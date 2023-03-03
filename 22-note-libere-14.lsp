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


----------------------------------
Numeri somma di numeri consecutivi
----------------------------------

Dato un numero N, determinare se un numero può essere espresso come somma di due o più numeri interi consecutivi (non necessariamente a partire da 1).

Un numero espresso con k interi positivi consecutivi ha la forma seguente:

  N = (n+1) + (n+2) + ... + (n+k) = k*(2*n + k - 1)/2 per qualche n

Quindi se esistono k interi consecutivi la cui somma è N, il primo intero (n) vale (con passaggi algebrici):

  n = (2*N − k*(k−1))/2*k

Scriviamo una funzione che verifica se un numero può essere rappresentato come una somma di numeri interi positivi consecutivi.
In caso positivo, restituisce la sequenza di numeri.
In caso negativo, restituisce nil.

(define (sum? num)
  (local (k x continua out)
    (setq out nil)
    (cond
      ((odd? num)
        ; numero dispari N --> N/2 + N - N/2 = N (divisione intera)
        (setq out (list (/ num 2) (- num (/ num 2)))))
        ;(setq out (list num (/ num 2) (- num (/ num 2)))))
      (true ; numero pari
        (setq k 2)
        (setq continua true)
        (while (and (< k (mul 2 (sqrt num))) continua)
          (++ k)
          (setq x (div (sub (mul 2 num) (mul k (sub k 1))) (mul 2 k)))
          (if (= x (int x))
            (begin
              ;(push num out)
              (for (i 0 (- k 1))
                (push (int (+ x i)) out -1)
              )
              (setq continua nil)))))
    )
    out))

Complessità temporale: O(sqrt(N)*log(N))

Facciamo alcune prove:

(sum? 16)
;-> nil
(sum? 1024)
;-> nil
(sum? 23)
;-> (11 12)
(sum? 100)
;-> (18 19 20 21 22)
(sum? 1000)
;-> (198 199 200 201 202)
(sum? 666)
;-> (221 222 223)
(sum? 42)
;-> (13 14 15)
(sum? 1)
;-> (0 1)

Vediamo quanto sono lunghe le sequenze da 1 a 1 milione:

(time (setq m (map length (setq n (map sum? (sequence 1 1e6))))))
;-> 2176.041

(slice m 0 10)
;-> (2 0 2 0 2 3 2 0 2 4)
(slice n 0 10)
;-> ((0 1) nil (1 2) nil (2 3) (1 2 3) (3 4) nil (4 5) (1 2 3 4))

Quanto è lunga la sequenza più lunga?

(apply max m)
;-> 1024

(ref 1024 m)
;-> (527871)

Quali sono i numeri che compongono la sequenza più lunga?

(n (ref 1024 m))
;-> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
;-> ...
;-> 1019 1020 1021 1022 1023 1024 1025 1026 1027)

Verifica:

(length (n (ref 1024 m)))
;-> 1024

Quale numero genera la sequenza più lunga?

(apply + (n (ref 1024 m)))
;-> 527872

Verifica:

(sum? 527872)
;-> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21
;-> ...
;-> 1019 1020 1021 1022 1023 1024 1025 1026 1027)

(= (sum? 527872) (n (ref 1024 m)))
;-> true

Adesso analizziamo i numeri della sequenza:

(filter sum? (sequence 1 1e3))
;-> (1 3 5 6 7 9 10 11 12 13 14 15 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 33 34 35 36 37 38 39 40 41 42 43 44 45 ...
;->  ...
;->  976 977 978 979 980 981 982 983 984 985 986 987 988 989
;->  990 991 992 993 994 995 996 997 998 999 1000)

Quali numeri restano fuori (cioè non sono esprimibili come somma di numeri interi positivi consecutivi)?

(clean sum? (sequence 1 1e3))
;-> (2 4 8 16 32 64 128 256 512)

(clean sum? (sequence 1 1e6))
;-> (2 4 8 16 32 64 128 256 512 1024 2048 4096 8192
;->  16384 32768 65536 131072 262144 524288)

Ipotesi:
restano fuori solo i numeri potenza di 2, cioè i numeri della forma 2^p.

Dimostrazione matematica:

Sia n il nostro numero base, e scegliamo k numeri consecutivi:

 S = n + (n+1) + ... + (n+k−1)

 S = n*k + (k)*(k−1)/2

 S = k*(n + (k−1)/2)

 2S = k*(2*n + k − 1)

Se supponiamo che S è della forma 2^p, allora sia k che (2n+k−1) devono essere entrambi della forma 2^q.
Notiamo che quando k è pari, l'espressione (2*n − 1 + k) genera un numero dispari. Questa è una contraddizione.
Quindi S non può essere della forma 2^p.


-------------------------------
Best time to Buy and Sell Stock
-------------------------------

Problema LeetCode N. 122

Ti viene fornita una lista di numeri interi di prezzi, dove lista(i) è il prezzo di un determinato titolo l'i-esimo giorno.
Ogni giorno puoi decidere di acquistare e/o vendere le azioni.
Puoi detenere al massimo una quota del titolo alla volta.
Tuttavia, puoi acquistarlo e poi venderlo immediatamente lo stesso giorno.

Ad esempio, se la lista vale (2 4 6 8 5 3 1 3 7) il massimo profitto può essere ottenuto acquistando il giorno 0 al prezzo 2, e vendendo il giorno 3 al prezzo 8. Poi acquistando di nuovo il giorno 6 a prezzo 1 e vendendo il giorno 8 al prezzo 7. Profitto totale 6 + 6 = 12.
Se la lista dei prezzi è ordinata in ordine decrescente, allora non può esserci alcun profitto.

(define (maxprofit lst)
  (local (buy sell profit len)
    (setq profit 0)
    (setq len (length lst))
    (setq i 0)
    (while (< i (- len 1))
      ; se valore corrente minore del valore successivo...
      (if (< (lst i) (lst (+ i 1)))
        (begin
          ; allora comprare
          (setq buy i)
          ; andare avanti con i giorni fino a che incontriamo
          ; sempre un valore maggiore
          (while (and (< i (- len 1)) (< (lst i) (lst (+ i 1))))
            (++ i)
          )
          ; adesso vendere, perchè siamo arrivati ad un valore massimo
          (setq sell i)
          ; aggiornare il profitto
          (setq profit (+ profit (- (lst sell) (lst buy))))
          (println "comprare a " (lst buy) " il giorno " buy
                   " e vendere a " (lst sell) " il giorno " sell
                   ": + " (- (lst sell) (lst buy)))
        )
      )
      (++ i)
    )
    profit))

Facciamo alcune prove:

(maxprofit '(2 4 6 8 5 3 1 3 7))
;-> comprare a 2 il giorno 0 e vendere a 8 il giorno 3: + 6
;-> comprare a 1 il giorno 6 e vendere a 7 il giorno 8: + 6
;-> 12
(maxprofit '(7 1 5 3 6 4))
;-> comprare a 1 il giorno 1 e vendere a 5 il giorno 2: + 4
;-> comprare a 3 il giorno 3 e vendere a 6 il giorno 4: + 3
;-> 7
(maxprofit '(1 2 3 4 5))
;-> comprare a 1 il giorno 0 e vendere a 5 il giorno 4: + 4
;-> 4
(maxprofit '(7 6 4 3 2 1))
;-> 0


--------------------------------------------
Analisi degli elementi di una lista/funzione
--------------------------------------------

Scriviamo una funzione che elenca tutti i simboli con i relativi tipi di una lista (o funzione).

(define (index-list lst)
"Create a list of indexes for all the elements of a list"
  (ref-all nil lst (fn (x) true)))

(define (type-of x)
"Get the type of a symbol"
  (let (table '("nil" "true" "int" "float" "string" "symbol" "context"
               "primitive" "import" "ffi" "quote" "list" "lambda"
               "fexpr" "array" "dyn_symbol"))
    (table (& 0xf ((dump x) 1)))))

(define (infos lst)
  (let (index-list (ref-all nil lst (fn (x) true)))
    (dolist (el index-list)
      (println (nth el lst) ": " (type-of (nth el lst))))))

Facciamo alcune prove:

; lista
(setq a '(1 (2 3) "quattro" ("cinque" "sei") 3.1415 sin))
;-> (infos a)
;-> 1: int
;-> (2 3): list
;-> 2: int
;-> 3: int
;-> quattro: string
;-> ("cinque" "sei"): list
;-> cinque: string
;-> sei: string
;-> 3.1415: float
;-> sin: symbol

; funzione
(infos index-list)
;-> (lst): list
;-> lst: symbol
;-> Create a list of indexes for all the elements of a list: string
;-> (ref-all nil lst (lambda (x) true)): list
;-> ref-all: symbol
;-> nil: symbol
;-> lst: symbol
;-> (lambda (x) true): lambda
;-> (x): list
;-> x: symbol
;-> true: symbol

; funzione
(infos infos)
;-> (lst): list
;-> lst: symbol
;-> (let (index-list (ref-all nil lst (lambda (x) true)))
;->  (dolist (el index-list)
;->   (println (nth el lst) ": " (type-of (nth el lst))))): list
;-> let: symbol
;-> (index-list (ref-all nil lst (lambda (x) true))): list
;-> index-list: symbol
;-> (ref-all nil lst (lambda (x) true)): list
;-> ref-all: symbol
;-> nil: symbol
;-> lst: symbol
;-> (lambda (x) true): lambda
;-> (x): list
;-> x: symbol
;-> true: symbol
;-> (dolist (el index-list)
;->  (println (nth el lst) ": " (type-of (nth el lst)))): list
;-> dolist: symbol
;-> (el index-list): list
;-> el: symbol
;-> index-list: symbol
;-> (println (nth el lst) ": " (type-of (nth el lst))): list
;-> println: symbol
;-> (nth el lst): list
;-> nth: symbol
;-> el: symbol
;-> lst: symbol
;-> : : string
;-> (type-of (nth el lst)): list
;-> type-of: symbol
;-> (nth el lst): list
;-> nth: symbol
;-> el: symbol
;-> lst: symbol


--------------
Sequenza crc32
--------------

Si tratta della sequenza dei valori di crc32 dei numeri naturali.

(define (num-crc32 n) (crc32 (string n)))

(num-crc32 42)
;-> 841265288

(define (seq-crc32 limit)
  (map crc32 (map string (sequence 0 limit))))

(seq-crc32 20)
;-> (4108050209 2212294583 450215437 1842515611 4088798008 2226203566
;->  498629140 1790921346 4194326291 2366072709 2707236321 3596227959
;->  1330857165 945058907 2788221432 3510096238 1212055764 1060745282
;->  2944839123 3632373061 2322626082)

Vediamo se c'è qualche "collisione" (numeri ripetuti) fino a 10 milioni:

(new Tree 'hash)

(for (i 1 1e7)
  (setq c (crc32 (string i)))
  (if (nil? (hash c))
      (hash c c)
      (println (hash c) { } c)
  )
  'end
)
;-> end
(delete 'hash)


----------------
Sort con memoria
----------------

Una semplice funzione per ordinare una lista mantenendo anche i valori della lista originale:

(define (mem-sort lst) (map list (sort (copy lst)) lst))

Facciamo un paio di prove:

(setq a '(3 8 6 5 89 76 5 45))
(mem-sort a)
;-> ((3 3) (5 8) (5 6) (6 5) (8 89) (45 76) (76 5) (89 45))

(setq aa (map last (mem-sort a)))
;-> (3 8 6 5 89 76 5 45)
(setq aa-sorted (map first (mem-sort a)))
;-> (3 5 5 6 8 45 76 89)

(setq b '((3 2) (8 4) (6 5) (89 3) (76 4) (5 8)))
(mem-sort b)
;-> (((3 2) (3 2)) ((5 8) (8 4)) ((6 5) (6 5)) ((8 4) (89 3))
;->  ((76 4) (76 4)) ((89 3) (5 8)))

(setq bb (map last (mem-sort b)))
;-> ((3 2) (8 4) (6 5) (89 3) (76 4) (5 8))
(setq bb-sorted (map first (mem-sort b)))
;-> ((3 2) (5 8) (6 5) (8 4) (76 4) (89 3))


-------------
email address
-------------

Caratteri permessi in un indirizzo di posta elettronica (email):

; The local-part of the email address may use any of these ASCII characters:
;
; - uppercase and lowercase Latin letters A to Z and a to z;
; - digits 0 to 9;
; - special characters !#$%&'*+-/=?^_`{|}~;
; - dot ., provided that it is not the first or last character unless quoted, and provided also that it does not appear consecutively unless quoted (e.g. John..Doe@example.com is not allowed but "John..Doe"@example.com is allowed);
; - space and "(),:;<>@[\] characters are allowed with restrictions (they are only allowed inside a quoted string and in addition, a backslash or double-quote must be preceded by a backslash);
; comments are allowed with parentheses at either end of the local-part; e.g. john.smith(comment)@example.com and (comment)john.smith@example.com are both equivalent to john.smith@example.com.

Vediamo due funzioni per offuscare (per gioco) il nostro indirizzo in una pagina web in modo che con newLISP sia facile rivelare il vero indirizzo.

; encode
(define (encode-email str)
  (let (alst (sort (map (fn(x) (list x $idx)) (explode str))))
    (list (join (map first alst)) (map last alst))))

; decode
(define (decode-email str lst)
  (join (map last (sort (map list lst (explode str))))))

(setq email "nome.cognome@provider.com")
(encode-email email)
;-> ("..@ccdeeegimmmnnoooooprrv"
;->  (4 21 12 5 22 18 3 11 19 7 17 2 10 24 0 8 1 6 9 15 23 13 14 20 16))

(decode-email "..@ccdeeegimmmnnoooooprrv" '(4 21 12 5 22 18 3 11 19 7 17 2 10 24 0 8 1 6 9 15 23 13 14 20 16))
;-> "nome.cognome@provider.com"

Nella pagina web:

-----------------------------------------------------------------------------
email:
  str = "..@ccdeeegimmmnnoooooprrv"
  lst = '(4 21 12 5 22 18 3 11 19 7 17 2 10 24 0 8 1 6 9 15 23 13 14 20 16)

(define (decode-email str lst)
  (join (map last (sort (map list lst (explode str))))))
-----------------------------------------------------------------------------

Come funziona?

(setq str "bazzo.go")
;-> "bazzo.go"
; lista associativa (carattere indice)
(setq alst (map (fn(x) (list x $idx)) (explode str)))
;-> (("b" 0) ("a" 1) ("z" 2) ("z" 3) ("o" 4) ("." 5) ("g" 6) ("o" 7))
; ordina la lista associativa per carattere
(setq mlst (sort (copy alst)))
;-> (("." 5) ("a" 1) ("b" 0) ("g" 6) ("o" 4) ("o" 7) ("z" 2) ("z" 3))
; estrae gli indici che rappresentano la posizione di quel carattere
; nella lista associativa
(setq indici (map last mlst))
;-> (5 1 0 6 4 7 2 3)
; estrae i caratteri della lista ordinata e crea la stringa criptata
(setq crypt (join (map first mlst)))
;-> ".abgoozz"
; crea una lista (indice carattere) con la stringa criptata...
(map list indici (explode crypt))
;-> ((5 ".") (1 "a") (0 "b") (6 "g") (4 "o") (7 "o") (2 "z") (3 "z"))
; ... poi la ordina ina base al valore degli indici ...
(sort (map list indici (explode crypt)))
;-> ((0 "b") (1 "a") (2 "z") (3 "z") (4 "o") (5 ".") (6 "g") (7 "o"))
; ... poi prende solo i caratteri ...
(map last (sort (map list indici (explode crypt))))
;-> ("b" "a" "z" "z" "o" "." "g" "o")
; ... e infine ricostruisce la stringa
(join (map last (sort (map list indici (explode crypt)))))
;-> "bazzo.go"


----------------------------------------------
Warden and prisoners (Guardiani e prigionieri)
----------------------------------------------

(define (w-p)
  (set 'start (time-of-day))
  (seed (date-value))
  #choose how many prisoners, and the measure of success
  (set 'prisonerCount 100 'prisonerGoal 90)
  (set 'wincount 0 'losecount 0)
  (dotimes (t 100)
  #set up random lists for the warden and the prisoners
  (set 'warden (randomize (sequence 0 (- prisonerCount 1)))
        'prisoners (randomize (sequence 0 (- prisonerCount 1))))
  #initialize an array that will store how the two lists map to each other
  (set 'prisonerArray (array prisonerCount))
  #populate the array with entries.
  #the index is the number from the prisoners' list
  #the value is the number from the warden's list
  ;(map (fn (x y) (nth-set (prisonerArray x) y)) prisoners warden)
  (map (fn (x y) (setf (prisonerArray x) y)) prisoners warden)
  #initialize the results lists
  (set 'loopList '() 'prisonerDoneList (array prisonerCount))
  #for each prisoner entry
  (dolist (i prisoners)
  #if the prisoner has already been included in a list, go next
      (until (prisonerDoneList i)
  #mark the prisoner as done
          ;(nth-set (prisonerDoneList i) 1)
          (setf (prisonerDoneList i) 1)
  #find what is in the prisoner's box,
  #and start a list with the prisoner
  (set 'x (prisonerArray i) 'oneLoop (list i))
  #repeat until we find a loop
          (until (= x i)
  #put the new box at the end of the list
                  (push x oneLoop -1)
  #mark the new prisoner/box as done
                  ;(nth-set (prisonerDoneList x) 1)
                  (setf (prisonerDoneList x) 1)
  #move on to the next box in the loop
                  (set 'x (prisonerArray x)))
  #when we have a complete loop,
  #add it to the list of loops
          (push oneLoop loopList -1)))
  #create a sorted list with the lengths of the loops
  (set 'loopCount (sort (map length loopList) > ) )
  (if (> (first loopCount) prisonerGoal)
      (inc losecount)
      (inc wincount)))
  #print the results
  (println "prisoners win: " wincount " and prisoners lose: " losecount " in " (- (time-of-day) start) " ms"))

(w-p)
;-> prisoners win: 90 and prisoners lose: 10 in 4 ms
(w-p)
;-> prisoners win: 84 and prisoners lose: 16 in 4 ms


-------------------------------------------------
Valori di default per i parametri di una funzione
-------------------------------------------------

Il metodo classico per definire i valori di default di una funzione è il seguente:

(define (f a b)
   (set
      'a (or a 1)
      'b (or b 3))
   (+ a b b a))

oppure in modo equivalente:

(define (g a b)
   (setq a (or a 1))
   (setq b (or b 3))
   (+ a b b a))

Nessun parametro:
(f)
;-> 8

Solo il parametro a:
(f 2)
;-> 10

Solo il parametro b:

(f nil 3)
;-> 8

Entrambi i parametri:
(f 3 3)
;-> 12

Un altro metodo è il seguente:

(define (foo (a 1) (b 3))
   (println "a:" a " b:" b))

Nessun parametro:
(foo)
;-> a:1 b:3

Solo il parametro a:
(foo 8)
;-> a:8 b:3

Solo il parametro n:
(foo nil 3)
;-> a:nil b:3

Entrambi i parametri:
(foo 8 9)
;-> a:8 b:9


-------------------------
Da iterativo a funzionale
-------------------------

Quando devo convertire codice da un liguaggio iterativo/procedurale incontro spesso situazioni del tipo seguente:

repeat with i = 1 to 10
  #do step a
  println (i * i)
  if i = 5 then next repeat
  #do step b
  println (i * i * i)
end repeat

Ciò significa che per i = 1 2 3 4 6 7 8 9 10 il codice esegue sia il passo "a" che il passo "b" (stampa i^2 e i^3). Per i = 5, il codice esegue solo il passo "a" (stampa i^2), quindi passa a i = 6.

Come convertire questo comportamento in newLISP?

Vediamo due possibili soluzioni:

(for (i 1 10)
  (println i { } (* i i) " a")
  (unless (= i 5) (println i { } (* i i i) " b")))
;-> 1 1 a
;-> 1 1 b
;-> 2 4 a
;-> 2 8 b
;-> 3 9 a
;-> 3 27 b
;-> 4 16 a
;-> 4 64 b
;-> 5 25 a
;-> 6 36 a
;-> 6 216 b
;-> 7 49 a
;-> 7 343 b
;-> 8 64 a
;-> 8 512 b
;-> 9 81 a
;-> 9 729 b
;-> 10 100 a
;-> 10 1000 b

(for (i 1 10)
  (and
    (println i { } (* i i) " a")
    (!= i 5)
    (println i { } (* i i i) " b")))
;-> 1 1 a
;-> 1 1 b
;-> 2 4 a
;-> 2 8 b
;-> 3 9 a
;-> 3 27 b
;-> 4 16 a
;-> 4 64 b
;-> 5 25 a
;-> 6 36 a
;-> 6 216 b
;-> 7 49 a
;-> 7 343 b
;-> 8 64 a
;-> 8 512 b
;-> 9 81 a
;-> 9 729 b
;-> 10 100 a
;-> 10 1000 b


-----------------
La funzione "dup"
-----------------

****************
>>>funzione DUP
****************
sintassi: (dup exp int-n [bool])
sintassi: (dup exp)

Se l'espressione in "exp" restituisce una stringa, verrà replicata "int-n" volte all'interno di una stringa e restituita. Quando si specifica un'espressione che valuta qualcosa di diverso da nil in "bool", la stringa non verrà concatenata, ma replicata in una lista come qualsiasi altro tipo di dati.

Se "exp" contiene qualsiasi tipo di dati diverso da string, la lista restituita conterrà "int-n" valutazioni di "exp".

Senza il parametro di ripetizione, "dup" assume 2.

(dup "*")
;-> "**"
(dup "A" 6)
;-> "AAAAAA"
(dup "A" 6 true)
;-> ("A" "A" "A" "A" "A" "A")
(dup "A" 0)
;-> ""
(dup "AB" 5)
;-> "ABABABABAB"
(dup 9 7)
;-> (9 9 9 9 9 9 9)
(dup 9 0)
;-> ()
(dup 'x 8)
;-> (x x x x x x x x)
(dup '(1 2) 3)
;-> ((1 2) (1 2) (1 2))
(dup "\000" 4)
;-> "\000\000\000\000"

L'ultimo esempio mostra la gestione delle informazioni binarie, creando una stringa piena di quattro zeri binari.

Vedere anche le funzioni "sequence" e "series".

Quindi (dup '(2 3) 3) produce ((2 3)(2 3)(2 3)), ma se vogliamo che produca (2 3 2 3 2 3)?

Possiamo scrivere:

(flat (dup '(2 3) 3))
;-> (2 3 2 3 2 3)

Comunque Sammo ha scritto due funzioni simili per questo:

(define (dup1)
  (flat (dup (chop (args)) ((args) -1))))

(dup1 1 2 3)
;-> (1 2 1 2 1 2)
(dup1 1 10)
;-> (1 1 1 1 1 1 1 1 1 1)
(dup1 '(1 2) 10)
;-> (1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2)
(dup1 '(1 2) "A" 5)
;-> (1 2 "A" 1 2 "A" 1 2 "A" 1 2 "A" 1 2 "A")
(dup1 5)
;-> ()

(define (dup2)
  (apply append (dup (chop (args)) ((args) -1))))

(dup2 1 2 3)
;-> (1 2 1 2 1 2)
(dup2 1 10)
;-> (1 1 1 1 1 1 1 1 1 1)
(dup2 '(1 2) 10)
;-> ((1 2) (1 2) (1 2) (1 2) (1 2) (1 2) (1 2) (1 2) (1 2) (1 2))
(dup2 '(1 2) "A" 5)
;-> ((1 2) "A" (1 2) "A" (1 2) "A" (1 2) "A" (1 2) "A")
(dup2 5)
;-> ()


------------------
Profiler casalingo
------------------

newLISP non ha un profiler, ma possiamo divertirci ugualmente usando la natura introspettiva di newLISP.

L'idea chiave è quella di inserire il codice che ci interessa in una lista.
Per esempio, supponiamo di avere la seguente e di voler conoscere la velocità di creazione delle liste l1, l2 e l3:

(define (test a lst)
(local (l1 l2 l3)
  (setq l1 (map (fn(x) (pow x a)) lst))
  (setq l2 (map (fn(x) (+ (* x x) (* a a))) lst))
  (setq l3 '())
  (dolist (el lst)
    (push (mul a (sin el)) l3 -1)
  )
  (print l1 "\n" l2 "\n" l3)))

(test 3 '(1 2 3 4 5))
;-> (1 8 27 64 125)
;-> (10 13 18 25 34)
;-> (2.524412954423689 2.727892280477045 0.4233600241796016
;->  -2.270407485923784 -2.876772823989415)

Mettiamo le espressioni in una lista:

(setq code '(
  (setq a 3)
  (setq lst (sequence 1 1e5))
  (setq l1 (map (fn(x) (pow x a)) lst))
  (setq l2 (map (fn(x) (+ (* x x) (* a a))) lst))
  (setq l3 '())
  (dolist (el lst) (push (mul a (sin el)) l3 -1))
  'end))

E poi eseguiamo ogni espressione con la funzione "time":

(dolist (expr code) (println (time (eval expr)) ": " expr))
;-> 0: (setq a 3)
;-> 0.997: (setq lst (sequence 1 100000))
;-> 8.074999999999999: (setq l1 (map (lambda (x) (pow x a)) lst))
;-> 9.994999999999999: (setq l2 (map (lambda (x) (+ (* x x) (* a a))) lst))
;-> 0: (setq l3 '())
;-> 10.023: (dolist (el lst) (push (mul a (sin el)) l3 -1))
;-> 0: 'end

Eseguendo di nuovo il codice della lista otteniamo risultati leggermente differenti:

(dolist (expr code) (println (time (eval expr)) ": " expr))
;-> 0: (setq a 3)
;-> 0.998: (setq lst (sequence 1 100000))
;-> 7.704: (setq l1 (map (lambda (x) (pow x a)) lst))
;-> 9.962: (setq l2 (map (lambda (x) (+ (* x x) (* a a))) lst))
;-> 0: (setq l3 '())
;-> 10.022: (dolist (el lst) (push (mul a (sin el)) l3 -1))
;-> 0: 'end

Questo è dovuto a diversi motivi, ma comunque abbiamo un'idea di quali parti del programma consumano più tempo.

Possiamo anche eseguire le espressioni più volte, per esempio eseguiamo il codice precedente 10 volte e sommiamo i tempi ad ogni esecuzione:

; lista dei tempi di esecuzione di ogni espressione della lista
(setq timers (dup 0 (length code)))
(dotimes (i 10)
  (dolist (expr code)
    (setf (timers $idx) (add (timers $idx) (time (eval expr))))
  )
)
(dolist (expr code)
  (println (timers $idx) ": " expr)
)
;-> 0: (setq a 3)
;-> 6.532: (setq lst (sequence 1 100000))
;-> 79.821: (setq l1 (map (lambda (x) (pow x a)) lst))
;-> 117.633: (setq l2 (map (lambda (x) (+ (* x x) (* a a))) lst))
;-> 6.004: (setq l3 '())
;-> 103.889: (dolist (el lst) (push (mul a (sin el)) l3 -1))
;-> 0: 'end

Possiamo anche "profilare" solo alcune espressioni e non calcolare il tempo di esecuzione delle altre.

Nota: ogni volta che misuriamo i tempi di esecuzione di parti di un programma influenziamo i tempi stessi (analogo del fatto che quando misuriamo una caratteristica, modifichiamo la caratteristica stessa (anche se solo di pochissimo)).


--------------------
La funzione "member"
--------------------

*******************
>>>funzione MEMBER
*******************
sintassi: (member exp list)
sintassi: (member str-key str [num-option])

Nella prima sintassi, "member" cerca l'elemento "exp" nella lista "list". Se l'elemento è un membro della lista, viene costruita e restituita una nuova lista che inizia con l'elemento trovato e il resto della lista originale. Se non viene trovato nulla, viene restituito nil. Quando si specifica "num-option", "member" esegue una ricerca con espressione regolare.

(set 'aList '(a b c d e f g h))  → (a b c d e f g h)
(member 'd aList)                → (d e f g h)
(member 55 aList)                → nil

In the second syntax, member searches for str-key in str. If str-key is found, all of str (starting with str-key) is returned. nil is returned if nothing is found.

Nella seconda sintassi, il Nella seconda sintassi, il membro cerca "str-key" in "str". Se viene trovato "str-key", viene restituito tutto "str" (che inizia con "str-key"). nil viene restituito se non viene trovato nulla.

(member "LISP" "newLISP")
;-> "LISP"
(member "LI" "newLISP")
;-> "LISP"
(member "" "newLISP")
;-> "newLISP"
(member "xyz" "newLISP")
;-> nil
(member "li" "newLISP" 0)
;-> nil
(member "li" "newLISP" 1)
;-> "LISP"

Vedi anche le relative funzioni "slice" e "find".

La funzione "member" agisce in modo leggermente diverso su liste e stringhe:

(member "" "this is a string")
;-> "this is a string"
(member '() '("this" "is" "a" "list"))
;-> nil

Ogni stringa contiene la stringa vuota come sottostringa.
Non tutte le liste contengono la lista vuota come sottolista.

La funzione "member" considera il carattere vuoto "" come presente in ogni stringa:

(member "" "")
;-> ""
(true? (member "" ""))
;-> true

La funzione "find" è più consistente:

(find "" "this is a string")
;-> nil
(find '() '("this" "is" "a" "list"))
;-> nil

Lutz:
-----
From a mathematical-logical point of view, (member "" "string") should probably be nil. But the 'member' function for strings is less trying to model mathematical member ship behaviour than that it tries to be practical for string handling purposes. It tries to offer a shorter coding for the frequently used idom:

(setq str "abcd")
(setq key "b")
(slice str (find key str 0))
;-> bcd

(member "b" "abcd")
;-> "bcd"

The function is modelled after the 'C' function strstr() which behaves the same way, returning a pointer to the entire string when searching for the empty string. When doing a regular expression search with 'find' then the 0 position is returned, also assuming that the empty string is part of the string.

When doing a non regular expression search with "find", than 'nil' is returned, but "find" without the regex option is rather a memory buffer search rather than it is a string search because it is made to also handle binary information.

(member "" "abcd")
;-> "abcd" ; => true

(find "" "abc")
;-> nil

(find "" "abc" 0)
;-> 0 ; => true

(regex "" "abc")
;-> ("" 0 0) ; => true

Programming languages which force these kinds of decisions to be always mathematically consistent tend to be impractical. But even from a practicality point of view one could probably argue both ways. In this case the precedent of strstr() and the behaviour of regular expressions swayed the decision.
Note that there is also:

(starts-with "abc" "")
;-> true

(ends-with "abc" "")
;-> true


-----------------------------------
States & Provinces contiguity check
-----------------------------------

tburton:
--------
A couple years ago, I wrote an algorithm that checks whether a series of input (or is it inputted?) U.S. states and/or Canadian provinces were contiguous with eachother. It is used by a governmental agency as part of the process of validating applications for trucking licenses. Although initially written in Java, I rewrote it in Cold Fusion for production because the latter was much faster!. Later, I rewrote it while fooling around with python.

Then I discovered newLisp and found that all the hoopla about it was true after rewriting the algorithm again. The newLisp version is more than half the number of lines than the previous languages and writing it in newLisp required a subtle change in consciousness that felt, to use an adjective posted more than once elsewhere, Zen-like in its focus and clarity. Verrrry interesting.

Anyway, the algorithm is below. Needless to say, the bulk of the work consisted of setting up a data structure listing all North American jurisdictions and integers representing each jurisdiction's neighbors. Since I'm a newbie, any feedback on how to make the code more 'lispy' would be appreciated!

Nota: refactoring by Cormullion and cameyo

(define (contiguity? theInputStr)
  ;(set 'theInputStr "OR,CA,CO,ID,WA");not contig test
  ;(set 'theInputStr "OR,CA,ID,WA");contig test
  ;
  (set 'testStr (replace "," (parse theInputStr)))
  ;
  ;if (< (length testStr) 2)
  ; (begin
  ;   (println "You must input at least two jurisdictions.")
  ;   (exit)))
  ;
  (set 'statesNeighbors
  '(("AL" 1 2 3 4)
  ("AK" 5 138)
  ("AR" 6 7 8 9 10 11)
  ("AZ" 12 13 14 15 16)
  ("CA" 12 17 18 19)
  ("CO" 20 21 22 23 24 25)
  ("CT" 26 27 28)
  ("DE" 29 30 31)
  ("FL" 1 32)
  ("GA" 2 32 33 34 35)
  ("ID" 36 37 38 39 40 41 42)
  ("IL" 43 44 45 46 47)
  ("IN" 43 48 49 50)
  ("IA" 44 51 52 53 54 55)
  ("KS" 20 56 57 58)
  ("KY" 45 48 59 60 61 62 63)
  ("LA" 6 64 65)
  ("ME" 66 67 68)
  ("MD" 29 69 70 71 144)
  ("MA" 26 72 73 74 75)
  ("MI" 49 76 77 78)
  ("MN" 51 79 80 81 82 83)
  ("MS" 3 7 64 84)
  ("MO" 8 46 52 56 59 85 86 87)
  ("MT" 36 88 89 90 91 92 93)
  ("NE" 21 53 57 85 94 95)
  ("NV" 13 17 37 96 97)
  ("NH" 66 72 98 99)
  ("NJ" 30 100 101)
  ("NM" 14 22 102 103 104)
  ("NY" 27 73 100 105 106 107 108)
  ("NC" 33 109 110 111)
  ("ND" 79 88 112 113 114)
  ("OH" 50 60 76 115 116)
  ("OK" 9 23 58 86 102 117)
  ("OR" 18 38 96 118)
  ("PA" 31 69 101 105 115 119)
  ("RI" 28 74)
  ("SC" 34 109)
  ("SD" 54 80 89 94 112 120)
  ("TN" 4 10 35 61 84 87 110 121)
  ("TX" 11 65 103 117 122)
  ("UT" 15 24 39 97 123)
  ("VT" 75 98 106 124)
  ("VA" 62 70 111 121 125 145)
  ("WA" 40 118 126)
  ("WV" 63 71 116 119 125)
  ("WI" 47 55 77 81)
  ("WY" 25 41 90 95 120 123)
  ("AB" 91 127 128 142)
  ("BC" 5 42 92 126 127 139 140)
  ("MB" 82 113 129 130)
  ("NB" 67 131 132 134)
  ("NS" 131 135 137)
  ("ON" 78 83 107 129 133)
  ("QC" 68 99 108 124 132 133 136)
  ("SK" 93 114 128 130 141)
  ("PE" 134 135)
  ("NL" 136 137)
  ("NT" 140 141 142 143)
  ("YT" 138 139 143)
  ("MX" 16 19 104 122)
  ("DC" 144 145)))
  ;
  (push "ZZ" testStr -1) ;postpend a marker for a batch (one complete loop)
  ;
  ;remove first state from testStr & push its neighbors into matchingBucket:
  (set 'matchingBucket (rest (assoc (pop testStr) statesNeighbors)))
  (set 'cntBatchNoChange 0)
  ;
  (define (common-boundary)
    ;if there is one boundary common to this state and boundaries in matchingBucket:
    ;then push this state's boundaries into bucket
    ;else push (at tail) this state back into the testStr
    (let (boundaries (length (intersect tempStatesBoundaries matchingBucket)))
    (cond
        ((!= boundaries 0 )  (push tempStatesBoundaries matchingBucket)
                            (set 'matchingBucket (unique (flat matchingBucket)))
                            (set 'cntBatchNoChange 0))
        (true                (push tempState testStr)
                            (rotate testStr -1)))))
  ;
  (while (and (< cntBatchNoChange 2 ) (> (length testStr) 1))
    (set 'tempState (pop testStr))
    (cond
        ((!= tempState "ZZ")
                    (set 'tempStatesBoundaries (rest (assoc tempState statesNeighbors)))
                    (common-boundary))
        (true ;if ZZ encountered
                    (push tempState testStr)
                    (rotate testStr -1)
                    (inc cntBatchNoChange))))
  ;
  (if (> (length testStr) 1)
    (begin
      (replace "ZZ" testStr)
      (println "not contiguous because of " testStr))
    (println "contiguous!"))
)

Some tests:

(contiguity? "OR,CA,CO,ID,WA")
;-> not contiguous because of ("CO")

(contiguity? "OR,CA,ID,WA")
;-> contiguous

(contiguity? "OR,WA,CA,ID,CO,WA")
;-> not contiguous because of ("CO")


------------------------------------------
Pensieri sparsi per imparare a programmare
------------------------------------------

La programmazione e il programmatore
------------------------------------
Oggi il lavoro del programmatore è ben pagato ed è uno dei lavori più interessanti che le persone possano fare.
Non si impara a programmare dall'oggi al domani e può richiedere anni per un principiante.
Ci sono molte risorse disponibili online e offline per imparare l'arte della programmazione.
Naturalmente ci sono alcune persone che hanno un talento particolare per scrivere codice, ma con dedizione, passione, interesse e sicuramente pazienza è possibile diventare un buon programmatore.

Quale linguaggio di programmazione?
-----------------------------------
Prima di rispondere a questa domanda dobbiamo porci prima un'altra domanda: cosa ci interessa fare come programmatore?
Ci interessa lo sviluppo di siti web oppure vogliamo scrivere dei giochi?
Esistono dei linguaggi general-purpose, ma se vogliamo scrivere dei driver, allora molto probabilmente la scelta migliore è il linguaggio C.
Io non sono un programmatore professionista, nel senso che ho scritto parecchio codice, ma funzionale al mio lavoro (Geographic Information System e Infografica).
Comunque ho scritto programmi in Fortran (CAD S5000 - O.S. Apollo Domain), C (grafica - windows), python (Arc-Gis - windows), Delphi (database - windows), MapBasic (MapInfo - windows), Zscript (ZBrush - windows, osx), processing/java (grafica, giochi - windows, osx).
Poi ho giocato con Prolog, Pascal, Logo, Forth, Scheme (SICP), CLISP, Julia (bello), ... adesso mi diverto (tanto) con newLISP.
Il mondo dei linguaggi è in continuo movimento e il miglior consiglio che posso dare è quello di seguire quello che accade informandosi su internet. Ad esempio, l'indice TIOBE Programming Community (https://www.tiobe.com/tiobe-index/) è un indicatore della popolarità dei linguaggi di programmazione. È importante notare che l'indice TIOBE non riguarda il miglior linguaggio di programmazione o il linguaggio in cui sono state scritte la maggior parte delle righe di codice.
L'indice può essere utilizzato per verificare se le tue capacità di programmazione sono ancora aggiornate o per prendere una decisione strategica su quale linguaggio di programmazione dovrebbe essere adottato quando inizi a costruire un nuovo sistema software.
La definizione dell'indice TIOBE può essere trovata al seguente indirizzo:
https://www.tiobe.com/tiobe-index/programminglanguages_definition/

Vediamo la classifica di febbraio 2023:

  Rank   Language       Ratings
  ----   --------       -------
    1     Python         15.49%
    2     C              15.39%
    3     C++            13.94%
    4     Java           13.21%
    5     C#             6.38%
    6     Visual Basic   4.14%
    7     JavaScript     2.52%
    8     SQL            2.12%
    9     Assembly       1.38%
   10     PHP            1.29%
   11     Go             1.11%
   12     R              1.08%
   13     MATLAB         0.99%
   14     Delphi         0.95%
   15     Swift          0.93%
   16     Ruby           0.83%
   17     Perl           0.79%
   18     Scratch        0.76%
   19     Classic VB     0.74%
   20     Rust           0.70%

Costruire delle fondamenta solide (un passo alla volta)
-------------------------------------------------------
Non bisogna saltare i fondamenti o il capitolo 1 e passare direttamente al capitolo successivo. Per comprendere i concetti avanzati è necessario avere molto chiari i fondamenti della programmazione. Questo errore ci porterà, prima o poi, ad una confusione tale che dovremo tornare di nuovo a studiare le basi. Questi fondamenti sono strutture dati, variabili, strutture di controllo, sintassi, algoritmi, compilatori, editor di testo, ecc. Quando si inizia a programmare, si sceglie un linguaggio di programmazione e si studiano tutte le basi prima di passare al livello successivo.
La padronanza di un linguaggio di programmazione si ottiene dopo anni di programmazione.

Imparare facendo e non solo leggendo (pratica, teoria, pratica, teoria, ...)
----------------------------------------------------------------------------
Un errore comune che i principianti fanno mentre imparano a programmare è semplicemente leggere un libro o guardare il codice di esempio senza provarlo direttamente. È facile leggere i loop e le variabili e pensare che si sia capito tutto, ma la programmazione reale non funziona in questo modo. Devi davvero "sporcarti le mani" ed esercitarti regolarmente e continuamente. Scrivere il codice ci costringe ad essere precisi e a risolvere tutti quei problemi collaterali dovuti agli strumenti che usiamo (editor, compilatori, ecc.). Inoltre risolvere i problemi migliora realmente la capacità di pensiero logico e di sviluppare algoritmi.
Quando iniziamo a programmare affrontiamo molti problemi e spesso rimaniamo bloccati lì, apparentemente senza speranza, ma è proprio in questi momenti che la forza di volontà deve spronarci a trovare una soluzione in qualche modo.

Scrivere codice a mano (carta e penna)
--------------------------------------
I principianti dovrebbero scrivere il codice con carta e penna prima di implementare il programma con un editor.
Questo è un processo che richiede tempo, inoltre non è possibile eseguire/verificare il programma su carta.
Allora perché si dovrebbe usare carta e penna?
La codifica manuale è una tecnica della vecchia scuola, ma in realtà comporta un test per la competenza di un programmatore. La codifica manuale può darti una chiara comprensione della sintassi e degli algoritmi, crei una connessione più profonda nel tuo cervello. Imparare a programmare in questo modo renderà il tuo lavoro più facile e veloce in seguito.

Condividere, insegnare, discutere e chiedere aiuto (con tutti)
--------------------------------------------------------------
Uno dei modi migliori per vedere se abbiamo capito un concetto è quello di insegnarlo ad un'altra persona. Insegnare a qualcuno è anche insegnare a se stessi, quindi quando siamo in grado di insegnare significa che abbiamo capito veramente i concetti.
Condividi le tue conoscenze, discuti il codice con altri programmatori (tramite forum ad esempio), impara con youtube e con corsi video specialistici, apri un account su github o gitlab, leggi il codice di altri programmatori, partecipa a progetti open source.
Soprattutto non esitare a chiedere aiuto: fai tutte le domande che credi, nella maggior parte dei casi troverai programmatori pronti ad aiutarti.

Utilizzare le risorse disponibili su Internet (e non solo)
----------------------------------------------------------
Ci sono molte risorse online (gratis e a pagamento). Lezioni video, boot camp, code golf, tutorial, project euler, rosetta code e molto altro sono solo ad un passo.
Un altro consiglio è quello di leggere i blog relativi alla programmazione e al linguaggio scelto.
I libri non sono passati di moda, ci sono alcuni classici che devono essere nella nostra biblioteca (K&R, TAOCP, SICP, ecc.).
Leggere TUTTI i manuali del linguaggio e dell'ambiente di programmazione (RTFM, Read The Fucking Manual).
Per una lista di libri e siti di programmazione vedi la bibliografia.

Prendere aria (fare delle pause)
--------------------------------
La capacità di rimanere concentrati a programmare davanti ad un computer è soggettiva.
Comunque quando ci sentiamo stanchi e poco lucidi è il momento di fare una pausa.
A volte passo ore a cercare un bug senza successo, allora è meglio liberare la mente (porto fuori il cane) e spesso la soluzione mi viene in mente fuori.
Quando programmi devi isolarti e concentrarti: eliminare ogni tipo di distrazione (email, notifiche, ecc.).

Imparare a usare il debugger (un vero amico)
--------------------------------------------
Fare errori quando si scrive codice è normale (difficilmente un programma funziona al primo tentativo). All'inizio troveremo molti errori nel nostro codice quindi è bene imparare ad usare il debugger per analizzare da vicino l'esecuzione dei nostri programmi. Un programmatore passa la maggior parte del tempo a correggere i programmi. Padroneggiare il debugger è fondamentale per programmare.

Matematica (accidenti...)
-------------------------
La conoscenza della matematica aiuta moltissimo a risolvere i problemi in modo efficace ed efficiente. Un programmatore che ha solide basi in algebra, trigonometria, calcolo delle probabilità, statistica, trigonometria e calcolo/analisi è sicuramente avvantaggiato nel suo lavoro.
Come studiare la matematica è un altro problema... (lasciato come esercizio agli studenti di programmazione).

Nota finale: requisito fondamentale per programmare: "ti deve piacere (e tanto)!!!"


---------------------
La tecnica di Feynman
---------------------

La tecnica di Feynman è un metodo di analisi che permette di acquisire nuove conoscenze in maniera più rapida e profonda.
Prende il nome da Richard Feynman, un fisico che prese il nobel nel 1965 per aver contribuito allo sviluppo dell'elettrodinamica quantistica.
La tecnica deriva dai metodi di studio che Feynman ha utilizzato quando era uno studente a Princeton.
Di questa tecnica si possono trovare diverse versioni simili che ruotano tutte intorno a un punto focale: se non lo sai spiegare a un bimbo di 10/12 anni, allora non lo sai davvero.

La tecnica Feynman può essere riassunta in 4 passi:

Step 1: scegli un concetto che vuoi approfondire
------------------------------------------------
Quando hai individuato qualcosa che vuoi capire meglio, prendi un foglio di carta bianco o un libro degli appunti e scrivi tutto quello che sai già sull’argomento.
Man mano che recuperi più informazioni, aggiungile ai tuoi appunti, magari utilizzando penne di colori diversi per rendere visibile la progressione del tuo apprendimento (es. mappa mentale).
Una volta che pensi di conoscere bene l’argomento, puoi passare al passo 2.

Passo 2: cerca di spiegarlo ad un bambino di 10/12 anni
-------------------------------------------------------
Riscrivi quello che sai come se lo dovessi spiegare ad un bambino di 12 anni.
Devi seguire due regole fondamentali:
a) semplicità: i bambini non capiscono il linguaggio tecnico o vocaboli troppo complicati;
b) sintesi: la capacità di concentrazione dei bambini è molto breve. Devi andare subito al punto evitando troppi fronzoli.

Chiunque può rendere un argomento complicato, ma solo quelli che lo comprendono veramente riescono a renderlo semplice. Il linguaggio tecnico spesso nasconde la mancanza di vera comprensione: sforzandoci ad utilizzare solo parole semplici ci rendiamo conto dove il nostro ragionamento si inceppa, dove non conosciamo le cose così in profondità come pensavamo.

Passo 3: rifletti, modifica, semplifica
---------------------------------------
Questa è la fase dove avviene il vero apprendimento. Nel passo 2 ci siamo resi conto dei nostri punti deboli, delle nostre mancanze. Dobbiamo quindi andare a rivedere i nostri appunti, recuperare più informazioni, coprire le nostre lacune e rendere più fluido il nostro ragionamento.

Passo 4: racconta una storia
----------------------------
Una volta che hai completato gli aggiustamenti del passo 3 sei pronto per raccontare la tua storia: rileggi i tuoi appunti a voce alta. Fai finta di spiegare l’argomento ad una classe di studenti. Se possibile raccontalo a qualcuno per capire le sue reazioni: che domande ti ha chiesto? Su quali parti è andato in confusione?
Ritorna al passo 2 tutte le volte che lo ritieni necessario, ovvero fino a quando non ti sarai reso conto di conoscere davvero l’argomento e di spiegarlo in modo semplice.

Una volta che hai terminato questo processo puoi essere sicuro di aver capito veramente quello che volevi approfondire e di non dimenticherlo più.

Sembra semplice, ma è complicato da mettere in pratica: si fa molta fatica a spiegare una cosa a qualcuno che non ne sa nulla.
In questa fatica sta una parte del segreto dell’efficacia della tecnica.
La tecnica di Feynman è efficace per due motivi principali:

a) lo sforzo che dobbiamo fare per "tradurre" il nostro contenuto mentale ci costringe all’elaborazione del nostro pensiero.
Siamo costretti ad elaborare in maniera attiva le nostre conoscenza, facendo domande del tipo:
 - Come faccio a rappresentare questo concetto?
 - Come posso esemplificare questa connessione logica?
 - Cosa significa esattamente questa frase?
 - Con che analogia o metafora potrai descrivere questo fenomeno?
 - Che parola potrei usare al posto di quest'altra?

b) la consapevolezza sul nostro reale livello di conoscenza dell'argomento. Questa tecnica ci permette di individuare esattamente le nostre lacune concettuali, in questo modo sappiamo cosa dobbiamo approfondire.

Consigli sparsi nell'utilizzo della tecnica
-------------------------------------------
Usare carta e penna solo per concetti e argomenti complessi.
La tecnica funziona molto meglio quando spieghiamo ad una persona reale.
Lo scopo di questa tecnica è chiarire i concetti, non memorizzare le nozioni.

"Ho imparato molto presto la differenza tra il conoscere il nome di una cosa e il conoscere una cosa." Richard Feynman


------------------------
La matrice di Eisenhower
------------------------

La matrice di Eisenhower è uno strumento di gestione delle attività che aiuta ad organizzare e ad assegnare alle attività la giusta priorità in base all'urgenza e all'importanza. Questo strumento permette di dividere le attività in quattro categorie: attività da svolgere per prime, attività da programmare per dopo, attività da delegare e attività da eliminare. Il processo di creazione della matrice e il suo utilizzo successivo hanno lo scopo fondamentale di massimizzare i nostri obiettivi personali.

"Ciò che è importante raramente è urgente e ciò che è urgente raramente è importante" Dwight D. Eisenhower.

Il concetto di "importante" è soggettivo e dipende anche dal contesto.
Il concetto di "urgente" è oggettivo perché dipende unicamente dalla variabile tempo (È proprio l’oggettività della situazione che crea l’urgenza).

Combinando i due concetti si ottengono i quattro quadranti che costituiscono la matrice di Eisenhower:

                    +--------------------------+--------------------------+
                    |                          |                          |
                    |         URGENTE          |       NON URGENTE        |
                    |                          |                          |
 +------------------+--------------------------+--------------------------+
 |                  | 1       da FARE          | 2       da FARE          |
 |    IMPORTANTE    |     (immediatamente)     |          (dopo)          |
 |                  |  Azioni non delegabili   |   Azioni da pianificare  |
 +------------------+--------------------------+--------------------------+
 |                  | 3     da DELEGARE        | 4      da NON FARE       |
 |  NON IMPORTANTE  |   (immediatamente)       |     (assolutamente)      |
 |                  |    Azioni delegabili     |      Azioni superflue    |
 +------------------+--------------------------+--------------------------+

Alla base della Matrice di Eisenhower deve esserci prima di tutto un elenco dettagliato delle nostre attività, ordinate in base alla priorità, alle scadenze e alle risorse a disposizione.
La matrice rappresenta un punto di partenza per la gestione dei progetti, non un punto di arrivo. Una volta creata la matrice occorre seguirla e aggiornarla costantemente (questa è la parte difficile).


--------------------
Forum: Lispy regexes
--------------------

Jeremy Dunn:
------------

I was thinking about the fact that NewLISP uses functional notation for everything but departs from that philosophy when we write regex patterns. I realize that this simplifies the task of including some form of regex because then one only has to adopt pre-existing PERL notation. Also, there is more or less a tradition as to how one is supposed to write regexes. Why rock the boat? Well, one reason is to be consistent and have a functional approach to everything, that eliminates the need to learn and remember a complex set of syntax rules. Large regexes are awful to create and read if you aren't doing it all the time. Standard regex notation continues to enlarge and the way that PERL does it is doomed to become limited because no one is going to be able to read all the extra little syntax goodies Larry Wall likes to create. Functional notation is not limited because one just comes up with a new function name and adds parentheses and moves on. So I have come up with the notion of having a set of NewLISP functions that generate the regex pattern string without having to know or deal with standard regex notation at all. First I will unveil my first attempt and then discuss how it is used.

;; Functions:
;;
;; (reg x y ...) translate and join epressions
;; (bracket s c) bracket expressions with parens
;; (r1  x)       match 1 or more times  +
;; (r01 x)       match 0 or 1 times     ?
;; (r0  x)       match 0 or more times  *
;; (r2  x)       match 2 or more times  {2,}
;; (ntom x n m)  match a min of n and a max of m    {n,m}
;; (lazy x)      perform lazy (non-greedy) evaluation
;; (r-n x)       negate character class or individual character
;; (r-or x y)    alternation (x|y)
;; (r-run x y)   [a-z] run of characters
;; (r-chc x)     [abc] character class

;; Bracket a string with a given bracket character. If no character than parentheses () are
;; assumed. For regex expressions the function acts as the grouping operator ().
(define (bracket s c , opt)
  (setq c   (or c "(")
        opt (if (member c '("(" ")")) '("(" ")")
                (member c '("[" "]")) '("[" "]")
                (member c '("<" ">")) '("<" ">")
                '("{" "}")
            )
  )
  (join (list (first opt) s (last opt))))

;; Convert numbers or symbols to appropriate character strings. Note that character
;; classes or special characters are denoted by symbols. Ascii codes are typed in
;; directly as integers.
(define (convert-codes c)
  (if   ;c is an ascii code
      (= c 7)  "\\a" ;bell
      (= c 8)  "\\b" ;backspace
      (= c 9)  "\\t" ;tab
      (= c 10) "\\n" ;newline
      (= c 12) "\\f" ;formfeed
      (= c 13) "\\r" ;carriage return
      (= c 27) "\\e" ;escape
      (or (<= 48 c 57)(<= 65 c 90)(<= 97 c 122)) (char c)  ;alphabet or digits
        ;c is a symbol
      (= c 'a)  "\\a"   ;bell
      (= c 'b)  "\\b"   ;backspace
      (= c 't)  "\\t"   ;tab
      (= c 'n)  "\\n"   ;newline
      (= c 'f)  "\\f"   ;formfeed
      (= c 'r)  "\\r"   ;carriage return
      (= c 'e)  "\\e"   ;escape
      (= c '^)  "^"          ;anchor to start of line
      (= c '$)  "$"          ;anchor to end of line
      (= c 'L)  "[a-z]"      ;any lower case letter
      (= c 'U)  "[A-Z]"      ;any upper case letter
      (= c 'UL) "[^A-Za-z]"         ;anything other than an upper or lower case letter
      (= c 'ul) "[A-Za-z]"          ;any lower or upper case letter
      (= c 'V)  "[^aeiouAEIOU]"     ;any consonant
      (= c 'v)  "[aeiouyAEIOUY]"    ;any vowel
      (= c 'br) "[()\[\]{}<>]"      ;any bracket symbol
      (= c 'lb) "[(\[{<]"           ;any left bracket symbol
      (= c 'rb) "[)\]}>]"           ;any right bracket symbol
      (= c 'BR) "[^()\[\]{}<>]"     ;any non-bracket symbol
      (= c 'W)  "\\W"        ;matches a non-alphanumeric character
      (= c 'w)  "\\w"        ;matches an alphanumeric character
      (= c 'D)  "\\D"        ;non-digit
      (= c 'd)  "\\d"        ;digit
      (= c 'S)  "\\S"        ;non-space
      (= c 's)  "\\s"        ;space
      (= c 'se) "[.?!]"      ;a sentence ending symbol
      (= c 'P)  "[^,;:.?! ]" ;a non sentence punctuation symbol
      (= c 'p)  "[,::.?! ]"  ;a sentence punctuation symbol
      (= c '.)  "."          ;any single character
      (= c '*)  ".*"         ;one or more of any character
      (= c 'rp) ".{2,}"      ;2 or more of any character (repeats)
      (= c 'K)  "[^!-~]"     ;is not a key character
      (= c 'k)  "[!-~]"      ;is a key character
      (= c '+)  "[-+]"       ;matches + or -
      c
  )
)

;; Convert a list of strings, ascii codes, symbols or other lists into
;; a single string.
(define (reg%% z)
  (if (string? z) z
      (or (integer? z)(symbol? z)) (convert-codes z)
      (list? z)(join (map reg%% z))
      nil
  ))

;; Convert all arguments into strings and join them into a single string.
(define-macro (reg)
  (join (map reg%% (map eval (args)))))

;; Take the negation of a string pattern.
(define (r-n x)
  (setq x (reg x))
  (if (= "^" (first x)) (rest x)
      (= "[^" (0 2 x)) (join (list "[" (slice x 2)))
      (= "[" (first x)) (join (list "[^" (rest x)))
      (= "^(" (0 2 x)) (rest x)
      (join (list "^" x))
  ))

;; Match 1 or more of x. If L is non-nil do a lazy (non-greedy) analysis.
;; Example: (r1 "a")      -> "a+"
;;          (r1 "a" true) -> "a+?"
(define (r1 x L)
  (join (list (reg x) "+" (if L "?" ""))))

;; Match 0 or more of x. If L is non-nil do a lazy (non-greedy) analysis.
;; Example: (r0 "a")      -> "a*"
;;          (r0 "a" true) -> "a*?"
(define (r0 x L)
  (join (list (reg x) "*" (if L "?" ""))))

;; Match 0 or 1 of x. If L is non-nil do a lazy (non-greedy) analysis.
;; Example: (r01 "a")      -> "a?"
;;          (r01 "a" true) -> "a??"
(define (r01 x L)
  (join (list (reg x) "?" (if L "?" ""))))

;; Match 2 or more i.e. repeats of x. If L is non-nil do a lazy (non-greedy) analysis.
;; Example: (r2 "a")      -> "a{2,}"
;;          (r2 "a" true) -> "a{2,}?"
(define (r2 x L)
  (join (list (reg x) "{2,}" (if L "?" ""))))

;; Another way of doing lazy evaluation by having a function specifically for it.
;; The function takes a string and appends "?" onto the end of it. So you can
;; write (r1 "A" true) as (lazy (r1 "A")) if you wish. This might be handier if you
;; wanted to use map to map lazy onto several expressions at once.
(define (lazy x)(join (list (reg x) "?")))

;; Match x a minimum of n times and a maximum of m times. If L is non-nil
;; do a lazy (non-greedy) analysis. If m is 0 then the maximum is infinity.
;; Example: (ntom "a" 2 4)      -> "a{2,4}"
;;          (ntom "a" 2 0)      -> "a{2,}"
;;          (ntom "a" 2)        -> "a{2}"
;;          (ntom "a" 2 4 true) -> "a{2,4}?"
(define (ntom x n m L)
      (join (list (reg x)
                  (bracket (join (list (string n)
                                   (if (>= m 0) "," "")
                                   (if (> m 0) (string m) "")
                                  )) "}")
                  (if L "?" "")
            )))

;; Perform alternation on a series of arguments. If the last argument is +
;; do a positive lookahead, if the last argument is - do a negative lookahead.
;; Example: (r-or "cat" "dog")   -> "(cat|dog)"
;;          (r-or "cat" "dog" +) -> "(?=cat|dog)"
;;          (r-or "cat" "dog" -) -> "(?!cat|dog)"
(define-macro (r-or)
  (setq L        (last (args))
        interior (map (fn (x)(join (list "|" (reg x)))) (args))
        interior (rest (join interior))
  )
  (bracket (join (list (if (= L +) "?=" (= L -) "?!" "") interior)))
)

;; Create a run of characters. You must backslash
;; a character for it to be taken literally.
;; Example: (r-run "a" "b") -> "[a-b]"
(define (r-run s f)
  (bracket
    (join (list (reg s)
                "-"
                (reg f))) "["))

;; Create a character class. You must backslash a character
;; for it to be taken literally.
;; Example: (r-chc "f9p") -> "[f9p]"
(define (r-chc s)(bracket (reg s) "]"))

One must remember that the above code does not examine regex patterns but only produces a PERL compatible regex pattern string that can be input into a regex function. I have not done in-depth testing of the above functions and I am pretty certain that more code needs to be added to take care of situations I haven't thought of. With those caveats lets give some examples of how things will look.

"cat" - a single string just remains a single string
"^cat" - (reg '^ "cat")
"(cat|dog)" - (r-or "cat" "dog")
"[a9fr]" - (r-chc "a9fr")
"[^b-t]" - (r-n (r-run "b" "t")) we use r-n to negate the class
"[b-tamcd]" - (reg (r-run "b" "t")(r-chc "amcd"))
"[-+]?[0-9]" - (reg (r01 '+) 'd)
"([-+]?[0-9])+" - (r1 (bracket (reg (r01 '+) 'd)))

Perhaps you are getting the idea now? The REG function is used for glueing multiple expressions together into a single string, it translates and then concatenates. The BRACKET function is used for grouping, it is the regex equivalent of LIST.

If you take the time to look at the CONVERT-CODES function you will notice that I have taken the liberty of adding several shorthands for various character classes that I think are useful. Perhaps there are suggestions for more or less?

Here are the advantages that I think justify this approach:

1. A consistent syntax instead of myriad rules to remember.
2. It adds extra options for the programmer while still allowing standard notation to be used if desired.
3. Other NewLISP functions can be used on parts of the expression providing untold power to manipulate expressions in ways not thought of before. For instance, instead of normal backtracking you could use the SETQ function to set part of the expression to a variable that you call later in the expression.
4. More readable? Debateable of course but I think that the larger the expression the more readable it will be in functional format instead of comic book swearing typology.

Disadvantages:

1. Unfamiliar notation.
2. Short expressions can be more wordy.

I am hoping that by providing an example of this concept that it will stimulate some thought and discussion on the issue. Ideas? Suggestions?


---------------------------------------------
Restituire una stringa senza i doppi apici ""
---------------------------------------------

Supponiamo di avere una funzione che restituisce una stringa e a noi serve mostrare solo il contenuto della stringa senza i doppi apici:

(define (test a b) (string a b))

(test "123" "456")
;-> "123456"

Possiamo usare la funzione "sym":

(define (test a b) (sym (string a b)))

(test "123" "456")
;-> 123456

Nota: adesso 123456 è un simbolo.

Un altro metodo:

(silent (println (test "123" "456")))
;-> 123456
(silent (println (date (date-value) 0 "%Y-%m-%d %H:%M:%S")))
2023-02-14 16:37:23


-------------------------------------
Allineamento di numeri floating point
-------------------------------------

Il problema è quello di allineare i numeri floating point contenuti in una lista:

(setq num '(205.492 201.729 201.38 -5.38672 -1.38724 -158.966 123.63))

nel modo seguente (cioè allineati in colonna nel punto decimale):

   205.492
   201.729
   201.38
    -5.38672
    -1.38724
  -158.966
   123.63

Possiamo usare "format":

(setq f (map (fn (x) (format "%10.5f" x)) num))
;-> (" 205.49200" " 201.72900" " 201.38000" "  -5.38672"
;->  "  -1.38724" "-158.96600" " 123.63000")

e poi sostituire gli zeri finali di ogni numero con uno spazio usando una regex:

(replace {(0+)$} "12345.567000" (dup " " (length $1)) 0)
;-> "12345.567   "

Il pattern (modello) {(0+)$} trova uno o più zeri finali e li sostituisce con lo stesso numero di spazi.

(define (change x)
  (replace {(0+)$} x (dup " " (length $1)) 0))

(setq p (map change f))
;-> (" 205.492  " " 201.729  " " 201.38   " "  -5.38672"
;->  "  -1.38724" "-158.966  " " 123.63   ")

Infine possiamo stampare i numeri della lista:

(map println p)
;->  205.492
;->  201.729
;->  201.38
;->   -5.38672
;->   -1.38724
;-> -158.966
;->  123.63

Nota: se cercate di risolvere un problema con una espressione regolare (regex) vi ritroverete con due problemi ;-).


----------------
Crittografia MD5
----------------

Il Message Digest 5 (noto anche come "MD5" o "MD5 Checksum" o "MD5 Hash") è una funzione crittografica inventata da Ronald Rivest nel 1991 e standardizzata con la RFC 1321.
Questa funzione prende in input una stringa di lunghezza arbitraria (max 2^64 bit) e ne produce in output un'altra di 128 bit (32 caratteri in esadecimale poichè servono solo 4 bit per codificare un valore esadecimale).
L'algoritmo usato rende altamente improbabile ottenere due valori MD5 uguali con due stringhe di input diverse.
In teoria è una funzione unidirezionale diversa dalla codifica e dalla cifratura perché irreversibile.
In pratica, oggi sono disponibili molte risorse online che riescono a decriptare parole comuni codificate. Inoltre esistono algoritmi efficienti capaci di generare stringhe diverse che collidono (cioè hanno lo stesso valore di MD5).
Nel 2008, la CMU Software Engineering Institute concluse che MD5 era "cryptographically broken and unsuitable for further use" (crittograficamente "rotto" e inadatto all'uso).
Malgrado tutto ciò, ad oggi (2023) viene ancora ampiamente utilizzato.

Nota: per scopi "casalinghi" l'MD5 "basta e avanza" ;-)

Vediamo un'implementazione in newLISP:

;;
;; md5 in newLISP
;;
;; based on RFC 1321
;;
;; written by frontera000
;;
;; updated to newLISP 10.7.5 by cameyo
;;

(define (F x y z)
  (| (& x y) (& (& 0xffffffff (~ x)) z)))
;
(define (G x y z)
  (| (& x z) (& y (& 0xffffffff (~ z)))))
;
(define (H x y z)
  (^ x y z))
;
(define (I x y z)
  (^ y (| x (& 0xffffffff (~ z)))))
;
(define (rotate-left x n)
  (| (& 0xffffffff (<< x n)) (& 0xffffffff (>> x (- 32 n)))))
;
(define (FF a b c d x s ac)
  (set 'a (& 0xffffffff (+ a (F b c d) x ac)))
  (set 'a (rotate-left a s))
  (set 'a (& 0xffffffff (+ a b))))
;
(define (GG a b c d x s ac)
  (set 'a (& 0xffffffff (+ a (G b c d) x ac)))
  (set 'a (rotate-left a s))
  (set 'a (& 0xffffffff (+ a b))))
;
(define (HH a b c d x s ac)
  (set 'a (& 0xffffffff (+ a (H b c d) x ac)))
  (set 'a (rotate-left a s))
  (set 'a (& 0xffffffff (+ a b))))
;
(define (II a b c d x s ac)
  (set 'a (& 0xffffffff (+ a (I b c d) x ac)))
  (set 'a (rotate-left a s))
  (set 'a (& 0xffffffff (+ a b))))

(define (md5-init )
  (set 'md5-i '(0 0))
  (set 'md5-in (dup 0 64))
  (set 'md5-digest (dup 0 16))
  (set 'md5-buf '(0x67452301 0xefcdab89 0x98badcfe 0x10325476)))

(define (md5-update inbuf inlen)
  ;; compute number of bytes mod 64
  (set 'mdi (& (>> (md5-i 0) 3) 0x3f))
  ;; update number of bits
  (if (< (+ (md5-i 0)  (<< inlen 3)) (md5-i 0))
      ;(nth-set (md5-i 1) (+ 1 (md5-i 1))))
      (setf (md5-i 1) (+ 1 (md5-i 1))))
  (setf (md5-i 0) (+ (md5-i 0) (<< inlen 3)))
  (setf (md5-i 1) (+ (md5-i 1) (>> inlen 29)))
  (set 'inbuf-index 0)
  (while (> inlen 0)
    ;; add new character to buffer, increment mdi
    (setf (md5-in mdi) (inbuf inbuf-index))
    (set 'mdi (+ mdi 1))
    (set 'inbuf-index (+ inbuf-index 1))
    ;; transform if necessary
    (if (= mdi 0x40)
        (begin
          (set 'ii 0)
          (set 'in (dup 0 16))
          (for (i 0 15 1)
          (setf (in i) (| (<< (char->int (md5-in (+ ii 3))) 24)
                          (<< (char->int (md5-in (+ ii 2))) 16)
                          (<< (char->int (md5-in (+ ii 1))) 8)
                          (char->int (md5-in ii))))
          (set 'ii (+ ii 4)))
          (transform  in)
          (set 'mdi 0)))
    (set 'inlen (- inlen 1))))

(define (char->int x)
  (if (integer? x) x (char x)))

(define (md5-final)
  (set 'in (dup 0 16))
  ;; save number of bits
  (setf (in 14) (md5-i 0))
  (setf (in 15) (md5-i 1))
  ;; compute number of bytse mod 64
  (set 'mdi (& (>> (md5-i 0) 3) 0x3f))
  ;; pad out to 56 mod 64
  (if (< mdi 56)
      (set 'padlen (- 56 mdi))
      (set 'padlen (- 120 mdi)))
  (set 'padding (dup 0 64))
  (setf (padding 0) 0x80)
  (md5-update padding padlen)
  ;; append lenth in bits and transform
  (set 'ii 0)
  (for (i 0 13 1)
       (setf (in i) (| (<< (char->int (md5-in (+ ii 3))) 24)
                       (<< (char->int (md5-in (+ ii 2))) 16)
                       (<< (char->int (md5-in (+ ii 1))) 8)
                       (char->int (md5-in ii))))
       (set 'ii (+ ii 4)))
  (transform in)
  ;; store buffer in digest
  (set 'ii 0)
  (for (i 0 3 1)
       (setf (md5-digest ii) (& (md5-buf i) 0xff))
       (setf (md5-digest (+ ii 1)) (& (>> (md5-buf i) 8) 0xff))
       (setf (md5-digest (+ ii 2)) (& (>> (md5-buf i) 16)  0xff))
       (setf (md5-digest (+ ii 3)) (& (>> (md5-buf i) 24)  0xff))
       (set 'ii (+ ii 4))))

(define (transform  in)
  (set 'a (md5-buf 0))
  (set 'b (md5-buf 1))
  (set 'c (md5-buf 2))
  (set 'd (md5-buf 3))
  ;; Round 1
  (set 'S11 7)
  (set 'S12 12)
  (set 'S13 17)
  (set 'S14 22)
  (set 'a (FF a b c d (in 0) S11 3614090360))
  (set 'd (FF d a b c (in 1) S12 3905402710))
  (set 'c (FF c d a b (in 2) S13  606105819))
  (set 'b (FF b c d a (in 3) S14 3250441966))
  (set 'a (FF a b c d (in 4) S11 4118548399))
  (set 'd (FF d a b c (in 5) S12 1200080426))
  (set 'c (FF c d a b (in 6) S13 2821735955))
  (set 'b (FF b c d a (in 7) S14 4249261313))
  (set 'a (FF a b c d (in 8) S11 1770035416))
  (set 'd (FF d a b c (in 9) S12 2336552879))
  (set 'c (FF c d a b (in 10) S13 4294925233))
  (set 'b (FF b c d a (in 11) S14 2304563134))
  (set 'a (FF a b c d (in 12) S11 1804603682))
  (set 'd (FF d a b c (in 13) S12 4254626195))
  (set 'c (FF c d a b (in 14) S13 2792965006))
  (set 'b (FF b c d a (in 15) S14 1236535329))
  ;; Round 2
  (set 'S21 5)
  (set 'S22 9)
  (set 'S23 14)
  (set 'S24 20)
  (set 'a (GG a b c d (in 1) S21 4129170786))
  (set 'd (GG d a b c (in 6) S22 3225465664))
  (set 'c (GG c d a b (in 11) S23  643717713))
  (set 'b (GG b c d a (in 0) S24 3921069994))
  (set 'a (GG a b c d (in 5) S21 3593408605))
  (set 'd (GG d a b c (in 10) S22   38016083))
  (set 'c (GG c d a b (in 15) S23 3634488961))
  (set 'b (GG b c d a (in 4) S24 3889429448))
  (set 'a (GG a b c d (in 9) S21  568446438))
  (set 'd (GG d a b c (in 14) S22 3275163606))
  (set 'c (GG c d a b (in 3) S23 4107603335))
  (set 'b (GG b c d a (in 8) S24 1163531501))
  (set 'a (GG a b c d (in 13) S21 2850285829))
  (set 'd (GG d a b c (in 2) S22 4243563512))
  (set 'c (GG c d a b (in 7) S23 1735328473))
  (set 'b (GG b c d a (in 12) S24 2368359562))
  ;; Round 3
  (set 'S31 4)
  (set 'S32 11)
  (set 'S33 16)
  (set 'S34 23)
  (set 'a (HH a b c d (in 5) S31 4294588738))
  (set 'd (HH d a b c (in 8) S32 2272392833))
  (set 'c (HH c d a b (in 11) S33 1839030562))
  (set 'b (HH b c d a (in 14) S34 4259657740))
  (set 'a (HH a b c d (in 1) S31 2763975236))
  (set 'd (HH d a b c (in 4) S32 1272893353))
  (set 'c (HH c d a b (in 7) S33 4139469664))
  (set 'b (HH b c d a (in 10) S34 3200236656))
  (set 'a (HH a b c d (in 13) S31  681279174))
  (set 'd (HH d a b c (in 0) S32 3936430074))
  (set 'c (HH c d a b (in 3) S33 3572445317))
  (set 'b (HH b c d a (in 6) S34   76029189))
  (set 'a (HH a b c d (in 9) S31 3654602809))
  (set 'd (HH d a b c (in 12) S32 3873151461))
  (set 'c (HH c d a b (in 15) S33  530742520))
  (set 'b (HH b c d a (in 2) S34 3299628645))
  ;; Round 4
  (set 'S41 6)
  (set 'S42 10)
  (set 'S43 15)
  (set 'S44 21)
  (set 'a (II a b c d (in 0) S41 4096336452))
  (set 'd (II d a b c (in 7) S42 1126891415))
  (set 'c (II c d a b (in 14) S43 2878612391))
  (set 'b (II b c d a (in 5) S44 4237533241))
  (set 'a (II a b c d (in 12) S41 1700485571))
  (set 'd (II d a b c (in 3) S42 2399980690))
  (set 'c (II c d a b (in 10) S43 4293915773))
  (set 'b (II b c d a (in 1) S44 2240044497))
  (set 'a (II a b c d (in 8) S41 1873313359))
  (set 'd (II d a b c (in 15) S42 4264355552))
  (set 'c (II c d a b (in 6) S43 2734768916))
  (set 'b (II b c d a (in 13) S44 1309151649))
  (set 'a (II a b c d (in 4) S41 4149444226))
  (set 'd (II d a b c (in 11) S42 3174756917))
  (set 'c (II c d a b (in 2) S43  718787259))
  (set 'b (II b c d a (in 9) S44 3951481745))
  (setf (md5-buf 0) (+ a (md5-buf 0)))
  (setf (md5-buf 1) (+ b (md5-buf 1)))
  (setf (md5-buf 2) (+ c (md5-buf 2)))
  (setf (md5-buf 3) (+ d (md5-buf 3))))

(define (md5-string str)
  (md5-init)
  (md5-update str (length str))
  (md5-final)
  (set 'result "")
  (for (i 0 15 1)
       (set 'result (append result (format "%02x" (md5-digest i)))))
  result)

Facciamo alcune prove:

(md5-string "pippo")
;-> "0c88028bf3aa6a6a143ed846f2be1ea4"

(md5-string "newLISP")
;-> "d3a067ae8916054962581a38e2508c78"

Nota: per scopi "casalinghi" l'uso di MD5 "basta e avanza" ;-)


-------------------
Funtori e dizionari
-------------------

In newLISP per creare un dizionario (hash-map) usiamo un contesto.
Un funtore è il simbolo di default associato al nome/simbolo del contesto.

Per esempio, creiamo un dizionario e inseriamo alcuni valori:

(new Tree 'dict)
(dict '((1 "a") (2 "b") (3 "c")))
(dict)
;-> (("1" "a") ("2" "b") ("3" "c"))

Il funtore di default di un contesto può essere individuato con la funzione "default":

(default 'dict)
;-> nil

Un dizionario può anche essere creato in un altro modo:

(define dizio:dizio)
(dizio '((1 "x") (2 "y") (3 "z")))
(dizio)
;-> (("1" "x") ("2" "y") ("3" "z"))
(default 'dizio)
;-> nil

Un altro metodo è il seguente:

(define (myhash:myhash key value)
   (if value
       (context 'myhash key value)
       (context 'myhash key)))

In questo modo possiamo inserire/interrogare i valori nel dizionario più comodamente:

(myhash "1" "uno")
(myhash "2" "due")
(myhash "3" "tre")
(myhash "1")
;-> "uno"

Adesso il funtore di default del contesto/dizionario myhash è una funzione:

(default 'myhash)
;-> (lambda (key value)
;->  (if value
;->   (context 'myhash key value)
;->   (context 'myhash key)))

E non possiamo elencare i valori con la funzione (<nome-del-contesto>):

(myhash)
;-> ERR: illegal parameter type in function context : nil
;-> called from user function (myhash)

Dobbiamo usare "dotree":

(dotree (w myhash)
    (if (not (lambda? (eval w)))
        (println (term w) " => " (eval w))))
;-> 1 => uno
;-> 2 => due
;-> 3 => tre


(dotree (w myhash) (println (term w) " => " (eval w)))
;-> 1 => uno
;-> 2 => due
;-> 3 => tre
;-> myhash => (lambda (key value)
;->  (if value
;->   (context 'myhash key value)
;->   (context 'myhash key)))


--------------------------
Dividere una lista/stringa
--------------------------

(setq lst '(1 2 3 4 5 6 7 8 9))
(setq str "abcdefghij")

1)
(explode lst 2)
;-> ((1 2) (3 4) (5 6) (7 8) (9))
(explode lst 2 true)
;-> ((1 2) (3 4) (5 6) (7 8))
(explode str 3)
;-> ("abc" "def" "ghi" "j")
(explode str 3 true)
;-> ("abc" "def" "ghi")

2)
(define (pairs lst n)
  (array-list (array (/ (length lst) n) n lst)))

(pairs lst 2)
;-> ((1 2) (3 4) (5 6) (7 8))
(pairs lst 3)
;-> ((1 2 3) (4 5 6) (7 8 9))

3)
(setq r '())
(for (e 0 (length lst) 2) (push (slice lst e 2) r -1))
;-> ((1 2) (3 4) (5 6) (7 8) (9))
(setq r '())
(for (e 0 (length lst) 3) (push (slice lst e 3) r -1))
;-> ((1 2 3) (4 5 6) (7 8 9) ())
(setq r '())
(for (c 0 (length str) 2) (push (slice str c 2) r -1))
;-> ("ab" "cd" "ef" "gh" "ij" "")
(setq r '())
(for (c 0 (length str) 3) (push (slice str c 3) r -1))
;-> ("abc" "def" "ghi" "j")

4)
(find-all ".." str)
;-> ("ab" "cd" "ef" "gh" "ij")
The . dot in a regex pattern stands for "any character".
(find-all "..." str)
;-> ("abc" "def" "ghi")
(find-all {..|.$} str)
;-> ("ab" "cd" "ef" "gh" "ij")
(find-all {...|..|.$} str)
;-> ("abc" "def" "ghi" "j")


--------------------
La funzione "expand"
--------------------

sintassi: (expand exp sym-1 [sym-2 ... ])
sintassi: (expand exp list-assoc [bool])
sintassi: (expand exp)

sintassi: (expand exp sym-1 [sym-2 ... ])
---------------------------------------
Nella prima sintassi, un simbolo in "sym" (o più in "sym-2" attraverso "sym-n") viene cercato in un'espressione semplice o nidificata "exp". Vengono quindi espansi all'associazione corrente del simbolo e viene restituita l'espressione espansa. La lista originale rimane invariata.

(set 'x 2 'a '(d e))
(set 'foo 'a)
(expand foo 'a)
;-> (d e)
(expand '(a x b) 'x)
;-> (a 2 b)
(expand '(a x (b c x)) 'x)
;-> (a 2 (b c 2))
(expand '(a x (b c x)) 'x 'a)
;-> ((d e) 2 (b c 2))

"expand" è utile quando si compongono espressioni lambda e si esegue l'espansione delle variabili come nelle macro di riscrittura.

(define (raise-to power)
  (expand (fn (base) (pow base power)) 'power))

(define square (raise-to 2))
(define cube (raise-to 3))

(square 5)
;-> 25
(cube 5)
;-> 125

Se è presente più di un simbolo, "expand" funzionerè in modo incrementale:

(set 'a '(b c))
(set 'b 1)

(expand '(a b c) 'a 'b)
;-> ((1 c) 1 c)

Come la funzione "apply", "expand" riduce la lista dei suoi argomenti.

syntax: (expand list list-assoc [bool])
---------------------------------------
La seconda sintassi di "expand" consente di specificare al volo i binding di espansione, senza eseguire un "set" sulle variabili partecipanti.
Se bool restituisce true, vengono valutate le parti del valore nella lista associativa.

(expand '(a b c) '((a 1) (b 2)))
;-> (1 2 c)
(expand '(a b c) '((a 1) (b 2) (c (x y z))))
;-> (1 2 (x y z))
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))))
;-> ((+ 1 2) (+ 3 4))
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))) true)
;-> (3 7)

Si noti che il contenuto delle variabili nella lista associativa non cambierà. Questo è diverso dalla funzione "letex", in cui le variabili vengono impostate valutando e assegnando le loro parti di associazione.

Questa forma di espansione viene spesso utilizzata nella programmazione logica, insieme alla funzione "unify".

syntax: (expand list)
---------------------
Una terza sintassi viene utilizzata per espandere solo il contenuto delle variabili che iniziano con un carattere maiuscolo. Questa modalità PROLOG può essere utilizzata anche nel contesto della programmazione logica. Come nella prima sintassi di "expand", i simboli devono essere preimpostati. Verranno espanse solo le variabili maiuscole e quelle associate a qualcosa di diverso da nil:

(set 'A 1 'Bvar 2 'C nil 'd 5 'e 6)
(expand '(A (Bvar) C d e f))
;-> (1 (2) C d e f)

Solo i simboli A e Bvar sono espansi perché hanno nomi in maiuscolo e contenuti non nulli.

La funzione currying nell'esempio mostra che la prima sintassi di "expand" ora può essere scritta ancora più semplicemente usando una variabile maiuscola:

(define (raise-to Power)
  (expand (fn (base) (pow base Power))))

(define cube (raise-to 3))
;-> (lambda (base) (pow base 3))

(cube 4)
;-> 64

Si veda la funzione "letex", che fornisce anche un meccanismo di espansione, e la funzione "unify", che è spesso usata insieme a "expand".


-----------------------------------------------
Aggiornamento dinamico dei simboli di una lista
-----------------------------------------------

Supponiamo di avere una lista con dei simboli all'interno:

(setq lst '(a 44 55 b c 66))

Il problema è quello di assegnare i valori ai simboli "a", "b" e "c".
Ad esempio, con a=1, b=2 e c=3, come possiamo trasformare la lista "lst" nella lista (1 44 55 2 3 66)?

Possiamo usare la funzione "expand" (che modifica una copia della lista):

(expand lst '((a 1) (b 2) (c 3)))
;-> (1 44 55 2 3 66)
lst
;-> (a 44 55 b c 66)

Questo metodo tratta "a", "b" e "c" come variabili locali (in modo simile a "let").

Se le variabili hanno un valore allora possiamo scrivere:

(set 'a 1 'b 2 'c 3)
(expand lst 'a 'b 'c)
;-> (1 44 55 2 3 66)


-------------------
Some math functions
-------------------

;
;
; Some math functions
; by Jeremy Dunn
;
;
; Command name alternates for naming consistency
;
(define-macro (less?)(apply < (args)))
(define-macro (greater?)(apply > (args)))
(define-macro (ge?)(apply >= (args)))
(define-macro (le?)(apply <= (args)))
(define-macro (e?)(apply = (args)))
(define-macro (ne?)(apply != (args)))
;
; Functions are shorthands for testing whether the number "a" lies within
; or without of various ranges of x and y
;
(define (lle?  x a y)(and (<  x a)(<= a y)))
(define (lel?  x a y)(and (<= x a)(<  a y)))
(define (gge?  x a y)(and (>  x a)(>= a y)))
(define (geg?  x a y)(and (>= x a)(>  a y)))
(define (lg?   x a y)(or  (<  a x)(>  a y)))
(define (lege? x a y)(or  (<= a x)(>= a y)))
;
; Functions for dealing with signs
;
; strictly positive
(define (spos? x)(> x 0))
(define (pos? x)(>= x 0))
(define (neg? x)(<= x 0))
; strictly negative
(define (sneg? x)(< x 0))
; similar to the sgn function except that it returns 1 if x=0 rather than 0
(define (sgn2 x)(if (zero? x) 1 (sgn x)))
; returns true if x and y have the same sign
(define (sgn=? x y)(= 1 (* (sgn2 x)(sgn2 y))))
; returns y with the same sign as x
(define (sgncast x y)(if (sgn=? x y) y (sub y)))
;
; Functions for approximation
;
; The fuzzy function must be called somewhere at the start of your program
; so that all functions that use the *fuzz* value will know what level of
; approximation to use.
; Sets the fuzz factor for functions that use it.
; (fuzzy) with no arguments resets *fuzz* to its default value of 0.000001.
; If there is an integer argument then *fuzz* is set to 10^n.
; If there is a real number as an argument then *fuzz* is set to that value.
(define (fuzzy (x 0.000001))
  (setq *fuzz* (if (integer? x) (pow 10 x) x)))
; Return true if x=y to within +-fz
(define (approx? x (y 0)(fz *fuzz*))
  (< (sub y fz) x (add y fz)))
; If x=y to within the fuzz factor then return y else return nil
(define (approx x (y 0)(fz *fuzz*))
  (if (approx? x y fz) y))

; Functions for (a+b)/c and (a-b)/c.
; If c is not supplied it defaults to 2.
(define (divadd a b (c 2))(div (add a b) c))
(define (divsub a b (c 2))(div (sub a b) c))

;
; Functions for vectors operations
;
; Calculate the square of a number x
(define (sq x)(mul x x))

; Calculate the quadrance of a vector
(define (quad u)(if (vector? u)(apply add (map sq u))))

; Calculate the magnitude of a vector
(define (mag u)(sqrt (quad u)))

; Return true if u is a vector i.e a list of numbers
(define (vector? u)
  (and (list? u)
       (apply and (map number? u))))

; The unit vector of a vector u, the distance from origin to u divided
; into the coordinates of u
(define (unitv u)
  (if (vector? u)
      (scalar/ (vec* u u)(quad u))))

; Add two or more vectors together.
; It is assumed that all vectors are the same length.
(define (v+ u v)(map add u v))
(define-macro (vec+)(apply v+ (map eval (args)) 2))

; Vector subtraction. If there is only a single
; vector then the negation of all its coordinates is returned.
(define (v- u v)(map sub u v))
(define-macro (vec-)
  (if (= 1 (length (args)))
      (map sub (eval (args 0)))
      (apply v- (map eval (args)) 2)))

(define (v* u v)(map mul u v))
(define-macro (vec*)
  (apply v* (map eval (args)) 2))

(define-macro (vec/)
  (map div (eval (args 0))
           (if (> (length (args)) 2)
               ; we test to perform only one division
               (apply vec* (map eval (rest (args))))
               (eval (args 1)))))

; Multiply a vector by a scalar. Vector first, scalar second
(define (scalar* v n)
  (map mul v (dup n (length v))))

; Divide a vector by a scalar. Vector first, scalar second
(define (scalar/ v n)
  (map div v (dup n (length v))))

; Vector Dot product of two vectors - produces a scalar
(define (dot u v)(apply add (vec* u v)))

; Vector Cross product of two vectors.
(define (cross u v)
  (setq u1 (u 0) u2 (u 1) u3 (u 2)
        v1 (v 0) v2 (v 1) v3 (v 2))
  (list (sub (mul u2 v3)(mul u3 v2))
        (sub (mul u3 v1)(mul u1 v3))
        (sub (mul u1 v2)(mul u2 v1))))

;Tensor product of three vectors
(define (tensor u v w)(vec* (dot u v) w))

;Scalar triple product
(define (striple u v w)(dot u (cross v w)))

;Vector triple product of three vectors
(define (vtriple u v w)(cross u (cross v w)))
;
; Functions to check numbers (by Lutz)
;
(define (octal? x) (= (eval-string x) (int x nil 8)))
(define (decimal? x) (= (eval-string x) (int x nil 10)))
(octal? "10")
;-> nil
(octal? "010")
;-> true
(decimal? "10")
;-> true
(decimal? "010")
;-> nil


------------------------------
Eliminazione sicura di un file
------------------------------

Cancellare un file in modo sicuro significa rendere difficile il recupero del file da parte di software di recupero dati.
Un metodo semplice e relativamente sicuro è quello di sovrascrivere il file diverse volte con caratteri casuali e poi cancellarlo.
In questo modo un eventuale recupero del file porterebbe solo ad un insieme di caratteri casuali.

(define (wipefile file overwrite)
  (local (size handle)
    (println "Secure delete: " file)
    (cond
      ((file? file) ; il file esiste
        (setq overwrite (or overwrite 1)) ; numero di sovrascritture del file
        (setq size (file-info file 0)) ; lunghezza del file
        (setq handle (open file "update")) ; handle del file
        (for (pass 1 overwrite)
          ; ciclo di sovrascrittura del file con valori casuali;
          (println "overwrite: pass " pass)
          (for (i 0 size)
              (write-char handle (rand 255))
          )
        )
        (close handle) ; chiusura del file
        (delete-file file) ; cancellazione del file
        (println "file deleted."))
      (true ; il file non esiste
        (println "Warning: file " file " don't exists."))
    )))

Facciamo alcune prove con file di grandezza diversa:

(change-dir "f:\\tmp")
;-> true
(real-path)
;-> "f:\\tmp"

; file da 100 Kb
(wipefile "test1.txt" 7)
;-> Secure delete: test1.txt
;-> overwrite: pass 1
;-> overwrite: pass 2
;-> overwrite: pass 3
;-> overwrite: pass 4
;-> overwrite: pass 5
;-> overwrite: pass 6
;-> overwrite: pass 7
;-> file deleted.

; file da 5 Mb
(time (wipefile "test2.zip" 7))
;-> Secure delete: test2.zip
;-> overwrite: pass 1
;-> overwrite: pass 2
;-> overwrite: pass 3
;-> overwrite: pass 4
;-> overwrite: pass 5
;-> overwrite: pass 6
;-> overwrite: pass 7
;-> file deleted.
;-> 51437.384 ;51s 437ms

; file da 1 Gb
(time (wipefile "test3.mp4"))
;-> Secure delete: test3.mp4
;-> overwrite: pass 1
;-> file deleted.
;-> 1507829.713 ;25m 7s 829ms

Nota: le probabilità di recuperare un file dipendono molto dal file-system del sistema operativo (es. I-node, cache, ecc.)


----------------------------------------------------------------------
Perfect Digital Invariant number (Numero invariante digitale perfetto)
----------------------------------------------------------------------

Un numero intero positivo è chiamato numero invariante digitale perfetto (PDI) se la somma di una certa potenza p delle loro cifre è uguale al numero stesso.
Per qualsiasi numero, abcd... = pow(a, p) + pow(b, p) + pow(c, p) + pow(d, p) + ... ,
  dove p può essere qualsiasi numero intero maggiore di 0.

Si può dimostrare che per una qualunque potenza p, il valore più grande per un PDI ha al massimo (p + 1) cifre.

Sequenza OEIS: A023052
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 4150, 4151,
  8208, 9474, 54748, 92727, 93084, 194979, 548834, 1741725, 4210818,
  9800817, 9926315, 14459929, 24678050, 24678051, 88593477, 146511208,
  472335975, 534494836, 912985153, ...

(define (sumpower power limit)
  (local (out p somma tmp)
    (setq out '())
    ; precalcola i valori delle potenze delle cifre
    (setq p (map (fn(x) (pow x power)) (sequence 0 9)))
    (for (num 0 limit)
      (setq somma 0)
      (setq tmp num)
      (while (!= tmp 0)
        (++ somma (p (% tmp 10)))
        (setq tmp (/ tmp 10))
      )
      (if (= somma num) (push somma out -1))
    )
    out))

Facciamo alcune prove (fino a p=9):

(sumpower 0 1e2)
;-> (0 1)
(sumpower 1 1e2)
;-> (0 1 2 3 4 5 6 7 8 9)
(sumpower 2 1e3)
;-> (0 1)
(sumpower 3 1e4)
;-> (0 1 153 370 371 407)
(sumpower 4 1e5)
;-> (0 1 1634 8208 9474)
(sumpower 5 1e6)
;-> (0 1 4150 4151 54748 92727 93084 194979)
(sumpower 6 1e7)
;-> (0 1 548834)
(time (println (sumpower 7 1e8)))
;-> (1 1741725 4210818 9800817 9926315 14459929)
;-> 122418.952 ; 2m 2s 418ms
(time (println (sumpower 8 1e9)))
;-> (1 24678050 24678051 88593477)
;-> 1342803.294 ; 22m 22s 803ms
(time (println (sumpower 9 1e9)))
;-> (0 1 146511208 472335975 534494836 912985153)
;-> 1325118.774 ; 22m 5s 118ms


-----------------------------------
Floating-point tolerances revisited
-----------------------------------

Traduzione dell'articolo: "Floating-point tolerances revisited"
https://realtimecollisiondetection.net/blog/?p=89
by Christer Ericson

Per diversi anni ho partecipato alla sessione di tutorial di fisica al GDC (insieme a Jim Van Verth, Gino van den Bergen, Erin Catto, Brian "Squirrel" Eiserloh e Marq Singer). Una sezione che ho trattato in dettaglio è la robustezza e all'interno di quest'area ho sottolineato (tra le altre cose) l'importanza di distinguere tra tolleranze assolute e relative quando si eseguono confronti di numeri in virgola mobile.

Non entrerò nei dettagli sul motivo per cui vorresti (dovresti) preoccuparti di come vengono confrontati i tuoi numeri in virgola mobile. (Informazioni dettagliate possono essere trovate in parte nelle diapositive della mia presentazione GDC e in modo molto più approfondito nel mio libro "Rilevamento delle collisioni in tempo reale"). Qui presumo che tu sappia già perché ti interessa, e noterò solo che le tolleranze assolute e relative sono testate come:

// Absolute tolerance comparison of x and y
if (Abs(x – y) <= EPSILON) ...

e

// Relative tolerance comparison of x and y
if (Abs(x – y) <= EPSILON * Max(Abs(x), Abs(y)) ...

Il test di tolleranza assoluta fallisce quando x e y diventano grandi e il test di tolleranza relativa fallisce quando diventano piccoli. Si desidera quindi combinare questi due test insieme in un unico test. Negli anni alla GDC, così come nel mio libro, ho suggerito il seguente test di tolleranza combinato:

if (Abs(x – y) <= EPSILON * Max(1.0f, Abs(x), Abs(y)) ...

Questo in genere funziona bene, ma Erin Catto mi ha fatto notare che a volte può essere difficile controllare il comportamento desiderato con un solo EPSILON che controlla contemporaneamente sia la tolleranza assoluta che quella relativa. Quando si desidera un controllo migliore, possiamo invece utilizzare la combinazione delle tolleranze nel modo seguente.
Quello che stiamo veramente cercando in termini di uguaglianza di x e y è il seguente test combinato:

if ((Abs(x - y) <= absTol) ||
    (Abs(x - y) <= relTol * Max(Abs(x), Abs(y)))) ...

Queste due espressioni possono essere catturate in un'unica formula come:

if (Abs(x - y) <= Max(absTol, relTol * Max(Abs(x), Abs(y)))) ...

o in modo equivalente:

if (Abs(x - y) <= absTol * Max(1.0f, relTol/absTol * Max(Abs(x), Abs(y)))) ...

Nel mio libro e nelle mie presentazioni GDC ho semplificato questa espressione assumendo relTol = absTol, che dà la mia formula originale:

if (Abs(x - y) <= absTol * Max(1.0f, Abs(x), Abs(y))) ...

Nei casi in cui l'assunzione relTol = absTol non è auspicabile ha senso rimanere con la formula:

if (Abs(x - y) <= Max(absTol, relTol * Max(Abs(x), Abs(y)))) ...

perché qui si possono modificare absTol e relTol indipendentemente l'uno dall'altro.
because here one can tweak absTol and relTol independently of each other.

Ho evitato di entrare nei dettagli nelle mie presentazioni GDC perché tendono ad essere limitate per il tempo e il messaggio importante da portare a casa è davvero "tolleranza assoluta spesso cattiva, tolleranza relativa per lo più buona". Tuttavia, ho ritenuto importante documentare queste informazioni aggiuntive sui confronti in virgola mobile da qualche parte, quindi questo breve articolo!

jchavez:
--------
Come notato nel tuo post, il confronto relativo:

|a - b| <= epsilon * max(|a|, |b|)

può restituire un risultato errato per a e b piccoli. Ciò accade perché il lato destro della disuguaglianza può arrivare fino a zero (underflow).
Per esempio:

float a = -FLT_MIN;
float b = FLT_MIN;
float epsilon = 2 * FLT_MIN;

abs(a - b) <= epsilon * max(abs(a), abs(b))

restituisce false a causa dell'underflow. Puoi, tuttavia, evitarlo verificando la presenza di un multiplo underflow e ristrutturando la disuguaglianza con una divisione:

float close_rel(float a, float b, float epsilon)
{
    // assume small positive epsilon
    assert(epsilon >= 0.0f && epsilon <= 1.0f);

    float diff = abs(a - b);
    float maxab = max(abs(a), abs(b));

    // if the multiply won't underflow then use a multiply
    if (maxab >= 1.0f)
    {
        return diff <= (epsilon * maxab);
    }
    // multiply could underflow so use a divide if nonzero denominator
    else if (maxab > 0.0f)
    {
        // correctly returns false on divide overflow
        // (inf <= epsilon is false), since overflow means the
        // relative difference is large and they are therefore not close
        return diff / maxab <= epsilon;
    }
    else
    {
        // both a and b are zero
        return false;
    }
}

Ciò intrappola correttamente il problema e consente un confronto relativo in tutte le situazioni. Questo, ovviamente, non è sempre auspicabile e sono d'accordo con te sul fatto che un test combinato di tolleranza assoluta e relativa sia il modo migliore per procedere. In quasi tutte le situazioni di gioco vuoi che due valori molto piccoli siano considerati uguali, anche se la loro differenza relativa è grande. Tuttavia, potrebbero esserci situazioni in cui un confronto puramente relativo è utile e questo è un modo per farlo.


-------------------------
Five programming problems
-------------------------

"Five programming problems every Software Engineer should be able to solve in less than 1 hour"
"Cinque problemi di programmazione che ogni Software Engineer dovrebbe essere in grado di risolvere in meno di 1 ora"
https://linepole.wordpress.com/2015/06/02/five-programming-problems-every-software-engineer-should-be-able-to-solve-in-less-than-1-hour/


Problem 1
---------
Write three functions that compute the sum of the numbers in a given list using a for-loop, a while-loop, and recursion.

(setq a '(10 -2 6 7 1))

(define (for-loop lst)
  (let (sum 0)
    (for (i 0 (- (length lst) 1))
      (setq sum (add sum (lst i)))
    )
    sum))

(define (while-loop lst)
  (let ((sum 0) (i 0))
    (while (< i (length lst))
      (setq sum (add sum (lst i)))
      (++ i)
    )
    sum))

(define (recurse lst)
  (cond ((= lst '()) 0)
        (true
          (add (first lst) (recurse (rest lst))))))

(for-loop a)
;-> 22
(while-loop a)
;-> 22
(recurse a)
;-> 22

Problem 2
---------
Write a function that combines two lists by alternatingly taking elements. For example: given the two lists [a, b, c] and [1, 2, 3], the function should return [a, 1, b, 2, c, 3].

(setq a '(1 2 3))
(setq b '("a" "b" "c" "d"))

(define (combine lst1 lst2)
  (local (len1 len2 out)
    (setq out '())
    (setq len1 (length lst1))
    (setq len2 (length lst2))
    (setq lmin (min len1 len2))
    (setq lmax (max len1 len2))
    ; alternating elements
    (for (i 0 (- lmin 1))
      (push (lst1 i) out -1)
      (push (lst2 i) out -1)
    )
    (if (!= lmin lmax)
      (if (< len1 len2)
        ; len2 > len1: copy the remaining elements of lst2
        (for (i lmin (- lmax 1)) (push (lst2 i) out -1))
        ;else
        ; len1 > len2: copy the remaining elements of lst1
        (for (i lmin (- lmax 1)) (push (lst1 i) out -1))
      )
    )
    out))

(combine a b)
;-> (1 "a" 2 "b" 3 "c" "d")
(combine b a)
;-> ("a" 1 "b" 2 "c" 3 "d")

Problem 3
---------
Write a function that computes the list of the first 100 Fibonacci numbers. By definition, the first two numbers in the Fibonacci sequence are 0 and 1, and each subsequent number is the sum of the previous two. As an example, here are the first 10 Fibonnaci numbers: 0, 1, 1, 2, 3, 5, 8, 13, 21, and 34.

Recursive version:

(define (fibo n)
  (cond ((zero? n) 0)
        ((= 1 n) 1)
        (true
          (+ (fibo (- n 1)) (fibo (- n 2))))))

(map fibo (sequence 0 10))
;-> (0 1 1 2 3 5 8 13 21 34 55)
(map fibo (sequence 0 99))
...too slow

Iterative and big-integer version:

(define (fibo2 n)
  (local (a b c)
    (cond ((zero? n) 0L)
      (true
        (setq a 0L b 1L c 0L)
        (for (i 0 (- n 1))
          ; i number
          (setq c (+ a b))
          ; (i - 2)
          (setq a b)
          ; (i - 1)
          (setq b c)
        )
        a))))

(map fibo2 (sequence 0 10))
;-> (0L 1L 1L 2L 3L 5L 8L 13L 21L 34L 55L)
(map fibo2 (sequence 0 99))
;-> (0L 1L 1L 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L 610L 987L
;->  1597L 2584L 4181L 6765L 10946L 17711L 28657L 46368L 75025L 121393L
;->  196418L 317811L 514229L 832040L 1346269L 2178309L 3524578L 5702887L
;->  9227465L 14930352L 24157817L 39088169L 63245986L 102334155L 165580141L
;->  267914296L 433494437L 701408733L 1134903170L 1836311903L 2971215073L
;->  4807526976L 7778742049L 12586269025L 20365011074L 32951280099L
;->  53316291173L 86267571272L 139583862445L 225851433717L 365435296162L
;->  591286729879L 956722026041L 1548008755920L 2504730781961L 4052739537881L
;->  6557470319842L 10610209857723L 17167680177565L 27777890035288L
;->  44945570212853L 72723460248141L 117669030460994L 190392490709135L
;->  308061521170129L 498454011879264L 806515533049393L 1304969544928657L
;->  2111485077978050L 3416454622906707L 5527939700884757L 8944394323791464L
;->  14472334024676221L 23416728348467685L 37889062373143906L
;->  61305790721611591L 99194853094755497L 160500643816367088L
;->  259695496911122585L 420196140727489673L 679891637638612258L
;->  1100087778366101931L 1779979416004714189L 2880067194370816120L
;->  4660046610375530309L 7540113804746346429L 12200160415121876738L
;->  19740274219868223167L 31940434634990099905L 51680708854858323072L
;->  83621143489848422977L 135301852344706746049L 218922995834555169026L)

Problem 4
---------
Write a function that given a list of non negative integers, arranges them such that they form the largest possible number. For example, given [50, 2, 1, 9], the largest formed number is 95021.

(setq a '(50 2 1 9))

(define (biggest lst)
  ; join the descending sort of the strings of numbers
  (join (sort (map string lst) >)))

(biggest a)
;-> "95021"

But fails with:

(setq t '("420" "423" "42"))
(biggest '(420 423 42))
;-> "42342042"

The correct result is: 42423420
(> 42423420 42342042)
;-> true

We must change the compare function of sort:

(sort t (fn(x y) (> (string x y) (string y x))))
;-> ("42" "423" "420")

(define (biggest2 lst)
  ; join the descending sort of the strings of numbers
  ; compare "x"+"y" and "y"+"x"
  (join (sort (map string lst) (fn(x y) (> (string x y) (string y x))))))

(biggest2 t)
;-> 42423420
(biggest2 a)
;-> 95021

Nota: i primi 4 problemi risolti in 45 minuti.

Problem 5
---------
Write a program that outputs all possibilities to put + or - or nothing between the numbers 1, 2, ..., 9 (in this order) such that the result is always 100. For example: 1 + 2 + 34 – 5 + 67 – 8 + 9 = 100.

Bad solution (but it is fast and works):

(define (hundred)
  (local (oper expr)
    (setq oper '("" " + " " - "))
    (dolist (e1 oper)
      (dolist (e2 oper)
        (dolist (e3 oper)
          (dolist (e4 oper)
            (dolist (e5 oper)
              (dolist (e6 oper)
                (dolist (e7 oper)
                  (dolist (e8 oper)
                    (setq expr (string "1" e1 "2" e2 "3" e3 "4" e4 "5" e5 "6" e6 "7" e7 "8" e8 "9"))
                    (if (= (eval (xlate expr)) 100)
                        (println expr))))))))))))

(hundred)
;-> 123 + 45 - 67 + 8 - 9
;-> 123 + 4 - 5 + 67 - 89
;-> 123 - 45 - 67 + 89
;-> 123 - 4 - 5 - 6 - 7 + 8 - 9
;-> 12 + 3 + 4 + 5 - 6 - 7 + 89
;-> 12 + 3 - 4 + 5 + 67 + 8 + 9
;-> 12 - 3 - 4 + 5 - 6 + 7 + 89
;-> 1 + 23 - 4 + 56 + 7 + 8 + 9
;-> 1 + 23 - 4 + 5 + 6 + 78 - 9
;-> 1 + 2 + 34 - 5 + 67 - 8 + 9
;-> 1 + 2 + 3 - 4 + 5 + 6 + 78 + 9

Nota: 20 minuti per risolvere il problema 5 in modo orribile, inoltre ho usato la funzione "xlate" per valutare le espressioni.
Ma io non sono un software engineer :-)


---------------------------
Numeri pandigitali quadrati
---------------------------

a) Trovare tutti i numeri a 9 cifre che sono quadrati perfetti e che usano tutte le cifre da 1 a 9 una volta ciascuna.

Sequenza OEIS A036744:
  139854276, 152843769, 157326849, 215384976, 245893761, 254817369,
  326597184, 361874529, 375468129, 382945761, 385297641, 412739856,
  523814769, 529874361, 537219684, 549386721, 587432169, 589324176,
  597362481, 615387249, 627953481, 653927184, 672935481, 697435281,
  714653289, 735982641, 743816529, 842973156, 847159236, 923187456

b) Trovare tutti i numeri a 10 cifre che sono quadrati perfetti e che usano tutte le cifre da 0 a 9 una volta ciascuna.

Sequenza OEIS A225218:
  1026753849, 1042385796, 1098524736, 1237069584, 1248703569, 1278563049
  1285437609, 1382054976, 1436789025, 1503267984, 1532487609, 1547320896
  1643897025, 1827049536, 1927385604, 1937408256, 2076351489, 2081549376
  2170348569, 2386517904, 2431870596, 2435718609, 2571098436, 2913408576
  3015986724, 3074258916, 3082914576, 3089247561, 3094251876, ...

a) Soluzione
------------

Numero più piccolo a 9 cifre:
(setq min9 123456789)

Numero più grande a 9 cifre:
(setq max9 987654321)

Quindi dovremmo verificare 864197532 numeri:

(setq num9 (- max9 min9))
;-> 864197532

Calcoliamo la radice quadrata dei valori min9 e max9:
(setq sqmin9 (sqrt min9))
;-> 1111.11106055556
(setq sqmax9 (sqrt max9))
;-> 31426.96805293187

In questo caso dobbiamo verificare 20315 numeri:

(setq sqnum9 (sub sqmax9 sqmin9))
;-> 20315.85699237631

oppure meglio:

(setq sqnum9 (- (int sqmax9) (int (+ sqmin9 1))))
;-> 20314

Funzione che verifica se un numero è pandigitale zeroless (9 cifre da 1 a 9):

(define (pan9? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            (if (ref '-1 lst) nil true)))))

Funzione che cerca i numeri pandigitali zeroless quadrati:

(define (square9)
  (local (out val)
    (setq out '())
    (for (i 11112 31426 1)
    ;(for (i 11112 31429 3)
      (setq val (* i i))
      (if (and (pan9? val) (= (sqrt val) i))
      ;(if (and (unique-digits val) (= (sqrt val) i))
        (push val out -1)
      )
    )
    out))

(square9)
;-> (139854276 152843769 157326849 215384976 245893761 254817369
;->  326597184 361874529 375468129 382945761 385297641 412739856
;->  523814769 529874361 537219684 549386721 587432169 589324176
;->  597362481 615387249 627953481 653927184 672935481 697435281
;->  714653289 735982641 743816529 842973156 847159236 923187456)

(time (square9) 100)
;-> 1420.024

Possiamo ottimizzare il ciclo "for" considerando che un numero pandigitale zeroless è divisibile per 9, quindi se ha radice quadrata perfetta, allora la radice è divisibile per 3: questo significa che possiamo incrementare la variabile del ciclo di 3 invece che di 1 ad ogni passo.

(define (square91)
  (local (out val)
    (setq out '())
    (for (i 11112 31426 3)
      (setq val (* i i))
      (if (and (pan9? val) (= (sqrt val) i))
        (push val out -1)
      )
    )
    out))

(= (square91) (square9))
;-> true

(time (square91) 100)
;-> 1090.954

Altra versione ottimizzata:

(define (square92)
  (local (square root x y found c a out)
    (setq out '())
    (setq root 11109)
    (setq a (array 10 '(0)))
    (setq square (* root root))
    (setq c 0)
    (setf (a 0) 1)
    (for (i 1 6771)
      (setq square (+ square (* 6 root) 9))
      (setq root (+ root 3))
      (for (j 1 9) (setf (a j) 0))
      (setq x square)
      (setq found 1)
      (setq stop nil)
      (for (j 1 9 1 stop)
        (setq y x)
        (setq x (/ x 10))
        (setq y (- y (* 10 x)))
        (if (> (a y) 0)
          (set 'found 0 'stop true)
          (setf (a y) 1)
        )
      )
      (if (= found 1)
        (begin
          (++ c)
          (push square out -1)
          ;(println square)
        )
      )
    )
    ;(println c " numeri pandigitali zeroless quadrati")
    out))

(= (square92) (square91))
;-> true

(time (square92) 100)
;-> 934.729


b) Soluzione
------------

Numero più piccolo a 10 cifre:

(setq min10 1023456789)

Numero più grande a 9 cifre:

(setq max10 9876543210)

Quindi dovremmo verificare 864197532 numeri:

(setq num10 (- max10 min10))
;-> 8853086421

Calcoliamo la radice quadrata dei valori min9 e max9:

(setq sqmin10 (sqrt min10))
;-> 31991.51120219237

(setq sqmax10 (sqrt max10))
;-> 99380.79900061178

In questo caso dobbiamo verificare 67389 numeri:

(setq sqnum10 (sub sqmax10 sqmin10))
;-> 67389.28779841941

oppure meglio:

(setq sqnum10 (- (int sqmax10) (int (+ sqmin10 1))))
;-> 67388

Funzione che verifica se un numero è pandigitale (10 cifre da 0 a 9):

(define (pan10? n)
  (cond ((or (< n 1023456789) (> n 9876543210) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 0 0 0 0 0 0 0 0 0))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            (if (ref '0 lst) nil true)))))

Funzione che cerca i numeri pandigitali quadrati:

(define (square10)
  (local (out val)
    (setq out '())
    (for (i 31992 99380 3)
      (setq val (* i i))
      (if (and (pan10? val) (= (sqrt val) i))
        (push val out -1)
      )
    )
    out))

(square10)
;-> (1026753849 1042385796 1098524736 1237069584 1248703569 1278563049
;->  1285437609 1382054976 1436789025 1503267984 1532487609 1547320896
;->  1643897025 1827049536 1927385604 1937408256 2076351489 2081549376
;->  2170348569 2386517904 2431870596 2435718609 2571098436 2913408576
;->  3015986724 3074258916 3082914576 3089247561 3094251876 3195867024
;->  3285697041 3412078569 3416987025 3428570916 3528716409 3719048256
;->  3791480625 3827401956 3928657041 3964087521 3975428601 3985270641
;->  4307821956 4308215769 4369871025 4392508176 4580176329 4728350169
;->  4730825961 4832057169 5102673489 5273809641 5739426081 5783146209
;->  5803697124 5982403716 6095237184 6154873209 6457890321 6471398025
;->  6597013284 6714983025 7042398561 7165283904 7285134609 7351862049
;->  7362154809 7408561329 7680594321 7854036129 7935068241 7946831025
;->  7984316025 8014367529 8125940736 8127563409 8135679204 8326197504
;->  8391476025 8503421796 8967143025 9054283716 9351276804 9560732841
;->  9614783025 9761835204 9814072356)

(time (square10) 100)
;-> 3885.126

Nota: il numero pandigitale più piccolo in base b vale:

                      b^b - b
min-pandigital(b) = ----------- + (b - 1)*b^(b-2) - 1
                     (b - 1)^2

(define (minpan b)
  (+ (/ (- (pow b b) b) (* (- b 1) (- b 1)))
     (* (- b 1) (pow b (- b 2))) (- 1)))

(minpan 10)
;-> 1023456789

(map minpan (sequence 2 10))
;-> (2 11 75 694 8345 123717 2177399 44317196 1023456789)

(define (b1-b2 num base1 base2)
"Convert an integer from base1 to base2 (2 <= base <= 10)"
  (if (zero? num) num
      (+ (% num base2) (* base1 (b1-b2 (/ num base2) base1 base2)))))

(map (fn(x y) (b1-b2 x 10 y)) (map minpan (sequence 2 10)) (sequence 2 10))
;-> (10 102 1023 10234 102345 1023456 10234567 102345678 1023456789)


---------------------------------
Numeri pandigitali polidivisibili
---------------------------------

Un numero polidivisibile è un numero che soddisfa le seguenti proprietà:
 - La sua prima cifra a non è 0.
 - Il numero formato dalle sue prime due cifre ab è un multiplo di 2.
 - Il numero formato dalle sue prime tre cifre abc è un multiplo di 3.
 - Il numero formato dalle sue prime quattro cifre abcd è un multiplo di 4.
 - ecc.

Trovare i numeri pandigitali (numeri che hanno tutte e 10 le cifre ripetute una volta soltanto) in cui le prime k cifre sono divisibili esattamente per k.

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che verifica se un numero (base 10) è polidivisibile:

(define (poly-div? n)
  (local (len stop)
    (setq len (length n))
    (setq stop nil)
    (for (i 2 len 1 stop)
      ;(println (slice s 0 i))
      (if (!= (% (int (div n (pow 10 (- len i)))) i) 0)
          (setq stop true)
      )
    )
    (not stop)))

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

(length (perm '(0 1 2 3 4 5 6 7 8 9)))
;-> 36628800

Funzione che cerca i numeri pandigitali in cui le prime k cifre sono divisibili esattamente per k:

(define (find-pan-poly)
  ; genera tutti i numeri pandigitali
  (let (numbers (perm '(0 1 2 3 4 5 6 7 8 9)))
    (dolist (el numbers)
      ; vengono verificati solo i numeri che non iniziano con 0
      (if (!= (el 0) 0)
        (if (poly-div? (list-int el)) (println (list-int el)))))))

(time (find-pan-poly))
;-> 3816547290
;-> 15982.041

Quindi 3816547290 è l'unico numero pandigitale polidivisibile.


-----------------
La funzione "sgn"
-----------------

****************
>>>funzione SGN
****************
sintassi: (sgn num)
sintassi: (sgn num exp-1 [exp-2 [exp-3]])

Nella prima sintassi, la funzione sgn è una funzione logica che estrae il segno di un numero reale secondo le seguenti regole:

x > 0 : sgn(x) = 1
x < 0 : sgn(x) = -1
x = 0 : sgn(x) = 0

(sgn -3.5)
;-> -1
(sgn 0)
;-> 0
(sgn 123)
;-> 1

Nella seconda sintassi, viene restituito il risultato della valutazione di una delle espressioni facoltative exp-1, exp-2 o exp-3, invece di -1, 0 o 1. Se exp-n manca per il caso attivato, quindi viene restituito nil.

(sgn x -1 0 1)         ; works like (sgn x)
(sgn x -1 1 1)         ; -1 for negative x all others 1
(sgn x nil true true)  ; nil for negative else true
(sgn x (abs x) 0)      ; (abs x) for x < 0, 0 for x = 0, else nil

Qualsiasi espressione o costante può essere utilizzata per exp-1, exp-2 o exp-3.


-------------------------------------
Area di sovrapposizione di rettangoli
-------------------------------------

Input: una lista di rettangoli
1) ogni rettangolo è rappresentato dai punti lower-left e upper-right con 4 numeri interi naturali: (x0,y0,x1,y1)
2) non sono ruotati, sono tutti rettangoli con i lati a due a due paralleli all'asse X e all'asse Y
3) sono posizionati in modo casuale: possono toccarsi ai bordi, sovrapporsi o non avere alcun contatto
4) Ci sono diverse centinaia di rettangoli

Output:
L'area che viene formata dalla loro sovrapposizione - tutta l'area che più di un rettangolo "copre" (ad esempio con due rettangoli, sarebbe la loro intersezione)
Non c'è bisogno di restituire la geometria della sovrapposizione, ma solo l'area (esempio: 4 metri quadrati)

Le sovrapposizioni non devono essere contate più volte, ad esempio, immaginiamo 3 rettangoli che hanno la stessa dimensione e posizione - sono uno sopra l'altro - quest'area dovrebbe essere contata una volta (non tre volte).

Esempio
L'immagine qui sotto contiene tre rettangoli: A,B,C,D
A e B si sovrappongono (come indicato dai trattini)
B e C si sovrappongono (come indicato dai trattini)
D e B si sovrappongono (come indicato dai trattini)

Quello che dobbiamo trovare è l'area in cui vengono visualizzati i trattini.

  AAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAAAAAAAAAAAAAAAAAA
  AAAAAAAAAAAAAA--------------BBB
  AAAAAAAAAAAAAA--------------BBB
  AAAAAAAAAAAAAA--------------BBB
  AAAAAAAAAAAAAA--------------BBB
                BBBBBBBBBBBBBBBBB
    DDDDDDDDDDDD---BBBBBBBBBBBBBB
    DDDDDDDDDDDD---BBBBBBBBBBBBBB
    DDDDDDDDDDDD---BBB-----------CCCCCCCC
                BBBBBB-----------CCCCCCCC
                      CCCCCCCCCCCCCCCCCCC
                      CCCCCCCCCCCCCCCCCCC
                      CCCCCCCCCCCCCCCCCCC
                      CCCCCCCCCCCCCCCCCCC

Creiamo una matrice "out" di dimensioni sufficienti per contenere tutti i rettangoli.
Inizializziamo la matrice "out" con tutti 0.
Per ogni rettangolo aumentiamo di 1 tutte le celle della matrice "out" che sono occupate dal rettangolo corrente.
Al termine avremo una matrice con valori da 0 a k, dove k è il numero massimo di rettangoli sovrapposti.
L'area di sovrapposizione di tutti i rettangoli è data dal numero di celle della matrice "out" che hanno valore maggiore di 1.
In particolare i valori delle celle della matrice hanno il seguente significato:

  0: nessun rettangolo occupa la cella
  1: 1 rettangolo occupa la cella
  2: 2 rettangoli occupano la cella
  ...
  k: k rettangoli occupano la cella

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

Funzione che calcola l'area di sovrapposizione di una lista di rettangoli:

(define (area-rect lst show)
  (local (xmax ymax area out)
    ; colonne
    (setq xmax (+ 1 (apply max (flat (map (fn(x) (list (x 0) (x 2))) lst)))))
    ; righe
    (setq ymax (+ 1 (apply max (flat (map (fn(x) (list (x 1) (x 3))) lst)))))
    ; matrice per contenere i rettangoli
    (setq out (array ymax xmax '(0)))
    ; ciclo che aggiorna le celle della matrice con tutti i rettangoli
    (dolist (r lst)
      (for (y (r 1) (- (r 3) 1))
        (for (x (r 0) (- (r 2) 1))
          (++ (out y x))
        )
      )
      ; visualizza ogni passaggio
      (if show (begin (print-matrix out) (read-line)))
    )
    ; stampa la matrice finale
    ; (print-matrix out)
    ; calcolo dell'area di sovrapposizione
    ; (conta tutti i valori della matrice che sono maggiori di 1)
    (setq area (length (filter (fn(x) (> x 1)) (flat (array-list out)))))))

Facciamo un paio di prove:

(setq r1 '(2 2 14 6))
(setq r2 '(1 5 5 8))
(setq r3 '(4 4 6 10))
(setq r4 '(8 5 12 10))
(setq r5 '(11 3 16 9))
(setq rects (list r1 r2 r3 r4 r5))

(area-rect rects)
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 2 2 2 1 1 0
;->  0 0 1 1 2 2 1 1 1 1 1 2 2 2 1 1 0
;->  0 1 2 2 3 2 1 1 2 2 2 3 2 2 1 1 0
;->  0 1 1 1 2 1 0 0 1 1 1 2 1 1 1 1 0
;->  0 1 1 1 2 1 0 0 1 1 1 2 1 1 1 1 0
;->  0 0 0 0 1 1 0 0 1 1 1 2 1 1 1 1 0
;->  0 0 0 0 1 1 0 0 1 1 1 1 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 23

(setq r1 '(2 2 16 10))
(setq r2 '(3 8 8 16))
(setq r3 '(6 13 15 15))
(setq r4 '(11 7 14 18))
(setq r5 '(13 5 18 9))
(setq rects (list r1 r2 r3 r4 r5))

(area-rect rects)
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 2 2 2 1 1 0
;->  0 0 1 1 1 1 1 1 1 1 1 1 1 2 2 2 1 1 0
;->  0 0 1 1 1 1 1 1 1 1 1 2 2 3 2 2 1 1 0
;->  0 0 1 2 2 2 2 2 1 1 1 2 2 3 2 2 1 1 0
;->  0 0 1 2 2 2 2 2 1 1 1 2 2 2 1 1 0 0 0
;->  0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 1 1 1 2 2 1 1 1 2 2 2 1 0 0 0 0
;->  0 0 0 1 1 1 2 2 1 1 1 2 2 2 1 0 0 0 0
;->  0 0 0 1 1 1 1 1 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 39

Vediamo la velocità della funzione:

1000 rettangoli (0..100):
(silent
  (setq coord (rand 101 4000))
  (setq pts (explode coord 4)))
(length pts)
;-> 1000
(time (println (area-rect pts)))
;-> 10136
;-> 58.963

1000 rettangoli (0..1000):
(silent
  (setq coord (rand 1001 4000))
  (setq pts (explode coord 4)))
(length pts)
;-> 1000
(time (println (area-rect pts)))
;-> 987341
;-> 5747.871

10000 rettangoli (0..100):
(silent
  (setq coord (rand 101 40000))
  (setq pts (explode coord 4)))
(length pts)
;-> 10000
(time (println (area-rect pts)))
;-> 10201
;-> 574.509

10000 rettangoli (0..1000):
(silent
  (setq coord (rand 1001 40000))
  (setq pts (explode coord 4)))
(length pts)
;-> 10000
(time (println (area-rect pts)))
;-> 1001032
;-> 52985.638

Nota: questo metodo permette anche di calcolare l'area delle sovrapposizioni multiple.


----------------------------------------------------------
Network programming and distributed scripting with newLISP
----------------------------------------------------------

by Ax0n (2009-07-08)

I'm not sure why I never re-posted this here, but alas, better late than never.  I should have an article published in the Summer 2009 issue of 2600 as well, but I haven't seen it yet.

This initially showed up in 2600: The Hacker Quarterly Volume 23 Number 4 (Winter 2006-2007)

newLISP (www.newlisp.org) is a relative newcomer to the interpreted language arena in terms of popularity. While it had its humble beginnings back in 1991 when Lutz Mueller started working on it, only in the last 4 years has development been consistently active.

newLISP is everything that old-school LISP languages are, with a lot of modern features. First off, it's a scripting language that's extremely fast. It has networking ability that's powerful enough to write TCP or UDP client or server applications. Then, to top that off, it has a command called net-eval which makes newLISP stand out from the crowd by giving it the unique ability to easily distribute tasks to other nodes over a network connection.

Binaries (under 200 kilobytes) are available for Windows, BSD, Linux, Mac OS X, Solaris and a host of other platforms. It is released under the GPL. Performance is also second to none. newLISP has been topping the charts on script interpreter benchmarks in several categories thanks to it's small size (under 200 kilobytes) and efficient C code. It outruns php, perl, and even ruby.

newLISP also has some other tricks up its sleeve that make it an excellent system administration scripting language. It has decent filesystem support, so it can see if files or directories exist, determine if a file's permissions are acceptable for reading or writing, and it has very powerful text processing ability using PCRE (perl compatible regular expressions). Finally, it's also worth mentioning that newLISP can easily import whole functions from dynamic libraries such as libmysqlclient (instant MySQL access from within newLISP!), tcl/tk (for creating graphical applications in newLISP) and zlib (for compression and decompression) just to name a few. This makes newLISP one of the most robust and flexible languages around. As you can tell, newLISP is a formidable choice for hackers, geeks, network admins or security professionals wishing to create scripted programs to do network operations or distributed computing with minimal effort

I am lucky to have been able to work directly with Lutz, the founder and creator of newLISP. I got a few direct lessons from him, and from there, started tinkering with it on my own. With that, the first thing I did was create a makeshift port scanner. I learn easiest by example, so here is what I came up with.

Here is port.lsp:

#!/usr/bin/newlisp
(set 'params (main-args))
(if (< (length params) 5)
  (begin
    (println "USAGE: port.lsp host begin-port end-port")
    (exit)
  )
)
(set 'host (nth 2 params))
(set 'bport (int (nth 3 params)))
(set 'eport (int (nth 4 params)))
(for (port bport eport)
  (begin
   (set 'socket (net-connect host port))
   (if socket (println port " open"))
  )
)
(exit)

The first part simply assigns the command line arguments into a list called params, then makes sure that 4 parameters were given (program name, host, begin port and ending port). If not, it displays a usage tip before exiting. The second part assigns elements of the list to appropriate variables, then uses a for loop to iterate through the ports, displaying open port numbers that are open. Note that on machines with packet filters that "drop" packets, this port scan will take a very long time. nmap is a much more robust port scanner, however this little script demonstrates the power of newLISP's network commands. We'll run this as a test just for fun:

$ ./port.lsp 192.168.0.105 1 200
21 open
22 open
23 open
25 open
79 open
111 open

Now, let's look into distributed computing, shall we? The core command behind newLISP's distributed computing power -- called "net-eval" -- operates on a list of lists (similar to a 3 dimensional array). The inner-most list is a list of host, port, and a string representing the command(s) you wish to run on the remote node. The outer-most list can contain as many host-port-command lists as your heart desires, allowing you to run many distributed processes at once, and get the results back all at the same time. Then, outside those lists is a timeout in milliseconds. If a result isn't returned in the timeout period, the operation returns "nil" (that is, false). To clarify, net-eval syntax is as follows:

(net-eval (list (list "host" port-number command-string)) timeout)

On each remote node, you must have a newLISP listener, which is simply started by running "newlisp -c -d port-number" from the command line. On UNIX environments, you may put an ampersand (&) at the end to launch it in the background, or you may even wish to use "set NOHUP" and log off to leave it running in the background indefinitely. In my example, I went to my Solaris box and launched it, listening on port 31337 as follows:

$ newlisp -c -d 31337 &

I also launched newLISP listeners on various other machines on my home network, including a few OpenBSD machines, and my wife's MUD/BBS server running Windows Server 2003 with the "Services for UNIX" tools installed.

Now, care must be taken. It is a bad idea to have a newLISP listener running on a public IP address, because commands like process or exec can launch shell processes on the newLISP node, which is just as good as giving away an unprotected shell account on your network. I advise using newLISP listener nodes only behind a NAT or firewall, or on a segregated network.

Let's run a test script, shall we? In LISP, boolean and math operations are always performed by placing the operator first, followed by the symbols to apply it to. In addition, the symbols are numbers, but they could easily be strings or lists with some operations. Adding 1 + 2 in LISP is as simple as (+ 1 2) I will start by running a quick addition operation on 1 remote node with a 3000ms (3 second) timeout.

Here is net-eval-test.lsp:

#!/usr/bin/newlisp
(set 'evalstring "(+ 1 2)")
(println (net-eval (list (list "192.168.0.55" 31337 evalstring)) 3000))
(exit)

When we run it, we get the answer to this mind-boggling math problem:
$ ./net-eval-test.lsp

(3)
Now, to expand this even more, I have added three other nodes into the mix, which shows more clearly how the nested list syntax of net-eval works, and I'll demonstrate remote command execution at the same time, using the "exec" command. Notice how the quotes around the command to be run is escaped with backslashes. This is needed to keep from confusing the interpreter. To put quotes inside a quoted string, you need to escape them. This is almost universal to all programming languages. On UNIX-like platforms, uname is used to get information about the operating system and architecture. uname -s -n -m will list the OS that's running, the hostname, and the machine architecture.

Here is uname.lsp:

#!/usr/bin/newlisp
(set 'evalstring "(exec \"uname -s -n -m\")")
(println (net-eval (list
        (list "localhost" 31337 evalstring)
        (list "192.168.0.55" 31337 evalstring)
        (list "192.168.0.102" 31337 evalstring)
        (list "192.168.0.127" 31337 evalstring)
        ) 3000))
(exit)

The result is a newLISP list of strings, containing the results of running the command:

$ ./uname.lsp
(("SunOS sparky sun4u") ("OpenBSD compy386 i386") ("OpenBSD bouncer sparc") ("Windows mudbbs x86"))

The online documentation for newLISP is very extensive, and features a few rather advanced demonstration scripts, including a working web server written entirely in newLISP. While learning a new programming language is never easy, newLISP is more than mature enough in both implementation and documentation to make it a pretty easy language to add to your list.


-------------------------------------
Convertire una espressione in stringa
-------------------------------------

Per trasformare un simbolo/funzione/contesto in una stringa possiamo usare la funzione "source".

*******************
>>>funzione SOURCE
*******************
sintassi: (source)
sintassi: (source sym-1 [sym-2 ... ])

Funziona in modo quasi identico a save, tranne che i simboli e i contesti vengono serializzati su una stringa anziché essere scritti su un file. È possibile specificare più simboli variabili, definizioni e contesti. Se non viene fornito alcun argomento, source serializza l'intero spazio di lavoro di newLISP. Quando i simboli di contesto sono serializzati, anche i simboli contenuti in quel contesto saranno serializzati. I simboli di sistema che iniziano con il carattere $ (simbolo del dollaro) vengono serializzati solo quando menzionati esplicitamente.

I simboli che non appartengono al contesto corrente sono scritti con il loro prefisso di contesto.

(define (double x) (+ x x))

(source 'double)
;-> "(define (double x)\n  (+ x x))\n\n"

Come con "save", la formattazione delle interruzioni di riga e degli spazi iniziali o delle tabulazioni può essere controllata usando la funzione pretty-print.

Da una REPL nuova:

(setq all (source))
;-> "\r\n(context 'Class)\r\n\r\n(define (Class:Class )\r\n  (cons ..."
(println all)
;->
;-> (context 'Class)
;-> (define (Class:Class )
;->   (cons (context) (args)))
;->
;-> (context MAIN)
;->
;-> (context 'Tree)
;->
;-> (context MAIN)
;->
;-> (define (module $x)
;->   (load (append (env "NEWLISPDIR") "/modules/" $x)))
;->
;-> (global 'module)
;->
;-> (constant (global 'ostype) "Windows")


------------------------------
Sequenze di interi con somma N
------------------------------

Scrivete un programma che trovi tutte le serie di interi positivi consecutivi la cui somma sia esattamente ad un numero intero N.

Un possibile approccio consiste nell'utilizzare due cicli nidificati.
Il più grande valore possibile in una serie di numeri interi positivi consecutivi che sommano a N vale N/2.
Quindi il ciclo esterno va da 1 a N/2 (o (N/2 + 1) se N è dispari).
Ad ogni passaggio, il secondo ciclo passa consecutivamente dal valore attuale al punto in cui la somma di quei numeri è uguale o superiore a N.
Se la somma è uguale a N, abbiamo trovato una soluzione (inizio e fine della serie) e poi incrementiamo nuovamente il contatore del ciclo esterno.

(define (seq-sum1 num)
  (local (somma primo iter out)
    (if (even? num)
      (setq iter (/ num 2))
      (setq iter (+ (/ num 2) 1))
    )
    (for (i 1 iter)
      (setq somma 0)
      (setq primo i)
      (while (< somma num)
        (setq somma (+ somma primo))
        (++ primo)
      )
      (if (= somma num) (push (list i (- primo 1)) out -1))
    )
    out))

Facciamo alcune prove:

(seq-sum1 10000)
;-> ((18 142) (297 328) (388 412) (1998 2002))

(seq-sum1 10001)
;-> ((5 141) (101 173) (5000 5001))

(seq-sum1 12345)
;-> ((397 426) (816 830) (1230 1239) (2055 2060)
;->  (2467 2471) (4114 4116) (6172 6173))

Una funzione che controlla i risultati:

(define (check lst)
  (dolist (el lst)
    (print (apply + (sequence (el 0) (el 1))) ", ")))

(check (seq-sum1 10000))
;-> 10000, 10000, 10000, 10000
(check (seq-sum1 10001))
;-> 10001, 10001, 10001
(check (seq-sum1 12345))
;-> 12345, 12345, 12345, 12345, 12345, 12345, 12345

Vediamo la velocità di esecuzione:

(time (println (setq a (seq-sum1 123456789))))
;-> ((5117 16525) (5999 16819) (12429 20034) (13507 20720) (30562 34364)
;->  (32424 36030) (6858702 6858719) (13717417 13717425) (20576129 20576134)
;->  (41152262 41152264) (61728394 61728395))
;-> 103872.129

(check a)
;-> 123456789, 123456789, 123456789, 123456789, 123456789, 123456789,
;-> 123456789, 123456789, 123456789, 123456789, 123456789

Possiamo ottimizzare la funzione nel modo seguente:
Utilizziamo un ciclo esterno che va da 1 a N.
Aumentiamo il valore della somma (somma) con il valore del contatore (i) del ciclo esterno e verifichiamo se supera N.
Quando questo accade sottraiamo il valore dell'inizio della serie (primo) dil totale e quindi aumentiamo (primo) di 1. Alla fine, la somma diminuisce torna a N o meno, e quando ciò accade il programma esce da quel ciclo.
Se la somma a quel punto è esattamente 10.000, abbiamo trovato una soluzione.
In questo caso la fine della serie equivale al contatore del ciclo esterno, quindi continuiamo con il successivo valore fino a N/2.

(define (seq-sum2 num)
  (local (somma primo iter out)
    (setq somma 0)
    (setq primo 1)
    (if (even? num)
      (setq iter (/ num 2))
      (setq iter (+ (/ num 2) 1))
    )
    (for (i 1 iter)
      (setq somma (+ somma i))
      (while (> somma num)
        (setq somma (- somma primo))
        (++ primo)
      )
      (if (= somma num) (push (list primo i) out -1))
    )
    out))

Facciamo alcune prove:

(seq-sum2 10000)
;-> ((18 142) (297 328) (388 412) (1998 2002))

(seq-sum2 10001)
;-> ((5 141) (101 173) (5000 5001))

(seq-sum2 12345)
;-> ((397 426) (816 830) (1230 1239) (2055 2060)
;->  (2467 2471) (4114 4116) (6172 6173))

(check (seq-sum2 10000))
;-> 10000, 10000, 10000, 10000
(check (seq-sum2 10001))
;-> 10001, 10001, 10001
(check (seq-sum2 12345))
;-> 12345, 12345, 12345, 12345, 12345, 12345, 12345

Vediamo la velocità di esecuzione:

(time (println (setq b (seq-sum2 123456789))))
;-> ((5117 16525) (5999 16819) (12429 20034) (13507 20720) (30562 34364)
;->  (32424 36030) (6858702 6858719) (13717417 13717425) (20576129 20576134)
;->  (41152262 41152264) (61728394 61728395))
;-> 11433.28

Questa funzione è 9 volte più veloce.

(check b)
;-> 123456789, 123456789, 123456789, 123456789, 123456789, 123456789,
;-> 123456789, 123456789, 123456789, 123456789, 123456789

In Pascal (FreePascal Compiler 3.2.2):

program main (input, output);
var
  num, i, primo, somma, iter: integer;
begin
  num := 10001;
  somma := 0;
  primo := 1;
  if num mod 2 = 0 then
    iter := num div 2;
    iter := num div 2 + 1;
  for i := 1 to iter do
    begin
      somma := somma + i;
      while somma > num do
        begin
          somma := somma - primo;
          primo := primo + 1;
        end;
      if (somma = num) then
        writeln ('(', primo, ',', i, ')');
    end
end.

Free Pascal Compiler version 3.2.2
Copyright (c) 1993-2021 by Florian Klaempfl and others
Target OS: Windows for x86-64
Compiling main.pas
Linking a.out
23 lines compiled, 0.0 sec
(5,141)
(101,173)
(5000,5001)

Un altro approccio è quello di tenere traccia della somma raggiunta e regolarla in base al confronto con la somma fissata.

(define (seq-sum3 num)
  (local (inizio fine somma out)
    (set 'inizio 1 'fine 1 'somma 1 'out '())
    (while (<= inizio (/ num 2))
      (cond ((< somma num)
              (++ fine)
              (++ somma fine))
            ((> somma num)
              (-- somma inizio)
              (++ inizio))
            ((= somma num)
              (push (list inizio fine) out -1)
              (-- somma inizio)
              (++ inizio))
      )
    )
    out))

(seq-sum3 10000)
;-> ((18 142) (297 328) (388 412) (1998 2002))

(seq-sum3 10001)
;-> ((5 141) (101 173) (5000 5001))

(seq-sum3 12345)
;-> ((397 426) (816 830) (1230 1239) (2055 2060)
;->  (2467 2471) (4114 4116) (6172 6173))

(check (seq-sum3 10000))
;-> 10000, 10000, 10000, 10000
(check (seq-sum3 10001))
;-> 10001, 10001, 10001
(check (seq-sum3 12345))
;-> 12345, 12345, 12345, 12345, 12345, 12345, 12345

Vediamo la velocità di esecuzione:

(time (println (setq c (seq-sum3 123456789))))
;-> ((5117 16525) (5999 16819) (12429 20034) (13507 20720) (30562 34364)
;->  (32424 36030) (6858702 6858719) (13717417 13717425) (20576129 20576134)
;->  (41152262 41152264) (61728394 61728395))
;-> 16898.714

(check c)
;-> 123456789, 123456789, 123456789, 123456789, 123456789, 123456789,
;-> 123456789, 123456789, 123456789, 123456789, 123456789

Se invece vogliamo trovare solo il numero di modi di esprimere N come somma di numeri consecutivi, allora possiamo rappresentare la serie come una sequenza di lunghezza K+1 nel modo seguente:

  N = a + (a+1) + (a+2) + .. + (a+K)

Adesso possiamo ricavare il valore di "a":

  N = (K+1)*a + (K*(K+1))/2
  a = (N - K*(K+1)/2)/(K+1)

Sostituiamo i valori di K a partire da 1 fino a K*(K+1)/2 < N.
Se otteniamo "a" come numero naturale allora abbiamo trovato una soluzione.

(define (num-seq num)
  (local (total K)
    (setq total 0)
    (setq K 1)
    (while (< (* K (+ K 1)) (* 2 num))
      (setq a (div (sub num (div (mul K (add K 1)) 2))
                   (add K 1)))
      ; (println K { } a { } (int a)) (read-line)
      (if (= a (int a 0 10)) (++ total))
      (++ K)
    )
    total))

Facciamo alcune prove:

(num-seq 10000)
;-> 4
(num-seq 10001)
;-> 3
(num-seq 12345)
;-> 7

(time (println (num-seq 123456789)))
;-> 11
;-> 5.984


------------------------------------
Numero successivo con cifre distinte
------------------------------------

Dato un numero intero N, trovare il numero successivo che ha cifre tutte distinte.

(setq MAX-INT 9223372036854775807)

(define (next-distinct num)
  (local (totale distinte continua out)
    (setq continua true)
    (while (and (< num MAX-INT) continua)
      (setq distinte (length (unique (explode (string (+ num 1))))))
      (setq totale (length (+ num 1)))
      ;(println num { } totale { } distinte) (read-line)
      (if (= distinte totale)
          (set 'out (+ num 1) 'continua nil)
          ;else
          (++ num)
      )
    )
    out))

(next-distinct 2023)
;-> 2031


----------------------------------------------
Differenza tra i caratteri "" e i caratteri {}
----------------------------------------------

In newLISP i caratteri "" e {} vengono usati per delimitare le stringhe.
La differenza tra i due metodi è la seguente:

- i doppi apici "" pre-processano la stringa racchiusa per eventuali caratteri di escape (es. backslash "\\")

- le parentesi graffe {} non pre-processano la stringa racchiusa, ma prende i caratteri letteralmente.

Vediamo alcuni esempi:

(println "\\newlisp")
;-> \newlisp
(println {\newlisp})
;-> \newlisp

In the first one, which is delimited by quotes you would have to escape the backslash with another backslash, which is not necessary in the second one, which is delimited by curly braces. Curly braces suppress pre-processing and take the characters literally.

(set 't "       ; this is a comment")
(find "(\s*)(;+?)(.*)" t 0)
;-> 7 ; risultato corretto è 0
(find {(\s*)(;+?)(.*)} t 0)
;-> 0

Nella prima, delimitata da virgolette, occorre usare il carattere di escape davanti al backslash
Nella seconda, delimitata da parentesi graffe. questo non è necessario perchè i caratteri vengono presi alla lettera.

; only single backslash needed
(find {(\s*)(;+?)(.*)} t 0)
;-> 0
; double backslash necessary
(find "(\\s*)(;+?)(.*)" t 0)
;-> 0


-----------------------------
Cryptography fun with newLISP
-----------------------------

by Ax0n (2007-02-07)

Some of you may have seen my article in the latest 2600 magazine about newLISP, a very fast scripting language based on LISP.

Well, the HiR crew has, for the better part of a year, been kicking around cryptography concepts. We keep coming back to one-time pad cryptography. It's fascinating in its simplicity. It's so computationally trivial that a human can quickly encrypt or decrypt a simple modular addition one-time pad scheme with nothing but a pencil and paper. The other thing is that, when implemented properly, OTP is perfectly secret and highly resistant to all forms of cryptanalysis. To this day, OTP is one of the most powerful and feared crypto schemes in existance.

Back here in computer world, we do a comparison on two numeric values assigned to the "cleartext" message. Since all ASCII characters have a decimal value in an 8-bit character space (256 distinct combinations), it's very easy to perform a bitwise Exclusive Or (XOR) on the cleartext and the key. XOR is simply "one or the other but not both". Let's try a cleartext of the letter A (binary 01000001) XOR against a key of "q" (binary 01110001). Comparing the bits vertically, the result will only have a "1" wherever either A or q have a differing bit at that location, but will have a "0" wherever both bits are the same.

"A"=01000001
"q"=01110001
-----00110000 (as it turns out, this is an ASCII uppercase "O")

newLISP, like all LISP based languages, handles lists and symbols very well. I just played around with this concept on the newLISP command line, and the result was fun, but not very practical as executed. I'll discuss ways to make this tinkering session a little more practical at the end of the article.

Ideally, the key would not be a string, but a very solid random set of characters known by the parties who are encrypting messages to one another. This doesn't even need to be a string, it may be binary random data...

A few things about this code. First, I'm a newbie at newLISP. Let me describe how some of this stuff works. The "explode" command turns a string variable into a list of characters. "char" turns a character into its ASCII decimal equivalent, or an ASCII decimal number back into a character. "map" simply takes the operation (such as "char") and uses that operation on a list. So (map char (explode cleartext)) would return the output of "char" for each individual character in the contents of the "cleartext" variable. Confusing enough? Okay, awesome!

# newlisp
#first, I'll assign a key and convert it to a list of ascii numbers.
> (set 'key "Pa5$w0rd!")
"Pa5$w0rd!"

> (set 'kcharlist (map char (explode key)))
(80 97 53 36 119 48 114 100 33)

#Then, I'll assign a cleartext string and convert it to a list of ascii numbers as well.
> (set 'cleartext "HiR ownz.")
"HiR ownz."

> (set 'ccharlist (map char (explode cleartext)))
(72 105 82 32 111 119 110 122 46)

#In many languages, newLISP included, the carat "^" is the symbol for XOR. This line outputs the XOR values for each character compared between the cleartext and key)
> (set 'cryptcharlist (map ^ ccharlist kcharlist))
(24 8 103 4 24 71 28 30 15)

#Note that some of the characters from the XOR operation are non-printable, so their ASCII string notation /nnn is used instead.
> (set 'cryptostring (join (map char cryptcharlist)))
"\024\008g\004\024G\028\030\015"

#Now on the receiving end, we take the known key character list and we XOR the crypto character list. In reality we'd have to generate these again but we'd already set the variables above. No sense repeating the process here.
> (set 'decryptcharlist (map ^ cryptcharlist kcharlist))
(72 105 82 32 111 119 110 122 46)

#Finally, we take that string of numbers and join them after converting them from ASCII Decimal to characters again.
> (set 'decryptstring (join (map char decryptcharlist)))
"HiR ownz."

Now, as I'd mentioned before, in order to be really practical, you'd need an actual one-time pad that was very random. What I made above was a variant of Vernam cipher to give you a taste of how simple XOR based encryption is, not a genuine one-time pad. A few things that would make the above more practical:
A lot of the steps could have been consolidated. I broke it down to show how things worked. I could have simply put all of the logic in one line, but it would have been confusing.
The key and cleartext should be able to be read from a file. As implemented above, this should work with binary data (executables, images, etc) and with a very random binary key (pad) file.
In the code above, the key needs to be the exact same number of characters as the cleartext. If implemented practically, the program should read the length of the cleartext and use that many bytes of the random pad.
In a true one-time pad scheme, the sender and recipient both possess the same random key data, but the sender must destroy the part of the key that was used as soon as the encryption is performed. That way, only the recipient(s) may decrypt the message, as they have the only existing copy of the key. In turn, the recipient must destroy the part of the key used to decrypt the message so that in the event the encrypted message was compromised, there is no existing copy of the key available to aid in decryption.
The above inconveniences have been the main downfall to widespread use of OTP.
OTP's strength relies heavily on protocol, not technology.
As I get more free time, I will write a quick one-time pad newLISP script that can do most of the above things. I just got the craving to tinker and write a little bit, and thought I'd share it here.
--------------------------------

Ax0n:
-----
#!/usr/bin/newlisp
(set 'params (main-args))
(if (< (length params) 6)
  (begin
    (println "USAGE: crypt.lsp <pad> <file> <output> <padremainder>")
    (exit)
  )
)
(set 'pad (nth 2 params))
(set 'file (nth 3 params))
(set 'out (nth 4 params))
(set 'padr (nth 5 params))
(set 'padfh (open pad "read"))
(set 'filefh (open file "read"))
(set 'outfh (open out "write"))
(set 'padrfh (open padr "write"))
(while (set 'filechr (read-char filefh))
  (set 'padchr (read-char padfh))
  (set 'xor (^ filechr padchr))
  (write-char outfh xor)
)

while (set 'padchr (read-char padfh))
  (write-char padrfh padchr)
)
(close padfh)
(close padrfh)
(close filefh)
(close outfh)
(exit)

Lutz:
-----
(set 'fname (main-args 2))
(print "Passphrase:")
(write-file (append fname ".enc") (encrypt (read-file fname) (read-line)))
(exit)

Because it is XOR based it works both ways for encryption and decryption.

Ax0n:
-----
#!/usr/bin/newlisp
(set 'pad (main-args 2))
(set 'target (main-args 3))
(write-file (append target ".enc") (encrypt (read-file target) (read-file pad)))
(exit)

resulting cipher is the same.

~/test $ hexdump crypt.txt
0000000 84fd 7697 3858 6738 1641 ee11 9008 c366
0000010 5fdd 1b5e a3b5 b2f9 1079 144f 40ce 0029
000001f

~/test $ hexdump clear.txt.enc
0000000 84fd 7697 3858 6738 1641 ee11 9008 c366
0000010 5fdd 1b5e a3b5 b2f9 1079 144f 40ce 0029
000001f

So, it does the same thing my program does, but loops the key if it is shorter than the clear?

Lutz:
-----
Yes, exactly. In your program that means, that there will only be a remainder when the pad is longer than the target, else 'encrypt' will apply the pad over and over. Allthough for the last piece in the file only part of the pad may be applied, if the clear-length is not an integer multiple of the pad-length.

Ax0n:
-----
#!/usr/bin/newlisp
(set 'params (main-args))
(if (< (length params) 5)
  (begin
    (println "USAGE: crypt.lsp [pad] [file] [output] [pad-remainder]")
    (exit)
  )
)
(set 'pad (params 2))
(set 'target (params 3))
(set 'output (params 4))
(set 'remainder (params 5))
(write-file output (encrypt (read-file target) (read-file pad)))
(write-file remainder (slice (read-file pad) (length (read-file target))))
(exit)

cormullion:
-----------

(cond
  ((< (length (main-args)) 5)
     (println "USAGE: crypt.lsp [pad] [file] [output] [pad-remainder]"))
  (true
     (map set '(pad target output remainder) (rest (rest (main-args))))
     (write-file output (encrypt (read-file target) (read-file pad)))
     (write-file remainder (slice (read-file pad) (length (read-file target))))))
(exit)

Vedere anche "Criptazione e decriptazione di un file" su "Funzioni varie"


-------------
sym e context
-------------

Possiamo creare simboli in un contesto con la funzione "sym":

(while (read-line)
  (dolist (word (parse (current-line)))
    (sym word 'HT)))
a b c  ; simboli inseriti nella prima riga
d e f  ; simboli inseriti nella seconda riga
^Z     ; premere Ctrl-Z per uscire dal ciclo
;-> HT:f

Vediamo i simboli creati nel contesto HT:

(symbols HT)
;-> (HT:a HT:b HT:c HT:d HT:e HT:f)

Oppure:

(context HT)
;-> HT
(symbols)
;-> (a b c d e f)

Se vogliamo estrarre, dal contesto MAIN, i nomi dei simboli di un contesto senza avere il nome del contesto (es. HT:a), possiamo usare la funzione "term":

(map term (symbols HT))
("a" "b" "c" "d" "e" "f")

Nota: è consigliabile anteporre il carattere "_" nei simboli di un contesto per evitare conflitti con funzioni integrate.
(sym (string "_" word) 'HT)


----------------
Cifratura Atbash
----------------

La cifratura Atbash è un cifrario a sostituzione con una sola chiave specifica in cui tutte le lettere sono invertite, cioè un alfabeto dalla A alla Z e un altro dalla Z alla A (è stato usato per codificare gli alfabeti ebraici, ma può codificare anche altri alfabeti con opportune modifiche).

La funzione permette anche di definire un altro alfabeto per la cifratura.

(setq a1 '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" " "))
(setq a2 '("z" "y" "x" "w" "v" "u" "t" "s" "r" "q" "p" "o" "n" "m" "l" "k" "j" "i" "h" "g" "f" "e" "d" "c" "b" "a" " "))
(setq alst '(("a" "z") ("b" "y") ("c" "x") ("d" "w") ("e" "v") ("f" "u")
             ("g" "t") ("h" "s") ("i" "r") ("j" "q") ("k" "p") ("l" "o")
             ("m" "n") ("n" "m") ("o" "l") ("p" "k") ("q" "j") ("r" "i")
             ("s" "h") ("t" "g") ("u" "f") ("v" "e") ("w" "d") ("x" "c")
             ("y" "b") ("z" "a")))

(define (atbash msg alfa)
  (local (a1 a2 alst cr out)
    (setq a1 '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" " "))
    (setq a2 '("z" "y" "x" "w" "v" "u" "t" "s" "r" "q" "p" "o" "n" "m" "l" "k" "j" "i" "h" "g" "f" "e" "d" "c" "b" "a" " "))
    (setq a2 (or alfa a2))
    (setq alst (map list a1 a2))
    (setq out "")
    (dolist (ch (explode msg))
      (setq cr (lookup ch alst))
      (if cr
        ; carattere conosciuto --> criptato
        (extend out cr)
        ; carattere sconosciuto --> non criptato
        (extend out ch)
      )
    )
    out))

(atbash "newlisp is magic")
;-> "mvdorhk rh nztrx"

(setq a3 (randomize (explode "abcdefghijklmnopqrstuvwxyz")))
;-> ("m" "a" "y" "u" "g" "r" "n" "d" "s" "i" "p" "e" "k" "j" "x" "h"
;->  "z" "o" "b" "l" "f" "t" "w" "q" "v" "c")

(atbash "newlisp is magic" a3)
;-> "jgwesbh sb kmnsy"

Nota: questo metodo di cifratura è facilmente decrittabile usando l'analisi della frequenze dei caratteri.


----------------------------
Cifrario quadrato di Polibio
----------------------------

Un quadrato (o scacchiera) di Polibio è una tabella che permette di convertire le lettere in numeri.
Per rendere la crittografia un pò più sicura la tabella può essere randomizzata e condivisa con il destinatario. Per adattarsi alle 26 lettere dell'alfabeto nelle 25 celle create dalla tabella, le lettere "I" e "J" sono generalmente combinate in una singola cella. Inizialmente non vi era alcun problema perché l'antico alfabeto greco ha 24 lettere.
Una tabella di dimensioni più grandi potrebbe essere utilizzata se un alfabeto ha più caratteri.
Usando dei simboli al posto dei numeri il metodo diventa un semplice sistema stenografico.

      +---+---+---+---+---+
      | 1 | 2 | 3 | 4 | 5 |
  +---+---+---+---+---+---+
  | 1 | a | b | c | d | e |
  +---+---+---+---+---+---+
  | 2 | f | g | h |ij | k |
  +---+---+---+---+---+---+
  | 3 | l | m | n | o | p |
  +---+---+---+---+---+---+
  | 4 | q | r | s | t | u |
  +---+---+---+---+---+---+
  | 5 | v | w | x | y | z |
  +---+---+---+---+---+---+

Nota: l'implementazione non tratta i caratteri non codificati.

Funzione di cifratura
---------------------
Creiamo una lista di associazione:

(setq table '("a" "b" "c" "d" "e" "f" "g" "h" "ij" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
(setq num '())
(for (r 0 4) (for (c 0 4) (push (string (+ r 1) (+ c 1)) num -1)))
(setq alst (map list table num))
;-> (("a" "11") ("b" "12") ("c" "13") ("d" "14") ("e" "15") ("f" "21")
;->  ("g" "22") ("h" "23") ("ij" "24") ("k" "25") ("l" "31") ("m" "32")
;->  ("n" "33") ("o" "34") ("p" "35") ("q" "41") ("r" "42") ("s" "43")
;->  ("t" "44") ("u" "45") ("v" "51") ("w" "52") ("x" "53") ("y" "54")
;->  ("z" "55"))

(setq crypt '(("a" "11") ("b" "12") ("c" "13") ("d" "14") ("e" "15")
              ("f" "21") ("g" "22") ("h" "23") ("i" "24") ("j" "24")
              ("k" "25") ("l" "31") ("m" "32") ("n" "33") ("o" "34")
              ("p" "35") ("q" "41") ("r" "42") ("s" "43") ("t" "44")
              ("u" "45") ("v" "51") ("w" "52") ("x" "53") ("y" "54")
              ("z" "55") (" " "00")))

(define (polibio msg alst)
  (let (out "")
    (setq out "")
    (dolist (ch (explode msg))
      (extend out (lookup ch alst))
    )
    out))

(polibio "messaggio da cifrare" crypt)
;-> "3215434311222224340014110013242142114215"

Funzione di decifratura
-----------------------
Creiamo una lista di associazione:

(setq decrypt (map (fn(x) (list (x 1) (x 0))) crypt))

(setq decrypt '(("11" "a") ("12" "b") ("13" "c") ("14" "d") ("15" "e") 
                ("21" "f") ("22" "g") ("23" "h") ("24" "i") ("24" "j")
                ("25" "k") ("31" "l") ("32" "m") ("33" "n") ("34" "o")
                ("35" "p") ("41" "q") ("42" "r") ("43" "s") ("44" "t")
                ("45" "u") ("51" "v") ("52" "w") ("53" "x") ("54" "y")
                ("55" "z") ("00" " ")))

(define (anti-polibio msg alst)
  (let (out "")
    (setq out "")
    (dolist (ch (explode msg 2))
      (extend out (lookup ch alst))
    )
    out))

(anti-polibio "3215434311222224340014110013242142114215" decrypt)
;-> "messaggio da cifrare"

Nota: questo metodo di cifratura è facilmente decrittabile usando l'analisi della frequenze dei caratteri.


-----------------------------------------------
I dischi crittografici di Leon Battista Alberti
-----------------------------------------------

Leon Battista Alberti è un famoso architetto del Rinascimento italiano, ma anche matematico, linguista, filosofo, musicista e archeologo.
Per crittografare i propri messaggi inventò uno strumento semplice ed efficace che consiste in due dischi concentrici contenenti i caratteri dell'alfabeto scritti in modo diverso.
Simuliamo i due cerchi con due liste che rappresentano i due alfabeti.
La prima lista contiene il normale alfabeto di 26 lettere in cui le lettere j, k, x, y e w sono state sostituite rispettivamente con i numeri 1, 2, 3, 4 e 5 (questo perchè Alberti scriveva in latino e non aveva bisogno delle lettere anglosassoni):

  (a b c d e f g h i 1 2 l m n o p q r s t u v 3 4 5 z)

La seconda lista è una qualunque permutazione dell'alfabeto di 26 lettere:

  (f b m k r o a v t z y c g n l x p q h j d i e u s w)

Vediamo come funziona la criptazione di un messaggio:

messaggio = "bonum3vesperum"

Si legge il carattere corrente del messaggio e trasforma questo carattere dal disco esterno al carattere del disco interno:

b --> b
o --> l
n --> n
u --> d
m --> g
3 --> e

Quando incontriamo un carattere numerico (1, 2, 3, 4 o 5) ruotiamo il disco interno in senso antiorario in modo da far combaciare la prima lettera del disco esterno con la lettera del disco interno associata al carattere numerico (in questo caso il carattere "e").
In questo modo i dischi assumono la seguente posizione:

  (a b c d e f g h i 1 2 l m n o p q r s t u v 3 4 5 z)

La seconda lista è una qualunque permutazione dell'alfabeto di 26 lettere:

  (e u s w f b m k r o a v t z y c g n l x p q h j d i)

I restanti caratteri del messaggio vengono codificati con questa nuove posizione dei dischi:
v --> q
e --> f
s --> l
p --> c
e --> f
r --> n
u --> p
m --> t

messaggio = "bonum3vesperum"
criptato  = "blndgeqflcfnpt"

Inserendo diversi caratteri numerici nel messaggio otteniamo un messaggio criptato che è impossibile da decriptare solo con l'analisi delle frequenze delle lettere.
Inoltre il metodo si presta facilmente a modifiche personali.
L'unico prerequisito è che il mittente e il ricevente si siano accordati sulla configurazione delle lettere nei due dischi.
Il meccanismo di decriptazione è analogo a quello della criptazione.

Vediamo le funzioni "crypta" e "decrypta" (l'implementazione non tratta i caratteri non codificati):

(define (crypta msg)
  (local (esterno interno crt rotazione)
    ; disco esterno (caratteri del messaggio)
    (setq esterno '("a" "b" "c" "d" "e" "f" "g" "h" "i" "1" "2" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "3" "4" "5" "z"))
    ; disco interno (caratteri di criptazione)
    (setq interno '("f" "b" "m" "k" "r" "o" "a" "v" "t" "z" "y" "c" "g" "n" "l" "x" "p" "q" "h" "j" "d" "i" "e" "u" "s" "w"))
    ;(setq interno '("j" "o" "p" "q" "r" "i" "t" "c" "b" "a" "g" "w" "x" "k" "e" "y" "m" "z" "f" "l" "u" "d" "n" "s" "h" "v"))
    ; lunghezza del messaggio
    (setq len (length msg))
    ; messaggio cryptato
    (setq crt (dup " " len))
    (dolist (ch (explode msg))
      ; trasforma il carattere corrente del messaggio nel carattere criptato
      ; usando la corrispondenza tra i due dischi (esterno --> interno)
      (setq (crt $idx) (interno (find ch esterno)))
      ; se il carattere del messaggio è un carattere speciale (1 2 3 4 5)...
      (if (find ch '("1" "2" "3" "4" "5"))
          ; allora ruotiamo il disco interno fino a far combaciare
          ; la prima lettera del disco esterno
          ; con la lettera del disco interno che corrisponde
          ; al valore speciale ch
          (begin
            (setq rotazione (- (find ch esterno)))
            (rotate interno rotazione)
          )
      )
    )
    crt))

(crypta "bonum3vesperum")
;-> "blndgeqflcfnpt"

(crypta  "leon1battista2alberti")
;-> "crlnzyzmmqbmzjjrduygb"

(define (decrypta msg)
  (local (esterno interno crt rotazione)
    ; disco esterno (caratteri del messaggio criptato)
    (setq esterno '("a" "b" "c" "d" "e" "f" "g" "h" "i" "1" "2" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "3" "4" "5" "z"))
    ; disco interno (caratteri di decriptazione)
    (setq interno '("f" "b" "m" "k" "r" "o" "a" "v" "t" "z" "y" "c" "g" "n" "l" "x" "p" "q" "h" "j" "d" "i" "e" "u" "s" "w"))
    ; lunghezza del messaggio
    (setq len (length msg))
    ; messaggio decriptato
    (setq crt (dup " " len))
    (dolist (ch (explode msg))
      ; trasforma il carattere corrente del messaggio criptato nel carattere
      ; decriptato usando la corrispondenza tra i due dischi
      ; (esterno --> interno)
      (setq (crt $idx) (esterno (find ch interno)))
      ; se il carattere decriptato è un carattere speciale (1 2 3 4 5)...
      (if (find (crt $idx) '("1" "2" "3" "4" "5"))
          ; allora ruotiamo il disco interno fino a far combaciare
          ; la prima lettera del disco esterno
          ; con la lettera del disco interno che corrisponde
          ; al valore speciale ch
          (begin
            (setq rotazione (- (find ch interno)))
            (rotate interno rotazione)
          )
      )
    )
    crt))

(decrypta "blndgeqflcfnpt")
;-> "bonum3vesperum"

(decrypta "crlnzyzmmqbmzjjrduygb")
;-> "leon1battista2alberti"

(decrypta (crypta "leonardo1rinascimento2italiano"))
;-> "leonardo1rinascimento2italiano"


-------------------------------------------------
Cifrario di Vernam e algoritmo One Time Pad (OTP)
-------------------------------------------------

Il cifrario di Vernam è un metodo di crittografia per sostituzione che permette di convertire un testo in chiaro in un testo cifrato.
Prima di tutto assegniamo un numero ad ogni carattere dell'alfabeto, come (a = 0, b = 1, c = 2, … z = 25).
Nell'algoritmo di cifratura di Vernam, prendiamo una chiave per crittografare il testo in chiaro la cui lunghezza dovrebbe essere uguale alla lunghezza del testo in chiaro.

L'algoritmo di crittografia opera nel modo seguente:
  1) Assegnare un numero ad ogni carattere del testo in chiaro e alla chiave secondo l'ordine alfabetico.
  2) Applicare il bitwise XOR ad ogni coppia due numeri (numero del carattere del testo normale e relativo numero del carattere della chiave).
  3) Quando il numero risultante è maggiore o uguale a 26, allora sottrarre 26 dal numero.

L'algoritmo One Time Pad (OTP) è un miglioramento del cifrario di Vernam, proposto da Joseph Mauborgne.
È l'unico algoritmo disponibile infrangibile (completamente sicuro).

I due requisiti per applicare l'algoritmo OTP sono:

  a) La chiave deve essere lunga quanto il messaggio e deve essere generata in modo casuale
  b) La chiave deve essere utilizzata per crittografare e decrittografare un singolo messaggio, quindi viene scartata.

Quindi la crittografia di ogni nuovo messaggio richiede una nuova chiave.
Il testo cifrato generato dal One-Time pad è completamente casuale, quindi non ha alcuna relazione statistica con il testo in chiaro.

Sicurezza del One-Time Pad
Se in qualche modo il crittoanalista trova queste due chiavi utilizzando le quali vengono prodotti due testi in chiaro, ma se la chiave è stata prodotta in modo casuale, il crittoanalista non può trovare quale chiave è più probabile dell'altra. Infatti, per qualsiasi testo in chiaro della dimensione del testo cifrato, esiste una chiave che produce quel testo in chiaro.

Quindi, se un crittoanalista tenta l'attacco di forza bruta (prova a utilizzare tutte le chiavi possibili), si ritroverebbe con molti testi in chiaro legittimi, senza modo di sapere quale testo in chiaro sia legittimo. Pertanto, il codice è infrangibile.

La sicurezza di questo metodo dipende interamente dalla casualità della chiave. Se i caratteri della chiave sono totalmente casuali, allora  non ci sono metodi o algoritmi per decriptare il testo cifrato.
Infatti, per qualsiasi testo in chiaro della dimensione del testo cifrato, esiste una chiave che produce quel testo in chiaro. Quindi, se si tenta un attacco brute-force (cioè provare a utilizzare tutte le chiavi possibili), ci ritroviamo con molti testi in chiaro legittimi, senza modo di sapere quale testo in chiaro sia quello corretto.

Vantaggi
One-Time Pad è l'unico algoritmo veramente inattaccabile (viene usato in ambito militare).

Svantaggi
C'è il problema pratico di creare grandi quantità di chiavi casuali. Per ogni messaggio da inviare, sia il mittente che il destinatario necessitano di una chiave di uguale lunghezza. Pertanto, esiste un problema nella distribuzione delle chiavi.

Associazione lettere-numeri:

(for (i 65 90) (print (char i) { }))
;-> A B C D E F G H I J K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z
> (for (i 0 26) (print i { }))
;-> 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25

Funzione di criptazione:

(define (otp-crypt text key)
  (local (len-key crypt ordA val)
    (setq len-key (length key))
    (setq text (upper-case text))
    (setq key (upper-case key))
    (cond
      ; text and key have different length --> exit ""
      ((!= len-key (length text)) "")
      ; text and/or key equal to empty string --> exit ""
      ((zero? len-key) "")
      (true ; crypt text with key
        (setq crypt "")
        (setq ordA (char "A"))
        (for (i 0 (- len-key 1))
          ; adding char of text and key
          (setq val (+ (char (text i)) (- ordA) (char (key i)) (- ordA)))
          ; correcting value
          (if (> val 25) (-- val 26))
          ; create crypted char
          (extend crypt (char (+ val ordA)))
        )
        crypt))))

(otp-crypt "HELLO" "MONEY")
;-> "TSYPM"

Funzione di decriptazione:

(define (otp-decrypt text key)
  (local (len-key crypt ordA val)
    (setq len-key (length key))
    (setq text (upper-case text))
    (setq key (upper-case key))
    (cond
      ; text and key have different length --> exit ""
      ((!= len-key (length text)) "")
      ; text and/or key equal to empty string --> exit ""
      ((zero? len-key) "")
      (true ; crypt text with key
        (setq crypt "")
        (setq ordA (char "A"))
        (for (i 0 (- len-key 1))
          ; adding char of text and key
          (setq val (- (char (text i)) ordA (- (char (key i)) ordA)))
          ; correcting value
          (if (< val 0) (++ val 26))
          ; create crypted char
          (extend crypt (char (+ val ordA)))
        )
        crypt))))

(otp-decrypt "TSYPM" "MONEY")
;-> "HELLO"

newLISP ha la funzione integrata "encrypt" per criptare con l'algoritmo OTP.

********************
>>>funzione ENCRYPT
********************
sintassi: (encrypt str-source str-pad)

Esegue una crittografia OTP (One Time Pad) di str-source utilizzando il pad di crittografia in str-pad. Più lungo è str-pad e più casuali sono i byte, più sicura è la crittografia. Se il pad è lungo quanto il testo di origine, è completamente casuale e viene utilizzato solo una volta, allora la crittografia one-time-pad è virtualmente impossibile da decifrare, poiché la crittografia sembra contenere solo dati casuali. Per recuperare l'originale, la stessa funzione e pad vengono applicati nuovamente al testo crittografato:

(set 'secret
  (encrypt "A secret message" "my secret key"))
;-> ",YS\022\006\017\023\017TM\014\022\n\012\030E"

(encrypt secret "my secret key")
;->  "A secret message"

Il secondo esempio cripta un file intero:

(write-file "myfile.enc"
  (encrypt (read-file "myfile") "29kH67*"))

Nel nostro esempio:

(encrypt "HELLO" "MONEY")
;-> "\005\n\002\t\022"
(encrypt (encrypt "HELLO" "MONEY") "MONEY")
;-> "HELLO"

In sostanza "encrypt" esegue la seguente operazione di XOR:

(char (^ (char "H") (char "M")))
;-> "\005"
(char (^ (char "E") (char "O")))
;-> "\n"
(char (^ (char "L") (char "N")))
;-> "\002"
(char (^ (char "L") (char "E")))
;-> "\t"
(char (^ (char "O") (char "Y")))
;-> "\022"

Oppure, in maniera analoga:

(map (fn(x y) (char (^ (char x) (char y)))) (explode "HELLO") (explode "MONEY")))
;-> ("\005" "\n" "\002" "\t" "\022")
(join (map (fn(x y) (char (^ (char x) (char y)))) (explode "HELLO") (explode "MONEY")))
;-> "\005\n\002\t\022"
(join (map (fn(x y) (char (^ (char x) (char y)))) (explode "\005\n\002\t\022") (explode "MONEY")))
;-> "HELLO"


---------------
La tabula recta
---------------

La tabula recta, è una matrice quadrata di righe dell'alfabeto.
Le righe vengono costruite sfalsandole di una lettera (verso destra o verso sinistra).
Fu creata nel 1508 da Johannes Trithemius che la utilizzò per definire un cifrario polialfabetico.

(setq tabula '(
 (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
 (B C D E F G H I J K L M N O P Q R S T U V W X Y Z A)
 (C D E F G H I J K L M N O P Q R S T U V W X Y Z A B)
 (D E F G H I J K L M N O P Q R S T U V W X Y Z A B C)
 (E F G H I J K L M N O P Q R S T U V W X Y Z A B C D)
 (F G H I J K L M N O P Q R S T U V W X Y Z A B C D E)
 (G H I J K L M N O P Q R S T U V W X Y Z A B C D E F)
 (H I J K L M N O P Q R S T U V W X Y Z A B C D E F G)
 (I J K L M N O P Q R S T U V W X Y Z A B C D E F G H)
 (J K L M N O P Q R S T U V W X Y Z A B C D E F G H I)
 (K L M N O P Q R S T U V W X Y Z A B C D E F G H I J)
 (L M N O P Q R S T U V W X Y Z A B C D E F G H I J K)
 (M N O P Q R S T U V W X Y Z A B C D E F G H I J K L)
 (N O P Q R S T U V W X Y Z A B C D E F G H I J K L M)
 (O P Q R S T U V W X Y Z A B C D E F G H I J K L M N)
 (P Q R S T U V W X Y Z A B C D E F G H I J K L M N O)
 (Q R S T U V W X Y Z A B C D E F G H I J K L M N O P)
 (R S T U V W X Y Z A B C D E F G H I J K L M N O P S)
 (S T U V W X Y Z A B C D E F G H I J K L M N O P Q R)
 (T U V W X Y Z A B C D E F G H I J K L M N O P Q R S)
 (U V W X Y Z A B C D E F G H I J K L M N O P Q R S T)
 (V W X Y Z A B C D E F G H I J K L M N O P Q R S T U)
 (W X Y Z A B C D E F G H I J K L M N O P Q R S T U V)
 (X Y Z A B C D E F G H I J K L M N O P Q R S T U V W)
 (Y Z A B C D E F G H I J K L M N O P Q R S T U V W X)
 (Z A B C D E F G H I J K L M N O P Q R S T U V W X Y)))
 
Algoritmo di criptazione:
Per ogni lettera del testo da criptare, si localizza la riga con la lettera del testo e la colonna con la corrispondente lettera della chiave. 
La lettera posizionata in quella linea e quella colonna è la lettera cifrata.

Ogni posizione della tavola fornisce la somma modulo 26 dell'intero a inizio riga e dell'intero a inizio colonna.

Funzione di criptazione:

(define (recta-crypt text key)
  (local (len-key crypt ordA row col)
    (setq len-key (length key))
    (setq text (upper-case text))
    (setq key (upper-case key))
    (cond
      ; text and key have different length --> exit ""
      ((!= len-key (length text)) "")
      ; text and/or key equal to empty string --> exit ""
      ((zero? len-key) "")
      (true ; crypt text with key
        (setq crypt "")
        (setq ordA (char "A"))
        (for (i 0 (- len-key 1))
          (setq row (% (- (char (text i)) ordA) 26))
          (setq col (% (- (char (key i)) ordA) 26))
          ;(println row { } col { } (tabula row col))
          (extend crypt (string (tabula row col)))
        )
        crypt))))

(recta-crypt "pippos" "chiave")
;-> "RPXPJW"

Funzione di decriptazione:

riga = 0
colonna = (% (- (char (text i)) (char (key i))) 26)

(define (recta-decrypt text key)
  (local (len-key crypt ordA row col)
    (setq len-key (length key))
    (setq text (upper-case text))
    (setq key (upper-case key))
    (cond
      ; text and key have different length --> exit ""
      ((!= len-key (length text)) "")
      ; text and/or key equal to empty string --> exit ""
      ((zero? len-key) "")
      (true ; crypt text with key
        (setq crypt "")
        (setq ordA (char "A"))
        (for (i 0 (- len-key 1))
          (setq row 0)
          (setq col (% (- (char (text i)) (char (key i))) 26))
          ;(println row { } col { } (tabula row col))
          (extend crypt (string (tabula row col)))
        )
        crypt))))

(recta-decrypt "RPXPJW" "CHIAVE")
;-> "PIPPOS"

(recta-crypt "OUAGADOUGOU" "kdjshetfduf")
;-> "YXJYHHHZJIZ"
(recta-decrypt "YXJYHHHZJIZ" "kdjshetfduf")
;-> "OUAGADOUGOU"


--------------------------
A trivial P2P file sharing
--------------------------

by frontera000

; a trivial P2P file sharing program written in newLISP for demo purpose
;
; based on ideas from http://www.freedom-to-tinker.com/tinyp2p.html
; and http://ansuz.sooke.bc.ca/software/molester/ and
; https://ansuz.sooke.bc.ca/software/molester/2005010301.php
;
; command reference
; i/ advertise presence of your node to the peer
; g<filename>/ requests a file
; f<message> forward to peers
; h/ gets list of all peers
;
; used internally
; e<filename>/ expect a file
; x sent after receiving a file to make sure
;
; the program below is a toy, not a serious p2p program.
;
; differences from original mole-ster:
; use of 'x' -- to allow data receipt on receiving side when file is sent
; data is read in 8k chunks at a time. this is to avoid having to read
; the entire file into a buffer before writing. it allows larger files to be
; transferred.
;
; more more information refer to the original mole-ster web sites.
;

(context 'P2P)

(constant 'SIGINT 2)
(define (interrupted)
(println "interruted by user!")
(exit))

(signal SIGINT interrupted)

(set 'my-address "")
(set 'my-password "")
(set 'peers '())

(define (get-addr addr-and-port) (regex "(.*):(.*)" addr-and-port) $1)
(define (get-port addr-and-port) (regex "(.*):(.*)" addr-and-port) (integer $2))

(define (op-send dest-addr source-addr filename data)
(if (set 'socket (net-connect (get-addr dest-addr) (get-port dest-addr)))
(begin
(net-send socket (format "%s %s %s/" my-password source-addr filename))
(net-send socket data )
(if (!= data "")
(net-receive socket 'buf 1))
(close socket))))

(define (P2P:P2P my-password peer-address my-address commands )
(set 'peers (append peers (list peer-address)))
(dolist (cmd commands) (op-send peer-address my-address cmd ""))
(set 'socket (net-listen (get-port my-address)))
(while true
(while (and (not (net-error)) (not (net-select socket "read" 1000)))
(if (net-error) (print (net-error))))
(set 'peer-socket (net-accept socket)) (net-receive peer-socket 'buf 1024 "/")
(regex "^([a-zA-Z0-9]*) ([0-9:.]*) ([e-i])([^/]*)(/)" buf)
(set 'peer-password $1)
(set 'peer-address $2)
(set 'peer-command $3)
(set 'requested-filename $4)
(set 'data $6)
(if (= peer-password my-password)
(case peer-command
("e" (begin
(set 'finished false)
(while (not finished)
(while (and (not (net-error)) (not (net-select peer-socket "read" 1000)))
(if (net-error) (print (net-error))))
(if (!= nil (net-receive peer-socket 'input-data 8192))
(begin
(append-file requested-filename input-data)
(set 'finished true)))
(net-send socket "x")))
("f" (dolist (peer peers) (op-send peer my-address requested-filename data)))
("g" (op-send peer-address my-address (append "e" requested-filename)
(read-file requested-filename)))
("h" (dolist (peer peers) (op-send peer-address peer "i" "")))
("i" (append peers peer-address))))
(close peer-socket)))

(context 'MAIN)

(P2P:P2P (main-args 2) (main-args 3) (main-args 4) (slice (main-args) 5 -1))

I put some information in my blog http://sparebandwidth.blogspot.com


-------------------------------------
Prodotto minimo e massimo con 9 cifre
-------------------------------------

Usare tutte le cifre da 1 a 9 una volta ciascuna per trovare i tre numeri di tre cifre che producono il prodotto più alto.
Usare tutte le cifre da 1 a 9 una volta ciascuna per trovare i tre numeri di tre cifre che producono il prodotto più basso.

Prodotto più alto
-----------------
Usiamo le permutazioni.

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

(define (prodmax1)
  (local (test nums nums-max val val-max)
    (setq val-max 0)
    (setq test (perm '("1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (dolist (el test)
      (setq values (map join (explode el 3)))
      (setq val (eval-string (append "(* "  (values 0) " " (values 1) " " (values 2) ")")))
      (if (> val val-max)
          (set 'val-max val 'nums-max values)
      )
    )
    (list nums-max val-max)))

(prodmax1)
;-> (("852" "941" "763") 611721516)

Per formare il prodotto più grande, i numeri più grandi devono essere tutti nella posizione delle centinaia. 
Cioè, i numeri devono essere (9xx, 8xx, 7xx).

(define (prodmax2)
  (local (test nums nums-max val val-max)
    (setq val-max 0)
    (setq test (perm '("1" "2" "3" "4" "5" "6")))
    (dolist (el test)
      (setq values (map join (explode el 2)))
      (setf (values 0) (append "9" (values 0)))
      (setf (values 1) (append "8" (values 1)))
      (setf (values 2) (append "7" (values 2)))
      (setq val (eval-string (append "(* "  (values 0) " " (values 1) " " (values 2) ")")))
      (if (> val val-max)
          (set 'val-max val 'nums-max values)
      )
    )
    (list nums-max val-max)))

(prodmax2)
;-> (("941" "852" "763") 611721516)

È chiaro che i numeri più piccoli devono essere nella posizione delle unità.
Il 3 può essere posizionato nei modi seguenti: (9xx, 8xx, 7x3) oppure (9xx, 8x3, 7xx) oppure (9x3, 8xx, 7xx).
Poiché il 9 e l'8 causano il maggior cambiamento nel numero per il quale vengono moltiplicati, il 3 dovrebbe essere posizionato con il 7.
Con la stessa logica, il 2 dovrebbe essere posizionato in modo tale da avere l'effetto maggiore successivo, cioè con l'8.
Questo lascia l'1 con il 9.

(define (prodmax3)
  (local (test nums nums-max val val-max)
    (setq val-max 0)
    (setq test (perm '("4" "5" "6")))
    (dolist (el test)
      (setq values el)
      (setf (values 0) (append "9" (values 0) "1"))
      (setf (values 1) (append "8" (values 1) "2"))
      (setf (values 2) (append "7" (values 2) "3"))
      (setq val (eval-string (append "(* "  (values 0) " " (values 1) " " (values 2) ")")))
      (if (> val val-max)
          (set 'val-max val 'nums-max values)
      )
    )
    (list nums-max val-max)))

(prodmax3)
;-> (("941" "852" "763") 611721516)

Usando la stessa logica con i numeri rimanenti (4, 5 e 6), possiamo notare che il 6 ha l'effetto maggiore se moltiplicato per il 9 e l'8, e quindi deve far parte del numero che non ha quei due, che è il numero con il 7 nella posizione delle centinaia. Posizioniamo il 4 e il 5 nello stesso modo e abbiamo tropvato la soluzione (senza scrivere codice): i numeri con il prodotto più alto sono 941, 852 e 763.

Prodotto più basso
------------------
Per trovare i numeri che hanno il prodotto più piccolo, invertiamo la logica precedente.
I numeri più piccoli devono essere nella posizione delle centinaia e i numeri più grandi devono essere nella posizione delle unità. Inoltre, il 9 deve essere posizionato dove ha il minimo effetto, cioè dove verrà moltiplicato per 1 e 2. con questo ragionamento i numeri sono 147, 258 e 369.
Facciamo una verifica:

(define (prodmin1)
  (local (test nums nums-min val val-min)
    (setq val-min 999999999)
    (setq test (perm '("1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (dolist (el test)
      (setq values (map join (explode el 3)))
      (setq val (eval-string (append "(* "  (values 0) " " (values 1) " " (values 2) ")")))
      (if (< val val-min)
          (set 'val-min val 'nums-min values)
      )
    )
    (list nums-min val-min)))

(prodmin1)
;-> (("258" "147" "369") 13994694)

=============================================================================

