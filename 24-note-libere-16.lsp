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
Vedi immagine "monopoli.png" nella cartella "data".

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

Sono sufficienti due cicli "for" per risolvere il problema.

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


--------------------------
Forum: OOP and inheritance
--------------------------

newBert:
--------
In chapter 17 of the NewLISP Manual (Object-Oriented Programming in newLISP) polymorphism is described clearly and simply.
That shows how NewLISP can adapt easily to apparently complex things...

I studied, with my poor knowledge and competence in computer science, the notion of inheritance and here is a little script which attempts to illustrate the question.

Please, would you critically examine it so as to let me know wether I've well understood the concept.

Nota: This code uses the earlier context-based way of doing OOP, which was found to have weaknesses (see Michael post).

#!/usr/bin/newlisp

(context 'rectangle)
; Class 'rectangle' with a constructor method
(define (rectangle:rectangle (width 30) (height 15))
   (set 'w width)
   (set 'h height)
   (set 'nam "rectangle"))

(define (perimeter)
   (string "(" w " + " h ") x 2 = " (mul (add w h) 2)))

(define (area)
   (string w " x " h " = " (mul w h)))

(define (measure)
   (println "A " nam " of " w " by " h)
   (println "has a surface area of " (area) ",")
   (println "and a perimeter of " (perimeter) ".\n"))

(context MAIN)

(context 'square)
; Class 'square' inherits from 'rectangle'
(new rectangle)
; Constructor of 'square'
(define (square:square (side 10))
   (set 'w side)
   (set 'h side)
   (set 'nam "square"))

(context MAIN)

; main program
(new rectangle 'fig1)
(fig1 27 12)
(fig1:measure)

(new square 'fig2)
(fig2 13)
(fig2:measure)

I think there is also a little polymorphism.
I don't use the colon operator there... yet it would be better, sorry ;)

cormullion:
-----------
Very good - clear and direct!

I wondered whether the first (context MAIN) was needed.
But in fact I think it demonstrates that (context 'square) isn't part of context rectangle although it inherits from it, neither is it a nested context (which don't exist...). So leaving it in is good!
cormullion

newBert:
--------
Yes, it was both intentional and conditioning by a distant practice of Basic or Basic-like language (with its 'block' ... 'end block', etc.).

I think it's just a little more readable.
And I would like to modify those definitions in a very NewLISP way, using lists and colon operator as described in the User Manual (chapter 17)... to compare clearness and efficiency.

m i c h a e l:
--------------
Hi newBert!
Inheritance can be used in a number of ways.
The one most commonly discussed is the "is a" type of inheritance (the one used in your code), which models a classification relationship between objects.
Mixins and implementation inheritance are two other types.

Your code uses the earlier context-based way of doing OOP, which was found to have weaknesses.

The way I would do that now is:

;; a rectangle constructor:
(define (rectangle:rectangle (width 30) (height 15)) (list rectangle width height))

;; a method defined using let to get the rectangle's width and height:
(define (rectangle:perimeter r)
   (let  (w (r 1) h (r 2)) (string "(" w " + " h ") x 2 = " (mul (add w h) 2)))
)

;; a method defined using straight indexing:
(define (rectangle:area r) (string (r 1) " x " (r 2) " = " (mul (add (r 1) (r 2)))))

;; a method defined using rectangle's area and perimeter methods:
(define (rectangle:measure r)
   (println "A " (r 0) " of " (r 1) " by " (r 2))
   (println "has a surface area of " (:area r) ", ")
   (println "and a perimeter of " (:perimeter r) ".\n")
)

;; a square is a rectangle
(new rectangle 'square)

;; a square constructor
(define (square:square (side 10)) (list square side side))

;; main program
(set 'fig1 (rectangle 27 12))
(:measure fig1)

(set 'fig2 (square 13))
(:measure fig2)

Programming this way takes a little getting used to, but once you do, it starts to feel a lot more nimble than heavier OOP frameworks (I never did grok Ocaml's object system).

P.S. I think Lutz mentioned somewhere on the club that (context MAIN) should be used before beginning a new context.
Sorry for not looking it up.

Fanda:
------
I could never abandon my version of OOP, so I wrote a new version:
http://www.intricatevisions.com/source/newlisp/oop.lsp

And using it:

(load "oop.lsp")

(set 'Rectangle
  (object ()
    width 30 height 15
    nam "rectangle"

    init (fn ((w 30) (h 15)) (set 'width w 'height h))
    perimeter (fn () (string "(" width " + " height ") x 2 = " (mul (add width height) 2)))
    area (fn () (string width " x " height " = " (mul width height)))
    measure (fn ()
     (println "A " nam " of " width " by " height)
     (println "has a surface area of " (area) ",")
     (println "and a perimeter of " (perimeter) ".\n"))
))

(set 'Square
  (object (Rectangle)
    nam "square"
    init (fn ((side 10)) (set 'width side 'height side))
))

;; main program
(set 'fig1 (obj-init Rectangle 27 12))
(obj-do 'fig1 (measure))

(set 'fig2 (obj-init Square 13))
(obj-do 'fig2 (measure))

I like it because it is compact and has a different feel to it.

newBert:
--------
m i c h a e l wrote:
Your code uses the earlier context-based way of doing OOP, which was found to have weaknesses.

I was aware of the weakness of my code. It was an adaptation of what I learnt about OOP through Python first. I like your version which is closer to the "newLISP spirit" than mine (which is perhaps just a little educational),

Fanda wrote:
I could never abandon my version of OOP ( ... )
I like it because it is compact and has a different feel to it.

and I like Fanda's version too, which is closer to OOP standard (so to speak), maybe a little clearer (particularly for a beginner), as we can see in language like Python, Rebol and probably others that I don't know ...

I'm going to study both ways trying to avoid dissipating my efforts.

In any case, thank you for your very interesting replies.

newdep:
-------
Fanda's ways is better because its indeed for the beginner more readable..

perhpas the newlisp manual needs this extention ->

;; The object initiation
;; is done by pre-defining the object-class.

(define object-class:object-class)

;; Now the object initiation with an object-class
;; defined in a list because that is OOP.
;; object-class is a context symbol!

(set 'object '(object-class "attribute and methods go here"))

;; A class function

(define (object-class:pick x) (x 1))

;; A polymorphism

(:pick object)

m i c h a e l:
--------------
There's no doubt in my mind I would have preferred Fanda's way of doing OOP when I first came to newLISP. I've struggled with many different ways of doing objects in this language (maybe six so far), but this latest way feels the most native to newLISP. An important part of this is that the objects are used functionally (without mutable state). Without this, it's not FOOP.

We are free to use any frameworks we wish in newLISP, including Fanda's. The problem with frameworks is they must be included (and maintained). So far, I've managed to get by without a framework.

So use whatever makes you happy (that's why we code in newLISP, isn't it?). As for me, I'll keep exploring FOOP, wherever it may lead :-)

P.S. I'm still working on the FOOP introduction and hope to have it finished soon!

Lutz:
-----
here: http://newlisp.org/index.cgi?page=newLISP-FOOP I have put together a page how FOOP came about and what makes it peculiar for newLISP.

newdep:
-------
Lutz wrote:
here: http://newlisp.org/index.cgi?page=newLISP-FOOP I have put together a page how FOOP came about and what makes it peculiar for newLISP.

Very clear and good paper Lutz!
and a special thanks to Micheal for his work!
(Micheals examples are a real mind mixer sometimes ..this is a compliment!..;-)

FOOP it is ;-)

newBert:
--------
m i c h a e l wrote:
We are free to use any frameworks we wish in newLISP, including Fanda's. The problem with frameworks is they must be included (and maintained). So far, I've managed to get by without a framework.

Yes I agree. This was a dilemna for me before...

Lutz:
-----
here: http://newlisp.org/index.cgi?page=newLISP-FOOP I have put together a page how FOOP came about and what makes it peculiar for newLISP.
...but Lutz's paper finishes convincing me there is a real NewLISP way (and modern way) of doing OOP.
Nevertheless Fanda's work is an interesting and concrete demonstration of what NewLISP is able to do and as far as it can go ...
I'm only a humble and occasional NewLISP user. I'm admiring before all your work. I take a lot of things but I'm incapable of returning so much with my modest contribution.
Thanks


-----------------
Codice efficiente
-----------------

Le autorità "Ministerie van Binnenlandse Zaken en Koninkrijksrelaties" (NL) - "Ministry of the Interior and Kingdom Relations" (EN) hanno rilasciato il codice sorgente della loro digid-app.

https://github.com/MinBZK/woo-besluit-broncode-digid-app

Ecco un pezzo di codice preso da:

https://github.com/MinBZK/woo-besluit-broncode-digid-app/blob/ad2737c4a039d5ca76633b81e9d4f3f9370549e4/Source/DigiD.iOS/Services/NFCService.cs

private static string GetPercentageRounds(double percentage)
{
    if (percentage == 0)
        return "⚪⚪⚪⚪⚪⚪⚪⚪⚪⚪";
    if (percentage > 0.0 && percentage <= 0.1)
        return "🔵⚪⚪⚪⚪⚪⚪⚪⚪⚪";
    if (percentage > 0.1 && percentage <= 0.2)
        return "🔵🔵⚪⚪⚪⚪⚪⚪⚪⚪";
    if (percentage > 0.2 && percentage <= 0.3)
        return "🔵🔵🔵⚪⚪⚪⚪⚪⚪⚪";
    if (percentage > 0.3 && percentage <= 0.4)
        return "🔵🔵🔵🔵⚪⚪⚪⚪⚪⚪";
    if (percentage > 0.4 && percentage <= 0.5)
        return "🔵🔵🔵🔵🔵⚪⚪⚪⚪⚪";
    if (percentage > 0.5 && percentage <= 0.6)
        return "🔵🔵🔵🔵🔵🔵⚪⚪⚪⚪";
    if (percentage > 0.6 && percentage <= 0.7)
        return "🔵🔵🔵🔵🔵🔵🔵⚪⚪⚪";
    if (percentage > 0.7 && percentage <= 0.8)
        return "🔵🔵🔵🔵🔵🔵🔵🔵⚪⚪";
    if (percentage > 0.8 && percentage <= 0.9)
        return "🔵🔵🔵🔵🔵🔵🔵🔵🔵⚪";

    return "🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵";
}

Commenti sul web:

https://www.reddit.com/r/ProgrammerHumor/comments/10dh6x1/very_efficient_code/

Versione newLISP

(define (percentage perc char1 char2)
  (local (piene vuote)
    (setq piene (int (add 0.5 (mul 10 perc))))
    (setq vuote (- 10 piene))
    (append (dup char1 piene) (dup char2 vuote))))

(percentage 0 "*" "·")
;-> "··········"
(percentage 1 "*" "·")
;-> "**********"
(percentage 0.63 "*" "·")
;-> "******····"


----------------
Interi eccessivi
----------------

Per un intero positivo n con la scomposizione in fattori primi n = p1^e1 * p2^e2 * ... pk^ek dove p1,...,pk sono numeri primi ed e1,...,ek sono numeri interi positivi, possiamo definire due funzioni:

  Ω(n) = e1+e2+...+ek il numero di divisori primi (contati con molteplicità).

Sequenza OEIS A001222:
  0, 1, 1, 2, 1, 2, 1, 3, 2, 2, 1, 3, 1, 2, 2, 4, 1, 3, 1, 3, 2, 2, 1, 4,
  2, 2, 3, 3, 1, 3, 1, 5, 2, 2, 2, 4, 1, 2, 2, 4, 1, 3, 1, 3, 3, 2, 1, 5,
  2, 3, 2, 3, 1, 4, 2, 4, 2, 2, 1, 4, 1, 2, 3, 6, 2, 3, 1, 3, ...

(define (big-omega num) (length (factor num)))

(map big-omega (sequence 1 10))
;-> (0 1 1 2 1 2 1 3 2 2)

  ω(n) = k il numero di divisori primi distinti.

Sequenza OEIS A001221:
0, 1, 1, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 2, 2, 1, 1, 2, 1, 2, 2, 2, 1, 2, 1,
2, 1, 2, 1, 3, 1, 1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 3, 1, 2, 2, 2, 1, 2, 1, 2,
2, 2, 1, 2, 2, 2, 2, 2, 1, 3, 1, 2, 2, 1, 2, 3, 1, 2, 2, 3, 1, ...

(define (omega num) (if (= num 1) 0 (length (unique (factor num)))))

(map omega (sequence 1 10))
;-> (0 1 1 1 1 2 1 1 1 2)

Con queste due funzioni definiamo l'eccesso e(n) = Ω(n) - ω(n).

Sequenza OEIS A046660:
0, 0, 0, 1, 0, 0, 0, 2, 1, 0, 0, 1, 0, 0, 0, 3, 0, 1, 0, 1, 0, 0, 0, 2, 1,
0, 2, 1, 0, 0, 0, 4, 0, 0, 0, 2, 0, 0, 0, 2, 0, 0, 0, 1, 1, 0, 0, 3, 1, 1,
0, 1, 0, 2, 0, 2, 0, 0, 0, 1, 0, 0, 1, 5, 0, 0, 0, 1, 0, 0, 0, ...

(define (excess num)
  (local (f u)
    (cond ((= num 1) 0)
          (true
          (setq f (factor num))
          (setq u (unique f))
          (- (length f) (length u))))))

(map excess (sequence 1 10))
;-> (0 0 0 1 0 0 0 2 1 0)

Per ogni numero n senza quadrati risulta e(n) = 0.
Quindi e(n) può essere considerata come una misura di quanto un numero sia vicino all'essere privo di quadrati.

Funzione che calcola i numeri senza quadrati fino ad un determinato numero:

(define (square-free limite)
  (let ((out '()))
    (for (i 1 limite)
      (if (zero? (excess i)) (push i out -1)))
    out))

(square-free 100)
;-> (1 2 3 5 6 7 10 11 13 14 15 17 19 21 22 23 26 29 30 31 33 34 35 37
;->  38 39 41 42 43 46 47 51 53 55 57 58 59 61 62 65 66 67 69 70 71 73
;->  74 77 78 79 82 83 85 86 87 89 91 93 94 95 97)


--------------------------------
Ricerca di un numero sconosciuto
--------------------------------

Supponiamo che ci sia un numero naturale sconosciuto finito N (big integer) e una funzione comp(x) che restituisce true se x <= N.
Scrivere un programma per determinare N minimizzando il numero di chiamate a "comp".
Poichè il numero minimo di chiamate dipende dalla distribuzione di probabilità dei possibili valori di N, si assume per N una distribuzione uniforme.

Un possibile metodo è il seguente:
- Aumentare la nostra stima finché non si supera N.
- Eseguire una ricerca binaria.

Ma cosa intendiamo per "aumentare" la stima?
In che modo la aumentiamo?
Un approccio ragionevole è quello di raddoppiare la stima, ma per numeri molto grandi potremmo utilizzare un aumento più consistente (moltiplicare per 10, fare il quadrato, ecc.). In questi casi occorre modificare il metodo di ricerca binaria (perchè il numero iniziale (low = high / 2) potrebbe essere superiore a N)

Numero sconosciuto:

(setq *N* 1234567890L)

Funzione "comp":

(define (comp x) (<= x *N*))

Funzione "guess":

(define (guess)
  (local (low high mid call)
    (setq call 0)
    ; stima iniziale
    (setq high 1L)
    ; raddoppia fino a che high che non supera *N*
    (while (comp high) (setq high (* high 2)) (++ call))
    ; ricerca binaria
    (setq low (/ high 2))
    (while (< low (- high 1)) ; low <= *N* < high (invariante)
      (setq mid (/ (+ low high) 2))
      (if (comp mid)
          (setq low mid)
          (setq high mid)
      )
      (++ call)
    )
    (list low call)))

Facciamo alcune prove:

(setq *N* 128)
(guess)
;-> (128L 15)

(setq *N* 872134762347L)
(guess)
;-> (872134762347L 79)

(setq *N* 2738372163489234712761872134762347L)
(guess)
;-> (2738372163489234712761872134762347L 223)

(setq *N* 100000000000000000000000000000000000000000000000000000000L)
(guess)
;-> (100000000000000000000000000000000000000000000000000000000L 373)

Nota: Il numero di bit nella rappresentazione binaria di *N* è l'optimum teorico delle chiamate a "comp" (se si dispone solo di un confronto binario).

Funzione che calcola la rappresentazione binaria di un numero intero (big-integer):

(setq MAXINT (** 2 62))
;-> 4611686018427387904L

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (prep s) (string (dup "0" (- 62 (length s))) s))

(define (bitsL n)
    (if (<= n MAXINT) (bits (int n))
      (string (bitsL (/ n MAXINT))
              (prep (bits (int (% n MAXINT)))))))

(length (bitsL 872134762347L))
;-> 40
(length (bitsL 2738372163489234712761872134762347L))
;-> 112
(length (bitsL 100000000000000000000000000000000000000000000000000000000L))
;-> 187


--------------------
Liste insignificanti
--------------------

Una lista insignificante (non significativa) è una lista di numeri interi positivi, in cui le differenze assolute tra elementi consecutivi sono tutte minori o uguali a 1.

Ad esempio, la seguente lista è insignificante: (1 2 3 4 3 4 5 5 5 4)
Perché le corrispondenti differenze (assolute) sono: (1 1 1 1 1 1 0 0 1)
Che sono tutti minori o uguali a 1.

Scrivere una funzione per determinare se una lista è insignificante.
Si può presumere che la lista contiene sempre almeno due elementi.

Test case:
Input                   ->   Output
(1 2 3 4 3 4 5 5 5 4)   ->   true
(1 2 3 4 5 6 7 8 9 8)   ->   true
(3 3 3 3 3 3 3)         ->   true
(3 4 4 4 3 3 3 4 4 4)   ->   true
(1 2 3 4)               ->   true
(5 4 3 2)               ->   true
(1 3 5 7 9 7 5 3 1)     ->   nil
(1 1 1 2 3 4 5 6 19)    ->   nil
(3 4 5 6 7 8 7 5)       ->   nil
(1 2 4 10 18 10 100)    ->   nil
(10 20 30 30 30)        ->   nil

https://codegolf.stackexchange.com/questions/143278/am-i-an-insignificant-array

Versione Golfed (61 char):

(for-all true?(map(fn(x y)(<(abs(- y x))2))(rest a)(chop a)))

Versione Ungolfed:

(define (ungolf lst)
  (for-all true? (map (fn(x y) (< (abs (- y x)) 2) ) (rest lst) (chop lst))))

(ungolf '(1 2 3 4 3 4 5 5 5 4)) ;-> true
(ungolf '(1 2 3 4 5 6 7 8 9 8)) ;-> true
(ungolf '(3 3 3 3 3 3 3))       ;-> true
(ungolf '(3 4 4 4 3 3 3 4 4 4)) ;-> true
(ungolf '(1 2 3 4))             ;-> true
(ungolf '(5 4 3 2))             ;-> true
(ungolf '(1 3 5 7 9 7 5 3 1))   ;-> nil
(ungolf '(1 1 1 2 3 4 5 6 19))  ;-> nil
(ungolf '(3 4 5 6 7 8 7 5))     ;-> nil
(ungolf '(1 2 4 10 18 10 100))  ;-> nil
(ungolf '(10 20 30 30 30))      ;-> nil


-------------------------------------------------
Operatore di confronto a tre vie "<=>" sui numeri
-------------------------------------------------

Scrivere una funzione che, quando vengono dati due numeri dello stesso tipo a e b, faccia quanto segue:

  se a < b, restituisce -1.
  se a = b, restituisce 0.
  se a > b, restituisce 1.

(define (<=> a b) (cond ((< a b) -1) ((= a b) 0) ((> a b) 1)))

(<=> 21 42)
;-> -1
(<=> 42 21)
;-> 1
(<=> 77 77)
;-> 0


---------------
Quadrati latini
---------------

Un quadrato latino è una griglia NxN riempita da n numeri distinti, ognuno dei quali appare esattamente una volta in ogni riga e colonna.
Dato un input N, dobbiamo creare una matrice NxN costituita da numeri da 1 a N ciascuno che compare esattamente una volta in ogni riga e in ogni colonna.
Esempi:

N: 3
quadrato latino: 1 2 3
        3 1 2
        2 3 1

N: 5
quadrato latino: 1 2 3 4 5
                 5 1 2 3 4
                 4 5 1 2 3
                 3 4 5 1 2
                 2 3 4 5 1

Un semplice algoritmo per creare un quadrato latino è il seguente:
 - Nella prima riga, i numeri sono memorizzati da 1 a n in modo sequenziale.
 - Nella seconda riga, i numeri vengono spostati a destra di una colonna (cioè, 1 è memorizzato nella seconda colonna ora e così via).
 - Nella terza riga, i numeri vengono spostati a destra di due colonne (cioè, 1 è memorizzato nella terza colonna ora e così via).
 - Continuare allo stesso modo per le restanti righe.

Nota: potrebbe esistere più di una configurazione possibile per un quadrato latino nxn.

(define (latin num)
  (let ( (out '()) (row '()) )
    (setq row (sequence 1 num))
    (push row out -1)
    (for (r 1 (- num 1))
      (push (rotate row) out -1)
    )
    out))

(latin 5)
;-> ((1 2 3 4 5) (5 1 2 3 4) (4 5 1 2 3) (3 4 5 1 2) (2 3 4 5 1))

(latin 12)
;-> ((1 2 3 4 5 6 7 8 9 10 11 12)
;->  (12 1 2 3 4 5 6 7 8 9 10 11)
;->  (11 12 1 2 3 4 5 6 7 8 9 10)
;->  (10 11 12 1 2 3 4 5 6 7 8 9)
;->  (9 10 11 12 1 2 3 4 5 6 7 8)
;->  (8 9 10 11 12 1 2 3 4 5 6 7)
;->  (7 8 9 10 11 12 1 2 3 4 5 6)
;->  (6 7 8 9 10 11 12 1 2 3 4 5)
;->  (5 6 7 8 9 10 11 12 1 2 3 4)
;->  (4 5 6 7 8 9 10 11 12 1 2 3)
;->  (3 4 5 6 7 8 9 10 11 12 1 2)
;->  (2 3 4 5 6 7 8 9 10 11 12 1))


--------------
Numeri sublimi
--------------

Un numero perfetto è un numero intero positivo la cui somma dei divisori (eccetto se stesso) è uguale a se stesso. Per esempio. 6 (1 + 2 + 3 = 6) e 28 (1 + 2 + 4 + 7 + 14 = 28) sono perfetti.

Un numero sublime è un numero intero positivo il cui conteggio e somma dei divisori (incluso se stesso) sono entrambi perfetti.
Per esempio. 12 è un numero sublime perché:

  i divisori di 12 sono 1, 2, 3, 4, 6, 12
  il conteggio dei divisori è 6 (perfetto)
  la somma dei divisori è 28 (perfetto)

Il successivo numero sublime più piccolo conosciuto è:

6086555670238378989670371734243169622657830773351885970528324860512791691264

e questi due numeri sono gli unici numeri sublimi conosciuti nel 2022.

Sequenza OEIS A081357:
2, 6086555670238378989670371734243169622657830773351885970528324860512791691264

Scomponiamo il numero in fattori  primi:

(time (println (setq f (factor-i 6086555670238378989670371734243169622657830773351885970528324860512791691264))))
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 7L 31L 127L 524287L 2147483647L 2305843009213693951L)
;->  253865.791 ; 4m 13s 865ms

(setq f '(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
 2L 2L 2L 2L 2L 2L 7L 31L 127L 524287L 2147483647L 2305843009213693951L))

Le seguenti funzioni prendono come argomento la lista dei fattori di un numero (in forma estesa)
(Accettano anche con i big-integer).

lst = lista dei fattori del numero

Raggruppa i fattori (RLE):

(define (raggruppa-fattori lst)
  (letn (unici (unique lst))
    (transpose (list unici (count unici lst)))))

(raggruppa-fattori f)
;-> ((2L 126) (7L 1) (31L 1) (127L 1) (524287L 1)
;->  (2147483647L 1) (2305843009213693951L 1))

Conta i divisori:

(define (conta-divisori lst)
  (let (lst (raggruppa-fattori lst))
    (apply * (map (fn(x) (+ 1L (last x))) lst))))

(conta-divisori f)
;-> 8128

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Somma i divisori:

(define (somma-divisori lst)
  (local (sum out)
    (setq out 1L)
    (setq lst (raggruppa-fattori lst))
    (dolist (el lst)
      (setq sum 0L)
      (for (i 0 (last el))
        (setq sum (+ sum (** (first el) i)))
      )
      (setq out (* out sum)))))

(somma-divisori f)
;-> 14474011154664524427946373126085988481573677491474835889066354349131199152128

Lista dei divisori:

(define (divisors lst)
  (local (f out)
    (setq f (raggruppa-fattori lst))
    (setq out '())
    (divisors-aux 0L 1L)
    (sort out)))
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

(length (divisors f))
;-> 8128

Sommiamo i divisori:

(setq sum 0L)
(dolist (el (divisors f)) (setq sum (+ sum el)))
;-> 14474011154664524427946373126085988481573677491474835889066354349131199152128L

I numeri 8128 e 14474011154664524427946373126085988481573677491474835889066354349131199152128 sono perfetti.


-------------------
Checksum alfabetico
-------------------

Data una stringa di lettere minuscole, calcolare il "checksum alfabetico" di quella stringa.

Esempio:
Prendiamo la stringa "helloworld".
Con a = 0, b = 1, c = 2 ... z = 25, possiamo sostituire tutte le lettere con numeri:

  h  e  l  l  o  w  o  r  l  d
  7  4  11 11 14 22 14 17 11 3

Ora, possiamo sommare questi numeri:

  7+4+11+11+14+22+14+17+11+3 = 114

Se applichiamo il modulo 26, otteniamo:

  114 % 26 = 10

Ora, utilizzando lo stesso sistema di numerazione di prima, otteniamo la decima lettera, k.
Questo è il checksum alfabetico di "helloworld".

Vediamo alcuni esempi:

  stringa          checksum
  -------          --------
  helloworld       k
  abcdef           p
  newlisp          n
  codegolf         h
  aaaaa            a
  zzzzz            v

Supponiamo che la stringa sia composta solo da lettere minuscole:
("a" = 97, "z" = 122)

Funzione di checksum alfabetico:

(define (checksum str)
  (char (+ 97 (% (apply + (map (fn(x) (- (char x) 97)) (explode str))) 26))))

(setq lst '("helloworld" "abcdef" "newlisp" "codegolf" "aaaaa" "zzzzz"))

(map checksum lst)
;-> ("k" "p" "n" "h" "a" "v")

Come funziona?

(setq str "newlisp")

(explode str)
;-> ("n" "e" "w" "l" "i" "s" "p")

(map (fn(x) (- (char x) 97)) '("n" "e" "w" "l" "i" "s" "p"))
;-> (13 4 22 11 8 18 15)

(apply + '(13 4 22 11 8 18 15))
;-> 91

(% 91 26)
;-> 13

(+ 97 13)
;-> 110

(char 110)
;-> "n"

Adesso scriviamo una funzione di checksum alfabetico che utilizza tutti i caratteri ASCII stampabili (32-126).

(for (i 32 126) (print (char i) { }))
;->   ! " # $ % & ' ( ) * + , - . / 0 1 2 3 4 5 6 7 8 9 : ; < = > ? @
;-> A B C D E F G H I J K L M N O P Q R S T U V W X Y Z [ \ ] ^ _ `
;-> a b c d e f g h i j k l m n o p q r s t u v w x y z { | } ~

In tutto sono (126 - 32 + 1) = 95 caratteri

(define (check-alpha str)
  (char (+ 32 (% (apply + (map (fn(x) (- (char x) 32)) (explode str))) 95))))

(check-alpha "newlisp")
;-> "g"
(check-alpha "newLISP")
;-> "F"
(check-alpha "Hello World!!")
;-> "E"


--------------------------
Anti-divisori di un numero
--------------------------

Gli anti-divisori sono i numeri che non dividono un numero per il margine più ampio possibile.
Per esempio, 20 ha anti-divisori 3, 8 e 13.

Definizione:
Se un numero dispari i nell'intervallo 1 < i <= n divide N dove N è uno qualsiasi tra 2n-1, 2n o 2n+1 allora d = N/i è chiamato anti-divisore di n. I numeri 1 e 2 non hanno anti-divisori.

Equivalentemente, un anti-divisore di n è un numero d nell'intervallo [2,n-1] che non divide n ed è un divisore (necessariamente dispari) di 2n-1 o 2n+1, oppure un divisore (necessariamente pari) ) divisore di 2n.
Quindi un antidivisore di n è un intero d in [2,n-1] tale che n == (d-1)/2, d/2, o (d+1)/2 (mod d), il la classe di d è rispettivamente -1, 0 o 1.

Equivalentemente, k è un anti-divisore di n se e solo se 1 < k < n e | (n mod k) - k/2 | < 1.

Sequenza OEIS A006272: Numero di anti-divisori di n (n > 0)
  0, 0, 1, 1, 2, 1, 3, 2, 2, 3, 3, 2, 4, 3, 3, 2, 5, 4, 3, 3, 3, 5, 5,
  2, 5, 3, 5, 5, 3, 3, 5, 6, 5, 3, 5, 2, 5, 7, 5, 4, 4, 5, 5, 3, 7, 5,
  5, 3, 6, 6, 3, 7, 7, 3, 5, 3, 5, 7, 7, 6, 4, 5, 7, 2, 5, 5, 9, 7, 3, ...

Funzione che crea la lista degli anti-divisori di un numero intero positivo:

(define (anti-divisors num)
  (cond ((< num 3) '())
    (true
      (let (out '())
        (for (k 2 (- num 1))
          (if (< (abs (sub (mod num k) (div k 2))) 1)
              (push k out -1)
          )
        )
        out))))

(anti-divisors 20)
;-> (3 8 13)

(anti-divisors 325)
;-> (2 3 7 10 11 21 26 31 50 59 93 130 217)

(map anti-divisors (sequence 1 20))
;-> (() () (2) (3) (2 3) (4) (2 3 5) (3 5) (2 6) (3 4 7)
;->  (2 3 7) (5 8) (2 3 5 9) (3 4 9) (2 6 10)
;->  (3 11) (2 3 5 7 11) (4 5 7 12) (2 3 13) (3 8 13))

Verifica della sequenza OEIS:

(map (fn(x) (length (anti-divisors x))) (sequence 1 25))
;-> (0 0 1 1 2 1 3 2 2 3 3 2 4 3 3 2 5 4 3 3 3 5 5 2 5)


--------------------------------
Stringa con caratteri mascherati
--------------------------------

Data una stringa con caratteri mascherati, generare tutte le parole possibili, utilizzando tutti i caratteri di un'altra stringa.
La stringa con i caratteri mascherati contiene solo lettere minuscole.
La stringa con i caratteri sostitutivi contiene solo lettere maiuscole.

Per esempio:
stringa 1 = "l-s-"
stringa 2 = "AEIOUSP"

Lista da creare:
(lAsA lEsA lIsA lOsA lUsA lSsA lPsA lAsE lEsE lIsE lOsE lUsE lSsE lPsE
 lAsI lEsI lIsI lOsI lUsI lSsI lPsI lAsO lEsO lIsO lOsO lUsO lSsO lPsO
 lAsU lEsU lIsU lOsU lUsU lSsU lPsU lAsS lEsS lIsS lOsS lUsS lSsS lPsS
 lAsP lEsP lIsP lOsP lUsP lSsP lPsP)

Per generare tutte le modifiche utilizziamo le permutazioni con ripetizione.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Funzione che genera tutte le parole possibili:

(define (unmask str1 str2)
  (local (indici masked changes out)
    (setq out '())
    ; indici degli elementi mascherati (da sostituire) in str1
    (setq indici (flat (ref-all "-" (explode str1))))
    ; numero di elementi mascherati
    (setq masked (length indici))
    ; lista dei cambiamenti
    (setq changes (perm-rep masked (explode str2)))
    ; creazione delle stringhe senza elementi mascherati
    ; ciclo per ogni elemento in changes
    (dolist (el changes)
      ; modifica la stringa corrente
      (dolist (ind indici)
        (setf (str1 ind) (upper-case (el $idx)))
      )
      (push str1 out -1)
    )
    out))

Facciamo un paio di prove:

(setq s1 "l-s-")
(setq s2 "AEIOUSP")

(unmask s1 s2)
;-> ("lAsA" "lEsA" "lIsA" "lOsA" "lUsA" "lSsA" "lPsA" "lAsE" "lEsE" "lIsE"
;->  "lOsE" "lUsE" "lSsE" "lPsE" "lAsI" "lEsI" "lIsI" "lOsI" "lUsI" "lSsI"
;->  "lPsI" "lAsO" "lEsO" "lIsO" "lOsO" "lUsO" "lSsO" "lPsO" "lAsU" "lEsU"
;->  "lIsU" "lOsU" "lUsU" "lSsU" "lPsU" "lAsS" "lEsS" "lIsS" "lOsS" "lUsS"
;->  "lSsS" "lPsS" "lAsP" "lEsP" "lIsP" "lOsP" "lUsP" "lSsP" "lPsP")

(setq s1 "n-wl-sp")
(setq s2 "aeiou")

(unmask s1 s2)
;-> ("nAwlAsp" "nEwlAsp" "nIwlAsp" "nOwlAsp" "nUwlAsp" "nAwlEsp" "nEwlEsp"
;->  "nIwlEsp" "nOwlEsp" "nUwlEsp" "nAwlIsp" "nEwlIsp" "nIwlIsp" "nOwlIsp"
;->  "nUwlIsp" "nAwlOsp" "nEwlOsp" "nIwlOsp" "nOwlOsp" "nUwlOsp" "nAwlUsp"
;->  "nEwlUsp" "nIwlUsp" "nOwlUsp" "nUwlUsp")


--------------------
Colori complementari
--------------------

Dato un colore, il suo colore complementare è il colore che si trova in posizione opposta nella ruota dei colori (ruota cromatica).
Esistono due tipi di ruote cromatiche: quella che usa una tecnica di combinazione dei colori additiva e quella che usa una tecnica sottrattiva.
Quindi esistono colori primari additivi (rosso, verde e blu) e colori primari sottrattivi (ciano, magenta e giallo).
In genere il metodo sottrattivo viene usato in pittura, mentre il metodo additivo viene usato dai computer.

Vediamo un semplice algoritmo per calcolare il colore complementare di un dato colore RGB (R,G,B):
1) trasformare il colore dato nello spazio HSV,
2) sommare a Hue (Tinta) un angolo piatto (180 gradi)
3) ritrasformare questo colore HSV nello spazio RGB.

Funzioni RGB <--> HSV:

(define (rgb2hsv r g b)
  (local (h s v var-r var-g var-b var-min var-max del-max del-r del-g del-b)
    (setq var-r (div r 255))
    (setq var-g (div g 255))
    (setq var-b (div b 255))
    (setq var-min (min var-r var-g var-b)) ; valore minimo di RGB
    (setq var-max (max var-r var-g var-b)) ; valore massimo di RGB
    (setq del-max (sub var-max var-min))   ; delta RGB
    (setq v var-max)
    (cond ((= 0 del-max) (setq h 0) (setq s 0)) ; tono di grigio
           (true ; colore
              (setq s (div del-max var-max))
              (setq del-r (div (add (div (sub var-max var-r) 6) (div del-max 2)) del-max))
              (setq del-g (div (add (div (sub var-max var-g) 6) (div del-max 2)) del-max))
              (setq del-b (div (add (div (sub var-max var-b) 6) (div del-max 2)) del-max))
              (cond ((= var-r var-max) (setq h (sub del-b del-g)))
                    ((= var-g var-max) (setq h (add (div 1 3) (sub del-r del-b))))
                    ((= var-b var-max) (setq h (add (div 2 3) (sub del-g del-r))))
                    (true println "errore")
              )
              (if (< h 0) (setq h (add 1 h)))
              (if (> h 1) (setq h (sub 1 h)))
           );end true
    )
    (list h s v)))

(define (hsv2rgb h s v)
  (local (r g b var-h var-i var-1 var-2 var-3 var-4 var-r var-g var-b)
    (cond ((= 0 s) (setq r (mul v 255)) (setq g (mul v 255)) (setq b (mul v 255)))
          (true
             (setq var-h (mul h 6))
             (if (= var-h 6) (setq var-h 0)) ; h deve essere minore di 1
             (setq var-i (floor var-h))
             (setq var-1 (mul v (sub 1 s)))
             (setq var-2 (mul v (sub 1 (mul s (sub var-h var-i)))))
             (setq var-3 (mul v (sub 1 (mul s (sub 1 (sub var-h var-i))))))
             (cond ((= 0 var-i) (setq var-r v)     (setq var-g var-3) (setq var-b var-1))
                   ((= 1 var-i) (setq var-r var-2) (setq var-g v)     (setq var-b var-1))
                   ((= 2 var-i) (setq var-r var-1) (setq var-g v)     (setq var-b var-3))
                   ((= 3 var-i) (setq var-r var-1) (setq var-g var-2) (setq var-b v))
                   ((= 4 var-i) (setq var-r var-3) (setq var-g var-1) (setq var-b v))
                   (true        (setq var-r v    ) (setq var-g var-1) (setq var-b var-2))
             )
             (setq r (mul var-r 255))
             (setq g (mul var-g 255))
             (setq b (mul var-b 255))
          )
    );end cond
    (list r g b)))

R, G e B range = 0 ÷ 255
H, S e V range = 0 ÷ 1.0

(define (complement r g b)
  (local (h s v h2)
    (setq hsv (rgb2hsv r g b))
    (map set '(h s v) (rgb2hsv r g b))
    ;(println h { } s { } v)
    ; Hue (tinta) è normalizzato fra 0 e 1
    ; per calcolare l'angolo opposto sommare o sottrarre mezzo giro (0.5).
    (if (> h 0.5)
        (setq h2 (sub h 0.5))
        (setq h2 (add h 0.5))
    )
    (hsv2rgb h2 s v)))

(complement 49 221 173)
;-> (221 49 97.00000000000009)

(apply complement '(49 221 173))
;-> (221 49 97.00000000000009)

(complement 221 49 97)
;-> (49 221 173.0000000000001)

(apply complement '(221 49 97))
;-> (49 221 173.0000000000001)

(setq colors (explode (rand 256 30) 3))
;-> ((0 144 49) (207 149 122) (89 229 210) (191 44 219) (181 131 77)
;->  (3 23 93) (37 42 253) (114 30 1) (2 96 136) (146 154 155))

(map (fn(x) (apply complement x)) colors)
;-> ((144 0 95) (122 180 207) (229 89 108) (72 219 44) (77 127 181)
;->  (93 73 3) (253 248 37) (1 85 114) (136 42 2) (155 147 146))

Vedere il file "complementari.png" nella cartella "data".


-------------------------------
Sequenza "Fly straight, dammit"
-------------------------------

"Fly straight, dammit" (OEIS A133058) è una sequenza di numeri interi, che ha queste regole:

  a0 = a1 = 1

         | a(n-1) + n + 1, se gcd(a(n-1),n) = 1
  a(n) = |
         | a(n) = a(n-1)/gcd(a(n-1),n), se gcd(a(n-1),n) != 1

Sequenza OEIS A133058:
  1, 1, 4, 8, 2, 8, 4, 12, 3, 1, 12, 24, 2, 16, 8, 24, 3, 21, 7, 27, 48, 16,
  8, 32, 4, 30, 15, 5, 34, 64, 32, 64, 2, 36, 18, 54, 3, 41, 80, 120, 3, 45,
  15, 59, 104, 150, 75, 123, 41, 91, 142, 194, 97, 151, 206, 262, 131, 189, ...

Dopo n=638, la sequenza genera quattro linee rette e si assesta diventando quasi periodica.

"Whenever I look at this sequence I am reminded of the great "Fly straight, dammit" scene in the movie "Avatar"."
N. J. A. Sloane

Versione ricorsiva:

(define (fly n)
  (cond ((or (zero? n) (= n 1)) 1)
        (true
          (if (= (gcd (fly (- n 1)) n) 1)
              (+ (fly (- n 1)) n 1)
              (/ (fly (- n 1)) (gcd (fly (- n 1)) n))))))

(time (println (map fly (sequence 1 22))))
;-> (1 4 8 2 8 4 12 3 1 12 24 2 16 8 24 3 21 7 27 48 16 8)
;-> 68087.971

Versione iterativa:

(define (fly2 n)
  (local (prev mcd)
    ; Valore precedente (a[n-1])
    (setq prev 1)
    (if (and (!= n 0) (!= n 1))
        ; ciclo da 2 a n
        (for (i 2 n)
          ; GCD del valore precedente e i
          (setq mcd (gcd prev i))
          ; Se GCD = 1,
          (if (= mcd 1)
            ; Incrementa il valore precedente di (i+1)
            (setq prev (+ prev i 1))
            ; altrimenti
            ; Imposta il valore precedente a se stesso diviso GCD
            (setq prev (/ prev mcd))
          )
        )
    )
    prev))

(time (println (map fly2 (sequence 1 22))))
;-> (1 4 8 2 8 4 12 3 1 12 24 2 16 8 24 3 21 7 27 48 16 8)
;-> 1.994

(map fly2 (sequence 638 700))
;-> (1 641 1282 2 1 645 1290 2 1 649 1298 2 1 653 1306 2 1 657 1314 2 1 661
;->  1322 2 1 665 1330 2 1 669 1338 2 1 673 1346 2 1 677 1354 2 1 681 1362
;->  2 1 685 1370 2 1 689 1378 2 1 693 1386 2 1 697 1394 2 1 701 1402)


-------------------------------------------------------------------
Valutazione di semplici espressioni matematiche (notazione infissa)
-------------------------------------------------------------------

La notazione infissa è la comune notazione logica e matematica, nella quale gli operatori sono scritti tra gli operandi su cui agiscono (per es. 2 + 2).
Nella notazione infissa le parentesi che circondano gruppi di operandi e operatori sono necessarie per indicare l'ordine desiderato delle operazioni. In assenza delle parentesi, entrano in causa delle regole di precedenza degli operatori per determinare l'ordine delle operazioni da applicare agli operandi.

Per convertire una notazione infissa in una postfissa è possibile utilizzare l'algoritmo "Shunting Yard" di Edgar Dijkstra.

Questo algoritmo prende come input un'espressione infissa e produce una coda che ha questa espressione convertita in notazione postfissa.
Lo stesso algoritmo può essere modificato per calcolare il risultato della valutazione dell'espressione invece di produrre una coda.
Per fare questo occorre usare due stack, uno per gli operandi e uno per gli operatori.

L'algoritmo è il seguente:

1. Affinchè ci sono ancora token da leggere,
   1.1 Ottieni il token successivo.
   1.2 Se il token è:
       1.2.1 Un numero: inseriscilo nella pila dei valori.
       1.2.2 Una variabile: ricavare il valore e inseriscilo nella pila dei valori.
       1.2.3 Una parentesi aperta: inseriscila nella pila degli operatori.
       1.2.4 Una parentesi chiusa:
         a) Affinchè il token in cima alla pila degli operatori non è una parentesi aperta,
            1 Pop l'operatore dalla pila degli operatori.
            2 Pop la pila di valori due volte, ottenendo due operandi.
            3 Applicare l'operatore agli operandi, nell'ordine corretto.
            4 Push il risultato nella pila dei valori.
         b) Estrarre la parentesi aperta dalla pila degli operatori e scartarla.
       1.2.5 Un operatore (chiamalo thisOp):
         a) Affinchè la pila degli operatori non è vuota,
            e il token in cima alla pila di operatori ha la stessa
            o maggiore precedenza di thisOp,
            1 Pop l'operatore dalla pila degli operatori.
            2 Pop la pila di valori due volte, ottenendo due operandi.
            3 Applicare l'operatore agli operandi, nell'ordine corretto.
            4 Push il risultato nella pila dei valori.
         b) Push thisOp sullo pila degli operatori.
2. Affinchè la pila degli operatori non è vuota,
     1 Pop l'operatore dalla pila degli operatori.
     2 Pop la pila di valori due volte, ottenendo due operandi.
     3 Applicare l'operatore agli operandi, nell'ordine corretto.
     4 Push il risultato nella pila dei valori.
3. A questo punto la pila degli operatori dovrebbe essere vuota e la pila
   dei valori dovrebbe contenere un solo valore, che è il risultato finale.

Per semplicità scriviamo una implementazione che ha le seguenti limitazioni:
- l'espressione deve essere ben formata (nessun controllo di correttezza)
- solo operazioni binarie (due operandi e un operatore)
- solo numeri interi
- solo le quattro operazioni +,-,*,/.
- solo parentesi tonde
- senza parentesi si applicano le comuni regole di precedenza
  (* e / hanno priorità maggiore di + e -).

Notare che i numeri negativi devono essere scritti come operazione binaria:
  -2  --> (0 - 2)
  -10 --> (0 - 10)

Funzione per calcolare la precedenza degli operatori:

(define (precedence op)
  (cond ((or (= op "+") (= op "-")) 1)
        ((or (= op "*") (= op "/")) 2)
        (true 0)))

Funzione che applica le operazioni aritmetiche:

(define (apply-op a b op)
  (cond ((= op "+") (+ a b))
        ((= op "-") (- a b))
        ((= op "*") (* a b))
        ((= op "/") (/ a b))))

Funzione che verifica se un carattere è una cifra:

(define (digit? ch) (and (>= ch "0") (<= ch "9")))

Funzione che implementa l'algoritmo Shunting yard (semplificato)::

(define (evaluate expr)
  (local (values ops i val val1 val2 op i)
    ; pila dei valori (stack)
    (setq values '())
    ; pila delle operazioni (stack)
    (setq ops '())
    ; Rimuove gli spazi dall'espressione
    (replace " " expr "")
    ; indice
    (setq i 0)
    ; parsing dell'espressione
    (while (< i (length expr))
            ; token = "(", parentesi aperta
      (cond ((= (expr i) "(")
              ; inserisce "(" nelle operazioni
              (push (expr i) ops))
            ; token = cifra
            ((digit? (expr i))
              ; legge il numero e poi lo mette nei valori
              (setq val 0)
              (while (and (< i (length expr)) (digit? (expr i)))
                (setq val (+ (* val 10) (int (expr i) 0 10)))
                (++ i)
              )
              (push val values)
              (-- i))
            ; token = ")", parentesi chiusa
            ((= (expr i) ")")
              ; risolve l'espressione tra parentesi
              (while (and (!= (length ops) 0) (!= (ops 0) "("))
                (setq val2 (pop values))
                (setq val1 (pop values))
                (setq op (pop ops))
                (push (apply-op val1 val2 op) values)
              )
              (pop ops)) ; rimuove "()"
            ; token = operatore
            (true
              ; applica l'operatore ai primi due numeri dei valori
              (while (and (!= (length ops) 0)
                          (>= (precedence (ops 0)) (precedence (expr i))))
                (setq val2 (pop values))
                (setq val1 (pop values))
                (setq op (pop ops))
                (push (apply-op val1 val2 op) values)
              )
              ; inserisce operatore nelle operazioni
              (push (expr i) ops)) ;opening brackets
      )
      (++ i)
   )
   ; il parsing dell'espressione è terminato
   ; applichiamo le rimanenti operazioni
   (while (!= (length ops) 0)
     (setq val2 (pop values))
     (setq val1 (pop values))
     (setq op (pop ops))
     (push (apply-op val1 val2 op) values)
   )
   ; risultato finale
   (values 0)))

Facciamo alcune prove:

(evaluate "100 * ( 2 + 12 ) / (13+1)*1")
;-> 100
(evaluate "(3*2)+(4*1)*(4 * (0 - 2))")
;-> -26
(evaluate "3*2+4*1+4*2")
;-> 18
(evaluate "(2+3*2)")
;-> 8
(evaluate "(2+3*2")
;-> nil

Adesso scriviamo una funzione che crea una mini-repl che agisce come una calcolatrice per espressioni infisse:
("quit" per uscire):

(define (calc)
  (let ((expr "") (run true))
    (while run
      (print ">> ")
      (setq expr (read-line))
      (cond ((= expr "quit") (setq run nil))
            (true (catch (evaluate expr) 'out)
                  (println "--> " out))))))

Vediamo come funziona:

(calc)
;-> >>
(2+3)
;--> 5
((4 + 2) * (2 + 1) - 7)
;--> 11
(0 - 25)*(0 - 31)
;--> 775
quit
;-> nil


-------------------------------------------------
Suggerimenti per la denominazione delle variabili
-------------------------------------------------

Una citazione famosa afferma che ci sono solo due cose difficili nell'informatica:
l'invalidazione della cache e la denominazione delle cose (variabili, funzioni, oggetti, classi,...)

Lasciamo stare l'invalidazione della cache e vediamo alcuni suggerimenti per migliorare il modo con cui si nominano le variabili di un programma.
Nota: per "variabile" intendiamo anche le funzioni, gli oggetti, le classe, ecc. a meno che non sia specificato diversamente.

Cosa fa il codice seguente?

(define (solve)
  (local (a b c)
    (setq a 0)
    (setq b 1)
    (for (i 2 50)
      (setq c (add (div (mul 2 a) i) 1))
      (setq a b)
      (setq b (add b c))
      (setq out (sub 1 (div (add c 1) (add i 3))))
      ;(println out)
    )
    (println (format "%16.14f" out))))

Non lo so.

Nota: passiamo più tempo a leggere i programmi che a scriverli.

Vediamo alcune regole e suggerimenti (poi ognuno fa come vuole):

1) Evitare di nominare una variabile con una singola lettera

  y = m*x + c

Questo deriva dal fatto che una espressione informatica è spesso molto simile ad una espressione matematica.
Comunque noi dobbiamo modificare i nostri programmi e non le formule matematiche.
Una variabile con una singola lettera non trasmette alcuna informazione.

Eccezione: per variabili che vivono solo all'interno di una singola espressione.
(Per esempio quando usiamo una funzione lambda anonima).
Eccezione: "i" è universalmente usato come indice...

2) Non abbreviare troppo i nomi

  Sbagliato               Corretto
  dw = 10                 dog-weight = 10
  cw = 5                  cat-weight = 5
  mw = 70                 man-weight = 70
  tw = dw + cw + mw       total-weight = dog-weight + cat-weight + man-weight

3) Non allungare troppo i nomi

  Sbagliato               Corretto
  the-dog-weight          dog-weight

4) Non utilizzare la prima lettera per indicare il tipo della variabile:
(notazione Ungherese)

  Sbagliato               Corretto
  iValue                  Value
  sName                   Name

In newLISP (che non è un linguaggio tipizzato) una variabile può cambiare tipo in ogni momento.

5) Non utilizzare il tipo nel nome della variabile

  Sbagliato               Corretto
  Value-Int               Value
  Name-String             Name

Eccezione: esistono due variabili che hanno lo stesso valore, ma tipo diverso.
Per esempio,
   value-string = "123"
   value-int = int(value-string) = 123

6) Utilizzare anche l'unità di misura nel nome della variabile

    Sbagliato             Corretto
    execute(delay)        execute(delay-seconds)

Vediamo alcuni pensieri presi in giro per il web su questo argomento:

A good variable name should:
1) Be clear and concise.
2) Be written in English.
3) Not contain special characters. (only the standard printable ASCII character)
3) Not conflict with keywords of programming language

Formatting variable names
1) Separate lover case words with "_" or "-" (temp_celsius or temp-celsius).
2) Use CamelCase or camelCase method to capitalize the first letter of words in a variable name to make it easier to read (TempCelsius or tempCelsius).
We can use either option, as long as we are consistent in the use.

"Abbreviations rely on context you may or may not have."

The more imposing the variable name is the bigger the scope. Since letter variables are for a few lines of code in the middle of a function. Large screaming snake case constants are constants that span 1 or more files.

Just for very simple variables which have no meaning other than iterative variables like “int i”, or “char c” for one line variables.
Or, like lambda function parameters (k, v) for map's.
Though I do see value in naming row / col instead of r / c.

Single letter variables do tell you something about the variable. They say "I'm not important", "my scope is as small as I am", "I'm fleeting" and "I'll be gone in 2 lines".

Verbs in function names are vital.

The "if you're having trouble naming something, it probably means something needs to be restructured" rule of thumb is honestly my biggest takeaway from this.

Clear variable names
--------------------
1) A variable name should describe the entity the variable represents.
2) When writing your code, prioritize ease of reading over speed of writing.
3) Use consistent standards throughout a project to minimize the cognitive burden of small decisions.

Things to avoid
---------------
1) Unhelpful, confusing or vague variable names
2) Unnamed magic constant numbers

Basic ideas when naming variables
---------------------------------
1) The variable name must describe the information represented by the variable.
A variable name should tell you concisely in words what the variable stands for.
2) Your code will be read more times than it is written.
Prioritize how easy your code is to read over than how quick it is to write.
3) Adopt standard conventions for naming so you can make one global decision in a codebase instead of multiple local decisions.

Problems with naming variables
------------------------------
1) A desire to keep variable names short
2) A direct translation of formulas into code

We write code to solve real-world problems, and we need to understand the problem our model represents.
While a computer will ultimately run your code, it'll be read by humans, so write code intended for humans!

Variable names — dos and dont's
-------------------------------
a) Use descriptive variable names
b) Use function parameters or named constants instead of magic numbers.
c) Describe what an equation or model represents with variable names.
d) Put aggregations at the end of variable names.
e) Use item_count instead of num.
f) Use descriptive loop indexes instead of i, j, k.
g) Adopt conventions for naming and formatting across a project.
h) Don't use machine-learning specific abbreviations.

Variable names — conventions to avoid
-------------------------------------
a) Numerals in variable names
b) Commonly misspelled words in English
c) Names with ambiguous characters
d) Names with similar meanings
e) Abbreviations in names
f) Names that sound similar to one another
g) Never use magic numbers

How to abbreviate names
-----------------------
a) Decide on common abbreviations: avg for average, max for maximum, std for standard deviation and so on.
Make sure all team members agree and write these down. (An alternative is to avoid abbreviating aggregations.)
b) Put the abbreviation at the end of the name.
This puts the most relevant information, the entity described by the variable, at the beginning.

Nota: qualunque stile adottiamo l'obiettivo è quello di facilitare (a noi stessi e agli altri) la lettura e la comprensione del programma.


------------------------
La funzione "atof" del C
------------------------

La funzione "atof" fa parte della libreria standard del linguaggio C e converte una stringa in un numero floating point.

Dal manuale del C dell'IBM:

atof() — Convert Character String to Float

Format
------
#include <stdlib.h>
double atof(const char *string);

Description
-----------
The atof() function converts a character string to a double-precision floating-point value.

The input string is a sequence of characters that can be interpreted as a numeric value of the specified return type.
The function stops reading the input string at the first character that it cannot recognize as part of a number.
This character can be the null character that ends the string.

The atof() function expects a string in the following form:

 [spaces][+|-][digits][.][digits][e|E][+|-][digits]

The white space consists of the same characters for which the isspace() function is true, such as spaces and tabs. The atof() function ignores leading white-space characters.

For the atof() function, digits is one or more decimal digits.
If no digits appear before the decimal point, at least one digit must appear after the decimal point.
The decimal digits can precede an exponent, introduced by the letter e or E. The exponent is a decimal integer, which might be signed.

The atof() function will not fail if a character other than a digit follows an E or if e is read in as an exponent.
For example, 100elf will be converted to the floating-point value 100.0.
The accuracy is up to 17 significant character digits.

Return Value
------------
The atof() function returns a double value that is produced by interpreting the input characters as a number. The return value is 0 if the function cannot convert the input to a value of that type.

La funzione di newLISP equivalente ad "atof" è "float".
Comunque, per esercizio, scriviamo la funzione "atof" in newLISP.

(define (digit? ch) (and (>= ch "0") (<= ch "9")))

(define (atof str)
  (local (val ex ch idx magn sign ee)
    (setq val 0.0)
    (setq ex 0)
    (setq ch 0)
    (setq idx 0)
    (setq magn 1)
    ; elimina gli spazi all'inizio della stringa
    (setq str (trim str " " ""))
    ; numero positivo o negativo?
    (cond ((= (str idx) "+") (++ idx))
          ((= (str idx) "-") (++ idx) (setq magn -1))
    )
    ; legge la parte intera (se esiste)
    (while (and (< idx (length str)) (digit? (setq ch (str idx))))
      (setq val (add (mul val 10.0) (- (char ch) 48)))
      (++ idx)
    )
    ; legge la parte decimale (se esiste)
    (if (and (< idx (length str)) (= (setq ch (str idx)) "."))
      (begin
        (++ idx)
        (while (and (< idx (length str)) (digit? (setq ch (str idx))))
          (setq val (add (mul val 10.0) (- (char ch) 48)))
          (++ idx)
          (-- ex)
        )))
    ; legge la parte esponenziale (se esiste)
    (if (and (< idx (length str)) (or (= (str idx) "E") (= (str idx) "e")))
      (begin
        (++ idx)
        (setq ch (str idx))
        (setq sign 1)
        (setq ee 0)
        (cond ((= ch "+") (++ idx))
              ((= ch "-") (++ idx) (setq sign -1))
        )
        (while (and (< idx (length str)) (digit? (setq ch (str idx))))
          (setq ee (add (mul ee 10) (- (char ch) 48)))
          (++ idx)
        )
        (setq ex (add ex (mul ee sign)))))
    ; aggiorna il risultato in base al valore dell'esponente
    (while (> ex 0)
      (setq val (mul val 10))
      (-- ex)
    )
    (while (< ex 0)
      (setq val (mul val 0.1))
      (++ ex)
    )
    ; assegnazione del segno (positivo o negativo)
    (mul val magn)))

Facciamo alcune prove:

(atof "1234.134")
;-> 1234.134
(atof " 1234.134")
;-> 1234.134
(atof " 1234.13 4")
;-> 1234.13
(atof "")
;-> 0
(atof "0.134")
;-> 0.134
(atof ".134")
;-> 0.134
(atof "a2")
;-> 0
(atof "2.3a2")
;-> 2.3
(atof "2.0130")
;-> 2.013
(atof "2.01b30")
;-> 2.01
(atof "2.0130a")
;-> 2.013
(atof " 2e3")
;-> 2000
(atof "2e+3")
;-> 2000
(atof "2e-3")
;-> 0.002000000000000001
(atof "e2e-3")
;-> 0
(atof ".1e2")
;-> 10
(atof "-2e3 ")
;-> -2000
(atof " 100elf ")
;-> 100
(atof "-2309.12E-15")
;-> -2.309120000000002e-012

Vediamo le differenze con "float":

(float "1234.134")
;-> 1234.134
(float " 1234.134")
;-> 1234.134
(float " 1234.13 4")
;-> 1234.13
(float "")
;-> nil
(float "0.134")
;-> 0.134
(float ".134")
;-> 0.134
(float "a2")
;-> nil
(float "2.3a2")
;-> 2.3
(float "2.0130")
;-> 2.013
(float "2.01b30")
;-> 2.01
(float "2.0130a")
;-> 2.013
(float " 2e3")
;-> 2000
(float "2e+3")
;-> 2000
(float "2e-3")
;-> 0.002
(float "e2e-3")
;-> nil
(float ".1e2")
;-> 10
(float "-2e3 ")
;-> -2000
(float " 100elf ")
;-> 100
(float "-2309.12E-15")
;-> -2.30912e-012

Nota: alcuni numeri in formato stringa non possono essere convertiti esattamente (con le stesse cifre decimali) perchè i numeri floating-point non possono rappresentare tutti i numeri reali.

(setq nums (map string (random 1 100 10)))
;-> ("1.125125888851589" "57.35853144932401" "20.33042390209662"
;->   "81.87405011139256" "59.50093081453902" "48.98730430005799"
;->   "36.02914517654958" "90.59624011963255" "83.28400524918364"
;->   "75.66048158207953")

(map atof nums)
;-> (1.12512588885159 57.35853144932406 20.33042390209664 81.87405011139263
;->  59.50093081453906 48.98730430005803 36.02914517654961 90.59624011963263
;->  83.28400524918371 75.6604815820796)

(map float nums)
;-> (1.125125888851589 57.35853144932401 20.33042390209662 81.87405011139256
;->  59.50093081453902 48.98730430005799 36.02914517654958 90.59624011963255
;->  83.28400524918364 75.66048158207953)

La funzione "float" è più precisa di "atof":

(= (map atof nums) (map float nums))
;-> nil

(= nums (map string (map float nums)))
;-> true

(= nums (map string (map atof nums)))
;-> nil

Ma anche "float" ha i suoi limiti:

(float "1.12345678901234567890")
;-> 1.123456789012346


-------------------------
Potenze di 2 in un intero
-------------------------

Estrarre la potenza di due da un numero intero minimizzando la lunghezza della soluzione.
Esempi:
   88 = 2 * 2 * 2 * 11                 --> 2 * 2 * 2 = 8
  316 = 2 * 2 * 79                     --> 2 * 2 = 4
  384 = 2 * 2 * 2 * 2 * 2 * 2 * 2 * 3  --> 2 * 2 * 2 * 2 * 2 * 2 * 2 = 128

(setq n1 384)
(setq n2 4096)
(setq n3 88)

Ecco alcune soluzioni in ordine decrescente di lunghezza:

60 caratteri:
(define (f n) (apply * (filter (fn(x) (= x 2)) (factor n))))
(println (f n1)  { } (f n2) { } (f n3))
;-> 128 4096 8

60 caratteri:
(define (f n) (apply * (clean (fn(x) (!= x 2)) (factor n))))
(println (f n1)  { } (f n2) { } (f n3))
;-> 128 4096 8

54 caratteri:
(define (f n) (pow 2 (length (ref-all 2 (factor n)))))
(println (f n1)  { } (f n2) { } (f n3))
;-> 128 4096 8

54 caratteri:
(define (f n) (apply * (ref-all 2 (factor n) = true)))
(println (f n1)  { } (f n2) { } (f n3))
;-> 128 4096 8

48 caratteri:
(define (f n) (apply * (find-all 2 (factor n))))
(println (f n1)  { } (f n2) { } (f n3))
;-> 128 4096 8


------------------------
Concatenazione di numeri
------------------------

Data una lista di numeri interi positivi come (21 360), generare la sequenza di numeri che può essere formata concatenando i numeri dall'insieme precedente, in ordine numerico crescente.

Ad esempio, con (21 360) la sequenza inizia in questo modo:

  21, 360, 2121, 21360, 36021, 212121, 360360, 2121360, ...

Gli elementi della sequenza devono essere unici.

La lista iniziale non è vuota e non contiene duplicati.

Idea: usare il prodotto cartesiano ripetutamente memorizzando i risultati intermedi

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        '()
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(setq out '())
(setq N 10)
(setq base '(21 360))
(setq nums '(21 360))
(setq curr '(21 360))

(while (> N (length nums))
  (setq curr (cp base curr))
  (extend nums curr)
)
;-> (21 360 (21 21) (21 360) (360 21) (360 360) (21 (21 21)) (21 (21 360)) 
;->  (21 (360 21)) (21 (360 360)) (360 (21 21)) (360 (21 360)) (360 (360 21))
;->  (360 (360 360)))

(dolist (el nums)
  (cond ((atom? el) (push el out))
        ((list? el) (push (int (join (map string (flat el))) 0 10) out))
  )
)
(sort (unique out))
;-> (21 360 2121 21360 36021 212121 360360 2121360 2136021 3602121 
;->  21360360 36021360 36036021 360360360)

Funzione che genera la sequenza dei numeri concatenati di una lista fino ad un dato limite:

(define (concatenate lst limit)
  (local (nums curr out)
    (setq nums lst)
    (setq curr lst)
    (while (> limit (length nums))
      (setq curr (cp lst curr))
      (extend nums curr)
    )
    (dolist (el nums)
      (cond ((atom? el) (push el out))
            ((list? el) (push (int (join (map string (flat el))) 0 10) out)))
    )
    (sort (unique out))))

(concatenate '(21 360) 20)
;-> (21 360 2121 21360 36021 212121 360360 2121360 2136021 3602121 21212121
;->  21360360 36021360 36036021 212121360 212136021 213602121 360212121
;->  360360360 2121360360 2136021360 2136036021 3602121360 3602136021
;->  3603602121 21360360360 36021360360 36036021360 36036036021 360360360360)

(concatenate '(108 5) 10)
;-> (5 55 108 555 1085 5108 10855 51085 55108 108108 
;->  1081085 1085108 5108108 108108108)

(concatenate '(2 222 2) 10)
;-> (2 22 222 2222 222222) ;ops: non è lunga 10...troppi numeri uguali.

(define (concatenate lst limit)
  (local (nums curr temp out)
    (setq nums lst)
    (setq curr lst)
    (while (> limit (length nums))
      (setq curr (cp lst curr))
      (setq temp '())
      (dolist (el curr)
        (cond ((atom? el) (push el temp))
              ((list? el) (push (int (join (map string (flat el))) 0 10) temp))
        )
      )
      (setq curr (unique temp))
      (setq nums (unique (extend nums curr)))
    )
    (slice (sort (unique nums)) 0 limit)))

(concatenate '(2 222 2) 10)
;-> (2 22 222 2222 22222 222222 2222222 22222222 
;->  222222222 2222222222)

(concatenate '(0 1 2 3 4 5 6 7 8 9) 50)
;-> (0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 
;->  20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
;->  37 38 39 40 41 42 43 44 45 46 47 48 49)


----------------------------------
Frazione compresa tra due frazioni
----------------------------------

Date due frazioni intere positive a e b tali che a<b, trovare la frazione z compresa tra a e b che ha il più piccolo denominatore.
Ad esempio per a=2/5 e b=4/5, la frazione z vale 1/2.
Anche altre frazioni come 3/5 sono tra i due, ma 1/2 ha il denominatore di più piccolo (2 < 5).

Per trovare la frazione tra due frazioni basta sommarle e dividere per 2:

  ((2/5) + (4/5))/2 = 6/5 * 1/2 = 6/10 = 3/5

Comunque il problema non è trovare la frazione che si trova esattamente a metà tra le due frazione date, ma trovare la frazione che è compresa tra le due ed ha il denominatore più piccolo.

Date due frazioni a=n1/d1 e b=n2/d2 il metodo per calcolare tale frazione è il seguente:

Ciclo per k=0,1,2,3... fino a che floor(b*k) > floor(a*k) + 1
Ritornare (floor(a*k) + 1) e k (numeratore e denominatore della soluzione)

(define (fraction n1 d1 n2 d2)
  (let ((den 0) (num 0))
    (while (<= (* den n2) (* d2 num))
      (++ den)
      (setq num (+ (/ (* den n1) d1) 1))
    )
  (list num den)))

Facciamo alcune prove:

(fraction 2 5 4 5)
;-> (1 2)
(fraction 5 13 7 18)
;-> (12 31)
(fraction 1 1 2 1)
;-> (3 2)
(fraction 12 31 7 18)
;-> (19 49)

Quando a=b la funzione entra in un ciclo infinito (es. (fraction 1 1 2 2)).
Modifichiamo la nostra funzione per trattare questo caso particolare:

(define (fraction n1 d1 n2 d2)
  ; due frazioni sono uguali se il loro prodotto incrociato è uguale
  ; num1*den2 = num2*den1 ?
  (if (= (* n1 d2) (* n2 d1)) 
      (list n1 d1)
      ;else
      (let ((den 0) (num 0))
        
        (while (<= (* den n2) (* d2 num))
          (++ den)
          (setq num (+ (/ (* den n1) d1) 1))
        )
      (list num den))))

(fraction 2 5 4 5)
;-> (1 2)
(fraction 5 13 7 18)
;-> (12 31)
(fraction 1 1 2 1)
;-> (3 2)
(fraction 12 31 7 18)
;-> (19 49)
(fraction 1 1 2 2)
;-> (1 1)
(fraction 12 13 132 143)
;-> (12 13)


------------------------------------------------
Fattorizzazione e divisori di numeri big-integer
------------------------------------------------

Alcune funzioni per calcolare i divisori di un numero big-integer.

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

(setq num1 922337203685477580988L)
(setq num2 442233720368547758094L)
(time (println (setq f1 (factor-i num1))))
;-> (2L 2L 13L 17L 109L 347813L 27521059771L)
;-> 40.182
(time (println (setq f2 (factor-i num2))))
;-> (2L 3L 43929733L 1677807148553L)
;-> 4714.545

Funzione che raggruppa una lista di fattori:

(define (raggruppa-fattori lst)
  (letn (unici (unique lst))
    (transpose (list unici (count unici lst)))))

(raggruppa-fattori f1)
;-> ((2L 2) (13L 1) (17L 1) (109L 1) (347813L 1) (27521059771L 1))
(raggruppa-fattori f2)
;-> ((2L 1) (3L 1) (43929733L 1) (1677807148553L 1))

Funzione che conta i divisori di una lista di fattori:

(define (conta-divisori lst)
  (let (lst (raggruppa-fattori lst))
    (apply * (map (fn(x) (+ 1L (last x))) lst))))

(conta-divisori f1)
;-> 96L
(conta-divisori f2)
;-> 16L

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

Funzione che somma i divisori di una lista di fattori:

(define (somma-divisori lst)
  (local (sum out)
    (setq out 1L)
    (setq lst (raggruppa-fattori lst))
    (dolist (el lst)
      (setq sum 0L)
      (for (i 0 (last el))
        (setq sum (+ sum (** (first el) i)))
      )
      (setq out (* out sum)))))

(somma-divisori f1)
;-> 1857391605801792688320L
(somma-divisori f2)
;-> 884467460871308455632L

Funzione che genera la lista dei divisori di una lista di fattori:

(define (lista-divisori lst)
  (local (f out)
    (setq f (raggruppa-fattori lst))
    (setq out '())
    (lista-divisori-aux 0L 1L)
    (sort out)))
; auxiliary function
(define (lista-divisori-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (lista-divisori-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

(lista-divisori f1)
;-> (1L 2L 4L 13L 17L 26L 34L 52L 68L 109L 218L 221L 436L 442L 884L
;->  1417L 1853L 2834L 3706L 5668L 7412L 24089L 48178L 96356L 347813L
;->  695626L 1391252L 4521569L 5912821L 9043138L 11825642L 18086276L
;->  23651284L 37911617L 75823234L 76866673L 151646468L 153733346L
;->  307466692L 492851021L 644497489L 985702042L 1288994978L 1971404084L
;->  2577989956L 8378467357L 16756934714L 27521059771L 33513869428L
;->  55042119542L 110084239084L 357773777023L 467858016107L 715547554046L
;->  935716032214L 1431095108092L 1871432064428L 2999795515039L 5999591030078L
;->  6082154209391L 11999182060156L 12164308418782L 24328616837564L
;->  38997341695507L 50996523755663L 77994683391014L 101993047511326L
;->  155989366782028L 203986095022652L 662954808823619L 1325909617647238L
;->  2651819235294476L 9572182362130823L 19144364724261646L 38288729448523292L
;->  124438370707700699L 162727100156223991L 248876741415401398L
;->  325454200312447982L 497753482830802796L 650908400624895964L
;->  1043367877472259707L 2086735754944519414L 2115452302030911883L
;->  4173471509889038828L 4230904604061823766L 8461809208123647532L
;->  13563782407139376191L 17737253917028415019L 27127564814278752382L
;->  35474507834056830038L 54255129628557504764L 70949015668113660076L
;->  230584300921369395247L 461168601842738790494L 922337203685477580988L)
(length (lista-divisori f1))
;-> 96
(apply + (lista-divisori f1))
;-> 1857391605801792688320L

(lista-divisori f2)
;-> (1L 2L 3L 6L 43929733L 87859466L 131789199L 263578398L 1677807148553L
;->  3355614297106L 5033421445659L 10066842891318L 73705620061424626349L
;->  147411240122849252698L 221116860184273879047L 442233720368547758094L)
(length (lista-divisori f2))
;-> 16
(apply + (lista-divisori f2))
;-> 884467460871308455632L


---------------------------
Visitare una lista annidata
---------------------------

(setq a '(1 2 3))
(setq b '(1 (2 3 (4 (5 (6)) 7)) (8 (9))))
(setq c '(1 (2 (3 (4 5 (6 5))) 7) (3 (8 7 (6 5)))))

Visita lineare (dal primo elemento all'ultimo (flat list))
----------------------------------------------------------

(define (visit lst f)
  (dolist (el lst)
    (if (list? el)
        (visit el f)
        (f el))))

(visit a (fn(x) (print x { })))
;-> 1 2 3
(visit b (fn(x) (print x { })))
;-> 1 2 3 4 5 6 7 8 9
(visit c (fn(x) (print x { })))
;-> 1 2 3 4 5 6 5 7 3 8 7 6 5

Sfruttando il contesto dinamico possiamo applicare anche una funzione che modifica i valori che visitiamo (i risultati vengono inseriti in una lista esterna alla funzione "visit"):

(setq out '())
(visit a (fn(x) (push (* x x) out -1)))
;-> (1 4 9)

(setq out '())
(visit b (fn(x) (push (* x x) out -1)))
;-> (1 4 9 16 25 36 49 64 81)

Se invece vogliamo applicare una funzione a tutti gli elementi di una lista annidata:

(define (map-all f lst)
  (let (result '())
    (dolist (el lst)
      (if (list? el)
        (push (map-all f el) result -1)
        (push (f el) result -1)))
    result))

(map-all (fn(x) (* x x)) a)
;-> (1 4 9)
(map-all (fn(x) (* x x)) b)
;-> (1 (4 9 (16 (25 (36)) 49)) (64 (81)))
(map-all (fn(x) (* x x)) c)
;-> (1 (4 (9 (16 25 (36 25))) 49) (9 (64 49 (36 25))))

Visita in base all'annidamento (prima gli elementi più annidati)
----------------------------------------------------------------
Generiamo la lista degli indici di tutti gli elementi della lista:

(setq indici (ref-all nil b (fn (x) true)))
;-> ((0) (1) (1 0) (1 1) (1 2) (1 2 0) (1 2 1) (1 2 1 0) (1 2 1 1) 
;->  (1 2 1 1 0) (1 2 2) (2) (2 0) (2 1) (2 1 0))

Ordiniamo la lista degli indici in base alla lunghezza di ogni indice (ordine decrescente):

(setq ind-ord (sort (map (fn(x) (list (length x) $idx)) indici) >))
;-> ((5 9) (4 8) (4 7) (3 14) (3 10) (3 6) (3 5) (2 13) (2 12) (2 4) (2 3) 
;->  (2 2) (1 11) (1 1) (1 0))

(setq ind-ord (select indici (map last ind-ord)))
;-> ((1 2 1 1 0) (1 2 1 1) (1 2 1 0) (2 1 0) (1 2 2) (1 2 1) (1 2 0) 
;->  (2 1) (2 0) (1 2) (1 1) (1 0) (2) (1) (0))

Visitiamo la lista utilizzando la lista degli indici ordinata:

(dolist (el ind-ord)
  (print (b el) { | })
)
;-> 6 | (6) | 5 | 9 | 7 | (5 (6)) | 4 | (9) | 8 | (4 (5 (6)) 7) | 3 | 2 | 
;-> (8 (9)) | (2 3 (4 (5 (6)) 7)) | 1 |

(setq indici (ref-all nil c (fn (x) true)))
(setq ind-ord (sort (map (fn(x) (list (length x) $idx)) indici) >))
(setq ind-ord (select indici (map last ind-ord)))
(dolist (el ind-ord)
  (print (c el) { | })
)
;-> 5 | 6 | 5 | 6 | (6 5) | 5 | 4 | (6 5) | 7 | 8 | (4 5 (6 5)) | 3 |
;-> (8 7 (6 5)) | 3 | 7 | (3 (4 5 (6 5))) | 2 | (3 (8 7 (6 5))) | 
;-> (2 (3 (4 5 (6 5))) 7) | 1 |

Partendo dalla lista degli indici possiamo visitare la lista nel modo che vogliamo.


--------------------------------
Inversione di una lista annidata
--------------------------------

La funzione "reverse" di newLISP inverte solo la posizione degli elementi del primo livello (cioè le eventuali sotto-liste non vengono invertite):

(setq a '(1 2 3))
(setq b '(1 (2 3) (4 5)))
(setq c '((1 2) (3 4) ((5) 6) (7)))

(reverse (copy a))
;-> (3 2 1)
(reverse (copy b))
;-> ((4 5) (2 3) 1)
(reverse (copy c))
;-> ((7) ((5) 6) (3 4) (1 2))

Scriviamo una funzione che inverte una lista e tutte le sottoliste:

(define (reverse-all lst)
  (let (result '())
    (dolist (el lst)
      (if (atom? el)
        (push el result)
        (push (reverse-all el) result)))
    result))

(reverse-all a)
;-> (3 2 1)
(reverse-all b)
;-> ((5 4) (3 2) 1)
(reverse-all c)
;-> ((7) (6 (5)) (4 3) (2 1))


-------------------------------
Angoli e lancette dell'orologio
-------------------------------

Dato un angolo tra 0 e 180 gradi scrivere una funzione che restituisce ora e minuti che formano le lancette di un orologio analogico con quell'angolo.
Per esempio quando l'angolo vale 0 l'ora vale 12:00.
Per esempio quando l'angolo vale 180 l'ora vale 6:00.
L'ora deve essere restituita come hh:mm tralasciando i secondi.
L'ora restituita deve essere compresa tra le 12:00 e le 11:59 (ad es. 0:00 e 22:00 sono ore non valide).
Ci sono due tempi possibili in ore e minuti (ad eccezione di 0 e 180 gradi) per ogni angolo intero (o angolo con parte frazionaria di 0.5) tra 0 e 180.

Esempi:

Angolo   | Ora
---------|------------
0        | 12:00
90       | 3:00, 9:00
180      | 6:00
45       | 4:30, 7:30
30       | 1:00, 11:00
60       | 2:00, 10:00
120      | 4:00, 8:00
15       | 5:30, 6:30
135      | 1:30, 10:30
1        | 4:22, 7:38
42       | 3:24, 8:36
79       | 3:02, 8:58
168      | 1:36, 10:24
179      | 1:38, 10:22
115      | 1:50, 10:10

Se poniamo che un angolo pari a 0 restituisce 12, risulta che all'ora hh:mm:
- la lancetta dei minuti ha un angolo pari a (360*mm)/60
- la lancetta delle ore ha un angolo pari a (360*hh)/60 + (360*mm)/(60*12)
Quindi l'angolo (clockwise) tra le due lancette vale:

  A = (360*hh)/60 + (360*m)/(60*12) - (360*mm)/60 =
    = 30*hh - (11*m)/2

A questo punto possiamo usare due cicli (ore e minuti) per creare una lista con tutti gli orari (hh:mm) e il relativo angolo)

(define (make-time)
  (local (out angle)
    (setq out '())
    (for (h 1 12)
      (for (m 0 59)
        (setq angle (abs (sub (mul 30 h) (div (mul 11 m) 2))))
        (if (> angle 180) (setq angle (sub 360 angle)))
        (push (list angle h m) out)
      )
    )
    (sort (unique out))))

(setq t (make-time))
(length t)
;-> 720

Adesso per cercare l'ora associata ad un angolo possiamo scrivere:

(ref-all '(115 ? ?) t match true)
;-> ((115 1 50) (115 10 10))
Un angolo di 115 gradi rappresenta le ore 01:50 oppure 10:10.

Invece per cercare l'angolo associato ad una data ora possiamo scrivere:

(ref-all '(? 10 10) t match true)
;-> ((115 10 10))

Verifichiamo i valori degli esempi:

(setq angoli '(0 90 180 45 30 60 120 15 135 1 42 79 168 179 115))

(map (fn(x) (println (ref-all (list x '? '?) t match true))) angoli)
;-> ((0 12 0))
;-> ((90 3 0) (90 9 0))
;-> ((180 6 0))
;-> ((45 4 30) (45 7 30))
;-> ((30 1 0) (30 11 0))
;-> ((60 2 0) (60 10 0))
;-> ((120 4 0) (120 8 0))
;-> ((15 5 30) (15 6 30))
;-> ((135 1 30) (135 10 30))
;-> ((1 4 22) (1 7 38))
;-> ((42 3 24) (42 8 36))
;-> ((79 3 2) (79 8 58))
;-> ((168 1 36) (168 10 24))
;-> ((179 1 38) (179 10 22))
;-> ((115 1 50) (115 10 10))
;-> ((115 1 50) (115 10 10))

Orari associati agli angoli (da 0 a 180):

(dolist (a angoli) (println (ref-all (list a '? '?) t match true)))

Angoli associati agli orari (da 1:00 a 12:59):

(setq tt (sort (map (fn(x) (list (x 1) (x 2) (x 0))) t)))


------------------------------------------
Esecuzione di programmi esterni dalla REPL
------------------------------------------

Per eseguire programmi esterni newLISP mette a disposizione due funzioni: "exec" e "process".

*****************
>>>funzione EXEC
*****************
sintassi: (exec str-process)
sintassi: (exec str-process [str-stdin])

Nella prima forma, "exec" avvia un processo descritto in "str-process" e restituisce tutto lo standard output come una lista di stringhe (una per ogni riga in standard out (STDOUT)). 
"exec" restituisce nil se non è stato possibile avviare il processo. 
Se il processo può essere avviato ma restituisce solo un errore e nessun output valido, verrà restituito la lista vuota.

(exec "ls *.c")  → ("newlisp.c" "nl-math.c" "nl-string.c")

L'esempio avvia un processo ed esegue il comando di shell ls, catturando l'output in un array di stringhe.

Nella seconda forma, exec crea una pipe di processo, avvia il processo in str-process e riceve da str-stdin input standard per questo processo. Il valore restituito è true se il processo è stato avviato correttamente, altrimenti è nil.

(exec "cgiProc" query)

In questo esempio, cgiProc potrebbe essere un processore cgi (ad esempio, Perl o newLISP) che riceve ed elabora l'input standard fornito da una stringa contenuta nella variabile query.

Per esempio possiamo usare "exec" per visualizzare un'immagine:

Esegue il visualizzatore di Windows 10 (ImageViewer):
(exec
{%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen})

Esegue il visualizzatore di Windows 10 (ImageViewer) visualizzando un'immagine:
(exec
{%SystemRoot%\System32\rundll32.exe "%ProgramFiles%\Windows Photo Viewer\PhotoViewer.dll", ImageView_Fullscreen C:\temp\image1.jpg})

Purtroppo la funzione "exec" è bloccante, cioè non viene restituito il focus alla REPL fino a che non viene chiuso il programma che è stato lanciato.

********************
>>>funzione PROCESS
********************
sintassi: (process str-command)
sintassi: (process str-command int-pipe-in int-pipe-out [int-win-option])
sintassi: (process str-command int-pipe-in int-pipe-out [int-unix-pipe-error])

Nella prima sintassi, "process" avvia un processo specificato in "str-command" e restituisce immediatamente un ID processo o nil se non è stato possibile creare un processo. 
Questo processo eseguirà il programma specificato o morirà immediatamente se "str-command" non può essere eseguito.

Su macOS e altri Unix, l'applicazione o lo script deve essere specificato con il suo percorso completo. 
Il nuovo processo eredita l'ambiente del sistema operativo dal processo principale.

Gli argomenti della riga di comando vengono analizzati negli spazi. 
Gli argomenti contenenti spazi devono essere delimitati utilizzando virgolette singole su macOS e altri Unix. 
Su MS Windows, vengono utilizzate le virgolette doppie. 

L'id del processo restituito può essere utilizzato per distruggere il processo in esecuzione utilizzando "destroy", se il processo non si chiude da solo.

(process "c:/WINDOWS/system32/notepad.exe")  → 1894 ; Windows

; or when in executable path
(process "notepad.exe")                      → 1894 ; Windows

; find out the path of the program to start using exec, 
; if the path is not known

(process (first (exec "which xclock")))  → 22607 ; on Unix

Se il percorso dell'eseguibile è sconosciuto, "exec" insieme al comando Unix "which" può essere utilizzato per avviare un programma. Il pid restituito può essere utilizzato per distruggere il processo.

Nella seconda sintassi, l'input e l'output standard del processo creato possono essere reindirizzati agli handle di pipe. 
Quando si rimappa l'I/O standard dell'applicazione avviata su una pipe, è possibile comunicare con l'altra applicazione tramite "write-line" e "read-line" o istruzioni "write" e "read":

;; Linux/Unix
;; create pipes
(map set '(myin bcout) (pipe))
(map set '(bcin myout) (pipe))   

;; launch Unix 'bc' calculator application
(process "/usr/bin/bc" bcin bcout) → 7916

(write-line myout "3 + 4")  ; bc expects a line-feed

(read-line myin)  → "7"

;; bc can use bignums with arbitrary precision

(write-line myout "123456789012345 * 123456789012345")

(read-line myin)  → "15241578753238669120562399025"

;; destroy the process
(destroy 7916)

;; MS Windows
(map set '(myin cmdout) (pipe))
(map set '(cmdin myout) (pipe))

(process "c:/Program Files/newlisp/newlisp.exe -c" cmdin cmdout)
→ 1284

(write-line myout "(+ 3 4)")

(read-line myin) → "7"

;; destroy the process
(destroy 1284)

Nelle versioni MS Windows di newLISP, è possibile specificare un quarto parametro opzionale di "int-win-option" per controllare lo stato di visualizzazione dell'applicazione. 
L'impostazione predefinita di questa opzione è 1 per mostrare la finestra dell'applicazione, 0 per nasconderla e 2 per mostrarla ridotta a icona sulla barra di avvio di Windows.

Su entrambi i sistemi MS Windows e Linux/Unix, standard error verrà reindirizzato a standard out per impostazione predefinita. Su Linux/Unix, è possibile definire un handle di pipe facoltativo per lo standard error output in "int-unix-pipe-error".

La funzione "peek" può essere utilizzata per controllare le informazioni sugli handle delle pipe:

;; create pipes
(map set '(myin bcout) (pipe))
(map set '(bcin myout) (pipe))   
(map set '(errin errout) (pipe))   

;; launch Unix 'bc' calculator application
(process "bc" bcin bcout errout)

(write myout command)

;; wait for bc sending result or error info
(while (and (= (peek myin) 0)
            (= (peek errin) 0)) (sleep 10))

(if (> (peek errin) 0)
  (println (read-line errin)))
  
(if (> (peek myin) 0)
  (println (read-line myin)))

Non tutte le applicazioni console interattive possono avere i propri canali I/O standard rimappati. 
A volte solo un canale, in o out, può essere rimappato. In questo caso, specificare 0 (zero) per il canale non utilizzato. L'istruzione seguente utilizza solo l'output dell'applicazione avviata:

(process "app" 0 appout)

Normalmente vengono utilizzate due pipe: una per le comunicazioni al processo figlio e l'altra per le comunicazioni dal processo figlio.

Vedi anche le funzioni "pipe" e "share" per le comunicazioni tra processi e la funzione "semaphore" per la sincronizzazione di più processi. Vedere le funzioni "fork" e "spawn" per altri modi di avviare i processi newLISP. Entrambi sono disponibili solo su macOS, Linux e altri sistemi operativi simili a Unix.

Con la funzione "process" possiamo eseguire un programma e ritornare immediatamente alla REPL.
Per esempio visualizziamo un'immagine con il seguente comando (XNviewMP):

(process "c:\\util\\XnViewMP\\xnviewmp.exe C:\\temp\\image1.jpg")
(setq viewer "c:\\util\\XnViewMP\\xnviewmp.exe ")

(process (append viewer "C:\\temp\\image1.jpg"))
(process (append viewer "C:/temp/image1.jpg"))

Nota: per convertire tra "\\", "/" e "\\":

(join (parse {c:\temp\image1} {\}) "/")
;-> "c:/temp/image1"

(join (parse {c:\temp\image1} {\\}) "/")
;-> "c:\\temp\\image1"


-------------
Make building
-------------

Scrivere una funzione che disegna il seguente edificio prendendo come parametro il numero di piani.
Un edificio ha almeno un piano (primo piano).
Esempi:

Edificio con 3 piani               Edificio con 2 piani
  .________.
  |        |
  | []  [] | ultimo piano          .________.
  |--------|                       |        |
  | []  [] | secondo piano         | []  [] | ultimo piano
  |--------|                       |--------|
  | []  [] |                       | []  [] |
  |  ____  |                       |  ____  |
  |  |  |  | primo piano           |  |  |  | primo piano
  |  |  |  |                       |  |  |  |
  ----------                       ----------

(define (build piani)
  (if (< piani 1) (setq piani 1))
  (if (> piani 1) ; almeno primo e ultimo piano
      ; ultimo piano
      (println ".________." "\n" "|        |" "\n" "| []  [] |")
  )
  ; ci sono più di due piani?
  (if (> piani 2)
    (until (= piani 2)
      (println "|--------|")
      (println "| []  [] |")
      (-- piani)
    )
  )
  ; primo piano
  (println "|--------|")
  (println "| []  [] |")
  (println "|  ____  |")
  (println "|  |  |  |")
  (println "|  |  |  |")
  '----------)

(build 3)
(build 2)
(build 1)
.________.
|        |
| []  [] |    .________.      
|--------|    |        |
| []  [] |    | []  [] |
|--------|    |--------|    |--------|
| []  [] |    | []  [] |    | []  [] |
|  ____  |    |  ____  |    |  ____  |
|  |  |  |    |  |  |  |    |  |  |  |
|  |  |  |    |  |  |  |    |  |  |  |
----------    ----------    ----------


--------------------------------
Ordine delle operazioni e PEMDAS
--------------------------------

Quanto fa 6/2*(1+2)?

a) (6/2)*(1+2) = 3*3 = 9
b) 6/(2*(1+2)) = 6/(2*3) = 6/6 = 1

L'ordine delle operazioni, ovvero l'ordine in cui devono essere eseguite le operazioni in una formula, viene utilizzato in matematica, scienze, tecnologia e molti linguaggi di programmazione per computer ed è il seguente:

1) Parentesi
2) Elevamenti a potenza (Exponentiation)
3) Moltiplicazioni e Divisioni
4) Addizioni e Sottrazioni

Le prime lettere delle operazioni formano l'acronimo "PEMDAS":
Parentheses, Exponents, Multiplication/Division, Addition/Subtraction.
Altro acronimo (altri paesi):
BEDMAS: Brackets, Exponents, Division/Multiplication, Addition/Subtraction.

Per risolvere il nostro quesito abbiamo bisogno di una regola ulteriore:

5) Se le operazioni hanno la stessa precedenza, allora si procede da sinistra a destra.

Con la regola 5) possiamo affermare che 6/2*(1+2) = 9 (perchè dobbiamo fare prima la divisione e poi la moltiplicazione).

Nota: il modo più sicuro per evitare ambiguità è usare le parentesi.
In newLISP siamo costretti a specificare l'ordine delle operazioni:

(* (/ 6 2) (+ 1 2))
;-> 9
(/ 6 (* 2 (+ 1 2)))
;-> 1


--------------------
Quadrati con n cifre
--------------------

Per ogni intero positivo n, determinare il numero più piccolo il cui quadrato ha n cifre.

Per esempio: a(4) = 32, 32^2 = 1024 ha 4 cifre, mentre 31^2 = 961 ha 3 cifre.

Sequenza OEIS A017936: 
  1, 4, 10, 32, 100, 317, 1000, 3163, 10000, 31623, 100000, 316228, 1000000, 
  3162278, 10000000, 31622777, 100000000, 316227767, 1000000000, 3162277661, 
  10000000000, 31622776602, 100000000000, 316227766017, ...

La formula è la seguente:

  a(n) = ceiling(10^((n-1)/2))
  
oppure

  a(n) = ceiling(sqrt(10^n))

(define (solve num) (ceil (sqrt (pow 10 num))))

(map solve (sequence 0 30))
;-> (1 4 10 32 100 317 1000 3163 10000 31623 100000 316228 1000000 3162278 
;->  10000000 31622777 100000000 316227767 1000000000 3162277661 
;->  10000000000 31622776602 100000000000 316227766017 1000000000000 
;->  3162277660169  10000000000000 31622776601684 100000000000000 
;->  316227766016838 1000000000000000)


----------------
Encoding Collatz
----------------

La famosa Congettura di Collatz definisce una sequenza per ogni numero naturale e ipotizza che ciascuna di queste sequenze alla fine raggiungerà 1.
Per un dato numero di partenza N, l'algoritmo per generare la sequenza di Collatz è il seguente:

   Affinchè N > 1:
     Se N è pari, dividire per 2
     Se N è dispari, moltiplicare per 3 e aggiungere 1

La codifica Collatz (encoding collatz) di un numero utilizza l'algoritmo specificato nella congettura per generare per mapparlo su un altro numero univoco.
https://codegolf.stackexchange.com/questions/246722/collatz-encoding
Per fare ciò, si inizia con un 1 e ad ogni passo dell'algoritmo, se si divide per 2 aggiungere 0, altrimenti aggiungere un 1. La stringa di cifre finale è la rappresentazione binaria della codifica.

Ad esempio, calcoliamo la codifica Collatz del numero 3:

 3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1.
(1)    1    0     1    0    0    0    0.

Pertanto, la codifica di 3 vale 208 (11010000 in binario).

(define (collatz n)
"Generate the collatz sequence of a positive integer number"
  (let ((out (list n)) (bit "1"))
    (until (= n 1)
      (if (even? n)
          (setq n (/ n 2))
          (setq n (+ (* 3 n) 1))
      )
      (push n out -1)
    )
    out))

(collatz 52)
;-> (52 26 13 40 20 10 5 16 8 4 2 1)

(collatz 27)
;-> (27 82 41 124 62 31 94 47 142 71 214 107 322 161 484 242 121 364 182
;->  91 274 137 412 206 103 310 155 466 233 700 350 175 526 263 790 395
;->  1186 593 1780 890 445 1336 668 334 167 502 251 754 377 1132 566 283
;->  850 425 1276 638 319 958 479 1438 719 2158 1079 3238 1619 4858 2429
;->  7288 3644 1822 911 2734 1367 4102 2051 6154 3077 9232 4616 2308 1154
;->  577 1732 866 433 1300 650 325 976 488 244 122 61 184 92 46 23 70
;->  35 106 53 160 80 40 20 10 5 16 8 4 2 1)

Funzione di codifica Collatz:

(define (collatz-enc n)
  (let (bit "1")
    (until (= n 1)
      (cond ((even? n)
              (setq n (/ n 2))
              (extend bit "0"))
            (true
              (setq n (+ (* 3 n) 1))
              (extend bit "1"))
      )
    )
    (println bit)
    (int bit 0 2)))

(collatz-enc 3)
;-> 11010000
;-> 208
(collatz-enc 52)
;-> 100100010000
;-> 2320
(collatz-enc 27)
;-> 11010010101010100100101001010100101010100100010101001010010101010101000
;-> 10101010000100100100001000101010000010000
;-> -1 ;oops la funzione "bit" non converte a numeri big-integer.

Funzioni per convertire numeri big-integer da decimale a binario e viceversa.

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (bitsL n)
(setq MAXINT (** 2 62)) ; 4611686018427387904L
(define (prep s) (string (dup "0" (- 62 (length s))) s))
    (if (<= n MAXINT) (bits (int n))
      (string (bitsL (/ n MAXINT))
              (prep (bits (int (% n MAXINT)))))))

(define (bin-decL binary)
  (let (num 0L)
    (dolist (b (explode binary))
      (setq num (+ (* num 2L) (int b)))
    )
    num))

Se n è dispari, 3*n + 1 deve essere pari. Ciò significa che in questo, possiamo combinare due passi in uno, con (3*n 1)/2 (e aggiungere "10" alla stringa di codifica).

Funzione di codifica Collatz ottimizzata (big-integer):

(define (c-enc n)
  (let (bit "1")
    (until (= n 1)
      (cond ((odd? n)
              ;(setq n (+ (* 3 n) 1))
              ;(setq n (/ n 2))
              ;(setq n (/ (+ (* 3 n) 1) 2))
              ; n = n/2+n%2*(n+1)
              (setq n (+ (/ n 2) (* (% n 2) (+ n 1))))
              (extend bit "10"))
            (true
              (setq n (/ n 2))
              (extend bit "0"))
      )
    )
    (println bit)
    (bin-decL bit)))

(c-enc 3)
;-> 11010000
;-> 208L
(c-enc 52)
;-> 100100010000
;-> 2320L
(c-enc 27)
;-> 11010010101010100100101001010100101010100100010101001010010101010101000
;-> 10101010000100100100001000101010000010000
;-> 4272797808638851837289440854955024L

(= 4272797808638851837289440854955024L
 (bin-decL (bitsL 4272797808638851837289440854955024L)))
;-> true


--------------------------------------------
Conversione decimale-binario per big-integer
--------------------------------------------

Ecco due funzioni per convertire tra decimale e binario (e viceversa) anche i numeri big-integer.

Conversione da decimale a binario (big-integer):

(define (dec-binL num)
  (let (MAXINT 4611686018427387904L) ; (2^62)
    (define (prep s) (string (dup "0" (- 62 (length s))) s))
    (if (<= num MAXINT) (bits (int num))
      (string (dec-binL (/ num MAXINT))
              (prep (bits (int (% num MAXINT))))))))

(bits 9223372036854775807)
;-> "111111111111111111111111111111111111111111111111111111111111111"
(dec-binL 9223372036854775807)
;-> "111111111111111111111111111111111111111111111111111111111111111"

Conversione da binario a decimale (big-integer):

(define (bin-decL binary)
  (let (num 0L)
    (dolist (b (explode binary)) (setq num (+ (* num 2L) (int b))))
    num))

(dec-binL 102394746378492383765)
;-> "1011000110100000011001101110101001000010100010000010001001000010101"
(bin-decL "1011000110100000011001101110101001000010100010000010001001000010101")
;-> 102394746378492383765L

(= 102394746378492383765 (bin-decL (dec-binL 102394746378492383765)))
;-> true


----------------------------
Numeri somma di due quadrati
----------------------------

Determinare se un numero intero N può essere espresso come somma dei quadrati di due numeri interi.

Sequenza OEIS A001481:
  0, 1, 2, 4, 5, 8, 9, 10, 13, 16, 17, 18, 20, 25, 26, 29, 32, 34, 36, 37,
  40, 41, 45, 49, 50, 52, 53, 58, 61, 64, 65, 68, 72, 73, 74, 80, 81, 82,
  85, 89, 90, 97, 98, 100, 101, 104, 106, 109, 113, 116, 117, 121, 122,
  125, 128, 130, 136, 137, 144, 145, 146, 148, 149, 153, 157, 160, ...

La sequenza complementare è quella di tutti i numeri che non possono essere espressi come somma  dei quadrati di due numeri interi.

Sequenza OEIS A022544:
  3, 6, 7, 11, 12, 14, 15, 19, 21, 22, 23, 24, 27, 28, 30, 31, 33, 35, 38,
  39, 42, 43, 44, 46, 47, 48, 51, 54, 55, 56, 57, 59, 60, 62, 63, 66, 67, 
  69, 70, 71, 75, 76, 77, 78, 79, 83, 84, 86, 87, 88, 91, 92, 93, 94, 95, 
  96, 99, 102, 103, 105, 107, 108, 110, 111, 112, 114, 115, 118, 119, 120,
  123, 124, 126, 127, 129, 131, 132, 133, 134, 135, 138, 139, 140, 141, 
  142, 143, 147, 150, 151, 152, 154, 155, 156, 158, 159, ...

Approccio Brute-force
---------------------
Usiamo due cicli for fino alla radice quadrata di N e ogni volta verifichiamo se la somma dei quadrati dei due numeri (indici) del ciclo è uguale a N.

(define (sum-quad1 num)
  (let ((a nil) (b nil) (break nil))
    (for (i 0 (int (+ (sqrt num) 1)) 1 break)
      (for (j i (int (+ (sqrt num) 1)))
        (if (= num (+ (* i i) (* j j))) (set 'a i 'b j 'break true))
      )
    )
    ;(println a { } b)
    break))

(sum-quad1 17)
;-> 1 4
;-> true

(filter sum-quad1 (sequence 0 30))
;-> (0 1 2 4 5 8 9 10 13 16 17 18 20 25 26 29)
(clean sum-quad1 (sequence 0 30))
;-> (3 6 7 11 12 14 15 19 21 22 23 24 27 28 30)

Approccio ottimizzato
---------------------
Usiamo una lista (o una hashmap) per memorizzare i quadrati dei numeri fino a sqrt(n), e ogni volta verifichiamo se esiste nella lista un numero pari a (N – sqrt(i)).

(define (sum-quad2 num)
  (let ((a nil) (b nil) (break nil) (sq '()))
    (for (i 0 (int (+ (sqrt num) 1)) 1 break)
      (setq q (* i i))
      (push q sq)
      (if (ref (- num q) sq) (set 'a i 'b (sqrt (- num q)) 'break true))
    )
    ;(println a { } b)
    break))

(sum-quad2 17)
;-> 4 1
;-> true

(filter sum-quad2 (sequence 0 30))
;-> (0 1 2 4 5 8 9 10 13 16 17 18 20 25 26 29)
(clean sum-quad2 (sequence 0 30))
;-> (3 6 7 11 12 14 15 19 21 22 23 24 27 28 30)

Approccio matematico
--------------------
Ecco un teorema, dovuto a Fermat, che risolve il problema:

Un numero N è esprimibile come somma di 2 quadrati se e solo se nella scomposizione in fattori primi di N ogni numero primo della forma (4k+3) ricorre un numero pari di volte!

Esempi: 245 = 5*7*7. L'unico numero primo della forma 4k+3 è 7, e compare due volte. Quindi dovrebbe essere possibile scrivere 245 come somma di 2 quadrati (infatti, prova i quadrati di 14 e 7). Ma poiché 7 compare solo una volta in 42=2*3*7, è impossibile scrivere 42 come somma di due quadrati.

Un corollario di questo fatto è che ogni numero primo della forma (4k+1) può essere scritto come somma di due quadrati.

Nota: un numero N è nella forma (4k+3) se (N mod 4) = 3.

(define (sum-quad3 num)
  (local (f out)
    (setq f (factor num))
    (cond ((or (= num 0) (= num 1)) true)
          ((= (length f) 1)
            ; primo in forma (4k+3) --> nil
            ; primo non in forma (4k+3) --> true
            (if (= (% (f 0) 4) 3) nil true)
          )
          (true
            (setq out true)
            (dolist (el f (not out))
              (if (and (= (% el 4) 3) (odd? (first (count (list el) f))))
                  (setq out nil)
              )
            )
            out))))

(sum-quad3 17)
;-> true

(filter sum-quad3 (sequence 0 30))
;-> (0 1 2 4 5 8 9 10 13 16 17 18 20 25 26 29)
(clean sum-quad3 (sequence 0 30))
;-> (3 6 7 11 12 14 15 19 21 22 23 24 27 28 30)

Vediamo se le funzioni producono gli stessi risultati:

(= (filter sum-quad1 (sequence 0 1000))
   (filter sum-quad2 (sequence 0 1000))
   (filter sum-quad3 (sequence 0 1000)))
;-> true

Vediamo la velocità delle funzioni:

(time (filter sum-quad1 (sequence 0 1e4)))
;-> 2387.103
(time (filter sum-quad2 (sequence 0 1e4)))
;-> 237.376
(time (filter sum-quad3 (sequence 0 1e4)))
;-> 17.007


------------------------------------------
Risoluzione dell'equazione 1/x + 1/y = 1/n
------------------------------------------

Trovare tutte le soluzioni intere positive della seguente equazione per un determinato n:

  1/x + 1/y = 1/n

Risolviamo l'espressione in funzione della variabile x:

  1/x + 1/y = 1/n
  --> 1/x = 1/n – 1/y
  --> 1/x = (y – n)/(n*y)
  --> x = (n*y)/(y – n)

  x = ((n*y)/(y – n)) * (1)
  --> x = ((n*y)/(y – n)) * (1 – n/y + n/y)
  --> x = ((n*y)/(y – n)) * ((y- n)/y + n/y)
  --> x = n + n^2 / (y – n)

Notiamo che per avere un intero positivo x, il resto quando n^2 è diviso per (y – n) deve essere 0.
Inoltre il valore minimo di y può essere n + 1 (così che il denominatore y – n > 0) e il valore massimo di y può essere n^2 + n così che rimane n^2/(y – n) un numero intero positivo maggiore o uguale a 1.
Quindi l'algoritmo è il seguente:

  Ciclo con y che va da n + 1 a n * n
    Se (y-n) divide il quadrato di n, allora
       una soluzione vale (n + n^2 / (y – n)) e y
  End

Questo algoritmo trova anche le soluzioni simmetriche, cioè (x,y) e (y,x).
Se vogliamo trovare solo le soluzioni uniche, allora prendiamo solo le soluzioni in cui x>=y (oppure solo quelle in cui x <= y).

(define (solve num all)
  (local (x y out)
    (setq out '())
    (if all
        (for (y (+ num 1) (+ num (* num num)))
          (if (zero? (% (* num num) (- y num)))
            (push (list (+ num (/ (* num num) (- y num))) y) out -1)))
        ;else
        (for (y (+ num 1) (+ num (* num num)))
          (if (and (zero? (% (* num num) (- y num)))
                   (>= (+ num (/ (* num num) (- y num))) y))
            (push (list (+ num (/ (* num num) (- y num))) y) out -1)))
    )
    out))

Facciamo alcune prove:

(solve 1)
;-> ((2 2))
(solve 7)
;-> ((56 8 (14 14)))
(solve 7 true)
;-> ((56 8) (14 14) (8 56))
(solve 360)
;-> ((129960 361) (65160 362) (43560 363) (32760 364) (26280 365) (21960 366) 
;->  (16560 368) (14760 369) (13320 370) (11160 372) (9000 375) (8460 376)
;->  (7560 378) (6840 380) (5760 384) (5544 385) (5160 387) (4680 390)
;->  (4410 392) (3960 396) (3600 400) (3240 405) (3060 408) (2952 410)
;->  (2760 414) (2520 420) (2385 424) (2160 432) (2088 435) (1980 440)
;->  (1960 441) (1800 450) (1710 456) (1656 460) (1560 468) (1440 480)
;->  (1320 495) (1260 504) (1224 510) (1170 520) (1160 522) (1080 540)
;->  (1035 552) (1008 560) (960 576) (936 585) (900 600) (840 630) (810 648)
;->  (792 660) (765 680) (760 684) (720 720))


-----------
a*b + c = N
-----------

Danto un intero positivo N, trovare (se esistono) tre interi a, b, c che soddisfano:

  1) a*b + c = N
  2) a, b e c sono numeri primi
  3) a > b > c oppure a< b < c

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

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(length (comb 3 (primes-to 1000)))
;-> 776216

(define (solve num)
  (local (terne out)
    (setq out '())
    ; genera tutte le terne possibili dei numeri primi fino a num
    ; le terne sono ordinate in modo crescente
    (setq terne (comb 3 (primes-to num)))
    (dolist (el terne)
      ; a < b < c
      (if (= (+ (* (el 0) (el 1)) (el 2)) num)
          (push el out -1))
      ; a > b > c
      (if (= (+ (* (el 2) (el 1)) (el 0)) num)
          (push (reverse el) out -1))
    )
    out))

Facciamo alcune prove:

(solve 17)
;-> ((5 3 2) (2 3 11) (2 5 7))
(solve 20)
;-> ()
(solve 37)
;-> ((2 3 31) (7 5 2) (2 7 23))
(solve 48)
;-> ((5 7 13))
(solve 208)
;-> ((41 5 3) (3 5 193) (3 17 157) (3 19 151) (3 23 139) (3 37 97) 
;->  (3 43 79) (3 47 67) (29 7 5) (5 7 173) (5 19 113) (5 31 53)
;->  (7 11 131) (7 17 89) (7 23 47))


-------------------------------------
Triangoli con stesso perimetro e area
-------------------------------------

Trovare tutti i possibili triangoli aventi lo stesso perimetro e area e i cui lati sono numeri interi.

  Perimetro = a + b + c
  Area = sqrt(s*(s-a)*(s-b)*(s-c)) (formula di Erone)
         dove s = (a + b + c)/2

  Perimetro = Area
  a + b + c = sqrt(s*(s-a)*(s-b)*(s-c))

sostituiamo: a + b + c = 2*s
  2*s = sqrt(s*(s-a)*(s-b)*(s-c))

eleviamo al quadrato:
  4*s^2 = (s*(s-a)*(s-b)*(s-c))

semplifichiamo s:
  4*s = (s-a)*(s-b)*(s-c)

moltiplichiamo entrambi i membri per 2*2*2:
  (2*2*2)*4s = 2*(s-a)*2*(s-b)*2*(s-c)

Adesso:
  2*(s-a) = 2*((a+b+c)/2 - a) = (-a + b + c)
  2*(s-b) = 2*((a+b+c)/2 - b) = (a - b + c)
  2*(s-c) = 2*((a+b+c)/2 - c) = (a + b - c)

Sostituiamo:
  (2*2)*4*(a + b + c) = (-a + b + c)*(a - b + c)*(a + b - c)

Semplifichiamo:
  16*(a + b + c) = (-a + b + c)*(a - b + c)*(a + b - c)

In base a questa condizione il massimo valore del secondo membro deve essere:

  Max[ (- a + b + c)*(a – b + c)*(a + b – c) ] <= 16*16*16

Quindi:
  16*(a + b + c) ≤ 16*16*16  --> (a + b + c) <= 256

Algoritmo:
Tre cicli per provare tutte le combinazioni di a, b, c che soddisfano le condizioni.

(define (triangle)
  (local (out per2 m1 m2 m3)
    (for (i 1 256)
      (for (j 1 256)
        (for (k 1 256)
          (setq per2 (+ i j k))
          ;2*(s-a)
          (setq m1 (+ (- i) j k))
          ;2*(s-b)
          (setq m2 (+ i (- j) k))
          ;2*(s-c)
          (setq m3 (+ i j (- k)))
          ; area = perimetro ?
          (if (= (* 16 per2) (* m1 m2 m3))
              ; una soluzione trovata (i j k)
              (push (sort (list i j k)) out -1)
          )
        )
      )
    )
    ; elimina soluzioni duplicate
    (unique out)))

(time (println (triangle)))
;-> ((5 12 13) (6 8 10) (6 25 29) (7 15 20) (9 10 17))
;-> 5132.188


-----------------------------
Ordinamento di liste annidate
-----------------------------

Per ordinare una lista non annidata possiamo usare la funzione "sort":

(setq a '(10 6 4 8 14 3 8))
(sort a)
;-> (3 4 6 8 8 10 14)

Se la lista è annidata, allora la funzione "sort" potrebbe essere insufficiente per i nostri scopi:

(setq a '((3 5 2) (7 6) (5 9 2 4)))
(sort a)
;-> ((3 5 2) (5 9 2 4) (7 6))

Come si nota, gli elementi vengono ordinati in base ai valori di ogni sottolista, ma le sottoliste non vengono ordinate.
Possiamo risolvere questo problema utilizzando la funzione "map":

(setq a '((3 5 2) (7 6) (5 9 2 4)))
(map sort a)
;-> ((2 3 5) (6 7) (2 4 5 9))

In questo caso abbiamo ordinato tutte le sottoliste in base ai propri valori, ma non vengono ordinate le liste tra loro, per fare questo occorre utilizzare nuovamente "sort":

(setq a '((3 5 2) (7 6) (5 9 2 4)))
(sort (map sort a))
;-> ((2 3 5) (2 4 5 9) (6 7))

Comunque la lista considerata aveva un solo annidamento, in caso di liste più complesse dobbiamo usare altri metodi per ordinarle.
Supponiamo di avere la seguente lista:

(setq a '( ((15 8 4) (3) (3 1 2) (9 20 2) (4))
           ((77 63) (42 21))
           ((33) (4 2 19) (1 7 (4 3 (5 1) (2)) 5 3) (44)  (55) (57))
           (2 1)
           1
           (2 2)
           (101 99 (77) (75)) ))

La funzione "sort" produce il seguente risultato:

(sort (copy a))
;-> (1 (2 1) (2 2)
;->  (101 99 (77) (75))
;->  ((15 8 4) (3) (3 1 2) (9 20 2) (4))
;->  ((33) (4 2 19) (1 7 (4 3 (5 1) (2)) 5 3) (44) (55) (57))
;->  ((77 63) (42 21)))

Come si nota, le sottoliste non sono ordinate.

Non possiamo applicare "map", perchè alcuni elementi sono atomi e non liste:

(map sort a)
;-> ERR: list or array expected in function sort : 1

L'obiettivo è quello di ordinare la lista nel modo seguente:

(((1 2 3) (2 9 20) (3) (4) (4 8 15))
 ((21 42) (63 77))
 ((1 3 5 7 (3 4 (1 5) (2))) (2 4 19) (33) (44) (55) (57))
 (1 2)
 1
 (2 2)
 (99 101 (75) (77)))

Cioè tutte le sottoliste annidate sono ordinate sia internamente che tra loro.
Solo le sottoliste del primo livello non vengono ordinate tra loro.

Per ottenere questo risultato occorre ordinare tutte le sottoliste partendo da quelle più interne.
Un possibile algoritmo è il seguente:

1) generare la lista degli indici di tutti gli elementi della lista data
2) ordinare la lista degli indici per lunghezza delle sottoliste (decrescente)
3) Ciclo sulla lista degli indici ordinata
   per ordinare tutte le sottoliste (partendo da quelle più interne/annidate)

Nota: se ordiniamo gli indici in modo crescente, allora incontriamo prima le sottoliste più esterne.

Facciamo un esempio:

(setq lst '( ((15 8 4) (3) (4 (1)))
             ((77 63) (42 21))
             ((33) (4 2 19) (57))
              (2 1)
              1
              (101 99 (77) (75)) ))

1) generare la lista degli indici di tutti gli elementi della lista data
(setq indici (ref-all nil lst (fn (x) true)))
;-> ((0) (0 0) (0 0 0) (0 0 1) (0 0 2) (0 1) (0 1 0) (0 2) (0 2 0) (0 2 1)
;->  (0 2 1 0) (1) (1 0) (1 0 0) (1 0 1) (1 1) (1 1 0) (1 1 1) (2) (2 0)
;->  (2 0 0) (2 1) (2 1 0) (2 1 1) (2 1 2) (2 2) (2 2 0) (3) (3 0) (3 1)
;->  (4) (5) (5 0) (5 1) (5 2) (5 2 0) (5 3) (5 3 0))

2) ordinare la lista degli indici per lunghezza delle sottoliste (decrescente)
(setq ind-ord (sort (map (fn(x) (list (length x) $idx)) indici) >))
(setq ind-ord (select indici (map last ind-ord)))
;-> ((0 2 1 0) (5 3 0) (5 2 0) (2 2 0) (2 1 2) (2 1 1) (2 1 0) (2 0 0) (1 1 1)
;->  (1 1 0) (1 0 1) (1 0 0) (0 2 1) (0 2 0) (0 1 0) (0 0 2) (0 0 1) (0 0 0)
;->  (5 3) (5 2) (5 1) (5 0) (3 1) (3 0) (2 2) (2 1) (2 0) (1 1) (1 0) (0 2)
;->  (0 1) (0 0) (5) (4) (3) (2) (1) (0))

3) Ciclo sulla lista degli indici ordinata
   per ordinare tutte le sottoliste (partendo da quelle più interne/annidate)
(dolist (idx ind-ord)
  ;(println idx { } (lst idx))
  ;(read-line)
  (if (list? (lst idx))
      ;(setf (lst idx) (sort (a idx)))
      (setf (lst idx) (sort (copy $it)))
  )
)
lst
;-> (((3) (4 8 15) (4 (1)))
;->  ((21 42) (63 77))
;->  ((2 4 19) (33) (57))
;->  (1 2)
;->  1 
;->  (99 101 (75) (77)))

Vediamo l'implementazione:

(define (sort-nested lst)
  (local (indici ind-ord)
    ; genera la lista degli indici di tutti gli elementi della lista data
    (setq indici (ref-all nil lst (fn (x) true)))
    ; ordina la lista degli indici per lunghezza delle sottoliste
    (setq ind-ord (sort (map (fn(x) (list (length x) $idx)) indici) >))
    (setq ind-ord (select indici (map last ind-ord)))
    ; ordina tutte le sottoliste della lista data
    ; partendo da quelle più interne (annidate)
    (dolist (idx ind-ord)
      ;(println idx { } (lst idx))
      ;(read-line)
      (if (list? (lst idx))
          ;(setf (lst idx) (sort (a idx)))
          (setf (lst idx) (sort (copy $it)))
      )
    )
    lst))

Facciamo alcune prove:

(sort-nested a)
;-> (((1 2 3) (2 9 20) (3) (4) (4 8 15))
;->  ((21 42) (63 77))
;->  ((1 3 5 7 (3 4 (1 5) (2))) (2 4 19) (33) (44) (55) (57))
;->  (1 2)
;->  1
;->  (2 2)
;->  (99 101 (75) (77)))

Se vogliamo ordinare anche il primo livello della lista data, basta applicare "sort" al risultato di "sort-nested":

(sort (sort-nested a))
;-> (1
;->  (1 2)
;->  (2 2)
;->  (99 101 (75) (77))
;->  ((1 2 3) (2 9 20) (3) (4) (4 8 15))
;->  ((1 3 5 7 (3 4 (1 5) (2))) (2 4 19) (33) (44) (55) (57))
;->  ((21 42) (63 77)))

Le liste non annidate non vengono ordinate:

(setq a '(4 2 1 7 6 9 2))
(sort-nested a)
;-> (4 2 1 7 6 9 2)
La lista non è cambiata perchè "sort-nested" non ordina il primo livello.

(setq a '((5 9) (4 8 2) ((6) (3) (8)) ((9 8 11))))
(sort-nested a)
;-> ((5 9) (2 4 8) ((3) (6) (8)) ((8 9 11)))

(setq a '((7 4 5) (9 4 2) (2 6 3)))
(sort-nested a)
;-> ((4 5 7) (2 4 9) (2 3 6))

(setq a '(((10 5 9) (6 4 4)) ((2 6 3) (3 3 2)) ((3 8 6) (1 5 6))))
(sort (copy a))
;-> (((2 6 3) (3 3 2)) ((3 8 6) (1 5 6)) ((10 5 9) (6 4 4)))
(sort-nested a)
;-> (((4 4 6) (5 9 10)) ((2 3 3) (2 3 6)) ((1 5 6) (3 6 8)))
(sort (sort-nested a))
(((1 5 6) (3 6 8)) ((2 3 3) (2 3 6)) ((4 4 6) (5 9 10)))

(setq a '(((6 9) (12 17)) ((9 6) (9 8))))
(sort (copy a))
;-> (((6 9) (12 17)) ((9 6) (9 8)))
(sort-nested a)
;-> (((6 9) (12 17)) ((6 9) (8 9)))
(sort (sort-nested a))
;-> (((6 9) (8 9)) ((6 9) (12 17)))
 
Nota: partendo dalla lista degli indici è possibile individuare anche il livello di annidamento della sottolista corrente (uguale alla lunghezza della relativa lista degli indici) e quindi possiamo ordinare la lista nel modo che vogliamo.


-------------------------------------------
Numero successivo con cifre non decrescenti
-------------------------------------------

Dato un numero intero positivo N, trovare il numero successivo con i seguenti requisiti:
Il successivo numero maggiore è un numero in cui ogni cifra, da sinistra a destra, è maggiore o uguale alla precedente. Ad esempio, 1455: 1<4, 4<5, 5<=5.
Il prossimo numero maggiore deve essere maggiore di N.

Sequenza OEIS A009994: Numbers with digits in nondecreasing order
0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 22, 23,
24, 25, 26, 27, 28, 29, 33, 34, 35, 36, 37, 38, 39, 44, 45, 46, 47, 48, 49,
55, 56, 57, 58, 59, 66, 67, 68, 69, 77, 78, 79, 88, 89, 99, 111, 112, 113,
114, 115, 116, 117, 118, 119, 122, ...

Sequenza OEIS A009996: Numbers with digits in nonincreasing order
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 21, 22, 30, 31, 32, 33, 40, 41,
  42, 43, 44, 50, 51, 52, 53, 54, 55, 60, 61, 62, 63, 64, 65, 66, 70, 71,
  72, 73, 74, 75, 76, 77, 80, 81, 82, 83, 84, 85, 86, 87, 88, 90, 91, 92,
  93, 94, 95, 96, 97, 98, 99, 100, 110, 111, 200, 210, 211, ...

(setq MAX-INT 9223372036854775807)

Algoritmo brute-force
Ciclo che ogni volta aumenta di 1 il numero e verifica se soddisfa i requisiti.

(define (next num)
  (let (found nil)
    (cond ((< num 9) (++ num))
          (true
            (until found
              (++ num)
              (if (apply <= (explode (string num))) (setq found true))
            )))
    num))

Facciamo alcune prove:

(next 2)
;-> 3
(next 10)
;-> 11
(next 19)
;-> 22
(next 21)
;-> 22
(next 99)
;-> 111
(next 321)
;-> 333
(next 1455)
;-> 1456
(next 98142)
;-> 99999

Questa non termina brevemente...(l'ho interrotta)
(time (println (next 11123159995399999)))

(map next (sequence 0 50))
;-> (1 2 3 4 5 6 7 8 9 11 11 12 13 14 15 16 17 18 19 22 22 22 23 24 25
;->  26 27 28 29 33 33 33 33 34 35 36 37 38 39 44 44 44 44 44 45 46 47
;->  48 49 55 55)
(unique (map next (sequence 0 50)))
;-> (1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 22 23 24 25 26 27 28
;->  29 33 34 35 36 37 38 39 44 45 46 47 48 49 55)

Algoritmo smart
a) Verifica del numero
b) Ciclo sul numero fino a che non si trova un numero inferiore al precedente (es. 5 > 4) o si raggiunge la fine del numero.
c) Se raggiungiamo la fine del numero, lo aumentiamo di 1 e andiamo al passo a).
4) Se abbiamo trovato una coppia discendente, allora occorre sostituire tutte le cifre dal numero inferiore (4) alla fine, con il numero precedente (5).

Esempio: 1321
1321 non soddisfa i requisiti
La prima coppia discendente vale 32.
Sosituiamo tutte le cifre dalla 2 alla fine con il valore 3 --> 1333
1333 soddisfa i requisiti.

(define (next1 num)
  (let ((found nil) (coppia nil))
    (cond ((< num 9) (setq str (string (++ num))))
          (true
            (until (or found coppia)
              (++ num)
              (setq str (string num))
              (cond ((apply <= (explode str)) (setq found true))
                    (true
                      (setq coppia nil)
                      (for (i 0 (- (length str) 2) 1 coppia)
                        (if (< (str (+ i 1)) (str i))
                            (set 'coppia true 'idx (+ i 1) 'digit (str i))
                        )
                      )
                      (if coppia
                        (for (i idx (- (length str) 1))
                          (setf (str i) digit)
                        )
                      ))
              )
            ))
    )
    (int str 0 10)))

Facciamo alcune prove:

(next1 2)
;-> 3
(next1 10)
;-> 11
(next1 19)
;-> 22
(next1 21)
;-> 22
(next1 99)
;-> 111
(next1 321)
;-> 333
(next1 1455)
;-> 1456
(next1 98142)
;-> 99999
(time (println (next1 11123159995399999)))
;-> 11123333333333333
;-> 1.996

(map next1 (sequence 0 50))
;-> (1 2 3 4 5 6 7 8 9 11 11 12 13 14 15 16 17 18 19 22 22 22 23 24 25
;->  26 27 28 29 33 33 33 33 34 35 36 37 38 39 44 44 44 44 44 45 46 47
;->  48 49 55 55)
(unique (map next1 (sequence 0 50)))
;-> (1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 22 23 24 25 26 27 28
;->  29 33 34 35 36 37 38 39 44 45 46 47 48 49 55)


---------------------------
La funzione modulo (%, mod)
---------------------------

L'operatore modulo, spesso indicato come "mod" o "%", rappresenta il resto di una divisione.
Una definizione matematica ampiamente accettata è stata fatta da Donald Knuth:

  mod(a, b) = a - b * floor(a / b)

Fare una divisione intera e poi moltiplicarla di nuovo significa trovare il numero più grande più piccolo di "a" che è divisibile per "b" senza resto. Sottraendo questo da "a" si ottiene il resto della divisione e quindi il modulo.

Nei linguaggi di programmazione esistono due principali implementazioni di "mod", che scelgono il segno del risultato a seconda dei segni del dividendo "a" e del divisore "b":

1) La divisione troncata restituisce: r = a − b*trunc(a/b).
   Pertanto, r ha lo stesso segno del dividendo a.
2) La divisione floor restituisce: r = a − b*floor(a/b).
   Qui, r ha lo stesso segno del divisore b.

Linguaggi e modalità di calcolo del modulo
------------------------------------------

  Linguaggio  (13 mod 3)  (-13 mod 3)  (13 mod -3)  (-13 mod -3)
  ----------  ----------  -----------  -----------  ------------
  C               1            -1          1             -1
  C#              1            -1          1             -1
  C++             1            -1          1             -1
  Erlang          1            -1          1             -1
  Go              1            -1          1             -1
  Java            1            -1          1             -1
  Javascript      1            -1          1             -1
  Kotlin          1            -1          1             -1
  newLISP         1            -1          1             -1
  PHP             1            -1          1             -1
  Rust            1            -1          1             -1
  Scala           1            -1          1             -1
  Swift           1            -1          1             -1
  Haskell         1             2         -2             -1
  Lua             1             2         -2             -1
  Mathematica     1             2         -2             -1
  Python          1             2         -2             -1
  Ruby            1             2         -2             -1
  Zig @rem        1            -1        error          error
  Zig @mod        1             2        error          error

Come si nota newLISP si comporta come il C.

****************
>>>funzione MOD
****************
sintassi: (mod num-1 num-2 [num-3 ... ])
sintassi: (mod num-1)

Calcola il valore modulare dei numeri in "num-1" e "num-2".
mod calcola il resto dalla divisione del numeratore "num-i" per il denominatore num-i + 1.
Nello specifico, il valore restituito è numeratore - n*denominatore, dove n è il quoziente del numeratore diviso per il denominatore, arrotondato per difetto a un numero intero.
Il risultato ha lo stesso segno del numeratore e la sua grandezza è minore della grandezza del denominatore.

Nella seconda sintassi si assume 1 per num-2 e il risultato è la parte frazionaria di num-1.

(mod 10.5 3.3)   →  0.6
(mod -10.5 3.3)  → -0.6
(mod -10.5)      → -0.5

Utilizzare la funzione % (segno di percentuale) quando si lavora solo con numeri interi.

**************
>>>funzione %
**************
sintassi: (% int-1 [int-2 ... ])

Ogni risultato viene diviso successivamente per l'int successivo, quindi viene restituito il resto (operazione modulo). 
La divisione per zero causa un errore. 
Per i numeri in virgola mobile, usa la funzione mod.

For floating point numbers, use the mod function.

(% 10 3)             → 1
(% -10 3)            → -1

I valori in virgola mobile negli argomenti di % vengono troncati al valore intero più vicino a 0 (zero).

I valori in virgola mobile maggiori o minori dei valori interi massimo (9.223.372.036.854.775.807) o minimo (-9.223.372.036.854.775.808) vengono troncati a tali valori.
Ciò include i valori per +Inf e -Inf.

I calcoli che generano valori maggiori di 9.223.372.036.854.775.807 o minori di -9.223.372.036.854.775.808 vanno da positivo a negativo o da negativo a positivo.

I valori in virgola mobile che restituiscono NaN (non un numero), vengono trattati come 0 (zero).
Floating point values in arguments to % are truncated to the integer value closest to 0 (zero).

Adesso vediamo come viene calcolato il modulo negli altri linguaggi (es. Mathematica).

Quando solo il dividendo è negativo
-----------------------------------
Se solo il dividendo è negativo, allora:
Il modulo troncato restituisce il resto negativo e il modulo floor restituisce il resto positivo.
Ad esempio, calcoliamo −9 mod 4:
−9 = 4 * (−2) − 1
e
-9 = 4 * (-3) + 3.
L'uguaglianza nella prima equazione corrisponde alla divisione troncata e implica che −9 mod 4 = −1. 
Il dividendo è negativo, e quindi lo è anche il resto.
L'uguaglianza di quest'ultima equazione corrisponde alla versione floor e implica che −9 mod 4 = 3. 
Il divisore è positivo, e quindi lo è anche il resto.

Quando solo il divisore è negativo
----------------------------------
Se solo il dividendo è negativo, allora:
La divisione troncata restituisce il resto positivo e la divisione floor restituisce il resto negativo.
Ad esempio, calcoliamo 9 mod (-4).
Abbiamo 9 = (−4) * (−2) + 1, che corrisponde alla versione troncata e implica che 9 mod (−4) = 1. 
Il dividendo e il risultato sono entrambi positivi.
In alternativa, 9 = (−4) * (−3) − 3, che è la versione floor vale 9 mod (−4) = −3. 
Il divisore e il resto sono negativi.

Quando sia il divisore che il dividendo sono negativi
-----------------------------------------------------
Se sia il divisore che il dividendo sono negativi, sia la divisione troncata che la divisione floor restituiscono il resto negativo.
Ad esempio, calcoliamo (-9) mod (-4).
Abbiamo floor(−9/(−4)) = floor(9/4) = 2 e trunc(−9/(−4)) = trunc(9/4) = 2.
Quindi, l'uguaglianza (−9) = (−4) * 2 − 1 corrisponde sia alla divisione troncata che a quella floored, e implica che in entrambi i casi abbiamo (−9) mod (−4) = (−9) − (− 4)*2 = (−9) + 8 = −1. 
Il dividendo, il divisore e il resto sono tutti negativi.

Scriviamo una funzione che calcola il modulo come Mathematica:

(define (%% a b)
  (cond ((and (>= a 0) (>= b 0)) (% a b))
        ; dividendo e divisore entrambi negativi
        ((and (< a 0) (< b 0)) (% a b))
        ; dividendo negativo e divisore positivo
        ((and (< a 0) (> b 0)) (+ (% a b) b))
        ;(dividendo positivo e divisore negativo
        ((and (> a 0) (< b 0)  (+ (% a b) b)))
        (true (println "error"))
  ))

(%% 9 4)
;-> 1
(%% -9 4)
;-> 3
(%% 9 -4)
;-> -3
(%% -9 -4)
;-> -1

Versione migliore (più efficiente):

(define (%% a b)
  (if (= (sgn a) (sgn b))
      (% a b)
      (+ (% a b) b)))

(%% 9 4)
;-> 1
(%% -9 4)
;-> 3
(%% 9 -4)
;-> -3
(%% -9 -4)
;-> -1

Versione definitiva per numeri interi:

(define (%% a b) (% (+ (% a b) b) b))

(%% 9 4)
;-> 1
(%% -9 4)
;-> 3
(%% 9 -4)
;-> -3
(%% -9 -4)
;-> -1

Versione definitiva per numeri in virgola mobile:

(define (modmod a b) (mod (add (mod a b) b) b))

(modmod 10.3 3.2)
;-> 0.7
(modmod -10.3 3.2)
;-> 2.5
(modmod 10.3 -3.2)
;-> -2.5
(modmod -10.3 -3.2)
;-> -0.7


--------------------------------
Generazione di un grafo regolare
--------------------------------

Dati due numeri interi positivi n,k con n> k >= 1, generare una matrice nxn binaria tale che ogni riga e ogni colonna contenga esattamente k valori 1 e la diagonale maggiore sia tutta con valori 0.
Questa è la matrice di adiacenza di un grafo orientato regolare.

Un grafo regolare è un grafo in cui ogni vertice ha lo stesso numero di vicini, cioè ogni vertice ha lo stesso grado.
Nel caso di grafi orientati, un grafo regolare deve soddisfare anche la proprietà che il grado in uscita e quello in entrata siano uguali.

(define (%% a b) (% (+ (% a b) b) b))

(define (graph n k)
  (setq out (array-list (array n n '())))
  (for (i 0 (- n 1))
    (for (j 0 (- n 1))
      (if (< (%% (- i j 1) n) k)
          (setf (out i j) 1)
          (setf (out i j) 0)
      )
    )
  )
  out)

Facciamo alcune prove:

(graph 2 1)
;-> ((0 1) (1 0))

(graph 5 3)
;-> ((0 0 1 1 1) 
;->  (1 0 0 1 1) 
;->  (1 1 0 0 1) 
;->  (1 1 1 0 0) 
;->  (0 1 1 1 0))

(graph 3 1)
;-> ((0 0 1)
;->  (1 0 0)
;->  (0 1 0)

(graph 6 2)
;-> ((0 0 0 0 1 1) 
;->  (1 0 0 0 0 1) 
;->  (1 1 0 0 0 0) 
;->  (0 1 1 0 0 0) 
;->  (0 0 1 1 0 0) 
;->  (0 0 0 1 1 0))

(graph 5 4)
;-> ((0 1 1 1 1) 
;->  (1 0 1 1 1) 
;->  (1 1 0 1 1) 
;->  (1 1 1 0 1) 
;->  (1 1 1 1 0))


--------------------------------
Disordine di una lista di numeri
--------------------------------

Per calcolare il "disordine" di una lista esistono diverse misure.
Il seguente articolo elenca 11 misure per il "disordine":

Vladmir Estivill-Castro, Derick Wood "A survey of adaptive sorting algorithms." ACM 1992
"Lo sviluppo di nuovi algoritmi di ordinamento sfrutta l'ordine esistente nella sequenza di input e molti di loro raggiungono la massima adattabilità (ottimalità) rispetto a diverse misure di disordine."

Inversione in una lista X = (x1, x2, ..., xn): quando per (i,j) risulta i < j e xi > xj.

Vediamo brevemente alcune misure di disordine:

Inv: numero di inversioni per passare dalla lista originale a quella ordinata.
Dis: la distanza più lunga eseguita da una inversione
Max: la distanza maggiore che un elemento deve fare per essere ordinato
Exc: minimo numero di scambi per ordinare la sequenza
Rem: il numero minimo di elementi che devono essere spostati per ordinare

La maggior parte delle misure è orientato dal metodo di ordinamento utilizzato.

Vediamo un metodo generico per misurare il "disordine" proposto da Andrushenko Alexander:

https://cs.stackexchange.com/questions/11836/how-to-measure-sortedness

Data una qualsiasi lista (a b c ...) la confrontiamo con la lista ordinata contenente gli stessi elementi, contiamo il numero di corrispondenze e lo dividiamo per il numero di elementi nella sequenza.
Ad esempio data la successione (5 1 2 3 4) si procede come segue:

1) ordinare la sequenza: (1 2 3 4 5)

2) confrontare la sequenza ordinata con l'originale spostandola di una posizione alla volta e contando il numero massimo di corrispondenze:

          (5 1 2 3 4)
  (1 2 3 4 5)                            1 match
  
          (5 1 2 3 4)
    (1 2 3 4 5)                          0 match
  
          (5 1 2 3 4)
      (1 2 3 4 5)                        0 match
  
          (5 1 2 3 4)
        (1 2 3 4 5)                      0 match
  
          (5 1 2 3 4)
          (1 2 3 4 5)                    0 match
  
          (5 1 2 3 4)
            (1 2 3 4 5)                  4 matches
  
          (5 1 2 3 4)
              (1 2 3 4 5)                0 match
  
          (5 1 2 3 4)
                (1 2 3 4 5)              0 match
  
          (5 1 2 3 4)
                  (1 2 3 4 5)            0 match

3) Il numero massimo di corrispondenze è 4, possiamo calcolare "quanto è ordinata" come 4/5 = 0.8.

Il numero di confronti da fare tra le due liste vale 2*length(lst) - 1.

L'ordinamento di una sequenza ordinata sarebbe 1 e l'ordinamento di una sequenza con elementi posti in ordine inverso sarebbe 1/n.

L'idea alla base di questa definizione è stimare la quantità minima di lavoro che dovremmo fare per convertire qualsiasi sequenza nella sequenza ordinata.
Nell'esempio sopra abbiamo bisogno di spostare un solo elemento, il 5 (ci sono molti modi, ma spostare il 5 è il più efficiente).
Quando gli elementi verrebbero posizionati in ordine inverso, avremmo bisogno di spostare 4 elementi.
E quando la sequenza è stata ordinata, non è necessario alcun lavoro.

Scriviamo una funzione che implementa questo metodo.

La funzione restituisce una lista con tre valori:
(valore minimo, valore della lista, valore massimo)
Il valore minimo rappresenta il valore di massimo disordine della lista e vale 1/len (quando la lista data è completamente disordinata).
Il valore della lista è il valore di ordine calcolato per la lista data.
Il valore massimo vale 1 (quando la lista data ordinata)

Il parametro op determina il tipo di ordinamento (crescente "<" o decrescente ">")

(define (ordered lst op)
  (local (srt len conta conta-max a b)
    (setq op (or op '<))
    ; ordinamento della lista (in base a op)
    (setq srt (sort (copy lst) op))
    (setq len (length lst))
    ; numero massimo di match tra gli elementi
    (setq conta-max 0)
    ; confronto tra tutti gli elementi delle due liste
    (setq conta 0)
    (map (fn(x y) (if (= x y) (++ conta))) lst srt)
    (setq conta-max (max conta conta-max))
    ; confronti tra gli elementi delle due liste
    ; left->right: from 1 to (len - 1)
    ; right->left: from 1 to (len - 1)
    (for (k 1 (- len 1))
      ; from left to right
      (setq a (slice lst 0 k))
      (setq b (slice srt (- k) k))
      ;(println a { } b)
      ; conta il numero di match
      (setq conta 0)
      (map (fn(x y) (if (= x y) (++ conta))) a b)
      (setq conta-max (max conta conta-max))
      ; from right to left
      (setq a (slice lst (- k) k))
      (setq b (slice srt 0 k))
      ;(println a { } b)
      ; conta il numero di match
      (setq conta 0)
      (map (fn(x y) (if (= x y) (++ conta))) a b)
      (setq conta-max (max conta conta-max))
    )
    ;(println conta-max)
    (list (div len) (div conta-max len) 1)))

Facciamo alcune prove:

(setq lst '(5 4 3 2 1))
(ordered lst <)
;-> (0.2 0.2 1)
Questa lista ha il massimo disordine (0.2) perchè è ordinata in senso opposto (decrescente) all'operatore utilizzato "<".
Se utilizziamo l'operatore ">", allora la lista ha il massimo ordine (1).
(ordered lst >)
;-> (0.2 1 1)

Quindi il tipo di "disordine" dipende dal tipo di ordinamento considerato.
Utilizzando entrambi gli operatori sulla stessa lista possiamo capire meglio il "disordine" della lista data.

(setq lst '(1 2 3 4 9 8 7 6))
(ordered lst <)
;-> (0.125 0.5 1)
(ordered lst >)
;-> (0.125 0.5 1)

(setq lst '(5 1 2 3 4))
(ordered lst <)
;-> (0.2 0.8 1)
(ordered lst >)
;-> (0.2 0.2 1)

(setq lst (rand 20 20))
;-> (11 3 16 11 9 7 17 16 14 3 17 14 10 6 0 1 7 2 3 19)
(ordered lst >)
;-> (0.05 0.2 1)
(ordered lst <)
;-> (0.05 0.15 1)

Un altro metodo per calcolare il "disordine" è quello di calcolare il valore massimo e la somma delle distanze degli indici tra gli elementi della lista data e quelli della lista ordinata (bubble-sort like).
Esempio:

  index  0 1 2 3 4
    lst (5 1 2 3 4)
  
  index  0 1 2 3 4
    srt (1 2 3 4 5)

  numero 5: indice passa da 0 a 4 --> 4
  numero 4: indice passa da 4 a 3 --> 1
  numero 3: indice passa da 3 a 2 --> 1
  numero 2: indice passa da 2 a 1 --> 1
  numero 1: indice passa da 1 a 0 --> 1

In questo caso il valore massimo vale 4 e la somma delle distanze vale 8.

(setq lst '(1 2 3 4 5))
;-> (0 0)
(setq lst '(5 4 3 2 1))
;-> (4 12)
(setq lst '(5 1 2 3 4))
;-> (4 8)

(define (disordered lst op)
  (local (srt a b dist dist-max dist-sum a1 b1 val1 idx1 val2 idx2 coppia)
    (setq op (or op '<))
    ; ordinamento della lista (in base a op)
    (setq srt (sort (copy lst) op))
    ; crea una lista (elemento indice) della lista data
    (setq a (map (fn(x) (list x $idx)) lst))
    ; crea una lista (elemento indice) della lista ordinata
    (setq b (map (fn(x) (list x $idx)) srt))
    ; reset distanze
    (setq dist 0)
    (setq dist-max 0)
    (setq dist-sum 0)
    ; copia delle liste per associazione/eliminazione 1:1
    ; delle coppie (valore indice) delle due liste
    (setq a1 a)
    (setq b1 b)
    ; ciclo per associare le coppie (valore indice) delle due liste
    ; e calcolare le distanze tra gli indici
    (dolist (el a)
      (setq idx1 (el 1)) ; indice lista data
      (setq val1 (el 0)) ; valore lista data
      ; trova la coppia con il valore val1 nella lista ordinata
      (find (list val1 '?) b1 match)
      ; coppia trovata nella lista ordinata
      (setq coppia $0)
      (setq idx2 (coppia 1)) ; indice lista ordinata
      ;(println idx1 { } idx2)
      ; eliminazione degli elementi correnti dalle liste copia
      ; (altrimenti non potremmo associare le coppie delle liste in modo 1:1)
      (pop b1 (find coppia b1))
      (pop a1 (find el a1))
      ; calcolo del valore massimo
      (setq dist (abs (- idx2 idx1)))
      (setq dist-max (max dist-max dist))
      (setq dist-sum (+ dist-sum dist))
      ;(println dist { } dist-sum { } dist-max)
    )
    (list dist-max dist-sum)))

Facciamo alcune prove:

(setq lst '(1 2 3 4 5))
(disordered lst)
;-> (0 0)

(setq lst '(5 4 3 2 1))
(disordered lst)
;-> (4 12)

(setq lst '(5 1 2 3 4))
(disordered lst)
;-> (4 8)

Anche in questo caso il valore del "disordine" dipende dal tipo di ordinamento che adottiamo:

(setq lst '(1 2 3 4 9 8 7 6))
(disordered lst <)
;-> (3 8)
(disordered lst >)
;-> (7 32)

(setq lst '(5 1 2 3 4))
(disordered lst <)
;-> (4 8)
(disordered lst >)
;-> (3 8)

(setq lst '(11 3 16 11 9 7 17 16 14 3 17 14 10 6 0 1 7 2 3 19))
(disordered lst >)
;-> (19 104)
(disordered lst <)
;-> (15 156)


------------------------------
Scambio di coppie in una lista
------------------------------

Data una lista di numeri con almeno due elementi e un numero pari di elementi, scambiare di posto ad ogni coppia di elementi.

Esempi:
input:  (1 2 3 4 5 6)
output: (2 1 4 3 6 5)

input:  (0 1 0 1)
output: (1 0 1 0)

La funzione deve essere la più breve possibile (tipo CodeGolf).

(setq a '(1 2 3 4 5 6))
(setq a '(0 1 0 1))

53 caratteri
(flat (map (fn(x) (list (x 1) (x 0))) (explode a 2)))

47 caratteri
(flat(map(fn(x)(list(x 1)(x 0)))(explode a 2)))
;-> (2 1 4 3 6 5)

34 caratteri
(flat (map reverse (explode a 2)))

32 caratteri
(flat(map reverse(explode a 2)))
;-> (2 1 4 3 6 5)


------------
Numeri Wonky
------------

I numeri wonky (traballanti) sono numeri di 3 o più cifre che soddisfano uno o più dei seguenti criteri:

1) Qualsiasi cifra seguita da tutti zeri: 100, 70000
2) Stessa cifra per tutto il numero: 1111, 7777777
3) Le cifre sono in ordine strettamente ascendente consecutivo: 1234, 1234567890 (per 0 vedi sotto)
4) Le cifre sono in ordine strettamente decrescente consecutivo: 4321, 9876543210
5) Il numero è un numero palindromo: 1221, 123321

Sia per i numeri ascendenti che per quelli discendenti 0 viene per ultimo.
Ascendente:  1234567890
Discendente: 9876543210

Esempi:
Il numero 122 non è ascendente,
Il numero 1245 non è Wonky perché manca 3.

Scrivere una funzione per verificare se un numero è Wonky:

Test 1) es. 100, 70000, ...

(define (t1 num)
  (let (str (slice (string num) 1))
    (= str (dup "0" (length str)))))

(t1 2000000)
;-> true
(t1 2000010)
;-> nil

Test 2) es 1111, 7777777, ...

(define (t2 num)
  (= num (* (div (- (pow 10 (length num)) 1) 9) (% num 10))))

(t2 1111)
;-> true
(t2 1112)
;-> nil

Test 3) 1234, 1234567890, ... (strettamente crescente consecutivo)

(define (t3 num)
  (let (str (string num))
    (if (= (str -1) "0") (setq str (chop str)))
    (and
         ; numero strettamente crescente ?
         (apply <= (explode str))
         ; ultima_cifra - prima_cifra == lunghezza_numero - 1 ?
         (= (- (int (str -1)) (int (str 0))) (- (length str) 1)))))

(t3 1234)
;-> true
(t3 12340)
;-> true
(t3 1340)
;-> nil
(t3 12344)
;-> nil
(t3 12034)
;-> nil

Test 4) 4321, 9876543210, ... (strettamente decrescente consecutivo)

(define (t4 num)
  (let (str (string num))
         ; numero strettamente decrescente ?
    (and (apply >= (explode str))
         ; prima_cifra - ultima_cifra == lunghezza_numero - 1 ?
         (= (- (int (str 0)) (int (str -1))) (- (length str) 1)))))

(t4 4321)
;-> true
(t4 43210)
;-> true
(t4 643210)
;-> nil

Test 5) 1221, 123321, ... (palindromi)

(define (t5 num)
  (let (str (string num))
    (= str (reverse (copy str)))))

(t5 1221)
;-> true
(t5 1222)
;-> nil

Un numero è Wonky se soddisfa uno o più criteri (t1...t5), quindi utilizziamo l'operatore "or".
Per decidere l'ordine delle funzioni(criteri) nell'operatore "or" vediamo la loro velocità (perchè gli operatori "or" e "and" usano la "short circuit evaluation"):

(silent (setq a (rand 123456789012345678 1000)))

(time (map t1 a) 100)
;-> 87.137
(time (map t2 a) 100)
;-> 27.737
(time (map t3 a) 100)
;-> 294.102
(time (map t4 a) 100)
;-> 271.083
(time (map t5 a) 100)
;-> 71.515

Ordine di velocità (dalla più veloce alla più lenta): t2, t5, t1, t4, t3.

(define (wonky? num)
  (if (< (length num) 3)
      nil
      (or (t2 num) (t5 num) (t1 num) (t4 num) (t3 num))))

Facciamo alcune prove:

(wonky? 100)
;-> true
(wonky? 12344321)
;-> true
(wonky? 77777777777)
;-> true
(wonky? 132)
;-> nil
(wonky? 321)
;-> true
(wonky? 122)
;-> nil
(wonky? 987789)
;-> true
(wonky? 98765)
;-> true
(wonky? 120000)
;-> nil
(wonky? 100001)
;-> true
(wonky? 786)
;-> nil
(wonky? 890)
;-> true

(filter wonky? (sequence 1 1000))
;-> (100 101 111 113 120 121 123 131 133 141 151 161 171 181 191 200 202
;->  210 212 220 222 224 230 232 234 242 244 252 262 272 282 292 300 303
;->  311 313 321 323 331 333 335 340 343 345 353 355 363 373 383 393 400
;->  404 414 422 424 432 434 442 444 446 450 454 456 464 466 474 484 494
;->  500 505 515 525 533 535 543 545 553 555 557 560 565 567 575 577 585
;->  595 600 606 616 626 636 644 646 654 656 664 666 668 670 676 678 686
;->  688 696 700 707 717 727 737 747 755 757 765 767 775 777 779 780 787
;->  789 797 799 800 808 818 828 838 848 858 866 868 876 878 886 888 890
;->  898 900 909 919 929 939 949 959 969 977 979 987 989 997 999 1000)


-------------------------------
Equazione ax + by + cz + dw = 0
-------------------------------

Risolvere l'equazione:

  a*x + b*y +c*z + d*w = 0

dove a,b,c,d sono numeri interi.

Poniamo g=gcd(a,b) e h=gcd(c,d) l'equazione diventa un sistema lineare Diofantino:

  a*x + b*y = g*u
  c*z + d*w = h*v
  g*u + u*v = 0

dove u,v sono numeri interi.

Per risolvere il sistema poniamo:

  h = (h*n3)/j
  v = (-g*n3)/j
  dove j = gcd(g,h)

Se consideriamo (x0,y0) come una soluzione "speciale" di a*x b*y=g e analogamente (z0,w0) una soluzione "speciale" di c*z d*w=h, allora le soluzioni sono

  x = (b*n1)/g + (-x0*h*n3)/j
  y = (-a*n1)/g + (-y0*h*n3)/j
  z = (d*n2)/h + (z0*g*n3)/j
  w = (-c*n2)/h + (w0*g*n3)/j

dove n1,n2 e n3 sono numeri interi qualsiasi.

Le soluzioni "speciali" (x0,y0) e (z0,w0) possono essere calcolate con l'agoritmo di euclide esteso.

(define (extended-euclid a b)
  (local (x0 y0 x y d)
  (cond ((zero? b) (list 1 0 a))
        (true
          (map set '(x0 y0 d) (extended-euclid b (% a b)))
          (map set '(x y) (list y0 (- x0 (* (/ a b) y0))))
          (list x y d)))))

Vediamo un esempio:

(setq a -6 b 3 c 7 d 8)

(setq g (gcd a b))
;-> 3
(setq h (gcd c d))
;-> 1
(setq j (gcd g h))
;-> 1

Primo set di valori per n1,n2,n3:
(setq n3 j)
(setq n2 h)
(setq n1 g)

Secondo set di valori per n1,n2,n3:
;(setq n3 1)
;(setq n2 1)
;(setq n1 1)

(setq u (/ (* n3 h) j))
;-> 1
(setq v (/ (* (- g) n3) j))
;-> -3

(setq x0y0 (extended-euclid a b))
;-> (0 1 3)
(setq x0 (x0y0 0))
;-> 0
(setq y0 (x0y0 1))
;-> 1
(setq z0w0 (extended-euclid c d))
;-> (-1 1 1)
(setq z0 (z0w0 0))
;-> -1
(setq w0 (z0w0 1))
;-> 1

(setq x (+ (/ (* b n1) g) (/ (* (- x0) h n3) j)))
;-> 3
(setq y (+ (/ (* (- a) n1) g) (/ (* (- y0) h n3) j)))
;-> 5
(setq z (+ (/ (* d n2) h) (/ (* z0 g n3) j)))
;-> 5
(setq w (+ (/ (* (- c) n2) h) (/ (* w0 g n3) j)))
;-> -4
(list x y z w)
;-> (3 5 5 -4)

Verifichiamo la soluzione:

(define (equation x y z w)
  (+ (* a x) (* b y) (* c z) (* d w)))

(equation x y z w)
;-> 0

Scriviamo la funzione che calcola la soluzione:

(define (solve a b c d n1 n2 n3)
  (local (g h j u v x0y0 x0 y0 z0w0 z0 w0)
    (setq g (gcd a b))
    (setq h (gcd c d))
    (setq j (gcd g h))
    (setq n1 (or n1 g))    
    (setq n2 (or n2 h))
    (setq n3 (or n3 j))
    (setq u (/ (* n3 h) j))
    (setq v (/ (* (- g) n3) j))
    ; calcolo soluzioni speciali
    (setq x0y0 (extended-euclid a b))
    (setq x0 (x0y0 0))
    (setq y0 (x0y0 1))
    ; calcolo soluzioni speciali
    (setq z0w0 (extended-euclid c d))
    (setq z0 (z0w0 0))
    (setq w0 (z0w0 1))
    ; calcolo soluzioni
    (setq x (+ (/ (* b n1) g) (/ (* (- x0) h n3) j)))
    (setq y (+ (/ (* (- a) n1) g) (/ (* (- y0) h n3) j)))
    (setq z (+ (/ (* d n2) h) (/ (* z0 g n3) j)))
    (setq w (+ (/ (* (- c) n2) h) (/ (* w0 g n3) j)))
    (setq verify (+ (* a x) (* b y) (* c z) (* d w)))
    (list x y z w verify)))

Facciamo alcuni esempi:
(solve -6 3 7 8 1 1 1)
;-> (1 1 5 -4 0)

Se non passiamo i valori per n1, n2 e n3, allora prendono i valori di g, h e j rispettivamente.
(solve -6 3 7 8)
;-> (3 5 5 -4 0)

(solve 1 2 3 4)
;-> (1 -1 3 -2 0)

Vediamo un problema simile con una soluzione brute-force.

Risolvere l'equazione:

  a*x + b*y +c*z + d*w = 0

dove a,b,c,d sono numeri interi noti compresi tra -999 e 999,
e le soluzioni x,y,z,w sono numeri interi diversi da 0.

La soluzione, se esiste, deve avere somma minima dei valori assoluti della soluzione, cioè il valore più piccolo di |x|+|y|+|z|+|w|.

(setq segni '( (1 1 1 1) (1 1 1 -1) (1 1 -1 1) (1 1 -1 -1)
               (1 -1 1 1) (1 -1 1 -1) (1 -1 -1 1) (1 -1 -1 -1)
               (-1 1 1 1) (-1 1 1 -1) (-1 1 -1 1) (-1 1 -1 -1)
               (-1 -1 1 1) (-1 -1 1 -1) (-1 -1 -1 1) (-1 -1 -1 -1) ))

(define (solve a b c d limit)
  (local (val-min x1 y1 z1 w1 xx yy zz ww out)
    (setq stop nil)
    (setq val-min 99999)
    ; brute force
    (for (x 1 limit 1 stop)
      (for (y 1 limit 1 stop)
        (for (z 1 limit 1 stop)
          (for (w 1 limit 1 stop)
            ; per ogni quadrupla di valori x,y,z,w
            ; applichiamo i 16 segni
            (dolist (s segni)
              ; assegnazione valori a x,y,z,w
              (map set '(x1 y1 z1 w1)
                        (map * s (list x y z w)))
              ; controllo soluzione
              (if (zero? (+ (* a x1) (* b y1) (* c z1) (* d w1)))
                  (if (> val-min (+ (abs x1) (abs y1) (abs z1) (abs w1)))
                    (begin
                      (setq xx x1 yy y1 zz z1 ww w1)
                      ; controllo valore minimo
                      (setq val-min (+ (abs x1) (abs y1) (abs z1) (abs w1)))
                      (println xx { } yy { } zz { } ww)
                      ;(setq stop true)
                    )  
                  )
              )
            )
          )
        )
      )
    )
    (list xx yy zz ww val-min)))

(solve 78 -75 24 33 10)
;-> 1 1 4 -3
;-> 1 -1 -5 -1
;-> 2 1 -2 -1
;-> (2 1 -2 -1 6)

(solve 84 62 -52 -52 10)
;-> 1 2 1 3
;-> (1 2 1 3 7)

(solve 26 45 -86 -4 10)
;-> 1 10 6 -10
;-> 2 -6 -3 10
;-> 3 2 2 -1
;-> (3 2 2 -1 8)

(solve 894 231 728 -106 10)
;-> 3 -8 -1 1
;-> (3 -8 -1 1 13)

(solve -170 962 863 -803 10)
;-> 4 3 -10 -8
;-> 5 -4 -2 -8
;-> (5 -4 -2 -8 19)

(solve 3 14 62 74 10)
;-> 2 -2 -8 7
;-> 2 -3 -3 3
;-> 2 -4 2 -1
;-> (2 -4 2 -1 9)

(solve 9923 -9187 9011 -9973 10)
;-> (nil nil nil nil 99999)
(solve 9923 -9187 9011 -9973 20)
;-> 3 17 -7 -19
;-> (3 17 -7 -19 46)


------------------
Numeri primi Gobar
------------------

I numeri primi Gobar sono quei numeri che generano un numero primo quando invertiamo gli 1 e gli 0 nella sua rappresentazione binaria.
Per esempio, 10 è un numero Gobar perchè 10 in base 2 vale "1010", e invertendo gli 1 e gli 0 otteniamo "0101" che rappresenta il numero 5 in notazione binaria che è primo.

(bits 10)
;-> "1010"

(int "0101" 0 2)
;-> 5

Sequenza OEIS A347476:
  4, 5, 8, 10, 12, 13, 18, 20, 24, 26, 28, 29, 32, 34, 40, 44, 46, 50, 52,
  56, 58, 60, 61, 66, 68, 74, 80, 84, 86, 90, 96, 98, 104, 108, 110, 114,
  116, 120, 122, 124, 125, 128, 142, 146, 148, 152, 154, 158, 166, 172, 176,
  182, 184, 188, 194, 196, 202, 208, 212, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

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

Inverte gli 0 e gli 1 di una stringa binaria:

(define (flip str)
  (let (out "")
    (dostring (c str)
      (if (= c 49)
          (extend out "0")
          (extend out "1")))))

(flip "101010000111")
;-> "010101111000"

Funzione che verifica se un numero è primo Gobar:

(define (gobar? num)
  (prime? (int (flip (bits num)) 0 2)))

(gobar? 10)
;-> true

(filter gobar? (sequence 1 215))
;-> (4 5 8 10 12 13 18 20 24 26 28 29 32 34 40 44 46 50 52 56 58 60 61
;->  66 68 74 80 84 86 90 96 98 104 108 110 114 116 120 122 124 125 128
;->  142 146 148 152 154 158 166 172 176 182 184 188 194 196 202 208 212
;->  214)


-----------
1 e 0 primi
-----------

Un numero è 1 e 0 primo se la sua rappresentazione binaria contiene un numero primo di 1 e un numero primo di 0.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (seq limit)
  (local (out0 out1 out01 one zero bin)
    (setq out0 '() out1 '() out01 '())
    (for (i 1 limit)
      (setq one 0)
      (setq zero 0)
      (setq bin (bits i))
      (dostring (b bin) 
        (if (= b 48) (++ zero))
        (if (= b 49) (++ one))
      )
      (if (prime? zero) (push i out0 -1))
      (if (prime? one)  (push i out1 -1))
      (if (and (prime? zero) (prime? one)) (push i out01 -1))
    )
    ;(println out0)
    ;(println out1)
    out01))

(seq 100)
;-> (9 10 12 17 18 19 20 21 22 24 25 26 28 35 37 38 41 42 44 49 50 52
;->  56 65 66 68 72 79 80 87 91 93 94 96)


--------------------
Contatore universale
--------------------

Un contatore universale (o contatore di cifre arbitrarie) è un algoritmo che utilizza simboli/cifre arbitrarie a scopo di conteggio.
Per esempio con i simboli (x y z) il conteggio dovrebbe essere il seguente
  x
  y
  z
  yx
  yy
  yz
  zx
  zy
  zz
  yxx
  yxy
  yxz
  yyx
  yyy
  yyz
  yzx
  yzy
  yzz
  zxx
  ... eccetera

L'idea è quella di convertire in base(numero dei simboli) e quindi invece di convertire i simboli in numeri, si indicizza la lista dei simboli.
Vediamo un esempio:

(setq digits '("x" "y" "z"))
(setq digits-length (length digits))

(define (getnext x)
  (setq out "")
  (cond ((zero? x)
          (push (digits 0) out))
        (true
          (until (zero? x)
            (push (digits (% x digits-length)) out)
            (setq x (/ x digits-length))
          )
        )
  )
  out)

(setq digits '("x" "y" "z"))
(setq digits-length (length digits))
(for (i 0 21) (println (getnext i)))
;-> x
;-> y
;-> z
;-> yx
;-> yy
;-> yz
;-> zx
;-> zy
;-> zz
;-> yxx
;-> yxy
;-> yxz
;-> yyx
;-> yyy
;-> yyz
;-> yzx
;-> yzy
;-> yzz
;-> zxx
;-> zxy
;-> zxz
;-> zyx

Verifichiamo la correttezza del contatore utilizzando le 10 cifre come simboli:

(setq digits '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
(setq digits-length (length digits))
(for (i 0 21) (println (getnext i)))
;-> 0
;-> 1
;-> 2
;-> 3
;-> 4
;-> 5
;-> 6
;-> 7
;-> 8
;-> 9
;-> 10
;-> 11
;-> 12
;-> 13
;-> 14
;-> 15
;-> 16
;-> 17
;-> 18
;-> 19
;-> 20
;-> 21

(setq digits '("a" "b" "c" "1" "2" "3"))
(setq digits-length (length digits))
(for (i 0 21) (println (getnext i)))
;-> a
;-> b
;-> c
;-> 1
;-> 2
;-> 3
;-> ba
;-> bb
;-> bc
;-> b1
;-> b2
;-> b3
;-> ca
;-> cb
;-> cc
;-> c1
;-> c2
;-> c3
;-> 1a
;-> 1b
;-> 1c
;-> 11

Vediamo una funzione che individua i numeri da utilizzare per un determinato range di valori.
Supponiamo di voler utilizzare il range da "baaa" a "dddd":

(setq digits '("a" "b" "c" "d"))
(setq digits-length (length digits))

(define (range str1 str2)
  (local (val a b)
    (setq s1 (explode str1))
    (setq s2 (explode str2))
    (setq val s1)
    (for (i 0 100000)
      (setq val (getnext i))
      ;(print val) (read-line)
      (if (= val str1) (setq a i))
      (if (= val str2) (setq b i))
    )
    (list a b)))

(range "baaa" "dddd")
;-> (64 255)
(getnext 64)
;-> "baaa"
(getnext 255)
;-> "dddd"

Nota: in questo caso il simbolo "a" vale 0, quindi non possiamo avere nessuna valore contatore che inizia per "a".


---------------------------------------------
Invertire parte di una lista o di una stringa
---------------------------------------------

Per invertire parte di una stringa o di una lista possiamo usare la seguente funzione:

(define (reverse-part obj idx len)
  (extend (slice obj 0 idx)             ; parte a sinistra dell'inversione
          (reverse (slice obj idx len)) ; parte dell'inversione
          (slice obj (+ idx len))))     ; parte a destra dell'inversione

Facciamo alcune prove:

(reverse-part "newLISP" 3 3)
;-> "newSILP"
(reverse-part "newLISP" 0 3)
;-> "wenLISP"
(reverse-part '(a b c d e f g) 2 3)
;-> (a b e d c f g)
(reverse-part '(a b c d e f g) 0 2)
;-> (b a c d e f g)
(reverse-part '(1 2 3 4 5 6 7) 0 6)
;-> (6 5 4 3 2 1 7)

Un'altra versione, solo per stringhe:

(define (reverse-part2 str idx len)
  (let (part (slice str idx len))
    (replace part str (reverse part))))

(reverse-part2 "newLISP" 3 3)
;-> "newSILP"
(reverse-part2 "newLISP" 0 3)
;-> "wenLISP"


--------------------------------------
Annidamento di un simbolo in una lista
--------------------------------------

Dato un simbolo S e un numero N, generare una lista in cui il simbolo S compare annidato N volte (cioè una lista annidata a più livelli con il simbol ripetuto in tutte le sottoliste  secondarie.

Esempi:

N = 1, simbolo = a  -->  (a)
N = 2, simbolo = a  -->  (a (a))
N = 3, simbolo = a  -->  (a (a (a)))
N = 4, simbolo = a  -->  (a (a (a (a))))
N = 5, simbolo = a  -->  (a (a (a (a (a)))))
N = 6, simbolo = a  -->  (a (a (a (a (a (a))))))

(define (annida simbolo level)
  (if (= level 1) (cons simbolo)
      (cons simbolo (cons (annida simbolo (- level 1))))))

(annida 'a 1)
;-> (a)
(annida 'a 5)
;-> (a (a (a (a (a)))))
(annida 'a 16)
;-> (a (a (a (a (a (a (a (a (a (a (a (a (a (a (a (a))))))))))))))))

Nota: la lista annidata risultante ha sempre lunghezza 2 (tranne quando N=1).


------------------------
Numero di bit 1 da 1 a n
------------------------

Dato un numero intero n >= 0, restituire il numero totale di bit impostati dei numeri tra 0 e n inclusi.

Sequenza OEIS A000788:
  0, 1, 2, 4, 5, 7, 9, 12, 13, 15, 17, 20, 22, 25, 28, 32, 33, 35, 37,
  40, 42, 45, 48, 52, 54, 57, 60, 64, 67, 71, 75, 80, 81, 83, 85, 88, 
  90, 93, 96, 100, 102, 105, 108, 112, 115, 119, 123, 128, 130, 133, 
  136, 140, 143, 147, 151, 156, 159, 163, 167, 172, 176, 181, 186, ...

(define (ones num)
  (let (sum 0)
    (for (i 0 num) 
      (++ sum (first (count '("1") (explode (bits i))))))
    sum))

(ones 10)
;-> 17

(map ones (sequence 0 40))
;-> (0 1 2 4 5 7 9 12 13 15 17 20 22 25 28 32 33 35 37 
;->  40 42 45 48 52 54 57 60 64 67 71 75 80 81 83 85 88 
;->  90 93 96 100 102)


--------------------------------------------
Triangoli rettangoli con lo stesso perimetro
--------------------------------------------

Dato un perimetro P (intero), trovare tutti i triangoli rettangoli possibili con perimetro uguale a P.

In un triangolo rettangolo risulta:

  P = a + b + c 
  a^2 + b^2 = c^2

quindi dobbiamo trovare i numeri interi a, b e c che soddisfano queste due equazioni.

Un algoritmo semplice consiste nell'eseguire due cicli per a (da 1 a p/2) e b (da 1 a p/3), quindi porre c = p-a-b e verificare se a*a + b*b == c*c.

(define (tri p)
  (local (c out)
    (setq out '())
    (for (a 1 (+ (/ p 2) 0))
      (for (b 1 (+ (/ p 3) 0))
        (setq c (- p a b))
        (if (= (* c c) (+ (* a a) (* b b)))
            (push (list a b c) out -1)
        )
      )
    )
    ; contiamo anche le soluzioni simmetriche (a = x, b = y) (a = y, b = x)
    out))

(setq s (tri 840))
;-> ((210 280 350) (240 252 348) (252 240 348) (280 210 350) (315 168 357) 
;->  (336 140 364) (350 120 370) (360 105 375) (390 56 394) (399 40 401))

Funzione di controllo della soluzione:

(define (check sol p)
  (local (a b c)
    (dolist (el sol)
      (print el {: })
      (setq per (apply + el))
      (if (= per p)
        (print "perimetro: " p { })
        (print "perimetro: " p " (ERROR)")
      )
      (setq a (el 0)) (setq b (el 1)) (setq c (el 2))
      (if (= (* c c) (+ (* a a) (* b b)))
          (println "c^2: " (* c c) ", a^2 + b^2: " (+ (* a a) (* b b)))
          (println "c^2: " (* c c) ", a^2 + b^2: " (+ (* a a) (* b b)) "ERROR")
      ))))

(check s 840)
;-> (210 280 350): perimetro: 840 c^2: 122500, a^2 + b^2: 122500
;-> (240 252 348): perimetro: 840 c^2: 121104, a^2 + b^2: 121104
;-> (252 240 348): perimetro: 840 c^2: 121104, a^2 + b^2: 121104
;-> (280 210 350): perimetro: 840 c^2: 122500, a^2 + b^2: 122500
;-> (315 168 357): perimetro: 840 c^2: 127449, a^2 + b^2: 127449
;-> (336 140 364): perimetro: 840 c^2: 132496, a^2 + b^2: 132496
;-> (350 120 370): perimetro: 840 c^2: 136900, a^2 + b^2: 136900
;-> (360 105 375): perimetro: 840 c^2: 140625, a^2 + b^2: 140625
;-> (390 56 394): perimetro: 840 c^2: 155236, a^2 + b^2: 155236
;-> (399 40 401): perimetro: 840 c^2: 160801, a^2 + b^2: 160801

=============================================================================

