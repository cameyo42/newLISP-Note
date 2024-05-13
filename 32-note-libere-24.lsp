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

============================================================================

