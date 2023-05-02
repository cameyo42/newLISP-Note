================

 NOTE LIBERE 16

================

----------------------------------------------
Lancio di una moneta e probabilità (Fibonacci)
----------------------------------------------

Qual è la probabilità che lanciando n volte una moneta non si ottengano Teste successive?

La probabilità vale:  prob = F(n+2)/2^n
                             dove F(n) è la funzione di Fibonacci.

Per la dimostrazione vedi "Games Gambling and Probability" di David Taylor.

(define (fibo-i num)
"Calculates the Fibonacci number of an integer number"
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- num 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a))

(define (prob-exact n) (div (fibo-i (+ n 2)) (pow 2 n)))

(time (for (n 2 20) (println n { } (prob-exact n))))
;-> 2 0.75
;-> 3 0.625
;-> 4 0.5
;-> 5 0.40625
;-> 6 0.328125
;-> 7 0.265625
;-> 8 0.21484375
;-> 9 0.173828125
;-> 10 0.140625
;-> 11 0.11376953125
;-> 12 0.092041015625
;-> 13 0.074462890625
;-> 14 0.06024169921875
;-> 15 0.048736572265625
;-> 16 0.0394287109375
;-> 17 0.03189849853515625
;-> 18 0.02580642700195313
;-> 19 0.02087783813476563
;-> 20 0.01689052581787109
;-> 6.017

(define (prob n iter)
  (local (t2 prev)
    (setq t2 0)
    (for (i 1 iter)
      (setq prev 1) ; 1 = croce
      (setq stop nil)
      (for (i 1 n 1 stop)
        (setq moneta (rand 2))
        (if (and (zero? moneta) (zero? prev))
            (set 't2 (+ t2 1) 'stop true)
        )
        (setq prev moneta)
      )
    )
    (sub 1 (div t2 iter))))

(time (for (n 2 20) (println n { } (prob n 1e7))))
;-> 2 0.7499642
;-> 3 0.6251121
;-> 4 0.5000997
;-> 5 0.4065151
;-> 6 0.3281095000000001
;-> 7 0.2654514
;-> 8 0.2147279
;-> 9 0.1739428
;-> 10 0.1404965
;-> 11 0.1136871
;-> 12 0.09208360000000004
;-> 13 0.07429520000000001
;-> 14 0.06014719999999996
;-> 15 0.04869690000000004
;-> 16 0.03937780000000002
;-> 17 0.0318349
;-> 18 0.02584909999999996
;-> 19 0.02092229999999995
;-> 20 0.01687899999999998
;-> 134666.968


----------------------
Probabilità a Monopoli
----------------------

Monopoli - Edizione Editrice Giochi

Calcoliamo le probabilità di visita di ogni casella del gioco del Monopoli da parte di un giocatore.

Simulazione
Partenza dal Via (0) e lancio di due dadi per un determinato numero di volte (iter).
Ad ogni lancio ci spostiamo in avanti dalla casella corrente di tante caselle quanto è il punteggio ottenuto.
Se capitiamo in una casella "Probabilità" o "Imprevisti", estraiamo una carta e applichiamo l'azione relativa (se comporta una modifica della posizione corrente).
Al termine di tutti i lanci calcoliamo il numero totale degli spostamenti fatti e calcoliamo la frequenza di visita di ogni casella.
Nota che il numero di volte che lanciamo il dado (iter) è minore del numero totale degli spostamenti (perchè le carte possono provocare uno spostamento senza lanciare i dadi).

Nota: non viene considerata la regola che se si ottengono 3 lanci doppi consecutivi si finisce direttamente in prigione, senza passare dal Via!.

Elenco Proprietà (40)
---------------------
0 "VIA!"
1 "Vicolo Corto"
2 "Probabilità"
3 "Vicolo Stretto"
4 "Tassa patrimoniale"
5 "Stazione Sud"
6 "Bastioni Gran Sasso"
7 "Imprevisti"
8 "Viale Monterosa"
9  "Viale Vesuvio"
10 "Prigione/Transito"
11 "Via Accademia"
12 "Società Elettrica"
13 "Corso Ateneo"
14 "Piazza Università"
15 "Stazione Ovest"
16 "Via Verdi"
17 "Probabilità"
18 "Corso Raffaello"
19 "Piazza Dante"
20 "Posteggio gratuito"
21 "Via Marco Polo"
22 "Imprevisti"
23 "Corso Magellano"
24 "Largo Colombo"
25 "Stazione Nord"
26 "Viale Costantino"
27 "Viale Traiano"
28 "Sociatà Acqua Potabile"
29 "Piazza Giulio Cesare"
30 "In prigione!"
31 "Via Roma"
32 "Corso Impero"
33 "Probabilità"
34 "Largo Augusto"
35 "Stazione Est"
36 "Imprevisti"
37 "Viale dei Giardini"
38 "Tassa del lusso"
39 "Parco della Vittoria"

Carte degli IMPREVISTI (16)
---------------------------
 1 "Andate fino al Parco della Vittoria."
 2 "Matrimonio in famiglia: spese impreviste 15.000."
 3 "Multa di 1500 lire per aver guidato senza patente."
 4 "Avete vinto un terno al lotto: ritirate 10.000 lire."
 5 "Andate alla Stazione NORD: se passate dal <<Via!>> ritirate le 20.000 lire."
 6 "La banca Vi paga gli interessi del vostro Conto Corrente: ritirate 5.000 lire."
 7 "Andate fino al Largo Colombo: se passate dal << Via! >> ritirate 20.000 lire."
 8 "Andate fino a Via Accademia: se passate dal << Via! >> ritirate 20.000 lire."
 9 "Versate 2.000 lire per beneficienza."
10 "Fate 3 passi indietro (con tanti auguri)."
11 "Dovete pagare un contributo di miglioria stradale, 4.000 lire per ogni casa, 10.000 lire per ogni albergo che possedete."
12 "Uscite gratis di prigione, se ci siete: potete conservare questo cartoncino sino al momento di servirvene (non si sa mai!), oppure venderlo."
13 "Maturano le cedole delle vostre cartelle di rendita, ritirate 15.000 lire."
14 "Andate in prigione direttamente e senza passare dal << Via! >>."
15 "Andate avanti fino al << Via! >>."
16 "Avete tutti i vostri stabili da riparare: pagare 2.500 lire per ogni casa e 10.000 per ogni albergo."

Carte delle PROBABILITÀ (16)
----------------------------
1  "Andate fino al << Via! >>."
2  "Pagate il conto del Dottore: 5.000 lire."
3  "Scade il Vostro premio di assicurazione: pagate 5.000 lire."
4  "Siete creditori verso la Banca di 20.000 lire: ritirateli."
5  "Avete vinto il secondo premio in un concorso di bellezza: ritirate 1.000 lire."
6  "Andate in prigione direttamente e senza passare dal << Via! >>."
7  "Ritornate al Vicolo Corto."
8  "Avete venduto delle azioni: ricavate 5.000 lire."
9  "È il vostro compleanno: ogni giocatore Vi regala 1.000 lire."
10 "Avete vinto un premio di consolazione alla Lotteria di Merano: ritirate 10.000 lire."
11 "Rimborso tassa sul reddito: ritirate 2.000 lire dalla Banca."
12 "Ereditate da un lontano parente 10.000 lire"
13 "Avete perso una causa: pagate 10.000 lire."
14 "Uscite gratis di prigione, se ci siete: potete conservare questo cartoncino fino al momento di servirvene (non si sa mai!), oppure venderlo."
15 "È maturata la cedola delle Vostre azioni: ritirate 2500 lire."
16 "Pagate una multa di 1.000, oppure prendete un cartoncino dagli << imprevisti >>."

; Roll N die with 6 sides and return the sum of numbers
(define (dice6 n) (+ n (apply + (rand 6 n))))

Lista delle caselle:

(setq caselle '((0 "VIA!")
                (1 "Vicolo Corto")
                (2 "Probabilità")
                (3 "Vicolo Stretto")
                (4 "Tassa patrimoniale")
                (5 "Stazione Sud")
                (6 "Bastioni Gran Sasso")
                (7 "Imprevisti")
                (8 "Viale Monterosa")
                (9  "Viale Vesuvio")
                (10 "Prigione/Transito")
                (11 "Via Accademia")
                (12 "Società Elettrica")
                (13 "Corso Ateneo")
                (14 "Piazza Università")
                (15 "Stazione Ovest")
                (16 "Via Verdi")
                (17 "Probabilità")
                (18 "Corso Raffaello")
                (19 "Piazza Dante")
                (20 "Posteggio gratuito")
                (21 "Via Marco Polo")
                (22 "Imprevisti")
                (23 "Corso Magellano")
                (24 "Largo Colombo")
                (25 "Stazione Nord")
                (26 "Viale Costantino")
                (27 "Viale Traiano")
                (28 "Società Acqua Potabile")
                (29 "Piazza Giulio Cesare")
                (30 "In prigione!")
                (31 "Via Roma")
                (32 "Corso Impero")
                (33 "Probabilità")
                (34 "Largo Augusto")
                (35 "Stazione Est")
                (36 "Imprevisti")
                (37 "Viale dei Giardini")
                (38 "Tassa del lusso")
                (39 "Parco della Vittoria")))

Funzione che simula gli spostamenti delle carte delle probabilità:

(define (probabilita)
  (local (prob update)
    ; probabilità random
    (setq prob (+ (rand 16) 1))
    (setq update true)
    (cond ((and (= prob 1) (zero? (p-card prob)))  ; goto VIA!
            (setq pos 0)
            (setf (p-card 1) 1))
          ((and (= prob 6) (zero? (p-card prob)))  ; goto Prigione
            (setq pos 10)
            (setf (p-card 6) 1))
          ((and (= prob 7) (zero? (p-card prob)))  ; goto Vicolo Corto
            (setq pos 1)
            (setf (p-card 7) 1))
          (true (setq update nil))
    )
    ;(println "prob:" prob { = } update)
    (if update (++ (freq pos)))))

Funzione che simula gli spostamenti delle carte degli imprevisti:

(define (imprevisti)
  (local (impr update)
    ; imprevisto random
    (setq impr (+ (rand 16) 1))
    (setq update true)
          ; goto Parco della Vittoria
    (cond ((and (= impr 1) (zero? (i-card impr)))
            (setq pos 30) (setf (i-card impr) 1))
          ; goto Stazione NORD
          ((and (= impr 5) (zero? (i-card impr)))
            (setq pos 25) (setf (i-card impr) 1))
          ; goto Largo Colombo
          ((and (= impr 7) (zero? (i-card impr)))
            (setq pos 24) (setf (i-card impr) 1))
          ; goto Via Accademia
          ((and (= impr 8) (zero? (i-card impr)))
            (setq pos 11) (setf (i-card impr) 1))
          ; goto 3 passi indietro
          ((and (= impr 10) (zero? (i-card impr)))
            (setq pos (abs (% (- pos 3) 40))) (setf (i-card impr) 1))
          ; goto Prigione
          ((and (= impr 14) (zero? (i-card impr)))
            (setq pos 10) (setf (i-card impr) 1))
          ; goto VIA!
          ((and (= impr 15) (zero? (i-card impr)))
            (setq pos 0) (setf (i-card impr) 1))
          (true (setq update nil))
    )
    ;(println "impr:" impr { = } update)
    (if update (++ (freq pos)))))

Funzione di simulazione per calcolare la frequenza di visita di tutte le caselle del Monopoli:

(define (monopoli iter)
  (local (freq pos move tot p-card i-card)
    (setq freq (array 40 '(0)))
    ; carte degli imprevisti (0,1)
    (setq i-card (array 17 '(0)))
    ; carte delle probabilità (0,1)
    (setq p-card (array 17 '(0)))
    (setq pos 0)
    (for (i 1 iter)
      (setq move (dice6 2))
      (setq pos (% (+ pos move) 40))
      (++ (freq pos))
      ; check action for current position
      (cond ((= pos 2) (probabilita))  ; probabilità
            ((= pos 7) (imprevisti))   ; imprevisti
            ((= pos 17) (probabilita)) ; probabilità
            ((= pos 22) (imprevisti))  ; imprevisti
            ((= pos 30)                ; prigione
              (setq pos 10) (++ (freq pos)))
            ((= pos 33) (probabilita)) ; probabilità
            ((= pos 36) (imprevisti))  ; imprevisti
      )
    )
    (setq tot (apply + freq))
    (dolist (f freq) (println (format "%24s %5.4f%%" (lookup $idx caselle) (mul 100 (div f tot)))))
    (println "Numero lanci:" iter)
    (println "Numero spostamenti: " tot)))

Eseguiamo la simulazione:

(monopoli 1e7)
;->                     VIA! 2.2357%
;->             Vicolo Corto 2.2573%
;->              Probabilità 2.2600%
;->           Vicolo Stretto 2.2931%
;->       Tassa patrimoniale 2.2639%
;->             Stazione Sud 2.2410%
;->      Bastioni Gran Sasso 2.2320%
;->               Imprevisti 2.2365%
;->          Viale Monterosa 2.2436%
;->            Viale Vesuvio 2.2538%
;->        Prigione/Transito 4.8627%
;->            Via Accademia 2.2522%
;->        Società Elettrica 2.3206%
;->             Corso Ateneo 2.3955%
;->        Piazza Università 2.4551%
;->           Stazione Ovest 2.5482%
;->                Via Verdi 2.6275%
;->              Probabilità 2.7298%
;->          Corso Raffaello 2.6792%
;->             Piazza Dante 2.6506%
;->       Posteggio gratuito 2.6364%
;->           Via Marco Polo 2.6208%
;->               Imprevisti 2.5947%
;->          Corso Magellano 2.5751%
;->            Largo Colombo 2.6124%
;->            Stazione Nord 2.6270%
;->         Viale Costantino 2.6378%
;->            Viale Traiano 2.6358%
;->   Società Acqua Potabile 2.6263%
;->     Piazza Giulio Cesare 2.6288%
;->             In prigione! 2.6133%
;->                 Via Roma 2.6111%
;->             Corso Impero 2.5460%
;->              Probabilità 2.4788%
;->            Largo Augusto 2.4049%
;->             Stazione Est 2.3185%
;->               Imprevisti 2.2404%
;->       Viale dei Giardini 2.1504%
;->          Tassa del lusso 2.1896%
;->     Parco della Vittoria 2.2135%
;-> Numero lanci:10000000
;-> Numero spostamenti: 10268355


-------------------------------------------------------------------
Forum: Macro version of define that prints args when func is called
-------------------------------------------------------------------

cormullion:
-----------
Hi. I'm trying to make a new version of define, such that when the function it defines is called, it prints its arguments (eg to a log file).
I think it should be possible.

Here's how far I've got:

(define-macro (my-define)
  (set (args 0 0)
    (append (lambda)
      (list
        (rest (first (args))))
        (println {call } (first (args)))
        (rest (args)))))

(my-define (p2 a1 a2) (println a1) (println a2))
;-> call (p2 a1 a2)
;-> (lambda (a1 a2) p2 a1 a2 (println a1) (println a2))

(p2 "bill" "bob")
;-> bill
;-> bob

But this prints the arguments when the function is first defined, not when it's subsequently called. Is there a way of delaying that 'print' till later on?

Fanda:
------
'define' creates a lambda function/list. 
You need to include your 'print' functions into the newly created function:

Try if this works:

(define-macro (my-define @farg)
   (set (@farg 0)
      (letex (@arg (rest @farg)
                  @arg-p (cons 'list (map (fn (@x) (if (list? @x) (first @x) @x)) (rest @farg)))
                  @body (args))
         (append (lambda @arg
            (println "params: " @arg-p)
            (println "args: " (args)))
            '@body))))

(constant (global 'define) my-define)

Example:

(define (f x) (+ x x))
;-> (lambda (x) (println "params: " (list x)) (println "args: " (args)) (+ x x))
f
;-> (lambda (x) (println "params: " (list x)) (println "args: " (args)) (+ x x))
(f 2)
;-> params: (2)
;-> args: ()
;-> 4
(f 2 3 4)
;-> params: (2)
;-> args: (3 4)
;-> 4

(define (f (x 10)) (+ x x))
;-> (lambda ((x 10)) (println "params: " (list x)) (println "args: " (args))
;->  (+ x x))
f
;-> (lambda ((x 10)) (println "params: " (list x)) (println "args: " (args))
;->  (+ x x))
(f)
;-> params: (10)
;-> args: ()
;-> 20
(f 3)
;-> params: (3)
;-> args: ()
;-> 6
(f 3 4 5)
;-> params: (3)
;-> args: (4 5)
;-> 6

Lutz:
-----
Fanda wrote: (constant (global 'define) my-define)
Nice idea.

cormullion:
-----------

Wicked cool, Fanda! You've done the clever bit for me...
I might change those @ signs to something else - I find them visually distracting... Underscores appear to work...
thanks!

Could this be easily modified so that the function name is also printed?
Edit: oh yes, i see:

(define-macro (my-define @farg)
   (set @fn (@farg 0)) ; that's the function name
   (set (@farg 0)
      (letex....

Edit 2: Ah, that doesn't work properly because it's global... Hmm

Fanda:
-----

Again, you need to put the function name inside the 'println' inside the 'lambda fn'.

(define-macro (my-define @farg)
  (set (@farg 0)
    (letex (@fn (@farg 0)
            @arg (rest @farg)
            @arg-p (cons 'list (map (fn (@x) (if (list? @x) (first @x) @x)) (rest @farg)))
            @body (args))
      (append
           (lambda @arg (println "[" '@fn "] params: " @arg-p " args: " (args)))
        '@body))))

(constant (global 'define) my-define)

Example:

(define (f x) (+ x x))
;-> (lambda (x) (println "[" 'f "] params: " (list x) " args: " (args)) (+ x x))
f
;-> (lambda (x) (println "[" 'f "] params: " (list x) " args: " (args)) (+ x x))
(f 2)
;-> [f] params: (2) args: ()
;-> 4

(define (f (x 10) y) (+ x y))
;-> (lambda ((x 10) y) (println "[" 'f "] params: " (list x y) " args: " (args))
 ;-> (+ x y))
(f 2 3)
;-> [f] params: (2 3) args: ()
;-> 5
(f 2 3 4 5)
;-> [f] params: (2 3) args: (4 5)
;-> 5

PS: I am using @ sign as an other-than-underscore sign, because some functions can be macro-like and use underscores for their variables.

One more version returning result of a function:

(define-macro (my-define @farg)
  (set (@farg 0)
    (letex (@fn (@farg 0)
            @arg (rest @farg)
            @arg-p (cons 'list (map (fn (@x) (if (list? @x) (first @x) @x)) (rest @farg)))
            @body (cons 'begin (args)))
       (lambda @arg
         (println "[" '@fn "] params: " @arg-p " args: " (args))
         (println "[" '@fn "] result: " @body)))))

(constant (global 'define) my-define)

Example:

(define (f (x 10) y) (+ x y))
;-> (lambda ((x 10) y) (println "[" 'f "] params: " (list x y) " args: "
;->   (args))
;->  (println "[" 'f "] result: "
;->   (begin
;->    (+ x y))))
(f 2 3)
;-> [f] params: (2 3) args: ()
;-> [f] result: 5
;-> 5
(f 2 3 4 5)
;-> [f] params: (2 3) args: (4 5)
;-> [f] result: 5
;-> 5

cormullion:
-----------

Aha - that looks like the one.
I find these constructions really difficult to conjure up, and so I'm really glad for your help. Perhap's it's something to do with the hypothetical nature of things that are going to be evaluated sometime in the future but now now...
thanks!


----------------------
Cattura Numeri (gioco)
----------------------

Questo gioco utilizza una griglia NxN, dove N è un numero pari.
Ogni cella della griglia contiene un numero. 
I numeri vanno da 1 a N^2, ogni numero appare esattamente una volta.
A turno, due giocatori scelgono un numero dalla griglia.
Il numero scelto viene rimosso dalla griglia e viene aggiunto al punteggio del relativo giocatore.
Si possono scegliere solo i numeri che hanno una cella adiacente vuota (cioè quei numeri che hanno una cella vuota immediatamente sopra, sotto o direttamente alla sua sinistra o destra).
Poiché all'inizio non ci sono caselle vuote, il primo giocatore, alla sua prima mossa, può scegliere una qualsiasi delle N^2 caselle possibili che non abbia un valore superiore al 40% del valore massimo (40% di N^2).

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

Per simulare il gioco supponiamo che la strategia dei giocatori sia quella di selezionare dalla griglia il massimo valore possibile.

Funzione che trova in una matrice il valore massimo che ha uno 0 adiacente:

(define (find-max)
  (let (val-max 0)
    (for (i 0 (- n 1))
      (for (j 0 (- n 1))
        (if (!= (grid i j) 0)
          (if (or (and (> i 0) (= (grid (- i 1) j) 0))
                  (and (< i (- n 1)) (= (grid (+ i 1) j) 0))
                  (and (> j 0) (= (grid i (- j 1)) 0))
                  (and (< j (- n 1)) (= (grid i (+ j 1)) 0)))
              (setq val-max (max (grid i j) val-max))))))
    val-max))

Funzionamento del gioco:

(setq n 6)
(setq grid (array n n (randomize (sequence 1 (* n n)))))
(print-matrix grid)
;->   7 35 10 26 15 12
;->  13  9 18 29  3 30
;->  34 32 24 25  2 19
;->  11  6 36 22 20 14
;->   8  1 16 33 23  4
;->  28 17  5 31 21 27
(setf (grid 0 1) 0) ;select 35
(print-matrix grid)
;->   7  0 10 26 15 12
;->  13  9 18 29  3 30
;->  34 32 24 25  2 19
;->  11  6 36 22 20 14
;->   8  1 16 33 23  4
;->  28 17  5 31 21 27
(find-max) ; max value in grid with adjacent 0
;-> 10
(setf (grid 0 2) 0) ;select 10
(print-matrix grid)
;->   7  0  0 26 15 12
;->  13  9 18 29  3 30
;->  34 32 24 25  2 19
;->  11  6 36 22 20 14
;->   8  1 16 33 23  4
;->  28 17  5 31 21 27
(find-max) ; max value in grid with adjacent 0
;-> 26
...

Funzione che effettua una partita tra due giocatori:

(define (game n start)
  (local (p1 p2 grid res)
    (setq p1 0) (setq p2 0)
    (setq grid (array-list (array n n (randomize (sequence 1 (* n n))))))
    ; p1 first move
    ; Rimuovere il commento relativo per calcolare le probabilità
    ; con varie scelte della casella iniziale:
    ;(setq res (+ (rand (* n n)) 1)) ; random
    ;(setq res (* n n) ; highest
    ;(setq res 1) ; lowest
    ;(setq res (div (* n n) 2)) ; middle
    (setq res start)
    (++ p1 res)
    (set-ref res grid 0)
    ;(print-matrix grid)
    ;(println res)
    ;(read-line)
    ; p2 first move
    (setq res (find-max))
    (++ p2 res)
    (set-ref res grid 0)
    ;(print-matrix grid)
    ;(println res)
    ;(read-line)
    (for (i 1 (- (div (* n n) 2) 1))
      ; i-th move for p1
      (setq res (find-max))
      (++ p1 res)
      (set-ref res grid 0)
      ;(print-matrix grid)
      ;(println res)
      ;(read-line)
      ; i-th move for p2
      (setq res (find-max))
      (++ p2 res)
      (set-ref res grid 0)
      ;(print-matrix grid)
      ;(println res)
      ;(read-line)
    )
    (if (= p1 p2) 0
        (> p1 p2) 1
        (< p1 p2) 2
    )))

Facciamo alcune prove con valori diversi di N e con diversi modi di scegliere il primo numero:

; random
(setq freq (array 3 '(0)))
(time (for (i 1 1e6) (++ (freq (game 2)))))
;-> 6410.919
freq
;-> (401652 424337 174011)

(setq freq (array 3 '(0)))
(time (for (i 1 1e6) (++ (freq (game 6)))))
;-> 410404.958
freq
;-> (24902 539798 435300)

; lowest (1)
(time (for (i 1 1e6) (++ (freq (game 2)))))
;-> 6322.021
freq
;-> (304802 0 695198)

(setq freq (array 3 '(0)))
(time (for (i 1 1e6) (++ (freq (game 6)))))
;-> 410130.575
freq
;-> (24114 307738 668148)

; middle (N*N)/2
(setq freq (array 3 '(0)))
(time (for (i 1 1e6) (++ (freq (game 2)))))
;-> 5751.165
freq
;-> (651766 348234 0)

(setq freq (array 3 '(0)))
(time (for (i 1 1e6) (++ (freq (game 6)))))
;-> 391872.938
freq
;-> (25996 536356 437648)

Funzione che effettua un numero di partite predefinito:

(define (test n start iter)
  (local (freq)
    (setq freq (array 3 '(0)))
    (for (i 1 iter) (++ (freq (game n start))))
    (println "n: " n { } "start: " start { } "freq: " freq)))

Vediamo quale scelta alla prima mossa rende la partita equa:

60% N^2
(test 10 60 1e3)
;-> n: 10 start: 60 freq: (7 546 447)

50% N^2
(test 10 50 1e3)
;-> n: 10 start: 50 freq: (5 525 470)

40% N^2
(test 10 40 1e3)
;-> n: 10 start: 40 freq: (6 491 503)
(test 10 40 1e4)

(test 10 40 1e5)
;-> n: 10 start: 40 freq: (639 50255 49106)
(test 8 26 1e3)
;-> n: 8 start: 26 freq: (13 493 494)
(test 8 26 1e4)
;-> n: 8 start: 26 freq: (108 4958 4934)
(test 6 14 1e3)
;-> n: 6 start: 14 freq: (20 491 489)
(test 6 14 1e4)
;-> n: 6 start: 14 freq: (252 4756 4992)
(test 12 58 1e3)
;-> n: 12 start: 58 freq: (3 496 501)
(test 12 58 1e4)
;-> n: 12 start: 58 freq: (43 5057 4900)

Sembra che l'opzione del 40% di N^2 come prima scelta sia abbastanza equa.
Comunque anche l'opzione di prima scelta casuale rende il gioco interessante.

Nota: la strategia di scegliere sempre il valore massimo tra quelli possibili non è la migliore in tutte le posizioni. Bisogna anche considerare quali numeri si mettono a disposizione dell'avversario con la nostra mossa.

=============================================================================

