===============

 NOTE LIBERE 5

===============

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

Nota: questo algoritmo non assicura che il giocatore A vince sempre. La vittoria di A dipende dalla casualità della distribuzione delle pentole, questo algoritmo massimizza il valore che A può ottenere, ma non è detto che il valore di B sia inferiore. Per convincersi è sufficiente considerare la seguente distribuzione di pentole: (1 3 1). Qualunque scelta faccia A, il massimo che può ottenere è 2, mentre B può ottenere 3:

(pots-gold-bu '(1 3 1))
;-> 2

In altre parole, questo algoritmo trova il comportamento ottimale per il giocatore A, ma non è in grado di definire una strategia vincente.

Nota: per definire una strategia vincente (se la distribuzione iniziale lo consente) occorre usare un algoritmo che considera l'intero albero delle possibili mosse (infatti è necessario ricorrere più in profondità per ottenere la soluzione ottimale anziché limitarsi a raggiungere il massimo alla mossa successiva).

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

Prendiamo per esempio il numero 7523351:

somma delle cifre con indice pari: 5 + 3 + 5 = 13
somma delle cifre con indice dispari: 7 + 2 + 3 + 1 = 13

Quindi il numero 7523351 soddisfa la condizione.

Sequenza OEIS A135499: 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132,
 143, 154, 165, 176, 187, 198, 220, 231, 242, 253, 264, 275, 286, 297, 330,
 341, 352, 363, 374, 385, 396, 440, 451, 462, 473, 484, 495, 550, 561, 572,
 583, 594, 660, 671, 682, 693, 770, 781, 792, 880, 891, 990, ...

Funzione che verifica se un numero soddisfa la condizione:

(define (equal-sum? num)
  (if (zero? num) nil
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

(time (println (length (equal-sum 1e8))))
;-> 4816029
;-> 186272.126 ; 3 minuti e 6 secondi


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
;-> Nuovo valore della variabile:
'(10 20 30)
;-> pippo = (10 20 30)
pippo
;-> (10 20 30)
(list? pippo)
;-> true


-----------------
La funzione curry
-----------------

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

perchè il simbolo "x" viene valutato a nil.


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

=============================================================================

