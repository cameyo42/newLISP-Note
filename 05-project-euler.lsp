================

 PROJECT EULERO
 
================

  Problema    Soluzione     Tempo (msec)
|    1     |  233168       |         0  |
|    2     |  4613732      |         0  |
|    3     |  6857         |         0  |
|    4     |  906609       |       297  |
|    5     |  232792560    |         0  |
|    6     |  25164150     |         0  |
|    7     |  104743       |        78  |
|    8     |  235146240    |       110  |
|    9     |  31875000     |        62  |
|    10    |  142913828    |      1563  |
|    11    |  70600674     |         0  |
|    12    |  76576500     |      5445  |
|    13    |  5537376230   |         0  |
|    14    |  837799       |     22487  |
|    15    |  137846528    |         0  |
|    16    |  1366         |         0  |
|    17    |  21124        |         0  |
|    18    |  1074         |        32  |
|    19    |  171          |         3  |
|    20    |  648          |         0  |
|    21    |  31626        |       122  |
|    22    |  871198282    |        20  |
|    23    |  4179871      |     40900  |
|    24    |  278391546    |     25309  |
|    25    |  4782         |      4926  |
|    26    |  983          |       488  |
|    27    |  -59231       |      2000  |
|    28    |  669171001    |         0  |
|    29    |  9183         |       141  |
|    30    |  443839       |       516  |
|    31    |  73682        |         1  |
|    32    |  45228        |      1625  |
|    33    |  100          |         0  |
|    34    |  40730        |      3797  |
|    35    |  55           |      1267  |
|    36    |  872187       |      1443  |
|    37    |  748317       |       778  |
|    38    |  932718654    |        94  |
|    39    |  840          |     13486  |
|    40    |  210          |       141  |
|    41    |  7652413      |       125  |
|    42    |  162          |        31  |
|    43    |  16695334890  |      1749  |
|    44    |  5482660      |      5589  |
|    45    |  1533776805   |       115  |
|    46    |  5777         |        31  |
|    47    |  134043       |         0  |
|    48    |  9110846700   |       266  |
|    49    |  296962999629 |        19  |
|    50    |  997651       |     27113  |

Sito web: https://projecteuler.net/archives

Cos'è Project Euler?
Project Euler è una serie di stimolanti problemi di programmazione matematica/informatica che richiedono molto più di semplici approfondimenti matematici da risolvere. Sebbene la matematica ti aiuti ad arrivare a metodi eleganti ed efficienti, per risolvere la maggior parte dei problemi sarà necessario l'uso di un computer e competenze di programmazione.

La motivazione per l'avvio di Project Euler, e la sua continuazione, è di fornire una piattaforma per la mente indagatrice per addentrarsi in aree non familiari e apprendere nuovi concetti in un contesto divertente e ricreativo.

A chi sono rivolti i problemi?
Il pubblico previsto comprende studenti per i quali il curriculum di base non alimenta la loro fame per imparare, adulti il ​​cui background non era principalmente la matematica ma aveva un interesse per le cose matematiche, e professionisti che vogliono mantenere le loro capacità di solving e la matematica all'avanguardia.

Chiunque può risolvere i problemi?
I problemi sono di diversa difficoltà e per molti l'esperienza è l'apprendimento a catena induttivo. Cioè, risolvendo un problema ti esporrà ad un nuovo concetto che ti permette di intraprendere un problema precedentemente inaccessibile. Quindi il partecipante determinato lentamente ma sicuramente farà il suo lavoro attraverso ogni problema.

Cosa fare in seguito?
Per tenere traccia dei tuoi progressi è necessario impostare un account e abilitare i cookie. Se hai già un account, accedi, altrimenti devi registrati - è completamente gratuito!

Tuttavia, poiché alcuni problemi sono difficili, potresti voler visualizzare i Problemi prima di registrarti.

"Il progetto Eulero esiste per incoraggiare, sfidare e sviluppare le capacità e il divertimento di chiunque abbia un interesse per l'affascinante mondo della matematica."

In questo paragrafo affronteremo e risolveremo alcuni di questi problemi. Comunque prima di vedere la soluzione dovresti provare a risolverli per conto proprio in modo da migliorare le tue capacità di problem-solver e di programmatore.

Vengono prima presentate alcune funzioni comuni che servono per la soluzione di diversi problemi.

;=============================================
; (isprime? n)
; Controlla se n è un numero primo
; Non funziona con i big integer
; numero massimo (int64): 9223372036854775807
(define (isprime? n)
  (if (< n 2) nil
    (if (= 1 (length (factor n))))))
;=============================================

;=============================================
; (factor-group n)
; fattorizza il numero x raggruppando i termini uguali
; Non funziona con i big integer
; numero massimo (int64): 9223372036854775807
;=============================================

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

(factor-group 1)
;-> (1 1)

(factor-group 2000)
;-> ((2 4) (5 3))

(factor-group 232792560)
;-> ((2 4) (3 2) (5 1) (7 1) (11 1) (13 1) (17 1) (19 1))

E la funzione inversa a factor-group che genera il numero partendo dalla fattorizzazione:

(define (inv-factor-group lst)
      (apply * (map (lambda (x) (pow (first x) (last x))) lst))
)

(inv-factor-group (factor-group 232792560))
;-> 232792560


==========
Problema 1
==========

Multipli di 3 e di 5

Se elenchiamo i numeri sotto a 10 che sono multipli di 3 o di 5, otteniamo 3, 5, 6 e 9.
La loro somma vale 23.

Trova la somma di tutti i multipli di 3 o di 5 sotto a 1000.
============================================================================

La funzione "sequence" genera una lista di numeri:

(sequence 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(sequence 1 10 2)
;-> (1 3 5 7 9)

Possiamo anche scrivere una funzione che si comporta come "sequence":

(define (seq start end (step 1))
  (cond ((= start end) (list end))
        ((> start end) '())
        (true (cons start (seq (+ start step) end step)))
  )
)

(seq 1 10)
;-> (1 2 3 4 5 6 7 8 9 10)

(seq 1 10 2)
;-> (1 3 5 7 9)

Un numero n è divisibile esattamente per m se risulta (n mod m == 0),
cioè il resto della divisione tra n e m vale zero.
In newLISP "%" è la funzione mod per i numeri interi.

(zero? (% 10 2))
;-> true
(zero? (% 130 11))
;-> nil

La funzione "filter" seleziona tutti i valori che soddisfano un predicato:
(filter (fn(x) (> x 5)) '(6 4 5 2 6 7 3 4 8 9))
;-> (6 6 7 8 9)

La funzione "apply" applica una funzione utilizzando tutti gli argomenti:
(apply + '(1 3 5))
;-> 9

Adesso possiamo scrivere la funzione:

(define (e001)
  (apply + (filter (fn(x) (or (zero? (% x 3)) (zero? (% x 5)))) (sequence 1 999)))
)

(e001)
;-> 233168

(time (e001))
;-> 0

Soluzione alternativa:

generiamo due sequenze (una con i multipli di 3 e l'altra con i multipli di 5)
(setq a (sequence 3 20 3))
;-> (3 6 9 12 15 18)
(setq b (sequence 5 20 5))
;-> (5 10 15 20)
uniamo le sequenze (la funzione union mantiene solo valori unici)
(setq c (union a b))
;-> (3 6 9 12 15 18 5 10 20)
infine sommiamo tutti i numeri:
(apply + c)
;-> 18

Ed ecco la funzione:

(define (e001)
    (apply + (union (sequence 3 999 3) (sequence 5 999 5)))
)

(time (e001))
;-> 0


==========
Problema 2
==========

I numeri di Fibonacci pari

Ciascun nuovo termine della sequenza di Fibonacci viene generato addizionando i due termini precedenti.
Partendo da 1 e 2, i primi 10 termini valgono:

1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

Considerando i termini della sequenza di Fibonacci i cui valori non superano quttro milioni, trovare la somma dei termini pari.
============================================================================

Questa è la funzione per il calcolo dei numeri di fibonacci:

(define (fibonacci n)
  (let (L '(0 1))
    (dotimes (i n)
      (setq L (list (L 1) (apply + L)))
    )
    ;(L 1)
    (last L)
  )
)

Il numero 32 è quello che genera l'ultimo valore utile (minore di 4.000.000):

(fibonacci 32)
;-> 3524578

(fibonacci 33)
;-> 5702887

Modifichiamo l'espressione "dotimes" con "while" per controllare il valore ottenuto.
Inoltre aggiorniamo il valore del risultato (res) quando il numero calcolato è dispari.

(define (e002)
  (let (L '(0 1) res 0)
    ;(dotimes (i n)
    (while (< (last L) 4000000)
      (setq L (list (L 1) (apply add L)))
      (if (even? (last L)) (inc res (last L)))
    )
    ;(last L)
    res
  )
)

(e002)
;-> 4613732

(time (e002))
;-> 0

Soluzione alternativa:

(define (e002)
  (let (a 2 b 1 ans 0)
    (until (> b 4000000)
      (if (even? a)
        (inc ans a))
      (inc b a)
      (swap a b))
     ans))

(e002)
;-> 4613732

(time (e002))
;-> 0


==========
Problema 3
==========

Il più grande fattore primo

I fattori primi di 13195 sono 5, 7, 13 e 29.

Qual'è il fattore primo più grande del numero 600851475143 ?
============================================================================

La funzione "factor" di newLISP restituisce tutti i fattori di un numero:

(factor 600851475143)
;-> (71 839 1471 6857)

Non resta che trovare il valore massimo:

(apply max (factor 600851475143))
;-> 6857

Definiamo la funzione:

(define (e003)
  (apply max (factor 600851475143))
)

(e003)
;-> 6857

(time (e003))
;-> 0


==========
Problema 4
==========

Il più grande prodotto palindromo

Un numero palindromo ha lo stesso valore leggendo da sinistra a destra o da destra a sinistra.
Il più grande numero palindromo ottenuto dal prodotto di due numeri da due cifre vale 9009 = 91 * 99.

Trova il più grande numero palindromo ottenuto dal prodotto di due numeri da tre cifre.
============================================================================

(define (e004)
    (let (out 0  val 0)
        (for (i 100 999)
          (for (j i 999)
            (setq val (string (* i j)))
            (when (= val (reverse (copy val)))
                (setq out (max out (int val)))
            )
          )
        )
 out)
)

(e004)
;-> 906609

(time (e004))
;-> 296.849


==========
Problema 5
==========

Il multiplo minore

2520 è il più piccolo numero che può essere diviso esattamente (senza resto) da tutti i numeri da 1 a 10.

Qual'è il più piccolo numero positivo che è divisibile esattamente per tutti i numeri da 1 a 20 ?
============================================================================

La soluzione non vale 1*2*3*4*5*6*7*8*9*10*11*12*13*14*15*16*17*18*19*20 perchè, per esempio, quando il numero cercato è divisibile per 3 e per 5 è anche divisibile per 15.

La soluzione consiste nel trovare tutti i numeri che sono fattori unici con gli esponenti massimi e moltiplicarli tra loro.

Proviamo con il numero 10:

Troviamo tutte scomposizioni in fattori:

2  -> (2)
3  -> (3)
4  -> (2 2)
5  -> (5)
6  -> (2 3)
7  -> (7)
8  -> (2 2 2)
9  -> (3 3)
10 -> (2 5)

I fattori unici sono: 2, 3, 5, e 7.

Questi hanno esponenete massimo rispettivamente: 3 2 1 1.

Quindi i numeri da moltiplicare sono: 2^3, 3^2, 5^1 e 7^1.

Otteniamo: 8 * 9 * 5 * 7 = 2520.

; lista con le fattorizzazioni dei numeri da 2 a 10
(setq a (map factor (sequence 2 10)))
;-> ((2) (3) (2 2) (5) (2 3) (7) (2 2 2) (3 3) (2 5))

; lista con tutti i numeri dei fattori
(setq b (flat (map factor (sequence 2 10))))
;-> (2 3 2 2 5 2 3 7 2 2 2 3 3 2 5)

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

Adesso dobbiamo trovare gli esponenti massimi di 2,3,5 e 7 nella lista con le fattorizzazioni dei numeri da 2 a 10.

Vediamo prima come funziona funzione "count":

(setq a '((1 2) (5 5) (2 3)))
(setq c '(2 3 5))

Vogliamo trovare quante volte gli elementi di c compaiono in a:

(map (curry count c) a)
;-> ((1 0 0) (0 0 2) (1 1 0)

cosa significa il risultato?

(1 0 0) -> conto il 2 una  volta su (1 2)
        -> conto il 3 zero volte su (1 2)
        -> conto il 5 zero volte su (1 2)

(0 0 2) -> conto il 2 zero volte su (5 5)
        -> conto il 3 zero volte su (5 5)
        -> conto il 5 due  volte su (5 5)

(1 1 0) -> conto il 2 una  volta su (2 3)
        -> conto il 3 una  volta su (2 3)
        -> conto il 5 zero volte su (2 3)

Se trasponiamo la lista:

(transpose(map (curry count c) a))
;-> ((1 0 1) (0 0 1) (0 2 0))

Che significa:

(1 0 1) -> conto il 2 una  volta su (1 2)
        -> conto il 2 zero volte su (5 5)
        -> conto il 2 una  volta su (2 3)
(0 0 1) -> conto il 3 zero volte su (1 2)
        -> conto il 3 zero volte su (5 5)
        -> conto il 3 una  volta su (2 3)
(0 2 0) -> conto il 5 zero volte su (1 2)
        -> conto il 5 due  volte su (5 5)
        -> conto il 5 zero volte su (2 3)

Nel nostro caso:

; lista con le fattorizzazioni dei numeri da 2 a 10
(setq a (map factor (sequence 2 10)))
;-> ((2) (3) (2 2) (5) (2 3) (7) (2 2 2) (3 3) (2 5))

; lista con tutti i numeri dei fattori
(setq b (flat (map factor (sequence 2 10))))
;-> (2 3 2 2 5 2 3 7 2 2 2 3 3 2 5)

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

Adesso troviamo quante volte gli elementi di c compaiono in a:

(setq d (transpose(map (curry count c) a)))
;-> ((1 0 2 0 1 0 3 0 1) (0 1 0 0 1 0 0 2 0) (0 0 0 1 0 0 0 0 1) (0 0 0 0 0 1 0 0 0))

Adesso dobbiamo trovare il valore massimo di ogni sottolista (che sono gli esponenti massimi rispettivamente di 2,3,5 e 7).

(setq e (map (curry apply max)
            (transpose(map (curry count c) a))))
;-> (3 2 1 1)

Per capire meglio come funziona l'ultima espressione vediamo un esempio.

Se vogliamo applicare la funzione "sin" ad una lista di valori possiamo usare la funzione "map":

(map sin '(10 20 30))
;-> (-0.5440211108893698 0.9129452507276277 -0.9880316240928618)

Ma se i valori sono in sottoliste questo non funziona:

(map sin '((10) (20) (30)))
;-> ERR: value expected in function sin : '(10)

La soluzione si ottiene utilizzando la funzione "curry" e "apply":

(map (curry apply sin) '((10) (20) (30)))
;-> (-0.5440211108893698 0.9129452507276277 -0.9880316240928618)

Oppure in modo equivalente:

(map (lambda (x) (apply sin x)) '((10) (20) (30)))

"curry" transforma una funzione f(x, y) che prende due argomenti in una funzione fx(y) che prende un singolo argomento.
In questo modo "curry" dice ad "apply" di applicare la funzione "sin" solo alla sottolista.

Tornando al problema abbiamo:

; lista con tutti i numeri dei fattori presi una sola volta
(setq c (unique (flat (map factor (sequence 2 10)))))
;-> (2 3 5 7)

; lista con gli esponenti massimi rispettivamente di 2,3,5 e 7).
(setq e (map (curry apply max)
            (transpose(map (curry count c) a))))
;-> (3 2 1 1)

Adesso calcoliamo i numeri con la funzione "pow" e li moltiplichiamo tra loro:

(apply * (map pow c e))
;-> 2520

Scriviamo la funzione finale:

(define (e005)
  (setq a (map factor (sequence 2 20)))
  (setq b (flat a))
  (setq c (unique b))
  (setq e (map (curry apply max)
               (transpose(map (curry count c) a))))
  (apply * (map pow c e))
)

(e005)
;-> 232792560

(time (e005))
;-> 0

Dopo tutti questi ragionamenti per trovare la soluzione notiamo che il problema richiedeva semplicemente di trovare il minimo comune multiplo dei primi venti numeri interi...
Quindi utilizzando la seguente funzione che calcola il Minimo Comune Multiplo di una serie di numeri:

(define-macro (mcm)
  (apply (fn (x y) (/ (* x y) (gcd x y))) (args) 2))

Potevamo calcolare la soluzione con:

(mcm 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20)
;-> 232792560


==========
Problema 6
==========

Somma quadrati differenza

La somma dei quadrati dei primi dieci numeri naturali vale,

1^2 + 2^2 + ... + 10^2 = 385

Il quadrato della somma dei primi dieci numeri naturali vale,

(1 + 2 + ... + 10)^2 = 55^2 = 3025

Quindi la differenza tra la somma dei quadrati e il quadrato della somma dei primi dieci numeri naturali vale 3025 − 385 = 2640.

Trovare la differenza tra la somma dei quadrati e il quadrato della somma dei primi cento numeri naturali.
============================================================================

I primi dieci numeri li otteniamo da:

(setq num (sequence 1 10))
;-> (1 2 3 4 5 6 7 8 9 10)

La loro somma vale:

(setq sum (apply add num))
;-> 55

Il quadrato della somma vale:

(setq qs (* sum sum))
;-> 3025

La somma dei quadrati vale:

(setq sq (apply add (map * num num)))

Nota che:

(setq lst (sequence 1 10))
(map * lst lst)
;-> (1 4 9 16 25 36 49 64 81 100)
(map * lst lst lst)
;-> (1 8 27 64 125 216 343 512 729 1000)

La loro differenza vale:

(sub qs sq)
;-> 2640

Scriviamo la funzione:

(define (e006)
  (setq num (sequence 1 100))
  (setq sum (apply add num))
  (setq qs (* sum sum))
  (setq sq (apply add (map * num num)))
  (sub qs sq)
)

(e006)
;-> 25164150

(time (e006))
;-> 0

Soluzione alternativa:

(define (e006)
    (let (lst (sequence 1 100))
        (- (pow (apply + lst)) (apply + (map * lst lst))) )
)


==========
Problema 7
==========

Il 10001-esimo numero primo

Elencando i primi sei numeri primi: 2, 3, 5, 7, 11, e 13, si nota che il sesto primo è 13.

Qual'è il 10001-esimo numero primo?
============================================================================

La soluzione con la forza bruta è semplice, cerchiamo progressivamente tutti i numeri primi partendo dal primo fino ad arrivare al 10001 numero primo:

(define (e007)
  (setq cnt 1 n 3) ; partiamo da 3 (il numero 2 è primo)
  (while (!= 10001 cnt)
      (if (isprime? n) (setq cnt (+ cnt 1))) ; se è un numero primo incrementiamo il conto
      (setq n (+ n 2)) ; non consideriamo i numeri pari
  )
  (- n 2)
)

(e007)
;-> 104743

(time (e007))
;-> 78.133


==========
Problema 8
==========

Il maggior prodotto in una serie

Le quattro cifre adiacenti che hanno il più grande prodotto nel numero da 1000 cifre riportato di seguito sono 9 × 9 × 8 × 9 = 5832.

73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450

Trovare, nel numero da 1000 cifre, le tredici cifre adiacenti che hanno il più grande prodotto. Qual'è il valore di questo numero ?
============================================================================

Assegniamo il numero ad una variabile di tipo stringa:

(set 'x "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")

(length x)
;-> 1000

Possiamo anche assegnare la variabile in un altro modo:

; elimina gli spazi (line-feeds)
(setq x (replace "\\s+" [text]
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
[/text] "" 0))

(length x)
;-> 1000

Dividiamo la stringa in blocchi da 13 caratteri (con passo 1 da 0 a 987):

(slice (explode x) 0 5) ; 5 al posto di 13
;-> ("7" "3" "1" "6" "7")

(setq a (map (fn (i) (slice (explode x) i 5))
             (sequence 0 4))) ; 4 al posto di 987

;-> (("7" "3" "1" "6" "7")
;->  ("3" "1" "6" "7" "1")
;->  ("1" "6" "7" "1" "7")
;->  ("6" "7" "1" "7" "6")
;->  ("7" "1" "7" "6" "5"))

(setq b (map join a))
;-> ("73167" "31671" "16717" "67176" "71765")

Mettiamo tutto insieme:

(setq c (map join (map (fn (i) (slice (explode x) i 5))
                       (sequence 0 4))))

;-> ("73167" "31671" "16717" "67176" "71765")

Convertiamo ogni carattere del blocco in integer:

(map explode c)
;-> (("7" "3" "1" "6" "7")
;->  ("3" "1" "6" "7" "1")
;->  ("1" "6" "7" "1" "7")
;->  ("6" "7" "1" "7" "6")
;->  ("7" "1" "7" "6" "5"))

(setq d (map (fn (i) (map int i)) (map explode c)))
;-> ((7 3 1 6 7) (3 1 6 7 1) (1 6 7 1 7) (6 7 1 7 6) (7 1 7 6 5))

Adesso moltiplichiamo tra loro i numeri in ogni sottolista:

(setq e (map (fn (i) (apply * i)) d))
;-> (882 126 294 1764 1470)

Infine troviamo il valore massimo delle moltiplicazioni:

(apply max e)
;-> 1764

Possiamo scrivere la funzione:

(define (e008)
  (set 'x "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450")
  ;(setq a (map join (map (fn (i) (slice (explode x) i 4)) ; for test: 5832
  ;                       (sequence 0 996))))
  (setq a (map join (map (fn (i) (slice (explode x) i 13)); for final result
                         (sequence 0 987))))
  (setq b (map (fn (i) (map int i)) (map explode a)))
  (setq c (map (fn (i) (apply * i)) b))
  (setq _res (apply max c))
  (println (nth (ref _res c) b)) ;-> (5 5 7 6 6 8 9 6 6 4 8 9 5)
  ;(println (last b)) ;-> (0 4 2 0 7 5 2 9 6 3 4 5 0)
  _res
)

(e008) ; con il valore 4 di test
;-> 5832

(e008) ; con il valore 13
;-> (5 5 7 6 6 8 9 6 6 4 8 9 5)
;-> 23514624000

(* 5 5 7 6 6 8 9 6 6 4 8 9 5)
;-> 23514624000

(time (e008))
;-> 109.557


==========
Problema 9
==========

Triple Pitagoriche speciali

Una tripla pitagorica è un insieme di tre numeri naturali, a < b < c, per cui risulta,

a^2 + b^2 = c^2

Per esempio, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

Esiste solo una tripla pitagorica per cui risulta: a + b + c = 1000.

Trovare il prodotto a*b*c.
============================================================================

(define (e009)
    (catch
      (for (a 1 1000)
        (for (b a 1000)
            (let (c (sqrt (+ (pow a) (pow b))))
                (when (and
                      (= (add a b c) 1000)
                      (< a b c)) ; a < b < c
                    (println a { } b { } c)
                    (throw (* a b c))
                 )
             )
         )
      )
    )
)

(e009)
;-> 200 375 425
;-> 31875000

(time (e009))
;-> 62.491


===========
Problema 10
===========

Sommatoria dei numeri primi

La somma dei numeri primi minori di 10 vale 2 + 3 + 5 + 7 = 17.

Trovare la somma di tutti i primi minori di 2 milioni.
============================================================================

(sequence 2 10)
;-> (2 3 4 5 6 7 8 9 10)

(isprime? 2)
;-> true

(filter isprime? (sequence 2 10))
;-> (2 3 5 7)

(filter isprime? (sequence 2 1000))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97 101 103 107
;->  109 113 127 131 137 139 149 151 157 163 167 173 179 181 191 193 197 199 211 223
;->  227 229 233 239 241 251 257 263 269 271 277 281 283 293 307 311 313 317 331 337
;->  347 349 353 359 367 373 379 383 389 397 401 409 419 421 431 433 439 443 449 457
;->  461 463 467 479 487 491 499 503 509 521 523 541 547 557 563 569 571 577 587 593
;->  599 601 607 613 617 619 631 641 643 647 653 659 661 673 677 683 691 701 709 719
;->  727 733 739 743 751 757 761 769 773 787 797 809 811 821 823 827 829 839 853 857
;->  859 863 877 881 883 887 907 911 919 929 937 941 947 953 967 971 977 983 991 997)

(apply add (filter isprime? (sequence 2 10)))
;-> 17

(apply add (filter isprime? (sequence 2 10000)))
;-> 5736396

(apply add (filter isprime? (sequence 2 2000000)))
;-> 142913828922

(time (apply add (filter isprime? (sequence 2 2000000))))
;-> 2265.831

(+ 2 (apply + (filter isprime? (sequence 3 2000000 2 ))))
;-> 142913828922

(time (+ 2 (apply + (filter isprime? (sequence 3 2000000 2 )))))
;-> 1893.077

Proviamo con una funzione iterativa:

(define (e010)
    (let (somma 2)
        (for (i 3 1999999 2)
            (if (= 1 (length (factor i)))
                (setq somma (+ somma i)))
        )
        somma
    )
)

(e010)
;-> 142913828922

(time (e010))
;-> 1562.567


===========
Problema 11
===========

Il più grande prodotto in una griglia

Nella griglia 20 × 20 seguente, quattro numeri lungo una linea diagonale sono stati racchiusi con i caratteri > < (es. >26<).

08  02  22  97  38  15  00  40  00  75  04  05  07  78  52  12  50  77  91  08
49  49  99  40  17  81  18  57  60  87  17  40  98  43  69  48  04  56  62  00
81  49  31  73  55  79  14  29  93  71  40  67  53  88  30  03  49  13  36  65
52  70  95  23  04  60  11  42  69  24  68  56  01  32  56  71  37  02  36  91
22  31  16  71  51  67  63  89  41  92  36  54  22  40  40  28  66  33  13  80
24  47  32  60  99  03  45  02  44  75  33  53  78  36  84  20  35  17  12  50
32  98  81  28  64  23  67  10 >26< 38  40  67  59  54  70  66  18  38  64  70
67  26  20  68  02  62  12  20  95 >63< 94  39  63  08  40  91  66  49  94  21
24  55  58  05  66  73  99  26  97  17 >78< 78  96  83  14  88  34  89  63  72
21  36  23  09  75  00  76  44  20  45  35 >14< 00  61  33  97  34  31  33  95
78  17  53  28  22  75  31  67  15  94  03  80  04  62  16  14  09  53  56  92
16  39  05  42  96  35  31  47  55  58  88  24  00  17  54  24  36  29  85  57
86  56  00  48  35  71  89  07  05  44  44  37  44  60  21  58  51  54  17  58
19  80  81  68  05  94  47  69  28  73  92  13  86  52  17  77  04  89  55  40
04  52  08  83  97  35  99  16  07  97  57  32  16  26  26  79  33  27  98  66
88  36  68  87  57  62  20  72  03  46  33  67  46  55  12  32  63  93  53  69
04  42  16  73  38  25  39  11  24  94  72  18  08  46  29  32  40  62  76  36
20  69  36  41  72  30  23  88  34  62  99  69  82  67  59  85  74  04  36  16
20  73  35  29  78  31  90  01  74  31  49  71  48  86  81  16  23  57  05  54
01  70  54  71  83  51  54  69  16  92  33  48  61  43  52  01  89  19  67  48

Il prodotto di questi numeri vale 26 × 63 × 78 × 14 = 1788696.

Qual'è il valore più grande del prodotto di quattro numeri adiacenti nella stessa direzione (su, giù, sinistra, destra o diagonalmente) nella griglia 20 × 20?
============================================================================

(setq grid
'( 8  2 22 97 38 15  0 40  0 75  4  5  7 78 52 12 50 77 91  8
  49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48  4 56 62  0
  81 49 31 73 55 79 14 29 93 71 40 67 53 88 30  3 49 13 36 65
  52 70 95 23  4 60 11 42 69 24 68 56  1 32 56 71 37  2 36 91
  22 31 16 71 51 67 63 89 41 92 36 54 22 4  40 28 66 33 13 80
  24 47 32 60 99  3 45  2 44 75 33 53 78 36 84 20 35 17 12 50
  32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
  67 26 20 68  2 62 12 20 95 63 94 39 63  8 40 91 66 49 94 21
  24 55 58  5 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
  21 36 23  9 75  0 76 44 20 45 35 14  0 61 33 97 34 31 33 95
  78 17 53 28 22 75 31 67 15 94  3 80  4 62 16 14  9 53 56 92
  16 39  5 42 96 35 31 47 55 58 88 24  0 17 54 24 36 29 85 57
  86 56  0 48 35 71 89  7  5 44 44 37 44 60 21 58 51 54 17 58
  19 80 81 68  5 94 47 69 28 73 92 13 86 52 17 77  4 89 55 40
   4 52  8 83 97 35 99 16  7 97 57 32 16 26 26 79 33 27 98 66
  88 36 68 87 57 62 20 72  3 46 33 67 46 55 12 32 63 93 53 69
   4 42 16 73 38 25 39 11 24 94 72 18  8 46 29 32 40 62 76 36
  20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74  4 36 16
  20 73 35 29 78 31 90  1 74 31 49 71 48 86 81 16 23 57  5 54
   1 70 54 71 83 51 54 69 16 92 33 48 61 43 52  1 89 19 67 48))

(length grid)
;-> 400

(define (right i)
  (setq r (slice grid i 4))
  (apply * r))

(define (down i)
  (setq d (select grid i (+ i 20) (+ i 40) (+ i 60)))
  (apply * d))

(define (diag-down-right i)
  (setq dr (select grid i (+ i 21) (+ i 42) (+ i 63)))
  (apply * dr))

(define (diag-down-left i)
  (setq dl (select grid i (+ i 19) (+ i 38) (+ i 57)))
  (apply * dl))

(define (e011)
  (setq down-max (apply max (map (fn (x) (down x)) (sequence 0 339))))
  (setq diag-down-left-max (apply max (map (fn (x) (diag-down-left x)) (sequence 3 339))))
  (setq diag-down-right-max (apply max (map (fn (x) (diag-down-right x)) (sequence 0 333))))
  (max down-max diag-down-left-max diag-down-left-max)
)

(e011)
;-> 70600674

(time (e011))
;-> 0


===========
Problema 12
===========

Numero triangolare altamente divisibile

La sequenza di numeri triangolari viene generata aggiungendo i numeri naturali. Quindi il settimo numero di triangolo sarebbe 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. I primi dieci termini sarebbero:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

Cerchiamo di elencare i fattori dei primi sette numeri di triangolo:

  1: 1
  3: 1,3
  6: 1,2,3,6
10: 1,2,5,10
15: 1,3,5,15
21: 1,3,7,21
28: 1,2,4,7,14,28

Possiamo vedere che 28 è il primo numero di triangolo ad avere più di cinque divisori.

Qual'è il valore del primo numero di triangolo per avere oltre cinquecento divisori?
============================================================================

Funzione che calcola l'n-esimo numero triangolare:

(define (numtri n) (/ (+ (* n n) n) 2))
;-> (numtri 1)
;-> 1
;-> (numtri 2)
;-> 3
;-> (numtri 3)
;-> 6
;-> (numtri 4)
;-> 10

Funzione cha calcola il numero di divisori di un numero n:

(define (numdivisors n)
  (local (ndiv)
    (setq ndiv 0)
    (for (i 1 (+ n 1))
      (if (zero? (mod (div n i) 1) 0) (++ ndiv))
      ;(if (= (mod (div n i) 1) 0) (begin (++ ndiv) (println i)))
    )
    ndiv
  )
)

(numdivisors 10) ;(1 2 5 10)
;-> 4

(numdivisors 64) ;(1 2 4 8 16 32 64)
;-> 7

(define (e012)
  (let (look true)
    (for (i 1 99999 2 (not look))
      (if (> (* (numdivisors i) (numdivisors (div (numtri i) i))) 500)
        (begin
          (println "i = " i {; }
                   "tri = " (numtri i) {; }
                   "divisori = " (* (numdivisors i) (numdivisors (div (numtri i) i))))
          (setq look false)
        )
      )
    )
  )
)

(e012)
;-> i = 12375; tri = 76576500; divisori = 576
;-> true

(time (e012))
;-> 5444.521


===========
Problema 13
===========

Grande somma

Calcolare le prime dieci cifre della somma dei seguenti cento numeri di 50 cifre ognuno.
============================================================================

Suddividiamo la lista da 100 numeri in due liste da 50 numeri per evitare il limite dei 2048 caratteri che newLISP pone alla lunghezza di una espressione.

(setq numeriA '(
 37107287533902102798797998220837590246510135740250L
 46376937677490009712648124896970078050417018260538L
 74324986199524741059474233309513058123726617309629L
 91942213363574161572522430563301811072406154908250L
 23067588207539346171171980310421047513778063246676L
 89261670696623633820136378418383684178734361726757L
 28112879812849979408065481931592621691275889832738L
 44274228917432520321923589422876796487670272189318L
 47451445736001306439091167216856844588711603153276L
 70386486105843025439939619828917593665686757934951L
 62176457141856560629502157223196586755079324193331L
 64906352462741904929101432445813822663347944758178L
 92575867718337217661963751590579239728245598838407L
 58203565325359399008402633568948830189458628227828L
 80181199384826282014278194139940567587151170094390L
 35398664372827112653829987240784473053190104293586L
 86515506006295864861532075273371959191420517255829L
 71693888707715466499115593487603532921714970056938L
 54370070576826684624621495650076471787294438377604L
 53282654108756828443191190634694037855217779295145L
 36123272525000296071075082563815656710885258350721L
 45876576172410976447339110607218265236877223636045L
 17423706905851860660448207621209813287860733969412L
 81142660418086830619328460811191061556940512689692L
 51934325451728388641918047049293215058642563049483L
 62467221648435076201727918039944693004732956340691L
 15732444386908125794514089057706229429197107928209L
 55037687525678773091862540744969844508330393682126L
 18336384825330154686196124348767681297534375946515L
 80386287592878490201521685554828717201219257766954L
 78182833757993103614740356856449095527097864797581L
 16726320100436897842553539920931837441497806860984L
 48403098129077791799088218795327364475675590848030L
 87086987551392711854517078544161852424320693150332L
 59959406895756536782107074926966537676326235447210L
 69793950679652694742597709739166693763042633987085L
 41052684708299085211399427365734116182760315001271L
 65378607361501080857009149939512557028198746004375L
 35829035317434717326932123578154982629742552737307L
 94953759765105305946966067683156574377167401875275L
 88902802571733229619176668713819931811048770190271L
 25267680276078003013678680992525463401061632866526L
 36270218540497705585629946580636237993140746255962L
 24074486908231174977792365466257246923322810917141L
 91430288197103288597806669760892938638285025333403L
 34413065578016127815921815005561868836468420090470L
 23053081172816430487623791969842487255036638784583L
 11487696932154902810424020138335124462181441773470L
 63783299490636259666498587618221225225512486764533L
 67720186971698544312419572409913959008952310058822L ))

(setq numeriB '(
 95548255300263520781532296796249481641953868218774L
 76085327132285723110424803456124867697064507995236L
 37774242535411291684276865538926205024910326572967L
 23701913275725675285653248258265463092207058596522L
 29798860272258331913126375147341994889534765745501L
 18495701454879288984856827726077713721403798879715L
 38298203783031473527721580348144513491373226651381L
 34829543829199918180278916522431027392251122869539L
 40957953066405232632538044100059654939159879593635L
 29746152185502371307642255121183693803580388584903L
 41698116222072977186158236678424689157993532961922L
 62467957194401269043877107275048102390895523597457L
 23189706772547915061505504953922979530901129967519L
 86188088225875314529584099251203829009407770775672L
 11306739708304724483816533873502340845647058077308L
 82959174767140363198008187129011875491310547126581L
 97623331044818386269515456334926366572897563400500L
 42846280183517070527831839425882145521227251250327L
 55121603546981200581762165212827652751691296897789L
 32238195734329339946437501907836945765883352399886L
 75506164965184775180738168837861091527357929701337L
 62177842752192623401942399639168044983993173312731L
 32924185707147349566916674687634660915035914677504L
 99518671430235219628894890102423325116913619626622L
 73267460800591547471830798392868535206946944540724L
 76841822524674417161514036427982273348055556214818L
 97142617910342598647204516893989422179826088076852L
 87783646182799346313767754307809363333018982642090L
 10848802521674670883215120185883543223812876952786L
 71329612474782464538636993009049310363619763878039L
 62184073572399794223406235393808339651327408011116L
 66627891981488087797941876876144230030984490851411L
 60661826293682836764744779239180335110989069790714L
 85786944089552990653640447425576083659976645795096L
 66024396409905389607120198219976047599490197230297L
 64913982680032973156037120041377903785566085089252L
 16730939319872750275468906903707539413042652315011L
 94809377245048795150954100921645863754710598436791L
 78639167021187492431995700641917969777599028300699L
 15368713711936614952811305876380278410754449733078L
 40789923115535562561142322423255033685442488917353L
 44889911501440648020369068063960672322193204149535L
 41503128880339536053299340368006977710650566631954L
 81234880673210146739058568557934581403627822703280L
 82616570773948327592232845941706525094512325230608L
 22918802058777319719839450180888072429661980811197L
 77158542502016545090413245809786882778948721859617L
 72107838435069186155435662884062257473692284509516L
 20849603980134001723930671666823555245252804609722L
 53503534226472524250874054075591789781264330331690L ))

(length numeriA)
;-> 50
(length numeriB)
;-> 50

(apply + numeriA)
;-> 2739840008414248713350123647779193919724097856798098L

(apply + numeriB)
;-> 2797536221976627923951925099053792052049561975094574L

(+ (apply + numeriA) (apply + numeriB))

(define (e013)
  (slice (string (+ (apply + numeriA) (apply + numeriB))) 0 10))

(e013)
;-> "5537376230"

Il numero  completo vale:
5537376230390876637302048746832985971773659831892672L

(time (e013))
;-> 0


===========
Problema 14
===========

La sequenza di Collatz più lunga

La seguente sequenza iterativa è definita per l'insieme di numeri interi positivi:

n = 1 -> stop
n -> n / 2 (n è pari)
n -> 3 * n + 1 (n è dispari)

Usando la regola sopra e iniziando con 13, generiamo la seguente sequenza:
13 40 20 10 5 16 8 4 2 1
Si può vedere che questa sequenza (che inizia a 13 e finisce a 1) contiene 10 termini.
Anche se non è stato ancora dimostrato (Collatz Problem), si ritiene che tutti i numeri iniziali conducano al numero 1.

Quale numero iniziale, inferiore a un milione, produce la catena più lunga?

NOTA: una volta avviata la sequenza, i termini possono superare il milione.
============================================================================

Scriviamo una funzione che costruisce la sequenza di Collatz per un numero n:

(define (collatz n)
  (if (= n 1) '(1)
    (cons n (collatz (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

Poi scriviamo una funzione che calcola la lunghezza della sequenza di Collatz di un numero n:

(define (collatz-lenght n)
  (length (collatz n))
)

(collatz 24)
;-> (24 12 6 3 10 5 16 8 4 2 1)

(collatz-lenght 24)
;-> 11

Utilizzando le due funzioni direttamente (senza alcun tipo di ottimizzazione) possiamo scrivere la seguente soluzione:

(define (e014)
  (local (maxlun out num)
    (setq maxlun 0)
    (setq out '())
    (setq num 0)
    (for (i 1 1000000)
      (if (> (length (collatz i)) maxlun)
          (begin
            (setq maxlun (length (collatz i)))
            (setq num i)
          )
      )
    )
    (list num maxlun)
  )
)

Questa funzione è molto lenta...

(e014)
;-> (837799 525)

(time (e014))
;-> 107039.434 ; 107 secondi

Proviamo a scrivere una funzione unica che calcola la lunghezza di collatz senza costruire la lista:

(define (e014)
  (local (maxlun lun num c)
    (setq maxlun 0)
    (setq num 0)
    (for (i 1 1000000)
      (setq c i)
      (setq lun 1)
      ; calcolo della lunghezza della sequenza
      (while (!= c 1)
         (if (even? c) (setq c (/ c 2))
                       (setq c (+ 1 (* 3 c)))
         )
         (inc lun)
      )
      (if (> lun maxlun) ; se la sequenza è più lunga di quella massima,
          (begin         ; allora aggiorno il valore massimo e il relativo numero di collatz
            (setq maxlun lun)
            (setq num i)
          )
      )
    )
    (list num maxlun)
  )
)

(e014)
;-> (837799 525)

(time (e014))
;-> 22486.695 ; 22.4 secondi


===========
Problema 15
===========

Percorsi in una griglia

Partendo dall'angolo in alto a sinistra di una griglia 2 × 2, e potendo solo spostarsi verso destra e verso il basso, ci sono esattamente 6 percorsi diversi per raggiungere l'angolo in basso a destra.

Quanti percorsi ci sono attraverso una griglia 20 × 20?
P==============

Quello che ci interessa è la distanza tra le coordinate di inizio e fine, cioè la dimensione della griglia: 20.

Possiamo scrivere una funzione ricorsiva che utilizza questo valore di distanza per calcolare il numero totale dei percorsi (minimi) tra i due punti.
Poichè ogni volta ci dobbiamo muovere a destra o verso il basso possiamo richiamare la stesse funzioni con uno dei parametri (destra o basso) diminuito di 1. Queste funzioni vengono richiamate tante volte quanto vale la distanza tra le coordinate. Facendo la somma dei risultati di queste funzioni otteniamo il numero di percorsi (minimi) tra le coordinate di inizio e fine della griglia.

La funzione ricorsiva per il calcolo dei percorsi è la seguente:

(define (numPercorsi basso destra);
    (if (or (= basso 0) (= destra 0)) 1
        (+ (numPercorsi (- basso 1) destra)
           (numPercorsi basso (- destra 1)))
    )
)

(numPercorsi 2 2)
;-> 6

(numPercorsi 10 10)
;-> 184756

(time (numPercorsi 20 20))

Purtroppo questa funzione è molto lenta (O(2^n)) quindi dobbiamo utilizzare un'altro metodo. Dal punto di vista matematico, il numero di percorsi in una griglia dal punto (0,0) al punto (n,m) è uguale al coefficiente binomiale:

(n + m)      (n + m)!
        = -------------
(  n  )      n! * m!
                          (2*n)    (2*n)!    (40)      40!
Nel nostro caso diventa:        = -------- =      = ---------
                          ( n )    (n!)^2    (20)    (20!)^2

Definiamo la funzione fattoriale:

(define (fact n) (apply * (map bigint (sequence 1 n))))

Calcoliamo il numero di persorsi:

(define (e015)
  (div (fact 40) (mul (fact 20) (fact 20)))
)

(e015)
;-> 137846528820

(time (e015))
;-> 0


===========
Problema 16
===========

Somma cifre di una potenza

215 = 32768 e la somma delle sue cifre vale 3 + 2 + 7 + 6 + 8 = 26.

Quanto vale la somma delle cifre del numero 2^1000?
============================================================================

(Definiamo una funzione che calcola la potenza di un numero intero (big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
)

(potenza 3 50)
;-> 717897987691852588770249L

(define (e016)
  (setq num (potenza 2 1000))
  (setq n$ (string num))
  (setq n$ (slice n$ 0 (- (length n$) 1)))
  (apply + (map int (explode n$)))
)

(e016)
;-> 1366

(time (e016))
;-> 0


===========
Problema 17
===========

Contare il numero di lettere

Se i numeri da 1 a 5 sono scritti con le parole inglesi:
one, two, three, four, five allora sono state usate
 3  +  3  +  5  +  4  +  4 = 19 lettere in totale.

Se tutti i numeri da 1 a 1000 (one thousand) incluso fossero scritti con le parole inglesi, quante lettere occorrerebbe usare?

NOTA: non contare spazi o trattini. Ad esempio, 342 (three hundred and forty-two) contiene 23 lettere e 115 (one hundred and fifteen) contiene 20 lettere. L'uso di "and" quando si scrivono numeri è conforme all'uso britannico.
============================================================================

La soluzione è tediosa.

(setq n1-19 '("" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))

(setq n20-90 '("" "" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety"))

(setq n100 "hundred")

; gli spazi non contano
(setq n100and "hundredand")

(setq n1000 "onethousand")

(define (e017)
  (local (n1-9 n10-19 n20-99 n100-999)
    (setq n1-9 (apply + (map length (1 9 n1-19))))
    (setq n10-19 (apply + (map length (10 19 n1-19))))
    (setq n20-99 (+ (* 10 (apply + (map length (2 9 n20-90))))
                    (* 8 n1-9)))
    (setq n100-999 (+ (* 100 (+ n1-9))
                      (* 9 (+ n1-9 n10-19 n20-99))
                            (* 9 (length n100))
                            (* 9 99 (length n100and))))
    (+ n1-9 n10-19 n20-99 n100-999 (length n1000))
  )
)

(e017)
;-> 21124


===========
Problema 18
===========

Percorso con somma massima

Iniziando dalla parte superiore del triangolo in basso e passando ai numeri adiacenti sulla riga sottostante, il totale massimo dall'alto verso il basso è 23.

   3
  7 4
 2 4 6
8 5 9 3

Cioè, 3 + 7 + 4 + 9 = 23.

Trova il totale massimo dall'alto al basso del triangolo sottostante:

                            75
                          95 64
                        17 47 82
                      18 35 87 10
                    20 04 82 47 65
                  19 01 23 75 03 34
                88 02 77 73 07 63 67
              99 65 04 28 06 16 70 92
            41 41 26 56 83 40 80 70 33
          41 48 72 33 47 32 37 16 94 29
        53 71 44 65 25 43 91 52 97 51 14
      70 11 33 28 77 73 17 78 39 68 17 57
    91 71 52 38 17 14 91 43 58 50 27 29 48
  63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

NOTA: poiché ci sono solo 16384 percorsi, è possibile risolvere questo problema provando ogni percorso.
============================================================================

La seguente soluzione è veramente "brutale".

(define (e018)
  (local (a aa b bb c cc d dd e ee f ff g gg h hh i ii j jj k kk l ll m mm n nn o oo somma sommaMax)
    (setq triangle '((75) (95 64) (17 47 82) (18 35 87 10) (20 4 82 47 65) (19 1 23 75 3 34) (88 2 77 73 7 63 67) (99 65 4 28 6 16 70 92) (41 41 26 56 83 40 80 70 33) (41 48 72 33 47 32 37 16 94 29) (53 71 44 65 25 43 91 52 97 51 14) (70 11 33 28 77 73 17 78 39 68 17 57) (91 71 52 38 17 14 91 43 58 50 27 29 48) (63 66 4 68 89 53 67 30 73 16 69 87 40 31) (4 62 98 27 23 9 70 98 73 93 38 53 60 4 23)))
    (setq a (triangle 0))
    (setq b (triangle 1))
    (setq c (triangle 2))
    (setq d (triangle 3))
    (setq e (triangle 4))
    (setq f (triangle 5))
    (setq g (triangle 6))
    (setq h (triangle 7))
    (setq i (triangle 8))
    (setq j (triangle 9))
    (setq k (triangle 10))
    (setq l (triangle 11))
    (setq m (triangle 12))
    (setq n (triangle 13))
    (setq o (triangle 14))
    (setq sommaMax 0)
    (setq somma 0)
    (for (bb 0 (- (length b) 1))
     (for (cc bb (+ bb 1))
       (for (dd cc (+ cc 1))
        (for (ee dd (+ dd 1))
         (for (ff ee (+ ee 1))
          (for (gg ff (+ ff 1))
           (for (hh gg (+ gg 1))
            (for (ii hh (+ hh 1))
             (for (jj ii (+ ii 1))
              (for (kk jj (+ jj 1))
               (for (ll kk (+ kk 1))
                (for (mm ll (+ ll 1))
                 (for (nn mm (+ mm 1))
                  (for (oo nn (+ nn 1))
                   (setq somma (+ (a 0) (b bb) (c cc) (d dd) (e ee) (f ff) (g gg) (h hh)
                                  (i ii) (j jj) (k kk) (l ll) (m mm) (n nn) (o oo)))
                   (if (> somma sommaMax) (swap somma sommaMax))
    ))))))))))))))
    sommaMax
  );local
)

(e018)
;-> 1074

(time (e018))
;-> 31.248


===========
Problema 19
===========

Conteggio delle domeniche

Ti vengono fornite le seguenti informazioni, ma potresti ricercare altre informazioni per te stesso.

- Il 1 gennaio 1900 era un lunedì.
- Trenta dì conta Novembre
  con April, Giugno e Settembre.
  Di ventotto ce n'è uno,
  Tutti gli altri ne han trentuno.

Un anno bisestile si verifica quando è divisibile per 4, ma non per un secolo (00) a meno che non sia divisibile per 400.

Quante domeniche caddero il primo del mese durante il ventesimo secolo (dal 1° gennaio 1901 al 31 dicembre 2000)?
============================================================================

Usiamo l'algoritmo di Gauss per determinare il giorno della settimana:

(define (day-of-week year month day) ; 0..6 --> Sun..Sat
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

Adesso la soluzione è abbastanza semplice:

(define (e019)
  (local (somma)
    (setq somma 0)
    (for (anno 1901 1999)
      (for (mese 1 12)
        (if (zero? (day-of-week anno mese 1)) (++ somma))
      )
    )
    somma
  )
)

(e019)
;-> 171

(time (e019))
;-> 2.997


===========
Problema 20
===========

Somma di cifre fattoriali

n! significa n × (n - 1) × ... × 3 × 2 × 1

Ad esempio, 10! = 10 × 9 × ... × 3 × 2 × 1 = 3628800,
e la somma delle cifre nel numero 10! vale 3 + 6 + 2 + 8 + 8 + 0 + 0 = 27.

Trova la somma delle cifre nel numero 100!
============================================================================

Funzione fattoriale

(define (fact n) (apply * (map bigint (sequence 1 n))))

(explode (string (fact 10)))
;-> ("3" "6" "2" "8" "8" "0" "0" "L")

(map int (explode (string (fact 10))))
;-> (3 6 2 8 8 0 0 nil)

(define (e020)
  (apply + (map (fn (x) (int x 0)) (explode (string (fact 100)))))
)

(e020)
;-> 648

(time (e020))
;-> 0

Il creatore di newLISP (Lutz Mueller) ha scritto la seguente funzione che moltiplica due numeri interi passati come stringhe (è valida anche per numeri big-integer).

(define (big* x y) ; a and b are strings of decimal digits
    (letn ( nx (length x)
            ny (length y)
            np (+ nx ny)
            X (array nx (reverse (map int (explode x))))
            Y (array ny (reverse (map int (explode y))))
            Q (array (+ nx 1) (dup 0 (+ nx 1)))
            P (array np (dup 0 np))
            carry 0
            digit 0 )
        (dotimes (i ny) ; for each digit of the multiplier
            (dotimes (j nx) ; for each digit of the multiplicant
                (setq digit (+ (* (Y i) (X j)) carry) )
                (setq carry (/ digit 10))
                (setf (Q j) (% digit 10)) )
            (setf (Q nx ) carry)
            ; add Q to P shifted by i
            (setq carry 0)
            (dotimes (j (+ nx 1))
                (setq digit (+ (P (+ j i)) (Q j) carry))
                (setq carry (/ digit 10))
                (setf (P (+ j i)) (% digit 10)) )
        )
    ; translate P to string and return
    (setq P (reverse (array-list P)))
    (if (zero? (P 0)) (pop P))
    (join (map string P))
    )
)

Con la seguente soluzione al problema:

(define (e020-Lutz)
    (let (result "1")
        (for (i 2 100)
            (setq result (big* result (string i))))
        (apply + (map int (explode result))))
)

(e020-Lutz)
;-> 648

(time (e020-Lutz))
;-> 32.948


===========
Problema 21
===========

Numeri Amicabili

Definiamo d(n) come la somma dei divisori propri di n (tutti i numeri minori di n che dividono esattamente n).

Se d(a) = b e d(b) = a, dove a ≠ b,, allora a e b sono una coppia amicabile e a e b sono chiamati singolarmente numeri amicabili.

Per esempio, i divisori propri di 220 sono 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 e 110: quindi d(n) = 284. I divisori propri di 284 sono 1, 2, 4, 71 e 142: così d(284) = 220.

Calcolare la somma di tutti i numeri amicabili inferiori a 10000.
============================================================================

Definiamo la funzione che calcola la somma dei divisori di un numero:

(define (sum-divisors n)
  (setq res 0)
  (setq m (sqrt n))
  (setq i 2)
  (while (<= i m)
      (if (zero? (% n i))   ; se 'i' è divisore di 'n'
          (if (= i (/ n i))              ; se entrambi i divisori sono uguali...
            (setq res (+ res i))         ; allora aggiungilo una volta,
            (setq res (+ res i (/ n i))) ; altrimenti aggiungili entrambi.
          )
      )
      (setq i (+ i 1))
  )
  res
)

(sum-divisors 10)
;-> 7

Adesso dobbiamo definire la funzione che calcola i divisori propri:

(define (sum-proper-divisors n)
  (+ 1 (sum-divisors n))
)

(sum-proper-divisors 10)
;-> 8
(sum-proper-divisors 3)
;-> 1

(sum-proper-divisors 18)
;-> 21

(sum-proper-divisors 220)
;-> 284
(sum-proper-divisors 284)
;-> 220

Adesso scriviamo la funzione che calcola i numeri amicabili:

(define (e021)
  (setq _res 0)
  (for (j 1 9999)
      (setq spd (sum-proper-divisors j))
      (setq spd2 (sum-proper-divisors spd))
      (if (and (= j spd2) (!= spd spd2))
            (begin
              (setq _res (+ _res spd spd2))
              ;(println j { } spd { } spd2)
            )
      )
  )
  (/ _res 2)
)

(e021)
;-> 220 284 220
;-> 284 220 284
;-> 1184 1210 1184
;-> 1210 1184 1210
;-> 2620 2924 2620
;-> 2924 2620 2924
;-> 5020 5564 5020
;-> 5564 5020 5564
;-> 6232 6368 6232
;-> 6368 6232 6368
;-> 31626

(time (e021))
;-> 220.022

Una soluzione più efficiente si ottiene usando la seguente formula:
Siano p1, p2, … pk i fattori primi del numero n.
Siano a1, a2, .. ak le potenze massime rispettivamente di p1, p2, .. pk che dividono n (es. n = (p1^a1)*(p2^a2)*...*(pk^ak)).

Somma dei divisori = (1 + p1 + p1^2 ... p1^a1) *
                     (1 + p2 + p2^2 ... p2^a2) *
                     ......................... *
                     (1 + pk + pk^2 ... pk^ak)

Notiamo che i termini individuali di questa formula sono progressioni geometriche.
Possiamo riscrivere la formula come:

Somma dei divisori = (p1^(a1+1) - 1)/(p1 - 1) *
                     (p2^(a2+1) - 1)/(p2 - 1) *
                     ........................ *
                     (pk^(ak+1) - 1)/(pk - 1)

Vediamo un'applicazione della formula:

Consideriamo il numero 18.

(factor 18)
;-> (2 3 3)

Somma dei divisori = 1 + 2 + 3 + 6 + 9 + 18
(+ 1 2 3 6 9 18)
;-> 39

Scrivendo i divisori come potenze dei fattori primi otteniamo:

Somma di divisori = (2^0)(3^0) + (2^1)(3^0) + (2^0)(3^1) +
                    (2^1)(3^1) + (2^0)(3^2) + (2^1)(3^2)
                  = (2^0)(3^0) + (2^0)(3^1) + (2^0)(3^2) +
                    (2^1)(3^0) + (2^1)(3^1) + (2^1)(3^2)
                  = (2^0)(3^0 + 3^1 + 3^2) +
                    (2^1)(3^0 + 3^1 + 3^2)
                  = (2^0 + 2^1)(3^0 + 3^1 + 3^2)

Guardando attentamente, possiamo notare che l'ultima espressione è del tipo:

(1 + p1) * (1 + p2 + p2^2)

dove p1 = 2, p2 = 3.

Quindi: (1 + 2) * (1 + 3 + 9) = 3*13 = 39

Per trovare la somma dei divisori di un numero è sufficiente conoscere la sua scomposizione in fattori primi e applicare la seguente formula:

Somma dei divisori = Prod [(1 + f(i)^1 + ... + f(i)^k(i)]

dove [f(i), k(i)] è il fattore i-esimo con f = valore del fattore e k = potenza del fattore
e l'indice i varia da 1 al numero dei fattori.

Per trovare la somma dei divisori propria di un numero, basta sottrarre il numero stesso alla somma dei divisori ottenuta con la formula.

Esempio:

(fattorizza 18)
;-> ((2 1) (3 2))

somma dei divisori = (1 + p1 + p1^2 ... p1^a1) * (1 + p2 + p2^2 ... p2^a2) =
= (1 + 2) * (1 + 3 + 3^2) = 3 * 13 = 39

somma dei divisori propri = somma dei divisori - n = 39 - 18 = 21

Esempio:

(fattorizza 220)
;-> ((2 2) (5 1) (11 1))

p1 = 2  a1 = 2
p2 = 5  a2 = 1
p3 = 11 a3 = 1

(p1^(a1+1) - 1)/(p1 - 1) = (2^3 - 1)/(2 - 1) = 7
(p2^(a2+1) - 1)/(p2 - 1) = (5^2 - 1)/(5 - 1) = 6
(p3^(a3+1) - 1)/(p3 - 1) = (11^2 - 1)/(11 - 1) = 12

(* 6 7 12)
;-> 504

(- 504 220)
;-> 284 ; somma dei divisori propri di 220

Adesso possiamo scrivere la funzione che calcola i numeri amicabili:

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

(factor-group 220)
;-> ((2 2) (5 1) (11 1))

(factor-group 1)
;-> (1 1)

(define (somma-divisori-propri-fast n)
  (if (= n 1) '0
    (begin (setq res 1)
     (setq lst (factor-group n))
     (dolist (el lst)
       (setq somma-el 0)
       (for (i 0 (last el))
         (setq somma-el (+ somma-el (pow (first el) i)))
       )
       (setq res (* res somma-el))
     )
     (- res n)) ;somma divisori propri (tutti tranne se stesso)
  )
)

(somma-divisori-propri-fast 220)
;-> 284

(somma-divisori-propri-fast 284)
;-> 220

(somma-divisori-propri-fast 1)
;-> 0

Scriviamo la funzione richiesta dal problema:

(define (e021-fast)
  (setq _res 0)
  (for (j 2 9999)
      (setq spd (somma-divisori-propri-fast j))
      (setq spd2 (somma-divisori-propri-fast spd))
      (if (and (= j spd2) (!= spd spd2))
            (begin
              (setq _res (+ _res spd spd2))
              ;(println j { } spd { } spd2)
            )
      )
  )
  (/ _res 2)
)

(e021-fast)
;-> 31626

(time (e021-fast))
;-> 122.883

la funzione "e021-fast" è tre volte più veloce della funzione "e021".


===========
Problema 22
===========

Punteggio dei nomi

Usando "names.txt", un file di testo 46K contenente oltre cinquemila nomi, inizia crando una lista dei nomi in ordine alfabetico. Quindi, calcolando il valore alfabetico per ciascun nome, moltiplica questo valore per la sua posizione alfabetica nella lista per ottenere un punteggio del nome.

Ad esempio, quando la lista è ordinata in ordine alfabetico, COLIN, che vale 3 + 15 + 12 + 9 + 14 = 53, è il 938-esimo nome nell'elenco. Quindi, COLIN otterrebbe un punteggio di 938 × 53 = 49714.

Qual è il totale di tutti i punteggi dei nomi contenuti nel file?
============================================================================

Il file ha questa struttura:
"MARY","PATRICIA","LINDA",...

Rimuoviamo tutti i caratteri doppio-apice "":

(define (remove-char c from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (if (!= chr c)
          (write-char out-file chr)))
    (close in-file)
    (close out-file)
    "fatto")

(char {"})
;-> 34

(char 34)
;-> "\""

(remove-char 34 "p022_nomi.txt" "nomi22.txt")

Il file adesso ha questa struttura:

MARY,PATRICIA,LINDA,...

Importiamo il file in una lista di stringhe:

(silent (setq nomi (parse (read-file "nomi22.txt") ",")))

Vediamo i primi cinque nomi:

(slice nomi 0 5)
;-> ("MARY" "PATRICIA" "LINDA" "BARBARA" "ELIZABETH")

Ordiniamo la lista:

(silent (sort nomi))

Vediamo i primi cinque nomi:

(slice nomi 0 5)
;-> ("AARON" "ABBEY" "ABBIE" "ABBY" "ABDUL")

Vediamo dove si trova "COLIN":

(ref "COLIN" nomi )
;-> 937

Quindi dobbiamo aggiungere 1 all'indice della lista (+ $idx 1).
Adesso creiamo una lista associativa (association list) tra i caratteri e il numero del relativo ordine.

(setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))

(lookup '"A" alfa)
;-> 1

(define (e022)
  (local (somma nomesomma nome$)
    (setq somma 0)
    (dolist (el nomi)
      (setq nome$ (explode el))
      (setq nomesomma 0)
      (dolist (c nome$)
        (setq nomesomma (add nomesomma (lookup c alfa)))
      )
      (setq nomesomma (mul nomesomma (+ $idx 1)))
      (setq somma (add somma nomesomma))
    )
  )
)

(e022)
;-> 871198282

(time (e022))
;-> 20.016


===========
Problema 23
===========

Somma numeri non abbondanti

Un numero perfetto è un numero per il quale la somma dei relativi divisori è esattamente uguale al numero. Ad esempio, la somma dei divisori propri di 28 sarebbe 1 + 2 + 4 + 7 + 14 = 28, il che in dica che 28 è un numero perfetto.

Un numero n è chiamato carente se la somma dei suoi divisori è inferiore a n e viene chiamato abbondante se questa somma supera n.

Dato che 12 è il numero abbondante più piccolo, 1 + 2 + 3 + 4 + 6 = 12, il numero più piccolo che può essere scritto come somma di due numeri abbondanti è 24. Con l'analisi matematica, si può dimostrare che tutti gli interi superiori a 28123 possono essere scritti come somma di due numeri abbondanti. Tuttavia, questo limite superiore non può essere ulteriormente ridotto dall'analisi anche se è noto che il più grande numero che non può essere espresso come somma di due numeri abbondanti è inferiore a questo limite.

Trovare la somma di tutti i numeri interi positivi che non possono essere scritti come la somma di due numeri abbondanti.
============================================================================

Funzione che calcola la somma di tutti i divisori propri (tutti i divisori tranne se stesso) di un numero :
(vedi problema 21)

(define (factor-group x)
  (if (= x 1) '(1 1)
    (letn (fattori (factor x)
          unici (unique fattori))
      (transpose (list unici (count unici fattori)))
    )
  )
)

(define (somma-divisori-propri-fast n)
  (if (= n 1) '0
    (begin (setq res 1)
     (setq lst (factor-group n))
     (dolist (el lst)
       (setq somma-el 0)
       (for (i 0 (last el))
         (setq somma-el (+ somma-el (pow (first el) i)))
       )
       (setq res (* res somma-el))
     )
     (- res n)) ;somma divisori propri (tutti tranne se stesso)
  )
)

(somma-divisori-propri-fast 284235235345)
;-> 59865475031

Funzione che cerca una coppia di numeri in un vettore che sommano a num.
Questa funzione ha complessità temporale O(nlog(n)).

(define (trovaCoppia vec num)
  (local (low high a b out)
    ; ordina il vettore in ordine crescente
    (sort vec)
    ; indici che puntano all'inizio e alla fine dell'array
    (setq low 0)
    (setq high (- (length vec) 1))
    (while (and (< low high) (= out nil))
      (setq a (vec low))
      (setq b (vec high))
      ; vale anche la coppia formata dallo stesso numero ripetuto
      ; altrimenti il risultato vale: 4179935
      (if (or (= num (add a b)) (= num (add a a)) (= num (add b b)))
          ; coppia trovata
          (setq out true)
      )
      (if (< (add (vec low) (vec high)) num)
          ; incrementa l'indice basso se il totale è minore della somma
          (++ low)
          ; decrementa indice alto se è totale è maggiore della somma
          (-- high)
      )
    )
    out
  );local
)

(setq lst '( 123 73 64 7 8 6 5 4 3 4 5 6 7 ))
(setq v (array (length lst) lst))
(array? v)
;-> true

(trovaCoppia v 130)
;-> true

(trovaCoppia v 230)
;-> nil

(trovaCoppia v 246)
;-> true

Funzione che crea la lista dei numeri abbondanti fino al numero 28123.

(define (creaAbbondanti)
  (local (out)
    (setq out '())
    (for (i 1 28123)
      (if (< i (somma-divisori-propri-fast i))
        (push i out)
      )
    )
    out
  )
)

(silent (setq abbo (creaAbbondanti)))
(time (setq abbo (creaAbbondanti)))

(length abbo)
;-> 6965
(sort abbo)

(slice abbo 0 30)
;-> (12 18 20 24 30 36 40 42 48 54 56 60 66 70 72 78 80 84 88 90 96 100 102 104 108 112 114 120 126 132)

Adesso possiamo scrivere la funzione che trova i numeri richiesti dal problema:

(define (e023)
  (local (abbo-lst abbo somma out)
    (setq out '())
    (setq somma 0)
    (setq abbo-lst (creaAbbondanti))
    (setq abbo (array (length abbo-lst) abbo-lst))
    (for (i 1 28123)
      (if (not (trovaCoppia abbo i))
        (begin
          (setq somma (add somma i))
          (push i out -1)
        )
      )
    )
    (println somma)
    out
  )
)

(silent (setq res (e023)))
;-> 4179871

(slice res 0 100)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 25 26 27 28 29 31 33
;->  34 35 37 39 41 43 45 46 47 49 51 53 55 57 59 61 63 65 67 69 71 73 75 77 79 81 83
;->  85 87 89 91 93 95 97 99 101 103 105 107 109 111 113 115 117 119 121 123 125 127
;->  129 131 133 135 137 139 141 143 145 147 149 151 153 155 157 159 161 163 165 167
;->  169)

Sopra a 50 i numeri della somma sono tutti dispari, quindi dividiamo il ciclo for in due parti:

(define (e023)
  (local (abbo-lst abbo somma)
    (setq somma 0)
    (setq abbo-lst (creaAbbondanti))
    (setq abbo (array (length abbo-lst) abbo-lst))
    (for (i 1 50)
      (if (not (trovaCoppia abbo i))
          (setq somma (add somma i))
      )
    )
    (for (i 51 28123 2)
      (if (not (trovaCoppia abbo i))
          (setq somma (add somma i))
      )
    )
    somma
  )
)

(e023)
;-> 4179871

(time (e023))
;-> 40900.186 ; circa 41 secondi


===========
Problema 24
===========

Permutazioni lessicografiche

Una permutazione è una disposizione ordinata di oggetti. Ad esempio, 3124 è una possibile permutazione delle cifre 1, 2, 3 e 4. Se tutte le permutazioni sono ordinate numericamente o alfabeticamente, vengono chiamate in ordine lessicografico. Le permutazioni lessicografiche di 0, 1 e 2 sono:

012 021 102 120 201 210

Qual è la milionesima permutazione lessicografica delle cifre 0, 1, 2, 3, 4, 5, 6, 7, 8 e 9?
============================================================================

Definiamo la funzione che genera le permutazioni:

(define (seq start end)
  (if (= start end)
      (list end)
      (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (seq 0 (length p))))
                         (permute (rest l))))))


Scriviamo la funzione finale:

(define (e024)
  (setq p (sort (permute '(0 1 2 3 4 5 6 7 8 9))))
  (int (join (map string (p 999999))))
)

Abbiamo ordinato le permutazioni poichè non vengono create in ordine lessicografico.

(e024)
;-> 2783915460

(time (e024))
;-> 25309.091  ;circa 25 secondi


===========
Problema 25
===========

Numero di Fibonacci a 1000 cifre

La sequenza di Fibonacci è definita dalla relazione di ricorrenza:

Fn = Fn-1 + Fn-2, dove F1 = 1 e F2 = 1.
Quindi i primi 12 termini saranno:

F1 = 1
F2 = 1
F3 = 2
F4 = 3
F5 = 5
F6 = 8
F7 = 13
F8 = 21
F9 = 34
F10 = 55
F11 = 89
F12 = 144

Il dodicesimo termine, F12, è il primo termine a contenere tre cifre.

Qual è l'indice del primo termine nella sequenza di Fibonacci per contenere 1000 cifre?
============================================================================

Funzione per calcolare i numeri di Fibonacci:

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

(fibo-i 12)
;-> 144

(define (e025)
  (local (trovato num)
    (setq num 1)
    (while (not trovato)
      ; maggiore di 1000 (non 999), perchè i big integer finiscono con L
      (if (> (length (string (fibo-i num))) 1000)
        (setq trovato true)
      )
      (++ num)
    )
    (-- num)
  )
)

(e025)
;-> 4782

(time (e025))
;-> 4925.875


===========
Problema 26
===========

Periodo dei numeri reciproci

Una frazione unitaria contiene 1 nel numeratore. La rappresentazione decimale delle frazioni unitarie con i denominatori da 2 a 10 è data:

1/2 =  0.5
1/3 =  0. (3)
1/4 =  0.25
1/5 =  0.2
1/6 =  0.1 (6)
1/7 =  0. (142857)
1/8 =  0.125
1/9 =  0. (1)
1/10 = 0.1

Dove 0.1 (6) significa 0.166666 ... e ha un ciclo ricorrente di 1 cifra. Si può vedere che 1/7 ha un ciclo ricorrente di 6 cifre.

Trova il valore di d <1000 per cui 1 / d contiene il ciclo ricorrente più lungo nella sua parte della frazione decimale.
============================================================================

Calcoliamo i resti della divisione, quando troviamo lo stesso resto per la seconda volta, allora abbiamo trovato un ciclo (se il rsto è diverso da zero.
La lunghezza del ciclo è uguale alla distanza in cui si trovano i due valori uguali di resto.

Esempio: 1/14

(% 1 14)
;-> 1
(% 10 14)
;-> 10
(% 100 14)
;-> 2
(% 1000 14)
;-> 6
(% 10000 14)
;-> 4
(% 100000 14)
;-> 12
(% 1000000 14)
;-> 8
(% 10000000 14)
;-> 10 ; il numero 10 è stato già trovato ==> stop

La lista vale: (1 10 2 6 4 12 8 10)

La distanza tra i due numeri 10 è la differenza tra gli indici: 7 - 1 = 6.
Se i due numeri uguali del resto valgono 0, allora il reciproco non ha cicli.

Adesso possiamo scrivere la funzione che calcola la lunghezza del ciclo del reciproco di un numero:

(define (ciclo n)
  (local (trovato lst resto len-ciclo idx)
    (setq lst '())
    (setq pot 1)
    (while (not trovato)
      (setq resto (% pot n))
      (if (= (find resto lst) nil ) (push resto lst -1)
          (begin
            (setq trovato true)
            (push resto lst -1)
            (setq idx (ref-all resto lst))
            (setq len-ciclo (- (first (last idx)) (first (first idx))))
          )
      )
      (setq pot (* 10L pot))
      ;(println pot)
    )
    ;se i numeri uguali del resto valgono 0, allora il ciclo vale 0.
    (if (= resto 0) (setq len-ciclo 0))
    ;(list len-ciclo lst (div 1 n))
    (list len-ciclo (div 1 n))
  )
)

(ciclo 14)
;-> (6 (1 10 2 6 4 12 8 10) 0.07142857142857143)

(ciclo 7)
;-> (6 (1 3 2 6 4 5 1) 0.1428571428571429)

(ciclo 2)
;-> (0 0.5)

(ciclo 3)
;-> (1 0.3333333333333333)

(ciclo 983)
;-> (982 0.001017293997965412)

(define (e026)
  (local (num maxciclo)
    (setq maxciclo 0)
    (for (i 1 1000)
      (setq c (ciclo i))
      (if (> c maxciclo)
        (setq maxciclo c num i)
      )
    )
    (list num maxciclo)
  )
)

(e026)
;-> (983 (982 0.001017293997965412))

(time (e026))
;-> 488.049


===========
Problema 27
===========

Eulero scoprì la notevole formula quadratica:  n^2 + n + 41

La formula produce 40 numeri primi per i valori interi consecutivi 0≤n≤39. Tuttavia, quando n = 40, 40^2 + 40 + 41 = 40 (40 + 1) + 41 è divisibile per 41, e certamente quando n = 41, 41^2 + 41 + 41 è chiaramente divisibile per 41.

È stata scoperta l'incredibile formula n^2 - 79n + 1601, che produce 80 numeri primi per i valori consecutivi 0≤n≤79. Il prodotto dei coefficienti, -79 e 1601, è -126479.

Considerando forme quadratiche del tipo:

n^2 + a*n + b, dove |a| < 1000 e |b| ≤ 1000

dove |n| è il valore assoluto di n

Per esempio: |11| = 11 e |-4| = 4

Trova il prodotto dei coefficienti, a e b, per l'espressione quadratica che produce il numero massimo di numeri primi per valori consecutivi di n, iniziando con n = 0.
============================================================================

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

(define (e027)
  (local (aa bb num min_a max_a min_b max_b max_len primo lst)
    (setq min_a -999)
    (setq max_a 999)
    (setq min_b -1000)
    (setq max_b 1000)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst '())
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (push num lst)
              (if (> (length lst) max_len)
                (begin
                  (setq max_len (length lst))
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list (* aa bb) aa bb max_len)
  );local
)

(e027)
;-> (-59231 -61 971 71)

(time (e027))
;-> 2000.151

Proviamo a ricercare in un intervallo più grande (-10000 10000):

(define (test27 min_a max_a min_b max_b)
  (local (aa bb num max_len primo lst)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst '())
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (push num lst)
              (if (> (length lst) max_len)
                (begin
                  (setq max_len (length lst))
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list aa bb max_len)
  );local
)

(test27 -10000 10000 -10000 10000)
;-> (-79 1601 80)

Abbiamo trovato l'equazione presentata come esempio nel problema.

Facciamo un controllo:

(define (f n)
  (primo? (+ (* n n) (* (- 79) n) 1601)))

(f 2)

(count '(true) (map f (sequence 0 79)))
;-> (80)

(define (f1 n)
  (list (primo? (+ (* n n) (* (- 79) n) 1601)) (+ (* n n) (* (- 79) n) 1601)))

Proviamo ad eliminare la lista dei numeri primi ed usare solo un contatore per cercare di migliorare la velocità di esecuzione:

(define (e027-2)
  (local (aa bb num min_a max_a min_b max_b max_len primo lst_len)
    (setq min_a -999)
    (setq max_a 999)
    (setq min_b -1000)
    (setq max_b 1000)
    (for (a min_a max_a)
      (for (b min_b max_b)
        (setq primo true)
        (setq lst_len 0)
        (setq num 0)
        (while primo
          (if (primo? (add (mul num num) (mul a num) b))
            (begin
              (++ lst_len)
              (if (> lst_len max_len)
                (begin
                  (setq max_len lst_len)
                  (setq aa a)
                  (setq bb b)
                )
              )
              (++ num)
            )
          ;else
            (setq primo nil)
          );if
        );while
      );for
    );for
    (list (* aa bb) aa bb max_len)
  );local
)

(e027-2)
;-> (-59231 -61 971 71)

(time (e027-2))
;-> 2015.211

Non abbiamo migliorato, sembra che il tempo dipenda quasi esclusivamente dai due cicli for :-)


===========
Problema 28
===========

Diagonale di numeri a spirale

Partendo dal numero 1 e spostandosi verso destra in senso orario, si forma una spirale 5 per 5 come segue:

21 22 23 24 25
20  7  8  9 10
19  6  1  2 11
18  5  4  3 12
17 16 15 14 13

Si può verificare che la somma dei numeri sulle diagonali sia 101:
(21 + 7 + 1 + 3 + 13 + 25 + 9 + 5 + 17) = 101 (l'elemento centrale (1) viene contato solo una volta).

Qual è la somma dei numeri sulle diagonali in una spirale 1001 per 1001 formata nello stesso modo?
============================================================================

Disegniamo una matrice più grande per poter individuare una funzione che possa generarer i valori dei numeri sulla diagonale in funzione della grandezza della matrice:

 73                      81
    43                49
       21 22 23 24 25
       20  7  8  9 10
       19  6  1  2 11
       18  5  4  3 12
       17 16 15 14 13
    37                31
 65                      57

(define (e028)
  (local (m somma a_d b_d b_s a_s alto_dx basso_dx basso_sx alto_sx)
    (setq m 1001)
    (setq somma 0)
    (setq a_d '())
    (setq b_d '())
    (setq a_s '())
    (setq b_s '())
    (for (i 1 (/ (- m 1) 2))
      (setq alto_dx (* (+ (* i 2) 1) (+ (* i 2) 1)))
      (setq basso_dx (- alto_dx (* 6 i)))
      (setq basso_sx (- alto_dx (* 4 i)))
      (setq alto_sx (- alto_dx (* 2 i)))
      ;(println alto_dx { } alto_sx { } basso_sx { } basso_dx)
      (push alto_dx a_d)
      (push basso_dx b_d)
      (push basso_sx b_s)
      (push alto_sx a_s)
    )
    (setq somma (+ (apply + a_d) (apply + a_s) (apply + b_d) (apply + b_s) 1))
  )
)

Con m = 5 e con l'espressione print attiva, otteniamo:

;-> 9 7 5 3
;-> 25 21 17 13
;-> 101

(e028)
;-> 669171001

(time (e028))
;-> 0


===========
Problema 29
===========

Potenze distinte

Considerare tutte le combinazioni intere di ab per 2 ≤ a ≤ 5 e 2 ≤ b ≤ 5:

2^2 = 4,  2^3 = 8,   2^4 = 16,  2^5 = 32
3^2 = 9,  3^3 = 27,  3^4 = 81,  3^5 = 243
4^2 = 16, 4^3 = 64,  4^4 = 256, 4^5 = 1024
5^2 = 25, 5^3 = 125, 5^4 = 625, 5^5 = 3125

Se vengono quindi posizionati in ordine numerico, con le eventuali ripetizioni rimosse, otteniamo la seguente sequenza di 15 termini distinti:

4, 8, 9, 16, 25, 27, 32, 64, 81, 125, 243, 256, 625, 1024, 3125

Quanti termini distinti sono nella sequenza generata da a^b per 2 ≤ a ≤ 100 e 2 ≤ b ≤ 100?
============================================================================

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
)

(define (e029)
  ;(local (a b lst)
  (local (a b)
    (setq lst '())
    (for (a 2 100)
      (for (b 2 100)
        (push (potenza a b) lst)
      )
    )
    (setq lst (unique lst))
    (length lst)
  )
)

(e029)
;-> 9183

(time (e029))
;-> 140.608


===========
Problema 30
===========

Quinta potenza delle cifre

Sorprendentemente ci sono solo tre numeri che possono essere scritti come la somma delle quarte potenze delle loro cifre:

1634 = 1^4 + 6^4 + 3^4 + 4^4
8208 = 8^4 + 2^4 + 0^4 + 8^4
9474 = 9^4 + 4^4 + 7^4 + 4^4

La somma di questi numeri è 1634 + 8208 + 9474 = 19316.

Il numero 1 = 1^4 non viene incluso perchè non è una somma.

Trova la somma di tutti i numeri che possono essere scritti come somma delle quinte potenze delle loro cifre.
============================================================================

Funzione che estrae le cifre di un numero da sinistra verso destra:

(define (estraiCifre n)
  (local (cifra)
    (while (!= n 0)
      (setq cifra (% n 10))
      (setq n (/ n 10))
      (print cifra { })
    )
  )
)

(estraiCifre 1234)
;-> 4 3 2 1 " "

Precalcoliamo la quinta potenza di ogni cifra:

(setq pot5 (map (fn (x) (pow x 5)) '(0 1 2 3 4 5 6 7 8 9)))
;-> (0 1 32 243 1024 3125 7776 16807 32768 59049)

Funzione che calcola la somma delle quinte potenze di tutte le cifre di un numero:

(define (pot5Cifre n)
  (local (cifra somma)
    (setq somma 0)
    (while (!= n 0)
      (setq cifra (% n 10))
      (setq somma (+ somma (pot5 cifra)))
      (setq n (/ n 10))
    )
    somma
  )
)

(pot5Cifre 1634)
;-> 9044

Limite superiore:
max numero con 1 cifra = 9^5 = 56049
max numero con 2 cifre = 9^5 + 9^5 = 118098
max numero con 3 cifre = 9^5 + 9^5 + 9^5 = 177147
max numero con 4 cifre = 9^5 + 9^5 + 9^5 + 9^5 = 236196
max numero con 5 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 295245
max numero con 6 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 354294
max numero con 7 cifre = 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 + 9^5 = 413343

Quindi per essere sicuri di considerare tutti i numeri di cinque cifre formati dalla somma delle quinte potenze di ogni cifra occorre prendere il numero 295245 (perchè questo numero ha 6 cifre).

(* 5 (pow 9 5))
;-> 295245

(define (e030)
  (local (maxVal tot)
    (setq maxVal 295245)
    (setq tot 0)
    (for (i 2 maxVal)
      (setq x (pot5Cifre i))
      (if (= x i) (setq tot (+ tot x)))
    )
    tot
  )
)

(e030)
;-> 443839

(time (e030))
;-> 515.564


===========
Problema 31
===========

Somme di monete

In Inghilterra la moneta è composta da sterline "£" e pence "p" e ci sono in circolazione otto tipi di monete:

1p, 2p, 5p, 10p, 20p, 50p, £ 1 (100p) e £ 2 (200p)

È possibile arrivare a £ 2 nel modo seguente:

1 × £ 1 + 1 × 50p + 2 × 20p + 1 × 5p + 1 × 2p + 3 × 1p

In quanti modi diversi si può arrivare a £ 2 usando un numero qualsiasi di monete?
============================================================================

Soluzione forza-bruta:

(define (e031)
  (local (A B C D E F G q tot)
    (setq A (sequence 0 200))
    (setq B (sequence 0 200 2))
    (setq C (sequence 0 200 5))
    (setq D (sequence 0 200 10))
    (setq E (sequence 0 200 20))
    (setq F (sequence 0 200 50))
    (setq G (sequence 0 200 100))
    (setq q 1)
    (setq tot 200)
    (dolist (a A)
      (dolist (b B (> (+ a b) tot))
        (dolist (c C (> (+ a b c) tot))
          (dolist (d D (> (+ a b c d) tot))
            (dolist (e E (> (+ a b c d e) tot))
              (dolist (f F (> (+ a b c d e f) tot))
                (dolist (g G)
                  (if (= (+ a b c d e f g) tot) (++ q))
    )))))))
    q
  );local
)

(e031)
;-> 73682

(time (e031))
;-> 3009.901

Soluzione programmazione dinamica:

(define (e031)
  (local (totale monete modi)
    ; valore obiettivo
    (setq totale 200)
    ; lista dei tagli di monete disponibili
    (setq monete '(1 2 5 10 20 50 100 200))
    ; crea un vettore di totale elementi con tutti valori 0 tranne il primo (modi[0]) che vale 1
    (setq modi (array (+ totale 1) (extend '(1) (dup 0 totale))))
    (dolist (el monete)
      (for (i el totale)
        (setq (modi i) (+ (modi i) (modi (- i el))))
      )
    )
    (modi totale)
  )
)

(e031)
;-> 73682

(time (e031))
;-> 0.971


===========
Problema 32
===========

Prodotti Pandigitali

Diciamo che un numero con n cifre è pandigitale se fa uso di tutte le cifre da 1 a n esattamente una volta. Ad esempio, il numero a 5 cifre, 15234, è pandigitale da 1 a 5.

Il prodotto 7254 è inusuale, poiché l'identità 39 × 186 = 7254, contenente moltiplicando, moltiplicatore e prodotto è pandigitale da 1 a 9.

Trovare la somma di tutti i prodotti la cui identità in moltiplicando/moltiplicatore/prodotto è pandigitale da 1 a 9.

SUGGERIMENTO: alcuni prodotti possono essere ottenuti in più di un modo, quindi assicurati di includerlo solo una volta nella somma.
============================================================================

La seguente funzione verifica se un numero è pandigitale (1-9):

(define (pan? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '-1 lst) nil true)
          )
        )
  )
)


(pan? 391867254)
;-> true

(pan? 391877254)
;-> nil

Calcoliamo i limiti dei numeri coinvolti:

(* 999 99)
;-> 98901

(* 9999 9)
;-> 89991

999 * 99 = 98901 => 10 cifre (moltiplicando/moltiplicatore/prodotto)
9999 * 9 = 89991 => 10 cifre (moltiplicando/moltiplicatore/prodotto)

Quindi, il massimo valore del primo indice vale 99 e il massimo valore del secondo indice 9999. Si tratta di una stima grossolana che potrebbe essere migliorata.

Possiamo scrivere la soluzione:

(define (e032)
  (local (somma sol p)
    (setq sol '())
    (for (i 1 99)
      (for (j (+ i 1) 9999)
        (setq p (int (string i j (* i j))))
        (if (pan? p) (push (* i j) sol))
        ;(if (pan? p) (begin (push (* i j) sol) (println i { * } j { = } (* i j))))
      )
    )
    (setq sol (unique sol))
    (apply + sol)
  )
)

(e032)
;-> 45228

(time (e032))
;-> 1625.291

Ecco tutti i prodotti pandigitali:

 4 * 1738 = 6952
 4 * 1963 = 7852
12 *  483 = 5796 (a)
18 *  297 = 5346 (b)
27 *  198 = 5346 (b)
28 *  157 = 4396
39 *  186 = 7254
42 *  138 = 5796 (a)
48 *  159 = 7632


(+ 6952 7852 5796 5346 4396 7254 7632)
;-> 45228

===========
Problema 33
===========

Cancellazione di cifre nelle frazioni

La frazione 49/98 è una frazione curiosa, poiché un matematico inesperto nel tentativo di semplificarlo potrebbe erroneamente credere che 49/98 = 4/8, che è corretto, si ottiene cancellando le due cifre 9.

Considereremo frazioni come, 30/50 = 3/5, come esempi banali.

Esistono esattamente quattro esempi non banali di questo tipo di frazione, che hanno valore minore di 1, e contenenti due cifre nel numeratore e nel denominatore.

Se il prodotto di queste quattro frazioni viene ridotto ai minimi termini (semplificato), trovare il valore del denominatore.
============================================================================

Funzione che converte un numero intero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

La soluzione con la forza bruta è abbastanza semplice (e anche veloce):

(define (e033)
  (local (fraction frazione N D num numL den denL d d1 d2 n n1 n2 val)
    (setq fraction '())
    (for (num 11 100)
      (for (den (+ num 1) 100)
        (setq val (div num den))
        (setq frazione 0)
        (setq denL (int2list den))
        (setq d1 (int (denL 0)))
        (setq d2 (int (denL 1)))
        (setq numL (int2list num))
        (setq n1 (int (numL 0)))
        (setq n2 (int (numL 1)))
        (cond ((and (= n1 d2) (!= d1 0))
               (setq frazione (div n2 d1))
               (setq n n2)
               (setq d d1)
              )
              ((and (= n2 d1) (!= d2 0))
               (setq frazione (div n1 d2))
              )
              ((and (= n1 d1) (!= d2 0))
               (setq frazione (div n2 d2))
              )
              ((and (= n2 d2) (!= n2 0) (!= d1 0))
               (setq frazione (div n1 d1))
              )
        )
        (if (= frazione val) (push (list num den) fraction))
      )
    )
    (println fraction)
    (setq N (apply * (map first f)))
    (setq D (apply * (map last f)))
    (div D (gcd N D))
  );local
)

(e033)
;-> ((49 98) (26 65) (19 95) (16 64))
;-> 100

(time (e033))
;-> 31.235

Le quattro frazioni sono: 16/64 (1/4), 26/65 (2/5), 19/95 (1/5) e 49/98 (4/8).

Anche in questo problema possiamo utilizzare la matematica per trovare un algoritmo migliore.
Si può dimostrare che ogni frazione della soluzione deve essere della forma:

10*n + i    n
-------- = ---
10*i + d    d

dove numeratore "n" e denominatore "d" soddisfano la relazione: 1 <= n < d <= 9
e la variabile da eliminare "i" soddisfa la relazione: 1 <= i <= 9

Per evitare di utilizzare divisoni, troveremo le soluzioni verificando se vale l'uguaglianza:

d*(10*n + i) = n*(10*i + d)

(define (e033)
  (local (den num numtot dentot)
    (setq numtot 1 dentot 1)
    (for (i 1 9)
      (setq den 1)
      (while (< den i)
        (setq num 1)
        (while (< num den)
          (if (= (* den (+ (* num 10) i)) (* num (+ (* 10 i) den)))
            (begin
              (setq dentot (* dentot den))
              (setq numtot (* numtot num))
              ;(println num i {/} i den)
            )
          )
          (++ num)
        )
        (++ den)
      )
    )
    (/ dentot (gcd numtot dentot))
  )
)

(e033)
;-> 100

(time (e033))
;-> 0


===========
Problema 34
===========

Cifre fattoriali

145 è un numero curioso, poichè 1! + 4! + 5! = 1 + 24 + 120 = 145.

Trovare la somma di tutti i numeri che sono uguali alla somma del fattoriale delle loro cifre.

Nota: poichè 1! = 1 e 2! = 2 non sono somme, allora non vengono inclusi.
============================================================================

Precalcoliamo il fattoriale delle cifre 0..9:

(define (fact n) (if (= n 0) 1 (apply * (sequence 1 n))))

(setq fact-lst (map (fn(n) (fact n)) (sequence 0 9)))
;-> (1 1 2 6 24 120 720 5040 40320 362880)

Limiti dei numeri
Il numero 3 potrebbe andar bene, ma poiché il fattoriale di un numero di una cifra - eccetto 3 - ha sempre più di una cifra, allora possiamo iniziare con 10.
Il calcolo del limite superiore è un pò più complicato.
Se prendiamo un numero n con "d" cifre, possiamo scrivere:

 10^(d-1) <= n < 10^d

Per formare il numero massimo di "d" cifre dobbiamo utilizzare tutti 9, e la somma delle sue cifre fattoriali sarebbe d*9!, quindi:

 10^(d-1) <= d*9! < 10^d

Provando alcuni valori di "d" notiamo che 9!*7 = 2540160. Non esiste un valore più alto, poiché sia 9!*8 che 9!*9 generano ugualmente numeri di 7 cifre (9!*8 = 2903040, 9!*93265920). Quindi il numero 9999999 genera 7*9! = 2540160.

(define (e034)
  (local (fact-lst somma sol n)
    (setq fact-lst '(1 1 2 6 24 120 720 5040 40320 362880))
    (setq sol '())
    (for (i 10 2540160)
      (setq somma 0)
      (setq n i)
      (while (!= n 0)
        (setq somma (+ somma (fact-lst (% n 10))))
        (setq n (/ n 10))
      )
      (if (= somma i) (push i sol))
    )
    (list (apply + sol) sol)
  )
)

(e034)
;-> (40730 (40585 145))

(time (e034))
;-> 3797.395


===========
Problema 35
===========

Numeri primi circolari

Il numero, 197, è chiamato primo circolare perché tutte le rotazioni delle cifre: 197, 971 e 719, sono esse stesse prime.

Ci sono tredici tali numeri primi sotto 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79 e 97.

Quanti numeri primi circolari ci sono sotto un milione?
============================================================================

Abbiamo bisogno delle seguenti funzioni ausiliarie:

Verifica se un numero è primo:

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

Converte un numero intero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

Converte una lista in un numero intero:

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

Crea una lista con tutte le rotazioni della lista passata:

(define (creaRotate lst)
  (let (out '())
    ;(for (i 1 (- (length lst) 1))
    (for (i 1 (length lst))
      (push (rotate lst) out)
    )
    out
  )
)

(creaRotate '(2))
;-> ((2))

(creaRotate '(1 2 3))
;-> ((1 2 3) (2 3 1) (3 1 2))

Adesso definiamo la funzione che risolve il problema:

(define (e035)
  (local (primicirco candidate stop k)
    (setq primicirco '(2)) ;lista risultato
    (setq candidate '())   ;lista rotazioni
    (for (i 3 999999 2)    ;solo numeri pari
      (if (primo? i)
        (begin
          ; creiamo la lista di tutti numeri ruotati del numero i
          (setq candidate (creaRotate (int2list i)))
          (setq stop nil)
          (setq k 0)
          (while (and (< k (length candidate)) (= stop nil))
            (if (!= k 0) ;il primo numero è sempre primo
              ;stop quando un numero della lista candidati non è primo
              (if (not (primo? (list2int (candidate k)))) (setq stop true))
            )
            (++ k)
          )
          ; se tutti i numeri nella lista candidati sono primi
          ; aggiungiamo la lista al risultato
          (if (= stop nil) (push (list2int (candidate (- k 1))) primicirco))
        )
      );if
    );for
    (list (length primicirco) primicirco)
  );local
)

(e035)
;-> (55 (199933 999331 193939 393919 993319 391939 939391 939193 933199 331999 319993
;->      919393 19937 19391 99371 39119 37199 93911 93719 71993 11939 91193 7937 1931 7793
;->      3779 9377 9311 1193 3119 199 197 991 373 971 337 733 131 919 719 113 311 79 97
;->      37 17 73 13 71 31 11 7 5 3 2))

(time (e035))
;-> 1266.715


===========
Problema 36
===========

Palindromi a doppia base

Il numero decimale, 585 = 10010010012 (binario), è palindromo in entrambe le basi.

Trova la somma di tutti i numeri, sotto al milione, che sono palindromi in base 10 e in base 2.

(Si noti che il numero palindromo, in entrambe le basi, non include gli zeri iniziali.)
============================================================================

Funzioni ausiliarie

Questa funzione controlla se un numero è palindromo:

(define (paliN n)
  (= (string n) (reverse (string n))))

(paliN 113311)
;-> true

(paliN 1123311)
;-> nil

Questa funzione controlla se una stringa è palindroma:

(define (paliS s)
  (= s (reverse (copy s))))

(paliS "1234321")
;-> true

(paliS "51234321")
;-> nil

Nota: I numeri pari non sono mai palindromi in base 2, perchè il bit a destra vale sempre 0 e il bit a sinistra vale sempre 1.

Nota: per controllare se un numero in base 2 è palindromo occorre utilizzare una stringa per rappresentarlo, perchè altrimenti il numero dovrebbe essere un big integer (con L alla fine).

La funzione finale è la seguente:

(define (e036)
  (let (somma 0)
    (for (i 1 999999 2) ;nessun numero pari palindromo in base 2
      (if (and (paliN i) (paliS (bits i)))
        (begin
          (setq somma (+ somma i))
          ;(println i { - } (bits i))
        )
      )
    )
    somma
  )
)

(e036)
;-> 872187

(time (e036))
;-> 1442.523

I numeri palindromi in entrambe le basi sono:

1 - 1
3 - 11
5 - 101
7 - 111
9 - 1001
33 - 100001
99 - 1100011
313 - 100111001
585 - 1001001001
717 - 1011001101
7447 - 1110100010111
9009 - 10001100110001
15351 - 11101111110111
32223 - 111110111011111
39993 - 1001110000111001
53235 - 1100111111110011
53835 - 1101001001001011
73737 - 10010000000001001
585585 - 10001110111101110001


===========
Problema 37
===========

Numeri primi troncabili

Il numero 3797 ha una proprietà interessante. Essendo primo se stesso, è possibile rimuovere continuamente i numeri da sinistra a destra, e rimanere primo in ogni fase: 3797, 797, 97 e 7. Allo stesso modo possiamo lavorare da destra a sinistra: 3797, 379, 37 e 3.

Trova la somma degli unici undici numeri primi che sono entrambi troncabili da sinistra a destra e da destra a sinistra.

NOTA: 2, 3, 5 e 7 non sono considerati numeri primi troncabili.
============================================================================

(define (creaTruncate lst)
  (let (out '())
    ; da destra
    (for (i 1 (- (length lst) 1))
      (push (slice lst 0 i) out)
    )
    ; da sinistra
    (for (i 1 (- (length lst) 1))
      (push (slice lst i) out)
    )
    out
  )
)

(setq lst '(3 7 9 7))

(creaTruncate lst)
;-> ((7) (9 7) (7 9 7) (3 7 9) (3 7) (3))

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(define (primo? n)
  (if (= n 2) true
      (if (even? n) nil
          (if (< n 2) nil
              (= 1 (length (factor n)))))))

(define (e037)
  (local (primitrunca candidate trovati stop k i)
    (setq primitrunca '()) ;lista risultato
    (setq candidate '())   ;lista troncati
    (setq trovati 0)
    (setq i 11)
    (while (< trovati 11)
      (if (primo? i)
        (begin
          (setq candidate (creaTruncate (int2list i)))
          (setq stop nil)
          (setq k 0)
          (while (and (< k (length candidate)) (= stop nil))
            (if (not (primo? (list2int (candidate k)))) (setq stop true))
            (++ k)
          )
          (if (= stop nil)
            (begin
              ;(push (list2int (candidate (- k 1))) primitrunca)
              (push i primitrunca)
              (++ trovati)
            )
          )
        )
      );if
      (setq i (+ i 2))
      (if (= 0 (% i 10000)) (println i))
    );while
    (list (apply + primitrunca) primitrunca)
  );local
)

(e037)
;-> (748317 (739397 3797 3137 797 373 317 313 73 53 37 23))

(time (e037))
;-> 939.055

Proviamo a velocizzare l'algoritmo della funzione.
Considerazioni:
- non abbiamo bisogno di una lista per il risultato: basta usare una variabile (somma).
- non abbiamo bisogno di una lista per i numeri troncati: possiamo testarli appena generati.

Definiamo una funzione che controlla se un numero è truncabile a sinistra:

(define (truncaSX n)
  (local (i stop)
    (setq i 10)
    (while (and (<= i n) (= stop nil))
      (if (not (primo? (% n i))) (setq stop true))
      (setq i (* i 10))
    )
    (not stop)
  )
)

(truncaSX 3797)
;-> true

Definiamo una funzione che controlla se un numero è truncabile a destra:

(define (truncaDX n)
  (local (i stop)
    (setq i n)
    (while (and (!= 0 i) (= stop nil))
      (if (not (primo? i)) (setq stop true))
      (setq i (/ i 10))
    )
    (not stop)
  )
)

(truncaDX 3797)
;-> true

(define (e037)
  (local (trovati somma i)
    (setq somma 0)
    (setq i 11)
    (while (< trovati 11)
      (if (and (truncaDX i) (truncaSX i))
        (begin
          (setq somma (+ somma i))
          (++ trovati)
        )
      )
      (setq i (+ i 2))
    )
    somma
  )
)

(e037)
;-> 748317

(time (e037))
;-> 778.216


===========
Problema 38
===========

Multiplicazioni pandigitali

Prendi il numero 192 e moltiplicalo per i numeri 1, 2 e 3:

192 × 1 = 192
192 × 2 = 384
192 × 3 = 576

Concatenando ogni prodotto otteniamo il numero pandigitale da 1 a 9, 192384576. Chiameremo 192384576 il prodotto concatenato di 192 e (1,2,3)

Lo stesso può essere ottenuto iniziando con 9 e moltiplicando per 1, 2, 3, 4 e 5, che genera il pandigitale, 918273645, che è il prodotto concatenato di 9 e (1,2,3,4,5).

Qual è il più grande numero pandigitale da 1 a 9 (9 cifre) che può essere formato come prodotto concatenato di un numero intero con (1,2, ..., n) dove n > 1?
============================================================================

(define (pan? n)
  (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 -1 -1 -1 -1 -1 -1 -1 -1 -1))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '-1 lst) nil true)
          )
        )
  )
)

Per calcolare il limite superiore del ciclo basta considerare che con 10000 arriviamo a considerare numeri con 10 cifre (dobbiamo concatenare le stringhe delle moltiplicazioni), quindi questo valore è sufficiente.

(define (lim n)
  (length (append (string (* n 1)) (string (* n 2))))
)

(lim 9999)
;-> 9

(lim 10000)
;-> 10

(define (e038)
  (local (maxpandi theK theI pandisomma)
    (setq maxpandi 0)
    (setq theK 0)
    (setq theI 0)
    (for (k 1 10000)
      (setq pandisomma "")
      (for (i 1 9)
        (extend pandisomma (string (* k i)))
        (if (and (= (length pandisomma) 9) (> (int pandisomma) maxpandi) (pan? (int pandisomma)))
          (begin
            (setq maxpandi (int pandisomma))
            (setq theK k)
            (setq theI i)
          )
        )
      )
    )
    (list maxpandi theK theI)
  );local
)

(e038)
;-> (932718654 9327 2)

str(9327*1) + str(9327*2) = "932718654"

(time (e038))
;-> 93.757


===========
Problema 39
===========

Triangoli rettangoli interi

Se p è il perimetro di un triangolo rettangolo con lati di lunghezza intera, {a, b, c}, ci sono esattamente tre soluzioni per p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

Per quale valore di p ≤ 1000, il numero di soluzioni è massimizzato?
============================================================================

(define (e039)
  (local (qmax lst a b p q)
    (setq qmax 0)
    (setq lst '())
    (for (p 12 1000 2)
      (setq q 0)
      (setq a 1)
      (while (< a (/ p 3))
        (setq b (+ a 1))
        (setq stop nil)
        (while (and (= stop nil) (< b (- p a)))
          (if (= (pow (- p a b) 2) (+ (* a a) (* b b)))
            (begin
              (++ q)
              (setq stop true)
            )
          )
          (++ b)
        )
        (++ a)
      )
      (if (> q qmax)
        (begin
          (setq lst (list p q))
          (setq qmax q)
        )
      )
    )
    lst
  );local
)

(e039)
;-> (840 8)

(time (e039))
;-> 13485.51


===========
Problema 40
===========

La costante di Champernowne

Una frazione decimale irrazionale viene creata concatenando gli interi positivi:

0.12345678910(1)112131415161718192021 ...

Si può vedere che la dodicesima cifra della parte frazionaria è (1).

Se d(n) rappresenta l'ennesima cifra della parte frazionaria, trovare il valore della seguente espressione:

d(1) × d(10) × d(100) × d(1000) × d(10000) × d(100000) × d(1000000)
============================================================================

La lunghezza della costante di Champernowne supera (di poco) il milione quando si arriva a concatenare il numero 186000:

(length (join (map string (sequence 0 186000))))
;-> 1004896

Quindi usiamo questo valore come limite per la creazione delle cifre del risultato:

(define (e040)
  (local (num cifre val x stop sol)
    (setq lst '())
    (setq stop nil)
    (setq num 1)
    (while (and (< num 186000) (= stop nil))
      (setq cifre (length (string num)))
      (setq val num)
      (for (i cifre 1 -1)
        (setq x (/ val (pow 10 (- i 1))))
        (setq val (- val (* x (pow 10 (- i 1)))))
        (push x lst -1)
      )
      ;(if (> (length lst) 1000000) (setq stop true))
      (++ num)
      ;(if (= (% num 10000) 0) (println num { } (length lst)))
    )
    (* (lst 0) (lst 9) (lst 99) (lst 999) (lst 9999) (lst 99999) (lst 999999))
  )
)

(e040)
;-> 210

(time (e040))
;-> 640.584

Proviamo un altro metodo, creiamo una stringa che contiene almeno 1000000 di cifre e poi calcoliamo il risultato della moltiplicazione:

(define (e040)
  (let (a$ (join (map string (sequence 1 186000))))
    (* (int (a$ 0)) (int (a$ 9)) (int (a$ 99)) (int (a$ 999)) (int (a$ 9999)) (int (a$ 99999)) (int (a$ 999999)))
  )
)

(e040)
;-> 210

(time (e040))
;-> 140.625


===========
Problema 41
===========

Primo Pandigitale

Diremo che un numero a una cifra è pandigitale se fa uso di tutte le cifre da 1 a n esattamente una volta. Ad esempio, 2143 è un pandigitale a 4 cifre ed è anche primo.

Qual è il più grande numero primo pandigitale ad n-cifre esistente?
============================================================================

I numeri pandigitali (0..9), quelli (1..9) e quelli (1..8) non sono primi perchè sono tutti divisibili per 9 (in quanto la somma delle loro cifre vale 9).
Quindi consideriamo solo i numeri pandigitali fino a 7 cifre.

Possiamo iniziare a creare tutte le permutazioni di 7 cifre e cercare il numero primo massimo (se esiste).
Poi potremmo passare ai numeri con 6 cifre, e via di questo passo.

Funzione per le permutazioni:

(define (rimuovi x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst)) (rimuovi x (rest lst)))
    (true (cons (first lst) (rimuovi x (rest lst))))))

(define (permutazioni lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutazioni (rimuovi i lst)))) lst)))))

Funzione test numero primo:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Scriviamo la funzione finale:

(define (e041)
  (local (perm num primi)
    ;crea le permutazioni
    (setq perm (permutazioni '("1" "2" "3" "4" "5" "6" "7")))
    ; crea la lista dei numeri
    (setq num (map (fn (x) (int (join x))) perm))
    ;filtra i numeri primi e poi cerca il valore massimo
    (apply max (filter primo? num))
  )
)

(e041)
;-> 7652413

(time (e041))
;-> 125.004


===========
Problema 42
===========

Numeri triangolari codificati

L'ennesimo termine della sequenza di numeri triangolari è dato da, t(n) = ½*n*(n + 1), quindi i primi dieci numeri di triangolari sono:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

Convertendo ogni lettera di una parola in un numero corrispondente alla sua posizione alfabetica e aggiungendo questi valori formiamo un valore della parola. Ad esempio, il valore della parola per SKY è 19 + 11 + 25 = 55 = t10. Se il valore della parola è un numero triangolare, chiameremo la parola triangolo.

Usando il file words.txt, un file di testo 16K contenente quasi duemila parole inglesi comuni, quante sono le parole triangolari?
============================================================================

Il file ha questa struttura:
"A","ABILITY","ABLE","ABOUT","ABOVE","ABSENCE","ABSOLUTELY",...

Rimuoviamo tutti i caratteri doppio-apice "":

(define (remove-char c from-file to-file)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (set 'chr (read-char in-file))
        (if (!= chr c)
          (write-char out-file chr)))
    (close in-file)
    (close out-file)
    "fatto")

(char {"})
;-> 34

(char 34)
;-> "\""

(remove-char 34 "p042_words.txt" "words42.txt")

Il file adesso ha questa struttura:
A,ABILITY,ABLE,ABOUT,ABOVE,ABSENCE,ABSOLUTELY,

MARY,PATRICIA,LINDA,...

Importiamo il file in una lista di stringhe:

(silent (setq parole (parse (read-file "words42.txt") ",")))

Vediamo i primi cinque nomi:

(slice parole 0 5)
;-> ("A" "ABILITY" "ABLE" "ABOUT" "ABOVE")

Calcoliamo la lunghezza della parola più lunga:

(apply max (map length parole))
;-> 14

Il valore massimo di una parola vale 14 volte "Z";
(* 14 26)
;-> 364

Adesso creiamo una lista associativa (association list) tra i caratteri e il numero del relativo ordine:

(setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))

(lookup '"A" alfa)
;-> 1

Creiamo una lista di numeri triangolari (almeno fino a 364):

(setq tri (map (fn (n) (/ (* n (+ n 1)) 2)) (sequence 1 27)))
;-> (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210 231 253 276 300 325 351 378)

Calcoliamo il valore della parola "ABILITY";

(setq valore 0)
(dolist (el (explode "ABILITY"))
  (setq valore (+ valore (lookup el alfa)))
)

;-> 78
A =  1
B =  2
I =  9
L = 12
I =  9
T = 20
Y = 25
   ----
    78

Vediamo se è un numero triangolare:

(ref 78 tri)
;-> (11)

Si tratta dell'undicesimo numero triangolare (se non fosse triangolare avremmo ottenuto nil dalla funzione "ref")

Possiamo scrivere la funzione finale:

(define (e042)
  (local (alfa tri valore out)
    (setq out 0)
    (setq alfa  '(("A" 1) ("B" 2) ("C" 3) ("D" 4) ("E" 5) ("F" 6) ("G" 7) ("H" 8) ("I" 9) ("J" 10) ("K" 11) ("L" 12) ("M" 13) ("N" 14) ("O" 15) ("P" 16) ("Q" 17) ("R" 18) ("S" 19) ("T" 20) ("U" 21) ("V" 22) ("W" 23) ("X" 24) ("Y" 25) ("Z" 26)))
    (setq tri (map (fn (n) (/ (* n (+ n 1)) 2)) (sequence 1 27)))
    (setq parole (parse (read-file "words42.txt") ","))
    (dolist (parola parole)
      (setq valore 0)
      (dolist (el (explode parola))
        (setq valore (+ valore (lookup el alfa)))
      )
      (if (ref valore tri) (++ out))
    )
    out
  )
)

(e042)
;-> 162

(time (e042))
;-> 31.244


===========
Problema 43
===========

Divisibilità sotto-stringhe

Il numero, 1406357289, è un numero da 0 a 9 pandigitale perché è composto da ciascuna delle cifre da 0 a 9 in un certo ordine, ma ha anche una proprietà di divisibilità della sotto-stringhe piuttosto interessante.

Sia d(1) la prima cifra, d(2) la seconda cifra e così via. In questo modo, notiamo quanto segue:

d(2)d(3)d(4) = 406 è divisibile per 2
d(3)d(4)d(5) = 063 è divisibile per 3
d(4)d(5)d(6) = 635 è divisibile per 5
d(5)d(6)d(7) = 357 è divisibile per 7
d(6)d(7)d(8) = 572 è divisibile per 11
d(7)d(8)d(9) = 728 è divisibile per 13
d(8)d(9)d(10) = 289 è divisibile per 17

Trovare la somma di tutti i numeri pandigital da 0 a 9 con questa proprietà.
============================================================================

Se d(4)d(5)d(6) è divisibile per 5, allora d(6) deve valere 5 (d(5) se zero-based).

(define (list2int lst)
  (let (n 0)
    (for (i 0 (- (length lst) 1))
      (setq n (+ n (* (lst i) (pow 10 (- (length lst) i 1)))))
    )
  )
)

(define (insert l n e)
  (if (= 0 n)
      (cons e l)
      (cons (first l)
            (insert (rest l) (- n 1) e))))

(define (seq start end)
  (if (= start end)
      (list end)
      (cons start (seq (+ start 1) end))))

(define (permute l)
  (if (null? l) '(())
      (apply append (map (lambda (p)
                           (map (lambda (n) (insert p n (first l))) (seq 0 (length p))))
                         (permute (rest l))))))

(define (e043)
  (local (numeri p10 a)
    (setq numeri '())
    (setq p10 (permute '(0 1 2 3 4 6 7 8 9)))
    (dolist (p p10)
      (if (!= (p 0) 0) ;scartare le permutazioni che iniziano con 0
        (begin
          (push 5 p 5) ; p(5) deve valere 5
          (setq n1 (+ (* (p 1) 100) (* (p 2) 10) (p 3)))
          (setq n2 (+ (* (p 2) 100) (* (p 3) 10) (p 4)))
          (setq n3 (+ (* (p 3) 100) (* (p 4) 10) (p 5)))
          (setq n4 (+ (* (p 4) 100) (* (p 5) 10) (p 6)))
          (setq n5 (+ (* (p 5) 100) (* (p 6) 10) (p 7)))
          (setq n6 (+ (* (p 6) 100) (* (p 7) 10) (p 8)))
          (setq n7 (+ (* (p 7) 100) (* (p 8) 10) (p 9)))
          (if (and (= (% n1 2) 0) (= (% n2 3) 0) (= (% n3 5) 0) (= (% n4 7) 0)
                   (= (% n5 11) 0) (= (% n6 13) 0) (= (% n7 17) 0))
              (push (list2int p) numeri)
          )
        )
      )
    )
    (list (apply + numeri) numeri)
  )
)

(e043)
;-> (16695334890 (4130952867 1430952867 4160357289 4106357289 1460357289 1406357289))

(time (e043))
;-> 1748.593


===========
Problema 44
===========

Numeri pentagonali

I numeri pentagonali sono generati dalla formula, P(n) = n*(3n-1)/2. I primi dieci numeri pentagonali sono:

1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

Si può vedere che P4 + P7 = 22 + 70 = 92 = P8. Tuttavia, la loro differenza, 70 - 22 = 48, non è pentagonale.

Trovare la coppia di numeri pentagonali, P(j) e P(k), per cui la loro somma e differenza sono pentagonali e D = |P(k) - P(j)| è ridotto al minimo: qual è il valore di D?
============================================================================

P(n) n-esimo numero pentagonale
N = numero dato

Affinchè un numero N sia pentagonale deve risultare:

P(n) = N  ==>  (3*n*n - n - 2*N) = 0  ==>  n = (1 + sqrt(24*N + 1))/6

Prima versione:

(define (penta? n)
; molto più veloce che cercare nella lista dei numeri pentagonali
  (let (i (div (add (sqrt (add 1 (mul 24 n))) 1) 6))
    (if (= 0 (sub i (int i))) true nil)
  )
)

Seconda versione (più veloce):

(define (penta? n)
; molto più veloce che cercare nella lista dei numeri pentagonali
  (if (= (mod (div (add (sqrt (+ 1 (mul 24 n))) 1) 6) 1) 0) true nil)
)

(penta? 176)
;-> true

(define (e044)
  (local (n penta stop i j out)
    (setq out nil)
    (setq penta (map (fn (n) (/ (* n (- (* 3 n) 1)) 2)) (sequence 1 10000)))
    (setq stop nil)
    (dolist (i penta (= stop true))
      (dolist (j penta (= stop true))
        (if (and (penta? (+ i j)) (penta? (abs (- i j))))
          (begin
            (setq stop true)
            (setq out (list i j (- j i)))
          )
        )
      )
    )
    out
  )
)

(e044)
;-> (1560090 7042750 5482660)

(time (e044))
;-> 5588.505


===========
Problema 45
===========

Triangolari, pentagonali ed esagonali

I numeri triangolari, pentagonali ed esagonali sono generati dalle seguenti formule:

Triangolari T(n) = n*(n + 1)/2 ==> 1, 3, 6, 10, 15, ...
Pentagonala P(n) = n*(3*n-1)/2 ==> 1, 5, 12, 22, 35, ...
Esagonale   H(n) = n*(2*n-1)   ==> 1, 6, 15, 28, 45, ...

Si può verificare che T(285) = P(165) = H(143) = (40755)

Trovare il prossimo numero triangolare che è anche pentagonale ed esagonale.
============================================================================

(define (tri n) (/ (* n (+ n 1)) 2))
(define (pen n) (/ (* n (- (* 3 n) 1)) 2))
(define (esa n) (* n (- (* 2 n) 1)))

(tri 285)
;-> 40755
(pen 165)
;-> 40755
(esa 143)
;-> 40755

Deve risultare:

t*(t + 1)/2 == p*(3*p-1)/2 == x*(2*x-1)

dove t -> indice triangolari
dove p -> indice pentagonali
dove x -> indice esagonali

La soluzione dell'uguaglianza:

t*(t + 1)/2 == x*(2*x-1)

vale: x = (t + 1)/2, t = 2*x - 1

Per t = 285 otteniamo x = (285 + 1)/2 = 143

Definiamo una funzione che genera l'indice del numero esagonale utilizzando l'indice del numero triangolare:

(define (xidx t) (/ (+ t 1) 2))

(xidx 285)
;-> 143

Vediamo come funziona:

(for (i 285 301 2)
  (println (tri i) { } (esa (xidx i))))
;-> 40755 40755
;-> 41328 41328
;-> 41905 41905
;-> 42486 42486
;-> 43071 43071
;-> 43660 43660
;-> 44253 44253
;-> 44850 44850
;-> 45451 45451

Adesso generiamo le tre sequenze di numeri:

(silent (setq trian (map tri (sequence 0 100000))))
(silent (setq penta (map pen (sequence 0 100000))))
(silent (setq esago (map esa (sequence 0 100000))))

Possiamo scrivere la soluzione controllando per ogni valore dell'indice del numero triangolare se esiste quel valore del numero triangolare nella lista dei numeri pentagonali:

(define (e045)
  (local (stop i)
    (setq i 287)
    (setq stop nil)
    (while (= stop nil)
      (setq x (xx i))
      ;(if (ref (esa x) penta) (begin (println i { } x { } (ref (esa x) penta) { } (esa x)) (setq stop true)))
      (if (ref (tri i) penta) (begin (println i { } x { } (ref (esa x) penta) { } (esa x)) (setq stop true)))
      (if (zero? (% i 1000))  (println i))
      (setq i (+ i 2))
    )
  )
)

(e045)
;-> 55385 27693 (31977) 1533776805

(time (e045))
;-> 19343.289

Possiamo usare la funzione "intersect" di newLISP per trovare il risultato:

(define (e045)
  (local (trian penta esago)
    (setq trian (map tri (sequence 1 100000)))
    (setq penta (map pen (sequence 1 100000)))
    (setq esago (map esa (sequence 1 100000)))
    (intersect (intersect trian penta) esago)
  )
)

(e045)
;-> (1 40755 1533776805)

(time (e045))
;-> 114.465

Questa soluzione è molto più veloce.


===========
Problema 46
===========

L'altra congettura di Goldbach

È stato proposto da Christian Goldbach che ogni numero composito dispari può essere scritto come la somma di un numero primo e due volte un quadrato.

9 = 7 + 2 × 1^2
15 = 7 + 2 × 2^2
21 = 3 + 2 × 3^2
25 = 7 + 2 × 3^2
27 = 19 + 2 × 2^2
33 = 31 + 2 × 1^2

Si scopre che la congettura era falsa.

Qual'è il più piccolo numero composito dispari che non può essere scritto come somma di un numero primo e due volte quadrato?
============================================================================

Per ogni numero dispari x:
- se x è un numero composito (cioè è un numero non primo) ==> non trovato
- per i che va da 1 a (* i i 2) se (x - i * i * 2) è primo ==> non trovato
  altrimenti ==> trovato

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Funzione che controlla se un numero soddisfa la congettura (se il numero è primo non soddisfa la congettura):

(define (check x)
  (local (out i stop limite)
    (cond ((primo? x) (setq out true))
          (true
            (setq i 1)
            (setq stop nil)
            (setq limite (* i i 2))
            (while (and (<= limite x) (= stop nil))
              (if (primo? (- x (* i i 2))) (begin (setq stop true) (setq out true)))
              (++ i)
              (setq limite (* i i 2))
            )
          )
    )
    out
  )
)

Scriviamo la funzione finale:

(define (e046)
  (local (num trovato)
    (setq num 11)
    (setq trovato false)
    (while (= trovato nil)
      (if (= (check num) nil) (setq trovato true))
      (setq num (+ num 2))
    )
    (- num 2)
  )
)


(e046)
;-> 5777

(time (e046))
;-> 31.247


===========
Problema 47
===========

Fattori primi distinti

I primi due numeri consecutivi con due fattori primi distinti sono:

14 = 2 × 7
15 = 3 × 5

I primi tre numeri consecutivi con tre fattori primi distinti sono:

644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Trova i primi quattro numeri interi consecutivi con quattro fattori primi distinti ciascuno. Qual è il primo di questi numeri?
============================================================================

Funzione che calcola il numero di fattori primi distitni di un numero:

(define (numFattDist n) (length (unique (factor n))))

(numFattDist 12345)
;-> 3

Possiamo scrivere la funzione finale:

(define (e047)
  (local (stop i)
    (setq i 134043)
    (while (= stop nil)
      (if (and (= (numFattDist i) 4)
               (= (numFattDist (+ i 1)) 4)
               (= (numFattDist (+ i 2)) 4)
               (= (numFattDist (+ i 3)) 4))
          (setq stop true)
      )
      (++ i)
      (if (= (% i 1000000) 0) (println i))
    )
    (-- i)
  )
)

(e047)
;-> 134043

(time (e047))
;-> 0


===========
Problema 48
===========

Auto potenze

La serie, 1^1 + 2^2 + 3^3 + ... + 10^10 = 10405071317.

Trova le ultime dieci cifre della serie, 1^1 + 2^2 + 3^3 + ... + 1000^1000.
============================================================================

Funzione che calcola la potenza di numeri interi (anche per numeri big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
  pot
)

Creiamo una lista con tutti i numeri da 1 a 1000 elevati a se stessi:
(setq a (map (fn (x) (potenza x x)) (sequence 1L 1000L)))

Sommiano tutti i valori della lista:
(setq b (apply + a))

Trasformiano il numero somma in stringa ed estraiamo le ultime 10 cifre (senza la L finale):
(setq c (pop (string b) -11 10))
;-> "9110846700"

Scriviamo la funzione:

(define (e048)
  (pop (string (apply + (map (fn (x) (potenza x x)) (sequence 1L 1000L)))) -11 10)
)

(e048)
;-> 9110846700

(time (e048))
;-> 265.614


===========
Problema 49
===========

Permutazioni prime

La sequenza aritmetica, 1487, 4817, 8147, in cui ciascun termine aumenta di 3330, è inusuale in due modi: (i) ciascuno dei tre termini è primo, e (ii) ciascuno dei numeri a 4 cifre è una permutazione degli altri.

Non ci sono sequenze aritmetiche composte da tre numeri primi di 1, 2 o 3 cifre, che esibiscono questa proprietà, ma esiste un'altra sequenza crescente di 4 cifre.

Quale numero di 12 cifre si forma concatenando i tre termini in questa sequenza?
============================================================================

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Funzione che converte un numero in una lista:

(define (int2list n)
  (let (out '())
    (while (!= n 0)
      (push (% n 10) out)
      (setq n (/ n 10))
    )
    out
  )
)

Limiti da considerare nella ricerca della soluzione: da 1001 a 9999

Filtro i numeri primi:

(setq a (filter primo? (sequence 1001 9999)))
(length a)
;-> 1061

Funzione che controlla se due numeri hanno le stesse cifre:

(define (cifreUguali x y)
  (if (= (sort (int2list x)) (sort (int2list y))))
)

(cifreUguali 1234 4231)
;-> true

Controllo tutti gli elementi della lista dei numeri primi per vedere se soddisfano le condizioni del problema:

(dolist (el a)
  (setq a1 el)
  (setq a2 (+ a1 3330))
  (setq a3 (+ a2 3330))
  (if (and (primo? a2) (primo? a3) (cifreUguali a1 a2) (cifreUguali a2 a3))
    (println a1 { } a2 { } a3)
  )
)
;-> 1487 4817 8147
;-> 2969 6299 9629

Possiamo scrivere la funzione finale:

(define (e049)
  (local (primi a1 a2 a3 out)
    (setq primi (filter primo? (sequence 1001 9999)))
    (dolist (el primi)
      (setq a1 el)
      (setq a2 (+ a1 3330))
      (setq a3 (+ a2 3330))
      (if (and (primo? a2) (primo? a3) (cifreUguali a1 a2) (cifreUguali a2 a3))
        (setq out (string a1 a2 a3))
        ;(println a1 { } a2 { } a3)
      )
    )
    out
  )
)

(e049)
;-> "296962999629"

(time (e049))
;-> 9.01


===========
Problema 50
===========

Somma di primi consecutivi

Il primo 41 può essere scritto come la somma di sei numeri primi consecutivi:

41 = 2 + 3 + 5 + 7 + 11 + 13

Questa è la somma più lunga di numeri primi consecutivi che si aggiunge a un numero primo inferiore a cento.

La somma più lunga di numeri primi consecutivi al di sotto di un migliaio che aggiunge un numero primo, contiene 21 termini ed è uguale a 953.

Quale primo, inferiore a un milione, può essere scritto come la somma dei numeri primi più consecutivi?
============================================================================

Funzione per i numeri primi:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

Limiti da considerare nella ricerca della soluzione: da 2 a 1000000

Filtro i numeri primi:

(silent (setq primi (filter primo? (sequence 2 1000000))))
(length primi)
;-> 78490

(slice primi 0 10)

(define (e050)
  (local (primi lenprimi somma sommaMax limite i j stop)
    (setq somma 0)
    (setq limite -1)
    (setq primi (filter primo? (sequence 2 1000000)))
    (setq lenprimi (length primi))
    (setq i 2)
    (while (< i lenprimi)
      (setq somma 0)
      (setq stop nil)
      (setq j i)
      (while (and (< j lenprimi) (= stop nil))
        (setq somma (+ somma (primi j)))
        (if (> somma 1000000) (setq stop true)
        ;else
        (if (and (> (- j i) limite) (> somma sommaMax) (primo? somma))
          (begin
            (setq sommaMax somma)
            (setq limite (- j i))
          )
        ))
        (++ j)
      )
      (++ i)
      ;(if (= (% i 10000)) (println i))
    )
    sommaMax
  )
)

(e050)
;-> 997651

(time (e050))
;-> 27113

I numeri coinvolti nella soluzione sono i seguenti:

(997651 543 (7 11 13 17 19 23 29 31 37 41 43 47 53
59 61 67 71 73 79 83 89 97 101 103 107 109 113 127
131 137 139 149 151 157 163 167 173 179 181 191 193
197 199 211 223 227 229 233 239 241 251 257 263 269
271 277 281 283 293 307 311 313 317 331 337 347 349
353 359 367 373 379 383 389 397 401 409 419 421 431
433 439 443 449 457 461 463 467 479 487 491 499 503
509 521 523 541 547 557 563 569 571 577 587 593 599
601 607 613 617 619 631 641 643 647 653 659 661 673
677 683 691 701 709 719 727 733 739 743 751 757 761
769 773 787 797 809 811 821 823 827 829 839 853 857
859 863 877 881 883 887 907 911 919 929 937 941 947
953 967 971 977 983 991 997 1009 1013 1019 1021 1031
1033 1039 1049 1051 1061 1063 1069 1087 1091 1093 1097
1103 1109 1117 1123 1129 1151 1153 1163 1171 1181 1187
1193 1201 1213 1217 1223 1229 1231 1237 1249 1259 1277
1279 1283 1289 1291 1297 1301 1303 1307 1319 1321 1327
1361 1367 1373 1381 1399 1409 1423 1427 1429 1433 1439
1447 1451 1453 1459 1471 1481 1483 1487 1489 1493 1499
1511 1523 1531 1543 1549 1553 1559 1567 1571 1579 1583
1597 1601 1607 1609 1613 1619 1621 1627 1637 1657 1663
1667 1669 1693 1697 1699 1709 1721 1723 1733 1741 1747
1753 1759 1777 1783 1787 1789 1801 1811 1823 1831 1847
1861 1867 1871 1873 1877 1879 1889 1901 1907 1913 1931
1933 1949 1951 1973 1979 1987 1993 1997 1999 2003 2011
2017 2027 2029 2039 2053 2063 2069 2081 2083 2087 2089
2099 2111 2113 2129 2131 2137 2141 2143 2153 2161 2179
2203 2207 2213 2221 2237 2239 2243 2251 2267 2269 2273
2281 2287 2293 2297 2309 2311 2333 2339 2341 2347 2351
2357 2371 2377 2381 2383 2389 2393 2399 2411 2417 2423
2437 2441 2447 2459 2467 2473 2477 2503 2521 2531 2539
2543 2549 2551 2557 2579 2591 2593 2609 2617 2621 2633
2647 2657 2659 2663 2671 2677 2683 2687 2689 2693 2699
2707 2711 2713 2719 2729 2731 2741 2749 2753 2767 2777
2789 2791 2797 2801 2803 2819 2833 2837 2843 2851 2857
2861 2879 2887 2897 2903 2909 2917 2927 2939 2953 2957
2963 2969 2971 2999 3001 3011 3019 3023 3037 3041 3049
3061 3067 3079 3083 3089 3109 3119 3121 3137 3163 3167
3169 3181 3187 3191 3203 3209 3217 3221 3229 3251 3253
3257 3259 3271 3299 3301 3307 3313 3319 3323 3329 3331
3343 3347 3359 3361 3371 3373 3389 3391 3407 3413 3433
3449 3457 3461 3463 3467 3469 3491 3499 3511 3517 3527
3529 3533 3539 3541 3547 3557 3559 3571 3581 3583 3593
3607 3613 3617 3623 3631 3637 3643 3659 3671 3673 3677
3691 3697 3701 3709 3719 3727 3733 3739 3761 3767 3769
3779 3793 3797 3803 3821 3823 3833 3847 3851 3853 3863
3877 3881 3889 3907 3911 3917 3919 3923 3929 3931))


