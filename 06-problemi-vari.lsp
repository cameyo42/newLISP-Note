===============

 PROBLEMI VARI

===============

----------
BubbleSort
----------

Il Bubble sort (ordinamento a bolla) è un semplice algoritmo stabile di ordinamento di una lista o di un vettore di dati. Ogni coppia di elementi adiacenti viene comparata e invertita di posizione se sono nell'ordine sbagliato. L'algoritmo continua continuamente ad eseguire questi passaggi per tutta la lista finché non vengono più eseguiti scambi, situazione che indica che la lista è ordinata.

Complessità temporale media O(n^2).

Nota: Un metodo di ordinamento si dice stabile se preserva l'ordine relativo dei dati con chiavi uguali all'interno della struttura dati da ordinare.

Possiamo rappresentare l'algoritmo con questo pseudocodice:

procedure BubbleSort(A:lista di elementi da ordinare)
  ultimoScambiato ← n
  n ← length(A) - 1
  while (ultimoScambiato > 0) do
    ultimoScambiato ← 0
    for i ← 0 to n do
      if (A[i] > A[i + 1]) then  //sostituire '>' con '<' per ottenere un ordinamento decrescente
        swap ( A[i], A[i+1] )
        ultimoScambiato ← i
   //ad ogni passaggio si accorcia il ciclo di for
   //fermandosi in corrispondenza dell'ultimo scambio effettuato
    n ← ultimoScambiato

Versione ricorsiva:

(define (bubble-up lst)
    (if (null? (rest lst))
        lst
        (if (< (first lst) (first (rest lst)))
            (cons (first lst) (bubble-up (rest lst)))
            (cons (first (rest lst)) (bubble-up (cons (first lst) (rest (rest lst))))))))

(define (bubble-sort-aux n lst)
    (cond ((= n 1) (bubble-up lst))
          (true (bubble-sort-aux (- n 1) (bubble-up lst)))))

(define (bubbleSort lst)
    (bubble-sort-aux (length lst) lst))

(bubbleSort '(5 10 9 8 7 8 6 7 5 4 3 4 5))
;-> (3 4 4 5 5 5 6 7 7 8 8 9 10)

Versione iterativa:

(define (bubbleSort lst)
  (local (i j continua)
    (setq continua 1)
    (setq j (length lst))
    (while (= continua 1)
      (setq continua 0)
      (for (i 1 (- j 1))
        (cond ((< (lst i) (lst (- i 1)))
               (swap (lst i) (lst (- i 1)))
               (setq continua 1))
        )
      )
      (-- j)
    )
  )
  lst
)

(bubbleSort '(5 10 9 8 7 8 6 7 5 4 3 4 5))
;-> (3 4 4 5 5 5 6 7 7 8 8 9 10)


---------
QuickSort
---------

Il Quicksort è un algoritmo di ordinamento ricorsivo. Appartiene alla classe degli algoritmi divide et impera, dal momento che scompone ricorsivamente i dati da processare in sottoprocessi. Tale procedura ricorsiva viene comunemente detta partizionamento: preso un elemento chiamato "pivot" da una struttura dati (es. lista o vettore) si pongono gli elementi minori a sinistra rispetto al pivot e gli elementi maggiori a destra. L'operazione viene quindi reiterata sui due insiemi risultanti fino al completo ordinamento della struttura.

Il Quicksort (ordinamento rapido), è l'algoritmo di ordinamento che ha, nel caso medio, prestazioni migliori tra quelli basati su confronto. È stato ideato da Richard Hoare nel 1961.

Complessità temporale media O(nlogn).

Lo pseudocodice per il Quicksort è:

Procedure Quicksort(A)
Input A, vettore a1, a2, a3 .. an
  begin
    if n ≤ 1 then return A
    else
      begin
        scegli un elemento pivot ak
        calcola il vettore A1 dagli elementi ai di A tali che i ≠ K e ai ≤ ak
        calcola il vettore A2 dagli elementi aj di A tali che j ≠ K e aj > ak
        A1 ← Quicksort(A1)
        A2 ← Quicksort(A2)
        return A1 U (ak) U A2;
      end

In newLISP possiamo scriverla in questo modo utilizzando la funzione "filter":

(define (quicksort lst)
  (cond ((or (null? lst)         ; la lista è vuota (ordinata)
             (null? (rest lst))) ; la lista ha un solo elemento (ordinata)
         lst)
        (true
          (let ((pivot (first lst)) ; Seleziona il primo elemento come pivot
                (resto (rest lst))) ; Prendi la lista rimanente (resto)
               (append (quicksort   ; Ricorsivamente ordina la lista dei valori più piccoli
                          (filter (lambda (x) (< x pivot)) resto)) ; Seleziona i valori più piccoli
                       (list pivot) ; Aggiungi il pivot al centro
                       (quicksort   ; Ricorsivamente ordina la lista dei valori più grandi
                          (filter (lambda (x) (>= x pivot)) resto)))  ; Seleziona i valori maggiori e uguali
          )
        )
  )
)

(quicksort '(89 3 4 5 3 2 2 4 6 7 8 9 7 8 9 3 2 4 89))
;-> (2 2 2 3 3 3 4 4 4 5 6 7 7 8 8 9 9 89 89)

Questo è l'algoritmo più veloce (in media) per ordinare una lista:

(silent (setq lst (rand 10000 100000)))

(time (quicksort lst))
;-> 989.971

Ma non è paragonabile alla funzione predefinita di newLISP "sort":

(time (sort lst))
;-> 55.94


-----------------------------------
Simulare una matrice con un vettore
-----------------------------------

Data la seguente matrice:

          | 1  2  3  4 |
Matrice = | 5  6  7  8 |
          | 9 10 11 12 |

Simuliamo l'indicizzazione della matrice con il vettore:

Vettore = (1 2 3 4 5 6 7 8 9 10 11 12)

In generale se la matrice ha N righe e M colonne, allora il vettore deve avere N*M elementi: matrice(NxM) ==> vettore(N*M)

La formula di conversione degli indici è la seguente:

Matrice(i,j) = Vettore(i*m + j) = vettore(k)

Definiamo una funzione che converte gli indici della matrice (i,j) nell'indice k del vettore:

(define (i-j->k i j n m) (+ (* i m) j))

(setq vec '(1 2 3 4 5 6 7 8 9 10 11 12))
(setq n 3)
(setq m 4)

(i-j->k 0 0 n m)
;-> 0
(vec (i-j->k 0 0 n m))
;-> 1

Stampiamo gli indici del vettore:

(for (i 0 (- n 1))
  (for (j 0 (- m 1))
    (print (i-j->k i j n m) { })
  )
)
;-> 0 1 2 3 4 5 6 7 8 9 10 11 " "

Stampiamo i valori del vettore:

(for (i 0 (- n 1))
  (for (j 0 (- m 1))
    (print (vec (i-j->k i j n m)) { })
  )
)
;-> 1 2 3 4 5 6 7 8 9 10 11 12 " "

Adesso definiamo la funzione inversa che mappa l'indice k del vettore negli indici (i,j) della matrice:

(define (k->i-j k n m)
  (local (i j)
    (setq i (/ k m))
    (setq j (- k (* m i)))
    (list i j)
  )
)

(k->i-j 0 n m)
;-> (0 0)
(k->i-j 11 n m)
;-> (2 3)

Stampiamo gli indici della matrice:

(for (k 0 (- (* n m) 1))
    (print (k->i-j k n m) { })
)
;-> (0 0) (0 1) (0 2) (0 3) (1 0) (1 1) (1 2) (1 3) (2 0) (2 1) (2 2) (2 3) " "


--------------------------------------------
Implementare una pila (stack) con un vettore
--------------------------------------------

La pila (Stack) è una struttura dati lineare che segue un ordine particolare in cui vengono eseguite le operazioni. L'ordine può essere LIFO (Last In First Out) o FILO (First In Last Out).
Principalmente le seguenti quattro operazioni di base sono eseguite nello stack:

Push: aggiunge un elemento nello stack. Se lo stack è pieno, si dice che sia una condizione di Overflow.
Pop: rimuove un oggetto dalla pila. Gli articoli vengono visualizzati nell'ordine invertito in cui vengono inseriti. Se lo stack è vuoto, si dice che sia una condizione di Underflow.
Look o Peek o Top: restituisce l'elemento superiore dello stack.
isEmpty: restituisce true se lo stack è vuoto, altrimenti false.
pila

Come capire praticamente una pila?
Ci sono molti esempi di vita reale di una pila. Considera il semplice esempio di piatti impilati uno sull'altro in una mensa. Il piatto che è nella parte superiore è il primo ad essere rimosso, in altre parole il piatto che è stato posto nella posizione più bassa rimane nella pila per il periodo di tempo più lungo. Quindi, può essere semplicemente visto seguire l'ordine LIFO / FILO.

Complessità di tempo delle operazioni sullo stack:

Le funzioni push (), pop (), isEmpty () e look () richiedono tutte un tempo O(1). Non eseguiamo alcun ciclo in queste operazioni.

          ---------------------   <-- push
          | 1 | 2 | 3 | 4 | 5 |
          ---------------------   pop -->
  Indice    0   1   2   3   4

Crea le variabili per la gestione della pila:
(define (Screate n)
  (setq Ssize n) ; max size
  (setq Sidx 0)
  (setq Stack (array Ssize '(0)))
)

La pila è vuota?
(define (SisEmpty?) (= Sidx 0))

La pila è piena?
(define (SisFull?) (= Sidx Ssize))

Lunghezza della pila
(define (SgetLen) (Sidx)

Inserisce un elemento nella pila (in cima):
(define (Spush el)
  (if (SisFull?) (list nil "Overflow")
    (begin (setf (Stack Sidx) el) (++ Sidx))
  )
)

Estrae un elemento dalla pila (in cima):
(define (Spop)
  (if (SisEmpty?) (list nil "Underflow")
    (begin (-- Sidx) (Stack Sidx))
  )
)

Guarda un elemento dalla lista (in cima):
(define (Slook)
  (if (SisEmpty?) nil
      (Stack (- Sidx 1))
  )
)

Stampa elementi della pila:

(define (Sshow)
  (if (SisEmpty?) nil ; coda vuota ?
      (for (i 0 (- Sidx 1))
            (print (Stack i) { })
      )
  )
)

(Screate 3)
;-> (0 0 0)
(Spush 1)
;-> 1
(Spush 2)
;-> 2
(SisFull?)
;-> nil
(Spush 3)
;-> 3
(SisFull?)
;-> true
(Slook)
;-> 3
(Sshow)
;-> 1 2 3
(Spop)
;-> 3
(Spop)
;-> 2
(Spop)
;-> 1
(Spop)
;-> (nil "Overflow)
(Spush 1)
(Spush 2)
(Spush 3)
(Spush 4)
;-> (nil "Overflow")


--------------------------------------------
Implementare una coda (queue) con un vettore
--------------------------------------------

In una coda (queue), l'inserimento e l'eliminazione degli elementi avvengono agli estremi opposti, quindi l'implementazione non è semplice come quella della pila (stack). Le operazioni su una coda sono basate sul principio FIFO (First In First Out).
Per implementare una coda usando un vettore, creare un vettore "vec" arr di dimensione n e utilizzare due variabili front e rear che verranno inizializzate a 0, il che significa che la coda è attualmente vuota. La variabile "rear" è l'indice in cui gli elementi sono memorizzati nel vettore e "front" è l'indice del primo elemento del vettore. Alcune delle operazioni sulle code sono le seguenti:

Enqueue: aggiunge di un elemento alla coda. L'aggiunta di un elemento verrà eseguita dopo aver controllato se la coda è piena o meno. Se (front < n) che indica che l'array non è pieno, allora memorizza l'elemento in vec[front] e incrementa rear di 1, ma se rear == n allora si ottiene una condizione di Overflow (il vettore è pieno).

Dequeue: rimuove un elemento dalla coda. Un elemento può essere cancellato solo quando è presente almeno un elemento da eliminare, ad esempio (rear > 0). Ora, l'elemento at vec[front] può essere cancellato, ma tutti gli elementi rimanenti devono essere spostati a sinistra di una posizione in modo che le successive operazioni sulla coda trovino il primo elemento della coda sulla prima cella (indice 0) del vettore.

Look: Ottiene l'elemento iniziale (front) dalla coda, ad esempio vec[front] se la coda non è vuota.

Show: Se la coda non è vuota, attraversa e stampa tutti gli elementi dall'indice anteriore a quello posteriore.

               -------------------------
  dequeue <--  | 1 | 2 | 3 | 4 | 5 |   |  <-- enqueue
               -------------------------
       Indice    0   1   2   3   4  ...

Crea le variabili per la gestione della coda:

(define (Qcreate n)
  (setq Qsize n) ; max size
  (setq Qfront 0)
  (setq Qrear 0)
  (setq Queue (array Qsize '(0)))
)

Inserisce un elemento nella coda (in fondo alla coda):

(define (Qenqueue el)
  ;controlla se la coda è piena
  (if (= Qsize Qrear)
      (list nil "overflow")
      ;else
      (begin
        (setf (Queue Qrear) el)
        (++ Qrear)
        el
      )
  )
)

Estrae un elemento dalla coda (all'inizio della coda):

(define (Qdequeue)
  (local (el)
    ;controlla se la coda è vuota
    (if (= Qfront Qrear)
        (list nil "overflow")
        ;else
        (begin
          (setq el (Queue Qfront)) ; estrae primo elemento della coda
          ; sposta tutti gli elementi a sinistra di un posto
          ; partendo dal secondo indice fino all'indice Qrear
          (for (i 0 (- Qrear 2)) (setf (Queue i) (Queue (+ i 1))))
          ; decrementa Qrear
          (-- Qrear)
          el
        )
    )
  );local
)

Stampa elementi della coda:

(define (Qshow)
  (if (= Qfront Qrear) nil ; coda vuota ?
      (for (i Qfront (- Qrear 1))
            (print (Queue i) { })
      )
  )
)

Guarda il primo elemento della coda:

(define (Qlook)
  (if (= Qfront Qrear) ; coda vuota ?
      nil
      (Queue Qfront)
  )
)

La coda è vuota?

(define (QisEmpty?) (= Qfront Qrear))

La coda è piena?

(define (QisFull?) (= Qrear Qsize))

Lunghezza della coda:

(define (QgetLen) (- Qfront Qrear))

(Qcreate 4)
;-> (0 0 0 0)
(Qenqueue 1)
;-> 1
(Qenqueue 2)
;-> 2
(Qenqueue 3)
;-> 3
(Qshow)
;-> 1 2 3
(QisEmpty?)
;-> nil
(QisFull?)
;-> nil
(Qenqueue 4)
;-> 4
(QisFull?)
;-> true
(Qenqueue 5)
;-> (nil "overflow")
(Qshow)
;-> (1 2 3 4)
(Qdequeue)
;-> (1)
(Qshow)
;-> (2 3 4)
(Qdequeue)
;-> 2
(Qdequeue)
;-> 3
(Qdequeue)
;-> 4
(Qdequeue)
;-> (nil "overflow")
(Qenqueue 4)
(Qshow)
;-> 4
(Qlook)
;-> 4
(Qshow)
;-> 4

Complessità temporale enqueue O(1)
Complessità temporale dequeue O(n)

È possibile ottenere una complessità temporale O(1) per la funzione dequeue se utilizziamo una lista circolare.

Con newLISP possiamo definire una coda (illimitata) utilizzando una lista in maniera "quick and dirty".
Dichiariamo una lista con lo stesso nome del contesto (funtore):

(setq k:k '())

Funzione che aggiunge (alla fine) un elemento alla coda:

(define (enqQ queue el) (push el queue -1))

Funzione che prende l'elemento iniziale della coda:

(define (deqQ queue) (if (not (emptyQ? queue)) (pop queue) nil))

Funzione che "guarda" il valore del primo elemento della coda:

(define (lookQ queue) (queue 0))

Funzione che restituisce true se la coda è vuota:

(define (emptyQ? queue) (= 0 (length queue)))

Funzione che restituisce il numero di elementi della coda:

(define (lenQ queue) (length queue))

Funzione che mostra tutti gli di elementi della coda:

(define (showQ queue) (println queue))

(enqQ k 1)
;-> (1)
(enqQ k 2)
;-> (2)
(enqQ k 3)
;-> (3)
k:k
;-> (1 2 3)
(deqQ k)
;-> 1
(println k:k)
;-> (2 3)
(emptyQ? k)
;-> nil
(lenQ k)
;-> 2
(k:k 1)
;-> 3
(showQ k:k)
;-> (2 3)
(lookQ k)
;-> 2

Con lo stesso metodo possiamo implementare anche una pila illimitata.


----------------------------
Coda circolare (Ring Buffer)
----------------------------

La Coda circolare (Circular Queue) è una struttura di dati lineare in cui le operazioni vengono eseguite in base al principio FIFO (First In First Out) e l'ultima posizione viene connessa alla prima posizione per creare un cerchio. Viene anche chiamato 'Ring Buffer'.

            front
 8      10   0       1  <--- indice
   -----------------
   |   |   | 2 | 1 |  <--- valore
   -----------------
 7 |   |       | 4 | 2
   -----------------
   |   | 7 | 8 | 5 |
   -----------------
 6       5   4       3
        rear

Crea le variabili per la gestione della coda circolare:

(define (CQcreate n)
  (setq CQsize n) ; max size
  (setq CQfront -1)
  (setq CQrear -1)
  (setq CQqueue (array CQsize '(0)))
)

(define (CQenqueue el)
  (cond ((or (and (= CQfront 0) (= CQrear (- CQsize 1)))
             (= CQrear (% (- CQfront 1) (- CQsize 1))))
          (list nil "Overflow") ; la coda è piena
        )
        ((= CQfront -1) ; primo inserimento
          (setq CQfront 0)
          (setq CQrear 0)
          (setq (CQqueue CQrear) el)
        )
        ((and (= CQrear (- CQsize 1)) (!= CQfront 0))
          (setq CQrear 0)
          (setq (CQqueue CQrear) el)
        )
        (true
          (++ CQrear)
          (setq (CQqueue CQrear) el)
        )
  )
)

(define (CQdequeue)
  (local (el)
    (cond ((= CQfront -1) (list nil "Underflow")) ; la coda è vuota
          (true
            (setq el (CQqueue CQfront))
            (setq (CQqueue CQfront) -1)
            (cond ((= CQfront CQrear) (setq CQfront -1 CQrear -1))
                  ((= CQfront (- CQsize 1)) (setq CQfront 0))
                  (true (++ CQfront))
            )
            el
          )
    )
  )
)

(define (CQshow)
  (cond ((= -1 CQfront) (list nil "Empty"))
        ((>= CQrear CQfront) (for (i CQfront CQrear) (print (CQqueue i) { })))
        (true (for (i CQfront (- CQsize 1) (print (CQqueue i) { })))
              (for (i 0 CQrear) (print (CQqueue i) { }))
        )
  )
)

(CQcreate 4)
;-> (0 0 0 0)
(CQenqueue 2)
;-> 2
(CQenqueue 1)
;-> 1
(CQshow)
;-> 2 1
(CQdequeue)
;-> 2
(CQdequeue)
;-> 1
(CQdequeue)
;-> (nil "Underflow")
(CQshow)
;-> (nil "Empty")

(CQenqueue 1)
(CQenqueue 2)
(CQenqueue 3)
(CQenqueue 5)
(CQenqueue 8)
;-> (nil "Overflow")
(CQshow)
;-> (1 2 3 5)

Complessità temporale:  O(1) per CQenqueue e CQdequeue poiché non vi è alcun ciclo in nessuna delle operazioni.

Applicazioni che utilizzano le code:
Gestione della memoria: le posizioni di memoria inutilizzate nel caso di code ordinarie possono essere utilizzate in code circolari.
Sistema di traffico: nel sistema di traffico controllato da computer, le code circolari vengono utilizzate per accendere ripetutamente i semafori secondo il tempo impostato.
Pianificazione della CPU: i sistemi operativi spesso mantengono una coda di processi pronti per l'esecuzione o che sono in attesa di un particolare evento.


----------
Fattoriale
----------

In matematica, si definisce fattoriale di un numero naturale n, indicato con n!, il prodotto dei numeri interi positivi minori o uguali a tale numero. In formula:

n! = Prod[i], con (1 <= i <= n)

per la convenzione del prodotto vuoto si definisce inoltre: 0! = 1

Nota: 1 = 1! = 1 * (1-1)! = 1 * 0! = 0!

Metodo ricorsivo:

(define (fact n)
  (if (< n 2)
      1
      (* n (fact (- n 1)))
  )
)

(fact 6L)
;-> 720L

Metodo iterativo:

(define (fact1 n)
  (let (fatt 1L)
    (for (x 1L n)
      (setq fatt (* fatt x))
    )
  )
)

(fact1 6)
;-> 720L

Metodo newLISP:

(define (fact2 n) (if (= n 0) 1 (apply * (map bigint (sequence 1 n)))))

(fact2 6)
;-> 720L

(fact2 100)
;-> 93326215443944152681699238856266700490715968264381621
;-> 46859296389521759999322991560894146397615651828625369
;-> 7920827223758251185210916864000000000000000000000000L

I fattoriali sono importanti nel calcolo combinatorio.
Per esempio, vi sono n! diverse sequenze formate da n oggetti distinti, cioè ci sono n! permutazioni di n oggetti.


----------------------
Coefficiente binomiale
----------------------

Il coefficiente binomiale, cioè il numero di scelte di k elementi tra quelli di un insieme di n elementi (numero di combinazioni semplici), ha la seguente formula:

(n)        n!
   = ---------------
(k)   k! * (n - k)!

in altre parole, il coefficiente binomiale C(n, k) fornisce anche il numero di modi, trascurando l'ordine, che k oggetti possono essere scelti tra n oggetti.

Soluzione ricorsiva

(define (binomiale n k)
  (if (or (= k 0) (= k n))
      1
      (add (binomiale (- n 1) (- k 1)) (binomiale (- n 1) k))
  )
)

(binomiale 5 2)
;-> 10

Soluzione iterativa

Per calcolare il coefficiente binomiale, usiamo una matrice M[][] che memorizza i valori precedenti (si tratta di una tecnica della Programmazione Dinamica)

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

(debug (binomiale 5 2))
(binomiale 5 2)
;-> 10

(binomiale 100 5)
;-> 75287520

Complessità temporale: O(n*k)
Complessità spaziale: O(n*k)


--------------
Lancio di dadi
--------------

Definire una funzione che permetta di ottenere il risultato del lancio di n dadi con m facce.
Utilizziamo la funzione "rand".

*****************
>>>funzione RAND
*****************
sintassi: (rand int-range [int-N])

Valuta l'espressione in int-range e genera un numero casuale compreso tra 0 (zero) e (int-range - 1). Quando viene passato 0 (zero), il generatore casuale interno viene inizializzato utilizzando il valore corrente restituito dalla funzione C time (). Facoltativamente, è possibile specificare un secondo parametro per restituire un elenco di lunghezza int-N di numeri casuali.

(dotimes (x 100) (print (rand 2))) =>
11100000110100111100111101 ... 10111101011101111101001100001000

(rand 3 100) → (2 0 1 1 2 0 ...)

La prima riga nell'esempio stampa equamente distribuite 0 e 1, mentre la seconda riga produce un elenco di 100 interi con 0, 1 e 2 equamente distribuiti. Utilizzare le funzioni "random" e "normal" per generare numeri casuali in virgola mobile e utilizzare "seed" per variare il seme iniziale per la generazione di numeri casuali.

Per generare il numero prodotto dal lancio di n dadi con m facce, potremmo pensare di generare un numero casuale tra n (quando tutti i dadi valgono 1) e n*m (quando tutti i dadi valgono m).

(define (lancio n m)
  (add n (rand (sub (add (mul n m) 1) n)))
)

(lancio 2 6)
;-> 11

Purtroppo questo ragionamento è sbagliato perchè la nostra funzione considera equiprobabili i numeri tra n e n*m, mentre questo non è vero. Vediamo un esempio con due dadi a sei facce.
Le probabilità dei numeri non sono identiche, infatti risulta:

 1: nil (non può mai uscire 1)
 2: (1,1) --> (1 caso)
 3: (1,2) (2,1) --> (2 casi)
 4: (1,3) (3,1) (2,2) --> (3 casi)
 5: (1,4) (4,1) (2,3) (3,2) --> (4 casi)
 6: (1,5) (5,1) (2,4) (4,2) (3,3) --> (5 casi)
 7: (1,6) (5,2) (2,5) (5,2) (3,4) (4,3) --> (6 casi)
 8: (2,6) (6,2) (3,5) (5,3) (4,4) --> (5 casi)
 9: (3,6) (6,3) (4,5) (5,4) --> (4 casi)
10: (4,6) (6,4) (5,5) --> (4 casi)
11: (5,6) (6,5) --> (2 casi)
12: (6,6) --> (1 caso)

La seguente funzione fornisce il risultato corretto:

(define (lancio-dadi num-dadi num-facce)
  (+ num-dadi (apply + (rand num-facce num-dadi)))
)

(lancio-dadi 2 6)
;-> 9

Per capire meglio la differenza dei risultati tra le due funzioni, creiamo due liste con le frequenze di 10000 valori generati da ognuna delle due funzioni, poi disegniamo un istogramma per ogni lista.

Creiamo la prima lista.
Generiamo una lista con 10000 lanci:

(setq res1 '())
(for (i 0 9999)
  (push (lancio 2 6) res1 -1)
)
(length res1)

Creiamo la lista delle frequenze:

(setq f1 (array 13 '(0)))
(dolist (el res1)
  (println el)
  (++ (f1 (- el 1)))
)

f1
;-> (0 880 889 913 929 910 914 939 866 902 943 915 0)

Creiamo la seconda lista.
Generiamo una lista con 10000 lanci:

(setq res2 '())
(for (i 0 9999)
  (push (lancio-dadi 2 6) res2 -1)
)
(length res2)

Creiamo la lista delle frequenze:

(setq f2 (array 13 '(0)))
(dolist (el res2)
  (println el)
  (++ (f2 (- el 1)))
)

f2
;-> (0 288 515 870 1145 1354 1643 1385 1162 803 565 270 0)

Adesso dobbiamo creare una funzione che disegna l'istogramma di una lista. Per i nostri scopi sarà sufficiente la seguente funzione che disegna un istogramma ruotato di 90 gradi utilizzando il carattere "*". Il parametro "hmax" definisce l'altezza massima dell'istogramma.

(define (histo lst hmax)
  (local (linee hm scala)
    (setq hm (apply max lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (lst $idx)))
      (println (format "%3d %s %4d" (add $idx 1) (dup "*" el) (lst $idx)))
    )
  )
)

Proviamo a disegnare l'istogramma della prima lista:

(histo f1 50)
;->   1     0
;->   2 ***********************************************  909
;->   3 **********************************************  878
;->   4 **********************************************  892
;->   5 **********************************************  888
;->   6 *************************************************  946
;->   7 *********************************************  870
;->   8 *************************************************  942
;->   9 ************************************************  918
;->  10 **************************************************  962
;->  11 ************************************************  923
;->  12 *********************************************  872
;->  13     0

E poi l'istogramma della seconda lista:

(histo f2 50)
;->   1     0
;->   2 ********  251
;->   3 ****************  525
;->   4 **************************  852
;->   5 ********************************** 1142
;->   6 ***************************************** 1363
;->   7 ************************************************** 1663
;->   8 ****************************************** 1403
;->   9 ********************************** 1133
;->  10 *************************  846
;->  11 ****************  541
;->  12 ********  281
;->  13     0

La prima lista ha una distribuzione pressochè uniforme (tutti i numeri hanno la stessa probabilità).
La seconda lista ha una distribuzione gaussiana centrata sul numero più probabile.

Notazione internazionale

Una lancio di dadi viene codificato con la seguente espressione matematica:

XdY [<-> | <+> | <*> | </>] [N | AdB]

Al numero uscito dal lancio di X dadi con Y facce viene applicata una delle operazioni - o + o * o / con il numero N o con il numero uscito da un lancio di A dadi con B facce.

Esempi:
2d6 + 10
(al lancio di 2 dadi con 6 facce sommare il numero 10)
4d8 - 1d6
(al lancio di 4 dadi con 8 facce sottrarre il lancio di 1 dado con 6 facce)


---------------
Quadrati magici
---------------

Un quadrato magico è una matrice quadrata NxN i cui numeri consistono in numeri consecutivi (da 1 a N) disposti in modo tale che la somma di ogni riga e colonna e di entrambe le diagonali siano uguali alla stessa somma (che è chiamata numero magico o costante magica).
Il numero magico vale: n(n*n + 1)/2

Esistono tre tipi di quadrati magici (catalogati in base alla dimensione del lato)

- dispari (dove n = 3, 5, 7, 9, 11, ecc.)

- singolarmente pari (dove n è multiplodi di 2, ma non di 4, n = 6, 10, 14, 18, 22, ...)

- doppiamente pari (dove n è un multiplo di quattro, n = 4, 8, 12, ...

Dato un numero N, scrivere una funzione che crea un quadrato magico di ordine N.

Per la stampa utilizziamo la seguente funzione:

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    ; converto matrice in lista ?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
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

Dobbiamo scrivere una funzione per ogni tipo di quadrato magico. Cominciamo con quelli di ordine dispari.

1) Quadrati Magici Dispari

(define (qmDispari n)
  (define (f n x y) (% (add x (mul y 2) 1) n))
  (local (val nm row out)
    (setq out '())
    (setq row '())
    ;calcolo quadrato magico
    (for (i 0 (sub n 1))
      (for (j 0 (sub n 1))
        (setq val (add (mul (f n (sub n j 1) i) n)
                       (add (f n j i))
                       1))
        (push val row -1)
      )
      (push row out -1)
      (setq row '())
    )
    ;calcolo numero magico
    (setq nm (div (mul n (add 1 (mul n n))) 2))
    (println nm)
    out
  )
)

(print-matrix (qmDispari 9))
;-> 369
;->   2 75 67 59 51 43 35 27 10
;->  22 14  6 79 71 63 46 38 30
;->  42 34 26 18  1 74 66 58 50
;->  62 54 37 29 21 13  5 78 70
;->  73 65 57 49 41 33 25 17  9
;->  12  4 77 69 61 53 45 28 20
;->  32 24 16  8 81 64 56 48 40
;->  52 44 36 19 11  3 76 68 60
;->  72 55 47 39 31 23 15  7 80

Scriviamo una funzione che controlla la correttezza del quadrato generato

(define (check qm n somma)
  (local (valido srow scol)
    (setq valido true)
    ; controllo diagonali
    (setq srow 0 scol 0)
    (for (i 0 (sub n 1))
      (setq srow (add srow (qm i i)))
      (setq scol (add scol (qm i (sub n i 1))))
    )
    (if (or (!= srow somma) (!= scol somma))
        (setq valido nil))
    ;controllo righe e colonne
    (for (i 0 (sub n 1) 1 valido)
      (setq srow 0 scol 0)
      (for (j 0 (sub n 1) 1 valido )
        (setq srow (add srow (qm i j)))
        (setq scol (add scol (qm j i)))
      )
      (if (or (!= srow somma) (!= scol somma))
          (setq valido nil)
      )
    )
    valido
  )
)

(setq m (qmDispari 9))
;-> 369
(check m 9 369)
;-> true

2) Quadrati Magici Doppiamente Pari

(define (qm4 n)
  (local (r c i bit size mult bitPos nm out v)
    (setq bit 38505)
    (setq size (* n n))
    (setq mult (/ n 4))
    ;creazione della lista)
    (setq out (dup (dup 0 n) n))
    (setq r 0 c 0 i 0)
    (while (< r n)
      (while (< c n)
        (setq bitPos (+ (/ c mult) (* (/ r mult) 4)))
        (if (!= (& bit (<< 1 bitPos)) 0)
          (setq v (+ i 1))
          (setq v (- size i))
        )
        (setf (out r c) v)
        (++ c)
        (++ i)
      )
      (setq c 0)
      (++ r)
    )
    ;calcolo numero magico
    (setq nm (div (mul n (add 1 (mul n n))) 2))
    (println nm)
    out
  )
)

(setq m (qm4 4))
;-> 34
;-> ((1 15 14 4) (12 6 7 9) (8 10 11 5) (13 3 2 16))
(print-matrix m)
;->   1 15 14  4
;->  12  6  7  9
;->   8 10 11  5
;->  13  3  2 16
(check m 4 34)
;-> true

(setq m (qm4 12))
;-> 870
(print-matrix m)
;->    1   2   3 141 140 139 138 137 136  10  11  12
;->   13  14  15 129 128 127 126 125 124  22  23  24
;->   25  26  27 117 116 115 114 113 112  34  35  36
;->  108 107 106  40  41  42  43  44  45  99  98  97
;->   96  95  94  52  53  54  55  56  57  87  86  85
;->   84  83  82  64  65  66  67  68  69  75  74  73
;->   72  71  70  76  77  78  79  80  81  63  62  61
;->   60  59  58  88  89  90  91  92  93  51  50  49
;->   48  47  46 100 101 102 103 104 105  39  38  37
;->  109 110 111  33  32  31  30  29  28 118 119 120
;->  121 122 123  21  20  19  18  17  16 130 131 132
;->  133 134 135   9   8   7   6   5   4 142 143 144
(check m 12 870)
;-> true

3) Quadrati Magici Singolarmente Pari

; Funzione interna che crea un quadrato magico dispari
(define (oddMS n)
  (local (r c squaresize nm out value)
    (setq squaresize (* n n))
    (setq c (/ n 2))
    (setq r 0)
    ;creazione della lista
    (setq out (dup (dup 0 n) n))
    (setq value 1)
    (while (<= value squaresize)
      (setf (out r c) value)
      (cond ((= r 0)
              (if (= c (- n 1))
                  (++ r)
                  (begin
                  (setq r (- n 1))
                  (++ c))
              )
            )
            ((= c (- n 1))
              (-- r)
              (setq c 0)
            )
            ((= (out (- r 1) (+ c 1)) 0)
              (-- r)
              (++ c)
            )
            (true (++ r))
      )
      (++ value)
    )
    ;(println (div (mul n (add 1 (mul n n))) 2))
    out
  )
)

(setq m (oddMS 5))
;-> 65
;-> ((17 24 1 8 15) (23 5 7 14 16) (4 6 13 20 22) (10 12 19 21 3) (11 18 25 2 9))
(print-matrix m)
;->  17 24  1  8 15
;->  23  5  7 14 16
;->   4  6 13 20 22
;->  10 12 19 21  3
;->  11 18 25  2  9
(check m 5 65)
;-> true

(define (qm2 n)
  (local (r c size half grid gridFactors subGrid nColsLeft nColsRigth nm out)
    (setq size (* n n))
    (setq halfN (/ n 2))
    (setq subGridSize (/ size 4))
    (setq subGrid (oddMS halfN))
    (setq gridFactors '(0 2 3 1))
    ;creazione della lista
    (setq out (dup (dup 0 n) n))
    (for (r 0 (- n 1))
      (for (c 0 (- n 1))
        ;(println r { } c)
        (setq grid (+ (* (/ r halfN) 2) (/ c halfN)))
        (setf (out r c) (subGrid (% r halfN) (% c halfN)))
        (setf (out r c) (+ (out r c) (* (gridFactors grid) subGridSize)))
      )
    )
    (setq nColsLeft (/ halfN 2))
    (setq nColsRigth (- nColsLeft 1))
    (for (r 0 (- halfN 1))
      (for (c 0 (- n 1) 1 )
        (if (or (< c nColsLeft) (>= c (- n nColsRigth))
                (and (= c nColsLeft) (= r nColsLeft)))
            ;(if (and (!= c 0) (!= r nColsLeft))
            (if (and (= c 0) (= r nColsLeft))
                (setq c c) ; no operation (NOP)
                (swap (out r c) (out (+ r halfN) c))
            )
        )
      )
    )
    (println (div (mul n (add 1 (mul n n))) 2))
    out
  );local
)

(qm2 6)
;-> 111
;-> ((35 1 6 26 19 24) (3 32 7 21 23 25) (31 9 2 22 27 20) (8 28 33 17 10 15)
;-> (30 5 34 12 14 16) (4 36 29 13 18 11))

(setq m (qm2 6))
(print-matrix m)
;->  35  1  6 26 19 24
;->   3 32  7 21 23 25
;->  31  9  2 22 27 20
;->   8 28 33 17 10 15
;->  30  5 34 12 14 16
;->   4 36 29 13 18 11
(check m 6 111)
;-> true


-------------------
Quadrati magici 3x3
-------------------

Nessun output sulla REPL:
(define (resume) (print "\r\n> "))

Esempio di utilizzo:
(silent <(function)> (print "Fatto") (resume))

Numero magico per i quadrati magici 3x3:
(setq nm (div (mul 3 (add 1 (mul 3 3))) 2))
;-> 15

Funzione che controlla se un quadrato è magico:

(define (check3 qm somma)
  (if (and (= somma (+ (qm 0) (qm 1) (qm 2))) ;riga 0
           (= somma (+ (qm 3) (qm 4) (qm 5))) ;riga 1
           (= somma (+ (qm 6) (qm 7) (qm 8))) ;riga 2
           (= somma (+ (qm 0) (qm 3) (qm 6))) ;colonna 0
           (= somma (+ (qm 1) (qm 4) (qm 7))) ;colonna 1
           (= somma (+ (qm 2) (qm 5) (qm 8))) ;colonna 2
           (= somma (+ (qm 0) (qm 4) (qm 8))) ;diagonale 1
           (= somma (+ (qm 2) (qm 4) (qm 6)))) ;diagonale 2
      true
      nil
  )
)

(check3 '(1 2 3 4 5 6 7 9 8) 15)
;-> nil

Questo è un quadrato magico:

  8 1 6
  3 5 7
  4 9 2

(check3 '(8 1 6 3 5 7 4 9 2) 15)
;-> true

Funzione che genera le permutazioni:

(define (rimuovi x lst)
  (cond
    ((null? lst) '())
    ((= x (first lst)) (rimuovi x (rest lst)))
    (true (cons (first lst) (rimuovi x (rest lst))))
  )
)

(define (permutazioni lst)
  (cond
    ((= (length lst) 1)(list lst))
    (true (apply append(map(lambda (i) (map (lambda (j)(cons i j))
                                            (permutazioni (rimuovi i lst)))) lst)))
  )
)

Generiamo tutte le permutazioni delle cifre da 1 a 9:
(silent (setq all (permutazioni '(1 2 3 4 5 6 7 8 9))) (print "Fatto") (resume))
;-> Fatto

Vediamo quante sono le permutazioni:
(length all)
;-> 362880

Vediamo una permutazione:
(all 1)
;-> (1 2 3 4 5 6 7 9 8)

Verifichiamo la correttezza della funzione di controllo:
(check3 (all 1) 15)
;-> nil

Verifichiamo quali permutazioni sono quadrati magici:

(setq out '())

(dolist (el all)
  (if (check3 el 15)
      (push el out -1)
  )
)

(length out)
;-> 8

out
;-> ((2 7 6 9 5 1 4 3 8)
;->  (2 9 4 7 5 3 6 1 8)
;->  (4 3 8 9 5 1 2 7 6)
;->  (4 9 2 3 5 7 8 1 6)
;->  (6 1 8 7 5 3 2 9 4)
;->  (6 7 2 1 5 9 8 3 4)
;->  (8 1 6 3 5 7 4 9 2)
;->  (8 3 4 1 5 9 6 7 2))

Per attraversare una lista la funzione "dolist" è molto più veloce dell'uso di un ciclo "for" con l'indicizzazione.

(setq out1 '())
(time
(for (i 0 (- (length all) 1))
  (setq el (all i))
  (if (check3 el 15)
      (push el out1 -1)
  )
  (if (= (% i 10000) 0 (println i)))
)
)
;->  1994673.832; 33 minuti...provatela solo se avete tempo...

Salviamo il risultato:

(save "qm3x3.lsp" 'out)
;-> true

Rendiamo il risultato più leggibile:

(dolist (el out)
  (println (el 0) { } (el 1) { } (el 2))
  (println (el 3) { } (el 4) { } (el 5))
  (println (el 6) { } (el 7) { } (el 8))
  (println)
)

                          Lo Shu
2 7 6    2 9 4    4 3 8    4 9 2    6 1 8    6 7 2    8 1 6    8 3 4
9 5 1    7 5 3    9 5 1    3 5 7    7 5 3    1 5 9    3 5 7    1 5 9
4 3 8    6 1 8    2 7 6    8 1 6    2 9 4    8 3 4    4 9 2    6 7 2

Il quarto quadrato magico è lo Shu (simbolo divinatorio e matematico cinese).
Ogni altro quadrato magico di ordine tre è ottenuto dallo Shu per rotazione e/o riflessione.


-------------------
Mastermind numerico
-------------------

(define (guessNumber)
  (local (num num$ found guess turnlst digits numdigits numTurn guessValue digitOK orderOK)
    ; lista di ogni turno
    ; turno -> (numTurn guess$ digitOK orderOK)
    (setq turnlst '())
    ; Inserire il numero di cifre del numero random
    (setq numdigits (input-integer "Numero di cifre (2-10): " 2 10))
    ; Generazione del numero random con cifre tutte diverse
    ; Validi anche i numeri con 0 iniziale (es. 0342)
    (setq num$ "")
    (setq digits (explode "0123456789"))
    (setq num$ (join (slice (randomize digits) 0 numdigits 1)))
    (setq num (int num$))
    ;(println num$)
    (setq numTurn 0)
    (setq found nil)
    ; Ciclo del gioco
    (while (not found)
      ; Inserire il numero (tentativo)
      (setq guess$ (input-string "Numero da provare: "))
      (while (not (guessControl guess$ num$))
        (setq guess$ (input-string "Numero da provare: "))
      )
      (++ numTurn)
      ;confronto tra numero random e guess
      ;numero di cifre di guess$ presenti in num$
      (setq digitOK (checkDigitOK num$ guess$))
      ;numero di cifre di guess$ nello stesso ordine in num$
      (setq orderOK (checkOrderOK num$ guess$))
      ; aggiorno la lista dei turni
      (push (list numTurn guess$ digitOK orderOK) turnlst -1)
      ;stampo la lista dei turni
      (println "turno    numero    cifreOK  ordineOK")
      (dolist (el turnlst)
        (println (format "%3d %10s %9d %9d" el))
      )
      ;controllo fine del gioco (numero indovinato)
      (if (= num$ guess$)
        (begin
          (println "NUMERO INDOVINATO --> " num$)
          (setq found true))
      )
    )
  );local
)

; routine che controlla la correttezza del numero di input (guess)
(define (guessControl guess$ num$)
  (cond ((not (numero? guess$)) (println "Inserire solo cifre...") nil)
        ((!= (length num$) (length guess$))
          (println "Numero di cifre errato...") nil) ;numero di cifre errato
        ((!= (unique (explode guess$)) (explode guess$))
          (println "Numero con cifre ripetute...") nil) ;numero con cifre ripetute
        (true true)
  )
)

; routine che controlla se la stringa è composta solo da cifre
(define (numero? stringa)
  (while (= "0" (stringa 0))
    (setq stringa (slice stringa 1)))
  (if (= (string (int stringa 0)) stringa) true nil))

(numero? "1234")
;-> true
(numero? "012a5")
;-> nil
(numero? "012")
;-> true

;routine che permette l'input di una stringa
(define (input-string message)
  (print message)
  (while (not (string? (read-line)))
    (print message)
  )
  (current-line)
)

;routine che permette l'input di un numero intero (compreso tra minv e maxv)
(define (input-integer message minv maxv)
  (print message)
  (while (or (not (integer? (int (read-line))))
             (> (int (current-line)) maxv)
             (< (int (current-line)) minv))
    (print message)
  )
  (int (current-line))
)

; Restituisce il numero di cifre di str1 che
; hanno la stessa posizione in str2
(define (checkOrderOK str1 str2)
  (local (numOK)
    (setq numOK 0)
    (for (i 0 (- (length str1) 1))
      (if (= (str1 i) (str2 i)) (++ numOK))
    )
    numOK
  )
)

(checkOrderOK "1234" "4321")
;-> 0
(checkOrderOK "123" "124")
;-> 2

; Restituisce il numero di cifre di str1 presenti in str2
(define (checkDigitOK str1 str2)
  (local (numOK)
    (setq numOK 0)
    (for (i 0 (- (length str1) 1))
      (if (!= (find (str1 i) str2) nil) (++ numOK))
    )
    numOK
  )
)

(checkDigitOK "012" "123")
;-> 2

(checkDigitOK "123" "132")
;-> 3

Adesso possiamo provare il gioco:

(guessNumber)
Numero di cifre (2-10): 3
Numero da provare: 515
Numero con cifre ripetute...
Numero da provare: 428
turno    numero    cifreOK  ordineOK
  1        428         2         2
Numero da provare: 183
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
Numero da provare: 421
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
Numero da provare: 426
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
  4        426         2         2
Numero da provare: er4
Inserire solo cifre...
Numero da provare: 1
Numero di cifre errato...
Numero da provare: 12345
Numero di cifre errato...
Numero da provare: 427
turno    numero    cifreOK  ordineOK
  1        428         2         2
  2        183         0         0
  3        421         2         2
  4        426         2         2
  5        427         3         3
NUMERO INDOVINATO --> 427
true


----------------------------
Algoritmo babilonese sqrt(x)
----------------------------

Dato un valore x > 0, l'algoritmo babilonese permette di calcolare un valore approssimato della radice quadrata di x sqrt(x). Questo metodo funziona nel modo seguente:

1) Assegna un valore positivo alla stima-iniziale della radice (quanto più essa è prossima alla radice, tanto migliore è la convergenza dell'algoritmo)
2) calcola la nuova stima come la media di stima-iniziale e x/stima-iniziale
3) Se la differenza tra stima-iniziale e stima è minore della precisione desiderata, allora la stima è la soluzione (radice), altrimenti poni la stima-iniziale uguale alla stima e continua al passo 2.

Questo algoritmo può essere rappresentato dalla seguente formula:

          1              x
x(n+1) = --- * (x(n) + -----)
          2            x(n)

Scriviamo la funzione:

(define (rq x err)
  (local (stima-iniziale stima differenza n)
    (setq n 0)
    (setq stima-iniziale (div x 2)) ;stima iniziale vale x/2
    (setq differenza (add 2 err))   ;differenza iniziale > err
    (while (> differenza err)
      (setq stima (div (add stima-iniziale (div x stima-iniziale)) 2))
      (setq differenza (abs(sub stima-iniziale stima)))
      (setq stima-iniziale stima)
      (++ n)
    )
    (list stima n)
  )
)

(rq 0.38 0.00001)
;-> (0.6164414002968977 6)

(rq 0.09 0.00001)
;-> (0.3 7)

(rq 0.123456789 0.0000001)
;-> (0.3513641828644462 7)
(mul 0.3513641828644462 0.3513641828644462)
;-> 0.123456789

(rq 123456 0.0000001)
(351.363060095964 12)
(mul 351.363060095964 351.363060095964)
;-> 123456

(rq 123456789 0.0000001)
;-> (11111.11106055556 18)
(mul 11111.11106055556 11111.11106055556)
;-> 123456789.0000001

Vediamo una versione che sceglie la stima iniziale in base al valore di x:

(define (rq x err)
  (local (stima-iniziale stima differenza n)
    (setq n 0)
    (if (> x 1)  ;stima iniziale
        (setq stima-iniziale (div x 2))
        (setq stima-iniziale (mul x 2))
    )
    (setq differenza (add 2 err))   ;differenza iniziale > err
    (while (> differenza err)
      (setq stima (div (add stima-iniziale (div x stima-iniziale)) 2))
      (setq differenza (abs(sub stima-iniziale stima)))
      (setq stima-iniziale stima)
      (++ n)
    )
    (list stima n)
  )
)

(rq 0.38 0.00001)
;-> (0.6164414002968979 4)

(rq 0.09 0.00001)
;-> (0.3000000001396984 4)

(rq 0.09 0.0000001)
;-> (0.3 5)

(rq 0.123456789 0.0000001)
;-> (0.3513641828644462 5)
(mul 0.3513641828644462 0.3513641828644462)
;-> 0.123456789

(rq 123456 0.0000001)
(351.363060095964 12)
(mul 351.363060095964 351.363060095964)
;-> 123456

(rq 123456789 0.0000001)
;-> (11111.11106055556 18)
(mul 11111.11106055556 11111.11106055556)
;-> 123456789.0000001

Questa ultima versione ha una convergenza più rapida con i numeri minori di 1.

L'algoritmo può anche essere definito nel modo seguente:

1) Poni il valore iniziale della stima della radice x0 uguale al numero x
2) Inizializza y = 1.
3) Fino al raggiungimento della precisione desiderata:
   a) calcolare prossima stima: x0 = (x0 + y)/2
   b) Imposta y = x / x0

(define (rq x err)
  (local (x0 y)
    (setq y 1)
    (setq x0 (div x 2)) ; stima valore iniziale uguale al numero x
    (while (> (abs (sub x0 y)) err) ;
      (setq x0 (div (add x0 y) 2))
      (setq y (div x x0))
    )
    x0
  )
)

(rq 4.5 0.000001)
;-> 2.121320746178046
(mul (rq 4.5 0.000001) (rq 4.5 0.000001))
;-> 4.500001708165383

(rq 4 0.000001)
;-> 2.00000000000012

La complessità temporale di questo algoritmo è O(log(log(n))).


-----------------------------------------------------
Radice quadrata intera di un numero intero (2^64 bit)
-----------------------------------------------------

(define (isqrt x)
  (local (x1 s g0 g1)
    (cond ((<= x 1) 1)
          ((> x 4294967295) nil)
          (true
            (setq s 1)
            (setq x1 (- x 1))
            (if (> 4294967295 x1) (setq s (+ s 16) x1 (>> x1 32)))
            (if (> 65535 x1) (setq s (+ s 8) x1 (>> x1 16)))
            (if (> 255 x1) (setq s (+ s 4) x1 (>> x1 8)))
            (if (> 15 x1) (setq s (+ s 2) x1 (>> x1 4)))
            (if (> 3 x1) (setq s (+ s 1)))
            (setq g0 (<< 1 s))
            (setq g1 (>> (+ g0 (>> x s)) 1))
            (while (< g1 g0) ; while approssimazione
              (setq g0 g1)   ; strettamente decrescente
              (setq g1 (>> (+ g0 (/ x g0))  1))
            )
          )
    )
    g0
  )
)

(isqrt 4)
;-> 2

(isqrt 18)
;-> 4

(isqrt 65536)
;-> 256

(isqrt 4294967295)
;-> (65535)

(isqrt 4294967296)
;-> nil

(* 4294967296L 4294967296L)
;-> 18446744073709551616L


-------------------------------
Ricerca binaria (binary search)
-------------------------------

La "ricerca binaria" è un algoritmo di ricerca che individua l'indice di un determinato valore in un insieme ordinato di dati. Se il valore non esiste allora l'indice vale -1.
Questo algoritmo cerca un elemento all'interno di una lista ordinata, effettuando mediamente meno confronti rispetto ad una ricerca sequenziale, e quindi più rapidamente rispetto ad essa perché, sfruttando l'ordinamento, dimezza l'intervallo di ricerca ad ogni passaggio.
L'algoritmo è simile a quello della ricerca di una parola sul dizionario: sapendo che il vocabolario è ordinato alfabeticamente, l'idea è quella di iniziare la ricerca non dal primo elemento, ma da quello centrale, cioè a metà del dizionario. Si confronta questo elemento con quello cercato:
- se corrisponde, la ricerca termina indicando che l'elemento è stato trovato;
- se è superiore, la ricerca viene ripetuta sugli elementi precedenti (ovvero sulla prima metà del dizionario), scartando quelli successivi;
- se invece è inferiore, la ricerca viene ripetuta sugli elementi successivi (ovvero sulla seconda metà del dizionario), scartando quelli precedenti.
Se tutti gli elementi vengono scartati, la ricerca termina senza aver trovato il valore.
La ricerca binaria non usa mai più di floor(log(2) N) (logaritmo base 2 di N approssimato per eccesso) confronti.

Attenzione che questo algoritmo è più difficile di quanto sembri da scrivere. Jon Bentley, nel suo libro "Programming Pearls", riferisce che il 90% dei programmatori professionisti non è in grado di scrivere una corretta implementazione della ricerca binaria in due ore, e Donald Knuth, nel secondo volume della sua opera "The Art of Computer Programming", riporta che sebbene il primo codice per la ricerca binaria fu pubblicato nel 1946, la prima ricerca binaria senza errori non fu pubblicata fino al 1962.

Scriviamo questo algoritmo sia in versione iterativa che in versione ricorsiva (e speriamo di farlo correttamente).

Versione iterativa:

(define (bs num lst)
  (local (basso alto indice)
    (setq out -1) ; elemento non trovato
    (setq basso 0) ; inizio lista
    (setq alto (- (length lst) 1)) ; fine lista
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (+ basso alto))) ; valore centrale indice
      (cond ((> (lst indice) num)
             (setq alto (- indice 1))) ; aggiorno l'indice "alto"
            ((< (lst indice) num)
             (setq basso (+ indice 1))) ; aggiorno l'indice "basso"
            (true (setq out indice)) ; elemento trovato
      )
    );while
    out
  );local
)

(bs 2 '(-31 0 1 2 3 4 65 83 99 782))
;-> 3

(bs -2 '(-31 0 1 2 2 4 65 83 99 782))
;-> -1

La funzione non è in grado di trovare il numero se la lista è ordinata in modo decrescente:

(bs 2 '(782 99 83 65 4 3 2 1 0 -31))
;->  -1 ;il valore 2 esiste con indice 6.

Aggiungiamo un parametro che ci permette di specificare l'ordinamento della lista:
1) > la lista è ordinata in modo crescente
2) < la lista è ordinata in modo decrescente

(define (bs num lst op)
  (local (basso alto indice)
    (setq out -1)
    (setq basso 0)
    (setq alto (- (length lst) 1))
    (while (and (>= alto basso) (= out -1))
      (setq indice (>> (+ basso alto))) ;; right shift
      (cond ((> (lst indice) num)
             (if (= op >) ;controllo dell'ordinamento della lista
                (setq alto (- indice 1))
                (setq basso (+ indice 1))
             ))
            ((< (lst indice) num)
             (if (= op >) ;controllo dell'ordinamento della lista
                (setq basso (+ indice 1))
                (setq alto (- indice 1))
             ))
            (true (setq out indice))
      )
    );while
    out
  );local
)

(bs 2 '(-31 0 1 2 3 4 65 83 99 782) >)
;-> 3

(bs -2 '(-31 0 1 2 2 4 65 83 99 782) >)
;-> -1

(bs 2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> 6

(bs -2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> -1

(bs 1 '() >)
;-> -1

(bs 2 '(1 2 2 3) <)
;-> 1 ;restituisce il primo valore del 2

Vediamo la versione ricorsiva:

(define (bs-r num lst op)
  (define (bsr num lst basso alto op)
    (setq indice (>> (+ basso alto)))
    (cond ((< alto basso) -1)
          ((> (lst indice) num)
              (if (= op >)
                  (bsr num lst basso (- indice 1) op)
                  (bsr num lst (+ indice 1) alto op)))
          ((< (lst indice) num)
              (if (= op >)
                  (bsr num lst (+ indice 1) alto op)
                  (bsr num lst basso (- indice 1) op)))
          (true indice)
    );cond
  )
  (if (= lst '())
    -1
    (bsr num lst 0 (length lst) op)
  )
)

(bs-r 2 '(-31 0 1 2 3 4 65 83 99 782) >)
;-> 3

(bs-r -2 '(-31 0 1 2 2 4 65 83 99 782) >)
;-> -1

(bs-r 2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> 6

(bs-r -2 '(782 99 83 65 4 3 2 1 0 -31) <)
;-> -1

(bs-r 1 '() >)
;-> -1

(bs-r 2 '(1 2 2 3) >)
;-> 2 ;restituisce il secondo valore del 2


--------------------
Frazione generatrice
--------------------

Qual è la frazione generatrice di 1.42703703703...? (il 703 si ripete infinite volte)

1.42703 = (142703 - 152)/99900

Come verifica possiamo calcolare:

152651 / 99900 = 1.42703703703...

Definiamo l'algoritmo di calcolo della frazione generatrice:

Consideriamo ad esempio il numero 1.42703703703..., con le cifre 703 che si ripetono infinite volte.

- si dice periodo il gruppo di cifre che si ripete (nell'esempio, il periodo è 703)
- si dice antiperiodo il gruppo di cifre che sta tra la virgola (punto) e il periodo (nell'esempio, l'antiperiodo è 42)

se l’antiperiodo non c’è, si parla di numero periodico semplice (ad esempio 1,6666... è un numero periodico semplice)

se invece l’antiperiodo è presente, si parla di numero periodico misto (ad esempio 1,3777... è un numero periodico misto)

L'algoritmo è il seguente:

Per costruire la frazione generatrice di un numero decimale periodico si calcola:

1) al numeratore, il numero dato senza la virgola (punto) e senza il segno di periodo, meno (sottrazione) tutto ciò che sta prima del periodo;

2) al denominatore, tanti 9 quante sono le cifre del periodo, seguiti da tanti 0 quante sono le cifre dell’antiperiodo.

3) Dopo aver fatto queste operazioni dobbiamo ridurre la frazione numeratore/denominatore ai minimi termini.

Nel nostro caso:

numero = 1.42(703)
periodo = 703
numero cifre periodo = 3
antiperiodo = 42
numero cifre antiperiodo = 2

Quindi:

N = 142708 - 142

D = 99900 (perchè periodo di 3 cifre --> 999 e antiperiodo di 2 cifre --> 00)

La nostra funzione avrà tre parametri:

1) il numero "n" (1.42703)
2) in numero di cifre del periodo "np" (3)
3) in numero di cifre dell'antiperiodo "na" (2)

(define (fraz-gen num np na)
  (local (n n1 n2 d d1 d2 t1 t2 temp)
     ; calcolo numeratore
    (setq n1 (mul num (pow 10 (add np na))))
    ;(setq n2 (int (mul num (pow 10 na))))
    (setq n2 (int (mul num (pow 10 na))) 0 10)
    (setq n (sub n1 n2))
    ; calcolo denominatore
    (setq d1 (dup "9" np))
    (setq d2 (dup "0" na))
    (setq d (int (append d1 d2)))
    ;semplifica numeratore/denominatore
    (setq t1 n)
    (setq t2 d)
    (while (!= t2 0)
      (setq temp t2)
      (setq t2 (% t1 temp))
      (setq t1 temp)
    )
    (setq n (/ n t1))
    (setq d (/ d t1))
    ; risultato
    (list n d (div n d))
  )
)

(fraz-gen 1.42703 3 2)
;-> (3853 2700 1.427037037037037)

(fraz-gen 10.52803 2 3)
;-> (13897 1320 10.5280303030303)

(fraz-gen 1.2 1 0)
;-> (11 9 1.222222222222222)

(fraz-gen 3.141592 1 5)
;-> (2827433 900000 3.141592222222222)

Nota:
I numeri che hanno come periodo la sola cifra 9 non esistono.
Infatti matematicamente 1.999... = 2.

(fraz-gen 1.9 1 0)
;-> (2 1 2)

(frac-gen 3.14159 1 4)
;-> (3927 1250 3.1416)


---------------
Il numero aureo
---------------

Il numero aureo (o rapporto aureo) è il numero ottenuto effettuando il rapporto fra due lunghezze disuguali delle quali la maggiore "a" è medio proporzionale tra la minore "b" e la somma delle due (a+b):

                        (a + b)     a
numero aureo (phi) --> --------- = ---
                           a        b

Quindi possiamo scrivere:

            1
phi = 1 + -----
           phi

Che porta alla seguente equazione di secondo grado:

phi^2 - phi - 1 = 0

Che ha la seguente soluzione (positiva):

phi = (1 + (sqrt 5))/2 = 1.6180339887...

Quindi phi è un numero irrazionale.

Cerchiamo di calcolarlo con il metodo del punto fisso.
La funzione di cui ricerchiamo il punto fisso vale:

phi = 1 + 1/phi

Poniamo il punto fisso iniziale a uno: phi0 = 1

(setq phi0 1)
(setq phi phi0)
(while (!= phi (add 1 (div 1 phi)))
  (setq phi (add 1 (div 1 phi)))
)
;-> 1.618033988749895

Possiamo utilizzare anche la funzione predefinita "series":

(series 1 (fn (x) (div (add 1 x))) 20)
;-> (1 0.5 0.6666666 0.6 0.625 0.6153846 0.619047 0.6176470 0.6181818
;->  0.6179775 0.6180555 0.6180257 0.6180371 0.6180327 0.6180344
;->  0.6180338 0.6180340 0.6180339 0.6180339 0.6180339)

Utilizziamo la funzione "series" per approssimare sqrt(2) = 1.414213562373095:

(series 1 (fn (x) (add 1 (div (add 1 x)))) 20)
;-> (1 1.5 1.4 1.416666666666667 1.413793103448276 1.414285714285714 1.414201183431953
;->  1.41421568627451 1.414213197969543 1.41421362489487 1.414213551646055 1.414213564213564
;->  1.41421356205732 1.414213562427273 1.4142135623638 1.41421356237469 1.414213562372821
;->  1.414213562373142 1.414213562373087 1.414213562373097)


--------------------------
Equazioni di secondo grado
--------------------------

Scriviamo una funzione che calcola le soluzioni di una equazione di secondo grado:

; Equazione di secondo grado: (a*x^2 + b*x + c = 0)
; Soluzioni:
; x1 = -b/(2*a) + (sqrt(b*b - 4*a*c))/(2*a)
; x2 = -b/(2*a) - (sqrt(b*b - 4*a*c))/(2*a)

(define (solve-quadratic a b c)
  (if (and (null? a) (null? b) (null? c))
      (begin
        (println "(solve-quadratic a b c)")
        (println "Calcola le soluzioni dell'equazione: a*x^2 + b*x + c = 0")
        (print {})
      )
  ; else
  (local (x1 i1 x2 i2 delta)
    (setq delta (sub (mul b b) (mul 4 a c)))
    (println delta)
    (cond ((= a 0) ; equazione di primo grado
            (if (!= b 0) (setq x1 (sub 0 (div c b)))))
          ((> delta 0) ; due radici reali
            (setq x1 (div (add (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq x2 (div (sub (sub 0 b) (sqrt delta)) (mul 2 a)))
            (setq i1 0.0)
            (setq i2 0.0))
          ((< delta 0) ; due radici complesse
            (setq x1 (div (sub 0 b) (mul 2 a)))
            (setq x2 (div (sub 0 b) (mul 2 a)))
            (setq i1 (div (sqrt (sub 0 delta)) (mul 2 a)))
            (setq i2 (sub 0 (div (sqrt (sub 0 delta)) (mul 2 a)))))
          (true
          ;((= delta 0) ; due radici coincidenti
            (setq x1 (sub 0 (div b (mul 2 a))))
            (setq x2 (sub 0 (div b (mul 2 a)))))
    )
    (list (list x1 i1) (list x2 i2))
  )
  ) ;endif
)

(solve-quadratic)
;-> (solve-quadratic a b c)
;-> Calcola le soluzioni dell'equazione: a*x^2 + b*x + c = 0

(solve-quadratic -3 -3 -20)
;-> -231
;-> ((-0.5 -2.533114025595111) (-0.5 2.533114025595111))

(solve-quadratic 3 3 -20)
;-> 249
;-> ((2.129955639676583 0) (-3.129955639676583 0))

(solve-quadratic 3 -3 -20)
;-> 249
;-> ((3.129955639676583 0) (-2.129955639676583 0))

(solve-quadratic -3 -3 20)
;-> 249
;-> ((-3.129955639676583 0) (2.129955639676583 0))

(solve-quadratic 3 3 20)
;-> -231
;-> ((-0.5 2.533114025595111) (-0.5 -2.533114025595111))

(solve-quadratic 0 10 20)
;-> 100
;-> ((-2 nil) (nil nil))


------------------------
Equazione di terzo grado
------------------------

Scriviamo una funzione che calcola le soluzioni di una equazione di terzo grado:

; Equazione di terzo grado: (a*x^3 + b*x^2 + c*x + d = 0)
; Per l'algoritmo di soluzione vedere i seguenti link:
; http://mathworld.wolfram.com/CubicFormula.html
; https://courses.cs.washington.edu/courses/cse590b/13au/lecture_notes/solvecubic_p2.pdf

(define (solve-cubic a b c d)
  (local (x1 x2 x3 i1 i2 i3 F G H I J K L M N P Q R S T U)
    (setq x1 0 x2 0 x3 0 i1 0 i2 0 i3 0)
    ; Calcolo discriminanti F, G, H
    ; F = (3*(c/a) - (b*b)/(a*a)) / 3
    (setq F (div (sub (mul 3 (div c a)) (div (mul b b) (mul a a))) 3))
    ; (println "F = " F)
    ; G = ((2*(b*b*b)/(a*a*a)) - (9*b*c/(a*a)) + (27*(d/a))) / 27
    (setq G (div (add (sub (mul 2 (div (mul b b b) (mul a a a))) (div (mul 9 b c) (mul a a))) (mul 27 (div d a))) 27))
    ; (println "G = " G)
    ; H = ((G*G)/4) + ((F*F*F)/27)
    (setq H (add (div (mul G G) 4) (div (mul F F F) 27)))
    ; (println "H = " H)
    ; Controllo discriminanti per determinare il tipo delle radici
    (cond ((> H 0) ; una radice reale e due radici complesse
            ; I = -(G/2) + Math.sqrt(H)
            (setq I (sub (sqrt H) (div G 2)))
            ;(println "I = " I)
            ; J = Math.cbrt(I)
            (setq J (my-pow I (div 1 3)))
            ;(println "J = " J)
            ; K = (-G/2) - Math.sqrt(H)
            (setq K (sub (sub 0 (div G 2)) (sqrt H)))
            ;(println "K = " K)
            ; L = Math.cbrt(K)
            (setq L (my-pow K (div 1 3)))
            ;(println "L = " L)
            ; x1 =  (J + L) - (b/(3*a))
            (setq x1 (sub (add J L) (div b (mul 3 a))))
            ; x2 = -(J + L)/2 - (b/(3*a))
            (setq x2 (sub (sub 0 (div (add J L) 2)) (div b (mul 3 a))))
            ; i2 =  (J - L) * Math.sqrt(3)/2
            (setq i2 (mul (sub J L) (div (sqrt 3) 2)))
            ; x3 =  x2
            (setq x3 x2)
            ; i3 = -i2
            (setq i3 (sub 0 i2)))
          ((and (zero? F) (zero? G) (zero? H)) ; tre radici reali coincidenti
            ; x1 = Math.cbrt(d/a) * (-1)
            (setq x1 (sub 0 (my-pow (div d a) (div 1 3))))
            (setq x2 x1)
            (setq x3 x1))
          ((<= H 0) ; tre radici reali
            ; M = Math.sqrt((G*G)/4 - H)
            (setq M (sqrt (sub (div (mul G G) 4) H)))
            ;(println "M = " M)
            ; N = Math.cbrt(M)
            (setq N (my-pow M (div 1 3)))
            ;(println "N = " N)
            ; P = Math.acos(-(G/(2*M)))
            (setq P (acos (sub 0 (div G (mul M 2)))))
            ;(println "P = " P)
            ; Q = N*(-1)
            (setq Q (sub 0 N))
            ;(println "Q = " Q)
            ; R = Math.cos(P/3)
            (setq R (cos (div P 3)))
            ;(println "R = " R)
            ; S = Math.sqrt(3) * Math.sin(P/3)
            (setq S (mul (sqrt 3) (sin (div P 3))))
            ;(println "S = " S)
            ; T = (b/(3*a)) * (-1)
            (setq T (sub 0 (div b (mul 3 a))))
            ;(println "T = " T)
            ; x1 = 2*N*Math.cos(P/3) - (b/(3*a))
            (setq x1 (sub (mul 2 N (cos (div P 3))) (div b (mul 3 a))))
            ; x2 = Q * (R + S) + T
            (setq x2 (add T (mul Q (add R S))))
            ; x3 = Q * (R - S) + T;
            (setq x3 (add T (mul Q (sub R S)))))
          (true (println "errore"))
    );cond
    (list x1 i1 x2 i2 x3 i3)
  );local
)

; calcola anche le potenze di numeri negativi
(define (my-pow x n)
  (if (< x 0)
      (sub 0 (pow (sub 0 x) n)) ;cambio segno a x, calcolo la potenza, cambio segno al risultato
      (pow x n)))

Vediamo alcuni esempi:

; una radice reale e due radici complesse
; (x-2)*(x-(2+8i))*(x-(2-8i)) = 0
; x^3 - 6x^2 + 76x - 136 = 0
(solve-cubic 1 -6 76 -136)
;-> (2 0 2 7.999999999999999 2 -7.999999999999999)

; tre radici reali coincidenti
; (x - 2)*(x - 2)*(x - 2) = 0
; x^3 - 6 x^2 + 12 x - 8 = 0
(solve-cubic 1 -6 12 -8)
;-> (2 0 2 0 2 0)

; tre radici reali distinte
; (x-1)*(x+4)*(x-2) = 0
; x^3 + x^2 - 10 x + 8 = 0
(solve-cubic 1 1 -10 8)
;-> (2 0 -4 0 1 0)

; una radice reale e due radici complesse
; 3x^3 - 2x^2 + 4x - 3 = 0
(solve-cubic 3 -2 4 -3)
;-> (0.7263732804864121 0 -0.02985330690987276 1.172949872052025 -0.02985330690987276 -1.172949872052025)


------------------------
Sistemi Lineari (Cramer)
------------------------

Proviamo a scrivere un programma che risolve i sistemi lineari.
Utilizzeremo il metodo di Cramer perchè newLISP mette a disposizione una funzione standard per calcolare il determinante di una matrice.

****************
>>>funzione DET
****************
sintassi: (det matrix [float-pivot])

Restituisce il determinante di una matrice quadrata. Una matrice può essere una lista nidificata o un vettore (array).

Opzionalmente 0.0 o un valore molto piccolo può essere specificato in float-pivot. Questo valore sostituisce gli elementi pivot nell'algoritmo di decomposizione LU, che risulta zero quando l'algoritmo incontra una matrice singolare.

(set 'A '((-1 1 1) (1 4 -5) (1 -2 0)))
(det A)
;-> -0.9999999999999998

; trattamento di una matrice singolare
(det '((2 -1) (4 -2)))
;-> nil
(det '((2 -1) (4 -2)) 0)
-0
(det '((2 -1) (4 -2)) 1e-20)
;-> -4e-20

Se la matrice è singolare e float-pivot non è specificato, viene restituito nil.

Vediamo alcuni esempi di risoluzione di un sistema lineare.

Esempio 1

  x + 2y + 3z =  1
-3x - 2y + 3z = -1
 4x - 5y + 2z =  1

Soluzione
 x = detX/det
 y = detY/det
 z = detZ/det

 x = 21/58, y = 4/29, z = 7/58
 x≈0.36207, y≈0.13793, z≈0.12069

Impostiamo i valori della matrice:

(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))
;-> ((1 2 3) (-3 -2 3) (4 -5 2))

Calcoliamo il determinante:

(setq det-m (det m))
;-> 116

Impostiamo il vettore dei termini noti:

(setq n '(1 -1 1))

Calcoliamo determinante per la variabile x sostituendo prima la colonna 0 della matrice con i valori della colonna dei termini noti:

(setf (m 0 0) (n 0))
(setf (m 1 0) (n 1))
(setf (m 2 0) (n 2))
m
;-> ((1 2 3) (-1 -2 3) (1 -5 2))

Calcoliamo il determinante di x:

(setq detX (det m))
;-> 42

Calcoliamo la soluzione per x:

(setq x (div detX det-m))
;-> 0.3620689655172414

Impostiamo i valori della matrice:
(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))

Calcoliamo determinante per la variabile y sostituendo prima la colonna 1 della matrice con i valori della colonna dei termini noti:

(setf (m 0 1) (n 0))
(setf (m 1 1) (n 1))
(setf (m 2 1) (n 2))
m
;-> ((1 1 3) (-3 -1 3) (4 1 2))

Calcoliamo il determinante di y:

(setq detY (det m))
;-> 16

Calcoliamo la soluzione per y:

(setq y (div detY det-m))
;-> 0.1379310344827586

Impostiamo i valori della matrice:
(setq m '((1 2 3) (-3 -2 3) (4 -5 2)))

Calcoliamo determinante per la variabile z sostituendo prima la colonna 2 della matrice con i valori della colonna dei termini noti:

(setf (m 0 2) (n 0))
(setf (m 1 2) (n 1))
(setf (m 2 2) (n 2))
m
;-> ((1 2 1) (-3 -2 -1) (4 -5 1))

Calcoliamo il determinante di z:

(setq detZ (det m))
;-> 14

Calcoliamo la soluzione per z:

(setq z (div detZ det-m))
;-> 0.1206896551724138

Esempio 2

 2x + y +  z =  1
 4x - y +  z = -5
 -x + y + 2z =  5

Soluzione
x = detX/det
y = detY/det
z = detZ/det

x = -1, y = 2, z = 1

Impostiamo i valori della matrice:

(setq m '((2 1 1) (4 -1 1) (-1 1 2)))
m
;-> ((2 1 1) (4 -1 1) (-1 1 2))

Calcoliamo il determinante:

(setq det-m (det m))
;-> -12
(setq n '(1 -5 5))

Calcoliamo determinante per la variabile x sostituendo prima la colonna 0 della matrice con i valori della colonna dei termini noti:

(setf (m 0 0) (n 0))
(setf (m 1 0) (n 1))
(setf (m 2 0) (n 2))
m

Calcoliamo il determinante di x:

(setq detX (det m))
;-> 12

Calcoliamo la soluzione per x:
(setq x (/ detX det-m))
;-> -1

Impostiamo i valori della matrice:
(setq m '((2 1 1) (4 -1 1) (-1 1 2)))

Calcoliamo determinante per la variabile y sostituendo prima la colonna 1 della matrice con i valori della colonna dei termini noti:

(setf (m 0 1) (n 0))
(setf (m 1 1) (n 1))
(setf (m 2 1) (n 2))
m

Calcoliamo il determinante di y:

(setq detY (det m))
;-> 24

Calcoliamo la soluzione per y:

(setq y (/ detY det-m))
;-> 2

Impostiamo i valori della matrice:

(setq m '((2 1 1) (4 -1 1) (-1 1 2)))

Calcoliamo determinante per la variabile z sostituendo prima la colonna 2 della matrice con i valori della colonna dei termini noti:

(setf (m 0 2) (n 0))
(setf (m 1 2) (n 1))
(setf (m 2 2) (n 2))
m

Calcoliamo il determinante di z:

(setq detZ (det m))
;-> -12

Calcoliamo la soluzione per z:

(setq z (/ detZ det-m))
;-> 1

Scriviamo la funzione:

(define (cramer matrice noti)
  (local (dim detm det-i sol copia)
    (setq dim (length matrice))
    (setq sol '())
    (setq copia matrice)
    (setq detm (det copia 0.0))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (copia j i) (noti j))
        )
        ; 0.0 -> restituisce 0 (invece di nil),
        ; quando la matrice è singolare
        (setq det-i (det copia 0.0))
        (push (div det-i detm) sol -1)
        (setq copia matrice)
      );endfor
    );endif
    sol
  );local
)

(cramer '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))
;-> (-1 2 1)

(cramer '((1 2 3) (-3 -2 3) (4 -5 2)) '(1 -1 1))
;-> (0.3620689655172414 0.1379310344827586 0.1206896551724138)

Proviamo con un sistema 8x8:

(cramer
'((2 3 3 -4 -5 3 -2 3)
  (-3 3 -1 2 3 5 -2 3)
  (4 2 4 -4 -2 3 -1 -5)
  (-3 2 2 -4 -1 4 -1 -5)
  (2 6 -3 -4 -4 3 -2 -3)
  (2 -6 -1 3 -3 4 -1 -1)
  (3 -1 -2 -3 -1 3 1 1)
  (1 -2 -3 4 -1 -3 2 3))
'(1 -1 1 2 3 2 -2 2))
;-> (-0.2907517086232766 0.4541737926192612 0.1222139219887456 0.7272295937332997
;->  -0.9577686974650513 0.1669345810796059 0.682061578219236 -0.3880884752566235)

Nota: La regola di Cramer è inadatta per N grande (es. N > 12), sia per l'accuratezza numerica e la sensibilità agli errori, sia perché è molto lenta rispetto ad altri algoritmi.


-----------------------
Sistemi lineari (Gauss)
-----------------------

Per risolvere un sitema lineare utilizzeremo il metodo di eliminazione di Gauss con pivot e poi sostituzione all'indietro (Gaussian elimination with pivot and then backwards substitution).
Per maggiori informazioni sull'algoritmo:

https://it.wikipedia.org/wiki/Metodo_di_eliminazione_di_Gauss

; risolve il sistema lineare A*x = b
(define (gauss A b)
  (local (n m p rowx amax xfac temp temp1 x)
    (setq rowx 0) ;conta il numero di scambio righe
    (setq n (length A))
    (setq x (dup '0 n))
    (for (k 0 (- n 2))
      (setq amax (abs (A k k)))
      (setq m k)
      ; trova la riga con il pivot più grande
      (for (i (+ k 1) (- n 1))
        (setq xfac (abs (A i k)))
        (if (> xfac amax) (setq amax xfac m i))
      )
      ; scambio delle righe
      (if (!= m k) (begin
          (++ rowx)
          (setq temp1 (b k))
          (setq (b k) (b m))
          (setq (b m) temp1)
          (for (j k (- n 1))
            (setq temp (A k j))
            (setq (A k j) (A m j))
            (setq (A m j) temp)
          ))
      )
      (for (i (+ k 1) (- n 1))
        (setq xfac (div (A i k) (A k k)))
        (for (j (+ k 1) (- n 1))
          (setq (A i j) (sub (A i j) (mul xfac (A k j))))
        )
        (setq (b i) (sub (b i) (mul xfac (b k))))
      )
    )
    ; sostituzione all'indietro (backward sostitution)
    (for (j 0 (- n 1))
      (setq p (sub n j 1))
      (setq (x p) (b p))
      (if (<= (+ p 1) (- n 1))
        (for (i (+ p 1) (- n 1))
          (setq (x p) (sub (x p) (mul (A p i) (x i))))
        )
      )
      (setq (x p) (div (x p) (A p p)))
    )
    x
  ); local
)

(gauss '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))
;-> (-1 2 1)

(gauss '((1 2 3) (-3 -2 3) (4 -5 2)) '(1 -1 1))
;-> (0.3620689655172414 0.1379310344827586 0.1206896551724138)

(setq matrice '((1 1 1 0 0 0 -10 -10)
 (0 0 0 1 1 1 -2 -2)
 (5 1 1 0 0 0 -65 -13)
 (0 0 0 5 1 1 -25 -5)
 (5 5 1 0 0 0 -60 -60)
 (0 0 0 5 5 1 -55 -55)
 (1 5 1 0 0 0 -9 -45)
 (0 0 0 1 5 1 -8 -40)))

(setq noti '(10 2 13 5 12 11 9 8))
;-> (10 2 13 5 12 11 9 8)

(gauss matrice noti)
;-> (0.7500000000000002 -0.2499999999999999 9.5 0.7500000000000002
;->  1.5 -0.2500000000000003 2.379049338482478e-017 7.930164461608264e-018)

Arrotondiamo a 4 cifre decimali dopo la virgola:

(map (fn (x) (round x -4)) (gauss matrice noti))
;-> (0.75 -0.25 9.5 0.75 1.5 -0.25 0 0)

Vediamo la differenza di velocità tra il metodo di Cramer e il metodo di Gauss:

(time (gauss matrice noti) 10000)
;-> 667.316

(time (cramer matrice noti) 10000)
;-> 318.691

Proviamo con un sistea 16x16:

(setq matrice '((1 1 1 0 0 0 -10 -10 -20 -22 -10 -12 -14 -16 22 -42)
 (0 0 0 -1 1 -1 0 0 0 -1 1 1 1 1 -2 -2)
 (5 1 1 0 0 0 5 -1 1 0 0 0 0 0 -65 -13)
 (0 0 0 5 1 1 0 0 0 5 1 -1 1 1 -25 -5)
 (5 5 1 0 0 0 5 -5 1 0 0 0 0 0 -60 -60)
 (0 0 0 5 5 1 0 0 0 5 5 1 -5 1 -55 -55)
 (1 5 1 0 0 0 1 5 -1 0 0 0 0 0 -9 -45)
 (0 0 0 1 5 2 0 0 0 1 -5 2 -5 2 -3 -40)
 (0 4 0 6 5 0 0 4 0 6 5 0 5 0 -8 -30)
 (1 0 4 1 5 1 1 0 4 1 -5 1 5 -1 -8 -40)
 (1 3 3 4 8 2 1 3 3 4 -8 2 8 2 -5 -64)
 (1 3 4 3 -4 2 1 3 3 3 4 2 4 2 -1 -14)
 (2 4 3 1 5 -2 2 4 3 1 0 2 5 2 -1 -24)
 (1 5 3 9 6 2 -1 5 3 9 6 0 6 2 -1 -34)
 (3 6 3 1 7 2 3 -6 3 1 7 2 0 2 -1 -44)
 (9 2 1 1 5 6 9 2 -1 1 5 6 5 0 -6 -74)))

(setq noti '(10 -2 13 -5 12 11 9 -8 -10 12 -18 10 20 16 8 6))

(cramer matrice noti)
;-> (6.073265713499919 
;-> -7.895511516493116 
;-> 1.832360106508081 
;-> 3.230429811886619 
;-> -1.455619886107596
;-> -6.476253322763236 
;-> 3.679036826897333 
;-> 2.718120581717722 
;-> 6.958059613240136 
;-> -3.641846643266388
;-> 2.958481343355023 
;-> -12.86237050078677 
;-> -2.628371168374938 
;-> 4.849669122127303 
;-> 0.6839772385617239
;-> -0.8092477063837188)

(gauss matrice noti)
;-> (6.073265713499932 
;->  -7.895511516493109 
;->  1.832360106508014 
;->  3.230429811886656 
;->  -1.455619886107596
;->  -6.476253322763209 
;->  3.679036826897329 
;->  2.718120581717728 
;->  6.958059613240156 
;->  -3.641846643266435
;->  2.958481343355025 
;->  -12.86237050078677 
;->  -2.628371168374938 
;->  4.849669122127305 
;->  0.6839772385617227
;->  -0.8092477063837177)

(time (gauss matrice noti) 10000)
;-> 4114.972

(time (cramer matrice noti) 10000)
;-> 1526.089

La funzione built-in "det" è molto veloce...


-------------
Numeri Brutti
-------------

I numeri Brutti sono numeri positivi i cui fattori primi includono solo 2, 3, 5. Ad esempio, 6, 8
sono brutti mentre 14 non è brutto in quanto include un altro fattore primo 7. Notare che 1 è
trattato come un numero brutto.
Scrivere un programma per trovare l'n-esimo numero Brutto.

Prima scriviamo una funzione per verificare se un dato numero è un numero Brutto:

(define (brutto? num)
  (cond ((= 0 num) nil)
        ((= 1 num) true)
        ((= 0 (% num 2)) true)
        ((= 0 (% num 3)) true)
        ((= 0 (% num 5)) true)
  )
)

(map brutto? (sequence 1 10))
;-> (true true true true true true nil true true true)

Poi scriviamo il programma per trovare l'n-esimo numero Brutto:

(define (brutto num)
  (local (conta out)
    (setq out '())
    (setq conta 0)
    (setq n 0)
    (while (< conta num)
      (if (brutto? n) (begin (++ conta) (push n out -1)))
      (++ n)
    )
    (last out)
  )
)

(brutto 10)
;-> 12

(brutto 10000)
;-> 13635


-----------------
Numeri Poligonali
-----------------

Un numero poligonale è un numero che può essere rappresentato mediante uno schema geometrico regolare in modo da raffigurare un poligono regolare.

I numeri poligonali derivano dalle seguenti operazioni:

1 + 1 + 1 + 1 + 1 + ...    genera numeri interi       1, 2, 3, 4, 5 ...
1 + 2 + 3 + 4 + 5 + ...    genera numeri triangulari  1, 3, 6, 10, 15 ...
1 + 3 + 5 + 7 + 9 + ...    genera numeri quadrati     1, 4, 9, 16, 25 ...
1 + 4 + 7 + 10 + 13 + ...  genera numeri pentagonali  1, 5, 12, 22, 35 ...
1 + 5 + 9 + 13 + 17 + ...  genera numeri esagonali    1, 6, 15, 28, 45 ...
1 + 6 + 11 + 16 + 21 + ... genera numeri eptagonali   1, 7, 18, 34, 55 ...
1 + 7 + 13 + 19 + 25 + ... genera numeri ottagonali   1, 8, 21, 40, 65 ...

Formule:
numeri triangolari = (n * (n - 1))/2
numeri quadrati    = n * n
numeri pentagonali = (n * (3*n - 1))/2
numeri esagonali   = n * (2*n - 1)
numeri eptagonali  = (5*n*n - 3*n)/2
numeri ottagonali  = (3*n*n - 2*n)
...
numeri p-gonali = p*n*(n - 1)/2 - n*(n - 2)

I numeri triangolari possono essere ottenuti anche in modo ricorsivo:

T(1) = 1
T(n) = T(n-1) + n per n > 1

Definiamo una funzione che calcola il numero n-esimo del numero poligonale con p lati:

(define (numpoligonale p n)
  (- (/ (* p n (- n 1)) 2) (* n (- n 2)))
)

(numpoligonale 3 2)
;-> 3

(numpoligonale 3 3)
;-> 6

(numpoligonale 8 5)
;-> 65

Adesso definiamo una funzione che costruisce una lista di n numeri poligonali con p lati:

(define (numpoligonale-list tipo num)
  (local (out)
    (setq out '())
    (for (x 1 num)
       ;(println out)
       (extend out (list(numpoligonale tipo x)))
    )
    ;(reverse _out)
  )
)

(numpoligonale-list 3 20)
;-> (1 3 6 10 15 21 28 36 45 55 66 78 91 105 120 136 153 171 190 210)

(numpoligonale-list 6 10)
;-> 1 6 15 28 45 66 91 120 153 190)

Nota: Ogni numero esagonale è anche un numero triangolare.

(numpoligonale-list 4 10)
;-> (1 4 9 16 25 36 49 64 81 100)


--------------
Torre di Hanoi
--------------

La Torre di Hanoi è un rompicapo matematico composto da tre paletti e un certo numero di dischi di grandezza decrescente, che possono essere infilati in uno qualsiasi dei paletti.

               paletto A              paletto B           paletto C

                   ||                    ||                  ||
                   ||                    ||                  ||
                   ||                    ||                  ||
                +------+                 ||                  ||
disco 1         +------+                 ||                  ||
                   ||                    ||                  ||
             +------------+              ||                  ||
disco 2      +------------+              ||                  ||
                   ||                    ||                  ||
          +------------------+           ||                  ||
disco 3   +------------------+           ||                  ||
                   ||                    ||                  ||

Il gioco inizia con tutti i dischi incolonnati su un paletto in ordine decrescente (il disco più piccolo si trova in cima). Lo scopo del gioco è spostare tutti i dischi su un paletto diverso potendo muovere solo un disco alla volta e potendo mettere un disco solo su un altro disco più grande, mai su uno più piccolo.
Il gioco fu inventato nel 1883[1] dal matematico francese Edouard Lucas. La leggenda narra che in un tempio Indù alcuni monaci sono impegnati a spostare su tre colonne di diamante 64 dischi d'oro secondo le regole della Torre di Hanoi: quando i monaci completeranno il lavoro, il mondo finirà.
La proprietà matematica base è che il numero minimo di mosse necessarie per completare il gioco è (2^n - 1), dove n è il numero di dischi. Ad esempio con 3 dischi, il numero minimo di mosse vale 7. Quindi i monaci di Hanoi dovrebbero effettuare almeno 18.446.744.073.709.551.615 mosse prima che il mondo finisca (n = 64).
La soluzione generale è data dal seguente algoritmo ricorsivo.
Identifichiamo i paletti con le lettere A, B e C, e i dischi con i numeri da 1 (il più piccolo) a n (il più grande). I passi necessari sono:
 - Spostare i primi n-1 dischi da A a B. (Questo lascia il disco n da solo sul paletto A)
 - Spostare il disco n da A a C
 - Spostare n-1 dischi da B a C
Per spostare n dischi si richiede di compiere un'operazione elementare (spostamento di un singolo disco) ed una complessa, ossia lo spostamento di n-1 dischi. Tuttavia anche questa operazione si risolve nello stesso modo, richiedendo come operazione complessa lo spostamento di n-2 dischi. Iterando questo ragionamento si riduce il processo complesso ad uno elementare, ovvero lo spostamento di n - (n-1) = 1 disco.
Questo algoritmo ha una complessità esponenziale.
Si può dimostrare che la Torre di Hanoi è risolvibile per qualsiasi valore di "n".

La seguente funzione risolve il problema della torre di hanoi:

(define (solve-hanoi n from to using)
  (cond ((> n 0)
         (solve-hanoi (- n 1) from using to)
         (println "da " from " a " to)
         (solve-hanoi (- n 1) using to from))
         (true nil)
  )
)

(solve-hanoi 3 1 3 2)
;-> da 1 a 3
;-> da 1 a 2
;-> da 3 a 2
;-> da 1 a 3
;-> da 2 a 1
;-> da 2 a 3
;-> da 1 a 3
;-> nil


------------------
Indovina il numero
------------------

Si tratta di un gioco con due giocatori, il primo pensa ad un numero da 1 a 100 (ad esempio 45).
Il secondo giocatore prova ad indovinare il numero (ad esempio con 40).
Il primo giocatore deve dire se il numero proposto è "uguale" (fine del gioco) "maggiore" (bigger) o "minore" (smaller) del numero che pensato. A questo punto il secondo giocatore propone un nuovo numero, il primo risponde e si continua in questo modo fino a quando non viene indovinato il numero pensato.
Scrivere un programma in cui il computer cerca di indovinare il numero da voi pensato.

(define (indovina-numero)
  (>> (+ small big))) ; restituisce il valore (small + big)/2

(define (smaller)
  (setf big (dec (indovina-numero)))
  (indovina-numero))

(define (bigger)
  (setf small (inc (indovina-numero)))
  (indovina-numero))

(define (inizia-gioco)
  (setf small 1)
  (setf big 100)
  (indovina-numero))

Supponiamo di aver scelto il numero 80 e iniziamo il gioco:

(inizia-gioco)
;-> 50    ; il computer prova con 50
(bigger)  ; il nostro numero è più grande
;-> 75    ; il computer prova con 75
(bigger)  ; il nostro numero è più grande
;-> 88    ; il computer prova con 88
(smaller) ; il nostro numero è più piccolo
;-> 81    ; il computer prova con 88
(smaller) ; il nostro numero è più piccolo
;-> 78    ; il computer prova con 88
(bigger)  ; il nostro numero è più grande
;-> 79    ; il computer prova con 88
(bigger)  ; il nostro numero è più grande
;-> 80    ; il computer ha indovinato il nostro numero


----------------------
Il problema Monty Hall
----------------------

Si tratta di un gioco in cui vengono mostrate al concorrente tre porte chiuse. Dietro ad una si trova il premio, mentre ciascuna delle altre due sono vuote. Il giocatore può scegliere una delle tre porte, vincendo il premio corrispondente. Dopo che il giocatore ha selezionato una porta, ma non l'ha ancora aperta, il conduttore del gioco – che conosce ciò che si trova dietro ogni porta – apre una delle altre due, rivelando una delle due porte vuote, e offre al giocatore la possibilità di cambiare la propria scelta iniziale, passando all'unica porta restante.
Quale comportamento del giocatore (cambiare la porta o rimanere con la scelta iniziale) massimizza la probabilità di vincere il premio?
La soluzione può essere ottenuta in diversi modi (Teorema di Bayes, Diagrammi di Venn, Teorema della probabilità totale), ma noi cercheremo di risolvere il problema tramite la scrittura di funzioni che calcolano le probabilità delle diverse azioni.

Iniziamo con la funzione che cambia sempre la prima scelta:

(define (monty-cambiaporta n)
  (setq vincita 0)
  (dotimes (i n)
    (setq premio (+ 1 (rand 3)))      ; il premio si trova in 1 o 2 o 3
    (setq scelta (+ 1 (rand 3)))      ; la prima scelta vale 1 o 2 o 3
    ; se il premio è diverso dalla scelta, allora abbiamo vinto.
    ; Questo perchè abbiamo scelto sempre di cambiare la scelta con la porta che rimane.
    ; Ricorda che il conduttore elimina sempre una porta vuota,
    ; quindi se non abbiamo indovinato con la prima scelta, cambiando abbiamo sicuramente vinto.
    (if (!= premio scelta) (++ vincita))
  )
  (setq prob-vincita (mul (div vincita n) 100)) ; calcoliamo la percentuale di vincite
)

(monty-cambiaporta 10000)
;-> 66.25 ;il risultato teorico vale 2/3 = 0.666666 [66.66 %]

Adesso scriviamo la funzione che tiene sempre la prima scelta (non cambia mai la porta):

(define (monty-tieneporta n)
  (setq vincita 0)
  (dotimes (i n)
    (setq premio (+ 1 (rand 3)))      ; il premio si trova in 1 o 2 o 3
    (setq scelta (+ 1 (rand 3)))      ; la prima scelta vale 1 o 2 o 3
    ; se il premio è uguale alla scelta, allora abbiamo vinto.
    (if (= premio scelta) (++ vincita))
  )
  (setq prob-vincita (mul (div vincita n) 100)) ; calcoliamo la percentuale di vincite
)

(monty-tieneporta 10000)
;-> 33.42  ;il risultato teorico vale 1/3 = 0.333333 [33.33 %]

Teoricamente cambiare la porta migliora la probabilità del giocatore di vincere il premio, portandola da 1/3 a 2/3.


--------------------------
Il problema del compleanno
--------------------------

Considerando n persone, quanto vale la probabilità che due persone compiano gli anni nello stesso giorno?
Il problema del compleanno è stato formulato nel 1939 da Richard von Mises.

Per effettuare il calcolo, si ricorre alla formula per la probabilità condizionata con le seguenti ipotesi:
- gli anni sono tutti di 365 giorni
- i giorni dell'anno sono tutti equiprobabili

Il modo più semplice per calcolare la probabilità P(n) che ci siano almeno due persone di un gruppo di n persone che compiano gli anni lo stesso giorno è calcolare dapprima la probabilità P1(n) che ciò non accada. Il ragionamento è questo: data una qualunque persona del gruppo (indipendentemente dalla data del suo compleanno), vi sono 364 casi su 365 in cui il compleanno di una seconda persona avvenga in un giorno diverso, se si considera una terza persona, ci sono 363 casi su 365 in cui compie gli anni in un giorno diverso dalle prime due persone e via dicendo.
In formule, la probabilità che tutti gli n compleanni cadano in date diverse vale:

        364   363         365-n+1           364!
P1(n) = --- * --- * ... * ------- = ----------------------
        365   365           365     365^(n-1) * (365 - n)!

Quindi la probabilità del suo evento complementare, cioè che esistano almeno due compleanni uguali, vale:

                               364!
P(n) = 1 - P1(n) = 1 - ---------------------- =
                       365^(n-1) * (365 - n)!

Definiamo la funzione fattoriale (per i numeri big integer):

(define (fattoriale n)
  (setq fact 1L)
  (for (x 1L n)
    (setq fact (* fact x))
  );for end
)

La seguente funzione calcola il valore di x!/y! (con x > y)

(define (fattoriali-semplifica x y)
  (setq fact 1L)
  (for (i x (+ 1 y))
    (setq fact (* fact i))
  );for end
)

(fattoriali-semplifica 300 200)
;-> 38807387193016483645683371924167275439580023008808434498936549308160840242981998
;-> 71839239153657492092277838092154244528689124699666247577409105786352279708206119
;-> 37899469540337072285732213325595760757119468974039367680000000000000000000000000L

(/ (fattoriale 300) (fattoriale 200))
;-> 38807387193016483645683371924167275439580023008808434498936549308160840242981998
;-> 71839239153657492092277838092154244528689124699666247577409105786352279708206119
;-> 37899469540337072285732213325595760757119468974039367680000000000000000000000000L

(- (fattoriali-semplifica 300 200) (/ (fattoriale 300) (fattoriale 200)))
;-> 0L

Definiamo la funzione potenza (per i numeri big integer):

(define (potenza n m)
  (setq pot 1L)
  (dotimes (x m)
    (setq pot (* pot n))
  )
  pot
)

;-> 81402749386839761113321L

Adesso possiamo scrivere la funzione finale che calcola le probabilità del problema del compleanno:

(define (compleanno n)
  (setq num (fattoriali-semplifica 364 (- 365 n)))
  (setq den (potenza 365 (- n 1)))
  (sub 1 (div num den))
)

Più concisamente:

(define (compleanno n)
  (sub 1 (div (fattoriali-semplifica 364 (- 365 n)) (potenza 365 (- n 1))))
)

(compleanno 22)
0.4756953076625502

(compleanno 23)
;-> 0.5072972343239853

(compleanno 30)
;-> 0.7063162427192686

(compleanno 50)
;-> 0.9703735795779884

(compleanno 100)
;-> 0.9999996927510721

I risultati ci dicono che la probabilità che almeno due persone in un gruppo compiano gli anni lo stesso giorno è molto superiore a quanto si potrebbe pensare intuitivamente:
infatti già con 23 persone la probabilità è circa 0.51,
con 30 persone essa supera 0.70,
con 50 persone arriva addirittura a 0.97,
con 100 persone siamo quasi sicuri 0.99999969.
(comunque per ottenere l'evento certo (1) occorre considerare un gruppo di almeno 366 persone)


----------------------
Algoritmo di Karatsuba
----------------------

L'algoritmo di Karatsuba (1960) è un algoritmo di moltiplicazione rapida per moltiplicare numeri interi. La sua complessità è  O(n^log2(3)) (circa O(n^1.585)) mentre la complessità della moltiplicazione normale vale O(n^2). Il metodo di Karatsuba è asintoticamente molto più veloce.

Prendiamo due numeri, x e y.
Esempio: 12345 e 6789.
Troviamo una base b e potenza m per separarli.
Usiamo la base = 10 con m che vale la metà della lunghezza delle cifre dei numeri.
In questo caso, m sarà 2, quindi 10 ^ 2 = 100. Divideremo i 2 numeri usando questo moltiplicatore.
La forma che vogliamo è:

x = x1*b^m + x0
y = y1*b^m + y0

Utilizzando l'esempio:

x1 = 123
x0 = 45

y1 = 67
y2 = 89

b = 10 e m = 2

Quindi:

12345 = 123 * 10^2 + 45
6789 = 67 * 10^2 + 89

L'algoritmo ricorsivo è il seguente:

Se x < 10 o y < 10, restituire x * y. La moltiplicazione a una cifra è il caso base.
Altrimenti:
Sia z2 = karatsuba(x1, y1). x1 e y1 sono le cifre più significative (le variabili locali "alte").
Sia z0 = karatsuba(x0, y0). x0 e y0 sono le cifre meno significative (le variabili locali "basse").
Sia z1 = karatsuba (x1 + y0, x0 + y1) - z0 - z2.

E il risultato è la seguente somma: z2 * b^2m + z1 * b^m + z0

Definiamo la funzione potenza per i numeri interi:

(define (potenza n m)
  (let (pot 1L) (dotimes (x m) (setq pot (* pot n))))
)

(potenza 3 6)
;-> 729L

Definiamo la funzione che implementa l'algoritmo di karatsuba:

(define (karatsuba num1 num2)
  (local (m m2 high1 low1 high2 low2 z0 z1 z2)
    (cond ((or (< num1 10) (< num2 10)) (* num1 num2))
          (true
            (setq m (max (length (string num1)) (length (string num2))))
            (setq m2 (/ m 2))
            (setq n1$ (string num1))
            (setq n2$ (string num2))
            (setq high1 (int (slice n1$ 0 (- (length n1$) m2))))
            (setq low1  (int (slice n1$ (- (length n1$) m2) m2)))
            (setq high2 (int (slice n2$ 0 (- (length n2$) m2))))
            (setq low2  (int (slice n2$ (- (length n2$) m2) m2)))
            ;(println high1 { } low1)
            ;(println high2 { } low2)
            (setq z0 (karatsuba low1 low2))
            (setq z1 (karatsuba (+ low1 high1) (+ low2 high2)))
            (setq z2 (karatsuba high1 high2))
            (+ (* z2 (potenza 10 (* m2 2))) (* (- z1 z2 z0) (potenza 10 m2)) z0)
          )
    )
  );local
)

(karatsuba 12 12)
;-> 144

(karatsuba 13 17)
;-> 221

(karatsuba 120 11)
;-> 1320

(karatsuba 12345 6789)
;-> 83810205

(mul 12345 6789)
;-> 83810205

(time (karatsuba 12345 6789) 10000)
;-> 359.359

Ecco un'altra implementazione dell'algoritmo di Karatsuba:

(define (karatsuba x y)
    (karatsuba1 x y 256)  ; in generale, opportuna potenza di 2 p (x , y < 2p)
)

(define (karatsuba1 x y p)  ; x, y, p: interi non negativi, p potenza di 2
    (if (= p 1)
        (* x y)
        (let ((x1 (/ x p)) (x0 (% x p))
              (y1 (/ y p)) (y0 (% y p))
              (q (/ p 2)))
          (let ((z2 (karatsuba1 x1 y1 q))
                (z0 (karatsuba1 x0 y0 q)))
            (let ((z1 (- (karatsuba1 (+ x1 x0) (+ y1 y0) q) (+ z2 z0))))
              (+ (* z2 p p) (* z1 p) z0)
            )
          )
        )
     )
)

(karatsuba 12 12)
;-> 144

(karatsuba 12345 6789)
;-> 83810205

(time (karatsuba 12345 6789) 10000)
;-> 33347.174

Nota:
Nel caso di rappresentazioni binarie le operazioni di quoziente e prodotto relativi a una potenza di 2 (2^k) si riducono semplicemente a spostamenti (right/left shift) di k cifre.
Analogamente, il resto della divisione per 2^k corrisponde alla selezione delle ultime k cifre.

Per implementare l'algoritmo anche per i numeri big integer dobbiamo tenere conto del carattere "L" al termine di ogni numero intero big integer.

(define (karatsuba num1 num2)
  (local (len1 len2 m m2 high1 low1 high2 low2 z0 z1 z2)
    (cond ((or (< num1 10) (< num2 10)) (* num1 num2))
          (true
            (setq len1 (length (string num1)))
            (if (= (last (string num1)) "L") (-- len1))
            (setq len2 (length (string num2)))
            (if (= (last (string num1)) "L") (-- len2))
            (setq m (max len1 len2))
            (setq m2 (/ m 2))
            (setq n1$ (string num1))
            (if (= (last n1$) "L") (setq n1$ (chop n1$)))
            (setq n2$ (string num2))
            (if (= (last n2$) "L") (setq n2$ (chop n2$)))
            (setq high1 (bigint (slice n1$ 0 (- (length n1$) m2))))
            (setq low1  (bigint (slice n1$ (- (length n1$) m2) m2)))
            (setq high2 (bigint (slice n2$ 0 (- (length n2$) m2))))
            (setq low2  (bigint (slice n2$ (- (length n2$) m2) m2)))
            ;(println high1 { } low1)
            ;(println high2 { } low2)
            (setq z0 (karatsuba low1 low2))
            (setq z1 (karatsuba (+ low1 high1) (+ low2 high2)))
            (setq z2 (karatsuba high1 high2))
            (+ (* z2 (potenza 10 (* m2 2))) (* (- z1 z2 z0) (potenza 10 m2)) z0)
          )
    )
  );local
)

(karatsuba 12345 6789)
;-> 83810205

(karatsuba 9223372036854775807 9223372036854775807)
;-> 85070591730234615847396907784232501249L

(* 9223372036854775807L 9223372036854775807L)
;-> 85070591730234615847396907784232501249L

(time (karatsuba 12345 6789) 10000)
;-> 687.468

La funzione per i big integer è veloce la metà della versione per interi.


-------------------------------
Formati A0, A1, A2, A3, A4, ...
-------------------------------

Formato A0:
Similitudine rettangoli:   s(1)/s(0) = s(2)/s(1) = s(0)/2s(1)
Superficie convenzionale:  s(0)*s(1) = A(0) = 1 mq = 10000 cmq

Lato maggiore formato A0 in cm:
(setq s0 (mul 100 (pow 2 (div 1 4))))
;-> 118.9207115002721

Lato minore formato A0 in cm:
(setq s1 (mul 100 (pow 2 (div -1 4))))
;-> 84.08964152537145

Lato maggiore dei fogli in formato Ak:  s(k)

  s(k+2) = s(k) / 2
  s(0) = s0 = 118.9207115002721
  s(1) = s1 = 84.08964152537145

(define (lato k)
; lato: numero reale (misura lato)
; k: numero naturale (indice formato)
    (if (< k 2)
        (if (= k 0) s0 s1)      ; misure conosciute
        (div (lato (- k 2)) 2)  ; piegando due volte la lunghezza dei lati si dimezza
    )
)

(define (formato k)
  (local (s0 s1)
    (setq s0 (mul 100 (pow 2 (div 1 4))))
    (setq s1 (mul 100 (pow 2 (div -1 4))))
    (list (lato (+ k 1)) (lato k))
  )
)

Esempio: lati formato A4
(formato 4)
;-> (21.02241038134286 29.73017787506803)

Esempio: lati formato A2
(formato 2)
;-> (42.04482076268572 59.46035575013605)

Esempio: lati formato A0
(formato 0)
;-> (84.08964152537145 118.9207115002721)


-----------------------------------
Moltiplicazione del contadino russo
-----------------------------------

Si esegue per mezzo di raddoppi e dimezzamenti successivi.
Esempio: 83*154. Si dimezza il numero 83 (considerando i valori interi) e si raddoppia il 154. Si sommano le righe della colonna del 154 corrispondenti alle righe dispari nella colonna del numero 83. Totale: 12782.

      dispari  -->  83  |   154  <--
      dispari  -->  41  |   308  <--
                    20  |   616
                    10  |  1232
      dispari  -->   5  |  2464  <--
                     2  |  4928
      dispari  -->   1  |  9856  <--
                         -------
154 + 308 + 2464 + 9856 = 12782

(* 83 154)
;-> 12782

(+ 154 308 2464 9856)
;-> 12782

;; Algoritmo del contadino Russo per la moltiplicazione:

(define (moltiplicazione-russa a b)
  (molt-russa a b 0L))

(define (molt-russa x y z)
    (cond ((= y 0) z)
          ((even? y) ; y pari
           (molt-russa (* 2L x) (/ y 2L) z))
          (true      ; y dispari
           (molt-russa (* 2L x) (/ y 2L) (+ z x))
          )
    ) ; valore risultante: z + xy
)

(moltiplicazione-russa 12 12)
;-> 144L

(moltiplicazione-russa 12345 6789)
;-> 83810205L

(moltiplicazione-russa 12345232332323 6782323232323239)
;-> 83729356055942287981803754197L

(time (moltiplicazione-russa 12345232332323 6782323232323239) 100000)
;-> 2406.6

Notiamo che la nostra funzione è ricorsiva di coda, quiondi possiamo usare la tecnica di "memoization":

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(define (moltiplicazione-russa-m a b)
  (molt-russa-m a b 0L))

(memoize molt-russa-m (lambda (x y z)
    (cond ((= y 0L) z)
          ((even? y) ; y pari
           (molt-russa-m (* 2L x) (/ y 2L) z))
          (true      ; y dispari
           (molt-russa-m (* 2L x) (/ y 2L) (+ z x))
          )
    ) ; valore risultante: z + xy
))

(moltiplicazione-russa-m 12 12)
;-> 144L

(moltiplicazione-russa-m 12345 6789)
;-> 83810205L

(moltiplicazione-russa-m 12345232332323 6782323232323239)
;-> 83729356055942287981803754197L

(time (moltiplicazione-russa-m 12345232332323 6782323232323239) 100000)
;-> 328.118

Con la tecnica di memoization la nostra funzione è diventata 7 volte più veloce.

Vediamo la velocità della funzione primitiva di addizione "*":

(* 12345232332323L 6782323232323239)
;-> 83729356055942287981803754197L

(time (* 12345232332323L 6782323232323239) 100000)
;-> 91.905


---------------------
Distanza di Manhattan
---------------------

Date le coordinate di due punti su una griglia (scacchiera), determinare la loro distanza minima (distanza di manhattan) e il numero di percorsi tra i due punti con distanza minima.
È possibile muoversi solo lungo gli assi x e y (solo in verticale e in orizzontale, non in diagonale)

Esempio:

Punto A = (ax,ay) = (4,3)
Punto B = (bx,by) = (2,1)

 4 +--+--+--+--+--+
   |  |  |  |  |  |
 3 +--+--+--+--A--+
   |  |  |  |  |  |
 2 +--+--+--+--+--+
   |  |  |  |  |  |
 1 +--+--B--+--+--+
   |  |  |  |  |  |
 0 +--+--+--+--+--+
   0  1  2  3  4  5

distanza di manhattan = somma del valore assoluto delle differenze delle coordinate.
distanza di manhattan = abs(bx - ax) + abs(by - ay)
distanza di manhattan = (+ (abs (- 2 4)) (abs (- 1 3))) = 4

Quanti percorsi esistono che vanno da A a B e hanno lunghezza 4?

Notiamo che la distanza è simmetrica, cioè dist(A,B) = dist(B,A), quindi possiamo supporre di spostarci solo verso "destra" e verso l'"alto".
Quello che ci interessa è la distanza tra le coordinate:
dist(x) = abs(bx-ax) = 2
dist(y) = abs(by-ay) = 2

Adesso scriviamo una funzione ricorsiva che utilizza questi valori di distanza per calcolare il numero totale dei percorsi minimi tra i due punti.
Poichè ogni volta ci dobbiamo muovere a destra o verso l'alto possiamo richiamare la stesse funzioni con uno dei parametri (destra o alto) diminuito di 1. Queste funzioni vengono chiamate tante volte quanto vale la distanza tra le coordinate. Facendo la somma di queste funzioni otteniamo il numero di percorsi minimi.

La funzione ricorsiva per il calcolo dei percorsi è la seguente:

(define (percorsi-manhattan alto destra);
    (if (or (= alto 0) (= destra 0)) 1
        (+ (percorsi-manhattan (- alto 1) destra)
           (percorsi-manhattan alto (- destra 1)))
    )
)

(percorsi-manhattan 2 2)
;-> 6

(define (manhattan x1 y1 x2 y2)
  (list
    (+ (abs (- x2 x1)) (abs (- y2 y1)))
    (percorsi-manhattan (abs (- x2 x1)) (abs (- y2 y1)))
  )
)

(manhattan 4 3 2 1)
;-> (4 6)

(manhattan 1 1 10 10)
;-> (18 48620)


-------------------------------------------------
Modello di crescita di una popolazione di conigli
-------------------------------------------------

Questo modello è stato discusso nel libro "Liber Abbaci" di Leonardo Pisano (Fibonacci) scritto nell'anno 1202.

- All'istane iniziale t=0 c'e' una coppia di conigli fertili
- I conigli nati all'istante t diventano fertili esattamente dopo un mese, all'istante t+1
- Una coppia di conigli fertile all'istante t genera una nuova coppia di conigli ad ogni mese successivo t+1, t+2, ...
- I conigli non muoiono nell'intervallo di tempo considerato
- I conigli nascono sempre a coppie: un maschio e una femmina.

Quante coppie di conigli ci saranno dopo un anno?

Stiamo parlando del numero di Fibonacci:

(define (coppie-fertili n)       ; valore: naturali
    (if (= n 0) 1
        (+ (nascita-nuove-coppie (- n 1)) (coppie-fertili (- n 1)))
    )
)

(define (nascita-nuove-coppie n)
    (if (= n 0) 0
        (coppie-fertili (- n 1))
    )
)

(for (x 1 10) (print (coppie-fertili x) { }))
;-> 1 2 3 5 8 13 21 34 55 89

Il numero di conigli al mese x è dato da C(x+1) (dove C è la funzione coppie-fertili):

(define (num-conigli mese)
  (coppie-fertili (add mese 1)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2 3 5 8 13 21 34 55 89 144 233 377

(time (num-conigli 35)) ;24157817
;-> 14656.997 ;14.7 secondi

La funzione è lenta possiamo utilizzare la macro "memoize" oppure scrivere una funzione iterativa. Vediamo entrambi i casi per la formula di Fibonacci: F(n+2) = F(n+1) + F(n)

Versione memoized:

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(define (num-conigli mese)
  (fibo-m (add mese 2)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L

(num-conigli 35)
;-> 24157817L

(time (num-conigli 35))
;-> 0

Versione iterativa:

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 n)
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(define (num-conigli mese)
  (fibo-i (add mese 1)))

(for (x 1 12) (print (num-conigli x) { }))
;-> 2L 3L 5L 8L 13L 21L 34L 55L 89L 144L 233L 377L

(num-conigli 35)
;-> 24157817L

(time (num-conigli 35))
;-> 0

Con la versione iterativa il calcolo è immediato.


---------------
The Game of Pig
---------------

Il gioco è stato inventato da John Scarne nel 1945.
Ad ogni turno, ogni giocatore lancia ripetutamente un dado finché non viene tirato un 1 o il giocatore decide di "passare":
Se il giocatore lancia un 1, il punteggio del turno è nullo e passa la mano al prossimo giocatore.
Se il giocatore lancia un altro numero (2..6), il numero viene aggiunto al punteggio del turno  e il turno del giocatore continua.
Se un giocatore decide di "passare", il suo punteggio del turno viene aggiunto al suo punteggio totale, e diventa il turno del prossimo giocatore.
Vince il giocatore che arriva o supera 100 (poichè il turno deve terminare per tutti i giocatori, potrebbero esserci più giocatori che superano 100, allora il vincitore è quello con il punteggio più alto).

Esempio:

Turno |  Player | punteggio Turno | punteggio Totale
----------------------------------------------------
1     |  A      | (2-2-3-5) 12    | 12
1     |  B      | (2-4-5-1)  0    |  0
2     |  A      | (6-1)      0    | 12
2     |  B      | (3-4-4)   11    | 11
3     |  A      | (3-4-2)    9    | 21
3     |  B      | (3-4)      7    | 18
4     |  ...    | ...       ...   | ...

Quale strategia massimizza le probabilità di vittoria ?

Quanto vale il valore medio dei punti ottenuti prima che esca un 1 ?

La seguente funzione crea una lista con n elementi del tipo (lanci totale):

(define (mediaVal n)
  (local (freq tot val lanci continua)
    (setq freq '())
    (for (i 0 n)
      (setq continua true)
      (setq tot 0)
      (setq val 0)
      (setq lanci 0)
      (while continua
        (setq val (add (rand 6) 1))
        (++ lanci)
        (if (= val 1)
          (begin
            (setq continua nil)
            (push (list lanci tot) freq -1)
          )
          (setq tot (add tot val))
        )
      )
    )
    freq
  )
)

(mediaVal 10)
;-> ((2 6) (7 25) (3 8) (3 9) (6 18) (4 15) (5 17) (2 6) (12 40) (2 5) (8 32))

Creiamo una lista con 100000 elementi:

(silent (setq f (mediaVal 100000)))

Analizziamo il risultato:

Numero totale di lanci:
(apply add (map first f))
;-> 600613 ;numero totale di lanci

Numero medio di lanci:
(div (apply add (map first f)) (length f))
;-> 6.006 ;numero medio di lanci

Punteggio totale:
(apply add (map last f))
;-> 2003171 ;punteggio totale

Punteggio medio per ogni turno:
(div (apply add (map last f)) (length f))
;-> 20.03 ;punteggio medio per ogni turno

Adesso scriviamo un programma che simula "The game of Pig":

(define (pigs n maxvalA maxlanciA maxvalB maxlanciB)
  (local (res vittA vittB)
    (setq vittA 0 vittB 0)
    (for (i 0 n)
      (setq res (game maxvalA maxlanciA maxvalB maxlanciB))
      (if (= res "A")
        (++ vittA)
        (++ vittB)
      )
    )
    (list vittA vittB)
  )
)

Vediamo la funzione che simula una partita tra due giocatori A e B. Con i parametri possiamo stabilire per ogni giocatore:
1) il numero massimo di lanci per ogni giocata (maxlanci)
2) il valore massimo per ogni giocata (maxval)
In questo modo possiamo variare la strategia dei giocatori per definire quale sia la migliore.

(define (game maxvalA maxlanciA maxvalB maxlanciB)
  (local (totA totB parA parB valA valB playgame continua)
    (setq totA 0 totB 0)
    ; "playgame" controlla il termine di una partita
    (setq playgame true)
    ; "playgame" diventa nil quando uno dei due giocatori ha superato i 100 punti
    (while playgame
      ; player A
      (setq parA 0)
      (setq lanciA 0)
      ; "continua" controlla se la giocata del giocatore è terminata
      ; "continua" diventa nil se:
      ; esce un 1 OR
      ; il giocatore ha raggiunto il numero massimo di lanci OR
      ; il giocatore ha raggiunto il valore massimo
      (setq continua true)
      (while continua
        ; lancio del dado
        (setq valA (add (rand 6) 1))
        (++ lanciA)
        (if (= valA 1)
          (begin ; è uscito 1
            ; annullo il punteggio parziale
            (setq parA 0)
            ; tocca al giocatore B
            (setq continua false)
          )
          (begin ; non è uscito 1 (2..6)
            ;aggiorno punteggio parziale A
            (setq parA (add parA valA))
          )
        )
        ;(println "valA = " valA { } "parA = " parA { } "lanciA = " lanciA)
        ;(println "totA = " totA)
        ;(read-key)
        ; controllo superamento max lanci
        (if (>= lanciA maxlanciA) (setq continua false))
        ; controllo superamento max lanci
        (if (>= parA maxvalA) (setq continua false))
      )
      ; aggiorno punteggio totale A
      (setq totA (add totA parA))
      ;(println "totA = " totA)
      ; controllo fine del gioco
      (if (> totA 100) (setq playgame false))
      ;--------------------------------------------
      ; player B
      (setq parB 0)
      (setq lanciB 0)
      ; "continua" controlla se la giocata del giocatore è terminata
      ; "continua" diventa nil se:
      ; esce un 1 OR
      ; il giocatore ha raggiunto il numero massimo di lanci OR
      ; il giocatore ha raggiunto il valore massimo
      (setq continua true)
      ;(while (and continua playgame) ;B non gioca l'ultimo turno
      (while continua
        ; lancio del dado
        (setq valB (add (rand 6) 1))
        (++ lanciB)
        (if (= valB 1)
          (begin ; è uscito 1
            ; annullo il punteggio parziale
            (setq parB 0)
            ; tocca al giocatore A
            (setq continua false)
          )
          (begin ; non è uscito 1 (2..6)
            ;aggiorno punteggio parziale B
            (setq parB (add parB valB))
          )
        )
        ;(println "valB = " valB { } "parB = " parB { } "lanciB = " lanciB)
        ;(println "totB = " totB)
        ;(read-key)
        ; controllo superamento max lanci
        (if (>= lanciB maxlanciB) (setq continua false))
        ; controllo superamento max lanci
        (if (>= parB maxvalB) (setq continua false))
      )
      ; aggiorno punteggio totale B
      (setq totB (add totB parB))
      ;(println "totB = " totB)
      ; controllo fine del gioco
      (if (> totB 100) (setq playgame false))
      ;(println totA { } totB)
    );while playgame
    ; determino il vincitore
    (if (> totA totB) "A" "B")
  )
)

(game 100 2 20 2)
;-> "B"

Giochiamo con i parametri (maxvalA maxlanciA maxvalB maxlanciB):

(pigs 100000 100 8 100 8)
;-> (49811 50190)
(pigs 100000 100 8 20 4)
;-> (45632 54369)
(pigs 100000 20 8 20 4)
;-> (56483 43518)
(pigs 100000 20 5 20 4)
;-> (53505 46496)
(pigs 100000 50 8 20 4)
;-> (45734 54267)
(pigs 100000 30 8 20 4)
;-> (46641 53360)
(pigs 100000 20 20 20 4)
;-> (56520 43481)
(pigs 100000 20 20 20 100)
;-> (49661 50340)
(pigs 100000 30 5 20 5)
;-> (49904 50097)
(pigs 100000 20 10 20 3)
;-> (66592 33409)
(pigs 100000 25 12 20 10)
;-> (50046 49955)
(pigs 100000 30 15 20 10)
;-> (38903 61098)
(pigs 100000 20 10 21 15)
;-> (51128 48873)
(pigs 100000 25 12 25 12)
;-> (49668 50333)
(pigs 1000000 25 12 25 12)
;-> (497380 502621)

Come si vede sembra che utilizzando 20 e 25 come valori massimi per ogni giocata (maxval) si massimizzano la probabilità di vittoria. Dalle prove effettuate sembra che 25 sia leggermente migliore che 20.
L'articolo "Practical Play of the Dice Game Pig" di Neller e Presser:
http://cs.gettysburg.edu/~tneller/papers/umap10.pdf
affronta il gioco matematicamente e raggiunge le stesse conclusioni: il numero 20 e il numero 25 massimizzano le probabilità di vittoria.


------------------
Il gioco dei salti
------------------

Dato una lista di numeri interi non negativi, si è inizialmente posizionati nel primo indice della lista. Ogni elemento della lista rappresenta la massima lunghezza di salto in avanti da quella posizione. La funzione deve restituire il numero minimo di passi per raggiungere la fine della lista oppure "nil" se non è possibile raggiungere la fine della lista (cioè l'ultimo indice).
Ad esempio:
A = (2 3 1 1 4) restituisce 2.
A = (3 2 1 0 4) restituisce falso.
A = (3 2 2 0 4) restituisce true.

Dobbiamo calcolare l'indice massimo che può essere raggiunto.
Possiamo avere due casi:
1) dalla posizione attuale non è possibile raggiungere la prossima posizione
2) dalla posizione attuale è possibile raggiungere la prossima posizione (in questo caso occorre controllare se abbiamo raggiunto la fine della lista).
Dalla posizione "i" l'indice più grande che può essere raggiunto vale: i + A(i).

Ecco un esempio
idx 0 1 2 3 4
A   3 2 1 0 4
max 3 3 3 0

(define (salto? lst)
  (local (lun idxMax passi)
    (cond ((<= (length lst) 1) 0) ;siamo già alla fine della lista
          (true
           (setq idxMax (lst 0))
           (setq passi 0)
           (setq lun (length lst))
           (for (i 0 (sub lun 1) 1 (or (and (<= idxMax i) (= (lst i) 0)) (>= idxMax (sub lun 1))))
              (if (> (add i (lst i)) idxMax)
                (begin
                ; aggiorno idxMax e passi
                  (setq idxMax (add i (lst i)))
                  (setq passi (add passi 1)))
              )
           )
           ; controllo della posizione finale
           (if (>= idxMax (sub lun 1))
               (setq passi (add passi 1))
               nil
           )
          );true
     );cond
  );local
)

Da notare l'espressione (or (and (<= idxMax i) (= (lst i) 0)) (>= idxMax (sub lun 1))) che fa uscire dal ciclo for quando:

(and (<= idxMax i) (= (lst i) 0)) non possiamo procedere e non abbiamo raggiunto la fine

oppure

(>= idxMax (sub lun 1)) siamo arrivati alla fine della lista.

(salto? '(2 3 1 1 4))
;-> 2
(salto? '(3 2 1 0 4))
;-> nil
(salto? '(3 2 2 0 4))
;-> 2
(salto? '(1 2 3 0 5))
;-> 3
(salto? '(6 2 3 0 0 0 1 5))
;-> 2
(salto? '(1 2 5 1 1 1 1 1))
;-> 3


--------------------------------------------
Ricerca stringa in un testo (algoritmo base)
--------------------------------------------

Dato un testo e una stringa (pattern), scrivere una funzione che ritorna gli indici di tutte le occorrenze della stringa contenute nel testo.
Si può presumere che il testo sia più lungo della stringa.
Esempi:
Input:  txt [] = "TESTO DI PROVA"
        str [] = "TEST"
Output: (0)

Input: txt [] = "OOHOOXOOWOOHOOHO"
       str [] = "OOHO"
Output: (0 9 12)

Questo algoritmo viene chiamato "naive pattern searching":
Facciamo scorrere la stringa (pattern) sul testo carattere per carattere per verificarne la corrispondenza. Se viene trovata una corrispondenza, scorriamo in avanti di uno per ricercare le occorrenze successive.

(define (trova pattern testo)
  (local (m n j out)
    (setq out '())
    (setq m (length pattern))
    (setq n (length testo))
    ; ciclo per far scorrere il pattern carattere per carattere
    (for (i 0 (sub n m))
      ; dall'indice corrente i, verifico la corrispondenza del pattern sul testo
      (setq j 0)
      (while (and (< j m) (= (testo (add i j)) (pattern j)))
        (++ j)
      )
      ;(if (= j m) (println i))
      ; se ho trovato una corrispondenza, aggiorno il risultato
      (if (= j m) (push i out -1))
    )
    out
  );local
)

(trova "TEST" "TEST: TESTO DI PROVA")
;-> (0 6)

(trova "OOHO" "OOHOOXOOWOOHOOHO")
;-> (0 9 12)

(trova "aba" "abababababa")
;-> (0 2 4 6 8)

Qual è il caso migliore?
Il caso migliore si verifica quando il primo carattere del pattern non è presente nel testo.
txt [] = "AABCCAADDEE";
pat [] = "FAA";
Il numero di confronti nel migliore dei casi è O(n).

Qual è il caso peggiore?
Il caso peggiore si verifica nei seguenti scenari.
1) Quando tutti i caratteri del testo e del pattern sono uguali.
txt [] = "AAAAAAAAAAAAAAAAAA";
pat [] = "AAAAA";
2) Il caso peggiore si verifica anche quando solo l'ultimo carattere è diverso.
txt [] = "AAAAAAAAAAAAAAAAAB";
pat [] = "AAAAB";
Il numero di confronti nel caso peggiore è O(m*(n-m+1)).

Nei testi italiani le lettere ripetute sono improbabili, ma questo potrebbero verificarsi in altri casi (ad esempio nei testi binari).


-----------------------------------------
Ricerca stringa in un testo (algoritmo Z)
-----------------------------------------

Questo algoritmo trova tutte le occorrenze di una stringa (pattern) in un testo in tempo lineare. Sia "n" la lunghezza del testo, sia "m" quella del pattern, quindi il tempo totale impiegato è O(m+n) con complessità dello spazio lineare. La complessità di tempo e spazio è uguale all'algoritmo KMP, ma questo algoritmo è più semplice da capire.
In questo algoritmo, costruiamo una lista Z.
Cos'è la lista Z?
Per una stringa str[0..n-1], la lista Z ha la stessa lunghezza della stringa. Un elemento Z[i] di Z memorizza la lunghezza della sottostringa più lunga che inizia da str[i] che è anche un prefisso di str[0..n-1]. La prima voce dell'array Z non ha significato in quanto la stringa completa è sempre prefisso di se stessa.

Esempio:
Indice           0   1   2   3   4   5   6   7   8   9  10  11
Testo            a   a   b   c   a   a   b   x   a   a   a   z
Z Valori         x   1   0   0   3   1   0   0   2   2   1   0

Altri esempi:
str = "aaaaaa"
Z = (x 5 4 3 2 1)

str = "aabaacd"
Z = (x 1 0 2 1 0 0)

str = "abababab"
Z = (x 0 6 0 4 0 2 0)

In che modo la lista Z è utile nella ricerca di pattern in tempo lineare?
L'idea è quella di concatenare pattern e testo e creare una stringa "P$T" dove P è il pattern, $ è un carattere speciale che non deve essere presente nel pattern e nel testo, e T è il testo. Costruire la lista Z per la stringa concatenata. Nella lista Z, se il valore Z in qualsiasi punto è uguale alla lunghezza del pattern, allora il pattern è presente in quel punto.

Esempio:
Pattern P = "aab",  Testo T = "baabaa"

La stringa concatenata vale = "aab~baabaa"

La lista Z per la stringa concatenata vale (x 1 0 0 0 3 1 0 2 1).
Poichè la lunghezza del pattern vale 3, il valore 3 presente nella lista Z indica che il pattern si trova nel testo.

Come costruire la lista Z?
Una soluzione semplice è costituita da due cicli annidati, il ciclo esterno percorre ogni indice e il ciclo interno trova la lunghezza del prefisso più lungo che corrisponde (match) alla sottostringa che inizia con l'indice corrente. La complessità temporale di questa soluzione è O(n^2).
Possiamo costruire la lista Z in tempo lineare.
L'idea è di mantenere un intervallo [L, R] che è l'intervallo con Rmax tale che [L, R] è una sottostringa di prefisso (sottostringa che è anche prefisso).

I passaggi per mantenere questo intervallo sono i seguenti:

1) Se i > R allora non esiste una sottostringa di prefisso che inizi prima di e termina dopo i, quindi ripristiniamo L e R e calcoliamo nuovo [L, R] confrontando str [0 ..] in str [i ..] e ottenendo Z [i] (= R-L + 1).

2) Se i <= R allora lascia K = i-L, ora Z[i] >= min(Z[K], R-i+1) perché str[i ..] corrisponde a str[K ..] per almeno R-i+1 caratteri (essi si trovano nell'intervallo [L, R] che sappiamo essere una sottostringa di prefisso).
Ora bisogna trattare due sottocasi:

a) Se Z[K] < R-i+1 allora non esiste una sottostringa di prefisso a partire da str[i] (altrimenti Z[K] sarebbe più grande) quindi Z[i] = Z[K] e l'intervallo [L, R] rimane lo stesso.

b) Se Z[K] >= R-i+1, allora è possibile estendere l'intervallo [L, R], quindi imposteremo L come i e inizieremo il controllo della corrispondenza da str[R] in poi per calcolare una nuova R con cui aggiorneremo l'intervallo [L, R] e calcoleremo Z [i] (= R - L + 1).

Per una migliore comprensione della procedura, vedere la seguente animazione:
http://www.utdallas.edu/~besp/demo/John2010/z-algorithm.htm

L'algoritmo viene eseguito in tempo lineare perché non confrontiamo mai un carattere minore di R e con la corrispondenza aumentiamo R di uno, quindi ci sono al massimo T confronti. Nel caso di mancata corrispondenza, questa avviene solo una volta per ogni i (a causa della quale R si arresta), questo comporta al massimo T confronti, quindi la complessità totale rimane lineare.

La seguente funzione restituisce una lista di indici se il "pattern" (stringa) viene trovato nel "testo", altrimenti restituisce la lista vuota:

(define (trovaZ pattern testo)
  (local (concat ll Z out)
    (setq out '())
    ; Crea stringa concatenata "P~T"
    (setq concat (append pattern "~" testo))
    (setq ll (length concat))
    (setq Z (dup  0 ll))
    ; Costruisce la lista array
    (setq Z (creaZlista concat Z))
    ; Loop sulla lista Z per cercare i match
    (for (i 0 (sub ll 1))
      (if (= (Z i) (length pattern))
        ; aggiunge l'indice trovato al risultato
        (push (add i (- (length pattern)) (- 1)) out -1)
      )
    )
    out
  );local
)

; Crea la lista Z per la stringa str
(define (creaZlista str Z)
  (local (n L R k)
    (setq n (length str))
    ; [L,R] crea un a finestra che corrisponde con il prefisso di str
    (setq L 0 R 0)
    (for (i 0 (sub n 1))
      ; se i>R allora niente corrisponde,
      ; quindi calcoliamo Z[i] usando il metodo base.
      (if (> i R)
        (begin
          (setq L i R i)
          ; R-L = 0 all'inizio, per iniziare il controllo dall'indice 0.
          ; Per esempio, per "ababab" e i = 1,
          ; il valore di R rimane 0 e Z[i] diventa 0.
          ; Per la stringa "aaaaaa" e i = 1,
          ; Z[i] e R diventano 5
          (while (and (< R n) (= (str (sub R L)) (str R)))
            (++ R)
          )
          (setq (Z i) (sub R L))
          (-- R)
        )
        ;else
        ; k = i-L, in questo modo k è relativo al numero
        ; che corrisponde all'intervallo [L,R].
        (begin
          (setq k (sub i L))
          ; se Z [k] è inferiore all'intervallo rimanente
          ; allora Z [i] sarà uguale a Z [k].
          ; Ad esempio, str = "ababab", i = 3, R = 5 e L = 2
          (if (< (Z k) (add R (- i) 1))
              (setq (Z i) (Z k))
              ; Per esempio str = "aaaaaa" e i = 2, R vale 5,
              ; L vale 0
              ;else
              (begin
                (setq L i)
                (while (and (< R n) (= (str (sub R L)) (str R)))
                  (++ R)
                )
                (setq (Z i) (sub R L))
                (-- R)
              )
          )
        )
      );if
    );for
    Z
  );local
)

(trovaZ "max" "max is the maximum")
;-> (0 11)

(trovaZ "maxx" "max is the maximum")
;-> ()

(trovaZ "aba" "abababababa")
;-> (0 2 4 6 8)


-----------------------
Distanza di Levenshtein
-----------------------

La distanza di Levenshtein (LD) è una misura della somiglianza tra due stringhe A e B. La distanza è il numero di cancellazioni, inserimenti o sostituzioni richieste per trasformare A in B. Per esempio:

- se A è "pippo" e B è "pippo", le stringhe sono identiche e non sono necessarie trasformazioni, quindi LD (A, B) = 0

- se A è "pippo" e B è "pluto", allora LD (A, B) = 3, perché tre sostituzioni (modifica "i" in "l", "p" in "u" e "p" in "l" ) sono sufficienti per trasformare A in B.

Maggiore è la distanza di Levenshtein, minore è la somiglianza tra le stringhe.

L'algoritmo per il calcolo dell distanza di Levenshtein è stato inventato dal russo Vladimir Levenshtein nel 1965.

Questo algoritmo viene utilizzato per:
- Controllo ortografico
- Riconoscimento vocale
- Analisi del DNA
- Rilevamento di plagio

Algoritmo:
Passo | Descrizione
------|------------
   1  | Impostare n = lunghezza di A
      | Impostare m = lunghezza di B.
      | Se n = 0 e m = 0, restituire nil e uscire.
      | Se n = 0, restituire m e uscire.
      | Se m = 0, restituire n e uscire.
      | Costruire una matrice contenente 0..m righe e 0..n colonne (m + 1) x (n + 1).

   2  | Inizializzare la prima riga con l'intervallo dei valori 0..n.
      | Inizializzare la prima colonna con l'intervallo dei valori 0..m.

   3  | Esaminare ciascun carattere di s (i da 1 a n).

   4  | Esaminare ciascun carattere di t (j da 1 a m).

   5  | Se s [i] è uguale a [j], il costo è 0.
      | Se s [i] non è uguale a [j], il costo è 1.

   6  | Impostare la cella D[i, j] della matrice uguale al minimo di:
      | a. La cella immediatamente sopra più 1: D[i-1, j] + 1.
      | b. La cella immediatamente a sinistra più 1: D[i, j-1] + 1.
      | c. La cella diagonalmente sopra a sinistra più il costo: D[i-1, j-1] + costo.

   7  | Dopo le iterazioni dei passi (3, 4, 5, 6), la distanza si trova nella cella D[n,m].


Passi 1 e 2        Passi 3 -> 6 con i = 1      Passi 3 -> 6 con i = 2
    D U M B O           D U M B O                   D U M B O
  0 1 2 3 4 5         0 1 2 3 4 5                 0 1 2 3 4 5
D 1                D  1 0                      D  1 0 1
A 2                A  2 1                      A  2 1 1
M 3                M  3 2                      M  3 2 2
B 4                B  4 3                      B  4 3 3
O 5                O  5 4                      O  5 4 4
L 6                L  6 5                      L  6 5 5

                   Passi 3 -> 6 con i = 3      Passi 3 -> 6 con i = 4
                        D U M B O                   D U M B O
                      0 1 2 3 4 5                 0 1 2 3 4 5
                   D  1 0 1 2                  D  1 0 1 2 3
                   A  2 1 1 2                  A  2 1 1 2 3
                   M  3 2 2 1                  M  3 2 2 1 2
                   B  4 3 3 2                  B  4 3 3 2 1
                   O  5 4 4 3                  O  5 4 4 3 2
                   L  6 5 5 4                  L  6 5 5 4 3

                   Passi 3 -> 6 con i = 5     Passo 7  D[m, n] = 2
                        D U M B O                 D U M B O
                      0 1 2 3 4 5               0 1 2 3 4 5
                   D  1 0 1 2 3 4             D 1 0 1 2 3 4
                   A  2 1 1 2 3 4             A 2 1 1 2 3 4
                   M  3 2 2 1 2 3             M 3 2 2 1 2 3
                   B  4 3 3 2 1 2             B 4 3 3 2 1 2
                   O  5 4 4 3 2 1             O 5 4 4 3 2 1
                   L  6 5 5 4 3 2             L 6 5 5 4 3>2<

La distanza si trova nell'angolo in basso a destra della matrice, ovvero 2. Infatti "DUMBO" può essere trasformato in "DAMBOL" sostituendo "A" per "U" e aggiungendo "L" (una sostituzione e un inserimento = due modifiche).

Vediamo prima una versione ricorsiva:

(define (ld A B)
  (define (ld-aux A lstA B lstB)
    (cond ((zero? lstA) lstB)
          ((zero? lstB) lstA)
          (true
            (min (+ (ld-aux (rest A) (- lstA 1) B lstB) 1)
                 (+ (ld-aux A lstA (rest B) (- lstB 1)) 1)
                 (+ (ld-aux (rest A) (- lstA 1) (rest B) (- lstB 1))
                                 (if (= (first A) (first B)) 0 1))
            )
          )
    )
  );define
  (ld-aux (explode A) (length A) (explode B) (length B))
)

(ld "top" "do")
;-> 2

(ld "topo" "dopo")
;-> 1

(ld "mister" "mostro")
;-> 3

(ld "rosettacode" "raisethysword")
;-> 8

(time (ld "rosettacode" "raisethysword"))
;-> 166616.661 ; 167 secondi

Questa versione è molto lenta.

Adesso scriviamo una funzione iterativa:

(define (ld A B)
  (local (n m D costo)
    (setq n (length A))
    (setq m (length B))
    (setq D (array (add n 1) (add m 1)))
    (cond ((and (zero? n) (zero? m)) nil)
          ((zero? n) m)
          ((zero? m) n)
          (true
            (for (i 0 n) (setf (D i 0) i))
            (for (j 0 m) (setf (D 0 j) j))
            (for (i 1 n)
              (for (j 1 m)
                (if (= (A (sub i 1)) (B (sub j 1)))
                  (setq costo 0)
                  (setq costo 1)
                )
                (setf (D i j) (min (add (D (sub i 1) j) 1)
                                   (add (D i (sub j 1)) 1)
                                   (add (D (sub i 1) (sub j 1)) costo)))
              )
            )
          )
    );cond
    (D n m)
  );local
)

(ld "topo" "dopi")
;-> 2
(ld "top" "lo")
;-> 2
(ld "lo" "top")
;-> 2
(ld "mister" "mostro")
;-> 3
(ld "rosettacode" "raisethysword")
;-> 8
(time (ld "rosettacode" "raisethysword"))
;-> 1.002
(ld "massimo" "omissam")
;-> 4
(ld "massimiliano" (reverse "massimiliano"))
;-> 8
(ld "abcdefgh" (reverse "abcdefgh"))
;-> 8
(ld "newLISP" "Common LISP")
;-> 7

La distanza Levenshtein è stata utilizzata:
1. nell'implementazione di un calcolatore per la distanza tra matrici
2. per la valutazione percettiva delle misurazioni della distanza dialettale.
3. per la marcatura automatica di dettati musicali.
4. per la corrispondenza approssimativa nelle espressioni regolari.
5. per identificare se due sequenze genetiche hanno funzioni simili.
6. per filtrare blocchi di elenchi e-mail (indirizzi spam candidati) entro un valore soglia.
7. come esploratore per i nomi di bambini.
8. per nominare prodotti e servizi come domini, marchi, ecc.
9. per condurre ricerche fuzzy nel tuo ambiente preferito.
10. per i motori di ricerca spamdex - convertendo casualmente il testo in una serie di caratteri incomprensibili.
11. per i motori di ricerca che generano spam - aggiungendo sistematicamente le modifiche a testi validi.
12. come parte di una routine per il controllo ortografico.
13. per identificare contenuti duplicati e plagio.
14. come criterio di ordinamento.


--------------
Social Network
--------------

Due parole sono amiche se hanno una distanza di Levenshtein pari a 1.
Cioè, possiamo aggiungere, rimuovere o sostituire esattamente una lettera nella parola A per creare la parola B.
Il Social Network di una parola è composto da tutti i suoi amici, a cui vanno sommati gli amici dei suoi amici, a cui vanno sommati gli amici degli amici dei suoi amici e così via.
Scrivere un programma per trovare il Social Network di una parola utilizzando il file "nomi.txt" che contiene circa 9000 nomi italiani.

Dobbiamo avere una funzione che, dato un nome, genera tutti i suoi amici (cioè tutti i nomi che hanno distanza pari a uno) utilizzando il file "nomi.txt". Le seguenti due funzioni fanno proprio questo e sono state prese e adattate dal forum di newLISP (autori: kanen e rickyboy).

; Distanza di Leveshtein
; (delete, insert, modify)
; by kanen/rickyboy
; Uso:
;  (setf found-words (get-friendsLD "benefit" word-list))
;

(define (get-friendsLD word word-list)
  (let ((new-words '())
        (alphabet (explode "abcdefghijklmnopqrstuvwxyz"))
        (tmpWord ""))
    ;; Deletes (removing one letter)
    (for (i 0 (- (length word) 1))
      (setf tmpWord word)
      (pop tmpWord i)
      (push tmpWord new-words -1))
    ;; Modifies (one letter to another)
    (for (i 0 (- (length word) 1))
      (set 'tmpWord word)
      (dolist (a alphabet)
        (when (not (= (word i) a))
          (setf (tmpWord i) a)
          (push tmpWord new-words -1))))
    ;; Inserts (add a letter)
    (for (i 0 (length word))
      (dolist (a alphabet)
        (set 'tmpWord word)
        (push (push a tmpWord i) new-words -1)))
    (intersect new-words word-list)))

Questa funzione permette anche lo scambio (swap) di lettere adiacenti (si tratta della distanza di Leveshtein-Damerau):

; Distanza di Leveshtein-Damerau
; (delete, insert, modify, swap)
; by kanen/rickyboy
; Uso:
;  (setf found-words (get-friendsLDD "benefit" word-list))
;
(define (get-friendsLDD word word-list)
  (let ((new-words '())
        (alphabet (explode "abcdefghijklmnopqrstuvwxyz"))
        (tmpWord ""))
    ;; Deletes (removing one letter)
    (for (i 0 (- (length word) 1))
      (setf tmpWord word)
      (pop tmpWord i)
      (push tmpWord new-words -1))
    ;; Swaps (swap adjacent letters)
    (for (i 0 (- (length word) 2))
      (set 'tmpWord word)
      (push (push (pop tmpWord i) tmpWord (+ 1 i)) new-words -1))
    ;; Modifies (one letter to another)
    (for (i 0 (- (length word) 1))
      (set 'tmpWord word)
      (dolist (a alphabet)
        (when (not (= (word i) a))
          (setf (tmpWord i) a)
          (push tmpWord new-words -1))))
    ;; Inserts (add a letter)
    (for (i 0 (length word))
      (dolist (a alphabet)
        (set 'tmpWord word)
        (push (push a tmpWord i) new-words -1)))
    (intersect new-words word-list)))

Per provarle useremo prima il file "nomi-prova.txt":

(define (resume) (print "\r\n> "))
(silent (setq word-list (parse (read-file "nomiA.txt" "\r\n"))) (print "Fatto") (resume))
word-list
;-> ("eva" "leana" "lena" "liana" "lina" "luana" "luano" "luca"
;->  "luce" "lucia" "luisa" "luna" "max" "roberta" "una" "uno")

(get-friendsLD "luca" word-list)
;-> ("luna" "luce" "lucia")

Adesso utilizziamo il file "nomi.txt":

(silent (setq word-list (parse (read-file "nomi.txt" "\r\n"))) (print "Fatto") (resume))
(length word-list)
;-> 8913

(setq amici (get-friendsLD "luca" word-list))
;-> ("luna" "luce" "lucia")

Abbiamo la funzione che calcola gli amici di una parola (nome). Adesso dobbiamo scrivere la funzione che calcola il Social Network di una parola (nome).
La funzione seguente non è ottimizzata, ma è abbastanza semplice: la spiegazione del metodo di calcolo si trova nei commenti:

(define (social x)
  (local (out lst tmp stop len-out)
    ; calcola la lista risultato per la prima volta
    (setq out (get-friendsLD x word-list))
    ; lista di nomi di cui cercare gli amici (lista ricerca)
    (setq lst out)
    (setq stop nil)
    ;lunghezza della lista risultato
    (setq len-out (length out))
    (while (= stop nil)
      ; per ogni nome della lista ricerca calcoliamo
      ; una lista con tutti gli amici e poi la uniamo alla lista risultato
      (setq tmp '())
      (dolist (el lst)
        (extend tmp (get-friendsLD el word-list))
      )
      (setq out (union out tmp))
      ; se la lista risultato ha la stessa lunghezza di quella precedente
      ; (vuol dire che non abbiamo aggiunto alcun nome)...
      (if (= (length out) len-out)
        ;allora stop
        (setq stop true)
        ;altrimenti...
        (begin
          ;(println len-out { } (length out))
          ;aggiorna la lunghezza della lista risultato
          (setq len-out (length out))
          ;crea la nuova lista ricerca partendo dalla lista risultato
          ;togliendo gli elementi della lista ricerca attuale
          (setq lst (difference out lst))
        )
      )
    )
    out
  );local
)

(silent (setq word-list (parse (read-file "nomi-demo.txt" "\r\n"))) (print "Fatto") (resume))
(social "luca")
;-> ("luna" "luce" "lucia" "una" "lena" "lina" "luca" "luana" "uno" "leana" "liana" "luano")

Adesso proviamo con il file "nomi.txt" senza visualizzare il risultato sulla REPL perchè la lista è molto grande. Salveremo il risultato nel file "social-luca.txt"

(silent (setq word-list (parse (read-file "nomi.txt" "\r\n"))) (print "Fatto") (resume))
;(social "luca")

(time (setq amici (social "luca")))
;-> 102772.905 ; 1 min 42 sec

(length amici)
;-> 5534

Adesso scriviamo il risultato nel file "social-luca.txt":

(setq datafile (open "social-luca.txt" "write"))
(write datafile (join amici " "))
(close datafile)


-------
Skyline
-------

Viene data una serie di n rettangoli in nessun ordine particolare. Hanno larghezze e altezze variabili, ma i loro bordi inferiori sono collineari, in modo che sembrino edifici su un orizzonte. Per ogni rettangolo, viene data la posizione x del bordo sinistro, la posizione x del bordo destro e l'altezza. Il compito è disegnare un contorno attorno alla serie di rettangoli in modo che rappresenti la loro forma complessiva rispetto all'orizzonte (skyline).
Esempio:

Input lista Rettangoli
(setq ret '((1 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))

Output lista Skyline:
((1 3) (2 4) (4 0) (5 2) (6 4) (7 2) (8 4) (9 0))

     Rettangoli                          Skyline

     |                                   |
   5 |                                 5 |
     |                                   |
     |                                   |
   4 |     +-----+     +--+  +--+      4 |     O-----+     O--+  O--+
     |     |     |     |  |  |  |        |     |     |     |  |  |  |
     |     |     |     |  |  |  |        |     |     |     |  |  |  |
   3 |  +--|--+  |     |  |  |  |      3 |  O--+     |     |  |  |  |
     |  |  |  |  |     |  |  |  |        |  |        |     |  |  |  |
     |  |  |  |  |     |  |  |  |        |  |        |     |  |  |  |
   2 |  |  |  |  |  +--|--|--+  |      2 |  |        |  O--+  O--+  |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
   1 |  |  |  |  |  |  |  |  |  |      1 |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
     |  |  |  |  |  |  |  |  |  |        |  |        |  |           |
   0 |-----------------------------    0 |-----------O--------------O--
     0  1  2  3  4  5  6  7  8  9        0  1  2  3  4  5  6  7  8  9

I punti della lista skyline sono contrassegnati con la lettera "O".

Creazione di un vettore delle altezze massime "hmap"
Creiamo un vettore di (hmax + 1) elementi, dove hmax è l'altezza del rettangolo più alto.
Per ogni rettangolo (i j h) assegniamo a tutte le celle di hmap da i a (j-1) il valore massimo tra quello contenuto nella cella corrente e h.

Creazione della lista dei punti della linea
Visitiamo il vettore hmap e riportiamo sulla lista solo i punti (con il relativo valore) che sono diversi dal punto precedente.

Complessità Temporale: O(n)
Complessità Spaziale: O(max(h)) dove max(h) è l'altezza massima dei rettangoli

Considerando i rettangoli dell'esempio:

indice  0 1 2 3 4 5 6 7 8 9  vettore hmap
        0 0 0 0 0 0 0 0 0 0  valori iniziale
          3 3                valori dopo il primo ret (1 3 3)
            4 4              valori dopo il secondo ret (2 4 4)
                  2 2 2      valori dopo il terzo ret (5 8 2)
                    4        valori dopo il quarto ret (6 7 4)
                        4    valori dopo il quinto ret (8 9 4)
        0 3 4 4 0 2 4 2 4 0  valori finali

hmap = (0 3 4 4 0 2 4 2 4 0)

Possiamo scrivere la funzione:

(define (skyline lst)
  (local (len hmap linea)
    ;calcolo valore massimo altezza
    (setq len (add (apply max (flat lst)) 1))
    ; creazione vettore con tutti valori a zero
    (setq hmap (array len '(0)))
    ;Calcolo valori per hmap
    (dolist (el lst)
      (for (i (el 0) (sub (el 1) 1))
        (setf (hmap i) (max (el 2) (hmap i)))
      )
    )
    hmap
    ;calcolo punti visibili
    (setq out '())
    (for (i 0 (sub len 1))
      (if (zero? i)
        ; controllo primo punto hmap[0]
        ; se hmap[0] è diverso da zero, allora lo aggiungo al risultato
        (if (!= (hmap 0) 0) (push (list 0 (hmap i)) out -1))
        ; controllo punti successivi
        ; inserisco il valore di hmap[i] solo se è diverso dal precedente
        (if (!= (hmap i) (hmap (sub i 1))) (push (list i (hmap i)) out -1))
      )
    )
    out
  );local
)

(setq ret '((1 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))
(skyline ret)
;-> ((1 3) (2 4) (4 0) (5 2) (6 4) (7 2) (8 4) (9 0))

(setq ret '((0 3 3) (2 4 4) (5 8 2) (6 7 4) (8 9 4)))

(setq ret '((2 9 10) (3 6 15) (5 12 12) (13 16 10) (15 17 5)))
(skyline ret)
;-> ((2 10) (3 15) (6 12) (12 0) (13 10) (16 5) (17 0))


-------------
Knuth-shuffle
-------------

Knuth-shuffle (oppure Fisher-Yates shuffle) è un algoritmo per mescolare casualmente gli elementi di un array.
Data una lista con N elementi (idx: 0..N-1), lo pseudo-codice dell'algoritmo è il seguente:

for i from N downto 1 do:
     let j = numero intero casuale nell'intervallo 0 <= j <= i
     swap lista[i] con lista[j]

(define (knuth-shuffle lst)
  (local (N j)
    (setq N (length lst))
    (for (i (- N 1) 0 -1)
      (setq j (rand (+ i 1)))
      (swap (lst i) (lst j))
    )
    lst
  )
)

(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (3 7 9 5 1 0 4 6 8 2)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (6 4 9 3 2 7 8 1 5 0)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (9 0 7 5 8 1 3 4 6 2)
(knuth-shuffle '(1 2 3 4 5 6 7 8 9 0))
;-> (3 6 5 2 1 4 0 8 7 9)

Estrazione del lotto:
(knuth-shuffle (sequence 1 90))
;-> (13 28 18 32 62 56 19 67 89 54 63 81 61 27 78 75 10 39 46 48 52 4 57 55 29 42 16
;->  24 66 77 44 65 58 15 11 83 85 40 38 6 74 45 3 22 64 79 17 37 49 26 41 70 12 9 73
;->  68 35 72 84 36 7 47 60 30 80 90 14 33 51 59 50 43 20 21 82 1 5 86 8 31 2 69 25 23
;->  34 53 87 88 76 71)

Controlliamo il risultato:
(= (apply + (knuth-shuffle (sequence 1 90))) (apply + (sequence 1 90)))
;-> true

Controlliamo meglio:
(difference (knuth-shuffle (sequence 1 90)) (sequence 1 90))
;-> ()

newLISP ha anche una funzione apposita: "randomize":

(randomize (sequence 1 90))
;-> (41 43 55 59 78 76 4 67 3 40 25 70 56 83 33 30 61 68 17 44 9 27 73 65 24 12 5 37
;->  64 82 85 18 75 36 72 89 54 32 28 48 46 84 14 22 52 60 50 51 15 2 35 69 38 11 71
;->  23 62 53 16 45 31 34 87 47 10 57 26 1 86 81 29 90 74 88 19 80 20 42 8 21 39 58 13
;->  77 63 49 6 79 7 66)


-------------------
Bussola e direzioni
-------------------

La bussola è divisa principalmente nelle quattro direzioni cardinali: nord, sud, est e ovest. Questi punti possono essere ulteriormente suddivisi con l'aggiunta delle quattro direzioni intercardinali (o ordinali) - nord-est (NE), sud-est (SE), sud-ovest (SO) e nord-ovest (NO) - per indicare gli otto venti principali. Nell'uso meteorologico, vengono aggiunti ulteriori punti intermedi tra il cardinale e le direzioni intercardinali, come nord-nord est (NNE) per dare i sedici punti di una rosa di bussola.
La bussola del marinaio ha 32 punti poichè aggiunge punti come nord per est (NbE oppure NxE) tra nord e nord-nordest, e nordest per nord (NEbN oppure NExN) tra nord-nordest e nord-est. Un punto di bussola consente di fare riferimento a una direzione specifica (o azimut) in modo colloquiale, senza ricorrere ai gradi.

(define (bussola32-lista)
  (local (gradi nomi i j)
    (setq gradi '(0.0 16.87 16.88 33.75 50.62 50.63 67.5 84.37
                  84.38 101.25 118.12 118.13 135.0 151.87 151.88
                  168.75 185.62 185.63 202.5 219.37 219.38 236.25
                  253.12 253.13 270.0 286.87 286.88 303.75 320.62
                  320.63 337.5 354.37 354.38))
    (setq nomi '("North                " "North by east        " "North-northeast      "
                 "Northeast by north   " "Northeast            " "Northeast by east    "
                 "East-northeast       " "East by north        " "East                 "
                 "East by south        " "East-southeast       " "Southeast by east    "
                 "Southeast            " "Southeast by south   " "South-southeast      "
                 "South by east        " "South                " "South by west        "
                 "South-southwest      " "Southwest by south   " "Southwest            "
                 "Southwest by west    " "West-southwest       " "West by south        "
                 "West                 " "West by north        " "West-northwest       "
                 "Northwest by west    " "Northwest            " "Northwest by north   "
                 "North-northwest      " "North by west        " "North                " ))
    (for (i 0 31)
      (setq j (add 0.5 (div (mul 32 (gradi i)) 360)))
      (println (format "%2d  %.22s  %6.2f %6.2f" (add (mod j 32) 1) (nomi (mod j 32)) (gradi i) j))
    )
    nil
  )
)

(bussola32-lista)
;->  1  North                    0.00
;->  2  North by east           16.87
;->  3  North-northeast         16.88
;->  4  Northeast by north      33.75
;->  5  Northeast               50.62
;->  6  Northeast by east       50.63
;->  7  East-northeast          67.50
;->  8  East by north           84.37
;->  9  East                    84.38
;-> 10  East by south          101.25
;-> 11  East-southeast         118.12
;-> 12  Southeast by east      118.13
;-> 13  Southeast              135.00
;-> 14  Southeast by south     151.87
;-> 15  South-southeast        151.88
;-> 16  South by east          168.75
;-> 17  South                  185.62
;-> 18  South by west          185.63
;-> 19  South-southwest        202.50
;-> 20  Southwest by south     219.37
;-> 21  Southwest              219.38
;-> 22  Southwest by west      236.25
;-> 23  West-southwest         253.12
;-> 24  West by south          253.13
;-> 25  West                   270.00
;-> 26  West by north          286.87
;-> 27  West-northwest         286.88
;-> 28  Northwest by west      303.75
;-> 29  Northwest              320.62
;-> 30  Northwest by north     320.63
;-> 31  North-northwest        337.50
;-> 32  North by west          354.37
nil

(define (bussola32 gradi)
  (local (nomi j)
    (setq nomi '("North" "North by east" "North-northeast"
                  "Northeast by north" "Northeast" "Northeast by east"
                  "East-northeast" "East by north" "East"
                  "East by south" "East-southeast" "Southeast by east"
                  "Southeast" "Southeast by south" "South-southeast"
                  "South by east" "South" "South by west"
                  "South-southwest" "Southwest by south" "Southwest"
                  "Southwest by west" "West-southwest" "West by south"
                  "West" "West by north" "West-northwest"
                  "Northwest by west" "Northwest" "Northwest by north"
                  "North-northwest" "North by west" "North"))
    (setq j (add 0.5 (div (mul 32 gradi) 360)))
    (nomi (mod j 32))
  )
)

(bussola32 84.37)
;-> "East by north"

(bussola32 84.38)
;-> "East"


--------------------------------------
Puzzle (a b c + a b c + a b c = c c c)
--------------------------------------

Data la seguente operazione:

a b c +
a b c +
a b c =
--------
c c c

Trovare il valore delle cifre a, b e c.

Soluzione 1

Matematicamente risulta 3*(abc) = ccc che può essere scritto come:

  300a + 30b + 3c = 100c + 10c + c

Raggruppiamo il termine "c":

  300a + 30b = 108c

Dividiamo per 3:

  100a + 10b = 36c

Inoltre possiamo notare che deve risultare:

  c + c + c = [x]c

dove l'eventuale [x] può valere 1 o 2.

Vediamo quali cifre soddisfano questo vincolo:

(for (i 0 9)
  (if (< (* 3 i) 10)
      (if (= i (* 3 i)) (println i)) ; valori minori di 10 (una cifra)
      (if (= i (% (* 3 i) 10)) (println i)) ; valori maggiori di 10 (due cifre)
  )
)
;-> 0
;-> 5

Solo il numero 5 è una soluzione accettabile (altrimenti la somma sarebbe nulla).
Quindi abbiamo:

  a b 5 +
  a b 5 +
  a b 5 =
  --------
  5 5 5

Adesso deve risultare:

  b + b + b + 1 = [x]5

dove l'eventuale [x] può valere 1 o 2.

Vediamo quali cifre soddisfano questo vincolo:

(for (i 0 9)
  (if (< (* 3 i) 10)
      (if (= 5 (+ 1 (* 3 i))) (println i)) ; valori minori di 10 (una cifra)
      (if (= 5 (% (+ 1 (* 3 i)) 10)) (println i)) ; valori maggiori di 10 (due cifre)
  )
)
;-> 8

Quindi abbiamo:

  a 8 5 +
  a 8 5 +
  a 8 5 =
  --------
  5 5 5

Adesso deve risultare:

  a + a + a + 2 = 5

Il termine [x] non compare perchè "a" deve essere minore di 10.

Quindi risolviamo quest'ultima equazione:

3*a = 3 ==> a = 1

  1 8 5 +
  1 8 5 +
  1 8 5 =
  --------
  5 5 5

Soluzione 2 (forza bruta)

Calcolare tutte le combinazioni delle cifre da 0 a 9:

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(setq prove (combinazioni 3 '(1 2 3 4 5 6 7 8 9 0)))
(length prove)
;-> 120

Calcolare tutte le permutazioni per ogni elemento della lista delle combinazioni:

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

(setq num (map (fn (x) (permutazioni x)) prove))

Eliminare un livello di annidamento:

(setq num (flat num 1))
(length num)
;-> 720

Calcolare il valore di ogni elemento della lista " num" (formato elemento (a b c)):
(setq numeri (map (fn (x) (+ (* 100 (first x)) (* 10 (first (rest x))) (last x))) num))

Ordinare i numeri:
(sort numeri)

Applicare la seguente funzione di controllo alla lista "numeri":

(define (calcola n)
  (local (val val$ n$ out)
    (setq n$ (string n))
    (setq val (+ n n n))
    (setq val$ (string val))
    (cond ((< n 100) nil)
          ((> val 999) nil)
          ((or (!= (val$ 0) (val$ 1)) (!= (val$ 0) (val$ 2)) (!= (val$ 1) (val$ 2))) nil)
          ((!= (val$ 2) (n$ 2)) nil)
          (true n)
    )
  )
)

(calcola 123)
;-> nil

(setq lsol (map (fn (x) (calcola x)) numeri))

Eliminare tutti gli elementi nil:

(clean null? lsol)
;-> (185)

Soluzione:
a = 1
b = 8
c = 5


---------------
Numero mancante
---------------

Data una lista contenente n numeri distinti presi da 0, 1, 2, ..., n, trovare quello mancante nella lista. Ad esempio, data la lista nums = (0  1  3), la funzione dovrebbe restituire 2.

Soluzione 1 - Matematica

(define (mancante lst)
  (local (somma n)
    (setq n (length lst))
    (setq somma (apply + lst))
    (- (/ (* n (+ n 1)) 2) somma)
  )
)

(setq lst '(9 0 5 4 7 1 6 8 2))
(mancante lst)
;-> 3

Soluzione 2 - Bitwise XOR

(define (mancante lst)
  (let (manca 0)
    (for (i 0 (- (length lst) 1))
      (setq manca (^ manca (^ (+ i 1) (lst i))))
    )
  manca
  )
)

(mancante lst)
;-> 3


--------------------------------------------------
Somma massima di una sottolista (Algoritmo Kadane)
--------------------------------------------------

Data una lista di numeri interi trovare il valore massimo della somma di una sua sottolista.
L'algoritmo di Kadane risolve questo problema per una lista di qualunque dimensione.
In questo caso lo applicheremo ad una lista semplice ad una sola dimensione (1D).

Prima vediamo la soluzione ottenuta con la forza bruta (brute-force).
Data la lista lst = (-1 2 -1 3) i valori delle somme di tutte le sottoliste valgono:

ELEMENTI     Somma   start-index   end-index
-1            -1       0             0
-1,2           1       0             1
-1,2,-1        0       0             2
-1,2,-1,3      3       0             3
2              2       1             1
2,-1           1       1             2
2,-1,3         4       1             3     <--- 4 somma massima sottoliste
-1            -1       2             2
-1,3           2       2             3
3              3       3             3

Dobbiamo scrivere una funzione che calcola la somma di tutte le sottoliste:

(define (maxSumSub lst)
  (local (n max_sum max_start max_end)
    (setq n (length lst))
    (setq max_sum (lst 0))
    (setq max_start 0)
    (setq max_end 0)
    (for (start 0 (- n 1))
      (for (end start (- n 1))
        (setq sum (calcSum lst start end))
        (if (> sum max_sum)
          (begin
            (setq max_sum sum)
            (setq max_start start)
            (setq max_end end))
        )
      )
    )
    (list max_sum max_start max_end)
  );local
)

(define (calcSum lst i j)
  (local (sum)
    (setq sum 0)
    (for (k i j)
      (setq sum (+ sum (lst k)))
    )
  )
)

(setq lst '(-1 2 -1 3))
;-> (-1 2 -1 3)
(maxSumSub lst)
;-> (4 1 3)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(maxSumSub lst)
;-> (122 0 12)

Questo algoritmo ha complessità temporale O(n^3).

Dobbiamo utilizzare un algoritmo più veloce.

L'algoritmo di Kadane inizia con un ragionamento induttivo: se conosciamo la somma massima del subarray che termina con la posizione i (si chiami questo B[i]), qual è la somma massima del subarray che termina alla positione i + 1 (equivalentemente, quanto vale B[i+1]) ? La risposta risulta essere relativamente semplice: o la somma massima del subarray che termina con la posizione i + 1 include la somma massima della subarray che termina alla posizione i come prefisso, oppure no (in altre parole, B[i+1] = max(A[i+1], A[i+1] + B[i]), dove A[i+1] è l'elemento all'indice i + 1).

L'algoritmo può essere codificato nel seguente modo:

(define (getMaxSum lst)
  (local (currentMax totalMax)
    (setq currentMax (lst 0))
    (setq totalMax (lst 0))
    (for (i 1 (- (length lst) 1))
      ; aggiorno il valore massimo della somma corrente
      ; sommandolo al valore corrente
      (setq currentMax (add (lst i) (max currentMax 0)))
      ; verifico se occorre aggiornare il valore massimo totale
      (setq totalMax (max totalMax currentMax 0))
    )
  )
)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(getMaxSum lst)
;-> 122

(setq lst '(-2 1 -3 4 -1 2 1 -5 4))
(getMaxSum lst)
;-> 6

La soluzione completa consiste nel restituire tre valori:
1) il valore della somma massima
2) l'indice di inizio della sottolista massima
2) l'indice di fine della sottolista massima
Inoltre bisogna trattare il caso della lista vuota e quello delle liste che hanno tutti valori negativi.

La funzione definitiva è la seguente:

(define (kadaneIdx lst)
  (local (currentMax totalMax startIdx endIdx tempIdx)
    (cond ((null? lst) (list nil nil nil))
          (true
            (setq currentMax (lst 0))
            (setq totalMax (lst 0))
            (setq startIdx 0)
            (setq endIdx 0)
            (setq tempIdx 0)
            (for (i 1 (- (length lst) 1))
              ; aggiorno il valore massimo della somma corrente
              (setq currentMax (add currentMax (lst i)))
              ; spezziamo la condizione che calcola
              ; il massimo tra totalMax currentMax e 0,
              ; per tenere conto degli indici coinvolti
              (cond ((< currentMax 0)
                      (setq currentMax 0)
                      (setq tempIdx (add i 1))
                    )
                    ((< totalMax currentMax)
                      (setq totalMax currentMax)
                      (setq startIdx tempIdx)
                      (setq endIdx i)
                    )
              )
            )
            ; controllo soluzione negativa ==> tutti i numeri sono negativi
            (if (< totalMax 0)
              (begin
                ; cerco il valore massimo della lista e il relativo indice
                (setq startIdx -1)
                (dolist (el lst)
                  (if (>= el totalMax) (setq totalMax el startIdx $idx))
                )
                (setq endIdx startIdx)
              )
            )
            (list totalMax startIdx endIdx)
          );true
    );cond
  );local
)

(setq lst '(5 7 -3 2 9 6 16 22 21 29 -14 10 12))
(kadaneIdx lst)
;-> (122 0 12)

(setq lst '(-2 1 -3 4 -1 2 1 -5 4))
(kadaneIdx lst)
;-> (6 3 6)

(setq lst '(1 2 3 -20 5 6))
(kadaneIdx lst)
;-> (11 4 5)

(setq lst '(10 -1 2 11))
(kadaneIdx lst)
;-> (22 0 3)

(setq lst '(-11 -10 -12))
(kadaneIdx lst)
(-10 1 1)

(setq lst '())
(kadaneIdx lst)
;-> (nil nil nil)

L'algoritmo Kadane ha complessità temporale O(n).


----------------------------------
Prodotto massimo di una sottolista
----------------------------------

Data una lista di numeri interi trovare il valore massimo del prodotto di una sua sottolista.
Per risolvere questo problema potremmo utilizzare l'algoritmo di Kadane e modificarlo per tenere conto degli elementi con valore 0 e del fatto che il prodotto può cambiare segno in funzione del segno dei moltiplicandi.
Invece utilizziamo un metodo più semplice che però non è ottimale in termini di tempo e di spazio.

(define (maxProd lst)
  (local (n maxprod pos neg)
    (setq n (length lst))
    (setq pos (array n '(0)))
    (setq neg (array n '(0)))
    (setq (pos 0) (lst 0)) ; pos[i] contiene il prodotto positivo fino a lst[i]
    (setq (neg 0) (lst 0)) ; neg[i] contiene il prodotto negativo fino a lst[i]
    (setq maxprod (lst 0))
    (for (i 0 (- n 1))
      ; il massimo dei tre valori
      (setq (pos i) (max (max (mul (pos (- i 1)) (lst i)) (mul (neg (- i 1)) (lst i))) (lst i)))
      ; il minimo dei tre valori
      (setq (neg i) (min (min (mul (pos (- i 1)) (lst i)) (mul (neg (- i 1)) (lst i))) (lst i)))
      (setq maxprod (max maxprod (pos i)))
    )
    maxprod
  )
)

(setq lst '(6 -3 -10 0 2))
(maxProd lst)
;-> 180
Sottolista: (6 -3 -10)

(setq lst '(-1 -3 -10 0 60))
(maxProd lst)
;-> 60
Sottolista: (60)

(setq lst '(-2 -3 0 -2 -40))
(maxProd lst)
;-> 80
Sottolista: (-2 -40)

(setq lst '(-1 -2 -3))
(maxProd lst)
;-> 6

(setq lst '(0 -1))
(maxProd lst)
;-> 0

(setq lst '(0 0 0 0))
(maxProd lst)
;-> 0


-----------------------
Problema delle N-Regine
-----------------------

Il problema delle N-Regine consiste nel trovare il modo di posizionare N Regine (pezzo degli scacchi) su una scacchiera NxN in modo che nessuna di esse sia sotto cattura.
Il problema è risolvibile solo per N >= 4.
Risolveremo il problema con il metodo di backtracking (che è una forma di ricorsione).
Per capire il funzionamento dell'algoritmo, risolveremo prima il problema passo per passo utilizzando una scacchiera 4x4.

Algoritmo di backtracking
1) All'inizio, posizioniamo una regina (X) nella casella (1,1)

   X 0 0 0
   0 0 0 0
   0 0 0 0
   0 0 0 0

2) Ora la seconda regina non può essere piazzata nelle colonne 1 e 2 poiché tali posizioni possono essere attaccate dalla prima regina.
Quindi piazziamo la regina due inizialmente a (2,3)

   X 0 0 0
   0 0 X 0
   0 0 0 0
   0 0 0 0

3) La terza regina può essere piazzata a (4,2).

   X 0 0 0
   0 0 X 0
   0 0 0 0
   0 X 0 0

4) Ora, quando proviamo a piazzare una regina nella terza fila, non troviamo alcuna casella disponibile perché sono tutte attaccate dalla prima regina o dalla seconda regina.
Quindi torniamo indietro (backtracking) e cerchiamo di mettere la terza regina in una nuova posizione. Purtoppo non esiste nessuna posizione disponibile per la terza regina, allora torniamo indietro e riposizioniamo la seconda regina a (2,4) (che è la prima casella disponibile).

   X 0 0 0
   0 0 0 X
   0 0 0 0
   0 0 0 0

5) Ora, quando piazziamo la terza regina, c'è solo una posizione possibile che è (3,2), quindi poniamo la terza regina in (3,2).

   X 0 0 0
   0 0 0 X
   0 X 0 0
   0 0 0 0

6) Ancora una volta finiamo senza nessuna posizione per piazzare la prossima regina. Quindi torniamo indietro, ma non ci sono posizioni alternative nemmeno per la terza e la seconda regina. Quindi torniamo indietro e cambiamo la posizione della prima regina come (1,2)

   0 X 0 0
   0 0 0 0
   0 0 0 0
   0 0 0 0

7) Ora per mettere la seconda regina, abbiamo solo una scelta che è (2,4)

   0 X 0 0
   0 0 0 X
   0 0 0 0
   0 0 0 0

8) Allo stesso modo, per posizionare la terza regina, abbiamo una sola posizione possibile (3,1)

   0 X 0 0
   0 0 0 X
   X 0 0 0
   0 0 0 0

9) Infine, abbiamo una posizione possibile per posizionare la quarta regina che è (4,3)

   0 X 0 0
   0 0 0 X
   X 0 0 0
   0 0 X 0

In questo modo si ottiene una possibile soluzione al problema delle N-Regine e l'algoritmo termina.

(define (isAttacked x y board N)
  (local (out)
    ; controllo righe e colonne
    (for (i 0 (- N 1))
      ;righe
      (if (and (= (board x i) 1) (!= i y))
        (setq out true))
      ;colonne
      (if (and (= (board i y) 1) (!= i x))
        (setq out true))
    )
    ; controllo diagonali
    (for (i 0 (- N 1))
      (for (j 0 (- N 1))
        (if (or (= (+ i j) (+ x y)) (= (- i j) (- x y)))
            (if (and (or (!= i x) (!= j y)) (= 1 (board i j)))
                (setq out true)
            )
        )
      )
    )
    out
  );local
)

(setq board '((1 0 0 0) (0 0 0 0) (0 0 0 0) (0 0 0 0)))
(isAttacked 1 1 board 4)
;-> true
(isAttacked 2 2 board 4)
;-> true
(isAttacked 1 2 board 4)
;-> nil

(define (nQueens board level N)
  (local (out j)
    (cond ((= level N) (setq out true) (show board N))
          (true
            (setq j 0)
            (while (and (< j N) (!= out true))
              (if (isAttacked level j board N) (setq j j)
                  (begin
                    (setq (board level j) 1)
                    (if (nQueens board (+ level 1) N) (setq out true)
                        (setq (board level j) 0))
                  )
              )
              (++ j)
            )
          )
    )
    out
  )
  ;(println board)
)

(define (show board)
    (for (i 0 (- N 1))
      (for (j 0 (- N 1))
        (print (board i j) { })
      )
      (println { })
    )
)

(setq size 4)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 0 1 0 0
;-> 0 0 0 1
;-> 1 0 0 0
;-> 0 0 1 0
;-> true

(setq size 8)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 1 0 0 0 0 0 0 0
;-> 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 1 0 0
;-> 0 0 1 0 0 0 0 0
;-> 0 0 0 0 0 0 1 0
;-> 0 1 0 0 0 0 0 0
;-> 0 0 0 1 0 0 0 0
;-> true

(setq size 21)
(setq board (array size size '(0)))
(nQueens board 0 size)
;-> 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0
;-> 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0
;-> true

(setq size 21)
(setq board (array size size '(0)))
(time (nQueens board 0 size))
;-> 31058.105 ; 31 secondi


------------------------------
Somma delle cifre di un numero
------------------------------

Calcolare la somma delle cifre di un numero ripetutamente fino a quando la somma ha una sola cifra.

Esempi:

n = 1234 ==> 1 + 2 + 3 + 4 = 10 ==> 1 + 0 = 1

n = 5674 ==> 5 + 6 + 7 + 4 = 22 ==> 2 + 2 = 4

(define (digitSum n)
  (if (zero? n) 0
    (if (zero? (% n 9)) 9
      (% n 9)
    )
  )
)

(digitSum 1234)
;-> 1

(digitSum 5674)
;-> 4

(digitSum 2345345345343453453453535353453453451345678901)
;-> 5L

Complessità temporale O(1).

Ted Walther ha scritto una funzione più elegante:

(define (digital_root n)
    (+ 1 (% (- n 1) 9)))

Vediamo adesso la dimostrazione matematica.

Prendiamo un numero numero positivo N. Scrivendo N in termini di cifre abbiamo:

N = Sum[ d[i] * 10^i ], dove d[0], d[1], d[2], ... sono le cifre di N. la somma inizia con i = 0.

Nota che 10^1 = (9*1 + 1), 10^2 = (9*11 + 1), 10^3 = (9*111 + 1), e così via.

Quindi possiamo scrivere:

N = (9*1 + 1) d[0] + (9*11 + 1) d[1] + (9*111 + 1) d[2] + ...

= 9 * (1*d[0] + 11*d[1] + 111*d[2] + ...) + d[0] + d[1] + d[2] + ...

= (multiplo di 9) + d[0] + d[1] + d[2] + ...

Quindi (N mod 9) = d[0] + d[1] + d[2] + ...

In altre parole il risultato deriva da una proprietà fondamentale dell'aritmetica modulare, vale a dire:

a*b mod n ≡ (a mod n)*(b mod n)

Poichè 10 mod 9 ≡ 1 abbimo 10^i mod 9 ≡ (10 mod 9)^i = 1^i = 1 per qualunque potenza i di 10.

Nella notazione decimale, un intero positivo N è rappresentato come una sequenza inversa di cifre d (i) tale che:

N = ∑ d(i)*10^i ⇒ N mod 9 ≡ ∑ (d(i)*10^i mod 9) ≡ ∑ d(i) mod 9
    i                       i                     i

Notare che qualsiasi numero intero positivo in base b è congruente alla somma delle sue cifre modulo (b-1) per qualsiasi base.

Per completezza riportiamo una funzione che calcola la somma delle cifre di un numero (non ripetutamente):

(define (digit-sum n)
  (let (out 0)
    (while (!= n 0)
      (setq out (+ out (% n 10)))
      (setq n (/ n 10))
    )
    out))

(digit-sum 123456789L)
;-> 45


--------------------------
Coppia di punti più vicina
--------------------------

Data una serie di n punti nel piano, trovare la coppia di punti che hanno distanza minore.

Esempio: L = ((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)

      |
    6 |
      |
    5 |       O               O       O
      |
    4 |       O       O
      |
    3 |   O                   O
      |
    1 |           O
      |
    1 |   O                   O
      |
    0 ---------------------------------------
      0   1   2   3   4   5   6   7   8   9

(define (closestPairs lst)
  (local (cp vec dist minDist)
    (setq minDist 9223372036854775807) ; valore massimo int64
    (setq cp '())
    ; trasformo la lista in un vettore per guadagnare in velocità
    (setq vec (array (length lst) 2 (flat lst)))
    (for (p1 0 (- (length vec) 1))
      (for (p2 p1 (- (length vec) 1))
        (if (!= (vec p1) (vec p2))
          (begin
            (setq dist (add (mul (sub (vec p1 0) (vec p2 0)) (sub (vec p1 0) (vec p2 0)))
                            (mul (sub (vec p1 1) (vec p2 1)) (sub (vec p1 1) (vec p2 1)))))
            (if (< dist minDist)
              (begin
                (setq minDist dist)
                (setq cp (list (vec p1) (vec p2)))
                ;(println minDist)
              )
            )
          )
        )
      )
    )
    (println minDist)
    cp
  )
)

(setq lst '((1 3) (4 4) (1 1) (2 5) (6 3) (8 5) (6 1) (6 5) (3 2) (2 4)))
(closestPairs lst)
;-> 1
;-> ((2 4) (2 5))

Vediamo con una lista di 10000 punti:

(silent
  (setq a (rand 10000 10000))
  (setq b (rand 10000 10000))
  (setq c (map list a b))
  (setq d (unique c))
)

(time (closestPairs d))
;-> 1
;-> 31187.104

La funzione è lenta. Complessità temporale O(n^2)).

Vediamo la differenza del numero di cicli tra due for innestati (i = 0 e j = 0) e due for con il secondo ciclo che inizia da i = j:

(setq n 100)
(setq n 1000)
(setq n '(100 1000 10000 100000))
(dolist (el n)
  (setq num 0 num1 0)
  ; primo ciclo
  (for (i 0 (- el 1))
    (for (j 0 (- el 1))
      (++ num)
    )
  )
  ; secondo ciclo
  (for (i 0 (- el 1))
    (for (j i (- el 1))
      (++ num1)
    )
  )
  (println el { } num { } num1)
)

;-> 100 10000 5050
;-> 1000 1000000 500500
;-> 10000 100000000 50005000
;-> 100000 10000000000 5000050000

Il primo ciclo ha n^2 cicli, il secondo ha (n^2)/2 cicli.


--------------------------------------------
Moltiplicazione tra numeri interi (stringhe)
--------------------------------------------

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


------------------
Numeri pandigitali
------------------

I numeri pandigitali sono numeri che contengono tutte le dieci (10) cifre 0..9 solo una volta.
Alcune volte sono consoderati pandigitali anche i numeri che contengono tutte le nove (9) cifre 1..9 solo una volta.
I numeri con zero all'inizio non vengono considerati.

Nota: I numeri pandigitali sono divisibili per 9.

Iniziamo con i numeri pandigitali (10):

(define (pan10a? n)
  (local (out)
    (cond ((or (< n 1023456789) (> n 9876543210) (!= 0 (% n 9))) (setq out nil))
          ((= (length (intersect (explode (string n)) '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))) 10)
           (setq out true))
    )
    out
  )
)

(define (pan10b? n)
  (cond ((or (< n 1023456789) (> n 9876543210) (!= 0 (% n 9))) nil)
        (true
          (let (lst '(0 0 0 0 0 0 0 0 0 0))
            (while (!= n 0)
              (setf (lst (% n 10)) 1)
              (setq n (/ n 10))
            )
            ;(println lst)
            (if (ref '0 lst) nil true)
          )
        )
  )
)

Primo numero pandigitale (10):     1023456789
Millesimo numero pandigitale (10): 1024658793

(define (test10a)
  (setq conta 0)
  (for (i 1023456789 1024658793) (if (pan10a? i) (++ conta)))
  conta
)

(test10a)
;-> 1000

(time (test10a))
;-> 1044.941

(define (test10b)
  (setq conta 0)
  (for (i 1023456789 1024658793) (if (pan10b? i) (++ conta)))
  conta
)

(test10b)
;-> 1000

(time (test10b))
;-> 605.393

Vediamo ora in numeri pandigitali (9):

(define (pan9a? n)
  (local (out)
    (cond ((or (< n 123456789) (> n 987654321) (!= 0 (% n 9))) (setq out nil))
          ((= (length (intersect (explode (string n)) '("1" "2" "3" "4" "5" "6" "7" "8" "9"))) 9)
           (setq out true))
    )
    out
  )
)

(define (pan9b? n)
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

(define (test9a)
  (setq conta 0)
  (for (i 123456789 123987654) (if (pan9a? i) (++ conta)))
  conta
)

(test9a)
;-> 720

(time (test9a))
;-> 449.521

(define (test9b)
  (setq conta 0)
  (for (i 123456789 123987654) (if (pan9b? i) (++ conta)))
  conta
)

(test9b)
;-> 720

(time (test9b))
;-> 277.714


--------------------------------------
Somma dei divisori propri di un numero
--------------------------------------

Prima versione:

(define (sum-proper-divisors n)
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
  (+ 1 res)
)

Seconda versione:

(define (somma-divisori-propri n)
  (local (somma fine)
    (setq somma 0)
    (setq fine (int (sqrt n)))
    (for (i 2 fine)
      (if (zero? (% n i))
        (setq somma (+ somma i (/ n i)))
      )
    )
    (if (= n (* fine fine) (setq somma (- somma fine))))
    (+ 1 somma)
  )
)


Terza versione:

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

(sum-proper-divisors 12345678901234567)
;-> 1763668414462089
(somma-divisori-propri 12345678901234567)
;-> 1763668414462089
(somma-divisori-propri-fast 12345678901234567)
;-> 1763668414462089

(time (sum-proper-divisors 12345678901234567))
;-> 17358.122
(time (somma-divisori-propri 12345678901234567))
;-> 8089.74
(time (somma-divisori-propri-fast 12345678901234567))
;-> 199.812


----------------------------
Labirinti (calcolo percorsi)
----------------------------

Un labirinto è un percorso o un insieme di percorsi, in genere con uno o più ingressi e con nessuna o più uscite.
Per risolvere un labirinto (maze) utilizzeremo il seguente algoritmo che trova la soluzione (se esiste) in modo ricorsivo. Si parte da un valore iniziale X e Y. Se i valori X e Y non sono su un muro, il metodo (funzione) richiama se stesso con tutti i valori X e Y adiacenti, assicurandosi di non aver utilizzato in precedenza quei valori X e Y. Se i valori X e Y sono quelli della posizione finale, salva tutte le istanze precedenti del metodo (risultati parziali) creando una matrice con il percorso risolutivo.
Questo metodo non garantisce che la soluzione trovata sia quella più breve.

(define (solveMaze matrice sRow sCol eRow eCol)
  (local (maze row col visited correctPath starRow startCol endRow endCol)
    ; matrice labirinto
    (setq maze matrice)
    ; righe della matrice
    (setq row (length maze))
    ; colonne della matrice
    (setq col (length (first maze)))
    ; matrice delle celle visitate
    (setq visited (array row col '(nil)))
    ; matrice soluzione del labirinto
    (setq correctPath (array row col '(nil)))
    ; posizione iniziale: riga
    (setq startRow sRow)
    ; posizione iniziale: colonna
    (setq startCol sCol)
    ; posizione finale: riga
    (setq endRow eRow)
    ; posizione finale: colonna
    (setq endCol eCol)
    ;
    ; funzione recursive solve
    ;
    (define (recursiveSolve x y)
      (catch
        (local (return)
          ;controllo se abbiamo raggiunto la fine e non è un muro
          (if (and (= x endRow) (= y endCol) (!= (maze x y) 2))
              (throw (setf (correctPath x y) true))
          )
          ; cella muro o cella visitata
          (if (or (= (maze x y) 2) (= (visited x y) true)) (throw nil))
          ; imposta cella come visitata
          (setf (visited x y) true)
          ; controllo posizione riga 0
          (if (!= x 0)
              ; richiama la funzione una riga in basso
              (if (recursiveSolve (- x 1) y)
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione riga (row - 1)
          (if (!= x (- row 1))
              ; richiama la funzione una riga in alto
              (if (recursiveSolve (+ x 1) y)
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione colonna 0
          (if (!= y 0)
              ; richiama la funzione una colonna a sinistra
              (if (recursiveSolve x (- y 1))
                  (throw (setf (correctPath x y) true))
              )
          )
          ; controllo posizione colonna (col - 1)
          (if (!= y (- col 1))
              ; richiama la funzione una colonna a destra
              (if (recursiveSolve x (+ y 1))
                  (throw (setf (correctPath x y) true))
              )
          )
          return
        );local
      ) ;catch
    ); recursiveSolve
    ;
    ; Chiama la funzione ricorsiva di soluzione
    ; Se (recursiveSolve startRow startCol) ritorna nil,
    ; allora il labirinto non ha soluzione.
    ; Altrimenti la matrice booleana "correctPath"
    ; contiene la soluzione (valori true).
    (if (recursiveSolve startRow startCol) (showPath correctPath))
  );local
)

(define (showPath matrix)
  (local (row col)
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; stampa
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (if (matrix i j) (print " 1") (print " 0"))
      )
      (println)
    )
    true
  )
)

Esempio 1:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 1 1
 2 2 1 1
 1 2 2 1
 2 2 2 1
 1 1 1 1

; definizione labirinto
(setq righe 5)
(setq colonne 4)
(setq matrice (array righe colonne '(1 1 1 1  2 2 1 1  1 2 2 1  2 2 2 1  1 1 1 1)))
(solveMaze matrice 0 0 4 3)
;-> 1 1 1 0
;-> 0 0 1 1
;-> 0 0 0 1
;-> 0 0 0 1
;-> 0 0 0 1

Esempio 2:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2
 2 1 1 1 2
 2 1 2 2 2
 2 1 1 1 1

; definizione labirinto
(setq righe 4)
(setq colonne 5)
(setq matrice (array righe colonne '(1 1 2 1 2  2 1 1 1 2  2 1 2 2 2  2 1 1 1 1)))
(solveMaze matrice 0 0 3 4)
;-> 1 1 0 0 0
;-> 0 1 0 0 0
;-> 0 1 0 0 0
;-> 0 1 1 1 1

Esempio 3:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 1 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 1 1 1 1 1 2 2 2 1 1 1 1 2 2 2 1 2 1 2
 1 2 2 2 2 1 2 2 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 1 1 1 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 1 2 1 2 1 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 1 1 1 2 1 2 2 1 1 1 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 1 1 1 1 2 1 1 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1

Soluzione:

 * * 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 * 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 * 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 * * * * * 2 2 2 1 * * * 2 2 2 1 2 1 2
 1 2 2 2 2 * 2 2 1 2 * 2 * 2 2 1 1 2 2 2
 1 2 2 2 2 * * * * 2 * 2 * 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 * 2 * 2 * 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 * * * 2 * 2 2 * * * 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 * * * * 2 * * *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 *

; definizione labirinto
(setq righe 12)
(setq colonne 20)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 1 2 1 2 1 2 1 2 2 1 1 1 2
 2 1 1 1 2 2 1 1 1 1 1 2 2 1 1 1 1 1 2 2
 2 1 2 2 2 2 2 1 1 2 2 2 1 2 2 2 2 1 2 1
 2 1 1 1 1 1 2 2 2 1 1 1 1 2 2 2 1 2 1 2
 1 2 2 2 2 1 2 2 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 1 1 1 1 2 1 2 1 2 2 1 1 2 2 2
 1 2 2 2 2 2 2 2 1 2 1 2 1 2 2 1 2 1 2 2
 1 2 2 2 2 2 2 2 1 1 1 2 1 2 2 1 1 1 2 2
 1 2 2 2 2 2 2 2 1 2 2 2 1 1 1 1 2 1 1 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1
 1 2 2 2 2 2 2 2 1 2 2 2 1 2 2 1 2 2 2 1)))

(solveMaze matrice 0 0 11 19)
;-> 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;-> 0 1 1 1 1 1 0 0 0 0 1 1 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 0 0 0 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 1 1 1 1 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 0 1 0 1 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 1 0 0
;-> 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1

Esempio 4:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 1 2
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 1
 2 1 1 1 1 1 2 2 2
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 2 1 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1

Nessuna soluzione.

; definizione labirinto
(setq righe 9)
(setq colonne 9)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 1 2
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 1
 2 1 1 1 1 1 2 2 2
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 2 1 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1
 1 2 2 2 2 2 2 2 1)))

(solveMaze matrice 0 0 8 8)
;-> nil

(solveMaze matrice 0 0 5 5)
;-> 1 1 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0
;-> 0 1 0 0 0 0 0 0 0
;-> 0 1 1 1 1 1 0 0 0
;-> 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 1 0 0 0
;-> 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0
;-> 0 0 0 0 0 0 0 0 0

Esempio 5:
; matrice labirinto (1 = libero, 2 = muro)

 1 1 2 1 2 1 1 2 1
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 2
 2 1 1 1 1 1 2 1 1
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 1 1 1
 1 1 1 1 1 2 1 2 1
 1 2 2 2 1 2 1 2 1
 1 2 2 2 1 1 1 2 1

Soluzione:

 1 1 2 1 2 1 1 2 *
 2 1 1 1 2 2 1 * *
 2 1 2 2 2 2 2 * 2
 2 1 1 1 1 1 2 * *
 1 2 2 2 2 1 2 2 *
 1 2 2 2 2 1 * * *
 * * * * * 2 * 2 1
 * 2 2 2 * 2 * 2 1
 * 2 2 2 * * * 2 1

; definizione labirinto
(setq righe 9)
(setq colonne 9)

(setq matrice (array righe colonne '(
 1 1 2 1 2 1 1 2 1
 2 1 1 1 2 2 1 1 1
 2 1 2 2 2 2 2 1 2
 2 1 1 1 1 1 2 1 1
 1 2 2 2 2 1 2 2 1
 1 2 2 2 2 1 1 1 1
 1 1 1 1 1 2 1 2 1
 1 2 2 2 1 2 1 2 1
 1 2 2 2 1 1 1 2 1)))

(solveMaze matrice 8 0 0 8)
;-> 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 0 1 1
;-> 0 0 0 0 0 0 0 1 0
;-> 0 0 0 0 0 0 0 1 1
;-> 0 0 0 0 0 0 0 0 1
;-> 0 0 0 0 0 0 1 1 1
;-> 1 1 1 1 1 0 1 0 0
;-> 1 0 0 0 1 0 1 0 0
;-> 1 0 0 0 1 1 1 0 0


--------------------------
Moltiplicazioni di fattori
--------------------------

Dato un numero N, creare la lista dei numeri che possono essere ottenuti dal prodotto di tutte le combinazioni dei fattori primi del numero N.
Nota: i numeri primi restituiscono una lista vuota.

Esempio:
N = 12
Fattori = 2 2 3
Prodotti = 2*2 2*3 2*2*3 = 4 6 12

(define (combinazioni k nlst)
  (cond ((zero? k)     '(()))
        ((null? nlst)  '())
        (true
          (append (map (lambda (k-1) (cons (first nlst) k-1))
                       (combinazioni (- k 1) (rest nlst)))
                  (combinazioni k (rest nlst))))))

(setq fattori (factor 12))

(setq c1 (combinazioni 1 fattori))
;-> ((2) (2) (3))
(setq c2 (combinazioni 2 fattori))
;-> ((2 2) (2 3) (2 3))
(setq c3 (combinazioni 3 fattori))
;-> ((2 2 3))

(setq r1 (map (fn (x) (apply * x)) c1))
;-> (2 2 3)
(setq r2 (map (fn (x) (apply * x)) c2))
;-> (4 6 6)
(setq r3 (map (fn (x) (apply * x)) c3))
;-> (12)
(setq r (append r1 r2 r3))
;-> (2 2 3 4 6 6 12)
(setq r (unique r))
;-> (2 3 4 6 12)
(setq r (difference r fattori))
;-> (4 6 12)

Esempio con N = 36:

(setq fattori (factor 36))
(setq c1 (combinazioni 1 fattori))
;-> ((2) (2) (3) (3))
(setq c2 (combinazioni 2 fattori))
;-> ((2 2) (2 3) (2 3) (2 3) (2 3) (3 3))
(setq c3 (combinazioni 3 fattori))
;-> ((2 2 3) (2 2 3) (2 3 3) (2 3 3))
(setq c4 (combinazioni 4 fattori))
;-> ((2 2 3 3))

(setq r1 (map (fn (x) (apply * x)) c1))
;-> (2 2 3 3)
(setq r2 (map (fn (x) (apply * x)) c2))
;-> (4 6 6 6 6 9)
(setq r3 (map (fn (x) (apply * x)) c3))
;-> (12 12 18 18)
(setq r4 (map (fn (x) (apply * x)) c4))
;-> (36)

(setq r (difference (unique(append r1 r2 r3 r4)) fattori))
;-> (4 6 9 12 18 36)

Possiamo scrivere la funzione:

(define (mult-fact n)
  (local (fattori c r out)
    (setq out '())
    (setq fattori (factor n))
    (if (= fattori nil) '()
      (begin
        (for (i 1 (length fattori))
          (setq c (combinazioni i fattori))
          (setq r (map (fn (x) (apply * x)) c))
          (push r out -1)
        )
        (sort (difference (unique (flat out)) fattori))
      )
    );if
  );local
)

(mult-fact 12)
;-> (4 6 12)

(mult-fact 36)
;-> (4 6 9 12 18 36)

(mult-fact 100)
;-> (4 10 25 20 50 100)

(mult-fact 31)
;-> ()

(mult-fact 1)
;-> ()

(mult-fact 10032)
;-> (4 6 8 12 16 22 24 33 38 44 48 57 66 76 88 114 132 152 176 209 228
;->  264 304 418 456 528 627 836 912 1254 1672 2508 3344 5016 10032)

Vediamo per curiosità quale numero fino a diecimila genera la lista più lunga.

(define (entro10000)
  (setq lungo 0)
  (setq val 0)
  (for (i 10 10000)
    (if (> (length (mult-fact i)) lungo)
      (setq lungo (length (mult-fact i)) val i)
    )
  )
  (println "numero: " val { --- } "lunghezza: " lungo)
)

(entro10000)
;-> numero: 7560 --- lunghezza: 59


---------------------------------------------
Problemi patologici dei numeri floating point
---------------------------------------------

La Chaotic Bank Society offre questo investimento ai propri clienti.
Per prima cosa depositi $ e - 1 dove e è 2.7182818 ... la base dei logaritmi naturali.

Dopo ogni anno, il saldo del tuo account verrà moltiplicato per il numero di anni che sono passati e verranno rimossi $ 1 in costi di servizio.

Così ...

dopo 1 anno, il saldo verrà moltiplicato per 1 e $ 1 verrà rimosso per le spese di servizio.
dopo 2 anni il saldo sarà raddoppiato e $ 1 rimosso.
dopo 3 anni il saldo sarà triplicato e $ 1 rimosso.
...
dopo 10 anni, moltiplicato per 10 e $ 1 rimosso, e così via.

Quale sarà il tuo saldo dopo 25 anni?

Risultato corretto:
    Saldo iniziale: (e - 1)
    Saldo = (Saldo * anno) - 1 (per 25 anni)
    Saldo dopo 25 anni: 0.0399387296732302

Proviamo con una funzione che utilizza i numeri floating point:

(define (banca)
  (local (e deposito)
    ;definiamo il numero e
    (setq e (exp 1))
    (setq deposito (sub e 1))
    (for (i 1 25)
      (setq deposito (sub (mul deposito i) 1))
      (println i { } deposito)
    )
    deposito
  )
)

(banca)
;-> 1   0.7182818284590451
;-> 2   0.4365636569180902
;-> 3   0.3096909707542705
;-> 4   0.2387638830170822
;-> 5   0.1938194150854109
;-> 6   0.1629164905124654
;-> 7   0.1404154335872576
;-> 8   0.1233234686980609
;-> 9   0.1099112182825479
;-> 10  0.09911218282547907
;-> 11  0.09023401108026974
;-> 12  0.08280813296323686
;-> 13  0.07650572852207915
;-> 14  0.07108019930910814
;-> 15  0.06620298963662208
;-> 16  0.05924783418595325
;-> 17  0.007213181161205284
;-> 18 -0.8701627390983049
;-> 19 -17.53309204286779
;-> 20 -351.6618408573559
;-> 21 -7385.898658004473
;-> 22 -162490.7704760984
;-> 23 -3737288.720950264
;-> 24 -89694930.30280632
;-> 25 -2242373258.570158
;-> -2242373258.570158

Il risultato è sbagliato, poichè gli arrotondamenti delle operazioni floating point fanno divergere i calcoli.
Per risolvere il problema possiamo usare le frazioni, cioè eseguiamo tutti i calcoli con le frazioni (numeri interi) e usiamo la divisione solo per ottenere il valore del risultato come floating point. Per fare questo dobbiamo rappresentare anche il numero "e" con una frazione:

e = 106246577894593683 / 39085931702241241

Le funzioni per utilizzare le quattro operazioni delle frazioni sono le seguenti:

(define (semplifica frac)
  (local (num den n d temp, nums dens)
    (setq num (first frac))
    (setq den (last frac))
    (setq n (first frac))
    (setq d (last frac))
    ; calcola il numero massimo che divide esattamente numeratore e denominatore
    (while (!= d 0)
      (setq temp d)
      (setq d (% n temp))
      (setq n temp)
    )
    (setq nums (/ num n))
    (setq dens (/ den n))
    ; controllo del segno
    (cond ((or (and (< dens 0) (< nums 0)) (and (< dens 0) (> nums 0)))
           (setq nums (* nums -1))
           (setq dens (* dens -1))
          )
    )
    (list nums dens)
  )
)

(define (+f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (+ (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (-f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (- (* n1 d2) (* n2 d1)))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (*f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 n2))
    (setq den (* d1 d2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

(define (/f frac1 frac2 redux)
  (local (num den n1 d1 n2 d2)
    (setq n1 (first frac1))
    (setq d1 (last frac1))
    (setq n2 (first frac2))
    (setq d2 (last frac2))
    (setq num (* n1 d2))
    (setq den (* d1 n2))
    (if redux (list num den)
          (semplifica (list num den))
    )
  )
)

Adesso riscriviamo la funzione che calcola il valore finale dell'investimento:

(define (banca)
  (local (e deposito)
    ;definiamo il numero e
    (setq e '(106246577894593683L 39085931702241241L))
    (setq deposito (-f e '(1 1)))
    (for (i 1 25)
      (setq deposito (-f (*f deposito (list i 1)) '(1 1)))
      (println i { } deposito { } (div (first deposito) (last deposito)))
    )
    deposito
  )
)

(banca)
;-> 1  (28074714490111201L 39085931702241241L) 0.7182818284590452
;-> 2  (17063497277981161L 39085931702241241L) 0.4365636569180905
;-> 3  (12104560131702242L 39085931702241241L) 0.3096909707542714
;-> 4  (9332308824567727L 39085931702241241L) 0.2387638830170857
;-> 5  (7575612420597394L 39085931702241241L) 0.1938194150854282
;-> 6  (6367742821343123L 39085931702241241L) 0.1629164905125695
;-> 7  (5488268047160620L 39085931702241241L) 0.1404154335879862
;-> 8  (4820212675043719L 39085931702241241L) 0.1233234687038897
;-> 9  (4295982373152230L 39085931702241241L) 0.1099112183350075
;-> 10 (3873892029281059L 39085931702241241L) 0.09911218335007542
;-> 11 (3526880619850408L 39085931702241241L) 0.09023401685082953
;-> 12 (3236635735963655L 39085931702241241L) 0.08280820220995427
;-> 13 (2990332865286274L 39085931702241241L) 0.07650662872940559
;-> 14 (2778728411766595L 39085931702241241L) 0.07109280221167809
;-> 15 (2594994474257684L 39085931702241241L) 0.06639203317517139
;-> 16 (2433979885881703L 39085931702241241L) 0.06227253080274239
;-> 17 (2291726357747710L 39085931702241241L) 0.05863302364662064
;-> 18 (2165142737217539L 39085931702241241L) 0.05539442563917152
;-> 19 (2051780304892000L 39085931702241241L) 0.05249408714425882
;-> 20 (1949674395598759L 39085931702241241L) 0.04988174288517631
;-> 21 (1857230605332698L 39085931702241241L) 0.04751660058870241
;-> 22 (1773141615078115L 39085931702241241L) 0.04536521295145283
;-> 23 (1696325444555404L 39085931702241241L) 0.04339989788341503
;-> 24 (1625878967088455L 39085931702241241L) 0.04159754920196069
;-> 25 (1561042474970134L 39085931702241241L) 0.03993873004901714
;-> (1561042474970134L 39085931702241241L)

Questa volta il risultato è esatto.

Sul forum di newLISP, rickyboy ha fornito le seguenti funzioni equivalenti:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (rat (+ (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (-rat r1 r2)
  (rat (- (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (*rat r1 r2)
  (rat (* (r1 0) (r2 0))
       (* (r1 1) (r2 1))))

(define (/rat r1 r2)
  (rat (* (r1 0) (r2 1))
       (* (r1 1) (r2 0))))


------------------
Numerali di Church
------------------

Nella codifica di Church dei numeri naturali, il numero N viene codificato da una funzione che applica il suo primo argomento N volte al suo secondo argomento.

Church ZERO restituisce sempre la funzione identità, indipendentemente dal suo primo argomento. In altre parole, il primo argomento non viene applicato al secondo argomento.
Church UNO applica il suo primo argomento f solo una volta al secondo argomento x, producendo f(x).
Church DUE applica il suo primo argomento f due volte al suo secondo argomento x, producendo f(f(x))
e ogni successivo numero della Chiesa applica il suo primo argomento una volta in più al secondo argomento, f(f(f(x))), f(f(f(f(x)))) ... Il numero Church 4, per ad esempio, restituisce una composizione quadrupla della funzione fornita come primo argomento.
Le operazioni aritmetiche sui numeri naturali possono essere similmente rappresentate come funzioni sui numeri di Church.

Definiamo i numeri di Church:

(define (zero f x) x)
(define (uno f x) (f x))
(define (due f x) (f (f x)))
(define (tre f x) (f (f (f x))))
(define (quattro f x) (f (f (f (f x)))))
(define (cinque f x) (f (f (f (f (f x))))))
(define (sei f x) (f (f (f (f (f (f x)))))))
(define (sette f x) (f (f (f (f (f (f (f x))))))))
(define (otto f x) (f (f (f (f (f (f (f x))))))))
(define (otto f x) (f (f (f (f (f (f (f (f x)))))))))
(define (nove f x) (f (f (f (f (f (f (f (f (f x))))))))))

(zero inc 0)
;-> 0
(uno inc 0)
;-> 1
(due inc 0)
;-> 2

Oppure:

(setq f inc)
(setq x 0)
(zero f x)
;-> 0
(sei f x)
;-> 6

Definiamo la funzione successore "succ":

(define (succ n f x) (f (f n x)))

(succ 0 inc 0)
;-> 1
(succ 3 inc 0)
;-> 4
(succ 2 inc 0)
;-> 3

Definiamo la funzione somma "plus":

(define (plus m n f x) (f m (f n x)))
(plus 3 2 inc 0)
;-> 5
(plus (due inc 0) 5 inc 0)
;-> 7
(plus (due f x) 5 f x)
;-> 7

Adesso dovremmo definire la funzioni precedente "prec", la funzione moltiplicazione "molt" e la funzione sottrazione "minus". Dopo aver avuto un aiuto da kosh ho deciso di utilizzare il suo metodo per definire i numerali di Church (https://gist.github.com/kosh04/262332)

La funzione "expand" espande solo i simboli che iniziano con una lettera maiuscola:

(define-macro (LAMBDA)
  (append (lambda) (expand (args))))

(define DEFINE define)

Numeri naturali e aritmetica:

; 0: = λfx.x
(DEFINE ZERO (LAMBDA (F) (LAMBDA (X) X)))
; 1: = λfx.fx
(DEFINE UNO  (LAMBDA (F) (LAMBDA (X) (F X))))
(define UNO  (LAMBDA (F) (LAMBDA (X) (F X))))
; 2: = λfx.f (fx)              ; 1: = λfx.fx
(DEFINE DUE  (LAMBDA (F) (LAMBDA (X) (F (F X)))))
(define DUE  (LAMBDA (F) (LAMBDA (X) (F (F X)))))
; 3: = λfx.f (f (fx))
(DEFINE TRE  (LAMBDA (F) (LAMBDA (X) (F (F (F X))))))
(DEFINE QUATTRO (LAMBDA (F) (LAMBDA (X) (F (F (F (F X)))))))
(DEFINE CINQUE  (LAMBDA (F) (LAMBDA (X) (F (F (F (F (F X))))))))
(DEFINE SEI  (LAMBDA (F) (LAMBDA (X) (F (F (F (F (F (F X)))))))))

; SUCC: = λnfx.f (n f x)
(DEFINE (SUCC N) (LAMBDA (F) (LAMBDA (X) (F (N F X)))))

; PLUS: = λmnfx.m f (n f x)
(DEFINE (PLUS M N) (LAMBDA (F) (LAMBDA (X) ((M F) ((N F) X)))))
(define (PLUS M N) (LAMBDA (F) (LAMBDA (X) ((M F) ((N F) X)))))

; MOLT: = λ mn f. M (n f)
(DEFINE (MOLT M N) (LAMBDA (F) (LAMBDA (X) ((N (M F) X)))))

; POW: = λbe.e b
(DEFINE (POW B E) (E B))

(define (to-number x) ((x (lambda (n) (+ n 1))) 0))

(define (to-lambda n) (if (< 0 n) (SUCC (to-lambda (- n 1))) (ZERO)))

(to-number ZERO)
;-> 0
(to-number UNO)
;-> 1
(to-number DUE)
;-> 2

La funzione seguente prende un intero e ritorna il numero nella forma di Church:

(define (reduce stencil sq) (apply stencil sq 2))

(define (num n)
(cond
   ((= n 0) 'x)
   ((< n 2) '(f x))
   (true (reduce (fn (l i) (list 'f l)) (cons '(f x) (sequence 2 n)) ))))

(define (church-encode n)
  (letex ((body (num n)))
    (fn (f x) body)))

(church-encode 0)
;-> (lambda (f x) x)
(church-encode 4)
;-> (lambda (f x) (f (f (f (f x)))))

(num 0)
;-> x

(num 4)
;-> (f (f (f (f x))))

Per adesso mi fermo qui, devo ragionarci un pò di più :-)


-----------------------------------
Creazione e valutazione di polinomi
-----------------------------------

Supponiamo di avere il polinomio y(x) = 3*x^2 - 7*x + 5 e di voler calcolare i valori di y per x che varia da 0 a 10 (con passo 1).
Possiamo definire una funzione che rappresenta il polinomio:

(define (poly x)
  (+ 5 (mul 7 x) (mul 3 (pow x 2))))

(poly 0)
;-> 5

E poi per ottenere i valori cercati possiamo scrivere:

(for (x 0 10) (println x { } (poly x)))
;-> 0 5
;-> 1 15
;-> 2 31
;-> 3 53
;-> 4 81
;-> 5 115
;-> 6 155
;-> 7 201
;-> 8 253
;-> 9 311
;-> 10 375

Poichè i polinomi hanno una struttura ben definita possiamo scrivere una funzione che prende i coefficienti di un polinomio e restituisce una funzione che rappresenta il polinomio:
Ad esempio, il polinomio:

 y(x) = 4*x^3 + 5*x^2 + 7*x + 10

viene rappresentato dalla funzione:

 (lambda (x) (add 10 (mul x 7) (mul (pow x 2) 5) (mul (pow x 3) 4)))

La nostra funzione deve quindi costruire una nuova funzione lambda che rappresenta il polinomio (lavoriamo sulla funzione lambda come se fosse una lista).

; y(x) = 4*x^3 + 5*x^2 + 7*x + 10)
; (setq poly (crea-polinomio '(4 5 7 10)))
; poly -> (lambda (x) (add 10 (mul x 7) (mul (pow x 2) 5) (mul (pow x 3) 4)))

(define (crea-polinomio coeff)
  (local (fun body)
    (reverse coeff)
    (setq fun '(lambda (x) x)) ;funzione lambda base
    (setq body '()) ;corpo della funzione
    (push 'add body -1)
    (push (first coeff) body -1) ;termine noto
    (push (list 'mul 'x (coeff 1)) body -1) ;termine lineare
    (for (i 2 (- (length coeff) 1))
      (push (list 'mul (list 'pow 'x i) (coeff i)) body -1)
    )
    (setq (last fun) body) ;modifica corpo della funzione
    fun
  )
)

Adesso possiamo definire una nuova funzione "poly" che rappresenta il nostro polinomio:

(setq poly (crea-polinomio '(4 5 7 10)))
;-> (lambda (x) (add 10 (mul x 7) (mul (pow x 2) 5) (mul (pow x 3) 4)))

Valutando il polinomio per x = 0 otteniamo il termine noto:

(poly 0)
;-> 10

Usiamo la funzione "poly" in un ciclo for:

(for (x 0 10) (println x { } (poly x)))
;-> 0 10
;-> 1 26
;-> 2 76
;-> 3 184
;-> 4 374
;-> 5 670
;-> 6 1096
;-> 7 1676
;-> 8 2434
;-> 9 3394
;-> 10 4580

Proviamo con i dati del primo esempio:

(setq poly2 (crea-polinomio '(3 7 5)))
;-> (lambda (x) (add 5 (mul x 7) (mul (pow x 2) 3)))

(for (x 0 10) (println x { } (poly2 x)))
;-> 0 5
;-> 1 15
;-> 2 31
;-> 3 53
;-> 4 81
;-> 5 115
;-> 6 155
;-> 7 201
;-> 8 253
;-> 9 311
;-> 10 375

Sul forum di newLISP, raph.ronnquist ha fornito la seguente funzione per creare polinomi:

(define (make-poly coeff)
  (let ((rank (length coeff))
        (polyterm (fn (k) (case (dec rank)
                                (0 k)
                                (1 (list 'mul 'x k))
                                (true (list 'mul (list 'pow 'x rank) k))))))
    (push (cons 'add (reverse (map polyterm coeff))) (copy '(fn (x))) -1)))

(setq poly3 (make-poly '(4 5 7 10)))
;-> (lambda (x) (add 10 (mul x 7) (mul (pow x 2) 5) (mul (pow x 3) 4)))

Sul forum di newLISP, rickyboy ha fornito la seguente funzione per creare polinomi con la regola di Horner:

(define (make-poly-horner coeffs)
  (push (if (< (length coeffs) 2)
            (first coeffs)
          (apply (fn (acc c)
                   (list 'add c (cons 'mul (list 'x acc))))
                 coeffs
                 2))
        (copy '(fn (x)))
        -1))

(setq poly4 (make-poly-horner '(3 7 5)))
;-> (lambda (x) (add 5 (mul x (add 7 (mul x 3)))))

(poly4 0)
;-> 5


------------------------------
Quadrato perfetto di un numero
------------------------------

Determinare se un numero n è un quadrato perfetto.

Usiamo la funzione radice quadrata (sqrt):

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(square? 400)
;-> true

(square? 1736364774)
;-> nil

(time (map square? (sequence 2 1000000)))
;-> 225.77

Facciamo un test per vedere se la funzione è corretta:

(for (i 2 1e7)
  (if (not (square? (* i i))) (println i { } (* i i))))
;-> nil

Un metodo alternativo:

(define (square1? n)
  (catch
    (let (i (max 1 (int (- (sqrt n) 1))))
      (while (<= (* i i) n)
        (if (and (= (% n i) 0) (= i (/ n i))) (throw true))
        (++ i)
      )
      (throw nil)
    )
  )
)

(square1? 400)
;-> true

(square1? 1736364774)
;-> nil

(time (map square1? (sequence 2 1000000)))
;-> 2253.451

Test:

(for (i 2 1e6)
  (if (not (square1? (* i i))) (println i { } (* i i))))
;-> nil

Un altro metodo è quello di fattorizzare il numero n e poi, se tutti gli esponenti dei fattori sono numeri pari, allora n è un quadrato perfetto.

Esempio:
n = 400
(factor 400)
;-> (2 2 2 2 5 5)

400 = 20*20 = 2^4 * 5^2

Poichè 4 e 2 (gli esponenti) sono numeri pari allora 400 è un quadrato perfetto.

Ecco la funzione:

(define (square2? n)
  (let (f (factor n))
    (catch
      (dolist (x (count (unique f) f))
        (if (odd? x) (throw nil))
        true
      )
    )
  )
)

(square2? 400)
;-> true

(square2? 1736364774)
;-> nil

(time (map square2? (sequence 2 1000000)))
;-> 3534.401

Test:

(for (i 2 1e5)
  (if (not (square2? (* i i))) (println i { } (* i i))))
;-> nil

Un altro algoritmo (molto lento).

Dato il numero n:
1) a = 5*n
2) b = 5
3) Affinchè (a >= b)
      a = a - b
      b = b + 10
4) Quando (a < b):
   se e solo se (a == 0) allora n è un quadrato perfetto

Ecco la funzione:

(define (square3? n)
  (let ((a (* 5 n)) (b 5))
    (while (>= a b)
      (setq a (- a b))
      (++ b 10)
    )
    (zero? a)
  )
)

(square3? 400)
;-> true

(square3? 1736364774)
;-> nil

(time (map square3? (sequence 2 1000000)))
;-> 80311.923

Test:

(for (i 2 1e4)
  (if (not (square3? (* i i))) (println i { } (* i i))))
;-> nil

Inoltre valgono le seguenti due regole:

1) Se un numero ha 2 o 3 o 7 o 8 nel posto dell'unità, allora non è un quadrato perfetto.

(define (digit-1 n)
  (if (zero? (/ n 10))
      n
      (digit-1 (/ n 10))
  )
)

(digit-1 (* 343 343))
;-> 1

2) Se la somma delle cifre di un numero non vale 1 o 4 o 7 o 9, allora non è un quadrato perfetto.

(define (digit-sum n) (+ 1 (% (- n 1) 9)))

(digit-sum (* 361 361))
;-> 1

Infine, ecco una soluzione abbastanza veloce che funzione anche per i numeri big integer:

(define (square4? n)
  (local (a)
    (setq a n)
    (while (> (* a a) n)
      (setq a (/ (+ a (/ n a)) 2L))
    )
    (= (* a a) n)
  )
)

(square4? 400L)
;-> true

(square4? 1736364774L)
;-> nil

(* 83968 83968)
;-> 7050625024

(square4? (* 83968L 83968L))
;-> true

Ma attenzione, occorre passare dei numeri big integer (L) per ottenere il risultato corretto:

(square4? (* 83968 83968))
;-> nil ;errore

(square4? (* 383747464646473736473647364736L 383747464646473736473647364736L))
;-> true

(time (map square4? (sequence 2L 1000000L)))
;-> 2578.611

Test:

(for (i 2 1e6)
  (if (not (square4? (* (bigint i) (bigint i))) (println i { } (* i i)))))
;-> nil


-----------------------------
Potenza perfetta di un numero
-----------------------------

Determinare se un numero intero è potenza perfetta di un altro numero intero.

Cominciamo col determinare se un numero n è potenza del numero 3.

(define (power-of-3? n)
  (if (zero? (% n 3))
        (power-of-3? (/ n 3))
        (= n 1)
  )
)

(power-of-3? 9)
;-> true
(power-of-3? 6)
;-> nil
(power-of-3? 81)
;-> true
(power-of-3? 847288609443)
;-> true

Vediamo la velocità della funzione:

(time (map power-of-3? (sequence 4 1e7)))
;-> 2676.189

Notiamo che la somma delle cifre di ogni numero che è potenza di 3 vale 9 (tranne 0 e 3).
Per calcolare la somma delle cifre di un numero usiamo la seguente funzione:

(define (digitSum n) (+ 1 (% (- n 1) 9)))

Verifichiamo la nostra ipotesi:

(for (i 4 1e6)
  (if (and (power-of-3? i) (!= 9 (digitSum i)))
    (println "Error: " i)
  )
)
;-> nil

Non è vero il contrario, cioè esistono tanti numeri che hanno come somma delle cifre il valore 9, ma non sono potenze del numero 3.

(for (i 4 1e2)
  (if (and (= 9 (digitSum i)) (not (power-of-3? i)))
    (println "Error: " i)
  )
)
;-> Error: 18
;-> Error: 36
;-> Error: 45
;-> Error: 54
;-> Error: 63
;-> Error: 72
;-> Error: 90
;-> Error: 99

Possiamo generalizzare la funzione per determinare se un numero m è potenza del numero n.

(define (power-of? n m)
  (if (zero? (% m n))
        (power-of? n (/ m n))
        (= m 1)
  )
)

(power-of? 3 117)
;-> nil
(power-of? 4 4096)
;-> true
(power-of? 4 20)
;-> nil
(power-of? 7 2401)
;-> true
(power-of-3? 847288609443)
;-> true

Un altro metodo è quello di utilizzare i logaritmi. L'idea è di calcolare il logaritmo di y in base x. Se risulta essere un numero intero, allora il numero y è una potenza perfetta, altrimenti non lo è.
Ricordiamo che matematicamente risulta:

logb(x) = logc(x) / logc(b)

E in newLISP la funzione "log" ha la seguente sintassi:

(log num num-base)

Quindi la funzione è la seguente:

(define (ispower? x y) (= (log y x) (int (log y x))))

(ispower? 2 16)
;-> true

(ispower? 3 81)
;-> true


Per finire, scriviamo una funzione che calcola se un numero intero n è potenza di un qualsiasi numero intero.
Un numero n viene detto una potenza perfetta quando n = m^k è un numero intero e m>1 e k>=2.
Consideriamo la fattorizzazione di un numero: n = p1^a1 * p2^a2 *...* pk^ak
Il numero n è una potenza perfetta se e solo se (MCD a1 a2 ... ak) > 1

La funzione "factor-exp-list" calcola la lista degli esponenti della fattorizzazione del numero x:

(define (factor-exp-list x)
  (if (= x 1) '(1)
    (letn (fattori (factor x)
           unici (unique fattori))
       (count unici fattori))))

1000 = 2^3 * 5^3
(factor-exp-list 1000)
;-> (3 3)

Adesso possiamo scrivere la funzione "checkpower" che calcola se un numero è una potenza perfetta:

(define (checkpower n)
  (local (a out)
    (if (> (setq a (apply gcd (factor-exp-list n))) 1)
        (list (ceil (pow n (div 1 a))) a)
        nil)))

(checkpower (pow 3 12))
;-> (3 12)

(checkpower (pow 4 25))
;-> (2 50)

(checkpower (+ (pow 3 7) 1))
;-> nil

(checkpower 4096)
;-> (2 12)


-------------------------
Problema della segretaria
-------------------------

Il problema della segretaria è un problema che dimostra uno scenario che coinvolge la teoria dell'arresto ottimale.
La forma base del problema è la seguente: immagina un amministratore che vuole assumere la miglior segretaria da n candidate. Le candidate vengono intervistate una per una in ordine casuale. Una decisione su ciascuna candidata particolare deve essere presa immediatamente dopo il colloquio. Una volta respinta, una candidata non può essere richiamata. Durante il colloquio, l'amministratore ottiene informazioni sufficienti per classificare con un punteggio la candidata. La domanda riguarda la strategia ottimale (regola di arresto) per massimizzare la probabilità di selezionare la miglior candidata. Se la decisione può essere rinviata alla fine, allora la scelta viene fatta al termine di tutti i colloqui, selezionando la candidata con il punteggio maggiore. La difficoltà è che la decisione deve essere presa immediatamente: la candidata deve essere presa o scartata.

La probabilità di vincita ottimale è sempre almeno 1/e (dove e è la base del logaritmo naturale). La regola di arresto ottimale prescrive sempre di rifiutare le prime n/e candidate che vengono intervistate e quindi fermarsi alla prima candidata che è migliore di tutti le candidate intervistate finora (o si continua fino all'ultima candidata se ciò non si verifica mai). A volte questa strategia è chiamata regola di arresto 1/e , perché la probabilità di fermarsi alla migliore candidata con questa strategia è circa 1/e già per valori piccoli n. Il metodo per la soluzione del problema (la regola di arresto) è semplice e seleziona la migliore candidata circa il 37% delle volte, indipendentemente dal fatto che ci siano 100 o 100 milioni di candidate.

Sebbene ci siano molte varianti, il problema di base può essere definito come segue:

1) C'è una singola posizione da riempire.
2) Ci sono n candidate per la posizione e il valore di n è noto.
3) Le candidate, se viste complessivamente, possono essere classificate dalla migliore alla peggiore in modo inequivocabile.
4) I punteggi relativi alle valutazioni devono essere tutti diversi.
5) Le candidate vengono intervistate in sequenza in ordine casuale.
6) Immediatamente dopo un colloquio, la candidata intervistata viene accettata o respinta e la decisione è irrevocabile.
7) La decisione di accettare o respingere una candidata si basa solo sui punteggi delle candidate intervistate finora.

L'obiettivo della soluzione generale è trovare un metodo che renda massima probabilità di selezionare il miglior candidato dell'intero gruppo.

La politica ottimale per il problema è una regola di arresto. Con questa, l'intervistatore rifiuta le prime (r - 1) (considerando che la candidata M abbia il miglior punteggio tra queste (r - 1) candidate), quindi seleziona, tra le candidate successive, la prima candidata che ha un punteggio migliore della candidata M. Si può dimostrare che la strategia ottimale sta in questa classe di strategie. Con un taglio arbitrario r, la probabilità che sia selezionato il miglior richiedente vale:

P(r) = (r - 1)/n * sum[i=1...i=n] 1/(i-1)

Definiamo una funzione per calcolare questo valore:

(define (P r n)
  (local (somma out)
    (setq out 0)
    (if (= r 1) (setq out (div 1 n))
        (begin
          (setq somma 0)
          (for (i r n)
            (setq somma (add somma (div 1 (sub i 1))))
          )
          (setq out (mul somma (div (sub r 1) n)))
        )
    )
  out
  )
)

(P 1 1)
;-> 1

(P 1 2)
;-> 0.5

(P 2 3)
;-> 0.5

(P 3 5)
;-> 0.4333333

(P 37 100)
;-> 0.371014595504193

La teoria afferma che il taglio ottimo vale n/e

(div 1 (exp 1))
;-> 0.3678794411714423

Proviamo con un esempio per capire come funziona.

Abbiamo 100 candidati con punteggi variabili da 1 a 100:

(setq cand (randomize (sequence 0 99)))
;-> (76 64 72 83 55 63 29 95 89 74 61 71 60 49 3 8 2 58
;->  53 98 24 15 38 69 43 94 39 8 21 5 19 41 80 59 20 44
;->  28 82 73 7 75 36 77 14 79 25 67 11 85 9 47 32 16 88
;->  12 90 17 0 91 46 26 93 99 35 18 37 13 42 22 50 66 52
;->  96 97 48 62 51 4 70 45 87 6 92 4 27 65 54 23 34 86 31
;->  1 33 30 78 57 40 56 10 81)

La teoria afferma che il taglio ottimo vale n/e:

(div 1 (exp 1))
;-> 0.3678794411714423

(setq taglio (round (div 100 (exp 1))))
;-> 37

Calcoliamo il punteggio massimo dal primo fino al taglio:
(apply max (slice cand 0 taglio))
;-> 98

Quindi nelle rimanenti candidate (dal taglio alla fine della lista) troviamo la candidata con punteggio 99, che è la miglioer ed è quella che verrà selezionata.

Adesso scriviamo una funzione che calcola la percentuale di successo (cioè quante volte selezioniamo la migliore candidata) con due parametri, il numero delle candidate n e il numero dei colloqui (cioè quante volte ripetiamo il test).

(define (secretary n prove)
  (local (cand taglio m1 m2 success found)
    (setq success 0)
    ;Definiamo il taglio
    ; 1/e = (div 1 (exp 1))) = 0.3678794411714423
    (setq taglio (round (div n (exp 1))))
    (for (i 1 prove)
      ; Generiamo la lista dei punteggi per le candidate
      (setq cand (randomize (sequence 0 (- n 1))))
      ;Calcoliamo il valore massimo FINO al taglio
      (setq m1 (apply max (slice cand 0 taglio)))
      ;Cerchiamo il primo valore > m1 dal resto della lista
      ;se non esiste tale valore, allora m2 vale l'ultimo candidato
      (setq m2 (last cand))
      (setq found nil)
      (dolist (el (slice cand taglio) found)
        (if (> el m1) (setq m2 el found true))
      )
      ;se m2 > max allora abbiamo scelto la candidata migliore
      ;(if (>= m2 (apply max cand) (++ success)))
      ;se m2 = (n - 1) allora abbiamo scelto la candidata migliore
      ;(if (= m2 (- n 1)) (++ success))
      (if (= m2 (- n 1)) (++ success))
    )
    (div success prove)
  )
)

(secretary 100 100)
;-> 0.35

(secretary 100 1000)
;-> 0.365

(secretary 100 10000)
;-> 0.3668

(secretary 100 100000)
;-> 0.36995

(time (println (secretary 1000 100000)))
;-> 0.36794
;-> 14018
;-> 14018

Quindi con il taglio ottimo selezioniamo la segretaria migliore il 37% delle volte.

Adesso vogliamo verificare se il taglio ottimo n/e è veramente ottimo. Per fare questo scriviamo una funzione simile alla precedente, ma che utilizza il taglio dal 2% dei candidati al 98% dei candidati con passo dell'1%. Prima abbiamo bisogno di aggiungere il parametro percentuale (perc) alla funzione "secretary".

(define (secretary1 n prove perc)
  (local (cand taglio m1 m2 success found)
    ; numero di successi
    (setq success 0)
    ;Definiamo il taglio
    ; 1/e = (div 1 (exp 1))) = 0.3678794411714423
    ;(setq taglio (round (mul n (div 1 (exp 1)))))
    (setq taglio (round (mul n perc)))
    (for (i 1 prove)
      ; Generiamo la lista dei punteggi per le candidate
      ; I punteggi devono essere tutti diversi
      (setq cand (randomize (sequence 0 (- n 1))))
      ;
      ;Definiamo il taglio
      ; 1/e = (div 1 (exp 1))) = 0.3678794411714423
      ;(setq taglio (round (mul n (div 1 (exp 1)))))
      ;
      ;Calcoliamo il valore massimo FINO al taglio
      (setq m1 (apply max (slice cand 0 taglio)))
      ;Cerchiamo il primo valore > m1 dal resto della lista
      ;se non esiste tale valore, allora m2 vale l'ultimo candidato
      (setq m2 (last cand))
      (setq found nil)
      (dolist (el (slice cand taglio) found)
        (if (> el m1) (setq m2 el found true))
      )
      ;se m2 > max allora abbiamo scelto la candidata migliore
      ;(if (>= m2 (apply max cand) (++ success)))
      ;se m2 = (n - 1) allora abbiamo scelto la candidata migliore
      (if (= m2 (- n 1)) (++ success))
    )
    (div success prove)
  )
)

Proviamo la funzione con il taglio ottimo:

(secretary1 100 10000 0.37)
;-> 0.3688

Adesso scriviamo la funzione di test:

(define (test numero try)
  (let (out '())
    (for (i 0.02 0.98 0.01)
      (push (list i (secretary1 numero try i)) out -1)
    )
    out
  )
)

(time (println (test 1000 100000)))
;-> ((0.02 0.07912) (0.03 0.10446) (0.04 0.12815) (0.05 0.14926) (0.06 0.16773)
;->  (0.07 0.18446) (0.08 0.19901) (0.09 0.21840) (0.10 0.23036) (0.11 0.24187)
;->  (0.12 0.25638) (0.13 0.26558) (0.14 0.27721) (0.15 0.28404) (0.16 0.29332)
;->  (0.17 0.30204) (0.18 0.30775) (0.19 0.31570) (0.20 0.32219) (0.21 0.32700)
;->  (0.22 0.33187) (0.23 0.33872) (0.24 0.34584) (0.25 0.34686) (0.26 0.35190)
;->  (0.27 0.35387) (0.28 0.35426) (0.29 0.35849) (0.30 0.36257) (0.31 0.36373)
;->  (0.32 0.36782) (0.33 0.36693) (0.34 0.36981) (0.35 0.36654) (0.36 0.36841)
;->  (0.37 0.36798) (0.38 0.37075) (0.39 0.36919) (0.40 0.37071) (0.41 0.36927)
;->  (0.42 0.36649) (0.43 0.36714) (0.44 0.36583) (0.45 0.36196) (0.46 0.35700)
;->  (0.47 0.35620) (0.48 0.35523) (0.49 0.35266) (0.50 0.34981) (0.51 0.34740)
;->  (0.52 0.34153) (0.53 0.33946) (0.54 0.33874) (0.55 0.32996) (0.56 0.32723)
;->  (0.57 0.32194) (0.58 0.31821) (0.59 0.31414) (0.60 0.31107) (0.61 0.30513)
;->  (0.62 0.29896) (0.63 0.29224) (0.64 0.28734) (0.65 0.28199) (0.66 0.28114)
;->  (0.67 0.26891) (0.68 0.26747) (0.69 0.25871) (0.70 0.25116) (0.71 0.24809)
;->  (0.72 0.23956) (0.73 0.23304) (0.74 0.22672) (0.75 0.21875) (0.76 0.21029)
;->  (0.77 0.20602) (0.78 0.19533) (0.79 0.18661) (0.80 0.18105) (0.81 0.17393)
;->  (0.82 0.16428) (0.83 0.15788) (0.84 0.14896) (0.85 0.13921) (0.86 0.13023)
;->  (0.87 0.12356) (0.88 0.11341) (0.89 0.10416) (0.90 0.09511) (0.91 0.08739)
;->  (0.92 0.07860) (0.93 0.06842) (0.94 0.05824) (0.95 0.04976) (0.96 0.03982)
;->  (0.97 0.03023) (0.98 0.01985))
;-> 964754.466

Come possiamo vedere, i risultati calcolati confermano la teoria, cioè il taglio ottimo è circa il 37%.

Per definire meglio la validità del metodo sarebbe interessante vedere quanto siamo lontani dal punteggio massimo, quando non selezioniamo la segretaria migliore utilizxzando il taglio ottimo. Per fare questo modifichiamo la funzione "secretary":

(define (secretary2 n prove)
  (local (cand taglio m1 m2 success found delta)
    (setq success 0)
    (setq delta 0)
    ;Definiamo il taglio
    ; 1/e = (div 1 (exp 1))) = 0.3678794411714423
    (setq taglio (round (div n (exp 1))))
    (for (i 1 prove)
      ; Generiamo la lista dei punteggi per le candidate
      (setq cand (randomize (sequence 0 (- n 1))))
      ;Calcoliamo il valore massimo FINO al taglio
      (setq m1 (apply max (slice cand 0 taglio)))
      ;Cerchiamo il primo valore > m1 dal resto della lista
      ;se non esiste tale valore, allora m2 vale l'ultimo candidato
      (setq m2 (last cand))
      (setq found nil)
      (dolist (el (slice cand taglio) found)
        (if (> el m1) (setq m2 el found true))
      )
      ;se m2 > max allora abbiamo scelto la candidata migliore
      ;(if (>= m2 (apply max cand) (++ success)))
      ;se m2 = (n - 1) allora abbiamo scelto la candidata migliore
      ;(if (= m2 (- n 1)) (++ success))
      (if (= m2 (- n 1)) (++ success))
      ;somma le distanze tra la candidata scelta e quella migliore
      (setq delta (+ delta (- (- n 1) m2)))
    )
    (println (div success prove))
    (println delta)
    (div delta prove)
  )
)

(secretary2 100 100000)
;-> 0.37281  ; percentuale di successo
;-> 1888047  ; totale distanze
;-> 18.88047 ; distanza media

(secretary2 1000 100000)
;-> 0.37051   ; percentuale di successo
;-> 18267139  ; totale distanze
;-> 182.67139 ; distanza media

Con questo metodo si seleziona una candidata che ha circa il 18% di punteggio inferiore alla candidata migliore (in media).


-----------------------
Numeri con tre divisori
-----------------------

Trovare tutti i numeri fino al milione che hanno tre divisori.
Ad esempio, il numero 10 ha quattro divisori: 1, 2, 5 e 10.

Scriviamo una funzione per calcolare i divisori di un numero N.

(define (divisori n)
  (local (lista-div m i)
    (setq lista-div '(1)) ; aggiungo il numero 1
    (setq m (int (sqrt n)))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è divisore di 'n'
            (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi aggiungine uno,
                              ; altrimenti aggiungili entrambi
              (push i lista-div -1)
              (begin (push i lista-div -1) (push (/ n i) lista-div -1))
            )
        )
        (++ i)
    )
    (push n lista-div -1) ; aggiungo il numero stesso
    (sort lista-div)
  )
)

(divisori 1000)
;-> (1 2 4 5 8 10 20 25 40 50 100 125 200 250 500 1000)

Facciamo una prova per vedere quanto tempo occorre per trovare la soluzione:

(define (prova n)
  (for (i 2 n)
    (if (= (length (divisori i)) 3) (println i { } (divisori i))))
)

(prova 1e6)
;-> 4 (1 2 4)
;-> 9 (1 3 9)
;-> 25 (1 5 25)
;-> 49 (1 7 49)
;-> 121 (1 11 121)
;-> 169 (1 13 169)
;-> 289 (1 17 289)
...
;-> 954529 (1 977 954529)
;-> 966289 (1 983 966289)
;-> 982081 (1 991 982081)
;-> 994009 (1 997 994009)

Vediamo quanti sono i numeri da ricercare:

(define (prova1 n)
  (let (out 0)
    (for (i 2 n)
      (if (= (length (divisori i)) 3) (++ out)))
  out
  )
)

(prova1 1e6)
;-> 168

(time (prova1 1e6))
;-> 94695.56 ; circa 95 secondi

La funzione è molto lenta, quindi cerchiamo di ottimizzarla. Inannzitutto la funzione "divisori" calcola una lista di divisori, ma a noi in interessa sapere soltanto se un numero ha esattamente 3 divisori.
Riscriviamo la funzione per i divisori:

(define (numdiv3 n)
  (local (num m i)
    (setq num 1) ; il numero 1
    (setq m (int (sqrt n)))
    (setq i 2)
    (while (<= i m)
        (if (zero? (% n i))   ; se 'i' è divisore di 'n'...
            (if (= i (/ n i)) ; se entrambi i divisori sono gli stessi ...
              (++ num)   ; allora aggiungine uno,
              (++ num 2) ; altrimenti aggiungili entrambi
            )
        )
        (if (> num 2) (setq i m)) ;numero da scartare
        (++ i)
    )
    (++ num 1) ; il numero stesso
  )
)

Proviamo questa nuova funzione:

(define (prova2 n)
  (let (out 0)
    (for (i 2 n)
      (if (= (numdiv3 i) 3) (++ out)))
  out
  )
)

(prova2 1e6)
;-> 168

(time (prova2 1e6))
;-> 12788.932 ; circa 13 secondi

Abbiamo ottenuto un buon miglioramento della velocità, ma possiamo fare meglio.

I divisori vengono in coppie, quindi per la maggior parte dei numeri il conteggio dei divisori è un numero pari. Per esempio, i divisori di 24 sono 1 e 24, 2 e 12, 3 e 8, e 4 e 6, quindi 24 ha 8 divisori.
L'unica volta in cui un numero può avere un numero dispari di divisori è quando il numero è un quadrato perfetto. Ad esempio, i divisori di 36 sono 1 e 36, 2 e 18, 3 e 12, 4 e 9 e 6 e 6, gli ultimi due sono duplicati, quindi 36 ha 9 divisori.
E l'unica volta in cui un numero può avere 3 divisori è quando il numero è un quadrato di un numero primo. Ad esempio, i divisori di 25 sono 1, 5 e 25.

Quindi possiamo modificare il ciclo for e controllare solo i numeri quadrati. In questo modo il valore di n passato alla funzione vale 1000, poichè 1000x1000 = 1000000 (un milione). Inoltre controlliamo solo i quadrati dei numeri dispari (perchè non esistono numeri primi pari oltre al numero 2).

(define (prova3 n)
  (let (out 1) ; il numero 4
    (for (i 3 n 2)
      (if (= (numdiv3 (* i i)) 3) (++ out)))
  out
  )
)

(prova3 1000)
;-> 168

(time (prova3 1000))
;-> 32.965

Questo è un miglioramento enorme. Provamo a modificare la funzione per testare anche se il numero è primo:

(define (prova4 n)
  (let (out 1) ; il numero 4
    (for (i 3 n 2)
      (if (= (length (factor i)) 1) ; se il numero è primo...
        (if (= (numdiv3 (* i i)) 3) (++ out)))
    )
  out
  )
)

(prova4 1000)
;-> 168

(time (prova4 1000))
;-> 30.968

I tempi di "prova3" e "prova4" sono quasi uguali (poichè il calcolo del numero primo pur eliminando molti numeri, ma richiede tempo).

Scriviamo la funzione finale che ritorna una lista con tutti i numeri che hanno 3 divisori:

(define (divisori3 n)
  (let (out '(4)); il numero 4
    (for (i 3 n 2)
      (if (= (length (factor i)) 1) ; se il numero è primo...
        (if (= (numdiv3 (* i i)) 3) (push (* i i) out -1)))
    )
  out
  )
)

(divisori3 1000)
;-> (4 9 25 49 121 169 289 361 529 841 961 1369 1681 1849 2209 2809
;->  3481 3721 4489 5041 5329 6241 6889 7921 9409 10201 10609 11449
;->  11881 12769 16129 17161 18769 19321 22201 22801 24649 26569
;->  27889 29929 32041 32761 36481 37249 38809 39601 44521 49729
;->  51529 52441 54289 57121 58081 63001 66049 69169 72361 73441
;->  76729 78961 80089 85849 94249 96721 97969 100489 109561 113569
;->  120409 121801 124609 128881 134689 139129 143641 146689 151321
;->  157609 160801 167281 175561 177241 185761 187489 192721 196249
;->  201601 208849 212521 214369 218089 229441 237169 241081 249001
;->  253009 259081 271441 273529 292681 299209 310249 316969 323761
;->  326041 332929 344569 351649 358801 361201 368449 375769 380689
;->  383161 398161 410881 413449 418609 426409 434281 436921 452929
;->  458329 466489 477481 491401 502681 516961 528529 537289 546121
;->  552049 564001 573049 579121 591361 597529 619369 635209 654481
;->  657721 674041 677329 683929 687241 703921 727609 734449 737881
;->  744769 769129 776161 779689 786769 822649 829921 844561 863041
;->  877969 885481 896809 908209 935089 942841 954529 966289 982081
;->  994009)

(length (divisori3 1000))
;-> 168

(time (divisori3 1000))
;-> 33.964


----------------------
Congettura di Goldbach
----------------------

Nel 1742, il matematico prussiano Christian Goldbach scrisse una lettera a Leonhard Euler in cui proponeva la seguente congettura:

  "Ogni numero intero maggiore di 2 può essere scritto come la somma di tre numeri primi."

Considerava 1 un numero primo, una convenzione successivamente abbandonata. Quindi oggi, la congettura originale di Goldbach sarebbe stata scritta:

  "Ogni numero intero maggiore di 5 può essere scritto come la somma di tre numeri primi."

Euler, diventando interessato al problema, rispose con una versione equivalente della congettura:

  "Ogni numero pari maggiore di 2 può essere scritto come la somma di due numeri primi,"

aggiungendo che lo considerava un teorema del tutto certo ("ein ganz gewisses Theorema"), nonostante non fosse in grado di dimostrarlo.

La prima congettura è oggi nota come congettura di Goldbach "ternaria" o "debole", la seconda come congettura di Goldbach  "binaria" o "forte". La congettura che tutti gli interi dispari maggiori di 9 siano la somma di tre numeri primi dispari è chiamata congettura di Goldbach "debole". Entrambe le domande sono rimaste irrisolte da allora, sebbene la forma debole della congettura sia molto più vicina alla risoluzione di quella forte.

La maggior parte dei matematici ha sempre ritenuto che la congettura (sia nella forma debole che in quella forte) sia vera, almeno per numeri interi sufficientemente grandi, principalmente basata su considerazioni statistiche incentrate sulla distribuzione probabilistica dei numeri primi: più grande è il numero, più modi ci sono disponibili affinché quel numero sia rappresentato come la somma di altri due o tre numeri e più "probabile" diventa che almeno una di queste rappresentazioni è costituita interamente da numeri primi.

Nel 2012 e 2013 Harald Helfgott ha pubblicato su internet due articoli che dimostrerebbero la congettura debole incondizionatamente per ogni intero maggiore di 7.

La congettura forte non è ancora stata dimostrata.

Vediamo come calcolare la coppia di numeri che soddisfano la congettura di Goldbach per ogni numero pari maggiore di due.

Utilizziamo il Crivello (sieve) di Eratostene per calcolare i numeri primi fino a n. Questa funzione restituisce un vettore di valori booleani dove l'indice i-esimo è primo se vettore(i) vale true.

(define (sieve n)
  (local (primi p)
    (setq primi (array (add 1 n) '(true)))
    (setf (primi 0) nil) ; 0 non è primo
    (setf (primi 1) nil) ; 1 non è primo
    (setq p 2)
    (while (<= (* p p) n)
      (if (= (primi p) true))
      (for (i (* p p) n p) (setq (primi i) nil))
      (++ p)
    )
    ; se vogliamo la lista dei numeri
    ;(slice (filter true? (map (fn (x) (if x $idx)) primi)) 2)
    ; se vogliamo la lista dei valori booleani (indicizzata)
    primi
  )
)

Adesso scriviamo la funzione che cerca la coppia di numeri primi che sommati valgono n:

(define (coppia n)
  (local (primi stop out)
    (setq primi (sieve n))
    (setq stop nil)
    ; attraversiamo la lista per trovare la prima coppia 
    ; di numeri primi che sommati valgono n
    (dolist (el primi stop)
       (if (and el (primi (- n $idx)))
           (begin 
            (setq stop true)
            (setq out (list $idx (- n $idx)))
           )
       )
    )
    out
  )
)

(coppia 4)
;-> (2 2)

Verifichiamo la congettura per valori fino a n:

(define (testGoldbach n)
  (local (primi out)
    (setq out '())
    (setq primi (sieve n))
    (for (i 4 n 2)
      (setq stop nil)
      (dolist (el primi stop)
        (if (and el (primi (- i $idx)))
            (begin 
              (setq stop true)
              ; se vogliamo stampare le coppie
              ;(println (list $idx (- i $idx)))
              ; se vogliamo memorizzare le coppie in una lista
              ;(push (list $idx (- i $idx)) out -1)
            )
        )
      )
      (if (null? stop) (println "errore con numero: " i))
    )
    ;out
    'fine
  )
)

(testGoldbach 10000)
;-> fine ; nessun errore

(time (testGoldbach 100000))
;-> 38084.502

Infine scriviamo la funzione che genera tutte le coppie di numeri primi che sommate valgono n:

(define (coppie n)
  (local (primi out)
    (setq out '())
    (setq primi (sieve n))
    ; attraversiamo la lista per trovare la prima coppia 
    ; di numeri primi che sommati valgono n
    (dolist (el primi)
       (if (and el (primi (- n $idx)))
           (push (list $idx (- n $idx)) out -1)
       )
    )
    out
  )
)

(coppie 20)
;-> ((3 17) (7 13) (13 7) (17 3))


-------------------------------------------
Problema dei travasi ed equazioni diofantee
-------------------------------------------

Avendo a disposizione una fontana e due recipienti, rispettivamente da 9 e da 15 litri, come si può a raccogliere precisamente 12 litri d’acqua?

In generale, dati due contenitori non graduati e una quantità infinita di liquido, è possibile avere, con una serie di riempimenti, svuotamenti e travasi, una fissata quantità in un solo recipiente?

Indichiamo con A e B i due contenitori e con a e b le loro capacità e c la quantità di liquido da ottenere. Dove a, b, c sono numeri naturali e (0 < c < max(a,b)).

Indichiamo con la coppia (x,y) un particolare stato del problema, caratterizzato dalla quantità di liquido x contenuto nel contenitore A e dalla quantità di liquido y contenuta in B. Dove x, y sono numeri naturali e (0 <= x <= a), (0 <= y <= b).

Lo stato iniziale è quindi rappresentato dalla coppia (0,0) e quello da raggiungere è (c,y) per qualche y, oppure (x,c) per qualche x.

Le azioni che permettono di passare da uno stato ad un altro sono descritte nel seguente schema:

Riempimenti
-----------
Azione         Risultato                            Vincoli
RiempiA        A viene completamente riempito.      A non deve essere pieno.
RiempiB        B viene completamente riempito.      B non deve essere pieno.

Travasi
-------
TravasoAB      A viene svuotato in B, fino a che    A non deve essere vuoto e
               A è vuoto oppure B è pieno.          B non deve essere pieno.
TravasoBA      B viene svuotato in A, fino a che    B non deve essere vuoto e
               B è vuoto oppure A è pieno.          A non deve essere pieno.

Svuotamenti
-----------
SvuotaA        A viene completamente svuotato.      A non deve essere vuoto.
SvuotaB        B viene completamente svuotato.      B non deve essere vuoto.

Adesso vediamo gli effetti delle azioni su un generico stato iniziale (x,y):

Iniziale      Azione      Finale
 (x,y)        RiempiA      (a,y)
 (x,y)        RiempiB      (x,b)
 (x,y)        TravasoAB    (0,x+y) oppure (x+y-b,b)
 (x,y)        TravasoBA    (x+y,0) oppure (a,x+y-a)
 (x,y)        SvuotaA      (0,y)
 (x,y)        SvuotaB      (x,0)

Nota: se si parte dallo stato (0,0) non si ottengono mai stati in cui 0 < x < a e 0 < y < b.

Ogni problema dei travasi con contenitori di capienza a e b e quantità da realizzare c può essere formalizzato nel modo seguente:

Dati tre numeri naturali a, b, c Îe 0 < c < max(a,b), trovare una sequenza di azioni che permetta di passare dallo stato iniziale (0,0) a quello (c,y) per qualche y, oppure a quello (x, c) per qualche x.

Per risolvere il problema ci servono alcune nozioni di teoria di numeri.

Teorema della divisione e del resto
-----------------------------------
Dati due numeri interi a e b esistono solo due numeri interi q e r che soddisfano la seguente relazione:

  a = q*b + r  con 0 <= r < b

q prende il nome di “quoziente” della divisione di a per b
r prende il nome di “resto” della divisione di a per b

Ddefinizione: equazioni diofantee di primo grado
------------------------------------------------
Si dice equazione diofantea (di 1° grado) ogni equazione della forma:

ax + by = c

dove a, b, c numeri interi relativi e a e b non entrambi nulli

Si dice soluzione dell’equazione diofantea ogni coppia (x0,y0) con x0 e y0 numeri interi relativi tale che:

a*x + b*y = c

Teorema fondamentale delle equazioni diofantee di primo grado
-------------------------------------------------------------
Un'equazione diofantea di primo grado

  ax + by = c

con a, b, c numeri interi relativi e a e b non entrambi nulli ha soluzioni se e solo se c è un multiplo del Massimo Comun Denominatore di (a,b).

In tal caso se (x0,y0) è una soluzione dell’equazione, tutte le soluzioni (x(n),y(n)) si trovano con le formule:

                    b                              a
    x(n) = x0 + ----------*n       y(n) = y0 + ----------*n
                 MCD(a,b)                       MCD(a,b)

al variare di n.

Nota: se a e/o b sono negativi si considera il MCD dei loro valori assoluti.

Esempio: 8x - 6y = 26
a = 8
b = -6
c = 26
MCD(8, 6) = 2

Quindi c è multiplo di MCD(a,b): (26 mod 2) = 0
Una soluzione vale (1,-3), quindi tutte le soluzioni si ottengono dalle formule:

                b                  -6
x(n) = x0 + ----------*n = 1 + ----------*n = 1 - 3*n
             MCD(a,b)           MCD(8,6)

                a                   8
y(n) = y0 + ----------*n = -3 + ----------*n = -3 - 4*n
             MCD(a,b)            MCD(8,6)

Quindi risulta:
...
n = -2 --> (7,5)
n = -1 --> (4,1)
n = 0  --> (1,-3)
n = 1  --> (-2,-7)
n = 2  --> (-5,-11)
...

Vedremo in seguito come viene calcolata la prima soluzione (x0,y0). Adesso dobbiamo vedeere quali sono le possibili strategie per risolvere il problema.

Strategia Destra
----------------
Si definisce "strategia destra" ogni sequenza di azioni che segue le seguenti regole:
1) Se A è vuoto lo si riempie con RiempiA.
2) Se A non è vuoto lo si svuota con un numero finito di travasi TravisaAB e
svuotamenti SvuotaB di B fino ad uno stato (0,y) con y<b.

Strategia Sinistra
------------------
Si definisce "strategia sinistra" ogni sequenza di azioni che segue le seguenti regole:
1) Se B è vuoto lo si riempie con RiempiB
2) Se B non è vuoto lo si svuota con un numero finito di travasi TravasiBA e
svuotamenti SvuotaA di A fino ad uno stato (x,0) con x<a.

Nota: si osservi che applicando la strategia destra (sinistra) a partire dallo stato (0,0) si effettua un primo riempimento di A (di B) (regola 1), poi si raggiunge lo stato (0,y) con y<b (lo stato (x,0) con x<a) (regola 2), da qui si può ricominciare e andare avanti quanto si vuole alternando le regole 1 e 2.
Si noti inoltre che nella strategia destra (sinistra) per ogni stato ottenuto del tipo (0,y) (del tipo (x,0)) si ha y = n*a - m*b (x = n*b - m*a) dove n è il numero di riempimenti di A (di B) e m il numero di svuotamenti di B (di A).

Adesso siamo in grado di definire in quali casi il problema dei travasi ha una soluzione.

Teorema
Dati tre numeri naturali a, b, c con 0 < c < max(a,b) CNES affinché il problema dei travasi con contenitori di capienza a, b e quantità da realizzare c sia risolubile, è che c sia un multiplo di MCD(a,b).

Applichiamo ora il teorema appena dimostrato al problema dei travasi proposto all'inizio.
Avendo a disposizione una fontana e due recipienti, rispettivamente da 9 e da 15 litri, come si può a raccogliere precisamente 12 litri d’acqua?
In virtù del teorema il problema è risolubile perché 12 è un multiplo di MCD(9,15)=3.
Mostreremo ora come la strategia destra permette di raggiungere lo stato (0,6) e la
strategia sinistra lo stato (6,0).

Strategia destra
Inizio  Azione     Fine
(0,0)   RiempiA    (9,0)
(9,0)   TravasoAB  (0,9)
(0,9)   RiempiA    (9,9)
(9,9)   TravasoAB  (3,15)
(3,15)  SvuotaB    (3,0)
(3,0)   TravasoAB  (0,3)
(0,3)   RiempiA    (9,3)
(9,3)   TravasoAB  (0,12)

Strategia sinistra
Inizio  Azione     Fine
(0,0)   RiempiB    (0,15)
(0,15)  TravasoBA  (9,6)
(9,6)   SvuotaA    (0,6)
(0,6)   RiempiB    (6,15)
(6,15)  TravasoBA  (9,12)
(9,12)  SvuotaA    (0,12)
(0,12)  TravasoBA  (12,0)

Osserviamo che nella strategia sinistra le ultime due azioni sono inutili ai fini della
risoluzione del problema, ed eliminandole, la strategia sinistra si dimostra in questo caso "migliore": 6 azioni per quella sinistra contro le 8 di quella destra.

Per finire vediamo un algoritmo per trovare la soluzione (x0,y0), se esiste, di una equazione diofantea lineare a due incognite.

Possiamo usare l'algoritmo euclideo esteso. Innanzitutto, supponiamo che a e b siano non negativi. Quando applichiamo l'algoritmo euclideo esteso per a e b, possiamo trovare il loro massimo comune divisore g e due numeri xg e yg tali che:

a*xg + b*yg = g

Se c è divisibile per g = gcd(a, b), allora l'equazione diofantea data ha una soluzione, altrimenti non ha alcuna soluzione. La dimostrazione è semplice: una combinazione lineare di due numeri è sempre divisibile per il loro comune divisore.

Ora supponiamo che c sia divisibile per g, quindi abbiamo:

a*xg*c/g + b*yg*c/g = c

Pertanto una delle soluzioni dell'equazione diofantea è:

x0 = xg*c/g
y0 = yg*c/g

Questo metodo funziona anche quando a e/o b sono negativi.

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
    ; Adesso la variabile a contine il valore di gcd
    ;(println a { } b { } x { } y { } lastx { } lasty)
    (list a lastx lasty)))

(gcdex 120 23)
;-> 1 0 23 -120 -9 47
;-> (-9 47)

(gcdex 8 -6)
;-> 2 0 3 4 1 1
;-> (1 1)

(define (diofanto a b c)
  (local (gcdex-lst g xg yg out)
    (setq out '())
    (setq gcdex-lst (gcdex a b))
    (setq g (first gcdex-lst))
    (setq xg (first (rest gcdex-lst)))
    (setq yg (last gcdex-lst))
    (println g { } xg { } yg)
    (cond ((not (zero? (% c g))) (setq out '()))
          (true
            (setq out (list (div (mul xg c) g) (div (mul yg c) g)))))
    out))

(diofanto 8 -6 26)
;-> 2 1 1 
;-> (13 13)

Infatti risulta:

(+ (* 13 8) (* 13 -6))
;-> 26


---------------
Primi circolari
---------------

Un numero primo è circolare se i numeri che otteniamo da tutte le sue rotazioni sono primi. Per esempio il numero 3779 è un nuero primo circolare perchè risulta:

numero base: 3779 -> numero primo
rotazione 1: 7793 -> numero primo
rotazione 2: 7937 -> numero primo
rotazione 3: 9377 -> numero primo

Trovare tutti i numeri primi circolari sotto al milione.

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

(define (prime-rot n)
  (local (num cand valid)
    (for (i 2 n)
      ; se i è primo
      (if (primo? i)
        (begin
           ; controlliamo se sono primi i numeri ruotati
           (setq cand i)
           (setq valid true)
           (for (i 1 (- (length cand) 1) 1 (not valid))
             (setq cand (int (rotate (string cand))))
             (if (not (primo? cand)) (setq valid nil))
           )
           ; se il numero è valido, allora lo stampiamo
           (if valid (print i { }))
        ))
    )
    'end
  )
)

(prime-rot 1000000)
;-> 2 3 5 7 11 13 17 31 37 71 73 79 97 113 131 197 199 311 337
;-> 373 719 733 919 971 991 1193 1931 3119 3779 7793 7937 9311
;-> 9377 11939 19391 19937 37199 39119 71993 91193 93719 93911
;-> 99371 193939 199933 319993 331999 391939 393919 919393
;-> 933199 939193 939391 993319 999331 end

(time (prime-rot 1000000))
;-> ;-> 1368.633


---------------------------------
Radici di un polinomio (Bairstow)
---------------------------------

Questo programma utilizza il metodo di Bairstow per trovare le radici reali e complesse di un poliomiale con coefficienti reali. Il metodo fornisce un processo iterativo per trovare le radici reali e complesse usando solo l'aritmetica reale.

Inoltre, poiché si basa sul metodo di Newton per un sistema di due equazioni non lineari in due incognite, ha la proprietà di convergenza rapida del metodo di Newton per i sistemi di equazioni. Il principale svantaggio di questo metodo è che a volte non coverge alla soluzione. Questo perché è difficile trovare un'ipotesi iniziale che soddisfi le rigide condizioni necessarie per assicurare la convergenza. Quando queste condizioni non sono soddisfatte, la sequenza di approssimazioni può allontanarsi dalle radici desiderate o può iterare indefinitamente intorno alle radici.

Il programma ottiene un'approssimazione iniziale a due radici del polinomio e usa queste due radici per stimare i valori iniziali iniziali dell'interazione di Bairstow. Questi valori sono i coefficienti r e s di un fattore quadratico approssimativo x^2 + rx + s, del polinomio dato. Il polinomio dato passerà attraverso la divisione sintetica per il fattore quadratico che alla fine fornirà tutte le radici reali o complesse in forma singola o in coppia a seconda del grado del polinomio.

Il programma è la traduzione in newLISP del programma in C disponibile all'indirizzo:

https://github.com/DipakMajhi/Roots_of_a_Polynomial

in cui potete trovare anche un articolo (pdf) con tutte le spiegazioni sull'algoritmo.

(define (linear a0 a1)
  ;(println (sub (div a0 a1)))
  (push (list (sub (div a0 a1))) sol -1))

(define (quadratic t r s)
  (local (deter x1 x2 x1r x1i x2r x2i)
    (setq deter (sub (mul r r) (mul 4 s t)))
    ;(println t { } r { } s)
    (cond ((>= deter 0)
           (setq x1 (div (add (sub r) (sqrt deter)) (mul 2 t)))
           (setq x2 (div (sub (sub r) (sqrt deter)) (mul 2 t)))
           ;(println "x1: " x1 { } "x2: " x2)
           (push (list x1 x2) sol -1)
          )
          (true
           (setq x1r (div (sub r) (mul 2 t)))
           (setq x1i (div (sqrt (abs deter)) (mul 2 t)))
           (setq x2r x1r)
           (setq x2i (sub x1i))
           ;(println "x1r: " x1r { , } "x1i: " x1i)
           ;(println "x2r: " x2r { , } "x2i: " x2i)
           (push (list (list x1r x1i) (list x2r x2i)) sol -1)
          ))))

(define (bairstow coeff)
  (local (w j i n
          t deter p q x1 x2 x1r x1i r s ds dr
          a b c d sol)
    (setq sol '())
    (setq x1 0.0)
    (setq x2 0.0)
    (setq r 0.1)
    (setq s 0.1)
    (setq a (array 100 '(0)))
    (setq b (array 100 '(0)))
    (setq c (array 100 '(0)))
    (setq d (array 100 '(0)))
    (setq (b 4) 0)
    (setq (b 3) 0)
    ;assegna i coefficienti al vettore "a"
    (dolist (el (reverse coeff))
      (setq (a $idx) el)
    )
    ;(println a)
    (setq n (- (length coeff) 1))
    (setq w n)
    (cond ((= w 1) (linear (a 0) (a 1)) (-- w))
          ((= w 2) (quadratic (a 2) (a 1) (a 0)) (setq w (- w 2)))
          (true
           (while (>= w 3)
             (for (j 1 50)
               (setq (b n) (a n))
               (setq (b (- n 1)) (sub (a (- n 1)) (mul r (b n))))
               (for (i (- n 2) 1 -1)
                 (setq (b i) (sub (a i) (mul r (b (+ i 1))) (mul s (b (+ i 2)))))
               )
               (setq (b 0) (sub (a 0) (mul s (b 2))))
               (setq (c n) (b n))
               (setq (c (- n 1)) (sub (b (- n 1)) (mul r (c n))))
               (for (i (- n 2) 2 -1)
                 (setq (c i) (sub (b i) (mul r (c (+ i 1))) (mul s (c (+ i 2)))))
               )
               (setq (c 1) (sub (mul s (c 3))))
               (setq (d n) (b n))
               (setq (d (- n 1)) (sub (b (- n 1)) (mul r (d n))))
               (for (i (- n 2) 3 -1)
                 (setq (d i) (sub (b i) (mul r (d (+ i 1))) (mul s (d (+ i 2)))))
               )
               (setq (d 2) (sub (b 2) (mul s (d 4))))
               (setq dr (div
                        (sub (mul (b 0) (d 3)) (mul (b 1) (d 2)))
                        (add (mul (sub (d 2) (mul r (d 3))) (d 2)) (mul s (d 3) (d 3)))))
               (setq ds (div
                        (sub (add (mul (b 1) s (d 3)) (mul (b 0) (sub (d 2) (mul r (d 3))))))
                        (add (mul (sub (d 2) (mul r (d 3))) (d 2)) (mul s (d 3) (d 3)))))
               (setq p (sub r dr))
               (setq q (sub s ds))
               (setq r p)
               (setq s q)
            )
            (setq t 1)
            (quadratic t r s)
            (setq w (- w 2))
            (for (i n 0 -1)
              (setq (a (- n i)) (b (- n i)))
            )
            (for (i n 0 -1)
              (setq (a (- n i)) (a (+ (- n i) 2)))
            )
          )
          (cond ((= w 2) (quadratic (b 4) (b 3) (b 2)) (setq w (- w 2)))
                ((= w 1) (linear (b 2) (b 3)) (-- w))
          )
        )
    )
    sol
  )
)

Vediamo alcuni esempi:

4x - 32 = 0
(bairstow '(4 32))
;-> ((-8))

2x^2 -4x + 10 = 0
(bairstow '(2 -4 10))
;-> (((1 2) (1 -2)))

x^2 -3x + 2 = 0
(bairstow '(1 -3 2))
;-> ((2 1))

4x^3 + 2x^2 -4*x + 10 = 0
(bairstow '(4 2 -4 10))
;-> (((0.6563019928818721 0.9739090873711072) 
;->   (0.6563019928818721 -0.9739090873711072))
;->  (-1.812603985763744))
WolframAlpha
x≈0.656301992881872 + 0.973909087371107 i
x≈0.656301992881872 - 0.973909087371107 i
x≈-1.81260398576374

3x^4 - 2x^3 - x^2 + 4x + 10 = 0
(bairstow '(3 -2 -1 4 10))
;-> (((-0.871136997600388 0.7358894057211269) 
;->   (-0.871136997600388 -0.7358894057211269))
;->  ((1.204470330933721 1.054769962446627) 
;->   (1.204470330933721 -1.054769962446627)))
WolframAlpha
x≈-0.871136997600388 + 0.735889405721127 i
x≈-0.871136997600388 - 0.735889405721127 i
x≈1.20447033093372 + 1.05476996244663 i
x≈1.20447033093372 - 1.05476996244663 i

5x^5 - 4x^4 + 7x^3 + 8x^2 + 9x + 3 = 0
(bairstow '(5 -4 7 8 9 3))
;-> (((-0.3480864445180198 0.6520958216175604) 
;->   (-0.3480864445180198 -0.6520958216175604))
;->  ((0.9531760543651267 1.329888453606416) 
;->   (0.9531760543651267 -1.329888453606416))
;->  (-0.4101792196942135))
WolframAlpha
x≈-0.348086 - 0.652096 i
x≈-0.348086 + 0.652096 i
x≈0.953176 - 1.32989 i
x≈0.953176 + 1.32989 i
x≈-0.410179

x^9 - 2x^8 + 3x^7 + 0x^6 + 5x^5 - 4x^4 + 7x^3 + 8x^2 + 9x + 3 = 0
(bairstow '(1 -2 3 0 5 -4 7 8 9 3))
;-> (((-0.3612218566283093 0.6913476051961196) 
;->   (-0.3612218566283093 -0.6913476051961196))
;->  ((-0.739130448788589 0.9706810141091354) 
;->   (-0.739130448788589 -0.9706810141091354))
;->  ((1.251229097959007 1.099346245887554) 
;->   (1.251229097959007 -1.099346245887554))
;->  ((1.053720393127137 1.34449644051663) 
;->   (1.053720393127137 -1.34449644051663))
;->  (-0.4091943713384922))

WolframAlpha
x≈-0.361222 + 0.691348 i
x≈-0.361222 - 0.691348 i
x≈-0.73913 + 0.970681 i
x≈-0.73913 - 0.970681 i
x≈1.25123 + 1.09935 i
x≈1.25123 - 1.09935 i
x≈1.05372 + 1.3445 i
x≈1.05372 - 1.3445 i
x≈-0.409194

Calcoliamo il valore del polinomio per una radice:
x^9 - 2 x^8 + 3 x^7 + 0 x^6 + 5 x^5 - 4 x^4 + 7 x^3 + 8 x^2 + 9 x + 3 
dove x = 1.251229097959007 - 1.099346245887554 i
Risultato:
2.99×10^-14 + 6.8×10^-15 i


-------------
Nomi ordinati
-------------

Abbiamo una lista con alcuni nomi in ordine alfabetico:

(andrea bea carla eva francesca marco pietro roberta sandra)

Se mischiamo i nomi della lista:

1) qual'è la probabilità che la lista mischiata sia ordinata come quella iniziale?
2) qual'è la probabilità che almeno un nome sia allo stesso posto della lista iniziale?
3) qual'è la probabilità limite del punto 2) al tendere di n all'infinito (n = numero dei nomi)?

Vediamo di calcolare queste probabilità prima con delle simulazioni e poi matematicamente.

1) qual'è la probabilità che la lista mischiata sia ordinata come quella iniziale?

(define (prob1 n)
  (local (base test conta)
    (setq conta 0)
    (setq base '(andrea bea carla eva francesca marco pietro roberta sandra))
    (setq test (randomize base))
    (for (i 1 n)
      (setq test (randomize test))
      (if (= base test) (++ conta))
    )
    (list conta n (div conta n))
  )
)

(prob1 1000000)
;-> (3 1000000 3e-006)

(prob1 10000000)
;-> (28 10000000 2.8e-006)

(prob1 100000000)
;-> (251 100000000 2.51e-006)

Matematicamante risulta che esistono 9!=362880 possibilità di ordinare la lista. Quindi la probabilità cercata vale:

prob1 = 1 / 9! = (div 1 362880) = 2.755731922398589e-006

2) qual'è la probabilità che almeno un nome sia allo stesso posto della lista iniziale?
Per semplificare il codice consideriamo una lista costituita da soli numeri:

(1 2 3 4 5 6 7 8 9)

In questo modo due liste hanno un elemento in comune se troviamo almeno uno 0 nella differenza tra gli elementi delle due liste:

(if (find 0 (map - base test)) (++ conta))

(define (prob2 n)
  (local (base test conta)
    (setq conta 0)
    (setq base '(1 2 3 4 5 6 7 8 9))
    (setq test (randomize base))
    (for (i 1 n)
      (setq test (randomize test))
      (if (find 0 (map - base test)) (++ conta))
    )
    (list conta n (div conta n))
  )
)

(prob2 100)
;-> (60 100 0.6)
(prob2 1000)
;-> (632 1000 0.632)
(prob2 10000)
;-> (6238 10000 0.6238)
(prob2 100000)
;-> (63361 100000 0.63361)
(prob2 1000000)
;-> (632357 1000000 0.632357)
(prob2 10000000)
;-> (6320110 10000000 0.632011)

Dal punto di vista matematico considerando una lista con i primi 5 numeri abbiamo:

P(1) = 1/5 e

P(1 e 2) = 1/5 * 1/4

Utilizziamo il principio di inclusione-esclusione per calcolare la probabilità che il numero 1 o 2 o 3 o 4 o 5 sia piazzato correttamente (almeno uno).

P(1 o 2 o 3 ... o 5) = P(1) + P(2) + P(3) + P(4) + P(5)
                       - P(1 e 2) - P(2 e 3) - ...
                       + P(1 e 2 e 3) + P(2 e 3 e 4) + ...
                       - P(1 e 2 e 3 e 4) - P(2 e 3 e 4 e 5) - ...
                       + P(1 e 2 e 3 e 4 e 5)

                     = 5*(1/5)
                       - 5*2*(1/5)(1/4)
                       + 5*3*(1/5)(1/4)(1/3)
                       - 5*4*(1/5)(1/4)(1/3)(1/2)
                       + (1/5)*(1/4)*(1/3)*(1/2)*(1/1)

        5*4    1    5*4*3     1      5*4*3*2       1          1
  = 1 - --- * --- + ----- * ----- - --------- * ------- + ---------
        1*2   5*4   1*2*3   5*4*3    1*2*3*4    5*4*3*2   5*4*3*2*1

  = 1 - 1/2! + 1/3! - 1/4! + 1/5! =

  = 1 - 0.5 + 0.166666667 - 0.041666667 + 0.008333333 = 0.633333333

Questa è la probabilità che almeno uno dei 5 numeri sia piazzato correttamente.

La formula generalizzata per n numeri è la seguente:

P = 1 - (-1)^n 1/n!

Nel caso di nove elementi risulta:

P(nove) = 1 - 0.5 + 0.166666667 - 0.041666667 + 0.008333333
          - 0.001388889 + 0.000198413 - 2.48016E-05 + 2.75573E-06 = 0.632120811

Quindi il valore calcolato matematicamente corrisponde al valore della simulazione.

3) qual'è la probabilità che almeno un nome sia allo stesso posto della lista iniziale quando il numero n dei nomi/elementi tende all'infinito?

La formula da considerare è la seguente:

sum[2 <= n <= ∞] (1 - (-1)^n/(n!))

Scriviamo la funzione che calcola la probabilità per una lista con n elementi:

; funzione fattoriale per biginteger
(define (fact n) (apply * (map bigint (sequence 1 n))))

(define (prob3 n)
  (local (val)
    (setq val 1L)
    (for (i 2 n)
      (setq val (sub val (div (pow -1 i) (fact i))))
    )
    val))

Controlliamo il risultato del secondo quesito:

(prob3 9)
;-> 0.632120811287478

Vediamo cosa accade quando cresce il valore di n:

(prob3 50)
;-> 0.6321205588285578
(prob3 100)
;-> 0.6321205588285578
(prob3 200)
;-> 0.6321205588285578

Nota: (1 - 1/e) = 0.6321205588285578

(sub 1 (div 1 (exp 1)))
;-> 0.6321205588285577


