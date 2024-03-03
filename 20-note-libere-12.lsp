================

 NOTE LIBERE 12

================

  "LISP (newLISP) is like zen buddhism: 
   if it doesn't solve your problems, you are not using enough of it."

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

Once upon a time, during a large and international conference of the world's leading philosophers, an Angel miraculously appeared and said:
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

Scrivere due funzioni per calcolare il valore minimo e il valore massimo tra due frazioni.

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

Vedi anche "Perchè (sqrt x) restituisce solo la radice positiva?" in "Note libere 19".


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


------------------
La funzione "bind"
------------------

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
Comunque questa strategia porta il gatto a catturare sempre il topo (perchè la griglia ha dimensioni finite).


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

John McCarthy wrote in the LISP 1.5 programmer's manual that LISP differs from most programming languages in three ways:

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


---------------------
La funzione "for-all"
---------------------

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


--------------------
La funzione "random"
--------------------

Vediamo la definizione dal manuale:

*******************
>>>funzione RANDOM
*******************
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
Il programma funziona solo per matrici di dimensione NxN (con 2 <= N <=9 ).

Prima vediamo alcuni risultati matematici sul gioco:
1) Alcune configurazioni iniziali non hanno soluzione.
2) In alcuni casi sono possibili soluzioni multiple.
3) Passare da tutte le luci accese a tutte le luci spente è sempre possibile per matrici quadrate di qualsiasi dimensione (Sutner 1989).

Inoltre osserviamo che:
a) commutare due volte una luce equivale a non fare nulla,
b) commutare la luce A e poi luce B ha lo stesso effetto di commutare B e poi commutare A.
Di conseguenza, l'ordine in cui premiamo i pulsanti è irrilevante.

Caratteri grafici usati:
; on
(print "■ ")
; off
(print "· ")
;(print "∙ ")

; on
(print "* ")
; off
(print "· ")

Funzione che stampa la griglia di gioco:

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (cond ((= (grid i j) 1) (print "■ ")) ; on
              ((= (grid i j) 0) (print "· ")) ; off
              ;((= (grid i j) 0) (print "∙ ")) ; off
              (true (println "ERROR"))
        )
      )
      (println))))

(setq test (array 3 3 (rand 2 9)))
;-> ((0 1 0) (1 1 0) (0 1 1))
(print-grid test)
;-> · ■ ·
;-> ■ ■ ·
;-> · ■ ■

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

Funzione che crea una griglia di gioco casuale:

(define (make-grid size)
  (local (board rr cc celle)
  ; partiamo da una configurazione di luci tutte accese (tutti 1)
  ; poichè questa configurazione è sicuramente risolvibile
  (setq board (array size size '(1)))
  ; eseguiamo 1000 mosse casuali sulla griglia di tutti 1
  (for (i 1 1000)
    (setq rr (rand size))
    (setq cc (rand size))
    ; calcola le celle vicine alla cella (rr cc)
    (setq celle (vicini rr cc size size))
    ; aggiorna la cella corrente
    (setf (board rr cc) (- 1 (board rr cc)))
    ; aggiorna le celle vicine
    (dolist (c celle)
      (setf (board (c 0) (c 1)) (- 1 (board (c 0) (c 1))))
    )
  )
  board))

(make-grid 4)
;-> ((0 0 0 1) (0 0 0 0) (0 1 0 0) (0 0 0 0))

Funzione che verifica se il gioco è finito (tutte le luci spente = tutti i valori uguali a 0):

(define (endgame? grid) (for-all (fn(x) (= x 0)) (flat (array-list grid))))

Funzione che gestisce l'input utente di una cifra intera (0..9):

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

(read-int "Intero (1 5): " 1 5)
;-> Intero (1 5): 2

Funzione che gestisce il gioco:

(define (lights-out size)
  (local (board mosse rr cc celle)
    ; crea griglia di gioco casuale
    (setq board (make-grid size))
    ; Il seguente metodo può creare griglie non risolvibili
    ; quindi non è utilizzabile
    ;(setq board (array size size (rand 2 (* size size))))
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
;-> · ·
;-> row (0..1): 0
;-> col (0..1): 0
;-> · ·
;-> ■ ·
;-> row (0..1): 1
;-> col (0..1): 0
;-> ■ ·
;-> · ■
;-> row (0..1): 0
;-> col (0..1): 0
;-> · ■
;-> ■ ■
;-> row (0..1): 1
;-> col (0..1): 1
;-> Risolto in 4 mosse.
;-> · ·
;-> · ·
;-> game-over

Scriviamo una funzione che prova a risolvere il gioco in modo casuale (cioè premendo i pulsanti a caso).

(define (solve-rnd size)
  (local (board mosse rr cc celle)
    ; crea griglia di gioco casuale
    (setq board (make-grid size))
    ; stampa la griglia iniziale
    (print-grid board)
    (setq mosse 0)
    ; ciclo del gioco
    (until (endgame? board)
      ; mossa casuale
      (setq rr (rand size))
      (setq cc (rand size))
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
    ; stampa la griglia finale
    ;(print-grid board)
  ) 'solved
)

Proviamo con una matrice 2x2:

(solve-rnd 2)
;-> · ·
;-> ■ ·
;-> Risolto in 5 mosse.

(solve-rnd 2)
;-> · ■
;-> ■ ·
;-> Risolto in 38 mosse.

(solve-rnd 2)
;-> · ■
;-> ■ ■
;-> Risolto in 61 mosse.

Proviamo con una matrice 3x3:

(solve-rnd 3)
;-> · ■ ■
;-> ■ ■ ·
;-> ■ · ·
;-> Risolto in 422 mosse.

(solve-rnd 3)
;-> · ■ ·
;-> ■ ■ ·
;-> ■ · ·
;-> Risolto in 2033 mosse.

Proviamo con una matrice 4x4:

(solve-rnd 4)
;-> · ■ ■ ■
;-> ■ · ■ ·
;-> ■ · ■ ·
;-> · · · ■
;-> Risolto in 720 mosse.

(solve-rnd 4)
;-> · · ■ ■
;-> · ■ ■ ■
;-> · ■ · ·
;-> · ■ ■ ■
;-> Risolto in 4306 mosse.

(solve-rnd 4)
;-> · · ■ ■
;-> · · ■ ■
;-> ■ · ■ ■
;-> · · · ·
;-> Risolto in 94 mosse.

Proviamo con una matrice 5x5:

(solve-rnd 5)
;-> ■ · · ■ ·
;-> · · · ■ ■
;-> ■ ■ · · ·
;-> ■ ■ ■ ■ ■
;-> · · ■ · ·
;-> Risolto in 62934 mosse.

(solve-rnd 5)
;-> · ■ · ■ ·
;-> ■ · ■ · ■
;-> ■ ■ · · ■
;-> ■ · ■ ■ ·
;-> · · ■ ■ ·
;-> Risolto in 107798 mosse.

(solve-rnd 5)
;-> · ■ ■ ■ ■
;-> ■ ■ · · ·
;-> ■ · ■ ■ ■
;-> · · ■ ■ ·
;-> ■ · ■ ■ ·
;-> Risolto in 402828 mosse.

(solve-rnd 5)
;-> · ■ · · ■
;-> ■ ■ · · ·
;-> ■ ■ ■ · ■
;-> · · ■ ■ ■
;-> · · ■ · ■
;-> Risolto in 9721170 mosse.

Con una matrice 5x5 ci mette alcuni secondi per trovare la soluzione (che sicuramente non è quella ottimale).

Esiste un algoritmo per risolvere questo gioco chiamato "Light Chasing".

Descriviamo l'algoritmo per una matrice 5x5.
Per iniziare, spegnere tutte le luci nella riga superiore, premendo i pulsanti della seconda riga che si trovano direttamente sotto qualsiasi pulsante acceso nella riga superiore. La riga superiore avrà quindi tutte le luci spente.
Ripetere questo passaggio per la seconda, terza e quarta riga. (cioè spegnere le luci fino alla riga inferiore).
Questo potrebbe aver già risolto il puzzle, ma è più probabile che siano rimaste accese alcune luci nella riga inferiore.
Se è così, ci sono solo 7 configurazioni possibili.
A seconda della configurazione ottenuta, occorre premere alcuni pulsanti nella riga superiore, come mostrato dalla seguente tabella:

  Luci accese sulla riga inferiore    Luci da premere sulla riga superiore
  1 0 0 0 1                           1 1 0 0 0
  0 1 0 1 0                           1 0 0 1 0
  1 1 1 0 0                           0 1 0 0 0
  0 0 1 1 1                           0 0 0 1 0
  1 0 1 1 0                           0 0 0 0 1
  0 1 1 0 1                           1 0 0 0 0
  1 1 0 1 1                           0 0 1 0 0

Dopo aver premuto i pulsanti nella riga superiore, ora applicare nuovamente l'algoritmo "Light Chasing" (cioè spegnere le luci riga per riga).
Questa volta il puzzle sarà sicuramente risolto quando raggiungeremo la riga inferiore.
Nota: questo algoritmo non genera la soluzione ottimale (quella con il minor numero di mosse).

Vediamo un esempio di applicazione dell'algoritmo:

(lights-out 4)
;-> · ■ · ·
;-> · ■ · ■
;-> · · · ·
;-> ■ · · ■
;-> row (0..3): 1
;-> col (0..3): 1
;-> · · · ·
;-> ■ · ■ ■
;-> · ■ · ·
;-> ■ · · ■
;-> row (0..3): 2
;-> col (0..3): 0
;-> · · · ·
;-> · · ■ ■
;-> ■ · · ·
;-> · · · ■
;-> row (0..3): 2
;-> col (0..3): 2
;-> · · · ·
;-> · · · ■
;-> ■ ■ ■ ■
;-> · · ■ ■
;-> row (0..3): 2
;-> col (0..3): 3
;-> · · · ·
;-> · · · ·
;-> ■ ■ · ·
;-> · · ■ ·
;-> row (0..3): 3
;-> col (0..3): 0
;-> · · · ·
;-> · · · ·
;-> · ■ · ·
;-> ■ ■ ■ ·
;-> row (0..3): 3
;-> col (0..3): 1
;-> Risolto in 6 mosse.
;-> · · · ·
;-> · · · ·
;-> · · · ·
;-> · · · ·
;-> game-over

Nel caso di una matrice 5x5 possiamo verificare se una data posizione è risolvibile usando il seguente algoritmo:

https://www.jaapsch.net/puzzles/lights.htm

Le posizioni seguenti sono chiamate "quiet patterns" (modelli di pulsanti che, se premuti, lasceranno le luci invariate):

  Posizione A        Posizione B
  1 0 1 0 1          1 1 0 1 1
  1 0 1 0 1          0 0 0 0 0
  0 0 0 0 0          1 1 0 1 1
  1 0 1 0 1          0 0 0 0 0
  1 0 1 0 1          1 1 0 1 1

Osserva la posizione A e considera le luci segnate (1). Qualsiasi delle 25 pressioni del pulsante cambierà un numero pari delle luci contrassegnate.
Pertanto, gli unici schemi risolvibili hanno un numero pari di luci contrassegnate accese.
Lo stesso vale per la posizione B.
Se nella nostra posizione entrambi questi gruppi di luci segnate hanno un numero pari di luci accese, allora la posizione è risolvibile.


-------
Risiko!
-------

Dal Regolamento del Risiko!:
l'attaccante comunica ad alta voce il nome del territorio attaccato e quello da cui parte l'attacco.
Se omette di fare questo annuncio prima di aver lanciato i dadi, il difensore può chiedere la ripetizione del lancio.
L'attaccante tira tanti dadi quante sono le armate con cui ha deciso di attaccare (massimo 3).
Esempio: un attaccante possiede 10 armate su un territorio e attacca con 3 armate, lanciando 3 dadi, ma se lo avesse desiderato, avrebbe potuto anche attaccare solo con una o due, lanciando un corrispondente numero di dadi.
Il difensore, a sua volta, può lanciare un massimo di 3 dadi, anche se possiede più di 3 armate in difesa del territorio attaccato. Il difensore deve tuttavia dichiarare con quante armate intende combattere prima che l'attaccante abbia lanciato i dadi.
Quando i due giocatori hanno lanciato i dadi, si confrontano i punteggi ottenuti in base al seguente criterio:
a) Il dado con il punteggio più alto ottenuto dall'attaccante si confronta con il punteggio più alto del difensore: se è maggiore il punteggio dell'attaccante, il difensore dovrà togliere dal territorio attaccato una delle sue armate (riponendola fra quelle in dotazione). In caso contrario, sarà l'attaccante a dover ritirare una delle sue armate dal territorio dal quale ha sferrato l'attacco.
b) In caso di pareggio vince sempre il difensore.
c) Se entrambi hanno lanciato più di un dado si confronta il secondo punteggio più alto dell'attaccante con il secondo punteggio più alto del difensore seguendo la stessa procedura.
d) Se entrambi hanno lanciato 3 dadi, si confronta anche il terzo punteggio più alto dell'attaccante con il terzo punteggio più alto del difensore seguendo la stessa procedura.
I punteggi non si sommano mai, si confrontano in ordine di grandezza.

Vediamo alcune funzioni di simulazione.

Funzione che simula un singolo scontro tra N attaccanti (1..3) contro M difensori (1..3).
Il risultato è una lista con due numeri, le armate perse dell'attaccante e le armate perse dal difensore:

(define (boom attacker defender)
  (local (res lstA lstD)
    (setq res '(0 0))
    (setq lstA (sort (rand 6 attacker) >))
    (setq lstD (sort (rand 6 defender) >))
    (if (>= attacker defender)
      (dolist (d lstD)
        (if (>= d (lstA $idx))
            (-- (res 0))
            (-- (res 1))
        )
      )
      ;else (< attacker defender)
      (dolist (a lstA)
        (if (> a (lstD $idx))
            (-- (res 1))
            (-- (res 0))
        )
      )
    )
    ;(println lstA { } lstD)
    res))

Facciamo alcune prove:

(boom 3 3)
;-> (-3 0)
(boom 3 2)
;-> (0 -2)
(boom 3 1)
;-> (0 -1)

(boom 2 3)
;-> (-2 0)
(boom 1 3)
;-> (0 -1)

Adesso scriviamo una funzione che calcola le probabilità di tutte le possibili situazioni tra attacco e difesa.

(define (risiko iter)
  (local (out modi a d tmp)
    (setq out '())
    (setq modi '((3 3) (3 2) (3 1) (2 3) (2 2) (2 1) (1 3) (1 2) (1 1)))
    (dolist (m modi)
      (setq a (m 0))
      (setq d (m 1))
      (setq tmp '(0 0))
      (for (i 1 iter)
        (setq tmp (map + tmp (boom a d)))
      )
      (println "attackers: " a ", defenders: " d)
      (println tmp { } (list (div (tmp 0) iter) (div (tmp 1) iter)))
      (println "(dead attackers)/(dead defender) = "
        (round (div (div (tmp 0) iter) (div (tmp 1) iter)) -2))
      (println "---------------------------------------")
    )
  )
)

Calcoliamo le probabilità simulate:

(risiko 1e6)
;-> attackers: 3, defenders: 3
;-> (-1892259 -1107741) (-1.892259 -1.107741)
;-> (dead attackers)/(dead defender) = 1.71
;-> ---------------------------------------
;-> attackers: 3, defenders: 2
;-> (-920313 -1079687) (-0.9203130000000001 -1.079687)
;-> (dead attackers)/(dead defender) = 0.85
;-> ---------------------------------------
;-> attackers: 3, defenders: 1
;-> (-340694 -659306) (-0.340694 -0.659306)
;-> (dead attackers)/(dead defender) = 0.52
;-> ---------------------------------------
;-> attackers: 2, defenders: 3
;-> (-1493481 -506519) (-1.493481 -0.5065190000000001)
;-> (dead attackers)/(dead defender) = 2.95
;-> ---------------------------------------
;-> attackers: 2, defenders: 2
;-> (-1219808 -780192) (-1.219808 -0.780192)
;-> (dead attackers)/(dead defender) = 1.56
;-> ---------------------------------------
;-> attackers: 2, defenders: 1
;-> (-421330 -578670) (-0.42133 -0.57867)
;-> (dead attackers)/(dead defender) = 0.73
;-> ---------------------------------------
;-> attackers: 1, defenders: 3
;-> (-826799 -173201) (-0.826799 -0.173201)
;-> (dead attackers)/(dead defender) = 4.77
;-> ---------------------------------------
;-> attackers: 1, defenders: 2
;-> (-744480 -255520) (-0.74448 -0.25552)
;-> (dead attackers)/(dead defender) = 2.91
;-> ---------------------------------------
;-> attackers: 1, defenders: 1
;-> (-582816 -417184) (-0.582816 -0.417184)
;-> (dead attackers)/(dead defender) = 1.4
;-> ---------------------------------------

Cosa significa?
  attackers: 3, defenders: 3
  (-1892259 -1107741) (-1.892259 -1.107741)
  (dead attackers)/(dead defender) = 1.71
Per distruggere una armata del difensore, occorrono 1.71 armate dell'attaccante.

Adesso scriviamo una funzione che effettua uno scontro completo tra attaccante e difensore, cioè calcola il risultato finale dello scontro. Restituisce 1 se vince l'attaccante, 0 se vince il difensore.

(define (boom-boom attacker defender)
  (local (res lstA lstD end out)
    (setq out nil)
    (setq end nil)
    (until end
      (setq res (boom attacker defender))
      (setq attacker (+ attacker (res 0)))
      (setq defender (+ defender (res 1)))
      ;(println attacker { } defender)
      ;(read-line)
      ; vince il difensore
      (if (<= attacker 0) (set 'out 0 'end true))
      ; vince l'attaccante
      (if (<= defender 0) (set 'out 1 'end true))
    )
    out))

Facciamo alcune prove:

(boom-boom 3 3)
;-> 0
(boom-boom 3 1)
;-> 1

Calcoliamo le probabilitá di vittoria nel caso in cui le armate non siano piú di 3 per ogni giocatore.

(define (risiko2 iter)
  (local (modi a d tmp awin dwin)
    (setq modi '((3 3) (3 2) (3 1) (2 3) (2 2) (2 1) (1 3) (1 2) (1 1)))
    (dolist (m modi)
      (setq a (m 0))
      (setq d (m 1))
      (setq tmp nil)
      (setq awin 0)
      (setq dwin 0)
      (for (i 1 iter)
        (setq tmp (boom-boom a d))
        (if (= tmp 0)
            (++ dwin)
            (++ awin)
        )
      )
      (println "attackers: " a ", defenders: " d)
      (println "wins attackers: " awin ", wins defenders: " dwin)
      (println "attackers: " (round (div awin iter) -4) ", defenders: " (round (div dwin iter) -4))
      (println "(wins attackers)/(wins defender) = " (round (div awin dwin) -2))
      (println "----------------------------------------------")
    )
  )
)

(risiko2 1e6)
;-> attackers: 3, defenders: 3
;-> wins attackers: 327397, wins defenders: 672603
;-> attackers: 0.3274, defenders: 0.6726
;-> (wins attackers)/(wins defender) = 0.49
;-> ---------------------------------------------
;-> attackers: 3, defenders: 2
;-> wins attackers: 656134, wins defenders: 343866
;-> attackers: 0.6561, defenders: 0.3439
;-> (wins attackers)/(wins defender) = 1.91
;-> ---------------------------------------------
;-> attackers: 3, defenders: 1
;-> wins attackers: 916431, wins defenders: 83569
;-> attackers: 0.9164, defenders: 0.08359999999999999
;-> (wins attackers)/(wins defender) = 10.97
;-> ---------------------------------------------
;-> attackers: 2, defenders: 3
;-> wins attackers: 121546, wins defenders: 878454
;-> attackers: 0.1215, defenders: 0.8785
;-> (wins attackers)/(wins defender) = 0.14
;-> ---------------------------------------------
;-> attackers: 2, defenders: 2
;-> wins attackers: 361899, wins defenders: 638101
;-> attackers: 0.3619, defenders: 0.6381
;-> (wins attackers)/(wins defender) = 0.57
;-> ---------------------------------------------
;-> attackers: 2, defenders: 1
;-> wins attackers: 754007, wins defenders: 245993
;-> attackers: 0.754, defenders: 0.246
;-> (wins attackers)/(wins defender) = 3.07
;-> ---------------------------------------------
;-> attackers: 1, defenders: 3
;-> wins attackers: 18080, wins defenders: 981920
;-> attackers: 0.0181, defenders: 0.9819
;-> (wins attackers)/(wins defender) = 0.02
;-> ---------------------------------------------
;-> attackers: 1, defenders: 2
;-> wins attackers: 105658, wins defenders: 894342
;-> attackers: 0.1057, defenders: 0.8943
;-> (wins attackers)/(wins defender) = 0.12
;-> ---------------------------------------------
;-> attackers: 1, defenders: 1
;-> wins attackers: 416637, wins defenders: 583363
;-> attackers: 0.4166, defenders: 0.5834
;-> (wins attackers)/(wins defender) = 0.71
;-> ---------------------------------------------


I valori esatti delle percentuali di vittoria dell'attaccante ottenuti con il calcolo delle probabilità sono i seguenti (tra parentesi i risultati della simulazione):

https://amslaurea.unibo.it/11436/1/MangiantiMarco.pdf

  1 contro 1 = 41.7%   (41.66%)
  2 contro 1 = 57.9% + 42.1% * 41.7% = 75.46%   (75.4%)
  3 contro 1 = 66% + 34% * 75.46% = 91.67%   (91.64%)
  1 contro 2 = 25.5% * 41.7% = 10.63%   (10.57%)
  2 contro 2 = 22.8% + 32.4% * 41.7% = 36.31%   (36.19%)
  3 contro 2 = 37.2% + 33.6% * 75.46% + 29.3% * 10.63% = 65.67%   (65.61%)
  1 contro 3 = 17.4% * 10.63% = 1.85%   (1.81%)
  2 contro 3 = 12.6% * 75.46% + 25.5% * 10.63% = 12.22%   (12.15%)
  3 contro 3 = 13.8% + 21.5% * 75.46% + 26.5% * 10.64% = 32.84%   (32.74%)

I risultati della funzione di simulazione sono congruenti con quelli matematici.

Per finire una funzione che simula uno scontro di N attaccanti e M difensori per un determinato numero di volte.
Restituisce la percentuale di vittoria dell'attaccante e del difensore.

(define (boom-boom2 attacker defender)
  (local (res lstA lstD end)
    (setq end nil)
    (until end
      (setq res (boom attacker defender))
      (setq attacker (+ attacker (res 0)))
      (setq defender (+ defender (res 1)))
      ;(println attacker { } defender)
      ;(read-line)
      ; vince il difensore
      (if (<= attacker 0) (setq end true))
      ; vince l'attaccante
      (if (<= defender 0) (setq end true))
    )
    (list attacker defender)))

(boom-boom2 3 1)
;-> (3 0)
(boom-boom2 3 1)
;-> (0 1)

(define (risiko3 attacker defender iter)
  (local (out a d end tmp att def awin dwin)
    (setq out nil)
    (setq awin 0)
    (setq dwin 0)
    (for (i 1 iter)
      (setq end nil)
      (setq att attacker)
      (setq def defender)
      ;(println "new: " attacker { } defender)
      (until end
        ; attacco e difesa sempre al massimo delle possibilità
        (if (>= att 3) (setq a 3) (setq a att))
        (if (>= def 3) (setq d 3) (setq d def))
        (setq tmp (boom-boom2 a d))
        (setq att (- att (- a (tmp 0))))
        (setq def (- def (- d (tmp 1))))
        (if (<= att 0) (setq end true))
        (if (<= def 0) (setq end true))
        ;(println tmp { } att { } def)
        ;(read-line)
      )
      ; aggiorna numero vittorie
      ; (due if per controllo errori...)
      (if (<= att 0) (++ dwin))
      (if (<= def 0) (++ awin))
    )
    (println "win attackers: " (round (mul (div awin iter) 100) -4))
    (println "win defenders: " (round (mul (div dwin iter) 100) -4))
  )
)

Per controllare la correttezza di questa funzione verifichiamo alcuni valori che conosciamo:

(risiko3 3 3 1e6)
;-> win attackers: 32.8267
;-> win defenders: 67.1733
(risiko3 1 3 1e6)
;-> win attackers: 1.8598
;-> win defenders: 98.14019999999999
(risiko3 2 2 1e6)
;-> win attackers: 36.2132
;-> win defenders: 63.7868

I risultati sono congruenti con quelli precedenti.

Vediamo qualche altro esempio:

(risiko3 6 3 1e6)
;-> win attackers: 66.6077
;-> win defenders: 33.3923

(risiko3 10 6 1e6)
;-> win attackers: 55.0539
;-> win defenders: 44.9461

(risiko3 8 3 1e6)
;-> win attackers: 77.9385
;-> win defenders: 22.0615


----------
Open doors
----------

Abbiamo un lungo corridoio con N porte su un lato. Tutte le porte sono inizialmente chiuse.
Ci muoviamo avanti e indietro nel corridoio cambiando lo stato delle porte come segue:
1) Apriamo una porta che è chiusa e chiudiamo una porta che è aperta.
2) Iniziamo da un'estremità e continuiamo a modificare lo stato delle porte fino a raggiungere l'altra estremità, quindi torniamo indietro e iniziamo ad alterare di nuovo lo stato delle porte.
3) Al primo passaggio si alterano gli stati delle porte numerate 1, 2, 3, ..., N.
4) Al secondo passaggio, si modificano gli stati delle porte numerate 2, 4, 6, ....
5) Al terzo giro si alterano gli stati delle porte numerate 3, 6, 9, ...
6) e così via...
7) La procedura di cui sopra continuerà fino all'ennesimo turno in cui si modifica lo stato della porta numero N.

Trovare il numero di porte aperte alla fine della procedura.

(define (doors num show)
  (local (porte turn base)
    (setq porte (array num '(0)))
    (setq turn 1)
    (setq base 0)
    (while (<= turn num)
      (if show (println "turno: " turn))
      (for (i base (- num 1) turn)
        (setf (porte i) (- 1 (porte i)))
      )
      (if show (begin (print "porte: " porte) (read-line)))
      (++ turn)
      (++ base)
    )
    (first (count '(1) (array-list porte)))))

Vediamo come agisce la procedura:

(doors 10 true)
;-> turno: 1
;-> porte: (1 1 1 1 1 1 1 1 1 1)
;-> turno: 2
;-> porte: (0 1 0 1 0 1 0 1 0 1)
;-> turno: 3
;-> porte: (1 1 0 0 0 1 1 1 0 0)
;-> turno: 4
;-> porte: (0 1 0 0 1 1 1 1 1 0)
;-> turno: 5
;-> porte: (1 1 0 0 1 0 1 1 1 0)
;-> turno: 6
;-> porte: (0 1 0 0 1 0 0 1 1 0)
;-> turno: 7
;-> porte: (1 1 0 0 1 0 0 0 1 0)
;-> turno: 8
;-> porte: (0 1 0 0 1 0 0 0 0 0)
;-> turno: 9
;-> porte: (1 1 0 0 1 0 0 0 0 1)
;-> turno: 10
;-> porte: (0 1 0 0 1 0 0 0 0 1)
;-> 3

(doors 372)
;-> 19
(doors 400)
;-> 20
(doors 100)
;-> 10
(doors 120)
;-> 10
(doors 121)
;-> 11
(doors 825625)
;-> 908

Per vedere se esiste qualche pattern, possiamo scrivere:

(map (fn(x) (list x (doors x))) (sequence 1 30))
;-> ((1 1) (2 1) (3 1)
;->  (4 2) (5 2) (6 2) (7 2) (8 2)
;->  (9 3) (10 3) (11 3) (12 3) (13 3) (14 3) (15 3)
;->  (16 4) (17 4) (18 4) (19 4) (20 4) (21 4) (22 4) (23 4) (24 4)
;->  (25 5) (26 5) (27 5) (28 5) (29 5) (30 5))

Sembra che la funzione restituisca floor(sqrt(num)).
Per verificare la nostra ipotesi scriviamo una nuova funzione:

(define (doors2 num) (floor (sqrt num)))

Facciamo alcune prove:

(doors2 372)
;-> 19
(doors2 400)
;-> 20
(doors2 100)
;-> 10
(doors2 120)
;-> 10
(doors2 121)
;-> 11
(doors2 825625)
;-> 908

Verifichiamo la nostra ipotesi fino a 1000:

(= (map doors (sequence 1 1e3))
   (map doors2 (sequence 1 1e3)))
;-> true


---------------------------
Divisibilità dei fattoriali
---------------------------

Dato un numero N, determinare se il suo fattoriale N! è divisibile dalla somma dei primi N numeri.

Soluzione ingenua

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione che calcola la somma dei numeri 1..n:

(define (somma n) (/ (* n (+ n 1)) 2))

(somma 10)
;-> 55

(define (divisibile n)
  (zero? (% (fact-i n) (somma n))))

(divisibile 3)
;-> true

(divisibile 4)
;-> nil

Soluzione matematica

La somma dei primi n numeri vale:

  s = n*(n+1)/2

Ora il termine n*(n+1) può essere scritto come:

  n*(n+1) = (n+1)!/(n-1)!

Quindi la somma diventa:

  s = (n+1)!/2*(n-1)!

Il rapporto da calcolare n!/s vale:

    n!     2*(n - 1)!
  ----- = ------------
    s       (n + 1)

Da questa formula possiamo osservare che:

- se (n + 1) è un numero primo, allora n! non è divisibile per s
- se (n + 1) non è un numero primo, allora n! è divisibile per s

Nota: il numero 1! è divisibile per 1 e va trattato a parte.

La nuova funzione è la seguente:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (divisible n)
  (cond ((= n 1) true)
        ((prime? (+ n 1)) nil)
        (true true)))

(divisible 3)
;-> true

(divisible 4)
;-> nil

Verifichiamo se le due funzioni producono risultati uguali fino a 1000:

(= (map divisibile (sequence 1 1000))
   (map divisible (sequence 1 1000)))
;-> true


---------------------
Paradossi delle buste
---------------------

Esistono diversi paradossi logici che trattano due buste.

https://it.wikipedia.org/wiki/Paradosso_delle_due_buste

Il mio approccio è quello di simulare i vari processi.

Due buste: X e 2X
-----------------
Due buste uguali, una contiene X euro e l'altra contiene 2X euro.
Apriamo una busta e vediamo il numero di euro.
Conviene cambiare la busta con l'altra oppure tenerla?

(define (buste-x2x max-value iter)
  (local (win lose x)
    (setq win 0)
    (setq lose 0)
    (for (i 1 iter)
      ; primo numero (x)
      (setq x (+ 1 (rand max-value)))
      ; secondo numero (2*x oppure x/2)
      (setq y (if (zero? (rand 2)) (* x 2) (/ x 2)))
      ; scambio sempre...
      ; quindi se risulta x > y, allora ho perso
      (if (> x y)
        (++ lose)
        (++ win)
      )
    )
    (println "win: " win " (" (round (div win iter) -2) "%)")
    (println "lose: " lose " (" (round (div lose iter) -2) "%)")))

(buste-x2x 100 1e5)
;-> win: 50005 (0.5%)
;-> lose: 49995 (0.5%)

(buste-x2x 1000 1e5)
;-> win: 49943 (0.5%)
;-> lose: 50057 (0.5%)

Senza altre informazioni la scelta non cambia il risultato, ho sempre il 50% di probabilità di scegliere la busta X e il 50% di scegliere la busta 2X.

Due buste: x e y
----------------
Primo caso: conosciamo il valore minimo e massimo che può contenere una busta.

In questo caso una strategia ovvia è quella di utilizzare come soglia il valore (massimo - minimo)/2.
Se il valore della busta che apriamo è inferiore alla soglia, allora scambiamo le buste.
Se il valore della busta che apriamo è superiore alla soglia, allora non scambiamo le buste.

La seguente funzione simula un evento con questa strategia
(valore minimo = 1, valore massimo = num):

(define (buste1 num)
  (local (out cambio x y z)
    (setq out -1)
    (setq cambio nil)
    ; il nostro numero (che conosciamo)
    (setq x (+ (rand num) 1))
    ; l'altro numero (che non conosciamo)
    (setq y (+ (rand num) 1))
    ; se il nostro numero è meno della metà del valore massimo
    ; allora facciamo lo scambio tra x e y
    (if (< x (/ num 2)) (setq cambio true))
    ; Verifichiamo i possibili risultati:
    ; 1. scambio e l'altro numero è maggiore
    (if (and cambio (>= y x))
        (setq out true)
    )
    ; 2. scambio e l'altro numero è minore
    (if (and cambio (< y x))
        (setq out nil)
    )
    ; 3. nessuno scambio e l'altro numero è maggiore
    (if (and (not cambio) (>= y x))
        (setq out nil)
    )
    ; 4. nessuno scambio e l'altro numero è minore
    (if (and (not cambio) (< y x))
        (setq out true)
    )
    out))

(buste1 100)
;-> nil
(buste1 100)
;-> true

Funzione di simulazione che esegue un evento un determinato numero di volte:

(define (simula-buste func max-value iter)
  (local (win lose)
    (setq win 0)
    (setq lose 0)
    (for (i 1 iter)
      (if (func max-value)
        (++ win)
        (++ lose)
      )
    )
    (println "win: " win " (" (round (div win iter) -2) "%)")
    (println "lose: " lose " (" (round (div lose iter) -2) "%)")))

Calcoliamo le percentuali di vittoria e sconfitta della strategia:

(simula-buste buste1 100 1e5)
;-> win: 74779 (0.75%)
;-> lose: 25221 (0.25%)
(simula-buste buste1 1000 1e5)
;-> win: 75141 (0.75%)
;-> lose: 24859 (0.25%)

Secondo caso: non conosciamo l'intervallo dei valori, ma conosciamo un altro valore (z) che ha la stessa distribuzione di x e y.

In questo caso una possibile strategia è la seguente.
Poichè z proviene dallo stesso intervallo di valori di x e y, allora può essere minore o maggiore di x e y con la stessa probabilità.
Se z > x, allora supponiamo che x è minore di y e facciamo lo scambio.
Se z <= x, allora supponiamo che x è maggiore di y e non facciamo lo scambio.

Perchè?
Consideriamo due casi:
La prima busta che scegliamo contiene x (cioè la quantità minore).
La prima busta che scegliamo contiene y (questo è ciò che vogliamo).
Il caso per prima x:
se prendiamo prima x, dobbiamo cambiare la busta per avere y.
Quando succede secondo la nostra strategia?
Succede ogni volta che la nostra z campionata casualmente è maggiore di x.
Ciò significa che in questo caso vinciamo con una probabilità P(z>x).

Il primo caso per y:
se prendiamo prima y, dobbiamo attenerci alla busta.
Ciò accade ogni volta che la nostra z campionata casualmente è minore di y.
Ciò significa che in questo caso vinciamo con una probabilità P(z<y).

Poiché entrambi i casi hanno una probabilità del 50% (le buste sono state mescolate), si ottiene una probabilità di successo totale di:

  P(win) = P(win|prima x)*P(prima x) + P(win|prima y)*P(prima y) =
         = (1/2)*P(win|prima x) + P(win|prima y) =
         = (1/2)*[P(z>x) + P(z<y)] =
         = (1/2)*[1- P(z<=x) + P(z<y)] =
         = (1/2) + (1/2)*P(x<z<y)

Questa probabilità è almeno del 50%, e se P(x<z<y)>0, è ancora più grande.
Il vantaggio varia da 0% (quando z non è mai compreso tra x e y) al 50% (quando z è sempre compreso tra x e y).

La seguente funzione simula questa strategia (z viene "estratto" nello stesso modo di x e y):

(define (buste2 num)
  (local (out cambio x y z)
    (setq out -1)
    (setq cambio nil)
    ; il nostro numero (che conosciamo)
    (setq x (+ (rand num) 1))
    ; l'altro numero (che non conosciamo)
    (setq y (+ (rand num) 1))
    ; generiamo un numero casuale
    (setq z (+ (rand num) 1))
    ; se z > x, allora supponiamo che x è minore di y
    ; e quindi facciamo lo scambio tra x e y
    (if (> z x) (setq cambio true))
    ; Verifichiamo i possibili risultati:
    ; 1. scambio e l'altro numero è maggiore
    (if (and cambio (>= y x))
        (setq out true)
    )
    ; 2. scambio e l'altro numero è minore
    (if (and cambio (< y x))
        (setq out nil)
    )
    ; 3. nessuno scambio e l'altro numero è maggiore
    (if (and (not cambio) (>= y x))
        (setq out nil)
    )
    ; 4. nessuno scambio e l'altro numero è minore
    (if (and (not cambio) (< y x))
        (setq out true)
    )
    out))

(buste2 100)
;-> true
(buste2 100)
;-> nil

Calcoliamo le percentuali di vittoria e sconfitta della strategia:

(simula-buste buste2 100 1e5)
;-> win: 66718 (0.67%)
;-> lose: 33282 (0.33%)

(simula-buste buste2 1000 1e5)
;-> win: 66497 (0.66%)
;-> lose: 33503 (0.34%)


-----------------------------------
Parse numbers from a list of symbol
-----------------------------------

; by newdep
(define (numbers:numbers) (clean nil? (args)))

(numbers any number from 10 upto 100 from this line)
;-> (10 100)


------------------------------
Esempio di programmazione FOOP
------------------------------

;lambdaj/java
;Person me = new Person("Mario", "Fusco", 35);
;Person luca = new Person("Luca", "Marrocco", 29);
;Person biagio = new Person("Biagio", "Beatrice", 39);
;Person celestino = new Person("Celestino", "Bellone", 29);
;List<Person> meAndMyFriends = asList(me, luca, biagio, celestino);
;it is possible to filter the ones having more than 30 years applying the following filter:
;LList<Person> oldFriends = filter(having(on(Person.class).getAge(), greaterThan(30)), meAndMyFriends)
;int totalAge = sum(meAndMyFriends, on(Person.class).getAge());

; newlisp by Cormullion

(new Class 'Person)
(new Class 'Firstname)
(new Class 'Lastname)
(new Class 'Age)

(set 'me
  (Person
    (Firstname "Mario")
    (Lastname "Fusco")
    (Age 35)))

(set 'luca
  (Person
    (Firstname "Luca")
    (Lastname "Marrocco")
    (Age 29)))

(set 'biagio
  (Person
    (Firstname "Biagio")
    (Lastname "Beatrice")
    (Age 39)))

(set 'celestino
  (Person
    (Firstname "Celestino")
    (Lastname "Bellone")
    (Age 29)))

(set 'me-and-my-friends
  (list me luca biagio celestino))

(lookup Age luca)
;-> 29

(map (curry assoc Age) me-and-my-friends)
;-> ((Age 35) (Age 29) (Age 39) (Age 29))

(set 'oldfriends
 (filter (fn (person) (> (lookup Age person) 30)) me-and-my-friends))
;-> ((Person
;->    (Firstname "Mario")
;->    (Lastname "Fusco")
;->    (Age 35))
;->  (Person
;->    (Firstname "Biagio")
;->    (Lastname "Beatrice")
;->    (Age 39)))

(set 'total-age (apply add (map (curry lookup Age) me-and-my-friends)))
;-> 132


-------------
Peg solitaire
-------------

Peg Solitaire, è un classico puzzle di "jumping".
È costituito da una tavola con 33 fori, disposti a forma di croce:
un quadrato 3×3 con quattro rettangoli 2×3 aggiunti ai suoi lati.

casa libera = "·"
casa occupata = "■"

      ■ ■ ■
      ■ ■ ■
  ■ ■ ■ ■ ■ ■ ■
  ■ ■ ■ · ■ ■ ■
  ■ ■ ■ ■ ■ ■ ■
      ■ ■ ■
      ■ ■ ■

All'inizio, tutti i fori, tranne quello centrale contengono una pedina (in genere una pallina). Una mossa consiste nel saltare una pedina sopra un'altro per finire in una buca vuota, quindi rimuovere la pedina che è stata saltata.
Le pedine possono muoversi solo in modo orizzontale (a sinistra o a destra) e verticale (in alto o in basso).
Lo scopo del puzzle è rimuovere tutte le pedine tranne una e preferibilmente lasciare quest'ultima pedina al centro della tavola.

Simulazione del gioco
---------------------
casa libera = "·"
casa occupata = "■"

0 = casa libera
1 = casa occupata
2 = casa impossibile

(setq peg '((2 2 1 1 1 2 2)
            (2 2 1 1 1 2 2)
            (1 1 1 1 1 1 1)
            (1 1 1 0 1 1 1)
            (1 1 1 1 1 1 1)
            (2 2 1 1 1 2 2)
            (2 2 1 1 1 2 2)))

Funzione che stampa una determinata posizione del gioco:

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (println "  0 1 2 3 4 5 6")
    (for (i 0 (- row 1))
      (print i { })
      (for (j 0 (- col 1))
        (cond ((= (grid i j) 2) (print "  ")) ; invisibile
              ((= (grid i j) 1) (print "■ ")) ; occupata
              ((= (grid i j) 0) (print "· ")) ; libera
              (true (println "ERROR"))
        )
      )
      (println))))

(print-grid peg)
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ ■ ■
;-> 2 ■ ■ ■ ■ ■ ■ ■
;-> 3 ■ ■ ■ · ■ ■ ■
;-> 4 ■ ■ ■ ■ ■ ■ ■
;-> 5     ■ ■ ■
;-> 6     ■ ■ ■

Funzione che crea una lista di mosse possibili da una determinata posizione:
mosse possibili = ((r1 c1 r2 c2) ... (r1 c1 r2 c2)))

(define (possible-moves grid)
  (let ((out '()))
    (for (r 0 6)
      (for (c 0 6)
        (cond ((= (grid r c) 1)
                ; up possible?
                (if (and (>= (- r 2) 0)
                         (zero? (grid (- r 2) c))
                         (= (grid (- r 1) c) 1))
                    (push (list r c (- r 2) c) out -1)
                )
                ; down possible?
                (if (and (< (+ r 2) 7)
                         (zero? (grid (+ r 2) c))
                         (= (grid (+ r 1) c) 1))
                    (push (list r c (+ r 2) c) out -1)
                )
                ; left possible?
                (if (and (>= (- c 2) 0)
                         (zero? (grid r (- c 2)))
                         (= (grid (- c 1) r) 1))
                    (push (list r c r (- c 2)) out -1)
                )
                ; right possible?
                (if (and (< (+ c 2) 7)
                         (zero? (grid r (+ c 2)))
                         (= (grid (+ c 1) r) 1))
                    (push (list r c r (+ c 2)) out -1)
                ))
              (true nil)
        )
      )
    )
    out))

(possible-moves peg)
;-> ((1 3 3 3) (3 1 3 3) (3 5 3 3) (5 3 3 3))

Funzione che verifica se il gioco è terminato (ci deve essere un solo 1 nella matrice):

(define (endgame? grid)
  (= 1 (first (count '(1) (flat grid)))))

(setq test '((2 2 0 0 0 2 2)
             (2 2 0 0 0 2 2)
             (0 0 0 0 0 0 0)
             (1 0 0 0 0 0 0)
             (0 0 0 0 0 0 0)
             (2 2 0 0 0 2 2)
             (2 2 0 0 0 2 2)))

(endgame? test)
;-> true

Funzione che verifica se una mossa è legale in una determinata posizione:

(define (legal-move? move grid)
  (local (r1 c1 r2 c2 rr cc out)
    (setq out true)
    (map set '(r1 c1 r2 c2) move)
    ; la casa di partenza deve essere occupata (1)
    (if (!= (grid r1 c1) 1) (setq out nil))
    ; la casa di arrivo deve essere libera (0)
    (if (!= (grid r2 c2) 0) (setq out nil))
    ; la casa in mezzo deve essere occupata (1)
    ; (pallina da mangiare)
    (cond ((= r1 r2) ; mossa in orizzontale
            (setq cc (/ (+ c1 c2) 2))
            (if (!= (grid r1 cc) 1) (setq out nil)))
          ((= c1 c2) ; mossa in verticale
            (setq rr (/ (+ r1 r2) 2))
            (if (!= (grid rr c1) 1) (setq out nil)))
          (true (setq out nil))
    )
    out))

(for (i 0 3) (print (legal-move? ((possible-moves peg) i) peg) { }))
;-> true true true true

Funzione che effettua una mossa legale da una determinata posizione:
mossa = (r1 c1 r2 c2)

(define (make-move move grid)
  (local (r1 c1 r2 c2 rr cc)
    (map set '(r1 c1 r2 c2) move)
    ; la casa di partenza diventa libera (0)
    (setf (grid r1 c1) 0)
    ; la casa di arrivo diventa occupata (1)
    (setf (grid r2 c2) 1)
    ; la casa in mezzo diventa libera (0)
    ; (pallina mangiata)
    (cond ((= r1 r2) ; mossa in orizzontale
            (setq cc (/ (+ c1 c2) 2))
            (setf (grid r1 cc) 0))
          ((= c1 c2) ; mossa in verticale
            (setq rr (/ (+ r1 r2) 2))
            (setf (grid rr c1) 0))
          (true (println "ERROR: wrong move."))
    )
    grid))

(setq tmp peg)
(print-grid tmp)
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ ■ ■
;-> 2 ■ ■ ■ ■ ■ ■ ■
;-> 3 ■ ■ ■ · ■ ■ ■
;-> 4 ■ ■ ■ ■ ■ ■ ■
;-> 5     ■ ■ ■
;-> 6     ■ ■ ■
(setq tmp (make-move '(1 3 3 3) tmp))
(print-grid tmp)
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ · ■
;-> 2 ■ ■ ■ · ■ ■ ■
;-> 3 ■ ■ ■ ■ ■ ■ ■
;-> 4 ■ ■ ■ ■ ■ ■ ■
;-> 5     ■ ■ ■
;-> 6     ■ ■ ■
(setq tmp (make-move '(4 3 2 3) tmp))
(print-grid tmp)
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ · ■
;-> 2 ■ ■ ■ ■ ■ ■ ■
;-> 3 ■ ■ ■ · ■ ■ ■
;-> 4 ■ ■ ■ · ■ ■ ■
;-> 5     ■ ■ ■
;-> 6     ■ ■ ■

Funzione che gestisce l'input utente di una cifra intera (0..9):

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

(read-int "Intero (1 5): " 1 5)
;-> Intero (1 5): 2

Funzione che gestisce il gioco:

(define (peg-solo)
  (local (board mosse rr1 cc1 rr2 cc2)
    ; crea griglia di gioco
    (setq board '((2 2 1 1 1 2 2)
                  (2 2 1 1 1 2 2)
                  (1 1 1 1 1 1 1)
                  (1 1 1 0 1 1 1)
                  (1 1 1 1 1 1 1)
                  (2 2 1 1 1 2 2)
                  (2 2 1 1 1 2 2)))
    (setq mosse 0)
    ; ciclo del gioco
    (until (endgame? board)
      ; stampa griglia di gioco
      (print-grid board)
      ; input utente
      (setq rr1 (read-int (string "start row (0..6): ") 0 6))
      (setq cc1 (read-int (string "start col (0..6): ") 0 6))
      (setq rr2 (read-int (string "end row (0..6): ") 0 6))
      (setq cc2 (read-int (string "end col (0..6): ") 0 6))
      ;(println rr1 { } cc1 { } rr2 { } cc2)
      ; se la mossa è legale...
      (if (legal-move? (list rr1 cc1 rr2 cc2) board)
        ; allora effettua la mossa sulla griglia
        (setq board (make-move (list rr1 cc1 rr2 cc2) board))
        ; altrimenti stampa un messaggio di errore
        (println "Attenzione: mossa illegale")
      )
      (++ mosse)
    )
    ; fine del gioco
    (println "Risolto in " mosse " mosse.")
    (print-grid board)
  ) 'game-over
)

Facciamo una partita:

(peg-solo)
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ ■ ■
;-> 2 ■ ■ ■ ■ ■ ■ ■
;-> 3 ■ ■ ■ · ■ ■ ■
;-> 4 ■ ■ ■ ■ ■ ■ ■
;-> 5     ■ ■ ■
;-> 6     ■ ■ ■
;-> start row (0..6): 5
;-> start col (0..6): 3
;-> end row (0..6): 3
;-> end col (0..6): 3
;->   0 1 2 3 4 5 6
;-> 0     ■ ■ ■
;-> 1     ■ ■ ■
;-> 2 ■ ■ ■ ■ ■ ■ ■
;-> 3 ■ ■ ■ ■ ■ ■ ■
;-> 4 ■ ■ ■ · ■ ■ ■
;-> 5     ■ · ■
;-> 6     ■ ■ ■
;-> start row (0..6):
;-> ...
;-> ...
;->   0 1 2 3 4 5 6
;-> 0     · · ·
;-> 1     · · ·
;-> 2 · · · · · · ·
;-> 3 · ■ ■ · · · ·
;-> 4 · · · · · · ·
;-> 5     · · ·
;-> 6     · · ·
;-> start row (0..6): 3
;-> start col (0..6): 1
;-> end row (0..6): 3
;-> end col (0..6): 3
;-> Risolto in 31 mosse.
;->   0 1 2 3 4 5 6
;-> 0     · · ·
;-> 1     · · ·
;-> 2 · · · · · · ·
;-> 3 · · · ■ · · ·
;-> 4 · · · · · · ·
;-> 5     · · ·
;-> 6     · · ·
;-> game-over


----------------------------------
Il gatto, la tartaruga e il tavolo
----------------------------------

Un gatto è seduto sul tavolo e una tartaruga sta strisciando sul pavimento direttamente sotto di esso. La distanza dalle orecchie del gatto alla sommità del guscio della tartaruga è di 170 cm.
Eva ha scambiato i suoi animali domestici.
Ora la tartaruga è sopra il tavolo e il gatto sotto e la distanza dalle orecchie del gatto alla sommità del guscio della tartaruga è di 130 cm.
Qual è l'altezza del tavolo?

Le due situazioni sono rappresentate dal grafico seguente, in cui A è la tartaruga e B è il gatto (con molta fantasia):

                                                           +--+    +
                 +---+    +                                |B |    |
                 | A |    |                                |  |    |
  ---------+-----+---+    |                ---------+------+--+    |
           |              | 130                     |              | 170
           |              |                         |              |
           |              |                         |              |
           | x = ?        |                         | x = ?        |
           |              +--+                      |              |
           |              |B |                      |              +---+
           |              |  |                      |              | A |
           +              +--+                      +              +---+

Scriviamo le due equazioni:

1) 130 + B - A = x
2) 170 + A - B = x

Sommiamo le due equazioni:

  130 + B - A + 170 + A - B = 2x
  300 = 2x
  x = 300/2 = 150

Quindi il tavolo è alto 150 cm.


-------------------
Problema di Basilea
-------------------

Il problema di Basilea è un problema matematico, proposto da Pietro Mengoli nel 1644 e risolto dal ventottenne Eulero nel 1735, che consiste nel trovare la somma esatta della seguente serie infinita:

   ∞
   ∑ 1/n² = 1/1² + 1/2² + 1/3² + ... = π²/6
  n=1

  Sum[n=1,inf](1/n^2) - 1/1^2 + 1/2^2 + 1/3^2 + ... = π²/6

La serie è approssimativamente uguale a 1.644934...
Eulero dimostrò che la somma esatta vale π²/6.

(setq PI 3.141592653589793)
(setq basilea (div (mul PI PI) 6))
;-> 1.644934066848226

π²/6 ≈ 1.644934066848226...

(define (basil n)
  (apply add (map (fn(x) (div (mul x x))) (sequence 1 n))))

(setq values (map basil '(10 100 1000 1e4 1e5 1e6 1e7 1e8)))
;-> (1.549767731166541 1.634983900184892
;->  1.643934566681562 1.644834071848065
;->  1.644924066898242 1.644933066848770
;->  1.644933966847260 1.644934057834575)

(setq errors (map (fn(x) (sub basilea x)) values))
;-> (0.09516633568168564 0.009950166663334148
;->  0.0009995001666649461 9.999500016122376e-005
;->  9.999949984074164e-006 9.999994563525405e-007
;->  1.000009668405966e-007 9.013651380840315e-009)


--------------------------------------
Forum: In-place parameter substitution
--------------------------------------

genghis:
--------
Is it possible to create a user-defined function much like what inc does: in-place parameter substitution, or is this only available for built-in functions?

Let me clarify my question:

Is it possible to create my version of inc, my-inc?

(define (sum (x 0)) (my-inc 0 x))
(sum 1) ;=> 1
(sum 2) ;=> 3
sum ;=> (lambda ((x 0)) (my-inc 3 x))

My gut instinct tells me in order to have a self-modifying code like the above, my-inc must have a reference to the enclosing lambda list. How do I go about creating my-inc ? Is this possible?

Lutz:
-----
Any destructive primitive could be used to do this, when there is a way to reference the currently executing lambda expression:

(define (selfmod x) (setf (last selfmod) (+ (last selfmod) 1)) 0)
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 0)
(selfmod)
;-> 1
(selfmod)
;-> 2
(selfmod)
;-> 3
selfmod
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 3)

A user-defined function has no way to reference the function it was invoked from, except when it has previous knowledge of it:

(define (selfinc x) (myinc x) 0)
;-> (lambda (x) (myinc x) 0)
(define (myinc x) (inc (last selfinc) x))
;-> (lambda (x) (inc (last selfinc) x))
(selfinc 1)
;-> 1
(selfinc 2)
;-> 3
(selfinc 3)
;-> 6
selfinc
;-> (lambda (x) (myinc x) 6)

Kazimir Majorinc:
-----------------
It would be nice to have some function that returns list of the caller functions, similarly like (sys-info 3) returns the level of recursion. Although it sounds quite 'dangerous' it can actually provide some debugging facilities, i.e. functions could react if called by someone they do not appreciate.

Lutz:
-----

(define (callers)
    (catch (0) 'error)
    (slice (map sym (find-all "function (\\w+)" error $1 0)) 3)
)

(define (foo) (bar))
(define (bar) (baz))
(define (baz) (callers))

(foo) => (baz bar foo)

Instead of 3 in the last statement of 'callers' put 4 to exclude the current function.

I had this function coded natively a while back for experimentation, but couldn't really find any good use for it. Similar to 'estack', which was even shipped - undocumented - for a for a few versions and returned the variable environment stack. These functions seem interesting too me too, but I cannot see useful applications, it is just overhead nobody ever uses. When you really have a situation, where a function needs to know the caller, just make it a parameter of the function call.

Above code is not the only way to implement this. A while back Cormullion showed how you could redefine 'define' to include debugging code. In the current case, it would mean pushing the function symbol on a 'callers' stack as first statement of each function.


-------------------------------------
Forum: How to solve context collision
-------------------------------------

lotabout:
---------
I am new to newLISP, and just can't find out how to solve this problem.
As we know, we can surround a macro to avoid variable capture.
But if we write two different modules without knowing the other one, we might encounter a context collision, i.e. using the same name for context.

here is an example:

In module 'A', we define a macro 'my-set' and put it in context 'my-set'(just to illustrate).

; A.lsp
(context 'my-set)
(define-macro (my-set a b)
  (set (eval a) b))
(context MAIN)
(context 'A)
(define (my-test x)
  (letex (x x) (my-set:my-set 'y x)))
(context MAIN)

And now we write module 'B' without recognizing the existence of module 'A'.

; B.lsp
(context 'my-set)
(define-macro (my-set a b)
  (set  (eval b) a))
(context MAIN)
(context 'B)
(define (my-test x)
  (letex (x x) (my-set:my-set x 'y)))
(context MAIN)

Now we see that we have two implementations of 'my-set' macro in the same context, if we load these two files at the same time, one will break the other.
If we load 'A.lsp' first, and then 'B.lsp', then the definition of 'my-set' in B will overwrite that in 'A.lsp', so the 'my-test' function in 'A.lsp' will fail.

Cause contexts can be seen globally instead of being shadowed by the other
contexts. And we might be using different modules written by different people,
and somehow they might have context collision, and I just wondering how to deal
with this situation.

Lutz:
-----
Use only one context per module file. Different programmers maintain different contexts. The MAIN context is the only place where other contexts should be loaded and controls the main organization of the program and is maintained by a lead programmer. No context should redefine functions during runtime in contexts not maintained by the same developer.

lotabout:
---------
Using only one context per module file is a good convention. But in this case, there won't be an easy solution of solving variable capture when defining macros (in a module).
Also, that means we are not allow to use context as a 'dict' or 'hash table'
when writing modules.
How to deal with this situation?

Lutz:
-----
Hashes / dictionaries are globally accessible data (contexts), which can be changed by different other modules. By why would this be a problem, the same happens to databases or other global data intended for global use.

The thing happening in your example is not caused by variable capture or dynamic scoping, but is simply the effect of redefining the context my-set during run-time. I expanded the example with printing statements and usage of the my-test function to show the effect:

; A.lsp
(context 'my-set)
(define-macro (my-set:my-set a b)
  (set (eval a) b))
(context MAIN)
(context 'A)
(println "A before " my-set:my-set)
(define (my-test x)
  (letex (x x) (my-set:my-set 'y x)))
(my-test 123)
(println "A after " my-set:my-set)
(context MAIN)

; B.lsp
(context 'my-set)
(define-macro (my-set:my-set a b)
  (set  (eval b) a))
(context MAIN)
(context 'B)
(println "B before " my-set:my-set)
(define (my-test x)
  (letex (x x) (my-set:my-set x 'y)))
(my-test 456)
(println "B after " my-set:my-set)
(context MAIN)

and this is the output:

A before (lambda-macro (my-set:a my-set:b) (set (eval my-set:a) my-set:b))
A after (lambda-macro (my-set:a my-set:b) (set (eval my-set:a) my-set:b))
B before (lambda-macro (my-set:a my-set:b) (set (eval my-set:b) my-set:a))
B after (lambda-macro (my-set:a my-set:b) (set (eval my-set:b) my-set:a))

The only effect we can see, is caused by explicitly redefining the my-set:my-set function. The A:my-test and B:my-test functions have no effect on my-set:myset

Variable capture via macros (really fexprs) of the type as described here: http://www.newlisp.org/downloads/newlisp_manual.html#scoping
is only possible via interactions inside the same context.
That context is under the control of one developer, or better, you have all macros in their own context. Then any symbol brought into the space of the macro is foreign and cannot interact.

On a more general note:

Dynamic scoping is frequently cited as an argument against newLISP. In practice, I never have seen variable capture problems in my own code or code of others. When sticking to the "separate contexts" rule and putting macros in to their own contexts, problems cannot occur.

A few years ago I worked on a team of seven developers for over a year, all except I, using newLISP for the first time and building a multi-module distributed application for search.
Some of the programmers were experienced in programming, others new to the craft. One was an experienced CL programmer.
We never saw problems caused by dynamic scoping.
Many newLISP users don't even fully understand the whole concept and avoid free variables as a matter of good programming style.

Today, I believe that the problems with dynamic scoping are vastly exaggerated, which is sad, because people have stopped using dynamic scoping as a tool, exploiting its special characteristics, e.g.: switching and separation of concerns.

The real problems in dynamic languages are of different nature. E.g. misspelling variables, because there is no need to pre-declare them, or confusing types of different variables in duck typed functions.

lotabout:
---------
Now I have more confidence in using dynamic scope.
And understand that we can avoid variable capture by putting macros(fexprs) into a seperate context, and use it inside another context. Without interactions, no variable caputure will ever happen to macros(fexprs).

Just for discussion, consider the following situation:
Now we have this convention when writing modules (all I can think up):
1. segregate macros. => put them into a seperate context.
2. wrap all codes with a context. => i.e. the name of the module.
3. use only one context(which is specified by No.2) except those used as data containers(such as dict/hash table)

And what if two developers use the same contex name for different purpose?
Here, we use contexts as data(dict/hash table, etc.) inside another global context(to specify module name). Suppose developer A use the context 'dict' to store (word explanations) pairs, and developer B happen to use the same context for holding (word frequency) pairs. Now we have to use both modules, because these two modules will affect the other by operate on the same context 'dict', both will fail to some extent.

How to deal with this one?

I have little experience of joinning large projects, but I do believe with the
modules for newLisp increasing, there will be a name collision. Of course we
can have all contexts as data named with a prefix such as "A-dict" or something
like that, which I believe is easy and will work, besides, can we prevent this
from happenning instead of fixed it as a bug?

cormullion:
-----------
And what if two developers use the same contex name for different purpose?
How to deal with this one?
I think this issue should be considered as part of project management, not language design. If two developers working closely on the same project are not already working consistently to some agreed policies, then the project is probably going to fail anyway..

Lutz:
-----
Name clashes occur in any programming language and must be dealt with as part of development management, as Cormullion states. Name clashes occur in different programming languages at different time. They can occure in C, C++ and in Java too. In fully compiled languages, they can be catched during compile time before running.

The problem is more critical in fully dynamic languages like newLISP, where you can create and delete symbols during runtime. For normal grouping of code into context modules, the rules outlined in the previous post work, because these are created and dealt with before runtime. For hashes created and deleted at runtime do the following:

Using the uuid function you could create a dictionary at runtime and guaranteed to be unique. Fortunately contexts in newLISP can be referred to with variables, which could be local to a context. So you don't have to know the name of the dictionary context when writing your program before the context is created, and you don't have to deal with hard to remember UUID strings.

The following code shows this as an example:

(context 'A)
(set 'mydict (let (s (sym (append "dict" (uuid)) MAIN)) (new Tree s)))
(bayes-train (parse "this sentence has words and words") mydict)
(bayes-train (parse "and more words") mydict)
(println "mydict in A:" (mydict))
(context MAIN)

(context 'B)
(set 'mydict (let (s (sym (append "dict" (uuid)) MAIN)) (new Tree s)))
(mydict "foo" "hello world")
(mydict "bar" 1234567)
(println "mydict in B:" (mydict))
(println "association in B: " (mydict "foo"))
(context MAIN)
(exit)

Both contexts A and B use the same internal name mydict to refer to a dictionary context created using the sym and uuid functions. This is the output:

mydict in A:(("and" (2)) ("has" (1)) ("more" (1)) ("sentence" (1)) ("this" (1)) ("words" (3)))
mydict in B:(("bar" 1234567) ("foo" "hello world"))
association in B: hello world

In A word frequencies are counted. Note, that frequencies are in parenthesis, because you could count and compare several corpuses using bayes-query. In B general associations are made.

lotabout:
---------
This trick works!
And I think we should always use this trick when using a context as a data container inside a module.
Thanks again for being so patient. And surely I will stay with newlisp, it is just amazing.

bairui:
-------
I would love to hear more about this. I am a struggling convert to the world of functional programming and dynamic scope bewilders me. :-/

rickyboy:
---------
Hello bairui,

I'm going to try to explain how dynamic scope of variables and static (lexical) scope of variables differ. If you don't understand it after reading this, I will bet money that it is the fault of my bad explanation. :)

Free and bound variables

To answer this question, we should first look at a simple classification of variables: free variables versus bound variables. To explain what free and bound variables are, consider this code snippet which is at the top-level in newLISP.

(define x 42)  ; <-- 0
(+ x y)  ; <-- 1
(let (y 1) (+ x y))  ; <-- 2
(let (x 42 y 1) (+ x y))  ; <-- 3
(lambda (y) (+ x y))  ; <-- 4
(define (dumb-sum y) (+ x y)) ; <-- 5

Expression 1 has two variables: x and y. Both of them are free. Expression 2 has the same variables, but only x is free -- y is bound. Why? Because the let is responsible for binding y (and BTW this is why the second item of any let form is called "the let bindings").

Here's a good idea to keep in the mind in determining whether a variable is free or bound in an expression: every variable is free until it is *bound* by something -- that is, until something puts binds, or fetters, on it. That's what let did to y in Expression 2. (Bad let!) :))

[Aside: BTW, it is not conventional to say that (non-lambda) top-level defines (as in Expression 0) "bind" variables. Hence, while associating x to 42, x is not considered bound there. In short, ignore non-lambda top-level defines.]

Expression 3 has x and y both bound, i.e. they are both bound variables and no variables in that expression are free.

When you write a lambda form, the parameter list tells you which variables are going to be bound by lambda. So, Expression 4 has y as bound and x as free. Expression 5, while being a top-level define, defines a lambda, and as we said about lambdas, they bind variables. So, in Expression 5, as we saw in Expression 4, y is bound and x is free.

The following are "binders" (in maths they are called "quantifiers") of variables: let, lambda, local, etc. (I'd have to look at the manual to get an exhaustive list, but hopefully you get the idea).

Dynamic scope versus static (or lexical) scope

Now, consider the following code snippet, again at the top level.

(define x 42)

(define (f y) (let ((x 13)) (g y)))
(define (g z) (list x z))

(define (h x y) (list x y))

Notice that f calls g before it can "return" a value. It calls g with its own parameter y. Now the question is, with these definitions, what should be the value of the expression (f 3)?

Clearly, this depends on what the value of x. Why? Because x is free in g: that is, x is free in this expression: (lambda (z) (list x z)). Well then, x can take on one of two values: either 42 or 13. So, that means that the value of (f 3) is either (42 3) or (13 3). So which is it?

The answer has to do with the type of variable scoping that prevails in the language. The value of (f 3) in Scheme (which has static scope) is (42 3) but in newLISP (dynamic scope), it's (13 3). That's because Scheme only "sees" the value of x due to the top level definition, but newLISP sees the x binding up the call stack (as f calls g, there's that intervening let).

Finally, let's not forget the function h defined above. What is the value of (h 1 2)? The answer is that it is the list (1 2), both in dynamically scoped languages AND in statically scoped langauges. Why this is so easy to resolve and why this point is important, is because there are no free variables in h!

So, the question of what is the value of such-and-such in dynamic scope versus lexical scope, only depends on how the free variables are resolved (or evaluated) in the greater expression being evaluated. At the heart of the variable scoping scheme (whether it be dynamic or static) is this issue of "how the free variables are resolved." That's pretty much it.

That's why it is good programming practice to not have free variables in your expressions when you don't need them. (In order words, think about the "boundness" of your variables and don't be a lazy programmer. :)) However, there are times when you need to have a free variable in the expression on purpose, like if you want to wire in a run-time switch in your code (Lutz mentioned this earlier in this thread), but in general, when you code you should be dealing in bound variables only. This practice/discipline will really help eliminate many problems that could creep up in your code without it. (Inadvertent free variables tend to be less of a problem with lexical variable scope, however, being mindful of the "boundness" of variables should be observed as a practice with lexically scoped languages also).
I hope this helps a little.

bairui:
-------
Thanks, rickyboy! That helped a lot. Thank you!
So, now I'd like to understand what Lutz meant when he said there were good uses for dynamic scope that us lexical scopers are deprived of. Could you elaborate on: "switching and separation of concerns"?

Lutz:
-----
If you want to know it all and have time on this weekend :)

http://en.wikipedia.org/wiki/Separation_of_concerns

So basically concerns are groups of topic requirements which have to be covered by your program. The most famous tool at the moment to achieve this is Object Oriented Programming (OOP). But dynamic scoping can do it too. In Rickyboy's example, different concerns are expressed via the value of the variable x, which is 42 by default, but could be shadowed with other values, e.g. 13 in function f.

Now things get get hairy when you deal with crosscutting concerns. It's possible to solve the situation using OOP but complicated:

http://en.wikipedia.org/wiki/Cross-cutting_concern

The solution is Aspect Oriented Programming (AOP):

http://en.wikipedia.org/wiki/Aspect-oriented_programming

Here comes Pascal Costanza and proves, that AOP type of programming is really a natural thing for dynamically scoped languages! Google for 'aspect oriented programming and dynamic scoping' and you will get this Article as one of the links:

http://www.p-cos.net/documents/dynfun.pdf

There is a neat way to switch concerns using contexts in newLISP. Imagine your task is formatting documents. Your two main methods are using HTML or using Markdown (a simple markup language by John Gruber).

On a higher level, you want write only one program doing the formatting, but you want an easy way to switch between both, and perhaps you want to add LATEX later but not change your main program.

This is how to do it in newLISP contexts:

(context 'HTML)

(define (format-title text)
    (string "<h1>" text "</h2>"))

(context MAIN)

(context 'Markdown)

(define (format-title text)
    (string "===" text "==="))

(context MAIN)

(define (format-page method text)
    (method:format-title text))

(println (format-page HTML "hello world"))
(println)
(println (format-page Markdown "hello world"))

(exit)

and this would be the output:

<h1>hello world</h2>

===hello world===

So basically you are using a variable named method to hold the contexts required.

bairui:
-------
Excellent, Lutz.

Those WP articles and the PDF helped a lot. Thanks! :-)
Your example of handling separate concerns with contexts was clear. That reminds me of one of the GOF patterns... strategy? (I never got into the habit of quoting GOF patterns.)
However, your example shows... completely separate concerns rather than cross-cutting concerns. I googled for AOP in newlisp rather unsuccessfully. It seems that dragonfly has a (wrap_func) that provides an aspect of it (no pun intended).
I will have to play with this to truly understand it. But now I have the means to begin that journey. Thanks, Lutz & rickyboy. Much appreciated. :-D


------------------------------------
Creazione di una REPL personalizzata
------------------------------------

In newLISP posiamo creare facilmente una REPL  utilizzando le funzioni "readline", "read-expp" e "eval":

(define (repl)
  (while true
   (print ">> ")
   (catch (eval (read-expr (read-line))) 'result)
   (println "--> " result)
  )
)

(repl)
;-> >>
(+ 2 3)
;-> --> 5
;-> >>

Possiamo anche creare un meccanismo di valutazione personalizzato ed usarlo al posto di "eval".
La funzione "read-expr" restituisce una s-espressione non valutata della stringa restituita da "read-line". In caso di errori "result" conterrà il messaggio di errore.

(2 + 3)
;-> --> ERR: illegal parameter type : +
;-> called from user function (repl)
;-> >>


---------------
Forum: closure?
---------------

oofoe:
------
I'm working through the early examples of the "Stratified Design" paper[1] and I've run (almost immediately!) into something that doesn't seem to work.

They describe an average-damp function that given a function, returns a new function that averages the value with the result of the function:

(define (average)
   (div (apply 'add (args)) (length (args))))

(define (average-damp f)
   (fn (x)
      (average x (f x))))

You might use it like this: ((average-damp (fn (y) (+ 2 y))) 3)

And expect to get 4 (the average of 3 and the result of adding 2 to 3). However, instead I get this:

ERR: invalid function : (f x)
called from user defined function average

I assume that this is happening because the function f, that is passed to average-damp is not lexically closed in the new function that's returned, because NewLisp is not doing that sort of thing.

I have looked through the "Functions as Data" section of the Code Patterns and those examples didn't seem to help. I tried both "expand" and "letex" and they didn't seem to help.

So, is it possible to implement something like average-damp in NewLisp, and how would you do it?

rickyboy:
---------
You are correct that the reliance on lexical scope is causing the problem. In the manual, Lutz talks about what you should do in this case in the manual (letex).

In the second example a function make-adder is defined for making adder functions:

(define (make-adder n)
    (letex (c n) (lambda (x) (+ x c))))

(define add3 (make-adder 3)) → (lambda (x) (+ x 3))

(add3 10)
;-> 13

letex evaluates n to the constant 3 and replaces c with it in the lambda expression.

So your definition of average-damp in this case might be:

(define (average-damp f)
  (letex ([f] f)
    (fn (x) (average x ([f] x)))))

((average-damp (fn (y) (+ 2 y))) 3)
;-> 4

Lutz:
-----
(define (average)
    (div (apply add (args)) (length (args))))

(define (average-damp f)
    (apply average (append (map f (args)) (args))))

I assume a dampening factor has to be applied to every argument, as in the second example

(average-damp (fn (x) (+ 2 x)) 3)
;-> 4
(average-damp (fn (x) (+ 2 x)) 3 4 5 6)
;-> 5.5

Note, that the x is not a free variable in (fn (x)...) and is protected so the following won't harm:

(set 'x 3)
;-> 3
(average-damp (fn (x) (+ 2 x)) x (+ x 1) (+ x 2) (+ x 3))
;-> 5.5

also: fn is just a shorter writing for lambda

:-) I just see, rickyboy and I posted at the same time, but two different solutions

the function passed doesn't need to be anonymous:

(define (my-damp x) (+ 2 x))
;-> (lambda (x) (+ 2 x))
(average-damp my-damp 3)
;-> 4
(average-damp my-damp 3 4 5 6)
;-> 5.5


-----------------------
Forum: Why no closures?
-----------------------

Ishpeck:
--------
I'm really quite surprised that this isn't in the FAQ.
Why don't we have closures now?

(define (foo x) (lambda (y) (+ x y)))
;-> (lambda (x) (lambda (y) (+ x y)))
((foo 3) 4)
;-> ERR: value expected in function + : x

I can do this in Common Lisp:

[1]> (defun foo (x) (lambda (y) (+ x y)))
FOO
[2]> (apply (foo 3) '(5))
8

Was this part of the design philosophy or have we just not done it yet?
Ishpeck

Lutz:
-----
See here:

http://www.newlisp.org/index.cgi?Closures

TedWalther:
-----------
I'm kind of surprised that example doesn't work. I know newLISP is dynamically scoped. I assumed that would work even in a dynamically scoped LISP? Not sure how closures come into it. Perhaps I better buckle down and read through SICP.

rickyboy:
---------
No need to go to SICP. When (foo 3) gets evaluated in newLISP, the value of x is gone from the stack (it gets popped off), and without the environment carried by a closure to remember it, it gets forgotten. So then the value of (foo 3) (with the lost value of x) gets applied to the argument 4 and the evaluator complains that there is no x. We might not like this, but it does work as advertized.

For that example to work as the fellow intended, it needs to have the binding of x hang around in an environment (part of the closure) -- if only for a moment. However, in newLISP, what you want to do is just have any reference to x expanded on the fly. If this can be done, then in this case, there is no need to have environments hang around.

(define (foo* x) (letex (x x) (lambda (y) (+ x y))))
((foo* 3) 4)
;-> 7
;; Here's what's really happening with (foo* 3):
(foo* 3)
;-> (lambda (y) (+ 3 y))
;; Here is what happens with (foo 3):
(foo 3)
;-> (lambda (y) (+ x y))
;; The following works, because the value of x is still on the stack:
((lambda (x) ((lambda (y) (+ x y)) 4)) 3)
7

Of course, closures are neat for other reasons, but in this case, it is no great loss (or any loss), since all you really need to do is just "fill in" the value of x on the fly -- a way for doing that in newLISP is to expand the reference to x in that lambda expression on the fly.

TedWalther:
-----------
In some sense, a (let ...) block is a closure. I assumed that (fn ...) acted as a closure in the same way, like a let block. Thanks for the explanation, ricky.

Ishpeck:
--------
It's good to see that I'm the one who's the moron.
Thanks for the help, all.

xytroxon:
---------
Lisp(s) make all mere mortals "morons" at some point...


----------------
Spirale numerica
----------------

Una spirale numerica è una griglia infinita il cui quadrato in alto a sinistra ha il numero 1. Ecco i primi cinque strati della spirale:

   1  2  9 10 25
   4  3  8 11 24
   5  6  7 12 23
  16 15 14 13 22
  17 18 19 20 21

Determinare il numero che si trova alla riga x e colonna y.

(define (number x y)
  (local (r c tmp)
    (setq tmp nil)
    (setq r (+ x 1))
    (setq c (+ y 1))
    (setq tmp (- (max r c) 1))
    (if (odd? tmp)
        (if (< r c)
            (+ r (* tmp tmp))
            (+ (* tmp tmp) (* 2 tmp) (- c) 2)
        )
    ;else (even)
        (if (< r c)
            (+ (* tmp tmp) (* 2 tmp) (- r) 2)
            (+ c (* tmp tmp))
        )
    )
  )
)

(number 0 0)
;-> 1

(number 4 3)
;-> 20

Funzione che crea una spirale numerica di lato n:

(define (make-spiral n)
  (let ((out '()))
    (for (i 0 (- n 1))
      (for (j 0 (- n 1))
        (push (number i j) out -1)
      )
    )
    ; create matrix (list of list)
    (explode out n)))

(make-spiral 10)
;-> ((  1  2  9 10 25 26 49 50 81 82)
;->  (  4  3  8 11 24 27 48 51 80 83)
;->  (  5  6  7 12 23 28 47 52 79 84)
;->  ( 16 15 14 13 22 29 46 53 78 85)
;->  ( 17 18 19 20 21 30 45 54 77 86)
;->  ( 36 35 34 33 32 31 44 55 76 87)
;->  ( 37 38 39 40 41 42 43 56 75 88)
;->  ( 64 63 62 61 60 59 58 57 74 89)
;->  ( 65 66 67 68 69 70 71 72 73 90)
;->  (100 99 98 97 96 95 94 93 92 91))


------------------------------------------------
read-line, current-line, read-char, current-char
------------------------------------------------

La funzione "read-line" assegna a "current-line" il valore della linea corrente.
La funzione "read-char" non ha "current-char" (analogo di "current-line"), ma possiamo utilizzare la seguente espressione:

(read 0 chr 1)

Le seguenti spressioni funzionano con pipe e reindirizzamento stdin:

(while (read 0 chr 1)
    (print chr))

oppure:

(while (set 'chr (read-char 0))
    (print (char chr)))

La seguente legge caratteri UTF8:

(while (set 'chr (read-utf8 0))
    (print (char chr)))

Questa legge un file <= 1Mbyte in una volta:

(read 0 theFile 1000000)
(print theFile)

e potremmo usare:

(dolist (chr (explode theFile))
...
)

"explode" riconosce i caratteri UTF8 (con la versione UTF di newLISP).


---------------------------------------
Poligoni su reticolo di punti (lattice)
---------------------------------------

Dato un poligono, calcolare il numero di punti del reticolo all'interno del poligono e sul suo confine.
Un punto del reticolo è un punto le cui coordinate sono interi.

Il poligono è costituito da n vertici (x1,y1),(x2,y2),…,(xn,yn). I vertici (xi,yi) e (xi+1,yi+1) sono adiacenti per i=1,2,…,n−1, e anche i vertici (x1,y1) e (xn,yn) sono adiacenti.
Il poligono è semplice, cioè non si interseca.

Usiamo il teorema di Pick (vedi "Teorema di Pick" su "Problemi vari").

(define (pick poly)
  (local (area2 inside boundary x y)
    (setq inside 0)
    (setq boundary 0)
    ; il primo e l'ultimo punto del poligono devono essere uguali
    (if (!= (poly 0) (poly -1))
        (push (poly 0) poly -1)
    )
    ; extract coordinates of points (x and y)
    (setq x (map first poly))
    (setq y (map last poly))
    ; calculate area2
    (setq area2 0)
    (for (i 0 (- (length poly) 2))
      (setq area2 (+ area2 (* (y (+ i 1)) (x i))))
      (setq area2 (- area2 (* (x (+ i 1)) (y i))))
    )
    (setq area2 (abs area2))
    ; loop over polygon points
    ; to calculate boundary points...
    (for (i 0 (- (length poly) 2))
      (cond ((= (x (+ i 1)) (x i))
              (setq boundary (+ boundary (abs (- (y (+ i 1)) (y i))))))
            ((= (y (+ i 1)) (y i))
              (setq boundary (+ boundary (abs (- (x (+ i 1)) (x i))))))
            (true
              (setq boundary (+ boundary (gcd (- (x (+ i 1)) (x i))
                                              (- (y (+ i 1)) (y i))))))
      )
    )
    (setq inside (div (+ area2 2 (- boundary)) 2))
    (list (/ area2 2) inside boundary)))

(pick '((1 1) (5 3) (3 5) (1 4)))
;-> (9 6 8)

; un quadrato
(pick '((0 0) (5 0) (5 5) (0 5) (0 0)))
;-> (25 16 20)

(pick '((4 9) (8 9) (14 3) (7 3) (7 6) (4 6) (4 9)))
;-> (33 21 26)

(pick '((2 6) (4 4) (6 6) (8 4) (10 4) (10 1) (9 1) (7 3) (4 3) (2 1) (2 6)))
;-> (20 9 24)

(pick '((3 2) (6 5) (6 7) (2 5) (3 2)))
;-> (10 7 8)


------------------
Problema con i Bit
------------------

Dato un numero x calcolare:
il numero di elementi y <= x tali che x|y = x
il numero di elementi y <= x tali che x&y = x
il numero di elementi y <= x tali che x&y != 0

Soluzione in stile procedurale/iterativo:

Funzione per x|y = x:

(define (test-or x)
  (local (out val)
    (setq out '())
    (for (y 1 x)
      (setq val (| x y))
      (if (= val x)
        (push (list x y val) out -1)
      )
    )
    out))

Funzione per x&y = x:

(define (test-and x)
  (local (out val)
    (setq out '())
    (for (y 1 x)
      (setq val (& x y))
      (if (= val x)
        (push (list x y val) out -1)
      )
    )
    out))

Funzione per x|y != 0

(define (test-and-0 x)
  (local (out val)
    (setq out '())
    (for (y 1 x)
      (setq val (& x y))
      (if (!= val 0)
        (push (list x y val) out -1)
      )
    )
    out))

Funzione finale:

(define (test x values)
  (local (out1 out2 out3)
    (setq out1 (test-or x))
    (setq out2 (test-and x))
    (setq out3 (test-and-0 x))
    (if values
        (list out1 out2 out3)
        (list (length out1) (length out2) (length out3)))))

(test 10)
;-> (3 1 7)
(test 10 true)
;-> (((10 2 10) (10 8 10) (10 10 10))
;->  ((10 10 10))
;->  ((10 2 2) (10 3 2) (10 6 2) (10 7 2) (10 8 8) (10 9 8) (10 10 10)))
(test 88)
;-> (7 1 73)

Soluzione procedurale/iterativa ottimizzata:

(define (test1 x values)
  (local (out1 out2 out3)
    (set 'out1 '() 'out2 '() 'out3 '())
    (for (y 1 x)
      ; x|y = x
      (setq val (| x y))
      (if (= val x)
        (push (list x y val) out1 -1)
      )
      ; x&y = x
      (setq val (& x y))
      (if (= val x)
        (push (list x y val) out2 -1)
      )
      ; x&y != 0
      (setq val (& x y))
      (if (!= val 0)
        (push (list x y val) out3 -1)
      )
    (if values
        (list out1 out2 out3)
        (list (length out1) (length out2) (length out3))))))

(test1 10)
;-> (3 1 7)
(test1 10 true)
;-> (((10 2 10) (10 8 10) (10 10 10))
;->  ((10 10 10))
;->  ((10 2 2) (10 3 2) (10 6 2) (10 7 2) (10 8 8) (10 9 8) (10 10 10)))
(test1 88)
;-> (7 1 73)

Soluzione in stile newLISP (molto più compatta):

(define (test2 x)
  (list
    (first (count (list x) (map (curry | x) (sequence 1 x))))
    (first (count (list x) (map (curry & x) (sequence 1 x))))
    (length (clean zero? (map (curry & x) (sequence 1 x))))))

(test2 10)
;-> (3 1 7)
(test 88)
;-> (7 1 73)


----------
Bit string
----------

Calcolare il numero di stringhe di bit di lunghezza n.
Ad esempio, se n=3, la risposta è 8, perché le possibili stringhe di bit sono:
000, 001, 010, 011, 100, 101, 110 e 111.

Una stringa di bit è una sequenza composta da 0 e 1.
Se la lunghezza di questa sequenza è N, quante stringhe di bit distinte possiamo creare?

Se f(n) è la funzione che ci dà il numero di stringhe possibili, allora possiamo scrivere:

   f(n) = 2*f(n−1)

Ciò significa che il numero di possibili stringhe di bit raddoppia ogni volta che aggiungiamo un nuovo bit alla sequenza.
Come mai? Perché aggiungendo un bit avremo tutte le combinazioni precedenti con l'ennesimo bit assegnato a 1 più tutte le combinazioni precedenti con l'ennesimo bit assegnato a 0, quindi raddoppiandolo.

La funzione è la seguente:

(define (stringhe n) (pow 2 n))

(stringhe 3)
;-> 8
(stringhe 4)
;-> 16

In altri termini si tratta di generare tutte le pemutazioni di n elementi dalla lista di elementi (0 1):

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 3 '(0 1))
;-> ((0 0 0) (1 0 0) (0 1 0) (1 1 0) (0 0 1) (1 0 1) (0 1 1) (1 1 1))
(perm-rep 4 '(0 1))
;-> ((0 0 0 0) (1 0 0 0) (0 1 0 0) (1 1 0 0) (0 0 1 0) (1 0 1 0)
;->  (0 1 1 0) (1 1 1 0) (0 0 0 1) (1 0 0 1) (0 1 0 1) (1 1 0 1)
;->  (0 0 1 1) (1 0 1 1) (0 1 1 1) (1 1 1 1))


---------------------------------------
Sviluppi in serie di Taylor e Maclaurin
---------------------------------------

In analisi matematica, la serie di Taylor di una funzione in un punto x0 è la rappresentazione della funzione come serie di termini calcolati a partire dalle derivate della funzione stessa nel punto.

La formula è la seguente:

                 f'(x0)            f''(x0)            f'''(x0)
  f(x) = f(x0) + ------*(x-x0)^1 + -------*(x-x0)^2 + --------*(x-x0)^3 + ...
                   1!                 2!                 3!

          fn(x0)
       + --------*(x-x0)^n + ...
            n!

Uno sviluppo di Taylor in cui x0 sia uguale a 0 è definito sviluppo di Maclaurin.
Il teorema di Taylor (in realtà scoperto per primo da Gregory) afferma che qualsiasi funzione che soddisfi determinate condizioni può essere espressa come una serie di Taylor.

Vediamo alcune sviluppi di Taylor di alcune funzioni comuni:

Funzione esponenziale:

  e^x = Sum[n=0,inf](x^n/n!) =

      = 1 + x + x^2/2! + x^3/3! + x^4/4! + ...

Logaritmo naturale:

  ln(1 + x) = Sum[n=1,inf](x^n*(-1)^(n-1)/n), per |x| < 1

            = x - x^2/2 + x^3/3! - x^4/4! + x^5/5! - ... , per |x| < 1

Funzioni trigonometriche:

                          (-1)^n
  sin(x) = Sum[n=0,inf] -----------*x^(2n+1) =
                         (2n + 1)!

         = x - x^3/3! + x^5/5! - x^7/7! + ...

                           (-1)^n
  cos(x) = Sum[n=0,inf] -----------*x^(2n) =
                            (2n)!

         = 1 - x^2/2! + x^4/4! - x^6/6! + x^8/8! + ...

Calcoliamo la convergenza di queste funzioni:

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione per il calcolo della sommatoria di una funzione generica in un punto:

(define (fn-sum func x0 start end)
  (let (sum 0)
    (for (i start end)
      (inc sum (func x0 i)))))

(define (seno x n)
  (mul (pow x (+ (* 2 n) 1)) (div (pow -1 n) (fact-i (+ (* 2 n) 1)))))

Valore con la serie di Taylor:
(fn-sum seno 1 0 6)
;-> 0.8414709848086585

Valore con primitiva "sin":
(sin 1)
;-> 0.8414709848078965

Errore:
(sub (fn-sum seno 1 0 6) (sin 1))
;-> 7.619460618002449e-013

(define (coseno x n)
  (mul (pow x (* 2 n)) (div (pow -1 n) (fact-i (* 2 n)))))

Valore con la serie di Taylor:
(fn-sum coseno 1 0 6)
;-> 0.5403023058795627

Valore con primitiva "cos":
(cos 1)
;-> 0.5403023058681398

Errore:
(sub (fn-sum coseno 1 0 6) (cos 1))
;-> 1.142297367806577e-011


-------------------------
Equazione di quarto grado
-------------------------

https://en.wikipedia.org/wiki/Quartic_function

Data l'equazione generale di quarto grado:

  ax^4 + bx^3 + cx^2 + dx + e = 0

con coefficienti reali e a ≠ 0 la natura delle sue radici è determinata principalmente dal segno del suo discriminante:

  delta = 256a^3e^3 - 192a^2bde^2 - 128a^2c^2e^2 + 144a^2cd^2e - 27a^2d^4
        + 144ab^2ce^2 - 6ab^2d^2e - 80abc^2de + 18abcd^3 + 16ac^4e
        - 4ac^3d^2 - 27b^4e^2 + 18b^3cde - 4b^3d^3 - 4b^2c^3e + b^2c^2d^2

e dai seguenti polinomi:

  P = 8ac - 3b^3

  R = b^3 + 8da^2 - 4abc

  d0 = c^2 - 3bd + 12ae

  D = 64a^3e - 16a^2c^2 + 16ab^2c - 16a^2bd - 3b^4

(define (tipo a b c d e)
  (setq delta (add (mul  256 a a a e e e)
                   (mul -192 a a b d e e)
                   (mul -128 a a c c e e)
                   (mul  144 a a c d d e)
                   (mul  -27 a a d d d d)
                   (mul  144 a b b c e e)
                   (mul   -6 a b b d d e)
                   (mul  -80 a b c c d e)
                   (mul   18 a b c d d d)
                   (mul   16 a c c c c e)
                   (mul   -4 a c c c d d)
                   (mul  -27 b b b b e e)
                   (mul   18 b b b c d e)
                   (mul   -4 b b b d d d)
                   (mul   -4 b b c c c e)
                   (mul    1 b b c c d d)))
  (setq P (add (mul 8 a c) (mul -3 b b b)))
  (setq R (add (mul b b b) (mul 8 d a a) (mul -4 a b a)))
  (setq d0 (add (mul 12 a e) (mul -3 b d) (mul c c)))
  (setq D (add (mul  64 a a a e)
               (mul -16 a a c c)
               (mul  16 a b b c)
               (mul -16 a a b d)
               (mul  -3 b b b b)))
  (cond ((< delta 0)
          (println "2 distinct real and 2 complex conjugate"))
        ((> delta 0)
          (if (and (< P 0) (< D 0))
              (println "4 distinct real"))
          (if (or (> P 0) (> D 0))
              (println "2 pairs complex conjugate")))
        ((= delta 0)
          (if (and (< P 0) (< D 0) (!= d0 0))
              (println "1 double real and 2 distinct real"))
          (if (or (> D 0) (and (> P 0) (or (!= D 0) (!= R 0))))
              (println "1 double real and 2 complex conjugate"))
          (if (and (= d0 0) (!= D 0))
              (println "1 triple real and 1 distinct real"))
          (if (= D 0)
              (cond ((< P 0)
                     (println "2 double real"))
                    ((and (> p 0) (= R 0))
                     (println "2 double complex conjugate"))
                    ((= d0 0)
                     (println "1 quadruple real -b/2a"))
              )
          ))
  )
)

(set 'a 1 'b -2 'c -13 'd 14 'e 24)
(tipo a b c d e)
;-> 4 distinct real

(set 'a 1 'b -10 'c 35 'd -50 'e 24)
(tipo a b c d e)
;-> 2 pairs complex conjugate ???

(set 'a 1 'b 1 'c 1 'd 1 'e 1)
(tipo a b c d e)
;-> 2 pairs complex conjugate

La quattro radici (x1, x2, x3, x4) della seguente equazione di quarto grado:

  ax^4 + bx^3 + cx^2 + dx + e = 0

Si trovano con la seguente formula:

             b
  x1,x2 = - ---- - S +- (1/2)*sqrt(-4S^2 - 2p + q/S)
             4a

             b
  x3,x4 = - ---- + S +- (1/2)*sqrt(-4S^2 - 2p - q/S)
             4a

dove:

  delta = 256a^3e^3 - 192a^2bde^2 - 128a^2c^2e^2 + 144a^2cd^2e - 27a^2d^4
        + 144ab^2ce^2 - 6ab^2d^2e - 80abc^2de + 18abcd^3 + 16ac^4e
        - 4ac^3d^2 - 27b^4e^2 + 18b^3cde - 4b^3d^3 - 4b^2c^3e + b^2c^2d^2

  P = 8ac -3b^3

  R = b^3 + 8da^2 - 4abc

  d0 = c^2 - 3bd + 12ae

  D = 64a^3e - 16a^2c^2 + 16ab^2c - 16a^2bd - 3b^4


       8ac - 3b^2
  p = ------------
          8a^2

       b^3 - 4abc + 8a^2d
  q = --------------------
             8a^3

  S = (1/2)*sqrt[-(2/3)*p + (1/3a)*(Q + d0/Q)]

  Q = cubic[(d1 + sqrt(d1^2 - 4d0^3))/2]

  d0 = c^2 - 3bd + 12ae

  d1 = 2c^3 - 9bcd + 27b^2e - 72ace

  (d1^2 - 4d0^3) = -27delta

(set 'a 1 'b 1 'c 1 'd 1 'e 1)

Equazione:

  y = x^4 - 10x^3 + 35x^2 - 50x + 24
  y = (x - 4) (x - 3) (x - 2) (x - 1)

(set 'a 1 'b -10 'c 35 'd -50 'e 24)

Soluzioni:

  x1 = 1
  x2 = 2
  x3 = 3
  x4 = 4

Equazione:

  y = x^4 - 2x^3 - 13x^2 + 14x + 24
  y = (x - 4) (x + 3) (x - 2) (x + 1)

(set 'a 1 'b -2 'c -13 'd 14 'e 24)

Soluzioni:

  x1 = -1
  x2 =  2
  x3 = -3
  x4 =  4

(setq delta (add (mul  256 a a a e e e)
                 (mul -192 a a b d e e)
                 (mul -128 a a c c e e)
                 (mul  144 a a c d d e)
                 (mul  -27 a a d d d d)
                 (mul  144 a b b c e e)
                 (mul   -6 a b b d d e)
                 (mul  -80 a b c c d e)
                 (mul   18 a b c d d d)
                 (mul   16 a c c c c e)
                 (mul   -4 a c c c d d)
                 (mul  -27 b b b b e e)
                 (mul   18 b b b c d e)
                 (mul   -4 b b b d d d)
                 (mul   -4 b b c c c e)
                 (mul    1 b b c c d d)))

(setq p (div (add (mul 8 a c) (mul -3 b b)) (mul 8 a a)))

(setq q (div (add (mul 8 a a d) (mul -4 a b c) (mul b b b)) (mul 8 a a a)))

(setq d0 (add (mul 12 a e) (mul -3 b d) (mul c c)))

(setq d1 (add (mul 27 a d d) (mul -72 a c e) (mul 27 b b e) (mul -9 b c d) (mul 2 c c c)))

Test:
(add (mul 27 delta) (add (mul d1 d1) (mul -4 d0 d0 d0)))
;-> 0

;
; todo: check negative cubic root
;
(setq Q (pow (div (add d1 (sqrt (add (mul d1 d1) (mul -4 d0 d0 d0)))) 2) (div 3)))

;
; todo: check negative square root
;
(setq S (mul 0.5 (sqrt (add (div (add Q (div d0 Q)) (mul 3 a)) (div (mul -2 p) 3)))))

Soluzioni:

(setq z1 (sub (div (- b) (mul 4 a)) S))
(setq z2 (mul 0.5 (sqrt (add (mul -4 S S) (mul -2 p) (div q S)))))
(setq z3 (add (div (- b) (mul 4 a)) S))
(setq z4 (mul 0.5 (sqrt (add (mul -4 S S) (mul -2 p) (- (div q S))))))

(setq sol1 (add z1 z2))
(setq sol2 (sub z1 z2))
(setq sol3 (add z3 z4))
(setq sol4 (sub z3 z4))


----------------------------------
Gestione stipendi (Salary Queries)
----------------------------------

Una società ha n dipendenti con determinati stipendi.
Il compito è tenere traccia degli stipendi ed elaborare le richieste.
I dipendenti sono numerati 1,2,…,n.
Una lista di n interi (p1 p2 ... pn) contiene lo stipendio di ciascun impiegato.

Le richieste da elaborare per tenere traccia degli stipendi sono le seguenti:

 "! k":   licenzia (elimina) l'impiegato k
 "& x":   inserisce un nuovo impiegato con stipendio x
 "$ k x": cambia lo stipendio dell'impiegato k in x
 "? a b": conta il numero di dipendenti il cui stipendio è compreso tra a e b
 "*":     stampa tutti gli stipendi

Utilizziamo una variabile globale per gli stipendi (lista).

; global list for salaries
(setq *stipendi* '())

Funzione che inizializza gli stipendi:

; init salaries
(define (setup lst)
  (setq *stipendi* lst))

Scriviamo una funzione per ogni richiesta:

; delete employee
(define (delete-employee k)
  (pop *stipendi* (- k 1)))

; add employee
(define (add-employee x)
  (push x *stipendi* -1))

; update salary of employee
(define (update-salary k x)
  (setf (*stipendi* (- k 1)) x))

; num of salaries within (a...b)
(define (query-salary a b)
  (length (filter (fn(x) (and (>= x a) (<= x b))) *stipendi*)))

; show salaries
(define (show-salaries)
  (dolist (el *stipendi*) (print el { })) (println))

Funzione che gestisce gli stipendi;

(define (main salaries)
; no correctness check on user input
  (local (getline line)
    (setup salaries)
    (println "Salaries: " *stipendi*)
    (setq line "")
    (until (= getline "quit") ; type "quit" to exit
      (print "Command: ")
      (setq getline (read-line))
      (setq line (parse getline))
      (cond ((= (line 0) "!") ; "!"
              (delete-employee (int (line 1)))
              (println "delete employee " (line 1)))
            ((= (line 0) "&") ; "&"
              (add-employee (int (line 1)))
              (println "add employee with salary " (line 1)))
            ((= (line 0) "$") ; "$"
              (update-salary (int (line 1)) (int (line 2)))
              (println "update salary employee " (line 1) " to " (line 2)))
            ((= (line 0) "?") ; "?"
              (println "Total salaries within (" (line 1) ".." (line 2) "): "
                (query-salary (int (line 1)) (int (line 2)))))
            ((= (line 0) "*") ; "*"
              (println "Salaries:")
              (show-salaries))
            (true nil)
      ))))

(main '(3 7 2 2 5 8))
;-> Salaries: (3 7 2 2 5 8)
;-> Command: *
;-> Salaries:
;-> 3 7 2 2 5 8
;-> Command: ? 2 3
;-> Total salaries within (2..3): 3
;-> Command: ! 1
;-> delete employee 1
;-> Command: *
;-> Salaries:
;-> 7 2 2 5 8
;-> Command: ? 2 3
;-> Total salaries within (2..3): 2
;-> Command: & 12
;-> add employee with salary 12
;-> Command: *
;-> Salaries:
;-> 7 2 2 5 8 12
;-> Command: $ 2 6
;-> update salary employee 2 to6
;-> Command: *
;-> Salaries:
;-> 7 6 2 5 8 12
;-> Command: quit


--------------------------------
Teorema di Wilson e numeri primi
--------------------------------

Il teorema di Wilson afferma che un numero naturale p > 1 è un numero primo se e solo se

  (p - 1)! ≡ -1 mod p    oppure    (p - 1)! ≡ (p-1) mod p

In modo equivalente:
un numero p è primo se e solo se ((p-1)! + 1) % p = 0.

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (primo? num)
  (if (< num 2) nil
      (zero? (% (+ (fact-i (- num 1)) 1) num))))

(primo? 1)
;-> nil
(primo? 3)
;-> true
(primo? 11)
;-> trrue
(primo? 85)
;-> nil

(filter primo? (sequence 1 100))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

Nota: questo metodo è molto lento rispetto agli algoritmi standard per calcolare i numeri primi.


------------------
Patate disidratate
------------------

Supponiamo di acquistare 100 grammi di patate.
Sappiamo che il 99% delle patate è costituito da acqua.
Portiamo le patate a casa e le lasciamo fuori a disidratarsi fino a quando la quantità di acqua nelle patate è del 98%.
Qual è il peso delle patate adesso?

Situazione iniziale:
 x = 99% acqua + 1% solida
 x = 100
 x = 99gr acqua + 1gr solida

Situazione finale:
  y = 98% acqua + 2% solida
  y = ?

Al termine della disidratazione il peso della sostanza solida non è cambiato.
Questo significa che:

 1% di x = 2% di y

Poichè 1% di x = 1gr, risulta 2% di y = 1gr, cioè:

(2/100)*y = 1gr  -->  y = (100/2)*1gr = 50gr

Al termine della disidratazione le patate pesano 50 grammi.

Scriviamo una funzione generica:

peso = peso iniziale
p1 = percentuale iniziale materia A
p2 = percentuale finale materia A

(define (disidrata peso p1 p2)
  (local (pa1 pa2 pb1 pb2 ma1 ma2 mb1 mb2 peso-finale)
    (set 'pa1 p1 'pa2 p2)
    (set 'pb1 (sub 100 pa1) 'pb2 (sub 100 pa2))
    (setq ma1 (div (mul peso pa1) 100))
    (setq mb1 (div (mul peso pb1) 100))
    (setq mb2 mb1)
    (setq peso-finale (mul 100 (mul (div pb2) mb1)))
    (setq ma2 (sub peso-finale mb2))
    (println "Peso iniziale: "
      peso " con " ma1 " di A (" pa1 "%) e " mb1 " di B (" pb1 "%)")
    (println "Peso finale: "
      peso-finale " con " ma2 " di A (" pa2 "%) e " mb2 " di B (" pb2 "%)")))

(disidrata 100 99 98)
;-> Peso iniziale: 100 con 99 di A (99%) e 1 di B (1%)
;-> Peso finale: 50 con 49 di A (98%) e 1 di B (2%)

(disidrata 200 90 50)
;-> Peso iniziale: 200 con 180 di A (90%) e 20 di B (10%)
;-> Peso finale: 40 con 20 di A (50%) e 20 di B (50%)


----------------
Taxi verdi e blu
----------------

Un uomo è testimone di un incidente notturno in una città.
Un taxi urta una macchina parcheggiata e poi scompare.
L'uomo afferma che il taxi coinvolto nell'incidente era di colore Verde.
Nella città ci sono 85% di taxi Blu e 15% di taxi Verdi.
L'uomo, di notte, riconosce i colori Verde e Blu con una precisione dell'80%.
Qual è la probabilità che il taxi fosse effettivamente di colore verde?

Supponiamo che ci siano 100 incidenti:

  85 coinvolgono i taxi blu e
  15 coinvolgono i taxi verdi

Degli 85 incidenti con i taxi blu, il testimone ne riconosce:

  80% come blu, cioè 80% di 85 = 63
  20% come verdi, 20% di 85 = 17

Dei 15 incidenti con i taxi verdi, il testimone ne riconosce:

  80% come verdi, cioè 80% di 15 = 12
  20% come blu, cioè 20% di 15 = 3

La probabilità di un evento è data da:

               numero casi favorevoli
  P(evento) = -------------------------
                numero casi possibili

Il numero dei casi possibili è il numero dei casi in cui è stata riconosciuta una macchina Verde, cioè 17 + 12.
Il numero dei casi favorevoli è il numero dei casi in cui la macchina coinvolta era effettivamente verde, cioè 12.

La probabilità che il taxi coinvolto nell'incidente fosse effettivamente Verde vale:

  P(Verde) = 12/29 = 0.4137 = 41.37%

Scriviamo una funzione generica.

p1 = percentuale oggetti A (85 blu)
p2 = percentuale oggetti A (15 verdi)
acc = accuratezza del testimone (80%)

(define (correct? p1 p2 acc)
  (local (out err numA numB)
    ; errore del testimone
    (setq err (sub 100 acc))
    ; oggetti A riconosciuti come B
    (setq numA (div (mul p1 err) 100))
    ; oggetti B riconosciuti come B
    (setq numB (div (mul p2 acc) 100))
    ; percentuale di oggetti riconosciuti correttamente
    (mul 100 (div numB (add numA numB)))))

(correct? 85 15 80)
;-> 41.37931034482759

(correct? 80 20 80)
;-> 50

(correct? 60 40 80)
;-> 72.72727272727273

(correct? 98 2 98)
;-> 50

Se la percentuale di accuratezza del testimone è maggiore della percentuale di oggetti A, allora la probabilità che il testimone abbia visto giusto è maggiore del 50%.

Proviamo a simulare il processo.

(define (accident blu verdi accuratezza iter)
  (local (b v correct-v correct-b wrong-v wrong-b taxi)
    (set 'b 0 'v 0)
    (setq correct-v 0) ; verdi corretti
    (setq correct-b 0) ; blu corretti
    (setq wrong-v 0)   ; verdi sbagliati
    (setq wrong-b 0)   ; blu sbagliati
    (for (i 1 iter)
      (if (> blu (rand 100))
        (setq taxi "blu")
        (setq taxi "verde")
      )
      (cond ((= taxi "blu")
              (++ b)
              (if (> accuratezza (rand 100))
                  (++ correct-b)
                  (++ wrong-b)))
            ((= taxi "verde")
              (++ v)
              (if (> accuratezza (rand 100))
                  (++ correct-v)
                  (++ wrong-v)))
            (true (println "error"))
      )
    )
    ;(println b { } v)
    (list (div correct-v (add correct-v wrong-b)))))

(accident 85 15 80 1e7)
;-> (0.4135245750449149)

(accident 80 20 80 1e7)
;-> (0.5001220565180991)

(accident 60 40 80 1e7)
;-> (0.7273790548541494)

I risultati della simulazione sono congruenti con quelli teorici.


--------------------
Short classic puzzle
--------------------

Risolvere i seguenti problemi senza utilizzo dell'algebra con carta e penna.

Il prezzo di un libro è di 10 euro più la metà del suo prezzo.
Quanto costa il libro?

  x = 10 + x/2
  (1/2)x = 10
  x = 10 * 2 = 20 euro

---------------------

Il peso di un mattone è di 1kg più il peso di mezzo mattone.
Quanto pesa un mattone?

  x = 1 + (1/2)x
  (1/2)x = 1
  x = 1 * 2 = 2kg

---------------------

Una matita e una penna costano 1 euro e 10 centesimi.
La penna costa 1 euro in più della matita.
Quanto costano la matita e la penna?

  m + p = 1.10
  p = 1 + m
  m + (1 + m) = 1.10
  2q + 1 = 1.10
  2q = 0.10
  m = 0.10/2 = 0.05
  p = 1 + m = 1 + 0.05 = 1.05

La penna costa 1 euro e 5 centesimi (1.05), la matita costa 5 centesimi (0.05).


-------------------------
Risultati delle votazioni
-------------------------

Una elezione ha 8000 votanti e 4 candidati.
Il vincitore ha superato i suoi avversari di 200, 221 e 400 voti.
Ci sono state 97 schede bianche o nulle.
Calcolare quanti voti sono stati espressi per ogni candidato.

Sia x il numero di voti ottenuti dal candidato che ha vinto.
Gli altri candidati hanno ricevuto: x - 200, x - 221 e x - 400.
La somma di questi voti è uguale a:

  4x - 821

Questo deve essere uguale ai votanti meno il numero di schede bianche o nulle:

  8000 - 97 = 7903

Quindi, possiamo scrivere:

  4x − 821 = 7903.

Pertanto:

  4x = 7903 + 821 = 8724 --> x = 8724/4 = 2181.

Pertanto, il candidato vincente (primo) ha ricevuto 2181 voti.
Il numero di voti ricevuti dagli altri candidati si ottiene sottraendo i voti di scarto:

  voti del primo = 2181
  voti del secondo = voti del primo - 200 = 2181 - 200 = 1981
  voti del terzo   = voti del primo - 221 = 2181 - 221 = 1960
  voti del quarto  = voti del primo - 400 = 2181 - 400 = 1781

Scriviamo una funzione generica che risolve il problema:

(define (votazione votanti diff nulle)
  (local (out somma)
    (setq out '())
    (setq somma (apply + diff))
    (setq primo (div (add (sub votanti nulle) somma) (length diff)))
    (dolist (p diff)
      (push (sub primo p) out -1)
    )
    out))

(votazione 8000 '(0 200 221 400) 97)
;-> (2181 1981 1960 1781)


------------------------------------------------
Il paradosso di Simpson e la fallacia di Berkson
------------------------------------------------

Il paradosso di Simpson viene descritto per la prima volta dallo statistico Edward Simpson in un articolo del 1951 intitolato "The Interpretation of Interaction in Contingency Tables".
Simpson ha descritto uno scenario in cui i risultati di uno studio scientifico sembrano supportare una conclusione, ma quando i risultati vengono divisi per tenere conto di una particolare variabile, i risultati mostrano una conclusione diversa.
Il paradosso di Simpson si manifesta quando la relazione tra due variabili nell'intera popolazione è molto diversa dalla relazione tra le stesse variabili nelle sottopopolazioni definite da una terza variabile, tanto che le conclusioni sono opposte.
Il paradosso di Simpson viene descritto anche come un metodo per dimostrare, con gli stessi dati, conclusioni opposte.

Vediamo alcuni esempi.

1) Soccorso in ambulanza o elicottero
-------------------------------------
Analizziamo la seguente tabella:

                  +------------+-----------+--------+
                  | Elicottero | Ambulanza | Totale |
  +---------------+------------+-----------+--------+
  | Morti         |  64        |  260      |  324   |
  +---------------+------------+-----------+--------+
  | Sopravvissuti | 136        |  840      |  976   |
  +---------------+------------+-----------+--------+
  | Totale        | 200        | 1100      | 1300   |
  +---------------+------------+-----------+--------+

Pazienti morti:
- Elicottero: 64/200 = 32%
- Ambulanza: 260/1100 = 24%

Adesso inseriamo una nuova variabile (incidenti gravi e non gravi):

  Incidenti gravi
                  +------------+-----------+--------+
                  | Elicottero | Ambulanza | Totale |
  +---------------+------------+-----------+--------+
  | Morti         |  48        |  60       | 108    |
  +---------------+------------+-----------+--------+
  | Sopravvissuti |  52        |  40       |  92    |
  +---------------+------------+-----------+--------+
  | Totale        | 100        | 100       | 200    |
  +---------------+------------+-----------+--------+

Pazienti morti:
- Elicottero: 48/100 = 48%
- Ambulanza: 60/100 = 60%

  Incidenti non gravi
                  +------------+-----------+--------+
                  | Elicottero | Ambulanza | Totale |
  +---------------+------------+-----------+--------+
  | Morti         | 16         | 200       | 216    |
  +---------------+------------+-----------+--------+
  | Sopravvissuti | 84         | 800       | 884    |
  +---------------+------------+-----------+--------+
  | Totale        | 100        | 1000      | 1100   |
  +---------------+------------+-----------+--------+

Pazienti morti:
• Elicottero: 16/100 = 16%
• Ambulanza:200/1000= 20%

Vediamo cosa accade:

  X = mezzo di soccorso (elicottero/ambulanza)
  Y = esito (morto/sopravvissuto)
  Z = gravità dell'incidente (grave/non grave)

La relazione tra X e Y nell'intera popolazione (1300 persone) è ben diversa dalla relazione tra X e Y nella sottopopolazione con incidente grave (Z= "grave", 200 persone) e in quella con incidente non grave (Z="non grave", 1100 persone).

2) Discriminazione sessuale
---------------------------
Negli anni Settanta l'università di Berkeley ha analizzato i dati relativi alle assunzioni nei vari dipartimenti, scoprendo che il tasso di ammissione delle femmine era sostanzialmente inferiore a quello dei maschi.
L'università poteva essere accusata di discriminazione sessuale!

Consideriamo un esempio con 200 candidati, di cui 100 maschi e 100 femmine

                +--------+---------+
                | Maschi | Femmine |
  +-------------+--------+---------+
  | Assunti     |  55    |  45     |
  +-------------+--------+---------+
  | Non assunti |  45    |  55     |
  +-------------+--------+---------+
  | Totale      | 100    | 100     |
  +-------------+--------+---------+
  | % assunti   |  55%   |  45%    |
  +-------------+--------+---------+

La tabella mostra che il tasso di assunzione delle femmine è minore di quello dei maschi.

Adesso introduciamo una nuova variabile (dipartimento: sociologia o fisica):

                +---------+---------+--------+---------+--------+---------+
                |    Sociologia     |     Fisica       | Totale | Totale  |
  +-------------+---------+---------+--------+---------+--------+---------+
  |             | Maschi  | Femmine | Maschi | Femmine | Maschi | Femmine |
  +-------------+---------+---------+--------+---------+--------+---------+
  | Assunti     | 5       | 30      | 50     | 15      | 55     | 45      |
  +-------------+---------+---------+--------+---------+--------+---------+
  | Non-assunti | 15      | 50      | 30     | 5       | 45     | 55      |
  +-------------+---------+---------+--------+---------+--------+---------+
  | Totale      | 20      | 80      | 80     | 20      | 100    | 100     |
  +-------------+---------+---------+--------+---------+--------+---------+
  | %-assunti   | 25.0%   | 37.5%   | 62.5%  | 75.0%   | 55.0%  | 45.0%   |
  +-------------+---------+---------+--------+---------+--------+---------+

L'analisi dei dati mostra che non c'♪ alcuna discriminazione sessuale.
Infatti, considerando i tassi di ammissione per dipartimento, la situazione è rovesciata poiché nella maggior parte dei dipartimenti (nell'esempio solo Sociologia e Fisica) le femmine facevano registrare un tasso di successo più elevato (il tasso di assunzione globale risultava inferiore perché le femmine facevano domanda soprattutto nei dipartimenti più "difficili", cioè con molti candidati per ogni posizione).
Il tasso di successo complessivo si ottiene come media pesata dei tassi di successo nei due dipartimenti, usando pesi proporzionali al numero di partecipanti.
Ad es., le femmine hanno un tasso di successo di 0.375 a sociologia (dove partecipano in 80) e 0.75 a fisica (dove partecipano in 20):
il tasso di successo complessivo è 0.375*(80/100)+0.75*(20/100)=0.45
I maschi hanno un tasso di 0.25 per Sociologia e 0.625 per Fisica, con un tasso di successo complessivo pari a 0.55.
In entrambi i dipartimenti il tasso di successo delle femmine è superiore a quello dei maschi, ma per il tasso complessivo accade il contrario a causa dei pesi (le femmine partecipano in prevalenza alla selezione nel dipartimento più "difficile").

Interpretazione in termini di effetti causali

           +--------------+
       +-->| Dipartimento |---+
       |   +--------------+   |
   (b) |                      | (b)
       |                      |
       |                      ∨
  +---------+    (a)    +------------+
  | Femmina |---------->| Assunzione |
  +---------+           +------------+

Essere femmina influenza probabilità di assunzione in due modi:
a) Effetto diretto (la freccia (a))
b) Effetto indiretto tramite la scelta del dipartimento (le frecce (b))
L'effetto di interesse per valutare la discriminazione è quello diretto.
Tuttavia, studiando la relazione tra femmina e assunzione senza considerare il dipartimento non si ottiene l'effetto diretto, ma quello complessivo (diretto + indiretto).
Per ottenere l'effetto diretto l'analisi va svolta condizionatamente al dipartimento, cioè si deve studiare la relazione tra femmina e assunzione separatamente per ogni dipartimento.

3) Razzismo e pena di morte
---------------------------

          +-----------------+---------------+
          | Imputato-bianco | Imputato-nero |
  +-------+-----------------+---------------+
  | Morte | 19              | 17            |
  +-------+-----------------+---------------+
  | Salvo | 141             | 149           |
  +-------+-----------------+---------------+
            11.86%            20.24%

(div 19 (+ 19 141))
;-> 0.11875
(div 17 (+ 17 149))
;-> 0.1024096385542169

Introduciamo una nuova variabile (vittima: bianca o nera):

  Imputato bianco
          +----------------+--------------+
          | Vittima-bianca | Vittima-nera |
  +-------+----------------+--------------+
  | Morte | 19             | 0            |
  +-------+----------------+--------------+
  | Salvo | 132            | 9            |
  +-------+----------------+--------------+
            12.6%            0%

(div 19 (+ 19 132))
;-> 0.1258278145695364
(div 0 (+ 0 9))
;-> 0

  Imputato nero
          +----------------+--------------+
          | Vittima-bianca | Vittima-nera |
  +-------+----------------+--------------+
  | Morte | 11             | 6            |
  +-------+----------------+--------------+
  | Salvo | 52             | 5.8          |
  +-------+----------------+--------------+
            17.5%            5.8%

(div 11 (+ 11 52))
;-> 0.1746031746031746
(div 6 (+ 6 97))
;-> 0.05825242718446602

Anche in questo caso è evidente la contraddizione dei due risultati.

La fallacia di Berkson
----------------------

Paradosso di Simpson: la relazione tra due variabili di interesse X e Y si inverte quando ci si condiziona ad una terza variabile Z.

Negli esempi visti fino ad ora l'analisi che ignora Z è sbagliata, mentre l'analisi che condiziona a Z è corretta.
Questo è ciò che accade di solito, ma ci sono situazioni in accade il contrario, ovvero è l'analisi condizionata a Z a produrre risultati fuorvianti.

Un caso interessante è la fallacia di Berkson, in cui Z denota l'appartenenza al campione osservato.
Esempio fittizio con X: diabete, Y: ipertensione, questa è la tabella doppia nell'intera popolazione.

          Ipertensione
 Diabete   No  Sì Tot
 No       420 180 600
 Sì       280 120 400
 Tot      700 300 1000

Nella popolazione le due patologie sono indipendenti: la proporzione di ipertesi è la stessa tra i non diabetici (180/600=0.3) e diabetici (280/400=0.3).

Supponiamo di non poter osservare l'intera popolazione, ma solo coloro che sono ricoverati in ospedale (Z=1) e consideriamo due scenari.

Scenario A:
sono in ospedale tutti coloro che hanno almeno una delle due patologie.

           Ipertensione
  Diabete   No  Sì Tot
  No         0 180 180
  Sì       280 120 400
  Tot      280 300 580

Nella sottopopolazione in ospedale le due patologie sono positivamente associate: la proporzione di ipertesi è maggiore tra i non diabetici (180/180=1) che tra i diabetici (120/400=0.3).

Scenario B:
sono in ospedale tutti coloro che hanno entrambe le due patologie + 1 su 10 di coloro che hanno una sola patologia + altri 12 soggetti che non hanno ne l'una né l'altra.

           Ipertensione
  Diabete   No  Sì Tot
  No        12  18  30
  Sì        28 120 148
  Tot       40 138 178

Nella sottopopolazione in ospedale le due patologie sono negativamente associate: la proporzione di ipertesi è minore tra i non diabetici (18/30=0.6) che tra i diabetici (120/148=0.81).

Interpretazione in termini di effetti causali

       +---------+          +--------------+
       | Diabete |          | Ipertensione |
       +---------+          +--------------+
               |              |
               |              |
               ∨              ∨
            +----------------------+
            | Ricovero in ospedale |
            +----------------------+

In questo esempio non c'è associazione tra diabete e ipertensione (nessuna freccia). Tuttavia, diabete e ipertensione hanno un effetto comune (ricovero in ospedale), per cui l'analisi condizionata allo stato di ricovero in ospedale crea una associazione fittizia tra diabete e ipertensione.
In questo caso l'analisi condizionata (cioè sui soggetti ricoverati in ospedale) è sbagliata, mentre quella non condizionata (cioè su tutta la popolazione) è corretta.
La fallacia di Berkson è detta anche distorsione da selezione campionaria: in generale, si verifica quando l'appartenere o meno al campione osservato dipende dal valore delle variabili di interesse, per cui la relazione tra le variabili nel campione è diversa dalla relazione nella popolazione.


------------------------------------
Forum: The semantics of newLISP's if
------------------------------------

rickyboy:
---------
The if expression in newLISP can usually be found to have different semantics than ifs in other lisps. Lutz has chosen for it to have semantics which are in the spirit of cond.

I believe that this is a great choice, because newLISP's if is a general type of if. What do I mean by this? In the manual discussion,

 http://www.newlisp.org/downloads/newlisp_manual.html#if

we are presented with the two different forms of if, but in fact, the second form (the one that takes an arbitrary number of clauses) is just a generalization of the first form.[1]

Lutz may not like for me to say this, but there is a beauty and a consistency[2] in its simple semantics.

http://www.newlispfanclub.alh.net/forum/viewtopic.php?t=4381&p=21628#p21628

(Programming language geeks like me love it, but I think other users would too. This is something that I think can bring us all together. :)

I believe that Lutz made a great decision in choosing the semantics of newLISP's if expression, and in the following, I am going to detail why this is so.

The arguments to if are a list of clauses, which in the non-degenerate cases, are pairs of test and consequent clauses. The situation looks like this:

( if test-clause-1 consequent-clause-1 . . . test-clause-N consequent-clause-N )

These pairs are continually looped though until the first such test clause evaluates to a "truthy" value, in which case its corresponding consequent clause is evaluated and yielded as the value of the if expression itself.

The degenerate cases are when the if expression has one clause (argument) or none. But these cases can be thought of as base cases of a recursive evaluator for if. In fact, you can write such an evaluator in newLISP. Here is one.

(define (eval-if EXPR)
  (if (empty? EXPR)        nil
      (= 'if (EXPR 0))     (eval-if (1 EXPR))
      (= 1 (length EXPR))  (eval (EXPR 0))
      (let (test-clause (EXPR 0)
            consequent-clause (EXPR 1)
            rest-of-the-clauses (2 EXPR))
        (if (eval test-clause)
            (eval consequent-clause)
            (eval-if rest-of-the-clauses)))))

There is something important lurking here, and it is that this function describes the semantics of newLISP's if in newLISP itself!!! Yeah, that's cool.

Now, it is clear why the degenerate cases yield the values they do for newLISP's if. Here are some examples of these cases.

(if)          ;=> nil
(if 42)       ;=> 42
(if (+ 2 40)) ;=> 42

Our evaluator treats them the same.

(eval-if '(if))          ;=> nil
(eval-if '(if 42))       ;=> 42
(eval-if '(if (+ 2 40))) ;=> 42

Next, examples from the first form of if in the manual look like this.

(set 'x 50)
(if (< x 100) "small" "big") ;=> "small"
(set 'x 1000)
(if (< x 100) "small" "big") ;=> "big"
(if (> x 2000) "big")        ;=> nil

Our evaluator in action now.

(set 'x 50)
(eval-if '(if (< x 100) "small" "big")) ;=> "small"
(set 'x 1000)
(eval-if '(if (< x 100) "small" "big")) ;=> "big"
(eval-if '(if (> x 2000) "big"))        ;=> nil

Finally, the examples from the second form of if in the manual.

(define (classify x)
  (if (< x 0) "negative"
      (< x 10) "small"
      (< x 20) "medium"
      (>= x 30) "big"
      "n/a"))

(classify 15)   ;=> "medium"
(classify 100)  ;=> "big"
(classify 22)   ;=> "n/a"
(classify -10)  ;=> "negative"

Our evaluator.

(define (classify-eval-if x)
  (eval-if '(if (< x 0) "negative"
                (< x 10) "small"
                (< x 20) "medium"
                (>= x 30) "big"
                "n/a")))

(classify-eval-if 15)   ;=> "medium"
(classify-eval-if 100)  ;=> "big"
(classify-eval-if 22)   ;=> "n/a"
(classify-eval-if -10)  ;=> "negative"

__________
[1] No doubt though that the manual presents two forms of if to the user because the first form is well-known; so it will communicate its ideas (about it and the second form) best to the broadest section of readers.

[2] There you go, Lutz; I used both terms. :)
---------------------

***************
>>>funzione IF
***************
syntax: (if exp-condition exp-1 [exp-2])
syntax: (if exp-cond-1 exp-1 exp-cond-2 exp-2 [ ... ])

If the value of exp-condition is neither nil nor an empty list, the result of evaluating exp-1 is returned; otherwise, the value of exp-2 is returned. If exp-2 is absent, the value of exp-condition is returned.

if also sets the anaphoric system variable $it to the value of the conditional expression in if.

(set 'x 50)                   → 50
(if (< x 100) "small" "big")  → "small"
(set 'x 1000)                 → 1000
(if (< x 100) "small" "big")  → "big"
(if (> x 2000) "big")         → nil

; more than one statement in the true or false
; part must be blocked with (begin ...)
(if (= x y)
  (begin
    (some-func x)
    (some-func y))
  (begin
    (do-this x y)
    (do-that x y))
)

; if also sets the anaphoric system variable $it
(set 'lst '(A B C))
(if lst (println (last $it)))  → C

The second form of if works similarly to cond, except it does not take parentheses around the condition-body pair of expressions. In this form, if can have an unlimited number of arguments.

(define (classify x)
(if
(< x 0) "negative"
(< x 10) "small"
(< x 20) "medium"
(>= x 30) "big"
"n/a"))

(classify 15)   → "medium"
(classify 100)  → "big"
(classify 22)   → "n/a"
(classify -10)  → "negative"

The last expression, "n/a", is optional. When this option is omitted, the evaluation of (>= x 30) is returned, behaving exactly like a traditional cond but without requiring parentheses around the condition-expression pairs.

In any case, the whole if expression always returns the last expression or condition evaluated.

See also the when and unless functions.


----------------------
Forza 4 - Connect Four
----------------------

Forza 4 (Connect Four) è un gioco da tavolo prodotto dalla Milton Bradley nel 1974.
Si tratta di un gioco di allineamento (di solito su una matrice di sei righe e sette colonne) simile al tris o al go-moku.

Anche in questo caso l'obiettivo è mettere in fila (orizzontale, verticale o diagonale) un certo numero (quattro) di proprie pedine. L'elemento fondamentale del gioco, che lo rende del tutto originale, è la forza di gravità: la scacchiera è posta in verticale fra i giocatori, e le pedine vengono fatte cadere lungo una griglia verticale, in modo tale che una pedina inserita in una certa colonna va sempre a occupare la posizione libera situata più in basso nella colonna stessa.
Forza 4 è stato risolto, nel senso che è stato dimostrato che il giocatore che comincia la partita ed esegue tutte le mosse "ottimali" vince sempre.

0 = empty cell
1 = yellow piece
2 = red piece

Funzione che stampa la griglia del gioco:

(define (print-grid grid)
  (local (rows cols)
    (setq rows (length grid))
    (setq cols (length (first grid)))
    (for (i 0 (- rows 1))
      (for (j 0 (- cols 1))
        (cond ((= (grid i j) 0) (print " 0")) ; empty
              ((= (grid i j) 1) (print " 1")) ; yellow
              ((= (grid i j) 2) (print " 2")) ; red
        )
      )
      (println))))

(setq grid '((0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0)
             (0 0 0 0 1 0 0)
             (0 0 0 0 2 1 0)
             (1 1 2 2 1 2 1)
             (1 2 1 2 1 2 1)))

(print-grid grid)
;-> 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0
;-> 0 0 0 0 1 0 0
;-> 0 0 0 0 2 1 0
;-> 1 1 2 2 1 2 1
;-> 1 2 1 2 1 2 1

Funzione che verifica se una mossa è legale:
Una mossa è un numero che rappresenta la colonna di inserimento (0..(cols -1)).
Il numero è valido se è compreso tra 0 e (cols - 1) e l'elemento della riga = 0 e colonna = num è vuoto (cioè vale 0).

(define (legal-move? num grid)
  (let ((cols (length (first grid))))
    (and (>= num 0) (< num cols) (zero? (grid 0 num)))))

Funzione che effettua una mossa legale (modifica la griglia di gioco):

(define (make-move num color grid)
  (local (tmp rows)
    (setq tmp -1)
    (setq rows (length grid))
    ; cerca l'ultimo 0 della colonna num
    (for (r 0 (- rows 1))
      (if (zero? (grid r num)) (setq tmp r))
    )
    (setf (grid tmp num) color)
    grid))

(setq g1 grid)
(print-grid g1)
(valid-move? 1 g1)
(setq g1 (make-move 2 1 g1))
(print-grid g1)

Funzione che verifica se un giocatore ha vinto:
(0 = nessun vincitore, 1 = vince yellow, 2 = vince red)

(define (check-win player grid)
  (local (out rows cols)
    (setq out 0)
    (setq rows (length grid))
    (setq cols (length (first grid)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (if (check r c grid player) (setq out (grid r c)))
      )
    )
    out))

Funzione ausiliaria che verifica se una casella è un estremo di una configurazione vincente (nelle 8 direzioni possibili):

(define (check i j grid player)
  (local (rows cols val out)
    (setq out nil)
    (setq rows (length grid))
    (setq cols (length (first grid)))
    (setq val (grid i j))
    (if (= val player)
      (begin
        ; right
        (if (< (+ j 3) cols)
            (if (= (grid i j) (grid i (+ j 1))
                   (grid i (+ j 2)) (grid i (+ j 3)))
                (begin
                  ;(println "right: " i { } j)
                  (setq out true)))
        )
        ; left
        (if (>= (- j 3) 0)
            (if (= (grid i j) (grid i (- j 1))
                   (grid i (- j 2)) (grid i (- j 3)))
                (begin
                  ;(println "left: " i { } j)
                  (setq out true)))
        )
        ; down
        (if (< (+ i 3) rows)
            (if (= (grid i j) (grid (+ i 1) j)
                   (grid (+ i 2) j) (grid (+ i 3) j))
                (begin
                  ;(println "down: " i { } j)
                  (setq out true)))
        )
        ; up
        (if (>= (- i 3) 0)
            (if (= (grid i j) (grid (- i 1) j)
                   (grid (- i 2) j) (grid (- i 3) j))
                (begin
                  ;(println "up: " i { } j)
                  (setq out true)))
        )
        ; up-right
        (if (and (>= (- i 3) 0) (< (+ j 3) cols))
            (if (= (grid i j) (grid (- i 1) (+ j 1))
                   (grid (- i 2) (+ j 2)) (grid (- i 3) (+ j 3)))
                (begin
                  ;(println "up-right: " i { } j)
                  (setq out true)))
        )
        ; up-left
        (if (and (>= (- i 3) 0) (>= (- j 3) 0))
            (if (= (grid i j) (grid (- i 1) (- j 1))
                   (grid (- i 2) (- j 2)) (grid (- i 3) (- j 3)))
                (begin
                  ;(println "up-left: " i { } j)
                  (setq out true)))
        )
        ; down-left
        (if (and (< (+ i 3) rows) (>= (- j 3) 0))
            (if (= (grid i j) (grid (+ i 1) (- j 1))
                   (grid (+ i 2) (- j 2)) (grid (+ i 3) (- j 3)))
                (begin
                  ;(println "down-left: " i { } j)
                  (setq out true)))
        )
        ; down-right
        (if (and (< (+ i 3) rows) (< (+ j 3) cols))
            (if (= (grid i j) (grid (+ i 1) (+ j 1))
                   (grid (+ i 2) (+ j 2)) (grid (+ i 3) (+ j 3)))
                (begin
                  ;(println "down-right: " i { } j)
                  (setq out true)))
        )
      )
    )
    out))

(setq test '((1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)
             (1 1 1 1)))

(check-win 1 test)
;-> 1
(check-win 2 test)
;-> 0

Funzione che gestisce l'input utente di una cifra intera (0..9):

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

(read-int "Intero (1 5): " 1 5)
;-> Intero (1 5): 2

Funzione che gestisce una partita di forza4 tra due giocatori:

(define (forza4 rows cols)
  (local (board mosse endgame player p1 p2)
    ; crea griglia di gioco
    (setq board (array-list (array rows cols '(0))))
    (setq mosse 0)
    (setq endgame nil)
    ; ciclo del gioco
    (until endgame
      ; stampa griglia di gioco
      (print-grid board)
      ;
      ; input player 1
      ;
      (setq player 1)
      (setq p1 (read-int (string "Player 1 --> colonna (0.." (- cols 1) "): ")
                0 (- cols 1)))
      ; se la mossa è legale...
      (if (legal-move? p1 board)
        ; allora effettua la mossa sulla griglia
        (setq board (make-move p1 player board))
        ; altrimenti stampa un messaggio di errore
        (println "Attenzione: mossa illegale, salta il turno.")
      )
      ; controllo vincita del giocatore 1
      (if (= (check-win player board) player) (setq endgame true))
      ; aggiorna numero delle mosse
      (++ mosse)
      ; stampa griglia di gioco
      (print-grid board)
      ;
      ; input player 2
      ;
      (cond ((not endgame)
              (setq player 2)
              (setq p2 (read-int (string "Player 2 --> colonna (0.." (- cols 1) "): ")
                        0 (- cols 1)))
              ; se la mossa è legale...
              (if (legal-move? p2 board)
                ; allora effettua la mossa sulla griglia
                (setq board (make-move p2 player board))
                ; altrimenti stampa un messaggio di errore
                (println "Attenzione: mossa illegale, salta il turno.")
              )
              ; controllo vincita del giocatore 1
              (if (= (check-win player board) player) (setq endgame true)))
      )
    )
    ; fine del gioco
    (println "-----FORZA4-----")
    (print-grid board)
    (println "The winner is: " player " (" mosse " moves)")
  ) 'game-over
)

Facciamo una partita:

(forza4 6 7)
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;-> Player 1 --> colonna (0..6): 1
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 1 0 0 0 0 0
;-> Player 2 --> colonna (0..6): 2
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 1 2 0 0 0 0
;-> Player 1 --> colonna (0..6): 1
;-> ...
;-> -----FORZA4-----
;->  0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0
;->  0 1 0 0 0 0 0
;->  0 1 2 0 0 0 0
;->  0 1 2 0 0 0 0
;->  0 1 2 0 0 0 0
;-> The winner is: 1 (4 moves)
;-> game-over

Una funzione di stampa a colori e caratteri UTF8 (per terminali ANSI):

 █ ■

(define (print-grid grid)
  (local (rows cols yellow red nocol)
    (setq yellow "\027[0;33m")
    (setq red "\027[0;31m")
    (setq nocol "\027[39;49m")
    (setq rows (length grid))
    (setq cols (length (first grid)))
    (for (i 0 (- cols 1))
      (print (string " " i " "))
    )
    (println)
    (for (i 0 (- rows 1))
      (for (j 0 (- cols 1))
        (cond ((= (grid i j) 0) (print "|  ")) ; empty
              ((= (grid i j) 1) (print "|" yellow "██" nocol)) ; yellow
              ((= (grid i j) 2) (print "|" red    "██" nocol)) ; red
        )
      )
      (println "|" )
    )
    (println (dup "-" (+ (* cols 3) 1)))))

Pronto per giocare per dimensioni diverse:

(forza4 10 10)
;->  0  1  2  3  4  5  6  7  8  9
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> |  |  |  |  |  |  |  |  |  |  |
;-> -------------------------------
;-> Player 1 --> colonna (0..9):

Vedi anche "Forza 4 (Connect4) Interattivo" su "Note libere 20")


-----------------------------------------
Moltiplicazione fra matrici e stress-test
-----------------------------------------

Dal momento che anche i programmatori esperti commettono errori nella risoluzione di problemi algoritmici, è importante imparare a identificare gli errori (bug) il più presto possibile.
I programmi non sono quasi mai corretti quando li eseguiamo per la prima volta.
Per essere sicuri che il nostro programma funziona, spesso lo proviamo solo con alcuni casi di test e se i risultati sono ragionevoli, consideraimo il programma terminato.
Tuttavia, questa è il modo migliore per andare incontro ad un disastro.
Per rendere "robusto" ikl nostro programma dovremmo provarlo con una serie di casi di test attentamente progettati.
Il lavoro del programmatore consiste nell'implementare algoritmi ed eseguire il debug dei programmi.

Stress Test
-----------
Lo stress test è una tecnica per generare migliaia di test con l'obiettivo di trovare uno o più casi per il quale il nostro programma fallisce.

Uno stress test si compone di quattro parti:

1. La nostra implementazione di un algoritmo.

2. Un'implementazione alternativa corretta dell'algoritmo per lo stesso problema (anche banale e lenta).

3. Un generatore di test casuali.

4. Un ciclo di lunghezza arbitraria in cui un nuovo test viene generato e inserito in entrambe
 le implementazioni per confrontare i risultati.
Se i loro risultati differiscono, allora viene riportato un errore e lo sterss test si interrompe.
Se i risultati sono uguali si passa al prosimo test generato all'interno del ciclo.

L'idea alla base dello stress test è che due implementazioni corrette dovrebbero dare la stessa risposta per ogni test (a condizione che la risposta al problema sia unica).
Se, tuttavia, una delle implementazioni non è corretta, allora esiste almeno un test su cui le loro risposte differiscono.
L'unico caso in cui questo non è vero si ha quando c'è lo stesso errore in entrambe le implementazioni, ma questo è improbabile (a meno che l'errore non sia nell'input/output o nelle routine comuni ad entrambe le soluzioni).
Se entrambi i programmi sono sbagliati, ma i bug sono diversi, molto probabilmente esiste un test in cui due soluzioni danno risultati differenti.

Moltiplicazione tra matrici
---------------------------
Data una matrice A di dimensione MxN ed una seconda matrice B di dimensioni NxP.
Siano a(i j) gli elementi di A e b(i j) gli elementi di B.
Si definisce il prodotto matriciale di A per B la matrice  C = A*B di dimensioni MxP i cui elementi c(i j) sono dati da:

  c(i j) = Sum[k=1,N] a(i k)*b(k j)

per i = 1..M e j = 1..P.

Per poter eseguire la moltiplicazione tra matrici, il numero di colonne nella prima matrice deve essere uguale al numero di righe nella seconda matrice.

La matrice risultante, nota come prodotto tra matrici, ha il numero di righe della prima matrice e il numero di colonne della seconda matrice.

  Prima matrice:        A (MxN)
  Seconda matrice:      B (NxP)
  Prodotto tra matrici: C (MxP)

Scriviamo la nostra funzione per la moltiplicazione tra matrici:

(define (mult-mat A B)
  (local (out rowA colA rowB colB)
    (setq rowA (length A))
    (setq colA (length (first A)))
    (setq rowB (length B))
    (setq colB (length (first B)))
    (read-line)
    ; matrice risultante: rowA righe e colB colonne
    (setq out (array rowA colB '(0)))
    ; condizione per poter moltiplicare due matrici:
    ; numero colonne prima matrice = numero righe seconda matrice
    (cond ((!= colA rowB) (setq out nil))
          (true ; moltiplicazione tra matrici
            (for (i 0 (- rowA 1))
              (for (j 0 (- colB 1))
                (for (k 0 (- colA 1))
                  (setf (out i j) (add (out i j) (mul (A i k) (B k j))))
                )
              )
            ))
    )
    out))

Complessità temporale: O(n^3)

Facciamo alcune prove:

(setq m1 '((1 1 1) (2 2 2) (3 3 3)))
(setq m2 '((1 1 1) (2 2 2) (3 3 3)))
(print-matrix (mult-mat m1 m2))
;->  6  6  6
;-> 12 12 12
;-> 18 18 18
(print-matrix (multiply m1 m2))
;->   6  6  6
;->  12 12 12
;->  18 18 18

(setq m1 '((1 1 2) (0 1 -3)))
(setq m2 '((1 1 1) (2 5 1) (0 -2 1)))
(print-matrix (mult-mat m1 m2))
;-> 3  2  4
;-> 2 11 -2
(print-matrix (multiply m1 m2))
;-> 3  2  4
;-> 2 11 -2

(setq m1 '((1 1 1 1) (2 5 1 -1) (0 -2 1 -1)))
(setq m2 '((1 1 2) (0 1 -3) (1 1 2) (0 1 -3)))
(print-matrix (mult-mat m1 m2))
;-> 2  4 -2
;-> 3  7 -6
;-> 1 -2 11
(print-matrix (multiply m1 m2))
;-> 2  4 -2
;-> 3  7 -6
;-> 1 -2 11

(setq m1 '((1 1 1 1) (2 5 1 -1) (0 -2 1 -1)))
(setq m2 '((1 1 2) (0 1 -3) (1 1 2)))
(mult-mat m1 m2)
;-> nil
(multiply m1 m2)
;-> ERR: wrong dimensions in function multiply

La funzione "multiply" è una primitiva di newLISp che moltiplica due matrici.

(define (print-matrix matrix)
"Print a matrix m x n"
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
      (println))))

Funzioni che generano numeri casuali (interi e floating) in un intervallo:

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (+ min-val (rand (+ (- max-val min-val) 1))))

(define (rand-range-f min-val max-val)
"Generate a random float in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (add min-val (random 0 (sub max-val min-val))))

Funzione che crea due matrici casuali idonee per la moltiplicazione.
I parametri sono:
  max-row = numero massimo di righe
  max-col = numero massimo di colonne
  min-val = valore minimo dei numeri
  max-val = valore massimo dei numeri
  floating = true->floating, nil->integer

(define (make-matrix max-row max-col min-val max-val floating)
  (local (m1 m2 rows cols nums)
    ; first matrix m1
    (setq rows (+ (rand max-row) 1))
    (setq cols (+ (rand max-col) 1))
    (setq nums '())
    (if floating
      ; numeri casuali floating point
      (for (i 1 (* rows cols))
        (push (rand-range-f min-val max-val) nums -1)
      )
      ; else
      ; numeri casuali interi
      (for (i 1 (* rows cols))
        (push (rand-range min-val max-val) nums -1)
      )
    )
    (setq m1 (array rows cols nums))
    ; second matrix m2
    ; numero righe seconda matrice = numero colonne prima matrice
    (setq rows cols)
    (setq cols (+ (rand max-col) 1))
    (setq nums '())
    (if floating
      ; numeri casuali floating point
      (for (i 1 (* rows cols))
        (push (rand-range-f min-val max-val) nums -1)
      )
      ; else
      ; numeri casuali interi
      (for (i 1 (* rows cols))
        (push (rand-range min-val max-val) nums -1)
      )
    )
    (setq m2 (array rows cols nums))
    (list m1 m2)))

(print-matrix ((make-matrix 5 5 -10 10 true) 0))

Scriviamo una funzione di test.
Questa funzione crea due matrici casuali e le moltiplica con la nostra funzione "mult-mat" e con la funzione "multiply".
Se i risultati sono uguali restituisce true.
Se i risultati sono diversi, allora stampa un messaggio di errore e restituisce nil.

(define (test max-row max-col min-val max-val floating)
  (local (mm a b res1 res2)
    (setq mm (make-matrix max-row max-col min-val max-val floating))
    (setq a (mm 0))
    (setq b (mm 1))
    ; (print-matrix a) (print-matrix b)
    (setq res1 (multiply a b))
    (setq res2 (mult-mat a b))
    ;(print-matrix res1) (print-matrix res2)
    ; risultati diversi --> ERRORE --> nil
    (cond ((!= (multiply a b) (array-list (mult-mat a b)))
            (println "ERROR: ")
            (println "matrix A:")
            (println (print-matrix a))
            (println "matrix B:")
            (println (print-matrix b))
            (println "Result with multiply:")
            (println (print-matrix res1))
            (println "Result with mult-mat:")
            (println (print-matrix res1))
            nil)
          ; risultati uguali --> true
          (true true))))

Proviamo la funzione di test con matrici 10x10 al massimo e valori compresi tra -100 e 100:

(test 10 10 -100 100)
;-> true

(test 10 10 0 1 true)

Adesso possiamo scrivere la funzione di stress che applica la funzione "test" un determinato numero di volte:

(define (stress max-row max-col min-val max-val floating iter)
  (local (stop)
    ; inizializzazione generatore numeri casuali
    (seed (time-of-day))
    (setq stop nil)
    (dotimes (i iter stop)
      (if (not (test max-row max-col min-val max-val floating)) (setq stop true)
      (print "\r" i))
    )
    'end))

Test con numeri interi da -100 a 100 con matrici 100x100 max:

(stress 100 100 -100 100 nil  100)
;-> 99end
Test con numeri floating da -100 a 100 con matrici 100x100 max:

(stress 100 100 -100 100 true 100)
;-> 99end


---------------------------
Estrazione di sotto-matrici
---------------------------

Vediamo una funzione per estrarre una sottomatrice da una matrice.

Prima una funzione per stampare una matrice:

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    (setq digit (+ 1 lenmax))
    (setq fmtstr (append "%" (string digit) "s"))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

Adesso la funzione che estrae una sottomatrice:

Parameters | Parametri:
i: start row of matrix M | riga iniziale della matrice M
j: start column of matrix M | riga finale della matrice M
rows: number of rows to extract | numero di righe da estrare
cols: number of columns to extract | numero di colnne da estrarre

Se rows oppure cols non vengono passati, allora la funzione estrae tutta la sottomatrice a partire dalla cella M(i j).

(define (sub-matrix M i j rows cols)
  (local (sub-mat ic jc)
    ; no passing rows, cols then
    ; select all sub-matrix from M(i j)
    (if (= rows nil) (setq rows (- (length M) i)))
    (if (= cols nil) (setq cols (- (length (M 0)) j)))
    ;; no passing rows, cols and
    ;; if (rows + i) or (cols + j) exceed M dimension then
    ;; select all sub-matrix from M(i j)
    ;(if (or (= rows nil) (> (+ rows i) (length M)))
    ;    (setq rows (- (length M) i))
    ;)
    ;(if (or (= cols nil) (> (+ cols i) (length (M 0))))
    ;    (setq cols (- (length (M 0)) j))
    ;)
    ; create the result array (empty)
    (setq sub-mat (array rows cols '(0)))
    ; index for rows of sub-mat
    (setq ic 0)
    (for (rr i (+ rows i -1))
      ; index for cols of sub-mat
      (setq jc 0)
      (for (cc j (+ cols j -1))
        (setf (sub-mat ic jc) (M rr cc))
        (++ jc)
      )
      (++ ic)
    )
    ; restituisce una lista
    (array-list sub-mat)))

Proviamo la funzione:

(setq a '((1 2 3) (4 5 6) (7 8 9)))
(print-matrix a)
;-> 1 2 3
;-> 4 5 6
;-> 7 8 9
(print-matrix (sub-matrix a 1 1 1 2))
;-> 5 6
(print-matrix (sub-matrix a 0 0 3 1))
;-> 1
;-> 4
;-> 7
(print-matrix (sub-matrix a 0 0 3 3))
;-> 1 2 3
;-> 4 5 6
;-> 7 8 9
(sub-matrix a 1 1 3 3)
;-> ERR: invalid list index in function setf
;-> called from user function (sub-matrix a 1 1 3 3)

(setq b (array 6 4 (sequence 1 (* 6 4))))
(print-matrix b)
;->  1  2  3  4
;->  5  6  7  8
;->  9 10 11 12
;-> 13 14 15 16
;-> 17 18 19 20
;-> 21 22 23 24
(print-matrix (sub-matrix b 2 2 4 2))
;-> 11 12
;-> 15 16
;-> 19 20
;-> 23 24
(print-matrix (sub-matrix b 1 2 5 2))
;->  7  8
;-> 11 12
;-> 15 16
;-> 19 20
;-> 23 24
(print-matrix (sub-matrix b 3 2))
;-> 15 16
;-> 19 20
;-> 23 24
(print-matrix (sub-matrix b 0 0 2 2))
;-> 1 2
;-> 5 6

(print-matrix (setq A '((1 2 3 4 5 6 7 8)
                        (1 2 3 4 5 6 7 8)
                        (1 2 3 4 5 6 7 8)
                        (1 2 3 4 5 6 7 8)
                        (1 1 1 1 2 2 2 2)
                        (3 3 3 3 4 4 4 4)
                        (5 5 5 5 6 6 6 6)
                        (7 7 7 7 8 8 8 8))))
(print-matrix (setq A11 (sub-matrix A 0 0 4 4)))
(print-matrix (setq A12 (sub-matrix A 0 4 4 4)))
(print-matrix (setq A21 (sub-matrix A 4 0 4 4)))
(print-matrix (setq A22 (sub-matrix A 4 4 4 4)))
;->  1 2 3 4 5 6 7 8
;->  1 2 3 4 5 6 7 8
;->  1 2 3 4 5 6 7 8
;->  1 2 3 4 5 6 7 8
;->  1 1 1 1 2 2 2 2
;->  3 3 3 3 4 4 4 4
;->  5 5 5 5 6 6 6 6
;->  7 7 7 7 8 8 8 8
;->
;->  1 2 3 4
;->  1 2 3 4
;->  1 2 3 4
;->  1 2 3 4
;->
;->  5 6 7 8
;->  5 6 7 8
;->  5 6 7 8
;->  5 6 7 8
;->
;->  1 1 1 1
;->  3 3 3 3
;->  5 5 5 5
;->  7 7 7 7
;->
;->  2 2 2 2
;->  4 4 4 4
;->  6 6 6 6
;->  8 8 8 8


-----------------------
Unione di sotto-matrici
-----------------------

Vediamo una funzione per unire sue matrici.

Prima una funzione per stampare una matrice:

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    (setq digit (+ 1 lenmax))
    (setq fmtstr (append "%" (string digit) "s"))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

Adesso la funzione che unisce due matrici:

Parameters | Parametri:
A: first matrix | prima matrice
B: second matrix | seconda matrice
position: position of second matrix | posizione della seconda matrice

Il parametro "position" può avere 4 valori:

  "n" --> nord  (La matrice B a sopra la matrice A)
  deve risultare: numero colonne A = numero colonne B
  "s" --> sud   (La matrice B a sotto la matrice A)
  deve risultare: numero colonne A = numero colonne B
  "e" --> est   (La matrice B a destra della matrice A)
  deve risultare: numero righe A = numero righe B
  "o" --> ovest (La matrice B a sinistra della matrice A)
  deve risultare: numero righe A = numero righe B

(define (merge-matrix A B position)
  (local (out rowsA colsA rowsB colsB)
    (setq rowsA (length A))
    (setq colsA (length (A 0)))
    (setq rowsB (length B))
    (setq colsB (length (B 0)))
    (cond ((= position "n") ; B sopra A (nord) con (colsA == colsB)
            (setq out '())
            (dolist (r B) (push r out -1))
            (dolist (r A) (push r out -1)))
          ((= position "s") ; B sotto A (sud) con (colsA == colsB)
            (setq out '())
            (dolist (r A) (push r out -1))
            (dolist (r B) (push r out -1)))
          ((= position "e") ; B a destra di A (est) con (rowsA == rowsB)
            (dolist (r A)
              (push (append r (B $idx)) out -1)))
          ((= position "o") ; B a sinistra di A (ovest) con (rowsA == rowsB)
            (dolist (r A)
              (push (append (B $idx) r) out -1)))
    )
    out))

Proviamo la funzione:

(print-matrix (setq m1 '((1 2 3 4) (5 6 7 8))))
;-> 1 2 3 4
;-> 5 6 7 8
(print-matrix (setq m2 '((11 22 33 44) (55 66 77 88))))
;-> 11 22 33 44
;-> 55 66 77 88

(print-matrix (merge-matrix m1 m2 "e"))
;-> 1  2  3  4 11 22 33 44
;-> 5  6  7  8 55 66 77 88

(print-matrix (merge-matrix m1 m2 "o"))
;-> 11 22 33 44  1  2  3  4
;-> 55 66 77 88  5  6  7  8

(print-matrix (merge-matrix m1 m2 "n"))
;-> 11 22 33 44
;-> 55 66 77 88
;->  1  2  3  4
;->  5  6  7  8

(print-matrix (merge-matrix m1 m2 "s"))
;->  1  2  3  4
;->  5  6  7  8
;-> 11 22 33 44
;-> 55 66 77 88

(setq c11 '((1 2 3 4)
            (1 2 3 4)
            (1 2 3 4)
            (1 2 3 4)))
(setq c12 '((5 6 7 8)
            (5 6 7 8)
            (5 6 7 8)
            (5 6 7 8)))
(setq c21 '((1 1 1 1)
            (3 3 3 3)
            (5 5 5 5)
            (7 7 7 7)))
(setq c22 '((2 2 2 2)
            (4 4 4 4)
            (6 6 6 6)
            (8 8 8 8)))

(print-matrix (setq t1 (merge-matrix c11 c12 "e")))
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
(print-matrix (setq t2 (merge-matrix c21 c22 "e")))
;-> 1 1 1 1 2 2 2 2
;-> 3 3 3 3 4 4 4 4
;-> 5 5 5 5 6 6 6 6
;-> 7 7 7 7 8 8 8 8
(print-matrix (setq R (merge-matrix t1 t2 "s")))
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8
;-> 1 1 1 1 2 2 2 2
;-> 3 3 3 3 4 4 4 4
;-> 5 5 5 5 6 6 6 6
;-> 7 7 7 7 8 8 8 8


---------------------------------------
La leggenda della nascita degli scacchi
---------------------------------------

Tanto tempo fa, in India c'era un principe (Khusraw o Re Cosroe) le cui ricchezze erano tali che nulla gli mancava ed ogni suo desiderio poteva essere esaudito.
Mancandogli però in tal modo proprio ciò che l'uomo comune spesso ha, ovvero la bramosia verso un desiderio inesaudibile, il Principe trascorreva le giornate nell'ozio e nella noia.
Un giorno, stanco di tanta inerzia, annunciò a tutti che avrebbe donato qualunque cosa richiesta a colui che fosse riuscito a farlo divertire nuovamente.
A corte si presentò uno stuolo di personaggi d'ogni genere, eruditi saggi e stravaganti fachiri, improbabili maghi e spericolati saltimbanchi, sfarzosi nobili e zotici plebei, ma nessuno riuscì a rallegrare l'annoiato Principe.
Finché si fece avanti un mercante (Sissa), famoso per le sue invenzioni. Aprì una scatola, estrasse una tavola con disegnate alternatamente 64 caselle bianche e nere, vi appoggiò sopra 32 figure di legno variamente intagliate, e si rivolse al nobile reggente: "Vi porgo i miei omaggi, o potentissimo Signore, nonché questo gioco di mia modesta invenzione. L'ho chiamato il gioco degli scacchi".
Poi stese a terra un tappeto sul quale aveva disegnato un "reticolato" composto da 64 piccoli quadrati alternativamente bianchi e neri , poi estrasse via via delle statuine spiegando che rappresentavano schematicamente due eserciti contrapposti pronti alla battaglia.
La conformazione dell'esercito presentata dal mercante era ovviamente stabilita secondo la concezione  dell'epoca, quindi guerrieri a piedi, truppe a cavallo e su elefante, carri per il trasporto delle vettovaglie e delle salmerie e poi il sovrano con il suo generale.
Sistemò quei pezzi e cominciò a spiegare le regole del movimento di ciascuno e lo scopo del "gioco", che era evidentemente uccidere il re (lo scià) nemico.
Chi fosse riuscito avrebbe potuto gridare "Shah mat!", "il Re è morto!"
E proprio dall'espressione “Shah mat!” per assonanza deriverà “scacco matto!”.
Il Principe guardò perplesso il mercante e gli chiese spiegazioni sulle regole.
Il mercante gliele mostrò, sconfiggendolo in una partita dimostrativa.
Punto sull'orgoglio il Principe chiese la rivincita, perdendo nuovamente.
Fu alla quarta sconfitta consecutiva che capì il genio del mercante, accorgendosi per giunta che non provava più noia, ma un gran divertimento!
Memore della sua promessa, chiese all'inventore di tale sublime gioco quale ricompensa desiderasse. Il mercante, con aria dimessa, chiese un chicco di grano per la prima casella della scacchiera, due chicchi per la seconda, quattro chicchi per la terza, e via a raddoppiare fino all'ultima casella.
Stupito da tanta modestia, il Principe diede ordine affinché la richiesta del mercante venisse subito esaudita.
Gli scribi di corte si apprestarono a fare i conti, ma dopo qualche calcolo la meraviglia si stampò sui loro volti.
Il mercante infatti stava chiedendo 18.446.744.073.709.551.615 chicchi di grano, una quantità che avrebbe richiesto secoli di produzione.
Non potendo materialmente esaudire la richiesta dell'esoso mercante e non potendo neppure sottrarsi alla parola data, il Principe diede ordine di giustiziare immediatamente l'inventore degli scacchi.

Di questa leggenda appare un accenno anche nella Divina Commedia di Dante Alighieri, dove viene adoperata dal poeta per dare un'idea al lettore del numero degli Angeli presenti nei cieli:

       L'incendio suo seguiva ogne scintilla
         ed eran tante, che 'l numero loro
     più che 'l doppiar de li scacchi s'inmilla.
               Paradiso, XXVIII, 91-93

Il numero di chicchi di grano vale:

  2^64 - 1 = 18446744073709551615

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(- (** 2 64) 1)
;-> 18446744073709551615L

Ma quanto pesano tutti questi chicchi di grano?

Un chicco di grano pesa 0.04-0.06 grammi, quindi il peso totale è compreso tra:
> (mul 18446744073709551615L 0.04)
;-> 7.378697629483821e+017
> (div (mul 18446744073709551615L 0.04) 1e6)
;-> 737869762948.3821
Circa 737 miliardi e 869 milioni di tonnellate di grano.

(mul 18446744073709551615L 0.06)
;-> 1.106804644422573e+018
(div (mul 18446744073709551615L 0.06) 1e6)
;-> 1106804644422.573
Circa 1106 miliardi e 804 milioni di tonnellate di grano.

Nel 2020 la produzione mondiale di grano è stata di 760 milioni di tonnellate:

 1) CINA    (134254710 tonnellate)
 2) INDIA   (107590000 tonnellate)
 3) RUSSIA   (85896326 tonnellate)
 4) USA      (49690680 tonnellate)
 5) CANADA   (35183000 tonnellate)
 6) FRANCIA  (30144110 tonnellate)
 7) PAKISTAN (25247511 tonnellate)
 8) UCRAINA  (24912350 tonnellate)
 9) GERMANIA (22172100 tonnellate)
10) TURCHIA  (20500000 tonnellate)

Interessante notare che se venisse conteggiata la produzione di grano dell'Unione Europea come fosse un unico paese, con le sue 126658950 tonnellate (l'Italia ne ha prodotte 6716180 tonnellate), sarebbe il secondo produttore di grano del mondo.


----------------------
Quante cifre ha x^y^z?
----------------------

Quante cifre ha il massimo numero x^y^z quando x, y e z sono le cifre da 1 a 9?
Ovviamente il numero massimo vale 9^9^9, ma quante cifre ha?

Proviamo a scrivere una funzione che ci indica come vanno le cose con le prime cifre.

(define (pow-i num power)
"Calculates the integer power of an integer"
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))
        )
    )
    out))

Funzione che calcola x^y^z con x,y,z in (2..max-val):

(define (xyz max-val)
  (for (x 2L max-val)
    (for (y 2L max-val)
      (for (z 2L max-val)
        (println "x: " x { } "y: " y { } "z: " z { } "x^y^z: "
          (length (pow-i (bigint x) (pow-i (bigint y) (bigint z)))))))))

(xyz 6)
;-> x: 2 y: 2 z: 2 x^y^z: 2
;-> x: 2 y: 2 z: 3 x^y^z: 3
;-> x: 2 y: 2 z: 4 x^y^z: 5
;-> ...
;-> x: 6 y: 5 z: 5 x^y^z: 2432
;-> x: 6 y: 5 z: 6 x^y^z: 12159
;-> x: 6 y: 6 z: 2 x^y^z: 29
;-> x: 6 y: 6 z: 3 x^y^z: 169
;-> x: 6 y: 6 z: 4 x^y^z: 1009
;-> x: 6 y: 6 z: 5 x^y^z: 6051
;-> x: 6 y: 6 z: 6 x^y^z: 36306

Quindi 6^6^6 è un numero che ha 36306 cifre.

(time (println (length (pow-i 6L (pow-i 6L 6L)))))
;-> 39306
;-> 10.001

Proviamo a calcolare 7^7^7 (e quanto tempo ci vuole):

(time (println (length (pow-i 7L (pow-i 7L 7L)))))
;-> 695975
;-> 3515.933

Quindi 7^7^7 è un numero che ha 695975 cifre (calcolato in 3.5 secondi).

Non è possibile calcolare 8^8^8 perchè ci vuole troppo tempo.

Allora come facciamo a calcolare le cifre di 9^9^9?

Calcoliamo 9^9:

(setq a (pow-i 9L 9L))
;-> 387420489L

Calcoliamo il logaritmo in base 10 di 9:

(setq b (log 9 10))
;-> 0.9542425094393249

Moltiplichiamo a e b:

(setq c (mul a b))
;-> 369693099.6315703

Il numero il cui logaritmo in base 10 vale 369693099 è 10^369693099.
Questo numero ha 369693099 cifre.

Il numero il cui logaritmo in base 10 vale 369693100 è 10^369693100.
Questo numero ha 369693100 cifre.

Quindi il numero il cui logaritmo in base 10 vale 369693099.6315703 è più vicino a 10^369693100.
Quindi 10^369693100 ha 369693100 cifre.

Questo ci dice che:

  9^9^9 ≈ 10^369693100 è un numero con 369693100 cifre (quasi 370 milioni).

Verifichiamo questo metodo calcolando il numero di cifre di 7^7^7.

Calcoliamo 7^7^7:

(setq a (pow-i 7L 7L))
;-> 823543L

Calcoliamo il logaritmo in base 10 di 7:

(setq b (log 7 10))
;-> 0.8450980400142567

Moltiplichiamo a e b:

(setq c (mul a b))
;-> 695974.575167461

Quindi il numero il cui logaritmo in base 10 vale 695974.575167461 è più vicino a 10^695975.
Quindi 10^695975 ha 695975 cifre.

Questo ci dice che:

  7^7^7 ≈ 10^695975 è un numero con 695975 cifre (quasi 696 mila).

Il risultato è uguale a quello calcolato direttamente:

(length (pow-i 7L (pow-i 7L 7L)))
;-> 695975

Vediamo l'ultimo caso rimasto 8^8^8:
(setq a (pow-i 8L 8L))
;-> 16777216L
(setq b (log 8 10))
;-> 0.9030899869919434
(setq c (mul a b))
;-> 15151335.77920103

Quindi:

  8^8^8 ≈ 10^15151336 è un numero con 15151336 cifre (più di 15 milioni).


-------------------------
La funzione "unget" del C
-------------------------

Nella programmazione C prendere il carattere successivo di un file file viene eseguita la funzione "gets":

  ch = getc(infile)

Comunque possiamo riportare il carattere "indietro" con la funzione "ungetc":

  ungetc(ch, infile)

In questo modo la prossima "getc" ritorna lo stesso carattere.

In newLISP la funzione "getc" si chiama "raad-char", comunque non esiste una funzione primitiva analoga a "ungetc".

Comunque la seguente funzione "unread-char" si comporta come "ungetc":

(define (unread-char file) (seek file (- (seek file) 1)))

Si noti che la funzione ritornerà alla fine del file quando viene raggiunto l'inizio (posizione 0).


-----------------------------------------------------
Cartella corrente/lavoro - Current/Working directory
-----------------------------------------------------

Percorso della cartella corrente con la primitiva newLISP "real-path":

(real-path)
;-> "F:\\Lisp-Scheme\\newLisp\\MAX\\newLISP-NoteNEW"

Percorso della cartella corrente con una funzione di Windows:

;;
;;  cwd
;;  return the current working directory (Windows)
;;  by Sammo
;;  In the Windows API the maximum length for a path is 260 characters.
;;  It is structured as follows: Drive letter, colon, backslash
;;  components separated by backslashes and a null-terminating character 
;;  (eg. "D:\<256 chars>NUL"), which restricts the path to 256 characters.
;;
(import "kernel32.dll" "GetCurrentDirectoryA")
(define (cwd , buff bufflen)
    (setq bufflen 260)
    ;(setq buff (allocate bufflen))
    (setq buff (string ""))
    (GetCurrentDirectoryA bufflen buff)
    (string buff))

(cwd)
;-> "F:\\Lisp-Scheme\\newLisp\\MAX\\newLISP-NoteNEW"

=============================================================================

