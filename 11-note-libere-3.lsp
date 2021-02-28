===============

 NOTE LIBERE 3

===============

---------------------------------
Generazione di un simbolo univoco
---------------------------------

Se abbiamo la necessità di generare un simbolo univoco utilizziamo la funzione "uuid" che costruisce e ritorna un identificatore unico (stringa) chiamato UUID (Universally Unique IDentifier).

(uuid)
;-> "3FD45C9C-1313-4ACF-B720-C42CF6319E0C"

Purtroppo non è un simbolo legale per newLISP (perchè inizia con un numero):

(legal? (uuid))
;-> nil

Allora scriviamo una funzione per generare un simbolo univoco legale:

(define (gensym)
  (sym (string "g-" (uuid)))) ; 'g-*** è un simbolo legale

(gensym)
;-> g-7E31347F-6EEB-477E-BFF0-4868BE374F6B
(gensym)
;-> g-4DE95DAB-4A11-431F-9EBE-D267E9646C4C
(gensym)
;-> g-5ECA1A6B-6E8B-4ADB-9189-D352CE488876

La funzione "gensym" genera sempre un simbolo univoco.


------------------------------
Compromessi tra tempo e spazio
------------------------------

Supponiamo di dover scrivere una funzione che verifica se ci sono duplicati in una lista.
Il primo metodo che viene in mente è quello di attraversare la lista con due cicli e verificare se i valori correnti sono uguali.

(define (dup1? lst)
  (let ((found nil) (idx1 -1) (idx2 -1))
    (dolist (el1 lst)
      (setq idx1 $idx)
      (dolist (el2 lst)
        (setq idx2 $idx) ;per semplicità
        (if (and (!= idx1 idx2) (= el1 el2))
            (setq found true))))
    found))

(dup1? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup1? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup1? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Il tempo di esecuzione non dipende dall'ordine dei valori nella lista.

(time (dup1? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 1458.268
(time (dup1? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 1444.711
(time (dup1? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 1443.694

Questa funzione ha complessità temporale O(n^2).
Possiamo migliorare la velocità della funzione uscendo dal ciclo quando incontriamo la prima coppia di valori uguali. Per fare questo aggiungiamo la condizione "found" ad ogni ciclo "dolist":

(define (dup2? lst)
  (let ((found nil) (idx1 -1) (idx2 -1))
    (dolist (el1 lst found) ;esce dal ciclo quando found diventa true
      (setq idx1 $idx)
      (dolist (el2 lst found) ;esce dal ciclo quando found diventa true
        (setq idx2 $idx) ;per semplicità
        (if (and (!= idx1 idx2) (= el1 el2))
            (setq found true))))
    found))

(dup2? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup2? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup2? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Questa funzione ha complessità temporale che varia a seconda che la lista contenga duplicati o meno. Quando ci sono duplicati ha complessità temporale O(n), viceversa, quando non ci sono duplicati ha complessità temporale O(n^2). Comunque la complessità temporale vale O(n^2), anche se la funzione è (in media) più veloce.

(time (dup2? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 147.633
(time (dup2? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 55.011 ; più veloce perchè il duplicato (1) si trova all'inizio della lista
(time (dup2? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 1507.185

Possiamo scrivere un'altra funzione che utilizza una hash-map:

(define (dup3? lst)
  (let ((found nil))
    (new Tree 'myHash)
    (dolist (el lst found)
      ; se l'elemento corrente non esiste nella hash-map...
      (if (nil? (myHash el))
          (myHash el el)    ; allora inseriscilo
          (setq found true) ; altrimenti è un duplicato
      )
    )
    (delete 'myHash) ; eliminiamo l'hash-map
    found))

(dup3? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup3? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup3? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Questa funzione ha complessità temporale O(n) poichè utilizza soltanto un ciclo (supponendo che le operazioni di "get" e "put" della hash-map siano O(1)).
Vediamo i tempi di esecuzione:

(time (dup3? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 1096.76
(time (dup3? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 675.509
(time (dup3? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 1121.185

Come mai i tempi di esecuzione sono sono superiori di quelli della funzione "dup2?" ?
Il problema si trova nell'operazione di cancellazione della hash-map che richiede tanto tempo. Possiamo evitare la cancellazione se generiamo ogni volta una hash-map diversa (vedi la sezione "Generazione automatica di una hash-map"):

Funzione per creare un simbolo legale in newLISP:

(define (gensym)
  (sym (string "g-" (uuid))))

(define (dup4? lst)
  (let ((found nil) (hm nil))
    ;(new Tree 'myHash)
    (setq hm (new Tree (gensym) true))
    (dolist (el lst found)
      ; se l'elemento corrente non esiste nella hash-map...
      (if (nil? (hm el))
          (hm el el)    ; allora inseriscilo
          (setq found true) ; altrimenti è un duplicato
      )
    )
    ;(delete 'myHash) ; non eliminiamo l'hash-map
    found))

(dup4? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup4? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup4? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Questa funzione, come la precedente, ha complessità temporale O(n), ma impiega funzioni primitive complesse (es. uuid) che rallentano l'esecuzione:

(time (dup4? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 730.16
(time (dup4? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 349.212
(time (dup4? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 803.067

Possiamo scrivere un'altra funzione utilizzando la funzione integrata "sort":

(define (dup5? lst)
  (let (found nil)
    (sort lst)
    (for (i 0 (- (length lst) 2))
      (if (= (lst i) (lst (+ i 1)))
          (setq found true)))
    found))

(dup5? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup5? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup5? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Questa funzione ha complessità temporale O(n*log(n)) in quanto l'operazione di sort ha complessità O(n*log(n)) (il ciclo for aumenta i tempi di esecuzione, ma non modifica la complessità):

(time (dup5? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 154.001
(time (dup5? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 156.054
(time (dup5? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 155.701

Infine, utilizziamo la funzione integrata "unique" per scrivere un'altra funzione:

(define (dup6? lst) (!= (unique lst) lst))

(dup6? '(1 2 3 4 5 6 7 8 9 10 11 1))
;-> true
(dup6? '(1 1 2 3 4 5 6 7 8 9 10 11))
;-> true
(dup6? '(1 2 3 4 5 6 7 8 9 10 11 12))
;-> nil

Per capire la complessità temporale di questa funzione occorrerebbe analizzare i sorgenti di newLISP, ma dovrebbe essere simile a O(n*log(n). Vediamo i tempi di esecuzione:

(time (dup6? '(1 2 3 4 5 6 7 8 9 10 11 1)) 100000)
;-> 96.755
(time (dup6? '(1 1 2 3 4 5 6 7 8 9 10 11)) 100000)
;-> 93.268
(time (dup6? '(1 2 3 4 5 6 7 8 9 10 11 12)) 100000)
;-> 96.36

Adesso vediamo la complessità spaziale delle funzioni, considerando lo spazio addizionale che viene richiesto.
Le funzioni dup1? e dup2? non richiedono spazio aggiuntivo in memoria, quindi la complessità spaziale vale O(1).
La funzione dup3? richie una hash-map con n valori, quindi la complessità spaziale vale O(n).
La funzione dup4? richiede una hash-map con n valori per n volte (perchè ogni volta creiamo una hash-map diversa), quindi la complessità spaziale vale O(n^2).
Presumiamo che le funzioni dup5? e dup6? abbiano una complessità spaziale O(log(n)) (questa è la complessità spaziale dell'algoritmo di ordinamento Quicksort).

Ricapitoliamo le caratteristiche delle funzioni:

           Complessità   Tempi             Complessità
Funzione   temporale     di esecuzione     spaziale
 dup1?      O(n^2)        1458 1444 1443    O(1)
 dup2?      O(n^2)         147   55 1507    O(1)
 dup3?      O(n)          1096  675 1121    O(n)
 dup4?      O(n)           730  349  803    O(n^2)
 dup5?      O(n*log(n))    154  156  155    O(log(n))
 dup6?      O(n*log(n))     96   93   96    O(log(n))

Quindi per scrivere una funzione efficiente in termini di tempo di esecuzione l'algoritmo è molto importante, ma occorre preferire l'uso di funzioni integrate (se presenti). Un'altra considerazione fondamentale riguarda lo spazio di memoria utilizzato in quanto non sempre la funzione più veloce è anche quella che consuma meno spazio. La scelta della funzione finale dipende dall'analisi e dalla valutazione di queste caratteristiche.


----------------
Scambio di somme
----------------

Date due liste di numeri interi i cui relativi elementi sommano ad una certa cifra, determinare due numeri (ognuno in una lista) che scambiati tra loro producono somme uguali per le due liste. Esempio:

lista1: (5 3 2 9 1)  Somma = 5 + 3 + 2 + 9 + 1 = 20
lista2: (1 12 5)     Somma = 1 + 12 + 5 = 18

Scambiando il numero 2 della lista1 con il numero 1 della lista2 entrambe le liste sommano a 19.

Se non è possibile ottenere due liste con somme uguali allora la funzione deve restituire nil.

La soluzione più semplice è quella di utilizzare due cicli che attraversano le liste e verificano se scambiando gli elementi correnti si ottengono due somme uguali per le liste.

(define (scambio lst1 lst2)
  (local (out idx1 idx2 found)
    (setq out nil found nil)
    (dolist (el1 lst1 found)
      (setq idx1 $idx)
      (dolist (el2 lst2 found)
        (setq idx2 $idx)
        ; se scambiando questi valori le somme sono uguali...
        (if (= (+ (- (apply + lst1) el1) el2) (+ (- (apply + lst2) el2) el1))
            ; allora salviamo gli indici
            (setq out (list idx1 idx2) found true)
        )
      )
    )
    (if (nil? out) out
        (begin
        (swap (lst1 (first out)) (lst2 (last out)))
        (setq out (list out (apply + lst1) (apply + lst2)))))
    out))

(scambio lst1 lst2)
;-> ((2 0) 19 19)

(scambio '(1 -1 2 4) '(2 3 4 -1))
;-> ((0 0) 7 7)

(scambio '(1 -1 2 5) '(2 3 8 -1))
;-> nil

La complessità temporale vale O(n*m), dove n e m sono le lunghezze delle liste.

Per cercare un algoritmo migliore dobbiamo analizzare alcuni casi:

(setq lst1 '(5 3 3 7))  Somma = 18
(setq lst2 '(4 1 1 6))  Somma = 12
(scambio lst1 lst2)
;-> ((3 0) 15 15)
Scambiamo il 7 con il 4:
(setq lst1 '(5 3 3 4))  Somma = 15
(setq lst2 '(7 1 1 6))  Somma = 15

(setq lst1 '(1 2 3 4 5)) Somma = 15
(setq lst2 '(6 7 8))     Somma = 21
(scambio lst1 lst2)
;-> ((2 0) 18 18)
Scambiamo il 3 con il 6:
(setq lst1 '(1 2 6 4 5)) Somma = 18
(setq lst2 '(3 7 8))     Somma = 18

(setq lst1 '(10 15 20)) Somma = 45
(setq lst2 '(5 30))     Somma = 35
(scambio lst1 lst2)
;-> ((0 0) 40 40)
Scambiamo il 10 con il 5:
(setq lst1 '(5 15 20))  Somma = 40
(setq lst2 '(10 30))    Somma = 40

Possiamo notare queste caratteristiche:

1) per ottenere somme uguali, la lista con la somma più grande deve scambiare un numero maggiore con un numero minore della lista con la somma più piccola.

2) Lo scambio provoca una modifica delle somme della stessa quantità (dopo lo scambio la somma di una lista vale (somma-iniziale + x) e la somma dell'altra lista vale (somma_iniziale - x)

3) Dopo lo scambio le somme delle liste sono la media delle somme iniziali:
(somma = somma-iniziale-lista1 + somma-iniziale-lista2)/2
Poichè le liste contengono solo numeri interi, allora la differenza delle somme deve essere un numero pari (altrimenti la divisione per 2 produrrebbe un numero con la virgola).

Facciamo un esempio e applichiamo la terza caratteristica:

lst1 = (5 3 3 7)  Somma = 18
lst2 = (4 1 1 6)  Somma = 12

La media tra le due somme vale: (18 + 12)/2 = 15. In altre parole, la lista1 deve diminuire di 3 e la lista2 deve aumentare di 3. Questo accade quando la differenza tra l'elemento della lista1 e l'elemento della lista2 vale 3.
Anche in questo modo dobbiamo sempre utilizzare due cicli per attraversare le liste, notiamo una differenza: questa volta non dobbiamo verificare l'uguaglianza delle somme, ma verificare se esiste un numero predeterminato sulla lista2. Infatti, per esempio, quando abbiamo il numero 5 della lista1, allora dobbiamo cercare se esiste il numero (5 - 3) = 2 nella lista2.
Questo fatto ci permette di utilizzare una hash-map con i valori della lista2, dove la chiave è il numero e l'indice è l'indice del numero nella lista.

Funzione che copia una lista in una hash-map dove la chiave della hash-map è il valore dell'elemento della lista e l'indice della hash-map è l'indice dell'elemento della lista:

(define (list-hashmap lst hash)
  (dolist (el lst) (hash (string el) $idx)))

(new Tree 'myhash)
(setq lst '(10 15 20 35))

(list-hashmap lst myhash)
;-> 3
(myhash)
;-> (("10" 0) ("15" 1) ("20" 2) ("35" 3))

Oppure (più velocemente):

(myhash (map (fn(x) (list x $idx)) lst))

Esempio di ricerca di un valore:

(myhash "10")
;-> 0
(myhash 10)
;-> 0
(myhash "11")
;-> nil
(myhash 11)
;-> nil

Proviamo a scrivere la nuova funzione:

(define (scambio2 lst1 lst2)
  (local (out sum1 sum2 gap val found)
    (setq sum1 (apply + lst1))
    (setq sum2 (apply + lst2))
    (cond ((odd? (+ sum1 sum2)) (setq out nil))
          (true
            (new Tree 'myhash) ; crea hash-map
            (myhash (map (fn(x) (list x $idx)) lst2))     ; copia lista2 su hash-map
            ;(dolist (el lst2) (myhash (string el) $idx)) ; copia lista2 su hash-map
            ;(println (myhash))
            (setq gap (/ (- sum1 sum2) 2))
            (setq out nil found nil)
            (dolist (el1 lst1 found)
              ;(println "elemento: " el1 " --- cerco: " (- el1 gap))
              (setq val (myhash (string (- el1 gap))))
              ;(println "trovato: " val)
              (if val (setq out (list $idx val) found true))
            )
            (if (nil? out) out
                (begin
                (swap (lst1 (first out)) (lst2 (last out)))
                (setq out (list out (apply + lst1) (apply + lst2)))))
            (delete 'myhash)
          )
    )
    out))

(setq lst1 '(5 3 3 7))
(setq lst2 '(4 1 1 6))
(scambio2 lst1 lst2)
;-> ((3 0) 15 15)

(setq lst1 '(1 2 3 4 5))
(setq lst2 '(6 7 8))
(scambio2 lst1 lst2)
;-> ((2 0) 18 18)

(setq lst1 '(10 15 20))
(setq lst2 '(5 30))
(scambio2 lst1 lst2)
;-> ((0 0) 40 40)

Vediamo la velocità delle due funzioni:

(setq lst1 '(sequence 1 1000))

(apply + (sequence 1 1000))
;-> 500500

(apply + (sequence -110 1010))

(/ (- (apply + (sequence 1 1000)) (apply + (sequence -150 1010))) 2)

(setq lst1 (sequence 1 50))
(setq lst2 (sequence -50 71))

(time (scambio lst1 lst2) 10000)
;-> 1095.098
(time (scambio2 lst1 lst2) 10000)
;-> 767.13

Questa funzione ha complessità temporale O(n+m) ed è più veloce nonostante la necessità di copiare la lista sulla hash-map e di eliminare la hash-map.


---------------------------------
Evitare begin nella condizione if
---------------------------------

L'istruzione "if" ha la seguente sintassi:

(if (exp-condition)
    (expression-when-true)
    (expression-when-nil)
)

Se dobbiamo usare più di una espressione in (expression-when-true) oppure in (expression-when-nil) dobbiamo utilizzare la parola riservata "begin":

(if (exp-condition)
    (begin
      (expression1-when-true)
      (expression2-when-true)
      ...
      (expressionN-when-true)
    )
    (begin
      (expression1-when-nil)
      (expression2-when-nil)
      ...
      (expressionN-when-nil)
    )
)

In alcuni casi possiamo evitare l'uso di "begin".

Ad esempio se le espressioni sono limitate a pochi assegnamenti di variabili possiamo usare l'assegnamento multiplo di "setq":

(setq val1 10 val2 -3 val3 "a")

In questo modo "setq" racchiude tutte le assegnazioni in un'unica espressione che non necessita di "begin".

Oppure, se le espressioni che dobbiamo eseguire sono diverse tra loro, allora possiamo usare la funzione "let" o "letn":

(let ((a 10) (b 20) (c 30))
     (++ a)
     (if (> a b) (setq c (+ a b c)))
     ...
)

In questo modo "let" racchiude tutte le espressioni in un'unica espressione che non necessita di "begin".


----------------------------
Frazioni continue (funzioni)
----------------------------

Funzione che calcola i primi n termini della frazione continua di un numero:

(define (num2cf x n)
  (local (cf xi stop)
    (setq cf '())
    (setq stop nil)
    (for (k 0 (- n 1) 1 stop)
      (setq xi (floor x))
      (push xi cf -1)
      (if (zero? (sub x xi) )
          (setq stop true)
          (setq x (div 1 (sub x xi)))
      )
    )
    cf))

Facciamo alcune prove:

(num2cf (sqrt 2) 10)
;-> (1 2 2 2 2 2 2 2 2 2)

(setq PI 3.1415926535897931)
(num2cf PI 25)
;-> (3 7 15 1 292 1 1 1 2 1 3 1 14 3 3 23 1 1 7 4 35 1 1 1 2)

(num2cf 1.5 10)
;-> (1 2)
(num2cf 0.5 10)
;-> (0 2)
(num2cf 2 10)
;-> (2)

Il prossimo esempio produce un risutato errato a causa degli arrotondamenti dei numeri in virgola mobile:

(num2cf 3.245 10)
;-> (3 4 12 3 1 247777268231 4 1 2 1)

Funzione che calcola tutti i termini della frazione continua di una frazione:

(define (fract2cf a b)
  (local (fc r out)
    (setq out '())
    (while (!= 0 r)
      (setq r (% a b))
      (setq fc (/ a b))
      (push fc out -1)
      (setq a b)
      (setq b r)
    )
    out))

(fract2cf 3245 1000)
;-> '(3 4 12 4)

(fract2cf 31415926535897931 10000000000000000)
;-> (3 7 15 1 292 1 1 1 2 1 3 1 14 3 2 2 1 1 1 1 2 2 12 24 1 1 6 2 4 1 3 3)

Funzione che calcola il numero di una frazione continua:

(define (cf2num cf)
  (local (x)
    (cond ((= (length cf) 1) (setq x (first cf)))
          (true
           (setq x (cf -1))
           (for (k (- (length cf) 2) 0 -1)
             (setq x (add (cf k) (div 1 x)))
           )))
    x))

Facciamo alcune prove:

(cf2num '(1 2 2 2 2 2 2 2 2 2))
;-> 1.41421362489487
(sqrt 2)
;-> 1.414213562373095

(cf2num '(3 7 15 1 292 1 1 1 2 1 3 1 14 3 3 23 1 1 7 4 35 1 1 1 2))
;-> 3.141592653589793

(cf2num '(1 2))
;-> 1.5
(cf2num '(0 2))
;-> 0.5
(cf2num '(2))
;-> 2

(cf2num '(3 4 12 4))
;-> 3.245

Funzione che calcola i convergenti di una frazione continua:

(define (cf2conv cf)
  (local (p0 q0 p1 q1 p2 q2)
    (setq p0 1 q0 0)
    (setq p1 (cf 0) q1 1)
    (for (k 1 (- (length cf) 1))
      (setq p2 (+ (* (cf k) p1) p0))
      (setq q2 (+ (* (cf k) q1) q0))
      (println (list p2 q2 (div p2 q2)))
      (setq p0 p1 q0 q1 p1 p2 q1 q2)
    )
    (list p2 q2 (div p2 q2))))

(cf2conv '(2 1 2 1 1 4 1 1 6 1))
;-> (3 1 3)
;-> (8 3 2.666666666666667)
;-> (11 4 2.75)
;-> (19 7 2.714285714285714)
;-> (87 32 2.71875)
;-> (106 39 2.717948717948718)
;-> (193 71 2.71830985915493)
;-> (1264 465 2.718279569892473)
;-> (1457 536 2.718283582089552)
;-> (1457 536 2.718283582089552)

(cf2conv '(3 4 12 4))
;-> (13 4 3.25)
;-> (159 49 3.244897959183673)
;-> (649 200 3.245)

(cf2conv '(3 7 15 1 292 1 1 1 2 1 3 1 14 3 2 2 1 1 1 1 2 2 12 24 1 1 6 2 4 1 3 3))
;-> (22 7 3.142857142857143)
;-> (333 106 3.141509433962264)
;-> (355 113 3.141592920353983)
;-> (103993 33102 3.141592653011903)
;-> (104348 33215 3.141592653921421)
;-> (208341 66317 3.141592653467437)
;-> (312689 99532 3.141592653618937)
;-> (833719 265381 3.141592653581078)
;-> (1146408 364913 3.141592653591404)
;-> (4272943 1360120 3.141592653589389)
;-> (5419351 1725033 3.141592653589815)
;-> (80143857 25510582 3.141592653589793)
;-> (245850922 78256779 3.141592653589793)
;-> (571845701 182024140 3.141592653589793)
;-> (1389542324 442305059 3.141592653589793)
;-> (1961388025 624329199 3.141592653589793)
;-> (3350930349 1066634258 3.141592653589793)
;-> (5312318374 1690963457 3.141592653589793)
;-> (8663248723 2757597715 3.141592653589793)
;-> (22638815820 7206158887 3.141592653589793)
;-> (53940880363 17169915489 3.141592653589793)
;-> (669929380176 213245144755 3.141592653589793)
;-> (16132246004587 5135053389609 3.141592653589793)
;-> (16802175384763 5348298534364 3.141592653589793)
;-> (32934421389350 10483351923973 3.141592653589793)
;-> (214408703720863 68248410078202 3.141592653589793)
;-> (461751828831076 146980172080377 3.141592653589793)
;-> (2061416019045167 656169098399710 3.141592653589793)
;-> (2523167847876243 803149270480087 3.141592653589793)
;-> (9630919562673896 3065616909839971 3.141592653589793)
;-> (31415926535897931 10000000000000000 3.141592653589793)


---------------
Redditi e tasse
---------------

In genere le tasse sui redditi vengono definite per "scaglioni" (classe di reddito). Ad esempio in Italia valgono le seguenti classi:

fino a 15000 euro il 23%
(23% del reddito)

da 15001 fino a 28000 euro il 27%
(3450.00 + 27% sulla parte oltre i 15000 euro)

da 28.001 fino a 55.000 euro il 38%
(6960.00 + 38% sulla parte oltre i 28000 euro

da 55.001 fino a 75.000 euro il 41%
(17220.00 + 41% sulla parte oltre i 55000 euro)

oltre 75.000 euro il 43%
(25420.00 + 43% sulla parte oltre i 75000 euro

Esempio:
Reddito = 27000 euro
15000 * 23% = 3450
più il 27% sulla parte oltre i 15000 (27000 - 15000 = 12000) = 3240,
per un totale di (3450 + 3240 = 6690).

Scrivere una funzione che calcola le tasse da pagare dato un determinato reddito.

Questo problema permette una soluzione elegante utilizzando la ricorsione.

La tabella viene codificata nel modo seguente:

(setq tabella '((75000 0.43) (55000 0.41) (28000 0.38) (15000 0.27) (0 0.23)))

Definiamo alcune funzione tipiche del LISP:

(define car first)
;-> first@4071B9
(define cdr rest)
;-> rest@4072CA
(define (caar x)   (first (first x)))
(define (cadar x)  (first (rest (first x))))

Vediamo cosa estraggono dalla lista le funzioni "caar" e "cadar":

(caar tabella)
;-> 75000
(cadar tabella)
;-> 0.43

(define (tasse reddito tabella)
   (if (null? tabella) 0
     (add (mul (max (sub reddito (caar tabella)) 0) (cadar tabella))
               (tasse (min reddito (caar tabella)) (cdr tabella)))))

Da notare che la ricorsione viene applicata sommando le tasse e diminuendo la lunghezza della tabella ad ogni passo. Possiamo capire meglio il funzionamento se calcoliamo le seguenti espressioni (che rappresentano il primo passo della ricorsione):

(mul (max (sub 27000 (caar tabella)) 0) (cadar tabella))
;-> 0

(min 27000 (caar tabella))
;-> 27000

(cdr tabella)
;-> ((55000 0.41) (28000 0.38) (15000 0.27) (0 0.23))

Applichiamo la funzione all'esempio:

(tasse 27000 tabella)
;-> 6690

E verifichiamo altri casi:

(tasse 0)
;-> 0
(tasse 15000 tabella)
;-> 3450
(tasse 15001 tabella)
;-> 3450.27
(tasse 75000 tabella)
;-> 25420
(tasse 75001 tabella)
;-> 25420.43

Adesso vediamo come variano le tasse in funzione del reddito:

(define (curva tabella reddito step)
  (let (out '())
    (for (i step reddito step)
      (push (list i (tasse i tabella)) out -1))
    out))

(setq data (curva tabella 200000 1000))

Adesso scriviamo una funzione che crea un file grafico ("tasse.png") che visualizza relazione reddito/tasse:

(module "plot.lsp")

(define (plotXY lst)
  (local (xx zz)
    ; azzera parametri della funzione plot
    (plot:reset)
    ; opzionale title, sub-title, labels e legend, data min/max per Y
    (set 'plot:title "Tasse sul reddito")
    (set 'plot:sub-title "IRPEF 2020")
    (set 'plot:unit-x "reddito")
    (set 'plot:unit-y "tasse")
    ; crea il file dei dati
    ; lista dei valori x (reddito) e lista dei valori z (tasse)
    (setq xx '())
    (setq zz '())
    (dolist (el lst)
      (push (first el) xx -1)
      (push (last el) zz -1 ))
    ; plot data
    (plot:XY xx zz)
    ; salva il plot su un file
    (plot:export (string "tasse.png"))))

Creiamo il grafico:

(plotXY data)

Il grafico mostra che le tasse sono, grosso modo, direttamente proporzionali al reddito.

Potete trovare il file nella cartella "data".


----------------------------
Numero di eulero o di nepero
----------------------------
e = 2.7182818284590451

(exp 1)
;-> 2.718281828459045

Supponiamo di avere depositato un certo capitale C al tasso di interesse annuo di x per cento, cioè al tasso assoluto di r = x/100.

Dopo un anno il nostro capitale è diventato C(1) = C*(1+r). Dopo un altro anno: C(2) = C1*(1+r) = C*(1+r)^2, dopo tre anni C(3) = C*(1+r)^3 e dopo n anni C(n) = C*(1+r)^n. La crescita esponenziale è dovuta agli interessi maturati precedentemente che concorrono nel maturare altri interessi.

Supponiamo che dopo 6 mesi (1/2 anno) il capitale si sia rivalutato di r/2 (in realtà non è così perché altrimenti risulterebbe (dopo n anni): C(n) =C*(1+n*r) invece di C(n) = C*(1+r)^n).
Dopo un semestre il capitale sarà diventato C(1/2) = C*(1+r/2) e dopo un anno C1 = C*(1+r/2)^2 .

Per ogni quadrimestre (1/3 di anno) al tasso di r/3 avremmo C(1/3) = C*(1+r/3) e dopo un anno C(1) = C*(1+r/3)^3.

Se gli interessi maturassero ogni 1/n di anno al tasso di r/n dopo ogni m frazioni di anno avremmo C(m/n) = C(1+r/n)^m e dopo un anno C1 = C*(1+r/n)n.

Per una maturazione continua (interesse composto) basta passare al limite per n tendente all’infinito e dopo un anno avremmo un capitale di: C(1) = C*lim(1+r/n)^n.

Se poniamo r = 1 questo limite è proprio il numero di Eulero "e".

Calcoliamo questo limite (facendo assumere ad n valori sempre maggiori):

(define (limite n) (pow (add 1 (div n)) n))

(limite 1000)
;-> 2.71692393223552
(limite 10000)
;-> 2.718145926824356
(limite 100000)
;-> 2.718268237197528
(limite 1000000)
;-> 2.718280469156428

Vediamo la differenza con il numero "e":

(sub (exp 1) (limite 1000000))
;-> 1.359302617576219e-006

Invece, se r è diverso da 1 con il cambio di variabile m = n/r si ha:

lim(1+r/n)^n = lim(1+1/m)^(m*r) = (lim(1+1/m)^m)^r = e^r

Anche questa volta abbiamo ritrovato il numero di Eulero "e".

Quindi dopo un anno sarà C(1) = C*e^r e dopo t anni (con t non necessariamente intero): C(t) = C*e^(t*r).

Da notare che il numero "e" è scaturito naturalmente, non è stato introdotto artificiosamente.

Purtroppo le banche non concedono un tasso assoluto di interesse continuo.


---------------------
map e filter multiplo
---------------------

Qualche volta abbiamo la necessità di applicare la funzione "map" più volte su una stessa lista, ad esempio per applicare tre funzioni func1, func2 e func2 ad una lista lst dobbiamo scrivere:

(map func3 (map func2 (map func1 lst)))

Possiamo scrivere una funzione per utilizzare un'espressione più elegante:

(define (nmap lst)
  (let (res lst)
    ; per ogni predicato
    (dolist (func (args))
      ; applica il predicato agli elementi della lista
      (setq res (map func res)))))

Adesso il nostro esempio può essere scritto nel modo seguente:

(nmap lst func1 func2 func3)

Vediamo un esempio concreto:

(nmap '(-4 36 81 49) abs sqrt)
;-> (2 6 9 7)

Possiamo anche usare una funzione definita dall'utente:

(nmap (explode "newLISP") upper-case (fn(x) (char x)))
;-> (78 69 87 76 73 83 80)

Vediamo la differenza di velocità:

(setq lst (sequence -5000 5000))

(time (nmap lst abs sqrt) 1000)
;-> 1221.763

(time (map sqrt (map abs lst)) 1000)
;-> 607.408

Nota: il tempo di esecuzione della nostra funzione è il doppio di quello del metodo standard.

Possiamo utilizzare la stessa tecnica anche per la funzione "filter":

(define (nfilter lst)
  (let (res lst)
    ; per ogni predicato
    (dolist (func (args))
      ; applica il predicato agli elementi della lista
      (setq res (filter func res)))))

(setq lst '(1 2 3 4 a b c 5 6 7 8 9 ))

(filter odd? (filter integer? lst))
;-> (1 3 5 7 9)

(nfilter lst integer? odd?)
;-> (1 3 5 7 9)

Vediamo la velocità:

(setq lst (sequence 1 10000))
(time (nfilter lst integer? odd?) 1000)
;-> 1325.484

(time (filter odd? (filter integer? lst)) 1000)
;-> 967.444

Anche in questo caso possiamo anche usare una funzione definita dall'utente al posto del predicato.

Nota: i predicati vengono valutati da sinistra a destra, quindi nell'esempio la loro inversione provoca un errore perchè non possiamo applicare "odd?" all'elemento "a":

(nfilter lst odd? integer?)
;-> ERR: value expected in function odd? : a
;-> called from user function (nfilter lst odd? integer?)

La funzione "nfilter" applica i predicati in sequenza, cioè ogni elemento della lista deve rispettare tutti i predicati per essere selezionato (and):

  elemento selezionato se rispetta (func1 and func2 and ... and funcN)

Può risultare utile una funzione che seleziona un elemento anche se un solo predicato viene rispettato (or):

  elemento selezionato se rispetta (func1 or func2 or ... or funcN)

Vediamo come potrebbe essere implementata:

(define (nfilter-or lst)
  (let ((stop nil) (res '()))
    ; per ogni elemento della lista
    (dolist (el lst)
      ; per ogni predicato
      (setq stop nil)
      (dolist (func (args) stop)
        ; applica il predicato all'elemento
        ; se il risultato è vero (true)
        (if (func el)
          (begin
          ; allora lo inserisce nella lista res
          (push el res -1)
          ; e non occorre applicare
          ; gli altri predicati all'elemento corrente
          (setq stop true))
        )
      )
    )
    res))

(setq lst '(1 2 3 4 5 6 7 8 9))

(nfilter-or lst integer? odd?)
;-> (1 2 3 4 5 6 7 8 9)

Usiamo una funzione definita dall'utente:

(define (big5? x) (> x 5))

(nfilter-or lst big5? odd?)
;-> (1 3 5 6 7 8 9)

Vediamo la velocità:

(setq test (sequence 1 10000))
(time (nfilter-or test integer? odd?) 100)
;-> 221.408

Nota: Nel caso della funzione "nfilter-or" i predicati devono poter essere applicati a tutti gli elementi senza errore.

Vediamo un altro modo di implementare la funzione "nfilter-or":

(define (nfilter-or lst)
  (let ((bool '()) (res '()))
    ; per ogni predicato
    (dolist (func (args))
      ; applica il predicato a tutta la lista
      ; creando una lista di true e nil
      ; e la aggiunge alla lista bool
      ; es. bool = ((true nil) (true nil) (nil nil))
      (push (map func lst) bool -1)
    )
    ; per ogni elemento della trasposta di bool
    ; es. traposta bool = ((true true nil) (nil nil nil))
    (dolist (b (transpose bool))
      ; se "or" = true per elemento corrente
      (if (apply or b)
          ; inserisco il relativo elemento della lista lst
          ; nella lista risultato
          (push (lst $idx) res -1)
      )
    )
    res))

(setq lst '(abc 1 "a" 2 "b" 3 "c" lst))

(nfilter-or lst integer? string?)
;-> (1 "a" 2 "b" 3 "c")

Vediamo la velocità:

(setq test (sequence 1 10000))
(time (nfilter-or test integer? odd?) 100)
;-> 7057.166

L'ultima funzione è molto lenta perchè crea altre liste che vengono attraversate diverse volte.

Come al solito la cosa migliore da fare è utilizzare le primitive di newLISP:

Per "filter":

Con una funzione utente:
(setq lst (sequence -5000 5000))
(define (test? x) (or (integer? x) (odd? x)))
(time (filter test? lst) 1000)
;-> 1465.309

Direttamente:
(setq lst (sequence -5000 5000))
(time (filter odd? (filter integer? lst)) 1000)
;-> 913.119

Per "map":

Con una funzione utente:
(setq lst (sequence -5000 5000))
(define (func x) (sqrt (abs x)))
(time (map func lst) 1000)
;-> 850.763

Direttamente:
(setq lst (sequence -5000 5000))
(time (map sqrt (map abs lst)) 1000)
;-> 564.408


--------
Toziente
--------

La funzione φ (phi) di Eulero o funzione toziente, è una funzione definita, per ogni intero positivo n, come il numero degli interi compresi tra 1 e n che sono coprimi con n. Ad esempio, phi(8) = 4 poiché i numeri coprimi di 8 sono quattro: 1, 3, 5 e 7.

n = p1^a1 * p2^a2 *... * pk^ak

phi(n) = n* (1 - 1/p1)*(1 - 1/p2)*...*(1 - 1/pk)

Per calcolare il toziente di un numero scriviamo tre funzioni, due che utilizzano la primitiva di newLISP "factor" e una che calcola la fattorizzazione (quindi utilizzabile anche per i big-integer):

Funzione 1:

(define (toziente1 num)
    (if (= num 1) 1
    (round (mul num (apply mul (map (fn (x) (sub 1 (div 1 x))) (unique (factor num))))) 0)))

(toziente1 222)
;-> 72
(toziente1 123456)
;-> 41088
(toziente1 9223372036854775807)
;-> 7.713001620195509e+018

Funzione 2:

(define (toziente2 num)
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

(toziente2 222)
;-> 72
(toziente2 123456)
;-> 41088
(toziente2 9223372036854775807)
;-> 7713001620195508224

Funzione 3 (big-integer):

(define (toziente-i num)
  (if (= num 1) 1
    (let ((res num) (i 2L))
      (while (<= (* i i) num)
        (if (zero? (% num i))
            (begin
              (while (zero? (% num i))
                (setq num (/ num i))
              )
              (setq res (- res (/ res i))))
        )
        (++ i)
      )
      (if (> num 1)
        (setq res (- res (/ res num)))
      )
      res)))

(toziente-i 222)
;-> 72
(toziente-i 123456)
;-> 41088
(toziente-i 9223372036854775807)
;-> 7713001620195508224

Se passiamo un numero big-integer, allora la soluzione sarà un big-integer:

(toziente-i 9223372036854775808L)
;-> 4611686018427387904L

Verifichiamo che le funzioni producano lo stesso risultato:

(= (map toziente1 (sequence 1 1000)) (map toziente2 (sequence 1 1000)) (map toziente-i (sequence 1 1000)))
;-> true

Vediamo la velocità delle funzioni:

(setq lst (sequence 1 10000))
(time (map toziente1 lst) 100)
;-> 1401.418
(time (map toziente2 lst) 100)
;-> 1156.911
(time (map toziente-i lst) 100)
;-> 11216.188

Se abbiamo bisogno di tutti i totienti dei numeri compresi tra 1 e n, la fattorizzazione di tutti gli n numeri non è efficiente. Possiamo usare la stessa idea del crivello di Eratostene: troviamo tutti i numeri primi e per ciascuno aggiorniamo i risultati temporanei di tutti i numeri che sono divisibili per quel numero primo.

(array (+ 3 1) '(0))

(define (totients-to num)
  (let (phi (array (+ num 1) '(0)))
    (setf (phi 0) 0)
    (setf (phi 1) 1)
    (for (i 2 num)
      (setf (phi i) i)
    )
    (for (i 2 num)
      (if (= (phi i) i)
          (for (j i num i)
            (setf (phi j) (- (phi j) (/ (phi j) i)))
          )
      )
    )
    (slice phi 1 num)))

(totients-to 10)
;-> (1 1 2 2 4 2 6 4 6 4)

Verifichiamo il risultato:

(= (array-list (totients-to 10000)) (map toziente2 (sequence 1 10000)))
;-> true

Vediamo la differenza di velocità:

(time (totients-to 10000) 100)
;-> 349.067

(time (map toziente2 (sequence 1 10000)) 100)
;-> 1250.951

Per calcolare i tozienti dei numeri da 1 a n conviene utilizzare la funzione "totients-to".


--------------------------
Direct Acyclic Graph (DAG)
--------------------------

Un grafo aciclico diretto (Directed acyclic graph, DAG) è un grafo diretto che non ha cicli (circuiti), ovvero comunque scegliamo un vertice del grafo non possiamo tornare ad esso percorrendo gli archi del grafo. Un grafo diretto può dirsi aciclico (cioè è un DAG) se una visita in profondità non presenta archi all'indietro.

Un esempio di DAG è il seguente:

  +---------+-        +---------+        +---------+          +---------+
  |         |         |         |        |         |          |         |
  |    A    |-------->|    C    |------->|    D    |--------->|    E    |
  |         |   ----->|         |        |         |------    |         |
  +---------+   |     +---------+        +---------+     |    +---------+
                |         |                              |
  +---------+   |         |                              |    +---------+
  |         |   |         |                              |    |         |
  |    B    |----         |        +---------+           ---->|    F    |
  |         |             |        |         |                |         |
  +---------+             -------->|    G    |                +---------+
                                   |         |
                                   +---------+

A e B sono nodi iniziali. Ogni nodo ha proprietà, ogni vertice ha proprietà. E, G e F sono nodi finali.

Il codice seguente è stato scritto da rickyboy ed è anche un ottimo esempio di programmazione ad oggetti in newLISP (FOOP).

;;;
;;; Find dependencies ((grand)*parents) in a DAG.
;;;

(define (mappend) (apply append (apply map (args))))

(define (Class:Class) (cons (context) (args)))

The three principal types of objects we need are nodes, edges, and DAGs.

(new Class 'Node)
(new Class 'Edge)
(new Class 'DAG)

Naturally, DAGs will contain nodes and edges. Here is a helper function to create a DAG.
Besides nodes and edges, DAGS contain a "parents-alist", an adjacency list matching nodes (node names, actually) to a list of their parents (names).
The create function will compute the "parents-alist" for you, as a convenience.

;; Warning: no error checking is done, e.g. checking for no cycles.
(define (DAG:create nodes edges)
  "Create a DAG object from Nodes and Edges."
  (let ((simple-nodes (map (fn (n) (n 1)) nodes))
        (simple-edges (map (fn (e) (list (e 1) (e 2))) edges)))
    (DAG nodes
         edges
         ;; parents-alist: assocs look like (node (parent-node ...))
         (map (fn (sn)
                (list sn
                      (map first
                           (filter (fn (se) (= sn (last se)))
                                   simple-edges))))
              simple-nodes)
         ;; children-alist: assocs look like (node (child-node ...))
         (map (fn (sn)
                (list sn
                      (map last
                           (filter (fn (se) (= sn (first se)))
                                   simple-edges))))
              simple-nodes))))

Let's see it in action on our DAG:

(define my-dag
  (DAG:create (list (Node "A" 'happy)
                    (Node "B" 'sad)
                    (Node "C" 'happy)
                    (Node "D" 'indifferent)
                    (Node "E" 'surly)
                    (Node "F" 'happy)
                    (Node "G" 'sad))
              (list (Edge "A" "C" 3)
                    (Edge "B" "C" 4)
                    (Edge "C" "D" 8)
                    (Edge "C" "G" 1)
                    (Edge "D" "E" 4)
                    (Edge "D" "F" 9))))

Here's what it looks like:

my-dag
;-> (DAG ((Node "A" happy) (Node "B" sad) (Node "C" happy)
;->       (Node "D" indifferent) (Node  "E" surly)
;->       (Node "F" happy) (Node "G" sad))
;->      ((Edge "A" "C" 3) (Edge "B" "C" 4) (Edge "C" "D" 8)
;->       (Edge "C" "G" 1) (Edge "D" "E"  4) (Edge "D" "F" 9))
;->      (("A" ()) ("B" ()) ("C" ("A" "B")) ("D" ("C"))
;->       ("E" ("D")) ("F" ("D")) ("G" ("C"))))

Nodes and edges must contain properties. The convention I'm using here is that, when defining a Node, the first "slot" contains the name and the remaining "slots" contain any number of properties that you want to add. So, (Node "A" 'happy) is a node with the name "A" and one property value (namely, 'happy). The same idea applies to edges, except that the first 2 slots contain node names and the remaining slots can be properties. Hence, (Edge "A" "C" 3) is an edge starting from node "A", ending at node "C" and containing the property value 3 (which could be an edge weight/cost, for example). These are the properties.

Now, here are some accessor functions for DAGs:

(define (DAG:nodes) (self 1))
(define (DAG:edges) (self 2))
(define (DAG:parents node-name)
  (let ((parents-alist (self 3)))
    (if node-name
        (if (assoc node-name parents-alist) (last $it) '())
        parents-alist)))

;; Example usage:
;; (:parents my-dag) => (("A" ()) ("B" ()) ("C" ("A" "B")) ("D" ("C")) ("E" ("D")) ("F" ("D")) ("G" ("C")))
;; (:parents my-dag "C") => ("A" "B")
;; (:parents my-dag "B") => ()
;; (:parents my-dag "Does not exist") => ()

Here's a function to compute a node's children:

(define (DAG:children node-name)
  (let ((children-alist (self 4)))
    (if node-name
        (if (assoc node-name children-alist) (last $it) '())
        children-alist)))

;; Example usage:
;; (:children my-dag) => (("A" ("C")) ("B" ("C")) ("C" ("D" "G")) ("D" ("E" "F")) ("E" ()) ("F" ()) ("G" ()))
;; (:children my-dag "C") => ("D" "G")
;; (:children my-dag "B") => ("C")
;; (:children my-dag "E") => ()
;; (:children my-dag "Does not exist") => ()

Here's a function to compute a node's ancestors (i.e. parents, grandparents, ...):

(define (DAG:ancestors node-name)
  (let ((parents (:parents (self) node-name)))
    (and parents
         (append parents
                 (mappend (fn (p) (:ancestors (self) p))
                      parents)))))

;; Example usage:
;; (:ancestors my-dag "D") => ("C" "A" "B")

Here's a function to compute a node's descendants:

(define (DAG:descendants node-name)
  (let ((children (:children (self) node-name)))
    (and children
         (append children
                 (mappend (fn (p) (:descendants (self) p))
                          children)))))

;; Example usage:
;; (:descendants my-dag "C") => ("D" "G" "E" "F")

;; If you want to get a Node out of the DAG (e.g. in order the extract
;; its properties), then use the following function to get it by name.

(define (DAG:get-node node-name)
  (and (find (list 'Node node-name '*)
             (:nodes (self))
             match)
       $0))

;; Example usage:
;; (:get-node my-dag "G") => (Node "G" sad)
;; (:get-node my-dag "Does not exist") => nil

;; Same goes for getting an Edge, expect you provide a list of two
;; node names, e.g. '("A" "B").

(define (DAG:get-edge edge-name)
  (and (find (append '(Edge) edge-name '(*))
             (:edges (self))
             match)
       $0))

;; Example usage:
;; (:get-edge my-dag '("C" "D")) => (Edge "C" "D" 8)
;; (:get-edge my-dag '("Does" "Not Exist")) => nil

(define (find-all-dependencies dag node-name)
  (:ancestors dag node-name))

;; (find-all-dependencies my-dag "D") => ("C" "A" "B")

(define (get-all-dependencies dag node-name)
   (map (fn (name) (:get-node dag name))
        (:ancestors dag node-name)))

;; (get-all-dependencies my-dag "D") => ((Node "C" happy) (Node "A" happy) (Node "B" sad))


---------------
Corde e cerchio
---------------

Se una corda è selezionata a caso su un cerchio, qual è la probabilità che la sua lunghezza (l) superi il raggio (r) del cerchio?
"A caso" indica che i punti finali della corda sono distribuiti uniformemente sul cerchio.

La lunghezza di una corda AB vale:

corda = diametro * sin(alfa)

dove alfa è l'angolo che insiste sulla corda AB

0° <= alfa <= 180°

Se poniamo (corda = r) ==> r = 2 * r * sin(alfa) ==> sin(alfa) = 1/2 ==> asin(1/2) = 60°

Quindi la lunghezza della corda è pari al raggio r quando alfa = 60°.

Allora per alfa compreso tra 0° e 60°, la corda è minore del raggio,
       per alfa compreso tra 60° e 180°, la corda è maggiore del raggio.

Quindi la probabilità che la lunghezza della corda superi il raggio vele (180 - 60/180) = 2/3 = 0.666666...

Scriviamo una funzione che effettua la simulazione:

(setq PI 3.1415926535897931)

(define (corda step)
  (local (tot magg r alfa)
  (setq tot 0 magg 0 r 1)
  (for (alfa 0 (div PI 2) step)
    (if (> (mul 2 r (sin alfa)) r) (++ magg))
    (++ tot)
  )
  (div magg tot)))

(corda 0.01)
;-> 0.6645569620253164
(corda 0.001)
;-> 0.6664544875875239
(corda 0.0001)
;-> 0.6666666666666666


--------
Toziente
--------

La funzione φ (phi) di Eulero o funzione toziente, è una funzione definita, per ogni intero positivo n, come il numero degli interi compresi tra 1 e n che sono coprimi con n. Ad esempio, phi(8) = 4 poiché i numeri coprimi di 8 sono quattro: 1, 3, 5 e 7.

n = p1^a1 * p2^a2 *... * pk^ak

phi(n) = n* (1 - 1/p1)*(1 - 1/p2)*...*(1 - 1/pk)

Per calcolare il toziente di un numero scriviamo tre funzioni, due che utilizzano la primitiva di newLISP "factor" e una che calcola la fattorizzazione (quindi utilizzabile anche per i big-integer):

Funzione 1:

(define (toziente1 num)
    (if (= num 1) 1
    (round (mul num (apply mul (map (fn (x) (sub 1 (div 1 x))) (unique (factor num))))) 0)))

(toziente1 222)
;-> 72
(toziente1 123456)
;-> 41088
(toziente1 9223372036854775807)
;-> 7.713001620195509e+018

Funzione 2:

(define (toziente2 num)
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

(toziente2 222)
;-> 72
(toziente2 123456)
;-> 41088
(toziente2 9223372036854775807)
;-> 7713001620195508224

Funzione 3 (big-integer):

(define (toziente-i num)
  (if (= num 1) 1
    (let ((res num) (i 2L))
      (while (<= (* i i) num)
        (if (zero? (% num i))
            (begin
              (while (zero? (% num i))
                (setq num (/ num i))
              )
              (setq res (- res (/ res i))))
        )
        (++ i)
      )
      (if (> num 1)
        (setq res (- res (/ res num)))
      )
      res)))

(toziente-i 222)
;-> 72
(toziente-i 123456)
;-> 41088
(toziente-i 9223372036854775807)
;-> 7713001620195508224

Se passiamo un numero big-integer, allora la soluzione sarà un big-integer:

(toziente-i 9223372036854775808L)
;-> 4611686018427387904L

Verifichiamo che le funzioni producano lo stesso risultato:

(= (map toziente1 (sequence 1 1000)) (map toziente2 (sequence 1 1000)) (map toziente-i (sequence 1 1000)))
;-> true

Vediamo la velocità delle funzioni:

(setq lst (sequence 1 10000))
(time (map toziente1 lst) 100)
;-> 1401.418
(time (map toziente2 lst) 100)
;-> 1156.911
(time (map toziente-i lst) 100)
;-> 11216.188

Se abbiamo bisogno di tutti i totienti di tutti i numeri compresi tra 1 e n, la fattorizzazione di tutti gli n numeri non è efficiente. Possiamo usare la stessa idea del crivello di Eratostene: troviamo tutti i numeri primi e per ciascuno aggiorniamo i risultati temporanei di tutti i numeri che sono divisibili per quel numero primo.

(array (+ 3 1) '(0))

(define (totients-to num)
  (let (phi (array (+ num 1) '(0)))
    (setf (phi 0) 0)
    (setf (phi 1) 1)
    (for (i 2 num)
      (setf (phi i) i)
    )
    (for (i 2 num)
      (if (= (phi i) i)
          (for (j i num i)
            (setf (phi j) (- (phi j) (/ (phi j) i)))
          )
      )
    )
    (slice phi 1 num)))

(totients-to 10)
;-> (0 1 1 2 2 4 2 6 4 6 4)

Verifichiamo il risultato:

(= (array-list (totients-to 10000)) (map toziente2 (sequence 1 10000)))
;-> true

Vediamo la differenza di velocità:

(time (totients-to 10000) 100)
;-> 349.067

(time (map toziente2 (sequence 1 10000)) 100)
;-> 1250.951

Per calcolare i tozienti dei numeri da 1 a n conviene utilizzare la funzione "totients-to".


----------------
Numeri permutati
----------------

Scrivere una funzione che verifica se due numeri sono la permutazione uno dell'altro, cioè se i due numeri contengono le stesse identiche cifre.

Funzione che converte un intero in una lista:

(define (int-lst num)
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Prima funzione:

(define (perm1? n1 n2) (= (sort (int-lst n1)) (sort (int-lst n2))))

(perm1? 112233 123123)
;-> true
(perm1? 112233 223123)

Seconda funzione:
usiamo due vettori che vengono aggiornati (+ 1) con le cifre dei due numeri.
Al termine confrontiamo i due vettori.

(define (perm2? n1 n2)
  (if (!= (length n1) (length n2))
      nil
      (let (ar1 (array 10 '(0)) (ar2 (array 10 '(0))))
        (while (!= n1 0)
            (++ (ar1 (% n1 10)))
            (setq n1 (/ n1 10))
        )
        (while (!= n2 0)
            (++ (ar2 (% n2 10)))
            (setq n2 (/ n2 10))
        )
        (= ar1 ar2))))

(perm2? 112233 123123)
;-> true
(perm2? 112233 223123)
;-> nil

Terza funzione:
usiamo un vettore che viene aggiornato (+ 1 e -1) con le cifre dei due numeri.
Al termine verifichiamo se il vettore contiene tutti 0.

(define (perm3? n1 n2)
  (if (!= (length n1) (length n2))
      nil
      (let (ar (array 10 '(0)))
        (while (!= n1 0)
            (++ (ar (% n1 10)))
            (setq n1 (/ n1 10))
        )
        ;(println ar)
        (while (!= n2 0)
            (-- (ar (% n2 10)))
            (setq n2 (/ n2 10))
        )
        ;(println ar)
        (= (count '(0) (array-list ar)) '(10)))))

(perm3? 112233 123123)
;-> true
(perm3? 112233 223123)
;-> nil

Quarta funzione:
questa funzione è presa da un vecchio libro sul linguaggio C.

(define (perm4? n1 n2)
  (if (!= (length n1) (length n2))
      nil
      (let ((nn1 n1) (nn2 n2) (tot1 0) (tot2 0))
        (while (and (> nn1 0) (> nn2 0))
          (setq nn1 (/ nn1 10) nn2 (/ nn2 10)))
        (while (!= n1 0)
          (setq tot1 (+ tot1 (<< 1 (* (% n1 10) 6))))
          (setq tot2 (+ tot2 (<< 1 (* (% n2 10) 6))))
          (setq n1 (/ n1 10))
          (setq n2 (/ n2 10)))
        (= tot1 tot2))))

Nota: L'operazione di left-shift (x << y) è equivalente a moltiplicare x per 2^y (2 elevato alla potenza y).

(perm4? 112233 123123)
;-> true
(perm4? 112233 223123)
;-> nil

Vediamo la velocità delle funzioni:

(time (perm1? 9223372036854775807 7223372036854775809) 100000)
;-> 587.222
(time (perm2? 9223372036854775807 7223372036854775809) 100000)
;-> 557.205
(time (perm3? 9223372036854775807 7223372036854775809) 100000)
;-> 611.291
(time (perm4? 9223372036854775807 7223372036854775809) 100000)
;-> 945.856

Per i big-integer:

(time (perm1? 92233720368547758079223372036854775807L 72233720368547758097223372036854775809L) 100000)
;-> 4832.083
(time (perm2? 92233720368547758079223372036854775807L 72233720368547758097223372036854775809L) 100000)
;-> 4063.133
(time (perm3? 92233720368547758079223372036854775807L 72233720368547758097223372036854775809L) 100000)
;-> 4131.988


-------------
Numeri bouncy
-------------

Un numero "bouncy" (che rimbalza) è un numero intero positivo le cui cifre non sono in ordine strettamente crescente o strettamente decrescente. Ad esempio, 1235 è un numero crescente, 5321 è un numero decrescente e 2351 è un numero bouncy. Per definizione, tutti i numeri inferiori a 100 sono non-bouncy e 101 è il primo numero bouncy.

Scrivere una funzione che verifica se un numero è bouncy.

Funzione iterativa:

(define (bouncy1 num)
  (local (incr decr ultimo prossimo continua)
    (setq continua true)
    (setq incr nil decr nil)
    (setq ultimo (% num 10))
    (setq num (/ num 10))
    (while (and (> num 0) continua)
      (setq prossimo (% num 10))
      (setq num (/ num 10))
      (if (< prossimo ultimo)
          (setq incr true)
          (if (> prossimo ultimo)
              (setq decr true)))
      (setq ultimo prossimo)
      (if (and decr incr) (setq continua nil))
    )
    (and decr incr)))

(bouncy1 123456)
;-> nil
(bouncy1 123451)
;-> true
(bouncy1 123455)
;-> nil
(bouncy1 111111)
;-> nil
(bouncy1 211111)
;-> nil

Funzione funzionale:

(define (int-lst num)
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (bouncy2 num)
  (let (digits (int-lst num))
    (not (or (apply >= digits) (apply <= digits)))))

(bouncy2 123456)
;-> nil
(bouncy2 123451)
;-> true
(bouncy2 123455)
;-> nil
(bouncy2 111111)
;-> nil
(bouncy2 211111)
;-> nil

Vediamo se le due funzioni producono risultati uguali:

(= (map bouncy1 (sequence 1 10000)) (map bouncy2 (sequence 1 10000)))
;-> true

Vediamo la velocità delle funzioni:

(setq numeri (sequence 1 100000))
(time (map bouncy1 numeri) 10)
;-> 934.53
(time (map bouncy2 numeri) 10)
;-> 975.42


---------
docstring
---------

Una docstring è una stringa letterale specificata nel codice sorgente che viene utilizzata, come un commento, per documentare uno specifico segmento di codice.
newLISP supporta l'inserimento di una docstring nelle funzione, ma non ha alcun metodo per recuperarla. Possiamo scrivere una funzione che estrae la docstring, se presente, di una funzione. Sul forum di newLISP Nigel Brown e HPW hanno proposto la seguente funzione:

(define (doc f)
  "(doc f) - display function f's doc string, if present"
  (if (and (or (lambda? f) (macro? f)) (string? (nth 1 f)))
      (nth 1 f)
      nil))

Esempi:

(define (somma a b)
"(somma a b) - somma due numeri interi"
(+ a b))

(doc somma)
;-> "(somma a b) - somma due numeri interi"

(doc doc)
"(doc f) - display function f's doc string, if present"

In questo modo possiamo avere un help sulle funzioni scritte dall'utente.


--------------
Numeri sfenici
--------------

Sono chiamati “sfenici” (dal greco σφήν, cuneo) i numeri naturali che sono il prodotto di tre primi distinti.

I numeri sfenici minori di 500 sono:
 30, 42, 66, 70, 78, 102, 105, 110, 114, 130, 138, 154, 165, 170, 174, 182,
 186, 190, 195, 222, 230, 231, 238, 246, 255, 258, 266, 273, 282, 285, 286,
 290, 310, 318, 322, 345, 354, 357, 366, 370, 374, 385, 399, 402, 406, 410,
 418, 426, 429, 430, 434, 435, 438, 442, 455, 465, 470, 474, 483, 494, 498

Possiamo scrivere una funzione che verifica se un numero è sfenico:

(define (sfenico? num)
  (let (f (factor num))
    (and (= (length f) 3) (!= (f 0) (f 1) (f 2)))))

(sfenico? 30)
;-> true

(filter true? (map (fn(x) (if x $idx)) sf))
;-> (30 42 66 70 78 102 105 110 114 130 138 154 165 170 174 182 186 190 195 222 230 231
;->  238 246 255 258 266 273 282 285 286 290 310 318 322 345 354 357 366 370 374 385
;->  399 402 406 410 418 426 429 430 434 435 438 442 455 465 470 474 483 494 498 506
;->  518 530 534 555 561 574 582 590 595 598 602 606 609 610 615 618 627 638 642 645
;->  646 651 654 658 663 665 670 678 682 705 710 715 730 741 742 754 759 762 777 782
;->  786 790 795 805 806 814 822 826 830 834 854 861 874 885 890 894 897 902 903 906
;->  915 935 938 942 946 957 962 969 970 978 986 987 994)

Vediamo la velocità:

(time (map sfenico? (sequence 0 100000)))
;-> 44.88
(time (map sfenico? (sequence 0 1000000)))
;-> 794.902
(time (map sfenico? (sequence 0 10000000)))
;-> 17351.718


---------------------
Bilancia a due piatti
---------------------

Qual'è il minimo numero di pesi (masse campione) e il loro peso per pesare da 1 fino a n in una bilancia a due piatti?

La soluzione si trova nel sistema binario: occorre convertire il numero n in binario ed utilizzare come pesi i valori di tutte le potenze di 2 che si trovano nella conversione

Esempio per n = 10:

(bits 10)
;-> 1010

Ci servono quattro cifre (0 o 1) per rappresentare 10 in binario:

1*2^3 + 0*2^2 + 1*2^1 + 0*2^0 = 1*8 + 0*4 + 1*2 + 0*1 = 10

I quattro valori che ci servono sono tutte le potenze di 2 coinvolte:

2^0 = 1, 2^1 = 2, 2^2 = 4, 2^3 = 8

Quindi con quattro pesi di valore 1,2,4,8 possiamo pesare qualunque peso da 1 a 10.

Scriviamo una funzione:

(define (pesi? n)
  (let (out '())
    (for (i 0 (- (length (bits n)) 1))
      (push (pow 2 i) out -1))))

(pesi? 100)
;-> (1 2 4 8 16 32 64)

(pesi? 1000)
;-> (1 2 4 8 16 32 64 128 256 512)


-----------
Somma di 6s
-----------

Calcolare per n > 0 la somma della seguente espressione:

S(n) = 6 + 66 + 666 + ... 6(n volte)

Scriviamo una funzione:

(define (s6 n)
  (local (out)
    (setq out 0)
    (setq prev 0)
    (for (i 1 n)
      ; s(i) = s(n-1)*10 + 6
      (setq val (+ (* prev 10) 6))
      (setq out (+ out val))
      (setq prev val)
    )
    out))

Vediamo i risultati:

(map s6 (sequence 1 11))
;-> (6 72 738 7404 74070 740736 7407402 74074068
;->  740740734 7407407400 74074074066)

(+ 6 66 666 6666 66666 666666)
;-> 740736

Dal punto di vista matematico:

S(n) = 6 + 66 + 666 + ... + 6[n volte] =
     = (0+6) + (60+6) + (660 + 6) + ... + (666...60 + 6) =
     = 10 * (6 + 66 + 666 + ... + 6[n-1 volte]) + 6*n =
     = 10 * S(n-1) + 6n =
     = 10 * (S(n) - 6[n volte])

Risolvendo per S(n):

9*S(n) = 6[n volte]0 - 6*n
       = (2/3)*(9[n volte]0 - 9*n)
  S(n) = (2/3)*(1[n volte]0 - n)

Adesso poichè risulta:

1[n volte]0 = 10 + 10^2 +...+ 10^n = 10*(10^n - 1)/9

Possiamo scrivere:

S(n) = (2/3)*(10*(10^n - 1)/9 - n) =
     = (2/27) * (10^(n+1) - 10 - 9n)

Implementiamo una funzione:

(define (s6m n)
  (/ (* 2 (- (pow 10 (+ n 1)) 10 (* 9 n))) 27))

La divisione "/" per 27 viene applicata per ultima per evitare arrotondamenti.

(map s6m (sequence 1 11))
;-> (6 72 738 7404 74070 740736 7407402 74074068
;->  740740734 7407407400 74074074066)

Le due funzioni producono gli stessi risultati. Per usarle con n più grandi dovremmo usare i big-integer.

Vediamo la differenza di velocità:

(time (map s6 (sequence 1 11)) 100000)
;-> 961.145
(time (map s6m (sequence 1 11)) 100000)
;-> 300.694

La funzione "matematica" è tre volte più veloce (almeno per gli interi a 64 bit).


---------------
Serie ricorsiva
---------------

Una serie è definita in questo modo:

f[0](x) = 1/(1 - x)

f[n](x) = f0(f[n-1](x)) per n=1,2,3,4...

Calcolare f[1976](1976).

Proviamo a definire una funzione che calcola questa serie utilizzando la primitiva "series".

(series exp-start func num-count)

Partendo da "num-count" usa la funzione "func" per trasformare l'espressione precedente nell'espressione successiva "num-count" volte, in altre parole applica la funzione "func" al valore "exp-start" e il valore risultante viene passato di nuovo a "func" e cosi via per "num-count" volte. Restituisce una lista con tutti i valori calcolati.

Esempio:

(series 2 (fn(x) (div 1 x)) 4)
;-> (2 0.5 2 0.5)
primo valore = 2
secondo valore (fn 2) = 1/2 = 0.5
terzo valore (fn (fn 2)) = (fn 0.5) = 1/0.5 = 2
quarto valore (fn (fn (fn 2))) = (fn (fn 0.5)) = (fn 2) = 1/2 = 0.5

Più interessante utilizzare la funzione fn(x) = 1/(1+x) che genera numeri che si avvicinano al valore inverso del rapporto aureo:

(series 1 (fn (x) (div (add 1 x))) 20)
;-> (1 0.5 0.6666666 0.6 0.625 0.6153846 0.619047 0.6176470 0.6181818
;->  0.6179775 0.6180555 0.6180257 0.6180371 0.6180327 0.6180344
;->  0.6180338 0.6180340 0.6180339 0.6180339 0.6180339)

Scriviamo la nostra funzione e applichiamo la funzione "series" verificando i risultati:

(define (f0 x) (div 1 (- 1 x)))

(series (f0 1976) f0 1)
;-> -0.0005063291139240507
(f0 1976)
;-> -0.0005063291139240507

(series (f0 1976) f0 2)
;-> (-0.0005063291139240507 1)
(f0 (f0 1976))
;-> 1

(series (f0 1976) f0 3)
;-> (-0.0005063291139240507 1 1.#INF)
(f0 (f0 (f0 1976)))
;-> 1.#INF

Avendo raggiunto un numero infinito "1.#INF" non possiamo proseguire nel calcolo, cioè non possiamo scrivere:

(series (f0 1976) f0 1976)

per ottenere la soluzione corretta.

Proviamo a sviluppare la serie matematicamente usando l'espressione della funzione:

  f0(x) = 1/(1-x)

  f1(x) = f0(f0(x)) = 1/(1 - (1/(1-x))) = (1-x)/(-x)

  f2(x) = f0(f1(x)) = 1/(1 - (1-x)/(-x)) = x

  f3(x) = f0(f2(x)) = 1/(1-x) = f0(x)

Questo schema si ripete:

  f4(x) = f1(x)
  f5(x) = f2(x)
  f6(x) = f0(x)

Quindi:

  per (n+1) la serie vale f1(x)
  per (n+2) la serie vale f2(x)
  per (n+3) la serie vale f0(x)

con n = 0,1,2,3,4,...

Quindi per scrivere la soluzione prima definiamo le tre funzioni:

(define (f0 x) (div 1 (- 1 x)))
(define (f1 x) (div (- 1 x) (- x)))
(define (f2 x) x)

Adesso definiamo la nostra procedura utilizzando un vettore che contiene le tre funzioni che vengono chiamate in base al valore di n:

(define (f n x)
  (let (funcs (array 3 (list f0 f1 f2)))
    ((funcs (% n 3)) x)))

Proviamo a calcolare quanto richiesto:

(f 1976 1976)
;-> 1976


-----------------
Sei contro cinque
-----------------

Eva lancia 6 monete. Veronica lancia 5 monete.
Qual'è la probabilità che Eva ottenga più "teste" di Veronica?

Poniamo che 1 sia "testa" e 0 "croce".

(define (test iter)
  (let (e 0)
    (for (i 1 iter)
      (setq eva (rand 2 6))
      (setq Veronica (rand 2 5))
      (if (> (count '(1) eva) (count '(1) Veronica))
          (++ e))
      ;(println (count '(1) eva) { } (count '(1) Veronica) { } e)
      ;(read-line)
    )
    (list e iter (div e iter))))

(test 1000)
;-> (489 1000 0.489)
(test 10000)
;-> (5028 10000 0.5028)
(test 100000)
;-> (49865 100000 0.49865)
(test 1000000)
;-> (500251 1000000 0.500251)
(test 10000000)
;-> (5000474 10000000 0.5000474)

Come ci aspettavamo la simulazione mostra che Eva ha una probabilità leggermente maggiore del 50% (0.5) di ottenere più teste di Veronica, ma non possiamo essere molto precisi sul valore vero. Inoltre esistono anche le simulazioni con 1000 e 100000 lanci che mostrano una probabilità leggermente inferiore al 50% (0.489 e 0.49865).

Dal punto di vista matematico possiamo ragionare in modo generalizzato:

Eva lancia (n + 1) monete
Veronica lancia n monete

Ci possono essere due risultati (eventi):

1) Eva ottiene più teste di Veronica, oppure
2) Eva ottiene più croci di Veronica.

Questi risultati sono autoescludenti (non possono risultare contemporaneamente, o accade l'uno o accade l'altro) e la loro probabilità vale esattamente 1/2 per entrambi.

Quindi la probabilità che Eva ottenga più "teste" di Veronica è del 50%. Strano ma vero.

Possiamo anche dimostrarlo calcolando la probabilità reale con la formula:

          numero eventi favorevoli
P(Eva) = --------------------------
            numero totale eventi

Generiamo le combinazioni di Eva e quelle di Veronica:

(define (comb-rep k lst)
  (cond ((zero? k 0) '(()))
        ((null? lst) '())
        (true
         (append (map (lambda (x) (cons (first lst) x))
                      (comb-rep (- k 1) lst))
                 (comb-rep k (rest lst))))))

Per Eva:
(setq lst1 (comb-rep 6 '(1 0)))
;-> ((1 1 1 1 1 1) (1 1 1 1 1 0) (1 1 1 1 0 0) (1 1 1 0 0 0)
;->  (1 1 0 0 0 0) (1 0 0 0 0 0) (0 0 0 0 0 0))

Per Veronica:
(setq lst2 (comb-rep 5 '(1 0)))
;-> ((1 1 1 1 1) (1 1 1 1 0) (1 1 1 0 0) (1 1 0 0 0) (1 0 0 0 0) (0 0 0 0 0))

Il numero di eventi è dato dal numero di combinazioni di Eva moltiplicato il numero di combinazioni di Veronica (perchè ogni combinazione di Eva va confrontata con ogni combinazione di Veronica):

(setq num-eventi (* (length lst1) (length lst2)))
;-> 42

Adesso confrontiamo i 42 eventi e verifichiamo quale sia il risultato.
Per esempio, i primi due eventi sono:

(1 1 1 1 1 1) contro (1 1 1 1 1) ==> 6 per Eva e 5 per Veronica ==> vince Eva
(1 1 1 1 1 1) contro (1 1 1 1 0) ==> 6 per Eva e 4 per Veronica ==> vince Eva

Gli ultimi due eventi sono:

(0 0 0 0 0 0) contro (1 0 0 0 0) ==> 0 per Eva e 1 per Veronica ==> vince Veronica
(0 0 0 0 0 0) contro (0 0 0 0 0) ==> 0 per Eva e 0 per Veronica ==> vince Veronica

In codice:

(setq eva 0)
(setq eventi 0)
(dolist (el1 lst1)
  (dolist (el2 lst2)
    (if (> (first (count '(1) el1)) (first (count '(1) el2)))
        (++ eva)
    )
    (++ eventi)
  )
  (list eventi eva (div eva eventi)))
;-> (42 21 0.5)

Eva vince 21 eventi su 42, quindi la probabilità è del 50%.


------------------------------
Torneo ad eliminazione diretta
------------------------------

Un circolo di scacchi invita 32 giocatori di pari capacità a partecipare ad un torneo ad eliminazione diretta (chi vince va avanti, chi perde va fuori).
Qual'è la probabilità che due giocatori qualsiasi si scontrino durante il torneo?

Due giocatori, A e B, possono giocare insieme se:
1) si incontrano al primo turno, oppure
2) entrambi passano il primo turno e si incontrano al secondo turno, oppure
3) entrambi passano il secondo turno e si incontrano al terzo turno, oppure
x) entrambi passano il turno (x - 1) e si incontrano al turno x, oppure
N) giocano contro in finale

Questi eventi sono mutuamente esclusivi (se ne può verificare soltanto uno).

Quante partite giocano i due finalisti? Ad ogni turno si dimezzano i giocatori: 16, 8, 4, 2, 1. Quindi nel nostro caso i finalisti giocano 5 partite (32 = 2^5).

Si può dimostrare che la probabilità che due giocatori qualsiasi si scontrino vale:

P(n) = 1/2^(k-1), dove n = 2^k (con n giocatori).

Infatti, ci sono (2^n - 1) partite tra tutte le coppie e ci sono binom(2^n 2) coppie di giocatori.

(define (chess n)
  (let (k (length (factor n)))
    (div (pow 2 (- k 1)))))

(chess 2)

(- (length (factor 32)) 1)

Vediamo come definire una simulazione:

(define (torneo players iter)
  (local (num k g p1 p2 lst1 lst2 conta stop turn out)
    (setq num players)
    (setq k (/ num 2))
    (setq p1 1)
    (setq p2 2)
    (setq lst1 (list p1 p2))
    (setq lst2 (list p2 p1))
    (setq conta 0)
    ; ciclo sul numero di simulazioni di un torneo
    (for (x 1 iter)
      ; lista giocatori (1..num)
      (setq g (sequence 1 num))
      (setq stop nil)
      ; ciclo sulle partite del torneo
      (for (i 1 (length (factor num)) 1 stop)
        ; divido i giocatori in coppie
        (setq turn (explode (randomize g) 2))
        ; se i giocatori si scontrano...
        (cond ((or (find lst1 turn) (find lst2 turn))
                ; allora aggiorno il contatore e
                ; termino la simulazione di questo torneo
                (++ conta)
                (setq stop true))
              ; se siamo arrivati alla finale
              ; termino la simulazione di questo torneo
              ; (non ci interessa il vincitore)
              ((= 1 (length turn))
               (setq stop true))
              (true
                ; altrimenti procedo con il prossimo turno del torneo
                (setq g '())
                ; ciclo sulla lista turn per determinare i vincitori
                ; (ognuno dei due giocatori di ogni coppia
                ; ha il 50% di probabilità di vincere)
                (dolist (el turn)
                  (if (zero? (rand 2))
                      (push (first el) g -1)
                      (push (last el) g -1))))
        )
      )
    )
    (div conta iter)))

Facciamo alcune prove:

(torneo 8 1000000)
;-> 0.249886
(chess 8)
;-> 0.25

(torneo 16 1000000)
;-> 0.124973124973125
(chess 16)
;-> 0.125

(torneo 32 1000000)
;-> 0.062574
(chess 32)
;-> 0.0625

(torneo 64 1000000)
;-> 0.03146
(chess 64)
;-> 0.03125


--------
Roulette
--------

Un giocatore ha a disposizione un certo capitale C e decide di giocare alla roulette con la strategia di
puntare sempre sul Rosso la metà del capitale posseduto in quel momento.
Dal punto di vista probabilistico, dopo n puntate il giocatore ha vinto, perso o pareggiato?

Quando vince il suo capitale diventa C*(3/2), mentre quando perde il capitale diventa C*(1/2). Dopo n puntate (con n numero pari) si avranno n/2 vittorie e n/2 sconfitte, cioè:

C(n) = C*(3/2)^(n/2) * C*(1/2)^(n/2) = C*(3/4)^(n/2)

Quindi il giocatore più gioca e più perde.

(define (cap c n) (mul c (pow (div 3 4) (/ n 2))))

Partendo con un capitale di 1000 otteniamo:

(cap 1000 10)
;-> 237.3046875
(cap 1000 20)
;-> 56.31351470947266
(cap 1000 30)
;-> 13.36346101015806

Quindi la strategia del giocatore lo porterà rapidamente in rovina.


-------------------------------
Daniel Dennet Quinian Crossword
-------------------------------

Questo non c'entra con la programmazione, ma è molto interessante: due cruciverba (crossword) che hanno soluzione doppia. Le definizioni sono in inglese perchè è impossibile tradurle mantenendo anche le doppie soluzioni. Di seguito sono riportate anche le soluzioni.

Crossword 3x3
-------------
Across
1. Suck the resources out of
2. Epoch
3. Sleep furniture

Down
1. Retentive membrane
2. Earlier
3. For some kids, a best friend

Solutions:

  W E D
  E R A
  B E D

  S A P
  A G E
  C O T


Crossword 4x4
-------------
Across
1. Dirty stuff
2. A great human need
3. To make smooth
4. Movie actor

Down
1. Vehicle dependent on H2O
2. We usually want this
3. Just above
4. U.S. state (abbrev.)

Solutions:

S L O P      S M O G
L O V E      L O V E
E V E N      E V E N
D E R N      D E R ?

S M U T
H O P E
I R O N
P E N N


----------------------------------------
Lista delle fattorizzazioni di un numero
----------------------------------------

Ogni numero intero ha una scomposizione primitiva e altre scomposizioni generate dalle combinazioni dei prodotti dei fattori della scomposizione primitiva.
Prendiamo per esempio il numero 24:

Scomposizione primitiva:
(factor 24)
;-> (2 2 2 3)

Le altre scomposizioni sono:
(2 * 2 * (2*3)) = (2 2 6)
(2 * (2*2) * 3) = (2 4 3)
(2 * (2*2*3))   = (12 2)
((2*2*2) * 3)   = (8 3)
((2*2) * (2*3)) = (4 6)

La seguente funzione calcola ricorsivamente tutte le fattorizzazioni di un numero:

(define (get-factorizations n)
  (let (afc '())
    (all-fact n '() n)))

(define (all-fact num parfac parval)
  (let ((newval parval) (i (- num 1)))
    (while (>= i 2)
      (cond ((zero? (% num i))
              (if (> newval 1) (setq newval i))
              (if (and (<= (/ num i) parval) (<= i parval) (>= (/ num i) i))
                  (begin
                    (push (append parfac (list i (/ num i))) afc -1)
                    (setq newval (/ num i))
                  )
              )
              (if (<= i parval)
                  (all-fact (/ num i) (append parfac (list i)) newval)
              )
            )
      )
      (-- i)
    )
    (sort (unique (map sort afc)))))

Facciamo alcune prove:

(get-factorizations 8)
;-> ((2 2 2) (2 4))
(get-factorizations 12)
;-> ((2 2 3) (2 6) (3 4))
(get-factorizations 24)
;-> ((2 2 2 3) (2 2 6) (2 3 4) (2 12) (3 8) (4 6))
(get-factorizations 280)
;-> ((2 2 2 5 7) (2 2 2 35) (2 2 5 14) (2 2 7 10) (2 2 70)
;->  (2 4 5 7) (2 4 35) (2 5 28) (2 7 20) (2 10 14) (2 140)
;->  (4 5 14) (4 7 10) (4 70) (5 7 8) (5 56) (7 40) (8 35)
;->  (10 28) (14 20))

Per i numeri primi non esiiste alcuna fattorizzazione:

(get-factorizations 11)
;-> ()
(get-factorizations 577)
;-> ()

Comunque questa funzione è inutilizzabile per valori che hanno molti fattori nella loro scomposizione primitiva:

(factor 12000)
;-> (2 2 2 2 2 3 5 5 5)

(time (println (get-factorizations 12000)))
;->  ....
;->  (75 160)
;->  (80 150)
;->  (96 125)
;->  (100 120))
;-> 275880.184


-------------------------
Algoritmo di Bellman-Ford
-------------------------

L'algoritmo di Bellman–Ford trova i percorsi più brevi da un nodo iniziale a tutti nodi di un grafo. L'algoritmo può elaborare tutti i tipi di grafo, a condizione che il grafo non contenga un ciclo di lunghezza negativa. Se il grafo contiene un ciclo di lunghezza negativa, l'algoritmo può rilevarlo.
L'algoritmo tiene traccia delle distanze dal nodo di partenza a tutti i nodi del grafo. Inizialmente, la distanza dal nodo di partenza è 0 e la distanza da tutti gli altri nodi è infinita. L'algoritmo riduce le distanze trovando i archi che accorciano i percorsi fino a quando non è possibile ridurre alcuna distanza.

Vediamo come funziona utilizzando il seguente grafo:

        0        INF
      +---+  5  +---+
      | 0 |<--->| 1 |<---\
      +---+     +---+     \ 2
        |  \      |        \       INF
        |   \     |         \     +---+
      3 |    \7   | 3        |--->| 4 |
        |     \   |         /     +---+
        |      \  |        /
      +---+     +---+     / 2
      | 2 |<--->| 3 |<---/
      +---+  1  +---+
       INF       INF

Ad ogni nodo del grafico viene assegnata una distanza. Inizialmente, la distanza dal nodo iniziale è 0 e la distanza da tutti gli altri nodi è infinita (INF). L'algoritmo ricerca archi che riducono le distanze. Per primo cosa tutti gli archi del nodo 0 riducono le distanze:

        0         5
      +---+  5  +---+
      | 0 |<--->| 1 |<---\
      +---+     +---+     \ 2
        |  \      |        \       INF
        |   \     |         \     +---+
      3 |    \7   | 3        |--->| 4 |
        |     \   |         /     +---+
        |      \  |        /
      +---+     +---+     / 2
      | 2 |<--->| 3 |<---/
      +---+  1  +---+
        3         7

Dopo questo gli archi 1-->4 e 2-->3 riducono la distanza:

        0         5
      +---+  5  +---+
      | 0 |<--->| 1 |<---\
      +---+     +---+     \ 2
        |  \      |        \        7
        |   \     |         \     +---+
      3 |    \7   | 3        |--->| 4 |
        |     \   |         /     +---+
        |      \  |        /
      +---+     +---+     / 2
      | 2 |<--->| 3 |<---/
      +---+  1  +---+
        3         4

Infine l'arco 3-->4 riduce la distanza:

        0         5
      +---+  5  +---+
      | 0 |<--->| 1 |<---\
      +---+     +---+     \ 2
        |  \      |        \        6
        |   \     |         \     +---+
      3 |    \7   | 3        |--->| 4 |
        |     \   |         /     +---+
        |      \  |        /
      +---+     +---+     / 2
      | 2 |<--->| 3 |<---/
      +---+  1  +---+
        3         4

A questo punto non è possibile ridurre le distanze e abbiamo calcolato tutte le distanze minime dal nodo di partenza (0) a tutti gli altri nodi.

La seguente implementazione dell'algoritmo determina le distanze più brevi da un nodo iniziale a tutti i nodi del grafo. Il codice presuppone che il grafo sia memorizzato come una lista di archi che consiste in una lista della forma (a, b, w): questo significa che c'è un arco dal nodo a al nodo b con peso w.
L'algoritmo consiste di (n-1) cicli e ad ogni ciclo l'algoritmo attraversa tutti gli archi del grafo e cerca di ridurre le distanze. L'algoritmo costruisce una "lista delle distanze" che contiene i valori delle distanze dal nodo iniziale a tutti i nodi del grafo e una "lista di predecessori" che serve per ricostruire tutti i percorsi minimi dal nodo iniziale a tutti i nodi del grafo. La costante INF indica una distanza infinita.
La complessità temporale dell'algoritmo è O(nm), perché l'algoritmo consiste di n-1 cicli e itera su tutti gli archi per ogni ciclo. Se non ci sono cicli negativi nel grafo, tutte le distanze sono definitive dopo n-1 cicli, perché ogni percorso più breve può contenere al massimo n-1 archi.
In pratica, le distanze finali di solito possono essere trovate prima che si esauriscano tutti gli n-1 cicli, ertanto, un possibile modo per rendere l'algoritmo più efficiente è arrestare l'algoritmo se nessuna distanza può essere ridotta durante un ciclo.

(define (bf graph start num-nodi)
  (local (dist a b w)
    (setq maxval 999999)
    (setq dist (array n (list maxval)))
    (setq pred (array n '(nil)))
    (setf (dist start) 0)
    (for (i 1 (- n 1))
      (for (j 0 (- (length graph) 1))
        (setq a (graph j 0))
        (setq b (graph j 1))
        (setq w (graph j 2))
        ;(println a { } b { } w)
        ;(read-line)
        (if (!= (dist a) maxval)
            (if (> (dist b) (+ (dist a) w))
                (begin
                 (setf (dist b) (+ (dist a) w))
                 (setf (pred b) a)
                ))
        )
      )
    )
    ; cicli negativi?
    (for (j 0 (- (length graph) 1))
      (setq a (graph j 0))
      (setq b (graph j 1))
      (setq w (graph j 2))
      (if (and (!= (dist a) maxval) (< (+ (dist a) w) (dist b)))
          (println "ERRORE: ciclo negativo")
      )
    )
    ; Ricostruzione percorsi completi
    (for (nodo 0 (- n 1))
      (setq path '())
      (print "da: " start " a: " nodo " = ")
      (cond ((= start nodo)
             (setq path '(nil)))
             ;(println "nil"))
            (true
             (setq step (pred nodo))
             (until (= start step)
               (push step path -1)
               ;(print step { } )
               (setq step (pred step))
             )
             ; inverte percorso
             (reverse path)
             ; inserisce nodo iniziale
             (push start path)
             ; inserisce nodo finale
             (push nodo path -1)
             ;(println nodo)
            )
      )
      (println path)
    )
    (list dist pred)))

Proviamo con il grafo seguente (disegnatelo con carta e penna):

(setq graph '((0 1 50) (0 2 30) (0 3 10)
              (1 0 50) (1 5 40)
              (2 0 30) (2 1 10) (2 3 10) (2 4 10)
              (3 0 10) (3 2 10) (3 6 10)
              (4 2 10) (4 5 20)
              (5 1 40) (5 4 20)
              (6 5 80)))

(bf graph 0)
;-> da: 0 a: 0 = (nil)
;-> da: 0 a: 1 = (0 3 2 1)
;-> da: 0 a: 2 = (0 3 2)
;-> da: 0 a: 3 = (0 3)
;-> da: 0 a: 4 = (0 3 2 4)
;-> da: 0 a: 5 = (0 3 2 4 5)
;-> da: 0 a: 6 = (0 3 6)
;-> ((0 30 20 10 30 50 20) (nil 2 3 0 2 4 3))

(bf graph 1)
;-> da: 1 a: 0 = (1 0)
;-> da: 1 a: 1 = (nil)
;-> da: 1 a: 2 = (1 0 3 2)
;-> da: 1 a: 3 = (1 0 3)
;-> da: 1 a: 4 = (1 5 4)
;-> da: 1 a: 5 = (1 5)
;-> da: 1 a: 6 = (1 0 3 6)
;-> ((50 0 70 60 60 40 70) (1 nil 3 0 5 1 3))

(bf graph 4)
;-> da: 4 a: 0 = (4 2 3 0)
;-> da: 4 a: 1 = (4 2 1)
;-> da: 4 a: 2 = (4 2)
;-> da: 4 a: 3 = (4 2 3)
;-> da: 4 a: 4 = (nil)
;-> da: 4 a: 5 = (4 5)
;-> da: 4 a: 6 = (4 2 3 6)
;-> ((30 20 10 20 0 20 30) (3 2 4 2 nil 4 3))


----------------
Catene di Markov
----------------

Una catena di Markov è un processo casuale che consiste di stati e transizioni tra di loro. Per ogni stato, conosciamo le probabilità di spostarci in altri stati. Una catena di Markov può essere rappresentata come un grafico i cui nodi sono stati e gli archi sono transizioni. Ad esempio, consideriamo un problema in cui ci troviamo al piano 1 di un edificio di n piani. Ad ogni passo, ci spostiamo casualmente di un piano su o di un piano giù. Qual è la probabilità di trovarsi al piano m dopo k passi?
In questo problema, ogni piano dell'edificio corrisponde a uno stato in una catena di Markov.
Ad esempio, se n = 5, il grafico è il seguente:

      --> 1      --> 1/2    --> 1/2    --> 1/2
   +----------+ +--------+ +--------+ +---------+
   |          | |        | |        | |         |
  +---+      +---+      +---+      +---+      +---+
  | 1 | <--> | 2 | <--> | 3 | <--> | 4 | <--> | 5 |
  +---+      +---+      +---+      +---+      +---+
   |          | |        | |        | |         |
   +----------+ +--------+ +--------+ +---------+
      1/2 <--     1/2 <--    1/2 <--     1 <--

La distribuzione di probabilità di una catena di Markov è un vettore [p1, p2, ..., pn], dove pk è la probabilità che lo stato corrente sia k. La formula p1 + p2 + ... + pn = 1 vale sempre.
Nello scenario precedente, la distribuzione iniziale è (1 0 0 0 0), perché iniziamo sempre dal piano 1. La distribuzione successiva è [0,1,0,0,0], perché possiamo solo muoverci dal piano 1 al piano 2. Dopodiché, possiamo spostarci di un piano in alto o di un piano in basso, quindi la distribuzione successiva è (1/2 0 1/2 0 0) e così via.

Una catena Markov si basa sulla proprietà di Markov: la probabilità che un sistema casuale cambi da uno stato particolare al successivo stato di transizione dipende solo dallo stato e dal tempo presente ed è indipendente dagli stati precedenti. Il fatto che il probabile stato futuro di un processo casuale sia indipendente dalla sequenza di stati che esisteva prima di esso rende la catena di Markov un processo senza memoria che dipende solo dallo stato corrente della variabile.

Un modo efficiente per simulare il cammino in una catena di Markov è usare la programmazione dinamica. L'idea è di mantenere il vettore della distribuzione di probabilità e ad ogni passaggio esaminare tutte le possibilità su come possiamo muoverci. Usando questo metodo, possiamo simulare una camminata di m passi in tempo O(n^2*m).

Le transizioni di una catena di Markov possono anche essere rappresentate come una matrice di transizione che aggiorna la distribuzione di probabilità. Per l'esempio precedente, la matrice vale:

  0   1/2   0     0     0
  1   0     1/2   0     0
  0   1/2   0     1/2   0
  0   0     1/2   0     1
  0   0     0     1/2   0

Quando moltiplichiamo una distribuzione di probabilità per questa matrice, otteniamo la nuova distribuzione dopo aver fatto un passo. Ad esempio, possiamo passare dalla distribuzione (1 0 0 0 0) alla distribuzione (0 1 0 0 0) come segue:

  0   1/2   0     0     0
  1   0     1/2   0     0
  0   1/2   0     1/2   0
  0   0     1/2   0     1
  0   0     0     1/2   0

Calcolando le potenze della matrice in modo efficiente, possiamo calcolare la distribuzione dopo m passi in tempo O(n^3*log(m)).

In generale, i processi Markoviani (che generano le catene di Markov) sono caratterizzati dalle seguenti proprietà:

1) Rappresentano transizioni tra stati che avvengono in modo probabilistico.

2) Le probabilità di transizione non dipendono dal numero di transizioni effettuate (proprietà di omogeneità).

3) Le probabilità di transizione dipendono unicamente dallo stato attuale (proprietà memoryless, o di assenza di memoria).

Le catene di Markov sono uno strumento matematico essenziale che aiuta a semplificare la previsione dello stato futuro di processi stocastici complessi, infatti questo dipende esclusivamente dallo stato attuale del processo e vede il futuro come indipendente dal passato. Ad esempio vengono utilizzate per le previsioni del tempo, la predizione di parole digitate sul telefono, riconoscimento della scrittura, simulazione di ecosistemi, ecc.

Adesso vediamo una implementazione pratica delle catene di Markov.

Data una catena di Markov G, trovare la probabilità di raggiungere lo stato F all'istante t = T se partiamo dallo stato S all'istante t = 0.
Una catena di Markov è un processo casuale costituito da vari stati e dalle probabilità di spostarsi da uno stato all'altro. Possiamo rappresentarlo utilizzando un grafo orientato dove i nodi rappresentano gli stati e gli archi rappresentano la probabilità di andare da un nodo all'altro. Ci vuole una unità tempo per spostarsi da un nodo all'altro. La somma delle probabilità associate degli archi uscenti vale 1 per ogni nodo.

Consideriamo la catena di Markov (G) dell'immagine "markov.png".
Possiamo creare una matrice di adiacenza della catena di Markov per rappresentare le probabilità di transizioni tra gli stati.

La matrice di adiacenza per il nostro grafo vale:

      0      0.09   0      0      0     0
      0.23   0      0      0      0     0.62
      0      0.06   0      0      0     0
      0.77   0      0.63   0      0     0
      0      0      0      0.65   0     0.38
      0      0.85   0.37   0.35   1.0   0

Possiamo osservare che la distribuzione di probabilità al tempo t è data da P(t) = M * P(t - 1), e la distribuzione di probabilità iniziale P(0) è un vettore zero con l'elemento S-th che vale 1. Usando questi risultati, possiamo risolvere l'espressione ricorsiva per P(t). Ad esempio, se prendiamo S = 3, allora P(t) è dato da:

             | 0 |
             | 0 |
P(t) = M^t * | 1 |
             | 0 |
             | 0 |
             | 0 |

La complessità temporale di questo algoritmo vale O(N^3*log(T)) dove N è il numero di stati e T e il numero di transizioni (tempi).

Funzione per calcolare la potenza di una matrice:

(define (pow-matrix mtx p n)
  (let (out (array n n '(0)))
    (for (i 0 (- n 1))
      (setf (out i i) 1)
    )
    (while (> p 0)
      (if (odd? p) (setq out (multiply out mtx)))
      (setq mtx (multiply mtx mtx))
      (setq p (/ p 2))
    )
    out))

(setq m '((2 -2 9) (7 -4 4) (1 2 3)))
(pow-matrix m 2 3)
;-> ((-1 22 37) (-10 10 59) (19 -4 26))

(define (markov matrix num-stati stato-iniziale stato-finale tempo)
  (let (out (pow-matrix matrix tempo num-stati))
    (out (- stato-finale 1) (- stato-iniziale 1))))

Proviamo la funzione:

(setq matrix '((0      0.09   0      0      0     0   )
               (0.23   0      0      0      0     0.62)
               (0      0.06   0      0      0     0   )
               (0.77   0      0.63   0      0     0   )
               (0      0      0      0.65   0     0.38)
               (0      0.85   0.37   0.35   1.0   0   )))

(markov matrix 6 1 2 1)
;-> 0.23
Input:  stato-iniziale = 1, stato-finale = 2, tempo = 1
Output: 0.23
Partiamo dallo stato 1 per t = 0,
La probabilità di raggiungere lo stato 2 per t = 1 vale 0.23.

(markov matrix 6 4 2 100)
;-> 0.284991
Input : stato-iniziale = 4, stato-finale = 2, tempo = 100
Output : 0.284992
Partiamo dallo stato 4 per t = 0,
La probabilità di raggiungere lo stato 2 per t = 100 vale 0.284992.


----------------------
Contornare una matrice
----------------------

Data una matrice NxM contornare la matrice con k righe e colonne con un determinato valore.
Esempio:
          |1 1|
matrice = |1 1|
          |1 1|
k = 2

Valore: 0

        |0 0 0 0 0 0|
        |0 0 0 0 0 0|
        |0 0 1 1 0 0|
output: |0 0 1 1 0 0|
        |0 0 1 1 0 0|
        |0 0 0 0 0 0|
        |0 0 0 0 0 0|

Funzione che contorna una matrice:

(define (pad-matrix mtx pad val)
  (local (row col out)
    (setq out '())
    (if (array? mtx) (setq mtx (array-list mtx)))
    (setq row (+ (* 2 pad) (length mtx)))
    (setq col (+ (* 2 pad) (length (mtx 0))))
    ; aggiunge pad righe iniziali ad out
    (for (i 1 pad)
      (push (dup val col true) out -1)
    )
    ; aggiunge le righe centrali ad out
    (dolist (el mtx)
      (setq cur (append (dup val pad true) el (dup val pad true)))
      (push cur out -1)
    )
    ; aggiunge pad righe finali ad out
    (for (i 1 pad)
      (push (dup val col true) out -1)
    )
    out))

Funzione per stampare una matrice:

(define (print-matrix matrix)
  (local (row col nmax nmin digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq nmax (string (apply max (flat matrix))))
    (setq nmin (string (apply min (flat matrix))))
    (setq digit (add 1 (max (length nmax) (length nmin))))
    (setq fmtstr (append "%" (string digit) "d"))
    (for (i 0 (sub row 1))
      (for (j 0 (sub col 1))
        (print (format fmtstr (matrix i j)))
      )
      (println))
    '.))

(setq m '((1 1) (1 1) (1 1)))

(print-matrix (pad-matrix m 2 0))
;-> |0 0 0 0 0 0|
;-> |0 0 0 0 0 0|
;-> |0 0 1 1 0 0|
;-> |0 0 1 1 0 0|
;-> |0 0 1 1 0 0|
;-> |0 0 0 0 0 0|
;-> |0 0 0 0 0 0|

Il primo indice (0 0) del primo valore (1) della matrice "m" si trova all'indice (pad pad) della matrice "out" di output.

Esempio:

(setq b '((0)))
(for (i 1 9)
  (setq b (pad-matrix b 1 i))
)
(print-matrix b)
;-> 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9
;-> 9 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 9
;-> 9 8 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 8 9
;-> 9 8 7 6 6 6 6 6 6 6 6 6 6 6 6 6 7 8 9
;-> 9 8 7 6 5 5 5 5 5 5 5 5 5 5 5 6 7 8 9
;-> 9 8 7 6 5 4 4 4 4 4 4 4 4 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 3 3 3 3 3 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 2 2 2 2 2 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 2 1 1 1 2 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 2 1 0 1 2 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 2 1 1 1 2 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 2 2 2 2 2 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 3 3 3 3 3 3 3 4 5 6 7 8 9
;-> 9 8 7 6 5 4 4 4 4 4 4 4 4 4 5 6 7 8 9
;-> 9 8 7 6 5 5 5 5 5 5 5 5 5 5 5 6 7 8 9
;-> 9 8 7 6 6 6 6 6 6 6 6 6 6 6 6 6 7 8 9
;-> 9 8 7 7 7 7 7 7 7 7 7 7 7 7 7 7 7 8 9
;-> 9 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 8 9
;-> 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9


----------------------------------------------------
Stringa decimale infinita 12345678910111213141516...
----------------------------------------------------

La stringa decimale infinita viene creata unendo tutti i numeri naturali da 1 a infinito (∞):

"123456789101112131415161718192021222324252627282930..."

Poichè non è possibile memorizzarla interamente in una struttura dati, diventa interessante la soluzione di  due problemi:

1) quale cifra si trova alla posizione K della stringa?
-------------------------------------------------------

Esempi:
K = 1     il primo carattere è "1"
K = 10      10-imo carattere è "1"
K = 11      11-imo carattere è "0"
K = 50      50-imo carattere è "3"
K = 190    190-imo carattere è "1"

Possiamo risolvere questo problema spezzando la stringa in base ai seguenti criteri:
 I primi 9 decimali hanno lunghezza 1, poi 90 numeri sono di lunghezza 2, poi 900 numeri sono di lunghezza 3 e così via, quindi possiamo saltare questi numeri in base al dato K e poi ricavare il carattere cercato.

La K-esima cifra sarà compresa tra 10^k e 10^(k + 1) per qualche k intero.
Se la risposta non è compresa tra 10^m e 10^(m + 1) per il valore di m che stiamo
attualmente verificando, aumentiamo m di 1 e sottraiamo la lunghezza dei numeri da 10^m a 10^(m + 1). Una volta trovata la potenza di 10 dove si trova il numero, tutti i numeri che dobbiamo controllare hanno "ordine" cifre, e possiamo usare la divisione intera per determinare il numero e poi estrarre il carattere con il modulo.

Funzione che calcola la potenza intera di un numero intero:

(define (** num power)
    (if (zero? power)
        1
    (let (out 1)
        (dotimes (i power)
            (setq out (* out num))))))

Funzione che trova la cifra alla posizione k della stringa:

(define (find-digit k)
  (local (ordine intervallo)
    (setq ordine 1L)
    (find-digit-aux k ordine)))

(define (find-digit-aux k ordine)
    (setq intervallo (* 9 ordine (** 10 (- ordine 1))))
    (if (> k intervallo)
        (begin
        (find-digit-aux (- k intervallo) (+ ordine 1)))
        ;else
        (begin
        (setq num (+ (** 10 (- ordine 1)) (/ (- k 1) ordine)))
        (setq numstr (string num))
        (numstr (% (- k 1) ordine)))
    ))

(find-digit 10)
;-> "1"
(find-digit 11)
;-> "0"
(find-digit 50)
;-> "3"
(find-digit 190)
;-> "1"
(find-digit 9)
;-> "9"
(find-digit 0)
;-> "0"
(find-digit 456)
;-> "8"
(find-digit 454)
;-> "1"
(find-digit 2000)
;-> "0"
(find-digit 2001)
;-> "3"
(find-digit 1234)
;-> "4"

Possiamo usare anche un metodo iterativo:

(define (find-cifra k)
  (local (lun conta num strnum)
    (setq lun 1 conta 9 num 1)
    (while (> k (* lun conta))
      (setq k (- k (* lun conta)))
      (++ lun)
      (setq conta (* conta 10))
      (setq num (* num 10))
    )
    (setq num (+ num (/ (- k 1) lun)))
    (setq strnum (string num))
    (int (strnum (% (- k 1) lun)))))

(find-cifra 10)
;-> "1"
(find-cifra 11)
;-> "0"
(find-cifra 50)
;-> "3"
(find-cifra 190)
;-> "1"
(find-cifra 9)
;-> "9"
(find-cifra 0)
;-> "0"
(find-cifra 456)
;-> "8"
(find-cifra 454)
;-> "1"
(find-cifra 2000)
;-> "0"
(find-cifra 2001)
;-> "3"
(find-cifra 1234)
;-> "8"

2) in quale posizione della stringa inizia un numero N?
-------------------------------------------------------

Utilizziamo la tecnica di "Window slicing": creiamo una stringa di numeri da 1 a x e cerchiamo al suo interno il numero N, se non lo troviamo costruiamo un'altra stringa lunga da x a (+ x x) aggiungendo all'inizio gli ultimi len(N) caratteri della stringa precedente (per verificare su il numero N si trova in una sovrapposizione di finestre) e verifichiamo se troviamo N, altrimenti continuiamo con una nuova stringa.

Funzione che genera la stringa da a a b:

(define (genera a b) (join (map string (sequence a b))))

(genera 1 20)
;-> "1234567891011121314151617181920"
(genera 20 40)
;-> "202122232425262728293031323334353637383940"

Funzione di ricerca del numero N nella stringa:

(define (find-str str)
  (setq pos 0)
  (setq lenstr (length str))
  (setq lenwin (max 50 lenstr))
  (setq num1 1)
  (setq num2 (+ num1 lenwin))
  (setq curstr (genera num1 num2))
  (setq indice (find str curstr))
  (until indice
    (setq pos (+ pos (length curstr) (- lenstr)))
    (setq num1 (+ num2 1))
    (setq num2 (+ num1 lenwin))
    (setq curstr (append (slice curstr (- lenstr)) (genera num1 num2)))
    (setq indice (find str curstr))
  )
  (+ pos indice))

(find-str "141")
;-> 17
(find "141" (genera 11 20))
;-> 17

(find-str "67")
;-> 5
(find "67" (genera 1 10))
;-> 5

(find-str "454")
;-> 79
(find "454" (genera 1 100))
;-> 79

(find-str "222")
;-> 33
(find "222" (genera 1 30))
;-> 33

(find-str "85")
;-> 106
(find "85" (genera 1 60))
;-> 106

(find-str "81")
;-> 26
(find "81" (genera 1 60))
;-> 26

(find-str "333")
;-> 55
(find "333" (genera 1 60))
;-> 55

(find-str "12345")
;-> 0

Potremmo usare questa funzione per generare una password, per esempio possiamo passare alla funzione una data speciale ed ottenere un numero che può essere usato come password:

(find-str "19700321")
;-> 12679113

Vediamo se la larghezza della finestra influenza la velocità della funzione:

(define (find-str str window)
  (setq pos 0)
  (setq lenstr (length str))
  (setq lenwin (max window lenstr))
  (setq num1 1)
  (setq num2 (+ num1 lenwin))
  (setq curstr (genera num1 num2))
  (setq indice (find str curstr))
  (until indice
    (setq pos (+ pos (length curstr) (- lenstr)))
    (setq num1 (+ num2 1))
    (setq num2 (+ num1 lenwin))
    (setq curstr (append (slice curstr (- lenstr)) (genera num1 num2)))
    (setq indice (find str curstr))
  )
  (+ pos indice))

(time (find-str "19700321" 10) 10)
;-> 7656.259

(time (find-str "19700321" 50) 10)
;-> 7642.337

(time (find-str "19700321" 255) 10)
;-> 7647.513

(time (find-str "19700321" 1000) 10)
;-> 7624.258

Sembra che la larghezza della finestra non influenzi la velocità della funzione.


-----------------
Numeri early-bird
-----------------

Consideriamo la stringa decimale infinita:

"123456789101112131415161718192021222324252627282930..."

La funzione "(find-cifra k)" trova la cifra che si trova alla posizione k della stringa, ma determina anche il numero corrente della stringa infinita.
Quindi la usiamo per scrivere la nuova funzione "(trova-num k)"che trova il numero corrente della stringa infinita all'indice k.

(define (trova-num k)
  (local (lun conta num strnum)
    (setq lun 1 conta 9 num 1)
    (while (> k (* lun conta))
      (setq k (- k (* lun conta)))
      (++ lun)
      (setq conta (* conta 10))
      (setq num (* num 10))
    )
    (setq num (+ num (/ (- k 1) lun)))
    (setq strnum (string num))
    (int (strnum (% (- k 1) lun)))
    num))

La funzione "(find-str str)" trova la posizione della stringa in cui inizia un numero (passato in formato stringa):

(define (genera a b) (join (map string (sequence a b))))

(define (find-str str)
  (setq pos 0)
  (setq lenstr (length str))
  (setq lenwin (max 50 lenstr))
  (setq num1 1)
  (setq num2 (+ num1 lenwin))
  (setq curstr (genera num1 num2))
  (setq indice (find str curstr))
  (until indice
    (setq pos (+ pos (length curstr) (- lenstr)))
    (setq num1 (+ num2 1))
    (setq num2 (+ num1 lenwin))
    (setq curstr (append (slice curstr (- lenstr)) (genera num1 num2)))
    (setq indice (find str curstr))
  )
  (+ pos indice))

Combinando queste due funzioni possiamo trovare i numeri early-bird.
Per capire cosa sono i numeri early-bird facciamo un esempio:

Vediamo a quale carattere della stringa infinita incontriamo il numero 141:

(find-str "141")
;-> 17

Il numero 141 si incontra al 17-esimo carattere della stringa infinita, infatti:

(genera 1 46)
                  ___
"1234567891011121314151617181920..."

Adesso vediamo quale numero inizia al carattere successivo:

(trova-num 18)
;-> 14

Al 18-esimo carattere inizia il numero 14.

Quindi il numero 141 compare quando inizia il numero 14 nella stringa infinita, cioè  compare prima di quando inizia il numero 141 nella stringa infinita.
Quindi 141 è un numero "early bird" (nato prima).

Possiamo scrivere una funzione che calcola tutti i numeri early-bird fino ad un determinato numero:

(define (early-bird num)
  (let (out '())
    (for (i 1 num)
      (if (< (trova-num (+ (find-str (string i)) 1)) i)
          (push i out -1)))
    out))

(early-bird 50)
;-> (12 21 23 31 32 34 41 42 43 45)

Proviamo la correttezza dei risultati confrontandoli con la sequenza OEIS A116700:

(setq A116700 '(12 21 23 31 32 34 41 42 43 45
      51 52 53 54 56 61 62 63 64 65 67 71 72
      73 74 75 76 78 81 82 83 84 85 86 87 89
      91 92 93 94 95 96 97 98 99 101 110 111
      112 121 122 123 131 132 141 142 151 152
      161 162 171))

(= (early-bird 171) A116700)
;-> true

Vediamo dove possiamo arrivare:

(time (println (length (early-bird 5000))))
;-> 2805
;-> 2694.607
(time (println (length (early-bird 10000))))
;-> 7571
;-> 7400.475
(time (println (length (early-bird 20000))))
;-> 10400
;-> 49163.784
(time (println (length (early-bird 40000))))
;-> 23214
;-> 183631.179


-------------------
Zero elevato a zero
-------------------

Quanto vale 0^0 ?

Proviamo a calcolarlo come limite:

limite(x^x)
 x->0

(define (lim x) (pow x x))

(for (i 1 0.1 -0.1) (println (round i -3) { } (round (lim i) -3)))
;-> 1 1
;-> 0.9 0.91
;-> 0.8 0.837
;-> 0.7 0.779
;-> 0.6 0.736
;-> 0.5 0.707
;-> 0.4 0.693
              <------- inversione di tendenza
;-> 0.3 0.697
;-> 0.2 0.725
;-> 0.1 0.794

(for (i 0.1 0.001 -0.005) (println (round i -5) { } (round (lim i) -5)))
;-> 0.1   0.79433
;-> 0.095 0.79962
;-> 0.090 0.80516
;-> 0.085 0.81096
;-> 0.080 0.81705
;-> 0.075 0.82344
;-> 0.070 0.83015
;-> 0.065 0.83722
;-> 0.060 0.84467
;-> 0.055 0.85255
;-> 0.050 0.86089
;-> 0.045 0.86975
;-> 0.040 0.87919
;-> 0.035 0.88929
;-> 0.030 0.90015
;-> 0.025 0.9119
;-> 0.020 0.92474
;-> 0.015 0.93895
;-> 0.010 0.95499
;-> 0.005 0.97386

Poichè il limite tende a 1, allora 0^0 = 1.

Per quale valore si inverte la tendenza (cioè si ha un minimo della funzione)?

La derivata di x^x vale: x^x*(1 + ln(x))

Il minimo si ha nel punto in cui la derivata vale 0:

  x^x*(1+ln(x)) = 0 quando (1 + ln(x)) = 0,

  cioè per x = e^(-1) = 1/e = 0.3678794411714423


------------------
Fattoriale di zero
------------------

Perchè 0! = 1 ?

Il fattoriale di un numero può essere scritto nel modo seguente:

     (x + 1)!
x! = --------
     (x + 1)

Adesso sostituiamo x con alcuni numeri:

3! = 4!/4 = 24/4 = 6
2! = 3!/3 = 6/3  = 2
1! = 2!/2 = 2/2  = 1
0! = 1!/1 = 1/1  = 1

Quindi 0! = 1.


--------------------------------------
Somma delle potenze dei primi n numeri
--------------------------------------

Per trovare la somma dei primi n numeri possiamo usare la formula seguente:

Sum[1..n] (i) = (n*(n+1))/2 = (n^2 + n)/2

(define (sumpot1 n)
  (/ (+ (** n 2) n) 2))

Vediamo come l'ha risolto Gauss a 8 anni (con n = 100):

Esempio: n = 10

1 + 10 = 11
2 +  9 = 11
3 +  8 = 11
4 +  7 = 11
5 +  6 = 11

(n + 1) = 11
n/2 = 5

11 * 5 = 55

Esempio: n = 5

1 + 5 = 6
2 + 4 = 6
3

(12 + 3) = 15

Funzione che calcola la potenza intera di un numero intero (big-integer):

(define (** num power)
    (let (out 1L)
        (dotimes (i power)
            (setq out (* out num)))))

Somma dei primi n quadrati (numeri piramidali)
----------------------------------------------
Sum[1..n] (i^2) = (2*n^3 + 3*n^2 + n)/6

(define (sumpot2 n)
  (/ (+ (* 2 (** n 3)) (* 3 (** n 2)) n) 6))

Assumendo che esista una formula per la somma dei quadrati, la pendenza di quella funzione deve essere quadratica, quindi la funzione che cerchiamo deve essere di terzo grado. Quindi sappiamo che la formula ha la seguente struttura:

   a*n^3 + b*n^2 + c*n + d*n

Con 4 equazioni questo problema è risolto (es. Poniamo n = 0, troviamo che d = 0. Con n = 1, n = 2 e n = 3 otteniamo un sistema lineare di equazioni che risolto produce a = 1/3 , b = 1/2 e c = 1/6).
Con lo stesso metodo possiamo calcolare le sommatorie delle potenze successive.

Somma dei primi n cubi
----------------------
Sum[1..n] (i^3) = (n^4 + 2*n^3 + n^2)/4

(define (sumpot3 n)
  (/ (+ (** n 4) (* 2L (** n 3)) (** n 2)) 4))

Somma delle prime quarte potenze
--------------------------------
Sum[1..n] (i^4) = (6*n^5 + 15*n^4 + 10*n^3 + n)/30

(define (sumpot4 n)
  (/ (+ (* 6L (** n 5)) (* 15L (** n 4)) (* 10L (** n 3)) (- n)) 30))

Somma delle prime quinte potenze
--------------------------------
Sum[1..n] (i^5) = (2*n^6 + 6*n^5 + 5*n^4 - n^2)/12

(define (sumpot5 n)
  (/ (+ (* 2L (** n 6)) (* 6L (** n 5)) (* 5L (** n 4)) (- (** n 2))) 12))

Somma delle prime seste potenze
-------------------------------
Sum[1..n] (i^6) = (6*n^7 + 21*n^6 + 21*n^5 - 7*n^3 + n)/42

(define (sumpot6 n)
  (/ (+ (* 6L (** n 7)) (* 21L (** n 6)) (* 21L (** n 5))
     (- (* 7L (** n 3))) n) 42))

Somma delle prime settime potenze
---------------------------------
Sum[1..n] (i^7) = (3*n^8 + 12*n^7 + 14*n^6 - 7*n^4 + 2*n^2)/24

(define (sumpot7 n)
  (/ (+ (* 3L (** n 8)) (* 12L (** n 7)) (* 14L (** n 6))
        (- (* 7L (** n 4))) (* 2L (** n 2))) 24))

Somma delle prime ottave potenze
--------------------------------
Sum[1..n] (i^8) = (10*n^9 + 45*n^8 + 60*n^7 - 42*n^5 + 20*n^3 - 3*n)/90

(define (sumpot8 n)
  (/ (+ (* 10L (** n 9)) (* 45L (** n 8)) (* 60L (** n 7))
        (* (- 42L) (** n 5)) (* 20L (** n 3)) (* (- 3L) n)) 90))

Somma delle prime none potenze
------------------------------
Sum[1..n] (i^9) = (2*n^10 + 10*n^9 + 15*n^8 - 14*n^6 + 10*n^4 - 3*n^2)/20

(define (sumpot9 n)
  (/ (+ (* 2L (** n 10)) (* 10L (** n 9)) (* 15L (** n 8))
        (* (- 14L) (** n 6)) (* 10L (** n 4)) (* (- 3L) (** n 2))) 20))

Somma delle prime decime potenze
--------------------------------
Sum[1..n] (i^10) = (6*n^11 + 33*n^10 + 55*n^9 - 66*n^7 + 66*n^5 - 33*n^3 + 5*n)/66

(define (sumpot10 n)
  (/ (+ (* 6L (** n 11)) (* 33L (** n 10)) (* 55L (** n 9)) (* (- 66L) (** n 7))
        (* 66L (** n 5)) (* (- 33L) (** n 3)) (* 5 n)) 66))

Per le verifiche possiamo usare la seguente funzione per il confronto dei risultati:

(define (somma pot num)
  (apply + (map (fn(x) (** x pot)) (sequence 1 num))))

Facciamo un test per i primi 100 numeri di tutte le formule:

(for (num 1 100)
  (if (!= (somma 2  num) (sumpot2  num)) (println "ERROR 2: "  num))
  (if (!= (somma 3  num) (sumpot3  num)) (println "ERROR 3: "  num))
  (if (!= (somma 4  num) (sumpot4  num)) (println "ERROR 4: "  num))
  (if (!= (somma 5  num) (sumpot5  num)) (println "ERROR 5: "  num))
  (if (!= (somma 6  num) (sumpot6  num)) (println "ERROR 6: "  num))
  (if (!= (somma 7  num) (sumpot7  num)) (println "ERROR 7: "  num))
  (if (!= (somma 8  num) (sumpot8  num)) (println "ERROR 8: "  num))
  (if (!= (somma 9  num) (sumpot9  num)) (println "ERROR 9: "  num))
  (if (!= (somma 10 num) (sumpot10 num)) (println "ERROR 10: " num))
)
;-> nil


-----------
Cercaparole
-----------

Il "Cercaparole" è un gioco che consiste nel cercare alcune parole inglobate in una matrice di caratteri. Per esempio,

Matrice di caratteri:

(setq matrice
'(("F" "A" "V" "J" "L" "Y" "O" "C" "A" "N" "O" "A" "C" "A" "R")
  ("O" "D" "O" "R" "O" "T" "E" "G" "V" "U" "X" "G" "A" "T" "B")
  ("A" "C" "Y" "L" "O" "G" "N" "L" "T" "F" "O" "R" "L" "A" "V")
  ("C" "O" "R" "U" "I" "I" "G" "E" "L" "L" "N" "G" "C" "C" "X")
  ("S" "R" "N" "A" "K" "M" "N" "I" "F" "O" "N" "Q" "I" "I" "G")
  ("E" "S" "N" "K" "L" "N" "P" "G" "N" "I" "V" "A" "O" "P" "F")
  ("P" "E" "E" "M" "I" "L" "B" "I" "H" "G" "T" "I" "R" "M" "R")
  ("O" "R" "T" "S" "E" "N" "A" "C" "A" "L" "L" "A" "P" "A" "E")
  ("T" "I" "O" "D" "U" "J" "T" "O" "E" "D" "A" "G" "A" "R" "C")
  ("Z" "C" "B" "G" "A" "E" "V" "T" "R" "F" "I" "G" "R" "R" "C")
  ("R" "S" "Y" "D" "R" "N" "I" "L" "X" "I" "X" "P" "O" "A" "E")
  ("F" "L" "Y" "T" "O" "C" "Z" "K" "C" "R" "T" "T" "Y" "Y" "T")
  ("C" "V" "S" "K" "A" "L" "L" "A" "B" "E" "S" "A" "B" "V" "T")
  ("P" "U" "G" "I" "L" "A" "T" "O" "Y" "E" "K" "C" "O" "H" "E")
  ("S" "J" "J" "G" "I" "N" "N" "A" "S" "T" "I" "C" "A" "Q" "O")))

Lista delle parole da cercare:

(setq lista-parole '("ARRAMPICATA" "ATLETICA" "BASEBALL"
                     "CALCIO" "CANOA" "CORSE" "DANZA"
                     "FRECCETTE" "GINNASTICA" "GOLF"
                     "HOCKEY" "JOGGING" "JUDO" "NUOTO"
                     "OLIMPIADI" "PALLACANESTRO"
                     "PESCA" "PUGILATO" "SCI" "STRETCHING"
                     "TENNIS" "TIRO" "ARCO"
                     "TREKKING" "VOLLEY" "YOGA"))

Le parole possono trovarsi in orizzontale o in verticale o in diagonale, inoltre possono essere scritte al contrario.

Funzione per contornare la matrice di caratteri con un carattere speciale che ci serve per delimitare la ricerca:

(define (pad-matrix mtx pad val)
  (local (row col out)
    (setq out '())
    (if (array? mtx) (setq mtx (array-list mtx)))
    (setq row (+ (* 2 pad) (length mtx)))
    (setq col (+ (* 2 pad) (length (mtx 0))))
    ; aggiunge pad righe iniziali ad out
    (for (i 1 pad)
      (push (dup val col true) out -1)
    )
    ; aggiunge le righe centrali ad out
    (dolist (el mtx)
      (setq cur (append (dup val pad true) el (dup val pad true)))
      (push cur out -1)
    )
    ; aggiunge pad righe finali ad out
    (for (i 1 pad)
      (push (dup val col true) out -1)
    )
    out))

Funzione che cerca tutte le parole:

(define (cercaparole matrice parole)
  (local (word matrix word-list row col err out)
    (setq matrix (pad-matrix matrice 1 "#"))
    (dolist (parola parole)
      (find-word parola)
    )
    (list out err)))

Funzione che cerca una parola:

(define (find-word word)
  (setq stop nil)
  (setq row (length matrix))
  (setq col (length (matrix 0)))
  (setq word-list (explode word))
  (for (i 0 (- row 1) 1 stop)
    (for (j 0 (- col 1) 1 stop)
      (cond ((find-nord)      (push (list word i j "N") out -1)  (setq stop true))
            ((find-sud)       (push (list word i j "S") out -1)  (setq stop true))
            ((find-est)       (push (list word i j "E") out -1)  (setq stop true))
            ((find-ovest)     (push (list word i j "O") out -1)  (setq stop true))
            ((find-nordest)   (push (list word i j "NE") out -1) (setq stop true))
            ((find-nordovest) (push (list word i j "NO") out -1) (setq stop true))
            ((find-sudest)    (push (list word i j "SE") out -1) (setq stop true))
            ((find-sudovest)  (push (list word i j "SO") out -1) (setq stop true))
      )
    )
  )
  (if (= stop nil) (push (list word -1) err -1)))

(define (find-nord)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (-- r))
      )
    )
    true)))
(define (find-sud)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (++ r))
      )
    )
    true)))
(define (find-est)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (++ c))
      )
    )
    true)))
(define (find-ovest)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (-- c))
      )
    )
    true)))
(define (find-nordest)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (++ c) (-- r))
      )
    )
    true)))
(define (find-nordovest)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (-- c) (-- r))
      )
    )
    true)))
(define (find-sudest)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (++ c) (++ r))
      )
    )
    true)))
(define (find-sudovest)
(catch
  (let ((r i) (c j))
    (dolist (ch word-list)
      (cond ((= (matrix r c) "#") (throw nil))
            ((!= ch (matrix r c)) (throw nil))
            (true (-- c) (++ r))
      )
    )
    true)))

Il risultato è una lista con elementi del tipo:

a) ("parola" riga colonna direzione) per le parole trovate
b) ("parola" -1) per le parole non trovate

Proviamo la funzione con l'esempio riportato prima:

(cercaparole matrice lista-parole)
;-> ((("ARRAMPICATA" 11 14 "N") ("ATLETICA" 6 12 "SO")
;->   ("BASEBALL" 13 13 "O") ("CALCIO" 1 13 "S")
;->   ("CANOA" 1 8 "E") ("CORSE" 3 2 "S")
;->   ("DANZA" 9 4 "SE") ("FRECCETTE" 6 15 "S")
;->   ("GINNASTICA" 15 4 "E") ("GOLF" 2 12 "SO")
;->   ("HOCKEY" 14 14 "O") ("JOGGING" 1 4 "SE")
;->   ("JUDO" 9 6 "O") ("NUOTO" 5 3 "NE")
;->   ("OLIMPIADI" 2 3 "SE") ("PALLACANESTRO" 8 13 "O")
;->   ("PESCA" 7 1 "N") ("PUGILATO" 14 1 "E")
;->   ("SCI" 11 2 "N") ("STRETCHING" 13 3 "NE")
;->   ("TENNIS" 3 9 "SO") ("TIRO" 12 11 "NO")
;->   ("ARCO" 5 4 "NO") ("TREKKING" 9 1 "NE")
;->   ("VOLLEY" 6 11 "NO") ("YOGA" 12 14 "NO"))
;->   nil)

Proviamo la funzione con un cercaparole in inglese:

(setq matrice
      '(("R" "E" "S" "O" "C" "C" "C" "I" "N" "S" "T" "U" "H" "H" "N")
        ("F" "M" "F" "E" "H" "O" "A" "I" "R" "F" "M" "S" "D" "O" "T")
        ("R" "I" "O" "M" "C" "C" "U" "R" "L" "Y" "H" "A" "E" "S" "E")
        ("N" "T" "H" "I" "L" "I" "A" "R" "R" "R" "B" "C" "E" "G" "C")
        ("Y" "H" "S" "O" "A" "O" "P" "N" "G" "O" "A" "J" "T" "T" "U")
        ("P" "O" "T" "A" "T" "O" "E" "S" "I" "E" "T" "G" "I" "T" "T")
        ("F" "V" "Y" "O" "C" "A" "R" "O" "R" "P" "T" "P" "O" "R" "T")
        ("G" "P" "F" "R" "U" "E" "I" "R" "D" "M" "S" "T" "E" "S" "E")
        ("E" "T" "T" "C" "A" "U" "L" "I" "F" "L" "O" "W" "E" "R" "L")
        ("I" "S" "O" "E" "E" "M" "L" "T" "U" "A" "I" "O" "L" "T" "S")
        ("O" "I" "T" "A" "E" "G" "E" "T" "B" "A" "N" "E" "T" "S" "E")
        ("E" "T" "O" "O" "T" "O" "N" "S" "D" "I" "N" "D" "A" "E" "A")
        ("T" "N" "A" "L" "P" "G" "G" "E" "O" "N" "R" "L" "A" "H" "D")
        ("E" "T" "N" "E" "T" "U" "N" "N" "E" "R" "A" "H" "R" "F" "O")
        ("A" "E" "C" "E" "O" "S" "P" "F" "H" "D" "O" "N" "O" "M" "R")))

(setq lista-parole '("CAULIFLOWER" "CARROT" "COURGETTE" "BAD"
                     "EGGPLANT" "FENNEL" "GARLIC" "LETTUCE"
                     "PIETRA" "ONION" "POTATOES" "ROSEMARY"
                     "SALAD" "SPICES" "SPINACH"))

(cercaparole matrice lista-parole)
;-> ((("CAULIFLOWER" 9 4 "E") ("CARROT" 1 6 "SE")
;->   ("COURGETTE" 1 5 "SE") ("BAD" 4 11"NE")
;->   ("EGGPLANT" 13 8 "O") ("FENNEL" 15 8 "NE")
;->   ("GARLIC" 6 12 "NO") ("LETTUCE" 9 15 "N")
;->   ("ONION" 10 12 "SO") ("POTATOES" 6 1 "E")
;->   ("ROSEMARY" 14 10 "NO") ("SALAD" 11 14 "SO")
;->   ("SPICES" 6 8 "NO") ("SPINACH" 8 11 "NO"))
;->  (("PIETRA" -1)))


-------------------------
Generare frazioni proprie
-------------------------

Vediamo come generare tutte le frazioni proprie fino ad un certo denominatore.
Le frazioni proprie sono, per definizione, frazioni in cui il numeratore è minore (più piccolo) del denominatore (cioè sono frazioni con valore minore di 1).

Partiamo con la seguente funzione:

(define (genera n)
  (local (out)
    (setq out '())
    (for (a 1 n)
      (for (b (+ a 1) n)
        ;(println a "/" b)
        (push (list (string (div a b)) (string a "/" b)) out -1)
      )
    )
    ; gli ultimi due elementi non sono validi:
    ; n/n non è una frazione propria
    ; n/(n + 1) ha il denominatore maggiore di n
    (chop out 2)))

(genera 5)
;-> (("0.5" "1/2")
;->  ("0.3333333333333333" "1/3")
;->  ("0.25" "1/4")
;->  ("0.2" "1/5")
;->  ("0.6666666666666666" "2/3")
;->  ("0.5" "2/4")
;->  ("0.4" "2/5")
;->  ("0.75" "3/4")
;->  ("0.6" "3/5")
;->  ("0.8" "4/5"))

Ci sono elementi doppi ("0.5" "1/2") e ("0.5" "2/4") e la lista non è ordinata per valore della frazione.

Per eliminare gli elementi doppi inserriamo la lista in una hash-map. Quando assegniamo una lista ad una hash-map gli elementi multipli (con la stessa chiave) vengono presi solo una volta. In newLISP la hash-map inserisce gli elementi partendo dal fondo della lista (poi nella hash-map gli elementi sono ordinati in base alla chiave). Quindi quando incontra elementi multipli prende l'ultimo che compare nella lista (cioè il primo partendo dal fondo della lista). Qiindi prima dobbiamo ordinare la lista in modo da mantenere la frazione che è ai minimi termini (cioè vogliamo mantenere la frazione 1/2 e non 2/4).

Generiamo e ordiniamo la lista in ordine decrescente:

(setq lst (sort (genera 5) >))
;-> (("0.8" "4/5") 
;->  ("0.75" "3/4") 
;->  ("0.6666666666666666" "2/3") 
;->  ("0.6" "3/5") 
;->  ("0.5" "2/4")
;->  ("0.5" "1/2")
;->  ("0.4" "2/5")
;->  ("0.3333333333333333" "1/3")
;->  ("0.25" "1/4")
;->  ("0.2" "1/5"))

E poi la inseriamo in una hash-map:

(new Tree 'hash)
(hash lst)
;-> hash

(hash)
;-> (("0.2" "1/5") 
;->  ("0.25" "1/4") 
;->  ("0.3333333333333333" "1/3") 
;->  ("0.4" "2/5") 
;->  ("0.5" "1/2")
;->  ("0.6" "3/5")
;->  ("0.6666666666666666" "2/3")
;->  ("0.75" "3/4")
;->  ("0.8" "4/5"))

Adesso copiamo la hash-map in una lista:

(setq lst (hash))
;-> (("0.2" "1/5") 
;->  ("0.25" "1/4") 
;->  ("0.3333333333333333" "1/3") 
;->  ("0.4" "2/5") 
;->  ("0.5" "1/2")
;->  ("0.6" "3/5")
;->  ("0.6666666666666666" "2/3")
;->  ("0.75" "3/4")
;->  ("0.8" "4/5"))

E cancelliamo la hash-map:

(delete 'hash)
;-> true

Adesso possiamo ricercare una frazione nella lista nel modo seguente:

(find "3/5" lst (fn(x y) (= x (last y))))
;-> 5

(lst 5)
;-> (0.6 "3/5")

Scriviamo la funzione finale:

(define (genera-frazioni-proprie n)
  (local (out)
    (setq out '())
    (for (a 1 n)
      (for (b (+ a 1) n)
        ;(println a "/" b)
        (push (list (string (div a b)) (string a "/" b)) out -1)
      )
    )
    ; gli ultimi due elementi non sono validi:
    ; n/n non è una frazione propria
    ; n/(n + 1) ha il denominatore maggiore di n
    (setq out (sort (chop out 2) >))
    (new Tree 'hash)
    (hash out)
    (setq out (hash))
    (delete 'hash)
    out))

(genera-frazioni-proprie 20)
;-> (("0.1" "1/10")
;->  ("0.1111111111111111" "1/9")
;->  ("0.125" "1/8")
;->  ("0.1428571428571429" "1/7")
;->  ("0.1666666666666667" "1/6")
;->  ("0.2" "1/5")
;->  ("0.2222222222222222" "2/9")
;->  ("0.25" "1/4")
;->  ("0.2857142857142857" "2/7")
;->  ("0.3" "3/10")
;->  ("0.3333333333333333" "1/3")
;->  ("0.375" "3/8")
;->  ("0.4" "2/5")
;->  ("0.4285714285714286" "3/7")
;->  ("0.4444444444444444" "4/9")
;->  ("0.5" "1/2")
;->  ("0.5555555555555556" "5/9")
;->  ("0.5714285714285714" "4/7")
;->  ("0.6" "3/5")
;->  ("0.625" "5/8")
;->  ("0.6666666666666666" "2/3")
;->  ("0.7" "7/10")
;->  ("0.7142857142857143" "5/7")
;->  ("0.75" "3/4")
;->  ("0.7777777777777778" "7/9")
;->  ("0.8" "4/5")
;->  ("0.8333333333333334" "5/6")
;->  ("0.8571428571428571" "6/7")
;->  ("0.875" "7/8")
;->  ("0.8888888888888888" "8/9")
;->  ("0.9" "9/10"))


