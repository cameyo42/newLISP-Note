===============

 NOTE LIBERE 5

===============

  Il alcuni giochi l'unica mossa vincente è quella di non giocare.

-------------------
Spostamento di zeri
-------------------

Data una lista di numeri interi, scrivere una funzione che sposta gli tutti gli zeri all'inizio o alla fine della lista. L'ordine degli elementi diversi da 0 deve rimanere lo stesso. Per esempio:

Input:
lista = (1 0 5 -4 0 3 0 4 -2 -1)

Output:
zeri all'inizio = (0 0 0 1 5 -4 3 4 -2 -1)
zeri alla fine  = (1 5 -4 3 4 -2 -1 0 0 0)

Un metodo per risolvere il problema è il seguente (zeri alla fine):
1) Per ogni elemento:
  se il numero corrente è diverso da zero,
  allora mettere il numero nella posizione disponibile nella lista.
2) Riempire tutti gli indici rimanenti con 0.

La seguente funzione utilizza questo metodo:

(define (move0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (for (i 0 (- len 1))
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= (lst i) 0)
        (begin
          (setf (lst idx) (lst i))
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(move0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Per scrivere la funzione che mette gli zeri all'inizio è sufficiente cominciare il ciclo "for" dalla fine della lista e modificare l'inserimento di zeri al termine del ciclo.

La seguente funzione utilizza "dolist" invece del ciclo "for":

(define (move-0 lst)
  ; "idx" memorizza l'indice della posizione disponibile
  (let ((idx 0) (len (length lst)))
    (dolist (el lst)
      ; se il numero corrente è diverso da zero,
      ; allora mette il numero nella posizione libera
      (if (!= el 0)
        (begin
          (setf (lst idx) el)
          ; aggiorna posizione libera
          (++ idx)
        )
      )
    )
    ; sposta gli zeri (0) in fondo alla lista (gli indici rimanenti)
    (for (i idx (- len 1))
      (setf (lst i) 0)
    )
    lst))

(move-0 a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Adesso scriviamo una funzione che risolve lo stesso problema utilizzando le funzioni primitive "clean" e "filter":

(define (move-zero lst pos)
  (cond ((= pos 1) ; 1 ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))
        ((= pos 0) ; 0 ==> zeri all'inizio
         (append (filter zero? lst) (clean zero? lst)))
        (true ; default ==> zeri alla fine
         (append (clean zero? lst) (filter zero? lst)))))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
; zeri all'inizio (pos = 0)
(move-zero a 0)
;-> (0 0 0 1 5 -4 3 4 -2 -1)
; zeri alla fine (pos = 1)
(move-zero a 1)
;-> (1 5 -4 3 4 -2 -1 0 0 0)
; zeri alla fine (default)
(move-zero a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo i tempi di esecuzione delle tre funzioni:

(setq nums (rand 10 1000))
(time (move0 nums) 1000)
;-> 1552.321
(time (move-0 nums) 1000)
;-> 604.397
(time (move-zero nums) 1000)
;-> 103.849

(silent (setq nums (rand 10 10000)))
(time (move0 nums) 1000)
;-> 219458.513 ; ciclo "for" molto lento con liste con numero elementi > 1000
(time (move-0 nums) 1000)
;-> 74461.084  ; ciclo "dolist" più veloce sulle liste
(time (move-zero nums) 1000)
;-> 1042.734   ; le primitive newLISP vincono nettamente

Per velocizzare il calcolo le funzioni "move0" e "move-0" possono utilizzare anche dei vettori:

(silent (setq vec (array (length nums) nums)))
(time (move0 vec) 1000)
;-> 1368.295 ; ciclo "for" veloce con vettori
(time (move-0 vec) 1000)
;-> 1225.153 ; ciclo "dolist" veloce anche con vettori

Con l'uso dei vettori otteniamo quasi la stessa velocità della funzione "move-zero". Quindi, utilizzando i vettori i cicli "for" e "dolist" hanno velocità simili, mentre con le liste il ciclo "dolist" è molto più veloce del ciclo "for".

Un altro metodo per risolvere il problema è quello di utilizzare la logica del quicksort. L'idea è di usare 0 come elemento pivot e poi fare un ciclo per leggere tutti gli elementi e scambiare ogni elemento non pivot con la prima occorrenza del pivot.

La seguente funzione implementa questo metodo:

(define (zeri lst)
  (let (idx 0)
    ; se l'elemento è diverso da zero,
    ; allora l'elemento viene posizionato prima del pivot
    ; e "idx" viene incrementato
    (for (i 0 (- (length lst) 1))
      (if (!= (lst i) 0) ; 0 è il pivot
        (begin
          (swap (lst i) (lst idx))
          (++ idx)
        )
      )
    )
    lst))

(setq a '(1 0 5 -4 0 3 0 4 -2 -1))
(zeri a)
;-> (1 5 -4 3 4 -2 -1 0 0 0)

Vediamo la velocità di questa ultima funzione utilizzando un vettore:

(time (zeri vec) 1000)
;-> 1280.851


-----------------------
Quadratura approssimata
-----------------------

La funzione f(x) = x * ceil(x) viene chiamata "quadratura approssimata" ed è studiata nell'articolo "Approximate Squaring" di Lagarias e Sloane.
Consideriamo la frazione x = n/d quando n > d > 1. Prendiamo 8/7 come esempio e cominciamo a calcolare la funzione:

1) f(8/7) = 8/7 * (ceil 8/7) = 8/7 * 2 = 16/7, adesso applichiamo di nuovo la funzione:

2) f(16/7) = 16/7 * (ceil 16/7) = 16/7 * 3 = 48/7, adesso applichiamo di nuovo la funzione:

3) f(48/7) = 48/7 * (ceil 48/7) = 48/7 * 7 = 48 , adesso abbiamo raggiunto un numero intero e il ciclo è finito.

Il numero di passaggi dipende dalla frazioni iniziale e il suo comportamento è abbastanza caotico. Per esempio, con 6/5 si arriva in 18 passi ad un numero di 57735 cifre prima di raggiungere un numero intero, con 200/199 si arriva ad un numero di 10^435 cifre. È congetturato, ma non dimostrato, che iterando la quadratura approssimata si ottenga sempre un numero intero.
La seguente tabella mostra alcune frazioni di esempio con i relativi risultati:

  Frazione  Passi  Numero
  --------  -----  ------
  3/2       1      3
  5/2       2      60
  7/2       1      14
  9/2       3      268065
  11/2      1      33
  13/2      2      2093
  15/2      1      60
  17/2      4      1204154941925628
  19/2      1      95

Scrivere un programma che calcola il numero di passaggi per raggiungere un numero intero partendo da una frazione x = n/d con n > d > 1.

La funzione che calcola la squadratura approssimata è la seguente:

(define (approx n d)
  (div (* n (ceil (div n d))) d))

Purtroppo le funzioni "div" e "ceil" non possono essere utilizzate con i big-integer, allora simuliamo la funzione "ceil" nel modo seguente:
  se (% n d) = 0, allora (ceil (div n d)) = (/ n d)
              altrimenti (ceil (div n d)) = (+ (/ n d) 1)

Scriviamo la funzione:

(define (itera n d)
  (let (passi 0L)
    ; fintanto che n/d non è un numero intero...
    (do-until (zero? (% n d))
      (++ passi)
      ; calcola il nuovo numeratore
      (if (zero? (% n d))
        ;(setq n (* n (int (ceil (div n d)))))
        (setq n (* n (/ n d)))
        (setq n (* n (+ 1L (/ n d))))
      ))
    (list passi (/ n d))))

(itera 8L 7L)
;-> (3L 48L)
(itera 3 2)
;-> (1L 3)
(itera 9 2)
;-> (3L 268065)
(itera 17L 2L)
;-> (4L 1204154941925628L)
(itera 10L 6L)
;-> (6L 1484710602474311520L)

Vediamo il numero da 57735 cifre:

(length (last (itera 6L 5L)))
;-> 57735

La seguente espressione "crasha" newLISP...perchè  un numero di 10^435 cifre dove lo mette?

(length (last (itera 200L 199L)))
;->  puff


-----------------------------------------
Introduzione alla programmazione dinamica
-----------------------------------------

"Dynamic Programming is not about filling in tables, but writing smart recursions." – Jeff Erickson.

La programmazione dinamica è un metodo per risolvere un problema complesso scomponendolo in un insieme di sottoproblemi più semplici, e poi risolvendo ciascuno di questi sottoproblemi una sola volta e memorizzando le loro soluzioni in una utilizzando una struttura di dati (lista, vettore, hash, ecc.). Ogni soluzione del sottoproblema è indicizzata in qualche modo, in genere in base ai valori dei parametri di input, per facilitarne la ricerca. Quindi, la prossima volta che si verifica lo stesso sottoproblema, invece di ricalcolare la sua soluzione, si utilizza la soluzione calcolata in precedenza, risparmiando così tempo di calcolo. Questa tecnica di memorizzazione delle soluzioni ai sottoproblemi invece di ricalcolarli è chiamata memoizzazione.

Ecco una brillante metafora per spiegare ad un principiante il concetto alla base della programmazione dinamica:

https://www.quora.com/How-should-I-explain-dynamic-programming-to-a-4-year-old/answer/Jonathan-Paulson

  *writes down "1+1+1+1+1+1+1+1 =" on a sheet of paper*
  "What's that equal to?"
  *counting* "Eight!"
  *writes down another "1+" on the left*
  "What about that?"
  *quickly* "Nine!"
  "How'd you know it was nine so fast?"
  "You just added one more."
  "So you didn't need to recount because you remembered there were eight! Dynamic Programming is just a fancy way to say 'remembering stuff to save time later'"

Ci sono due attributi chiave che un problema deve avere affinché la programmazione dinamica sia applicabile: una sottostruttura ottimale e sovrapposizione dei sottoproblemi.

1. Sottostruttura ottimale
La programmazione dinamica semplifica un problema complicato suddividendolo in sottoproblemi più semplici in modo ricorsivo. Un problema che può essere risolto in modo ottimale suddividendolo in sottoproblemi e quindi trovando ricorsivamente le soluzioni ottimali dei sottoproblemi si dice che abbia una sottostruttura ottimale. In altre parole, la soluzione di un dato problema di ottimizzazione può essere ottenuta dalla combinazione delle soluzioni ottime dei suoi sottoproblemi (le soluzioni dei sottoproblemi sono indipendenti tra di loro).

Ad esempio, il cammino minimo p da un vertice u a un vertice v in un dato grafo mostra una sottostruttura ottimale: prendiamo qualsiasi vertice intermedio w su questo cammino minimo p. Se p è veramente il cammino minimo, allora può essere suddiviso in sottopercorsi p1 da u a w e p2 da w a v tali che questi, a loro volta, siano effettivamente i cammini più brevi tra i vertici corrispondenti.

2. Sovrapposizione dei sottoproblemi
Si dice che un problema ha sottoproblemi sovrapposti se il problema può essere suddiviso in sottoproblemi e ogni sottoproblema viene ripetuto più volte, o un algoritmo ricorsivo per il problema risolve ripetutamente lo stesso sottoproblema invece di generare sempre nuovi sottoproblemi.

Ad esempio, il problema del calcolo della sequenza di Fibonacci mostra sottoproblemi sovrapposti. Il problema del calcolo dell'n-esimo numero di Fibonacci F(n) può essere scomposto nei sottoproblemi del calcolo di F(n-1) e F(n-2) e quindi sommando i due. Il sottoproblema del calcolo di F(n-1) può essere esso stesso scomposto in un sottoproblema che coinvolge il calcolo di F(n-2). Pertanto, il calcolo di F(n-2) viene riutilizzato e la sequenza di Fibonacci mostra quindi sottoproblemi sovrapposti. La programmazione dinamica tiene conto di questo fatto e risolve ogni sottoproblema una sola volta. Ciò può essere ottenuto in uno dei due modi seguenti:

Approccio top-down (dall'alto verso il basso) (Memoizzazione): questa è la ricaduta diretta della formulazione ricorsiva di qualsiasi problema. Se la soluzione a qualsiasi problema può essere formulata ricorsivamente utilizzando la soluzione ai suoi sottoproblemi e se i suoi sottoproblemi si sovrappongono, si può facilmente utilizzare la memoizzazione oppure memorizzare le soluzioni dei sottoproblemi in una tabella. Ogni volta che tentiamo di risolvere un nuovo sottoproblema, prima controlliamo la tabella per vedere se è già stato risolto. Se il sottoproblema è già risolto, usiamo direttamente la sua soluzione, altrimenti, risolviamo il sottoproblema e aggiungiamo la sua soluzione alla tabella.

Approccio bottom-up (dal basso verso l'alto) (Tabella): una volta che formuliamo la soluzione a un problema in modo ricorsivo in termini di sottoproblemi, possiamo provare a riformulare il problema in modo dal basso verso l'alto: proviamo a risolvere prima i sottoproblemi e usiamo le loro soluzioni per costruire verso l'alto e arrivare alle soluzioni dei sottoproblemi più grandi. Questo viene solitamente fatto anche in forma tabellare generando in modo iterativo soluzioni a sottoproblemi sempre più grandi utilizzando le soluzioni dei sottoproblemi più piccoli. Ad esempio, se conosciamo già i valori di F(i-1) e F(i-2), possiamo calcolare direttamente il valore di F(i).
Quando un problema può essere risolto combinando soluzioni ottimali con sottoproblemi non sovrapposti, allora la strategia si chiama "Divide et impera". Questo è il motivo per cui il MergeSort e il QuickSort non sono classificati come problemi di programmazione dinamica.

Consideriamo un'implementazione ricorsiva di una funzione che trova l'ennesimo numero della sequenza di Fibonacci:

(define (fib num)
  (if (<= num 1)
      num
      (+ (fib (- num 1)) (fib (- num 2)))))

(fib 5)
;-> 5

Quando chiamiamo (fib 5) (per esempio) produciamo un albero di chiamate che chiama la funzione sullo stesso valore molte volte:

                                   (fib 5)
                                   .     .
                                .           .
                             .                 .
                          .                       .
                       .                             .
                    (fib 4)                        (fib 3)
                  .        .                         .  .
                .            .                      .    .
              .                .                   .      .
          (fib 3)            (fib 2)            (fib 2) (fib 1)
            / \                / \                / \
           /   \              /   \              /   \
          /     \            /     \            /     \
      (fib 2) (fib 1)    (fib 1) (fib 0)    (fib 1) (fib 0)
        / \
       /   \
      /     \
  (fib 1) (fib 0)

In particolare, (fib 3) è stato calcolato due volte e (fib 2) è stato calcolato tre volte. Con numeri più grandi vengono ricalcolati molti più sottoproblemi, portando questo algoritmo ad una complessità temporale esponenziale.

Ora supponiamo di avere una struttura per memorizzare i risultati intermedi di fib e modifichiamo la nostra funzione per usarlo e aggiornarlo. La funzione risultante viene eseguita in tempo O(n) anziché in tempo esponenziale (ma richiede uno spazio O(n)).

Di seguito è riportata l'implementazione basata su questo metodo:

; lista associativa per memorizzare i risultati parziali
(setq memo '())

(define (fib-memo num)
  (local (val)
    (cond ((<= num 1)
            num)
          ; se il numero di Fibonacci relativo a num non è stato calcolato
          ((nil? (lookup num memo))
            ; allora lo calcola...
            (setq val (+ (fib-memo (- num 1)) (fib-memo (- num 2))))
            ; e poi mette il risultato
            ; (num fib(num)) nella lista associativa memo
            (push (list num val) memo -1)))
    (lookup num memo)))

(fib-memo 5)
;-> 5

Da notare che avremmo potuto usare un'altra struttura dati per memorizzare i valori invece di una lista associativa (vettore, hash-map, ecc.).

Questa tecnica di memorizzazione dei valori già calcolati è chiamata memoizzazione e questo è l'approccio top-down poiché prima suddividiamo il problema in sottoproblemi e poi calcoliamo e memorizziamo i valori.

Nell'approccio bottom-up, calcoliamo prima i valori più piccoli di fib, quindi costruiamo da essi valori più grandi. Anche questo metodo utilizza un tempo O(n) poiché contiene un ciclo che si ripete n-1 volte, ma richiede solo uno spazio costante O(1) costante, in contrasto con l'approccio top-down, che richiede spazio O(n) per memorizzare tutti i risultati. In questo caso la tabella di memorizzazione è costituita solo da tre valori: il valore corrente di fib, il valore precedente e il valore successivo.

Di seguito è riportato il programma che utilizza questo metodo (tabella):

(define (fib-tab num)
  (local (new-fib prev-fib curr-fib)
    (cond ((<= num 1) num)
          (true
           (setq prev-fib 0)
           (setq curr-fib 1)
           (for (i 1 (- num 1))
              (setq new-fib (+ prev-fib curr-fib))
              (setq prev-fib curr-fib)
              (setq curr-fib new-fib))))
    curr-fib))

(fib-tab 5)
;-> 5

In entrambe le ultime due funzioni, la chiamata a (fib 5) calcola (fib 2) solo una volta e poi il valore viene usato per calcolare sia (fib 4) che (fib 3), invece di essere ricalcolato nuovamente ogni volta che deve essere valutato.


--------------------------------------------------------------------
Programmazione dinamica: il gioco delle pentole d'oro (pots of gold)
--------------------------------------------------------------------

Ci sono due giocatori, A e B, e delle pentole disposte in fila ciascuna contenente alcune monete d'oro. I giocatori possono vedere quante monete ci sono in ogni pentola. A turni alternati ogni giocatore può scegliere una pentola da una delle estremità della linea. Alla fine il vincitore è il giocatore che ha un numero maggiore di monete. Per esempio, la seguente lista rappresenta una linea di 8 pentole ognuna contenente un numero di monete (valore dell'elemento):

(setq pentole '(3 4 1 6 7 4 8 9))

L'obiettivo del nostro problema è "massimizzare" il numero di monete raccolte da A, supponendo che B giochi "in modo ottimale" e che A inizi il gioco.

Vediamo un paio di esempi:

Pentole              A    B
4, 6, 2, 3           3
4, 6, 2                   4
6, 2                 6
2                         2
                    --------
totale monete        9    6

Pentole              A    B
6, 1, 4, 9, 8, 5     6
1, 4, 9, 8, 5             5
1, 4, 9, 8           8
1, 4, 9                   9
1, 4                 4
1                         1
                    --------
totale monete       18   15

L'idea è quella di trovare una strategia ottimale che faccia vincere il giocatore A, sapendo che l'avversario sta giocando in modo ottimale. Il giocatore ha due scelte per coin[i..j], dove i e j indicano rispettivamente la parte anteriore e quella posteriore della linea di pentole.

1. Se il giocatore sceglie la pentola anteriore i, l'avversario può scegliere tra [i+1, j].
       Se l'avversario sceglie la pentola anteriore i+1, ricorsione per [i+2, j].
       Se l'avversario sceglie la pentola posteriore j, ricorsione per [i+1, j-1].

2. Se il giocatore sceglie la pentola posteriore j, l'avversario può scegliere tra [i, j-1].
       Se l'avversario sceglie la pentola anteriore i, ricorsione per [i+1, j-1].
       Se l'avversario sceglie la pentola posteriore j-1, ricorsione per [i, j-2].

Poiché l'avversario sta giocando in modo ottimale, cercherà di ridurre al minimo i punti del giocatore, cioè l'avversario farà una scelta che lascerà al giocatore il minimo di monete. Quindi, possiamo definire ricorsivamente il problema nel modo seguente:

                 | coin[i]                            (se i = j)
 optimal(i, j) = | max(coin[i], coin[j])              (se i + 1 = j)
                 | max(coin[i] + min(optimal(coin, i + 2, j),
                           optimal(coin, i + 1, j – 1)),
                           coin[j] + min(optimal(coin, i + 1, j – 1),
                           optimal(coin, i, j – 2)))

Quindi la funzione che implementa la strategia ottimale è la seguente:

(define (optimal pentole i j)
  ; caso base: una pentola rimasta, solo una scelta possibile
  (cond ((= i j)
        (pentole i))
        ; se rimangono solo due pentole,
        ; scegliere quella con il massimo numero di monete
        ((= (+ i 1) j)
          (max (pentole i) (pentole j)))
        (true
          (local (inizio fine)
          ; Se il giocatore sceglie la pentola anteriore i,
          ; l'avversario può scegliere tra [i+1, j].
          ; 1. Se l'avversario sceglie la pentola anteriore i+1,
          ;    ricorsione per [i+2, j].
          ; 2. Se l'avversario sceglie la pentola posteriore j,
          ;    ricorsione per [i+1, j-1].
          (setq inizio (+ (pentole i) (min (optimal pentole (+ i 2) j)
                                           (optimal pentole (+ i 1) (- j 1)))))
          ; Se il giocatore sceglie la pentola posteriore j,
          ; l'avversario può scegliere tra [i, j-1].
          ; 1. Se l'avversario sceglie la pentola anteriore i,
          ;    ricorsione per [i+1, j-1].
          ; 2. Se l'avversario sceglie la pentola posteriore j-1,
          ;  ricorsione per [i, j-2].
          (setq fine (+ (pentole j) (min (optimal pentole (+ i 1) (- j 1))
                                         (optimal pentole i (- j 2)))))
          (max inizio fine)))))

Funzione main:

(define (pots-gold pots)
  (local (i j)
    (setq i 0)
    (setq j (- (length pots) 1))
    (optimal pots i j)))

(pots-gold '(4 6 2 3))
;-> 9
(pots-gold '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold pentole)
;-> 23

La complessità temporale della soluzione di cui sopra è esponenziale e occupa spazio nello stack di chiamate.

Il problema ha una sottostruttura ottimale, quindi può essere suddiviso in sottoproblemi più piccoli, che possono essere ulteriormente suddivisi in sottoproblemi ancora più piccoli e così via. Il problema mostra anche sottoproblemi sovrapposti, quindi finiremo per risolvere lo stesso sottoproblema più e più volte. Abbiamo visto che i problemi con sottostruttura ottimale e sottoproblemi sovrapposti possono essere risolti mediante la programmazione dinamica, in cui le soluzioni dei sottoproblemi vengono memorizzate piuttosto che calcolate di nuovo.

Vediamo la versione top-down:

(define (optimal-td pentole i j)
  (local (inizio fine)
  ; caso base: una pentola rimasta, solo una scelta possibile
  (cond ((= i j)
         (pentole i))
        ; se rimangono solo due pentole,
        ; scegliere quella con il massimo numero di monete
        ((= (+ i 1) j)
         (max (pentole i) (pentole j)))
        ; valore non calcolato?
        ((zero? (memo i j))
         (setq inizio (+ (pentole i) (min (optimal-td pentole (+ i 2) j)
                                          (optimal-td pentole (+ i 1) (- j 1)))))
         (setq fine (+ (pentole j) (min (optimal-td pentole (+ i 1) (- j 1))
                                        (optimal-td pentole i (- j 2)))))
         (setf (memo i j) (max inizio fine)))
         (true
          (memo i j)))))

(define (pots-gold-td pots)
  (local (memo i j)
    (setq memo (array (length pots) (length pots) '(0)))
    (setq i 0)
    (setq j (- (length pots) 1))
    (optimal-td pots i j)))

(pots-gold-td '(4 6 2 3))
;-> 9
(pots-gold-td '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold-td pentole)
;-> 23

La complessità temporale di questa soluzione è O(n^2) e richiede O(n^2) spazio extra, dove n è il numero totale di pentole.

Vediamo la versione bottom-up:

(define (calc T i j)
  (if (<= i j)
      (T i j)
      0))

(define (optimal-bu pentole)
  (local (len dp j inizio fine)
    (setq len (length pentole))
    (cond ((= len 1) (pentole 0))
          ((= len 2) (max (pentole 0) (pentole 1)))
          (true
           ; matrice 2D dinamica per memorizzare
           ; le soluzioni dei sottoproblemi
           (setq dp (array len len '(0)))
           (for (iter 0 (- len 1))
              (setq i 0)
              (for (j iter (- len 1))
                (setq inizio (+ (pentole i) (min (calc dp (+ i 2) j)
                                                 (calc dp (+ i 1) (- j 1)))))
                (setq fine (+ (pentole j) (min (calc dp (+ i 1) (- j 1))
                                              (calc dp i (- j 2)))))
                (setf (dp i j) (max inizio fine))
                (++ i)
              )
           )
           ;(println dp)
           (dp 0 (- len 1))))))

(define (pots-gold-bu pots)
    (optimal-bu pots))

(pots-gold-bu '(4 6 2 3))
;-> 9
(pots-gold-bu '(6 1 4 9 8 5))
;-> 18
(setq pentole '(3 4 1 6 7 4 8 9))
(pots-gold-bu pentole)
;-> 23

La complessità temporale di questa soluzione è O(n^2) e richiede O(n) spazio extra, dove n è il numero totale di pentole.

Nota: questo algoritmo non assicura che il giocatore A vinca sempre. La vittoria di A dipende dalla casualità della distribuzione delle pentole, questo algoritmo massimizza il valore che A può ottenere, ma non è detto che il valore di B sia inferiore. Per convincersi è sufficiente considerare la seguente distribuzione di pentole: (1 3 1). Qualunque scelta faccia A, il massimo che può ottenere è 2, mentre B può ottenere 3:

(pots-gold-bu '(1 3 1))
;-> 2

In altre parole, questo algoritmo trova il comportamento ottimale per il giocatore A, ma non è in grado di definire una strategia vincente.

Nota: per definire una strategia vincente (se la distribuzione iniziale lo consente) occorre usare un algoritmo che analizza l'intero albero delle possibili mosse (infatti è necessario ricorrere più in profondità per ottenere la soluzione ottimale anziché limitarsi a raggiungere il massimo alla mossa successiva).

Nota: per rendere più equo il gioco il numero di pentole dovrebbe essere pari, altrimenti il primo giocatore A sceglierebbe una pentola in più del giocatore B.

Comunque se il numero di pentole è dispari, allora il giocatore B è in grado di selezionare una determinata pentola.
Per esempio, nella distribuzione (1 2 6 2 101 6 8) il giocatore B sarà sempre in grado di scegliere la pentola con 101 monete (e vincere il gioco):
(pots-gold-bu '(1 2 6 2 101 6 8))
;-> 18

Invece se il numero di pentole è pari, allora il giocatore A è in grado di selezionare una determinata pentola.
Per esempio, nella distribuzione (1 2 6 2 101 6) il giocatore A sarà sempre in grado di scegliere la pentola con 101 monete (e vincere il gioco):
(pots-gold-bu '(1 2 6 2 101 6))
;-> 108

Per maggiori informazioni consultare l'articolo "An Optimal Algorithm for Calculating the Profit in the Coins in a Row Game" di Tomasz Idziaszek.

Quante partite diverse possono essere giocate con una fila di n pentole?

Una partita può essere considerata una sequenza di catture a Sinistra o a Destra della linea, cioè una partita con quattro pentole può essere rappresentata dalla lista (s s d d): A prende a Sinistra, B prende a Sinistra, A prende a destra e, infine, B prende a destra.
Comunque la lista (s s d d) è equivalente alla lista (s s d s), perchè l'ultima pentola si trova indifferentemente a Sinistra e a Destra.
Quindi il numero di partite è dato da tutte le permutazioni con ripetizione di s e d di lunghezza (n - 1):

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Queste sono tutte le possibili partite con una linea di 2 pentole (s=sinistra, d=destra)
(perm-rep 1 '(s d))
;-> ((s) (d))

Queste sono tutte le possibili partite con una linea di 4 pentole (s=sinistra, d=destra)
(perm-rep 3 '(s d))
;-> ((s s s) (d s s) (s d s) (d d s) (s s d) (d s d) (s d d) (d d d))

Queste sono tutte le possibili partite con una linea di 5 pentole (s=sinistra, d=destra)
(perm-rep 4 '(s d))
;-> ((s s s s) (d s s s) (s d s s) (d d s s) (s s d s) (d s d s) (s d d s)
;->  (d d d s) (s s s d) (d s s d) (s d s d) (d d s d) (s s d d) (d s d d)
;->  (s d d d) (d d d d))

Quindi la funzione che calcola il numero di partite con n pentole è la seguente:

(define (game-pots num)
  (length (perm-rep (- num 1) '(s d))))

Oppure più semplicemente,

  numero partite = elementi^scelte

dove "elementi" è il numero di cose tra cui scegliere (s e d), e ne scegliamo "scelte" (num-1), la ripetizione è consentita e l'ordine è importante.

(define (game-pots num)
  (pow 2 (- num 1)))

(game-pots 10)
;-> 512

Scriviamo una funzione che data una linea di pentole calcola il risultato di tutte le partite possibili:

(define (all-game lst)
  (local (len perm tmp val aa bb tot-a tot-b tot-ab)
    ;tot-a:  vittoria giocatore A
    ;tot-b:  vittoria giocatore B
    ;tot-ab: pareggio
    (setq tot-a 0 tot-b 0 tot-ab 0)
    (setq len (length lst))
    (setq perm (perm-rep (- len 1) '(s d)))
    ; per ogni permutazione
    (dolist (p perm)
      (setq tmp lst)
      (setq aa 0 bb 0)
      ; per ogni elemento di una permutazione (partita)
      (dolist (el p)
        ; calcola il valore preso (a sinistra o a destra)
        (if (= el 's)
          (setq val (pop tmp 0))
          (setq val (pop tmp -1))
        )
        ; aumenta il punteggio del relativo giocatore
        (if (even? $idx)
            (setq aa (+ aa val))
            (setq bb (+ bb val))
        )
      )
      ; assegna l'ultimo valore della lista
      ; ad uno dei due giocatori
      (if (odd? len)
          (setq aa (+ aa (last tmp)))
          (setq bb (+ bb (last tmp)))
      )
      ;(println lst { } p { } aa { } bb)
      ; aumenta numero vittorie al vincitore corrente
      (cond ((= aa bb) (++ tot-ab))
            ((> aa bb) (++ tot-a))
            (true (++ tot-b)))
    )
    (list tot-a tot-b tot-ab)
  )
)

(all-game '(1 2 3 4 5 6 7))
;-> (45 12 7)

(all-game '(1 3 1))
;-> (2 2 0)

(all-game '(3 9 5 7 1 6 4 8 1 9 8 7))
;-> (914 995 139)


---------------------------------------------
Somma delle cifre in posizioni pari e dispari
---------------------------------------------

Scrivere una funzione che calcola tutti i numeri fino ad un dato limite che hanno la seguente proprietà:

la somma delle cifre in posizione pari è uguale alla somma delle cifre in posizione dispari

L'indice comincia da 1 a sinistra del numero.

Prendiamo per esempio il numero 7523351:

somma delle cifre con indice dispari: 7 + 2 + 3 + 1 = 13
somma delle cifre con indice pari: 5 + 3 + 5 = 13

Quindi il numero 7523351 soddisfa la condizione.

Sequenza OEIS A135499: 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132,
 143, 154, 165, 176, 187, 198, 220, 231, 242, 253, 264, 275, 286, 297, 330,
 341, 352, 363, 374, 385, 396, 440, 451, 462, 473, 484, 495, 550, 561, 572,
 583, 594, 660, 671, 682, 693, 770, 781, 792, 880, 891, 990, ...

Funzione che verifica se un numero soddisfa la condizione:

(define (equal-sum? num)
  (if (zero? num) true
      (local (odd-sum even-sum len)
        (setq odd-sum 0 even-sum 0)
        (setq len (length num))
        (while (!= num 0)
          (if (odd? len)
              (setq odd-sum (+ odd-sum (% num 10)))
              (setq even-sum (+ even-sum (% num 10)))
          )
          (setq num (/ num 10))
          (-- len)
        )
        (= odd-sum even-sum))))

(equal-sum? 0)
;-> nil
(equal-sum? 7523351)
;-> true
(equal-sum? 11165)
;-> true
(equal-sum? 11111)
;-> nil

Funzione che calcola tutti i numeri che verificano la condizione fino ad un dato limite:

(define (equal-sum limite)
  (let (out '())
    (for (i 1 limite)
      (if (equal-sum? i)
          (push i out -1)))
    out))

(equal-sum 1e3)
;-> (11 22 33 44 55 66 77 88 99 110 121 132 143 154 165 176 187 198 220 231
;->  242 253 264 275 286 297 330 341 352 363 374 385 396 440 451 462 473 484
;->  495 550 561 572 583 594 660 671 682 693 770 781 792 880 891 990)

(time (println (length (filter equal-dp? (sequence 1 1e7)))))
;-> 436974
;-> 16958.25

(time (println (length (equal-sum 1e7))))
;-> 436974
;-> 16146.418

(time (println (length (equal-sum 1e8))))
;-> 4816029
;-> 177110.473 ; 2 minuti e 57 secondi

Vediamo se possiamo ottimizzare le funzioni:

(define (equal-dp? num)
  (let ((i 1) (sum-d 0) (sum-p 0))
    (while (!= num 0)
      (if (odd? i)
          (++ sum-d (% num 10))
          (++ sum-p (% num 10))
      )
      (setq num (/ num 10))
      (++ i)
    )
    ;(println sum-d { } sum-p)
    (= sum-d sum-p)))

(equal-dp? 0)
;-> true
(equal-dp? 7523351)
;-> true
(equal-dp? 122364)
;-> true
(equal-dp? 11111)
;-> nil

(filter equal-dp? (sequence 1 1e3))
;-> (11 22 33 44 55 66 77 88 99 110 121 132 143 154 165 176 187 198 220 231
;->  242 253 264 275 286 297 330 341 352 363 374 385 396 440 451 462 473 484
;->  495 550 561 572 583 594 660 671 682 693 770 781 792 880 891 990)

(define (equal limite)
  (let (out '())
    (for (i 1 limite)
      (if (equal-dp? i)
          (push i out -1)))
    out))

(equal 1e3)
;-> (11 22 33 44 55 66 77 88 99 110 121 132 143 154 165 176 187 198 220 231
;->  242 253 264 275 286 297 330 341 352 363 374 385 396 440 451 462 473 484
;->  495 550 561 572 583 594 660 671 682 693 770 781 792 880 891 990)

(time (println (length (filter equal-dp? (sequence 1 1e7)))))
;-> 436974
;-> 16854.807

(time (println (length (equal 1e7))))
;-> 436974
;-> 13590.867

(time (println (length (equal 1e8))))
;-> 4816029
;-> 151885.455 ; 2 minuti e 32 secondi


-------------------------------------
Ordinare una lista con un'altra lista
-------------------------------------

Supponiamo di avere una lista di numeri e una seconda lista di indici o di posizioni. Per esempio,

lista di numeri:
(setq nums '(3 5 2 8 6 4))

lista di posizioni:
(setq pos '(3 2 1 4 5 0))

lista di indici:
(setq idx '(3 2 1 4 5 0))

Primo problema
Ordinare la lista di numeri in accordo con la lista di posizioni. In questo caso l'elemento i-esimo della lista "nums" deve essere posizionato/spostato all'indice ord(i), cioè nums(i) = nums(ord(i)).

(define (order1 lst pos)
  (local (len out)
    (setq len (length lst))
    (setq out (array len '(0)))
    (for (i 0 (- len 1))
      (setf (out (pos i)) (lst i))
    )
    out))

(order1 '(1 2 3 4 5) '(3 2 4 1 0))
;-> (5 4 2 1 3)

(order1 nums pos)
;-> (4 2 5 3 8 6)

Secondo problema
Ordinare la lista di numeri in accordo agli indici della lista di indici. In questo caso l'elemento i-esimo della lista "idx" rappresenta l'indice del numero che va posizionato/spostato alla posizione i-esima, cioè nums(idx(i)) = nums(i)

(define (order2 lst idx)
  (local (len out)
    (setq len (length lst))
    (setq out (array len '(0)))
    (for (i 0 (- len 1))
      (setf (out i) (lst (idx i)))
    )
    out))

(order2 '(1 2 3 4 5) '(3 2 4 1 0))
;-> (4 3 5 2 1)

(order2 nums idx)
;-> (8 2 5 6 4 3)

Nota: newLISP ha la funzione primitiva "select" che produce lo stesso risultato di "order2":

(select '(1 2 3 4 5) '(3 2 4 1 0))
;-> (4 3 5 2 1)
(select nums idx)
;-> (8 2 5 6 4 3)

Vedi anche "Ordinare una lista con un'altra lista (variante)" su "Note libere 19".


--------------------
Test di Lucas-Lehmer
--------------------

Il test di Lucas-Lehmer è una verifica della primalità dei primi di Mersenne.
Per p numero primo, detto M(p) = 2^p - 1 il p-esimo numero di Mersenne, esso è primo se e solo se divide L(p-1), dove L(n) è l'n-esimo termine della successione definita ricorsivamente come:

  L(n+1) = L(n)^2 - 2, con L(1) = 4

Il test è stato sviluppato da Lucas nel 1870 e semplificato da Lehmer nel 1930.

La seguente funzione calcola i numeri primi di mersenne fino a un dato indice. Il secondo numero di Mersenne, M2, è primo, ma la funzione seguente calcola solo da M3 fino all'indice dato.

Nota: M2 è l'unico numero di Mersenne con indice pari (perchè l'indice è un numero primo).

(define (lucas-lehmer limite)
  (local (s n i expo)
    (println "M2 primo.")
    (setq n 1L)
    (for (expo 2 limite)
      (if (= expo 2)
          (setq s 0L)
          (setq s 4L))
      ; evita l'utilizzo della funzione pow
      (setq n (- (* (+ n 1) 2) 1))
      (for (i 1 (- expo 2))
        (setq s (% (- (* s s) 2) n)))
      (if (zero? s)
          (println "M" expo " primo.")))))

(lucas-lehmer 1000)
;-> M2 primo.
;-> M3 primo.
;-> M5 primo.
;-> M7 primo.
;-> M13 primo.
;-> M17 primo.
;-> M19 primo.
;-> M31 primo.
;-> M61 primo.
;-> M89 primo.
;-> M107 primo.
;-> M127 primo.
;-> M521 primo.
;-> M607 primo.

(time (lucas-lehmer 2300))
;-> M2 primo.
;-> M3 primo.
;-> M5 primo.
;-> M7 primo.
;-> M13 primo.
;-> M17 primo.
;-> M19 primo.
;-> M31 primo.
;-> M61 primo.
;-> M89 primo.
;-> M107 primo.
;-> M127 primo.
;-> M521 primo.
;-> M607 primo.
;-> M1279 primo.
;-> M2203 primo.
;-> M2281 primo.
;-> 89791.177 ; 90 secondi


-------------
0,1,2 con 0,1
-------------

Scrivere un algoritmo per generare 0, 1 e 2 con uguale probabilità utilizzando una funzione che produce 0 o 1 con il 50% di probabilità.

Supponiamo che la funzione specificata sia rnd(), che genera 0 o 1 con una probabilità del 50%. Quindi, se effettuiamo due chiamate diverse alla funzione rnd() e memorizziamo il risultato in due variabili, a e b, la loro somma a+b può essere uno qualsiasi di {0, 1, 2}. Qui, la probabilità di ottenere 0 e 2 è del 25% ciascuno e la probabilità di ottenere 1 è del 50%.
Ora il problema si riduce alla diminuzione della probabilità di ottenere 1 dal 50% al 25%. Possiamo farlo facilmente forzando la nostra funzione a non generare mai né (a = 1, b = 0) oppure (a = 0, b = 1), il che fa sì che la somma sia uguale a 1.

(define (rnd012)
  (local (a b)
    (setq a (rand 2))
    (setq b (rand 2))
    (if (and (= a 1) (= b 0))
        (rnd012)
        (+ a b))))

(rnd012)
;-> 0
(rnd012)
;-> 2

(define (test iter)
  (let (freq '(0 0 0))
    (for (i 1 iter)
      (++ (freq (rnd012))))
    (map (fn(x) (div x iter)) freq)))

Calcoliamo le frequenze:

(test 1e5)
;-> (0.33403 0.33284 0.33313)
(test 1e8)
;-> (0.33333341 0.33337291 0.33329368)


------------------------------------
Angolo delle lancette di un'orologio
------------------------------------

Data l'ora in formato ore:minuti, calcolare l'angolo minore tra la lancetta delle ore e quella dei minuti in un orologio analogico.
Per esempio:

Ora:  5:30
Angolo: 15°

Ora:  9:10
Angolo: 145°

Ora:  12:55
Angolo: 57°

La lancetta delle ore di un orologio analogico a 12 ore ruota di 360° in 12 ore e la lancetta dei minuti ruota di 360° in 60 minuti. Quindi, possiamo calcolare l'angolo in gradi della lancetta delle ore e della lancetta dei minuti separatamente e poi restituire la loro differenza utilizzando la seguente formula:

  Gradi(ore) = ore*(360/12) + (minuti*360)/(12*60)

  Gradi(minuti) = minuti*(360/60)

dove: 0 <= ore <= 23 e 0 <= minuti <= 59

L'angolo deve essere in gradi e misurato in senso orario dalla posizione delle ore 12 dell'orologio. Se l'angolo è maggiore di 180°, allora prendere la sua differenza con 360.

(define (angolo ore minuti)
  (local (angle-ore angle-minuti)
    (setq angle-ore (+ (/ (* ore 360) 12) (/ (* minuti 360) (* 12 60))))
    (setq angle-minuti (/ (* minuti 360) 60))
    (setq diff (abs (- angle-ore angle-minuti)))
    (if (> diff 180)
        (- 360 diff)
        diff)))

(angolo 5 30)
;-> 15
(angolo 9 10)
;-> 145
(angolo 12 55)
;-> 57
(angolo 1 30)
;-> 135

Vedi anche "Angolo minore delle lancette di un'orologio" su "Note libere 25".


----------
Data e ora
----------

Scrivere una funzione che stampa la data e l'ora corrente aggiornate in tempo reale (al secondo).

newLISP ha la funzione "now" che restituisce una lista con le informazioni che ci servono (vedere il manuale per maggiori informazioni).

(define (clock)
  (local (year month day hour minute second
          days-name months-name erase actual val)
    (setq days-name '("0" "lunedì" "martedì" "mercoledì" "giovedì" "venerdì" "sabato" "domenica"))
    (setq months-name '("gennaio" "febbraio" "marzo" "aprile" "maggio" "giugno" "luglio"
                      "agosto" "settembre" "ottobre" "novembre" "dicembre"))
    (setq erase (dup " " 70))
    (setq actual (slice (now) 0 6))
    (setq val '())
    ; infinite loop (break with CTRL-C)
    (while true
             ; update only when change year or
             ; month or day or hour or minute or second
      (cond ((!= actual (slice val 0 6))
             (setq val (now))
             (setq actual (slice val 0 6))
             (setq year (string (val 0)))
             (setq month (months-name (val 1)))
             (setq day (string (val 2)))
             (setq hour (string (val 3)))
             (setq minute (string (val 4)))
             (setq second (string (val 5)))
             (setq day-name (days-name (val 8)))
             (setq printed (string " " day-name ", " day " " month " " year ", " hour ":" minute ":" second))
             ; erase output line (print blank chars)
             (print (dup " " (length printed)) " \r")
             ; print informations
             (print printed "\r"))
            (true
             ; update clock values
             (setq val (now)))))))

(clock)
;->  lunedì, 28 luglio 2021, 16:49:28

Nota: premere CTRL-C per terminare il programma.


------------------------
Corda intorno alla Terra
------------------------

Supponiamo di avere una corda che circonda una Terra perfettamente sferica che ha una circonferenza pari a 40000 km. La corda viene allungata di 1 metro e posta come una circonferenza a distanza costante dalla Terra.
Quanto è distante la nuova circonferenza dalla Terra?
Di quanto bisogna allungare la corda per fare una circonferenza che si trovi a 1 metro di distanza dalla Terra?

La prima circonferenza C vale:

  C = 2*π*R

La seconda circonferenza C + L vale:

  C + L = 2*π*R1

dove R e R1 sono i raggi delle due circonferenze e L è la lunghezza della corda aggiunta.

La differenza (R1 - R) vale:

            C + L       C        C + L - C       L
  R1 - R = ------- - ------- = ------------- = -----
             2*π       2*π          2*π         2*π

Quindi la distanza dalla Terra dipende solo da quanto viene allungata la corda e non dipende dal valore della circonferenza.

(define (diff L)
  (div L (mul 2 3.1415926535897931)))

(diff 1)
;-> 0.1591549430918954

La nuova circonferenza è distante 15.9 cm dalla Terra.

(diff 5)
;-> 0.7957747154594768

Per la seconda domanda, se R - R1 = 1, allora deve risultare L = 2*π.


-------
Eredità
-------

Autore: Richard A. Proctor (1886)

Uno sceicco lascia in eredità 35 cammelli ai suoi tre figli.
L'eredità dovrà essere divisa nel modo seguente:
1/2 al figlio maggiore, 1/3 al secondogenito e 1/9 al terzo figlio, senza uccidere animali. Il notaio dovrà ricevere un cammello come ricompensa per il suo lavoro. Come dividere i cammelli?

Nota: 1/2 + 1/3 + 1/9 = 17/18 = 34/36

Il notaio presta un cammello e, dei 36 cammelli totali, il primo figlio ne prende 18 (la metà), il secondo 12 (la terza parte) ed il terzo 4 (la nona parte). In totale i cammelli "spartiti" sono 34. I due cammelli rimasti vengono presi dal notaio (uno già gli apparteneva) che quindi ottiene un cammello come ricompensa.
Da notare che tutti i figli hanno avuto di più della parte stabilita nel testamento.


-----------------
Sequenza di Farey
-----------------

La sequenza di Farey F(n) per ogni intero positivo n è l'insieme dei numeri razionali a/b irriducibili (ridotti ai minimi termini) con 0<=a<=b<=n e (a,b)=1 disposti in ordine crescente.

Un termine a/b può essere valutato ricorsivamente utilizzando i due termini precedenti. Di seguito è riportata la formula per calcolare a(n+2)/b(n+2) da a(n+1)/b(n+1) e a(n)/b(n):

a(n+2) = floor((b(n) + n)/b(n+1))*a(n+1) - a(n)
b(n+2) = floor((b(n) + n)/b(n+1))*b(n+1) - b(n)

(define (farey num)
  (local (a b a1 b1 a2 b2 out)
    (setq out '())
    (setq a1 0 b1 1 a2 1 b2 num)
    ; il primo termine vale 0/1
    (push (list 0 1) out)
    ; il secondo termine vale 1/num
    (push (list 1 num) out -1)
    ; inizializzazione dei valori nuovo termine
    (setq a 0 b 0)
    ; ciclo fino a che b = 1
    (while (!= b 1)
      ; relazione per trovare il termine corrente
      (setq a (- (* (floor (div (add b1 num) b2)) a2) a1))
      (setq b (- (* (floor (div (add b1 num) b2)) b2) b1))
      ; inserimento del termine corrente
      (push (list a b) out -1)
      ; aggiornamento valori per la prossima iterazione
      (setq a1 a2)
      (setq a2 a)
      (setq b1 b2)
      (setq b2 b)
    )
    ; funzione di comparazione per l'ordinamento (sort)
    (define (cmp x y) (< (div (first x) (last x)) (div (first y) (last y))))
    ; ordina la lista (crescente)
    (sort out cmp)))

(farey 7)
;-> ((0 1) (1 7) (1 6) (1 5) (1 4) (2 7) (1 3) (2 5) (3 7) (1 2)
;->  (4 7) (3 5) (2 3) (5 7) (3 4) (4 5) (5 6) (6 7) (1 1))

(length (farey 100))
;-> 3045
(length (farey 1000))
;-> 304193

Il numero N di frazioni contenute nella sequenza di Farey di un numero n vale:

          n
  N = 1 + ∑ totient(k)
         k=1

Funzione che calcola il toziente di eulero di un dato numero:

(define (totient num)
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

Funzione che calcola la lunghezza della sequenza di Farey di un dato numero:

(define (farey-len num)
  (let (out 1)
    (for (k 1 num)
      (setq out (+ out (totient k)))
    )
    out))

(farey-len 100)
;-> 3045

(farey-len 1000)
;-> 304193

              3*n²
Nota: N(n) ≈ ------
               π²

(define (farey-len2 num)
  (div (mul 3 num num) (mul 3.1415926535897931 3.1415926535897931)))

(farey-len2 1000)
;-> 303963.5509270133

(farey-len 100000)
;-> 3039650755
(farey-len2 100000)
;-> 3039635509.270134


---------------------
Distanza di Chebyshev
---------------------

La distanza di Chebyshev (o della scacchiera o di Lagrange), è il valore tale per cui la distanza tra due vettori è il valore massimo della loro differenza lungo gli assi:

  d(p,q) = max[(|p(i) - q(i)|)]

Nella geometria piana (2D), dati due punti P(x1,y1) e Q(x2,y2) la loro distanza di Chebyshev vale:

  d(P,Q) = max(|x2 - x1|,|y2 - y1|)

Nota: In due dimensioni, la distanza di Chebyshev è equivalente ad una rotazione ed una riscalatura della distanza di Manhattan.

Scriviamo una funzione che calcola la distanza di Chebyshev:

(define (dist-chebyshev x1 y1 x2 y2)
  (max (abs (sub x2 x1)) (abs (sub y2 y1))))

(dist-chebyshev 1 3 3 6)
;-> 3

In N dimensioni i due punti hanno le seguenti coordinate:

  P = (p1, p2, ..., pN)
  Q = (q1, q2, ..., qN)

E la distanza di Chebyshev tra i due punti P e Q vale:

  d(P,Q) = max(|pi - qi|), dove 1<=i<=N

Quindi la funzione generica per calcolare la distanza di Chebyshev tra due punti diventa:

(define (dist-cheby P Q)
  (apply max (map (fn(x y) (abs (sub x y))) P Q)))

(dist-cheby '(1 2 3 4) '(4 7 8 2))
;-> 5

(dist-cheby '(1 3) '(3 6))
;-> 3


----------
Anti-primi
----------

Gli anti-primi (o numeri altamente composti) sono i numeri naturali con più fattori di quelli più piccoli di se stesso. In altre parole, i numeri altamente composti sono quei numeri n dove d(n), il numero di divisori di n, aumenta a record (cioè è maggiore del precedente).

Sequenza OEIS A002182:
  1, 2, 4, 6, 12, 24, 36, 48, 60, 120, 180, 240, 360, 720, 840, 1260,
  1680, 2520, 5040, 7560, 10080, 15120, 20160, 25200, 27720, 45360,
  50400, 55440, 83160, 110880, 166320, 221760, 277200, 332640, 498960,
  554400, 665280, 720720, 1081080, 1441440, 2162160, ...

Funzione che fattorizza un numero:

(define (factor-group num)
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

Funzione che conta i divisori di un numero:

(define (divisors-count num)
  (if (= num 1)
      1
      (let (lst (factor-group num))
        (apply * (map (fn(x) (+ 1 (last x))) lst)))))

Funzione che calcola gli anti-primi fino ad un dato limite:

(define (anti-primes limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-count i))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(anti-primes 1000)
;-> ((1 1) (2 2) (4 3) (6 4) (12 6) (24 8) (36 9) (48 10) (60 12)
;->  (120 16) (180 18) (240 20) (360 24) (720 30) (840 32))

(map first (anti-primes 10000))
;-> (1 2 4 6 12 24 36 48 60 120 180 240 360 720 840 1260 1680 2520 5040 7560)

Possiamo calcolare anche i numeri altamente composti il cui anche il numero di divisori è un numero altamente composto.

Sequenza OEIS A189394:
  1, 2, 6, 12, 60, 360, 1260, 2520, 5040, 55440, 277200, 720720, 3603600,
  61261200, 2205403200, 293318625600, 6746328388800, 195643523275200, ...

(define (anti2-primes limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-count (divisors-count i)))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(anti2-primes 10000)
;-> ((1 1) (2 2) (6 3) (12 4) (60 6) (360 8) (1260 9) (2520 10) (5040 12))
(map first (anti2-primes 1e6))
;-> (1 2 6 12 60 360 1260 2520 5040 55440 277200 720720)

(time (println (map first (anti2-primes 1e8))))
;-> (1 2 6 12 60 360 1260 2520 5040 55440 277200 720720 3603600 61261200)
;-> 683129.503


---------------------------
Numeri altamente abbondanti
---------------------------

I numeri altamente abbondanti sono quei numeri k tali che sigma(k) > sigma(m) per ogni m < k, dove sigma(k) è la somma dei divisori di k.

Sequenza OEIS A002093:
  1, 2, 3, 4, 6, 8, 10, 12, 16, 18, 20, 24, 30, 36, 42, 48, 60, 72, 84,
  90, 96, 108, 120, 144, 168, 180, 210, 216, 240, 288, 300, 336, 360,
  420, 480, 504, 540, 600, 630, 660, 720, 840, 960, 1008, 1080, 1200,
  1260, 1440, 1560, 1620, 1680, 1800, 1920, 1980, 2100, ...

Funzione che fattorizza un numero:

(define (factor-group num)
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

Funzione che somma tutti i divisori di un numero:

(define (divisors-sum num)
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

Funzione che calcola i numeri altamente abbondanti fino ad un dato limite:

(define (high-abundant limit)
  (local (out best)
    (setq out '())
    (setq best 0)
    (for (i 1 limit)
      (setq val (divisors-sum i))
      (if (> val best) (begin
          (setq best val)
          (push (list i val) out -1))
      )
    )
    out))

(high-abundant 100)
;-> ((1 1) (2 3) (3 4) (4 7) (6 12) (8 15) (10 18) (12 28) (16 31) (18 39)
;->  (20 42) (24 60) (30 72) (36 91) (42 96) (48 124) (60 168) (72 195)
;->  (84 224) (90 234) (96 252))

(map first (high-abundant 1e3))
;-> (1 2 3 4 6 8 10 12 16 18 20 24 30 36 42 48 60 72 84 90 96
;->  108 120 144 168 180 210 216 240 288 300 336 360 420 480
;->  504 540 600 630 660 720 840 960)


-------------------------------
Creazione dinamica di variabili
-------------------------------

Scrivere una funzione che permette di creare dinamicamente una variabile.

La seguente funzione prende due parametri, il nome (stringa) della variabile da creare e il valore della varibile:

(define (create-var name-var value-var)
  (local (var)
    (setq var name-var)
    (set (sym var) value-var)
    (sym var)))

(create-var "pluto" '(10 20 30))
;-> pluto
pluto
;-> '(10 20 30)
(list? pluto)
;-> true

Possiamo anche creare una variabile definita dall'utente:

(define (make-var)
  (local (var)
    (print "Nome della variabile: ")
    (setq var (read-line))
    ; crea il simbolo/variabile inserito dall'utente come stringa
    (set (sym var) '())
    (println "Variabile " var " creata.")
    (println "Valore della variabile: " (eval (sym var)))
    (print "Nuovo valore della variabile: ")
    ;(set (sym var) (sym (read-line))) ; no list, only a symbol !!!
    ; eval-string valuta la stringa inserita dall'utente
    (set (sym var) (eval-string (read-line)))
    (println (sym var) " = " (eval (sym var)))
  ))

(make-var)
;-> Nome della variabile:
pippo
;-> Variabile pippo creata.
;-> Valore della variabile: ()
Nuovo valore della variabile:
'(10 20 30)
;-> pippo = (10 20 30)
pippo
;-> (10 20 30)
(list? pippo)
;-> true


-------------------
La funzione "curry"
-------------------

Prima di tutto vediamo la definizione del manuale:

******************
>>>funzione CURRY
******************
sintassi: (curry func exp)

Trasforma "func" da una funzione f(x, y) che prende due argomenti, in una funzione fx(y) che prende un singolo argomento. "curry" funziona come una macro, nel senso che non valuta i suoi argomenti. Questi ultimi vengono valutati durante l'applicazione della funzione "func".

Vediamo alcuni esempi:

(set 'f (curry + 10))
;-> (lambda ($x) (+ 10 $x))

(f 7)
;-> 17

(filter (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((a 10) (a 3) (a 9))

(clean (curry match '(a *)) '((a 10) (b 5) (a 3) (c 8) (a 9)))
;-> ((b 5) (c 8))

(map (curry list 'x) (sequence 1 5))
;-> ((x 1) (x 2) (x 3) (x 4) (x 5))

"curry" può essere usato con tutte le funzioni che prendono due argomenti.

Vediamo come usare "curry" insieme alla funzione "map".

(map (curry list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

In pratica "curry" crea una funzione anonima:
(curry list 1)
;-> (lambda ($x) (list 1 $x))

Ecco altri esempi:

(curry * 2)
;-> (lambda ($x) (* 2 $x))
(curry + 3)
;-> (lambda ($x) (+ 3 $x))
((curry + 3) 10)
;-> 13

Possiamo assegnare un nome alla funzione creata da "curry":

(define add3 (curry + 3))
;-> (lambda ($x) (+ 3 $x))
(add3 10)
;-> 13

Possiamo utilizzare "map" con una funzione che riceve più di un argomento (ad esempio la funzione "pow") in questo modo:

(map pow '(2 1) '(3 4))
;-> (8 1)

dove: 8 = 2^3, 1 = 1^4

Ma se la lista degli argomenti si trova all'interno di un'altra lista, allora otteniamo un errore:

(setq lst '((2 1) (3 4)))
(map pow lst)
;-> ERR: value expected in function pow : '(2 1)

Utilizziamo la funzione "curry" per risolvere questo problema:

(map (curry apply pow) lst)
;-> (2 81)

dove: 2 = 2^1, 81 = 3^4

Ok, non è il risultato che volevamo, ma se trasponiamo la lista degli argomenti:

(transpose lst)
;-> ((2 3) (1 4))

Quindi possiamo scrivere:

(map (curry apply pow) (transpose lst))
;-> (8 1)

Che è equivalente a:

(map (lambda(x) (apply pow x)) (transpose lst))
;-> (8 1)

Possiamo anche utilizzare una funzione definita dall'utente:

(define (mypow lst)
  (if (null? lst) '()
      (cons (pow (nth '(0 0) lst) (nth '(0 1) lst)) (mypow (rest lst)))
  )
)

(setq lst '((2 1) (3 4)))
(mypow (transpose lst))
;-> (8 1)

Un altro esempio con la funzione "max":

(map max '(3 5) '(2 7))
;-> (3 7)

(map (curry apply max) '((3 5) (2 7)))
;-> (5 7)

(map (curry apply max) (transpose '((3 5) (2 7))))
;-> (3 7)

Definiamo una macro che si comporta come la funzione predefinita "curry":

(define-macro (curry1 f)
  (append (lambda (z)) (list (cons f (append (args) '(z))))))

(curry1 + 10)
;-> (lambda (z) (+ 10 z))
((curry1 + 10) 20)
;-> 30

(map (curry1 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

(map (curry1 list 'x) '(a b c))
;-> ((x a) (x b) (x c))

Ecco un'altra soluzione che utilizza "expand", ma è più lenta:

(define-macro (curry2 f)
   (letex (body (cons f (append (args) '(z))))
      (lambda (z) body)))

(curry2 + 10)
;-> (lambda (z) (+ 10 z))
((curry2 + 10) 20)
;-> 30

(map (curry2 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

(map (curry2 list 'x) '(a b c))
;-> ((x a) (x b) (x c))

Vediamo perchè una funzione (invece di una macro) non si comporta correttamente:

(define (curry3 f)
  (append (lambda (z)) (list (cons f (append (args) '(z))))))

(curry3 + 1)
;-> (lambda (z) (+@41493E 1 z))

Se quotiamo la funzione otteniamo:

(curry3 '+ 1)
;-> (lambda (z) (+ 1 z))

La seguente chiamata si comporta correttamente:

(map (curry3 list 1) '(a b c))
;-> ((1 a) (1 b) (1 c))

Ma la seguente non genera il risultato corretto:

(map (curry3 list 'x) '(a b c))
;-> ((nil a) (nil b) (nil c))

perchè il simbolo "x" viene valutato a nil, invece la macro non valuta il simbolo "x".

Come abbiamo visto, "curry" trasforma una funzione con due argomenti in una funzione con un singolo argomento raggruppandolo nel primo argumento (quello più sinistra). Inoltre non valuta i suoi argomenti.

Per esempio:

(define (sottrai a b) (- a b))
;-> (lambda (a b) (- a b))
(define fun (curry sottrai 10))
;-> (lambda ($x) (sottrai 10 $x))
(fun 4)
;-> 6
(sottrai 10 4)
;-> 6

Come funziona?
Per prima cosa definiamo una funzione chiamata "sottrai" che accetta due argomenti e sottrae il secondo dal primo.
Quindi applichiamo "curry" a questa funzione per ottenere una nuova funzione "fun", a cui passiamo "10" come primo argomento fisso. 
La funzione restituita viene associata alla variabile "fun".
Quando chiamiamo "fun" passando 4, otteniamo 6 come previsto. Questo è esattamente lo stesso che chiamare "sottrai" con gli argomenti 10 e 4.

Altri esempi:

(map fun '(10 20 30))
;-> (0 -10 -20)
(map sottrai '(10 10 10) '(10 20 30))
;-> (0 -10 -20)
(map (curry sottrai 5) '(10 20 30))
;-> (-5 -15 -25)
((curry fun 10) 20)
;-> 0

Come si nota, "currying" semplifica alcune chiamate di funzione e rende il codice più leggibile.

La funzione "lambda" restituita da "curry" nomina il suo singolo argomento in ingressoo come "$x". Possiamo quindi usare questo nome nella nostra espressione di argomenti.

(define (pippo arg1 arg2) (* arg1 arg2))
;-> (lambda (arg1 arg2) (* arg1 arg2))
(define curry-pippo (curry pippo (+ $x 2)))
;-> (lambda ($x) (pippo (+ $x 2) $x))
(curry-pippo 50)
;-> 2600  ;(* 52 50) ==> 2600

Poichè "curry" non valuta i suoi argomenti possiamo commettere il seguente tipo di errore:

(define (pippo arg1 arg2) (* arg1 arg2))
;-> (lambda (arg1 arg2) (* arg1 arg2))
(define fun (let (x 6) (curry pippo x)))
;-> (lambda ($x) (pippo x $x))
(fun 10)
;-> ERR: value expected in function * : nil
;-> called from user function (pippo x $x)
;-> called from user function (fun 10)

In questo caso, per risolvere il problema, dobbiamo usare "letex" al posto di "let", che valuta/sostituisce la "x" all'interno di "curry" con il suo valore iniziale (espansione statica):

(define fun (letex (x 6) (curry pippo x)))
(fun 10)
;-> 60

La funzione "curry" è molto utile e comoda in certi casi.


-------------------
Algoritmo evolutivo
-------------------

Data una stringa (target) scrivere un algoritmo che genera una stringa (current) uguale in modo evolutivo.

Un algoritmo può essere il seguente:

1) generare la stringa "current" con tutti spazi vuoti lunga come la stringa "target"
2) se target=current, allora abbiamo ottenuto la soluzione.
   altrimenti,
    Calcolare la 'distanza' tra la stringa "target" e la stringa "current" (quanti caratteri sono differenti?).
    Modificare in modo casuale/evolutivo i caratteri della stringa "current" che sono diversi da quelli della stringa "target".
    Andare al passo 2.

Vediamo il procedimento:

La stringa da ottenere:

(setq target "NEWLISP IS FUN")

La stringa iniziale (tutti spazi):

(setq current (dup " " (length target)))

Funzione che genera un carattere maiuscolo casuale:

(define (rnd-char) (char (+ (rand 26) 65)))

Funzione che genera una lista con tutti gli indici dei caratteri che sono differenti tra la stringa str1 e la stringa str2:

(define (fitness str1 str2)
  (let (out '())
    (for (i 0 (- (length str1) 1))
      (if (!= (str1 i) (str2 i))
        ;(push (list i (str1 i)) out -1)
        (push i out -1)
      )
    )
    out))

(setq change (fitness target current))
;-> (0 1 2 3 4 5 6 8 9 11 12 13)

Funzione che aggiorna casualmente tutti i caratteri della stringa current che sono differenti tra la stringa target e la stringa current:

(define (update current change)
  (for (i 0 (- (length change)))
    (setf (current (change i)) (rnd-char))
  )
  current)

(setq current (update current change))
;-> "EELVYHN PK KWT"

Adesso possiamo scrivere la funzione "evolutiva":

(define (evolutionary target)
  (local (current change counter)
    (setq counter 1)
    (setq current (dup " " (length target)))
    (while (!= target current)
      (setq change (fitness target current))
      (setq current (update current change))
      (println counter {: } target { - } current)
      (++ counter)
    )))

(evolutionary "NEWLISP IS FUN")
;-> 1: NEWLISP IS FUN - ZTJQPIA BU PQA
;-> 2: NEWLISP IS FUN - LNHQYPN DO MVZ
;-> 3: NEWLISP IS FUN - GKQWVTU MT EMW
;-> 4: NEWLISP IS FUN - SEGBWIY TY VAQ
;-> 5: NEWLISP IS FUN - MEWVNQZ NA KRO
;-> 6: NEWLISP IS FUN - IEWZYQA KC XRD
;-> ...
;-> 49: NEWLISP IS FUN - NEWLISP ES FUN
;-> 50: NEWLISP IS FUN - NEWLISP RS FUN
;-> 51: NEWLISP IS FUN - NEWLISP GS FUN
;-> 52: NEWLISP IS FUN - NEWLISP TS FUN
;-> 53: NEWLISP IS FUN - NEWLISP IS FUN

A dire il vero, questo algoritmo non è "evolutivo" nel senso stretto del significato: non esiste una popolazione e le mutazioni avvengono solo nei caratteri errati.

L'algoritmo generale (Weasel algorithm) è stato proposto da Richard Dawkins utilizzando la seguente frase di 28 caratteri:

  "METHINKS IT IS LIKE A WEASEL"

1. Iniziare con una stringa casuale di 28 caratteri.
2. Fare 100 copie della stringa (riproduzione).
3. Per ogni carattere in ciascuna delle 100 copie, con una probabilità del 5%, sostituire (mutare) il carattere con un nuovo carattere casuale.
4. Confrontare ogni nuova stringa con la stringa di destinazione "METHINKS IT IS LIKE A WEASEL" e assegnare a ciascuna un punteggio che rappresenta l'adattamento evolutivo (il numero di lettere nella stringa che sono corrette e nella posizione corretta).
5. Se una delle nuove stringhe ha un punteggio perfetto (28), abbiamo finito. Altrimenti, prendere la stringa con il punteggio più alto e andare al passo 2.

Un "carattere" è una qualsiasi lettera maiuscola o uno spazio. Il numero di copie per generazione e la possibilità di mutazione per lettera non sono specificati nel libro di Dawkins. Inoltre, 100 copie e un tasso di mutazione del 5% sono solo numeri di esempio. Le lettere corrette non sono "bloccate". Ogni lettera corretta può diventare errata nelle generazioni successive. I termini del programma e l'esistenza della frase target indicano tuttavia che tali 'mutazioni negative' verranno rapidamente corrette.

Vediamo come implementare l'algoritmo Weasel.

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")

Funzione che genera un carattere maiuscolo casuale o uno spazio:

(define (rnd-char-space)
  (let (ch (char (+ (rand 27) 65)))
    (if (= ch "[")
        " "
        ch)))

(rnd-char-space)
;-> "W"

Funzione che confronta la similitudine di due strignhe (numero di caratteri uguali nella stessa posizione):

(define (check-evolution str1 str2)
  (let (same 0)
    (for (i 0 (- (length str1) 1))
      (if (= (str1 i) (str2 i))
        (++ same)
      )
    )
    same))

(check-evolution target current)
;-> 1

Funzione che modifica una popolazione:

(define (evolve mutation)
  (for (m 0 (- (length mutation) 1))
    (for (i 0 (- (length (mutation m)) 1))
       (if (> change (rand 100)) (begin
           (setf ((mutation m) i) (rnd-char-space))
       ))
    )
  )
  mutation)

Funzione che calcola la mutazione più adatta (stringa più vicina al target):

(define (best-fit mutation)
  (local (score out val-max)
    (setq out -1)
    (setq val-max -1)
    (setq score '())
    ;(dolist (m mutation)
    ;  (push (check-evolution target m) score -1)
    ;)
    (setq score (map (curry check-evolution target) mutation))
    (dolist (s score)
      (if (> s val-max)
        (setq val-max s out $idx)
      )
    )
    out))

Funzione finale dell'algoritmo di Weasel:

(define (evolution target start population change)
(catch
  (local (mutation current generation)
    (setq current start)
    (setq generation 0)
    (while true
      ; creazione della mutazione
      (setq mutation (dup current population true))
      (setq mutation (evolve mutation))
      ; calcolo mutazione più adatta
      (setq current (mutation (best-fit mutation)))
      (++ generation)
      (println current)
      ; target raggiunto?
      (if (= current target) (throw generation))
    ))))

Facciamo alcune prove:

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")
(evolution target current 100 5)
;-> QFXCBVHJ IDGC VHGQ JKLOPQB Q
;-> QFXCBMHJ IDQC VHGQ JKLOPQB L
;-> MFXCBMHJ IDQC VHGQ JKLOPQB L
;-> MFTCBMHJ IDQC VHGQ JKLOPQB L
;-> ...
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASKL
;-> METHINKS IT IS LIKE A WEASEL
;-> 111

(setq target  "METHINKS IT IS LIKE A WEASEL")
(setq current "DFGCBVHJUIDGC VHAQ JKLOPQB Q")
(evolution target current 1000 10)
;-> ...
;-> 45

(setq target  "EVA VINCE A BRISCOLA MA PERDE A TRESSETTE")
(setq current "                                         ")
(evolution target current 1000 5)
;->        D       S    T                 T
;->   A    M      WS    T                 T
;->   A    M     NWS    T      D          T
;->   A    M     WWS    T   P  D          T
;->  VA    MK    WWS  E T   P  D          T
;->  VA    ML    WWS  E     P  D         WT
;-> EVA    ML    WIS  E     P  D      J  WT
;-> EVA    ML    WIS  E   B P  D      J  WT E
;-> ...
;-> EVA VINCE A BRIS OLA MA PERDE A TRESSETTE
;-> EVA VINCE A BRIS OLA MA PERDE A TRESSETTE
;-> EVA VINCE A BRISCOLA MA PERDE A TRESSETTE
;-> 89

La convergenza dell'algoritmo dipende molto dai parametri "population" e "change".


------------------
Nome del programma
------------------

newLISP ha una funzione per gestire il nome del programma e i suoi parametri: "main-args"
Vediamo la definizione del manuale:

sintassi: (main-args)
sintassi: (main-args int-index)
main-args returns a list with several string members, one for program invocation and one for each of the command-line arguments.
restituisce una lista con diversi elementi stringa, uno per l'invocazione del programma e uno per ciascuno degli argomenti della riga di comando.

newlisp 1 2 3

(main-args)
;-> ("newlisp" "1" "2" "3")

Dopo che "newlisp 1 2 3" è stato eseguito al prompt dei comandi, main-args restituisce un elenco contenente il nome del programma invocante e tre argomenti della riga di comando.

Facoltativamente, main-args può prendere un int-index come indice nella lista. Nota che un indice fuori dall'intervallo farà sì che venga restituito nil, non l'ultimo elemento dell'elenco come nell'indicizzazione standard delle liste.

newlisp a b c

(main-args 0)
;-> "newlisp"
(main-args -1)
;-> "c"
(main-args 2)
;-> "b"
(main-args 10)
;-> nil

Nota che quando newLISP viene eseguito da uno script, main-args restituisce anche il nome dello script come secondo argomento:

# script to show the effect of 'main-args' in script file
(print (main-args) "\n")
(exit)
# end of script file

;; eseguire lo script dalla shell del sistema operativo

script 1 2 3

("newlisp" "script" "1" "2" "3")

Try executing this script with different command-line parameters.

newLISP has a function, (main-args int) for this.

Per ottenere il nome del programma/script possiamo usare il seguente script:

(let ((program (main-args 1)))
  (println (format "Program: %s" program))
  (exit))


------------------
loop e recur macro
------------------

Le macro "loop" e "recur" (scritte da ClaudeM) facilitano l'utilizzo di una programmazione simile al linguaggio Scheme in quanto newLISP non supporta l'ottimizzazione della ricorsione in coda (Tail Code Optimization).
Queste macro sono molto eleganti anche se sono meno efficienti della tecnica di "trampolining" o delle tecniche iterative.

; looking at options to simulate TCO (Tail Code Optimization)
; I come from Scheme and I like simple recursion
; maybe like Clojure, which makes it explixit with loop & recur
;
; Use a pair of macros. The process is as follows:
;   - use a loop (otherwise infinite)
;   - there must be two args: let-list and body
;   - define local variables with initial values
;   - execute the body, must have an exit test and recur
;   - recur macro
;     - in tail position - how would I check for this?
;     - take new values for local variables (positional)
;     - loop back; if not in tail position, problems may occur
(define-macro (loop)
  (letn (loop-recur-let-list (args 0)
         loop-recur-body (args 1)
         loop-recur-let-list-length (length loop-recur-let-list)
         loop-recur-var-names '()
         loop-recur-variables '()
         loop-recur-done nil)
    ;
    ; let-list could be a list of pairs or a list of two-item lists
    ; convert pairs to a list of lists
    ;
;   (println "loop-recur-let-list : " loop-recur-let-list)
;   (println "loop-recur-body : " loop-recur-body)
;   (println " - - - - - - - -")
    (if (not (list? (loop-recur-let-list 0)))
      (begin
        (if (not (even? loop-recur-let-list-length))
            (begin
              ;;(println "The loop's let list must contain an even number of items.")
              ;;(println "  (loop " loop-recur-let-list " ...)")
              (exit 1)))
        ;
        ; loop over pairs and convert
        ;
        (letn (loop-recur-old-let-list loop-recur-let-list)
          (setq loop-recur-let-list '())
          (for (i 0 (- loop-recur-let-list-length 1) 2)
            (push (list (nth i loop-recur-old-let-list)
                        (nth (+ i 1) loop-recur-old-let-list))
                  loop-recur-let-list
                  -1)))))
    ;
    ; process loop-recur-let-list: extract variable names and initial values
    ; so I can redefine at each iteration
    ; build loop-recur-var-names and initial loop-recur-variables
    ;
    (dolist (i loop-recur-let-list)
      (push (first i) loop-recur-var-names -1)
      (push (nth 1 i) loop-recur-variables -1))
    ;;(println "loop-recur-var-names : " loop-recur-var-names)
    ;;(println "loop-recur-variables : " loop-recur-variables)
    ;
    ; loop variables are defined and given initial values
    ;
    (until loop-recur-done
      ; define variables, made fresh each iteration
      (setq loop-recur-let-list
            (map list loop-recur-var-names loop-recur-variables))
      ;;(println "loop-recur-let-list : " loop-recur-let-list)
      (letex (loop-recur-let-list-expanded loop-recur-let-list)
        (let loop-recur-let-list-expanded
          (setq loop-recur-done true)  ; if recur is not used, the loop should end
          (eval loop-recur-body))))))  ; evaluate the body, it should call recur
;
; build a new loop-recur-let-list
;
(define-macro (recur)
  (begin
    (setq loop-recur-variables
          (map eval (args)))
;   (println "recur: new variables are " loop-recur-variables)
    (setq loop-recur-done nil)))
;
; quick test
;
(define (factorial n)
  (loop (i 1
         prod 1L)
      (if (> i n)
        prod
        (recur (+ 1 i) (* prod i)))))

(factorial 5)
;-> loop-recur-var-names : (i prod)
;-> loop-recur-variables : (1 1L)
;-> loop-recur-let-list : ((i 1) (prod 1L))
;-> loop-recur-let-list : ((i 2) (prod 1L))
;-> loop-recur-let-list : ((i 3) (prod 2L))
;-> loop-recur-let-list : ((i 4) (prod 6L))
;-> loop-recur-let-list : ((i 5) (prod 24L))
;-> loop-recur-let-list : ((i 6) (prod 120L))
;-> 120L

Vediamo la diffferenza di velocità con una versione iterativa del fattoriale:

(define (fact num)
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(= (fact 200) (factorial 200))
;-> true

(time (factorial 200) 1000)
;-> 281.456

(time (fact 200) 1000)
;-> 31.178

La versione iterativa è 9 volte più veloce.


---------------------------
Breve introduzione ai grafi
---------------------------

A) Cosa è un Grafo?
-------------------

Un grafo è una coppia ordinata G = (V, E) che comprende un insieme V di vertici o nodi e un insieme di coppie di vertici da V, noti come archi (edges) di un grafo. Ad esempio, per il grafo sottostante.

  V = { 1, 2, 3, 4, 5, 6 }
  E = { (1, 4), (1, 6), (2, 6), (4, 5), (5, 6) }

  ╔═══╗           ╔═══╗
  ║ 6 ║-----------║ 2 ║
  ╚═══╝           ╚═══╝
    |  \
    |   \
    |    \
    |     ╔═══╗           ╔═══╗
    |     ║ 1 ║           ║ 3 ║
    |     ╚═══╝           ╚═══╝
    |          \
    |           \
    |            \
  ╔═══╗           ╔═══╗
  ║ 5 ║-----------║ 4 ║
  ╚═══╝           ╚═══╝

B) Tipi di grafi
----------------

1. Grafo non orientato (Undirected graph)
-----------------------------------------
Un grafo non orientato (grafo) è un grafo in cui gli archi non hanno orientamento. L'arco (x, y) è identico all'arco (y, x), cioè non sono coppie ordinate. Il numero massimo di archi possibili in un grafo non orientato senza cicli (loop) è n*(n-1)/2.

Esempio di grafo non orientato

  ╔═══╗           ╔═══╗
  ║ 6 ║-----------║ 2 ║
  ╚═══╝           ╚═══╝
    |  \
    |   \
    |    \
    |     ╔═══╗           ╔═══╗
    |     ║ 1 ║-----------║ 3 ║
    |     ╚═══╝           ╚═══╝
    |          \         /
    |           \       /
    |            \     /
  ╔═══╗           ╔═══╗
  ║ 5 ║-----------║ 4 ║
  ╚═══╝           ╚═══╝

2. Grafo orientato (Direct graph)
-------------------------------
Un grafo orientato (digrafo) è un grafo in cui gli archi sono orientati, ovvero l'arco (x, y) non è identico all'arco (y, x).

Esempio di grafo orientato (Il carattere "■" rappresenta la fine dell'arco)

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
       /
      /
  ╔═══╗           ╔═══╗
  ║ 1 ║■---------■║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
        \       /
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

3. Grafo aciclico diretto (Directed Acyclic Graph - DAG)
----------------------------------------------------------
Un grafo aciclico diretto (DAG) è un grafo orientato che non contiene cicli.

Esempio di DAG

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
       /
      /
  ╔═══╗           ╔═══╗
  ║ 1 ║■----------║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
        \       /
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

4. Multi grafo
--------------
Un multigrafo è un grafo non orientato in cui sono consentiti più archi (e talvolta cicli/loop). Gli archi multipli sono due o più archi che collegano gli stessi due vertici. Un ciclo è un arco (diretto o non orientato) che collega un vertice a se stesso (può essere consentito o meno)

5. Grafo semplice
-----------------
Un grafo semplice è un grafo non orientato in cui non sono consentiti sia gli archi multipli che i cicli/loop rispetto a un multigrafo. In un grafo semplice con n vertici, il grado di ogni vertice è al massimo n-1.

Esempi di archi multipli

  ╔═══╗----------■╔═══╗           ╔═══╗-----------╔═══╗
  ║ 1 ║           ║ 2 ║           ║ 1 ║           ║ 2 ║
  ╚═══╝■----------╚═══╝           ╚═══╝-----------╚═══╝

Esempio di ciclo/loop

  ╔═══╗------+
  ║ 1 ║      |
  ╚═══╝------+

6. Grafo pesato e non pesato
------------------------------------
Un grafo pesato associa un valore (peso) a ogni arco del grafo. Possiamo anche usare le parole costo o lunghezza invece di peso.

Un grafo non pesato non ha alcun valore (peso) associato a ogni arco del grafo. In altre parole, un grafo pesato è un grafo pesato con tutti i pesi degli archi pari a 1. Se non diversamente specificato, si presume che tutti i grafi non siano ponderati per impostazione predefinita.

Esempio di grafo diretto pesato

          ╔═══╗
          ║ 2 ║
          ╚═══╝
        ■
    10 /
      /
  ╔═══╗     3     ╔═══╗
  ║ 1 ║■----------║ 3 ║
  ╚═══╝           ╚═══╝
       \         ■
      8 \       / 4
         ■     /
          ╔═══╗
          ║ 4 ║
          ╚═══╝

7. Grafo completo
-----------------
Un grafo completo è quello in cui ogni due vertici sono adiacenti: tutti i bordi che possono esistere sono presenti.

8. Grafo connesso
-----------------
Un grafo connesso ha un percorso tra ogni coppia di vertici. In altre parole, non ci sono vertici irraggiungibili. Un grafo disconnesso è un grafo non connesso.

C) Termini comunemente usati per i Grafi
----------------------------------------

Un "arco (edge)" è (insieme ai "vertici (vertices") una delle due unità di base da cui sono costruiti i grafi. Ogni arco ha due vertici a cui è attaccato, chiamati i suoi "punti finali (endpoints)".

Due vertici sono chiamati "adiacenti (adjacent)" se sono punti finali dello stesso arco.

Gli "archi in uscita (outgoing edges)" di un vertice sono archi diretti di cui il vertice è l'origine.

Gli "archi in entrata (ingoing edges)" di un vertice sono archi diretti di cui il vertice è la destinazione.

Il "grado (degree)" di un vertice in un grafo è il numero totale di archi incidenti su di esso.

In un grafo orientato, il "grado esterno (out-degree)" di un vertice è il numero totale di archi uscenti e il "grado interno (in-degree)" è il numero totale di archi entranti.

Un vertice con zero di grado è chiamato "vertice sorgente (source vertex)", mentre un vertice con zero di grado esterno è chiamato "vertice sink (sink vertex)".

Un "vertice isolato (isolated vertex)" è un vertice con grado zero, che non è un punto finale di un arco.

"Percorso (path)" è una sequenza di vertici e archi alternati in modo tale che ogni arco colleghi ogni vertice successivo.

"Ciclo (cycle)" è un percorso che inizia e finisce nello stesso vertice.

"Percorso semplice (simple path)" è un percorso con vertici distinti.

Un grafo è "fortemente connesso (strongly connected)" se contiene un cammino orientato da u a v e un cammino orientato da v a u per ogni coppia di vertici u, v.

Un grafo orientato è detto "debolmente connesso (weakly connected)" se la sostituzione di tutti i suoi archi orientati con archi non orientati produce un grafo connesso (non orientato). I vertici in un grafo debolmente connesso hanno un grado esterno o un grado interno di almeno 1.

"Componente connesso (connected component)" è il sottografo connesso massimale di un grafo non connesso.

Un "ponte (bridge)" è un arco la cui rimozione disconnetterebbe il grafo.

"Foresta (forest)" è un grafo senza cicli.

"Albero (tree)" è un grafo connesso senza cicli. Se rimuoviamo tutti i cicli da DAG (grafo aciclico diretto), diventa un albero e se rimuoviamo qualsiasi arco in un albero, diventa una foresta.

"Albero di copertura (spanning tree)" di un grafo non orientato è un sottografo che è un albero che include tutti i vertici del grafo.

D) Relazione tra numero di archi e vertici
------------------------------------------

Per un grafo semplice con m bordi e n vertici, se il grafo è

diretto, allora m = n*(n-1)

non orientato, allora m = n*(n-1)/2

connesso, allora m = n-1

un albero, allora m = n-1

una foresta, allora m = n-1

completo, allora m = n*(n-1)/2

Pertanto, O(m) può variare tra O(1) e O(n^2), a seconda di quanto è denso il grafo.

E) Rappresentazione dei grafi
-----------------------------

1. Rappresentazione con matrice di adiacenza
--------------------------------------------
Una matrice di adiacenza è una matrice quadrata utilizzata per rappresentare un grafo finito. Gli elementi della matrice indicano se le coppie di vertici sono adiacenti o meno nel grafo.
Definizione:
Per un semplice grafo non pesato con insieme di vertici V, la matrice di adiacenza è un quadrato |V| × |V| matrice A tale che il suo elemento:

A(i j) = 1, quando c'è un arco dal vertice i al vertice j, e
A(i j) = 0, quando non c'è un arco.

Ogni riga nella matrice rappresenta i vertici di origine e ogni colonna rappresenta i vertici di destinazione. Gli elementi diagonali della matrice sono tutti zero poiché i bordi da un vertice a se stesso, cioè i cicli non sono consentiti nei grafi semplici. Se il grafo non è orientato, la matrice di adiacenza sarà simmetrica. Inoltre, per un grafo ponderato, Aij può rappresentare i pesi degli archi.

Esempio di matrice di adiacenza di un grafo orientato

          ╔═══╗
          ║ 0 ║
          ╚═══╝             ╔═══╗
        ■      \            ║ 4 ║
       /        \           ╚═══╝             |0 1 0 0 0 0|
      /          ■            ■               |0 0 1 0 0 0|
  ╔═══╗           ╔═══╗       |               |1 1 0 0 0 0|
  ║ 2 ║■---------■║ 1 ║       |               |0 0 1 0 0 0|
  ╚═══╝           ╚═══╝       |               |0 0 0 0 0 1|
       ■                      ■               |0 0 0 0 1 0|
        \                   ╔═══╗
         \                  ║ 5 ║
          ╔═══╗             ╚═══╝
          ║ 3 ║
          ╚═══╝

Una matrice di adiacenza mantiene un valore (1/0/arco-peso) per ogni coppia di vertici, indipendentemente dal fatto che l'arco esista o meno, quindi richiede n^2 spazi. Può essere utilizzata in modo efficiente solo quando il grafo è denso.

2. Rappresentazione con una lista delle adiacenze
-------------------------------------------------
Una rappresentazione del grafo con una lista delle adiacenze associa ciascun vertice nel grafo alla raccolta dei suoi vertici o archi vicini, ovvero ogni vertice memorizza un elenco di vertici adiacenti. Esistono molte varianti della rappresentazione con una lista delle adiacenze a seconda dell'implementazione. Questa struttura dati consente la memorizzazione di dati aggiuntivi sui vertici ed è molto efficiente quando il grafo contiene solo pochi archi (cioè il grafo è rado (sparse)).

Esempio di lista delle adiacenze di un grafo orientato

          ╔═══╗
          ║ 0 ║
          ╚═══╝             ╔═══╗
        ■      \            ║ 4 ║
       /        \           ╚═══╝
      /          ■            ■
  ╔═══╗           ╔═══╗       |
  ║ 2 ║■---------■║ 1 ║       |
  ╚═══╝           ╚═══╝       |
       ■                      ■
        \                   ╔═══╗
         \                  ║ 5 ║
          ╔═══╗             ╚═══╝
          ║ 3 ║
          ╚═══╝

lista = ((0 (1)) (1 (2)) (2 (0 1)) (3 (2)) (4 (5)) (5 (4)))


---------------------------
Lanciare N volte una moneta
---------------------------

Lanciando una moneta equa N volte, qual'è la probabilità che gli ultimi due risultati siano uguali?

Se la moneta è equa, cioè i suoi risultati hanno una distribuzione uniforme, allora i lanci da i a (N-2) non hanno importanza. Dobbiamo considerare solo gli ultimi due lanci e possiamo farlo in due modi.

1) Teorema della probabilità composta, la probabilità che due eventi indipendenti accadano insieme è pari al prodotto delle probabilità dei singoli eventi:

  P(2T) = P(T) * P(T) = 1/2 * 1/2 = 1/4 = 25%

La probabilità che due risultati siano due Teste vale il prodotto delle singole probabilità.
Poichè anche due croci sono risultati uguali dobbiamo aggiungere anche questo caso alla probabilità totale:

  P(2C) = P(C) * P(C) = 1/2 * 1/2 = 1/4 = 25%

Quindi la probabilità totale vale:

  P(2uguali) = P(2C) + P(2B) = 1/4 + 1/4 = 1/2 = 50%

2) Teorema fondamentale della probabilità, la brobabilità di un evento è data dal rapporto tra casi favorevoli e casi possibili:

           numero casi favorevoli
  P(E) = --------------------------
           numero casi possibili

Nel nostro caso abbiamo:
casi possibili  = 4: (T T), (T C), (C T), (C C) = 4
casi favorevoli = 2: (T T) (C C)

  P(2uguali) = 2/4 = 1/2 = 50%

Per gli scettici come me scriviamo una funzione:

(define (flip-coin num)
  (local (val a b)
    (for (i 1 num)
      (setq val (rand 2))
      (cond ((= i (- num 1)) (setq a val))
            ((= i (- num 2)) (setq b val))
      )
    )
    (= a b)))

(for (i 1 10) (print (flip-coin 10) { }))
;-> nil true nil nil true nil true true nil nil

(define (test-coin num iter)
  (let (out 0)
    (for (i 1 iter)
      (if (flip-coin num) (++ out))
    )
    (div out iter)))

(test-coin 10 10000)
;-> 0.5011
(test-coin 100 100000)
;-> 0.50122
(test-coin 100 1000000)
;-> 0.499789


-----------------------------------------------
Problema dei fiammiferi di Banach con N scatole
-----------------------------------------------

Una persona ha N scatole di fiammiferi nello zaino ognuna contenente M fiammiferi.
Ogni volta che ha bisogno di un fiammifero lo prende da una delle N scatole (cioè, ha la stessa probabilità di scegliere una delle N scatole).
Ad un certo punto (N-1) scatole saranno diventate vuote: in media, quanti fiammiferi ci sono nell'unica scatola rimasta?
Una scatola è considerata vuota quando viene selezionata e contiene 0 fiammiferi.
Ci sono due modi di simulare il problema a seconda del seguente comportamento:
1) le scatole vuote non vengono gettate e quindi possono essere riselezionate
2) le scatole vuote vengono gettate e quindi non possono essere riselezionate

Vediamo di scrivere un programma che simula il primo caso:

(setq n 5 m 10)

Funzione che verifica se esistono fiammiferi da estrarre dalle scatole:

(define (exist-fiam fiam)
  (let (conta 0)
    (dolist (f fiam)
      ; scatola vuota = -1
      (if (= f -1)
          (++ conta)))
    ; se tutti gli elementi (tranne uno) valgono -1,
    ; allora non esistono fiammiferi da estrarre
    (!= conta (- (length fiam) 1))))

(exist-fiam '(-1 3 -1 -1 -1))
;-> nil
(exist-fiam '(-1 3 0 -1 -1))
;-> true
(exist-fiam '(-1 20 20 20 20 20 20 20 20 20 20))
;-> true
(exist-fiam '(-1 2))
;-> nil
(exist-fiam '(2))
;-> nil

Funzione che effettua una simulazione completa del processo di estrazione e calcola quanti fiammiferi rimangono nell'ultima scatola (quando le altre sono tutte vuote):

(define (banach1 n m)
  (local (fiam box-num)
    ; lista delle scatole
    ; vettore di n+1 elementi tutti con valore m
    (setq fiam (array (+ n 1) (list m)))
    ; (fiam 0) = -1
    (setf (fiam 0) -1)
    ; affinchè esistono fiammiferi da estrarre..
    (while (exist-fiam fiam)
       ; seleziona una scatola
      (setq box-num (+ (rand n) 1))
      ; se la scatola scelta non è vuota (-1)
      (if (!= (fiam box-num) -1)
          ; toglie un fiammifero dalla scatola
          (-- (fiam box-num))
      )
      ;(println fiam)
      ;(read-line)
    )
    ; cerca valore non uguale a -1
    ; nella lista/vettore delle scatole
    (catch
      (dolist (f fiam)
        (if (!= f -1) (throw f))
      ))))

(for (i 1 10) (print (banach1 5 10) { }))
;-> 3 1 1 1 2 0 2 1 1 0

Funzione che esegue la simulazione un determinato numero di volte e restituisce una lista con le frequenze dei fiammiferi rimasti:

(define (banach1-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach1 n m)))
    )
    out))

(setq sol (banach1-test 5 10 10000))
;-> (3184 2409 1871 1199 708 388 149 69 18 5 0)

Quindi, 3233 volte sono rimasti 0 fiammiferi, 2443 volte è rimasto 1 fiammifero, 1870 volte sono rimasti 2 fiammiferi, ... e 0 volte sono rimasti 10 fiammiferi.

Vediamo le percentuali di frequenza:

(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.84 24.09 18.71 11.99 7.08
;->  3.88 1.49 0.69 0.18 0.05 0)

Aumentiamo il numero di simulazioni:

(setq sol (banach1-test 5 10 1e6))
;-> (315275 248335 180842 120336 71935 37678 17220 6297 1711 334 37)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.5275 24.8335 18.0842
;->  12.0336 7.1935 3.7678
;->  1.722 0.6297 0.1711
;->  0.0334 0.0037)

(setq sol (banach1-test 5 10 1e7))
;-> (3146012 2488151 1814325 1205730 718858
;->  375560 168454 61827 17359 3412 312)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.46012 24.88151 18.14325
;->  12.0573 7.18858 3.7556
;->  1.68454 0.61827 0.17359
;->  0.03412 0.00312)

Adesso vediamo di simulare il secondo caso:

(define (banach2 n m)
  (local (fiam box-num b)
    ; lista delle scatole
    ; vettore di n+1 elementi tutti con valore m
    (setq fiam (array (+ n 1) (list m)))
    (setf (fiam 0) -1)
    ; lista delle scatole
    (setq box-num (sequence 1 n))
    ; affinchè ci sono almeno due scatole...
    (while (> (length box-num) 1)
      ; seleziona una scatola
      ; (un numero casuale da 1 al numero delle scatole)
      (setq b (first (select box-num (rand (length box-num)))))
      ; se il valore della scatola è zero,
      ; (non ci sono più fiammiferi)
      (if (= (fiam b) 0)
          ; allora rimuove la scatola
          (pop box-num (find b box-num))
          ; altrimenti toglie un fiammifero dalla scatola
          (-- (fiam b))
      )
    )
    ; il risultato è il numero di fiammiferi
    ; della scatola rimasta
    (fiam (first box-num))
    ))

(for (i 1 10) (print (banach2 5 10) { }))
;-> 0 2 2 0 0 1 3 0 5 0

Funzione che esegue la simulazione un determinato numero di volte e restituisce una lista con le frequenze dei fiammiferi rimasti:

(define (banach2-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach2 n m)))
    )
    out))

Facciamo alcune prove:

(setq sol (banach2-test 5 10 10000))
;-> (3129 2553 1783 1218 718 362 158 61 13 4 1)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.29 25.53 17.83 12.18 7.18 3.62 1.58 0.61 0.13 0.04 0.01)

(setq sol (banach2-test 5 10 1e6))
;-> (314822 248776 180943 121049 71350
;->  37623 16971 6254 1810 369 33)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.4822 24.8776 18.0943 12.1049 7.135
;->  3.7623 1.6971 0.6254 0.181 0.0369 0.0033)

(setq sol (banach2-test 5 10 1e7))
;-> (3145292 2489280 1814241 1205993 718267
;->  376016 168057 61812 17443 3292 307)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (31.45292 24.8928 18.14241 12.05993 7.182667
;->  3.76016 1.68057 0.61812 0.17443 0.03292 0.00307)

I due casi ottengono lo stesso risultato nelle simulazioni:

(map sub
 '(31.46012 24.88151 18.14325 12.0573 7.18858
   3.7556 1.68454 0.61827 0.17359 0.03412 0.00312)
 '(31.45292 24.8928 18.14241 12.05993 7.182667
   3.76016 1.68057 0.61812 0.17443 0.03292 0.00307))
;-> (0.007200000000000983 -0.01129000000000247 0.0008399999999966212
;->  -0.00262999999999991 0.005912999999999613 -0.00456000000000012
;->  0.003970000000000029 0.0001499999999999835 -0.0008400000000000074
;->  0.0012 5.000000000000013e-005)

Verifichiamo che questa funzione sia congruente con i risultati ottenuti nel paragrafo "Problema dei fiammiferi di Banach" con due scatole:

  (8.8874 8.9236 8.756500000000001 8.5153 8.262600000000001
  7.7165 7.2776 6.6639 6.0641 5.3545 4.7031 4.0201 3.3735
  2.7765 2.2529 1.7751 1.3587 1.0171 0.7549 0.5440999999999999
  0.3697 0.2397 0.1619 0.1025 0.05860000000000001 0.0335 0.0198
  0.0086 0.0043 0.0021 0.0006000000000000001 0.0004 9.999999999999999e-005
  9.999999999999999e-005 9.999999999999999e-005 0 0 0 0 0 0)

(setq sol (banach2-test 2 40 1e6))
;-> (88666 88925 87689 85645 82462 78072 73074 67090
;->  60151 53463 46363 40217 33591 27990 22455 17826
;->  13485 10417 7356 5314 3657 2327 1546 944 597 309
;->  203 82 46 23 9 3 1 2 0 0 0 0 0 0 0)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (8.8666 8.8925 8.7689 8.564500000000001 8.2462
;->  7.8072 7.3074 6.709 6.0151 5.3463 4.6363 4.0217 3.3591
;->  2.799 2.2455 1.7826 1.3485 1.0417 0.7355999999999999 0.5314
;->  0.3657 0.2327 0.1546 0.0944 0.0597 0.0309 0.0203
;->  0.008200000000000001 0.0046 0.0023 0.0009 0.0003 9.999999999999999e-005
;->  0.0002 0 0 0 0 0 0 0)

Le due soluzioni sono congruenti.

Per finire vediamo un modo alternativo di selezionare i fiammiferi dalle scatole.
Possiamo creare una lista con tutti i valori possibili del nostro universo che è rappresentato dalle estrazioni di un fiammifero da una delle scatole a disposizione. Supponiamo di avere N scatole con M fiammiferi, allora il nostro universo vale N volte la lista (1 2 ... M):

                      (x M volte)
  (1 2 ... N) (1 2 ... N) ... (1 2 ... N) =

= (1 1 ... 1) (2 2 ... 2) ... (N N ... N)
   (M volte)

Cioè dobbiamo estrarre M volte la scatola X per estrarre tutti i fiammiferi. Mettendo insieme tutti i valori possibili otteniamo una lista del tipo:

(1 1 .. 1 2 2 .. 2 ... N N .. N)

Un esempio chiarisce meglio il concetto:

(setq n 3 m 5)
(setq rnd (randomize (flat (dup (sequence 1 n) (+ m 1)))))
;-> (3 1 2 2 1 3 3 3 3 1 3 1 2 1 1 2 2 2)

Questa lista rappresenta l'ordine (casuale) con cui devono essere estratti i fiammiferi dalle scatole: scatola 3, poi 1, poi 2, ecc. e infine rimane la scatola 2.
Abbiamo usato (m+1) perchè la scatola deve arrivare a -1 e non a 0 per essere considerata vuota.
In questo caso il numero di fiammiferi rimasti nell'ultima scatola è pari al numero di valori uguali consecutivi in "rnd" (partendo dal fondo) meno uno. Ad esempio nel caso precedente abbiamo 3 valori uguali (2) alla fine di "rnd", quindi ci sono (3 - 1) = 2 fiammiferi rimasti nell'ultima scatola.

(define (banach3 n m)
  (local (rnd fiam box idx conta)
    ; creazione di tutte le estrazioni casuali
    (setq rnd (randomize (flat (dup (sequence 1 n) (+ m 1)))))
    ; ultima scatola da estrarre
    (setq box (rnd -1))
    ; posizione indice
    (setq idx -2)
    ; numero fiammiferi rimasti nell'ultima scatola
    (setq conta 0)
    (while (= (rnd idx) box)
      ; aggiorna indice
      (-- idx)
      ; aumenta numero di fiammiferi
      (++ conta)
    )
    conta))

(define (banach3-test n m iter)
  (local (out)
    (setq out (array (+ m 1) '(0)))
    (for (i 1 iter)
      (++ (out (banach3 n m)))
    )
    out))

(setq sol (banach3-test 5 10 10000))
;-> (8137 1543 277 36 6 1 0 0 0 0 0)
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (81.37000000000001 15.43 2.77 0.36 0.06 0.01
;->  0 0 0 0 0)

(setq sol (banach3-test 5 10 1e6))
;-> (814717 153676 26567 4410 565 57 7 1 0 0 0))
(map (fn(x) (mul 100 (div x (apply + sol)))) sol)
;-> (81.4717 15.3676 2.6567 0.441 0.0565 0.0057
;->  0.0007 9.999999999999999e-005 0 0 0)

In questo caso i risultati sono diversi dalle prime due simulazioni perchè la funzione di casualità viene applicata a tutta la simulazione e non ad ogni singolo passo della simulazione (cioè ad ogni estrazione di un fiammifero).


-----------------------------------------------------
Conflitti read-write nelle transazioni di un database
-----------------------------------------------------

Dato un elenco di transazioni di database, trovare tutti i conflitti di lettura-scrittura tra di loro. Si supponga che non esista un protocollo (es. Strict 2PL) per prevenire conflitti di read-write (lettura-scrittura).

Ogni transazione del database è data sotto forma di tupla. La tupla ('T', 'A', 't', 'R') indica che una transazione T ha avuto accesso a un record del database A all'istante t e che viene eseguita un'operazione di lettura R sul record.

Supponiamo che si verifichi un conflitto di dati quando due transazioni accedono allo stesso record nel database entro un intervallo di 5 unità. Sul record viene eseguita almeno un'operazione di scrittura.

Per esempio, il seguente gruppo di transazioni di input:

  (T1, A, 0, R)
  (T2, A, 2, W)
  (T3, B, 4, W)
  (T4, C, 5, W)
  (T5, B, 7, R)
  (T6, C, 8, W)
  (T7, A, 9, R)

Dovrebbe produrre il seguente output:

  Le transazioni T1 e T2 sono coinvolte nel conflitto RW
  Le transazioni T3 e T5 sono coinvolte nel conflitto WR
  Le transazioni T4 e T6 sono coinvolte nel conflitto WW

Breve panoramica sui conflitti di lettura-scrittura
---------------------------------------------------
Nei database può verificarsi un conflitto di dati durante un'operazione di lettura o scrittura da parte delle diverse transazioni sugli stessi dati durante la vita della transazione, portando a uno stato finale del database incoerente. Esistono tre tipi di conflitti di dati coinvolti nelle transazione di un database.

1) Conflitto tra scrittura e lettura (WR) (lettura sporca)
----------------------------------------------------------
Questo conflitto si verifica quando una transazione legge i dati scritti dall'altra transazione, ma non ancora confermati.

2) Conflitto di lettura-scrittura (RW)
--------------------------------------
Questo conflitto si verifica quando una transazione scrive i dati che sono stati precedentemente letti dall'altra transazione.

3) Conflitto di scrittura-scrittura (WW) (operazione di scrittura cieca)
------------------------------------------------------------------------
Questo conflitto si verifica quando i dati aggiornati da una transazione vengono sovrascritti da un'altra transazione che potrebbe portare alla perdita dell'aggiornamento dei dati.
Si noti che non vi è alcun conflitto di lettura-lettura (RR) nel database poiché nessuna informazione viene aggiornata nel database durante l'operazione di lettura.

Per risolvere il nostro problema, l'idea è di ordinare tutte le transazioni in ordine crescente di record del database e del relativo tempo di accesso. Per ogni record del database, considerare tutte le coppie di transazioni che hanno avuto accesso al record corrente entro un intervallo di 5 unità. Infine, memorizziamo tutte le coppie di transazioni in conflitto per le quali viene eseguita almeno un'operazione di scrittura sul record corrente.

(define (check-conflict transaction)
  (local (tr out)
    (setq tr '() out '())
    ; per ogni transazione Tx sposta
    ; il nome della transazione all'ultimo posto
    (dolist (t transaction)
      (setq el (select t '(1 2 3 0)))
      (push el tr -1)
    )
    ; ordina le transazioni per record e tempo di accesso
    (sort tr)
    ; ricerca dei conflitti nelle operazioni di lettura e scrittura
    (for (i 0 (- (length tmp) 1))
      (setq j (- i 1))
      (while (and (>= j 0) (= (tmp i 0) (tmp j 0)) (<= (tmp i 1) (+ 5 (tmp j 1))))
        ; per l'esistenza di un conflitto,
        ; almeno una operazione deve essere di scrittura (W)
        (if (or (= 'W (tmp i 2)) (= 'W (tmp j 2)))
            (push (list (tmp j) (tmp i)) out -1)
        )
        (-- j)
      )
    )
    out))

Proviamo la funzione:

(setq transact '(
  (T1 A 0 R)
  (T2 A 2 W)
  (T3 B 4 W)
  (T4 C 5 W)
  (T5 B 7 R)
  (T6 C 8 W)
  (T7 A 9 R)))

(check-conflict transact)
;-> (((A 0 R T1) (A 2 W T2))
;->  ((B 4 W T3) (B 7 R T5))
;->  ((C 5 W T4) (C 8 W T6)))

Le transazioni T1 e T2 sono coinvolte nel conflitto RW.
Le transazioni T3 e T5 sono coinvolte nel conflitto WR.
Le transazioni T4 e T6 sono coinvolte nel conflitto WW.


-----------------------------------
Unico elemento diverso in una lista
-----------------------------------

Dato una lista di interi in cui tutti gli elementi sono uguali tranne uno, trovare l'unico elemento diverso nella lista.

Esempi:
Input: lst = (10 10 10 20 10 10)
Output: 20

Input: lst = (30 10 30 30 30)
Output: 10

Una soluzione semplice è attraversare la lista. Per ogni elemento, controllare se è diverso dagli altri o meno. La complessità temporale di questa soluzione sarebbe O(n^2)
Una soluzione migliore è usare l'hashing. Contiamo le frequenze di tutti gli elementi. La tabella hash avrà due elementi. La soluzione è l'elemento con valore (o frequenza) uguale a 1. Questa soluzione opera in tempo O(n), ma richiede O(n) spazio extra.
Una soluzione più efficiente consiste nell'iniziare a controllare i primi tre elementi. Ci possono essere due casi:
1) Due elementi sono uguali, cioè uno è diverso a seconda delle condizioni definite. In questo caso, l'elemento diverso è tra i primi tre, quindi restituiamo l'elemento diverso.
2) Tutti e tre gli elementi sono uguali. In questo caso, l'elemento diverso si trova nell'array rimanente. Quindi attraversiamo l'array dal quarto elemento e controlliamo semplicemente se il valore dell'elemento corrente è diverso dal precedente o meno.

Vediamo di implementare quest'ultimo metodo con una funzione che restituisce l'indice dell'elemento diverso.

(define (find-unique lst)
(catch
  (let (len (length lst))
    ; se la lista ha meno di due elementi,
    ; allora restituisce nil
    (cond ((= len 0) nil)
          ((= len 1) nil)
          ; se la lista ha due elementi,
          ; allora possiamo restituire l'indice 0 o l'indice 1
          ((= len 2) 0) ; oppure 1
          (true ; se la lista ha più di due elementi
            (cond ((and (= (lst 0) (lst 1)) (!= (lst 0) (lst 2))) throw 2)
                  ((and (= (lst 0) (lst 2)) (!= (lst 0) (lst 1))) throw 1)
                  ((and (= (lst 1) (lst 2)) (!= (lst 0) (lst 1))) throw 0)
                  (true
                    (for (i 3 (- len 1))
                      (if (!= (lst i) (lst (- i 1)))
                          (throw i)
                      )
                    )
                  )
            )
          )
    ))))

(find-unique '())
;-> nil
(find-unique '(1))
;-> nil
(find-unique '(3 1 1 1 1 1 1 1))
;-> 0
(find-unique '(1 3 1 1 1 1 1 1))
;-> 1
(find-unique '(1 1 3 1 1 1 1 1))
;-> 2
(find-unique '(1 1 1 1 1 1 3 1))
;-> 6


-----
1 o 2
-----

Scrivere una funzione che restituisce 1 quando viene passato 2 e restituisce 2 quando viene passato 1.

(define (f12a x)
  (if (= x 1) 2 1))

(f12a 1)
;-> 2
(f12a 2)
;-> 1

Scrivere la stessa funzione senza utilizzare la primitiva "if" o "cond".

(define (f12b x)
  (- 3 x))

(f12b 1)
;-> 2
(f12b 2)
;-> 1

Scrivere la stessa funzione senza utilizzare le operazioni aritmetiche elementari "+", "-", "*", "/".

(define (f12c x)
  (^ x 1 2))

(f12c 1)
;-> 2
(f12c 2)
;-> 1

Vediamo quale delle tre funzioni è la più veloce:

(time (f12a 2) 1e7)
;-> 685.196
(time (f12b 2) 1e7)
;-> 567.46
(time (f12c 2) 1e7)
;-> 610.196

Vedi anche "1 o 2 (again)" su "Note libere 10".


-------------------------------------------------
Generare tutte le coppie di elementi di una lista
-------------------------------------------------

Scrivere una funzione per generare tutte le coppie diverse degli elementi di una lista.
Per esempio, la lista (a b c) genera la lista di coppie ((a b) (a c) (b c)).
Nota: le coppie (a b) e (b a) sono uguali.

La funzione è abbastanza semplice:

(define (pair-bind lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (list (lst i) (lst j)) out -1)
      )
    )
    out))

(setq lst '(1 2 3 4 5))
(pair-bind lst)
;-> ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5))

Adesso possiamo usare questo risultato per calcolare, ad esempio, le somme delle coppie di elementi:

(map (fn(x) (+ (first x) (last x))) (pair-bind lst))
;-> (3 4 5 6 5 6 7 7 8 9)

Oppure possiamo scrivere una funzione simile a "pair-bind" per calcolare la somma delle coppie di elementi:

(define (pair-sum lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (+ (lst i) (lst j)) out -1)
      )
    )
    out))

(pair-sum lst)
;-> (3 4 5 6 5 6 7 7 8 9)

Notiamo che le due funzioni "pair-bind" e "pair-sum" sono uguali tranne la funzione che viene applicata ad ogni coppia di elementi, allora possiamo scrivere una funzione generica che prende come parametro la funzione da applicare (list, +, -, *, ecc.):

(define (pair-func f lst)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (push (f (lst i) (lst j)) out -1)
      )
    )
    out))

Vediamo di simulare la funzione "pair-bind":

(pair-func list lst)
;-> ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5))

Adesso la funzione "pair-sum":

(pair-func + lst)
;-> (3 4 5 6 5 6 7 7 8 9)

Calcoliamo la potenza di ogni coppia:

(pair-func pow lst)
;-> (1 1 1 1 8 16 32 81 243 1024)

Adesso un problema inverso, data una lista i cui elementi sono le coppie di elementi di un'altra lista, determinare la lista originale.
Per esempio, data la lista ((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5)), allora la lista originale vale (1 2 3 4 5).

(setq lst '((1 2) (1 3) (1 4) (1 5) (2 3) (2 4) (2 5) (3 4) (3 5) (4 5)))

(define (pair-inverse lst)
  (local (palo out)
    ; il primo valore è il palo (sentinella)
    (setq palo (lst 0 0))
    ; inserisce il primo valore
    (setq out (list palo))
    (dolist (el lst)
      ; se il valore è diverso,
      ; allora lo inserisce nella lista e
      ; aggiorna il valore del palo
      (if (!= (el 0) palo)
          (begin
          (setq palo (el 0))
          (push palo out -1))
      )
    )
    ; inserisce l'ultimo valore
    (push (lst -1 1) out -1)
  out))

(pair-inverse lst)
;-> (1 2 3 4 5)

Adesso un problema più complesso, data una lista i cui elementi sono la somma dele coppie di elementi di un'altra lista, determinare la lista originale.
Per esempio, data la lista (3 4 5 6 5 6 7 7 8 9), allora la lista originale vale (1 2 3 4 5).

In generale, la lista delle somme delle coppie della lista lst[0..n-1] vale (lst[0]+lst[1], lst[0]+lst[2], ..., lst[1]+lst[2], lst[1]+lst[3], ..., lst[2]+lst[3], lst[2]+lst[4], ..., lst[n-2]+lst[n-1]).

Supponiamo che la lista data sia "pair" e che ci siano n elementi nella lista originale. Se diamo un'occhiata ad alcuni esempi, possiamo osservare che lst[0] è la metà di pair[0] + pair[1] – pair[n-1]. Nota che il valore di pair[0] + pair[1] – pair[n-1] è (lst[0] + lst[1]) + (lst[0] + lst[2]) – (lst[1] + lst[2]). Una volta valutato lst[0], possiamo valutare altri elementi sottraendo lst[0]. Ad esempio lst[1] può essere valutato sottraendo lst[0] da pair[0], lst[2] può essere valutato sottraendo lst[0] da pair[1].
Possiamo ricavare la lunghezza della lista originale notando che è legata all'equazione dei numeri triangolari:

  (length pair) = (Triangular((length lst) - 1))
  Triangular(n) = n*(n-1)/2

dove:

  n = (length lst) - 1

quindi possiamo scrivere:

  (length (pair) = n*(n-1)/2 ==> 2*(length pair) = n*n - n

e ricavare n, cioè (length lst) - 1, risolvendo l'equazione di secondo grado:

(length lst) = (+ 1 (sqrt(1 + (8 * (length pair)))))/2

Adesso possiamo scrivere la funzione:

(define (pair-sum-inverse pair)
  (local (base len out)
    (setq out '())
    ; lunghezza della lista originale
    (setq len (/ (+ 1 (sqrt (+ 1 (* 8 (length pair))))) 2))
    ; valore base
    (setq base (/ (+ (pair 0) (pair 1) (- (pair (- len 1)))) 2))
    (push base out -1)
    (for (i 1 (- len 1))
      (push (- (pair (- i 1)) base) out -1)
    )
    out))

(pair-sum-inverse (pair-sum '(1 2 3 4 5)))
;-> (1 2 3 4 5)
(pair-sum-inverse (pair-sum '(1 2 3 4 5 6 7 8 9)))
;-> (1 2 3 4 5 6 7 8 9)
(pair-sum-inverse (pair-sum '(2 2 1 1 3 3 4 4 5)))
;-> (2 2 1 1 3 3 4 4 5)
(pair-sum-inverse (pair-sum '(2 1 2)))
;-> (2 1 2)


---------------------------------
Numero di partite nel Tic-Tac-Toe
---------------------------------

Quante partite diverse di Tic-Tac-Toe sono possibili?

http://www.se16.info/hgb/tictactoe.htm

Abbiamo 9 modi possibili per posizionare il primo segno, 8 modi per posizionare il secondo, 7 modi il terzo, ... e 1 per il nono. Quindi risulta 9*8*7*6*5*4*3*2*1 = 9! = 362880.

Ma nelle 362880 partite esistono anche quelle che dovrebbero essere terminate prima a causa della vittoria di uno dei due giocatori. Quindi le sole partite valide (cioè le partite che devono essere considerate terminate) sono quelle che terminano appena qualcuno ottiene tre simboli uguali in fila oppure quelle partite che hanno tutti le caselle riempite e senza nessun tris. Da notare che la partita di lunghezza minima ha 5 caselle occupate.
Possiamo trovare il numero totale di partite calcolando quante partite finiscono con cinque caselle, sei caselle, sette caselle, otto caselle e nove casella e poi sommando il tutto.

Nel caso di nove caselle ci sono due possibilità: o qualcuno ha vinto alla nona mossa, o è un pareggio senza tre di fila.

Supponiamo che il primo giocatore inizi con una X e il secondo usi una O.

Numero di partite che terminano alla quinta mossa
ci sono 8 linee di tre quadrati (tre verticali, tre orizzontali e due diagonali) e non importa in quale ordine sono state messe le tre X, e le due O potrebbero essere andate in due delle altre sei quadrati in qualsiasi ordine. Quindi abbiamo 8*3!*6*5 = 1440 partite che finiscono con una vittoria alla quinta mossa.

Numero di partite che terminano alla sesta mossa
ci sono ancora 8 righe di tre quadrati, e non importa in quale ordine sono state disposte le tre O, e le tre X avrebbero potuto essere inserite in tre degli altri sei quadrati in qualsiasi ordine (a condizione che le X siano non tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3!*6*5*4 = 5760 possibilità. Per tener conto della parentesi dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se si prende una riga particolare, ci sono solo altre due righe possibili , quindi dobbiamo escludere 6*3!*2*3! = 432 casi. Quindi stiamo guardando 5760-432 = 5328 partite che finiscono con una vittoria alla sesta mossa.

Numero di partite che terminano alla settima mossa
ci sono ancora 8 linee di tre quadrati, ma questa volta importa in quale ordine sono state poste le quattro X, poiché la quarta deve essere sulla linea, mentre le tre O potrebbero essere andate in tre delle altre cinque quadrati in qualsiasi ordine (a condizione che le O non siano tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3*6*3!*5*4*3 = 51840 possibilità. Per tener conto della parentesi dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se una determinata riga viene presa con X, ci sono solo altre due possibili righe di cui una ha una X, quindi dobbiamo escludere 6*3*6*3!*3! = 3888 casi. Quindi abbiamo 51840-3888 = 47952 partite che finiscono con una vittoria alla settima mossa.

Numero di partite che terminano all'ottava mossa
ci sono di nuovo 8 linee di tre quadrati, ma anche in questo caso non importa in quale ordine sono state disposte le quattro O, poiché la quarta deve essere sulla linea, mentre le quattro X potrebbero essere andate in quattro delle altre cinque quadrati in qualsiasi ordine (a condizione che le X non siano tre di fila). Ignorando la frase tra parentesi, questo ci dà 8*3*6*3!*5*4*3*2 = 103680 possibilità. Per tener conto della condizione tra parentesi, dobbiamo escludere i casi in cui ci sono tre O di fila e tre X di fila: nessuna di esse può essere una diagonale, e se una determinata riga viene presa con O, ci sono solo altre due possibili righe di cui una ha una O e due posti rimanenti per una X, quindi dobbiamo escludere 6*3*6*3!*2*4! = 31104 casi. Quindi sono 103680-31104 = 72576 partite che finiscono con una vittoria all'ottava mossa.

Numero di partite che terminano alla nona mossa
Questo potrebbe essere facilmente calcolato sottraendo le possibilità già coperte da 9!. Ma lo terremo da parte per un controllo finale e useremo la forza bruta. La partita potrebbe concludersi con una vittoria o un pareggio, e li calcoleremo entrambi.

Per vincere, ci sono molte di possibilità:
non solo dobbiamo assicurarci che non ci siano tre O in fila prima che la quinta X sia posizionata, ma anche che non ci sia già una linea distinta di tre X in fila. Per prima cosa consideriamo una vittoria che coinvolge solo una diagonale: ce ne sono due e la quinta X deve essere sulla diagonale. Questo significa che le altre due X possono trovarsi solo in 8 delle restanti 15 possibili coppie di quadrati fuori dalla diagonale: questo porta a 2*3*8*4!*4! = 27648 possibilità. In secondo luogo consideriamo una vincita che coinvolge solo un tre di fila verticale o orizzontale: le altre due X possono essere in 10 delle restanti 15 possibili coppie di quadrati fuori dalla fila per evitare altri tre X di fila, solo 4 su 10 evitano tre O di fila, ancora la quinta X deve trovarsi nella riga desiderata, questo porta a 6*3*4*4!*4! = 41472 possibilità. Terzo,bisogna considerare la possibilità che la quinta X completi due distinti tre di fila dove si intersecano: ci sono 22 possibili coppie di tre intersecanti di fila, la quinta X deve essere l'intersezione, questo porta a 22*1*4!*4! = 12672 possibilità. Quindi stiamo guardando 27648+41472+12672 = 81792 possibilità di partite che terminano con una vittoria alla nona mossa.

Per un pareggio:
ci sono un totale di 16 possibili modelli per le cinque X e quattro O che non hanno tre simboli in fila (ci sono tre modelli di base che aumentano a 8+4+4 con riflessioni e rotazioni). Quindi abbiamo 16*5!*4! = 46080 possibilità di partite che finiscono in parità alla nona mossa.

Quindi in totale abbiamo 81792+46080 = 127872 partite che durano fino alla nona mossa.

Controllo sul calcolo
Avremmo potuto calcolare la possibilità della nona mossa come 9! -4!*(quinta mossa vince) -3!*(sesta mossa vince) -2!*(settima mossa vince) -1!*(otto mossa vince) = 362880-24*1440-6*5328-2*47952 -1*72576 = 127872. Questo è lo stesso risultato di prima, quindi nonostante la possibilità di errori di compensazione, possiamo avere una certa fiducia nel risultato.

Quanti giochi di Tic-Tac-Toe (zero e croci) sono possibili?
Sommando tutte queste cifre si ottiene il risultato desiderato: 1440+5328+47952+72576+81792+46080 = 255168 possibili partite in totale .

Questa tabella riporta i risultati:

  Mosse            Partite         %
--------------------------------------
  Vittoria in 5     1440          0,6%
  Vittoria in 6     5328          2,1%
  Vittoria in 7    47952         18,8%
  Vittoria in 8    72576         28,4%
  Vittoria in 9    81792         32,1%
  Pareggio         46080         18,1%
--------------------------------------
  Totale           255168       100.0%

Comunque se entrambi i giocatori giocano in modo perfetto, allora le partite terminano sempre in pareggio.

Vediamo di implementare una simulazione.
Generiamo tutte le permutazioni delle 9 mosse.
Per ogni permutazione giochiamo la partita e vediamo come finisce, ad esempio, la permutazione/partita (2 7 6 5 1 4 9 3 8) si gioca nel modo seguente:
X occupa la casella 2
fine partita? (-1 X -1 -1 -1 -1 -1 -1 -1)
O occupa la casella 7
fine partita? (-1 X -1 -1 -1 -1 O -1 -1)
X occupa la casella 6
fine partita? (-1 X -1 -1 -1 X O -1 -1)
O occupa la casella 5
fine partita? (-1 X -1 -1 O X O -1 -1)
...
Per ogni partita memorizziamo il risultato e mettiamo la posizione finale in una lista.

Scriviamo alcune funzioni.

Generate tutte le permutazioni senza ripetizioni:

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
    )
    out))

(length (perm '(1 2 3 4 5 6 7 8 9)))
;-> 362880

(silent (setq all-game (perm '(1 2 3 4 5 6 7 8 9))))
(all-game 21)
;-> (4 2 3 1 5 6 7 8 9)

Funzione che controlla se e come è terminata una partita:

(define (game-over? pos)
          ; controllo righe
    (cond ((or (and (!= (pos 0) -1) (= (pos 0) (pos 1) (pos 2)))
               (and (!= (pos 3) -1) (= (pos 3) (pos 4) (pos 5)))
               (and (!= (pos 6) -1) (= (pos 6) (pos 7) (pos 8))))
           '1)
          ; controllo colonne
          ((or (and (!= (pos 0) -1) (= (pos 0) (pos 3) (pos 6)))
               (and (!= (pos 1) -1) (= (pos 1) (pos 4) (pos 7)))
               (and (!= (pos 2) -1) (= (pos 2) (pos 5) (pos 8))))
           '1)
          ; controllo diagonali
          ((or (and (!= (pos 0) -1) (= (pos 0) (pos 4) (pos 8)))
               (and (!= (pos 2) -1) (= (pos 2) (pos 4) (pos 6))))
           '1)
          ; controllo caselle tutte occupate (partita terminata patta)
          ((zero? (first (count '(-1) pos)))
           '0)
          ; partita non finita
          (true '2)))

(setq pos '(1 0 1
            0 0 1
            0 1 -1))
(game-over? pos)
;-> 2
(setq pos '(1 0 1
            0 0 1
            0 1 0))
(game-over? pos)
;-> 0
(setq pos '(1 1 1
            0 -1 -1
            0 -1 -1))
(game-over? pos)
;-> 1
(setq pos '(0 1 1
            0 1 -1
            0 -1 1))
(game-over? pos)
;-> 1
(setq pos '(0 1 1
            1 1 -1
            0 -1 1))
(game-over? pos)
;-> 2
(setq pos '(-1 1 1
            1 -1 -1
            0 -1 -1))
(game-over? pos)
;-> 2

Funzione che gioca una posizione (per esempio (8 7 2 3 5 4 1 9 6)):

(define (play pos)
  (local (cur res stop)
    (setq cur (dup -1 9))
    (for (i 0 3)
      (if (even? i)
          (setf (cur (- (pos i) 1)) '1)
          (setf (cur (- (pos i) 1)) '0)
      )
    )
    ;(println "partita iniziale: ")
    ;(print-board cur)
    ;(read-line)
    (for (i 4 8 1 stop)
      (if (even? i)
          (setf (cur (- (pos i) 1)) '1)
          (setf (cur (- (pos i) 1)) '0)
      )
      ; res -> (1=win 0=draw 2=play)
      (setq res (game-over? cur))
      ;(println "partita attuale: ")
      ;(print-board cur)
      ;(println "risultato: " res)
      ;(read-line)
      (cond ((or (= res 1) (= res 0))
             (setq stop true)
             (if (= res 1) (push cur out -1))
             (++ (freq res)))
            ((= res 2) nil)
            (true (println "error:" res))
      ))))

Funzione che stampa una posizione:

(define (print-board pos)
  (println (format "%2d %2d %2d" (pos 0) (pos 1) (pos 2)))
  (println (format "%2d %2d %2d" (pos 3) (pos 4) (pos 5)))
  (println (format "%2d %2d %2d" (pos 6) (pos 7) (pos 8))))

(print-board pos)
;->  1  1  1
;->  0 -1 -1
;->  0 -1 -1

Nota: per provare la funzione play occorre definire: (setq freq '(0 0))

Funzione che gestisce tutta la simulazione:

(define (num-ttt)
  (local (freq out)
    (setq out '())
    (setq freq '(0 0))
    (setq all-game (perm '(1 2 3 4 5 6 7 8 9)))
    (dolist (game all-game)
      (play game)
    )
    (println freq)
    out))

(silent (setq allwin (num-ttt)))
;-> (46080 316800)

(allwin 1)
;-> (0 1 1 0 1 0 1 -1 -1)

(print-board (allwin 1))
;->  0  1  1
;->  0  1  0
;->  1 -1 -1

(game-over? (allwin 1))
;-> 1

(length allwin)
;-> 316800

Adesso contiamo le vittorie in base al numero delle mosse (5,6,7,8 o 9):

(define (contawin lst)
  (local (fwin num)
    (setq fwin '(0 0 0 0 0 0 0 0 0 0))
    (dolist (el lst)
      ; conta quanti -1 esistono nella posizione
      ; e poi aggiorna la lista delle frequenza
      (setq num (- 9 (first (count '(-1) el))))
      (++ (fwin num))
    )
    fwin))

(contawin allwin)
;-> (0 0 0 0 0 34560 31968 95904 72576 81792)

Questo significa che tra tutte le partite vinte:

34560 partite terminano in 5 mosse
31968 partite terminano in 6 mosse
95904 partite terminano in 7 mosse
72576 partite terminano in 8 mosse
81792 partite terminano in 9 mosse

Ricordiamo dal Controllo del calcolo precedente che risulta:

(* 24 1440)
;-> 34560
(* 6 5328)
;-> 31968
(* 2 47952)
;-> 95904
(* 1 72576)
;-> 72576
(* 1 81792)
;-> 81792

Numero di partite patte:

(- 362880 (+ 34560 31968 95904 72576 81792))
;-> 46080

Nota: una posizione finale può derivare da molte partite diverse.

Quindi le posizioni della lista allwin contengono anche molte posizioni doppie. Vediamo di calcolare solo le posizioni finali univoche:

(setq allvalidwin (unique allwin))

(length allvalidwin)
;-> 942

Adesso contiamo le vittorie delle posizioni finali uniche in base al numero delle mosse (5,6,7,8 o 9):

(contawin allvalidwin)
;-> (0 0 0 0 0 120 148 444 168 62)

Questo significa che ci sono:

120 posizioni finali univoche di vittoria in 5 mosse
148 posizioni finali univoche di vittoria in 6 mosse
444 posizioni finali univoche di vittoria in 7 mosse
168 posizioni finali univoche di vittoria in 8 mosse
 62 posizioni finali univoche di vittoria in 9 mosse

Vedi anche "Tic-Tac-Toe" su "Note libere 3".
Vedi anche "Posizioni finali del tic-tac-toe" su "Note libere 22".


---------------------------
Estrazione dati da file PDF
---------------------------

Questo esempio è tratto da un problema reale. Dato un file PDF con la struttura simile a quella del file "db.pdf" (disponibile nella cartella "data") occorre estrarre tutti i numeri ISBN che si trovano nel file.
Per convertire il file PDF in un file TXT ho utilizzato il software open-source "Xpdf" tools (https://www.xpdfreader.com/).

(define (find-isbn str)
  (setq out '())
  (setq lst (parse (replace "[^0-9]+" str " " 0)))
  (dolist (el lst)
    (if (> (length (int el 0 10)) 12)
      (push (int el 0 10) out -1)))
  out)

(define (isbn)
  ; extract text from pdf with xpdf tools
  ;(! "pdftotext.exe db.pdf" 0)
  (! "pdftotext.exe -table db.pdf" 0)
  (setq db (open "db.txt" "read"))
  ; search numbers with more than 12 digits
  (while (read-line db)
        (setq res (find-isbn (current-line)))
        ; print number
        (if res (println res))
  )
  (close db))

(real-path)
;-> "F:\\Lisp-Scheme\\newLisp\\MAX"
(change-dir "f:\\temp\\xpdf-tools-win-4.03\\bin64")
;-> true

(isbn)
;-> (9788835049371)
;-> (9788869105210)
;-> (9788826819907)
;-> (9788826819921)
;-> (9788848263948)
;-> (9788808520746)
;-> (9788808232953)
;-> (9788883394508)
;-> (9781108440387)
;-> (9781108465953)
;-> (9780194527897)
;-> (9788842115960)
;-> (9788808237347)
;-> (9788808172082)
;-> (9788857791302)
;-> true


--------------
Media continua
--------------

Per calcolare la media aritmetica di una lista di numeri possiamo usare la seguente funzione:

(define (media lst)
  (div (apply add lst) (length lst)))

Ma per calcolare la media di una lista di numeri che aumenta di dimensione possiamo utilizzare la seguente funzione:

(define (media-continua media val items)
  (div (add val (mul media items)) (+ items 1)))

(media '(1 2 3))
;-> 2

(media-continua 1 2 1)
;-> 1.5

(media-continua 1.5 3 2)
;-> 2

In questo modo possiamo calcolare la nuova media anche senza modificare la lista. Inoltre la funzione potrebbe essere usata come un generatore.


---------------------
Sequenza di Kolakoski
---------------------

L sequenza di Kolakoski è una sequenza infinita di simboli {1,2} che è la sequenza dei run-length del run-length encoding di se stessa.

Sequenza OEIS A000002: 1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 1,
                       2, 2, 1, 2, 1, 1, 2, 1, 2, 2, 1, 1, 2, 1, 1, 2, 1,
                       2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 2, 1, 2, 1, 1, 2, ...

La sequenza è stata discussa per primo da da Rufus Oldenburger nel 1939 e poi da Kolakoski nel 1965.

La successione di Kolakoski è una successione infinita di numeri naturali, (escluso lo zero) con la proprietà:

  se si forma una nuova sequenza dai conteggi delle ripetizioni dello stesso numero nella prima sequenza, questa nuova sequenza è uguale alla prima sequenza.

Esempio:

Questa non è una sequenza di Kolakoski:

1,1,2,2,2,1,2,2,1,2,...

La sua sequenza di conteggi delle ripetizioni, (simile alla codifica Run Length Encoding (RLE), ma una vera RLE fornisce anche il carattere codificato una sola volta), viene calcolata in questo modo:

Partendo dal numero più a sinistra della sequenza abbiamo 2 unità, seguite da 3 due, quindi 1 unità, 2 due, 1 uno, ...

Quanto sopra fornisce il RLE di:

2, 3, 1, 2, 1, ...

La sequenza originale è diversa dal suo RLE in questo caso. Sarebbe la stessa per una vera sequenza di Kolakoski.

Creazione di una sequenza di Kolakoski

Cominciamo con i due numeri (1, 2) che andremo a scorrere, cioè verranno utilizzati in questo ordine:

1,2,1,2,1,2,....

Iniziamo la sequenza s con il primo elemento del ciclo c:

1

Un indice, k, nella sequenza, (in espansione), passerà, o indicizzerà, attraverso ogni elemento della sequenza s dal primo, al proprio ritmo.

Faremo in modo che il k-esimo elemento di s indichi quante volte l'ultimo elemento di s dovrebbe apparire alla fine di s.

Abbiamo iniziato s con 1 e quindi s[k] afferma che dovrebbe apparire solo 1 volta.

Incremento k

Prendi l'elemento successivo da c e aggiungilo alla fine della sequenza s. s diventerà quindi:

1, 2

k è stato spostato al secondo elemento dell'elenco e s[k] afferma che dovrebbe apparire due volte, quindi aggiungi un altro dell'ultimo elemento alla sequenza s:

1, 2, 2

Incremento k

Aggiungi l'elemento successivo del ciclo all'elenco:

1, 2, 2, 1

k è ora al terzo elemento nell'elenco che indica che l'ultimo elemento dovrebbe apparire due volte, quindi aggiungi un'altra copia dell'ultimo elemento alla sequenza s:

1, 2, 2, 1, 1

incremento k

...

Nota che l'RLE di 1, 2, 2, 1, 1, ... inizia 1, 2, 2 che è l'inizio della sequenza originale. L'algoritmo di generazione garantisce che sarà sempre così.

Compito (rosetta-code):

Creare una funzione che, data una lista ordinata iniziale, ecc. dei numeri naturali (1, 2), restituisca il numero successivo dalla lista quando si accede in un ciclo.

Creare un'altra funzione che, data la lista ordinata iniziale (1, 2) e la lunghezza minima della sequenza da generare, usa la prima routine e l'algoritmo sopra, per generare almeno i primi membri richiesti della sequenza kolakoski.

Creare una funzione che, quando viene data una sequenza, crei la codifica della lunghezza di esecuzione di quella sequenza (come definita sopra) e restituisca il risultato del controllo se la sequenza inizia con i membri esatti del suo RLE. (Ma nota, a causa del campionamento, non confrontare l'ultimo membro del RLE).

Mostrare i primi 20 membri della sequenza generata da (1, 2).
Controllare la sequenza contro il suo RLE.

Mostrare i primi 20 membri della sequenza generata da (2, 1).
Controllare la sequenza contro il suo RLE.

Mostrare i primi 30 membri della sequenza Kolakoski generata da (1, 3, 1, 2)
Controlla la sequenza contro il suo RLE.

Mostrare i primi 30 membri della sequenza Kolakoski generata da (1, 3, 2, 1)
Controlla la sequenza contro il suo RLE.

(Ci sono regole sulla generazione di sequenze di Kolakoski da questo metodo che sono infrante dall'ultimo esempio).

Soluzione:

(define (next-in-cycle c idx)
  (c (% idx (length c))))

(define (kolakoski c len)
(catch
  (local (i j k clen slen)
    (setq i 0 j 0 k 0)
    (setq clen (length c))
    ;(setq slen (length s))
    (setq slen len)
    (while true
      (setf (s i) (next-in-cycle c k))
      (if (> (s k) 1)
          (for (j 1 (- (s k) 1))
            (++ i)
            ;(if (= i slen) (throw nil))
            (if (= i slen) (throw s))
            (setq (s i) (s (- i 1)))
          )
      )
      (++ i)
      ;(if (= i slen) (throw nil))
      (if (= i slen) (throw s))
      (++ k)
    ))))

(setq s (array 20 '(0)))
(kolakoski '(1 2) 20)
;-> (1 2 2 1 1 2 1 2 2 1 2 2 1 1 2 1 1 2 2 1)

(define (possible-kolakoski s)
  (local (i j prev cnt len rle res)
    (setq j 0 prev (s 0) cnt 1 len (length s))
    (setq rle '())
    (setq res true)
    (for (i 1 (- len 1))
      (if (= (s i) prev)
          (++ cnt)
          (begin
            (push cnt rle -1)
            (setq cnt 1)
            (setq prev (s i))
          )
      )
    )
    ;(println rle)
    ; non aggiunge il valore finale di 'cnt' a rle perché non viene mai confrontato
    ;(for (i 0 (- j 1) 1 (not res))
    (for (i 0 (- (length rle) 1) 1 (not res))
      (if (!= (rle i) (s i))
          (setq res nil)
      )
    )
    (println s)
    res))

(possible-kolakoski (kolakoski '(1 2) 20))
;-> (1 2 2 1 1 2 1 2 2 1 2 2 1 1 2 1 1 2 2 1)
;-> true

(possible-kolakoski (kolakoski '(2 1) 20))
;-> (2 2 1 1 2 1 2 2 1 2 2 1 1 2 1 1 2 2 1 2)
;-> true

(possible-kolakoski (kolakoski '(1 3 1 2) 20))
;-> (1 3 3 3 1 1 1 2 2 2 1 3 1 2 2 1 1 3 3 1)
;-> true

(possible-kolakoski (kolakoski '(1 3 2 1) 20))
;-> (1 3 3 3 2 2 2 1 1 1 1 1 3 3 2 2 1 1 3 2)
;-> nil

Funzione per calcolare la sequenza di kolakoski di lunghezza generica:

(define (kolakoski-seq start-lst len)
  (let (s (array len '(0)))
    (println (kolakoski start-lst len))
    ;(println (possible-kolakoski s))
  ))

(kolakoski-seq '(1 2) 20)
;-> (1 2 2 1 1 2 1 2 2 1 2 2 1 1 2 1 1 2 2 1)
(kolakoski-seq '(1 2) 30)
;-> (1 2 2 1 1 2 1 2 2 1 2 2 1 1 2 1 1 2 2 1 2 1 1 2 1 2 2 1 1 2)
(possible-kolakoski (kolakoski-seq '(1 3 1 2) 30))
;-> (1 3 3 3 1 1 1 2 2 2 1 3 1 2 2 1 1 3 3 1 2 2 2 1 3 3 1 1 2 1)
;-> true


----------------------------------------
Da stringa generica a stringa palindroma
----------------------------------------

Verificare se i caratteri di una data stringa possono essere riposizionati per formare una stringa palindroma.

Un insieme di caratteri può formare una stringa palindroma se, al massimo, un carattere si verifica un numero dispari di volte e tutti gli altri caratteri si verificano un numero pari di volte.

Il carattere dispari, se esiste, è quello che compare al centro della stringa palindroma.

Un metodo semplice è eseguire due cicli, il ciclo esterno seleziona tutti i caratteri uno per uno, il ciclo interno conta il numero di occorrenze del carattere selezionato tenendo traccia dei conteggi dispari. La complessità temporale di questa soluzione è O(n^2).
Possiamo farlo in tempo O(n) usando una lista di frequenze:

1) Creare una lista di frequenze di dimensioni alfabetiche (per i caratteri ASCII vale 256). Inizializzare tutti i valori della lista a 0.
2) Attraversare la stringa data e incrementare il conteggio di ogni carattere nella lista delle frequenze.
3) Attraversare la lista delle frequenze e se incontriamo più di un valore dispari, restituire nil. In caso contrario, restituire true.

(define (can-palindrome? str)
  (local (freq oddies)
    (setq freq (array 256 '(0)))
    (dostring (ch str)
      (++ (freq ch))
    )
    (setq oddies 0)
    (dolist (el freq)
      (if (odd? el) (++ oddies))
    )
    (< oddies 2)))

(can-palindrome? "pippo")
;-> nil
(can-palindrome? "mama")
;-> true
(can-palindrome? "presaelaserpe")
;-> true

Adesso vogliamo elencare tutte le stringhe palindrome che possono essere create quando il risultato vale true.

(define (make-palindrome? str)
  (local (freq oddies lst oddch oddnum)
    ; carattere dispari
    (setq oddch "")
    ; numero occorrenze carattere dispari
    (setq oddnum -1)
    ; lista dei caratteri pari
    (setq lst '())
    ; lista delle frequenze dei caratteri
    (setq freq (array 256 '(0)))
    ; calcola la frequenza dei caratteri di str
    (dostring (ch str)
      (++ (freq ch))
    )
    (setq oddies 0)
    ; verifica quanti caratteri dispari esistono,
    ; memorizza il carattere dispari e il numero di occorrenze
    ; crea la lista dei caratteri pari
    (dolist (el freq)
      (if (odd? el) (begin
          (++ oddies)
          (setq oddch (char $idx))
          (setq oddnum el))
          ;else
          (if (!= el 0)
            (for (i 1 el)
              (push (char $idx) lst -1)
            )
          )
      )
    )
    ; se i caratteri dispari sdono maggiori di 1
    ; allora restituisce nil
    (cond ((> oddies 1) nil)
          ; altrimenti calcola le stringhe palindrome
          (true (make-pali lst oddch oddnum)))))

La funzione "make-palindrome?" restituisce nil o chiama la funzione "make-pali" con i seguenti parametri:
  1) lista dei caratteri pari - lst
  2) carattere dispari - oddch
  3) occorrenze del carattere dispari - oddnum

Per calcolare le stringhe palindrome utilizziamo la funzione "anagrams" che calcola tutti gli anagrammi di una data stringa. Il metodo è il seguente:
prima di tutto la funzione "make-pali" aggiorna la lista dei caratteri pari con (oddnum -1) ripetizioni del carattere dispari, poi prendiamo solo i caratteri univoci. Ad esempio la stringa "pippoio" genera:

  lst = ("i" "i" "o" "o")
  oddch = "p"
  oddnum = 3

Quindi la lista lst viene aggiornata con (oddnum - 1) = 2 caratteri oddch = "p":

  lst = ("i" "i" "o" "o" "p" "p")

I caratteri univoci di lst sono: ("i" "o" "p").

Adesso le stringhe palindrome sono formate da un anagramma dei caratteri ("i" "o" "p") + il carattere oddch = "p" + l'inverso dell'anagramma iniziale, ad esempio il primo caso vale:

  "iop" + "p" + (reverse "iop") = "iop" + "p" + "poi" = "iopppoi"

Prima scriviamo la funzione per gli anagrammi:

(define (anagrams str)
  (map (fn (perm) (select str perm))
       (permute-aux (sequence 0 (- (length str) 1)))))
; auxiliary permutation function
(define (permute-aux lst)
  (if (= (length lst) 1)
   lst
   (apply append (map (fn (rot)
                      (map (fn (perm) (cons (first rot) perm))
                           (permute-aux (rest rot))))
                      (rotate-aux lst)))))
; auxiliary rotation function
(define (rotate-aux lst)
  (map (fn (x) (rotate lst)) (sequence 1 (length lst))))

Poi scriviamo la funzione "make-pali":

(define (make-pali lst oddch oddnum)
  (local (all-ana out)
  ;(println lst { } oddch { } oddnum)
  (setq out '())
  ; aggiunge (oddnum-1) caratteri oddch alla lista dei caratteri
  (if (> oddnum 2)
    (for (i 1 (- oddnum 1))
      (push oddch lst -1)
    )
  )
  ; creazione di tutti gli anagrammi delle mezze parole palindrome
  (setq all-ana (anagrams (join (unique lst))))
  (dolist (ana all-ana)
    ; oddch = "" se non esiste il carattere dispari
    (push (string ana oddch (reverse ana)) out -1)
  )
  out))

(make-palindrome? "pippoio")
;-> ("poipiop" "piopoip" "oipppio" "opipipo" "ipopopi" "iopppoi")
(make-palindrome? "pippo")
;-> nil
(make-palindrome? "mama")
;-> ("maam" "amma")

(make-palindrome? "iomassimo")
;-> ("somiaimos" "soimamios" "smioaoims" "smoiaioms" "siomamois"
;->  "simoaomis" "omisasimo" "omsiaismo" "oismamsio" "oimsasmio"
;->  "osmiaimso" "osimamiso" "misoaosim" "miosasoim" "msoiaiosm"
;->  "msioaoism" "moisasiom" "mosiaisom" "isomamosi" "ismoaomsi"
;->  "iomsasmoi" "iosmamsoi" "imsoaosmi" "imosasomi")
"isomamosi"


------------------------------------
Frasi e semplici regole grammaticali
------------------------------------

Una frase semplice è sintatticamente corretta se soddisfa determinate regole regole grammaticali. Di seguito sono riportate le regole della grammatica per il questo problema:

1. La frase deve iniziare con un carattere maiuscolo
2. Quindi segue il carattere minuscolo.
3. Devono esserci spazi tra le parole.
4. Quindi la frase deve terminare con un punto "." dopo l'ultima parola.
5. Non sono ammessi due spazi continui.
6. Non sono consentiti due caratteri maiuscoli continui.
7. Tuttavia, la frase può terminare dopo un carattere maiuscolo (da solo).

Esempi:

Frasi corrette:
   "Mi chiamo Eva."
   "Il vertice è A."
   "Sono a casa."
   "Mi piace newlisp."

Frasi errate:
   "Mi chiamo MAX."
   "Amo il cinema"
   "Forza. Andiamo."
   "Tu sei mio  amico."
   "Amo i libri ."

Scrivere una funzione che verifica se una frase è corretta rispetto alle precedenti regole grammaticali

Il problema può essere risolto utilizzando un automa/diagramma degli stati che rappresenta le nostre regole..

Algoritmo:

1. Controllare i casi ad inizio e fine frase (stringa)
  1.a) Controllare se il primo carattere è maiuscolo o meno nella frase.
  1.b) Controllare se l'ultimo carattere è un punto o meno.

2. Per il resto della stringa possiamo seguire il diagramma di stato rappresentato di seguito:

         [A-Z]
    +-------------+
    |             |
    |             ■
  ╔═══╗  space  ╔═══╗
  ║ 1 ║■--------║ 0 ║
  ╚═══╝         ╚═══╝
    |  ■          |  \
    |   \ space   |   \
    |    \        |    \
    |     \       |     \ [A-Z]
    |      \      |      \
    |       \     |       \
    |        \    | [a-z]  \ (.)
    |         \   |         \
    |          \  ■          ■
    |  [a-z]    ╔═══╗   (.)   ╔═══╗
    +----------■║ 2 ║--------■║ 3 ║
                ╚═══╝         ╚═══╝
                |   ■
                |   |
                +---+
                [a-z]

       Diagramma degli stati

3. Dobbiamo mantenere lo stato precedente e quello attuale dei diversi caratteri nella stringa. Sulla base di ciò possiamo sempre convalidare la frase di ogni carattere attraversato.

Di seguito è riportata un'implementazione basata su C. (A proposito, anche questa frase è corretta secondo la regola e il codice)

(define (check-grammar str)
(catch
  (local (len prev curr idx)
    (setq len (length str))
    ; Controlla che la frase inizi correttamente
    ; Check that the first character lies in [A-Z]
    (if (or (< (str 0) "A") (> (str 0) "Z"))
        (throw nil))
    ; Controlla che la frase termini correttamente
    ; Check if the last character is a full stop (.)
    (if (!= (str -1) ".")
        (throw nil))
    ; Inizializzazione degli stati da memorizzare
    (setq prev 0)
    (setq curr 0)
    ; Indice della stringa
    (setq idx 1)
    (while (< idx len)
      ; Set states according to the input characters
      ; in the string and the rule defined in the description.
            ; If current character is [A-Z], set current state as 0.
      (cond ((and (>= (str idx) "A") (<= (str idx) "Z"))
             (setq curr 0))
            ; If current character is a space, set current state as 1.
            ((= (str idx) " ")
             (setq curr 1))
            ; If current character is [a-z], set current state as 2.
            ((and (>= (str idx) "a") (<= (str idx) "z"))
             (setq curr 2))
            ; If current character is a dot, set current state as 3.
            ((= (str idx) ".")
             (setq curr 3))
      )
      ;;(println (str idx)) (read-line)
      ;;(println prev { } curr)
      ; Validates all current state with previous state
      ; for the rules in the description of the problem.
      (if (and (= prev curr) (!= curr 2))
          (throw nil))
      ;;(println prev { } curr)
      ;;(println "1") (read-line)
      (if (and (= prev 2) (= curr 0))
          (throw nil))
      ;;(println prev { } curr)
      ;;(println "2") (read-line)
      (if (and (= curr 3) (!= prev 1))
          (throw (= (+ idx 1) len)))
      ;;(println prev { } curr)
      ;;(println "3") (read-line)
      ; indice prossimo carattere
      (++ idx)
      ; aggiorna valore degli stati
      (setq prev curr)
    )
    nil)))

Proviamo la funzione:

(check-grammar "Viva la pasta.")
;-> true
(check-grammar "Mi chiamo Eva.")
;-> true
(check-grammar "Mi chiamo Eva")
;-> nil
(check-grammar "Mi chiamo Eva..")
;-> nil
(check-grammar "Mi chiamo EVA.")
;-> nil
(check-grammar "Mi chiamo evA.")
;-> nil
(check-grammar "Mi chiamo A.")
;-> true
(check-grammar "Amo i libri .")
;-> nil
(check-grammar "Forza. Andiamo.")
;-> nil
(check-grammar "Tu sei mio  amico.")
;-> nil


---------------------
commonLISP in newLISP
---------------------

Nel blog di johu https://johu02.wordpress.com/ ci sono molte informazioni su newLISP. In particolare ci sono due librerie ("newlisp-utility.lsp" e "onnewlisp.lsp") che permettono di studiare il libro "On Lisp" di Paul Graham utilizzando newLISP. I post sono molto istruttivi e l'unico problema è che il blog è scritto in giapponese (ma con Google Translate si può tradurlo facilmente).
Riportiamo di seguito il codice delle due librerie.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; newlisp-utility.lsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2008/12/23 second, third, fourth and labels are added.
;            with-open-file is improved.( setq _stream -> let )
; 2009/ 1/ 6 hayashi is improved. (push used.)
;            gensym, mklist, flat1, mappend are added.
;            with-open-file is improved. (catch and gensym used.)
; 2009/ 1/ 7 mapc,psetq are added.
; 2009/ 1/12 mapc is improved. (nthlst -> (map (curry nth i)))
; 2009/ 1/17 mappend is improved. (function -> macro)
;            maplist is added.
;            reference-inversion is added.
; 2009/ 1/21 read-integer is improved. (remove apostrophe for inc)
; 2009/ 1/26 reference-inversion:reference-inversion is improved. (remove macro-detect)
; 2009/ 1/27 incf & decf are improved. (On Lisp compatible)
; 2009/ 2/18 car is improved. (Common Lisp compatible)
; 2009/ 4/ 7 multi-let is added.
; 2009/ 4/15 read-string is improved. (read-buffer used.)
; 2010/ 6/15 ++ & -- is removed.
; 2010/ 6/16 map-mv is added.
;            null is improved.(using not only)
;            reference-inversion:reference-inversion is improved. (using MAIN:setf in defref)
; 2010/ 6/18 gensym is improved. (no suffix of context)
;            lables is improved. (remove begin in body)
;            ++ & -- are added.
;            consp is improved. (function -> macro)
;            aif is added.
; 2010/ 6/23 mklist is improved. (function -> macro)
; 2010/ 6/24 mappend is improved. (macro -> function)
; 2010/ 7/14 consp is improved. (macro -> function)
; 2010/ 8/ 2 cdr is improved. ((cdr '(a)) -> nil)
; 2010/12/10 curryEx is added.
; 2010/12/17 car, cdr, second, third, fourth are improved. (Common Lisp compatible)
;

;http://www.alh.net/newlisp/phpbb/viewtopic.php?t=1942&highlight=gensym
;(define (gensym) (sym (string "gs" (uuid))))
(define *gensym*:*gensym* 0)
(define (gensym num)
  (if (number? num)
      (let (res)
        (dotimes (i num)
          (push (sym (string  "gensym" (++ *gensym*:*gensym*))) res -1)))
    (sym (string  "gensym" (++ *gensym*:*gensym*)))))
(global 'gensym)
(context 'MAIN:with-open-file)
(define-macro (with-open-file:with-open-file)
  (letex (_result (gensym)
          _stream (args 0 0)
          _open (cons 'open (1 (args 0)))
          _body (cons 'begin (1 (args))))
    (let ((_stream _open) (_result))
      (catch _body '_result)
      (and _stream (close _stream))
      _result)))

(context 'MAIN:defun)
;http://www.alh.net/newlisp/phpbb/viewtopic.php?t=1064&highlight=defun
(set 'defun:defun
  (lambda-macro (_func-name _arguments)
      (set _func-name (append '(lambda ) (list _arguments) (args)))))

(context 'MAIN:labels)
(define-macro (labels:labels)
  (letex (_labels (append '(begin)
                          (map (fn (x)
                                 (list 'setq (x 0) (append '(fn) (list (x 1)) (2 x))))
                            (args 0))
                          (1 (args))))
    _labels))

(context 'MAIN:hayashi)
(define-macro (hayashi:hayashi)
;  (letex ((_func (flat (list (args 0) '_x (1 (args))))))
  (letex (_func (push '_x (args) 1))
    (fn (_x) _func )))

(context 'MAIN:decf)
;(set 'decf:decf
;  (lambda-macro (_number)
;    (set _number (- (eval _number) 1))))
(define-macro (decf:decf place (val 1))
  (letex (_place place
          _val val)
    (setf _place (- $it _val))))

(context 'MAIN:incf)
;(define-macro (incf:incf)
;  (letex (_number (args 0))
;    (setq _number (+ (eval _number) 1))))
(define-macro (incf:incf place (val 1))
  (letex (_place place
          _val val)
    (setf _place (+ $it _val))))

(context 'MAIN:rsetq)
(define-macro (rsetq:rsetq)
  (letex (_arg (args 0 1)
          _func (args 0))
    (setq _arg _func)))

(context 'MAIN:reference-inversion)
(setq *reference-inversion* nil)
(setq *set* 'reference-inversion:set)

(define-macro (reference-inversion:set expr)
  (letex (_expr expr)
    (if *reference-inversion* '_expr _expr)))

(define-macro (reference-inversion:reference-inversion m)
  (setq *reference-inversion* true)
  (letex (_body (if (and (list? (args 0))
                         ;(macro? (eval (args 0 0)))
                         (ref *set* (eval (args 0 0))))
                    (append (list m (eval (args 0))) (1 (args)))
                  (cons m (args))))
    (begin
      (setq *reference-inversion* nil)
      _body)))

(define-macro (reference-inversion:setf)
  (letex (_body (cons 'begin
                      (map (curry append '(reference-inversion MAIN:setf))
                           (explode (args) 2))))
    (begin
      _body)))

(define-macro (reference-inversion:defref)
  (letex (_mname (args 0))
    (if (ref *set* (eval _mname)) nil
        (MAIN:setf (nth '(1 -1) _mname) (cons *set* (list $it))))))

(context MAIN)

(define cdr    (fn (lst) (and (not (nil? lst)) (or (rest lst) nil))))
(define car    (fn (lst) (first (or lst '(nil)))))
(define second (fn (lst) (car (cdr lst))))
(define third  (fn (lst) (car (cdr (cdr lst)))))
(define fourth (fn (lst) (car (cdr (cdr (cdr lst))))))
(define cadr   second)
(define progn begin)
(define t true)
(define equal =)
(define char-code char)
(define atom atom?)
(define floatp float?)
(define integerp integer?)
(define listp list?)
;(define null (fn (x) (not (true? x))))
(define null not)
(define numberp number?)
(define stringp string?)
(define symbolp symbol?)
(define zerop zero?)

(defun read-integer (bytes INPUT-STREAM)
  (let ((c nil) (value 0) (cnt 0) (base 1))
    (while (and (< cnt bytes) (setq c (read-char INPUT-STREAM)))
      (setq value (+ value (* base c)))
      (setq base (* base 256))
      (inc cnt))
    (if c value nil)))

(defun read-string (bytes INPUT-STREAM)
  (let (buff (dup "00" bytes))
    (read-buffer INPUT-STREAM buff bytes)
    buff))

(defun remove (item seq)
  (cond ((string? seq) (replace item (copy seq) ""))
  (true (replace item (copy seq)))))
(define remove-if clean)
(define remove-if-not filter)

(defun evenp (num)
  (= (& num 1) 0))
(defun oddp (num)
  (= (& num 1) 1))
(define (consp L) (and (list? L) (true? L)))
(defun flat1 (lst)
  (apply append (map mklist lst)))
(defun mappend ()
  (apply append (apply map (args))))
(defun mapc (f)
 (let (lsts (args))
  (dotimes (i (apply min (map length lsts)))
    (apply f (map (curry nth i) lsts)))))
(defun maplist (f)
  (let ((lsts (args))(res))
    (dotimes (i (apply min (map length lsts)))
      (push (apply f (map (hayashi slice i) lsts)) res -1))
  res))

;(define (sprint) (silent (apply print (args))))
;(define (sprintln) (silent (apply println (args))))

(global 'cdr 'car 'second 'third 'fourth 'cadr 'progn 't 'equal 'char-code)
(global 'atom 'floatp 'integerp 'listp 'null 'numberp 'stringp 'symbolp 'zerop)
(global 'read-integer 'read-string)
(global 'evenp 'oddp 'consp)
(global 'remove 'remove-if 'remove-if-not)
(global 'flat1 'mappend 'mapc 'maplist)
;(global 'sprint 'sprintln)
;(constant (global '+) add))
;(constant (global '-) sub))
;(constant (global '*) mul))
;(constant (global '/) div))
(context 'MAIN:psetq)
(define-macro (psetq:psetq)
  (letn (_args (explode (args) 2)
         _temp (gensym (length _args)))
    (letex (_vars (transpose (list _temp (map second _args)))
            _pset (flat (cons 'setq (transpose (list (map first _args) _temp)))))
           (let _vars _pset))))
(context MAIN)
(context 'MAIN:multi-let)
(define-macro (multi-let:multi-let)
  (letex (_varlst (map list (args 0))
          _var (args 0)
          _val (args 1)
          _body (cons 'begin (2 (args))))
     (let _varlst
         (map set '_var (MAIN:mklist _val)) ; corrected 2010/ 6/23
         _body)))
(context MAIN)
(context 'MAIN:map-mv)
(define-macro (map-mv:map-mv)
;(mvmap exp-functor nested-list)
   (letex (_func (args 0)
           _vals (args 1))
     (map (curry apply _func) _vals)))
(context MAIN)
(if macro
    (unless (or i+ i-)
      (macro (i+ X) (+ X 1))
      (macro (i- X) (- X 1))
      (macro (mklist Obj) (if (list? Obj) Obj (list Obj)))
      (macro (aif S A B) (let (it S) (if it A B)))
      (macro (curryEx F A) (lambda () (apply F (cons A $args))))
    )
  (begin
    (define (i+ X) (+ X 1))
    (define (i- X) (- X 1))
    (define (mklist Obj) (if (list? Obj) Obj (list Obj)))
    (define-macro (aif)
      ; (aif test-form then-form &optional else-form)
      (letex (_test-form (args 0)
              _then-form (args 1)
              _else-form (third (args)))
        (let (it _test-form)
          (if it _then-form _else-form))))
    (define-macro (curryEx)
      (letex (_func (args 0) _arg (args 1))
        (lambda () (apply _func (cons _arg $args)))))
  )
)
(global 'i+ 'i- 'aif 'mklist 'curryEx)
; eof newlisp-utility.lsp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; onnewlisp.lsp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 2010/ 8/ 2 identity is added.
;            map0-n, map1-n and mapa-b are added.
; 2010/ 8/ 3 "newlisp-utility.lsp" is necessary.
;            https://johu02.wordpress.com/newlisp-utility-lsp/
;            include is defined in https://johu02.wordpress.com/init-lsp/
;            functionp is added.
;            lrec is added.
; 2010/ 8/ 4 lrec is improved. (cdr -> rest)
;            MACRO? is added.
;            trec is added.
; 2010/ 8/14 multiple-value-bind and multiple-value-list are improved.
;              (avoided the multiple evaluation problem of _val)
;
; 2010/ 8/20 =lambda, =defun, =bind, =values, =funcall and =apply are added.
; 2010/ 8/24 defstruct and structurep are added.
;

(include "newlisp-utility.lsp")

(context 'MAIN:do)
(define (make-stepform bindform)
  (remove nil (mappend (fn (b) (if (and (consp b) (third b))
                               (list (car b) (third b))
                                '()))
                         bindform)))
(define-macro (do:do)
  (letex (_init (map (hayashi slice 0 2) (args 0))
          _steps (cons 'psetq (make-stepform (args 0)))
          _results (cons 'begin (rest (args 1)))
          _end-test (first (args 1))
          _body (cons 'begin (2 (args))))
   (let _init
     (until _end-test
       _body
       _steps)
     _results)))

(context 'MAIN:do*)
(define (make-stepform bindform)
  (remove nil (mappend (fn (b) (if (and (consp b) (third b))
                               (list (car b) (third b))
                                '()))
                         bindform)))
(define-macro (do*:do*)
  (letex (_init (map (hayashi slice 0 2) (args 0))
          _steps (cons 'setq (make-stepform (args 0)))
          _results (cons 'begin (rest (args 1)))
          _end-test (first (args 1))
          _body (cons 'begin (2 (args))))
   (letn _init
     (until _end-test
       _body
       _steps)
     _results)))

(context 'MAIN:multiple-value-bind)
(define (add-nil lst c)
  (let (len (- c (length lst)))
    (if (> c) (append lst (dup nil c)) lst)))
(define-macro (multiple-value-bind:multiple-value-bind)
  (letex (_var (args 0)
          _len (length (args 0))
          _val (args 1)
          _body (cons 'begin (2 (args))))
    (local _var
      (setq values:mv-set true)
      (let (_res _val)
        (map set '_var (add-nil (mklist _res) _len)))
      (setq values:mv-set nil)
      _body)))

(context 'MAIN:multiple-value-list)
(define-macro (multiple-value-list:multiple-value-list)
  (letex (_val (args 0))
    (let (_lst)
      (setq values:mv-set true)
      (let (_res _val) (setq _lst (mklist _res)))
      (setq values:mv-set nil)
      _lst)))

(context 'MAIN:values)
(define-macro (values:values)
  (letex (_item (args 0)
          _lst  (cons 'list (args)))
    (if mv-set _lst _item)))

(context MAIN)

(define (identity x) x)

(define (functionp x) (or (lambda? x) (primitive? x)))

(define (lrec rec-f base-f)
  (letex (rec rec-f
          base base-f)
    (labels ((self-r (lst)
                   (if (null lst)
                       (if (functionp 'base) (base) 'base)
                       (rec (first lst)
                            (fn () (self-r (rest lst)))))))
      self-r)))

(define (map0-n f n)
  (map f (sequence 0 n)))
(define (map1-n f n)
  (map f (sequence 1 n)))
(define (mapa-b f a b (step 1))
  (map f (sequence a b step)))

(define (MACRO? f)
  (and (list? f) (macro? f) (= 'expand (nth '(1 0) f))))

(define (trec rec-f (base-f identity))
  (letex (rec rec-f
          base base-f)
    (labels
      ((self-r (tree)
         (if (atom tree)
             (if (functionp 'base) (base tree)
                 (MACRO?    'base) (eval (base tree))
               'base)
             (rec tree (fn () (self-r (first tree)))
                       (fn () (if (rest tree)
                                  (self-r (rest tree))))))))
      self-r)))

(global 'identity 'map0-n 'map1-n 'mapa-b)
(global 'functionp 'lrec 'trec 'MACRO?)

(setq *cont* values)

(define-macro (=lambda)
; (=lambda parms &body body)
  (letex (_parms (cons '*cont* (args 0))
          _body (cons 'begin (1 (args))))
    (fn _parms _body)))

(define-macro (=defun)
; (= defun name parms &body body)
  (let (_f (sym (string "=" (args 0))))
    (letex (_mname (cons (args 0)
                   (map sym (map (curry string "_") (args 1))))
            _fname (append (list _f '*cont*)
                           (map sym (map (curry string "_") (args 1))))
            _vars (if (args 1)
                      (transpose (list (args 1)
                                       (map sym
                                            (map (curry string "_")
                                                 (args 1)))))
                    '())
            _body (cons 'begin (2 (args))))
      (begin
        (define-macro _mname
           _fname)
        (define _fname
          (letex _vars _body))))))

(define-macro (=bind)
; (=bind parms expr &body body)
  (letex (_parms (args 0)
          _expr (args 1)
          _body (cons 'begin
                      (or (set-ref '=values (2 (args)) (eval *cont*))
                          (2 (args)))))
    (let (*cont* (fn _parms _body)) _expr)))

(define-macro (=values)
; (=value &rest retvals)
  (letex (_body (cons '*cont* (args)))
    _body))

(define-macro (=funcall)
; (=fancall fn &rest args)
  (letex (_body (append (list (args 0) '*cont*) (1 (args))))
    _body))

(define-macro (=apply)
; (=apply fn &rest args)
  (letex (_body (append (list 'apply (args 0) '*cont*) (1 (args))))
    _body))

(global '=lambda '=defun '=values '=bind '=funcall '=apply)

(define (structurep s)
  (letex (_s (sym (string s) s))
    (and (context? s) _s (= (s 0) 'structure))))

(define-macro (structfunc funcname propname)
  (letex (_funcname funcname
          _propname propname)
    (setq _funcname (lambda (symbol)
      (letex (_sym (sym '_propname symbol))
        (reference-inversion:set _sym))))))

(define-macro (structfuncs)
  (letex (_pair (cons 'begin (map (curry cons 'structfunc) (args))))
    _pair))

(define-macro (defstruct defname)
  (let (_name defname
        _var (map (fn (x) (first (mklist x))) (args))
        _val (map (fn (x) (second (mklist x))) (args)))
    (letex (_defctx _name
            _strucp (sym (string _name "-p"))
            _copy-n (sym (string "copy-" _name))
            _make-n (sym (string "make-" _name))
            _funcs (cons 'structfuncs (map (fn (x) (list (sym (string _name "-" x)) x)) _var))
            _vari _var
            _vali _val)
      _funcs
      (setq _copy-n (fn (s) (letex (_ctx (sym (gensym))) (new s '_ctx))))
      (setq _strucp (fn (s) (and (structurep s) (= (s 1) '_defctx))))
      (setq _make-n
            (lambda-macro ()
              (let (_gsym (sym (gensym))
                    _vars (append '_vari (map (fn (x) (first (mklist x))) (args)))
                    _vals (append '_vali (map (fn (x) (second (mklist x))) (args))))
                (letex (_ctx _gsym
                        _default (sym _gsym _gsym)
                        _structurep (append (list 'structure '_defctx) '_vari)
                        _var (cons 'setq (apply append (transpose (list (map (hayashi sym _gsym) _vars) _vals)))))
                  (setq _default '_structurep)
                  _var
                  _ctx)))))))

(global 'defstruct 'structurep)
; eof onnewlisp.lsp


--------------------------------------
Peso ideale e indice di massa corporea
--------------------------------------

Peso ideale
-----------
Il peso ideale è il peso forma teorico di una persona. Ma come calcolare questo peso forma teorico?
La soluzione esatta del problema è praticamente impossibile. Molti scienziati hanno cercato di creare una formula e, nonostante ne esistano diverse, ognuna ha i suoi difetti. Questo non significa che siano completamente sbagliate, ma solo che i risultati variano da formula a formula. Questo perché ci sono delle caratteristiche dell'essere umano che non vengono prese in considerazione. Queste formule utilizzano come parametri l'età, il sesso e l'altezza, mentre non tengono conto della struttura scheletrica (dimensione delle ossa) e della struttura muscolare (grasso o muscoli).
Vediamo le formule più famose e indicative.

Formula di Lorenz
-----------------
Questa formula per il calcolo del peso ideale non tiene conto né dell'età né della struttura scheletrica, ma è molto utilizzata. Inoltre non fornisce risultati affidabili nei soggetti longilinei e brachitipici.

Peso ideale Uomini = altezza in cm - 100 - (altezza in cm - 150)/4
Peso ideale Donne = altezza in cm - 100 - (altezza in cm - 150)/2

Formula di Broca
----------------
Questa formula è la più semplice, ma tiene conto solo dell'altezza. I limiti maggiori risiedono nella non corrispondenza del peso ideale per i soggetti medio alti.

Peso ideale Maschi = altezza in cm - 100
Peso ideale Femmine = altezza in cm - 104

Formula di Wan der Vael
-----------------------
Anche questa formula considera solo l'altezza.

Peso ideale Uomini = (altezza in cm - 150) x 0.75 + 50
Peso ideale Donne = (altezza in cm - 150) x 0.6 + 50

Formula di Berthean
-------------------
Questa formula tiene conto dell'età e dell'altezza.
Peso ideale = 0.8 x (altezza in cm - 100) + età/2

Formula di Perrault
-------------------
Questa formula tiene conto dell'età e dell'altezza.
Peso ideale = Altezza in cm - 100 + età/10 x 0.9

Formula di Keys
---------------
Peso ideale Uomini = (altezza in m)² x 22.1
Peso ideale Donne = (altezza in m)² x 20.6

Formula di Travia
-----------------
Peso ideale = (1.012 x altezza in cm) - 107.5

Formula di Livi
---------------
Peso ideale = (2.37 x altezza in m)^3

Buffon, Roher e Bardeen (confermata da Quételet e Martin)
---------------------------------------------------------
Peso ideale Uomini = (1.40 x altezza in dm3)/100

Peso ideale Donna = (135 x altezza in dm3)/100

Indice di massa corporea
------------------------
Dato che tutte queste formule producono risultati diversi, l'OMS (Organizzazione Mondiale della Sanità), ha preferito definire un indice che viene interpretato in un range di valori (invece che il solo valore del peso forma). In questo modo l'indice appartiene ad una classe con determinati limiti (minimo e massimo). Ad esempio, se ci troviamo nella classe (range) "Normale" non ci sono problemi sia che ci troviamo verso l'alto che verso il basso (se usciamo dal range "Normale", invece, occorre preoccuparsi).

La formula del BMI (Body Mass Index) o IMC (Indice di Massa Corporea) che viene utilizzata è la seguente:

BMI = peso / (altezza in m)²

Questa formula da un valore che non è il peso forma teorico, ma un punteggio. Comunque questa formula ha dei limiti, ovvero tende a valutare come sovrappeso individui muscolosi oppure come sottopeso individui esili con ossa piccole. La formula è stata perfezionata in un nuovo indice che viene chiamato "Nuovo BMI":

NuovoBMI: 1.3 x peso in Kg / (altezza in m)^2.5

In pratica, questa nuova formula normalizza l'altezza rendendola più significativa del peso.

Possiamo utilizzare tutte e due le formule e, pur trovando due valori leggermente diversi, interpretare i risultati con la seguente tabella:

  BMImin   BMImax   Classe
  -----------------------------------
  > 40   |        | Obesità (terzo grado)
  > 35   | < 40   | Obesità (secondo grado)
  > 30   | < 35   | Obesità (primo grado)
  > 25   | < 30   | Sovrappeso
  > 18.5 | < 25   | Normale
  > 17.5 | < 18.5 | Sottopeso
  > 15.5 | < 17.5 | Anoressia moderata
  >  0   | < 15.5 | Anoressia

Scriviamo una funzione che calcola il "Nuovo BMI" e la relativa classe:

(define (newBMI peso altezza)
  (local (bmi tipo)
    (setq bmi (div (mul 1.3 peso) (pow altezza 2.5)))
    (cond ((> bmi 40) (setq tipo "Obesità (terzo grado)"))
          ((and (> bmi 35) (<= bmi 40)) (setq tipo "Obesità (secondo grado)"))
          ((and (> bmi 30) (<= bmi 35)) (setq tipo "Obesità (primo grado)"))
          ((and (> bmi 25) (<= bmi 30)) (setq tipo "Sovrappeso"))
          ((and (> bmi 18.5) (<= bmi 25)) (setq tipo "Normale"))
          ((and (> bmi 17.5) (<= bmi 18.5)) (setq tipo "Sottopeso"))
          ((and (> bmi 15.5) (<= bmi 17.5)) (setq tipo "Anoressia moderata"))
          ((and (> bmi 0) (<= bmi 15.5)) (setq tipo "Anoressia"))
          (true (setq tipo "errore: valore fuori dai limiti"))
    )
    (list bmi tipo)))

Facciamo alcune prove:

(newBMI 75 1.80)
;-> (23.62594457708111 "Normale")
(newBMI 89 1.75)
;-> (28.55868703815026 "Sovrappeso")
(newBMI 60 1.85)
;-> (16.755804389574 "Anoressia moderata")
(newBMI 50 1.65)
;-> (18.5867516512393 "Normale")
(newBMI 45 1.60)
;-> (18.06574639842287 "Sottopeso")
(newBMI 75 1.60)
;-> (30.10957733070478 "Obesità (primo grado)")


------------------
Sequenza di Golomb
------------------

La sequenza di Golomb (definita dal matematico e ingegnere Solomon Golomb) è una successione di interi monotona non decrescente nella quale a(n) rappresenta il numero di volte in cui n compare nella successione stessa. La successione inizia con a1 = 1 e ha la proprietà che, per qualsiasi n > 1, a(n) è il primo e unico intero che soddisfa la definizione. Ad esempio, il termine a1 = 1 afferma che il numero 1 appare una e una sola volta nella sequenza, perciò a2 non può essere anch'esso 1, ma può (e deve) essere l'intero successivo, 2. Seguendo questo ragionamento otteniamo:

  a1 = 1
  Pertanto 1 si verifica esattamente una volta in questa sequenza.
  a2 > 1
  a2 = 2
  2 si verifica esattamente 2 volte in questa sequenza.
  a3 = 2
  3 si verifica esattamente 2 volte in questa sequenza.
  a4 = a5 = 3
  4 si verifica esattamente 3 volte in questa sequenza.
  5 si verifica esattamente 3 volte in questa sequenza.
  a6 = a7 = a8 = 4
  a9 = a10 = a11 = 5
  ...

Sequenza OEIS A001462: 1, 2, 2, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6,
 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 11, 11,
 11, 11, 11, 12, 12, 12, 12, 12, 12,...

La formula ricorsiva per calcolare i termini della sequenza è la seguente (Colin Mallows):

  a(1) = 1
  a(n+1) = 1 + a*(n + 1 - a(a(n)))

Nota: dalla definizione ricorsiva segue che questa è una sequenza autoreferenziale.

La stima asintotica per a(n) vale (Marcus e Fine):

  a(n) = phi^(2-phi)*n^(phi-1) + E(n),
  dove phi è il rapporto aureo (1+sqrt(5))/2
  e E(n) è il termine di errore che vale (Ilan Vardi): O( n^(phi-1) / log n )

Scriviamo una funzione che calcola la stima asintotica di a(n):

(setq phi (div (add 1 (sqrt 5)) 2))
;-> 1.618033988749895

(setq n 20)
(define (golomb-stima n)
  (local (phi an en)
    (setq phi (div (add 1 (sqrt 5)) 2))
    (setq an (mul (pow phi (sub 2 phi)) (pow n (sub phi 1))))
    (setq en (div (pow n (sub phi 1)) (log n)))
    (list an en)
  ))

(golomb-stima 100)
;-> (20.69636871119573 3.739575390803224)

Scriviamo una funzione ricorsiva che calcola la sequenza di Golomb fino a un dato valore n:

(define (find-golomb n)
  (cond ((= n 1) 1)
        (true (+ 1 (find-golomb (- n (find-golomb (find-golomb (- n 1)))))))))

(define (golomb-rec n)
  (local (gol)
    (setq gol '())
    (for (i 1 n)
      (push (find-golomb i) gol -1)
    )
    gol))

(golomb-rec 10)
;-> (1 2 2 3 3 4 4 4 5 5)
(golomb-rec 25)
;-> (1 2 2 3 3 4 4 4 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9)

Scriviamo una funzione che utilizza la programmazione dinamica per calcolare la sequenza di Golomb fino a un dato valore n:

(define (golomb-dp n)
  (let (gol (array (+ n 1) '(0)))
    (setf (gol 1) 1)
    (for (i 1 (- n 1))
      (setf (gol (+ i 1)) (+ 1 (gol (+ i 1 (- (gol (gol i)))))))
    )
    (slice gol 1)))

(golomb-dp 10)
;-> (1 2 2 3 3 4 4 4 5 5)
(golomb-dp 25)
;-> (1 2 2 3 3 4 4 4 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9)

Vediamo un'altra funzione che calcola la sequenza di Golomb fino a che a(k) è uguale a n:

(define (golomb-k n)
  (local (gol next-val)
    (setq gol '(1))
    (for (i 0 (- n 2))
      (setq next-val (+ (gol (- (length gol) 1)) 1))
      (push next-val gol -1)
      (for (j 0 (- (gol (- next-val 1)) 2))
        (push next-val gol -1)
      )
    )
    gol))

(golomb-k 10)
;-> (1 2 2 3 3 4 4 4 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 9 10 10 10 10 10)
(golomb-k 25)
;-> (1 2 2 3 3 4 4 4 5 5 5 6 6 6 6 7 7 7 7 8 8 8 8 9 9 9 9 9 10 10 10 10 10
;->  11 11 11 11 11 12 12 12 12 12 12 13 13 13 13 13 13 14 14 14 14 14 14 15
;->  15 15 15 15 15 16 16 16 16 16 16 16 17 17 17 17 17 17 17 18 18 18 18 18
;->  18 18 19 19 19 19 19 19 19 20 20 20 20 20 20 20 20 21 21 21 21 21 21 21
;->  21 22 22 22 22 22 22 22 22 23 23 23 23 23 23 23 23 24 24 24 24 24 24 24
;->  24 24 25 25 25 25 25 25 25 25 25)


---------------------------
Acquistare e vendere azioni
---------------------------

Nel trading di azioni, un acquirente compra azioni e le vende in una data futura. Dato il prezzo delle azioni di n giorni, il trader può effettuare al massimo k transazioni (dove una nuova transazione può iniziare solo dopo che la transazione precedente è stata completata). Determinare il profitto massimo che un trader può realizzare dato il prezzo delle azioni di n giorni e il numero k di transazioni.

Esempi:

Input:
Valore azioni = [10, 22, 5, 75, 65, 80]
Transazioni = 2
Output: 87
Il trader guadagna 87 come somma di 12 e 75.
Acquista a prezzo 10, vende a 22, acquista a 5 e vende a 80.

Input:
Valore azioni = [12, 14, 17, 10, 14, 13, 12, 15]
Transazioni = 3
Output: 12
Il trader guadagna 12 come somma di 5, 4 e 3.
Acquista a prezzo 12 e vende a 17, acquista a 10 e vende a 14, acquista a 12 e vende a 15.

Input:
Valore azioni = [100, 30, 15, 10, 8, 25, 80]
Transazioni = 3
Output: 72
Due transazioni. Acquista a prezzo 8 e vende a 25, acquista a prezzo 25 e vende a 80.

Input:
Valore azioni = [90, 80, 70, 60, 50]
Transazioni = 1
Output: 0
Non è possibile guadagnare.

Esistono varie versioni del problema. Se è possibile comprare e vendere solo una volta, allora possiamo usare l'algoritmo "differenza massima tra due elementi". Se è possibile comprare e vendere un numero qualsiasi di volte, possiamo utilizzare il metodo seguente.

Il problema può essere risolto utilizzando la programmazione dinamica.

Poniamo che profitto[t][i] rappresenti il profitto massimo utilizzando al massimo t transazioni fino al giorno i (incluso il giorno i).
Allora la relazione è:

  profitto[t][i] = max(profitto[t][i-1], max(prezzo[i] – prezzo[j] + profitto[t-1][j]))
  per tutti j nell'intervallo [0, i-1]

profitto[t][i] sarà il massimo di:
  1) profitto[t][i-1] che rappresenta non fare alcuna transazione il giorno i-esimo.
  2) Massimo profitto ottenuto vendendo l'iesimo giorno. Per vendere azioni l'i-esimo giorno, dobbiamo acquistarle in uno qualsiasi dei [0, i – 1] giorni. Se acquistiamo azioni il giorno j-esimo e le vendiamo il giorno i-esimo, il profitto massimo sarà prezzo[i] – prezzo[j] + profitto[t-1][j] dove j varia da 0 a i-1. Qui il profitto[t-1][j] è il migliore che avremmo potuto fare con una transazione in meno fino al j-esimo giorno.

Vediamo una possibile implementazione:

(define (max-profit price k)
  (local (n profit val-max)
    ; numero giorni
    (setq n (length price))
    ; matrice per memorizzare i risultati dei sottoproblemi
    ; profit[t][i] memorizza il massimo profitto usando al massimo
    (setq profit (array (+ k 1) n '(0)))
    ; Riempimento della matrice in modo bottom-up
    (for (i 1 k)
      (for (j 1 (- n 1))
        (setq val-max 0)
        (for (m 0 (- j 1))
          (setq val-max (max val-max (+ (price j) (profit (- i 1) m) (- (price m)))))
        )
        (setf (profit i j) (max (profit i (- j 1)) val-max))
      )
    )
    (print-transaction profit price)
    (profit k (- n 1))))

Adesso scriviamo la funzione che stampa i valori delle singole transazioni:

(define (print-transaction profit price)
  (local (i j stack max-diff continua stop)
    (setq i (- (length profit) 1))
    (setq j (- (length (profit 0)) 1))
    (setq continua true)
    (while continua
      (cond ((or (= i 0) (= j 0))
             (setq continua nil))
            (true
             (if (= (profit i j) (profit i (- j 1)))
                 (-- j)
             (begin ;else
                 (push j stack)
                 (setq max-diff (- (profit i j) (price j)))
                 (setq stop nil)
                 (for (k (- j 1) 0 -1 stop)
                     (if (= (- (profit (- i 1) k) (price k)) max-diff) (begin
                         (-- i)
                         (setq j k)
                         (push j stack)
                         (setq stop true))
                     )
                 )
             )))
      )
    )
    (if (> (length stack) 0)
      (for (i 0 (- (length stack) 2) 2)
        (println "compra a " (price (stack i)) " e vende a " (price (stack (+ i 1))) " (" (- (price (stack (+ i 1))) (price (stack i))) ")")
      )
    )
  )
)

Facciamo alcune prove:

(max-profit '(10 22 5 75 65 80) 2)
;-> compra a 10 e vende a 22 (12)
;-> compra a 5 e vende a 80 (75)
;-> 87
(max-profit '(12 14 17 10 14 13 12 15) 3)
;-> compra a 12 e vende a 17 (5)
;-> compra a 10 e vende a 14 (4)
;-> compra a 12 e vende a 15 (3)
;-> 12
(max-profit '(100 30 15 10 8 25 80) 3)
;-> compra a 8 e vende a 25 (17)
;-> compra a 25 e vende a 80 (55)
;-> 72
(max-profit '(90 80 70 60 50) 1)
;-> 0

Questa soluzione ha complessità temporale O(k*n^2).
È possibile calcolare il massimo profitto ottenuto vendendo azioni il giorno i-esimo in tempo costante.

  profitto[t][i] = max(profitto [t][i-1], max(prezzo[i] – prezzo[j] + profitto[t-1][j]))
  per tutti j nell'intervallo [0, i-1]

Se notiamo con attenzione l'espressione,
  max(prezzo[i] – prezzo[j] + profitto[t-1][j])
  per tutti j nell'intervallo [0, i-1]

può essere riscritta come,
  = prezzo[i] + max(profitto[t-1][j] – prezzo[j])
  per tutti j nell'intervallo [0, i-1]
  = prezzo[i] + max(prev-diff, profitto[t-1][i-1] – prezzo[i-1])
  dove prev-diff è max(profit[t-1][j] – prezzo[j])
  per tutti j nell'intervallo [0, i-2]

Quindi, se abbiamo già calcolato max(profit[t-1][j] – prezzo[j]) per tutti j nell'intervallo [0, i-2], possiamo calcolarlo per j = i – 1 in tempo costante. In altre parole, non dobbiamo più guardare indietro nell'intervallo [0, i-1] per scoprire il giorno migliore per l'acquisto. Possiamo determinarlo in tempo costante usando la relazione seguente:

  profitto[t][i] = max(profitto[t][i-1], prezzo[i] + max(prev-diff, profitto [t-1][i-1] – prezzo[i-1])
  dove prev-diff è max(profit[t-1][j] – price[j]) per tutti j nell'intervallo [0, i-2]

Scriviamo una possibile implementazione:

(define (max-profit-2 price k)
  (local (n profit prev-diff)
    ; numero giorni
    (setq n (length price))
    ; matrice per memorizzare i risultati dei sottoproblemi
    ; profit[t][i] memorizza il massimo profitto usando al massimo
    ; t transazioni fino al giorno i (incluso)
    (setq profit (array (+ k 1) n '(0)))
    ; Riempimento della matrice in modo bottom-up
    (for (i 1 k)
      (setq prev-diff -9223372036854775808)
      (for (j 1 (- n 1))
        (setq prev-diff (max prev-diff (- (profit (- i 1) (- j 1)) (price (- j 1)))))
        (setf (profit i j) (max (profit i (- j 1)) (+ (price j) prev-diff)))
      )
    )
    ; stampa le singole transazioni
    (print-transaction profit price)
    ; restituisce il valore finale
    (profit k (- n 1))))

Verifichiamo i risultati precedenti:

(max-profit-2 '(10 22 5 75 65 80) 2)
;-> compra a 10 e vende a 22 (12)
;-> compra a 5 e vende a 80 (75)
;-> 87
(max-profit-2 '(12 14 17 10 14 13 12 15) 3)
;-> compra a 12 e vende a 17 (5)
;-> compra a 10 e vende a 14 (4)
;-> compra a 12 e vende a 15 (3)
;-> 12
(max-profit-2 '(100 30 15 10 8 25 80) 3)
;-> compra a 8 e vende a 25 (17)
;-> compra a 25 e vende a 80 (55)
;-> 72
(max-profit-2 '(90 80 70 60 50) 1)
;-> 0

Questa soluzione ha complessità temporale O(k*n).

Vediamo la differenza di velocità tra le due funzioni:

(setq azioni (randomize (sequence 1 1000)))
(time (println (max-profit azioni 10)))
;-> compra a 2 e vende a 1000 (998)
;-> compra a 17 e vende a 997 (980)
;-> compra a 1 e vende a 996 (995)
;-> compra a 8 e vende a 998 (990)
;-> compra a 13 e vende a 990 (977)
;-> compra a 9 e vende a 994 (985)
;-> compra a 15 e vende a 995 (980)
;-> compra a 4 e vende a 977 (973)
;-> compra a 6 e vende a 992 (986)
;-> compra a 3 e vende a 999 (996)
;-> 9860
;-> 6257.59

(time (println (max-profit-2 azioni 10)))
;-> compra a 2 e vende a 1000 (998)
;-> compra a 17 e vende a 997 (980)
;-> compra a 1 e vende a 996 (995)
;-> compra a 8 e vende a 998 (990)
;-> compra a 13 e vende a 990 (977)
;-> compra a 9 e vende a 994 (985)
;-> compra a 15 e vende a 995 (980)
;-> compra a 4 e vende a 977 (973)
;-> compra a 6 e vende a 992 (986)
;-> compra a 3 e vende a 999 (996)
;-> 9860
;-> 22.303

Vedi anche "Acquisto e vendita di merce" in "Note libere 20".


---------------
Numeri armonici
---------------

Per ogni intero naturale n si definisce come n-esimo numero armonico la somma:

                                   n
H(n) = 1 + 1/2 + 1/3 + ... + 1/n = ∑ 1/k
                                   k=1

Questi sono numeri razionali e le corrispondenti frazioni ridotte ai minimi termini hanno numeratore dispari e denominatore pari.

I primi termini della successione dei numeri armonici sono:

1, 3/2, 11/6, 25/12, 137/60, 49/20, 363/140, 761/280, 7129/2520, 7381/2520, 83711/27720, ...

I numeratori dei numeri armonici sono la sequenza A001008 OEIS.
I denominatori dei numeri armonici sono la sequenza A002805 OEIS.

I numeri armonici costituiscono le somme parziali della serie armonica (che è divergente).

Per questi numeri vale la seguente relazione ricorsiva:

H(n+1) = H(n) + 1/(n + 1)

Nota: il valore di un numero armonico è compreso tra: log(n) < H(n) < log(n) + 1

Scriviamo le funzioni necessarie per calcolare i numeri armonici.

Funzioni per il calcolo delle quattro operazioni aritmetiche con le frazioni "+", "-" "*" "/" (big integer):

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
(define (-rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (- (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1) (r2 1))))
(define (*rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 0L))
       (* (r1 1L) (r2 1L))))
(define (/rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 1L))
       (* (r1 1L) (r2 0L))))
;; (+f '(1 2) '(1 2))           ==> (1L 1L)
;; (+f '(1 2) '(1 2) '(1 2))    ==> (3L 2L)
;; (+f '(-1 -2) '(2 1) '(1 1))  ==> (-7L -2L)
(define-macro (+f)
  (apply +rat (map eval (args)) 2))
;; (-f '(1 2) '(1 2))          ==> (0L 1L)
;; (-f '(1 2) '(1 2) '(1 2))   ==> (-1L 2L)
(define-macro (-f)
  (apply -rat (map eval (args)) 2))
;; (*f '(2 5) '(5 2))         ==> (1L 1L)
;; (*f '(1 2) '(1 2) '(1 2))  ==> (1L 8L)
(define-macro (*f)
  (apply *rat (map eval (args)) 2))
;; (/f '(1 2) '(1 2) '(1 2))    ==> (2L 1L)
;; (/f '(4 1) '(1 1) '(1 2))    ==> (8L 1L)
(define-macro (/f)
  (apply /rat (map eval (args)) 2))

Scriviamo una funzione che calcola il numero armonico di un numero n:

(define (harmonic n)
  (local (h)
    (setq h '(0L 1L))
    (for (i 1 n)
      (setq h (+f h (list 1 i)))
    )
    h))

(harmonic 1)
;-> (1L 1L)

Calcoliamo i numeri armonici dei primi dieci interi:

(for (i 1 10) (println (harmonic i)))
;-> (1L 1L)
;-> (3L 2L)
;-> (11L 6L)
;-> (25L 12L)
;-> (137L 60L)
;-> (49L 20L)
;-> (363L 140L)
;-> (761L 280L)
;-> (7129L 2520L)
;-> (7381L 2520L)

I valori del numeratore e del denominatore crescono molto velocemente:

(harmonic 42)
;-> (12309312989335019L 2844937529085600L)


-----------------------------------------
Numero previsto di prove fino al successo
-----------------------------------------

Teorema
Se la probabilità di successo è p in ogni prova, il numero previsto di prove fino al successo vale 1/p.

Problema
Un dado a 6 facce viene lanciato fino a quando non esce un '5'. Qual è il numero previsto di lanci?

Soluzione
Poichè per ogni lancio la probabilità che esca un 5 vale p = 1/6, allora il numero previsto di lanci vale 1/p = 6.

Possiamo verificare questo risultato con le seguente funzioni:

Funzione che simula il lancio di un dado con n facce (da 1 a n):

(define (dado n) (+ (rand n) 1))

(dado 6)
;-> 2

Funzione che calcola la media dei successi (cioè la frequenza di uscita del numero k):

(define (media-successo k iter)
  (let (conta 0)
    (for (i 1 iter)
      (if (= (dado 6) k)
        (++ conta)
      )
    )
    (println conta)
    (div conta iter)))

Facciamo alcune prove:

(media-successo 1 100000)
;-> 16573
;-> 0.16573
(media-successo 2 100000)
;-> 16459
;-> 0.16459
(media-successo 1 100000)
;-> 16634
;-> 0.16634
(media-successo 2 100000)
;-> 16519
;-> 0.16519
(media-successo 3 100000)
;-> 16699
;-> 0.16699
(media-successo 4 100000)
;-> 16685
;-> 0.16685
(media-successo 5 100000)
;-> 16618
;-> 0.16618
(media-successo 6 100000)
;-> 16554
;-> 0.16554

Il valore teorico vale 1/6 = 0.1666666666666667, cioè, in media, il numero k esce ogni 6 lanci.

Con la funzione seguente possiamo calcolare quante volte, in media, occorre lanciare un dado prima che esca il numero k:

(define (freq-successo k iter)
  (local (conta lanci continua)
    ; numero totale di lanci per ottenere "iter" successi
    (setq conta 0)
    (for (i 1 iter)
      ; numero di lanci per l'i-esimo successo
      (setq lanci 0)
      (setq continua true)
      (while continua
        (++ lanci)
        (if (= (dado 6) k) (begin
            (setq conta (+ conta lanci))
            (setq continua nil)
        )
      )
    )
    (div conta iter))))

Facciamo alcune prove:

(freq-successo 1 100000)
;-> 6.01599
(freq-successo 2 100000)
;-> 6.00242
(freq-successo 3 100000)
;-> 6.00706
(freq-successo 4 100000)
;-> 6.00222
(freq-successo 5 100000)
;-> 6.02989
(freq-successo 6 100000)
;-> 5.99746

Quindi, affinchè esca il numero k occorrono in media 6 lanci.


------------------------------------------
Valore atteso e linearità dell'aspettativa
------------------------------------------

Il valore atteso (chiamato anche media o speranza matematica) di una variabile casuale X, è un numero indicato con E[X] che formalizza l'idea euristica di valore medio di un fenomeno aleatorio.

In generale il valore atteso di una variabile casuale discreta (che assuma cioè solo un numero finito di valori) è dato dalla somma dei possibili valori di tale variabile, ciascuno moltiplicato per la probabilità di verificarsi, cioè è la media ponderata dei possibili risultati.

        n
  E[X]= ∑ x(i)*p(i)
       i=1

Per esempio, nel gioco testa o croce, il valore atteso per "testa" vale:

  E[testa]= 1*0.5 + 0*0.5 = 0.5

cioè il valore atteso del gioco di testa vale 0.5, ovvero la media delle vincite e perdite pesata in base alle probabilità (50% per entrambi i casi).

Invece, lanciando un dado il valore atteso vale:

  E[dado] = 1*1/6 + 2*1/6 + 3*1/6 + 4*1/6 + 5*1/6 + 6*1/6 = 21/6 = 3.5

La linearità dell'aspettativa dice fondamentalmente che il valore atteso di una somma di variabili casuali è uguale alla somma delle aspettative individuali. La sua importanza è fondamentale per l'area degli algoritmi randomizzati e dei metodi probabilistici. La sua forza principale consiste sul fatto che:

  a) è applicabile per somme di qualsiasi variabile casuale (indipendente o meno), e
  b) spesso consente semplici argomenti “locali” invece di quelli “globali”.

         n
  E[X] = ∑ E[x(i)]
        i=1

Per esempio, nel lancio di due dadi (con distribuzioni indipendenti X1 e X2) il valore atteso di X = X1 + X2 vale:

  E[X] = 2*1/36 + 3*1/36 + ... + 12*1/36 = 7

Cioè, la linearità dell'aspettativa ci permette di calcolare il valore atteso di una somma di variabili casuali calcolando la somma delle aspettative individuali.

Problema
Supponiamo di avere n buche e un numero infinito di palline. Lanciando una pallina questa termina in una delle n buche (con distribuzione uniforme). Quanti lanci dobbiamo effettuare, in media, affinchè tutte le buche contengano almeno una pallina?

Soluzione
Dal punto di vista matematico è possibile dimostrare (utilizzando la proprietà della linearità delle aspettative) che il risultato vale:

 E[X] = n * H(n)
 dove H(n) è l'n-esimo numero armonico.

Prima scriviamo le funzioni per calcolare il valore matematico della soluzione.

Funzioni per il calcolo delle quattro operazioni aritmetiche con le frazioni "+", "-" "*" "/" (big integer):

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
(define (-rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (- (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1) (r2 1))))
(define (*rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 0L))
       (* (r1 1L) (r2 1L))))
(define (/rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 1L))
       (* (r1 1L) (r2 0L))))
(define-macro (+f)
  (apply +rat (map eval (args)) 2))
(define-macro (-f)
  (apply -rat (map eval (args)) 2))
(define-macro (*f)
  (apply *rat (map eval (args)) 2))
(define-macro (/f)
  (apply /rat (map eval (args)) 2))

Funzione per il calcolo dell'n-esimo numero armonico:

(define (harmonic-value n)
  (local (h)
    (setq h '(0L 1L))
    (for (i 1 n)
      (setq h (+f h (list 1 i)))
    )
    (div (h 0) (h 1))))

(harmonic-value 10)
;-> 2.928968253968254

Funzione che calcola il risultato matematico del problema:

(define (math-value n)
  (mul n (harmonic-value n)))

Adesso scriviamo le funzioni per effettuare una simulazione del processo e calcolare una soluzione numerica.

Funzione che effettua il processo di riempire le buche con almeno una pallina in ogni buca e restituisce il numero di lanci necessari:

(define (fill-hole n)
  (local (buche lanci continua filled break)
    (setq buche (array (+ n 1) '(0)))
    (setq lanci 0)
    (setq continua true)
    (while continua
      ; lancio nella buca b
      (setq b (+ (rand n) 1))
      (++ lanci)
      (++ (buche b))
      ; controllo riempimento buche
      (setq filled true)
      (setq break nil)
      (for (i 1 n 1 break)
        (if (zero? (buche i))
          (setq filled nil break true)
        )
      )
      (if filled (setq continua nil))
    )
    ;(println buche)
    ;(println (apply + buche))
    lanci))

Funzione che simula iter volte il processo di riempimento visto sopra:

(define (fill-hole-test n iter)
  (local (conta lanci continua)
    ; numero totale di lanci per ottenere "iter" successi
    (setq conta 0)
    (for (i 1 iter)
      ; (fill-hole n) -> numero di lanci per l'i-esimo successo
      ; (successo = tutte le buche almeno con 1 pallina)
      (setq conta (+ conta (fill-hole n)))
    )
    (div conta iter)))

Verifichiamo che il risultati teorici siano congruenti con quelli delle simulazioni:

(fill-hole-test 10 10000)
;-> 29.30323
(math-value 10)
;-> 29.28968253968254

(fill-hole-test 20 10000)
;-> 72.2317
(math-value 20)
;-> 72.03876

(fill-hole-test 30 10000)
;-> 119.7455
(math-value 30)
;-> 119.8496139276117

I risultati teorici confermano i risultati delle simulazioni.


-------------------------
Moltiplicazione ricorsiva
-------------------------

Moltiplicare due interi senza utilizzare gli operatori di moltiplicazione, divisione e bitwise. Inoltre non è possibile utilizza cicli (for, while, ecc).

La soluzione consiste nell'utilizzare una funzione ricorsiva:

(define (molt x y)
        ; 0*x = 0
  (cond ((zero? y) 0)
        ; aggiunge x ogni volta
        ((> y 0) (+ x (molt x (- y 1))))
        ; caso in cui y è negativo
        ((< y 0) (- (molt x (- y))))
        (true nil)))

(molt 3 4)
;-> 12
(molt -2 4)
;-> -8
(molt 2 -4)
;-> -8
(molt -1 -3)
;-> 3
(molt 0 0)
;-> 0
(molt 0 2)
;-> 0
(molt 2 0)
;-> 0

Nota: questa funzione ha il problema dello stack overflow per numeri relativamente grandi:

(molt 5000 -1234)
;-> ERR: call or result stack overflow in function cond : zero?
;-> called from user function (molt x (- y 1))


------------------
Il gioco del Lotto
------------------

Il gioco del Lotto consiste in un'urna che contiene 90 palline numerate. Vengono estratte a caso 5 palline, 85 di queste sono perdenti, 5 sono vincenti.
I casi possibili sono tutti i modi di estrarre un gruppo di k=5 palline tra n=90 (poichè le ripetizioni non sono ammesse e l'ordine di estrazione non è rilevante, allora si tratta del numero di combinazioni):

  Numero di casi possibili = Combinazioni(90,5)

Per calcolare le combinazioni utilizziamo la funzione che calcola il coefficiente binomiale (n k) = n!/(k!*(n - k)!):

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(binom 90 5)
;-> 43949268L

Prima di calcolare tutte le probabilità del lotto, vediamo un esempio di queste probabilità utilizzando il calcolo combinatorio.

Esempio
-------
Una persona gioca 4 numeri al lotto, calcolare la probabilità di vincere almeno un terno (ossia un terno o una quaterna).

La formula per calcolare la probabilità è la seguente:

          C(a x) * C(b y)
  P(x) = -----------------
              C(N n)

dove:
  a = numeri giocati (4)
  b = numeri non giocati (86)
  x = numeri favorevoli estratti (3 per il terno o 4 per la quaterna)
  y = numeri non favorevoli estratti (2 per il terno 1 per la quaterna)
  N = popolazione totale (90)
  n = numero palline estratte (5)

La formula considera che i casi favorevoli siano dati dal prodotto cartesiano di tutti i possibili raggruppamenti dei 4 numeri giocati con i 3 numeri del terno uscito e tutti i possibili raggruppamenti degli 86 numeri non giocati con i 2 numeri avanzati che non costituiscono il terno. I casi totali sono dati da tutte le possibili combinazioni dei 90 numeri del lotto presi a gruppi di 5.

Per il terno abbiamo:

          C(4,3) * C(86,2)       170
  P(3) = ------------------ = ----------
              C(90,5)           511038

Per la quaterna abbiamo:

          C(4,4) * C(86,1)        1
  P(4) = ------------------ = ----------
              C(90,5)           511038

Probabilità di estrazione su singola ruota
------------------------------------------

A) Probabilità secche

Probabilità che 1 numero giocato venga estratto:

C(89,4)*C(1,1) / C(90,5) = 2441626 / 43949268 = 1/18 = 0.05555555555555555

(* (binom 89 4) (binom 1 1))
;-> 2441626L
(div 2441626 43949268)
;-> 0.05555555555555555
(div (div 2441626 43949268))
;-> 18

Probabilità che 2 numeri giocati vengano estratti (ambo secco):

Siccome i numeri estratti sono 5 numeri i casi favorevoli sono quelli in cui i due numeri giocati sono fissi C(2,2) e gli altri 3 numeri variabili, cioe' tutte le terne che si possono formare con gli 88 numeri restanti, cioè C(88,3).
Poichè i casi possibili sono tutte le cinquine che posso formare con i 90 numeri C(90,5), otteniamo:

                 C(88,3)*C(2 2)      2
P(ambo secco) = ---------------- = ----- = 0.002496878901373283 (~ 0,25%)
                    C(90,5)         801

C(88,3)*C(2,2) / C(90,5) = 109736 / 43949268 = 1/400.5 = 0.002496878901373283

(* (binom 88 3) (binom 2 2))
;-> 109736L
(div 109736 43949268)
;-> 0.002496878901373283
(div (div 109736 43949268))
;-> 400.5

Probabilità che 3 numeri giocati vengano estratti (terno secco):

C(87,2)*C(3,3) / C(90,5) = 3741 / 43949268 = 1/11748 = 8.512087163772556e-005

(* (binom 87 2) (binom 3 3))
;-> 3741L
(div 3741 43949268)
;-> 8.512087163772556e-005
(div (div 3741 43949268))
;-> 11748

Probabilità che 4 numeri giocati vengano estratti (quaterna secca):

C(86,1)*C(4,4) / C(90,5) = 86 / 43949268 = 1/511038 = 1.956801646844266e-006

(* (binom 86 1) (binom 4 4))
;-> 86L
(div 86 43949268)
;-> 1.956801646844266e-006
(div (div 86 43949268))
;-> 511038

Probabilità che 5 numeri giocati vengano estratti (cinquina secca):

C(85,0)*C(5,5) / C(90,5) = 1 / 43949268 = 2.275350752144495e-008

(* (binom 85 0) (binom 5 5))
;-> 1L
(div 43949268)
;-> 2.275350752144495e-008
(div (div 43949268))
;-> 43949268

B) Probabilità con 5 numeri giocati

Probabilità che 0 dei 5 numeri giocati venga estratto:

C(85,5)*C(5,0) / C(90,5) = 32801517 / 43949268 =

(* (binom 85 5) (binom 5 0))
;-> 32801517L
(div 32801517 43949268)
;-> 0.7463495637743045
(div (div 32801517 43949268))
;-> 1.339854739035393

Probabilità che 1 dei 5 numeri giocati venga estratto:

C(85,4)*C(5,1) / C(90,5) = 10123925 / 43949268 = 0.2303548036340446

(* (binom 85 4) (binom 5 1))
;-> 10123925L
(div 10123925 43949268)
;-> 0.2303548036340446
(div (div 10123925 43949268))
;-> 4.341129354474673

Probabilità che 2 dei 5 numeri giocati vengano estratti:

C(85,3)*C(5,2) / C(90,5) = 987700 / 43949268 = 0.02247363937893118

(* (binom 85 3) (binom 5 2))
;-> 987700
(div 987700 43949268)
;-> 0.02247363937893118
(div (div 987700 43949268))
;-> 44.4965758833654

Probabilità che 3 dei 5 numeri giocati vengano estratti:

C(85,2)*C(5,3) / C(90,5) = 35700 / 43949268 = 0.0008123002185155848

(* (binom 85 2) (binom 5 3))
;-> 35700L
(div 35700 43949268)
;-> 0.0008123002185155848
(div (div 35700 43949268))
;-> 1231.071932773109

Probabilità che 4 dei 5 numeri giocati vengano estratti:

C(85,1)*C(5,4) / C(90,5) = 425 / 43949268 = 9.670240696614104e-006

(* (binom 85 1) (binom 5 4))
;-> 425L
(div 425 43949268)
;-> 9.670240696614104e-006
(div (div 425 43949268))
;-> 103410.0423529412

Probabilità che 5 dei 5 numeri giocati vengano estratti:

C(85,0)*C(5,5) / C(90,5) = 1 / 43949268 = 2.275350752144495e-008

(* (binom 85 0) (binom 5 5))
;-> 1L
(div 43949268)
;-> 2.275350752144495e-008
(div (div 43949268))
;-> 43949268

Probabilità di estrazione su più ruote
--------------------------------------
Data la probabilità P di estrazione su una ruota di un evento (numero singolo o ambo o terno o quaterna o cinquina), per ottenere la probabilità di estrazione dello stesso evento su N ruote (considerando favorevoli i casi in cui esso esce su almeno una delle N ruote e che le estrazioni siano indipendenti una dall'altra) possiamo usare il teorema della probabilità composta.
La probabilità che l'evento non si verifichi è data da)
indicando con N il numero di ruote su cui si gioca e considerando che le estrazioni su ciascuna di esse sono indipendenti le une dalle altre, la probabilità di non estrazione su nessuna delle N ruote vale:

  Probabilità di non estrazione = (1-P)^N

Pertanto, la probabilità che l'evento si verifichi su almeno una delle N ruote vale:

  Probabilità di estrazione = 1 - (1-P)^N

Simulazione del gioco del lotto
-------------------------------
Adesso scriviamo delle funzioni per simulare il gioco del lotto e verificare i risultati matematici.
Per confrontare i numeri vincenti con i numeri estratti usiamo la funzione primitiva "difference", per esempio:

(setq win '(1 3 5 7 9))
(setq a '(3 1 7 5 9))
(setq b '(1 7 5 6))
(setq c '(5 4 8))
(setq d '(2 4 6 8 10))
(setq y '(2 1))

Tutti numeri uguali (5 giocati):
(difference win a)
;-> ()

3 numeri uguali (4 giocati):
(difference win b)
;-> (3 9)

1 numero uguale (3 giocati):
(difference win c)
;-> (1 3 7 9)

0 numeri uguali (5 giocati):
(difference win d)
;-> (1 3 5 7 9)

1 numero uguale (2 giocati):
(difference win y)
;-> (3 5 7 9)

Scriviamo due funzioni, una per calcolare le probabilità delle giocate secche e una per le calcolare le probabilità delle giocate con 5 numeri.

Funzione per simulare le giocate secche nel lotto:

(define (lotto-secco-test num iter)
  (local (conta urna ev estratti)
    (setq urna (sequence 1 90))
    (setq conta 0)
    (for (i 1 iter)
      ; scommessa secca
      ; estrazione dei num numeri giocati
      (setq ev (slice (randomize urna true) 0 num))
      ; estrazione dei 5 numeri vincenti
      (setq estratti (slice (randomize urna true) 0 5))
      (setq res (length (difference estratti ev)))
      ;(if (= res (- 5 num))
      ;  (println ev { } estratti { } res)
      ;)
      ; confronto vincenti con numeri giocati
      (if (= res (- 5 num)) (++ conta))
    )
    (div conta iter)))

Vediamo l'output delle simulazioni:

(lotto-secco-test 1 1e6)
;-> 0.055632
(lotto-secco-test 2 1e6)
;-> 0.002448
(lotto-secco-test 3 1e6)
;-> 8.1e-005
(lotto-secco-test 4 1e7)
;-> 1.7e-006
(lotto-secco-test 5 1e7)
;-> 0

Nota: quando le percentuali di un evento si avvicinano a zero, allora il processo di simulazione deve utilizzare un numero maggiore di iterazioni. Ad esempio, la cinquina ha una probabilità di uscita di 1 su 43949268 (43milioni 949mila 268), quindi per simulare il processo dovremmo usare tra 50 e 100 milioni di iterazioni. Questo è il motivo per cui l'ultimo valore della simulazione vale 0 (semplicemente perchè 1e7 iterazioni (10 milioni) non sono sufficienti per calcolare correttamente la probabilità della cinquina).

Proviamo con 100 milioni di iterazioni:
(time (println (lotto-secco-test 5 1e8)))
;-> 2e-008
;-> 504951.426

Funzione per simulare le giocate con 5 numeri nel lotto:

(define (lotto5-test num iter)
  (local (conta urna ev estratti)
    (setq urna (sequence 1 90))
    (setq conta 0)
    (for (i 1 iter)
      ; scommessa con 5 numeri
      ; estrazione dei 5 numeri giocati
      (setq ev (slice (randomize urna true) 0 5))
      ; estrazione dei 5 numeri vincenti
      (setq estratti (slice (randomize urna true) 0 5))
      (setq res (length (difference estratti ev)))
      ;(if (= res (- 5 num))
      ;  (println ev { } estratti { } res)
      ;)
      ; confronto vincenti con numeri giocati
      (if (= res (- 5 num)) (++ conta))
    )
    (div conta iter)))

Vediamo l'output delle simulazioni:

(lotto5-test 1 1e6)
;-> 0.231228
(lotto5-test 2 1e6)
;-> 0.022308
(lotto5-test 3 1e6)
;-> 0.000833
(lotto5-test 4 1e7)
;-> 8.5e-006
(lotto5-test 5 1e7)
;-> 0

Proviamo con 100 milioni di iterazioni:

(time (println (lotto5-test 5 1e8)))
;-> 2e-008
;-> 498999.692

La simulazione ottiene dei valori congruenti con i risultati calcolati matematicamente.

Per finire vediamo un metodo per ottimizzare le due funzioni di simulazione del lotto. Invece di utilizzare le funzioni "randomize" e "slice" usiamo "rand" con una lista di lunghezza variabile (ogni numero estratto viene tolto dalla lista). Scriviamo solo la funzione per le giocate secche:

(define (lotto-secco2-test num iter)
  (local (conta base urna ev estratti)
    (setq base (sequence 0 90))
    (setq conta 0)
    (for (i 1 iter)
      ; scommessa secca
      ; generazione numeri giocati (1 o 2 o 3 o 4 o 5)
      (setq urna base)
      (setq ev '())
      (for (i 0 (- num 1))
        (push (pop urna (+ 1 (rand (- 90 i)))) ev -1)
      )
      ; generazione numeri vincenti (5)
      (setq urna base)
      (setq estratti '())
      (for (i 0 4)
        (push (pop urna (+ 1 (rand (- 90 i)))) estratti -1)
      )
      (setq res (length (difference estratti ev)))
      ;(if (= res (- 5 num))
      ;  (println ev { } estratti { } res)
      ;)
      ; confronto vincenti con numeri giocati
      (if (= res (- 5 num)) (++ conta))
    )
    (div conta iter)))

Vediamo i risultati:

(lotto-secco2-test 1 1e6)
;-> 0.055617
(lotto-secco2-test 2 1e6)
;-> 0.002464
(lotto-secco2-test 3 1e6)
;-> 8.4e-005
(lotto-secco2-test 4 1e7)
;-> 1.6e-006
(time (println (lotto-secco2-test 5 1e8)))
;-> 4e-008
;-> 393129.225


-------------------
Hash-map e contesti
-------------------

In newLISP quando creiamo una hash-map creiamo un dizionario di contesto con lo stesso nome (in pratica una hash-map viene rappresentata con un contesto).
Nota:
Chiamiamo spesso i dizionari di contesto "hash", ma non c'è alcuna funzione di hash alla base di esso. "Hash" è solo un nome conveniente poiché la maggior parte degli altri linguaggi implementa la funzionalità di ricerca utilizzando le funzioni di hash.
In newLISP i dizionari sono costruiti separatamente come alberi binari bilanciati rosso-nero e solo la radice di esso - il nome del contesto - fa parte dello spazio dei simboli principale. Quindi non si verifica alcun "inquinamento" dello spazio dei nomi.

Per vedere la lisa dei contesti attivi possiamo utilizzare la funzione seguente:

(define (contexts-lst)
  (filter context? (map eval (symbols))))

Se usiamo la funzione in una nuove REPL otteniamo:

(contexts-lst)
;-> (Class MAIN Tree)

I contesti "Class", "MAIN" e "Tree" sono dei contesti predefiniti.
Definiamo un nuovo contesto con una funzione:

(context 'demo)
;-> demo
(define (pippo a b) (+ a b))
;-> (lambda (a b) (+ a b))
(context MAIN)
;-> MAIN

(pippo 1 2)
;-> ERR: invalid function : (pippo 1 2)
(demo:pippo 1 2)
;-> 3
(demo:demo)
;-> ERR: invalid function : (demo:demo)

Vediamo come si è modificata la lista dei contesti:

(contexts-lst)
;-> (Class MAIN Tree demo)

Adesso scriviamo una funzione che prende n numeri diversi da una lista di numeri e utilizza una hash-map "myHash":

(define (rand-range min-val max-val)
  (+ min-val (rand (+ (- max-val min-val) 1))))
(define (sample-rand num min-val max-val)
  (local (value out)
    (cond ((> num (+ max-val (- min-val) 1)) '()) ; controllo
          (true
            ; creazione di una hashmap
            (new Tree 'myHash)
            (until (= (length (myHash)) num)
              ; genera valore casuale
              (setq value (rand-range min-val max-val))
              ; inserisce valore casuale nell'hash
              (myHash (string value) value))
              ; assegnazione dei valori dell'hasmap ad una list
              (setq out (myHash))
              (setq out (map last out))
              ; eliminazione dell'hashmap
              ; ELIMINARE IL COMMENTO SEGUENTE
              ; PER IL CORRETTO FUNZIONAMENTO
              ; DELLA FUNZIONE
              ;(delete 'myHash)
              (sort out)))))

Nella funzione, l'espressione che elimina la hash-map (delete 'myHash) è commentata. In questo modo la funzione genera sempre gli stessi risultati (quelli contenuti nella hash-map "myHash").

(sample-rand 5 1 100)
;-> (1 20 57 59 81)
(sample-rand 5 1 100)
;-> (1 20 57 59 81)
(sample-rand 5 1 100)
;-> (1 20 57 59 81)

Vediamo come è cambiata la lista dei contesti:

(contexts-lst)
;-> (Class MAIN Tree demo myHash)

A questo punto il problema è il seguente, come riconoscere un contesto con funzioni da un contesto che rappresenta una hash-map?

Se elenchiamo i valori della hash-map otteniamo:

(myHash)
;-> (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))
(length (myHash))
;-> 5

Se elenchiamo i valori del contesto otteniamo:

(demo)
;-> ()
(length (demo))
;-> 0

Quindi una hash-map contiene una lista di valori, mentre un contesto con funzioni ha la lista vuota () (e ha lunghezza pari a 0).
Vediamo come possiamo identificare questa differenza.

Stampiamo la lista dei contesti:

(dolist (_el (symbols))
  (if (context? (eval _el)) (println _el)))
;-> Class
;-> MAIN
;-> Tree
;-> demo
;-> myHash
;-> nil

Per filtrare solo i contesti che sono hash-map dobbiamo vedere la lunghezza della lista dei valori del contesto:

(dolist (_el (symbols))
  (if (context? (eval _el))
      (println (eval _el) { } (length (eval _el)))))
;-> Class 2
;-> MAIN 0
;-> Tree 0
;-> demo 0
;-> myHash 0
;-> nil

Purtroppo la funzione "lenght" ha bisogno della valutazione del contesto (length (contesto)) e non del contesto stesso (length contesto). Per fare questo l'unico metodo che ho trovato è quello di ricorrere alla funzione "eval-string":

(dolist (_el (symbols))
  (if (and (context? (eval _el))
      (not (= _el 'MAIN))
      (not (= _el 'Tree))
      (not (= _el 'Class)))
      (println (eval _el) { } (eval-string (string "(" _el ")")))))
;-> demo ()
;-> myHash (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))
;-> nil

Miglioriamo un pò la stampa dei risultati:

(dolist (_el (symbols))
  (if (and (context? (eval _el))
      (not (= _el 'MAIN))
      (not (= _el 'Tree))
      (not (= _el 'Class)))
    (begin
      (setq ctxlst (eval-string (string "(" _el ")")))
      (println (eval _el) { } (length ctxlst))
      (println (eval _el) { } (eval-string (string "(" _el ")"))))))
;-> demo 0
;-> demo ()
;-> myHash 5
;-> myHash (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))
;-> nil

Adesso scriviamo una funzione che filtra i contesti che sono hash-map:

(define (hashmap-lst)
  (let (ctxlst '())
    (dolist (_el (symbols))
      (if (and (context? (eval _el))
          (not (= _el 'MAIN))
          (not (= _el 'Tree))
          (not (= _el 'Class)))
          (push (list (eval _el) (eval-string (string "(" _el ")"))) ctxlst -1)))
    ctxlst))

(hashmap-lst)
;-> ((demo ()) (myHash (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))))

Con la funzione "length" possiamo controllare se i due contesti hanno valori oppure sono la lista vuota:

(length (demo))
;-> 0
(length (myHash))
;-> 5

Eliminiamo i valori della hash-map "myHash":

(myHash "36" nil)
(myHash "48" nil)
(myHash "75" nil)
(myHash "83" nil)
(myHash "90" nil)

(hashmap-lst)
;-> ((demo ()) (myHash ()))

In questa ultima situazione non siamo in grado di stabilire se il contesto "myHash" (o "demo") è una hash-map.

Comunque quello che abbiamo visto ci permette di migliorare la funzione "free-vars" in modo da elencare anche le hash-map:

(define (free-vars _ctx)
"Print a list of free symbols/variables"
  (local (_vars _lst-ctx)
    (if (= _ctx nil) (setq _ctx (context)))
    (setq _vars '())
    (setq _lst-ctx '())
    (dolist (_el (symbols _ctx))
      ;(if (= _el myHash) (println _el))
      (if (and (context? (eval _el))
               (not (= _el '_ctx))
               (not (= _el 'MAIN))
               (not (= _el 'Tree))
               (not (= _el 'Class)))
          (push (eval _el) _lst-ctx -1))
      (if (and (not (lambda? (eval _el)))
               (not (primitive? (eval _el)))
               (not (protected? _el))
               (not (global? _el))
               (not (= _el '_ctx))
               (not (= _el '_lst-ctx))
               (not (= _el '_vars))
               (not (= _el '_el))
               (not (= _el '_v)))
          (push _el _vars -1))
    )
    (dolist (_v _vars)
      (if (eval _v)
        (println _v { } (eval _v)))
    )
    (dolist (_v _lst-ctx)
      (if (eval _v)
        (println (eval _v) { } (eval-string (string "(" _v ")")))
      )
    )
    nil))

Ricreiamo i valori nella hash-map "myHash":

(sample-rand 5 1 100)

E creiamo una variabile:

(setq z 999)

Adesso possiamo provare la funzione free-:vars

(free-vars)
;-> ctxlst (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))
;-> z 999
;-> demo ()
;-> myHash (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))

Suggerimento di ralph.ronnquist:

1) a "hashmap" is a context without default functor, i.e.
(and (context? S) (nil? (sym (term S) S nil)))

2) using the symbol as functor results in its list if entries, i.e.
(apply S)

La seguente funzione è un tentativo (parzialmente fallito) di identificare le hash-map:

(define (test)
  (dolist (el (symbols))
    (if (and (context? (eval el))
             ;(= el 'myHash)
             ; suggerimento di ralph.ronnquist
             (nil? (eval (sym (term el) el nil))))
        (begin
          ; (prefix el) -> stringa
          (println "(prefix el): " (prefix el))
          ; (term el) -> stringa
          (println "(term el): " (term el))
          (println "(sym (term el)): " (sym (term el)))
          ; converte la stringa in simbolo
          (setq S (sym (term el) el nil))
          (println "S: " S)
          (println (eval (sym (term el) el nil)))
          ;(apply S)
          (println "------------")
        )
    )))

(test)
;-> (prefix el): MAIN
;-> (term el): Tree
;-> (sym (term el)): Tree
;-> S: Tree:Tree
;-> nil
;-> ------------
;-> (prefix el): MAIN
;-> (term el): demo
;-> (sym (term el)): demo
;-> S: demo:demo
;-> nil
;-> ------------
;-> (prefix el): MAIN
;-> (term el): myHash
;-> (sym (term el)): myHash
;-> S: myHash:myHash
;-> nil
;-> ------------

Nota: un contesto può contenere funzioni ed essere una hash-map Per esempio, modifichiamo il contesto "demo" creando una hash-map con lo stesso nome:

(demo "1" 1)
;-> 1
(demo "2" 2)
;-> 2

Adesso "demo" è un contesto con funzioni e una hash-map:

(demo:pippo 3 5)
;-> 8
(demo)
;-> (("1" 1) ("2" 2))
(demo:demo)
;-> ERR: invalid function : (demo:demo)

Possiamo creare anche il "funtore" del contesto "demo":

(context 'demo)
(define (demo)
  (println "Functor"))
(context MAIN)

(demo:demo)
;-> Functor

Invece di utilizzare (context 'demo) o (define (demo:demo)...) per creare un hash-map è meglio utilizzare (new Tree 'demo): il risultato è lo stesso, tranne che viene creato il funtore di default "demo:demo" come costante (con valore nil)).

Nota: quando definiamo direttamente un funtore (contesto e funzione con lo stesso nome), allora la funzione "hashmap-lst" genera un errore quando il funtore ha dei parametri. Infatti l'espressione "(eval _el)" valuta il funtore senza parametri.

Esempio:
(define (tt:tt a b) (+ a b))

(hashmap-lst)
;-> ERR: value expected in function + : nil
;-> called from user function (tt)
;-> called from user function (MAIN:hashmap-lst)

Dopo un pò di tempo ho trovato una soluzione parziale all'identificazione di una hash-map. La seguente funzione identifica correttamente come hash-map tutti i contesti il cui funtore non è una funzione (list?):

(define (hash? hash)
  (and (context? (eval hash))
       (not (list? (eval (sym (term hash) hash nil))))))

Come funziona?
L'espressione (sym (term hash) hash nil) restituisce il funtore hash:hash e poi verifichiamo se tale funtore sia una funzione (list? restituisce true) oppure no (list? restituisce nil).
Questo metodo identifica correttamente tutte le hash-map create con la funzione "new Tree".

Nota:
Se assegniamo una hash-map ad un simbolo/variabile non viene creata una copia della hash-map, ma solo un simbolo che punta alla hash-map originale. In questo modo i valori delle due hash-map sono sempre uguali anche quando modifichiamo una sola delle due hash-map (perchè i simboli delle due hash-map puntano agli stessi indirizzi di memoria).
Per esempio:

(setq hh myHash)
;-> myHash
(hh)
;-> (("1" 1) ("20" 20) ("57" 57) ("59" 59) ("81" 81))

Modifichiamo un valore di hh:
(hh "1" 0)
;-> 0
Modifichiamo un valore di myHash:
(myHash "20" 0)
;-> 0

Vediamo che i valori delle due-hashmap sono gli stessi:
(hh)
;-> (("1" 0) ("20" 0) ("57" 57) ("59" 59) ("81" 81))
(myHash)
;-> (("1" 0) ("20" 0) ("57" 57) ("59" 59) ("81" 81))

Nota: per una questione di stile, è meglio definire in anticipo tutti gli hash e creare altri contesti nel contesto MAIN come tutti gli altri simboli utilizzati a livello globale. In progetti newLISP più grandi o quando si lavora con diversi programmatori sullo stesso progetto in questo modo si evitano conflitti/problemi.


-----------------
Numeri di Motzkin
-----------------

Dati n punti su una circonferenza, si definisce come numero di Motzkin, M(n), il numero di modi in cui si possono tracciare tra questi delle corde non intersecanti, senza che tutti i punti siano necessariamente toccati da una corda.
La successione di questi numeri interi prende il nome dal matematico americano Theodore Motzkin.

Sequenza OEIS A001006:
  1, 1, 2, 4, 9, 21, 51, 127, 323, 835, 2188, 5798, 15511, 41835, 113634,
  310572, 853467, 2356779, 6536382, 18199284, 50852019, 142547559,
  400763223, 1129760415, 3192727797, 9043402501, 25669818476, 73007772802,
  208023278209, ...

I numeri di Motzkin soddisfano la seguente relazione ricorsiva:

                (n-2)                2*n + 1            3*n - 3
  M(n) = M(n-1) + ∑ M(i)*M(n-2-i) = ---------*M(n-1) + ---------*M(n-2)
                i=0                  n + 2              n + 2

Funzione che usa la ricorsione per calcolare il numero di Motzkin:

(define (motzkin1 num)
  (cond ((or (= num 0) (= num 1))
         1)
        (true
          (/ (+ (* (+ (* 2 num) 1) (motzkin1 (- num 1)))
                (* (- (* 3 num) 3) (motzkin1 (- num 2))))
             (+ num 2))
        )))

(map motzkin1 (sequence 0 20))
;-> (1 1 2 4 9 21 51 127 323 835 2188 5798 15511 41835 113634 310572
;->  853467 2356779 6536382 18199284 50852019)

Funzione che usa la programmazione dinamica per calcolare il numero di Motzkin:

(setq pp (array (+ 4 1) '(0)))

(define (motzkin2 num)
  (let (dp (array (+ num 1) '(0)))
    (cond ((= num 0)
           (setf (dp 0) 1))
          ((= num 1)
           (setf (dp 0) 1)
           (setf (dp 1) 1))
          ((> num 1)
           (setf (dp 0) 1)
           (setf (dp 1) 1)
           (for (i 2 num)
             (setf (dp i) (/ (+ (* (+ (* 2 i) 1) (dp (- i 1)))
                                (* (- (* 3 i) 3) (dp (- i 2))))
                             (+ i 2)))))
    )
    (dp num)))

(map motzkin2 (sequence 0 20))
;-> (1 1 2 4 9 21 51 127 323 835 2188 5798 15511 41835 113634 310572
;->  853467 2356779 6536382 18199284 50852019)

Poichè utilizziamo solo gli ultimi due valori della matrice dp per calcolare il valore successivo, allora possiamo evitare di usare una matrice ed utilizzare semplicemente due variabili a e b. Questo velocizza un pò la funzione, ma perdiamo i valori dei numeri di Motzkin precedenti (che invece vengono mantenuti con la matrice dp).

Funzione che usa l'iterazione pura per calcolare il numero di Motzkin:

(define (motzkin3 num)
  (let ((a 1) (b 1) (c 0))
    (cond ((or (= num 0) (= num 1))
           (setq b 1))
          ((> num 1)
           (for (i 2 num)
             (setq c (/ (+ (* (+ (* 2 i) 1) b)
                           (* (- (* 3 i) 3) a))
                           (+ i 2)))
             (setq a b)
             (setq b c)))
    )
  b))

(map motzkin3 (sequence 0 20))
;-> (1 1 2 4 9 21 51 127 323 835 2188 5798 15511 41835 113634 310572
;->  853467 2356779 6536382 18199284 50852019)

I valori dei numeri di Motzkin crescono molto velocemente, quindi per calcolarli in modo corretto occorre utilizzare i big integer.
La seguente espressione produce un risultato errato:

(motzkin3 100)
;-> -17402571795490030 ;risultato errato

Modifichiamo la funzione che usa la programmazione dinamica per utilizzare i big integer:

(define (motzkin-big num)
  (let (dp (array (+ num 1) '(0)))
    (cond ((= num 0)
           (setf (dp 0) 1L))
          ((= num 1)
           (setf (dp 0) 1L)
           (setf (dp 1) 1L))
          ((> num 1)
           (setf (dp 0) 1L)
           (setf (dp 1) 1L)
           (for (i 2 num)
             (setf (dp i) (/ (+ (* (+ (* 2L i) 1L) (dp (- i 1)))
                                (* (- (* 3L i) 3L) (dp (- i 2))))
                             (+ i 2L)))))
    )
    (dp num)))

(motzkin-big 10)
;-> 2188L
(motzkin-big 100)
;-> 737415571391164350797051905752637361193303669L


------------------
Numeri di Narayana
------------------

I numeri Narayana formano una matrice triangolare di numeri naturali, chiamato triangolo di Narayana, che si verificano in vari problemi di calcolo combinatorio (parole di Dick, cammini reticolari monotoni, alberi con radice, ecc.).

I numeri di Narayana possono essere espressi in termini di coefficienti binomiali nel modo seguente:

  N(n,k) = (1/n)*binom(n,k)*binom(n, k-1)

Le prime dieci righe ti tale disposizione sono:[3]

k =       1   2   3   4   5   6   7   8   9   10
------------------------------------------------
n = 1  |  1
    2  |  1   1
    3  |  1   3   1
    4  |  1   6   6   1
    5  |  1  10  20  10   1
    6  |  1  15  50  50  15   1
    7  |  1  21 105 175 105  21   1
    8  |  1  28 196 490 490 196  28   1
    9  |  1  36 336 1176 1764 1176 336 36 1
   10  |  1  45 540 2520 5292 5292 2520 540 45 1

Più in generale, si può dimostrare che il triangolo Narayana è simmetrico:

   N(n,k) = N(n,n-k+1)

La somma delle righe in questo triangolo è uguale ai numeri catalani:

   N(n,1) + N(n,2) + N(n,3) + ... + N(n,n) = Catalan(n)

Sequenza OEIS A001263:
  1, 1, 1, 1, 3, 1, 1, 6, 6, 1, 1, 10, 20, 10, 1, 1, 15, 50, 50, 15, 1, 1,
  21, 105, 175, 105, 21, 1, 1, 28, 196, 490, 490, 196, 28, 1, 1, 36, 336,
  1176, 1764, 1176, 336, 36, 1, 1, 45, 540, 2520, 5292, 5292, 2520, 540, 45,
  1, 1, 55, 825, 4950, 13860, 19404, 13860, 4950, 825, ...

Scriviamo una funzione che calcola il numero di Narayana per un dato n e k:

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (narayana n k)
  (/ (* (binom n k) (binom n (- k 1))) n))

(narayana 5 4)
;-> 10L
(narayana 7 4)
;-> 175L

Adesso scriviamo la funzione per calcolare il triangolo di narayana fino ad un dato n e k:

(define (triangle-narayana n k)
  (local (out kappa)
    (setq out '())
    (for (i 1 n)
      ; lista dei numeri di Narajana da 1 a k per un determinato n
      (setq kappa '())
      (for (j 1 k)
        (push (narayana i j) kappa -1)
      )
      (push (list i kappa) out -1)
    )
    out))

(triangle-narayana 10 10)
;-> ((1 (1L 0 0 0 0 0 0 0 0 0))
;->  (2 (1L 1L 0 0 0 0 0 0 0 0))
;->  (3 (1L 3L 1L 0 0 0 0 0 0 0))
;->  (4 (1L 6L 6L 1L 0 0 0 0 0 0))
;->  (5 (1L 10L 20L 10L 1L 0 0 0 0 0))
;->  (6 (1L 15L 50L 50L 15L 1L 0 0 0 0))
;->  (7 (1L 21L 105L 175L 105L 21L 1L 0 0 0))
;->  (8 (1L 28L 196L 490L 490L 196L 28L 1L 0 0))
;->  (9 (1L 36L 336L 1176L 1764L 1176L 336L 36L 1L 0))
;->  (10 (1L 45L 540L 2520L 5292L 5292L 2520L 540L 45L 1L)))

Funzione per calcolare la sequenza OEIS:

(define (A001263 n k)
  (local (out nara)
    (setq out '())
    (for (i 1 n)
      (for (j 1 k)
        (setq nara (narayana i j))
        (if (!= nara 0)
            (push (narayana i j) out -1)
        )
      )
    )
    out))

(A001263 10 10)
;-> (1L 1L 1L 1L 3L 1L 1L 6L 6L 1L 1L 10L 20L 10L 1L 1L 15L 50L 50L 15L
;->  1L 1L 21L 105L 175L 105L 21L 1L 1L 28L 196L 490L 490L 196L 28L 1L
;->  1L 36L 336L 1176L 1764L 1176L 336L 36L 1L 1L 45L 540L 2520L 5292L
;->  5292L 2520L 540L 45L 1L)


----------------------------------------
Permutazioni, Disposizioni, Combinazioni
----------------------------------------

Formule per il calcolo del numero di permutazioni, disposizioni e combinazioni
------------------------------------------------------------------------------
Permutazione di n elementi: P(n) = n!
Permutazioni di n elementi con un elemento ripetuto m volte: P(n,m) = n!/m!
Permutazioni di n elementi con "a" ripetuto k1 volte, "b" ripetuto k2 volte, "c" ripetuto k3 volte, ecc.: P(n,k1!,k2!,k3!,...,km!) = n!/(k1!*k2!*k3!*...*km!)
Permutazioni cicliche di n elementi in una circonferenza: PC(n) = (n - 1)!
Disposizioni semplici di n elementi presi k a k: D(n,k) = n*(n-2)* ... *(n - k + 1)
Disposizioni con ripetizione di n elementi presi k a k con possibile ripetizione di ogni elemento fino a k volte: DR(n,k) = n^k
Combinazioni semplici di n elementi presi k a k: C(n,k) = D(n,k) / P(k) = (n*(n-2)* ... *(n - k + 1))/k!
Combinazioni con ripetizione di n elementi con possibile ripetizione di ogni elemento fino a k volte: CR(n,k) = C(n+k-1,k)

Permutazioni - P(n)
-------------------
Dati n elementi distinti, si dicono permutazioni, P(n), i gruppi che si possono formare in modo che:
- ogni gruppo contenga tutti gli n elementi (ogni elemento contato una sola volta)
- ogni gruppo differisca dagli altri solo per l'ordine degli elementi

Nota: una permutazione è una corrispondenza biunivoca di un insieme con se stesso.

Esempi:
Per n = 2: (ab ba)
Per n = 3: (abc acb bac bca cab cba)
Per n = 4: (abcd abdc acbd acdb adbc adcb
            bacd badc bcad bcda bdac bdca
            cabd cadb cbad cbda cdab cdba
            dabc dacb dbac dbca dcab dcba)

Numero di permutazioni di n elementi: P(n) = n!

Funzione per il calcolo del Fattoriale:
  fattoriale(n) = n!

(define (fact num)
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione per il calcolo del numero di Permutazioni:
  P(n) = n!

(define (P n) (fact n))

Permutazioni di n elementi non tutti diversi - PR(n,k1,k2,k3,...km)
-------------------------------------------------------------
Queste permutazioni si hanno quando:
- negli n elementi da permutare ve ne è uno ripetuto m volte
- oppure ve ne sono diversi ripetuti, a1 ripetuto k1 volte, a2 ripetuto k2 volte, a3 ripetuto k3 volte, ecc.
Esempio:
Ad esempio, se vogliamo costruire le permutazioni di "abcc" prendiamo le permutazioni di 4 elementi, abcd e sostituiamo c al posto di d, poi eliminiamo le permutazioni uguali:
Per n = 4: (abcd abdc acbd acdb adbc adcb
            bacd badc bcad bcda bdac bdca
            cabd cadb cbad cbda cdab cdba
            dabc dacb dbac dbca dcab dcba)

Sostituiamo:
(abcc abcc acbc accb acbc accb
 bacc bacc bcac bcca bcac bcca
 cabc cacb cbac cbca ccab ccba
 cabc cacb cbac cbca ccab ccba)

Eliminiamo i doppioni:
(abcc abcc acbc accb acbc accb
 bacc bacc bcac bcca bcac bcca
 cabc cacb cbac cbca ccab ccba
 cabc cacb cbac cbca ccab ccba)

Si procede allo stesso modo se gli oggetti ripetuti sono più di uno.

Numero di prmutazioni di n elementi non tutti diversi: PR(n, k1, k2, k3,...,km) = n! / k1!*k2!*k3!*...*km!

Funzione per il calcolo del numero di Permutazioni con ripetizione:
  PR(n, k1, k2, k3,...,km) = n! / k1!*k2!*k3!*...*km!

(define (PR n rip)
  (/ (fact n) (apply * (map fact rip))))

(PR 10 '(2 3 4))
;-> 12600L


Permutazioni cicliche - PC(n)
-----------------------------
Sono le permutazioni di n elementi lungo una circonferenza (o circuito chiuso).
Vediamo la dimostrazione seguendo un esempio:
Esempio:
lista = A B C
permutazioni semplici = (A B C) (B A C) (B C A) (A C B) (C A B) (C B A)
Se rappresentiamo queste permutazioni intorno ad un cerchio, notiamo che alcune di loro sono equivalenti:

      A           B           B           A           C           C
    C   B       C   A       A   C       B   C       B   A       A   B
     (1)         (2)         (3)         (4)         (5)         (6)

La (1), la (3) e la (5) sono equivalenti (sono tutte rotazioni una dell'altra).
La (2), la (4) e la (6) sono equivalenti (sono tutte rotazioni una dell'altra).

Quindi abbiamo solo due permutazioni circolari uniche. Poichè il numero di permutazioni semplici vale n!, ed ogni permutazione semplice ha n permutazioni circolari equivalenti, possiamo calcolare il numero di permutazioni circolari in questo modo:

numero_permutazioni_circolari(n) = numero_permutazioni_semplici(n) / n = n!/n = (n - 1)!

Numero di permutazioni cicliche: PC(n) = (n-1)!

Funzione per il calcolo del numero di Permutazioni cicliche:
  PC(n) = (n - 1)!

(define (PC n) (fact (- n 1)))

Disposizioni semplici - D(n,k)
------------------------------
Dati n elementi distinti e un numero k<=n si dicono disposizioni di questi n elementi, presi a k a k (o di classe k), D(n,k), tutti i gruppi che si possono formare con gli elementi dati, in modo che:
- ogni gruppo contenga k elementi distinti
- due gruppi qualunque differiscano fra loro per qualche elemento oppure per l'ordine in cui gli elementi sono disposti

Nota: nelle disposizioni ha importanza l'ordine degli elementi.

Esempi:
Le disposizioni semplici di 3 elementi (abc) presi a 2 a 2 sono:
(ab ac ba bc ca cb)
Le disposizioni semplici di 4 elementi (abcd) presi a 3 a 3 sono:
(abc abd acb acd adb adc bac bad
 bca bcd bda bdc cab cad cba cbd
 cda cdb dab dac dba dbc dca dcb)

Nota. Se tutti gli elementi sono distinti (cioè k=n), allora la formula è uguale a quella delle permutazioni: D(n,k=n) = n!.
Se invece gli elementi sono tutti uguali k=1, c'è una sola disposizione semplice: D(n,1) = 5.

Numero di disposizioni semplici: D(n,k) = n(n-1)(n-2)...(n-k+1) = n!/(n - k)! = n!/(n - k)!

Funzione per il calcolo del numero di Disposizioni semplici:
  D(n,k) = n(n-1)(n-2)...(n-k+1) = n!/(n - k)!

(define (D n k)
  (/ (fact n) (fact (- n k))))

(define (D2 n k)
  (let (out 1L)
    (for (i 0 (- k 1))
      (setq out (* out (- n i)))
    )
    out))

(D 3 2)
;-> 6L
(D2 3 2)
;-> 6L
(D 12 6)
;-> 665280L
(D2 12 6)
;-> 665280L

Esempio:
A una gara partecipano 10 atleti. Quante sono le possibili disposizioni dei primi tre posti sul podio?
I dati del problema sono n = 10 e k = 3.
Le disposizioni semplici sono D(10,3) = 720
(D 10 3)
;-> 720L

Disposizioni con ripetizione - DR(n,k)
-------------------------------------
Dati n elementi distinti e un numero k<=n si dicono disposizioni con ripetizione di questi n elementi, presi a k a k (o di classe k), D(n,k), tutti i gruppi che si possono formare con gli elementi dati, in modo che:
- ogni gruppo contenga k elementi non necessariamente distinti
- ogni elemento possa trovarsi ripetuto nel gruppo fino a k volte
- due gruppi qualunque differiscano fra loro per qualche elemento oppure per l'ordine in cui gli elementi sono disposti
Esempi:
Le disposizioni con ripetizione di 3 elementi (abc) presi a 2 a 2 sono:
(aa ab ac ba bb bc ca cb cc)
Le disposizioni con ripetizione di 4 elementi (abcd) presi a 3 a 3 sono:
(aaa aab aac aad aba abb abc abd
 aca acb acc acd ada adb adc add
 baa bab bac bad bba bbb bbc bbd
 bca bcb bcc bcd bda bdb bdc bdd
 caa cab cac cad cba cbb cbc cbd
 cca ccb ccc ccd cda cdb cdc cdd
 daa dab dac dad dba dbb dbc dbd
 dca dcb dcc dcd dda ddb ddc ddd)

Numero di disposizioni con ripetizione: DR(n,k) = n^k

Funzione per il calcolo del numero di Disposizioni con ripetizione:
  DR(n,k) = n^k

(define (DR n k) (pow n k))

Esempio:
Con tre lettere A,B,C quante stringhe diverse da due lettere si possono creare?
I dati del problema sono n = 3 e k = 2.
Le disposizioni con ripetizione di classe k=2 sono DR(3,2) = 3^2 = 9
(DR 3 2)
;-> 9

Nota: Ecco tutte le 9 disposizioni con ripetizione possibili. Le disposizioni semplici (senza ripetizione) sono invece 3*2=6. Questo esempio rende più chiara la differenza tra le disposizioni semplici e le disposizioni con ripetizione.
  Disposizioni            Disposizioni
  con ripetizione         senza ripetizione
  AA                      AA (non valida)
  AB                      AB
  AC                      AC
  BA                      BA
  BB                      BB (non valida)
  BC                      BC
  CA                      CA
  CB                      CB
  CC                      CC (non valida)

Combinazioni semplici - C(n,k)
------------------------------
Dati n elementi distinti e un numero intero positivo k<=n, si chiamano combinazioni C(n,k) di questi n elementi, a k a k (o di classe k), tutti gruppi che si possono formare con gli elementi dati, in modo che:
- ciascun gruppo contenga k elementi
- due gruppi qualunque differiscano per almeno un elemento.

Nota: in una combinazione l'ordine degli elementi non è importante.

Esempi:
Le combinazioni di 3 elementi (abc) presi a 2 a 2 sono:
(ab ac bc)
Le combinazioni di 4 elementi (abcd) presi a 3 a 3 sono:
(abc abd acd bcd)

Numero di combinazioni semplici:
C(n,k) = D(n,k) / P(k)
C(n,k) = [n*(n-1)*(n-2)*...*(n-k+1)] / k! = n! / (k!*(n - k)!)

Funzione per il calcolo del numero di Combinazioni semplici:
  C(n,k) = [n*(n-1)*(n-2)*...*(n-k+1)] / k! = n! / (k!*(n - k)!)

Nota: L'espressione n! / (k!*(n - k)!) è il cofficiente binomiale.

Funzione per il calcolo del Coefficiente binomiale:

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (C n k) (binom n k))

(C 10 2)
;-> 45L

Esempio:
Dato un insieme con le tre lettere I = (A B C), trovare le combinazioni di classe 2 semplici, ossia i raggruppamenti possibili delle lettere prese a coppia.
In questo caso n = 3 e k = 2.
Applicando la formula per il calcolo delle combinazioni semplici C(3,2)= 3!/(2!*(3−2)!) = 6/2 = 3.
Le combinazioni semplici possibili sono tre: (A B), (A C), (B C).

Combinazioni con ripetizione
----------------------------
Dati n elementi distinti e un numero intero positivo k<=n, si chiamano combinazioni con ripetizione CR(n,k) di questi n elementi, a k a k (o di classe k), tutti gruppi che si possono formare con gli elementi dati, in modo che:
- ciascun gruppo contenga k elementi
- ogni elemento possa trovarsi ripetuto nel gruppo fino a k volte
- due gruppi qualunque differiscano per almeno un elemento
Esempi:
Le combinazioni con ripetizione di 3 elementi (abc) presi a 2 a 2 sono:
(aa ab ac bb bc cc)
Le combinazioni con ripetizione di 4 elementi (abcd) presi a 3 a 3 sono:
(aaa aab aac aad abb abc abd acc acd add
 bbb bbc bbd bcc bcd bdd ccc ccd cdd ddd)

Numero di combinazioni con ripetizione:
CR(n,k) = C(n+k-1,k)

Funzione per il calcolo del numero di Combinazioni con ripetizione:
  CR(n,k) = C(n+k-1,k)

(define (CR n k) (binom (+ n k (- 1)) k))

(CR 10 2)
;-> 55L

Esempio:
Dato un insieme con le tre lettere I = (A B C), trovare le combinazioni di classe 2 semplici, ossia i raggruppamenti possibili delle lettere prese a coppia. In ogni coppia può esserci anche due volte la stessa lettera.
In questo caso n = 3 e k = 2.
Applicando la formula per il calcolo delle combinazioni con ripetizione CR(3,2)= (3+2-1)!/(2!*(3−1)!) = 24/4 = 6.
Le combinazioni con ripetizione possibili sono sei: (A A), (A B), (A C), (B B), (B C), (C C).

La differenza tra disposizioni e combinazioni
---------------------------------------------
Nelle disposizioni è importante l'ordine degli elementi. Nelle combinazioni, invece, non conta l'ordine degli elementi.
Esempio.
Le stringhe AB e BA sono due disposizioni diverse ma identificano una sola combinazione (AB). Le combinazioni sono insiemi di lettere in cui l'ordine non conta. Le disposizioni sono invece delle stringhe dove l'ordine è importante.

La differenza tra disposizioni e permutazioni
---------------------------------------------
Nelle disposizioni definisco raggruppamenti con k<n elementi.
Nelle permutazioni, invece, prendo in considerazione dei raggruppamenti con n elementi.
Nota. Se k=n il numero delle disposizioni semplici è uguale a quello delle permutazioni.

Come risolvere i problemi di Calcolo Combinatorio
-------------------------------------------------
Diagramma per capire se usare una permutazione, una disposizione o una combinazione.

                          +--------------------------+
                          |  Nei raggruppamenti      |
                          |  l'ordine è importante?  |
                          +--------------------------+
                             /                   \
                            /                     \
                           /                       \
                       +------+                 +------+
                       |  SI  |                 |  NO  |
                       +------+                 +------+
                          |                         |
                          |                         |
           +-----------------------------+   +--------------+
           | Permutazioni o Disposizioni |   | Combinazioni |
           +-----------------------------+   +--------------+
                         |                         |
                         |                         |
                   +---------+              +-------------------+
                   | k = n ? |              | Elemento ripetuto |
                   +---------+              | nel gruppo?       |
                     /     \                +-------------------+
                    /       \                     /       \
             +------+       +------+        +------+     +------+
             |  SI  |       |  NO  |        |  SI  |     |  NO  |
             +------+       +------+        +------+     +------+
                /               \              /               \
               /                 \            /                 \
    +--------------+    +--------------+   +--------------+   +--------------+
    | Permutazioni |    | Disposizioni |   | Combinazioni |   | Combinazioni |
    +--------------+    +--------------+   | Semplici     |   | con Ripetiz  |
           /                          \    +--------------+   +--------------+
          /                            \
         /                              \
   +----------------------+           +-------------------+
   | I k (=n) elementi    |           | Elemento ripetuto |
   | sono tutti distinti? |           | nel gruppo?       |
   +----------------------+           +-------------------+
        /            \                     /            \
       /              \                   /              \
   +------+        +------+            +------+        +------+
   |  SI  |        |  NO  |            |  SI  |        |  NO  |
   +------+        +------+            +------+        +------+
      |                |                  |                 |
      |                |                  |                 |
+--------------+   +--------------+   +--------------+    +--------------+
| Permutazioni |   | Permutazioni |   | Disposizioni |    | Disposizioni |
| Semplici     |   | con Ripetiz  |   | con ripetiz  |    | Semplici     |
+--------------+   +--------------+   +--------------+    +--------------+

Esempio 1
---------
Le targhe automobilistiche sono formate nel modo seguente:

  lettera lettera numero numero numero lettera lettera

Quante auto si possono immatricolare con l'alfabeto internazionale di 26 lettere e i numeri da 0 a 9?

Abbiamo 3 raggruppamenti diversi:

1) lettera lettera

In questo caso k = 2 e n = 26.
L'ordine ha importanza? si (e poichè k ≠ n, allora dobbiamo usare le disposizioni).
Un elemento può essere ripetuto nel gruppo? si

Quindi si tratta di Disposizioni con ripetizione di classe k. Quindi il primo gruppo può essere raggruppato in:

DR(26,2) = 26^2 = 676

2) numero numero numero

In questo caso k = 3 e n = 10.
L'ordine ha importanza? si (e poichè k ≠ n, allora dobbiamo usare le disposizioni).
Un elemento può essere ripetuto nel gruppo? si

Quindi si tratta di Disposizioni con ripetizione di classe k. Quindi il primo gruppo può essere raggruppato in:

DR(10,3) = 10^3 = 1000

3) lettera lettera

In questo caso k = 2 e n = 26.
L'ordine ha importanza? si (e poichè k ≠ n, allora dobbiamo usare le disposizioni).
Un elemento può essere ripetuto nel gruppo? si

Quindi si tratta di Disposizioni con ripetizione di classe k. Quindi il primo gruppo può essere raggruppato in:

DR(26,2) = 26^2 = 676

Quindi in totale si possono immatricolare:

DR(26,2) * DR(10,3) * DR(26,2) = 676 * 1000 * 676 = 456976000 auto

Esempio 2
---------
Una classe di 27 ex-compagni di scuola si rivedono per una cena. Alla fine, ognuno stringe la mano a tutti gli altri compagni. Quante strette di mano sono avvenute?

In questo caso k = 2 e n = 27.
L'ordine ha importanza? no, perchè le strette di mano non hanno un ordine (quindi dovremo usare le combinazioni).
Un elemento può essere ripetuto nel gruppo? no, perchè nessuno si stringe la mano da solo.

Quindi si tratta di Combinazioni semplici: C(27,2) = 27!/(2!*(27-2)!) = 351

Esempio 3
---------
Una squadra di 8 persone va a cena tutte le settimane dopo la partitadi calcetto.
Quante posizioni diverse possono assumere nella tavolata?

In questo caso k = 8 e n = 8.
L'ordine ha importanza? si, infatti ogni posizione è diversa in base all'ordine (e poichè k = n, allora dobbiamo usare le Permutazioni).
Un elemento può essere ripetuto nel gruppo: no, poichè gli elementi sono tutti distinti.

Quindi si tratta di Permutazioni semplici: P(8) = 8! = 40320 posizioni.


------------------------------------
Valore massimo di una lista ordinata
------------------------------------

Data una lista ordinata (di cui non si conosce il tipo di ordinamento) trovare l'elemento massimo.

Risolviamo il problema con due metodi: nel primo metodo utilizziamo le primitive di newLISP, mentre nel secondo metodo utilizziamo un algoritmo ad-hoc.

Primo metodo
------------
Per calcolare il valore massimo della lista usiamo la primitiva "max":

(define (f1 lst) (apply max lst))

Secondo metodo
--------------
Notiamo che la lista può essere ordinata in uno dei seguenti modi:
1) Strettamente decrescente
2) Decrescente
3) Tutti elementi uguali
4) Crescente
5) Strettamente decrescente
Il nostro algoritmo calcola la differenza tra il primo e l'ultimo elemento della lista:
- se la differenza vale 0, allora la lista contiene tutti numeri uguali (prendiamo un numero qualunque)
- se la differenza è maggiore di zero, allora la lista è decrescente o strettamente decrescente (prendiamo il primo numero della lista)
- se la differenza è minore di zero, allora la lista è crescente o strettamente crescente (prendiamo l'ultimo numero della lista)
Scriviamo la funzione che implementa l'algoritmo:

(define (f2 lst)
  (let (val (- (lst 0) (lst -1)))
    (cond ((> val 0) (lst 0))  ; lista decrescente
          ((< val 0) (lst -1)) ; lista crescente
          (true (lst 0)))))    ; tutti elementi uguali

Creiamo tre liste per effettuare i test:

(silent
(setq a (sequence 1 10000))
(setq b (reverse (copy a)))
(setq c (dup '10000 10000)))

(f1 a)
;-> 10000
(f1 b)
;-> 10000
(f1 c)
;-> 10000

(f2 a)
;-> 10000
(f2 b)
;-> 10000
(f2 c)
;-> 10000

Vediamo i tempi di esecuzione:

(time (f1 a) 10000)
;-> 1461.643
(time (f2 a) 10000)
;-> 512.362

(time (f1 b) 10000)
;-> 1461.585
(time (f2 b) 10000)
;-> 504.808

(time (f1 c) 10000)
;-> 1468.911
(time (f2 c) 10000)
;-> 516.737

Proviamo con liste più grandi (un milione di elementi):

(silent
(setq a (sequence 1 1000000))
(setq b (reverse (copy a)))
(setq c (dup '1000000 1000000)))

(time (f1 a) 100)
;-> 2009.643
(time (f2 a) 100)
;-> 730.251

(time (f1 b) 100)
;-> 1977.548
(time (f2 b) 100)
;-> 767.725

(time (f1 c) 100)
;-> 1948.062
(time (f2 c) 100)
;-> 729.342

In questo problema è molto più efficiente utilizzare l'algoritmo ad-hoc al posto delle primitive di newLISP (caso poco frequente).


--------------
Treni e binari
--------------

Dati gli orari di arrivo e partenza di tutti i treni che raggiungono una stazione ferroviaria, è trovare il numero minimo di binari necessari in modo che nessun treno rimanga in attesa.
Gli orari di arrivo e partenza dei treni sono contenuti in due liste, "arrivi" e "partenze".

Esempio:
Treno 1: arrivo=9:05 - partenza= 9:15
Treno 2: arrivo=9:40 - partenza= 12:05
Treno 3: arrivo=9:55 - partenza= 11:20
Treno 4: arrivo=11:10 - partenza= 11:25
Treno 5: arrivo=15:10 - partenza= 18:30
Treno 6: arrivo=18:10 - partenza= 20:20

lista arrivi = (9:05 9:40 9:55 11:00 15:10 18:10)
lista partenze = (9:15 12:05 11:20 11:30 18:30 20:20)

In questo caso occorrono 3 binari perchè ci sono tre treni tra le 11:10 e le 11:25.

Per risolvere il problema trasformiamo ogni orario di partenza e arrivo in un numero (in questo modo i valori rimangono ordinati):

 9:00 --> 900
 12:30 --> 1230
 ...

Adesso creiamo una lista unica ordinata con tutti gli orari di arrivo e di partenza:

; lista degli arrivi
(setq arr '(905 940 955 1110 1510 1830))
; lista delle partenze
(setq par '(915 1205 1120 1125 1830 2020))
; lista degli arrivi con il codice "A"
(setq arr-t (map (fn(x) (list x "A")) arr))
;->  ((905 "A") (940 "A") (955 "A") (1110 "A") (1510 "A") (1830 "A"))
; lista delle partenze con il codice "P"
(setq par-t (map (fn(x) (list x "P")) par))
;-> ((915 "P") (1205 "P") (1120 "P") (1125 "P") (1830 "P") (2020 "P"))
; lista ordinata con tutti gli orari
(setq all (sort (append arr-t par-t)))
;-> ((905 "A") (915 "P") (940 "A") (955 "A") (1110 "A") (1120 "P")
;->  (1125 "P") (1205 "P") (1510 "A") (1830 "A") (1830 "P") (2020 "P"))

Il prossimo passo è quello di attraversare la lista e contare i binari necessari per ogni arrivo o partenza nel modo seguente:
- se il codice vale "A", allora aumentiamo il numero dei binari necessari correnti
- se il codice vale "P", allora diminuiamo il numero dei binari necessari correnti
Il numero di binari necessari è pari al valore massimo del numero dei binari necessari correnti

; numero necessario di binari
(setq binari 0)
; numero necessario corrente di binari
(setq curr 0)
(dolist (el all)
  (cond ((= (el 1) "A") (++ curr))
        ((= (el 1) "P") (-- curr))
  )
  ; aggiorna il numero necessario di binari
  (setq binari (max binari curr))
  ; stampa la situazione corrente della stazione
  (println (el 0) { } (el 1) { } curr)
)
;-> 905 A 1
;-> 915 P 0
;-> 940 A 1
;-> 955 A 2
;-> 1110 A 3
;-> 1120 P 2
;-> 1125 P 1
;-> 1205 P 0
;-> 1510 A 1
;-> 1830 A 2
;-> 1830 P 1
;-> 2020 P 0

Vediamo il valore dei binari necessari:

binari
;-> 3

Scriviamo la funzione finale:

(define (station arr par)
  (local (arr-t par-t all curr binari)
    ; lista degli arrivi con il codice "A"
    (setq arr-t (map (fn(x) (list x "A")) arr))
    ; lista delle partenze con il codice "P"
    (setq par-t (map (fn(x) (list x "P")) par))
    ; lista ordinata con tutti gli orari
    (setq all (sort (append arr-t par-t)))
    ; numero necessario di binari
    (setq binari 0)
    ; numero necessario corrente di binari
    (setq curr 0)
    (dolist (el all)
      (cond ((= (el 1) "A") (++ curr))
            ((= (el 1) "P") (-- curr))
      )
      ; aggiorna il numero necessario di binari
      (setq binari (max binari curr))
      ; stampa la situazione corrente della stazione
      (println (el 0) { } (el 1) { } curr)
    )
    binari))

(station arr par)
;-> 905 A 1
;-> 915 P 0
;-> 940 A 1
;-> 955 A 2
;-> 1110 A 3
;-> 1120 P 2
;-> 1125 P 1
;-> 1205 P 0
;-> 1510 A 1
;-> 1830 A 2
;-> 1830 P 1
;-> 2020 P 0
;-> 3

Nota: questo algoritmo presuppone che i treni arrivino e partano nello stesso giorno.


----------------------
Mastermind (by Norman)
----------------------
All'indirizzo web http://newlisp.digidep.net/ troviamo la "Norman's Collection", una varietà di piccole utilità estremamente utili e creative scritte dall'utente Norman. Non tutte le utilità sono aggiornate a newLISP 10.7.5, ma sono molto interessanti per vedere lo stile di programmazione di un esperto.
Di seguito riportiamo il programma "mastermind" aggiornato (con piccole modifiche) alla versione 10.7.5.

#!/usr/bin/newlisp
;; ---------------------------------------------------------------------
;;
;; An ANSI based MASTERMIND v0.7
;;
;; Colors can occur more than once (more fun).
;; You have 10 guesses to finish in.
;;
;;
;; Enjoy, Norman 2006
;; uptated to newLISP 10.7.5 by cameyo, 25-Sep-2021
;; ---------------------------------------------------------------------
;; defines
;; ---------------------------------------------------------------------
(define r "\027[0;31m")
(define g "\027[0;32m")
(define b "\027[0;34m")
(define y "\027[0;33m")
(define m "\027[0;35m")
(define c "\027[0;36m")
(define w "\027[0;37m")
(define d "\027[0;0m" )
;------------------
(define (cls) (println "\027[H\027[2J"))
(define (line) (println "\t\t" (dup "-" 32)))
;------------------
(setq colors '(r g b y m c w))
(setq title (explode "MASTERMIND"))
;; ---------------------------------------------------------------------
;; header
;; ---------------------------------------------------------------------
(define (header)
  (cls)
  (seed (nth 6 (now)) )
  (setq solution (0 4 (randomize (flat (dup (randomize colors) 4)))))
  ;(println "\t\t Solution: " solution)
  (line)
  (dotimes (l 3) (print "\t\t ") (dotimes (l 3) (dolist (l title) (print (eval (nth 0 (randomize colors))) l ))) (println d))
  (line)
  (println "\t\t " w "Type the keys: " r "R" g "G" b "B" y "Y" m "M" c "C" w "W" d " to play")
  (println "\t\t     " w {Press "\" to quit})
  (println "\t\t " c "!" d " - correct color and place")
  (println "\t\t " r "?" d " - correct color wrong place")
  (line)
  (println "\t\t [" g (dup "  #" 4) d "  ]")
  (line))
;; ---------------------------------------------------------------------
;; print colors
;; ---------------------------------------------------------------------
(define (output)
  (print "\t\t [ " )
  (dolist (p solution) (print (eval p) " @ " )) (println d " ] "))
;; ---------------------------------------------------------------------
;; handle input
;; ---------------------------------------------------------------------
(define (input)
  (setq pushed 0)
  (setq current '())
  (print "\t\t [ " )
  (while (!= pushed 4)
    (setq h (sym (char (read-key))))
       ; check quit game char
       (if (= h '\) (exit))
       (if (find h colors)
        (begin
          (print (eval h) " @ " d)
          (push h current -1)
          (++ pushed) )))
  (print " ]")
  (check))
;; ---------------------------------------------------------------------
;; check & print colors and positions
;; ---------------------------------------------------------------------
(define (check)
  (setq work solution)
  (print "\t[")
  '(for (x 0 3) (if (= (nth x current) (nth x work)) (begin (set-nth x current 'nil) (set-nth x work 'nil) (print c "!" d))))
  (for (x 0 3) (if (= (nth x current) (nth x work)) (begin (setf (current x) 'nil) (setf (work x) 'nil) (print c "!" d))))
  (setq current (clean nil? current))
  (if (empty? current) (begin (println "]") (line) (println "\t\t " g "Well Done!" d) (restart)))
  (setq work (clean nil? work))
  (dolist (x current) (if (setq i (find x work)) (begin (setf (work i) 'nil) (print r "?" d))))
  (println "]")
  (line))
;; ---------------------------------------------------------------------
;; restart
;; ---------------------------------------------------------------------
(define (restart)
  (line)
  (print "\t\t " w "Play Again? (" g "y" w "/" r "n" c"): " d)
  (if (= (lower-case (char (read-key))) "y") (game) (begin (println "\n\n") (exit))))
;; ---------------------------------------------------------------------
;; GAME
;; ---------------------------------------------------------------------
(define (game)
  (header)
  (setq counter 0)
  (while (!= counter 10) (input) (++ counter))
  (output)
  (restart))
;(exit)

Proviamo a fare una partita:

(game)
;-> --------------------------------
;->  MASTERMINDMASTERMINDMASTERMIND
;->  MASTERMINDMASTERMINDMASTERMIND
;->  MASTERMINDMASTERMINDMASTERMIND
;-> --------------------------------
;->  Type the keys: RGBYMCW to play
;->      Press \ to quit
;->  ! - correct color and place
;->  ? - correct color wrong place
;-> --------------------------------
;->  [  #  #  #  #  ]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!]
;-> --------------------------------
;->  [  @  @  @  @  ]       []
;-> --------------------------------
;->  [  @  @  @  @  ]       [??]
;-> --------------------------------
;->  [  @  @  @  @  ]       [??]
;-> --------------------------------
;->  [  @  @  @  @  ]       [??]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!?]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!!]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!!!]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!!!]
;-> --------------------------------
;->  [  @  @  @  @  ]       [!!!!]
;-> --------------------------------
;->  Well Done!
;-> --------------------------------
;->  Play Again? (y/n):

Nota: vedi l'immagine "mastermind.png" nella cartella "data" per vedere l'output precedente a colori.


--------------
newLISP banner
--------------

(define (banner1)
  (println "███    ██ ███████ ██     ██ ██      ██ ███████ ██████ ")
  (println "████   ██ ██      ██     ██ ██      ██ ██      ██   ██")
  (println "██ ██  ██ █████   ██  █  ██ ██      ██ ███████ ██████ ")
  (println "██  ██ ██ ██      ██ ███ ██ ██      ██      ██ ██     ")
  (println "██   ████ ███████  ███ ███  ███████ ██ ███████ ██     ")
  (print))
(banner1)

(define (banner2)
  (println "                                        _|        _|_|_|    _|_|_|  _|_|_|  ")
  (println "_|_|_|      _|_|    _|      _|      _|  _|          _|    _|        _|    _|")
  (println "_|    _|  _|_|_|_|  _|      _|      _|  _|          _|      _|_|    _|_|_|  ")
  (println "_|    _|  _|          _|  _|  _|  _|    _|          _|          _|  _|      ")
  (println "_|    _|    _|_|_|      _|      _|      _|_|_|_|  _|_|_|  _|_|_|    _|      ")
  (print))
(banner2)

(define (banner3)
  (println "                                                                           LLLLLLLLLLL             IIIIIIIIII   SSSSSSSSSSSSSSS PPPPPPPPPPPPPPPPP   ")
  (println "                                                                           L:::::::::L             I::::::::I SS:::::::::::::::SP::::::::::::::::P  ")
  (println "                                                                           L:::::::::L             I::::::::IS:::::SSSSSS::::::SP::::::PPPPPP:::::P ")
  (println "                                                                           LL:::::::LL             II::::::IIS:::::S     SSSSSSSPP:::::P     P:::::P")
  (println "nnnn  nnnnnnnn        eeeeeeeeeeee  wwwwwww           wwwww           wwwwwwwL:::::L                 I::::I  S:::::S              P::::P     P:::::P")
  (println "n:::nn::::::::nn    ee::::::::::::ee w:::::w         w:::::w         w:::::w L:::::L                 I::::I  S:::::S              P::::P     P:::::P")
  (println "n::::::::::::::nn  e::::::eeeee:::::eew:::::w       w:::::::w       w:::::w  L:::::L                 I::::I   S::::SSSS           P::::PPPPPP:::::P ")
  (println "nn:::::::::::::::ne::::::e     e:::::e w:::::w     w:::::::::w     w:::::w   L:::::L                 I::::I    SS::::::SSSSS      P:::::::::::::PP  ")
  (println "  n:::::nnnn:::::ne:::::::eeeee::::::e  w:::::w   w:::::w:::::w   w:::::w    L:::::L                 I::::I      SSS::::::::SS    P::::PPPPPPPPP    ")
  (println "  n::::n    n::::ne:::::::::::::::::e    w:::::w w:::::w w:::::w w:::::w     L:::::L                 I::::I         SSSSSS::::S   P::::P            ")
  (println "  n::::n    n::::ne::::::eeeeeeeeeee      w:::::w:::::w   w:::::w:::::w      L:::::L                 I::::I              S:::::S  P::::P            ")
  (println "  n::::n    n::::ne:::::::e                w:::::::::w     w:::::::::w       L:::::L         LLLLLL  I::::I              S:::::S  P::::P            ")
  (println "  n::::n    n::::ne::::::::e                w:::::::w       w:::::::w      LL:::::::LLLLLLLLL:::::LII::::::IISSSSSSS     S:::::SPP::::::PP          ")
  (println "  n::::n    n::::n e::::::::eeeeeeee         w:::::w         w:::::w       L::::::::::::::::::::::LI::::::::IS::::::SSSSSS:::::SP::::::::P          ")
  (println "  n::::n    n::::n  ee:::::::::::::e          w:::w           w:::w        L::::::::::::::::::::::LI::::::::IS:::::::::::::::SS P::::::::P          ")
  (println "  nnnnnn    nnnnnn    eeeeeeeeeeeeee           www             www         LLLLLLLLLLLLLLLLLLLLLLLLIIIIIIIIII SSSSSSSSSSSSSSS   PPPPPPPPPP          ")
  (print))
(banner3)

(define (banner4)
(println "                       __    _________ ____ ")
(println "   ____  ___ _      __/ /   /  _/ ___// __ \\")
(println "  / __ \\/ _ \\ | /| / / /    / / \\__ \\/ /_/ /")
(println " / / / /  __/ |/ |/ / /____/ / ___/ / ____/ ")
(println "/_/ /_/\\___/|__/|__/_____/___//____/_/      ")
(print))
(banner4)

(define (banner5)
(println "                     _     ___ ____  ____  ")
(println " _ __   _____      _| |   |_ _/ ___||  _ \\ ")
(println "| '_ \\ / _ \\ \\ /\\ / / |    | |\\___ \\| |_) |")
(println "| | | |  __/\\ V  V /| |___ | | ___) |  __/ ")
(println "|_| |_|\\___| \\_/\\_/ |_____|___|____/|_|    ")
(print))
(banner5)

(define (banner6)
  (println "                     #       ###  #####  ###### ")
  (println "#    # ###### #    # #        #  #     # #     #")
  (println "##   # #      #    # #        #  #       #     #")
  (println "# #  # #####  #    # #        #   #####  ###### ")
  (println "#  # # #      # ## # #        #        # #      ")
  (println "#   ## #      ##  ## #        #  #     # #      ")
  (println "#    # ###### #    # ####### ###  #####  #      ")
  (print))
(banner6)

(define (banner7)
  (println "##    ## ######## ##      ## ##       ####  ######  ######## ")
  (println "###   ## ##       ##  ##  ## ##        ##  ##    ## ##     ##")
  (println "####  ## ##       ##  ##  ## ##        ##  ##       ##     ##")
  (println "## ## ## ######   ##  ##  ## ##        ##   ######  ######## ")
  (println "##  #### ##       ##  ##  ## ##        ##        ## ##       ")
  (println "##   ### ##       ##  ##  ## ##        ##  ##    ## ##       ")
  (println "##    ## ########  ###  ###  ######## ####  ######  ##       ")
  (print))
(banner7)

(define (banner8)
  (println "                                                  _               _  _  _     _  _  _  _     _  _  _  _   ")
  (println "                                                 (_)             (_)(_)(_)  _(_)(_)(_)(_)_  (_)(_)(_)(_)_ ")
  (println " _  _  _  _      _  _  _  _     _             _  (_)                (_)    (_)          (_) (_)        (_)")
  (println "(_)(_)(_)(_)_   (_)(_)(_)(_)_  (_)           (_) (_)                (_)    (_)_  _  _  _    (_) _  _  _(_)")
  (println "(_)        (_) (_) _  _  _ (_) (_)     _     (_) (_)                (_)      (_)(_)(_)(_)_  (_)(_)(_)(_)  ")
  (println "(_)        (_) (_)(_)(_)(_)(_) (_)_  _(_)_  _(_) (_)                (_)     _           (_) (_)           ")
  (println "(_)        (_) (_)_  _  _  _     (_)(_) (_)(_)   (_) _  _  _  _   _ (_) _  (_)_  _  _  _(_) (_)           ")
  (println "(_)        (_)   (_)(_)(_)(_)      (_)   (_)     (_)(_)(_)(_)(_) (_)(_)(_)   (_)(_)(_)(_)   (_)           ")
  (print)   )
(banner8)

(define (banner9)
  (println "                          LL      IIIII  SSSSS  PPPPPP ")
  (println "nn nnn    eee  ww      ww LL       III  SS      PP   PP")
  (println "nnn  nn ee   e ww      ww LL       III   SSSSS  PPPPPP ")
  (println "nn   nn eeeee   ww ww ww  LL       III       SS PP     ")
  (println "nn   nn  eeeee   ww  ww   LLLLLLL IIIII  SSSSS  PP     ")
  (print))
(banner9)

(define (banner str)
  (let (line (dup "+-" (length str)))
    (println line "+")
    (map (fn(x) (print "|" x)) (explode str))
    (println "|")
    (println line "+")
    (print)))
(banner "newLISP")
;-> +-+-+-+-+-+-+-+
;-> |n|e|w|L|I|S|P|
;-> +-+-+-+-+-+-+-+


--------------------
Puzzle di Gordon Lee
--------------------

Data una matrice NxN con numeri composti con una sola cifra (0..9) anche ripetuti, contare i distinti numeri primi incorporati nella matrice. I numeri si possono leggere con orientamento verticale, orizzontale o diagonale, in entrambe le direzioni.
Ad esempio nella matrice:

  1 2 3
  4 5 6
  7 8 9

Sono inglobati i seguenti 65 numeri:

(1 2 3 4 5 6 7 8 9 12 14 15 21 23 24 25 26 32 35 36 41 42 45 47 48 51 52 53 54 56
 57 58 59 62 63 65 68 69 74 75 78 84 85 86 87 89 95 96 98 123 147 159 258 321 357
 369 456 654 741 753 789 852 951 963 987)

Questo puzzle è stato proposto per la prima volta nel 1989 da Gordon Lee per una matrice 6x6.

La matrice 6x6 con il maggior numero di primi è stata trovata da Stephen Root:

  3 1 7 3 3 3
  9 9 5 6 3 9
  1 1 8 1 4 2
  1 3 6 3 7 3
  3 4 9 1 9 9
  3 7 9 3 7 9

Questa matrice contiene all'interno 187 numeri primi.

Nota: i numeri contenuti nella matrice non sono necessariamente tutti differenti.

Quello che ci serve è una funzione che, data una matrice, sia in grado di generare tutti i numeri inglobati.

(define (numatrix mtx)
  (local (sol val num cur-row cur-col max-row max-col)
    (setq sol '())
    (setq max-row (length mtx))
    (setq max-col (length (mtx 0)))
    ; ricerca dei numeri inglobati
    ; per ogni elemento della matrice...
    (for (r 0 (- max-row 1))
      (for (c 0 (- max-col 1))
        (setq num (mtx r c))
        ; inseriamo il numero corrente nella soluzione
        (push num sol -1)
        ; numeri per colonna in avanti
        (setq val num)
        (setq cur-row (+ r 1))
        (while (< cur-row max-row)
          (setq val (+ (* val 10) (mtx cur-row c)))
          (push val sol -1)
          (++ cur-row)
        )
        ; numeri per colonna all'indietro
        (setq val num)
        (setq cur-row (- r 1))
        (while (>= cur-row 0)
          (setq val (+ (* val 10) (mtx cur-row c)))
          (push val sol -1)
          (-- cur-row)
        )
        ; numeri per riga in avanti
        (setq val num)
        (setq cur-col (+ c 1))
        (while (< cur-col max-col)
          (setq val (+ (* val 10) (mtx r cur-col)))
          (push val sol -1)
          (++ cur-col)
        )
        ; numeri per riga all'indietro
        (setq val num)
        (setq cur-col (- c 1))
        (while (>= cur-col 0)
          (setq val (+ (* val 10) (mtx r cur-col)))
          (push val sol -1)
          (-- cur-col)
        )
        ; numeri in diagonale basso-sx
        (setq val num)
        (setq cur-col (- c 1))
        (setq cur-row (+ r 1))
        (while (and (>= cur-col 0) (< cur-row max-row))
          (setq val (+ (* val 10) (mtx cur-row cur-col)))
          (push val sol -1)
          (-- cur-col)
          (++ cur-row)
        )
        ; numeri in diagonale basso-dx
        (setq val num)
        (setq cur-col (+ c 1))
        (setq cur-row (+ r 1))
        (while (and (< cur-col max-col) (< cur-row max-row))
          (setq val (+ (* val 10) (mtx cur-row cur-col)))
          (push val sol -1)
          (++ cur-col)
          (++ cur-row)
        )
        ; numeri in diagonale alto-sx
        (setq val num)
        (setq cur-col (- c 1))
        (setq cur-row (- r 1))
        (while (and (>= cur-col 0) (>= cur-row 0))
          (setq val (+ (* val 10) (mtx cur-row cur-col)))
          (push val sol -1)
          (-- cur-col)
          (-- cur-row)
        )
        ; numeri in diagonale alto-dx
        (setq val num)
        (setq cur-col (+ c 1))
        (setq cur-row (- r 1))
        (while (and (< cur-col max-col) (>= cur-row 0))
          (setq val (+ (* val 10) (mtx cur-row cur-col)))
          (push val sol -1)
          (++ cur-col)
          (-- cur-row)
        )
      )
    )
    (sort sol)))

Facciamo alcune prove:

(setq m2 '((1 2) (3 4)))
(setq n2 (numatrix m2))
;-> (1 2 3 4 12 13 14 21 23 24 31 32 34 41 42 43)
(length n2)
;-> 16

(setq m3 '((1 2 3) (4 5 6) (7 8 9)))
(setq n3 (numatrix m3))
;-> (1 2 3 4 5 6 7 8 9 12 14 15 21 23 24 25 26 32 35 36 41 42 45 47 48 51
;->  52 53 54 56 57 58 59 62 63 65 68 69 74 75 78 84 85 86 87 89 95 96 98
;->  123 147 159 258 321 357 369 456 654 741 753 789 852 951 963 987)
(length n3)
;-> 65

(setq m4 '((1 2 3 4) (4 5 6 7) (7 8 9 1) (3 7 9 0)))
(setq n4 (numatrix m4))
;-> (0 1 1 1 2 3 3 4 4 5 6 7 7 7 8 9 9 9 9 10 12 14 15 16 17 17 19 19 21 23 24
;->  25 26 32 34 35 36 37 37 37 38 41 42 43 45 46 47 47 48 51 52 53 54 56 57 58
;->  59 61 62 63 64 65 67 68 69 71 73 73 73 74 74 75 76 77 77 78 78 79 79 79 83
;->  84 85 86 87 87 89 89 90 90 91 91 95 95 96 97 97 97 97 98 98 99 99 123 147
;->  159 162 174 174 198 234 258 261 321 357 369 374 379 386 432 456 468 471
;->  473 489 567 587 590 654 683 699 710 741 753 765 785 789 790 797 797 852
;->  864 891 951 951 963 973 973 984 987 996 1234 1473 1590 1987 2587 3699
;->  3741 3790 3864 4321 4567 4683 4710 7654 7852 7891 9963)
(length n4)
;-> 168

(setq m5 '((1 2 3 4 5) (1 2 3 4 5) (1 2 3 4 5) (1 2 3 4 5) (1 2 3 4 5)))
(length (setq n5 (numatrix m5)))
;-> 345

(setq m6 '((1 2 3 4 5 6) (1 2 3 4 5 6) (1 2 3 4 5 6) (1 2 3 4 5 6) (1 2 3 4 5 6) (1 2 3 4 5 6)))
(length (setq n6 (numatrix m6)))
;-> 616

Quindi abbiamo la seguente tabella:

  Ordine    Numero elementi
  ------    ---------------
  1x1         1 numero
  2x2        16 numeri
  3x3        65 numeri
  4x4       168 numeri
  5x5       345 numeri
  6x6       616 numeri

Adesso abbiamo bisogno di una funzione per verificare/calcolare i numeri primi:

Funzione che genera tutti i numeri primi minori o uguali a un dato numero:

(define (primes-to num)
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
                (when (not (arr x))
                  (push x lst -1)
                  (for (y (* x x) num (* 2 x) (> y num))
                      (setf (arr y) true)))) lst))))

Funzione che verifica se un dato numero è primo:

(define (prime? num)
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Possiamo usare due metodi per calcolare i numeri primi della matrice:

1) identificare se ogni numero della matrice è primo
(filter prime? numeri)

2) precalcolare i numeri primi fino a 10^(N+1) (dove N è l'ordine della matrice)
(intersect primi numeri)

Per esempio:

(setq mx3 '((1 2 3) (4 5 6) (7 8 9)))
(setq numeri (unique (sort (numatrix mx3))))
;-> (1 2 3 4 5 6 7 8 9 12 14 15 21 23 24 25 26 32 35 36 41 42 45 47 48 51 52
;->  53 54 56 57 58 59 62 63 65 68 69 74 75 78 84 85 86 87 89 95 96 98 123
;->  147 159 258 321 357 369 456 654 741 753 789 852 951 963 987)
(filter prime? numeri)
;-> (2 3 5 7 23 41 47 53 59 89)
(setq primi (primes-to 1e3))
(intersect numeri primi)
;-> (2 3 5 7 23 41 47 53 59 89)

Verifichiamo la matrice record 6x6 vista sopra:

(setq x6
 '((3 1 7 3 3 3)
  (9 9 5 6 3 9)
  (1 1 8 1 4 2)
  (1 3 6 3 7 3)
  (3 4 9 1 9 9)
  (3 7 9 3 7 9)))
(setq numeri (unique (sort (numatrix x6))))
(setq sol (filter prime? numeri))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
;->  113 131 139 149 151 163 173 179 181 191 193 197 199 233 239 241 271 293
;->  311 313 317 331 337 347 349 373 379 389 397 431 433 439 461 467 479 491
;->  563 599 613 617 619 631 643 659 683 719 733 739 743 797 811 839 857 863
;->  911 919 937 941 971 983 991 1153 1181 1193 1619 1733 1811 1913 2399
;->  2719  3119 3163 3191 3347 3371 3461 3467 3491 3511 3613 3631 3637 3659
;->  3793  3863  3911 3923 3931 4397 4919 5179 5639 5869 6131 6133 6373 6599
;->  6833 6857 7151 7333 7433 7643 7937 8699 9161 9199 9239 9349 9439 9739
;->  9743 9839 13163 17333 24181 31193 31643 33119 33479 33713 33863 34613
;->  34919 36131 36373 36599 36833 37363 39113 39239 39839 46133 49199 58699
;->  73973 75869 79349 79379 91943 92399 93893 94397 96857 97151 97397 99563
;->  136373 241811 313163 317333 333713 346133 349199 361313 373631 391133
;->  758699 936599 991943 993893 996857)
(length sol)
;-> 187

Verifichiamo altri record dal sito:

https://www.primepuzzles.net/puzzles/puzz_001.htm

Matrice 3x3 con 30 numeri primi:
(setq x3
       '((1 1 3)
         (7 5 4)
         (9 3 7)))
(setq numeri (unique (sort (numatrix x3))))
(setq sol (filter prime? numeri))
;-> (3 5 7 11 13 17 31 37 41 43 47 53 59 71 73 79 97 113 157 179 311 347
;->  359 457 739 743 751 937 953 971)
(length sol)
;-> 30

Matrice 4x4 con 63 numeri primi:
(setq x4
       '((1 1 3 9)
         (6 4 5 1)
         (7 3 9 7)
         (3 9 2 9)))
(setq numeri (unique (sort (numatrix x4))))
(setq sol (filter prime? numeri))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 97 113
;->  139 149 157 167 179 199 293 311 347 359 397 439 499 673 719 739 743
;->  751 761 929 937 941 953 971 991 1439 1499 2953 3359 3761 3929 6451
;->  7937 9293 9311 9341 9533 9719 9941)
(length sol)
;-> 63

Matrice 5x5 con 116 numeri primi:
(setq x5
       '((1 1 9 3 3)
         (9 9 5 6 3)
         (8 9 4 1 7)
         (3 3 7 3 1)
         (3 2 9 3 9)))
(setq numeri (unique (sort (numatrix x5))))
(setq sol (filter prime? numeri))
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97
;->  137 149 151 163 173 193 199 239 271 293 317 331 337 349 359 373 379 389
;->  433 439 463 479 491 547 563 593 599 613 643 659 719 733 739 769 839 911
;->  937 941 953 967 983 991 997 1151 1193 1373 1511 1733 1933 1993 2399 2713
;->  2939 3163 3371 3373 3389 3391 3463 3491 3593 3613 3643 3659 3719 3733
;->  3911 3923 5479 6133 6599 7459 8941 9173 9349 9439 9547 9833 9973 11933
;->  32939 33911 36433 36599 89417 91733 93491 93923 95479 97459 99563)
(length sol)
;-> 116

Matrice 7x7 con 281 numeri primi:
(setq x7
       '((9 3 3 7 3 1 3)
         (3 3 3 3 2 9 9)
         (4 9 8 7 7 9 6)
         (9 1 9 5 1 6 7)
         (1 1 2 4 3 7 7)
         (9 3 9 7 4 9 9)
         (9 9 9 1 7 3 3)))
(setq numeri (unique (sort (numatrix x7))))
(length (numatrix x7))
(setq sol (filter prime? numeri))
(length sol)
;-> 281

Otteniamo la seguente tabella:

  Ordine    Numero elementi    Numeri primi
  ------    ---------------    ------------
  1x1          1 numero          1
  2x2         16 numeri          ? (11)
  3x3         65 numeri         30
  4x4        168 numeri         63
  5x5        345 numeri        116
  6x6        616 numeri        187
  7x7       1001 numeri        281

Manca il numero di primi per la matrice 2x2. In questo caso possiamo trovare la soluzione esaustivamente considerando tutte le matrici che si possono generare con i numeri da 0 a 9 e calcolando il relativo numero di primi.

Funzione che genera tutte le permutazioni di k elementi con ripetizione da un elenco di elementi:

(define (perm-rep k lst)
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Funzione che calcola la matrice con il più grande numero di primi:

(define (find-x2)
  (local (m numeri sol max-val out)
    (setq max-val 0)
    (setq all (perm-rep 4 '(0 1 2 3 4 5 6 7 8 9)))
    (dolist (el all)
      (setq m (list (select el 0 1) (select el 2 3)))
      (setq numeri (unique (sort (numatrix m))))
      (setq sol (filter prime? numeri))
      (if (> (length sol) max-val)
        (begin
        (setq m-sol m)
        (setq max-val (length sol))
        (setq out sol)
        )
      )
    )
    (println m-sol { } max-val { } out)))

Proviamo a trovare la matrice 2x2 con il maggior numero di primi:

(find-x2)
;-> ((7 4) (3 1)) 11 (3 7 13 17 31 37 41 43 47 71 73)


-------------
Orologio ANSI
-------------

;;
;; Newlisp clocking
;;
;; linux version or dos-box with ansi support or windows console 20H1.
;; enjoy...norman.
;;
(set 'digits '(
(" ### " "  #  " "#####" "#####" "#   #" "#####" "#    " "#####" "#####" " ### " "     ")
("#   #" " ##  " "    #" "    #" "#   #" "#    " "#    " "    #" "#   #" "#   #" "  #  ")
("#   #" "  #  " "#####" " ### " "#####" "#####" "#####" "   ##" "#####" " ####" "     ")
("#   #" "  #  " "#    " "    #" "    #" "    #" "#   #" "   # " "#   #" "   # " "  #  ")
(" ### " "  #  " "#####" "#####" "    #" "#####" "#####" "   # " "#####" "  #  " "     ")))
(while true
 ;; clear screen (ANSI sequence)
 (println "\027[H\027[2J\027[0;32m")
 ;; define time without ":" get from apply date
 (set 'ticks (replace ":" (slice (date (apply date-value (now))) 11 8) ""))
 ;; write 5 rows of 6 digits and 2 seperators
 (dotimes (x 5)
   (dotimes (y 6)
  (print " " (nth (integer (nth 0 (nth y ticks))) (nth x digits)))
  (if (or (= y 1) (= y 3)) (print (nth 10 (nth x digits)))))
  (println))
(sleep 1000)
)


---------------
Indici ordinali
---------------

Le seguenti funzioni permettono di indicizzare i primi dieci elementi di una lista (o stringa o vettore):

(define (second  x) (unless (>= 1 (length x)) (nth 1 x) 'nil))
(define (third   x) (unless (>= 2 (length x)) (nth 2 x) 'nil))
(define (fourth  x) (unless (>= 3 (length x)) (nth 3 x) 'nil))
(define (fifth   x) (unless (>= 4 (length x)) (nth 4 x) 'nil))
(define (sixth   x) (unless (>= 5 (length x)) (nth 5 x) 'nil))
(define (seventh x) (unless (>= 6 (length x)) (nth 6 x) 'nil))
(define (eigth   x) (unless (>= 7 (length x)) (nth 7 x) 'nil))
(define (ninth   x) (unless (>= 8 (length x)) (nth 8 x) 'nil))
(define (tenth   x) (unless (>= 9 (length x)) (nth 9 x) 'nil))


-----------------------
Generazione di password
-----------------------

(define (pwd1)
  ; simple pwd gen 8 chars
  ; [a-n p-z A-N P-Z 1-9]
  (seed (time-of-day))
  (println (join (map char (0 8 (randomize (flat (map (fn(x) (sequence (x 0) (x 1))) '( (50 57) (65 78) (80 90) (97 110) (112 122) )))))))))

(pwd1)
;-> ixHsMClA
(pwd1)
;-> GQ7Crwet

(define (pwd2)
  ; simple pwd gen 16 chars 4x4
  ; one time password
  ; [a-n p-z A-N P-Z 1-9]
  (seed (time-of-day))
  (println (join (explode (join (map char (0 16 (randomize (flat (map (fn(x) (sequence (x 0) (x 1))) '( (50 57) (65 78) (80 90) (97 110) (112 122) ))))))) 4)" ")))

(pwd2)
;-> BvmF Kf4w WArj ULRH
(pwd2)
;-> SnZJ 29VP DyQq sTcM

(define (pwd3)
  ; simple pwd gen 10 chars
  ; [!-/ :-@ [-` {-~ a-n p-z A-N P-Z 1-9]
  (seed (time-of-day))
  (println (join (map char (0 10 (randomize (flat (map (fn(x) (sequence (x 0) (x 1))) '( (33 47) (50 78) (80 110) (112 126) )))))))))

(pwd3)
;-> X_u|=\,C#9
;-> NjA3Hk'[9Y


-------------------------------
Verifica accessibilità siti web
-------------------------------

La seguente funzione controlla se un sito web è online (connesso) | offline (disconnesso):

(define (online? www)
 (if (setq checkup (net-connect www 80))
  (begin (net-close checkup ) "Online") "Offline"))

(online? "youtube.com")
;-> "Online"

(setq urls '(
  "newlisp.org"
  "pazzzo.org"
  "www.gnu.org"
  "google.com"))

(dolist (url urls) (println (online? url) " : " url))
;-> Online  : newlisp.org
;-> Offline : pazzzo.org
;-> Online  : www.gnu.org
;-> Online  : google.com


------------------------
Miglior punto d'incontro
------------------------

Un gruppo di due o più persone vuole incontrarsi e ridurre al minimo la distanza totale del viaggio. Viene data una griglia 2D di
valori 0 o 1, dove 1 indica la posizione di qualcuno nel gruppo. La distanza è calcolata utilizzando il metodo Manhattan:

  Distanza di Manhattan (p1, p2) = |p2.x - p1.x| + |p2.y - p1.y|.

Ad esempio, date tre persone che si trovano a (0,0), (0,4) e (2,2):

  1 - 0 - X - 0 - 1
  |   |   |   |   |
  0 - 0 - 0 - 0 - 0
  |   |   |   |   |
  0 - 0 - 1 - 0 - 0

Funzione che calcola la distanza Manhattan (4 direzioni - torre) di due punti P1=(x1 y1) e P2=(x2 y2):

(define (manhattan x1 y1 x2 y2)
  (+ (abs (- x1 x2)) (abs (- y1 y2))))

Soluzione brute-force:

(define (meet grid girl)
  (local (cols rows num-rows num-cols dmin dist)
    (setq num-rows (length grid))
    (setq num-cols (length (grid 0)))
    (setq rows '())
    (setq cols '())
    (setq pos '(0 0))
    (setq dmin 999999999)
    ; per ogni cella della griglia...
    (for (r 0 (- num-rows 1))
      (for (c 0 (- num-cols 1))
        (setq dist 0)
        ; calcola il valore minimo
        ; della somma delle distanze
        ; di tutte le persone
        (dolist (m girl)
          (setq dist (+ dist (manhattan (m 0) (m 1) r c)))
        )
        (println dist { } (grid r c))
        ; aggiorna il valore minimo e la posizione migliore
        (if (< dist dmin)
            (setq dmin dist pos (list r c))
        )
      )
    )
    (list pos dmin)))

(setq grid '((1 0 0 0 1) (0 0 0 0 0) (0 0 1 0 0)))
(setq girl '((0 0) (0 4) (2 2)))

(meet grid girl)
;-> ((0 2) 6)

Se vogliamo trovare solo la distanza minima, allora il problema consiste nel trovare il valore mediano sull'asse x e sull'asse y.

(define (meeting lst girl)
  (local (cols rows num-rows num-cols somma)
    (setq num-rows (length lst))
    (setq num-cols (length (lst 0)))
    (setq rows '())
    (setq cols '())
    (for (r 0 (- num-rows 1))
      (for (c 0 (- num-cols 1))
        (if (= 1 (lst r c))
            (begin
            (push c cols -1)
            (push r rows -1))
        )
      )
    )
    (setq rows (map first girl))
    (setq cols (map last girl))
    (setq somma 0)
    (setq r-mid (/ (length rows) 2))
    (dolist (el rows)
      (setq somma (+ somma (abs (- el (rows r-mid)))))
    )
    (setq c-mid (/ (length cols) 2))
    (sort cols)
    (dolist (el cols)
      (setq somma (+ somma (abs (- el (cols c-mid)))))
    )
    somma))

(meeting grid girl)
;-> 6

Vediamo altri esempi:

  1 - 0 - 0 - 0 - 1 - 0 - 1
  |   |   |   |   |   |   |
  0 - 0 - 0 - 0 - 0 - 1 - 1
  |   |   |   |   |   |   |
  0 - 0 - 1 - 0 - 0 - 0 - 1
  |   |   |   |   |   |   |
  1 - 0 - 0 - 0 - 0 - 1 - 1
  |   |   |   |   |   |   |
  0 - 0 - 0 - 0 - 0 - 0 - 1

(setq grid '((1 0 0 0 1 0 1)
             (0 0 0 0 0 1 1)
             (0 0 1 0 0 0 1)
             (1 0 0 0 0 1 1)
             (0 0 0 0 0 0 1)))

(setq girl '((0 0) (0 4) (0 5) (0 6) (2 2) (2 6) (3 0) (3 5) (3 6) (4 6)))

(meet grid girl)
;-> ((2 5) 31)

(setq grid '((0 1 0 0)
             (0 1 1 0)
             (0 0 0 0)))

(setq girl '((0 1) (1 1) (1 2)))

(meet grid girl)
;-> ((1 1) 2)


-------------------------------
Stringhe Unicode (UTF8) o ASCII
-------------------------------

Per verificare se una stringa contiene solo caratteri ASCII oppure contiene anche caratteri Unicode (UTF8) possiamo usare le seguenti due funzioni:

(define (ascii? str) (= (length str) (utf8len str)))

(define (utf? str) (!= (length str) (utf8len str)))

Se la lunghezza ASCII è uguale alla lunghezza UTF8, allora la stringa contiene solo caratteri ASCII, altrimenti contiene anche caratteri UTF8.

(setq s "abcde")
(ascii? s)
;-> true
(utf? s)
;-> nil

(setq s "abc╬de")
(ascii? s)
;-> nil
(utf? s)
;-> true

Nota: la funzione "utf8len" è disponibile solo nella versione di newLISP UTF8.


---------------------------------------------
Le funzioni "set-nth" e "nth-set" (deprecate)
---------------------------------------------

**********************
>>>funzione "SET-NTH"
**********************

syntax: (set-nth int-nth-1 [ int-nth-2 ... ] list|array exp-replacement)
syntax: (set-nth int-nth-1 str str-replacement)

syntax: (set-nth (list|array int-nth-1 [ int-nth-2 ... ]) exp-replacement)
syntax: (set-nth (str int-nth-1) str str-replacement)

set-nth works like nth-set, except instead of returning the replaced element, it returns the entire changed expression. For this reason, set-nth is slower on larger data objects.
------------------------

***********************
>>> funzione "NTH-SET"
***********************

syntax: (nth-set int-index list exp-replacement)

syntax: (nth-set (list int-nth-1 [ int-nth-2 ...]) exp-replacement)

syntax: (nth-set (array int-nth-1 [ int-nth-2 ...]) exp-replacement)

syntax: (nth-set (str int-nth-1) str str-replacement)

Sets the int-nth element of a list or array with the evaluation of exp-replacement and returns the old element. As shown in the last two syntax lines, implicit indexing syntax can be used for specifying indices. Implicit indexing is the preferred form in nth-set and set-nth, but both forms remain valid.

nth-set performs a destructive operation, changing the original list or array. More than one index can be specified to recursively traverse nested list structures or multidimensional arrays. An out-of-bounds index always returns the last or first element when indexing a list, but it causes an out-of-bound error when indexing an array.

When replacing in lists, the old element is also contained in the system variable $0 and can be used in the replacement expression itself.

(set 'aList '(a b c d e f g))   

;; plain syntax for on level index
(nth-set 4 aList (list $0 'z))     → e ; old value

;; modern syntax and preferred for multiple indices
(nth-set (aList 4) (list $0 'z))   → e ; old value

aList → (a b c d (e z) f g)

In the second form, the int-nth character in str is replaced with the string in str-replacement. Out-of-bounds indices will pick the first or last character for replacement, and the system variable $0 is set to the old, replaced character.

example:

;;;;;;;;;;; usage on lists ;;;;;;;;;;;;

(set 'aList '(a b c d e f g))

(nth-set (aList 2) "I am the replacement")  → c  ; new syntax

aList  → (a b "I am the replacement" d e f g)

$0  → c

(set 'aList '(a b (c d (e f g) h) i))
(nth-set (aList 2 2 0) 'x)  → e

aList  → (a b (c d (x f g) h) i)
$0     → e

(nth-set (aList -2 2 -1) 99)  → g

aList  → (a b (c d (x f 99) h) i)

;; use indices in a vector

(set 'aList '(a b (c d (e f g) h) i))

(set 'vec (ref 'f aList))  → (2 2 1)

(nth-set (aList vec) 'Z)  → f ; old value

aList  → (a b (c d (e Z g) h) i)

;; usage on default functors

(set 'db:db '(a b c d e f g))

(nth-set (db 3) 99)  → d

db:db  → (a b c 99 e f g)

The following examples use nth-set to change the contents of arrays.

example:

;;;;;;;;;;; usage on arrays ;;;;;;;;;;;;

(set 'myarray (array 3 4 (sequence 1 12)))
→ ((1 2 3 4) (5 6 7 8) (9 10 11 12))

(nth-set (myarray 2 3) 99)  → 12        
myarray  
→ ((1 2 3 4) (5 6 7 8) (9 10 11 99))

(nth-set (myarray -2 1) "hello")  → 6  
myarray
→ ((1 2 3 4) (5 "hello" 7 8) (9 10 11 99))

(nth-set (myarray 1) (array 4 '(a b c d)))
→ (5 "hello" 7 8)    
myarray
→ ((1 2 3 4) (a b c d) (9 10 11 99))

;; usage on default functors
(set 'myarray:myarray (array 7 '(a b c d e f g)))

(nth-set (myarray 3) 99)  → d
myarray:myarray           → (a b c 99 e f g)

When replacing whole rows as in the third example, care must be taken to replace it as an array. See also the array functions array, array?, and array-list.

In second form, the int-nth character in str is replaced with the string in str-replacement.

example:
;;;;;;;;;;; usage on strings ;;;;;;;;;;;;
(set 's "abcd")

(nth-set (s 0) "xyz")  → "a"   
s   → "xyzbcd"
$0  → "a"

nth-set uses the system variable $0 for the element found in lists and strings. This can be used in the replacement expression:

(set 'lst '(1 2 3 4))

(nth-set (lst 1) (+ $0 1))  → 2

lst  → '(1 3 3 4)

See the set-nth function, which works like nth-set but returns the whole changed expression instead of the replaced element. set-nth is also slower when doing replacements in larger lists or string buffers.

Use the nth, push, and pop functions to access multidimensional nested lists. The nth function will also work with multidimensional nested arrays.

nth-set works exactly like set-nth but returns the replaced element instead of the whole changed list expression. nth-set is much faster when replacing elements in larger lists or arrays.

------------------------

La funzione "set-nth" è deprecata e non è più disponibile nelle versione 10.7.5 di newLISP.
Questa funzione è stata sostituita da "setf" e l'indicizzazione implicita.
Riportiamo la sintassi della funzione "set-nth" al fine di facilitare la conversione di vecchi programmi newLISP che la utilizzano:

  (set-nth indice list|string|array value)

Sostituisce l'elemento in posizione "indice" di una lista, vettore o stringa con il valore del parametro "value".
Restituisce la nuova lista/array.

Esempi:

(setq s "abc")
;-> "abc"
(set-nth 0 s "z")
;-> "zbc"

(setq lst '(1 2 3 4))
;-> (1 2 3 4)
(set-nth 0 lst 99)
;-> (99 2 3 4)

Nella versione 10.7.5, al posto di set-nth, utilizziamo "setf" con l'indicizzazione implicita:

  (setf (list|string|array indice) value)

(setq s "abc")
;-> "abc"
(setf (s 0) "z")
;-> "z"
s
;-> "zbc"

(setq lst '(1 2 3 4))
;-> (1 2 3 4)
(setf (lst 0) 99)
;-> 99
lst
;-> (99 2 3 4)

Possiamo anche scrivere una funzione per simulare "set-nth":

(define (set-nth idx obj val)
  (setf (obj idx) val)
  obj)

(setq lst '(1 2 3 4))
(set-nth 0 lst "0")
;-> ("0" 1 2 3 4)

Ma in questo modo "lst" non vien modificata:

lst
;-> (1 2 3 4)

Quindi dobbiamo scrivere:

(setq lst (set-nth 0 lst "0"))
;-> ("0" 1 2 3 4)

Nota: abbiamo anche "push" e "pop" che possono inserire o estrarre pezzi di uno o più caratteri da una stringa:

(setq s "abc")
(pop s) (push "z" s)
;-> "a"
;-> "zbc"

Anche la funzione "nth-set" è deprecata e non è più disponibile nelle versione 10.7.5 di newLISP.
Questa funzione è stata sostituita da "setf" e l'indicizzazione implicita.
Riportiamo la sintassi della funzione "nth-set" al fine di facilitare la conversione di vecchi programmi newLISP che la utilizzano:

  (nth-set indice list|string|array value)

Sostituisce l'elemento in posizione "indice" di una lista, vettore o stringa con il valore del parametro "value".
Restituisce il valore inserito.

Nota: "nth-set" è (era) molto più veloce perché non ha bisogno di restituire l'intera lista o array.


----------------------------------------
Somma di interi rappresentati come liste
----------------------------------------

Sommare due numeri interi positivi contenuti in due liste.

Esempio:
lst1 = (1 4 3)
lst2 = (7 7)
lst1 + lst2 = (2 2 0)

L'algoritmo segue il procedimento manuale per fare una addizione.

(define (add-int lst1 lst2 out)
  (local (carry prev temp somma)
    (setq out '())
    ; riporto
    (setq carry 0)
    ; indici delle liste (partendo dalla fine)
    (setq idx1 (- (length lst1) 1))
    (setq idx2 (- (length lst2) 1))
    ; fino a che le liste non sono entrambe vuote
    (while (or (>= idx1 0) (>= idx2 0))
      ; prende le cifre correnti (partendo dall'ultima)
      ; se la lista è terminata, allora prende il valore 0
      ; altrimenti prende il valore corrispondente a idx
      (if (< idx1 0)
          (setq cifra1 0)
          (setq cifra1 (lst1 idx1))
      )
      (if (< idx2 0)
          (setq cifra2 0)
          (setq cifra2 (lst2 idx2))
      )
      ; somma delle due cifre e del riporto
      (setq somma (+ cifra1 cifra2 carry))
      ; verifica del riporto
      ; ed aggiustamento della somma (che deve essere una sola cifra)
      (if (< somma 10)
          (setq carry 0 somma somma)
          (setq carry 1 somma (% somma 10))
      )
      ; inserisce la somma nella lista soluzione
      (push somma out)
      ;(println somma { } carry)
      ; posiziona gli indici sulle prossime cifre
      (-- idx1)
      (-- idx2)
    )
    ; se abbiamo un riporto all'ultima cifra,
    ; allora lo inseriamo nella lista soluzione
    (if (= carry 1) (push carry out))
    out))

Proviamo la funzione:

(add-int '(3) '(6))
;-> (9)
(add-int '(3 1) '(6 2))
;-> (9 3)
(add-int '(3 6) '(8 6))
;-> (1 2 2)

Funzione che converte un numero intero in una lista di cifre:

(define (int-lst num)
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che converte una lista di cifre in intero:

(define (lst-int lst)
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(setq a 1237561238576352)
(setq b 123875612323)
(+ a b)
;-> 1237685114188675
(= (+ a b) (lst-int (add-int (int-lst a) (int-lst b))))
;-> true

Proviamo con degli interi big-integer:

(setq c 786762621237561238576352)
;-> 786762621237561238576352L
(setq d 222123875612323)
;-> 222123875612323
(+ c d)
;-> 786762621459685114188675L
(= (+ c d) (lst-int (add-int (int-lst c) (int-lst d))))
;-> true

(setq e 786762621237561238576352)
;-> 786762621237561238576352L
(setq f 131313131313131222123875612323L)
;-> 222123875612323
(+ e f)
;-> 131313918075752459685114188675L
(= (+ e f) (lst-int (add-int (int-lst e) (int-lst f))))
;-> true


---------------------------
Equazione diofantea lineare
---------------------------

Un'equazione diofantea (chiamata anche equazione diofantina) è un'equazione in una o più incognite con coefficienti interi di cui si ricercano le soluzioni intere.
Un'equazione diofantea lineare è un'equazione diofantea in cui le relazioni tra le variabili sono di tipo lineare.

Vediamo un algoritmo per trovare la soluzione (x0,y0), se esiste, di una equazione diofantea lineare a due incognite.
Possiamo usare l'algoritmo euclideo esteso. Innanzitutto, supponiamo che a e b siano non negativi. Quando applichiamo l'algoritmo euclideo esteso per a e b, possiamo trovare il loro massimo comune divisore g e due numeri xg e yg tali che:

  a*xg + b*yg = g

Se c è divisibile per g = gcd(a, b), allora l'equazione diofantea data ha una soluzione, altrimenti non ha alcuna soluzione. La dimostrazione è semplice: una combinazione lineare di due numeri è sempre divisibile per il loro comune divisore.

Ora supponiamo che c sia divisibile per g, quindi abbiamo:

  a*xg*c/g + b*yg*c/g = c

Pertanto una delle soluzioni dell'equazione diofantea è:

  x0 = xg*c/g
  y0 = yg*c/g

Questo metodo funziona anche quando a e/o b sono negativi.

La soluzione generale è data da:

  xk = x0 + k*b/(gcd a b)
  yk = y0 + k*a/(gcd a b)

Funzione implementa l'algoritmo di Euclide esteso:

(define (gcdex a b)
  (local (x y lastx lasty temp)
    (setq x 0)
    (setq y 1)
    (setq lastx 1)
    (setq lasty 0)
    (while (not (zero? b))
      (setq q (div a b))
      (setq r (% a b))
      (setq a b)
      (setq b r)
      (setq temp x)
      (setq x (- lastx (* q x)))
      (setq lastx temp)
      (setq temp y)
      (setq y (- lasty (* q y)))
      (setq lasty temp)
    )
    ; Adesso la variabile a contiene il valore di gcd
    ;(println a { } b { } x { } y { } lastx { } lasty)
    (list a lastx lasty)))

(gcdex 120 23)
;-> (1 -9 47)

(gcdex 8 -6)
;-> (2 1 1)

Funzione che risolve una equazione diofantea lineare (soluzione particolare e generale):

(define (diofanto a b c)
  (local (gcdex-lst g xg yg out)
    (setq out '())
    (setq gcdex-lst (gcdex a b))
    (setq g (first gcdex-lst))
    (setq xg (first (rest gcdex-lst)))
    (setq yg (last gcdex-lst))
    ;(println g { } xg { } yg)
    (cond ((not (zero? (% c g))) (setq out '()))
          (true
            (setq out (list (list (div (mul xg c) g) (div b g))
                            (list (div (mul yg c) g) (div (- a) g))))))
    out))

Facciamo alcune prove:

8x - 6y = 26
(diofanto 8 -6 26)
;-> ((13 -3) (13 -4))
x = 13 + -3k  (con k = 0 .. ∞)
y = 13 – 4k (con k = 0 .. ∞)

Infatti risulta:

(+ (* 13 8) (* 13 -6))
;-> 26

25x + 10y = 15
(diofanto 25 10 15)
;-> ((3 2) (-6 -5))
x = 3 + 2k  (con k = 0 .. ∞)
y = -6 – 5k (con k = 0 .. ∞)

21x + 14y = 35
(diofanto 21 14 35)
;-> ((5 2) (-5 -3))
x = 5 + 2k  (con k = 0 .. ∞)
y = -5 – 3k (con k = 0 .. ∞)

8x + 5y = 81
(diofanto 8 5 81)
;-> ((162 5) (-243 -8))
x = 162 + 5k  (con k = 0 .. ∞)
y = -243 – 8k (con k = 0 .. ∞)

19x + 13y = 20
(diofanto 19 13 20)
;-> ((-40 13) (60 -19))
x = -40 + 13k (con k = 0 .. ∞)
y = 60 – 19k  (con k = 0 .. ∞)

14x + 21y = 77
(diofanto 14 21 77)
;-> ((-11 3) (11 -2))
x = -11 + 3k (con k = 0 .. ∞)
y = 11 – 2k  (con k = 0 .. ∞)

40x + 16y = 88
(diofanto 40 16 88)
;-> ((-11 3) (11 -2))
x = 11 + 2k  (con k = 0 .. ∞)
y = -22 – 5k (con k = 0 .. ∞)


---------
Cache LRU
---------

Progettare e implementare una struttura dati per gestire una cache LRU (Least Recent Used) che memorizza gli ultimi N file utilizzati da un editor di testo. Le funzioni per gestire la cache sono: put e clear.
1) put(value) - Se il valore non è presente, allora inserisce il valore all'inizio della cache, altrimenti prima elimina il valore dalla cache e poi lo inserisce all'inizio. Quando la cache ha raggiunto la sua capacità, dovrebbe eliminare l'elemento utilizzato meno di recente prima di inserirne uno nuovo.
2) clear - Elimina tutti i valori dalla cache

Funzione per la creazione della cache:

(define (cacheLRU size)
    (setq cache '())
    (setq files (length cache))
    (setq capacity size)
)

Funzione "put":

(define (put value)
  (cond ((= files capacity) ; cache piena
         ; se il file si trova nella cache...
         (if (setq idx (find value cache))
             (begin (pop cache idx)    ; lo cancello
                   (push value cache)) ; e poi lo inserisco all'inizio
             ; altrimenti...
             (begin (pop cache -1)      ; elimino l'ultimo file
                    (push value cache)) ; e poi inserisco il nuovo all'inizio
         ))
        (true ; cache non piena
         ; se il file si trova nella cache...
         (if (setq idx (find value cache))
             (begin
             (pop cache idx) ; lo cancello
             (-- files)) ; aggiorna il numero di file
         )
         ; inserisco il file all'inizio della cache
         (push value cache)
         ; aggiorna il numero di file
         (++ files)
        )
  )
  files)

Funzione "clear":

(define (clear)
  (setq cache '())
  (setq files (length cache)))

Proviamo le funzioni:

(cacheLRU 4)
;-> 4
(put "pippo")
;-> 1
cache
;-> ("pippo")
(put "gioia")
;-> 2
cache
;-> ("gioia" "pippo")
(put "data")
;-> 3
cache
;-> ("data" "gioia" "pippo")
(put "gioia")
;-> 3
cache
;-> ("gioia" "data" "pippo")
(put "pasta")
;-> 4
cache
;-> ("pasta" "gioia" "data" "pippo")
(put "plot")
;-> 4
cache
;-> ("plot" "pasta" "gioia" "data")
(put "gioia")
;-> 4
cache
;-> ("gioia" "plot" "pasta" "data")


----------------------------
Un bug della versione 10.7.5
----------------------------

Creiamo un vettore numerico:
(setq m (array 256 (sequence 0 255)))

Creiamo una stringa
(setq str "abc")

Adesso se indicizziamo il vettore con il codice di un carattere della stringa otteniamo un errore:

(setq (m (char (str 0))) -1)
;-> ERR: string expected : -1

L'espressione è corretta, ma questo è un bug della funzione "char" nella versione 10.7.5.

Nota: If char() retuns a number stringCell should be NULL (Lutz).

Per ovviare a questo problema è sufficiente utilizzare le seguenti due funzioni, che convertono i caratteri ASCII nei relativi codici e viceversa, al posto della funzione "char". Le funzioni rendono anche più leggibili i programmi ("char" è polimorfica).

Funzione che converte un carattere ASCII nel relativo codice:

(define (char-int ch) (char ch))

Funzione che converte un codice nel relativo carattere ASCII:

(define (int-char num) (char num))

Adesso l'espressione precedente non genera un errore:

(setq (m (char-int (str 0))) -1)
;-> -1
(m (char-int "a"))
;-> -1
(m (char-int (int-char 97)))
;-> -1


--------------------------------
Algoritmo LZW (Lempel Ziv Welch)
--------------------------------

Riferimenti
-----------
Quello che segue è la traduzione libera dell'articolo disponibile al seguente indirizzo web:
https://iq.opengenus.org/lempel-ziv-welch-compression-and-decompression/
OpenGenus IQ © 2021 All rights reserved ™ [email: team@opengenus.org]
Nota: Le funzioni newLISP sono liberamente utilizzabili.

Introduzione
------------
Questo algoritmo di compressione dati è stato sviluppato da Abraham Lempel, Jacob Ziv e successivamente pubblicato da Terry Welch nel 1984. Si tratta di un algoritmo senza perdita di dati (lossless), il che significa che nessun valore viene perso durante la compressione e la decompressione dei dati.

L'algoritmo lavora sul concetto che i codici interi (numeri) occupano meno spazio in memoria rispetto alle stringhe letterali permettendo  così una compressione dei dati. L'algoritmo LZW legge la sequenza dei caratteri e inizia a raggrupparli in modelli di stringhe ripetitivi e poi li converte in codici interi a 12 bit in modo da comprimere i dati senza alcuna perdita.

Vantaggi dell'algoritmo LZW
---------------------------
I vantaggi dell'algoritmo LZW sono:
  - è più veloce rispetto agli altri algoritmi.
  - è semplice, facile ed efficiente.
  - comprime i dati in un unico passaggio.
  - funziona in modo più efficiente per i file che contengono molti dati ripetitivi.
  - costruisce la tabella di codifica e decodifica durante l'esecuzione e non richiede alcuna informazione preventiva sull'input.
  - tende ad avere un rapporto di compressione del 60-70% sui file di testo.

Vediamo un esempio semplificato sul funzionamento della tecnica di compressione LZW.

Funzionamento dell'algoritmo LZW
--------------------------------
L'algoritmo ha due parti, una funzione di codifica (encoder) che converte le stringhe in codici interi e una funzione di decodifica (decoder) che fa l'inverso.

Sia l'algoritmo di codifica che quello di decodifica hanno una tabella predefinita o un set di dati di una coppia di stringhe di codice che funge da modello iniziale sia per il codificatore che per il decodificatore. E quando l'algoritmo va avanti, i nuovi codici interi per i vari modelli di stringa vengono aggiunti a questa tabella.

Formazione della tabella di mappatura
-------------------------------------
La tabella di mappatura o la tabella dei caratteri è predefinita con tutti i singoli codici dei caratteri ASCII di default da 0-255. Quando analizza la stringa di input, inizia con un singolo carattere e poi aggiunge caratteri per formare nuove stringhe. Ogni volta che aggiunge un carattere, verifica se la stringa appena formata è già presente nella tabella, altrimenti mappa la stringa appena formata con il codice successivo disponibile nella tabella di mappatura, creando così un nuovo elemento nella tabella.

Dopo aver aggiornato la tabella con il nuovo modello di stringa, inizia di nuovo con l'ultimo carattere aggiunto e inizia ad aggiungere caratteri e poi continua nuovamente con lo stesso processo. Pertanto, durante il processo di lettura dei dati, la tabella di mappatura viene aggiornata con i modelli di stringa più recenti utilizzati nella compressione.

Algoritmo dell'encoder
----------------------
Come appena detto, l'algoritmo LZW crea una tabella di mappatura che associa le stringhe ai codici interi e restituisce il codice per i dati compressi. E quando l'algoritmo vede di nuovo la stessa stringa, aggiunge il carattere successivo e crea una nuova stringa. Quindi la stringa diventa sempre più grande, il che porta a una compressione efficiente dei dati.

Passi
-----
1. Creare la Tabella per mappare i codici e le stringhe (hash-map)
2. Creare una lista per memorizzare i codici per la stringa da comprimere e una variabile per memorizzare il codice successivo per ogni modello di stringa.
3. Creare una variabile vuota per contenere la stringa corrente.
4. Per ogni carattere nella stringa (i), aggiungere il carattere alla variabile corrente.
   - Controllare se la stringa corrente non è nel dizionario.
   - Quindi mapparlo su nxt_code e aggiungerlo al dizionario.
   - Aumentare nxt_code di 1.
   - Ora aggiungere il codice per la stringa corrente ignorando il carattere corrente, ovvero i, alla lista soluzione.
   - Ora assegnare la stringa corrente solo al carattere corrente i.
5. E prima di restituire i codici compressi, aggiungi il codice alla stringa corrente nel dizionario.
6. Ora, restituiamo i codici di compressione per la stringa di input.

Implementazione in python
-------------------------
def lzw_encoder(string):
    table = dict()
    lis = []
    # creating the table for default compression codes
    for i in range(256):
        table[chr(i)] = i
    current = ''    # a variable to hold the string patterns
    nxt_code = 257  # a variable to hold the next code for the string
    for i in string:
        current += i # appends the current character to the current string
        if ( current not in table ):
            table[current] = nxt_code # adds a new string pattern to the table
            nxt_code += 1
            current = current[:-1] # deletes the last character of i
            # appends the code for current string to the answer list
            lis.append( table[current] )
            current = i # reassigns the value of current to i
    lis.append(table[current])
    # adds the last string pattern to the table
    return lis # returns the compressed code

print(lzw_encoder('XYYXYYYXYYX'))
;-> [88, 89, 89, 257, 258, 260, 88]

Implementazione in newLISP
--------------------------
(define (lzw-encode str)
  (local (lis current nxt-code)
    # creates the table as hash-map
    (new Tree 'table)
    (setq lis '())
    # creating the table for default compression codes
    (for (i 0 255)
      (table (char i) i)
    )
    # a variable to hold the string patterns
    (setq current "")
    # a variable to hold the next code for the string
    (setq nxt-code 257)
    (dolist (i (explode str))
      # appends the current character to the current string
      (extend current i)
      (if (= (table current) nil)
          (begin
          # adds a new string pattern to the table
          (table current nxt-code)
          (++ nxt-code)
          # deletes the last character of i
          (pop current -1)
          # appends the code for current string to the answer list
          (push (table current) lis -1)
          # reassigns the value of current to i
          (setq current i))
      )
    )
    # adds the last string pattern to the table
    (push (table current) lis -1)
    # delete the hash-map table
    (delete 'table)
    # returns the compressed code
    lis))

(lzw-encode "XYYXYYYXYYX")
;-> (88 89 89 257 258 260 88)

Analizziamo come funziona l'encoder:

La funzione ottiene la stringa da comprimere come input e quindi crea un dizionario per memorizzare i codici predefiniti. Questo dizionario memorizza i valori per tutte le possibili stringhe di caratteri singoli con codici 0-255.

Quindi, aggiunge i caratteri della stringa di input alla variabile stringa corrente. Quindi controlla se la stringa corrente è nel dizionario se è nel dizionario aggiunge semplicemente il carattere di input successivo alla variabile stringa corrente. Quando la stringa corrente non è nel dizionario, la aggiunge al dizionario e aumenta nxt_code di uno.

E dopo aver aggiunto la stringa corrente al dizionario, rimuove l'ultimo carattere da esso e quindi restituisce il codice per la stringa corrente. Questo perché la stringa corrente insieme all'ultimo carattere comprende la nuova stringa che viene aggiunta al dizionario, quindi per ottenere il codice per lo schema di stringa precedente eliminiamo l'ultimo carattere.

E continua a farlo finché l'intera stringa non viene convertita in codici. E alla fine, aggiunge al dizionario il codice per la stringa rimanente che è memorizzata nella variabile corrente. E poi restituisce i codici di output.

Ecco un esempio di input e output dell'algoritmo di encoder LZW:

  Stringa di input: XYYXYYYXYYX
  Codici di uscita: (88 89 89 257 258 260 88)

Algoritmo del decoder
---------------------
Il decoder fa l'esatto opposto di quello che ha fatto l'endoder. Prendiamo i codici forniti come input e li convertiamo nei modelli di stringa corretti e li uniamo nuovamente per ottenere la stringa decompressa.

Nota: qui il dizionario è composto da coppie codice-stringa mentre il dizionario nell'encoder è composto da coppie stringa-codice, questo è solo per la semplificare l'accesso ai valori richiesti.

Passi
-----
1. Creare la tabella predefinita per mappare tutti i singoli caratteri ASCII con i codici interi 0-255.
2. Creare una variabile per memorizzare la stringa precedente e una variabile per memorizzare la stringa di output finale.
3. Ora per ogni codice intero, aggiungiamo la stringa corrispondente dalla tabella alla stringa di risposta.
   - Se la variabile precedente contiene una stringa, la tabella dei codici viene aggiornata con il nuovo codice insieme alla sua stringa.
   - Il valore della variabile precedente è impostato sulla stringa del codice corrente.
4. Infine, viene restituita la stringa di output.

Implementazione in python
-------------------------
def lzw_decoder(lis):
    table = dict()
    # Creating a dictionary with default values of codes and strings
    for i in range(256):
        table[i] = chr(i)
    previous = ''
    nxt_code = 257
    ans = ''
    for i in lis:
        ans += table[i] # adding the strings to the output variable
        if ( previous != '' ):
            table[nxt_code] = previous + table[i][0] # updating the table
            print(table[i], ' ', table[i][0])
            nxt_code += 1
        previous = table[i] # reassigning the previous with the new string
    return ans

print(lzw_decoder([88, 89, 89, 257, 258, 260, 88]))
;-> XYYXYYYXYYX

Implementazione in newLISP
--------------------------
(define (lzw-decode lis)
  (local (previous nxt-code ans)
    # creates the table as hash-map
    (new Tree 'table)
    # Creating a dictionary with default values of codes and strings
    (for (i 0 255)
      (table (string i) (char i))
    )
    (setq previous "")
    (setq nxt-code 257)
    (setq ans "")
    (dolist (i lis)
      # adding the strings to the output variable
      (extend ans (table i))
      (if (!= previous "")
        (begin
        # updating the table
        (table (string nxt-code) (append previous ((table i) 0)))
        (++ nxt-code))
      )
      # reassigning the previous with the new string
      (setq previous (table i))
    )
    (delete 'table)
    ans))

(lzw-decode '(88 89 89 257 258 260 88))
;-> "XYYXYYYXYYX"

(lzw-encode "newLISP is fun")
;-> (110 101 119 76 73 83 80 32 105 115 32 102 117 110)
(lzw-decode '(110 101 119 76 73 83 80 32 105 115 32 102 117 110))
;-> "newLISP is fun"
(lzw-decode (lzw-encode "newLISP is fun"))
;-> "newLISP is fun"

Analizziamo come funziona decoder:

Crea un dizionario dei codici insieme alle stringhe dei singoli caratteri proprio come abbiamo fatto nell'encoder. E quindi crea le variabili per memorizzare la stringa di output, il codice successivo da creare e la stringa precedente.

E poi aggiunge semplicemente la stringa corrispondente per ogni codice di input alla variabile di output. Se la variabile precedente contiene una stringa, l'istruzione if viene eseguita e la tabella viene aggiornata con il nuovo valore del codice.

E quando il ciclo termina, la funzione restituisce la stringa di output.

Ecco un esempio di input e output dell'algoritmo di decoder LZW:

  Codici di input: (88 89 89 257 258 260 88)
  Stringa di uscita: XYYXYYYXYYX

Punti importanti
----------------
- La complessità temporale e spaziale dell'algoritmo è O(n).
- L'algoritmo LZW non necessita di alcuna informazione preventiva sui dati da comprimere, rendendolo così più versatile.
- L'algoritmo LZW si adatta al tipo di dati in elaborazione, quindi non richiede alcuna guida del programmatore o pre-analisi dei dati.
- L'algoritmo LZW non fornisce sempre un risultato di compressione ottimale.
- L'effettiva compressione dell'algoritmo LZW è difficile da prevedere.

Conclusione
-----------
Il codice riportato non è l'algoritmo completo di Lempel Ziv Welch, è solo un semplice esempio per capire come funziona, ma contiene tutti i dettagli richiesti per implementare l'algoritmo.

Per una visione completa potete leggere il documento pubblicato da Welch nel 1984 al seguente indirizzo web:

https://courses.cs.duke.edu/spring03/cps296.5/papers/welch_1984_technique_for.pdf


-------------------------------
Moltiplicazione di due polinomi
-------------------------------

Dati due polinomi, calcolare la loro moltiplicazione.
Supponiamo che i polinomi siano rappresentati come liste con la seguente struttura:

f(x) = a0 + a1*x + a2*x^2 + ... + an*x^n

lista = (a0 a1 a2 ... an)

(define (mul-poly p1 p2)
  (local (res l1 l2)
    (setq l1 (length p1))
    (setq l2 (length p2))
    (setq res (dup 0 (+ l1 l2 (- 1))))
    (for (i 0 (- l1 1))
      (for (j 0 (- l2 1))
        (setf (res (+ i j)) (add (res (+ i j)) (mul (p1 i) (p2 j))))
      )
    )
    res))

(mul-poly '(0 1 2) '(0 1 2))
;-> (0 0 1 4 4)

(mul-poly (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6))
          (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6)))
;-> (0 0 0.02777777777777778 0.05555555555555555 0.08333333333333333
;->  0.1111111111111111 0.1388888888888889 0.1111111111111111
;->  0.08333333333333333 0.05555555555555555 0.02777777777777778)


-------------------------
Addizione di due polinomi
-------------------------

Dati due polinomi, calcolare la loro addizione.
Supponiamo che i polinomi siano rappresentati come liste con la seguente struttura:

f(x) = a0 + a1*x + a2*x^2 + ... + an*x^n

lista = (a0 a1 a2 ... an)

(define (add-poly p1 p2)
  (local (res l1 l2)
    (setq l1 (length p1))
    (setq l2 (length p2))
    (cond ((>= l1 l2)
           (setq res p1)
           (for (i 0 (- l2 1))
             (setf (res i) (add (res i) (p2 i))))
          )
          ((< l1 l2)
           (setq res p2)
           (for (i 0 (- l1 1))
             (setf (res i) (add (res i) (p1 i))))
          )
    )
    res))

(add-poly '(5 0 10 6) '(1 2 4))
;-> (6 2 14 6)

(add-poly '(1 2 4) '(5 0 10 6))
;-> (6 2 14 6)

(add-poly '(1 2 3) '(3 2 1))
;-> (4 4 4)


---------------------------
Sottrazione di due polinomi
---------------------------

Dati due polinomi, calcolare la loro sottrazione.
Supponiamo che i polinomi siano rappresentati come liste con la seguente struttura:

f(x) = a0 + a1*x + a2*x^2 + ... + an*x^n

lista = (a0 a1 a2 ... an)

(define (sub-poly p1 p2)
  (local (res l1 l2)
    (setq l1 (length p1))
    (setq l2 (length p2))
    (cond ((>= l1 l2)
           (setq res p1)
           (for (i 0 (- l2 1))
             (setf (res i) (sub (res i) (p2 i))))
          )
          ((< l1 l2)
           (setq res p2)
           (for (i 0 (- l1 1))
             (setf (res i) (sub (p1 i) (res i))))
          )
    )
    res))

(sub-poly '(5 0 10 6) '(1 2 4))
;-> (4 -2 6 6)

(sub-poly '(1 2 4) '(5 0 10 6))
;-> (-4 2 -6 6)

(sub-poly '(1 2 3) '(3 2 1))
;-> (-2 0 2)

(sub-poly '(-9 2 5) '(-3 2 2))
;-> (-6 0 3)


------------
Dadi e somme
------------

Dati d dadi ciascuno con f facce. Trovare il numero di modi in cui è possibile ottenere una determinata somma quando vengono lanciati i dadi.
Vediamo un esempio:
Se ci sono 2 dadi con 2 facce, per ottenere la somma come 3, ci possono essere 2 modi:
a) (1 + 2) Il primo dado avrà il valore 1 e il secondo avrà 2.
b) (2 + 1) Il primo dado avrà il valore 2 e il secondo avrà 1.
Quindi, per f=2, d=2, s=3, la risposta sarà 2.

Risolviamo il problema con la forza bruta.
Dobbiamo trovare tutte le possibili combinazioni per ogni dado e poi calcolare la somma di tutte le facce, per verificare se otteniamo il valore s. Dobbiamo usare una variabile per tenere il conto di quante volte otteniamo la somma uguale ad s, e il valore di questa variabile sarà la risposta.
Tuttavia, questo approccio richiede molto tempo che dipende dal numero di dadi e dal numero delle facce.
La complessità temporale vale O(d^2 * f) perchè ci sono (d * f) combinazioni e per ogni combinazione occorre O(d) tempo per ottenere la somma.

Per trovare tutte le possibili combinazioni dei dadi utilizziamo una funzione che calcola il prodotto cartesiano di tutte le sotto-liste di una lista. In questo modo il risultato sarà una lista che contiene tutti i possibili risultati del lancio dei dadi come sotto-liste.

Funzione per calcolare il prodotto cartesiano di due liste:

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

Con 2 dadi da 2 facce abbiamo i seguenti possibili risultati (lanci):

(cp '(1 2) '(1 2))
;-> ((1 1) (1 2) (2 1) (2 2))

Funzione per calcolare il prodotto cartesiano di tutte le sotto-liste di una lista:

(define (cp-all lst-lst)
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1))))

Con 5 dadi da 3 facce abbiamo i seguenti possibili risultati (lanci):

(cp-all '((1 2 3) (1 2 3) (1 2 3) (1 2 3) (1 2 3)))
;-> ((1 1 1 1 1) (1 1 1 1 2) (1 1 1 1 3) (1 1 1 2 1) (1 1 1 2 2)
;->  (1 1 1 2 3) (1 1 1 3 1) (1 1 1 3 2) (1 1 1 3 3) (1 1 2 1 1)
;->  ...
;->  (3 3 3 2 2) (3 3 3 2 3) (3 3 3 3 1) (3 3 3 3 2) (3 3 3 3 3))

Per calcolare la somma di ogni sotto-lista (cioè la somma di ogni lancio) usiamo la seguente espressione:

(setq results (map (fn(x) (apply + x))
                   (cp-all '((1 2 3) (1 2 3) (1 2 3) (1 2 3) (1 2 3)))))

Per vedere quante volte la nostra somma è uguale alla somma di ogni lancio usiamo la funzione "count":

(setq success (first (count (list 6) results)))
;-> 5

Il numero totale dei lanci è dato dalla lunghezza della lista dei risultati:

(setq num-events (length results))
;-> 243

Adesso possiamo scrivere la funzione finale:

(define (lanci dadi facce somma)
  (local (dlst results success)
    ; lista che contiene le facce di ogni dado
    (setq dlst (dup (sequence 1 facce) dadi))
    ; calcolo della lista con le somme di ogni lancio possibile
    (setq results (map (fn(x) (apply + x))
                   (cp-all dlst)))
    ; conta dei valori uguali a somma
    (setq success (first (count (list somma) results)))
    (println (length results))
    success
  ))

(lanci 2 2 3)
;-> 2

(lanci 2 6 2)
;-> 1

(lanci 3 6 12)
;-> 25

(lanci 5 6 21)
;-> 540

Nota: il numero di lanci vale facce^dadi, un valore che cresce molto rapidamente:
- 5 dadi con 6 facce -> 6^5 = 7776 lanci
- 10 dadi con 6 facce -> 6^10 = 60466176 lanci (60 milioni 466 mila 176)
Poichè memorizziamo tutti i lanci in una lista è chiaro che non possiamo utilizzare questa funzione quando abbiamo parecchi dadi.

Allora proviamo un altro metodo che utilizza la programmazione dinamica.
Poniamo che la funzione per trovare il numero di modi per trovare la somma s da d dadi con f facce sia Somma(f,d,s)

Somma(f,d,s) =
  [ottenendo la somma (s-1) da (d-1) dadi quando il d-esimo dado ha valore 1]
+ [ottenendo la somma (s-2) da (d-1) dadi quando il d-esimo dado ha valore 2]
+ [ottenendo la somma (s-3) da (d-1) dadi quando il d-esimo dado ha valore 3]
+ ................................................. .............
+ [ottenendo la somma (s-f) da (d-1) dadi quando il d-esimo dado ha valore f]

Il valore massimo del d-esimo dado vale f poiché ci sono solo f facce nei dadi.

Vediamo un esempio, 3 dadi con 6 facce e somma 8:

f = 5, d = 3, s = 8

Quindi, abbiamo 3 dadi con 5 facce e dobbiamo trovare il numero di modi per ottenere la somma come 8.

Somma(5,3,8) = 3° dado che ottiene 1 + 3° dado che ottiene 2 + 3° dado che ottiene 3 + ...... + 3° dado che ottiene 5

Somma(5,3,8) = Somma(5,2,7) + Somma(5,2,6) + Somma(5,2,5) + Somma(5,2,4) + Somma(5,2,3)
Il 3° dado può avere un valore massimo di 5, poiché ci sono 5 facce. Quindi ci fermiamo a Somma(5,2,3).

Inoltre,

Somma(5,3,7) = Somma(5,2,6) + Somma(5,2,5) + Somma(5,2,4) + Somma(5,2,3) + Somma(5,2 ,2)
Con 2 dadi, la somma minima deve essere 2.

Quindi, otteniamo:

Somma(5,3,8) = Somma(5,3,7) + Somma(5,2,7)

Pertanto, in termini generali:

  Somma(f,d,s) = Somma(f,d,s-1) + Somma(f,d-1,s-1)

Possiamo inoltre trovare Sum(5,2,7) come

Somma(5,2,7) = Somma(5,1,6) + Somma(5,1,5) + Somma(5,1,4) + Somma(5,1,3) + Somma(5,1 ,2)

Tuttavia, Sum(5,1,6) = 0, poiché non possiamo avere una somma di 6 con 1 dado con 5 facce.

Perciò,

Somma(5,2,7) = Somma(5,1,5) + Somma(5,1,4) + Somma(5,1,3) + Somma(5,1,2)

Questo processo continua per tutta l'equazione.

  Somma(f,1,s) sarà sempre 1 quando s<=f, poiché con un dado, c'è solo un modo per ottenere la somma s.
  Somma(f,1,s) sarà 0 quando s>f, poiché non c'è un numero sufficiente di facce o dadi, per ottenere la somma s. Quindi, ci sono 0 modi.

Quindi, nel il nostro esempio:

Somma(5,2,7) = 1 + 1 + 1 + 1 = 4

In questo modo possiamo chiamare ogni funzione ed quindi trovare la somma(5,3,8). Memorizzeremo tutti i valori in una tabella 2d con gli indici i e j che variano 1 <= i <= d, 1 <= j <= s. Usiamo questa tabella[i][j] per trovare e memorizzare tutti i valori successivi partendo da un valore di base.
Il valore base è il seguente:

  somma(f,0,0) = 1
  cioè table[0][0] = 1

La complessità temporale vale O(n * x) dove n è il numero di dadi e x è la somma.

Adesso possiamo scrivere la funzione finale:

(define (lanci-dp d f s)
  (local (table)
    ; inizializzazione tabella con tutti 0
    (setq table (array (+ d 1) (+ s 1) '(0)))
    ; valore iniziale
    (setf (table 0 0) 1)
    ; ciclo per ogni dado
    (for (i 1 d)
      ; ciclo per ogni somma
      (for (j i s)
        ; equazione generale per ottenere sum(f,s,d)
        (setf (table i j) (+ (table i (- j 1)) (table (- i 1) (- j 1))))
        ; alcuni valori extra vengono aggiunti quando j>f
        ; cioè quando la somma da trovare è maggiore del numero di facce.
        ; Tali valori devono essere rimossi.
        (if (> j f)
            (setq (table i j) (- (table i j) (table (- i 1) (- j f 1))))
        )
      )
    )
    (table d s)))

(lanci-dp 2 2 3)
;-> 2

(lanci-dp 2 6 2)
;-> 1

(lanci-dp 3 6 12)
;-> 25

(lanci-dp 5 6 21)
;-> 540

Con questa funzione possiamo usare un numero elevato di dadi:

(lanci-dp 10 6 21)
;-> 147940

(lanci-dp 10 12 42)
;-> 251287465

Inoltre possiamo anche stabilire le probabilità di uscita di ogni valore possibile. Ad esempio due dadi con sei facce hanno le seguenti probabilità:

(define (dadi-prob dadi facce)
  (local (out min-val max-val num-lanci)
    (setq out '())
    (setq min-val dadi)
    (setq max-val (* facce dadi))
    (setq num-lanci (pow facce dadi))
    (println num-lanci)
    (for (i min-val max-val)
      (setq success (lanci-dp dadi facce i))
      (push (list i success (div success num-lanci)) out -1)
    )
    out))

(dadi-prob 2 6)
;-> 36
;-> ((2 1 0.02777777777777778) (3 2 0.05555555555555555)
;->  (4 3 0.08333333333333333) (5  4 0.1111111111111111)
;->  (6 5 0.1388888888888889) (7 6 0.1666666666666667)
;->  (8 5 0.1388888888888889) (9 4 0.1111111111111111)
;->  (10 3 0.08333333333333333) (11 2 0.05555555555555555)
;->  (12 1 0.02777777777777778))

Metodo dei polinomi
-------------------
Per calcolare la probabilità di uscita di un numero dovuta al lancio di alcuni dadi possiamo utilizzare anche il metodo dei polinomi.
Questo metodo rappresenta un dado a n facce con il seguente polinomio:

         n
  f(x) = ∑ (x^i)*p(i), dove p(i) è la probabilità dell'evento i-esimo
        i=1

Ad esempio il polinomio per un dado da 6 facce vale:

f(x) = (1/6)*x + (1/6)*x^2 + (1/6)*x^3 + (1/6)*x^4 + (1/6)*x^5 + (1/6)*x^6

Il primo passo per risolvere il problema è quello di rappresentare tutti i dadi con un polinomio.
Poi occorre moltiplicare tutti i polinomi tra loro.
I coefficienti del polinomio risultante rappresentano le probabilità di uscita del numero che rappresenta la potenza del termine x associato.

Facciamo un esempio, due dadi con sei facce hanno i seguenti polinomi:

f1(x) = (1/6)*x + (1/6)*x^2 + (1/6)*x^3 + (1/6)*x^4 + (1/6)*x^5 + (1/6)*x^6
f2(x) = (1/6)*x + (1/6)*x^2 + (1/6)*x^3 + (1/6)*x^4 + (1/6)*x^5 + (1/6)*x^6

Il loro prodotto vale:

f1(x) * f2(x) = (1/36)*x^12 + (1/18)*x^11 + (1/12)*x^10 + (1/9)x^9 +
                (5/36)*x^8 + (1/6)*x^7 + (5/36)*x^6) + (1/9)*x^5 +
                (1/12)*x^4 + (1/18)*x^3 + (1/36)*x^2

Questo polinomio dice che:
12 ha probabilità di uscire 1/36 = 0.02777777777777778
11 ha probabilità di uscire 1/18 = 0.05555555555555555
10 ha probabilità di uscire 1/12 = 0.08333333333333333
 9 ha probabilità di uscire 1/9  = 0.1111111111111111
 8 ha probabilità di uscire 5/36 = 0.1388888888888889
 7 ha probabilità di uscire 1/6  = 0.1666666666666667
 6 ha probabilità di uscire 5/36 = 0.1388888888888889
 5 ha probabilità di uscire 1/9  = 0.1111111111111111
 4 ha probabilità di uscire 1/12 = 0.08333333333333333
 3 ha probabilità di uscire 1/18 = 0.05555555555555555
 2 ha probabilità di uscire 1/36 = 0.02777777777777778

Scriviamo una funzione che calcola il prodotto di due polinomi:

(define (mul-poly p1 p2)
  (local (prod l1 l2)
    (setq l1 (length p1))
    (setq l2 (length p2))
    (setq prod (dup 0 (+ l1 l2 (- 1))))
    (for (i 0 (- l1 1))
      (for (j 0 (- l2 1))
        (setf (prod (+ i j)) (add (prod (+ i j)) (mul (p1 i) (p2 j))))
      )
    )
    prod))

Applichiamo il metodo al nostro esempio:

(setq p1 (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6)))
(setq p2 (list 0 (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6) (div 1 6)))
(mul-poly p1 p2)
;-> (0 0 0.02777777777777778 0.05555555555555555 0.08333333333333333
;->  0.1111111111111111 0.1388888888888889 0.1666666666666667
;->  0.1388888888888889 0.1111111111111111 0.08333333333333333
;->  0.05555555555555555 0.02777777777777778)

I risultati sono uguali a quelli trovati con funzione che usa la programmazione dinamica.

Nota: il metodo dei polinomi è applicabile anche quando le probabilità di uscita dei singoli numeri dei dadi sono differenti.


---------------------------------
Stringhe e dizionari (word break)
---------------------------------

Data una stringa e un dizionario di parole, determinare se S può essere divisa in due sottostringhe non vuote contenute nel dizionario. Per esempio, la stringa = "antifoop" può essere divisa in due sottostringhe "anti" e "foop" che sono contenute entrambe nel dizionario/lista = ("half" "foop" "doing" "way" "demo" "super" "anti").

La funzione è la seguente:

(define (test s words)
  (local (start end)
    (setq start 0)
    (setq end (length s))
    (for (i start (- end 1))
      (setq a (slice s start i))
      (setq b (slice s i end))
      ;(println a { - } b)
      (if (and (find a words) (find b words))
          (println a { } b { } (string a b))
      )
    )))

(setq lst '("half" "foop" "doing" "way" "demo" "super" "anti"))

(test "halfway" lst)
;-> half way halfway

(test "superdemo" lst)
;-> super demo superdemo

(test "doing" lst)
;-> nil

Un problema più difficile è quello di determinare se la stringa può essere divisa in una o più sottostringhe non vuote contenute nel dizionario.

Utilizziamo la ricorsione per risolvere questo problema. Consideriamo uno per uno tutti i prefissi della stringa corrente e controlliamo se il prefisso corrente è presente nel dizionario o meno. Se il prefisso è una parola valida, la aggiungiamo alla stringa di output e ripetila per la stringa rimanente. Il caso base della parola ricorsione è quando la stringa diventa vuota e stampiamo la stringa di output.

Funzione per estrarre una sottostringa da una stringa (dall'indice start all'indice (end - 1)):

(define (substr str start end)
  (if (or (= str "") (>= start (length str)))
      ""
      (select str (sequence start (- end 1)))))

(substr "zippo" 0 1)
;-> "z"
(substr "zippo" 0 0)
;-> "zo"
(substr "zippo" 1 1)
;-> "iz"
(substr "" 0 0)
;-> ""
(substr "" 1 3)
;-> ""

Adesso scriviamo la funzione ausiliaria e quella principale:

(define (wordbreak dict word out)
  (cond ((zero? (length word))
         (println ":" out)
         (push (trim out) sol -1)
         nil)
        (true
         (for (i 1 (length word))
            (setq pre (substr word 0 i))
            (if (find pre dict)
                (wordbreak dict (substr word i (length word)) (string out " " pre))
            )))))

(define (word-break dict word)
  (local (sol)
    (setq sol '())
    (wordbreak dict word "")
    sol))

Vediamo alcuni esempi:

(setq dizio '("super" "demo" "is" "famous" "anti" "break" "problem"))
(word-break dizio "superantibreak" "")
;-> : super anti break
;-> ("super anti break")
(word-break dizio "superantibrea")
;-> ()
(word-break dizio "problemisdemo")
;-> :  problem is demo
;-> ("problem is demo")

(setq dizio '("this" "th" "is" "famous" "Word" "break" "b" "r" "e" "a" "k" "br" "bre" "brea" "ak" "problem"))
(word-break dizio "Wordbreakproblem")
;-> : Word b r e a k problem
;-> : Word b r e ak problem
;-> : Word br e a k problem
;-> : Word br e ak problem
;-> : Word bre a k problem
;-> : Word bre ak problem
;-> : Word brea k problem
;-> : Word break problem
;-> ("Word b r e a k problem" "Word b r e ak problem"
;->  "Word br e a k problem" "Word br e ak problem"
;->  "Word bre a k problem" "Word bre ak problem"
;->  "Word brea k problem" "Word break problem")


------------------------------------------------
Estrazione codice sorgente da eseguibile newLISP
------------------------------------------------

Il codice sorgente e l'eseguibile newLISP.exe possono essere uniti tra loro per creare un'applicazione autonoma utilizzando il flag della riga di comando -x.

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende la prima parola dalla riga di comando e la converte in maiuscolo.

Per compilare questo programma come eseguibile autonomo, occorre salvare il file con un nome (uppercase.lsp) e poi eseguire dal terminale la seguente procedura (windows):

newlisp -x uppercase.lsp uppercase.exe

newLISP prende l'eseguibile "newLISP.exe" e lo unisce ad una copia del file che contiene il codice sorgente "uppercase.lsp" per creare il programma "uppercase.exe".

La seguente funzione "get-code" prende un eseguibile creato con newLISP ed estrae il codice sorgente su un file indicato.
Il file sorgente è si trova in fondo al file eseguibile. La funzione legge mette tutti i bytes/caratteri del file in una lista (in ordine inverso). Poi legge la lista fino a trovare un carattere NUL (0). Tutti i bytes prima del carattere NUL costituiscono il codice sorgente. Infine salva il file.

(define (get-code exe lsp)
    (setq codici '())
    (setq code '())
    ;; open newlisp exe file
    (setq infile (open exe "read"))
    ; put bytes on list "codici"
    ; in reverse order
    (while (setq byte (read-char infile))
      (push byte codici)
    )
    (close infile)
    (setq stop nil)
    ; search for source code in list "codici"
    ; stop when find byte 0 (NUL)
    ; else put bytes of source code on list "code"
    (dolist (ch codici stop)
      (if (!= ch 0)
          (push ch code)
          (setq stop true)
      )
    )
    ; save source file from list "code"
    (setq outfile (open lsp "write"))
    (dolist (ch code)
      (write-char outfile ch)
    )
    (close outfile)
    "end")

(get-code "uppercase.exe" "codice.lsp")
;-> "end"

Il file codice.lsp contiene il seguente programma:

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)


--------------------------------------------------------------
Algoritmo Boyer Moore (Voto di maggioranza - Majority element)
--------------------------------------------------------------

L'algoritmo di voto di Boyer Moore viene utilizzato per trovare l'elemento più frequente che compare più di N/2 volte (dove N è il numero di elementi) in una lista o vettore. Questo algoritmo ha complessità temporale lineare e complessità spaziale costante.
Per esempio:

Input: (1 5 5 5 5 4 6)
Output: 5
Spiegazione: 5 è l'elemento di maggioranza in quanto compare 4 volte, cioè più di 7/2 o 3 volte.

Input: (1 3 5 7 9)
Output: -1
Explanation: non esiste alcun elemento di maggioranza.

Esistono diversi approcci per risolvere questo problema:

- Il metodo della forza bruta per risolvere questo problema può utilizzare cicli for annidati e contare per ogni elemento se appare n/2 volte. Ma non è un approccio efficiente in quanto richiede tempo O(n^2).

- Un altro approccio può essere quello di utilizzare le hash-map, ovvero memorizzare il conteggio di ciascun elemento nella mappa hash e quindi attraversarla per verificare se e quale elemento ha conteggio > n/2. Questo metodo ha complessità temporale O(n) e complessità spaziale O(n).

- Utilizzare l'algoritmo di Boyer Moore che ha complessità temporale O(n) e complessità spaziale O(1).

L'algoritmo di Boyer Moore in senso elementare trova un elemento maggioritario, se esiste. L'elemento di maggioranza è un elemento che si verifica ripetutamente per più della metà degli elementi dati. Tuttavia, se non esiste un elemento di maggioranza, l'algoritmo non è in grado di rilevarlo e restituisce comunque uno degli elementi.

Fondamentalmente l'algoritmo funziona in due parti. Il primo passaggio trova un elemento come elemento di maggioranza e un secondo passaggio viene utilizzato per verificare che l'elemento trovato nel primo passaggio sia realmente quello di maggioranza.
Se l'elemento di maggioranza non esiste, l'algoritmo non lo rileverà e quindi restituirà un elemento arbitrario.

L'algorimo si divide in due passi logici:

1) trovare l'elemento che potrebbe essere un elemento maggioritario.

2) controllare che il conteggio dell'elemento trovato nel primo passaggio sia maggiore di n/2.

Abbiamo bisogno di una variabile per tenere traccia dell'elemento corrente e di un contatore. Inizialmente il contatore viene posto o zero. Quindi iteriamo sugli elementi della sequenza. Durante l'elaborazione di un elemento x, se il contatore è zero, l'algoritmo memorizza x come elemento di sequenza ricordato e imposta il contatore su uno. In caso contrario, confronta x con l'elemento memorizzato. Se l'elemento è lo stesso, incrementiamo il contatore e se l'elemento non è lo stesso, diminuiamo il contatore. Alla fine, se l'elemento di maggioranza esiste, sarà l'elemento memorizzato dall'algoritmo.

I passaggi dell'algoritmo di Boyer Moore sono:

Primo passaggio: trovare un candidato con la maggioranza
- Inizializzare una variabile m e un contatore a 0
- Per ogni elemento x della lista di input:
- Se il contatore è uguale a zero, assegniamo m = x e contatore = 1
- altrimenti se m è uguale a x, incrementiamo il contatore.
- altrimenti decrementiamo il contatore.
- Infine restituire l'elemento memorizzato m.

Secondo passaggio: verificare se il candidato ha più di n/2 voti
- Inizializzare una variabile contatore a zero.
- Ciclo sulla sequenza di elementi e incrementa il contatore se l'elemento corrente è lo stesso del candidato.
- Se il contatore è maggiore di n/2, restituisce il candidato, altrimenti restituisce -1.

Cerchiamo di analizzare il metodo attraverso un esempio:

lista di elementi = (5 3 3 5 5 1 5).

Primo passaggio:
       _
lista=(5 3 3 5 5 1 5)
i=0, m=5
contatore=1
         _
lista=(5 3 3 5 5 1 5)
i=1, x=3, m=5
contatore=0 (l'elemento corrente non è lo stesso, contatore=contatore-1)
           _
lista=(5 3 3 5 5 1 5)
i=2, x=3, m=3
contatore=1 (contatore era 0 quindi, m = x)
             _
lista=(5 3 3 5 5 1 5)
i=3, x=5, m=3
contatore=0 (l'elemento corrente non è lo stesso, contatore=contatore-1)
               _
lista=(5 3 3 5 5 1 5)
i=4 x=5, m=5
contatore=1 (contatore era 0 quindi, m = x)
                 _
lista=(5 3 3 5 5 1 5)
i=5, x=1, m=5,
contatore=0 (l'elemento corrente non è lo stesso, contatore=contatore-1)
                   _
lista=(5 3 3 5 5 1 5)
i=6, x=5, m=5
contatore=1 (contatore era 0 quindi, m = x)

Adesso abbiamo il candidato m=5.

Secondo passaggio:

contatore=0;
i=0, x=5
contatore=1, (contatore++ come m = x)
i=1, x=3
contatore=1, (m != x)
i=2, x=3
contatore=1, (m != x)
i=3, x=5
contatore=2, (contatore++ come m = x)
i=4, x=5
contatore=3, (contatore++ come m = x)
i=5, x=1
contatore=3, (m != x)
i=6, x=5
contatore=4, (contatore++ come m = x)

contatore=4 è maggiore di 7/2=3, quindi m=5 è l'elemento di maggioranza.

Vediamo l'implementazione:

(define (boyer-moore lst)
  (local (m contatore n)
    (setq n (length lst))
    (setq contatore 0)
    ; prima parte: trova candidato
    (for (i 0 (- n 1))
      (cond ((zero? contatore)
             (setq m (lst i))
             (setq contatore 1)
            )
            ((= m (lst i))
             (++ contatore)
            )
            (true (-- contatore))
      )
    )
    ;(println "candidato = " m)
    ; seconda parte: verifica candidato
    (if (> (first (count (list m) lst)) (/ n 2))
        m
        nil
    )))

(boyer-moore '(5 3 3 5 5 1 5))
;-> 5

(boyer-moore '(5 3 3 5 5 3))
;-> nil

(boyer-moore '(5 3 3 5 5 3 3 3 5 3 4 3 3 3 4))
;-> 3


---------------------------
Convertire 0 in N (+1 o *2)
---------------------------

Il problema consiste nel convertire 0 nel numero N, aggiungendo 1 o moltiplicando per 2, con il numero minimo di passi. Inoltre tutte le operazioni devono produrre un numero intero.

Esempio:
N = 6

0 + 1 = 1
1 * 2 = 2
2 + 1 = 3
3 * 2 = 6

Consideriamo il problema al contrario, cioè partiamo da N e arriviamo a 0. Poichè dobbiamo sempre ottenere un numero intero con l'operazione che applichiamo (- o /) abbiamo due casi:
1) se il numero è dispari allora dobbiamo diminuirlo di 1 ottenendo un numero pari.
2) se il numero è pari allora dobbiamo dividerlo per 2 (questo perchè dobbiamo rendere minimo il numero di passi) ottenendo un numero dispari.
Infine ci fermiamo quando il numero vale 0.
Naturalmente il numero di sottrazioni e divisioni per passare da N a 0 sono uguali rispettivamente al numero di addizioni e moltiplicazioni necessarie per passare da 0 a N.

(define (dazero num)
  (local (n-add n-mul)
    (set 'n-add 0 'n-mul 0)
    (while (> num 0)
      (cond ((odd? num)
             (-- num)
             (++ n-add)
            )
            (true ; numero pari
             (setq num (/ num 2))
             (++ n-mul)
            )
      )
    )
    (list n-add n-mul (+ n-add n-mul))))

(dazero 0)
;-> (0 0 0)
(dazero 1)
;-> (1 0 1)
(dazero 2)
;-> (1 1 2)
(dazero 3)
;-> (2 1 3)
(dazero 4)
;-> (1 2 3)
(dazero 6)
;-> (2 2 4)
(dazero 1023)
;-> (10 9 19)
(dazero 1024)
;-> (1 10 11)
(dazero 1025)
;-> (2 10 12)

Per velocizzare un pò la funzione possiamo togliere l'espressione (-- num) e dividere sempre il numero per due (perchè è una divisione intera e quindi (n+1)/2 = (n/2)). Inoltre possiamo utilizzare lo shift a destra ">>" per la divisione.

(define (da-zero num)
  (let ((n-add 0) (n-mul 0))
    (while (> num 0)
      (if (odd? num)
          (++ n-add)
      )
      (++ n-mul)
      (setq num (>> num))
    )
    (-- n-mul)
    (list n-add n-mul (+ n-add n-mul))))

(da-zero 6)
;-> (2 2 4)
(da-zero 1023)
;-> (10 9 19)
(da-zero 1024)
;-> (1 10 11)
(da-zero 1025)
;-> (2 10 12)

Il numero minimo di passi per passare da 0 a N sommando 1 o moltiplicando per 2 è una sequenza OEIS:

Sequenza OEIS A056792:
  0, 1, 2, 3, 3, 4, 4, 5, 4, 5, 5, 6, 5, 6, 6, 7, 5, 6, 6, 7, 6, 7, 7,
  8, 6, 7, 7, 8, 7, 8, 8, 9, 6, 7, 7, 8, 7, 8, 8, 9, 7, 8, 8, 9, 8, 9,
  9, 10, 7, 8, 8, 9, 8, 9, 9, 10, 8, 9, 9, 10, 9, 10, 10, 11, 7, 8, 8,
  9, 8, 9, 9, 10, 8, 9, 9, 10, 9, 10, 10, 11, 8, 9, 9, 10, 9, 10, 10, ...

(define (A056792 num)
  (if (zero? num) 0
  (let ((n-add 0) (n-mul 0))
    (while (> num 0)
      (if (odd? num)
          (++ n-add)
      )
      (++ n-mul)
      (setq num (>> num))
    )
    (-- n-mul)
    (+ n-add n-mul))))

(map A056792 (sequence 0 50))
;-> (0 1 2 3 3 4 4 5 4 5 5 6 5 6 6 7 5 6 6 7 6 7 7
;->  8 6 7 7 8 7 8 8 9 6 7 7 8 7 8 8 9 7 8 8 9 8 9
;->  9 10 7 8 8)


----------------------------
Funzione "substring" di Java
----------------------------

In Java il metodo substring(int beginIndex, int endIndex) della classe String restituisce una nuova stringa che è una sottostringa di questa stringa. La sottostringa inizia dall'indice beginIndex e si estende fino al carattere con l'indice (endIndex - 1). Pertanto, la lunghezza della sottostringa è (endIndex - beginIndex).

Per simulare la funzione "substring" utilizziamo la funzione "slice" di newLISP.

(setq str "zippo")

(define (substring str start end)
  (if (= end nil) (setq end (length str)))
  (cond ((= str "") "")
        ((>= start (length str)) "")
        ((>= start end) "")
        (true
         (slice str start (+ start end)))))

Vediamo alcuni esempi:

(substring "zippo" 0 1)
;-> "z"
(substring "zippo" 0)
;-> "zippo"
(substring "zippo" 5)
;-> ""
(substring "zippo" 6)
;-> ""
(substring "zippo" 2)
;-> "ppo"
(substring "zippo" 0 0)
;-> ""
(substring "zippo" 1 1)
;-> ""
(substring "zippo" 1 3)
;-> "ipo"
(substring "zippo" 4 5)
;-> "o"

(for (i 1 (length str)) (println (substring str 0 i)))
;-> z
;-> zi
;-> zip
;-> zipp
;-> zippo

Nota: la funzione Java "substring" restituisce un errore se gli indici non sono corretti.


---------------------------------------
Clojure-style Tail Recursion in newLISP
---------------------------------------

Questo è un post di rickyboy su forum di newLISP (riportato integralmente in inglese).

rickyboy:
*********
Today, I just read an old blog post by Mike Ivanov where he explains how he implemented Clojure-style (loop/recur) tail recursion in Emacs Lisp. My first thought was, "Hey, that's cool!" My second thought was, "Hey, I think we can do this in newLISP too!" :)

Nota: il post di Mike Ivanov viene riportato al termin di questo articolo.

So, just for fun, here is my newLISP port of Mike's implementation.

[EDIT: I updated the code in the following block after my original posting to fix a bug. The details of the bug (error) are described in a  reply of mine further down in this discussion.]

(constant '[loop/recur-marker] '[loop/recur-marker])

(define (loop- BODY-FN)
  (let (.args (args) .res nil)
    (while (begin
             (setq .res (apply BODY-FN .args))
             (when (and (list? .res) (not (empty? .res))
                        (= [loop/recur-marker] (first .res)))
               (setq .args (rest .res)))))
    .res))

(define (recur) (cons [loop/recur-marker] (args)))

(define (flat-shallow-pairs LIST)
  (let (i 0 acc '())
    (dolist (e LIST)
      (cond ((even? i) ; Indicator i is even = abscissa
             (cond ((and (list? e) (not (empty? e)))
                    (extend acc (0 2 (push nil e -1))))
                   ((symbol? e)
                    (push e acc -1)
                    (inc i))))
            ((odd? i) ; Indicator i is odd = ordinate
             (push e acc -1)
             (inc i))))
    acc))

(define (parms<-bindings BINDINGS)
  (map first (explode (flat-shallow-pairs BINDINGS) 2)))

(define-macro (loop INIT)
  (letn (.parms (parms<-bindings INIT)
         .body-fn (letex ([body] (args)
                          [parms] .parms)
                    (append '(fn [parms]) '[body]))
         .loop-call (letex ([body-fn] .body-fn
                            [parms] .parms)
                      (append '(loop- [body-fn]) '[parms])))
    (letex ([init] INIT [loop-call] .loop-call)
      (letn [init] [loop-call]))))

You can't use Mike's (Emacs Lisp) applications examples verbatim, but here they are in newLISP.

(define (factorial x)
  (loop (x x acc 1)
    (if (< x 1)
        acc
        (recur (- x 1) (* x acc)))))

(define (fibo x)
  (loop (x x curr 0 next 1)
    (if (= x 0)
        curr
        (recur (- x 1) next (+ curr next)))))

They work like a charm!

(factorial 10)
;-> 3628800
(fibo 10)
;-> 55

Please let me know if you spot an error or if it can be accomplished better in any way. Thanks and happy hacking! :)
(λx. x x) (λx. x x)

rickyboy:
*********
There was an error in my first implementation of the loop macro in extracting the "variables" associated with the loop bindings. I changed this in the first post (above), in case any reader gets it and doesn't make it this far into the discussion.

newLISP Let Bindings
--------------------
Before we get into describing the error, I should give some context.

newLISP does something very cool with let bindings. In newLISP, you can code the let bindings as a list of pairs -- as it is done in Common Lisp or Scheme, for example -- as in the following.

> (let ((x 1) (y 2) (z 3)) (list x y z))
(1 2 3)

Alternatively, newLISP allows you to drop the pair parentheses in the let bindings, or to mix and match.

> (let (x 1 y 2 z 3) (list x y z))
(1 2 3)
> (let (x 1 (y 2) z 3) (list x y z))
(1 2 3)
Also, note how the following bindings are equivalent.

> (let (x 1 (y) z 3) (list x y z))
(1 nil 3)
> (let (x 1 (y nil) z 3) (list x y z))
(1 nil 3)

The Error
---------
So now on to how the error was introduced. I knew my code needed to build a list of "parameters" from the bindings provided by the user (caller) of loop. These parameters are a list of all the variables in the loop bindings, and the loop macro was going to use these in building its call to loop-. This list is the second argument to loop-, by the way.

I had thought that the users of loop would naturally need to express the loop bindings in the same way that they express any let bindings that they ever code. So, in building that list of parameters, I had to be mindful of the different ways that let bindings can be expressed in newLISP (as we covered above).

The error is contained in the following (original and erroneous) definition of loop. You might be able to spot it right away.

(define-macro (loop INIT)
  (letn (.parms (map first (explode (flat INIT) 2))
         .body-fn (letex ([body] (args)
                          [parms] .parms)
                    (append '(fn [parms]) '[body]))
         .loop-call (letex ([body-fn] .body-fn
                            [parms] .parms)
                      (append '(loop- [body-fn]) '[parms])))
    (letex ([init] INIT [loop-call] .loop-call)
      (letn [init] [loop-call]))))

Specifically the error is in the way the parameters, .parms, are getting computed by the expression (map first (explode (flat INIT) 2)). The problem is that flat flattens the list "too deeply" for our use.

For instance, the first usage is OK, but the second breaks.

> (let (INIT '(x 1 y 2 z 3)) (map first (explode (flat INIT) 2)))
(x y z)
> (let (INIT '(x 1 y (+ 40 2) z 3)) (map first (explode (flat INIT) 2)))
(x y 40 z)

Oops, look at the second usage above: 40 is not supposed to be a parameter. The second usage breaks because flat is "too eager" or "too deep." Let's look at what flat does to the bindings from the second usage above.

> (let (INIT '(x 1 y (+ 40 2) z 3)) (flat INIT))
(x 1 y + 40 2 z 3)

Yeah, that's not what we want. What we need, however, is a "shallower" version of flat.

The following function flat-shallow-pairs attempts to do just that. It will flatten a list, making "flat pairs" along the way, but will respect the pairs that are explicitly expressed with parentheses.

(define (flat-shallow-pairs LIST)
  (let (i 0 acc '())
    (dolist (e LIST)
      (cond ((even? i) ; Indicator i is even = abscissa
             (cond ((and (list? e) (not (empty? e)))
                    (extend acc (0 2 (push nil e -1))))
                   ((symbol? e)
                    (push e acc -1)
                    (inc i))))
            ((odd? i) ; Indicator i is odd = ordinate
             (push e acc -1)
             (inc i))))
    acc))

Here it is in action on the (formerly problematic) second usage and beyond.

> (let (INIT '(x 1 y (+ 40 2) z 3)) (flat-shallow-pairs INIT))
(x 1 y (+ 40 2) z 3)
> (let (INIT '((x 1) y (+ 40 2) z 3)) (flat-shallow-pairs INIT))
(x 1 y (+ 40 2) z 3)
> (let (INIT '((x 1) y (+ 40 2) z (lambda (x) (flat x)))) (flat-shallow-pairs INIT))
(x 1 y (+ 40 2) z (lambda (x) (flat x)))

Now, we just replace flat with flat-shallow-pairs in the expression (map first (explode (flat INIT) 2)), but we'll roll that expression into a function called parms<-bindings.

(define (parms<-bindings BINDINGS)
  (map first (explode (flat-shallow-pairs BINDINGS) 2)))

Let's look at the old and new computation, side-by-side.

> (let (INIT '(x 1 y (+ 40 2) z 3)) (map first (explode (flat INIT) 2)))
(x y 40 z)
> (let (INIT '(x 1 y (+ 40 2) z 3)) (parms<-bindings INIT))
(x y z)

So, the new definition of loop is now the following.

(define-macro (loop INIT)
  (letn (.parms (parms<-bindings INIT)
         .body-fn (letex ([body] (args)
                          [parms] .parms)
                    (append '(fn [parms]) '[body]))
         .loop-call (letex ([body-fn] .body-fn
                            [parms] .parms)
                      (append '(loop- [body-fn]) '[parms])))
    (letex ([init] INIT [loop-call] .loop-call)
      (letn [init] [loop-call]))))

As before, please let me know about any errors or if things can be accomplished better. Thanks!
(λx. x x) (λx. x x)

Lutz:
This for rickyboy:

(flat '(a b (c d (e f)) (g h (i j))) )   → (a b c d e f g h i j)

(flat '(a b (c d (e f)) (g h (i j))) 1)  → (a b c d (e f) g h (i j))

(flat '(a b (c d (e f)) (g h (i j))) 2)  → (a b c d e f g h i j)

new optional parameter for recursion level in flat

Tail recursion without TCO by Mike Ivanov
-----------------------------------------

https://www.mikeivanov.com/post/44952159596/tail-recursion-without-tco

Emacs lisp has no Tail Call Optimization (TCO), neither do many other lisp dialects. The lack of TCO is not a big deal–it's always possible to transform a tail recursive algorithm into a loop. However, it makes functions look uglier. Here is a very simple method of enabling Clojure-style tail call recursion in Emacs lisp:

;; A very simple linearized Y combinator.
;; All the state management stuff is incapsulated here.
;; Don't call it directly.
(defun rloop- (body &rest args)
  (let ((res nil))
    (while (progn
             ;; here's the idea: we keep calling body
             ;; while it returns the recursion marker
             (setq res (apply body args))
             (when (and (consp res)
                        (eq :loop-recur-marker (car res)))
               (progn (setq args (cdr res))
                      t))))
    res))

;; Recursion marker factory
(defun recur (&rest args)
  ;; instead of a real recursive call,
  ;; just signal an intention to make one
  (cons :loop-recur-marker args))

;; The form macro
(defmacro rloop (init body)
  (let ((args (mapcar 'car init)))
    ;; a little courtesy to the macro users
    `(let* ,init
       ;; make a lambda from the body and pass it
       ;; to the combinator function
       (rloop- (function (lambda (,@args) ,body))
               ,@args))))

Here's how to use it:

(defun factorial (x)
  ;; this is the recursion entry point
  (rloop ((x   x)
          (acc 1))
         (if (< x 1)
             acc ;; done, just return the result
           ;; not done, start the whole rloop block again
           (recur (1- x)
                  (* x acc)))))

ELISP> (factorial 10)
3628800

The funny part is defun is not necessary. You can have as many sequential inlined rloops as you want. I like this approach: all the state management stuff is off the sight. The function code is almost identical to the underlying algorithm. Another classic example:

(defun fibo (x)
  (rloop ((x    x)
          (curr 0)
          (next 1))
         (if (= x 0)
             curr
           (recur (1- x)
                   next
                  (+ curr next)))))

ELISP> (fibo 10)
55

Nice, eh? Of course, this kind of beauty comes with a price. Here is how the rloop macro expands:

ELISP> (macroexpand '(rloop ((n 0)) (if (> n 5) n (recur (1+ n)))))

(let*
    ((n 0))
  (rloop-
   #'(lambda
       (n)
       (if
           (> n 5)
           n
         (recur
          (1+ n))))
   n))

...which means two extra function calls on each iteration. But realistically, it's not such a big deal. Clarity of the code is way more important.


------------------------
Sviluppo di una funzione
------------------------

Vogliamo scrivere una funzione che estrae una sottostringa da una stringa.
Prima di tutto defininiamo il nome e i parametri della funzione:

  (substring str start end)

Adesso dobbiamo descrivere come agisce la funzione:

 La funzione "substring" prende una stringa ed estrae i caratteri da "start" a (end - 1).

Perchè arriviamo fino a (end - 1) e non a "end" ?
Perchè in questo modo possiamo passare ad "end" la lunghezza della stringa per estrarre tutti i caratteri da "start" fino alla fine della stringa.

Scriviamo il primo prototipo della funzione (commentando fin da ora il codice):

(define (substring1 str start end)
  (let (out "") ; risultato della funzione
    ; per ogni carattere da start a (end -1)
    (for (i start (- end 1))
      ;aggiunge il carattere corrente al risultato
      (extend out (str i))
    )
    out))

Adesso proviamo la funzione:

(setq str "zippo")

(substring1 str 0 1)
;-> "z"
(substring1 str 3 4)
;-> "p"
(substring1 str 2 4)
;-> "pp"
(substring1 str 0 (length str))
;-> "zippo"

Sembra corretta, ma se proviamo a passare due indici uguali non otteniamo il risultato voluto (""):

(substring1 str 0 0)
;-> "zo"

Otteniamo "zo" perchè l'indice del ciclo "for" vale 0, che è il carattere "z", e -1, che è il carattere "o" (perchè per newLISP l'indice -1 è l'ultimo carattere della stringa).

Anche quando risulta (start > end) otteniamo strani risultati:

(substring1 str 2 0)
;-> "pizo"
(substring1 str 3 0)
;-> "ppizo"
(substring1 str 3 1)
;-> "ppiz"
(substring1 str 4 1)
;-> "oppiz" ; inversione della stringa

Anche in questi casi il risultato è dovuto al comportamento della funzione "for". Supponendo che la nostra funzione non debba produrre questi risultati di difficile interpretazione, dobbiamo decidere come devono essere trattati i "casi particolari" (cercando di trovarli tutti).

Caso 1 - Indici uguali (start = end)
Output: Il risultato deve essere la stringa vuota

Caso 2 - Indici negativi (start < 0) o (end < 0)
Output: Il risultato deve essere la stringa vuota

Caso 3 - Indici non ordinati (start < end)
Output: Il risultato deve essere la stringa vuota

Nota: la scelta di restituire la stringa vuota per i casi particolari potrebbe essere diversa, ad esempio avremmo potuto scegliere di restituire nil o un codice di errore. Questo dipende dal contesto in cui verrà utilizzata la funzione.

Scriviamo il secondo prototipo:

(define (substring2 str start end)
  (let (out "") ; risultato della funzione
    (cond ((= end start) (setq out "")) ; casi particolari
          ((< end start) (setq out "")) ; casi particolari
          ((< start 0) (setq out ""))   ; casi particolari
          ((< end 0) (setq out ""))     ; casi particolari
          (true
            ; per ogni carattere da start a (end -1)
            (for (i start (- end 1))
              ;aggiunge il carattere corrente al risultato
              (extend out (str i))
            )))
    out))

E proviamo la funzione:

(substring2 str 0 1)
;-> "z"
(substring2 str 3 4)
;-> "p"
(substring2 str 2 4)
;-> "pp"
(substring2 str 0 (length str))
;-> "zippo"
(substring2 str 0 0)
;-> ""
(substring2 str 2 0)
;-> ""
(substring2 str 3 0)
;-> ""
(substring2 str 3 1)
;-> ""
(substring2 str 4 1)
;-> ""

Tutto a posto... quasi. Abbiamo controllato che il valore degli indici sia corretto, ma se passiamo alla funzione una stringa vuota otteniamo un errore:

(substring2 "" 1 2)
;-> ERR: invalid string index in function extend
;-> called from user function (substring2 "" 1 2)

Quindi dobbiamo aggiungere alla funzione anche questo caso particolare:

Caso 4 - Stringa nulla (str = "")

Scriviamo il terzo prototipo:

(define (substring3 str start end)
  (let (out "") ; risultato della funzione
    (cond ((= end start) (setq out "")) ; casi particolari
          ((< end start) (setq out "")) ; casi particolari
          ((< start 0) (setq out ""))   ; casi particolari
          ((< end 0) (setq out ""))     ; casi particolari
          ((= str "") (setq out ""))    ; casi particolari
          (true
            ; per ogni carattere da start a (end -1)
            (for (i start (- end 1))
              ;aggiunge il carattere corrente al risultato
              (extend out (str i))
            )))
    out))

Proviamo (solo questo ultimo caso particolare):

(substring3 "" 1 2)
;-> ""

Bene, abbiamo considerato i casi in cui i valori dei parametri assumono dei valori limite. Adesso possiamo considerare anche i casi in cui i parametri non sono del tipo giusto (ed esempio passimo un numero come stringa o passimo una stringa come indice). Comunque dobbiamo fare una piccola riflessione e porci alcune domnande:

1) chi userà la funzione?
Se la funzione viene utilizzata solo da noi, allora possiamo fare a meno di "proteggere" tutti gli input errati (anche se io credo che sia meglio "prevedere" il più possibile), altrimenti dobbiamo considerare un eventuale utilizzo errato della funzione da parte di altri programmatori.

2) quanto deve essere veloce la funzione?
Se la funzione ha limiti di tempo, allora occore cercare di renderla il più efficiente possibile a scapito di ogni controllo: la funzione si comporta correttamente solo se i parametri sono corretti.

Chiaramente è anche possibile definire una soluzione che soddisfa in parte entrambe le esigenze.

Per adesso consideriamo che la funzione debba essere disponibile per tutti, quindi consideriamo i casi particolari dovuti al tipo errato dei parametri.

Caso 5 - str non è una stringa
Output: Il risultato deve essere nil

Caso 6 - start non è un numero intero
Output: Il risultato deve essere nil

Caso 7 - end non è un numero intero
Output: Il risultato deve essere nil

Nota: la scelta di restituire nil in questi casi è per diversificare dai casi precedenti sugli indici in cui restituiamo la stringa vuota "".

Per il corretto funzionamento i casi particolari sui "tipi" dei parametri devono essere controllati prima dei casi sui "valori" dei parametri.

Scriviamo il quarto prototipo:

(define (substring4 str start end)
  (let (out "") ; risultato della funzione
          ; controlli sui tipi dei parametri
    (cond ((not (string? str)) (setq out nil))
          ((not (integer? start)) (setq out nil))
          ((not (integer? end)) (setq out nil))
          ; controlli sui valori dei parametri
          ((= end start) (setq out "")) ; casi particolari
          ((< end start) (setq out "")) ; casi particolari
          ((< start 0) (setq out ""))   ; casi particolari
          ((< end 0) (setq out ""))     ; casi particolari
          ((= str "") (setq out ""))    ; casi particolari
          (true
            ; per ogni carattere da start a (end -1)
            (for (i start (- end 1))
              ;aggiunge il carattere corrente al risultato
              (extend out (str i))
            )))
    out))

Proviamo (solo i casi che controllano i tipi dei parametri):

(substring4 1 2 4)
;-> nil
(substring4 "newlisp" "1" 4)
;-> nil
(substring4 "newlisp" 1 4.1)
;-> nil

Abbiamo finito a scrivere la nostra funzione "substring" che controlla la correttezza di tutti i parametri (speriamo) prima di effettuare l'estrazione della sottostringa.

Adesso scriviamo una funzione che risolve il problema nel modo più veloce possibile (quindi senza alcun controllo sui parametri). Invece di utilizzare il ciclo "for" utilizziamo la funzione "slice" di newLISP.

sintassi: (slice str int-index [int-length])
"slice" estrae una parte della stringa in str. int-index contiene l'indice iniziale e int-length contiene la lunghezza della sottostringa. Se int-length non viene specificato, viene estratto tutto fino alla fine della stringa.

Esempi:

(slice "Hello World" 6 2)
;-> "Wo"
(slice "Hello World" 0 5)
;-> "Hello"
(slice "Hello World" 6)
;-> "World"
(slice "newLISP" -4 2)
;-> "LI"

Scriviamo la funzione veloce:

(define (substring5 str start end)
    (slice str start (- end start)))

Proviamo questa funzione con tutti gli input precedenti:

(setq str "zippo")

(substring5 str 0 1)
;-> "z"
(substring5 str 3 4)
;-> "p"
(substring5 str 2 4)
;-> "pp"
(substring5 str 0 (length str))
;-> "zippo"

(substring5 str 0 0)
;-> ""
(substring5 str 2 0)
;-> "p"
(substring5 str 3 0)
;-> ""
(substring5 str 3 1)
;-> ""
(substring5 str 4 1)
;-> ""
(substring5 "" 1 2)
;-> ""

(substring5 1 2 4)
;-> ERR: list or string expected : (- end start)
;-> called from user function (substring5 1 2 4)
(substring5 "newlisp" "1" 4)
;-> ERR: value expected in function slice : start
;-> called from user function (substring5 "newlisp" "1" 4)
(substring5 "newlisp" 1 4.1)
;-> "ewl"

Vediamo i tempi di esecuzione di "substring4" e "substring5":

(time (substring4 "supercalifragilistichespiralidoso" 10 31) 100000)
;-> 576.981
(time (substring5 "supercalifragilistichespiralidoso" 10 31) 100000)
;-> 25.815

Possiamo terminare lo sviluppo se una delle due funzioni soddisfa le nostre esigenze, altrimenti potremmo scrivere una nuova funzione utilizzando alcuni (o tutti) i controlli e il metodo "slice". Supponendo di essere soddisfatti dobbiamo terminare il lavoro scrivendo un documento fondamentale: la documentazione della funzione (che sarà leggermente differente in base alla funzione che scegliamo "substring4" o "substring5" o altro).


-------------------
Closures (chiusure)
-------------------

Qual è la differenza tra le chiusure in newLISP e le chiusure in Lisp/Scheme?
Leggendo l'articolo http://lispy.wordpress.com/2007/10/25/what-you-dont-know-about-closures-can-hurt-you/ sembra che una chiusura sia solo una procedura con stato.

Il "classico esempio" dell'accumulatore integrato in una funzione menzionato nell'articolo è apparso anche su questo forum:

(context 'gen)

(define (foo)
    (if (number? acc)
        (inc 'acc)
        (set 'acc 0)))

(context MAIN)

(gen:foo)
;-> 0
(gen:foo)
;-> 1
(gen:foo)
;-> 2
(gen:foo)
;-> 3

Anche se questa sembra una procedura con lo stato, Lutz ha detto che le "chiusure di contesto" di newLISP non sono chiusure.
Quindi qual è la differenza tra le "chiusure" di newLISP e le chiusure di Lisp/Scheme?

Le chiusure sono una caratteristica dell'ambito lessicale e della definizione di funzioni dinamiche. Ad esempio, se crei un lambda all'interno di un'altra funzione, le variabili che si trovano nell'ambito esterno devono essere conservate per quel lambda. Quando quel lambda viene successivamente chiamato, quelle variabili che sarebbero state disponibili all'interno dell'ambito in cui è stato definito vengono quindi attivate nell'ambito della chiamata corrente.

newLisp ha un ambito dinamico. Ogni volta che viene chiamata una funzione, viene chiamata nell'ambito corrente, non nell'ambito in cui è stata definita.

newLisp ha tuttavia contesti che sono spazi dei nomi lessicali che possono simulare chiusure. Puoi farlo con un funtore (una funzione con lo stesso nome del suo contesto come foo:foo). Il contesto conserva i simboli nell'ambito del funtore e sono disponibili quando la funzione viene chiamata in un secondo momento, indipendentemente da dove viene chiamata.

Tuttavia, la grande differenza è che all'interno di un contesto si applicano ancora le regole di ambito dinamico. Non è un ambito lessicale. È uno spazio dei nomi definito dal punto di vista lessicale parallelo all'ambito dinamico MAIN. Così:

(setq foo:x "Hello world")
(define (foo:foo) (lambda () (println x)))
(setq x "Hello Corm")
(setq my-foo (foo:foo))
(my-foo)
;-> Hello Corm
(define (foo:foo) (lambda () (let (x "go") (println x))))
(my-foo)
;-> Hello Corm
(context foo)
(symbols)
(foo:foo x)
(setq a 10)
x
;-> "Hello world"
(my-foo)
;-> ERR: invalid function : (my-foo)

In Scheme funzionerebbe in questo modo:

(define foo
  (lambda ()
    (let ((x "Hello world"))
      (lambda () (print x)))))

(define my-foo (foo))
(define x "Hello Corm")
(my-foo) ; => prints "Hello world"

Giusto - quindi la descrizione dell'articolo della chiusura come solo "una procedura con lo stato" non è l'intera storia...
Beh, è una procedura con lo stato, ma questo non spiega come viene mantenuto quello stato.


-------------------------------------------
Il concetto di base dei contesti in newLISP
-------------------------------------------

Il contesto è equivalente allo spazio dei nomi di altri linguaggi, ma dopo tutto è un lisp, quindi il contesto è anche un simbolo, che può essere copiato, può essere passato come parametro di funzione e può essere assegnato a una variabile.

Ogni contesto ha la sua collezione di simboli.

Il contesto MAIN
----------------
C'è un contesto chiamato MAIN per impostazione predefinita. Ogni volta che viene avviato il processo newlisp, il contesto MAIN verrà creato automaticamente. Tutte le funzioni predefinite e i simboli speciali sono nel contesto MAIN. Utilizzare (symbols) per visualizzare:

(symbols)

(symbol your-context-name) può essere utilizzato per visualizzare i simboli in altri contesti.

Regole per la creazione di simboli nel contesto
-----------------------------------------------
Le seguenti regole aiutano a capire come vengono creati i simboli nel contesto, annotando l'ordine di creazione:

1. newLISP prima analizza e traduce ogni espressione di primo livello. In questa fase verrà creato il simbolo. Dopo che l'espressione è stata tradotta, l'espressione viene valutata.

2. Quando newLISP vede il simbolo per la prima volta, lo creerà, chiamando la funzione load, sym o eval-string. Quando newLISP legge un file di codice sorgente, crea un simbolo prima di valutarlo.

3. Quando si incontra un simbolo sconosciuto durante la traduzione del codice, cercherà la sua definizione nel contesto corrente, se non lo trova, cercherà nel contesto MAIN. Se non riesci ancora a trovarlo, crea questo simbolo nel contesto corrente.

4. Una volta che un simbolo è stato creato e appartiene a un contesto, apparterrà in modo permanente al contesto.

5. Quando una funzione definita dall'utente si trova in un contesto, se la funzione viene chiamata in un altro contesto, il contesto passerà al contesto in cui si trova la funzione.

6. La conversione del contesto riguarda solo la creazione di simboli tramite load, sym o eval-string. Per impostazione predefinita, load crea simboli nel contesto MAIN, a meno che il cambio di contesto non avvenga al di fuori del caricamento del file (non so come usarlo per ora).

Quando si utilizza sym e eval-string, è necessario specificare il contesto.
Il cambio di contesto avverrà solo nella parte più esterna del programma, non in una funzione.

Creare un contesto
------------------
A) Crea e cambia contesto

Si noti l'uso delle virgolette singole, generalmente in maiuscolo, ma le minuscole non saranno sbagliate.

(context 'A)

B) Crea ma non cambia contesto
------------------------------
Basta usare set

(imposta 'ACTX:var "hello")

Qui viene creato un contesto ACTX con un simbolo var con il valore "hello", ma il contesto non viene cambiato.

Notare che il contesto appena creato appare nel contesto MAIN come un simbolo, che può essere visualizzato con (symbols).

Cambiare contesto
-----------------
Nessun uso del carattere ' (quote), come il passaggio a MAIN

(context MAIN)

Usare il simbolo all'interno del contesto
-----------------------------------------
Occore mettere un prefisso ":" al nome del contesto, ad esempio:

A:my-fun(1, 2)

Il funtore o funzione predefinita
---------------------------------
Se una funzione, una macro o un simbolo si trova all'interno di un contesto e ha lo stesso nome del contesto, diventa la funzione predefinita (chiamata anche "funtore"). Possiamo chiamarlo direttamente con il nome del contesto. come:

;; the default function
(define (Foo: Foo abc) (+ abc))

(Foo 1 2 3)
;-> 6

Se vuoi usare la funzione predefinita di un altro contesto in un contesto, devi pre-dichiarare

;; forward declaration of a default function
(define Fubar:Fubar)

(context 'Foo)
(define (Foo: Foo abc)
    ...
    (Fubar ab); forward reference
    (...)); To default function

(context MAIN)

;; definition of previously declared default function
(context 'Fubar)
(define (Fubar: Fubar xy)
    (...))

(context MAIN)

Fare riferimento al manuale per maggiori dettagli, http://www.newlisp.org/downloads/newlisp_manual.html#contexts


-------------------------------------
Numeri palindromi e numeri di Lychrel
-------------------------------------

Generare tutti i numeri palindromi fino ad un determinato numero n.
Un numero palindromo è un numero "simmetrico" come 16461, che rimane lo stesso quando le sue cifre sono invertite (cioè il numero ha lo stesso valore se viene letto al contrario).

I primi numeri palindromi (base decimale) sono:
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 22, 33, 44, 55, 66, 77, 88,
  99, 101, 111, 121, 131, 141, 151, 161, 171, 181, 191, ...

Soluzione brute-force
---------------------
Funzione che verifica se una stringa, una lista o un numero è palindroma:

(define (palindrome? obj)
  (if (integer? obj)
      (let (str (string obj)) (= str (reverse (copy str))))
      (= obj (reverse (copy obj)))))

Funzione che calcola i numeri palindromi fino a n:

(define (find-pali num)
  (local (out)
    (setq out '(0 1 2 3 4 5 6 7 8 9))
    (for (i 11 num)
      (if (palindrome? i)
          (push i out -1)))
    out))

Proviamo la funzione:

(find-pali 200)
;-> (0 1 2 3 4 5 6 7 8 9 11 22 33 44 55 66 77 88
;->  99 101 111 121 131 141 151 161 171 181 191)

Vediamo i tempi di esecuzione:

(time (find-pali 1e6))
;-> 591.671
(time (find-pali 1e7))
;-> 6086.745

Calcoliamo quanti numeri palindromi ci sono con diversi valori di n:

(length (filter (fn(x) (= 7 (length x))) (find-pali 1e7)))
;-> 9000
(length (filter (fn(x) (= 6 (length x))) (find-pali 1e6)))
;-> 900
(length (filter (fn(x) (= 5 (length x))) (find-pali 1e5)))
;-> 900
(length (filter (fn(x) (= 3 (length x))) (find-pali 1e3)))
;-> 90

Soluzione con generazione diretta
---------------------------------
Invece di verificare quali numeri da 0 a n siano palindromi, proviamo a generare direttamente questi numeri.
Prima di tutto scriviamo una funzione che genera tutti i numeri palindromi di una determinata lunghezza. Dividiamo i palindromi in due categorie: quelli con numero pari di cifre e quelli con numero dispari di cifre. Ad esempio, se la lunghezza è 5 (dispari), generiamo numeri palindromi con lo schema "abxba", dove a, b e x sono un numero qualsiasi da 1 a 9 (più x che può essere 0). Se la lunghezza è 4 (pari), lo schema è "abba".

(define (gen-pal-len len)
  (local (out half)
    (setq out '())
    (cond ((< len 1) (setq out '()))
          ((= len 1) (setq out '(0 1 2 3 4 5 6 7 8 9)))
          ((odd? len)
           (setq half (/ (- len 1) 2))
           (for (x 0 9)
              (for (y (pow 10 (- half 1)) (- (pow 10 half) 1))
                (push (int (string y x (reverse (string y)))) out))))
          ((even? len)
           (setq half (/ len 2))
           (for (x (pow 10 (- half 1)) (- (pow 10 half) 1))
                (push (int (string x (reverse (string x)))) out)))
     )
     (sort out)))

Facciamo alcune prove:

(gen-pal-len 0)
;-> ()
(gen-pal-len 1)
;-> (0 1 2 3 4 5 6 7 8 9)
(gen-pal-len 2)
;-> (11 22 33 44 55 66 77 88 99)
(length (gen-pal-len 5))
;-> 900

Adesso possiamo scrivere la funzione che calcola tutti i numeri palindromi in un dato intervallo:

(define (generate-palindrome min-val max-val)
  (local (min-len max-len res)
    (setq res '())
    (setq min-len (length min-val))
    (setq max-len (length max-val))
    (for (ll min-len (+ max-len 1))
      (dolist (el (gen-pal-len ll))
        ; alcuni palindromi non rientrano nell'intervallo
        (if (and (>= el min-val) (<= el max-val))
            (push el res)
        )
      )
    )
    (sort res)))

Facciamo alcune prove:
(generate-palindrome 1 100)
(generate-palindrome 10 100)
;-> (11 22 33 44 55 66 77 88 99)
(generate-palindrome 800 900)
;-> (808 818 828 838 848 858 868 878 888 898)
(length (generate-palindrome 10000 99999))
;-> 900

Nota: la funzione, internamente, calcola qualche palindromo in più di quelli necessari (questo dipende dai valori minimo e massimo dell'intervallo), che poi vengono eliminati dal risultato.

Vediamo i tempi di esecuzione:

(time (generate-palindrome 0 1e6))
;-> 28.054
(time (generate-palindrome 0 1e7))
;-> 133.918

Vediamo se le due funzioni producono gli stessi risultati:

(= (generate-palindrome 0 1e6) (find-pali 1e6))
;-> true
(= (generate-palindrome 0 1e7) (find-pali 1e7))
;-> true

Per curiosità, vediamo se converge la sommatoria degli inversi dei numeri palindromi p:

  ∞
  ∑(1/p) = ?
  p

(define (converge num-palin)
  (local (palin sum)
    (setq palin (generate-palindrome 1 num-palin))
    (setq sum 0)
    (dolist (p palin)
      (setq sum (add sum (div p)))
    )
    sum))

Vediamo se converge:

(converge 1e6)
;-> 3.36746897025007
(converge 1e7)
;-> 3.369771573629799
(converge 1e8)
;-> 3.370001832403638
(converge 1e9)
;-> 3.370232090939355
(converge 1e10)
;-> 3.370255116790679
(converge 1e11)
;-> 3.370278142641684
(converge 1e12)
;-> 3.370280445226788
(converge 1e13)
;-> 3.370282747811378

Quanti sono i numeri palindromi che hanno n cifre?
--------------------------------------------------
Si possono presentare due casi:

1) n è pari
Supponiamo n=6. Il modello di palindromo è "XYZZYX", dove X (1..9), Y (0..9) e Z (0..9).

Poichè a noi interessano solo le prime 3 cifre "XYZ" il problema si riduce e dobbiamo stabilire quanti sono i numeri a 3 cifre (infatti per trovare un numero palindromo basta aggiungere al numero trovato lo stesso numero invertito).

Per la cifra X abbiamo 9  possibilità di scelta (1..9) (poichè un numero non può iniziare con 0).
Per la cifra Y abbiamo 10 possibilità di scelta (0..9).
Per la cifra Z abbiamo 10 possibilità di scelta (0..9).

Quindi in totale abbiamo 9*10*10 = 900 numeri palindromi con 6 cifre.

2) n è dispari
Supponiamo n=5. Il modello di palindromo è "XYZYX", dove X (1..9), Y (0..9) e Z (0..9).

Per la cifra X abbiamo 9  possibilità di scelta (1..9) (poichè un numero non può iniziare con 0).
Per la cifra Y abbiamo 10 possibilità di scelta (0..9).
Per la cifra Z abbiamo 10 possibilità di scelta (0..9).

Quindi in totale abbiamo 9*10*10 = 900 numeri palindromi con 5 cifre.

Adesso possiamo scrivere una funzione che effettua il calcolo:

(define (count-pal len)
  (local (half)
    (if (odd? len)
        (setq half (+ (/ len 2) 1))
        (setq half (/ len 2)))
    (* 9 (pow 10 (- half 1)))))

(count-pal 5)
;-> 900
(count-pal 6)
;-> 900
(count-pal 7)
;-> 9000

Numeri di Lychrel
-----------------
Un numero di Lychrel è un numero naturale che non può formare un palindromo attraverso il processo iterativo di invertire ripetutamente le sue cifre e sommare i numeri risultanti. Questo processo è talvolta chiamato "algoritmo 196" (196-algorithm), dal numero più famoso associato al processo. In base dieci, non è stata ancora dimostrata matematicamente l'esistenza di numeri di Lychrel, ma molti, tra cui 196, sono sospettati per motivi euristici e statistici. Il nome "Lychrel" è stato coniato da Wade Van Landingham come quasi-anagramma di "Cheryl", il nome della sua ragazza.

Algoritmo 196: generare un numero palindromo partendo da un numero n
--------------------------------------------------------------------
Dato un numero n possiamo generare un numero palindromo con la procedura seguente:

1) invertire le cifre del numero n --> rev(n)
2) creare un nuovo numero n sommando n e rev(n) --> n = n + rev(n)
3) se il nuovo numero n è palindromo, allora stop
   altrimenti vai al passo 1

Vediamo alcuni esempi:

n = 8  ==> rev(8) = 8 ==> n + rev(n) = 8 + 8 = 16 (non palindromo)
n = 16 ==> rev(16) = 61 ==> 16 + 61 = 77 (palindromo e stop)

n = 45 ==> rev(45) = 54 ==> 45 + 54 = 99 (palindromo e stop)

Scriviamo la funzione che effettua questo calcolo:

(define (make-pali num)
  (let (conta 1)
    (setq num (+ num (int (reverse (string num)))))
    (until (palindrome? num)
      ;(setq num (string num (reverse (string num))))
      (setq num (+ num (int (reverse (string num)))))
      (++ conta)
      ; check 196
      ;(print num { } conta)
      ;(read-line)
    )
    (list num conta)))

(make-pali 8)
;-> (77 2)
(make-pali 45)
;-> (99 1)
(make-pali 21)
;-> (33 1)
(make-pali 89)
;-> (8813200023188 24)

Il metodo sembra funzionare, ma siamo sicuri che ogni numero scelto produrrà un numero palindromo, oppure esistono numeri che non permettono di creare palindromi? Proviamo per esempio con il numero 196:

(make-pali 196)
;-> 1675 2
;-> 7436 3
;-> 13783 4
;-> 52514 5
;-> 94039 6
;-> 187088 7
;-> ...
;-> -8076639798875541976 37

Vediamo che alla 37-esima iterazione abbiamo un errore perchè abbiamo superato il valore massimo per gli interi a 64 bit e dobbiamo utilizzare i big-integer. Quindi dobbiamo riscrivere la funzione per utilizzare il tipo bigint.
Usiamo le liste al posto delle stringhe per trattare i numeri bigint (in questo modo non dobbiamo preoccuparci del carattere finale "L").

Funzione che converte un intero in una lista di cifre invertite:

(define (int-rev-lst num)
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out -1)
      (setq num (/ num 10))) out))

Funzione che converte una lista di cifre in un intero:

(define (lst-int lst)
  (let (num 0L)
    (dolist (el lst) (setq num (+ el (* num 10))))))

Funzione che genera un numero palindromo partendo da un determinato numero:

(define (make-palindrome num)
  (let (conta 1)
    (setq num (bigint num))
    (setq num (+ num (lst-int (int-rev-lst num))))
    (println num { } conta)
    (until (palindrome? (int-rev-lst num))
      ;(println (int-rev-lst num))
      ;(println (lst-int (int-rev-lst num)))
      (setq num (+ num (lst-int (int-rev-lst num))))
      (++ conta)
      ; check 196
      (print num { } conta)
      (read-line)
    )
    (list num conta)))

Proviamo la funzione:

(make-palindrome 8)
;-> 16L 1
;-> 77L 2
;-> (77L 2)
(make-palindrome 45)
;-> 99L 1
;-> (99L 1)
(make-palindrome 89)
;-> 187L 1
;-> 968L 2
;-> 1837L 3
;-> 9218L 4
;-> 17347L 5
;-> 91718L 6
;-> 173437L 7
;-> 907808L 8
;-> 1716517L 9
;-> 8872688L 10
;-> 17735476L 11
;-> 85189247L 12
;-> 159487405L 13
;-> 664272356L 14
;-> 1317544822L 15
;-> 3602001953L 16
;-> 7193004016L 17
;-> 13297007933L 18
;-> 47267087164L 19
;-> 93445163438L 20
;-> 176881317877L 21
;-> 955594506548L 22
;-> 1801200002107L 23
;-> 8813200023188L 24
;-> (8813200023188L 24)

Adesso vediamo il numero 196:

(make-palindrome 196)
;-> 887L 1
;-> 1675L 2
;-> 7436L 3
;-> 13783L 4
;-> 52514L 5
;-> 94039L 6
;-> ...
;-> 1727771406219778777543062557405118846645642140346636747711515645369345777787911604276737L 199
;-> 9104495467417656552982698022556296323012072552812103235826563197972803556567037646054008L 200
;-> ...

Quando e se terminerà... non si sa. Comunque qualcuno ha raggiunto il miliardo di iterazioni, arrivando a un numero con più di 600 milioni di cifre e ancora non è palindromo.

Sequenza OEIS: A023108 Interi positivi che apparentemente non risultano mai palindromi sotto ripetute applicazioni della funzione A056964(x) = x (x con cifre invertite).

  196, 295, 394, 493, 592, 689, 691, 788, 790, 879, 887, 978, 986,
  1495, 1497, 1585, 1587, 1675, 1677, 1765, 1767, 1855, 1857, 1945,
  1947, 1997, 2494, 2496, 2584, 2586, 2674, 2676, 2764, 2766, 2854,
  2856, 2944, 2946, 2996, 3493, 3495, 3583, 3585, 3673, 3675, ...

Il numero 1.186.060.307.891.929.990, dopo 261 iterazioni giunge ad un palindromo di 119 cifre.

(make-palindrome 1186060307891929990L)
;-> ...
;-> (44562665878976437622437848976653870388884783662598425855963436955852489526638748888307835667984873422673467987856626544L
;->  261)


------------------------------
Numeri primi di Sophie Germain
------------------------------

Un numero primo P viene detto numero primo di Sophie Germain se anche il numero 2P + 1 è primo.
Ad esempio, 41 è un numero di Sophie Germain in quanto 2*41 + 1 = 83 è anch'esso un numero primo.
Si congettura che il numero dei primi di Sophie Germain sia infinito. Finora questa tesi non è stata ancora dimostrata, ma sembra molto verosimile, dato che vengono trovati numeri primi di Sophie Germain sempre più grandi.

Tra 1 e 1000, troviamo 37 numeri di Sophie Germain. Indichiamo in parentesi il corrispondente numero primo 2P + 1.
 2(5), 3(7), 5(11), 11(23), 23(47), 29(59), 41(83), 53(107), 83(167),
 89(179), 113(227), 131(263), 173(347), 179(359), 191(383), 233(467),
 239(479), 251(503), 281(563), 293(587), 359(719), 419(839), 431(863),
 443(887), 491(983), 509(1019), 593(1187), 641(1293), 653(1307), 659(1319),
 683(1367), 719(1439), 743(1487), 761(1523), 809(1619), 911(1823), 953(1907)

Considerando che il numero dei numeri primi tra 1 e 1000 è 168, notiamo che ben il 22% di questi sono numeri di Sophie Germain.
Se però consideriamo i numeri primi fino a 100.000, questa percentuale scende al 12.2%, fino a 10.000.000 all'8.43%, fino a 100.000.000 al 7.34%, fino a 1.000.000.000 al 6.5% e così via.
Tutti i numeri primi di Sophie Germain sono della forma 6N + 5 e così pure i corrispondenti numeri primi 2P +1.

Considerando per esempio il numero primo di Sophie Germain 89 ed il suo corrispondente 179, avremo:

89 = 6*14 + 5 e 179 = 6*29 + 5

Si noti che non è affatto vero il contrario, cioè che un numero primo della forma 6N + 5 sia un numero primo di Sophie Germain.
Per esempio il numero primo 47 = 6*7 + 5 non è un numero di Sophie Germain, in quanto 2*47 + 1 = 95 non è un numero primo (95 = 5*19).

Scriviamo una funzione per calcolare i numeri primi di Sophie-German:

(define (prime? num)
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (sophie-german limit)
  (let (out '())
    (for (i 2 limit)
      (if (and (prime? i) (prime? (+ (* 2 i) 1)))
          (push (list i (+ (* 2 i) 1)) out -1)))
    out))

(sophie-german 1000)
;-> ((2 5) (3 7) (5 11) (11 23) (23 47) (29 59) (41 83) (53 107)
;->  (83 167) (89 179) (113 227) (131 263) (173 347) (179 359)
;->  (191 383) (233 467) (239 479) (251 503) (281 563) (293 587)
;->  (359 719) (419 839) (431 863) (443 887) (491 983) (509 1019)
;->  (593 1187) (641 1283) (653 1307) (659 1319) (683 1367) (719 1439)
;->  (743 1487) (761 1523) (809 1619) (911 1823) (953 1907))


-------------
Il numero 666
-------------

"Qui sta la sapienza. Chi ha intelligenza, calcoli il numero della bestia, perché è un numero d'uomo, e il suo numero è seicentosessantasei." Apocalisse di Giovanni (13,18).
Su questo numero, chiamato "numero della bestia" o "numero dell'Anticristo" o "numero del Demonio", sono stati versati fiumi d'inchiostro e sono stati scritti interi volumi. Vediamo alcune proprietà note di questo numero.

1) La proprietà più evidente è che 666 è la somma dei primi 36 numeri interi consecutivi (si noti che 36 è a sua volta uguale a 6×6):

1+2+3+4+5+6+7+8+9+10+11+12+13+14+15+16+17+18+19+20+21+
22+23+24+25+26+27+28+29+30+31+32+33+34+35+36 = 666

(apply + (sequence 1 36))
;-> 666

2) I numeri che sono la somma dei primi N interi consecutivi, vengono detti "Numeri Triangolari"”: 666 è un numero triangolare esprimibile come somma di due quadrati esatti di due numeri triangolari:

666 = 15² + 21² (infatti 15² + 21² = 225 + 441 = 666)

e sia 15 che 21 sono a loro volta numeri triangolari:

15 = 1 + 2 + 3 + 4 + 5
21 = 1 + 2 + 3 + 4 + 5 + 6

3) Un'altra proprietà è che 666 è uguale anche alla somma delle sue cifre più la somma dei cubi delle sue cifre:

6 + 6 + 6 + 6³ + 6³ + 6³ = 6 + 6 + 6 + (6x6x6) + (6x6x6) + (6x6x6) = 6 + 6 + 6 + 216 + 216 + 216 = 666

4) Altra proprietà:

1³ + 2³ + 3³ + 4³ + 5³ + 6³ + 5³ + 4³ + 3³ + 2³ + 1³ = 666

Infatti:

(1x1x1) + (2x2x2) + (3x3x3) + (4x4x4) + (5x5x5) + (6x6x6) + (5x5x5) + (4x4x4) + (3x3x3) + (2x2x2) + (1x1x1) = 1 + 8 + 27 + 64 + 125 + 216 + 125 + 64 + 27 + 8 + 1 = 666

5) Inoltre 666 è la somma dei quadrati dei primi sette numeri primi:

Infatti:

2² + 3² + 5² + 7² + 11² + 13² + 17² = (2×2) + (3×3) + (5×5) + (7×7) + (11×11) + (13×13) +(17×17) = 4 + 9 + 25 + 49 + 121 + 169 + 289 = 666

6) 666 è costituito dalla tripla ripetizione della cifra 6 che è il più piccolo dei rarissimi numeri perfetti, cioè uguali alla somma dei suoi divisori. Infatti i divisori di 6 sono 1, 2 e 3 e la loro somma fa 6.
Inoltre 6 è la somma dei primi 3 interi consecutivi: 1 + 2 + 3 = 6.

7) Notiamo che, nel sistema di numerazione dell'antica Roma, 666 si scrive DCLXVI che sono le prime 6 cifre romane scritte in rigoroso ordine decrescente.

8) Una ulteriore proprietà è che 666 è la somma delle prime 144 cifre decimali di pi greco (senza contare dunque il 3 a sinistra della virgola), dove 144 = (6+6)x(6+6)

3,141592653589793238462643383279502884197169399375
 105820974944592307816406286208998628034825342117
 067982148086513282306647093844609550582231725359

Verifichiamo:

(apply + '(1 4 1 5 9 2 6 5 3 5 8 9 7 9 3 2 3 8 4 6 2 6 4
          3 3 8 3 2 7 9 5 0 2 8 8 4 1 9 7 1 6 9 3 9 9 3
          7 5 1 0 5 8 2 0 9 7 4 9 4 4 5 9 2 3 0 7 8 1 6
          4 0 6 2 8 6 2 0 8 9 9 8 6 2 8 0 3 4 8 2 5 3 4
          2 1 1 7 0 6 7 9 8 2 1 4 8 0 8 6 5 1 3 2 8 2 3
          0 6 6 4 7 0 9 3 8 4 4 6 0 9 5 5 0 5 8 2 2 3 1
          7 2 5 3 5 9))
;-> 666

9) I fattori primi di 666 sono 2,3,3,37 e 2+3+3+3+7 = 6+6+6

10) Ecco un'altra relazione: (6x6x6)² + (666 – 6×6)² = 666²

Verifichiamola:

666² = 666×666 = 443556

(6x6x6)² + (666 – 6×6)² = 216² + 630² = 46656 + 396900 = 443556

11) Un quadrato magico, formato esclusivamente da numeri primi, nel quale la somma dei numeri di ogni riga, colonna o diagonale lunga è 666:

  +-----+-----+-----+-----+-----+-----+
  |   3 | 107 |   5 | 131 | 109 | 311 |
  +-----+-----+-----+-----+-----+-----+
  |   7 | 331 | 193 |  11 | 83  |  41 |
  +-----+-----+-----+-----+-----+-----+
  | 103 |  53 |  71 |  89 | 151 | 199 |
  +-----+-----+-----+-----+-----+-----+
  | 113 |  61 |  97 | 197 | 167 |  31 |
  +-----+-----+-----+-----+-----+-----+
  | 367 |  13 | 173 |  59 |  17 |  37 |
  +-----+-----+-----+-----+-----+-----+
  |  73 | 101 | 127 | 179 | 139 |  47 |
  +-----+-----+-----+-----+-----+-----+

(for (i 0 5) (println "somma riga " i ": " (apply + (m i))))
;-> somma riga 0: 666
;-> somma riga 1: 666
;-> somma riga 2: 666
;-> somma riga 3: 666
;-> somma riga 4: 666
;-> somma riga 5: 666

(apply + '(3 331 71 197 17 47))
;-> 666
(apply + '(311 83 89 97 13 73))
;-> 666

(for (i 0 5) (println "somma colonna " i ": " (apply + ((transpose m) i))))
;-> somma colonna 0: 666
;-> somma colonna 1: 666
;-> somma colonna 2: 666
;-> somma colonna 3: 666
;-> somma colonna 4: 666
;-> somma colonna 5: 666

12) Il quadrato magico del sole (composto dai numeri che vanno da 1 a 36):

  +----+----+----+----+----+----+
  |  6 | 32 |  3 | 34 | 35 |  1 | 111
  +----+----+----+----+----+----+
  |  7 | 11 | 27 | 28 |  8 | 30 | 111
  +----+----+----+----+----+----+
  | 19 | 14 | 16 | 15 | 23 | 24 | 111
  +----+----+----+----+----+----+
  | 18 | 20 | 22 | 21 | 17 | 13 | 111
  +----+----+----+----+----+----+
  | 25 | 29 | 10 |  9 | 26 | 12 | 111
  +----+----+----+----+----+----+
  | 36 |  5 | 33 |  4 |  2 | 31 | 111
  +----+----+----+----+----+----+
   111  111  111  111  111  111   666

=============================================================================

