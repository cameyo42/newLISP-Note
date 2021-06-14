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


------------------------------------------------
Esempio di Programmazione Dinamica: 0-1 Knapsack
------------------------------------------------

=============================================================================

