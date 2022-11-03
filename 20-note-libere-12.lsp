================

 NOTE LIBERE 12

================

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

;-> Prossimo numero:
;-> 81
;-> cartella 1: (5 10 26 64 83)
;-> cartella 2: (13 30 41 73)
;-> cartella 3: (7 12 21 46 89)
;-> cartella 4: (27 42 53 65 85)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (9 11 39 63 90)
;-> Prossimo numero:
;-> 74
;-> cartella 1: (5 10 26 64 83)
;-> cartella 2: (13 30 41 73)
;-> cartella 3: (7 12 21 46 89)
;-> cartella 4: (27 42 53 65 85)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (9 11 39 63 90)
;-> Prossimo numero:
;-> 67
;-> cartella 1: (5 10 26 64 83)
;-> cartella 2: (13 30 41 73)
;-> cartella 3: (7 12 21 46 89)
;-> cartella 4: (27 42 53 65 85 3 48 67 77 87 15 29 33 59 79)
;-> cartella 5: (2 17 24 35 66)
;-> cartella 6: (9 11 39 63 90)


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

=============================================================================

