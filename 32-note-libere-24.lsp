================

 NOTE LIBERE 24

================

Trigrammi

     =========          ===   ===           ===   ===           ===   ===
     =========          ===   ===           ===   ===           =========
     =========          ===   ===           =========           ===   ===
  乾 qián Cielo 天    坤 kūn  Terra 地    震 zhèn Tuono 雷    坎 kǎn  Acqua 水

     =========          =========           =========           ===   ===
     ===   ===          =========           ===   ===           =========
     ===   ===          ===   ===           =========           =========
  艮 gèn  Monte 山    巽 xùn  Vento 風    離 lí   Fuoco 火    兌 duì  Lago  泽

---------------------------------
Numeri sommati alle proprie cifre
---------------------------------

Dato un numero intero positivo N, definiamo "autosomma digitale" il numero:

  ASD(N) = N + somma(cifre di N)

Sequenza OEIS: A062028
a(n) = n + sum of the digits of n.
  0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 11, 13, 15, 17, 19, 21, 23, 25, 27,
  29, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 33, 35, 37, 39, 41, 43, 45,
  47, 49, 51, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 55, 57, 59, 61, 63,
  65, 67, 69, 71, 73, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 77, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (asd num) (+ num (digit-sum num)))

Proviamo:

(map asd (sequence 0 30))
;-> (0 2 4 6 8 10 12 14 16 18 11 13 15 17 19 21 23 25 27
;->  29 22 24 26 28 30 32 34 36 38 40 33)

Possiamo anche applicare ripetutamente la formula partendo da un numero N:

(define (repeat-asd num times) (collect (setq num (asd num)) times))

Proviamo:

(repeat-asd 480 10)
;-> (492 507 519 534 546 561 573 588 609 624)

(repeat-asd 480 10)

(repeat-asd 123 50)
;-> (129 141 147 159 174 186 201 204 210 213 219 231 237 249 264 276 291
;->  303 309 321 327 339 354 366 381 393 408 420 426 438 453 465 480 492
;->  507 519 534 546 561 573 588 609 624 636 651 663 678 699 723 735)

(intersect (repeat-asd 1 100) (repeat-asd 2 100))
;-> (4 8 16 23 28 38 49 62 70 77 91 101 103 107 115 122 127 137 148 161
;->  169 185 199 218 229 242 250 257 271 281 292 305 313 320 325 335 346
;->  359 376 392 406 416 427 440 448 464 478 497 517 530 538 554 568 587
;->  607 620 628 644 658 677 697 719 736 752 766 785 805 818 835 851 865
;->  884 904 917 934 950 964 983 1003 1007 1015 1022 1027 1037 1048 1061
;->  1069 1085 1099 1118 1129 1142 1150 1157 1171 1181 1192 1205 1213)


--------------------------------
Stima della popolazione mondiale
--------------------------------

Alla pagina web https://xkcd.com/1047/ viene proposto un metodo per calcolare la popolazione mondiale in funzione dell'anno.

I passi del metodo sono i seguenti:

1) Prendere le ultime due cifre dell'anno corrente.
2) Sottrarre il numero di anni bisestili (incluso l'anno corrente) dall'uragano Katrina (2005).
3) Per questo calcolo ogni anno divisibile per 4 è considerato bisestile.
4) Aggiungere un punto decimale tra i due numeri (equivale a dividere per 10).
5) Aggiungere 6. Questo restituisce il risultato in miliardi di persone.

Per gli anni precedenti al 2005 il numero di anni bisestili è negativo.

(define (leap? year) (zero? (% year 4)))

(define (world-pop year)
  (setq p (int (slice (string year) -2) 0 10))
  (if (> year 2004)
    (setq p (- p (length (filter leap? (sequence 2005 year)))))
    ;else
    (setq p (+ p (length (filter leap? (sequence year 2005))))))
  (setq p (div p 10))
  (setq p (add p 6)))

Proviamo:

(world-pop 2024)
;-> 7.9

(map (fn(x) (list x (world-pop x))) (sequence 2000 2030))
;-> ((2000 6.2) (2001 6.2) (2002 6.3) (2003 6.4) (2004 6.5) (2005 6.5)
;->  (2006 6.6) (2007 6.7) (2008 6.7) (2009 6.8) (2010 6.9) (2011 7)
;->  (2012 7)   (2013 7.1) (2014 7.2) (2015 7.3) (2016 7.3) (2017 7.4)
;->  (2018 7.5) (2019 7.6) (2020 7.6) (2021 7.7) (2022 7.8) (2023 7.9)
;->  (2024 7.9) (2025 8) (2026 8.1) (2027 8.199999999999999)
;->  (2028 8.199999999999999) (2029 8.300000000000001) (2030 8.4))

(world-pop 2050)
;-> 9.9


--------------------------------------
Frequenza delle cifre nei numeri primi
--------------------------------------

Dato un numero intero positivo N, determinare la frequenza delle cifre dei numeri primi da 1 a N compreso.

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

(define (prime-digit N)
  (local (primi cifre)
    (setq primi (primes-to N))
    (setq cifre (flat (map (fn(x) (explode (string x))) primi)))
    (count '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9") cifre))

Proviamo:

(prime-digit 1e5)
;-> (2725 6353 3906 6229 3772 3816 3741 6172 3690 6130)

Vediamo le percentuali delle cifre:

(define (perc-list lst)
  (let (somma (apply add lst))
    (map (fn(x) (mul (div x somma) 100)) lst)))

N = 1e5
(map (fn(x) (list $idx x)) (perc-list (prime-digit 1e5)))
;-> ((0 5.855933296084583)
;->  (1 13.65238320367903)
;->  (2 8.393862552112434)
;->  (3 13.38591137662784)
;->  (4 8.105901061589375)
;->  (5 8.200455580865604)
;->  (6 8.039283104826577)
;->  (7 13.26342029483818)
;->  (8 7.929685821120041)
;->  (9 13.17316370825633))

N = 1e6
(map (fn(x) (list $idx x)) (perc-list (prime-digit 1e6)))
;-> ((0 6.598256408026611)
;->  (1 12.96475857121117)
;->  (2 8.60316977194165)
;->  (3 12.7769202339283)
;->  (4 8.480118268582734)
;->  (5 8.459464747700936)
;->  (6 8.416635867556579)
;->  (7 12.68060960497424)
;->  (8 8.379024719003414)
;->  (9 12.64104180707438))

N = 1e7
(time (println (map (fn(x) (list $idx x)) (perc-list (prime-digit 1e7)))))
;-> ((0 7.104227319142836)
;->  (1 12.49649043942)
;->  (2 8.780772627158969)
;->  (3 12.37579004838755)
;->  (4 8.711688255897981)
;->  (5 8.679732350663677)
;->  (6 8.671074886625577)
;->  (7 12.28496338769417)
;->  (8 8.644269624553182)
;->  (9 12.25099106045606))
;-> 5688.478

N = 1e8
(time (println (map (fn(x) (list $idx x)) (perc-list (prime-digit 1e8)))))
;-> ((0 7.470598595490779)
;->  (1 12.15470533307439)
;->  (2 8.928205089181605)
;->  (3 12.07050800831849)
;->  (4 8.872339691088259)
;->  (5 8.857409460525487)
;->  (6 8.839704487748509)
;->  (7 12.00566550306154)
;->  (8 8.819204921660404)
;->  (9 11.98165890985055))
;-> 61818.008


-------------------------------------------------
Problema della brocca d'acqua (Water-Jug Problem)
-------------------------------------------------

Il problema della brocca d'acqua è un classico rompicapo che coinvolge due brocche (di capacità x e y litri) e una fonte d'acqua.
L'obiettivo è misurare 'z' litri d'acqua utilizzando le due brocche che non hanno contrassegni di volume.
Si tratta della ricerca nello spazio degli stati, in cui lo stato iniziale consiste nelle due brocche vuote e lo stato finale è quello in cui una brocca contiene 'z' litri.
Varie operazioni come il riempimento, lo svuotamento e il versamento tra le brocche vengono utilizzate per trovare una sequenza efficiente di passaggi per ottenere la quantità d'acqua desiderata.
In particolare le operazioni consentite sono:
a) Riempire la brocca A: riempire completamente la brocca A.
b) Riempire la brocca B: riempire completamente la brocca B.
c) Svuotare la brocca A: svuotare la brocca A.
d) Svuotare la brocca B: svuotare la brocca B.
e) Travasare da A a B: versare l'acqua dalla brocca A alla brocca B, a meno che non si ottenga una brocca A vuota o una brocca B piena.
f) Travasare da B ad A: Versare l'acqua dalla brocca B alla brocca A fino a quando la brocca B è vuota o la brocca A è piena.

Esistono diversi modi per risolvere questo problema (Breadth-First Search, Matematica, Programmazione Dinamica).

Vediamo l'algoritmo Breadth-First Search (BFS):

Iniziare con lo stato iniziale in cui entrambe le brocche sono vuote.
Creare una coda.
Aggiungere lo stato iniziale alla coda
Finchè la coda non è vuota:
  Estrarre lo stato dall'inizio dalla coda.
  Applicare tutte le possibili operazioni tra le due brocche per generare nuovi stati.
  Controllare se qualcuno di questi nuovi stati corrisponde allo stato obiettivo.
  Se viene trovato lo stato obiettivo, il problema è risolto.
  In caso contrario, aggiungere i nuovi stati alla coda per le successive esplorazioni.

(define (brocche x y z)
  (local (a b visitati coda out)
    (setq visitati '())
    (setq coda '((0 0)))
    ; finchè la coda non è vuota...
    (while (!= coda '())
      ; estrae il primo elemento (stato) della coda
      (map set '(a b) (pop coda))
            ; Controllo se è lo stato finale (obbiettivo)
      (cond ((or (= a z) (= b z) (= (+ a b) z)) (setq out true))
            ; Se l'elemento corrente è stato già visitato
            ; passiamo al prossimo elemento
            ((!= (find (list a b) visitati) nil) nil)
            ; Se l'elemento corrente non è stato già visitato
            ; generiamo tutte le opzioni (stati) possibili
            (true
              ; inserisce l'elemento corrente nella lista visitati
              (push (list a b) visitati)
              ; Genera tutti i possibili stati dallo stato corrente
              ; riempie la brocca A
              (if (< a x) (push (list x b) coda -1))
              ; riempie la brocca A
              (if (< b y) (push (list a y) coda -1))
              ; svuota la brocca A
              (if (> a 0) (push (list 0 b) coda -1))
              ; svuota la brocca B
              (if (> b 0) (push (list a 0) coda -1))
              ; travaso da A a B
              (if (>= (+ a b) y)
                (push (list (- a (- y b)) y) coda -1)
                ;else
                (push (list 0 (+ a b)) coda -1)
              )
              ; travaso da B a A
              (if (>= (+ a b) x)
                  (push (list x (- b (- x a))) coda -1)
                  ;else
                  (push (list (+ a b) 0) coda -1)
              ))
      )
      ;(println "V: " visitati)
      ;(println "C: " coda)
    )
    out))

Proviamo:

(brocche 4 3 2)
;-> true

(brocche 5 4 2)
;-> true

(brocche 8 6 3)
;-> nil

(brocche 3 5 4)
;-> true

Adesso vediamo un approccio matematico.

Il problema può essere rappresentato mediante l'equazione diofantea della forma ax + by = d che è risolvibile se e solo se mcd(a,b) divide d.
Inoltre, la soluzione x,y per la quale l'equazione è soddisfatta può essere trovata utilizzando l'algoritmo di Euclide esteso per il calcolo del MCD.
Naturalmente la soluzione non può esistere (fisicamente) se risulta:
  (d > a) and (d > b)
Vediamo un esempio: abbiamo una brocca A da 5 litri (a=5) e un'altra brocca B da 3 litri (b=3) e dobbiamo misurare 1 litro d'acqua.
L'equazione associata sarà 5x + 3y = 1.
Il problema può essere risolto poiché mcd(3,5) = 1 che divide 1.
Utilizzando l'algoritmo di Euclide esteso, otteniamo valori di x e y per i quali l'equazione è soddisfatta, che sono x = 2 e y = -3.
I valori n = 2 e m = -3 significano che dobbiamo riempire A due volte e svuotare B tre volte.

Se vogliamo trovare il numero minimo di operazioni da eseguire dobbiamo decidere quale brocca riempire per prima.
A seconda di quale brocca si sceglie da riempire e quale da svuotare abbiamo due soluzioni diverse e la minima tra queste sarà la soluzione.

Algoritmo 1 (Versare sempre dalla brocca da 'a' litri alla brocca da 'b' litri)
-----------
1) Riempire la brocca da m litro e svuotarla nella brocca da 'b' litri.
2) Ogni volta che la brocca da 'a' litri si svuota, riempirla.
3) Ogni volta che la brocca da 'b' litri si riempie, svuotarla.
4) Ripetere i passaggi 1,2,3 finché la brocca da 'b' litri o la brocca da 'a' litri non conterrà 'd' litri di acqua.
Ciascuno dei passaggi 1, 2 e 3 viene conteggiato come un'operazione da eseguire.
L'algoritmo 1 raggiunge il compito in K1 operazioni.

Algoritmo 2 (versare sempre dalla brocca da 'b' litri alla brocca da 'a' litri)
-----------
Riempire la brocca da 'b' litri e svuotarla nella brocca da 'a'.
Ogni volta che la brocca da 'b' litri si svuota, riempirla.
Ogni volta che la brocca da 'a' litri si riempie, svuotarla.
Ripetere i passaggi 1, 2 e 3 finché la brocca da 'b' litri o la brocca da 'a' litri non conterrà 'd' litri di acqua.
Ciascuno dei passaggi 1, 2 e 3 viene conteggiato come un'operazione da eseguire.
L'algoritmo 2 raggiunge il compito in K2 operazioni.

La soluzione finale sarà il minimo tra K1 e K2.

Funzione che calcola il numero e i passi necessari per avere 'd' litri in una brocca:

(define (travasi a b d)
  (local (from to step temp)
    (println a { } b { } d)
    ; inizializza la quantità di acqua nelle brocche origine e destinazione
    (setq from a)
    (setq to 0)
    (println (list from to))
    ; numero di travasi
    (setq step 1)
    ; stop se abbiamo trovato la soluzione
    (while (and (!= from d) (!= to d))
      ; quantità massima che può essere travasata
      (setq temp (min from (- b to)))
      # travasa 'temp' litri dalla brocca origine alla brocca destinazione
      (setq to (+ to temp))
      (setq from (- from temp))
      (println (list from to))
      (++ step)
      ; non fare nulla se abbiamo trovato la soluzione
      (cond ((or (= from d) (= to d)) nil)
            (true
              ; se la prima brocca si svuota, la riempie
              (when (zero? from) (setq from a) (++ step) (println (list from to)))
              ; se la seconda brocca si riempie, la svuota
              (when (= to b) (setq to 0) (++ step) (println (list from to))))
      )
    )
    step))

Proviamo:

(travasi 3 5 4)
;-> 3 5 4
;-> (3 0)
;-> (0 3)
;-> (3 3)
;-> (1 5)
;-> (1 0)
;-> (0 1)
;-> (3 1)
;-> (0 4)
;-> 8

(travasi 5 3 4)
;-> 5 3 4
;-> (5 0)
;-> (2 3)
;-> (2 0)
;-> (0 2)
;-> (5 2)
;-> (4 3)
;-> 6

Funzione che calcola il numero minimo e i passi necessari per avere 'd' litri in una brocca:

(define (travasi-min m n d)
  ; verifica che m < n
  (if (> m n) (swap m n))
  (cond
    ; verifica se la soluzione è fisicamente possibile
    ((> d n) nil)
    ; verifica se la soluzione è matematicamente possibile
    ((!= (% d (gcd n m)) 0) nil)
    (true
      (min (travasi m n d) (travasi n m d)))))

Proviamo:

(travasi-min 3 5 4)
;-> 3 5 4
;-> (3 0)
;-> (0 3)
;-> (3 3)
;-> (1 5)
;-> (1 0)
;-> (0 1)
;-> (3 1)
;-> (0 4)
;-> 5 3 4
;-> (5 0)
;-> (2 3)
;-> (2 0)
;-> (0 2)
;-> (5 2)
;-> (4 3)
;-> 6


---------------------
cmp(x, y) di python 2
---------------------

cmp(x, y)
Compare the two objects x and y and return an integer according to the outcome.
The return value is negative if x < y, zero if x = y and strictly positive if x > y.

Confronta i due oggetti x e y e restituisce un numero intero in base al risultato.
Il valore restituito è negativo se x < y, zero se x = y e strettamente positivo se x > y.

Scriviamo una funzione equivalente in newLISP.
In questo caso il valore restituito è -1 se x < y, 0 se x = y e +1 se x > y.

(define (cmp x y)
  (if (> x y) 1
      (= x y) 0
      (< x y) -1))

Proviamo:

Numeri interi:

(cmp 3 4)
;-> -1
(cmp 4 4)
;-> 0
(cmp 4 3)
;-> 1

Numeri float:

(cmp 3.2 4.1)
;-> -1
(cmp 4.1 4.1)
;-> 0
(cmp 4.1 3.2)
;-> 1

Stringhe:

(cmp "abc" "ab")
;-> 1
(cmp "abc" "abc")
;-> 0
(cmp "abc" "xyz")
;-> -1

Liste:

(cmp '(1 2 3) '(1 2 4))
;-> -1
(cmp '(1 2 3) '(1 2 3))
;-> 0
(cmp '(1 2 4) '(1 2 3))
;-> 1

Funzioni:

(cmp cmp cmp)
;-> 0
(cmp cmp map)
;-> 1
(cmp map cmp)
;-> -1
(cmp cmp apply)
;-> 1
(cmp apply cmp)
;-> -1

Vediamo un semplice esempio:

(define (confronta a b) (println a { } ('(= > <) (cmp a b)) { } b))

(confronta 10 11)
;-> 10 < 11

(confronta 3 3)
;-> 3 = 3

(confronta 2 1)
;-> 2 > 1


----------------------
Operazioni in sequenza
----------------------

Supponiamo di avere una lista di numeri e operatori aritmetici del tipo:

  (num0 op0 num1 op1 ... numN opN)

e vogliamo calcolare il valore ottenuto eseguendo 'linearmente' le operazioni da sinistra a destra.

Per esempio:

  Lista = (4 + 2 / 2 * 3)
  Calcolo = 4 + 2 = 6
            6 / 2 = 3
            3 * 3 = 9
  Risultato = 9

Il termine 'linearmente' significa che gli operatori si applicano direttamente ai termini che trovano a sinistra e a destra (di volta in volta).
Questo significa che non contano le normali precedenze algebriche degli operatori.

Per esempio:

  (4 + 6 / 2) --> 4 + 6 = 10 --> 10 / 2 = 5

Per semplicità, supponiamo che la lista sia formata correttamente (nessun controllo di errore).

Non abbiamo bisogno di costruire un mini-parser, basta leggere gli elementi della lista a due a due (prendendo il primo elemento come valore iniziale).

(define (linear-calc lst)
  (local (tot idx operator value)
    ; valore corrente
    (setq tot (lst 0))
    ; indice della lista
    (setq idx 1)
    ; ciclo di lettura della lista
    (while (< idx (length lst))
      ; legge l'operatore
      (setq operator (lst idx))
      ; legge il valore
      (setq value (lst (+ idx 1)))
      (print tot { } operator { } value " = " )
      ; effettua l'operazione corrente
      (setq tot ((eval operator) tot value))
      (println tot)
      ; sposta l'indice sul prossimo operatore
      (++ idx 2)
   ) tot))

Proviamo:

(setq a '(4 + 2 / 2 * 3))
(linear-calc a)
;-> 4 + 2 = 6
;-> 6 / 2 = 3
;-> 3 * 3 = 9
;-> 9

(setq b '(4.2 add 2 div 2.1 mul 3))
(linear-calc b)
;-> 4.2 add 2 = 6.2
;-> 6.2 div 2.1 = 2.952380952380953
;-> 2.952380952380953 mul 3 = 8.857142857142858
;-> 8.857142857142858


------------------------------
Cifre delle pagine di un libro
------------------------------

Dato un libro con un numero di pagine P, determinare le occorrenze di ogni cifra (0..9) necessarie per numerare le pagine da 1 a P.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (cifre-pagine P)
  (count '(0 1 2 3 4 5 6 7 8 9) (flat (map int-list (sequence 1 P)))))

Proviamo:

(cifre-pagine 100)
;-> (11 21 20 20 20 20 20 20 20 20)

(cifre-pagine 1000)
;-> (192 301 300 300 300 300 300 300 300 300)

(cifre-pagine 999)
;-> (189 300 300 300 300 300 300 300 300 300)

Quante cifre occorrono per un libro di P pagine?

Sequenza OEIS: A058183
Number of digits in concatenation of first n positive integers.
Or, total number of digits in numbers from 1 through n.
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31,
  33, 35, 37, 39, 41, 43, 45, 47, 49, 51, 53, 55, 57, 59, 61, 63, 65, 67,
  69, 71, 73, 75, 77, 79, 81, 83, 85, 87, 89, 91, 93, 95, 97, 99, 101, 103,
  105, 107, 109, 111, 113, 115, 117, 119, ...

(define (numero-cifre P) (apply + (cifre-pagine P)))

Proviamo:

(map numero-cifre (sequence 1 50))
;-> (1 2 3 4 5 6 7 8 9 11 13 15 17 19 21 23 25 27 29 31 33 35 37 39 41 43 45
;->  47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83 85 87 89 91)

(numero-cifre 1000)
;-> 2893

(numero-cifre 250)
;-> 642

Rapporto numero-pagine/numero-cifre:

(map (fn(x) (div x (+ $idx 1))) (map numero-cifre (sequence 1 50)))
;-> (1 1 1 1 1 1 1 1 1 1.1 1.181818181818182 1.25 1.307692307692308
;->  1.357142857142857 1.4 1.4375 1.470588235294118 1.5 1.526315789473684
;->  1.55 1.571428571428571 1.590909090909091 1.608695652173913
;->  1.625 1.64 1.653846153846154 1.666666666666667 1.678571428571429
;->  1.689655172413793 1.7 1.709677419354839 1.71875 1.727272727272727
;->  1.735294117647059 1.742857142857143 1.75 1.756756756756757
;->  1.763157894736842 1.769230769230769 1.775 1.780487804878049
;->  1.785714285714286 1.790697674418605 1.795454545454545 1.8
;->  1.804347826086957 1.808510638297872 1.8125 1.816326530612245
;->  1.82)


------------------------------------
Codifica e decodifica di una stringa
------------------------------------

Vogliamo inviare un messaggio segreto.
Inventare un metodo personale per codificare e decodificare una stringa.
La stringa è composta solo da caratteri ASCII.

Algoritmo di codifica
---------------------
1) Per ogni carattere della stringa:
     calcolare il valore in base 3 del suo codice ASCII (format "%05d")
2) Unire tutti i valori in una stringa unica
3) Aggiungere in modo casuale un numero casuale di cifre (3..9) alla stringa
4) Invertire la stringa
5) Restituire la stringa (codificata)

Vediamo un esempio:

stringa = "newLISP"
caratteri = "n" "e" "w" "L" "I" "S" "P"
base3 = "11002" "10202" "11102" "02211" "02201" "10002" "02222"
stringa = "11002102021110202211022011000202222"
stringa+(3..9) = "71555336108023130892980237319795154137476554303420224518
                  567677618402929703648119793084699673068906889520462982242"
codifica = "2422892640259886098603769964803979118463079292048167767658154
            2202430345567473145159791373208929803132080163355517"

Chiarimenti:
Formattiamo il numero in base 3 con 5 caratteri (0-pad) perchè al massimo i valori hanno 5 cifre.
Il procedimento di inserire nella stringa unita un numero casuale di tutte le cifre che vanno da 3 a 9 serve per mascherare il messaggio.
Ma quante volte inseriamo la cifra 3? e quante volte la cifra 4? ... e quante volte la cifra 9?
Prendiamo il valore minimo e il valore massimo delle occorrenze di 0, 1 e 2 nella stringa unica.
Poi, per ogni cifra da 3 a 9, la inseriamo nella stringa un numero casuale di volte che va dal valore minimo al valore massimo.

Algoritmo di decodifica
-----------------------
1) Invertire la stringa
2) togliere tutti i caratteri "3", "4", ..., "9".
3) Per ogni blocco di 5 caratteri della stringa:
    convertire il blocco in carattere
    aggiungere il carattere al messaggio
4) restituire il messaggio

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (+ min-val (rand (+ (- max-val min-val) 1))))

(define (clean-str chars str)
"Clean chars from a string"
  (join (difference (explode str) (explode chars) true)))

(define (filter-str chars str)
"Filter chars from a string"
  (join (intersect (explode str) (explode chars) true)))

Funzione di codifica della stringa:

(define (encode str)
  (local (base chars nums n012 vmin vmax len)
    (setq base 3)
    (setq chars (explode str))
    (setq nums "")
    ; creazione stringa unica
    (dolist (ch chars)
      (extend nums (format "%05d" (b1-b2 (char ch) 10 base)))
    )
    ; conta le occorrenze di 0, 1 e 2
    (setq n012 (count '("0" "1" "2") (explode nums)))
    ; calcola valore massimo e minimo
    (setq vmax (apply max n012))
    (setq vmin (apply min n012))
    (setq len (length nums))
    ; inserisce ogni cifra da 3 a 9 un numero casuale di volte
    (for (digit 3 9)
      (for (i 1 (rand-range vmin vmax))
        (push (string digit) nums (rand len))
        (++ len)
      )
    )
    (reverse nums)))

Proviamo:

(encode "newLISP")
;-> "23522202388064788797839039458037814194697058664220418317
;->  6622839077204976611123660545720534915203084679359715159"

Funzione di decodifica della stringa:

(define (decode str)
  (let (msg "")
    (reverse str)
    (setq str (clean-str "3456789" str))
    (dolist (el (explode str 5))
      (extend msg (char (b1-b2 (int el 0 10) 3 10))))))

Proviamo:

(decode (encode "newLISP"))
;-> "newLISP"

(decode (encode "--- HeLlO WoRlD ---"))
;-> "--- HeLlO WoRlD ---"


--------------------------
Generare un grafo regolare
--------------------------

Dati due interi positivi n,k con n>k>=1, generare una matrice binaria nxn tale che ogni riga e colonna contenga esattamente k '1' e la diagonale principale ha tutti i valori a 0.
Questa è la matrice di adiacenza di un grafo regolare.

Soluzione originale in python 2 (Jonathan Allan):

  lambda n,k:[(i/n+~i)%n<k for i in range(n*n)]

Conversione della soluzione in newLISP:

Nota: ~x = (- (x + 1))
L'operatore "~" è il complemento bit a bit, che inverte tutti i bit di un numero intero.
Quindi, ~x fornisce effettivamente la negazione bit a bit di 'x'.
Nella rappresentazione in complemento a due, che newLISP utilizza per gli interi, la negazione bit a bit di un intero 'x' è equivalente a (-x - 1) = -(x + 1).

Funzione / di python2:

(define (pydiv a b)
  (cond ((or (and (> a 0) (> b 0)) (and (< a 0) (< b 0))) (/ a b))
        ((zero? (% a b)) (/ a b))
        (true (- (/ a b) 1))))

Funzione mod di python 2:

(define (pymod a b) (% (+ (% a b) b) b))

Funzione che stampa una matrice binaria:

(define (print-matrix matrix)
  (local (row col)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (matrix i j) { })
      )
      (println))))

Funzione che crea una matrice di adiacenza di un grafo regolare:

(define (regular-graph n k)
  (setq out '())
  (for (i 0 (- (* n n) 1))
    ; this do not work...
    ; (setq v (% (+ (/ i n) (~ i)) n))
    (setq v (pymod (+ (pydiv i n) (~ i)) n))
    (if (< v k)
      (push 1 out -1)
      (push 0 out -1)
    )
  )
  (print-matrix (array-list (array n n out))))

Proviamo:

(regular-graph 2 1)
;-> 0 1
;-> 1 0

(regular-graph 3 2)
;-> 0 1 1
;-> 1 0 1
;-> 1 1 0

(regular-graph 5 3)
;-> 0 0 1 1 1
;-> 1 0 0 1 1
;-> 1 1 0 0 1
;-> 1 1 1 0 0
;-> 0 1 1 1 0

(regular-graph 6 2)
;-> 0 0 0 0 1 1
;-> 1 0 0 0 0 1
;-> 1 1 0 0 0 0
;-> 0 1 1 0 0 0
;-> 0 0 1 1 0 0
;-> 0 0 0 1 1 0


---------------------
Sequenza Sleter-Velez
---------------------

La sequenza Sleter-Velez viene costruta con le seguenti regole:
  a(1) = 1,
  Il numero successivo a(n) sarà il numero più piccolo che:
  1) non è già apparso nella sequenza
  2) la sua differenza assoluta dal numero che lo precede non è uguale a qualsiasi differenza assoluta precedente tra elementi consecutivi.

Vediamo la costruzione dei primi termini della sequenza:

Il primo termine è 1 poiché è il più piccolo intero positivo.
Dopodiché viene 2,
   Sequenza: (1 2)
   Differenze: (1)

3 è il numero più piccolo successivo, ma la differenza da 2 è uguale alla differenza tra
1 e 2, quindi 4 è il termine successivo.

  Sequenza: (1 2 4)
  Differenze: (1 2)

Ora si può aggiungere 3, poiché la sua differenza da 7 è 4 che non esiste nella lista delle diferenze.

   Sequenza: (1 2 4 7 3)
   Differenze: (1 2 3 4)

Poiché le differenze arrivano fino a 4, sappiamo che la successiva differenza è almeno 5, quindi il numero successivo è almeno 8.
8 non è apparso, quindi possiamo aggiungerlo.

   Sequenza: (1 2 4 7 3 8)
   Differenze: (1 2 3 4 5)

Sequenza OEIS: A081145
a(1)=1, thereafter, a(n) is the least positive integer which has not already occurred and is such that |a(n)-a(n-1)| is different from any |a(k)-a(k-1)| which has already occurred.
  1, 2, 4, 7, 3, 8, 14, 5, 12, 20, 6, 16, 27, 9, 21, 34, 10, 25, 41, 11,
  28, 47, 13, 33, 54, 15, 37, 60, 17, 42, 68, 18, 45, 73, 19, 48, 79, 22,
  55, 23, 58, 94, 24, 61, 99, 26, 66, 107, 29, 71, 115, 30, 75, 121, 31,
  78, 126, 32, 81, 132, 35, 87, 140, 36, 91, 147, 38, 96, 155, 39, ...

La spiegazione dell'algoritmo si trova nei commenti della funzione.

(define (slater num)
  (local (nums seq diff continua found cur-diff)
  ; Per avere x numeri nella sequenza abbiamo bisogno
  ; di una lista di numeri da 2 a 2.5*x (approssimazione per eccesso).
  ; lista di numeri da 2 a (2.5*num)
  (setq nums (sequence 2 (int (mul num 2.5))))
  ; lista della sequenza
  (setq seq '(1))
  ; lista delle differenze
  (setq diff '())
  ; trovato un numero da inserire in un ciclo completo di nums?
  (setq continua true)
  ; finchè ci sono numeri in nums e non abbiamo effettuato un ciclo a vuoto...
  (while (and nums continua)
    ; flag per segnalare che abbiamo trovato un numero da inserire
    (setq found nil)
    (dolist (el nums found)
      ; calcola la differenza corrente
      (setq cur-diff (abs (- el (seq -1))))
      ; quando il numero non compare nella sequenza e
      ; la differenza corrente non compare nelle differenze...
      (when (and (not (find el seq))
                (not (find cur-diff diff)))
        ; inseriamo il numero nella sequenza
        (push el seq -1)
        ; inseriamo la differenza corrente nelle differenze
        (push cur-diff diff -1)
        ; segnaliamo che abbiamo trovato e inserito un numero da nums a seq
        (setq found true)
      )
    )
    ; se usciamo dal ciclo di nums senza aver inserito alcun numero,
    ; allora abbiamo terminato il calcolo della sequenza
    ; (perchè nessun numero rimasto può essere inserito)
    (if (= found nil) (setq continua nil))
    ; quando abbiamo trovato un numero da inserire nella sequenza
    ; dobbiamo rimuoverlo da nums
    (when found
      ; rimuove il numero inserito nella sequenza da nums
      (pop nums (find (seq -1) nums))
      ; azzeramento del flag per una nuova ricerca
      (setq found nil)
    )
  )
  ; poichè abbiamo calcolato un numero di elementi leggermente maggiore
  ; di quello stabilito dal parametro num, allora operiamo uno slice.
  (slice seq 0 num)))

Proviamo:

(slater 70)
;-> (1 2 4 7 3 8 14 5 12 20 6 16 27 9 21 34 10 25 41 11
;->  28 47 13 33 54 15 37 60 17 42 68 18 45 73 19 48 79 22
;->  55 23 58 94 24 61 99 26 66 107 29 71 115 30 75 121 31
;->  78 126 32 81 132 35 87 140 36 91 147 38 96 155 39)

(time (println (slater 1000)))
;-> (1 2 4 7 3 8 14 5 12 20 6 16 27 9 21 34 10 25 41 11 28 47 13 33 54
;->  15 37 60 17 42 68 18 45 73 19 48 79 22 55 23 58 94 24 61 99 26 66
;->  ...
;->  541 1359 2179 543 1364 2186 544 1367 2191 545 1370 2196 546 1373
;->  2201 548 1377 2208 549 1381 2214 552 1386 2221 553 1389 2226 555)
;-> 2239.297

(length (slater 1000))
;-> 1000

(time (slater 2000))
;-> 17157.765

Per velocizzare la funzione si potrebbero usare le hash-map (dizionari) al posto delle liste.


----------------------------
Operatori binari di INTERCAL
----------------------------

Il Compiler Language With No Pronounceable Acronym, abbreviato INTERCAL, è un linguaggio di programmazione unico creato da Don Woods e James M. Lyon, due studenti dell'Università di Princeton, nel 1972.
Lo scopo principale del linguaggio era quello di discostarsi il più possibile da tutti i linguaggi esistenti (e ci sono riusciti).

I due operatori binari di INTERCAL sono 'interleave' (noto anche come 'mingle') e 'select'.

L'interleave è rappresentato dal carattere "¢" e la 'select' dal carattere "~".

L'operatore 'interleave' accetta due valori a 16 bit e produce un risultato a 32 bit alternando i bit degli operandi.

Per esempio:

  234 ¢ 4321
  234    = 0000011101010
  4321   = 1000011100001
  Result = 01000000001111110010001001
  Output = 16841865

L'operatore 'select' prende dal primo operando i bit che corrispondono a 1 nel secondo operando e li unisce a destra nel risultato.
Entrambi gli operandi vengono automaticamente riempiti a sinistra con zero fino a 32 bit prima che avvenga la selezione, quindi i tipi di variabile non hanno restrizioni.
Se vengono selezionati più di 16 bit, il risultato è un valore a 32 bit, altrimenti è un valore a 16 bit.

Per esempio:

  2345 ~ 7245
  2345 =   0100100101001
  7245 =   1110001001101
  Take =   010   0  10 1
  Pack =   0100101
  Output = 37

1) Funzione "interleave" (mingle)

(define (mingle num1 num2)
  (local (b1 b2)
    (setq b1 (explode (format "%016s" (bits num1))))
    (setq b2 (explode (format "%016s" (bits num2))))
    ;(println a "\n" b)
    (int (join (flat (map list b1 b2))) 0 2)))

Proviamo:

(mingle 234 4321)
;-> ("0" "0" "0" "0" "0" "0" "0" "0" "1" "1" "1" "0" "1" "0" "1" "0")
;-> ("0" "0" "0" "1" "0" "0" "0" "0" "1" "1" "1" "0" "0" "0" "0" "1")
;-> 16841865

(mingle 5 6)
;-> 54

(mingle 51234 60003)
;-> 4106492941

2) Funzione "select" (selector)

(define (selector num1 num2)
  (local (b1 b2)
    (setq b1 (explode (format "%032s" (bits num1))))
    (setq b2 (explode (format "%032s" (bits num2))))
    ;(println b1 "\n" b2)
    (int (join (select b1 (flat (ref-all "1" b2)))) 0 2)))

Proviamo:

(selector 2345 7245)
;-> ("0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
;->  "0" "0" "0" "1" "0" "0" "1" "0" "0" "1" "0" "1" "0" "0" "1")
;-> ("0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0" "0"
;->  "0" "0" "1" "1" "1" "0" "0" "0" "1" "0" "0" "1" "1" "0" "1")
;-> 37

(selector 5 6)
;-> 2

(selector 51234 60003)
;-> 422

Adesso scriviamo due funzioni che permettono ai due operatori, (interleave e select), di utilizzare i big-integer.

(define (string-int str)
"Convert a numeric string to big-integer"
  (let (num 0L)
    (cond ((= (str 0) "-")
            (pop str)
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))
            (* num -1))
          (true
            (dolist (el (explode str)) (setq num (+ (* num 10) (int el))))))))

(define (bits-i num)
"Convert a decimal integer (big integer) to binary string"
  (setq max-int (pow 2 62)) ; put this outside when doing a lot of calls
  (define (prep s) (string (dup "0" (- 62 (length s))) s))
  (if (<= num max-int) (bits (int num))
      (string (bits-i (/ num max-int))
              (prep (bits (int (% num max-int)))))))

(define (binary-bigint bin)
"Convert a binary string to big integer"
  (let (num 0L)
    ; remove left padded 0
    (while (= (bin 0) "0") (pop bin))
    (if (= bin "") 0L
        ; else, build big integer number
        (dolist (el (explode bin))
          (setq num (+ (* num 2) (int el)))))))

1) Funzione "interleave" (mingle) per big-integer:

(define (mingle-big num1 num2)
  (local (b1 b2 len1 len2 fmt)
    (setq len1 (length (setq b1 (bits-i num1))))
    (setq len2 (length (setq b2 (bits-i num2))))
    (setq fmt (string "%0" (max len1 len2) "s"))
    (setq b1 (explode (format fmt b1)))
    (setq b2 (explode (format fmt b2)))
    (println b1 "\n" b2)
    (binary-bigint (join (flat (map list b1 b2))))))

Proviamo:

(mingle-big 1234567890 1234567890)
;-> ("1" "0" "0" "1" "0" "0" "1" "1" "0" "0" "1" "0" "1" "1" "0" "0" "0"
;->  "0" "0" "0" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> ("1" "0" "0" "1" "0" "0" "1" "1" "0" "0" "1" "0" "1" "1" "0" "0" "0"
;->  "0" "0" "0" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> 3513866796745421580L

(mingle-big 12345678901234567890 12345678900987654321)
;-> ("1" "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "1" "0" "1" "0" "0" "1"
;->  "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1"
;->  "1" "0" "1" "0" "1" "1" "0" "0" "0" "1" "1" "1" "1" "1" "0" "0" "0"
;->  "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> ("1" "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "1" "0" "1" "0" "0" "1"
;->  "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1"
;->  "0" "1" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1" "1" "0" "1" "1"
;->  "1" "0" "0" "0" "0" "1" "0" "1" "1" "0" "0" "0" "1")
;-> 272238354859052727989328541678683350793L

(mingle-big 234 4321)
;-> ("0" "0" "0" "0" "0" "0" "0" "0" "1" "1" "1" "0" "1" "0" "1" "0")
;-> ("0" "0" "0" "1" "0" "0" "0" "0" "1" "1" "1" "0" "0" "0" "0" "1")
;-> 16841865L

(mingle-big 5 6)
;-> ("1" "0" "1")
;-> ("1" "1" "0")
;-> 54L

(mingle-big 51234 60003)
;-> ("1" "1" "0" "0" "1" "0" "0" "0" "0" "0" "1" "0" "0" "0" "1" "0")
;-> ("1" "1" "1" "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1")
;-> 4106492941L

2) Funzione "select" (selector) per big integer:

(define (selector-big num1 num2)
  (local (b1 b2 len1 len2 fmt)
    (setq len1 (length (setq b1 (bits-i num1))))
    (setq len2 (length (setq b2 (bits-i num2))))
    (setq fmt (string "%0" (max len1 len2) "s"))
    (setq b1 (explode (format fmt b1)))
    (setq b2 (explode (format fmt b2)))
    (println b1 "\n" b2)
    (binary-bigint (join (select b1 (flat (ref-all "1" b2)))) 0 2)))

Proviamo:

(selector-big 1234567890 1234567890)
;-> ("1" "0" "0" "1" "0" "0" "1" "1" "0" "0" "1" "0" "1" "1" "0" "0" "0"
;->  "0" "0" "0" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> ("1" "0" "0" "1" "0" "0" "1" "1" "0" "0" "1" "0" "1" "1" "0" "0" "0"
;->  "0" "0" "0" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> 3513866796745421580L

(selector-big 12345678901234567890 12345678900987654321)
;-> ("1" "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "1" "0" "1" "0" "0" "1"
;->  "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1"
;->  "1" "0" "1" "0" "1" "1" "0" "0" "0" "1" "1" "1" "1" "1" "0" "0" "0"
;->  "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "0" "1" "0")
;-> ("1" "0" "1" "0" "1" "0" "1" "1" "0" "1" "0" "1" "0" "1" "0" "0" "1"
;->  "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1"
;->  "0" "1" "1" "1" "0" "0" "0" "1" "1" "0" "0" "1" "1" "1" "0" "1" "1"
;->  "1" "0" "0" "0" "0" "1" "0" "1" "1" "0" "0" "0" "1")
;-> 4294943626L

(selector-big 2345 7245)
;-> ("0" "1" "0" "0" "1" "0" "0" "1" "0" "1" "0" "0" "1")
;-> ("1" "1" "1" "0" "0" "0" "1" "0" "0" "1" "1" "0" "1")
;-> 37L

(selector-big 5 6)
;-> ("1" "0" "1")
;-> ("1" "1" "0")
;-> 2L

(selector-big 51234 60003)
;-> ("1" "1" "0" "0" "1" "0" "0" "0" "0" "0" "1" "0" "0" "0" "1" "0")
;-> ("1" "1" "1" "0" "1" "0" "1" "0" "0" "1" "1" "0" "0" "0" "1" "1")
;-> 422L


-----------------
Stringhe perfette
-----------------

Una parola perfetta, è una parola in cui la somma della posizione nell'alfabeto di ciascuna lettera della parola è perfettamente divisibile per la lunghezza totale della parola.
Ad esempio, "abcabc" è una parola perfetta perché 1 + 2 + 3 + 1 + 2 + 3 = 12 e 12 / 6 = 2.

Scrivere la funzione più breve possibile per verificare se una parola è perfetta.
La parola è costituita solo da lettere minuscole (a..z).

Prima versione:

(char "a")
;-> 97

(define (perfect? str)
  (let (somma 0)
    (dostring (ch str) (setq somma (+ somma (- ch 96))))
    (zero? (% somma (length str)))))

Proviamo:

(perfect? "abcabc")
;-> true
(perfect? "newlisp")
;-> true
(perfect? "python")
;-> nil
(perfect? "julia")
;-> nil

Seconda versione:

(define (perfect? str)
  (let (somma 0)
    (setq somma (apply + (map (fn(x) (- (char x) 96)) (explode str))))
    (zero? (% somma (length str)))))

Terza versione:

(define (perfect? s)
  (zero? (% (apply + (map (fn(x) (- (char x) 96)) (explode s))) (length s))))

Quarta versione:

Se poniamo "a" = 1, "b" = 2, ecc. oppure "a" = 97, "b" = 98, ecc. il risultato della divisione non cambia.

(define (perfect? s)
  (zero? (% (apply + (map char (explode s))) (length s))))

Quinta versione (63 caratteri):

(define(p s)(zero?(%(apply +(map char(explode s)))(length s))))

Proviamo:

(p "abcabc")
;-> true
(p "newlisp")
;-> true
(p "python")
;-> nil
(p "julia")
;-> nil


--------------------------------------------
Interlacciare gli elementi di N liste (args)
--------------------------------------------

Abbiamo due liste e vogliamo creare una lista con elementi che hanno lo stesso indice.

Per esempio:
  L1 = (1 2 3)
  L2 = (4 5 6)
  Output = ((1 4) (2 5) (3 6))

Per fare questo possiamo usare le funzioni "map" e "list":

(map list '(1 2 3) '(4 5 6))
;-> ((1 4) (2 5) (3 6))

Questa espressione funziona anche con più liste:

(map list '(1 2 3) '(4 5 6) '(7 8 9))
;-> ((1 4 7) (2 5 8) (3 6 9))

Scriviamo una funzione per interlacciare due liste:

(define (interleave lst1 lst2) (map list lst1 lst2))

(interleave '(1 2 3) '(4 5 6))
;-> ((1 4) (2 5) (3 6))

Per utilizzare "interleave" con più di due liste dobbiamo utilizzare (args).

Non possiamo utilizzare direttamente il valore di (args):

(define (interleave) (map list (args)))

(interleave '(1 2 3) '(4 5 6) '(7 8 9))
;-> (((1 2 3)) ((4 5 6)) ((7 8 9)))

non otteniamo il risultato voluto perchè (args) vale (L1 L2 L3) e non L1 L2 L3.

Allora dobbiamo usare la funzione "apply" e la funzione "cons":

(define (interleave) (apply map (cons list (args))))

(interleave '(1 2 3) '(4 5 6) '(7 8 9))
;-> ((1 4 7) (2 5 8) (3 6 9))

Analizziamo come si comporta la funzione:

1) (args) cattura tutti gli argomenti passati alla funzione.
2) (cons list (args)) crea una lista in cui il primo elemento è la funzione "list" e il resto sono gli argomenti catturati.
3) apply viene utilizzato per applicare la funzione map agli argomenti raccolti.

(set 'L1 '(1 2 3))
(set 'L2 '(4 5 6))
(set 'L3 '(7 8 9))

(interleave L1 L2 L3)
;-> ((1 4 7) (2 5 8) (3 6 9))

Se le liste non hanno lo stesso numero di elementi, allora qualche sottolista ha un numero minore di elementi:

(set 'L4 '(10 11))

(interleave L1 L2 L3 L4)
;-> ((1 4 7 10) (2 5 8 11) (3 6 9))

(interleave '(1 2 3) '(4 5) '(6))
;-> ((1 4 6) (2 5) (3))

(interleave '(6) '(4 5) '(1 2 3))
;-> ((6 4 1))

(interleave '(4 5) '(1 2 3) '(6))
;-> ((4 1 6) (5 2))

(interleave '(4 5) '(6) '(1 2 3))
;-> ((4 6 1) (5))

La funzione "interleave" è simile alla funzione "zip":

(define (zip)
"Transpose multiple lists into one"
  (transpose (args)))

(zip '(1 2 3) '(4 5 6) '(7 8 9))
;-> ((1 4 7) (2 5 8) (3 6 9))

(interleave '(1 2 3) '(4 5 6) '(7 8 9))
;-> ;-> ((1 4 7) (2 5 8) (3 6 9))

Le due funzioni si comportano diversamente quando le liste hanno un numero di elementi diverso:

(zip '(1 2 3) '(4 5 6) '(7 8))
;-> ((1 4 7) (2 5 8) (3 6 nil))

(interleave '(1 2 3) '(4 5 6) '(7 8))
;-> ((1 4 7) (2 5 8) (3 6))

La funzione "zip" usa sempre 'nil' per gli argomenti mancanti:
(zip L1 L2 L3 L4)
;-> ((1 4 7 10) (2 5 8 11) (3 6 9 nil))

Comunque il numero di elementi della lista risultante è sempre uguale al numero di elementi della prima lista passata:

(zip '(1 2 3) '(4 5) '(6))
;-> ((1 4 6) (2 5 nil) (3 nil nil))

(zip '(6) '(4 5) '(1 2 3))
;-> ((6 4 1))

(zip '(4 5) '(1 2 3) '(6))
;-> ((4 1 6) (5 2 nil))

(zip '(4 5) '(6) '(1 2 3))
;-> ((4 6 1) (5 nil 2))

Se abbiamo come parametro una lista di N liste (invece che N liste) allora possiamo usare "apply":

(apply zip '((1 2 3) (4 5 6) (7 8)))
;-> ((1 4 7) (2 5 8) (3 6 nil))

(apply interleave '((1 2 3) (4 5 6) (7 8)))
;-> ((1 4 7) (2 5 8) (3 6))

Nota: la funzione "zip" usa (args) direttamente perchè "transpose" accetta una lista di liste.

Vedi anche "Interlacciamento di stringhe e liste" su "Note libere 19".


------------------------------------
La costante di Champernowne (Mahler)
------------------------------------

La costante di Champernowne (o costante di Mahler) C10 è una costante reale trascendente, presentata in un articolo del 1933 dal matematico David Gawen Champernowne.

In base 10, il numero è definito concatenando i numeri naturali nel modo seguente:

  C10 = 0.12345678910111213141516...

Anche per ogni altra base si può costruire una costante in modo analogo:

Base 2: C2 = 0.11011100101110111...

Base 3: C3 = 0.12101112202122...

Sequenza OEIS: A033307
Decimal expansion of Champernowne constant (or Mahler's number), formed by concatenating the positive integers.
  1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 0, 1, 1, 1, 2, 1, 3, 1, 4, 1, 5, 1, 6,
  1, 7, 1, 8, 1, 9, 2, 0, 2, 1, 2, 2, 2, 3, 2, 4, 2, 5, 2, 6, 2, 7, 2, 8,
  2, 9, 3, 0, 3, 1, 3, 2, 3, 3, 3, 4, 3, 5, 3, 6, 3, 7, 3, 8, 3, 9, 4, 0,
  4, 1, 4, 2, 4, 3, 4, 4, 4, 5, 4, 6, 4, 7, 4, 8, 4, 9, 5, 0, 5, 1, 5, 2,
  5, 3, 5, 4, 5, 5, 5, 6, 5, 7, 5, 8, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (A033307 limit)
  (let (out '())
    (for (i 1 limit) (extend out (int-list i)))))

(A033307 58)
;-> (1 2 3 4 5 6 7 8 9 1 0 1 1 1 2 1 3 1 4 1 5 1 6
;->  1 7 1 8 1 9 2 0 2 1 2 2 2 3 2 4 2 5 2 6 2 7 2 8
;->  2 9 3 0 3 1 3 2 3 3 3 4 3 5 3 6 3 7 3 8 3 9 4 0
;->  4 1 4 2 4 3 4 4 4 5 4 6 4 7 4 8 4 9 5 0 5 1 5 2
;->  5 3 5 4 5 5 5 6 5 7 5 8)

Funzione che genera la costante di Champernowne (base10) fino ad un dato numero:

(define (c10 limit)
  (let (out '())
    (for (i 1 limit) (extend out (map string (int-list i))))
    (append "0." (join out))))

Proviamo:

(c10 20)
;-> "0.1234567891011121314151617181920"

Adesso vediamo la funzione per creare la costante in base N (N <= 62).

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

(base10-baseN 10 3)

Funzione che genera la costante di Champernowne (base N) fino ad un dato numero:

(define (cn base limit)
  (let (out "")
    (for (i 1 limit) (extend out (base10-baseN i base)))
    (println out)
    (append "0." out)))

Proviamo:

(cn 2 10)
"0.11011100101110111100010011010"

(cn 3 10)
"0.12101112202122100101"

(cn 22 42)
"0.123456789ABCDEFGHIJKL101112131415161718191A1B1C1D1E1F1G1H1I1J1K"


------------------------
Bussola e Rosa dei Venti
------------------------

I punti della bussola sono un insieme di direzioni cardinali orizzontali (o azimut) disposte radialmente utilizzate nella navigazione e nella cartografia.
Una rosa dei venti è composta principalmente da quattro direzioni cardinali: nord, est, sud e ovest, ciascuna separata da 90 gradi e secondariamente divisa da quattro direzioni ordinali (intercardinali): nord-est, sud-est, sud-ovest e nord-ovest, ciascuna situata a metà strada tra due direzioni cardinali.
Alcune discipline come la meteorologia e la navigazione dividono ulteriormente la bussola con azimut aggiuntivi.
Nella tradizione europea, una bussola completamente definita ha 32 "punti".

Ciascuna direzione è 11.25 (360/32) gradi più lontana della precedente.
Ad esempio, N (nord) è 0 gradi, NbE (nord-est) è 11,25 gradi, NNE (nord-nordest) è 22,5 gradi, ecc.

Nel dettaglio i nomi sono così assegnati:
- 0 gradi è N, 90 gradi è E, 180 gradi è S e 270 gradi è W. Queste sono chiamate direzioni cardinali.
- I punti a metà strada tra le direzioni cardinali sono semplicemente le direzioni cardinali tra loro concatenate. N o S vanno sempre per primi e W o E sono sempre secondi. Queste sono chiamate direzioni ordinali. Le direzioni ordinale e cardinale insieme formano i venti principali.
- I punti intermedi tra i venti principali sono le direzioni tra cui sono concatenati. Le direzioni cardinali vanno per prime, quelle ordinali per seconda. Questi sono chiamati mezzi venti.
- I punti a metà strada tra i venti principali e quelli mezzi sono i venti principali adiacenti "per" la direzione cardinale più vicina lontano dal vento principale.
Questo è indicato con una b. Questi sono chiamati venti quarti.

I nomi "tradizionali" degli otto venti principali sono:

  (N)  – Tramontana
  (NE) – Greco (o Grecale o Bora in veneziano)
  (E)  – Levante (o Oriente)
  (SE) – Scirocco (o Exaloc in catalano)
  (S)  – Ostro (o Mezzogiorno in veneziano)
  (SW) – Libeccio (o Garbino, Eissalot in provenzale)
  (W)  – Ponente (o Zefiro in greco)
  (NW) – Maestro (o Mistral in provenzale)

Vedi immagini "Bussola32.png" e "RosaVenti.jpg" (wikipedia) nella cartella "data".

  #   Gradi    Codice  Nome                 Vento
  1   0        N       North                Tramontana
  2   11.25    NbE     North by east        Quarto di Tramontana verso Greco
  3   22.5     NNE     North-northeast      Greco-Tramontana
  4   33.75    NEbN    Northeast by north   Quarto di Greco verso Tramontana
  5   45       NE      Northeast            Greco
  6   56.25    NEbE    Northeast by east    Quarto di Greco verso Levante
  7   67.5     ENE     East-northeast       Greco-Levante
  8   78.75    EbN     East by north        Quarto di Levante verso Greco
  9   90       E       East                 Levante
  10  101.25   EbS     East by south        Quarto di Levante verso Scirocco
  11  112.5    ESE     East-southeast       Levante-Scirocco
  12  123.75   SEbE    Southeast by east    Quarto di Scirocco verso Levante
  13  135      SE      Southeast            Scirocco
  14  146.25   SEbS    Southeast by south   Quarto di Scirocco verso Ostro
  15  157.5    SSE     South-southeast      Ostro-Scirocco
  16  168.75   SbE     South by east        Quarto di Ostro verso Scirocco
  17  180      S       South                Ostro
  18  191.25   SbW     South by west        Quarto di Ostro verso Libeccio
  19  202.5    SSW     South-southwest      Ostro-Libeccio
  20  213.75   SWbS    Southwest by south   Quarto di Libeccio verso Ostro
  21  225      SW      Southwest            Libeccio
  22  236.25   SWbW    Southwest by west    Quarto di Libeccio verso Ponente
  23  247.5    WSW     West-southwest       Ponente-Libeccio
  24  258.75   WbS     West by south        Quarto di Ponente verso Libeccio
  25  270      W       West                 Ponente
  26  281.25   WbN     West by north        Quarto di Ponente verso Maestro
  27  292.5    WNW     West-northwest       Maestro-Ponente
  28  303.75   NWbW    Northwest by west    Quarto di Maestro verso Ponente
  29  315      NW      Northwest            Maestro
  30  326.25   NWbN    Northwest by north   Quarto di Maestro verso Tramontana
  31  337.5    NNW     North-northwest      Maestro-Tramontana
  32  348.75   NbW     North by west        Quarto di Tramontana verso Maestro

(setq p32 '(
 (1  0      "N"    "North"              "Tramontana")
 (2  11.25  "NbE"  "North by east"      "Quarto di Tramontana verso Greco")
 (3  22.5   "NNE"  "North-northeast"    "Greco-Tramontana")
 (4  33.75  "NEbN" "Northeast by north" "Quarto di Greco verso Tramontana")
 (5  45     "NE"   "Northeast"          "Greco")
 (6  56.25  "NEbE" "Northeast by east"  "Quarto di Greco verso Levante")
 (7  67.5   "ENE"  "East-northeast"     "Greco-Levante")
 (8  78.75  "EbN"  "East by north"      "Quarto di Levante verso Greco")
 (9  90     "E"    "East"               "Levante")
 (10 101.25 "EbS"  "East by south"      "Quarto di Levante verso Scirocco")
 (11 112.5  "ESE"  "East-southeast"     "Levante-Scirocco")
 (12 123.75 "SEbE" "Southeast by east"  "Quarto di Scirocco verso Levante")
 (13 135    "SE"   "Southeast"          "Scirocco")
 (14 146.25 "SEbS" "Southeast by south" "Quarto di Scirocco verso Ostro")
 (15 157.5  "SSE"  "South-southeast"    "Ostro-Scirocco")
 (16 168.75 "SbE"  "South by east"      "Quarto di Ostro verso Scirocco")
 (17 180    "S"    "South"              "Ostro")
 (18 191.25 "SbW"  "South by west"      "Quarto di Ostro verso Libeccio")
 (19 202.5  "SSW"  "South-southwest"    "Ostro-Libeccio")
 (20 213.75 "SWbS" "Southwest by south" "Quarto di Libeccio verso Ostro")
 (21 225    "SW"   "Southwest"          "Libeccio")
 (22 236.25 "SWbW" "Southwest by west"  "Quarto di Libeccio verso Ponente")
 (23 247.5  "WSW"  "West-southwest"     "Ponente-Libeccio")
 (24 258.75 "WbS"  "West by south"      "Quarto di Ponente verso Libeccio")
 (25 270    "W"    "West"               "Ponente")
 (26 281.25 "WbN"  "West by north"      "Quarto di Ponente verso Maestro")
 (27 292.5  "WNW"  "West-northwest"     "Maestro-Ponente")
 (28 303.75 "NWbW" "Northwest by west"  "Quarto di Maestro verso Ponente")
 (29 315    "NW"   "Northwest"          "Maestro")
 (30 326.25 "NWbN" "Northwest by north" "Quarto di Maestro verso Tramontana")
 (31 337.5  "NNW"  "North-northwest"    "Maestro-Tramontana")
 (32 348.75 "NbW"  "North by west"      "Quarto di Tramontana verso Maestro")))

Funzione che ricerca uno qualunque dei valori di 'Numero', 'Gradi', 'Codice', e 'Nome':

(define (find-points value)
  (let (idx (ref value p32))
    (if idx (p32 (idx 0)) nil)))

Proviamo:

(find-points "South")
;-> (17 180 "S" "South" "Ostro")

(find-points "SbW")
;-> (18 191.25 "SbW" "South by west" "Quarto di Ostro verso Libeccio")

(find-points 281.25)
;-> (26 281.25 "WbN" "West by north" "Quarto di Ponente verso Maestro")

(find-points "Ponente-Libeccio")
;-> (23 247.5 "WSW" "West-southwest" "Ponente-Libeccio")

(find-points "Nord")
;-> nil

Adesso scriviamo una funzione che prende un valore in gradi tra 0 e 359 e restituisce il punto  della bussola più vicino:

(define (point gradi)
  (local (found val1 val2 diff1 diff2 idx)
    ; 0 <= gradi <= 359
    (while (>= gradi 360) (setq gradi (- gradi 360)))
    ; estrae la colonna 'Gradi' dalla lista p32
    (setq column ((transpose p32) 1))
    ; ricerca del valore più vicino
    (setq found nil)
    (dolist (el column found)
      (cond
        ; Caso ultimo settore (348.75 - 0)
        ((>= gradi (column -1))
          (setq found true)
          (setq diff1 (abs (sub gradi (column -1))))
          (setq diff2 (abs (sub gradi 360)))
          ;(println diff1 { } diff2)
          (if (>= diff1 diff2)
              (setq idx $idx)
              (setq idx (- $idx 1))))
        ; Per tutti gli altri settori
        ; quando 'gradi' è minore o uguale al valore corrente
        ; allora abbiamo trovato il settore (range) di appartenenza
        ; del valore 'gradi'
        ((<= gradi el)
          (setq found true)
          (setq val1 el)
          (setq val2 (column (+ $idx 1)))
          (setq diff1 (abs (sub gradi val1)))
          (setq diff2 (abs (sub gradi val2)))
          ;(println val1 { } val2 { } diff1 { } diff2)
          (if (>= diff1 diff2)
              (setq idx (+ $idx 1))
              (setq idx $idx)))
      )
    )
    (if found (p32 idx) nil)))

Proviamo:

(point 0)
;-> (1 0 "N" "North" "Tramontana")

(point 33.75)
;-> (4 33.75 "NEbN" "Northeast by north" "Quarto di Greco verso Tramontana")

(point 45)
;-> (5 45 "NE" "Northeast" "Greco")

(point 60)
;-> (7 67.5 "ENE" "East-northeast" "Greco-Levante")

(point 90)
;-> (9 90 "E" "East" "Levante")

(point 123.123)
;-> (12 123.75 "SEbE" "Southeast by east" "Quarto di Scirocco verso Levante")

(point 360)
;-> (1 0 "N" "North" "Tramontana")

(point 355)
;-> (1 0 "N" "North" "Tramontana")

(point 350)
;-> (32 348.75 "NbW" "North by west" "Quarto di Tramontana verso Maestro")

(point 348.75)
;-> (32 348.75 "NbW" "North by west" "Quarto di Tramontana verso Maestro")


-------------------
Valore delle parole
-------------------

Data una parola (stringa) valutiamo il suo valore in base alle seguenti regole:

1) Le lettere minuscole valgono 'a'=1, 'b'=2, 'c'=3, ... 'z'=26.
2) Ogni lettera maiuscola vale 1.5 volte la corrispondente minuscola.
Per esempio, il valore di 'C' vale 'c'*1.5 = 3*1.5 = 4.5.
3) Tutti gli altri caratteri valgono 0.5.

(define (lower? ch)
"Check if a char is lowercase (a..z)"
  (and (>= ch "a") (<= ch "z")))

(define (upper? ch)
"Check if a char is uppercase (A..Z)"
   (and (>= ch "A") (<= ch "Z")))

(map char '("a" "z" "A" "Z"))
;-> (97 122 65 90)

Distanza tra maiuscole e minuscole = 32
(- 97 65)
;-> 32

Funzione che calcola il valore di una parola (stringa):

(define (wordvalue str)
  (let (value 0)
    (dostring (ch str)
      (cond
        ; minuscole
        ((and (>= ch 97) (<= ch 122))
          (setq value (add value (- ch 96))))
        ; maiuscole
        ((and (>= ch 65) (<= ch 90))
          (++ ch 32)
          (setq value (add value (mul 1.5 (- ch 96)))))
        ; tutti gli altri caratteri
        (true (setq value (add value 0.5)))
      )
    )
    value))

Proviamo:

(wordvalue "c")
(wordvalue "Cc")
(wordvalue "Zz")

Nota: (mul (sub (char c) 64) 1.5) è uguale a (sub (mul 1.5 (char c)) 96).


------------------------------------------------
Eguagliare la somma di due liste (scambio unico)
------------------------------------------------

Date due liste di numeri interi possiamo effettuare una sola volta uno scambio tra un elemento della prima lista con un elemento della seconda lista.
Lo scambio deve servire per eguagliare la somma delle due liste.

In pratica, dobbiamo trovare una coppia di elementi, uno da ciascuna lista, che scambiati rendano uguali le somme delle due liste.

Per equagliare le somme delle due liste, lo scambio di due elementi deve correggere la differenza delle somme.
Quindi dobbiamo trovare due elementi la cui differenza è esattamente metà della differenza tra le somme delle due liste.

(define (equalize-sum A B)
  (local (sum1 sum2 diff found out1 out2)
    (setq tmp1 A)
    (setq tmp2 B)
    (setq sum1 (apply + A))
    (setq sum2 (apply + B))
    (setq diff (- sum1 sum2))
    (cond
      ; le lista hanno già somma uguale
      ((zero? diff)
        (println "Nessuno scambio.")
        (println A { } B { } sum1))
      ; Se la differenza è dispari,
      ; non è possibile eguagliare le somme con un singolo scambio.
      ((odd? diff)
        (println "Differenza dispari tra somme.")
        (println "Impossibile eguagliare le somme con un solo scambio."))
      ; ricerca della coppia di elementi
      (true
        (setq found nil)
        (dolist (x A)
          (setq idx1 $idx)
          (dolist (y B)
            (setq idx2 $idx)
            ; cerchiamo due elementi la cui differenza è esattamente metà
            ; della differenza tra le somme delle due liste
            (when (= (- x y) (/ diff 2))
                (setq found true)
                (println "Scambiare " x " in A con " y " in B")
                (swap (tmp1 idx1) (tmp2 idx2))
                (println tmp1 { } tmp2 { } (apply + tmp1) { } (apply + tmp2))
                (setq tmp1 A)
                (setq tmp2 B))
          )
        )
        (if (not found)
          (println "Impossibile eguagliare le somme con un solo scambio.")))) '>))

Proviamo:

(setq a '(1 2 3 4 5))
(setq b '(2 4 6 8 10))
(equalize-sum a b)

(setq a '(1 2 3 4 6))
(setq b '(2 4 6 8 10))
(equalize-sum lst1 lst2)
;-> Scambiare 1 in A con 8 in B
;-> (8 2 3 4 6) (2 4 6 1 10) 23 23
;-> Scambiare 3 in A con 10 in B
;-> (1 2 10 4 6) (2 4 6 8 3) 23 23


------------------------------
Numero di cifre dei fattoriali
------------------------------

Per calcolare il numero di cifre di N! (dove N è un intero positivo) possiamo utilizzare i logaritmi:

  Numero cifre numero N = floor(log10 N) + 1

  Numero cifre numero N! = floor(log10 N!) + 1

Per la proprietà: log10(a*b) = log10(a) + log10(b)

  log10(N!) = log10(1) + log10(2) + ... + log10(N)

  Numero cifre numero N! = floor(log10(1) + log10(2) + ... + log10(N)) + 1

(define (log10 x) (log x 10))

Formula che calcola il numero di cifre del fattoriale di un numero N:

(define (digit-fact N)
  (add (floor (apply add (map log10 (sequence 1 N)))) 1)
)

Formula che calcola il fattoriale di un numero N:

(define (fact n) (apply * (map bigint (sequence 1 n))))

Proviamo:

(digit-fact 10)
;-> 7
(length (fact 10))
;-> 7

(digit-fact 100)
;-> 158
(length (fact 100))
;-> 158

(digit-fact 1000)
;-> 2568
(length (fact 1000))
;-> 2567

(digit-fact 10000)
La seguente espressione manda in crash la REPL di newLISP (probabilmente il numero risultante eccede la memoria disponibile):
;(length (fact 10000))

Comunque possiamo continuare a contare le cifre del fattoriale con "digit-fact".

(digit-fact 1e6)
;-> 5565709

Se una pagina contiene 40 righe con 80 caratteri ognuna, allora occorrono 1740 pagine per scrivere 1e6!:

(div 5565709 (mul 40 80))
;-> 1739.2840625

Vedi anche "Numero di cifre dei fattoriali (formula di Kamenetsky)" su "Note libere 11".


--------------------------------------------
Generazione di numeri primi in un intervallo
--------------------------------------------

Per generare i numeri primi da 1 a N possiamo usare la seguente funzione:

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

Per generare i numeri primi in un intervallo (a..b) modifichiamo la funzione precedente:

(define (primes-range a b)
"Generates all prime numbers in the range (a..b) included"
  (if (> a b) (swap a b))
  (cond ((= b 1) '())
        ((= b 2) '(2))
        (true
          (let ((lst '(2)) (arr (array (+ b 1))))
            ; initialize lst
            (if (> a 2) (setq lst '()))
            (for (x 3 b 2)
              (when (not (arr x))
                ; push current primes (x) only if > a
                (if (>= x a) (push x lst -1))
                (for (y (* x x) b (* 2 x) (> y b))
                  (setf (arr y) true)))) lst))))

Proviamo:

(primes-range 1 2)
;-> (2)
(primes-range 1 3)
;-> (2 3)
(primes-range 10 100)
;-> (11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

(= (primes-range 1 1e6) (primes-to 1e6))
;-> true

Per verificare i risultati della funzione "primes-range" usiamo un'altra funzione che calcola i primi in un intervallo:

(define (primi-tra a b)
  (filter (fn(x) (= (length (factor x)) 1)) (sequence a b)))

(= (primes-range 3 20) (primi-tra 3 20))
;-> true
(= (primes-range 1 1e6) (primi-tra 1 1e6))
;-> true
(= (primes-range 101 1e5) (primi-tra 101 1e5))
;-> true
(= (primes-range 1e5 1e6) (primi-tra 1e5 1e6))
;-> true

Vediamo la  velocitè delle funzioni:

(time (primes-to 1e6))
;-> 144.871
(time (primes-range 1 1e6))
;-> 145.462
(time (primi-tra 1 1e6))
;-> 800.222

(time (primi-tra 1e3 1e5))
;-> 50.189
(time (primes-range 1e3 1e5))
;-> 9.929

(time (primi-tra 1e5 1e6))
;-> 763.068
(time (primes-range 1e5 1e6))
;-> 143.841


-----------------------------------------------------
Carattere medio di una stringa e stringhe equilibrate
-----------------------------------------------------

Il carattere medio di una stringa viene calcolato nel modo seguente:

1) sommare i valori ASCII di tutti i caratteri della stringa (sum)
2) dividere la somma per la lunghezza della stringa (x = sum/len)
3) arrotondare il risultato all'intero più vicino  (x = int(x + 0.5))
4) convertire il risultato in carattere char(x)

Per esempio:
  stringa = "newLISP"
  caratteri = "n" "e" "w" "L" "I" "S" "P"
  ascii = 110 101 119 76 73 83 80
  somma = 642
  x = 642/7 = 91.71428571428571
  x = int(0.5 + x) = 92
  carattere-medio = char(92) = "\\"

Funzione che calcola il carattere medio di una stringa:

(define (avg-ch str)
  (char (int (add 0.5 (div (apply + (map char (explode str))) (length str))))))

Proviamo:

(avg-ch "program")
;-> "m"
(avg-ch "chess")
;-> "k"
(avg-ch "newlisp"))
;-> "n"
(avg-ch "MATHEMATICS")
;-> "J"

Una stringa è equilibrata quando il primo carattere è uguale al suo carattere medio.

(define (balanced? str) (= (str 0) (avg-ch str)))

Proviamo:

(balanced? "newlisp")
;-> true
(balanced? "home")
;-> nil
(balanced? "massimo")
;-> true

Ricerchiamo le parole equilibrate in un file (unixdict.txt) che contiene 25104 parole.
Il file "unixdict.txt" si trova nella cartella "data".

Leggiamo tutto il file in una stringa:

(setq datafile (read-file "unixdict.txt"))

Trasformiamo questa stringa in una lista di stringhe delimitate dal carattere di fine linea (eol - end of line). La funzione "parse" fa proprio questo, suddivide una stringa in sottostringhe basandosi su un delimitatore (in windows il delimitatore di fine linea è "\r\n", mentre su UNIX è "\n"):

(setq data (parse datafile "\n"))

Cerchiamo tutte le parole equilibrate:

(filter balanced? data)
;-> ("a" "aaa" "aba" "ababa" "b" "bad" "c" "cabbage" "cb" "cdc" "d"
;->  "d'oeuvre" "dabble" "dade" "dc" "dead" "deadhead" "deaf" "dec"
;->  ...
;->  "sylow" "synonymy" "t" "tory" "toy" "troy" "trust" "trw" "u"
;->  "usury" "ut" "v" "w" "wv" "x" "y" "z")

(length (filter balanced? data))
;-> 983


-----------------------------------------
Righe e colonne delle matrici come numeri
-----------------------------------------

Data una matrice NxM di interi non negativi trovare:

1) la somma dei numeri di ogni riga e di ogni colonna
2) i numeri (uniti come strighe) di ogni riga e di ogni colonna

Per esempio:

            |1 3 2|
  matrice = |4 3 6|
            |0 7 8|

  somma-numeri-riga (N) = (1 + 3 + 2 = 6) (4 + 3 + 6 = 13) (0 + 7 + 8 = 15) =
                        = 6 13 15
  somma-numeri-colonna (M) = (1 + 4 + 0 = 5) (3 + 3 + 7 = 13) (2 + 6 + 8 = 16) =
                        = 5 13 16
  output = 6 13 15 5 13 16 (N+M elementi)

  numeri-stringa-riga (N) = 132 436 78
  numeri-stringa-colonna (M) = 140 337 268
  output = 132 436 78 140 337 268 (N+M elementi)

Funzione che restituisce la lista delle somme dei numeri di ogni riga e di ogni colonna di una matrice:

(define (rows-cols-sums matrix)
  (let (out '())
    ; somma degli elementi di ogni riga
    (extend out (map (fn(x) (apply + x)) matrix))
    ; somma degli elementi di ogni colonna
    (extend out (map (fn(x) (apply + x)) (transpose matrix)))))

(rows-cols-sums '((1 3 2) (4 3 6) (0 7 8)))
;-> (6 13 15 5 13 16)
(matrix-numbers '((1 3 2) (4 3 6) (0 7 8)))

Funzione che restituisce la lista dei numeri (uniti come strighe) di ogni riga e di ogni colonna di una matrice:

(define (rows-cols-numbers matrix)
  (let (out '())
    ; per ogni riga: converte i numeri in stringhe, unisce le stringhe,
    ; infine converte la stringa unita in un numero intero.
    (extend out (map (fn(x) (int (join (map string x)) 0 10)) matrix))
    ; per ogni colonna: converte i numeri in stringhe, unisce le stringhe,
    ; infine converte la stringa unita in un numero intero.
    (extend out (map (fn(x) (int (join (map string x)) 0 10)) (transpose matrix)))))

(rows-cols-numbers '((1 3 2) (4 3 6) (0 7 8)))
;-> (132 436 78 140 337 268)


-----------------------------------
Quadrati di cifre con somma massima
-----------------------------------

Data una lista di cifre (0..9), disporre le cifre nella forma quadrata che ha somma massima.
La lista contiene sempre un numero quadrato di cifre.
La somma viene calcolata con i numeri creati unendo le cifre di ogni riga e di ogni colonna.

Vediamo un esempio:

  lista = (1 2 4 4)
  una forma quadrata:  1 2
                       4 4
  somma = 12 + 44 + 14 + 24 = 94

  altra forma quadrata: 4 2
                        1 4
  somma = 42 + 14 + 41 + 24 = 121

  forma quadrata massima: 4 4
                          2 1
  somma = 44 + 21 + 42 + 41 = 148

Una soluzione è quella di generare tutte le permutazioni dei numeri della lista e calcolare la matrice che ha somma massima.

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

Funzione che restituisce la lista dei numeri (uniti come strighe) di ogni riga e di ogni colonna di una matrice:

(define (rows-cols-numbers matrix)
  (let (out '())
    ; per ogni riga: converte i numeri in stringhe, unisce le stringhe,
    ; infine converte la stringa unita in un numero intero.
    (extend out (map (fn(x) (int (join (map string x)) 0 10)) matrix))
    ; per ogni colonna: converte i numeri in stringhe, unisce le stringhe,
    ; infine converte la stringa unita in un numero intero.
    (extend out (map (fn(x) (int (join (map string x)) 0 10)) (transpose matrix)))))

Funzione che trova la matrice quadrata con somma massima:

(define (matrice-somma-massima lst)
  (local (permute sum-max mat-max)
    (setq side (sqrt (length lst)))
    (setq sum-max 0)
    (setq mat-max '())
    (setq permute (perm lst))
    (dolist (p permute)
      (setq a (array side side p))
      (setq sum (apply + (rows-cols-numbers a)))
      (if (> sum sum-max) (set 'sum-max sum 'mat-max a)
      )
    )
    (list sum-max mat-max)))

Proviamo:

(setq lst '(1 2 4 4))
(setq matrix (matrice-somma-massima '(1 2 4 4)))
;-> (148 (4 4) (2 1))

(setq lst '(1 2 3 4 5 6 7 8 9))
(setq matrix (matrice-somma-massima lst))
;-> (4698 ((9 7 6) (8 4 3) (5 2 1)))

(setq lst '(2 2 4 3 1 1 2 3 2))
(time (println (setq matrix (matrice-somma-massima lst))))
;-> (1939 ((4 3 2) (3 2 1) (2 2 1)))
;-> 5001.764

Comunque se la lista contiene più di 9 elementi (la successiva lista contiene 16 elementi), allora il calcolo delle permutazioni è irrealizzabile.

Un'altra idea è quella di determinare quali posizioni della matrice hanno un 'peso' maggiore nell'operazione di somma.
La posizione in alto a destra della matrice ha il 'peso' maggiore, infatti è la posizione che viene moltiplicata per la potenza di 10 più grande.
Vediamo per esempio una matrice 3x3:

  |a b c|
  |d e f|
  |g h i|

Per le righe:
  La posizione 'a' vale 100, la posizione 'b' vale 10, la posizione 'c' vale 1.
  La posizione 'd' vale 100, la posizione 'e' vale 10, la posizione 'f' vale 1.
  La posizione 'g' vale 100, la posizione 'h' vale 10, la posizione 'i' vale 1.

Per le colonne:
  La posizione 'a' vale 100, la posizione 'd' vale 10, la posizione 'g' vale 1.
  La posizione 'b' vale 100, la posizione 'e' vale 10, la posizione 'h' vale 1.
  La posizione 'c' vale 100, la posizione 'f' vale 10, la posizione 'i' vale 1.

Per ogni posizione sommiamo i relativi valori di riga e colonna:
  a = 100 + 100 = 200
  b = 10 + 100 = 110
  ...
  i = 1 + 1 = 2

Otteniamo:

   a   b   c   d   e  f  g   h  i
  (200 110 101 110 20 11 101 11 2)

Vediamo come creare una lista con i valori e gli indici di ogni posizione:

  (valore (i j))

(setq pos '())
(setq side 3)

(for (i 0 (- side 1))
  (for (j 0 (- side 1))
    (setq ival (pow 10 (- (- side 1) i)))
    (setq jval (pow 10 (- (- side 1) j)))
    (setq val (+ ival jval))
    (push (list val (list i j)) pos -1)
  )
)
;-> ((200 (0 0)) (110 (0 1)) (101 (0 2)) (110 (1 0)) (20 (1 1))
;->  (11 (1 2)) (101 (2 0)) (11 (2 1)) (2 (2 2)))

Con questa lista possiamo facilmente creare il quadrato con la somma massima:
1) Ordinare la lista delle posizioni (decrescente).
2) Ordinare la lista dei numeri (decrescente).
3) Ciclo sulla lista dei numeri
     Inserire il numero corrente nella matrice agli indici (i, j)
     individuati dalla posizione corrente ($idx)

(setq lst '(1 2 3 4 5 6 7 8 9))
(sort pos >)
;-> ((200 (0 0)) (110 (1 0)) (110 (0 1)) (101 (2 0)) (101 (0 2))
;->  (20 (1 1)) (11 (2 1)) (11 (1 2)) (2 (2 2)))
(sort lst >)
;-> (9 8 7 6 5 4 3 2 1)

(setq out (array-list (array side side '(0))))
;-> ((0 0 0) (0 0 0) (0 0 0))

(dolist (el lst) (setf (out (pos $idx 1)) el))
out
;-> ((9 7 5) (8 4 2) (6 3 1))

Calcoliamo la somma di questa matrice:

(apply + (rows-cols-numbers out))
;-> 4698

Quindi la soluzione vale:

somma = 4698
matrice = (9 7 5)
          (8 4 2)
          (6 3 1)

Scriviamo la funzione che calcola la matrice quadrata con somma massima:

(define (mat-sum-max lst)
  (local (pos len side ival jval val out)
    ; Creazione della lista delle posizioni
    (setq pos '())
    (setq len (length lst))
    (setq side (sqrt len))
    (for (i 0 (- side 1))
      (for (j 0 (- side 1))
        (setq ival (pow 10 (- side 1 i)))
        (setq jval (pow 10 (- side 1 j)))
        (setq val (+ ival jval))
        (push (list val (list i j)) pos -1)
      )
    )
    ; ordina la lista delle posizioni
    (sort pos >)
    ; ordina la lista data
    (sort lst >)
    ; Inserisce gli elementi della lista data nella matrice 'out'
    ; in modo da avere somma massima
    (setq out (array-list (array side side '(0))))
    (dolist (el lst)
      (setf (out (pos $idx 1)) el)
    )
    out))

Proviamo:

(setq lst '(1 2 3 4 5 6 7 8 9))
(setq matrix (mat-sum-max lst))
;-> ((9 7 5) (8 4 2) (6 3 1))
(apply + (rows-cols-numbers matrix))
;-> 4698

(setq lst '(1 2 4 4))
(setq matrix (mat-sum-max '(1 2 4 4)))
;-> ((4 2) (4 1))
(apply + (rows-cols-numbers matrix))
;-> 148

(setq lst '(2 2 4 3 1 1 2 3 2))
(setq matrix (mat-sum-max lst))
;-> ((4 3 2) (3 2 1) (2 2 1))
(apply + (rows-cols-numbers matrix))
;-> 1939

(setq lst '(5 4 3 6 9 2 6 8 8 1 6 8 5 2 8 4 2 4 5 7 3 7 6 6 7))
(setq matrix (mat-sum-max lst))
;-> ((9 8 8 7 6) (8 6 6 5 5) (8 6 4 4 3) (7 6 4 2 2) (7 5 3 2 1))
(apply + (rows-cols-numbers matrix))
;-> 836445


-------------------------------------------
Quanto vale la radice 0-esima di un numero?
-------------------------------------------

La radice cubica (3) di 27 vale 3.

(define (cbrt x)
"Calculates the cube root of a number"
  (if (< x 0)
      (sub (pow (sub x) (div 3)))
      ;else (positive number)
      (pow x (div 3))))

(cbrt 27)
;-> 3

La radice quadrata (2) di 16 vale 4.

(sqrt 16)
;-> 4

La radice (0) di un numero x vale ?

Se x^n = a, allora x = rootN(a)
  dove rootN rappresenta la radice N-esima (root2 = "sqrt", root3 = "cbrt")

Quindi, ponendo n=0:

  x^0 = a, allora x = root0(a)

Poichè qualunque numero x elevato a 0 vale 1: x^0 = 1,

Risulta:  2^0 = 1, allora 2 = root0(1)
Ma anche: 5^0 = 1, allora 5 = root0(1)

che è chiaramente impossibile.

Scriviamo la radice N-esima in un altro modo:

  rootN(x) = x^(1/N)

Ponendo N = 0 (root0) otteniamo:

  root0(x) = x^(1/0)

A questo punto possiamo considerare due casi distinti:

1) Consideriamo la divisione per zero come una operazione indefinita, di conseguenza anche root0(x) è indefinita.

2) Consideriamo 1/0 = infinito, allora vediamo quanto vale x^infinito:
se x > 1:     x^inf = inf
se 0 < x < 1: x^inf = 0
se x = 1:     1^inf = 1
se x = 0:     0^inf = 0
se x < 0:     l'espressione non è ben definita per esponenti reali infiniti

In conclusione i matematici hanno stabilito che l'estrazione della radice 0-esima di un numero è una operazione indefinita.


-----------------
Indice di Simpson
-----------------

L'indice Simpson è una misura della diversità di una collezione di elementi con duplicati.
In ecologia viene spesso utilizzato per quantificare la biodiversità di un habitat.
Tiene conto del numero di specie presenti, nonché dell'abbondanza di ciascuna specie.
Si tratta di una misura della diversità che tiene conto del numero di specie presenti, nonché dell'abbondanza relativa di ciascuna specie.
Dal punto di vista matematico l'indice è equivalente alla probabilità di estrarre in modo casuale due elementi diversi da una collezione di elementi.

L'indice viene calcolato con la seguente formula:

                       n(i)*(n(i) - 1)
  S = 1 - Sum[i=1,k](-------------------)
                          N*(N - 1)

  dove:
  N = numero totale di elementi
  n(1), n(2), ..., n(k) = numero di elementi uguali del gruppo i-esimo (i=1..k)

Vediamo un esempio:

(setq lst '(1 1 2 2 2 3 3 4 5 6 7 7))
;-> (1 1 2 2 2 3 3 4 5 6 7 7)
(setq len (length lst))
;-> 12

Calcolo dei valori unici:

(setq unici (unique lst))
;-> (1 2 3 4 5 6 7)

Conteggio delle occorrenze di ogni valore unico:

(setq conta (count unici lst))
;-> (2 3 2 1 1 1 2)

Calcolo dell'indice di Simpson:

(setq S 0)
(dolist (el conta)
  (setq S (add S (mul el (- el 1))))
  (println el { } S)
)
(setq S (sub 1 (div S (mul len (- len 1)))))
;-> 0.9090909090909091

Scriviamo la funzione che calcola l'indice di Simpson per una lista di elementi:

(define (simpson lst)
  (local (len unici conta S)
    (setq len (length lst))
    ; calcolo valori unici:
    (setq unici (unique lst))
    ; conteggio delle occorrenze di ogni valore unico:
    (setq conta (count unici lst))
    ; Calcolo dell'indice di Simpson:
    (setq S 0)
    (dolist (el conta) (setq S (add S (mul el (- el 1)))))
    (setq S (sub 1 (div S (mul len (- len 1)))))))

Proviamo:

(setq lst '(1 1 2 2 2 3 3 4 5 6 7 7))
(simpson lst)
;-> 0.9090909090909091

(setq lst '(1 1 1 2 2 3))
(simpson lst)
;-> 0.7333333333333334

(simpson (explode "AAABBCC"))
;-> 0.7619047619047619

Con elementi tutti uguali l'indice vale 0:
(simpson (explode "AAA"))
;-> 0

Con elementi tutti diversi l'indice vale 1:
(simpson (explode "ABC"))
;-> 1

Vediamo di calcolare l'indice di Simpson con una simulazione del processo di estrazione di due elementi dalla lista.

(define (simula lst iter)
  (let ( (ok 0) (r '()) )
    (for (i 1 iter)
      (setq r (randomize lst))
      (if (= (r 0) (r 1)) (++ ok)))
    (sub 1 (div ok iter))))

Proviamo:

(setq lst '(1 1 2 2 2 3 3 4 5 6 7 7))
(simula lst 1e6)
;-> 0.908613

(setq lst '(1 1 1 2 2 3))
(simula lst 1e6)
;-> 0.734974

(simula (explode "AAABBCC") 1e6)
;-> 0.762323

Con elementi tutti uguali l'indice vale 0:
(simula (explode "AAA") 1e6)
;-> 0

Con elementi tutti diversi l'indice vale 1:
(simula (explode "ABC") 1e6)
;-> 1


----------------------------
Generazione di somme diverse
----------------------------

Scrivere una funzione che prende un numero intero N e restituisce due numeri interi X e Y la cui somma è il numero dato.
Ulteriore requisito: nessun numero può far parte dell'output per due input diversi.

Esempio 1:

  1 --> 4 -3
  2 --> 7 -5
  4 --> 8 -5
  Errato, perchè '-5' è già stato usato

Esempio 2:

  -2 --> -5  3
   0 -->  0  0
   1 --> -8  9
   2 --> -5  7
   3 --> 11 -8
  Corretto...fino a questo punto.

Il problema può essere risolto se restringiamo il numero in ingresso in un determinato intervallo [a..b].

Per esempio, supponiamo di voler considerare l'intervallo [-32768 .. 32767].
Dobbiamo trovare una funzione che genera numeri sufficientemente distanziati.
Una funzione potrebbe essere l'elevamento al cubo:

  numero = N
  X = -(N^3)
  Y = N - X

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1L
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (diff num)
  (letn ( (num (bigint num)) (potenza (** num 3)) )
    (list (- potenza) (+ num potenza))))

(map diff (sequence 0 10))
;-> ((0L 0L) (-1L 2L) (-8L 10L) (-27L 30L) (-64L 68L) (-125L 130L)
;->  (-216L 222L) (-343L 350L) (-512L 520L) (-729L 738L) (-1000L 1010L))

Questi numeri sono distinti perché i cubi sono sufficientemente distanziati che l'aggiunta di n a n**3 non è sufficiente per superare lo spazio vuoto fino al cubo successivo: n**3 < n+n**3 < (n+1)**3 per n positivo e simmetricamente per n negativo.

Vediamo se la funzione di elevamento al cubo copre tutto l'intervallo:

Generiamo tutti i numeri di output da -32768 a 32767

(setq all '())
(silent (for (i -32768 32767) (extend all (diff i))))

Vediamo se esistono numeri duplicati (a parte lo 0 a causa di 0 = 0 - 0):

(length all)
;-> 131072
(length (unique all))
;-> 131071
(count '(0) all)
;-> (2)
(count '(0) (unique all))
;-> (1)

Per questo intervallo l'elevamento al cubo è sufficiente per generare sempre numeri diversi.
Per intervalli più grandi potremmo utilizzare l'elevamento a potenza con k>3:

(define (diff num k)
  (letn ( (num (bigint num)) (potenza (** num k)) )
    (list (- potenza) (+ num potenza))))

Intervallo (-1e5.. 1e5), proviamo con k = 4:

(setq all '())
(silent (for (i -1e5 1e5) (extend all (diff i 4))))

Vediamo se esistono numeri duplicati (a parte lo 0 a causa di 0 = 0 - 0):

(length all)
;-> 400002
(length (unique all))
;-> 300000

Esistono duplicati, quindi usiamo una potenza superiore k = 5:

(setq all '())
(silent (for (i -1e5 1e5) (extend all (diff i 5))))
(length all)
;-> 400002
(length (unique all))
;-> 400001

In questo caso l'elevamento a potenza con k=5 è sufficiente ad ottenere numeri tutti distinti.


--------------------
Distanze tra pianeti
--------------------

Le distanze tra i pianeti varieranno a seconda di dove si trova ciascun pianeta nella sua orbita attorno al Sole. A volte le distanze saranno più vicine e altre volte saranno più lontane.

Questo accade perchè i pianeti hanno orbite ellittiche e nessuno di essi è un cerchio perfetto. Ad esempio, la distanza tra Mercurio e la Terra può variare da 77 milioni di km nel punto più vicino, fino a 222 milioni di km nel punto più lontano. C'è un'enorme differenza nelle distanze tra i pianeti a seconda della loro posizione sul loro percorso orbitale.

((Sole)) Mercurio - Venere - Terra - Marte - Giove - Saturno - Urano - Nettuno

La tabella delle distanze medie tra pianeti è la seguente:
  +---------------------+---------------+---------------+
  |      Pianeti        | Distanza (km) | Distanza (AU) |
  +---------------------+---------------+---------------+
  | Mercurio -> Venere  |      50290000 |
  | Venere   -> Terra   |      41400000 |
  | Terra    -> Marte   |      78340000 |
  | Marte    -> Giove   |     550390000 |
  | Giove    -> Saturno |     646270000 |
  | Saturno  -> Urano   |    1448950000 |
  | Urano    -> Nettuno |    1627450000 |
  | Nettuno  -> Plutone |    1405380000 |
  +---------------------+---------------+---------------+
La colonna Distanza (AU) rappresenta la distanza in Unità Astronomiche.
1 AU è la distanza tra il Sole e la Terra, ovvero 149.600.000 km.

Dividiamo la tabella in due liste:

(setq planets '("Mercurio" "Venere" "Terra" "Marte" "Giove"
                "Saturno" "Urano" "Nettuno" "Plutone"))

(setq dist '(50290000 41400000 78340000 550390000 646270000
             1448950000 1627450000 1405380000))

Troviamo gli indici dei pianeti:

(setq idx1 (find "Venere" planets))
;-> 1
(setq idx2 (find "Giove" planets))
;-> 4

Troviamo la lista delle distanze da considerare:

(setq lst (slice dist idx1 (- idx2 idx1)))
;-> (41400000 78340000 550390000)

Sommiamo le distanze della lista:

(apply + lst)
;-> 670130000

Funzione che calcola la distanza tra due pianeti (km):

(define (distanza p1 p2)
  (setq planets '("Mercurio" "Venere" "Terra" "Marte" "Giove"
                  "Saturno" "Urano" "Nettuno" "Plutone"))
  (setq dist '(50290000 41400000 78340000 550390000 646270000
               1448950000 1627450000 1405380000))
  (setq idx1 (find p1 planets))
  (setq idx2 (find p2 planets))
  (cond
    ((nil? idx1) (println "Pianeta: " p1 " non trovato") nil)
    ((nil? idx2) (println "Pianeta: " p2 " non trovato") nil)
    ((= idx1 idx2) (println "Distanza tra " p1 " e " p2 ": 0 km") nil)
    (true
      (if (> idx1 idx2) (swap idx1 idx2) (swap p1 p2))
      (setq d (apply + (slice dist idx1 (- idx2 idx1))))
      (println "Distanza tra " p1 " e " p2 ": " d " km") true)))

Proviamo:

(distanza "Mercurio" "Venere")
;-> Distanza tra Venere e Mercurio: 50290000 km
;-> true
(distanza "Mercurio" "Mercurio")
;-> Distanza tra Mercurio e Mercurio: 0 km
;-> nil
(distanza "Nettuno" "Marte")
;-> Distanza tra Nettuno e Marte: 4273060000 km
;-> true
(distanza "Terra" "Plutone")
;-> Distanza tra Plutone e Terra: 5756780000 km
;-> 5756780000
(distanza "Mercurio" "Nettuno")
;-> Distanza tra Nettuno e Mercurio: 4443090000 km
;-> true

Conversione Kilometri <--> Unita Astronomiche:

(define (km-AU km) (div km 149600000))
(define (AU-km AU) (mul AU 149600000))

Funzione che calcola la distanza tra due pianeti (km o AU):

(define (distance p1 p2 AU)
  (local (planets dist idx1 idx2 km)
    (setq planets '("Mercurio" "Venere" "Terra" "Marte" "Giove"
                    "Saturno" "Urano" "Nettuno" "Plutone"))
    (setq dist '(50290000 41400000 78340000 550390000 646270000
                1448950000 1627450000 1405380000))
    (setq idx1 (find p1 planets))
    (setq idx2 (find p2 planets))
    (cond
      ((nil? idx1) nil)
      ((nil? idx2) nil)
      ((= idx1 idx2) 0)
      (true
        (if (> idx1 idx2) (swap idx1 idx2) (swap p1 p2))
        (setq km (apply + (slice dist idx1 (- idx2 idx1))))
        (if AU (div km 149600000) km)))))

Proviamo:

(distance "Mercurio" "Venere")
;-> 50290000
(distance "Mercurio" "Mercurio")
;-> 0
(distance "Nettuno" "Marte")
;-> 4273060000
(distance "Terra" "Plutone")
;-> 5756780000
(distance "Mercurio" "Nettuno")
;-> 4443090000
(distance "Mercurio" "Nettuno" true)
;-> 29.69979946524064

Tabella delle distanze degli otto pianeti (senza Plutone):

    DA         A      (AU)       (km)
+---------+---------+-------+------------+
| Mercury | Venus   | 0.34  | 50290000   |
+---------+---------+-------+------------+
| Mercury | Earth   | 0.61  | 91691000   |
+---------+---------+-------+------------+
| Mercury | Mars    | 1.14  | 170030000  |
+---------+---------+-------+------------+
| Mercury | Jupiter | 4.82  | 720420000  |
+---------+---------+-------+------------+
| Mercury | Saturn  | 9.14  | 1366690000 |
+---------+---------+-------+------------+
| Mercury | Uranus  | 18.82 | 2815640000 |
+---------+---------+-------+------------+
| Mercury | Neptune | 29.7  | 4443090000 |
+---------+---------+-------+------------+
| Venus   | Earth   | 0.28  | 41400000   |
+---------+---------+-------+------------+
| Venus   | Mars    | 0.8   | 119740000  |
+---------+---------+-------+------------+
| Venus   | Jupiter | 4.48  | 670130000  |
+---------+---------+-------+------------+
| Venus   | Saturn  | 8.8   | 1316400000 |
+---------+---------+-------+------------+
| Venus   | Uranus  | 18.49 | 2765350000 |
+---------+---------+-------+------------+
| Venus   | Neptune | 29.37 | 4392800000 |
+---------+---------+-------+------------+
| Earth   | Mars    | 0.52  | 78340000   |
+---------+---------+-------+------------+
| Earth   | Jupiter | 4.2   | 628730000  |
+---------+---------+-------+------------+
| Earth   | Saturn  | 8.52  | 1275000000 |
+---------+---------+-------+------------+
| Earth   | Uranus  | 18.21 | 2723950000 |
+---------+---------+-------+------------+
| Earth   | Neptune | 29.09 | 4351400000 |
+---------+---------+-------+------------+
| Mars    | Jupiter | 3.68  | 550390000  |
+---------+---------+-------+------------+
| Mars    | Saturn  | 7.99  | 1196660000 |
+---------+---------+-------+------------+
| Mars    | Uranus  | 17.69 | 2645610000 |
+---------+---------+-------+------------+
| Mars    | Neptune | 28.56 | 4273060000 |
+---------+---------+-------+------------+
| Jupiter | Saturn  | 4.32  | 646270000  |
+---------+---------+-------+------------+
| Jupiter | Uranus  | 14.01 | 2095220000 |
+---------+---------+-------+------------+
| Jupiter | Neptune | 24.89 | 3722670000 |
+---------+---------+-------+------------+
| Saturn  | Uranus  | 9.7   | 1448950000 |
+---------+---------+-------+------------+
| Saturn  | Neptune | 20.57 | 3076400000 |
+---------+---------+-------+------------+
| Uranus  | Neptune | 10.88 | 1627450000 |
+---------+---------+-------+------------+

(setq d8 '((Mercury Venus 0.34 50290000)
           (Mercury Earth 0.61 91691000)
           (Mercury Mars 1.14 170030000)
           (Mercury Jupiter 4.82 720420000)
           (Mercury Saturn 9.14 1366690000)
           (Mercury Uranus 18.82 2815640000)
           (Mercury Neptune 29.70 4443090000)
           (Venus Earth 0.28 41400000)
           (Venus Mars 0.8 119740000)
           (Venus Jupiter 4.48 670130000)
           (Venus Saturn 8.80 1316400000)
           (Venus Uranus 18.49 2765350000)
           (Venus Neptune 29.37 4392800000)
           (Earth Mars 0.52 78340000)
           (Earth Jupiter 4.2 628730000)
           (Earth Saturn 8.52 1275000000)
           (Earth Uranus 18.21 2723950000)
           (Earth Neptune 29.09 4351400000)
           (Mars Jupiter 3.68 550390000)
           (Mars Saturn 7.99 1196660000)
           (Mars Uranus 17.69 2645610000)
           (Mars Neptune 28.56 4273060000)
           (Jupiter Saturn 4.32 646270000)
           (Jupiter Uranus 14.01 2095220000)
           (Jupiter Neptune 24.89 3722670000)
           (Saturn Uranus 9.7 1448950000)
           (Saturn Neptune 20.57 3076400000)
           (Uranus Neptune 10.88 1627450000)))


----------------
Liste bilanciate
----------------

Una lista a(1), a(2), a(3), ..., a(n) è considerata bilanciata se soddisfa uno dei seguenti criteri:

1) esiste un indice 'i' per cui risulta:

   Sum(a(0) + ... + a(i)) = Sum(a(i+1) + a(i+2) + ... + a(n))

2) esiste un indice 'i' per cui risulta:

   Sum(a(0) + ... + a(i-1)) = Sum(a(i+1) + a(i+2) + ... + a(n))

Nel primo caso la lista può essere divisa all'indice 'i' in due parti che hanno somma uguale
(l'elemento alla posizione 'i' appartiene alla parte sinistra della lista):

  (1 4 6 5 3 2 1) --> (1 4 6) (5 3 2 1) --> 1 + 4 + 6 = 5 + 3 + 2 + 1

Nel secondo caso la lista può essere divisa all'indice 'i' in due parti che hanno somma uguale
(l'elemento alla posizione 'i' non appartiene a nessuna delle due parti della lista):

  (2 5 3 4 1 2) --> (2 5) 3 (4 1 2) --> 2 + 5 = 4 + 1 + 2

Criterio 1
----------

(define (balance1 lst)
  (local (out sx dx stop)
    (setq out '())
    ; somma parte sinistra
    (setq sx 0)
    ; somma parte destra
    (setq dx (apply + lst))
    (setq stop nil)
    ; ciclo per ogni elemento della lista
    (dolist (el lst)
      ; somma corrente parte sinistra
      (setq sx (+ sx el))
      ; somma corrente parte destra
      (setq dx (- dx el))
      ; somme uguali?
      (cond ((= sx dx)
              (setq out (list $idx el sx dx))
              (setq stop true))
            ((> sx dx) (setq stop true))
      )
    )
    out))

Proviamo:

(setq lst1 '(1 4 6 5 3 2 1))
(setq lst2 '(2 5 3 4 1 2))

(balance1 lst1)
;-> (2 6 11 11)

(balance1 lst2)
;-> ()

Criterio 2
----------

(define (balance2 lst)
  (local (out sx dx stop)
    (setq out '())
    ; somma parte sinistra
    (setq sx (lst 0))
    ; numero pivot
    (setq pivot (lst 1))
    ; somma parte destra
    (setq dx (- (apply + lst) (lst 0) (lst 1)))
    (setq stop nil)
    (for (i 1 (- (length lst) 2) 1 stop)
      ;(print (lst i) { } sx { } dx) (read-line)
      ; somme uguali?
      (cond ((= sx dx)
              (setq out (list (lst i) i sx dx))
              (setq stop true))
            ((> sx dx) (setq stop true))
      )
      ; somma corrente parte sinistra
      (setq sx (+ sx pivot))
      ; nuovo numero pivot
      (setq pivot (lst (+ i 1)))
      ; somma corrente parte destra
      (setq dx (- dx pivot))
    )
    out))

Proviamo:

(balance2 lst1)
;-> ()

(balance2 lst2)
;-> (3 2 7 7)


----------------------------------------------------
Stringhe con caratteri minuscoli e maiuscoli casuali
----------------------------------------------------

Data una stringa con caratteri ASCII, scrivere una funzione più breve possibile per restituire la stringa con gli stessi caratteri, ma con minuscole e maiuscole distribuite in modo casuale.

Per esempio:
  stringa = "newlisp"
  output  = "NEwLisP" (una delle tante risposte possibili)

Prima versione:

(define (r s)
  (dolist (c (explode s))
    (if (zero? (rand 2))
        (setf (s $idx) (upper-case c))
        (setf (s $idx) (lower-case c)))
  ) s)

113 caratteri:
(define(r1 s)(dolist(c(explode s))(if(zero?(rand 2))(setf(s $idx)(upper-case c))(setf(s $idx)(lower-case c)))) s)

Proviamo:

(r1 "newlisp")
;-> "NEwLIsp"
(r1 "newlisp")
;-> "NeWlisP"
(r1 "newlisp")
;-> "NEWlisp"
(r1 "newlisp")
;-> "NEwLIsp"

Seconda versione:

(define (r2 s)
  (join (map (fn(x) (eval (list ('(upper-case lower-case) (rand 2)) x)))
             (explode s))))

91 caratteri:
(define(r2 s)(join(map(fn(x)(eval(list('(upper-case lower-case)(rand 2)) x)))(explode s))))

Proviamo:

(r2 "newlisp")
;-> "NeWliSP"
(r2 "newlisp")
;-> "NewLisp"
(r2 "newlisp")
;-> "NEwLIsp"
(r2 "newlisp")
;-> "NEwlisP"


---------------------------------
Esplosioni all'interno di matrici
---------------------------------

Abbiamo una matrice NxM con valori interi.
Facciamo esplodere una 'bomba' di potenza B nella cella (x,y).
Restituire la matrice dopo lo scoppio della 'bomba'.
La potenza della bomba B può essere positiva o negativa.

Come funziona l'esplosione?
1) La cella (x,y) aumenta il valore di B (o diminuisce se B è negativo)
2) Le celle intorno a (x,y) aumentano di valore (B - 1)
3) Le celle intorno al rettangolo 2) aumentano di valore (B - 2)
4) Le celle intorno al rettangolo 3) aumentano di valore (B - 3)
...
B) Le celle intorno al rettangolo precedente aumentano di valore 1.

In altre parole, dalla cella (x,y) vengono creati contorni chiusi con valori determinati da B e dal valore delle celle.

Per esempio:

Matrice (7x9):  0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0
                0 0 0 0 0 0 0 0 0

Bomba a (3,4) di valore 3:  0 0 0 0 0 0 0 0 0
                            0 0 1 1 1 1 1 0 0
                            0 0 1 2 2 2 1 0 0
                            0 0 1 2 3 2 1 0 0
                            0 0 1 2 2 2 1 0 0
                            0 0 1 1 1 1 1 0 0
                            0 0 0 0 0 0 0 0 0

Funzione che esplode una bomba di valore B alla cella (i,j) della matrice mx:

(define (bomb mx i j B)
  (local (rows cols)
    (setq rows (length mx))
    (setq cols (length (mx 0)))
    ;
    ; Funzione che aggiorna il valore di una cella
    (define (set-cell x y value)
      ; se la cella individuata dalle coordinate x,y è interna alla matrice...
      (if (and (>= x 0) (< x (length mx)) (>= y 0) (< y (length (mx 0))))
        ;... allora aggiorna il valore della cella
        (setf (mx x y) (+ (mx x y) value))
      )
    )
    (cond
      ((> B 0) ; valore bomba positivo
        ; Ciclo decrescente sulla potenza della Bomba
        (for (k 0 (- B 1))
          ; Creazione rettangolo di valori k
          (for (di (- k) k)   ; righe
            (for (dj (- k) k) ; colonne
              (if (or (= (abs di) k) (= (abs dj) k))
                (set-cell (+ i di) (+ j dj) (- B k))
              )
            )
          )
        ))
      ((< B 0) ; valore bomba negativo
        (setq B (abs B))
        ; Ciclo decrescente sulla potenza della Bomba
        (for (k 0 (- B 1))
          ; Creazione rettangolo di valori k
          (for (di (- k) k)   ; righe
            (for (dj (- k) k) ; colonne
              (if (or (= (abs di) k) (= (abs dj) k))
                (set-cell (+ i di) (+ j dj) (+ (- B) k))
              )
            )
          )
        ))
    )
    mx))

Proviamo:

(setq m '((0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0) (0 0 0 0 0 0 0 0 0)
          (0 0 0 0 0 0 0 0 0)))

(map println (bomb m 3 4 3))
;-> (0 0 0 0 0 0 0 0 0)
;-> (0 0 1 1 1 1 1 0 0)
;-> (0 0 1 2 2 2 1 0 0)
;-> (0 0 1 2 3 2 1 0 0)
;-> (0 0 1 2 2 2 1 0 0)
;-> (0 0 1 1 1 1 1 0 0)
;-> (0 0 0 0 0 0 0 0 0)

(map println (bomb m 0 0 9))
;-> (9 8 7 6 5 4 3 2 1)
;-> (8 8 7 6 5 4 3 2 1)
;-> (7 7 7 6 5 4 3 2 1)
;-> (6 6 6 6 5 4 3 2 1)
;-> (5 5 5 5 5 4 3 2 1)
;-> (4 4 4 4 4 4 3 2 1)
;-> (3 3 3 3 3 3 3 2 1)

(map println (bomb m 6 8 9))
;-> (1 2 3 3 3 3 3 3 3)
;-> (1 2 3 4 4 4 4 4 4)
;-> (1 2 3 4 5 5 5 5 5)
;-> (1 2 3 4 5 6 6 6 6)
;-> (1 2 3 4 5 6 7 7 7)
;-> (1 2 3 4 5 6 7 8 8)
;-> (1 2 3 4 5 6 7 8 9)

Bombe multiple:

(map println (setq m (bomb m 2 2 3)))
;-> (1 1 1 1 1 0 0 0 0)
;-> (1 2 2 2 1 0 0 0 0)
;-> (1 2 3 2 1 0 0 0 0)
;-> (1 2 2 2 1 0 0 0 0)
;-> (1 1 1 1 1 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)

(map println (setq m (bomb m 2 2 3)))
;-> (2 2 2 2 2 0 0 0 0)
;-> (2 4 4 4 2 0 0 0 0)
;-> (2 4 6 4 2 0 0 0 0)
;-> (2 4 4 4 2 0 0 0 0)
;-> (2 2 2 2 2 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)

Bomba negativa:

(map println (setq m (bomb m 2 2 -2)))
;-> (2 2 2 2 2 0 0 0 0)
;-> (2 3 3 3 2 0 0 0 0)
;-> (2 3 4 3 2 0 0 0 0)
;-> (2 3 3 3 2 0 0 0 0)
;-> (2 2 2 2 2 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)
;-> (0 0 0 0 0 0 0 0 0)

Bomba altra cella:

(map println (setq m (bomb m 3 4 3)))
;-> (2 2 2 2 2 0 0 0 0)
;-> (2 3 4 4 3 1 1 0 0)
;-> (2 3 5 5 4 2 1 0 0)
;-> (2 3 4 5 5 2 1 0 0)
;-> (2 2 3 4 4 2 1 0 0)
;-> (0 0 1 1 1 1 1 0 0)
;-> (0 0 0 0 0 0 0 0 0)

Bomba altra cella:

(map println (setq m (bomb m 5 7 10)))
;-> (5  6  7  7  7  5  5  5  5)
;-> (5  7  9 10  9  7  7  6  6)
;-> (5  7 10 11 11  9  8  7  7)
;-> (5  7  9 11 12 10  9  8  8)
;-> (5  6  8 10 11 10 10  9  9)
;-> (3  4  6  7  8  9 10 10  9)
;-> (3  4  5  6  7  8  9  9  9)

Questa funzione è la base per calcolare i risultati del lancio di una bomba in un gioco del tipo "Battaglia Navale" (un pò più avanzato).


------------------------------
Wolfram Engine e WolframScript
------------------------------

Cos'è WolframScript?
----------------------
WolframScript è un'interfaccia a riga di comando per Wolfram Engine.
Consente di eseguire il codice WolframLang da un terminale.
Wolfram Engine viene fornito con WolframScript in bundle.

Download Wolfram Engine (Free):
https://www.wolfram.com/developer/

WolframScript Reference:
https://reference.wolfram.com/language/ref/program/wolframscript.html

Tutorial
--------
1) Esegue WolframScript dal terminale

type "wolframscript"

Wolfram Language 12.2.0 Engine for Microsoft Windows (64-bit)
Copyright 1988-2020 Wolfram Research, Inc.

In[1]:= Integrate[1/x^3,x]

          1  1
Out[1]= -(-) --
          2   2
             x

In[2]:= Expand[(x^2 + xy +y^2)^3]

         6      4         2   2     3      4  2      2     2       2  2      2  4         4    6
Out[3]= x  + 3 x  xy + 3 x  xy  + xy  + 3 x  y  + 6 x  xy y  + 3 xy  y  + 3 x  y  + 3 xy y  + y

In[3]:=
...

2) Exit WolframScript
type "Exit" or "Quit".

3) Esegue codice WolframLang
wolframscript -code "3+1"

4) Esegue un file con codice WolframLang
wolframscript -file test.wls

5) Stampa risultato
# run a file and print last expression
wolframscript -file test.wls -print

6) Stampa tutti i risultati
# run a file and print all expressions
wolframscript -file test.wls -print all

7) Stampa la versione di WolframScript.
wolframscript -version

8) Fornisce aiuto per le opzioni:
wolframscript -h

WolframScript complete Reference:
https://reference.wolfram.com/language/ref/program/wolframscript.html

Vediamo alcuni semplici esempi di come usare WolframScript con newLISP:

(exec {wolframscript -code "3+1"})
;-> ("4")

(exec {wolframscript -code "Integrate[1/x^3,x]"})
;-> ("-1/2*1/x^2")

(exec {wolframscript -code "Expand[(x^2 + xy +y^2)^3]"})
;-> ("x^6 + 3*x^4*xy + 3*x^2*xy^2 + xy^3 + 3*x^4*y^2 + 6*x^2*xy*y^2 +
;->   3*xy^2*y^2 + 3*x^2*y^4 + 3*xy*y^4 + y^6")

Le possibilità di utilizzo sono innumerevoli.


---------------------------------------------------------
Simboli di una matrice 3x3 (permutazioni con ripetitione)
---------------------------------------------------------

Le celle di una matrice 3x3 possono contenere 0 o 1.
Se consideriamo 0 come il carattere spazio " " e 1 come come il carattere asterisco "*", quanti e quali simboli si possono  formare?

Per esempio:
matrice = 1 0 1   simbolo = *   *
          1 0 1             *   *
          1 1 1             * * *

matrice = 0 1 0   simbolo =   *
          1 0 1             *   *
          0 1 0               *

Si tratta di creare tutte le permutazioni di 9 elementi con ripetizione dalla lista (0, 1) e poi stamparle come se fossero matrici 3x3.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Numero di simboli:

(length (perm-rep 9 '(0 1)))
;-> 512

Altra funzione che genera permutazioni con ripetizione:

(define (permutations-with-repetitions N K)
  (if (= N 0)
    (list '())
    (let ((sub-permutations (permutations-with-repetitions (- N 1) K)))
      (apply append
        (map (lambda (elem)
               (map (lambda (sub-perm)
                      (cons elem sub-perm))
                    sub-permutations))
             (sequence 0 (- K 1)))))))

(permutations-with-repetitions 4 2)
;-> ((0 0 0 0) (0 0 0 1) (0 0 1 0) (0 0 1 1) (0 1 0 0) (0 1 0 1) (0 1 1 0)
;->  (0 1 1 1) (1 0 0 0) (1 0 0 1) (1 0 1 0) (1 0 1 1) (1 1 0 0) (1 1 0 1)
;->  (1 1 1 0) (1 1 1 1))

Il numero totale di permutazioni con ripetizioni di N elementi scelti da K elementi è dato dalla formula:

  numero permutazioni con ripetizione = K^N

Questa formula assume che ogni posizione nella sequenza può essere occupata da uno qualsiasi dei K elementi, e quindi ci sono
K scelte per ciascuna delle N posizioni.

(pow 2 9)
;-> 512

Funzione che genera tutti i 512 simboli:

(define (print-all c0 c1)
  (local (all m)
    (setq all (perm-rep 9 '(0 1)))
    (dolist (el all)
      (setq m (explode el 3))
      (for (r 0 2)
        (for (c 0 2)
          (if (zero? (m r c)) (print c0) (print c1))
        )
        (println)
      )
      ;(read-line)
      (println "------"))))

Proviamo:

(print-all "." "█")

;-> ...     █..     .█.     ██.     ..█     █.█
;-> ...     ...     ...     ...     ...     ...
;-> ...     ...     ...     ...     ...     ...
;-> ------  ------  ------  ------  ------  ------

...

;-> .█.     ██.     ..█     █.█     .██     ███
;-> ███     ███     ███     ███     ███     ███
;-> ███     ███     ███     ███     ███     ███
;-> ------  ------  ------  ------  ------  ------


--------------------------------------------------------
Verificare se una lista è sottoinsieme di un'altra lista
--------------------------------------------------------

Date due liste A e B vogliamo verificare se tutti gli elementi di A appartengono agli elementi di B (cioè se una lista di elementi (A) è costituita solo da elementi di un'altra lista (B)).

Per esempio:
  A = (1 2 2 1 ),  B = (1 2),     Output = true (ogni valore di A si trova in B)
  A = (1 2 2 1 3), B = (1 2),     Output = nil  (il 3 di A non si trova in B)
  A = (1 2 2 1),   B = (1 2 3),   Output = true (il 3 in B non conta)
  A = (1 2 3),     B = (1 2 2 1), Output = nil  (il 3 di A non si trova in B)

Primo metodo:
-------------

(define (subset1? lst1 lst2)
  ; Checks if all elements of a list (lst1) are in another list (lst2)
  (for-all (fn(x) (ref x lst2)) lst1))

(ref x lst2): Restituisce l'indice di x in lst2 se x è presente, altrimenti restituisce nil.
for-all: Restituisce true solo se la funzione anonima restituisce true per tutti gli elementi di lst1.

Secondo metodo:
---------------

(define (subset2? lst1 lst2)
  (= (difference lst1 lst2) '()))

(difference lst1 lst2): restituisce '() se tutti gli elementi di lst1 si trovano in lst2.

Proviamo:

(subset1? '(1 1 2 2 3 3)   '(1 2 3))
;-> true
(subset2? '(1 1 2 2 3 3)   '(1 2 3))
;-> true

(subset1? '(1 1 2 2 3 3)   '(1 2 3 4))
;-> true
(subset2? '(1 1 2 2 3 3)   '(1 2 3 4))
;-> true

(subset1? '(1 1 2 2 3 3 4) '(1 2 3))
;-> nil
(subset2? '(1 1 2 2 3 3 4) '(1 2 3))
;-> nil

(subset1? '(1 2 3)   '(1 1 2 2 3 3))
;-> true
(subset2? '(1 2 3)   '(1 1 2 2 3 3))
;-> true

(subset1? '(1 2 3 4) '(1 1 2 2 3 3))
;-> nil
(subset2? '(1 2 3 4) '(1 1 2 2 3 3))
;-> nil

(subset1? '(1 2 3)   '(1 1 2 2 3 3 4))
;-> true
(subset2? '(1 2 3)   '(1 1 2 2 3 3 4))
;-> true

Vediamo la velocità delle funzioni:

Output = true
(time (subset1? t '(0 1 2 3)) 1000)
;-> 156.206
(time (subset2? t '(0 1 2 3)) 1000)
;-> 109.343
(time (subset1? t '(0 1 2 3)) 10000)
;-> 1500.393
(time (subset2? t '(0 1 2 3)) 10000)
;-> 1031.574

Output = nil
(time (subset1? t '(0 1 3)) 1000)
;-> 15.587
(time (subset2? t '(0 1 3)) 1000)
;-> 109.338
(time (subset1? t '(0 1 3)) 10000)
;-> 62.447
(time (subset2? t '(0 1 3)) 10000)
;-> 1031.228

Per liste che danno come risultato true, la versione con "difference" è leggermente più veloce.
Per liste che danno come risultato nil, la versione con "for-all" è mediamente molto più veloce.
Questo perchè "for-all" restituisce nil appena un elemento non soddisfa la condizione, mentre restituisce true solo dopo aver controllato tutti gli elementi.


-----------------------------
Numeri binari in basi diverse
-----------------------------

Dato un numero intero positivo N in quali basi (base <= 10) il numero ha una rappresentazione di soli 0 e 1?

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

(define (subset? lst1 lst2)
"Check if all elements of lst1 are in lst2"
  (for-all (fn(x) (ref x lst2)) lst1))

(subset? '(0 1 0 0 0 0 1 1 1 0) '(0 1))
;-> true
(subset? '(0 1 1 0 0 2) '(0 1))
;-> nil
(subset? '(1 2 3 2 1 2 3 3 2 1) '(1 2 3))
;-> true
(subset? '(1 2 3 2 1 2 3 3 2 1) '(1 2 3 4))
;-> true
(subset? '(1 2 3 4) '(1 2 3 2 1 2 3 3 2 1))
;-> nil

Funzione che restituisce le basi il cui il numero N è costituito solo da 0 e 1:

(define (basi01 N)
  (setq strN (explode (string N)))
  (setq basi '())
  (for (b 2 10)
    (setq str-num (base10-baseN N b))
    (setq num (int str-num 0 10))
    (if (subset? (explode str-num) '("0" "1")) (push (list b num) basi -1))
  )
  (push N basi)
  basi)

Proviamo:

(basi01 10)
;-> (10 (2 1010) (3 101) (9 11) (10 10))
(basi01 1111)
;-> (1111 (2 10001010111) (10 1111))

Funzione che calcola il numero con basi01 massimo:

(define (basi01-max start end)
  (setq out (basi01 start))
  (for (k (+ start 1) end)
    (setq cur (basi01 k))
    (when (> (length cur) (length out))
      (println cur)
      (setq out cur)))
  out)

Proviamo:

(basi01-max 2 100000)
;-> (3 (2 11) (3 10))
;-> (4 (2 100) (3 11) (4 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))

(basi01-max 100000 2)
;-> (86356 (2 10101000101010100) (3 11101110101) (4 111011110))
;-> (82000 (2 10100000001010000) (3 11011111001) (4 110001100) (5 10111000))

(time (basi01-max 2 1e5))
;-> (3 (2 11) (3 10))
;-> (4 (2 100) (3 11) (4 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))
;-> 5672.122

(time (basi01-max 2 1e6))
;-> (3 (2 11) (3 10))
;-> (4 (2 100) (3 11) (4 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))
;-> 56366.144

Possiamo velocizzare la funzione "basi01", scrivendo una funzione unica:

(define (basi01-fast N)
  (local (out quotient cur continua)
    (setq out '())
    ; Ciclo sulle basi
    (for (base 2 10)
      ; Conversione del numero N in base 'base'
      (setq cur '())
      (setq continua true)
      (setq quotient N)
      (while (and (>= quotient base) continua)
        ; se la cifra corrente non vale 0 o 1, allora esce
        ; dal ciclo di conversione di base
        (if (> (% quotient base) 1)
            (setq continua nil)
            (push (% quotient base) cur)
        )
        (setq quotient (/ quotient base))
      )
      (if continua
          (if (> quotient 1)
              (setq continua nil)
              (push quotient cur)
          )
      )
      ; inserisce la base e la conversione corrente nella lista soluzione
      ; solo se la conversione è costituita da 0 e 1
      (if continua (push (list base cur) out -1))
    )
    (push N out)
    out))

Proviamo:

(basi01 10)
;-> (10 (2 1010) (3 101) (9 11) (10 10))
(length (basi01 10))
;-> 5

(basi01-fast 10)
;-> (10 (2 (1 0 1 0)) (3 (1 0 1)) (9 (1 1)) (10 (1 0)))
(length (basi01-fast 10))
;-> 5

(define (basi01-max-fast start end)
  (setq out (basi01-fast start))
  (for (k (+ start 1) end)
    (setq cur (basi01-fast k))
    (when (> (length cur) (length out))
      (println cur)
      (setq out cur)))
  out)

(time (basi01-max-fast 2 1e5))
;-> (3 (2 11) (3 10))
;-> (4 (2 100) (3 11) (4 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))
;-> 718.566

(time (basi01-max-fast 2 1e6))
;-> (3 (2 11) (3 10))
;-> (4 (2 100) (3 11) (4 10))
;-> (9 (2 1001) (3 100) (8 11) (9 10))
;-> 7594.215


-----------
Dama cinese
-----------

Scrivere una funzione che stampa la seguente raffigurazione di dama cinese:

              G
             G G
            G G G
           G G G G
  B B B B . . . . . Y Y Y Y
   B B B . . . . . . Y Y Y
    B B . . . . . . . Y Y
     B . . . . . . . . Y
      . . . . . . . . .
     P . . . . . . . . O
    P P . . . . . . . O O
   P P P . . . . . . O O O
  P P P P . . . . . O O O O
           R R R R
            R R R
             R R
              R

Colore dei Pezzi: Green, Yellow, Orange, Red, Purple, Blue

(define (print-chinese)
  (local (rows chinese)
    (setq rows
              '("            G            "
                "           G G           "
                "          G G G          "
                "         G G G G         "
                "B B B B . . . . . Y Y Y Y"
                " B B B . . . . . . Y Y Y "
                "  B B . . . . . . . Y Y  "
                "   B . . . . . . . . Y   "
                "    . . . . . . . . .    "
                "   P . . . . . . . . O   "
                "  P P . . . . . . . O O  "
                " P P P . . . . . . O O O "
                "P P P P . . . . . O O O O"
                "         R R R R         "
                "          R R R          "
                "           R R           "
                "            R            "))
    (setq chinese (map explode rows))
    (for (r 0 (- (length chinese) 1))
      (for (c 0 (- (length (chinese 0)) 1))
        (print (chinese r c))) (println))))

(print-chinese)
;->             G
;->            G G
;->           G G G
;->          G G G G
;-> B B B B . . . . . Y Y Y Y
;->  B B B . . . . . . Y Y Y
;->   B B . . . . . . . Y Y
;->    B . . . . . . . . Y
;->     . . . . . . . . .
;->    P . . . . . . . . O
;->   P P . . . . . . . O O
;->  P P P . . . . . . O O O
;-> P P P P . . . . . O O O O
;->          R R R R
;->           R R R
;->            R R
;->             R


----------------------------
Griglie esagonali (Hex Grid)
----------------------------

In una griglia esagonale (per esempio la tavola per il gioco dell'Hex) le celle possono essere indicizzate con una terna (x y z).
La cella al centro della griglia è (0 0 0).
La griglia viene ordinata in a base al raggio degli anelli di esagoni concentrici (partendo dall'origine (0 0 0)).

Vedi immagine "Hex-Grid.png" nella cartella "data".

Per generare la lista delle coordinate per ogni anello dobbiamo notare che:
1) x + y = z = 0 per tutte le celle
2) la somma dei valori assoluti di x, y e z sono pari al doppio del raggio dell'anello.
Questo è sufficiente per identificare ogni esagono su ciascun anello successivo.
Inoltre ogni anello contiene sei celle in più rispetto al precedente e ogni vettore di 120° contiene un punto in più rispetto al centro.

Funzione che genera le coordinate (anello per anello) di una griglia esagonale:

(define (hex-grid rings)
  (let (out '())
    (for (i 0 rings)
      (for (j (- i) i)
      (for (k (- i) i)
      (for (l (- i) i)
        (if (and (= (+ (abs j) (abs k) (abs l)) (* i 2)) (zero? (+ j k l)))
            (push (list j k l) out -1)))))) out))

Proviamo:

(hex-grid 2)
;-> ((0 0 0)
;->  (-1 0 1) (-1 1 0) (0 -1 1) (0 1 -1) (1 -1 0) (1 0 -1)
;->  (-2 0 2) (-2 1 1) (-2 2 0) (-1 -1 2) (-1 2 -1) (0 -2 2)
;->  (0 2 -2) (1 -2 1) (1 1 -2) (2 -2 0) (2 -1 -1) (2 0 -2))

(hex-grid 3)
;-> ((0 0 0)
;->  (-1 0 1) (-1 1 0) (0 -1 1) (0 1 -1) (1 -1 0) (1 0 -1)
;->  (-2 0 2) (-2 1 1) (-2 2 0) (-1 -1 2) (-1 2 -1) (0 -2 2)
;->  (0 2 -2) (1 -2 1) (1 1 -2) (2 -2 0) (2 -1 -1) (2 0 -2))
;->  (-3 0 3) (-3 1 2) (-3 2 1) (-3 3 0) (-2 -1 3) (-2 3 -1)
;->  (-1 -2 3) (-1 3 -2) (0 -3 3) (0 3 -3) (1 -3 2) (1 2 -3)
;->  (2 -3 1) (2 1 -3) (3 -3 0) (3 -2 -1) (3 -1 -2) (3 0 -3))


---------------------------
Autoconteggio dei caratteri
---------------------------

Scrivere una funzione che restituisce una lista con il conteggio dei propri caratteri in odine decrescente di occorrenze.

Per esempio:
Funzione: (define (demo) (+ 3 2))
Conteggio caratteri: ((4 " ") (3 "e") (3 "(") (2 "d") (2 ")") (1 "o") (1 "n")
                      (1 "m") (1 "i") (1 "f") (1 "3") (1 "2") (1 "+"))

(setq s "(define (demo) (+ 3 2)")
(setq code (explode s))
(setq uniq (unique code))
(sort (map (fn(x y) (list y x)) uniq (count uniq code)) >)

Vediamo una funzione di esempio per capire quale rappresentazione usare:

(define (test a b)
  (local (c s)
    (setq s "/\\"))
    (setq c (+ a b)))

Metodi di rappresentazione della funzione:

(explode (source 'test))
;-> ("(" "d" "e" "f" "i" "n" "e" " " "(" "t" "e" "s" "t" " " "a" " " "b"
;->  ")" "\r" "\n" " " " " "(" "l" "o" "c" "a" "l" " " "(" "c" " " "s"
;->  ")" " " "\r" "\n" " " " " " " "(" "s" "e" "t" "q" " " "s" " " "\""
;->  "/" "\\" "\\" "\"" ")" ")" "\r" "\n" " " " " "(" "s" "e" "t" "q"
;->  " " "c" " " "(" "+" " " "a" " " "b" ")" ")" ")" "\r" "\n" "\r" "\n")

(parse (source 'test))
;-> ("(" "define" "(" "test" "a" "b" ")" "(" "local" "(" "c" "s" ")" "("
;->  "setq" "s" "/\\" ")" ")" "(" "setq" "c" "(" "+" "a" "b" ")" ")" ")")

(explode (string test))
;-> ("(" "l" "a" "m" "b" "d" "a" " " "(" "a" " " "b" ")" " " "(" "l" "o"
;->  "c" "a" "l" " " "(" "c" " " "s" ")" " " "(" "s" "e" "t" "q" " " "s"
;->  " " "\"" "/" "\\" "\\" "\"" ")" ")" " " "(" "s" "e" "t" "q" " " "c"
;->  " " "(" "+" " " "a" " " "b" ")" ")" ")")

(parse (string test))
;-> ("(" "lambda" "(" "a" "b" ")" "(" "local" "(" "c" "s" ")" "(" "setq"
;->  "s" "/\\" ")" ")" "(" "setq" "c" "(" "+" "a" "b" ")" ")" ")")

Il primo metodo sembra quello più appropriato (perchè abbiamo anche i caratteri \r, \n).

(define (auto-count-chars)
  (local (code uniq)
    (setq code (explode (source 'auto-count-chars)))
    (setq uniq (unique code))
    (sort (map (fn(x y) (list y x)) uniq (count uniq code)) >)))

(auto-count-chars)
;-> ((48 " ") (20 ")") (20 "(") (18 "o") (18 "e") (15 "u") (15 "c") (13 "t")
;->  (13 "a") (11 "s") (10 "n") (9 "d") (8 "q") (7 "r") (7 "l") (7 "i")
;->  (7 "\r") (7 "\n") (6 "-") (5 "p") (4 "x") (3 "m") (3 "h") (2 "y")
;->  (2 "f") (2 "'") (1 "b") (1 ">"))

Versione minimalista (100 caratteri):

(define(f)(letn((c(explode(source 'f)))(u(unique c)))(sort(map(fn(x y)(list y x)) u(count u c))>)))
(f)
;-> ((27 " ") (15 ")") (15 "(") (7 "u") (7 "e") (5 "c") (4 "t") (4 "o")
;->  (4 "n") (4 "l") (4 "\r") (4 "\n") (3 "x") (3 "s") (3 "i") (3 "f")
;->  (3 "d") (3 "a") (2 "y") (2 "r") (2 "p") (2 "m") (1 "q") (1 "b")
;->  (1 ">") (1 "'"))


-------------------------------------------------------------
Calcolo dei valori di resistenza per resistori (4 band color)
-------------------------------------------------------------

I resistori hanno delle bande codificate a colori che vengono utilizzate per identificare la loro resistenza in Ohm.
Consideriamo i normali resistori assiali a 4 bande.

            a   b   c   t
         +------------------+
         |  ||  ||  ||  ||  |
  -------+  ||  ||  ||  ||  +-------
         |  ||  ||  ||  ||  |
         +------------------+

  Colore    Numero    Moltiplicatore    Lettera
  Black       0         1                  K
  Brown       1         10                 N
  Red         2         100                R
  Orange      3         1000               O
  Yellow      4         10000              Y
  Green       5         100000             G
  Blue        6         1000000            B
  Violet      7         10000000           V
  Gray        8         100000000          A
  White       9         1000000000         W
  Gold                  +/- 5%             g
  Silver                +/- 10%            s
  None                  +/- 20%            n

Formato del codice: a b c t

dove a è la prima banda, b è la seconda banda e hanno il nome di un colore (i quali sono associati ai numeri 0 .. 9).
     c è il moltiplicatore (da 1, 10, 100, ..., 1000000000),
     t è la tolleranza che può valere "Gold", "Silver" o "None".

Il valore della resistenza viene calcolato con la seguente formula:

  R = (10*a + b)*c (Ohm) +/-t

Funzione che calcola la resistenza in base ai colori (4 bande):

(define (resistor lst)
  (local (colors tolerance a b c t ohm)
    (setq colors '("Black" "Brown" "Red" "Orange" "Yellow" "Green" "Blue"
                   "Violet" "Gray" "White"))
    (setq tolerance '(("Gold" 5) ("Silver" 10) ("None" 20)))
    ; get band 1 color value
    (setq a (find (lst 0) colors))
    ; get band 2 color value
    (setq b (find (lst 1) colors))
    ; get multiplicator value
    (setq c (pow 10 (find (lst 2) colors)))
    ; get toleranceance
    (setq t (lookup (lst 3) tolerance))
    ;(println a { } b { } c { } t)
    ; calculate value of resistor (Ohm)
    (setq ohm (* (+ (* 10 a) b) c))
    ; convert to string with K,M,G
    (cond
      ((>= ohm 1e9) (string (format "%.1f" (div ohm 1e9)) " Gohms (+/- " t "%)"))
      ((>= ohm 1e6) (string (format "%.1f" (div ohm 1e6)) " Mohms (+/- " t "%)"))
      ((>= ohm 1e3) (string (format "%.1f" (div ohm 1e3)) " Kohms (+/- " t "%)"))
    (true (string ohm "ohms +/- " t)))))

Proviamo:

(resistor '("Brown" "Black" "Orange" "Gold"))
;-> "10.0 Kohms (+/- 5%)"

(resistor '("Orange" "Red" "Violet" "None"))
;-> "320.0 Mohms (+/- 20%)"

(resistor '("Yellow" "Green" "White" "Silver"))
;-> "45.0 Gohms (+/- 10%)"


----------------
Sequenze magiche
----------------

Una sequenza magica è una sequenza di interi non negativi a[0..n-1] tale che ci siano esattamente a[i] occorrenze di i.
Ad esempio, (5 2 1 0 0 1 0 0 0) è una sequenza magica poiché ci sono cinque 0, due 1, un 2 e un 5.
Scrivere una funzione che prende un intero positivo N e restituisce una sequenza magica di lunghezza N.

Si può dimostrare che le uniche sequenze magiche sono le seguenti:

N = 4
Sequenze = (1 2 1 0) oppure (2 0 2 0)

N = 5
Sequenza =  (2 1 2 0 0)

N >= 7
Sequenza = (N-4 2 1) + [(N-7) volte 0] + (1 0 0 0)

Dimostrazione di xnor:
https://codegolf.stackexchange.com/questions/50151/magic-sequences-of-length-n

Funzione che calcola la sequenza magica per un numero N:

(define (magic-sequence N)
  (cond ((= N 4) '(1 2 1 0))
        ((= N 5) '(2 1 2 0 0))
        ((>= N 7)
          (let (out '())
            (extend out (list (- N 4) 2 1))
            (extend out (dup 0 (- N 7)))
            (extend out '(1 0 0 0))))
        (true '())))

Proviamo:

(magic-sequence 9)
;-> (5 2 1 0 0 1 0 0 0)

(map magic-sequence (sequence 4 20))
;-> ((1 2 1 0)
;->  (2 1 2 0 0)
;->  ()
;->  (3 2 1 1 0 0 0)
;->  (4 2 1 0 1 0 0 0)
;->  (5 2 1 0 0 1 0 0 0)
;->  (6 2 1 0 0 0 1 0 0 0)
;->  (7 2 1 0 0 0 0 1 0 0 0)
;->  (8 2 1 0 0 0 0 0 1 0 0 0)
;->  (9 2 1 0 0 0 0 0 0 1 0 0 0)
;->  (10 2 1 0 0 0 0 0 0 0 1 0 0 0)
;->  (11 2 1 0 0 0 0 0 0 0 0 1 0 0 0)
;->  (12 2 1 0 0 0 0 0 0 0 0 0 1 0 0 0)
;->  (13 2 1 0 0 0 0 0 0 0 0 0 0 1 0 0 0)
;->  (14 2 1 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0)
;->  (15 2 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0)
;->  (16 2 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0))


------------------
Sequenza di Alcuin
------------------

Nella sequenza di Alcuin, a(n) è il numero di triangoli con lati interi e perimetro n.

Sequenza OEIS: A005044
Alcuin's sequence: expansion of x^3/((1-x^2)*(1-x^3)*(1-x^4)).
  0, 0, 0, 1, 0, 1, 1, 2, 1, 3, 2, 4, 3, 5, 4, 7, 5, 8, 7, 10, 8, 12, 10,
  14, 12, 16, 14, 19, 16, 21, 19, 24, 21, 27, 24, 30, 27, 33, 30, 37, 33,
  40, 37, 44, 40, 48, 44, 52, 48, 56, 52, 61, 56, 65, 61, 70, 65, 75, 70,
  80, 75, 85, 80, 91, 85, 96, 91, 102, 96, 108, 102, 114, 108, 120, ...

Formula:
  a(n) = round(n^2/48), se n è pari
       = round((n+3)^2/48), se n è dispari

(define (alcuin n)
  (if (even? n)
      (int (add 0.5 (div (* n n) 48)))
      (int (add 0.5 (div (* (+ n 3) (+ n 3)) 48)))))

Proviamo:

(alcuin 9)
;-> 3
(alcuin 10)
;-> 2

(map alcuin (sequence 0 70))
;-> (0 0 0 1 0 1 1 2 1 3 2 4 3 5 4 7 5 8 7 10 8 12
;->  10 14 12 16 14 19 16 21 19 24 21 27 24 30 27 33 30 37 33
;->  40 37 44 40 48 44 52 48 56 52 61 56 65 61 70 65 75 70
;->  80 75 85 80 91 85 96 91 102 96 108 102)


---------------------
Distanza di Hausdorff
---------------------

La distanza di Hausdorff tra due insiemi finiti non vuoti A e B può essere calcolata trovando l'elemento di A per il quale la distanza dall'elemento più vicino di B è massima, e l'elemento di B per il quale la distanza dall'elemento più vicino di A è massima, e quindi prendendo il massimo di questi distanze.
Considerando dist(a,b) = (abs (a - b)), l'algoritmo è il seguente:

1. Per ciascun elemento "a" dell'insieme A, trovare la distanza minima da qualsiasi elemento dell'insieme B.
2. Trovare il massimo di queste distanze minime per tutti gli "a" in A.
3. Allo stesso modo, per ciascun elemento "b" dell'insieme B, trovare la distanza minima da qualsiasi elemento dell'insieme A.
4. Trovare il massimo di queste distanze minime per tutti gli "b" in B.
5. La distanza di Hausdorff è il massimo di questi due massimi.

In altre parole, se la distanza di Hausdorff è d, allora ogni elemento di A si trova entro la distanza d da qualche elemento di B, e viceversa.

(define (min-distance a B)
  (apply min (map (fn(b) (abs (- a b))) B)))

"min-distance": questa funzione calcola la distanza minima tra un elemento a e tutti gli elementi dell'insieme B.
Utilizza la funzione 'map' per applicare il calcolo della distanza '(abs (- a b))' a ciascun elemento b in B, quindi trova il valore minimo utilizzando 'apply min'.

(define (max-min-distance set1 set2)
  (apply max (map (fn(x) (min-distance x set2)) set1)))

"max-min-distance": questa funzione calcola la distanza massima tra tutti gli elementi di un set e un altro set.
Mappa la funzione "min-distance" su tutti gli elementi in "set1" e applica "max" al risultato.

(define (hausdorff A B)
  (let ((d_AB (max-min-distance A B))
        (d_BA (max-min-distance B A)))
    (max d_AB d_BA)))

"hausdorff": questa è la funzione principale che calcola la distanza di Hausdorff.
Calcola 'd_AB' come il massimo delle distanze minime dal set A al set B e 'd_BA' come il massimo delle distanze minime dal set B al set A.
La distanza di Hausdorff è quindi il massimo di 'd_AB' e ' d_BA'.

Proviamo:

(hausdorff '(1 3 5 7) '(2 4 6 8))
;-> 1

(hausdorff '(3 6 12 8 4) '(4 5 9 8))
;-> 3

(hausdorff '(1 10 100) '(2 20 200))
;-> 100


--------------
Sequenza SUDSI
--------------

La sequenza SUDSI (somma, differenza, scambio, incremento) è una sequenza che può essere generata nel modo seguente:

Sia S una lista infinita di numeri naturali: 1 2 3 4 5 6 ...
Sia S(i) l'i-esimo elemento di S con un solo indice.
Inizialmente, S(1) è 1, S(2) è 2, ecc. (non esiste S(0)).

A partire da S(1) e S(2):
Calcolare la loro somma: somma = S(1) + S(2)
Calcolare la loro differenza assoluta: diff = |S(1) - S(2)|
Scambiare i due valori in S negli indici della somma e della differenza: swap(S(somma), S(diff))
Incrementare gli indici di S (quindi la prossima volta usiamo la somma e la differenza di S2 e S3, e la volta successiva useremo S3 e S4, ecc.)
Ripetere questo processo indefinitamente.

Esempio:

Lista S originale:
[1 2] 3 4 5 6 7 8 9 10 11 12 ...

Dopo che S3 (3 = 1 + 2) e S1 (1 = |1 - 2|) sono stati scambiati:
3 [2 1] 4 5 6 7 8 9 10 11 12 ...

Dopo che S3 e S1 sono stati scambiati:
1 2 [3 4] 5 6 7 8 9 10 11 12 ...

Dopo che S7 e S1 sono stati scambiati:
7 2 3 [4 5] 6 1 8 9 10 11 12 ...

Dopo che S9 e S1 sono stati scambiati:
9 2 3 4 [5 6] 1 8 7 10 11 12 ...

Dopo che S11 e S1 sono stati scambiati:
11 2 3 4 5 [6 1] 8 7 10 9 12 ...

Dopo che S7 e S5 sono stati scambiati:
11 2 3 4 1 6 [5 8] 7 10 9 12 ...
ecc.

Ecco i primi termini della sequenza SUDSI:

  1 3 1 7 9 11 11 11 15 15 19 19 19 19 19 19 19 19 19 19 19 19 19 19 19
  19 19 19 57 59 59 59 59 59 59 59 59 59 77 79 81 83 85 87 89 91 91 91
  91 91 91 91 91 91 91 91 91 91 115 115 121 123 125 127 127 127 127 127
  137 139 141 143 145 147 147 147 147 147 147 147 ...

Funzione che calcola la sequenza SUDSI fino ad un dato numero di termini:

(define (sudsi termini)
  (local (seq out counter idx a b sum diff)
    (setq seq (sequence 0 (* 2 termini)))
    (setq out '(1))
    (setq counter 1)
    (setq idx 1)
    (while (< counter termini)
      (setq a (seq idx))
      (setq b (seq (+ idx 1)))
      (setq diff (abs (- a b)))
      (setq sum (+ a b))
      (swap (seq diff) (seq sum))
      (push (seq 1) out -1)
      (++ idx)
      (++ counter)
    )
    out))

Proviamo:

(sudsi 100)
;-> (1 3 1 7 9 11 11 11 15 15 19 19 19 19 19 19 19 19 19 19 19 19 19 19
;->  19 19 19 19 57 59 59 59 59 59 59 59 59 59 77 79 81 83 85 87 89 91
;->  91 91 91 91 91 91 91 91 91 91 91 91 115 115 121 123 125 127 127 127
;->  127 127 137 139 141 143 145 147 147 147 147 147 147 147 147 147 147
;->  147 167 167 167 167 167 167 167 167 167 167 167 167 167 167 167 167)

La funzione è lenta perchè usa una lista.

(time (sudsi 1e4))
;-> 296.797
(time (sudsi 1e5))
;-> 30674.64

Proviamo con un vettore:

(define (sudsi1 termini)
  (local (seq out counter idx a b sum diff)
    (setq seq (array (+ (* 2 termini) 2) (sequence 0 (+ (* 2 termini) 1))))
    (setq out '(1))
    (setq counter 1)
    (setq idx 1)
    (while (< counter termini)
      (setq a (seq idx))
      (setq b (seq (+ idx 1)))
      (setq diff (abs (- a b)))
      (setq sum (+ a b))
      (swap (seq diff) (seq sum))
      (push (seq 1) out -1)
      (++ idx)
      (++ counter)
    )
    out))

(= (sudsi 100) (sudsi1 100))
;-> true

(time (sudsi1 1e4))
;-> 15.586
(time (sudsi1 1e5))
;-> 46.859
(time (sudsi1 1e6))
;-> 484.346


-------------------------
Effetto Schrodinger's cat
-------------------------

Scrivere una funzione che alla prima esecuzione esegue (con la stessa probabilità) una delle seguenti azioni:
1) legge caratteri da STDIN e li stampa su STDOUT indefinitamente (Ctrl-C per terminare)
2) restituisce nil e si ferma
Le successive esecuzioni della funzione devono sempre eseguire l'azione effettuata al primo lancio.

Il primo approccio è stato quello di scrivere una funzione che al primo lancio ridefisce la funzione stessa:

(define (cat)
  (local (choice)
    (setq choice (rand 2))
    (println choice)
    (cond ((zero? choice)
           (setq f "(define (cat) (while true (read-line)))")
           (eval-string f)
           (while true (read-line)))
          (true
           (setq f "(define (cat) nil)")
           (eval-string f)
           nil))))

Purtoppo newLISP va in crash quando si tenta di ridefinire la funzione in esecuzione:
(cat)
La REPl di newLISP...scompare.

Il secondo approccio è quello di usare una variabile globale (_schrodinger):

(define (cat)
  ; definisce la variabile solo la prima volta (quando vale nil)
  (if (nil? _schrodinger) (setq _schrodinger (rand 2)))
  (println _schrodinger)
  (cond
    ; prima azione
    ((zero? _schrodinger) (while true (read-line)))
    ; seconda azione
    (true nil)))

Proviamo:

(cat)
;-> 0
caratteri inseriti da tastiera
per uscire premere CTRL-C
;-> ERR: received SIGINT - in function read-line
;-> called from user function (cat)

Adesso "cat" esegue sempre la prima azione:

(cat)
;-> 0
...
;-> ERR: received SIGINT - in function read-line
;-> called from user function (cat)

(cat)
;-> 0
...
;-> ERR: received SIGINT - in function read-line
;-> called from user function (cat)

Per resettare il comportamento della funzione poniamo _schrodinger a nil:

(setq _schrodinger nil)

Eseguiamo di nuovo "cat" per la prima volta:

(cat)
;-> 1
;-> nil

Adesso "cat" esegue sempre la seconda azione:

(cat)
;-> 1
;-> nil

(cat)
;-> 1
;-> nil


----------------------------------
Funzioni booleane di due variabili
----------------------------------

Con due variabili booleane (binarie) A e B possiamo creare 16 funzioni diverse:

A B | a | b | c | d | e | f | g | h | i | j | k | l | m | n | o | p |
---------------------------------------------------------------------
0 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |
0 1 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 | 0 | 0 | 0 | 0 | 1 | 1 | 1 | 1 |
1 0 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 1 |
1 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 | 0 | 1 |

Vediamo le espressioni di queste 16 funzioni:


A B | a = (NOT (A OR B OR (NOT (A AND B)))) oppure (A AND (NOT A))
-------------------------------------------------------------------
0 0 | 0 |
0 1 | 0 |
1 0 | 0 |
1 1 | 0 |

| A B | b = (A AND B)
---------------------
| 0 0 | 0 |
| 0 1 | 0 |
| 1 0 | 0 |
| 1 1 | 1 |

A B | c = (A AND (NOT B)) oppure (A > B)
----------------------------------------
0 0 | 0 |
0 1 | 0 |
1 0 | 1 |
1 1 | 0 |

A B | d = (A)
-------------
0 0 | 0 |
0 1 | 0 |
1 0 | 1 |
1 1 | 1 |

A B | e = ((NOT A) AND B)) oppure (A < B)
-----------------------------------------
0 0 | 0 |
0 1 | 1 |
1 0 | 0 |
1 1 | 0 |

A B | f = (B)
-------------
0 0 | 0 |
0 1 | 1 |
1 0 | 0 |
1 1 | 1 |

A B | g = ((A AND (NOT B)) OR ((NOT A) AND B)) = (A XOR B)
----------------------------------------------------------
0 0 | 0 |
0 1 | 1 |
1 0 | 1 |
1 1 | 0 |

A B | h = (A OR B)
------------------
0 0 | 0 |
0 1 | 1 |
1 0 | 1 |
1 1 | 1 |

A B | i = (NOT (A OR B))
------------------------
0 0 | 1 |
0 1 | 0 |
1 0 | 0 |
1 1 | 0 |

A B | j = (NOT (A XOR B))
-------------------------
0 0 | 1 |
0 1 | 0 |
1 0 | 0 |
1 1 | 1 |

A B | k = (NOT B))
------------------
0 0 | 1 |
0 1 | 0 |
1 0 | 1 |
1 1 | 0 |

A B | l = (A OR (NOT B))
------------------------
0 0 | 1 |
0 1 | 0 |
1 0 | 1 |
1 1 | 1 |

A B | m = (NOT A)
-----------------
0 0 | 1 |
0 1 | 1 |
1 0 | 0 |
1 1 | 0 |

A B | n = ((NOT A) OR B)
------------------------
0 0 | 1 |
0 1 | 1 |
1 0 | 0 |
1 1 | 1 |

A B | o = (NOT (A AND B)) = NAND
--------------------------------
0 0 | 1 |
0 1 | 1 |
1 0 | 1 |
1 1 | 0 |

A B | l = (A OR B OR (NOT (A AND B))) oppure (A OR (NOT A))
-----------------------------------------------------------
0 0 | 1 |
0 1 | 1 |
1 0 | 1 |
1 1 | 1 |

(define (xor a b) (or (and a (not b)) (and (not a) b)))
(define (nand a b) (not (and a b)))


--------------------------------------------------
Tastiera QWERTY e stringhe con caratteri adiacenti
--------------------------------------------------

Data una stringa contenente solo caratteri alfabetici [A,B,C,...,Z], determinare se può essere scritta utilizzando solo tasti adiacenti di una tastiera QWERTY.

Costruiamo la lista associativa tra ogni tasto e i suoi caratteri adiacenti:

(setq keys '( ("Q" ("Q" "W" "A"))
              ("W" ("W" "Q" "A" "S" "E"))
              ("E" ("E" "W" "S" "D" "R"))
              ("R" ("R" "E" "D" "F" "T"))
              ("T" ("T" "R" "F" "G" "Y"))
              ("Y" ("Y" "T" "G" "H" "U"))
              ("U" ("U" "Y" "H" "J" "I"))
              ("I" ("I" "U" "J" "K" "O"))
              ("O" ("O" "I" "K" "L" "P"))
              ("P" ("P" "O" "L"))
              ("A" ("A" "Q" "Z" "W" "S"))
              ("S" ("S" "W" "A" "Z" "X" "D" "E"))
              ("D" ("D" "E" "S" "X" "C" "F" "R"))
              ("F" ("F" "R" "D" "C" "V" "G" "T"))
              ("G" ("G" "T" "F" "V" "B" "H" "Y"))
              ("H" ("H" "Y" "G" "B" "N" "J" "U"))
              ("J" ("J" "U" "H" "N" "M" "K" "I"))
              ("K" ("K" "I" "J" "M" "L" "O"))
              ("L" ("L" "O" "K" "P"))
              ("Z" ("Z" "A" "S" "X"))
              ("X" ("X" "S" "Z" "D" "C"))
              ("C" ("C" "D" "X" "F" "V"))
              ("V" ("V" "F" "C" "B" "G"))
              ("B" ("B" "G" "V" "N" "H"))
              ("N" ("N" "H" "B" "M" "J"))
              ("M" ("M" "J" "N" "K"))))

Scriviamo una funzione che scorre la stringa e verifica se ogni carattere è adiacente al precedente:

(define (typeable str)
  (if (< (length str) 2) true
  ;else
  (local (len cur-char stop)
    (setq str (upper-case str))
    (setq len (length str))
    (setq cur-char (str 0))
    (setq stop nil)
    (for (i 1 (- len 1) 1 stop)
      (if (nil? (ref cur-char (lookup (str i) keys))) (setq stop true))
      (setq cur-char (str i))
    )
    (not stop))))

Proviamo:

(typeable "")
;-> true
(typeable "s")
;-> true
(typeable "qwerty")
;-> true
(typeable "pollo")
;-> true
(typeable "newLISP")
;-> nil
(typeable "desertress")
;-> true
(typeable "qwertyuioplkjhgfdsazxcvbnm")
;-> true


---------------------------------------------------------
Sequenze di interi consecutivi che sommano ad un numero N
---------------------------------------------------------

Dato un numero N, determinare tutte le sequenza di numeri interi consecutivi che sommano a N.
Per esempio:

  N = 18
  sequenza1 = (5 6 7)   --> 5 + 6 + 7 = 18
  sequenza2 = (3 4 5 6) --> 3 + 4 + 5 + 6 = 18

(define (seq-somma N)
  (local (out somma end continua)
    (setq out '())
    ; Ciclo dal numero di partenza della sequenza...
    (for (base 1 (- N 1))
      ; calcola la somma iniziale
      (setq somma base)
      (setq end (+ base 1))
      (setq continua true)
      ; ciclo che aggiunge numneri consecutivi alla sequenza
      (while (and (< end N) continua)
      ; calcola la somma corrente
        (setq somma (+ somma end))
        ; verifica se la somma della sequenza vale N
        (if (= somma N) (push (sequence base end) out -1))
        ; se la somma supera N, allora passiamo ad una base successiva
        (if (> somma N) (setq continua nil))
        (++ end)
      )
    )
    out))

Proviamo:

(seq-somma 18)
;-> ((3 4 5 6) (5 6 7))

(seq-somma 1000)
;-> ((28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52) (55
;->   56 57 58 59 60 61 62 63 64 65 66 67 68 69 70)
;->  (198 199 200 201 202))

Vediamo la velocità:

(time (seq-somma 1000) 1000)
;-> 763.102

Possiamo utilizzare un approccio matematico.
La somma di una sequenza di numeri consecutivi x, x+1, x+2, ..., x+k-1 può essere espressa come:

  S = (k/2)*(2x + k - 1)

dove S = N e k è la lunghezza della sequenza.

Per risolvere il problema eseguiamo questi passaggi:
1. Trovare tutte le possibili lunghezze k della sequenza.
2. Per ogni k, verificare se esiste un x tale che la sequenza somma a N:
   in tal caso aggiungere la sequenza trovata alla soluzione.

(define (seq-sum N)
  (local (out x seq)
    (setq out '())
    ; ciclo per ogni k
    (dotimes (k (int (sqrt (* 2 N))))
      (let (k (inc k))
        ; calcolo della x
        ; utilizzando la formula derivata dalla somma aritmetica
        (setq x (/ (- (* 2 N) (* k (- k 1))) (* 2 k)))
        ; x è intero e maggiore di 0 ?
        (when (and (= x (int x)) (> x 0))
          ; costruzione della sequenza
          (setq seq (sequence x (+ x (dec k))))
          ; verifica se la sequenza somma a N
          (when (and (= (apply + seq) N) (> (length seq) 1))
            (push seq out)))))
    out))

Nota:
(dotimes (k 5) (print k { }))
;-> 0 1 2 3 4
(dotimes (k 5) (setq k 3) (print k { }))
;-> 3 3 3 3 3 ; perchè sono due 'k' diversi!!

Proviamo:

(seq-sum 18)
;-> ((3 4 5 6) (5 6 7))

(seq-sum 1000)
;->((28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52)
;-> (55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70)
;-> (198 199 200 201 202))

Vediamo se le due funzioni producono gli stessi risultati fino a N=10000:

(for (i 1 10000) (if (!= (seq-sum i) (seq-somma i)) (println i)))
;-> nil

Vediamo la velocità:

(time (seq-sum 1000) 1000)
;-> 39.747

La funzione "seq-sum" è circa 20 volte più veloce di "seq-somma".

Vediamo quante sequenze sono associate ad ogni numero.

Sequenza OEIS: A069283
Number of nontrivial ways to write n as sum of at least 2 consecutive integers.
a(n) = -1 + number of odd divisors of n.
  0, 0, 0, 1, 0, 1, 1, 1, 0, 2, 1, 1, 1, 1, 1, 3, 0, 1, 2, 1, 1, 3, 1, 1,
  1, 2, 1, 3, 1, 1, 3, 1, 0, 3, 1, 3, 2, 1, 1, 3, 1, 1, 3, 1, 1, 5, 1, 1,
  1, 2, 2, 3, 1, 1, 3, 3, 1, 3, 1, 1, 3, 1, 1, 5, 0, 3, 3, 1, 1, 3, 3, 1,
  2, 1, 1, 5, 1, 3, 3, 1, 1, 4, 1, 1, 3, 3, 1, 3, 1, 1, 5, 3, 1, 3, 1, 3,
  1, 1, 2, 5, 2, ...

(define (seq-count N)
  (local (out conta x seq)
    (setq out '())
    (setq conta 0)
    ; ciclo per ogni k
    (dotimes (k (int (sqrt (* 2 N))))
      (let (k (inc k))
        ; calcolo della x
        ; utilizzando la formula derivata dalla somma aritmetica
        (setq x (/ (- (* 2 N) (* k (- k 1))) (* 2 k)))
        ; x è intero e maggiore di 0 ?
        (when (and (= x (int x)) (> x 0))
          ; costruzione della sequenza
          (setq seq (sequence x (+ x (dec k))))
          ; verifica se la sequenza somma a N
          (when (and (= (apply + seq) N) (> (length seq) 1))
            (++ conta)))))
    conta))

Proviamo:

(seq-count 1000)
;-> 3

(map seq-count (sequence 0 100))
;-> (0 0 0 1 0 1 1 1 0 2 1 1 1 1 1 3 0 1 2 1 1 3 1 1
;->  1 2 1 3 1 1 3 1 0 3 1 3 2 1 1 3 1 1 3 1 1 5 1 1
;->  1 2 2 3 1 1 3 3 1 3 1 1 3 1 1 5 0 3 3 1 1 3 3 1
;->  2 1 1 5 1 3 3 1 1 4 1 1 3 3 1 3 1 1 5 3 1 3 1 3
;->  1 1 2 5 2)

Verifichiamo il risultato calcolando la sequenza utilizzando il numero di divisori di N:

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

Funzione che trova i divisori dispari di un numero:

(define (odd-divisors divisori) (filter odd? divisori))

Proviamo:

(odd-divisors (divisors 90))
;-> (1 3 5 9 15 45)

(map (fn(x) (- (length (odd-divisors (divisors x))) 1)) (sequence 1 100))
;-> (  0 0 1 0 1 1 1 0 2 1 1 1 1 1 3 0 1 2 1 1 3 1 1 
;->  1 2 1 3 1 1 3 1 0 3 1 3 2 1 1 3 1 1 3 1 1 5 1 1
;->  1 2 2 3 1 1 3 3 1 3 1 1 3 1 1 5 0 3 3 1 1 3 3 1
;->  2 1 1 5 1 3 3 1 1 4 1 1 3 3 1 3 1 1 5 3 1 3 1 3
;->  1 1 2 5 2)

Le sequenze sono uguali (a parte il primo valore per N = 0 che nel coso dei divisori non viene calcolato).

Per completezza riportiamo la sequenza dei divisori dispari dei numeri interi:

Sequenza OEIS: A001227
Number of odd divisors of n.
Number of partitions of n into consecutive positive integers including the trivial partition of length 1 (the number itself).
a(n) = d(n) if n is odd, 
    or d(n) - d(n/2) if n is even,
where d(n) is the number of divisors of n.
  1, 1, 2, 1, 2, 2, 2, 1, 3, 2, 2, 2, 2, 2, 4, 1, 2, 3, 2, 2, 4, 2, 2,
  2, 3, 2, 4, 2, 2, 4, 2, 1, 4, 2, 4, 3, 2, 2, 4, 2, 2, 4, 2, 2, 6, 2,
  2, 2, 3, 3, 4, 2, 2, 4, 4, 2, 4, 2, 2, 4, 2, 2, 6, 1, 4, 4, 2, 2, 4,
  4, 2, 3, 2, 2, 6, 2, 4, 4, 2, 2, 5, 2, 2, 4, 4, 2, 4, 2, 2, 6, 4, 2,
  4, 2, 4, 2, 2, 3, 6, 3, 2, 4, 2, 2, 8, ...


----------------------------------------
Calcolo di pi greco con il metodo spigot
----------------------------------------

Per generare un numero arbitrario di cifre di pi greco usiamo l'algoritmo presentato nel seguente articolo:

"Unbounded Spigot Algorithms for the Digits of Pi" di Jeremy Gibbons

https://www.cs.ox.ac.uk/jeremy.gibbons/publications/spigot.pdf

Programma originale:

> piG3 = g(1,180,60,2) where
>   g(q,r,t,i) = let (u,y)=(3*(3*i+1)*(3*i+2),div(q*(27*i-12)+5*r)(5*t))
>                in y : g(10*q*i*(2*i-1),10*u*(q*(5*i-2)+r-y*t),t*u,i+1)

Versione newLISP:

(define (pi-spigot digits)
  (local (d q r t i u y)
    (setq d 0)
    (set 'q 1L 'r 180L 't 60L 'i 2L)
    (while (< d digits)
      (setq u (+ (* 27L i (+ i 1L)) 6L))
      (setq y (/ (+ (* q (- (* 27L i) 12L)) (* 5L r)) (* 5L t)))
      ;(println u { } y)
      (print (+ 0 y))
      (setq r (* (* 10L u) (- (+ (* q (- (* 5L i) 2L)) r) (* y t))))
      (setq q (* 10L q i (- (* 2L i) 1L)))
      (setq t (* t u))
      (setq i (+ i 1))
      ;(print q { } r { } t { } i) (read-line)
      (++ d))))

Proviamo:

(pi-spigot 20)
;-> 3141592653589793238420

(pi-spigot 1000)
;-> 314159265358979323846264338327950288419716939937510582097494459230781640
;-> 628620899862803482534211706798214808651328230664709384460955058223172535
;-> 940812848111745028410270193852110555964462294895493038196442881097566593
;-> 344612847564823378678316527120190914564856692346034861045432664821339360
;-> 726024914127372458700660631558817488152092096282925409171536436789259036
;-> 001133053054882046652138414695194151160943305727036575959195309218611738
;-> 193261179310511854807446237996274956735188575272489122793818301194912983
;-> 367336244065664308602139494639522473719070217986094370277053921717629317
;-> 675238467481846766940513200056812714526356082778577134275778960917363717
;-> 872146844090122495343014654958537105079227968925892354201995611212902196
;-> 086403441815981362977477130996051870721134999999837297804995105973173281
;-> 609631859502445945534690830264252230825334468503526193118817101000313783
;-> 875288658753320838142061717766914730359825349042875546873115956286388235
;-> 37875937519577818577805321712268066130019278766111959092164201981000

Vedi anche "Calcolo di e con il metodo spigot" su "Funzioni varie".


-----------------------------------
Fissione totale di un numero intero
-----------------------------------

La fissione F di un numero N è la sequenza del maggior numero di interi positivi consecutivi che si sommano a N.

Per esempio per N = 18 abbiamo:

  18 = 3 + 4 + 5 + 6  (sequenza con 4 termini)
e 
  18 =5 + 6 + 7 (sequenza con 3 termini)

Quindi F(18) = (3 4 5 6).

Per N = 10:

  10 = 1 + 2 + 3 + 4  -->  F(10) = (1 2 3 4)

La fissione totale FT di un numero N è la fissione F applicata prima a N e  poi ricorsivamente a tutti i numeri generati dalle fissioni precedenti.
In altre parole, per un intero positivo N, trovare il maggior numero di interi positivi consecutivi (almeno 2) che si sommano a N. Per ognuno di questi fare lo stesso... ripetere fino al completamento.

Vediamo alcuni esempi:

a(10) = 7 perché ci sono 7 numeri generati dall'iterazione:

         10
          | 
    +-----------+
    |   |   |   |
    1   2   3   4
           / \
          1   2

a(24) = 13 perché ci sono 13 numeri generati dall'iterazione:

          24
          /|\
         / | \
        /  |  \
       7   8   9
      / \     /|\
     3   4   / | \
    / \     /  |  \
   1   2   2   3   4
              / \
             1   2
             
a(23) = 23 perché ci sono 23 numeri generati dall'iterazione:

                  23
                  /\
                 /  \
                /    \
               /      \
              /        \
             /          \
            /            \
          11             12
          /\             /|\
         /  \           / | \
        /    \         /  |  \
       /      \       3   4   5
      /        \     / \     / \
     5          6   1   2   2   3
    / \        /|\             / \
   2   3      / | \           1   2
      / \    /  |  \
     1   2  1   2   3
                   / \
                  1   2

Sequenza OEIS: A256504
Summative Fission - For a positive integer n, find the greatest number of consecutive positive integers (at least 2) which add to n. For each of these do the same ... iterate to completion. 
a(n) = the total number of integers (including n itself) defined.
  0, 1, 1, 3, 1, 5, 6, 5, 1, 6, 7, 12, 10, 12, 11, 12, 1, 8, 16, 14, 17,
  18, 18, 23, 13, 21, 18, 22, 23, 24, 19, 14, 1, 22, 20, 23, 24, 31, 27,
  25, 26, 36, 28, 37, 29, 30, 42, 37, 22, 32, 37, 38, 35, 41, 36, 37, 43,
  42, 37, 44, 44, 34, 33, 47, 1, 48, 49, 43, 53, ...

Funzione che calcola la sequenza di numeri consecutivi più lunga che somma a N:
(cioè calcola la fissione di un numero N)
;(define (seq-sum-max-length N)
(define (fission N)
  (local (max-length best-seq x seq)
    (setq max-length 0)
    (setq best-seq '())
    ; ciclo per ogni k
    (dotimes (k (int (sqrt (* 2 N))))
      (let (k (inc k))
        ; calcolo della x
        ; utilizzando la formula derivata dalla somma aritmetica
        (setq x (/ (- (* 2 N) (* k (- k 1))) (* 2 k)))
        ; x è intero e maggiore di 0 ?
        (when (and (= x (int x)) (> x 0))
          ; costruzione della sequenza
          (setq seq (sequence x (+ x (dec k))))
          ; verifica se la sequenza somma a N e controlla la sua lunghezza
          (when (and (= (apply + seq) N) (> (length seq) max-length))
                (set 'max-length (length seq))
                (set 'best-seq seq)))))
    best-seq))

Proviamo:

(fission 0)
(fission 23)
;-> (11 12)
(fission 12)
;-> (3 4 5)
(fission 11)
;-> (5 6)
(fission 1)
;-> (1)
(fission 9)
;-> (2 3 4)

Funzione che calcola la fissione totale di un numero N:

(define (fission-total num)
  (local (total)
  (setq total (list num))
  ; lista dei numeri a cui applicare 'fission'
  (setq seq (fission num))
  (cond ((= num 0) '()) ; 0 non ha fissione
        ((= (length seq) 1) (list num)) ; fissione lunga 1
        (true
          ; ciclo sulla lista dei numeri a cui applicare 'fission'
          (until (= seq '())
            ; estrae il primo numero dalla lista (numero corrente)
            (setq cur-num (pop seq))
            ; calcola la fissione del numero corrente
            (setq cur-fission (fission cur-num))
            (cond 
              ; se la fissione produce una lista con lo stesso numero...
              ((= (length cur-fission) 1)
                    ; allora aggiungo il numero alla lista totale
                    (push cur-num total -1))
              ; se la fissione produce una lista con più di un numero...                    
                  ((> (length cur-fission) 1)
                    ; allora aggiungo il numero alla lista totale
                    (push cur-num total -1)
                    ; e aggiungo la fissione corrente alla lista 'seq'
                    (extend seq cur-fission))
            )
          )
          total))))

Proviamo:

(fission-total 0)
;-> ()
(fission-total 10)
;-> (10 1 2 3 4 1 2)
(fission-total 23)
;-> (23 11 12 5 6 3 4 5 2 3 1 2 3 1 2 2 3 1 2 1 2 1 2)
(fission-total 24)
;-> (24 7 8 9 3 4 2 3 4 1 2 1 2) 

Calcoliamo la sequenza OEIS:

(define (A256504 num)
  (map (fn(x) (length (fission-total x))) (sequence 0 num)))

(A256504 70)
;-> (0 1 1 3 1 5 6 5 1 6 7 12 10 12 11 12 1 8 16 14 17
;->  18 18 23 13 21 18 22 23 24 19 14 1 22 20 23 24 31 27
;->  25 26 36 28 37 29 30 42 37 22 32 37 38 35 41 36 37 43
;->  42 37 44 44 34 33 47 1 48 49 43 53 59 54)


-----------------
Sequenze annidate
-----------------

Scrivere una funzione che genera una sequenza di numeri interi consecutivi annidati da 'a' a 'b'.
La funzione primitiva "sequence" (a=1 e b=5) genera una lista di interi consecutivi:

(sequence 1 5)
;-> (1 2 3 4 5)

Invece la nostra funzione deve generare la lista annidata:

  (1 (2 (3 (4 (5)))))

La funzione deve essere in grado di trattare numeri interi positivi e/o negativi per i seguenti casi:

1) a = b
2) a > b
3) a < b

Funzione che genera una lista annidata di numeri consecutivi:

(define (nested-range a b)
  (cond
    ((= a b) (list a))
    ((< a b) (let (x (list b)) (for (k (- b 1) a) (setq x (list k x)))))
    ((> a b) (let (x (list b)) (for (k (+ b 1) a) (setq x (list k x)))))))

oppure

(define (nested-range a b)
    (if (< a b) (setq s (- b 1)))
    (if (> a b) (setq s (+ b 1)))
    (if (= a b)
        (list a)
        (let (x (list b)) (for (k s a) (setq x (list k x))))))

Proviamo:

(nested-range 0 0)
;-> (0)
(nested-range 2 2)
;-> (2)
(nested-range 2 3)
;-> (2 (3))
(nested-range 3 2)
;-> (3 (2))
(nested-range 1 5)
;-> (1 (2 (3 (4 (5)))))
(nested-range 5 -1)
;-> (5 (4 (3 (2 (1 (0 (-1)))))))
(nested-range -3 -1)
;-> (-3 (-2 (-1)))
(nested-range -3 4)
;-> (-3 (-2 (-1 (0 (1 (2 (3 (4))))))))
(nested-range 3 -4)
;-> (3 (2 (1 (0 (-1 (-2 (-3 (-4))))))))
(nested-range -1 -5)
;-> (-1 (-2 (-3 (-4 (-5)))))
(nested-range -5 -1)
;-> (-5 (-4 (-3 (-2 (-1)))))


-------------------
Numeri scacchistici
-------------------

Un numero scacchistico è un numero in base 10 che, quando convertito in base 18, risulta in una coppia di coordinate scacchistiche valida, dove il primo carattere è A,B,C,...,H e il secondo carattere è [1..8].
Scrivere una funzione che genera tutti i numeri scacchistici come coppie:

  (n10(1) n18(1)) (n10(2) n18(2)) ... (n10(64) n18(64))

(define (baseN-base10 number-string base)
"Convert a number from base N (<=62) to base 10"
  (let ((charset "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (result 0)
        (len (length number-string)))
    (dolist (digit (explode number-string))
      (setq result (+ (* result base) (find digit charset)))
    )
    result))

(baseN-base10 "A1" 18)
;-> 181
(baseN-base10 "H8" 18)
;-> 314

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

Funzione che trova tutti i numeri scacchistici:

(define (chess-numbers)
  (let (out '())
    (for (i 181 314)
      (setq b18 (base10-baseN i 18))
      (if (and (>= (b18 0) "A") (<= (b18 0) "H")
               (>= (b18 1) "1") (<= (b18 1) "8"))
          (push (list (base10-baseN i 18) i) out -1)))
    out))

Proviamo:

(chess-numbers)
;-> (("A1" 181) ("A2" 182) ("A3" 183) ("A4" 184) ("A5" 185) ("A6" 186) 
;->  ("A7" 187) ("A8" 188) ("B1" 199) ("B2" 200) ("B3" 201) ("B4" 202)
;->  ("B5" 203) ("B6" 204) ("B7" 205) ("B8" 206) ("C1" 217) ("C2" 218)
;->  ("C3" 219) ("C4" 220) ("C5" 221) ("C6" 222) ("C7" 223) ("C8" 224)
;->  ("D1" 235) ("D2" 236) ("D3" 237) ("D4" 238) ("D5" 239) ("D6" 240)
;->  ("D7" 241) ("D8" 242) ("E1" 253) ("E2" 254) ("E3" 255) ("E4" 256)
;->  ("E5" 257) ("E6" 258) ("E7" 259) ("E8" 260) ("F1" 271) ("F2" 272)
;->  ("F3" 273) ("F4" 274) ("F5" 275) ("F6" 276) ("F7" 277) ("F8" 278)
;->  ("G1" 289) ("G2" 290) ("G3" 291) ("G4" 292) ("G5" 293) ("G6" 294)
;->  ("G7" 295) ("G8" 296) ("H1" 307) ("H2" 308) ("H3" 309) ("H4" 310)
;->  ("H5" 311) ("H6" 312) ("H7" 313) ("H8" 314))

(length (chess-numbers))
;-> 64


--------------------
Il gioco della Morra
--------------------

La Morra è un antico gioco tradizionale che consiste nell'indovinare la somma dei numeri che vengono mostrati con le dita dai giocatori.
Simultaneamente due giocatori tendono il braccio mostrando il pugno oppure stendendo un numero di dita a scelta, mentre gridano un numero da due a dieci (il "pugno" equivale all'uno e il dieci è anche chiamato proprio "morra").
Il giocatore che indovina la somma conquista il punto. Se entrambi i giocatori indovinano la somma il gioco continua e nessuno guadagna il punto. 
Il gioco finisce quando un giocatore raggiunge il punteggio deciso a priori.
La Morra può essere giocata anche con più di due giocatori.

Funzione che inizia una nuova partita:

(define (new-game punteggio)
  ; turni giocati
  (setq turni 0)
  ; punteggio da raggiungere
  (setq punti punteggio)
  ; punteggi dei due giocatori
  (setq p1 0)  ; human
  (setq p2 0)
  (println "Morra ("punti")")
  '>) ; computer

Funzione che effettua un turno di una partita:

(define (morra num-hu somma-hu)
  (local (num-pc somma vmin vmax somma-pc t)
    (++ turni)
    ; numero proposto dal computer
    (setq num-pc (+ (rand 5) 1))
    ; valore della somma dei due numeri proposti 
    (setq somma (+ num-hu num-pc))
    ; Strategia del computer
    ; valore minimo della somma proposta dal computer
    (setq vmin (+ num-pc 1))
    ; valore massimo della somma proposta dal computer
    (setq vmax (+ num-pc 5))
    ; valore della somma proposta dal computer (vmin <= somma-pc <= vmax)
    (setq somma-pc (+ vmin (rand (+ (- vmax vmin) 1))))
    ; To count the frequency of values (1 2 3 4 5) this funtion must return:
    ; (- somma-pc num-pc)
    ; and then (count '(1 2 3 4 5) (collect (morra) 1e6))
    ; Verifica dell'esito del turno
    (setq t nil)
    (cond 
      ((and (= somma somma-pc) (= somma somma-hu)) (setq t 0))
      ((= somma somma-hu) (++ p1) (setq t 1))
      ((= somma somma-pc) (++ p2) (setq t 2))
      (true (setq t 3))
    )
    ; Stampa situazione corrente del gioco
    (println "TURNO " turni)
    (println "Somma: " somma)
    (println "Umano: " num-hu { } somma-hu)
    (println "Computer: " num-pc { } somma-pc)
    (cond ((= t 0) (println "Turno patto (entrambi hanno indovinato)"))
          ((= t 1) (println "Turno vinto dall'umano"))
          ((= t 2) (println "Turno vinto dal computer"))
          ((= t 3) (println "Turno nullo (entrambi hanno sbagliato)" ))
    )
    (println "Punteggio: ")
    (println "Umano: " p1 "  ---  Computer: " p2)
    (if (>= p1 punti) (println "L'umano ha vinto la partita"))
    (if (>= p2 punti) (println "Il computer ha vinto la partita"))
    '>))

Facciamo una partita:

(new-game 2)
;-> Morra (2)

(morra 4 7)
;-> TURNO 1
;-> Somma: 6
;-> Umano: 4 7
;-> Computer: 2 5
;-> Turno nullo (entrambi hanno sbagliato)
;-> Punteggio:
;-> Umano: 0  ---  Computer: 0

(morra 3 8)
;-> TURNO 2
;-> Somma: 5
;-> Umano: 3 8
;-> Computer: 2 5
;-> Turno vinto dal computer
;-> Punteggio:
;-> Umano: 0  ---  Computer: 1

(morra 2 5)
;-> TURNO 3
;-> Somma: 5
;-> Umano: 2 5
;-> Computer: 3 8
;-> Turno vinto dall'umano
;-> Punteggio:
;-> Umano: 1  ---  Computer: 1

(morra 2 6)
;-> TURNO 4
;-> Somma: 7
;-> Umano: 2 6
;-> Computer: 5 10
;-> Turno nullo (entrambi hanno sbagliato)
;-> Punteggio:
;-> Umano: 1  ---  Computer: 1

...
...

(morra 1 5)
;-> TURNO 8
;-> Somma: 6
;-> Umano: 1 5
;-> Computer: 5 6
;-> Turno vinto dal computer
;-> Punteggio:
;-> Umano: 1  ---  Computer: 2
;-> Il computer ha vinto la partita


-----------------
Sequenza di Stohr
-----------------

La sequenza di Stohr viene definita nel modo seguente:

 S(0) = 1
 S(n) = è il numero più piccolo che non può essere espresso come somma di due elementi distinti contenuti nella sequenza.

Vediamo come viene costruita:

n = 0
S = (1)

n = 1
Numero corrente = 2
Somma di tutte le coppie di S: somme = () (non esistono coppie in S)
Il 2 non si trova in somme quindi lo aggiungiamo a S.
S = (1 2)

n = 2
Numero corrente = 3
Somma di tutte le coppie di S: somme = (3)
Il 3 si trova in somme quindi non lo aggiungiamo a S e incrementiamo il numero corrente.
numero corrente = 4
Somma di tutte le coppie di S: somme = (3)
Il 4 non si trova in somme quindi lo aggiungiamo a S.
S = (1 2 4)

n = 3
Numero corrente = 5
Somma di tutte le coppie di S: somme = (3 5 6)
Il 5 si trova in somme quindi non lo aggiungiamo a S e incrementiamo il numero corrente.
numero corrente = 6
Somma di tutte le coppie di S: somme = (3 5 6)
Il 6 si trova in somme quindi non lo aggiungiamo a S e incrementiamo il numero corrente.
numero corrente = 7
Somma di tutte le coppie di S: somme = (3 5 6)
Il 7 non si trova in somme quindi lo aggiungiamo a S.
S = (1 2 4 7)

n = 4
Numero corrente = 8
Somma di tutte le coppie di S: somme = (3 5 8 6 9 11)
L'8 si trova in somme quindi non lo aggiungiamo a S e incrementiamo il numero corrente.
numero corrente = 9
Somma di tutte le coppie di S: somme = (3 5 8 6 9 11)
Il 9 si trova in somme quindi non lo aggiungiamo a S e incrementiamo il numero corrente.
numero corrente = 10
Somma di tutte le coppie di S: somme = (3 5 8 6 9 11)
Il 10 non si trova in somme quindi lo aggiungiamo a S.
S = (1 2 4 7 10)

ecc.

Sequenza OEIS: A033627
0-additive sequence: not the sum of any previous pair.
  1, 2, 4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52,
  55, 58, 61, 64, 67, 70, 73, 76, 79, 82, 85, 88, 91, 94, 97, 100, 103,
  106, 109, 112, 115, 118, 121, 124, 127, 130, 133, 136, 139, 142, 145,
  148, 151, 154, 157, 160, 163, 166, 169, 172, 175, ...

Funzione che caclola tutte le somme tra le coppie di elementi di una lista:

(define (pair-sums lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (+ (lst i) (lst j)) out -1)))))

(pair-sums '(1 2))
;-> 3
(pair-sums '(1 2 4 7))
;-> (3 5 8 6 9 11)

Con le liste la funzione è lenta:

(define (stohr limit)
  (local (out cur-num)
    (setq out '(1 2))
    (setq k 2)
    (setq cur-num 3)
    (while (< k limit)
      (setq somme (pair-sums out))
      (while (ref cur-num somme) (++ cur-num))
      (push cur-num out -1)
      (++ cur-num)
      (++ k)
    )
    out))

Proviamo:

(stohr 10)
;-> (1 2 4 7 10 13 16 19 22 25)
(time (stohr 200))
;-> 281.147
(time (stohr 300))
;-> 1172.002

Allora usiamo un vettore:

(define (stohr limit)
  (local (out cur-num)
    (setq out '(1 2))
    (setq k 2)
    (setq cur-num 3)
    (while (< k limit)
      (setq somme (pair-sums (array (length out) out)))
      (while (ref cur-num somme) (++ cur-num))
      (push cur-num out -1)
      (++ cur-num)
      (++ k)
    )
    out))

Proviamo:

(stohr 10)
;-> (1 2 4 7 10 13 16 19 22 25)
(time (stohr 200))
;-> 120
(time (stohr 300))
;-> 420.87

Questa seconda funzione è un pò più veloce, ma possiamo utilizzare una formula.
A parte i primi due termini della sequenza (1 e 2), tutti gli altri termini hanno una differenza pari a 3 tra un numero e il suo successivo.
Con il metodo alle differenze finit possiamo trovare che:

  a(n) =  (3*n - 5)

(define (stohr-formula N)
  (let (out '(1 2))
  (extend out (map (fn(x) (- (* 3 x) 5)) (sequence 3 N)))))

Proviamo:
(stohr-formula 10)
;-> (1 2 4 7 10 13 16 19 22 25)

(stohr-formula 70)
;-> (1 2 4 7 10 13 16 19 22 25 28 31 34 37 40 43 46 49 52 55 58 61 64 67 
;->  70 73 76 79 82 85 88 91 94 97 100 103 106 109 112 115 118 121 124 127
;->  130 133 136 139 142 145 148 151 154 157 160 163 166 169 172 175 178 181
;->  184 187 190 193 196 199 202 205)

(time (stohr-formula 1e3))
;-> 0
(time (stohr-formula 1e6))
;-> 124.963


-----------------------------------------------------------------
Rappresentare un numero intero N come prodotto di M numeri interi
-----------------------------------------------------------------

Dati due interi N e M elencare in quali modi N può essere espresso come prodotto di M interi.
Ogni termine dei prodotti deve essere maggiore di 1.

Funzione che genera tutte le combinazioni di M numeri che, moltiplicati insieme, danno N:

Algoritmo:

Funzione principale 'prodotti':
   - Prende due parametri: N (il numero da esprimere come prodotto) e M (il numero di fattori).
   - Chiama una funzione ausiliaria 'prodotti-aux' con i parametri N, M e 'start' inizializzato a 1.

Funzione ausiliaria 'prodotti-aux':
   - Questa funzione viene chiamata ricorsivamente per generare tutte le combinazioni.
   - Quando 'm' è 0, controllia se 'n' è 1.
     Se 'n' è 1, restituisce una lista che contiene una lista vuota ''(())', che rappresenta una combinazione valida (nessun numero moltiplicato per dare 1).
     Se 'n' non è 1, restituisce una lista vuota ''(())' per indicare che non ci sono combinazioni valide.
   - Altrimenti, itera su tutti i numeri da 'start' a n. Per ogni numero i:
     - Controlla se i è un divisore di n.
     - Chiama ricorsivamente 'prodotti-aux' con n diviso per i, m decrementato di 1, e 'start' impostato a 2 (per trovare tutte le combinazioni).
     - Unisce 'i' con i risultati delle chiamate ricorsive per formare le combinazioni complete.

(define (prodotti N M)
  ; il termine 2 serve per evitare 1 nei prodotti
  (prodotti-aux N M 2))

Funzione ausiliaria:

(define (prodotti-aux n m start)
  (cond
    ((= m 0)
      (if (= n 1) '(()) '()))
    (true
      (let (result '())
        (for (i start n)
          (when (and (>= (/ n i) 1) (= (mod n i) 0) (> i 1))
            (let ((partial (prodotti-aux (/ n i) (- m 1) 2)))
              (dolist (s partial) (push (cons i s) result)))))
        result))))

Proviamo:

(prodotti 12 3)
;-> ((3 2 2) (2 2 3) (2 3 2))
(prodotti 30 2)
;-> ((15 2) (10 3) (6 5) (5 6) (3 10) (2 15))
(prodotti 30 3)
;-> ((5 2 3) (5 3 2) (3 2 5) (3 5 2) (2 3 5) (2 5 3))
(prodotti 15 4)
;-> ()

La funzione genera tutti i prodotti (anche le permutazioni).
Se vogliamo solo i prodotti univoci allora possiamo ordinare i prodotti e poi usare la funzione "unique":

(define (prodotti-unici N M) (unique (map sort (prodotti N M))))

Proviamo:

(prodotti-unici 12 3)
;-> (2 2 3)
(prodotti-unici 30 2)
;-> ((2 15) (3 10) (5 6))
(prodotti-unici 30 3)
;-> ((2 3 5))
(prodotti-unici 15 4)
;-> ()

(prodotti 2310 4)
;-> ((77 2 5 3) (77 2 3 5) (77 3 5 2) (77 3 2 5) (77 5 3 2) (77 5 2 3) (55 2 7 3)
;-> ...
;-> (2 33 5 7) (2 35 11 3) (2 35 3 11) (2 55 7 3) (2 55 3 7) (2 77 5 3) (2 77 3 5))
(length (prodotti 2310 4))
;-> 240
(prodotti-unici 2310 4)
;-> ((2 3 5 77) (2 3 7 55) (2 3 11 35) (2 5 7 33) (3 5 7 22) 
;->  (2 5 11 21) (2 7 11 15) (3 5 11 14) (3 7 10 11) (5 6 7 11))
(length (prodotti-unici 2310 4))
;-> 10

(time (prodotti 2310 4) 100)
;-> 243.376
(time (prodotti-unici 2310 4) 100)
;-> 253.352

Adesso un pò di stress-test:

(setq num (* 1 2 3 4 5 6 7))
;-> 5040
(length (prodotti num 7))
;-> 3675
100 ripetizioni della funzione:
(time (prodotti num 7) 100)
;-> 6062.786
(time (prodotti-unici num 7) 100)
;-> 6361.016

(setq num (* 1 2 3 4 5 6 7 8))
;-> 40320
(length (prodotti num 8))
;-> 145384
Solo 1 ripetizione della funzione:
(time (prodotti num 8))
;-> 3456.783
(time (prodotti-unici num 8))
;-> 4875.954

(setq num (* 1 2 3 4 5 6 7 8 9))
;-> 362880
;(length (prodotti num 9))
(time (setq p9 (prodotti num 9)))
;-> 165951.457
(length p9)
;-> 4261086
Quanto incide la creazione di prodotti unici:
(time (setq p9u (unique (map sort p9))))
;-> 15365.934


----------------------------------
Da stringa a binario (e viceversa)
----------------------------------

Per convertire una stringa in binario occorre per ogni carattere:
1) trovare il codice ASCII
2) convertire questo codice in binario

(setq s "Hello newLISP!")

Funzione che converte una stringa in binario:

(define (string-binary str)
  (map (fn(x) (bits (char x))) (explode str)))

(string-binary s)
;-> ("1001000" "1100101" "1101100" "1101100" "1101111" "100000" "1101110"
;->  "1100101" "1110111" "1001100" "1001001" "1010011" "1010000" "100001")

Funzione che converte un binario in una stringa:

(define (binary-string lst)
  (join (map (fn(x) (char (int x 0 2))) lst)))

(binary-string (string-binary s))
;-> "Hello newLISP!"


-----------------------------
Compito di selezione di Wason
-----------------------------

Si tratta di un test che mira a verificare la nostra capacità di cognizione condizionale, cioè a riflettere sulla correlazione "se... allora".
Ai partecipanti vengono mostrate quattro carte:

la prima mostra una A,
la seconda una K,
le terza un 4
la quarta un 7.

Il compito consiste nel verificare che le carte rispettino la seguente regola:

"Se la carta mostra una consonante su una faccia, allora sulla faccia opposta c'è un numero dispari".

Inoltre tale verifica deve avvenire sollevando il minor numero di carte.

Vediamo la soluzione.
La maggior parte dei partecipanti al test decide di girare le carte K e 7.
Ma è sbagliato: la soluzione corretta sarebbe girare le carte K e 4, poiché solo una consonante sul rovescio di un numero pari può dimostrare se la regola postulata è valida (nello specifico, confutandola).
Il fatto che sia presente una consonante sul retro di 7 è irrilevante per verificare la verità della regola (essa infatti non recita: "solo" se c'è una consonante sul retro, allora può esserci un numero dispari sul fronte).
Pochissimi non commettono questo errore, perché siamo tutti vittime della nostra tendenza al pregiudizio di conferma (bias di conferma) e in genere non siamo particolarmente propensi a riflettere su proposizioni condizionali astratte (che non hanno alcuna rilevanza immediata nel mondo reale) che ci circonda. 

Se il contenuto del test viene modificato inserendo un riferimento alla violazione di regole sociali (cioè, se al posto di consonanti e numeri vengono introdotte norme e azioni umane), allora difficilmente sbagliamo.
Supponiamo che il compito consista ora nel verificare la seguente regola:
"Se una persona beve alcolici, allora deve avere più di 18 anni"
e le carte disponibili siano:

1) beve alcolici, 
2) non beve alcolici,
3) ha più di 18 anni,
4) ha meno di 18 anni.

In questo caso, tutti (o quasi) scoprono naturalmente le carte corrette (1 e 4).

Anche se questo test è strutturalmente analogo alla variante astratta precedente, perché la cognizione condizionale ci viene improvvisamente così facile se sostituiamo numeri e lettere con contenuti sociali?

La psicologia evoluzionista ipotizza che siamo programmati con una facoltà intuitiva che ci permette di riconoscere con precisione e rapidità la violazione delle regole.


--------------------------------------
Linee temporali sovrapposte (timeline)
--------------------------------------

Le visualizzazioni che sovrappongono le linee della durata delle vite di vari personaggi storici sono comunemente chiamate e o "linee temporali sovrapposte" (in inglese "lifelines" o "timelines").
Questi grafici mostrano il periodo di vita di ogni personaggio lungo una scala temporale, permettendo di visualizzare le sovrapposizioni e le relazioni temporali tra diverse vite.

Per esempio:

Chess Players:
  Jose Raul Capablanca (19 November 1888 – 8 March 1942)
  Alexander Alekhine (31 ottobre 1892 – 24 marzo 1946)
  Aaron Nimzowitsch (7 novembre 1886 – 16 marzo 1935)

(setq personaggi '(("Capablanca" 1888 1942)
                   ("Alekhine" 1892 1946)
                   ("Nimzowitsch" 1886 1935)))

(define (timeline personaggi)
    (dolist (p personaggi)
        (let ((nome (p 0))
              (inizio (p 1))
              (fine (p 2)))
            (println (format "%s: %s%s"
                             nome
                             (dup " " (- inizio 1800))
                             (dup "-" (- fine inizio)))))))

(timeline personaggi)
;-> Capablanca:
;->                   ------------------------------------------------------
;-> Alekhine:
;->                     ------------------------------------------------------
;-> Nimzowitsch:
;->              -------------------------------------------------

Scriviamo una funzione che genera una timeline migliore.

Funzione che normalizza un numero all'interno dell'intervallo (start, end) nell'intervallo (a,b):

(define (normalizza num start end a b)
  (let (k (div (sub b a) (sub end start)))
    (add a (mul (sub num start) k))))

(normalize 1816 1815 1852 0 200)
;-> 5.405405405405405
(normalize 1852 1815 1852 0 200)
;-> 200

Funzione che visualizza la timelines di elementi di una lista:
elemento = ("nome" anno-nascita anno-morte)

(define (life-line lst line-space)
  (local (start end max-len lst-norm)
    (setq start 9999)
    (setq end -9999)
    (setq max-len 0)
    ; Trova i valori minimi e massimi delle date
    ; e la lunghezza massima del nome
    (dolist (el lst)
      (setq max-len (max (length (el 0)) max-len))
      (setq start (min (el 1) start))
      (setq end (max (el 2) end))
    )
    ; lunghezza intervallo della linea degli anni
    (setq range (or line-space (- end start)))
    ; Normalizza i valori delle date
    ; nell'intervallo (1, range)
    (setq lst-norm '())
    (dolist (el lst)
      (push (list (el 0)
             (normalizza (el 1) start end 1 range)
             (normalizza (el 2) start end 1 range)) lst-norm -1)
    )
    ; Stampa le timeline di ogni personaggio
    (dolist (el lst-norm)
      (println (string (dup " " max-len)
                (dup " " (el 1))
                (lst $idx 1)
                (dup " " (- (el 2) (el 1) (length (lst $idx 1))))
                (lst $idx 2)))
      (println (string (el 0)
                (dup " " (- max-len (length (el 0))))
                (dup " " (el 1))
                (dup "-" (- (el 2) (el 1)))))
    ) '>))

Proviamo:

(setq chess '(("Capablanca" 1888 1942)
              ("Alekhine" 1892 1946)
              ("Nimzowitsch" 1886 1935)))

(life-line chess)
;->              1888                                                  1942
;-> Capablanca   ------------------------------------------------------
;->                  1892                                                  1946
;-> Alekhine         ------------------------------------------------------
;->             1886                                            1935
;-> Nimzowitsch ------------------------------------------------

Computer Scientists:
John Backus (3 December 1924 – 17 March 2007)
John Atanasoff (4 October 1903 – 15 June 1995)
Alan Turing (23 June 1912 – 7 June 1954)
John von Neumann (28 December 1903 – 8 February 1957)
Alonzo Church (14 June 1903 – 11 August 1995)
Norbert Wiener (26 November 1894 – 18 March 1964)
Edsger Dijkstra (11 May 1930 – 6 August 2002)
Kenneth Iverson (17 December 1920 – 19 October 2004)

(setq cs '(("John Backus"  1924 2007)
           ("John Atanasoff" 1903 1995)
           ("Alan Turing" 1912 1954)
           ("John von Neumann" 1903 1957)
           ("Alonzo Church" 1903 1995)
           ("Norbert Wiener" 1894 1964)
           ("Edsger Dijkstra" 1930 2002)
           ("Kenneth Iverson" 1920 2004)))

(life-line cs 50)
;->                               1924                                2007
;-> John Backus                   ------------------------------------
;->                     1903                                    1995
;-> John Atanasoff      ----------------------------------------
;->                         1912               1954
;-> Alan Turing             -------------------
;->                     1903                    1957
;-> John von Neumann    ------------------------
;->                     1903                                    1995
;-> Alonzo Church       ----------------------------------------
;->                  1894                          1964
;-> Norbert Wiener   ------------------------------
;->                                 1930                           2002
;-> Edsger Dijkstra                 -------------------------------
;->                             1920                                2004
;-> Kenneth Iverson             ------------------------------------

Se vogliamo ordinare le linee in base alle date di nascita e di morte:

Ordinamento per anno di nascita crescente:

(define (comp x y) (<= (x 1) (y 1)))

(sort cs comp)
;-> (("Norbert Wiener" 1894 1964) 
;->  ("John Atanasoff" 1903 1995) 
;->  ("John von Neumann" 1903 1957)
;->  ("Alonzo Church" 1903 1995)
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
;->  ("John von Neumann" 1903 1957) 
;->  ("John Atanasoff" 1903 1995)
;->  ("Alonzo Church" 1903 1995)
;->  ("Alan Turing" 1912 1954)
;->  ("Kenneth Iverson" 1920 2004)
;->  ("John Backus" 1924 2007)
;->  ("Edsger Dijkstra" 1930 2002))

(life-line (sort cs comp) 50)
;->                  1894                          1964
;-> Norbert Wiener   ------------------------------
;->                     1903                    1957
;-> John von Neumann    ------------------------
;->                     1903                                    1995
;-> John Atanasoff      ----------------------------------------
;->                     1903                                    1995
;-> Alonzo Church       ----------------------------------------
;->                         1912               1954
;-> Alan Turing             -------------------
;->                             1920                                2004
;-> Kenneth Iverson             ------------------------------------
;->                               1924                                2007
;-> John Backus                   ------------------------------------
;->                                 1930                           2002
;-> Edsger Dijkstra                 -------------------------------


-----------------------
Fusione di due stringhe
-----------------------

Definiamo fusione di due stringhe la sovrapposizione di una stringa su un'altra stringa.
Per esempio:

  str1 = "new"
  str2 = "oldLISP"
  Fusione = "newLISP"

In altre parole la prima stringa sostituisce i caratteri della seconda stringa che hanno lo stesso indice.
La stringa risultante ha la stessa lunghezza della seconda stringa.
Per esempio:

  str1 = "pippo"
  str2 = "xyz"
  Fusione = "pip"

Funzione che effettua la fusione di due stringhe:

(define (fusione str1 str2)
  (let ((len1 (length str1)) (len2 (length str2)))
    (cond 
      ((= len1 len2) str1)
      ((> len1 len2) (slice str1 0 len2))
      ((< len1 len2)
        (string str1 (slice str2 len1))))))

Proviamo:

(fusione "pippo" "torta")
;-> "pippo"

(fusione "pippo" "xyz")
;-> "pip"

(fusione "new" "oldLISP")
;-> "newLISP"

(fusione "John" "     Von Neumann")
;-> "John Von Neumann"


------------
Potenze di i
------------

Scrivere la funzione più breve possibile per calcolare i^n.
dove, 'i' è la parte immaginaria di un numero complesso
      'n' è un numero intero maggiore di 0

Risulta che:

  i^1 = i
  i^2= −1
  i^3 = -i
  i^4 = 1
... e questo si ripete.

Usiamo l'indicizzazione implicita di una lista con indice (% n 4).

(map (fn(n) (% n 4)) (sequence 1 12))
;-> (1 2 3 0 1 2 3 0 1 2 3 0)

42 caratteri:
(define(f n)(string('(1 i -1 -i)(% n 4))))
(map f (sequence 1 12))
;-> ("i" "-1" "-i" "1" "i" "-1" "-i" "1" "i" "-1" "-i" "1")

42 caratteri:
(define(f n)('("1" "i" "-1" "-i")(% n 4)))
(map f (sequence 1 12))
;-> ("i" "-1" "-i" "1" "i" "-1" "-i" "1" "i" "-1" "-i" "1")

34 caratteri:
(define(f n)('(1 i -1 -i)(% n 4)))
(map f (sequence 1 12))
;-> (i -1 -i 1 i -1 -i 1 i -1 -i 1)


-------------
Points, Lines
-------------

Abbiamo un file di testo in cui ogni riga contiene uno dei seguenti comandi:

1) width w
   dove w è la larghezza dell'immagine

2) height h
   dove h è l'altezza dell'immagine

3) ; comment
   una linea che inizia con ";" è un commento

4) point x y
   disegna un punto nell'immagine a x,y

5) line x1 y1 x2 y2
   disegna una linea nell'immagine da x1,y1 a x2,y2

I comandi di larghezza e altezza (1 e 2) compaiono solo una volta rispettivamente alla prima e alla seconda riga del file.
Gli altri comandi (3, 4 e 5) possono essere ripetuti e in qualunque ordine (basta che ce ne sia uno solo per linea).

Vediamo un file di esempio:

file: graph.txt
--------------------
width 20
height 20
; comment
; some points
point 1 1
point 10 3
point 7 2
; some lines
line 1 1 1 5
line 12 12 7 12
line 15 15 19 19
eof
--------------------

Usando una matrice come canvas dell'immagine, creiamo una funzione che legge un file del genere, interpreta i comandi e stampa l'immagine finale (cioè la matrice).

Nota: rispetto ad un piano cartesiano, nella matrice l'indice di riga rappresenta la y e l'indice di colonna rappresenta la x.
Inoltre l'asse y deve essere invertito (in una matrice (0,0) si trova in alto a sinistra, mentre nel piano cartesiano (0,0) si trova in basso a sinistra).

(define (file-list file-str)
"Create a list with all the lines of a text file"
  (let (lst '())
    (setq file-str (open file-str "read"))
    (while (read-line file-str)
      (push (current-line) lst -1))
    (close file-str)
    lst))

Funzione che stampa la matrice (canvas):

(define (print-canvas matrix)
  (local (row col)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (if (zero? (matrix i j))
            (print ".")
            (print (matrix i j)))
      )
      (println)) '>))

Funzione che calcola i punti di una linea da x1,y1 a x2,y2:
Vedi "Algoritmo di Bresenham" in "Note libere 4".

(define (bresenham x0 y0 x1 y1)
  (local (dx dy err x y sx sy out)
    (setq out '())
    (setq dx (abs (- x1 x0)))
    (setq dy (abs (- y1 y0)))
    (set 'x x0 'y y0)
    (if (> x0 x1)
        (setq sx -1)
        (setq sx 1)
    )
    (if (> y0 y1)
        (setq sy -1)
        (setq sy 1)
    )
    (cond ((> dx dy)
            (setq err (div dx 2))
            (while (!= x x1)
              (push (list x y) out -1)
              (setq err (sub err dy))
              (if (< err 0)
                  (set 'y (add y sy) 'err (add err dx))
              )
              (setq x (add x sx))
            ))
          (true
            (setq err (div dy 2))
            (while (!= y y1)
              (push (list x y) out -1)
              (setq err (sub err dx))
              (if (< err 0)
                  (set 'x (add x sx) 'err (add err dy))
              )
              (setq y (add y sy))
            ))
    )
    (push (list x y) out -1)
    out))

(bresenham 1 1 10 6)
;-> ((1 1) (2 2) (3 2) (4 3) (5 3) (6 4) (7 4) (8 5) (9 5) (10 6))

Funzione che legge un file e stampa il canvas (matrice) dell'immagine:

(define (create-graph file)
  (local (command width height matri)
    ; reading file and put lines (commands) on a list
    (setq commands (file-list file))
    ;(println commands)
    ; read width (must be the first line of file)
    (setq width (int ((parse (commands 0 1)) 1) 0 10))
    ; read height (must be the second line of file)
    (setq height (int ((parse (commands 1 1)) 1) 0 10))
    (println width { } height)
    ; create canvas (matrix)
    (setq matrix (array height width '(0)))
    ; executing commands
    (dolist (cmd commands)
      (setq cmd (trim cmd))
      (cond
        ; this is a comment
        ((= (cmd 0) ";") nil)
        ; point command
        ((= (slice cmd 0 4) "poin")
          (setq x (int ((parse cmd) 1) 0 10))
          (setq y (int ((parse cmd) 2) 0 10))
          (println x { } y)
          ; draw point on canvas (matrix)
          ; x --> column, y --> row
          (setf (matrix y x) 1)
        )
        ; line command
        ((= (slice cmd 0 4) "line")
          (setq x1 (int ((parse cmd) 1) 0 10))
          (setq y1 (int ((parse cmd) 2) 0 10))
          (setq x2 (int ((parse cmd) 3) 0 10))
          (setq y2 (int ((parse cmd) 4) 0 10))
          (println x1 { } y1 { }  x2 { } y2)
          ; create points of line with bresenham algorithm
          (setq points (bresenham x1 y1 x2 y2))
          ;(println points)
          ; draw points on canvas (matrix)
          ; x --> column, y --> row
          (dolist (p points) (setf (matrix (p 1) (p 0)) 1)))
      )
    )
    ; y axis must be inverted
    (reverse matrix)
  )
)

Proviamo:

(print-canvas (create-graph "graph.txt"))
;-> 20 20
;-> 1 1
;-> 10 3
;-> 7 2
;-> 1 1 1 5
;-> 12 12 7 12
;-> 15 15 19 19
;-> ...................1
;-> ..................1.
;-> .................1..
;-> ................1...
;-> ...............1....
;-> ....................
;-> ....................
;-> .......111111.......
;-> ....................
;-> ....................
;-> ....................
;-> ....................
;-> ....................
;-> ....................
;-> .1..................
;-> .1..................
;-> .1........1.........
;-> .1.....1............
;-> .1..................
;-> ....................

Nel 1985 per un lavoro d'esame universitario scrissi un programma in C che leggeva un file di testo con un formato simile, ma con coordinate in 3D, e visualizzava la scena tridimensionale finale in wireframe in un PC 8088.
L'unica primitiva grafica utilizzabile era una funzione in assembler che accendeva/spegneva un pixel dello schermo.


---------------------------------------------
Eliminare parte di una lista o di una stringa
---------------------------------------------

Come eliminare una parte contigua di una lista o di una stringa?

Vediamo prima la definizione (in stile manuale newLISP):

syntax: (remove lst int-index [int-length])

"remove" deletes a sublist/substring from a list/string.
The sublist/substring deleted starts at index 'int-index' and has a length of 'int-length'. 
If the parameter 'int-length' is omitted, the function deletes all of the elements from 'int-index' to the end of the list/string.

(define (remove lst int-index int-length)
"Deletes a sublist/substring from a list/string"
  (let (int-length (or int-length (- (length lst) int-index)))
    ; pop the same index for int-length times
    (for (i 1 int-length) (pop lst int-index))
  lst))

Proviamo:

(setq a '(8 0 6 5 1))
(setq b "80651")

(remove a 1 2)
;-> (8 5 1)
(remove b 1 2)
;-> "851"
(remove a 1)
;-> (8)
(remove b 1)
;-> "8"
(remove a 0)
;-> ()
(remove b 0)
;-> ""

Vediamo la velocità:

(silent (setq t (rand 100 10000)))
(time (remove t 10 9000) 1000)
;-> 354.36

Funzione che genera una lista con tutte le sottoliste/sottostringhe che rimangono dopo aver applicato tutte le possibili rimozioni di elementi contigui alla lista/stringa data:

(define (remove-all-contiguous obj)
"Generate all rests of a list or string removing all contiguous parts"
  (let ( (out '()) (len (length obj)) )
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        (push (remove obj i j) out -1)
      )
    )
    out))

Proviamo:

(remove-all-contiguous "80651")
;-> ("0651" "651" "51" "1" "" "8651" "851" "81" "8" 
;->  "8051" "801" "80" "8061" "806" "8065")

(remove-all-contiguous '(8 0 6 5 1))
;-> ((0 6 5 1) (6 5 1) (5 1) (1) () (8 6 5 1) (8 5 1) (8 1) (8)
;->  (8 0 5 1) (8 0 1) (8 0) (8 0 6 1) (8 0 6) (8 0 6 5))

Nota: la funzione "remove" è il contrario della funzione "slice", infatti mentre "slice" restituisce la sottolista/sottostringa individuata dagli indici, "remove" restituisce la lista/stringa che rimane una volta eliminata la sottolista/sottostringa individuata dagli indici.


---------------------
Primi indistruttibili
---------------------

Un numero primo è indistruttibile se rimane primo togliendo qualunque sequenza di cifre contigue dal numero stesso.

Vediamo un paio di esempi:

Dal numero primo 317 otteniamo (tra parentesi le cifre contigue da eliminare):

  (3)17 (31)7  3(1)7 3(17) 31(7)
     17     7  37    3     31
  
Tutti i numeri 17, 7, 37, 3 e 31 sono primi, quindi 317 è un numero primo indistruttibile.

Dal numero primo 349 otteniamo:

  (3)49 (34)9  3(4)9 3(49) 34(9)
     49     9  39    3     34 

Poichè non tutti i numeri 49, 9, 39, 3, 34 sono primi, allora 349 non è un numero primo indistruttibile.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (remove lst int-index int-length)
"Deletes a sublist/substring from a list/string"
  (let (int-length (or int-length (- (length lst) int-index)))
    ; pop the same index for int-length times
    (for (i 1 int-length) (pop lst int-index))
  lst))

Funzione che genera una lista con tutte le sottoliste/sottostringhe che rimangono dopo aver applicato tutte le possibili rimozioni di elementi contigui alla lista/stringa data:

(define (remove-all-contiguous obj)
"Generate all rests of a list or string removing all contiguous parts"
  (let ( (out '()) (len (length obj)) )
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        (push (remove obj i j) out -1)
      )
    )
    out))

(remove-all-contiguous "5737")
;-> ("737" "37" "7" "" "537" "57" "5" "577" "57" "573")

Funzione che verifica se un numero è un primo indistruttibile:

(define (indistruttibile? num)
  (cond ((prime? num)
          (if (< num 10) true ; primo con una sola cifra
          ;else 
              ; primo con più di una cifra
              (let ((nums '())
                    (parts (remove-all-contiguous (string num))))
                (dolist (el parts) (if (!= el "") (push (int el 0 10) nums)))
                ; tutte le parti sono numeri primi?
                (for-all prime? nums))))
        ; numero non primo
        (true nil)))

Proviamo:

(indistruttibile? 317)
;-> true

(indistruttibile? 319)
;-> nil

(filter indistruttibile? (sequence 1 1e4))
;-> (2 3 5 7 23 37 53 73 317 3137)

(filter indistruttibile? (sequence 1 1e6))
;-> (2 3 5 7 23 37 53 73 317 3137)

(time (println (filter indistruttibile? (sequence 1 1e7))))
;-> (2 3 5 7 23 37 53 73 317 3137)
;-> 47633.117

Fino a 100 milioni:
(time (println (filter indistruttibile? (sequence 1 1e8))))
;-> (2 3 5 7 23 37 53 73 317 3137)
;-> 762920.691

Il numero 3137 è l'ultimo numero della sequenza?


-------------------------------------
Espressioni aritmetiche vere o false?
-------------------------------------

Determinare se le seguenti espressioni sono vere o false.

  1)  44 + 21 = 105
  2)  34 - 12 = 20
  3)  44 - 21 = 23
  4)  12 * 12 = 221
  5)  12 - 4 = 1
  6)  40 + 7 = 51
  7)  8 * 7 = 62

A prima vista sembra che solo l'espressione 3) sia vera e tutte le altre siano false.
Questo perchè siamo abituati a ragionare in base 10.
Forse le espressioni potrebbero essere vere in una base minore di 10.

Scriviamo una funzione che verifica la validità di espressioni del tipo:

  a op b = c

  dove 'a','b' e 'c' sono numeri interi e 'op' può valere +,-,*,/.

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica la validità di un'espressione nelle basi da 2 a 10:

(define (valuta expr)
  (local (out items op a b c x y z)
    (setq out '())
    ; parse expr
    (setq items (parse expr))
    ; termine 'op' come stringa
    (setq op (items 1))
    ; termini a,b,c come numeri
    (setq a (int (items 0) 0 10))
    (setq b (int (items 2) 0 10))
    (setq c (int (items 4) 0 10))
    ; calcola la base minima da cui iniziare la verifica
    ; (cifra massima dei termini)
    (setq bmin (apply max (append (int-list a) (int-list b) (int-list c))))
    ; Ciclo per la verifica dell'espressione per le basi da bmin a 10
    (for (base bmin 10 1)
      (setq x (b1-b2 a base 10))
      (setq y (b1-b2 b base 10))
      (setq z (b1-b2 c base 10))
      ; verifica se l'espressione è vera o falsa per la base corrente
      (when (= ((eval-string op) x y) z)
          (println expr "  -->  (Base " base")")
          (push base out -1)))
    ; valore restituito
    out))

Proviamo:

(valuta "44 + 21 = 105")
;-> 44 + 21 = 105  -->  (Base 6)
;-> (6)

(valuta "34 - 12 = 20")
;-> ()

(valuta "44 - 21 = 23")
;-> 44 - 21 = 23  -->  (Base 4)
;-> 44 - 21 = 23  -->  (Base 5)
;-> 44 - 21 = 23  -->  (Base 6)
;-> 44 - 21 = 23  -->  (Base 7)
;-> 44 - 21 = 23  -->  (Base 8)
;-> 44 - 21 = 23  -->  (Base 9)
;-> 44 - 21 = 23  -->  (Base 10)
;-> (4 5 6 7 8 9 10)

(valuta "12 * 12 = 221")
;-> 12 * 12 = 221  -->  (Base 3)
;-> (3)

(valuta "12 - 4 = 1")
;-> ()

(valuta "40 + 7 = 51")
;-> ()

(valuta "8 * 7 = 62")
;-> 8 * 7 = 62  -->  (Base 9)
;-> (9)

Vediamo una funzione che genera espressioni valide in una base data:

(define (create-expr a b base)
  (setq x (b1-b2 a base 10))
  (setq y (b1-b2 b base 10))
  (println "Base = " base)
  (println a " + " b " = " (b1-b2 (+ x y) 10 base))
  (println a " - " b " = " (b1-b2 (- x y) 10 base))
  (println a " * " b " = " (b1-b2 (* x y) 10 base))
  (println a " / " b " = " (b1-b2 (/ x y) 10 base)))

Proviamo:

(create-expr 74 22 8)
;-> Base = 8
;-> 74 + 22 = 116
;-> 74 - 22 = 52
;-> 74 * 22 = 2070
;-> 74 / 22 = 3
(valuta "74 * 22 = 2070")
;-> 74 * 22 = 2070  -->  (Base 8)
;-> (8)

(create 123 456 7)
;-> Base = 7
;-> 123 + 456 = 612
;-> 123 - 456 = -333
;-> 123 * 456 = 63414
;-> 123 / 456 = 0
(valuta "123 + 456 = 612")
;-> 123 + 456 = 612  -->  (Base 7)
;-> (7)


-------------------------------------------------
Sensibilità di una funzione rispetto ai parametri
-------------------------------------------------

Per analizzare la sensibilità di una funzione algebrica rispetto ai suoi parametri, si possono usare diversi metodi.
Questi includono la derivata parziale rispetto ai parametri, il metodo Monte Carlo e l'analisi della varianza.

Metodo delle Derivate Parziali
------------------------------
Si tratta di uno dei metodi più comuni e diretti.
Supponiamo di avere una funzione algebrica f(x, a, b, c) con variabili indipendenti x e parametri a, b, c.
I passi da seguire sono i seguenti:

1. Calcolo delle derivate parziali rispetto ai parametri:
   Le derivate parziali della funzione rispetto ai parametri ci indicano come la funzione cambia al variare di ciascun parametro.

   df/da, df/db, df/db

2. Valutazione delle derivate:
   Valutare le derivate parziali in punti specifici per determinare la sensibilità locale.
   Si scelgono solitamente valori dei parametri e delle variabili di input di interesse.

3. Analisi delle derivate:
   Confrontare i valori delle derivate per determinare quali parametri hanno un'influenza maggiore sulla funzione.

Vediamo un esempio con la funzione f(x, a, b, c) = a*x^2 + b*x + c.

Definizione della funzione:

(define (f x a b c)
  (add (mul a (pow x 2)) (add (mul b x) c)))

Funzioni per il calcolo numerico delle derivate parziali:

(define (partial-derivative-a x a b c)
  (letn ( (h 1e-5)
          (f1 (f x (add a h) b c))
          (f2 (f x (sub a h) b c)) )
  (div (sub f1 f2) (mul 2 h))))

(define (partial-derivative-b x a b c)
  (letn ( (h 1e-5)
          (f1 (f x a (add b h) c))
          (f2 (f x a (sub b h) c)) )
  (div (sub f1 f2) (mul 2 h))))

(define (partial-derivative-c x a b c)
  (letn ( (h 1e-5)
          (f1 (f x a b (add c h)))
          (f2 (f x a b (sub c h))) )
    (div (sub f1 f2) (mul 2 h))))

Calcoliamo le derivate parziali per x = 2, a = 1, b = 3, c = 5:

(setq x 2)
(setq a 1)
(setq b 3)
(setq c 5)

(println "Sensibilità di f al parametro a: " (partial-derivative-a x a b c))
;-> Sensibilità di f al parametro a: 4.000000000026205

(println "Sensibilità di f al parametro b: " (partial-derivative-b x a b c))
;-> Sensibilità di f al parametro b: 1.999999999924284

(println "Sensibilità di f al parametro c: " (partial-derivative-c x a b c))
;-> Sensibilità di f al parametro c: 0.9999999999621422

Quindi il parametro 'a' è quello che influenza di più la funzione.

Proviamo con altri valori:

(setq x 100)
(setq a 10)
(setq b -10)
(setq c -5)

(println "Sensibilità di f al parametro a: " (partial-derivative-a x a b c))
;-> Sensibilità di f al parametro a: 9999.999999126885

(println "Sensibilità di f al parametro b: " (partial-derivative-b x a b c))
;-> 100.0000003841706

(println "Sensibilità di f al parametro c: " (partial-derivative-c x a b c))
;-> 9999.999999126885

(println "Sensibilità di f al parametro b: " (partial-derivative-b x a b c))
;-> Sensibilità di f al parametro c: 1.000000338535756

Poichè la derivata parziale rispetto ad 'a' è maggiore rispetto a quelle rispetto a 'b' e 'c', la funzione è più sensibile ai cambiamenti del parametro 'a'.

Questo metodo delle derivate parziali è utile per analizzare la sensibilità locale della funzione rispetto ai parametri.
Per un'analisi più globale, potremmo considerare metodi statistici come il campionamento di Monte Carlo.

Metodo di Monte Carlo
---------------------
Il metodo di Monte Carlo è un approccio statistico utilizzato per stimare la sensibilità di una funzione algebrica rispetto ai suoi parametri.
Consiste nel campionare i parametri da una distribuzione e valutare come varia la funzione.

Supponiamo di avere la stessa funzione f(x, a, b, c) = a*x^2 + b*x + c.
Utilizziamo il metodo di Monte Carlo per analizzare la sensibilità rispetto ai parametri a, b e c.

(define (f x a b c)
  (add (mul a (pow x 2)) (add (mul b x) c)))

(define (random-sample min-val max-val)
  (add min-val (mul (random) (sub max-val min-val))))

Algoritmo:
1) Generare 'num-samples' campioni casuali per ogni parametro a, b, c all'interno degli intervalli specificati.
2) Calcolare il valore della funzione per i parametri originali e i campioni generati.
3) Calcolare la differenza assoluta tra il valore della funzione con i campioni e il valore della funzione con i parametri originali.
4) Memorizzare queste differenze in liste.
5) Calcolare la media delle differenze per ogni parametro per stimare la sensibilità.

(define (montecarlo-sensitivity f x a b c num-samples range-a range-b range-c)
  (local (results-a results-b results-c a-sample b-sample c-sample
          f0 fa fb fc)
    (setq results-a '())
    (setq results-b '())
    (setq results-c '())
    (dotimes (i num-samples)
      (setq a-sample (random-sample (range-a 0) (range-a 1)))
      (setq b-sample (random-sample (range-b 0) (range-b 1)))
      (setq c-sample (random-sample (range-c 0) (range-c 1)))
      (setq f0 (f x a b c))
      (setq fa (f x a-sample b c))
      (setq fb (f x a b-sample c))
      (setq fc (f x a b c-sample))
      (push (abs (sub fa f0)) results-a)
      (push (abs (sub fb f0)) results-b)
      (push (abs (sub fc f0)) results-c)
    )
    (println "Sensibilità rispetto a a: " (mean results-a))
    (println "Sensibilità rispetto a b: " (mean results-b))
    (println "Sensibilità rispetto a c: " (mean results-c)) '>))

(define (mean lst)
  (div (apply add lst) (length lst)))

Esempio di utilizzo con x = 2, a = 1, b = 3, c = 5, 1000 campioni

(setq x 2)
(setq a 1)
(setq b 3)
(setq c 5)
(setq num-samples 1000)
(setq range-a '(0.5 1.5))
(setq range-b '(2.5 3.5))
(setq range-c '(4.5 5.5))

(montecarlo-sensitivity f x a b c num-samples range-a range-b range-c):
;-> Sensibilità rispetto a a: 0.9731997436445328
;-> Sensibilità rispetto a b: 0.4965421918393565
;-> Sensibilità rispetto a c: 0.253571398052922

Questi valori rappresentano la sensibilità media della funzione rispetto ai cambiamenti nei parametri a, b e c.
Quindi la nostra funzione è più sensibile ai cambiamenti del parametro 'a'.


-----------------------
Velocità di digitazione
-----------------------

Scrivere una funzione che misura il tempo di risposta dell'utente chiedendogli di inserire il carattere visualizzato sullo schermo nel più breve tempo possibile.
La funzione prende come parametro il numero di prove da effettuare.
La funzione deve restituire il numero di prove corrette, il numero di prove sbagliate e la velocità di risposta media nei due casi.
Il tempo deve essere misurato in millisecondi.

Esempio di output:
  ---------------------
  Test 1 di 10:
  Computer: z
  Utente: z
  Corretto: 1045 msec.
  ---------------------
  Test 2 di 10:
  Computer: l
  Utente: k
  Errato: 1335 msec.
  ---------------------
  ...
  ---------------------
  Test 10 di 10:
  Computer: p
  Utente: p
  Corretto: 662 msec.
  ---------------------
  Risultati:
  Tasti corretti = 8
  Tempo medio = 1122 millisec
  Tasti errati = 2
  Tempo medio = 2007 millisec

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (+ min-val (rand (+ (- max-val min-val) 1))))

Funzione che prova la velocità di digitazione dell'utente:

(define (fast-test prove)
  (local (time-ok time-no ch start elapsed pressed)
    (setq time-ok '())
    (setq time-no '())
    (println "---------------------")
    (for (p 1 prove)
      (println "Test " p " di " prove ":")
      (setq ch (char (rand-range 97 122)))
      ;(setq ch (char (rand-range 65 90))))
      (println "Computer: " ch)
      ; start time
      (setq start (time-of-day))
      ; wait for user keypress...
      (while (zero? (setq code (read-key true))))
      ; calculate elapsed time (time of user response)
      (setq elapsed (sub (time-of-day) start))
      ; char keypressed 
      (setq pressed (char code))
      (println "Utente: " pressed)
      ; check user response
      (cond ((= ch pressed)
              (push elapsed time-ok -1)
              (println "Corretto: " (format "%.0f" elapsed) " msec."))
            (true
              (push elapsed time-no -1)
              (println "Errato: " (format "%.0f" elapsed) " msec."))
      )
      (println "---------------------")
    )
    ; print results
    (println "Risultati:")
    (println "Tasti corretti = " (length time-ok))
    ;(println "Tempi: " time-ok)
    (println "Tempo medio: " 
        (int (add 0.5 (div (apply add time-ok) (length time-ok)))) " msec")
    (println "Tasti errati = " (length time-no))
    ;(println "Tempi: " time-no)
    (println "Tempo medio: " 
        (int (add 0.5 (div (apply add time-no) (length time-no)))) " msec")
    '>))

Proviamo:

(fast-test 10)
;-> ---------------------
;-> Test 1 di 10:
;-> Computer: c
;-> Utente: c
;-> Corretto: 941 msec.
;-> ---------------------
;-> Test 2 di 10:
;-> Computer: r
;-> Utente: r
;-> Corretto: 991 msec.
;-> ---------------------
;-> Test 3 di 10:
;-> Computer: b
;-> Utente: b
;-> Corretto: 1127 msec.
;-> ---------------------
;-> Test 4 di 10:
;-> Computer: a
;-> Utente: a
;-> Corretto: 862 msec.
;-> ---------------------
;-> Test 5 di 10:
;-> Computer: x
;-> Utente: x
;-> Corretto: 1038 msec.
;-> ---------------------
;-> Test 6 di 10:
;-> Computer: h
;-> Utente: h
;-> Corretto: 1175 msec.
;-> ---------------------
;-> Test 7 di 10:
;-> Computer: h
;-> Utente: g
;-> Errato: 887 msec.
;-> ---------------------
;-> Test 8 di 10:
;-> Computer: p
;-> Utente: p
;-> Corretto: 999 msec.
;-> ---------------------
;-> Test 9 di 10:
;-> Computer: r
;-> Utente: r
;-> Corretto: 1726 msec.
;-> ---------------------
;-> Test 10 di 10:
;-> Computer: v
;-> Utente: v
;-> Corretto: 1031 msec.
;-> ---------------------
;-> Risultati:
;-> Tasti corretti = 9
;-> Tempo medio: 1099 msec
;-> Tasti errati = 1
;-> Tempo medio: 887 msec


------------------
Più o meno quanto?
------------------

"Più o meno quanto? L'arte di fare stime sul mondo" di Lawrence Weinstein e John A. Adam è un libro che insegna a fare valutazioni quantitative sui temi più disparati, anche quando le informazioni disponibili sono poche, con quattro calcoli che si possono fare con carta e penna.
L'obiettivo non è quello di risolvere i vari problemi esattamente, ma trovare una soluzione soddisfacente entro un fattore dieci dalla soluzione esatta (che in genere è quanto basta per prendere una decisione).

Vediamo un semplice problema per avere un'idea di cosa stiamo parlando.

Problema
--------
Mettendo uno sopra l'altro tutti i biglietti della Lotteria Italia, quanto sarà alta la pila risultante?
E quanto pesa?

Nota:
Grattacielo (100 m)
Piccola montagna (1000 m)
Everest (10000 m)
Spessore atmosfera (10^5 m)
Lunghezza dell'Italia (10^6 m)
Diametro terrestre (10^7)
Distanza Terra-Luna (10^8)

Stima dei valori delle variabili coinvolte nel problema:

Quanti biglietti?
In Italia ci sono circa 60 milioni di persone. Supponendo che una persona ogni 10 conpra un biglietto, otteniamo 6 milioni di biglietti venduti.
Nota: I biglietti della Lotteria Italia venduti nel 2023 sono circa 6.7 milioni.

Peso e spessore di un biglietto?
Il peso e lo spessore di un biglietto della lotteria possono variare a seconda del tipo e del materiale del biglietto stesso, ma possiamo dare alcune stime generali:
Peso: Un biglietto della lotteria tipico pesa solitamente tra 1 e 5 grammi (prendiamo 3 grammi).
Spessore: Il spessore di un biglietto della lotteria è generalmente compreso tra 0.1 e 0.3 millimetri (prendiamo 0.2 millimetri).

Adesso possiamo calcolare altezza e peso della pila di biglietti:

Altezza = Numero-biglietti * Spessore-biglietto =
        = 6e6 * 2e-4 = 1200 metri

Peso = Numero-biglietti * Peso-biglietto =
     = 6e6 * 3 = 18000000 grammi = 18000 Kg = 180 Quintali = 18 Tonnellate

In questo caso per calcolare i valori minimi e massimi di Altezza e Peso della pila è sufficiente sostituire i valori minimi e massimi dei Numero-biglietti, Spessore-biglietto e Peso-biglietto.
Quando la formula si fa più complicata, invece di usare un approccio matematico per trovare i minimi e i massimi, possiamo utilizzare un approccio casuale (simile al Metodo di Monte Carlo).

Algoritmo
Generare N volte valori casuali per tutti i parametri della funzione (negli intervalli definiti per ogni parametro)
Per ogni generazione di valori calcolare il valore della funzione per quei valori e
aggiornare i valori mini e massimi della funzione.

Per maggiori informazioni vedere i commenti della funzione.

Funzione che genera un numero casuale tra due valori:

(define (random-value min-val max-val)
  (add min-val (mul (random) (sub max-val min-val))))

(random-value 0.1 0.2)
;-> 0.1001251258888516
(random-value 2 2)
;-> 2

Funzione Altezza:

(define (A) (mul a b))
dove 'a' è il numero di biglietti
     'b' è lo spessore di un biglietto

Funzione Peso:

(define (P) (mul a b))
dove 'a' è il numero di biglietti
     'b' è il peso di un biglietto

Per la definizione della funzione da calcolare dobbiamo usare i simboli a,b,c,...,z.
Questo perchè dobbiamo creare automaticamente le variabili all'interno della funzione newLISP.

Intervalli dei parametri:

Numero-biglietti: (4e6, 8e6)
Spessore-biglietto: (0.1, 0.3)
Peso-biglietto: (1, 5)

Funzione che calcola il valore minimo e massimo di una funzione con parametri a,b,c,... utilizzando valori casuali scelti nell'intervallo di variazione di ogni parametro:

(define (min-max func iterazioni ranges)
  (local (val-min val-max)
    ; numero di parametri
    (setq num-par (length ranges))
    ; valore minimo iniziale
    (setq min-val 1e99)
    ; valore massimo iniziale
    (setq max-val -1e99)
    (for (k 1 iterazioni)
      ; lista dei valori correnti dei parametri
      (setq cur-values '())
      ; creazione dei valori casuali per i parametri a,b,c,d,e,...,z
      (for (i 0 (- num-par 1))
        ; crea 'num-par' variabili: a,b,c...
        ; e le inserisce nella lista 'cur-values'
        (push (set (sym (char (+ i 97)))
                   (random-value (ranges i 0) (ranges i 1))) cur-values -1)
      )
      ; calcolo del valore della funzione con i parametri correnti
      (setq cur-value (func))
      ;(print a { } b { -> } cur-value) (read-line)
      ; controllo valore massimo
      (when (> cur-value max-val)
        (setq max-val cur-value)
        (setq massimo (list max-val cur-values)))
      ; controllo valore minimo
      (when (< cur-value min-val)
        (setq min-val cur-value)
        (setq minimo (list min-val cur-values)))
    )
    (println minimo)
    (println massimo)
  '>))

Proviamo:

Numero-biglietti: (4e6, 8e6)
Spessore-biglietto: (0.1, 0.3)
Peso-biglietto: (1, 5)

(min-max A 1e6 '((4e6 8e6) (1 5)))
;-> (4014048.945808469 (4004272.59132664 1.00244148075808))   ; grammi
;-> (39995483.32020584 (7999877.925962096 4.999511703848384)) ; grammi

(min-max P 1e6 '((4e6 8e6) (0.1 0.3)))
;-> (400756.9037412169 (4000244.148075808 0.100183111056856)) ; millimetri
;-> (2398242.455738911 (7997070.223090304 0.2998901333658864)); millimetri

Nota: attenzione alle unità di misura.


------------------------------------
Numero casuale con cifre predefinite
------------------------------------

Scrivere una funzione che genera un numero intero casuale compreso in un intervallo chiuso e con cifre predefinite.

Per esempio:
Intervallo: (1 200)
Cifre: 1 2 3
Numeri possibili: 1 2 3 11 12 13 21 22 23 31 32 33 111 112 113 121 122 123 131 132 133 211 212 213
 221 222 223 231 232 233 311 312 313 321 322 323 331 332 333
Numeri nell'intervallo: 1 2 3 11 21 31 12 22 32 13 23 33 111 112 113 121 122 123 131 132 133
Numero casuale: uno qualunque dei numeri nell'intervallo

Per calcolare tutti i numeri che possono essere generati con una lista di cifre possiamo usare la funzione per il calcolo delle permutazioni con ripetizione:

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 1 '(1 2 3))
;-> ((1) (2) (3))
(perm-rep 2 '(1 2 3))
;-> ((1 1) (2 1) (3 1) (1 2) (2 2) (3 2) (1 3) (2 3) (3 3))
(perm-rep 3 '(1 2 3))
;-> ((1 1 1) (2 1 1) (3 1 1) (1 2 1) (2 2 1) (3 2 1) (1 3 1) (2 3 1) 
;->  (3 3 1) (1 1 2) (2 1 2) (3 1 2) (1 2 2) (2 2 2) (3 2 2) (1 3 2)
;->  (2 3 2) (3 3 2) (1 1 3) (2 1 3) (3 1 3) (1 2 3) (2 2 3) (3 2 3)
;->  (1 3 3) (2 3 3) (3 3 3))

Adesso possiamo selezionare a caso una delle liste della permutazione per creare il numero casuale.
Comunque non siamo sicuri che questo numero sia compreso nell'intervallo predefinito.

Allora, prima di selezionare una lista, attraversiamo la lista delle permutazioni e filtriamo solo i numeri compresi nell'intervallo.

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che genera un numero casuale in un intervallo con cifre predefinite:

(define (rnd-digits min-val max-val digits)
  (local (len perm nums nums-range)
    (setq len (length digits))
    ; crea i numeri possibili (permutazioni)
    (setq perm '())
    (for (i 1 len) (extend perm (perm-rep i digits)))
    ; converte le permutazioni in numeri
    (setq nums (map list-int perm))
    ; filtra solo i numeri nell'intervallo
    (setq nums-range (filter (fn(x) (and (>= x min-val) (<= x max-val))) nums))
    ; seleziona, se possibile, un numero casuale dai numeri possibili
    (if (= nums-range '())
        ; nessun numero soddisfa le condizioni
        nil
        ;else
        (nums-range (rand (length nums-range))))))

Proviamo:

(rnd-digits 1 200 '(1 2 3))
;-> 112
(rnd-digits 1 200 '(1 2 3))
;-> 132
(rnd-digits 1 100 '(1 2 3))
;-> 11
(rnd-digits 400 500 '(1 2 3))
;-> nil
(rnd-digits 1 1000 '(1 2 3 4 5 6))
;-> 324

Verifichiamo che questo metodo genera numeri veramente casuali:

(count '(1 2 3 11 21 31 12 22 32 13 23 33 111 112 113 121 122 123 131 132 133)
        (collect (rnd-digits 1 200 '(1 2 3)) 1e6))
;-> (47816 47318 47511 47555 47398 47662 47627 47962 47542 47772 47417 
;->  47728 47542 47777 47584 48005 47516 47401 47653 47575 47639)

Comunque il metodo è molto lento al crescere del numero delle cifre:

(time (println (rnd-digits 1 90000000 '(1 2 3 4 5 6))))
;-> 144132
;-> 267.557

(time (println (rnd-digits 1 90000000 '(1 2 3 4 5 6 7))))
;-> 6477531
;-> 3592.844

(time (println (rnd-digits 1 90000000 '(1 2 3 4 5 6 7 8))))
;-> 57127468
;-> 35980.383 ; quasi 36 secondi...

Vediamo un altro metodo che genera casualmente le cifre per formare il numero.

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (+ min-val (rand (+ (- max-val min-val) 1))))

(define (rnd-cifre min-val max-val digits)
  (local (len min-digits max-digits num-digits num cifra)
    (setq len (length digits))
    ; numero minimo di cifre del numero casuale
    (setq min-digits (length min-val))
    ; numero massimo di cifre del numero casuale
    (setq max-digits (length max-val))
    ; numero casuale di cifre 
    (setq num-digits (rand-range min-digits max-digits))
    (setq stop nil)
    (until stop
      ; crea il numero casuale selezionando casualmente 'num-digits' cifre
      ; dalla lista delle cifre 'digits'
      (setq num 0)
      (for (i 1 num-digits)
        (setq cifra (digits (rand len)))
        (setq num (+ cifra (* num 10)))
      )
      ; verifica se il numero ricade nell'intervallo
      (if (and (>= num min-val) (<= num max-val)) (setq stop true))
    )
    num))

Proviamo:

(rnd-cifre 1 200 '(1 2 3))
;-> 21

(rnd-cifre 1 200 '(1 2 3))
;-> 121

(rnd-cifre 1 100 '(1 2 3))
;->332

(rnd-cifre 400 500 '(1 2 3))
...non termina mai...

(rnd-cifre 1 1000 '(1 2 3 4 5 6))
;-> 324

(time (println (rnd-cifre 1 90000000 '(1 2 3 4 5 6 7 8))))
;-> 7348481
;-> 0

Questa funzione è velocissima, ma ha due problemi.
Primo, non è in grado di riconoscere quando non esiste nessun numero nell'intervallo (in questo caso la funzione non termina mai).
Secondo, la funzione produce risultati errati. Infatti alcuni numeri compaiono più spesso di altri:

(count '(1 2 3 11 21 31 12 22 32 13 23 33 111 112 113 121 122 123 131 132 133)
        (collect (rnd-cifre 1 200 '(1 2 3)) 1e6))
;-> (111518 111161 111218 37105 37145 37117 37184 36827 36896 36766 37054 36965 36871
;->  36702 37032 36911 37079 37055 37225 37109 37060)

In questo esempio i numeri 1, 2 e 3 compaiono più volte degli altri perchè quando viene scelto un numero lungo una sola cifra (che ha la stessa probabilità di un numero di due o tre cifre), allora abbiamo solo tre scelte (1, 2 o 3). I numeri con due e tre cifre hanno la stessa probabilità perchè ci sono nove numeri con due cifre e nove numeri con tre cifre da cui scegliere.

Proviamo ad generare i numeri validi usando un metodo ricorsivo.

Funzione che genera i numeri validi:

(define (create-numbers current)
  (if (<= current max-val)
      (begin
        ; check if current number is within range
        (if (and (>= current min-val) (<= current max-val))
            (push current valid-numbers))
        ; creates numbers recursively
        (dolist (d digits)
          (create-numbers (+ (* current 10) d))))))

Funzione che genera un numero casuale valido:

(define (random-integer min-val max-val digits)
  (let (valid-numbers'())
    ; creates valid numbers
    (dolist (d digits) (create-numbers d))
    ;(print valid-numbers)
    ; random selection of element of valid-numbers
    (valid-numbers (rand (length valid-numbers)))))

Proviamo:

(random-integer 1 200 '(1 2 3))
;-> 131

(random-integer 1 200 '(1 2 3))
;-> 32

(random-integer 1 100 '(1 2 3))
;->1

(random-integer 400 500 '(1 2 3))
;-> ERR: invalid list index : (rand (length valid-numbers))
;-> called from user function (random-integer 400 500 '(1 2 3))

(random-integer 1 1000 '(1 2 3 4 5 6))
;-> 644

Verifichiamo che questo metodo genera numeri veramente casuali:

(count '(1 2 3 11 21 31 12 22 32 13 23 33 111 112 113 121 122 123 131 132 133)
        (collect (random-integer 1 200 '(1 2 3)) 1e6))
;-> (47905 47688 47495 47306 47887 47425 47729 47547 47442 47717 47632 
;->  47620 47514 47555 47445 47649 47817 47826 47220 47833 47748)

Comunque anche questo metodo è molto lento al crescere del numero delle cifre:

(time (println (random-integer 1 90000000 '(1 2 3 4 5 6 7))))
;-> 77747763
;-> 6812.929

(time (println (random-integer 1 90000000 '(1 2 3 4 5 6 7 8))))
;-> 4545245
;-> 21973.893 ; quasi 22 secondi

17 giugno 2024 - Quesito sul forum di newLISP:
https://newlispfanclub.com/index.php?topic=5269.0

Soluzione proposta da rrq: (Ralph Ronnquist)

(define (randint RANGE DIGITS)
  (letn ((digits (fn (X) (map int (unique (explode (string X))))))
         (wrong (fn (X) (difference (digits X) DIGITS)))
         (S (clean wrong (apply sequence RANGE))))
    (S (rand (length S)))))

Proviamo:

(randint '(1 200) '(1 2 3))
;-> 33

(count '(1 2 3 11 21 31 12 22 32 13 23 33 111 112 113 121 122 123 131 132 133)
        (collect (randint '(1 200) '(1 2 3)) 1e5))
;-> (463 453 471 481 459 459 488 450 484 476 471 484 495 513
;->  467 467 471 490 474 507 477)

(time (println (randint '(1 1000000) '(1 2 3 4 5 6 7 8))))
;-> 314761
;-> 2875.328

(time (println (random-integer 1 1000000 '(1 2 3 4 5 6 7 8))))
;-> 176317
;-> 343.668


----------------------------
mex (minimum excluded value)
----------------------------

Il mex (minimum excluded value - numero minimo escluso) di una lista finita di numeri interi non negativi è il più piccolo intero non negativo 0, 1, 2, 3, 4, ... che non appare nella lista.
In altre parole, è il valore minimo dell'insieme complementare.

(define (mex lst)
  (local (len max-value seq diff)
    (setq len (length lst))
    (cond ((= lst '()) 0)
          ((= len 1) ; lista con un solo elemento
            ; se elemento uguale a 0, allora restituisce 1
            ; altrimenti restituisce 0
            (if (zero? (first lst)) 1 0))
          (true
            ; calcolo del valore massimo
            (setq max-value (apply max lst))
            ; creazione sequenza completa da 0 a valore massimo
            (setq seq (sequence 0 max-value))
            ;(println seq)
            ; calcolo della lista differenza fra la lista data e la sequenza completa
            ; (insieme complementare)
            (setq diff (difference seq lst))
            ; se differenza è vuota, allora restituisce (valore-massimo + 1)
            ; altrimenti restituisce il primo valore della lista differenza
            (if (= diff '())
                (+ max-value 1)
                (first diff))))))

Proviamo:

(mex '(3 1 0 1 3 3))
;-> 2
(mex '(1))
;-> 0
(mex '(0))
;-> 1
(mex '(5))
;-> 0
(mex '(2 0))
;-> 1
(mex '(3 2 0 1 3 3))
;-> 4
(mex '())
;-> 0
(mex '(1 2 3))
;-> 0
(mex '(5 4 1 5 4 8 2 1 5 4 0 7 7))
;-> 3
(mex '(3 2 1 0))
;-> 4
(mex '(0 0 1 1 2 2 3))
;-> 4
(mex '(1 0 7 6 3 11 15 1 9 2 3 1 5 2 3 4 6 8 1 18))
;-> 10
(mex '(0 1 2 3 4 5 6 7 8 9))
;-> 10


------------------------------------
Moltiplicazione di caratteri (ASCII)
------------------------------------

codice ASCII minore: 32 --> " "
codice ASCII maggiore: 126 --> "~"

(define (mult ch1 ch2)
  ; moltiplica i codici ASCII dei caratteri
  (setq m (* (char ch1) (char ch2)))
  ; calcola il modulo 127 della moltiplicazione
  (setq m1 (% (* (char ch1) (char ch2)) 127))
  ; aggiunge 32 (solo caratteri stampabili 32-126)
  (if (< m1 32) (++ m1 32))
  ; converte il risultato in carattere
  (char m1))

Proviamo:

(mult "a" "Z")
;-> "^"

(mult "a" "A")
;-> "R"

Vediamo la distribuzione dei valori della moltiplicazione:

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (+ min-val (rand (+ (- max-val min-val) 1))))

100000 moltiplicazioni con caratteri casuali:

(setq test '())
(silent (for (i 1 100000) (push (mult (char (rand-range 32 126)) (char (rand-range 32 126))) test)))

Calcolo delle frequenze dei caratteri risultanti:

(setq caratteri '())
(for (i 32 126) (push (char i) caratteri -1))
;-> (" " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/"
;->  "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ":" ";" "<" "=" ">" "?" 
;->  "@" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O"
;->  "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_"
;->  "`" "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o"
;->  "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~")

(setq freq (count caratteri test))
;-> (838 1489 1544 1633 1546 1540 1620 1573 1601 1655 1621 1574 1662 1612
;->  1610 1642 1664 1656 1684 1603 1624 1643 1667 1529 1672 1619 1568
;->  1588 1586 1548 1609 1497 773 816 766 784 772 810 780 783 846 745
;->  728 811 768 774 807 750 785 873 745 850 862 814 738 783 787 771 859
;->  716 777 713 808 761 774 772 755 809 777 702 760 751 779 806 792 743
;->  805 752 777 793 818 855 744 862 786 750 742 829 882 771 731 805 749
;->  809 848)

Vediamo se le moltiplicazioni hanno creato caratteri non-ASCII:

(apply + freq)
;-> 100000
(difference caratteri test)
;-> ()
(difference test caratteri)
;-> ()


-------------
Primi supremi
-------------

Un numero N è un "primo supremo" se soddisfa le seguenti proprietà:

1) il numero è primo
2) la lunghezza del numero è un numero primo
3) la somma delle cifre del numero è un numero primo
4) il prodotto delle cifre del numero è un numero primo

Per esempio:
N = 113
1) 113 è un numero primo
2) la lunghezza vale 3 che è un numero primo
3) la somma delle cifre vale 1 + 1 + 3 = 5 che è un numero primo
4) il prodotto delle cifre vale 1 * 1 * 3 = 3 che è un numero primo

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se un numero è un primo supremo:

(define (supreme? num)
  (and (prime? num)
       (prime? (length num))
       (prime? (apply + (int-list num)))
       (prime? (apply * (int-list num)))))

Proviamo:

(supreme? 113)
;-> true

(supreme? 139)
;-> nil

(filter supreme? (sequence 1 1000))
;-> (113 131 151 311)

(filter supreme? (sequence 1 1e6))
;-> (113 131 151 311 11113 11117 11131 11171 11311)

Vediamo la velocità della funzione:

(time (filter supreme? (sequence 1 1e6)))
;-> 1007.337

Invertiamo le prime due condizioni nell'espressione 'and' per vedere se conviene verificare prima se la lunghezza del numero è primo:

(define (supreme1? num)
  (and (prime? (length num))
       (prime? num)
       (prime? (apply + (int-list num)))
       (prime? (apply * (int-list num)))))

(filter supreme1? (sequence 1 1000))
;-> (113 131 151 311)

(filter supreme1? (sequence 1 1e6))
;-> (113 131 151 311 11113 11117 11131 11171 11311)

(time (filter supreme1? (sequence 1 1e6)))
;-> 395.969

(time (println (filter supreme? (sequence 1 1e7))))
;-> (113 131 151 311 11113 11117 11131 11171 11311
;->  1111151 1111711 1117111 1171111)
;-> 19856.507

(time (println (filter supreme1? (sequence 1 1e7))))
;-> (113 131 151 311 11113 11117 11131 11171 11311
;->  1111151 1111711 1117111 1171111)
;-> 21071.058

Modifichiamo la funzione "primes-to" (vedi yo.lsp) per calcolare i primi supremi.

Funzione che genera tutti i primi supremi minori o uguali a un dato numero:

(define (supremes-to num)
  (if (< num 10) '()
      ;else
      (let ((lst '()) (arr (array (+ num 1))))
            (for (x 3 num 2)
              (when (not (arr x))
                ; verifica se x è un primo supremo
                (if (and (prime? (length x))
                         (prime? (apply + (int-list x)))
                         (prime? (apply * (int-list x))))
                    (push x lst -1)
                )
                (for (y (* x x) num (* 2 x) (> y num))
                  (setf (arr y) true)))) lst)))

Proviamo:

(supremes-to 1e6)
;-> (113 131 151 311 11113 11117 11131 11171 11311)

Vediamo la velocità:

(time (println (supremes-to 1e6)))
;-> (113 131 151 311 11113 11117 11131 11171 11311)
;-> 178.477

(time (println (supremes-to 1e7)))
;-> (113 131 151 311 11113 11117 11131 11171 11311
;->  1111151 1111711 1117111 1171111)
;-> 2912.01


--------------------------------
Esiste il 1 gennaio dell'anno 0?
--------------------------------

Nell'attuale calendario gregoriano, che è quello più utilizzato nel mondo, non esiste un anno 0.
La numerazione degli anni inizia con l'anno 1 d.C. (dopo Cristo), preceduto immediatamente dall'anno 1 a.C. (avanti Cristo).
Questo sistema di numerazione fu sviluppato nel VI secolo dal monaco Dionigi il Piccolo (quando il concetto di anno 0 non era ancora conosciuto).
La sequenza degli anni è la seguente:

  ... (2 a.C.) (1 a.C.) (1 d.C.) (2 d.C.) ...

Questo significa che nel calendario gregoriano non esiste un "1 gennaio dell'anno 0".

Nella computazione moderna si utilizza un sistema chiamato "anno astronomico" in cui esiste un anno 0.
La sequenza degli anni è la seguente:

  ... (2 a.C.) (1 a.C.) (0) (1 d.C.) (2 d.C.) ...
  ...  -2       -1       0   1        2       ...

Nota: l'anno astronomico viene usato in contesti scientifici e storici per agevolare i calcoli e l'analisi dei dati.


-----------------------
Date prime e palindrome
-----------------------

Determinare se una data è un numero primo e/o un numero palindromo.
Le date sono nel formato: Y[YYY]M[M]D[D]

Per esempio:
3 dicembre 2024 --> 2024 12 3
21 gennaio 133  --> 133 1 21
1 gennaio 1     --> 1 1 1

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che verifica se una data è un numero primo:

(define (prime-data? data) (prime? (int (join (map string data)) 0 10)))

Proviamo:

(prime-data? '(2014 10 2))
;-> nil
(prime-data? '(2014 5 1))
;-> true
Funzione che verifica se una data è un numero palindromo:

(define (palindrome-data? data)
  (let (str (join (map string data)))
    (= str (reverse (copy str)))))

Proviamo:

(palindrome-data? '(2014 10 2))
;-> true
(palindrome-data? '(2014 5 1))
;-> nil

Vediamo di analizzare un intervallo di date.

(define (leap? year)
"Check if a year is a leap year"
  (or (zero? (% year 400))
      (and (zero? (% year 4)) (not (zero? (% year 100))))))

(define (data-list data1 data2)
"Generates a list of datas (YYYY MM DD) from data1 data2"
  (local (y1 m1 d1 y2 m2 d2 out md n1 n2 days data num-data stop)
    ; unpack data
    (map set '(y1 m1 d1) data1)
    (map set '(y2 m2 d2) data2)
    (setq out '())
    ; lista (mese giorni)
    (setq md '((1 31) (2 28) (3 31) (4 30) (5 31) (6 30)
              (7 31) (8 31) (9 30) (10 31) (11 30) (12 31)))
    ; valore numerico data1
    (setq n1 (int (format "%d%02d%02d" y1 m1 d1)))
    ; valore numerico data2
    (setq n2 (int (format "%d%02d%02d" y2 m2 d2)))
    (if (< n2 n1) (setq stop nil))
    ; ciclo anni
    (for (yy y1 y2 1 stop)
      ;ciclo mesi
      (for (mm 1 12 1 stop)
        (setq days (lookup mm md))
        ; mese febbraio e anno palindromo?
        (if (and (= mm 2) (leap? yy)) (setq days 29))
        ; ciclo giorni
        (for (dd 1 days 1 stop)
          ; data corrente
          (setq data (list yy mm dd))
          ; valore numerico data corrente
          (setq num-data (int (format "%d%02d%02d" yy mm dd)))
          ;controllo (data1 <= data corrente <= data2)
          (cond ((< num-data n1) nil)
                ((and (>= num-data n1) (<= num-data n2))
                  (push data out -1))
                ((> num-data n2 (setq stop true)))
          )
        )
      )
    )
    out))

Calcoliamo le date prime e/o palindrome dall'anno 1000 al 2000 (1 gennaio):

(silent 
  (setq pri (filter prime-lst? (data-list '(1000 1 1) '(2000 1 1))))
  (setq pal (filter palindrome? (data-list '(1000 1 1) '(2000 1 1)))))

(length pri)
;-> 31482
(length pal)
;-> 358
(setq pri-pal (intersect pri pal))
;-> ((1014 10 1) (1016 10 1) (1019 10 1) (1111 1 11) (1111 11 1) (1115 1 11)
;->  (1115 11 1) (1117 1 11) (1118 1 11) (1120 2 11) (1123 2 11) (1128 2 11)
;->  (1130 3 11) (1133 3 11) (1144 4 11) (1150 5 11) (1153 5 11) (1155 5 11)
;->  (1158 5 11) (1163 6 11) (1164 6 11) (1172 7 11) (1178 7 11) (1186 8 11)
;->  (1188 8 11) (1190 9 11) (1196 9 11) (1212 12 1) (1213 12 1) (1215 1 21)
;->  (1215 12 1) (1216 1 21) (1216 12 1) (1218 12 1) (1219 1 21) (1219 12 1)
;->  (1220 2 21) (1227 2 21) (1235 3 21) (1245 4 21) (1253 5 21) (1254 5 21)
;->  (1264 6 21) (1267 6 21) (1272 7 21) (1275 7 21) (1276 7 21) (1281 8 21)
;->  (1289 8 21) (1310 1 31) (1314 1 31) (1316 1 31) (1319 1 31) (1332 3 31)
;->  (1351 5 31) (1352 5 31) (1355 5 31) (1357 5 31) (1371 7 31) (1382 8 31)
;->  (1384 8 31))
(length pri-pal)
;-> 61

Calcoliamo le date prime e/o palindrome dall'anno 2000 al 2100 (1 gennaio):

(silent 
  (setq pri (filter prime-lst? (data-list '(2000 1 1) '(2100 1 1))))
  (setq pal (filter palindrome? (data-list '(2000 1 1) '(2100 1 1)))))

(length pri)
;-> 3093
(length pal)
;-> 10
(setq pri-pal (intersect pri pal))
;-> ()
pal
;-> ((2010 10 2) (2011 10 2) (2012 10 2) (2013 10 2) (2014 10 2) 
;->  (2015 10 2) (2016 10 2) (2017 10 2) (2018 10 2) (2019 10 2))


----------------------
Torri sulla scacchiera
----------------------

In una scacchiera NxN determinare in quanti modi N torri dominano tutte le caselle della scacchiera.
Per dominare tutte le caselle della scacchiera le N torri devono essere posizionate in modo che:
in tutte le righe ci sia almeno una torre oppure in tutte le colonne ci sia almeno una torre.

Cominciamo calcolando in quanti modi possiamo posizionare N torri in una scachiera NxN.
Si tratta delle combinazioni di k elementi senza ripetizione scelte da una lista di elementi.
I k elementi sono le N torri e la lista di elementi sono le caselle della scacchiera.
Il numero delle combinazioni è conosciuto anche come coefficiente binomiale:

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (C n k) (binom n k))

Calcoliamo il numero di combinazioni per N che va da 2 a 8:

(C 4 2)
;-> 6L
(C 9 3)
;-> 84L
(C 16 4)
;-> 1820L
(C 25 5)
;-> 53130L
(C 36 6)
;-> 1947792L ; 1 milione 947 mila 792
(C 49 7)
;-> 85900584L ; 85 milioni 900 mila 584
(C 64 8)
;-> 4426165368L ; 4 miliardi 426 milioni 165 mila 368

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

Vediamo i passaggi per risolvere questo problema.

Proviamo con una scacchiera 4x4:

(setq N 4)

Creazione delle caselle della scacchiera:

(setq board '())
(for (i 0 (- N 1))
  (for (j 0 (- N 1))
    (push (list i j) board -1)))
;-> ((0 0) (0 1) (0 2) (0 3) (1 0) (1 1) (1 2) (1 3)
;->  (2 0) (2 1) (2 2) (2 3) (3 0) (3 1) (3 2) (3 3))

Creazione di tutte le posizioni possibili:

(silent (setq positions (comb N board)))
(length positions)
;-> 1820

Come è fatta una posizione:

(positions 100)
;-> ((0 0) (0 2) (0 3) (3 1))

Funzione che verifica se una posizione domina tutte le caselle:

(define (domina? pos)
  (let (seq (sequence 0 (- N 1)))
        ; in tutte le righe esiste una torre?
    (or (= '() (difference seq (map first pos)))
        ; in tutte le colonne esiste una torre?
        (= '() (difference seq (map last  pos))))))

(domina? (positions 100))
;-> true

Funzione che stampa una posizione:

(define (print-position pos)
  (for (i 0 (- N 1))
    (for (j 0 (- N 1))
      (if (ref (list i j) pos)
          (print "1 ")
          (print ". ")
      )
    )
    (println)) '>)

(print-position (positions 100))
;-> 1 . 1 1
;-> . . . .
;-> . . . .
;-> . 1 . .

Calcolo delle posizioni dominanti:

;(setq out '())
;(dolist (p positions) (if (domina? p) (push p out -1)))
;(length out)
(setq dominanti (filter domina? positions))
(length dominanti)
;-> 488

Vediamo le prime 10 posizioni dominanti:

(for (i 0 9) (print-position (dominanti i)) (println))
;-> 1 1 1 1   1 1 1 .   1 1 1 .   1 1 1 .   1 1 . 1
;-> . . . .   . . . 1   . . . .   . . . .   . . 1 .
;-> . . . .   . . . .   . . . 1   . . . .   . . . .
;-> . . . .   . . . .   . . . .   . . . 1   . . . .

;-> 1 1 . 1   1 1 . 1   1 1 . .   1 1 . .   1 1 . .
;-> . . . .   . . . .   . . 1 1   . . 1 .   . . 1 .
;-> . . 1 .   . . . .   . . . .   . . . 1   . . . .
;-> . . . .   . . 1 .   . . . .   . . . .   . . . 1

Adesso scriviamo la funzione che calcola le posizioni dominanti data la dimensione N della scacchiera.

(define (find-dominanti N)
  (local (board positions dominanti)
    ; creazione delle caselle della scacchiera
    (setq board '())
    (for (i 0 (- N 1))
      (for (j 0 (- N 1))
        (push (list i j) board -1)))
    ; creazione di tutte le posizioni possibili
    (setq positions (comb N board))
    ; calcolo delle posizioni dominanti
    (filter domina? positions)))

Proviamo:

N = 4
(length (find-dominanti 4))
;-> 488

N = 5
(time (println (length (find-dominanti 5))))
;-> 6130
;-> 340.917

N = 6
(time (println (length (find-dominanti 6))))
;-> 92592
;-> 16537.171

N = 7
(time (println (length (find-dominanti 7))))
Troppo tempo per calcolarlo...

N = 8
(time (println (length (find-dominanti 7))))
Troppo tempo per calcolarlo...

Comunque per N=8 è stato calcolato che esistono 33514312 posizioni dominanti. 


--------------
Numeri di Ulam
--------------

La sequenza dei numeri di Ulam ha le seguenti caratteristiche:
- u(1) = 1
- u(2) = 2
- Per n > 2, u(n) è il più piccolo intero maggiore di u(n-1) che è la somma di due distinti termini esattamente in un modo.

Sequenza OEIS: A002858
Ulam numbers: a(1) = 1, a(2) = 2, for n>2: a(n) = least number > a(n-1) which is a unique sum of two distinct earlier terms.
  1, 2, 3, 4, 6, 8, 11, 13, 16, 18, 26, 28, 36, 38, 47, 48, 53, 57, 62, 69,
  72, 77, 82, 87, 97, 99, 102, 106, 114, 126, 131, 138, 145, 148, 155, 175,
  177, 180, 182, 189, 197, 206, 209, 219, 221, 236, 238, 241, 243, 253, 258,
  260, 273, 282, 309, 316, 319, 324, 339, ...

Funzione che genera la lista di tutte le somme delle coppie di una lista data:

(define (pair-sums lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (+ (lst i) (lst j)) out -1)))))

Algoritmo:

(setq ulam '(1 2))

(setq sums (pair-sums ulam))
;-> (3)
(setq num-to-add 3)
(push num-to-add ulam -1)
;-> (1 2 3)

(setq sums (pair-sums ulam))
;-> (3 4 5)
(setq num-to-add 4)
(push num-to-add ulam -1)
;-> (1 2 3 4)

(setq sums (pair-sums ulam))
;-> (3 4 5 5 6 7)
(setq num-to-add 6)
(push num-to-add ulam -1)
;-> (1 2 3 4 6)

Funzione che trova il numero di Ulam da aggiungere:

(define (find-num-to-add lst somme)
  (let ( (num nil) (trovato nil) )
    (dolist (s somme trovato)
           ; se il numero non si trova già nella sequenza e
           ; ha una sola occorrenza nella lista delle somme
           ; allora abbiamo trovato il numero da aggiungere
           ; alla sequenza corrente
      (if (and (= (ref s lst) nil)
               (= (length (ref-all s somme)) 1))
          (set 'num s 'trovato true)))
    num))

(find-num-to-add '(1 2 3 4) '(3 4 5 5 6 7))
;-> 6
(find-num-to-add '(1 2 3 4) '(3 4 4))
;-> nil

Funzione che calcola i numeri di Ulam fino ad un dato limite:

(define (ulam limite)
  (local (out num-to-add)
    (setq out '(1 2))
    (setq conta 2)
    (while (< conta limite)
      (setq sums (sort (pair-sums out)))
      (setq num-to-add (find-num-to-add out sums))
      ; Segnala che non c'è nessun numero da aggiungere (errore)
      (if (= num-to-add nil) (println "nil: " sums))
      (push num-to-add out -1)
      (++ conta)
    )
    out))

Proviamo:

(ulam 100)
;-> (1 2 3 4 6 8 11 13 16 18 26 28 36 38 47 48 53 57 62 69 72 77 82 87
;->  97 99 102 106 114 126 131 138 145 148 155 175 177 180 182 189 197
;->  206 209 219 221 236 238 241 243 253 258 260 273 282 309 316 319 324
;->  339 341 356 358 363 370 382 390 400 402 409 412 414 429 431 434 441
;->  451 456 483 485 497 502 522 524 544 546 566 568 585 602 605 607 612
;->  624 627 646 668 673 685 688 690)


--------------------------
Congettura di Erdos-Straus
--------------------------

La congettura di Erdos-Straus afferma che per ogni intero N>=2, il numero razionale 4/N si può scrivere come somma di tre frazioni unitarie, ossia esistono tre interi positivi x, y e z tali che:

  4/N = 1/x + 1/y + 1/z

In altre parole, la somma di queste frazioni unitarie è una rappresentazione come frazione egiziana del numero 4/N. 

Ad esempio, per N = 100, esiste una soluzione con x = 60, y = 75 e z = 100

(div 4 100)
;-> 0.04
(add (div 60) (div 75) (div 100))
;-> 004

Nota: moltiplicando entrambi i membri dell'equazione per n*x*y*z si trova la l'equazione diofantea equivalente:
  
  4*x*y*z = n*(x*y + x*z + y*z)

Soluzione brute-force (lenta ed inefficace per N grandi):

(define (solve N limit)
  (for (x 1 limit)
    (for (y (+ x 1) limit)
      (for (z (+ y 1) limit)
        (if (= (* 4 x y z) (* N (+ (* y z) (* x z) (* x y))))
            (println x { } y { } z))))))

Proviamo:

(solve 100 100)
;-> 50 100 100
;-> 60 75 100

(time (solve 100 1000))
;-> 27 525 945
;-> 27 540 900
;-> 27 650 702
;-> 28 315 900
;-> 28 350 700
;-> 28 364 650
;-> ...
;-> 50 70 175
;-> 50 75 150
;-> 55 66 150
;-> 60 75 100
;-> 33037.206 ; 33 secondi


---------------
Trova il numero
---------------

Trovare un numero N che ha le seguenti proprietà:

1) N diviso per 2 o 3 o 4 o 5 o 6 o 7 o 8 o 9 o 10 produce resto 1,
2) N diviso per 11 produce resto 0

Formuliamo il problema in termini matematici:

1) N ≡ 1 (mod k), con k=(2, 3, 4, 5, 6, 7, 8, 9, 10)
2) N ≡ 0 (mod 11)

Il primo punto implica che N - 1 deve essere divisibile per tutti i numeri da 2 a 10.
La condizione diventa quindi che N - 1 deve essere un multiplo del minimo comune multiplo (mcm) di questi numeri.
Il secondo punto ci dice che N deve essere un multiplo di 11.

Algoritmo
a) Calcolare l'mcm dei numeri da 2 a 10.
b) Trovare il primo multiplo di 11 che soddisfa la condizione:
   N ≡ 1 (mod mcm(2,3,4,5,6,7,8,9,10)).

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (map eval (args)) 2))

Funzione che trova il primo oppure tutti i numeri con le proprietà 1) e 2) fino ad un dato limite:

(define (find-N limite all)
  (setq N 0)
  (setq lcm-val (apply lcm (sequence 2 10)))
  (setq stop nil)
  (for (i 1 limite 1 stop)
    (setq cur-val (* i 11))
    (when (= (% cur-val lcm-val) 1)
      (setq N cur-val)
      (if (not all) 
        (setq stop true)
        (println N)
      )
    )
  )
  N)

Proviamo:

(find-N 10000)
;-> 25201

(find-N 10000 true)
;-> 25201
;-> 52921
;-> 80641
;-> 108361


------------------------------------------
Massima sequenza ripetuta di ogni elemento
------------------------------------------

Supponiamo di avere una lista e di voler trovare la massima sequenza ripetuta di ogni elemento.
Per esempio:

lista = (a a c c c b b a a b b b b a a a a a ac c c)
output = a=6, c=3, b=4 --> ((a 6) (c 3) (b 4))

Funzione che trova la massima sequenza consecutiva di un elemento in una lista:

(define (find-max-seq lst item)
  (let ( (max-seq 0) (cur-seq 0) )
    (dolist (x lst)
      (if (= x item)
          (setq cur-seq (+ cur-seq 1))
          ;else
          (begin
            (if (> cur-seq max-seq) (setq max-seq cur-seq))
            (setq cur-seq 0))))
    ; Controlla l'ultima sequenza
    (if (> cur-seq max-seq)
        (setq max-seq cur-seq))
    max-seq))

Funzione che trova la massima sequenza per ogni elemento unico nella lista:

(define (find-max-sequences lst)
  (let ( (uniq (unique lst)) (result '()) )
    (dolist (el uniq)
      (push (list el (find-max-seq lst el)) result -1))))

Proviamo:

(setq lst '(a a c c c b b a a b b b b a a a a a a c c c))

(find-max-sequences lst)
;-> ((a 6) (c 3) (b 4))


------------------------------
Massimo e minimo di tre numeri
------------------------------

Dati tre numeri interi a, b, c, determinare il valore massimo e il valore minimo senza utilizzare le espressioni condizionali (if, cond, ecc.).

Possiamo utilizzare lo "short-circuit evaluation" delle funzioni booleane.

Valore massimo:

(define (max3 a b c)
  (and (> b a) (setq a b)) ; if (a > b) then a = b;
  (and (> c a) (setq a c)) ; if (a > c) then a = c;
  a)

Proviamo:

(max3 1 2 3)
;-> 3
(max3 6 5 4)
;-> 6
(max3 7 9 8)
;-> 9
(max3 1 1 2)
;-> 2
(max3 1 2 1)
;-> 2
(max3 2 1 1)
;-> 2
(max3 1 1 1)
;-> 1

Valore minimo:

(define (min3 a b c)
  (and (< b a) (setq a b)) ; if (a < b) then a = b;
  (and (< c a) (setq a c)) ; if (a < c) then a = c;
  a)

Proviamo:

(min3 1 2 3)
;-> 1
(min3 6 5 4)
;-> 4
(min3 7 9 8)
;-> 7
(min3 2 1 2)
;-> 1
(min3 1 2 2)
;-> 1
(min3 2 2 1)
;-> 1
(min3 1 1 1)
;-> 1

Vedi anche "Ordinare tre numeri" su "Note libere 1".


----------------------------------------
Moltiplicazione (errata) di due frazioni
----------------------------------------

La moltiplicazione tra le frazioni 1/4 e 8/5 vale:

 1     8     8      2
--- * --- = ---- = --- = 0.4
 4     5     20     5

Comunque possiamo anche scrivere:

   1     8     18     2
  --- * --- = ---- = --- = 0.4
   4     5     45     5 

Chiaramente questo ultimo metodo è errato dal punto di vista aritmetico, ma il risultato (per le frazioni 1/4 e 5/8) è esatto.
Quante moltiplicazioni tra due frazioni generano un risultato corretto considerando tutte le frazioni con denominatore e numeratore ad una sola cifra (con numeratore diverso da denominatore)?

Generazione di tutte le frazioni con num e den ad una sola cifra e (num != den):

(setq frac '())
(for (num 1 9)
  (for (den 1 9)
    (if (!= num den) (push (list num den) frac -1))))

(length frac)
;-> 72

Funzione che genera tutte le coppie di una lista:

(define (pair-list lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
          (push (list (lst i) (lst j)) out -1)))))

(length (setq coppie (pair-list frac)))
;-> 2556

(find '((1 4) (8 5)) coppie)
;-> 198

Verifichiamo quali moltiplicazioni tra frazioni portano ad un risultato corretto con il metodo sbagliato:

(dolist (c coppie)
  (setq num1 (c 0 0))  (setq den1 (c 0 1))
  (setq num2 (c 1 0))  (setq den2 (c 1 1))
  (setq val1 (div (+ (* num1 10) num2) (+ (* den1 10) den2)))
  (setq val2 (div (* num1 num2) (* den1 den2)))
  (if (= val1 val2) (println c { } val1 { } val2))
)
;-> ((1 2) (5 4)) 0.625 0.625
;-> ((1 4) (8 5)) 0.4 0.4
;-> ((1 6) (4 3)) 0.2222222222222222 0.2222222222222222
;-> ((1 6) (6 4)) 0.25 0.25
;-> ((1 9) (9 5)) 0.2 0.2
;-> ((2 1) (4 5)) 1.6 1.6
;-> ((2 6) (6 5)) 0.4 0.4
;-> ((4 1) (5 8)) 2.5 2.5
;-> ((4 9) (9 8)) 0.5 0.5

Funzione che valuta se la moltiplicazione tra due frazioni date portano ad un risultato corretto con il metodo sbagliato:

(define (valuta coppia)
  (local (num1 den1 num2 den2 val1 val2)
    (setq num1 (coppia 0 0))  (setq den1 (coppia 0 1))
    (setq num2 (coppia 1 0))  (setq den2 (coppia 1 1))
    ;(println num1 { } den1 { } num2 { } den2)
    (setq val1 (div (+ (* num1 10) num2) (+ (* den1 10) den2)))
    (setq val2 (div (* num1 num2) (* den1 den2)))
    (if (= val1 val2) val1 nil)))

Proviamo:

(valuta '((1 4) (8 5)))
;-> 0.4

(valuta '((1 6) (4 3)))
;-> 0.2222222222222222


---------------
Nomi dei colori
---------------

Dati i valori Red, Green, Blue di un colore (da 0 a 255) restituire il nome del colore.

Per esempio:
Input: (255 0 0)
Output: Red

Per il nome dei colori utilizziamo i risultati del "Color Survey" di xkcd, in cui Randall Munroe ha posto a migliaia di persone la stessa identica domanda (il sondaggio contiene solo dati sui colori completamente saturi):

https://blog.xkcd.com/2010/05/03/color-survey-results/

La risposta finale fu il grafico "satfaces_map.png" che si trova nella cartella "data".
Il grafico è stato poi convertito in un file di testo "sarfaces.txt" (anche questo file si trova nella cartella "data").

Il file "satfaces.txt" contiene per ogni riga le coordinate RGB e il nome del colore:
 [0, 0, 0] black
 [0, 1, 0] black
 [0, 2, 0] black
 ...

Nota: nel file non sono riportate tutte le triplette RGB (16777216).

(define (file-list file-str)
"Create a list with all the lines of a text file"
  (let (lst '())
    (setq file-str (open file-str "read"))
    (while (read-line file-str)
      (push (current-line) lst -1))
    (close file-str)
    lst))

Funzione che calcola la distanza tra due colori RGB:

(define (dist-color col1 col2)
  (local (r1 g1 b1 r2 g2 b2 r g b rmean)
    (map set '(r1 g1 b1) col1)
    (map set '(r2 g2 b2) col2)
    (setq rmean (div (add r1 r2) 2))
    (setq r (sub r1 r2))
    (setq g (sub g1 g2))
    (setq b (sub b1 b2))
    (sqrt (add (>> (int (mul (add 512 rmean) r r)) 8)
               (mul 4 g g)
               (>> (int (mul (add 767 rmean) b b)) 8)))))

(dist-color '(10 30 150) '(250 30 50))
;-> 423.6614214204546
(dist-color '(10 30 150) '(250 30 60))
;-> 415.7294793492519
 
Funzione che trova il nome del colore dato il colore RGB:

(define (color-name col)
  (local (lines cur-col found)
    ; legge il file in una lista di linee
    (setq lines (file-list "satfaces.txt"))
    (setq dist-min 999999)
    (setq found nil)
    (dolist (l lines found)
      ; crea il colore corrente 
      (setq cur-col (map int (find-all {\d+} l)))
      ;(print cur-col) (read-line)
      (cond ((= col cur-col) ; colore trovato
              (setq found true)
              (setq out l))
            (true ; colore non trovato
              ; calcolo distanza dei colori
              (setq dist (dist-color col cur-col))
              ; aggiorna distanza minima?
              (when (< dist dist-min)
                (setq dist-min dist)
                ; colore più vicino al colore dato
                (setq out l)
              )))
    )
    (println out)) '>)

Proviamo:

(color-name '(0 0 0))
;-> [0, 0, 0] black

(color-name '(2 3 5))
;-> [0, 3, 5] black

(color-name '(122 33 55))
;-> [122, 0, 55] maroon


-----------------------------------
Estrazione di numeri da una stringa
-----------------------------------

Per estrarre i numeri interi contenuti in una stringa possiamo usare la seguente espressione:

(setq str1 "a20b-10c")

(map (fn(x) (int x 0 10)) (find-all {-?\d+} str1))
;-> (20 -10)

L'espressione regolare {-?\d+} cattura una o più cifre adiacenti con eventuale segno "-" all'inizio (in forma di stringhe).
La funzione (fn(x) (int x 0 10)) trasforma le stringhe numeriche in interi.

Per estrarre i numeri decimali contenuti in una stringa possiamo usare la seguente espressione:

(setq str2 "pi vale -3.1415, e vale 2.7182, k vale -3, x vale .1, y vale -0.1")

(map float (find-all {-?.?\d+(\.\d+)?} str2))
;-> (-3.1415 2.7182 -3 0.1 -0.1)

L'espressione regolare {-?.?\d+(\.\d+)?} cattura una o più cifre adiacenti con eventuale segno "-" all'inizio ed eventuale "." trattato come cifra (in forma di stringhe).
La funzione float trasforma le stringhe numeriche in numeri decimali (floating point).

Scriviamo una funzione per queste due operazioni:

(define (extract-numbers str decimal)
  (if decimal 
      ; estrae numeri decimali
      (map float (find-all {-?.?\d+(\.\d+)?} str))
      ;else
      ; estrae numeri interi
      (map (fn(x) (int x 0 10)) (find-all {-?\d+} str))))

Proviamo:

(extract-numbers str1)
;-> (20 -10)
(extract-numbers str1 true)
;-> (20 -10)
(extract-numbers str2)
;-> (-3 1415 2 7182 -3 1 0 1)
(extract-numbers str2 true)
;-> (-3.1415 2.7182 -3 0.1 -0.1)


-----------------------------------------------
Funzione che può essere eseguita solo una volta
-----------------------------------------------

Scrivere una funzione che può essere eseguita solo una volta.
Ogni esecuzione successiva alla prima deve generare un errore.
Scriviamo una funzione semplice:

(define (only-one) (println "Only one run.") '>)

(only-one)
;-> Only one run.

Vediamo come è fatta la funzione come lista:

only-one
;-> (lambda () (println "Only one run.") '>)

(nth 0 only-one)
;-> '()
(nth 1 only-one)
;-> (println "Only one run.")
(nth 2 only-one)
;-> '>

Per creare la funzione finale possiamo sostituire l'espressione (println "Only one run.") con un'espressione che genera un errore (error):

(define (only-one)
  (println "Only one run.")
  (setf (nth 1 only-one) '(error)) '>)

Proviamo:

(only-one)
;-> Only one run.

(only-one)
;-> ERR: invalid function : (error)
;-> called from user function (only-one)

Vediamo come è fatta la nuova funzione "only-one":

only-one
;-> (lambda () (error) (setf (nth 1 only-one) '(error)) '>)

============================================================================

