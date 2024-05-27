==========

 LIBRERIE

==========

===================================
 OPERAZIONI CON I NUMERI COMPLESSI
===================================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con i numeri complessi.
Possiamo scrivere alcune funzioni per supportare alcuni calcoli con questi numeri.
Ogni numero complesso (a + ib), dove a = parte_reale e b = parte_immaginaria o complessa, viene rappresentato con una lista (a b).
Per esempio, il numero (2 + i3) viene rappresentata dalla lista (2 3).

Definiamo due funzioni che estraggono la parte reale e quella immaginaria di un numero complesso:

Funzione estrazione parte reale "re"
------------------------------------
(define (re num) (first num))

Funzione estrazione parte immaginaria "im"
------------------------------------------
(define (im num) (last num))

(setq n1 '(3 -12))
(setq n2 '(-2 8))

(re n1)
;-> 3

(im n2)
;-> 8

I numeri complessi possono essere rappresentati in due modi:
1) forma cartesiana (o algebrica) -->  (a + ib)
2) forma esponenziale             -->  |z|*e^it (dove z = modulo, t = angolo)

Vediamo le formule che permettono di trasformare un numero complesso tra le due forme:

Cartesiana --> Esponenziale
Dato il numero complesso z = a + ib:

|z| = sqrt(a^2 + b^2)

    +arccos(a/|z|)   se b >= 0
t =
    -arccos(a/|z|)   se b < 0

Esponenziale --> Cartesiana
Dato il numero complesso z = |z|*e^it:

a = Re(z) = |z|*cos(t)
b = Im(z) = |z|*sin(t)

Adesso dobbiamo scrivere due funzioni che convertono un numero complesso tra le due forme cartesiana ed esponenziale. Anche il numero complesso in forma esponenziale può essere rappresentato da una lista con due valori:

 |z|e^it  -->  (z t)

dove z è il valore del modulo e t è il valore dell'angolo.

Anche in questo caso scriviamo due funzioni che estraggono il modulo e l'angolo da un numero complesso in forma esponenziale:

Funzione estrazione modulo "|z|"
------------------------------------
(define (z num) (first num))

Funzione estrazione angolo "t"
------------------------------------------
(define (t num) (last num))

Inoltre utilizziamo anche la costante di Eulero e la costante pi greco:

(constant '*e*  2.7182818284590451)
(constant '*pi* 3.1415926535897931)

Adesso possiamo scrivere le funzioni di conversione tra le due forme:

Conversione Cartesiana --> Esponenziale
---------------------------------------

(define (ccx2ecx num)
  (let (z (sqrt (add (mul (re num) (re num)) (mul (im num) (im num)))))
       (list z
             (if (< (im num) 0)
                 (acos(div (re num) z))
                 (sub 0 (acos(div (re num) z)))
             )
       )
  )
)

cartesiana: sqrt(3) + 1i

(setq num (list (sqrt 3) 1))
;-> (1.732050807568877 1)

(ccx2ecx num)
;-> (2 -0.5235987755982987)

esponenziale: 2*e^-0.5235987755982987i
(dove -0.5235987755982987 = *pi*/6)

(div *pi* 6)
;-> 0.5235987755982988

Conversione Esponenziale --> Cartesiana
---------------------------------------

(define (ecx2ccx num)
  (list (mul (z num) (cos (t num)))
        (mul (z num) (sin (t num))))
)

esponenziale: 2*e^-0.5235987755982987i

(setq num (list 2 -0.5235987755982987))
;-> (2 -0.5235987755982987)

(ecx2ccx num)
;-> (1.732050807568877 -0.9999999999999997)

cartesiana: 1.732050807568877 -0.9999999999999997i
(dove 1.732050807568877 = sqrt(3))

(sqrt 3)
;-> 1.732050807568877

Siamo pronti per scrivere le funzioni di base per la gestione di calcoli con i muneri complessi:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) reciproco (o inverso)
6) potenza

Addizione di due numeri complessi "+cx"
---------------------------------------

(define (+cx n1 n2)
  (list (add (re n1) (re n2)) (add (im n1) (im n2)))
)

(+cx n1 n2)
;-> (1 -4)

Sottrazione di due numeri complessi "-cx"
-----------------------------------------

(define (-cx n1 n2)
  (list (sub (re n1) (re n2)) (sub (im n1) (im n2)))
)

(-cx n1 n2)
;-> (5 -20)

Moltiplicazione di due numeri complessi "*cx"
---------------------------------------------

(define (*cx n1 n2)
  (list (sub (mul (re n1) (re n2)) (mul (im n1) (im n2)))
        (add (mul (im n1) (re n2)) (mul (re n1) (im n2))))
)

(*cx n1 n2)
;-> (90 48)

(*cx n2 n1)
;-> (90 48)

Divisione di due numeri complessi "/cx"
---------------------------------------

(define (/cx n1 n2)
  (if (and (zero? (re n2)) (zero? im n2))
    (list nil nil())
    (list (div (add (mul (re n1) (re n2)) (mul (im n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2))))
          (div (sub (mul (im n1) (re n2)) (mul (re n1) (im n2)))
               (add (mul (re n2) (re n2)) (mul (im n2) (im n2)))))
  )
)

(/cx n1 n2)
;->(-1.5 0)

(/cx n2 n1)
;->

Reciproco di un numero complesso "|cx"
-------------------------------------

Il reciproco (o l'inverso) di un numero complesso z = a + i b ≠ 0 è quel numero che moltiplicato per z ha come risultato 1.

(define (|cx n)
  (if (and (= (re n) 0) (= (im n) 0))
      ; (list (nil nil)
      (list (div 1 0) (div 1 0))
      (list (div (re n) (add (mul (re n) (re n)) (mul (im n) (im n))))
            (div (sub 0 (im n)) (add (mul (re n) (re n)) (mul (im n) (im n))))))
)

(setq n '(3 4))
(add (mul (re n) (re n)) (mul (im n) (im n)))

(|cx '(3 4))
;-> (0.12 -0.16)

(*cx '(3 4) '(0.12 -0.16))
;-> (1 0)

Potenza di un numero complesso "^cx"
------------------------------------

(define (^cx n p)
  (cond ((zero? p) (if (= 0 (re n)) (list 0 0) (list 1 0))) ;potenza nulla
        ((= p 1) (list (re n) (im n))) ;potenza uguale ad 1
        ((> p 1) ;potenza positiva maggiore di 1
          (setq t n)
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (list (re t) (im t))
        )
        ((< p 0) ;potenza negativa
          (setq t n)
          (setq p (abs p))
          (for (i 1 (sub p 1))
            (setq t (*cx (list (re t) (im t)) (list (re n) (im n))))
          )
          (|cx (list (re t) (im t))) ; calcolo numero inverso
        )
  )
)

(^cx '(4 2) 2)
;-> (12 16)

(^cx '(4 2) -2)
;-> (0.03 -0.04)

(^cx '(12 16) -2)
;-> (-0.0007 -0.0024)


============================
 OPERAZIONI CON LE FRAZIONI
============================

newLISP non fornisce alcun tipo di numeri e operazioni per gestire i calcoli con le frazioni.
Possiamo scrivere alcune funzioni per supportare il calcolo frazionario con numeri interi.

Ogni frazione numeratore e denominatore (N/D) viene rappresentata con una lista (N D).
Per esempio, la frazione 2/3 viene rappresentata dalla lista (2 3).
Prima di tutto scriviamo una funzione che semplifica una frazione (in altre parole, riduce una frazione ai minimi termini):

Funzione che semplifica una frazione "semplifica"
-------------------------------------------------

(define (semplifica frac)
  (local (num den n d temp, nums dens)
    (setq num (first frac))
    (setq den (last frac))
    (setq n (first frac))
    (setq d (last frac))
    ; calcola il numero massimo che divide esattamente numeratore e denominatore
    (while (!= d 0)
      (setq temp d)
      (setq d (% n temp))
      (setq n temp)
    )
    (setq nums (/ num n))
    (setq dens (/ den n))
    ; controllo del segno
    (cond ((or (and (< dens 0) (< nums 0)) (and (< dens 0) (> nums 0)))
           (setq nums (* nums -1))
           (setq dens (* dens -1))
          )
    )
    (list nums dens)
  )
)

(semplifica '(4 8))
;-> (1 2)

(semplifica '(1000 2500))
;-> (2 5)

(semplifica '(-2 -4))
;-> (1 2)

(semplifica '(-2 4))
;-> (-1 2)

Adesso possiamo scrivere le funzioni per le quattro operazioni.

Funzione che somma due frazioni "+f"
------------------------------------

(define (+f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (+ (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

Se l'argomento "redux" vale true, allora il risultato non viene semplificato.

(+f '(3 4) '(2 3))
;-> (17 12)

(+f '(2 4) '(2 3))
;-> (7 6)

(+f '(2 4) '(2 3) true)
;-> (14 12)

(+f '(10 100) '(40 100))
;-> (1 2)

Funzione che sottrae due frazioni "-f"
--------------------------------------

(define (-f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (- (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(-f '(12 13) '(13 13))
;-> (-1 13)

(-f '(-12 -13) '(-13 -13))
;-> (-1 13)

(+f '(-12 -13) '(-14 -13) true)
;-> (338 169)

(+f '(-12 -13) '(-14 -13))
;-> (2 1)

Funzione che moltiplica due frazioni "*f"
-----------------------------------------

(define (*f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 n2))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(*f '(3 6) '(3 5))
;-> (3 10)

(*f '(-3 6) '(3 5) true)
;-> -9 30)

Funzione che divide due frazioni "/f"
-------------------------------------

(define (/f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 d2))
    (setq den (* d1 n2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(/f '(2 4) '(1 -3))
;-> (-3 2)

(/f '(2 4) '(3 2) true)
;-> (4 12)

Funzione che calcola la potenza di una frazione "^f"
----------------------------------------------------

(define (^f frac power redux)
  (local (num den n d)
    (setq n (first frac))
    (setq d (last frac))
    (setq num (int (pow n power)))
    (setq den (int (pow d power)))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(^f '(3 4) 4)
;-> (81 256)

(^f '(3 5) 2)
;-> (9 25)

Sul forum di newLISP, rickyboy ha fornito le seguenti funzioni equivalenti (che sono molto più compatte e veloci):

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (rat (+ (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (-rat r1 r2)
  (rat (- (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (*rat r1 r2)
  (rat (* (r1 0) (r2 0))
       (* (r1 1) (r2 1))))

(define (/rat r1 r2)
  (rat (* (r1 0) (r2 1))
       (* (r1 1) (r2 0))))

Per generalizzare le funzioni che abbiamo scritto, dobbiamo permettere che queste siano in grado di gestire un numero variabile di argomenti (attualmente possiamo passare solo due frazioni alle nostre funzioni).
Usiamo le seguenti funzioni per estrarre il numeratore e il denominatore da una frazione (num den):

Numeratore di (num den)
-----------------------
(define (numf f) (first f))

Denominatore di (num den)
-------------------------
(define (denf f) (last f))

Poi riscriviamo la funzione che semplifica (riduce ai minimi termini) una frazione:

(define (redux f)
  (local (num den)
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Testiamo la funzione "redux":

(redux '(-30 5))
;-> (-6 1)

(redux '(-30 -5))
;-> (6 1)

(redux '(30 -5))
;-> (-6 1)

(redux '(30 5))
;-> (6 1)

Adesso riscriviamo (in modo più conciso) la funzione che somma due frazioni:

(define (+f-aux f1 f2)
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
)

Si tratta di una funzione (ausiliaria) che prende come parametro due frazioni.
Adesso scriviamo una macro che permette di applicare la funzione "+f-aux" ad un numero qualunque di frazioni:

(define-macro (+f)
  ; somma tutte le frazioni passate come argomento a due a due
  (apply +f-aux (map eval (args)) 2))

Nota:
L'espressione (apply +f-aux (map eval (args)) 2) permette di chiamare la macro "+f" con gli argomenti quotati (es. (+f '(1 2) '(1 2) '(1 2))).
Se avessimo scritto (apply +f-aux (args) 2) dovremmo chiamare la macro "+f" con gli argomenti non quotati (es. (+f (1 2) (1 2) (1 2))).
Questo è dovuto al fatto che le macro non valutano gli argomenti, quindi è necessario utilizzare la funzione "eval" per valutare gli argomenti.
Vediamo un esempio:

(define-macro (a)
  (args))

(a (1 2) (1 2) (1 2))
;-> ((1 2) (1 2) (1 2))

(define-macro (a)
  (map eval (args)))

(a '(1 2) '(1 2) '(1 2))
;-> ((1 2) (1 2) (1 2))

Adesso possiamo testare la nostra nuova funzione "f+":

(+f '(1 2) '(1 3))
;-> (5 6)

(+f '(1 2) '(1 2) '(1 2))
;-> (3 2)

(+f '(20 2) '(-1 -2) '(1 2))
;-> (11 1)

Riscriviamo tutte le funzioni che operano sulle frazioni:
1) addizione
2) sottrazione
3) moltiplicazione
4) divisione
5) potenza

Funzioni varie
--------------

;numeratore di (num den)
(define (numf f) (first f))

;denominatore di (num den)
(define (denf f) (last f))

;riduzione minimi termini
(define (redux f)
  (local (num den)
    (setq num (/ (numf f) (gcd (numf f) (denf f))))
    (setq den (/ (denf f)  (gcd (numf f) (denf f))))
    (cond ((or (and (< den 0) (< num 0)) (and (< den 0) (> num 0)))
            (setq num (* num -1))
            (setq den (* den -1)))
    )
    (list num den)
  )
)

Addizione frazioni "+f"
-----------------------

;ausiliaria
(define (+f-aux f1 f2)
  (redux (list (+ (* (numf f1) (denf f2)) (* (numf f2) (denf f1)))
               (* (denf f1) (denf f2))))
)

;Addiziona tutte le frazioni passate come argomento a due a due
(define-macro (+f)
  (apply +f-aux (map eval (args)) 2))


========================
 OPERAZIONI CON I TEMPI
========================

In questo capitolo definiremo due funzioni che permettono di addizionare e sottrarre due o più tempi.
Un valore tempo viene definito in ore, minuti, secondi e lo rappresenteremo con una lista con tre valori (h m s). Ad esempio, il tempo 3 ore, 34 minuti e 20 secondi è rappresentato dalla lista (3 34 20). Cominciamo con la funzione che somma due tempi.

Addizione di due tempi "+t"
---------------------------

Definiamo alcune funzioni di estrazione delle ore, minuti e secondi da un tempo:

(define (hh t) (first t))
(define (mm t) (first (rest t)))
(define (ss t) (last t))

Definiamo una funzione che normalizza il tempo, cioè controlla e ricalcola i tempi che hanno valori di minuti e/o secondi maggiori o uguali a 60.

(define (redux-t t)
  (local (h m s)
    (setq h (hh t)) (setq m (mm t)) (setq s (ss t))
    ; normalizza secondi (il valore dei secondi deve essere minore di 60)
    (while (>= s 60) (setq s (sub s 60)) (++ m))
    ; normalizza minuti (il valore dei minuti deve essere minore di 60)
    (while (>= m 60) (setq m (sub m 60)) (++ h))
    (list h m s)
  )
)

(redux-t '(0 6000 12000))
;-> (103 20 0)

Nota: la funzione "redux-t" non riduce valori negativi

; redux-t non riduce valori negativi
(redux-t '(0 -61 0))
;-> (0 -61 0)

(define (+t t1 t2)
  (local (h m s ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    (setq h (add (hh t1) (hh t2)))
    (setq m (add (mm t1) (mm t2)))
    (setq s (add (ss t1) (ss t2)))
    (redux-t (list h m s))
  )
)

(+t '(10 60 60) '(10 30 30))
;-> (21 31 30)

(+t '(60 1200 1200) '(60 120 300))
;-> (142 25 0)

Adesso definiamo la funzione che sottrae due tempi (un pò più complicata).

Sottrazione di due tempi "+t"
-----------------------------

(define (-t t1 t2)
  (local (h m s h1 m1 s1 h2 m2 s2 ch)
    ; riduzione dei tempi ai minimi termini
    (setq t1 (redux-t t1))
    (setq t2 (redux-t t2))
    ; estrazione ore (h), minuti (m), secondi (s)
    (setq h1 (hh t1)) (setq m1 (mm t1)) (setq s1 (ss t1))
    (setq h2 (hh t2)) (setq m2 (mm t2)) (setq s2 (ss t2))
    ; trova il tempo maggiore
    (if (< (add s1 (mul m1 1000) (mul h1 10000))
           (add s2 (mul m2 1000) (mul h2 10000)))
        (begin (swap h1 h2) (swap m1 m2) (swap s1 s2) (setq ch true))
    )
    ; sottrazione dei tempi
    (if (<= s2 s1) (setq s (sub s1 s2))
        (begin (setq s (add 60 (sub s1 s2))) (++ m2))
    )
    (if (<= m2 m1) (setq m (sub m1 m2))
        (begin (setq m (add 60 (sub m1 m2))) (++ h2))
    )
    (setq h (sub h1 h2))
    ; se abbiamo scambiato i due tempi (perchè il primo tempo era minore)
    ; allora cambiamo il segno delle ore o dei minuti o dei secondi
    (if (= ch true)
      (begin
        (setq h (sub 0 h))
        (if (= h 0) (setq m (sub 0 m)))
        (if (and (= h 0) (= m 0) (setq s (sub 0 s))))
      )
    )
    ; risultato
    (list h m s)
  );local
)

(redux-t '(150 300 200))
;-> (155 3 20)

(redux-t '(120 130 201))
;-> (122 13 21)

(-t '(155 3 20) '(122 13 21))
;-> (32 49 59)

(-t '(150 300 200) '(120 130 201))
;-> (32 49 59)

(-t '(120 130 201) '(150 300 200))
;-> (-32 49 59)

(-t '(24 58 2) '(24 58 1))
;-> (0 0 1)

(-t '(24 58 1) '(24 58 2))
;-> (0 0 -1)

(-t '(24 58 1) '(24 59 2))
;-> (0 -1 1)

(-t '(-3 0 0) '(-2 0 0))
;-> (-1 0 0)

(-t '(0 0 -1) '(0 0 -2))
;-> (0 0 1)

(+t '(0 0 -1) '(0 0 -2))
;-> (0 0 -3)

Adesso definiamo due macro che ci permettono di sommare o sottrarre un numero qualsiasi di tempi:

Addizione tempi "+tt"
---------------------

(define-macro (+tt)
  ; somma tutte i tempi passati come argomento a due a due
  (apply +t (map eval (args)) 2))

(+tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (7 1 0)

Sottrazione tempi "-tt"
-----------------------

(define-macro (-tt)
  ; sottrae tutti i tempi passati come argomento a due a due
  (apply -t (map eval (args)) 2))

(-tt '(2 20 20) '(2 20 20) '(2 20 20))
;-> (-2 20 20)

(+tt '(1 20 40) '(0 20 40) '(1 0 0))
;-> (2 41 20)

(-tt '(1 20 30) '(1 20 35) '(0 0 5))
;-> (0 0 -10)

(+tt '(0 0 -5) '(0 0 5))
;-> (0 0 0)

(-tt '(2 20 30) '(2 20 35))
;-> (0 0 -5)

(-tt '(2 20 30) '(2 20 35) '(0 0 5))
;-> (0 0 -10)


============================
 OPERAZIONI CON GLI INSIEMI
============================

newLISP fornisce alcune funzioni per operare sugli insiemi (set).
Vediamo quali sono e come implementare le funzioni che mancano (alcune di queste funzioni sono prese dal libro "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015).

Definiamo due insiemi (liste) per i test:

 (setq A '(a b c d e))

 (setq B '(a c e f g))

;------------------------------------------------------
; intersect (built-in)
;------------------------------------------------------
sintassi 1: (intersect list-A list-B)
sintassi 2: (intersect list-A list-B bool)
output: list

Nella prima sintassi, ritorna una lista che contiene una copia di ogni elemento che si trova sia nella list-A che nella list-B.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5))
;-> (2 4 1)

Nella seconda sintassi, ritorna una lista con tutti gli elementi della list-A che si trovano anche nella list-B, senza eliminazione dei duplicati della list-A.
bool è un espressione che deve essere true o nil.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) true)
;-> (1 2 4 2 1)

(intersect '(3 0 1 3 2 3 4 2 1) '(1 4 2 5) nil)
;-> (1 2 4)

;------------------------------------------------------
; intersects
;------------------------------------------------------
sintassi: (intersects list-1 list-2 ... list-N)
output: list

Ritorna una lista che contiene una copia di ogni elemento che si trova sia nella list-1 che nella list-2... che nella lista N.

(define (intersects)
  (let (tmp (intersect (args 0)))
    (doargs (arg)
      (setq tmp (intersect tmp arg)))
    tmp))

(setq a1 '(1 2 3 4 5))
(setq b1 '(4 5))
(setq c1 '(5 6 7 8))

(intersects a1 b1 c1)
;-> (5)

;------------------------------------------------------
; difference (built-in)
;------------------------------------------------------
sintassi 1: (difference list-A list-B)
sintassi 2: (difference list-A list-B bool)
output: list

Questa funzione mantiene l'ordine degli elementi della lista originale.

Nella prima sintassi, restituisce la differenza tra gli insieme list-A e list-B.
La lista risultante ha solo gli elementi che si trovano nella list-A, ma non nella list-B.
Tutti gli elementi della lista risultante sono unici, ma le liste possono anche essere non uniche
Gli elementi della lista possono essere qualunque espressione lisp.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1))
;-> (5 6 0)
(difference '(1 1 2 3 4) '(2 4 6 8))
;->  (1 3)
(difference '(1 1 2 3 4) '(2 4 6 8) true)
;-> (1 1 3)

Nella seconda sintassi, la differenza funziona in modalità lista
bool è un espressione che deve essere true o nil.
Nelle lista risultante, tutti gli elementi di list-B sono eliminati nella list-A, ma i duplicati che si trovano nella list-A vengono mantenuti.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) true)
;-> (5 6 0 5 0)

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) nil)
;-> (5 6 0)

;------------------------------------------------------
; unique (built-in)
;------------------------------------------------------
sintassi: (unique list)
output: list

Restituisce una lista in cui tutti i duplicati vengono rimossi.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(unique '(2 3 4 4 6 7 8 7))
;-> (2 3 4 6 7 8)

La lista può essere non ordinata, ma una lista ordinata rende il calcolo più veloce.

;------------------------------------------------------
; union (built-in)
;------------------------------------------------------
sintassi: (union list-1 list-2 [list-3 ... ])
output: list

Restituisce una lista con tutti i valori diversi trovati nelle liste passate come argomento.
Questa funzione mantiene l'ordine degli elementi della lista originale.

(union '(1 3 1 4 4 3) '(2 1 5 6 4))
;-> (1 3 4 2 5 6)

;------------------------------------------------------
; belongs?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (belongs? x A)
output: boolean

Restituisce true se un elemento x appartiene all'insieme A (nil altrimenti).

(define (belongs? x A)
  (if (or (intersect (list x) A) (= x '())) ;() is always a subset
    true nil))

(belongs? 'a '(a b c d e))
;-> true
(belongs? '() '(a b c d e))
;-> true

;------------------------------------------------------
; subset?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi (subset? A B)
output: boolean

Restituisce true se l'insieme A è sottoinsieme dell'insieme B (nil altrimenti).

(define (subset? A B)
  (if (or (= A (intersect A B)) (= A '())) ;() is always a subset
    true nil))

(subset? '(a b c d e) '(a c e f g))
;-> nil
(subset? '(a b c d e) '(a b c d e))
;-> true

;------------------------------------------------------
; cardinality
;"A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (cardinality A)
output: integer

Restituisce la cardinalità (numero degli elementi) di un insieme.

(define (cardinality S)
  (length S)
)

;------------------------------------------------------
; equivalent?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (equivalent? A B)
output: boolean

Restituisce true se due insiemi sono equipotenti, cioè se hanno lo stesso numero di elementi (nil altrimenti).

(define (equivalent? A B)
  (if (= (cardinality A) (cardinality B)))
)

;------------------------------------------------------
; idem?
;------------------------------------------------------
sintassi: (idem? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi nello stesso ordine (nil altrimenti).

(define (idem? A B)
  (if (= A B))
)

;------------------------------------------------------
; equal?
;------------------------------------------------------
sintassi: (equal? A B)
output: boolean

Restituisce true se due insiemi hanno gli stessi elementi, anche in ordine diverso (nil altrimenti).

(define (equal? A B)
  (if (= (sort A) (sort B)))
)

(setq A '(a b c))
(setq B '(a c b))
a

(equal? '(a b c) '(b a c))
(equal? A B)
(sort B)
B

;------------------------------------------------------
; disjoint?
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (disjoint? A B)
output: boolean

Restituisce true se due insiemi non hanno elementi in comune (nil altrimenti).

(define (disjoint? A B)
  (if (= (intersect A B) '()))
)

;------------------------------------------------------
; complement
; "A Practical Introduction to Fuzzy Logic using Lisp", Luis Argüelles Mendez, 2015
;------------------------------------------------------
sintassi: (complement A U)
output: list

Restituisce il complemento di un insieme rispetto all'insieme universo U.

(define (complement A U, lU i set-out)
  (setq set-out '())
  (setq lU (cardinality U))
  (setq i 0)
  (while (< i lU)
    (if (!= (belongs? (nth i U) A) true)
      (setq set-out (cons (nth i U) set-out))
    )
    (++ i) ;this is equivalent to (setq i (+ 1 i))
  );end while
  (reverse set-out)
)

(setq U '(a b c d e f g h))
(setq A '(c d e b h g))

(complement A U)
;-> (a f)

(difference U A) it is the same
;-> (a f)

;------------------------------------------------------
; cartesian-product
;------------------------------------------------------
sintassi: (cartesian-product A B)
output: list

Restituisce il prodotto cartesiano di due insiemi.

; iterative
(define (cartesian-product A B , lA lB i j set-out)
  (setq lA (cardinality A))
  (setq lB (cardinality B))
  (setq i 0 j 0) ;initializes i and j at the same time to zero
  (setq set-out '())
  (while (< i lA)
    (while (< j lB)
    (setq set-out (cons (list (nth i A) (nth j B)) set-out))
      (++ j) ;equivalent to (setq j (+ 1 j))
    );end while j
    (++ i) ;equivalent to (setq i (+ 1 i))
    (setq j 0) ;reinitializes j
  );end while i
  (reverse set-out)
)

(cartesian-product '(a b) '(a c))
;-> ((a a) (a c) (b a) (b c))
(cartesian-product '(a b) '(a b c))
;-> ((a a) (a b) (a c) (b a) (b b) (b c))

; recursive
(define (cart-one x lst)
  (cond
   ((null? lst) '())
   (true (cons (list x (first lst))
               (cart-one x (rest lst))))))

(dist-one 'b '(x y z))
;-> ((b x) (b y) (b z))

(define (cartesian A B)
  (cond
    ((null? A) '())
    (true (append (cart-one (first A) B)
              (cartesian (rest A) B)))))

(cartesian '(a b) '(x y z))
;-> ((a x) (a y) (a z) (b x) (b y) (b z))

;------------------------------------------------------
; powerset
;------------------------------------------------------
sintassi: (powerset A)
output: list

Restituisce l'insieme potenza di un insieme.

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c d))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())


=================
 FUNZIONI WINAPI
=================

Esempio di alcune funzioni che utilizzano le libreria di windows:

(context 'Win32API)

(import "user32.dll" "MessageBoxA")
(import "kernel32.dll" "GetShortPathNameA")
(import "kernel32.dll" "GetLongPathNameA")
(import "shell32.dll" "ShellExecuteA")

(define PATH_MAX 512)

(context MAIN)

;(define NULL 0)

(define (message-box text (title "newLISP"))
  (let ((MB_OK 0))
    (Win32API:MessageBoxA 0 text title MB_OK)))

(define (get-short-path-name pathname)
  (unless (file? pathname)
    (throw-error (list "No such file or directory" pathname)))
  (setq pathname (real-path pathname)) ; to fullpath
  (letn ((len Win32API:PATH_MAX)
         (buf (dup (char 0) (+ len 1)))
         (ret (Win32API:GetShortPathNameA pathname buf len)))
    (slice buf 0 ret)
    ;; (GetShortPathNameA pathname buf len) (get-string buf)
    ))

(define (get-longpathname pathname)
  (letn ((len Win32API:PATH_MAX)
         (buffer (dup (char 0) (+ len 1)))
         (r (Win32API:GetLongPathNameA pathname buffer len)))
    (if (= r 0) (throw-error '("GetLongPathNameA" "failure")))
    (slice buffer 0 r)))

(define (shell-execute app)
  (let ((SW_SHOWNORMAL 1) e)
    (setf e (Win32API:ShellExecuteA 0 "open" app 0 0 SW_SHOWNORMAL))
    ;(if (< e 32) )
    ))
;(shell-execute "C:\\PROGRA~1\\newLISP\\newLISP.exe")
;(shell-execute "C:/")
(shell-execute "http://www.newLISP.org/")

(context MAIN)
;;; EOF


==================================
 OPERAZIONI CON GLI ALBERI BINARI
==================================

Terminologia
------------

Un albero è un insieme finito di nodi tali che:
- esiste un nodo speciale chiamato "root" (radice)
- i nodi rimanenti sono partizionati in (n >= 0) insiemi disgiunti T(1)...T(n), dove ogni T(i) è un "sub-tree" (sotto-albero) della radice.

       radice
        /|\
       / | \
      /  |  \
     /   |   \
    /    |    \
  T(1) T(2)..T(n)

Supponiamo di avere il seguente albero:

              A                livello 1     altezza 0
             /|\
            / | \
           /  |  \
          /   |   \
         /    |    \
        B     C     D          livello 2     altezza 1
       / \    |    /|\
      /   \   |   / | \
     E     F  G  H  I  J       livello 3     altezza 2
    / \
   /   \
  K     L                      livello 4     altezza 3

Un nodo che ha sotto-alberi è il nodo "parent" (genitore) di quel sotto-albero (es. parent(B)).
Le radici di questi sotto-alberi sono i "children" (figli) di quel nodo (es. children(E, F))
I cildren dello stesso parent sono "sibling" (fratelli) (es. siblings(C, D).
La radice del nostro albero è il nodo A.
Il "grado" di un nodo è il numero di sotto-alberi di quel nodo. (es. grado(D) = 3)
La "profondità" (depth) di un nodo è la distanza dal nodo alla radice dell'albero.
Il "livello" (level) sono tutti i nodi che hanno la stessa profondità. Il livello della radice vale 1.
La "altezza" (height) la massima distanza di qualunque nodo dalla radice. Un albero con la sola radice ha altezza 0.

Rappresentazione
----------------

Un albero può essere rappresentato da una lista il cui primo elemento è la radice (root) e i rimanenti elementi sono sottoalberi.
Ad esempio, (A (B (E (K L)) F) (C (G)) (D (H (M)) I J))

Ogni nodo dell'albero può essere visto come un elemento della lista. Esistono tre tipi di nodi:

1) nodo radice (root node)
2) nodo ramo (branch node)
3) nodo foglia (leaf node)

Supponiamo di avere il seguente albero:

                             +-----> PS
                             +-----> AN
             + -----> MARCHE +-----> MC
             |               +-----> AP
             |               +-----> FM
             |
ITALIA ----> + -----> UMBRIA +-----> PG
             |               +-----> TR
             |
             |               +-----> FR
             |               +-----> LT
             + -----> LAZIO  +-----> RI
                             +-----> RM
                             +-----> VT

Un esempio di rappresentazione con una lista potrebbe essere il seguente:

(setq tree '(ITALIA
  (MARCHE (PS AN MC AP FM))
  (UMBRIA (PG TR))
  (LAZIO (FR LT RI RM VT))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (UMBRIA (PG TR)) (LAZIO (FR LT RI RM VT)))

In questo caso abbiamo:

nodo radice: ITALIA
nodi ramo: MARCHE UMBRIA LAZIO
nodi foglia: PS AN MC AP FM PG TR FR LT RI RM VT

Possiamo creare questa lista anche in altri modi:

(setq tree (list 'ITALIA (list 'MARCHE (list 'PS 'AN 'MC 'AP 'FM))
                         (list 'UMBRIA (list 'PG 'TR))
                         (list 'LAZIO (list 'FR 'LT 'RI 'RM 'VT))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (UMBRIA (PG TR)) (LAZIO (FR LT RI RM VT)))

(setq marche (list 'MARCHE (cons 'PS (cons 'AN (cons 'MC (cons 'AP (cons 'FM)))))))
(setq lazio  (list 'LAZIO  (cons 'FR (cons 'LT (cons 'RI (cons 'RM (cons 'VT)))))))
(setq umbria (list 'UMBRIA (cons 'PG (cons 'TR))))
(setq tree   (cons 'ITALIA (cons marche (cons umbria (cons lazio)))))
;-> (ITALIA (MARCHE (PS AN MC AP FM)) (LAZIO (FR LT RI RM VT)) (UMBRIA (PG TR)))

Altro esempio:

         A
        / \
       /   \
      B     C
     /     / \
    /     /   \
   D     E     F

Un altro tipo di rappresentazione dell'albero con una lista:

(setq lettere '(A (B (D () ())) (C (E () ()) (F () ()))))

nodo radice: A
nodi rami: B C
nodi foglie: D E F

Alberi binari
-------------

Un albero binario è vuoto o è composto da un elemento radice e due sotto-alberi, che sono essi stessi alberi binari. In Lisp rappresentiamo l'albero vuoto con il valore lista vuota '() e l'albero non vuoto dell'elenco (X L R), dove X indica il nodo radice e L e R indicano rispettivamente il sotto-albero sinistro (Left) e destro (Right).

Ad esempio il seguente albero:

           A
          / \
         /   \
        /     \
       B       C
      / \     / \
     /   \   /   \
    D     E ()    F
                 / \
                /   \
               G    ()

viene rappresentato dalla lista:

(A (B (D () ()) (E () ())) (C () (F (G () ()) ())))

Altri esempi sono un albero binario che consiste solo di un nodo radice: (A () ())

Oppure un albero binario vuoto: ()

Un albero binario di livello k è "pieno" quando ha (2^k - 1) nodi.
Un albero binario di livello k è "completo" quando tutti i nomi dei nodi corrispondono (posizionalmente) a quelli di un albero pieno di livello k.

Albero binario pieno    Albero binario completo    Albero binario inclinato

          A                       A                          A
         / \                     / \                        /
        /   \                   /   \                      B
       /     \                 /     \                    /
      B       C               B       C                  C
     / \     / \             / \                        /
    /   \   /   \           /   \                      D
   D     E F     G         D     E

Il seguente albero non è un albero binario completo (il nodo F non corrisponde a quello dell'albero pieno):

          A
         / \
        /   \
       /     \
      B       C
     / \       \
    /   \       \
   D     E       F


Il livello i-esimo di un albero binario può avere al massimo 2^(i-1) nodi.

Un albero binario con k livelli può avere al massimo Sum[1<=i<=k](2^(i-1)) = (2^k - 1) nodi.

In Lisp un albero binario viene rappresentato dalla lista: (T L R)
dove T = nome del nodo
     L = sotto-albero sinistro (Left)
     R = sotto-albero destro (Right)

Il nodo foglia viene rappresentato dalla lista: (T () ())

Esempio:
          A
         / \
        /   \
       B     C
      /     / \
     /     /   \
    D     E     F

(A (B (D nul nul) nul) (C (E nul nul) (F nul nul)))

radice: A
nodi: B C
foglie: D E F

(setq nul '())
(setq tree '(A (B (D nul nul) nul) (C (E nul nul) (F nul nul))))

Nome del nodo:
(first tree)
;-> A

sotto-albero sinistro
(first (rest tree))
;-> (B (D nul nul) nul)

sotto-albero destro
(first (rest (rest tree)))
(last (rest tree))
;-> (C (E nul nul) (F nul nul))

Le funzioni di base per gestire un albero binario sono le seguenti:

(define (empty-tree tree) --> Crea un albero vuoto
(define (empty-tree? tree) --> verifica se un albero è vuoto
(define (tree? lst) --> verifica se una lista è la rappresentazione di un albero binario
(define (make-tree data st-left st-right) --> crea un albero con radice di valore data e con i sottoalberi sinistro (st-left) e destro (st-right)
(define (name-tree tree) --> restituisce il valore/nome dell'albero
(define (left-tree tree) --> restituisce il sotto-albero sinistro dell'albero
(define (right-tree tree) --> restituisce il sotto-albero destro dell'albero

Le ultime tre funzioni potrebbero essere definite nel modo seguente:

(define (name-tree tree) (first tree))
(define (left-tree tree) (first (rest tree)))
(define (right-tree tree) (first (rest (rest tree))))

(name-tree tree)
;-> A

(left-tree tree)
;-> (B (D nul nul) nul)

(right-tree tree)
;-> (C (E nul nul) (F nul nul))

Attraversamento di alberi binari
--------------------------------

Per usare un albero binario dobbiamo essere in grado di visitare tutti i suoi nodi in un certo ordine.
Partendo dalla radice (o da un nodo) di un albero binario abbiamo tre azioni possibili:

        V
       / \
      /   \
     L     R

1) L --> muovi a sinistra (Left)
2) V --> visita il nodo (leggi il valore (Value) del nodo)
3) R --> muovi a destra (Right)

In base alla sequenza di queste azioni abbiamo i seguenti metodi principali di attraversamento:

Attraversamento "Inorder":   L-V-R

Attraversamento "Preorder":  V-L-R

Attraversamento "Postorder": L-R-V

Esempio (espressioni matematiche):

Applicando i metodi di attraversamento all'albero che rappresenta l'espressione aritmetica (A ^ B * C * D + E) otteniamo:

            +
           / \
          *   E
         / \
        *   D
       / \
      ^   C
     / \
    A   B

Inorder Traversal (infix expression) : A ^ B * C * D + E

Preorder Traversal (prefix expression) : + * * ^ A B C D E

Postorder Traversal (postfix expression) : A B ^ C * D * E +

A questo punto conosciamo le nozioni teoriche di base sugli alberi binari e possiamo scrivere alcune funzioni per gestirli:

Crea un albero binario (BST) vuoto "bst-create-empty"

(define (bst-create-empty) '())

Crea un albero binario "bst-create"

(define (bst-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))

Verifica se un albero binario è vuoto "bst-isempty?"

(define (bst-isempty? BST) (null? BST))

Selezione del valore dell'albero binario "bst-value"

(define (bst-value BST) (first BST))

Selezione del sotto-albero sinistro dell'albero binario "bst-left-subtree"

(define (bst-left-subtree BST) (first (rest BST)))

Selezione del sotto-albero destro dell'albero binario "bst-right-subtree"

(define (bst-right-subtree BST) (first (rest (rest BST))))

Attraversamento Inorder "bst-traverse-inorder"

(define (bst-traverse-inorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-inorder (bst-left-subtree BST))
              (list (bst-value BST))
              (bst-traverse-inorder (bst-right-subtree BST))))))

Attraversamento Preorder "bst-traverse-preorder"

(define (bst-traverse-preorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (list (bst-value BST))
              (bst-traverse-preorder (bst-left-subtree BST))
              (bst-traverse-preorder (bst-right-subtree BST))))))

Attraversamento Postorder "bst-traverse-postorder"

(define (bst-traverse-postorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-postorder (bst-left-subtree BST))
              (bst-traverse-postorder (bst-right-subtree BST))
              (list (bst-value BST))))))

Vediamo un esempio:

           A
          / \
         /   \
        /     \
       B       C
      / \     / \
     /   \   /   \
    D     E ()    F
                 / \
                /   \
               G    ()

(setq tree '(A (B (D () ()) (E () ())) (C () (F (G () ()) ()))))

(bst-traverse-inorder tree)
;-> (D B E A C G F)

(bst-traverse-preorder tree)
;-> (A B D E C F G)

(bst-traverse-postorder tree)
;-> (D E B G F C A)

Vediamo l'espressione aritmetica precedente:

            +
           / \
          *   E
         / \
        *   D
       / \
      ^   C
     / \
    A   B

(setq arit '(+ (* (* (^ (A () ()) (B () ())) (C () ())) (D () ())) (E () ())))

infix
(bst-traverse-inorder arit)
;-> (A ^ B * C * D + E)

prefix
(bst-traverse-preorder arit)
;-> (+ * * ^ A B C D E) ;

postfix
(bst-traverse-postorder arit)
;-> (A B ^ C * D * E +) ;

Esistono anche altri due metodi di attraversamento degli alberi binari:

1) Breadth-First-Search (attraversamento livello per livello da sinistra a destra)

2) Depth-First-Search (attraversamento per profondità)

Scriviamo altre funzioni utili per la gestione degli alberi binari.

Verifica se una lista è la rappresentazione di un albero binario "bst-istree?"

(define (bst-istree? LST)
  (or (null? LST)
      (and (list? LST)
           (= (length LST) 3)
           (bst-istree? (bst-left-subtree LST))
           (bst-istree? (bst-right-subtree LST)))))

(setq tree '(A (B (D () ()) (E () ())) (C () (F (G () ()) ()))))
(bst-istree? tree)
;-> true

(setq arit '(+ (* (* (^ (A () ()) (B () ())) (C () ())) (D () ())) (E () ())))
(bst-istree? arit)
;-> true

(bst-istree? '(a (b) (c)))
;-> nil

(bst-istree? '(a b))
;-> nil

Conta il numero dei nodi di un albero binario "bst-count-nodes"

(define (bst-count-nodes BST)
  (if (bst-isempty? BST)
      0
      (+ 1 (bst-count-nodes (bst-left-subtree BST))
           (bst-count-nodes (bst-right-subtree BST)))))

(bst-count-nodes tree)
;-> 7

(bst-count-nodes arit)
;-> 9

Conta il numero di foglie di un albero binario "bst-count-leaves"

(define (bst-count-leaves BST)
  (if (bst-isempty? BST)
      0
      (if (and (bst-isempty? (bst-left-subtree BST)) (bst-isempty? (bst-right-subtree BST)))
          (+ 1 (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST)))
          (+   (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST))))))

(bst-count-leaves tree)
;-> 3

(bst-count-leaves arit)
;-> 5

Verifica se un albero binario è una foglia: "bst-isleaf?":

(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))

(bst-isleaf? '(a () ()))
;-> true

(bst-isleaf? '(a (b () ()) (c () ())))
;-> nil

(bst-isleaf? (bst-right-subtree '(a (b () ()) (c () ()))))
;-> true

(bst-isleaf? (bst-left-subtree '(a (b () ()) (c () ()))))
;-> true

Calcola l'altezza di un albero binario "bst-height"

(define (bst-height BST)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bst-isempty? BST) -1)
      (true (+ 1 (max (bst-height (bst-left-subtree BST))
                      (bst-height (bst-right-subtree BST)))))))

(bst-height tree)
;-> 3

(bst-height arit)
;-> 4

Cerca un valore in un albero binario "bst-find?"

(define (bst-find? BST value)
    (cond ((bst-isempty? BST) nil)
          ((= value (bst-value BST)) true)
          (true (or (bst-find? (bst-left-subtree BST) value)
                    (bst-find? (bst-left-subtree BST) value)))))

(bst-find? tree 'D)
;-> true

(bst-find? arit '^)
;-> true


Alberi binari di ricerca
------------------------

Un albero binario di ricerca (BST - Binary Search Tree) è un albero binario con le seguenti proprietà:

1) Il sottoalbero sinistro di un nodo x contiene soltanto i nodi con chiavi minori della chiave del nodo x
2) Il sottoalbero destro di un nodo x contiene soltanto i nodi con chiavi maggiori della chiave del nodo x
3) Il sottoalbero destro e il sottoalbero sinistro devono essere entrambi due alberi binari di ricerca.

Nota: poichè ogni nodo di un albero binario di ricerca è una "chiave" (key), non possono esistere due nodi con valori uguali.

Questa struttura permette di effettuare in maniera efficiente operazioni come: ricerca, inserimento e cancellazione di elementi.

Esempio:

           8
          / \
         /   \
        /     \
       3      10
      / \       \
     /   \       \
    1     6       14
         / \      /
        /   \    /
       4     7  13

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))

(bst-count-nodes albero)
;-> 9

(bst-count-leaves albero)
;-> 4

Per verificare se un dato albero binario è un albero binario di ricerca (cioè soddisfa le proprietà elencate sopra), si può operare nel modo seguente:
- attraversare l'albero con il metodo "inorder"
- se la lista risultante è ordinata in modo crescente, allora è un albero binario di ricerca, altrimenti non lo è.

Nota: questo metodo è valido solo se l'albero non ha valori duplicati (ipotesi delle chiavi univoche)

Verifica se un albero binario è un albero binario di ricerca "bst-istreebst"

(define (bst-istreebst? BST)
  (apply < (bst-traverse-inorder BST)))

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))

(bst-istreebst? albero)
;-> true

(bst-istreebst? tree)
;-> nil

(bst-istreebst? arit)
;-> nil

Esempio:

                |
          +--- 14 ---+
          |          |
    +--- 13    +--- 22 ---+
    |          |          |
    1         16    +--- 29 ---+
                    |          |
                   28         30

(setq numtree '(14 (13 (1 () ()) ()) (22 (16 () ()) (29 (28 () ()) (30 () ())))))

(bst-istreebst? numtree)
;-> true

Nota: Quando l'albero binario di ricerca ha valori duplicati possiamo mantenere le stesse funzioni utilizzando una struttura in cui un nodo può avere valori multipli.

Cerca un valore in un albero binario di ricerca "bst-member?"

(define (bst-member? BST value)
    (cond
      ((bst-isempty? BST) nil)
      ((= value (bst-value BST)) true)
      ((< value (bst-value BST)) (bst-member? (bst-left-subtree BST) value))
      (true (bst-member? (bst-right-subtree BST) value))))

Aggiunge un valore in un albero binario di ricerca "bst-add"

(define (bst-add BST value)   ; restituisce un bst con il valore aggiunto
    (cond
      ((bst-isempty? BST)           ; se vuoto, crea un nuovo nodo
       (bst-create value (bst-create-empty) (bst-create-empty)))
      ((< value (bst-value BST))    ; aggiunge il nodo al sotto-albero sinistro...
       (bst-create (bst-value BST)  ; ...aggiungendo un nuovo albero
                   (bst-add (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      ((> value (bst-value BST))    ; aggiunge il nodo al sotto-albero destro
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-add (bst-right-subtree BST) value)))
      (true BST)))                  ; valore presente, non fare nulla anything

Esempio:

        5
       / \
      /   \
     4     6

(setq tri '(5 (4 () ()) (6 () ())))

(bst-add tri 2)
;-> (5 (4 (2 () ()) ()) (6 () ()))

Elimina un valore in un albero binario di ricerca "bst-delete"

(define (bst-delete BST value)   ; restituisce un bst con il valore eliminato
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((= value (bst-value BST)) (bst-delete-root BST))
      ((< value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-delete (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      (true ; (> value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-delete (bst-right-subtree BST) value)))))

(define (bst-delete-root BST)   ; restituisce un bst con la radice eliminata
    (cond
      ; se la radice non ha figli, il risultato è un bst vuoto
      ((bst-isleaf? BST) (bst-create-empty))
      ; se la radice ha un figlio (destro o sinistro),
      ; il risultato è quel figlio (con i suoi sotto-alberi)
      ((bst-isempty? (bst-left-subtree BST)) (bst-right-subtree BST))
      ((bst-isempty? (bst-right-subtree BST)) (bst-left-subtree BST))
      ; se la radice ha due figli,
      ; sostituisci il valore con il figlio più a sinistra del sotto-albero destro
      (true (letn ((replacement-value (bst-value (bst-leftmost-child (bst-right-subtree BST))))
                   (new-right-subtree (bst-delete (bst-right-subtree BST) replacement-value)))
              (bst-create replacement-value (bst-left-subtree BST) new-right-subtree)))))

(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))

(define (bst-leftmost-child BST)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((bst-isempty? (bst-left-subtree BST)) BST)
      (true (bst-leftmost-child (bst-left-subtree BST)))))

Esempio:

           8
          / \
         /   \
        /     \
       3      10
      / \       \
     /   \       \
    1     6       14
         / \      /
        /   \    /
       4     7  13

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))
;-> (8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))

(bst-member? albero 3)
;-> true

(setq newtree (bst-add albero 2))
;-> (8 (3 (1 () (2 () ())) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))

                       |
              +--------8---------+
              |                  |
              |                  |
              3                  10
             / \                   \
            /   \                   \
           /     \                   \
          1       6                  14
           \     / \                 /
            \   /   \               /
             2 4     7             13


(bst-delete newtree 2)
;-> (8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ())))
Abbiamo ottenuto lo stesso albero di partenza.

(bst-istreebst? albero)
;-> true

(bst-istreebst? (bst-delete-root albero))
;-> true

Verifica se un albero binario è bilanciato "bst-balanced?"

(define (bst-balanced? BST)
    (cond
      ((bst-isempty? BST) true)
      (true (and (= (bst-height (bst-left-subtree BST)) (bst-height (bst-right-subtree BST)))
                 (bst-balanced? (bst-left-subtree BST))
                 (bst-balanced? (bst-right-subtree BST))))))

(setq albero '(8 (3 (1 () ()) (6 (4 () ()) (7 () ()))) (10 () (14 (13 () ()) ()))))
(bst-count-nodes albero)
;-> 9
(bst-height albero)
;-> 3
(bst-balanced? albero)
;-> nil

(setq albero2 '(8 (3 (1 () ()) (6 () ())) (10 (4 () ()) (5 () ()))))
(bst-count-nodes albero2)
;-> 7
(bst-height albero2)
;-> 2
(bst-balanced? albero2)
;-> true

Verifica se un albero binario è quasi bilanciato "bst-relatively-balanced?"

(define (bst-relatively-balanced? BST)
    (>= 1 (abs (- (bst-height BST) (bst-shortest-path-to-leaf BST)))))

Calcola il percorso minimo fino alla foglia "bst-shortest-path-to-leaf"

(define (bst-shortest-path-to-leaf BST)
    (cond
      ((bst-isempty? BST) -1)
      (true (+ 1 (min (bst-shortest-path-to-leaf (bst-left-subtree BST))
                      (bst-shortest-path-to-leaf (bst-right-subtree BST)))))))

(bst-relatively-balanced? albero)
;-> nil

(bst-relatively-balanced? albero2)
;-> true

(bst-shortest-path-to-leaf albero)
;-> 1

(bst-shortest-path-to-leaf albero2)
;-> 2

Trova il valore minimo di un albero binario di ricerca "bst-find-min"

(define (bst-find-min BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-left-subtree BST)) (bst-value BST))
      (true (bst-find-min (bst-left-subtree BST)))))

(bst-find-min albero)
;-> 1

Trova il valore massimo di un albero binario di ricerca "bst-find-max"

(define (bst-find-max BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-right-subtree BST)) (bst-value BST))
      (true (bst-find-max (bst-right-subtree BST)))))

(bst-find-max albero)
;-> 14

Vediamo come creare un albero binario di ricerca (BST) da una lista di numeri:

(define (bst-make lst)
  (let (BST '())
    (dolist (el lst)
      (setf BST (bst-add BST el)))))

(setq lst '(23 12 1 4 5 28 4 9 10 45 89))
(setq albero (bst-make lst))
;-> (23 (12 (1 () (4 () (5 () (9 () (10 () ()))))) ()) (28 () (45 () (89 () ()))))

(bt-istree? albero)
;-> true

(bst-istree? albero)
;-> true

TODO:
- Print ASCII tree on console
- Depth-First-Search
- Breadth-First-Search

Adesso possiamo raggruppare in una libreria tutte le funzioni che abbiamo scritto finira differenziando le funzioni in base al tipo di albero (binario oppure binario di ricerca).

;;
;; Library File: tree-library.lsp
;; Library load: (load "tree-library.lsp")
;;

;;
;;
;; Alberi Binari
;; Binary Tree (BT)
;;
;;

; (bt-create-empty)
; Crea un albero binario (BT) vuoto
; output: '() (un albero binario vuoto)
(define (bt-create-empty) '())


; (bt-create value left-subtree right-subtree)
; Crea un BT
; output: BT
(define (bt-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))


; (bt-isempty? BT)
; Verifica se un BT è vuoto
; output: true o nil
(define (bt-isempty? BT) (null? BT))


; (bt-value BT)
; Selezione del valore del BT
; output: valore del BT (radice del BT)
(define (bt-value BT) (first BT))


; (bt-left-subtree BT)
; Selezione del sotto-albero sinistro del BT
; output: sotto-albero sinistro del BT
(define (bt-left-subtree BT) (first (rest BT)))


; (bt-right-subtree BT)
; Selezione del sotto-albero destro dell'albero binario
; output: sotto-albero destro del BT
(define (bt-right-subtree BT) (first (rest (rest BT))))


; (bt-istree? LST)
; Verifica se una lista è la rappresentazione di un BT
; output: true o nil
(define (bt-istree? LST)
  (or (null? LST)
      (and (list? LST)
           (= (length LST) 3)
           (bt-istree? (bt-left-subtree LST))
           (bt-istree? (bt-right-subtree LST)))))


; (bt-count-nodes BT)
; Conta il numero di nodi del BT
; output: numero di nodi del BT
(define (bt-count-nodes BT)
  (if (bt-isempty? BT)
      0
      (+ 1 (bt-count-nodes (bt-left-subtree BT))
           (bt-count-nodes (bt-right-subtree BT)))))


; (bt-count-leaves BT)
; Conta il numero di foglie del BT
; output: numero di foglie del BT
(define (bt-count-leaves BT)
  (if (bt-isempty? BT)
      0
      (if (and (bt-isempty? (bt-left-subtree BT)) (bt-isempty? (bt-right-subtree BT)))
          (+ 1 (bt-count-leaves (bt-left-subtree BT))
               (bt-count-leaves (bt-right-subtree BT)))
          (+   (bt-count-leaves (bt-left-subtree BT))
               (bt-count-leaves (bt-right-subtree BT))))))


; (bt-height BT)
; Calcola l'altezza del BT
; output: altezza del BT
(define (bt-height BT)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bt-isempty? BT) -1)
      (true (+ 1 (max (bt-height (bt-left-subtree BT))
                      (bt-height (bt-right-subtree BT)))))))


; (bt-member? BT value)
; Cerca un valore nel BT
; output: true o nil
(define (bt-member? BT value)
    (cond ((bt-isempty? BT) nil)
          ((= value (bt-value BT)) true)
          (true (or (bt-member? (bt-left-subtree BT) value)
                    (bt-member? (bt-left-subtree BT) value)))))


; (bt-isleaf? BT)
; Verifica se il BT è una foglia:
; output: true o nil
(define (bt-isleaf? BT)
    (and (bt-isempty? (bt-left-subtree BT))
         (bt-isempty? (bt-right-subtree BT))))


; (bt-traverse-inorder BT)
; Attraversamento Inorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-inorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (bt-traverse-inorder (bt-left-subtree BT))
              (list (bt-value BT))
              (bt-traverse-inorder (bt-right-subtree BT))))))


; (bt-traverse-preorder BT)
; Attraversamento Preorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-preorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (list (bt-value BT))
              (bt-traverse-preorder (bt-left-subtree BT))
              (bt-traverse-preorder (bt-right-subtree BT))))))


; (bt-traverse-postorder BT)
; Attraversamento Postorder
; output: lista con tutti i nodi del BT
(define (bt-traverse-postorder BT)
    (cond
      ((bt-isempty? BT) '())
      (true (append
              (bt-traverse-postorder (bt-left-subtree BT))
              (bt-traverse-postorder (bt-right-subtree BT))
              (list (bt-value BT))))))

;;
;;
;; Alberi Binari di Ricerca
;; Binary Search Tree (BST)
;;
;;

; (bst-create-empty)
; Crea un albero binario di ricerca (BST) vuoto
; output: '() (un albero binario di ricerca vuoto)
(define (bst-create-empty) '())


; (bst-create value left-subtree right-subtree)
; Crea un BST
; output: BST
(define (bst-create value left-subtree right-subtree)
  (list value left-subtree right-subtree))


; (bst-isempty? BST)
; Verifica se un BST è vuoto
; output: true o nil
(define (bst-isempty? BST) (null? BST))


; (bst-value BST)
; Selezione del valore del BST
; output: valore del BST (radice del BST)
(define (bst-value BST) (first BST))


; (bst-left-subtree BST)
; Selezione del sotto-albero sinistro del BST
; output: sotto-albero sinistro del BST
(define (bst-left-subtree BST) (first (rest BST)))


; (bst-right-subtree BST)
; Selezione del sotto-albero destro del BST
; output: sotto-albero destro del BST
(define (bst-right-subtree BST) (first (rest (rest BST))))


; (bst-istree? BST)
; Verifica se un albero binario è un BST
; output: true o nil
(define (bst-istree? BST)
  (apply < (bst-traverse-inorder BST)))


; (bst-count-nodes BST)
; Conta il numero di nodi del BST
; output: numero di nodi del BST
(define (bst-count-nodes BST)
  (if (bst-isempty? BST)
      0
      (+ 1 (bst-count-nodes (bst-left-subtree BST))
           (bst-count-nodes (bst-right-subtree BST)))))


; (bst-count-leaves BST)
; Conta il numero di foglie del BST
; output: numero di foglie del BST
(define (bst-count-leaves BST)
  (if (bst-isempty? BST)
      0
      (if (and (bst-isempty? (bst-left-subtree BST)) (bst-isempty? (bst-right-subtree BST)))
          (+ 1 (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST)))
          (+   (bst-count-leaves (bst-left-subtree BST))
               (bst-count-leaves (bst-right-subtree BST))))))


; (bst-height BST)
; Calcola l'altezza del BST
; output: altezza del BST
(define (bst-height BST)
    (cond
      ; per convenzione l'altezza di un albero vuoto vale -1
      ((bst-isempty? BST) -1)
      (true (+ 1 (max (bst-height (bst-left-subtree BST))
                      (bst-height (bst-right-subtree BST)))))))


;("bst-member? BST value)"
; Cerca un valore nel BST
; output: true o nil
(define (bst-member? BST value)
    (cond
      ((bst-isempty? BST) nil)
      ((= value (bst-value BST)) true)
      ((< value (bst-value BST)) (bst-member? (bst-left-subtree BST) value))
      (true (bst-member? (bst-right-subtree BST) value))))


; (bst-isleaf? BST)
; Verifica se il BST una foglia:
; output: true o nil
(define (bst-isleaf? BST)
    (and (bst-isempty? (bst-left-subtree BST))
         (bst-isempty? (bst-right-subtree BST))))


; (bst-traverse-inorder BST)
; Attraversamento Inorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-inorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-inorder (bst-left-subtree BST))
              (list (bst-value BST))
              (bst-traverse-inorder (bst-right-subtree BST))))))


; (bst-traverse-preorder BST)
; Attraversamento Preorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-preorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (list (bst-value BST))
              (bst-traverse-preorder (bst-left-subtree BST))
              (bst-traverse-preorder (bst-right-subtree BST))))))


; (bst-traverse-postorder BST)
; Attraversamento Postorder
; output: lista con tutti i nodi del BST
(define (bst-traverse-postorder BST)
    (cond
      ((bst-isempty? BST) '())
      (true (append
              (bst-traverse-postorder (bst-left-subtree BST))
              (bst-traverse-postorder (bst-right-subtree BST))
              (list (bst-value BST))))))


; (bst-add BST value)
; Aggiunge un valore nel BST
; output: BST
(define bst-add
  (lambda (BST value)
    (cond
      ((bst-isempty? BST)           ; if empty, create a new node
       (bst-create value (bst-create-empty) (bst-create-empty)))
      ((< value (bst-value BST))    ; add node to left subtree
       (bst-create (bst-value BST)  ; (functionally, by building new tree)
                   (bst-add (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      ((> value (bst-value BST))    ; add node to right subtree
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-add (bst-right-subtree BST) value)))
      (true BST))))                 ; it's already there;


; (bst-delete BST value)
; Elimina un valore nel BST
; output: BST
(define (bst-delete BST value)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((= value (bst-value BST)) (bst-delete-root BST))
      ((< value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-delete (bst-left-subtree BST) value)
                   (bst-right-subtree BST)))
      (true ; (> value (bst-value BST))
       (bst-create (bst-value BST)
                   (bst-left-subtree BST)
                   (bst-delete (bst-right-subtree BST) value)))))


; (bst-delete-root BST)
; Elimina la radice del BST
; output: BST
(define (bst-delete-root BST)   ; return tree with root deleted
    (cond
      ; If the root has no children, result is empty tree
      ((bst-isleaf? BST) (bst-create-empty))
      ; If the root has one child (right or left),
      ; result is that child (and descendants)
      ((bst-isempty? (bst-left-subtree BST)) (bst-right-subtree BST))
      ((bst-isempty? (bst-right-subtree BST)) (bst-left-subtree BST))
      ; If the root has two children,
      ; replace value with leftmost child of right subtree
      (true (letn ((replacement-value (bst-value (bst-leftmost-child (bst-right-subtree BST))))
                   (new-right-subtree (bst-delete (bst-right-subtree BST) replacement-value)))
              (bst-create replacement-value (bst-left-subtree BST) new-right-subtree)))))


; (bst-leftmost-child BST)
; Selezione del sotto-albero più a sinistra del BST
; output: BST
(define (bst-leftmost-child BST)
    (cond
      ((bst-isempty? BST) (bst-create-empty))
      ((bst-isempty? (bst-left-subtree BST)) BST)
      (true (bst-leftmost-child (bst-left-subtree BST)))))


; (bst-balanced? BST)"
; Verifica se un albero binario è bilanciato
; output: true o nil
(define (bst-balanced? BST)
    (cond
      ((bst-isempty? BST) true)
      (true (and (= (bst-height (bst-left-subtree BST)) (bst-height (bst-right-subtree BST)))
                 (bst-balanced? (bst-left-subtree BST))
                 (bst-balanced? (bst-right-subtree BST))))))


; (bst-relatively-balanced? BST)
; Verifica se un albero binario è quasi bilanciato
; output: true o nil
(define (bst-relatively-balanced? BST)
    (>= 1 (abs (- (bst-height BST) (bst-shortest-path-to-leaf BST)))))


; (bst-shortest-path-to-leaf BST)
; Calcola il valore del percorso minimo fino alla foglia del BST
; output: valore del percorso minimo (radice --> foglia)
(define (bst-shortest-path-to-leaf BST)
    (cond
      ((bst-isempty? BST) -1)
      (true (+ 1 (min (bst-shortest-path-to-leaf (bst-left-subtree BST))
                      (bst-shortest-path-to-leaf (bst-right-subtree BST)))))))


; (bst-find-min BST)
; Trova il valore minimo del BST
; output: valore minimo del BST
(define (bst-find-min BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-left-subtree BST)) (bst-value BST))
      (true (bst-find-min (bst-left-subtree BST)))))


; (bst-find-max BST)
; Trova il valore massimo del BST
; output: valore massimo del BST
(define (bst-find-max BST)
    (cond
      ((bst-isempty? BST) nil)
      ((bst-isempty? (bst-right-subtree BST)) (bst-value BST))
      (true (bst-find-max (bst-right-subtree BST)))))


; (bst-make lst)
; Crea un BST da una lista di numeri
; output: BST
(define (bst-make lst)
  (let (BST '())
    (dolist (el lst)
      (setf BST (bst-add BST el)))))

;(setq lst '(23 12 1 4 5 28 4 9 10 45 89))
;(setq albero (bst-make lst))
;-> (23 (12 (1 () (4 () (5 () (9 () (10 () ()))))) ()) (28 () (45 () (89 () ()))))

'library-tree-loaded
;
; end of library
;

Per caricare la libreria nella REPL:

(load "tree-library.lsp")


==================
 SIMULAZIONE DADI
==================

Alcune funzioni per simulare il lancio di dadi generici.

; Roll a die with S sides
(define (die s) (+ (rand s) 1))

; Roll a die with 6 sides
(define (die6) (+ (rand 6) 1))

; Roll N die with S sides and return the sum of numbers
(define (dice n s) (+ n (apply + (rand s n))))
(dice 10 4)
;-> 19

; Roll N die with 6 sides and return the sum of numbers
(define (dice6 n) (+ n (apply + (rand 6 n))))
(dice6 10)
;-> 38

; Roll N die with S sides and return the list of numbers
(define (dice-lst n s) (map (curry + 1) (rand s n)))
(dice-lst 4 8)
;-> (7 7 5 3)

; Roll N die with 6 sides and return the list of numbers
(define (dice6-lst n) (map (curry + 1) (rand 6 n)))
(dice6-lst 5)
;-> (1 3 2 6 2)

; Roll N die with s sides and return a list with the frequency of all faces
(define (dice-lst-freq n s) (count (sequence 1 s) (dice-lst n s)))
(dice-lst-freq 20 8)
;-> (3 3 3 4 0 5 1 1)

; Roll N die with 6 sides and return a list with the frequency of all faces
(define (dice6-lst-freq n) (count '(1 2 3 4 5 6) (dice6-lst n)))
(dice6-lst-freq 12)
;-> (1 3 0 4 3 1)

; Convert probability (0..1) to "1 in x events"
(define (one-in prob) (int (add 0.5 (div prob))))
(one-in 0.5)
;-> 2

; Roll a non-fair dice with N sides
; Get a list of N probabilities (one prob for each sides)
; and return a random number (0..N-1) with the distribution
; of the probabilities predefined
; Nota: the sum of probabilities must be 1.
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

Tests:

(setq dice4-prob '(0.05 0.15 0.35 0.45))
(apply add dice4-prob)
;-> 1
(rand-pick dice4-prob)
;-> 2

(setq dice4-prob '(0.05 0.15 0.35 0.45))
(apply add dice4-prob)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick dice4-prob))))
vet
;-> (50087 150175 349614 450124)
(apply + vet)
;-> 1000000

(setq dice6-prob '(0.01 0.01 0.01 0.77 0.1 0.1))
(apply add dice6-prob)
;-> 1
(setq vet (array 6 '(0)))
;-> (0 0 0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick dice6-prob))))
vet
;-> (9821 10070 9923 770122 100288 99776)

(setq dice6-prob '(0.1 0.0 0.2 0.3 0.0 0.4))
(apply add dice6-prob)
;-> 1
(setq vet (array 6 '(0)))
;-> (0 0 0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick dice6-prob))))
vet
;-> (100015 0 200371 300148 0 399466)

; Roll a die with N sides with non-standard numeration
; Get a list with the values of each face
; Return an element of the list
(define (rand-lst lst) (lst (rand (length lst))))

(setq d1 '(1 2 2 3 3 4))
(setq d2 '(1 3 4 5 6 8))

(rand-lst d1)
;-> 3
(rand-lst d2)
;-> 6

Probability for d1:

(setq freq (array 5 '(0)))
(for (i 1 1e6) (++ (freq (rand-lst d1))))
(dolist (f freq) (println $idx { } (div f 1e6)))
;-> 0 0
;-> 1 0.166152
;-> 2 0.334015
;-> 3 0.332892
;-> 4 0.166941

Probability for d2:

(setq freq (array 9 '(0)))
(for (i 1 1e6) (++ (freq (rand-lst d2))))
(dolist (f freq) (println $idx { } (div f 1e6)))
;-> 0 0
;-> 1 0.166818
;-> 2 0
;-> 3 0.166644
;-> 4 0.167115
;-> 5 0.166344
;-> 6 0.166272
;-> 7 0
;-> 8 0.166807


=========
 FUNLISP
=========

L'autore di questa libreria di funzioni "funlisp.lsp" è Dmitry Chernyak <dmi@en.feautec.pp.ru>.
La libreria è reperibile all'indirizzo:

http://en.feautec.pp.ru/store/libs/funlib.lsp

;; @module funlib.lsp
;; @author Dmitry Chernyak <dmi@en.feautec.pp.ru>
;; @version 1.22
;; @description The newLISP language unofficial extension module
;; @location http://en.feautec.pp.ru/store/libs/funlib.lsp

(context MAIN)

;; @syntax (push-end <item> <list>)
;;
;; Push <item> to the end of the <list>
;; Equivalent to (push item list -1)
(context 'MAIN:push-end)
(define-macro (push-end:push-end _push lst_push)
  "(push-end item list) - push item to the end of the list"
  (eval (list 'push (quote (eval _push)) lst_push -1)))

;; @syntax (pushl-end <lst> <slst> <index>)
;;
;; Push a list <lst> into the end of a list <slst>
;;
;; @param <slst> must be a list
;;
;; @return the last element of <lst>
;;
;; Effective as in-place alternative to <b>append</b> in case
;; of frequently appending to long list
;;
;; @example
;; (set 'l (1 2 3))
;; (pushl '(4 5 6) l)
;; l => (1 2 3 4 5 6)
(context 'MAIN:pushl-end)
(define-macro (pushl-end:pushl-end lst slst)
  "(pushl-end lst slst) - push a list lst into the end of a list in symbol slst"
  (dolist (l (eval lst))
    (push l (eval slst) -1)))

;; @syntax (dofile (<sym> <str-fnam>e [<str-delim> [<int-strlen>]]) <body>)
;; @syntax (dofile (<sym> <int-fd> [<str-delim> [<int-strlen>]]) <body>)
;;
;; Behaves like 'dolist' but for a file contents
;;
;; @param <sym> iterating symbol
;; @param <str-fname> filename
;; @param <int-fd> opened file descriptor (will be closed on finish)
;; @param <str-delim> "\n" by default; use nil to turn off explicitly
;; @param <int-strlen> 65000 by default. Not limited
;; @param <body> the plain sequence of funcalls
;;
;; @example
;; (dofile (l "/etc/passwd") (print ">") (println l))
;; =>
;; >root:x:0:0:root:/root:/bin/bash
;; >daemon:x:1:1:daemon:/usr/sbin:/bin/sh
;; >bin:x:2:2:bin:/bin:/bin/sh
;; >....
(context 'MAIN:dofile)
(define-macro (dofile:dofile ini)
  "(dofile (sym str-fname|int-fd [str-delim [int-strlen]]) body) - behaves like dolist, but for file's contents"
  (let (
    _sym (ini 0)
    fil (eval (ini 1))
    delim (eval (if (> (length ini) 2) (ini 2) "\n"))
    buflen (eval (if (> (length ini) 3) (ini 3) 65000))
    fd nil
    iter nil buf nil delim_len 0
    _read-buffer nil
    res nil err nil)
    (set 'delim_len (length delim))
    (if (not (set 'fd
      (if
        (string? fil) (open fil "r")
        (integer? fil) fil
        (throw-error "dofile: fname must evaluate to str-fname or int-fd"))))
      (throw-error "dofile: no file descriptor or can't open file"))
    (unless (atom? _sym) (set '_sym (eval _sym)))
    (set 'iter
      (expand (append '(let (_sym buf)) (args)) '_sym))
    (set '_read-buffer
      '(read-buffer fd 'buf buflen))
    (if delim (push 'delim _read-buffer -1))
    (set 'err (catch
      (while (or (eval _read-buffer) buf) ; works since 8.7.0
         (if (and delim (ends-with buf delim))
           (set 'buf (chop buf delim_len)))
         (eval iter))
      'res))
    (close fd)
    (if err res (throw-error res))))

;; @syntax (ecase <exp-switch> (<exp-key1> <body-1>)[ (<exp-key2> <body-2>)...])
;;
;; Like a <b>case</b> with evaluating <exp-key> before testing against evaluated <exp-switch>
;;
;; @param <exp-switch> expression, value of which will be tested against <exp-key> conditions
;; @param <exp-key> expression, value of which will be tested against value
(context 'MAIN:ecase)
(define-macro (ecase:ecase v)
  "(ecase ...) - case with evaluating exp-key before testing"
  (eval (append (list 'case v)
    (map (fn (i) (set-nth 0 i (eval (i 0))))
         (args)))))

;; @syntax (ifempty <exp-value> <exp-replacement>)
;;
;; Replace empty or nil value
;;
;; If the result of <exp-value> is <nil> or is empty, returns the result of
;; <exp-replacement>.
;; Otherwise returns the result of <exp-value>.<br>
;; NOTE: <b>ifempty</b> is a macro, so <exp-replacement> evaluated only when needed.
(context 'MAIN:ifempty)
(define-macro (ifempty:ifempty v r)
  "(ifempty value replacement) - replace empty or nil value"
  (set 'v (eval v))
  (if (or (not v) (empty? v)) (eval r) v))

;; @syntax (ifnil <exp-value> <exp-replacement>)
;;
;; Replace nil value
;;
;; If the result of <exp-value> is <nil>, returns the result of
;; <exp-replacement>.
;; Otherwise returns the result of <exp-value>.<br>
;; NOTE: <b>ifnil</b> is a macro, so <exp-replacement> evaluated only when needed.
(context 'MAIN:ifnil)
(define-macro (ifnil:ifnil v r)
  "(ifempty value replacement) - replace empty or nil value"
  (set 'v (eval v))
  (if v v (eval r)))

;; @syntax (file-tree <dir|dir-list> [<filter-function>])
;;
;; Filesystem tree iterator
;;
;; @param <dir|dir-list> starting directory or a list of several
;; @param <filter-function> filter: (lambda <filename> <dirname> <is-file>)
;; @param <is-file> <true> if filename is a file
;;
;; @return a list of pairs (<filename> <directory>) where <filename> satisfy
;; to filter-function (more precise - see code and examles).<br>
;; <filename> can be either the name of a file or a directory.
;;
;; @example
;; (setq list1 (file-tree "." ))
;; (setq list2 (file-tree "." (fn (x) (starts-with x "b" nil))))
;; ; got files only and skip directories
;; (setq list3 (file-tree "." (fn (f d is-file) is-file)))

;; ORIGIN<br>
;; file-tree was introduced by alex version 2005.12.02.
;; Published at newLisp fan Club forum.
;; funlib has slightly modified version of it.
; by alex (modified)
(context 'MAIN:file-tree)
(define-macro (file-tree:file-tree dir _filter)
  "(file-tree dir|dir-list [filter-function]) - filesystem tree iterator.\nfilter-function: (fn (filename dirname is-file))"
  (if (symbol? _filter) (setq _filter (eval _filter)))
  (letn
    ( result '()
      file-tree-utility
        (lambda (d)
          (dolist (f (replace "." (replace ".." (directory d))))
            (let (isdir (directory? (append d f)))
              (if isdir
                (file-tree-utility (append d f "/")))
              (if (or (not _filter) (_filter f d (not isdir)))
                (push (list f d) result))))))

    (unless (list? dir) (setq dir (list dir)))
    (dolist (d dir)
      (replace "\\" d "/")
      (unless (ends-with d "/") (setq d (append d "/" )))
      (file-tree-utility d))
    result))

;; @syntax (doif (<sym> <expr>) <expr-yes> <expr-no>)
;;
;; Anaphoric if
;;
;; Eval <expr-yes> if <expr> orherwise eval <expr-no><br>
;; While evaluating <expr-yes> or <expr-no> the result of <expr> is stored in <sym>
;; @example
;; (doif (l (lookup key table))
;;   (println "found: " l)
;;   (println "not found"))
(context 'MAIN:doif)
(define-macro (doif:doif test do-yes do-no)
        (eval
    (list let test (list 'if (first test) do-yes do-no))))

(context MAIN)

;; @syntax (inc-p '<sym> [<num>])
;;
;; Post increment function
;;
;; @param <num> increment value, 1 by default
(define (inc-p symb num)
  "(inc-p sym num) - post-increment sym by num"
  (let (old (eval symb))
    (if num (inc symb num) (inc symb))
  old))

;; @syntax (dec-p '<sym> [<num>])
;;
;; Post decrement function
;;
;; @param <num> decrement value, 1 by default
(define (dec-p symb num)
  "(dec-p sym num) - post-decrement sym by num"
  (let (old (eval symb))
    (if num (dec symb num) (dec symb))
  old))

;; @syntax (group <n> <lst>)
;;
;; Group list lst into sublists by n members, truncate the last incomplete group
;;
;; @param <n> number of members in a group, if <n>>0 group from start, else from end
(define (group n lst)
  "(group n lst) - group list by n members, truncate the last incomplete group"
  (letn
    (an (abs n)
     ln (length lst)
     t (% ln an))
    (if (> an ln) (set 'an ln))
    (array-list (array
      (/ ln an) an
      (if (> n 0)
        lst
        (t lst))))))

;; @syntax (group-all <n> <lst>)
;;
;; Group list lst into sublists by n members, save the last incomplete group
;;
;; @param <n> number of members in a group, if <n>>0 group from start, else from end
(define (group-all n lst)
  "(group-all n lst) - group list by n members, save the last incomplete group"
  (letn
    (an (abs n)
     ln (length lst)
     an (if (> an ln) ln an)
     t (% ln an)
     ml (array-list (array
      (/ ln an) an
      (if (> n 0) lst (t lst)))))
    (if (= t 0) ml
      (if (> n 0) (append ml (list ((- ln t) lst)))
        (append (list (0 t lst)) ml)))))

;; @syntax (group-by <lst> <ind-grp> <ind-memb>)
;;
;; Group sublists by a key
;;
;; @param <lst> list of some sublists
;; @param <ind-grp> list of member's indices in a sublists, which will be a KEY-list
;; @param <ind-memb> list of member's indices in a sublists, which will be a VALUE-list
;;
;; Group (select lst ind-memb) <VALUE-list> by (select lst ind-grp) <KEY-list>.<br>
;;
;; Result is an assoc-list where each unique <KEY-list> relies to a list of
;; corresponding <VALUE-lists>.
(define (group-by lst ind-grp ind-memb)
  "(group-by lst ind-grp ind-memb) - group sublists of lst into assoc-list with a key of ind-grp and a list of values of ind-memb indices"
  (let (grp '())
    (dolist (l lst)
      (let (g (select l ind-grp) m (select l ind-memb))
        (if (not
              (replace-assoc
                g grp
                (list g (append ($0 1) (list m)))))
          (push (list g (list m)) grp))))
    grp))

;; @syntax (lesser <int>)
;;
;; @return next lesser int value
;;
;; Equivalent to (- <int> 1)
;;
;; Introduced for readability improvement
(define (lesser x) (- x 1))

;; @syntax (greater <int>)
;;
;; @return next greater int value
;;
;; Equivalent to (+ <int> 1)
;;
;; Introduced for readability improvement
(define (greater x) (+ x 1))

;; @syntax  (append-one <lst> <memb>)
;;
;; Append one any element to the end of the list
(define (append-one lst)
  "(append-one lst arg1 arg2 ...)  - append one or more elements to the end of the list"
  (append lst (args)))

;; @syntax (dirname <str-pathname>)
;;
;; @return a directory part of pathname
;;
;; Split pathname by "/" symbol and return all but last element as a string.<br>
;; If directory part is empty, return ".".<br>
;; Return value is not finished by a "/".
(define (dirname f)
  "(dirname pathname) - return directory part of pathname"
  (ifempty (join (chop (parse f "/")) "/") "."))

;; @syntax (strip-end <str> <fin>)
;;
;; Strip the final substring from the end of string
;; Useful for stripping filename extension
;;
;; @example
;; (strip-end "abcd" "cd") => "ab"
;; (strip-end "abcd" "c") => "abcd"
;; (strip-end "somedir/somefile.txt" ".txt") => "somedir/somefile"
(define (strip-end str fin)
  "(strip-end str fin) - strip the fin-string from the end of str"
  (if (ends-with str fin) (chop str (length fin)) str))

;; @syntax (newlisp-version)
;;
;; @return a version string like "newLisp v8.8.0-p0 on linux"
;;
;; ORIGIN<br>
;; Introduced by Sammo on newLISP Fan Club forum.
(define (newlisp-version)
  "(newlisp-version) - return version string"
  (let (OS '("unknown" "linux" "bsd" "osx" "solaris" "cygwin" "win32"
             "win32-Borland" "WinCE" "Tru64Unix")
        FORMAT "newLISP v%s.%s.%s-p%s on %s")
    (apply format (flat (list FORMAT (explode (string ((sys-info) -2)))
                              (OS ((sys-info) -1)))))))

;; @syntax (int10 <str> <int-default>)
;;
;; String to integer on base 10 conversion
;;
;; Converts a string to an integer strictly on base 10 (despite of leading
;; zeroes etc.)
(define (int10 str def)
  "(int10 str [def]) - converts str to int on base 10"
  (int str (if def def 0) 10))

;; @syntax (doc <sym-function>)
;;
;; Prints help on function
;;
;; If function body has a meaningless string value at it's start,
;; it will be returned, otherwise nil is returned.
;;
;; @example
;; (define (foo bar)
;;   "doc test function"
;;   (if bar (bla-bla-bla)
;;           (aaaarrgghhhh)))
;;
;; (doc foo) => "doc test function"

;; ORIGIN<br>
;; Nigel Brown and HPW has introduced this on newLisp forum.
; by nigelbrown & HPW
(define (doc f)
  "(doc f) - display function f's doc string, if present"
  (if (and (or (lambda? f) (macro? f))(string? (nth 1 f)))
      (nth 1 f)
      nil))

;; @syntax (make-k-permutations <k> <multiset>)
;;
;; Make permutation w/o duplicates
;;
;; @param <k> a permutation length >= (length <multiset>)
;; @param <multiset> a list for permutation
;;
;; Warren-Hanson algorithm for generating permutations of multisets.
;;
;; @example
;; (make-k-permutations 2 '(1 2)) => ((2 1) (1 2))

;; ORIGIN<br>
;; Copied from newLisp code snippets
; from newLisp code snippets
(define (make-k-permutations k multiset)
 "(make-k-permutations k multiset) - make permutations w/o duplicates"
 (let ((pivots (unique multiset)))
   (if (= k 1)
      (map list pivots)
      (let ((acc '()))
        (dolist (p pivots)
          (let ((sub-multiset (remove-from-list p multiset)))
            (dolist (sub-perm
                     (make-k-permutations (- k 1) sub-multiset))
              (push (cons p sub-perm) acc))))
        acc))))

;; @syntax (remove-from-list <elt> <lst>)
;;
;; Nondestructive remove element from list
(define (remove-from-list elt lst)
  "(remove-from-list elt lst) - nondestructive remove element from list"
  (let ((elt-pos (find elt lst)))
    (if elt-pos (pop lst elt-pos))
    lst))

;; @syntax (compose <lst> <lst> ...)
;;
;; Inter-compose lists
;;
;; Generate all possible combinations of lists's elements
;; @example
;; (compose '(a b) '(c d) '(e f))
;; =>
;; ((b d f) (b d e) (b c f) (b c e) (a d f) (a d e) (a c f) (a c e))
(define (compose )
  "(compose lst lst ...) - inter-compose lists"
  (let (res '())
   (compose-support (args) '()) res))

(define (compose-support l s)
  (if (empty? l)
   (push s res)
   (dolist (p (l 0))
    (compose-support (1 l) (append s (list p))))))

;; @syntax (++ '<int-a> <int-b>)
;;
;; Increment <int-a> by <int-b>.
;;
;; @param <int-a> can be either a symbol or a value
;;
;; ORIGIN<br>
;; Sammo has introduced this on newLisp forum.
; by Sammo, modified
(define (++ _a01 _b01)
  "(++ 'int-a int-b) - increment int-a by int-b. int-a can be either a symbol or a value"
  (if (symbol? _a01)
    (set _a01 (+ (or (eval _a01) 0) (or (eval _b01) 1)))
    (+ (or (eval _a01) 0) (or (eval _b01) 1))))

;; @syntax (-- '<int-a> <int-b>)
;;
;; Decrement <int-a> by <int-b>.
;;
;; @param <int-a> can be either a symbol or a value
(define (-- _a01 _b01)
  "(-- 'int-a int-b) - decrement int-a by int-b. int-a can be either a symbol or a value"
  (if (symbol? _a01)
    (set _a01 (- (or (eval _a01) 0) (or (eval _b01) 1)))
    (- (or (eval _a01) 0) (or (eval _b01) 1))))

;; @syntax (p++ '<int-a> <int-b>)
;;
;; Post-increment <int-a> by <int-b>.
(define (p++ _a01 _b01)
  "(p++ int-sym int-num) - post-increment int-sym by int-num"
  (let (_old (eval _a01))
    (++ _a01 (or _b01 1))
  _old))

;; @syntax (p-- '<int-a> <int-b>)
;;
;; Post-decrement <int-a> by <int-b>.
(define (p-- _a01 _b01)
  "(p-- int-sym int-num) - post-decrement int-sym by int-num"
  (let (_old (eval _a01))
    (-- _a01 (or _b01 1))
  _old))

;; @syntax (second <lst>)
;;
;; Returns the second element of a list
(define (second lst)
  "(second lst) - returns the second element from a list"
  (lst 1))

(global 'inc-p 'dec-p 'group 'group-all 'group-by 'lesser 'greater
  'append-one 'dirname 'strip-end 'newlisp-version 'int10 'doc
  'make-k-permutations 'remove-from-list 'compose
        '++ '-- 'p++ 'p-- 'second)


========================
 LITTLE SCHEMER LIBRARY  (wip)
========================

; Nome del file: "_newlisper.lsp"
; Questa libreria contiene tutte le funzioni (finali) definite dal libro
; "Little Schemer" di Friedman e Felleisen convertite in newLISP.

; Per caricare la libreria: (load "_newlisper.lsp")

(define (flat? lst)
  (cond
    ((null? lst) true)
    ((atom? (first lst)) (flat? (rest lst)))
    (true nil)))

(define (member? atm lst)
  (cond
    ((null? lst) nil)
    (true (or (= (first lst) atm)
              (member? atm (rest lst))))))

(define (rember atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (rest lst))
    (true (cons (first lst) (rember atm (rest lst))))))

(define (firsts lst)
  (cond
      ((null? lst) '())
      (true (cons (first (first lst)) (firsts (rest lst))))))

(define (firsts2 lst)
  (if (null? lst) '()
    (let (L '())
      (dolist (x lst)
        (cond
            ((null? x) (push '() L))
            ((atom? x) (push x L))
            ((atom? (first x)) (push (first x) L))
            ((list? (first x)) (push (first x) L))
        )
      )
      (reverse L))))

(define (insertR nuovo vecchio lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) vecchio)
                (cons vecchio (cons nuovo (rest lst))))
            (true (cons (first lst) (insertR nuovo vecchio (rest lst))))))))

(define (insertL nuovo vecchio lst)
  (cond
    ((null? lst) '())
    (true (cond
            ((= (first lst) vecchio)
                (cons nuovo (cons vecchio (rest lst))))
            (true (cons (first lst) (insertL nuovo vecchio (rest lst))))))))

(define (subst nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (rest lst)))
     (true (cons (first lst) (subst nuovo vecchio (rest lst))))))

(define (subst2 nuovo vecchio1 vecchio2 lst)
    (cond
      ((null? lst) '())
      ((or (= (first lst) vecchio1) (= (first lst) vecchio2))
       (cons nuovo (rest lst)))
      (true (cons (first lst) (subst2 nuovo vecchio1 vecchio2 (rest lst))))))

(define (multirember atm lst)
  (cond
    ((null? lst) '())
    ((= (first lst) atm) (multirember atm (rest lst)))
    (true (cons (first lst) (multirember atm (rest lst))))
  )
)

(define (multiinsertR nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons vecchio (cons nuovo (multiinsertR nuovo vecchio (rest lst)))))
     (true (cons (first lst) (multiinsertR nuovo vecchio (rest lst))))))

(define (multiinsertL nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (cons vecchio (multiinsertL nuovo vecchio (rest lst)))))
     (true (cons (first lst) (multiinsertL nuovo vecchio (rest lst))))))

(define (multisubst nuovo vecchio lst)
    (cond
     ((null? lst) '())
     ((= (first lst) vecchio) (cons nuovo (multisubst nuovo vecchio (rest lst))))
     (true (cons (first lst) (multisubst nuovo vecchio (rest lst))))))

(define (add1 n) (++ n))

(define (sub1 n) (-- n))

(define (o+ n m)
    (cond
     ((zero? m) n)
     (true (add1 (o+ n (sub1 m))))))

(define (o- n m)
    (cond
     ((zero? m) n)
     (true (sub1 (o- n (sub1 m))))))

(define (addtup tup)
    (cond
     ((null? tup) 0)
     (true (o+ (first tup) (addtup (rest tup))))))

(define (o* n m)
    (cond
     ((zero? m) 0)
     (true (o+ n (o* n (sub1 m))))))

(define (tup+ tup1 tup2)
    (cond
     ((null? tup1) tup2)
     ((null? tup2) tup1)
     (true (cons (o+ (first tup1) (first tup2))
             (tup+ (rest tup1) (rest tup2))))))

(define (o> n m)
    (cond
     ((zero? n) nil)
     ((zero? m) true)
     (true (o> (sub1 n) (sub1 m)))))

(define (o< n m)
    (cond
     ((zero? m) nil)
     ((zero? n) true)
     (true (o< (sub1 n) (sub1 m)))))

(define (o= n m)
    (cond
     ((o> n m) nil)
     ((o< n m) nil)
     (else true)))

(define (oexpt n m)
    (cond
     ((zero? m) 1)
     (true (o* n (oexpt n (sub1 m))))))

(define (oquotient n m)
    (cond
     ((o< n m) 0)
     (true (add1 (oquotient (o- n m) m)))))

(define (length- lst)
    (cond
     ((null? lst) 0)
     (true (add1 (length- (rest lst))))))

(define (pick n lst)
    (cond
     ((zero? (sub1 n)) (first lst))
     (true (pick (sub1 n) (rest lst)))))

(define (rempick n lst)
    (cond
     ((zero? (sub1 n)) (rest lst))
     (true (cons (first lst) (rempick (sub1 n) (rest lst))))))

(define (no-nums lst)
    (cond
     ((null? lst) '())
     (true
      (cond
       ((number? (first lst)) (no-nums (rest lst)))
       (true (cons (first lst) (no-nums (rest lst))))))))

(define (all-nums lst)
    (cond
     ((null? lst) '())
     ((number? (first lst)) (cons (first lst) (all-nums (rest lst))))
     (true (all-nums (rest lst)))))

(define (eqan? a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (o= a1 a2))
     ((and (number? a1) (number? a2)) (o= a1 a2))
     ((or (number? a1) (number? a2) nil))
     (true (= a1 a2))))

(define (occur a lst)
    (cond
     ((null? lst) 0)
     ((= (first lst) a) (add1 (occur a (rest lst))))
     (true (occur a (rest lst)))))

(define (one? n) (= n 1))

(define (rempick n lst)
    (cond
     ((one? n) (rest lst))
     (true (cons (first lst) (rempick (sub1 n) (rest lst))))))

(define (rember* a S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) a) (rember* a (rest S)))
       (true (cons (first S) (rember* a (rest S))))))
     (true (cons (rember* a (first S)) (rember* a (rest S))))))

(define (insertR* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons vecchio (cons nuovo (insertR* nuovo vecchio (rest S)))))
       (true (cons (first S) (insertR* nuovo vecchio (rest S))))))
     (true (cons (insertR* nuovo vecchio (first S)) (insertR* nuovo vecchio (rest S))))))

(define (occur* a S)
    (cond
     ((null? S) 0)
     ((atom? (first S))
      (cond
       ((= (first S) a) (add1 (occur* a (rest S))))
       (true (occur* a (rest S)))))
     (true (o+ (occur* a (first S)) (occur* a (rest S))))))

(define (subst* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons nuovo (subst* nuovo vecchio (rest S))))
       (true (cons (first S) (subst* nuovo vecchio (rest S))))))
     (true (cons (subst* nuovo vecchio (first S)) (subst* nuovo vecchio (rest S))))))

(define (insertL* nuovo vecchio S)
    (cond
     ((null? S) '())
     ((atom? (first S))
      (cond
       ((= (first S) vecchio) (cons nuovo (cons vecchio (insertL* nuovo vecchio (rest S)))))
       (true (cons (first S) (insertL* nuovo vecchio (rest S))))))
     (true (cons (insertL* nuovo vecchio (first S)) (insertL* nuovo vecchio (rest S))))))

(define (member* a S)
    (cond
     ((null? S) nil)
     ((atom? (first S))
      (or (= (first S) a) (member* a (rest S))))
     (true (or (member* a (first S)) (member* a (rest S))))))

(define (leftmost S)
    (cond
     ((atom? S) S)
     (true (leftmost (first S)))))

(define (eqan? a1 a2)
    (cond
     ((and (number? a1) (number? a2)) (= a1 a2))
     ((or (number? a1) (number? a2) nil))
     (true (= a1 a2))))

(define (equal? s1 s2)
    (cond
     ((and (atom? s1) (atom? s2)) (eqan? s1 s2))
     ((or (atom? s1) (atom? s2)) nil)
     (true (eqlist? s1 s2))))

(define (eqlist? lst1 lst2)
    (cond
     ((and (null? lst1) (null? lst2)) true)
     ((or (null? lst1) (null? lst2)) nil)
     (true
      (and (equal? (first lst1) (first lst2))
           (eqlist? (rest lst1) (rest lst2))))))

(define (rember S lst)
    (cond
     ((null? lst) '())
     ((equal? (first lst) S) (rest lst))
     (true
      (cons (first lst)
        (rember S (rest lst))))))

(define (numbered? aexp)
    (cond
     ((atom? aexp) (number? aexp))
     (true
      (and (numbered? (first aexp))
           (numbered? (first (rest (rest aexp))))))))

(define (value nexp)
    (cond
     ((atom? nexp) nexp)
     ((= (first (rest nexp)) 'o+)
      (o+ (value (first nexp))
          (value (first (rest (rest nexp))))))
     ((= (first (rest nexp)) 'o*)
      (o* (value (first nexp))
          (value (first (rest (rest nexp))))))
     (true
      (oexpt (value (first nexp))
             (value (first (rest (rest nexp))))))))

(define (first-sub-exp aexp)
    (first (rest aexp)))

(define (second-sub-exp aexp)
    (first (rest (rest aexp))))

(define (operator aexp)
    (first aexp))

(define (value nexp)
    (cond
     ((atom? nexp) nexp)
     ((= (operator nexp) 'o+)
      (o+ (value (first-sub-exp nexp))
          (value (second-sub-exp nexp))))
     ((= (operator nexp) 'o*)
      (o* (value (first-sub-exp nexp))
          (value (second-sub-exp nexp))))
     (true
      (oexpt (value (first-sub-exp nexp))
             (value (second-sub-exp nexp))))))

(define (first-sub-exp aexp)
    (first aexp))

(define (operator aexp)
    (first (rest aexp)))

(define (sero? n) (null? n))

(define (edd1 n)  (cons '() n))

(define (zub1 n) (rest n))

(define (o+ n m)
    (cond
     ((sero? m) n)
     (true (edd1 (o+ n (zub1 m))))))

(define (lat? lst)
  (cond
    ((null? lst) true)
    ((atom? (first lst)) (lat? (rest lst)))
    (true nil)))

(define (set? lat)
    (cond
     ((null? lat) true)
     ((member? (first lat) (rest lat)) nil)
     (true (set? (rest lat)))))

(define (makeset lat)
    (cond
     ((null? lat) '())
     (true (cons (first lat)
             (makeset
              (multirember (first lat) (rest lat)))))))

(define (subset? s1 s2)
    (cond
     ((null? s1) true)
     (true
      (and (member? (first s1) s2) (subset? (rest s1) s2)))))

(define (eqset? set1 set2)
    (and (subset? set1 set2) (subset? set2 set1)))

(define (intersect? set1 set2)
    (cond
     ((null? set1) nil)
     (true (or (member? (first set1) set2)
               (intersect? (rest set1) set2)))))

(define (intersects set1 set2)
    (cond
     ((null? set1) '())
     ((member? (first set1) set2)
      (cons (first set1) (intersects (rest set1) set2)))
     (true (intersects (rest set1) set2))))

(define (unions set1 set2)
    (cond
     ((null? set1) set2)
     ((member? (first set1) set2) (unions (rest set1) set2))
     (true (cons (first set1) (unions (rest set1) set2)))))

(define (differences  set1 set2)
    (cond
     ((null? set1) '())
     ((member? (first set1) set2) (differences (rest set1) set2))
     (true (cons (first set1) (differences (rest set1) set2)))))

(define (intersectall l-set)
    (cond
     ((null? (rest l-set)) (first l-set))
     (true (intersect (first l-set) (intersectall (rest l-set))))))

(define (a-pair? l)
    (cond
     ((atom? l) nil)
     ((null? l) nil)
     ((null? (rest l)) nil)
     ((null? (rest (rest l))) true)
     (true nil)))

(define (firstp p) (first p))

(define (secondp p) (first (rest p)))

(define (build s1 s2) (cons s1 (cons s2 '())))

(define (thirdp l) (first (rest (rest l))))

(define (fun? rel) (set? (firsts rel)))

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (build (secondp (first rel))
                        (firstp (first rel)))
             (revrel (rest rel))))))

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (cons (first (rest (first rel)))
                   (cons (first (first rel)) '()))
             (revrel (rest rel))))))

(define (revpair p)
    (build (secondp p) (first p)))

(define (revrel rel)
    (cond
     ((null? rel) '())
     (true (cons (revpair (first rel))
             (revrel (rest rel))))))

(define (seconds s)
    (cond
     ((null? s) '())
     (true (cons (first (rest (first s)))
             (seconds (rest s))))))

(define (fullfun? fun)
    (set? (seconds fun)))

(define (one-to-one? fun)
    (fun? (revrel fun)))

; continua...

'library-schemer-loaded


=====================
 MESSAGE-BOX LIBRARY
=====================

L'autore di questa libreria "message-box.lsp" è Dexter Santucci.
La libreria è reperibile all'indirizzo:

https://github.com/DexterLagan/newlisp-message-box

;; @module message-box.lsp
;; @description Definitions and a function to display message boxes on Windows
;; @version 1.0 - comments redone for automatic documentation
;; @author Dexter Santucci 2018
;; <h3>Definitions and a function to display message boxes on Windows</h3>
;; This module is platform-specific (Windows)
;;
;; Before using the module it must be loaded:
;; <pre>
;; (load "C:\Program Files (x86)/newlisp/modules/message-box.lsp")
;; ; or shorter
;; (module "message-box.lsp")
;; </pre>

(context 'win-message-box)

;;; imports

(import "user32.dll" "MessageBoxA")

;;; defs

; message box types
(constant 'MB_ABORTRETRYIGNORE      0x00000002) ; The message box contains three push buttons: Abort, Retry, and Ignore.
(constant 'MB_CANCELTRYCONTINUE     0x00000006) ; The message box contains three push buttons: Cancel, Try Again, Continue. Use this message box type instead of MB_ABORTRETRYIGNORE.
(constant 'MB_HELP                  0x00004000) ; Adds a Help button to the message box. When the user clicks the Help button or presses F1, the system sends a WM_HELP message to the owner.
(constant 'MB_OK                    0x00000000) ; The message box contains one push button: OK. This is the default.
(constant 'MB_OKCANCEL              0x00000001) ; The message box contains two push buttons: OK and Cancel.
(constant 'MB_RETRYCANCEL           0x00000005) ; The message box contains two push buttons: Retry and Cancel.
(constant 'MB_YESNO                 0x00000004) ; The message box contains two push buttons: Yes and No.
(constant 'MB_YESNOCANCEL           0x00000003) ; The message box contains three push buttons: Yes, No, and Cancel.

; message box icons
(constant 'MB_ICONEXCLAMATION       0x00000030) ; An exclamation-point icon appears in the message box.
(constant 'MB_ICONWARNING           0x00000030) ; An exclamation-point icon appears in the message box.
(constant 'MB_ICONINFORMATION       0x00000040) ; An icon consisting of a lowercase letter i in a circle appears in the message box.
(constant 'MB_ICONASTERISK          0x00000040) ; An icon consisting of a lowercase letter i in a circle appears in the message box.
(constant 'MB_ICONQUESTION          0x00000020) ; A question-mark icon appears in the message box.
(constant 'MB_ICONSTOP              0x00000010) ; A stop-sign icon appears in the message box.
(constant 'MB_ICONERROR             0x00000010) ; A stop-sign icon appears in the message box.
(constant 'MB_ICONHAND              0x00000010) ; A stop-sign icon appears in the message box.

; message box default button specification
(constant 'MB_DEFBUTTON1            0x00000000) ; The first button is the default button. MB_DEFBUTTON1 is the default unless another is specified.
(constant 'MB_DEFBUTTON2            0x00000100) ; he second button is the default button.
(constant 'MB_DEFBUTTON3            0x00000200) ; The third button is the default button.
(constant 'MB_DEFBUTTON4            0x00000300) ; The fourth button is the default button.

; message box modality
(constant 'MB_APPLMODAL             0x00000000) ; The user must respond to the message box before continuing work in the window (hWnd parameter).
(constant 'MB_SYSTEMMODAL           0x00001000) ; Same as MB_APPLMODAL except that the message box has the WS_EX_TOPMOST style.
(constant 'MB_TASKMODAL             0x00002000) ; Same as MB_APPLMODAL except that all the top-level windows belonging to the current thread are disabled if the hWnd parameter is NULL.

; message box other options
(constant 'MB_DEFAULT_DESKTOP_ONLY  0x00020000) ; If the current input desktop is not the default desktop, MessageBox does not return until the user switches to the default desktop.
(constant 'MB_RIGHT                 0x00080000) ; The text is right-justified.
(constant 'MB_RTLREADING            0x00100000) ; Displays message and caption text using right-to-left reading order on Hebrew and Arabic systems.
(constant 'MB_SETFOREGROUND         0x00010000) ; The message box becomes the foreground window.
(constant 'MB_TOPMOST               0x00040000) ; The message box is created with the WS_EX_TOPMOST window style.
(constant 'MB_SERVICE_NOTIFICATION  0x00200000) ; The caller is a service notifying the user of an event. If this flag is set, the hWnd parameter must be NULL.

; message box return values
(constant 'IDOK       1)
(constant 'IDCANCEL   2)
(constant 'IDABORT    3)
(constant 'IDRETRY    4)
(constant 'IDIGNORE   5)
(constant 'IDYES      6)
(constant 'IDNO       7)
(constant 'IDTRYAGAIN 10)
(constant 'IDCONTINUE 11)

;; @syntax (win-message-box:show <title> <message> <flags>)
;; @return The message box return value.
;;
;; Displays a message box matching the given <title> <message> and <flags>.
;; @example
;; (setq result (win-message-box:show "My Title" "Please select something:" (+ win-message-box:MB_CANCELTRYCONTINUE)))
;;
;; @example
;; (define appname "My Program")
;; (define result (win-message-box:show appname "Please select something:" (+ win-message-box:MB_CANCELTRYCONTINUE)))
;; (case result
;;    (1          (win-message-box:show appname "You clicked on OK."        win-message-box:MB_OK))
;;    (2          (win-message-box:show appname "You clicked on Cancel."    win-message-box:MB_OK))
;;    (10         (win-message-box:show appname "You clicked on Try Again." win-message-box:MB_OK))
;;    (11         (win-message-box:show appname "You clicked on Continue."  win-message-box:MB_OK))
;;    (true       (win-message-box:show appname (append "You clicked on ID: " (string result)) win-message-box:MB_OK)))
;; @example
;; (setq result (win-message-box:show "Test" "Select:"
;;              (+ win-message-box:MB_SETFOREGROUND
;;               win-message-box:MB_CANCELTRYCONTINUE
;;               win-message-box:MB_ICONQUESTION
;;               win-message-box:MB_DEFBUTTON3))
(define (show title message flags)
  (int (MessageBoxA 0 message title flags)))

; EOF


========================================
 KAZIMIR-MAJORINC
 Instprog.default-library.lsp
 http://kazimirmajorinc.com/Default.lsp
========================================

;;##############################################################
;;
;;                        Default.lsp
;;
;; Kazimir Majorinc, 2008-13
;;
;; It is library I typically load into all of my programs. It
;; contains many unrelated groups of functions, however, I do
;; not separate them into small libraries, because I do not
;; want to think about dependencies.
;;
;; If the version you look at is in HTML form, then you need to
;; copy all, paste in your text editor, and then save.
;;
;;##############################################################

(set 'Default.number-of-symbols.before
     (length (symbols)))

(set 'Default.number-of-primitives.before
     (length (filter primitive? (map eval (symbols)))))

(set 'Default.number-of-functions.before
     (length (filter lambda? (map eval (symbols)))))

(set 'Default.number-of-macros.before
     (length (filter macro? (map eval (symbols)))))

(set 'Default.loading-time (time (begin

;===============================================================
; Group:             The constants needed for protection of the
;                    symbols.

(set 'left-parenthesis-equivalent ".<_")
(set 'right-parenthesis-equivalent ".>_")
(set 'blank-equivalent "____")
(set 'apostrophe-equivalent "`")
(set 'quotation-mark-equivalent "~")

;===============================================================
;
; Group:             Transformation from sexprs to symbols and
;                    vice versa
;
; Names:             symbol-to-sexpr
;                    symbol-from-sexpr
;                    sexpr-to-symbol
;                    sexpr-from-symbol

(set 'symbol-to-sexpr
     (lambda(S)
       (setq S (string S))
       (setq S (replace left-parenthesis-equivalent S "("))
       (setq S (replace right-parenthesis-equivalent S ")"))
       (setq S (replace blank-equivalent S " "))
       (setq S (replace apostrophe-equivalent S "'"))
       (setq S (replace quotation-mark-equivalent S "\""))
       (eval-string (append "'" S))))

(set 'sexpr-from-symbol symbol-to-sexpr)

(set 'sexpr-to-symbol
     (lambda(L)
       (setq L (string L))
       (setq L (replace "("  L left-parenthesis-equivalent))
       (setq L (replace ")"  L right-parenthesis-equivalent))
       (setq L (replace " "  L blank-equivalent))
       (setq L (replace "'"  L apostrophe-equivalent ))
       (setq L (replace "\"" L quotation-mark-equivalent ))
       (sym L)))

(set 'symbol-from-sexpr sexpr-to-symbol)

;===============================================================
;
; Group:             Dynamic scope protection.
;
;---------------------------------------------------------------
;
; Names:             set-protected1,
;                    set-protected2,
;                    protect1,
;                    protect2
;
; Type:              functions
;
; Syntax:            (set-protected1 <name> <definition-code> <variables-to-be-protected>)
;                    (set-protected2 <name> <definition-code> <variables-to-be-protected>)
;                    (protect1 <name> <vars>)
;                    (protect2 <name> <vars>)
;
; Purpose:           Protection from accidental name clashes.
;                    In dynamic scope, variables can be accidentally
;                    overwritten. Especially well known is so called
;                    funarg problem. Functions protect1 and protect2
;                    make accidental overwritting less probable
;                    by automatic renaming of variables, while
;                    keeping dynamic scope. Protect1 provides same
;                    level of safety as contexts, while Protect2,
;                    as far as I can see, prevent even the hardest
;                    funarg problems.


(set 'set-protected1
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (expand definition-code
              (map (lambda(x)
                        (list x (symbol-from-sexpr (list function/macro-name x))))
                        variables)))))

(set 'protect1 (lambda(function/macro-name variables)
                 (set-protected1 function/macro-name
                                 (eval function/macro-name)
                                 variables)))

((copy set-protected1) 'set-protected1
                        set-protected1
                        '(function/macro-name definition-code
                                              variables
                                              x))

((copy protect1) 'protect1 '(function/macro-name variables))

(set 'set-protected2
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (expand
         (lambda-macro()
            (let((name-and-counter (symbol-from-sexpr
                                      (list 'function/macro-name
                                            (inc protected2-counter)))))

                (set-protected1 name-and-counter
                                definition-code
                                'variables)

                (first (list (eval (cons name-and-counter $args)) ;apply = eval cons
                             (dolist(i 'variables)
                               (delete (symbol-from-sexpr
                                  (list name-and-counter i))))
                             (delete name-and-counter))))) ; no need for (dec counter)

           'function/macro-name 'definition-code 'variables))))

(set 'protect2
     (lambda(function/macro-name variables)
        (set-protected2 function/macro-name
                      (eval function/macro-name)
                      variables)))

(protect1 'set-protected2 '(function/macro-name definition-code
                            variables counter name-and-counter i))

(protect1 'protect2 '(function/macro-name variables))

;---------------------------------------------------------------

(protect1 'sexpr-to-symbol '(L))
(protect1 'symbol-from-sexpr '(L))
(protect1 'symbol-to-sexpr '(S))
(protect1 'sexpr-from-symbol '(S))

;===============================================================
;
; Group:             Protection from accidental name clashes.
;
; Names:             <°original_°!>°, <°original_°!=>°,
;                    <°original_°$>°...
;
; Explanation        These symbols point to original versions
;                    of built in functions !, != etc, that might
;                    be needed in case original names are redefined.
;
; Example           (constant 'sin cos)
;                   ...
;                   (constant 'sin
;                             (eval (symbol-from-sexpr '(original sin))))

(set 'original
  (lambda(x)
    (symbol-from-sexpr (list 'original x))))

(dolist(i (symbols))
  (when (primitive? (eval i))
        '(println i ", " (original i) ", " (eval i))
        (set (original i) (eval i))))

;===============================================================
;
; Group            Handy predicates
;
; Name             positive? negative?
;

(define (positive? x)(> x 0))
(protect1 'positive '(x))

(define (negative? x)(< x 0))
(protect1 'negative '(x))


;===============================================================
;
; Group:            Protection from accidental name clashes.
;
; Name:             originalize
;
; Type:             function
;
; Explanation       replace variables in function definition with
;                   variables with prefix original
;
; Example           (set 'f (lambda(x y)x y))
;
;                   After
;
;                          (originalize 'f '(x))
;
;                   f is
;
;                   (lambda (<°original·x>° y) <°original·x>° y)

(set 'originalize
  (lambda(function/macro-name variables)
    (set function/macro-name
         (expand (eval function/macro-name)
                 (map (lambda(x)(list x (original x)))
                      variables)))))

; (set 'f (lambda(x y)x y))
; (originalize 'f '(x))
; (println f)
;

;===============================================================
;
; Group:             Supressing printing
;
; Functions:         print, println
;
; Symbols:           (symbol-from-sexpr '(println supressed))
;                    (symbol-from-seprx '(print supressed))
;
; Purpose            Supress printing in some parts of the program.
;                    Functions print and println are redefined to
;                    work dependently on the value of
;                    (symbol-from-sexpr '(println supressed)) symbols
;
; Example:           (set (symbol-from-sexpr '(println supressed)) true)

(set 'evaluate-all-and-return-last begin)

(constant 'print
          (lambda-macro()(eval (cons (if (or (eval (symbol-from-sexpr '(print supressed)))
                                             [print.supressed])
                                         evaluate-all-and-return-last
                                         (original 'print))
                                      (args)))))

(constant 'println
          (lambda-macro()(eval (cons (if (or (eval (symbol-from-sexpr '(println supressed)))
                                             [println.supressed])
                                         evaluate-all-and-return-last
                                         (original 'println))
                                      (args)))))

;===============================================================
;
; Group:             Expressions as graphs
;
; Names:             depth, size, width
;
; Syntax:            (depth <L>) - length of the longest branch
;                    (size <L>) - number of nodes
;                    (size2 <L>) - number of nodes, nonleafs count
;                                  as 2
;                    (width <L>) - number of branches
;                    (size-string <L>) - size as string
;
; Examples:

(set 'depth (lambda(x)
               (cond ((quote? x)(+ 1 (depth (eval x))))
                     ((and (list? x) (empty? x)) 1)
                     ((list? x)(+ 1 (apply max (map depth x))))
                     (true 1))))

(set 'size (lambda(x)
              (+ 1 (cond ((quote? x)(size (eval x)))
                         ((list? x)(apply + (map size x)))
                         (true 0)))))
(set 'size (lambda(x)
              (+ 1 (cond ((quote? x)(size (eval x)))
                         ((list? x)(apply + (map size x)))
                         (true 0)))))

(set 'size2 (lambda(x)
              (+ 1 (cond ((quote? x)(size (eval x)))
                         ((list? x)(+ (apply + (map size2 x)) 1))
                         (true 0)))))

(set 'width (lambda(x)
              (cond ((quote? x)(width (eval x)))
                    ((list? x)(apply + (map width x)))
                    (true 1))))

(set 'width-noq (lambda(x)
              (cond ;((quote? x)(width (eval x)))
                    ((list? x)(apply + (map width x)))
                    (true 1))))

(set 'size-string (lambda(x)(length (string x))))

;===============================================================
;
; Group:             "Safe assignement"
;
;---------------------------------------------------------------
;
; Symbols:           set-undefined, SU
;                    setf-undefined, SfU
;                    setq-undefined, SqU
;
; Purpose:           Assignement that prevents unintentional
;                    redefinition of already defined symbols.
;                    Thesw work just as normal set, setf and setq,
;                    except they
;
; Syntax:            (set-undefined <var-expr> <val-expr>)
;                    (SU <var-expr> <val-expr>)
;                    (setf-undefined <var-expr> <val-expr>)
;                    (SfU <var-expr> <val-expr>)
;                    (setq-undefined <var-expr> <val-expr>)
;                    (SqU <var-expr> <val-expr>)
;

;
; Effects:           Assigns result of evaluation of val-expr to
;                    result of evaluation of var-expr, just like
;                    set, but throws error in the case val-expr
;                    already has an value.
;
; Result:            nil
;
; Error conditions:  var-expr is already defined.
;
; Example:           (set-undefined 'x 44), (SU 'x 44)
;
; Limitation:        If value of some symbol is intentionally
;                    defined as nil, SU recognizes it as undefined.

(set 'set-undefined
     (lambda-macro(var-expr val-expr)
        (let ((evar-expr (eval var-expr)))
             (when (eval evar-expr)
                   (throw-error (append (dup (char 8) 3)
                                        ": (set-undefined " (string var-expr)
                                         " ...) is already defined ")))
             (set 'toeval (list 'set
                                (list 'quote evar-expr)
                                val-expr))
             (eval toeval)
             (println "Defined " evar-expr " with size=" (size (eval evar-expr))
                              ", depth=" (depth (eval evar-expr))
                              " and width=" (width (eval evar-expr)) ".\n")
             nil)))

(set 'setf-undefined
     (lambda-macro(var-expr val-expr)
        (when (eval var-expr)
                   (throw-error (append (dup (char 8) 3)
                                        ": (setf-undefined " (string var-expr)
                                         " ...) is already defined ")))
        (set 'toeval (list 'setf
                           var-expr
                           val-expr))
        (eval toeval)
        (println "Defined " evar-expr " with size=" (size (eval evar-expr))
                              ", depth=" (depth (eval evar-expr))
                              " and width=" (width (eval evar-expr)) ".\n")
        nil))

(set 'setq-undefined
     (lambda-macro(var-expr val-expr)
        (when (eval var-expr)
                   (throw-error (append (dup (char 8) 3)
                                        ": (setq-undefined " (string var-expr)
                                         " ...) is already defined ")))
        (set 'toeval (list 'setq
                           var-expr
                           val-expr))
        (eval toeval)
        (println "Defined " evar-expr " with size=" (size (eval evar-expr))
                              ", depth=" (depth (eval evar-expr))
                              " and width=" (width (eval evar-expr)) ".\n")
        nil))

(set-undefined 'SU set-undefined)
(set-undefined 'SfU setf-undefined)
(set-undefined 'SqU setq-undefined)

(set 'protect-later
     '(begin (protect1 'set-undefined '(var-expr val-expr evar-expr toeval))
             (protect1 'SU '(var-expr val-expr evar-expr toeval))
             (protect1 'setf-undefined '(var-expr val-expr toeval))
             (protect1 'SfU '(var-expr val-expr toeval))
             (protect1 'setq-undefined '(var-expr val-expr toeval))
             (protect1 'SqU '(var-expr val-expr toeval))))

;===============================================================
;;
;; Group:            Long lines for printing
;;
;;--------------------------------------------------------------
;;
;; Name:             ---, ===, +++, ***, ###, $$$$, ///, \\\,
;;                   |||, ___, ...
;;
;; Type:             Functions.
;;
;; Syntax:           (---), (===), (+++) ...
;;
;; Purpose:          Long lines useful in printing.
;;
;; Result:           Line 64 characters long.
;;
;; Limitation:       Some characters are special and cannot
;;                   be used as the names of the functions
;;                   on the simple way. For example (###) cannot.
;;                   For that case, more complicated expressions
;;                   like (eval (list (sym "###"))) are possible
;;                   although unpractical.

(dostring (i "-=+*#$/\|_~^%&<>@.")
  (SU (sym (dup (char i) 3))
      (expand (lambda()(println (dup (char i) 64)))
               'i)))

(println "--------------------------------------------------------------")
(println "           Default.lsp is loading            ")
(println "--------------------------------------------------------------")

;;==============================================================
;;
;; Group:            With
;;
;;--------------------------------------------------------------
;;
;; Name:             with-device
;;
;; Type:             Macro
;;
;; Syntax:           (with-device (_ _ _) ...)
;;
;; Works like        (device _ _ _) ... (close (device))
;;
;;--------------------------------------------------------------


(define-macro (with-device l)
   (letn((l1 (args))
         (l2 (append (list 'begin (list 'device l))
                     l1
                     (list (quote (close (device)))))))
   ;(println l2)
   (eval l2)))

;;==============================================================
;;
;; Group:            Expression testing support.
;;
;;--------------------------------------------------------------
;;
;; Name:             assert, test
;;
;; Type:             Macros.
;;
;; Syntax:           (assert <expr>)
;;                   (test <name> <expr>)
;;
;; Parameters:       <name> - string that describes test.
;;                   <expr> - expression that will be evaluated.
;;
;; Purpose:          Testing expressions and catching errors.
;;                   If expression fails, report is printed.
;;                   In the case of assert, evaluation of the
;;                   program stops.
;;
;; Result:           Result of the evaluation of expression.
;;
;; Side effects:     Following global variables are used:
;;                   [test.counter]
;;
;; Error conditions: unknown
;;
;; Note:             assert and test are protected with functions
;;                   protect1, see under definition of protect1.

(SU '[test.counter] 0)
(SU '[test.failed] 0)
(SU '[test.passed] 0)

(SU 'test
     (lambda-macro(testname expr)
        (inc [test.counter])
        (if (eval expr)
            (begin (inc [test.passed])
                   (dotimes(i [test.failed])
                     (print "-"))
                   (println "Passed " [test.counter]
                            ". test \"" testname "\"\n     " expr ".\n"))
            (begin (inc [test.failed])
                   (println "\n*********\nFAILED " [test.counter]
                            ". test \"" testname "\"\n     " expr ".\n")))))

(push '(protect1-simplified 'test '(testname expr i))
      protect-later
      -1)

(SU 'assert
     (lambda-macro(expr)
         (unless (eval expr)
                 (println "Asserted " expr " FAILED.")
                 (throw-error "Assertion failed."))))

(push '(protect1-simplified 'assert '(expr))
      protect-later
      -1)

(test "should pass" (= (+ 1 2) 3))
(test "should fail" (= (+ 4 5) 7))
(assert (= 2 2))



;===============================================================
;;
;; Group:            Special appends.
;;
;;--------------------------------------------------------------
;;
;; Name:             symbol-append, string-append, +sym, -sym +$
;;
;; Type:             Functions.
;;
;; Purpose:          Frequently useful concatenation of symbols
;;                   or strings.
;;
;; Syntax:           (symbol-append <x1> <x2> ... <xm>)
;;
;; Parameters:       <x1>, ... <xm> - expressions evaluating to
;;                   strings or symbols.
;;
;; Result:           symbol or string resulting from concatenation
;;                   of <x1> <x2> ... <xm>
;;
;; Side effects:     No known side effects.
;;
;; Error conditions: Nothing particular.
;;
;; Examples:         (symbol-append 'a "b" 34) => ab34
;;                   (symbol-append 'a "b" 34) => "ab34"

(test "string" (= (string 'a "b" 34) "ab34"))

; original
;
;(SU 'string-append (lambda()(apply 'append (map string $args))))
;
; can be simplified into:

(SU 'string-append (lambda()(apply string $args)))
(SU '+$ string-append)

    (test "+$" (= (+$  'a "b" 34) "ab34"))

(SU 'symbol-append (lambda()(sym (apply 'append (map string $args)))))
(SU '+sym symbol-append)

    (test "+sym" (= (+sym 'a "b" 34) 'ab34))

(SU '-sym (lambda(x y)
             (when (> (length (args)) 0)
                (throw-error "-sym for 3+ arguments not implemented yet."))
             (if (ends-with (string x) (string y))
                 (sym (chop (string x) (length (string y))))
                 (throw-error (append "(-sym " x " " y "): x doesn't end with y")))))

    (test "-sym1" (= (-sym 'a1 "") 'a1))
    (test "-sym2" (= (-sym 'a1 1) 'a))
    (test "-sym3" (= (-sym 'a12 12) 'a))

(SU 'ends-with-sym (lambda(x y)
                    (ends-with (string x) (string y))))

    (test "ends-with-sym" (ends-with-sym 'a1 1))


(SU 'protect1-simplified-unsafe-with-current-values
   (lambda(safename unsafename vars)
      (inc [protect1.counter])
      (dolist(i vars)
          (set (+sym "[" safename "." i "]") (eval i)))
      (set safename
           (eval (list 'letex
                       (map (lambda(x)
                               (expand '(x (+sym "[" safename "." 'x "]"))
                                       'x))
                            vars)
                       (eval unsafename))))))

(SU 'protect1-simplified-with-original-values
   (lambda(safename unsafename vars)
      (inc [protect1.counter])
      (dolist(i vars)
          (set (+sym "[" safename "." i "]") (eval i)))
      (set safename
           (eval (list 'letex
                       (map (lambda(x)
                               (expand '(x (+sym "[" safename "." 'x "]"))
                                       'x))
                            vars)
                       (eval unsafename))))))

;;==============================================================
;;
;; Group:              Debug support.
;;
;; Names:              debug-wrap, debug-unwrap
;;
;; Type:               macros.
;;
;; Syntax:             (debug-wrap <name>)
;;                     (debug-unwrap <name>)
;;
;;                     where <name> is name of the primitive,
;;                     function or macro.

(SU 'pretty-string (lambda(L)
  (if (not (list? L))
      (string L)
      (let ((result "(")
            (blanks (dup " " (- (depth L) 1))))
            (dolist(i L)
              (if (list? i)
                  (extend result (pretty-string i))
                  (extend result (string i)))
              (when (!= (+ $idx 1) (length L)) (extend result blanks)))
            (extend result ")")))))

(protect1 'pretty-string '(L result i blanks))

;;==============================================================
;;
;; Group:              Debug support.
;;
;; Names:              debug-wrap, debug-unwrap
;;
;; Type:               macros.
;;
;; Syntax:             (debug-wrap <name>)
;;                     (debug-unwrap <name>)
;;
;;                     where <name> is name of the primitive,
;;                     function or macro.

; usage: (debug-wrap <function-name|macro-name|primitive-name>)
;        (debug-unwrap <function-name|macro-name|primitive-name>)
;
; Example:
;
; (debug-wrap fibo)
; (fibo 4)
;
; After that, (fibo 4) beside evaluating result, also produces
; following output in the properly indented s-expr form:
;
; (fibo (in 4)
;       (fibo (in 3)
;             (fibo (in 2)
;                   (out 1)); t=0, mem=0, sym=0
;             (fibo (in 1)
;                   (out 1)); t=0, mem=0, sym=0
;             (out 2)); t=1, mem=0, sym=0
;       (fibo (in 2)
;             (out 1)); t=1, mem=0, sym=0
;       (out 3)); t=3, mem=0, sym=0
;
; If you have bug in some of your function, just produce output
; on this way, and if needed copy output into some editor that
; recognize parentheses (I prefer PLT Scheme) and find where error
; occured. You can "debug-wrap" and later "debug-unwrap" many
; function in the same time, output will be properly nested.
; If your bugs are complicated and truely logical, this approach
; beats IDE, because you'll have complete evaluation "on paper"
; instead "in time."
;

(SU (symbol-from-sexpr '(debug-wrap indent)) 0)

(SU 'debug-wrap
  (lambda-macro();`function-name)
   (dolist(`function-name (args))
    (letn ((function-name (eval `function-name))
           (indent-step (+ (length (string `function-name)) 2))
           (in-line (append "(" (string `function-name) " " ))
           (is-function (lambda? function-name)))
       ((if (protected? function-name) set constant)
        `function-name
        (expand
           (lambda-macro()
             function-name
             (local (t
                     result
                     used-memory-before
                     used-memory-after
                     symbols-before
                     symbols-after
                     to-be-evaluated
                     largs
                     eargs
                     indent2)

                (set 'largs (args))
                (when is-function (set 'eargs (map eval largs)))

;                 (println (dup " " indent)
;                          in-line
;
;                          (cons 'in (if is-function (map string eargs)
;                                                    (map string largs )))
;                           ;"; is-function=" is-function "; largs=" largs "; eargs=" eargs
;                           )
                  (pretty-print 50000)
                  (setf indent2 (+ (apply max
                                      (map length
                                           (map string
                                                (if is-function eargs largs)))) 2))

                  (print (dup " " indent) in-line "(in ")
                  (println (dup " " indent2) " ; " (length (if is-function eargs largs)) ". args ")
                  (dolist (t2 (if is-function eargs largs))
                      (println (dup " " (+ indent 4 (length in-line)))
                               (if (string? t2) "\"" "")
                               (string t2)
                               (if (string? t2) "\"" "")
                               (if (symbol? t2)
                                     (append
                                       (dup " " (- indent2 (length (string t2))))
                                       " ; symbol")
                                       "")))
                  (println (dup " " (+ indent (length in-line))) ")")
;

                (inc indent indent-step)
                (set 'to-be-evaluated
                     (cons function-name
                           (if is-function (map quote eargs)
                                           largs)))
                (set 'symbols-before (length (symbols)))
                (set 'used-memory-before (sys-info 0))

                (set 't (time (set 'result (eval to-be-evaluated))))

                (set 'used-memory-after (sys-info 0))
                (set 'symbols-after (length (symbols)))

                (print (dup " " indent)
                         "(out " (if (string? result)
                                     (append "\"" result "\"")
                                     (string result))
                         "))")

                (print "; t=" t)
                (print "; mem=" (- used-memory-after used-memory-before 2))
                (print "; syms=" (- symbols-after symbols-before))
                (println)

                (dec indent indent-step)
                result))
               'function-name
               'indent-step
               'in-line
               'is-function))
               nil))))

; pažnja: debug-wrap ne radi za funkcije koje ne primaju argumente.

(originalize 'debug-wrap '(+ - > append args cons constant
                          dec dup eval expand if inc lambda?
                          length length letn local map print println
                          protected? quote set string string? symbols
                          sys-info time when))

'(println debug-wrap)

(protect1 'debug-wrap '(`function-name
                         function-name
                         indent
                         indent2
                         indent-step
                         in-line
                         is-function
                         t
                         t2
                         result
                         used-memory-before
                         used-memory-after
                         symbols-before
                         symbols-after
                         to-be-evaluated
                         largs
                         eargs))

(SU 'debug-unwrap
     (lambda-macro()
       (letn ((`function-name (first (args)))
              (function-name (eval `function-name)))
             ((if (protected? function-name) set constant)
                  `function-name
                  (nth 1 function-name)))))

(protect1 'debug-unwrap '(`function-name function-name))

;===============================================================
;;
;; Group:            Association list support
;;
;;--------------------------------------------------------------
;;
;; Name:             assoc-list,
;;                   let-from-assoc-list, letn-from-assoc-list
;;                   setf-from-assoc-list, ath, assoc-values
;;                   modify-assoc-list

(SU 'assoc-list
  (lambda()
     (map (lambda(x)(list x (eval x))) (args))))

     (protect1 'assoc-list '(x))

     (test "assoc-list" (= (let((x1 1)(x2 2)(x3 3))
                              (assoc-list 'x1 'x2 'x3))
                           '((x1 1)(x2 2)(x3 3))))

;;--------------------------------------------------------------
(SU 'let-from-assoc-list
    (lambda(L)
       (eval (append (list 'let-from-assoc-list L) (args)))))

     (protect1 'let-assoc-list '(L))
;;--------------------------------------------------------------
(SU 'letn-from-assoc-list
    (lambda(L)
      (eval (append (list 'letn-from-assoc-list L)) (args))))

     (protect1 'letn-from-assoc-list '(L))
;;--------------------------------------------------------------
(SU 'setf-from-assoc-list
    (lambda(L)
       (eval (cons 'setf (apply append L)))))

     (protect1 'setf-from-assoc-list  '(L))

     (test "setf-from-assoc-list"
           (= (begin (setf-from-assoc-list '((x1 44)(x2 55)(x3 66)))
                     (+ x1 x2 x3))
               165))
;;--------------------------------------------------------------
(SU 'aval
     (lambda(a b)(last (assoc a b))))

     (protect1 'aval '(a b))
;;--------------------------------------------------------------
(SU 'avals
     (lambda(a b)(rest (assoc a b))))

     (protect1 'avals '(a b))
;;--------------------------------------------------------------
(SU 'setfa1
    (lambda(a b)
      (local(flag result)
         (setf result (map (lambda(x)(if (= (first x) a)
                                         (begin (setf flag true)
                                                (list a (eval a)))
                                         x))
                           b))
         (when (not flag) (push (list a (eval a)) result -1))
         result)))

     (protect1 'setfa1 '(a b flag result))

(test "setfa1"
      (= (begin (setf L '((x1 44)(x2 55)(x3 56)))
                (setf x2 57)
                (setf L (setfa1 'x2 L))
                L)
        '((x1 44)(x2 57)(x3 56))))

(SU 'setfa2
    (lambda(a b)
      (local(flag result)
        (setf result (map (lambda(x)(if (= (first x) (first a))
                                        (begin (setf flag true)
                                               a)
                                        x))
                           b))
        (when (not flag) (push a result -1))
        result)))

     (protect1 'setfa2 '(a b flag result))

(test "setfa2"
      (= (begin (setf L '((x1 44)(x2 55)(x3 56)))
                (setf L (setfa2 '(x2 57) L))
                L)
        '((x1 44)(x2 57)(x3 56))))

(SU 'setfa
    (lambda-macro(a L b)
      ;(println L a b)
      (local(flag result)
        (set L (map(lambda(x)(println x a)
                             (if (= (first x) a)

                                  (begin (setf flag true)
                                         (list a (eval b)))
                                  x))
                    (eval L)))
        (when (not flag) (push (list a (eval b)) (eval L) -1)))
        L))

(SU 'seta
    (lambda(a L b)
      ;(println L a b)
      (local(flag result)
        (set L (map(lambda(x);(println x a)
                             (if (= (first x) a)

                                  (begin (setf flag true)
                                         (list a b))
                                  x))
                    (eval L)))
        (when (not flag) (push (list a b) (eval L) -1)))
        L))


;---------------------------------------------------------------
;
; Group:              recursive map


(define (recursive-map f x)
  (if (atom? x) (f x)
      (map (lambda(y)(recursive-map f y)) x)))

(protect1 'recursive-map '(f x y))

'(test "recursive-map" (= (recursive-map (lambda(x)(* x x))
                                        '(1 (2 (3 4) 5 6)))
                         '(1 (4 (9 16) 25 36))))

;;==============================================================
;;
;; Group:              sublists
;;
;; Names:              sublists
;;
;

(set 'sublists
   (lambda(L)
     (if (zero? (length L))
         '(())
         (let ((s (sublists (chop L))))
              (append s (map (lambda(x)(append x (list (last L))))
                             s))))))

(protect1 'sublists '(L s x))

;;==============================================================
;;
;; Group:              Fibonacci numbers
;;
;; Names:              fibo, fibo2
;;
;; Usage:              (fibo n) and (fibo2 n) evaluates to
;;                     nth Fibonacci number, using recursive and
;;                     non-resursive algorithm respectively.

(set 'fibo (lambda(n)
              (if (<= n 2)
                  1
                  (+ (fibo (- n 1))
                     (fibo (- n 2))))))

(protect1 'fibo '(n))

(SU 'fibo2 (lambda(n)
             (let ((n1 1)(n2 1))
                  (dotimes(i (/ (- n 1) 2))
                    (setq n1 (+ n1 n2))
                    (setq n2 (+ n1 n2)))
                  (if (even? n) n2 n1))))

(protect1 'fibo2 '(n n1 n2))


;===============================================================
; Group:             Multi-loops
;---------------------------------------------------------------
; Names:             list-to-single-expression
; ------
; Syntax:            (list-to-single-expression 'L)
; -------
; Description:       It creates one expression from list of expressions
; ------------
; Examples:          (list-to-single-expression '())
; ---------                    -> (begin)
;
;                    (list-to-single-expression '(expr1))
;                              -> expr1
;
;                    (list-to-single-expression '(expr1 ... exprn))
;                              -> (begin expr1 ... exprn)

(SU 'list-to-single-expression
     (lambda(L)
       (if (= (length L) 1)
           (first L)
           (cons 'begin L))))

(SU 'LSE list-to-single-expression)
(protect1 'list-to-single-expression '(L))
(protect1 'LSE '(L))

;;==============================================================
;;
;; Group:            Identity function and macro.
;;
;;--------------------------------------------------------------
;;
;; Name:             identity-function, IF
;;                   identity-macro, IM
;;
;; Type:             Function and macro, respectively.
;;
;; Purpose:          Identity and identity-macro return their
;;                   arguments, evaluated and non-evaluated
;;                   respectively. Identity is very important
;;                   from mathematical point of view.
;;
;; Syntax:           (identity-function <expr>),
;;                   (identity-macro <expr>)
;;                   (IF <expr>)
;;                   (IM <expr>)
;;
;; Parameters:       <expr> - any evaluable expression
;;
;; Result:           Evaluated and unevaluated <expr> respectively.
;;
;; Side effects:     no
;;
;; Error condition:  These functions and macros do not cause
;;                   error on their own.
;;
;; Example:          (set 'x '(+ 2 3))
;;                   (identity-function x) => (+ 2 3)
;;                   (identity-macro x) => x

(SU 'identity-function (lambda(x)x))
(SU 'IF identity-function)

(protect1 'identity-function '(x))
(protect1 'IF '(x))

(SU 'identity-macro (lambda-macro(x)x))
(SU 'IM identity-macro)

(protect1 'identity-macro '(x))
(protect1 'IM '(x))

(test "identity-function" (= (identity-function (+ 2 3)) 5))
(test "identity-macro" (= (identity-macro (+ 2 3)) '(+ 2 3)))

;;==============================================================
;;
;; Group:          Print support.
;;
;;--------------------------------------------------------------
;;
;; Name:            =$, ->$
;;
;; Type:            macro
;;
;; Syntax:          (=$ <expr>)
;;                  (->$ <expr>)
;;
;; Parameters:      <expr> - any s-expression
;;
;; Result:          string containing expr, = and result of
;;                  evaluation of the expression.
;;
;; Side effects:    expr is evaluated
;;
;; Error condition: if evaluation of expr causes error
;;
;; Examples:        (=$ (sin 1)) -> "(sin 1)=0.8414709848;"
;;                  (->$ (sin 4)) -> "(->(sin 4) -0.7568024953)"

(SU '=$ (lambda-macro(a)(append (string a)
                                 "="
                                 (string (eval a))
                                 "; ")))

(protect1 '=$ '(a))

(test "=$" (= (=$ (sin 1)) "(sin 1)=0.8414709848; "))

(SU '->$ (lambda-macro()(append "(->"
                                (string (first (args)))
                                " "
                                (string (eval (first (args))))
                                "); ")))

(test "->$" (= (->$ (sin 4)) "(->(sin 4) -0.7568024953); "))

;;==============================================================
;;
;; Group:          Print support.
;;
;;--------------------------------------------------------------
;;
;; Name:            print=, println=, print->, println->
;;
;; Type:            macros.
;;
;; Syntax:          (print= expr1 ... exprn) and similar
;;
;; Parameters:      expr1 ... exprn - any s-expression
;;
;; Result:          Result of evaluation of (=$ exprn) or (->$ exprn)
;;

(SU 'print=
    (lambda-macro()
      (doargs(i)
         (print i)
         (unless (or (string? i) (number? i) (macro? i) (lambda? i))
                 (print "=" (eval i) "; ")))))

(protect1 'print= '(i))

(SU 'println= (lambda-macro()
                   (eval (cons print= (args)))
                   (println)))

(SU 'print-> (lambda-macro()
                (eval (cons 'print
                            (map (lambda()(list '->$
                                                (first (args))))
                                 (args))))))

(SU 'println-> (lambda-macro()
                   (eval (cons print-> (args)))
                   (println)))

;;==============================================================
;;
;; Group:          Print support.
;;
;;--------------------------------------------------------------
;;
;; Name:           printlist

(SU 'printlist (lambda-macro(L)
                 (underline (string L) "-")
                 (dolist(i (eval L))
                      (println (+ $idx 1) ". " i))))

(SU 'PL printlist)
(protect1 'printlist '(i L))
(protect1 'PL '(i L))


;;==============================================================
;;
;; Group:            Booleans constant and predicate.
;;
;;--------------------------------------------------------------
;;

(SU 'booleans '(true nil))
(SU 'boolean? (lambda(x)(or (= x true) (= x nil))))
(protect1 'boolean? '(x))

;;==============================================================
;;
;; Group:            Operators of propositional calculus.
;;
;;--------------------------------------------------------------
;;
;; Name:             yest, nor, nand, xor, ->, <-, <->, -><-, false
;;
;; Type              Functions.
;;
;; Purpose:          Useful in logic and general programming

(SU 'yest (lambda()(first $args)))
(SU 'nor (lambda()(not (apply or $args))))
(SU 'nand (lambda()(not (apply and $args))))

         (test "yest" (= (yest nil) nil))
         (test "yest" (= (yest true) true))

         (test "nor1" (= (nor nil nil) true))
         (test "nor2" (= (nor nil true) nil))
         (test "nor3" (= (nor true nil) nil))
         (test "nor4" (= (nor true true) nil))

         (test "nand1" (= (nand nil nil) true))
         (test "nand2" (= (nand nil true) true))
         (test "nand3" (= (nand true nil) true))
         (test "nand4" (= (nand true true) nil))

(SU '-> <=) ;(lambda(a b)(or (not a) b)))
(SU '<- (lambda(a b)(or (not b) a)))
(protect1 '<- '(a b))

(SU '<-> (lambda(a b)(or (and a b)
                         (and (not a) (not b)))))
(protect1 '<-> '(a b))

(SU '-><- (lambda(a b)(not (<-> a b))))
(SU 'xor -><-)

(protect1 '-><- '(a b))
(protect1 'xor '(a b))

(SU 'false nil)

          (test "-> 1" (= (-> nil  nil)  true))
          (test "-> 2" (= (-> nil  true) true))
          (test "-> 3" (= (-> true nil)  nil))
          (test "-> 4" (= (-> true true) true))

          (test "<-> 1" (= (<-> nil  nil)  true))
          (test "<-> 2" (= (<-> nil  true) nil))
          (test "<-> 3" (= (<-> true nil)  nil))
          (test "<-> 4" (= (<-> true true) true))

          (test "-><- 1" (= (-><- nil  nil)  nil))
          (test "-><- 2" (= (-><- nil  true) true))
          (test "-><- 3" (= (-><- true nil)  true))
          (test "-><- 4" (= (-><- true true) nil))

;;==============================================================
;;
;; Group:            Operators of propositional calculus.
;;
;;--------------------------------------------------------------
;;
;; Name:             infix<->prefix, prefix<->infix
;;
;; Type              Functions.
;;
;; Purpose:          Returns equivalent formula in other form.

(SU 'infix<->prefix
  (lambda(L)
    (cond ((not (list? L)) L)
          ((= (length L) 2) (map infix<->prefix L))
          ((= (length L) 3) (let((L1 (map infix<->prefix L)))
                                (list (nth 1 L1) (nth 0 L1) (nth 2 L1)))))))

(SU 'prefix<->infix infix<->prefix)
(protect1 'infix<->prefix '(L))
(protect1 'prefix<->infix '(L))

(test "infix<->prefix" (= (infix<->prefix '(+ (- 1 2) (- 1 2))) '((1 - 2) + (1 - 2))))
(test "infix<->prefix" (= (infix<->prefix '((1 - 2) + (1 - 2))) '(+ (- 1 2) (- 1 2))))

;;==============================================================
;;
;; Group:            Prefix-theorem-variables
;;
;;--------------------------------------------------------------

(SU 'propositional-operator?
    (lambda(x)(find x '(-> <- or and not yest <-> -><- nor xor nand))))

    (protect1 'propositional-operator? '(x))

    (test "propositional-operator?" (propositional-operator? '->))

(SU 'prefix-variables-in-formula
      (lambda(p theorem)
        (recursive-map (lambda(x)(if (propositional-operator? x)
                                     x
                                     (+sym p x)))
                       theorem)))

(protect1 'prefix-variables-in-formula '(p theorem x))

(test "prefix-variables-in-formula"
      (= (prefix-variables-in-formula 'p '(-> (-> A B) P))
         '(-> (-> pA pB) pP)))

(SU 'suffix-variables-in-formula
      (lambda(p theorem)
        (recursive-map (lambda(x)(if (propositional-operator? x)
                                     x
                                     (sym (string x p))))
                       theorem)))

(protect1 'suffix-variables-in-formula '(p theorem x))

(test "prefix-variables-in-formula"
      (= (suffix-variables-in-formula 'p '(-> (-> A B) P))
         '(-> (-> Ap Bp) Pp)))

;;==============================================================
;;
;; Group:            Aliases for arithmetic operations.
;;
;; Name:             -. +. *. /. %.
;;
;; Type:             Primitives.
;;
;; Purpose:          Shorter names for add, sub, mul, div, mod
;;
;; Example:          (*. (-. a b) (+. a b)) instead of
;;                   (mul (sub a b) (add a b))

(SU '-. sub)
(SU '+. add)
(SU '*. mul)
(SU '/. div)
(SU '%. mod)

;;--------------------------------------------------------------
;; Group:            Aliases for first and rest
;;
;; Purpose:          more descriptive names of the functions

(SU 'operator first)
(SU 'arguments rest)

;;==============================================================
;;
;; Group:            Set operations.
;;
;;--------------------------------------------------------------
;; Name:             -S2, +S2, *S2,
;;                   -S, +S, *S
;;
;; Type:             Primitives and functions
;;
;; Purpose:          -S2, and *S2 are shorter names for built in
;;                   difference and intersection, +S2 is equivalent
;;                   union operations. -S, +S and *S are not binary,
;;                   but n-ary operators, n>=0, and in the case of +
;;                   n can be equal to 0.

(SU '-S2 difference) ;
(SU '*S2 intersect)
(SU '+S2 (lambda()((if (and (= (length $args) 3)
                          ($args 3))
                      IF  ; identity function
                      unique)
                   (apply append $args))))

(SU '+S (lambda()(unique (apply append $args))))

(SU '-S (lambda()
           (case (length $args)
           (0 (throw-error "mising argument in Default function -S."))
           (1 (unique (first $args)))
           (2 (apply -S2 $args))
           (true (-S2 (first $args)
                      (apply +S (rest $args)))))))
(SU '*S (lambda()
           (case (length $args)
                 (0 (throw-error "mising argument in Default function *S."))
                 (1 (unique (first $args)))
                 (2 (apply *S2 $args))
                 (true (*S2 (first $args)
                            (apply *S (rest $args)))))))

(test "+S 0" (= (+S) '()))
(test "+S 1" (= (+S '(1)) '(1)))
(test "+S 2" (= (+S '(1 2) '(2 3)) '(1 2 3)))
(test "+S 3" (= (+S '(1 2 3) '(4 3 2) '(3 4 5)) '(1 2 3 4 5)))

(test "-S 1" (= (+S '(1)) '(1)))
(test "-S 2" (= (+S '(1 2) '(2 3)) '(1 2 3)))
(test "-S 3" (= (+S '(1 2 3) '(4 3 2) '(3 4 5)) '(1 2 3 4 5)))

(test "*S 1" (= (*S '(1)) '(1)))
(test "*S 2" (= (*S '(1 2) '(2 3)) '(2)))
(test "*S 3" (= (*S '(1 2 3) '(4 3 2) '(3 4 5)) '(3)))

;===============================================================
;
; Group:             Generating mutating macros.
;
; Name:              hset
;
; Syntax:            (hset operator)
;
; Purpose:           hset generates the functions that modify
;                    values of the symbols. Names of these
;                    functions are results of appending "setq"
;                    and function names.
;
; Examples:          (hset '+) generates the functions setq+, setf
;                    and set+ such that if x is 3, after (setq+ x 7),
;                    (setf+ x 7) and (set+ 'x 7) the value of x is 10.
;
;                    (hset 'append) generates the function setqappend
;                    such that if value of z is "hihi" then after
;                    (setqappend z "ho") the value of z is "hihiho".

(SU 'hset
    (lambda()
       (letn ((old-function-name (first (args))))
             (set (sym (append "setq"(string old-function-name)))
                  (expand '(lambda-macro()
                               (set (first (args))
                                    (apply old-function-name
                                           (map eval (args)))))
                                'old-function-name))

             (set (sym (append "set" (string old-function-name)))
                  (expand '(lambda-macro()
                                (set (eval (first (args)))
                                     (apply old-function-name
                                           (map eval
                                               (cons (eval (first (args)))
                                                     (rest (args)))))))
                            'old-function-name))

             (set (sym (append "setf" (string old-function-name)))
                  (expand '(lambda-macro()
                               (eval
                                 (letex((x (first (args))))
                                    '(setf x (apply old-function-name
                                                   (map eval (args)))))))
                            'old-function-name)))))

(protect1 'hset
     '(x old-function-name))

(dolist(i '( + - * / %
             +. -. *. /. %.
             add mul sub div mod
             append max min and or
             nand nor -> <-> -><-
             +S -S *S
             +S2 -S2 *S2))
  (hset i))

(test "hset & setf"  (begin (setf L '(1 2 3 4))
                            (setf/ (L 3) 2)
                            (= (L 3) 2)))

;;===============================================================
;;
;; Group:          Apostrophe
;;
;; Name:           apostrophe
;;
;; Example         (apostrophe (list '+ 1 2)) => '(+ 1 2)

(set 'apostrophe
     (lambda(x)(expand ''x 'x)))

(protect1 'apostrophe '(x))

;;==============================================================
;; Group:          Manipulating second element of list
;;
;; Purpose:        Mostly internal purposes, switching from let
;;                 to met, using result of unification in construction
;;                 of let expressions

(set 'apostrophe-second
     (lambda(x)
       (list (first x) (apostrophe (last x)))))

(set 'quote-second
     (lambda(x)
       (list (first x) (list 'quote (last x)))))

(set 'eval-second
     (lambda(x)
       (list (first x) (eval (last x)))))

(protect1 'apostrophe-second '(x))
(protect1 'quote-second '(x))
(protect1 'eval-second '(x))

;;==============================================================
;;
;; Group:            Even and odd numbers.
;;
;; Name:             even? and odd?
;;
;; Type:             Functions.
;;
;; Syntax:           (even expr) (odd expr)
;;
;; Parameters:       Expr - expression that evaluates to integer.
;;
;; Purpose:          Well known property.
;;
;; Result:           true or false.
;;
;; Side effects:     There is no side effects.
;;
;; Error conditions: No known error conditions.
;;
;; Example:          (even? 3) => nil, (odd? 3) => true
;;

; (SU 'even?
;     (lambda(n)(and (integer? n)
;                     (= (% n 2) 0))))
; (protect1 'even? '(n))
;
; (SU 'odd?
;     (lambda(n)(and (integer? n)
;                     (not (= (% n 2) 0)))))
;
; (protect1 'odd? '(n))
;

(test "even?" (even? 4))
(test "odd?" (odd? 3))

;;==============================================================
;;
;; Group:              Collatz sequence
;;
;; Names:              Collatz-next, Collatz-list, Collatz-count
;;
;; Usage:              (Collatz-next x) returns list x defined with formula:
;;                          x/2 if x is even
;;                          3*x + 1 if x is odd
;;
;;                     (

(SU 'Collatz-next (lambda(x)
                     (if (even? x) (/ x 2) (+ (* 3 x) 1))))

(SU 'Collatz-list (lambda(x)
             (cond ((= x 1) (list 1))
                   (true (append (list x)
                                 (Collatz (Collatz-next x)))))))

(set 'Collatz-list (lambda(x)
               (let((result (list x)))
                   (while(!= x 1)
                       (setf x (Collatz-next x))
                       (push x result -1))
                   result)))

(SU 'Collatz-count (lambda(x)
                     (let((result 1))
                        (while(!= x 1)
                          (setf x (Collatz-next x))
                          (inc result))
                        result)))

(protect1 'Collatz-list '(x))
(protect1 'Collatz-next '(x))
(protect1 'Collatz-count '(x))

(test "Collatz-next" (= (Collatz-next 7) 22))
(test "Collatz-list" (= (Collatz-list 7)
                   '(7 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)))
(test "Collatz-count" (= (Collatz-count 7) 17))

;;==============================================================
;;
;; Group:            Prime and composite numbers.
;;
;; Name:             divisible? prime? composite? and power-of-two?
;;
;; Type:             Functions.
;;
;; Syntax:           (prime? expr)
;;                   (composite? expr)
;;
;; Parameters:       Expr - expression that evaluates to integer.
;;
;; Result:           true or false.
;;
;; Side effects:     There is no side effects.
;;
;; Error conditions: No known error conditions.
;;
;; Example:          (prime? 577) => true;
;;                   (composite? 577) => false
;;

(SU 'divisible? (lambda(n i)(= (% n i) 0)))
(protect1 'divisible? '(n i))

(SU 'prime? (lambda(n)
               (if (= n 1)
                   nil
                   (let((is_composite nil))
                       (for(i 2 (int (sqrt n)) 2 is_composite)
                           ;(println i)
                           (when (divisible? n i)
                                 (set 'is_composite true)))
                       (not is_composite)))))

(SU 'composite?
    (lambda(n)(if (= n 1)
                  nil
                  (not (prime? n)))))

(protect1 'prime? '(n i))
(protect1 'composite? '(n))

(SU  'power-of-two?
  (lambda(i)
     (cond((= i 1) true)
          ((odd? i) nil)
          ((even? i) (power-of-two? (/ i 2))))))

(protect1 'power-of-two? '(i))

(test "divisible? 1" (divisible? 343 7))
(test "divisible? 2" (not (divisible? 343 8)))
(test "prime 1" (prime? 577))
(test "prime 2" (not (prime? 1)))
(test "composite 1" (composite? 24))
(test "composite 2" (composite? 2))

;;==============================================================
;;
;; Group:            Integer functions
;;
;;--------------------------------------------------------------
;;
;; Name:             sum-dividers
;;
;; Type:             Function.
;;
;; Syntax:           (sum-dividers <expr>)
;;
;; Parameters:       <expr> - expression that evaluates to integer.
;;
;; Result:           sum of dividers of the number
;;

(set 'sum-dividers (lambda(n)
                     (let ((result 1))
                          (for(i 2 (int (sqrt n)) 1)
                              (if (divisible? n i)
                                  (set+ 'result (+ i (/ n i)))))
                          result)))

(protect1 'sum-dividers '(n result i))

(test "sum-dividers" (= (sum-dividers 12) 16))

;;==============================================================
;;
;; Group:            Integer functions
;;
;;--------------------------------------------------------------
;;
;; Name:             perfect?
;;
;; Type:             Function.
;;
;; Syntax:           (perfect? <expr>)
;;
;; Parameters:       <expr> - expression that evaluates to integer.
;;
;; Result:           true if <expr> evaluates to perfect number,
;;                   false otherwise

(set 'perfect? (lambda(n)
                 (let ((result 1))
                      (for(i 2 (int (sqrt n)) 1 (> result n))
                          (if (divisible? n i)
                              (set+ 'result (+ i (/ n i)))))
                      (= result n))))

(protect1 'perfect? '(n result i))

(test "perfect 1" (perfect? 6))
(test "perfect 2" (perfect? 28))
(test "perfect 3" (not (perfect? 8)))

;===============================================================
;;
;; Group:            Map relatives.
;;
;;--------------------------------------------------------------
;;
;; Name:             pam, mapq, pamq
;;
;; Type:             Functions.
;;
;; Syntax:           (pam list-of-functions element)
;;                   (pamq list-of-functions element)
;;                   (mapq function list-of-elements)
;;
;; Parameters:       list-of-functions - expression that evaluates
;;                                       to list of functions.
;;                   element           - expression that evaluates
;;                                       to any Newlisp value
;;                   list-of-elements  - expression that evaluates
;;                                       to list of any Newlisp values
;;
;; Purpose:          Useful in similar situations as map.
;;
;; Result:           (pam '(f1 ... fn) x) <=> (list (f1 x) ... (fn x))
;;                   (pamq '(f1 ... fn) x) <=> (list '(f1 x) ... '(fn x))
;;                   (mapq f1 '(x1 ... xn)) <=> (list '(f1 x) ... '(fn x))
;;
;; Side effects:     No known side effects
;;
;; Error conditions: Errors happen if parameters are not of the
;;                   described type or functions are not applicable
;;                   on elements.
;;
;; Examples:
;;
;; Tested expression: (map 'sin '(1 2 3))
;; Result:            (0.8414709848 0.9092974268 0.1411200081)
;;
;; Tested expression: (pam '(sin cos) 3)
;; Result:            (0.1411200081 -0.9899924966)
;;
;; Tested expression: (pamq '(sin cos) 3)
;; Result:            ((sin 3) (cos 3))
;;
;; Tested expression: (mapq 'sin '(1 2 3))
;; Result:            ((sin 1) (sin 2) (sin 3))
;;

(SU 'pamq (lambda(L a)
          (map (lambda(li)(list li a)) L)))

(protect1 'pamq '(L li a))

(SU 'pam (lambda(L a)
         (map (lambda(fi)(eval (list fi a))) L)))

(protect1 'pam '(L fi a))

(SU 'mapq (lambda(f L)
          (map (lambda(li)(list f li)) L)))

(protect1 'pam '(f L li))

(test "map" (= (map (lambda(x)(* x x)) '(1 2 3)) '(1 4 9)))
(test "pam" (= (pam '((lambda(x)(+ 1 x)) (lambda(x)(* x 2))) 3)
               '(4 6)))
(test "pmaq" (= (pamq '(sin cos) 3) '((sin 3) (cos 3))))
(test "mapq" (= (mapq 'sin '(1 2 3)) '((sin 1) (sin 2) (sin 3))))

;===============================================================
;
; Group:           map relatives
;
; Name:            maplist
;
; Type:            macro
;
; Example:         (maplist '(a b c) '(1 2 3) '("x" "y" "z")))
;                  ==> ((a 1 "x") (b 2 "y") (c 3 "z"))


(SU 'maplist (lambda-macro()(eval (append '(map list) (args)))))



(test "maplist" (= (maplist '(a b c) '(1 2 3) '("x" "y" "z"))
                   '((a 1 "x") (b 2 "y") (c 3 "z"))))

;===============================================================
;
; Group:          map relatives
;
; name:           appendall
;
; Type:           function
;
; Syntax          (appendall f b)
;
; Result:         returns result of appending (f b1), ... (f bn)
;                 where b = (b1 ... bn)
;
; Example:        (appendall (lambda(x)(list x (sqrt x x)))
;                            '(1 4 9 16 25))
;
;                 = (1 1 4 2 9 3 16 4 25 5)

(SU 'appendall (lambda(a b)
                  (apply append (map a b))))

(protect1 'appendall '(a b))

(test "appendall" (= (appendall (lambda(x)(list x (sqrt x x)))
                                '(1 4 9 16 25))
                                '(1 1 4 2 9 3 16 4 25 5)))

;===============================================================
;;
;; Group:            Increased order.
;;
;;--------------------------------------------------------------
;;
;; Name:             increase-order, IO
;;
;; Type:             Functions.
;;
;; Syntax:           (increase-order f)
;;
;; Parameters:       f - expression that evaluates to function,
;;                       primitive or macro or their names.
;;
;; Purpose:          increase-order takes function of the nth
;;                   order and returns appropriate function of the
;;                   increased order. See examples.
;;
;; Result:           Let us assume that f is function that accept
;;                   m arguments, (f x1 ... xm), and F is result of
;;                   (increase-order f), then F can be applied on
;;                   functions that return x1 ... xm. Say g1 ... gm
;;                   are such functions, and f0=(F g1 ...gm), then
;;                   (f0 y1...yn)=(f (g1 y1...yn) ... (gm y1...ym).
;;                   Yes, I know it is abstract. See examples.
;;
;; Side effects:     No known side effects
;;
;; Error conditions: Nothing particular.
;;
;; Examples:
;;
;; (set 'notf (increase-order 'not))
;; (set 'noteven? (notf even?))
;;
;; (println= (noteven? 3))  ;(noteven? 3)=true;
;; (println= (noteven? 6))  ;(noteven? 6)=nil;
;;
;; (set '+.f (increase-order '+.))
;; (set '+.sincos (+.f 'sin 'cos))
;;
;; (println= (+.sincos 3)) ;(+.sincos 3)=-0.8488724885;
;; (println= (+. (sin 3) (cos 3))) ;(+. (sin 3) (cos 3))=-0.8488724885;
;;

(SU 'increase-order
     (lambda(main-connective)
        (expand (lambda()
                   (let ((tmp1 (args)))
                        (expand (lambda-macro()
                                   (eval (let ((tmp0 (args)))
                                              (cons 'main-connective
                                                    (map (lambda(x)(cons x tmp0))
                                                               'tmp1)))))
                                'tmp1)))
                 'main-connective)))

(SU 'IO increase-order)

(protect1 'increase-order '(main-connective tmp1 tmp0 x))
(protect1 'IO '(main-connective tmp1 tmp0 x))

(test "increase-order 1" (= (((IO not) even?) 5) true))
(test "increase-order 2" (= (((IO not) even?) 6) nil))

;===============================================================
;;
;; Group:            Increased order.
;;
;;--------------------------------------------------------------
;;
;; Name:             not^, or^, and^,
;;                   ~^, &^, |^, ->^, <-^, <->^, -><-^
;;                   +^, -^, *^, /^, %^
;;                   +.^, -.^, *.^, /.^, %.^
;;
;; Type:             Functions.
;;
;; Syntax:           (not^ f), (or^ f1 f2), (+^ f1 f2 f3 ... )
;;
;; Parameters:       f, f1, ... expression that evaluates to
;;                              function, primitive or macro
;;
;; Purpose:          Basic operations of a higher order. It can
;;                   simplify programs and make errors less probable.
;;
;; Result:           The functions that behave as operations over
;;                   functions. See examples.
;;
;; Side effects:     There are no known side effects.
;;
;; Error conditions: Nothing particular.
;;

(dolist (i '(not or and
             nand nor xor -> <- <-> -><-
             + - * / %
             +. -. *. /. %.
             +S2 -S2 *S2
             +S -S *S))

        (SU (+sym i "^") (IO i)))

(dolist (i '(true nil))
   (dolist (j '(true nil))
      (eval (expand
                '(test "not^" (= ((not^ or) i j) (not (or i j))))
                'i 'j))))

(dolist (i '(true nil))
   (dolist (j '(true nil))
      '(println= i j)
      (eval (expand
                '(test "and^" (= ((and^ or and) i j)
                                 (and (or i j) (and i j))))
                'i 'j))))

(dolist (i '(true nil))
   (dolist (j '(true nil))
      (eval (expand
                '(test "or^" (= ((or^ or and ->) i j)
                                (or (or i j) (and i j) (-> i j))))
                'i 'j))))

;===============================================================
;;
;; Name:             function-or-macro?, FM?
;;
;; Type:             Function.
;;
;; Syntax:           (function-or-macro f)
;;
;; Parameters:       f - expression that evaluates to function,
;;                       primitive or macro
;;
;; Purpose:          Not a big deal, but I've needed it once,
;;                   so its here.
;;
;; Result:           True if f evaluates to function or macro,
;;                   false otherwise.
;;
;; Side effects:     No known side effects
;;
;; Error conditions: Nothing particular.
;;
;; Examples:

(SU 'function-or-macro?
     (lambda(x)(or (lambda? x)(macro? x))))

(SU 'FM? function-or-macro)

(protect1 'function-or-macro '(x))
(protect1 'FM? '(x))

(test "function or macro?" (function-or-macro? IF))

;===============================================================
;;
;; Group:            Predicates from relations.
;;
;; Name:             predicatize
;;
;; Type:             Function.
;;
;; Syntax:           (predicatize r)
;;
;; Parameters:       r - expression that evaluates to relation.
;;
;; Purpose:          Produces useful predicates from relations.
;;                   Similar to curry but simpler for extensive
;;                   use. Check examples.
;;
;; Result:           Tramsrofms relation r(x,y) into function of
;;                   one argument r?(y) which for given y0 returns
;;                   predicate r(x,y0).
;;
;; Side effects:     No known side effects
;;
;; Error conditions: Nothing particular.
;;
;; Examples:         (predicatize '<=) ;result: <=? see bellow.

(SU 'predicatize
     (lambda(relation)
            (local (left rigth relvar)
                   (set 'left
                         (sym (append (string relation) "?")))
                   (set 'relvar
                         (sym (append "[" (string relation) "?.arg]")))
                   (set 'right
                         (expand (lambda(x)
                                    (expand (lambda(relvar)
                                                (relation relvar x))
                                            'x))
                                 'relation
                                 'relvar))

                   (set left right))))

(protect1 'predicatize '(relation left right relvar x))

;===============================================================
;;
;; Group:            Predicates from relations.
;;
;; Name:             <? >? =? <=? >=? !=? or? and? not? &? |? ~?
;;                   ->? <-? <->? -><-?
;;
;; Type:             Functions.
;;
;; Syntax:           (<? x), (>? x)
;;
;; Parameters:       x - real number.
;;
;; Purpose:          (<? x) has the meaning of the predicate
;;                   "less than x".
;;
;; Result:           Transforms relation r(x,y) into function of
;;                   one argument r?(y) which for given y0 returns
;;                   predicate r(x,y0).
;;
;; Side effects:     No known side effects
;;
;; Error conditions: Nothing particular.
;;
;; Examples:         (<=? 1) is (lambda ([<=?.arg]) (<= [<=?.arg] 1))
;;

(dolist (predicate '(< > = <= >= != or and not & | ~ nor nand xor -> <- <-> -><-))
          (predicatize predicate))

(test "<?" ((<? 3) 1))

;===============================================================
;;
;; Group:            Floating point rounding support.
;;
;; Name:             gfloor, ground, gceil
;;
;; Type:             Functions.
;;
;; Syntax:           (gfloor number precision)
;;                   (ground number precision)
;;                   (gceil  number precision)
;;
;; Parameters:       x - real number.
;;
;; Purpose:          Well known functions floor, round and ceil
;;                   in different form. Precision can be 0, in that
;;                   case, number is returned. If precision is negative,
;;                   result is equivalent of - (gfloor (- number)
;;
;; Result:           Transrofms relation r(x,y) into function of
;;                   one argument r?(y) which for given y0 returns
;;                   predicate r(x,y0).
;;
;; Side effects:     No known side effects
;;
;; Error conditions: If step < 0.
;;
;; Examples:         (gfloor 3.17492 0.01)=3.17;
;;                   (ground 3.17492 0.01)=3.17;
;;                   (gceil  3.17492 0.01)=3.18;

(dolist(j '(floor ceil round))
  (SU (+sym 'g j)
      (expand (lambda(x step)
                 (when (< step 0)
                       (throw-error "gfloor, gceil or ground: step < 0"))
                 (if (= step 0)
                     x
                     (*. (j (/. x step)) step)))
              'j))
  (protect1 (+sym 'g j) '(x step)))

(test "gfloor" (= (gfloor 3.17492 0.01) 3.17))
(test "ground" (= (ground 3.17492 0.01) 3.17))
(test "gceil " (= (gceil  3.17492 0.01) 3.18))

;===============================================================
;;
;; Group:            Random numbers.
;;
;;--------------------------------------------------------------
;;
;; Name:             rnd, irnd
;;
;; Type:             Function.
;;
;; Syntax:           (rnd from to step)
;;                   (irnd from to)
;;
;; Parameters:       from - start of the segment
;;                   to   - end of the segment
;;                   step - granularity of the segment.
;;
;; Purpose:          Random number function in the syntax similar
;;                   to for and sequence.
;;
;; Result:           Random number from set starting with "from"
;;                   and ending with "to" - both included - increased
;;                   by "step." If "step" is 0, then any floating
;;                   point number in segment can be random number.
;;
;; Side effects:     No known side effects.
;;
;; Error conditions: No known error conditions.
;;
;; Examples:          (rnd 2 10000 5)=12;
;;                    (rnd 6 7 0.125)=6.625;
;;                    (rnd 1 3 0)=2.170018616;
;;

(SU 'rnd
    (lambda(a b step)
       (if (> a b)
           (rnd b a step) ; because of specificity of Newlisp for
           (begin (when (not step) (set 'step 1))

                  (let ((result
                       (if (and (= step 0)
                                (= (random) (random)))
                           b

                           (let ((r (random)))
                                (while (or (= 0 r) (= 1 r))
                                       (set 'r (random)))
                                (let((scale (+. (gfloor (- b a) step) ; [??]
                                                step)))
                                    (+. a (gfloor (*. scale r)
                                                  step)))))))
                        (if (or (< result a) (> result b))
                            (println= "error!" result a b step r)
                             result))))))

(SU 'irnd (lambda(a b)(rnd a b 1)))

(protect1 'rnd '(a b step scale r result))
(protect1 'irnd '(a b))

;===============================================================
;;
;; Name:             random-element, RE
;;
;; Type:             Function.
;;
;; Syntax:           (random-element list)
;;
;; Examples:         (random-element (list 1 2 3))
;;

(SU 'random-element (lambda(L)(apply amb L)))
(SU 'RE random-element)

(protect1 'random-element '(L))
(protect1 'RE '(L))

(test "random-element" (= (random-element '(1)) 1))

;===============================================================
;;
;; Name:             random-sublist, RS
;;
;; Type:             Function.
;;
;; Syntax;           (random-sublist L n)
;;

(SU 'random-sublist
    (lambda(L pick-from-list)
      (let ((result '())
            (left-in-list (length L)))
           (when (> pick-from-list left-in-list)
            (throw-error (append "There is no n="
                                 (string pick-from-list)
                                 " elements in L.")))
           (dolist (element L (= pick-from-list 0))
                   (let ((probability (div pick-from-list
                                           left-in-list)))
                         (when (<= (random 0 1) probability)
                               (push element result -1)
                               (dec pick-from-list))
                         (dec left-in-list)))
            result)))

(SU 'RS random-sublist)

(protect1 'random-sublist '(L pick-from-list result left-in-list element
                       probability))

(protect1 'RS '(L pick-from-list result left-in-list element
                       probability))

;===============================================================
;;
;; Group:            Ordinal numbers.
;;
;;--------------------------------------------------------------
;;
;; Name:             second, third
;;
;; Type:             Function.
;;
;; Syntax:           (second L), (third L) ...

(setq second (lambda()(first(rest (first(args))))))
(setq third (lambda()(first(rest(rest (first(args)))))))

;===============================================================
;;
;; Name:             type
;;
;; Type:             Function.
;;
;;
;; Returns type of the argument, "boolean", "integer" etc.
;; It is not my function, it is just the part of my default
;; library file. It is once posted by newBert on the Newlisp forum.

(define (type x)
  ; returns the type of data
  (let (types '("boolean" "boolean" "integer" "float"
                "string" "symbol" "context"
                "primitive" "primitive" "primitive"
                "quote" "list" "lambda" "macro" "array"))
       (types (& 0xf ((dump x) 1)))))

(protect1 'type '(x))

;===============================================================
;
; Name:              evaluation-level-indent
;
; Syntax             (evaluation-level-indent <indent-character>)
;                    if indent-character is omitted, then " " is
;                    used.

(set 'evaluation-level-indent
     (lambda()
        (dup (or (first (args)) " ") (sys-info 3))))

;;==============================================================
;;
;; Group:              functions for memory control.
;;
;; Name:               memory-watch, memory-watch-reset,
;;                     memory-watch-report
;;
;; Example of use:
;;
;; (memory-watch-reset)
;; (set 'fibo (lambda(n)
;;                 (memory-watch)
;;                 (if (< n 3) 1
;;                     (+ (fibo (- n 1)) (fibo (- n 2))))))
;; (fibo 20)
;; (memory-watch-report)
;;
;; prints following line:
;;
;; Memory watch report: 1593-1696 (difference 103) cells used.

(SU 'memory-watch-reset (lambda()
                             (set '[memory-watch.min-used-cells]
                                   (sys-info 0))
                             (set '[memory-watch.max-used-cells]
                                   (sys-info 0))))
(SU 'memory-watch (lambda()
                     (when (> (sys-info 0) max-used-cells)
                           (set '[memory-watch.max-used-cells]
                                (sys-info 0)))
                     (when (< (sys-info 0) min-used-cells)
                           (set '[memory-watch.min-used-cells]
                                (sys-info 0)))))

(protect1 'memory-watch '(max-used-cells min-used-cells))

(SU 'memory-watch-report
    (lambda()(println "Memory watch report: "
                      [memory-watch.min-used-cells]
                      "-"
                      [memory-watch.max-used-cells]
                      " (difference "
                      (- [memory-watch.max-used-cells]
                         [memory-watch.min-used-cells])
                      ") cells used.")))

; (memory-watch-reset)
; (set 'fibo (lambda(n)
;                 (memory-watch)
;                 (if (< n 3)
;                     1
;                     (+ (fibo (- n 1)) (fibo (- n 2))))))
; (fibo 25)
;(memory-watch-report)


;;==============================================================
;;
;; Group:              Conversion between functions, macros and
;;                     primitives.
;;
;;--------------------------------------------------------------
;;
;; Name:               function-from-macro, macro-from-function
;;                     FM, MF
;;
;; USAGE:              (function-from-macro p) only changes the
;;                     "lambda-macro" from definition of p into
;;                     lambda.
;;
;;                     (macro-from-function p) does the same,

(SU 'function-from-macro (lambda()
                             (append '(lambda) ; quote can be omitted
                                      (first (args)))))

(SU 'FM function-from-macro)

(test "function-from-marco" (= (FM (lambda-macro(x)(sin x)))
                               (lambda(x)(sin x))))

(SU 'macro-from-function (lambda()
                             (append '(lambda-macro)
                                      (first (args)))))

(SU 'MF macro-from-function)

(test "macro-from-function" (= (MF (lambda(x)(sin x)))
                               (lambda-macro(x)(sin x))))

;;==============================================================
;;
;; Group:              Conversion between functions, macros and
;;                     primitives.
;;
;;--------------------------------------------------------------
;;
;; Name:               function-from-primitive, macro-from-primitive
;;                     FP, MP
;;
;; Purpose:            Converting primitives to function and macros
;;                     behaving on the SAME way as primitive.

(SU 'function-from-primitive
     (lambda(built-in-name)
       (expand '(lambda()(apply 'built-in-name $args))
               'built-in-name)))

(SU 'macro-from-primitive
     (lambda(built-in-name)
        (expand '(lambda-macro()(eval (cons 'built-in-name $args)))
                'built-in-name)))

(SU 'FP function-from-primitive)
(SU 'MP macro-from-primitive)

(protect1 'function-from-primitive '(built-in-name))
(protect1 'macro-from-primitive '(built-in-name))

(protect1 'FP '(built-in-name))
(protect1 'MP '(built-in-name))

(test "FP" (= ((MF (FP sqrt)) 4) 2))

;===============================================================
;
; Group:             Functions supporting lambda and lambda-macro
;                    lists
;
; Name:              mapg, cleang
;
; Type:              Functions.
;
; Syntax:            (mapg f list), (cleang f L)
;
; Purpose:           Same like map and clean, they just keep
;                    special type of lists, i.e. if applied on
;                    lambda and lambda macro lists, they return
;                    same kinds of lists

(SU 'mapg (lambda(f L)
             (append (cond ((lambda? L) (lambda))
                           ((macro? L)  (lambda-macro))
                           (true '()))
                      (map f L))))

(protect1 'mapg '(f L))

(SU 'cleang (lambda(f L)
               (append (cond ((lambda? L) (lambda))
                             ((macro? L)  (lambda-macro))
                             (true '()))
                        (clean f L))))

(protect1 'cleang '(f L))



;===============================================================
;
; Group:             Two-phase, Common Lisp / Scheme kind of macros
;
; Names:             prepare-time, !!, prepare-time-fn?, prepare
;
; Syntax:            See my blog.

(SU 'prepare-time begin)
(SU '!! '!!)

(SU 'prepare-time-fn?
      (lambda(expr)(and (symbol? expr)
                        (or (lambda? (eval expr)) (macro? (eval expr)))
                        (= (nth 1 (eval expr)) ''prepare-time))))

(protect1 'prepare-time-fn? '(expr))

(SU 'prepare
     (lambda(expr)
        (let ((result
              (if (and (list? expr)
                       (not (empty? expr)))

                   (if (= (first expr) 'prepare-time)
                       (eval expr)           ; [1]

                       (begin (set 'expr (mapg prepare expr)); recursion

                              (if (prepare-time-fn? (first expr))
                                  (eval expr) ; [2]
                                  expr)))
                   expr)))                    ; general case

             (if (list? result)
                 (cleang (lambda(x)(= x !!)) result) ; [1a]
                  result))))

(protect1 'prepare '(expr result x))

;===============================================================
;
; Group:             List splitting.
;
; Names:             except-last,
;                    first-half-inclusive,
;                    first-half-exclusive,
;                    second-half-inclusive,
;                    second-half-exclusive,
;                    middle,
;                    except-nth
;
; Syntax:            (except-last L) etc

(SU 'except-last
      (lambda(L)
        (slice L 0 (- (length L) 1))))
        (SU 'EL except-last)
        (protect1 'except-last '(L))
        (protect1 'EL '(L))
        (test "except-last" (= (except-last '(1 2 3)) '(1 2)))

(SU 'first-half-inclusive
     (lambda(L)
        (slice L 0 (ceil (/. (length L) 2)))))
        (SU 'FHI first-half-inclusive)
        (protect1 'first-half-inclusive '(L))
        (protect1 'FHI '(L))
        (test "first-half-inclusive"
              (= (first-half-inclusive '(1 2 3)) '(1 2)))

(SU 'first-half-exclusive
    (lambda(L)
       (slice L 0 (floor (/. (length L) 2)))))
       (SU 'FHE first-half-exclusive)
       (protect1 'first-half-exclusive '(L))
       (protect1 'FHE '(L))
       (test "first-half-exclusive" (= (first-half-exclusive '(1 2 3))
                                        '(1)))

(SU 'second-half-inclusive
    (lambda(L)
       (slice L (floor (/. (length L) 2))
                (ceil (/. (length L) 2)))))
       (SU 'SHI second-half-inclusive)
       (protect1 'second-half-inclusive '(L))
       (protect1 'SHI '(L))
       (test "second-half-inclusive"
             (= (second-half-inclusive '(1 2 3)) '(2 3)))

(SU 'second-half-exclusive
    (lambda(L)
       (slice L (ceil (/. (length L) 2))
                (floor (/. (length L) 2)))))

       (SU 'SHE second-half-exclusive)
       (protect1 'second-half-exclusive '(L))
       (protect1 'SHE '(L))
       (test "second-half-exclusive" (= (second-half-exclusive '(1 2 3)) '(3)))

(SU 'middle
    (lambda(L)
       (if (odd? (length L))
           (nth (/ (length L) 2) L)
           (throw-error "middle applied on even length list"))))

     (test "middle" (= (middle '(1 2 3)) 2))
     (protect1 'middle '(L))

(SU 'except-nth
    (lambda(n L)
        (append (slice L 0 n)
                (slice L (+ n 1) (- (length L) n)))))

    (SU 'EN except-nth)
    (protect1 'except-nth '(n L))
    (protect1 'EN '(n L))
    (test "except-nth" (= (except-nth 1 '(1 2 3)) '(1 3)))

;===============================================================
;
; Group:             Expressions as graphs
;
; Names:             branches, leafs
;
; Syntax:            (branches L), (leafs L)
;
; Examples:
;
; (println (branches '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))))
;
; (println (leafs '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))))
;
; ((+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))
; (- 1 2) 1 2 (+ 3 4) 3 4 (- 5 (+ 6 7)) 5 (+ 6 7) 6 7)
; (1 2 3 4 5 6 7)

(SU 'branches
    (lambda(L)
      (cons L (cond ((list? L)(apply append (map branches (rest L))))
                    ((quote? L)(branches (eval L)))
                    (true '())))))

(SU 'branches-exclusive
    (lambda(L)(difference (branches L) (list L))))

(protect1 'branches '(L))

(SU 'leafs
     (lambda(L)
       (cond ((list? L)(apply append (map leafs (rest L))))
             ((quote? L)(leafs (eval L)))
             (true (list L)))))

(protect1 'leafs '(L))

(test "branches 1"
       (= (branches '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7))))
          '((+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))
           (- 1 2) 1 2 (+ 3 4) 3 4 (- 5 (+ 6 7)) 5 (+ 6 7) 6 7)))

(test "branches 2" (= (branches '(+ 1 '2)) '((+ 1 '2) 1 '2 2)))

(test "branches-exclusive"
       (= (branches-exclusive
            '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7))))
            '((- 1 2) 1 2 (+ 3 4) 3 4 (- 5 (+ 6 7)) 5 (+ 6 7) 6 7)))

(test "leafs" (= (leafs '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7))))
                 '(1 2 3 4 5 6 7)))

;===============================================================
;
; Group:             List operations
;
; Names              *list
;
; Syntax:            (*list <L1> <L2>)
;
; Result:            Cartesian product of lists <L1> and <L2.>
;
; Example:           (*list '(1 2) '(4 5 6)) ->
;                    ((1 4) (1 5) (1 6) (2 4) (2 5) (2 6))

(set '*list (lambda(l1 l2)
              (let ((result '()))
                   (dolist(i l1)
                     (dolist(j l2)
                       (push (list i j) result -1)))
                   result)))

(protect1 '*list '(i l1 l2 result))

(test "*list" (=  (*list '(1 2) '(4 5 6))
              '((1 4) (1 5) (1 6) (2 4) (2 5) (2 6))))

;===============================================================
;
; Group:             List operations
;
; Names              element
;
; Syntax:            (element x L)
;
; Result:            nil if x not element L, place in the list
;                    if it is element of the list. Same thing as
;                    find, just with different name
;

(set 'element find)

;===============================================================
;
; Group:             Expressions as graphs
;
; Names:             depth, size, size2, size-string, width
;
; Syntax:            (depth <L>) - length of the longest branch
;                    (size <L>)  - number of nodes
;                    (size2 <L>) - number of nodes, such that non
;                                  terminal nodes are counted with 2.
;                    (string-size <L>) - size of the string
;                    (width <L>) - number of branches
;
; (set 'depth (lambda(x)
;                (cond ((quote? x)(+ 1 (depth (eval x))))
;                       ((list? x)(+ 1 (apply max (map depth x))))
;                       (true 1))))
;
; (set 'size (lambda(x)
;               (+ 1 (cond ((quote? x)(size (eval x)))
;                          ((list? x)(apply + (map size x)))
;                          (true 0)))))
;
; (set 'width (lambda(x)
;               (cond ((quote? x)(width (eval x)))
;                     ((list? x)(apply + (map width x)))
;                     (true 1))))
;

(protect1 'depth '(x))
(protect1 'size '(x))
(protect1 'size2 '(x))
(protect1 'size-string '(x))
(protect1 'width '(x))

(test "size 1" (= (size '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))) 17))
(test "depth 1" (=(depth '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))) 4))
(test "width 1" (= (width '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))) 12))
(test "size 2" (= (size '()) 1))
(test "depth 2" (= (size '()) 1))
(test "width 2" (= (width '() 0)))
(test "size2" (= (size2 '(+ a b)) 5))
(test "size2" (= (size2 '(+ (a) (b))) 9))
(test "size2" (= (size2 '(+ (length "a") (length "b"))) 11))

;===============================================================
;
; Group:             Special cond's
;
; Names:             most-probable-cond, least-probable-cond
;
; Syntax:
;
; Examples:

(SU 'most-probable-cond
    (lambda-macro(formula-for-a-number-of-evals)
       (when (> (length (args) 0))
       (let ((number-of-evals (eval formula-for-a-number-of-evals))
             (maximal-clause-index -1)
             (maximal-clause-successes -1))

            ;(println "Number of evals: " number-of-evals)
            (doargs(clause)
                (let ((counter-of-successes 0))

                     (dotimes (this-eval number-of-evals)
                          (when (eval (first clause))
                                (inc counter-of-successes)))

;                      (println "Clause: " $idx
;                               ". " ($args $idx)
;                               ": " counter-of-successes
;                               " times.")

                     (when (> counter-of-successes
                              maximal-clause-successes)
                           (set 'maximal-clause-index $idx)
                           (set 'maximal-clause-successes
                                 counter-of-successes))))
;             (println "Max: " maximal-clause-index
;                      ". " ($args maximal-clause-index)
;                      ": " maximal-clause-successes " times.")
;
            (eval (last ($args maximal-clause-index)))))))

(SU 'MPC most-probable-cond)

(protect1 'most-probable-cond '(formula-for-a-number-of-evals
                           number-of-evals
                           this-eval
                           maximal-clause-index
                           maximal-clause-successes
                           clause
                           counter-of-successes))

(protect1 'MPC '(formula-for-a-number-of-evals
            number-of-evals
            this-eval
            maximal-clause-index
            maximal-clause-successes
            clause
            counter-of-successes))

(SU 'least-probable-cond
    (lambda-macro(formula-for-a-number-of-evals)
       (let ((number-of-evals (eval formula-for-a-number-of-evals))
             (minimal-clause-index -1)
             (minimal-clause-successes -1))
;            (println "Number of evals: " number-of-evals)
            (doargs(clause)
                (let ((counter-of-successes 0))

                     (dotimes (this-eval number-of-evals)
                          (when (eval (first clause))
                                (inc counter-of-successes)))
;                      (println "Clause: " $idx
;                               ". " ($args $idx)
;                               ": " counter-of-successes
;                               " times.")
                     (when (< counter-of-successes
                              minimal-clause-successes)
                           (set 'minimal-clause-index $idx)
                           (set 'minimal-clause-successes
                                 counter-of-successes))))
;             (println "Max: " maximal-clause-index
;                      ". " ($args maximal-clause-index)
;                      ": " maximal-clause-successes " times.")
            (eval (last ($args minimal-clause-index))))))

(SU 'LPC least-probable-cond)

(protect1 'least-probable-cond '(formula-for-a-number-of-evals
                            number-of-evals
                            this-eval
                            minimal-clause-index
                            minimal-clause-successes
                            clause
                            counter-of-successes))

(protect1 'LPC '(formula-for-a-number-of-evals
            number-of-evals
            this-eval
            minimal-clause-index
            minimal-clause-successes
            clause
            counter-of-successes))

;===============================================================
;
; Group:             Macros support
;
; Name:              macrocall
;
; Syntax:            (macrocall macro values)
;
;                    Attention: use only uppercase for variables.
;
; Examples:
;
; (macrocall '((X Y)(println "X=" X "; Y=" Y))
;            '((+ 1 2) (- (* 4 5))))
;
; (macrocall '(L (println "L=" L))
;            '((+ 1 2) (- (* 4 5))))
;
; (macrocall '((X (Y Z)) (println "X=" X "; Y=" Y "; Z=" Z))
;            '((+ 1 2) (- (* 4 5))))
;
;
; X=(+ 1 2); Y=(- (* 4 5))
; L=((+ 1 2) (- (* 4 5)))
; X=(+ 1 2); Y=-; Z=(* 4 5)
;
; (macrocall '((X (Y Z#)) (println "X=" X "; Y=" Y "; Z=" Z))
;            '((+ 1 2) (- (* 4 5))))
;
; X=(+ 1 2); Y=-; Z=20   - It works

(SU 'macrocall-quote-second (lambda(x)
                       (if (ends-with (string (first x)) "#")
                            (list (sym (chop (string (first x))))
                                  (last x))
                            (list (first x)
                                  (apply quote (rest x))))))

(SU 'MQS macrocall-quote-second)

(protect1 'macrocall-quote-second '(x))
(protect1 'MQS '(x))

(SU 'equivalent-let-block
     (lambda (definition arguments)
             (list 'let
                    (map macrocall-quote-second
                         (unify (first definition)
                                       arguments))
                    (last definition))))

(SU 'ELB equivalent-let-block)

(protect1 'equivalent-let-block '(definition arguments))
(protect1 'ELB '(definition arguments))

(SU 'macrocall
     (lambda (definition arguments)
             (eval (equivalent-let-block definition arguments))))

(protect1 'macrocall '(definition arguments))

(test "macrocall 1" (= (macrocall '((X (Y Z))(+ X (* Y Z)))
                                  '(2 (3 4)))
                       14))

;===============================================================
;
; Name:              calculate-or-ask
;
; Syntax:            see example:
;
; (calculate-or-ask
;      (Diagonal)
;      (Width)
;      (Height)
;      (Price)
;      (Pixels               (* Height Width))
;      (Area                 (/ (* Diagonal Diagonal Width Height)
;                               (+ (* Width Width)
;                                  (* Height Height))))
;      (Pixels/Unit-of-area  (/ Pixels Area))
;      (Pixels/Unit-of-price (/ Pixels Price)))
;
; Output:
;
          ; Diagonal             = 24
          ; Width                = 1920
          ; Height               = 1200
          ; Price                = 2000
          ; Pixels               = 2304000
          ; Area                 = 258
          ; Pixels/Unit-of-area  = 8930
          ; Pixels/Unit-of-price = 1152

(SU 'calculate-or-ask
     (lambda-macro()
        (dolist (i $args)
           (print (first i)
               (dup " " (- 20 (length (string (first i)))))
               " = ")
           (set (first i) (if (> (length i) 1)
                              (println (eval (nth 1 i)))
                              (float (read-line)))))))

(SU 'CA calculate-or-ask)

(protect1 'calculate-or-ask '(i))
(protect1 'CA '(i))

;===============================================================
;
; Group:             Inverse let
;
; Names:             where, wherex, wheren
;
; Syntax:            (where   <body> <head>)
;                    (wherex  <body> <head>)
;                    (wheren  <body> <head>)

(SU 'where
    (lambda-macro()
       (eval (append '(let)
                     (cons (last (args))
                           (reverse (rest (reverse (args)))))))))
(SU 'wherex
   (lambda-macro()
      (eval (append '(letex)
                    (cons (last (args))
                          (reverse (rest (reverse (args)))))))))
(SU 'wheren
   (lambda-macro()
      (eval (append '(letn)
                    (cons (last (args))
                          (reverse (rest (reverse (args)))))))))

; comment: where, wherex and wheren have not local variables.


;===============================================================
;
; Group:             Multi-loops
;
; Names:             multiloop
;
; Syntax:            (multiloop expr0) where expr0 evaluates to
;                    function name
;
; Description:       internal, for producing multi loops, might
;                    be useful for some people.

(SU 'multiloop
   (lambda(loop)
     (let ((new-loop (sym (append (string loop) "-multi"))))
        (SU new-loop
           (expand
             (lambda-macro(L)
                (let ((variables (first L)))
                  (if (empty? variables)
                      (eval (list-to-single-expression (args)))
                      (letex ((head1 (cons (first variables)
                                           (rest L)))
                              (head2 (cons (rest variables)
                                           (rest L)))
                             (body  (list-to-single-expression (args))))
                         (loop head1
                               (new-loop head2
                                         body))))))
                    'loop
                    'new-loop))
         (protect1 new-loop '(L variables head1 head2 body)))))

(protect1 'multiloop '(loop new-loop L))
;===============================================================
;
; Group:             Multi-loops
;
; Names:             doargs-multi, dolist-multi, dostring-multi
;                    dotimes-multi, dotree-multi, for-multi
;
; Description        multi-versions of loops allow following
;                    syntax:
;
;                    (dolist-multi ((i j k l) '(true nil))
;                                      ... )
;
;                    instead of
;
;                    (dolist (i '(true nil))
;                       (dolist (j '(true nil))
;                          (dolist (k '(true nil))
;                              (dolist (l '(true nil))
;                                     ... ))))

(map multiloop '(doargs dolist dostring dotimes dotree for))

;===============================================================
;
; Group:            factorials
;
; Names:            factorial, double-factorial
;

(set 'factorial
     (lambda(n)
       (let((result 1))
         (when (> n 0)
            (for(i 1 n 1)
                (set 'result (* result i))))
          result)))

(protect1 'factorial '(result n i))

; one might expect that "sequence" work better than loop here,
; but sequence definition is really different, so it requires some
; changes that at the end, make definition more similar to loop.

(test "factorial 1" (= (factorial 6) 720))
(test "factorial 2" (= (factorial 0) 1))

(set 'double-factorial
     (lambda(n)
       (let((result 1))
        (when (> n 0)
         (for(i n 1 -2)
            (set 'result (* result i))))
         result)))

(protect1 'double-factorial '(result n i))

(test "double-factorial 1" (= (double-factorial 5) 15))
(test "double-factorial 2" (= (double-factorial 6) 48))
(test "double-factorial 3" (= (double-factorial 0) 1))

;===============================================================
;
; GROUP:        PROPOSITIONAL VARIABLES AND FORMULAS
;
; Description:  Few elementary functions related to propositional
;               formulas, implemented on the simplest way.
;               Some of the functions can redefine values of
;               the variables in the propositional formulas.
;
;               They use some other library functions I wrote,
;               so this code cannot be just cutted and pasted
;               in editor, but I'll publish it in library soon
;               (or I already did it.)
;
; Names:        propositional-variables, PV
;
;               tautology
;               falsifiable
;               satisfiable
;               contradiction
;
;               satisfaction
;               falsification
;
; Type:         functions
;
; Examples:     (propositional-variables '(-> nil (-> nil nil)))
;               ===> '()
;
;               (propositional-variables '(-> A (or B (and D true) nil)))
;                ===> '(A B D)
;
;               (tautology? '(-> A B)) ==> nil
;
;               (tautology? (-> nil (-> nil nil))) ==> true
;
;               (falsifiable '(-> A B)) ==> true
;
;               (falsifiable (-> nil (-> nil nil))) ==> nil
;
;               (falsification '(-> A B)) ==> ((A true) (B nil))
;
;               (satisfaction '(-> A (not A))) ==> '((A nil)))
;

(SU 'propositional-variables ; SU is my version of set, it warns
                             ; if variable is already defined

  (lambda(f)(difference (unique (leafs f)) ; (leafs '(-> (-> x y) z)) ==> (x y z)
                                booleans)))        ; booleans = '(true nil)

        (SU 'PV propositional-variables)
        (protect1 'propositional-variables '(f)) ; protect1 is my protection
                                            ; function roughly equivalent
                                            ; to built in contexts.

                                            ; I use it instead of contexts
                                            ; primarily because I can
                                            ; experiment.
        (protect1 'PV '(f))

        (test "propositional-variables 1"
          (= (propositional-variables '(-> nil (-> nil nil)))
             '()))
                   ; -> is implication, the propositional logical
                   ; connective like or and not, defined
                   ; earlier in library.

        (test "propositional-variables 2"
          (= (propositional-variables '(-> A (or B (and D true) nil)))
             '(A B D)))

(SU 'tautology?
  (lambda(formula)
    (let ((tautology true))
      (letex ((L (propositional-variables formula)))
        (dolist-multi(L booleans (not tautology))
          (setand 'tautology (eval formula)))) ; (setand 'x y) = (set 'x (and x y))
      tautology)))

          (test "tautology" (not (tautology? '(-> A B))))
          (test "tautology2" (tautology? (-> nil (-> nil nil))))

(SU 'falsifiable? (not^ tautology?))  ; not^ is a higher order not;
                                      ; it can be applied on functions
                                      ; ((not^ f) x) = (not (f x))
                                      ; for every x

          (test "falsifiable? 1" (not (falsifiable? true)))
          (test "falsifiable? 2" (falsifiable? '(-> A B)))

          (protect1 'tautology? '(formula tautology L))
          (protect1 'falsifiable? '(formula tautology L))

(SU 'falsification
  (lambda(formula)
    (let ((tautology true)
          (result nil))
      (letex ((L (propositional-variables formula)))
        (dolist-multi(L booleans (not tautology))
          (setand 'tautology (eval formula))
          (unless tautology
                  (set 'result (map (lambda(x)(list x (eval x)))
                                    'L)))))
      result)))

           (test "falsification" (= (falsification '(-> A B))
                                    '((A true) (B nil))))

           (protect1 'falsification '(formula tautology result L))

(SU 'satisfiable? (lambda(f)(falsifiable? (list 'not f))))
(SU 'satisfaction (lambda(f)(falsification (list 'not f))))
(SU 'contradiction? (not^ satisfiable?))

          (test "satisfaction" (= (satisfaction '(-> A (not A))) '((A nil))))

          (protect1 'satisfiable? '(f))
          (protect1 'satisfaction '(f))
          (protect1 'contradiction? '(f))

;===============================================================
;
; Group:          Propositional variables and functions (2)
;
; Description:    canonization
;                 canon
;
; Sometimes, two formulas differ only in the names of used variables.
; For example, formulas (-> A (-> X A)) and (->B (-> Y B)). If name
; of the variable doesn't interest us, we can think about these two
; as about essentially same formula; or as two equivalent formulas.
;
; However, it is not trivial to recognize that two formulas are
; equivalent on that way. Possible approach is to transform the
; formula in some canonical (normal, standard) form and in that case,
; recognition that two formulas are equivalent can be purely graphical.
;
; The simplest normal form in this case is probably one in which
; the first occurence of the variable is chosen by
; alphabetical order, e.g. (-> A (-> B A)).
;
; Two functions are defined here: "canon" returns formula in canonic
; form, "canonization" returns substitution able to transform original
; formula in normal form.
;
; Example:
;
;      (canonization '(-> X (or A X)))
;
;           ===> ((X TEMP-A) (A TEMP-B) (TEMP-A A) (TEMP-B B))
;
; so
;
;      (expand '(-> X (or A X))
;              '((X TEMP-A) (A TEMP-B) (TEMP-A A) (TEMP-B B)))
;
;                                            ==>(-> A (or B A))
;
; Note that variables like TEMP-A are needed.
;
;      (canon '(-> X (or A X))) ==> '(-> A (or B A))

(SU 'canonization
     (lambda (formula)
        (letn((L1 (map (lambda(x)(list x (sym (append "TEMP-" (char (+ $idx 65))))))
                       (propositional-variables formula)))
              (L2 (map (lambda(x)(list (last x)
                                       (sym (char (+ $idx 65)))))
                       L1)))
             (append L1 L2))))

      (protect1 'canonization '(formula L1 x L2))

      (test "canonization" (= (canonization '(-> X (or A X)))
                              '((X TEMP-A) (A TEMP-B) (TEMP-A A) (TEMP-B B))))

(SU 'canon
     (lambda(formula)
        (expand formula (canonization formula))))

      (protect1 'canon '(formula))

      (test "canon" (= (canon '(-> X (or A X))) '(-> A (or B A))))

;===============================================================
;
;   Group: Propositional variables and functions:
;
; Name:     serial-substitute
; Type:     primitive
; Syntax:   (serial-substitute <formula> <substitution>)

(SU 'serial-substitute expand)

;===============================================================
;
;   Group:  Propositional variables and Functions (3)
;
;   Names:  prefix-variables
;           deprefix-variables
;           underscore-variables
;           deunderscore-variables

;   (prefix-variables '(-> X Y) "-") ==> (-> -X -Y)
;   (deprefix-variables '(-> -X -Y) "-") ==> (-> X Y)

;   (underscore-variables '(-> X Y)) ==> (-> _X _Y)
;   (deunderscore-variables '(-> _X _Y)) ==> (-> X Y)

(SU 'prefixing-substitution
    (lambda(formula prefix)
         (map (lambda(x)(list x (sym (append prefix (string x)))))
              (propositional-variables formula))))

(SU 'prefix-variables
   (lambda(formula prefix)
      (serial-substitute
         formula
         (map (lambda(x)(list x (sym (append prefix (string x)))))
              (propositional-variables formula)))))

(protect1 'prefix-variables '(formula prefix x))

(test "prefix-variables1" (= (prefix-variables '(-> A (-> B A)) "MIN-")
                            '(-> MIN-A (-> MIN-B MIN-A))))

(test "prefix-variables2" (= (prefix-variables '(-> X Y) "-")
                            '(-> -X -Y)))

(SU 'deprefixing-substitution
    (lambda(formula prefix)
        (let ((substitution '()))
             (dolist(v (propositional-variables formula))
                  (when (starts-with (string v)
                                     (string prefix))
                        (push (list v
                                    (sym (slice (string v)
                                                (length prefix))))
                              substitution))))))

(SU 'deprefix-variables
     (lambda(formula prefix)
        (let ((substitution '()))
             (dolist(v (propositional-variables formula))
                  ;(println v)
                  (when (starts-with (string v)
                                     (string prefix))
                        (push (list v
                                    (sym (slice (string v)
                                                (length prefix))))
                              substitution)))
             (serial-substitute
                     formula
                     substitution))))



(protect1 'deprefix-variables '(formula prefix substitution v))

(test "deprefix-variables" (= (deprefix-variables '(-> -X -Y) "-")
                              '(-> X Y)))

(SU 'underscore-variables
     (lambda(formula)(prefix-variables formula "_")))

(protect1 'underscore-variables '(formula))

(test "underscore-variables"  (= (underscore-variables '(-> X Y))
                                 '(-> _X _Y)))

(SU 'deunderscore-variables
     (lambda(formula)(deprefix-variables formula "_")))

(protect1 'underscore-variables '(formula))

(test "deunderscore-variables"  (= (deunderscore-variables '(-> _X _Y))
                                   '(-> X Y)))

;===============================================================
;
;  Group:  Propositional variables and Functions (3)
;
;
;  note: large letters means variables for instantiation

(SU 'instance?
     (lambda(f1 f2)
       (if (= nil (unify (prefix-variables f1 "_") f2))
           nil
           true)))

(protect1 'instance? '(f1 f2))

(SU 'instantiate
     (lambda(f1 f2)
       (unify (prefix-variables f1 "-") f2)))

(protect1 'instantiate '(f1 f2))

(SU 'instantiation
     (lambda(f1 f2)
        (letn((l1 (prefixing-substitution f1 "_"))
              (pf1 (serial-substitute f1 l1))
              (l2 (unify pf1 f2))
              (pf2 (serial-substitute pf1 l2))
              (l3 (deprefixing-substitution pf2 "_")))
             (append l1 l2 l3))))

(protect1 'instantiation '(f1 f2 l1 l2 l3 pf1 pf2))

;===============================================================
;
;   Group:  Propositional variables and Functions
;

(SU 'upper-case-formula
     (lambda(f)
       (cond ((list? f)(map upper-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (upper-case (string f)))))))

(protect1 'upper-case-formula '(f))

(SU 'lower-case-formula
     (lambda(f)
       (cond ((list? f)(map lower-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (lower-case (string f)))))))

(protect1 'lower-case-formula '(f))

;===============================================================
;
; Group:       Propositional formulas
;
; Names:       all-pf
;
; Type:        function
;
; Syntax:      (all-pf len leafs unary binary)
;
; Result:      returns list of all propositional formulas of a
;              size len, with a given leafs (constants and symbols)
;              and unary and binary logical connectives

(set 'all-pf
  (lambda(len leafs unary binary)
     (if (= len 1)
        leafs
        (append (appendall (lambda(connective)
                              (map (lambda(x)(list connective x))
                                   (all-pf (- len 1) leafs unary binary)))
                           unary)
                (if (> len 2)
                    (appendall (lambda(connective)
                                  (appendall (lambda(r)
                                               (map (lambda(x)(cons connective x))
                                                    (*list (all-pf r leafs unary binary)
                                                           (all-pf (- len 1 r) leafs unary binary))))
                                             (sequence 1 (- len 2))))
                                binary)
                    '())))))

;===============================================================
;
; Group:       Propositional formulas
;
; Names:       rnd-pf
;
; Type:        function
;
; Syntax:      (rnd-pf len leafs unary binary)
;
; Result:      returns random propositional formulas of a
;              size len, with a given leafs (constants and symbols)
;              and unary and binary logical connectives

(set 'rnd-pf
  (lambda(len leafs unary binary)
    (let ((connectives (append unary binary)))
      (cond ((= len  1)
               (apply amb leafs))
            ((= len  2)
               (list (apply amb unary)
                 (rnd-pf 1 leafs unary binary)))

            ((> len  2)
               (let ((connective (apply amb connectives)))
                 (cons connective
                       (if (element connective unary)
                           (list (rnd-pf (- len  1) leafs unary binary))
                           (let ((r (apply amb (sequence 1 (- len  2)))))
                                 (list (rnd-pf r leafs unary binary)
                                       (rnd-pf (- len 1 r) leafs unary binary)))))))))))

;===============================================================
;
; Group:       Adding and multiplying digits
;
; Names:       add-digits,
;              multiply-digits.
;              add-digits-recursively
;              multiply-digits-recursively
;

(SU 'add-digits (lambda(n)
                    (apply + (map int (explode (string n))))))

(protect1 'add-digits '(n))

(test "add-digits" (= (add-digits 12345) 15))

(SU  'multiply-digits (lambda(n)
                         (apply * (map int (explode (string n))))))

(protect1 'multiply-digits '(n))

(test "multiply-digits" (= (multiply-digits 12345) 120))

(SU  'recursively-add-digits (lambda(n)(if (< n 10)
                                            n
                                            (recursively-add-digits
                                              (add-digits n)))))

(protect1 'recursively-add-digits '(n))

(test "recursively-add-digits"
      (= (recursively-add-digits 12345) 6))

(SU  'recursively-multiply-digits
  (lambda(n)(if (< n 10)
                n
                (recursively-multiply-digits (multiply-digits n)))))

(protect1 'recursively-add-digits '(n))

(test "recursively-multiply-digits"
      (= (recursively-multiply-digits 12345) 0))

;===============================================================
;
; Group:           Text titles support
;
; Name:            number-of-columns, max-title-width
; Type:            integer
; Purpose:         specifies width of the terminal

(SU '[text-titles.number-of-columns] 64)
(SU '[text-titles.max-title-width] 24)

;===============================================================
;
; Group:           Text titles support
;
;---------------------------------------------------------------
;
; Name:            nth-cyclic
;
; Type:            Function
;
; Description      (nth-cyclic i L) returns (nth (i mod length L) L)
;
; Examples:
;
;         (nth-cyclic -6 '(2 3 4))=2
;         (nth-cyclic -5 '(2 3 4))=3
;         (nth-cyclic -4 '(2 3 4))=4
;         (nth-cyclic -3 '(2 3 4))=2
;         (nth-cyclic -2 '(2 3 4))=3
;         (nth-cyclic -1 '(2 3 4))=4
;         (nth-cyclic 0 '(2 3 4))=2
;         (nth-cyclic 1 '(2 3 4))=3
;         (nth-cyclic 2 '(2 3 4))=4
;         (nth-cyclic 3 '(2 3 4))=2
;         (nth-cyclic 4 '(2 3 4))=3
;         (nth-cyclic 5 '(2 3 4))=4
;         (nth-cyclic 6 '(2 3 4))=2
;

(SU 'nth-cyclic
     (lambda(i l)(nth (mod i (length l)) l)))

(protect1 'nth-cyclic '(i l))

;===============================================================
;
; Group:           Text titles support
;
; Name:            find-last
; Type:            Function
; Description      Returns the index of the last occurence of the
;                  element in the string or list.

(SU 'find-last
     (lambda(d l)
       (let ((result (find (reverse d) (reverse l))))
            (if result (- (length l) result (length d))))))

(protect1 'find-last '(d l result))

;===============================================================
;
; Group:           Text titles support
;
; Name:            break-title
; Type:            Function
; Description      breaks the title in the list of strings, each
;                  of them shorter than max-title-width

(SU 'break-title
  (lambda(title-string)
    (let ((title-string (trim title-string))
          (lts (length title-string)))
      (if (<= lts [text-titles.max-title-width])
          (list (trim title-string))
          (let ((s (or (find-last " " (slice title-string
                                             0
                                             [text-titles.max-title-width]))
                       [text-titles.max-title-width])))
              (cons (trim (slice title-string 0 s))
                     (break-title (slice title-string
                                         s
                                         (- lts s)))))))))

(protect1 'break-title '(title-string lts s))

;===============================================================
;
; Group:           Text titles support
;
; Name:            clean string
; Type:            Function
; Description      returns string without double blanks, (chr 13)
;                  and (chr 10)

(SU 'clean-string
     (lambda(x)
        (dolist(i (list (list "  " " ")
                         (list (char 13) "")
                         (list (char 10) "")))
           (while (find (i 0) x)
               (replace (i 0) x (i 1))))
        x))

(protect1 'clean-string '(i x))

;===============================================================
;
; Group:           Text titles support
;
;---------------------------------------------------------------
;
; Name:            underline
;
; Type:            Function
;
; Syntax:          (underline title-text underline-string)
;                  (underline-left title-text underline-string)
;                  (underline-right title-text underline-string)
;
; Description      prints underlined title
;
; Example:         (underline "This is title" "X")
;                  (underline-left "And this is title" "=")
;                  (underline-right "And this also" "#")
;
;
;
;                          This is title
;                          XXXXXXXXXXXXX
;
;
; And this is title
; =================
;
;
;                                                    And this also
;                                                    #############

(SU 'underline
    (lambda()
       (let ((title-text (apply append (map string (chop (args)))))
             (underline-string (string (last (args)))))
       (println)
       (let ((cc 0))
            (dolist(i (break-title (clean-string title-text)))
              (let ((indent (dup " "
                                 (round (div (sub [text-titles.number-of-columns]
                                                  (length i)
                                                  +0.1)
                                              2)))))
                  (print indent i "\n" indent)
                  (dotimes(j (length i))
                     (inc cc)
                     (print (nth-cyclic cc underline-string)))
                  (println)))
            (println)))))

(SU 'underline-left
    (lambda()
      (let ((title-text (apply append (map string (chop (args)))))
            (underline-string (string (last (args)))))
           (println)
           (let ((cc 0))
             (dolist(i (break-title (clean-string title-text)))
               (let ((indent ""))
                   (print indent i "\n" indent)
                   (dotimes(j (length i))
                      (inc cc)
                      (print (nth-cyclic cc underline-string)))
                   (println)))
              (println)))))

(SU 'underline-right
    (lambda()
      (let ((title-text (apply append (map string (chop (args)))))
            (underline-string (string (last (args)))))
        (println)
        (let ((cc 0))
          (dolist(i (break-title (clean-string title-text)))
            (let ((indent (dup " "
                               (round (sub [text-titles.number-of-columns]
                                                (length i)
                                                +0.1)
                                            ))))
                (print indent i "\n" indent)
                (dotimes(j (length i))
                   (inc cc)
                   (print (nth-cyclic cc underline-string)))
                (println)))
           (println)))))

(protect1 'underline '(title-text underline-string cc i indent))
(protect1 'underline-left '(title-text underline-string cc i indent))
(protect1 'underline-right '(title-text underline-string cc i indent))

;===============================================================
; Group:           Text titles support
;---------------------------------------------------------------
; Name:            box
;
; Type:            Function
;
; Syntax:          (box title-text arg1 ... argn box-string)
;                  (box-left arg1 ... argn box-string)
;                  (box-right arg1 ... argn box-string)
;
; Description      prints boxed title with various frames
;
; Example:         (box "This is title" "X")
;                  (box-left "And this is title" "=")
;                  (box-right "And this also" "#")
;
;                        XXXXXXXXXXXXXXXXX
;                        X This is title X
;                        XXXXXXXXXXXXXXXXX
;
;
; =====================
; = And this is title =
; =====================
;
;
;                                                #################
;                                                # And this also #
;                                                #################
;

(SU 'box
     (lambda()
       (let ((title-text (apply append (map string (chop (args)))))
             (box-string (string (last (args)))))
           (println)
           (letn ((cc 0)
                  (L (map trim (break-title (clean-string title-text))))
                  (maxlength (apply max (map length L)))
                  (indent (dup " " (/ (- [text-titles.number-of-columns]
                                         maxlength
                                         4)
                                       2))))
               (print indent)
               (for(i 1 (+ maxlength 4))
                  (print (nth-cyclic cc box-string))
                  (inc cc))
               (println)

               (dolist(i L)
                   (print indent (nth-cyclic cc box-string))
                   (print (dup " " (+ 1 (round (div (sub maxlength
                                                         (length i)
                                                         +0.1)
                                                    2)))))
                   (inc cc)
                   (print i)
                   (print (dup " " (+ 1 (round (div (sub maxlength
                                                         (length i)
                                                         -0.1)
                                                    2)))))
                   (println (nth-cyclic cc box-string))
                   (inc cc))

               (print indent)
               (for(i 1 (+ maxlength 4))
                  (print (nth-cyclic cc box-string))
                  (inc cc))
               (println)

               (println)))))

(SU 'box-left
     (lambda()
     (let ((title-text (apply append (map string (chop (args)))))
             (box-string (string (last (args)))))
       (println)
       (letn ((cc 0)
              (L (map trim (break-title (clean-string title-text))))
              (maxlength (apply max (map length L)))
              (indent ""))
           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (dolist(i L)
               (print indent (nth-cyclic cc box-string))
               (print (dup " " (+ 1 (round (div (sub maxlength
                                                     (length i)
                                                     +0.1)
                                                2)))))
               (inc cc)
               (print i)
               (print (dup " " (+ 1 (round (div (sub maxlength
                                                     (length i)
                                                     -0.1)
                                                2)))))
               (println (nth-cyclic cc box-string))
               (inc cc))

           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (println)))))

(SU 'box-right
     (lambda()
     (let ((title-text (apply append (map string (chop (args)))))
           (box-string (string (last (args)))))
       (println)
       (letn ((cc 0)
              (L (map trim (break-title (clean-string title-text))))
              (maxlength (apply max (map length L)))
              (indent (dup " " (- [text-titles.number-of-columns]
                                     maxlength
                                     4)
                                   )))
           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (dolist(i L)
               (print indent (nth-cyclic cc box-string))
               (print (dup " " (+ 1 (round (div (sub maxlength
                                                     (length i)
                                                     +0.1)
                                                2)))))
               (inc cc)
               (print i)
               (print (dup " " (+ 1 (round (div (sub maxlength
                                                     (length i)
                                                     -0.1)
                                                2)))))
               (println (nth-cyclic cc box-string))
               (inc cc))

           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (println)))))

(protect1 'box '(title-text box-string maxlength cc i indent))
(protect1 'box-left '(title-text box-string maxlength cc i indent))
(protect1 'box-right '(title-text box-string maxlength cc i indent))

;===============================================================
; Group:           Text titles support
;---------------------------------------------------------------
; Name:            box-standard
; Type:            Function
; Syntax:          (box-standard title-text)
; Description      prints boxed title with standard frame

(SU 'box-standard
  (lambda()
    (let ((title-text (apply append (map string (args)))))
         (println)
         (letn ((cc 0)
                (L (break-title (clean-string title-text)))
                (maxlength (apply max (map length L)))
                (indent (dup " " (/ (- [text-titles.number-of-columns]
                                       maxlength
                                       4)
                                    2))))
             (print indent)
             (println "+" (dup "-" (+ maxlength 2)) "+")
             (dolist(i L)
                 (print indent "|")
                 (print (dup " " (+ 1 (round (div (sub maxlength
                                                      (length i)
                                                      +0.1) 2)))))
                 (print i)
                 (print (dup " " (+ 1 (round (div (sub maxlength
                                                       (length i)
                                                       -0.1) 2)))))
                 (println "|"))
             (print indent)
             (println "+" (dup "-" (+ maxlength 2)) "+")
             (println)))))

(SU 'box-standard-left
    (lambda()
       (let ((title-text (apply append (map string (args)))))
         (println)
         (letn ((cc 0)
                (L (break-title (clean-string title-text)))
                (maxlength (apply max (map length L)))
                (indent ""))
             (print indent)
             (println "+" (dup "-" (+ maxlength 2)) "+")
             (dolist(i L)
                 (print indent "|")
                 (print (dup " " (+ 1 (round (div (sub maxlength
                                                      (length i)
                                                      +0.1) 2)))))
                 (print i)
                 (print (dup " " (+ 1 (round (div (sub maxlength
                                                       (length i)
                                                       -0.1) 2)))))
                 (println "|"))
             (print indent)
             (println "+" (dup "-" (+ maxlength 2)) "+")
             (println)))))

(SU 'box-standard-right
  (lambda()
    (let ((title-text (apply append (map string (args)))))
      (println)
      (letn ((cc 0)
             (L (break-title (clean-string title-text)))
             (maxlength (apply max (map length L)))
             (indent (dup " " (- [text-titles.number-of-columns]
                                 maxlength
                                 4))))
          (print indent)
          (println "+" (dup "-" (+ maxlength 2)) "+")
          (dolist(i L)
              (print indent "|")
              (print (dup " " (+ 1 (round (div (sub maxlength
                                                   (length i)
                                                   +0.1) 2)))))
              (print i)
              (print (dup " " (+ 1 (round (div (sub maxlength
                                                    (length i)
                                                    -0.1) 2)))))
              (println "|"))
          (print indent)
          (println "+" (dup "-" (+ maxlength 2)) "+")
          (println)))))

(protect1 'box-standard '(title-text maxlength cc i indent L))
(protect1 'box-standard-left '(title-text maxlength cc i indent L))
(protect1 'box-standard-right '(title-text maxlength cc i indent L))

;===============================================================
; Name:            slice-sequence
; Type:            Function
; Syntax:          (slice-sequence X from to step)
; Description      returns parts of string or list X determined by
;                  sequence from to and step

(SU 'slice-sequence
     (lambda(X)
        (apply append (map (lambda(i)((if (string? X)
                                          identity-function
                                          list)
                                      (nth i X)))
                           (eval (cons 'sequence (args)))))))

(protect1 'slice-sequence '(X i))

(test "slice-sequence" (= (slice-sequence "abcdefghijkl"
                                          1
                                          (length "abcdefghijkl")
                                          2)
                           "bdfhjl"))

;===============================================================
; Name:            center-string
; Type:            Function
; Syntax:          (center-string s m)
; Description      returns string of the length m with string s
;                  in center and blanks left and right of it.

(SU 'center-string
    (lambda(s m)
       (let ((ls (length s)))
            (append (dup " " (round (/. (-. m ls +0.1) 2)))
                    s
                    (dup " " (round (/. (-. m ls -0.1) 2)))))))

(protect1 'center-string '(s m ls))

;===============================================================
; Group:           let versions
;---------------------------------------------------------------
; Name:            met
; Type:            macro
; Syntax:          (met <head> <body>)
; Purpose:         Just like let, but without evaluation of argument.
; Example:         (met ((x (sin x))) ... ) is the same as
;                  (let ((x '(sin x))) ... )

(SU 'met
   (lambda-macro(head)
     (eval (append '(let)
                   (list (map (lambda(x)
                                 (list (first x)
                                       (list 'quote (last x))))
                               head))
                   (args)))))

(protect1 'met '(head x))

(test "met" (= (met ((x (sin x))) x)
               '(sin x)))

;===============================================================
; Name:            metex
; Type:            macro
; Syntax:          (metex <head> <body>)
; Purpose:         Just like let, but without evaluation of argument.
; Example:         (metex ((x (sin x))) ... ) is the same as
;                  (letex ((x '(sin x))) ... )

(SU 'metex
    (lambda-macro(head)
      (eval (append '(letex)
                    (list (map (lambda(x)
                                  (list (first x)
                                        (list 'quote (last x))))
                                head))
                    (args)))))

(protect1 'metex '(head x))

(test "metex" (= (metex ((x (sin 3))
                         (y (cos 3)))
                            '(+ x y))
                 '(+ (sin 3) (cos 3))))

;===============================================================
; Name:            letex2
; Type:            macro
; Syntax:          (letex2 <head> <body>)
; Purpose:         Just like letex, but "safer", i.e
;                  (letex2 <head> <body>)=(eval (letex <head> '<body>))

(SU 'letex2
     (lambda-macro(head)
        (eval (eval (cons 'letex
                          (list head
                                (list 'quote
                                      (LSE (args)))))))))

(protect1 'letex2 '(head))

;===============================================================
; Name:            metex2
; Type:            macro
; Syntax:          (metex2 <head> <body>)
; Purpose:         Just like letex, but "safer", i.e
;                  (metex2 <head> <body>)=(eval (metex <head> '<body>))

(SU 'metex2
     (lambda-macro(head)
        (eval (eval (cons 'letex2
                          (list head
                                (list 'quote
                                      (LSE (args)))))))))

(protect1 'metex2 '(head))

;===============================================================
; Name:            gensym, GS, gensym-illegal, GSI
; Type:            functions
; Syntax           (gensym <s>), (GS <s>)
;                  (gensym-illegal <s>), (GSI <s>)

(SU '[gensym.counter] 0)
(SU '[gensym-illegal.counter] 0)

(SU 'gensym
     (lambda(i)
       (inc [gensym.counter])
       (sym (append "[gensym."
                     (string i)
                     "."
                     (string [gensym.counter])
                     "]"  ))))

(SU 'GS gensym)

(SU 'gensym-illegal
     (lambda(i)
       (inc [gensym.counter])
       (sym (append "(gensym "
                     (string i)
                     " "
                     (string [gensym-illegal.counter])
                     ")"  ))))

(SU 'GSI gensym-illegal)

(protect1 'gensym '(i))
(protect1 'GS '(i))
(protect1 'gensym-illegal '(i))
(protect1 'GSI '(i))

;===============================================================
; Group:           Gensym versions
; Name:            genlet
; Type:            Function

(SU 'genlet
  (lambda-macro()
    (eval
          ; Eval has to be done after all local variables are
          ; cleaned, except those gensyms.
          ; Preparation of the code to be evaluated should
          ; be completely syntactical.

      (let ((head (first (args)))
            (body (rest (args))))
           (letex ((H1 (map (lambda(x)
                               (list (nth 0 x)
                                     (list 'gensym
                                           (list 'quote (nth 0 x)))))
                             head))
                   (H2 head)
                   (H3 (cons 'begin body))
                   (H4 (cons 'begin (map (lambda(x)
                                            (list 'delete
                                                  (list 'quote
                                                         (nth 0 x))))
                                           head))))
                   (letex H1
                       '(first (list (let H2
                                          H3)
                                    H4))))))))

(protect1 'genlet '(head body H1 x H2 H3 H4))

(SU 'genlocal
  (lambda-macro(head)
    (let ((body (args)))
       (letex  ; look body first, head later.
               ; head

             ((H1 (map (lambda(x)
                        (list x
                              (list 'gensym
                                    (list 'quote x))))
                      head))

             (H2 (cons 'local (cons head body)))

             (H3 (cons 'begin (map (lambda(x)
                                     (list 'delete
                                           (list 'quote
                                                  x)))
                                    head))))

                 ; body:

                 (letex H1
                       (first (list H2
                                    H3)))))))

(protect1 'genlocal '(head body H1 x H2 H3 H4))

(dolist (loopname '(for doargs dolist dostring dotimes))
  (SU (sym (append "gen" (string loopname))) ; for -> genfor etc
    (letex ((loopname loopname))
      (lambda-macro(head)
        (let ((body (args)))
          (letex((H1 (list (first head)))
                 (H2 (append (list 'loopname head) body)))
                 (genlocal H1
                           H2))))))

  (protect1 (sym (append "gen" (string loopname)))
       '(head body H1 H2)))

;===============================================================
; Name:            deep-replace
;
; Type:            Function
;
; Purpose:         Same like built in replace, but recursive.
;                  Note that deep-replace works even if a is not
;                  formula.
;
; Attention: deep replace can be done using expand with its binding
; form.

(SU 'deep-replace ; nondestructive
  (lambda(a x b)
      (cond ((= x a) b)
            ((quote? x) (letex((qx (deep-replace a (eval x) b)))
                              ''qx))
            ((list? x) (append (cond ((macro? x)'(lambda-macro))
                                     ((lambda? x)'(lambda))
                                     (true '()))
                               (map (lambda(y)(deep-replace a y b))
                                    x)))
            (true x))))

(protect1 'deep-replace '(a x b qx y))

;===============================================================
;                   CANTORS ENUMERATIONS
;

(SU 'cantors-diagonal1
  (lambda(n)(ceil (div (add (- 1)
                            (sqrt (add 1 (mul 8 n))))
                        2))))

(protect1 'cantors-diagonal '(n))

(SU 'cantors-row
    (lambda (n)
       (let ((cd (cantors-diagonal1 n)))
            (- n (/ (* cd
                       (- cd 1))
                    2)))))

(protect1 'cantors-row '(n cd))

(SU 'cantors-column (lambda (n) (+ (cantors-diagonal1 n)
                                   (- (cantors-row n))
                                   1)))

(protect1 'cantors-row '(n))

(SU 'cantors-diagonal2 (lambda(r c)(+ c r (- 1))))

(protect1 'cantors-diagonal2 '(r c))

(SU 'cantors-number
    (lambda(r c)
       (let ((cd (cantors-diagonal2 r c)))
             (+ (/ (* cd (- cd 1)) 2) r))))

(protect1 'cantors-number '(r c))

(SU 'cantors-enumeration
    (lambda(p n)
       (cond ((= p 1) (list n))
             ((> p 1) (cons (cantors-row n)
                            (cantors-enumeration (- p 1) (cantors-column n)))))))

(protect1 'cantors-enumeration '(p n))

(SU 'cantors-enumeration-inverse
    (lambda()
      ; p is not needed since it can be calculated from the
      ; number of arguments
      (letn((arguments (args))
           (p (length arguments)))
          (cond ((= p 1) (first arguments))
                ((> p 1) (apply cantors-number
                                (cons (first arguments)
                                      (apply cantors-enumeration-inverse
                                             (rest arguments)))))))))

(protect1 'cantors-enumeration-inverse '(p arguments))

(SU 'cantors-enumeration-finite
    (lambda(n)
      (cantors-enumeration (cantors-row n) (cantors-column n))))

    (protect1 'cantors-enumeration-finite '(n))

(SU 'cantors-enumeration-finite-inverse
    (lambda()
      (let((arguments (args)))
        (cantors-enumeration-inverse
            (length arguments)
            (apply cantors-enumeration-inverse arguments)))))

    (protect1 'cantors-enumeration-finite-inverse
              '(arguments))


(SU 'cantors-square (lambda(n)
                     (+ (floor (sqrt (- n 1))) 1)))


(SU 'cantors-row2
    (lambda(n)
      (letn((d (cantors-square n))
            (r (- n (* (- d 1) (- d 1)))))
            ;(println= d r)
         (cond((<= r d) d)
              ((> r d) (- d (- r d)))))))

(SU 'cantors-column2
    (lambda(n)
      (letn((d (cantors-square n))
            (r (- n (* (- d 1) (- d 1)))))
         (cond((<= r d) r)
              ((> r d) d)))))

;(for(i 1 10)
;  (print i "->(" (cantors-row2 i) ", " (cantors-column2 i)"), "))

;---------------------------------------------------------------
;                          LAMBDA CALCULUS

; The lambda-expressions are defined on following way:
;
; (a) a, b, c, ... are lambda-expressions. These lambda expressions
;     are named "variables".
;
; (b) if X is variable and E is lambda-expression, then
;
;                            (^ X . E)
;
;     is lambda-expression as well. These lambda-expressions are
;     named "functions".
;
; (c) if E and F are lambda-expressions, then (E F) is lambda-
;     expression as well. These lambda expressions are named
;     "applications."
;
; Using functions for Cantor's enumeration developed in last few
; posts, now in my library, I'll define functions for enumeration
; of all lambda-expressions, i.e. bijective function
;
;                    lam: N -> all lambda-exprsions
;
; Enumerations of variables, functions, and applications will be
; defined independently.
;
;       var1, var2, ..., varn, ...
;       fun1, fun2, ..., funn, ...
;       app1, app2, ..., appn, ...
;
; After that, all lambda expressions will be enumerated on following
; way:
;
;       var1, fun1, app1, var2, fun2, app2, ...
;
;---------------------------------------------------------------
;
; First - enumeration of variables; and inverse enumeration.
;
; If alphabet is, for example, "xyz", I'll enumerate variables
; on following way:
;
;       x, y, z, x1, y1, z1, x2, y2, z2 ...
;
; It slightly complicates enumeration, but it looks better than
;
;       x0, y0, z0, x1, y1, ...

(SU 'var (lambda(n alphabet)
             (letn((l (length alphabet))
                   (first-char (alphabet (% (- n 1) l)))
                   (rest-chars (let((n1 (/ (- n 1) l)))
                               (if (= n1 0) "" (string n1)))))
                  (sym (append first-char rest-chars))))
          '(n alphabet l n1 first-char rest-chars))

(SU 'var-inverse (lambda(v alphabet)
                     (letn((l (length alphabet))
                           (first-char (first (string v)))
                           (rest-chars (rest (string v))))
                          (when (= rest-chars "")
                                (setf rest-chars "0"))
                          (+ (* (int rest-chars) l)
                             (find first-char alphabet) 1)))
                '(v alphabet l first-char rest-chars))
;
;---------------------------------------------------------------
;
; Second, enumeration of functions - and inverse enumeration.
;
; Every function has form (^ <var> <lambda-expression>), where
; any variable and lambda-expression is allowed. All pairs of
; variables and lambda-expressions can be enumerated using
; Cantor's enumeration:

(SU 'fun (lambda(n alphabet)
             (list '^
                   (var (cantors-row n) alphabet)
                   '.
                   (lam (cantors-column n) alphabet)))
         '(n alphabet))

(SU 'fun-inverse
  (lambda(f alphabet)
     (cantors-enumeration-inverse (var-inverse (f 1) alphabet)
                                  (lam-inverse (f 3) alphabet)))
  '(f alphabet))
;
;---------------------------------------------------------------
;
; Third, enumeration of applications - and inverse enumeration.
;
; Every application has form (<lambda-expression1> <lambda-expression2>),
; For enumeration of pairs of lambda-expressions, we need Cantors
; enumeration again.

(SU 'app (lambda(n alphabet)
            (list (lam (cantors-row n) alphabet)
                  (lam (cantors-column n) alphabet)))
         '(n alphabet))

(SU 'app-inverse
  (lambda(a alphabet)
    (cantors-enumeration-inverse (lam-inverse (first a) alphabet)
                                 (lam-inverse (last a) alphabet)))

  '(a alphabet))

;
;---------------------------------------------------------------
;
; Finally, enumeration of lambda expressions - and inverse enumeration:

(SU 'lam (lambda(n alphabet)
            (letn((n1 (- n 1))
                  (row (+ (% n1 3) 1))
                  (column (+ (/ n1 3) 1)))

              (case row (1 (var column alphabet))
                        (2 (fun column alphabet))
                        (3 (app column alphabet)))))
        '(n alphabet n1 row column))

; For lam-inverse, I need few helper predicates:

(SU 'var? (lambda(l)(symbol? l)) '(l))
(SU 'fun? (lambda(l)(and (list? l) (= (length l) 4))) '(l))
(SU 'app? (lambda(l)(and (list? l) (= (length l) 2))) '(l))

(SU 'lam-inverse
      (lambda(l alphabet)
         (local(row column)
           (cond ((var? l)(setf row 1)
                          (setf column (var-inverse l alphabet)))
                 ((fun? l)(setf row 2)
                          (setf column (fun-inverse l alphabet)))
                 ((app? l)(setf row 3)
                          (setf column (app-inverse l alphabet))))
            (+ (* 3 (- column 1)) row)))

      '(l alphabet row column))

(SU 'lambda-expression-pretty-form
   (lambda(t)
      (replace " . " (replace "^ " (replace ") (" (string t) ")(") "^") "."))
   '(t))

(SU 'parallelize-association-list
  (lambda(L)
    (letex((new-var '(sym (append "temp-" (string $idx)))))
          (append (map (lambda(x)(list (first x) new-var)) L)
                  (map (lambda(x)(list new-var (last x))) L))))
  '(L new-var x))

(SU 'normalize-variables
      (lambda(E alphabet)
        (let((EF (unique (filter (lambda(x)(find (first (string x)) alphabet)) (flat (list E))))))
           (setf toexpand (parallelize-association-list (map (lambda(x)(list x (var (+ $idx 1) alphabet))) EF)))
           (expand E toexpand)))
      '(E alphabet EF x toexpand))

;---------------------------------------------------------------
;
;  (beta-reduce-once E) search for one beta reduction in E and
;                       performs it, if possible.
;
; returns
;
;        (true result)  if beta-reduction is possible
;        (nil E)        if beta-reduction is impossible

(SU 'beta-reduce-once ; assumption - alpha conversion happened
  (lambda(E)
    (cond ((var? E) (list 'nil E))

          ((fun? E)
           (let((rfb (beta-reduce-once (last E))))
             (if (first rfb)
                 (list 'true (append (chop E)
                                     (list (last rfb))))
                 (list 'nil E))))

          ((app? E)
           (let ((F (first E))
                 (G (last E)))

             (if (fun? F)

                  ;E=((^V._) G) ==> E10[V:=E2]

                  (list 'true (expand (last F) (list (list (nth 1 F) G)))) ;)

                  ;E=(F G) ==>

                  (let ((rF (beta-reduce-once F)))
                     (cond ((= (first rF) true)
                            (list 'true (list (last rF) G)))
                           ((= (first rF) nil)
                            (let ((rG (beta-reduce-once G)))
                                 (cond ((= (first rG) true)
                                        (list 'true (list F (last rG))))
                                       ((= (first rG) nil)
                                        (list 'nil (list F G)))))))))))))
   '(E rfb rF rG))

;---------------------------------------------------------------
;
;               (alpha-convert E bounded-vars)
;
; converts the formula E to the form such that occurences of bounded
; variables have different names, among themself, and different than
; free variables.
;
; The function returns (true F), where F is result of alpha-conversion,
; if such conversion possible, or (nil E) if it is impossible.

(SU 'alpha-convert0
  (lambda(E bounded-vars)
     (cond ((var? E) E)
           ((fun? E)
            (begin (inc bounded-counter)
                   (letn ((new-E-1 bounded-counter); (var bounded-counter bounded-vars))
                          (new-E-2 (sym (append "temp-" (string new-E-1)))))
                      (push  new-E-2 temporary-vars -1);(list new-E-2 new-E-1)
                      (list '^
                            new-E-2
                            '.
                            (expand (alpha-convert0 (E 3) bounded-vars)
                                    (list (list (E 1) new-E-2)))))))
           ((app? E)
            (list (alpha-convert0 (first E) bounded-vars)
                  (alpha-convert0 (last E) bounded-vars))))))

(protect1 'alpha-convert0 '(E bounded-vars new-E-1 new-E-2))

(SU 'alpha-convert
  (lambda(E bounded-vars)
    (letn((bounded-counter 0)
          (temporary-vars '())
          (semi-result (alpha-convert0 E bounded-vars))
          (free-vars (clean (lambda(t)(or (= t '^) (= t '.) (starts-with (string t) "temp-")))
                            (flat (list semi-result))))
          (final-substitution '())

          (F))

          (setf bounded-counter 0)
          (dolist(i temporary-vars)
                 (do-while (find (var bounded-counter bounded-vars) free-vars)
           ;             (println "*")
                        (inc bounded-counter))
                 (push (list i (var bounded-counter bounded-vars)) final-substitution -1))

          ;(println r "," final-substitution "," frees "," F "," final-substitution2)
          (setf F (expand semi-result final-substitution))
          ;(println F)

          (if (= E F)
              (list nil E)
              (list true F)))))

(protect1 'alpha-convert
          '(E bounded-vars F semi-result free-vars t final-substitution i))

;---------------------------------------------------------------
;
;               (eta-reduce-once <expr>)
;
; Standard eta-reduction of lambda calculus
;
; Example: (eta-reduce-once '(^ x . (F x))) => F

(SU 'eta-reduce-once
  (lambda(E)
    (cond ((var? E) (list nil E))
          ((fun? E)
           (let((E0 (last E))) ; E=(^ x . E0)
             (cond

                ; E=(^ x . (... x)), where ... is free for x

                ((and (app? E0)
                      (= (nth 1 E) (last E0))
                      (= (first E0) (expand (first E0)
                                            (list (list (nth 1 E)
                                                         'eta-dummy)))))
                         ; needed to prevent (^y.(y y)) => y

                 (list true (first E0)))

                ; E=(^ x . (... v)), v!=x
                ; E=(^ x . F), F isn't list

                ((or (not (list? E0))
                     (and (list? E0)
                          (!= (nth 1 E) E0)))

                  (let((reduced-E0 (eta-reduce-once E0)))
                      (list (first reduced-E0)
                            (list '^
                                   (nth 1 E)
                                   '.
                                   (last reduced-E0))))))))

          ((app? E) ; E=(E1 E2)
           (letn((E1 (first E))
                 (E2 (last E))
                 (reduced-E1 (eta-reduce-once E1)))

                (if (= (first reduced-E1) true)
                    (list 'true (list (last reduced-E1)
                                      E2))
                    (let((reduced-E2 (eta-reduce-once E2)))
                        (list (first reduced-E2)
                              (list E1
                                    (last reduced-E2)))))))))

   '(E E0 E1 E2 reduced-E1 reduced-E2))

;---------------------------------------------------------------
;
;  (reduce^ <expression> <max-reductions> <to-print>)
;
; Standard reduction of lambda calculus, using normal order.
;
; <max-reductions> is maximal number of reductions. After that number
; is reached, further reductions are canceled. Important for
; non-terminating reductions.
;
; <to-print> the option that determines if output is silent.
;
; The function returns
;
; (reduced <result of reductions> <number of steps>)
;
;                        if reduction succeeded
;
; (unreduced <last expression in derivation> <number of steps>)
;
;                        if max-reductions number of steps is reached
;
; (irreducible <last expression in derivation> <number of steps>)
;
;                        if cycle is discovered

(SU 'reduce^

  (lambda(new-expr max-reductions to-print)

    (local(result
           alpha-success
           beta-success
           eta-success
           max-reductions-success
           reductions
           reduce-end)

      (setf print-reduction-report
            (lambda(reduction-name)
              (when to-print
                  (println (format "%5d" (+ (length reductions) 1))
                           ". ==[" reduction-name "]==> "
                           (lambda-expression-pretty-form new-expr)))))

      (setf check-cycle
            (lambda()(when (find new-expr reductions)
                           (when to-print
                              (println "\n       IRREDUCIBLE: CYCLE DISCOVERED."))
                           (setf reduce-end true)
                           (setf result 'irreducible))))

      (setf reductions '())
      (print-reduction-report " start    ")
      (push new-expr reductions -1)

  ;(println= reduce-end)
  (until reduce-end

     (setf aplha-success nil eta-success nil)

      ;Attempt of alpha conversion

     (unless reduce-end

       (setf alpha-result (alpha-convert (last reductions) "xyzuvwpqr"))
       (setf alpha-success (first alpha-result))
       (when alpha-success

             (setf new-expr (last alpha-result))
             (print-reduction-report " alpha    ")
             (check-cycle)
             (push new-expr reductions -1)))

       ;Attempt of eta conversion

       (unless (or reduce-end alpha-success)

          (setf eta-result (eta-reduce-once (last reductions)))
          (setf eta-success (first eta-result))

          (when eta-success
                (setf new-expr (last eta-result))
                (print-reduction-report " eta      ")
                (check-cycle)
                (push new-expr reductions -1)))

      ; Beta redukcija

      (unless (or reduce-end alpha-success eta-success)

         (setf beta-result (beta-reduce-once (last reductions)))
         (setf beta-success (first beta-result))

         (when beta-success
               (setf new-expr (last beta-result))
               (print-reduction-report " beta     ")
               (check-cycle)
               (push new-expr reductions -1)))

       (when (and (= (length reductions) max-reductions)
                  (not reduce-end))
              (when to-print
                (println "\n       UNREDUCED: MAX NUMBER OF REDUCTIONS REACHED."))
              (setf max-reduction-success true)
              (setf reduce-end true)
              (setf result 'unreduced))

       (unless (or alpha-success beta-success eta-success max-reductions-success)

               (when to-print
                 (println "\n       REDUCED TO NORMAL FORM."))
               (setf reduce-end true)
               (setf result 'reduced)))
    (list result new-expr (length reductions)))))

(protect1 'reduce^ '(new-expr
                     max-reductions
                     to-print
                     result
                     alpha-success
                     beta-success
                     eta-success
                     max-reductions-success
                     reductions
                     reduce-end))

(SU 'meta-var?
    (lambda(v)
      (and (= (string v) (upper-case (string v)))
           (!= v '^)
           (!= v '.))))

(protect1 'meta-var? '(v))

(SU 'expand-once^
    (lambda(expr)
       (let((expandable-meta-variables (filter (lambda(x)(and (meta-var? x)
                                                              (not (nil? (eval x)))))
                                               (flat (list expr)))))
          (eval (append '(expand expr)
                         (map quote expandable-meta-variables))))))

(protect1 'expand-once^ '(expr expandable-meta-variables))

(SU 'expand^
  (lambda(expr max-expansions to-print)
    (let((expansions 0))
      (when to-print
         (println)
         (---)
         (println "\n       EXPANSION AND REDUCTION OF "
                  (lambda-expression-pretty-form expr)
                  "\n\n"
                  (format "%5d" (+ expansions 1))
                  ". ==[ original ]==> "
                  (lambda-expression-pretty-form expr)))

       (while (exists (lambda(x)(and (meta-var? x)
                                     (not (nil? (eval x)))))
                      (flat (list expr)))

          (setf expr (expand-once^ expr))
          (inc expansions)
          (when to-print
             (println (format "%5d" (+ expansions 1))
                     ". ==[ expanded ]==> "
                     (lambda-expression-pretty-form expr)))))
        (when to-print
             (println "\n       META-VARIABLES EXPANDED.\n"))

    expr))

(protect1 'expand^ '(expr max-expansions to-print expansions))

(SU 'expand-and-reduce^
    (lambda(expr max-expand-and-reduce to-print)
       (when (nil? max-expand-and-reduce)
             (setf max-expand-and-reduce 1000000))
       (setf expr (expand^ expr max-expand-and-reduce to-print))
       (reduce^ expr max-expand-and-reduce to-print)))

(protect1 'expand^ '(expr max-expand-and-reduce to-print))

;---------------------------------------------------------------

(define (expand// expr)
  (letn((a (args))
        (expand//sym (lambda(n)(symbol-from-sexpr (list 'expand// n))))
        (expandlist

    (if (empty? a)
        (throw-error "expand//: arguments missing.")

        (cond ((symbol? (first a))
               (append (map (lambda(i)(list i (expand//sym $idx))) a)
                       (map (lambda(i)(list (expand//sym $idx) (eval i))) a)))

              ((list? (first a))
               (append (map (lambda(i)(list (i 0) (expand//sym $idx))) (first a))
                       (map (lambda(i)(list (expand//sym $idx) (i 1))) (first a))))))))

       ;(println "expandlist=" expandlist)
       (expand expr expandlist)))

(protect1 'expand// '(expr a expand//sym n expandlist i))

(setf x 'y)
(setf y 3)
(test "expand//1" (= (expand// '(x y) 'x 'y) '(y 3)))
(test "expand//2" (= (expand// '(x y) '((x y)(y 3))) '(y 3)))


;###############################################################
;#                                                             #
;#           LEAVE THIS ON THE END OF THE LIBRARY              #
;#                                                             #
;###############################################################

(set 'Default.number-of-symbols.after
     (length (symbols)))

(set 'Default.number-of-primitives.after
     (length (filter primitive? (map eval (symbols)))))

(set 'Default.number-of-functions.after
     (length (filter lambda? (map eval (symbols)))))

(set 'Default.number-of-macros.after
     (length (filter macro? (map eval (symbols)))))

))) ; <=== leave this here - it is end of the timing operation

(println "--------------------------------------------------------------")

(println "Defined\n\n"
   (format "%10d%s"
           (- Default.number-of-symbols.after
              Default.number-of-symbols.before)
           " symbols:\n")

   (format "%10d%s"
           (- Default.number-of-primitives.after
              Default.number-of-primitives.before)
           " for primitives,\n")

   (format "%10d%s"
           (- Default.number-of-functions.after
              Default.number-of-functions.before)
           " for functions and \n")

   (format "%10d%s"
           (- Default.number-of-macros.after
              Default.number-of-macros.before)
           " for macros.\n"))

(println "Performed\n\n"
   (format "%10d%s" [test.counter] " tests:\n")
   (format "%10d%s" [test.passed] " passed and \n")
   (format "%10d%s" [test.failed] " failed (one should fail!)\n"))

(println "Library loading time: "
          (/. Default.loading-time 1000) " seconds.")

(println "--------------------------------------------------------------")
(println "     Do you want to load this library without these reports?")
(println "    Check 'supressing printing' on the beginning of the file.")
(println "--------------------------------------------------------------")

true


===========
 CSV FILE
===========

; -------------------------------------------------------------------------
; csv.lsp
; a simple set of Lisp functions for managing csv flat databases
; Luis Argüelles, 2014
; www.fuzzylisp.com
; modify and adapted by cameyo 2018
; (load "csv.lsp")
; (load "e:/Lisp-Scheme/newLisp/MAX/csv/csv.lsp")
; -------------------------------------------------------------------------

; Assign the data of db (csv) to a list (messier)
; It is a list of sublists. Each sublist is a row.
; The first sublist contains the names of columns.
; All data are parsed as string.

;(setq messier (db-load))

; Assign the names of the fields of the db
;(setq fields (first messier))
;(setq fields (nth 0 messier))

; (define (db-load, f1 str lst)
;   (setq lst '())
;   ;(setq f1 (open "e:/Lisp-Scheme/newLisp/MAX/csv/Messier.csv" "read"))
;   (setq f1 (open "e:/Lisp-Scheme/newLisp/MAX/csv/db.csv" "read"))
;   (while (setq str (read-line f1))
;       (setq lst (cons (parse str ",") lst))
;       ;(write-line)
;   );while
;   (close f1)
;   (reverse lst)
; )

;(db-load "e:/Lisp-Scheme/newLisp/MAX/csv/db1.csv" "|")
;(silent (setq db (db-load "e:/Lisp-Scheme/newLisp/MAX/csv/db-all.csv" ",")))
(define (db-load filename delim , str lst)
  (setq lst '())
  ;(setq f1 (open "e:/Lisp-Scheme/newLisp/MAX/csv/Messier.csv" "read"))
  (setq f1 (open "e:/Lisp-Scheme/newLisp/MAX/csv/db.csv" "read"))
  (setq f1 (open filename "read"))
  (while (setq str (read-line f1))
      (setq lst (cons (parse str delim) lst))
      ;(write-line)
  );while
  (close f1)
  (reverse lst)
)

; This function returns the name of the fields in the base of
; data to help user at the Lisp prompt

(define (db-fields lst)
  (nth 0 lst)
)

; design of the function (db-tell) to interrogate the database
; if we say (db-tell lst id) it will take the database already loaded in lst
; and it will return the sublist of the first identifier. For example:
; (db-tell lst "M108") -> ("M108" "3556" "Ursa Major" "Spiral galaxy"
; "11h 11.5m" "55d 40m" "10.1" "7.7x1.3" "*" "Sc - edge-on/M97 in field")

(define (db-tell lst id, i l aux-lst result)
  (setq i 0)
  (setq l (length lst))
  (while (< i l)
    (setq aux-lst (nth i lst))
      (if (= id (first aux-lst))
        (setq result aux-lst)
      )
      (setq i (+ 1 i))
  );end while
  result
)

; db-tell2 allows to interrogate the database giving it the name
; of the first element of the row and one of the names of the
; fields. For example:
; (db-tell2 lst "M45" "Constellation") -> "Taurus"
; (db-tell2 lst "M42" "Remarks") -> "Great Orion Nebula"

(define (db-tell2 lst id a-field, i l aux-lst result position)
  (setq i 0)
  (setq l (length lst))

  (while (< i l)
    (setq aux-lst (nth i lst))
      (if (= id (first aux-lst))
        (setq result aux-lst)
      )
      (setq i (+ 1 i))
  );end while
  ;(cons result (find a-field (nth 0 lst)))
  (setq position (find a-field (nth 0 lst)))
  (nth position result) ;index
)

; the following function adds a new field to the
; database. Take into account it is not a destructive
; function, so it must be used, for example:
; (setq messier (db-new-field messier "My observations"))
; this would add the field "My observation" to messier database

(define (db-new-field lst name-field , i l lst-out)
  (setq lst-out '())
  (setq l (length lst)) ;number of records in lst
  ;in the following line we append the new field's name
  (setq lst-out (cons (append (nth 0 lst) (list name-field)) lst-out))
  ;then we copy the entire database, making space in every record
  ;for the new field
  (setq i 1)
  (while (< i l)
    (setq lst-out (cons (append (nth i lst) (list "")) lst-out))
    (setq i (+ 1 i))
  );while
  (reverse lst-out)
);end function

;this function substitutes the content of a field in a record
;parameters:
;    - lst: the database in list form
;    - record: the entire record to be updated in list form
;    - field: the name of the field as string
;    - new-data: data to be updated as string
;
; call example:
; (db-update-record messier (nth 42 messier) "Remarks" "great sight with the Zeiss telescope")
;-> ("M42" "1976" "Orion" "Diffuse nebula" "5h 35.4m" "-5d 27m" "2.9" "66x60" "!!!" "great sight with the Zeiss telescope")
; another call:
; (db-update-record lst (nth 42 lst) "Constellation" "I'm not sure")
;-> ("M42" "1976" "I'm not sure" "Diffuse nebula" "5h 35.4m" "-5d 27m" "2.9" "66x60" "!!!" "Great Orion Nebula")
;important remark: this function is not destructive. Have it into account
;;This is an auxiliary function to (db-update)

(define (db-update-record lst record field new-data, position j l record-out)
  (setq record-out '())
  (setq j 0)
  (setq l (length record))
  ;gets the position of the field looking in the first record:
  (setq position (find field (nth 0 lst)))
  ;replaces the data:
  (while (< j l)
    (if (= j position)
      (setq record-out (cons new-data record-out)) ;if it evaluates to true
      (setq record-out (cons (nth j record) record-out)) ;else copy the element
    );end if
    (setq j (+ j 1))
  )
  (reverse record-out)
)

;(db-save) saves the database in memory to a file
(define (db-save db, i j length2 length2 record)
  (setq f1 (open "Documents/Libro Lisp y Fuzzy Logic/FuzzyLisp/Out.csv" "write"))
  (println "saving database.....")
  (setq j 0)
  (setq length1 (length db)) ;number of records in db
  (while (< j length1)
    (setq record (nth j db)) ;loads a record
    (setq length2 (length record)) ;number of fields in the record
    (setq i 0)
  ;now, for each record:
    (while (< i length2)
        (write f1 (nth i record))
        (if (< i (- length2 1))
           (write f1 ",")
        );end if
        (setq i (+ 1 i))
    );internal while
    (write f1 "\n")
    (setq j (+ 1 j))
  );enf while j
  (close f1)
  (println "Database saved Ok")
  (println j " records sucessfully saved.")
  true
)

; returns the number of row given by the value of first field key in the database
; (db-get-row-number messier "M42") -> 42
; This is an auxiliary function to (db-update)
(define (db-get-row-number db key, i length1 row-number)
  (setq i 0)
  (setq length1 (length db))
  (while (< i length1)
    (if (= key (first (nth i db)))
      (setq row-number i)
    )
    (setq i (+ 1 i))
  );while end
  row-number
)

;(db-update messier "M42" "Constellation" "I'm not sure")
(define (db-update db key field new-data, row-number i length1 db-out)
  (setq row-number (db-get-row-number db key)) ;get the index of the row
  (setq i 0)
  (setq db-out '())
  (setq length1 (length db)) ;number of records in db
  ;copy the first set of records
  (while (< i row-number)
      (setq db-out (cons (nth i db) db-out))
      (setq i (+ 1 i))
  )
  ;update the record:
  (setq db-out (cons (db-update-record db (nth row-number db) field new-data) db-out))
  (setq i (+ 1 i)); advances one row
  ;copy the rest of records
  (while (< i length1)
      (setq db-out (cons (nth i db) db-out))
      (setq i (+ 1 i))
  )
  (reverse db-out)
)

;(db-filter messier '(= "Constellation" "Orion"))
;(db-filter messier '(= "Class" "Globular cluster"))
;(db-filter messier '(= "Class" "Spiral galaxy"))
;(db-filter messier '(<= "Magnitude" 4))
;(setq galaxies (db-filter messier '(= "Class" "Spiral galaxy")))

(define (db-filter db expr, i, length1 header record field-id lst-out str)
  (setq i 1)
  (setq lst-out '())
  (setq lst-out (cons (nth 0 db) lst-out)) ;header row (name of the fields)
  (setq length1 (length db))
  (setq header (first db)) ;name of fields
  (setq field-id (find (nth 1 expr) header)) ;field index
  (while (< i length1)
      (setq record (nth i db));current record
      (setq str (nth field-id record))
      ; if (last expr) is a number then convert (nth field-id record) in number
      (if (number? (last expr))
        ;(setq str (eval-string str))
        (setq str (float str))
      );if
      (if (eval (list (eval '(first expr)) str (last expr)))
        ;(println (nth 0 record) " within filter")
        (setq lst-out (cons record lst-out))
      );if
  (setq i (+ 1 i))
  );while
  (reverse lst-out)
)

; db-stats returns the statistics of a field, that is, numbers located
; in columns. It assumes that the content of the field are strings that
; represent numbers.
; example: (db-stats messier "Magnitude") ->
; (110 7.534545455 1.540495868 1.914715413 3.666135113 -0.4639868813 0.3590037872)
(define (db-stats db field, header field-id i lst length1)
  (setq header (first db));get name of fields
  (setq field-id (find field header));find the position of the field
  (setq lst '())
  (setq i 1)
  (setq length1 (length db))
  (while (< i length1)
    ;get a record, get its field, convert from string to number and
    ;cons it in lst
    (setq lst (cons (eval-string (nth field-id (nth i db))) lst))
    (setq i (+ 1 i))
  );while
  (stats (reverse lst)) ;return the statistics
)

; A simple menu
; (define (db-menu)
;   (print "\nCSV database manager\n\n")
;   (print "1. Load a database into memory\n")
;   (print "2. Get the name of fields in a database\n")
;   (print "3. Query the database\n")
;   (print "4. Add a new field to the database\n")
;   (print "5. Update the database\n")
;   (print "6. Filter the database\n")
;   (print "7. Calculate statistics\n")
;   (print "8. Save the database\n")
;   (print "\nChoose an option (1-8): ")
;   (read-line)
; )
;
; (db-menu)


; (db-see)
; Print records from start number to end number
; Call example: (dbsee db 1 10)
(define (db-see lst start end)
  ;(println (nth 0 lst))
  (setq numrec (- (length lst) 1))
  (println (format (get-format lst) (nth 0 lst)))
  (if (>= end numrec)
      (setq end numrec)
  )
  (while (<= start end)
      ;(println (nth start lst))
      ;(println (format "%-10s %-10s %-10s %-10s %-10s" (nth start lst)))
      ;(println (format "%-4s %-12s %-13s %-7s %-3s" (nth start lst)))
      (println (format (get-format lst) (nth start lst)))
      (setq start (+ 1 start))
  )
  ;(print (char 7))
)

; return a format string for db-see function
; Find the max lenght of field value for all the fields
(define (get-format db)
  (setq db1 (transpose db))
  (setq fmt "")
  (setq row 0)
  (while (< row (length db1))
      (setq fmt (append fmt "%-" (string (apply max (map length (nth row db1)))) "s "))
      (setq row (+ 1 row))
  )
  fmt
)

(println "EOF csv.lsp")
; -------------------- EOF ------------------------

=============================================================================

