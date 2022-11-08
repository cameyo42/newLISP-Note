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

Equagliamo a zero la derivata per calcolare il minimo:

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
  (let (conta 0)
    (for (i 1 iter)
      (if (or (= (apply + (rand 2 n)) n)  ; tutti 1?
              (= (apply + (rand 2 n)) 0)) ; tutti 0?
          (++ conta)
      )
    )
    (div conta iter)))

(ants 3 1e6)
;-> 0.234201
(ants 5 1e6)
;-> 0.061411
(ants 12 1e6)
;-> 0.000484

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

=============================================================================

