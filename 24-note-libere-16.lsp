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


----------------------------------------------------
Complemento relativo di due insiemi (set difference)
----------------------------------------------------

Avendo due insiemi A e B, il complemento di A rispetto a B o l'insieme differenza B meno A, è formato dai soli elementi di B che non appartengono ad A. Esso si indica solitamente come B\A oppure B-A.

  B\A = B-A = (x in B) and (x not in A)

Si noti che l'insieme differenza B-A è un sottoinsieme dell'insieme B.

In newLISP possiamo usare la funzione "difference".

***********************
>>>funzione DIFFERENCE
***********************
sintassi: (difference list-A list-B)
sintassi: (difference list-A list-B bool)

Nella prima sintassi, "difference" restituisce la differenza degli insiemi list-A e list-B. La lista risultante contiene solo elementi presenti in "list-A", ma non in "list-B". Tutti gli elementi nella lista risultante sono univoci, ma non è necessario che "list-A" e "list-B" contenga elementi univoci. Gli elementi nelle liste possono essere qualsiasi tipo di espressione Lisp.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1))
;-> (5 6 0)

Nella seconda sintassi, la "difference" funziona in modalità lista. "bool" specifica true o un'espressione diversa da nil.
Nella lista risultante, tutti gli elementi di "list-B" vengono eliminati  in "list-A", ma vengono lasciati i duplicati di altri elementi in "list-A".

In the second syntax, difference works in list mode. bool specifies true or an expression not evaluating to nil. In the resulting list, all elements of list-B are eliminated in list-A, but duplicates of other elements in list-A are left.

(difference '(2 5 6 0 3 5 0 2) '(1 2 3 3 2 1) true)
;-> (5 6 0 5 0)

Vedi anche le altre funzioni sugli insiemi "intersect", "unique" e "union".

Vediamo altri esempi:

(setq A '(1 1 3))
(setq B '(1 2 2 3 3 4 4))

(difference B A)
;-> (2 4)
(difference B A true)
;-> (2 2 4 4)

(setq A '(1 3))
(setq B '(1 2 3 4))
(difference B A)
;-> (2 4)
(difference B A true)
;-> (2 4)

Vediamo un caso non contemplato, la differenza tra due liste con corrispondenza 1:1 tra gli elementi:
Per esempio:

(setq A '(1 4 7))
(setq B '(1 1 3 3 4 5 6))

In questo caso il risultato voluto è (1 3 3 5 6), cioè i 2 elementi di A, 1 e 4, cancellano 2 elementi di B, 1 e 4.
In altre parole, vogliamo eliminare gli elementi in comune tra due liste, l'eliminazione degli elementi avviene con una corrispondenza 1:1.
La funzione "difference" non è in grado di fornire questo risultato:

(difference B A)
;-> (3 5 6)
(difference B A true)
;-> (3 3 5 6)

Scriviamo una funzione per fare questa operazione:

(define (remove-common lst-a lst-b)
  (local (a1 b1 f)
    ; lista copia della prima lista (lst-a)
    (setq a1 lst-a)
    ; lista copia della seconda lista (lst-b)
    (setq b1 lst-b)
    ; ciclo per ogni elemento della prima lista
    (dolist (el lst-a)
      ; se elemento corrente della prima lista esiste nella seconda lista
      (if (setq f (ref el b1))
        ; allora elimina l'elemento da entrambe le liste copia
        (begin (pop a1 (ref el a1)) (pop b1 f))
      )
    )
    ;(println a1) (println b1)
    (extend a1 b1)))

(remove-common B A)
;-> (1 3 3 5 6 7)
(remove-common A B)
;-> (7 1 3 3 5 6)

(remove-common '(1 1 2 3 4) '(1 2 3 5 3))
;-> (1 4 5 3)
(remove-common '(1 2 3 5 3) '(1 1 2 3 4))
;-> (5 3 1 4)
(remove-common '("M" "a" "g" "o" "o") '("o" "o" "o" "m" "g" "b"))
;-> ("M" "a" "o" "m" "b")

Comunque la funzione è lenta per liste con molti elementi:

(silent
  (setq a (rand 1e5 1e4))
  (setq b (rand 1e5 1e4)))

(time (remove-common a b))
;-> 653.583

(silent
  (setq a (rand 1e5 1e5))
  (setq b (rand 1e5 1e5)))

(time (remove-common a b))
;-> 35202.751

Vedere anche "Differenza simmetrica negli insiemi (set)" in "Note libere 11".


----------------
Serie di Kempner
----------------

La serie di Kempner è una variante della serie armonica, costruita omettendo tutti i termini il cui denominatore contiene la cifra
9 espressa in base decimale:

  Sum[n=1..inf](1/n) con n != 9

Mentre la serie armonica è divergente, la serie di Kempner è convergente.
Il valore di convergenza (corretto fino alla 20-esima cifra) è 22.92067661926415034816...
Intuitivamente questa serie converge perché gli interi molto grandi hanno un'alta probabilità di possedere un 9 (o qualunque cifra) che ne causano l'esclusione dalla sommatoria.
Generalizzando, omettendo qualunque cifra (0..9), si genera sempre una serie convergente.
Comunque la serie converge molto lentamente.

Usiamo un'implementazione ovvia per calcolare i valori della serie:

(define (kempner1 limit)
  (let (k 0)
    (for (n 1 limit)
      (if (not (find "9" (string n)))
        (inc k (div n))))
    k))

(kempner1 10)
;-> 2.817857142857143
(kempner1 100)
;-> 4.78184876508206
(kempner1 1000)
;-> 6.590720190283038
(kempner1 1e5)
;-> 9.692877792106202
(kempner1 1e6)
;-> 11.01565184987255
(kempner1 1e7)
;-> 12.20615372256586
(time (println (kempner1 1e8)))
;-> 13.2776059498581
;-> 46190.689

È stato osservato che dopo aver sommato 10^27 termini, il resto è ancora maggiore di 1.

Definiamo una funzione che accetta la cifra "x" da omettere:

(define (xharm x limit)
  (let ((sum 0) (d (string x)))
    (for (n 1 limit)
      (if (not (find d (string n)))
        (inc sum (div n))))
    sum))

(time (println (xharm 0 1e8)))
;-> 13.42865819123347
;-> 45896.513

(time (println (xharm 1 1e8)))
;-> 9.324480947154584
;-> 45998.49

(time (println (xharm 2 1e8)))
;-> 11.17880173453594
;-> 45766.789

(time (println (xharm 3 1e8)))
;-> 11.94518119626663
;-> 46122.134

(time (println (xharm 4 1e8)))
;-> 12.38086241813837
;-> 46344.576

(time (println (xharm 5 1e8)))
;-> 12.66946402654039
;-> 45954.239

(time (println (xharm 6 1e8)))
;-> 12.87885049539925
;-> 46016.512

(time (println (xharm 7 1e8)))
;-> 13.04019764280692
;-> 45639.016

(time (println (xharm 8 1e8)))
;-> 13.16993797273606
;-> 45425.952

(time (println (xharm 9 1e8)))
;-> 13.2776059498581
;-> 45488.271

(time (println (xharm 9 1e9)))
;-> 14.2419130103833
;-> 472970.052

Un algoritmo efficiente si trova nell'articolo di Schmelzer e Baillie, "Summing a Curious, Slowly Convergent Series" in American Mathematical Monthly, vol.115, n.6, June–July 2008, pp.525–540.
Non credo di essere in grado di implementarlo.

Teorema
Sia X una stringa di n cifre in base 10. Quindi se eliminiamo dalla serie armonica tutti i termini che contengono X, la serie risultante converge.

La seguente tabella riassume i valori a cui tendono le serie quando omettiamo la cifra "d":

  d  Somma     OEIS
  0  23.10344  A082839
  1  16.17696  A082830
  2  19.25735  A082831
  3  20.56987  A082832
  4  21.32746  A082833
  5  21.83460  A082834
  6  22.20559  A082835
  7  22.49347  A082836
  8  22.72636  A082837
  9  22.92067  A082838

In generale, la somma sum[n=1,inf](1/n) quando una particolare stringa di lunghezza k è esclusa dalla somma delle n è data  approssimativamente da 10^k*ln(10).


--------------
Dadi esplosivi
--------------

Scrivere una funzione che simula il lancio di un dado "esplosivo" (Exploding Die).
Questo dado funziona con le seguenti regole:
Il dado viene lanciato e si ottiene un valore.
Se questo valore è minore del valore massimo per quel tipo di dado (con 4 facce il massimo è 4, con 6 facce il massimo è 6, ecc.), allora ci fermiamo e il risultato del lancio è il valore ottenuto.
Se, invece, questo valore è il massimo per quel tipo di dado, allora il dado viene lanciato di nuovo e il valore ottenuto viene aggiunto al precedente (totale). Si continua a tirare il dado (e ad aggiungere il risultato al totale) finché non si ottiene più il numero massimo.
Il valore finale è comunque aggiunto al totale.

Che distribuzione hanno i valori di questo dado?
Quale è il valore atteso?

Funzione che simula il lancio di un dado esplosivo con n facce:

(define (explode-die n s)
  (let (val (+ (rand n) 1)) ;(println val)
    (++ s val)
    (if (= val n) (explode-die n s) s)))

(explode-die 4)
;-> 1
(explode-die 4)
;-> 7

Funzione che calcola le frequenze dei valori di un determinato numero di lanci di un dado esplosivo con n facce:

(define (distr n lanci)
  (local (freq val)
    (setq freq (array (* n 100) '(0)))
    (for (i 1 lanci)
      (setq val (explode-die n))
      (++ (freq val))
    )
    freq))

(distr 4 1e6)
;-> (0 249952 250009 249924 0 62248 62852 62282 0
;->  15653 15702 15636 0 4000 3908 3845 0
;->  1000 985 991 0 261 254 248 0
;->  77 62 62 0 11 9 21 0 2 2 2 0
;->  1 0 0 0 0 0 1 0 0 0 ...)

Nota: i valori multipli di n non compaiono mai (perchè sono da esplodere...)

(distr 6 1e6)
;-> (0 166222 166745 166832 167004 166596 0 27607 27776 27936 27783 27686 0
;->  4659 4677 4717 4632 4620 0 719 757 769 735 787 0
;->  109 120 125 135 121 0 14 24 23 25 26 0
;->  4 4 3 4 4 0 0 0 ...

Funzione che calcola il valore atteso di un dado esplosivo con n facce:

(define (atteso n lanci)
  (local (sum val)
    (setq sum 0)
    (for (i 1 lanci)
      (setq val (explode-die n))
      (++ sum val)
    )
    (div sum lanci)))

(atteso 4 1e7)
;-> 3.3336836

(for (n 2 10) (println n { } (atteso n 1e7)))
;-> 2 2.999395
;-> 3 3.0007173
;-> 4 3.3329194
;-> 5 3.7513152
;-> 6 4.1990122
;-> 7 4.6669425
;-> 8 5.1448579
;-> 9 5.6254875
;-> 10 6.1091211


---------------------------
Trasformare due dadi in uno
---------------------------

Abbiamo due dadi equi, d1 con A facce e d2 con B facce, dove A non è necessariamente uguale a B.
Le facce dei dadi sono tutte senza alcun numero.
Determinare i numeri delle facce di quei dadi per creare un "dado target" con N facce.
I numeri sulle facce dei dadi d1 e d2 devono essere tali che, se tirati e sommati i loro risultati, si simula un dado equo con N facce.
I numeri scritti sui dadi devono essere maggiori o uguali a zero (cioè sui dadi non possono esserci numeri negativi).
Supponiamo che A, B e N siano tutti numeri interi positivi e che N sia un divisore di A*B (condizione per ottenere un risultato valido).

Per esempio per creare un dado con 9 facce con 2 dadi da 6 facce possiamo usare la seguente numerazione:

      0 0 3 3 6 6
      -----------
  1 | 1 1 4 4 7 7
  1 | 1 1 4 4 7 7
  2 | 2 2 5 5 8 8
  2 | 2 2 5 5 8 8
  3 | 3 3 6 6 9 9
  3 | 3 3 6 6 9 9

Nota: Possono esistere più soluzioni per gli stessi dati iniziali (dipende dal metodo usato per risolvere il problema).

Esempi:

  d1 = 6, d2 = 6 N = 9
  d1 = (0 0 3 3 6 6)
  d2 = (1 1 2 2 3 3)

  d1 = 5, d2 = 12, N = 20
  d1 = (0 0 0 5 5 5 10 10 10 15 15 15)
  d2 = (1 2 3 4 5)

  d1 = 6, d2 = 4, N = 8
  d1  = (0 0 0 4 4 4)
  d2  = (1 2 3 4)

  d1 = 12, d2 = 12, N = 18
  d1 = (1 1 2 2 3 3 4 4 5 5 6 6)
  d2 = (0 0 0 0 6 6 6 6 12 12 12 12)

Funzione che genera le facce dei dadi A e B con numeri da 1 a N (target):

(define (single d1 d2 target)
  (let ((dieA '()) (dieB '()))
    ; crea le facce del primo dado
    (dolist (x (sequence 1 d1))
      (push (% (* x d2) target) dieA)
    )
    ; crea le facce del secondo dado
    (dolist (y (sequence 1 d2))
      (push (+ (% y (- target (apply max dieA))) 1) dieB)
    )
    (list (sort dieA) (sort dieB))))

Facciamo alcune prove:

(single 6 6 9)
;-> ((0 0 3 3 6 6) (1 1 2 2 3 3))

(single 5 12 20)
;-> ((0 4 8 12 16) (1 1 1 2 2 2 3 3 3 4 4 4))

(single 6 4 8)
;-> ((0 0 0 4 4 4) (1 2 3 4))

(single 12 12 18)
;-> ((0 0 0 0 6 6 6 6 12 12 12 12) (1 1 2 2 3 3 4 4 5 5 6 6))

Versione minima:

(setq s (fn (a b t , x y)
  (dolist (k (sequence 1 a)) (push (% (* k b) t) x))
  (dolist (k (sequence 1 b)) (push (+ (% k (- t (apply max x))) 1) y))
  (list (sort x) (sort y))))

(s 12 12 18)
;-> ((0 0 0 0 6 6 6 6 12 12 12 12) (1 1 2 2 3 3 4 4 5 5 6 6))

Scriviamo una funzione che verifica se il risultato della funzione "single" è corretto.
Possiamo usare due metodi: usare una simulazione oppure calcolare le probabilità esatte.

Funzione di verifica con simulazione:

; Roll a die with N sides with non-standard numeration
; Get a list with the values of each face
; Return an element of the list
(define (rand-lst lst) (lst (rand (length lst))))
(rand-lst '(0 4 8 12 16))
;-> 8

(define (verify d1 d2 target iter)
  (local (freq val)
    (setq freq (array (+ target 1) '(0)))
    (for (i 1 iter)
      (setq val (+ (rand-lst d1) (rand-lst d2)))
      (++ (freq val))
    )
    (dolist (f freq)
      (println $idx { } (div f iter)))))

(verify '(0 4 8 12 16) '(1 1 1 2 2 2 3 3 3 4 4 4) 20 1e7)
;->  0 0
;->  1 0.0499359
;->  2 0.0499348
;->  3 0.0500476
;->  4 0.0499919
;->  5 0.0499749
;->  6 0.0499699
;->  7 0.0499723
;->  8 0.0500833
;->  9 0.0499779
;-> 10 0.0500969
;-> 11 0.0499459
;-> 12 0.0499415
;-> 13 0.0500323
;-> 14 0.0500137
;-> 15 0.0500337
;-> 16 0.0500409
;-> 17 0.0501069
;-> 18 0.049893
;-> 19 0.0499482
;-> 20 0.0500585

(verify '(0 0 0 5 5 5 10 10 10 15 15 15) '(1 2 3 4 5) 20 1e7)
;->  1 0.0499492
;->  2 0.0499846
;->  3 0.0498709
;->  4 0.0500461
;->  5 0.0499026
;->  6 0.0500105
;->  7 0.0498982
;->  8 0.0500815
;->  9 0.0500338
;-> 10 0.0500018
;-> 11 0.0500612
;-> 12 0.0500846
;-> 13 0.0500281
;-> 14 0.0499065
;-> 15 0.049938
;-> 16 0.0500609
;-> 17 0.0499236
;-> 18 0.0501166
;-> 19 0.050058
;-> 20 0.0500433

Funzione di verifica che calcola le frequenze (probabilità) esatte di ogni numero:

(define (verify-mat d1 d2 target)
  (setq values '())
  ; costruisce la lista di tutti i valori possibili
  ; del lancio dei due dadi
  (dolist (x d1)
    (dolist (y d2)
      (push (+ x y) values)
    )
  )
  ; conta quante volte appaiono i numeri da 1 a N (target)
  (count (sequence 1 target) values))

Verifichiamo alcuni esempi:

(verify-mat '(0 4 8 12 16) '(1 1 1 2 2 2 3 3 3 4 4 4) 20)
;-> (3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3)

(verify-mat '(0 0 0 0 6 6 6 6 12 12 12 12) '(1 1 2 2 3 3 4 4 5 5 6 6) 18)
;-> (8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8)

(verify-mat '(0 0 0 5 5 5 10 10 10 15 15 15) '(1 2 3 4 5) 20)
;-> (3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3 3)

Vediamo cosa accade se N non è divisore esatto di A*B:

(single 4 4 10)
;-> ((2 4 6 8) (1 1 2 2))

Verifichiamo il risultato:

(verify '(2 4 6 8) '(1 1 2 2) 10 1e7)
;->  0 0
;->  1 0
;->  2 0
;->  3 0.1248611
;->  4 0.1250152
;->  5 0.1249099
;->  6 0.125066
;->  7 0.1251647
;->  8 0.124981
;->  9 0.1250377
;-> 10 0.1249644

(verify-mat '(2 4 6 8) '(1 1 2 2) 10)
;-> (0 0 2 2 2 2 2 2 2 2)

I numeri 1 e 2 non sono possibili, quindi il dado ottenuto non è equo.


-------------------------------
Numeri in ordine lessicografico
-------------------------------

Quando ordiniamo delle stringhe che contengono numeri, spesso il risultato ottenuto non è quello voluto (o migliore esteticamente).
Per esempio, suppponiamo di voler ordinare i nomi dei seguenti file: file1, file10, file99, file2:

(sort '(file1 file99 file10 file2))
;-> (file1 file10 file2 file99)

Invece l'ordinamento lessicografico genera: file1, file2, file10, file99.
Il problema è quello di convertire la parte numerica in un modo che il successivo ordinamento produca un ordine lessicografico.
Un metodo può essere quello di riempire il numero (a sinistra) con la cifra "0" in modo da raggiungere una lunghezza prefissata (padding left with 0).
Nel nostro esempio, possiamo utilizzare una lunghezza pari a 3 per "normalizzare" i numeri nel modo seguente:

  1  --> 001 --> file001
  2  --> 002 --> file002
  10 --> 010 --> file010
  99 --> 099 --> file099

In questo modo otteniamo un ordinamento lessicografico:

(sort '(file001 file099 file010 file002))
;-> (file001 file002 file010 file099)

Questo metodo ha lo svantaggio di dover fissare preventivamente la lunghezza della stringa finale (pad length) in modo da generare il numero corretto di zeri da anteporre al numero. Ogni volta che compare un nuovo numero potremmo essere costretti a cambiare la lunghezza di tutte le stringhe.
Per esempio, se aggiungiamo il file file2222, dobbiamo ricalcolare tutte le stringhe con una lunghezza pari a 4:

  1    --> 0001 --> file0001
  2    --> 0002 --> file0002
  10   --> 0010 --> file0010
  99   --> 0099 --> file0099
  2222 --> 2222 --> file2222

Quindi il metodo può essere utilizzato solo per numeri in un intervallo limitato (dobbiamo impostare prima la lunghezza).
Sarebbe auspicabile avere una codifica che possa essere utilizzata per tutti i numeri naturali, da 1 in poi.

(sort '(file1 file10 file2 file9))
;-> (file1 file10 file2 file9)

Vediamo una codifica che soddisfa il vincolo richiesto (vale per tutti i numeri da 1 in poi):

(define (encode n)
  (extend (dup "1" (length (string (length (string n))))) "0"
          (string (length (string n))) (string n)))

(map encode '(1 99 10 2))
;-> ("1011" "10299" "10210" "1012")

(sort (map list '(1 99 10 2) (map encode '(1 99 10 2))))
;-> ((1 "1011") (2 "1012") (10 "10210") (99 "10299"))

(sort (map list (map encode (sequence 1 20)) (sequence 1 20)))
;-> (("1011" 1) ("1012" 2) ("1013" 3) ("1014" 4) ("1015" 5) ("1016" 6)
;->  ("1017" 7) ("1018" 8) ("1019" 9) ("10210" 10) ("10211" 11) ("10212" 12)
;->  ("10213" 13) ("10214" 14) ("10215" 15) ("10216" 16) ("10217" 17)
;->  ("10218" 18) ("10219" 19) ("10220" 20))

Vediamo la funzione di decodifica:

(define (decode s)
  (slice s (+ (* 2 (find "0" s)) 1)))

(map decode '("1011" "10299" "10210" "1012"))
;-> ("1" "99" "10" "2")


----------------------------
Serie consecutiva di N Teste
----------------------------

Quanti lanci sono necessari per ottenere N Teste di fila?
Matematicamente il valore atteso dei lanci vale:

  E[f(N)] = 2*(2^N − 1) = 2^(N+1) − 2.

Verifichiamolo con una simulazione.

(define (teste n) (- (pow 2 (+ n 1)) 2))

(map teste (sequence 1 10))
;-> (2 6 14 30 62 126 254 510 1022 2046)

Per avere 10 teste di fila dobbiamo effettuare (in media) 2046 lanci.

Scriviamo una funzione di simulazione:

(define (head n prove)
  (local (lanci seq val)
    (setq lanci 0)
    (for (i 1 prove)
      (setq seq 0)
      (until (= seq n)
        (if (zero? (rand 2)) (++ seq) (setq seq 0))
        (++ lanci)
      )
    )
    (div lanci prove)))

(head 4 1e5)
;-> 30.03065

(time (for (n 1 10) (println n { } (head n 1e6))))
;-> 1 2.000496
;-> 2 5.998088
;-> 3 13.973106
;-> 4 30.012896
;-> 5 61.973598
;-> 6 125.952494
;-> 7 254.146778
;-> 8 508.807303
;-> 9 1022.059468
;-> 10 2045.985049
;-> 493618.754


--------------------
Monete e probabilità
--------------------

Abbiamo una moneta equa (Testa o Croce).
Quale evento è più probabile?
  1) Ottenere almeno 1 testa con 2 lanci
  2) Ottenere almeno 2 teste con 4 lanci
  3) Ottenere almeno 3 teste con 6 lanci

Poniamo: 0=Testa, 1=Croce

Lancio di una moneta:
(define (moneta) (rand 2))
(moneta)
;-> 1

Lancio di N monete:
(define (monete n) (rand 2 n))
(monete 10)
;-> (1 1 0 0 1 1 1 0 1 1)

Funzione di simulazione:

(define (teste iter)
  (local (s1 s2 s3)
    (setq s1 0 s2 0 s3 0)
    (for (i 1 iter)
      (if (ref 0 (monete 2)) (++ s1))
      (if (>= (length (ref-all 0 (monete 4))) 2) (++ s2))
      (if (>= (length (ref-all 0 (monete 6))) 3) (++ s3))
    )
    (list (div s1 iter) (div s2 iter) (div s3 iter))))

(time (println (teste 1e7)))
;-> (0.750132 0.6874232 0.6560362)
;-> 8782.184

L'evento 1) è quello più probabile.


-----------------------
Dado da N con dado da 6
-----------------------

Vediamo come simulare un dado da n facce con un dado da 6 facce.
Supponiamo che le facce dei dadi a 6 facce siano numerate 0,1,2,3,4,5 e che le facce dei dadi a n facce siano numerate 0,1,2,...,n−1.
Sia k l'intero tale che 6^(k−1) < n ≤ 6^k: k = ceil(log 6).
Lanciare tutti i k dadi.
Siano d0,d1,...,d(k−1) i numeri lanciati.
Dopo ogni lancio di k dadi, il numero in base-6 m = (d(k−1),d(k−2),...,d2,d1,d0) è un numero intero casuale compreso tra 0 e 6^k−1, con ogni numero intero ugualmente probabile.
Convertire il numero m (in base-6) nel numero m10 (in base-10).
Se (m10 < n) allora restituire m10, altrimenti tirare di nuovo i k dadi.
(Aggiungere 1 a m10 se i dadi sono numerati 1,...,6 e 1,...,n).

(define (roll n)
  (local (k m10 stop m6)
    (setq k (ceil (log n 6))) ; 6^(k-1) < n <= 6^k
    (setq m10 0)
    (setq stop nil)
    (until stop
      (setq m6 "")
      (for (i 1 k)
        (extend m6 (string (rand 6)))
      )
      (setq m10 (int m6 0 6))
      (if (< m10 n) (setq stop true))
    )
    (+ m10 1)))

Facciamo alcune prove:

(roll 10)
;-> 8

(setq freq (array 21 '(0)))
(for (i 1 1e6) (++ (freq (roll 20))))
freq
;-> (0 52364 53000 52816 52563 52788 52690 52752 52528 52459 52966
;->  52514 52527 52618 52831 52358 52320 52605 52537 52764)

(freq 1)
;-> 49953
(freq 20)
;-> 50115

(setq freq (array 41 '(0)))
(for (i 1 1e6) (++ (freq (roll 40))))
freq
;-> (0 24906 24909 24912 25112 25210 24892 25088 25059 25240 24930 24885
;->  24690 24883 24806 24958 24704 24976 25223 24910 24849 24994 24665
;->  25301 25145 25107 24925 24806 24940 25215 24857 25015 25102 25143
;->  25202 25309 25050 25033 25215 24981 24853)


---------------------------------
Codice Multitap (old Nokia Phone)
---------------------------------

Il codice multitap è il nome dato alla storica tecnica di scrittura degli SMS sui primi cellulari con tastiera a 10-12 tasti numerici.
Multitap sostituisce una lettera con cifre ripetute definite dal codice chiave corrispondente sulla tastiera di un telefono cellulare (questa modalità viene utilizzata durante la scrittura di SMS/Text).

La tabella di corrispondenza è la seguente:

  A 2     B 22
  C 222   D 3
  E 33    F 333
  G 4     H 44
  I 444   J 5
  K 55    L 555
  M 6     N 66
  O 666   P 7
  Q 77    R 777
  S 7777  T 8
  U 88    V 888
  W 9     X 99
  Y 999   Z 9999

Esempio: LISP diventa 555-444-7777-7

Configurazione standard nella tastiera dei telefoni:

  +-----+-----+-----+
  |  1  |  2  |  3  |
  |     | abc | cde |
  +-----+-----+-----+
  |  4  |  5  |  6  |
  | ghi | jkl | mno |
  +-----+-----+-----+
  |  7  |  8  |  9  |
  | pqrs| tuv | wxyz|
  +-----+-----+-----+
  |  *  |  0  |  #  |
  |     |     |     |
  +-----+-----+-----+

Questo standard (brevettato nel 1985) prende il nome di E.161 ed è stato creato dall'ITU Telecommunication Standardization Sector (ITU-T).
Definisce solo lettere dalla A alla Z, altri caratteri come cifre o distinzioni maiuscole/minuscole non sono normalizzate.

In genere lo spazio " " viene codificato con "00".

(setq ch-num
   '(("A" "2") ("B" "22") ("C" "222") ("D" "3") ("E" "33") ("F" "333")
     ("G" "4") ("H" "44") ("I" "444") ("J" "5") ("K" "55") ("L" "555")
     ("M" "6") ("N" "66") ("O" "666") ("P" "7") ("Q" "77") ("R" "777")
     ("S" "7777") ("T" "8") ("U" "88") ("V" "888") ("W" "9") ("X" "99")
     ("Y" "999") ("Z" "9999") (" " "00")))

(setq num-ch (map (fn(x) (list (x 1) (x 0))) ch-num))
;-> (("2" "A") ("22" "B") ("222" "C") ("3" "D") ("33" "E") ("333" "F")
;->  ("4" "G") ("44" "H") ("444" "I") ("5" "J") ("55" "K") ("555" "L")
;->  ("6" "M") ("66" "N") ("666" "O") ("7" "P") ("77" "Q") ("777" "R")
;->  ("7777" "S") ("8" "T") ("88" "U") ("888" "V") ("9" "W") ("99" "X")
;->  ("999" "Y") ("9999" "Z") ("00" " "))

Funzione di Decoder:

(define (mt-text nums)
  (let (lst (parse nums "-"))
    (join (map (fn(x) (lookup x num-ch)) lst))))

(mt-text "2-22-222-00-222-444-2-666")
;-> "ABC CIAO"

Funzione di Encoder:

(define (text-mt chars)
  (let (lst (explode chars))
    (chop (join (map (fn(x) (string (lookup x ch-num) "-")) lst)))))

(text-mt "ABC CIAO")
;-> "2-22-222-00-222-444-2-666"

(text-mt "NEWLISP")
;-> "66-33-9-555-444-7777-7"
(mt-text "66-33-9-555-444-7777-7")
;-> "NEWLISP"


---------------------------------
Forum: Naming for global symbols?
---------------------------------

cormullion:
-----------
If there is some data that I want to refer to throughout a script - such as the path to a database - I store it in a global symbol/variable. In the past I've sometimes used the (CommonLisp?) convention of enclosing with asterisks - eg *db* - which doesn't look that great:

(set '*db* {/Users/me/misc/db})

but it's good to have some visual reminder that the symbol is global, and it's harder to type by accident.

Does everyone else use this?
What other conventions are used for marking variable names as global?
I'm not a fan of underscores... :_)
Is an initial capital enough? Or is it better to avoid them altogether somehow?

rickyboy:
---------
I also use the asterisk enclosing in my global names. My reasons:

1. This is the convention in CL, and so having the same convention in newlisp makes it easier for me to go back and forth between newlisp and CL, and

2. Putting asterisks around something was the Usenet and Internet way of applying *emphasis* to some text in flat ASCII.

So the convention is well ingrained in me. :-)

Jeff:
-----
The other thing you can do is maintain state more safely in a context. Call it 'global or even *global* ;)

I use asterisks for globals in any context, though.

m i c h a e l:
--------------
What about the $ (dollar sign)? newLISP uses it for its global variables ($n and $idx, for example).

> (set (global '$db) {/Users/me/misc/db})
"/Users/me/misc/db"
> (context 'C)
C
C> (define (C:print) (println $db))
(lambda () (println $db))
C> (context MAIN)
> (C:print)
/Users/me/misc/db
"/Users/me/misc/db"
> _

Don't forget to make your globals global ;-)

Lutz:
-----
Just put all globals in its own context 'global' or 'gl' or even shortening to capital 'G' for those who hate typing (like myself ;-))

(set 'G:database "/usr/home/joe/data/database.lsp")
(set 'G:n-config 12345)

A context qualified variable is global by definition, because contexts names are global. It also keeps all globals together in one place for inspection or serializing with

(save "appglobals.lsp" 'G)


---------------------------------------------------
Funzione che accetta simboli o una lista di simboli
---------------------------------------------------

Scriviamo una funzione che calcola il quadrato di tutti i suoi argomenti.
Il problema è che gli argomenti si possono presentare in 3 modi:
1) un singolo atomo (es. 3 o a)
2) più di un atomo (es. 2 3 o a b)
3) una lista (es. (2 3) o (a b)

Vediamo cosa contiene la variabile (args) in base ad ogni parametro.

(define (test) (println "(args) = "(args)) (println "(args 0) = " (args 0)))

Un atomo:
(test 3)
;-> (args) = (3)
;-> (args 0) = 3

Più atomi:
(test 2 3)
;-> (args) = (2 3)
;-> (args 0) = 2

Una lista:
(test '(2 3))
;-> (args) = ((2 3))
;-> (args 0) = (2 3)

La nostra funzione dovrà utilizzare il procedimento corretto (calcolo del quadrato) in base al tipo di parametro.

(define (square)
  ; se abbiamo un atomo o una lista
  (if (= (length (args)) 1)
      ; se abbiamo un atomo
      (if (atom? (args 0))
          (mul (args 0) (args 0))
          ; se abbiamo una lista
          (map mul (args 0) (args 0))
      )
      ; altrimenti abbiamo più di un atomo
      (map mul (args) (args))))

Facciamo alcune prove:

(square 2)
;-> 4
(square 2 3)
;-> (4 9)
(square '(2 3))
;-> (4 9)
(square '(2))
;-> (4)

(setq a 2 b 3)
(setq lst '(1 2 3))
(square a)
;-> 4
(square a b b a)
;-> (4 9 9 4)
(square lst)
;-> (1 4 9)
(square (list a b))
;-> (4 9)

Quindi abbiamo una funzione che si comporta in modo differente in base al tipo di parametro/i passato.


-------------------
Forum: set question
-------------------

newdep:
-------
Lutz, this may sound like a very very very very stupid question ..

(set 'here '(there where ))
;-> (there where)

Are there and where now evaluated and set to nil inside newlisp and known as symbols?

PS: assuming you just started the newlisp console

Lutz:
-----
yes, they exist now as symbols in the MAIN namespace and contain 'nil'.
But they have not been evaluated, because they are inside a quoted list.

They get put into the symbol table when parsing the source: "(set 'here '(there where ))".

After parsing the source and translating it into an internal s-expression format, the expression gets evaluated, assigning the list '(there where ) to the symbol 'here.

newdep:
-------
..oke thank you for the clear answer...

Has this always been the fact? because im now wondering why I got away with some list content in my programs while not using contexts or OOP.

I was always under the impression that anything inside an explicit list was static until evaluated with .i.e. 'eval..until then the data inside a list was abstract and unknown to the main-context when using 'set.
I mean only for lists!

PS: like this, i still think its odd.. ->

newLISP v.9.2.7 on Linux, execute 'newlisp -h' for more info.

(set 'X '(i am a new list))
;-> (i am a new list)
(set 'i:am "a new list")
;-> ERR: context expected in function set : i

Lutz:
-----
yes, it has always been this way.
After the first statement 'i' exists as a normal symbol variable containing 'nil'.
In the next statement then 'i' is expected to be either a context or contain a context.
Only the the 'context' function can promote a normal variable to a context symbol:

newLISP v.9.2.0 on OSX, execute 'newlisp -h' for more info.

(set 'X '(i am a new list))
;-> (i am a new list)
(set 'i:am "a new list")
;-> ;-> ERR: context expected in function set : i

(context 'i "am" "a new list")
;-> "a new list"
i:am
;-> "a new list"


----------------------------
Lista con indici predefiniti
----------------------------

In newLISP la struttura lista ha indici che vanno da 0 a (n-1), dove n è la lunghezza della lista.
In Pascal e in Fortran possiamo definire un vettore con indici predefiniti, ad esempio:

var c : array[ -7 .. 7] of boolean;

In questo caso abbiamo un vettore da 15 elementi con indici da -7 a 7 (compreso l'indice 0).

Per simulare una lista con indici diversi da 0..(n-1) possiamo utilizzare il seguente metodo.

Supponiamo di voler simulare una lista con indici che vanno da -5 a 5.
Creiamo una lista con una lunghezza predefinita di 11 elementi (5 - (-5) + 1):

(setq lista (dup 0 11))
;-> (0 0 0 0 0 0 0 0 0 0 0)

Adesso scriviamo una funzione che prende una lista e i nuovi indici idx1, idx2 (iniziale e finale) e crea una lista associativa del tipo:

  (idx1 0) (idx1+1 1) (idx1+2 2) ... (idx2 n-1))

(define (new-index lst idx1 idx2)
  ;(println (+ (- idx2 idx1) 1) { } (length lst))
  (if (!= (+ (- idx2 idx1) 1) (length lst))
      nil ; error: il numero di elementi è diverso
      ; else crea la lista associativa tra nuovi indici e indici originali
      (map list (sequence idx1 idx2) (sequence 0 (abs (- idx2 idx1))))))

Creiamo la lista di associazione tra gli indici:

(setq lista-idx (new-index lista -5 5))
;-> ((-5 0) (-4 1) (-3 2) (-2 3) (-1 4) (0 5) (1 6) (2 7) (3 8) (4 9) (5 10))

Adesso dobbiamo scrivere le funzioni per impostare e leggere i valori dalla lista con i nuovi indici:

(define (set-value lst lst-idx idx value)
  ;(println (lookup idx lst-idx))
  (setf ((eval lst) (lookup idx lst-idx)) value))

Nota: Alla funzione "set-value" deve essere passata la lista per riferimento (quotata).

(define (get-value lst lst-idx idx)
  (lst (lookup idx lst-idx)))

(set-value 'lista lista-idx -5 2)
;-> 2
lista
;-> (2 0 0 0 0 0 0 0 0 0 0)

(get-value lista lista-idx -5)
;-> 2

Aggiorniamo tutti gli elementi con un ciclo "for":

(for (i -5 5) (set-value 'lista lista-idx i i))
lista
;-> (-5 -4 -3 -2 -1 0 1 2 3 4 5)

Un altro metodo potrebbe essere quello di utilizzare delle macro, ma questo mi sembra semplice ed immediato.


----------------
Battaglia navale
----------------

Battaglia Navale è un gioco per due persone che utilizza due griglie rettangolari di 10 per 10.

   A B C D E F G H I J        A B C D E F G H I J
 1 . . . . . . . . . .      1 . . . . . . . . . .
 2 . . . . . . . . . .      2 . . . . . . . . . .
 3 . . . . . . . . . .      3 . . . . . . . . . .
 4 . . . . . . . . . .      4 . . . . . . . . . .
 5 . . . . . . . . . .      5 . . . . . . . . . .
 6 . . . . . . . . . .      6 . . . . . . . . . .
 7 . . . . . . . . . .      7 . . . . . . . . . .
 8 . . . . . . . . . .      8 . . . . . . . . . .
 9 . . . . . . . . . .      9 . . . . . . . . . .
10 . . . . . . . . . .     10 . . . . . . . . . .

Ogni giocatore posiziona un certo numero di navi nella propria griglia senza farle vedere al proprio avversario.
Il numero di navi da posizionare viene deciso dai giocatori prima di iniziare il gioco.
Le navi hanno le seguenti dimensioni:

  Portaerei: con 5 caselle
  Corazzata: con 4 caselle
  Sottomarino: con 3 caselle
  Corvetta: 2 caselle
  Lancia: 1 casella

Per esempio, una posizione di partenza potrebbe essere la seguente:

  1 Nave da 5 caselle
  1 Nave da 4 caselle
  2 Navi da 3 caselle
  3 Navi da 2 caselle
  4 Navi da 1 casella

A questo punto ogni giocatore, a turno, spara un colpo in una casella della griglia dell'avversario.
Se la casella contiene una nave, allora l'avversario deve rispondere: "colpito".
Se la casella contiene l'ultima casella "viva" di una nave, allora l'avversario deve rispondere: "colpito e affondato".
Se la casella è vuota, allora l'avversario deve rispondere: "acqua".

Il vincitore è colui che affonda per primo le navi dell'avversario.

Rappresentiamo queste informazioni in due griglie per ogni giocatore.

  Griglia 1                Griglia 2
  ---------                ---------
    0 1 2 3 4 5 6 7 8 9      0 1 2 3 4 5 6 7 8 9
  0 . . . . . . . . . .    0 . . . . + . . . . .
  1 . . . . . . . . . .    1 . + . . . . . . . .
  2 . . . . . . . 1 . .    2 . + . . . . . . . .
  3 . 4 4 4 x . . 3 3 3    3 . . . . . . . . . .
  4 . 2 . 1 . . . . . .    4 . . . . . . . . . .
  5 . 2 5 . . . . . . .    5 . . . . . . . . . .
  6 . . 5 . . . . . . .    6 . . . - . . . . . .
  7 . . x . . . . . . .    7 . . . . + . - . . .
  8 . . 5 . . . . . . .    8 . . . - . . . . . .
  9 . . 5 . . . . . . .    9 . . . . . . . . . .

Nella griglia 1 viene rappresentata la posizione delle proprie navi.
Valore 0 = casella vuota --> Segno "." significa che la casella è vuota.
Valore -1 = nave colpita --> Segno "x" significa che quella nave è stata colpita.
Valore = (1..5) = nave --> Segno "numero" significa la posizione delle navi (es. 3 3 3 rappresenta una nave da 3).

Nella griglia 2 viene riportata il risultato degli spari del giocatore:
Valore 0 = casella vuota --> Segno "." significa che non ha sparato su quella casella.
Valore 1 = colpo a vuoto --> Segno "+" significa che ha sparato sulla casella e colpito una nave.
Valore 2 = colpo a segno --> Segno "-" significa che ha sparato sulla casella senza colpire nulla.

Funzione che stampa le griglie di un giocatore:

(define (print-grid grid1 grid2)
  (local (row col)
    (setq row (length grid1))
    (setq col (length (first grid1)))
    (print "  " (join (map string (sequence 0 (- row 1))) " "))
    (println "     " (join (map string (sequence 0 (- row 1))) " "))
    (for (i 0 (- row 1))
      (print i { })
      (for (j 0 (- col 1))
        (cond ((= (grid1 i j) 0) (print ". ")) ; libera
              ((= (grid1 i j) -1) (print "x ")) ; nave colpita
              (true (print (string (grid1 i j) " "))) ; nave
        )
      )
      (print {  } i { })
      (for (j 0 (- col 1))
        (cond ((= (grid2 i j) 0) (print ". ")) ; libera
              ((= (grid2 i j) 1) (print "- ")) ; colpo a vuoto
              ((= (grid2 i j) 2) (print "+ ")) ; colpo a segno
              (true (println "ERROR"))
        )
      )
      (println))))

Funzione che riempie casualmente una griglia con una lista di navi:

(define (navi-random grid lst)
  (dolist (el lst)
    ; dir = 0 -> nave orizzontale
    ; dir = 1 -> nave verticale
    (setq dir (rand 2))
    (setq ok nil)
    ; posiziona la nave corrente
    (until ok
      (setq row (rand (- 11 el)))
      (setq col (rand (- 11 el)))
      (setq stop nil)
      (cond ((= dir 0)
              (for (i 0 (- el 1) 1 stop)
                (if (!= (grid row (+ col i)) 0) (setq stop true))))
            ((= dir 1)
              (for (i 0 (- el 1) 1 stop)
                (if (!= (grid (+ row i) col) 0) (setq stop true))))
      )
      (if (not stop)
        (begin
          (setq ok true)
          (cond ((= dir 0)
                  (for (i 0 (- el 1) 1 stop)
                    (setf (grid row (+ col i)) el)))
                ((= dir 1)
                  (for (i 0 (- el 1) 1 stop)
                    (setf (grid (+ row i) col) el)))
          )))
    )
    grid))

(setq navi '(4 3 3 2 2 2 1 1 1 1))

Funzione di sparo per il giocatore 1:

(define (boom1)
  (local (row col r c value out)
    ; input riga
    (setq row nil)
    (until row
      (print "riga (0..9): ")
      (setq r (int (read-line)))
      (if (or (< r 0) (> r 9))
          (println "Errore: riga inesistente")
          (setq row true))
    )
    ; input colonna
    (setq col nil)
    (until col
      (print "colonna (0..9): ")
      (setq c (int (read-line)))
      (if (or (< c 0) (> c 9))
          (println "Errore: riga inesistente")
          (setq col true))
    )
    ; sparo
    (setq value (g2 r c))
    (cond ((= value 0) ; casella vuota (colpo a vuoto)
            (setf (g11 r c) 1) ; "-"
            (setq out "Acqua"))
          ((= value -1) ; nave già colpita
            (setf (g2 r c) -1)  ; "x"
            (setf (g11 r c) 2)  ; "+"
            (setq out "Colpita (2 volte)"))
          ((> value 0) ; nave colpita con questo tiro
            (setf (g2 r c) -1)  ; "x"
            (setf (g11 r c) 2)  ; "+"
            (setq out "Colpita!")
            (if (affondata? r c value g2) (setq out "Colpita e affondata!")))
    )
    out))

Funzione di sparo per il giocatore 2:

(define (boom2)
  (local (row col r c out value)
    ; input riga
    (setq row nil)
    (until row
      (print "riga (0..9): ")
      (setq r (int (read-line)))
      (if (or (< r 0) (> r 9))
          (println "Errore: riga inesistente")
          (setq row true))
    )
    ; input colonna
    (setq col nil)
    (until col
      (print "colonna (0..9): ")
      (setq c (int (read-line)))
      (if (or (< c 0) (> c 9))
          (println "Errore: riga inesistente")
          (setq col true))
    )
    ; sparo
    (setq value (g1 r c))
    (cond ((= value 0) ; casella vuota (colpo a vuoto)
            (setf (g22 r c) 1) ;"-"
            (setq out "Acqua"))
          ((= value -1) ; nave già colpita
            (setf (g1 r c) -1)  ;"x"
            (setf (g22 r c) 2)  ;"+"
            (setq out "Colpita (2 volte)"))
          ((> value 0) ; nave colpita con questo tiro
            (setq value (g1 r c))
            (setf (g1 r c) -1)  ;"x"
            (setf (g22 r c) 2)  ;"+"
            (setq out "Colpita!")
            (if (affondata? r c  value g1) (setq out "Colpita e affondata!")))
    )
    out))

Funzione che verifica se una nave colpita è affondata:
(controlla se una cella ha un valore uguale up, down, left or right)

(define (affondata? row col value grid)
  (local (out righe colonne)
    (setq out true)
    (setq righe (length grid))
    (setq colonne (length (grid 0)))
    (cond ((= value 1) (setq out true))
          (true
    # Check the value to the left of the current position (if not in the leftmost column)
            (if (and (> col 0) (= (grid row (- col 1)) value)) (setq out nil))
    # Check the value to the right of the current position (if not in the rightmost column)
            (if (and (< col (- colonne 1)) (= (grid row (+ col 1)) value)) (setq out nil))
    # Check the value above the current position (if not in the top row)
            (if (and (> row 0) (= (grid (- row 1) col) value)) (setq out nil))
    # Check the value below the current position (if not in the bottom row)
            (if (and (< row (- righe 1)) (= (grid (+ row 1) col) value)) (setq out nil)))
    )
    out))

Simulazione di una partita:

Creazione delle griglie:
(setq g1 (explode (dup 0 100) 10))
(setq g2 (explode (dup 0 100) 10))
(setq g11 (explode (dup 0 100) 10))
(setq g22 (explode (dup 0 100) 10))

Posizionamento casuale delle navi nelle griglie:
(setq g1 (navi-random g1 '(5 4 3 2 1 1)))
(setq g2 (navi-random g2 '(5 4 3 2 1 1)))

Stampa griglie:
(print-grid g1 g11)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . 5 . . . . . .   0 . . . . . . . . . .
;-> 1 . . . 5 . . 1 . . .   1 . . . . . . . . . .
;-> 2 . 3 . 5 . . . . . .   2 . . . . . . . . . .
;-> 3 . 3 . 5 . . . 2 2 .   3 . . . . . . . . . .
;-> 4 . 3 . 5 . . . . . .   4 . . . . . . . . . .
;-> 5 . . . . 4 4 4 4 . .   5 . . . . . . . . . .
;-> 6 . . . . . . . . . .   6 . . . . . . . . . .
;-> 7 . . . . . . . . . .   7 . . . . . . . . . .
;-> 8 . . . . . . . . . .   8 . . . . . . . . . .
;-> 9 . . . . . . . 1 . .   9 . . . . . . . . . .

(print-grid g2 g22)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . . 5 5 5 5 5 .   0 . . . . . . . . . .
;-> 1 . . . . . . 4 . . .   1 . . . . . . . . . .
;-> 2 . . . . . . 4 . . .   2 . . . . . . . . . .
;-> 3 2 2 . . . . 4 . . .   3 . . . . . . . . . .
;-> 4 . . . . . . 4 . . .   4 . . . . . . . . . .
;-> 5 . . . . . . . . . .   5 . . . . . . . . . .
;-> 6 . 1 . . . . . . . .   6 . . . . . . . . . .
;-> 7 . . . . . 3 3 3 . .   7 . . . . . . . . . .
;-> 8 . . . . . 1 . . . .   8 . . . . . . . . . .
;-> 9 . . . . . . . . . .   9 . . . . . . . . . .

Spara 1:
(boom1)
;-> riga (0..9): 6
;-> colonna (0..9): 1
;-> "Colpita e affondata!"

Stampa griglie:
(print-grid g1 g11)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . 5 . . . . . .   0 . . . . . . . . . .
;-> 1 . . . 5 . . 1 . . .   1 . . . . . . . . . .
;-> 2 . 3 . 5 . . . . . .   2 . . . . . . . . . .
;-> 3 . 3 . 5 . . . 2 2 .   3 . . . . . . . . . .
;-> 4 . 3 . 5 . . . . . .   4 . . . . . . . . . .
;-> 5 . . . . 4 4 4 4 . .   5 . . . . . . . . . .
;-> 6 . . . . . . . . . .   6 . + . . . . . . . .
;-> 7 . . . . . . . . . .   7 . . . . . . . . . .
;-> 8 . . . . . . . . . .   8 . . . . . . . . . .
;-> 9 . . . . . . . 1 . .   9 . . . . . . . . . .

(print-grid g2 g22)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . . 5 5 5 5 5 .   0 . . . . . . . . . .
;-> 1 . . . . . . 4 . . .   1 . . . . . . . . . .
;-> 2 . . . . . . 4 . . .   2 . . . . . . . . . .
;-> 3 2 2 . . . . 4 . . .   3 . . . . . . . . . .
;-> 4 . . . . . . 4 . . .   4 . . . . . . . . . .
;-> 5 . . . . . . . . . .   5 . . . . . . . . . .
;-> 6 . x . . . . . . . .   6 . . . . . . . . . .
;-> 7 . . . . . 3 3 3 . .   7 . . . . . . . . . .
;-> 8 . . . . . 1 . . . .   8 . . . . . . . . . .
;-> 9 . . . . . . . . . .   9 . . . . . . . . . .

Spara 2:
(boom2)
;-> riga (0..9): 8
;-> colonna (0..9): 0
;-> "Acqua"

Stampa griglie:
(print-grid g2 g22)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . . 5 5 5 5 5 .   0 . . . . . . . . . .
;-> 1 . . . . . . 4 . . .   1 . . . . . . . . . .
;-> 2 . . . . . . 4 . . .   2 . . . . . . . . . .
;-> 3 2 2 . . . . 4 . . .   3 . . . . . . . . . .
;-> 4 . . . . . . 4 . . .   4 . . . . . . . . . .
;-> 5 . . . . . . . . . .   5 . . . . . . . . . .
;-> 6 . x . . . . . . . .   6 . . . . . . . . . .
;-> 7 . . . . . 3 3 3 . .   7 . . . . . . . . . .
;-> 8 . . . . . 1 . . . .   8 - . . . . . . . . .
;-> 9 . . . . . . . . . .   9 . . . . . . . . . .

(print-grid g1 g11)
;->   0 1 2 3 4 5 6 7 8 9     0 1 2 3 4 5 6 7 8 9
;-> 0 . . . 5 . . . . . .   0 . . . . . . . . . .
;-> 1 . . . 5 . . 1 . . .   1 . . . . . . . . . .
;-> 2 . 3 . 5 . . . . . .   2 . . . . . . . . . .
;-> 3 . 3 . 5 . . . 2 2 .   3 . . . . . . . . . .
;-> 4 . 3 . 5 . . . . . .   4 . . . . . . . . . .
;-> 5 . . . . 4 4 4 4 . .   5 . . . . . . . . . .
;-> 6 . . . . . . . . . .   6 . + . . . . . . . .
;-> 7 . . . . . . . . . .   7 . . . . . . . . . .
;-> 8 . . . . . . . . . .   8 . . . . . . . . . .
;-> 9 . . . . . . . 1 . .   9 . . . . . . . . . .

...

Spara 1:
(boom1)

Stampa griglie:
(print-grid g1 g11)
(print-grid g2 g22)

Spara 2:
(boom2)

Stampa griglie:
(print-grid g2 g22)
(print-grid g1 g11)


---
Nim
---

Nim è un gioco di strategia in cui due giocatori, a turno, rimuovono ("nimming") oggetti da righe distinte.
Ad ogni turno, un giocatore deve rimuovere almeno un oggetto e può rimuovere qualsiasi numero di oggetti purché provengano tutti dalla stessa riga.
Il numero di righe e di oggetti in ogni riga viene concordato tra i giocatori all'inizio del gioco.
Una disposizione tipica è la seguente (3 righe da 3, 4 e 5 oggetti):

  Riga 1     | | |

  Riga 3    | | | |

  Riga 3   | | | | |

Il giocatore che prende l'ultimo oggetto vince (nella versione "misère" del Nim il giocatore che prende l'ultimo oggetto perde).

Strategia ottimale:
La strategia vincente è terminare ogni mossa con una somma-nim pari a 0.
Questo è sempre possibile se la somma-nim è diversa da zero prima della mossa.
Se la somma-nim è zero, il giocatore che deve muovere perderà sicuramente se l'avversario giocherà in maniera ottimale.

La somma-nim viene calcolata sommando il numero di oggetti in ogni riga in base 2.
I valori binari vanno sommati senza riporto.
Per esempio, calcoliamo la somma-nim per la posizione raffigurata sopra:

          Binario   Decimale
  Riga 1  011       3
  Riga 2  100       4
  Riga 3  101       5
          ---
          010 --> 2

Una procedura equivalente, che spesso è più facile da eseguire mentalmente, consiste nell'esprimere il numero di oggetti nelle righe come somme di potenze distinte di 2, cancellare le coppie di potenze uguali e quindi aggiungere ciò che resta:

  Riga 1  3 = 0 + 2 + 1 =    2  1
  Riga 2  4 = 4 + 0 + 0 = 4
  Riga 3  5 = 4 + 0 + 1 = 4     1
          --------------------------------------------------------------------
                             2    Cosa rimane dopo aver cancellato gli 1 e i 4

La somma-nim è equivalente allo xor di tutte le righe (es. 3 xor 4 xor 5).

Simulazione del gioco Nim standard (vince chi prende l'ultimo oggetto).

Rappresentiamo le righe con una lista:

(setq righe '(3 4 5))

Valutazione della posizione (somma-nim)
Per valutare la posizione dobbiamo calcolare la somma-nim delle righe:

 valore_posizione = xor(righe)

Con i valori dell'esempio dobbiamo calcolare 3 xor 4 xor 5.

(setq vp (apply ^ righe))
;-> 2

Se il valore di vp è uguale a 0, allora siamo in una posizione perdente.
Se il valore di vp è diverso da 0, allora siamo in una posizione vincente.
Da una posizione vincente, la mossa ottimale è quella che genera un vp pari a 0 per l'avversario.

Nell'esempio vp = 2 e siamo in una posizione vincente.
La mossa ottimale è quella (quelle) che rendono vp = 0 per l'avversario.
Ad esempio togliendo 2 oggetti dalla prima riga otteniamo:

(setq righe '(1 4 5))
(setq vp (apply ^ righe))
;-> 0

Adesso il nostro avversario si trova in una posizione (vp = 0) in cui qualunque mossa rende vp diverso da 0.
In questo modo possiamo seguire questa strategia vincente fino alla fine.

Invece di scrivere un programma che gestisce completamente una partita a Nim tra due giocatori, scriviamo alcune funzioni con cui poter simulare le singole fasi di una partita.
In questo modo possiamo interagire più liberamente con il funzionamento del gioco.

Posizione iniziale:
(setq *pos* '(3 4 5))

Funzione che stampa una posizione di Nim:

(define (print-nim position ch)
  (dolist (p position)
    (println { } (+ $idx 1) { } (dup (string " " ch " ") p))))

(print-nim *pos* "|")
;-> 1  |  |  |
;-> 2  |  |  |  |
;-> 3  |  |  |  |  |

(define (make-move posizione)
  (local (righe r oggetti o)
    (setq righe (length posizione))
    ; input riga
    (setq row nil)
    (until row
      (print "Riga (1.." righe "): ")
      (setq r (int (read-line)))
      (if (or (< r 1) (> r righe) (zero? (posizione r)))
          (println "Errore: riga inesistente")
          ;else
          (set 'r (- r 1) 'row true))
    )
    ; input oggetti
    (setq obj nil)
    (setq oggetti (posizione r))
    (until obj
      (print "Oggetti (1.." oggetti "): ")
      (setq o (int (read-line)))
      (if (or (< o 1) (> o oggetti))
          (println "Errore: oggetti inesistenti")
          ;else
          (setq obj true))
    )
    (-- (posizione r) o)
    posizione))

Questa è l'unica funzione che modifica la variabile globale "*pos*".

(setq *pos* (make-move *pos*))
;-> riga (1..3): 2
;-> Oggetti (1..4): 4
;-> (3 0 5)

Funzione che valuta una posizione:

(define (eval-position posizione) (apply ^ posizione))

Funzione che genera tutte le mosse possibili da una posizione data:
(genera una lista di posizioni)

(define (possible-moves posizione)
  (local (out base)
    (setq out '())
    (dolist (p posizione)
      (setq base posizione)
      (for (i 1 p)
        (setf (base $idx) (- p i))
        (push base out -1)
      )
    )
    out))

(possible-moves '(3 4 5))
;-> ((2 4 5) (1 4 5) (0 4 5)
;->  (3 3 5) (3 2 5) (3 1 5) (3 0 5)
;->  (3 4 4) (3 4 3) (3 4 2) (3 4 1) (3 4 0))

Funzione che valuta una lista di posizioni e restituisce una lista di posizioni valutate con elementi del tipo:

  (valore_posizione [numero] posizione [lista])

(define (evaluate-positions posizioni)
  (map list (map eval-position posizioni) posizioni))

(evaluate-positions (possible-moves '(3 4 5)))
;-> ((3 (2 4 5)) (0 (1 4 5)) (1 (0 4 5))
;->  (5 (3 3 5)) (4 (3 2 5)) (7 (3 1 5)) (6 (3 0 5))
;->  (3 (3 4 4)) (4 (3 4 3)) (5 (3 4 2)) (6 (3 4 1)) (7 (3 4 0)))

Per trovare (se esiste) la mossa ottimale cerchiamo il valore 0 nella lista delle posizioni valutate:

(setq best-move (lookup 0 (evaluate-positions (possible-moves '(3 4 5)))))
;-> (1 4 5)

(print-nim '(1 4 5) "|")
;-> 1  |
;-> 2  |  |  |  |
;-> 3  |  |  |  |  |

Notiamo che dalla posizione (1 4 5) non esiste una mossa ottimale:

(evaluate-positions (possible-moves '(1 4 5)))
;-> ((1 (0 4 5))
;->  (7 (1 3 5)) (6 (1 2 5)) (5 (1 1 5)) (4 (1 0 5))
;->  (1 (1 4 4)) (6 (1 4 3)) (7 (1 4 2)) (4 (1 4 1)) (5 (1 4 0)))

Con queste funzioni possiamo analizzare completamente una partita a Nim.

Nota:
nella versione "misère", la strategia di Nim è diversa solo quando la normale mossa di gioco lascerebbe solo righe con un oggetto soltanto.
In tal caso, la mossa corretta è lasciare un numero dispari di righe che hanno un solo oggetto (nel gioco normale, la mossa corretta sarebbe lasciare un numero pari di tali righe).


----------------------
Insiemi (set) sum-free
----------------------

Un insieme (set) viene chiamato "sum-free" se non ci sono due elementi (non necessariamente distinti) che sommati insieme fanno parte dell'insieme stesso.
Ad esempio, (1 5 7) è "sum-free", perché tutti i membri sono dispari e due numeri dispari quando sommati insieme sono sempre pari.
Inoltre se un insieme contiene 0, allora non è "sum-free", poichè 0 + 0 = 0.
Anche (2 4 9 13) non è "sum-free", poiché le somme 2 + 2 = 4 o 4 + 9 = 13 appartengono all'insieme.

Esempi:

  Sum-free:        Non sum-free:
    ()               (0)
    (4)              (1 4 5 7)
    (1 5 7)          (3 0)
    (16 1 4 9)       (16 1 4 8)

Scriviamo una funzione che verifica se un insieme è "sum-free".

Primo metodo (intersezione tra il prodotto cartesiano e la lista):

(define (sum-free? lst)
  (let (out '())
    (dolist (el1 lst)
      (dolist (el2 lst)
        (push (+ el1 el2) out)))
    (null? (intersect lst out))))

(sum-free? '())
;-> true
(sum-free? '(4))
;-> true
(sum-free? '(1 5 7))
;-> true
(sum-free? '(16 1 4 9))
;-> true

(sum-free? '(0))
;-> nil
(sum-free? '(1 4 5 7))
;-> nil
(sum-free? '(3 0))
;-> nil
(sum-free? '(16 1 4 8))
;-> nil

Secondo metodo (prodotto cartesiano con verifica per ogni elemento):

(define (sum-free lst)
  (let (all lst)
    (setq stop nil)
    (dolist (el1 lst stop)
      (dolist (el2 lst stop)
        ; verifica della presenza della somma corrente nella lista
        (if (find (+ el1 el2) lst)
            (setq stop true))))
    (not stop)))

(sum-free '())
;-> true
(sum-free '(4))
;-> true
(sum-free '(1 5 7))
;-> true
(sum-free '(16 1 4 9))
;-> true

(sum-free '(0))
;-> nil
(sum-free '(1 4 5 7))
;-> nil
(sum-free '(3 0))
;-> nil
(sum-free '(16 1 4 8))
;-> nil

Vediamo i tempi di esecuzione delle due funzioni.

Insieme casuale:
(setq insieme (unique (rand 1e6 5000)))
(time (println (sum-free? insieme)))
;-> 11215.037
;-> nil
(time (println (sum-free insieme)))
;-> nil
;-> 1.995

Insieme con tutti numeri dispari (quindi è sum-free):
(time (println (sum-free? (sequence 1 5001 2))))
;-> true
;-> 1724.876
(time (println (sum-free (sequence 1 5001 2))))
;-> true
;-> 139356.052
La funzione "find" sulle liste rallenta molto l'esecuzione.

Terzo metodo (controlli e poi prodotto cartesiano con intersezione):

(define (sumfree? lst)
  (let (out '())
    (cond ((null? (clean odd? lst)) true) ; tutti numeri dispari?
          ((ref 0 lst) nil); numero 0 nella lista?
          (true ; prodotto cartesiano e intersezione
            (dolist (el1 lst)
              (dolist (el2 lst)
                (push (+ el1 el2) out)))
            (null? (intersect lst out))))))

(time (println (sumfree? insieme)))
;-> nil
;-> 10918.23
(time (println (sumfree? (sequence 1 5001 2))))
;-> true
;-> 0.996


------------
Numeri orari
------------

Determinare tutti i numeri che rappresentano un'ora della giornata in ore e minuti (da 0 a 23 e da 0 a 59).
Per esempio, 18 rappresenta l'ora 1 e 8 minuti e l'ora 18 (le 6 di pomeriggio).

Sono sufficientei due cicli "for" per risolvere il problema.

(define (ora-esatta)
  (let (out '())
    (for (ore 0 23)
      (for (minuti 0 59)
        (push (int (string ore minuti) 0 10) out)))
    ; nella lista out ci sono molti valori duplicati
    (sort (unique out))))

(ora-esatta)
;-> (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
;->  25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
;->  47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68
;->  69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
;->  91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109
;->  ...
;->  2255 2256 2257 2258 2259 2310 2311 2312 2313 2314 2315 2316 2317
;->  2318 2319 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330
;->  2331 2332 2333 2334 2335 2336 2337 2338 2339 2340 2341 2342 2343
;->  2344 2345 2346 2347 2348 2349 2350 2351 2352 2353 2354 2355 2356
;->  2357 2358 2359)


-------------------------------
Notazione Forsyth-Edwards (FEN)
-------------------------------

La Notazione Forsyth-Edwards (FEN) è una notazione scacchistica utilizzata per descrivere una particolare posizione sulla scacchiera inventatata da David Forsyth (1854–1909).
Lo scopo della notazione FEN è quello di fornire tutte le informazioni necessarie a consentire la prosecuzione di una partita a partire da una posizione data.

Una stringa FEN definisce una particolare posizione nel corso di una partita, descrivendola interamente in una linea di testo, ed utilizzando solo i caratteri ASCII.
Un file di testo che contenga solo stringhe FEN dovrebbe recare l'estensione ".fen".

Una stringa è composta di 6 campi, a loro volta separati da uno spazio.
Usualmente è indicata tra parentesi quadre.

I campi sono:

1. Posizione dei pezzi: viene descritta ogni singola traversa, a partire dalla ottava fino alla prima.
Per ciascuna traversa, sono descritti i contenuti di ciascuna casa, a partire dalla colonna "a" ed a finire con quella "h".
I pezzi del Bianco sono indicati usando le iniziali (inglesi) dei pezzi stessi in maiuscolo ("KQRBNP").
I pezzi del Nero, con le stesse lettere, ma in minuscolo ("kqrbnp").
K = King, Q = Queen, R = Rook, B = Bishop, N = kNight, P = pawn.
L'unica eccezione è il cavallo 'knight' che viene indicato con la lettera N o n.
Il numero di case vuote tra un pezzo e l'altro o dai bordi della scacchiera è indicato con le cifre dall'1 all'8.
Se una traversa non contiene pezzi o pedoni, sarà descritta con un 8.
Il segno " / " è usato per separare le traverse una dall'altra.

2. Giocatore che ha la mossa: "w" indica che la mossa è al Bianco, "b" che tocca al Nero.

3. Possibilità di arroccare: se nessuno dei due giocatori può arroccare, si indica "-".
Altrimenti, possono essere utilizzare una o più lettere:
"K" (Il Bianco può arroccare corto),
"Q" (Il Bianco può arroccare lungo),
"k" (il Nero può arroccare corto),
"q" (il Nero può arroccare lungo).

4.  Possibilità di catturare en passant: se non è possibile effettuare alcuna cattura en passant, si indica "-".
Se un pedone ha appena effettuato la sua prima mossa di due case e c'è la possibilità di catturarlo en passant, verrà indicata la casa "alle spalle" del pedone stesso.

5.  Numero delle semimosse:  è il numero di semimosse dall'ultima spinta di pedone o dall'ultima cattura.
È usato per determinare se si può chiedere patta per la regola delle cinquanta mosse.

6.  Numero di mosse: il numero complessivo di mosse della partita.
Inizia da 1, ed aumenta di una unità dopo ogni mossa del Nero.

Come esempio consideriamo la seguente stringa FEN e ricostruiamo la posizione:

 [r1bq1rk1/pp3ppp/3n4/2p1N3/2B5/7P/PPP2PP1/R1BQR1K1 w]

    Coordinate algebriche:                     Righe FEN per ogni traversa:

    +---+---+---+---+---+---+---+---+
  8 | r |   | b | q |   | r | k |   |   <-->   r1bq1rk1
    +---+---+---+---+---+---+---+---+
  7 | p | p |   |   |   | p | p | p |   <-->   pp3ppp
    +---+---+---+---+---+---+---+---+
  6 |   |   |   | n |   |   |   |   |   <-->   3n4
    +---+---+---+---+---+---+---+---+
  5 |   |   | p |   | N |   |   |   |   <-->   2p1N3
    +---+---+---+---+---+---+---+---+
  4 |   |   | A |   |   |   |   |   |   <-->   2B5
    +---+---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   | P |   <-->   7P
    +---+---+---+---+---+---+---+---+
  2 | P | P | P |   |   | P | P |   |   <-->   PPP2PP1
    +---+---+---+---+---+---+---+---+
  1 | R |   | B | Q | R |   | K |   |   <-->   R1BQR1K1
    +---+---+---+---+---+---+---+---+
      a   b   c   d   e   f   g   h

Vedere anche "Posizione di scacchi casuale - random chess position" su "Note libere 11".

Supponiamo che la posizione sia memorizzata in una matrice.

     Scacchiera con                          Matrice della posizione
     coordinate algebriche
                                              0   1   2   3   4   5   6   7
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  8 |   |   |   |   |   |   |   |   |     0 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  7 |   |   |   |   |   |   |   |   |     1 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  6 |   |   |   |   |   |   |   |   |     2 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |   |     3 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |   |     4 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |   |     5 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |   |     6 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  1 |   |   |   |   |   |   |   |   |     7 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
      a   b   c   d   e   f   g   h

(setq board '(({r} { } {b} {q} { } {r} {k} { })
              ({p} {p} { } { } { } {p} {p} {p})
              ({ } { } { } {n} { } { } { } { })
              ({ } { } {p} { } {N} { } { } { })
              ({ } { } {B} { } { } { } { } { })
              ({ } { } { } { } { } { } { } {P})
              ({P} {P} {P} { } { } {P} {P} { })
              ({R} { } {B} {Q} {R} { } {K} { })))

(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))
      )
    )
    (println)
  )
  'chess-position)

(print-board board)
;->  r . b q . r k .
;->  p p . . . p p p
;->  . . . n . . . .
;->  . . p . N . . .
;->  . . B . . . . .
;->  . . . . . . . P
;->  P P P . . P P .
;->  R . B Q R . K .
;-> end

Funzione che converte una stringa FEN nella posizione sulla scacchiera:

(define (fen-board fen)
  (local (grid field traverse row col ch))
    (setq grid (array 8 8 '(" ")))
    ; remove "[" and "]"
    (setq fen (slice fen 1 (- (length fen) 2)))
    ; parse fen
    (setq field (parse fen " "))
    ; parse field
    (dolist (f field)
      (cond ((= $idx 0) ; 1) position
              (setq traverse (parse f "/"))
              (setq row 0 col 0)
              (dolist (t traverse)
                (setq row $idx)
                (setq col 0)
                (dostring (ch t)
                  (cond ((and (>= ch 49) (<= ch 56)) ; numero
                          ; (char "1") --> 49, (char "8") --> 56
                          (setq num (- ch 48))
                          (for (i 1 num)
                            (setf (grid row (+ col (- i 1))) " ")
                          )
                          (setq col (+ col num)))
                        (true ; carattere
                          (setf (grid row col) (char ch))
                          (++ col))
                  )
                )
              )
              (print-board grid)
            )
            ((= $idx 1) (println "Active color: "f)) ; 2) mossa
            ((= $idx 2) (println "Castling: " f))    ; 3) arrocco
            ((= $idx 3) (println "En passant: "f))   ; 4) en passant
            ((= $idx 4) (println "Halfmove: " f))    ; 5) semi-mosse
            ((= $idx 5) (println "Fullmove: " f))    ; 6) mosse
      )
    )
  'end)

(setq fen "[r1bq1rk1/pp3ppp/3n4/2p1N3/2B5/7P/PPP2PP1/R1BQR1K1 w]")
(fen-board fen)
;->  r . b q . r k .
;->  p p . . . p p p
;->  . . . n . . . .
;->  . . p . N . . .
;->  . . B . . . . .
;->  . . . . . . . P
;->  P P P . . P P .
;->  R . B Q R . K .
;-> Active color: w

(setq fen "[rnbqkbnr/pp1ppppp/8/2p5/4P3/5N2/PPPP1PPP/RNBQKB1R b KQkq - 1 2]")
;-> (fen-board fen)
;->  r n b q k b n r
;->  p p . p p p p p
;->  . . . . . . . .
;->  . . p . . . . .
;->  . . . . P . . .
;->  . . . . . N . .
;->  P P P P . P P P
;->  R N B Q K B . R
;-> Active color: b
;-> Castling: KQkq
;-> En passant: -
;-> Halfmove: 1
;-> Fullmove: 2

Funzione che converte una posizione sulla scacchiera nella stringa FEN:

(define (board-fen board)
  (local (row col ch)
    (setq fen "[")
    (dolist (trav board)
      (setq num 0)
      (dolist (t trav)
        (cond ((= t " ") ; casa vuota
                (++ num))
              (true ; casa occupata da un pezzo
               (if (> num 0) (extend fen (string num)))
               (setq num 0)
               (extend fen t))
        )
      )
      (if (> num 0) (extend fen (string num)))
      (extend fen "/")
    )
    (setf (fen -1) "]")
    fen))

(setq board '(({r} { } {b} {q} { } {r} {k} { })
              ({p} {p} { } { } { } {p} {p} {p})
              ({ } { } { } {n} { } { } { } { })
              ({ } { } {p} { } {N} { } { } { })
              ({ } { } {B} { } { } { } { } { })
              ({ } { } { } { } { } { } { } {P})
              ({P} {P} {P} { } { } {P} {P} { })
              ({R} { } {B} {Q} {R} { } {K} { })))

(board-fen board)
;-> "[r1bq1rk1/pp3ppp/3n4/2p1N3/2B5/7P/PPP2PP1/R1BQR1K1]"


--------------------------------------------------------
ASCII caratteri stampabili (printable characters 32-127)
--------------------------------------------------------

I codici da 32 a 127 sono i cosiddetti caratteri stampabili.
Rappresentano lettere, numeri, punteggiatura e altri simboli.
Il carattere 127 rappresenta il comando DEL.

;; ASCII Table (printable characters)
;;
;; 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;;     !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /
;;
;; 48 49 50 51 52 53 54 55 56 57
;;  0  1  2  3  4  5  6  7  8  9
;;
;; 58 59 60 61 62 63 64
;;  :  ;  <  =  >  ?  @
;;
;; 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90
;;  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z
;;
;; 91 92 93 94 95 96
;;  [  \  ]  ^  _  `
;;
;; 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122
;;  a  b  c   d  e   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   y   z
;;
;; 123 124 125 126 127
;;  {   |   }   ~   ⌂ (DEL)

(define (chars-printable) (map char (sequence 32 126)))
(chars-printable)
;-> (" " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/"
;->  "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" ":" ";" "<" "=" ">" "?" "@"
;->  "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q"
;->  "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "[" "\\" "]" "^" "_" "`" "a"
;->  "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r"
;->  "s" "t" "u" "v" "w" "x" "y" "z" "{" "|" "}" "~")

(define (chars-lower) (map char (sequence 97 122)))
(chars-lower)
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
;->  "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

(define (chars-upper) (map char (sequence 65 90)))
(join (chars-upper))
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(define (chars-digit) (map char (sequence 48 57)))
(chars-digit)
;-> ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")

(define (chars-symbol)
  (extend (map char (sequence 32 47)) (map char (sequence 58 64))
          (map char (sequence 91 96)) (map char (sequence 123 126))))

(join (chars-symbol))
(" " "!" "\"" "#" "$" "%" "&" "'" "(" ")" "*" "+" "," "-" "." "/"
 ":" ";" "<" "=" ">" "?" "@" "[" "\\" "]" "^" "_" "`" "{" "|" "}"
 "~")
(join (chars-symbol))
;-> " !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"


---------------------------
clean e filter per stringhe
---------------------------

Le funzioni "clean" e "filter" accettano solo liste.
Per utilizzarli con le stringhe potremmo utilizzare "explode" e poi passare la lista risultante.
Comunque vorrei qualcosa di semplice utilizzo.
Le funzioni "clean-str" e "filter-str" prendono due parametri:
1) la stringa di caratteri da eliminare/mantenere
2) la stringa da modificare

(define (clean-str chars str)
  (join (difference (explode str) (explode chars) true)))

(clean-str "aeoiuk" "attenzione pericolo")
;-> "ttnzn prcl"

(define (filter-str chars str)
  (join (intersect (explode str) (explode chars) true)))

(filter-str "aeoiuk" "attenzione pericolo")
;-> "aeioeeioo"


--------------------
Numerazione di Godel
--------------------

La numerazione di Godel è un sistema che assegna un numero naturale ad ogni simbolo ed espressione in un sistema logico, inventato nel 1931 da Kurt Godel per le dimostrazioni dei suoi teoremi di incompletezza.
Considerariamo il sistema logico in cui i simboli sono lettere e le espressioni sono parole.
Per esempio, la parola LISP consiste di sei simboli L, I, S, P.
La numerazione di Godel assegna numeri alle lettere, diciamo A=1...Z=26, quindi assegna ogni lettera come esponente del numero primo successivo, quindi LISP sarebbe numerato con:

  2^12 × 3^9 × 5^19 × 7^16 = 51103419718863787734375000000000000

(* (** 2 12) (** 3 9)  (** 5 19) (** 7 16))
;-> 51103419718863787734375000000000000L

Il processo è reversibile, cioè è possibile scomporre il numero di Godel e decodificare gli esponenti.

Nota: la numerazione di Godedl genera un numero diverso (univoco) per ogni stringa.

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Per semplicità utilizziamo una lista finita di numeri primi (50):

(setq primi '(2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73
              79 83 89 97 101 103 107 109 113 127 131 137 139 149 151 157
              163 167 173 179 181 191 193 197 199 211 223 227 229))

Inoltre limitiamo la codifica alle sole lettere maiuscole.

Funzione di codifica:

(define (godel str)
  (let (g 1L)
    (dostring (ch (upper-case str))
      (setq g (* g (** (primi $idx) (- ch 64))))
      (println (char ch) { } (- ch 64) { -> } (primi $idx)"^"(- ch 64) "=" (** (primi $idx) (- ch 64)))
    )
  g))

(godel "LISP")
;-> L 12 -> 2^12=4096L
;-> I  9 ->  3^9=19683L
;-> S 19 -> 5^19=19073486328125L
;-> P 16 -> 7^16=33232930569601L
;-> 51103419718863787734375000000000000L

(* 4096L 19683L 19073486328125L 33232930569601L)
;-> 51103419718863787734375000000000000L

(godel "ABBA")
;-> A 1 -> 2^1=2L
;-> B 2 -> 3^2=9L
;-> B 2 -> 5^2=25L
;-> A 1 -> 7^1=7L
;-> 3150L

Per decodificare il numero e trovare la stringa che lo ha generato dobbiamo fattorizzare il numero:

(setq f (factor 3150))
;-> (2 3 3 5 5 7)

E poi contare quante volte sono ripetuti i singoli fattori (molteplicità):

; singoli fattori
(setq u (unique f))
;-> (2 3 5 7)

; conta della moltiplicità dei fattori
(setq conta (count u f))
;-> (1 2 2 1)

Adesso basta applicare la decodifica dei numeri in caratteri:

(map (fn(x) (char (+ x 64))) conta)
;-> ("A" "B" "B" "A")

Funzione di decodifica:

(define (decode-godel num)
  (local (f u)
    (setq f (factor num))
    (setq u (unique f))
    (join (map (fn(x) (char (+ x 64))) (count u f)))))

(decode-godel 3150)
;-> "ABBA"

Purtroppo la funzione "factor" non è utilizzabile con i numeri big-integer:
(MAX-INT = 9223372036854775807)

(decode-godel 51103419718863787734375000000000000L)
;-> ERR: number out of range in function factor
;-> called from user function (decode-godel 51103419718863787734375000000000000L)

Quindi usiamo la seguente funzione per fattorizzare:

(define (factor-i num)
"Factorize a big integer number"
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% num 2)) (push '2L out -1) (setq num (/ num 2)))
    (while (zero? (% num 3)) (push '3L out -1) (setq num (/ num 3)))
    (while (zero? (% num 5)) (push '5L out -1) (setq num (/ num 5)))
    (while (zero? (% num 7)) (push '7L out -1) (setq num (/ num 7)))
    (setq k 11L i 0)
    (while (<= (* k k) num)
      (if (zero? (% num k))
        (begin
          (push k out -1)
          (setq num (/ num k)))
        (begin
          (setq k (+ k (dist i)))
          (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> num 1) (push (bigint num) out -1))
    out))

(factor-i 51103419718863787734375000000000000L)
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 3L 3L 3L 3L 5L
;->  5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 7L 7L 7L 7L
;->  7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L)

(define (decode-godel num)
  (local (f u)
    (setq f (factor-i num))
    (setq u (unique f))
    (join (map (fn(x) (char (+ x 64))) (count u f)))))

(decode-godel 51103419718863787734375000000000000L)
;-> "LISP"

(godel "newlisp")
;-> N 14 -> 2^14=16384L
;-> E 5  -> 3^5=243L
;-> W 23 -> 5^23=11920928955078125L
;-> L 12 -> 7^12=13841287201L
;-> I 9  -> 11^9=2357947691L
;-> S 19 -> 13^19=1461920290375446110677L
;-> P 16 -> 17^16=48661191875666868481L
;-> 110192844774977460126605610605702126906292904935806038056274175976562500000000000000L

(decode-godel 110192844774977460126605610605702126906292904935806038056274175976562500000000000000L)
;-> "NEWLISP"

(setq alpha (godel "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
;-> A 1 -> 2^1=2L
;-> B 2 -> 3^2=9L
;-> C 3 -> 5^3=125L
;-> D 4 -> 7^4=2401L
;-> E 5 -> 11^5=161051L
;-> F 6 -> 13^6=4826809L
;-> G 7 -> 17^7=410338673L
;-> H 8 -> 19^8=16983563041L
;-> I 9 -> 23^9=1801152661463L
;-> J 10 -> 29^10=420707233300201L
;-> K 11 -> 31^11=25408476896404831L
;-> L 12 -> 37^12=6582952005840035281L
;-> M 13 -> 41^13=925103102315013629321L
;-> N 14 -> 43^14=73885357344138503765449L
;-> O 15 -> 47^15=12063348350820368238715343L
;-> P 16 -> 53^16=3876269050118516845397872321L
;-> Q 17 -> 59^17=1271991467017507741703714391419L
;-> R 18 -> 61^18=136753052840548005895349735207881L
;-> S 19 -> 67^19=49593099428404263766544428188098203L
;-> T 20 -> 71^20=10596610576391421032662867140133202401L
;-> U 21 -> 73^21=1348279907365869037210940254745047725673L
;-> V 22 -> 79^22=559494740587480879172162808385362976196641L
;-> W 23 -> 83^23=137656310293626928473255626953462008797108987L
;-> X 24 -> 89^24=61004259453331056987939675478443460082004997441L
;-> Y 25 -> 97^25=46697470525437199259645027890776274462295771593057L
;-> Z 26 -> 101^26=12952563149674059497286795495913738760889297603252601L
;-> 415260364831088141867894021632550820346162101325613792345810114400910514
;-> 317412167586650021121833870034921203823690683008724895811222364673849139
;-> 216671139100788554150419950718781730038776119800333893574816309672573909
;-> 695498235624708513162596101581761852746026349347879108878718311949631722
;-> 492822286363917917040069041491884038827718215780986280439105169542807185
;-> 468703329772870877506193497585032045949738505627758317340676507217143012
;-> 654416894907347356697296673839244260921466927657884638690278253588924482
;-> 254626824854619852358939817427700766183092864231129965172825851501071650
;-> 9196547272680962939471941750L

(decode-godel alpha)
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

Generalizziamo le due funzioni di codifica/decodifica in modo da trattare tutti i caratteri ASCII stampabili (32-126).

(define (encode-godel str)
  (let (g 1L)
    (dostring (ch str) (setq g (* g (** (primi $idx) (- ch 31)))))
  g))

(define (decode-godel num)
  (local (f u)
    (setq f (factor-i num))
    (setq u (unique f))
    (join (map (fn(x) (char (+ x 31))) (count u f)))))

(encode-godel "ABC abc 123 !@# <>:")
;-> 39911660981250439803710089453218313440521182511801778772255772240541908
;-> 74938080229982666479851833908813107116478194694558115270553002214310389
;-> 40370374931894005002334307110312035383736586519255693972157497377553283
;-> 14028400556982113243261696500607428747559525219816805180556055875194781
;-> 89153923331767732732130223925187593273708372563867817087085182694180919
;-> 84654806427465548325956883465881188044907551957043623890132057389835120
;-> 03374726519093429273419906171255061576942845143828292130495770885678381
;-> 22318410915039336938565395608325000000000000000000000000000000000L

(decode-godel (encode-godel "ABC abc 123 !@# <>:"))
;-> "ABC abc 123 !@# <>:"


--------------------------
Generatore di numeri primi
--------------------------

Scriviamo una funzione che genera il prossimo numero primo a partire da un determinato numero.
Usiamo un contesto che chiamiamo "nextprime".
Prima di tutto definiamo una funzione che verifica se un numero è primo:

(define (nextprime:prime? n)
  (if (< n 2) nil
      (= 1 (length (factor n)))))

Adesso scriviamo una funzione che definisce il numero da cui iniziare la ricerca del prossimo primo:

(define (nextprime:start num) (setq nextprime:val num))

Una funzione per vedere il numero corrente (che potrebbe non essere primo):

(define (nextprime:current)
  ; se val è nil, allora val = 2
  (if (nil? nextprime:val)
      (setq nextprime:val 2)
      ;else
      nextprime:val))

Infine la funzione che genera il prossimo numero primo (partendo da nextprime:val):

(define (nextprime:nextprime)
  ; se val è nil, allora val = 1
  (setq nextprime:val (or nextprime:val 1))
  (until (nextprime:prime? (++ nextprime:val)))
  nextprime:val)

Facciamo alcune prove:

(nextprime)
;-> 2
(nextprime)
;-> 3
(map nextprime (sequence 1 10))
;-> (5 7 11 13 17 19 23 29 31 37)

(nextprime:start 98)
;-> 98
(nextprime:current)
;-> 98
(nextprime)
;-> 101
(nextprime:current)
;-> 101

Nota: quando programmiamo con i contesti è utile analizzare i simboli che sono stati definiti con la seguente funzione:

(define (simboli contesto)
  (dotree (el contesto) (println el)))

(simboli nextprime)
;-> nextprime:current
;-> nextprime:nextprime
;-> nextprime:prime?
;-> nextprime:start
;-> nextprime:val


------------------------------------------------------------------
Forum: Dynamic and lexical scoping - anyone help me understand it?
------------------------------------------------------------------

cormullion:
----------
I decided it was time for me to learn about this, since I've avoided it hitherto (no mention of it in "Introduction to newLISP"... :-))

Apparently newLISP is bad because it has dynamic scoping...
Can someone explain in words of one syllable why that's bad?
And what's lexical scoping (which newLISP also has, but not enough to make it less bad)?

(I have read the manual. But it was very condensed...)

The Wikipedia article is a start, but the examples were in C and Perl, so it wasn't easy to translate them into newLISP...

newdep:
------
Actualy good question...I personaly dont care what i use,
but im intrested in a good explenation too ;-)

m i c h a e l:
--------------
Dynamic Scope
In a dynamically scoped language, e.g. most versions of Lisp, an identifier can be referred to, not only in the block where it is declared, but also in any function or procedure called from within that block, even if the called procedure is declared outside the block.

rickyboy:
---------
Here's a short example which hopefully will illustrate the difference.
Say you have the following definitions entered into your newLISP session.

(define x 42)
(define (f x) (g (+ x 2)))
(define (g y) (+ y x))

Now, can you guess the value of (f 1) before evaluating it at the newLISP prompt?

The answer will either be 45 (i.e. y + x = 3 + 42) or 4 (i.e. y + x = 3 + 1).
That is, the answer depends on which x you are referring to.

It turns out that the answer is 4. But not so with Scheme, for instance:

$ scsh
Welcome to scsh 0.6.6 (King Conan)
Type ,? for help.
> (define x 42)
> (define (f x) (g (+ x 2)))
> (define (g y) (+ y x))
> (f 1)
45

But what is happening?
In Scheme, which has lexical variable scope, g can only see the x at the top level (or any level above it in a nested definition).
In newLISP, g sees the x defined "through" the running application of f (hence, the term "dynamic"), since that x is f's formal parameter.

Hope that helps and doesn't confuse.

cormullion:
-----------
Thanks, Ricky. Light is dawning... :-)

My initial reaction is that dynamic scoping is problematic, because it seems that:

 (define (g y) (+ y x))

will give different answers, depending on where you call it from, since x may or may not be a global x or an x inside a calling function.

So the apparent problem with DS is that if you're a sloppy programmer and use symbols that aren't defined in your functions you won't know whether a symbol is 'global' or is inherited from a calling function...
And that other people will use your functions and pick up the wrong values for symbols... unless you bother to read their code first...

OK - so how do I avoid it using contexts?

rickyboy:
---------
Easy. If g were in a context with the top level x from the previous example, then you'd get the same answer as in Scheme:

> (define (f x) (g (+ x 2)))
> (context 'g)
g> (define x 42)
g> (define (g:g y) (+ y x))
g> (context MAIN)
> (f 1)
45

But most of the time, I write functions which don't have free variables (not counting primitives like +).
So I don't have to resort to making contexts just for my functions.

For instance, note that the body of g has two variables x and y. y is a bound variable in g, since it is a formal parameter of g.
However, x is unbound, i.e. "free".

If I ever notice free variables in the body of my functions, it is usually due to either an oversight (e.g. I meant it to be a local variable and I forgot to bind it by a let(n) or a local) or it is free on purpose (i.e. it's supposed to refer to a global variable).
Usually the former case prevails and I have to fix the problem, but when the latter case holds, it's still not a problem due to the naming convention I have for globals (to put asterisks around the name like *this-is-a-global*) which doesn't conflict with names I choose for the non-globals I use (i.e. the ones that show up on the stack).

cormullion:
-----------
This seems a useful way of thinking about the problem... so thanks!

You can spot free variables lexically - if it's not in a let or a local list inside a block or function definition, it must be global/dynamically scoped... ?

Interesting idea to use asterisks - looks familiar... ;-)

Lutz:
-----
But most of the time, I write functions which don't have free variables (not counting primitives like +), so I don't have to resort to making contexts just for my functions.

Yes, that is the best practice, and most experienced programmers work like this anyway in any programming language and in the spirit of structured programming.

it's still not a problem due to the naming convention I have for globals (to put asterisks around the name like *this-is-a-global*)

... which is a commonly used convention for Lisp programmers and most people from other Lisps will immedeately understand you mean a global.

Or what I sometimes do, is putting all globals into a context, e.g.:

(set 'Setup:data-path "/home/data")
(set 'Setup:language "english")
(set 'Setup:n-records 12345)

This has also the advantage that all your globals and/or constants can be saved/loaded to a file in one swoop:

(save "setup.lsp" 'Setup)

; or when reloading

(load "setup.lsp")

As Rickyboy was showing, contexts give you the the lexical fence.
This is why a multiprogrammer/bigger project in newLISP always should be divided in context modules, so nobody steps on each others feet.

newLISP gives you the best of both worlds: you can make use of dynamic scoping but also build lexical fences using contexts to avoid the dangers of it.

Jeff:
-----
I personally prefer dynamic scoping because it forces you to write functions without side effects. I like the idea of having multiple, named, dynamic scopes, though, a-la python modules.

cormullion:
-----------
I'm still puzzled - but for different reasons, now! ;-)
If - as I understand it - dynamic scoping is the way that otherwise unassigned symbols are evaluated in functions called by other functions, I can't see what the fuss is about. People seem to think that dynamic scoping is the devil's work... :-)

I'm not much of a programmer, but I don't think I tend to refer to symbols without knowing what they are and where they're defined, except by mistake. I use global variables a lot - but not without knowing that they're global... There are plenty of more common pitfalls awaiting programmers in every language than that, I would have thought...

Thanks for the explanations...!

Jeff:
-----
Dynamic namespaces are better for non-object oriented languages, particularly procedural or functional languages.
Lexical namespaces are kind of a way of protecting sloppy programmers (in my not-so-humble opinion).

If you take rickyboy's example, the lambda f is redefining x as whatever is passed to it.
Now, since lambda g is called from inside lambda f, lamba f's scope takes precedence over the global.

With lexical namespaces, the scope from which lambda g is called is irrelevant. Only the scope in which it is defined matters.

This book has an excellent intro to dynamic scoping: http://www.cs.cmu.edu/~dst/LispBook/book.pdf
"COMMON LISP: A Gentle Introduction to Symbolic Computation"

It is a bit dated (in that it teaches ansi common lisp as it was in the 80s, I believe), but since common lisp has not changed that much since then, it's still relevant, and it gives an excellent foundation in lisp technique.

cormullion:
-----------
One more question - to see if I've got this sorted out yet.
In the following code, is the width symbol in the right-just context statically or lexically scoped, and is the w symbol in the dolist dynamically scoped?

(context 'right-just)
(set 'width 30)
(define (right-just:right-just str)
  (slice (string (dup " " width) str) (* width -1)))

(context MAIN)

(set 'width 1) ; just a test

(dolist (w (symbols))
  (println (right-just w)))

I'm wondering whether it's the terminology that's confusing me rather than the actual behaviour itself...

thanks if you can dispel the gloom!

Jeff:
-----
Technically, they are all dynamically scoped - the entire language is.
All variables obey the same rules for scoping.
However, contexts allow you to wall off a scope to provide newlisp with some of the features of lexical scopes.
Contexts are their own, isolated, dynamic scopes.

There is a difference between global versus local scope and dynamic versus lexical scope.

Both dynamic and lexical scopes have both global and local scopes.
More accurately, there are dynamic and lexical namespaces.
These determine the rules for how symbols may be accessed within global and local scopes.

Contexts let you create additional namespaces.
When you use a function, it creates its own local scope internally.
This means that when you access a symbol, the interpreter will first look at the local scope. If it cannot find the symbol there, it will then look to the scope the next outside scope.
For example:

(set 'a-list '(foo bar baz))
(set 'b "Hello there")
(dolist (b a-list)
  (= b "Hello there")) ; => evaluates to nil, because b is locally declared in the dolist

That is an example of local scope overriding a globally declared symbol.
What dynamic/lexical namespaces do are determine the parent scope of a local scope.
So,

(set 'a 50)
(define (foo)
  (println a))
(define (bar)
  (let ((a 10))
    (foo)))
(bar)

When we run bar at the bottom, it first enters the bar lambda. It then enters the let scope. It then runs foo.

With dynamic namespaces, foo's outer scope search will proceed through let, bar, then global.
In lexical, foo will search for 'a in foo, then global.
Lexical is literally that - based on its lexical location.

Dynamic is determined by where it is called. 
Because foo is called form within bar and let, those are its parent scopes. 
In a lexically scoped language, because foo is defined outside of bar, it has no internal relationship with bar.

cormullion:
-----------
thanks jeff - i'll work this a few times today to see if it makes sense. I'm grateful that you've spent some time trying to help...

One thing, though - the word lexical to me (and the OED) means "Pertaining or relating to the words or vocabulary of a language. Often contrasted with grammatical." What do computer programmers mean when they use the word?

rickyboy:
---------
They mean "of, or related to, program text." Wikipedia has a nice blurb about it:
http://en.wikipedia.org/wiki/Scope_(programming) wrote:
With static scope, a variable always refers to its nearest enclosing binding. This is a property of the program text and unrelated to the runtime call stack. Because matching a variable to its binding only requires analysis of the program text, this type of scoping is sometimes also called lexical scoping.

cormullion:
-----------
yes that was a good bit... But you can see why i get confused -

Generally, certain blocks are defined to create bindings whose lifetime is the execution time of the block; this adds a hint of lexicality to the scoping.

rickyboy:
---------
Yes, I agree that part is confusing -- it was a poor choice of words.


---------------
Nested contexts
---------------

Lutz:
-----
The context/namespace system in newLISP comes from an earlier language project called RuleTalk (a Prolog like language).
This had nested contexts with inheritance from the ancestor levels.
The experience building programs with these made me abandon the idea and implement a flat context system for newLISP.
Initially with inheritance for symbols in MAIN, which was later abandoned too.

Nested namespaces are well suited for languages like Java or JavaScript, but not well suited for a Lisp functional programming language, where the main organizing paradigm is the list.

Use a combination of contexts, symbols, lists and association lists to configure complex data structures.
When data structures are defined this way they are much easier to handle in a functional way with newLISP's repertoir of built-ins for function application, mapping, lookups in association lists and iteration through lists.
On the highest data level and for building dictionaries/hashes use contexts.


------------------------
Intervallo di confidenza
------------------------

In statistica, un intervallo di confidenza (CI) è un intervallo di stime per un parametro sconosciuto.
Un intervallo di confidenza viene calcolato a un livello di confidenza (CL) designato.
In genere vengono utilizzati i livelli di confidenza del 90%, 95% e 99%.
Un livello di confidenza al 95%, significa che di tutti gli intervalli calcolati (con questo livello), il 95% dovrebbe contenere il vero valore del parametro.

Alcuni errori comuni sugli intervalli di confidenza:

- un intervallo di confidenza al 95% non significa che esiste una probabilità del 95% che il parametro della popolazione (es. la percentuale di voti per un partito in tutta Italia) sia compreso nei due estremi dell'intervallo.
L'intervallo può "contenere" il valore del parametro, oppure no.
Non è una questione di probabilità.
Il 95% di confidenza è riferito all'attendibilità del metodo di stima, ma non del particolare intervallo calcolato.
Per quanto riguarda la bontà del metodo di stima si possono valutare, quando pertinenti:
a) numerosità e rappresentatività del campione,
b) casualizzazione della modalità di campionamento,
c) controllo preventivo delle ipotesi di indipendenza e di identica distribuzione,
d) assenza di autocorrelazione fra i dati osservati,
e) eliminazione eventuale di unità fuori tolleranza.

- similmente per il singolo campione, un intervallo di confidenza al 95% non significa che il 95% dei valori campionati cada nell'intervallo.

- se l'intervallo di confidenza è un insieme di valori probabili per l'intera popolazione, ciò non vale per i singoli campioni.

Esempio pratico: sondaggio

Un intervallo di confidenza è rappresentato da un limite inferiore e un limite superiore che definiscono un margine di errore per i risultati di un sondaggio.

L'intervallo di confidenza valuta la qualità e l'accuratezza della stima ottenuta con il campione esaminato, cioè la "fiducia" del sondaggio

L'intervallo dipende principalmente dal numero di persone intervistate.
Se un sondaggio ha più domande e il numero di risposte ottenute differisce per ogni domanda, allora l'intervallo di confidenza deve essere calcolato per ogni domanda.

Nota: la frequenza osservata in un campione viene chiamata "f", mentre la probabilità nella popolazione totale viene chiamata "p".

Per un'indagine su n persone risultante nella frequenza f e nella probabilità p, allora l'intervallo di confidenza CI% è dato da:

  Limite inferiore             Limite superiore

         sqrt(f*(1 - p))              sqrt(p*(1 - p))
  p - K*-----------------,     p + K*-----------------
            sqrt(n)                      sqrt(n)

dove K = sqrt(2)*InverseErf(LC%/100)
e InverseErf(x) è la funzione errore inversa (Inverse Error Function).

Vediamo i valori più utilizzati per K in base al livello di confidenza (LC):

  LC% = 99.9% --> K = 3.2905267314918947932216270353746491792162269256774...
  LC% = 99%   --> K = 2.5758293035489007609785767486038141173060176342763...
  LC% = 95%   --> K = 1.9599639845400542355245944305205515279555500778695...
  LC% = 90%   --> K = 1.6448536269514727148638489079916321360831957442753...
  LC% = 50%   --> K = 0.6744897501960817432022270145413071853869044150499...

(define (confidence n f p lc)
  (local (inf sup)
    (cond ((= lc 99.9) (setq k 3.290526731))
          ((= lc 99)   (setq k 2.575829303))
          ((= lc 95)   (setq k 1.959963984))
          ((= lc 90)   (setq k 1.644853626))
          ((= lc 50)   (setq k 0.674489750))
          (true (println "lc error!!!"))
    )
    (setq inf (sub p (mul k (div (sqrt (mul f (sub 1 p))) (sqrt n)))))
    (setq sup (add p (mul k (div (sqrt (mul p (sub 1 p))) (sqrt n)))))
    (list inf sup)))

Facciamo un esempio: abbiamo intervistato 400 persone e 125 hanno votato "SI".
Calcoliamo gli intervalli di confidenza per i livelli di confidenza 50%, 90%, 95%, 99% e 99.9%.

In questo caso la frequenza e la probabilità valgono 125/400 = 0.3125

(confidence 400 0.3125 0.3125 50)
;-> (0.2968682816765265 0.3281317183234735)
50% di probabilità che il voto "SI" sia tra il 29.7% e 32.8%

(confidence 400 0.3125 0.3125 90)
;-> (0.2743794969605156 0.3506205030394844)
90% di probabilità che il voto "SI" sia tra il 27.4% e 35.1%

(confidence 400 0.3125 0.3125 95)
;-> (0.2670766189596788 0.3579233810403212)
95% di probabilità che il voto "SI" sia tra il 26.7% e 35.8%

(confidence 400 0.3125 0.3125 99)
;-> (0.2528035581877335 0.3721964418122665)
99% di probabilità che il voto "SI" sia tra il 25.2% e 37.2%

(confidence 400 0.3125 0.3125 99.9)
;-> (0.2362400019869062 0.3887599980130939)
99.9% di probabilità che il voto "SI" sia tra il 23.6% e 38.9%

Per ridurre/migliorare un intervallo di confidenza, è necessario aumentare il numero di persone che partecipano all'indagine.

Nota: newLISP mette a disposizione solo la funzione Error Function "erf":

****************
>>>funzione ERF
****************
syntax: (erf num)

erf calcola la funzione di errore del numero num.
La funzione di errore è definita come:

  erf(x) = 2/sqrt(pi) * integral from 0 to x of exp(-t^2) dt


--------------------------------------
Dragonfly: A web framework for newLISP
--------------------------------------

Dragonfly is a web framework for newLISP. 
Development started in June 2009. 
It focuses on speed, small memory consumption and a small learning curve. 
Other goodies are a plug and play architecture for writing own helpers or modules and a very easy deployment. 
It's possible to use it with the builtin newLISP webserver.

Source and download: https://github.com/taoeffect/dragonfly-newlisp

Please visit http://dragonfly.uberberg.com/ for more information.


-----------------------
Strada non intersecante
-----------------------

Dato una lista di punti, ordinarli in modo che, quando sono collegati in questo ordine, non si intersechino mai.
Per esempio:

              1     2     3     4     5     6
    punti = (2 2) (4 1) (1 4) (3 5) (6 3) (4 3)

      |     4
      | 3   *
      | *     6
      |       *  *
      |  *       5
      |  1   *2
      +----------------

Per risolvere il problema basta ordinare i punti in base alla coordinata x e alla coordinata y.

(define (line pts) (sort pts))

(setq punti '((2 2) (4 1) (1 4) (3 5) (6 3) (4 3)))
(line punti)
;-> ((1 4) (2 2) (3 5) (4 1) (4 3) (6 3))
Quindi la linea ha la sequenza di punti: 3-1-4-2-6-5.


--------------------
Bordo di una matrice
--------------------

Data una matrice di forma rettangolare mxn contenente numeri interi come input, estrarre i suoi bordi.
Le dimensioni m e n sono maggiori di 1.
La lista risultante deve partire dall'elemento 0,0 e proseguire in senso orario.
Per esempio:

 1 2 3
 4 5 6
 7 8 9  ==> 1 2 3 6 9 8 7 4

 4 7 8 8
 4 6 7 2
 1 2 7 9 ==> 4 7 8 8 2 9 7 2 1 4

Primo metodo (trasposta):

Prendiamo la prima e l'ultima riga della matrice e parte della prima e ultima riga della matrice trasposta

(setq m '((1 2 3) (4 5 6) (7 8 9)))

(setq rows (length m))
(setq cols (length (m 0)))
(reverse )
(setq t (transpose m))
;-> ((1 4 9) (2 5 8) (3 6 7))

(m 0)
;-> (1 2 3)
(slice (t -1) 1 (- rows 2))
;-> (6)
(m -1)
;-> (7 8 9)
(reverse (m -1))
;-> (9 8 7)
(reverse (slice (t 0) 1 (- rows 2)))
;-> (4)

(define (bordo matrix)
  (local (out rows cols t)
    (setq out '())
    (setq rows (length m))
    (setq cols (length (m 0)))
    (setq t (transpose matrix))
    (extend out (matrix 0)
                (slice (t -1) 1 (- rows 2))
                (reverse (matrix -1))
                (reverse (slice (t 0) 1 (- rows 2))))))

(setq m '((1 2 3)
          (4 5 6)
          (7 8 9)))

(bordo m)
;-> (1 2 3 6 9 8 7 4)

(setq m '((1 2 3 4 5)
          (3 4 3 6 7)
          (4 5 8 1 7)
          (8 3 1 0 9)
          (4 7 8 1 2)
          (4 4 5 3 9)
          (4 5 0 9 1)))
(bordo m)
;-> (1 2 3 4 5 7 7 9 2 9 1 9 0 5 4 4 4 8 4 3)

Secondo metodo (ciclo for):

(define (bordo1 matrix)
  (local (out rows cols t)
    (setq out '())
    (setq rows (length m))
    (setq cols (length (m 0)))
    (for (i 0 (- cols 1))
      (push (matrix 0 i) out -1))
    (for (i 1 (- rows 2))
      (push (matrix i (- cols 1)) out -1))
    (for (i (- cols 1) 0 -1)
      (push (matrix (- rows 1) i) out -1))
    (for (i (- rows 2) 1 -1)
      (push (matrix i 0) out -1))
 ))

(setq m '((1 2 3)
          (4 5 6)
          (7 8 9)))
(bordo1 m)
;-> (1 2 3 6 9 8 7 4)

(setq m '((1 2 3 4 5)
          (3 4 3 6 7)
          (4 5 8 1 7)
          (8 3 1 0 9)
          (4 7 8 1 2)
          (4 4 5 3 9)
          (4 5 0 9 1)))
(bordo1 m)
;-> (1 2 3 4 5 7 7 9 2 9 1 9 0 5 4 4 4 8 4 3)

=============================================================================

