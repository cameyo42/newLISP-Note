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

=============================================================================

