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

Sul forum di newLISP, rickyboy ha fornito le seguenti funzioni equivalenti (che sono molto più compatte):

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

Nella seconda sintassi, la differenza funziona in modalità elenco
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

Scriviamo altre funzioni per la gestione degli alberi binari.

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
 LITTLE SCHEMER LIBRARY
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
(constant 'MB_ABORTRETRYIGNORE  	  0x00000002) ; The message box contains three push buttons: Abort, Retry, and Ignore.
(constant 'MB_CANCELTRYCONTINUE 	  0x00000006) ; The message box contains three push buttons: Cancel, Try Again, Continue. Use this message box type instead of MB_ABORTRETRYIGNORE. 
(constant 'MB_HELP              	  0x00004000) ; Adds a Help button to the message box. When the user clicks the Help button or presses F1, the system sends a WM_HELP message to the owner. 
(constant 'MB_OK             	 	    0x00000000) ; The message box contains one push button: OK. This is the default. 
(constant 'MB_OKCANCEL 		 	        0x00000001) ; The message box contains two push buttons: OK and Cancel. 
(constant 'MB_RETRYCANCEL 	 	      0x00000005) ; The message box contains two push buttons: Retry and Cancel. 
(constant 'MB_YESNO 		 	          0x00000004) ; The message box contains two push buttons: Yes and No. 
(constant 'MB_YESNOCANCEL 	 	      0x00000003) ; The message box contains three push buttons: Yes, No, and Cancel. 

; message box icons
(constant 'MB_ICONEXCLAMATION 	    0x00000030) ; An exclamation-point icon appears in the message box.
(constant 'MB_ICONWARNING 	 	      0x00000030) ; An exclamation-point icon appears in the message box.  
(constant 'MB_ICONINFORMATION 	    0x00000040) ; An icon consisting of a lowercase letter i in a circle appears in the message box.  
(constant 'MB_ICONASTERISK 	 	      0x00000040) ; An icon consisting of a lowercase letter i in a circle appears in the message box. 
(constant 'MB_ICONQUESTION 	 	      0x00000020) ; A question-mark icon appears in the message box. 
(constant 'MB_ICONSTOP 		 	        0x00000010) ; A stop-sign icon appears in the message box.
(constant 'MB_ICONERROR 		        0x00000010) ; A stop-sign icon appears in the message box.
(constant 'MB_ICONHAND 		 	        0x00000010) ; A stop-sign icon appears in the message box. 

; message box default button specification
(constant 'MB_DEFBUTTON1 	 	        0x00000000) ; The first button is the default button. MB_DEFBUTTON1 is the default unless another is specified.
(constant 'MB_DEFBUTTON2 	 	        0x00000100) ; he second button is the default button.
(constant 'MB_DEFBUTTON3 	 	        0x00000200) ; The third button is the default button.
(constant 'MB_DEFBUTTON4 	 	        0x00000300) ; The fourth button is the default button.

; message box modality
(constant 'MB_APPLMODAL 		        0x00000000) ; The user must respond to the message box before continuing work in the window (hWnd parameter).
(constant 'MB_SYSTEMMODAL 	 	      0x00001000) ; Same as MB_APPLMODAL except that the message box has the WS_EX_TOPMOST style.
(constant 'MB_TASKMODAL 		        0x00002000) ; Same as MB_APPLMODAL except that all the top-level windows belonging to the current thread are disabled if the hWnd parameter is NULL.

; message box other options
(constant 'MB_DEFAULT_DESKTOP_ONLY 	0x00020000) ; If the current input desktop is not the default desktop, MessageBox does not return until the user switches to the default desktop.
(constant 'MB_RIGHT 			          0x00080000) ; The text is right-justified.
(constant 'MB_RTLREADING 		        0x00100000) ; Displays message and caption text using right-to-left reading order on Hebrew and Arabic systems.
(constant 'MB_SETFOREGROUND 		    0x00010000) ; The message box becomes the foreground window.
(constant 'MB_TOPMOST 			        0x00040000) ; The message box is created with the WS_EX_TOPMOST window style.
(constant 'MB_SERVICE_NOTIFICATION 	0x00200000) ; The caller is a service notifying the user of an event. If this flag is set, the hWnd parameter must be NULL.

; message box return values
(constant 'IDOK				1)
(constant 'IDCANCEL 	2)
(constant 'IDABORT 		3)
(constant 'IDRETRY		4)
(constant 'IDIGNORE 	5)
(constant 'IDYES			6)
(constant 'IDNO				7)
(constant 'IDTRYAGAIN	10)
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


