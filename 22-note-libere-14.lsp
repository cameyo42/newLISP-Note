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
4) Qual è la probabilità che un contenitore qualunque contenga k palline?
5) Quante palline devono essere lanciate affinchè tutti i contenitori contengano almeno k palline?

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

(define (p3 M N molt)
  (cond ((= M N)
          (div (log N) (log (log N))))
        ; M > molt * N*(ln(N))^3
        ((> M (mul molt (mul N (pow (log N) 3))))
          (add (div M N) (sqrt (div (mul 2 M (log N)) N))))
        (true
          nil)))

Il parametro "molt" è quanto deve essere maggiore M di N*(ln(N))^3:

  M > molt * N*(ln(N))^3

(p3 10 10 10)
;-> 2.760785993534691
(p3 50 50 10)
;-> 2.867937186023309
(p3 100 100 10)
;-> 3.015473823880991
(p3 2000 10 10)
;-> 230.3485425877029
(p3 10000 25 10)
;-> 450.7454496471808

Funzione di simulazione:

(define (p3-sim M N iter)
  (local (tot bins)
    (setq tot 0)
    (for (i 1 iter)
      (setq bins (array N '(0)))
      ; riempie N contenitori con M palline
      (dolist (idx (rand N M)) (++ (bins idx)))
      (setq tot (+ tot (apply max bins)))
    )
    (div tot iter)))

(p3-sim 10 10 1e5)
;-> 2.75045
(p3-sim 50 50 1e5)
;-> 3.803
(p3-sim 100 100 1e5)
;-> 4.23266
(p3-sim 2000 10 1e5)
;-> 222.05482
(time (println (p3-sim 10000 25 1e5)))
;-> 439.79507
;-> 59660.722

I risultati matematici e quelli delle simulazioni sono abbastanza congruenti.

4) Qual è la probabilità che un contenitore qualunque contenga k palline?

  P(E)  = binom(m k) * (1/n^k) * (1 - 1/n)^(m-k)

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (p4 M N k)
  (mul (binom M k)
       (div 1 (pow N k))
       (pow (sub 1 (div 1 N)) (- M k))))

(p4 10 200 2)
;-> 0.001080779674022367
(p4 100 50 4)
;-> 0.0902079912322042
(p4 100 50 2)
;-> 0.2734139115697736

Funzione di simulazione:

(define (p4-sim M N k bin iter)
  (local (tot bins)
    (setq tot 0)
    (for (i 1 iter)
      (setq bins (array N '(0)))
      ; riempie N contenitori con M palline
      (dolist (idx (rand N M)) (++ (bins idx)))
      (if (= k (bins bin)) (++ tot))
    )
    (div tot iter)))

(p4-sim 10 200 2 0 1e5)
;-> 0.00109
(p4-sim 100 50 4 0 1e5)
;-> 0.09089
(p4-sim 100 50 2 0 1e5)
;-> 0.27368

I risultati matematici e quelli delle simulazioni sono congruenti.

5) Quante palline devono essere lanciate affinchè tutti i contenitori contengano almeno k palline?
Si tratta della domanda numero 2) con k > 1.

Newman e Shepp hanno generalizzato il problema del collezionista di figurine quando si vuole raccogliere k copie di ciascuna figurina.
Sia Tk la prima volta che vengono raccolte k copie di ciascuna figurina.
Allora l'aspettativa in questo caso vale:

  A(Tk) = n*ln(n) + (k - 1)*n*ln(ln(n)) + O(n), per n -> infinito

dove:

  n*ln(n) è il termine dovuto alla figurine originali (prima copia)

e:

  (k - 1)*n*ln(ln(n)) è il termine dovuto alle altre (k - 1) copie

(define (p5 N k)
  (add (mul N (log N))
       (mul (sub k 1) N (log (log N)))))

(p5 10 1)
;-> 23.02585092994046
(p5 100 1)
;-> 460.5170185988092
(p5 10 2)
;-> 31.36617538242002
(p5 100 2)
;-> 613.2349811795992
(p5 1000 2)
;-> 8840.400012898203

Funzione di simulazione:

(define (p5-sim N k iter)
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
        (setq stop (for-all (fn(x) (>= x k)) (array-list bins)))
      )
      (setq tot (+ tot cur))
    )
    (list (div tot iter) tot)))

Nota: per k=1 dobbiamo ottenere risultati simili a "p2" e "p2-sim".

(p5-sim 1 1 1e4)
;-> (1 10000)
(p5-sim 10 1 1e4)
;-> (29.2857 292857)
(time (println (p5-sim 100 1 1e5)))
;-> (519.00168 51900168)
;-> 166524.317

(p5-sim 10 2 1e5)
;-> (46.2694 4626940)
(p5-sim 100 2 1e4)
;-> (727.6312 7276312)
(time (println (p5-sim 1000 2 1e4)))
;-> (9884.672200000001 98846722)
;-> 3392360.719

I risultati matematici e quelli delle simulazioni sono congruenti.


-------------------------------
Invertire le cifre di un numero
-------------------------------

Dato un numero intero positivo, invertire le sue cifre.

Nota: nei numeri invertiti le cifre iniziali che valgono 0 vengono eleminate, per esempio, 52100 diventa 00125, cioè 125.

Metodo iterativo:

Algoritmo
1) Inizializzare rev = 0
2) Ciclo mentre num > 0
     (a) Moltiplicare rev per 10 e aggiungiere
         il resto di num diviso per 10 a rev:
         rev = rev*10 + num%10
     (b) Dividire num per 10
3) Restituire rev

Esempio, numero = 7742:
  num: 7742, rev: 0
  num: 774, rev: 2
  num: 77, rev: 24
  num: 7, rev: 247
  num: 0, rev: 2477

(define (invert-digit num)
  (let (rev 0)
    (while (> num 0)
      ;(println "num: " num ", rev: " rev)
      (setq rev (+ (% num 10) (* rev 10)))
      (setq num (/ num 10))
    )
    ;(println "num: " num ", rev: " rev)
    rev))

(invert-digit 7742)
;-> 2477
(invert-digit 1234567890)
;-> 987654321
(invert-digit 1000)
;-> 1

Metodo newLISP:

(define (inv-dig num) (int (reverse (string num)) 0 10))
(inv-dig 7742)
;-> 2477
(inv-dig 1234567890)
;-> 987654321
(inv-dig 1000)

Vediamo se le due funzioni producono gli stessi risultati:

(silent (setq data (rand 1e7 1e3)))
(= (map invert-digit data)
   (map inv-dig data))
;-> true

Vediamo la velocità delle due funzioni

(silent (setq data (rand 1e7 1e4)))
(time (map invert-digit data) 1000)
;-> 11559.936
(time (map inv-dig data) 1000)
;-> 5573.95


----------------------------
Fattorioni e anti-fattorioni
----------------------------

Un numero "fattorione" (o numero di krishnamurthy) è un numero che è uguale alla somma dei fattoriali di ogni sua cifra, cioè un numero è un fattorione se risulta:

  numero = d1! + d2! + d3! + ... + dn!
  dove d1..dn sono le cifre del numero

Es. 145 = 1! + 4! + 5! = 1 + 24 + 120 = 145

Sequenza OEIS A014080:
  1, 2, 145, 40585

Nota: è stato dimostrato (Poole, 1971) che questi sono gli unici fattorioni possibili.

Un numero "anti-fattorione" è un numero la cui inversione di cifre è uguale alla somma dei fattoriali di ogni sua cifra, cioè un numero è un anti-fattorione se risulta:

  reverse(numero) = dn..d3d2d1 = d1! + d2! + d3! + ... + dn!
  dove d1..dn sono le cifre del numero

Nota: nei numeri invertiti le cifre iniziali che valgono 0 vengono eleminate, per esempio, 52100 diventa 00125, cioè 125.

Es. 541 --> 145 = 1! + 4! + 5! = 1 + 24 + 120 = 145
Es. 863180 --> 081368 = 0! + 8! + 1! + 3! + 6! + 8! =
                      = 1 + 40320 + 1 + 6 + 720 + 40320 = 81368

Sequenza OEIS A101702:
  1, 2, 541, 52100, 58504, 66410, 430000, 863180, 8601400, 17927300,
  27927300, 31000000, 665100000, 3715000000, 6739630000, 11000000000,
  21000000000, 53100000000, 70858000000, 79637300000, 451000000000,
  1715000000000, 2715000000000, 48304000000000, ...

Funzione che calcola la somma dei fattoriali delle cifre di un dato numero:

(define (sum-digit-fact num)
       ; precodifica dei fattoriali da 0 a 9
  (let ((fact '(1 1 2 6 24 120 720 5040 40320 362880))
        (temp num) (out 0))
    (while (> temp 0)
      (setq out (+ out (fact (% temp 10))))
      (setq temp (/ temp 10))
    )
    out))

Funzione che verifica se un numero è un fattorione:

(define (fattorione? num)
  (= (sum-digit-fact num) num))

Calcoliamo i fattorioni fino a 10 milioni:

(time (println (filter fattorione? (sequence 1 1e7))))
;-> (1 2 145 40585)
;-> 14201.792

Funzione che verifica se un numero è un anti-fattorione:

(define (anti-fattorione? num)
  (= (sum-digit-fact num) (int (reverse (string num)) 0 10)))

Calcoliamo gli anti-fattorioni fino a 10 milioni:

(time (println (filter anti-fattorione? (sequence 1 1e7))))
;-> (1 2 541 52100 58504 66410 430000 863180 8601400)
;-> 19845.029

Funzione che verifica se un numero è un anti-fattorione:

(define (anti? num)
  (local (fact rev sum tmp)
    ; precodifica dei fattoriali da 0 a 9
    (setq fact '(1 1 2 6 24 120 720 5040 40320 362880))
    ; numero invertito
    (setq rev 0)
    ; somma dei fattoriali delle cifre
    (setq sum 0)
    (while (> num 0)
      (setq tmp (% num 10))
      (setq sum (+ sum (fact tmp)))
      (setq rev (+ (* rev 10) tmp))
      (setq num (/ num 10))
    )
    (= sum rev)))

(time (println (filter anti? (sequence 1 1e7))))
;-> (1 2 541 52100 58504 66410 430000 863180 8601400)
;-> 23865.854

Funzione che calcola gli anti-fattorioni fino ad un dato limite:

(define (find-anti limit)
  (local (fact num rev sum out tmp)
    ; precodifica dei fattoriali da 0 a 9
    (setq fact '(1 1 2 6 24 120 720 5040 40320 362880))
    (setq out '())
    (for (i 1 limit)
      ; numero corrente
      (setq num i)
      ; numero invertito
      (setq rev 0)
      ; somma dei fattoriali delle cifre
      (setq sum 0)
      (while (> num 0)
        (setq tmp (% num 10))
        (setq sum (+ sum (fact tmp)))
        (setq rev (+ (* rev 10) tmp))
        (setq num (/ num 10))
      )
      ;(println i { } rev { } sum)
      (if (= sum rev) (push i out -1))
    )
    out))

(time (println (find-anti 1e7)))
;-> (1 2 541 52100 58504 66410 430000 863180 8601400)
;-> 16482.133


-------------------------------
Stelle e barre (Stars and bars)
-------------------------------

Quanti sono i modi possibili di nettere m palline in n contenitori?

Il numero di modi per mettere m oggetti identici in n contenitori vale:

  binom(m + n - 1, m) = binom(m + n − 1, n − 1)

La prova consiste nel trasformare gli oggetti in stelle e separare le scatole usando delle barre (da qui il nome).
Per esempio. possiamo rappresentare con *|**||** la seguente situazione: nel primo box c'è un oggetto, nel secondo box ci sono due oggetti, il terzo è vuoto e nell'ultimo box ci sono due oggetti. Questo è un modo per dividere 5 oggetti in 4 caselle.

Possiamo notare che ogni partizione può essere rappresentata usando m stelle e n - 1 barre e ogni permutazione di stelle e barre usando m stelle e n - 1 barre rappresenta una partizione.

Pertanto il numero di modi per dividere m oggetti identici in n contenitori è lo stesso numero delle permutazioni di m stelle e n - 1 barre. Il coefficiente binomiale ci fornisce la formula desiderata:

   binom(m + n − 1, n − 1) = binom(m + n − 1, m)

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (modi m n)
  ;(binom (+ m n (- 1)) (- n 1))
  (binom (+ m n (- 1)) m))

3 palline in 4 contenitori:
(modi 3 4)
;-> 20L
3 palline in 5 contenitori:
(modi 3 5)
;-> 21L
100 palline in 10 contenitori:
(modi 100 10)
;-> 4263421511271L

Possiamo scrivere una funzione che visualizza tutte le combinazioni.

Rappresentiamo una configurazione di "star and bar" (stelle e barre) con una lista.
Vediamo alcuni esempi:

  Lista      Stars and Bars
  (5 0 0)    *****||
  (2 3 0)    **|***|
  (0 5 0)    |*****|
  (4 0 1)    ****||*
  (3 1 1)    ***|*|*
  (0 4 1)    |****|*
  (1 1 3)    *|*|***
  (0 2 3)    |**|***
  (1 0 4)    *||****
  (0 0 5)    ||*****

m --> stars
n --> bars

Versione ricorsiva:

(define (stars-bars m n show)
  (local (out)
    (setq out '())
    ;(aux-sb m n (dup "0" n true))
    (aux-sb m n (array n '(0)))
    out))

(define (aux-sb m n lst)
  ; lst contiene la disposizione corrente
        ; condizione di stop
  (cond ((zero? n)
         (push (array-list lst) out -1)
         (if show (begin (print lst "   ") (print-sb lst))))
        ; assicura che tutte le star sono distribuite
        ((= n 1)
          (setf (lst 0) m)
          (aux-sb 0 0 lst))
        ; ricorsione regolare
        (true
          (for (i 0 m)
            (setf (lst (- n 1)) i)
            ; l'ultimo contenitore ha i stars, imposta e ricorsione
            (aux-sb (- m i) (- n 1) lst)
          ))))

(define (print-sb lst)
  (local (s len)
    (setq len (length lst))
    (setq s "")
    (dolist (el lst)
      (cond ((= el 0)
              (if (!= $idx (- len 1))
                (extend s "|")))
            ((> el 0)
              (if (!= $idx (- len 1))
                  (extend s (dup "*" el) "|")
                  (extend s (dup "*" el))))
      )
    )
    (println s)))

(stars-bars 3 4 true)
;-> (3 0 0 0)   ***|||
;-> (2 1 0 0)   **|*||
;-> (1 2 0 0)   *|**||
;-> (0 3 0 0)   |***||
;-> (2 0 1 0)   **||*|
;-> (1 1 1 0)   *|*|*|
;-> (0 2 1 0)   |**|*|
;-> (1 0 2 0)   *||**|
;-> (0 1 2 0)   |*|**|
;-> (0 0 3 0)   ||***|
;-> (2 0 0 1)   **|||*
;-> (1 1 0 1)   *|*||*
;-> (0 2 0 1)   |**||*
;-> (1 0 1 1)   *||*|*
;-> (0 1 1 1)   |*|*|*
;-> (0 0 2 1)   ||**|*
;-> (1 0 0 2)   *|||**
;-> (0 1 0 2)   |*||**
;-> (0 0 1 2)   ||*|**
;-> (0 0 0 3)   |||***
;-> ((3 0 0 0) (2 1 0 0) (1 2 0 0) (0 3 0 0) (2 0 1 0) (1 1 1 0)
;->  (0 2 1 0) (1 0 2 0) (0 1 2 0) (0 0 3 0) (2 0 0 1) (1 1 0 1)
;->  (0 2 0 1) (1 0 1 1) (0 1 1 1) (0 0 2 1) (1 0 0 2) (0 1 0 2)
;->  (0 0 1 2) (0 0 0 3))

(stars-bars 5 3 true)
;-> (5 0 0)   *****||
;-> (4 1 0)   ****|*|
;-> (3 2 0)   ***|**|
;-> (2 3 0)   **|***|
;-> (1 4 0)   *|****|
;-> (0 5 0)   |*****|
;-> (4 0 1)   ****||*
;-> (3 1 1)   ***|*|*
;-> (2 2 1)   **|**|*
;-> (1 3 1)   *|***|*
;-> (0 4 1)   |****|*
;-> (3 0 2)   ***||**
;-> (2 1 2)   **|*|**
;-> (1 2 2)   *|**|**
;-> (0 3 2)   |***|**
;-> (2 0 3)   **||***
;-> (1 1 3)   *|*|***
;-> (0 2 3)   |**|***
;-> (1 0 4)   *||****
;-> (0 1 4)   |*|****
;-> (0 0 5)   ||*****

Versione iterativa:

(define (star-bar m n)
  (local (out bins stop nz)
    (setq out '())
    (setq bins (array n '(0)))
    ; situazione iniziale
    (setf (bins 0) m)
    (setq stop nil)
    (until stop
      (push (array-list bins) out -1)
            ; ultima configurazione, stop
      (cond ((= (bins -1) m)
            (setq stop true))
            ; movimento della barra più a sinistra (loop interno)
            ((> (bins 0) 0)
              (-- (bins 0))
              (++ (bins 1)))
            (true
              # inserisce la barra successiva nei cicli
              # ovvero, trova la prima voce diversa da zero e la divide
              (setq nz 1)
              (while (zero? (bins nz))
                (++ nz))
              (setf (bins 0) (- (bins nz) 1))
              (++ (bins (+ nz 1)))
              (setf (bins nz) 0))
      )
    )
    out))

(star-bar 3 4)
;-> ((3 0 0 0) (2 1 0 0) (1 2 0 0) (0 3 0 0) (2 0 1 0) (1 1 1 0)
;->  (0 2 1 0) (1 0 2 0) (0 1 2 0) (0 0 3 0) (2 0 0 1) (1 1 0 1)
;->  (0 2 0 1) (1 0 1 1) (0 1 1 1) (0 0 2 1) (1 0 0 2) (0 1 0 2)
;->  (0 0 1 2) (0 0 0 3))

Vediamo se le due funzioni producono risultati uguali:

(= (sort (stars-bars 6 5)) (sort (star-bar 6 5)))
;-> true
(= (sort (stars-bars 7 2)) (sort (star-bar 7 2)))
;-> true


-----------------------------
La funzione "yield" di python
-----------------------------

Quando ho bisogno di convertire codice dal linguaggio python alle volte trovo la funzione "yield".
Per capire nei dettagli tale funzione vedere:

https://stackoverflow.com/questions/231767/what-does-the-yield-keyword-do

Vediamo un "trucco" per convertire "yield" in codice newLISP (in maniera brutale e assolutamente non equivalente, ma serve per capire cosa accade):

Quando vediamo una funzione con istruzioni "yield":

1) Inserire una riga (setq result '()) all'inizio della funzione.
2) Sostituire ogni "yield" expr con (push expr result -1).
3) Inserire una riga che restituisce result alla fine della funzione.

Questo trucco può darci un'idea della logica alla base della funzione, ma ciò che effettivamente accade con yield è significativamente diverso da ciò che accade nell'approccio basato su liste. In molti casi, l'approccio yield sarà molto più efficiente in termini di memoria e anche più veloce. In altri casi, questo trucco ti farà rimanere bloccato in un ciclo infinito, anche se la funzione originale funziona perfettamente.

Vediamo un semplice esempio:

# funzione per creare un generatore
def creaGeneratore():
  lista=range(4)
  for numero in lista:
    yield numero*numero

# crea un generatore di tipo creaGeneratore
generatore=creaGeneratore()

# restituisce un oggetto
print(generatore)
;-> <generator object creaGeneratore at 0x7fe225ce5630>

#uso del generatore
for numero in generatore:
  print(numero)
;-> 0
;-> 1
;-> 4
;-> 9

In newLISP possiamo scrivere:

(define (test n)
  (local (lista result)
    (setq result '())
    (setq lista (sequence 0 (- n 1)))
    (dolist (numero lista)
      (push (* numero numero) result -1)
    )
    result))

(test 4)
;-> (0 1 4 9)


--------------------------------------------
Riflessione di un punto P lungo una linea AB
--------------------------------------------

Dato un punto P e una retta determinata dai punti A e B, calcolare le coordinate del punto Pr che è la riflessione del punto P attraverso la linea AB.

Esempio di riflessione lungo una linea verticale (tipo specchio).

          A
          *
          |
  p1      |    p1r
   *      |     *
     p2   |  p2r
      *   |   *
          |
    p3    |   p3r
     *    |    *
          |
          *
          B

Algoritmo
---------
1.Traslazione (spostamento dell'origine in A): sottrarre A da tutti i punti.

  Pt = P-A
  Bt = B-A

At è l'origine.

2. Rotazione (spostamento di BtAt sull'asse X): dividere tutti i punti per Bt (dividere significa ruotare in senso orario, che qui è il requisito per portarsi sull'asse X).

  Pr = Pt/Bt

3. Riflessione di Pr su BrAr (che non è altro che l'asse X): prendere semplicemente il coniugato del punto.

  Pr-riflesso = conj(Pr)

4. Ripristino dalla rotazione: moltiplicare tutti i punti per Bt.

  Pt-riflesso = conj(Pr)*Bt

5. Ripristino dalla traslazione: aggiungere A a tutti i punti.

  P-riflesso = conj(Pr)*Bt + A

Quindi in definitiva:

Restituire conj(Pr)*Bt + A
dove, Bt = B – A
      Pt = P – A
      Pr = Pt/Bt

Nota: tutte le operazioni sono con i numeri complessi.

Per una spiegazione completa vedi:
https://www.geeksforgeeks.org/reflection-point-line-c/

Funzioni con i numeri complessi:

; Extract real part "real"
(define (real num) (first num))
; Extract imaginary part "imag"
(define (imag num) (last num))
;
;;  (cx-add '(2 4) '(3 2)) ==> (5 6)
(define (cx-add num1 num2)
"Addition of two complex number (cartesian)"
  (list (add (real num1) (real num2)) (add (imag num1) (imag num2))))
;
;; (cx-sub '(5 6) '(3 2)) ==> (2 4)
(define (cx-sub num1 num2)
"Subtraction of two complex number (cartesian)"
  (list (sub (real num1) (real num2)) (sub (imag num1) (imag num2))))
;; (cx-mul '(5 6) '(3 2)) ==> (3 28)
;
(define (cx-mul num1 num2)
"Multiplication of two complex number (cartesian)"
  (list (sub (mul (real num1) (real num2)) (mul (imag num1) (imag num2)))
        (add (mul (imag num1) (real num2)) (mul (real num1) (imag num2)))))
;; (cx-div '(3 28) '(3 2)) ==> (5 6)
;
(define (cx-div num1 num2)
"Division of two complex number (cartesian)"
  (if (and (zero? (real num2)) (zero? imag num2))
    (list nil nil())
    (list (div (add (mul (real num1) (real num2)) (mul (imag num1) (imag num2)))
               (add (mul (real num2) (real num2)) (mul (imag num2) (imag num2))))
          (div (sub (mul (imag num1) (real num2)) (mul (real num1) (imag num2)))
               (add (mul (real num2) (real num2)) (mul (imag num2) (imag num2)))))))
;
; (cx-conj '(-10 3)) ==> (-10 -3)
(define (cx-conj num)
"Conjugate of a complex number"
  (list (real num) (sub (imag num))))

Funzione che riflette il Punto P attraverso la linea AB:

(define (reflect p a b)
  (local (pt bt pr)
  ; Performing translation and shifting origin at A
  (setq pt (cx-sub p a))
  (setq bt (cx-sub b a))
  ; Performing rotation in clockwise direction
  ; BtAt becomes the X-Axis in the new coordinate system
  (setq pr (cx-div pt bt))
  ; Reflection of Pr about the new X-Axis
  ; Followed by restoring from rotation
  ; Followed by restoring from translation
  (cx-add a (cx-mul (cx-conj pr) bt))))

Facciamo alcune prove:

(reflect '(4 7) '(1 1) '(3 3))
;-> (7 4)

(reflect '(-2 -2) '(0 0) '(0 1))
;-> (2 -2)

(reflect '(-2 -2) '(-1 1) '(1 -1))
;-> (2 2)


--------------
Quale nazione?
--------------

(define (which-nation)
  (local (len flag)
  (setq str "aO _Q \\U [[ TNPONZ SPN^ Ng Oh OePN Ob Nb Nc Ob Nb Nb ORPY QORY POVW [X [Y [[ \\Z \\Z ]Z [NNZ ^Y _Y aX aY c] c] d[ f\\ i[ j\\ SNPO`\\ TNNQaVNQ TSaUPQ TSaURP URcTSO UReP TSeQ URfR TSfR TRgR TRhP TPjO sP sO rO rO pN dNNPQQ dY dY fV hU iT lQ mP ")
    (setq flag true)
    (dostring (num str)
      (cond ((= num 32) (println))
            (true
              (setq len (- num 77))
              (if flag
                  (print (dup " " len))
                  (print (dup "█" len))
              )
              (setq flag (not flag)))))))

(which-nation)
;->                     ██
;->                   ████
;->                ████████
;->               ██████████████
;->        █   ██ █████████████
;->       ███ █████████████████
;->  ██████████████████████████
;->   ███████████████████████████
;->   ████████████████████████   █
;->   █████████████████████
;->  █████████████████████
;->  ██████████████████████
;->   █████████████████████
;->  █████████████████████
;->  █████████████████████
;->   █████   ████████████
;->     ██     ████████████
;->    ██         ██████████
;->               ███████████
;->               ████████████
;->               ██████████████
;->                █████████████
;->                █████████████
;->                 █████████████
;->               █ █████████████
;->                  ████████████
;->                   ████████████
;->                     ███████████
;->                     ████████████
;->                       ████████████████
;->                       ████████████████
;->                        ██████████████
;->                          ███████████████
;->                             ██████████████
;->                              ███████████████
;->       █   ██                   ███████████████
;->        █ ████                    █████████ ████
;->        ██████                    ████████   ████
;->        ██████                    ████████     ███
;->         █████                      ███████      ██
;->         █████                        ███
;->        ██████                        ████
;->         █████                         █████
;->        ██████                         █████
;->        █████                          █████
;->        █████                           ███
;->        ███                             ██
;->                                       ███
;->                                       ██
;->                                      ██
;->                                      ██
;->                                    █
;->                        █ ███    ████
;->                        ████████████
;->                        ████████████
;->                          █████████
;->                            ████████
;->                             ███████
;->                                ████
;->                                 ███

Come funziona?

Ogni linea viene codificata come una lista di numeri:

  (numero-spazi-bianchi numero-spazi-neri numero-spazi-bianchi ...)

(setq a '(10 3 5 8 4 12 4))
(setq b '(1 1 1 1 1 1 1 1 1 1))

Funzione che stampa una linea:

(define (line lst ch1 ch2)
  (dolist (el lst)
    (if (even? $idx) ; start with ch1
        (print (dup ch1 el))
        (print (dup ch2 el))
    )
  )
  (println))

(line a "-" "+")
;-> ----------+++-----++++++++----++++++++++++----
(line b "+" "-")
;-> +-+-+-+-+-
(line b " " "█")
;->  █ █ █ █ █

Funzione che stampa una lista di linee:

(define (draw lst ch1 ch2)
  (local ()
    (dolist (el lst)
      (line el ch1 ch2)
    )
  ))

Creiamo una lista di linee casuali:

(setq nums '())
(for (i 1 10) (push (rand 10 10) nums -1))
;-> ((0 5 1 8 5 4 3 8 8 7)
;->  (1 8 7 5 3 0 0 3 1 1)
;->  (9 4 1 0 0 3 5 5 6 6)
;->  (1 6 4 3 0 6 7 8 5 3)
;->  (8 7 9 9 5 1 4 2 8 2)
;->  (7 8 9 9 6 3 2 2 8 0)
;->  (3 0 6 0 0 9 2 2 5 6)
;->  (8 7 4 2 7 4 4 9 7 1)
;->  (5 3 7 6 5 3 1 2 4 8)
;->  (5 9 7 3 1 6 4 0 6 5))

Disegniamo questa lista di linee casuali:

(draw nums "+" "-")
;-> -----+--------+++++----+++--------++++++++-------
;-> +--------+++++++-----+++---+-
;-> +++++++++----+---+++++-----++++++------
;-> +------++++---------+++++++--------+++++---
;-> ++++++++-------+++++++++---------+++++-++++--++++++++--
;-> +++++++--------+++++++++---------++++++---++--++++++++
;-> +++++++++---------++--+++++------
;-> ++++++++-------++++--+++++++----++++---------+++++++-
;-> +++++---+++++++------+++++---+--++++--------
;-> +++++---------+++++++---+------++++++++++-----
;-> ++++++++-------++++--+++++++----++++---------+++++++-
;-> +++++---+++++++------+++++---+--++++--------
;-> +++++---------+++++++---+------++++++++++-----
;-> +---------+---------++++++---+++++++++++++------
;-> +--------++++++++-----+-++++++++----+-----
;-> +++++++----++-----++++++-------+++++++----+---
;-> +++++++++++++------++++-+++++++++---------+++++---
;-> ++++---++++++++---++++--+++++++++--+++++++-----
;-> +-------++++++++---+++++-----------------+++++
;-> +++++-++++++++------++++++-++++++++-+-------

Adesso usiamo le linee della nostra nazione (create con pazienza su un foglio a quadretti):

(setq nazione '((20 2)
                (18 4)
                (15 8)
                (14 14)
                (7 1 3 2 1 13)
                (6 3 1 17)
                (1 26)
                (2 27)
                (2 24 3 1)
                (2 21)
                (1 21)
                (1 22)
                (2 21)
                (1 21)
                (1 21)
                (2 5 3 12)
                (4 2 5 12)
                (3 2 9 10)
                (14 11)
                (14 12)
                (14 14)
                (15 13)
                (15 13)
                (16 13)
                (14 1 1 13)
                (17 12)
                (18 12)
                (20 11)
                (20 12)
                (22 16)
                (22 16)
                (23 14)
                (25 15)
                (28 14)
                (29 15)
                (6 1 3 2 19 15)
                (7 1 1 4 20 9 1 4)
                (7 6 20 8 3 4)
                (7 6 20 8 5 3)
                (8 5 22 7 6 2)
                (8 5 24 3)
                (7 6 24 4)
                (8 5 25 5)
                (7 6 25 5)
                (7 5 26 5)
                (7 5 27 3)
                (7 3 29 2)
                (38 3)
                (38 2)
                (37 2)
                (37 2)
                (35 1)
                (23 1 1 3 4 4)
                (23 12)
                (23 12)
                (25 9)
                (27 8)
                (28 7)
                (31 4)
                (32 3)
                ))

Disegniamo la nostra nazione:

(draw nazione " " "█")

Adesso trasformiamo la lista di coordinate in stringa nel modo seguente:

(20 2) --> (char (+ 20 start)) (char (+ 2 start)) " "
(18 4) --> (char (+ 18 start)) (char (+ 4 start)) " "

Il carattere spazio " " indica la fine di una linea.

(define (lines-str lst start)
  (let (s "")
    (dolist (el lst)
      (dolist (num el)
        (extend s (char (+ start num)))
      )
      (extend s " ")
    )
    s))

(setq s (lines-str nazione 77))
;-> "aO _Q \\U [[ TNPONZ SPN^ Ng Oh OePN Ob Nb Nc Ob Nb Nb ORPY QORY
;->  POVW [X [Y [[ \\Z \\Z ]Z [NNZ ^Y _Y aX aY c] c] d[ f\\ i[ j\\
;->  SNPO`\\ TNNQaVNQ TSaUPQ TSaURP URcTSO UReP TSeQ URfR TSfR TRgR
;->  TRhP TPjO sP sO rO rO pN dNNPQQ dY dY fV hU iT lQ mP "

Funzione che stampa la stringa come lista di linee:

(define (plot str ch1 ch2)
  (local (len flag start)
    (setq flag true)
    (setq start 77)
    (dostring (num str)
      (cond ((= num 32) (println))
            (true
              (setq len (- num start))
              (if flag
                  (print (dup ch1 len))
                  (print (dup ch2 len))
              )
              (setq flag (not flag)))
     ))))

Disegniamo la nostra stringa:

(plot s " " "█")

Infine la funzione "which-nation":

(define (which-nation)
  (local (len flag start)
  (setq str "aO _Q \\U [[ TNPONZ SPN^ Ng Oh OePN Ob Nb Nc Ob Nb Nb ORPY QORY POVW [X [Y [[ \\Z \\Z ]Z [NNZ ^Y _Y aX aY c] c] d[ f\\ i[ j\\ SNPO`\\ TNNQaVNQ TSaUPQ TSaURP URcTSO UReP TSeQ URfR TSfR TRgR TRhP TPjO sP sO rO rO pN dNNPQQ dY dY fV hU iT lQ mP ")
    (setq flag true)
    (setq start 77)
    (dostring (num str)
      (cond ((= num 32) (println))
            (true
              (setq len (- num start))
              (if flag
                  (print (dup " " len))
                  (print (dup "█" len))
              )
              (setq flag (not flag)))))))

Nota: l'Italia appare "allungata" perchè il rapporto della cella del terminale non è 1:1 (cioè non è un quadrato).


------------------
Reservoir Sampling
------------------

Il Reservoir Sampling è una famiglia di algoritmi random per la scelta casuale di k elementi da una lista di n elementi, dove n è un numero molto grande.
Data una lista di numeri scrivere una funzione per selezionare casualmente k numeri distinti, dove 1 <= k <= n.

Questo problema può essere risolto in tempo O(n) con un'idea  simile a quella dell'algoritmo di mescolamento Fisher–Yates shuffle (vedi "Fisher-Yates shuffle" su "Note libere 7").

Algoritmo
1) Creare una lista reservoir[0..k-1] e copiare i primi k elementi di stream[].
2) Considerare uno per uno tutti gli elementi dal (k+1)-esimo all'n-esimo elemento.
   2a) Generare un numero casuale j da 0 a i dove i è l'indice dell'elemento corrente in stream[].
   2b) Se j è compreso tra 0 e k-1, sostituire reservoir[j] con stream[i].

(define (select-k lst k)
  (local (reservoir len)
    (setq len (length lst))
    ; initializza reservoir con i primi k elementi di lst
    (setq reservoir (slice lst 0 k))
    ; indice per gli elementi di lst (parte da k)
    (setq idx k)
    ; ciclo
    (while (< idx len)
      (setq j (rand (+ idx 1)))
      (if (< j k) (setq (reservoir j) (lst idx)))
      (++ idx)
    )
    reservoir))

(setq a '(1 2 3 4 5 6 7 8 9 10 11 12))

(select-k a 5)
;-> (10 12 8 7 11)
(select-k a 5)
;-> (6 12 7 4 8)
(select-k a 5)
;-> (4 3 9 5 8)
(select-k a 5)
;-> (3 7 3 4 5)
(select-k a 5)
;-> (10 2 6 12 5)
(select-k a 12)
;-> (1 2 3 4 5 6 7 8 9 10 11 12)

Test di correttezza sui valori distinti:

Vediamo se vengono estratti valori multipli su 10000 selezioni di 500 elementi dalla lista (1..1000):

(setq t (sequence 1 1000))
(for (i 1 1e4)
  (setq s (select-k t 500))
  (if (!= s (unique s)) (println "Errore: " s))
)
;-> nil

Test di correttezza statistica:

Creiamo una lista con i valori di centomila selezioni di 10 elementi dalla lista (1..20)

(silent
  (setq c (sequence 1 20))
  (setq all '())
  (for (i 1 1e5)
    (extend all (select-k c 10))
  )
)

Contiamo le frequenze dei valori contenuti nella lista:

(count c all)
;-> (50151 50072 49527 50169 49983 50064 49863 49894 49861 50496
;->  49988 49893 50044 50089 50012 49972 50234 49906 49810 49972)


-------------------------------------------
Punti di intersezione tra due circonferenze
-------------------------------------------

Equazione del cerchio con centro C (cx, cy) e raggio R:

  (x - cx)^2 - (y - cy)^2 = R^2

Algoritmo: http://paulbourke.net/geometry/circlesphere/

Funzione che restituisce i punti di intersezione di due cerchi.

Ogni cerchio è descritto dal suo centro (x,y) e raggio (r).

(define (cc x0 y0 r0 x1 y1 r1)
  (local (d a h x2 y2 x3 y3 x4 y4)
    ; cerchio 1: (x0, y0), raggio r0
    ; cerchio 2: (x1, y1), raggio r1
    (setq d (sqrt (add (mul (sub x1 x0) (sub x1 x0))
                       (mul (sub y1 y0) (sub y1 y0)))))
    (cond ((> d (add r0 r1)) nil)        ; nessuna intersezione
          ((< d (abs (sub r0 r1))) nil)  ; un cerchio incluso nell'altro
          ((and (zero? d) (= 0 1)) nil ) ; cerchi coincidenti
          (true                          ; intersezione
            (setq a (div (add (mul r0 r0) (sub (mul r1 r1)) (mul d d))
                         (mul 2 d)))
            (setq h (sqrt (sub (mul r0 r0) (mul a a))))
            (setq x2 (add x0 (div (mul a (sub x1 x0)) d)))
            (setq y2 (add y0 (div (mul a (sub y1 y0)) d)))
            (setq x3 (add x2 (div (mul h (sub y1 y0)) d)))
            (setq y3 (sub y2 (div (mul h (sub x1 x0)) d)))
            (setq x4 (sub x2 (div (mul h (sub y1 y0)) d)))
            (setq y4 (add y2 (div (mul h (sub x1 x0)) d)))
            (list x3 y3 x4 y4)))))

Facciamo alcune prove:

;cerchi inclusi uno nell'altro
(cc 2 2 3 4 4 6)
;-> nil
; cerchi intersecanti
(cc 7 3 9 -5 -3 6)
;-> (-1.962019151721343 2.174038303442685 0.9620191517213417 -3.674038303442686)
; cerchi intersecanti
(cc 2 2 3 4 4 3)
;-> (4.87082869338697 1.12917130661303 1.12917130661303 4.87082869338697)
; cerchi tangenti esternamente
(cc 0 0 2 5 0 3)
;-> (2 0 2 0)
; cerchi tangenti internamente
(cc 0 0 4 2 0 2)
;-> (4 0 4 0)

Vedi anche "Area di intersezione tra due circonferenze" su "Note libere 9".


-----------------
Clessidra pattern
-----------------

Dato un numero positivo n, scrivere una funzione che stampa il seguente pattern numerico (clessidra).

Per esempio con n = 5:

 1 2 3 4 5
  2 3 4 5
   3 4 5
    4 5
     5
    4 5
   3 4 5
  2 3 4 5
 1 2 3 4 5

(define (clessidra n)
  (local (i j k)
    ; parte superiore
    (for (i 1 n)
      ; stampa "i+1" spazi all'inizio della riga...
      (for (k 1 i) (print " "))
      ; ...poi stampa i valori da "i" a "n"
      (for (j i n) (print j { }))
      (println) ; nuova riga
    )
    ; parte inferiore
    (for (i (- n 1) 1 -1)
      ; stampa "i+1" spazi all'inizio della riga...
      (for (k 1 i) (print " "))
      ; ...poi stampa i valori da "i" a "n"
      (for (j i n) (print j { }))
      (println) ; nuova riga
    )))

(clessidra 9)
;-> 1 2 3 4 5 6 7 8 9
;->  2 3 4 5 6 7 8 9
;->   3 4 5 6 7 8 9
;->    4 5 6 7 8 9
;->     5 6 7 8 9
;->      6 7 8 9
;->       7 8 9
;->        8 9
;->         9
;->        8 9
;->       7 8 9
;->      6 7 8 9
;->     5 6 7 8 9
;->    4 5 6 7 8 9
;->   3 4 5 6 7 8 9
;->  2 3 4 5 6 7 8 9
;-> 1 2 3 4 5 6 7 8 9

(define (clessidra2 n)
  (local (i j k)
    ; parte superiore
    (for (i 1 n)
      ; stampa "i+1" spazi all'inizio della riga...
      (for (k 1 i) (print " "))
      ; ...poi stampa i valori da 1 a n+1-i
      (for (j 1 (+ n 1 (- i))) (print j { }))
      (println) ; nuova riga
    )
    ; parte inferiore
    (for (i (- n 1) 1 -1)
      ; stampa "i+1" spazi all'inizio della riga...
      (for (k 1 i) (print " "))
      ; ...poi stampa i valori da 1 a n+1-i
      (for (j 1 (+ n 1 (- i))) (print j { }))
      (println) ; nuova riga
    )))

(clessidra2 9)
;-> 1 2 3 4 5 6 7 8 9
;->  1 2 3 4 5 6 7 8
;->   1 2 3 4 5 6 7
;->    1 2 3 4 5 6
;->     1 2 3 4 5
;->      1 2 3 4
;->       1 2 3
;->        1 2
;->         1
;->        1 2
;->       1 2 3
;->      1 2 3 4
;->     1 2 3 4 5
;->    1 2 3 4 5 6
;->   1 2 3 4 5 6 7
;->  1 2 3 4 5 6 7 8
;-> 1 2 3 4 5 6 7 8 9


----------------------------
Punti interi e circonferenze
----------------------------

Dato un cerchio centrato nell'origine (0, 0) di raggio r, trovare tutti i punti interi (lattice points) che si trovano sulla circonferenza del cerchio.

Nota: I punti interi (lattice points) sono tutti i punti con coordinate intere.

Sequenza OEIS: A046109
  1, 4, 4, 4, 4, 12, 4, 4, 4, 4, 12, 4, 4, 12, 4, 12, 4, 12, 4, 4,
  12, 4, 4, 4, 4, 20, 12, 4, 4, 12, 12, 4, 4, 4, 12, 12, 4, 12, 4,
  12, 12, 12, 4, 4, 4, 12, 4, 4, 4, 4, 20, ...

Per trovare i punti interi che giacciono sulla circonferenza, dobbiamo trovare i valori di (x, y) che soddisfano l'equazione x^2 + y^2 = r^2.
Per qualsiasi valore di (x, y) che soddisfi l'equazione di cui sopra abbiamo un totale di 4 diverse combinazioni che soddisfano l'equazione.
Ad esempio, se r = 10 e (6, 8) è una coppia che soddisfa l'equazione, allora diventano 4 combinazioni (6, 8) (-6, 8) (6, -8) (-6, -8).

(define (circumference-points r)
  (local (ysquare y out)
    (cond ((zero? r) (setq out 1))
          ((= r 1) (setq out 4))
          (true
            (setq out 4) ; (r, 0), (-r, 0), (0, r) e (0, -r)
            (for (x 1 (- r 1))
              (setq ysquare  (sub (mul r r) (mul x x)))
              (setq y (int (sqrt ysquare)))
              (if (= ysquare (mul y y))
                (setq out (+ out 4)))))
    )
    out))

(circumference-points 5)
;-> 12
(circumference-points 7)
;-> 4
(circumference-points 10)
;-> 12

(map circumference-points (sequence 0 50))
;-> (1 4 4 4 4 12 4 4 4 4 12 4 4 12 4 12 4 12 4 4 12 4 4 4 4 20 12
;->  4 4 12 12 4 4 4 12 12 4 12 4 12 12 12 4 4 4 12 4 4 4 4 20)

Vediamo quali sono le coordinate dei punti sulla circonferenza del cerchio.

(define (circumference-pts r)
  (local (ysquare y four out)
    (cond
      ((zero? r) (setq out '((0 0))))
      (true
        ; (r, 0), (-r, 0), (0, r) e (0, -r)
        (setq out (list (list r 0) (list (- r) 0) (list 0 r) (list 0 (- r))))
        (for (x 1 (- r 1))
          (setq ysquare  (sub (mul r r) (mul x x)))
          (setq y (int (sqrt ysquare)))
          (if (= ysquare (mul y y))
            (begin
              (setq four (list (list x y) (list (- x) y) (list x (- y)) (list (- x) (- y))))
              (extend out four)))))
    )
    out))

(circumference-pts 0)
;-> ((0 0))

(length (circumference-pts 5))
;-> 12
(length (circumference-pts 7))
;-> 4
(length (circumference-pts 10))
;-> 12

(circumference-pts 5)
;-> ((5 0) (-5 0) (0 5) (0 -5) (3 4) (-3 4) (3 -4)
;->  (-3 -4) (4 3) (-4 3) (4 -3) (-4 -3))
(circumference-pts 10)
;-> ((10 0) (-10 0) (0 10) (0 -10) (6 8) (-6 8)
;->  (6 -8) (-6 -8) (8 6) (-8 6) (8 -6) (-8 -6))


-----------------------------
Problema del cerchio di Gauss
-----------------------------

Il problema del cerchio di Gauss è quello di determinare quanti punti interi del reticolo (lattice points) ci sono in un cerchio centrato nell'origine (0, 0) e di raggio r.
Questo numero N(r) vale approssimativamente pi*r^2, l'area all'interno di un cerchio di raggio r.
Questo perché in media ogni quadrato unitario contiene un punto del reticolo.

Pertanto, il numero effettivo di punti reticolari nel cerchio è approssimativamente uguale alla sua area:

  N(r) = π*r^2 + E(r)

dove E(r) è un termine di errore con valore assoluto relativamente piccolo.

Quindi il problema è delimitare l'errore rappresentato dalla differenza tra il numero di punti e l'area, cioè
trovare un limite superiore e superiore per |E(r)|.
Gauss ha dimostrato che per l'errore minimo assoluto vale la seguente relazione:

  |E(min)| <= 2*(sqrt 2)*pi*r

Inoltre è stato dimostrato che E(r) cresce, minimo, come r^(1/2) e, massimo, come r^131/208.
Hardy e Landau (1915) per il limite minimo r^1/2.
Martin Huxley (2000) per il limite massimo r^131/208.

La sequenza di N(r) per r numero intero, genera la sequenza OEIS A000328:

  1, 5, 13, 29, 49, 81, 113, 149, 197, 253, 317, 377, 441

La sequenza dell'area pi*r^2 (arrotondata all'intero più vicino) per r numero intero, genera la sequenza OEIS A075726:

  0, 3, 13, 28, 50, 79, 113, 154, 201, 254, 314, 380, 452

Nota: il raggio r non deve essere necessariamente un numero intero.

Funzione che calcola il numero punti lattice inclusi in un cerchio centrato in (0,0) di raggio r:

(define (circle-points r)
  (local (num r2)
    (set 'num 0 'r2 (mul r r))
    (for (m (- r) r 1)
      (for (n (- r) r 1)
        (if (<= (+ (* m m) (* n n)) r2)
            (++ num)
        )
      )
    )
    num))

(circle-points 12)
;-> 441

Sequenza OEIS A000328:

(map circle-points (sequence 0 20))
;-> (1 5 13 29 49 81 113 149 197 253 317 377 441
;->  529 613 709 797 901 1009 1129 1257)

(circle-points (sqrt 17))
;-> 57

Funzione che calcola l'area di un cerchio con centro in (0,0) e raggio r (integer):

(define (circle-area-int r)
  (int (add 0.5 (mul 3.1415926535897931 r r))))

(circle-area-int 12)
;-> 452

Sequenza OEIS A075726:

(map circle-area-int (sequence 0 20))
;-> (0 3 13 28 50 79 113 154 201 254 314 380 452
;->  531 616 707 804 908 1018 1134 1257)

Funzione che calcola l'area di un cerchio con centro in (0,0) e raggio r (float):

(define (circle-area-float r)
  (mul 3.1415926535897931 r r))

(circle-area-float 12)
;-> 452.3893421169302

(map circle-area-float (sequence 0 20))
;-> (0 3.141592653589793 12.56637061435917 28.27433388230814 50.26548245743669
;->  78.53981633974483 113.0973355292326 153.9380400258999 201.0619298297468
;->  254.4690049407732 314.1592653589793 380.1327110843649 452.3893421169302
;->  530.9291584566751 615.7521601035994 706.8583470577034 804.247719318987
;->  907.9202768874503 1017.876019763093 1134.114947945915 1256.637061435917)

Gauss ha dimostrato che vale la seguente relazione:

  |E(min)| <= 2*(sqrt 2)*pi*r

(define (min-E r)
  (mul 2 (sqrt 2) 3.1415926535897931 r))

Vediamo se la relazione è corretta per r = 1..iter:

(define (test-min iter)
  (for (r 1 iter)
    (if (< (min-E r) (abs (sub (circle-points r) (circle-area-int r))))
        (println r))))

(time (println (test-min 1e3)))
;-> nil
;-> 171916.522 ; 3 minuti 11 secondi

Adesso vediamo quali sono le coordinate dei punti interni al cerchio.

(define (circle-pts r)
  (local (r2 out)
    (set 'r2 (mul r r) 'out '())
    (for (m (- r) r 1)
      (for (n (- r) r 1)
        (if (<= (+ (* m m) (* n n)) r2)
            (push (list m n) out -1)
        )
      )
    )
    out))

(length (circle-pts 12))
;-> 441
(setq all (circle-pts 4))
;-> ((-4 0) (-3 -2) (-3 -1) (-3 0) (-3 1) (-3 2) (-2 -3) (-2 -2) (-2 -1)
;->  (-2 0) (-2 1) (-2 2) (-2 3) (-1 -3) (-1 -2) (-1 -1) (-1 0) (-1 1)
;->  (-1 2) (-1 3) (0 -4) (0 -3) (0 -2) (0 -1) (0 0) (0 1) (0 2) (0 3)
;->  (0 4) (1 -3) (1 -2) (1 -1) (1 0) (1 1) (1 2) (1 3) (2 -3) (2 -2)
;->  (2 -1) (2 0) (2 1) (2 2) (2 3) (3 -2) (3 -1) (3 0) (3 1) (3 2) (4 0))


--------------------
Confronto tra numeri
--------------------

Le seguenti definizioni sono tratte da "The art of computer programming" di Donald Knuth:

bool approximatelyEqual(float a, float b, float epsilon)
{
  return fabs(a - b) <= ( (fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool essentiallyEqual(float a, float b, float epsilon)
{
  return fabs(a - b) <= ( (fabs(a) > fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool definitelyGreaterThan(float a, float b, float epsilon)
{
  return (a - b) > ( (fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool definitelyLessThan(float a, float b, float epsilon)
{
  return (b - a) > ( (fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

Ovviamente, la scelta di epsilon dipende dal contesto e determina quanto vuoi che siano uguali i numeri.


------------------------------------------------------------------
Storia di una intervista per programmatori (Programming interview)
------------------------------------------------------------------

Questa è una storia ipotetica di un programmatore newLISP.

Qx: domanda\questione x dell'intervistatore
Ax: risposta x del programmatore

Q1: Abbiamo una borsa contenente i numeri non ordinati 1, 2, 3, ..., 100.
Ogni numero appare esattamente una volta, quindi ci sono 100 numeri.
Ora un numero viene estratto a caso dalla borsa.
Trova il numero mancante.

A1: Posso usare la funzione "difference":

Lista con 100 elementi:
(setq a (randomize (sequence 1 100)))

Togliamo il primo elemento

(pop a)
;-> 51

(define (manca-uno1 lst)
  (let (len (+ (length lst) 1))
    (difference (sequence 1 len) lst)))

(manca-uno1 a)
;-> (51)

Q2: Ok. Come risolveresti il problema senza usare "difference"?

A2: Posso usare la funzione sort e poi vedere quale indice non è uguale al valore:

(define (manca-uno2 lst)
  (local (len)
    (setq len (+ (length lst) 2))
    (sort lst)
    (setq stop nil)
    (for (i 0 (- len 1) 1 stop)
      (if (!= (lst i) (+ i 1))
        (begin
          (setq stop true)
          (println (+ i 1)))))))

(manca-uno2 a)
;-> 51

Q3: Ok. Questa soluzione ha una complessità temporale O(N*log(N)), perchè viene usato "sort". Supponiamo che sia possibile attraversare la lista solo una volta. Come risolveresti adesso il problema?

A3: Posso usare una soluzione del tipo bit-set. Attraverso la lista e imposto a 1 tutte le celle di un vettore temporaneo che hanno indice uguale ai numeri della lista. Poi attraverso il vettore e cerco il valore 0.

(define (manca-uno3 lst)
  (local (len arr)
    (setq len (+ (length lst) 2))
    (setq arr (array len '(0)))
    (dolist (el lst) (setq (arr el) 1))
    (for (i 1 (- len 1))
      (if (= (arr i) 0) (println i)))))

(manca-uno3 a)
;-> 51

Q4: Bene. Adesso la complessità temporale vale O(n) e la complessità spaziale vale O(N) perchè abbiamo usato un vettore temporaneo. Sapresti risolvere il problema con una complessità spaziale O(1)?

A4: Idea: posso usare la formula della somma di N numeri.
La somma di N numeri vale: (N + 1)*N/2. Per N=100 la somma vale 5050.
Quindi, se tutti i numeri sono presenti nel sacchetto, la somma sarà esattamente 5050. Poiché manca un numero, la somma sarà inferiore a questo, e la differenza è quel numero. Quindi possiamo trovare quel numero mancante nel tempo O(N) e nello spazio O(1).

A questo punto il programmatore pensava di aver risolto il problema, ma all'improvviso ecco una domanda inaspettata:

Q5: Bravo. Ora come risolvi il problema se mancano DUE numeri?

A5: (Prima panico) (poi concentrazione) (e infine soluzione).
Posso usare la formula della somma dei numeri e la formula della somma dei quadrati dei numeri.
In questo modo ottengo un sistema in due equazione che posso risolvere.

              (N + 1)*N
  Somma(N) = -----------
                  2

                      (N + 1)*N*(2*N + 1)
  SommaQuadrati(N) = ---------------------
                              6

La somma dei numeri mancanti (x e y) vale:

  x + y = (st - sc) = k1

dove: sr = somma di tutti i numeri (formula),
      sc = somma dei numeri della lista (calcolata)

La somma del quadrati dei numeri mancanti (x e y) vale:

  x^2 + y^2 = (sqt - sqc) = k2

dove: sqt = somma dei quadrati di tutti i numeri (formula),
      sqc = somma dei quadrati dei numeri della lista (calcolata)

Adesso abbiamo il sistema:

  x + y = k1
  x^2 + y^2 = k2

Le soluzioni del sistema valgono:

  x1 = 1/2*(k1 - sqrt(-(k1^2) + 2*k2))
  y1 = 1/2 (k1 + sqrt(-(k1^2) + 2*k2))
  x2 = 1/2 (k1 + sqrt(-(k1^2) + 2*k2))
  y2 = 1/2 (k1 - sqrt(-(k1^2) + 2*k2))

Adesso possiamo scrivere la funzione:

Funzione che calcola la somma dei numeri di una lista (formula):

(define (sum-nums n) (/ (* n (+ n 1)) 2))

Funzione che calcola la somma dei quadrati dei numeri di una lista (formula):

(define (sqsum-nums n) (/ (* n (+ n 1) (+ (* 2 n) 1)) 6))

(define (manca-due lst)
  (local (len s q k1 k2 x1 y1 x2 y2)
    (setq len (+ (length lst) 2))
    (setq s (sum-nums len))
    (setq q (sqsum-nums len))
    (setq k1 (- s (apply + lst)))
    (setq k2 (- q (apply + (map (fn(x) (* x x)) lst))))
    ;(println k1 { } k2)
    (setq x1 (div (sub k1 (sqrt (add (- (mul k1 k1)) (mul 2 k2)))) 2))
    (setq y1 (div (add k1 (sqrt (add (- (mul k1 k1)) (mul 2 k2)))) 2))
    ; le altre soluzioni sono simmetriche
    ;(setq x2 (div (add k1 (sqrt (add (- (mul k1 k1)) (mul 2 k2)))) 2))
    ;(setq y2 (div (sub k1 (sqrt (add (- (mul k1 k1)) (mul 2 k2)))) 2))
    (list x1 y1)))

Togliamo un elemento dalla lista:

(pop a)
;-> 16

(manca-due a)
;-> (16 51)

Q6: Perfetto.

Nota: Questo metodo può essere esteso a K numeri.
Utilizzando la somma delle i-esime potenze, dove i=1,2,..,k, il problema si riduce il problema alla risoluzione di un sistema di equazioni del tipo:

  a1 + a2 + ... + ak = b1
  a1^2 + a2^2 + ... + ak^2 = b2
  ...
  a1^k + a2^k + ... + ak^k = bk

Per maggiori informazioni vedi: "Data Streams: Algorithms and Applications" di S. Muthukrishnan


--------------------
Trovare il perimetro
--------------------

Calcolare il perimetro della seguente figura:

Soluzione visuale:

           8
    +--------------+
    |              |
    |              |
    |              |
    |              |
    |       +------+
    |       |
 14 |       |       10
    |       +------------------+
    |                          |
    |                          |
    |                          |
    |                          |
    +--------------------------+

Se trasformiano la figura nel modo seguente il perimetro non viene modificato.

           8
    +--------------+
    |              |
    |              |
    |              |
    |          a   |
    |       .......+
    |       .      |
 14 |     c .      | c1     10    a1
    |       .......+-----------+------+
    |          b               .      |
    |                          .      |
    |                          .      |
    |                          .      |
    +--------------------------+------+
                                  b1

Infatti i segmenti a, b e c sono uguali, ripsettivamente, ad a1, b1 e c1.

Adesso possiamo calcolare il perimetro:

  lato sinistro = 14
  lato destro = 14 (2 pezzi che sommano a 14)
  lato superiore = 8 + 9 = 18
  lato inferiore = 8 + 9 = 18

  Perimetro = 14 + 14 + 18 + 18 = 64

Soluzione non-visuale:

Supponiamo che la figura abbia il nord in alto.
Iniziamo dall'angolo nord-ovest e camminiamo verso est seguendo la figura finché non torniamo di nuovo all'angolo nord-ovest di partenza.
La distanza totale che percorriamo verso est è 8 + 10 = 18, quindi anche la distanza totale che percorriamo verso ovest deve essere 18. La distanza totale che percorriamo verso nord è 14, quindi anche la distanza totale che percorriamo verso sud deve essere 14.
Il perimetro quindi vale 18 + 18 + 14 + 14 = 64

Soluzione matematica:

           8
    +--------------+
    |              |
    |              | x
    |              |
    |          a   |
    |       +------+
    |     y |      .
 14 |       |  a   .  10 - a
    |       +------------------+
    |              .           |
    |              .           | z
    |              .           |
    |              .           |
    +--------------------------+
           8          10 - a 

  x + y + z = 14

  Perimetro = 8 + x + a + y + a + 10 - a + z + 10 - a + 8 + 14 =
            = 8 + (x + y + z) + a - a + a - a + 10 + 10 + 8 + 14 =
            = 8 + 14 + 10 + 10 + 8 + 14 = 64


---------------
Numeri speciali
---------------

Prendiamo un numero (x) e creiamo la lista completa dei numeri formati eliminando le singole cifre dalla sua rappresentazione in base dieci (d1,d2,...,dn).
Se la somma di tutti questi nuovi numeri è uguale a x, chiamiamo il numero un numero speciale.
In altre parole, trovare i numeri n tali che la somma di tutti i numeri formati eliminando una cifra da n sia uguale a n.

Esempio:

1729404 = 729404 (tolgo 1) + 129404 (tolgo 7) + 179404 (tolgo 2)
          + 172404 (tolgo 9) + 172904 (tolgo 4) + 172944 (tolgo 0)
          + 172940 (tolgo 4)

13758846 = 3758846 + 1758846 + 1358846 + 1378846 + 1375846
           + 1375846 + 1375886 + 1375884
(in quest'ultimo esempio 1375846 compare due volte)

Sequenza OEIS: A131639
  1729404, 1800000, 13758846, 13800000, 14358846, 14400000, 15000000,
  28758846, 28800000, 29358846, 29400000, 1107488889, 1107489042,
  1111088889, 1111089042, 3277800000, 3281400000, 4388888889, 4388889042,
  4392488889, 4392489042, 4500000000, 5607488889, 5607489042, 5611088889,
  5611089042, 7777800000, 7781400000, 8888888889, 8888889042, 8892488889,
  8892489042, 10000000000, 20000000000, 30000000000, 40000000000,
  50000000000, 60000000000, 70000000000, 80000000000, 90000000000.

La sequenza è completa. In generale, un numero x = x_1 x_2 ... x_n di n cifre appartiene alla sequenza se le sue cifre soddisfano una certa equazione diofantea c_1*x_1 + c_2*x_2 + ... + c_n*x_n = 0, dove i coefficienti c_i dipendono da n. Si può verificare che per n > 11 tutti i coefficienti c_i sono positivi, quindi l'equazione non ammette soluzione diversa da zero.

Proviamo un approccio brute-force (anche se, vista la grandezza dei numeri, è destinato a fallire).

(define (sum-digit num)
  (local (sum str s)
    (setq sum 0)
    (setq str (string num))
    (for (i 0 (- (length num) 1))
      (setq s str)
      (pop s i)
      (++ sum (int s 0 10)))))

Proviamo:

(time (for (i 1729403 1800001) (if (= (sum-digit i) i) (println i))))
;-> 1729404
;-> 1800000
;-> 234.318

(time (for (i 1729403 29400001) (if (= (sum-digit i) i) (println i))))
;-> 1729404
;-> 1800000
;-> 13758846
;-> 13800000
;-> 14358846
;-> 14400000
;-> 15000000
;-> 28758846
;-> 28800000
;-> 29358846
;-> 29400000
;-> 98870.034 ; 1 minuto 39 secondi


--------------
Numeri ciclope
--------------

Un numero naturale è un numero ciclope se la sua rappresentazione binaria contiene uno solo 0 posizionato al centro della rappresentazione.
Si tatta dei numeri binari del tipo:

      0
     101
    11011
   1110111
  111101111

Sequenza OEIS: A129868
  0, 5, 27, 119, 495, 2015, 8127, 32639, 130815, 523775, 2096127, 
  8386559, 33550335, 134209535, 536854527, 2147450879, 8589869055,
  34359607295, 137438691327, 549755289599, 2199022206975, 8796090925055,
  35184367894527, 140737479966719, 562949936644095, ...

Funzione che verifica se un numero è ciclope:

(define (ciclope? num)
  (local (len b)
    (setq b (bits num))
    (setq len (length b))
    (and
      (odd? len)
      (= (length (find-all "1" b)) (- len 1))
      (= (b (+ (/ len 2))) "0"))))

(filter ciclope? (sequence 1 1e5))
;-> (5 27 119 495 2015 8127 32639)

Per trovare i numeri ciclope fino ad un certo limite usiamo una tecnica inversa: costruiamo i numeri binari usando il loro pattern.

Funzione che trova tutti i numeri ciclope fino ad un dato limite:

(define (ciclope limit)
  (local (len num1 b val out)
    (setq out '(0))
    (setq len (length (bits limit)))
    ; numero di 1 a sinistra (o a destra) del numero binario massimo
    (if (odd? len)
        (setq num1 (/ len 2))
        (setq num1 (- (/ len 2) 1))
    )
    ; ciclo per la costruzione dei numeri tramite pattern:
    ; (1..1)0(1..1)
    (for (i 1 num1)
      (setq b (string (dup "1" i) "0" (dup "1" i)))
      (push (int b 0 2) out -1)
    )
    out))

(ciclope 1e5)
;-> (0 5 27 119 495 2015 8127 32639 130815)

(time (println (ciclope 9223372036854775807)))
;-> (0 5 27 119 495 2015 8127 32639 130815 523775 2096127 8386559 33550335
;->  134209535 536854527 2147450879 8589869055 34359607295 137438691327
;->  549755289599 2199022206975 8796090925055 35184367894527 140737479966719
;->  562949936644095 2251799780130815 9007199187632127 36028796884746239
;->  144115187807420415 576460751766552575 2305843008139952127 
;->  9223372034707292159)
;-> 1.995

(ciclope? 9223372034707292159)
;-> true

(bits 9223372034707292159)
;-> "111111111111111111111111111111101111111111111111111111111111111"


---------------------------------
Somma di due quadrati consecutivi
---------------------------------

Determinare se un numero n è la somma di due quadrati consecutivi.

Sequenza OEIS: A001844
  1, 5, 13, 25, 41, 61, 85, 113, 145, 181, 221, 265, 313, 365, 421, 481,
  545, 613, 685, 761, 841, 925, 1013, 1105, 1201, 1301, 1405, 1513, 1625,
  1741, 1861, 1985, 2113, 2245, 2381, 2521, 2665, 2813, 2965, 3121, 3281,
  3445, 3613, 3785, 3961, 4141, 4325, 4513, ...

Scriviamo l'equazione di secondo grado:

  n = k^2 + (k-1)^2
  n = 2*k^2 - 2*k - 1

Risolviamo l'equazione (solo soluzione positiva):

  k = (2 + sqrt(8*n - 4))/2
  k = 1 + sqrt(n - 1)

(define (sum-square? num)
  ;(let (n (div (add 2 (sqrt (sub (mul 8 num) 4))) 2))
  (let (n (add 1 (sqrt (- (* 2 num) 1))))
    ;(println n)
    (= n (int n))))

(sum-square? 18)
;-> nil

(filter sum-square? (sequence 1 1000))
;-> (1 5 13 25 41 61 85 113 145 181 221 265 313
;->  365 421 481 545 613 685 761 841 925)

Per calcolare più velocemente i numeri della sequenza possiamo usare la seguente formula:

  a(n) = 2*n*(n+1)+1

(define (sum-square-to limit)
  (local (out)
    (setq out '())
    (setq i 1)
    (setq val 1)
    (while (< val limit)
      (push val out -1)
      (setq val (+ (* 2 i (+ i 1)) 1))
      (++ i)
    )
    out))

(sum-square-to 1000)
;-> (1 5 13 25 41 61 85 113 145 181 221 265 313
;->  365 421 481 545 613 685 761 841 925)

(= (sum-square-to 1e5) (filter sum-square? (sequence 1 1e5)))
;-> true


----------------------------------------
Somma di almeno due quadrati consecutivi
----------------------------------------

Numeri che possono essere scritti come somma di almeno 2 quadrati di interi positivi consecutivi.

Sequenza OEIS: A174069
  5, 13, 14, 25, 29, 30, 41, 50, 54, 55, 61, 77, 85, 86, 90, 91, 110,
  113, 126, 135, 139, 140, 145, 149, 174, 181, 190, 194, 199, 203, 204,
  221, 230, 245, 255, 265, 271, 280, 284, 285, 294, 302, 313, 330, 355,
  365, 366, 371, 380, 384, 385, 415, 421, 434, 446, 451, ...

(define (sum-squares num)
(catch
  (local (sum lower upper)
    (setq sum 1)
    (setq lower 1)
    (setq upper 1)
    ; limite superiore <= int(sqrt(num))
    (setq max-val (int (sqrt num)))
    ;Exit if the number is found. 
    (while (!= sum num)
            ; se la somma dei quadrati è troppo piccola, 
            ; aggiunge il quadrato successivo e incrementa upper
      (cond ((< sum num)
              (++ upper)
              (setq sum (+ sum (* upper upper))))
            ; se la somma dei quadrati è troppo alta, 
            ; sottrae il primo quadrato, e incrementa lower.
            ((> sum num)
              (setq sum (- sum (* lower lower)))
              (++ lower))
      )
      ; se non può essere espresso come somma 
      ; di quadrati di numeri consecutivi,
      ; allora, alla fine upper supererà il massimo e restituisce nil.
      (if (> upper max-val) (throw nil))
    )
    ;(println lower { } upper)
    ; se lower = upper, allora num = x*x + x*x
    (!= lower upper))))

(filter sum-squares (sequence 1 500))
;-> (5 13 14 25 29 30 41 50 54 55 61 77 85 86 90 91 110 113 126 135 139
;->  140 145 149 174 181 190 194 199 203 204 221 230 245 255 265 271 280 
;->  284 285 294 302 313 330 355 365 366 371 380 384 385 415 421 434 446 
;->  451 476 481 492)

=============================================================================

