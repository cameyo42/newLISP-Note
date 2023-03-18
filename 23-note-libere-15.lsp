================

 NOTE LIBERE 15

================

-------------------------------
Potenze più vicine ad un numero
-------------------------------

Dati due numeri interi N e K, trovare la prima potenza di K inferiore a N e la prima potenza di K superiore a N.

Per esempio, con N = 8 e K = 3:
Le potenze di 3 sono: 3, 9, 27, 81, ...
La prima potenza di 3 inferiore a 8 vale: 3
La prima potenza di 3 superiore a 8 vale: 9

In generale:
- la prima potenza minore di N vale K^floor(logk(N)).
- la prima potenza maggiore di N vale K^ceil(logk(N)).

Dobbiamo solo stare attenti quando N è una potenza perfetta di K (perchè i numeri floating point sono pericolosi).

(define (close-power num k)
  (local (eps lg p1 p2 a b)
    (setq eps 1e-6)
    (setq lg (log num k))
    (setq p1 (floor lg))
    (setq p2 (ceil  lg))
    (setq a (pow k p1))
    (setq b (pow k p2))
    ; controlla se num è una potenza perfetta di k
    (cond ((> eps (abs (sub num a)))
            (setq a (pow k (- p1 1)))
            (setq b (pow k (+ p1 1))))
          ((> eps (abs (sub num b)))
            (setq a (pow k (- p2 1)))
            (setq b (pow k (+ p2 1))))
    )
    (list a b)))

Facciamo alcune prove:

(close-power 8 3)
;-> (3 9)
(close-power 81 3)
;-> (27 243)
(close-power 1000 10)
;-> (100 10000)
(close-power 100 10)
;-> (10 1000)
(close-power 78125 5)
;-> (15625 390625)


------------------------------------------------
Problemi di pesatura (con bilancia a due piatti)
------------------------------------------------

Un problema di pesatura è un puzzle logico sul peso di oggetti, spesso monete, per determinare quale ha un valore diverso, utilizzando una bilancia a due piatti un numero limitato (minimo) di volte.
Questo tipo di puzzle comprende i seguenti tre casi:

1) La moneta target è più leggera o più pesante delle altre
Bisogna identificare la moneta target.
Numero massimo di monete con N pesature: 3^N
Numero di pesature necessarie con M monete: ceil(log3(M))

2) La moneta target è diversa dalle altre
Bisogna identificare la moneta target.
Numero massimo di monete con N pesature: (3^N - 1)/2
Numero di pesature necessarie con M monete: ceil(log3(2*M + 1))

3) La moneta target è diversa dalle altre o tutte le monete sono uguali
Bisogna identificare se esiste una moneta unica e se è più leggera o più pesante.
Numero massimo di monete con N pesature: (3^N - 1)/2 - 1
Numero di pesature necessarie con M monete: ceil(log3(2*M + 3))

Ad esempio, cercando una moneta diversa con tre pesate (n = 3), il numero massimo di monete analizzabili è (3^3 − 1)/2 = 13.
Con 3 pesate e 13 monete non è sempre possibile determinare l'identità dell'ultima moneta (se è più pesante o più leggera delle altre), ma semplicemente che la la moneta è diversa.
In generale, con n pesate, è possibile determinare l'identità di una moneta se abbiamo (3n − 1)/2 - 1 monete o meno.
Nel caso n = 3, è possibile identificare la moneta diversa su 12 monete.

Vediamo due esempi classici:

Problema delle nove monete
--------------------------
Abbiamo nove monete dal peso uguale tranne una, che è più leggera delle altre. Dobbiamo identificare la moneta diversa utilizzando il minor numero di pesate con una bilancia a due piatti.

Soluzione
Il numero massimo di monete tra le quali è possibile trovare quella più leggera in una sola pesata vale 3.
Infatti, per trovare quella più leggera, possiamo confrontare due monete qualsiasi, escludendo la terza.
Se le due monete hanno lo stesso peso, allora la moneta più leggera deve essere una di quelle non sulla bilancia.
Altrimenti è quello indicata come più leggera dalla bilancia.
Adesso consideriamo le nove monete in tre pile di tre monete ciascuna.
In una sola mossa possiamo trovare quale delle tre pile è più leggera (ovvero quella contenente la moneta più leggera).
Ci vuole quindi solo un'altra mossa per identificare la moneta leggera dall'interno di quella pila più leggera.
Quindi, in due pesate, possiamo trovare una singola moneta leggera da un insieme di 3 * 3 = 9.
Per estensione, basterebbero solo 3 pesate per trovare la moneta più leggera tra 27 monete e 4 pesate per trovarla da 81 monete.

Problema delle dodici monete (Grossman, Howard (1945). Scripta Mathematica XI)
------------------------------------------------------------------------------
Un problema più complesso consiste in 12 monete, in cui 11 o dodici sono uguali. Se una è diversa, non sappiamo se è più pesante o più leggera delle altre. In questo caso bastano 3 pesate per determinare se esiste una moneta unica e, in tal caso, per isolarla e determinarne il peso rispetto alle altre.

Soluzione
La soluzione proposta è facilmente scalabile a un numero maggiore di monete utilizzando la numerazione in base tre: etichettando ogni moneta con un diverso numero di tre cifre in base tre e posizionando all'n-esima pesatura di tutte le monete etichettate con l'n-esima cifra identica all'etichetta del piatto (con tre piatti, uno su ciascun lato della scala etichettati 0 e 2, e uno al centro scala (pareggio) etichettato 1). Per questo problema la seconda e la terza pesatura potrebbero dipendere da ciò che è accaduto in precedenza.

Quattro monete sono messe su ogni lato. Ci sono due possibilità:
1. Un lato è più pesante dell'altro. In tal caso, rimuovere tre monete dal lato più pesante, spostare tre monete dal lato più leggero a quello più pesante e posizionare tre monete che non sono state pesate la prima volta sul lato più leggero. (Ricorda quali monete sono quali.) Ci sono tre possibilità:
  1.a) Lo stesso lato che era più pesante la prima volta è ancora più pesante. Ciò significa che la moneta che è rimasta lì è più pesante o che la moneta che è rimasta sul lato più leggero è più leggera. Bilanciare una di queste contro una delle altre dieci monete rivela quale di queste è vera, risolvendo così il puzzle.
  1.b) Il lato che era più pesante la prima volta è più leggero la seconda volta. Ciò significa che una delle tre monete che sono andate dal lato più leggero a quello più pesante è la moneta leggera. Per il terzo tentativo, pesa due di queste monete l'una contro l'altra: se una è più leggera, è l'unica moneta, se si bilanciano, la terza moneta è quella leggera.
  1.c) Entrambi i lati sono pari. Ciò significa che una delle tre monete che è stata rimossa dal lato più pesante è la moneta pesante. Per il terzo tentativo, pesa due di queste monete l'una contro l'altra: se una è più pesante, è l'unica moneta, se si bilanciano, la terza moneta è quella pesante.
2. Entrambi i lati sono pari. In tal caso, tutte e otto le monete sono identiche e possono essere messe da parte. Prendi le quattro monete rimanenti e posizionane tre su un lato della bilancia. Posiziona 3 delle 8 monete identiche sull'altro lato. Ci sono tre possibilità:
  2.a) Le tre monete rimanenti sono più leggere. In questo caso ora sai che una di quelle tre monete è quella dispari e che è più leggera. Prendi due di quelle tre monete e pesale l'una contro l'altra. Se la bilancia si inclina, la moneta più leggera è quella dispari. Se le due monete si bilanciano, la terza moneta non in bilico è quella dispari ed è più leggera.
  2.b) Le tre monete rimanenti sono più pesanti. In questo caso ora sai che una di quelle tre monete è quella dispari e che è più pesante. Prendi due di quelle tre monete e pesale l'una contro l'altra. Se la bilancia si ribalta, la moneta più pesante è quella dispari. Se le due monete si bilanciano, la terza moneta non in bilico è quella dispari ed è più pesante.
  2.c) Saldo delle tre monete rimanenti. In questo caso devi solo pesare la moneta rimanente contro una qualsiasi delle altre 11 monete e questo ti dice se è più pesante, più leggera o uguale.

Una bilancia a piatti ha naturalmente 3 posizioni: a sinistra, a destra e in equilibrio.
Nella tabella sottostante, accanto a ciascun numero di moneta c'è il numero della triade. La terza colonna fornisce un secondo numero di triade ottenuto cambiando ogni 0 in 2 e ogni 2 in 0 dal primo numero di triade.

 numero  ternario  modificato
   1       001*      221
   2       002*      220
   3       010*      212
   4       011       211*
   5       012*      210
   6       020       202*
   7       021       201*
   8       022       200*
   9       100       122*
  10       101       121*
  11       102       120*
  12       110       112*

Quindi sceglere quelli in cui le prime due cifre disuguali sono uguali a 01, 12 o 20. Questi sono segnati con l'asterisco "*" nella tabella.

Come prima pesatura le monete con la prima cifra 2 vanno a destra e quelle con la prima cifra 0 a sinistra:

  001       200
  010       201
  011       202
  012       220

Se c'è un saldo, scriviamo 1 come prima cifra della moneta contraffatta. Quando la bilancia di sinistra scende scriviamo 0, quando quella di destra scende scriviamo 2.
Per la seconda pesata facciamo lo stesso con la seconda cifra delle monete, quindi:

  001       120
  200       121
  201       122
  202       220

Ancora una volta scriviamo un 1, 0 o 2 come secondo numero, a seconda che la scala sia bilanciata, oscilla a sinistra o oscilla a destra.
Infine, facciamo di nuovo la stessa cosa, ora con la terza cifra delle monete:

  010       012
  120       112
  200       122
  220       202

È così che finalmente otteniamo il numero della moneta contraffatta.
Possiamo capire dai pesi se la moneta era troppo leggera o troppo pesante.
La moneta è troppo pesante se il numero trovato era anche il numero usato della moneta.
Se la moneta era troppo leggera, troviamo l'altro numero che appartiene alla moneta.

Nota: questo problema ha una variante più semplice con 3 monete in 2 pesate, e una variante più complessa con 39 monete in 4 pesate.


-------------------------------------------
Problemi di pesatura (con bilancia a molla)
-------------------------------------------

Ci sono N monete dall'aspetto identico. N − 1 sono autentiche con un peso noto P e una, di un peso sconosciuto diverso da P, è falsa.
Determinare il numero minimo di pesate, con una bilancia a molla, necessarie per identificare la moneta falsa.
La bilancia a molla indica il peso esatto delle monete pesate.

Soluzione
---------
Il numero minimo di pesate necessarie per garantire l'identificazione della moneta falsa è ceil(log2 N).
Si consideri un sottoinsieme arbitrario S di M ≥ 1 monete selezionate tra le N monete fornite.
Se il suo peso totale T è uguale a P*M, tutte le monete in S sono autentiche, altrimenti una delle monete in S è falsa.
Possiamo quindi procedere alla ricerca del falso tra le monete non in S nel primo caso e tra le monete in S nel secondo caso.
Se S contiene la metà (o quasi la metà) delle monete date, dopo una pesatura possiamo procedere alla ricerca del falso in un insieme grande la metà.
Dovremo ripetere questa operazione di dimezzamento e pesatura ceil(log2 N) volte prima che N, la dimensione dell'insieme originale, possa essere sicuramente ridotto a 1.
Dal punto di vista matematico, il numero di pesate nel caso peggiore è definito dalla funzione ricorsiva:

   W(n) = W(ceil(n/2)) + 1 per n > 1,
   W(1) = 0

la cui soluzione è: W(n) = ceil(log2 n).


-----------------------------
Punto interno ad un triangolo
-----------------------------

Date le coordinate dei tre vertici di un triangolo e un altro punto P, scrivere una funzione per verificare se P si trova all'interno del triangolo oppure no.
Esempi:
  A = (0 0), B = (10 30), C = (20 0)
  P = (10 15)
  Il punto è interno.

  A = (0 0), B = (10 30), C = (20 0)
  P = (30 15)
  Il punto è esterno.

Algoritmo
Siano (x1 y1), (x2 y2) e (x3 y3) le coordinate dei tre vertici del triangolo.
Sia (x y) le coordinate del punto dato P.
Calcolare l'area del triangolo ABC:
  Area A = [x1(y2 – y3) + x2(y3 – y1) + x3(y1 - y2)]/2
Calcolare l'area del triangolo PAB. Sia quest'area A1.
Calcolare l'area del triangolo PBC. Sia quest'area A2.
Calcolare l'area del triangolo PAC. Sia quest'area A3.
Il punto P si trova all'interno del triangolo se e solo se:
  (A1 + A2 + A3) è uguale ad A (+- epsilon).

Funzione che calcola l'area di un triangolo dati i tre vertici:

(define (area-triangle x1 y1 x2 y2 x3 y3)
  (abs (div (add (mul x1 (sub y2 y3))
                 (mul x2 (sub y3 y1))
                 (mul x3 (sub y1 y2))) 2)))

Funzione che verifica se un punto è interno ad un triangolo:

(define (inside-triangle? x y x1 y1 x2 y2 x3 y3)
  (local (eps a a1 a2 a3)
    (setq eps 1e-6) ; compensate rounding errors
    (setq a  (area-triangle x1 y1 x2 y2 x3 y3))
    (setq a1 (area-triangle x y x2 y2 x3 y3))
    (setq a2 (area-triangle x1 y1 x y x3 y3))
    (setq a3 (area-triangle x1 y1 x2 y2 x y))
    ;(println a { } (add a1 a2 a3) { } a1 { } a2 { } a3)
    (> eps (abs (sub a (add a1 a2 a3))))))

Facciamo alcune prove:

(inside-triangle? 10 15 0 0 20 0 10 30 10 15)
;-> true

(inside-triangle? 0 2 0 0 4 0 0 4)
;-> true

(inside-triangle? 1 0 0 0 2 0 1 1)
;-> true


------------------------------
Punto interno ad un rettangolo
------------------------------

Date le coordinate dei quattro vertici di un rettangolo e un altro punto P, scrivere una funzione per verificare se P si trova all'interno del rettangolo oppure no.

Primo metodo
------------
Dividiamo il rettangolo in 4 triangoli e calcoliamo la somma delle loro aree.
Se la somma dei triangoli è uguale all'area del rettangolo, allora il punto è interno al rettangolo.

Funzione che calcola l'area di un triangolo dati i tre vertici:

(define (area-triangle x1 y1 x2 y2 x3 y3)
  (abs (div (add (mul x1 (sub y2 y3))
                 (mul x2 (sub y3 y1))
                 (mul x3 (sub y1 y2))) 2)))

(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

Funzione che calcola l'area di un rettangolo dati i quattro vertici:

(define (area-rectangle x1 y1 x2 y2 x3 y3 x4 y4)
  (mul (dist2d x1 y1 x2 y2) (dist2d x2 y2 x3 y3)))

Funzione che verifica se un punto è interno ad un rettangolo:

(define (inside-rect? x y x1 y1 x2 y2 x3 y3 x4 y4)
  (local (eps a a1 a2 a3 a4)
    (setq eps 1e-6) ; compensate rounding errors
    (setq a  (area-rectangle x1 y1 x2 y2 x3 y3 x4 y4))
    (setq a1 (area-triangle x y x1 y1 x2 y2))
    (setq a2 (area-triangle x y x2 y2 x3 y3))
    (setq a3 (area-triangle x y x3 y3 x4 y4))
    (setq a4 (area-triangle x y x1 y1 x4 y4))
    ; (println a { } (add a1 a2 a3 a4) { } a1 { } a2 { } a3 { } a4)
    (> eps (abs (sub a (add a1 a2 a3 a4))))))

Vediamo alcuni esempi:

(inside-rect? -1 -1 -2 -2 -2 8 10 8 10 -2)
;-> true
(inside-rect? 2 2 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> nil
(inside-rect? 5.5 0.5 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> true

Secondo metodo
--------------
Supponiamo di avere un rettangolo con punti in p1 = (x1, y1), p2 = (x2, y2), p3 = (x3, y3) e p4 = (x4, y4), procedendo in senso orario.
Se un punto p = (x, y) giace all'interno del rettangolo, allora il prodotto scalare (p - p1).(p2 - p1) sarà compreso tra 0 e |p2 - p1|^2, e (p - p1).(p4 - p1) sarà compreso tra 0 e |p4 - p1|^2.
Ciò equivale a prendere la proiezione del vettore p - p1 lungo la lunghezza e la larghezza del rettangolo, con p1 come origine.

(define (inside-rect? x y x1 y1 x2 y2 x3 y3 x4 y4)
  (local (p21x p21y p41x p41y p21mag-sq p41mag-sq px py v1 v2 out)
    (setq p21x (sub x2 x1))
    (setq p21y (sub y2 y1))
    (setq p41x (sub x4 x1))
    (setq p41y (sub y4 y1))
    (setq p21mag-sq (add (mul p21x p21x) (mul p21y p21y)))
    (setq p41mag-sq (add (mul p41x p41x) (mul p41y p41y)))
    (setq px (sub x x1))
    (setq py (sub y y1))
    (setq v1 (add (mul px p21x) (mul py p21y)))
    (setq v2 (add (mul px p41x) (mul py p41y)))
    (if (and (>= v1 0) (<= v1 p21mag-sq))
        (if (and (>= v2 0) (<= v2 p41mag-sq))
          (setq out true)
          ;else
          (setq out nil)
        )
        ;else
        (setq out nil)
    )
    out))

Vediamo alcuni esempi:

(inside-rect? -1 -1 -2 -2 -2 8 10 8 10 -2)
;-> true
(inside-rect? 2 2 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> nil
(inside-rect? 5.5 0.5 3.5 5 7.5 1 5.5 -1 1.5 3)
;-> true


----------------------------------------
Ricerca in una lista di numeri adiacenti
----------------------------------------

Data una lista di numeri interi positivi in cui due elementi vicini sono adiacenti (con differenza assoluta 1), scrivere un algoritmo per cercare un elemento nella lista e restituirne la posizione.
Se l'elemento appare più volte, restituire la prima occorrenza.

Ad esempio:
lista = (3 4 5 6 5 6 7 8 7 8 9)
numero = 8
Il numero appare due volte nella lista e la prima occorrenza è nella posizione 7.

Algoritmo
Partiamo dalla posizione 0 dove si trova il numero 3.
La differenza tra 3 e 8 vale 5, quindi ci spostiamo nella posizione 5. Perchè?
Perché la differenza assoluta tra due elementi vicini è 1.
Se i numeri nella lista fossero ordinati in modo crescente, l'elemento in posizione 5 sarebbe 9.
Se alcuni elementi diminuiscono, allora 8 dovrebbe trovarsi a destra della posizione 5.
Pertanto, 5 è la posizione più a sinistra possibile per il numero 8.
Alla posizione 5 troviamo il numero 6. La differenza tra 8 e 6 vale 2.
Quindi ci spostiamo 2 posizioni in avanti (dalla posizione 5) nella posizione 7.
Nella posizione 7 troviamo il numero 8.

Proviamo a cercare un numero che non esiste nella lista, ad esempio 2.
Alla posizione 0 troviamo il 3, la differenza 3 - 2 vale 1.
Alla posizione 1 troviamo 4, 4 - 2 = 2.
Alla posizione 3 (2+1) troviamo 6, 6 - 2 = 4.
Alla posizione 7 (4+3) troviamo 8, 8 - 2 = 6.
Alla posizione 13 (6+7) abbiamo supreato la lunghezza della lista e restituiamo nil.

Possiamo riassumere la soluzione: iniziamo dal primo elemento dell'elemento e lo confrontiamo con il numero dato.
Se la differenza assoluta è K, ci spostiamo a destra della distanza K (partendo dalla posizione corrente).
Quindi confrontiamo l'elemento attualmente visitato.
Ripetere finché non viene trovato l'elemento specificato o la posizione è oltre la lunghezza della lista quando l'elemento cercato non si trova nella lista.

(define (cerca val nums)
  (local (len idx delta)
    (setq len (length nums))
    (setq idx 0)
    (while (and (< idx len) (!= (nums idx) val))
      ;(println idx { } (nums idx))
      (setq delta (abs (sub val (nums idx))))
      ;(println delta)
      (++ idx delta)
    )
    (if (< idx len) idx nil)))

(setq lst '(3 4 5 6 5 6 7 8 7 8 9))

(cerca 7 lst)
;-> 6

(cerca 2 lst)
;-> nil


-----------
Super primi
-----------

I numeri super primi sono la sottosequenza di numeri primi che occupano posizioni prime all'interno della sequenza di tutti i numeri primi.

posizione:    (0)  1  2  3  4  5   6
numeri primi: (1)  2  3  5  7  11  13
super primi:          3  5     11

Sequenza OEIS A006450:
  3, 5, 11, 17, 31, 41, 59, 67, 83, 109, 127, 157, 179, 191, 211, 241, 277,
  283, 331, 353, 367, 401, 431, 461, 509, 547, 563, 587, 599, 617, 709, 739,
  773, 797, 859, 877, 919, 967, 991, 1031, 1063, 1087, 1153, 1171, 1201, 1217,
  1297, 1409, 1433, 1447, 1471, ...

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

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che genera tutti i super primi minori o uguali ad un dato numero:

(define (super-primes-to num)
  (let ( (primes (primes-to num)) (out '()) )
    (push 1 primes)
    (dolist (p primes)
      (if (prime? $idx) (push p out -1))
    )
    out))

(super-primes-to 1000)
;-> (3 5 11 17 31 41 59 67 83 109 127 157 179 191 211 241 277
;->  283 331 353 367 401 431 461 509 547 563 587 599 617 709 739
;->  773 797 859 877 919 967 991)


-----------
Candy crush
-----------

Data una lista non vuota composta esclusivamente da cifre nell'intervallo [1-9], scrivere una funzione che applichi la regola "match-3" da sinistra a destra e genera la stringa risultante.
Esempi:

Input: (1 2 2 2 3) -> Output (1 3)
Input: (1 3 2 2 2 3 2 2 2 3 2 2 2 3 1 1) -> Output (1 3 1 1)

Vale a dire, mentre si analizza la stringa da sinistra a destra se si incontra la stessa cifra ripetuta 3 o più volte di seguito, l'intero gruppo di cifre deve "scomparire", risultando nella concatenazione della parte sinistra e destra della stringa rimanente.
Ogni volta che abbiamo a che fare con un gruppo, dobbiamo ricominciare dall'estremità sinistra e ripetere lo stesso processo fino a quando la lista non cambia più (normalmente quando finalmente si raggiunge l'estremità destra).
Se la lista diventa vuota alla fine del processo, restituire la lista vuota.

(define (candycrush lst num)
  (local (len idx palo palo-idx uguali)
    (setq len (length lst))
    (setq idx 1)
    (setq palo-idx 0)
    (setq palo (lst 0))
    (setq uguali 1)
    (while (< idx len)
      (cond ((= palo (lst idx)) ; caratteri uguali
              (++ uguali)
              (++ idx))
            ((!= palo (lst idx)) ; caratteri diversi
              ; controllo se i caratteri precedenti erano uguali
              ; in numero >= 3
              (if (>= uguali 3)
                (begin
                  ; eliminazione dei caratteri uguali
                  (for (i 1 uguali) (pop lst palo-idx))
                  ; impostazione dall'inizio per una nuova ricerca
                  (setq len (length lst))
                  (setq idx 1)
                  (setq palo-idx 0)
                  (setq palo (lst 0))
                  (setq uguali 1)
                )
                ;else
                (begin
                  ; nuovo palo
                  (setq palo-idx idx)
                  (setq palo (lst idx))
                  (setq uguali 1)
                  (++ idx)
                )))
      )
   )
   ; fine della stringa e
   ; controllo se i caratteri precedenti erano uguali in numero >= 3
   (if (>= uguali 3) (for (i 1 uguali) (pop lst -1)))
   lst))

Facciamo alcune prove:

(setq a '(1 2 3 3 3 1))
(setq b '(1 3 2 2 2 3 2 2 2 3 1 1 1))
(setq c '(1 3 2 2 3 3 3 2 2 2 3 1))
(setq d '(1 3 2 2 3 3 3 2 2 2 3 3))

(candycrush a)
;-> (1 2 1)
(candycrush b)
;-> ()
(candycrush c)
;-> (1 3 3 1)
(candycrush d)
;-> (1)


------------------------------
Primi con cifre prime univoche
------------------------------

Scrivere una funzione che genera tutti i numeri primi in cui ogni singola cifra è un numero primo e compare solo una volta.

Sequenza OEIS A124674:
  2, 3, 5, 7, 23, 37, 53, 73, 257, 523, 2357, 2753, 3257, 3527,
  5237, 5273, 7253, 7523.

Le cifre prime sono 2, 3, 5 e 7.
Il numero più grande che possiamo formare vale 7532.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Come facciamo a verificare se un numero è composto solo dalle cifre 2, 3, 5 e 7 che compaiono solo una volta?
Un metodo è il seguente:
Convertire il numero in una lista ordinata --> lst
Fare l'intersezione tra (2 3 5 7) e lst --> res
Se lst = res allora il numero è composto solo dalle cifre 2, 3, 5 e 7 che compaiono solo una volta.

(setq num 3256)
(setq lst (sort (int-list num)))
;-> (2 3 5 6)
(setq res (intersect '(2 3 5 7) lst))
;-> (2 3 5)
res != lst --> numero non corretto

(setq num 375)
(setq lst (sort (int-list num)))
;-> (3 5 7)
(setq res (intersect '(2 3 5 7) lst))
;-> (3 5 5)
res = lst --> numero corretto

Funzione che genera tutti i numeri primi in cui ogni singola cifra è un numero primo e compare solo una volta:

(define (primis)
  (let (out'())
    (for (num 2 7532)
      (if (and (prime? num)
          (= (intersect '(2 3 5 7) (sort (int-list num))) (sort (int-list num))))
          (push num out -1)
      )
    )
    out))

(primis)
;-> (2 3 5 7 23 37 53 73 257 523 2357 2753 3257 3527 5237 5273 7253 7523)

Nota:
  2357 è il numero primo più piccolo che contiene tutte le cifre prime.
  2^2 + 3^3 + 5^5 + 7^7 è primo.
  (+ (* 2 2) (* 3 3 3) (* 5 5 5 5 5) (* 7 7 7 7 7 7 7))
  ;-> 826699
  (prime? 826699)
  ;-> true
  (2*3*5*7+2+3+5+7) e (2*3*5*7-2-3-5-7) sono entrambi primi.
  (+ (* 2 3 5 7) 2 3 5 7)
  ;-> 227
  (prime? 227)
  ;-> true
  (- (* 2 3 5 7) 2 3 5 7)
  ;-> 193
  (prime? 193)
  ;-> true


---------------------------------------------------------
Polinomi generatori di sequenze - Metodo delle differenze
---------------------------------------------------------

Spesso è utile trovare una formula per una sequenza di numeri. Avere una tale formula ci consente di prevedere altri numeri nella sequenza, vedere quanto velocemente cresce la sequenza, esplorare le proprietà matematiche della sequenza e talvolta trovare relazioni tra una sequenza e un'altra.

Se abbiamo una sequenza (parziale) di numeri, come possiamo ricavarne una formula?
Non esiste un metodo che funzionerà sempre per tutte le sequenze, ma esistono metodi che funzioneranno per determinati tipi di sequenze. In questo caso vediamo un metodo per determinare una formula polinomiale per una sequenza.

Esempio 1
---------
Supponiamo di avere la seguente sequenza:

    n  = 1 2  3  4  5  6
  S(n) = 4 7 10 13 16 19

La sequenza è generata da n quadrati possibilmente sovrapposti che condividono esattamente un vertice (angolo).
In altre parole, c'è un punto che è un vertice di ciascuno dei quadrati, ma nessun altro punto è un vertice di più di un quadrato.
Vedi immagine "quad-vertici.png" nella cartella "data".

Vorremmo trovare una formula polinomiale per f(n) in termini di n.
Calcoliamo le differenze tra numeri successivi nella sequenza, scrivendo questi valori in una riga sotto la riga f(n).

  S(n) = 4 7 10 13 16 19
          3 3  3  3  3

Quando otteniamo valori tutti uguali per le differenze ci fermiamo.
Poichè abbiamo calcolato solo una volte le differenze, allora la formula polinomiale avrà grado uno.
In altre parole, il grado del polinomio è dato dal numero delle volte che abbiamo calcolato le differenze per arrivare a valori uguali.

In questo esempio il polinomio è lineare (grado uno) e in generale vale:

  P(n) = A*n + B

Adesso dobbiamo calcolare i valori di A e B con un sistema di due equazioni e due incognite (A e B).
Le equazioni vengono definite utilizzando i primi valori della sequenza:

  P(1) = A + B = 4
  P(2) = 2A + B = 7

Risolvendo il sistema si ottengono i valori delle incognite:

  A = 3, B = 1

Che sostituite nel polinomio generico di primo grado produce il nostro polinomio generatore:

  P(n) = 3*n + 1

Verifichiamo i valori della sequenza e oltre:

(define (p n) (+ (* 3 n) 1))
(map p (sequence 1 10))
;-> (4 7 10 13 16 19 22 25 28 31)

È importante notare che questo metodo produce solo un'ipotesi per una formula, in realtà non dimostra che la formula sia corretta in generale.
Come sappiamo che un'ipotesi è corretta?
Come facciamo a sapere che è sempre vera?
La risposta sta nel concetto di prova matematica.
Quando indoviamo una formula per f (n), abbiamo creato una congettura.
Trovare una prova per una congettura può essere difficile e può richiedere un modo molto creativo di esaminare il problema.

Proviamo a dimostrare la nostra congettura, cioè che il numero totale di vertici nel problema dei quadrati è dato dalla formula f(n) = 3n + 1.
Potremmo prima chiederci: perché la formula termina con "+1"? Che significato ha? A cosa corrisponde?
Vediamo se esiste un singolo oggetto che potrebbe darci il "+1" nella formula.
Poiché la formula conta i vertici, il "+1" sembra indicare uno speciale vertice "extra" che deve essere aggiunto alla fine. Osservando l'immagine, potremmo ipotizzare che il “+1” corrisponda al singolo vertice condiviso da tutti i quadrati.
In tal caso, i vertici rimanenti dovrebbero essere contabilizzati dal "3n".
Quindi la variabile n rappresenta il numero di quadrati e ogni quadrato ha 3 vertici non condivisi che sono suoi e non appartengono a nessun altro quadrato, allora il numero totale di questi vertici non condivisi è dato da 3n.
A questo dobbiamo aggiungere 1 per il vertice condiviso, per un totale di 3n + 1 vertici in tutto, che è la formula che abbiamo indovinato.

Una volta individuata l'idea di una dimostrazione, in genere si riscrive la dimostrazione in una forma più succinta e raffinata.
Nel nostro caso potrebbe essere:

Teorema
Il numero totale di vertici per n quadrati che condividono esattamente un vertice comune è dato dalla formula f(n) = 3n + 1.

Prova
Ciascuno degli n quadrati ha 3 vertici che non sono condivisi con nessun altro quadrato, questo dà 3n vertici non condivisi in tutto. Inoltre c'è un solo vertice condiviso tra tutti i quadrati. Quindi il numero totale di vertici è 3n + 1.

Ora che abbiamo una dimostrazione di questo teorema, sappiamo che la formula f(n) = 3n + 1 funziona sempre.

Esempio 2
---------
Quante diagonali ha un poligono regolare di n lati?
Un poligono regolare è una figura geometrica con n lati uguali e n angoli uguali.
Una diagonale è una linea da un vertice all'altro del poligono, tranne per il fatto che i lati del poligono non contano.

Vediamo i primi casi:

  Lati    Figura        Diagonali
    3     triangolo        0 (nessuna diagonale)
    4     quadrato         2
    5     pentagono        5
    6     esagono          9
    7     ettagono        14
    8     ottagono        20

Quindi la nostra sequenza è la seguente:

    n  = 3 4 5 6 7  8
  S(n) = 0 2 5 9 14 20

Scriviamo la differenza di termini consecutivi della sequenza fino a quando non otteniamo una sequenza costante (non sempre si arriva ad una sequenza costante).
Le righe che rappresentano le differenze costituiscono la "tavola delle differenze".

Calcoliamo la tavola delle differenze con la seguente funzione:

(define (pair-func lst func)
"Produces a list applying a function to each pair of elements of a list"
  (map func (rest lst) (chop lst)))

(setq lst '(0 2 5 9 14 20))

prima differenza:
(setq a1 (pair-func lst -))
;-> (2 3 4 5 6)
seconda differenza:
(setq a2 (pair-func a1 -))
;-> (1 1 1 1)

Per verificare se i numeri di una lista sono tutti uguali usiamo la seguente espressione:

(apply = a1)
;-> nil
(apply = a2)
;-> true

Valori uguali dopo 2 differenze --> polinomio di secondo grado.

  P(n) = A*n^2 + B*n + C

Abbiamo 3 incognite che possiamo calcolare con un sistema di 3 equazioni.
Dalla sequenza ricaviamo che:

  P(3) = 0
  P(4) = 2
  P(5) = 5

Sostituiamo i valori nella funzione:

  P(n) = A*n^2 + B*n + C

e otteniamo il seguente sistema:

  9A + 3B + C = 0
  16A + 4B + C = 2
  25A + 5B + C = 5

Le cui soluzioni sono:

  A = 0.5, B = -1.5, C = 0

Quindi il polinomio generatore della sequenza vale:

  P(n) = 0.5*n^2 - 1.5*n

Verifichiamo i valori della sequenza e oltre:

(define (p n) (sub (mul 0.5 n n) (mul 1.5 n)))

(map p (sequence 3 10))
;-> (0 2 5 9 14 20 27 35)

Esempio 3
---------
Abbiamo la seguente sequenza:

  S(n) = 5 19 49 101 181 295 449

(setq lst '(5 19 49 101 181 295 449))

Calcoliamo la tavola delle differenze:

prima differenza:
(setq a1 (pair-func lst -))
;-> (14 30 52 80 114 154)

seconda differenza:
(setq a2 (pair-func a1 -))
;-> (16 22 28 34 40)

terza differenza:
(setq a3 (pair-func a2 -))
;-> (6 6 6 6)

Valori uguali dopo 3 differenze --> polinomio di terzo grado.
In altre parole, la tavola delle differenze ha 3 righe.

  P(n) = A*n^3 + B*n^2 + C*n + D

Abbiamo 4 incognite che possiamo calcolare con un sistema di 4 equazioni.
Dalla sequenza ricaviamo che:

  P(1) = 5
  P(2) = 19
  P(3) = 49
  P(4) = 101

Sostituiamo i valori nella funzione:

  P(n) = A*n^3 + B*n^2 + C*n + D

e otteniamo il seguente sistema:

  A + B + C + D = 5
  8A + 4B + 2C + D = 19
  27A + 9B + 3C + D = 49
  64A + 16B + 4C + D = 101

Le cui soluzioni sono:

  A = 1, B = 2, C = 1, D = 1

Quindi il polinomio generatore della sequenza vale:

  P(n) = n^3 + 2*n^2 + n + 1

Verifichiamo i valori della sequenza e oltre:

(define (p n) (+ (* n n n) (* 2 n n ) n 1))
(map p (sequence 1 10))
;-> (5 19 49 101 181 295 449 649 901 1211)

Nota: questo metodo afferma implicitamente che nella terza differenza la riga di 6 continuerà indefinitamente.
Esistono formule che danno sequenze in cui i primi 7 valori corrispondono ai valori dati, ma in cui non tutti i valori successivi della terza differenza sarebbero 6.

Esempio 4
---------
In alcuni casi il calcolo delle differenze non arriva mai a valori tutti uguali.
Questo significa che la funzione generatrice non è un polinomio.
Comunque il calcolo delle differenze può aiutarci lo stesso (qualche volta) a risolvere il problema.

Sequenza:

  S(n) = 1 4 13 40 121 364

Tavola delle differenze:

(setq lst '(1 4 13 40 121 364 1093))
(setq a1 (pair-func lst -))
;-> (3 9 27 81 243 729)
(setq a2 (pair-func a1 -))
;-> (6 18 54 162 486)
(setq a3 (pair-func a2 -))
;-> (12 36 108 324)
(setq a4 (pair-func a3 -))
;-> (24 72 216)
(setq a5 (pair-func a4 -))
;-> (48 144)

Non sembra che si possa ottenere una riga con valori tutti uguali.
Comunque possiamo notare che la prima riga della tavola:

  3 9 27 81 243 729

rappresentano le potenze di 3:

  3^1 3^2 3^3 3^4 3^5 3^6

Ma la prima riga rappresenta:

  s(n) - s(n-1)

Quindi risulta:

  s(n) - s(n-1) = 3^(n-1)  -->  s(n) = 3^(n-1) + s(n-1)
  con s(1) = 1

In definitiva abbiamo trovato una formula ricorsiva per la sequenza:

  s(1) = 1
  s(n) = 3^(n-1) + s(n-1)

Scriviamo la funzione e verifichiamo i valori della serie e oltre:

(define (s n)
  (cond ((= n 1) 1)
        (true
          (+ (pow 3 (- n 1)) (s (- n 1))))))

(map s (sequence 1 10))
;-> (1 4 13 40 121 364 1093 3280 9841 29524)

Nota:
I valori della nostra funzione sono uguali a quelli della funzione:

  s(n) = (3^n - 1)/2

Sequenza OEIS A003462:
  0, 1, 4, 13, 40, 121, 364, 1093, 3280, 9841, 29524, 88573, 265720,
  797161, 2391484, 7174453, 21523360, 64570081, 193710244, 581130733,
  1743392200, 5230176601, 15690529804, 47071589413, 141214768240,
  423644304721, 1270932914164, ...

(define (a003462 n) (/ (pow 3 n) 2))

(map a003462 (sequence 1 10))
;-> (1 4 13 40 121 364 1093 3280 9841 29524)

Verifichiamo i primi 25 valori:

(= (map s (sequence 1 25)) (map a003462 (sequence 1 25)))
;-> true

Nota: questa sequenza è esponenziale (non è polinomiale).


----------------------------------------
Prima e ultima cifra di un numero intero
----------------------------------------

Dato un numero intero positivo scrivere due funzioni che restituiscono la prima e l'ultima cifra del numero.
Esempio: numero = 3728 --> prima cifra = 3, ultima cifra = 8.

Vediamo come estrarre l'ultima cifra.

Un metodo comune è quello di calcolare il modulo 10 del numero:

  (modulo abc...xyz 10) = z

(% 3728 10)
;-> 8

(define (last-digit num) (% num 10))

(last-digit 3728)
;-> 8

Per trattare anche i numeri negativi:

(define (last-digit num)
  (if (< num 0)
      (% (abs num) 10)
      ;else
      (% num 10)))

(last-digit 3728)
;-> 8
(last-digit 0)
;-> 0
(last-digit -3728)
;-> 8

Un altro metodo è quello di convertire il numero in stringa e poi estrarre il primo carattere (a destra):

(define (ultima-cifra num) (int ((string num) -1)))

(ultima-cifra 3728)
;-> 8

In questo caso per trattare anche i numeri negativi:

(define (ultima-cifra num) (int ((string (abs num)) -1)))

(ultima-cifra 3728)
;-> 8
(ultima-cifra 0)
;-> 0
(ultima-cifra -3728)
;-> 8

Per estrarre la prima cifra abbiamo diverse possibilità:

Un metodo matematico è quello di dividere il numero per 10 fino a che il numero è maggiore o uguale a 10.
Al termine delle divisioni rimaniamo con la prima cifra.

(define (first-digit1 num) (while (or (< num -9) (> num 9)) (setq num (/ num 10))) num)

oppure in modo simile:

(define (first-digit2 num) (until (zero? (/ num 10)) (setq num (/ num 10))) num)

(first-digit1 3728)
;-> 3
(first-digit2 3728)
;-> 3

In modo ricorsivo:

(define (first-digit3 num)
  (if (zero? (/ num 10))
      num
      ;else
      (first-digit3 (/ num 10))))

(first-digit3 3728)
;-> 3

Queste funzioni trattano anche il numero 0 e i numeri interi negativi:

(first-digit1 0)
;-> 0
(first-digit2 0)
;-> 0
(first-digit3 0)
;-> 0
(first-digit1 -3728)
;-> -3
(first-digit2 -3728)
;-> -3
(first-digit3 -3728)
;-> -3

Un altro metodo è quello di convertire il numero in stringa e poi estrarre l'ultimo carattere (a sinistra):

(define (prima-cifra num) (int ((string num) 0)))

(prima-cifra 3728)
;-> 3

Per gestire anche i numeri negativi:

(define (prima-cifra num)
  (if (< num 0)
      (- (int ((string (abs num)) 0)))
      ;else
      (int ((string num) 0))))

(prima-cifra 3728)
;-> 3
(prima-cifra 0)
;-> 0
(prima-cifra -3728)
;-> -3

Altri metodi matematici utilizzano le funzioni "log" e "pow".

(define (first-digit4 num)
  ; (int (log num 10)) = (- (length num) 1)
  ;(/ num (pow 10 (- (length num) 1))))
  (/ num (pow 10 (int (log num 10)))))

(first-digit4 3728)
;-> 3
(first-digit4 0)
;-> ERR: division by zero
;-> called from user function (first-digit4 0)
(first-digit4 -3728)
;-> -3728 ; ?? risposta errata

Per gestire anche i numeri negativi:

(define (first-digit4 num)
  ; (int (log num 10)) = (- (length num) 1)
  ;(/ num (pow 10 (int (log num 10)))))
  (/ num (pow 10 (- (length num) 1))))

(first-digit4 3728)
;-> 3
(first-digit4 0)
;-> 0
(first-digit4 -3728)
;-> -3

Vediamo se le funzioni producono gli stessi risultati.

(setq test (rand 1e8 100))

(= (map last-digit test) (map ultima-cifra test))
;-> true

(= (map first-digit1 test) (map prima-cifra test)
   (map first-digit2 test) (map first-digit3 test)
   (map first-digit4 test))
;-> true

Vediamo la velocità di tutte queste funzioni.

(silent (setq test (rand 1e20 1e5)))

(time (map last-digit test) 100)
;-> 997.245
(time (map ultima-cifra test) 100)
;-> 8792.958

(time (map first-digit1 test) 100)
;-> 18650.935
(time (map first-digit2 test) 100)
;-> 15138.27
(time (map first-digit3 test) 100)
;-> 22498.514
(time (map prima-cifra test) 100)
;-> 9074.222
(time (map first-digit4 test) 100)
;-> 2511.418

Nel caso migliore (con le funzioni "last-digit" e "first-digit4"), ci vuole un tempo T per calcolare l'ultima cifra e ci vuole un tempo 2.5*T per calcolare la prima cifra.


------------------
Numeri unprimeable
------------------

I numeri "unpribeable" sono i numeri composti che rimangono sempre composti quando viene modificata una singola cifra decimale del numero, cioè numeri composti che non possono essere trasformati in numeri primi cambiando una singola cifra.
Unprimeable numbers are composite numbers which cannot be turned into a prime by changing a single digit.

Sequenza OEIS A118118:

  200, 204, 206, 208, 320, 322, 324, 325, 326, 328, 510, 512, 514, 515,
  516, 518, 530, 532, 534, 535, 536, 538, 620, 622, 624, 625, 626, 628,
  840, 842, 844, 845, 846, 848, 890, 892, 894, 895, 896, 898, 1070, 1072,
  1074, 1075, 1076, 1078, 1130, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se un numero intero è unprimeable:

(define (unprimeable? num)
(catch
  (cond ((prime? num) nil)
    (true
      (local (str len digit tmp)
        (setq str (string num))
        (setq len (length str))
        (setq digit '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
        ; per ogni carattere/cifra del numero...
        (for (i 0 (- len 1))
          (setq tmp str)
          ; ... sostituisce la cifra con 0,1,2,3,4,5,6,7,8 e 9
          ; e controlla se il nuovo numero è primo
          (dolist (d digit)
            (setf (tmp i) d)
            ;(print (int tmp 0 10)) (read-line)
            (if (prime? (int tmp 0 10)) (throw nil))
          )
        )
        true)))))

(unprimeable? 200)
;-> true

Verifichiamo la sequenza OEIS:

(filter unprimeable? (sequence 1 1130))
;-> (200 204 206 208 320 322 324 325 326 328 510 512 514 515 516 518 530 532
;->  534 535 536 538 620 622 624 625 626 628 840 842 844 845 846 848 890 892
;->  894 895 896 898 1070 1072 1074 1075 1076 1078 1130)

(length (filter unprimeable? (sequence 1 100000)))
;-> 19188

(time (filter unprimeable? (sequence 1 100000)))
;-> 2834.279

Funzione che calcola i primi numeri unprimable che terminano con 0,1,2,3,4,5,6,7,8,9:

(define (unprimeable-ending)
  (local (nums full)
    (setq nums (dup 0 10))
    (setq full nil)
    (setq i 200)
    (until full
      (if (and (= (nums (% i 10)) 0) ; primo test: valore trovato?
               (unprimeable? i))     ; secondo test: numero unprimeable?
          (setf (nums (% i 10)) i)
      )
      ;(print i { } (% i 10) { } (nums (% i 10))) (read-line)
      (setq full (nil? (ref 0 nums)))
      (++ i)
    )
    nums))

(time (println (unprimeable-ending)))
;-> (200 595631 322 1203623 204 325 206 872897 208 212159)
;-> 3370.765

Nota: scambiando di posto il primo test con il secondo test nell'espressione "and" il tempo di calcolo diventa 57830.631 millisecondi (invece che 3370.765).

Funzione che calcola i primi numeri unprimable che iniziano con 1,2,3,4,5,6,7,8,9:

(define (unprimeable-starting)
  (local (nums full prima)
    (setq nums (dup 0 10))
    (setf (nums 0) -1)
    (setq full nil)
    (setq i 200)
    (until full
      ; estrae la prima cifra del numero
      (setq prima (int ((string i) 0)))
      (if (and (= (nums prima) 0) ; primo test: valore trovato?
               (unprimeable? i))     ; secondo test: numero unprimeable?
          (setf (nums prima) i)
      )
      ;(print i { } prima { } (nums prima)) (read-line)
      (setq full (nil? (ref 0 nums)))
      (++ i)
    )
    nums))

(time (println (unprimeable-starting)))
;-> (-1 1070 200 320 4030 510 620 7080 840 9030)
;-> 7.067

Nota: la funzione "length" può essere usata con un numero intero o con una stringa.
In caso di una stringa l'eventuale segno "-" viene contato come un carattere:

(length 10)
;-> 2
(length (string -10))
;-> 3

Inoltre la funzione length è leggermente più veloce con le stringhe:

(silent
(setq tnum (rand 1e12 1e4))
(setq tstr (map string tnum)))
(time (map length tnum) 10000)
;-> 8685.683000000001
(time (map length tstr) 10000)
;-> 7418.195


------------
Numeri Gilda
------------

Dato un numero n > 9 con le cifre d1, d2, ... dk, definiamo una sequenza di tipo Fibonacci dove:

   a(1) = |d1 - d2 - ... - dk|

   a(2) = d1 + d2 + ... + dk

   a(i) = a(i-1) + a(i-2) per i>2.

Se il numero n compare nella sequenza delle a(i), allora n è un numero di Gilda.

Ad esempio, con n = 152 abbiamo la successione che parte da |1 - 5 - 2| = 6, 1 + 5 + 2 = 8, poi 14, 22, 36, 58, 94 e infine 152.

Sequenza OEIS A042947:
  0, 29, 49, 78, 110, 152, 220, 314, 330, 364, 440, 550, 628, 660, 683,
  770, 880, 990, 997, 2207, 5346, 13064, 30254, 35422, 37862, 38006,
  65676, 73805, 143662, 202196, 933138, 977909, 3120796, 3242189, 3363582,
  3606368, 3727761, 3849154, 3970547, 4484776, 4848955, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Fibonacci di un numero n con valori iniziali a1 a2:

(define (fibo-like num a1 a2)
  (local (a b c)
    (setq a a1 b a2 c 0L)
    (for (i 0 (- num 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a))

(fibo-like 2 6 8)
;-> 14
(fibo-like 3 6 8)
;-> 22

(define (gilda? num)
  (local (out a1 a2 digits)
    ;(print num { })
    (setq out '())
    (setq digits (int-list num))
    ; calcolo di a1
    (setq a1 (abs (- (digits 0) (apply + (rest digits)))))
    ; calcolo di a2
    (setq a2 (apply + digits))
    (setq fibo 0)
    (setq i 2) ; indice iniziale
    (setq continua true)
    ; ciclo per calcolare i numeri di Fibonacci minori o uguali a num
    (while (and (> num fibo) continua)
      (setq fibo (fibo-like i a1 a2))
      (if (= num fibo) (setq continua nil))
      ;(print fibo { })
      (++ i)
    )
    (not continua)))

Facciamo alcune prove:

(gilda? 152)
;-> true
(gilda? 10)
;-> nil

(filter gilda? (sequence 10 1e4))
;-> (29 49 78 110 152 220 314 330 364 440 550
;->  628 660 683 770 880 990 997 2207 5346)

(time (println (filter gilda? (sequence 10 1e5))))
;-> (29 49 78 110 152 220 314 330 364 440 550 628 660 683 770 880 990
;->  997 2207 5346 13064 30254 35422 37862 38006 65676 73805)
;-> 2092.654

(time (println (filter gilda? (sequence 10 1e6))))
;-> (29 49 78 110 152 220 314 330 364 440 550 628 660 683 770 880 990
;->  997 2207 5346 13064 30254 35422 37862 38006 65676 73805
;->  143662 202196 933138 977909)
;-> 29632.406


------------------
Numeri upside-down
------------------

La seguente definizione è stata creata da R.E.Kennedy e C.N.Cooper.

Un numero n è "upside-down" se la sua i-esima cifra più a sinistra e la sua i-esima cifra più a destra sommano a 10.
Ad esempio, 42586 è un numero upside-down perché 4 + 6 = 2 + 8 = 5 + 5 = 10.

Dalla definizione segue che i numeri upside-down sono senza la cifra "0" (zero) e se hanno un numero dispari di cifre, allora la cifra centrale è 5.

Sequenza OEIS A299539:
  5, 19, 28, 37, 46, 55, 64, 73, 82, 91, 159, 258, 357, 456, 555, 654,
  753, 852, 951, 1199, 1289, 1379, 1469, 1559, 1649, 1739, 1829, 1919,
  2198, 2288, 2378, 2468, 2558, 2648, 2738, 2828, 2918, 3197, 3287, 3377,
  3467, 3557, 3647, 3737, 3827, 3917, 4196, 4286, ...

(define (upside-down? num)
  (local (out str len)
    (setq out true)
    (setq str (string num))
    (setq len (length num))
    ; verifica che la somma di ogni coppia i e -(i+1) vale 10
    (for (i 0 (- (/ len 2) 1) 1 (not out))
      ;(println (str i) { } (str (- (+ i 1))))
      (if (!= (+ (int (str i) 0 10) (int (str (- (+ i 1))) 0 10)) 10)
        (setq out nil))
    )
    ; verifica "5" al centro per numeri di lunghezza dispari
    ; (solo per quelli che sono potenzialmente upside-down)
    (if (and out (odd? len) (!= (str (/ len 2)) "5")) (setq out nil))
    out))

Facciamo alcune prove:

(upside-down? 1379)
;-> true
(upside-down? 951)
;-> true
(upside-down? 921)
;-> nil

(filter upside-down? (sequence 1 5000))
;-> (5 19 28 37 46 55 64 73 82 91 159 258 357 456 555 654 753 852 951
;->  1199 1289 1379 1469 1559 1649 1739 1829 1919 2198 2288 2378 2468
;->  2558 2648 2738 2828 2918 3197 3287 3377 3467 3557 3647 3737 3827
;->  3917 4196 4286 4376 4466 4556 4646 4736 4826 4916)

(time (println (length (filter upside-down? (sequence 1 1e6)))))
;-> 910
;-> 2044.835


----------------
Primi di Honaker
----------------

Un numero primo p(n) è un numero primo di Honaker se il suo indice n e p(n) hanno la stessa somma di cifre.
Si definisce p(1) = 2
Ad esempio, p(32) = 131 è un numero primo di Honaker perché 3 + 2 = 1 + 3 + 1.

Sequenza OEIS A033548:
  131, 263, 457, 1039, 1049, 1091, 1301, 1361, 1433, 1571, 1913, 1933,
  2141, 2221, 2273, 2441, 2591, 2663, 2707, 2719, 2729, 2803, 3067, 3137,
  3229, 3433, 3559, 3631, 4091, 4153, 4357, 4397, 4703, 4723, 4903, 5009,
  5507, 5701, 5711, 5741, 5801, 5843, ...

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

(ref 2 (primes-to 10))
;-> (0)

(ref 131 (primes-to 200))
;-> 31

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

Funzione che calcola tutti i numeri primi di Honeker fino ad un determinato valore:

(define (honaker-to num)
  (local (out primes)
    (setq out '())
    (setq primes (primes-to num))
    (dolist (p primes)
      (if (= (digit-sum p) (digit-sum (+ $idx 1)))
        (push p out -1)
      )
    )
    out))

Facciamo alcune prove:

(honaker-to 500)
;-> (131 263 457)

(honaker-to 1e4)
;-> (131 263 457 1039 1049 1091 1301 1361 1433 1571 1913 1933 2141 2221
;->  2273 2441 2591 2663 2707 2719 2729 2803 3067 3137 3229 3433 3559
;->  3631 4091 4153 4357 4397 4703 4723 4903 5009 5507 5701 5711 5741
;->  5801 5843 5927 6301 6311 6343 6353 6553 6563 6653 6737 6827 6971
;->  7013 7213 7283 7411 7481 7523 7741 8011 8821 9103)

(time (println (length (honaker-to 1e6))))
;-> 2949
;-> 268.329


-----------------
Numeri plaindrome
-----------------

Un numero è "plaindrome" in una data base b, se le sue cifre sono in ordine non decrescente in quella base.
Ad esempio, 1234, 2222, 25667 e 2468 sono tutti plaindrome in base 10.

Chiaramente un numero plaindrome non può contenere la cifra 0, a meno che non sia il numero 0 stesso.

0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 22

Sequenza OEIS A009994:
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 22,
  23, 24, 25, 26, 27, 28, 29, 33, 34, 35, 36, 37, 38, 39, 44, 45, 46,
  47, 48, 49, 55, 56, 57, 58, 59, 66, 67, 68, 69, 77, 78, 79, 88, 89,
  99, 111, 112, 113, 114, 115, 116, 117, 118, 119, 122, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica se un numero è plaindrome:

(define (plaindrome? num)
  (if (< num 10)
      true
      ;else
      (apply <= (int-list num))))

(filter plaindrome? (sequence 1 122))
;-> (1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 22 23 24 25 26 27 28
;->  29 33 34 35 36 37 38 39 44 45 46 47 48 49 55 56 57 58 59 66 67 68
;->  69 77 78 79 88 89 99 111 112 113 114 115 116 117 118 119 122)


------------------------
Coppie di primi Ormiston
------------------------

Due numeri primi consecutivi le cui cifre sono uguali, ordine a parte, formano una coppia di Ormiston.
Le prime due di queste coppie sono (1913, 1931) e (18379, 18397), mentre la prima tripa, quadrupla e quintupla sono (11117123, 11117213, 11117321), 6607882000+(123,213,231,321) e 208479425600009+(0791,0917,0971,1097).
Ogni numero maggiore di 119639 può essere scritto come somma di numeri di Ormiston.

Sequenza OEIS A072274:

  1913, 1931, 18379, 18397, 19013, 19031, 25013, 25031, 34613, 34631,
  35617, 35671, 35879, 35897, 36979, 36997, 37379, 37397, 37813, 37831,
  40013, 40031, 40213, 40231, 40639, 40693, 45613, 45631, 48091, 48109,
  49279, 49297, 51613, 51631, ...

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

Funzione che verifica se due numeri hanno le stesse cifre:

(define (same-digit num1 num2)
  (= (sort (int-list num1)) (sort (int-list num2))))

Funzione che calcola le coppie di Ormiston fino ad un dato valore:

(define (ormiston-to num)
  (let ( (out '()) (primi (primes-to num)) (a 0) (b 0) )
    (for (i 0 (- (length primi) 2))
      (setq a (primi i))
      (setq b (primi (+ i 1)))
      (if (same-digit a b)
          (push (list a b) out -1)
      )
    )
    (flat out)))

Facciamo alcune prove:

(ormiston-to 5000)
;-> (1913 1931)

Vediamo la velocità:

(time (println (length (ormiston-to 1e6))))
;-> 764
;-> 9224.614

Proviamo con un altro metodo.

(define (pair-func lst func)
"Produces a list applying a function to each pair of elements of a list"
  (map func (rest lst) (chop lst)))

(pair-func '(314 413 589 456 654) same-digit)
;-> (true nil nil true)

Funzione che calcola le coppie di Ormiston fino ad un dato valore:

(define (ormiston num)
  (local (primi bool indici)
    (setq primi (primes-to num))
    ; crea una lista true/nil
    ; true --> (primi $idx) e (primi (+ $idx 1)) hanno le stesse cifre
    (setq bool (pair-func primi same-digit))
    (setq indici '())
    ; crea la lista degli indici
    (dolist (b bool) (if b (push (list $idx (+ $idx 1)) indici -1)))
    ; seleziona le coppie di Ormiston
    (select primi (flat indici))))

(ormiston 5000)
;-> (1913 1931)

Vediamo se le due funzioni producono risultati uguali:

(= (ormiston-to 1e5) (ormiston 1e5))
;-> true

Vediamo la velocità:

(time (println (length (ormiston 1e6))))
;-> 764
;-> 319.53

Questa funzione è 30 volte più veloce della funzione precedente.

(time (println (length (ormiston 1e7))))
;-> 7444
;-> 3374.716


-------------
Numeri Rhonda
-------------

Un numero n è un numero di Rhonda in base b se il prodotto delle sue cifre, quando rappresentato in base b, è uguale a b moltiplicato per la somma dei suoi fattori primi.

Ad esempio, 1568 = 2^5*7^2 è un numero Rhonda in base 10 perché:

  1*5*6*8 = 10 * (2+2+2+2+2+7+7)

I numeri di Rhonda esistono solo nelle basi composite. Infatti, il prodotto delle cifre di un numero in una base prima b non può essere divisibile per b, poiché ogni cifra è minore di b.

Kevin Brown ha dimostrato che esistono infiniti numeri di Rhonda:

https://www.mathpages.com/home/kmath007/kmath007.htm

Sequenza OEIS A099542:
  1568, 2835, 4752, 5265, 5439, 5664, 5824, 5832, 8526, 12985, 15625, 
  15698, 19435, 25284, 25662, 33475, 34935, 35581, 45951, 47265, 47594,
  52374, 53176, 53742, 54479, 55272, 56356, 56718, 95232, 118465, 133857,
  148653, 154462, 161785, ...

(define (digit-prod num)
"Calculates the product of the digits of an integer"
  (if (zero? num)
      0
      (let (out 1)
        (while (!= num 0)
          (setq out (* out (% num 10)))
          (setq num (/ num 10))
        )
    out)))

Funzione che verifica se un numero è di Rhonda (base 10):

(define (rhonda? num)
  (= (digit-prod num) (* 10 (apply + (factor num)))))

(rhonda? 1568)
;-> true

(time (println (filter rhonda? (sequence 1 1e6))))
;-> (1568 2835 4752 5265 5439 5664 5824 5832 8526 12985 15625 15698 19435
;->  25284 25662 33475 34935 35581 45951 47265 47594 52374 53176 53742
;->  54479 55272 56356 56718 95232 118465 133857 148653 154462 161785
;->  172577 178754 185614 194526 196355 224256 226953 232356 242352 245579
;->  254254 254334 254624 256973 259333 272952 285359 295412 315288 316285
;->  334359 339521 342225 365313 392533 415275 456841 457346 512278 513744
;->  516817 518668 521356 531729 534391 547682 562696 563125 625275 643528
;->  668185 671865 681265 733125 733495 749425 754682 765371 826754 844185
;->  859341 885521 954664)
;-> 1891.899


-------------
Numeri Sastry
-------------

Un numero n è un numero Sastry se concatenato con (n + 1) dà un quadrato. 
Ad esempio, 183 è un numero Sastry perché 183184 è il quadrato di 428.

Sequenza OEIS A030465:
  183, 328, 528, 715, 6099, 13224, 40495, 106755, 453288, 2066115, 
  2975208, 22145328, 28027683, 110213248, 110667555, 147928995, 178838403, 
  226123528, 275074575, 333052608, 378698224, 445332888, 446245635, ...

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(define (sastry? num)
  (square? (int (string num (+ num 1)) 0 10)))

(sastry? 183)
;-> true

(time (println (filter sastry? (sequence 1 1e5))))
;-> (183 328 528 715 6099 13224 40495)
;-> 109.862

(time (println (filter sastry? (sequence 1 1e6))))
;-> (183 328 528 715 6099 13224 40495 106755 453288)
;-> 1107.91

(time (println (filter sastry? (sequence 1 1e7))))
;-> (183 328 528 715 6099 13224 40495 106755 453288 2066115 2975208)
;-> 12295.323


--------------
Hamming weight
--------------

L'Hamming weight (peso di Hamming) di una stringa è il numero di simboli diversi dal simbolo zero dell'alfabeto utilizzato. 
È quindi equivalente alla distanza di Hamming dalla stringa composta da tutti zeri della stessa lunghezza. 
Per il caso più tipico, cioè una stringa di bit, questo è il numero di 1 nella stringa o la somma delle cifre della rappresentazione binaria di un dato numero.

Stringa         Hamming weight
 11101           4
 11101000        4
 00000000        0
 678012340567    10

Esistono diversi algoritmi ottimizzati (generalmente scritti in C) per trattare stringhe/numeri binari di 8,16,32 e 64 bit.
Vediamo alcuni metodi che contano il numero di caratteri "0" in una stringa.

(define (h-weigth1 str)
  (replace "0" str "0")
  (- (length str) $count))

(h-weigth1 "11029")
;-> 4

(define (h-weight2 str)
  (let (conta 0)
    (dostring (ord str)
      ; (char "0") = 48
      (if (!= ord 48) (++ conta))
    )
    conta))

(h-weight2 "11029")
;-> 4

(define (h-weight3 str)
  (- (length str) (first (count '("0") (explode str)))))

(h-weight3 "11029")
;-> 4

La seguente espressione trova tutti i caratteri diversi da "0" di una stringa e li mette in una lista:
(find-all {[^0]} "108100")
;-> ("1" "8" "1")

(define (h-weight4 num)
  (length (find-all {[^0]} num)))

(h-weight4 "11029")
;-> 4

(setq str (join (map string (rand 2 100))))

Vediamo se le funzioni producono risultati identici:

(= (h-weight1 str) (h-weight2 str) (h-weight3 str) (h-weight4 str))
;-> true

Vediamo la velocità delle funzioni:

(time (h-weight1 str) 1e5)
;-> 538.147
(time (h-weight2 str) 1e5)
;-> 537.583
(time (h-weight3 str) 1e5)
;-> 1616.936
(time (h-weight4 str) 1e5)
;-> 887.011


---------------------------------------------
Primo carattere meno frequente in una stringa
---------------------------------------------

Data una stringa ASCII, scrivere una funzione per trovare il primo carattere meno frequente.
Ad esempio: 
- stringa = "abaccdeff" 
  output  = "b" (primo carattere con 1 occorrenza)
- stringa = "abbaccddeeff" 
  output "a" (primo carattere con 2 occorrenze, infatti non esiste nessun carattere che compare solo 1 volta)

Caratteri ascii standard
                   char   ord 
primo carattere:    "1"    49
ultimo carattere:   "~"   126

Usiamo un vettore per contare le occorrenze di larghezza (126 - 49 + 1):

(+ (- 126 49) 1)
;-> 78

(define (find-min-freq str)
  (local (alpha found freq idx out)
    ; vettore delle frequenze/occorrenze dei caratteri
    (setq alpha (dup 0 78))
    ; calcola i valori delle frequenze/occorrenze dei caratteri
    (dostring (ord str)
      (++ (alpha (- ord 49)))
    )
    ; ciclo per la ricerca del carattere meno frequente
    ; prima frequenza/occorrenza da ricercare
    (setq freq 1)
    (setq found nil)
    (until found
      ; primo indice con valore freq
      (setq idx (find freq alpha))
      ;(println freq { } idx)
      (cond
        ; se non esiste indice con valore freq,
        ; allora aumenta freq di 1
        ((nil? idx) (++ freq))
        ; indice con valore freq trovato
        (true
          (setq found true)
          (setq out (char (+ idx 49))))
      )
    )
    (list out freq)))

Facciamo alcune prove:

(find-min-freq "abaccdeff")
;-> ("b" 1)

(find-min-freq "abbaccddeeff")
;-> ("a" 2)

(setq str "")
(for (i 1 2000) (extend str (char (+ (rand 77) 49))))
(find-min-freq str)
;-> ("G" 15)

Ripensandoci, possiamo trovare direttamente il valore minimo di freq invece di cercare per freq = 1,2,3... in successione.

(define (find-min-freq2 str)
  (local (alpha lst freq idx)
    ; vettore delle frequenze/occorrenze dei caratteri
    (setq alpha (dup 0 78))
    ; calcola i valori delle frequenze/occorrenze dei caratteri
    (dostring (ord str)
      (++ (alpha (- ord 49)))
    )
    ; ordina le frequenze
    (setq lst (sort (copy alpha)))
    ; trova la prima frequenza maggiore di 0
    (find 0 lst <)
    (setq freq $0)
    ; trova il primo indice con valore freq
    (setq idx (find freq alpha))
    (list (char (+ idx 49)) freq)))

Facciamo alcune prove:

(setq str "abaccdeff")
(find-min-freq2 "abaccdeff")
;-> ("b" 1)

(find-min-freq2 "abbaccddeeff")
;-> ("a" 2)

(setq str "")
(for (i 1 2000) (extend str (char (+ (rand 77) 49))))
(find-min-freq str)
;-> ("N" 16)
(find-min-freq2 str)
;-> ("N" 16)

Vediamo la velocità delle due funzioni:

(setq str "")
(for (i 1 50) (extend str (char (+ (rand 77) 49))))
(time (find-min-freq str) 1e5)
;-> 593.358
(time (find-min-freq2 str) 1e5)
;-> 1248.525

(setq str "")
(for (i 1 5000) (extend str (char (+ (rand 77) 49))))
(time (find-min-freq str) 1e4)
;-> 4655.602
(time (find-min-freq2 str) 1e4)
;-> 4491.533


-----------
Numeri nudi
-----------

Y.Katagiri chiama un numero nudo se è divisibile per tutte le sue cifre (che dovrebbero essere diverse da zero).
Per esempio, 672 = 6*112 = 7*96 = 2*336.
(Il numero è chiamato "nudo" perché espone alcuni dei suoi fattori).

Sequenza OEIS A034838:
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22, 24, 33, 36, 44, 48, 55, 
  66, 77, 88, 99, 111, 112, 115, 122, 124, 126, 128, 132, 135, 144, 
  155, 162, 168, 175, 184, 212, 216, 222, 224, 244, 248, 264, 288, 
  312, 315, 324, 333, 336, 366, 384, 396, 412, 424, 432, 444, 448, ...

(define (nudo? num)
  (local (tmp continua d)
    (setq tmp num)
    (setq continua true)
    (while (and (!= tmp 0) continua)
      ; cifra corrente
      (setq d (% tmp 10))
      (if (or (zero? d) 
              (!= (/ num d) (div num d)))
          (setq continua nil)
      )
      (setq tmp (/ tmp 10))
    )
    continua))

Facciamo alcune prove:

(nudo? 10)
;-> nil

(nudo? 432)
;-> true

(filter nudo? (sequence 1 1e3))
;-> (1 2 3 4 5 6 7 8 9 11 12 15 22 24 33 36 44 48 55 66 77 88 99 111 112
;->  115 122 124 126 128 132 135 144 155 162 168 175 184 212 216 222 224
;->  244 248 264 288 312 315 324 333 336 366 384 396 412 424 432 444 448
;->  488 515 555 612 624 636 648 666 672 728 735 777 784 816 824 848 864
;->  888 936 999)


-------------------
Numeri di Zuckerman
-------------------

I numeri di Zuckerman (definizione di Tattersall) sono numeri interi positivi che sono divisibili per il prodotto delle loro cifre.
Tattersall, James "Elementary Number Theory in Nine Chapters" 2ed (2005).

Sequenza OEIS A007602:
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 24, 36, 111, 112, 115, 128,
  132, 135, 144, 175, 212, 216, 224, 312, 315, 384, 432, 612, 624, 672,
  735, 816, 1111, 1112, 1113, 1115, 1116, 1131, 1176, 1184, 1197, 1212,
  1296, 1311, 1332, 1344, 1416, 1575, 1715, 2112, 2144, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (zuckerman? num)
  (let (prod (apply * (int-list num)))
    (and (!= prod 0) (= (/ num prod) (div num prod)))))

Facciamo alcune prove:

(zuckerman? 1311)
;-> true
(zuckerman? 1322)
;-> nil

(filter zuckerman? (sequence 1 2200))
;-> (1 2 3 4 5 6 7 8 9 11 12 15 24 36 111 112 115 128 132 135 144 175
;->  212 216 224 312 315 384 432 612 624 672 735 816 1111 1112 1113 1115
;->  1116 1131 1176 1184 1197 1212 1296 1311 1332 1344 1416 1575 1715
;->  2112 2144)

Nota: i numeri di Zuckerman sono un sottoinsieme dei numeri nudi.


--------------------
Numeri di O'Halloran
--------------------

Un numero pari n è un numero di O'Halloran se non esiste un cuboide (parallelepipedo) di dimensione a*b*c la cui superficie è uguale a n.
In altre parole, i numeri di O'Halloran sono quei numeri pari che non possono essere espressi come 2(a*b + b*c + c*a).
La superficie minima che può avere un parallelepipedo è 6, quello in cui le misure l, w e h sono tutte 1.

   2*(l*w + w*h + h*l)
   2*(1*1 + 1*1 + 1*1) = 6

Diverse configurazioni cuboidi (possono) produrre diverse aree superficiali, ma l'area della superficie è sempre un numero intero ed è sempre pari.
Esistono 16 valori pari inferiori a 1000 che non possono essere un'area della superficie di nessun cuboide intero.
Si ipotizza, sebbene non sia stato ancora dimostrato, che non ne esistano altri.

(define (ohalloran)
  (local (max-area half-max-area lst out)
    (setq out '())
    (setq max-area 1000)
    (setq half-max-area 500)
    (setq lst (array half-max-area '(true)))
    (for (l 1 (- max-area 1))
      ;(print l { })
      (for (w 1 (- half-max-area 1))
        (for (h 1 (- half-max-area 1))
          (setq somma (+ (* l w) (* l h) (* w h)))
          (if (< somma half-max-area)
            (setf (lst somma) nil)
          )
        )
      )
    )
    (for (i 3 (- half-max-area 1))
      (if (lst i) (push (* i 2) out -1))
    )
    out))

(time (println (ohalloran)))
;-> (8 12 20 36 44 60 84 116 140 156 204 260 380 420 660 924)
;-> 34810.863


--------------------
Coppie di Ruth-Aaron
--------------------

Due numeri consecutivi n e n+1 formano una coppia Ruth-Aaron se condividono la stessa somma di fattori primi.
Esistono due diverse sequenze ottenute tenendo conto o meno delle molteplicità dei numeri primi.

Se si contano solo numeri primi distinti, allora (104, 105) è una coppia, poiché 104 = 2^3*13 e 105 = 3*5*7 e 2+13 = 3+5+7.

Se invece si contano i numeri primi ripetuti, (125 = 5^3, 126 = 2*3^2*7) è una coppia poiché 5+5+5 = 2+3+3+7.

Numeri di Ruth-Aaron (tipo 1): somma dei divisori primi di n = somma dei divisori primi di n+1.
Sequenza OEIS A006145:
  5, 24, 49, 77, 104, 153, 369, 492, 714, 1682, 2107, 2299, 2600, 2783,
  5405, 6556, 6811, 8855, 9800, 12726, 13775, 18655, 21183, 24024, 24432,
  24880, 25839, 26642, 35456, 40081, 43680, 48203, 48762, 52554, 61760,
  63665, 64232, 75140, 79118, 95709, 106893, 109939, ...


Numeri di Ruth-Aaron (tipo 2): somma dei divisori primi di n = somma dei divisori primi di n+1 (entrambi presi con molteplicità).
Sequenza OEIS A039752:
  5, 8, 15, 77, 125, 714, 948, 1330, 1520, 1862, 2491, 3248, 4185, 4191,
  5405, 5560, 5959, 6867, 8280, 8463, 10647, 12351, 14587, 16932, 17080,
  18490, 20450, 24895, 26642, 26649, 28448, 28809, 33019, 37828, 37881,
  41261, 42624, 43215, 44831, 44891, 47544, 49240, ...

Funzione che verifica se un numero è Ruth-Aaron di tipo 1:

(define (ruth1? num)
  (= (apply + (unique (factor num)))
     (apply + (unique (factor (+ num 1))))))

(ruth1? 104)
;-> true
(ruth1? 105)
;-> nil

(filter ruth1? (sequence 2 110000))
;-> (5 24 49 77 104 153 369 492 714 1682 2107 2299 2600 2783 5405 6556
;->  6811 8855 9800 12726 13775 18655 21183 24024 24432 24880 25839 26642
;->  35456 40081 43680 48203 48762 52554 61760 63665 64232 75140 79118
;->  95709 106893 109939)

Funzione che verifica se un numero è Ruth-Aaron di tipo 2:

(define (ruth2? num)
  (= (apply + (factor num))
     (apply + (factor (+ num 1)))))

(ruth2? 125)
;-> true
(ruth2? 126)
;-> nil

(filter ruth2? (sequence 2 50000))
;-> (5 8 15 77 125 714 948 1330 1520 1862 2491 3248 4185 4191 5405 5560
;->  5959 6867 8280 8463 10647 12351 14587 16932 17080 18490 20450 24895
;->  26642 26649 28448 28809 33019 37828 37881 41261 42624 43215 44831
;->  44891 47544 49240)

Funzione che verifica se un numero è Ruth-Aaron di tipo 1 e 2:

(define (ruth12? num)
  (= (apply + (factor num))
     (apply + (factor (+ num 1)))
     (apply + (unique (factor num)))
     (apply + (unique (factor (+ num 1))))))

(filter ruth12? (sequence 1 1e5))
;-> (5 77 714 5405 26642 52554 95709)


---------------------------------
Stack con valori minimo e massimo
---------------------------------

Definire uno stack, in cui possiamo ottenere il suo numero minimo e massimo con una funzione "min-stack" e "max-stack".
La complessità temporale di "min-stack", "max-stack", "push-stack" e "pop-stack" deve essere O(1).

Un metodo è quello utilizzare come elemento dello stack una lista del tipo:

  (valore valore-minimo valore-massimo)

Poi facciamo in modo che il valore minimo e il valore massimo si trovino sempre sul primo elemento dello stack (l'elemento che si trova alla posizione 0).

(setq stack '())

(define (push-stack val)
  (local (low high)
    (if (!= stack '())
      (begin
        ; stack is not empty
        ; copy minimum value and maximum value from first element of stack
        ; and compare both numbers to value
        ; eventually update min and max value
        (setq low (stack 0 1))
        (setq high (stack 0 2))
        (setq low (min low val))
        (setq high (max high val))
        ; insert new element on stack
        ;(println val { } low { } high)
        (push (list val low high) stack))
        ;else
        ; stack is empty
        ; minimum value = maximum value = value
        (push (list val val val) stack))))

(define (pop-stack)
  (if (= stack '())
      nil
      ;else
      (stack 0 0)))

(define (min-stack) (stack 0 1))
(define (max-stack) (stack 0 2))

Facciamo una prova:

stack
;-> ()
(push-stack 20)
;-> ((20 20 20))
(push-stack 15)
;-> ((15 15 20) (20 20 20))
(push-stack 20)
;-> ((20 15 20) (15 15 20) (20 20 20))
(push-stack 30)
;-> ((30 15 30) (20 15 20) (15 15 20) (20 20 20))
(min-stack)
;-> 15
(max-stack)
;-> 30
(push-stack 5)
;-> ((5 5 30) (30 15 30) (20 15 20) (15 15 20) (20 20 20))
(min-stack)
;-> 5
(max-stack)
;-> 30
(push-stack 45)
;-> ((45 5 45) (5 5 30) (30 15 30) (20 15 20) (15 15 20) (20 20 20))
(pop-stack)
;-> 45
(pop-stack)
;-> 45
(min-stack)
;-> 5
(max-stack)
;-> 45
(push-stack 2)
;-> ((2 2 45) (45 5 45) (5 5 30) (30 15 30) (20 15 20) (15 15 20) (20 20 20))
(min-stack)
;-> 2
(max-stack)
;-> 45

=============================================================================

