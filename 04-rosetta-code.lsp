==============

 ROSETTA CODE

==============

https://rosettacode.org/wiki/Category:Programming_Tasks

Rosetta Code è un sito di programmazione "chrestomathy" (proviene dal greco χρηστομάθεια e significa "desiderio di imparare"). L'idea è di risolvere/presentare la soluzione per lo stesso problema in quanti più linguaggi possibili, per dimostrare le analogie e le differenze dei linguaggi, e per aiutare chi conosce un linguaggio ad apprenderne un altro.
Il sito contiene moltissimi problemi risolti in più di 800 linguaggi (non tutti problemi sono stati risolti con tutti i linguaggi).
Di seguito vengono presentanti alcuni di questi problemi e la loro soluzione.
Per avere una migliore comprensione si consiglia di provare a risolverli per conto proprio prima di leggere la soluzione.

Nota: in questo capitolo vengono risolti 100 problemi presenti sul sito Rosetta Code (in ordine sparso). Molti altri problemi elencati nel sito e non qui presenti sono risolti in altri capitoli di questo documento.

--------
FIZZBUZZ
--------

Scrivere un programma che stampa i numeri interi da 1 a 100 (inclusi).
Ma:
- per multipli di tre, stampa Fizz (invece del numero)
- per multipli di cinque, stampa Buzz (invece del numero)
- per multipli di entrambi tre e cinque, stampa FizzBuzz (invece del numero)

(define (fizzbuzz)
  (for (i 1 100)
    (cond ((= 0 (% i 15)) (println "FizzBuzz"))
          ((= 0 (% i 3))  (println "Fizz"))
          ((= 0 (% i 5))  (println "Buzz"))
          (true           (println i))
    )
  )
)

(fizzbuzz)

Vediamo ora una generalizzazione del problema. Occorre scrivere una funzione che accetta una lista di fattori e una lista di parole associate. Un ulteriore parametro permette di specificare il numero massimo da stampare.
Come esempio possiamo usiare la seguente lista associativa:

(3 "Fizz")
(5 "Buzz")
(7 "Baxx")

Nel caso in cui un numero sia un multiplo di almeno due fattori, stampare ciascuna delle parole associate a tali fattori nell'ordine dal fattore minore a quello maggiore. Ad esempio, il numero 15 è un multiplo di entrambi 3 e 5, allora stampa FizzBuzz. Se il numero massimo vale 105, occorre stampare FizzBuzzBaxx perché è un multiplo di 3, 5 e 7.

(setq lst '((3 "Fizz") (5 "Buzz") (7 "Baxx")))

(define (fizzbuzzG n lst)
  (local (out)
    (for (i 1 n)
      (setq out "")
      (dolist (el lst)
        (if (= 0 (% i (first el))) (setq out (append out (last el))))
      )
      (if (= out "") (setq out (string i)))
      (print out {, })
    )
  )
)

(fizzbuzzG 20 lst)
;-> 1, 2, Fizz, 4, Buzz, Fizz, Baxx, 8, Fizz, Buzz, 11,
;-> Fizz, 13, Baxx, FizzBuzz, 16, 17, Fizz, 19, Buzz

(setq lst '((2 "Fizz") (3 "Buzz") (5 "Baxx")))

(fizzbuzzG 30 lst)
;-> 1, Fizz, Buzz, Fizz, Baxx, FizzBuzz, 7, Fizz, Buzz, FizzBaxx, 11,
;-> FizzBuzz, 13, Fizz, BuzzBaxx, Fizz, 17, FizzBuzz, 19, FizzBaxx, Buzz,
;-> Fizz, 23, FizzBuzz, Baxx, Fizz, Buzz, Fizz, 29, FizzBuzzBaxx


------------
NUMERI PRIMI
------------

In matematica, un numero primo (in breve anche primo) è un numero intero positivo che ha esattamente due divisori distinti. In modo equivalente si può definire come un numero naturale maggiore di 1 che è divisibile solamente per 1 e per sé stesso. Al contrario, un numero maggiore di 1 che abbia più di due divisori è detto composto.
L'algoritmo di base per calcolare i numeri primi è il cosiddetto Crivello di Eratostene.
Di seguito è riportato l'algoritmo che trova tutti i numeri primi minori o uguali a un intero dato n con il metodo di Eratostene:

1) Creare una lista di numeri interi consecutivi da 2 a n: (2, 3, 4, ..., n).

2) Inizialmente, sia p uguale a 2, il primo numero primo.

3) A partire da p^2, contare ad incrementi di p e marca nella lista tutti quei numeri che sono maggiori o uguali a p^2 stesso. Questi numeri saranno p(p + 1), p(p + 2), p(p + 3), ecc.

4) Trova nella lista il primo numero maggiore di p che non è marcato. Se non esiste tale numero, allora fermati -> algoritmo terminato). Altrimenti, lascia p uguale a questo numero (che è il prossimo primo), e ripeti dal punto 3.

Quando l'algoritmo termina, tutti i numeri nell'elenco che non sono contrassegnati sono primi.

(setq n 1000)
;definiamo un vettore di n+1 elementi tutti con valore true
;al termine dell'algoritmo i valori del vettore "primi" che hanno valore true sono numeri primi ()
(setq primi (array (add 1 n) '(true)))
(setq p 2)

(while (<= (* p p) n)
  (if (= (primi p) true)) ; se primi[p} non è cambiato, allora è un numero primo)
  ; Poniamo a nil tutti i multipli di p che sono maggiori o uguali al quadrato di p
  ; I numeri che sono multipli di p e sono minori di p^2 sono già stati marcati (posti a nil).
  (for (i (* p p) n p) (setq (primi i) nil))
  (++ p)
)

; stampiamo solo gli indici del vettore primi che hanno valore true (cioè sono numeri primi).
(for (p 2 n 1)
   (if (= (primi p) true)
      (print p { })
   )
)

Adesso possiamo scrivere la funzione completa:

(define (Eratostene n)
  (local (primi p)
    (setq primi (array (add 1 n) '(true)))
    (setq p 2)
    (while (<= (* p p) n)
      (if (= (primi p) true))
      (for (i (* p p) n p) (setq (primi i) nil))
      (++ p)
    )
    (for (p 2 n 1)
      (if (= (primi p) true)
          (print p { })
      )
    )
  )
)

(Eratostene 1000)
;-> 2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113
;-> 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223 227 229 233 239 241
;-> 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337 347 349 353 359 367 373 379 383
;-> 389 397 401 409 419 421 431 433 439 443 449 457 461 463 467 479 487 491 499 503 509 521 523
;-> 541 547 557 563 569 571 577 587 593 599 601 607 613 617 619 631 641 643 647 653 659 661 673
;-> 677 683 691 701 709 719 727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829
;-> 839 853 857 859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997

Se vogliamo sapere soltanto se un certo numero è primo possiamo utilizzare altri metodi.
Il test di primalità più semplice è la "prova della divisione": dato un numero n, controlla se ogni numero intero m, che va da 2 a sqrt(n), divide precisamente n (la divisione non lascia resto). Se n è divisibile per uno qualsiasi dei valori di m allora n è composto, altrimenti è primo.

Ad esempio, per testare la primalità di 100 con questo metodo, considera tutti i divisori interi di 100:

2, 4, 5, 10, 20, 25, 50

Il fattore più grande è 100/2 = 50. Questo è vero per tutti n: tutti i divisori sono inferiori o uguali a n/2. Ispezionando i divisori, si determina che alcuni di essi sono ridondanti. L'elenco dei divisori può essere scritto come:

100 = 2 × 50 = 4 × 25 = 5 × 20 = 10 × 10 = 20 × 5 = 25 × 4 = 50 × 2

che dimostra la ridondanza. Una volta testato il divisore 10, che è sqrt(100), il primo divisore è semplicemente il dividendo di un precedente divisore. Pertanto, è possibile eliminare i divisori di prova superiori a sqrt(n). Tutti i numeri pari maggiori di 2 possono anche essere eliminati, poiché se un numero pari può dividere n, anche 2 può dividere quel numero.

Diamo un'occhiata ad un altro esempio e usiamo la prova della divisione per testare la primalità di 17. Poiché ora sappiamo che non abbiamo bisogno di testare usando divisori superiori a sqrt(n), abbiamo solo bisogno di usare divisori interi minori o uguali a sqrt(17) circa uaguale 4.12. Quindi sarebbero 2, 3 e 4. Come detto sopra, possiamo saltare 4 perché se 4 divide precisamente 17, 2 deve anche dividere precisamente 17, che avremmo già controllato prima. Questo ci lascia solo con 2 e 3. Dopo la divisione, troviamo che 17 non è divisibile per 2 o 3, e possiamo confermare che 17 deve essere primo.

L'algoritmo può essere ulteriormente migliorato osservando che tutti i numeri primi sono della forma 6k ± 1, con l'eccezione di 2 e 3. Ciò è dovuto al fatto che tutti gli interi possono essere espressi come (6k + i) per alcuni interi k e per i = - 1, 0, 1, 2, 3 o 4, poi 2 divide (6k + 0), (6k + 2), (6k + 4) e 3 divide (6k + 3). Quindi, un metodo più efficiente è quello di verificare se n è divisibile per 2 o 3, quindi controllare tutti i numeri della forma (6k ± 1 <= sqrt(n)). Questo è 3 volte più veloce di testare tutti i valori di m.
Lo pseudocodice della funzione è il seguente:

 function is_prime(n)
     if n ≤ 3
        return n > 1
     else if n mod 2 = 0 or n mod 3 = 0
        return false
     let i ← 5
     while i * i ≤ n
        if n mod i = 0 or n mod (i + 2) = 0
            return false
        i ← i + 6
     return true

Adesso scriviamo la nostra funzione:

(define (primo? n)
  (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
  (cond ((<= n 3) (setq out true))
        ((or (= (% n 2) 0) (= (% n 3) 0)) (setq out nil))
        (true (setq i 5)
              (while (<= (* i i) n)
                (if (or (= (% n i) 0) (= (% n (+ i 2)) 0)) (setq out nil))
                (setq i (+ i 6))
              )
        )
  )
  out
)

(primo? 100)
;-> nil

(primo? 3347833720307)
;-> nil

(primo? 100000017239)
;-> true

Calcoliamo il tempo di esecuzione:

(time (primo? 3347833720307) 100)
;-> 9468.2
(time (primo? 100000017239) 100)
;-> 1640.4

newLISP mette a disposizione la funzione "factor" per calcolare i fattori primi di un numero.
Ad esempio:

(factor 67456)
;-> (2 2 2 2 2 2 2 17 31)

"factor" restituisce una lista con i numeri della scomposizione in fattori del numero fornito.
Possiamo scrivere un'altra funzione per verificare se un dato numero è primo:
se la lunghezza della lista restituita dalla funzione "factor" vale 1, allora il numero è primo.

(define (primo-a? n)
  (= 1 (length (factor n))))

(primo-a? 3347833720307)
;-> nil
(primo-a? 100000017239)
;-> true

Poichè "factor" è una funzione predefinita (compilata) è molto veloce. Se proviamo a migliorare la nostra funzione (ad esempio eliminando i numeri pari dalla fattorizzazione) otteniamo miseri risultati:

(define (primo-b? n)
  (if (even? n) nil
      (= 1 (length (factor n)))))

(primo-b? 3347833720307)
;-> nil
(primo-b? 100000017239)
;-> true

Adesso vediamo la velocità di esecuzione delle due funzioni primo-a e primo-b:

(time (primo-a? 3347833720307) 100)
;-> 203.1
(time (primo-a? 100000017239) 100)
;-> 156.2

(time (primo-b? 3347833720307) 100)
;-> 203.2
(time (primo-b? 100000017239) 100)
;-> 156.2

Ci sono miglioramenti sostanziali tra "primo-a?" e "primo-b?", comunque entrambe sono circa 10 volte più veloci della funzione "primo?".

Nota: le funzioni "primo-a" e "primo-b" non funzionano con i big integer perchè la funzione "factor" non funziona con i big integer. Il numero massimo possibile (int64) vale: 9223372036854775807.

Riscriviamo la nostra funzione "primo?" in modo da funzionare con i big integer:

(define (primoBig? n)
  (local (out i)
    (setq out true) ; il numero viene considerato primo fino a che non troviamo un divisore preciso
    (cond ((<= n 3L) (setq out true))
          ((or (= (% n 2L) 0L) (= (% n 3L) 0L)) (setq out nil))
          (true (setq i 5L)
                (while (<= (* i i) n)
                  (if (or (= (% n i) 0L) (= (% n (+ i 2L)) 0L)) (setq out nil))
                  (setq i (+ i 6L))
                )
          )
    )
    out
  )
)

(primoBig? 3347833720307)
;-> nil
(primoBig? 100000017239)
;-> true

La funzione è lenta con numeri grandi:

(time (primoBig? 3347833720307) 100)
;-> 17672.8

(time (primoBig? 100000017239) 100)
;-> 3066.7

E raggiunge rapidamente il limite pratico di utilizzo con i big integer:

(primoBig? 1111235916285193) ; numero con 16 cifre
;-> true

(time (primoBig? 1111235916285193)) ; numero con 16 cifre
;-> 3250.1

(primoBig? 76912895956636885) ; numero con 17 cifre
;->  nil
(time (primoBig? 76912895956636885))
;-> 27235.75

Adesso scriviamo una funzione che fattorizza un numero raggruppando i termini uguali.
Ad esempio (fattorizza 45) deve produrre ((3 2) (5 1)), cioè 45 = 3^2 * 5^1.

(define (fattorizza x)
  (local (fattori unici)
    (setq fattori (factor x))
    (setq unici (unique fattori))
    (transpose (list unici (count unici fattori)))
    ;(map list unici (count unici fattori))
  )
)

(fattorizza 45)
;-> ((3 2) (5 1))

(fattorizza 232792560)
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(time (fattorizza 232792560) 100000)
;-> 342.6

(factor 9223372036854775807)
;-> (7 7 73 127 337 92737 649657)

(fattorizza 9223372036854775807)
;-> ((7 2) (73 1) (127 1) (337 1) (92737 1) (649657 1))

Può essere utile avere due funzioni che ricostruiscono il numero originale partendo dai due tipi di fattorizzazione:

Operazione inversa di "factor":

(setq f (factor 45))
;-> (3 3 5)

(setq num-f (apply * f))
;-> 45

Operazione inversa di "fattorizza":

(setq fg (fattorizza 45))
;-> ((3 2) (5 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 45

(setq fg (fattorizza 232792560))
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

(setq num-fg (apply * (map (lambda (x) (pow (first x) (last x))) fg)))
;-> 232792560

Adesso scriviamo una funzione che converte il risultato di "fattorizza" nel risultato di "factor". Per esempio, ((2 3) (3 4)) --> (2 2 2 3 3 3 3)

(define (fattorizza-factor lst-fattori)
  (define (crea lst) (dup (first lst) (last lst)))
  (flat (map crea lst-fattori))
)

(crea '(2 3))
;-> (2 2 2)

(fattorizza-factor '((2 3) (3 4)))
;-> (2 2 2 3 3 3 3)

(fattorizza-factor (fattorizza 2301))
;-> (3 13 59)

(fattorizza-factor (fattorizza 29))
;-> (29)

Per finire scriviamo una funzione "fattori-primi" che fa lo stesso lavoro di "factor":

(define (fattori-primi numero)
  (define (fattori divisore numero)
    (if (> (* divisore divisore) numero)
        (list numero)
        (if (= (mod numero divisore) 0)
            (cons divisore (fattori divisore (/ numero divisore)))
            (fattori (+ divisore 1) numero)
        )
    )
  )
  (fattori 2L numero)
)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

(apply * (fattori-primi 3434344L))
;-> 3434344L

(factor 3434344L)
;-> (2 2 2 151 2843)

Ricordiamo che il valore massimo per i numeri int64 è 9223372036854775807.

(factor 9223372036854775807L)
;-> (7 7 73 127 337 92737 649657)

(fattori-primi 9223372036854775807L)
;-> ERR: call or result stack overflow in function > : *

Purtroppo "fattori-primi" è una funzione ricorsiva che consuma tutto lo stack di newLISP.

Proviamo allora a scrivere una versione iterativa che funziona con i big integer:

(define (fattori-primi n)
  (local (fp lim i)
    (setq fp '())
    (while (zero? (% n 2L))  ; quante volte il numero 2 divide esattamente il numero n
      (setq fp (cons 2L fp))
      (setq n (/ n 2L))
    )
    ; adesso n è un numero dispari
    (setq i 3L)
    (setq lim (sqrt n))
    (while (<= i lim)
      (while (zero? (% n i))  ; quante volte il numero "i" divide esattamente il numero n
        (setq fp (cons i fp))
        (setq n (/ n i))
      )
      (setq i (+ 2L i))
    )
    ; questa condizione verifica il caso che il numero n sia un numero primo maggiore di 2
    (if (> n 2L) (setq fp (cons n fp)))
    (reverse fp)
  )
)

(fattori-primi 256)
;-> (2L 2L 2L 2L 2L 2L 2L 2L)

(fattori-primi 3434344L)
;-> (2L 2L 2L 151L 2843L)

Questa volta la funzione "fattori-primi" produce i risultati corretti, ma è molto lenta con numeri grandi:

(time (fattori-primi 9223372036854775807L))
;-> 432092.716 ; 7 minuti e 12 secondi

(time (factor 9223372036854775807L))
;-> 1.998 ;

(fattori-primi 9223372036854775808L)
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L)

(time (fattori-primi 9223372036854775808L))
;-> 0

(factor 9223372036854775808L)
;-> ERR: number out of range in function factor

Attenzione: la funzione è molto lenta con numeri grandi.

(fattori-primi 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

(time (fattori-primi 9223372036854775809L))
;-> 551342.497 ; 9 minuti e 11 secondi

Altra funzione che controlla se un numero è primo:

(define (isPrime n)
  (local (idx step out)
    (setq out true)
    (cond ((or (= n 2) (= n 3)) true)
          ((or (< n 2) (= (% n 2) 0) (= (% n 3) 0)) nil)
          (true
            (setq idx 5 step 2)
            (while (<= (* idx idx) n)
              (if (= 0 (% n idx)) (setq out nil))
              (setq idx (+ idx step))
              (setq step (- 6 step ))
            )
            out
          )
    )
  )
)

(isPrime 100)
;-> nil

(isPrime 18376353439383)
;-> nil

(isPrime 113)
;-> true

(factor 18376353439383)
;-> (3 850261 7204201)

(for (i 2 100000) (if (and (isPrime i) (> (length (factor i)) 1)) (println "error: " i)))
;-> nil

Vediamo un post di fdb sul forum di newLISP:

Funzione (factor) che calcola i numeri primi fino a n:

(define (primes-to n , (out '(2)))
  (for (i 3 n 2)
    (unless (rest (factor i))
      (push i out -1)
    )
  )
  out
)

(length (primes-to 1000000))
;-> 78498

(time (primes-to 1000000))
;-> 640.006

Funzione (Eratostene) che calcola i numeri primi fino a n:

(define (sieve-to n)
   (setq arr (array (+ n 1)) lst '(2))
   (for (x 3 n 2)
      (when (not (arr x))
         (push x lst -1)
         (for (y (* x x) n (* 2 x) (> y n))
            (setf (arr y) true))))
   lst
)

(length (sieve-to 1000000))
;-> 78498

(time (sieve-to 1000000))
;-> 251.022

Funzione che applica una operazione ad ogni coppia di elementi di una lista:
el(1) op el(2), el(2) op el(3), el(3) op el(4), ..., el(n-1) op (el n)

(define (funlist lst func rev)
  (if rev
      (map func (chop lst) (rest lst))
      (map func (rest lst) (chop lst)))))

Differenza/distanza tra gli elementi:

(funlist '(4 7 11 16 18) -)
;-> (3 4 5 2)

Somma tra gli elementi:

(funlist '(4 7 11 16 18) +)
;-> (11 18 27 34)

Calcoliamo le distanze tra le coppie di numeri primi contigui:

(funlist (sieve-to 1000) -)
;-> (1 2 2 4 2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4 6 8 4 2 4 2 4 14 4 6 2 10 2 6 6 4 6
;->  6 2 10 2 4 2 12 12 4 2 4 6 2 10 6 6 6 2 6 4 2 10 14 4 2 4 14 6 10 2 4 6 8 6 6 4
;->  6 8 4 8 10 2 10 2 6 4 6 8 4 2 4 12 8 4 8 4 6 12 2 18 6 10 6 6 2 6 10 6 6 2 6 6 4
;->  2 12 10 2 4 6 6 2 12 4 6 8 10 8 10 8 6 6 4 8 6 4 8 4 14 10 12 2 10 2 4 2 10 14 4
;->  2 4 14 4 2 4 20 4 8 10 8 4 6 6 14 4 6 6 8 6)

Contiamo la frequenza delle distanze:

(define (freq lst)
   (let (ulist (unique (sort lst)))
      (map list ulist (count ulist lst))))

(freq (funlist (sieve-to 1000) -))
;-> ((1 1) (2 35) (4 40) (6 44) (8 15) (10 16) (12 7) (14 7) (18 1) (20 1))

Ordiniamo le frequenze:

(define (comp x y) (>= (last x) (last y)))

(sort (freq (funlist (sieve-to 1000000) -)) comp)
;-> ((6 13549) (2 8169) (4 8143) (12 8005) (10 7079) (8 5569)
;->  (18 4909) (14 4233) (16 2881) (24 2682) (20 2401) (22 2172)
;->  (30 1914) (28 1234) (26 1175) (36 767)  (34 557)  (32 550)...
;->  ...(114 1))

La distanza più frequente tra due numeri primi vale 6.


---------------
NUMERI DI SMITH
---------------

I numeri di Smith sono numeri in cui la somma delle cifre decimali che compongono il numero è uguale alla somma delle cifre decimali dei suoi fattori primi escluso 1.
Per definizione, tutti i numeri primi sono esclusi in quanto (naturalmente) soddisfano questa condizione!

Esempio utilizzando il numero 166
I fattori primi di 166 sono: 2 x 83 = 166
Somma tutte le loro cifre decimali: 2 + 8 + 3 = 13
Somma le cifre decimali di 166: 1 + 6 + 6 = 13
Allora, il numero 166 è un numero Smith.

Scrivere un programma per trovare tutti i numeri Smith inferiori a 10000.

Le seguenti istruzioni verificano se un numero x è un numero di Smith:

(setq x 1234567890)
;-> 1234567890
(setq s (string x))
;-> "1234567890"
(setq a (slice (explode s) 0))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "0")
(setq b (apply + (map int a)))
;-> 45

(setq f (factor x))
;-> (2 3 3 5 3607 3803)
(setq sf (apply string f))
;-> "233536073803"
(setq af (slice (explode sf) 0))
;-> ("2" "3" "3" "5" "3" "6" "0" "7" "3" "8" "0" "3")
(setq bf (apply + (map int af)))
;-> 43
(if (= b bf) true nil)
;-> nil

Adesso possiamo scrivere la funzione richiesta:

(define (smith? x)
  (local (s aa b f sf af bf)
    (cond
      ((bigint? x) -1) ; do not work with big integer
      ( true
          (setq s (string x))
          (setq a (slice (explode s) 0))
          (setq b (apply + (map int a)))
          (setq f (factor x))
          (if (= 1 (length f)) (setq f '(0))) ; trovato numero primo
          (setq sf (apply string f))
          (setq af (slice (explode sf) 0))
          (setq bf (apply + (map int af)))
          (= b bf)
          ;(if (= b bf) true nil)
      )
    )
  )
)

(smith? 166)
;-> true
(smith? 1234567890)
;-> nil
(smith? 123456789012938347464736374657484756578)
;-> -1

(define (smith10000)
  (let (n '())
    (for (i 1 10000)
      (if (smith? i) (setq n (append (list i) n)))
    )
    (println (reverse n))
    (println "Fino a 10000 ci sono " (length n) " numeri di Smith.")
  )
)

(smith10000)
;-> (4 22 27 58 85 94 121 166 202 265 274 319 346 355 378 382 391 438 454 483 517 526
;->  535 562 576 588 627 634 636 645 648 654 663 666 690 706 728 729 762 778 825 852
;->  861 895 913 915 922 958 985 1086 1111 1165 1219 1255 1282 1284 1376 1449 1507 1581
;->  1626 1633 1642 1678 1736 1755 1776 1795 1822 1842 1858 1872 1881 1894 1903 1908
;->  1921 1935 1952 1962 1966 2038 2067 2079 2155 2173 2182 2218 2227 2265 2286 2326
;->  2362 2366 2373 2409 2434 2461 2475 2484 2515 2556 2576 2578 2583 2605 2614 2679
;->  2688 2722 2745 2751 2785 2839 2888 2902 2911 2934 2944 2958 2964 2965 2970 2974
;->  3046 3091 3138 3168 3174 3226 3246 3258 3294 3345 3366 3390 3442 3505 3564 3595
;->  3615 3622 3649 3663 3690 3694 3802 3852 3864 3865 3930 3946 3973 4054 4126 4162
;->  4173 4185 4189 4191 4198 4209 4279 4306 4369 4414 4428 4464 4472 4557 4592 4594
;->  4702 4743 4765 4788 4794 4832 4855 4880 4918 4954 4959 4960 4974 4981 5062 5071
;->  5088 5098 5172 5242 5248 5253 5269 5298 5305 5386 5388 5397 5422 5458 5485 5526
;->  5539 5602 5638 5642 5674 5772 5818 5854 5874 5915 5926 5935 5936 5946 5998 6036
;->  6054 6084 6096 6115 6171 6178 6187 6188 6252 6259 6295 6315 6344 6385 6439 6457
;->  6502 6531 6567 6583 6585 6603 6684 6693 6702 6718 6760 6816 6835 6855 6880 6934
;->  6981 7026 7051 7062 7068 7078 7089 7119 7136 7186 7195 7227 7249 7287 7339 7402
;->  7438 7447 7465 7503 7627 7674 7683 7695 7712 7726 7762 7764 7782 7784 7809 7824
;->  7834 7915 7952 7978 8005 8014 8023 8073 8077 8095 8149 8154 8158 8185 8196 8253
;->  8257 8277 8307 8347 8372 8412 8421 8466 8518 8545 8568 8628 8653 8680 8736 8754
;->  8766 8790 8792 8851 8864 8874 8883 8901 8914 9015 9031 9036 9094 9166 9184 9193
;->  9229 9274 9276 9285 9294 9296 9301 9330 9346 9355 9382 9386 9387 9396 9414 9427
;->  9483 9522 9535 9571 9598 9633 9634 9639 9648 9657 9684 9708 9717 9735 9742 9760
;->  9778 9840 9843 9849 9861 9880 9895 9924 9942 9968 9975 9985)
;-> Fino a 10000 ci sono 376 numeri di Smith.


-----------------
NUMERI DI HAMMING
-----------------

I numeri di Hamming sono numeri della forma:

        H = 2^i × 3^j × 5^k

dove: i, j, k ≥ 0

Scrivere un programma per calcolare i numeri di hamming nel corretto ordine.

Questa funzione restituisce il più piccolo tra due numeri (anche big integer):

(define (minimo x y) (if (< x y) x y))

(define (hamming n bool)
  (local (h i j k x2 x3 x5)
    (setq h (array n '(0L))) ; utilizziamo un vettore big integer
    (setf (h 0) 1L)
    (setq i 0L)  (setq j 0L)  (setq k 0L)
    (setq x2 2L)  (setq x3 3L)  (setq x5 5L)
    (for (m 1 (-- n) 1)
      (setf (h m) (minimo x2 (minimo x3 x5)))
      ;(setf (h m) (min x2 (min x3 x5))) ; la funzione "min" non funziona con i big integer
      (if (= (h m) x2) (begin (++ i) (setq x2 (* (h i) 2L))))
      (if (= (h m) x3) (begin (++ j) (setq x3 (* (h j) 3L))))
      (if (= (h m) x5) (begin (++ k) (setq x5 (* (h k) 5L))))
    )
    (if bool h (last h)) ; se bool = true, allora resitutuisce tutti i numeri, altrimenti solo l'ultimo
  )
)

(hamming 20 true)
;-> (1L 2L 3L 4L 5L 6L 8L 9L 10L 12L 15L 16L 18L 20L 24L 25L 27L 30L 32L 36L)

(hamming 1691)
;-> 2125764000L

(hamming 1000000)
;-> 519312780448388736089589843750000000000000000000000000000000000000000000000000000000L

(time (hamming 1000000))
;-> 2130.027 (millisecondi)


-----------------
NUMERI DI CATALAN
-----------------

I numeri di Catalan formano una successione di numeri naturali utile in molti calcoli combinatori. Prendono il nome dal matematico belga Eugène Charles Catalan.
Esistono diverse definizioni equivalenti per calcolare questi numeri.
Prendiamo in considerazione una definizione ricorsiva:

C(0) = 1

         2*(2*n - 1)
C(n) = --------------- * C(n-1)
           (n + 1)

Quindi scriviamo una funzione che utilizza i big integer per il calcolo:

(define (catalan n)
  (if (< n 2) 1L
      (/ (* (- (* 4L n) 2L) (catalan (- n 1L))) (+ n 1L))
  )
)

(catalan 5L)
;-> 42L

(catalan 500L)
;-> 53949748691703906090941056611971112873483434819670316767942689642041003733637164
;-> 45082085507475097208889473175349731459177688817366281036278441002389211945617238
;-> 83202123256952806711505149177419849031086149939116975191706558395784192643914160
;-> 118616272189452807591091542120727401415762287153293056320L

Questa funzione genera un errore di stack-overflow per valori superiori di 512:

(catalan 513L)
;-> ERR: call or result stack overflow in function * : -
;-> called from user function (catalan (- n 1L))

Possiamo scrivere anche una versione iterativa, ma non possiamo usare i big-integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.
Utilizziamo una funzione diversa:

C(0) = C(1) = 1

C(n) = Prod[ (n + k)/k ] (dove k va da 2 a n) (per n > 1)

Iterativo
Non possiamo usare i big integer poichè la divisione altera il risultato, quindi dobbiamo usare i floating-point.

(define (catalan-i n)
  (let (res 1.0)
    (for (k 2 n)
        (setq res (mul res (div (add n k) k)))
    )
  )
)

(catalan-i 5L)
;-> 41.99999999999999

(ceil (catalan-i 5L))
;-> 42

(catalan-i 500L)
;-> 5.394974869170395e+296

Però possiamo usare un'altra definizione dei numeri Catalani per utilizzare i big-integer:

C(n) = binomiale(2n n) / (n + 1)

(define (binom num k)
  (if (> k num)
    0
    (let (r 1L)
      (for (d 1 k)
        (setq r (/ (* r num) d))
        (-- num)
      )
      r)))

(define (min-big a b) (if (< a b) a b))

(define (catalan-big n)
  (/ (binom (* 2 n) n) (+ 1L n)))

(map catalan-big (sequence 1 20))
;-> (1L 2L 5L 14L 42L 132L 429L 1430L 4862L 16796L
;->  58786L 208012L 742900L 2674440L 9694845L 35357670L
;->  129644790L 477638700L 1767263190L 6564120420L)

(time (catalan 500L) 1000)
;-> 634.693

(time (catalan-big 500L) 1000)
;-> 540.585

(= (map catalan (sequence 1 100)) (map catalan-big (sequence 1 100)))
;-> true


------------------
NUMERI DI KAPREKAR
------------------

Un numero intero positivo è un numero di Kaprekar se la rappresentazione decimale del suo quadrato può essere divisa una volta in due parti costituite da numeri interi positivi che sommano al numero originale.
Si noti che una divisione risultante in una parte costituita esclusivamente da 0 non è valida, poiché 0 non è considerato positivo.
Per convenzione 1 è un numero di Kaprekar.

(setq x 45)
;-> 45
(setq xx (* x x))
;-> 2025
(setq s (string (* x x)))
;-> "2025"

(for (i 0 (length s))
  (setq num1 (int (slice s 0 i) 0 10))
  (setq num2 (int (slice s i (length s)) 0 10))
  (println num1 { } num2)
)
;-> 0 2025
;-> 2 25
;-> 20 25 (la loro somma vale 45, quindi 45 è un numero di Kaprekar)
;-> 202 5
;-> 2025 0

Adesso possiamo scrivere la funzione:

(define (kaprekar? n)
  (local (kap i xx s num1 num2)
    (setq kap nil)
    (setq i 0)
    (setq xx (* n n))
    (setq s (string xx))
    (while (and (<= i (length s)) (= kap nil))
      (setq num1 (int (slice s 0 i) 0 10))
      (setq num2 (int (slice s i (length s)) 0 10))
      (if (and (> num2 0) (= n (+ num1 num2))) (setq kap true))
      (++ i)
    )
    kap
  )
)

(kaprekar? 1)
;-> true
(kaprekar? 10)
;-> nil
(kaprekar 2223)
;-> true

(define (kaprekar10000)
  (let (out '())
    (for (j 1 10000)
      (if (kaprekar? j) (setq out (append (list j) out)))
    )
    (println (reverse out))
    (println "Fino a 10000 ci sono " (length out) " numeri di Kaprekar.")
  )
)

(kaprekar10000)
;-> (1 9 45 55 99 297 703 999 2223 2728 4879 4950 5050 5292 7272 7777 9999)
;-> Fino a 10000 ci sono 17 numeri di Kaprekar.

(define (kaprekar1milione)
  (setq out '())
  (for (m 1 1000000)
    (if (kaprekar? m) (setq out (append (list m) out)))
  )
  (println (reverse out))
  (println "Fino a 1000000 ci sono " (length out) " numeri di Kaprekar.")
)

(kaprekar1milione)
;-> (1 9 45 55 99 297 703 999 2223 2728 4879 4950 5050 5292 7272 7777 9999 17344 22222
;->  38962 77778 82656 95121 99999 142857 148149 181819 187110 208495 318682 329967 351352
;->  356643 390313 461539 466830 499500 500500 533170 538461 609687 627615 643357 648648
;->  670033 681318 791505 812890 818181 851851 857143 961038 994708 999999)
;-> Fino a 1000000 ci sono 54 numeri di Kaprekar.

(time (kaprekar1milione))
;-> 11532 (millisecondi)


-------------
NUMERI FELICI
-------------

Un numero felice è definito dal seguente processo:
Iniziando con un numero intero positivo, sostituisci il numero con la somma dei quadrati delle sue cifre e ripeti il processo fino a quando il numero è uguale a 1 (dove rimarrà), o si genera un ciclo infinito che non include 1. Quei numeri per cui questo processo finisce in 1 sono numeri felici, mentre quelli che non terminano in 1 sono numeri infelici.
Vediamo un esempio:

(setq lista '())
;-> ()
(setq x 31)
;-> 31
(setq s (string x))
;-> "31"
(setq a (slice (explode s) 0))
;-> ("3" "1")
(setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
;-> 10 (3*3 + 1*1)

(cond ((= b 1) (setq felice true) (setq continua nil))
      ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
      (true (setq lista (cons b lista)) (setq n b))
)

se (b = 1) allora (felice = true) e (continua = nil)                  ;(il numero è felice)
se (b si trova nella lista) allora (felice = nil) e (continua = nil)  ;(il numero non è felice)
altrimenti inserisci il numero nella lista e continua                 ;continua creazione lista

(define (felice? n)
  (local (continua lista x s a b)
    (setq continua true)
    (setq lista '())
    (setq x n)
    (while (= continua true)
      (setq s (string x))
      (setq a (slice (explode s) 0))
      (setq b (apply + (map (lambda (x) (* (int x) (int x)))  a)))
      (cond ((= b 1) (setq felice true) (setq continua nil))
            ((!= (ref b lista) nil) (setq felice nil) (setq continua nil))
            (true (setq lista (cons b lista)) (setq x b))
      )
    )
    felice
  )
)

(felice? 10)
;-> true
(felice? 11)
;-> nil
(felice? 31)
;-> true

(define (felici1000)
  (let (out '())
    (for (j 1 1000)
      (if (felice? j) (setq out (append (list j) out)))
    )
    (println (reverse out))
    (println "Fino a 1000 ci sono " (length out) " numeri felici.")
  )
)

(felici1000)
;-> (1 7 10 13 19 23 28 31 32 44 49 68 70 79 82 86 91 94 97 100 103 109 129 130 133 139
;->  167 176 188 190 192 193 203 208 219 226 230 236 239 262 263 280 291 293 301 302
;->  310 313 319 320 326 329 331 338 356 362 365 367 368 376 379 383 386 391 392 397
;->  404 409 440 446 464 469 478 487 490 496 536 556 563 565 566 608 617 622 623 632
;->  635 637 638 644 649 653 655 656 665 671 673 680 683 694 700 709 716 736 739 748
;->  761 763 784 790 793 802 806 818 820 833 836 847 860 863 874 881 888 899 901 904
;->  907 910 912 913 921 923 931 932 937 940 946 964 970 973 989 998 1000)
;-> Fino a 1000 ci sono 143 numeri felici.


-----------------
NUMERI PRIMORIALI
-----------------

I numeri primoriali sono quelli formati moltiplicando i numeri primi successivi.
La serie di numeri primoriali vale:

   primoriale (0) = 1 (per definizione)
   primoriale (1) = 2 (2)
   primoriale (2) = 6 (2 * 3)
   primoriale (3) = 30 (2 * 3 * 5)
   primoriale (4) = 210 (2 * 3 * 5 * 7)
   primoriale (5) = 2310 (2 * 3 * 5 * 7 * 11)
   primoriale (6) = 30030 (2 * 3 * 5 * 7 * 11 * 13)
   ...

Per esprimere questo matematicamente, primoriale(n) è il prodotto dei primi n numeri primi (successivi):

primorial(n) = prod[prime(k)] (con k che va da 1 a n)

Un metodo semplice, anche se relativamente lento, è quello di generare n numeri primi con il metodo di Eratostene e poi calcolare i numeri primoriali.
Il teorema dei numeri primi ci dice che l'ennesimo numero primo viene delimitato dalla seguente espressione:

n*ln(n) + n*ln(ln(n)) - 1 < p(n) < n*ln(n) + n*ln(ln(n)) per n ≥ 6

La funzione è la seguente (utilizza i big integer):

(define (primoriale n bool)
  (local (pn maxnum primi p sum)
    (cond ((= n 0L) (setq pn '(1L)))
          ((= n 1L) (setq pn '(1L 2L)))
          (
            (if (<= n 6L) (setq maxnum 20L)
                (setq maxnum (ceil (mul n (add (log n) (log (log n)))))) ; limite superiore
            )
            ;(println maxnum)
            ; generiamo la lista con tutti i numeri primi esistenti fino a maxnum
            (setq primi (array (+ 1L maxnum) '(true)))
            (setq p 2L)
            (while (<= (* p p) maxnum)
              (if (= (primi p) true))
              (for (i (* p p) maxnum p) (setq (primi i) nil))
              (++ p)
            )
            (setq lista-primi '())
            (for (p 2L maxnum)
              (if (= (primi p) true)
                  ;(print p { })
                  (setq lista-primi (cons p lista-primi))
              )
            )
            (reverse lista-primi) ; funzione distruttiva (cambia direttamente lista-primi)
            ;(println lista-primi)
            ;(println (length lista-primi))
            (if (> n (length lista-primi)) (println "Errore")
                ; Calcoliamo i numeri primoriali fino a n
                (begin
                  (setq pn '(1L))
                  (setq sum 1L)
                  (for (i 0L (- n 1L))
                    ;(println {i =} i)
                    (for (k 0L i)
                      ;(println k)
                      (setq sum (* sum (nth k lista-primi)))
                    )
                    (setq pn (cons sum pn))
                    (setq sum 1L)
                  )
                  (reverse pn)
                  ; risultato
                  (if (= bool true) pn
                      (last pn)
                  )
                )
            )
          )
    ); end cond
  )
)

(primoriale 0)
;-> 1L

(primoriale 1)
;-> (1L 2L)

(primoriale 6 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L)

(primoriale 10 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L)

(primoriale 20 true)
;-> (1L 2L 6L 30L 210L 2310L 30030L 510510L 9699690L 223092870L 6469693230L 200560490130L
;->  7420738134810L 304250263527210L 13082761331670030L 614889782588491410L 32589158477190044730L
;->  1922760350154212639070L 117288381359406970983270L 7858321551080267055879090L
;->  557940830126698960967415390L)

(primoriale 20)
;-> 557940830126698960967415390L

(primoriale 40)
;-> 166589903787325219380851695350896256250980509594874862046961683989710L


---------------
NUMERI PERFETTI
---------------

Un numero è perfetto quando è uguale alla somma dei suoi divisori propri.
Oppure, un numero è perfetto quando è uguale alla metà della somma di tutti i suoi divisori positivi (incluso se stesso).
I divisori propri di un numero sono tutti i divisori del numero tranne il numero stesso.
Ad esempio, i divisori di 6 sono {1,2,3,6}, mentre i divisori propri di 6 sono {1,2,3}.
Inoltre, poichè 1 + 2 + 3 = 6, allora 6 è un numero perfetto.
Si conoscono pochi numeri perfetti perchè diventano enormi velocemente.

Per calcolare questi numeri scriviamo per primo una funzione che restituisce i divisori propri di un numero:

(define (divisori n)
  (local (lista-div m i)
    (setq lista-div '(1)) ; aggiungo il numero 1
    (setq m (int (sqrt n)))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è divisore di 'n'
            (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi aggiungine uno,
                              ; altrimenti aggiungili entrambi
              ;(setq lista-div (cons i lista-div))
              ;(setq lista-div (cons (/ n i) (cons i lista-div)))
              (push i lista-div -1)
              (begin (push i lista-div -1) (push (/ n i) lista-div -1))
            )
        )
        (++ i)
    )
    ;(push n lista-div -1) ; aggiungo il numero stesso
    (sort lista-div)
  )
)

(divisori 128)
;-> (1 2 4 8 16 32 64)

(divisori 20)
;-> (1 2 4 5 10)

(define (perfetto? n)
  (if (= n (apply + (divisori n))) true nil)
)

(perfetto? 6)
;-> true

(perfetto? 8)
;-> nil

(define (perfetti n)
  (let (res '())
    (for (x 2 n)
      (if (= true (perfetto? x)) (setq res (cons x res)))
    )
    (reverse res)
  )
)

(perfetti 10000)
;-> (6 28 496 8128)

La funzione è corretta, ma molto lenta. Proviamo a scrivere una versione ottimizzata:

(define (perfetto-fast? n)
  (local (somma q)
    (cond ((< n 2) (setq somma nil))
          ((!= (mod n 2) 0) (setq somma nil)) ; i numeri dispari non sono perfetti
          (true (setq somma 1)
                (for (i 2 (sqrt n))
                    (if (= (mod n i) 0) (begin (setq somma (+ somma i))
                                                (setq q (/ n i))
                                                (if (> q i) (setq somma (+ somma q)))
                                          )
                    )
                )
          )
    )
    (= n somma)
  )
)

(perfetto-fast? 6)
;-> true

(perfetto-fast? 8128)
;-> true

(perfetto-fast? 33550336)
;-> true

(define (perfetti-fast n)
  (let (res '())
    (for (x 2 n)
      (if (= true (perfetto-fast? x)) (setq res (cons x res)))
    )
    (reverse res)
  )
)

(perfetti-fast 10000)
;-> (6 28 496 8128)

Non provare ad eseguire (perfetti-fast 35000000) per trovare il prossimo numero perfetto (che vale 33550336) perchè impiega molto tempo (alcune ore sul mio computer).

Vediamo la differenza di velocità:

(time (perfetti 10000) 100)
;-> 12625.9

(time (perfetti-fast 10000) 100)
;-> 6797.5

(div 12625.9 6797.5)
;-> 1.857432879735197

La funzione "perfetti-fast" è 1.86 volte più veloce della funzione "perfetti".

Nota: i numeri perfetti hanno come espressione binaria p valori uguali a uno seguiti da (p-1) zeri (con p numero primo). Qui il numero tra parentesi denota la base in cui il numero viene espresso:

6(10)        = 110(2)
28(10)       = 11100(2)
496(10)      = 111110000(2)
4128(10)     = 1111111000000(2)
33550336(10) = 1111111111111000000000000(2)

Proviamo con il numero 17 (17 valori 1 seguiti da 16 valori 0)
(binary2decimal "111111111111111110000000000000000")
(perfetto-fast? 8589869056)
;-> true

Quindi possiamo cercare i numeri perfetti con il seguente algoritmo:
1) Prendere il primo numero primo pk ()
2) Costruire il numero binario con pk volte 1 e (pk - 1) volte 0
3) Convertire il numero in decimale
4) Controllare se il numero covertito è perfetto
5) Prendere il successivo numero primo e ripeti dal passo 2)

Prima di tutto definiamo una funzione che converte una stringa binaria in un numero decimale (big integer):

(define (binary2decimal b)
  (local (l d r d)
    (setq l (length b))
    (setq d 0L)
    (setq r (reverse b))
    (dostring (c r)
      ;(println c { } (char c) { } $idx)
      (setq d (+ d (* (int (char c)) (pow 2 $idx))))
    )
  )
)

(binary2decimal "1111111")
;-> 127L

(binary2decimal "1111111111111000000000000")
;-> 33550336L

Adesso scriviamo la funzione per trovare i numeri perfetti con il nostro algoritmo:

(define (perfetti-primi)
  (local (primi res ns dp)
    ; lista di numeri primi (attenzione che la funzione "divisori" è lenta)
    (setq primi '(2L 3L 5L 7L 11L 13L 17L 19L 23L))
    (setq res '())
    (dolist (p primi)
      ; creo il numero binario
      (setq ns (join (list (dup "1" p) (dup "0" (- p 1)))))
      ; converto il numero binario in decimale
      (setq dp (binary2decimal ns))
      ; se il numero decimale è perfetto, allora lo stampo
      (if (= dp (apply + (divisori dp))) (print dp { (} p {), }))
    )
  )
)

(perfetti-primi)
;-> 6L (2L), 28L (3L), 496L (5L), 8128L (7L), 33550336L (13L),
;-> 8589869056L (17L), 137438691328L (19L), nil

(perfetto-fast? 2305843008139952128)
;-> true ; ma ci vuole tanto tempo


----------------
NUMERI AMICABILI
----------------

Due interi N e M sono considerati coppia di numeri amicabili se N != M e la somma dei divisori propri di N è uguale a M e la somma dei divisori propri di M è uguale a N.
I divisori propri di un intero positivo N sono quei numeri, diversi da N, che dividono N senza resto.
Per N > 1 includeranno sempre 1, ma per N == 1 non ci sono divisori propri.

Scrivere una funzione per trovare le coppie di numeri amicabili fino a N = 100.000

(define (somma-divisori n)
  (local (res m i)
    (setq res 0)
    (setq m (sqrt n))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è un divisore di 'n'
            (if (= i (/ n i)) ; se entrambi i divisori sono uguali...
              (setq res (+ res i)) ; aggiungili una volta
              (setq res (+ res i (/ n i))) ; altrimenti aggiungili entrambi
            )
        )
        (setq i (+ i 1))
    )
    res
  )
)

(somma-divisori 10)
;-> 7

(define (somma-divisori-propri n)
  (+ 1 (somma-divisori n))
)

(define (amicabili)
  (local (spd spd2)
    (for (j 1 100000)
        (setq spd (somma-divisori-propri j))
        (setq spd2 (somma-divisori-propri spd))
        (if (and (= j spd2) (!= spd spd2))
            (println j { } spd)
        )
    )
  )
)

(amicabili)
;-> 220 284
;-> 284 220
;-> 1184 1210
;-> 1210 1184
;-> 2620 2924
;-> 2924 2620
;-> 5020 5564
;-> 5564 5020
;-> 6232 6368
;-> 6368 6232
;-> 10744 10856
;-> 10856 10744
;-> 12285 14595
;-> 14595 12285
;-> 17296 18416
;-> 18416 17296
;-> 63020 76084
;-> 66928 66992
;-> 66992 66928
;-> 67095 71145
;-> 69615 87633
;-> 71145 67095
;-> 76084 63020
;-> 79750 88730
;-> 87633 69615
;-> 88730 79750


-----------------
NUMERI PERNICIOSI
-----------------

Un numero pernicioso è un numero intero positivo il cui conteggio della popolazione è un numero primo.
Il numero di abitanti è il numero di uno (1) nella rappresentazione binaria di un numero intero non negativo.

Esempio
22 (che è 10110 in binario) ha un numero di abitanti pari a 3, che è primo, e quindi 22 è un numero pernicioso.

Funzione per verificare se un numero è primo:

(define (primo? n)
  (= 1 (length (factor n))))

Funzione che conta elementi in una lista:

(define (conta item lst)
    (cond ((null? lst) 0)
          ((= (first lst) item) (+ 1 (conta item (rest lst))))
          (true (conta item (rest lst)))))

(conta 'a '(a b c a n a c a a d f))
;-> 5

Funzione predefinita che conta elementi in una lista:

(count '(a) '(a b c a n a c a a d f))
;-> (5)

Funzione che converte un numero decimale in un numero binario:

(define (decimal2binary n)
  (cond ((zero? n) '())
        (true (cons (% n 2)
                    (decimal2binary (/ n 2))))))

(decimal2binary 63)
;-> (1 1 1 1 1 1)

Funzione che verifica se un numero è pernicioso:

(define (pernicioso? n)
  (local (np)
    (setq np (count '(1) (decimal2binary n)))
    (if (= true (primo? (first np))) true nil)
  )
)

(pernicioso? 22)
;-> true

Funzione che calcola i numeri perniciosi fino a n:

(define (perniciosi n)
  (let (res '())
    (for (x 2 n)
      (if (= true (pernicioso? x)) (setq res (cons x res)))
    )
    (reverse res)
  )
)

(perniciosi 25)
;-> (3 5 6 7 9 10 11 12 13 14 17 18 19 20 21 22 24 25)


--------------------
NUMERI DI MUNCHAUSEN
--------------------

Un numero di Munchausen è un numero naturale n la cui somma di cifre (in base 10), ciascuna (tranne la cifra zero) elevata alla potenza di se stessa, è uguale a n.

Ad esempio: 3435 = 3^3 + 4^4 + 3^3 + 5^5

Precalcoliamo i valori delle potenze:

(setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)

Facciamo una prova:
(setq a (explode (string 3435)))
;-> ("3" "4" "3" "5")
(setq b (map int a))
;-> (3 4 3 5)
(apply + (map (lambda (x) (nth x powers)) b))
;-> 3435

Adesso definiamo la funzione che verifica se un dato numero è di Munchausen:

(define (munchausen n)
  (apply + (map (lambda (x) (nth x powers)) (map int (explode (string n)))))
)

(munchausen 3435)
;-> 3435

(munchausen 438579088)
;-> 438579088

Infine scriviamo la funzione che ricerca i numeri di Munchausen:

(define (cerca-munchausen m)
  (local (powers)
    (setq powers (cons '0 (map (lambda (x) (pow x x)) (sequence 1 9))))
    ;-> (0 1 4 27 256 3125 46656 823543 16777216 387420489)
    (dotimes (i m)
      (if (= i (munchausen i)) (println i))
    )
  )
)

(cerca-munchausen 10000)
;-> 1
;-> 3435
;-> nil

(time (cerca-munchausen 500000000))
;-> 0
;-> 1
;-> 3435
;-> 438579088
;-> 1814539.27 ; millisecondi (circa 30 minuti)


-------------------
SEQUENZA DI COLLATZ
-------------------

La sequenza di numeri di Collatz (o Hailstone) può essere generata da un numero intero positivo iniziale, n da:

   se n è 1, la sequenza termina.
   se n è pari anche allora il successivo n della sequenza vale n / 2
   se n è dispari allora il successivo n della sequenza vale (3 * n) + 1

(define (collatz n)
  (if (= n 1) '(1)
    (cons n (collatz (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

(define (collatz-lenght n)
  (length (collatz n))
)

(collatz 13123)
;-> (13123 39370 19685 59056 29528 14764 7382 3691 11074 5537 16612 8306 4153 12460
;->  6230 3115 9346 4673 14020 7010 3505 10516 5258 2629 7888 3944 1972 986 493 1480 740
;->  370 185 556 278 139 418 209 628 314 157 472 236 118 59 178 89 268 134 67 202 101 304
;->  152 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

(collatz-lenght 13123)
;-> 77

Ecco una espressione che prende un numero e calcola la relativa lunghezza della sequenza di Collatz (scritta da Cormullion):

(let(f(fn(x)(cond((= x 1)0)((odd? x)(++(f(++(* 3 x)))))(1(++(f(>> x)))))))(f(int(read-line))))

10
;-> 6


------------
PERMUTAZIONI
------------

Una permutazione è un modo di ordinare in successione oggetti distinti.
Il numero delle permutazioni di n elementi vale: n!.

; =====================================================
; (permutazioni lst)
; Permutazioni di n elementi
; senza ripetizioni
; =====================================================

(define (remove x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst))(remove x (rest lst)))
    (true (cons (first lst) (remove x (rest lst))))))

(define (permutazioni lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutazioni (remove i lst)))) lst)))))

(permutazioni '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

Come funziona?

Quali sono le permutazioni di una lista e come le troveresti?

Le permutazioni di una lista con un singolo elemento sono la lista stessa.
Le permutazioni di (1 2) sono l'insieme: [(1 2) (2 1)].
Le permutazioni di (1 2 3) sono l'insieme: [(1 2 3) (1 3 2) (2 3 1) (2 1 3) (3 1 2) (3 2 1)]

In generale ci sono n! permutazioni in un elenco di lunghezza n - abbiamo n scelte per il primo elemento, e una volta che abbiamo scelto quello, (n-1) scelte per il secondo elemento, (n-2) per il terzo elemento, e così via. Questa diminuzione dei gradi di libertà ci suggerisce di trovare le permutazioni di un elenco di lunghezza n in termini di permutazioni di un elenco di lunghezza (n - 1), e così via fino a raggiungere le permutazioni di un elenco di elementi singoli.
Si scopre che le permutazioni di una lista sono precisamente l'insieme [elemento anteposto alle permutazioni di [lista - elemento], per ogni elemento nella lista].

Osservando il caso (1 2 3) si conferma che questo è vero - abbiamo 1 che prece (2 3) e (3 2), che sono le permutazioni di (2 3), 2 che precede (1 3) e (3 1) e così via. Questa operazione di anteporre l'elemento alla sottolista potrebbe essere definita come:

(define (prepend j)
  (cons element j))

e l'operazione per applicarlo a tutte le permutazioni della sottolista potrebbe essere:

(map prepend (permutazioni sublist))

Questa operazione è molto onerosa (considerando che hanno tutti la stessa forma), quindi utilizziamo un approccio lambda che cattura il valore dell'elemento considerato. L'operazione che vogliamo diventa:

(map (lambda (j) (cons element j)) (permutazioni sublist))

Adesso vogliamo applicare questa operazione ad ogni elemento della lista, quindi utilizziamo la funzione map con un'altra funzione lambda:

(map (lambda (element)
       (lambda (j) (cons element j) (permutazioni sublist)))
     list)

Sembra che vada tutto bene, ma c'è un problema: ogni ciclo di ricorsione prende un elemento e lo converte in una lista. Questo va bene per una lista di lunghezza 1, ma per liste più lunghe ogni elemento genera un annidamento della lista. Per inserire allo stesso livello ogni permutazione generata dobbiamo utilizzare la funzione (apply append...).
Adesso l'unica cosa che manca è come generare la prima sottolista? Questo viene ottenuto utilizzando la funzione "remove": la sottolista è uguale a (remove element list).
La funzione "remove" elimina l'elemento x dalla lista lst:

(remove '1 '(1 2 3 1 1))
;-> (2 3)

In definitiva l'istruzione completa è la seguente:

(apply append (map (lambda (i) (lambda (j) (cons i j))
                               (permutazioni (remove i lst))) lst))

che risove tutti i casi tranne quello base che viene preso in conasiderazione da:

((= (length lst) 1)(list lst))

Questo è tutto, ma per capire meglio la funzione "permutazioni" facciamo un esempio partendo dall'interno e proseguendo verso l'esterno.
Applichiamo l'espressione interna (permutazioni (remove i lst)) ad uno degli elementi:

(define lst '(1 2 3))
(define i 1)
(permutazioni (remove i lst))
;-> ((2 3) (3 2))

L'espressione rimuove un elemento e genera, ricorsivamente, le permutazioni del resto della lista.
Adesso applichiamo map con la funzione lambda sulle permutazioni ottenute:

(define j 1)
(map (lambda (j) (cons i j)) (permutazioni (remove i lst)))
;-> ((1 2 3) (1 3 2))

Quindi il map interno produce tutte le permutazioni per un dato i (in questo caso i=1)
Il map esterno assicura che tutte le permutazioni sono generate considerando tutti gli elementi della lista lst come primo elemento:

(map (lambda (i) (map (lambda (j) (cons i j))
                      (permutazioni (remove i lst))))
     lst)
;-> (((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1)))

Ma questo genera troppe liste innestate, quindi l'applicazione di append appiattisce una lista di liste:

(append '(1 2) '(3 4) '(5 6))
;-> (1 2 3 4 5 6)

(apply append '(((1 2 3) (1 3 2)) ((2 1 3) (2 3 1)) ((3 1 2) (3 2 1))))
;-> ((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1))

In questo modo otteniamo la lista corretta delle permutazioni.

Anche la seguente funzione calcola le permutazioni, ma con un metodo diverso:

(define (insert lst n e)
  (if (= 0 n)
      (cons e lst)
      (cons (first lst)
            (insert (rest lst) (- n 1) e))))

(define (permutazioni l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n)
                                  (insert p n (first l)))
                                (sequence 0 (length p))))
                         (permutazioni (rest l))))))

(permutazioni '(1 2 3))
;-> ((1 2 3) (2 1 3) (2 3 1) (1 3 2) (3 1 2) (3 2 1))

Possiamo creare le permutazioni utilizzando l'algoritmo di Heap ( https://en.wikipedia.org/wiki/Heap%27s_algorithm ).
Questo algoritmo produce tutte le permutazioni scambiando un elemento ad ogni iterazione.

(define (perm lst)
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
    out
  )
)

(perm '(a b c))
;-> ((a b c) (b a c) (c a b) (a c b) (b c a) (c b a))

(perm '(a b b))
;-> ((a b b) (b a b) (b a b) (a b b) (b b a) (b b a))

(length (perm '(0 1 2 3 4 5 6 7 8 9)))
;-> 36628800

(time (length (perm '(0 1 2 3 4 5 6 7 8 9))))
;-> 3928.519

; =====================================================
; (perm-rep k lst)
; Permutazioni di k elementi su n elementi
; con ripetizioni
; =====================================================

Il numero di permutazioni con ripetizione di n elementi distinti presi a k vale: n!/(n - k)!

Per trovare un metodo può essere utile scrivere alcuni risultati per valori piccoli di N e vedere se riesciamo a estrapolare uno schema:

LISTA = (a b)
DIMENSIONE  (ELEMENTI DELLA PERMUTAZIONE)
0           ( () )
1           ( (a) (b) )
2           ( (a a) (a b) (b a) (b b) )
3           ( (a a a) (a a b) (a b a) (a b b) (b a a) ... )

Quindi fondamentalmente quello che vogliamo fare è, dato R = (permutazioni n elementi), ottenere (permutazioni (+ n 1) elementi) prendendo ogni permutazione P in R, e quindi per ogni elemento E in LISTA, uniamo E a P per creare una nuova permutazione e la memorizziamo in una lista. Questo possiamo farlo con MAP annidate:

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p)          ; For each permutation we already have:
                 (map (lambda (e)     ; For each element in the set:
                        (cons e p))   ; Add the element to the perm'n.
                      elements))
               (permutations (- k 1) elements))))

Dobbiamo usare "flat" per la funzione esterna "map", perché la MAP interna crea liste di nuove permutazioni e dobbiamo unire queste liste insieme per creare un'unica lista (piatta) delle permutazioni che vogliamo.

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 2 '(a b c))
;-> ((a a) (b a) (c a) (a b) (b b) (c b) (a c) (b c) (c c))

(perm-rep 2 '(a b b))
((a a) (b a) (b a) (a b) (b b) (b b) (a b) (b b) (b b))


------------
COMBINAZIONI
------------

; =====================================================
; (combinazioni k nlst)
; Calcola le combinazioni di k elementi da n elementi
; senza ripetizione
; =====================================================

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(1 2 3 4))
;-> ((1 2) (1 3) (1 4) (2 3) (2 4) (3 4))

(combinazioni 3 '(1 2 3 4))
;-> ((1 2 3) (1 2 4) (1 3 4) (2 3 4))

(combinazioni 1 '(a b c))
;-> ((a) (b) (c))

(combinazioni 2 '(a b c))
;-> ((a b) (a c) (b c))

(combinazioni 3 '(a b c))
;-> ((a b c))

; =====================================================
; (comb-rep k nlst)
; Calcola le combinazioni di k elementi da n elementi
; con ripetizione
; =====================================================
(define (comb-rep k lst)
  (cond ((= k 0) '(()))
        ((null? lst) '())
        (true
         (append (map (lambda (x) (cons (first lst) x))
                      (comb-rep (- k 1) lst))
                 (comb-rep k (rest lst))))))

(comb-rep 2 '(a b))
;-> ((a a) (a b) (b b))
(comb-rep 2 '(1 2 3 4))
;-> ((1 1) (1 2) (1 3) (1 4) (2 2) (2 3) (2 4) (3 3) (3 4) (4 4))
(comb-rep 2 '(1 2 3))
;-> ((1 1) (1 2) (1 3) (2 2) (2 3) (3 3))
(comb-rep 3 '(1 2 3))
;-> ((1 1 1) (1 1 2) (1 1 3) (1 2 2) (1 2 3) (1 3 3) (2 2 2) (2 2 3) (2 3 3) (3 3 3))


----------------
REGOLA DI HORNER
----------------

Calcolare il valore del polinomio: y = 6*x^3 - 4*x^2 + 7*x - 19 per x = 3.
La regola di Horner è un algoritmo inventato da William George Horner che permette di valutare un polinomio: Pn(x) = a(0)*x^n + a(1)*x^(n-1) +...+ a(n-1)*x + a(n) svolgendo n addizioni ed n moltiplicazioni (algoritmo ottimale). Infatti è possibile riscrivere il polinomio nella forma:

Pn(x) = a(n) + x*(a(n-1) + x*(a(n-2) + ... + x*(a(1) + a(0)*x)...))

Pertanto, il valore di tale polinomio si può calcolare sfruttando la definizione ricorsiva:

p(0) = a(0)
p(k+1) = p(k)*x + a(k+1)

Scriviamo la funzione prima in stile funzionale:

(define (horner lst x)
  (define (*horner lst x acc)
    (if (null? lst) acc
        (*horner (rest lst) x (+ (* acc x) (first lst)))))
  (*horner (reverse lst) x 0))

(horner '(-19 7 -4 6) '3)
;-> 128

Adesso la scriviamo in stile iterativo:

(define (horner-i lst-coeffs x)
  (local (acc)
    (setq acc 0)
    (reverse lst-coeffs) ; funzione distruttiva
    (dolist (el lst-coeffs)
      ;acc = acc * x + c
      (setq acc (add (mul acc x) el))
    )
    acc
  )
)

(horner-i '(-19 7 -4 6) '3)
;-> 128

Vediamo un altro modo di scrivere la funzione in stile funzionale:

(define (horner-f lst x)
  (cond ((null? lst) '0)
        (true (+ (first lst) (* x (horner-f (rest lst) x))))))

(horner-f '(-19 7 -4 6) '3)
;-> 128


-------------------------------
PROBLEMA DELLO ZAINO (KNAPSACK)
-------------------------------

Il problema dello zaino, detto anche problema di Knapsack, è un problema di ottimizzazione combinatoria definito nel modo seguente:
Dato uno zaino che può supportare determinato peso e dati N oggetti, ognuno dei quali caratterizzato da un peso e un valore, il problema si propone di scegliere quali di questi oggetti mettere nello zaino per ottenere il maggiore valore senza eccedere il peso sostenibile dallo zaino stesso.
In maniera formale la formulazione del problema diventa:
- ognuno degli N oggetti possiede un peso p(i) e un valore v(i)
- il valore W indica il peso massimo sopportabile dallo zaino;
- la possibilità che un oggetto venga inserito o meno nello zaino è espressa dalle variabili intere x(i)
La funzione obiettivo è:

max Z = Sum(ci*xi) (per i=1..N)

Con i vincoli:

W <= Sum(wi*xi) (per i=1..N)

Si indichino con w{i} il peso dell'i-esimo oggetto e con c{i} il suo valore. Si vuole massimizzare il valore totale rispettando il vincolo che il peso totale sia minore o uguale al peso massimo consentito W. Definiamo A(i,j) come il massimo valore che può essere trasportato con uno zaino di capacità j <= W avendo a disposizione solo i primi "i" oggetti.

Si può definire A(i,j) ricorsivamente come segue:

A(0,j) = 0
A(i,0) = 0
A(i,j) = A(i-1,j) se w(i) > j
A(i,j) = max[A(i-1,j), A(i-1,j-w(i)) + c(i)] se w(i) <= j.}

Cerchiamo di risolvere il problema con la forza bruta: calcolo tutte le combinazioni di oggetti con il relativo valore e poi scelgo quella combinazione che ha il valore maggiore (potrebbero esserci più di una combinazione con valore massimo).
I dati sono rappresentati da una lista i cui elementi hanno la seguente struttura:

(nome peso valore)

Supponiamo che la lista iniziale sia la seguente:

(setq k '((a 2 3) (b 3 4) (c 4 5) (d 5 6)))
;-> ((a 2 3) (b 3 4) (c 4 5) (d 5 6))

Definiamo tre funzioni che estraggono le liste dei nomi, dei pesi e dei valori:

(define (getNomi lst) (map (fn(x) (first x)) lst))
(define (getPesi lst) (map (fn(x) (first (rest x))) lst))
(define (getValori lst) (map (fn(x) (last x)) lst))

(setq nomi (getNomi k))
;-> (a b c d)
(setq pesi (getPesi k))
;-> (2 3 4 5)
(setq valori (getValori k))
;-> (3 4 5 6)

Questa è la funzione per generare le combinazioni:

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(combinazioni 2 '(3 4 5 6))
;-> ((3 4) (3 5) (3 6) (4 5) (4 6) (5 6))

Dobbiamo generare le combinazioni (dei valori) relative a tutte le possibili liste (quindi quelle di qualunque lunghezza):

(setq allv '())
(for (i 1 (length valori))
  (extend allv (combinazioni i valori))
)
;-> ((3) (4) (5) (6) (3 4) (3 5) (3 6) (4 5) (4 6) (5 6) (3 4 5) (3 4 6) (3 5 6)
;->  (4 5 6) (3 4 5 6))

Notare che il numero di combinazioni da cansiderare vale (2^elementi + 1).
Ad esempio con 22 elementi dobbiamo considerare (pow 2 22) = 4194304 combinazioni.

Adesso dobbiamo calcolare la somma dei valori di ogni sottolista (peso):

(setq sumv (map (fn (x) (apply + x)) allv))
;-> (3 4 5 6 7 8 9 9 10 11 12 13 14 15 18)

Cerchiamo il valore massimo
(setq valmax (apply max sumvOK))
;-> 10

Adesso dobbiamo eliminare tutti i valori che sono superiori al peso massimo W:
(setq W 10)

(setq sumvOK (map (fn(x) (if (> x W) 0 x)) sumv))
;-> (3 4 5 6 7 8 9 9 10 0 0 0 0 0 0)

Troviamo gli indici dei valori che hanno valore massimo (10):
(setq sol-idx (flat (ref-all 10 sumvOK)))
;-> (8)

Adesso cerchiamo i valori che concorrono a creare il valore massimo:
(setq val-max '())
(dolist (el sol-idx)
  (push (allv el) val-max -1)
)
;-> ((4 6))

Troviamo gli indici degli elementi che hanno valore 4 e 6:

(setq ele-idx '())
(dolist (el val-max)
  (setq item '())
  (dolist (x el)
    (setq vv (ref x valori))
    (push (list (nomi vv) (valori vv)) item -1)
  )
  (push item ele-idx -1)
)
;-> (((b 4) (d 6)))

Finalmente abbiamo trovato la soluzione.

Come abbiamo anticipato, si può trovare la soluzione calcolando A(n,W). Per farlo in modo efficiente si può usare una tabella che memorizza i calcoli fatti precedentemente (memoization o programmazione dinamica). Questa soluzione impiegherà quindi un tempo proporzionale a O(nW)} e uno spazio anch'esso proporzionale a O(nW).

(define (knapsack C items)
  (define (getNomi lst) (map (fn(x) (first x)) lst))
  (define (getPesi lst) (map (fn(x) (first (rest x))) lst))
  (define (getValori lst) (map (fn(x) (last x)) lst))
  (local (table x name weight val cp n nome peso valore)
    ;creazione i vettori dei dati
    (setq n (length items))
    (setq name (getNomi items))
    (setq weight (getPesi items))
    (setq val (getValori items))
    (setq table (array (add n 1) (add C 1) '(0)))
    ;(for (i 0 (sub n 1)) (setf (table i 0) 0))
    ;(for (j 0 (sub n 1)) (setf (table 0 j) 0))
    (for (i 1 n)
      (for (cp 1 C)
        (if (<= (weight (sub i 1)) cp)
            (begin
              ;(println (weight (sub i 1)) { } (val (sub i 1)))
              (setq x (sub cp (weight (sub i 1))))
              (setf (table i cp) (max (add (val (sub i 1)) (table (sub i 1) x))
                                      (table (sub i 1) cp)))
            )
        ;else
            (begin
              (setf (table i cp)  (table (sub i 1) cp))
            )
        )
      )
    )
    ;(println (table n C))
    ; Selezione elementi della soluzione
    (setq res '())
    (setq cp C)
    (setq ptot 0)
    (setq vtot 0)
    (for (i n 1 -1)
      (setq aggiunto (!= (table i cp) (table (sub i 1) cp)))
      (if aggiunto
        (begin
           (setq nome (name (sub i 1)))
           (setq peso (weight (sub i 1)))
           (setq valore (val (sub i 1)))
           (push (list nome peso valore) res)
           (setq ptot (add ptot peso))
           (setq vtot (add vtot valore))
           (setq cp (sub cp peso))
        )
      )
    )
    (println "Valore: " vtot { } "Peso: " ptot)
    res
  )
)

(setq item '((maps 9 150) (compass 13 35) (water 153 200) (sandwich 50 160)
             (glucose 15 60) (tin 68 45) (banana 27 60) (apple 39 40)
             (cheese 23 30) (beer 52 10) (suntan-cream 11 70) (camera 32 30)
             (T-shirt 24 15) (trousers 48 10) (umbrella 73 40)
             (waterproof-trousers 42 70) (waterproof-overclothes 43 75)
             (note-case 22 80) (sunglasses 7 20) (towel 18 12) (socks 4 50)
             (book 30 10)
            ))

(knapsack 400 items)
;-> Valore: 1030 Peso: 396
;-> ((maps 9 150) (compass 13 35) (water 153 200) (sandwich 50 160) (glucose 15 60)
;->  (banana 27 60) (suntan-cream 11 70) (waterproof-trousers 42 70) (waterproof-overclothes 43 75)
;->  (note-case 22 80) (sunglasses 7 20) (socks 4 50))


----------------------
GIORNO DELLA SETTIMANA
----------------------

Dato anno, mese e giorno, determinare il giorno della settimana.
Esistono diversi algoritmi per risolvere questo problema.

La prima funzione utilizza la regola di Zeller per calcolare il giorno della settimana nel calendario gregoriano prolettico (Domenica = 0)

(define (dayZ year month day)
  (local (adjust mm yy d)
    (setq adjust (/ (- 14 month) 12))
    (setq mm (+ month (* 12 adjust) (- 2)))
    (setq yy (- year adjust))
    (setq d (% (+ day (/ (- (* 13 mm) 1) 5) yy (/ yy 4) (- (/ yy 100)) (/ yy 400)) 7))
  )
)

(dayZ 2019 6 2)
;-> 0

La seconda funzione usa l'algoritmo di Gauss per determinare il giorno della settimana.
Questo metodo vale per il calendario gregoriano.
La funzione seguente è presa dal sito di newLISP (Lutz Mueller).

(define (dayG year month day) ; 0..6 --> Domenica..Sabato
    (letn ( d day
            m (+ (% (- month 3) 12) 1)
            Y (if (> m 10) (- year 1) year)
            y (% Y 100)
            c (/ (- Y y) 100)
            w (add d (floor (sub (mul 2.6 m) 0.2)) y (floor (div y 4)) (floor (div c 4)) (- (mul c 2)))
            w (% w 7)
          )
       (if (< w 0) (inc w 7) w))
)

(dayG 2019 6 2)
;-> 0

La terza funzione usa l'algoritmo di Tomohiko Sakamoto. Anche questo metodo vale per il calendario gregoriano.

Vediamo come funziona l'algoritmo.
Il 1 gennaio dell'anno 1 D.C. è un lunedì nel calendario gregoriano.
Prendiamo in considerazione il primo caso in cui non abbiamo anni bisestili, quindi il numero totale di giorni in ogni anno è 365. Gennaio ha 31 giorni cioè 7*4+3 giorni, quindi il giorno del 1° febbraio sarà sempre 3 giorni prima della giornata del 1° gennaio. Ora febbraio ha 28 giorni (esclusi gli anni bisestili) che è il multiplo esatto di 7 (7 * 4 = 28) Quindi non ci saranno cambiamenti nel mese di marzo e sarà anche 3 giorni prima del giorno del 1° gennaio dell'anno rispettivo. Considerando questo modello, se creiamo un vettore del numero iniziale di giorni per ogni mese, avremo: t = (0, 3, 3, 6, 1, 4, 6, 2, 5, 0, 3, 5).
Ora diamo un'occhiata al caso reale quando ci sono anni bisestili. Ogni 4 anni, il nostro calcolo guadagnerà un giorno in più. Tranne ogni 100 anni quando non lo guadagna. Tranne ogni 400 anni quando lo guadagna. Come inseriamo questi giorni aggiuntivi? Basta aggiungere y / 4 - y / 100 + y / 400. Si noti che tutta la divisione è una divisione intera. Questo aggiunge esattamente il numero richiesto di giorni bisestili. Ma qui c'è un problema, il giorno bisestile è il 29 febbraio e non il 0 gennaio. Ciò significa che l'anno corrente non deve essere conteggiato per il calcolo del giorno bisestile per i primi due mesi. Supponiamo che se il mese fosse gennaio o febbraio, abbiamo sottratto 1 dall'anno. Ciò significa che durante questi mesi, il valore y/4 sarà quello dell'anno precedente e non verrà conteggiato. Se sottraiamo 1 dai valori t[] di ogni mese dopo febbraio? Ciò riempirebbe il vuoto e il problema degli anni bisestili verrà risolto. In altre parole, dobbiamo apportare le seguenti modifiche:
1. t[] diventa (0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4).
2. se m corrisponde a Gen/Feb (ovvero, i mesi < 3) diminuiamo y di 1.
3. l'incremento annuo all'interno del modulo è ora y + y/4 - y/100 + y/400 al posto di y.

Adesso possiamo scrivere la funzione:

(define (dayT year month day) ; 0..6 --> Domenica..Sabato
  (local (t d)
    (setq t '(0 3 2 5 0 3 5 1 4 6 2 4))
    (if (< month 3) (-- year))
    (setq d (% (add year (/ year 4) (/ (- year) 100) (/ year 400) (t (- month 1)) day) 7))
  )
)

(dayT 2019 6 2)
;-> 0

(dayZ 2017 7 13) ;-> 4
(dayG 2017 7 13) ;-> 4
(dayT 2017 7 13) ;-> 4

(dayZ 2012 8 15) ;-> 3
(dayG 2012 8 15) ;-> 3
(dayT 2012 8 15) ;-> 3

(dayZ 2456 12 24) ;-> 0
(dayG 2456 12 24) ;-> 0
(dayT 2456 12 24) ;-> 0


-------------------
TRIANGOLO DI PASCAL
-------------------

Il triangolo di Pascal (o di Tartaglia) è una matrice triangolare formata dai coefficienti binomiali (ossia dai coefficienti dello sviluppo del binomio (a + b) elevato ad una qualsiasi potenza n - Esempio: (a + b)^2 = 1*a^2 + 2*a*b + 1*b^2).

Ecco un triangolo con 9 linee, in cui le righe e le colonne sono state numerate (a base zero):

         colonne
         0  1  2  3  4  5  6  7  8
righe
    0    1  0  0  0  0  0  0  0  0
    1    1  1  0  0  0  0  0  0  0
    2    1  2  1  0  0  0  0  0  0
    3    1  3  3  1  0  0  0  0  0
    4    1  4  6  4  1  0  0  0  0
    5    1  5 10 10  5  1  0  0  0
    6    1  6 15 20 15  6  1  0  0
    7    1  7 21 35 35 21  7  1  0
    8    1  8 28 56 70 56 28  8  1

dove ogni elemento della matrice vale: matrice[riga][colonna] = binomiale[n, k]

Tutte le righe iniziano e terminano con il numero 1.

Ogni riga ha un elemento in più rispetto al suo predecessore.

Definiamo una funzione che calcola il triangolo di Pascal utilizzando i coeffiecienti binomiali.
La prima funzione permette di calcolare il coefficiente binomiale di n,k.

(define (binomiale n k)
  (local (M q)
    (setq M (array (+ n 1) (+ k 1) '(0)))
    (for (i 0 n)
      (setq q (min i k))
      (for (j 0 q)
        (if (or (= j 0) (= j i))
          (setq (M i j) 1)
          (setq (M i j) (+ (M (- i 1) (- j 1)) (M (- i 1) j)))
        )
      )
    )
    (M n k)
  );local
)

(binomiale 5 0)
;-> 1
(binomiale 5 3)
;-> 10

Poi definiamo la funzione che crea il triangolo di Pascal:

(define (pascal n)
  (local (P)
    (setq P (array n n '(0)))
    (for (riga 0 (- n 1))
      (for (i 0 riga)
        (setf (P riga i) (binomiale riga i))
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  )
)

Definiamo la funzione che stampa la matrice:

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice (da rivedere)
    (setq col (length (first matrix)))
    ; valore massimo
    (setq nmax (string (apply max (flat matrix))))
    ; valore minimo
    (setq nmin (string (apply min (flat matrix))))
    ; calcolo spazio per i numeri
    (setq digit (add 1 (max (length nmax) (length nmin))))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "d"))
    ; stampa
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println)
    )
  )
)

(pascal 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

Il matematico tedesco Stifel ha scoperto che gli elementi del triangolo di Pascal hanno la seguente proprietà (nota come Relazione di Stifel):

Se col = 0 o row = col,
  P(row,col) = 1

Se row >= col,
  P(row,col) = P(row-1,col) + P(row-1,col-1)

dove (row >= 0) e (col >= 0)

Quindi possiamo definire una nuova funzione per calcolare il triangolo di Pascal utilizzando la relazione di Stifel:

(define (pascalS n)
  (local (P)
    (setq P (array n n '(0L)))
    (for (row 0 (- n 1))
      (for (col 0 row)
        (if (or (= col 0) (= row col))
            (setf (P row col) 1L)
            (setf (P row col) (+ (bigint (P (- row 1) col)) (bigint  (P (- row 1) (- col 1)))))
        )
      )
    )
    ; disabilitare la seguente istruzione per calcolare la velocità
    (print-matrix P)
  );local
)

(pascalS 9)
;-> 1  0  0  0  0  0  0  0  0
;-> 1  1  0  0  0  0  0  0  0
;-> 1  2  1  0  0  0  0  0  0
;-> 1  3  3  1  0  0  0  0  0
;-> 1  4  6  4  1  0  0  0  0
;-> 1  5 10 10  5  1  0  0  0
;-> 1  6 15 20 15  6  1  0  0
;-> 1  7 21 35 35 21  7  1  0
;-> 1  8 28 56 70 56 28  8  1

(pascalS 14)
;-> 1    0    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    1    0    0    0    0    0    0    0    0    0    0    0    0
;-> 1    2    1    0    0    0    0    0    0    0    0    0    0    0
;-> 1    3    3    1    0    0    0    0    0    0    0    0    0    0
;-> 1    4    6    4    1    0    0    0    0    0    0    0    0    0
;-> 1    5   10   10    5    1    0    0    0    0    0    0    0    0
;-> 1    6   15   20   15    6    1    0    0    0    0    0    0    0
;-> 1    7   21   35   35   21    7    1    0    0    0    0    0    0
;-> 1    8   28   56   70   56   28    8    1    0    0    0    0    0
;-> 1    9   36   84  126  126   84   36    9    1    0    0    0    0
;-> 1   10   45  120  210  252  210  120   45   10    1    0    0    0
;-> 1   11   55  165  330  462  462  330  165   55   11    1    0    0
;-> 1   12   66  220  495  792  924  792  495  220   66   12    1    0
;-> 1   13   78  286  715 1287 1716 1716 1287  715  286   78   13    1

Per vedere quale funzione è più veloce commentiamo nelle due funzioni la riga che contiene l'istruzione per stampare la matrice:

; (print-matrix P)


(time (pascal 30) 100)
;-> 2914.029

(time (pascalS 30) 100)
;-> 34.966

La seconda funzione è velocissima perchè non calcola tutti i coefficienti binomiali, ma riempie la matrice ricorsivamente con una relazione matematica.

Per finire vediamo come calcolare la riga n-esima del triangolo di Pascal (valida anche per i big integer):

(define (pascaln n)
  (local (out)
    (setq out '(1L))
    (for (k 0 (- n 1))
      (push (/ (* (out k) (- n k)) (+ k 1)) out -1)
    )
    out
  )
)

(pascaln 9)
;-> (1L 9L 36L 84L 126L 126L 84L 36L 9L 1L)

(pascaln 20)
;-> (1L 20L 190L 1140L 4845L 15504L 38760L 77520L 125970L 167960L 184756L 167960L 125970L
;->  77520L 38760L 15504L 4845L 1140L 190L 20L 1L)

Questa funzione sfrutta la seguente identità matemetica sulle combinazioni:

C(n, k+1) = C(n,k) * (n-k) / (k+1)

Quindi iniziamo con C(n, 0) = 1 e poi calcoliamo il resto della riga usando questa identità, cioè moltiplichiamo ogni volta l'elemento precedente per (n-k)/(k+1).
Ricordiamo che il coefficiente binomiale rappresenta il numero di scelte di k elementi tra quelli di un insieme di n elementi (numero di combinazioni semplici).


------------
CODICE MORSE
------------

Il codice Morse è un metodo per trasmettere informazioni, utilizzando sequenze standardizzate di brevi e lunghi segni o impulsi, comunemente noti come punti e linee ("dot and dashes"), per le lettere, i numeri e i caratteri speciali di un messaggio.
Originariamente creato per il telegrafo elettrico di Samuel Morse verso la metà del 1830, fu anche ampiamente utilizzato per le prime comunicazioni radio a partire dal 1890.

Rappresentazione del codice

A  • −         N  − •         0  − − − − −     .  • − • − • −
B  − • • •     O  − − −       1  • − − − −     ,  − − • • − −
C  − • − •     P  • − − •     2  • • − − −     :  − − − • • •
D  − • •       Q  − − • −     3  • • • − −     ?  • • − − • •
E  •           R  • − •       4  • • • • −     =  − • • • −
F  • • − •     S  • • •       5  • • • • •     -  − • • • • −
G  − − •       T  −           6  − • • • •     (  − • − − •
H  • • • •     U  • • −       7  − − • • •     )  − • − − • −
I  • •         V  • • • −     8  − − − • •    {"} • − • • − •
J  • − − −     W  • − −       9  − − − − •     '  • − − − − •
K  − • −       X  − • • −                      /  − • • − •
L  • − • •     Y  − • − −                      @  • − − • − •
M  − −         Z  − − • •                      !  − • − • − −
                                               " "  "       "

Il codice Morse internazionale è composto da 5 elementi:

1) Impulso breve, punto (dot o "dit"): "dot duration" vale una unità di tempo
2) Impulso lungo, linea (dash o "dah"): "dash duration" vale tre unità di tempo
3) Intervallo di divisione tra dot e dash di un carattere: vale una unità di tempo
4) Intervallo breve (tra le lettere): vale tre unità di tempo
5) Intervallo lungo (tra le parole): vale sette unità di tempo

Il codice Morse viene trasmesso come un codice digitale usando solo due stati (acceso e spento). Il codice Morse può essere rappresentato come un codice binario: 1 acceso e 0 spento. Quindi una sequenza di codice Morse è costituita da una combinazione delle seguenti cinque stringhe di bit:

1) Impulso breve, punto (dot o "dit"): "dot duration" 1
2) Impulso lungo, linea (dash o "dah"): "dash duration" 111
3) Intervallo di divisione tra dot e dash di un carattere: 0
4) Intervallo breve (tra le lettere): 000
5) Intervallo lungo (tra le parole): 0000000

Notare che gli impulsi e gli intervalli (zeri) sono alternati: punti e linee sono sempre separati da uno degli intervalli vuoti e che gli intervalli sono sempre separati da un punto o da una linea.

In termini di spazio invece che di tempo, abbiamo:

1) Un punto (dot) occupa uno spazio "."
2) Una linea (dash) occupa 3 spazi "---"
3) Le parti di ogni lettera sono separate da uno spazio " "
4) Tra due lettere intercorrono 3 spazi. "   "
5) Tra due parole intercorrono 7 spazi.  "       "

Per scrivere le funzioni di conversione abbiamo bisogno di creare due liste di associazione:

; Lista di associazione carattere --> codice morse
(setq alfa-morse '(
("A"  ". -")
("B"  "- . . .")
("C"  "- . - .")
("D"  "- . .")
("E"  ".")
("F"  ". . - .")
("G"  "- - .")
("H"  ". . . .")
("I"  ". .")
("J"  ". - - -")
("K"  "- . -")
("L"  ". - . .")
("M"  "- -")
("N"  "- .")
("O"  "- - -")
("P"  ". - - .")
("Q"  "- - . -")
("R"  ". - .")
("S"  ". . .")
("T"  "-")
("U"  ". . -")
("V"  ". . . -")
("W"  ". - -")
("X"  "- . . -")
("Y"  "- . - -")
("Z"  "- - . .")
("0"  "- - - - -")
("1"  ". - - - -")
("2"  ". . - - -")
("3"  ". . . - -")
("4"  ". . . . -")
("5"  ". . . . .")
("6"  "- . . . .")
("7"  "- - . . .")
("8"  "- - - . .")
("9"  "- - - - .")
("."  ". - . - . -")
(","  "- - . . - -")
(":"  "- - - . . .")
("?"  ". . - - . .")
("="  "- . . . -")
("-"  "- . . . . -")
("("  "- . - - .")
(")"  "- . - - . -")
("\""  ". - . . - .")
("'"  ". - - - - .")
("/"  "- . . - .")
("@"  ". - - . - .")
("!"  "- . - . - -")
(" "  "       ")))

Sottolineato  ". . - - . -"
. - . . - .
; Lista di associazione codice morse --> carattere
(setq morse-alfa (map (fn (n) (list (last n) (first n))) alfa-morse))

(lookup "A" alfa-morse)
;-> ". -"
(lookup "−" morse-alfa)
;-> "T"

Adesso possiamo scrivere la funzione che converte un messaggio di testo in una lista di codici morse:

(define (morse2alfa msg)
  (let (out '())
    (dolist (ch (explode msg))
      (if (lookup ch alfa-morse)
          (push (lookup ch alfa-morse) out -1)
          (push "$$$" out -1)
          ;(print (lookup ch alfa-morse){   })
          ;(print "$$$"{   })
      )
    )
    out
  )
)

(setq msg "Testo da tradurre.")
; conversione del messaggio in lettere maiuscole
(setq msg (upper-case msg))

(morse2alfa msg)
;-> ("-" "." ". . ." "-" "- - -" "       " "- . ." ". -" "       " "-" ". - ." ". -"
;->  "- . ." ". . -" ". - ." ". - ." "." ". - . - . -")

Definiamo la funzione inversa che converte da una lista di codici morse ad una lista di caratteri:

(define (alfa2morse msg)
  (let (out '())
    (dolist (ch msg)
      (if (lookup ch morse-alfa)
          (push (lookup ch morse-alfa) out -1)
          (push "$$$" out -1)
      )
    )
    out
  )
)

(join (alfa2morse (morse2alfa msg)))
;-> "TESTO DA TRADURRE."

(setq msg {Testo "da tradurre})
(setq msg (upper-case msg))
(println (join (alfa2morse (morse2alfa msg))))
;-> "TESTO \"DA TRADURRE"
(println (join (alfa2morse (morse2alfa msg))))
;-> TESTO "DA TRADURRE


-------------------
PROBLEMA DI BABBAGE
-------------------

Qual è il più piccolo intero positivo il cui quadrato termina con le cifre 269.696?
Lettera di Charles Babbage a Lord Bowden, 1837.

Notiamo che solo i numeri che terminano con 4 o 6 posoono produrre un quadrato che ha il numero 6 come ultima cifra.

Inoltre risulta:

(sqrt 269696)
;-> 519.3226357477594

quindi qualsiasi numero inferiore a 520 produce un quadrato più piccolo di 269.696.
Allora, il numero più piccolo da provare vale 574.

(define (babbage)
  (catch
    (local (num quadrato)
      (setq num 524)
      (setq quadrato (* num num))
      (while true
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 2
        ; adesso il numero termina con la cifra 6
        (setq num (+ num 2))
        ; eleva il numero al quadrato
        (setq quadrato (* num num))
        ; controlla se è il numero cercato
        (if (= (slice (string quadrato) -6 6) "269696")
          ; numero trovato
          (throw (list num quadrato))
        )
        ; aumenta in numero di 8
        ; adesso il numero termina con la cifra 4
        (setq num (+ num 8))
      );while
    );local
  );catch
)

(babbage)
;-> (25264 638269696)

(time (babbage))
;-> 15.627


------------------
CIFRARIO DI CESARE
------------------

Il cifrario di Cesare è uno dei più antichi algoritmi crittografici conosciuti. È un cifrario a sostituzione monoalfabetica in cui ogni lettera del messaggio in chiaro è sostituita nel messaggio cifrato dalla lettera che si trova un certo numero di posizioni dopo (o prima) nell'alfabeto. La sostituzione avviene lettera per lettera, analizzando il testo dall'inizio alla fine.
Il cifrario prende il nome da Giulio Cesare, che lo utilizzava per proteggere i suoi messaggi segreti. Cesare utilizzava in genere una chiave di 3 per il cifrario. A quel tempo il metodo era sicuro perché la maggior parte della gente spesso non era neanche in grado di leggere.

Definiamo il nostro alfabeto:
(setq alfa (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di partenza:
(setq s1 alfa)
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")

Definiamo l'alfabeto di arrivo (con chiave 3):
(setq s2 (rotate (copy alfa) -3))
;-> ("D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "A" "B" "C")

Creiamo la lista di associazione tra le lettere in chiaro e le lettere cifrate:

(setq codice (transpose (list s1 s2)))
;-> (("A" "D") ("B" "E") ("C" "F") ("D" "G") ("E" "H") ("F" "I") ("G" "J")
;->  ("H" "K") ("I" "L") ("J" "M") ("K" "N") ("L" "O") ("M" "P") ("N" "Q")
;->  ("O" "R") ("P" "S") ("Q" "T") ("R" "U") ("S" "V") ("T" "W") ("U" "X")
;->  ("V" "Y") ("W" "Z") ("X" "A") ("Y" "B") ("Z" "C"))

Creiamo la lista di associazione tra le lettere cifrate e le lettere in chiaro:

(setq anticodice (transpose (list s2 s1)))
;-> (("D" "A") ("E" "B") ("F" "C") ("G" "D") ("H" "E") ("I" "F") ("J" "G")
;->  ("K" "H") ("L" "I") ("M" "J") ("N" "K") ("O" "L") ("P" "M") ("Q" "N")
;->  ("R" "O") ("S" "P") ("T" "Q") ("U" "R") ("V" "S") ("W" "T") ("X" "U")
;->  ("Y" "V") ("Z" "W") ("A" "X") ("B" "Y") ("C" "Z"))

Funzione di conversione da chiaro a cirato:

(define (chiaro-cifrato msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch codice)
          (push (lookup ch codice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(setq msg "Testo da tradurre")

(chiaro-cifrato msg)
;-> "WHVWR$GD$WUDGXUUH"

Funzione di conversione da cifrato a chiaro:

(define (cifrato-chiaro msg)
  (let (out '())
    (dolist (ch (explode (upper-case msg)))
      (if (lookup ch anticodice)
          (push (lookup ch anticodice) out -1)
          (push "$" out -1)
      )
    )
    (join out)
  )
)

(cifrato-chiaro "WHVWR$GD$WUDGXUUH")
;-> "TESTO$DA$TRADURRE"

Scriviamo una funzione generica che codifica e decodifica ed ha come parametro la chiave (numero):

(define (cesare msg tipo key)
  (local (s1 s2 codice anticodice)
    (setq out '())
    (setq s1 (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    (setq s2 (rotate (copy s1) (- key)))
    (setq codice (transpose (list s1 s2)))
    (setq anticodice (transpose (list s2 s1)))
    (cond ((= tipo 0)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch codice)
                  (push (lookup ch codice) out -1)
                  (push "$" out -1)
              )
           ))
          ((= tipo 1)
           (dolist (ch (explode (upper-case msg)))
              (if (lookup ch anticodice)
                  (push (lookup ch anticodice) out -1)
                  (push "$" out -1)
              )
           ))
          (true (println "tipo: 0 -> cifra, 1 -> decifra"))
    );cond
    (join out)
  ); local
)

(cesare "TESTO DA TRADURRE" 0 3)
;-> "WHVWR$GD$WUDGXUUH"

(cesare "WHVWR$GD$WUDGXUUH" 1 3)
;-> "TESTO$DA$TRADURRE"

(cesare "newLISP is great" 0 6)
;-> "TKCROYV$OY$MXKGZ"

(cesare "TKCROYV$OY$MXKGZ" 1 6)
;-> "newLISP$IS$GREAT"

(cesare "newLISP is great" 2 6)
;-> tipo: 0 -> cifra, 1 -> decifra


--------------------
CIFRARIO DI VIGENERE
--------------------

Il cifrario di Vigenère è il più semplice dei cifrari polialfabetici. Il metodo è una generalizzazione del cifrario di Cesare: invece di spostare la lettera da cifrare di un numero fisso di posti, questa viene spostata di un numero di posti variabile, determinato in base ad una parola chiave, che deve essere conosciuta sia dal mittente che dal destinatario. La chiave (detta anche "verme") deve essere ripetuta per tutta la lunghezza del messaggio.
Per esempio:

Testo in chiaro: RICERCARETESORO
Verme          : VERMEVERMEVERMEVE
Testo cifrato  : MMTQVXEIQXZWFDS

Il testo cifrato si ottiene spostando la lettera chiara di un numero fisso di caratteri, pari al numero ordinale della lettera corrispondente del verme. Di fatto si esegue una somma aritmetica tra l'ordinale dei caratteri in chiaro (A = 0, B = 1, C = 2...) e quello del verme. Superando l'ultima lettera, Z, si ricomincia dalla A, secondo la logica delle aritmetiche modulari.

Il vantaggio rispetto ai cifrari monoalfabetici (come il cifrario di Cesare) è dovuto al fatto che il testo è cifrato con n alfabeti cifranti. In questo modo, la stessa lettera viene cifrata (se ripetuta consecutivamente) n volte e questo rende più complessa la crittoanalisi del testo.

Possiamo usare una funzione matematica per la cifratura e la decifratura:

L = Lunghezza del cifrario = Numero caratteri alfabeto (26)

Numero prima lettera del cifrario "A" = 0

Numero ultima lettera del cifrario "Z" = 25

a = Numero della lettera della parola in Chiaro (0-25)

b = Numero della lettera della parola Chiave/Verme (0-25)

c = Numero della lettera della parola Cifrata (0-25)

Formula per cifrare/criptare: n = a + b (mod L)

Formula per decifrare/decriptare: n = c - b + L

r = floor(n / L)

x = n - ( L * r ) = Numero della lettera della parola in Chiaro/Cifrata (0-25)

La funzione si basa sulla somma/sottrazione dei numeri delle lettere e sulla divisione per la lunghezza del cifrario per ottenere il numero della lettera cercata. Per avere sempre un numero n positivo (anche per la decriptazione) basta aggiungere la lunghezza del cifrario L, in quanto verrà poi eliminata grazie al metodo con cui calcoliamo r.

Esempio di criptazione per il carattere "R":

L = 26
a[R] = 17
b[V] = 21
n = 17 + 21 = 38
r = 38 / 26 = 1,461... = 1
x = 38 - ( 26 * 1 ) = 38 - 26 = 12
lettera(12) = M

Esempio di decriptazione per il carattere "M":

L = 26
b[V] = 21
c[M] = 12
n = 12 - 21 + 26 = 17
r = 17 / 26 = 0,653... = 0
x = 17 - ( 26 * 0 ) = 17 - 0 = 17
lettera(17) = R

; messaggio in chiaro
(setq msg "RICERCARETESORO")
; costruzione il cifrario
(setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
(setq lettere (explode cifrario))
;-> ("A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M"
;->  "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z")
; liste di associazione lettera <--> numero
(setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
;-> (("A" 0) ("B" 1) ("C" 2) ("D" 3) ("E" 4) ("F" 5) ("G" 6)
;->  ("H" 7) ("I" 8) ("J" 9) ("K" 10) ("L" 11) ("M" 12) ("N" 13)
;->  ("O" 14) ("P" 15) ("Q" 16) ("R" 17) ("S" 18) ("T" 19) ("U" 20)
;->  ("V" 21) ("W" 22) ("X" 23) ("Y" 24) ("Z" 25))
(setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
;-> ((0 "A") (1 "B") (2 "C") (3 "D") (4 "E") (5 "F") (6 "G") (7 "H")
;->  (8 "I") (9 "J") (10 "K") (11 "L") (12 "M") (13 "N") (14 "O")
;->  (15 "P") (16 "Q") (17 "R") (18 "S") (19 "T") (20 "U") (21 "V")
;->  (22 "W") (23 "X") (24 "Y") (25 "Z"))
; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
(setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
;-> "VERMEVERMEVERME"
(setq L (length cifrario))
;-> 26

cifratura:

(dolist (el (explode msg))
  (setq a (lookup el char-num))
  (setq b (lookup (chiave $idx) char-num))
  ;(println a { } b)
  (setq n (% (+ a b) L))
  (setq r (/ n L))
  (setq x (- n (* L r)))
  ;(println n { } r { } x)
  (print (lookup x num-char))
)
;-> MMTQVXEIQXZWFDS

Adesso scriviamo le due funzioni di cifratura/decifratura tenendo conto dei caratteri del messaggio che non si trovano nel cifrario (alfabeto). Inoltre aggiungiamo uno spazio " " al nostro alfabeto.

Funzione di cifratura:

(define (vige-cifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq a (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println a { } b)
              (setq n (% (+ a b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "CIFRARIO DI VIGENERE")
(vige-cifra msg "VERME")
;-> "XMWCELMELHCDLUKZRVCI"

(define (vige-decifra msg verme)
  (local (cifrario lettere char-num num-char chiave L out)
    (setq out '())
    (setq msg (upper-case msg))
    (setq verme (upper-case verme))
    ; costruzione del cifrario
    (setq cifrario "ABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    (setq lettere (explode cifrario))
    ; liste di associazione lettera <--> numero
    (setq char-num (map (fn (x) (list x $idx)) (explode cifrario)))
    (setq num-char (map (fn (x) (list $idx x)) (explode cifrario)))
    ; la chiave è il valore del verme ripetuto per tutta la lunghezza del messaggio
    (setq chiave (slice (dup verme (+ (/ (length msg) (length verme)) 1)) 0 (length msg) 1))
    (setq L (length cifrario))
    ; ciclo di cifratura del messaggio
    (dolist (el (explode msg))
      ; controllo caratteri sconosciuti
      (cond ((or (nil? (lookup el char-num)) (nil? (lookup (chiave $idx) char-num)))
             (push "$" out -1)
            )
            (true
              (setq c (lookup el char-num))
              (setq b (lookup (chiave $idx) char-num))
              ;(println c { } b)
              (setq n (+ (- c b) L))
              (setq r (/ n L))
              (setq x (- n (* L r)))
              ;(println n { } r { } x)
              ;(print (lookup x num-char))
              (push (lookup x num-char) out -1)
            )
      );cond
    );dolist
    (join out)
  );local
)

(setq msg "XMWCELMELHCDLUKZRVCI")
(vige-decifra msg "VERME")
;-> "CIFRARIO DI VIGENERE"


---------
ANAGRAMMI
---------

Quando due o più parole sono composte dagli stessi caratteri, ma in un ordine diverso, vengono chiamate anagrammi.
Usando l'elenco di parole: http://wiki.puzzlers.org/pub/wordlists/unixdict.txt trovare l'insieme di anagrammi che ha il maggior numero di parole (elementi).

Leggiamo tutto il file in una stringa:
(setq datafile (read-file "unixdict1.txt"))

Trasformiamo questa stringa in una lista di stringhe delimitate dal carattere di fine linea (eol - end of line). La funzione "parse" fa proprio questo, suddivide una stringa in sottostringhe basandosi su un delimitatore (in windows il delimitatore di fine linea è "\r\n", mentre su UNIX è "\n"):

(setq data (parse datafile "\r\n"))

Se volessi convertire le stringhe in simboli:
(setq data (map sym data))
;-> (10th 1st 2nd 3rd 4th 5th 6th 7th 8th 9th a a&m a&p a's aaa aaas aarhus aaron aau
;->  aba ababa aback abacus abalone abandon abase abash abate abater abbas abbe abbey
;->  abbot abbott abbreviate abc abdicate abdomen abdominal abduct abe abed abel abelian
;->  abelson aberdeen abernathy aberrant aberrate abet)

Creazione di una lista ordinata in cui ogni elemento è formato dalla parola ordinata e dalla parola di partenza:
(setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
;-> (("&am" "a&m") ("&ap" "a&p") ("'as" "a's") ("01ht" "10th")
;->  ("1st" "1st") ("2dn" "2nd") ("3dr" "3rd") ("4ht" "4th")
;->  ("5ht" "5th") ("6ht" "6th") ("7ht" "7th") ("8ht" "8th")
;->  ("9ht" "9th") ("a" "a") ("aaa" "aaa") ("aaabb" "ababa")
;->  .......

Scriviamo una funzione che utilizza un metodo molto simile al Run-Length Encoding: raggruppa le parole che hanno lo stesso anagramma:

(define (rle lst)
  (local (palo conta ana out)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq ana '())
           (setq palo (first (first lst)))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              ; e aggiungiamo l'anagramma alla lista degli anagrammi
              (if (= (first el) palo)
                  (begin (++ conta)
                         (push (last el) ana -1)
                  )
                  ; altrimenti costruiamo la lista (conta ana)
                  ; poi la aggiungiamo al risultato
                  ; e azzeriamo le variabili
                  (begin (push conta ana)
                         (push ana out -1)
                         (setq conta 1)
                         (setq palo (first el))
                         (setq ana (rest el))
                  )
              )
           )
           ; aggiungiamo l'ultima coppia di valori al risultato
           (push conta ana)
           (push ana out -1)
          )
    )
    out
  )
)

(rle lst)
;-> ((1 "a&m") (1 "a&p") (1 "a's") (1 "10th") (1 "1st") (1 "2nd") (1 "3rd")
;->  (1 "4th") (1 "5th") (1 "6th") (1 "7th") (1 "8th") (1 "9th") (1 "a") (1 "aaa")
;->  .....

Quindi la soluzione è la seguente:

  (silent (setq datafile (read-file "unixdict.txt")))
  (silent (setq data (parse datafile "\n")))
  (silent (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data))))
  (silent (rle lst))
  (slice (sort (rle lst) >) 0 10)

Scriviamo la funzione:

(define (solveAna)
  (setq datafile (read-file "unixdict.txt"))
  (setq data (parse datafile "\n"))
  (setq lst (sort (map (fn (x) (list (join (sort (explode x))) x)) data)))
  (rle lst)
  (slice (sort (rle lst) >) 0 10)
)

(solveAna)
;-> ((5 "evil" "levi" "live" "veil" "vile")
;->  (5 "elan" "lane" "lean" "lena" "neal")
;->  (5 "caret" "carte" "cater" "crate" "trace")
;->  (5 "angel" "angle" "galen" "glean" "lange")
;->  (5 "alger" "glare" "lager" "large" "regal")
;->  (5 "abel" "able" "bale" "bela" "elba")
;->  (4 "resin" "rinse" "risen" "siren")
;->  (4 "pare" "pear" "rape" "reap")
;->  (4 "nepal" "panel" "penal" "plane")
;->  (4 "mate" "meat" "tame" "team"))

(time (solveAna))
;-> 265.205 ;la funzione è molto veloce.

Usando il file "60000_parole_italiane.txt" otteniamo:

(solveAna)
;-> ((9 "avresti" "restavi" "stivare" "svitare" "versati"
;->     "vestira" "viraste" "vistare" "vistera")
;->  (8 "riavesti" "stiverai" "sviterai" "vestiari" "vestirai"
;->     "visitare" "visitera" "visterai")
;->  (8 "aperti" "aprite" "pareti" "patrie" "perita"
;->     "pietra" "rapite" "ripeta")
;->  (7 "cernite" "cretine" "incerte" "recenti" "recinte" "tenerci" "trincee")
;->  (7 "cavero" "covare" "covera" "creavo" "recavo" "revoca" "vorace")
;->  (7 "argenti" "girante" "granite" "ingrate" "integra" "regnati" "ritenga")
;->  (6 "piastre" "prestai" "rapiste" "sparite" "sperati" "spirate")
;->  (6 "piastra" "rapasti" "raspati" "sparati" "sparita" "spirata")
;->  (6 "perso" "porse" "poser" "preso" "prose" "spero")
;->  (6 "parati" "patria" "pirata" "rapati" "rapita" "tarpai"))

Adesso scriviamo una funzione che controlla se due parole sono anagrammi l'una dell'altra:

(define (anagram? str1 str2)
  (if (or (null? str1) (null? str2)) nil
      (if (!= (length str1) (length str2)) nil
          (if (= (sort (explode str1)) (sort (explode str2)))
              true
              nil
          )
      )
  )
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 71.007

Se le parole utilizzano solo le lettere maiuscole, allora possiamo scrivere la funzione con un altro algoritmo:

(define (anagram? str1 str2)
  (local (vec ret)
    (if (or (null? str1) (null? str2)) (setq ret nil)
        (if (!= (length str1) (length str2)) (setq ret nil)
          (begin
            (setq ret true)
            (setq str1 (upper-case str1))
            (setq str2 (upper-case str2))
            (setq vec (array 26 '(0)))
            (dostring (ch str1) (++ (vec (- ch 65))))
            (dostring (ch str2) (-- (vec (- ch 65))))
            (while (and ret (< i (length str1)))
               (if (!= (vec i) 0) (setq ret nil))
               (++ i)
            )
          )
        )
    )
    ;(println vec)
    ret
  );local
)

(anagram? "pippo" "poppi")
;-> true

(anagram? "abcdefghi" "abcdefghij")
;-> nil

(anagram? "abcdefghi" "abcdefghj")
;-> nil

(time (anagram? "pippipappopoppi" "poppipappopippi") 10000)
;-> 73.007

Per finire vediamo due funzioni per generare tutti gli anagrammi di una parola.
Il primo dei due algoritmi è stato fornito da Sam Cox e funziona direttamente sulla stringa stessa. Sottosezioni ricorsive della stringa vengono esplose, ruotate e poi unite per formare una nuova stringa.

(define (anagrams s)
    (if (<= (length s) 1)
        (list s)
        (flat (map (fn (n) (aux (rotate-string s n)))
                          (sequence 1 (length s))))))

(define (aux rs)
    (map (fn (x) (append (first rs) x)) (anagrams (rest rs))))

(define (rotate-string s n)
    (join (rotate (explode s) n)))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

(time (anagrams "newLISP") 100)
;-> 1979.796

Il secondo algoritmo si basa su un algoritmo di permutazioni generalmente applicabile. La funzione permutazioni genera tutte le possibili permutazioni di offset nella stringa, quindi applica tali permutazioni.

(define (permutations lst)
  (if (= (length lst) 1)
   lst
   (apply append (map (fn (rot)
                      (map (fn (perm) (cons (first rot) perm))
                           (permutations (rest rot))))
                      (rotations lst)))))

(define (rotations lst)
  (map (fn (x) (rotate lst)) (sequence 1 (length lst))))

(define (anagrams str)
  (map (fn (perm) (select str perm))
       (permutations (sequence 0 (- (length str) 1)))))

(anagrams "lisp")
;-> ("psil" "psli" "pils" "pisl" "plsi" "plis" "silp" "sipl" "slpi"
;->  "slip" "spil" "spli" "ilps" "ilsp" "ipsl" "ipls" "islp" "ispl"
;->  "lpsi" "lpis" "lsip" "lspi" "lips" "lisp")

(time (anagrams "newLISP") 100)
;-> 1571.798

Nota: numero di anagrammi = fattoriale(numero di caratteri)


------------------
NUMERI PRIMI CUBAN
------------------

Il nome "cuban" non ha nulla a che fare con Cuba, ma ha a che fare con il fatto che i cubi (le terze potenze) hanno un ruolo nella sua definizione.

I primi cuban sono tutti i numeri primi p che soddisfano:

p = (x^3 - y^3)/(x - y),    dove x = y + 1

I numeri primi cuban sono stati nominati nel 1923 da Allan Joseph Champneys Cunningham.

La seguente funzione brute-force è abbastanza veloce per trovare i numeri primi cubani sotto a 10000:

(define (isprime? n)
  (if (< n 2) nil
    (if (= 1 (length (factor n))))))

(define (primi_cuban N)
  (local (cubani cubo1 cubo2 conta i diff)
    (setq cubani (array (+ N 1) '(0L)))
    (setq cubo1 1L)
    (setq conta 0)
    (setq i 1L)
    (catch
      (while true
        (setq cubo2 (* i i i))
        (setq diff (- cubo2 cubo1))
        (if (isprime? diff)
          (begin
            (if (<= conta N) (setf (cubani conta) diff))
            (if (= conta N) (throw nil))
            (++ conta)
          )
        )
        (setq cubo1 cubo2)
        (++ i)
      )
    );catch
    cubani
  );local
)

(primi_cuban 100)
;-> (7L 19L 37L 61L 127L 271L 331L 397L 547L 631L 919L 1657L 1801L 1951L 2269L 2437L
;->  2791L 3169L 3571L 4219L 4447L 5167L 5419L 6211L 7057L 7351L 8269L 9241L 10267L 11719L
;->  12097L 13267L 13669L 16651L 19441L 19927L 22447L 23497L 24571L 25117L 26227L 27361L
;->  33391L 35317L 42841L 45757L 47251L 49537L 50311L 55897L 59221L 60919L 65269L 70687L
;->  73477L 74419L 75367L 81181L 82171L 87211L 88237L 89269L 92401L 96661L 102121L 103231L
;->  104347L 110017L 112327L 114661L 115837L 126691L 129169L 131671L 135469L 140617L
;->  144541L 145861L 151201L 155269L 163567L 169219L 170647L 176419L 180811L 189757L
;->  200467L 202021L 213067L 231019L 234361L 241117L 246247L 251431L 260191L 263737L
;->  267307L 276337L 279991L 283669L 285517L)

(time (primi_cuban 1000))
;-> 46.869
(time (primi_cuban 5000))
;-> 922.045
(time (primi_cuban 10000))
;-> 3797.161
(time (primi_cuban 20000))
;-> 16017.151
(time (primi_cuban 30000))
;-> 37065.96
(time (primi_cuban 50000))
;-> 108592.154
(time (primi_cuban 100000))
;-> 455520.319


--------------
DATA DI PASQUA
--------------

Calcolo della data di pasqua per gli anni 1583 a 4099
La domenica di Pasqua è la domenica successiva alla luna piena Paschal (PFM).
Questo algoritmo è un'interpretazione aritmetica del metodo EDS "Easter Dating Method" sviluppato da Ron Mallen 1985.
Poichè i valori vengono ricavati in modo sequenziale da calcoli inter-dipendenti, non modificare l'ordine dei calcoli !
L'operatore / rappresenta la divisione intera, ad esempio: 30 / 7 = 4
Tutte le variabili sono tipi di dati interi.
Per maggiori informazioni: https://www.assa.org.au/edm

(define (pasqua y)
  (local (FirstDig Remain19 temp tA tB tC tD tD)
    (setq FirstDig (/ y 100)) ; prime 2 cifre anno
    (setq Remain19 (% y 19))   ; cifre restanti anno
    ;calcola data PFM
    (setq temp (+ (/ (- FirstDig 15) 2) 202 (- (* 11 Remain19))))
    (if (find FirstDig '(21 24 25 27 28 29 30 31 32 34 35 38))
      (setq temp (- temp 1))
    )
    (if (find FirstDig '(33 36 37 39 40))
      (setq temp (- temp 2))
    )
    (setq temp (% temp 30))
    (setq tA (+ temp 21))
    (if (= temp 29) (setq tA (- tA 1)))
    (if (and (= temp 28) (> Remain19 10)) (setq tA (- tA 1)))
    ; trova la domenica successiva
    (setq tB (% (- tA 19) 7))
    (setq tC (% (- 40 FirstDig) 4))
    (if (= tC 3) (setq tC (+ tC 1)))
    (if (> tC 1) (setq tC (+ tC 1)))
    (setq temp (% y 100))
    (setq tD (% (+ temp (/ temp 4)) 7))
    (setq tE (+ (% (- 20 tB tC tD) 7) 1))
    (setq d (+ tA tE))
    ;data
    (if (> d 31)
      (setq d (- d 31) m 4)
      (setq m 3)
    )
    (list d m y)
  );local
)

(pasqua 2000)
;-> (23 4 2000)

Definiamo una funzione che calcola tutte le domeniche di Pasqua partendo dall'anno x fino all'anno y:

(define (pasque x y)
  (for (i x y)
    (print (pasqua i) { })
    (if (= (% (+ (- i x) 1) 5) 0) (println { }))
  )
  'fine
)

(pasque 2020 2029)
;-> (12 4 2020) (4 4 2021) (17 4 2022) (9 4 2023) (31 3 2024)
;-> (20 4 2025) (5 4 2026) (28 3 2027) (16 4 2028) (1 4 2029)
;-> fine


-----------------
EQUAZIONE DI PELL
-----------------

L'equazione di Pell (detta anche equazione di Pell-Fermat) è un'equazione diofantina della forma:

x^2 - n*y^2 = 1

dove il parametro "n" è un numero intero positivo non quadrato.
L'equazione ha soluzioni intere per x e y.

Trovare la soluzione più piccola dell'equazione di Pell per n = 61, 109, 181, 277.

(define (Pell n)
  (local (z r x y e1 e2 f1 f2 A B t1 t2)
    (setq x (bigint (int (sqrt n))))
    (setq y x)
    (setq z 1L)
    (setq r (* x 2))
    (setq e1 1L e2 0L)
    (setq f1 0L f2 1L)
    (catch
      (while true
        (setq y (bigint (- (* r z) y)))
        (setq z (bigint (/ (- n (* y y)) z)))
        (setq r (bigint (/ (+ x y) z)))
        (setq t1 e1) (setq t2 e2)
        (setq e1 t2)
        (setq e2 (bigint (+ (* t2 r) t1)))
        (setq t1 f1) (setq t2 f2)
        (setq f1 t2)
        (setq f2 (bigint (+ (* t2 r) t1)))
        (setq A f2)
        (setq B e2)
        (setq t1 A) (setq t2 B)
        (setq B t1)
        (setq A (bigint (+ (* t1 x) t2)))
        (if (= (- (* A A) (* B B n)) 1) (throw (list A B)))
        ;(println (format "z = %s\nr = %s\nx = %s\ny = %s" (string z) (string r) (string x) (string y)))
        ;(println (format "e1 = %s\ne2 = %s\nf1 = %s\nf2 = %s" (string e1) (string e2) (string f1) (string f2)))
        ;(println (format "A = %s\nB = %s" (string A) (string B)))
        ;(read-line)
      );while
    );catch
  );local
)

(Pell 61)
;-> (1766319049L 226153980L)

(Pell 109)
;-> (158070671986249L 15140424455100L)

(Pell 181)
;-> (2469645423824185801L 183567298683461940L)

(Pell 277)
;-> (159150073798980475849L 9562401173878027020L)

Se passiamo un numero quadrato, otteniamo un errore:

(Pell 4)
;-> ERR: division by zero
;-> called from user function (Pell 4)

Troviamo le soluzione dell'equazione di Pell per n = [1..100].

(define (Pell100)
  (for (i 1 100)
    (if (= (sqrt i) (int (sqrt i))) (println i {:})
        (println i {:  }(Pell i))
    )
  )
)

(Pell100)
;-> 1:
;-> 2:  (3L 2L)
;-> 3:  (2L 1L)
;-> 4:
;-> 5:  (9L 4L)
;-> 6:  (5L 2L)
;-> 7:  (8L 3L)
;-> 8:  (3L 1L)
;-> 9:
;-> 10:  (19L 6L)
;-> 11:  (10L 3L)
;-> 12:  (7L 2L)
;-> 13:  (649L 180L)
;-> 14:  (15L 4L)
;-> 15:  (4L 1L)
;-> 16:
;-> 17:  (33L 8L)
;-> 18:  (17L 4L)
;-> 19:  (170L 39L)
;-> 20:  (9L 2L)
;-> 21:  (55L 12L)
;-> 22:  (197L 42L)
;-> 23:  (24L 5L)
;-> 24:  (5L 1L)
;-> 25:
;-> 26:  (51L 10L)
;-> 27:  (26L 5L)
;-> 28:  (127L 24L)
;-> 29:  (9801L 1820L)
;-> 30:  (11L 2L)
;-> 31:  (1520L 273L)
;-> 32:  (17L 3L)
;-> 33:  (23L 4L)
;-> 34:  (35L 6L)
;-> 35:  (6L 1L)
;-> 36:
;-> 37:  (73L 12L)
;-> 38:  (37L 6L)
;-> 39:  (25L 4L)
;-> 40:  (19L 3L)
;-> 41:  (2049L 320L)
;-> 42:  (13L 2L)
;-> 43:  (3482L 531L)
;-> 44:  (199L 30L)
;-> 45:  (161L 24L)
;-> 46:  (24335L 3588L)
;-> 47:  (48L 7L)
;-> 48:  (7L 1L)
;-> 49:
;-> 50:  (99L 14L)
;-> 51:  (50L 7L)
;-> 52:  (649L 90L)
;-> 53:  (66249L 9100L)
;-> 54:  (485L 66L)
;-> 55:  (89L 12L)
;-> 56:  (15L 2L)
;-> 57:  (151L 20L)
;-> 58:  (19603L 2574L)
;-> 59:  (530L 69L)
;-> 60:  (31L 4L)
;-> 61:  (1766319049L 226153980L)
;-> 62:  (63L 8L)
;-> 63:  (8L 1L)
;-> 64:
;-> 65:  (129L 16L)
;-> 66:  (65L 8L)
;-> 67:  (48842L 5967L)
;-> 68:  (33L 4L)
;-> 69:  (7775L 936L)
;-> 70:  (251L 30L)
;-> 71:  (3480L 413L)
;-> 72:  (17L 2L)
;-> 73:  (2281249L 267000L)
;-> 74:  (3699L 430L)
;-> 75:  (26L 3L)
;-> 76:  (57799L 6630L)
;-> 77:  (351L 40L)
;-> 78:  (53L 6L)
;-> 79:  (80L 9L)
;-> 80:  (9L 1L)
;-> 81:
;-> 82:  (163L 18L)
;-> 83:  (82L 9L)
;-> 84:  (55L 6L)
;-> 85:  (285769L 30996L)
;-> 86:  (10405L 1122L)
;-> 87:  (28L 3L)
;-> 88:  (197L 21L)
;-> 89:  (500001L 53000L)
;-> 90:  (19L 2L)
;-> 91:  (1574L 165L)
;-> 92:  (1151L 120L)
;-> 93:  (12151L 1260L)
;-> 94:  (2143295L 221064L)
;-> 95:  (39L 4L)
;-> 96:  (49L 5L)
;-> 97:  (62809633L 6377352L)
;-> 98:  (99L 10L)
;-> 99:  (10L 1L)
;-> 100:


----------------------------
PUNTEGGIO NUMERICO (RANKING)
----------------------------

Il punteggio numerico dei concorrenti (ranking) mostra se uno è migliore, uguale o peggiore di un altro in base ai risultati ottenuti in una  o più competizioni.
Il punteggio numerico di un concorrente può essere assegnato in diversi modi:

1) Ordinale (I concorrenti prendono il successivo numero intero disponibile. I punteggi uguali non sono trattati diversamente).

2) Standard (I punteggi uguali condividono quello che sarebbe stato il loro primo numero ordinale).

3) Denso (I punteggi uguali condividono il successivo numero intero disponibile).

4) Modificato (I punteggi uguali condividono quello che sarebbe stato il loro ultimo numero ordinale).

5) Frazionale (I punteggi uguali condividono la media di quello che sarebbe stato il loro numero ordinale)

Scrivere una funzione per ognuno dei cinque metodi di calcolo elencati.

Lista di concorrenti e relativi risultati:

44 Solomon
42 Jason
42 Errol
41 Garry
41 Bernard
41 Barry
39 Stephen

Tipi di punteggi:

Ordinal Ranking    Standard Ranking    Dense Ranking
---------------    ----------------    -------------
1  44  Solomon     1  44  Solomon      1  44  Solomon
2  42  Jason       2  42  Jason        2  42  Jason
3  42  Errol       2  42  Errol        2  42  Errol
4  41  Garry       4  41  Garry        3  41  Garry
5  41  Bernard     4  41  Bernard      3  41  Bernard
6  41  Barry       4  41  Barry        3  41  Barry
7  39  Stephen     7  39  Stephen      4  39  Stephen

Modified Ranking   Fractional Ranking
----------------   ------------------
1  44  Solomon     1.0  44  Solomon
3  42  Jason       2.5  42  Jason
3  42  Errol       2.5  42  Errol
6  41  Garry       5.0  41  Garry
6  41  Bernard     5.0  41  Bernard
6  41  Barry       5.0  41  Barry
7  39  Stephen     7.0  39  Stephen

Definiamo una lista che contiene i concorrenti e i relativi risultati:

(setq lst '((44 Solomon) (42 Jason) (42 Errol) (41 Garry) (41 Bernard) (41 Barry) (39 Stephen)))

(define (ordinal-rank lst)
  (println "Ordinal rank")
  (for (i 0 (- (length lst) 1))
    (println (format "%d  %d  %s" (+ i 1) (first (lst i)) (string (last (lst i)))))
  )
  'fine)

(ordinal-rank lst)
;-> Ordinal rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 5  41  Bernard
;-> 6  41  Barry
;-> 7  39  Stephen

(define (standard-rank lst)
  (let (j 1)
    (println "Standard rank")
    (for (i 0 (- (length lst) 2))
      (println (format "%d  %d  %s" j (first (lst i)) (string (last (lst i)))))
      (if (< (first (lst (+ i 1))) (first (lst i)))
        (setq j (+ i 2))
      )
    )
    (println (format "%d  %d  %s" j (first (last lst)) (string (last (last lst)))))
  )
  'fine)

(standard-rank lst)
;-> Standard rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 2  42  Errol
;-> 4  41  Garry
;-> 4  41  Bernard
;-> 4  41  Barry
;-> 7  39  Stephen

(define (dense-rank lst)
  (let (j 1)
    (println "Dense rank")
    (for (i 0 (- (length lst) 2))
      (println (format "%d  %d  %s" j (first (lst i)) (string (last (lst i)))))
      (if (< (first (lst (+ i 1))) (first (lst i)))
        (++ j)
      )
    )
    (println (format "%d  %d  %s" j (first (last lst)) (string (last (last lst)))))
  )
  'fine)

(dense-rank lst)
;-> Dense rank
;-> 1  44  Solomon
;-> 2  42  Jason
;-> 2  42  Errol
;-> 3  41  Garry
;-> 3  41  Bernard
;-> 3  41  Barry
;-> 4  39  Stephen

Proviamo con una diversa lista relativi risultati:

44 Solomon
44 Jason
42 Errol
41 Garry
41 Bernard
39 Barry
39 Stephen

(setq lst '((44 Solomon) (44 Jason) (42 Errol) (41 Garry) (41 Bernard) (39 Barry) (39 Stephen)))

(ordinal-rank lst)
;-> Ordinal rank
;-> 1  44  Solomon
;-> 2  44  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 5  41  Bernard
;-> 6  39  Barry
;-> 7  39  Stephen

(standard-rank lst)
;-> Standard rank
;-> 1  44  Solomon
;-> 1  44  Jason
;-> 3  42  Errol
;-> 4  41  Garry
;-> 4  41  Bernard
;-> 6  39  Barry
;-> 6  39  Stephen

(dense-rank lst)
Dense rank
;-> 1  44  Solomon
;-> 1  44  Jason
;-> 2  42  Errol
;-> 3  41  Garry
;-> 3  41  Bernard
;-> 4  39  Barry
;-> 4  39  Stephen


-----------------
LEGGE DI BENDFORD
-----------------

La legge di Benford, chiamata anche legge della prima cifra, si riferisce alla distribuzione di frequenza delle cifre in molte (ma non tutte) fonti di dati reali.

In questa distribuzione, il numero 1 si presenta come la prima cifra circa il 30% delle volte, mentre i numeri più grandi si verificano in quella posizione meno frequentemente: 9 come prima cifra meno del 5% delle volte. Questa distribuzione delle prime cifre è uguale alle larghezze di una griglia con scala logaritmica.

La legge di Benford riguarda anche la distribuzione prevista per cifre oltre la prima, che si avvicina ad una distribuzione uniforme.

È stato riscontrato che questo risultato si applica a un'ampia varietà di set di dati, tra cui bollette elettriche, indirizzi stradali, quotazioni azionarie, numero di abitanti, tassi di mortalità, lunghezze dei fiumi, costanti fisiche e matematiche e processi descritti dalle leggi di potenza (che sono molto comune in natura). Tende ad essere più preciso quando i valori sono distribuiti su più ordini di grandezza.

Si dice che una serie di numeri soddisfa la legge di Benford se le cifre iniziali (1..9) si verificano con probabilità:

P(d) = log10(d + 1) - log10(d) = log10(1 + 1/d)

(define (P)
  (let (out '())
    (for (i 1 9)
      (push (mul 100 (log (add 1 (div 1 i)) 10)) out -1)
    )
  )
)

(setq bend (P))
;-> (30.10299956639812 17.60912590556812  12.49387366082999
;->   9.69100130080564  7.918124604762481  6.694678963061322
;->   5.799194697768673 5.115252244738128  4.575749056067514)

Scriviamo una funzione per calcolare la distribuzione delle prime cifre significative (non zero) in un insieme di numeri, quindi confrontare la distribuzione effettiva rispetto a quella attesa (cioè quella di Bendford). La funzione ha come parametro il nome del file che contiene l'insieme dei numeri.

Come primo esempio utilizziamo come insieme di dati i primi 1000 numeri di fibonacci.
Scriviamo una funzione che crea un file di testo con i primi 1000 numeri di fibonacci.

Funzione che calcola il numero di fibonacci di un numero n:

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- n 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

Funzione che crea un file con n numeri di Fibonacci (un numero per ogni riga).

(define (fibfile file n)
  (local (outfile)
    (setq outfile (open file "write"))
    (for (i 1 n)
      (write-line outfile (string (fibo-i i)))
    )
    (close outfile)
  )
)

(fibfile "fibo1000.txt" 1000)
;-> true

Adesso scriviamo la funzione per verificare la legge di Bendford. La prima versione della funzione crea il vettore con le frequenze:

(define (bendford file)
  (local (infile val data)
    (setq data (array 10 '(0)))
    ; leggiamo i numeri dal file
    (setq infile (open file "read"))
    (while (read-line infile)
      ; (current-line) restituisce una stringa
      (setq val (int ((current-line) 0)))
      ;aggiorniamo il vettore delle frequenze
      (++ (data val))
    )
    (close infile)
     data
  )
)

(setq out (bendford "fibo1000.txt"))
;-> (0 301 177 125 96 80 67 56 53 45)

Verifichiamo il risultato:
(apply + out)
;-> 1000

Adesso scriviamo la versione finale:

(define (bendford file)
  (local (infile val data dataB perc-freq-reali perc-freq-attese)
    (setq data (array 10 '(0)))
    ; leggiamo i numeri dal file
    (setq infile (open file "read"))
    (while (read-line infile)
      ; (current-line) restituisce una stringa
      (setq val (int ((current-line) 0)))
      ;aggiorniamo il vettore delle frequenze
      (++ (data val))
    )
    (close infile)
    (setq data (array-list data))
    ; calcoliamo le percentuali delle frequenze reali
    (setq somma (apply add data))
    (setq perc-freq-reali (map (fn (x) (mul 100 (div x somma))) data))
    ;(println perc-freq-reali)
    ; calcoliamo le percentuali delle frequenze attese (Bendford)
    (setq perc-freq-attese '(0))
    (for (i 1 9)
      (push (mul 100 (log (add 1 (div 1 i)) 10)) perc-freq-attese -1)
    )
    ;(println perc-freq-attese)
    ;calcoliamo la differenza tra le due percentuali di ogni cifra
    (setq diff (map sub perc-freq-attese perc-freq-reali))
    ;stampiamo i risultati
    (println {     %att     %real     diff})
    (for (i 1 9)
      (println (format "%d %8.2f %8.2f %+8.2f"
               i (perc-freq-attese i) (perc-freq-reali i) (diff i)))
    )
    '-----------------------------
  )
)

(bendford "fibo1000.txt")
     %att     %real     diff
1    30.10    30.10    +0.00
2    17.61    17.70    -0.09
3    12.49    12.50    -0.01
4     9.69     9.60    +0.09
5     7.92     8.00    -0.08
6     6.69     6.70    -0.01
7     5.80     5.60    +0.20
8     5.12     5.30    -0.18
9     4.58     4.50    +0.08
-----------------------------

I primi 1000 numeri di Fibonacci rispettano la legge di Bendford.

Proviamo con un altro insieme di dati: i numeri primi.

(bendford "primi5000.txt")
;->      %att     %real     diff
;-> 1    30.10    23.86    +6.24
;-> 2    17.61    22.58    -4.97
;-> 3    12.49    21.94    -9.45
;-> 4     9.69    18.72    -9.03
;-> 5     7.92     2.62    +5.30
;-> 6     6.69     2.70    +3.99
;-> 7     5.80     2.50    +3.30
;-> 8     5.12     2.54    +2.58
;-> 9     4.58     2.54    +2.04
;-> -----------------------------

I primi 5000 numeri Primi non sembra che rispettino la legge di Bendford.

Proviamo con un altro insieme di dati: 10000 cifre decimali di pi greco.

(bendford "pigreco10000.txt")
;->      %att     %real     diff
;-> 1    30.10    10.26   +19.84
;-> 2    17.61    10.21    +7.40
;-> 3    12.49     9.74    +2.75
;-> 4     9.69    10.12    -0.43
;-> 5     7.92    10.46    -2.54
;-> 6     6.69    10.21    -3.52
;-> 7     5.80     9.70    -3.90
;-> 8     5.12     9.48    -4.36
;-> 9     4.58    10.14    -5.56
;-> -----------------------------

Le prime 10000 cifre decimali di pi greco non sembra che rispettino la legge di Bendford.

Proviamo con i primi 100000 numeri.

(define (numeri file n)
  (local (outfile)
    (setq outfile (open file "write"))
    (for (i 1 n)
      (write-line outfile (string i))
    )
    (close outfile)
  )
)

(numeri "numeri100000.txt" 100000)
;-> true

(bendford "numeri100000.txt")
;->      %att     %real     diff
;-> 1    30.10    11.11   +18.99
;-> 2    17.61    11.11    +6.50
;-> 3    12.49    11.11    +1.38
;-> 4     9.69    11.11    -1.42
;-> 5     7.92    11.11    -3.19
;-> 6     6.69    11.11    -4.42
;-> 7     5.80    11.11    -5.31
;-> 8     5.12    11.11    -6.00
;-> 9     4.58    11.11    -6.54
;-> -----------------------------

Le prime cifre dei numeri naturali hanno una distribuzione uniforme.

Proviamo con un altro insieme di dati: la lunghezza dei fiumi italiani (6226).

(bendford "fiumi.txt")
;->      %att     %real     diff
;-> 1    30.10    26.10    +4.00
;-> 2    17.61    12.19    +5.42
;-> 3    12.49    11.05    +1.44
;-> 4     9.69    11.84    -2.15
;-> 5     7.92    10.62    -2.70
;-> 6     6.69     8.79    -2.09
;-> 7     5.80     7.65    -1.85
;-> 8     5.12     6.73    -1.61
;-> 9     4.58     5.04    -0.47
;-> -----------------------------

Le lunghezze dei fiumi seguono abbastanza la legge di Bendford.


----------
CALENDARIO
----------

Unix e Linux hanno il comando "cal" per stampare il calendario corrente. Un programma ancora più completo è GNU "gcal" (con alcune funzionalità esoteriche). Per windows non esiste niente di simile, allora scriviamo una funzione che stampa il calendario dell'anno corrente o di un'anno definito (anno > 1752).
Ci servono due funzioni ausiliarie, una per il calcolo del giorno della settimana a partire da una data e un'altra per calcolare se un anno è bisestile.

Giorno della settimana

(define (giorno year month day) ; 0..6 --> Domenica..Sabato
  (local (t d)
    (setq t '(0 3 2 5 0 3 5 1 4 6 2 4))
    (if (< month 3) (-- year))
    (setq d (% (add year (/ year 4) (/ (- year) 100) (/ year 400) (t (- month 1)) day) 7))
  )
)

(giorno 2019 7 17)
;-> 3

Anno bisestile

(define (leap? year)
  (cond ((= (% year 400) 0) true) ; divisibile per 400
        ((= (% year 100) 0) nil)  ; divisibile per 100, ma non per 400
        ((= (% year 4) 0) true)   ; divisibile per 4, ma non per 100 e 400
        (true nil)                ; non divisibile per 4 o 100 o 400
  )
)

(leap? 1900)
;-> nil

La funzione integrata "now" fornisce le seguenti informazioni:

(now)
;-> (2019 7 18 8 15 43 236522 199 4 120 2)

Ecco il significato dei numeri interi (11) restituiti dalla funzione "now":

Descrizione                       Valore

 1) year                          Gregorian calendar
 2) month                         (1–12)
 3) day                           (1–31)
 4) hour                          (0–23) UTC
 5) minute                        (0–59)
 6) second                        (0–59)
 7) microsecond                   (0–999999) OS-specific, millisecond resolution
 8) day of current year           Jan 1st is 1
 9) day of current week           (1–7) starting Monday
10) time zone offset in minutes   west of GMT including daylight savings bias
11) daylight savings time type    (0–6) on Linux/Unix or (0–2) on MS Windows

(define (cal anno)
  (local (startNum startNum day month numDays pad)
    (setq day '((1 Lunedi) (2 Martedi) (3 Mercoledi) (4 Giovedi) (5 Venerdi) (6 Sabato) (7 Domenica)))
    (setq month '((GENNAIO 31) (FEBBRAIO 28) (MARZO 31) (APRILE 30) (MAGGIO 31) (GIUGNO 30)
      (LUGLIO 31) (AGOSTO 31) (SETTEMBRE 30) (OTTOBRE 31) (NOVEMBRE 30) (DICEMBRE 31)))
    (if (or (= anno nil) (<= anno 1752)) (setq anno (first (now))))
    ; if (anno < 1753) then anno = (first (now))
    ; primo giorno dell'anno (numero)
    (setq startNum (giorno anno 1 1))
    ; (1: lunedi ... 7: domenica)
    (if (= startNum 0) (setq startNum 7))
    (setq startDay (lookup startNum day))
    ; anno bisestile?
    (if (leap? anno) (setf (last (month 1)) 29))
    ; stampa anno
    (println (format "\n%d\n" anno))
    (setq ultimo startNum)
    (for (i 0 11)
      ; stampa mese
      ;(println (format "%s" (first (month i))))
      (println (first (month i)))
      ; stampa intestazione giorni
      (println "Lu Ma Me Gi Ve Sa Do")
      ; calcola e stampa lo spazio di inizio del primo giorno
      (setq pad (dup " " (* (- ultimo 1) 3)))
      (print pad)
      ; giorni del mese
      (setq numDays (lookup (first (month i)) month))
      (for (j 1 numDays)
        (print (format "%2d " j))
        ; se il giorno è Domenica (e non è l'ultimo del mese), allora andiamo a capo
        (if (and (= (giorno anno (+ i 1) j) 0) (!= j numDays))  (println { }))
      )
      ; ultimo giorno stampato
      (setq ultimo (+ 1 (giorno anno (+ i 1) (lookup (first (month i)) month))))
      (println "\n")
    )
    '--------------------
  )
)

(cal 2020)

2020

GENNAIO                FEBBRAIO               MARZO
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                   1  2                      1
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    2  3  4  5  6  7  8
13 14 15 16 17 18 19   10 11 12 13 14 15 16    9 10 11 12 13 14 15
20 21 22 23 24 25 26   17 18 19 20 21 22 23   16 17 18 19 20 21 22
27 28 29 30 31         24 25 26 27 28 29      23 24 25 26 27 28 29
                                              30 31

APRILE                 MAGGIO                 GIUGNO
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                1  2  3    1  2  3  4  5  6  7
 6  7  8  9 10 11 12    4  5  6  7  8  9 10    8  9 10 11 12 13 14
13 14 15 16 17 18 19   11 12 13 14 15 16 17   15 16 17 18 19 20 21
20 21 22 23 24 25 26   18 19 20 21 22 23 24   22 23 24 25 26 27 28
27 28 29 30            25 26 27 28 29 30 31   29 30

LUGLIO                 AGOSTO                 SETTEMBRE
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
       1  2  3  4  5                   1  2       1  2  3  4  5  6
 6  7  8  9 10 11 12    3  4  5  6  7  8  9    7  8  9 10 11 12 13
13 14 15 16 17 18 19   10 11 12 13 14 15 16   14 15 16 17 18 19 20
20 21 22 23 24 25 26   17 18 19 20 21 22 23   21 22 23 24 25 26 27
27 28 29 30 31         24 25 26 27 28 29 30   28 29 30
                       31

OTTOBRE                NOVEMBRE               DICEMBRE
Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do   Lu Ma Me Gi Ve Sa Do
          1  2  3  4                      1       1  2  3  4  5  6
 5  6  7  8  9 10 11    2  3  4  5  6  7  8    7  8  9 10 11 12 13
12 13 14 15 16 17 18    9 10 11 12 13 14 15   14 15 16 17 18 19 20
19 20 21 22 23 24 25   16 17 18 19 20 21 22   21 22 23 24 25 26 27
26 27 28 29 30 31      23 24 25 26 27 28 29   28 29 30 31
                       30

Nota: L'output della funzione stampa tutti i mesi uno di seguito all'altro.


--------------
CARTE DA GIOCO
--------------

Crea una struttura dati e le funzioni associate per definire e manipolare un mazzo di carte da gioco.
Il mazzo dovrebbe contenere 54 carte uniche.

Le funzioni devono includere la capacità di:

1) crea un nuovo mazzo
2) mischiare il mazzo (shuffle)
3) Estrarre una carta dal mazzo
4) Stampare il contenuto del mazzo

Ogni carta deve avere un valore e un seme che costituiscono il codice univoco della carta.

Per chi ha i caratteri utf-8 può usare la definizione seguente:

(setq semi '("♥" "♦" "♣" "♠"))

Definiamo una funzione che crea un mazzo di carte:

(define (crea-carte)
  (local (semi numeri indice carte)
    ; definiamo i semi delle carte
    (setq semi '(Cuori Quadri Fiori Picche))
    ; definiamo i numeri delle carte
    (setq numeri '(Asso Due Tre Quattro Cinque Sei Sette Otto Nove Dieci Jack Donna Re))
    ; creiamo il mazzo di carte: (1 (Asso Cuori)) (2 (Due Cuori)) ...
    (setq carte '())
    (setq indice 0)
    (dolist (seme semi)
      (push (map (fn (x) (list (+ $idx 1 indice) (list x seme))) numeri) carte -1)
      (++ indice 13)
    )
    ; togliamo un livello alla lista carte (da 4 elementi passa a 52 elementi)
    (setq carte (flat carte 1))
    ; aggiungiamo i Jolly (le matte)
    (push '(53 (Matta Jolly)) carte -1)
    (push '(54 (Matta Jolly)) carte -1)
    carte
  )
)

(setq mazzo (crea-carte))
;-> ((1 (Asso Cuori)) (2 (Due Cuori)) (3 (Tre Cuori)) (4 (Quattro Cuori))
;->  (5 (Cinque Cuori)) ...
;->  ...
;->  (51 (Donna Picche)) (52 (Re Picche)) (53 (Matta Jolly)) (54 (Matta Jolly)))

Definiamo una funzione che mischia le carte:

(define (mischia mazzo)
  (seed (time-of-day))
  (randomize mazzo)
)

(setq partita (mischia mazzo))
;-> ((34 (Otto Fiori)) (30 (Quattro Fiori)) (26 (Re Quadri))...
;->  ... (21 (Otto Quadri)) (37 (Jack Fiori)))

Per la funzione di estrazione possiamo usare la funzione integrata "pop" estraendo la prima carta del mazzo:

(define (estrai mazzo) (pop mazzo))

Però qualcosa non funziona:

(length partita)
;-> 54

(estrai partita)
;-> (34 (Otto Fiori))

(length partita)
;-> 54

Abbiamo estratto la prima carta, ma non è stata eliminata dal mazzo perchè alla funzione estrai viene passata una copia del mazzo "partita".
Per risolvere il problema definiamo un mazzo come contesto, in questo modo newLISP passa la variabile definita per riferimento.

(setq p:p (mischia mazzo))
;-> ((26 (Re Quadri)) (12 (Donna Cuori)) ...
;->  ... (9 (Nove Cuori)) (43 (Quattro Picche)))

Vediamo se funziona:

(length p)
;-> 54

(estrai p)
;-> (26 (Re Quadri))

(length p)
;-> 53

Sembra che vada tutto bene. Senza utilizzare i contesti avremmo dovuto applicare la funzione "pop" direttamente sulla variabile mazzo.

Infine definiamo una funzione che stampa le carte del mazzo:

(define (stampa-tutto mazzo)
  (dolist (carta mazzo)
    (print (format "%18s" (string (last carta))))
    (if (= (% (+ $idx 1) 4) 0) (println))
  )
)

(stampa-tutto partita)
;->   (Otto Quadri)     (Matta Jolly)      (Tre Picche)     (Donna Fiori)
;->   (Otto Picche)   (Cinque Picche)       (Sei Fiori)        (Re Fiori)
;->    (Otto Fiori)     (Matta Jolly)     (Jack Picche)   (Quattro Fiori)
;->     (Sei Cuori)        (Re Cuori)     (Sette Cuori)       (Due Cuori)
;->  (Sette Picche)      (Nove Cuori)     (Dieci Cuori)       (Due Fiori)
;->     (Re Picche)     (Nove Quadri)      (Sei Quadri)       (Tre Cuori)
;->   (Asso Picche)     (Sette Fiori)      (Sei Picche)    (Sette Quadri)
;->   (Donna Cuori)     (Jack Quadri)    (Cinque Fiori)      (Jack Cuori)
;->     (Tre Fiori)    (Cinque Cuori)      (Otto Cuori)    (Donna Picche)
;->    (Jack Fiori)       (Re Quadri)      (Asso Cuori)      (Nove Fiori)
;-> (Cinque Quadri)  (Quattro Quadri)  (Quattro Picche)    (Donna Quadri)
;->    (Due Picche)    (Dieci Picche)      (Tre Quadri)     (Dieci Fiori)
;->    (Asso Fiori)     (Asso Quadri)    (Dieci Quadri)     (Nove Picche)
;-> (Quattro Cuori)      (Due Quadri)


----------------------
GENERATORE DI PASSWORD
----------------------

Creare un programma per la generazione di password contenenti caratteri ASCII casuali dai seguenti gruppi:
lettere minuscole:  (a..z)
lettere maiuscole:  (A..Z)
cifre numeriche:    (0..9)
caratteri speciali: (# ! $ % & ( ) * + , - . / : ; < = > ? @ [ ] ^ _ { | } ~)

Le password generate devono includere almeno un carattere di ciascuno dei seguenti quattro gruppi):

1) lettera minuscola,
2) lettera maiuscola,
3) cifra numerica,
4) carattere speciale

La funzione ha come parametri la lunghezza della password e il numero di password da generare.

La funzione deve anche escludere la creazione di password con i seguenti caratteri visualmente simili:

1) Il lI
2) 1l l1
3) 1I I1
4) O0 0O
5) 5S S5
6) Z2 2Z

(define (gen-pwd num lun stampa)
  (local (pwd g g0 g1 g2 g3 gv out)
    (cond ((or (< num 1) (< lun 4)) (setq out nil) (println "parametri errati"))
          (true
            ; inizializza il generatore random
            (seed (time-of-day))
            (setq out '())
            (setq g0 (explode "abcdefghijklmnopqrstuvwxyz"))
            (setq g1 (explode "ABCDEFGHIJKLMNOPQRSTUVWXYZ"))
            (setq g2 (explode "0123456789"))
            (setq g3 (explode "#!$%&()*+,-./:;<=>?@[]^_{|}~"))
            ; ciclo numero di password
            (for (i 1 num)
              (setq pwd '())
              ; aggiungiamo un carattere per ogni gruppo
              (push (g0 (rand 26)) pwd -1)
              (push (g1 (rand 26)) pwd -1)
              (push (g2 (rand 10)) pwd -1)
              (push (g3 (rand 28)) pwd -1)
              ; ciclo genera password di lunghezza lun
              (if (> lun 4)
                (begin
                  (for (j 1 (- lun 4))
                    (setq g (rand 4))
                    (if (= g 0) (push (g0 (rand 26)) pwd -1)
                      (if (= g 1) (push (g1 (rand 26)) pwd -1)
                        (if (= g 2) (push (g2 (rand 10)) pwd -1)
                          (if (= g 3) (push (g3 (rand 28)) pwd -1)))))
                  )
                )
              )
              ; randomize per mischiare i caratteri
              ; soprattuto per i primi quattro che altrimenti
              ; seguirebbero una regola fissa
              (setq pwd (join (randomize pwd)))
              ; controllo caratteri visualmente simili
              ; (Il lI) (1l l1) (1I I1) (O0 0O) (5S S5) (Z2 2Z)
              (if (setq idx (find "Il" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "ll" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "1l" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "l1" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "1I" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "I1" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "0O" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "O0" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "5S" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "S5" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "Z2" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if (setq idx (find "2Z" pwd)) (setq (pwd idx) (g3 (rand 28))))
              (if stampa (println pwd))
              (push pwd out -1)
            );for
          );true
    );cond
    out
  );local
)

(gen-pwd 2 8)
;-> ("BPT=v+8s" "M&I9^o0L")

(gen-pwd 1 3)
;-> parametri errati
;-> nil

(gen-pwd 1 4)
;-> ("M5}g")

(gen-pwd 6 12)
;-> ("Jrfh.F2~uEtd" "ljR8[=3VYoSH" "|0J4u^4dv0{9"
;->  "87HFP;{u6ini" "M3w|1:4],G4m" "3@LH5Q*E00mv")

Funzione che controlla la presenza di caratteri visualmente simili:

(define (test pwd)
  (for (i 1 100000)
    (setq pwd (first (gen-pwd 1 21)))
    (if (or (find "Il" pwd) (find "ll" pwd) (find "1l" pwd)
            (find "l1" pwd) (find "1I" pwd) (find "I1" pwd)
            (find "0O" pwd) (find "O0" pwd) (find "5S" pwd)
            (find "S5" pwd) (find "Z2" pwd) (find "2Z" pwd))
        (println pwd)
    )
  )
)

(test pwd)
;-> nil


-------------------
CALCOLO DI PI GRECO
-------------------

Pi greco è un numero irrazionale (cioè non può essere il rapporto di due numeri interi) e trascendente (cioè non è una radice di un polinomio con coefficienti razionali.

Pi greco vale: 3.141592653589793238462643383279502884197169399375105820974....

I matematici hanno trovato differenti serie matematiche che, se calcolate sommando un numero infinito di termini, generano un'approssimazione sufficientemente accurata di pi greco per un numero abbastanza grande di decimali.
Alcune di esse sono talmente complesse da richiedere dei supercomputer per calcolarle.
Vediamo alcuni algoritmi per il calcolo del numero pigreco.
Uno dei più semplici è l'algoritmo basato sulla serie di Gregory-Leibniz. Anche se non è molto efficiente, genera un numero sempre più vicino a pi greco ad ogni iterazione, arrivando ad una approssimazione sufficientemente accurata con 10 cifre decimali con 500.000 iterazioni.

Serie di Gregory-Leibniz:

Pi = 4 * (1 - 1/3 + 1/5 - 1/7 + 1/9 - 1/11 + ...)

Pi = (4/1) - (4/3) + (4/5) - (4/7) + (4/9) - (4/11) + ... + (-i)^i/(2*i + 1) + ...

Definiamo la funzione:

(define (pow10? i)
  (while (> i 10)
    (setq i (div i 10)))
  (= i 10)
)

(define (pigrecoGL iter)
  (local (sum fac i denom myterm)
    (setq sum 0)
    (setq fac 1)
    (setq i 1)
    (while (<= i iter)
      (setq denom (- (mul 2 i ) 1))
      (setq myterm (div fac denom))
      (setq sum (add sum myterm))
      (setq fac (mul -1 fac))
      (if (pow10? i)
        (print (format "%d iterazioni: PI = %16.12f.\n" i (mul 4 sum)))
      )
      (++ i)
    )
  );local
)

(pigrecoGL 10000000)
;-> Con 10 termini PI vale:   3.041839618929.
;-> Con 100 termini PI vale:   3.131592903559.
;-> Con 1000 termini PI vale:   3.140592653840.
;-> Con 10000 termini PI vale:   3.141492653590.
;-> Con 100000 termini PI vale:   3.141582653590.
;-> Con 1000000 termini PI vale:   3.141591653590.
;-> Con 10000000 termini PI vale:   3.141592553590.
Valore reale pi greco:              3.141592653589

Un'altra serie infinita per calcolare pi greco è quella di Nilakantha. Anche se più leggermente più complessa, converge a pi greco molto più velocemente della formula di Leibniz.

Serie di Nilakantha:

pigrecoN = 3 + 4/(2*3*4) - 4/(4*5*6) + 4/(6*7*8) - 4/(8*9*10) + 4/(10*11*12) - (4/(12*13*14) ...

(define (pigrecoN iter)
  (local (val based frac num den i)
    (setq val 3)
    (setq based 2)
    (setq i 1)
    (setq num 4)
    (while (<= i iter)
      (setq den (* based (+ based 1) (+ based 2)))
      (setq val (add val (div num den)))
      (++ based 2)
      (setq num (- num))
      (++ i)
      (if (= (% i 100) 0)
        (print (format "Con %d termini PI vale: %16.12f.\n" i val))
      )
    )
  )
)

(pigrecoN 500)
;-> Con 100 termini PI vale:   3.141592903559.
;-> Con 200 termini PI vale:   3.141592684839.
;-> Con 300 termini PI vale:   3.141592662849.
;-> Con 400 termini PI vale:   3.141592657496.
;-> Con 500 termini PI vale:   3.141592655590.
Valore reale pi greco:         3.141592653589

Serie di Eulero:

(pigreco^2)/6 = sum[1,∞] 1/(i*i)

(define (pigrecoL iter)
  (local (val i)
      (setq i 1)
      (setq val 0)
      (while (<= i iter)
        (setq val (add val (div 1 (mul i i))))
        (if (= (% i 100000) 0)
          (print (format "Iterazioni: %d   PI: %16.12f\n" i (sqrt (mul val 6))))
        )
        (++ i)
      )
      (sqrt (mul val 6))
  )
)

(pigrecoL 1000000)
;-> Iterazioni: 100000   PI:   3.141583104326
;-> Iterazioni: 200000   PI:   3.141587878950
;-> Iterazioni: 300000   PI:   3.141589470495
;-> Iterazioni: 400000   PI:   3.141590266268
;-> Iterazioni: 500000   PI:   3.141590743732
;-> Iterazioni: 600000   PI:   3.141591062041
;-> Iterazioni: 700000   PI:   3.141591289405
;-> Iterazioni: 800000   PI:   3.141591459928
;-> Iterazioni: 900000   PI:   3.141591592557
;-> Iterazioni: 1000000  PI:   3.141591698661
Valore reale pi greco:         3.141592653589


---------------
NUMERI DI LUCAS
---------------

I numeri di Lucas sono simili ai numeri di Fibonacci. I numeri di Lucas sono definiti come la somma dei suoi due termini immediatamente precedenti. Ma qui i primi due termini sono 2 e 1 mentre nei numeri di Fibonacci i primi due termini sono rispettivamente 0 e 1.

Matematicamente, i numeri di Lucas sono definiti come:

 L(0) = 2
 L(1) = 1
 L(n) = L(n-2) + L(n-1), per n > 1.

I primi numeri di Lucas sono i seguenti numeri interi:

2, 1, 3, 4, 7, 11, 18, 29, 47, 76, 123, ...

Scriviamo una funzione che restituisce l'ennesimo numero di Lucas.

Versione ricorsiva:

(define (lucas n)
  (if (zero? n)
      2
      (if (= 1 n)
      1
      (+ (lucas (- n 1)) (lucas (- n 2))))))

(map lucas (sequence 0 10))
;-> (2 1 3 4 7 11 18 29 47 76 123)

(lucas 30)
;-> 1860498

Versione iterativa O(n):

(define (lucas-i n)
  (local (a b c)
    (setq a 2 b 1)
    (if (zero? n)
        a
        (if (= 1 n)
            b
            (for (i 2 n)
              (setq c (+ a b))
              (setq a b)
              (setq b c)
            )
        )
    )
  )
)

(map lucas-i (sequence 0 10))
;-> (2 1 3 4 7 11 18 29 47 76 123)

(lucas-i 30)
;-> 1860498

Vediamo la differenza di velocità:

(time (lucas 30))
;-> 500.961

(time (lucas-i 30))
;-> 0

La versione iterativa è molto più veloce della versione ricorsiva.
Esistono algoritmi ancora più veloci per il calcolo dei numeri di Lucas che utilizzano le operazioni tra matrici.


------------------------------------
LOGARITMO INTERO DI UN NUMERO INTERO
------------------------------------

Il logaritmo intero base b di un numero n è il numero di volte in cui il numero b può essere moltiplicato per se stesso senza superare n.

Scrivere una funzione che calcola il logaritmo intero di un numero intero.

Funzione ricorsiva:

(define (ilog n b)
  (if (zero? n) -1
    (+ (ilog (/ n b) b) 1L)))

(ilog 1818272126126126 3)
;-> 31

Verifichiamo la correttezza della funzione:

(for (i 1 1e6)
  (if (!= (ilog i 10) (int (log i 10)))
    (println "error: " i { } (ilog i 10) { } (log i 10))
  )
)
;-> error: 1000 3 3
;-> error: 1000000 6 5.999999999999999

Questi errori sono dovuti alla mancanza di precisione dei numeri floating-point, non a bug della  funzione "ilog".

Vediamo la velocità della funzione:

(time (for (i 1 1000000) (ilog i 10)))
;-> 1294.672

(time (for (i 1 1000000) (int (log i 10))))
;-> 114.881

Se cambio la base (es. 2) "ilog" aumenta il tempo, mentre "log" rimane costante) !!!

(time (for (i 1 1000000) (ilog i 2)))
;-> 4015.893

(time (for (i 1 1000000) (int (log i 2))))
;-> 109.365

Nota: Per la funzione "log" vale: logb(n) = x, n = b^x. Questo non è vero per la funzione "ilog".

Versione iterativa:

(define (ilog n b)
  (let (out -1)
    (while (!= n 0)
      ;(++ out)
      (setq n (/ n b))
      (setq out (+ out 1))
    )
    out
  )
)

(ilog 1818272126126126 3)
;-> 31

Verifichiamo la correttezza della funzione:

(for (i 1 1e6)
  (if (!= (ilog i 10) (int (log i 10)))
    (println "error: " i { } (ilog i 10) { } (log i 10))
  )
)
;-> error: 1000 3 3
;-> error: 1000000 6 5.999999999999999

Questi errori sono dovuti alla mancanza di precisione dei numeri floating-point, non a bug della  funzione "ilog".

Vediamo la velocità della funzione:

(time (for (i 1 1000000) (ilog i 10)))
;-> 1015.882

Se cambio la base (es. 2) "ilog" aumenta il tempo, mentre "log" rimane costante) !!!

(time (for (i 1 1000000) (ilog i 2)))
;-> 2797.303

(time (for (i 1 1000000) (int (log i 2))))
;-> 109.365

Versione iterativa (big integer):

(define (ilog n b)
  (let (out -1L)
    (while (!= n 0)
      ;(++ out)
      (setq n (/ n b))
      (setq out (+ out 1L))
    )
    out
  )
)

(ilog 1818272126126126 3)
;-> 31L

Verifichiamo la correttezza della funzione:

(for (i 1 1e6)
  (if (!= (ilog i 10) (int (log i 10)))
    (println "error: " i { } (ilog i 10) { } (log i 10))
  )
)
;-> error: 1000 3L 3
;-> error: 1000000 6L 5.999999999999999

Questi errori sono dovuti alla mancanza di precisione dei numeri floating-point, non a bug della  funzione "ilog".

(setq a (log 1000 10))
;-> 3

Trasformo il float "a" in integer:
(int a)
;-> 2
Non è il risultato che ci aspettavamo.

Il problema risiede nella perdita di precisione dei calcoli in virgola mobile:
(setq a (format "%16.16f" (log 1000 10)))
;-> "2.9999999999999996"

Vediamo la velocità della funzione:

(time (for (i 1 1000000) (ilog i 10)))
;-> 1687.71

Se cambio la base (es. 2 ilog aumenta il tempo, mentre log rimane costante) !!!

(time (for (i 1 1000000) (ilog i 2)))
;-> 4359.772


--------------------
NUMERI DI CARMICHAEL
--------------------

In teoria dei numeri, un numero di Carmichael è un intero positivo composto n che soddisfa la congruenza

 b^(n-1) ≡ 1 mod n

per tutti gli interi b che sono coprimi con n o, equivalentemente, che verificano la congruenza

 b^n ≡ b mod n

per ogni b.

Il piccolo teorema di Fermat afferma che tutti i numeri primi hanno quella proprietà, ma il viceversa non è vero: ad esempio  2^(341) mod 341, ma 341 non è primo, essendo il prodotto di 11 e 31. Un numero tale che b^n ≡ b mod n è detto pseudoprimo di Fermat rispetto alla base b. I numeri di Carmichael sono pseudoprimi di Fermat in ogni base, cioè assoluti.

I numeri di Carmichael passano in ogni caso il test di primalità di Fermat pur essendo composti: la loro esistenza impedisce di utilizzare questo test per certificare con sicurezza la primalità di un numero, mentre rimane utilizzabile per dimostrare che un numero è composto.

I numeri di Carmichael sono tutti dispari.

Scriviamo una funxione che controlla se un dato numero è un numero di Carmichael:

(define (fattorizza x)
  (letn (fattori (factor x)
         unici (unique fattori))
    (transpose (list unici (count unici fattori)))))
    ;(map list unici (count unici fattori))))

(fattorizza 45)
;-> ((3 2) (5 1))

(fattorizza 561)
;-> ((3 1) (11 1) (17 1))

(define (carmichael? n)
  (local (out fattori)
    (setq out true)
    (cond ((or (= n 1) (even? n) (= 1 (length (factor n)))) (setq out nil))
          (true
            (setq fattori (fattorizza n))
            (dolist (f fattori (= out nil))
              (if (> (f 1) 1) (setq out nil))
              (if (!= (% (- n 1) (- (f 0) 1)) 0) (setq out nil))
            )
          )
    )
    out
  )
)

Scriviamo una funzione che calcola i numeri di Carmichael fino al numero n:

(define (carmichael n)
  (let (out '())
    (for (i 3 n 2)
      (if (carmichael? i) (push i out -1))
    )
  out
  )
)

(carmichael 1000000)
;-> (561 1105 1729 2465 2821 6601 8911 10585 15841 29341 41041 46657 52633 62745 63973
;->  75361 101101 115921 126217 162401 172081 188461 252601 278545 294409 314821 334153
;->  340561 399001 410041 449065 488881 512461 530881 552721 656601 658801 670033 748657
;->  825265 838201 852841 997633)

(time (carmichael 1000000))
;-> 2043.545

(define (carmichael n)
  (filter carmichael? (sequence 3 n 2)))

(time (carmichael 1000000))
;-> 3510.422


------------------------------------------
RADICE QUADRATA INTERA DI UN NUMERO INTERO
------------------------------------------

Calcolare la radice quadrata intera di un numero n.

Primo metodo:

(define (isqrt1 n)
  (local (xn xn1)
    (setq xn 1)
    (setq xn1 (/ (+ xn (/ n xn)) 2))
    (while (> (abs (- xn1 xn)) 1)
      (setq xn xn1)
      (setq xn1 (/ (+ xn (/ n xn)) 2))
    )
    (while (> (* xn1 xn1) n) (-- xn1))
    xn1
  )
)

(isqrt1 900)
;-> 30

(isqrt1 899)
;-> 29

(isqrt1 6074020096)
;-> 77936

(time (map isqrt1 (sequence 2 1e6)))
;-> 4980.122

Test di correttezza:

(for (i 2 1e6) (if (!= (isqrt1 (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Secondo metodo (algoritmo babilonese):

(define (isqrt2 n)
  (let ((x n) (y 1))
    (while (> x y)
      (setq x (/ (+ x y) 2))
      (setq y (/ n x))
    )
    x
  )
)

(isqrt2 900)
;-> 30

(isqrt2 899)
;-> 29

(isqrt2 6074020096)
;-> 77936

(time (map isqrt2 (sequence 2 1e6)))
;-> 3630.086

Test di correttezza:

(for (i 2 1e6) (if (!= (isqrt2 (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Terzo metodo:

(define (isqrt3 n) (int (sqrt n)))

(isqrt3 900)
;-> 30

(isqrt3 899)
;-> 29

(isqrt3 6074020096)
;-> 77936

(time (map isqrt3 (sequence 2 1e6)))
;-> 150.086

Test di correttezza:

(for (i 2 1e6) (if (!= (isqrt3 (* i i)) (sqrt (* i i))) (println "error: " (* i i)) ))
;-> nil

Quarto metodo (big integer):

(define (isqrt4 n)
  (catch
    (local (start mid end out)
      (setq start 1L)
      (setq end (bigint (/ n 2)))
      (while (<= start end)
        (setq mid (/ (+ start end) 2))
        (if (= n (* mid mid)) (throw mid))
        (if (< (* mid mid) n)
          (begin (setq start (+ mid 1)) (setq out mid))
          (setq end (- mid 1))
        )
      )
      (throw out)
    )
  )
)

oppure:

(define (isqrt4 n)
  (local (start mid end trovato out)
    (setq start 1L)
    (setq end (bigint (/ n 2)))
    (while (and (<= start end) (= trovato nil))
      (setq mid (/ (+ start end) 2))
      (if (= n (* mid mid))
          (begin (setq out mid) (setq trovato true))
          (if (< (* mid mid) n)
            (begin (setq start (+ mid 1)) (setq out mid))
            (begin (setq end (- mid 1))  (setq out mid)))
      )
    )
    out
  )
)

(isqrt4 900)
;-> 30L

(isqrt4 899)
;-> 29L

(isqrt4 6074020096)
;-> 77936L

(time (map isqrt4 (sequence 2 1e6)))
;-> 26274.627

Test di correttezza:

(for (i 2 1e6)
  (setq j (bigint i))
  (if (!= (isqrt4 (* j j)) (sqrt (* j j)))
    (begin (println "error: " (* j j)))))
;-> nil


-----------------------
COPPIE DI PRIMI GEMELLI
-----------------------

Due numeri sono primi gemelli se n e (n + 2) sono entrambi primi.
Le coppie di primi gemelli sono infinite, ma la loro frequenza diminuisce con l'aumentare di n.

Usiamo la seguente funzione per verificare se un numero n è primo:

(define (primo? n)
  (if (even? n) nil
      (= 1 (length (factor n)))))

(primo? 11)
;-> true

Definiamo una funzione per verificare se un numero n ha un gemello:

(define (gemelli? n) (if (and (primo? n) (primo? (+ n 2)))))

(gemelli? 5)
;-> true

Definiamo una funzione che trova tutte le coppie di gemelli dal numero a (dispari) al numero b:

(define (coppieGemelli a b)
  (local (somma)
    (setq somma 0)
    ;(for (i a b) (if (gemelli? i) (println (++ somma) { } i { } (+ i 2))))
    (for (i a b 2) (if (gemelli? i) (++ somma)))
    somma
  )
)

Con: (for (i a b) (if (gemelli? i) (println (++ somma) { } i { } (+ i 2))))

(coppieGemelli 3 1000)
;-> 1 3 5         2 5 7
;-> 3 11 13       4 17 19
;-> 5 29 31       6 41 43
;-> 7 59 61       8 71 73
;-> 9 101 103     10 107 109
;-> 11 137 139    12 149 151
;-> 13 179 181    14 191 193
;-> 15 197 199    16 227 229
;-> 17 239 241    18 269 271
;-> 19 281 283    20 311 313
;-> 21 347 349    22 419 421
;-> 23 431 433    24 461 463
;-> 25 521 523    26 569 571
;-> 27 599 601    28 617 619
;-> 29 641 643    30 659 661
;-> 31 809 811    32 821 823
;-> 33 827 829    34 857 859
;-> 35 881 883

Con: (for (i a b 2) (if (gemelli? i) (++ somma)))

Calcoliamo la velocità della funzione:

(time (coppieGemelli 3 2e7))
;-> 46361.619

Adesso definiamo una funzione "pairs" che restituisce una lista con tutte le coppie di primi gemelli dal numero a al numero b.

Prima scriviamo la funzione "twin?" che dato un numero n restituisce la coppia di primi n e (n + 2) oppure nil:

(define (twin? n)
  (if (and (primo? n) (primo? (+ n 2)))
    (list n (+ n 2))
    nil
  )
)

(twin? 9)
;-> nil

(twin? 881)
;-> (881 883)

(define (pairs a b)
  (filter true? (map twin? (sequence a b)))
)

(pairs 3 1000)
;-> ((3 5) (5 7) (11 13) (17 19) (29 31) (41 43) (59 61) (71 73) (101 103) (107 109)
;->  (137 139) (149 151) (179 181) (191 193) (197 199) (227 229) (239 241) (269 271)
;->  (281 283) (311 313) (347 349) (419 421) (431 433) (461 463) (521 523) (569 571)
;->  (599 601) (617 619) (641 643) (659 661) (809 811) (821 823) (827 829) (857 859)
;->  (881 883))

(length (pairs 3 1000))
;-> 35

Calcoliamo la velocità della funzione:

(time (pairs 3 2e7))
;-> 47479.457

Adesso definiamo la stessa funzione, ma in modo imperativo:

(define (pairs-i a b)
  (local (idx out)
    (setq idx a)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (push (list idx (+ idx 2)) out -1)
      )
      (++ idx 2)
    )
    out
  )
)

(length (pairs-i 3 1000))
;-> 35

(time (pairs-i 3 2e7))
;-> 44355.696

Adesso riscriviamo la funzione ottimizzata (non ricalcoliamo un numero primo quando troviamo una coppia):

(define (pairs-i a b)
  (local (idx found out)
    (setq found nil)
    (setq idx a)
    ; solo il numero 5 appartiene a due coppie di numeri primi gemelli
    (setq out '((3 5) (5 7)))
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (begin
        (push (list idx (+ idx 2)) out -1)
        (setq found true))
      )
      (if found (++ idx 4) (++ idx 2))
      (setq found nil)
    )
    out
  )
)

(length (pairs-i 7 1000))
;-> 35

(time (pairs-i 7 2e7))
;-> 43177.908

Questo è il miglior risultato ottenuto in termini di velocità.

Cerchiamo di capire dove la funzione spende il tempo maggiore. Proviamo a testare solo la parte che calcola i numeri primi:

(define (test-a a b)
  (local (idx out)
    (setq idx a)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2))))
      (++ idx 2)
    )
  )
)

(time (test-a 3 2e7))
;-> 44295.723

Come avevamo intuito, quasi tutto il tempo di esecuzione della funzione è dedicato al calcolo dei numeri primi.

Calcoliamo la distanza tra le coppie di numeri primi:

(define (dist-pairs a b)
  (local (idx base out)
    (setq idx a)
    (setq base 3)
    (while (< idx b)
      (if (and (primo? idx) (primo? (+ idx 2)))
        (begin
          (push (- idx base) out -1)
          (setq base idx))
      )
      (++ idx 2)
    )
    out
  )
)

(dist-pairs 5 1000)
;-> (2 6 6 12 12 18 12 30 6 30 12 30 12 6 30 12 30 12
;->  30 36 72 12 30 60 48 30 18 24 18 150 12 6 30 24)

(silent (setq dp6 (dist-pairs 5 1e6)))
(length dp6)
;-> 8168

Infine salviamo dp6 come file di testo (per esempio per plottare i dati con un altro programma):

(save "dist-coppie.txt" 'dp6)
;-> true

Sul forum di newLISP, raph.ronnquist ha fornito due funzioni per calcolare le coppie:

(define (pairs-i a b)
  (let ((out (list)) (x nil))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (1 (factor y)) (setf y nil) x (push (list x y) out -1))
      (setf x y))
    out))

(length (pairs-i 3 1000))
;-> 35

(time (pairs-i 3 2e7))
;-> 40072.606

La seconda funzione sfrutta la seguente idea. Per migliorare la velocità (nei numeri grandi) possiamo controllare se il modulo di un generico prodotto di primi include uno dei numeri primi del prodotto.
Il codice è il seguente:

(define (pairs-i1 a b)
  (let ((out (list)) (x nil) (FX (* 2 3 5 7 11 13)) (M 0))
    (for (y (if (odd? a) a (inc a)) b 2)
      (if (if (< y FX) (1 (factor y))
             (or (= (setf M (% y FX))) (if (factor M) (<= ($it 0) 13)) (1 (factor y))))
        (setf y nil)
        x (push (list x y) out -1))
      (setf x y))
    out))

In questo esempio viene utilizzato il prodotto di primi (* 2 3 5 7 11 13). Per numeri maggiori di questo, controlla se il modulo è un prodotto di uno di quei numeri primi, nel qual caso il numero nel suo insieme è divisibile per quel numero primo (e quindi non è un numero primo). In particolare, la fattorizzazione del modulo è in genere più veloce perchè filtra tutti i numeri controllati dal modulo.

(time (pairs-i1 3 2e7))
;-> 29964.396

Il miglioramento di velocità per la gestione di grandi numeri è significativo (+ 25%).


----------------
NUMERI SEMIPRIMI
----------------

Un numero semi-primo è un numero che è il prodotto di due numeri primi.
Algoritmo:
1) Trovare un divisore del numero d1.
2) Dividere il numero per d1 per ottenere un secondo divisore d2.
3) Se d1 e d2 sono entrambi primi, allora il numero originale è semiprimo.
4) ripetere 1), 2) e 3) per tutti i divisori del numero.

Scriviamo una funzione che verifica se un numero è primo:

(define (primo? n)
  (if (and (!= n 2) (even? n)) nil
      (= 1 (length (factor n)))))

Scriviamo una funzione che verifica se un numero è semiprimo:

(define (semiprimo? num)
  (local (d2 out)
    (for (d1 2 (int (+ (sqrt num) 1)) 1 (= out true))
      (if (= (% num d1) 0)
        (setq d2 (/ num d1)
              out (and (primo? d1) (primo? d2)))
      )
    )
    out
  )
)

(semiprimo? 21)
;-> true

(semiprimo? 4)
;-> true

Scriviamo una funzione che calcola i numeri semiprimi fino a n:

(define (semiprimi n)
  (let (out '())
    (for (i 2 n)
      (if (semiprimo? i) (push i out -1))
    )
  out
  )
)

(semiprimi 100)
;-> (4 6 9 10 14 15 21 22 25 26 33 34 35 38 39 46 49 51 55
;->  57 58 62 65 69 74 77 82 85 86 87 91 93 94 95)

(length (semiprimi 1000))
;-> 299

(time (map semiprimi (sequence 10 1000)))
;-> 1473.389

Per migliorare la velocità possiamo inglobare il controllo dei numeri primi all'interno del ciclo while:

(define (semiprimo? num)
  (let ((cnt 0) (i 2))
    (while (and (< cnt 2) (<= (* i i) num))
      (while (zero? (% num i))
        (setq num (/ num i))
        (++ cnt)
      )
      (++ i)
    )
    (if (> num 1) (++ cnt))
    (= cnt 2)
  )
)

(semiprimi 100)
;-> (4 6 9 10 14 15 21 22 25 26 33 34 35 38 39 46 49 51 55
;->  57 58 62 65 69 74 77 82 85 86 87 91 93 94 95)

(length (semiprimi 1000))
;-> 299

(time (map semiprimi (sequence 10 1000)))
;-> 1056.916


--------------
NUMERI COPRIMI
--------------

Due numeri a e b sono detti coprimi (o primi tra loro o relativamente primi) se e solo se essi non hanno nessun divisore comune eccetto 1 e -1 o, in modo equivalente, se il loro massimo comune divisore è 1, cioè MCD(a,b) = 1.

(define (coprimi? a b) (= (gcd a b) 1))

(coprimi? 10 11)

(define (coprimi n)
  (let ((out '()))
    (for (i 0 n)
      (for (j i n)
      ;(for (j (+ i 1) n)
        (if (coprimi? i j) (push (list i j) out -1))
      )
    )
    out
  )
)

(coprimi 10)
;-> ((0 1) (1 1) (1 2) (1 3) (1 4) (1 5) (1 6) (1 7) (1 8) (1 9)
;->  (1 10) (2 3) (2 5) (2 7) (2 9) (3 4) (3 5) (3 7) (3 8) (3 10)
;->  (4 5) (4 7) (4 9) (5 6) (5 7) (5 8) (5 9) (6 7) (7 8) (7 9)
;->  (7 10) (8 9) (9 10))

Due teoremi interessanti sui numeri coprimi:

Teorema: Numeri naturali consecutivi n e (n + 1) sono sempre coprimi.

(coprimi? 310 311)
;-> true

Teorema: La probabilità che due interi scelti a caso siano coprimi tra loro è 6/(π^2).

Un altro metodo per calcolare tutte le coppie di coprimi è quello di utilizzare la sequenza di Farey.
La sequenza di Farey F(n), per ogni numero naturale positivo n, è definita come l'insieme ordinato secondo l'ordine crescente di tutti i numeri razionali irriducibili (cioè tali che numeratore e denominatore siano coprimi) espressi sotto forma di frazione con numeratore e denominatore compresi tra zero e n.

La seguente funzione genera la n-esima sequenza di Farey in ordine crescente o decrescente:

(define (farey n desc)
  (local (a b c d k p q out)
    (setq out '())
    (setq a 0 b 1 c 1 d n)
    ;(println a { } b)
    (if desc (setq a 1 c (- n 1)))
    (push (list a b) out -1)
    (while (or (and (<= c n) (not desc)) (and (> a 0) desc))
      (setq k (int (div (+ n b) d)))
      (setq p (- (* k c) a))
      (setq q (- (* k d) b))
      (setq a c b d c p d q)
      (push (list a b) out -1)
      ;(println a { } b)
    )
    out
  )
)

(farey 3)
;-> ((0 1) (1 3) (1 2) (2 3) (1 1))

(farey 10)
;-> ((0 1) (1 10) (1 9) (1 8) (1 7) (1 6) (1 5) (2 9) (1 4) (2 7)
;->  (3 10) (1 3) (3 8) (2 5) (3 7) (4 9) (1 2) (5 9) (4 7) (3 5)
;->  (5 8) (2 3) (7 10) (5 7) (3 4) (7 9) (4 5) (5 6) (6 7) (7 8)
;->  (8 9) (9 10) (1 1))

Verifichiamo che le due funzioni "coprimi" e "farey" generano le stesse sequenze :

(= (coprimi 100) (sort (farey 100)))
;-> true

Vediamo la differenza delle due funzioni in termini di velocità:

(time (map coprimi (sequence 10 500)))
;-> 6391.329

(time (map farey (sequence 10 500)))
;-> 7297.73

Ottimizziamo un pò la funzione "farey":

(define (farey1 n)
  (local (a b c d k p q out)
    (setq out '())
    (setq a 0 b 1 c 1 d n)
    ;(println a { } b)
    (push (list a b) out -1)
    ;(while (or (and (<= c n) (not desc)) (and (> a 0) desc))
    (while (<= c n)
      ;(setq k (int (div (+ n b) d)))
      (setq k (/ (+ n b) d))
      (setq p (- (* k c) a))
      (setq q (- (* k d) b))
      (setq a c b d c p d q)
      (push (list a b) out -1)
      ;(println a { } b)
    )
    out
  )
)

(= (coprimi 100) (sort(farey1 100)))
;-> true

(time (map farey1 (sequence 10 500)))
;-> 6469.966

Le due funzioni hanno la stessa velocità.

Insiemi di numeri coprimi
-------------------------
Un insieme di interi S = {a1, a2, .... an} può anche essere chiamato coprimo o "setwise coprimo" se il massimo comune divisore di tutti gli elementi dell'insieme è 1. Ad esempio, gli interi 6, 10, 15 sono coprimi perché 1 è l'unico numero intero positivo che li divide tutti.
Se ogni coppia in un insieme di interi è coprimo, allora l'insieme è detto coprimo a coppie o "pairwise coprimo". Un insieme di interi S = {a1, a2, .... an} è "pairwise coprimo" se il minimo comune multiplo di tutti i numeri è uguale al prodotto di tutti i numeri.
La condizione paiwise coprimo è più forte della condizione setwise coprimo. Ogni insieme finito pairwise coprimo è anche setwise coprimo, ma non è vero il contrario. Ad esempio, gli interi 4, 5, 6 sono (setwise) coprimi (perché l'unico intero positivo che li divide tutti è 1), ma non sono coprimi a coppie (perché mcd (4, 6) = 2).
Il concetto di coprimalità a coppie è importante come ipotesi in molti risultati nella teoria dei numeri, come il teorema cinese dei resti.
È possibile che un insieme infinito di interi sia coprimo a coppie, ad esempio l'insieme di tutti i numeri primi.


-------------------------------------------------
FATTORIZZAZIONE DI UN NUMERO INTERO (BIG INTEGER)
-------------------------------------------------

La fattorizzazione a ruota è un miglioramento del metodo della divisione di prova per la fattorizzazione a numeri interi.

Il metodo della divisione di prova consiste nel dividere il numero da fattorizzare successivamente per i primi numeri interi (2, 3, 4, 5, ...) fino a trovare un divisore. Con la fattorizzazione a ruota, si parte da una lista (base) dei primi numeri primi. Quindi si genera l'elenco, chiamato la ruota, degli interi che sono coprimi con tutti i numeri della base. Quindi, per trovare il divisore più piccolo del numero da fattorizzare, lo si divide in successione per i numeri nella base e nella ruota.

Con la base {2, 3}, questo metodo riduce il numero di divisioni a 1/3 <34% del numero necessario per la divisione di prova. Basi più grandi riducono ulteriormente questa proporzione. Ad esempio, con base da {2, 3, 5} a 8/30 <27%, mentre con una base da {2, 3, 5, 7} a 48/210 <23%.

Esempio

Con la base dei primi 3 numeri primi {2, 3, 5}, il "primo giro" della ruota è costituito da:

7, 11, 13, 17, 19, 23, 29, 31.

Il secondo giro si ottiene aggiungendo il prodotto della base 2 * 3 * 5 = 30, ai numeri del primo giro. Il terzo giro si ottiene aggiungendo 30 al secondo giro e così via.
Da notare che gli incrementi tra due elementi consecutivi della ruota, cioè

dist = [4, 2, 4, 2, 4, 6, 2, 6],

rimangono gli stessi dopo ogni giro.

Nota: (setq MAXINT 9223372036854775807)

Scriviamo la funzione per fattorizzare un numero:

(define (factorbig n)
  (local (f k i dist out)
    ; distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist '(0 4 2 4 2 4 6 2 6))
    (setq out '())
    (while (zero? (% n 2))
      (push '2L out -1)
      (setq n (/ n 2)))
    (while (zero? (% n 3))
      (push '3L out -1)
      (setq n (/ n 3)))
    (while (zero? (% n 5))
      (push '5L out -1)
      (setq n (/ n 5)))
    (setq k 7L i 1)
    (while (<= (* k k) n)
      (if (zero? (% n k))
        (begin
        (push k out -1)
        (setq n (/ n k)))
        (begin
        (setq k (+ k (dist i)))
        (if (< i 8) (++ i) (setq i 1)))
      )
    )
    (if (> n 1) (push (bigint n) out -1))
    out
  )
)

(factorbig 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(time (factorbig 9223372036854775809L))
;-> 50.947

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

Controlliamo se "factorbig" e "factor" producono lo stesso risultato (fino ad un milione):

(= (map factorbig (sequence 2 1e6)) (map factor (sequence 2 1e6)))
;-> true

Proviamo con un numero di 20 cifre:

(time (println (factorbig 92233720368547758091L)))
;-> (7L 13L 1013557366687338001L)
;-> 182879.379 ; 3 minuti e 2 secondi

(apply * '(7L 13L 1013557366687338001L))
;-> 92233720368547758091L

Più è grande il valore dei fattori maggiore è il tempo di esecuzione.

(time (println (factorbig 1013557366687338001L)))
;-> (1013557366687338001L)
;-> 179855.465 ; 3 minuti

Invece nel seguente esempio il calcolo è immediato:

2^64 = 18446744073709551616

(setq d 18446744073709551616L)

(factorbig d)
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L)

Calcoliamo la differenza di velocità tra "factorbig" e "factor":

(time (map factorbig (sequence 2 1e5)))
;-> 1453.157

(time (map factor (sequence 2 1e5)))
;-> 78.108

(time (map factorbig (sequence 2 1e6)))
;-> 33469.801 ; 33 secondi

(time (map factor (sequence 2 1e6)))
;-> 1027.95

La funzione integrata "factor" è molto più veloce, ma non funzione con i big integer.

Possiamo migliorare le prestazioni della funzione utilizzando una base più grande:

(2 3 5 7)

Vediamo come calcolare la lista delle distanze. Prima occorre generare i numeri della ruota, cioè tutti gli interi coprimi con la base fino al numero (+ (* 2 3 5 7) 11) = 221

Funzione per calcolare i coprimi:

(define (coprimi? a b) (= (gcd a b) 1))

Funzione che verifica se un numero appartiene alla ruota:

(define (wheel7 n) (and (coprimi? n 2) (coprimi? n 3) (coprimi? n 5) (coprimi? n 7)))

Funzione che crea la ruota dei numeri:

(define (dowheel7)
  (let (out '())
    (for (i 2 221) (if (wheel7 i) (push i out -1)))
  )
)

(dowheel7)
;-> (11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113
;->  121 127 131 137 139 143 149 151 157 163 167 169 173 179 181 187 191 193 197 199
;->  209 211 221)

Per calcolare le distanze tra due elementi consecutivi della ruota usiamo la seguente funzione:

(define (creadist lst) (map - (rest lst) (chop lst)))

(creadist (dowheel7))
;-> (2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4 6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4 2 4 6 2
;-> 6 4 2 4 2 10 2 10)

Adesso possiamo scrivere la nuova funzione di fattorizzazione con base (2 3 5 7):

(define (factorbig n)
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% n 2)) (push '2L out -1) (setq n (/ n 2)))
    (while (zero? (% n 3)) (push '3L out -1) (setq n (/ n 3)))
    (while (zero? (% n 5)) (push '5L out -1) (setq n (/ n 5)))
    (while (zero? (% n 7)) (push '7L out -1) (setq n (/ n 7)))
    (setq k 11L i 0)
    (while (<= (* k k) n)
      (if (zero? (% n k))
        (begin
        (push k out -1)
        (setq n (/ n k)))
        (begin
        ;(++ k (dist i))
        (setq k (+ k (dist i)))
        (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> n 1) (push (bigint n) out -1))
    out
  )
)

(factorbig 9223372036854775809L)
;-> (3L 3L 3L 19L 43L 5419L 77158673929L)

(time (factorbig 9223372036854775809L))
;-> 46.875

(apply * '(3L 3L 3L 19L 43L 5419L 77158673929L))
;-> 9223372036854775809L

Controlliamo se "factorbig" e "factor" producono lo stesso risultato (fino ad un milione):

(= (map factorbig (sequence 2 1e5)) (map factor (sequence 2 1e5)))
;-> true
(= (map factorbig (sequence 2 1e6)) (map factor (sequence 2 1e6)))
;-> true

Proviamo con un numero di 20 cifre:

(time (println (factorbig 92233720368547758091L)))
;-> (7L 13L 1013557366687338001L)
;-> 150515.93

Questa funzione "factorbig" impiega 30 secondi in meno di quella precedente (con la base (2 3 5) la funzione impiegava 180 secondi).

Calcoliamo la differenza di velocità tra "factorbig" e "factor":

(time (map factorbig (sequence 2 1e5)))
;-> 1406.559

(time (map factor (sequence 2 1e5)))
;-> 78.108

(time (map factorbig (sequence 2 1e6)))
;-> 28834.221 ; 29 secondi

(time (map factor (sequence 2 1e6)))
;-> 1027.95


------------------------------------------
POTENZA DI DUE NUMERI INTERI (BIG INTEGER)
------------------------------------------

Utilizziamo una soluzione ricorsiva per calcolare x^n usando il metodo divide & conquer:

power(x, n) =     power(x, n/2) * power(x, n/2)     (se n è pari)
power(x, n) = x * power(x, n/2) * power(x, n/2)     (se n è dispari)

(define (ipow x n)
  (cond ((zero? n) 1)
        ((even? n) (ipow (* x x) (/ n 2)))
        (true (* x (ipow (* x x) (/ (- n 1) 2))))))

(ipow 3 7)
;-> 2187

(ipow -2 15)
;-> -32768

Il metodo può essere migliorato notando che calcoliamo due volte lo stesso sotto-problema (power (x, n/2) per ogni chiamata ricorsiva. Possiamo ottimizzare la funzione calcolando e memorizzando la soluzione del sotto-problema solo una volta.

(define (ipow x n)
  (local (pot out)
    (if (zero? n)
        (setq out 1L)
        (begin
          (setq pot (ipow x (/ n 2)))
          (if (odd? n) (setq out (* x pot pot))
                       (setq out (* pot pot)))
        )
    )
    out
  )
)

(ipow -2 15)
;-> -32768

Controlliamo se la soluzione genera gli stessi risultati della funzione built-in pow(n m):

(for (i 1 15)
  (for (j 1 15)
    (if (!= (pow i j) (ipow i j))
      (println "error: " i ", " j))
  )
)
;-> nil

(setq MAXINT 9223372036854775807)

(ipow 10 53)
;-> -8169529724050079744 ;errore di overflow

Passando gli argomenti come big integer otteniamo il risultato corretto:

(ipow 10L 53L)
;-> 100000000000000000000000000000000000000000000000000000L

(ipow 3L 8L)
;-> 6561L

Complessità temporale: O(log(n))

Potete trovare un algoritmo più efficiente che utilizza il metodo delle "addiction chain" nel libro di Donald Knuth "The Art of Computer Programming".

Questa è una versione brute-force fornita da Lutz su forum di newLISP:

(define (** x p)
    (let (y 1L)
        (dotimes (i p)
            (set 'y (* y x)))))

(** 10 53)
;-> 100000000000000000000000000000000000000000000000000000L

(= (ipow 10L 53L) (** 10 53))
;-> true

(time (ipow 12345L 12345L) 100)
;-> 2572.051

(time (** 12345L 12345L) 100)
;-> 9752.167


--------------------
NUMERI DI TRIBONACCI
--------------------

La serie tribonacci è una generalizzazione della sequenza di Fibonacci in cui ogni termine è la somma dei tre termini precedenti.

La sequenza Tribonacci:

0, 0, 1, 1, 2, 4, 7, 13, 24, 44, 81, 149, 274, 504, 927, 1705, 3136, 5768, 10609, 19513, 35890, 66012, 121415, 223317, 410744, 755476, 1389537, 2555757, 4700770, 8646064, 15902591, 29249425, 53798080, 98950096, 181997601, 334745777, 615693474, 1132436852...

Forma generale del numero Tribonacci:

a(n) = a(n-1) + a(n-2) + a(n-3)

dove: a(0) = a(1) = 0, a(2) = 1

Scrivere una funzione che calcola l'n-esimo numero di Tribonacci.

Soluzione ricorsiva:

(define (trib n)
  (if (or (= n 2) (= n 1) (zero? n))
      0
      (if (= n 3)
          1
          (+ (trib (- n 1)) (trib (- n 2)) (trib (- n 3)))
      )
  )
)

(trib 10)
;-> 44

(map trib (sequence 1 10))
;-> (0 0 1 1 2 4 7 13 24 44)

Complessità temporale: O(2^n) (esponenziale)

Una soluzione migliore è utilizzare la programmazione dinamica (cioè memorizzando e poi utilizzando i valori calcolati precedentemente):

(define (trib n)
  (local (a b c val)
    (setq a 0 b 0 c 1 val 0)
    (if (or (= 0 n) (= n 1) (= n 2))
        (setq val 0)
        (if (= n 3)
            (setq val 1)
            (for (i 3 (- n 1))
              (setq val (+ a b c))
              (setq a b b c c val)
            )
        )
    )
    val
  )
)

(map trib (sequence 1 10))
;-> (0 0 1 1 2 4 7 13 24 44)

Complessità temporale: O(n) (lineare)

Scriviamo una versione per i big-integer:

(define (trib-big n)
  (local (a b c val)
    (setq a 0L b 0L c 1L val 0L)
    (if (or (= 0 n) (= n 1) (= n 2))
        (setq val 0L)
        (if (= n 3)
            (setq val 1L)
            (for (i 3 (- n 1))
              (setq val (+ a b c))
              (setq a b b c c val)
            )
        )
    )
    val
  )
)

(trib-big 1000L)
;-> 443382579490226307661986241584270009256355236429858450381499235934108943134478901646797270328593836893366107162717822510963842586116043942479088674053663996392411782672993524690287662511197858910187264664163782145563472265666010074477859199789932765503984125240893L

Calcoliamo il limite del rapporto tra due numeri consecutivi di Tribonacci:

(div (trib-big 1000L) (trib-big 999L))
;-> 1.839286755214161

Esiste un algoritmo ancora più veloce che utilizza la moltiplicazioni tra matrici, ma la funzione "trib-big" è sufficientemente veloce.


-------------
NUMERI EUREKA
-------------

Un numero intero è un numero eureka se la somma delle potenze delle sue cifre, con le potenze crescenti in aumento, è uguale al numero stesso. Ad esempio, 89 è un numero eureka perché 8^1 + 9^2 = 89 e 1306 è un numero eureka perché 1^1 + 3^2 + 6^4 = 1306.
Scrivere una funzione per calcolare i numeri eureka fino al milione.
Maggiori informazioni:

https://oeis.org/A032799

Precalcoliamo i valori delle potenze (da 1 a 9) di ogni cifra. Per comodità creiamo una lista/matrice 10x10 "pot" in modo che si possa scrivere:

(pot 2 4)
;-> 16

(define (creapotenze)
  (let ((out '()) (row '()))
    (dotimes (i 10)
      (dotimes (j 10)
        (push (pow i j) row -1)
      )
      (push row out -1)
      (setq row '())
    )
    out
  )
)

(setq pot (creapotenze))
;-> ((1 0 0 0 0 0 0 0 0 0)
;->  (1 1 1 1 1 1 1 1 1 1)
;->  (1 2 4 8 16 32 64 128 256 512)
;->  (1 3 9 27 81 243 729 2187 6561 19683)
;->  (1 4 16 64 256 1024 4096 16384 65536 262144)
;->  (1 5 25 125 625 3125 15625 78125 390625 1953125)
;->  (1 6 36 216 1296 7776 46656 279936 1679616 10077696)
;->  (1 7 49 343 2401 16807 117649 823543 5764801 40353607)
;->  (1 8 64 512 4096 32768 262144 2097152 16777216 134217728)
;->  (1 9 81 729 6561 59049 531441 4782969 43046721 387420489))

Proviamo:

(pot 7 7)
;-> 823543

(pow 7 7)
;-> 823543

Da notare che possiamo calcolare numeri con al massimo 10 cifre, poichè la matrice "pot" contiene solo le prime dieci potenze (da 0 a 9) di ogni cifra (da 0 a 9).

Funzione che converte un intero in una lista di cifre

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(define (eureka num)
  (local (somma d out)
    (setq out '())
    (setq somma 0)
    (for (i 0 num)
      (setq j i)
      ; valore della potenza della cifra meno significativa
      ; cioè la cifra più a destra
      (setq d (length (string j)))
      ; somma delle potenze di ogni cifra
      ; partendo dalla cifra meno significativa (da destra)
      ; stop somma se somma > i (è più lento !!!)
      ;(while (and (!= j 0) (<= somma i))
      (while (!= j 0)
        (setq somma (+ somma (pot (% j 10) d)))
        (setq j (/ j 10))
        (-- d)
      )
      ; numero eureka?
      (if (= i somma) (push i out -1))
      (setq somma 0)
    )
    out
  )
)

(eureka 1e6)
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427)

(time (eureka 1e6))
;-> 2226.745

(eureka 3e6)
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427 2646798)

(time (eureka 3e6))
;-> 7266.561

Proviamo a riscrivere la funzione in stile funzionale.

Funzione che converte un numero in un a lista di cifre:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))) out))

Funzione che calcola i numeri eureka:

(define (eureka2 num)
  (let (out '())
    (dotimes (x num)
      (if (= x (apply + (map (fn (x) (pot x (+ $idx 1))) (int2list x))))
          (push x out -1)
      )
    )
    out
  )
)

(eureka2 1e6)
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427)

(time (eureka2 1e6))
;-> 2408

(eureka 3e6)
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427)

(time (eureka2 3e6))
;-> 7908.93

La versione iterativa è leggermente più veloce.

Il prossimo numero eureka vale: 12157692622039623539.
La nostra funzione non è in grado di calcolarlo...in tempo.

I numeri eureka sono un numero finito e l'ultimo termine ha un massimo di 22 cifre. Perchè?

Dato un numero naturale n di m cifre. Risulta che:

10^(m-1) <= n

e

n <= 9 + 9^2 + ... 9^m = 9*(9^m-1)/8 < (9^(m+1))/8

Quindi:

10^(m-1) < (9^(m+1))/8.

Facendo il logaritmo di entrambe le parti e risolvendo l'equazione si ottiene: m < 22.97.


-------------------
ABITAZIONI MULTIPLE
-------------------

I signori Baker, Cooper, Fletcher, Miller e Smith vivono su piani diversi in un condominio che ha cinque piani. Si conoscono le seguenti informazioni:

1) Baker non vive all'ultimo piano.
2) Cooper non vive al piano inferiore.
3) Fletcher non vive né al piano superiore né al piano inferiore.
4) Miller vive a un piano più alto di Cooper.
5) Smith non vive su un piano adiacente a quello di Fletcher.
6) Fletcher non vive su un piano adiacente a quello di Cooper.

Dove vivono tutti?

Possiamo risolvere questo problema utilizzando la funzione non-deterministica "amb".

(define (dove n)
  (local (i baker cooper fletcher miller smith found)
    (setq i 1 found nil)
    ; inizializzazione generatore random
    ; la funzione "amb" usa il generatore random
    (seed (time-of-day))
    (while (and (< i n) (= found nil))
      ; genera una disposizione random degli inquilini
      (setq baker (amb 1 2 3 4 5))
      (setq cooper (amb 1 2 3 4 5))
      (setq fletcher (amb 1 2 3 4 5))
      (setq miller (amb 1 2 3 4 5))
      (setq smith (amb 1 2 3 4 5))
      ; controllo dei vincoli
      (if (and (not (= baker 5))
               (not (= cooper 1))
               (not (= fletcher 5))
               (not (= fletcher 1))
               (> miller cooper)
               (not (= (abs (- smith fletcher)) 1))
               (not (= (abs (- fletcher cooper)) 1))
               (= (list baker cooper fletcher miller smith)
                  (unique (list baker cooper fletcher miller smith))))
          (begin ; soluzione trovata
            (setq found true)
            ; commentare println quando si usa la funzione "time"
            ;(println (list baker cooper fletcher miller smith))
            ;(println i)
          )
      )
      (++ i)
    )
    (if (not found)
        ; commentare println quando si usa la funzione "time"
        ;(println "...nessuna soluzione con " n " tentativi.")
        ;(println "...risolto.")
    )
  )
)

Il parametro n serve per limitare i tentativi di prova, altrimenti la funzione potrebbe girare all'infinito se la soluzione non esiste.

(dove 100)
;-> ...nessuna soluzione con 100 tentativi.

(dove 1000)
;-> (3 2 4 5 1)
;-> 293
;-> ...risolto

Il programma non è deterministico, infatti:

(dove 1000)
;-> ...nessuna soluzione con 1000 tentativi.

(dove 2000)
;-> ...nessuna soluzione con 2000 tentativi.

(dove 10000)
;-> (3 2 4 5 1)
;-> 224
;-> ...risolto.

(dove 10000)
;-> (3 2 4 5 1)
;-> 416
;-> ...risolto.

(dove 10000)
;-> (3 2 4 5 1)
;-> 3302
;-> ...risolto.

Un programma non deterministico ha un tempo di esecuzione variabile ogni volta che viene eseguito.

Possiamo scrivere anche una funzione deterministica che risolve il problema.
Numero di posizioni:
(* 5 5 5 5 5)
;-> 3125

(define (dove-d)
  (let (found nil)
    (for (baker 1 5 1 found)
     (for (cooper 1 5 1 found)
      (for (fletcher 1 5 1 found)
       (for (miller 1 5 1 found)
        (for (smith 1 5 1 found)
          ; controllo dei vincoli
          (if (and (not (= baker 5))
                   (not (= cooper 1))
                   (not (= fletcher 5))
                   (not (= fletcher 1))
                   (> miller cooper)
                   (not (= (abs (- smith fletcher)) 1))
                   (not (= (abs (- fletcher cooper)) 1))
                   (= (list baker cooper fletcher miller smith)
                      (unique (list baker cooper fletcher miller smith))))
              (begin ; soluzione trovata
                (setq found true)
                ; commentare println quando si usa la funzione "time"
                ;(println (list baker cooper fletcher miller smith))
              )
          );if
    )))));fors
    ; commentare println quando si usa la funzione "time"
    ;(if (not found) (println "nessuna soluzione."))
  );let
)

(dove-d)
;-> (3 2 4 5 1)

Vediamo la differenza di velocità tra le due funzioni.

Funzione non-deterministica (non ha un tempo di esecuzione costante):

(time (dove 100000) 1000)
;-> 1440.525

(time (dove 100000) 1000)
;-> 1126.112

Funzione deterministica (ha un tempo di esecuzione costante):

(time (dove-d) 1000)
;-> 838.496

(time (dove-d) 1000)
;-> 535.417

Comunque con diversi tentativi si possono ottenere risultati sorprendenti con la funzione non-deterministica:

(time (dove 100000) 1000)
;-> 392.759

In questo caso è stata più veloce della funzione deterministica.


------------------
TOZIENTE DI EULERO
------------------

La funzione φ (phi) di Eulero o funzione toziente, è una funzione definita, per ogni intero positivo n, come il numero degli interi compresi tra 1 e n che sono coprimi con n. Ad esempio, phi(8) = 4 poiché i numeri coprimi di 8 sono quattro: 1, 3, 5 e 7.

Funzione per verificare se due numeri sono coprimi:

(define (coprimi? a b) (= (gcd a b) 1))

Funzione per calcolare il toziente:

(define (toziente-coprimi num)
  (let (toz 0)
    (dotimes (i (- num 1))
      ;(println (+ i 1) { } num { } (coprimi? (+ i 1) num))
      (if (coprimi? (+ i 1) num)
          (++ toz)
          toz))))

(toziente-coprimi 8)
;-> 4
(toziente-coprimi 10090)
;-> 4032
(toziente-coprimi 5e6)
;-> 2000000

Questa funzione ha complessità temporale O(n).

Un'altro metodo per calcolare il toziente è quello di utilizzare la seguente formula:

phi(n) = n * [(1 - 1/p(1)) * (1 - 1/p(2)) * ... * (1 - 1/p(r))]

dove p(1), p(2), ... p(r) sono i fattori primi distinti del numero n.

Utilizzando la fattorizzazione, il problema ha la stessa complessità temporale di quella della fattorizzazione di un numero O(sqrt n).

(define (toziente-factor num)
  (let ((result num) (p 2))
    ; Per ogni fattore primo di n (fattore p),
    ; moltiplica il risultato per (1 - 1/p)
    (while (<= (* p p) num)
      ; Controlla se p è un fattore primo
      (if (= 0 (% num p))
          ; Se è vero, allora aggiorna num e il risultato
          (begin
          (while (= 0 (% num p)) (setq num (/ num p)))
          (setq result (mul result (sub 1 (div 1 p))))
          )
      )
      (++ p)
    )
    ; Se n ha un fattore primo maggiore di sqrt (n)
    ; (Può esserci al massimo uno di questi fattori primi)
    (if (> num 1)
        (setq result (mul result (sub 1 (div 1 num))))
    )
    (round result 0)
  )
)

(toziente-factor 8)
;-> 4
(toziente-factor 10090)
;-> 4032
(toziente-factor 5e6)
;-> 2000000

Per evitare i calcoli floating-point possiamo utilizzare il seguente metodo: contare tutti i fattori primi e i loro multipli e sottrarre questo conteggio da n per ottenere il valore della funzione toziente (i fattori primi e i multipli di fattori primi non hanno gcd = 1).

I passi da seguire sono i seguenti:

1) Inizializza il risultato come num
2) Considera ogni numero 'p' (dove 'p' varia da 2 a num).
    Se p divide n, procedi come segue
    a) Sottrai tutti i multipli di p da 1 a n (tutti i multipli di p
       hanno gcd maggiore di 1 (almeno p) con num)
    b) Aggiorna n dividendolo ripetutamente per p.
3) Se il valore ridotto di num è superiore a 1, rimuovi tutti i multipli
    di num dal risultato.

(define (toziente-factor-int num)
  (let ((result num) (i 2))
    (while (<= (* i i) num)
      (if (= 0 (% num i))
          (begin
          (while (= 0 (% num i)) (setq num (/ num i)))
          (setq result (- result (/ result i)))
          )
      )
      (++ i)
    )
    (if (> num 1)
        (setq result (- result (/ result num)))
    )
    result
  )
)

(toziente-factor-int 8)
;-> 4
(toziente-factor-int 10090)
;-> 4032
(toziente-factor-int 5e6)
;-> 2000000

Adesso scriviamo una nuova funzione per il calcolo del toziente utilizzando le primitive di newLISP (in stile LISP):

(define (toziente num)
    (if (= num 1) 1
    (round (mul num (apply mul (map (fn (x) (sub 1 (div 1 x))) (unique (factor num))))) 0)))

Calcola la lista dei fattori unici:
(unique (factor num))

Applica la funzione (1 - 1/p) agli elementi della lista dei fattori unici:
(map (fn (x) (sub 1 (div 1 x))) ...

Moltiplica n e tutti gli elementi della lista
(mul num (apply mul ...

(toziente 8)
;-> 4
(toziente 10090)
;-> 4032
(toziente 5e6)
;-> 200000

Non ci resta che verificare quale funzione è la più veloce.

(time (toziente-coprimi 5e6))
;-> 1325.904
(time (toziente-factor 5e6))
;-> 0
(time (toziente-factor-int 5e6))
;-> 0
(time (toziente 5e6))
;-> 0

Le ultime tre funzioni devono essere differenziate ripetendo il calcolo per un certo numero di volte (50000):

(time (toziente-factor 5e6) 50000)
;-> 119.114
(time (toziente-factor-int 5e6) 50000)
;-> 109.032
(time (toziente 5e6) 50000)
;-> 67.039

Il risultato è conforme alle aspettative logiche.


--------------
NUMERI VAMPIRI
--------------

Un numero del vampiro è un numero naturale composto v, con un numero pari di cifre n, che può essere fattorizzato in due interi x e y (chiamati zanne "faing") che non abbiano entrambi degli zeri finali e ognuno dei quali abbia n/2 cifre, dove v contiene precisamente tutte le cifre di x e y, in un ordine qualsiasi, contando la molteplicità.

Per esempio: 1260 è un numero del vampiro, le cui zanne sono 21 e 60 (dato che 21·60 = 1260): infatti, 1260 ha 4 cifre e 12 e 60 hanno entrambi 4/2 = 2 cifre, ed è inoltre formato da tutte le cifre di 21 e 60.

I primi numeri vampiro sono:

1260, 1395, 1435, 1530, 1827, 2187, 6880, 102510, 104260, 105210, 105264, 105750, 108135, 110758, 115672, 116725, 117067, 118440, 120600, 123354, 124483, 125248, 125433, 125460, 125500, ...

Proviamo a risolvere il problema con la forza bruta. Generiamo tutte le permutazioni delle cifre di un numero e poi verifichiamo se il prodotto tra la prima metà delle cifre della permutazione e la seconda metà delle cifre della permutazione è uguale al numero.

(define (list2int lst) (int (join (map string lst))))

(define (int2list n)  (map int (explode (string n))))

Funzione che calcola le permutazioni:

(define (perm lst)
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i)))
            (push lst out -1)
            (++ (indici i))
            (setq i 0))
          (begin
            (setf (indici i) 0)
            (++ i))))
    out))

Scriviamo la funzione:

(define (vampire n)
  (local (i-lst lun lst a b half)
    (for (i 1111 n)
      (setq i-lst (int2list i))
      (setq lun (length i-lst))
      (setq half (/ lun 2))
      (cond ((even? lun)
             (setq lst (unique (perm i-lst)))
             (dolist (el lst)
               (setq a (list2int (slice el 0 half)))
               (setq b (list2int (slice el half)))
               (if (= (* a b) i)
                 (println a { * } b { = } (* a b)))))))))

(vampire 2000)
;-> 21 * 60 = 1260
;-> 60 * 21 = 1260
;-> 93 * 15 = 1395
;-> 15 * 93 = 1395
;-> 41 * 35 = 1435
;-> 35 * 41 = 1435
;-> 51 * 30 = 1530
;-> 30 * 51 = 1530
;-> 21 * 87 = 1827
;-> 87 * 21 = 1827

(time (vampire 125000))
;-> 68708.184

Questo metodo è molto lento a causa della funzione che calcola le permutazioni.

Cerchiamo di risolvere il problema utilizzando le coppie di fattori.
Ogni numero può essere scomposto in fattori primi. Un fattore è quindi un qualsiasi sottoinsieme dei fattori primi moltiplicati tra loro. La coppia di fattori è il numero originale diviso per il fattore scelto.

Esempio:

Numero = 54
(factor 54)
;-> (2 3 3 3)
Sottoinsieme scelto = (2 3) = 2*3 = 6
Coppia di fattori = (6 (54 / 6)) = (6 9)

Per generare tutti i sottoinsiemi (tutti i fattori) utilizziamo la funzione "powerset-i":

(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(factor 1260)
;-> (2 2 3 3 5 7)

(powerset-i (factor 1260))
;-> ((2 2 3 3 5 7) (2 2 3 3 5) (2 2 3 3 7) (2 2 3 3) (2 2 3 5 7) (2 2 3 5) (2 2 3 7)
;->  (2 2 3) (2 2 3 5 7) (2 2 3 5) (2 2 3 7)
;->  ...
;->  (5 7) (5) (7) ())

Per generare i fattori applichiamo la funzione moltiplicazione "*" a tutti gli elementi do ogni sotto-lista:

(setq r (map (fn(x) (apply * x)) (powerset-i (factor 1260))))
;-> (1260 180 252 36 420 60 84 12 420 60 84 12 140 20 28 4 630 90 126 18 210
;->  30 42 6 210 30 42 6 70 10 14 2 630 90 126 18 210 30 42 6 210 30 42 6 70
;->  10 14 2 315 45 63 9 105 15 21 3 105 15 21 3 35 5 7 1)

Di questa lista a noi interessano solo i numeri che sono lunghi 2 cifre e che dividendo il numero base (1260) generano un numero con due cifre:

(setq r (unique (filter (fn(x) (and (= (length x) 2) (= (length (/ 1260 x)) 2))) r)))
;-> (36 60 84 20 28 90 18 30 42 70 14 45 63 15 21 35)

Da questa lista possiamo creare le coppie di fattori e verificare se le cifre di queste coppie sono le stesse di quelle del numero:

(dolist (el r)
  (setq a el)
  (setq b (/ 1260 el))
    (if (= (sort (append (int2list a) (int2list b))) (sort '(1 2 6 0)))
      (println a { } b { } 1260)))

;-> 60 21 1260
;-> 21 60 1260

Adesso possiamo scrivere la nuova funzione che calcola i numeri vampiri fino a n:

(define (vampire2 n)
  (local (lst lst2 i-lst lun a b h)
    (for (i 1 n)
      ;(setq lun (length i-lst))
      (setq lun (length i))
      (cond ((even? lun)
             (setq i-lst (int2list i))
             (setq h (/ (length i) 2))
             (setq lst (map (fn(x) (apply * x)) (powerset-i (factor i))))
             (setq lst2 (unique (filter (fn(x) (and (= (length x) h) (= (length (/ i x)) h))) lst)))
             (dolist (el lst2)
               (setq a el)
               (setq b (/ i el))
                 (if (= (sort (append (int2list a) (int2list b))) (sort i-lst))
                   (println a { * } b { = } i))
             )
            )
      )
    )
  )
)

(vampire2 2000)
;-> 60 * 21 = 1260
;-> 21 * 60 = 1260
;-> 15 * 93 = 1395
;-> 93 * 15 = 1395
;-> 35 * 41 = 1435
;-> 41 * 35 = 1435
;-> 30 * 51 = 1530
;-> 51 * 30 = 1530
;-> 21 * 87 = 1827
;-> 87 * 21 = 1827

(time (vampire2 125000))
;-> 4734.965

Questo metodo è molto più veloce e la funzione potrebbe essere ottimizzata, oppure si potrebbe utilizzare un importante risultato teorico trovato da Pete Hartley:

  Se x · y è un numero vampiro, allora x · y == x + y (mod 9)

Prova:
Sia mod l'operatore modulo binario e d(x) la somma delle cifre decimali di x.
È noto che d(x) mod 9 = x mod 9, per tutti i valori di x.
Supponiamo che x · y sia un vampiro. Quindi contiene le stesse cifre di xey, in particolare d(x · y) = d(x) + d(y). Questo porta a:
(x · y) mod 9 = d(x · y) mod 9 = (d(x) + d(y)) mod 9 = (d(x) mod 9 + d(y) mod 9) mod 9
              = (x mod 9 + y mod 9) mod 9 = (x + y) mod 9

Le soluzioni alla congruenza sono (x mod 9, y mod 9) in ((0 0) (2 2) (3 6) (5 8) (6 3) (8 5)). Solo questi casi (6 su 81) devono essere testati nella ricerca di vampiri basata sul test di x · y per valori diversi di x e y.

Esempio:

(setq num 1260)

(define (faing? x y)
  (true? (find (list (% x 9) (% y 9))
               '((0 0) (2 2) (3 6) (5 8) (6 3) (8 5)))))

(faing? 12 60)
;-> true

Formula di Roushe e Rogers per generare numeri vampiri:

  1·10^(2n+3) + 524·10^(n+1) + 208 = (25·10^(n) + 1 · (40·10^n + 208)

Questa formula produce numeri vampiri con (2n + 4) cifre.

n = 2  ==>  10524208 = 2501 · 4208
n = 3  ==>  1005240208 = 25001 · 40208

Ma per adesso basta con i numeri vampiri.


----------------
IL GIOCO DEL NIM
----------------

Nim è un gioco in cui due persone alternativamente rimuovono alcuni elementi disposti in una serie di righe partendo da una posizione iniziale. Si inizia con una serie di righe contenenti un certo numero di elementi (il numero delle righe e degli elementi di ogni riga possono essere qualunque numero intero e sono concordati tra i giocatori all'inizio della partita). I giocatori, a turno, tolgono da una qualsiasi riga un numero di elementi a piacere, da uno a tutti. Vince chi toglie l'ultimo elemento presente. Non è possibile passare (saltare la mossa).
Esiste anche una variante chiamata Marienbad in cui chi toglie l'ultimo elemento perde.

Esempio di posizione iniziale:

        |          riga: 0 - elementi: 1
      | | |        riga: 1 - elementi: 3
    | | | | |      riga: 2 - elementi: 5
  | | | | | | |    riga: 3 - elementi: 7

La strategia di gioco è la seguente:

1) se (n1 xor n2 xor ... nk = 0), scegliere una mossa casuale valida (poichè non esiste una mossa vincente)

2) se (n1 xor n2 xor ... nk != 0), scegliere la mossa che rende (n1 xor n2 xor ... nk = 0).

Non svilupperemo un programma completo, ma solo le funzioni per giocare interattivamente.

Rappresentiamo una posizione con una lista: l'indice della lista rappresenta il numero di riga, mentre il relativo valore rappresenta il numero di elementi presenti nella riga.

Utilizzeremo due variabili globali per tenere traccia della posizione iniziale (*start*) e della posizione corrente (*current*): questo rende più semplice l'interazione con la REPL durante una partita

Esempio:
(setq *start* '(1 3 5 7))
(setq *current* '(0 2 3 7))

Funzione che stampa la posizione corrente:

(define (show-position)
  (local (triple)
    (setq big (apply max *start*))
    (setq space (map (fn(x) (+ big 1 (- x))) *start*))
    (setq triple (map list *start* *current* space))
    (dolist (el triple)
      (print (dup " " (el 2)))
      (print (dup ". " (- (el 0) (el 1))))
      (print (dup "| " (el 1)))
      (println)
    )
    '...
  )
)

Funzione per iniziare una nuova partita:

(define (nim start-position current-position)
  (setq *start* start-position)
  (setq *current* current-position)
  (show-position))

(nim '(1 3 5 7) '(1 3 5 7))
;->        |
;->      | | |
;->    | | | | |
;->  | | | | | | |
;-> ...

Funzione che calcola lo xor di una posizione:

(define (calc-xor position) (apply ^ position))

Funzione che verifica se una posizione è vincente per il giocatore di turno:
Se il calcolo dello xor della posizione attuale vale 0, allora non è una posizione vincente.
Se il calcolo dello xor della posizione attuale è diverso da zero, allora è una posizione vincente.
Da una posizione vincente la mossa vincente è quella che rende zero il calcolo dello xor della nuova posizione.

(define (canwin? position) (if (zero? (calc-xor position)) nil true))

Funzione che verifica la fine del gioco:

(define (game-end?)
  (if (zero? (apply + *current*)) true nil))

Funzione che genera e applica una mossa del computer alla posizione corrente:

(define (move-ai)
  (local (found sol)
    ; ricerca una mossa vincente
    (setq found nil)
    (dolist (el *current* found)
      (if (!= el 0)
        (for (i 1 el 1 found)
          (setq test *current*)
          (setq (test $idx) (- el i))
          (if (not (canwin? test))
            (begin
              (setq sol (list $idx i))
              (setq found true)))
        )
      )
    )
    ; se non esiste alcuna mossa vincente,
    ; allora genera una mossa casuale valida.
    ; Toglie un elemento dalla prima riga non vuota...
    (dolist (el *current* found)
      (if (not (zero? el)) (begin
          (setq sol (list $idx 1))
          (setq found true)))
    )
    (if found (begin
        (setf (*current* (first sol)) (- (*current* (first sol)) (last sol)))
        (println "row: " (first sol) { - } "elementi: " (last sol))
        (show-position *start* *current*)
        (if (game-end?) (println "I WIN !!!"))
        )
        (println "Error: search move"))
  )
)

Funzione che applica una mossa dell'utente alla posizione corrente:

(define (move-human mossa)
  (local (ok riga elementi)
    (setq ok nil)
    (until ok
      (setq out mossa)
      (cond ((!= 2 (length out))
             (setq ok true)
             (println "Error: only two value"))
            (true
             (setq riga (first out))
             (setq elementi (last out))
             (cond ((or (not (integer? riga)) (not (integer? elementi)))
                    (setq ok true)
                    (println "Error: only integer value"))
                   ((>= riga (length *current*))
                    (setq ok true)
                    (println "Error: row not found: " riga))
                   ((> elementi (*current* riga))
                    (setq ok true)
                    (println "Error: can't remove " elementi " elements from row " riga))
                   (true ; applica la mossa (validata) alla posizione corrente
                     (setq ok true)
                     (setf (*current* riga) (- (*current* riga) elementi))
                     (println "row: " riga { - } "elementi: " elementi)
                     (show-position *start* *current*)
                     (if (game-end?) (println "YOU WIN !!!"))
                   )
             )
            )
       )
     )
  )
)

Giochiamo una partita:

(nim '(1 3 5 7) '(1 3 5 7))
;->        |
;->      | | |
;->    | | | | |
;->  | | | | | | |
;-> ...

(canwin? '(1 3 5 7))
;-> nil

(move-human '(0 1))
;-> row: 0 - elementi: 1
;->        .
;->      | | |
;->    | | | | |
;->  | | | | | | |

(move-ai)
row: 1 - elementi: 1
;->        .
;->      . | |
;->    | | | | |
;->  | | | | | | |
;-> ...

(move-human '(3 6))
;-> row: 3 - elementi: 6
;->        .
;->      . | |
;->    | | | | |
;->  . . . . . . |
;-> ...

(move-ai)
;-> row: 2 - elementi: 2
;->        .
;->      . | |
;->    . . | | |
;->  . . . . . . |
;-> ...

(move-human '(2 1))
;-> row: 2 - elementi: 1
;->        .
;->      . | |
;->    . . . | |
;->  . . . . . . |
;-> ...

(move-ai)
;-> row: 3 - elementi: 1
;->        .
;->      . | |
;->    . . . | |
;->  . . . . . . .
;-> ...

(move-human '(2 2))
;-> row: 2 - elementi: 2
;->        .
;->      . | |
;->    . . . . .
;->  . . . . . . .
;-> ...

(move-ai)
;->        .
;->      . . .
;->    . . . . .
;->  . . . . . . .
;-> I WIN !!!


------------------------------
FIBONACCI SEQUENZE DI N-NUMERI
------------------------------

Scrivere una funzione per generare le sequenze di Fibonacci in base al valore di n.

 n   Nome         Valori
 2   fibonacci    1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 ...
 3   tribonacci   1 1 2 4 7 13 24 44 81 149 274 504 927 1705 3136 ...
 4   tetranacci   1 1 2 4 8 15 29 56 108 208 401 773 1490 2872 5536 ...
 5   pentanacci   1 1 2 4 8 16 31 61 120 236 464 912 1793 3525 6930 ...
 6   hexanacci    1 1 2 4 8 16 32 63 125 248 492 976 1936 3840 7617 ...
 7   heptanacci   1 1 2 4 8 16 32 64 127 253 504 1004 2000 3984 7936 ...
 8   octonacci    1 1 2 4 8 16 32 64 128 255 509 1016 2028 4048 8080 ...
 9   nonanacci    1 1 2 4 8 16 32 64 128 256 511 1021 2040 4076 8144 ...
10   decanacci    1 1 2 4 8 16 32 64 128 256 512 1023 2045 4088 8172 ...

La funzione "iterate" crea una lista applicando n volte una funzione ad una lista iniziale.
Vediamo il funzionamento in particolare con un esempio:

- la lista iniziale vale (1 2 3)
- la funzione da applicare è "+"
- il numero di iterazioni vale 3

1. applichiamo la funzione alla lista: (apply + '(1 2 3)) = 4
2. aggiungiamo il valore (4) alla lista: (1 2 3 4)
3. applichiamo la funzione alla lista,
   prendendo solo gli ultimi 3 elementi della lista: (apply + '(2 3 4)) = 9
   (perchè la lista iniziale aveva tre elementi)
4. continua come al punto 2 per la prossima iterazione.

La funzione può essere scritta nel seguente modo:

(define (iterate iter func lst)
  (let ((out lst)
        (cur '())
        (len (length lst)))
    (dotimes (x iter)
      (setq cur (slice out (- len)))
      (push (apply func cur) out -1)
    )
    out))

Oppure in modo più conciso:

(define (iterate iter func lst)
  (let ((out lst) (len (length lst)))
    (dotimes (x iter)
      (push (apply func (slice out (- len))) out -1)
    )
    out))

Vediamo il nostro esempio:

(iterate 5 + '(1 2 3))
;-> (1 2 3 6 11 20 37 68)

Invece per calcolare i numeri Pentabonacci:

(iterate 10 + '(0 1 1 2 4))
;-> (0 1 1 2 4 8 16 31 61 120 236 464 912 1793 3525)

(iterate 20 + '(0 1 1 2 4))
;-> (0 1 1 2 4 8 16 31 61 120 236 464 912 1793 3525 6930 13624
;->  26784 52656 103519 203513 400096 786568 1546352 3040048)

Numeri di Fibonacci:

(iterate 10 + '(1 1))
;-> (1 1 2 3 5 8 13 21 34 55 89 144)

Numeri di Tribonacci:

(iterate 10 + '(0 0 1))
;-> (0 0 1 1 2 4 7 13 24 44 81 149 274)

Possiamo usare anche altre funzioni:

(iterate 10 - '(0 1 1 2 4))
;-> (0 1 1 2 4 -8 2 1 3 6 -20 12 0 5 9)

Per utilizzare i numeri big-integer:

(iterate 100 + '(0L 1L 1L 2L 4L))
;-> (0L 1L 1L 2L 4L 8L 16L 31L 61L 120L 236L 464L
;->  ...
;->  930350798981478627292926391581L)

Vediamo le sequenze di Fibonacci:
n = 2
(iterate 10 + '(1 1))
;-> (1 1 2 3 5 8 13 21 34 55 89 144)
n = 3
(iterate 10 + '(1 1 2))
;-> (1 1 2 4 7 13 24 44 81 149 274 504 927)
n = 4
(iterate 10 + '(1 1 2 4))
;-> (1 1 2 4 8 15 29 56 108 208 401 773 1490 2872)
n = 5
(iterate 10 + '(1 1 2 4 8))
;-> (1 1 2 4 8 16 31 61 120 236 464 912 1793 3525 6930)
n = 6
(iterate 10 + '(1 1 2 4 8 16))
;-> (1 1 2 4 8 16 32 63 125 248 492 976 1936 3840 7617 15109)
n = 7
(iterate 10 + '(1 1 2 4 8 16 32))
;-> (1 1 2 4 8 16 32 64 127 253 504 1004 2000 3984 7936 15808 31489)
n = 8
(iterate 10 + '(1 1 2 4 8 16 32 64))
;-> (1 1 2 4 8 16 32 64 128 255 509 1016 2028 4048 8080 16128 32192 64256)
n = 9
(iterate 10 + '(1 1 2 4 8 16 32 64 128))
;-> (1 1 2 4 8 16 32 64 128 256 511 1021 2040 4076 8144 16272 32512 64960 129792)
n = 10
(iterate 10 + '(1 1 2 4 8 16 32 64 128 256))
;-> (1 1 2 4 8 16 32 64 128 256 512 1023 2045 4088 8172 16336 32656 65280 130496 260864)


---------------------------------
IL PROBLEMA DEI MATRIMONI STABILI
---------------------------------

Il problema del matrimoni stabili è un nome semplice che rappresenta un problema molto importante. In economia questo intende ogni problema che richieda di allocare un gruppo di risorse di un insieme A con un gruppo di risorse di un insieme B in maniera tale da formare dei gruppi stabili (nella versione base si parla di coppie, ma è estendibile).

La definizione originale del problema è la seguente:
dato n uomini e n donne, dove ogni persona ha classificato tutti i membri del sesso opposto in ordine di preferenza, si accoppiano uomini e donne insieme in modo tale che non ci siano due persone di sesso opposto che preferirebbero stare tra loro rispetto ai loro attuali partner. Quando non esistono coppie di questo tipo, l'insieme dei matrimoni è considerato stabile.

I matematici americani Dave Gale e Lloyd Shapley pubblicarono un algoritmo di soluzione nel 1962 dimostrando che il problema del matrimonio stabile ammette sempre una soluzione.

L’algoritmo di Gale e Shapley consente di individuare una soluzione stabile. Nel 1971 Mc Vitie e Wilson hanno pubblicato un algoritmo che consente di trovare tutte le soluzioni stabili del problema.

La soluzione proposta è un adattamento del programma in Java presentato all'indirizzo web:

https://www.sanfoundry.com/java-program-gale-shapley-algorithm/

In questo modo possiamo vedere come possono essere tradotte in newLISP alcune espressioni/costrutti del linguaggio Java. Inoltre la nomenclatura è stata lasciata in lingua inglese.

La struttura dei dati di input è la seguente:

Men:   ("M1" "M2" "M3" "M4" "M5")
Women: ("W1" "W2" "W3" "W4" "W5")

Men preferenze:
(("W5" "W2" "W3" "W4" "W1")
 ("W2" "W5" "W1" "W3" "W4")
 ("W4" "W3" "W2" "W1" "W5")
 ("W1" "W2" "W3" "W4" "W5")
 ("W5" "W2" "W3" "W4" "W1"))

Women preferenze:
(("M5" "M3" "M4" "M1" "M2")
 ("M1" "M2" "M3" "M5" "M4")
 ("M4" "M5" "M3" "M2" "M1")
 ("M5" "M2" "M1" "M4" "M3")
 ("M2" "M1" "M4" "M3" "M5"))

Lo pseudocodice dell'algoritmo è il seguente:

Algorithm Gale-Shapley
    Initialize all m of M and w of W to free
    while exist free man m who still has a woman w to propose to
    (
       w = m's highest ranked such woman to whom he has not yet proposed
       if w is free
         (m, w) become engaged
       else some pair (m', w) already exists
         if w prefers m to m'
           (m, w) become engaged
           m' becomes free
         else
           (m', w) remain engaged
    )

Di seguito viene riportato il codice in Java:

"
/** Java Program to Implement Gale Shapley Algorithm **/
/**
 Gale Shapley Algorithm is used to solve the stable marriage problem (SMP). SMP is the problem of finding a stable matching between two sets of elements given a set of preferences for each element.
**/
/** Class GaleShapley **/
public class GaleShapley
{
    private int N, engagedCount;
    private String[][] menPref;
    private String[][] womenPref;
    private String[] men;
    private String[] women;
    private String[] womenPartner;
    private boolean[] menEngaged;

    /** Constructor **/
    public GaleShapley(String[] m, String[] w, String[][] mp, String[][] wp)
    {
        N = mp.length;
        engagedCount = 0;
        men = m;
        women = w;
        menPref = mp;
        womenPref = wp;
        menEngaged = new boolean[N];
        womenPartner = new String[N];
        calcMatches();
    }
    /** function to calculate all matches **/
    private void calcMatches()
    {
        while (engagedCount < N)
        {
            int free;
            for (free = 0; free < N; free++)
                if (!menEngaged[free])
                    break;
            for (int i = 0; i < N && !menEngaged[free]; i++)
            {
                int index = womenIndexOf(menPref[free][i]);
                if (womenPartner[index] == null)
                {
                    womenPartner[index] = men[free];
                    menEngaged[free] = true;
                    engagedCount++;
                }
                else
                {
                    String currentPartner = womenPartner[index];
                    if (morePreference(currentPartner, men[free], index))
                    {
                        womenPartner[index] = men[free];
                        menEngaged[free] = true;
                        menEngaged[menIndexOf(currentPartner)] = false;
                    }
                }
            }
        }
        printCouples();
    }
    /** function to check if women prefers new partner over old assigned partner **/
    private boolean morePreference(String curPartner, String newPartner, int index)
    {
        for (int i = 0; i < N; i++)
        {
            if (womenPref[index][i].equals(newPartner))
                return true;
            if (womenPref[index][i].equals(curPartner))
                return false;
        }
        return false;
    }
    /** get men index **/
    private int menIndexOf(String str)
    {
        for (int i = 0; i < N; i++)
            if (men[i].equals(str))
                return i;
        return -1;
    }
    /** get women index **/
    private int womenIndexOf(String str)
    {
        for (int i = 0; i < N; i++)
            if (women[i].equals(str))
                return i;
        return -1;
    }
    /** print couples **/
    public void printCouples()
    {
        System.out.println("Couples are : ");
        for (int i = 0; i < N; i++)
        {
            System.out.println(womenPartner[i] +" "+ women[i]);
        }
    }
    /** main function **/
    public static void main(String[] args)
    {
        System.out.println("Gale Shapley Marriage Algorithm\n");
        /** list of men **/
        String[] m = {"M1", "M2", "M3", "M4", "M5"};
        /** list of women **/
        String[] w = {"W1", "W2", "W3", "W4", "W5"};
        /** men preference **/
        String[][] mp = {{"W5", "W2", "W3", "W4", "W1"},
                         {"W2", "W5", "W1", "W3", "W4"},
                         {"W4", "W3", "W2", "W1", "W5"},
                         {"W1", "W2", "W3", "W4", "W5"},
                         {"W5", "W2", "W3", "W4", "W1"}};
        /** women preference **/
        String[][] wp = {{"M5", "M3", "M4", "M1", "M2"},
                         {"M1", "M2", "M3", "M5", "M4"},
                         {"M4", "M5", "M3", "M2", "M1"},
                         {"M5", "M2", "M1", "M4", "M3"},
                         {"M2", "M1", "M4", "M3", "M5"}};
        GaleShapley gs = new GaleShapley(m, w, mp, wp);
    }
}
"

Adesso vediamo l'implementazione in newLISP in cui ho cercato di mantenere il codice newLISP il più possibile fedele all'originale:

(define (gs m w mp wp)
  (local (N engagedCount menPref womenPref men women womenPartner menEngaged
          free cont i j km kw ind currentPartner pref res)
    (setq N (length mp))
    (setq engagedCount 0) ;
    (setq men m)   ; array of men (string)
    (setq women w) ; array of women (string)
    (setq menPref mp)   ; array of array of men preferences (string)
    (setq womenPref wp) ; array of array women preferences (string)
    (setq menEngaged (array N '(nil)))   ; boolean array
    (setq womenPartner (array N '(""))) ; string array
    ; function: calcMatches
    (define (calcMatches)
      (while (< engagedCount N)
        ;(println "engaged: " engagedCount)
        (setq free 0)
        (setq cont true)
        (while (and (< free N) cont)
          (if (null? (menEngaged free))
              (setq cont nil)
              (++ free))
        )
        (setq i 0)
        (setq cont true)
        (while (and (< i N) (null? (menEngaged free)))
          ;(println "i: " i " free: " free)
          (setq ind (womenIndexOf (menPref free i)))
          (if (null? (womenPartner ind))
            (begin
             (setf (womenPartner ind) (men free))
             (setf (menEngaged free) true)
             (++ engagedCount))
            ;else
            (begin
             (setq currentPartner (womenPartner ind))
             (if (morePreference currentPartner (men free) ind)
              (begin
               (setf (womenPartner ind) (men free))
               (setf (menEngaged free) true)
               (setf (menEngaged (menIndexOf currentPartner)) nil))
             ))
          )
          (++ i)
        )
      )
    )
    ; function: morePreference
    (define (morePreference curPartner newPartner idx)
      (setq res nil)
      (setq j 0)
      (setq cont true)
      (while (and (< j N) cont)
        (cond ((= (womenPref idx j) newPartner)
               (setq cont nil)
               (setq res true))
              ((= (womenPref idx j) curPartner)
               (setq cont nil)
               (setq res nil))
        )
        (++ j)
      )
      res)
    ; function: menIndexOf
    (define (menIndexOf str)
      (setq km 0)
      (setq cont true)
      (while (and (< km N) cont)
        (if (= (men km) str)
            (setq cont nil)
            (++ km))
      )
      ;(if (= i N) -1 i)
      (if (= km N) nil km)
    )
    ; function: womenIndexOf
    (define (womenIndexOf str)
      (setq kw 0)
      (setq cont true)
      (while (and (< kw N) cont)
        (if (= (women kw) str)
            (setq cont nil)
            (++ kw))
      )
      ;(if (= i N) -1 i)
      (if (= kw N) nil kw)
    )
    ;
    (define (printCouples)
      (dolist (el womenPartner)
        (println el { } (women $idx)))
    )
    ;
    ; Calculate solution
    (calcMatches)
    ; Print solution
    (printCouples)
    'end
  ))

Assegniamo i valori iniziali:

Array of Men:

(setq mm '("M1" "M2" "M3" "M4" "M5"))
(setq m (array 5 mm))

Array of Women:

(setq ww '("W1" "W2" "W3" "W4" "W5"))
(setq w (array 5 ww))

Array of Men preference:

(setq mmp '(("W5" "W2" "W3" "W4" "W1")
           ("W2" "W5" "W1" "W3" "W4")
           ("W4" "W3" "W2" "W1" "W5")
           ("W1" "W2" "W3" "W4" "W5")
           ("W5" "W2" "W3" "W4" "W1")))
(setq mp (array 5 5 (flat mmp)))

Array of Women preference:

(setq wwp '(("M5" "M3" "M4" "M1" "M2")
           ("M1" "M2" "M3" "M5" "M4")
           ("M4" "M5" "M3" "M2" "M1")
           ("M5" "M2" "M1" "M4" "M3")
           ("M2" "M1" "M4" "M3" "M5")))
(setq wp (array 5 5 (flat wwp)))

Proviamo la funzione:

(gs m w mp wp)
;-> M4 W1
;-> M2 W2
;-> M5 W3
;-> M3 W4
;-> M1 W5
;-> end

Attenzione, questo algoritmo permette di trovare una soluzione stabile, non ottima.
Alcune coppie potrebbero essere ottime (banalmente se la prima scelta di un x e un y combaciano), ma non è necessario che lo siano. Anzi, è molto probabile che ciascun elemento ottenga la sua seconda o terza scelta (o, al crescere del numero di persone, anche scelte molto peggiori). Inoltre se un elemento riceve una sola proposta sarà costretto ad accettarla, non importa quanto sia in basso nella sua scala delle preferenze.
È opportuno osservare che l’algoritmo produce sempre la soluzione ottimale per ciascun elemento del gruppo che propone e al tempo stesso produce la soluzione peggiore per ciascun elemento dell'altro gruppo.
Quindi se il gruppo che propone fosse una volta quello degli uomini e una volta quello delle donne otterremmo due risultati diversi, entrambi i risultati però sarebbero completi e costituiti solo da coppie stabili (ottimali per il gruppo proponente).
Di fatto l’algoritmo garantisce che ogni coppia formata non possa "trovare di meglio" e che quindi non abbia motivo per rompersi. E questo è il risultato migliore a cui si può aspirare.

Nota: nei problemi pratici occorre considerare anche i casi generali in cui gli insiemi sono di cardinalità differente e/o le liste di preferenza sono incomplete.

L'algoritmo di Gale-Shapley viene usato in tutto il mondo: in Danimarca per l'assegnazione di bambini agli asili, in Ungheria per l'iscrizione di bambini alle scuole, a New York per la scelta dei rabbini alle sinagoghe, in Cina, Germania e Spagna per gli studenti delle università, nel Regno Unito l'algoritmo è stato il punto di partenza per elaborare un metodo ottimale per associare organi a pazienti bisognosi di trapianti...

Vediamo un altro esempio (Rosetta code):

(setq mm (map string '(abe bob col dan ed fred gav hal ian jon)))
(setq m (array 10 mm))

(setq ww (map string '(abi bea cath dee eve fay gay hope ivy jan)))
(setq w (array 10 ww))

(setq mmp (map string (flat '((abi eve cath ivy jan dee fay bea hope gay)
            (cath hope abi dee eve fay bea jan ivy gay)
            (hope eve abi dee bea fay ivy gay cath jan)
            (ivy fay dee gay hope eve jan bea cath abi)
            (jan dee bea cath fay eve abi ivy hope gay)
            (bea abi dee gay eve ivy cath jan hope fay)
            (gay eve ivy bea cath abi dee hope jan fay)
            (abi eve hope fay ivy cath jan bea gay dee)
            (hope cath dee gay bea abi fay ivy jan eve)
            (abi fay jan gay eve bea dee cath ivy hope)))))
(setq mp (array 10 10 (flat mmp)))

(setq wwp (map string (flat '((bob fred jon gav ian abe dan ed col hal)
            (bob abe col fred gav dan ian ed jon hal)
            (fred bob ed gav hal col ian abe dan jon)
            (fred jon col abe ian hal gav dan bob ed)
            (jon hal fred dan abe gav col ed ian bob)
            (bob abe ed ian jon dan fred gav col hal)
            (jon gav hal fred bob abe col ed dan ian)
            (gav jon bob abe ian dan hal ed col fred)
            (ian col hal gav fred bob abe ed jon dan)
            (ed hal gav abe bob jon col ian fred dan)))))
(setq wp (array 10 10 (flat wwp)))

(gs m w mp wp)
;-> jon abi
;-> fred bea
;-> bob cath
;-> col dee
;-> hal eve
;-> dan fay
;-> gav gay
;-> ian hope
;-> abe ivy
;-> ed jan
;-> end

Cerchiamo adesso di scrivere una funzione che controlla se una data soluzione è stabile o meno. Una soluzione non è stabile se risultano vere entrambe le seguenti condizioni:

1) Esiste un elemento A del primo gruppo (a) che preferisce un elemento B del secondo gruppo (b) all'elemento a cui A è stato abbinato e
2) l'elemento b di B preferisce a di A all'elemento a cui è stato abbinato.

In altre parole, una soluzione è stabile quando non esiste alcuna coppia (a di A e b di B) in cui entrambi si preferiscono l'un l'altro rispetto al loro partner attuale.

Utilizziamo i dati del primo esempio:

(setq mm '("M1" "M2" "M3" "M4" "M5"))
(setq m (array 5 mm))
(setq ww '("W1" "W2" "W3" "W4" "W5"))
(setq w (array 5 ww))
(setq mmp '(("W5" "W2" "W3" "W4" "W1")
           ("W2" "W5" "W1" "W3" "W4")
           ("W4" "W3" "W2" "W1" "W5")
           ("W1" "W2" "W3" "W4" "W5")
           ("W5" "W2" "W3" "W4" "W1")))
(setq mp (array 5 5 (flat mmp)))
(setq wwp '(("M5" "M3" "M4" "M1" "M2")
           ("M1" "M2" "M3" "M5" "M4")
           ("M4" "M5" "M3" "M2" "M1")
           ("M5" "M2" "M1" "M4" "M3")
           ("M2" "M1" "M4" "M3" "M5")))
(setq wp (array 5 5 (flat wwp)))

Calcoliamo la soluzione:

(gs m w mp wp)
;-> M4 W1
;-> M2 W2
;-> M5 W3
;-> M3 W4
;-> M1 W5
;-> end

(setq sol '(("M1" "W5") ("M2" "W2") ("M3" "W4") ("M4" "W1") ("M5" "W3")))

Per seguire meglio il metodo di soluzione modifichiamo e stampiamo i dati:

(define (check-sol sol mmp wwp)
  (local (i j k stable men women theman thewoman pos-woman pos-men idx-m idx-w
          uomini donne prefU prefD link pos ind-uomo ind-donna
          ind-uomo ind-uomo-accoppiato)
    (setq stable true)
    (sort sol)
    (setq men (sort (map (fn(x) (first x)) sol)))
    (setq women (sort (map (fn(x) (last x)) sol)))
    (setq uomini '())
    (setq donne '())
    (setq prefU '())
    (setq prefD '())
    (setq link '())
    ; preferenze degli uomini
    (println "Preferenze M")
    (dolist (el mmp)
      (print "M" $idx ": ")
      (dolist (pref el)
        (print (first (ref pref women)) { })
        (push (first (ref pref women)) prefU -1)
      )
      (println)
    )
    (setq prefU (explode prefU 5))
    ; preferenze delle donne
    (println "Preferenze W")
    (dolist (el wwp)
      (print "W" $idx ": ")
      (dolist (pref el)
        (print (first (ref pref men)) { })
        (push (first (ref pref men)) prefD -1)
      )
      (println)
    )
    (setq prefD (explode prefD 5))
    ; accoppiamenti
    (println "M p  W p")
    (setq i 0)
    (while (< i (length sol))
      (setq theman (first (sol i)))
      (setq thewoman (last (sol i)))
      (setq pos-woman (first (ref thewoman (mmp i))))
      (setq pos-man (first (ref theman (wwp (first (ref thewoman ww))))))
      (setq idx-m i)
      (setq idx-w (first (ref thewoman women)))
      ;(println idx-m { } idx-w { } theman { } thewoman { } pos-woman { } pos-man)
      (println i { } pos-woman {  } idx-w { } pos-man)
      (push idx-m uomini -1)
      (push idx-m donne -1)
      (push (list i pos-woman idx-w pos-man) link -1)
      (++ i)
    )
  )
)

Eseguiamo la funzione:

(check-sol sol mmp wwp)
;-> Preferenze M
;-> M0: 4 1 2 3 0
;-> M1: 1 4 0 2 3
;-> M2: 3 2 1 0 4
;-> M3: 0 1 2 3 4
;-> M4: 4 1 2 3 0
;-> Preferenze W
;-> W0: 4 2 3 0 1
;-> W1: 0 1 2 4 3
;-> W2: 3 4 2 1 0
;-> W3: 4 1 0 3 2
;-> W4: 1 0 3 2 4
;-> M p  W p
;-> 0 0  4 1
;-> 1 0  1 1
;-> 2 0  3 4
;-> 3 0  0 2
;-> 4 2  2 1

Analizziamo la situazione per verificare la stabilità:
tutti gli M che sono accoppiati con valore 0 (colonna p per M) hanno la scelta migliore, quindi non hanno motivo di cambiare. Vediamo l'unico elemento M che non è accoppiato con valore 0, cioè M4.
M4 è accoppiato con W2 (con valore 2), ma preferisce di più W4 e W1.
W4 è accoppiata con M0 con valore 1 e (per W4) M4 vale 4, quindi W4 preferisce restare con M0.
W1 è accoppiata con M1 con valore 1 e (per W1) M4 vale 3, quindi W1 preferisce restare con M1.

Adesso possiamo scrivere la funzione che controlla la stabilità:

(define (check-sol sol mmp wwp)
  (local (i j k stable men women theman thewoman pos-woman pos-men idx-m idx-w
          uomini donne prefU prefD link pos ind-uomo ind-donna
          ind-uomo ind-uomo-accoppiato)
    (setq stable true)
    (sort sol)
    (setq men (sort (map (fn(x) (first x)) sol)))
    (setq women (sort (map (fn(x) (last x)) sol)))
    (setq uomini '())
    (setq donne '())
    (setq prefU '())
    (setq prefD '())
    (setq link '())
    ; preferenze degli uomini
    (println "Preferenze M")
    (dolist (el mmp)
      (print "M" $idx ": ")
      (dolist (pref el)
        (print (first (ref pref women)) { })
        (push (first (ref pref women)) prefU -1)
      )
      (println)
    )
    (setq prefU (explode prefU 5))
    ; preferenze delle donne
    (println "Preferenze W")
    (dolist (el wwp)
      (print "W" $idx ": ")
      (dolist (pref el)
        (print (first (ref pref men)) { })
        (push (first (ref pref men)) prefD -1)
      )
      (println)
    )
    (setq prefD (explode prefD 5))
    ; accoppiamenti
    (println "M p  W p")
    (setq i 0)
    (while (< i (length sol))
      (setq theman (first (sol i)))
      (setq thewoman (last (sol i)))
      (setq pos-woman (first (ref thewoman (mmp i))))
      (setq pos-man (first (ref theman (wwp (first (ref thewoman ww))))))
      (setq idx-m i)
      (setq idx-w (first (ref thewoman women)))
      ;(println idx-m { } idx-w { } theman { } thewoman { } pos-woman { } pos-man)
      (println i { } pos-woman {  } idx-w { } pos-man)
      (push idx-m uomini -1)
      (push idx-m donne -1)
      (push (list i pos-woman idx-w pos-man) link -1)
      (++ i)
    )
    ;(println uomini)
    ;(println donne)
    ;(println prefU)
    ;(println prefD)
    ;(println link)
    ;
    ; check stability
    ;
    (dolist (cur-link link)
      ;(println cur-link { } $idx)
      (setq idx-link $idx)
      ; controllo solo accoppiamenti non ottimali
      (if (> (cur-link 1) 0)
        (begin
         ;(println (cur-link 1) { } $idx)
         (setq pos (- (cur-link 1) 1))
         (while (> pos -1)
           (println "uomo corrente: " idx-link)
           ; indice donna migliore di quella attuale
           (setq ind-donna (prefU idx-link pos))
           (println "indice donna migliore di quella attuale: " ind-donna)
           ; valore uomo corrente per donna migliore
           (setq ind-uomo (first (ref idx-link (prefD ind-donna))))
           (println "valore uomo corrente per donna migliore: " ind-uomo)
           ; valore uomo accoppiato per donna migliore
           (dolist (el link)
             (if (= (el 2) ind-donna) (setq ind-uomo-accoppiato (el 3)))
           )
           (println "valore uomo accoppiato per donna migliore: " ind-uomo-accoppiato)
           ;controllo stabilità
           (if (< ind-uomo ind-uomo-accoppiato)
             (begin
               (setq stable nil)
               (println "coppia instabile")
             )
             ;else
             (println "coppia stabile")
           )
           (-- pos)
         )
        )
      )
    )
    (println "Soluzione stabile: " stable)
  )
)

Proviamo la stabilità:

(check-sol sol mmp wwp)
;-> Preferenze M
;-> M0: 4 1 2 3 0
;-> M1: 1 4 0 2 3
;-> M2: 3 2 1 0 4
;-> M3: 0 1 2 3 4
;-> M4: 4 1 2 3 0
;-> Preferenze W
;-> W0: 4 2 3 0 1
;-> W1: 0 1 2 4 3
;-> W2: 3 4 2 1 0
;-> W3: 4 1 0 3 2
;-> W4: 1 0 3 2 4
;-> M p  W p
;-> 0 0  4 1
;-> 1 0  1 1
;-> 2 0  3 4
;-> 3 0  0 2
;-> 4 2  2 1
;-> uomo corrente: 4
;-> indice donna migliore di quella attuale: 1
;-> valore uomo corrente per donna migliore: 3
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> uomo corrente: 4
;-> indice donna migliore di quella attuale: 4
;-> valore uomo corrente per donna migliore: 4
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> Soluzione stabile: true

Proviamo a modificare la soluzione:

(setq sol '(("M1" "W5") ("M2" "W2") ("M3" "W4") ("M4" "W1") ("M5" "W3")))

scambiando di posto W4 in W5:

(setq sol1 '(("M1" "W4") ("M2" "W2") ("M3" "W5") ("M4" "W1") ("M5" "W3")))

(check-sol sol1 mmp wwp)
;-> Preferenze M
;-> M0: 4 1 2 3 0
;-> M1: 1 4 0 2 3
;-> M2: 3 2 1 0 4
;-> M3: 0 1 2 3 4
;-> M4: 4 1 2 3 0
;-> Preferenze W
;-> W0: 4 2 3 0 1
;-> W1: 0 1 2 4 3
;-> W2: 3 4 2 1 0
;-> W3: 4 1 0 3 2
;-> W4: 1 0 3 2 4
;-> M p  W p
;-> 0 3  3 2
;-> 1 0  1 1
;-> 2 4  4 3
;-> 3 0  0 2
;-> 4 2  2 1
;-> uomo corrente: 0
;-> indice donna migliore di quella attuale: 2
;-> valore uomo corrente per donna migliore: 4
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> uomo corrente: 0
;-> indice donna migliore di quella attuale: 1
;-> valore uomo corrente per donna migliore: 0
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia instabile
;-> uomo corrente: 0
;-> indice donna migliore di quella attuale: 4
;-> valore uomo corrente per donna migliore: 1
;-> valore uomo accoppiato per donna migliore: 3
;-> coppia instabile
;-> uomo corrente: 2
;-> indice donna migliore di quella attuale: 0
;-> valore uomo corrente per donna migliore: 1
;-> valore uomo accoppiato per donna migliore: 2
;-> coppia instabile
;-> uomo corrente: 2
;-> indice donna migliore di quella attuale: 1
;-> valore uomo corrente per donna migliore: 2
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> uomo corrente: 2
;-> indice donna migliore di quella attuale: 2
;-> valore uomo corrente per donna migliore: 2
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> uomo corrente: 2
;-> indice donna migliore di quella attuale: 3
;-> valore uomo corrente per donna migliore: 4
;-> valore uomo accoppiato per donna migliore: 2
;-> coppia stabile
;-> uomo corrente: 4
;-> indice donna migliore di quella attuale: 1
;-> valore uomo corrente per donna migliore: 3
;-> valore uomo accoppiato per donna migliore: 1
;-> coppia stabile
;-> uomo corrente: 4
;-> indice donna migliore di quella attuale: 4
;-> valore uomo corrente per donna migliore: 4
;-> valore uomo accoppiato per donna migliore: 3
;-> coppia stabile
;-> Soluzione stabile: nil

La soluzione modificata non è stabile.


-----------------------
TEST PRIMI MILLER-RABIN
-----------------------

Il test di primalità di Miller-Rabin è un algoritmo per determinare se un numero intero è primo.
Il test è probabilistico, nel senso che se il test è negativo, allora il numero è sicuramente composito (non primo), mentre se il test è positivo il numero è "quasi" sicuramente primo.

Per maggiori informazioni: https://it.wikipedia.org/wiki/Test_di_Miller-Rabin

Definiamo alcune funzioni che servono per l'agoritmo.

(random-sample n k) seleziona k numeri distinti da una lista n.
Se il parametro n è un numero, allora la lista vale (1 2 ... n).
Altrimenti n deve essere una lista di elementi distinti.

(define (random-sample n k)
  (cond ((integer? n)
         (slice (randomize (sequence 1 n)) 0 k))
        ((list? n)
         (slice (randomize n) 0 k))
        (true nil)))

(random-sample 100 10)
;-> (73 30 87 32 20 74 91 2 82 36)
(random-sample '(a v f j k o l) 3)
;-> (f j a)

Nota: la funzione "random-sample" manda in crash il sistema con numeri grandi. Probabilmente la primitiva "sequence" richiede troppa memoria per generare la lista di numeri.

Quindi utilizziamo la seguente funzione:

(define (random-sample n k)
  (let (out '())
    (for (i 1 k)
      (push (+ 2 (rand n)) out)
    )
    out))

(random-sample 10 3)
;-> (75 83 90 36 48 59 81 20 57 1)

Nota: questa funzione può generare numeri uguali, ma è molto improbabile con n grande.

(powmod b e m) calcola l'espressione ((b^e) % m) in modo veloce.

(define (powmod b e m)
  (local (r)
    (cond ((= m 1) (setq r 0))
          (true
            ;(setq r 1L)
            (setq r 1)
            (setq b (% b m))
            (while (> e 0)
              (if (= (% e 2) 1) (setq r (% (* r b) m)))
              (setq e (/ e 2))
              (setq b (% (* b b) m))
            )
          )
    )
    r))

(** x p) calcola la potenza di due numeri interi (x^p):

(define (** x p)
  (let (y 1L)
    (dotimes (i p)
      (set 'y (* y x)))))

(powmod 10320320302 2322 5)
;-> 4L
(% (** 10320320302 2322) 5)
;-> 4L

Vediamo i tempi di esecuzione:
(time (% (** 103203203022222 23213) 5))
;-> 2160.79
(time (powmod 103203203022222 23213 5))
;-> 0

Adesso possiamo scrivere la funzione che implementa l'algoritmo di Miller-Rabin:

(define (mil-rab n)
  (local (k s d x out stop)
    (setq out true)
    (setq stop nil)
    (setq k 5)
    (cond ((or (= n 1) (= n 4)) (setq out nil))
          ((or (= n 2) (= n 3) (= n 5)) (setq out true))
          ((zero? (% n 2)) (setq out nil))
          (true
            (setq s 0)
            (setq d (- n 1))
            (while (= (% d 2) 0)
              (++ s)
              (setq d (/ d 2))
            )
            ; ciclo con una lista di numeri casuali (k = 5)
            ;(dolist (a (random-sample (sequence 2 (- n 3)) k) stop)
            ;(dolist (a (random-sample (- n 5) k) stop)
            (dolist (a (random-sample (- n 3) k) stop)
              (setq x (powmod a d n))
              (if (and (!= x 1) (!= n (+ x 1)))
                (begin
                  (setq r 1)
                  (while (< r s)
                    (setq x (powmod x 2 n))
                    (if (= x 1) ; numero composito
                        (setq out nil r s stop true)
                    ;else
                        (if (= x (- n 1)) ; il ciclo non continua
                            (setq a 0 r s)) ; proviamo un'altro "a"
                    )
                    (++ r)
                  )
                  ; numero composito
                  (if (> a 0) (setq out nil stop true))
                )
              )
            )
            ; probabilmente primo se raggiunge la fine del loop
            ; cioè, (out = true)
          )
    )
    out))

Prima di verificare la funzione utilizziamo la funzone "seed" per inizializzare il generatore di numerii casuali di newLISP (altrimenti newLISP inizia sempre con la stessa sequenza di numeri casuali).

(seed (time-of-day))

(mil-rab 11)
;-> true
(mil-rab 1117)
;-> true

Verifichiamo la funzione "mil-rab" utilizzando la funzione "primo?":

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Verifichiamo la correttezza dell'algoritmo per i primi 100000 numeri:

(= (map primo? (sequence 1 100000)) (map mil-rab (sequence 1 100000)))
;-> true

Nota: all'aumentare di k aumenta l'affidabilità della funzione, ma diminuisce la velocità di esecuzione.

Vediamo al differenza di velocità tra le due funzioni:

(time (map primo? (sequence 1 1000000)))
;-> 1123.864

(time (map mil-rab (sequence 1 1000000)))
;-> 6828.682

Purtroppo la funzione "rand" non gestisce i numeri big-integer.


-----------------------
IL PROBLEMA DI GIUSEPPE
-----------------------

Il problema di Giuseppe (Josephus problem) o la permutazione di Giuseppe è un problema collegato ad un episodio raccontato dallo storico Flavio Giuseppe nella sua opera "Guerra giudaica" (composta tra il 93 e il 94 d.C.).
Il problema presenta n persone disposte in circolo in attesa di una esecuzione. Scelta una persona iniziale e un senso di rotazione, si saltano k-1 persone, raggiungendo così la k-esima persona, che viene giustiziata ed eliminata dal cerchio. Poi si saltano k-1 persone e si giustizia la k-esima persona. Le esecuzioni proseguono e il cerchio si restringe sempre più, finché non rimane che una sola persona, la quale viene graziata. Dati n e k, determinare la posizione del sopravvissuto all'interno del cerchio iniziale. In altre parole il problema è scegliere il posto nel cerchio iniziale che assicura la sopravvivenza.

Soluzione ricorsiva
Il problema ha la seguente struttura ricorsiva.

   giuseppe (n, k) = (giuseppe (n - 1, k) + k - 1) % n + 1
   giuseppe (1, k) = 1

Dopo che la prima persona (kth dall'inizio) viene uccisa, rimangono n-1 persone. Quindi chiamiamo giuseppe (n - 1, k) per ottenere la posizione con n-1 persone. Ma la posizione restituita da giuseppe (n - 1, k) considererà la posizione a partire da k%n + 1. Quindi dobbiamo apportare modifiche alla posizione restituita da giuseppe (n - 1, k).

(define (giuseppe n k)
  (if (= n 1) 1
      ; La posizione restituita da (giuseppe (n - 1) k)
      ; viene aggiustata perché la chiamata ricorsiva
      ; (giuseppe (n - 1) k) considera l'originale
      ; posizione (k % n) + 1 come posizione 1
      (+ (% (+ (giuseppe (- n 1) k) k -1) n) 1)))

(giuseppe 14 2)
;-> 13
(giuseppe 5 2)
;-> 3
(giuseppe 7 4)
;-> 2

Soluzione iterativa
Nell'algoritmo, utilizziamo la variabile somma per determinare la persona da rimuovere. La posizione corrente della persona viene calcolata aggiungendo il conteggio della persona K alla posizione precedente, ovvero la somma e il modulo della somma.

(define (giuseppe n k)
  (let (somma 0)
    (for (i 2 n)
      (setq somma (% (+ somma k) i)))
    (+ somma 1)))

(giuseppe 14 2)
;-> 13
(giuseppe 5 2)
;-> 3
(giuseppe 7 4)
;-> 2

Nel caso k sia sempre uguale a 2, allora possiamo utilizzare un altro metodo:

(define (giuseppe n)
  ; trova il valore di 2 ^ (1 + floor (Log n))
  ; che è una potenza di 2 il cui valore
  ; è appena sopra n.
  (let (p 1)
    (while (<= p n)
      (setq p (* p 2)))
    ; restituisce 2n - 2^(1+floor(Log n)) + 1
    (+ (- (* 2 n) p) 1)))

(giuseppe 14)
;-> 13
(giuseppe 5)
;-> 3


------
ROT-13
------

Il ROT-13 (rotate by 13 places) è un cifrario monoalfabetico. Il ROT13 è una variante del cifrario di Cesare, ma con chiave 13: ogni lettera viene sostituita con quella situata 13 posizioni più avanti nell'alfabeto.

Originale:  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
Criptato:   N O P Q R S T U V W X Y Z A B C D E F G H I J K L M

La scelta della chiave non è casuale, perché è la metà del numero di lettere dell'alfabeto internazionale, 26: in questo modo si può utilizzare lo stesso algoritmo sia per la cifratura che per la decifratura.

Ecco un esempio:

Originale LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE
Criptato  YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR

Si tratta di un cifrario monoalfabetico molto facile da decifrare e non viene più utilizzato in crittografia. Ad oggi, il ROT-13 viene usato per offuscare un testo che contiene informazioni (es. una soluzione o un suggerimento) che il lettore potrebbe non voler conoscere immediatamente.

Metodo 1:

(define (rot13-1 txt)
  (join
   (map
    (fn(c)
      (cond
       ((<= "A" (upper-case c) "M") (char (+ (char c) 13)))
       ((<= "N" (upper-case c) "Z") (char (- (char c) 13)))
       (true c)))
    (explode txt))))

(rot13-1 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-1 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 2:

(define (rot13-2 txt)
 (for (y 0 (- (length txt) 1))
      (setf (txt y) (slurp-2 (nth y txt))))
 txt)

(define (slurp-2 x)
  (if
    (or (and (>= (char x)(char "a")) (<= (char x)(char "m")))
        (and (>= (char x)(char "A")) (<= (char x)(char "M"))))
        (char (+ (char x) 13))
    (or (and (>= (char x)(char "n")) (<= (char x)(char "z")))
        (and (>= (char x)(char "N")) (<= (char x)(char "Z"))))
        (char (- (char x) 13))
  x))

(rot13-2 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-2 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 3:

(define (rot13-3 txt)
  (let ((rot13from "NOPQRSTUVWXYZABCDEFGHIJKLMnopqrstuvwxyzabcdefghijklm")
        (rot13goto "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        (enc ""))
    (while (> (length txt) 0)
      (if (!= (find (nth 0 txt) rot13from) nil)
        (setq enc(append enc(nth (find (nth 0 txt) rot13from) rot13goto)))
        (setq enc(append enc(nth 0 txt))))
      (setq txt (rest txt))
    )
    enc))

(rot13-3 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-3 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 4:

(define (rot13-4 txt)
  (for (y 0 (- (length txt) 1))
    (setf (txt y) (char (slurp-4 (char (nth y txt))))))
txt)

(define (slurp-4 x)
  (if
    (or (and (>= x 97) (<= x 109))
        (and (>= x 65) (<= x 77)))
        (+ x 13)
    (or (and (>= x 110)(<= x 122))
        (and (>= x 78) (<= x 90)))
        (- x 13)
  x))

(rot13-4 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-4 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 5:

(define (rot13-5 txt , rotarray)
  (setq rotarray (array 256
  '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
    25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
    47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 78 79 80 81
    82 83 84 85 86 87 88 89 90 65 66 67 68 69 70 71 72 73 74 75 76 77
    91 92 93 94 95 96 110 111 112 113 114 115 116 117 118 119 120 121
    122 97 98 99 100 101 102 103 104 105 106 107 108 109 123 124 125
    126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141
    142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157
    158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173
    174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189
    190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205
    206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221
    222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237
    238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253
    254 255)))
  (join (map (fn (x) (char (nth (char x) rotarray))) (explode txt))))

(rot13-5 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-5 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 6 (iterativo):

(define (rot13-6 txt , rotarray)
  (setq rotarray (array 256
  '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
    25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46
    47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 78 79 80 81
    82 83 84 85 86 87 88 89 90 65 66 67 68 69 70 71 72 73 74 75 76 77
    91 92 93 94 95 96 110 111 112 113 114 115 116 117 118 119 120 121
    122 97 98 99 100 101 102 103 104 105 106 107 108 109 123 124 125
    126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141
    142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157
    158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173
    174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189
    190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205
    206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221
    222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237
    238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253
    254 255)))
  (dotimes (i (length txt))
    (setf (txt i) (char (nth (char (nth i txt)) rotarray)))) txt)

(rot13-6 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-6 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 7:

(context 'rot13)

(define (rot13:aux ch , i)
  (if (set 'i (find ch "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
    ("nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM" i)
    ch ))

(define (rot13:rot13-7 txt)
  (join (map rot13:aux (explode txt))))

(context 'MAIN)

(rot13-7 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-7 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Metodo 8:

(define (rot13-8 str)
  (join
   (map
    (fn(c)
      (cond
       ((<= "A" (upper-case c) "M") (char (+ (char c) 13)))
       ((<= "N" (upper-case c) "Z") (char (- (char c) 13)))
       (true c)))
    (explode str))))

(rot13-8 "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")
;-> "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR"
(rot13-8 "YN FPRAN VA PHV VY CREFBANTTVB CEVAPVCNYR ZHBER ABA ZV CVNPR")
;-> "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE"

Vediamo la velocità delle varie funzioni:

(setq testo "LA SCENA IN CUI IL PERSONAGGIO PRINCIPALE MUORE NON MI PIACE")

(time (rot13-1 (rot13-1 testo)) 10000)
;-> 874.66
(time (rot13-2 (rot13-2 testo)) 10000)
;-> 1173.892
(time (rot13-3 (rot13-3 testo)) 10000)
;-> 1042.892
(time (rot13-4 (rot13-4 testo)) 10000)
;-> 958.038
(time (rot13-5 (rot13-5 testo)) 10000)
;-> 474.13
(time (rot13-6 (rot13-6 testo)) 10000)
;-> 827.441
(time (rot13-7 (rot13-7 testo)) 10000)
;-> 470.769
(time (rot13-8 (rot13-8 testo)) 10000)
;-> 854.569


------
SUDOKU
------

Il sudoku è un gioco di logica rappresentato da una matrice di 9×9 celle, ciascuna delle quali può contenere un numero da 1 a 9, oppure essere vuota (zero). La matrice è suddivisa in 9 righe orizzontali, 9 colonne verticali e in 9 "sottomatrici" di 3×3 celle contigue chiamate regioni. Lo scopo del gioco è quello di riempire le caselle vuote con numeri da 1 a 9 in modo tale che in ogni riga, in ogni colonna e in ogni regione siano presenti tutte le cifre da 1 a 9, quindi senza ripetizioni. Una volta riempita correttamente, la matrice appare appare come un quadrato latino.
Il gioco fu inventato dal matematico svizzero Eulero (1707-1783).

Un esempio di puzzle sudoku è il seguente:

  Puzzle sudoku:                 Soluzione:

  3 0 6 | 5 0 8 | 4 0 0          3 1 6 | 5 7 8 | 4 9 2
  5 2 0 | 0 0 0 | 0 0 0          5 2 9 | 1 3 4 | 7 6 8
  0 8 7 | 0 0 0 | 0 3 1          4 8 7 | 6 2 9 | 5 3 1
  ------+-------+------          ------+-------+------
  0 0 3 | 0 1 0 | 0 8 0          2 6 3 | 4 1 5 | 9 8 7
  9 0 0 | 8 6 3 | 0 0 5          9 7 4 | 8 6 3 | 1 2 5
  0 5 0 | 0 9 0 | 6 0 0          8 5 1 | 7 9 2 | 6 4 3
  ------+-------+------          ------+-------+------
  1 3 0 | 0 0 0 | 2 5 0          1 3 8 | 9 4 7 | 2 5 6
  0 0 0 | 0 0 0 | 0 7 4          6 9 2 | 3 5 1 | 8 7 4
  0 0 5 | 2 0 6 | 3 0 0          7 4 5 | 2 8 6 | 3 1 9

In pseudocodice, la nostra strategia usa il backtracking ricorsivo:

Trovare (riga,colonna) di una cella non assegnata
Se non ce n'è nessuna, ritorna vero (puzzle risolto)
Per ogni cifra da 1 a 9
     se non vi è alcun conflitto per la cifra alla (riga,colonna)
     assegnare la cifra a (riga,colonna) e provare ricorsivamente a riempire il resto della matrice
     se la ricorsione ha esito positivo, restituire vero
     in caso di insuccesso, rimuovere la cifra e provarne un'altra
se tutte le cifre sono state provate e nulla ha funzionato, restituire falso per attivare il backtracking

Funzione che verifica se un numero è compatibile con la matrice:

; (con la variabile "safe")
(define (isSafe board row col num)
  (local (safe regionRowStart regionColStart)
    (setq safe true)
    ; numero unico sulla riga (row-clash)
    (for (d 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella riga
      ; restituire falso (nil)
      (if (= (board row d) num)
          (setq safe nil)
      )
    )
    (if safe (begin
    ; numero unico sulla colonna (column-clash)
    (for (r 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella colonna
      ; restituire falso (nil)
      (if (= (board r col) num)
          (setq safe nil)
      )
    )))
    (if safe (begin
    ; numero unico in ogni regione 3x3 (region-clash)
    (setq regionRowStart (- row (% row 3)))
    (setq regionColStart (- col (% col 3)))
    (for (r regionRowStart (+ regionRowStart 2))
          (for (d regionColStart (+ regionColStart 2))
        (if (= (board r d) num)
            (setq safe nil)
        )
      )
    )))
    ; se non c'è conflitto, allora è sicuro
    safe
  )
)

;(con la funzione "catch")
(define (isSafe board row col num)
(catch
  (local (regionRowStart regionColStart)
    ; numero unico sulla riga (row-clash)
    (for (d 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella riga
      ; restituire falso (nil)
      (if (= (board row d) num)
          (throw nil)
      )
    )
    ; numero unico sulla colonna (column-clash)
    (for (r 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella colonna
      ; restituire falso (nil)
      (if (= (board r col) num)
          (throw nil)
      )
    )
    ; numero unico in ogni region 3x3 (region-clash)
    (setq regionRowStart (- row (% row 3)))
    (setq regionColStart (- col (% col 3)))
    (for (r regionRowStart (+ regionRowStart 2))
      (for (d regionColStart (+ regionColStart 2))
        (if (= (board r d) num)
            (throw nil)
        )
      )
    )
    ; se non c'è conflitto, allora è sicuro
    true
  )
))

Definiamo la funzione che risolve il sudoku:

(define (solveSudoku board)
(catch
  (local (i j row col isEmpty solved)
    (setq row -1 col -1)
    (setq isEmpty true)
    (setq i 0 j 0)
    (while (and isEmpty (< i (length board)))
      (while (and isEmpty (< j (length board)))
        (if (= (board i j) 0)
            ; Esistono ancora dei valori nulli nel puzzle
            (setq row i col j isEmpty nil)
        )
        (++ j)
      )
      (setq j 0)
      (++ i)
    )
    ; stampa la soluzione
    (if isEmpty (begin (println board) (throw true)))
    ; salva la soluzione su una variabile globale
    ;(if isEmpty (begin (setq *sol* board) (throw true)))
    ;else
    (for (num 1 (length board))
        (cond ((isSafe board row col num)
                 (setf (board row col) num)
                 (if (solveSudoku board) (throw true))
                 (setf (board row col) 0)
              )
        )
    )
    nil
  )
))

Proviamo la funzione:

(setq puzzle
'((3 0 6 5 0 8 4 0 0)
  (5 2 0 0 0 0 0 0 0)
  (0 8 7 0 0 0 0 3 1)
  (0 0 3 0 1 0 0 8 0)
  (9 0 0 8 6 3 0 0 5)
  (0 5 0 0 9 0 6 0 0)
  (1 3 0 0 0 0 2 5 0)
  (0 0 0 0 0 0 0 7 4)
  (0 0 5 2 0 6 3 0 0)))

(solveSudoku puzzle)
;-> ((3 1 6 5 7 8 4 9 2)
;->  (5 2 9 1 3 4 7 6 8)
;->  (4 8 7 6 2 9 5 3 1)
;->  (2 6 3 4 1 5 9 8 7)
;->  (9 7 4 8 6 3 1 2 5)
;->  (8 5 1 7 9 2 6 4 3)
;->  (1 3 8 9 4 7 2 5 6)
;->  (6 9 2 3 5 1 8 7 4)
;->  (7 4 5 2 8 6 3 1 9))
;-> true

I puzzle sudoku più difficili del Dottor Arto Inkala:

Sudoku 1:

8 5 . |. . 2 |4 . .        8 5 9 |6 1 2 |4 3 7
7 2 . |. . . |. . 9        7 2 3 |8 5 4 |1 6 9
. . 4 |. . . |. . .        1 6 4 |3 7 9 |5 2 8
------+------+-----        ------+------+-----
. . . |1 . 7 |. . 2        9 8 6 |1 4 7 |3 5 2
3 . 5 |. . . |9 . .        3 7 5 |2 6 8 |9 1 4
. 4 . |. . . |. . .        2 4 1 |5 9 3 |7 8 6
------+------+-----        ------+------+-----
. . . |. 8 . |. 7 .        4 3 2 |9 8 1 |6 7 5
. 1 7 |. . . |. . .        6 1 7 |4 2 5 |8 9 3
. . . |. 3 6 |. 4 .        5 9 8 |7 3 6 |2 4 1

(setq sudoku1
'((8 5 0 0 0 2 4 0 0)
  (7 2 0 0 0 0 0 0 9)
  (0 0 4 0 0 0 0 0 0)
  (0 0 0 1 0 7 0 0 2)
  (3 0 5 0 0 0 9 0 0)
  (0 4 0 0 0 0 0 0 0)
  (0 0 0 0 8 0 0 7 0)
  (0 1 7 0 0 0 0 0 0)
  (0 0 0 0 3 6 0 4 0)))

(solveSudoku sudoku1)
;-> ((8 5 9 6 1 2 4 3 7)
;->  (7 2 3 8 5 4 1 6 9)
;->  (1 6 4 3 7 9 5 2 8)
;->  (9 8 6 1 4 7 3 5 2)
;->  (3 7 5 2 6 8 9 1 4)
;->  (2 4 1 5 9 3 7 8 6)
;->  (4 3 2 9 8 1 6 7 5)
;->  (6 1 7 4 2 5 8 9 3)
;->  (5 9 8 7 3 6 2 4 1))
;-> true

; (con la variabile "safe")
(time (solveSudoku sudoku1))
;-> 7734.897

; (con la funzione "catch")
(time (solveSudoku sudoku1))
;-> 8969.888

Sudoku 2:

. . 5 |3 . . |. . .        1 4 5 |3 2 7 |6 9 8
8 . . |. . . |. 2 .        8 3 9 |6 5 4 |1 2 7
. 7 . |. 1 . |5 . .        6 7 2 |9 1 8 |5 4 3
------+------+-----        ------+------+-----
4 . . |. . 5 |3 . .        4 9 6 |1 8 5 |3 7 2
. 1 . |. 7 . |. . 6        2 1 8 |4 7 3 |9 5 6
. . 3 |2 . . |. 8 .        7 5 3 |2 9 6 |4 8 1
------+------+-----        ------+------+-----
. 6 . |5 . . |. . 9        3 6 7 |5 4 2 |8 1 9
. . 4 |. . . |. 3 .        9 8 4 |7 6 1 |2 3 5
. . . |. . 9 |7 . .        5 2 1 |8 3 9 |7 6 4

(setq sudoku2
'((0 0 5 3 0 0 0 0 0)
  (8 0 0 0 0 0 0 2 0)
  (0 7 0 0 1 0 5 0 0)
  (4 0 0 0 0 5 3 0 0)
  (0 1 0 0 7 0 0 0 6)
  (0 0 3 2 0 0 0 8 0)
  (0 6 0 5 0 0 0 0 9)
  (0 0 4 0 0 0 0 3 0)
  (0 0 0 0 0 9 7 0 0)))

(solveSudoku sudoku2)
;-> ((1 4 5 3 2 7 6 9 8)
;->  (8 3 9 6 5 4 1 2 7)
;->  (6 7 2 9 1 8 5 4 3)
;->  (4 9 6 1 8 5 3 7 2)
;->  (2 1 8 4 7 3 9 5 6)
;->  (7 5 3 2 9 6 4 8 1)
;->  (3 6 7 5 4 2 8 1 9)
;->  (9 8 4 7 6 1 2 3 5)
;->  (5 2 1 8 3 9 7 6 4))
;-> true

; (con la variabile "safe")
(time (solveSudoku sudoku2))
;-> 234.297

; (con la funzione "catch")
(time (solveSudoku sudoku2))
;-> 265.557


--------
CHESS960
--------

Chess960 è una variante degli scacchi creata dal campione del mondo Bobby Fischer. Questa variante non richiede un materiale diverso, ma si basa su una posizione iniziale casuale, con alcuni vincoli:

A) come nella partita a scacchi standard, tutte e otto i pedoni bianchi devono essere piazzati sulla seconda riga.

B) I pezzi bianchi devono stare nella prima riga come nel gioco standard, in ordine casuale di colonne ma con i due seguenti vincoli:
  1) gli alfieri devono essere posizionati su case di colore opposto (cioè deve esserci un numero pari di spazi tra loro)
  2) il re deve trovarsi tra due torri (con un numero qualsiasi di altri pezzi tra loro)

C) Pedoni e pezzi neri devono essere posizionati rispettivamente sulla settima e sull'ottava riga, rispecchiando i pedoni e i pezzi bianchi, proprio come nel gioco standard. (Cioè, le loro posizioni non sono casuali in modo indipendente.)

Con questi vincoli ci sono 960 possibili posizioni di partenza, quindi il nome della variante.

I pezzi sono definiti nel modo seguente:

ITA        ENG       CHAR
-------    ------    ----
Pedone     Pawn      P
Torre      Rook      R
Cavallo    Knight    N
Alfiere    Bishop    B
Regina     Queen     Q
Re         King      K

Nel file "chess960-lst.lsp" sono memorizzate in una lista tutte le 960 posizioni iniziali.
Il modo più semplice per generare una posizione è quello di prenderne casualmente una da questa lista:

(define (get960)
  (load "chess960-lst.lsp")
  (chess960 (rand 960)))

(get960)
;-> (B Q N B N R K R)

Se invece vogliamo generare una posizione ex-novo possiamo scrivere due funzioni.

Funzione che controlla la correttezza di una posizione casuale:

(define (legal-pos lst)
  (and
    ; re a destra di una torre?
    (> (find 'K lst) (find 'R lst))
    ; re a sinistra dell'altra torre?
    (> (find 'K (reverse (copy lst))) (find 'R (reverse (copy lst))))
    ; alfieri di colore contrario?
    (even? (- (find 'B lst) (find 'B (reverse (copy lst)))))))

Funzione che genera una posizione chess960 corretta:

(define (get960)
  (setq start '(R N B Q K B N R))
  (setq prova (randomize start))
  (while (not (legal-pos prova))
    (setq prova (randomize start))
  )
  prova)

(get960)
;-> (N B R Q K N B R)
(get960)
;-> (R K R B N N B Q)
(get960)
;-> (R B B N N K Q R)

Controlliamo la correttezza della funzione generando n posizioni e controllando che esistano nella lista di tutte le posizioni chess960:

(define (control n)
  (load "chess960-lst.lsp")
  (for (i 1 n)
    (setq a (get960))
    (if (nil? (find a chess960)) (println "error:" a))))

(control 10000)
;-> nil

Sembra tutto corretto.


--------------------
PERCORSO DEL CAVALLO
--------------------

In questo problema un cavallo è posizionato in una qualunque casella sulla scacchiera vuota e, spostandosi secondo le regole degli scacchi (cioè ad L), deve passare per tutte le altre caselle esattamente una sola volta. Un percorso del cavallo si dice "chiuso" se l'ultima casa su cui si posiziona il cavallo è vicina alla casa da cui è partito (ad esempio, se il cavallo inizia in d8 e conclude il suo percorso in f7). In caso contrario il percorso del cavallo è detto "aperto". Questo problema è un esempio del più generale "problema del cammino hamiltoniano" nella teoria dei grafi.

Vediamo la soluzione ricorsiva con backtracking:

(define (knight side x y)
  (local (n board result counter res_counter sx sy)
    (setq n side)
    (setq sx x sy y)
    (setq board (array n n '(0)))
    (setq result (array n n '(0)))
    (setq counter 0)
    (setq res_counter 0)
    (if (knight-tour board sx sy) result nil)
  ))

(define (knight-tour board curr-x curr-y)
(catch
  (local (temp)
  ;(println counter)
  ; n*n mosse --> risolto
  (if (= counter (* n n)) (throw true))
  (cond ((or (> curr-x (- n 1)) (< curr-x 0) (> curr-y (- n 1)) (< curr-y 0) (= (board curr-x curr-y) 1))
         (throw nil))
        (true (++ counter) (++ res-counter))
  )
  (setf (board curr-x curr-y) 1)
  (cond ((knight-tour board (+ curr-x 2) (+ curr-y 1)) ; down_right
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x 1) (+ curr-y 2)) ; right_down
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x -1) (+ curr-y 2)) ; right-up
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x -2) (+ curr-y 1)) ; up-right
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x -2) (+ curr-y -1)) ; up-left
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x -1) (+ curr-y -2)) ; left-up
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x 1) (+ curr-y -2)) ; left-down
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        ((knight-tour board (+ curr-x 2) (+ curr-y -1)) ; down-left
         (setf (result curr-x curr-y) res-counter)
         (setq res-counter (- res-counter 1))
         (throw true)
        )
        (true
          ; nessuna mossa possibile --> backtracking
          (if (or (> curr-x (- n 1)) (< curr-x 0) (> curr-y (- n 1)) (< curr-y 0) (= (board curr-x curr-y) 1))
            (begin
              (setq counter (- counter 1))
              (setq res-counter (- res-counter 1))
              (setf (board curr-x curr-y) 0)
            )
          )
          (throw nil)
        )
  )
  )
))

(knight 6 0 0)
;-> (( 1 16  7 26 11 14)
;->  (34 25 12 15  6 27)
;->  (17  2 33  8 13 10)
;->  (32 35 24 21 28  5)
;->  (23 18  3 30  9 20)
;->  (36 31 22 19  4 29))

(time (knight 6 0 0))
;-> 3437.779

(knight 8 0 0)
;-> (( 1 60 39 34 31 18  9 64)
;->  (38 35 32 61 10 63 30 17)
;->  (59  2 37 40 33 28 19  8)
;->  (36 49 42 27 62 11 16 29)
;->  (43 58  3 50 41 24  7 20)
;->  (48 51 46 55 26 21 12 15)
;->  (57 44 53  4 23 14 25  6)
;->  (52 47 56 45 54  5 22 13))

(time (knight 8 0 0))
;-> 142474.658

(knight 8 7 7)
;-> ((47 34 21 30  5 14 19 64)
;->  (36 31 48 33 20 63  4 13)
;->  (49 46 35 22 29  6 15 18)
;->  (60 37 32 51 62 17 12  3)
;->  (45 50 61 38 23 28  7 16)
;->  (56 59 42 25 52  9  2 11)
;->  (41 44 57 54 39 24 27  8)
;->  (58 55 40 43 26 53 10  1))

(time (knight 8 7 7))
;-> 4232650.162 ; circa 70 minuti

Vediamo lo stesso algoritmo di backtracking codificato in modo più strutturato.

(define (is_valid i j)
  (if (and (>= i 0) (< i n) (>= j 0) (< j n))
      (if (= (board i j) -1)
          true
          nil)))

(define (knight_tour i j step_count)
(catch
  (local (next_i next_j)
    (if (= step_count (* n n)) (throw true))
    (for (k 0 7)
      (setq next_i (+ i (x_move k)))
      (setq next_j (+ j (y_move k)))
      (if (is_valid next_i next_j)
          (begin
            (setf (board next_i next_j) step_count)
            ;(println next_i { } next_j { } step_count)
            (if (knight_tour next_i next_j (+ step_count 1))
                (throw true)
            )
            (setf (board next_i next_j) -1) ; backtracking
          )
      )
    )
    nil
  )
))

(define (start_knight_tour side x y)
  (local (n board x_move y_move step_count sx sy)
    (setq n side)
    (setq sx x sy y)
    (setq step_count 1)
    (setq board (array n n '(-1)))
    (setq x_move '(2 1 -1 -2 -2 -1 1 2))
    (setq y_move '(1 2 2 1 -1 -2 -2 -1))
    (setf (board sx sy) 0) ; cavallo nella cella (x,y)
    (if (knight_tour sx sy step_count) board nil
    )))

(start_knight_tour 6 0 0)
;-> (( 0 15  6 25 10 13)
;->  (33 24 11 14  5 26)
;->  (16  1 32  7 12  9)
;->  (31 34 23 20 27  4)
;->  (22 17  2 29  8 19)
;->  (35 30 21 18  3 28))

(time (start_knight_tour 6 0 0))
;-> 672.085

(start_knight_tour 8 0 0)
;-> (( 0 59 38 33 30 17  8 63)
;->  (37 34 31 60  9 62 29 16)
;->  (58  1 36 39 32 27 18  7)
;->  (35 48 41 26 61 10 15 28)
;->  (42 57  2 49 40 23  6 19)
;->  (47 50 45 54 25 20 11 14)
;->  (56 43 52  3 22 13 24  5)
;->  (51 46 55 44 53  4 21 12))

(time (start_knight_tour 8 0 0))
;-> 23314.636

(start_knight_tour 8 7 7)
;-> ((46 33 20 29  4 13 18 63)
;->  (35 30 47 32 19 62  3 12)
;->  (48 45 34 21 28  5 14 17)
;->  (59 36 31 50 61 16 11  2)
;->  (44 49 60 37 22 27  6 15)
;->  (55 58 41 24 51  8  1 10)
;->  (40 43 56 53 38 23 26  7)
;->  (57 54 39 42 25 52  9  0))

(time (start_knight_tour 8 7 7))
;-> 705835.03 ; circa 11 minuti

Nota: cambiando l'ordine delle mosse di ricerca (x_move e y_move) si ottiene un'altra soluzione (e cambia anche il tempo di calcolo).

Un algoritmo molto più veloce è quello di Warnsdorff (1823) che permette di trovare un percorso chiuso partendo da qualunqe casa della scacchiera.

Regola di Warnsdorff:
1) Partire da qualsiasi posizione iniziale del cavallo sulla scacchiera.
2) Spostarsi sempre in una casella non visitata che possiede grado minimo (numero minimo di caselle adiacenti non visitate).

(define (print-board lst)
  (local (s space)
  (for (i 0 (- n 1))
    (setq s "")
    (for (j 0 (- n 1))
      (if (> (lst (+ (* j n) i)) 9)
          (setq space "  ")
          (setq space "   ")
      )
      (extend s space (string (lst (+ (* j n) i))))
    )
    (println s)
  )
  'end))

; Restricts the knight to remain within
; the 8x8 chessboard
(define (limits x y)
  (and (>= x 0) (>= y 0) (< x n) (< y n)))

; Checks whether a square is valid and empty or not
(define (isempty b x y)
  (and (limits x y) (< (b (+ (* y n) x)) 0)))

; Returns the number of empty squares adjacent to (x, y)
(define (getDegree b x y)
  (let (conta 0)
    (for (i 0 (- n 1))
      (if (isempty b (+ x (cx i)) (+ y (cy i)))
          (++ conta)
      )
    )
    conta))

; Picks next point using Warnsdorff's heuristic.
; Returns false if it is not possible to pick next point.
(define (nextMove)
(catch
  (local (minDegIdx c minDeg nx ny start i)
    (setq minDegIdx -1)
    (setq minDeg (+ n 1))
    ; Try all N adjacent of (*x, *y) starting
    ; from a random adjacent. Find the adjacent
    ; with minimum degree.
    (setq start (rand n))
    (for (conta 0 (- n 1))
      (setq i (% (+ start conta) n))
      (setq nx (+ gx (cx i)))
      (setq ny (+ gy (cy i)))
      (setq c (getDegree board nx ny))
      (if (and (isempty board nx ny) (< c minDeg))
          (setq minDegIdx i minDeg c)
      )
    )
    ; if we could not find a next cell
    (if (= minDegIdx -1) (throw nil))
    ; Store coordinates of next point
    (setq nx (+ gx (cx minDegIdx)))
    (setq ny (+ gy (cy minDegIdx)))
    ; Mark next move
    (setf (board (+ (* ny n) nx)) (+ (board (+ (* gy n) gx)) 1))
    ; Update next point
    (setq gx nx)
    (setq gy ny)
    true
  )
))

; checks its neighbouring squares
; If the knight ends on a square that is one
; knight's move from the beginning square,
; then tour is closed
(define (neighbour x y xx yy)
  (let (found nil)
    (for (i 0 (- n 1) 1 found)
      (if (and (= (+ x (cx i)) xx) (= (+ y (cy i)) yy))
          (setq found true)
      )
    )
    found))

; Generates the legal moves using warnsdorff's heuristics.
; Returns false if not possible
(define (findClosedTour)
(catch
  (local (temp)
  ; fill board
  (setq board (array (* n n) '(-1)))
  ; Current points are same as initial points
  (setq gx sx gy sy)
  ; Mark first move
  (setf (board (+ (* gy n) gx)) 1)
  ; Keep picking next points using Warnsdorff's heuristic
  (for (i 0 (- (* n n) 2))
    (if (nil? (nextMove)) (throw nil))
  )
  ; Check if tour is closed
  (if (not (neighbour gx gy sx sy)) (throw nil))
  (print-board board)
  true
  )
))

(define (warnsdorff x y)
    (setq n 8)
    ; start position
    (setq sx x sy y)
    ; current position
    (setq gx sx gy sy)
    ; Move pattern on basis of the change of
    ; x coordinates and y coordinates respectively
    (setq cx '(1 1 2 2 -1 -1 -2 -2))
    (setq cy '(2 -2 1 -1 2 -2 1 -1))
    ; define board
    (setq board (array (* n n) '(-1)))
    ; While we don't get a solution
    (while (not (findClosedTour)))
    'stop
)

(warnsdorff 0 0)
;->    1   4  61  20  51   6  53  22
;->   34  19   2   5  62  21  50   7
;->    3  64  35  60  37  52  23  54
;->   18  33  38  63  56  59   8  49
;->   39  14  57  36  43  48  55  24
;->   32  17  42  47  58  27  44   9
;->   13  40  15  30  11  46  25  28
;->   16  31  12  41  26  29  10  45
;-> stop

(warnsdorff 1 1)
;->   53  50  15  20  63  24  13  22
;->   16   1  54  51  14  21  58  25
;->   49  52  19  64  59  62  23  12
;->    2  17  60  55  46  33  26  57
;->   43  48  45  18  61  56  11  32
;->    6   3  42  47  34  29  38  27
;->   41  44   5   8  39  36  31  10
;->    4   7  40  35  30   9  28  37
;-> stop

(warnsdorff 7 7)
;->    7  10  25  40  59  12  27  30
;->   24  39   8  11  26  29  62  13
;->    9   6  41  60  47  58  31  28
;->   38  23  46  43  50  61  14  63
;->    5  42  55  48  57  44  51  32
;->   22  37  20  45  54  49  64  15
;->   19   4  35  56  17   2  33  52
;->   36  21  18   3  34  53  16   1

(time (warnsdorff 7 7))
;-> 12.965
(time (warnsdorff 7 7))
;-> 53.121
(time (warnsdorff 7 7))
;-> 477.722
(time (warnsdorff 7 7))
;-> 69.916
(time (warnsdorff 7 7))
;-> 541.521


------------------------
TEOREMA CINESE DEI RESTI
------------------------

Siano (n1, n2,..., nk) k interi a due a due coprimi (divisori) e siano (b1, b2,..., bk) k interi relativi (resti).
Allora il sistema di congruenze:

x ≡ b1 (mod n1)   --> x mod n1 = b1
x ≡ b2 (mod n2)   --> x mod n2 = b2
...
x ≡ bk (mod nk)   --> x mod nk = bk

Ammette soluzioni. Inoltre se x0 è una soluzione del sistema, tutte le soluzioni di tale sistema saranno date da:

x = x0 + h*N  dove h appartiene all'insieme dei numeri interi relativi (Z) e N = n1*n2*...*nk.

Nota: la condizione che (n1, n2,..., nk) siano coprimi a coppie, è solo una condizione sufficiente per la risolubilità del sistema. Può capitare che i moduli non siano a due a due coprimi, ma il sistema abbia comunque soluzione.

Vediamo come si calcola la soluzione di un sistema di congruenze con un esempio:

x ≡ 2 (mod 5)
x ≡ 0 (mod 4)
x ≡ 4 (mod 7)

Poiché mcd(5,4) = mcd(5,7) = mcd(4,7) = 1 per il Teorema Cinese dei resti, il sistema ammette soluzione.

Siano:

b1=2, b2=0, b3=4

n1=5, n2=4, n3=7

N = n1*n2*n3 = 140

N1 = n2*n3 = 28

N2 = n1*n3 = 35

N3 = n1*n2 = 20

Iniziamo col determinare una soluzione particolare y1 della congruenza:

N1*y2 ≡ 1 (mod n1)   ==>   28*y1 ≡ 1 (mod 5)   ==>   y1 = 2

Determiniamo una soluzione particolare y2 della congruenza:

N2*y2 ≡ 1 (mod n2)   ==>   35*y2 ≡ 1 (mod 4)   ==>   y2 = 3

Determiniamo una soluzione particolare y3 della congruenza:

N3*y3 ≡ 1 (mod n3)   ==>   20*y2 ≡ 1 (mod 7)   ==>   y2 = 6

La soluzione particolare x0 del sistema è data da:

x0 = b1*N1*y1 + b2*N2*y2 + b3*N3*y3 = 112 + 0 + 480 = 592 = 32 (mod N) = 32 (mod 140)

Quindi le soluzioni del sistema sono date da: x = 32 + 140*h.

Algoritmo del teorema cinese dei resti
--------------------------------------
L'algoritmo seguente è applicabile solo se l'insieme dei numeri n è coprimo a coppie (coprimo pairwise).

Dato il sistema di congruenze:

x ≡ ai (mod ni) dove i=1,...k

Definiamo il prodotto N = n1*n2*...*nk

Per ogni i, gli interi ni e N/ni sono coprimi.

Usando l'algoritmo di Euclide Esteso possiamo trovare gli interi ri e si tali che: ri*ni + si*N/ni = 1.

La soluzione vale: x = Sum[1,k](ai*si*N/ni)

E la soluzione minima vale: x (mod N)

; ritorna il valore di x, dove (a * x) % b == 1
(define (mul-inv a b)
  (local (b0 t q x0 x1)
    (setq b0 b x0 0 x1 1)
    (cond ((= b 1) 1)
          (true
            (while (> a 1)
              (setq q (/ a b))
              (setq t b b (% a b) a t)
              (setq t x0 x0 (- x1 (* q x0)) x1 t)
            )
            (if (< x1 0) (setq x1 (+ x1 b0)))
            x1
          ))))

(mul-inv 3 2)
;-> 1
(mul-inv 5 3)
;-> 2
(mul-inv 7 2)
;-> 1

Funzione che calcola la soluzione con il Teorema Cinese dei Resti:

(define (chinese divisori resti)
  (local (p prod sum)
    (setq prod 1 sum 0)
    (for (i 0 (- (length divisori) 1))
      (setq prod (* prod (divisori i)))
    )
    (for (i 0 (- (length divisori) 1))
      (setq p (/ prod (divisori i)))
      (setq sum (+ sum (* (resti i) (mul-inv p (divisori i)) p)))
    )
    (list (% sum prod) prod)
  )
)

Funzione per il calcolo del minimo comune multiplo:

(define (lcm_ a b) (/ (* a b) (gcd a b)))
(define-macro (lcm) (apply lcm_ (args) 2))

(lcm 3 5 7)
;-> 105
(apply lcm '(3 5 7))
;-> 105

Funzione finale per il Teorema Cinese dei Resti:

(define (trc divisori resti)
    ;se tutte le coppie di numeri sono coprimi tra loro
    ;(minimo comune multiplo(numeri) = prodotto(numeri))
    (if (= (apply * divisori) (apply lcm divisori))
        ;allora cerchiamo la soluzione
        (chinese divisori resti)
        ; altrimenti nessuna soluzione
        nil))

(trc '(3 5 7) '(2 3 2))
;-> (23 105)

La soluzione vale (23 + k*105) dove k=...,-2,-1,0,1,2,...

(trc '(3 5 10) '(2 3 2))
;-> nil

Esempio di applicazione del teorema:

Un generale deve contare i suoi soldati. Invece di contarli uno ad uno, li fa disporre in diversi modi:
1) se messi in fila per 5, allora l'ultima fila ha 1 soldato
2) se messi in fila per 8, allora l'ultima fila ha 7 soldati
3) se messi in fila per 7, allora l'ultima fila ha 6 soldati

A questo punto il generale applica il Teorema Cinese dei Resti e calcola il numero dei soldati:

(chinese '(5 8 7) '(1 7 6))
;-> (111 280)

Infatti risulta:
(% 111 5)
;-> 1
(% 111 8)
;-> 7
(% 111 7)
;-> 6

Applicazioni del teorema cinese dei resti
-----------------------------------------
La maggior parte delle implementazioni di RSA utilizza il teorema cinese del resto durante la firma dei certificati HTTPS e durante la decrittografia.
Il teorema cinese del resto può essere utilizzato anche nella condivisione segreta, che consiste nel distribuire un insieme di dati tra un gruppo di persone che, tutti insieme (ma nessuno da solo), possono recuperare un certo valore dall'insieme dei dati. Ciascuna delle parti è rappresentata da una congruenza e la soluzione del sistema di congruenze utilizzando il teorema cinese dei resti è il numero segreto da recuperare. La condivisione segreta che utilizza il teorema cinese del resto utilizza anche speciali sequenze di interi che garantiscono l'impossibilità di recuperare il numero da un insieme di dati con meno di una certa cardinalità.

Il teorema cinese dei resti è stato utilizzato per costruire una numerazione di Gödel per le sequenze, che è coinvolta nella dimostrazione dei teoremi di incompletezza di Gödel.


----------------
NUMERI ATTRAENTI
----------------

Un numero viene detto attraente se il numero dei suoi fattori primi (distinti o meno) è primo. Per esempio, il numero 20, la cui scomposizione prima è 2 × 2 × 5, è un numero attraente perché anche il numero dei suoi fattori primi (3) è primo.

(define (prime? n) (= (length (factor n)) 1))
(define (attractive? n) (prime? (length (factor n))))
(filter attractive? (sequence 2 120))

Output:
;-> (4 6 8 9 10 12 14 15 18 20 21 22 25 26 27 28 30 32 33 34 35 38
;->  39 42 44 45 46 48 49 50 51 52 55 57 58 62 63 65 66 68 69 70 72
;->  74 75 76 77 78 80 82 85 86 87 91 92 93 94 95 98 99 102 105 106
;->  108 110 111 112 114 115 116 117 118 119 120)


----
IBAN
----

Scrivere una funzione che controlla se un codice dato rappresenta un numero IBAN (International Bank Account Number).

(setq *iban-code-length* '((15  ("NO"))
                             (16  ("BE"))
                             (18  ("DK" "FO" "FI" "GL" "NL"))
                             (19  ("MK" "SI"))
                             (20  ("AT" "BA" "EE" "KZ" "LT" "LU"))
                             (21  ("CR" "HR" "LV" "LI" "CH"))
                             (22  ("BH" "BG" "GE" "DE" "IE" "ME" "RS" "GB"))
                             (23  ("GI" "IL" "AE"))
                             (24  ("AD" "CZ" "MD" "PK" "RO" "SA" "SK" "ES" "SE" "TN" "VG"))
                             (25  ("PT"))
                             (26  ("IS" "TR"))
                             (27  ("FR" "GR" "IT" "MR" "MC" "SM"))
                             (28  ("AL" "AZ" "CY" "DO" "GT" "HU" "LB" "PL"))
                             (29  ("BR" "PS"))
                             (30  ("KW" "MU"))
                             (31  ("MT"))))

;; Remove spaces and set upper case.
(define (sanitize-iban iban)
   (upper-case (replace " " iban ""))
)

;; Check that only A-Z and 0-9 are used.
(define (valid-chars? iban)
  (setq rx (string "[A-Z0-9]{" (length iban) "}" ))
  (regex rx iban 1)
)

;; Check that the length is correct for the country.
(define (valid-length? iban)
  (setq countries-found (lookup (int (length iban)) *iban-code-length*))
  (if (not (nil? countries-found))
    (member (0 2 iban) countries-found)
  )
)

;; Convert the IBAN to integer following the rules from Wikipedia.
(define (iban-to-integer iban)
    (setq country-code (0 2 iban))
    (setq checksum (2 2 iban))
    (setq iban (string (4 iban) country-code))
    (setq iban (join (map (lambda (x) (if (regex "[0-9]" x) x (string (- (char x) 55)))) (explode iban))))
    (bigint (string iban checksum))
)

;; Test if IBAN is correct (true) or not (nil):
;; (valid-iban? "GB82 WEST 1234 5698 7654 32") ==> true
;; (valid-iban? "GB82 TEST 1234 5698 7654 32") ==> nil
(define (valid-iban? iban)
    (setq iban (sanitize-iban iban))
    (and
        (valid-chars? iban)
        (valid-length? iban)
        (= 1L (% (iban-to-integer iban) 97))
    )
)

(valid-iban? "GB82 WEST 1234 5698 7654 32")
;-> true

(valid-iban? "GB82 TEST 1234 5698 7654 32")
;-> nil


-----------------------
ESTENDERE IL LINGUAGGIO
-----------------------

Introdurre un nuovo meccanismo di controllo del flusso. Un esempio pratico e utile è un ramo a quattro vie (four-way branch): alle volte, è necessario scrivere codice che dipende da due condizioni, risultando in un massimo di quattro rami (a seconda che entrambe, solo la prima, solo la seconda o nessuna delle condizioni siano "vere"). In un linguaggio simile al C questo potrebbe essere il seguente:

  if (condition1isTrue) {
     if (condition2isTrue)
        bothConditionsAreTrue();
     else
        firstConditionIsTrue();
  }
  else if (condition2isTrue)
     secondConditionIsTrue();
  else
     noConditionIsTrue();

Oltre ad essere piuttosto ingombrante, le espressioni per 'condition2isTrue' devono essere scritte due volte. Se 'condition2isTrue' fosse un'espressione lunga e complessa, sarebbe abbastanza illeggibile e il codice generato dal compilatore potrebbe essere inutilmente grande.

Questo può essere migliorato introducendo una nuova parola chiave if2. È simile a if, ma accetta due istruzioni condizionali invece di una e fino a tre istruzioni "else". Una proposta (in sintassi pseudo-C) potrebbe essere:

  if2 (condition1isTrue) (condition2isTrue)
     bothConditionsAreTrue();
  else1
     firstConditionIsTrue();
  else2
     secondConditionIsTrue();
  else
     noConditionIsTrue();

Scegli la sintassi che si adatta al tuo linguaggio. Le parole chiave "else1" e "else2" sono solo esempi. La nuova espressione condizionale dovrebbe apparire, annidarsi e comportarsi in modo analogo all'istruzione "if" incorporata nel linguaggio.

(context 'if2)

(define-macro (if2:if2 cond1 cond2 both-true first-true second-true neither)
  (cond
    ((eval cond1)
      (if (eval cond2)
            (eval both-true)
            (eval first-true)))
    ((eval cond2)
      (eval second-true))
    (true
      (eval neither))))

(context MAIN)

(if2 true true 'bothTrue 'firstTrue 'secondTrue 'else)
;-> bothTrue
(if2 true false 'bothTrue 'firstTrue 'secondTrue 'else)
;-> firstTrue
(if2 false true 'bothTrue 'firstTrue 'secondTrue 'else)
;-> secondTrue
(if2 false false 'bothTrue 'firstTrue 'secondTrue 'else)
;-> else


------------------------
COMPOSIZIONE DI FUNZIONI
------------------------

Creare una funzione "compose" i cui due argomenti f e g sono entrambi funzioni con un argomento.
Il risultato di compose deve essere una funzione di un argomento, (chiamiamo l'argomento x), che applica la funzione f al risultato dell'applicazione della funzione g a x: compose(f, g) (x) = f(g(x)).

(define (compose f g) (expand (lambda (x) (f (g x))) 'f 'g))

((compose sin asin) 0.5)
;-> 0.5
((compose sqrt pow) 3)
;-> 3


--------------------
CALCOLO DI UNA SERIE
--------------------

Calcolare l'ennesimo termine di una serie, cioè la somma degli n primi termini della sequenza corrispondente.
Questo valore, o il suo limite quando n tende all'infinito, è anche chiamato la somma della serie.

Definiamo una funzione che accetta tre parametri:
1) la funzione da calcolare
2) il valore iniziale dell'indice
3) il valore finale dell'indice

(define (sum-series func from to)
  (let (s 0)
    (for (i from to)
      (inc s (func i))
    )
    s))

Adesso per calcolare la serie di una funzione occorre prima definire la funzione matematica e poi usare "sum-series". Ad esempio:

Sum[x 1 n] (1/x^2) = π²/6
(define (f x) (div 1 (* x x)))
(sum-series f 1 1000)
;-> 1.643934566681562

Sum[x 0 n] (1/2^x) = 2
(define (g x) (div (pow 2 x)))
(sum-series g 0 1000)
;-> 2

Serie con segni alternati
Sum[x 1 n] (-1)^(n-1)/n = ln(2)
(define (h x) (div (pow -1 (- x 1)) x))
(sum-series h 1 1000)
;-> 0.6931471805599453
(log 2)
;-> 0.6931471805599453

Sum[x 0 n] 1/x! = e
(define (fact n)
  (if (zero? n)
      1
      (apply * (map bigint (sequence 1 n)))))
(define (o x) (div (fact x)))
(sum-series o 0 100)
;-> 2.718281828459046


-------------
NUMERI GAPFUL
-------------

I numeri (interi positivi espressi in base dieci) che sono (esattamente) divisibili per il numero formato dalla prima e dall'ultima cifra sono noti come numeri gapful. Esattamente divisibile significa divisibile senza resto.
Tutti i numeri a una e due cifre hanno questa proprietà e sono banalmente esclusi. Solo i numeri ≥ 100 saranno considerati.
Esempio
187 è un numero gapful perché è esattamente divisibile per il numero 17 che è formato dalla prima e dall'ultima cifra decimale di 187.
Circa il 7,46% degli interi positivi è gapful.

;; Create an integer out of the first and last digits of a given integer
(define (first-and-last-digits number)
 (local (digits first-digit last-digit)
  (set 'digits (format "%d" number))
  (set 'first-digit (first digits))
  (set 'last-digit (last digits))
  (int (append first-digit last-digit))))

;; Divisibility test
(define (divisible-by? num1 num2)
 (zero? (% num1 num2)))

;; Gapfulness test
(define (gapful? number)
 (divisible-by? number (first-and-last-digits number)))

;; Increment until a gapful number is found
(define (next-gapful-after number)
 (do-until (gapful? number)
  (++ number)))

;; Return a list of gapful numbers beyond some (excluded) lower limit.
(define (gapful-numbers quantity lower-limit)
 (let ((gapfuls '()) (number lower-limit))
  (dotimes (counter quantity)
   (set 'number (next-gapful-after number))
   (push number gapfuls))
  (reverse gapfuls)))

;; Format a list of numbers together into decimal notation.
(define (format-many numbers)
 (map (curry format "%d") numbers))

;; Format a list of integers on one line with commas
(define (format-one-line numbers)
 (join (format-many numbers) ", "))

;; Display a quantity of gapful numbers beyond some (excluded) lower limit.
(define (show-gapfuls quantity lower-limit)
 (println "The first " quantity " gapful numbers beyond " lower-limit " are:")
 (println (format-one-line (gapful-numbers quantity lower-limit))))

; Example: calculate gapful numbers
(show-gapfuls 30 99)
;-> The first 30 gapful numbers beyond 99 are:
;-> 100, 105, 108, 110, 120, 121, 130, 132, 135, 140, 143, 150, 154, 160, 165,
;-> 170, 176, 180, 187, 190, 192, 195, 198, 200, 220, 225, 231, 240, 242, 253
(show-gapfuls 15 999999)
;-> The first 15 gapful numbers beyond 999999 are:
;-> 1000000, 1000005, 1000008, 1000010, 1000016, 1000020, 1000021, 1000030,
;-> 1000032, 1000034, 1000035, 1000040, 1000050, 1000060, 1000065
(show-gapfuls 10 999999999)
;-> The first 10 gapful numbers beyond 999999999 are:
;-> 1000000000, 1000000001, 1000000005, 1000000008, 1000000010,
;-> 1000000016, 1000000020, 1000000027, 1000000030, 1000000032


----------------------------------
VALUTAZIONE DI UNA ESPRESSIONE RPN
----------------------------------

Valutare il valore di un'espressione aritmetica nella notazione polacca inversa (Reverse Polish Notation). Gli operatori validi sono:

"+" "-" "*" "/" "%"
"add" "sub" "mul" "div" "mod" "pow"
"abs" "sqrt" "exp"
"sin" "cos" "tan"
"asin" "acos" "atan" "atan2"

Ogni operando può essere un numero o un'altra espressione. Per esempio:

Questo problema può essere risolto utilizzando una pila (stack). Valutiamo ogni elemento dell'espressione (lista):
- quando è un numero, lo mettiamo nella pila (push).
- quando è un operatore, prendiamo (pop) i numeri che servono dalla pila, eseguiamo il calcolo e mettiamo (push) il risultato nella pila (per decidere quanti sono "i numeri che servono dalla pila" basta vedere quanti numeri servono all'operatore corrente).

Per capire come funziona, scriviamo una versione che accetta solo le quattro operazioni "+" "-" "*" "/":

(define (eval-rpn lst)
  (local (stack a b)
    (setq stack '())
    (dolist (el lst)
      (if (number? el) ; se è un numero...
          (push el stack) ; lo metto nella pila
          (begin ; altrimenti è un operatore
            ; prendo due numeri dalla pila
            (setq a (pop stack))
            (setq b (pop stack))
            ; applico l'operatore e
            ; inserisco il risultato nella pila
            (cond ((= el '+) (push (+ a b) stack))
                  ((= el '-) (push (- b a) stack))
                  ((= el '*) (push (* a b) stack))
                  ((= el '/) (push (/ b a) stack))
                  (true (println "error"))
            )
          )
      )
    )
    ;restituisco il valore in cima alla pila
    (pop stack)
  )
)

Adesso scriviamo la funzione che accetta tutti gli operatori:

(define (eval-rpn lst)
  (local (stack a b op op1 op2)
    (setq stack '())
    ; lista operatori con un argomento
    (setq op1 '(abs sqrt exp sin cos tan asin acos atan))
    ; lista operatori con due argomenti
    (setq op2 '(+ - * / % add sub mul div mod pow atan2))
    ; Per ogni simbolo della lista...
    (dolist (el lst)
      (cond ((number? el)     ; se è un numero...
             (push el stack)) ; lo metto nella pila
            (true ; altrimenti è un operatore
             (cond ((find el op1) ; se è un operatore unario...
                    (setq a (pop stack))    ; prendo numero dalla pila
                    (setq op (eval el))     ; calcolo operazione
                    (push (op a) stack))    ; inserisco risultato nella pila
                   ((find el op2) ; se è un operatore binario...
                    (setq a (pop stack))    ; prendo primo numero dalla pila
                    (setq b (pop stack))    ; prendo secondo numero dalla pila
                    (setq op (eval el))     ; calcolo operazione e
                    (push (op b a) stack))  ; inserisco risultato nella pila
                   (true (println "operator error:" el))
             ))
      )
    )
    ;restituisco il valore in cima alla pila
    (pop stack)
  )
)

(eval-rpn '(3 2 + 7 * 4 / ))
;-> 8
(eval-rpn '(3 2 + 7 * 4 / 2.5 add))
;-> 10.5
(eval-rpn '(4 13 5 / +))
;-> 6
(eval-rpn '(3 2 pow))
;-> 9
(eval-rpn '(3 4 - abs))
;-> 1
(eval-rpn '(10 4 %))
;-> 2
(eval-rpn '(3 4 2 * 1 5 - 2 3 pow pow / +))
;-> 3

Proviamo a scrivere un'altra funzione che accetta anche le variabili globali. Per fare questo valutiamo gli elementi dell'espressione rpn e sostituiamo i valori, per esempio:

(setq q 3 t 5)
(setq expr '(q t 2 * 1 5 - 2 3 pow pow / +))
(map eval expr)
;-> (3 5 2 *@414964 1 5 -@414951 2 3 pow@40D998 pow@40D998 /@414977 +@41493E)

Questo non va bene perchè valutiamo anche gli operatori (i numeri vengono valutati su se stessi), allora usiamo una funzione specifica:

(map (fn (x) (if (not (protected? x)) (eval x) x)) expr)
;-> (3 5 2 * 1 5 - 2 3 pow pow / +)

Come si vede le variabili "q" e "t" sono state sostituite dai loro valori. Se abbiamo una variabile non inizializzata questa non viene valutata:

(setq expr '(z q t 2 * 1 5 - 2 3 pow pow / +))
(map (fn (x) (if (not (protected? x)) (eval x) x)) expr)
;-> (z 3 5 2 * 1 5 - 2 3 pow pow / +)

e genererà un errore nella funzione "eval-rpn".

Adesso possiamo scrivere la funzione che utilizza le variabili globali:

(define (eval-rpn lst)
  (local (_stack _a _b _op _op1 _op2)
    (setq _stack '())
    ; lista operatori con un argomento
    (setq _op1 '(abs sqrt exp sin cos tan asin acos atan))
    ; lista operatori con due argomenti
    (setq _op2 '(+ - * / % add sub mul div mod pow atan2))
    ; Valuto gli elementi della lista (espressione rpn) e
    ; assegno il valore alle variabili
    (setq lst (map (fn (x) (if (not (protected? x)) (eval x) x)) lst))
    ; Per ogni simbolo della lista...
    (dolist (el lst)
      (cond ((number? el)      ; se è un numero...
             (push el _stack)) ; lo metto nella pila
            (true ; altrimenti è un operatore
             (cond ((find el _op1) ;operatore unario
                    (setq _a (pop _stack))    ; prendo numeri dalla pila
                    (setq _op (eval el))     ; calcolo operazione
                    (push (_op _a) _stack))    ; inserisco risultato nella pila
                   ((find el _op2) ;operatore binario
                    (setq _a (pop _stack))    ; prendo numeri dalla pila
                    (setq _b (pop _stack))    ; prendo numeri dalla pila
                    (setq _op (eval el))     ; calcolo operazione
                    (push (_op _b _a) _stack))  ; inserisco risultato nella pila
                   (true (println "operator error:" el))
             ))
      )
    )
    ;restituisco il valore in cima alla pila
    (pop _stack)
  )
)

(eval-rpn '(3 4 2 * 1 5 - 2 3 pow pow / +))
;-> 3
(setq a 10 b 20)
(setq c (eval-rpn '(a b +)))
;-> 30

(eval-rpn '(a b + 5 - sqrt))
;-> 5


---------------
IL GIOCO DEL 24
---------------

Dati quattro numeri distinti da 1 a 9, costruire un'espressione con questi numeri e le quattro operazioni (+, -, *, /) che valuti a 24. Per esempio, con i numeri 2, 4, 5, e 6 possiamo scrivere: (((6 - 2) * 5) + 4) = 24
Occorre utilizzare tutti i numeri della lista, ma non è necessario utilizzare tutte e quattro le operazioni nell'espressione finale.

Risolviamo il problema creando e valutando tutte le possibili espressioni. La valutazione delle espressioni viene fatta in modo rpn.

(define (eval-rpn lst)
  (local (stack a b op op1 op2)
    (setq stack '())
    (setq op1 '(abs sqrt exp sin cos tan asin acos atan))
    (setq op2 '(+ - * / % add sub mul div mod pow atan2))
    (dolist (el lst)
      (cond ((number? el)
             (push el stack))
            (true
             (cond ((find el op1)
                    (setq a (pop stack))
                    (setq op (eval el))
                    (push (op a) stack))
                   ((find el op2)
                    (setq a (pop stack))
                    (setq b (pop stack))
                    (setq op (eval el))
                    (push (op b a) stack))
                   (true (println "operator error:" el))))))
    (pop stack)))

(eval-rpn '(3 2 + 7 * 4 / ))
;-> 8

Per creare le espressioni da valutare occorrono due funzioni di calcolo combinatorio: le permutazioni senza ripetizioni e le permutazioni con ripetizione.

Permutazioni senza ripetizione (n!):

(define (perm lst)
  (local (i indici out)
    (setq indici (dup 0 (length lst)))
    (setq i 0)
    (setq out (list lst))
    (while (< i (length lst))
      (if (< (indici i) i)
          (begin
            (if (zero? (% i 2))
              (swap (lst 0) (lst i))
              (swap (lst (indici i)) (lst i))
            )
            (push lst out -1)
            (++ (indici i))
            (setq i 0)
          )
          (begin
            (setf (indici i) 0)
            (++ i)
          )
       )
    ) out))

(perm '(a b c))
;-> ((a b c) (b a c) (c a b) (a c b) (b c a) (c b a))

(perm '(a b b))
;-> ((a b b) (b a b) (b a b) (a b b) (b b a) (b b a))

Permutazioni con ripetizione (n^k):

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 2 '(a b c))
;-> ((a a) (b a) (c a) (a b) (b b) (c b) (a c) (b c) (c c))

(perm-rep 2 '(a b b))
;-> ((a a) (b a) (b a) (a b) (b b) (b b) (a b) (b b) (b b))

Lista delle operazioni:
(setq op '(add sub mul div))

Lista delle operazioni possibili (n^k) = 4^3 = 64:
(setq operats (perm-rep 3 op))
;-> ((add add add) (sub add add) (mul add add) (div add add)
;->  (add sub add) (sub sub add) (mul sub add) (div sub add)
;->  ...
;->  (add div div) (sub div div) (mul div div) (div div div))

(length operats);-> 64
(pow 4 3);-> 64

Lista dei numeri singoli:
(setq num '(3 7 1 8))

Lista dei numeri possibili (n! = 4! = 24):
(setq digits (perm num))
;-> ((3 7 1 8) (7 3 1 8) (1 3 7 8) (3 1 7 8) (7 1 3 8) (1 7 3 8) (8 7 3 1)
;->  (7 8 3 1) (3 8 7 1) (8 3 7 1) (7 3 8 1) (3 7 8 1) (3 1 8 7) (1 3 8 7)
;->  (8 3 1 7) (3 8 1 7) (1 8 3 7) (8 1 3 7) (8 1 7 3) (1 8 7 3) (7 8 1 3)
;->  (8 7 1 3) (1 7 8 3) (7 1 8 3))

(length digits)
;-> 24

Adesso possiamo unire le due liste per creare una espressione da valutare.

Creazione dell'espressione da valutare:
(setq expr (append (digits 0) (operats 0)))
;-> (3 7 1 8 add add add)

Valutazione dell'espressione:
(eval-rpn expr)
;-> 19

Adesso scriviamo la funzione finale:

(define (game24 lst)
(local (op operats num digits out)
  (setq out '())
  (setq op '(add sub mul div))
  (setq operats (perm-rep 3 op))
  (setq digits (perm lst))
  (dolist (digit digits)
    (dolist (oper operats)
      (setq expr (append digit oper))
      (if (= 24 (eval-rpn expr))
          (begin
          ;(println expr)
          (replace 'add expr '+)
          (replace 'sub expr '-)
          (replace 'mul expr '*)
          (replace 'div expr '/)
          (println expr)
          (push expr out -1)
          )
      )
    )
  )
  out))

(game24 '(2 4 5 6))
;-> (4 5 2 6 - * -)
;-> (6 2 4 5 + * +)
;-> (6 2 4 5 * - -)
;-> (6 2 5 4 + * +)
;-> (6 2 5 4 * - -)
;-> (4 5 6 2 - * +)
;-> ((4 5 2 6 - * -) (6 2 4 5 + * +) (6 2 4 5 * - -)
;->  (6 2 5 4 + * +) (6 2 5 4 * - -) (4 5 6 2 - * +))

Proviamo a generalizzare il gioco  utilizzando fino a 9 numeri iniziali (1..9) e un numero qualunque da raggiungere (goal). Inoltre convertiamo l'espressione rpn in espressione infissa per la stampa.

Routine che converte l'espressione rpn nella corrispondente espressione infissa:

(define (infix lst)
  (local (s c)
    (setq s "")
    (setq c (/ (length lst) 2))
    (setq lst (map string lst))
    (dotimes (i c)
      (push "(" s -1)
      (push (lst i) s -1)
      (push " " s -1)
      (push (lst (- (length lst) 1 i)) s -1)
      (push " " s -1)
    )
    (push (lst c) s -1)
    (push (dup ")" c) s -1)
    s))

(infix '(2 1 4 3 5 6 7 8 9 * * - + + * - +))
;-> "(2 + (1 - (4 * (3 + (5 + (6 - (7 * (8 * 9))))))))"

Routine che converte l'espressione rpn nella corrispondente espressione prefissa:

(define (pre-fix lst)
  (local (s c)
    (setq s "")
    (setq c (/ (length lst) 2))
    (setq lst (map string lst))
    (dotimes (i c)
      (push "(" s -1)
      (push (lst (- (length lst) 1 i)) s -1)
      (push " " s -1)
      (push (lst i) s -1)
      (push " " s -1)
    )
    (push (lst c) s -1)
    (push (dup ")" c) s -1)
    s))

(pre-fix '(2 1 4 3 5 6 7 8 9 * * - + + * - +))
;-> "(+ 2 (- 1 (* 4 (+ 3 (+ 5 (- 6 (* 7 (* 8 9))))))))"

(eval-string (pre-fix '(2 1 4 3 5 6 7 8 9 * * - + + * - +)))
;-> 1963

Funzione finale:

(define (game-number lst goal)
(local (op operats digits out)
  (setq out '())
  (setq op '(add sub mul div))
  (setq operats (perm-rep (- (length lst) 1) op))
  (setq digits (perm lst))
  (dolist (digit digits)
    (dolist (oper operats)
      (setq expr (append digit oper))
      (if (= goal (eval-rpn expr))
          (begin
          ;(println expr)
          (replace 'add expr '+)
          (replace 'sub expr '-)
          (replace 'mul expr '*)
          (replace 'div expr '/)
          (println (infix expr))
          (push (list expr (infix expr)) out -1)
          )
      )
    )
  )
  out))

Proviamo con il gioco del 24:

(game-number '(2 4 5 6) 24)
;-> (4 - (5 * (2 - 6)))
;-> (6 + (2 * (4 + 5)))
;-> (6 - (2 - (4 * 5)))
;-> (6 + (2 * (5 + 4)))
;-> (6 - (2 - (5 * 4)))
;-> (4 + (5 * (6 - 2)))
;-> ((4 5 2 6 - * -) (6 2 4 5 + * +) (6 2 4 5 * - -)
;->  (6 2 5 4 + * +) (6 2 5 4 * - -) (4 5 6 2 - * +))

Proviamo un insieme di numeri che non hanno soluzione:

(game-number '(5 7 5 1) 24)
;-> ()

Proviamo con altri numeri:

(game-number '(1 3 7 10 25 50) 831)
;-> ()

(game-number '(1 3 7 10 25 50) 765)
(25 + (10 * (50 + (3 * (1 + 7)))))
(50 / (10 / (3 - (25 * (1 - 7)))))
(50 / (10 / (3 + (25 * (7 - 1)))))
(25 + (10 * (50 + (3 * (7 + 1)))))
;-> (((25 10 50 3 1 7 + * + * +) "(25 + (10 * (50 + (3 * (1 + 7)))))")
;->  ((50 10 3 25 1 7 - * - / /) "(50 / (10 / (3 - (25 * (1 - 7)))))")
;->  ((50 10 3 25 7 1 - * + / /) "(50 / (10 / (3 + (25 * (7 - 1)))))")
;->  ((25 10 50 3 7 1 + * + * +) "(25 + (10 * (50 + (3 * (7 + 1)))))"))

(game-number '(1 2 3 4 5 6 7 8 9) 1963)
(2 + (1 - (4 * (3 + (5 + (6 - (7 * (8 * 9))))))))
(1 + (2 - (4 * (3 + (5 + (6 - (7 * (8 * 9))))))))
(3 - (4 * (1 + (2 + (5 + (6 - (7 * (8 * 9))))))))
(3 - (4 * (2 + (1 + (5 + (6 - (7 * (8 * 9))))))))
(3 + (5 * (4 - (1 * (2 + (6 * (7 - (8 * 9))))))))
......

Per verifica prendiamo il primo risultato:
(eval-rpn '(2 1 4 3 5 6 7 8 9 * * - + + * - +))
;-> 1963
(2 + (1 - (4 * (3 + (5 + (6 - (7 * (8 * 9))))))))
(2 + (1 - (4 * (3 + (5 + (6 - (7 * (72))))))))
(2 + (1 - (4 * (3 + (5 + (6 - (504)))))))
(2 + (1 - (4 * (3 + (5 + (-498))))))
(2 + (1 - (4 * (3 + (-493)))))
(2 + (1 - (4 * (-490))))
(2 + (1 - (-1960)))
(2 + 1961)
1963

(game-number '(1 2 3 4 5 6 7 8 9) 2020)
;-> (4 / (3 * (2 / (1 + (5 + (6 * (7 * (8 * 9))))))))
;-> (4 / (3 * (2 / (1 + (5 + (6 * (7 * (8 * 9))))))))
;-> ......

(game-number '(1 2 3 4 5 6 7 8 9) 666)
;-> (3 * (1 * (2 - (4 * (5 + (6 * (7 - (8 + 9))))))))
;-> (3 / (1 / (2 - (4 * (5 + (6 * (7 - (8 + 9))))))))
;-> (1 * (3 * (2 - (4 * (5 + (6 * (7 - (8 + 9))))))))
;-> (3 * (2 - (1 * (4 * (5 + (6 * (7 - (8 + 9))))))))
;-> (2 + (4 * (1 - (3 * (5 + (6 * (7 - (8 + 9))))))))
;-> (2 * (1 + (4 * (3 + (5 * (6 - (7 - (8 + 9))))))))
;-> ......

Nota:
Con 9 cifre (da 1 a 9) abbiamo n! = 9! = 362880 modi di disporre le cifre nell'espressione
Con 9 cifre abbiamo 8 operazioni con 4 operatori n^k = 4^8 = 65536 modi di disporre gli operatori nell'espressione.
(* 362880 65536)
;-> 23781703680 ; (23 miliardi 781 milioni 703 mila 680) espressioni


-------------
SEQUENZA FUSC
-------------

La sequenza "fusc" (chiamata anche sequenza di Stern) è definita nel modo seguente:

  fusc(0) = 0
  fusc(1) = 1
  per n > 1, fusc(n) vale:
  se n è pari:     fusc(n) = fusc(n/2)
  se n è dispari:  fusc(n) = fusc((n-1)/2) + fusc((n+1)/2)

Questa è la sequenza OEIS A2487.

Vediamo prima di tutto la versione ricorsiva:

(define (fusc n)
  (cond ((or (zero? n) (= 1 n)) n)
        ((even? n) (fusc (/ n 2)))
        (true (+ (fusc (/ (- n 1) 2)) (fusc(/ (+ n 1) 2))))))

(fusc 10)
;-> 3

(map fusc (sequence 0 100))
;-> (0 1 1 2 1 3 2 3 1 4 3 5 2 5 3 4 1 5 4 7 3 8 5 7 2 7 5 8 3
;->  7 4 5 1 6 5 9 4 11 7 10 3 11 8 13 5 12 7 9 2 9 7 12 5 13
;->  8 11 3 10 7 11 4 9 5 6 1 7 6 11 5 14 9 13 4 15 11 18 7 17
;->  10 13 3 14 11 19 8 21 13 18 5 17 12 19 7 16 9 11 2 11 9 16 7)

Adesso vediamo la versione iterativa.
Possiamo evitare completamente la ricorsione poiché possiamo sempre esprimere fusc(n) nella forma a*fusc(m) + b*fusc(m + 1) riducendo il valore di m a 0. Abbiamo il seguente schema:

se m è dispari:
a*fusc(m) + b*fusc(m+1) = a*fusc((m-1)/2) + (b+a)*fusc((m+1)/2)

se m è pari:
a*fusc(m) + b*fusc(m+1) = (a+b)*fusc(m/2) + b*fusc((m/2)+1)

Pertanto è possibile utilizzare un ciclo per risolvere il problema in tempo O(log n):

(define (fusc-i n)
  (local (a b)
    (setq a 1 b 0)
    (cond ((zero? n) 0)
          (true (while (> n 0)
                  (if (odd? n)
                      (setq b (+ b a) n (/ (- n 1) 2))
                      (setq a (+ a b) n (/ n 2)))
                )
          )
    )
    b))

(fusc-i 10)
;-> 3

(map fusc-i (sequence 0 100))
;-> (0 1 1 2 1 3 2 3 1 4 3 5 2 5 3 4 1 5 4 7 3 8 5 7 2 7 5 8 3
;->  7 4 5 1 6 5 9 4 11 7 10 3 11 8 13 5 12 7 9 2 9 7 12 5 13
;->  8 11 3 10 7 11 4 9 5 6 1 7 6 11 5 14 9 13 4 15 11 18 7 17
;->  10 13 3 14 11 19 8 21 13 18 5 17 12 19 7 16 9 11 2 11 9 16 7)

Adesso risolviamo il problema con la programmazione dinamica.
Memorizziamo i due casi base di fs(0) = 0, fs(1) = 1, e poi attraversiamo il vettore dall'indice 2 a n calcolando fs(i) come da definizione. Infine restituiamo il valore di fs(n).

(define (fusc-dp n)
  (let (fs (array (+ n 2) '(0)))
    (setf (fs 0) 0)
    (setf (fs 1) 1)
    (if (> n 1)
      (for (i 2 n)
        (if (even? i)
            (setf (fs i) (fs (/ i 2)))
            (setf (fs i) (+ (fs (/ (- i 1) 2)) (fs (/ (+ i 1) 2))))
        )
      )
    )
    (fs n)))

(fusc-dp 10)
;-> 10

(map fusc-dp (sequence 0 100)))
;-> (0 1 1 2 1 3 2 3 1 4 3 5 2 5 3 4 1 5 4 7 3 8 5 7 2 7 5 8 3
;->  7 4 5 1 6 5 9 4 11 7 10 3 11 8 13 5 12 7 9 2 9 7 12 5 13
;->  8 11 3 10 7 11 4 9 5 6 1 7 6 11 5 14 9 13 4 15 11 18 7 17
;->  10 13 3 14 11 19 8 21 13 18 5 17 12 19 7 16 9 11 2 11 9 16 7)

Vediamo se le tre funzioni producono risultati uguali:

(= (map fusc (sequence 0 100))
   (map fusc-i (sequence 0 100))
   (map fusc-dp (sequence 0 100)))
;-> true

Vediamo i tempi di esecuzione delle funzioni:

(time (map fusc (sequence 0 10000)))
;-> 622.346

(time (map fusc-i (sequence 0 10000)))
;-> 17.959

(time (map fusc-dp (sequence 0 10000)))
;-> 8244.964

La versione iterativa è quella più veloce, ma la versione con la programmazione dinamica calcola tutti i valori della funzione da 0 a n. Quindi il confronto dovrebbe essere fatto nel modo seguente.
Riscriviamo fusc-dp in modo che restituisca una lista con tutti i valori:

(define (fusc-n n)
  (let (fs (array (+ n 2) '(0)))
    (setf (fs 0) 0)
    (setf (fs 1) 1)
    (if (> n 1)
      (for (i 2 n)
        (if (even? i)
            (setf (fs i) (fs (/ i 2)))
            (setf (fs i) (+ (fs (/ (- i 1) 2)) (fs (/ (+ i 1) 2))))
        )
      )
    )
    (slice fs 0 (+ n 1))))

Vediamo se le funzioni producono risultati uguali:

(= (map fusc-i (sequence 0 100000)) (array-list (fusc-n 100000)))
;-> true

Adesso facciamo il confronto:

(time (map fusc-i (sequence 0 100000)))
;-> 217.446
(time (fusc-n 100000))
;-> 18.937

In questo caso (cioè quando vogliamo tutti i valori della funzione fusc da 0 a n) la funzione fusc-n è molto più veloce.


--------------
ALGORITMO DAMM
--------------

Nel rilevamento degli errori, l'algoritmo di Damm è un algoritmo di cifre di controllo che rileva tutti gli errori di una cifra e tutti gli errori di trasposizione adiacenti. È stato presentato da H. Michael Damm nel 2004.
L'algoritmo di Damm rileva tutte le occorrenze dei due tipi di errori di trascrizione più frequenti, vale a dire l'alterazione di una singola cifra e la trasposizione di due cifre adiacenti (inclusa la trasposizione della cifra di controllo finale e della cifra precedente).

(define (damm-encode number)
  (local (dm out)
    (setq dm
      '((0 3 1 7 5 9 8 6 4 2)
        (7 0 9 2 1 5 4 8 6 3)
        (4 2 0 6 8 7 1 3 5 9)
        (1 7 5 0 9 8 3 4 2 6)
        (6 1 2 3 0 4 5 9 7 8)
        (3 6 7 4 2 0 9 5 8 1)
        (5 8 6 9 7 2 0 1 3 4)
        (8 9 4 5 3 6 2 0 1 7)
        (9 4 3 8 6 1 7 2 0 5)
        (2 5 8 1 4 3 6 7 9 0)))
    (setq out 0)
    (dostring (el (string number))
      (setq out (dm out (int (char el))))
    )
    out))

(define (check-damm-encode number)
  (zero? (damm-encode number)))

(damm-encode 572)
;-> 4

(check-damm-encode 5724)
;-> true

(damm-encode 43881234567)
;-> 9

(check-damm-encode 438812345679)
;-> true


----------------------------------
DISTANZA TRA DUE PUNTI DELLA TERRA
----------------------------------

Utilizziamo la formula "haversine" per calcolare la distanza minima tra due punti di una sfera (tale distanza viene chiamata "ortodromia"). Si tratta quindi della distanza più breve tra due punti della superficie terrestre (in linea d'aria e ignorando l'orografia).
Le coordinate per la latitudine e la longitudine sono espresse in gradi decimali.

(define (deg-rad deg) (div (mul deg 3.1415926535897931) 180))

(define (dist-earth lat1 lon1 lat2 lon2)
  (local (r dLat dLon a c d)
  (setq r 6371) ; raggio medio della terra in km
  (setq dLat (deg-rad (sub lat2 lat1))) ; delta lat (in radianti)
  (setq dLon (deg-rad (sub lon2 lon1))) ; delta lon (in radianti)
  (setq a (add (mul (sin (div dLat 2)) (sin (div dLat 2)))
               (mul (cos (deg-rad lat1)) (cos (deg-rad lat2))
                    (sin (div dLon 2)) (sin (div dLon 2)))))
  (setq c (mul 2 (atan2 (sqrt a) (sqrt (sub 1 a)))))
  (setq d (mul r c)))) ; distanza in km

(dist-earth 42.123456 13.123456 54.654321 8.654321)
;-> 1431.173709679866
(dist-earth 42.123456 -10.123456 54.654321 -2.654321)
;-> 1496.522788559527

La formula di haversine produce un errore massimo dello 0.5% (poichè la terra è un elissoide e non una sfera).


-----------------
ALGORITMO SOUNDEX
-----------------

Soundex è un algoritmo fonetico per l'indicizzazione dei nomi in base al suono (come pronunciati in inglese). L'obiettivo è che gli omofoni (parole che hanno la stessa pronuncia, ma differiscono nella grafia) siano codificati nella stessa rappresentazione in modo che possano essere riconosciuti come simili nonostante piccole differenze di ortografia. L'algoritmo codifica principalmente le consonanti, una vocale non viene codificata a meno che non sia la prima lettera. Soundex è il più conosciuto di tutti gli algoritmi fonetici ed è la base di molti algoritmi fonetici moderni.

I passi dell'algoritmo ufficiale sono i seguenti:

1) Conserva la prima lettera del nome e elimina tutte le altre occorrenze di a, e, i, o, u, y, h, w.
2) Sostituisci le consonanti con le cifre come segue (dopo la prima lettera):
   b, f, p, v → 1
   c, g, j, k, q, s, x, z → 2
   d, t → 3
   l → 4
   m, n → 5
   r → 6
3) Se due o più lettere con lo stesso numero sono adiacenti nel nome originale (prima del passaggio 1), conservare solo la prima lettera. Anche due lettere con lo stesso numero separate da "h" o "w" sono codificate come un numero unico, mentre tali lettere separate da una vocale sono codificate due volte. Questa regola si applica anche alla prima lettera.
4) Se hai poche lettere nel nome e non puoi assegnare tre numeri, aggiungi degli zeri fino a quando non ci sono tre numeri. Se hai quattro o più numeri, conserva solo i primi tre.

Funzione che formatta una stringa in una determinata lunghezza con un carattere predefinito:

(define (pad-string str ch len)
  (local (out len-str)
    (setq out "")
    (setq len-str (length str))
    (cond ((zero? len-str) (setq out (dup ch len)))
          ((= len-str len) (setq out str))
          ((> len-str len) (setq out (slice str 0 len)))
          ((< len-str len) (setq out (push (dup ch (- len len-str)) str -1))))))

(pad-string "" "0" 2)
;-> 00
(pad-string "ABC" "0" 5)
;-> "ABC00"
(pad-string "ABC" "0" 3)
;-> "ABC"
(pad-str "ABC" "0" 2)
;-> "AB"
(pad-str "ABC" "0" 0)
;-> ""

Funzione di decodifica dei caratteri:

(define (getcode ch)
  (letn ((lst '(("B" "1") ("F" "1") ("P" "1") ("V" "1")
                ("C" "2") ("G" "2") ("J" "2") ("K" "2")
                ("Q" "2") ("S" "2") ("X" "2") ("Z" "2")
                ("D" "3") ("T" "3")
                ("L" "4")
                ("M" "5") ("N" "5")
                ("R" "6")
                ("H" "-") ("W" "-")))
        (out (lookup ch lst)))
        (if (nil? out) (setq out ""))
        out))

(getcode "B")
;-> "1"
(getcode "A")
;-> ""
(getcode "H")
;-> "-"

Adesso possiamo scrive la funzione finale "soundex":

(define (soundex str)
  (local (out prev curr)
    (setq str (upper-case str))
    (setq out (str 0))
    (setq prev (getcode (out 0)))
    (dostring (el str)
      (setq curr (getcode (char el)))
      (if (and (!= curr "") (!= curr "-") (!= curr prev))
        (push curr out -1)
      )
      (if (!= curr "-") (setq prev curr))
    )
    (pad-string out "0" 4)))

(soundex "Ashcroft")
;-> A261

(setq lista '("Ashcraft" "Ashcroft" "Gauss" "Ghosh" "Hilbert" "Heilbronn" "Lee" "Lloyd"
              "Moses" "Pfister" "Robert" "Rupert" "Rubin" "Tymczak" "Soundex" "Example"))

(map soundex lista)
;-> ("A261" "A261" "G200" "G200" "H416" "H416" "L000" "L300"
;->  "M220" "P236" "R163" "R163" "R150" "T522" "S532" "E251")

Nota: la maggior parte dei database SQL usa un algoritmo leggermente diverso.

Vediamo cosa accade con dei nomi italiani:

(setq lista '("Mario" "Marco" "Sara" "Lara" "Luca" "Luisa" "Lisa"
              "Massimo" "Massimiliano" "Maria" "Marta"))

(map soundex lista)
;-> ("M600" "M620" "S600" "L600" "L200" "L200" "L200"
;->  "M250" "M254" "M600" "M630")


-------------------------------------
TRASFORMATA DISCRETA DI FOURIER (DFT)
-------------------------------------

Calcola la trasformata discreta di Fourier (DFT) della lista/vettore di numeri complessi in ingresso.

La lista/vettore ha la seguente struttura:

((real1 img1) (real2 img2) ... (realN imgN))

(setq PI 3.1415926535897931)

(define (dft input)
  (local (len sum-real sum-img angle)
    (setq len (length input))
    (setq output (array len '(0)))
    (for (k 0 (- len 1))
      (setq sum-real 0 sum-img 0)
      (for (t 0 (- len 1))
        (setq angle (div (mul 2 PI t k) len))
        (setq sum-real (add sum-real (add (mul (first (input t)) (cos angle))
                                          (mul (last (input t)) (sin angle)))))
        (setq sum-img  (add sum-img  (sub (mul (last (input t)) (cos angle))
                                          (mul (first (input t)) (sin angle)))))
      )
      ;(println sum-real { } sum-img)
      (setf (output k) (list sum-real sum-img))
    )
    output))

Vediamo alcuni esempi:

(setq in '((1 0) (4 0) (3 0) (2 0)))
(dft in)
;-> ((10 0) (-2 -2) (-2 -4.898425415289509e-016) (-2 1.999999999999999))

(setq in '((8 0) (4 0) (8 0) (0 0)))
(dft in)
;-> ((20 0) (0 -4.000000000000001)
;->  (12 1.469527624586853e-015)
;->  (-8.881784197001252e-016 3.999999999999997))

(setq in '(
  (0.4967  0) (-0.1383 0) ( 0.6477 0) ( 1.523  0) (-0.2342 0) (-0.2341 0) ( 1.5792 0)
  ( 0.7674 0) (-0.4695 0) ( 0.5426 0) (-0.4634 0) (-0.4657 0) ( 0.242  0) (-1.9133 0)
  (-1.7249 0) (-0.5623 0) (-1.0128 0) ( 0.3142 0) (-0.908  0) (-1.4123 0) ( 1.4656 0)
  (-0.2258 0) ( 0.0675 0) (-1.4247 0) (-0.5444 0) ( 0.1109 0) (-1.151  0) ( 0.3757 0)
  (-0.6006 0) (-0.2917 0) (-0.6017 0) ( 1.8523 0)))

(setq out (dft in))

Formattiamo meglio il risultato:

(setq outf
  (map list (map (fn(x) (format "%5.4f" (first x))) out)
            (map (fn(x) (format "%5.4f" (last x))) out)))

(dolist (el outf) (println (first el) { } (last el) "i"))
;-> -4.3939 0.0000i
;-> 9.0217 -3.7036i
;-> -0.5874 -6.2268i
;-> 2.5184 3.7749i
;-> 0.5008 -0.8433i
;-> 1.2904 -0.4024i
;-> 4.3391 0.8079i
;-> -6.2614 2.1596i
;-> 1.8974 2.4889i
;-> 0.1042 7.6169i
;-> 0.3606 5.1620i
;-> 4.7965 0.0755i
;-> -5.3064 -3.2329i
;-> 4.6237 1.5287i
;-> -2.1211 4.4873i
;-> -4.0175 -0.3712i
;-> -2.0297 -0.0000i
;-> -4.0175 0.3712i
;-> -2.1211 -4.4873i
;-> 4.6237 -1.5287i
;-> -5.3064 3.2329i
;-> 4.7965 -0.0755i
;-> 0.3606 -5.1620i
;-> 0.1042 -7.6169i
;-> 1.8974 -2.4889i
;-> -6.2614 -2.1596i
;-> 4.3391 -0.8079i
;-> 1.2904 0.4024i
;-> 0.5008 0.8433i
;-> 2.5184 -3.7749i
;-> -0.5874 6.2268i
;-> 9.0217 3.7036i

L'esempio di wikipedia produce risultati differenti:

(setq in '((1 0) (2 -1) (0 -1) (1 2)))

(setq out (dft in))
(setq outf
  (map list (map (fn(x) (format "%5.4f" (first x))) out)
            (map (fn(x) (format "%5.4f" (last x))) out)))
(dolist (el outf) (println (first el) { } (last el) "i"))
;-> 4.0000  0.0000i
;-> -2.0000 -0.0000i
;-> -2.0000 -2.0000i
;-> 4.0000  2.0000i


-----------------
NUMERI DI HARSHAD
-----------------

Un numero di Harshad in una data base è un numero intero positivo divisibile per la somma delle proprie cifre.
La definizione è stata data dal matematico indiano Dattatreya Ramachandra Kaprekar. Il termine Harshad deriva dal sanscrito "harṣa" che significa "grande gioia". A volte ci si riferisce a questi numeri anche come numeri di Niven, in onore del matematico Ivan Morton Niven.

(define (digit-sum num)
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10)))
    out))

(define (harshad? num)
  (zero? (% num (digit-sum num))))

(setq hd (map harshad? (sequence 1 50)))
(filter true? (map (fn(x) (if x (+ $idx 1))) hd))
;-> (1 2 3 4 5 6 7 8 9 10 12 18 20 21 24 27 30 36 40 42 45 48 50)

Vediamo la velocità:

(time (map harshad? (sequence 1 100000)))
;-> 85.214
(time (map harshad? (sequence 1 1000000)))
;-> 992.429
(time (map harshad? (sequence 1 10000000)))
;-> 10963.707


-------------
NUMERI HUMBLE
-------------

I numeri humble (umili) sono numeri interi positivi che non hanno fattori primi > 7.
Un altro modo per esprimere i numeri Humble è il seguente:

  humble = 2^i × 3^j × 5^k × 7^m
         dove i, j, k, m ≥ 0

1) Trovare i primi 50 numeri Humble.
2) Trovare il numero di numeri Humble che hanno x cifre con 1<= x <= 9

Prima scriviamo una funzione per verificare se un dato numero > 1 è un numero Humble.
Usiamo le primitive di newLISP "factor" e "difference":

(setq ok '(2 3 5 7))
(setq lst1 '(2 3 4 5 7))
(setq lst2 '(2 3 5 5 7))
(setq lst3 '(2))

(difference lst1 ok)
;-> (4)
(difference lst2 ok)
;-> ()
(difference lst3 ok)
;-> ()

Ecco la funzione:

(define (humble? num)
  (null? (difference (factor num) '(2 3 5 7))))

Adesso scriviamo due funzioni che calcolano i numeri di Humble fino a un dato numero:

Prima funzione (iterativa):

(define (humble1-to num)
  (let (out '(0 1))
    (for (i 2 num)
      (if (humble? i)
          (push i out -1)))
    out))

(humble1-to 50)
;-> (0 1 2 3 4 5 6 7 8 9 10 12 14 15 16 18 20 21
;->  24 25 27 28 30 32 35 36 40 42 45 48 49 50)

Seconda funzione (funzionale):

(define (humble2-to num)
  (let (out '(0 1))
    (extend out (map humble? (sequence 2 num)))
    (filter true? (map (fn(x) (if x $idx)) out))))

(humble2-to 50)
;-> (0 1 2 3 4 5 6 7 8 9 10 12 14 15 16 18 20 21
;->  24 25 27 28 30 32 35 36 40 42 45 48 49 50)

Vediamo la velocità delle due funzioni:

(time (humble1-to 1e5))
;-> 166.582
(time (humble1-to 1e6))
;-> 2039.789
(time (humble1-to 1e7))
;-> 27098.987

(time (humble2-to 1e5))
;-> 180.546
(time (humble2-to 1e6))
;-> 2142.921
(time (humble2-to 1e7))
;-> 28169.361

Ma quanti sono i numeri di Humble fino ad un milione (1e6)?

(length (humble1-to 1e6))
;-> 1274

(last (humble1-to 1e6))
;-> 1000000

Cerchiamo di risolvere il secondo problema:

(define (humble-digits num)
  (let (out (array 10 '(0)))
    (setq (out 1) 1)
    (for (i 2 num)
      (if (humble? i)
          (++ (out (length i)))))
    out))

(humble-digits 1e5)
;-> (0 9 36 95 197 356 1 0 0 0)
(humble-digits 1e6)
;-> (0 9 36 95 197 356 579 1 0 0)
(humble-digits 1e7)
;-> (0 9 36 95 197 356 579 882 1 0)
(time (humble-digits 1e7))
;-> 26933.739

Con questa velocità la funzione non riesce a calcolare la soluzione in tempo ragionevole.

Usiamo un'altro metodo per verificare se un numero è Humble:

(define (humble? num)
  (while (zero? (% num 2)) (setq num (/ num 2)))
  (while (zero? (% num 3)) (setq num (/ num 3)))
  (while (zero? (% num 5)) (setq num (/ num 5)))
  (while (zero? (% num 7)) (setq num (/ num 7)))
  (= num 1))

Vediamo la velocità:

(time (humble1-to 1e7))
;-> 4596.102

(time (print (humble-digits 1e7)))
;-> (0 9 36 95 197 356 579 882 1 0)
;-> 4614.613

(time (print (humble-digits (- 1e9 1))))
(0 9 36 95 197 356 579 882 1272 1768)
;-> 463139.021 Quasi 8 minuti.

Quindi fino a 1 miliardo (1e9) abbiamo:

    9 numeri Humble hanno 1 cifra
   36 numeri Humble hanno 2 cifre
   95 numeri Humble hanno 3 cifre
  197 numeri Humble hanno 4 cifre
  356 numeri Humble hanno 5 cifre
  579 numeri Humble hanno 6 cifre
  882 numeri Humble hanno 7 cifre
 1272 numeri Humble hanno 8 cifre
 1768 numeri Humble hanno 9 cifre

Vediamo un approccio migliore.
Invece di controllare ogni singolo numero possiamo costruire numeri partendo dal primo. I numeri che vogliamo sono fondamentalmente 2^w 3^x 5^y 7^z, per tutti i valori interi di w, x, y, z. L'iterazione non è immediata (come facciamo a sapere quale iterazione viene dopo?). Ma un modo diverso di ragionare è pensare che è ogni numero Humble è 2 volte o 3 volte o 5 volte o 7 volte il numero umile precedente. In questo modo l'iterazione è più semplice.

(define (humble-to num)
  (local (hn w x y z)
    (setq hn (array num '(0)))
    (setf (hn 1) 1)
    (setq w 1 x 1 y 1 z 1)
    (for (i 2 (- num 1))
      (setf (hn i) (min (* 2 (hn w)) (* 3 (hn x)) (* 5 (hn y)) (* 7 (hn z))))
      (if (= (hn i) (* 2 (hn w))) (++ w))
      (if (= (hn i) (* 3 (hn x))) (++ x))
      (if (= (hn i) (* 5 (hn y))) (++ y))
      (if (= (hn i) (* 7 (hn z))) (++ z))
    )
    hn))

(array-list (humble-to 47))
;-> (0 1 2 3 4 5 6 7 8 9 10 12 14 15 16 18 20 21 24 25 27 28 30 32 35 36 40 42 45 48
;->  49 50 54 56 60 63 64 70 72 75 80 81 84 90 96 98 100 105 108 112 120 125 126 128
;->  135 140 144 147 150 160 162 168 175 180 189 192 196 200 210 216 224 225 240 243
;->  245 250 252 256 270 280 288 294 300 315 320 324 336 343 350 360 375 378 384 392
;->  400 405 420 432 441 448)

Questa funzione "humble-to" calcola "num" numeri di Humble, mentre le funzioni "humble1-to" e "humble2-to" calcolano tutti i numeri di Humble minori o uguali a "num".

Verifichiamo che producono lo stesso risultato:

(= (array-list (humble-to 47)) (humble1-to 100))
;-> true

Adesso riscriviamo la funzione per risolvere la seconda questione:

(define (humble-digits num-digits)
  (local (hn i w x y z continua cifre)
    (setq hn (array 100000 '(0)))
    (setq cifre (array (+ num-digits 1) '(0)))
    (setq (cifre 1) 1)
    (setf (hn 1) 1)
    (setq w 1 x 1 y 1 z 1)
    (setq continua true)
    (setq i 2)
    (while continua
      (setf (hn i) (min (* 2 (hn w)) (* 3 (hn x)) (* 5 (hn y)) (* 7 (hn z))))
      (if (= (hn i) (* 2 (hn w))) (++ w))
      (if (= (hn i) (* 3 (hn x))) (++ x))
      (if (= (hn i) (* 5 (hn y))) (++ y))
      (if (= (hn i) (* 7 (hn z))) (++ z))
      ; aggiornamento vettore delle cifre
      (cond ((<= (length (hn i)) num-digits)
             (++ (cifre (length (hn i)))))
            (true (setq continua nil))
      )
      (++ i)
    )
    cifre))

Proviamo:

(humble-digits 16)
;-> (0 9 36 95 197 356 579 882 1272 1768 2380 3113 3984 5002 6187 7545 9081)

(time (humble-digits 16))
;-> 44.35

La soluzione è immediata.


------------------------
PERSISTENZA DI UN NUMERO
------------------------

La persistenza di un numero descrive il numero di operazioni che si devono applicare ad un intero per raggiungere un punto fisso, ad esempio fino a quando successive operazioni non cambieranno più il numero.
Generalmente, questo termine viene riferito alla persistenza additiva o moltiplicativa di un intero, che indica quante volte bisogna sostituire un numero con la somma o con la moltiplicazione delle sue cifre fino a quando si raggiunge un numero con una sola cifra. La cifra finale che si ottiene viene chiamata Multiplicative Digital Root o Additive Digital Root del numero intero iniziale.

Esempio: persistenza moltiplicativa

679 -> (6*7*9)=378 -> (3*7*8)=168 -> (1*6*8)=48 -> (4*2)=32 -> (3*2)=6.
679 -> 378 -> 168 -> 48 -> 32 -> 6.

Cioè, la persistenza di 679 è 6. La persistenza di un numero a una cifra è 0. Esistono numeri con persistenza di 11. Non è noto se ci siano numeri con la persistenza di 12 ma è noto (perchè è stato verificato con un computer nel 2019) che non esistono numeri con persistenza uguale a 12 che hanno meno di 20000 cifre.

Nota: la persistenza additiva o moltiplicativa dipende dalla base di numerazione in cui si sta operando.

Per la persistenza moltiplicativa:

Funzione cha calcola il prodotto delle cifre di un numero:

(define (digit-mul num)
  (let (out 1)
    (while (!= num 0)
      (setq out (* out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(digit-mul 100)
;-> 0

Funzione che calcola la persistenza moltiplicativa:

(define (pers-mul n)
  (let (out 0)
    (while (> n 9)
      (setq n (digit-mul n))
      (++ out)
    )
    out))

(pers-mul 28)
;-> (2)

(map pers-mul (sequence 1 30))
;-> (0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 1)

I numeri più piccoli con persistenza moltiplicativa di 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11,... sono 10, 25, 39, 77, 679, 6788, 68889, 2677889, 26888999, 3778888999, 277777788888899, ...

Verifichiamo:

(map pers-mul '(10 25 39 77 679 6788 68889 2677889 26888999 3778888999 277777788888899))
;-> (1 2 3 4 5 6 7 8 9 10 11)

Per la persistenza additiva:

Funzione cha calcola la somma delle cifre di un numero:

(define (digit-add num)
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

Funzione che calcola la persistenza additiva:

(define (pers-add n)
  (let (out 0)
    (while (> n 9)
      (setq n (digit-add n))
      (++ out)
    )
    out))

(pers-add 28)
;-> 2

(map pers-add (sequence 0 30))
;-> (0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 2 2 1)

I numeri più piccoli con persistenza additiva di 1, 2, 3, 4, ... sono 10, 19, 199, 19999999999999999999999, ...

Verifichiamo:

(map pers-add '(10 19 199 19999999999999999999999))
;-> (1 2 3 4)


--------------
NUMERI TAXICAB
--------------

I numeri Taxicab sono numeri che sono la somma di due cubi in due o più modi, i primi dei quali sono 1729, 4104, 13832, 20683, 32832, 39312, 40033, 46683, 64232, ... (OEIS A001235).

Il nome di questi numeri prende origine da un aneddoto, secondo il quale il matematico inglese Godfrey Harold Hardy, recatosi in ospedale in visita al matematico indiano Srinivasa Ramanujan, fece una battuta circa il fatto che il numero del taxi che aveva preso (1729) appariva essere privo di particolare interesse matematico. Ma Ramanujan rispose immediatamente: "No Hardy, è un numero estremamente interessante: è il minimo intero che si può esprimere come somma di due cubi in due modi diversi!"

1729 = 1 ^ 3 + 12 ^ 3 = 9 ^ 3 + 10 ^ 3

Taxicab:
1729, 4104, 13832, 20683, 32832, 39312, 40033, 46683, 64232, 65728,
110656, 110808, 134379, 149389, 165464, 171288, 195841, 216027, 216125,
262656, 314496, 320264, 327763, 373464, 402597, 439101, 443889, 513000,
513856, 515375, 525824, 558441, 593047, 684019, 704977, ...

Funzione che calcola tutti i numeri taxicab fino ad un numero dato:

(define (taxicab-to num)
  (local (i c out)
  (setq out '())
    (setq i 1)
    (while (< i num)
      (setq c 0)
      ; Verifica per tutte le coppie (j k) se risulta:
      ; i = j^3 + k^3
      (for (j 1 (int (pow i (div 1 3))))
        (for (k (+ j 1) (int (pow i (div 1 3))))
          (if (= (+ (* j j j) (* k k k)) i)
            (++ c)
          )
         )
      )
      (if (>= c 2) (push i out -1))
      (++ i)
    )
    out))

(taxicab-to 100000)
;-> (1729 4104 13832 20683 32832 39312 40033 46683 64232 65728)

Funzione che calcola i primi "quanti" numeri taxicab:

(define (taxicab-count quanti)
  (local (i conta c out)
  (setq out '())
    (setq i 1 conta 0)
    (while (< conta quanti)
      (setq c 0)
      (for (j 1 (int (pow i (div 1 3))))
        (for (k (+ j 1) (int (pow i (div 1 3))))
          (if (= (+ (* j j j) (* k k k)) i)
            (++ c)
          )
         )
      )
      (if (>= c 2)
          (begin (push i out -1) (++ conta))
      )
      (++ i)
    )
    out))

(taxicab-count 6)
;-> (1729 4104 13832 20683 32832 39312)

Entrambe le funzioni hanno una complessità temporale O(n^3) e non permettono di calcolare numeri taxicab troppo grandi.
Vediamo quanto tempo impiega per calcolare tutti i numeri taxicab fino ad un milione:

(time (println (taxicab-to 1e6)))
;-> (1729 4104 13832 20683 32832 39312 40033 46683 64232 65728 110656 110808 134379 149389
;->  165464 171288 195841 216027 216125 262656 314496 320264 327763 373464 402597 439101
;->  443889 513000 513856 515375 525824 558441 593047 684019 704977 805688 842751 885248
;->  886464 920673 955016 984067 994688)
;-> 321249.471 ; 5 minuti e 21 secondi


-----------
CODICE GRAY
-----------

Dato un numero N, generare stringhe di bit da 0 a 2^N-1 in modo tale che le stringhe successive differiscano di un bit.

La soluzione a questo problema è il codice Gray.

Per esempio:

Input: N = 2
Output: 00 01 11 10

Input: N = 3
Output: 000 001 011 010 110 111 101 100

Algoritmo

I codici Gray a n bit possono essere generati dall'elenco dei codici Gray a (n-1) bit utilizzando i seguenti passaggi.

  Poniamo che la lista dei codici Gray a (N-1) bit sia L1.
  Creare un'altra lista L2 che è il contrario di L1.
  Modificare la lista L1 anteponendo "0" in tutti i codici di L1.
  Modificare la lista L2 anteponendo "1" in tutti i codici di L2.
  Concatenare L1 e L2.
  L'elenco concatenato è la lista dei codici Gray a N bit.

Ad esempio, vediamo i passaggi per generare l'elenco dei codici Gray a 3 bit dall'elenco dei codici Gray a 2 bit:

  L1 = (00 01 11 10) (elenco di codici gray a 2 bit)
  L2 = (10 11 01 00) (inverso di L1)
  Anteporre "0" a tutti codici di L1, L1 diventa (000 001 011 010)
  Anteporre "1" a tutti codici di L2, L2 diventa (110 111 101 100)
  Concatenare L1 e L2: otteniamo (000 001 011 010 110 111 101 100)

Per generare il codice Gray a N bit, partiamo dalla lista dei codici Gray a 1 bit (0 1) e costruiamo tutte le liste successive fino a N.

(define (gray num)
  (local (lst1 lst2)
    (cond ((< num 1) '())
          ((= num 1) '("0" "1"))
          (true
          (setq lst1 '("0" "1"))
          (for (i 2 num)
            (setq lst2 (map reverse lst1))
            (setq lst1 (map (fn(x) (string "0" x)) lst1))
            (setq lst2 (map (fn(x) (string "1" x)) lst2))
            (setq lst1(extend lst1 lst2))
          )))))

(gray 3)
;-> ("000" "001" "010" "011" "100" "110" "101" "111")

Il numero di elementi della sequenza Gray(n) vale 2^n e cresce rapidamente con N:

(for (i 1 20) (print (length (gray i)) { }))
;-> 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192
;-> 16384 32768 65536 131072 262144 524288 1048576

(for (i 1 20) (print (pow 2 i) { }))
;-> 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192
;-> 16384 32768 65536 131072 262144 524288 1048576

Il codice Gray viene chiamato anche "reflected binary code" (RBC) oppure "reflected binary" (RB). I primi sedici numeri sono codificati nella tabella seguente:

   Decimale  Binario  Gray  Decimale Gray
       0      0000    0000      0
       1      0001    0001      1
       2      0010    0011      3
       3      0011    0010      2
       4      0100    0110      6
       5      0101    0111      7
       6      0110    0101      5
       7      0111    0100      4
       8      1000    1100     12
       9      1001    1101     13
      10      1010    1111     15
      11      1011    1110     14
      12      1100    1010     10
      13      1101    1011     11
      14      1110    1001      9
      15      1111    1000      8

Per convertire un numero decimale in decimale Gray (OEIS A003188) possiamo usare la seguente funzione:

(define (graycode1 num) (^ num (>> num 1)))

(graycode1 7)
;-> 4
(graycode1 10)
;-> 15

Oppure in maniera equivalente:

(define (graycode2 num) (^ num (floor (/ num 2))))

(graycode2 7)
;-> 4
(graycode2 10)
;-> 15

(= (map graycode1 (sequence 1 10000)) (map graycode2 (sequence 1 10000)))
;-> true


------------
GAME OF LIFE
------------

Il Gioco della Vita (The Game of Life), noto anche semplicemente come Life, è un automa cellulare ideato dal matematico britannico John Horton Conway nel 1970. È un gioco la cui evoluzione è determinata dal suo stato iniziale e non richiede ulteriori input. Si interagisce con il gioco della vita creando una configurazione iniziale e osservando come si evolve passo dopo passo. Il gioco è Turing completo e può simulare qualsiasi macchina di Turing.

Regole del gioco
----------------
L'universo del Gioco della Vita è una griglia ortogonale bidimensionale infinita di celle quadrate, ognuna delle quali si trova in uno dei due possibili stati, vivo o morto (o popolato e non popolato, rispettivamente). Ogni cella interagisce con i suoi otto vicini, che sono le celle adiacenti orizzontalmente, verticalmente o diagonalmente. Ad ogni passaggio nel tempo, si verificano le seguenti transizioni:

  - Qualsiasi cellula viva con meno di due vicini vivi muore, come per sottopopolazione.
  - Qualsiasi cellula viva con due o tre vicini vivi sopravvive alla generazione successiva.
  - Qualsiasi cellula viva con più di tre vicini vivi muore, come per sovrappopolazione.
  - Qualsiasi cellula morta con esattamente tre vicini vivi diventa una cellula viva, come per riproduzione.

Queste regole, che confrontano il comportamento dell'automa con la vita reale, possono essere condensate come segue:

  - Qualsiasi cellula viva con due o tre vicini vivi sopravvive.
  - Qualsiasi cellula morta con tre vicini vivi diventa una cellula viva.
  - Tutte le altre cellule vive muoiono nella generazione successiva. Allo stesso modo, tutte le altre cellule morte rimangono morte.

Il modello iniziale costituisce il seme del sistema. La prima generazione viene creata applicando le regole di cui sopra simultaneamente a ogni cellula del seme: nascite e morti avvengono simultaneamente e il momento discreto in cui ciò accade è talvolta chiamato passo (tick o step). Ogni generazione è una funzione pura della precedente. Le regole continuano ad essere applicate ripetutamente per creare nuove generazioni.

Implementazione
---------------
Il nostro universo è finito e viene rappresentato con una matrice quadrata NxN.

La stato "vivo" vale 1.
Lo stato "morto" vale 0.

In questo modo possiamo sommare i valori dei vicini per applicare le regole:

Per le celle vive (1):
- (somma < 2) o (somma > 3) ==> la cella muore
- (somma = 2) o (somma = 3) ==> la cella continua a vivere

Per le celle morte (0):
- (somma == 3) ==> la cella nasce (vive)

Invece di iterare su una matrice usiamo un vettore, per esempio la seguente matrice 4x4:

0 1 0 1
0 1 0 0
0 0 0 0
1 1 0 1

viene rappresentata con il vettore di 16 elementi:

0 1 0 1 0 1 0 0 0 0 0 0 1 1 0 1

dove gli indici della matrice sono determinati da:

riga    = i % 4
colonna = i / 4

Questo ci permette di calcolare più facilmente i vicini di una cella. Per esempio, nel nostro caso N = 4 e i vicini della cella i-esima sono i seguenti:

sinistra: (i - 1)
destra:   (i + 1)
sopra:    (i - N) = (i - 4)
sotto:    (i + N) = (i + 4)
alto-sx:  (i - (N + 1)) = (i - 5)
alto-dx:  (i - (N - 1)) = (i - 3)
basso-sx: (i + (N - 1)) = (i + 3)
basso-dx: (i + (N + 1)) = (i + 5)

Per evitare il controllo degli indici quando visitiamo/sommiamo le celle vicine contorniamo la matrice con valori 0 che la delimitano (in questo modo la somma non viene modificata dai valori di contorno che valgono 0).

Supponiamo di avere una matrice 10x10 di celle. Poichè la matrice viene contornata la matrice finale ha dimensioni 12x12.

Definiamo il vettore:

(setq dim 12)
(setq board (array (* dim dim) '(0)))

Scriviamo una funzione che stampa il gioco:

(define (print-board board size)
  (for (i 0 (- (length board) 1))
    (cond ((= i 0) (print"╔"))
          ((< i (- size 1)) (print "══"))
          ((= i (- size 1)) (print"╗"))
          ((= i (* size (- size 1))) (print "╚"))
          ((= i (- (length board) 1)) (print"╝"))
          ((or (zero? (% i size)) (zero? (% (+ i 1) size))) (print "║"))
          ((and (> i (* size (- size 1))) (< i (- (* size size) 1))) (print "══"))
          ((zero? (board i)) (print "  "))
          ((= 1 (board i)) (print "██"))
    )
    (if (zero? (% (+ i 1) size))
        (println))
  ))

(print-board board dim)

Scriviamo una funzione che data una generazione calcola la successiva:

(define (next board size)
  (local (temp-board somma)
    ; crea matrice temporanea
    (setq temp-board board)
    ; per ogni cella della matrice di life
    (for (i (+ size 1) (- (length board) (+ size 2)))
      ; se l'indice è fuori dalla matrice (nel contorno)
      (if (or (zero? (% i size)) (zero? (% (+ i 1) size)))
          nil
          (begin
            ; calcolo del numero dei vicini della cella
            (setq somma (+ (board (- i 1))
                           (board (+ i 1))
                           (board (- i size))
                           (board (+ i size))
                           (board (- i (+ size 1)))
                           (board (- i (- size 1)))
                           (board (+ i (+ size 1)))
                           (board (+ i (- size 1)))))
                  ; (> 3) la cella muore
            (cond ((> somma 3) (setf (temp-board i) 0))
                  ; (= 3) la cella vive o nasce
                  ((= somma 3) (setf (temp-board i) 1))
                  ; (= 2 e viva) la cella vive
                  ((and (= somma 2) (= (temp-board i) 1)) (setf (temp-board i) 1))
                  ; altrimenti la cella muore
                  (true (setf (temp-board i) 0))
            )
          )
       )
    )
  temp-board))

Adesso definiamo un "glider" nella matrice iniziale. Un "glider" è una configurazione che si muove indefinitamente nella matrice (a meno che non incroci altre celle vive).

(setf (board 15) 1)
(setf (board 27) 1)
(setf (board 39) 1)
(setf (board 38) 1)
(setf (board 25) 1)

Stampiamo la matrice:

(print-board board dim)
 ╔════════════════════╗
 ║    ██              ║
 ║██  ██              ║
 ║  ████              ║
 ║                    ║
 ║                    ║
 ║                    ║
 ║                    ║
 ║                    ║
 ║                    ║
 ║                    ║
 ╚════════════════════╝

Adesso calcoliamo le generazioni successive con un ciclo:

(while true
  (setq board (next board dim))
  (print-board board dim)
  (print "Premi Invio per la prossima generazione:")
  (read-line))

╔════════════════════╗ ╔════════════════════╗ ╔════════════════════╗
║  ██                ║ ║    ██              ║ ║                    ║
║    ████            ║ ║      ██            ║ ║  ██  ██            ║
║  ████              ║ ║  ██████            ║ ║    ████            ║
║                    ║ ║                    ║ ║    ██              ║
║                    ║ ║                    ║ ║                    ║
║                    ║ ║                    ║ ║                    ║
║                    ║ ║                    ║ ║                    ║
║                    ║ ║                    ║ ║                    ║
║                    ║ ║                    ║ ║                    ║
║                    ║ ║                    ║ ║                    ║
╚════════════════════╝ ╚════════════════════╝ ╚════════════════════╝
╔════════════════════╗ ╔════════════════════╗
║    ██              ║ ║                    ║
║      ██            ║ ║      ██            ║
║  ██████            ║ ║  ██  ██            ║
║                    ║ ║    ████            ║
║                    ║ ║                    ║
║                    ║ ║                    ║
║                    ║ ║                    ║
║                    ║ ║                    ║
║                    ║ ║                    ║
║                    ║ ║                    ║
╚════════════════════╝ ╚════════════════════╝

L'ultima generazione è uguale alla prima tranne il fatto che il "glider" si è spostato in basso a sinistra della matrice.

Esistono tante configurazioni particolari nel gioco della vita.

Adesso scriviamo una funzione che prende una matrice in ingresso (configurazione iniziale) e calcola le generazioni successive.

La matrice ha la seguente struttura:

(setq gen0 '((0 1 0 0 1 0 0)
             (1 1 1 0 1 0 1)
             (1 0 1 0 1 1 0)
             (0 1 0 0 0 0 1)
             (1 1 1 1 1 0 1)
             (0 1 0 1 0 1 1)
             (1 1 0 1 0 1 1)))

Prima dobbiamo scrivere una funzione che contorna la matrice di 0:

(define (pad matrix)
  (local (row col out)
    (setq out '())
    (if (array? matrix) (setq matrix (array-list matrix)))
    (setq row (+ 2 (length matrix)))
    (setq col (+ 2 (length (matrix 0))))
    ; aggiunge una riga iniziale ad out
    (push (dup 0 col true) out -1)
    ; aggiunge le righe centrali ad out
    (dolist (el matrix)
      (setq cur (append '(0) el '(0)))
      (push cur out -1)
    )
    ; aggiunge una riga finale ad out
    (push (dup 0 col true) out -1)
    (array (* col row) (flat out))))

(setq matrice '((0 0 1 0 0)
                (1 0 1 0 1)
                (0 0 1 1 1)
                (0 0 0 0 1)
                (0 1 1 1 1)))

(print-board (pad matrice) 7)
╔══════════╗
║    ██    ║
║██  ██  ██║
║    ██████║
║        ██║
║  ████████║
╚══════════╝

Adesso scriviamo la funzione finale:

(define (life start)
  (local (board dim)
    (setq board (pad start))
    (setq dim (sqrt (length board)))
    (while true
      (setq board (next board dim))
      (print-board board dim)
      (println "Premi Invio per la prossima generazione")
      (println "       Premi Ctrl-C per uscire")
      (read-line))))

Generiamo una generazione iniziale casuale con una matrice 32x32:

(setq gen0 (explode (rand 2 1024) 32))

Facciamo partire la simulazione:

(life gen0)
╔════════════════════════════════════════════════════════════════╗
║  ██████      ██████  ██████████    ██████    ████  ██        ██║
║██          ██        ██          ██                            ║
║██                    ██              ██                        ║
║██  ██      ██                                    ██          ██║
║██        ████████                ██  ██      ████        ██████║
║  ████    ██                      ██  ██  ██                ████║
║██        ████                    ████        ████          ██  ║
║██      ████                    ██                            ██║
║██          ██            ██                                  ██║
║      ████                ██                                    ║
║████                    ████    ██                ██  ██    ██  ║
║      ██                    ██                    ██  ████      ║
║      ██  ██  ██  ████████████  ████      ████    ██  ██  ██  ██║
║██        ██  ████                    ██████      ██  ██  ██  ██║
║██              ██████    ██                      ██  ██      ██║
║  ████    ██    ████                ██  ██            ████████  ║
║      ██  ██                ██  ██    ████  ██        ████    ██║
║  ████      ██    ██        ██                            ██  ██║
║██          ██        ██        ██    ████            ████      ║
║██                              ██                          ████║
║██                                                      ██  ██  ║
║██      ██                          ██          ██      ██  ██  ║
║██    ████  ██        ██            ██  ██          ██    ██    ║
║          ██                            ██  ██  ██        ██    ║
║████        ████      ██          ████  ██  ██  ██  ██        ██║
║██            ██                            ████                ║
║██        ██    ████      ██      ████        ██                ║
║        ████████      ████  ██        ██                        ║
║  ████  ████████        ████  ██                ██          ████║
║      ████    ██████████████                          ██        ║
║      ██        ██        ██                                    ║
║                    ██████    ██  ████      ████  ██  ██  ██    ║
╚════════════════════════════════════════════════════════════════╝
Premi Invio per la prossima generazione
       Premi Ctrl-C per uscire

---------------------

Adesso vediamo un altro metodo per simulare il gioco della vita. Questa volta utilizziamo una matrice n x m anche nel programma (e non un vettore come prima). Comunque i bordi della matrice (prima e ultima riga con prima e ultima colonna) hanno tutti valore 0 perchè rappresentano il limite/contorno della matrice (come nel caso precedente).

Funzione che stampa la matrice:

(define (print-griglia griglia m n)
  (for (i 0 (- m 1))
    (for (j 0 (- n 1))
      (if (zero? (griglia i j))
          (print "·")
          (print "×")
      )
    )
    (println "")
  ))

Funzione che calcola la generazione successiva:

(define (next-gen griglia m n)
  (local (vivi gen)
    (setq gen (array m n '(0)))
    ; per ogni cella della matrice
    (for (r 1 (- m 2))
      (for (c 1 (- n 2))
        (setq vivi 0)
        ; calcola i vicini che sono vivi
        (for (i -1 1)
          (for (j -1 1)
            (setq vivi (+ vivi (griglia (+ r i) (+ c j))))
          )
        )
        ; sottrae il valore della cella corrente
        ; (che non deve rientrare nei vicini)
        (setq vivi (- vivi (griglia r c)))
        ; Applica le regole del gioco della vita:
              ; solitudine: la cella muore
        (cond ((and (= (griglia r c) 1) (< vivi 2))
              (setf (gen r c) 0))
              ; sovrappopolazione: cella muore
              ((and (= (griglia r c) 1) (> vivi 3))
              (setf (gen r c) 0))
              ; nascita: cella nasce/vive
              ((and (= (griglia r c) 0) (= vivi 3))
              (setf (gen r c) 1))
              ; nessun cambiamento: la cella rimane nel suo stato
              (true (setf (gen r c) (griglia r c)))
        )))
     gen))

Funzione finale:

(define (vita griglia m n)
  (local (tempgrid)
    (setq tempgrid griglia)
    (print-griglia tempgrid m n)
    (println "Generazione iniziale")
    (println "Premere Invio per la prossima generazione")
    (println "oppure Ctrl-C per uscire")
    (while true
      (setq tempgrid (next-gen tempgrid m n))
      (print-griglia tempgrid m n)
      (println "Premere Invio per la prossima generazione")
      (println "oppure Ctrl-C per uscire")
      (read-line))))

Proviamo con una matrice 10 x 14:

(setq board '((0 0 0 0 0 0 0 0 0 0 0 0 0 0)
              (0 0 0 1 0 0 0 0 0 0 1 0 0 0)
              (0 1 0 1 0 0 0 0 0 0 1 0 0 0)
              (0 0 1 1 0 0 0 0 0 0 1 0 0 0)
              (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0 0 0 0 0 0 0 0)
              (0 1 1 0 0 0 0 0 0 0 0 0 0 0)
              (0 1 1 0 0 0 0 0 0 0 0 0 0 0)
              (0 0 0 0 0 0 0 0 0 0 0 0 0 0)))

Lanciamo la simulazione:

(vita board 10 14)

··············  ··············  ··············  ··············
···x······x···  ··x···········  ···x······x···  ··············
·x·x······x···  ···xx····xxx··  ····x·····x···  ··x·x····xxx··
··xx······x···  ··xx··········  ··xxx·····x···  ···xx·········
··············  ··············  ··············  ···x··········
··············  ··············  ··············  ··············
··············  ··············  ··············  ··············
·xx···········  ·xx···········  ·xx···········  ·xx···········
·xx···········  ·xx···········  ·xx···········  ·xx···········
··············  ··············  ··············  ··············
Generazione 0   Generazione 1   Generazione 2   Generazione 3

··············
··········x···
····x·····x···
··x·x·····x···
···xx·········
··············
··············
·xx···········
·xx···········
··············
Generazione 4

Nota: il miglior programma (open-source e multi-piattaforma) per "giocare" con Life e altri automi cellulari è "golly" (http://golly.sourceforge.net/).


---------
ACKERMANN
---------

Nella teoria della computabilità la funzione di Ackermann (da Wilhelm Ackermann) è uno degli esempi più semplici e scoperti per primi di una funzione totalmente calcolabile che non è ricorsiva in modo primitivo. Tutte le funzioni ricorsive primitive sono totali e calcolabili, ma la funzione di Ackermann illustra che non tutte le funzioni computabili totali sono ricorsive primitive.
Una versione comune, la funzione Ackermann – Péter a due argomenti, è definita per gli interi non negativi m e n nel modo seguente:

A(0, n) = n + 1
A(m, 0) = A(m-1, 1)
A(m, n) = A(m-1, A(m n-1))

Il suo valore cresce rapidamente, anche per valori piccoli di input.

Versione ricorsiva:

(define (ackermann m n)
  (cond ((zero? m) (+ n 1))
        ((zero? n) (ackermann (- m 1) 1))
        (true (ackermann (- m 1) (ackermann m (- n 1))))))

(for (m 0 3)
  (for (n 0 3)
    (println (format "Ack(%d,%d): %d" m n (ackermann m n)))))
;-> Ack(0,0): 1
;-> Ack(0,1): 2
;-> Ack(0,2): 3
;-> Ack(0,3): 4
;-> Ack(1,0): 2
;-> Ack(1,1): 3
;-> Ack(1,2): 4
;-> Ack(1,3): 5
;-> Ack(2,0): 3
;-> Ack(2,1): 5
;-> Ack(2,2): 7
;-> Ack(2,3): 9
;-> Ack(3,0): 5
;-> Ack(3,1): 13
;-> Ack(3,2): 29
;-> Ack(3,3): 61

Versione migliorata:

(define (pow-i num power)
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))))
    out))

(define (ack m n)
  (case m
    (0 (+ n 1))
    (1 (+ n 2))
    (2 (+ n n 3))
    (3 (- (pow-i 2L (+ 3L n)) 3))
    (true (ack (- m 1) (if (zero? n) 1 (ack m (- n 1)))))))

(for (m 0 3)
  (for (n 0 3)
    (println (format "Ack(%d,%d): %d" m n (ack m n)))))
;-> Ack(0,0): 1
;-> Ack(0,1): 2
;-> Ack(0,2): 3
;-> Ack(0,3): 4
;-> Ack(1,0): 2
;-> Ack(1,1): 3
;-> Ack(1,2): 4
;-> Ack(1,3): 5
;-> Ack(2,0): 3
;-> Ack(2,1): 5
;-> Ack(2,2): 7
;-> Ack(2,3): 9
;-> Ack(3,0): 5
;-> Ack(3,1): 13
;-> Ack(3,2): 29
;-> Ack(3,3): 61

Possiamo anche calcolare:

(ack 4L 1L)
;-> 65533

Il seguente output ha 20221 cifre:

(ack 4L 2L)
;-> 200352993040684646497907235156025575044782547556...
;-> ...337539755822087777506072339445587895905719156733L

Non provate a calcolare:

(ack 4L 3L)

ci vuole troppo tempo.

Il fatto che la funzione di Ackermann sia ricorsiva in modo non primitivo, comporta l'impossibilità di calcolarla utilizzando solo dei cicli (loop). Comunque può essere calcolata anche in modo iterativo, simulando la ricorsione con una pila (stack), inserendo (push) ed estraendo (pop) i valori di input e di output per ogni chiamata di funzione (che è quello che fa il linguaggio nel runtime):

(define (ack2 m n)
  (local (stack lst out q)
    (setq stack (list (list m n 0)))
    (setq out -1)
    (while (> (length stack) 0)
      (setq lst (pop stack))
      (setq m (lst 0))
      (setq n (lst 1))
      (setq q (lst 2))
      (cond ((zero? q)
             (cond ((zero? m) (setq out (+ n 1)))
                   ((zero? n) (push (list (- m 1) 1 0) stack))
                   (true (push (list m n 1) stack)
                         (push (list m (- n 1) 0) stack)))
            )
            ((= q 1) (push (list (- m 1) out 0) stack))
            (true (println "nil"))
      )
    )
    out))

(for (m 0 3)
  (for (n 0 3)
    (println (format "Ack(%d,%d): %d" m n (ack2 m n)))))
;-> Ack(0,0): 1
;-> Ack(0,1): 2
;-> Ack(0,2): 3
;-> Ack(0,3): 4
;-> Ack(1,0): 2
;-> Ack(1,1): 3
;-> Ack(1,2): 4
;-> Ack(1,3): 5
;-> Ack(2,0): 3
;-> Ack(2,1): 5
;-> Ack(2,2): 7
;-> Ack(2,3): 9
;-> Ack(3,0): 5
;-> Ack(3,1): 13
;-> Ack(3,2): 29
;-> Ack(3,3): 61

Nota: (ack2 4 1) non è calcolabile.

La prossima funzione differisce da quella precedente in quanto inserisce nello stack solo il valore di m e non una tripla di valori:

(define (ack3 m n)
  (local (stack lst out q)
    (setq stack (list m))
    (while (> (length stack) 0)
      (setq m (pop stack))
      (cond ((zero? m) (setq n (+ n m 1)))
            ((zero? n)
             (setq n (+ n 1))
             (setq m (- m 1))
             (push m stack))
            (true
             (setq m (- m 1))
             (push m stack)
             (setq m (+ m 1))
             (push m stack)
             (setq n (- n 1)))
      )
    )
    n))

(for (m 0 3)
  (for (n 0 3)
    (println (format "Ack(%d,%d): %d" m n (ack3 m n)))))
;-> Ack(0,0): 1
;-> Ack(0,1): 2
;-> Ack(0,2): 3
;-> Ack(0,3): 4
;-> Ack(1,0): 2
;-> Ack(1,1): 3
;-> Ack(1,2): 4
;-> Ack(1,3): 5
;-> Ack(2,0): 3
;-> Ack(2,1): 5
;-> Ack(2,2): 7
;-> Ack(2,3): 9
;-> Ack(3,0): 5
;-> Ack(3,1): 13
;-> Ack(3,2): 29
;-> Ack(3,3): 61

Nota: (ack3 4 1) non è calcolabile.

Le ultime due funzioni "ack2" e "ack3" sono molto lente perchè la simulazione della ricorsione viene fatta con una coda/lista.


------------------------
SEQUENZA Q DI HOFSTADTER
------------------------

La sequenza di Hofstadter Q è definita come:

Q(1) = Q(2) = 1
Q(n) = Q(n-Q(n-1)) + Q(n-Q(n-2)) per n > 2.

È simile alla sequenza di Fibonacci, ma mentre il termine successivo nella sequenza di Fibonacci è la somma dei due termini precedenti, nella sequenza Q i due termini precedenti dicono di quanto tornare indietro nella sequenza Q per trovare i due numeri da sommare per calcolare il termine successivo della sequenza.

Nella OEIS questa sequenza è la A005185:

(setq A005185 '(1 1 2 3 3 4 5 5 6 6 6 8 8 8 10 9 10 11 11
                12 12 12 12 16 14 14 16 16 16 16 20 17 17 20
                21 19 20 22 21 22 23 23 24 24 24 24 24 32 24
                25 30 28 26 30 30 28 32 30 32 32 32 32 40 33
                31 38 35 33 39 40 37 38 40 39))

Definiamo direttamente la funzione utilizzando la ricorsione:

(define (qh num)
  (cond ((= num 1) 1)
        ((= num 2) 1)
        (true (+ (qh (- num (qh (- num 1)))) (qh (- num (qh (- num 2))))))))

(map qh (sequence 1 10))
;-> (1 1 2 3 3 4 5 5 6 6)

(qh 30)
;-> 16
(qh 34)
;-> 20
(qh 40)
;-> 22

La funzione è molto lenta:

(time (qh 34))
;-> 7950.982
(time (qh 40))
;-> 142933.365

Possiamo provare ad utilizzare la tecnica memoization:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(memoize qh-m
  (lambda (num)
  (cond ((= num 1) 1)
        ((= num 2) 1)
        (true (+ (qh-m (- num (qh-m (- num 1)))) (qh-m (- num (qh-m (- num 2)))))))))

(map qh-m (sequence 1 10))
;-> (1 1 2 3 3 4 5 5 6 6)

(qh-m 30)
;-> 16
(qh-m 34)
;-> 20
(qh-m 40)
;-> 22
(qh-m 100)
;-> 56

In questo caso la funzione è molto più veloce:

(time (qh-m 40))
;-> 0

ma abbiamo il problema con i numeri più grandi perchè la ricorsione è molto profonda e provoca l'errore di stack overflow:

(qh-m 1000)
;-> ERR: call or result stack overflow : cond

Allora utilizziamo un vettore per memorizzare tutti i valori della sequenza mentre li calcoliamo. In questo modo calcoliamo tutti i valori q(i) con i = 1,..,n:

(define (hof num)
  (let (qq (array (+ num 1) '(0)))
    (setf (qq 1) 1)
    (setf (qq 2) 1)
    (for (i 3 num)
      (setf (qq i) (+ (qq (- i (qq (- i 1)))) (qq (- i (qq (- i 2))))))
    )
    qq))

(hof 10)
;-> (0 1 1 2 3 3 4 5 5 6 6)

(last (hof 1000))
;-> 502

(length (hof 1000))
;-> 1001

Confrontiamo il risultato con la sequenza OEIS:

(length A005185)
;-> 74

(= A005185 (slice (array-list (hof 74)) 1 74))
;-> true

Vediamo quanto è veloce quest'ultima funzione:

(time (println (last (hof 1e6))))
;-> 5124632
;-> 248.364

Vediamo quanto tempo occorre per calcolare la sequenza dei primi 100 milioni di numeri:

(time (println (last (hof 100000000))))
;-> 50166508
;-> 33357.835
    34 secondi

La funzione è molto veloce, ma il vettore che definiamo utilizza tanta memoria.


------------------------------------
SEQUENZA FIGURA-FIGURA DI HOFSTADTER
------------------------------------

La sequenza Figura-Figura (R e S) di Hofstadter sono una coppia di sequenze intere complementari definite come segue:

R(1) = 1
S(1) = 2
R(n) = R(n-1) + S(n-1), per n>1

con la sequenza S(n) definita come una serie strettamente crescente di interi positivi non presenti in R(n). I primi termini di queste sequenze sono:

R: 1, 3, 7, 12, 18, 26, 35, 45, 56, 69, 83, 98, 114, 131, 150, 170, 191, 213, 236, 260, ... (A005228 OEIS)
S: 2, 4, 5, 6, 8, 9, 10, 11, 13, 14, 15, 16, 17, 19, 20, 21, 22, 23, 24, 25, ... (A030124 OEIS)

(define (ffh num)
  (local (r s)
    (setq r '(0 1))
    (setq s '(0 2))
    (for (i 2 num)
      ;(println i)
      (ffr i)
      (ffs i)
    )
    (list r s)))

(define (ffr n)
  (push (+ (r (- n 1)) (s (- n 1))) r -1))

(define (ffs n)
  (local (idx stop)
    (setq stop nil)
    (setq idx (+ (s (- n 1)) 1))
    (do-until stop
      (cond ((ref idx r)
             (++ idx))
            (true
             (push idx s -1)
             (setq stop true))
      ))))

(ffh 20)
;-> ((0 1 3 7 12 18 26 35 45 56 69 83 98 114 131 150 170 191 213 236 260)
;->  (0 2 4 5 6 8 9 10 11 13 14 15 16 17 19 20 21 22 23 24 25))

Vediamo i tempi di esecuzione:

(time (ffh 10000))
;-> 1481.927
(time (ffh 100000))
;-> 211800.307

Proviamo ad utilizzare una hash-map per inserire e controllare i valori di r (invece di controllarli sulla lista dei valori di r):

(define (ffh num)
  (local (r s)
    (new Tree 'rhash)
    (setq r '(0 1))
    (setq s '(0 2))
    (rhash "1" 1)
    (for (i 2 num)
      ;(println i)
      (ffr i)
      (ffs i)
    )
    (delete 'rhash)
    (list r s)))

(define (ffr n)
  (local (val)
    (setq val (+ (r (- n 1)) (s (- n 1))))
    (push val r -1)
    (rhash (string val) val)))

(define (ffs n)
  (local (idx stop)
    (setq stop nil)
    (setq idx (+ (s (- n 1)) 1))
    (do-until stop
      (cond ((nil? (rhash idx))
             (push idx s -1)
             (setq stop true))
            (true
             (++ idx))
      ))))

(ffh 20)
;-> ((0 1 3 7 12 18 26 35 45 56 69 83 98 114 131 150 170 191 213 236 260)
;->  (0 2 4 5 6 8 9 10 11 13 14 15 16 17 19 20 21 22 23 24 25))

(time (ffh 10000))
;-> 1211.927
(time (ffh 100000))
;-> 199469.585

Abbiamo ottenuto solo un piccolo miglioramento di velocità.


------------------------
SEQUENZA G DI HOFSTADTER
------------------------

La sequenza G di Hofstadter è definita come segue:

G(0) = 0
G(n) = n - G(G(n-1)), per n>0

I primi termini di questa sequenza sono:

0, 1, 1, 2, 3, 3, 4, 4, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 12, ... (A005206 OEIS)

Per calcolare i valori utilizziamo un vettore che viene riempito sequenzialmente (non usiamo la ricorsione perchè è più lenta:

(define (gh num)
  (let (g (array (+ num 1) '(0)))
    (setf (g 0) 0)
    (setf (g 1) 1)
    (for (i 2 num)
      (setq (g i) (- i (g (g (- i 1)))))
    )
    g))

(gh 20)
;-> (0 1 1 2 3 3 4 4 5 6 6 7 8 8 9 9 10 11 11 12 12)

Vediamo quanto tempo occorre per calcolare i primi 100 milioni di termini:

(time (println (last (gh 100000000))))
;-> 61803399
;-> 12495.63
    12.5 secondi

Nota: per una rappresentazione visiva di questa sequenza vedi "A combinatorial interpretation of hofstadter’s G-sequence" di Mustazee Rahman.

----------------------------------------------
SEQUENZA FEMMINA (F) MASCHIO (M) DI HOFSTADTER
----------------------------------------------

Le sequenze Hofstadter Female (F) e Male (M) sono definite come segue:

F(0) = 1
M(0) = 0
F(n) = n - M(F(n-1)), per n>0
M(n) = n - F(M(n-1)), per n>0

I primi termini di questa sequenze sono:

F: 1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13, ... (A005378 OEIS)
M: 0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12, ... (A005379 OEIS)

(define (fmh num)
  (local (f m)
    (setq f (array (+ num 1) '(0)))
    (setq m (array (+ num 1) '(0)))
    (setf (f 0) 1)
    (setf (m 0) 0)
    (for (i 1 num)
      (setq (f i) (- i (m (f (- i 1)))))
      (setq (m i) (- i (f (m (- i 1)))))
    )
    (list f m)))

(fmh 20)
;-> ((1 1 2 2 3 3 4 5 5 6 6 7 8 8 9 9 10 11 11 12 13)
;->  (0 0 1 2 2 3 4 4 5 6 6 7 7 8 9 9 10 11 11 12 12))

Vediamo quanto tempo occorre per calcolare i primi 100 milioni di termini:

(time (fmh 100000000))
;-> 26554.548
    26.5 secondi


-----------
CONVEX HULL
-----------

Dato un insieme di N punti, il convex-hull è definito come il poligono convesso più piccolo che racchiude tutti i punti dell'insieme. Questo poligono è anche il poligono con il più piccolo perimetro contenente tutti i punti.

      |
    6 |                       O
      |
    5 |       O                       O
      |
    4 |       O       O
      |
    3 |   O                   O
      |
    2 |           O
      |
    1 |   O                   O
      |
    0 ---------------------------------------
      0   1   2   3   4   5   6   7   8   9

    Punti = ((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 6) (3 2) (2 4)

Ecco una lista di algoritmi che risolvono il problema del convex-hull:

Algoritmo                  Tempo          Autore
----------------------------------------------------------------------
Brute Force                O(n^4)         [Anon, the dark ages]
Gift Wrapping              O(n*h)         [Chand & Kapur, 1970]
Graham Scan                O(n*log(n))    [Graham, 1972]
Jarvis March               O(n*h)         [Jarvis, 1973]
QuickHull                  O(n*h)         [Eddy, 1977], [Bykat, 1978]
Divide-and-Conquer         O(n*log(n))    [Preparata & Hong, 1977]
Monotone Chain             O(n*log(n))    [Andrew, 1979]
Incremental                O(n*log(n))    [Kallay, 1984]
Marriage-before-Conquest   O(n*log(h))    [Kirkpatrick & Seidel, 1986]

Per risolvere questo problema useremo l'algoritmo di Andrew (monotone chain algorithm, 1979) che ha complessità temporale O(n*log(n)) in generale e O(n) se i punti sono già ordinati lungo l'asse x.
Questo algoritmo si basa sul test di orientamento tra 3 punti (vedi sotto) e può evitare errori di arrotondamento.
I punti superiori del convex-hull sono elaborati da sinistra a destra, nell'ordine delle loro coordinate x. La lista "alto" contiene il convex-hull dei punti già processati. Quando si elabora un punto p la prima cosa è aggiungerlo a "alto". Quindi, fintanto che il penultimo punto di "alto" rende la sequenza non convessa, viene rimosso dall'elenco.
Allo stesso modo si ottiene la parte inferiore del convex-hull. Il risultato è ottenuto concatenando le due liste e invertendo la lista "alto" per ottenere i punti dello scafo convesso nell'ordine "normale" (cioè quella antiorario).
Si noti che il primo e l'ultimo elemento delle liste sono uguali e quindi vanno rimossi.

Test di orientamento
--------------------
Dati tre punti p1, p2 e p3, vogliamo sapere se sono allineati, oppure, muovendosi da p1 -> p2 -> p3, se sono in senso orario (destra) o in senso anti-orario (sinistra).

Dobbiamo controllare il segno della componente z del prodotto vettoriale:
  ____   ____
  p1p2 × p2p3

Se è positivo, allora sono in senso antiorario (sinistra),
Se è negativo, allora sono in senso orario (destra),
Se è zero, allora i punti sono allineati.

(define (antiorario? p1 p2 p3)
  (> (sub (mul (sub (p1 0) (p3 0)) (sub (p2 1) (p3 1)))
          (mul (sub (p1 1) (p3 1)) (sub (p2 0) (p3 0)))) 0))

Quando i punti hanno coordinate non intere bisogna eseguire i calcoli che prevedono l'uguaglianza con una piccola tolleranza (esempio 10^-7), invece di utilizzare zero, per proteggersi da eventuali errori di arrotondamento.

(define (convex-hull lst)
  (local (alto basso)
    (sort lst)
    (setq alto '())
    (setq basso '())
    (dolist (p lst)
      ;(if (>= (length alto) 2)
      ;  (begin
      ;  (println p { } (alto -1) { } (alto -2) (antiorario? p (alto -1) (alto -2)))
      ;  (read-line)
      ;))
      (while (and (>= (length alto) 2) (not (antiorario? p (alto -1) (alto -2))))
        (setq alto (chop alto))
      )
      (push p alto -1)
      (while (and (>= (length basso) 2) (not (antiorario? (basso -2) (basso -1) p)))
        (setq basso (chop basso))
      )
      (push p basso -1)
    )
    (append (chop basso) (chop (reverse alto)))))

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 6) (3 2) (2 4)))

(convex-hull lst)
;-> ((1 1) (6 1) (8 5) (6 6) (2 5) (1 3))

Nel diagramma seguente i punti del convex-hull sono contrassegnsti con X.

      |
    6 |                       X
      |
    5 |       X                       X
      |
    4 |       O       O
      |
    3 |   X                   O
      |
    2 |           O
      |
    1 |   X                   X
      |
    0 ---------------------------------------
      0   1   2   3   4   5   6   7   8   9

Proviamo con l'esempio riportato su Rosetta Code:

(setq rc '((16 3) (12 17) (0 6) (-4 -6) (16 6) (16 -7) (16 -3)
           (17 -4) (5 19) (19 -8) (3 16) (12 13) (3 -4) (17 5)
           (-3 15) (-3 -9) (0 11) (-9 -3) (-4 -2) (12 10)))

(convex-hull rc)
;-> ((-9 -3) (-3 -9) (19 -8) (17 5) (12 17) (5 19) (-3 15))

Un esempio più complesso di convex-hull calcolato con questa funzione è visibile nell'immagine "convex-hull.png" contenuta nella cartella "data".


-------------------
SEQUENZA THUE-MORSE
-------------------

La sequenza Thue-Morse, o Prouhet-Thue-Morse, è la sequenza binaria (una sequenza infinita di 0 e 1) ottenuta partendo da 0 e aggiungendo successivamente il complemento booleano della sequenza ottenuta fino a quel momento. I primi passi di questa procedura producono le stringhe 0 poi 01, 0110, 01101001, 0110100110010110 e così via. La sequenza completa inizia così: 01101001100101101001011001101001.... (OEIS A010060).

(define (complemento str)
  (let (compl "")
    (for (i 0 (- (length str) 1))
      ; se carattere = "0", aggiunge 1
      (if (= (str i) "0")
          (extend compl "1")
          ; else
          ; se carattere = "1", aggiunge 0
          (extend compl "0")
      )
    )
    compl))

(define (thue-morse num)
  (let (seq "0")
    (for (i 1 (- num 1))
      (extend seq (complemento seq))
    )
    seq))

(thue-morse 6)
;-> "01101001100101101001011001101001"


--------------
NUMERI DI BELL
--------------

I numeri Bell o esponenziali rappresentano il numero di modi diversi per partizionare un insieme che ha esattamente n elementi. Ogni elemento della sequenza B(n) è il numero di partizioni di un insieme di dimensione n dove l'ordine degli elementi e l'ordine delle partizioni non sono significativi. Per esempio, (a b) è lo stesso di (b a) e (a) (b) è lo stesso di (b) (a).

I primi numeri di Bell hanno i seguenti valori (OEIS A000110):

B(0) = 1 C'è solo un modo per partizionare un insieme con zero elementi ()
B(1) = 1 C'è solo un modo per partizionare un insieme con un elemento (a)
B(2) = 2 Due elementi possono essere partizionati in due modi (a) (b), (a b)
B(3) = 5 Tre elementi possono essere partizionati in cinque modi (a) (b) (c), (a b) (c), (a) (b c), (a c) (b), (a b c)
ecc.

1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147, 115975, 678570, 4213597, 27644437, 190899322, 1382958545, 10480142147, 82864869804, 682076806159, 5832742205057, 51724158235372, 474869816156751, 4506715738447323, 44152005855084346, 445958869294805289, 4638590332229999353, 49631246523618756274

I numeri di Bell possono essere calcolati creando il cosiddetto triangolo di Bell, chiamato anche matrice di Aitken o triangolo di Peirce:

1. Iniziare con il numero uno. Mettere questo numero in una riga da solo x(0,1) = 1.
2 .Iniziare una nuova riga con l'elemento più a destra della riga precedente come numero più a sinistra x(i,1)) = x(i-1,r) dove r è l'ultimo elemento della (i-1)-esima riga.
3. Determinare i numeri che non si trovano nella colonna di sinistra prendendo la somma del numero a sinistra e il numero sopra il numero a sinistra, cioè il numero diagonalmente in alto a sinistra rispetto al numero che stiamo calcolando x(i,j) =  x(i,j-1) + x(i-1,j-1).
4. Ripetere il ​​passaggio 3 finché non c'è una nuova riga con un numero in più rispetto alla riga precedente (Eseguire il passaggio 3 fino a j = r + 1).
5. Il numero sul lato sinistro di una data riga è il numero di Bell per quella riga B(i) = x(i,1).

L'implementazione che segue si basa su questo algoritmo, ma produce solo i numeri di Bell:

(define (bell limite)
  (local (arr num idx out)
    (setq arr (array limite '(0L)))
    (setq num 0L)
    (setf (arr 0) 1L)
    (push (arr 0) out -1)
    (while (< num limite)
      (setf (arr num) (arr 0))
      (setq idx num)
      (while (>= idx 1)
        (setf (arr (- idx 1)) (+ (arr (- idx 1)) (arr idx)))
        (-- idx)
      )
      (++ num)
      ;(println arr)
      ;(read-line)
      (push (arr 0) out -1)
    )
    out))

(bell 25)
;-> (1L 1L 2L 5L 15L 52L 203L 877L 4140L 21147L 115975L 678570L
;->  4213597L 27644437L 190899322L 1382958545L 10480142147L
;->  82864869804L 682076806159L 5832742205057L 51724158235372L
;->  474869816156751L 4506715738447323L 44152005855084346L
;->  445958869294805289L 4638590332229999353L)

Vediamo il 50-esimo numero di Bell:

((bell 50) 49)
;-> 10726137154573358400342215518590002633917247281L

Vediamo i tempi di esecuzione:

(time (bell 100))
;-> 3.996
(time (bell 1000))
;-> 496.267
(time (bell 2000))
;-> 2708.044
(time (bell 4000))
;-> 17817.96
(time (bell 8000))
;-> 131118.729


-----------------------
NUMERI AUTO-DESCRITTIVI
-----------------------

Un numero intero si dice "auto-descrittivo" se ha la proprietà che, quando le posizioni delle cifre sono etichettate da 0 a N-1, la cifra in ciascuna posizione è uguale al numero di volte in cui quella cifra appare nel numero.

Ad esempio, 2020 è un numero autodescrittivo a quattro cifre:

   la posizione 0 ha valore 2 e ci sono due 0 nel numero;
   la posizione 1 ha valore 0 e non ci sono 1 nel numero;
   la posizione 2 ha valore 2 e ci sono due 2;
   la posizione 3 ha valore 0 e ci sono zero 3.

I numeri auto-descrittivi fino a 100 milioni sono: 1210, 2020, 21200, 3211000, 42101000.

(define (int-lst num)
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (autodesc? num)
(catch
  (local (digit num-lst)
    (setq num-lst (int-lst num))
    ; conta le cifre di num-lst
    (setq digit (count '(0 1 2 3 4 5 6 7 8 9) num-lst))
    ; applica la regola ad ogni cifra della lista:
    ; la cifra in ciascuna posizione è uguale al numero di volte
    ; in cui quella cifra appare nel numero?
    (dolist (el num-lst)
      (if (!= (digit $idx) el) (throw nil))
    )
    true)))

(autodesc? 2020)
;-> true

(autodesc? 1210)
;-> true

Definiamo una funzione che calcola i numeri descrittivi fino ad un dato numero:

(define (autodesc num)
  (for (i 1 num)
    (if (autodesc? i) (print i {, }))))

Vediamo i tempi di calcolo:

(time (autodesc 1e8))
;-> 1210, 2020, 21200, 3211000, 42101000,
;-> 378928.914 ;6 minuti e 20 secondi (circa)


---------
JORT SORT
---------

Nota: JortSort è considerato un'opera di satira. Raggiunge il suo risultato in modo intenzionalmente indiretto. La soluzione deve essere nello spirito del jortsort originale piuttosto che cercare di scrivere la versione più efficiente.

"JortSort è un uno strumento di ordinamento che lascia all'utente l'onere di svolgere il lavoro e garantisce efficienza perché non è necessario ordinare mai più." Jenn "Moneydollars" Schiffer al JSConf.

JortSort è una funzione che accetta come argomento una singola lista di oggetti comparabili.
Quindi ordina la lista in ordine crescente e confronta la lista ordinato con la lista originariamente fornita.
Se le liste corrispondono (ovvero la lista originale era già ordinata), la funzione restituisce true.
Se le liste non corrispondono (ovvero la lista originale non è stato ordinata), la funzione restituisce false (nil).

(define (jort-sort lst)
  (if (= lst (sort (copy lst)))
      true
      nil))

(jort-sort '(1 2 3 5 2))
;-> nil
(jort-sort '(1 2 3 5 11))
;-> true


-----------------------------
FUNZIONI MUTUAMENTE RICORSIVE
-----------------------------

Scrivere due funzioni mutuamente (reciprocamente) ricorsive che calcolano gli elementi delle sequenze di Hofstadter "Female" e "Male" definite come:

F(0) = 1
M(0) = 0
F(n) = n - M(F(n-1)), per n>0
M(n) = n - F(M(n-1)), per n>0

I primi termini di questa sequenze sono:

F: 1, 1, 2, 2, 3, 3, 4, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 11, 11, 12, 13, ... (A005378 OEIS)
M: 0, 0, 1, 2, 2, 3, 4, 4, 5, 6, 6, 7, 7, 8, 9, 9, 10, 11, 11, 12, 12, ... (A005379 OEIS)

(define (female num)
  (if (= num 0) 1
      (- num (male (female (- num 1))))))

(define (male num)
  (if (= num 0) 0
      (- num (female (male (- num 1))))))

(for (i 0 20) (print (female i) { }))
;-> 1 1 2 2 3 3 4 5 5 6 6 7 8 8 9 9 10 11 11 12 13
(for (i 0 20) (print (male i) { }))
;-> 0 0 1 2 2 3 4 4 5 6 6 7 7 8 9 9 10 11 11 12 12

Un altro esempio di coppia di funzioni mutuamente ricorsive è il seguente:

(define (pari? num)
  (cond ((zero? num) true)
        (true (dispari? (- (abs num) 1))))))

(define (dispari? num)
  (cond ((zero? num) nil)
        (true (pari? (- (abs num) 1)))))

(pari? 237)
;-> nil
(pari? 200)
;-> true
(pari? -100)
;-> true
(pari? -77)
;-> nil

(dispari? 237)
;-> true
(dispari? 200)
;-> nil
(dispari? -100)
;-> nil
(dispari? -77)
;-> true


-----------------------
NUMERI IN BASE NEGATIVA
-----------------------

I numeri in base negativa sono un modo alternativo per codificare i numeri senza la necessità del segno meno "-". È possibile utilizzare varie basi negative, tra cui nega-decimale (base -10), nega-binaria (-2) e nega-ternaria (-3).

Una base negativa può essere utilizzata per costruire un sistema numerico posizionale non standard. Come altri sistemi a valore posizionale, ogni posizione contiene multipli della potenza appropriata della base del sistema, solo che in questo caso la base è negativa, cioè la base b è uguale a −r per qualche numero naturale r (r ≥ 2).

I sistemi a base negativa possono contenere tutti gli stessi numeri dei sistemi di valori di posizione standard, ma sia i numeri positivi che quelli negativi sono rappresentati senza l'uso di un segno meno (o, nella rappresentazione del computer, senza il bit di segno). Questo vantaggio è controbilanciato da una maggiore complessità delle operazioni aritmetiche. La necessità di memorizzare le informazioni normalmente contenute da un segno negativo si traduce spesso in un numero in base negativa più lungo di una cifra rispetto al suo equivalente in base positiva.

Esempio
Rappresentazione del numero 12243 nel sistema negadecimale (b = −10):

Multipli
  (−10)^4 = 10000  (−10)^3 = −1000  (−10)^2 = 100  (−10)^1 = −10  (−10)^0 = 1
          1                2                2              4              3

Poiché 10000 + (−2000) + 200 + (−40) + 3 = 8163, la rappresentazione 12243(−10) in notazione negadecimale è equivalente a 8163(10) in notazione decimale, mentre −8163(10) in decimale sarebbe scritto 9977(−10) in negadecimale.

Scriviamo due funzioni che codificano/decodificano un numero in base negativa:

Funzione che converte un numero in base 10 nel numero (stringa) corrispondente in una certa base negativa:

(define (to-neg-base num bn)
  (local (digits nn val out)
    (setq digits "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    (cond ((or (< bn -62) (> bn -1)) nil)
          ((zero? num) "0")
          (true
           (setq out "")
           (setq nn (bigint num))
           (until (zero? nn 0)
             (setq val (% nn bn))
             (setq nn (/ nn bn))
             (if (< val 0)
                 (setq nn (+ nn 1) val (- val bn))
             )
             (push (digits val) out)
           ))
     )
     out))

Facciamo alcune prove:

(to-neg-base 8163 -10)
;-> "12243"
(to-neg-base -8163 -10)
;-> "9977"

(define (from-neg-base ns b)
  (local (digits nn val out)
    (setq digits "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    (cond ((or (< b -62) (> b -1)) nil)
          ((zero? ns) "0")
          (true
           (setq out 0)
           (setq bb 1L)
           (for (i (- (length ns) 1) 0 -1)
             (setq out (+ out (* bb (find (ns i) digits))))
             (setq bb (* bb b))
           ))
    )
    out))

Facciamo alcune prove:

(from-neg-base "12243" -10)
;-> 8163
(from-neg-base "9977" -10)
;-> -8163
(from-neg-base "11110" -2)
;-> 10

(from-neg-base (to-neg-base 1234567890 -10) -10)
;-> 1234567890
(to-neg-base (from-neg-base "1234567890" -10) -10)
;-> "1234567890"

(from-neg-base "newLISP" -62)
;-> 2747418320417
(to-neg-base 2747418320417 -62)
;-> "newLISP"

(from-neg-base "cameyo" -62)
(to-neg-base -34292389174 -62)
;-> "cameyo"


-----------
QUATERNIONI
-----------

I quaternioni sono entità matematiche introdotte da William Hamilton nel 1843 come estensioni dei numeri complessi. Un quaternione è un oggetto formale del tipo:

  a + bi + cj + dk

dove a,b,c,d sono numeri reali e i,j,k sono dei simboli che si comportano in modo simile all'unità immaginaria dei numeri complessi.

Somma e prodotto di due quaternioni sono definiti tenendo conto delle relazioni:

  i∙i = j∙j = k∙k = i∙j∙k = -1 oppure ii = jj = kk = ijk = -1.

che implicano:

  i*j = k
  j*k = i
  k*i = j
  j*i = -k
  k*j = -i
  i*k = -j

La tabella seguente riassume i risultati delle moltiplicazioni fra due elementi:

  +---+---+---+---+---+
  | * | 1 | i | j | k |
  +---+---+---+---+---+
  | 1 | 1 | i | j | k |
  +---+---+---+---+---+
  | i | i |-1 | k |-j |
  +---+---+---+---+---+
  | j | j |-k |-1 | i |
  +---+---+---+---+---+
  | k | k | j |-i |-1 |
  +---+---+---+---+---+

L'ordine di moltiplicazione è importante, infatti ,in generale, per due quaternioni q1 e q2:

  q1q2 ≠ q2q1.

Scrivere le funzioni per le seguenti operazioni di base con i quaternioni:

  q = a + bi + cj + dk

Norma di un quaternione q

  (norma q) = sqrt(a^2 + b^2 + c^2 + d^2)

Negativo di un quaternione q

  (negativo q) = (-a, -b, -c, -d)

Coniugato di un quaternione q

  (coniugato q) = (a, -b, -c, -d)

Addizione numero reale r e quaternione q

  r + q = q + r = (a + r, b, c, d)

Addizione di due quaternioni q1 e q2

  q1 + q2 = (a1+a2, b1+b2, c1+c2, d1+d2)

Moltiplicazione numero reale r e quaternione q

  q*r = r*q = (ar, br, cr, dr)

Moltiplicazione di due quaternioni q1 e q2

  (a1a2 − b1b2 − c1c2 − d1d2,
  a1b2 + b1a2 + c1d2 − d1c2,
  a1c2 − b1d2 + c1a2 + d1b2,
  a1d2 + b1c2 − c1b2 + d1a2)

Utilizziamo una lista per rappresentare un quaternione:

  q = (a + bi + cj + dk)  ==> (a b c d)

(setq q  '(1 2 3 4))
(setq q1 '(2 3 4 5))
(setq q2 '(3 4 5 6))
(setq r 7)

; norma di un quaternione
(define (norm-quat q)
  (let (out 0)
    (for (i 0 3)
      (setq out (add out (mul (q i) (q i)))))
    (sqrt out)))

(setq q '(1 2 3 4))
(norm-quat q)
;-> 5.477225575051661

; Negativo di un quaternione
(define (neg-quat q)
  (for (i 0 3)
    (setf (q i) (mul -1 (q i))))
  q)

(neg-quat q)
;-> (-1 -2 -3 -4)

; Coniugato di un quaternione
(define (coniug-quat q)
  (for (i 1 3)
    (setf (q i) (mul -1 (q i))))
  q)

(coniug-quat q)
;-> (1 -2 -3 -4)

; Addizione/sottrazione numero reale e quaternione
(define (add-real-quat r q)
  (setf (q 0) (add (q 0) r))
  q)

(add-real-quat r q)
;-> (8 2 3 4)

; Addizione/sottrazione tra due quaternioni
(define (add-quat q1 q2)
  (for (i 0 3)
    (setf (q1 i) (add (q1 i) (q2 i))))
  q1)

(add-quat q1 q2)
;-> (5 7 9 11)

; Moltiplicazione numero reale e quaternione
(define (mul-real-quat r q)
  (for (i 0 3)
    (setf (q i) (mul r (q i))))
  q)

(mul-real-quat r q)
;-> (7 14 21 28)

; Moltiplicazione tra due quaternioni
(define (mul-quat q1 q2)
  (let (out '(0 0 0 0))
    (setf (out 0) (sub (mul (q1 0) (q2 0))    (mul (q1 1) (q2 1))     (mul (q1 2) (q2 2))     (mul (q1 3) (q2 3))))
    (setf (out 1) (add (mul (q1 0) (q2 1))    (mul (q1 1) (q2 0))     (mul (q1 2) (q2 3))  (- (mul (q1 3) (q2 2)))))
    (setf (out 2) (add (mul (q1 0) (q2 2)) (- (mul (q1 1) (q2 3)))    (mul (q1 2) (q2 0))     (mul (q1 3) (q2 1))))
    (setf (out 3) (add (mul (q1 0) (q2 3))    (mul (q1 1) (q2 2))  (- (mul (q1 2) (q2 1)))    (mul (q1 3) (q2 0))))
    out))

(mul-quat q1 q2)
;-> (-56 16 24 26)
(mul-quat q2 q1)
;-> (-56 18 20 28)

Potete trovare una libreria sui quaternioni scritta da Heiko Schroeter al seguente indirizzo web:

  http://www.newlisp.org/modules/various/quatlib.lsp.html

Nota: i quaternioni vengono utilizzati nella modellizzazione delle rotazioni dello spazio: per questo motivo vengono impiegati nella fisica teorica (teoria della relatività e meccanica quantistica) e in settori applicativi, come la computer grafica 3D e la robotica.

Nota: l'uso dei quaternioni per ruotare un oggetto 3D lungo i tre assi x,y,z elimina il problema del "Gimbal lock", che può verificarsi se si utilizzano gli angoli di Eulero per la rotazione dell'oggetto.

Il "Gimbal lock" (blocco del giunto cardanico) è il fenomeno di due assi di rotazione di un oggetto che puntano nella stessa direzione. In poche parole, significa che il tuo oggetto non ruoterà come pensi che dovrebbe ruotare. Questo è un problema frustrante che ogni artista di computer grafica dovrà affrontare durante la sua carriera (e accade sempre nel momento peggiore possibile). Il Gimbal lock si verifica quando si ruota un oggetto con una matrice di rotazione con angoli di Eulero. È una limitazione generale di questo tipo di matrice di rotazione.

Qualsiasi sistema che utilizza gli angoli di Eulero (Maya, Max, Lightwave, Softimage) ha problemi di Gimbal lock. La ragione di ciò è che gli angoli di Eularo valutano ogni asse indipendentemente e in un ordine prestabilito. Ad esempio, l'ordine è generalmente X, Y, Z (ma vale anche per altri ordini), il che significa che prima l'oggetto viaggia lungo l'asse X. Quando l'operazione è completa, si sposta lungo l'asse Y e infine l'asse Z. Il problema del Gimbal lock si verifica quando si ruota l'oggetto lungo l'asse Y, diciamo di 90 gradi. Poiché la componente X è già stata valutata, non viene considerata con gli altri due assi. QUello che accade è che gli assi X e Z punto lungo lo stesso asse.

Il programma ZBrush (Pixologic) utilizza internamente sia gli angoli di Eulero che i quaternioni, ma il linguaggio di scripting mette a disposizione solo gli angoli di Eulero. Questa è la risposta di Pixolator (alias Ofer Alon, creatore del programma Zbrush) ad una mia richiesta di spiegazioni nel lontano luglio 2003:

"Hi Cameyo:
As you have already figured out, rotation system is a bit complicated. Internally, ZBrush is utilizing rotation matrices, Euler angles as well as quaternions.The rotation values in the TRNASFORM palette (and the TransformGet commands) are values that have been translated from ZBrush's internal representation into a more readable x,y,z angles format. The effective range for Y and Z rotations is ± 180 degrees. Values that are outside this range are automatically readjusted to fit within this range. The effective range for the X axis is only ±90 (this is why your ZScript is problematic when the X axis angle crosses the 90 degrees range). If you use values outside this range, the X will be readjusted and may require the Y axis to be reflected (+180 degrees). As mentioned above, "Gimbal lock" is also an issue when rotating an object by 90 degrees increments.

These factors must be taken into consideration when ZScripting rotation commands. One of ZBrush's standard ZScripts is the "PointFromTo" ZScript. This ZScript present a solution to a different, but yet related, rotation problem. I am including the source code of the "PointFromTo" ZScript here, you may find it helpful to your rotation explorations

-Pixolator"

Le rotazioni dei quaternioni sono molto più potenti e robuste poichè valutano tutti e tre gli assi contemporaneamente per trovare una direzione in cui muoversi e un quarto valore (la componente w o il vettore up) per indicare alla matrice quanto deve muoversi. Il vantaggio di utilizzare questo metodo è che non dobbiamo mai preoccuparci del Gimbal Lock poichè non può accadere in quanto tutti e tre gli assi vengono aggiornati contemporaneamente. Il lato negativo dell'utilizzo dei quaternioni è che sono molto più complicati da concettualizzare e implementare rispetto agli angoli di Eulero.


--------
BIORITMI
--------

Un bioritmo è un tentativo di identificare vari aspetti della vita di una persona attraverso una semplice modellazione matematica. La maggior parte degli scienziati crede che quest'idea non abbia un'efficacia maggiore del caso e considerano il concetto come un esempio di pseudoscienza.

Secondo la teoria dei bioritmi, la vita di una persona è caratterizzata da cicli biologici ritmici che influenzano le attività e le abilità personali in vari aspetti: fisico, emotivo e mentale (intellettuale). Questi cicli iniziano alla nascita ed oscillano in modo costante (onde sinusoidali) nel corso della vita.

La maggior parte dei modelli di bioritmo usa tre cicli: uno fisico di 23 giorni, uno emotivo di 28 ed uno mentale di 33. Sebbene il ciclo di 28 giorni sia della stessa lunghezza del ciclo mestruale medio delle donne, e sia stato in origine definito come ciclo “femminile” (vedi in seguito), i due non sono necessariamente sincronizzati. Ognuno di questi cicli varia tra estremi alti e bassi, in modo sinusoidale, con giorni in cui il ciclo incrocia la linea dello zero, descritti come "giorni critici" a maggior rischio di incertezza. In aggiunta a questi tre cicli, sono stati proposti vari altri cicli, basati sulla combinazione lineare dei tre, o su cicli più lunghi o più corti.

Le equazioni che regolano i tre cicli di base sono:

  Fisico: sin(2*pi*x/23)
  Emotivo: sin(2*pi*x/28)
  Mentale: sin(2*pi*x/33)

dove x indica il numero di giorni dalla nascita.

Si può osservare che la combinazione dei due cicli di 23 e 28 giorni si ripete (periodo) ogni 644 giorni (un anno e 3/4), mentre la tripla combinazione dei cicli di 23, 28 e 33 giorni si ripete ogni 21.252 giorni (circa 58 anni).

Converte una data gregoriana in numero del giorno giuliano (valido solo dal 15 ottobre 1582 d.C.):

(define (gdate-julian gdate)
  (local (a y m)
    (setq a (/ (- 14 (gdate 1)) 12))
    (setq y (+ (gdate 0) 4800 (- a)))
    (setq m (+ (gdate 1) (* 12 a) (- 3)))
    (+ (gdate 2) (/ (+ (* 153 m) 2) 5) (* y 365) (/ y 4) (- (/ y 100)) (/ y 400) (- 32045))))

Calcola la differenza tra due date gregoriane:

(define (gdate-diff gdate1 gdate2)
  (- (gdate-julian gdate1) (gdate-julian gdate2)))

(gdate-diff '(2021 5 6) '(1983 3 21))
;-> 13926

(setq PI 3.1415926535897931)

Funzioni per i tre cicli:

(define (fisico x)
  (sin (div (mul 2 3.141592653589793 x) 23)))
(define (emotivo x)
  (sin (div (mul 2 3.141592653589793 x) 28)))
(define (mentale x)
  (sin (div (mul 2 3.141592653589793 x) 33)))

(fisico 0)
;-> 0
(fisico 644)
;-> -6.857795581405313e-015

Vediamo come visualizzare i valori dei tre cicli nell'intervallo (-100, 100):

(define (cicli)
  (println " Emotivo       Fisico        Mentale")
  (println " gg    val     gg    val     gg    val")
  (for (i 0 33 1)
    (print (format "%3d  %+5d    " i (round (mul 100 (fisico i)))))
    (print (format "%3d  %+5d    " i (round (mul 100 (emotivo i)))))
    (print (format "%3d  %+5d    " i (round (mul 100 (mentale i)))))
    (println {})))

(cicli)
;-> Emotivo       Fisico        Mentale
;-> gg    val     gg    val     gg    val
;->  0     +0      0     +0      0     +0
;->  1    +27      1    +22      1    +19
;->  2    +52      2    +43      2    +37
;->  3    +73      3    +62      3    +54
;->  4    +89      4    +78      4    +69
;->  5    +98      5    +90      5    +81
;->  6   +100      6    +97      6    +91
;->  7    +94      7   +100      7    +97
;->  8    +82      8    +97      8   +100
;->  9    +63      9    +90      9    +99
;-> 10    +40     10    +78     10    +95
;-> 11    +14     11    +62     11    +87
;-> 12    -14     12    +43     12    +76
;-> 13    -40     13    +22     13    +62
;-> 14    -63     14     +0     14    +46
;-> 15    -82     15    -22     15    +28
;-> 16    -94     16    -43     16    +10
;-> 17   -100     17    -62     17    -10
;-> 18    -98     18    -78     18    -28
;-> 19    -89     19    -90     19    -46
;-> 20    -73     20    -97     20    -62
;-> 21    -52     21   -100     21    -76
;-> 22    -27     22    -97     22    -87
;-> 23     +0     23    -90     23    -95
;-> 24    +27     24    -78     24    -99
;-> 25    +52     25    -62     25   -100
;-> 26    +73     26    -43     26    -97
;-> 27    +89     27    -22     27    -91
;-> 28    +98     28     +0     28    -81
;-> 29   +100     29    +22     29    -69
;-> 30    +94     30    +43     30    -54
;-> 31    +82     31    +62     31    -37
;-> 32    +63     32    +78     32    -19
;-> 33    +40     33    +90     33     +0

Scriviamo una funzione che visualizza i valori dei bioritmi per 11 giorni (5 giorni prima, giorno scelto, 5 giorni dopo) in modo da identificare anche l'andamento delle curve e non solo i valori del giorno scelto:

(define (bioritmi data-oggi data-nascita)
  (println "Emotivo   Fisico   Mentale")
  (setq giorni (gdate-diff data-oggi data-nascita))
  (setq pre (- giorni 5))
  (setq post (+ giorni 5))
  (for (i pre post)
    (if (= i giorni) (println (format "%s" (dup "-" 31))))
    (print (format "%+6d   %+6d   %+6d"
            (round (mul 100 (fisico i))) (round (mul 100 (emotivo i))) (round (mul 100 (mentale i)))))
    (if (= i giorni) (print (format "\n%s" (dup "-" 31))))
    (println {})
  ))

Bioritmo del giorno 6 maggio 2021 per una persona nata il 21 marzo 1983:

(bioritmi '(2021 5 6) '(1983 3 21))
;-> Emotivo   Fisico   Mentale
;->   +100      +90      -81
;->    +94      +97      -69
;->    +82     +100      -54
;->    +63      +97      -37
;->    +40      +90      -19
;-> -------------------------------
;->    +14      +78       +0
;-> -------------------------------
;->    -14      +62      +19
;->    -40      +43      +37
;->    -63      +22      +54
;->    -82       +0      +69
;->    -94      -22      +81


-----------
RUNGE-KUTTA
-----------

Data l'equazione differenziale:

  y'(t) = t * sqrt[y(t)]

con le condizioni inziali:

  t0 = 0
  y0 = y(t0) = y(0) = 1

Questa equazione a la seguente soluzione esatta:

          (t² + 4)²
  y(t) = -----------
            16

Utilizzare il metodo Runge-Kutta del quarto ordine per risolvere l'equazione differenziale nell'intervallo t = 0 ... 10 con un valore di incremento di dt = 0.1 (101 punti totali, dato il primo). Stampare i valori calcolati di y ad ogni valore intero di t (0, 1.0, 2.0, ... 10.0) insieme all'errore rispetto alla soluzione esatta.

Metodo Runge-Kutta
------------------
Partendo da un dato yn e tn calcolare:

  dy1 = dt * y'(tn,yn)
  dy2 = dt * y'(tn + dt/2, yn + dy1/2)
  dy3 = dt * y'(tn + dt/2, yn + dy2/2)
  dy4 = dt * y'(tn + dt, yn + dy3)

poi calcolare:

  y(n+1) = yn + (dy1 +2*dy2 + 2*dy3 + dy4)/6
  t(n+1) = tn + dt

Implementazione:

(define (equation t y) (mul t (sqrt y)))
(define (solution t) (div (pow (add (mul t t) 4) 2) 16))

(define (rk4)
  (local (t end-t dt n y s dy1 dy2 dy3 dy4 i error t-rounded)
    (setq t 0.0)
    (setq end-t 10.0)
    (setq dt 0.1)
    (setq n (+ (int (div (sub end-t t) dt)) 1))
    (setq y (array n '(0)))
    (setq s (array n '(0)))
    (setq i 0)
    (setq (s i) 0.0)
    (setq (y i) 1.0)
    (println " t    y(t)     errore")
    (println (format "%4.1f %8.3f  %e" 0.00 1.00 0.00))
    (while (< i (- (length y) 1))
      (setq dy1 (mul dt (equation (s i) (y i))))
      (setq dy2 (mul dt (equation (add (s i) (div dt 2)) (add (y i) (div dy1 2)))))
      (setq dy3 (mul dt (equation (add (s i) (div dt 2)) (add (y i) (div dy2 2)))))
      (setq dy4 (mul dt (equation (add (s i) dt) (add (y i) dy3))))
      (setf (s (+ i 1)) (add (s i) dt))
      (setf (y (+ i 1)) (add (y i) (div (add dy1 (mul 2 dy2) (mul 2 dy3) dy4) 6)))
      (setq error (abs (sub (y (+ i 1)) (solution (s (+ i 1))))))
      (setq t-rounded (round (add t dt) -2))
      (if (zero? (mod t-rounded 1))
          (println (format "%4.1f %8.3f  %e" t-rounded (y (+ i 1)) error))
      )
      (++ i)
      (setq t (add t dt))
    )
    '----------------------------))

(rk4)
;->  t    y(t)     errore
;->  0.0    1.000  0.000000e+000
;->  1.0    1.562  1.457219e-007
;->  2.0    4.000  9.194792e-007
;->  3.0   10.562  2.909562e-006
;->  4.0   25.000  6.234909e-006
;->  5.0   52.562  1.081970e-005
;->  6.0  100.000  1.659460e-005
;->  7.0  175.562  2.351773e-005
;->  8.0  289.000  3.156520e-005
;->  9.0  451.562  4.072316e-005
;-> 10.0  676.000  5.098329e-005
;-> ----------------------------


------
ISBN13
------

Il codice ISBN ("International Standard Book Number" cioè il numero di riferimento internazionale di un libro) è una sequenza numerica di 13 cifre usata per la classificazione dei libri.
L'attuale codice ISBN è formato da una stringa di 13 cifre, suddivise in 5 settori. Generalmente, ma non sempre, i vari settori del codice ISBN sono separati l'uno dall'altro da un trattino (è il metodo consigliato) o da uno spazio.

1) Prefisso EAN – sono le prime tre cifre del codice ISBN, introdotte a partire dal 2007. Indicano che si è in presenza di un libro.

2) Gruppo linguistico – è l'identificativo del paese o dell'area linguistica dell'editore. Può utilizzare da 1 a 5 cifre.

3) Editore – è l'identificativo della casa editrice o del marchio editoriale. Può utilizzare da 2 a 7 cifre.

4) Titolo – è l'identificativo del libro. Può utilizzare da 1 a 6 cifre.

5) Carattere di controllo – è l'ultima cifra del codice ISBN (nei "vecchi" codici ISBN-10, oltre ai numeri da 0 a 9, si utilizzava anche il 10 romano, cioè la "X") e serve a verificare che il codice non sia stato letto o trascritto erroneamente.

Solo il primo e l'ultimo settore hanno un numero fisso di cifre (rispettivamente 3 e 1), mentre per gli altri tre settori centrali il numero di cifre varia in modo complementare fra loro. I tre settori centrali, nel loro insieme, hanno dunque a disposizione le nove cifre restanti. Questo significa che, meno cifre sono utilizzate dal gruppo linguistico e dall'editore, più cifre sono disponibili per la sua produzione editoriale (il settore titolo). In altre parole, le lingue e gli editori che hanno meno cifre nel codice ISBN dovrebbero essere anche quelli che pubblicano una maggior quantità di libri.

Verificare se un numero ISBN13 è valido.

Algoritmo di validazione ISBN13
-------------------------------
ISBN      9    7    8    1    8    6    1    9    7    8    7    6    9
Peso      1    3    1    3    1    3    1    3    1    3    1    3    1
Prodotto  9 + 21 +  8 +  3 +  8 + 18 +  1 + 27  + 7 + 24 +  7 + 18 +  9 = 160

160 diviso 10 = 16 resto 0
Se il resto vale 0, allora ISBN13 è valido.

Esempi:

  978-1734314502 valido
  978-1734314509 errato
  978-1788399081 valido
  978-1788399083 errato

Possiamo scrivere la seguente funzione per la verifica:

(define (check-ISBN13 str)
  (local (mult)
    (setq str (replace "-" str ""))
    (setq mult '(1 3 1 3 1 3 1 3 1 3 1 3 1))
    (setq val (map int (explode str)))
    (setq m (apply + (map * val mult)))
    (zero? (% m 10))))

(check-ISBN13 "978-1734314502")
;-> true
(check-ISBN13 "978-1734314509")
;-> nil
(check-ISBN13 "978-1788399081")
;-> true
(check-ISBN13 "978-1788399083")
;-> nil


-----------------
INSIEME DI CANTOR
-----------------

L'insieme di Cantor (dal matematico tedesco Georg Cantor), è un sottoinsieme dell'intervallo [0, 1] dei numeri reali.
L'insieme di Cantor è definibile in modo ricorsivo, partendo dall'intervallo [0, 1] e rimuovendo ad ogni passo un segmento aperto centrale da ogni intervallo.
Al primo passo rimuoviamo da [0, 1] il sotto-intervallo (1/3, 2/3), e rimaniamo quindi con due intervalli [0, 1/3] U [2/3, 1].
Al secondo passo rimuoviamo un segmento aperto centrale in entrambi questi intervalli (che ha lunghezza pari a un terzo della lunghezza del segmento, come al primo passo), e otteniamo quattro intervalli ancora più piccoli. E si continua così in modo analogo.
L'insieme di Cantor consiste di tutti i punti dell'intervallo di partenza [0, 1] che non vengono mai rimossi da questo procedimento ricorsivo: in altre parole, l'insieme che rimane dopo aver iterato questo procedimento infinite volte. È chiamato in termini suggestivi come "polvere di Cantor".

I primi quattro passi di questo processo sono illustrati qui sotto:

  ■■■■■■■■■■■■■■■■■■■■■■■■■■■
  ■■■■■■■■■         ■■■■■■■■■
  ■■■   ■■■         ■■■   ■■■
  ■ ■   ■ ■         ■ ■   ■ ■

Scriviamo una funzione che stampa 5 passi del processo:

(define (cantor start len idx)
 (local (seg)
  (setq seg (/ len 3))
  (cond ((zero? seg) nil)
        (true
         (for (i idx (- height 1))
           (for (j (+ start seg) (+ start (* seg 2) (- 1)))
             (setf (lines i j) " ")
           )
         )
         (cantor start seg (+ idx 1))
         (cantor (+ start (* seg 2)) seg (+ idx 1)))
  )))

(define (cantor-set)
  (local (width height lines)
    (setq width 81)
    (setq height 5)
    (setq lines (array height width '("■")))
    (cantor 0 width 1)
    (for (i 0 (- height 1))
      (for (j 0 (- width 1))
        (print (lines i j))
      )
      (println {})
    )))

(cantor-set)
;-> ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
;-> ■■■■■■■■■■■■■■■■■■■■■■■■■■■                           ■■■■■■■■■■■■■■■■■■■■■■■■■■■
;-> ■■■■■■■■■         ■■■■■■■■■                           ■■■■■■■■■         ■■■■■■■■■
;-> ■■■   ■■■         ■■■   ■■■                           ■■■   ■■■         ■■■   ■■■
;-> ■ ■   ■ ■         ■ ■   ■ ■                           ■ ■   ■ ■         ■ ■   ■ ■


---------------------------------------------
INCREMENTO-DECREMENTO DI UNA STRINGA NUMERICA
---------------------------------------------

Scrivere due funzioni per incrementare e decrementare una stringa numerica.

Incrementa una stringa numerica:

(define (inc-str str)
  (string (++ (int str 0 10))))

(inc-str "-1")
;-> 0
(inc-str "08")
;-> "9"
(inc-str "")
;-> "1"

Decrementa una stringa numerica:

(define (dec-str str)
  (string (-- (int str 0 10))))

(dec-str "-1")
;-> "-2"
(dec-str "12abc")
;-> "11"
(dec-str "abc12")
;-> "-1"


------------------------
FUNZIONI DI PRIMA CLASSE
------------------------

Un linguaggio ha funzioni di prima classe ("first-class funciton") se può eseguire ciascuna delle seguenti operazioni senza invocare ricorsivamente un compilatore o un interprete o la metaprogrammazione:

1) Creare nuove funzioni da funzioni preesistenti in fase di esecuzione
2) Memorizzare le funzioni in oggetti iterabili (es. liste,vettori)
3) Usare le funzioni come argomenti per altre funzioni
4) Usare le funzioni come valori di ritorno di altre funzioni

Il seguente codice effettua tutte le operazioni richieste:

(define (compose f g) (expand (lambda (x) (f (g x))) 'f 'g))
(define (cube x) (pow x 3))
(define (cube-root x) (pow x (div 1 3)))

(setq function (list sin cos cube))
(setq inverse (list asin acos cube-root))
(setq x 0.5)

(define (go f g)
  (if (not (or (null? f) (null? g)))
      (begin (println ((compose (first f) (first g)) x))
             (go (rest f) (rest g)))))

(go function inverse)
;-> 0.5
;-> 0.4999999999999999
;-> 0.5000000000000001

Prima-classe (first-class) e Ordine-superiore (high-class)
----------------------------------------------------------
Funzione di prima classe:
un linguaggio di programmazione ha funzioni di prima classe se le funzioni in quel linguaggio vengono trattate come altre variabili. Quindi le funzioni possono essere assegnate a qualsiasi altra variabile o passate come argomento o possono essere restituite da un'altra funzione.

Funzione di ordine superiore:
una funzione che riceve un'altra funzione come argomento o che restituisce una nuova funzione o entrambe è chiamata funzione di ordine superiore. Le funzioni di ordine superiore sono possibili solo grazie alla funzione di prima classe.


----------------
INVERSIONE FRASE
----------------

Data una stringa di parole separate da spazi scrivere tre funzioni per:

1) Invertire i caratteri della stringa.
2) Invertire i caratteri di ogni singola parola nella stringa, mantenendo l'ordine originale delle parole all'interno della stringa.
3) Invertire l'ordine di ogni parola della stringa, mantenendo l'ordine dei caratteri in ogni parola.

(setq str "Frase da invertire")

1)
(define (invert-chars str)
  (reverse str))
(invert-chars str)
;-> "eritrevni ad esarF"

2)
(define (invert-words-chars str)
  (map reverse (parse str " " )))
(invert-words-chars str)
;-> ("esarF" "ad" "eritrevni")

3)
(define (invert-words str)
  (reverse (parse str " " )))
(invert-words str)
;-> ("invertire" "da" "Frase")


---------------------
CONTEGGIO POPOLAZIONE
---------------------

Il conteggio della popolazione (population count) è il numero di 1 (uno) nella rappresentazione binaria di un numero intero non negativo. Quseto valore è conosciuto anche con i seguenti nomi:

 - pop count
 - popcount
 - sideways sum
 - bit summation
 - Hamming weight

Ad esempio, 5 (che è 101 in binario) ha un conteggio della popolazione pari a 2.

I numeri malvagi (Evil numbers) sono numeri interi non negativi che hanno un conteggio della popolazione pari (OEIS A001969).

I numeri odiosi (Odious numbers) sono numeri interi positivi che hanno un conteggio della popolazione dispari (OEIS A000069).

Scrivere una funzione che genera i numeri malvagi e i numeri odiosi fino ad un dato numero.

(define (count-pop num)
  (first (count '("1") (explode (bits num)))))
(count-pop 100)
;-> 3

(define (evil-odious num)
  (let ((evil '()) (odious '()) (val 0))
    (for (i 0 num)
      (setq val (count-pop i))
      (if (even? val)
          (push i evil -1)
          (push i odious -1)
      )
    )
    (list evil odious)))

(evil-odious 30)
;-> ((0 3 5 6 9 10 12 15 17 18 20 23 24 27 29 30)
;->  (1 2 4 7 8 11 13 14 16 19 21 22 25 26 28))


------------------------------
SELEZIONE CASUALE DA UNA LISTA
------------------------------

Scrivere una funzione che seleziona un elemento casuale da una lista.

(define (pick-rand lst)
  (lst (rand (length lst))))

(setq lst '(6 21 31 12 58 63 77 36 42))

(pick-rand lst)
;-> 6
(pick-rand lst)
;-> 63
(pick-rand lst)
;-> 21
(pick-rand lst)
;-> 63

Se vogliamo ogni volta un elemento diverso (fino all'esaurimento dei numeri della lista) possiamo scrivere:

(setq lst '(6 21 77 42))

(define (pick-unique-rand)
  (cond ((null? lst) nil)
        (true
        (let (val (lst (rand (length lst))))
        (pop lst (find val lst))
        val))))

(pick-unique-rand lst)
;-> 21
(pick-unique-rand lst)
;-> 77
(pick-unique-rand lst)
;-> 6
(pick-unique-rand lst)
;-> 42
;-> (pick-unique-rand lst)
nil

Oppure possiamo generare tutta la lista di numeri casuali con la funzione "randomize":

(define (get-unique-rand lst)
  (randomize lst))

(setq lst (sequence 1 90))

(get-unique-rand lst)
;-> (41 75 43 66 77 11 23 15 82 40 72 87 20 74 32 10 37 63 56 21 61 50
;->  90 71 1 76 78 53 64 6 47 2 83 27 3 28 33 42 59 58 4 85 81 31 70 52
;->  7 34 79 12 44 54 19 14 89 65 67 16 24 73 39 38 60 25 5 30 86 46 55
;->  80 57 29 26 62 13 68 9 49 36 48 8 69 84 45 51 17 22 35 88 18)


------------------------------
RAPPRESENTAZIONE DI ZECKENDORF
------------------------------

Proprio come i numeri possono essere rappresentati in una notazione posizionale come somme di multipli delle potenze di dieci (decimali) o di due (binarie), tutti gli interi positivi possono essere rappresentati come la somma di una o zero volte i membri distinti della serie di Fibonacci.

Ricorda che i primi sei numeri di Fibonacci distinti sono: 1, 2, 3, 5, 8, 13.

Il numero decimale 11 (undici) può essere scritto come 0*13 + 1*8 + 0*5 + 1*3 + 0*2 + 0*1 o 010100 in notazione posizionale dove le colonne rappresentano la moltiplicazione per un particolare membro della sequenza. Gli zeri iniziali vengono eliminati in modo che 11 decimale diventi 10100.

Tuttavia, 10100 non è l'unico modo per ricavare 11 dai numeri di Fibonacci: anche 0*13 + 1*8 + 0*5 + 0*3 + 1*2 + 1*1 o 010011 rappresenta anche il decimale 11. Comunque per un vero numero Zeckendorf c'è la restrizione aggiuntiva che non possono essere usati due numeri di Fibonacci consecutivi, quindi l'ultima rappresentazione di 11 non è un numero di Zeckendorf.

Scrivere una funzione che converte un generico numero intero nel corrispondente numero di Zeckendorf.

(define (fib num)
  (if (< num 2)
      num
      (add (fib (- num 1)) (fib (- num 2)))))

(define (zeckendorf num)
  (local (fibNums fibPos curFibNum temp out)
    (setq out "")
    (setq fibNums '())
    (setq fibPos 2)
    (setq curFibNum (fib fibPos))
    (do-while (<= curFibNum num)
      (push curFibNum fibNums)
      (++ fibPos)
      (setq curFibNum (fib fibPos))
    )
    (setq temp num)
    (dolist (el fibNums)
      (if (<= el temp)
        (begin
          (push "1" out -1)
          (setq temp (- temp el))
        )
        (push "0" out -1)
      )
    )
    out))

(zeckendorf 10)
;-> "10010"

(for (i 1 10)
  (println i {: } (zeckendorf i))
)
;-> 1: 1
;-> 2: 10
;-> 3: 100
;-> 4: 101
;-> 5: 1000
;-> 6: 1001
;-> 7: 1010
;-> 8: 10000
;-> 9: 10001
;-> 10: 10010

Scriviamo anche una funzione che effettua l'operazione inversa, cioè converte una stringa che rappresenta un numero di Zuckendorf nel corrispondente numero decimale:

(define (zeck-decimal zeck)
  (local (num)
    (setq num 0)
    (dolist (b (explode (reverse zeck)))
      (if (= b "1")
          (setq num (+ (fib (+ $idx 2)) num))))
    num))

(zeckendorf 10)
;-> "10010"
(zeck-decimal "10010")
;-> 10
(zeckendorf 100)
;-> "1000010100"
(zeck-decimal "1000010100")
;-> 100

(zeckendorf (zeck-decimal "10101010"))
;-> "10101010"
(zeck-decimal (zeckendorf 54))
;-> 54


-----------------------------
VECCHIE UNITÀ DI MISURA RUSSE
-----------------------------

Scrivere un programma per convertire le vecchie misure di lunghezza russe nel sistema metrico (e viceversa).


(setq unit-name '("kilometer" "meter" "centimeter"
                  "tochka" "liniya" "diuym" "vershok" "piad"
                  "fut" "arshin" "sazhen" "versta" "milia"))

(setq unit-value '(1000.0 1.0 0.01
                   0.000254 0.00254 0.0254 0.04445 0.1778
                   0.3048 0.7112 2.1336 1066.8 7467.6))

(define (russian-unit val unit)
  (local (idx scala)
    (setq idx (find unit unit-name))
    (setq scala (mul val (unit-value idx)))
    (println val " " unit " is:")
    (dolist (el unit-name)
      (cond ((!= el unit)
            (println (format "%.6f %s" (div scala (unit-value $idx)) el)))
      )
    )))

(russian-unit 1 "meter")
;-> 1 meter is:
;-> 0.001000 kilometer
;-> 100.000000 centimeter
;-> 3937.007874 tochka
;-> 393.700787 liniya
;-> 39.370079 diuym
;-> 22.497188 vershok
;-> 5.624297 piad
;-> 3.280840 fut
;-> 1.406074 arshin
;-> 0.468691 sazhen
;-> 0.000937 versta
;-> 0.000134 milia

(russian-unit 20 "piad")
;-> 20 piad is:
;-> 0.003556 kilometer
;-> 3.556000 meter
;-> 355.600000 centimeter
;-> 14000.000000 tochka
;-> 1400.000000 liniya
;-> 140.000000 diuym
;-> 80.000000 vershok
;-> 11.666667 fut
;-> 5.000000 arshin
;-> 1.666667 sazhen
;-> 0.003333 versta
;-> 0.000476 milia

=============================================================================

