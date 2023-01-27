================

 NOTE LIBERE 14

================

-------------------
Triangolo di Hosoya
-------------------

Il triangolo di Hosoya (o di Fibonacci) è una disposizione triangolare di numeri basata sui numeri di Fibonacci.
Ogni numero è la somma di due numeri sopra nella diagonale sinistra o destra.
Le prime righe sono:

               1
              1 1
             2 1 2
            3 2 2 3
           5 3 4 3 5
          8 5 6 6 5 8
       13 8 10 9 10 8 13
     21 13 16 15 15 16 13 21
   34 21 26 24 25 24 26 21 34
  55 34 42 39 40 40 39 42 34 55
...

I numeri in questo triangolo seguono le seguenti relazioni di ricorsive:

  H(0,0) = H(1,0) = v = H(1,1) = H(2,1) = 1
  H(n,i) = H(n-1,i) + H(n-2,i) = H(n-1,i-1) + H(n-2,i-2)

I numeri nel triangolo soddisfano l'identità:

  H(n,j) = F(i+1) * F(n-i+1)

In altre partole, le due diagonali più esterne sono i numeri di Fibonacci, mentre i numeri sulle linee verticali centrali sono i quadrati dei numeri di Fibonacci. Tutti gli altri numeri nel triangolo sono il prodotto di due distinti numeri di Fibonacci maggiori di 1.

Versione ricorsiva

(define (hosoya1 n m)
  (cond ((and (zero? n) (zero? m)) 1)
        ((and (= n 1) (zero? m)) 1)
        ((and (= n 1) (= m 1)) 1)
        ((and (= n 2) (= m 1)) 1)
        (true
          (cond ((> n m)
                  (add (hosoya1 (- n 1) m) (hosoya1 (- n 2) m)))
                ((= n m)
                  (add (hosoya1 (- n 1) (- m 1)) (hosoya1 (- n 2) (- m 2))))
                ((< n m)
                  0)
                (true (println "error:" n { } m))
          ))))

(define (print-hosoya1 n)
  (for (i 0 (- n 1))
    (for (j 0 i)
      (print (hosoya1 i j) " ")
    )
    (println)))

(print-hosoya1 12)
;-> 1
;-> 1 1
;-> 2 1 2
;-> 3 2 2 3
;-> 5 3 4 3 5
;-> 8 5 6 6 5 8
;-> 13 8 10 9 10 8 13
;-> 21 13 16 15 15 16 13 21
;-> 34 21 26 24 25 24 26 21 34
;-> 55 34 42 39 40 40 39 42 34 55
;-> 89 55 68 63 65 64 65 63 68 55 89
;-> 144 89 110 102 105 104 104 105 102 110 89 144

Versione programmazione dinamica

(setq dp (array 3 3 '(0)))

(define (print-hosoya2 n)
  (let (dp (array n n '(0)))
    ; fill dp matrix
    (setq (dp 0 0) 1)
    (setq (dp 1 0) 1)
    (setq (dp 1 1) 1)
    (for (i 2 (- n 1))
      (for (j 0 (- n 1))
        (if (> i j)
            (setf (dp i j) (add (dp (- i 1) j) (dp (- i 2) j)))
        ;else
            (setf (dp i j) (add (dp (- i 1) (- j 1)) (dp (- i 2) (- j 2))))
        )
      )
    )
    ; print triangle
    (for (i 0 (- n 1))
      (for (j 0 i)
        (print (dp i j) " ")
      )
    (println))))

(print-hosoya2 12)
;-> 1
;-> 1 1
;-> 2 1 2
;-> 3 2 2 3
;-> 5 3 4 3 5
;-> 8 5 6 6 5 8
;-> 13 8 10 9 10 8 13
;-> 21 13 16 15 15 16 13 21
;-> 34 21 26 24 25 24 26 21 34
;-> 55 34 42 39 40 40 39 42 34 55
;-> 89 55 68 63 65 64 65 63 68 55 89
;-> 144 89 110 102 105 104 104 105 102 110 89 144


------------------
Divisione Modulare
------------------

Dati tre numeri positivi a, b e m. Calcolare a/b % m.
In altre parole, si tratta di trovare un numero c tale che (b * c) % m = a % m.

La divisione modulare non è sempre possibile
1) la divisione per 0 non è possibile.
2) x/y mod z non è possibile quando y ≡ 0 mod z

La divisione modulare è definita quando esiste l'inverso modulare del divisore.
L'inverso di un numero intero "x" è un altro numero intero "y" tale che (x*y) % m = 1 dove m è il modulo.
Inverso un numero "a" esiste sotto modulo "m" se "a" e "m" sono coprimi, cioè il loro MCD vale 1.

Algoritmo
Verificare se esiste o meno l'inverso di b sotto modulo m.
     a) Se l'inverso non esiste (il MCD di b e m non è 1),
        allora la divisione non è definita.
     b) altrimenti restituire "(inverse * a) % m"

(define (mod-inverse b m)
  (let (g (gcd b m))
    (if (!= g 1)
        -1
        ;else
        ; con b e m coprimi,
        ; il modulo inverso vale b^(m-2) modulo m
        (% (int (pow b (- m 2))) m))))

(define (mod-divide a b m)
  (local (inv)
    (setq a (% a m))
    (setq inv (mod-inverse b m))
    (if (= inv -1)
        nil
        ;else
        (% (* inv a) m))))

Facciamo alcune prove:

(mod-divide 12 3 5)
;-> 4
(mod-divide 8 3 5)
;-> 1
(mod-divide 8 4 5)
;-> 2
(mod-divide 12 3 6)
;-> nil


----------------------------------
Potenza (esponenziazione) modulare
----------------------------------

Dati tre numeri a, b e m, calcolare (a^b) % m.

Per evitare l'overflow possiamo usare la seguente proprietà dell'oprazione modulo:

  (ab) mod m = ((a mod m) (b mod m)) mod m

Per esempio:
  a = 50,  b = 100, m = 13
  50  mod 13  = 11
  100 mod 13  = 9
  (50 * 100) mod 13 = ((50 mod 13) * (100 mod 13)) mod 13

(define (mod-power a b m)
  (let (res 1)
    (setq a (% a m))
    (cond ((zero? a) 0) ; a è divisibile per m
          (true
            (while (> b 0)
              (if (odd? b) (setq res (% (* res a) m)))
              (setq b (/ b 2))
              (setq a (% (* a a) m))
            )
            res))))

Facciamo alcune prove:

(mod-power 1001 20 12)
;-> 1
(mod-power 77 42 10)
;-> 9
(mod-power 2 5 13)
;-> 6


---------------------------------------------------
Aspettativa matematica o valore atteso di una lista
---------------------------------------------------

L'aspettativa o il valore atteso di qualsiasi gruppo di numeri in probabilità è il valore medio di lungo periodo delle ripetizioni dell'esperimento che rappresenta.
Ad esempio, il valore atteso nel lancio di un dado a sei facce è 3,5, perché la media di tutti i numeri che escono in un numero estremamente elevato di lanci è vicina a 3,5.
Più precisamente, la legge dei grandi numeri afferma che la media aritmetica dei valori converge (quasi sicuramente) al valore atteso quando il numero di ripetizioni si avvicina all'infinito.

Esempi:

Lista = (1 2 3 4 5 6)
Aspettativa = 3.5

Lista = (1 9 6 7 8 12)
Aspettativa = 7.16

(define (va lst)
  (letn ((len (length lst))
         (prob (div 1 len)) ; eventi equiprobabili
         (somma 0))
    (apply add (map (fn(x) (mul x prob)) lst))))

Facciamo alcune prove:

(va (sequence 1 6))
;-> 3.5

(va (sequence 1 12))
;-> 6.5

(va '(1 9 6 7 8 12))
;-> 7.166666666666667

Nota: il valore atteso è la media dei valori della lista,
(div (apply add '(1 9 6 7 8 12)) 6)
;-> 7.166666666666667


-------------------------------------------
Script caricato dalla REPL o dal terminale?
-------------------------------------------

La seguente funzione ci permette di determinare se uno script viene caricato dalla REPL di newLISP oppure se viene caricato eseguendo newLISP dal terminale:

; REPL or terminal loading?
; by Lutz
(define (interactive?)
    (not (main-args 1)))

Per caricare uno script dalla REPL:

  (load "script.lsp")

Per caricare uno script dal terminale:

  newlisp script.lsp

Questo ci permette di poter eseguire funzioni differenti in base al tipo di caricamento.

Per esempio, salviamo il file seguente come "test-load.lsp":

;--------------
; test-load.lsp
;
; Questo file si comporta in modo diverso a seconda
; che sia caricato dalla REPL di newLISP: (load "test-load.lsp")
; oppure dal prompt del terminale: newlisp test-load.lsp

(define (interactive?)
    (not (main-args 1)))

(define (print-repl)
  (println "Sessione interattiva"))

(define (print-no-repl)
  (println "Sessione NON interattiva"))

(if (interactive?)
  (begin
    (print-repl)
  )
  ;else 
  (begin
    (print-no-repl)
    (exit)
  )
)
;--------------
;eof

Dalla REPL di newLISP:

(load "test-load.lsp")
;-> Sessione interattiva

Dal prompt del terminale:

c:\newlisp> newlisp test-load.lsp
;-> Sessione NON interattiva

Dalla REPL di newLISP:

(! "newlisp test-load.lsp")
;-> Sessione NON interattiva
;-> 0


-------
Captcha
-------

Un CAPTCHA (Completely Automated Public Turing test to tell Computers and Humans Apart) è un test per determinare se l'utente è umano o meno.
Si genera un CAPTCHA univoco ogni volta che bisogna verificare se l'utente è umano o meno e si chiede all'utente di inserire lo stesso CAPTCHA generato automaticamente e controllando l'input dell'utente con il CAPTCHA generato.
In genere il CAPTCHA viene creato con caratteri grafici di difficile lettura per un computer, ma relativamente facile da leggere per un umano.
In questo esempio, generiamo i CAPTCHA con caratteri ASCII.

Il set di caratteri per generare CAPTCHA contiene "a-z", "A-Z" e "0-9", quindi contiene 62 caratteri.
Per generare un CAPTCHA lungo N si selezionano N caratteri in modo casuale dal set definito.

Stile iterativo:

(define (captcha len)
  (let ((chr "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        (capt ""))
    (while (> len 0)
      (extend capt (chr (rand 62)))
      (-- len)
    )
    capt))

(captcha 12)
;-> "IvDx0tCq8sTJ"
(captcha 10)
;-> "mV0yF3b9Jd"
(captcha 4)
;-> "Gm0M"

Stile newLISP:

(define (captcha len)
  (select "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" 
          (rand 62 len)))

(captcha 12)
;-> "Om0hgUt6ruiT"
(captcha 10)
;-> "ZRLUpiadX0"
(captcha 4)
;-> "nhIa"


-------------------------------------------------------------
Somma della serie (n/1) + (n/2) + (n/3) + (n/4) + ... + (n/n)
-------------------------------------------------------------

Scrivere una funzione per calcolare la seguente serie:

  (n/1) + (n/2) + (n/3) + (n/4) + ... + (n/n)

Sequenza OEIS A006218:
  1 3 5 8 10 14 16 20 23 27 29 35 37 41 45 50 52 58 60 66 70 74 76 84 87
  91 95 101 103 111 113 119 123 127 131 140 142 146 150 158 160 168 170
  176 182 186 188 198 201 207 211 217 219 227 231 239 243 247 249 261 263 ...

Stile iterativo:

Funzione che calcola la somma con divisione intera:

(define (sum-int n)
  (let ((top (int (sqrt n)))
        (sum 0))
    (for (i 1 top)
      (setq sum (+ sum (/ n i)))
    )
    (setq sum (- (* 2 sum) (* top top)))))

(sum-int 10)
;-> 27
(sum-int 100)
;-> 482
(sum-int 1000)
;-> 7069

Stile newLISP:

Funzione che calcola la somma con divisione intera:

(define (somma-int n)
  (apply + (map (curry / n) (sequence 1 n))))

Funzione che calcola la somma con divisione float:

(define (somma-float n)
  (apply add (map (curry div n) (sequence 1 n))))

(somma-int 10)
;-> 27
(somma-float 10)
;-> 29.28968253968254

(somma-int 100)
;-> 482
(somma-float 100)
;-> 518.7377517639619

(somma-int 1000)
;-> 7069
(somma-float 1000)
;-> 7485.470860550351

Verifichiamo che le funzioni calcolano gli stessi valori per le serie intere:

(= (map sum-int (sequence 1 1e4))
   (map somma-int (sequence 1 1e4)))
;-> true

Vediamo la velocità di esecuzione delle funzioni:

(time (sum-int 1000) 10000)
;-> 23.964
(time (somma-int 1000) 10000)
;-> 815.847

Sequenza dei valori per n = 1..100:

(map somma-int (sequence 1 100))
;-> (1 3 5 8 10 14 16 20 23 27 29 35 37 41 45 50 52 58 60 66 70 74 76 84 87
;->  91 95 101 103 111 113 119 123 127 131 140 142 146 150 158 160 168 170
;->  176 182 186 188 198 201 207 211 217 219 227 231 239 243 247 249 261 263
;->  267 273 280 284 292 294 300 304 312 314 326 328 332 338 344 348 356 358
;->  368 373 377 379 391 395 399 403 411 413 425 429 435 439 443 447 459 461
;->  467 473 482)


--------------------------------------
Palline e contenitori (Balls and Bins)
--------------------------------------

Consideriamo il seguente processo stocastico:

  M palline vengono lanciate casualmente in N contenitori.

Il contenitore selezionato per ciascuna delle M palline è determinato in modo uniforme e indipendentemente dagli altri lanci.

Esempio con 5 contenitori e 8 palline (o):

  |   |   |   |   |   |   |   |   |   |
  |oo |   |o  |   |oo |   |   |   |ooo|
  +---+   +---+   +---+   +---+   +---+
    0       1       2       3       4

Che rappresentiamo con:

(setq bins '(2 1 2 0 3))

Funzione che esegue un processo (lancia M palline in N contenitori):

(define (simula M N)
  (let (bins (array N '(0)))
    (dolist (idx (rand N M)) (++ (bins idx)))
    bins))

(simula 8 5)
;-> (0 1 4 3 0)

(define (check-full bins) (not (ref 0 (array-list bins))))

Considerando un contenitore qualunque, con M palline la probabilità che una pallina cada in un contenitore vale 1/N. Quindi il numero di palline di un contenitore k(i) ë distribuito in maniera binomiale con i parametri M e 1/N per ogni contenitore (i).
Quindi:

- in ogni contenitore ci aspettiamo M/N palline
- la probabilità che un contenitore sia vuoto vale (1 - 1/n)^M

Considerando tutti i contenitori i problemi sono più complicati perchè:

- il numero di palline in ogni contenitore dipendono stocasticamente l'uno dall'altro (non sono indipendenti)

Per capirlo, basta immaginare che tutte le M palline siano nel contenitore 1.
Allora il numero di palline negli altri contenitori vale 0.

Vediamo alcuni dei quesiti che si possono formulare su questo processo:

1) Qual è la probabilità che almeno uno dei contenitori contenga almeno due palline?
2) Quante palline in media dobbiamo lanciare affinché tutti i contenitori contengano almeno una pallina?
3) Qual è il carico massimo (previsto) su tutti i contenitori dopo che tutte le palline sono state lanciate?

Confrontiamo i risultati ottenuti con formule matematiche con i risultati delle simulazioni che andremo a implementare.

1) Qual è la probabilità che almeno uno dei contenitori contenga almeno due palline?

La formula matematica è la seguente:

              M-1
  P(E) = (1 -  ∏ (1 - i/N))
              i=1

(define (p1 M N)
  (let (p 1)
    (for (i 1 (- M 1))
      (setq p (mul p (sub 1 (div i N))))
      (println p)
    )
    (list (sub 1 p) p)))

(p1 10 8)
;-> (1 -0)
(p1 5 8)
;-> (0.794921875 0.205078125)
(p1 100 1100)
;-> (0.99036326269542 0.00963673730458005)
(p1 10 1000)
;-> (0.04413938699560271 0.9558606130043973)
(p1 2 1000)
;-> (0.001000000000000001 0.999)
(p1 50 365)
;-> (0.9703735795779884 0.0296264204220116)

Funzione di simulazione:

(define (p1-sim M N iter)
  (local (p bins stop)
    (setq p 0)
    (for (i 1 iter)
      (setq bins (array N '(0)))
      (setq stop nil)
      (dolist (idx (rand N M) stop)
        (++ (bins idx))
        ; se un contenitore ha più di una pallina
        ; allora l'evento corrente è terminato positivamente
        (if (> (bins idx) 1)
          (set 'stop true 'p (+ p 1))
        )
      )
    )
    (div p iter)))

(p1-sim 10 8 1e6)
;-> 1
(p1-sim 5 8 1e6)
;-> 0.794476
(p1-sim 100 1100 1e6)
;-> 0.990304
(p1-sim 10 1000 1e6)
;-> (0.044273)
(p1-sim 2 1000 1e6)
;-> 0.0009829999999999999
(p1-sim 50 365 1e6)
;-> 0.970402

I risultati matematici e quelli delle simulazioni sono congruenti.

Nota: vedi anche "Il problema del compleanno" su "Funzioni Varie".

2) Quante palline in media dobbiamo lanciare affinché tutti i contenitori contengano almeno una pallina?

        N
  T = N*∑(1/i)
       i=1

(define (p2 N)
  (let (sum 0)
    (for (i 1 N)
      (setq sum (add sum (div i)))
    )
    (mul N sum)))

(p2 1)
;-> 1
(p2 10)
;-> 29.28968253968254
(p2 100)
;-> 518.737751763962
(p2 1000)
;-> 7485.470860550343

Funzione di simulazione:

(define (p2-sim N iter)
  (local (cur tot bins stop trovato)
    (setq tot 0)
    (for (i 1 iter)
      (setq bins (array N '(0)))
      (setq stop nil)
      (setq cur 0)
      (until stop
        (++ (bins (rand N)))
        (++ cur)
        ; controllo contenitori...
        ; metodo 1 (più veloce)
        (setq stop (not (find 0 (array-list bins))))
        ; metodo 2
        ;(setq stop (not (ref 0 (array-list bins))))
        ; metodo 3
        ;(setq trovato nil)
        ;(dolist (el bins trovato)
        ;; se un elemento = 0,
        ;; allora i contenitori non hanno tutti almeno una pallina
        ;  (if (zero? el) (setq trovato true))
        ;)
        ;(setq stop (not trovato))
      )
      (setq tot (+ tot cur))
    )
    (list (div tot iter) tot)))

(p2-sim 1 1e5)
;-> (1 100000)
(p2-sim 10 1e5)
;-> (29.2603 2926030)
(time (println (p2-sim 100 1e5)))
;-> (518.07089 51807089)
;-> 45149.834
(time (println (p2-sim 1000 1e4)))
;-> (7491.3304 74913304)
;-> 517297.962

I risultati matematici e quelli delle simulazioni sono congruenti.

Nota: vedi anche "Raccolta di figurine" su "Note libere 6".

3) Qual è il carico massimo (previsto) su tutti i contenitori dopo che tutte le palline sono state lanciate?

"'Balls into Bins' - A Simple and Tight Analysis"
di Martin Raab e Angelika Steger

Per M = N:

         (ln N)
  C = -------------
       (ln (ln N))

Per M >> N*(ln(N))^3:

       M          2*M*ln(N)
  C = --- + sqrt(-----------)
       N             N

=============================================================================

