================

 NOTE LIBERE 12

================

---------------------------------
Sviluppo di programmi commerciali
---------------------------------

Lutz:
"The way newLISP is licensed, it does not permit linking or packaging closed source with newLISP together. 

You would have to distribute your closed source in a separate package. Users would have to install a newLISP distribution and then your closed source package.

You cannot distribute newLISP and your closed source application together. But you can distribute/sell you closed source application and let the user install newLISP from the binary installer available at http://newlisp.org/downloads.

Anybody planning distribution of closed source software forming a program together with the newLISP should assume strict interpretation of the GPL at first, then consult a intellectual property (IP-) lawyer specialized in software, and consult me if modifications are desired."


---------------------------
The Paradox of the Question
---------------------------

From "The Paradox of the Question" by Markosian Ned (1997), Analysis 57: 95–7.

Once upon a time, during a large and international conference of the world’s leading philosophers, an Angel miraculously appeared and said:
"I come to you as a messenger from God. You will be permitted to ask any one question you want – but only one! – and I will answer that question truthfully. What would you like to ask?"
...

Il documento prosegue discutendo il problema di trovare la domanda migliore.

Penso che un programmatore lisp chiederebbe all'Angelo di valutare qualcosa del genere:

  (map answer (cure all diseases, stop all wars, eliminate poverty, ...))


----------------------------------
Copia/Taglia e Incolla una stringa
----------------------------------

Data una stringa e una lista di coppie di indici, effettuare N volte la copia/il taglio di una sottostringa e aggiungerlo alla fine della stringa.
Gli indici di ogni copia/taglio sono definiti dalla lista degli indici.
Il numero di copie/tagli N deve essere uguale al numero di elementi della lista degli indici.
La sottostringa da tagliare parte dal primo indice di una coppia e finisce al secondo indice (compreso).
Gli indici sono compresi tra 0 e (lunghezza della stringa - 1).

Esempio di copia e incolla
--------------------------
stringa: "newLISP"
lista indici: ((0 2) (3 4))
substring "newLISP" da 0 a 2 = "new" (copia)
stringa: "newLISP" + "new" = "newLISPnew"
substring: "newLISPnew" da 3 a 4: "LI" (copia)
stringa: "newLISPnew" + "LI" = "newLISPnewLI"

(define (copy-paste str indexes)
    (dolist (el indexes)
      (extend str (slice str (el 0) (+ (- (el 1) (el 0)) 1)))
    )
    str)

(copy-paste "newLISP" '((0 2) (3 4)))
;-> "newLISPnewLI"

(copy-paste "massimo" '((0 1) (2 4) (1 3) (0 6) (5 6)))
;-> "massimomassiassmassimomo"

Esempio di taglia e incolla
---------------------------
stringa: "newLISP"
lista indici: ((0 2) (3 4))
substring "newLISP" da 0 a 2 = "new" (taglio)
stringa: "LISP" + "new" = "LISPnew"
substring: "LISPnew" da 3 a 4: "Pn" (taglio)
stringa: "LISewPn"

(define (cut-paste str indexes)
    (dolist (el indexes)
      (extend str (pop str (el 0) (+ (- (el 1) (el 0)) 1)))
    )
    str)

(cut-paste "newLISP" '((0 2) (3 4)))
;-> LISewPn

(cut-paste "AYBABTU" '((2 4) (2 4)))
;-> "AYABTUB"

(cut-paste "massimo" '((0 1) (2 4) (1 3) (0 6) (5 6)))
;-> "simosma"


--------------------
Massima Sequenza DNA
--------------------

Una sequenza di DNA è una stringa composta da caratteri A, C, G e T.
Data una stringa che rappresenta una sequenza di DNA, trovare la ripetizione più lunga nella sequenza.
Questa è la sottostringa di lunghezza massima contenente un solo tipo di carattere.
Nota:
 Adenina (Adenine) (A),
 Citosina (Cytosine) (C),
 Guanina (Guanine) (G),
 Timina (Thymine) (T).

(setq dna "AAAAACGGGAAATTTCCCTTTTAAATCGTAAACCCCCCCTAGCTAGG")

(define (max-seq str)
  (setq max-val 0)
  (setq cur (first str))
  (setq conta 0)
  (setq base cur)
  (dolist (ch (explode str))
    (if (= ch cur) ; caratteri uguali
        (begin
          (++ conta)
          (if (> conta max-val)
              (set 'max-val conta 'base cur)
          )
        )
        ;else (caratteri diversi)
        (begin
          (setq conta 1)
          (setq cur ch)
        )
    )
  )
  (list max-val base))

(max-seq dna)
;-> (7 "C")


----------------------
Il gioco della tombola
----------------------

Scriviamo un programma che simula una partita a tombola.

Per la generazione delle cartelle vedi "Generazione delle cartelle della tombola" nel capitolo "Note Libere 11".

(tombola true)
;->  0  0 22 34 40  0 60  0 82
;->  5 10 26  0  0  0 64  0 83
;->  0 18  0 38 49 55  0 78  0
;->
;->  0 13  0 30 41  0  0 73 80
;->  0  0  0 32 43 50  0 76 88
;->  6 19 28  0  0 51 61  0  0
;->
;->  4  0  0  0 45 56  0 71 86
;->  7 12 21  0 46  0  0  0 89
;->  0  0 23 37  0 58 69 74  0
;->
;->  0  0 27  0 42 53 65  0 85
;->  3  0  0  0 48  0 67 77 87
;->  0 15 29 33  0 59  0 79  0
;->
;->  0 14 20 31  0 54  0  0 81
;->  2 17 24 35  0  0 66  0  0
;->  8  0  0  0  0 57 68 75 84
;->
;->  1  0  0 36 44  0 62 70  0
;->  9 11  0 39  0  0 63  0 90
;->  0 16 25  0 47 52  0 72  0

Cartelle della tombola:

(setq c1 '(
(0  0 22 34 40  0 60  0 82)
(5 10 26  0  0  0 64  0 83)
(0 18  0 38 49 55  0 78  0)))
(setq c2 '(
(0 13  0 30 41  0  0 73 80)
(0  0  0 32 43 50  0 76 88)
(6 19 28  0  0 51 61  0  0)))
(setq c3 '(
(4  0  0  0 45 56  0 71 86)
(7 12 21  0 46  0  0  0 89)
(0  0 23 37  0 58 69 74  0)))
(setq c4 '(
(0  0 27  0 42 53 65  0 85)
(3  0  0  0 48  0 67 77 87)
(0 15 29 33  0 59  0 79  0)))
(setq c5 '(
(0 14 20 31  0 54  0  0 81)
(2 17 24 35  0  0 66  0  0)
(8  0  0  0  0 57 68 75 84)))
(setq c6 '(
(1  0  0 36 44  0 62 70  0)
(9 11  0 39  0  0 63  0 90)
(0 16 25  0 47 52  0 72  0)))

Lista delle cartelle:

(setq cartelle (list c1 c2 c3 c4 c5 c6))

Funzione che controlla se una cartella ha fatto ambo:

(define (ambo? cartella estratti)
  (let (res nil)
          ; prima riga: 2 numeri uguali?
    (cond ((= 2 (apply + (count estratti (cartella 0))))
           (setq res (intersect (cartella 0) estratti)))
          ; seconda riga: 2 numeri uguali?
          ((= 2 (apply + (count estratti (cartella 1))))
           (setq res (intersect (cartella 1) estratti)))
          ; terza riga: 2 numeri uguali?
          ((= 2 (apply + (count estratti (cartella 2))))
           (setq res (intersect (cartella 2) estratti)))
    )
    res))

Funzione che controlla se una cartella ha fatto terno:

(define (terno? cartella estratti)
  (let (res nil)
    (cond ((= 3 (apply + (count estratti (cartella 0))))
           (setq res (intersect (cartella 0) estratti)))
          ((= 3 (apply + (count estratti (cartella 1))))
           (setq res (intersect (cartella 1) estratti)))
          ((= 3 (apply + (count estratti (cartella 2))))
           (setq res (intersect (cartella 2) estratti)))
    )
    res))

Funzione che controlla se una cartella ha fatto quaterna:

(define (quaterna? cartella estratti)
  (let (res nil)
    (cond ((= 4 (apply + (count estratti (cartella 0))))
           (setq res (intersect (cartella 0) estratti)))
          ((= 4 (apply + (count estratti (cartella 1))))
           (setq res (intersect (cartella 1) estratti)))
          ((= 4 (apply + (count estratti (cartella 2))))
           (setq res (intersect (cartella 2) estratti)))
    )
    res))

Funzione che controlla se una cartella ha fatto cinquina:

(define (cinquina? cartella estratti)
  (let (res nil)
    (cond ((= 5 (apply + (count estratti (cartella 0))))
           (setq res (intersect (cartella 0) estratti)))
          ((= 5 (apply + (count estratti (cartella 1))))
           (setq res (intersect (cartella 1) estratti)))
          ((= 5 (apply + (count estratti (cartella 2))))
           (setq res (intersect (cartella 2) estratti)))
    )
    res))

Funzione che controlla se una cartella ha fatto tombola:

(define (tombola? cartella estratti)
  (if (= 15 (apply + (count estratti (flat cartella))))
      (clean zero? (flat cartella))
      nil))

Lista dei numeri usciti:

(setq fuori '(5 83 49 12 6 4 28 7 54 89))

Verifichiamo i punteggi di ogni cartella con la lista degli usciti:

(dolist (c cartelle)
  (println "cartella " (+ $idx 1))
  (println (ambo? c fuori))
  (println (terno? c fuori))
  (println (quaterna? c fuori))
  (println (cinquina? c fuori))
  (println (tombola? c fuori))
)

Verifichiamo i punteggi di ogni cartella con la lista di tutti i numeri usciti:

(setq all (sequence 1 90))

(dolist (c cartelle)
  (println "cartella " (+ $idx 1))
  (println (ambo? c all))
  (println (terno? c all))
  (println (quaterna? c all))
  (println (cinquina? c all))
  (println (tombola? c all))
)
;-> cartella 1
;-> nil
;-> nil
;-> nil
;-> (22 34 40 60 82)
;-> ((0 0 22 34 40 0 60 0 82) (5 10 26 0 0 0 64 0 83) (0 18 0 38 49 55 0 78 0))
;-> cartella 2
;-> nil
;-> nil
;-> nil
;-> (13 30 41 73 80)
;-> ((0 13 0 30 41 0 0 73 80) (0 0 0 32 43 50 0 76 88) (6 19 28 0 0 51 61 0 0))
;-> cartella 3
;-> nil
;-> nil
;-> nil
;-> (4 45 56 71 86)
;-> ((4 0 0 0 45 56 0 71 86) (7 12 21 0 46 0 0 0 89) (0 0 23 37 0 58 69 74 0))
;-> cartella 4
;-> nil
;-> nil
;-> nil
;-> (27 42 53 65 85)
;-> ((0 0 27 0 42 53 65 0 85) (3 0 0 0 48 0 67 77 87) (0 15 29 33 0 59 0 79 0))
;-> cartella 5
;-> nil
;-> nil
;-> nil
;-> (14 20 31 54 81)
;-> ((0 14 20 31 0 54 0 0 81) (2 17 24 35 0 0 66 0 0) (8 0 0 0 0 57 68 75 84))
;-> cartella 6
;-> nil
;-> nil
;-> nil
;-> (1 36 44 62 70)
;-> ((1 0 0 36 44 0 62 70 0) (9 11 0 39 0 0 63 0 90) (0 16 25 0 47 52 0 72 0))

Variabili che controllano quale punteggio è già uscito:

(setq ambo nil)
(setq terno nil)
(setq quaterna nil)
(setq cinquina nil)
(setq tombola nil)

; lista con i numeri della tombola da 1 a 90 mischiati
(setq sacchetto (randomize (sequence 1 90)))
; lista con i numeri usciti
(setq usciti '())

Funzione che estrae un numero:

(define (estrazione) ; sacchetto, usciti
  ; estrae ed elimina il primo numero dalla lista sacchetto
  (let (estratto (pop sacchetto))
    ; inserisce il numero estratto nella lista degli usciti
    (push estratto usciti)
    estratto))

(estrazione)
;-> 68

Funzione che verifica se una cartella ha fatto un punteggio con i numeri usciti:
Restituisce il punteggio maggiore oppure nil.

(define (result-cartella cartella usciti)
  (local (res)
    (setq res nil)
    (cond ((tombola? cartella usciti) (setq res (tombola? cartella usciti)))
          ((cinquina? cartella usciti) (setq res (cinquina? cartella usciti)))
          ((quaterna? cartella usciti) (setq res (quaterna? cartella usciti)))
          ((terno? cartella usciti) (setq res (terno? cartella usciti)))
          ((ambo? cartella usciti) (setq res (ambo? cartella usciti)))
    )
    res))

(result-cartella c1 fuori)
;-> (5 83)
(result-cartella c1 all)
;-> (22 34 40 60 82 5 10 26 64 83 18 38 49 55 78)

Funzione che simula una partita a tombola:

(define (run-tombola cartelle)
  (local (sacchetto usciti tombola res)
    ; lista con i numeri della tombola da 1 a 90 mischiati
    (setq sacchetto (randomize (sequence 1 90)))
    ; lista con i numeri usciti
    (setq usciti '())
    ; nessuno ha fatto tombola
    (setq tombola nil)
    ; ciclo di estrazione di tutti i numeri della tombola
    (while (and sacchetto (not tombola))
      ;(println)
      (print "Prossimo numero: " (read-line))
      (setq num-estratto (estrazione))
      (println num-estratto)
      ; controllo del risultato di ogni cartella
      (dolist (crt cartelle)
        (if (setq res (result-cartella crt usciti))
              (println "cartella " (+ $idx 1) ": " res))
        ; controllo se ha fatto tombola (finisce il gioco)
        (if (= 15 (length res)) (setq tombola true))
      )
    )))

(run-tombola cartelle)
;-> Prossimo numero:
;-> 1
;-> Prossimo numero:
;-> 52
;-> Prossimo numero:
;-> 49
;-> Prossimo numero:
;-> 41
;-> Prossimo numero:
;-> 63
;-> Prossimo numero:
;-> 65
;-> Prossimo numero:
;-> 79
;-> Prossimo numero:
;-> 6
;-> Prossimo numero:
;-> 10
;-> Prossimo numero:
;-> 77
;-> Prossimo numero:
;-> 60
;-> Prossimo numero:
;-> 15
;-> cartella 4: (15 79)
;-> Prossimo numero:
;-> 57
;-> cartella 4: (15 79)
;-> Prossimo numero:
;-> 81
;-> cartella 4: (15 79)
;-> Prossimo numero:
;-> 88
;-> cartella 4: (15 79)
;-> Prossimo numero:
;-> 90
;-> cartella 4: (15 79)
;-> cartella 6: (63 90)
;-> Prossimo numero:
;-> 39
;-> cartella 4: (15 79)
;-> cartella 6: (39 63 90)
;-> Prossimo numero:
;-> 78
;-> cartella 1: (49 78)
;-> cartella 4: (15 79)
;-> cartella 6: (39 63 90)
;-> ...
;-> ...
;-> ...
;-> ...
;-> Prossimo numero:
;-> 24
;-> cartella 1: (22 34 40 60 82)
;-> cartella 2: (32 43 50 76 88)
;-> cartella 3: (4 45 56 71 86)
;-> cartella 4: (3 48 67 77 87)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (16 25 47 52 72)
;-> Prossimo numero:
;-> 73
;-> cartella 1: (22 34 40 60 82)
;-> cartella 2: (13 30 41 73 80)
;-> cartella 3: (4 45 56 71 86)
;-> cartella 4: (3 48 67 77 87)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (16 25 47 52 72)
;-> Prossimo numero:
;-> 55
;-> cartella 1: (22 34 40 60 82)
;-> cartella 2: (13 30 41 73 80)
;-> cartella 3: (4 45 56 71 86)
;-> cartella 4: (3 48 67 77 87)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (16 25 47 52 72)
;-> Prossimo numero:
;-> 51
;-> cartella 1: (22 34 40 60 82)
;-> cartella 2: (13 30 41 73 80 32 43 50 76 88 6 19 28 51 61)
;-> cartella 3: (4 45 56 71 86)
;-> cartella 4: (3 48 67 77 87)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (16 25 47 52 72)


--------------------------------------------
Modi per distribuire m oggetti tra n persone
--------------------------------------------

Dati M e N che rappresentano rispettivamente il numero di oggetti e il numero di persone.
Calcolare il numero di modi per distribuire m oggetti tra N persone.

Considerando entrambe le variabili M e N, abbiamo 4 casi in base a come sono definiti gli oggetti e le persone:

1) M oggetti identici e N persone identiche
   (m m m ... m)        (n n n ... n)
Gli oggetti sono tutti uguali e le persone sono tutte uguali (cioè gli oggetti non sono distinguibili tra loro e le persone non sono distinguibili tra loro).

2) M Oggetti unici e N persone identiche
   (m1 m2 m3 ... mM) (n n n ... n)
Gli oggetti sono tutti diversi e le persone sono tutte uguali (cioè gli oggetti sono distinguibili tra loro e le persone non sono
distinguibili tra loro).

3) M Oggetti identici e N persone uniche
   (m m m ... m)        (n1 n2 n3 ... nN)
Gli oggetti sono tutti uguali e le persone sono tutte diverse (cioè gli oggetti non sono distinguibili tra loro e le persone sono distinguibili tra loro).

4) M Oggetti unici e N persone uniche
   (m1 m2 m3 ... mM) (n1 n2 n3 ... nN)
Gli oggetti sono tutti diversi e le persone sono tutte diverse (cioè gli oggetti sono distinguibili tra loro e le persone sono distinguibili tra loro).

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

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

Caso 1: Distribuzione di m oggetti identici tra n persone identiche

   modi = binom[(m + n - 1) (n - 1)]

(define (identici-identici m n)
  (binom (+ m n (- 1)) (- n 1)))

(identici-identici 3 2)
;-> 4L
(identici-identici 11 3)
;-> 78L
(identici-identici 13 6)
;-> 8568L
(identici-identici 7 5)
;-> 330L

Caso 2: Distribuzione di m oggetti unici tra n persone identiche

   modi = binom[(m + n - 1) (n - 1)] * m!

(define (unici-identici m n)
  (* (binom (+ m n (- 1)) (- n 1)) (fact-i m)))

(unici-identici 3 2)
;-> 24L
(unici-identici 11 3)
;-> 3113510400L
(unici-identici 13 6)
;-> 53353114214400L
(unici-identici 7 5)
;-> 1663200L

Caso 3: Distribuzione di m oggetti identici tra n persone uniche

   modi = binom[(m + n - 1) (n - 1)] * (n - 1)!

(define (identici-unici m n)
  (* (binom (+ m n (- 1)) (- n 1)) (fact-i (- n 1))))

(identici-unici 3 2)
;-> 24L
(identici-unici 11 3)
;-> 156L
(identici-unici 13 6)
;-> 1028160L
(identici-unici 7 5)
;-> 7920L

Caso 4: Distribuzione di m oggetti unici tra n persone uniche

  modi = binom[(m + n - 1) (n - 1)] * m! * (n - 1)!

(define (unici-unici m n)
  (* (binom (+ m n (- 1)) (- n 1)) (fact-i (- n 1)) (fact-i m)))

(unici-unici )

(unici-unici 3 2)
;-> 24L
(unici-unici 11 3)
;-> 6227020800L
(unici-unici 13 6)
;-> 6402373705728000L
(unici-unici 7 5)
;-> 39916800L

Per le dimostrazioni vedere:

https://www.geeksforgeeks.org/count-ways-to-distribute-m-items-among-n-people/


------------------------------
Problema di algebra elementare
------------------------------

Sapendo che a + b = x e a^2 + b^2 = y, scrivere una funzione per calcolare quanto vale a^3 + a^3.

Algebricamente:

1)  a + b = x
2)  a^2 + b^2 = y
3)  a^3 + a^3 ?

Vediamo un esempio del processo di soluzione con x = 1 e y = 2.

1)  a + b = 1
2)  a^2 + b^2 = 2
3)  a^3 + a^3 ?

Eleviamo al quadrato entrambi i membri della 1):

(a + b)^2 = 1^2

a^2 + b^2 + 2ab = 1

Sostituiamo la 2) nell'ultima equazione:

2 + 2ab = 1  ==>  2ab = -1  ==> ab = -1/2

Adesso eleviamo al cubo la 1):

(a + b)^3 = 1^3
a^3 + b^3 + 3*ab*(a + b) = 1

Sostituiamo ab = -1/2 e (a + b) = 1 nell'ultima equazione:

a^3 + b^3 + 3*(-1/2)*(1) = 1
a^3 + b^3 - 3/2 = 1  ==>  a^3 + b^3 = 5/2

Adesso facciamo lo stesso procedimento utilizzando le variabili x e y:

1)  a + b = x
2)  a^2 + b^2 = y
3)  a^3 + a^3 ?

Eleviamo al quadrato entrambi i membri della 1):

(a + b)^2 = x^2

a^2 + b^2 + 2ab = x^2

Sostituiamo la 2) nell'ultima equazione:

y + 2ab = x^2  ==>  2ab = x^2 - y  ==>  ab = (x^2 - y)/2

Adesso eleviamo al cubo la 1):

(a + b)^3 = x^3

a^3 + b^3 + 3*ab*(a + b) = 1

Sostituiamo ab = (x^2 - y)/2 e (a + b) = x nell'ultima equazione:

a^3 + b^3 + 3 * ((x^2 - y)/2) * x = x^3

Da cui ricaviamo la soluzione:

a^3 + b^3 = x^2 - 3 * ((x^2 - y)/2) * x

Scriviamo la funzione che risolve il problema:

(define (cubo x y)
  (sub (mul x x x) (mul 3 x (div (sub (mul x x) y) 2))))

Facciamo alcune prove:

(cubo 1 2)
;-> 2.5 ;5/2

a = 2, b = 2
a + b = 4
a^2 + b^2 = 8
a^3 + b^3 = 16
(cubo 4 8)
;-> 16

a = 21
b = 12
a + b = 33
a^2 + b^2 = 585
a^3 + b^3 = 10989
(cubo 33 585)
;-> 10989


---------------------------------
Minimo e massimo tra due frazioni
---------------------------------

Scrivere due funzione per calcolare il valore minimo e il valore massimo tra due frazioni.

Per esempio, 11/18 è maggiore/uguale/minore di 5/8?

Il metodo classico è quello di utilizzare il MCM dei denominatori:

MCM(18 8) = 72

 11     11*4     44
---- = ------ = ----
 18      72      72

 5     5*9     45
--- = ----- = ----
 8      72     72

Poichè 44 < 45, allora 11/8 è minore di 5/8.

Possiamo usare un metodo più rapido.
Consideriamo le due frazioni:

        num1            num2
  f1 = ------,    f2 = ------
        den1            den2

Calcoliamo i seguenti due valori:

  val1 = num1 * den2

  val2 = num2 * den1

Se val1 > val2, allora f1 > f2
Se val1 = val2, allora f1 = f2
Se val1 < val2, allora f1 < f2

Infatti, utilizzando l'esempio otteniamo:

f1 = 11/18, f2 = 5/8

val1 = 11*8 = 88
val2 = 18*5 = 90

Poichè val1 < val2, allora 11/18 < 5/8.

Questo metodo funziona perchè è lo stesso del metdo classico, tranne il fatto che il denominatore comune delle due frazioni non è il MCM dei due denominatori, ma un semplice multiplo di entrambi:

 11     11*8      88
---- = ------ = -----
 18     144      144

 5     5*18      90
--- = ------ = -----
 8      144     144

Adesso possiamo scrivere le funzioni.

(define (min-f f1 f2)
  (if (<= (* (f1 0) (f2 1)) (* (f1 1) (f2 0))) f1 f2))

(define (max-f f1 f2)
  (if (>= (* (f1 0) (f2 1)) (* (f1 1) (f2 0))) f1 f2))

(max-f '(11 18) '(5 8))
;-> (5 8)

(min-f '(11 18) '(5 8))
;-> (11 18)


-------------------------
Eventi singoli e ripetuti
-------------------------

Supponiamo di lanciare un dado a N facce per N volte.
Nella sequenza risultante alcuni numeri saranno unici (cioè usciti solo una volta) e altri numeri saranno ripetuti più volte.
Quanto vale la percentuale dei numeri che sono usciti solo una volta?

Scriviamo una funzione che simula il processo.

Come contare gli elementi univoci di una lista:

(setq a (rand 100 100))
;-> (5 2 3 0 5 3 3 0 9 8)
(setq u (unique a))
;-> (5 2 3 0 9 8)
(count u a)
;-> (2 1 3 2 1 1)
(length (filter (fn(x) (= x 1)) (count u a)))
;-> 3
(length (filter (fn(x) (> x 1)) (count u a)))

Funzione che simula il processo:

(define (simula side iter)
  (local (roll univoci uniq uni% mul%)
    (setq univoci 0)
    (for (i 1 iter)
      (setq roll (map (fn(x) (+ x 1)) (rand side side)))
      (setq uniq (unique roll))
      (setq univoci (+ univoci
            (length (filter (fn(x) (= x 1)) (count uniq roll)))))
    )
    (setq uni% (div univoci iter))
    (setq mul% (sub side uni%))
    (list uni% mul%)))

Facciamo alcune prove:

(simula 10 1e4)
;-> (3.8765 6.1235)
(simula 100 1e4)
;-> (36.9606 63.0394)
(simula 1000 1e4)
;-> (367.9226 632.0774)
(time (println (simula 10000 1e4)))
;-> (3647.6315 6352.368500000001)
;-> 109041.716

Proviamo a velocizzare la funzione di simulazione utilizzando un vettore (con numeri casuali da 0 a N-1).

(define (simula2 side iter)
  (local (univoci ar roll uni% mul%)
    (setq univoci 0)
    (for (i 1 iter)
      (setq ar (array side '(0)))
      (setq roll (rand side side))
      (dolist (r roll)
        (++ (ar r))
      )
      (setq univoci
           (+ univoci (length (filter (fn(x) (= x 1)) (array-list ar)))))
    )
    (setq uni% (div univoci iter))
    (setq mul% (sub side uni%))
    (list uni% mul%)))

Facciamo alcune prove:

(simula2 10 1e4)
;-> (3.8484 6.1516)
(simula2 100 1e4)
;-> (37.0575 62.9425)
(simula2 1000 1e4)
;-> (368.4869 631.5131)
(time (println (simula2 10000 1e4)))
;-> (3647.1127 6352.8873)
;-> 22550.796

Proviamo con un altra funzione:

(define (simula3 side iter)
  (local (roll univoci uni% mul%)
    (setq univoci 0)
    (for (i 1 iter)
      (setq ar (array side '(0)))
      (for (i 1 side)
        (++ (ar (rand side)))
      )
      (setq univoci
           (+ univoci (length (filter (fn(x) (= x 1)) (array-list ar)))))
    )
    (setq uni% (div univoci iter))
    (setq mul% (sub side uni%))
    (list uni% mul%)))

(simula3 10 1e4)
;-> (3.8634 6.1366)
(simula3 100 1e4)
;-> (36.9194 63.0806)
(simula3 1000 1e4)
;-> (368.0959 631.9041)
(time (println (simula3 10000 1e4)))
;-> (3647.323 6352.677)
;-> 24670.112

Adesso vediamo la soluzione matematica.
Dobbiamo contare il numero previsto di lanci distinti.
Definiamo una variabile casuale Xi come 1 se il lancio i appare in qualsiasi momento nei 100 lanci e 0 altrimenti.
Ciò significa che E(Xi) è la probabilità che il tiro i appaia come uno dei 100 tiri.
Quanti numeri distinti compaiono in 100 lanci?
Dobbiamo sommare le possibilità che appaia il lancio 1, appaia il lancio 2 e così via.
In altre parole, il numero di lanci diversi è la somma prevista per ciascuno dei 100 lanci.
Questa è la somma di E(Xi), dove i va da 1 a 100:

  E(lanci distinti) = E(X1) + ... + E(X100)

Per simmetria e indipendenza di ogni tiro, la possibilità che appaia il tiro 1 è la stessa che appaia il tiro 2, o appaia 3, o appaia qualsiasi tiro i. Quindi tutti gli E(Xi) devono essere uguali.
Quindi possiamo riscrivere la somma come 100 volte E(X1).

  E(lanci diversi) = 100 E(X1)

Qual è la probabilità che appaia il risultato 1?
Possiamo calcolare più facilmente la possibilità che non appaia.
C'è una probabilità 99/100 che un dato tiro non sia un 1.
Con 100 tiri, questo porta a una (99/100)^100 possibilità che il tiro 1 non appaia affatto.
La possibilità che appaia il risultato 1 è l'evento complementare di 1 - (99/100)^100 = E(X1).
Quindi, abbiamo:

  E(lanci diversi) = 100*(1 - (99/100)^100)
  E(lanci diversi) = 63.39676587267711

(mul 100 (sub 1 (pow (div 99 100) 100)))
;-> 63.39676587267711

Questo processo genera circa il 63% di lanci multipli, indipendentemente dalla dimensione di N.
Su un dado a N facce, c'è una possibilità (1 - 1/N) che un particolare tiro i non appaia.
In N lanci, la possibilità che il lancio i non appaia affatto è (1 - 1/N)^N.
Se lo sommiamo negli N lanci e poi lo dividiamo per gli N lanci diversi totali, i termini di N verranno annullati.
Ciò significa che la proporzione di lanci diversi è (1 - 1/N)^N.
Poiché N va all'infinito, il limite di questo termine è 1 - 1/e = 0.6321205588285577.

(setq e (exp 1))
;-> 2.718281828459045

(1 - 1/e) =
(sub 1 (div e))
;-> 0.6321205588285577


----------------------------
Somma delle coppie e ritorno
----------------------------

1) Data una lista di numeri interi positivi, costruire la lista di tutte le somme delle coppie degli elementi della lista.

La lista delle somme delle coppie per una lista con n elementi è la seguente:

(lst[0]+lst[1], lst[0]+lst[2], ..., lst[1]+lst[ 2], lst[1]+lst[3], ..., lst[2]+lst[3], lst[2]+lst[4], …., lst[n-2]+lst[n -1).

Funzione che genera la lista delle somme delle coppie:

(define (sum-pair lst)
  (local (res lenA lenB sumA sumB)
    (setq res '())
    (dolist (el lst)
      ;(if (!= $idx (- len 1))
        (extend res (map (fn(x) (+ el x)) (slice lst (+ $idx 1))))
      ;)
    )
    res))

Facciamo alcune prove:

(setq a '(1 2 3))
(sum-pair a)
;-> (3 4 5)

(setq b '(1 3 3 3))
(sum-pair b)
;-> (4 4 4 6 6 6)

(setq c '(3 2 1 4))
(sum-pair c)
;-> (5 4 7 3 6 5)

(setq d '(1 3 2 7 4 6 5))
(sum-pair d)
;-> (4 3 8 5 7 6 5 10 7 9 8 9 6 8 7 11 13 12 10 9 11)

(setq e '(8 7 5 3 2))
(sum-pair e)
;-> (15 13 11 10 12 10 9 8 7 5)

2) Data una lista di tutte le somme delle coppie degli elementi di un'altra lista, costruire quest'ultima lista.

Se N è la lunghezza di una lista, allora la sua lista delle coppie è lunga:

  M =  N*(N-1)/2

Se la lista delle coppie è lunga M, allora la lista che la genera è lunga:

  M = N*(N-1)/2  -->  N^2 - N - 2M = 0

       1 + sqrt(8M +1)
  N = -----------------
             2

Adesso vediamo una lista con 3 elementi:
 A = (a0 a1 a2)
 B = (b0 b1 b2)
 B = ((a0 + a1) (a0 + a2) (a1 + a2))

Per trovare le soluzioni bisogna fare alcuni passaggi algebrici, ad esempio calcoliamo a0:

 b0 + b1 = (a0 + a1) + (a0 + a2) = 2a0 + (a1 + a2) = 2a0 + b3

Quindi, a0 = 1/2 (b0 + b1 - b2).

Analogamente troviamo le altre soluzioni:

 a0 = 1/2 (b0 + b1 - b2)
 a1 = 1/2 (b0 - b1 + b2)
 a2 = 1/2 (-b0 + b1 + b2)

Se proviamo con una lista di 4 elementi, si osserva che risulta sempre:

  a[0] = (b[0] + b[1] – b[n-1])/ 2.

Si noti che il valore di:

    b[0] + b[1] – b[n-1] = (a[0] + a[1]) + (a[0] + a[2]) – (a[1] + a[2])

Una volta valutato a[0], possiamo valutare altri elementi sottraendo a[0].
Ad esempio, a[1] può essere valutato sottraendo a[0] dalla b[0],
a[2] può essere valutato sottraendo a[0] dalla b[1], e cosi via.

(define (desum-pair lst)
  (local (len-lst len res)
    (setq len-lst (length lst))
    ; lunghezza della lista soluzione
    (setq len (/ (+ 1 (sqrt (+ 1 (* 8 len-lst)))) 2))
    (setq res (array len '(0)))
    ; imposta il primo valore
    (setf (res 0) (/ (+ (lst 0) (lst 1) (- (lst (- len 1)))) 2))
    ; imposta i rimanenti valori
    (for (i 1 (- len 1))
      (setf (res i) (- (lst (- i 1)) (res 0)))
    )
    res))

Facciamo alcune prove:

(desum-pair '(3 4 5))
;-> (1 2 3)

(desum-pair '(4 4 4 6 6 6))
;-> (1 3 3 3)

(desum-pair '(5 4 7 3 6 5))
;-> (3 2 1 4)

(desum-pair '(4 3 8 5 7 6 5 10 7 9 8 9 6 8 7 11 13 12 10 9 11))
;-> (1 3 2 7 4 6 5)

(desum-pair '(15 13 11 10 12 10 9 8 7 5))
;-> (8 7 5 3 2)

(desum-pair (sum-pair '(2 9 8 3 5 6 1)))
;-> (2 9 8 3 5 6 1)


---------------------------
Get data from a C structure
---------------------------

Post by Lutz Mueller:
'unpack', 'get-integer' and 'get-char' all take memory (or string) addresses as an argument. You just need the memory address of you structure o union. Lets say you have the following in you library to import:

#include <stdio.h>

struct mystruct {
   char * msg;
   int intNumber;
   double dFloat;
   } data;

struct mystruct * foo(void)
{
data.msg = "hello";
data.intNumber = 123;
data.dFloat = 123.456;

return(&data);
}

Compile it to a library:

gcc test.c -lm -shared -o test.so

Now import into newLISP:

> (import "./test.so" "foo")
foo <281A0554>

> (unpack "lu ld lf" (foo))
(672794072 123 123.456)

> (get-string 672794072) => "hello"

Note that in 'C' on a Linux PC 'char *' and 'int' are 32 bit and 'double' is a 64 bit float as used in newLISP.
I used 'lu' to retrieve the pointer .
Sometimes a 'C' function takes a pointer to an existing memory area. In this case you just allocate memory in a string:

(set 'buff (dup "\000" 10)) ;; 10 bytes of zeroed memory

and pass it to the function:

int foo(char * buff)
{
strcpy(buff, "hello");
return(0);
}

and from newLISP:

(foo buff)

buff => "hello"

All of the database modules like mysql.lsp, sqlite.lsp and osbd.lsp make heavily use of these techniques.


-----------------------------------
Radice quadrata di numeri complessi
-----------------------------------

In genere, quando calcoliamo la radice quadrata sqrt(4) la risposta 2 è sufficiente per i nostri scopi. Comunque la risposta non è completa, infatti sqrt(4) = 2 e -2.
Se consideriamo questo aspetto matematico, allora possiamo pensare di estendere la funzione "sqrt" ai numeri complessi, ad esempio sqrt(-1).

; srt and new-sqrt
; by Kazimir Majorinc
(set '*. mul '/. div '+. add '-. sub)
(set 'old-sqrt sqrt)
(set 'pi (*. 2 (acos 0)))

(set 'ro (lambda(z)
            (old-sqrt (+. (*. (nth 0 z) (nth 0 z))
                          (*. (nth 1 z) (nth 1 z))))))

(set 'phi (lambda(z)
            (cond ((= (nth 1 z) 0)(if (>= (nth 0 z) 0)
                                      0
                                      pi))
                  ((= (nth 0 z) 0)(if (> (nth 1 z) 0)
                                      (/. pi 2)
                                      (*. 3 (/. pi 2))))
                  (true (atan (/. (nth 1 z) (nth 0 z)))))))

(set 'new-sqrt
    (lambda(z)
       (unless (list? z)
               (set 'z (list z 0)))
       (list (list (*. (old-sqrt (ro z)) (cos (/. (phi z) 2)))
                   (*. (old-sqrt (ro z)) (sin (/. (phi z) 2))))
             (list (*. (old-sqrt (ro z)) (cos (+. (/. (phi z) 2) pi)))
                   (*. (old-sqrt (ro z)) (sin (+. (/. (phi z) 2) pi)))))))

(set 'sqr (lambda (z)
           (list (-. (*. (z 0)(z 0)) (*. (z 1)(z 1)))
                 (*. 2 (z 0)(z 1)))))

;test

(dolist (z '((0 0) (0 4) (9 0) (3 4)))
  (println z "-> new-sqrt -> map sqr -> " (map sqr (new-sqrt z))))

; If you want not new-sqrt but sqrt (watch dynamic scope)

(constant 'sqrt new-sqrt)

(println)
(dolist (z '((0 0) (0 4) (9 0) (3 4)))
  (println z "-> sqrt -> map sqr -> " (map sqr (sqrt z))))

Calcoliamo sqrt(4):

(new-sqrt 4)
;-> ((2 0) (-2 2.449212707644755e-016))

Nota: usare una nuova REPL dopo queste funzioni :-)


------------------------------
Distributore d'acqua difettoso
------------------------------

Un distributore d'acqua non funziona correttamente.
Quando premiamo il pulsante per avere un litro d'acqua, la macchina versa una quantità d'acqua casuale da 0 a 1 litro.
Qual è il numero atteso/previsto di volte che occorre premere il pulsante per avere un litro d'acqua?
Per esempio:
la macchina versa il 10% di un litro, poi il 30% (arriviamo al 40%), poi l'80%: la bottiglia è piena al 100% e il 20% di acqua in più lo gettiamo (o lo beviamo noi). In questo caso abbiamo premuto 3 volte il pulsante per riempire la bottiglia.

(define (flush capacity)
  (let ((conta 1) (val (rand (+ capacity 1))))
    (while (< val capacity)
      (++ val (rand (+ capacity 1)))
      (++ conta)
    )
    conta))

(flush 100)
;-> 4

(define (atteso capacita iter)
  (let (f 0)
    (for (i 1 iter)
      (++ f (flush capacita))
    )
    (div f iter)))

(atteso 100 1e6)
;-> 2.704101
(atteso 500 1e6)
;-> 2.715304
(atteso 1000 1e6)
;-> 2.71802
(atteso 100 1e7)
;-> 2.7046374

Il risultato matematico vale: e = 2.718281828459045


------------------
Dado con 100 facce
------------------

Un gioco ha le seguenti regole:
1) Viene lanciato un dado con 100 facce (da 1 a 100)
2) Adesso ci sono due scelte:
   a) incassare il valore uscito in euro
   b) pagare 1 euro per tirare di nuovo il dado
Ci sono le stesse due scelte per ogni lancio e non c'è limite al numero di lanci che si possono effettuare.

Qual è il valore atteso del gioco?

Per scrivere una simulazione per prima cosa occorre stabilire una strategia da seguire nello svolgimento del gioco.
Quando lanciamo il dado otteniamo un numero compreso tra 1 e 100.
Se otteniamo un numero alto (es. 90), allora incassiamo. Se otteniamo un numero basso (es. 10), allora paghiamo 1 euro per lanciare di nuovo il dado.
Sembra ragionevole scegliere il valore 50 (che è il valore medio dei lanci) come soglia per la nostra decisione.
Quindi la strategia è la seguente:
- se il valore del dado è maggiore o uguale a 50, allora incassiamo
- se il valore del dado è minore a 50, allora paghiamo 1 euro per continuare.

Scriviamo la funzione che esegue un gioco con questa strategia:

(define (play limite)
  (local (val total)
    (setq total 0)
    (while (< (setq val (+ (rand 100) 1)) limite)
      (-- total)
    )
    (++ total val)))

(play 50)
;-> 79
(play 50)
;-> 74
(play 50)
;-> 92
(play 50)
;-> 82

Scriviamo la funzione che calcola il valore atteso di questa strategia:

(define (media limite iter)
  (local (somma)
    (setq somma 0)
    (for (i 1 iter)
      (setq somma (+ somma (play limite)))
    )
    (div somma iter)))

Calcoliamo il valore atteso:

(media 50 1e6)
;-> 74.038256

A questo punto sappiamo che il valore atteso del gioco vale circa 74 euro quando la soglia vale 50.
Ma quanto vale il valore atteso ottimale? Cioè, per quale valore della soglia il valore atteso è massimo?

Dal punto di vista matematico si può dimostrare che la funzione del valore atteso VA(s) in funzione della strategia s è la seguente:

  VA(s) = 51 + 0.5s - 100/(101 - s)

Per trovare il valore massimo di questo funzione possiamo scrivere:

(define (f n) (add 51 (mul 0.5 n) (sub (div 100 (sub 101 n)))))

(apply max (map f (sequence 1 100)))
;-> 87.35714285714286

Per calcolare anche il valore di s per cui abbiamo il valore atteso massimo:

(define (find-max func a b)
  (let ((vmax -999999999) (xmax 0))
    (for (i a b)
      (setq v (func i))
      (if (> v vmax) (set 'vmax v 'xmax i))
    )
    (println "valore massimo = " vmax)
    (println "per n = " xmax)))

(find-max f 1 100)
;-> valore massimo = 87.35714285714286
;-> per n = 87

Per vedere tutti i valori della funzione:

(for (i 1 100) (println i { } (media i 1e6)))
;-> 1 50.9076
;-> 2 51.1131
;-> 3 51.5065
;-> 4 52.1447
;-> ...
;-> 49 73.5226
;-> 50 73.9532
;-> 51 74.7581
;-> ...
;-> 86 87.3257
;-> 87 87.1818
;-> 88 87.2634
;-> 89 87.1832
;-> 90 86.7658
;-> 91 86.3957
;-> ...
;-> 97 74.6874
;-> 98 66.6193
;-> 99 50.4199
;-> 100 0.8999

Adesso scriviamo la funzione di simulazione finale e verifichiamo se corrisponde al risultato matematico:

(define (max-media a b iter)
  (let ((vmax -999999999) (smax 0))
    (for (i a b)
      (setq s (media i iter))
      (if (> s vmax) (set 'vmax s 'smax i))
    )
    (println "valore atteso massimo = " vmax)
    (println "per s = " smax)))

Facciamo alcune prove:

(max-media 1 100 1e4)
;-> valore atteso massimo = 87.3925
;-> per s = 86
;-> 86
(max-media 1 100 1e5)
;-> valore atteso massimo = 87.38336
;-> per s = 87
;-> 87
(max-media 1 100 1e6)
;-> valore atteso massimo = 87.356909
;-> per s = 87
;-> 87

I valori della simulazione sono congruenti con i risultati matematici.


----------------
La funzione bind
----------------

Vediamo la definizione dal manuale:

*****************
>>>funzione BIND
*****************
sintassi: (bind list-variable-associations [bool-eval])

"list-variable-associations" contiene una lista di associazione di simboli e relativi valori. "bind" imposta tutti i simboli sui valori associati.
I valori associati vengono valutati se il flag "bool-eval" vale true:

(set 'lst '((a (+ 3 4)) (b "hello")))

(bind lst)
;-> "hello"
a
;-> (+ 3 4)
b
;-> "hello"

(bind lst true) → "hello"
;-> a 7

Il valore di ritorno di "bind" è il valore dell'ultima associazione.

"bind" viene spesso utilizzato per "associare" le liste di associazioni restituite da "unify".

(bind (unify '(p X Y a) '(p Y X X)))
;-> a

X
;-> a
Y
;-> a

Questo può essere utilizzato per la destrutturazione:

(set 'structure '((one "two") 3 (four (x y z))))
(set 'pattern '((A B) C (D E)))
(bind (unify pattern structure))

A
;-> one
B
;-> "two"
C
;-> 3
D
;-> four
E
;-> (x y z)

"unify" restituisce una lista di associazioni e "bind" lega le associazioni.

Vediamo un altro esempio:

(setq lst1 '(a b c d e))
(setq lst2 '(10 20 k 40 (+ 10 40)))
(bind (map list lst1 lst2))

Le liste non sono cambiate:

lst1
;-> (a b c d e)
lst2
;-> (10 20 k 40 (+ 10 40))

Ma i simboli/variabili della lista lst1 sono stati associati ai simboli della lista lst2:

(dolist (el lst1) (print (eval el) { }))
;-> 10 20 30 40 (+ 10 40)

Con "bool-eval" uguale a true, i simboli della lista lst2 vengono valutati prima di essere associati ai simboli della lista lst1:

(bind lst1 lst2 true)

(dolist (el lst1) (print (eval el) { }))
;-> 10 20 k 40 (+ 10 40) " "


-------------------
Lattine ottimizzate
-------------------

Dobbiamo progettare delle lattine cilindriche per contenere una bevanda.
Il nostro compito è quello di utilizzare la minor quantità di materiale (es. alluminio) nella costruzione.

Per un dato volume dobbiamo cercare di minimizzare la superficie (area) della lattina.

Prima risolviamo il problema matematicamente.

Calcoliamo il volume del cilindro:

  Volume = V = Ab*h
  dove Ab = Area di base = π*r²
  Volume = V = π*r²*h

Calcoliamo l'area del cilindro:

  Area = A = 2*Ab + At
  dove At = Area del tubo = 2*π*r*h
  Area = A = 2*π*r² + 2*π*r*h

Supponiamo, per un dato volume, di ricavare l'altezza:

  h = V/π*r²

Sostituiamo questo valore nella formula dell'area del cilindro:

  A = 2*π*r² + 2*π*r*(V/π*r²) = 2*π*r² + 2*(V/r)

Per minimizzare il valore dell'area dobbiamo derivare la sua equazione rispetto alla variabile r ed uguagliarla a zero:

  dA
  -- = A' = 4*π*r - 2*(V/r³)
  dr

Eguagliamo a zero la derivata per calcolare il minimo:

  4*π*r - 2*(V/r³) = 0

La precedente espressione vale 0 per V = 2*π*r³.

Poichè per ogni cilindro il volume vale V = π*r²*h, per avere una superficie minima deve risultare:

  V = π*r²*h = 2*π*r³

Questo è vero quando h = 2*r.

Quindi un cilindro con un dato volume ha una superficie minima se h = 2*r.

Adesso possiamo scrivere una funzione di simulazione.
La funzione prende un valore di volume e calcola l'area del cilindro variando il raggio r con un ciclo.
All'interno del ciclo memorizziamo il valore minimo dell'area e il valore del raggio minimo.
Alla fine del ciclo calcoliamo il valore dell'altezza con il volume e il raggio minimo.
Restituisce il rapporto tra l'altezza e il raggio.

(setq PI 3.1415926535897931)
(define (volume h r) (mul PI r r h))
(define (area h r) (add (mul 2 PI r r) (mul 2 PI r h)))
(define (area2 r V) (add (mul 2 PI r r) (mul 2 (div V r))))
(define (altezza vol r) (div vol (mul PI r r)))

(define (area-minima vol)
  (local (h r min-area a)
    (setq min-area 999999999)
    (setq r 0)
    (for (x 1 vol 0.0001)
      ; calcoliamo l'area con il volume prefissato
      (setq a (area2 x vol))
      ;(println "r = " x)
      ;(println "h = " (altezza vol x))
      ;(println "area = " (area (altezza vol x) x))
      ;(println "area2 = " (area2 x vol))
      ;(print "volume = " (volume (altezza vol x) x))
      ;(read-line)
      (if (< a min-area)
          (set 'min-area a 'r x)
      )
    )
    ; calcoliamo hanno per volume ed r predefiniti
    (setq h (div vol (mul PI r r)))
    (println "Volume: " vol)
    (println "Area minima: " min-area)
    (println "h = " h ", r = " r)
    ; rapporto altezza/raggio
    (println "h/r  = " (div h r))))

Facciamo alcune prove:

(area-minima 10)
;-> Volume: 10
;-> Area minima: 25.69495598787001
;-> h = 2.335265959741505, r = 1.1675
;-> h/r  = 2.00022780277645
;-> 2.00022780277645
(area-minima 50)
;-> Volume: 50
;-> Area minima: 75.13250699687636
;-> h = 3.992836276202997, r = 1.9965
;-> h/r  = 1.999917994592035
;-> 1.999917994592035
(area-minima 100)
;-> Volume: 100
;-> Area minima: 119.2654206216453
;-> h = 5.030787974822657, r = 2.5154
;-> h/r  = 1.999995219377696
;-> 1.999995219377696
(area-minima 500)
;-> Volume: 500
;-> Area minima: 348.7342054697743
;-> h = 8.602420416092638, r = 4.3013
;-> h/r  = 1.999958248923032
;-> 1.999958248923032
(area-minima 1000)
;-> Volume: 1000
;-> Area minima: 553.5810446223193
;-> h = 10.83836421006721, r = 5.4193
;-> h/r  = 1.999956490703081
;-> 1.999956490703081

La simulazione è congruente con il risultato matematico (minArea per h = 2*r).


------------------
Il gatto e il topo
------------------

Un gatto e un topo vengono posizionati su una griglia di NxN caselle.
Il topo e il gatto possono muoversi solo orizzontalmente o verticalmente, non in diagonale.
A turno, il topo e il gatto si muovono di una casella.
Lo scopo del gatto è quello di catturare il topo occupando la sua casella.
Lo scopo del topo è sfuggire al gatto.
Il topo muove per primo.
Il numero N è pari.
La posizione del gatto è 0,0 (prima riga, prima colonna).
La posizione del topo è N-1,0 (ultima riga, prima colonna).

a) Il gatto riesce a prendere il topo?
b) Cosa accade se la posizione iniziale è casuale?

Soluzione caso a)
Il gatto non priesce mai a prendere il topo.
Consideriamo la griglia come una scacchiera con i quadrati alternati bianchi e neri.
Supponendo che la casella dove si trova il gatto (0,0) sia di colore nero, allora la casella dove si trova il topo (N-1,0) è di colore bianco.
Ad ogni mossa, il topo e il gatto si spostano in una casella adiacente, che avrà sempre il colore opposto.
Alla prima mossa, il topo si sposta su una casella bianca.
Alla prima mossa, il gatto si sposta su una casella nera.
Alla seconda mossa, il topo si sposta su una casella nera.
Alla seconda mossa, il gatto si sposta su una casella bianca.
Questo vale per tutte le mosse, quindi alla fine di ogni mossa il gatto e il topo si trovano sempre su caselle di colore diverse.
In questo modo il gatto è impossibilitato a prendere il topo.

Soluzione b)
Dalla soluzione precedente si nota che se all'inizio il topo e il gatto si trovano su caselle di colore diverso, allora il gatto non è in grado di prendere il topo.
Le caselle sono di colore diverso quando la distanza di manhattan delle due posizioni iniziali è dispari.

(define (dist-manh4 x1 y1 x2 y2)
"Calculates Manhattan distance (4 directions - rook) of two points P1=(x1 y1) e P2=(x2 y2)"
  (add (abs (sub x1 x2)) (abs (sub y1 y2))))

Per esempio,
N = 6
gatto = (0 0)
topo = (5 0)

(dist-manh4 0 0 5 0)
;-> 5

Quindi nel caso in cui il gatto e il topo si trovano inizialmente su caselle dello stesso colore, allora il gatto può provare a catturare il topo. Usando una scacchiera 4x4 è facile rendersi conto che, in questo caso, il gatto sarà sempre in grado di catturare il topo con una condotta ottimale.
In definitiva abbiamo le seguenti due situazioni:
1) il gatto e il topo si trovano inizialmente su caselle di colore diverso:
   il gatto non riuscirà mai a catturare il topo.
2) il gatto e il topo si trovano inizialmente su caselle di colore uguale:
   il gatto riuscirà sempre (con una condotta ottimale) a catturare il topo.

Vediamo alcune funzioni per simulare un gatto e un topo casuali.

Funzione per stampare la griglia:

(define (print-grid lst)
  (local (row col)
    (setq row (length lst))
    (setq col (length (first lst)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (cond ((= (lst i j) "0") (print ".."))
               ; gatto
               ((= (lst i j) "G") (print "GG"))
               ; topo
               ((= (lst i j) "T") (print "TT"))
        )
      )
      (println))))

Funzione che simula il movimento casuale del topo e del gatto su una griglia e verifica se il gatto prende (casualmente) il topo:

(define (acchiappa n gx gy tx ty iter stampa)
  (local (table preso mosse)
    (setq table (array n n '("0")))
    ; posizione gatto
    (setf (table gx gy) "G")
    ; posizione topo
    (setf (table tx ty) "T")
    (setq preso nil)
    (setq mosse 0)
    (if stampa
      (begin
        (println "Posizione iniziale:")
        (print-grid table))
    )
    (until (or preso (>= mosse iter))
      (if stampa (read-line))
      ; il topo muove per primo
      (move-topo)
      (move-gatto)
      (++ mosse)
      (if stampa
        (begin
          (print-grid table)
          (println "mosse: " mosse))
      )
      ; il gatto ha preso il topo?
      (if (and (= gx tx) (= gy ty)) (setq preso true))
    )
    (println "gatto: " gx { } gy ", topo: "  tx { } ty)
    preso))

Funzione per muovere il topo:

(define (move-topo) ; tx ty table
  (local (x y valida xmove ymove)
    (setq xmove '(1 0 -1))
    (setq ymove '(1 0 -1))
    ; prova a muoversi
    (setq x (+ tx (xmove (rand 3))))
    (setq y (+ ty (ymove (rand 3))))
    (setq valida nil)
    ; controllo validità nuova posizione
    (until valida ; non la stessa posizione
      (cond ((and (or (!= x tx) (!= y ty))
                  ; dentro la griglia
                  (>= x 0) (< x n) (>= y 0) (< y n)
                  ; solo mosse in verticale o orizzontale
                  (= (abs (- (+ tx ty) (+ x y))) 1)
                  ; non è il topo che deve prendere il gatto
                  (or (!= x gx) (!= y gy)))
              (setq valida true)
              ; aggiorna la vecchia posizione
              (setf (table tx ty) "0")
              (setq tx x)
              (setq ty y)
              ; aggiorna la nuova posizione
              (setf (table tx ty) "T"))
            (true
              ; riprova a muoversi
              (setq x (+ tx (xmove (rand 3))))
              (setq y (+ ty (ymove (rand 3)))))
      )
    )
    true))

Funzione per muovere il gatto:

(define (move-gatto) ; gx gy table
  (local (x y valida xmove ymove)
    (setq xmove '(1 0 -1))
    (setq ymove '(1 0 -1))
    ; prova a muoversi
    (setq x (+ gx (xmove (rand 3))))
    (setq y (+ gy (ymove (rand 3))))
    (setq valida nil)
    ; controllo validità nuova posizione
    (until valida ; non la stessa posizione
      (cond ((and (or (!= x gx) (!= y gy))
                  ; solo mosse in verticale o in orizzontale
                  (= (abs (- (+ gx gy) (+ x y))) 1)
                  ; dentro la griglia
                  (>= x 0) (< x n) (>= y 0) (< y n))
              (setq valida true)
              ; aggiorna la vecchia posizione
              (setf (table gx gy) "0")
              (setq gx x)
              (setq gy y)
              ; aggiorna la nuova posizione
              (setf (table gx gy) "G"))
            (true
              ; riprova a muoversi
              (setq x (+ gx (xmove (rand 3))))
              (setq y (+ gy (ymove (rand 3)))))
      )
    )
    true))

Proviamo con una griglia 6x6, gatto in (0,0) e topo (5,0) dove le caselle di partenza hanno colore diverso:

(acchiappa 6 0 0 5 0 100 true)
;-> Posizione iniziale:
;-> GG..........
;-> ............
;-> ............
;-> ............
;-> ............
;-> TT..........
;->
;-> ............
;-> GG..........
;-> ............
;-> ............
;-> ............
;-> ..TT........
;-> mosse: 1
;-> ...
;-> ...
;-> ...
;-> TT..........
;-> ........GG..
;-> ............
;-> ............
;-> ............
;-> ............
;-> mosse: 99
;->
;-> ............
;-> TT....GG....
;-> ............
;-> ............
;-> ............
;-> ............
;-> mosse: 100
;-> gatto: 1 3, topo: 1 0
;-> nil

In questo caso il gatto non riuscirà mai a catturare il topo:

(acchiappa 6 0 0 5 0 1e4)
;-> gatto: 4 2, topo: 5 2
;-> nil

Neanche con un milione di iterazioni:

(acchiappa 6 0 0 5 0 1e6)
;-> gatto: 1 1, topo: 4 1
;-> nil

Proviamo con una griglia 6x6, gatto in (0,0) e topo (4,0) dove le caselle di partenza hanno colore uguale:

Con 50 iterazioni il topo qualche volta si salva:

(acchiappa 6 0 0 4 0 50)
;-> gatto: 2 0, topo: 2 0
;-> true
(acchiappa 6 0 0 4 0 50)
;-> gatto: 4 1, topo: 4 1
;-> true
(acchiappa 6 0 0 4 0 50)
;-> gatto: 1 1, topo: 2 4
;-> nil
(acchiappa 6 0 0 4 0 50)
;-> gatto: 2 4, topo: 1 1
;-> nil
(acchiappa 6 0 0 4 0 50)
;-> gatto: 5 4, topo: 5 4
;-> true

Con 100 iterazioni il topo viene preso quasi sempre:

(acchiappa 6 0 0 4 0 100)
;-> gatto: 2 2, topo: 2 2
;-> true
(acchiappa 6 0 0 4 0 100)
;-> gatto: 3 2, topo: 3 2
;-> true
(acchiappa 6 0 0 4 0 100)
;-> gatto: 2 3, topo: 2 3
;-> true
(acchiappa 6 0 0 4 0 100)
;-> gatto: 3 0, topo: 3 0
;-> true

Nota: la simulazione casuale dei movimenti del gatto e del topo utilizzata nella nostra funzione non è quella ottimale.
La strategia ottimale del topo e del gatto è quella di muoversi nella casella che massimizza/minimizza la distanza dall'avversario.
Comunque questa strategia porta il gatto a catturare sempre il topo.


-----------------
Palle da biliardo
-----------------

Due palle A e B sono posizionate in un biliardo ad una certa distanza tra loro.
La palla A deve centrare la palla B con una sponda (cioè A deve toccare una sponda prima di colpire B).
Qual è il punto C della sponda che minimizza la distanza A->C->B?

Esempi di percorsi:

|                       |
|      A                |      A
|       \      B        |      |      B
|        \    /         |      |    .
|         \  /          |      |  .
|          \/           |      |.
|===================    |==================
           C                   C

Supponiamo che la sponda sia l'asse x (cioè il punto C si trova sull'asse x).
Il punto A vale (4 5).
Il punto B vale (9 4).

Soluzione
Riflettiamo il punto B rispetto all'asse x e otteniamo B1.
Quindi la distanza A->C->B è uguale alla distanza A->C->B1.
Adesso la distanza minima tra due punti A e B1 è una retta, quindi il punto C è l'intersezione tra il segmento AB1 e l'asse x.

 |
 |      A
 |       \      B
 |        \    /|
 |         \  / |
 |          \/  |
 |===================
             C  |
                |
                |
                B1

A = (4 5)
B1 = (9 -4)
Asse x => proiezione di AB sull'asse x: (4 0) (9 0)

Funzione che calcola il punto di intersezione tra due segmenti:

(define (intersect-line p0x p0y p1x p1y p2x p2y p3x p3y)
  (local (ix iy s1x s1y s2x s2y s t)
    (setq s1x (sub p1x p0x))
    (setq s1y (sub p1y p0y))
    (setq s2x (sub p3x p2x))
    (setq s2y (sub p3y p2y))
    ;(println "numer = " (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y))))
    ;(println "denom = " (add (mul (sub 0 s2x) s1y) (mul s1x s2y)))
    (setq s (div (add (mul (sub 0 s1y) (sub p0x p2x)) (mul s1x (sub p0y p2y)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    (setq t (div (sub (mul s2x (sub p0y p2y)) (mul s2y (sub p0x p2x)))
                (add (mul (sub 0 s2x) s1y) (mul s1x s2y))))
    ;(println "s = " s)
    ;(println "t = " t)
    (cond ((and (>= s 0) (<= s 1) (>= t 0) (<= t 1)) ;intersezione
           (setq ix (add p0x (mul t s1x)))
           (setq iy (add p0y (mul t s1y)))
          )
          (true (setq ix nil) (setq iy nil))
    )
    (list ix iy)
  )
)

(intersect-line 4 5 9 -4 4 0 9 0)
;-> (6.777777777777778 0)

Il punto C vale (6.777777777777778 0).


-------------------------------------
Espressioni condizionali in una lista
-------------------------------------

Supponiamo di avere il seguente pezzo di codice:

(setq a 10)
(setq b 20)

(if (and (> a b) (> (+ a b) 10)) true nil)
;-> nil

(if (or (> a b) (> (+ a b) 10)) true nil)
;-> true

Cioè dobbiamo valutare una serie di condizioni tutte con l'operatore AND o tutte con l'operatore OR.
In questo caso possiamo inserire le condizioni in una lista:

(setq cond-expr '((> a b) (> (+ a b) 10)))

E poi usare la seguente funzione:

(define (check a b cond-expr op)
  ;(println (map eval cond-expr))
  (apply op (map eval cond-expr)))

(check a b cond-expr 'and)
;-> nil

(check 10 20 cond-expr 'or)
;-> true

Questo è comodo quando dobbiamo frequentemente modificare e/o aggiungere espressioni condizionali alla logica del programma.


-------------------
Poligoni e formiche
-------------------

In un poligono regolare di N lati uguali (N-agono) si trovano N formiche, una formica per ogni vertice.
Se tutte le formiche iniziano a muoversi contemporaneamente alla stessa velocità, qual è la probabilità che due formiche qualunque non si scontrino?
Per esempio in un quadrato:

      f1         f2
       +---------+
       |         |
       |         |
       |         |
       +---------+
      f4         f3

Ogni formica può scegliere tra due direzioni (orario o antiorario)
Le formiche non si scontrano se tutte scelgono la stessa direzione.
Quindi abbiamo 2^n possibilità.
La probabilità che le formiche non si scontrino vale:

        casi favorevoli       2
  P = ------------------- = ----- = 1/2^(n-1)
        casi possibili       2^n

(define (formiche n) (div (pow 2 (- n 1))))

(formiche 3)
;-> 0.25
(formiche 5)
;-> 0.0625
(formiche 12)
;-> 0.00048828125

Per simulare questo processo possiamo scrivere:

(define (ants n iter)
  (let ((conta 0) (rnd '()))
    (for (i 1 iter)
      (setq rnd (rand 2 n))
      (if (or (= (apply + rnd) n)  ; tutti 1?
              (= (apply + rnd) 0)) ; tutti 0?
          (++ conta)
      )
    )
    (div conta iter)))

> (ants 3 1e7)
;-> 0.250017
;-> (ants 5 1e7)
;-> 0.0625722
(ants 12 1e7)
;-> 0.0004801

I risultati della simulazione sono congruenti con i risultati matematici.


--------------------
Cellulare e batterie
--------------------

Il cellulare di Eva ha una batteria che dura 4 ore.
Una seconda batteria di riserva ha una carica di 4 ore.
Il tempo di ricarica della batteria è 8 ore.
Le batterie si caricano in 8 ore (cioè in 4 ore si ricarica al 50% e dura 2 ore).
Eva adotta il seguente metodo:
1) quando la batteria sul telefono è scarica, prende l'altra batteria e la sostituisce.
   Contemporaneamente mette la batteria appena tolta sotto carica.
2) Ripetere il passo 1) fino all'esaurimento di entrambe le batterie.
Supponiamo che le sostituzioni della batteria siano istantanee e che sia la carica che la scarica avvengano a velocità lineare.
Quante ore ininterrotte può essere utilizzato il cellulare con questo metodo?

Risolviamo il problema matematicamente con le serie infinite.
La prima batteria si scarica in D ore. Chiamiamo questo periodo di tempo t1.
La batteria di riserva si scarica quindi in D ore. Il periodo di tempo successivo è t2.
Per il terzo periodo,t3, la prima batteria ha avuto D ore per caricarsi, ma è carica solo una frazione f della carica totale.
In questo caso f = 0.5 (ricarica al 50%).
Nel quarto periodo, t4, la batteria di riserva ha avuto f*D ore per caricarsi (il tempo impiegato dalla prima batteria a scaricarsi nell'ultimo periodo), ma si carica solo una frazione f del tempo. Quindi la batteria di riserva si scarica in f^2*D ore.
Ora possiamo vedere lo schema che il periodo successivo dura f volte quanto il precedente.
Cioè, per ogni periodo di tempo tk, con k > 1, la batteria si scarica in f^(k-2)*D ore.
Il tempo totale prima che entrambe le batterie si scarichino completamente è la somma di ogni periodo di tempo.

  T = t1 + t2 + t3 + …
  T = D + D + f*D + f^2*D + ...
  T = D + D(1 + f + f^2 + ...)

A questo punto siamo in grado di calcolare la soluzione in maniera brutale:

(setq T 0)
(setq D 4)
(setq T (mul 2 D))

(for (i 3 10000)
  (setq T (add T (mul (pow 0.5 (- i 2)) D)))
)
;-> 12

Il cellulare può essere usato per 12 ore.

Continuando matematicamente da dove eravamo arrivati:

  T = D + D(1 + f + f^2 + ...)

La somma della serie infinita tra parentesi vale 1/(1 - f).
Pertanto, il tempo totale è il seguente:

  T = D + D/(1 - f)

  T = D*(2 - f)/(1 - f)

Adesso possiamo scrivere una funzione più generica:

(define (durata D f)
  (div (mul D (sub 2 f)) (sub 1 f)))

(durata 4 0.5)
;-> 12

Il cellulare può essere usato per 12 ore.


---------------------
Aree minime e massime
---------------------

Abbiamo una corda lunga 4 metri.
Tagliamo la corda in due pezzi lc e lq.
Con il primo pezzo costruiamo un cerchio.
Con il secondo pezzo costruiamo un quadrato.
L'area totale è la somma dell'area del cerchio e dell'area del quadrato.

a) Determinare i valori delle lunghezza lc e lq per rendere massima l'area totale.
b) Determinare i valori delle lunghezza lc e lq per rendere minima l'area totale.
c) Se la corda viene tagliata a caso. Qual è il valore medio dell'area totale?

a) Soluzione
------------
  L = lc + lq = 4
  Area Cerchio = Ac = π*r²
  Perimetro Cerchio = Pc = 2*π*r --> r = Pc/(2*π)
  Ac = π*(Pc/(2*π))² = Pc²/(4*π)

  Area Quadrato = Aq = l²
  Perimetro Quadrato = Pq = 4*l  --> l = Pq/4
  Aq = Pq²/16

Nota: Pc = lc e Pq = lq

(setq PI 3.141592653589793)

Funzione che calcola area del cerchio dal perimetro del cerchio:

(define (areaC perimC)
  (div (mul perimC perimC) (mul 4 PI)))

(areaC 2)
;-> 0.3183098861837907

Funzione che calcola area del quadrato dal perimetro del quadrato:

(define (areaQ perimQ)
  (div (mul perimQ perimQ) 16))

(areaQ 2)
;-> 0.25

Funzione che effettua un taglio della corda e calcola la somma delle aree risultanti.
I parametri sono la lunghezza della corda (L) e la lunghezza del pezzo del cerchio (lc) (cioè il perimetro del cerchio).
La lughezza dell'altro pezzo di corda (lq) è il perimetro del quadrato e vale lq = L - lc.

(define (taglia L lc)
  (let (lq (sub L lc))
    (add (areaC lc) (areaQ lq))))

Facciamo alcune prove:

(taglia 4 0)
;-> 1
(taglia 4 1)
;-> 0.6420774715459476
(taglia 4 1.5)
;-> 0.5696743109783823
(taglia 4 3)
;-> 0.778697243913529
(taglia 4 3.5)
;-> 0.9904490264378589
(taglia 4 3.8)
;-> 1.151598689123484

I valori non sono monotoni (cioè tutti crescenti o tutti decrescenti).

Calcoliamo il valore massimo dell'area utilizzando la funzione "taglia" con lc che varia da 0 a L con un dato passo (step):

(define (max-area L step)
  (let ((lc 0) (lq 0) (area-max 0))
    (for (i 0 L step)
      (setq a (taglia L i))
      ;(print i { } a ) (read-line)
      (if (> a area-max)
          (set 'area-max a 'lc i 'lq (sub L lc))
      )
    )
    (list area-max lc lq)))

(max-area 4 0.001)
;-> (1.273239544735163 4 0)
(max-area 4 0.000001)
;-> (1.273239544735163 4 0)

Area massima = 1.273239544735163
lc = 4
lq = 0

Il risultato ci dice che l'area è massima se usiamo tutta la corda per il cerchio.
Questo è spiegato dal fatto che a parità di perimetro e di lati i poligoni regolari sono quelli che massimizzano l'area, mentre il cerchio è quella che la massimizza in assoluto.

b) Soluzione
------------
Calcoliamo il valore minimo dell'area utilizzando la funzione "taglia" con lc che varia da 0 a L con un dato passo (step):

(define (min-area L step)
  (let ((lc 0) (lq 0) (area-min 999999999))
    (for (i 0 L step)
      (setq a (taglia L i))
      ;(print i { } a ) (read-line)
      (if (< a area-min)
          (set 'area-min a 'lc i 'lq (sub L lc))
      )
    )
    (list area-min lc lq)))

(min-area 4 0.001)
;-> (0.5600991758607276 1.76 2.24)
(min-area 4 0.000001)
;-> (0.5600991535115785 1.759603 2.240397)

Area minima = 0.5600991535115785
lc = 1.759603
lq = 2.240397

Vediamo di verificare quest'ultimo risultato matematicamente.

  L = lc + lq = 4
  Area Cerchio = Ac = π*r²
  Perimetro Cerchio = Pc = 2*π*r --> r = Pc/(2*π)
  Ac = π*(Pc/(2*π))² = Pc²/(4*π)

  Area Quadrato = Aq = l²
  Perimetro Quadrato = Pq = 4*l  --> l = Pq/4
  Aq = Pq²/16

Nota: Pc = lc e Pq = lq

Calcoliamo Ac + Aq:

             Pc²     Pq²     (L - Pq)²      Pq²
  Ac + Aq = ----- + ----- = ------------ + ----- =
              4*π    16         4*π         16

     L² + Pq² -2*L*Pq     Pq²
  = ------------------ + ----- =
           4*π            16

     4*L² + 4*Pq² - 8*L*Pq + π*Pq²
  = -------------------------------
                16*π

Calcoliamo la derivata di (Ac + Aq) rispetto alla variabile Pq:

  d(Ac+Aq)
  -------- = 8*Pq - 8*L + 2*π*Pq = Pq*(8 + 2*π) - 8*L
    dPq

Per calcolare il valore di minimo dobbiamo eguagliare a 0 la derivata:

  d(Ac+Aq)
  -------- = Pq*(8 + 2*π) - 8*L = 0
    dPq

                                 8*L
La funzione è minima per Pq = ---------
                               8 + 2*π

Nel nostro caso:

          8*4
  Pq = --------- = 2.24039661404623
        8 + 2*π

(div (mul 8 4) (add 8 (mul 2 PI)))
;-> 2.24039661404623

Abbiamo ottenuto lo stesso risultato della simulazione.

c) soluzione
------------
Usiamo una funzione di simulazione.

(define (area-media L iter)
  (local (val tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq tot (add tot (taglia L (random 0 L))))
    )
    (div tot iter)))

(area-media 4 1e4)
;-> 0.7568260739237473
(area-media 4 1e5)
;-> 0.7574672497313104
(area-media 4 1e6)
;-> 0.7578529188281959
(area-media 4 1e7)
;-> 0.75776504437717


----------------
Da 1 a 1 milione
----------------

Due giocatori A e B iniziano con il numero 1.
A moltiplica 1 per qualsiasi numero intero compreso tra 2 e 9.
B quindi moltiplica il risultato per qualsiasi numero intero da 2 a 9.
Il gioco continua con ogni giocatore che muove a turno.
Il vincitore è il primo che raggiunge o supera 1 milione.
Chi vince questo gioco? Qual è la strategia?

Possiamo ragionare all'indietro per individuare i numeri vincenti e i numeri perdenti.
Partendo da 1 milione quale numeri sono vincenti per il giocatore corrente?
Dividiamo 1 milione per 9:
(div 1e6 9)
;-> 111111.1111111111
Quindi i numeri da 111112 fino a 999999 sono vincenti, nel senso che il giocatore che muove può vincere moltiplicando per 9 uno dei numeri tra 111112 e 999999.
Per trovare i numri perdenti dividiamo il limite inferiore 111111 per 2:
(div 111112 2)
;-> 55556
Quindi i numeri da 55556 a 111111 sono perdenti.
Seguendo questo ragionamento, per calcolare i numeri vincenti dividiamo il limite inferiore per 9 e per calcolare i numeri perdenti dividiamo il limite inferiore per 2. (Dobbiamo arrotondare per eccesso dopo ogni divisione poiché il gioco tratta solo numeri interi).
La seguente funzione calcola gli intervalli vincenti e perdenti:

(define (find-numbers)
  (local (out)
    (setq out '())
    (setq num 1e6)
    (setq w-up (- num 1))
    (until (<= num 1)
      (setq w-down (+ (int (div num 9)) 1))
      (push (list w-up w-down) out -1)
      ;(println "w: " (list w-up w-down))
      (setq num w-down)
      (setq l-up (- w-down 1))
      (setq l-down (add (int (div l-up 2)) 1))
      (push (list l-up l-down) out -1)
      ;(print "l: " (list l-up l-down)) (read-line)
      (setq num (- l-down 1))
      (setq w-up (- l-down 1))
    )
    out))

(find-numbers)
;-> ((999999 111112)
;->  (111111 55556)
;->  (55555 6173)
;->  (6172 3087)
;->  (3086 343)
;->  (342 172)
;->  (171 20)
;->  (19 10)
;->  (9 2)
;->  (1 1))

Quindi gli intervalli sono i seguenti:

 da 111112 a 999999: vincenti
 da 55556 a 111111: perdenti
 da 6173 a 55555: vincenti
 da 3087 a 6172: perdenti
 da 343 a 3086: vincenti
 da 172 a 342: perdenti
 da 20 a 171: vincenti
 da 10 a 19: perdenti
 da 2 a 9: vincenti
 da 1: perdente

Quindi, A inizia il gioco con 1 che è un numero perdente.
Quando presenta uno dei numeri da 2 a 9 a B, può arrivare nell'intervallo perdente da 10 a 18.
Qualunque cosa faccia A, B può sempre lasciare A dentro gli intervalli perdenti e vincere la partita

In definitiva chi comincia il gioco perde sempre se il suo avversario segue la strategia ottimale per cui, ad ogni tiro, parte da un intervallo vincente e arriva ad un intervallo perdente (da dove deve muovere l'altro giocatore).


-----------------------
Il gioco della sequenza
-----------------------

Due giocatori A e B fanno il gioco seguente:
A scrive i numeri 1, 2, . . . , N su un pezzo di carta.
B inizia per primo e sceglie due numeri x e y dalla sequenza.
B cancella questi numeri dalla sequenza e include un nuovo numero uguale alla loro differenza positiva (cioè, mette |x – y| nella sequenza).
A fa la stessa identica cosa con i numeri rimanenti nella sequenza.
B e A continuano a giocare, a turno, finché non rimane un solo numero nella sequenza.
A vince se il numero finale è dispari e B vince se è pari.
C'è una strategia vincente per uno dei giocatori?

Come prima cosa simuliamo una partita con una sequenza semplice, per esempio (1 2 3).
Il giocatore B può scegliere due numeri qualsiasi, il che genera le seguenti tre mosse:
– Se sceglie (1 2) la lista risultante è (1 3).
– Se sceglie (1 3) la lista risultante è (2 2).
– Se sceglie (2 3) la lista risultante è (1 1).
Poi il giocatore A dovrà scegliere i due numeri rimasti con i seguenti risultati:
– Se la lista era (1 3) il numero risultante è 2 (numero pari, vince B).
– Se la lista era (2 2) il numero risultante è 0 (numero pari, vince B).
– Se la lista era (1 1) il numero risultante è 0 (numero pari, vince B).
Questo esempio mostra che il giocatore A perde sempre, indipendentemente da come gioca B.

Analizziamo meglio il nostro esempio.
La somma originale di tutti i numeri è (1+2+3) = 6, un numero pari.
Quando B muove, la somma risultante può essere:
a) 4, se sceglie (1 2)
b) 4, se sceglie (1 3)
c) 2, se sceglie (2 3).
In tutti i casi la somma dei numeri è pari.
Dopo la mossa del giocatore A la somma risultante vale:
a) 2
b) 0
c) 0
Anche ora in tutti i casi la somma dei numeri è pari.

Quindi partendo da una somma pari si ottiene un valore finale pari, perchè ad ogni mossa di A o B la parità della somma non cambia.
Questo vale anche per somme iniziali dispari?
Se questo è vero il numero finale, così come ogni somma intermedia, avrà la stessa parità (cioè la proprietà di essere dispari o pari) della somma della lista iniziale.
Questo significherebbe che A vince se la lista iniziale ha una somma dispari, e B vince se la lista iniziale ha una somma pari.

Scriviamo una funzione per verificare la nostra supposizione.

La somma di una sequenza 1..N vale: Sum[1..N] = N*(N + 1)/2

(define (somma n) (/ (* n (+ n 1)) 2))

Funzione che simula una gioco prendendo come parametro il numero finale della sequenza (N):

(define (game n)
  (local (seq a b)
    (setq seq (sequence 1 n))
    ; fino a che non rimane un solo numero nella sequenza
    (until (= (length seq) 1)
      ; mischia la sequenza
      (setq seq (randomize seq))
      ; estrae primo numero
      (setq a (pop seq))
      ; estrae secondo numero
      (setq b (pop seq))
      ; inserisce la differenza in valore assoluto nella sequenza
      (push (abs (- a b)) seq)
    )
    (seq 0)))

Facciamo un paio di prove:

(game 3)
;-> 0
(game 3)
;-> 0
(game 3)
;-> 2

Funzione che controlla la nostra ipotesi:

(define (ipotesi num)
  (local (sum)
    (for (i 3 num)
      (setq sum (somma i))
      ; l'ipotesi fallisce se:
      ; 1) la somma iniziale è pari è il numero finale è dispari, oppure
      ; 2) la somma iniziale è dispari è il numero finale è pari
      (if (or (and (odd? sum) (even? (game i)))
              (and (even? sum) (odd? (game i))))
          (println "errore: " i ", somma = " sum ", " (game i))))))

Proviamo:

(ipotesi 250)
;-> nil
(ipotesi 500)
;-> nil
(ipotesi 1000)
;-> nil

(time (ipotesi 1000))
;-> 4357.583

Siamo certi che l'ipotesi è vera fino a N=1000.

Dal punto di vista matematico supponiamo che la somma originale dei numeri sia S.
Al turno di B, rimuove due numeri x > y dalla lista, e scrive un altro numero (x – y).
Ciò significa che l'azione di B riduce la somma originale S di:

  x + y – (x – y) = x + y - x + y = 2*y

La cosa da notare è che 2*y è un numero pari, il che significa che la parità della somma rimane invariata da una mossa nel gioco.
In altre parole:

– Se la somma originaria S era pari, ad ogni turno viene ridotta di un numero pari.
Poiché pari meno pari è un numero pari, questo significa che ogni somma intermedia sarà un numero pari. Quindi anche il numero finale deve essere pari.

– Se la somma originaria S era dispari, ad ogni turno viene ridotta di un numero pari.
Poiché dispari meno un pari è un numero dispari, questo significa che ogni somma intermedia sarà un numero dispari. Quindi anche il numero finale deve essere dispari.

La strategia finale non dipende dalla bravura dei giocatori:
- se S è pari vince sempre B
- se S è dispari vince sempre A

Per finire, la funzione "game" ottimizzata:

(define (game n)
  (local (seq a b)
    ; crea una sequenza casuale
    (setq seq (randomize (sequence 1 n)))
    ; si fanno (n-1) turni per una lista lunga n
    (dotimes (x (- n 1))
      ; inserisce nella sequenza la differenza in valore assoluto
      ; tra il primo e il secondo numero della sequenza
      ; (non è importante dove viene inserita)
      (push (abs (- (pop seq) (pop seq))) seq)
    )
    (seq 0)))

(time (ipotesi 1000))
;-> 68.95099999999999
(time (ipotesi 10000))
;-> 8069.884

---------------------------------
Problema delle 8 regine (8 queen)
---------------------------------

Il problema delle otto regine consiste nel di posizionare otto regine degli scacchi su una scacchiera 8 × 8 in modo che due regine non si minaccino a vicenda.
In altre parole, una soluzione richiede che due regine non condividano la stessa riga, colonna o diagonale.

Questo problema è piuttosto costoso dal punto di vista computazionale, poiché ci sono 4426165368 possibili disposizioni di otto regine su una scacchiaera 8×8, ma solo 92 soluzioni.

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

(binom 64 8)
;-> 4426165368L

Il puzzle delle otto regine ha 92 soluzioni distinte.
Se le soluzioni che differiscono solo per le operazioni di simmetria di rotazione e riflessione della scacchiera sono contate come una, allora il puzzle ha 12 soluzioni.
Queste 12 soluzioni sono chiamate soluzioni fondamentali.

Per risolvere il problema, in genere vien utilizzato l'algoritmo "depth-first backtracking". Abbiamo visto questo algoritmo in "Problema delle N-Regine" nel capitolo "Problemi vari".
Adesso proviamo a risolverlo con altri metodi.

Primo metodo: generazione di posizioni casuali
----------------------------------------------
Generiamo un determinato numero di posizioni casuali e verifichiamo se soddisfano i vincoli.

Funzione che restituisce true se la regina può attaccare l'avversaria:
(non controlla se ci sono pezzi che si interpongono)

(define (attack row-queen col-queen row col)
        ; regina e avversaria sono nella stessa riga?
  (cond ((= row-queen row)
         true)
        ; regina e avversaria sono nella stessa colonna?
        ((= col-queen col)
         true)
        ; regina e avversaria sono nella stessa diagonale?
        ((= (abs (- row-queen row)) (abs (- col-queen col)))
         true)
        ; altrimenti le regine non si attaccano
        (true nil)))

Funzione che cerca in modo casuale le soluzioni al problema:

(define (queen8-1 iter)
  (local (righe colonne sol check pos)
    (setq righe (sequence 0 7))
    (setq colonne (sequence 0 7))
    (setq sol '())
    ; genera iter posizioni casuali
    (for (k 1 iter)
      (setq check nil)
      ; genera posizione completamente casuale
      (setq pos (map list (rand 8 8) (rand 8 8)))
      ; for debug
      ;(if (= k 10)
      ; ; posizione valida (soluzione)
      ; (setq pos '((0 3) (1 6) (2 2) (3 7) (4 1) (5 4) (6 0) (7 5)))
      ;)
      ; controllo posizione corrente
      (for (i 0 6 1 check)
        (for (j (+ i 1) 7 1 check)
          (if (attack (pos i 0) (pos i 1) (pos j 0) (pos j 1))
              (setq check true)
          )
        )
      )
      ; trovata una soluzione?
      (if (not check) (push (sort pos) sol))
    )
    ; vogliamo solo soluzioni diverse
    (unique sol)))

Facciamo alcune prove:

(queen8-1 1000)
;-> ()
(queen8-1 1e5)
;-> ()
(queen8-1 1e7)
;-> ()
(queen8-1 1e7)
;-> ()

Non abbiamo trovato nessuna soluzione.

Secondo metodo: generazione di posizioni semi-casuali
-----------------------------------------------------
Generiamo un determinato numero di posizioni semi-casuali e verifichiamo se soddisfano i vincoli.
Il termine "semi-casuali" significa che per generare le posizioni sfruttiamo il fatto che per avere una soluzione tutte le regine devono trovarsi su righe diverse e su colonne diverse.
Questo vincolo restringe molto il numero delle posizioni da cui scegliere una posizione casuale. Inoltre il controllo tra due regine può essere fatto solo sulle diagonali.

Funzione che cerca in modo semi-casuale le soluzioni al problema:

(define (queen8-2 iter)
  (local (righe colonne sol check pos)
    (setq righe (sequence 0 7))
    (setq colonne (sequence 0 7))
    (setq sol '())
    ; genera iter posizioni casuali
    (for (k 1 iter)
      (setq check nil)
      ; genera posizione semi-casuale
      ; (donne su colonne e righe tutte diverse)
      (setq pos (map list (randomize '(0 1 2 3 4 5 6 7))
                          (randomize '(0 1 2 3 4 5 6 7))))
      ; for debug
      ;(if (= k 10)
      ; ; posizione valida (soluzione)
      ; (setq pos '((0 3) (1 6) (2 2) (3 7) (4 1) (5 4) (6 0) (7 5)))
      ;)
      ; controllo posizione corrente
      (for (i 0 6 1 check)
        (for (j (+ i 1) 7 1 check)
          ; controllo solo sulle diagonali
          (if (= (abs (- (pos i 0) (pos j 0)))
                 (abs (- (pos i 1) (pos j 1))))
          ;(if (attack (pos i 0) (pos i 1) (pos j 0) (pos j 1))
              (setq check true)
          )
        )
      )
      ; trovata una soluzione?
      (if (not check) (push (sort pos) sol))
    )
    ; vogliamo solo soluzioni diverse
    (unique sol)))

Proviamo con 1000 posizioni casuali:

(queen8-2 1000)
;-> (((0 6) (1 1) (2 5) (3 2) (4 0) (5 3) (6 7) (7 4))
;->  ((0 2) (1 4) (2 1) (3 7) (4 5) (5 3) (6 6) (7 0)))

Questa volta abbiamo trovato due soluzioni (dipende dal caso).
Stampiamo le soluzioni.

Funzione che stampa le soluzioni:

(define (print-solution lst)
  (local (board)
    (dolist (sol lst)
      (println "Soluzione: " (+ $idx 1))
      (setq board (array 8 8 '("")))
      (dolist (q sol)
        (setf (board (q 0) (q 1)) "Q")
      )
      (for (i 0 7)
        (for (j 0 7)
          (if (= (board i j) "Q")
              (print "■ ")
              (print "∙ ")
          )
        )
        (println "")))))

(print-solution '(((0 6) (1 1) (2 5) (3 2) (4 0) (5 3) (6 7) (7 4))
                  ((0 2) (1 4) (2 1) (3 7) (4 5) (5 3) (6 6) (7 0))))
;-> Soluzione: 1
;-> ∙ ∙ ∙ ∙ ∙ ∙ ■ ∙
;-> ∙ ■ ∙ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ■ ∙ ∙
;-> ∙ ∙ ■ ∙ ∙ ∙ ∙ ∙
;-> ■ ∙ ∙ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ■ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ∙ ∙ ■
;-> ∙ ∙ ∙ ∙ ■ ∙ ∙ ∙
;-> Soluzione: 2
;-> ∙ ∙ ■ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ■ ∙ ∙ ∙
;-> ∙ ■ ∙ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ∙ ∙ ■
;-> ∙ ∙ ∙ ∙ ∙ ■ ∙ ∙
;-> ∙ ∙ ∙ ■ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ∙ ■ ∙
;-> ■ ∙ ∙ ∙ ∙ ∙ ∙ ∙

Vediamo cosa accade se aumentiamo le iterazioni:

(length (queen8-1 1e5))
;-> 86
(length (queen8-1 1e6))
;-> 92

Con 1 milione di iterazioni abbiamo trovato tutte le 92 soluzioni.
Vediamo il tempo medio di calcolo:

(div (time (length (queen8-1 1e6)) 100) 100)
;-> 1884.08408

Tero metodo: generazione di permutazioni
----------------------------------------
Come abbiamo visto, ogni riga deve avere esattamente una regina e ogni colonna deve avere esattamente una regina.
Quindi una soluzione può essere semplicemente specificata menzionando per ogni riga il numero di colonna in cui è posizionata la regina di quella riga.
In particolare, la soluzione è una permutazione di tutti gli interi (a0,a1,a2,…,a7), dove a(r) è il numero di colonna per la regina sulla riga r.
Tale permutazione deve anche riflettere il vincolo che due regine non possono condividere una diagonale.

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

Funzione che cerca le soluzioni al problema su tutte le permutazioni possibili:

(define (queen8-3)
  (local (sol rows col check pos)
    (setq sol '())
    ; creazione posizioni con donne tutte su colonne diverse e righe diverse
    ; (length all-pos) -> 40320 = 8!
    (setq rows (perm '(0 1 2 3 4 5 6 7)))
    (setq col '(0 1 2 3 4 5 6 7))
    ; ciclo per ogni posizione...
    (dolist (r rows)
      (setq check nil)
      ; crea la posizione corrente
      (setq pos (map list col r))
      ; controllo diagonali
      (for (i 0 6 1 check)
        (for (j (+ i 1) 7 1 check)
          ;(if (attack (pos i 0) (pos i 1) (pos j 0) (pos j 1))
          (if (= (abs (- (pos i 0) (pos j 0)))
                 (abs (- (pos i 1) (pos j 1))))
                 (setq check true)
          )
        )
      )
      (if (not check) (push pos sol))
    )
    sol))
;->
Facciamo una prova:

(length (queen8-3))
;-> 92
(time (length (queen8-3)))
;-> 112.823

Stampiamo la soluzione 21:

(print-solution (list ((queen8-3) 20)))
Soluzione: 1
;-> ∙ ∙ ∙ ∙ ∙ ∙ ■ ∙
;-> ∙ ■ ∙ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ■ ∙ ∙
;-> ∙ ∙ ■ ∙ ∙ ∙ ∙ ∙
;-> ■ ∙ ∙ ∙ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ■ ∙ ∙ ∙ ∙
;-> ∙ ∙ ∙ ∙ ∙ ∙ ∙ ■
;-> ∙ ∙ ∙ ∙ ■ ∙ ∙ ∙


-----
Dieta
-----

Una persona che pesa 120 kg si mette a dieta e ogni settimana perde l'1% del peso.
In quante settimane raggiunge 80 kg?

Alla i-esima settimana il peso della persona vale il 99% della settimana precedente:

  P(i) = 0.99*P(i-1)

Dopo N settimane la formula diventa:

  P(N) = 0.99*P(N-1) = 0.99^2*P(N-2) = ... = 0.99^N*P(0)

Adesso sostituiamo nella formula: 

  P(N) = 80 (il peso dopo N settimane)
  P(0) = 120 (il peso all'inizio, dopo 0 settimane)

E la formula diventa:

  80 = 0.99^N*120

Risolviamo rispetto a N:

  N = log(80/120)/log(0.99) = 40.343438...

(define (weeks start end perc)
  (div (log (div end start) 10) (log (abs (add 1 perc)) 10)))

(weeks 120 80 -0.01)
;-> 40.3434386689579
In circa 40 settimane raggiunge il peso forma.

Ci vuole un pò più di tempo per ingrassare:

(weeks 80 120 0.01)
;-> 40.74890715609402

Ingrassare da 10 a 20 con 1%:

(weeks 10 20 0.1)
;-> 7.272540897341712

Dimagrire da 20 a 10 con -1%:

(weeks 20 10 -0.1)
;-> 6.578813478960584

Verifichiamo i risultati con la funzione primitiva "series":

> (series 120 (fn (x) (mul x 0.99)) 42)
;-> (120 118.8 117.612 116.43588 115.2715212 114.118805988 112.97761792812
;->  111.8478417488388 110.7293633313504 109.6220696980369 108.5258490010565
;->  107.440590511046 106.3661846059355 105.3025227598762 104.2494975322774
;->  103.2070025569546 102.1749325313851 101.1531832060712 100.1416513740105
;->  99.1402348602704 98.14883251166769 97.16734418655102 96.19567074468552
;->  95.23371403723866 94.28137689686626 93.3385631278976 92.40517749661862
;->  91.48112572165243 90.56631446443591 89.66065131979154 88.76404480659363
;->  87.87640435852769 86.99764031494242 86.12766391179299 85.26638727267506
;->  84.41372339994831 83.56958616594882 82.73389030428933 81.90655140124643
;->  81.08748588723397 80.27661102836163 79.47384491807802)
> (series 80 (fn (x) (mul x 1.01)) 42)
;-> (80 80.8 81.608 82.42408 83.2483208 84.080804008 84.92161204808001
;->  85.77082816856081 86.62853645024642 87.49482181474888 88.36977003289637
;->  89.25346773322534 90.14600241055759 91.04746243466316 91.95793705900979
;->  92.87751642959989 93.80629159389589 94.74435450983485 95.6917980549332
;->  96.64871603548254 97.61520319583737 98.59135522779575 99.57726878007371
;->  100.5730414678745 101.5787718825532 102.5945596013787 103.6205051973925
;->  104.6567102493664 105.7032773518601 106.7603101253787 107.8279132266325
;->  108.9061923588988 109.9952542824878 111.0952068253127 112.2061588935658
;->  113.3282204825015 114.4615026873265 115.6061177141998 116.7621788913418
;->  117.9298006802552 119.1090986870578 120.3001896739283)


----------------
Lavorare insieme
----------------

Due lavoratori A e B impiegano rispettivamente 10 ore e 5 ore per compiere da soli un certo lavoro.
Quanto tempo impiegheranno se svolgono lo stesso lavoro insieme?

Il lavoratore A svolge, in t ore, la frazione t/10 di tutto il lavoro.
Il lavoratore B svolge, in t ore, la frazione t/5 di tutto il lavoro.
Dobbiamo trovare il tempo t in modo che il loro lavoro congiunto sia 1 intero lavoro (cioè, i loro importi frazionari si sommano a 1).
Questo ci permette di scrivere la seguente equazione:

  t/10 + t/5 = 1

Risolviamo per t:

  (t + 2t)/10 = 1  -->  3t/10 = 1 --> t = 10/3 = 3.3333

Notare che t = 3.333333333333333 vale 3 ore e 20 minuti.

Funzione che converte ore decimali in ore, minui e secondi:

(define (hdec-hms x)
  (local (h m s)
    (setq h (int x))
    (setq m (int (mul 60.0 (sub x h))))
    (setq s (mul 3600.0 (sub x h (div m 60.0))))
    (list h m s)))

(hdec-hms 3.333333333333333)
;-> (3 19 59.99999999999899)

In generale:

  t/a + t/b = 1  -->  t = a*b/(a + b)

Questa ultima formula è uguale alla metà della media armonica dei numeri a e b.

(define (togheter2 a b) (div (mul a b) (add a b)))

(togheter2 10 5)
;-> 3.333333333333334

(togheter2 6 3)
;-> 2

Adesso arriva un altro lavoratore C che compie il lavoro in 3 ore.
Quanto tempo impiegheranno se A, B e C svolgono lo stesso lavoro insieme?

Ragionando come prima:
                                        a*b*c
  (t/a + t/b + t/c) = 1  -->  t = -----------------
                                   b*c + a*c + a*b 
                               
                                         10*5*3           150
  (t/10 + t/5 + t/2) = 1  -->  t = ------------------- = ----- = 1.57894...
                                    5*3 + 10*3 + 10*5      95

Provviamo a scrivere una funzione che calcola il tempo per finire un lavoro quando ci sono N lavoratori (ognuno con il proprio tempo di completamento del lavoro):

(define (togheter lst)
  (local (num den)
    (setq num (apply mul lst))
    (setq den 0)
    (dolist (x lst)
      ; es. b*c*d = (a*b*c*d)/a
      (setq den (add den (div (apply mul lst) x)))
    )
    (div num den)))

Facciamo alcune prove:

(togheter '(10 5))
;-> 3.333333333333334

(togheter '(10 5 3))
;-> 1.578947368421053

(togheter '(10 10 10 10 10))
;-> 2

Nota: aumentando il numero dei lavoratori occorre aggiungere al tempo totale di svolgimento del lavoro il tempo di "socializzazione" che cresce con l'aumentare del numero dei lavoratori...


--------------
Musica casuale
--------------

Abbiamo tre canzoni A, B e C. Se per tre volte scegliamo in maniera casuale una canzone, qual è la probabilità di ascoltare tutte e tre le canzoni?
Le canzoni hanno tutte la stessa probabilità di essere estratte.

Supponiamo che la prima canzone sia A, allora abbiamo le seguenti 9 possibilità per le prossime due canzoni:

  AA, AB, AC, BA, BB, BC, CA, CB, CC

Di queste solo due (CB e BC) permettono di ascoltare 3 canzoni diverse.
La probabilità cercata vale:

  P(3) = 2/9 = 0.2222222222222

In altre parole abbiamo solo il 22.2% di probabilità di ascoltare tre canzoni diverse.

In generale con N canzoni, qual è la probabilità che le prime N canzoni scelte casualmente siano tutte diverse?

Con N canzoni ci sono N^N possibilità per la scelta delle N canzoni da suonare:

  (N brani possibili)*(N brani possibili)* ... *(N brani possibili) = N^N

Se vogliamo ascolater N canzoni senza ripetizioni, ci sono N! arrangiamenti delle N canzoni, perché c'è
1 scelta in meno per riprodurre ogni brano successivo:

 (N brani possibili)*(N - 1 brani possibili)* ... *(N brani possibili) = N!

Quindi la probabilità di riprodurre N brani senza ripetizioni vale:

  P(N) = N!/N^N

All'aumentare di N, questo rapporto tende a 0. In altre parole, diventa sempre più improbabile ascoltare N canzoni a caso senza ripetizioni.

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (music n) (div (fact-i n) (pow n n)))

Facciamo alcune prove:

(music 3)
;-> 0.2222222222222222
(music 10)
;-> 0.00036288
(music 50)
;-> 3.424322470251197e-021

Scriviamo una funzione di simulazione.

(define (simula n iter)
  (local (conta seq lst)
    (setq conta 0)
    (setq seq (sequence 0 (- n 1)))
    (for (i 1 iter)
      ; generazione della lista casuale
      (setq lst (rand n n))
      ; lista con tutti elementi diversi?
      (if (= (sort lst) seq) (++ conta))
    )
    (div conta iter)))

Facciamo alcune prove:

(simula 3 1e6)
;-> 0.222638
(simula 3 1e7)
;-> 0.222461
(simula 10 1e7)
;-> 0.0003685
(simula 50 1e7)
;-> 0
(time (println (simula 50 1e8)))
;-> 0
;-> 375300.241

Al diminuire della probabilità da cercare (cioè con l'aumentare del numero N di canzoni), la funzione di simulazione diminuisce la capacità di calcolare il risultato corretto (perchè non è possibile effettuare il numero di iterazioni necessarie).

Per selezionare N canzoni distinte occorre mischiare la lista delle canzoni e poi attraversare semplicemente la lista mischiata.

(define (music-ok n) (randomize (sequence 1 n)))

(music-ok 10)
;-> (1 7 4 9 8 5 6 10 2 3)


---------------
Sequenza strana
---------------

Consideriamo la sequenza S = (1, 1/2, 1/3, 1/4, ..., 1/100).
Scegliere due numeri qualsiasi x e y e sostituirli con un nuovo numero che vale:

 nuovo numero = x + y + xy

Ad esempio, i numeri 1/4 e 1/8 sarebbero sostituiti da 13/32.
Continuare a ripetere il processo finché non rimane solo un numero. 
Quale numero o numeri risulteranno?

Come costruire la sequenza:

(setq numer (dup 1 100))
(setq denom (sequence 1 100))
(setq S (map list numer denom))

Funzioni per il calcolo delle quattro operazioni aritmetiche con le frazioni:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))
(define (+rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (+ (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1L) (r2 1L))))
(define (-rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (- (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1) (r2 1))))
(define (*rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 0L))
       (* (r1 1L) (r2 1L))))
(define (/rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 1L))
       (* (r1 1L) (r2 0L))))

(+rat (+rat (S 0) (S 1)) (*rat (S 0) (S 1)))
;-> (2L 1L)

Funzione che applica le regole definite alla sequenza:

(define (play n)
  (local (numer denom s)
    (setq numer (dup 1 n))
    (setq denom (sequence 1 n))
    ; potremmo anche non mischiare la lista
    (setq s (randomize (map list numer denom)))
    (until (= (length s) 1)
      (setq a (pop s))
      (setq b (pop s))
      (setq val (+rat (+rat a b) (*rat a b)))
      ;(print a { } b { } val) (read-line)
      ; non è importante dove viene inserito il nuovo valore nella sequenza
      (push val s)
    )
    (s 0)))

Facciamo alcune prove:

(play 100)
;-> (100L 1L)

(play 50)
;-> (50L 1L)

(play 1000)
;-> (1000L 1L)

Il numero finale è uguale al numero di frazioni.

Dal punto di vista matematico abbiamo la seguente funzione:

  f(x,y) = x + y + x*y

La funzione è formata solo da addizioni e moltiplicazioni che sono operazioni associative e commutative. Questo significa che non è importante quali coppie vengano scelte. Per esempio:

  f(f(x,y),z) = f(f(x,z),y) = f(f(y,z),x)

Possiamo verificare che tutte e tre le formulazioni siano uguali alla seguente espressione:

  x + y + z + xy + xz + yz + xyz

Quindi l'ordine in cui scegliamo le coppie non ha importanza.
Questo significa anche che possiamo inserire il nuovo valore in qualunque parte della lista.

Per calcolare una formula generica vediamo se esiste un pattern.
Per n = 2:
S(2) = (1 1/2)
f(1, 1/2) = 1 + 1/2 + (1)*(1/2) = 2

Per n = 3
S(3) = (1 1/2 1/3)
Sappiamo già che la scelta delle coppie 1 e 1/2 sarà sostituita dal numero 2. Quindi possiamo semplicemente saltare in avanti e valutare la coppia di 2 e 1/3.
f(2, 1/3) = 2 + 1/3 + (2)*(1/3) = 3

Per n = k
Quale sarà il risultato per la sequenza S(k)?
Sappiamo che S(k) è uguale a S(k – 1) più il termine addizionale 1/k. 
E conosciamo che il termine risultante di S(k – 1) sarà k – 1, per induzione.
Quindi possiamo valutare il termine finale per S(k) come risultato delle coppie finali (k – 1) e 1/k:

  f(k – 1, 1/k) = k – 1 + 1/k + (k – 1)/k = k – 1 + 1 = k

Questo dimostra che il termine finale di S(k) sarà k.


-----------------
Pierino e le mele
-----------------

La mamma chiede a Pierino di andare al mercato per acquistare 10 mele.
Il mercato ha 200 mele di cui 20 sono marce.
Il problema è che Pierino non è in grado di distinguere tra una mela sana e una mela marcia.
Le mele costano 20 centesimi l'una.
Se Pierino sceglie 10 mele a caso, qual è la probabilità che:
1) nessuna mela è marcia?
2) tutte le dieci mele sono marce?
3) X mele sono marce?
4) la mamma è insoddisfatta?

Calcola il coefficiente binomiale (n k) = n!/(k!*(n - k)!)
Numero di combinazioni di k elementi senza ripetizione da n elementi.

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

Modi in cui si possono scegliere 10 mele su 200: binom[200 10]

(binom 200 10)
;-> 22451004309013280L


1) Soluzione
Ci sono 180 mele sane. Se Pierino vuole evitare le mele marce, deve selezionare le sue 10 mele in 
questo insieme. Pertanto, ci sono binom[180 10] modi in cui Pierino può selezionare tutte le mele buone. Le probabilità che quasto accada vale:

          numero eventi favorevoli     binom[180 10]
  P(1) = -------------------------- = --------------- = 0.3397743762367859
            numero eventi totale       binom[200 10]

(div (binom 180 10) (binom 200 10))
;-> 0.3397743762367859

2) Soluzione
Ci sono 20 mele marce, da cui Bob deve selezionare tutte e 10 le sue mele.
Le probabilità che quasto accada vale:

          binom[20 10]
  P(2) = --------------- = 8.229297783610822e-012
          binom[200 10]

(div (binom 20 10) (binom 200 10))
;-> 8.229297783610822e-012

3) Soluzione
Dalle 20 mele marce, Pierino seleziona x mele marce e le restanti (10 – x) mele buone (il valore di x è compreso tra 0 e 10).

          binom[20 x]*binom[180 (10 - x)]
  P(2) = --------------------------------- = 
                   binom[200 10]

(define (mele-marce x)
  (div (* (binom 20 x) (binom 180 (- 10 x)))
       (binom 200 10)))

Calcoliamo le probabilità di selezionare da 1 a 10 mele marce:

(for (i 1 10) (println "mele marce: " i ", prob: " (mele-marce i)))
;-> mele marce: 1, prob: 0.3973969312710947
;-> mele marce: 2, prob: 0.1975432419981313
;-> mele marce: 3, prob: 0.05480968564110002
;-> mele marce: 4, prob: 0.009371196251854745
;-> mele marce: 5, prob: 0.001028154103060635
;-> mele marce: 6, prob: 7.302230845601101e-005
;-> mele marce: 7, prob: 3.300443320045695e-006
;-> mele marce: 8, prob: 9.03913549731616e-008
;-> mele marce: 9, prob: 1.346612364590862e-009
;-> mele marce: 10, prob: 8.229297783610822e-012

4) Soluzione
La probabilità che Pierino renda la madre insoddisfatta è data dalla somma di tutte le probabilità: 

(apply add (map mele-marce (sequence 1 10)))
;-> 0.6602256237632141

quindi Pierino ha il 66% di probabilità di fallire.
Ma Pierino acquista 30 mele ed è certo di avere 20 mele sane (nella peggiore delle ipotesi avrà 20 mele sane e 10 mele marce):

  Spesa di 20 mele: (20 * 0.2) = 4 euro
  Spesa di 30 mele: (30 * 0.2) = 6 euro
  Differenza di prezzo = (30 * 0.2) - (20 * 0.2) = 6 - 4 = 2 euro

Una Mamma soddisfatta vale molto più di 2 euro.

Nota: prima di andare a casa Pierino dovrà farsi aiutare da qualcuno per dividere le mele sane da quelle marce.


----------------------
Dado e numero ripetuto
----------------------

Qual è il numero previsto di lanci affinché un dado produca due numeri uguali?

Scriviamo una funzione di simulazione.

(define (dado iter)
  (local (totale-lanci nums found lanci val)
    (setq totale-lanci 0)
    (for (i 1 iter)
      ; vettore delle frequenze
      (setq nums (array 7 '(0)))
      (setq found nil)
      (setq lanci 0)
      ; ciclo fino a trovare un numero estratto due volte...
      (until found
        ; numero estratto
        (setq val (+ (rand 6) 1))
        ; aumenta numero lanci
        (++ lanci)
        ; aumenta frequenza
        (++ (nums val))
        ; numero già uscito?
        (if (> (nums val) 1)
            (set 'totale-lanci (+ totale-lanci lanci) 'found true)
        )
        ;(println nums { } val)
        ;(print lanci { } totale-lanci) (read-line)
      )
    )
    (div totale-lanci iter)))

Facciamo alcune prove:

(dado 1e4)
;-> 3.7749
(dado 1e5)
;-> 3.77363
(dado 1e6)
;-> 3.777907
(dado 1e7)
;-> 3.7747246

Poichè il numero di lanci per ottenere un numero doppio va da 2 a 7, il numero ottenuto dalla simulazione sembra ragionevole.

Dal punto di vista matematico possiamo ragionare nel modo seguente.
Il primo tiro è sempre un numero univoco e il settimo tiro è sempre un numero ripetuto.
Sia E(x) il numero atteso di lanci per avere un duplicato se sono già usciti x numeri diversi.
Se abbiamo visto tutti e 6 i numeri, il prossimo lancio produrrà sicuramente un numero ripetuto. Quindi E(6) = 1.

  E(6) = 1

Quanto vale E(5)?
Possiamo calcolarlo in termini di E(6). C'è una probabilità 5/6 che il tiro produca un duplicato, nel qual caso abbiamo finito in 1 lancio. E c'è 1/6 di probabilità di avere un numero diverso, nel qual caso il tempo medio è E(6) più il tiro 1 che abbiamo appena fatto. Quindi abbiamo quanto segue:

 E(5) = (5/6)*(1) + (1/6)8(1 + E(6))
 E(5) = 1 + (1/6)*E(6)
 E(5) = 1 + (1/6)*1 = 7 /6

Quanto vale E(4)?
Possiamo calcolarlo in modo simile in termini di E(5). C'è una probabilità di 4/6 di avere un duplicato, nel qual caso abbiamo finito in un 1 lancio. E c'è 2/6 di possibilità di avere un numero diverso, nel qual caso arriviamo al caso di aver visto 5 numeri, più aggiungiamo il tiro che abbiamo appena fatto. Adesso abbiamo:

  E(4) = (4/6)*(1) + (2/6)*(1 + E(5))
  E(4) = 1 + (2/6)*E(5)
  E(4) = 1 + (1/6)*(7/6) = 25/18

Notiamo che esiste uno schema per i calcoli.
Se abbiamo visto x numeri, allora c'è x/6 di probabilità di avere unduplicato e finire con 1 lancio. Oppure c'è (1-x)/6 di probabilità di avere un numero diverso e arriviamo al caso di aver visto (x + 1) numeri e dobbiamo aggiungere il tiro appena fatto.
Quindi la formula generale è la seguente:

  E(x) = (x/6)*(1) + ((1 - x)/6)*(1 + E(x + 1))
  E(x) = 1 + ((1 - x)/6)*E(x + 1)

Possiamo usare questa formula per calcolare i valori di E(3), E(2), E(1) e E(0), cioè dopo aver visto 3, 2, 1 e poi 0 numeri:

  E(3) = 61/36, 
  E(2) = 115/54, 
  E(1) = 899/324,
  E(0) = 1223/324.

Quindi, quando iniziamo, e non sono ancora stati visti numeri, il numero previsto di lanci fino a quando non vediamo un duplicato è E(0) = 1223/324, che è circa 3.77.

(div 1223 324)
;-> 3.774691358024692

Il risultato della simulazione e quello matematico sono congruenti.


-------------
Dado truccato
-------------

In un locale d'azzardo viene proposto il seguente gioco:
Un singolo dado viene lanciato 2 volte.
Se i due lanci consecutivi producono lo stesso numero, allora vinciamo 6 euro.
Il costo per un singolo gioco è 1 euro.
In altre parole, se escono due numeri uguali vinciamo 5 euro, altrimenti perdiamo 1 euro.

Attenzione, il dado potrebbe essere truccato.
Il gioco è equo? oppure è avvantaggiato il banco o il giocatore?

Scriviamo prima una simulazione per calcolare il valore atteso del gioco con un dado equo:

(define (equo iter)
  (local (totale a b)
    (setq totale 0)
    (for (i 1 iter)
      (setq a (rand 6))
      (setq b (rand 6))
      (if (= a b)
        (++ totale 5)
        (-- totale)
      )
    )
    (div totale iter)))

Facciamo alcune prove:

(equo 1e6)
;-> -0.005404
(equo 1e7)
;-> 0.0009146
(equo 1e8)
;-> 0.00037508

Il gioco sembra equo. Vediamo dal punto di vista matematico.
Se il dado è equo ogni numero ha probabilità 1/6 di apparire.
Ci sono 36 lanci possibili e si vince solo con 6 risultati:

  (primo tiro, secondo tiro) = (1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6).

Quindi si vince in 6/36 = 1/6 partite.
Poichè il gioco paga 6 euro al costo di 1 euro per giocare, il valore atteso vale:

  VA = P(vittoria)*(guadagno) + P(sconfitta)*(rimessa) = (1/6)*5 + (5/6)*(-1) = 0

Poichè il valore atteso vale 0, allora il gioco è equo.

Cosa accade se il dado è truccato?
Un dado è truccato quando la probabilità di uscita dei 6 numeri non è la stessa per tutti.
Nota: la somma delle probabilità di tutti i numeri deve essere uguale a 1.

Scriviamo una simulazione per calcolare il valore atteso del gioco con un dado non equo.

La seguente funzione genera un numero casuale data una lista che contiene le probabilità di ogni numero.
Il numero casuale va da 0 a ((length lista) - 1).

(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero,
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

(setq p '(0.05 0.15 0.35 0.45))
(apply add p)
;-> 1

(rand-pick p)
;-> 2

Facciamo una prova per verificare la correttezza della funzione:

(setq p '(0.05 0.15 0.35 0.45))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (49676 150476 349804 450044)
(apply + vet)
;-> 1000000

Funzione di simulazione del gioco per un dado non equo:

(define (non-equo lst iter)
  (local (totale a b)
    (setq totale 0)
    (for (i 1 iter)
      (setq a (rand-pick lst))
      (setq b (rand-pick lst))
      (if (= a b)
        (++ totale 5)
        (-- totale)
      )
    )
    (div totale iter)))
(div 1 6)

Proviamo con un dado equo:

(setq p '(0.1666666666666667 0.1666666666666667 0.1666666666666667
          0.1666666666666667 0.1666666666666667 0.1666666666666667))
(apply add p)
;-> 1
(non-equo p 1e6)
;-> -0.001546
(non-equo p 1e7)
;-> 0.0002828

I risultati sono corretti.

Proviamo con il numero 5 che ha 25% di probabilità di uscire (e scegliamo il numero 1 come quello che ha 8.3% di probabilità di uscire):

(setq p '(0.1666666666666667 0.08333333333333329 0.1666666666666667
          0.1666666666666667 0.1666666666666667 0.25))
(apply add p)
;-> 1
(non-equo p 1e6)
;-> 0.081902
(non-equo p 1e7)
;-> 0.0838016

Adesso P(5) = 50% e P(2) = P(3) = P(4) = 5.55555555555555%:

(setq p '(0.1666666666666667 0.1666666666666667 0.0555555555555555
          0.0555555555555555 0.0555555555555555 0.5))
(apply add p)
;-> 0.9999999999999999
(non-equo p 1e6)
;-> 0.8861
> (non-equo p 1e7)
;-> 0.8894594

Vediamo un caso limite, P(0) = 1, P(x) = 0 con x da 1 a 5
(setq p '(1 0 0 0 0 0))
(apply add p)
;-> 1
(non-equo p 1e6)
;-> 5
(non-equo p 1e7)
;-> 5
In questo caso si vince sempre.

La simulazione afferma che in caso di dado non-equo il giocatore ha un valore atteso maggiore di 0, quindi è vantaggioso giocare.

Dal punto di vista matematico possiamo scrivere la lista delle probabilità dei numeri da 1 a 6:

 P = (p0 p1 p2 p3 p4 p5)

La probabilità di vittoria è data dal prodotto scalare (dot-product) di P con se stesso.
Questo deriva dall'algebra lineare: il prodotto scalare è minimo quando tutte le variabili sono uguali tra loro. Quindi la probabilità più piccola di ottenere un numero qualsiasi è 1/6.

(define (dot-product x y)
"Calculates the dot-product of two list/array of arbitrary length"
  (apply add (map mul x y)))

(setq p '(0.1666666666666667 0.1666666666666667 0.1666666666666667
          0.1666666666666667 0.1666666666666667 0.1666666666666667))
(dot-product p p)
;-> 0.1666666666666668

Negli altri casi questa probabilità aumenta:

(setq p '(0.1666666666666667 0.08333333333333329 0.1666666666666667
          0.1666666666666667 0.1666666666666667 0.25))
(dot-product p p)
;-> 0.1805555555555556

(setq p '(0.1666666666666667 0.1666666666666667 0.0555555555555555
          0.0555555555555555 0.0555555555555555 0.5))
(dot-product p p)
;-> 0.3148148148148148

(setq p '(1 0 0 0 0 0))
(dot-product p p)
;-> 1

In definitiva, se il dado è equo, allora il gioco è equo, se il dado non è equo, allora il gioco è favorevole al giocatore.

-------------------------------
Lisp 1.5 Manual - John McCarthy
-------------------------------

I. THE LISP LANGUAGE

The LISP language is designed primarily for symbolic data processing. It has been used for symbolic calculations in differential and integral calculus, electrical circuit theory, mathematical logic, game playing, and other fields of artificial intelligence.

LISP is a formal mathematical language. It is therefore podsible to give a concise yet complete description of it. Such is the purpose of this first section of the manual. Other sections will describe ways of using LISP to advantage and will explain extensions of the language which make it a convenient programming system. LISP differs from most programming languages in three important ways.

The first way is in the nature of the data. In the LISP language, all data are in the form of symbolic expressions usually referred to as S-expressions. S-expressions are of indefinite length and have a branching tree type of structure, so that significant subexpressions can be readily isolated. In the LISP programming system, the bulk of available memory is used for storing S-expressions in the form of list structures. This type of memory organization frees the programmer from the necessity of allocating storage for the different sections of his program.

The second important part of the LISP language is the source language itself which specifies in what way the S-expressions are to be processed. This consists of recursive functions of S-expressions. Since the notation for the writing of recursive functions of S-expressions is itself outside the S-expression notation, it will be called the meta language. These expressions will therefore be called M-expressions.

Third, LISP can interpret and execute programs written in the form of Sexpressions. Thus, like machine language, and unlike most other higher level languages, it can be used to generate programs for further execution.
------------

John McCarthy wrote in the LISP 1.5 programmer’s manual that LISP differs from most programming languages in three ways:

1) The first way is the data. In the LISP language, all data are in the form of symbolic expressions usually referred to as S-expressions.

2) The second important part of the LISP language is the source language itself which specifies in what way the S-expressions are to be processed. This consists of recursive functions of S-expressions.

3) Third, LISP can interpert and execute programs written in the form of S-expressions. Thus, like machine language, and unlike most other higher level languages, it can be used to generate programs for further execution.


------------------------
Ciclo for con due indici
------------------------

newLISP supporta un solo indice per il ciclo "for".
Per esempio potremmo voler scrivere:

  (for ((i 1 5 1) (j 10 2 -2)) expr)

La precedente espressione (non supportata) rappresenta un ciclo for con due indici "i" e "j".
"i" varia da 1 a 5 con passo 1.
"j" varia da 10 a 2 con passo -2.

Vediamo come possiamo simularla:

(setq j 10)
(for (i 1 5 1 (= j 0))
 (println (string "i=" i " j=" j))
 (setq j (- j 2))
)
;-> i=1 j=10
;-> i=2 j=8
;-> i=3 j=6
;-> i=4 j=4
;-> i=5 j=2

Un altro metodo più generico:

  (for ((i low-i high-i step-i) (j low-i high-i step-i)) expr)

(setq low-i 1)
(setq high-i 5)
(setq step-i 1)
(setq low-j 10)
(setq high-j 2)
(setq step-j -2)
(setq i low-i)
(setq j low-j)

(while (and (!= i (+ high-i 1)) (!= j (+ high-j 1)))
  (println (string "i=" i " j=" j))
  (inc i step-i)
  (inc j step-j)
)
;-> i=1 j=10
;-> i=2 j=8
;-> i=3 j=6
;-> i=4 j=4
;-> i=5 j=2


---------------------------------------
Challenge: the seemingly simple 'my-or'
---------------------------------------

From a post of itstoday:

my-or is a macro, but not just any macro, it's a safe one. It takes exactly two arguments and evaluates the first argument only once, and it's immune to variable capture. If the result of that evaluation is true, then that value is returned, otherwise, the result of evaluating the second argument is returned.

I'm looking for a single macro function, that gets the job done without any other user-defined functions or macros

Sounds simple? Try it, it's not. Here, I'll help you out (evil grin). Here is the solution as written in Scheme:

(define-macro my-or
  (lambda (x y)
    (let ((temp (gensym)))
      `(let ((,temp ,x))
         (if ,temp ,temp ,y)))))

Once you've written 'my-or', run it against this program to test it:

(set 'temp 45)
(println "(my-or temp nil) = " (my-or temp nil))
(println "(my-or nil temp) = " (my-or nil temp))
(println "-----------")
(set 'value (my-or (begin (println "first arg") 1) (begin (println "second arg") 2)))
(println "should be 1: " value)
(println "-----------")
(set 'value (my-or (begin (println "first arg") nil) (begin (println "second arg") 2)))
(println "should be 2: " value)

IMPORTANT: In your implementation, make sure to name the symbol that you store the result of evaluating the first argument as 'temp'! Otherwise the variable-capture challenge is moot.

The winner is the first person to get the following output exactly:

(my-or temp nil) = 45
(my-or nil temp) = 45

Some solutions:

1) Kazimir Majorinc

(set 'my-or
  (lambda-macro (x y)
     (eval (let ((temp (sym (string (inc counter)))))
                (expand
                  '(let ((temp (eval x)))
                          (if temp          ; Naive
                              temp          ; version
                              (eval y)))
                 'temp)))))

(set 'my-or
  (lambda-macro (x y)
     (first (list (eval (let ((temp (sym (append (string (last (symbols))) "+"))))
                    (expand
                     '(let ((temp (eval x)))
                            (if temp          ; Naive
                              temp          ; version
                              (eval y)))
                 'temp)))
             (delete (last (symbols)))    ))))

2) Lutz

The proper solution in newLISP (not following the contest rules) is to avoid variable capture in the first place by enclosing the 'my-or' in a namespace:

(define-macro (my-or:my-or)
   (let (my-or:temp (eval (args 0)))
      (if my-or:temp my-or:temp (eval (args 1)))))

(my-or 1 nil) => 1
(my-or nil 1) => 1

it is as fast as the naive solution which is prone to variable capture.

3) newdep

(define-macro (my-or)
 (let (temp
  (unless (eval (args 0))
   (eval (args 1))))
    temp))

4) cgs1019

(define-macro (my-or)
  (
    (lambda ()
      (if (args 0)
          (args 0)
          (eval (args 1))
      )
    )
    (eval (args 0))
    (args 1)
  )
)

This solution uses a lambda to store the eval'ed first arg to the macro and defer evaluation of the second. It's not as fast as the solution presented by lutz, which has an execution time about 65% of mine, probably because mine entails an extra function call. But it does, at least, avoid the need for creating a new context just for one simple macro.
This use nested function call to transfer arguments in nested function so you do not have to use any variable at all. As (arg n) are always local, accidental overshadowing is impossible. Very interesting idea.

Here a rewrite easier to understand for beginners:

(define-macro (my-or)
  (let ( func (lambda () (if (args 0) (args 0) (eval (args 1)) )))
    (func (eval (args 0)) (args 1))
  )
)

cgs1019 passes the user arguments to an inner function, with only the first argument evaluated. The inner function then decides if the second must be evaluated too. cgs1019 just uses the anonymous version of func. This is like doing:

((lambda (x) (+ x x)) 1) => 2

5) itstoday

(define-macro (my-or)
   (catch
      (begin
         (let (temp (eval (args 0)))
            (if temp (throw temp))
         )
         (throw (eval (args 1)))
      )
   )
)


-------------------------
Link simbolico di oggetti
-------------------------

Come è possibile avere due oggetti uguali in cui una modifica su un oggetto si riflette anche sull'altro?
Ad esempio, due liste lst1 e lst2:

(setq lst1 '(1 2 3))

Copio la lista su un'altra lista:

(setq lst2 lst1)

Modifico lst1:

(setf (lst1 0) 0)

lst1
;-> (0 2 3)

Ma lst2 non è cambiata:

lst2
;-> (1 2 3)

Poichè i contesti vengono passati per riferimento possiamo scrivere:

(set 'A:var '(1 2 3))
;-> (1 2 3)
(set 'A:num 12)
;-> 12

Copio il contesto A nel contesto B (viene copiato tutto):

(set 'B A)
;-> A
A:var
;-> (1 2 3)
B:var
;-> (1 2 3)

Modifico A:var:

(pop A:var)
;-> 1
A:var
;-> (2 3)

Anche B:var è stato modificato:

B:var
;-> (2 3)

Vale anche il contrario. Modifico B:num:

(setq B:num 10)
;-> 10
B:num
;-> 10

Anche A:num è stato modificato:

A:num
;-> 10

Inseriamo un altro contesto e vediamo cosa accade:

(set 'C A)
;-> A

Modifichiamo C:num:

C:num
;-> 10
(setq C:num 22)
C:num
;-> 22

Anche A:num e B:num sono stati modificati:

A:num
;-> 22
B:num
;-> 22

Nota: questo comportamento dipende da "ORO: One-Reference-Only", il sistema di gestione della memoria di newLISP.


-----------------------------
Il numero 0 è pari o dispari?
-----------------------------

In matematica, "zero" è un numero pari. 
Questo può essere facilmente verificato in base alla definizione di "pari": è un multiplo intero di 2, precisamente 0*2.
In termini sociali la "parità" può essere vista come il "trattamento equo di due persone". La divisione per due di qualunque bene rappresenta un trattamento equo. Se il bene è "zero" e lo dividiamo per due, entrambe le persone hanno avuto lo stesso trattamento.
Anche per newLISP il numero 0 è pari:

(even? 0)
;-> true
(odd? 0)
;-> nil


---------------------------
Rapporto tra numeri casuali
---------------------------

Siano x e y due numeri casuali compresi tra 0 e 1.
Qual è la probabilità che x/y arrotonda a un numero pari?
Per esempio:

  a = (random 0 1) = 0.9467146824549089
  b = (random 0 1) = 0.4056825464644307
  a/b = 0.9467146824549089/0.4056825464644307 = 2.33363424358685
  result = round(2.33363424358685) = 2  --> numero pari

  a = (random 0 1) = 0.9525437177648244
  b = (random 0 1) = 0.2914517654957732
  a/b = 0.9525437177648244/0.2914517654957732 = 3.268272251308901
  result = round(3.268272251308901) = 3  --> numero dispari

Dato che x/y varia da 0 a infinito, e la probabilità che un numero sia pari o dispari è la stessa, allora la probabilità di arrotondamento a pari o dispari deve essere la stessa. 
Quindi la risposta è del 50%.

Siamo sicuri?

Scriviamo una funzione di simulazione:

(define (pari-dispari iter)
  (local (even odd)
    (for (i 1 iter)
      (if (even? (round (div (random 0 1) (random 0 1)) 0))
          (++ even)
          (++ odd)
      )
    )
    (list (div even iter) (div odd iter))))

Proviamo:

(pari-dispari 1e7)
;-> (0.4647791 0.5352209)
(pari-dispari 1e8)
;-> (0.46459377 0.53540623)

I numeri pari sono il 46.46% e i numeri dispari sono il 53.54%.

Dal punto di vista matematico è stato dimostrato che la soluzione vale:

  P(x/y arrotonda ad un numero pari) = 5/4 - π/4 = 0.4646...

(setq PI 3.1415926535897931)
(sub (div 5 4) (div PI 4))
;-> 0.4646018366025517

La nostra simulazione produce il risultato corretto.


-----------------------------------------------
Definizione di funzioni all'interno di funzioni
-----------------------------------------------

Ecco come definire una funzione all'interno di un'altra funzione.
La funzione creata viene eliminata una volta terminata la funzione principale.

La funzione applica una funzione a tutti gli elementi di una lista (anche annidata):

(define (mapflat f lst)
  (let ((anonima (lambda (x)    ; define internal function
                (cond ((atom? x) x)
                       ("else" (apply f (map anonima x)))))))
    (anonima lst)))

(mapflat + '(1 2 3 (4 5 6 (7 8 9) 10)))
;-> 55

La funzione "anonima" non esiste più:

anonima
;-> nil

Invece nel modo seguente la funzione interna esiste anche dopo il termine della funzione creatrice:

(define (mapflat2 f lst)
   (let ((dummy 0))
         ; define internal-external function
         (define (anonima2 x)
               (cond ((atom? x) x)
                      ("else" (apply f (map anonima2 x)))))
    (anonima2 lst)))

(mapflat2 + '(1 2 3 (4 5 6 (7 8 9) 10)))
;-> 55

Ed ecco la funzione "anonima2":

anonima2
;-> (lambda (x)
;->  (cond
;->   ((atom? x) x)
;->   ("else" (apply f (map anonima2 x)))))

Vediamo un altro esempio dove viene creata una funzione diversa in base ad un parametro e la funzione creata esiste anche dopo il termine della funzione creatrice:

(define (main-function a?)
   (if a?
      ; funzione 1
      ; funzione 2
      (define (dafunc) (println "Doing something"))
      (define (dafunc) (println "Doing something completely different"))
   )
   (dotimes (i 3)
      (dafunc)
   )
)

(main-function true)
;-> Doing something
;-> Doing something
;-> Doing something
dafunc
;-> (lambda () (println "Doing something"))

(main-function nil)
;-> Doing something completely different
;-> Doing something completely different
;-> Doing something completely different
dafunc
;-> (lambda () (println "Doing something completely different"))


-------------------
La funzione for-all
-------------------

Vediamo la definizione dal manuale:

********************
>>>funzione FOR-ALL
********************
sintassi: (for-all func-condition list)

Applica la funzione func-condition a tutti gli elementi nella lista. 
Se tutti gli elementi soddisfano la condizione in func-condition, il risultato è true, in caso contrario, viene restituito nil.

(for-all number? '(2 3 4 6 7))
;-> true

(for-all number? '(2 3 4 6 "hello" 7))
;-> nil

(for-all (fn (x) (= x 10)) '(10 10 10 10 10))
;-> true

Utilizzare la funzione "exist" per verificare se almeno un elemento in una lista soddisfa una condizione.
------------

Possiamo usare la funzione "apply" per alcune cose:

(apply = '(11 10 10 10 10))
;-> nil
(apply = '(10 10 10 10 10))
;-> true

(apply (fn (x) (= x 10)) '(11 10 10 10 10))
;-> nil
(apply (fn (x) (= x 10)) '(10 10 10 10 10))
;-> true

Le seguenti funzioni svolgono attività simili:

(define (map-predicate func lst bool)
  (if bool
      (for-all func lst)
    (map func lst)))

(map-predicate number? '(1 2 3 4 5) true)
;-> true
(map-predicate number? '(1 2 3 4 5) nil)
;-> (true true true true true)

(map-predicate number? '(1 2 3 "no" 5) true)
;-> nil
(map-predicate number? '(1 2 3 "no" 5) nil)
;-> (true true true nil true)

(define (map+ func lst bool)
  (if bool
      (apply = (map func lst))
    (map func lst))
)

(map+ sqrt '(4 9 16) true)
;-> nil
(map+ sqrt '(4 9 16) nil)
;-> (2 3 4)

(map+ sqrt '(4 4 4) true)
;-> true
(map+ sqrt '(4 4 4) nil)
;-> (2 2 2)

(define (map-compare func lst value)
  (apply = (cons value (map func lst)))
)

(map-compare sqrt '(4 4 4) 5)
;-> nil
(map-compare sqrt '(4 4 4) 2)
;-> true
(map-compare sqrt '(4 9 16) 2)
;-> nil
(map-compare sqrt '(4 9 16) 3)
;-> nil
(map-compare sqrt '(4 9 16) 4)
;-> nil


------------------
La funzione random
------------------

Vediamo la definizione dal manuale:

********************
>>> funzione RANDOM
********************
sintassi: (random float-offset float-scale int-n)
sintassi: (random float-offset float-scale)

Nella prima forma, "random" restituisce una lista di "int-n" numeri in virgola mobile distribuiti uniformemente e scalati (moltiplicati) per "float-scale", con l'aggiunta dell'offset "float-offset".
Il punto di partenza del generatore casuale interno può essere generato usando "seed".

(random 0 1 10)
;-> (0.10898973 0.69823783 0.56434872 0.041507289 0.16516733
;->  0.81540917 0.68553784 0.76471068 0.82314585 0.95924564)

Quando viene utilizzato nella seconda forma, "random" restituisce un unico numero distribuito uniformemente:

(random 10 5)
;-> 11.0971

Quando non vengono forniti parametri, "random" assume una media di 0.0 e una deviazione standard di 1.0.

Vedi anche le funzioni "normal" e "rand".
------------

La funzione "random" restituisce anche 0 e 1:

(seed (time-of-day))
(set 'counter 0)
(dotimes(i 200000)
  (let ((r (random)))
    (unless (and (< 0 r) (< r 1))
    (println "edge " (inc counter) ": " r))))
;-> 61349469
;-> 0
;-> edge 1: 0
;-> edge 2: 0
;-> edge 3: 0
;-> edge 4: 0
;-> edge 5: 0
;-> edge 6: 0
;-> edge 7: 0
;-> edge 8: 0
;-> edge 9: 1
;-> edge 10: 0
;-> edge 11: 0
;-> edge 12: 0
;-> edge 13: 1

Il fatto che si verificano casi limite è una questione di design.
Un'altra sorpresa è che i casi limite si verificano all'incirca una volta ogni 16384 volte e ciò potrebbe essere troppo frequente, se random restituisce una decina di cifre significative.

Ciò accade solo su Windows in cui il generatore casuale interno restituisce (purtroppo) solo valori interi compresi tra 0 e 32767 (15 bit). Sulla maggior parte degli Unix non lo vediamo (quasi) mai, dove i generatori casuali interni restituiscono 31 bit significativi.


---------
Freccette
---------

Una squadra di freccette è composta da due giocatori, A e B.
A ha una precisione di 1/3 e B di 1/4.
La gara si svolge nel modo seguente: ogni squadra fa lanciare a turno una freccetta per ogni componente fino a che non colpiscono il bersaglio.
Per esempio, A,B,A,...fino a che uno dei due colpisce il bersaglio.
Quanti lanci occorrono in media se la serie vale: A,B,A,B,...?
Quanti lanci occorrono in media se la serie vale: B,A,B,A,...?

In linea di principio il numero medio di lanci che una persona farà è 1 diviso la sua precisione.

1) lancia prima A
C'è una possibilità di 1/3 che A colpisce al primo lancio.
Se A sbaglia con probabilità 2/3, allora c'è a (2/3)*(1/4) possibilità che B colpisca il bersaglio al secondo lancio.
Se nessuno dei due colpisce al primo lancio (possibilità di (2/3)*(3/4)), allora siamo nella stessa
posizione d iniziale, tranne per il fatto che il numero totale di lanci deve essere aumentato di 2.
Quindi abbiamo l'equazione:

lanci medi = Pr(primo lancio)(1) + Pr(secondo lancio)(2) + Pr(nessun risultato nel primo o nel secondo)(media +
2)

  n = (1/3)*(1) + (2/3)*(1/4)*(2) + (2/3)*(3/4)*(n + 2)

Risolvendo questa equazione troviamo n = 10/3 = 3.33333...
Quindi ci vorranno in media 3 e 1/3 lanci per colpire il bersaglio.

2) lancia prima B
Se lancia prima B, allora l'aspettativa sarebbe:
lanci medi = Pr(primo lancio)(1) + Pr(secondo lancio)(2) + Pr(nessun risultato nel primo o nel secondo)*(media + 2)

  n = (1/4)*(1) + (3/4)*(1/3)*(2) + (3/4)*(2/3)*(n + 2)

Risolvendo questa equazione troviamo n = 3.5.

Dal momento che B inizia per primo ed è meno preciso, il numero previsto di lanci è un po' più alto.

Scriviamo una funzione di simulazione.
Supponiamo che 0 sia il bersaglio, allora A genera un numero casuale 0,1 o 2 e B genera un numero casuale 0,1,2 o 3.

(define (freccette p1 p2 iter)
  (local (totale colpito lanci)
    (setq totale 0)
    (for (i 1 iter)
      (setq colpito nil)
      (setq lanci 0)
      (until colpito
        (setq r1 (rand p1))
        (if (zero? r1) (setq colpito true))
        (++ lanci)
        (setq r2 (rand p2))
        (if (and (zero? r2) (nil? colpito))
          (begin
            (setq colpito true)
            (++ lanci))
        )
        (if (nil? colpito) (++ lanci))
        ;(print r1 { } r2 { } lanci) (read-line)
      )
      (setq totale (+ totale lanci))
    )
    (div totale iter)))

Verifichiamo i risultati matematici:

(freccette 3 4 1e6)
;-> 3.333139
(freccette 3 4 1e7)
;-> 3.3337905

(freccette 4 3 1e6)
;-> 3.493661
(freccette 4 3 1e7)
;-> 3.5003379

I risultati della simulazione sono congruenti con i risultati matematici.


---------------
Lights Out Game
---------------

Lights Out è un gioco elettronico pubblicato da Tiger Electronics nel 1995.
Il gioco consiste in una griglia di pulsanti luminosi 5x5. 
All'inizio del gioco, si accendono un numero casuale di pulsanti.
Ogni volta che viene premuto un pulsante, lo stato di quel pulsante e di tutti i pulsanti che condividono un bordo con esso cambia (le spie accese si spengono e viceversa). 
L'obiettivo del gioco è spegnere tutte le luci.

Scriviamo una versione minimale del gioco (circa 50 linee di codice).

; on
(print "■ ")
; off
(print "∙ ")

; on
(print "* ")
; off
(print ". ")

Funzione che stampa la griglia di gioco:

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (cond ((= (grid i j) 1) (print "■ ")) ; on
              ((= (grid i j) 0) (print "∙ ")) ; off
              (true (println "ERROR"))
        )
      )
      (println))))

(setq test (array 3 3 (rand 2 9)))
;-> ((0 1 0) (1 1 0) (0 1 1))
(print-grid test)
;-> ∙ ■ ∙
;-> ■ ■ ∙
;-> ∙ ■ ■

Funzione che crea una lista di "vicini" della cella (row col):

(define (vicini row col max-row max-col)
  (local (out up down sx dx)
    (setq out '())
    ; UP (cella sopra)
    (setq up (- row 1))
    (if (>= up 0) (push (list up col) out -1))
    ; DOWN (cella sotto)
    (setq down (+ row 1))
    (if (< down max-row) (push (list down col) out -1))
    ; SX (cella a sinistra)
    (setq sx (- col 1))
    (if (>= sx 0) (push (list row sx) out -1))
    ; DX (cella a destra)
    (setq dx (+ col 1))
    (if (< dx max-col) (push (list row dx) out -1))
    out))

(vicini 2 3 5 5)
;-> ((1 3) (3 3) (2 2) (2 4))

Funzione che verifica se il gioco è finito (tutte le luci spente = tutti i valori uguali a 0):

(define (endgame? grid) (for-all (fn(x) (= x 0)) (flat (array-list grid))))

Funzione che gestisce l'input utente di una cifra intera:

(define (read-int msg val-min val-max)
  (local (done k)
    (setq done nil)
    (print msg)
    (until done
      (setq k (- (read-key) 48))
      (if (and (>= k val-min) (<= k val-max))
        (setq done true)
      )
    )
    (println k)
    k))

Funzione che gestisce il gioco:

(define (lights-out size)
  (local (board mosse rr cc celle)
    ; crea griglia di gioco casuale
    (setq board (array size size (rand 2 (* size size))))
    (setq mosse 0)
    ; ciclo del gioco
    (until (endgame? board)
      ; stampa griglia di gioco
      (print-grid board)
      ; Input utente
      (setq rr (read-int (string "row (0.." (- size 1) "): ") 0 (- size 1)))
      (setq cc (read-int (string "col (0.." (- size 1) "): ") 0 (- size 1)))
      ;(print "row: " ) (setq rr (int (read-line)))
      ;(print "col: " ) (setq cc (int (read-line)))
      ;(println rr { } cc)
      ; calcola le celle vicine alla cella (rr cc)
      (setq celle (vicini rr cc size size))
      ; aggiorna la cella corrente
      (setf (board rr cc) (- 1 (board rr cc)))
      ; aggiorna le celle vicine
      (dolist (c celle)
        (setf (board (c 0) (c 1)) (- 1 (board (c 0) (c 1))))
      )
      (++ mosse)
    )
    ; fine del gioco
    (println "Risolto in " mosse " mosse.")
    (print-grid board)
  ) 'game-over
)

Facciamo una prova:

(lights-out 2)
;-> ■ ■
;-> ∙ ∙
;-> row (0..1): 0
;-> col (0..1): 0
;-> ∙ ∙
;-> ■ ∙
;-> row (0..1): 1
;-> col (0..1): 0
;-> ■ ∙
;-> ∙ ■
;-> row (0..1): 0
;-> col (0..1): 0
;-> ∙ ■
;-> ■ ■
;-> row (0..1): 1
;-> col (0..1): 1
;-> Risolto in 4 mosse.
;-> ∙ ∙
;-> ∙ ∙
;-> game-over

=============================================================================


