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

Y. Katagiri chiama un numero nudo se è divisibile per tutte le sue cifre (che dovrebbero essere diverse da zero).
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


-----------------
Numeri di Leyland
-----------------

Un numero n è un numero di Leyland se può essere scritto come a^b b^a, con a,b > 1. Ad esempio, 368 è un numero di Leyland perché 368 = 5^3 3^5.

Sequenza OEIS A076980:
  3, 8, 17, 32, 54, 57, 100, 145, 177, 320, 368, 512, 593, 945, 1124,
  1649, 2169, 2530, 4240, 5392, 6250, 7073, 8361, 16580, 18785, 20412,
  23401, 32993, 60049, 65792, 69632, 93312, 94932, 131361, 178478, 262468,
  268705, 397585, 423393, 524649, 533169, ...

Il programma esegue due cicli, uno per x e l'altro per y.
Il ciclo esterno inizia da 2 a n, il ciclo interno da 2 a x.
Memorizza x^y + y^x in una lista.
Dopo aver calcolato tutti i valori li ordina e poi li restituisce.

(define (leyland limit)
  (let (out '())
    (for (a 2 limit)
      (for (b 2 a)
        (push (+ (pow a b) (pow b a)) out)
      )
    )
    (sort out <)))

(leyland 8)
;-> (8 17 32 54 57 100 145 177 320 368 512 945 1649 2530 5392 6250 7073
;->  18785 23401 69632 93312 94932 397585 423393 1647086 1941760 7861953
;->  33554432)

Scriviamo una funzione che usa i big-integer.

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

(define (leyland-i limit)
  (let (out '())
    (for (a 2 limit)
      (for (b 2 a)
        (push (+ (** a b) (** b a)) out)
      )
    )
    (sort out <)))

(leyland-i 8)
;-> (8L 17L 32L 54L 57L 100L 145L 177L 320L 368L 512L 945L 1649L 2530L
;->  5392L 6250L 7073L 18785L 23401L 69632L 93312L 94932L 397585L 423393L
;->  1647086L 1941760L 7861953L 33554432L)

(leyland-i 20)
;-> (8L 17L 32L 54L 57L 100L 145L 177L 320L 368L 512L 593L 945L 1124L
;->  1649L 2169L 2530L 4240L 5392L 6250L 7073L 8361L 16580L 18785L 20412L
;->  23401L 32993L 60049L 65792L 69632L 93312L 94932L 131361L 178478L
;->  ...
;->  244552822542936127033092L 332558441007965087890625L
;->  812362695653248917890473L 1209581179614629174706176L
;->  3956839311320627178247958L 4077338606647572522401601L
;->  13010380216396078174437376L 42832853457545958193355601L
;->  209715200000000000000000000L)


-------------------
Numeri apocalittici
-------------------

Un numero n della forma 2^k è detto apocalittico se le sue cifre contengono "666" come sottostringa.
In questo caso il numero k viene chiamato potenza apocalittica, cioè 2^k contiene 666.
Il più piccolo numero apocalittico è 2^157, che è uguale a:

  182687704{666}362864775460604089535377456991567872

Sequenza OEIS A007356:
  157, 192, 218, 220, 222, 224, 226, 243, 245, 247, 251, 278, 285, 286,
  287, 312, 355, 361, 366, 382, 384, 390, 394, 411, 434, 443, 478, 497,
  499, 506, 508, 528, 529, 539, 540, 541, 564, 578, 580, 582, 583, 610,
  612, 614, 620, 624, 635, 646, 647, 648, 649, 650, ...

(define (pow-i num power)
"Calculates the integer power of an integer"
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))
        )
    )
    out))

(define (apocalittici pow-max)
  (let (out '())
    (for (p 1L pow-max)
      ;(println (pow-i 2L p))
      (if (find "666" (string (pow-i 2L p)))
          (push p out -1)
      )
    )
    out))
(pretty-print 65)
(apocalittici 1000L)
;-> (157 192 218 220 222 224 226 243 245 247 251 278 285 286 287 312 355
;->  361 366 382 384 390 394 411 434 443 478 497 499 506 508 528 529 539
;->  540 541 564 578 580 582 583 610 612 614 620 624 635 646 647 648 649
;->  650 660 662 664 666 667 669 671 684 686 693 700 702 704 714 718 720
;->  723 747 748 749 787 800 807 819 820 822 823 824 826 828 836 838 840
;->  841 842 844 846 848 850 857 859 861 864 865 866 867 868 869 871 873
;->  875 882 884 894 898 920 922 924 925 927 928 929 931 937 970 972 975
;->  977 979 981 983 985 994)


---------------------------
Numeri fattoriali alternati
---------------------------

Il fattoriale alternato a(n) di un intero n>0, è uguale a

  n! - (n-1)! + (n-2)! - (n-3)! + ... +-1!

dove il segno dell'ultimo termine dipende dalla parità di n.
Per definizione, a(0) = 0.

Ad esempio, a(5) = 5! - 4! + 3! - 2! + 1! = 101
e a(4) = 4! - 3! + 2! - 1! = 19

Sequenza OEIS A005165:
  0, 1, 1, 5, 19, 101, 619, 4421, 35899, 326981, 3301819, 36614981,
  442386619, 5784634181, 81393657019, 1226280710981, 19696509177019,
  335990918918981, 6066382786809019, 115578717622022981,
  2317323290554617019, 48773618881154822981, ...

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione che calcola il fattoriale alternato di un numero n:

(define (fatalt n)
  (local (fa)
    (cond ((zero? n) 0L)
          ((= n 1) 1L)
      (true
        (setq fa 0L)
        (setq k 1)
        (for (i n 1)
          (setq fa (+ fa (* k (fact-i i))))
          (setq k (* k -1))
        )
        fa))))

Facciamo alcune prove:

(map fatalt (sequence 0 5))
;-> (0L 1L 1L 5L 19L 101L)
(map fatalt (sequence 0 20))
;-> (0L 1L 1L 5L 19L 101L 619L 4421L 35899L 326981L 3301819L 36614981L
;->  442386619L 5784634181L 81393657019L 1226280710981L 19696509177019L
;->  335990918918981L 6066382786809019L 115578717622022981L
;->  2317323290554617019L)


-------------------
Derivata aritmetica
-------------------

La derivata aritmetica di un numero intero (più specificamente, la derivata aritmetica di Lagarias) è una funzione basata sulla scomposizione in fattori primi, per analogia con la regola del prodotto per la derivata di una funzione utilizzata nell'analisi matematica. Di conseguenza, per i numeri naturali n, la derivata aritmetica D(n) è definita come segue:

D(0) = D(1) = 0.
D(p) = 1 per ogni numero primo p.
D(mn) = D(m)*n + m*D(n) per ogni m,n in N. (regola di Leibniz per le derivate).

Inoltre, per numeri interi negativi la derivata aritmetica può essere definita come -D(-n) (n < 0).

Esempi:

  D(2) = 1 e D(3) = 1 (entrambi sono primi) quindi se m*n = 2 * 3, D(6) = (1)(3) + (1)(2) = 5.
  D(9) = D(3)(3) + D(3)(3) = 6
  D(27) = D(3)*9 + D(9)*3 = 9 + 18 = 27
  D(30) = D(5)(6) + D(6)(5) = 6 + 5 * 5 = 31.

Sequenza OEIS A003415 (0..n):
  0, 0, 1, 1, 4, 1, 5, 1, 12, 6, 7, 1, 16, 1, 9, 8, 32, 1, 21, 1, 24,
  10, 13, 1, 44, 10, 15, 27, 32, 1, 31, 1, 80, 14, 19, 12, 60, 1, 21,
  16, 68, 1, 41, 1, 48, 39, 25, 1, 112, 14, 45, 20, 56, 1, 81, 16, 92,
  22, 31, 1, 92, 1, 33, 51, 192, 18, 61, 1, 72, 26, 59, 1, 156, 1, 39,
  55, 80, 18, 71, ...

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

(factor-group 21)
;-> ((3 1) (7 1))

(factor-group 245)
;-> ((5 1) (7 2))

(factor-group 1)
;-> ((1 1))

Funzione cha calcola la derivata aritmetica di un numero intero:

(define (derive num)
  (cond ((< num 0) (- (derive (- num))))
        ; se num è uguale a 0 o 1, allora restituisce 0
        ((< num 2) 0)
        (true
          (setq fattori (factor-group num))
          ; se num è primo restituisce 1
          (if (and (= (length fattori) 1) (= (fattori 0 1) 1))
              1
              ;else
              ; altrimenti clcola la derivata aritmetica
              (begin
                (setq sum 0)
                (dolist (f fattori)
                  (setq sum (+ sum (/ (* num (f 1)) (f 0))))
                )
              )
          ))))

Facciamo alcune prove:

(derive 2)
;-> 1
(derive 9)
;-> 6
(derive 27)
;-> 27
(derive 30)
;-> 31

Calcoliamo le derivate da 0 a 20:

(map derive (sequence 0 20))
;-> (0 0 1 1 4 1 5 1 12 6 7 1 16 1 9 8 32 1 21 1 24)

Calcoliamo le derivate dei numeri da -99 a 100:

(explode (map derive (sequence -99 100)) 10)
;-> ((-75 -77 -1 -272 -24 -49 -34 -96 -20 -123)
;-> (-1 -140 -32 -45 -22 -124 -1 -43 -108 -176)
;->  (-1 -71 -18 -80 -55 -39 -1 -156 -1 -59)
;->  (-26 -72 -1 -61 -18 -192 -51 -33 -1 -92)
;->  (-1 -31 -22 -92 -16 -81 -1 -56 -20 -45)
;->  (-14 -112 -1 -25 -39 -48 -1 -41 -1 -68)
;->  (-16 -21 -1 -60 -12 -19 -14 -80 -1 -31)
;->  (-1 -32 -27 -15 -10 -44 -1 -13 -10 -24)
;->  (-1 -21 -1 -32 -8 -9 -1 -16 -1 -7)
;->  (-6 -12 -1 -5 -1 -4 -1 -1 0 0)
;->  (0 1 1 4 1 5 1 12 6 7)
;->  (1 16 1 9 8 32 1 21 1 24)
;->  (10 13 1 44 10 15 27 32 1 31)
;->  (1 80 14 19 12 60 1 21 16 68)
;->  (1 41 1 48 39 25 1 112 14 45)
;->  (20 56 1 81 16 92 22 31 1 92)
;->  (1 33 51 192 18 61 1 72 26 59)
;->  (1 156 1 39 55 80 18 71 1 176)
;->  (108 43 1 124 22 45 32 140 1 123)
;->  (20 96 34 49 24 272 1 77 75 140))


----------------------------------------------------
Numeri metadrome, plaindrome, nialpdrome e katadrome
----------------------------------------------------

Un numero è "metadrome" se le sue cifre sono in ordine strettamente crescente.
Ad esempio, 1234, 68 e 12789 sono tutti metadrome.

Un numero è "plaindrome" se le sue cifre sono in ordine non decrescente.
Ad esempio, 1334558 e 2222 sono tutti plaindrome.

Un numero è "katadrome" se le sue cifre sono in ordine strettamente decrescente.
Ad esempio, 4321, 86 e 98721 sono tutti katadrome.

Un numero è "nialpdrome" se le sue cifre sono in ordine non crescente.
Ad esempio, 8554331 e 2222 sono tutti nialpdrome.

Sequenza OEIS A009993: (metadrome)
Numeri con cifre in ordine strettamente crescente.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 13, 14, 15, 16, 17, 18, 19, 23, 24,
  25, 26, 27, 28, 29, 34, 35, 36, 37, 38, 39, 45, 46, 47, 48, 49, 56, 57,
  58, 59, 67, 68, 69, 78, 79, 89, ...

Sequenza OEIS A009994: (plaindrome)
Numeri con cifre in ordine non decrescente.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 13, 14, 15, 16, 17, 18, 19, 22, 23,
  24, 25, 26, 27, 28, 29, 33, 34, 35, 36, 37, 38, 39, 44, 45, 46, 47, 48,
  49, 55, 56, 57, 58, 59, 66, 67, 68, 69, 77, 78, 79, 88, 89, 99, ...

Sequenza OEIS A009995: (katadrome)
Numeri con cifre in ordine strettamente decrescente.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 21, 30, 31, 32, 40, 41, 42, 43, 50,
  51, 52, 53, 54, 60, 61, 62, 63, 64, 65, 70, 71, 72, 73, 74, 75, 76, 80,
  81, 82, 83, 84, 85, 86, 87, 90, 91, 92, 93, 94, 95, 96, 97, 98, ...

Sequenza OEIS A009996: (nialpdrome)
Numeri con cifre in ordine non crescente.
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 20, 21, 22, 30, 31, 32, 33, 40, 41,
  42, 43, 44, 50, 51, 52, 53, 54, 55, 60, 61, 62, 63, 64, 65, 66, 70, 71,
  72, 73, 74, 75, 76, 77, 80, 81, 82, 83, 84, 85, 86, 87, 88, 90, 91, 92,
  93, 94, 95, 96, 97, 98, 99, 100, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che cataloga un numero:

(define (drome? num)
  (local (lst)
    (setq lst (int-list num))
          ; lista con elementi uguali =
    (cond ((apply = lst) "plain-nial")
          ((and (apply > lst) (apply >= lst)) "kata-nial")
          ((and (apply < lst) (apply <= lst)) "meta-plain")
          ; lista strettamente decrescente >
          ((apply > lst) "kata")
          ; lista strettamente crescente <
          ((apply < lst) "meta")
          ; lista decrescente >=
          ((apply >= lst) "nial")
          ; lista crescente <=
          ((apply <= lst) "plain")
          ; lista non ordinata
          (true ""))))

Facciamo alcune prove:

(drome? 10)
;-> "nial-kata"
(drome? 11)
;-> "plain-nial"
(drome? 1342)
;-> ""

Funzione che cataloga i numeri fino ad un dato limite:

(define (drome-to limit)
  (local (tipo mata plain nial kata)
    (setq meta (sequence 0 9))
    (setq plain (sequence 0 9))
    (setq nial (sequence 0 9))
    (setq kata (sequence 0 9))
    (for (num 10 limit)
      (setq tipo (drome? num))
            ; lista con elementi uguali =
      (cond ((= tipo "plain-nial")
              (push num plain -1)
              (push num nial -1))
            ((= tipo "kata-nial")
              (push num kata -1)
              (push num nial -1))
            ((= tipo "meta-plain")
              (push num meta -1)
              (push num plain -1))
            ; lista strettamente decrescente >
            ((= tipo "nial")
              (push num nial -1))
            ; lista strettamente crescente <
            ((= tipo "meta")
              (push num meta -1))
            ; lista decrescente >=
            ((= tipo "kata")
              (push num kata -1))
            ; lista crescente <=
            ((= tipo "plain")
              (push num plain)
            ; lista non ordinata
            (true nil))
      )
    )
    (println "metadrome") (println meta)
    (println "plaindrome") (println plain)
    (println "katadrome") (println kata)
    (println "nialpdrome") (println nial)))

Cataloghiamo i numeri da 1 a 100:

(drome-to 100)
;-> metadrome
;-> (0 1 2 3 4 5 6 7 8 9 12 13 14 15 16 17 18 19 23 24 25 26 27 28 29
;->  34 35 36 37 38 39 45 46 47 48 49 56 57 58 59 67 68 69 78 79 89)
;-> plaindrome
;-> (0 1 2 3 4 5 6 7 8 9 11 12 13 14 15 16 17 18 19 22 23 24 25 26 27
;->  28 29 33 34 35 36 37 38 39 44 45 46 47 48 49 55 56 57 58 59 66 67
;->  68 69 77 78 79 88 89 99)
;-> katadrome
;-> (0 1 2 3 4 5 6 7 8 9 10 20 21 30 31 32 40 41 42 43 50 51 52 53 54
;->  60 61 62 63 64 65 70 71 72 73 74 75 76 80 81 82 83 84 85 86 87 90
;->  91 92 93 94 95 96 97 98)
;-> nialpdrome
;-> (0 1 2 3 4 5 6 7 8 9 10 11 20 21 22 30 31 32 33 40 41 42 43 44 50
;->  51 52 53 54 55 60 61 62 63 64 65 66 70 71 72 73 74 75 76 77 80 81
;->  82 83 84 85 86 87 88 90 91 92 93 94 95 96 97 98 99 100)


----------------
Numeri zigodromi
----------------

Un numero è "zigodromo" se è composto da sequenze non banali di cifre identiche, cioè numeri che non hanno serie di cifre con lunghezza minore di 2.
Ad esempio, 112277, 44444333 e 55500111 sono tutti zigodromi
Il nome deriva dal fatto che la radice greca per coppia è "zigo".

Sequenza OEIS A033023:
  11, 22, 33, 44, 55, 66, 77, 88, 99, 111, 222, 333, 444, 555, 666, 777,
  888, 999, 1100, 1111, 1122, 1133, 1144, 1155, 1166, 1177, 1188, 1199,
  2200, 2211, 2222, 2233, 2244, 2255, 2266, 2277, 2288, 2299, 3300, 3311,
  3322, 3333, ...

Algoritmo
Attraversiamo la lista analizzando il valore precedente, quello corrente e quello successivo.
Se (corrente != precedente) e (corrente != successivo), allora il numero non è zigodromo.

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica se un numero è zigodromo:

(define (zigo? num)
  (local (str stop)
    (setq str (string " " num " "))
    (setq stop nil)
    (for (i 1 (- (length str) 2) 1 stop)
      (if (and (!= (str i) (str (- i 1)))
               (!= (str i) (str (+ i 1))))
          (setq stop true)
      )
    )
    (not stop)))

Facciamo alcune prove:

(zigo? 0)
;-> nil
(zigo? 999)
;-> true

(filter zigo? (sequence 1 3335))
;-> (11 22 33 44 55 66 77 88 99 111 222 333 444 555 666 777 888 999 1100
;->  1111 1122 1133 1144 1155 1166 1177 1188 1199 2200 2211 2222 2233
;->  2244 2255 2266 2277 2288 2299 3300 3311 3322 3333)


--------------
Numeri modesti
--------------

Un numero n si dice modesto se le sue cifre possono essere separate in due numeri a e b tali che n diviso b dà a come resto.

Sequenza OEIS A054986:
  13, 19, 23, 26, 29, 39, 46, 49, 59, 69, 79, 89, 103, 109, 111, 133, 199,
  203, 206, 209, 211, 218, 222, 233, 266, 299, 309, 311, 327, 333, 399,
  406, 409, 411, 412, 418, 422, 433, 436, 444, 466, 499, 509, 511, 515,
  533, 545, 555, 599, 609, 611, 618, 622, 627, ...

(define (modest? num)
  (if (< num 10)
      nil
      ;else
      (local (p10 a b)
        (setq p10 10)
        (setq continua true)
        (while (and continua (< p10 num))
          (setq a (/ num p10))
          (setq b (% num p10))
          ;(println a { } b)
          (if (and (> b 0) (= (% num b) a))
            (setq continua nil)
          )
          (setq p10 (* p10 10))
        )
        (not continua))))

Facciamo alcune prove:

(modest? 13)
;-> true
(modest? 42)
;-> nil

(filter modest? (sequence 1 630))
;-> (13 19 23 26 29 39 46 49 59 69 79 89 103 109 111 133 199 203 206 209
;->  211 218 222 233 266 299 309 311 327 333 399 406 409 411 412 418 422
;->  433 436 444 466 499 509 511 515 533 545 555 599 609 611 618 622 627)


-------------------------------------------------------
Attraversamento di liste e stringhe (numeri palindromi)
-------------------------------------------------------

Qualche volta dobbiamo attraversare una lista o una stringa in modo diverso da "dolist" e "dostring".
In questi casi utilizziamo un ciclo "for" (o "while", "until", ecc.).
Vediamo se è più veloce attraversare una stringa o una lista.
Supponiamo di dover verificare se un numero intero è palindromo.
L'algoritmo consiste nel verificare se le coppie di numeri di inizio e fine sono uguali e continuando per tutto il numero.

Esempio: 12346321
primo confronto:   (1)234632(1) --> cifre uguali  --> prossima coppia
secondo confronto: 1(2)3463(2)1 --> cifre uguali  --> prossima coppia
terzo confronto:   12(3)46(3)21 --> cifre uguali  --> prossima coppia
quarto confronto:  123(4)(6)321 --> cifre diverse --> numero non palindromo

Esempio: 12512
primo confronto:   (1)252(1) --> cifre uguali  --> prossima coppia
secondo confronto: 1(2)5(2)1 --> cifre uguali  --> prossima coppia
terzo confronto:   12(5)21   --> cifra uguale  --> numero palindromo

Sequenza OEIS A002113:
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88, 99, 101,
  111, 121, 131, 141, 151, 161, 171, 181, 191, 202, 212, 222, 232, 242,
  252, 262, 272, 282, 292, 303, 313, 323, 333, 343, 353, 363, 373, 383,
  393, 404, 414, 424, 434, 444, 454, 464, 474, 484, 494, 505, 515, ...

Scriviamo due funzioni identiche che operano una su una lista e l'altra su una stringa:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (palin1? num)
  (if (< num 10)
      true
      ;else
      (local (len half)
        (setq len (length num))
        (setq half (- (/ len 2) 1))
        (setq lst (int-list num))
        (setq out nil)
        (for (i 0 half 1 out)
          (if (!= (lst i) (lst (- len 1 i)))
              (setq out true)
          )
        )
        (not out))))

(palin1? 2)
;-> true
(palin1? 12346321)
;-> nil
(palin1? 12521)
;-> true
(filter palin1? (sequence 0 1000))
;-> (0 1 2 3 4 5 6 7 8 9 11 22 33 44 55 66 77 88 99 101 111 121 131 141
;->  151 161 171 181 191 202 212 222 232 242 252 262 272 282 292 303 313
;->  323 333 343 353 363 373 383 393 404 414 424 434 444 454 464 474 484
;->  494 505 515 525 535 545 555 565 575 585 595 606 616 626 636 646 656
;->  666 676 686 696 707 717 727 737 747 757 767 777 787 797 808 818 828
;->  838 848 858 868 878 888 898 909 919 929 939 949 959 969 979 989 999)

(define (palin2? num)
  (if (< num 10)
      true
      ;else
      (local (len half)
        (setq len (length num))
        (setq half (- (/ len 2) 1))
        (setq str (string num))
        (setq out nil)
        (for (i 0 half 1 out)
          (if (!= (str i) (str (- len 1 i)))
              (setq out true)
          )
        )
        (not out))))

(palin2? 2)
;-> true
(palin2? 12346321)
;-> nil
(palin2? 12521)
;-> true
(filter palin2? (sequence 0 1000))
;-> (0 1 2 3 4 5 6 7 8 9 11 22 33 44 55 66 77 88 99 101 111 121 131 141
;->  151 161 171 181 191 202 212 222 232 242 252 262 272 282 292 303 313
;->  323 333 343 353 363 373 383 393 404 414 424 434 444 454 464 474 484
;->  494 505 515 525 535 545 555 565 575 585 595 606 616 626 636 646 656
;->  666 676 686 696 707 717 727 737 747 757 767 777 787 797 808 818 828
;->  838 848 858 868 878 888 898 909 919 929 939 949 959 969 979 989 999)

Vediamo la velocità delle due funzioni:

(time (filter palin1? (sequence 0 1e6)))
;-> 1803.993
(time (filter palin2? (sequence 0 1e6)))
;-> 1552.972

La funzione sulle stringhe è leggermente più veloce, ma la conversione da numero a lista (int-list) è più lenta della conversione da numero a stringa (string num).

Scriviamo una test specifico.

(define (test1 lst)
  (local (len half)
    (setq len (length lst))
    (setq half (- (/ len 2) 1))
    (setq out 0)
    (for (i 0 half)
      (if (= (lst i) (lst (- len 1 i)))
          (++ out)
      )
    )
    out))

(define (test2 str)
  (local (len half)
    (setq len (length str))
    (setq half (- (/ len 2) 1))
    (setq out 0)
    (for (i 0 half)
      (if (= (str i) (str (- len 1 i)))
          (++ out)
      )
    )
    out))

Prova con stringa/lista corta (65 caratteri/elementi):

(setq s "32857135987190358719803571890235718935712985376819235761125078393")
(setq l (explode s))

(time (test1 l) 1e5)
;-> 795.167
(time (test2 s) 1e5)
;-> 1153.354

Prova con stringa/lista lunga (2000 caratteri/elementi):

(setq s (join (map string (rand 10 2000))))
(setq l (explode s))

(time (test1 l) 1e3)
;-> 2480.59
(time (test2 s) 1e3)
;-> 3716.341

Quindi attraversare liste è più veloce che attraversare stringhe (con il ciclo "for").


-------------------------
Tipi di numeri primoriali
-------------------------

Esistono due tipi di numeri primoriali.

Primo tipo
----------
I numeri primoriali p(n) sono il prodotto dei primi n numeri primi:

  p(0) = 1
  p(1) = 2
  p(2) = 2 * 3 = 6

Sequenza OEIS A002110:
  1, 2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230,
  200560490130, 7420738134810, 304250263527210, 13082761331670030,
  614889782588491410, 32589158477190044730, 1922760350154212639070,
  117288381359406970983270, 7858321551080267055879090, ...

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

(define (primoriale1 num)
  (let (primi (primes-to 1000))
    ;(setq primi (primes-to 100)) ; 25 primi in 0 millisec)
    ;(setq primi (primes-to 1e4)) ; 1229 primi in 2 millisec)
    ;(setq primi (primes-to 1e6)) ; 78498 primi in 133 millisec)
    (apply * (slice primi 0 num)))

Facciamo alcune prove:

(primoriale1 4)
;-> 210

(map primoriale1 (sequence 1 15))
;-> (2 6 30 210 2310 30030 510510 9699690 223092870 6469693230 200560490130
;->  7420738134810 304250263527210 13082761331670030 614889782588491410)

Il massimo valore che possiamo calcolare per i numeri primoriali di primo tipo è p(15) perchè non abbiamo usato i numeri big integer.

Secondo tipo
------------
I numeri primoriali N(n) di un numero N sono il prodotto di tutti gli n numeri primi minori o uguali a N:

 N(0) = 0
 N(1) = 0
 N(2) = 2
 N(3) = 6
 N(4) = 6

Sequenza OEIS A034386:
  1, 1, 2, 6, 6, 30, 30, 210, 210, 210, 210, 2310, 2310, 30030, 30030,
  30030, 30030, 510510, 510510, 9699690, 9699690, 9699690, 9699690,
  223092870, 223092870, 223092870, 223092870, 223092870, 223092870,
  6469693230, 6469693230, 200560490130, 200560490130, ...

(define (primoriale2 num)
  (let (primi (primes-to num))
  (apply * primi)))

Facciamo alcune prove:

(primoriale2 4)
;-> 6

(map primoriale2 (sequence 1 15))
;-> (1 2 6 6 30 30 210 210 210 210 2310 2310 30030 30030 30030)


----------------------------
Quanti numeri primi ci sono?
----------------------------

Oltre 2.300 anni fa Euclide dimostrò che il numero di numeri primi è infinito, quindi mi viene in mente una possibile domanda:
Dato un numero reale positivo x, quanti numeri primi hanno un valore minore o uguale a x?

  π(x) = il numero di numeri primi minori o uguali a x.

I numeri primi sotto 25 sono 2, 3, 5, 7, 11, 13, 17, 19 e 23 quindi π(3) = 2, π(10) = 4 e π(25) = 9.

Tabella 1: Valori di π(x)

  n                                   x                                π(x)
  -------------------------------------------------------------------------
  1                                  10                                  4
  2                                 100                                 25
  3                               1,000                                168
  4                              10,000                              1,229
  5                             100,000                              9,592
  6                           1,000,000                             78,498
  7                          10,000,000                            664,579
  8                         100,000,000                          5,761,455
  9                       1,000,000,000                         50,847,534
  10                     10,000,000,000                        455,052,511
  11                    100,000,000,000                      4,118,054,813
  12                  1,000,000,000,000                     37,607,912,018
  13                 10,000,000,000,000                    346,065,536,839
  14                100,000,000,000,000                  3,204,941,750,802
  15              1,000,000,000,000,000                 29,844,570,422,669
  16             10,000,000,000,000,000                279,238,341,033,925
  17            100,000,000,000,000,000              2,623,557,157,654,233
  18          1,000,000,000,000,000,000             24,739,954,287,740,860
  19         10,000,000,000,000,000,000            234,057,667,276,344,607
  20        100,000,000,000,000,000,000          2,220,819,602,560,918,840
  21      1,000,000,000,000,000,000,000         21,127,269,486,018,731,928
  22     10,000,000,000,000,000,000,000        201,467,286,689,315,906,290
  23    100,000,000,000,000,000,000,000      1,925,320,391,606,803,968,923
  24  1,000,000,000,000,000,000,000,000     18,435,599,767,349,200,867,866
  25 10,000,000,000,000,000,000,000,000    176,846,309,399,143,769,411,680

Molti matematici hanno provato a definire una formula per calcolare π(x) e hanno trovato soluzioni abbastanza complesse.
Dal punto di vista pratico possiamo approssimare π(x) con le seguenti funzioni:

            x
  π(x) ≈ -------,  per x piccoli
          ln(x)

              x
  π(x) ≈ -----------, per x grandi
          ln(x) - 1

(define (primi-low x) (int (div x (log x))))

(map primi-low '(10 1e2 1e3 1e4 1e5 1e6 1e7 1e8 1e9 1e10))
;-> (4 21 144 1085 8685 72382 620420 5428681 48254942 434294481)

(define (primi-high x) (int (div x (sub (log x) 1))))

(map primi-high '(10 1e2 1e3 1e4 1e5 1e6 1e7 1e8 1e9 1e10))
;-> (7 27 169 1217 9512 78030 661458 5740303 50701542 454011971)

Tabella 2: Valori di π(x)-low, π(x)-high e π(x)

               x      π(x)-low     π(x)-high          π(x)
----------------------------------------------------------
              10             4             7             4
             100            21            27            25
           1,000           144           169           168
          10,000          1085          1217          1229
         100,000          8685          9512          9592
       1,000,000         72382         78030         78498
      10,000,000        620420        661458        664579
     100,000,000       5428681       5740303       5761455
   1,000,000,000      48254942      50701542      50847534
  10,000,000,000     434294481     454011971     455052511

Vedere anche "Teorema di Euclide (infinità dei numeri primi)" su "Note libere 2".


------------------------------------
Somma degli inversi dei numeri primi
------------------------------------

La somma degli inversi dei numeri primi è una serie convergente o divergente?

  1/2 + 1/3 + 1/5 + 1/7 + 1/11 + 1/13 + ...

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

Funzioni per il calcolo della somma di due frazioni (big-integer):

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (+ (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1L) (r2 1L))))

(+rat '(1 2) '(1 3))
;-> (5L 6L)
(+rat '(1 2) '(1 2))
;-> (1L 1L)
(+rat '(0 1) '(1 2))
;-> (1L 2L)

Funzione che calcola la somma degli inversi dei primi N numeri primi:

(define (serie nprimi)
  (local (s)
    (setq primi (primes-to nprimi))
    (setq s '(0 1))
    (dolist (p primi)
      (setq s (+rat s (list 1 p)))
    )
    (println (div (s 0) (s 1)))
    (println (/ (s 0) (s 1)))
    s))

(serie 10)
;-> 1.176190476190476
;-> 1L
;-> (247L 210L)
(serie 50)
;-> 1.661646517015796
;-> 1L
;-> (1021729465586766997L 614889782588491410L)
(serie 100)
;-> 1.802817201048871
;-> 1L
;-> (4156517583588203716343221884611037839L
;->  2305567963945518424753102147331756070L)
(serie 200)
;-> 1.949034074928571
;-> 1L
;-> (15202313841027497739047080375538859939135
;->  227730139536997746371469607707132833646367L
;->  77999220416834615532491991063298138766879
;->  96789903550945093032474868511536164700810L)
(serie 1000)
;-> -1.#IND
;-> 2L
;-> ...
> (serie 2000)
;-> -1.#IND
;-> 2L
;-> ...

Nota: Non eseguire (serie 5000)...la memoria finisce e newLISP va in crash.

Purtroppo l'operatore "div" va in overflow perchè i numeratori e denominatori sono numeri molto grandi.

Comunque per confrontare due frazioni possiamo utilizzare il seguente metodo.
Consideriamo due frazioni:

        num1            num2
  f1 = ------,    f2 = ------
        den1            den2

Calcoliamo i seguenti due valori:

  val1 = num1 * den2
  val2 = num2 * den1

Se val1 > val2, allora f1 > f2
Se val1 = val2, allora f1 = f2
Se val1 < val2, allora f1 < f2

(define (confronta f1 f2)
  (local (num1 den1 num2 den2 val1 val2)
    (setq num1 (f1 0))
    (setq den1 (f1 1))
    (setq num2 (f2 0))
    (setq den2 (f2 1))
    (setq val1 (* num1 den2))
    (setq val2 (* num2 den1))
    (cond ((> val1 val2) "f1")
          ((< val1 val2) "f2")
          ((= val1 val2) "="))))

Adesso possiamo confrontare le frazioni di due serie:

(confronta (serie 100) (serie 200))
;-> 1.802817201048871
;-> 1.949034074928571
;-> "f2"

(confronta (serie 1000) (serie 2000))
;-> -1.#IND
;-> -1.#IND
;-> "f2"

Le prove fatte mostrano che la serie cresce, ma non possiamo affermare che è divergente.
Comunque è stato dimostrato matematicamente che la serie diverge.

Per maggiori informazioni: https://t5k.org/infinity.html.

È interessante notare che esiste un limite per le somme degli inversi dei numeri primi:
sia S(x) la somma degli inversi dei primi minori di x, per x > 1 risulta:

 log(log x) < S(x) < log(log x) + B + 1/(log x)^2

dove B vale circa 0.261497.


---------------------
Numeri k-iperperfetti
---------------------

Un numero k-iperperfetto è un numero naturale n per il quale vale l'uguaglianza n = 1 + k(sigma(n) − n − 1), dove sigma(n) è la funzione divisore (cioè la somma di tutti i divisori positivi di N). Un numero iperperfetto è un numero k-iperperfetto per qualche intero k. I numeri iperperfetti generalizzano i numeri perfetti, che sono 1-iperperfetti.

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(define (divisors-sum num)
"Sum all the divisors of integer number"
  (local (sum out)
    (if (= num 1)
        1
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum)))))))

(divisors-sum 3)
;-> 4
(divisors-sum 6)
;-> 12

Funzione che verifica se un numero è hyper-k per un dato k:

(define (hyper-k? k num)
  (= num (+ 1 (* k (- (divisors-sum num) num 1)))))

(hyper-k? 1 28)
;-> true

Numeri hyper-1 (cioè hyper-k con k = 1) fino a 50:

(filter (curry hyper-k? 1) (sequence 1 50))
;-> (6 28)

Funzione che genera tutti i numeri hyper-k sotto un certo limite per un dato k:

(define (hyper-k-to k limit)
  (filter (curry hyper-k? k) (sequence 1 limit)))

(hyper-k-to 1 1e6)
;-> (6 28 496 8128)

Vediamo tutti i numeri hyper-k fino ad 1 milione con k che va da 1 a 10:

(for (k 1 10)
  (println "k = " k)
  (println (hyper-k-to k 1e6))
)
;-> k = 1
;-> (6 28 496 8128)
;-> k = 2
;-> (21 2133 19521 176661)
;-> k = 3
;-> (325)
;-> k = 4
;-> ()
;-> k = 5
;-> ()
;-> k = 6
;-> (301 16513)
;-> k = 7
;-> ()
;-> k = 8
;-> ()
;-> k = 9
;-> ()
;-> k = 10
;-> (159841)

Scriviamo una funzione ottimizzata (che calcola sigma(num) solo una volta):

(define (test kmax limite)
  (let (out '())
    (for (num 1 limite)
      (setq sigma (divisors-sum num))
      (for (k 1 kmax)
        (if (= num (+ 1 (* k (- sigma num 1))))
            (push (list k num) out -1)
        )
      )
    )
    (sort out)))

Facciamo alcune prove:

(time (println (test 4 1e6)))
;-> ((1 6) (1 28) (1 496) (1 8128) (2 21) (2 2133) (2 19521) (2 176661) (3 325))
;-> 3235.131

(time (println (test 1 1e6)))
;-> ((1 6) (1 28) (1 496) (1 8128))
;-> 2855.905

(time (println (test 1 1e7)))
((1 6) (1 28) (1 496) (1 8128))
;-> 38082.981

Per ottimizzare il calcolo possiamo precalcolare la somma dei divisori di tutti i numeri da 1 a 1e8.

(define (crea-sigma limite)
  (let (out '(0))
    (for (num 1 limite) (push (divisors-sum num) out -1))))

(time (setq sum-div (crea-sigma 1e6)))
;-> 2716.346

Lista con le somme dei divisori di tutti i numeri da 1 a 1e8 (100 milioni):

(time (setq sum-div (crea-sigma 1e8)))
;-> 616166.762 ;10 minuti e 16 secondi

(save "sum-div.lsp" 'sum-div)
;-> true
Ci mette alcuni minuti a salvare un file con 100 milioni di numeri...
sum-div.lsp --> 950 Mbyte circa

;(load "sum-div.lsp")

Per fare una prova:

(silent (setq sdiv (slice sum-div 0 1e5)))

(define (test2 kmax)
  (let (out '())
    (dolist (sd sum-div)
    ;(dolist (sd sdiv)
      (setq num $idx)
      (for (k 1 kmax)
        (if (= num (+ 1 (* k (- sd num 1))))
            (push (list k num) out -1)
        )
      )
    )
    (sort out)))

(time (println (test2 20)))
;-> ((1 0) (1 6) (1 28) (1 496) (1 8128) (1 33550336)
;->  (2 21) (2 2133) (2 19521) (2 176661)
;->  (3 325)
;->  (4 1950625)
;->  (6 301) (6 16513) (6 60110701)
;->  (10 159841)
;->  (11 10693)
;->  (12 697) (12 2041) (12 1570153) (12 62722153)
;->  (18 1333) (18 1909) (18 2469601)
;->  (19 51301))
;-> 254203.221


------------------------------
Tagli simultanei di un bastone
------------------------------

Un bastone lungo N unità deve essere tagliato in N pezzi da 1 unità.
Qual è il numero minimo di tagli richiesto se si possono tagliare più pezzi di bastoncini contemporaneamente?
Scrivere una funzione che restituisce il numero minimo di tagli per un bastone di N unità di lunghezza.

Poiché possiamo tagliare contemporaneamente più pezzi, dobbiamo trovare un algoritmo di taglio che riduce la dimensione del pezzo più lungo fino a 1.
Ad ogni iterazione dobbiamo tagliare il pezzo più lungo, e contemporaneamente tutti gli altri pezzi la cui dimensione è maggiore di 1), della metà (o il più vicino possibile alla metà).
In altre parole, se la lunghezza l di un pezzo è pari, viene tagliato in due pezzi di lunghezza l/2,
se l è dispari e maggiore di 1, viene tagliato in due pezzi di lunghezza l/2 = (l + 1)/2 e l/2 = (l − 1)/2.
Il processo di taglio si ferma quando il più lungo (e quindi tutti gli altri pezzi del bastone) ha lunghezza 1.
Il numero di tagli (iterazioni) che vengono effettuati per un bastone lungo N è uguale a ceil(log2(n)), che è il minimo k tale che 2^k >= n.

(define (cut num view)
  (local (pezzi tagli tmp p1 p2)
    (setq pezzi (list num))
    (setq tagli 0) ; numero tagli contemporanei
    ; ciclo fino a che tutti i pezzi hanno lunghezza 1
    ; cioè fino a che nella lista pezzi non ci sono num pezzi lunghi 1.
    (until (= (length (ref-all 1 pezzi)) num)
      ; lista temporanea per i pezzi del taglio corrente
      (setq tmp '())
      ; ciclo che taglia tutti i pezzi maggiori di 1
      (dolist (p pezzi)
        (cond ((and (odd? p) (> p 1)) ; pezzo lungo dispari
               ; taglio dei pezzi
               (setq p1 (/ (+ p 1) 2))
               (setq p2 (/ (- p 1) 2))
               ; inserimento pezzi tagliati nella lista temporanea
               (push p1 tmp -1)
               (push p2 tmp -1))
              ((even? p)              ; pezzo lungo pari
               ; taglio dei pezzi
               (setq p1 (/ p 2))
               (setq p2 (/ p 2))
               ; inserimento pezzi tagliati nella lista temporanea
               (push p1 tmp -1)
               (push p2 tmp -1))
              (true                   ; pezzo lungo 1
               (push 1 tmp -1))
        )
      )
      (++ tagli)
      ; ad ogni taglio i nuovi pezzi si trovano nella lista temporanea
      (setq pezzi tmp)
      (if view (println "Taglio: " tagli "\n" pezzi))
    )
    ; (ceil(log num 2)) = tagli
    (list tagli (ceil(log num 2)))))

Facciamo alcune prove:

(cut 10 true)
;-> Taglio: 1
;-> (5 5)
;-> Taglio: 2
;-> (3 2 3 2)
;-> Taglio: 3
;-> (2 1 1 1 2 1 1 1)
;-> Taglio: 4
;-> (1 1 1 1 1 1 1 1 1 1)
;-> (4 4)

(cut 20 true)
;-> Taglio: 1
;-> (10 10)
;-> Taglio: 2
;-> (5 5 5 5)
;-> Taglio: 3
;-> (3 2 3 2 3 2 3 2)
;-> Taglio: 4
;-> (2 1 1 1 2 1 1 1 2 1 1 1 2 1 1 1)
;-> Taglio: 5
;-> (1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
;-> (5 5)

(cut 100)
;-> (7 7)
ceil(log2(100)) = 7, infatti 2^6 < 100 e 2^7 > 100.


---------------------
Sequenze a somma zero
---------------------

Abbiamo una sequenza di numeri interi consecutivi da 1 a N.
Utilizzando solo le operazioni "+" e "-", dobbiamo scrivere un espressione che utilizza tutti i numeri da 1 a N la cui valutazione (somma) vale zero.
Ad esempio con la sequenza (1 2 3) la soluzione è 1 + 2 - 3 = 0.
Non tutte le sequenze possono generare un'espressione con somma zero.
Per esempio la sequenza 1 2 non ha soluzione.
Inoltre una sequenza può avere più soluzioni.

Il problema ha una soluzione se e solo se N o N+1 è divisibile per 4.
Poiché S = 1+2+...+N = N*(N+1)/2, la somma dei numeri in ciascuno dei sottoinsiemi deve essere uguale a esattamente metà di S.
Ciò implica che N*(N + 1)/2 deve essere pari come condizione necessaria per avere una soluzione.
Notiamp che N*(N + 1)/2 è pari se e solo se N è un multiplo di 4 o N + 1 è un multiplo di 4.
Infatti, se N*(N + 1)/2 = 2k, allora N*(N + 1) = 4k e poiché N o N + 1 è dispari, l'altro deve essere divisibile per 4.
Al contrario, se N o N + 1 è un multiplo di 4, N (N + 1)/2 è ovviamente pari.

Se N è divisibile per 4, una soluzione è quella di dividere la sequenza di numeri da 1 a N in N/4 gruppi di quattro numeri interi consecutivi e quindi mettere dei "+" prima del primo e del quarto numero e dei "-" prima del secondo e terzo numero in ognuno di questi gruppi:

  (1 − 2 − 3 + 4) + ··· + ((n−3) − (n−2) − (n−1) + n) = 0       (1)

Se n + 1 è divisibile per 4, allora n = 4k - 1 = 3 + 4 (k - 1) e possiamo usare lo stesso metodo dopo aver trattato i primi tre numeri come segue:

  (1+2−3) + (4−5−6+7) + ··· + ((n−3) − (n−2) − (n−1) + n) = 0   (2)

Algoritmo:
Calcolare resto = N % 4 (il resto della divisione di N di 4).
Se resto è uguale a 0, inserire i segni "+" e "-" come nella formula (1)
Se resto è uguale a 3, inserire i segni "+" e "-" come nella formula (2)
Altrimenti, restituire una lista vuota.

(define (pari num)
  (local (out tipo)
    (setq out '())
    (setq tipo (% num 4))
    (cond
      ((= tipo 0)
        (setq lst (explode (sequence 1 num) 4))
        (dolist (el lst)
          (push (list (el 0) '- (el 1) '- (el 2) '+ (el 3)) out -1)
          (push '+ out -1)
        )
        (pop out -1)) ; rimuove l'ultimo +
      ((= tipo 3)
        (setq lst (explode (sequence 4 num) 4))
        (dolist (el lst)
          (push '+ out -1)
          (push (list (el 0) '- (el 1) '- (el 2) '+ (el 3)) out -1)
        )
        (push (list 1 '+ 2 '- 3) out)) ; aggiunge i primi 3 numeri
      (true nil) ; impossibile trovare somma 0
    )
    out))

Facciamo alcune prove:

(pari 12)
;-> ((1 - 2 - 3 + 4) + (5 - 6 - 7 + 8) + (9 - 10 - 11 + 12))

Nota: la funzione "xlate" si trova nel file "yo.lsp".

(eval (xlate (string (pari 12))))
;-> 0

(pari 23)
;-> ((1 + 2 - 3) + (4 - 5 - 6 + 7) + (8 - 9 - 10 + 11) +
;->  (12 - 13 - 14 + 15) + (16 - 17 - 18 + 19) + (20 - 21 - 22 + 23))

(eval (xlate (string (pari 23))))
;-> 0

(pari 25)
;-> ()


----------------------------------------------------------------
Circonferenza con copertura massima di una lista di punti interi
----------------------------------------------------------------

Dato una lista di punti interi, trovare il centro di un cerchio di dimensioni predeterminate che contiene il maggior numero di punti.
Esempio: 1000 punti, in un reticolo 500x500 e un cerchio di 50 di diametro.

Per un'area rettangolare MxN, numero di punti P e raggio R:
1) Inizializzare una matrice 2D di interi di dimensione MxN con tutti zeri
2) Per ognuno dei punti P:
  incrementare di 1 tutti i punti della mappa entro il raggio R
3) Trovare l'elemento della matrice con il valore massimo: questo è il centro del cerchio che contiene il maggir numero di punti.

(define (dist2d-2 x1 y1 x2 y2)
"Calculates the square of 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (add (mul (sub x1 x2) (sub x1 x2))
       (mul (sub y1 y2) (sub y1 y2))))

(define (dist2d-2 x1 y1 x2 y2)
"Calculates the square of 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (+ (* (- x1 x2) (- x1 x2))
     (* (- y1 y2) (- y1 y2))))

(define (circle-points radius pts)
  (local (grid r2 cx cy xmin xmax ymin ymax lst)
    (setq grid (array 501 501 '(0)))
    (setq r2 (mul radius radius))
    (dolist (p pts)
      (setq cx (p 0))
      (setq cy (p 1))
      ; ricerca dei punti solo nel quadrato con centro cx,cy e lato 2*radius
      ; (ottimale: analizzare un solo quadrante)
      (setq xmin (- radius cx))
      (setq xmax (+ radius cx))
      (setq ymin (- radius cy))
      (setq ymax (+ radius cy))
      ; punto interno al cerchio?
      (for (m xmin xmax 1)
        (for (n ymin ymax 1)
          (if (<= (dist2d-2 m n cx cy) r2) (++ (grid m n)))
        )
      )
    )
    ; ricerca nella matrice del punto con valore massimo
    (setq lst (array-list grid))
    (ref (apply max (flat lst)) lst)))

(setq punti '((1 1) (3 3) (4 1) (4 3) (5 3)))
(circle-points 2 punti)
;-> (4 2)

10 punti:
(setq x (rand 499 10))
(setq y (rand 499 10))
(setq punti1 (map list x y))
(time (println (circle-points 50 punti1)))
;-> (22 420)
;-> 758.945

100 punti:
(setq x (rand 499 100))
(setq y (rand 499 100))
(setq punti2 (map list x y))
(time (println (circle-points 50 punti2)))
(431 50)
;-> 6758.597

1000 punti:
(setq x (rand 499 1000))
(setq y (rand 499 1000))
(setq punti3 (map list x y))
(time (println (circle-points 50 punti3)))
;-> (275 256)
;-> 70624.953

Nota: questo algoritmo è molto lento. Questo problema può essere risolto in modo efficiente con l'algoritmo Angular Sweep.


-------------------------------
Teorema di Polya (Random Walks)
-------------------------------

Il teorema di ricorrenza di Polya afferma che una passeggiata casuale è ricorrente in reticoli (lattice) a 1 e 2 dimensioni ed è transitoria per reticoli con più di 2 dimensioni. Polya ha definito una passeggiata casuale come ricorrente se attraversa ogni singolo punto su un reticolo con probabilità 1, altrimenti la passeggiata è transitoria.

Nel libro "An Introduction to Probability Theory and its Applications", Feller fornisce la seguente formulazione del teorema di Polya:

Teorema
Nelle passeggiate aleatorie simmetriche in una e due dimensioni c'è probabilità 1 che la particella prima o poi (e
quindi infinitamente spesso) ritorna alla sua posizione iniziale.
In tre dimensioni, tuttavia, questa probabilità è < 1.
(La probabilità di ritorno in tre dimensioni è di circa 0.35).

In generale:
In 1D la particella ritorna allo posizione iniziale con probabilità 1.
Distanza attesa dopo n passi: sqrt(n).

In 2D la particella ritorna allo posizione iniziale con probabilità 1.
Distanza attesa dopo n passi: sqrt(n).

In 3D la particella ritorna allo posizione iniziale con probabilità 0.34.
Distanza attesa dopo n passi: sqrt(n)*c(D), dove c(D) è una costante che dipende dalla dimensione D.

Per le dimensioni superiori:
In 4D la particella ritorna allo posizione iniziale con probabilità 0.19.
In 5D la particella ritorna allo posizione iniziale con probabilità 0.14.
In 6D la particella ritorna allo posizione iniziale con probabilità 0.10.
In 7D la particella ritorna allo posizione iniziale con probabilità 0.09.
In 8D la particella ritorna allo posizione iniziale con probabilità 0.07.

Vediamo di simulare il processo di random walk in 1, 2 e 3 dimensioni.

(define (go-1d iter)
  (local (stop pos k)
    (setq stop nil)
    (setq pos 0)
    (setq k 0)
    (until (or stop (>= k iter))
      (setq coord (rand 2))
      (if (zero? coord)
        (++ pos)
        (-- pos)
      )
      (++ k)
      ;(print pos) (read-line)
      (if (= pos 0) (setq stop true ))
    )
    (list k pos)))

(go-1d 1e5)
;-> (2 0)

(define (go-2d iter)
  (local (stop pos k)
    (setq stop nil)
    (setq pos '(0 0))
    (setq k 0)
    (until (or stop (>= k iter))
      (setq coord (rand 4))
      (case coord
        (0 (++ (pos 0)))
        (1 (-- (pos 0)))
        (2 (++ (pos 1)))
        (3 (-- (pos 1)))
      )
      (++ k)
      ;(print pos) (read-line)
      (if (= pos '(0 0)) (setq stop true ))
    )
    (list k pos)))

(go-2d 1e5)
;-> (100000 (-15 -73))

(define (go-3d iter)
  (local (stop pos k)
    (setq stop nil)
    (setq pos '(0 0 0))
    (setq k 0)
    (until (or stop (>= k iter))
      (setq coord (rand 6))
      (case coord
        (0 (++ (pos 0)))
        (1 (-- (pos 0)))
        (2 (++ (pos 1)))
        (3 (-- (pos 1)))
        (4 (++ (pos 2)))
        (5 (-- (pos 2)))
      )
      (++ k)
      ;(print pos) (read-line)
      (if (= pos '(0 0 0)) (setq stop true ))
    )
    (list k pos)))

(go-3d 1e5)
;-> (100000 (-228 52 18))

(define (return prove iter)
  (setq r1 0 r2 0 r3 0)
  (for (i 1 prove)
    (if (!= iter ((go-1d iter) 0)) (++ r1))
    (if (!= iter ((go-2d iter) 0)) (++ r2))
    (if (!= iter ((go-3d iter) 0)) (++ r3))
  )
  (println r1 { } r2 { } r3)
  (list (div r1 prove) (div r2 prove) (div r3 prove)))

Facciamo alcune prove:

Con 10 prove il risultato non è affidabile (solo per definire i tempi di esecuzione).
(time (println (return 10 1e6)))
;-> 10 5 4
;-> (1 0.5 0.4)
;-> 2214.077
(time (println (return 10 1e7)))
;-> 10 7 6
;-> (1 0.7 0.6)
;-> 14161.079
(time (println (return 10 1e8)))
;-> 10 7 5
;-> (1 0.7 0.5)
;-> 161621.354

100 prove:
(time (println (return 100 1e5)))
;-> 100 75 36
;-> (1 0.75 0.36)
;-> 1837.259
(time (println (return 100 1e6)))
;-> 100 84 39
;-> (1 0.84 0.39)
;-> 15879.205
(time (println (return 100 1e7)))
;-> 100 83 29
;-> (1 0.83 0.29)
;-> 179723.59
(time (println (return 100 1e8)))
;-> 100 89 31
;-> (1 0.89 0.31)
;-> 1650074.581

1000 prove:
(time (println (return 1000 1e4)))
;-> 995 741 336
;-> (0.995 0.741 0.336)
;-> 1978.672
(time (println (return 1000 1e5)))
;-> 998 764 357
;-> (0.998 0.764 0.357)
;-> 18442.772
(time (println (return 1000 1e6)))
;-> 997 813 337
;-> (0.997 0.8129999999999999 0.337)
;-> 177252.735

10000 prove:
(time (println (return 10000 1e4)))
;-> 9930 7407 3376
;-> (0.993 0.7407 0.3376)
;-> 19414.774
(time (println (return 10000 1e5)))
;-> 9972 7836 3406
;-> (0.9972 0.7836 0.3406)
;-> 182199.293

Le simulazioni hanno prodotto i seguenti risultati:
  1D: quasi il 100% ritorna al punto 0 (congruente con il teorema)
  2D: dal 74% al 89% ritorna al punto 0,0 (in "direzione" con il teorema)
  3D: circa il 35% ritorna al punto 0,0,0 (congruente con il teorema)


---------------
Scrivere numeri
---------------

Vogliamo scrivere una lista di numeri interi positivi 1, 2, 3,... usando il computer.
Tuttavia, puoi premere ciascun tasto 0–9 al massimo N volte durante il processo.
Qual è l'ultimo numero che riesci a scrivere in funzione di N?
Esempio:
N = 5 --> output = 12

Sequenza: 1 2 3 4 5 6 7 8 9 10 11 12 13
N di 1:   1                 2  34 5  6

Possiamo scrivere i numeri 1,2,...,12 premendo il tasto "1" per 5 volte.
Non possiamo scrivere 13 perchè premeremmo "1" per la sesta volta.

(define (num-1 num)
  (length (find-all "1" (join (map string (sequence 1 num))))))

(map list (sequence 1 50) (map num-1 (sequence 1 50)))
;-> ((1 1) (2 1) (3 1) (4 1) (5 1) (6 1) (7 1) (8 1) (9 1) (10 2) (11 4)
;->  (12 5) (13 6) (14 7) (15 8) (16 9) (17 10) (18 11) (19 12) (20 12)
;->  (21 13) (22 13) (23 13) (24 13) (25 13) (26 13) (27 13) (28 13) (29 13)
;->  (30 13) (31 14) (32 14) (33 14) (34 14) (35 14) (36 14) (37 14) (38 14)
;->  (39 14) (40 14) (41 15) (42 15) (43 15) (44 15) (45 15) (46 15) (47 15)
;->  (48 15) (49 15) (50 15))

(13 6) significa che nella sequenza 1..13 il numero "1" compare 6 volte.

(test 13)

(elenco 30)

Algoritmo
Per ogni numero in successione partendo da 1,
  inserire ogni cifra del numero nella lista lunga 10 (0..9)
  se la lista ha qualunque valore superiore a num, allora la sequenza ha superato il limite delle cifre prestabilito

(define (test n)
  ; lista delle occorrenze delle cifre
  (setq digit (dup 0 10))
  (setq stop nil)
  (setq k 1)
  (until stop
    ; ciclo sulle cifre del numero-stringa
    ; per aggiornare le occorrenze
    (dostring (c (string k))
      (++ (digit (- c 48)))
    )
    ; controllo numero occorrenze
    (if (find (+ n 1) digit <=)
        (setq stop true)
        ;else
        (++ k)
    )
  )
  (-- k))

(test 1)
;-> 9
(test 2)
;-> 10
(test 5)
;-> 12

(map test (sequence 1 22))
;-> (9 10 10 11 12 13 14 15 16 17 18 20 30 40 50 60 70 80 90 99 100 100)

(time (println (test 1e6)))
;-> 1199999
;-> 1806.034

Funzione simile alla precedente:

(define (test1 n)
(let ( (digit (dup 0 10)) (k 1) )
  (until (find (+ n 1) digit <=)
    ;(print k { })
    (dostring (c (string k))
      (++ (digit (- c 48)))
    )
    (++ k)
  )
  (- k 2)))

(test1 1)
;-> 9
(test1 2)
;-> 10
(test1 5)
;-> 12

(map test1 (sequence 1 22))
;-> (9 10 10 11 12 13 14 15 16 17 18 20 30 40 50 60 70 80 90 99 100 100)

(time (println (test1 1e6)))
;-> 1199999
;-> 1792.705

(= (map test (sequence 1 101)) (map test1 (sequence 1 101)))
;-> true

Funzione simile alla precedente, ma attravera il numero dividendolo:

(define (test2 n)
  (let ( (digit (dup 0 10)) (k 1) (tmp 0))
    (until (find (+ n 1) digit <=)
      ;(print k { })
      (setq tmp k)
      (until (zero? tmp)
        (++ (digit (% tmp 10)))
        (setq tmp (/ tmp 10))
      )
      (++ k)
    )
    (- k 2)))

(test2 1)
;-> 9
(test2 2)
;-> 10
(test2 5)
;-> 12

(map test2 (sequence 1 22))
;-> (9 10 10 11 12 13 14 15 16 17 18 20 30 40 50 60 70 80 90 99 100 100)

(time (println (test2 1e6)))
;-> 1199999
;-> 1780.264

(= (map test (sequence 1 101)) (map test1 (sequence 1 101))
   (map test2 (sequence 1 101)))
;-> true

Analizziamo quali numeri superano il limite e con quante occorrenze:

(define (demo n)
  (let ( (digit (dup 0 10)) (k 1) (tmp 0))
    (until (find (+ n 1) digit <=)
      ;(print k { })
      (setq tmp k)
      (until (zero? tmp)
        (++ (digit (% tmp 10)))
        (setq tmp (/ tmp 10))
      )
      (++ k)
    )
    (dolist (d digit) (println $idx " : " d))
    (- k 2)))

(demo 1)
;-> 0 : 1
;-> 1 : 2
;-> 2 : 1
;-> 3 : 1
;-> 4 : 1
;-> 5 : 1
;-> 6 : 1
;-> 7 : 1
;-> 8 : 1
;-> 9 : 1
;-> 9
(demo 100)
;-> 0 : 26
;-> 1 : 101
;-> 2 : 37
;-> 3 : 37
;-> 4 : 36
;-> 5 : 36
;-> 6 : 30
;-> 7 : 26
;-> 8 : 26
;-> 9 : 26
;-> 162
(demo 1000)
;-> 0 : 391
;-> 1 : 1001
;-> 2 : 500
;-> 3 : 500
;-> 4 : 500
;-> 5 : 401
;-> 6 : 400
;-> 7 : 400
;-> 8 : 400
;-> 9 : 400
;-> 1499

Notiamo che è sempre la cifra "1" che supera il limite impostato.

(define (num-1 num)
  (length (find-all "1" (join (map string (sequence 1 num))))))

(map list (sequence 1 50) (map num-1 (sequence 1 50)))
;-> ((1 1) (2 1) (3 1) (4 1) (5 1) (6 1) (7 1) (8 1) (9 1) (10 2) (11 4)
;->  (12 5) (13 6) (14 7) (15 8) (16 9) (17 10) (18 11) (19 12) (20 12)
;->  (21 13) (22 13) (23 13) (24 13) (25 13) (26 13) (27 13) (28 13) (29 13)
;->  (30 13) (31 14) (32 14) (33 14) (34 14) (35 14) (36 14) (37 14) (38 14)
;->  (39 14) (40 14) (41 15) (42 15) (43 15) (44 15) (45 15) (46 15) (47 15)
;->  (48 15) (49 15) (50 15))

Esempio:
(13 6) significa che nella sequenza 1..13 il numero "1" compare 6 volte.

Scriviamo una funzione che controlla solo il numero di "1".

(define (test3 n)
  (let ( (uno 0) (k 1) (tmp 0) )
    (until (> uno n)
      ;(print k { })
      (setq tmp k)
      (until (zero? tmp)
        (if (= (% tmp 10) 1) (++ uno))
        (setq tmp (/ tmp 10))
      )
      (++ k)
    )
    (-- k 2)))

(test3 1)
;-> 9
(test3 2)
;-> 10
(test3 5)
;-> 12

(map test3 (sequence 1 22))
;-> (9 10 10 11 12 13 14 15 16 17 18 20 30 40 50 60 70 80 90 99 100 100)

(time (println (test3 1e6)))
;-> 1199999
;-> 968.746

(= (map test (sequence 1 101)) (map test1 (sequence 1 101))
   (map test2 (sequence 1 101)) (map test3 (sequence 1 101)))
;-> true


-----------------------------
Funzione "exists" e "for-all"
-----------------------------

*******************
>>>funzione EXISTS
*******************
sintassi: (exists func-condition list)

Successivamente applica "func-condition" agli elementi di list e restituisce il primo elemento che soddisfa la condizione in "func-condition". Se nessun elemento soddisfa la condizione, viene restituito nil.

(exists string? '(2 3 4 6 "hello" 7))
;-> "hello"

(exists string? '(3 4 2 -7 3 0))
;-> nil

(exists zero? '(3 4 2 -7 3 0))
;-> 0 ; check for 0 or 0.0

(exists < '(3 4 2 -7 3 0))
;-> -7 ; check for negative

(exists (fn (x) (> x 3)) '(3 4 2 -7 3 0))
;-> 4

(exists (fn (x) (= x 10)) '(3 4 2 -7 3 0))  → nil

Se "func-condition" è "nil?", il risultato nil è ambiguo. In questo caso "index" o "find" sono il metodo migliore quando si cerca nil.

Utilizzare la funzione "for-all" per verificare se una condizione è soddisfatta per tutti gli elementi in un elenco.

********************
>>>funzione FOR-ALL
********************
sintassi: (for-all func-condition list)

Applica la funzione in "func-condition" a tutti gli elementi in list. Se tutti gli elementi soddisfano la condizione in "func-condition", il risultato è true, in caso contrario, viene restituito nil.

(for-all number? '(2 3 4 6 7))
;-> true

(for-all number? '(2 3 4 6 "hello" 7))
;-> nil

(for-all (fn (x) (= x 10)) '(10 10 10 10 10))
;-> true

Utilizzare la funzione "exists" per verificare se almeno un elemento in un elenco soddisfa una condizione.

Vediamo alcuni esempi:

(exists integer? '())
;-> nil
(exists integer? '(a b 3 t 7))
;-> 3
(for-all integer? '(a b 3 t 7))
;-> nil


(for-all integer? '())
;-> true
(for-all float? '())
;-> true

Il risultato delle ultime due espressioni lascia un pò perplessi.
Comunque è corretto dal punto di vista matematico, infatti il rapporto tra la quantificazione esistenziale e universale è abbastanza chiaro:

(not (for-all integer? L)) è equivalente a (exists (fn(x) (not (integer? x))) L)

e viceversa

(not (exists integer? L)) è equivalente a (for-all (fn(x) (not integer? x))) L)

Quindi, una volta deciso che (exists) su una lista vuota restituisce nil (il che ha senso), (for-all) per una lista vuota deve restituire true.


----------------------------
Scheme style e newLISP style
----------------------------

Jeff:
-----
Returns the first item that satisfies a predicate. 
Unlike find and ref, this returns the entire element, rather than its index.

(define (first-that lambda-p lst)
  "Returns first item in list that satisfies lambda-p."
  (if (lambda-p (first lst))
    (first lst)
    (first-that lambda-p (rest lst))))

(first-that integer? '(a r 4 t 2))
;-> 4

Nota: questa funzione è analoga alla funzione integrata "exists".

Lutz:
-----
Beyond the fact that the built-in 'exists' does the same functionality, I wanted to make some other comments about this code:

(define (first-that lambda-p lst)
  "Returns first item in list that satisfies lambda-p."
  (if (lambda-p (first lst))
    (first lst)
    (first-that lambda-p (rest lst))))

This is the kind of algorithm people use who have learned Scheme or have been teached other older LISP dialects favouring recursion and trying to avoid iteration.

The principle used here is iterating through a list by applying an operation to the first element and then recursing the function with the rest of the list.

newLISP has many built-in function to make this type of problem easier to code and much faster in execution:

(define (first-that lambda-p lst)
   (first (filter lambda-p lst)))

or to retrieve all for that lambda-p is not true:

(define (first-that-not lambda-p lst)
   (first (clean lambda-p lst)))

ps: this is not to criticize Jeff's code but to point out differences between programming in newLISP versus what is normally teached when learning Lisp ;-)

Jeff:
-----
Good point, Lutz. I do tend toward recursion and older lispy techniques. 
And we should always try the existing solution first before writing our own.

I did not use filter because (filter lambda-p lst) first expands by applying lambda-p to each item in lst. 
My solution short-circuits when it hits the first non-nil evaluation.

I did not imagine that filter would be faster since it is applying a lambda as well and does not short-circuit. Is there a fault in that logic?

ps: I of course don't take offense Lutz. Code doesn't get better if it doesn't get comments :)

rickyboy:
---------
Jeff,
Love the recursion! ;-) It's missing the base case, but looks beautiful anyway.

Lutz,
Your version, of course, doesn't need a base case, but Jeff is right about the short-circuiting logic. 
If he rewrote his short-circuiting version iteratively, it would probably be the most efficient lambda implementation. 
Your version would be pretty much be the most efficient way to implement it, if newLISP's evaluator was non-eager, then filter would only need to return its output's head to first, and not bother to process the rest of its input -- like UNIX pipelines, naturally short-circuiting!

Jeff:
-----
Rickyboy,
The base case is nil because it is technically a predicate. 
If nothing in the list evaluates as t, it should simply not return any elements - an empty list.

rickyboy:
---------
Here's why the base case (which checks for the end of list) is needed:

(rest '())
;-> ()
(first '())
;-> nil

So, something like (first-that string? '(a-symbol 42)) will cause a stack overflow.

Jeff:
-----
Ah, I assumed that it would return nil. 
I wasn't thinking and got sloppy :). I should have done:

(if (rest lst) (first-that lambda-p (rest lst)) nil)

or something on the last line there.


--------------------
Funzioni statistiche
--------------------

Nell'ambito della statistica, della simulazione e della modellistica, newLISP ha le seguenti funzione integrate:

amb           randomly selects an argument and evaluates it
bayes-query   calculates Bayesian probabilities for a data set
bayes-train   counts items in lists for Bayesian or frequency analysis
corr          calculates the product-moment correlation coefficient
crit-chi2     calculates the Chi^2 statistic for a given probability
crit-f        calculates the F statistic for a given probability
crit-t        calculates the Student's t statistic for a given probability
crit-z        calculates the normal distributed Z for a given probability
kmeans-query  calculates distances to cluster centroids or other data points
kmeans-train  partitions a data set into clusters
normal        makes a list of normal distributed floating point numbers
prob-chi2     calculates the tail probability of a Chi^2 distribution value
prob-f        calculates the tail probability of a F distribution value
prob-t        calculates the tail probability of a Student t distribution value
prob-z        calculates the cumulated probability of a Z distribution value
rand          generates random numbers in a range
random        generates a list of evenly distributed floats
randomize     shuffles all of the elements in a list
seed          seeds the internal random number generator
stats         calculates some basic statistics for a data vector
t-test        compares means of data samples using the Student's t statistic

Inoltre c'è un modulo di statistiche "stat.lsp" nella cartella "modules" dove è installato newLISP.
La documentazione si trova al seguente indirizzo:

http://newlisp.org/code/modules/stat.lsp.html

Per utilizzare questo modulo deve essere prima caricarlo:

(load (append (env "NEWLISPDIR") "/modules/stat.lsp"))
; oppure
(module "stat.lsp")

Tutte le funzioni funzionano su numeri interi e float o su una combinazione di entrambi.
Le liste sono normali liste LISP. Le matrici sono liste di liste, una lista per ogni riga nella matrice dati bidimensionale.
Vedere la funzione stat:matrix su come creare matrici da liste.

Esempio:
(module "stat.lsp")
(set 'lst '(4 5 2 3 7 6 8 9 4 5 6 9 2))
(stat:sdev lst)
;-> 2.39925202

Elenco delle funzioni del modulo "stats.lsp":
---------------------

General uni-variate and bi-variate statistics
---------------------------------------------
  stat:sum         - sum of a vector of numbers
                     (see also built-in stats since 10.4.2)
  stat:mean        - arithmetic mean of a vector of numbers
                     (see also built-in stats since 10.4.2)
  stat:var         - estimated variance of numbers in a vector sample
  stat:sdev        - estimated standard deviation of numbers in a vector
                     (see also built-in stats since 10.4.2)
  stat:sum-sq      - sum of squares of a data vector
  stat:sum-xy      - sum of products of a two data vectors
  stat:corr        - correlation coefficient between two vectors
                     (see also corr built-in since 10.4.2)
  stat:cov         - covariance of two number vectors
  stat:sum-d2      - sum of squared differences of a vector from its mean
  stat:sum-d2xy    - sum of squared differences of two vectors
  stat:regression  - calculates the intecept and slope of a regression estimate
  stat:fit         - return the fitted line using regression coefficients
  stat:moments     - calculates 1st to 3rd moments from a vector of numbers

Multi variate statistics
------------------------
  stat:multiple-reg  - calculates a multiple regression
  stat:cov-matrix    - calculates a covariance matrix
  stat:corr-matrix   - calculates a correlation matrix

Time series
-----------
  stat:smooth    - smoothes a vector of numbers
  stat:lag       - calculates a difference list with specified lag
  stat:cumulate  - cumulate a data vector
  stat:power     - calculates the power spectrum of a time series

Matrix and list utilities
-------------------------
  stat:matrix      - make a matrix from column vectors
  stat:diagonal    - make a diagonal matrix
  stat:get-diagonal - return the diagonal of a matrix in a vector
  stat:mat-map       - map a binary function on to matrices

Vedere anche:

  "Varianza e deviazione standard, (N-1) oppure N?" su "Note libere 10"
  "Medie statistiche" su "Note libere 10"
  "I cinque numeri di Tukey (Tukey's fivenum)" su "Note libere 10"
  "Quantili, quartili, percentili" su "Note libere 13"
  "Box-plot e valori anomali (outlier)" su "Note libere 13"
  "Statistica: Skewness e Kurtosis" su "Note libere 13"

Funzioni per il calcolo dei due tipi di deviazione standard:

1) Deviazione Standard con (N-1):

(define (sdev lst) 
(sqrt (div (sub (apply add (map mul lst lst))
                (div (mul (apply add lst) (apply add lst)) (length lst)))
           (sub (length lst) 1))))

2) Deviazione Standard con N:

(define (stdev lst) 
(sqrt (div (sub (apply add (map mul lst lst)) 
                (div (mul (apply add lst) (apply add lst)) (length lst)))
           (length lst))))

=============================================================================

