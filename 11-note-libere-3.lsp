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
Le funzioni "dup1?" e "dup2?" non richiedono spazio aggiuntivo in memoria, quindi la complessità spaziale vale O(1).
La funzione "dup3?" richiede una hash-map con n valori, quindi la complessità spaziale vale O(n).
La funzione "dup4?" richiede una hash-map con n valori per n volte (perchè ogni volta creiamo una hash-map diversa), quindi la complessità spaziale vale O(n^2).
Presumiamo che le funzioni "dup5?" e "dup6?" abbiano una complessità spaziale O(log(n)) (questa è la complessità spaziale dell'algoritmo di ordinamento Quicksort).

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

La soluzione più semplice è quella di utilizzare due cicli che attraversano le liste e verificare se scambiando gli elementi correnti si ottengono due somme uguali per le liste.

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

Infatti, ci sono (2^n - 1) partite tra tutte le coppie e ci sono binom(2^n, 2) coppie di giocatori.

(define (chess n)
  (let (k (length (factor n)))
    (div (pow 2 (- k 1)))))

(chess 32)
;-> 0.0625

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

Per i numeri primi non esiste alcuna fattorizzazione:

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
    (setq dist (array num-nodi (list maxval)))
    (setq pred (array num-nodi '(nil)))
    (setf (dist start) 0)
    (for (i 1 (- num-nodi 1))
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
    (for (nodo 0 (- num-nodi 1))
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

(bf graph 0 7)
;-> da: 0 a: 0 = (nil)
;-> da: 0 a: 1 = (0 3 2 1)
;-> da: 0 a: 2 = (0 3 2)
;-> da: 0 a: 3 = (0 3)
;-> da: 0 a: 4 = (0 3 2 4)
;-> da: 0 a: 5 = (0 3 2 4 5)
;-> da: 0 a: 6 = (0 3 6)
;-> ((0 30 20 10 30 50 20) (nil 2 3 0 2 4 3))

(bf graph 1 7)
;-> da: 1 a: 0 = (1 0)
;-> da: 1 a: 1 = (nil)
;-> da: 1 a: 2 = (1 0 3 2)
;-> da: 1 a: 3 = (1 0 3)
;-> da: 1 a: 4 = (1 5 4)
;-> da: 1 a: 5 = (1 5)
;-> da: 1 a: 6 = (1 0 3 6)
;-> ((50 0 70 60 60 40 70) (1 nil 3 0 5 1 3))

(bf graph 4 7)
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

Esempio:
(setq b '((0)))
(for (i 1 42)
  (setq b (pad-matrix b 1 i))
)
(device (open "matrix42.txt" "write"))
(print-matrix b)
(close (device))

----------------------------------------------------
Stringa decimale infinita 12345678910111213141516...
----------------------------------------------------

La stringa decimale infinita viene creata unendo tutti i numeri naturali da 1 a infinito (∞):

"123456789101112131415161718192021222324252627282930..."

Poichè non è possibile memorizzarla interamente in una struttura dati, diventa interessante la soluzione di due problemi:

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
Quindi la usiamo per scrivere la nuova funzione "(trova-num k)" che trova il numero corrente della stringa infinita all'indice k.

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

Per eliminare gli elementi doppi inseriamo la lista in una hash-map. Quando assegniamo una lista ad una hash-map gli elementi multipli (con la stessa chiave) vengono presi solo una volta. In newLISP la hash-map inserisce gli elementi partendo dal fondo della lista (poi nella hash-map gli elementi sono ordinati in base alla chiave). Quindi quando incontra elementi multipli prende l'ultimo che compare nella lista (cioè il primo partendo dal fondo della lista). Quindi prima dobbiamo ordinare la lista in modo da mantenere la frazione che è ai minimi termini (cioè vogliamo mantenere la frazione 1/2 e non 2/4).

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


-----------------
Somma di quadrati
-----------------

Dato un numero intero non negativo c, determinare se esistono due numeri interi a e b tali che a^2 + b^2 = c.

Per la teoria: "On numbers which are the sum of two squares" Leonhard Euler

Conviene cercare a^2 = c - b^2. Con un ciclo per "a" che va da 0 a int(sqrt c) inseriamo il valore a^2 in una hash-map e verifichiamo se nella hash-map esiste il valore b^2 = (c - a^2), in questo caso inseriamo la coppia di valori nella lista delle soluzioni.

(define (sommaquad c)
  (local (a b2 out)
    (setq out '())
    (new Tree 'hash)
    (for (a 0 (int (sqrt c)))
      (hash (string (* a a)) (* a a))
      (setq b2 (- c (* a a)))
      (if (hash (string b2))
          (push (list a (sqrt b2)) out -1)
      )
    )
    (delete 'hash)
    out))

(sommaquad 16)
;-> ((4 0))

(sommaquad 25)
;-> ((4 3) (5 0))

(sommaquad 50)
;-> ((5 5) (7 1))

Vediamo quanti numeri esistono fino a 10000 che hanno più di 5 scomposizioni come somma di quadrati:

(for (i 1 10000)
  (if (> (length (sommaquad i)) 5)
      (println i": " (sommaquad i))))

;-> 5525: ((55 50) (62 41) (70 25) (71 22) (73 14) (74 7))
;-> 9425: ((73 64) (80 55) (88 41) (92 31) (95 20) (97 4))

Scriviamo una funzione cha calcola il numero che ha più scomposizioni fino ad un determinato numero.

(define (sommaquad-max num)
  (local (a b2 tot max-tot out)
    (setq max-tot -1)
    (for (c 1 num)
        (setq tot 0)
        (new Tree 'hash)
        (for (a 0 (int (sqrt c)))
          (hash (string (* a a)) (* a a))
          (setq b2 (- c (* a a)))
          (if (hash (string b2)) (++ tot))
        )
        (delete 'hash)
        (if (> tot max-tot)
            (setq max-tot tot out c)
        )
    )
    (list out max-tot)))

Vediamo nei primi 10000 numeri:

(sommaquad-max 10000)
;-> (5525 6)
(time (sommaquad-max 10000))
;-> 842.939

Vediamo nei primi 100000 numeri:

(sommaquad-max 100000)
;-> (71825 9)
(time (sommaquad-max 100000))
;-> 26785.705
(sommaquad 71825)
;-> ((191 188) (208 169) (215 160) (236 127) (247 104)
;->  (257 76) (260 65) (265 40) (268 1))


-----------------------
Somma di cubi (Taxicab)
-----------------------

Dato un numero intero non negativo c, determinare se esistono due numeri interi a e b tali che a^3 + b^3 = c.
I numeri che si possono esprimere come somma di due cubi in più di un modo diverso vengono chiamati numeri Taxicab.

(define (sommacubi c)
  (local (a b3 out)
    (setq out '())
    (new Tree 'hash)
    (for (a 0 (int (pow c (div 3))))
      (hash (string (* a a a)) (* a a a))
      (setq b3 (- c (* a a a)))
      (if (hash (string b3))
          (push (list a (round (pow b3 (div 3)) -4)) out -1)
      )
    )
    (delete 'hash)
    out))

Proviamo con 1729, il numero di Ramanujan:

(sommacubi 1729)
;-> ((10 9) (12 1))

(+ (* 10 10 10) (* 9 9 9))
;-> 1729
(+ (* 12 12 12) (* 1 1 1))
;-> 1729

Vediamo quanti numeri esistono fino a 10000 che hanno più di una scomposizione come somma di cubi:

(for (i 1 10000)
  (if (> (length (sommacubi i)) 1)
      (println i": " (sommacubi i))))

;-> 1729: ((10 9) (12 1))
;-> 4104: ((15 9) (16 2))

Scriviamo una funzione cha calcola tutti i numeri Taxicab (con le relative scomposizioni) fino ad un determinato numero:

(define (taxicab num)
  (local (a b3 lst out)
    (setq out '())
    (for (c 1 num)
      (setq lst '())
      (new Tree 'hash)
      (for (a 0 (int (pow c (div 3))))
        (hash (string (* a a a)) (* a a a))
        (setq b3 (- c (* a a a)))
        (if (hash (string b3))
            (push (list a (round (pow b3 (div 3)) -4)) lst -1)
        )
      )
      (delete 'hash)
      (if (> (length lst) 1) (push (list c lst) out -1))
    )
    out))

(taxicab 10000)
;-> ((1729 ((10 9) (12 1))) (4104 ((15 9) (16 2))))

Vediamo quanti numeri taxicab ci sono fino a 100000:

(length (taxicab 100000))
;-> 10

Vediamo quali numeri taxicab ci sono fino a 1 milione:

(time (setq tx (taxicab 1000000)))
;-> 96643.946 ; 96 secondi

tx
;-> ((1729 ((10 9) (12 1)))
;->  (4104 ((15 9) (16 2)))
;->  (13832 ((20 18) (24 2)))
;->  (20683 ((24 19) (27 10)))
;->  (32832 ((30 18) (32 4)))
;->  (39312 ((33 15) (34 2)))
;->  (40033 ((33 16) (34 9)))
;->  (46683 ((30 27) (36 3)))
;->  (64232 ((36 26) (39 17)))
;->  (65728 ((33 31) (40 12)))
;->  (110656 ((40 36) (48 4)))
;->  (110808 ((45 27) (48 6)))
;->  (134379 ((43 38) (51 12)))
;->  (149389 ((50 29) (53 8)))
;->  (165464 ((48 38) (54 20)))
;->  (171288 ((54 24) (55 17)))
;->  (195841 ((57 22) (58 9)))
;->  (216027 ((59 22) (60 3)))
;->  (216125 ((50 45) (60 5)))
;->  (262656 ((60 36) (64 8)))
;->  (314496 ((66 30) (68 4)))
;->  (320264 ((66 32) (68 18)))
;->  (327763 ((58 51) (67 30)))
;->  (373464 ((60 54) (72 6)))
;->  (402597 ((61 56) (69 42)))
;->  (439101 ((69 48) (76 5)))
;->  (443889 ((73 38) (76 17)))
;->  (513000 ((75 45) (80 10)))
;->  (513856 ((72 52) (78 34)))
;->  (515375 ((71 54) (80 15)))
;->  (525824 ((66 62) (80 24)))
;->  (558441 ((72 57) (81 30)))
;->  (593047 ((70 63) (84 7)))
;->  (684019 ((75 64) (82 51)))
;->  (704977 ((86 41) (89 2)))
;->  (805688 ((92 30) (93 11)))
;->  (842751 ((84 63) (94 23)))
;->  (885248 ((80 72) (96 8)))
;->  (886464 ((90 54) (96 12)))
;->  (920673 ((96 33) (97 20)))
;->  (955016 ((89 63) (98 24)))
;->  (984067 ((92 59) (98 35)))
;->  (994688 ((92 60) (99 29))))

(length tx)
;-> 43


---------------------------
Somma numeri dispari (pari)
---------------------------

Dati due numeri a e b (con a < b) determinare la somma dei numeri dispari compresi nell'intervallo tra a e b (a e b inclusi, se sono dispari).

Vediamo la soluzione più semplice:

(define (sommadispari1 a b)
  (let (somma 0)
    ; per ogni numero tra a e b
    (for (i a b)
      ; se è dispari lo aggiungiamo ala somma
      (if (odd? i) (++ somma i))
    )
    somma))

(sommadispari1 1 10)
;-> 25
(sommadispari1 11 20)
;-> 75

La seconda soluzione utilizza il fatto che i numeri dispari distano di 2:

numero_dispari(n+1) = numero_dispari(n) + 2

(define (sommadispari2 a b)
  (let (somma 0)
    ; se a è pari, allora il primo
    ; numero dispari vale (a + 1)
    (if (even? a) (++ a))
    ; per ogni numero tra a e b con passo 2
    (for (i a b 2)
      ; aggiungiamo alla somma il numero
      (++ somma i)
    )
    somma))

(sommadispari2 1 10)
;-> 25
(sommadispari2 11 20)
;-> 75

Una versione simile alla precedente che usa le primitive di newLISP:

(define (sommadispari3 a b)
    ; se a è pari, allora il primo
    ; numero dispari vale (a + 1)
    (if (even? a) (++ a))
    ; se b è pari, allora l'ultimo
    ; numero dispari vale (b - 1)
    (if (even? b) (-- b))
    ; somma i valori della sequenza
    (apply + (sequence a b 2))
)

(sommadispari3 1 10)
;-> 25
(sommadispari3 11 20)
;-> 75

L'ultima soluzione utilizza il fatto che i numeri dispari sono in progressione aritmetica. Una progressione aritmetica è una successione di numeri tali che la differenza tra ciascun termine della successione e il suo precedente sia una costante. Tale costante viene detta ragione della progressione. Per esempio, la successione dei numeri dispari 3, 5, 7, 9, 11, ... è una progressione aritmetica di ragione 2.
La somma dei numeri di una progressione aritmetica finita si chiama serie aritmetica. La somma S dei primi n valori di una progressione aritmetica è uguale a:

            (a1 + an)
S(n) = n * -----------
                2
dove a1 è il primo termine della serie e an è l'n-esimo (ultimo) termine della serie.

(define (sommadispari4 a b)
  (let (n 0)
    ; se a è pari, allora il primo
    ; numero dispari vale (a + 1)
    (if (even? a) (++ a))
    ; se b è pari, allora l'ultimo
    ; numero dispari vale (b - 1)
    (if (even? b) (-- b))
    ; calcolo di n: numero dei valori dispari
    (setq n (/ (+ (- b a) 2) 2))
    ; calcoliamo la somma con la formula
    (/ (* n (+ a b)) 2)))

(sommadispari4 1 10)
;-> 25
(sommadispari4 11 20)
;-> 75

Test per verificare la correttezza:

(= (sommadispari1 2000 2345678)
   (sommadispari2 2000 2345678)
   (sommadispari3 2000 2345678)
   (sommadispari4 2000 2345678))
;-> true

Vediamo i tempi di esecuzione:

(time (sommadispari1 1234 123456789))
;-> 5062.233
(time (sommadispari1 1234 123456789) 10)
;-> 51041.947
(time (sommadispari2 1234 123456789))
;-> 2039.792
(time (sommadispari2 1234 123456789) 10)
;-> 20435.561
(time (sommadispari3 1234 123456789))
;-> 1938.445
(time (sommadispari3 1234 123456789) 10)
;-> 12659.818
(time (sommadispari4 1234 123456789))
;-> 0
(time (sommadispari4 1234 123456789) 10)
;-> 0
(time (sommadispari4 1234 123456789) 100000)
;-> 33.091

L'ultima funzione è la più veloce perchè non effettua alcun ciclo attraverso i numeri.

Possiamo anche scrivere una funzione che somma i numeri pari:

(define (sommapari a b)
  (let (n 0)
    ; se a è dispari, allora il primo
    ; numero pari vale (a + 1)
    (if (odd? a) (++ a))
    ; se b è dispari, allora l'ultimo
    ; numero pari vale (b - 1)
    (if (odd? b) (-- b))
    ; calcolo di n: numero dei valori pari
    (setq n (/ (+ (- b a) 2) 2))
    ; calcoliamo la somma con la formula
    (/ (* n (+ a b)) 2)))

(sommapari 3 9)
;-> 18
(sommapari 2 10)
;-> 30

Nota: la somma dei primi n numeri dispari è sempre un quadrato. Infatti la figura seguente mostra che:

1 + 3 =          4   (2 quadrati x 2 quadrati)
1 + 3 + 5 =      9   (3 quadrati x 3 quadrati)
1 + 3 + 5 + 7 = 16   (4 quadrati x 4 quadrati)
...

       +-----+-----+-----+-----+
       |  1  |  3  |  5  |  7  |
       |     |     |     |     |
       +-----+-----+-----+-----+
       |  3  |  3  |  5  |  7  |
       |     |     |     |     |
       +-----+-----+-----+-----+
       |  5  |  5  |  5  |  7  |
       |     |     |     |     |
       +-----+-----+-----+-----+
       |  7  |  7  |  7  |  7  |
       |     |     |     |     |
       +-----+-----+-----+-----+


------------
Cavo sospeso
------------

In molte applicazioni pratiche è necessario determinare il rapporto tra la lunghezza di un cavo appeso a due pali verticali, l'altezza dei pali e la minima distanza tra il cavo e il suolo (ad esempio nella posa di cavi elettrici o telefonici).

Per la teoria completa vedere il seguente articolo:
"The hanging cable problem for practical applications"
di Neil Chatterjee e Bogdan G. Nita

Un cavo perfettamente flessibile e inestensibile di densità e sezione trasversale uniformi appeso liberamente a due pali assume la forma di una catenaria. L'equazione di una catenaria in coordinate cartesiane è la seguente:

  y = a*cosh(x/a)

dove cosh è la funzione del coseno iperbolico.

Il fattore di scala "a" viene solitamente interpretato come il rapporto tra la componente orizzontale della tensione sul cavo e il peso del cavo per unità di lunghezza. Per un dato valore del parametro "a" la forma della catenaria è nota. Tuttavia nei problemi pratici "a" è sconosciuto e dipende dalla distanza tra i poli da cui pende il cavo.

Quando la catenaria è tangente all'asse x (il suolo) dobbiamo sottrarre "a" all'equazione sopra:

  y = a*cosh(x/a) - a

Primo caso: pali di altezza uguale
----------------------------------
Supponiamo che la lunghezza del cavo sia 120 m e i due pali hanno la stessa altezza di 50 m. Assumiamo anche che ogni polo si trovi alla distanza x dal punto medio che si presume sia l'asse y.
Calcolare la distanza tra i pali (2x) affinchè il cavo sia tangente al suolo.

                  asse y
                    |
     |.             |             .|
     | .            |            . |
     |  .           |        60 .  |
     |   .          |          .   | 50
     |     .        |        .     |
     |       .      |      .       |
     |           .  |  .           |
   -----------------|------------------ asse x

                  asse y
                    |
     |.             |             .|
     | .            |            . |
     |  .           |           .  |
     |   .          |        y .   | z
     |     .        |        .     |
     |       .      |      .       |
     |           .  |  .           |
   -----------------|------------------ asse x
                            x
La costante "a" vale:

       y² - z²
  a = ---------
         2z

La distanza 2x vale:

  2x = 2*a*ln(y/a + sqrt((y/a)² + 1))

Sostituendo il valore di "a" otteniamo:

       (y² - z²)ln(2*y*z/(y² - z²) + sqrt(4*y²*z²/(y^4 - 2*y²*z² + z^4) + 1))
 2x = ------------------------------------------------------------------------
                                       z

Secondo caso: pali di altezza diversa
-------------------------------------
Adesso esaminiamo un problema simile, ma con pali di diverse altezze. Supponiamo che la lunghezza del cavo sia 140 m e che i due poli abbiano altezze di 50 m e 70 m (vedi Figura 3). Determinare la distanza minima tra i due poli in modo che il cavo sia tangente al suolo.

     |.
     | .             asse y
     |  .              |
     |   .             |             .|
  70 |    .  y2        |        y1  . |
     |     .           |           .  |
     |      .          |          .   | 50
     |        .        |        .     |
     |          .      |      .       |
     |              .  |  .           |
   --------------------|------------------ asse x
            x2                 x1

     |.
     | .             asse y
     |  .              |
     |   .             |             .|
  z2 |    .  y2        |        y1  . |
     |     .           |           .  |
     |      .          |          .   | z1
     |        .        |        .     |
     |          .      |      .       |
     |              .  |  .           |
   --------------------|------------------ asse x
            x2                 x1

  y1 + y2 = 140

Questa volta "a" vale:

       (z1 + z2)*[y² - (z1 - z2)²] -2*y*sqrt(z1*z2*[y² (z1 - z2)²])
  a = --------------------------------------------------------------
                              2*(z1 - z2)²

  y1 = sqrt(z1² + 2*z1*a)

  y2 = sqrt(z2² + 2*z2*a)

             z1 + y1 + a
  x1 = a*ln(-------------)
                  a

             z2 + y2 + a
  x2 = a*ln(-------------)
                a


------------------
Numeri automorfici
------------------

In matematica si dice numero automorfo o anche intero automorfo un intero positivo che nelle notazioni decimali ha il quadrato che presenta nella sua parte finale il numero stesso.
Esempi: 5^2 = 25, 76^2 = 5776, 890625^2 = 793212890625.

(define (automorfico? num)
(catch
  (let (quadrato (* num num))
    ; confronto delle cifre
    (while (> num 0)
      ; se le cifre di num e le ultime di quadrato non sono uguali
      ; allora num non è automorfico
      (if (!= (% num 10) (% quadrato 10))
          (throw nil))
      (setq num (/ num 10))
      (setq quadrato (/ quadrato 10))
    )
    true)))

(automorfico? 890625)
;-> true

Vediamo i numeri automorfici fino a 100 milioni:

(for (i 0 1e8) (if (automorfico? (bigint i)) (print i { })))
;-> 0 1 5 6 25 76 376 625 9376 90625 109376
;-> 890625 2890625 7109376 12890625 87109376


-----------------
Numeri trimorfici
-----------------

Un numero è chiamato numero trimorfico se e solo se il suo cubo termina con le stesse cifre del numero stesso. In altre parole, è trimorfico se il numero appare alla fine del suo cubo.

Esempi di numeri trimorfici:

5 --> 5*5*5 = 125

24 --> 24*24*24 = 13824

(define (trimorfico? num)
(catch
  (let (cubo (* num num num))
    ; confronto delle cifre
    (while (> num 0)
      ; se le cifre di num e le ultime di cubo non sono uguali
      ; allora num non è trimorfico
      (if (!= (% num 10) (% cubo 10))
          (throw nil))
      (setq num (/ num 10))
      (setq cubo (/ cubo 10))
    )
    true)))

(trimorfico? 534857623847562384756238745623L)
;-> true

(trimorfico? 24)
;-> true

Vediamo i numeri trimorfici fino a 100 milioni:

(for (i 0 1e8) (if (trimorfico? (bigint i)) (print i { })))
;-> 0 1 4 5 6 9 24 25 49 51 75 76 99 125 249 251 375 376 499 501
;-> 624 625 749 751 875 999 1249 3751 4375 4999 5001 5625 6249
;-> 8751 9375 9376 9999 18751 31249 40625 49999 50001 59375
;-> 68751 81249 90624 90625 99999 109375 109376 218751 281249
;-> 390625 499999 500001 609375 718751 781249 890624 890625
;-> 999999 2109375 2890624 2890625 4218751 4999999 5000001 5781249
;-> 7109375 7109376 7890625 9218751 9999999 12890624 12890625
;-> 24218751 25781249 37109375 49999999 50000001 62890625 74218751
;-> 75781249 87109375 87109376 99999999


----------------------
Funzioni come Stringhe
----------------------

Nel paragrafo "Funzioni come liste" abbiamo visto che in newLISP le funzioni sono delle liste particolari che cominciano con la parola-chiave "lambda":

(define (test a b) (+ a b))
;-> (lambda (a b) (+ a b))

Verifichiamo che "test" sia una lista e vediamo come è composta:

(list? test)
;-> true

(length test)
;-> 2

Il primo elemento è la lista degli argomenti della funzione/lista:

(nth 0 test)
;-> (a b)

Il secondo elemento è il corpo della funzione/lista:

(nth 1 test)
(+ a b)

Adesso mostriamo brevemente che una funzione può essere trasformata in una stringa, la quale può essere modificata e poi riconvertita in una funzione.

Per esempio, prendiamo la nostra funzione "test" e applichiamola a due numeri:

(test 5 3)
;-> 8

Adesso assegniamo la funzione "test" ad una stringa:

(setq fs (string test))
;-> "(lambda (a b) (+ a b))"

Troviamo la posizione del segno "+" e sostituiamolo con il segno "-":

(find "+" fs)
;-> 15

(setf (fs 15) "-")
;-> "-"

La stringa "fs" è diventata:

(println fs)
;-> (lambda (a b) (- a b))

Adesso possiamo utilizzare la funzione primitiva "eval-string", che valuta l'espressione contenuta in una stringa, per convertire la stringa "fs" in una nuova funzione:

(setq test2 (eval-string fs))
;-> (lambda (a b) (- a b))

Proviamo la nuova funzione:

(test2 5 3)
;-> 2

Quindi è possibile convertire una funzione in una stringa e viceversa.


---------------------
Assegnazione multipla
---------------------

Qualche volta abbiamo bisogno di assegnare i valori di una lista di ritorno di una funzione a delle variabili. Ad esempio, la seguente funzione restituisce un punto e vogliamo assegnare i valori alle variabili a e b:

(define (midpoint p1 p2)
  (let ((x (div (add (p1 0) (p2 0)) 2))
        (y (div (add (p1 1) (p2 1)) 2)))
    (list x y)))

(midpoint '(2 2) '(3 3))
;-> (2.5 2.5)

Per assegnare i valori di ritorno della funzione alle variabili a e b possiamo scrivere:

(setq lst (midpoint '(2 2) '(3 3)))
(setq a (lst 0))
;-> 2.5
(setq b (lst 1))
;-> 2.5

Oppure possiamo scrivere:

(map set '(c d) (midpoint '(2 2) '(3 3)))
c
;-> 2.5
d
;-> 2.5

Possiamo scrivere una macro che ci semplifica il lavoro (simile alla macro psetq):

(define-macro (msetq)
    ; Assegna ad ogni variabile di (args 0)
    ; la relativa variabile ottenuta dalla
    ; valutazione della funzione in (args 1)
    ; (cioè dei valori della lista ritornata dalla funzione)
    (dolist (_el (eval (args 1)))
      (set (args 0 $idx) (eval _el))))

Questa macro prende due argomenti:
1) <lst-var> la lista delle variabili che devono essere associate
2) <func> la funzione da valutare

Esempio:

(msetq (x y) (midpoint '(2 2) '(3 3)))

Adesso le variabili x e y hanno il valore 2.5 e 2.5:

(list x y)
;-> (2.5 2.5)

Possiamo assegnare qualunque valore di ritorno alle variabili (anche una funzione):

(define (test a b f) (list a (sin b) f))

(msetq (x y z) (test 3 4 'add))
;-> add@40D926

(list x y z)
;-> (3 -0.7568024953079282 add@40D926)

Adesso "z" si comporta come la funzione "add":

(z 1 2)
;-> 3

Vediamo i tempi di esecuzione dei tre metodi:

(define (t)
  (setq lst (midpoint '(2 2) '(3 3)))
  (setq a (lst 0) b (lst 1)))

(time t 1e8)
;-> 312.193

(define (t1)
  (map set '(c d) (midpoint '(2 2) '(3 3))))

(time t1 1e8)
;-> 310.305

(define (t2)
  (msetq (x y) (midpoint '(2 2) '(3 3))))

(time t2 1e8)
;-> 310.174

I tempi di esecuzione sono equivalenti.


-----------------
Doppio fattoriale
-----------------

Il doppio fattoriale o semifattoriale di un numero n, indicato con n‼, è il prodotto di tutti gli interi da 1 a n che hanno la stessa parità (pari o dispari) di n (sequenze A000165 e A001147 nell'OEIS).
Il doppio fattoriale non deve essere confuso con la funzione fattoriale ripetuta due volte (sequenza A000197 nell'OEIS), che è scritta come (n!)! e non n!!.

Il doppio fattoriale di un numero n vale:

n!!(0) = 1

n!! = Prod[k=0..(ceil(n/2) - 1)] (n - 2*k)

Oppure separando il caso pari e dispari:

Numeri pari:

n!! = Prod[k=1..(n/2)] (2*k)

Numeri dispari:

n!! = Prod[k=1..(n+1)/2)] (2*k - 1)

La sequenza dei doppi fattoriali per i numeri pari n = 0, 2, 4, 6, 8, ... inizia come:

1, 2, 8, 48, 384, 3840, 46080, 645120, ... (sequenza A000165 nell'OEIS)

La sequenza dei doppi fattoriali per dispari n = 1, 3, 5, 7, 9, ... inizia come:

1, 3, 15, 105, 945, 10395, 135135, ... (sequenza A001147 nell'OEIS)

(define (double-fact num)
  (let (df 1)
    (cond ((zero? num) (setq df 1))
          ((= 1 num) (setq df 1))
          ((even? num)
           (for (k 1 (/ num 2))
             (setq df (* df 2 k))))
          ((odd? num)
           (for (k 1 (/ (+ num 1) 2))
             (setq df (* df (- (* 2 k) 1)))))
    )
    df))

Numeri pari:
(map double-fact (sequence 0 14 2))
;-> (1 2 8 48 384 3840 46080 645120)

Numeri dispari:
(map double-fact (sequence 1 13 2))
;-> (1 3 15 105 945 10395 135135)


--------------
0.999999999...
--------------

In matematica il numero N = 0.999999999... (che può essere scritto come 0.(9)) vale 1.

Dimostrazione

1 = 1/3 + 2/3 =
  = 0.333333333... + 0.666666666... =
  = 0.999999999...

In newLISP:

(add (div 1 3) (div 2 3))
;-> 1

Un altro metodo di dimostrazione:

Moltiplichiamo N = 0.999999999... per 10 e poi lo sottraiamo al risultato della moltiplicazione:

10 * 0.999999999... = 9.999999999...

10*N = 9.999999999... -
   N = 0.999999999... =
-----------------------
       9

Cioè, 10*N - N = 9 ==> N = 1


-----------------------
Quadrati magici curiosi
-----------------------

Il quadrato magico Apocalittico
-------------------------------
Tutti i numeri del seguente quadrato magico sono primi e la somma delle righe, delle colonne, delle diagonali e delle diagonali spezzate vale 666 (il numero della Bestia). Le diagonali spezzate (di lunghezza 6) sono quelle che si ottengono piegando il quadrato su se stesso lungo le diagonali.

    3  107    5  131  109  311
    7  331  193   11   83   41
  103   53   71   89  151  199
  113   61   97  197  167   31
  367   13  173   59   17   37
   73  101  127  179  139   47

Diagonali spezzate:

(113 + 13 + 127) + (131 83 199) = 666

(5 + 331 + 103) + (31 + 17 + 179) = 666

Scriviamo una funzione per verificare la proprietà della somma lungo le righe, le colonne e le diagonali:

(define (checksum qm n somma)
  (local (ok srow scol)
    (setq ok true)
    ; controllo diagonali
    (setq srow 0 scol 0)
    (for (i 0 (- n 1))
      (setq srow (add srow (qm i i)))
      (setq scol (add scol (qm i (sub n i 1))))
    )
    (if (or (!= srow somma) (!= scol somma))
        (setq ok nil))
    ;controllo righe e colonne
    (for (i 0 (- n 1) 1 ok)
      (setq srow 0 scol 0)
      (for (j 0 (- n 1) 1 ok )
        (setq srow (add srow (qm i j)))
        (setq scol (add scol (qm j i)))
      )
      (if (or (!= srow somma) (!= scol somma))
          (setq ok nil)
      )
    )
    ok))

Verifichiamo:

(setq a '((  3   107     5   131   109   311)
          (  7   331   193    11    83    41)
          (103    53    71    89   151   199)
          (113    61    97   197   167    31)
          (367    13   173    59    17    37)
          ( 73   101   127   179   139    47)))

(checksum a 6 666)
;-> true

Adesso verifichiamo se i numeri del quadrato sono tutti primi:

(define (primi lst)
  (let (out true)
    (dolist (el (flat lst))
      (if (> (length (factor el)) 1)
        (setq out nil)))
    out))

(primi a)
;-> true

Il quadrato magico Specchio
---------------------------
Nel quadrato magico seguente la somma di ogni riga, di ogni colonna e di ogni diagonale vale 242.

  96 64 37 45
  39 43 98 62
  84 76 25 57
  23 59 82 78

(setq s '((96 64 37 45)
          (39 43 98 62)
          (84 76 25 57)
          (23 59 82 78)))

Verifichiamo:

(checksum s 4 242)
;-> true

Invertiamo le cifre di ogni numero del quadrato:

(define (mirror qm)
  (let (out '())
    (dolist (el qm)
      (push (map (fn(x) (int (reverse (string x)))) el) out -1))
    out))

(setq s1 (mirror s))
;-> ((69 46 73 54) (93 34 89 26) (48 67 52 75) (32 95 28 87))

Otteniamo un altro quadrato magico con la stesso valore della somma:

  69 46 73 54
  93 34 89 26
  48 67 52 75
  32 95 28 87

Verifichiamo:

(checksum s1 4 242)
;-> true

Il quadrato magico Kurchan
--------------------------

Un altro incredibile quadrato magico è quello di Kurchan (scoperto da Rodolfo Marcelo Kurchan, di Buenos Aires, Argentina). Si pensa che sia il più piccolo quadrato magico non banale con 16 numeri interi pandigitali distinti con la più piccola somma magica pandigitale (Pandigitale significa che tutte e dieci le cifre sono utilizzato e 0 non è la cifra iniziale). La somma pandigitale è 4.129.607.358:

  1037956284 1026857394 1036847295 1027946385
  1036947285 1027846395 1037856294 1026957384
  1027856394 1036957284 1026947385 1037846295
  1026847395 1037946285 1027956384 1036857294

Vediamo se esiste un modo per ricavarlo.

Calcoliamo tutte le permutazioni (numeri) delle cifre (0 1 2 3 4 5 6 7 8 9):

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
    out))

(silent (setq all (perm '(0 1 2 3 4 5 6 7 8 9))))

Prendiamo solo le permutazioni che passano il seguente filtro:

(define (filtro lst)
  (and (= (lst 0) 1)
       (= (lst 1) 0)
       (or (= (lst 2) 2) (= (lst 2) 3))
       (or (= (lst 3) 6) (= (lst 3) 7))
       (or (= (lst 4) 8) (= (lst 4) 9))
       (or (= (lst 5) 4) (= (lst 5) 5))
       (or (= (lst 6) 6) (= (lst 6) 7))
       (or (= (lst 7) 2) (= (lst 7) 3))
       (or (= (lst 8) 8) (= (lst 8) 9))
       (or (= (lst 9) 4) (= (lst 9) 5))))

(silent (setq nums (filter filtro all)))
(length nums)
;-> 16
(nums 10)
;-> (1 0 2 7 8 4 6 3 9 5)

Convertiamo gli elementi della lista delle permutazioni in una lista di numeri:

(define (lst-int lst)
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))))

(silent (setq numeri (map lst-int nums)))
(length numeri)
;-> 16
(nums 10)
;-> (1 0 2 7 8 4 6 3 9 5)
(numeri 10)
;-> 1027846395

In quanti modi possiamo disporre 16 numeri in una matrice 4x4?
Si tratta del numero di permutazioni, quindi vale: 16!

(define (fact-i num)
  (let (out 1L)
    (for (x 1L num)
      (setq out (* out x)))))

(fact-i 16)
;-> 20922789888000L

Non le possiamo calcolare tutte...

Allora ricaviamo il valore della somma del quadrato magico dividendo per 4 la somma di tutti i valori:

(setq kur '(1037956284
            1026857394
            1036847295
            1027946385
            1036947285
            1027846395
            1037856294
            1026957384
            1027856394
            1036957284
            1026947385
            1037846295
            1026847395
            1037946285
            1027956384
            1036857294))

(apply + kur)
;-> 16518429432

(setq somma (/ (apply + kur) 4))
;-> 4129607358 ; somma del quadrato magico

Quindi dobbiamo trovare 4 numeri che sommano al valore di "somma"

Una soluzione base per trovare tutte le combinazioni  di 4 elementi in una lista "lst" che hanno somma uguale a "sum":

(define (findsum4 lst sum)
  (local (len vet out)
    (setq len (length lst))
    (setq vet (array len lst))
    (setq out '())
    (for (i 0 (- len 4))
      (for (j (+ i 1) (- len 3))
        (for (k (+ j 1) (- len 2))
          (for (p (+ k 1) (- len 1))
            (if (= (+ (vet i) (vet j) (vet k) (vet p)) sum)
                (push (list (vet i) (vet j) (vet k) (vet p)) out -1))))))
    out))

(findsum4 '(10 2 3 4 5 9 7 8) 21)
;-> ((10 2 4 5) (2 3 9 7) (2 4 7 8) (3 4 5 9))

(setq quad (findsum4 kur somma))
(length quad)
;-> 52

52 quadruple di numeri da mettere in una matrice 4x4 con tutti i numeri diversi...

(binom 52 4)
;-> 270725L

Adesso possiamo calcolarle...

(define (comb k lst)
  (cond ((zero? k)   '(()))
        ((null? lst) '())
        (true
          (append (map (lambda (k-1) (cons (first lst) k-1))
                       (comb (- k 1) (rest lst)))
                  (comb k (rest lst))))))

(silent (setq matrici (comb 4 quad)))
(length matrici)
;-> 270725

Vediamo un elemento della lista "matrici" :

(matrici 0)
;-> ((1037956284 1026857394 1036847295 1027946385)
;->  (1037956284 1026857394 1036947285 1027846395)
;->  (1037956284 1026857394 1026947385 1037846295)
;->  (1037956284 1026857394 1026847395 1037946285))

Quindi dobbiamo controllare ogni elemento della lista "matrici" per verificare se è un quadrato magico.

(checksum (matrici 10) 4 somma)
;-> nil

La funzione "test" seleziona solo i qudrati magici:

(define (test)
  (local (out)
    (setq out '())
    (dolist (el matrici)
      (if (checksum el 4 somma)
          (begin
            (println el)
            (push el out -1)))
      (if (zero? (% $idx 10000)) (println $idx))
    )
    out))

(setq sol (test))
(length sol)
;-> 258

Vediamo una matrice:

(sol 10)
;-> ((1037956284 1026857394 1036847295 1027946385)
;->  (1026857394 1027846395 1036957284 1037946285)
;->  (1026857394 1037856294 1026947385 1037946285)
;->  (1026847395 1037946285 1027956384 1036857294))

Notiamo che ci sono numeri uguali, quindi il quadrato magico è triviale.

Eliminiamo tutte le matrici (quadrati magici) che hanno numeri uguali:

(define (unici lst)
  (= (unique (flat lst)) (flat lst)))

(setq qmagic (filter unici sol))
(length qmagic)
;-> 7

Vediamo se in questi 7 quadrati magici esiste quello di Kurchan:

(ref (explode kur 4) qmagic)
;-> (0)

Esiste e si trova all'indice 0:

(qmagic 0)
;-> ((1037956284 1026857394 1036847295 1027946385)
;->  (1036947285 1027846395 1037856294 1026957384)
;->  (1027856394 1036957284 1026947385 1037846295)
;->  (1026847395 1037946285 1027956384 1036857294))

Vediamone un altro:

(qmagic 1)
;-> ((1037956284 1026857394 1036947285 1027846395)
;->  (1036847295 1027946385 1037856294 1026957384)
;->  (1027856394 1036957284 1026847395 1037946285)
;->  (1026947385 1037846295 1027956384 1036857294))

Il quinto quadrato magico è la trasposta di quello di Kurchan:

(= (qmagic 0) (transpose (qmagic 4)))
;-> true

Adesso vediamo se esiste un quadrato magico simile con una somma pandigitale minore di quello di Kurchan.

Calcoliamo tutte le permutazioni (numeri) delle cifre (0 1 2 3 4 5 6 7 8 9):

(silent (setq all (perm '(0 1 2 3 4 5 6 7 8 9))))

Questa volta modifichiamo il filtro::

(define (filtro lst)
  (and (= (lst 0) 1)
       (= (lst 1) 0)
       (or (= (lst 2) 2) (= (lst 2) 3))
       (or (= (lst 3) 4) (= (lst 3) 5))
       (or (= (lst 4) 6) (= (lst 4) 7))
       (or (= (lst 5) 2) (= (lst 5) 3))
       (or (= (lst 6) 8) (= (lst 6) 9))
       (or (= (lst 7) 6) (= (lst 7) 7))
       (or (= (lst 8) 8) (= (lst 8) 9))
       (or (= (lst 9) 4) (= (lst 9) 5))))

(silent (setq nums (filter filtro all)))
(length nums)
;-> 16
(nums 10)
;-> (1 0 3 4 7 2 8 6 9 5)

Convertiamo gli elementi della lista delle permutazioni in una lista di numeri:

(silent (setq numeri (map lst-int nums)))
(length numeri)
;-> 16
(nums 10)
;-> (1 0 3 4 7 2 8 6 9 5)
(numeri 10)
;-> 1034728695

Ricaviamo il valore della somma del quadrato magico dividendo per 4 la somma di tutti i valori:

(setq somma (div (apply + numeri) 4))
;-> 4120736958

La somma è pentadigitale...andiamo avanti.

Quindi dobbiamo trovare 4 numeri che sommano al valore di "somma"

(findsum4 '(10 2 3 4 5 9 7 8) 21)
;-> ((10 2 4 5) (2 3 9 7) (2 4 7 8) (3 4 5 9))

(setq quad (findsum4 numeri somma))
(length quad)
;-> 52

52 quadruple di numeri da mettere in una matrice 4x4 con tutti i numeri diversi...

(binom 52 4)
;-> 270725L

Adesso possiamo calcolarle...

(silent (setq matrici (comb 4 quad)))
(length matrici)
;-> 270725

Vediamo un elemento della lista "matrici" :

(matrici 0)
;-> ((1035629784 1025639784 1034728695 1024738695)
;->  (1035629784 1035729684 1024638795 1024738695)
;->  (1035629784 1025739684 1034628795 1024738695)
;->  (1035629784 1025739684 1024638795 1034728695))

Quindi dobbiamo controllare ogni elemento della lista "matrici" per verificare se è un quadrato magico.

(checksum (matrici 10) 4 somma)
;-> nil

La funzione "test" seleziona solo i qudrati magici:

(define (test)
  (local (out)
    (setq out '())
    (dolist (el matrici)
      (if (checksum el 4 somma)
          (begin
            (println el)
            (push el out -1)))
      (if (zero? (% $idx 10000)) (println $idx))
    )
    out))

(setq sol (test))
(length sol)
;-> 1082

Vediamo una matrice:

(sol 10)
;-> ((1035629784 1035729684 1024638795 1024738695)
;->  (1035629784 1025738694 1034628795 1024739685)
;->  (1025639784 1035729684 1024638795 1034728695)
;->  (1025639784 1035728694 1024638795 1034729685))

Notiamo che ci sono numeri uguali, quindi il quadrato magico è triviale.

Eliminiamo tutte le matrici (quadrati magici) che hanno numeri uguali:

(define (unici lst)
  (= (unique (flat lst)) (flat lst)))

(setq qmagic (filter unici sol))
(length qmagic)
;-> 5

(qmagic 0)
;-> ((1035629784 1035728694 1024638795 1024739685)
;->  (1025639784 1025738694 1034628795 1034729685)
;->  (1035729684 1035628794 1024738695 1024639785)
;->  (1025739684 1025638794 1034728695 1034629785))

(checksum (qmagic 0) 4 somma)
;-> true

Verifichiamo che i numeri siano tutti diversi:

(= (unique (flat (qmagic 0))) (flat (qmagic 0)))

Probabilmente qualcuno di questi 5 quadrati magici sono trasposti e/o simmetrici tra loro, ma sicuramente almeno uno (qmagic 0) è un quadrato magico con una somma pandigitale (minore di quella del quadrato magico di Kurchan), tutti i numeri sono pandigitali e diversi tra loro. Quindi abbiamo trovato un quadrato magico con le stesse proprietà di quelle di Kurchan, ma con una somma minore.


--------------
Serie infinite
--------------

La serie di Grandi
------------------

SG = 1 - 1 + 1 - 1 + 1 - 1 + ...

Qual'è il valore della serie SG?

(1 - SG) = 1 - (1 - 1 + 1 - 1 + 1 - 1 + ...)

(1 - SG) = SG

1 = 2*SG  ==>  SG = 1/2

Nota: i metodi algebrici utilizzati non dovrebbero essere applicati a serie non convergenti, tuttavia la somma di Cesaro per questa serie vale 1/2. La somma di Cesaro è un'estensione del concetto classico di serie convergente basata sulle somme parziali.
Data una serie:

Sum[1..INF] a(n)

con somme parziali:

s(n) = a(1) + a(2) + ... + a(n)

la somma di Cesàro è il limite (quando esiste) della media aritmetica delle somme parziali:

        s(1) + s(2) + ... + s(n)
  lim  --------------------------
 n->INF            n

La serie dei numeri naturali alternati
--------------------------------------

SA = 1 - 2 + 3 - 4 + 5 - 6 + ...

Qual'è il valore della serie SA?

2*SA = 1 - 2 + 3 - 4 + 5 - 6 + ...
         + 1 - 2 + 3 - 4 + 5 - ...

2*SA = 1 - 1 + 1 - 1 + 1 - 1 + 1 = SG

2*SA = 1/2  ==>  SA = 1/4

La serie dei numeri naturali
----------------------------

SN = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + ...

Qual'è il valore della serie SN?

(SN - SA) = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + ...
         - (1 + 2 - 3 + 4 - 5 + 6 - 7 + 8 + ...)

(SN - SA) = 4 + 8 + 12 + 16 = 4*SN

(SN - 1/4) = 4*SN

-1/4 = 3*SN  ==> SN = -1/12

Nota: i procedimenti non sono matematicamente ortodossi, ma i risultati sono corretti (in un certo senso).


----------------
Il gioco del Pig
----------------

Ad ogni turno, ogni giocatore lancia ripetutamente un dado finché non esce un 1 oppure il giocatore decide di "passare".
Se il giocatore ottiene un 1, il punteggio del turno è nullo e passa la mano al prossimo giocatore.
se il giocatore ottine un altro numero (2..6), il numero viene aggiunto al punteggio del turno e il turno del giocatore continua.
Se un giocatore decide di "passare", il suo punteggio del turno viene aggiunto al suo punteggio totale, e diventa il turno del prossimo giocatore.
Vince il giocatore che arriva o supera 100 (poichè il turno deve terminare per tutti i giocatori, potrebbero esserci più giocatori che superano 100, allora il vincitore è quello con il punteggio più alto).

Scriviamo un programma per giocare contro il computer. La strategia del computer è la seguente:

0) se il punteggio dell'altro giocatore è maggiore o uguale a 100, allora lanciare i dadi per raggiungere tale punteggio.
1) se il punteggio del computer è maggiore o uguale a 71, allora lancia i dadi per provare a raggiungere 100.
2) altrimenti lancia i dadi per raggiungere il valore: 21 + int((Punti-Giocatore - Punti-Computer)/8)

Nota: se ci sono N giocatori possiamo applicare la strategia con una sola differenza: il punteggio da considerare per calcolare il valore da raggiungere ad ogni turno è quello massimo tra tutti gli altri giocatori.

(define (game-pig)
  (local (score1 score2 turn winner endgame)
    (setq winner -1)
    (setq endgame nil)
    (setq score1 0 score2 0)
    (setq turn 1)
    (do-until endgame
      (println "")
      (println "Turno: " turn)
      (println "Punteggio: UMANO    = " score1)
      (println "           COMPUTER = " score2)
      (println "")
      (human)
      (println "")
      (println "Premi Invio per la mossa del computer...")
      (read-line)
      (computer)
      (setq winner (checkwinner score1 score2))
      (cond ((= winner 1) (println "Fine del gioco l'umano vince: " score1 " - " score2))
            ((= winner 2) (println "Fine del gioco il computer vince: " score2 " - " score1))
            ((= winner 3) (println "Fine del gioco in pareggio: " score1 " - " score2))
      )
      (++ turn)
    )
  ))

(define (human)
  (local (t1 val input continua)
    (setq t1 0)
    (setq val 0)
    (setq continua true)
    (println "Mossa all'Umano: ")
    (println "1 (per lanciare i dadi)")
    (println "0 (per passare la mano)")
    (while continua
      (setq input (read-line))
      (cond ((= "1" input)
             (setq val (+ (rand 6) 1))
             (if (= val 1)
                 (setq t1 0 continua nil)
             ;else
                 (setq t1 (+ t1 val)))
            )
            ((= "0" input)
             (setq continua nil))
      )
      (println "Dado = " val)
      (println "Parziale = " t1)
    )
    (setq score1 (+ score1 t1))
    (println "Umano: Parziale = " t1)
    (println "       Totale = " score1)
  )
)

(define (computer)
  (local (t2 val goal continua)
    (cond ((>= score1 100) (setq goal score1))
          ((>= score2 71)  (setq goal (- 100 score2)))
          (true            (setq goal (+ 21 (int (div (- score1 score2) 8)))))
    )
    (println "goal: "goal)
    (setq continua true)
    (setq t2 0)
    (while (and (< t2 goal) continua)
      (setq val (+ (rand 6) 1))
      (if (= val 1)
          (setq t2 0 continua nil)
      ;else
          (setq t2 (+ t2 val))
      )
      (println "Dado = " val)
      (println "Parziale = " t2)
    )
    (setq score2 (+ score2 t2))
    (println "Computer: Parziale = " t2)
    (println "          Totale = " score2)
    ))

(define (checkwinner p1 p2)
  (let (out 0)
    (if (or (>= p1 100) (>= p2 100))
        (begin
          (cond ((> p1 p2) (setq out 1))
                ((> p2 p1) (setq out 2))
                ((= p1 p2) (setq out 3))
          )
          (setq endgame true))
    )
    out))


Proviamo a giocare:

(game-pig)

Turno: 1
Punteggio: UMANO    = 0
           COMPUTER = 0

Mossa all'Umano:
1 (per lanciare i dadi)
0 (per passare la mano)
1
Dado = 1
Parziale = 0
Umano: Parziale = 0
       Totale = 0

Premi Invio per la mossa del computer...

goal: 21
Dado = 4
Parziale = 4
Dado = 2
Parziale = 6
Dado = 5
Parziale = 11
Dado = 4
Parziale = 15
Dado = 3
Parziale = 18
Dado = 3
Parziale = 21
Computer: Parziale = 21
          Totale = 21

Turno: 2
Punteggio: UMANO    = 0
           COMPUTER = 21

Mossa all'Umano:
1 (per lanciare i dadi)
0 (per passare la mano)
...
...
...
Premi Invio per la mossa del computer...

goal: 5
Dado = 5
Parziale = 5
Computer: Parziale = 5
          Totale = 100
Fine del gioco il computer vince: 100 - 92


----------
Mandelbrot
----------

L'insieme di Mandelbrot o frattale di Mandelbrot è uno dei frattali più popolari ed definito come l'insieme dei numeri complessi c per i quali la successione definita da:

  z(0) = 0
  z(n+1) = z(n)^2 + c

è limitata. Nonostante la semplicità della definizione, l'insieme ha una forma complessa il cui contorno è un frattale. Solo con l'avvento del computer è stato possibile visualizzarlo.

Vediamo un modo spartano di visualizzare questo frattale in una pagina html con una funzione che utilizza l'aritmetica dei numeri complessi:

;;; This program requires v.10.2.0 (or later) of newLISP and
;;; will not run on the original FOOP as introduced in 10.0
; open html file
(device (open "mandelbrot.html" "write"))
(print "<!doctype html>\r\n\r\n")
(println [text]
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Mandelbrot Fractal</title>
  <meta name="description" content="Mandelbrot">
  <meta name="author" content="cameyo">
  <link rel="stylesheet" href="css/styles.css?v=1.0">
</head>
[/text])
(println " </CENTER> <br><center><h4>Mandelbrot Fractal</h4></center></html>")
(println "<CENTER>")
(set ' colors '(
  "800000" "800080" "8000FF" "808000" "808080" "8080FF" "80FF00" "80FF80"
  "80FFFF" "FF0000" "FF0080" "FF00FF" "FF8000" "FF8080" "FF80FF" "FFFF00"))
;; adapted from a program written by Michael Michaels and Cormullion
;; this is a FOOP (Functional Object Oriented Programming) application
; (define (Class:Class) (cons (context) (args))) ; predefined since version 10.0
(new Class 'Complex)
(define (Complex:rad)
  (sqrt (add (pow (self 1) ) (pow (self 2))))
)
(define (Complex:add b)
  (Complex (add (self 1) (b 1)) (add (self 2) (b 2)))
)
(define (Complex:mul b)
  (let (a-re (self 1) a-im (self 2) b-re (b 1) b-im (b 2))
    (Complex
      (sub (mul a-re b-re) (mul a-im b-im))
      (add (mul a-re b-im) (mul a-im b-re)) )
))
(define (draw)
  (print "<table bgcolor=#f0f0f0>\n")
  (for (y -1 1.1 0.08)
    (for (x -2 1 0.04)
      (set 'z (Complex x y) 'c 85 'a z )
      (while (and (< (abs (:rad (set 'z (:add (:mul z z) a)))) 2) (> (dec c) 32)) )
      (if (= c 32)
        (print "<td bgcolor=#000000>&nbsp;</td>")
        (print "<td bgcolor=#" (colors (% c  16)) ">&nbsp;</td>"))
    )
    (println "</tr>") )
  (println "</table>")
)
(draw)
(print " </CENTER> <br><center><h4>created with newLISP v." (sys-info -2) "</h4></center></html>")
; close file
(close (device))
;; eof

Adesso possiamo visualizzare la pagina nel browser predefinito:

(exec "mandelbrot.html")

Potete trovare il file "mandelbrot.html" nella cartella "data".


----------------
find per vettori
----------------

Per ricercare un elemento in una lista possiamo usare la funzione "find":

******************
>>> funzione FIND
******************
sintassi: (find exp-key list [func-compare | regex-option])
sintassi: (find str-key str-data [regex-option [int-offset]])

Trova un'espressione in una lista
Se il secondo argomento restituisce è una lista, allora find restituisce la posizione dell'indice (offset) dell'elemento derivato dalla valutazione di exp-key.

Facoltativamente, è possibile specificare un operatore o una funzione definita dall'utente in func-compare. Se exp-key è una stringa, è possibile specificare un'opzione di espressione regolare con il parametro regex-option.

Quando si utilizzano espressioni regolari o funtori di confronto, la variabile di sistema $0 è impostata sull'ultimo elemento trovato.

; find an expression in a list
(find '(1 2) '((1 4) 5 6 (1 2) (8 9)))  → 3

(find "world" '("hello" "world"))       → 1
(find "hi" '("hello" "world"))          → nil

(find "newlisp" '("Perl" "Python" "newLISP") 1)  → 2
; same with string option
(find "newlisp" '("Perl" "Python" "newLISP") "i")  → 2

; use the comparison functor
(find 3 '(8 4 3  7 2 6) >)  → 4
$0 → 2

(find "newlisp" '("Perl" "Python" "newLISP")
                 (fn (x y) (regex x y 1))) → 2
$0 → "newLISP"

(find 5 '((l 3) (k 5) (a 10) (z 22))
         (fn (x y) (= x (last y))))  → 1
$0 → (k 5)

(find '(a ?) '((l 3) (k 5) (a 10) (z 22)) match)  → 2
$0 → (a 10)

(find '(X X) '((a b) (c d) (e e) (f g)) unify)  → 2
$0 → (e e)

; define the comparison functor first for better readability
(define (has-it-as-last x y) (= x (last y)))

(find 22 '((l 3) (k 5) (a 10) (z 22)) has-it-as-last)  → 3
$0 → (z 22)

Nota: in questo caso tralasciamo la spiegazione dell'uso di find con le stringhe (vedi manuale).

Per esempio:

(setq a '(1 3 (2 3) 4 (3 5 (6))))
(find 4 a)
;-> 3
(a 3)
;-> 4

Possiamo trovare solo un elemento completo, cioè non possiamo trovare un elemento annidato (es. 5):
(find 5 a)
;-> nil

Per trovare gli elementi annidati occorre usare la funzione "ref" o "ref-all":

(ref 5 a)
;-> (4 1)
(a 4 1)
;-> 5

Nota: comunque se conosciamo la struttura della lista di ricerca possiamo utilizzare "find" con una funzione lambda, per esempio:

(setq lst '((1 2) (2 3) (4 5)))

Cerchiamo l'elemento il cui ultimo sottoelemento vale 5:

(find 5 lst (fn(x y) (= x ((last y)))))

In questo caso i parametri della funzione lambda sono associati come:
x --> 5
y --> lst

Cerchiamo l'elemento i cui sottoelementi sommano a 5:

(find 5 lst (fn(x y) (= x (+ (first y) (last y)))))
;-> 1

Purtroppo "find" non è applicabile ai vettori, quindi scriviamo una funzione che rimedia (almeno in parte) a questa mancanza:

(define (find-array el arr)
(catch
  (for (i 0 (- (length arr) 1))
    (if (= el (arr i)) (throw i)))))

(define (find-array el arr)
(let ((val nil) (stop nil))
  (for (i 0 (- (length arr) 1) 1 stop)
    (if (= el (arr i)) (setq val el stop true)))
  val))

(find-array 4 a)
;-> 3

(find-array '(2 3) a)
;-> 2

Vediamo un test di velocità tra "find" e "find-array":

(setq t (sequence 1 10000))
(time (find 5000 t) 10000)
;-> 259.333

(setq arr (array 10000 t))
(time (find-array 5000 arr) 10000)
;-> 3093.758

Possiamo usare questa funzione solo con vettori non troppo grandi.

Se invece abbiamo un vettore ordinato di numeri possiamo utilizzare la ricerca binaria per cercare un elemento.

Scriviamo la funzione di ricerca binaria (per vettori ordinati in modo crescente):

(define (bs num arr len)
(catch
  (local (basso alto indice)
    (setq basso 0) ; inizio lista
    (setq alto (- len 1)) ; fine lista
    (while (>= alto basso)
      (setq indice (>> (+ basso alto))) ; valore centrale indice
      (cond ((> (arr indice) num)
             (setq alto (- indice 1))) ; aggiorno l'indice "alto"
            ((< (arr indice) num)
             (setq basso (+ indice 1))) ; aggiorno l'indice "basso"
            (true (throw indice)) ; elemento trovato
      )
    )
    out)))

La funzione finale "find-array-bs":

(define (find-array-bs el arr) (bs el arr (length arr)))

(setq s (array 8 '(1 2 8 11 21 36 42 77)))

(find-array-bs 4 s)
;-> nil

(find-array-bs 42 s)
;-> 6

Vediamo i tempi di esecuzione:

(silent (setq arr (array 10000 (sequence 1 10000))))
(time (find-array-bs 5000 arr) 10000)
;-> 1432.697
(time (find-array-bs 2 arr) 10000)
;-> 1465.604


----------------
Variabili libere
----------------

Quando si scrivono le funzioni può capitare di dimenticarsi di dichiarare una o più variabili locali. In questo caso la variabile utilizzata mantiene il suo valore anche quando la funzione in cui è contenuta è terminata. Queste variabili possono causare errori nell'esecuzione del programma perchè sono "viste" da tutte le funzioni che vengono eseguite. Per semplicità chiamiamo "libere" queste variabili.

La seguente funzioni visualizza tutte le "variabili libere" che hanno un valore diverso da nil (non è possibile, tramite le primitive di newLISP, determinare se una variabile che vale nil sia libera o meno).

(define (free-vars _ctx)
  (local (_vars)
    (if (= _ctx nil) (setq _ctx (context)))
    (setq _vars '())
    (dolist (_el (symbols _ctx))
      (if (and (not (lambda? (eval _el)))
               (not (primitive? (eval _el)))
               (not (protected? _el))
               (not (global? _el))
               (not (= _el '_ctx))
               (not (= _el '_vars))
               (not (= _el '_el))
               (not (= _el '_v)))
          (push _el _vars -1))
    )
    (dolist (_v _vars)
      (if (eval _v)
        (println _v { } (eval _v))))))

Partiamo con una REPL nuova e, dopo aver valutato la funzione "free-vars", scriviamo la seguente funzione:

(define (test a b) (setq c (+ a b)))

In questa funzione la variabile "c" è libera:

(test 5 10)
;-> 15

Verifichiamo con la funzione "free-vars":

(free-vars)
;-> c 15

In questo modo possiamo correggere la dichiarazione delle variabili e ottenere un programma più stabile.

Per includere anche i contesti/hashmap possiamo usare la seguente funzione:

(define (free-vars _ctx)
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


--------------
Debug spartano
--------------

Molte volte, prima di utilizzare il debugger di newLISP, utilizzo la vecchia scuola dei "println" per controllare i valori delle variabili durante l'esecuzione del programma. Il metodo è abbastanza tedioso soprattutto se dobbiamo controllare diverse variabili e se vogliamo che vengano visualizzate solo al verificarsi di certe condizioni.

La funzione "break" aiuta a semplificare questo problema utilizzando due parametri:
1) sym-lst: la lista dei simboli/variabili da visualizzare
2) cond-str: una espressione (stringa) newLISP che rappresenta una condizione (true o nil)

Quando la condizione "cond-str" viene valutata true, allora vengono stampati i simboli/variabili con i relativi valori contenuti nella lista "sym-lst". A questo punto l'utente può fare quattro scelte:
1) premere il tasto "Invio" per far continuare l'esecuzione della funzione chiamante.
2) inserire e valutare una espressione direttamente nella REPL.
3) disabilitare la funzione "break" inserendo nella REPL: (setq _BREAK nil)
4) premere "Ctrl+C" per interrompere l'esecuzione del programma.

Scriviamo la funzione e poi vediamo come si applica:

Abbiamo bisogno di una variabile globale _BREAK:

(global '_BREAK)
(setq _BREAK true)

(define (break sym-lst cond-str)
        ; se (_BREAK = true) e
        ; se la condizione "cond-str" viene valutata true
  (cond ((and _BREAK (eval-string cond-str))
          ; allora stampiamo tutti i simboli con i relativi valori
          ; contenuti nella lista sym-lst
          (dolist (el sym-lst)
            (print el " = " (eval el) "; ")
          )
          (println "")
          ; Aspetta un comando/espressione:
          ; 1) 'Invio' continua l'esecuzione della funzione chiamante
          ; 2) espressione da valutare
          ; 3) (setq _BREAK nil)
          ; 4) Ctrl+C
          (read-line)
          (while (> (length (current-line)) 0)
            (println (eval-string (current-line)))
            (read-line)
          ))))

Supponiamo di voler fare il debug della seguente funzione:

(define (prova a b)
  (let ((c 0) (d 0) (out '()))
    (for (i 1 20)
      (setq c (+ a c 10))
      (setq d (+ b d 3))
      (push c out -1)
      ;(break '(c d) "(or (> c 20) (> d 100))")
      (break '(out) "(or (> c 20) (> d 100))")
      ;(break '(out) "(> (length out) 5)")
      ;(break '(c d out) "true")
    )
    (+ c d)))

Abbiamo inserito quattro funzioni "break" e i quattro esempi seguenti si riferiscono ad una sola funzione di "break" attiva (ogni volta diversa).

Condizione: (break '(c d) "(or (> c 20) (> d 100))")
(prova 10 20)
;-> c = 40; d = 46;
out
;-> (20 40)
(setq c 20)
;-> 20
c
;-> 20
(+ a b)
;-> 30
"Invio"
;-> c = 60; d = 69;
"Invio"
;-> c = 80; d = 92;
"Invio"
;-> c = 100; d = 115;
...

Condizione: (break '(out) "(or (> c 20) (> d 100))")
(prova 10 20)
;-> out = (20 40);
c
;-> 40
d
;-> 46
"Invio"
;-> out = (20 40 60);
"Invio"
;-> out = (20 40 60 80);
(- c d)
;-> -12
(setq _BREAK nil)
;-> nil
"Invio"
860

Condizione: (break '(out) "(> (length out) 5)")
(setq _BREAK true)
(prova 10 20)
;-> out = (20 40 60 80 100 120);
(println c d)
;-> 120138
;-> 138
"Invio"
;-> out = (20 40 60 80 100 120 140);
"Invio"
;-> out = (20 40 60 80 100 120 140 160);
...

Se vogliamo che le variabili siano stampate sempre, allora basta assegnare "true" al parametro "cond-str":

Condizione: (break '(c d out) "true")
(prova 10 20)
;-> c = 20; d = 23; out = (20);
"Invio"
;-> c = 40; d = 46; out = (20 40);
"Invio"
;-> c = 60; d = 69; out = (20 40 60);
...

Nota: quando inseriamo le espressioni da valutare nella REPL è possibile inserire anche la funzione che è in esecuzione (es. (prova 3 4))


----------------------
Espressioni ABCDEFGHIJ
----------------------

Risolvere le seguenti espressioni in cui ogni lettera rappresenta una particolare cifra da 0 a 9:

  1) ABC + DEF = GHIJ
  2) (AB)^C = DEF + GHIJ
  3) (AB)^C = DEF * GHIJ
  4) (AB)^C = (DE)^F + GHIJ
  5) Trovare il numero ABCDEFGHIJ che ha le seguenti proprietà:
      A è divisibile per 1
      AB è divisibile per 2
      ABC è divisibile per 3
      ABCD è divisibile per 4
      ABCDE è divisibile per 5
      ABCDEF è divisibile per 6
      ABCDEFG è divisibile per 7
      ABCDEFGH è divisibile per 8
      ABCDEFGHI è divisibile per 9
      ABCDEFGHIJ è divisibile per 10

Funzione che calcola le permutazioni:

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

Creiamo le permutazioni delle 10 cifre:

(silent (setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))))

Equazione 1: ABC + DEF = GHIJ
-----------------------------

(define (solve1)
  (local (op1 op2 op3 out)
    ;(println "Calcolo permutazioni...")
    ;(setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    ;(println "Verifica equazione...")
    (dolist (k nums)
      ; costruzione operandi
      (setq op1 (int (join (slice k 0 3)) 0 10))
      (setq op2 (int (join (slice k 3 3)) 0 10))
      (setq op3 (int (join (slice k 6 4)) 0 10))
      (if (= (+ op1 op2) op3)
        (begin
          ;(println k)
          ;(println op1 "+" op2 " = " op3)
          (push (list op1 op2 op3) out -1)
        )
      )
      ;(if (zero? (% $idx 100000)) (println $idx)))
    )
    out))

(time (setq sol1 (solve1)))
;-> 17602.861
(length sol1)
;-> 432

sol1
;-> ((324 765 1089) (724 365 1089) (764 325 1089)
;->  (364 725 1089) (452 637 1089) (652 437 1089)
;->  ...
;->  (349 218 567) (139 428 567) (439 128 567))

Equazione2: (AB)^C = DEF + GHIJ
-------------------------------

(define (solve2)
  (local (op1 op2 op3 op4 out)
    ;(println "Calcolo permutazioni...")
    ;(setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (println "Verifica equazione...")
    (dolist (k nums)
      ; C non può essere "0"
      (cond ((!= (k 2) "0")
             ; costruzione operandi
             (setq op1 (int (join (slice k 0 2)) 0 10))
             (setq op2 (int (k 2)))
             (setq op3 (int (join (slice k 3 3)) 0 10))
             (setq op4 (int (join (slice k 6 4)) 0 10))
             (if (= (pow op1 op2) (+ op3 op4))
               (begin
                 (println k)
                 (println op1 "^" op2 " = " op3 " + " op4)
                 (push (list op1 op2 op3 op4) out -1)
               )
             ))
             ;(if (zero? (% $idx 100000)) (println $idx)))
      )
    )
    out))

(time (setq sol2 (solve2)))
;-> Verifica equazione...
;-> ("0" "7" "4" "8" "6" "2" "1" "5" "3" "9")
;-> 7^4 = 862 + 1539
;-> ("0" "7" "4" "5" "6" "2" "1" "8" "3" "9")
;-> 7^4 = 562 + 1839
;-> ("0" "7" "4" "8" "3" "2" "1" "5" "6" "9")
;-> 7^4 = 832 + 1569
;-> ("0" "7" "4" "5" "3" "2" "1" "8" "6" "9")
;-> 7^4 = 532 + 1869
;-> ("1" "5" "3" "9" "6" "7" "2" "4" "0" "8")
;-> 15^3 = 967 + 2408
;-> ("1" "5" "3" "4" "6" "7" "2" "9" "0" "8")
;-> 15^3 = 467 + 2908
;-> ("1" "5" "3" "9" "0" "7" "2" "4" "6" "8")
;-> 15^3 = 907 + 2468
;-> ("1" "5" "3" "4" "0" "7" "2" "9" "6" "8")
;-> 15^3 = 407 + 2968
;-> ("0" "7" "4" "8" "6" "9" "1" "5" "3" "2")
;-> 7^4 = 869 + 1532
;-> ("0" "7" "4" "5" "6" "9" "1" "8" "3" "2")
;-> 7^4 = 569 + 1832
;-> ("0" "7" "4" "8" "3" "9" "1" "5" "6" "2")
;-> 7^4 = 839 + 1562
;-> ("0" "7" "4" "5" "3" "9" "1" "8" "6" "2")
;-> 7^4 = 539 + 1862
;-> ("1" "5" "3" "9" "0" "8" "2" "4" "6" "7")
;-> 15^3 = 908 + 2467
;-> ("1" "5" "3" "4" "0" "8" "2" "9" "6" "7")
;-> 15^3 = 408 + 2967
;-> ("1" "5" "3" "9" "6" "8" "2" "4" "0" "7")
;-> 15^3 = 968 + 2407
;-> ("1" "5" "3" "4" "6" "8" "2" "9" "0" "7")
;-> 15^3 = 468 + 2907
;-> ((7 4 862 1539) (7 4 562 1839) (7 4 832 1569) (7 4 532 1869)
;->  (15 3 967 2408) (15 3 467 2908) (15 3 907 2468) (15 3 407 2968)
;->  (7 4 869 1532) (7 4 569 1832) (7 4 839 1562) (7 4 539 1862)
;->  (15 3 908 2467) (15 3 408 2967) (15 3 968 2407) (15 3 468 2907))
;-> 18882.909

(length sol2)
;-> 16

Equazione 3: (AB)^C = DEF * GHIJ
--------------------------------

(define (solve3)
  (local (op1 op2 op3 op4 out)
    ;(println "Calcolo permutazioni...")
    ;(setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (println "Verifica equazione...")
    (dolist (k nums)
      ; C non può essere "0"
      (cond ((!= (k 2) "0")
             ; costruzione operandi
             (setq op1 (int (join (slice k 0 2)) 0 10))
             (setq op2 (int (k 2)))
             (setq op3 (int (join (slice k 3 3)) 0 10))
             (setq op4 (int (join (slice k 6 4)) 0 10))
             (if (= (pow op1 op2) (* op3 op4))
               (begin
                 (println k)
                 (println op1 "^" op2 " = " op3 " * " op4)
                 (push (list op1 op2 op3 op4) out -1)
               )
             ))
             ;(if (zero? (% $idx 100000)) (println $idx)))
      )
    )
    out))

(time (setq sol3 (solve3)))
;-> Verifica equazione...
;-> ("8" "4" "3" "5" "7" "6" "1" "0" "2" "9")
;-> 84^3 = 576 * 1029
;-> ("4" "8" "3" "5" "7" "6" "0" "1" "9" "2")
;-> 48^3 = 576 * 192
;-> ("4" "8" "3" "1" "9" "2" "0" "5" "7" "6")
;-> 48^3 = 192 * 576
;-> 18747.064

(length sol3)
;-> 3

Equazione 4: (AB)^C = (DE)^F * GHIJ
-----------------------------------

(define (solve4)
  (local (op1 op2 op3 op4 op5 out)
    ;(println "Calcolo permutazioni...")
    ;(setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    (println "Verifica equazione...")
    (dolist (k nums)
      ; C e F non possono essere "0"
      (cond ((and (!= (k 2) "0") (!= (k 5) "0"))
             ; costruzione operandi
             (setq op1 (int (join (slice k 0 2)) 0 10))
             (setq op2 (int (k 2)))
             (setq op3 (int (join (slice k 3 2)) 0 10))
             (setq op4 (int (k 5)))
             (setq op5 (int (join (slice k 6 4)) 0 10))
             (if (= (pow op1 op2) (* (pow op3 op4) op5))
               (begin
                 (println k)
                 (println op1 "^" op2 " = (" op3 "^" op4 " * " op5)
                 (push (list op1 op2 op3 op4 op5) out -1)
               )
             ))
             ;(if (zero? (% $idx 100000)) (println $idx)))
      )
    )
    out))

(time (setq sol4 (solve4)))
;-> Verifica equazione...
;-> ("4" "2" "3" "9" "8" "1" "0" "7" "5" "6")
;-> 42^3 = (98^1 * 756
;-> ((42 3 98 1 756))
;-> 18911.696

(length sol4)
;-> 1

Equazione 5: ABCDEFGHIJ
-----------------------
Si tratta di un puzzle proposto da John Conway.
Trovare il numero ABCDEFGHIJ che ha le seguenti proprietà:

  A è divisibile per 1
  AB è divisibile per 2
  ABC è divisibile per 3
  ABCD è divisibile per 4
  ABCDE è divisibile per 5
  ABCDEF è divisibile per 6
  ABCDEFG è divisibile per 7
  ABCDEFGH è divisibile per 8
  ABCDEFGHI è divisibile per 9
  ABCDEFGHIJ è divisibile per 10

Il problema può essere risolto (non immediatamente) utilizzando le regole della divisibilità dei numeri. Invece qui lo risolveremo con una funzione brute-force:

(define (solve5)
  (local (co2 co3 co4 co5 co6 co7 co8 co9 co10 next)
    ;(println "Calcolo permutazioni...")
    ;(setq nums (perm '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")))
    ;(println "Verifica condizioni...")
    (dolist (k nums)
      (setq stop nil)
      ; A non può essere "0"
      (cond ((!= (k 0) "0")
             (setq found true)
             (for (i 2 10 1 stop)
                (setq val (int (join (slice k 0 i)) 0 10))
                (if (!= (% val i) 0)
                    (setq stop true found nil)
                )
             )
             (if found (println (int (join k)))))
      )
    )))

(time (println (solve5)))
;-> 3816547290
;-> 16091.888


----------------
Sequenza Juggler
----------------

La sequenza juggler (giocoliere) per un intero positivo a(1) = n è la sequenza di numeri prodotta dall'iterazione:

 a(k+1)= floor(a(k)^(1/2))   per a(k) pari
         floor(a(k)^(3/2))   per a(k) dispari

I termini di questa sequenza prima aumentano fino a un valore massimo e poi iniziano a diminuire. Sorprendentemente, tutti gli interi sembrano raggiungere alla fine 1, una congettura che vale almeno fino a 10^6.

Scriviamo la funzione di base:

(define (juggler num)
  (local (a b sqr out)
    (setq a num)
    ; primo termine della sequenza
    (setq out (list a))
    (while (!= a 1)
      (setq b 0)
      (setq sqr (sqrt a))
            ; precedente termine pari?
      (cond ((even? a)
            ; calcola il prossimo termine
            (setq b (int (floor sqr))))
            ; precedente termine dispari?
            ((odd? a)
             (setq b (int (floor (mul sqr sqr sqr)))))
            ; calcola il prossimo termine
      )
      ; inserisce il valore corrente della sequenza nella lista di output
      (push b out -1)
      ; il valore corrente diventa il valore precedente
      (setq a b)
    )
    out))

(juggler 10)
;-> (10 3 5 11 36 6 2 1)

I valori della sequenza posono raggiungere valori molto alti:

(juggler 37)
;-> (37 225 3375 196069 86818724 9317 899319 852846071
;->  24906114455136 4990602 2233 105519 34276462 5854 76 8 2 1)

Definiamo due sequenze:

A) I numeri di passi p(n) necessari per raggiungere 1 partendo da n (OEIS A007320).

B) Il valore massimo h(n) della sequenza partendo da n (OEIS A094716).

Modifichiamo la nostra funzione per calcolare i valori di queste sequenze. L'output sarà una lista con la seguente struttura:

(num num-step val-max)

(define (giocoliere num)
  (local (a b sqr max-val num-step)
    (setq a num)
    ; all'inizio il numero di passi vale 0
    (setq num-step 0)
    ; all'inizio il valore massimo della sequenza vale num, cioè a
    (setq max-val a)
    (while (!= a 1)
      (setq b 0)
      (setq sqr (sqrt a))
            ; precedente termine pari?
      (cond ((even? a)
            ; calcola il prossimo termine
            (setq b (int (floor sqr))))
            ; precedente termine dispari?
            ((odd? a)
             (setq b (int (floor (mul sqr sqr sqr)))))
            ; calcola il prossimo termine
      )
      ; verifica valore massimo
      (if (> b max-val) (setq max-val b))
      ; aumenta lunghezza di 1
      (++ num-step)
      ; il valore corrente diventa il valore precedente
      (setq a b)
    )
    (list num num-step max-val)))

(giocoliere 10)
;-> (10 8 36)

Adesso creiamo una funzione che calcola questi valori per tutti numeri fino a "limite":

(define (juggler-all limite)
  (let (out '())
    (for (i 1 limite)
      (push (giocoliere i) out -1))
    out))

(juggler-all 10)
;-> ((1 0 1) (2 1 2) (3 6 36) (4 2 4) (5 5 36)
;->  (6 2 6) (7 4 18) (8 2 8) (9 7 140) (10 7 36))

La sequenza del giocoliere che parte da a(0) = 48443 raggiunge un valore massimo in a(60) con 972463 cifre, prima di raggiungere 1 in a(157). Non siamo in grado di calcolarla correttamente perchè non usiamo i big-integer:

(juggler 48443)
;-> (48443 10662193 34815273349 6496130099313866 80598573
;->  723587455374 850639 784545138 28009 4687555 10148913818
;->  100741 31974914 5654 75 649 16533 2125824 1458 38 6 2 1)

(giocoliere 48443)
;-> (48443 22 6496130099313866)

Il risutato è errato.

Comunque in questo caso per poter utilizzare i numeri big-integer dovremmo avere anche la possibilità di definire la precisione dei calcoli in virgola mobile (infatti dobbiamo moltiplicare in virgola mobile la radice quadrata di un numero), altrimenti perderemmo cifre significative durante la conversione a big-integer.


----------------------
Limiti dei big-integer
----------------------

La classe BigInteger consente di creare e manipolare numeri interi di qualsiasi dimensione.

Qualsiasi dimensione? Esiste un limite (fisico o logico)?

Non ci sono limiti teorici. La classe BigInteger alloca la memoria necessaria per tutti i bit di dati che viene richiesto di contenere. Infatti una buona implementazione dei BigInteger utilizza internamente un vettori di interi dinamico per rappresentare i numeri che utilizza.

Tuttavia esistono alcuni limiti pratici dettati dalla memoria a disposizione. E ci sono ulteriori limiti tecnici, anche se è molto improbabile che il nostro programma ne sia influenzato: alcuni metodi presumono che i bit siano indirizzabili da indici interi, quindi le cose inizieranno a rompersi quando indirizziamo bit con indici del valore Integer.MAX_VALUE.

Ad esempio in java i BigInteger hanno la seguente definizione:

BigInteger:
  int bitCount +4 bytes
  int bitLength +4 bytes
  int firstNonzeroIntNum +4 bytes
  int lowestSetBit +4 bytes
  int signum +4 bytes
  int[] mag +?

Un vettore in Java può avere solo 2^32 elementi. Quindi se i bit del BigInteger sono memorizzati in un vettore di interi, allora può memorizzare al massimo 2^32 cifre, cioè un numero massimo pari a (2^32)^Integer.MAX_VALUE.

Nel linguaggio IDL la classe BigInteger memorizza un numero come un vettore di "cifre" intere a 32 bit senza segno con una radice, o base, di 4294967296 (2^32 - 1). La classe memorizza le cifre in ordine little-endian, con la cifra più significativa alla fine del vettore.

Nota: il valore massimo dei BigInteger può essere limitato da altre funzioni del linguaggio. Ad esempio, se esiste una funzione che trasforma il numero in una stringa, allora il valore massimo è limitato dalla lunghezza massima di una stringa che vale (2^31 - 1).


----------------------------------
Valutazione di espressioni infisse
----------------------------------

Per trasformare una espressione infissa in una prefissa bisogna invertire l'operatore con l'operando:
Per trasformare una semplice espressione infissa (es. (2 + 3)) in una espressione prefissa (es. (+ 2 3)) bisogna invertire l'operatore con l'operando:

(2 + 3) --> (+ 2 3)

(define (infix2prefix expr)
  (list (nth 1 expr) (nth 0 expr) (nth 2 expr)))

(infix2prefix '(2 + 3))
;-> (+ 2 3)

Comunque questa funzione non è in grado di tradurre correttamente espressioni annidate, ovvero espressioni in cui si trovano gli operandi essi stessi espressioni infisse. Per gestire correttamente questa situazione anche gli operandi devono essere trasformati in notazione prefissa. Questo viene fatto utilizzando la ricorsione che viene fermata quando l'argomento è un numero (che viene restituito come tale). Quindi la funzione diventa la seguente:

(define (infix-to-prefix expr)
  (cond ((number? expr) expr)
         (true (list (nth 1 expr)
               (infix-to-prefix (nth 0 expr))
               (infix-to-prefix (nth 2 expr))))))

(infix-to-prefix '(3 + 2))
;-> (+ 3 2)

(infix-to-prefix '((5.2 add 3.3) sub (4 div 2)))
;-> (sub (add 5.2 3.3) (div 4 2))

Questo convertitore infisso-prefisso gestisce solo espressioni aritmetiche binarie e richiede che tutte le espressioni siano completamente tra parentesi (questo elimina il calcolo sulla precedenza degli operatori). Comunque consente alle espressioni di essere annidate a una profondità arbitraria e gestisce tutti gli operatori aritmetici binari supportati da newLISP.

A questo punto definiamo una funzione che ci permette di valutare direttamente le espressioni infisse:

(define (infix expr)
  (eval (infix-to-prefix expr)))

(infix '((5 + 3) - (4 / 4)))
;-> 7

(infix '((5.2 add 3.3) sub (4 div 2)))
;-> 6.5

Nota: le espressioni devono essere inserite con le parentesi al posto giusto

(infix '((5.2 add 3.3 add 2)))
;-> ERR: invalid list index in function nth

(infix '((5.2 add 3.3) add 2))
;-> 10.5

A questo punto possiamo creare un mini-interprete che funziona in modo simile alla REPL di newLISP.

Per interagire con l'utente newLISP mette a disposizione la funzione "read-line" che resituisce la stringa inserita dall'utente. Quindi abbiamo bisogno di una funzione "reader" che converte questa stringa in una espressione newLISP.

(define (reader readstr readret)
   (cond
      ((float readstr)
       (if (find "." readstr)
         (setq readret (float readstr))
         (setq readret (integer readstr))))
      ((= (slice readstr 0 1)"(")
          (setq readret (eval-string (append "'" readstr))))
      (true
         (setq readret (sym readstr)))))

(reader "(2 + 3)" expr)
;-> (2 + 3)

(reader "((5.2 add 3.3) add 2)" expr)
;-> ((5.2 add 3.3) add 2)

Adesso scriviamo una semplice funzione che imposta il nostro ciclo REPL:

(define (calc-repl)
  (print "infix: ") ; Stampa il nostro prompt "infix: "
  (print (eval (infix (reader (read-line))))) ; READ-EVAL-PRINT
  (println "") ; Stampa un newline
  (calc-repl)) ; LOOP

Eseguiamo la nostra REPL di calcolo e valutiamo alcune espressioni:

(calc-repl)
;-> infix:
(2 + 3)
;-> 5
;-> infix:
((2.2 div 1.1) mul ((4 + 3) div 3.5))
;-> 4
;-> infix:
((2.2 div 1.1) mul 2.3)
;-> 4.6
;-> infix:

Premere Ctrl+C per uscire dalla REPL.


--------------------
Vincere 2 volte su 3
--------------------

Eva, Vero e Vale sono tre giocatrici di scacchi. Vero è più forte di Eva che, a sua volta, è più forte di Vale.
Un giorno Vale scommette una pizza con Eva se questa riesce a vincere 2 partite consecutive su 3 partite di scacchi contro Vero e Vale. Inoltre Vale permette a Eva di scegliere con chi giocare per prima. In altre parole la sfida (che consiste in tre partite) può avvenire in due modi diversi:

1) (Eva-Vale) (Eva-Vero) (Eva-Vale) oppure
2) (Eva-Vero) (Eva-Vale) (Eva-Vero)

Contro chi dovrebbe giocare Eva per prima per massimizzare le sue probabilità di vincere con entrambe le avversarie?

Per vincere la scommessa Eva deve sicuramente vincere la seconda partita (altrimenti non riuscirà mai a battere tutti e due gli avversari con tre partite, cioè non riesce a vincere due partite consecutive)

Supponiamo che la probabilità di Eva di battere Vero valga p1 con (p1 < 0.5) (cioè Vero è più forte di Eva) e la probabilità di Eva di battere Vale valga p2 (cioè Eva è più forte di Vale).
La probabilità di successo di Eva è data dalla somma delle probabilità di tutti gli eventi favorevoli.
Gli eventi favorevoli sono i tre seguenti:

1) Eva tutte e tre le partite:              --->  (p1) * (p2) * (1 - p1)
2) Eva vince la seconda e la terza partita: --->  (1 - p1) * (p2) * (p1)
3) Eva vince la prima e la seconda partita: ---=> (p1) * (p2) * (p1)

Quindi la probabilità totale di successo vale:

prob = g1 + g2 + g3

Possiamo scrivere una funzione che ci permette di calcolare questa probabilità al variare dei due modi di gioco.

(define (prob p1 p2)
  (local (g1 g2 g3)
    (setq g1 (mul p1 p2 (sub 1 p1)))
    (setq g2 (mul (sub 1 p1) p2 p1))
    (setq g3 (mul p1 p2 p1))
    ;(println g1 { } g2 { } g3 { -> } (add g1 g2 g3))
    (add g1 g2 g3)))

Adesso assegniamo i valori alle probabilità di vittoria per ogni singolo incontro:
poichè Vero è più forte di Eva, allora p1 deve essere minore di 0.5 (es. 0.4)
poichè Eva è più forte di Vale, allora p2 deve essere maggiore di 0.5 (es. 0.6)

Vediamo il risultato quando Eva gioca prima con Vale poi con Vero e infine con Vale:

(prob 0.6 0.4)
;-> 0.336

Vediamo il risultato quando Eva gioca prima con Vero e poi con Vale e infine con Vero:

(prob 0.4 0.6)
;-> 0.384

Cosa??? Questo risultato indica che per Eva la probabilità di vittoria della scommessa è maggiore se gioca due volte contro la giocatrice più forte (Vero). Il risultato è controintuitivo, ma è corretto al 100%.

Proviamo con altri valori di probabilità (0.8 e 0.2):

(prob 0.8 0.2)
;-> 0.192

(prob 0.2 0.8)
;-> 0.288

Proviamo a verificare il risultato matematico con una simulazione:

(define (simula p1 p2 iter)
  (local (g must tot)
    (setq tot 0)
    (for (i 1 iter)
      (setq must nil)
      (setq g 0)
      ; game 1
      (if (> (random) p1) (++ g))
      ; game 2
      (if (> (random) p2) (setq must true g (+ g 1)))
      ; game 3
      (if (> (random) p1) (++ g))
      ; obiettivo raggiunto?
      ; vinto due partite (di cui una è la seconda)?
      (if (and must (> g 1)) (++ tot))
    )
    (div tot iter)))

(simula 0.4 0.6 1e6)
;-> 0.336288
(simula 0.6 0.4 1e6)
;-> 0.383391

(simula 0.8 0.2 1e6)
;-> 0.288874
(simula 0.2 0.8 1e6)
;-> 0.192069

I risultati della simulazione confermano totalmente i risultati matematici.


----------------------
Investimenti in comune
----------------------

Due amici Tom e Jerry comprano insieme 3 villette al prezzo totale di 800.000 euro.
Tom investe 500.000 euro e Jerry 300.000. Dopo poco tempo decidono di tenersi una villetta ciascuno e di vendere la terza per la somma di 800.000 euro. Come devono essere ripartiti questi 800.000 euro tra Tom e Jerry?

La risposta ovvia è: 500.000 euro a Tom e 300.000 a Jerry. Ma è una risposta sbagliata!
Vediamo perchè:

Ogni villetta costa: (800000 / 3) = 266666.6666666667 euro

In totale Tom ha pagato 500000 euro e ha ricevuto una villetta da 266666.6666666667 euro.
Quindi Tom ha investito (500000 - 266666.6666666667) = 233333.3333333333 per la terza villetta.

In totale Jerry ha pagato 300000 euro e ha ricevuto una villetta da 266666.6666666667 euro.
Quindi Jerry ha investito (300000 - 266666.6666666667) = 33333.33333333331 per la terza villetta.

Il rapporto (266666.6666666667 / 33333.33333333331) vale 7, cioè Tom ha investito 7 volte il denaro di Jerry. Quindi la suddivisione degli 800.000 euro ricavati dalla vendita della terza villetta devono essere ripartiti in questo modo:
700.000 euro a Tom e 100.000 euro a Jerry.

Nota: la risposta ovvia (500.000 euro a Tom e 300.000 a Jerry) è sbagliata se tutto l'affare viene considerato come un investimento. Se invece consideriamo la differenza iniziale come un prestito senza interessi di Tom a Jerry, allora la risposta è corretta (infatti alla fine ognuno ha una villetta senza spendere nulla).


-----------------
Dadi intransitivi
-----------------

Un insieme di dadi è intransitivo (o non-transitivo) se contiene tre dadi, A, B e C, con la proprietà che A maggiore di B più della metà delle volte, B maggiore di C più della metà delle volte, C maggiore di A più della metà delle volte. In altre parole, una serie di dadi è intransitiva se la relazione binaria - X tira un numero maggiore di Y più della metà delle volte - sui suoi elementi non è transitiva.

Nota: Usando un tale insieme di dadi, si possono inventare giochi con risultati probabilistici inaspettati.

Esempio:
Consideriamo il seguente insieme di dadi

Il dado A ha i numeri: 2, 2, 4, 4, 9, 9.
Il dado B ha i numeri: 1, 1, 6, 6, 8, 8.
Il dado C ha i numeri: 3, 3, 5, 5, 7, 7.

La probabilità che A ottenga un numero maggiore di B, la probabilità che B ottenga un numero maggiore di C e la probabilità che C ottenga un numero maggiore di A vale 5/9, quindi questo insieme di dadi è intransitivo. In effetti, ha la proprietà ancora più forte che, per ogni dado, c'è un altro dado che tira un numero maggiore di quello più della metà delle volte.

Vediamo come calcolare questa probabilità (5/9):

(setq A '(2 2 4 4 9 9))
(setq B '(1 1 6 6 8 8))
(setq C '(3 3 5 5 7 7))

                numero eventi favorevoli
Probabilità = ----------------------------
                numero eventi possibili

Prodotto cartesiano tra due liste:

(define (prod-cart lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

Lista di tutti gli eventi possibili (ogni elemento della lista rappresenta un lancio e contiene i valori dei dadi A e B):

(setq eventi (prod-cart A B))
;-> ((2 1) (2 1) (2 6) (2 6) (2 8) (2 8) (2 1) (2 1) (2 6) (2 6) (2 8)
;->  (2 8) (4 1) (4 1) (4 6) (4 6) (4 8) (4 8) (4 1) (4 1) (4 6) (4 6)
;->  (4 8) (4 8) (9 1) (9 1) (9 6) (9 6) (9 8) (9 8) (9 1) (9 1) (9 6)
;->  (9 6) (9 8) (9 8))

Adesso calcoliamo gli eventi favorevoli a A, quelli favorevoli a B e quelli in parità:

(setq nA 0)
(setq nB 0)
(setq nAB 0)

(dolist (el eventi)
  (cond ((> (el 0) (el 1)) (++ nA))
        ((< (el 0) (el 1)) (++ nB))
        (true (++ nAB))))

(setq num (length eventi))
;-> 36

(list nA (div nA num) nB (div nB num) nAB (div nAB num))
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

(div 5 9)
;-> 0.5555555555555556

Quindi A batte B con probabilità 0.5555... (cioè 5/9).

Scriviamo una funzione che calcola il tutto prendendo come parametri i valori di due dadi:

(define (lancio d1 d2)
  (local (eventi n1 n2 np len)
    (setq n1 0 n2 0 np 0)
    (setq eventi (prod-cart d1 d2))
    (dolist (el eventi)
      (cond ((> (el 0) (el 1)) (++ n1))
            ((< (el 0) (el 1)) (++ n2))
            (true (++ np))))
    (setq len (length eventi))
    (list n1 (div n1 num) n2 (div n2 num) np (div np num))))

Verifichiamo che i tre dadi siano intransitivi:

(lancio A B)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

(lancio B C)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

(lancio C A)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

Un altro insieme di dadi intransitivo è il seguente:

(setq A1 '(2 2 6 6 7 7))
(setq B1 '(1 1 5 5 9 9))
(setq C1 '(3 3 4 4 8 8))

(lancio A1 B1)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

(lancio B1 C1)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

(lancio C1 A1)
;-> (20 0.5555555555555556 16 0.4444444444444444 0 0)

Anche in questo caso la probabilità tra i dadi vale 5/9.

Comunque questi due insiemi non sono equivalenti. Infatti se lanciamo tutti i dadi di un insieme e calcoliamo le probabilità di vincita di ognuno dei dadi otteniamo valori diversi per i due insiemi.

Calcoliamo tutti gli eventi possibili per il lancio di tre dadi:

(setq ev1 (prod-cart A B))
(setq ev2 (prod-cart ev1 C))
(setq eventi (map (fn(x) (list (x 0 0) (x 0 1) (x 1))) ev2))
;-> ((2 1 3) (2 1 3) (2 1 5) (2 1 5) (2 1 7) (2 1 7) (2 1 3)
;->  (2 1 3) (2 1 5) (2 1 5) (2 1 7) (2 1 7) (2 6 3) (2 6 3)
;->  ...
;->  (9 6 7) (9 8 3) (9 8 3) (9 8 5) (9 8 5) (9 8 7) (9 8 7)
;->  (9 8 3) (9 8 3) (9 8 5) (9 8 5) (9 8 7) (9 8 7))

(length eventi)
;-> 216

Calcoliamo le probabilità di vittoria di ognuno dei tre dadi:

(setq evnum (length eventi))
(setq nABC (array 3 '(0)))
(dolist (el eventi)
  (setq valmax (apply max el))
  (++ (nABC (find valmax el))))
(println "A vince " (nABC 0) " volte su " evnum)
(println "B vince " (nABC 1) " volte su " evnum)
(println "C vince " (nABC 2) " volte su " evnum)
;-> A vince 80 volte su 216
;-> B vince 80 volte su 216
;-> C vince 56 volte su 216

Calcoliamo questi valori per il secondo insieme di dadi:

(setq ev1 (prod-cart A1 B1))
(setq ev2 (prod-cart ev1 C1))
(setq eventi (map (fn(x) (list (x 0 0) (x 0 1) (x 1))) ev2))
(setq evnum (length eventi))
(setq nABC (array 3 '(0)))
(dolist (el eventi)
  (setq valmax (apply max el))
  (++ (nABC (find valmax el))))
(println "A1 vince " (nABC 0) " volte su " evnum)
(println "B1 vince " (nABC 1) " volte su " evnum)
(println "C1 vince " (nABC 2) " volte su " evnum)
;-> A1 vince 64 volte su 216
;-> B1 vince 88 volte su 216
;-> C1 vince 64 volte su 216

Quindi i due insiemi di dadi non sono equivalenti.

Dado di Efron
-------------
I dadi di Efron sono un insieme di quattro dadi intransitivi inventati da Bradley Efron.
I quattro dadi A, B, C, D hanno i seguenti numeri sulle sei facce:

A: 4, 4, 4, 4, 0, 0
B: 3, 3, 3, 3, 3, 3
C: 6, 6, 2, 2, 2, 2
D: 5, 5, 5, 1, 1, 1

Ogni dado è battuto dal dado precedente nell'elenco, con una probabilità di 2/3:

P(A>B) = P(B>C) = P(C>D) = P(D>A) = 2/3


---------------------
Il prezzo di un libro
---------------------

Dal libro "The Moscow Puzzles" di Kordemsky.
Il prezzo di un libro è di 10 euro più la metà del suo prezzo di vendita.
Quanto costa il libro?

Questo piccolo puzzle lascia perplesse diverse persone. Alcuni rispondono dicendo che il libro costa 10 euro. Altri che il costo è di 15 euro. La soluzione corretta è che il libro costa 20 euro.
Infatti se poniamo x il costo del libro abbiamo la seguente equazione:

  x = 10 + x/2

da cui si ricava:

  x - x/2 = 10  -->  x/2 = 10  -->  x = 2*10 = 20


-----------------------------
La barca, l'uomo e il mattone
-----------------------------

Un uomo è su una barca a remi che galleggia in un lago.
C'è un mattone nella barca.
Per qualche ragione, l'uomo getta il mattone in acqua.
Il livello dell'acqua del lago rimane lo stesso, sale o scende a causa del fatto che l'uomo ha lanciato il mattone nel lago?

Quando il mattone è nella barca, la quantità di acqua spostata dal mattone è uguale al suo peso.
Quando il mattone viene gettato in mare, la quantità di acqua spostata dal mattone è uguale al suo volume.
Poiché il mattone affonda nell'acqua, sappiamo che il peso specifico del mattone è maggiore di quello dell'acqua. Quindi, il volume d'acqua equivalente alla massa del mattone è maggiore del volume del mattone. Pertanto, quando il mattone viene gettato in acqua, viene spostata meno acqua rispetto a quando il mattone era nella barca (per esempio, supponiamo che il mattone pesa 2 chilogrammi e ha un volume di 1 litro: allora quando il mattone giace all'interno della barca provoca lo spostamento di 2 chilogrammi, cioè di 2 litri di acqua. Invece quando il mattone viene gettato nel lago provoca lo spostamento del proprio volume, cioè di 1 litro d'acqua).
Quindi il livello dell'acqua diminuirà quando il mattone verrà gettato nel lago.


--------------------------------------------
Creare, modificare e restituire una funzione
--------------------------------------------

Crea una semplice funzione all'interno di un'altra funzione e la restituisce:

(define (make-add-one)
  (define (somma x) (+ 1 x))
  somma)

Eseguiamo la funzione:

(make-add-one)
;-> (lambda (x) (+ 1 x))

Adesso possiamo eseguire la funzione creata "somma":
(somma 2)
;-> 3
(somma 5)
;-> 6

Modifichiamo la funzione "somma":

somma
;-> (lambda (x) (+ 1 x))
(last somma)
;-> (+ 1 x)
(nth 1 somma)
;-> (+ 1 x)
(setf (nth 1 somma) '(+ 2 x))
;-> (+ 2 x)
somma
;-> (lambda (x) (+ 2 x))

Adesso la funzione "somma" aggiunge 2 invece di 1:

(somma 3)
;-> 5

Scriviamo una funzione che prende due parametri, il nome della funzione da creare e il parametro della funzione da creare.
Funzione per creare una funzione con nome e parametri:

(define (make-add name val)
  (let (f nil)
    (setq f (string "(define (" name " x) (+ " val " x))"))
    (setq name (eval-string f))
  name))

Creiamo una funzione "somma-10" con parametro 10:

(make-add "somma-10" 10)
(lambda (x) (+ 10 x))

Usiamo la funzione creata "somma-10":

(somma-10 3)
;-> 13

newbert ha proposto il segente metodo alternativo (more lisp-ish):

(define (make-adder x)
  (letex (y x)
    (fn (z) (+ y z))))

Proviamo:

(setq add2 (make-adder 2))
;-> (lambda (z) (+ 2 z))
add2
;-> (lambda (z) (+ 2 z))
(println (add2 4))
;-> 6

Con una macro possiamo anche passare il nome della funzione da creare:

(define-macro (make-adder)
  (local (name val)
    (bind (args) true)
    (set (expand name 'name) (expand (lambda (x) (+ val x)) 'val))))

Proviamo:

(make-adder (name 'add10) (val 10))
;-> (lambda (x) (+ 10 x))
add10
;-> (lambda (x) (+ 10 x))
(println (add10 3))
;-> 13


------------------------
Input utente multi-linea
------------------------

Con la funzione "read-line" possiamo ottenere una stringa di input dall'utente che termina quando premiamo "Invio" (una sola linea di testo). Se vogliamo ottenere una stringa che contiene più linee di testo possiamo usare la seguente funzione che utilizza la primitiva "read-char".

(define (multi-line endchar)
(catch
  (let (out "" ch "")
    (while (setf ch (read-char))
      (if (!= (char ch) endchar)
        (setf out (append out (char ch)))
        (throw out)))
    out)))

Questa funzione prende come parametro un carattere che identifica la fine della stringa e restituisce la stringa inserita (multi-linea):

(multi-line "~")
pippo pluto
topolino minnie
qui quo qua
~
;-> "pippo pluto\r\ntopolino minnie\r\nqui quo qua\r\n"


-----------------------
Distanza dell'orizzonte
-----------------------

La distanza "d" dell'orizzonte da un osservatore (assumendo nessuna rifrazione atmosferica) è data dalla formula:

d = sqrt(2*R*h)

dove:
R = raggio della Terra
h = altezza del punto di osservazione

Assumendo un raggio medio della Terra pari a R = 6.371 chilometri otteniamo:

d(km) ≈ 112.9*sqrt(h(km))

Oppure esprimendo l'altezza h in metri:

d(km) ≈ 3.57*sqrt(h(m))

(define (horizon h)
  (mul 3.57 (sqrt h)))

Vediamo il valore della distanza per una persona (2m), un palazzo di tre piani (10m), una collina (100m), Cingoli (650m) e l'Everest (8850m):

(define (test)
  (println "h(m)  d(km)")
  (dolist (el '(2 10 100 650 8850))
    (println (format "%4d %6.2f" el (horizon el)))))

(test)
;-> h(m)  d(km)
;->    2   5.05
;->   10  11.29
;->  100  35.70
;->  650  91.02
;-> 8850 335.85


-----------
Tic-Tac-Toe
-----------

Tic-Tac-Toe (conosciuto in Italia come "Tris") è un gioco che utilizza una griglia quadrata di 3×3 caselle.
A turno, i giocatori scelgono una casella vuota e vi disegnano il proprio simbolo (di solito un giocatore ha come simbolo il carattere "X" e l'avversario il carttere "O"). Vince il giocatore che riesce a disporre tre dei propri simboli in linea retta orizzontale, verticale o diagonale. Se la griglia viene riempita senza che nessuno dei giocatori sia riuscito a completare una linea retta di tre simboli, il gioco finisce in parità, cioè "patta".

Esempio di partita patta:

  ·---·---·---·
  | O | O | X |
  ·---·---·---·
  | X | X | O |
  ·---·---·---·
  | O | X | X |
  ·---·---·---·

Scriviamo un programma che permette di giocare a Tic-Tac-Toe a due giocatori umani.

Le mosse vengono inserite con un numero da 1 a 9 come nella seguente griglia:

  ·---·---·---·
  | 1 | 2 | 3 |
  ·---·---·---·
  | 4 | 5 | 6 |
  ·---·---·---·
  | 7 | 8 | 9 |
  ·---·---·---·

Funzione che controlla se esiste un vincitore nella griglia passata come parametro (restituisce "X" oppure "O" oppure " "):

(define (check-win b)
  (let (bt (transpose b))
          ; controllo vittoria sulle righe
    (cond ((and (!= " " (b 0 0)) (apply = (b 0))) (b 0 0))
          ((and (!= " " (b 1 0)) (apply = (b 1))) (b 1 0))
          ((and (!= " " (b 2 0)) (apply = (b 2))) (b 2 0))
          ; controllo vittoria sulle colonne
          ((and (!= " " (b 0 0)) (apply = (bt 0))) (b 0 0))
          ((and (!= " " (b 0 1)) (apply = (bt 1))) (b 0 1))
          ((and (!= " " (b 0 2)) (apply = (bt 2))) (b 0 2))
          ;controllo vittoria sulle diagonali
          ((and (!= " " (b 1 1)) (= (b 0 0) (b 1 1) (b 2 2))) (b 1 1))
          ((and (!= " " (b 1 1)) (= (b 0 2) (b 1 1) (b 2 0))) (b 1 1))
          (true " "))))

Funzione che stampa la griglia passata come parametro:

(define (show-board b)
  (println "  ·---·---·---·")
  (println "  | " (b 0 0) " | " (b 0 1) " | " (b 0 2) " |" )
  (println "  ·---·---·---·")
  (println "  | " (b 1 0) " | " (b 1 1) " | " (b 1 2) " |" )
  (println "  ·---·---·---·")
  (println "  | " (b 2 0) " | " (b 2 1) " | " (b 2 2) " |" )
  (println "  ·---·---·---·"))

Funzione che permette di effettuare una mossa da parte di un giocatore:

(define (make-move b p)
  (local (move ok r c grid-move)
    (setq grid-move '((1 (0 0)) (2 (0 1))  (3 (0 2))
                      (4 (1 0)) (5 (1 1))  (6 (1 2))
                      (7 (2 0)) (8 (2 1))  (9 (2 2))))
    (println "Muove: " p)
    (do-while ok
      (setq ok nil)
      (print "Scegliere una casella (1..9): ")
      (setq move (int (read-line)))
      (while (or (< move 1) (> move 9) (not (integer? move)))
          (print "Scegliere una casella (1..9): ")
          (setq move (int (read-line))))
      (setq r (first (lookup move grid-move)))
      (setq c (last (lookup move grid-move)))
      (if (= (b r c) " ")
          (setf (b r c) p)
          (setq ok true))
      (if ok (println "La casella " move " è occupata."))
    )
  b))

Funzione per la gestione completa di una partita di tic-tac-toe:

(define (tic-tac-toe)
  (local (ttt endgame curr-player num-move)
    (setq ttt (array 3 3 '(" ")))
    (setq endgame nil)
    (setq curr-player "X")
    (setq num-move 0)
    (while (not endgame)
      (show-board ttt)
      (setq ttt (make-move ttt curr-player))
      (++ num-move)
      ; controllo vittoria giocatore corrente
      (if (= (check-win ttt) curr-player)
          (begin
            (setq endgame true)
            (show-board ttt)
            (println "Partita terminata:")
            (println "Il giocatore " curr-player " ha vinto."))
          ;else
          ; controllo griglia piena
          (begin
            (if (= num-move 9)
                (begin
                  (setq endgame true)
                  (show-board ttt)
                  (println "Partita terminata: patta")))))
      ; Prossimo giocatore
      (if (not endgame)
          (if (= curr-player "X")
              (setq curr-player "O")
              (setq curr-player "X"))))))

Facciamo una partita:

(tic-tac-toe)
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;-> Muove: X
;-> Scegliere una casella (1..9): 5
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;->   |   | X |   |
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;-> Muove: O
;-> Scegliere una casella (1..9): 1
;->   ·---·---·---·
;->   | O |   |   |
;->   ·---·---·---·
;->   |   | X |   |
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;-> Muove: X
;-> Scegliere una casella (1..9): e
;-> Scegliere una casella (1..9): 3
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;->   |   | X |   |
;->   ·---·---·---·
;->   |   |   |   |
;->   ·---·---·---·
;-> Muove: O
;-> Scegliere una casella (1..9): 7
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;->   |   | X |   |
;->   ·---·---·---·
;->   | O |   |   |
;->   ·---·---·---·
;-> Muove: X
;-> Scegliere una casella (1..9): 4
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;->   | X | X |   |
;->   ·---·---·---·
;->   | O |   |   |
;->   ·---·---·---·
;-> Muove: O
;-> Scegliere una casella (1..9): 6
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;->   | X | X | O |
;->   ·---·---·---·
;->   | O |   |   |
;->   ·---·---·---·
;-> Muove: X
;-> Scegliere una casella (1..9): 9
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;->   | X | X | O |
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;-> Muove: O
;-> Scegliere una casella (1..9): 2
;->   ·---·---·---·
;->   | O | O | X |
;->   ·---·---·---·
;->   | X | X | O |
;->   ·---·---·---·
;->   | O |   | X |
;->   ·---·---·---·
;-> Muove: X
;-> Scegliere una casella (1..9): 8
;->   ·---·---·---·
;->   | O | O | X |
;->   ·---·---·---·
;->   | X | X | O |
;->   ·---·---·---·
;->   | O | X | X |
;->   ·---·---·---·
;-> Partita terminata: patta

Vediamo ora un altro programma che permette di giocare contro il computer. Non è imbattibile, ma è abbastanza forte.

#!/usr/bin/newlisp
#
# An unbeatable TicTacToe. A small study to do AI with newLisp.
#
# Board moves are:
#   1 2 3
#   4 5 6
#   7 8 9
#
# The strategy is twofold:
#	1) Determine priority of preferred moves on board
#	2) Think one move ahead to see if X can make 3-in-a-row
#
# Future improvements: think ahead more.
#
# Version 1.0
# - Initial release
# Version 1.1
# - Fixed bug with playing in corners
# - Code optimizations
#
# June 12, 2005 - PvE.
#
# Version 1.2
# - adapted to newLISP 10.7.5
# - better graphics
# - add main function
#
# May 10, 2021 - cameyo
#
#--------------------------------------------------- Interaction with user
#
# Function to print board on console
(define (print_board)
  (println "╔═══╦═══╦═══╗")
  (for (i 1 9)
		(if (or (= (board i) 'X) (= (board i) 'O))
          (print "║ " (board i) " ")
          (print "║   ")
    )
		(if (= (mod i 3) 0) (begin
      (println "║")
      (if (< i 8)
          (println "╠═══╬═══╬═══╣")
          (println "╚═══╩═══╩═══╝")
      )
    ))
  ))
#
# Function to print board on console
;(define (print_board)
;	(for (n 1 9)
;		(if (and (!= (board n) 'X) (!= (board n) 'O))
;			(print (string n) " ")
;			(print (string (board n)) " "))
;		(if (= (mod n 3) 0) (println))))
#
# Function to get input from user
(define (get_input)
	(print "Enter your move (1..9): ")
	(do-until (and (> input 48)(< input 58))(set 'input (read-key)))
	(println (- input 48)))
#
#--------------------------------------------------- End of game queries
#
# Function to find out if there is a winning position for col X/O
(define (has_won col)
	(catch (dolist (n won)
		(if (= (select board n) col) (throw true)))))
#
# Check if game is at end
(define (game_end)
	(if (has_won '(X X X))
		(begin (print_board)(println "---> X has won! <---") true)
		(if (has_won '(O O O))
			(begin (print_board) (println "---> O has won! <---") true)
			(if (= (find 0 board) nil)
				(begin (print_board) (println "---> Equal game! <---") true) nil))))
#
#--------------------------------------------------- Intelligence starts here
#
# Define preferred moves - sequences need improvement using some maths
(define (set_preferred)
	(catch (dolist (n split)
		(if (= (select board n) '(X X))
			(throw (case n
				((2 4) '(1 5 3 7 9 6 8))
				((2 6) '(3 5 1 7 9 4 8))
				((4 8) '(7 5 9 1 3 2 6))
				((6 8) '(9 5 7 1 3 2 4))
				((1 8) '(4 5 3 7 9 2 6))
				((1 6) '(2 5 3 7 9 4 6))
				((7 6) '(8 5 1 9 3 4 2))
				((7 2) '(4 5 1 9 3 8 2))
				((9 2) '(6 5 7 3 1 4 8))
				((9 4) '(8 5 7 3 1 4 6))
				((3 4) '(2 5 9 1 7 6 8))
				((3 8) '(6 5 9 1 7 2 8)))))
		'(5 1 3 7 9 2 4 6 8))))
#
# Function to play move N with color X/O if legal
(define (validate_input n col)
	(if (and (!= (board n) 'X)(!= (board n) 'O))
		(begin (setf (board n) col) true)))
#
# Think one move ahead by evaluating X
(define (eval_x)
	(set 'res nil)
	(for (l 1 9)
		(if (validate_input l 'X)
			(begin
				(if (has_won '(X X X))
					(begin (setq (board l) 0)
          ;(nth-set l board 0)
          (set 'res true)))
				(setq (board l) 0)))) res)
				;(nth-set l board 0)))) res)
#
# Try next move
(define (next_move)
	(catch (dolist (m (set_preferred))
		(if (validate_input m 'O)
			(if (has_won '(O O O))
				(throw)
				(if (eval_x)
					(setf (board m) 0)
					;(nth-set m board 0)
					(throw)))))))
#
#--------------------------------------------------- Main routine
(define (tic-tac-toe)
  # --- General setup
  # Define winning board positions
  (set 'won '((1 2 3)(4 5 6)(7 8 9)(1 4 7)(2 5 8)(3 6 9)(1 5 9)(3 5 7)))
  # Define split actions
  (set 'split '((2 4)(2 6)(4 8)(6 8)(1 8)(1 6)(7 6)(7 2)(9 2)(9 4)(3 4)(3 8)))
  # Setup board for X and O
  (set 'board '(N 0 0 0 0 0 0 0 0 0))
  # --- Main loop
  (while (not (game_end))
    # Print current situation
    (print_board)
    # Get move
    (while (not (validate_input (get_input) 'X)) (println "Try other move!"))
    # Play move
    (next_move)
  )
  'end)
#--------------------------------------------------- Run game
(tic-tac-toe)
;(exit)
;-> ╔═══╦═══╦═══╗
;-> ║ O ║ X ║ X ║
;-> ╠═══╬═══╬═══╣
;-> ║ X ║ O ║ O ║
;-> ╠═══╬═══╬═══╣
;-> ║ O ║ X ║ X ║
;-> ╚═══╩═══╩═══╝


----------------
Labirinti (Maze)
----------------

Un labirinto è un percorso o un insieme di percorsi, in genere con uno o più ingressi e con nessuna o più uscite.
Per risolvere un labirinto (maze) utilizzeremo due algoritmi.

Algoritmo Casuale del Topo
--------------------------
Questo primo algoritmo è un metodo banale che simula il comportamento di un topo (non intelligente). Si tratta semplicemente di procedere attraverso il labirinto in modo casuale cercando (prima o poi) di raggiungere l'uscita. Sebbene un tale metodo alla fine trova sempre la soluzione giusta, questo algoritmo può essere estremamente lento.

(define (solve-maze-A maze start-row start-col end-row end-col limite show)
  (local (matrix x y row col wall trovato solution-path e-row e-col num-passi out)
    ; lista soluzione percorso
    (setq out '())
    ; matrice labirinto
    (setq matrix maze)
    ; carattere che rappresenta il muro "0"
    (setq wall 0)
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; matrice soluzione del labirinto
    (setq solution-path (array row col '(nil)))
    ; posizione iniziale: riga
    (setq x start-row)
    ; posizione iniziale: colonna
    (setq y start-col)
    ; posizione finale: riga
    (setq e-row end-row)
    ; posizione finale: colonna
    (setq e-col end-col)
    ; numero passi iniziale
    (setq num-passi 0)
    ; Ricerca random della soluzione
    (setq trovato nil)
    (while (and (not trovato) (< num-passi limite))
      (++ num-passi)
      (setf (solution-path x y) true)
      ;controllo se abbiamo raggiunto la fine e non è un muro
      (cond ((and (= x e-row) (= y e-col) (!= (matrix x y) wall))
             (setf (solution-path x y) true)
             (setq trovato true))
      )
      ; Movimento random
      (setq move (amb 1 2 3 4))
      (cond ((= move 1)
             (if (and (!= x 0) (!= (matrix (- x 1) y) wall)) (setq x (- x 1) y y)))
            ((= move 2)
             (if (and (!= x (- row 1)) (!= (matrix (+ x 1) y) wall)) (setq x (+ x 1) y y)))
            ((= move 3)
             (if (and (!= y 0) (!= (matrix x (- y 1)) wall)) (setq x x y (- y 1))))
            ((= move 4)
             (if (and (!= y (- col 1)) (!= (matrix x (+ y 1)) wall)) (setq x x y (+ y 1))))
      )
    )
    (cond ((< num-passi limite)
           ; Se show = true --> stampa la soluzione
           (if show (begin
               (show-aux solution-path)
               (println "Passi: " num-passi)))
           ; crea la lista con il percorso risolutivo
           (for (i 0 (- row 1))
             (for (j 0 (- col 1))
               (if (solution-path i j)
                   (push (list i j) out -1)))))
          (true
           (setq out nil)
           (println "Limite raggiunto."))
    )
    out))

(define (show-aux path)
  (local (row col)
    ; righe della matrice
    (setq row (length path))
    ; colonne della matrice
    (setq col (length (first path)))
    ; stampa
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        ;(if (matrix i j) (print " ·") (print " 0"))
        ;(if (path i j) (print " ·") (print " " (matrix i j)))
        (if (path i j) (print " ■") (print " " (matrix i j)))
      )
      (println))))

Esempio 1:
; definizione labirinto (1 = libero, 0 = muro)
(setq righe 5)
(setq colonne 4)
(setq matrice (array righe colonne '(
  1 1 1 0
  0 0 1 1
  1 0 0 1
  0 0 0 1
  1 1 1 1)))

(solve-maze-A matrice 0 0 4 3 1000 true)
;->  ■ ■ ■ 0
;->  0 0 ■ ■
;->  1 0 0 ■
;->  0 0 0 ■
;->  1 1 1 ■
Passi: 16
;-> ((0 0) (0 1) (0 2) (1 2) (1 3) (2 3) (3 3) (4 3))
(solve-maze-A matrice 0 0 4 3 1000)
;-> ((0 0) (0 1) (0 2) (1 2) (1 3) (2 3) (3 3) (4 3))

Esempio 2:
; definizione labirinto
(setq righe 12)
(setq colonne 20)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 1 0 1 0 1 0 1 0 0 1 1 1 0
 0 1 1 1 0 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0
 0 1 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1
 0 1 1 1 1 1 0 0 0 1 1 1 1 0 0 0 1 0 1 0
 1 0 0 0 0 1 0 0 1 0 1 0 1 0 0 1 1 0 0 0
 1 0 0 0 0 1 1 1 1 0 1 0 1 0 0 1 1 0 0 0
 1 0 0 0 0 0 0 0 1 0 1 0 1 0 0 1 0 1 0 0
 1 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 1 0 0
 1 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 0 1 1 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1)))

(solve-maze matrice 0 0 11 19 10000 true)
;-> ■ ■ 0 ■ 0 1 1 1 0 1 0 1 0 1 0 0 1 1 1 0
;-> 0 ■ ■ ■ 0 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0
;-> 0 ■ 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1
;-> 0 ■ ■ ■ ■ ■ 0 0 0 ■ ■ ■ ■ 0 0 0 ■ 0 1 0
;-> 1 0 0 0 0 ■ 0 0 ■ 0 ■ 0 ■ 0 0 ■ ■ 0 0 0
;-> 1 0 0 0 0 ■ ■ ■ ■ 0 ■ 0 ■ 0 0 ■ ■ 0 0 0
;-> 1 0 0 0 0 0 0 0 ■ 0 ■ 0 ■ 0 0 ■ 0 ■ 0 0
;-> 1 0 0 0 0 0 0 0 ■ ■ ■ 0 ■ 0 0 ■ ■ ■ 0 0
;-> 1 0 0 0 0 0 0 0 ■ 0 0 0 ■ ■ ■ ■ 0 ■ ■ ■
;-> 1 0 0 0 0 0 0 0 ■ 0 0 0 ■ 0 0 ■ 0 0 0 ■
;-> 1 0 0 0 0 0 0 0 ■ 0 0 0 ■ 0 0 ■ 0 0 0 ■
;-> 1 0 0 0 0 0 0 0 ■ 0 0 0 1 0 0 ■ 0 0 0 ■
;-> Passi: 3277
;-> ((0 0) (0 1) (0 3) (1 1) (1 2) (1 3) (2 1) (3 1) (3 2) (3 3) (3 4)
;->  (3 5) (3 9) (3 10) (3 11) (3 12) (3 16) (4 5) (4 8) (4 10) (4 12)
;->  (4 15) (4 16) (5 5) (5 6) (5 7) (5 8) (5 10) (5 12) (5 15) (5 16)
;->  (6 8) (6 10) (6 12) (6 15) (6 17) (7 8) (7 9) (7 10) (7 12) (7 15)
;->  (7 16) (7 17) (8 8) (8 12) (8 13) (8 14) (8 15) (8 17) (8 18)
;->  (8 19) (9 8) (9 12) (9 15) (9 19) (10 8) (10 12) (10 15) (10 19)
;->  (11 8) (11 15) (11 19))

Esempio 3:
; definizione labirinto
(setq righe 9)
(setq colonne 9)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 1 0
 0 1 1 1 0 0 1 1 1
 0 1 0 0 0 0 0 1 1
 0 1 1 1 1 1 0 0 0
 1 0 0 0 0 1 0 0 1
 1 0 0 0 0 1 0 1 1
 1 0 0 0 0 0 0 0 1
 1 0 0 0 0 0 0 0 1
 1 0 0 0 0 0 0 0 1)))

La seguente chiamata non ha soluzione:

(solve-maze-A matrice 0 0 8 8 100000 true)
;-> Limite raggiunto
;-> nil

(solve-maze-A matrice 0 0 5 5 10000 true)
;-> ■ ■ 0 ■ 0 1 1 1 0
;-> 0 ■ ■ ■ 0 0 1 1 1
;-> 0 ■ 0 0 0 0 0 1 1
;-> 0 ■ ■ ■ ■ ■ 0 0 0
;-> 1 0 0 0 0 ■ 0 0 1
;-> 1 0 0 0 0 ■ 0 1 1
;-> 1 0 0 0 0 0 0 0 1
;-> 1 0 0 0 0 0 0 0 1
;-> 1 0 0 0 0 0 0 0 1
;-> Passi: 331
;-> ((0 0) (0 1) (0 3) (1 1) (1 2) (1 3) (2 1) (3 1) (3 2)
;->  (3 3) (3 4) (3 5) (4 5) (5 5))

Esempio 4:
; definizione labirinto
(setq righe 9)
(setq colonne 9)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 0 1
 0 1 1 1 0 0 1 1 1
 0 1 0 0 0 0 0 1 0
 0 1 1 1 1 1 0 1 1
 1 0 0 0 0 1 0 0 1
 1 0 0 0 0 1 1 1 1
 1 1 1 1 1 0 1 0 1
 1 0 0 0 1 0 1 0 1
 1 0 0 0 1 1 1 0 1)))

(solve-maze-A matrice 8 0 0 8 10000 true)
;-> 1 1 0 1 0 1 1 0 ■
;-> 0 1 1 1 0 0 1 ■ ■
;-> 0 1 0 0 0 0 0 ■ 0
;-> 0 1 1 1 1 1 0 ■ ■
;-> ■ 0 0 0 0 ■ 0 0 ■
;-> ■ 0 0 0 0 ■ ■ ■ ■
;-> ■ ■ ■ ■ ■ 0 ■ 0 ■
;-> ■ 0 0 0 ■ 0 ■ 0 1
;-> ■ 0 0 0 ■ ■ ■ 0 1
;-> Passi: 1650
;-> ((0 8) (1 7) (1 8) (2 7) (3 7) (3 8) (4 0) (4 5) (4 8) (5 0) (5 5)
;->  (5 6) (5 7) (5 8) (6 0) (6 1) (6 2) (6 3) (6 4) (6 6) (6 8) (7 0)
;->  (7 4) (7 6) (8 0) (8 4) (8 5) (8 6))

Algoritmo ricorsivo
--------------------
Il secondo algoritmo trova la soluzione (se esiste) in modo ricorsivo. Si parte da un valore iniziale X e Y. Se i valori X e Y non sono su un muro, il metodo (funzione) richiama se stesso con tutti i valori X e Y adiacenti, assicurandosi di non aver utilizzato in precedenza quei valori X e Y. Se i valori X e Y sono quelli della posizione finale, salva tutte le istanze precedenti del metodo (risultati parziali) creando una matrice con il percorso risolutivo.
Questo algoritmo non garantisce che la soluzione trovata sia quella più breve.
Nota: In sostanza si tratta di una ricerca depth-first espressa in termini di celle della matrice.

(define (solve-maze maze start-row start-col end-row end-col show)
  (local (matrix row col wall visited solution-path s-row s-col e-row e-col out)
    ; lista soluzione percorso
    (setq out '())
    ; matrice labirinto
    (setq matrix maze)
    ; carattere che rappresenta il muro "0"
    (setq wall 0)
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; matrice delle celle visitate
    (setq visited (array row col '(nil)))
    ; matrice soluzione del labirinto
    (setq solution-path (array row col '(nil)))
    ; posizione iniziale: riga
    (setq s-row start-row)
    ; posizione iniziale: colonna
    (setq s-col start-col)
    ; posizione finale: riga
    (setq e-row end-row)
    ; posizione finale: colonna
    (setq e-col end-col)
    ;
    ; funzione recursive solve
    ;
    (define (recursive-solve x y)
      (catch
        (local (return)
          ;controllo se abbiamo raggiunto la fine e non è un muro
          (if (and (= x e-row) (= y e-col) (!= (matrix x y) wall))
              (throw (setf (solution-path x y) true))
          )
          ; cella muro o cella visitata
          (if (or (= (matrix x y) wall) (= (visited x y) true)) (throw nil))
          ; imposta cella come visitata
          (setf (visited x y) true)
          ; controllo posizione riga 0
          (if (!= x 0)
              ; richiama la funzione una riga in basso
              (if (recursive-solve (- x 1) y)
                  (throw (setf (solution-path x y) true))
              )
          )
          ; controllo posizione riga (row - 1)
          (if (!= x (- row 1))
              ; richiama la funzione una riga in alto
              (if (recursive-solve (+ x 1) y)
                  (throw (setf (solution-path x y) true))
              )
          )
          ; controllo posizione colonna 0
          (if (!= y 0)
              ; richiama la funzione una colonna a sinistra
              (if (recursive-solve x (- y 1))
                  (throw (setf (solution-path x y) true))
              )
          )
          ; controllo posizione colonna (col - 1)
          (if (!= y (- col 1))
              ; richiama la funzione una colonna a destra
              (if (recursive-solve x (+ y 1))
                  (throw (setf (solution-path x y) true))
              )
          )
          return))
    ); recursive-solve
    ;
    ; Chiama la funzione ricorsiva di soluzione
    ; Se (recursive-solve s-row s-col) ritorna nil,
    ; allora il labirinto non ha soluzione.
    ; Altrimenti la matrice booleana "solution-path"
    ; contiene la soluzione (valori true).
    (if (recursive-solve s-row s-col)
        (begin
          ; Se show = true --> stampa la soluzione
          (if show (show-aux solution-path))
          ; crea la lista con il percorso risolutivo
          (for (i 0 (- row 1))
            (for (j 0 (- col 1))
              (if (solution-path i j)
                  (push (list i j) out -1)))))
    )
    out))

(define (show-aux path)
  (local (row col)
    ; righe della matrice
    (setq row (length path))
    ; colonne della matrice
    (setq col (length (first path)))
    ; stampa
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        ;(if (matrix i j) (print " ·") (print " 0"))
        ;(if (path i j) (print " ·") (print " " (matrix i j)))
        (if (path i j) (print " ■") (print " " (matrix i j)))
      )
      (println))))

Esempio 1:
; definizione labirinto (1 = libero, 0 = muro)
(setq righe 5)
(setq colonne 4)
(setq matrice (array righe colonne '(
  1 1 1 0
  0 0 1 1
  1 0 0 1
  0 0 0 1
  1 1 1 1)))

(solve-maze matrice 0 0 4 3 true)
;->  ■ ■ ■ 0
;->  0 0 ■ ■
;->  1 0 0 ■
;->  0 0 0 ■
;->  1 1 1 ■
;-> ((0 0) (0 1) (0 2) (1 2) (1 3) (2 3) (3 3) (4 3))
(solve-maze matrice 0 0 4 3)
;-> ((0 0) (0 1) (0 2) (1 2) (1 3) (2 3) (3 3) (4 3))

Esempio 2:
; definizione labirinto
(setq righe 12)
(setq colonne 20)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 1 0 1 0 1 0 1 0 0 1 1 1 0
 0 1 1 1 0 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0
 0 1 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1
 0 1 1 1 1 1 0 0 0 1 1 1 1 0 0 0 1 0 1 0
 1 0 0 0 0 1 0 0 1 0 1 0 1 0 0 1 1 0 0 0
 1 0 0 0 0 1 1 1 1 0 1 0 1 0 0 1 1 0 0 0
 1 0 0 0 0 0 0 0 1 0 1 0 1 0 0 1 0 1 0 0
 1 0 0 0 0 0 0 0 1 1 1 0 1 0 0 1 1 1 0 0
 1 0 0 0 0 0 0 0 1 0 0 0 1 1 1 1 0 1 1 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1
 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 1)))

(solve-maze matrice 0 0 11 19 true)
;-> ■ ■ 0 1 0 1 1 1 0 1 0 1 0 1 0 0 1 1 1 0
;-> 0 ■ 1 1 0 0 1 1 1 1 1 0 0 1 1 1 1 1 0 0
;-> 0 ■ 0 0 0 0 0 1 1 0 0 0 1 0 0 0 0 1 0 1
;-> 0 ■ ■ ■ ■ ■ 0 0 0 1 ■ ■ ■ 0 0 0 1 0 1 0
;-> 1 0 0 0 0 ■ 0 0 1 0 ■ 0 ■ 0 0 1 1 0 0 0
;-> 1 0 0 0 0 ■ ■ ■ ■ 0 ■ 0 ■ 0 0 1 1 0 0 0
;-> 1 0 0 0 0 0 0 0 ■ 0 ■ 0 ■ 0 0 1 0 1 0 0
;-> 1 0 0 0 0 0 0 0 ■ ■ ■ 0 ■ 0 0 ■ ■ ■ 0 0
;-> 1 0 0 0 0 0 0 0 1 0 0 0 ■ ■ ■ ■ 0 ■ ■ ■
;-> 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 ■
;-> 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 ■
;-> 1 0 0 0 0 0 0 0 1 0 0 0 1 0 0 1 0 0 0 ■
;-> ((0 0) (0 1) (1 1) (2 1) (3 1) (3 2) (3 3) (3 4) (3 5) (3 10) (3 11)
;->  (3 12) (4 5) (4 10) (4 12) (5 5) (5 6) (5 7) (5 8) (5 10) (5 12)
;->  (6 8) (6 10) (6 12) (7 8) (7 9) (7 10) (7 12) (7 15) (7 16) (7 17)
;->  (8 12) (8 13) (8 14) (8 15) (8 17) (8 18) (8 19) (9 19) (10 19)
;->  (11 19))

Esempio 3:
; definizione labirinto
(setq righe 9)
(setq colonne 9)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 1 0
 0 1 1 1 0 0 1 1 1
 0 1 0 0 0 0 0 1 1
 0 1 1 1 1 1 0 0 0
 1 0 0 0 0 1 0 0 1
 1 0 0 0 0 1 0 1 1
 1 0 0 0 0 0 0 0 1
 1 0 0 0 0 0 0 0 1
 1 0 0 0 0 0 0 0 1)))

(solve-maze matrice 0 0 8 8 true)
;-> ()
Nessuna soluzione.

(solve-maze matrice 0 0 5 5 true)
;-> ■ ■ 0 1 0 1 1 1 0
;-> 0 ■ 1 1 0 0 1 1 1
;-> 0 ■ 0 0 0 0 0 1 1
;-> 0 ■ ■ ■ ■ ■ 0 0 0
;-> 1 0 0 0 0 ■ 0 0 1
;-> 1 0 0 0 0 ■ 0 1 1
;-> 1 0 0 0 0 0 0 0 1
;-> 1 0 0 0 0 0 0 0 1
;-> 1 0 0 0 0 0 0 0 1
;-> ((0 0) (0 1) (1 1) (2 1) (3 1) (3 2) (3 3) (3 4) (3 5) (4 5) (5 5))

Esempio 4:
; definizione labirinto
(setq righe 9)
(setq colonne 9)
(setq matrice (array righe colonne '(
 1 1 0 1 0 1 1 0 1
 0 1 1 1 0 0 1 1 1
 0 1 0 0 0 0 0 1 0
 0 1 1 1 1 1 0 1 1
 1 0 0 0 0 1 0 0 1
 1 0 0 0 0 1 1 1 1
 1 1 1 1 1 0 1 0 1
 1 0 0 0 1 0 1 0 1
 1 0 0 0 1 1 1 0 1)))

(solve-maze matrice 8 0 0 8 true)
;-> 1 1 0 1 0 1 1 0 ■
;-> 0 1 1 1 0 0 1 ■ ■
;-> 0 1 0 0 0 0 0 ■ 0
;-> 0 1 1 1 1 1 0 ■ ■
;-> 1 0 0 0 0 1 0 0 ■
;-> 1 0 0 0 0 1 ■ ■ ■
;-> ■ ■ ■ ■ ■ 0 ■ 0 1
;-> ■ 0 0 0 ■ 0 ■ 0 1
;-> ■ 0 0 0 ■ ■ ■ 0 1
;-> ((0 8) (1 7) (1 8) (2 7) (3 7) (3 8) (4 8) (5 6) (5 7) (5 8) (6 0) (6 1)
;->  (6 2) (6 3) (6 4) (6 6) (7 0) (7 4) (7 6) (8 0) (8 4) (8 5) (8 6))


------------------
Progettare TinyURL
------------------

Problema:
Come progettare un servizio di semplificazione/accorciamento degli URL simile a TinyURL?

Nota: TinyURL è un servizio web di semplificazione URL in cui inserisci un URL come https://projecteuler.net/ e restituisce un URL breve come https://tinyurl.com/4j66fhmw.

L'identificatore (4j66fhmw) può essere qualsiasi stringa con 6 caratteri alfanumerici contenente 0-9, a-z, A-Z. Ogni URL abbreviato deve essere univoco (ovvero, non è possibile abbreviare due URL diversi con lo stesso URL). Di seguito sono riportate solo alcune domande per iniziare. Nel mondo reale, potrebbero esserci molti problemi e domande possibili.

Domande:
Quanti identificatori univoci possibili?
Potremmo rimanere senza URL univoci?
L'identificatore dovrebbe essere incrementato o no?
Quale è più facile da progettare? Pro e contro?
Mappatura di un identificatore a un URL e sua inversione: questo problema ti suona un campanello?
Come memorizzi gli URL? Un semplice database flat-file è sufficiente?
Qual è il collo di bottiglia del sistema? È oneroso in lettura o in scrittura?
Stimare il numero massimo di URL che una singola macchina può memorizzare.
Stimare il numero massimo di query al secondo (QPS) per la decodifica di un URL abbreviato in una singola macchina.
Come ridimensioneresti il ​​servizio? Ad esempio, un collegamento "virale" condiviso nei social media potrebbe comportare un picco di QPS in qualche momento.
Come potresti gestire la ridondanza? (Per esempio, se un server non funziona, come puoi assicurarti che il servizio rimanga ancora operativo?)
Conservare gli URL per sempre o eliminarli, pro e contro? Come si fa la potatura?
Quale API fornireste a uno sviluppatore di terze parti?
Se puoi abilitare la memorizzazione nella cache, cosa memorizzerai nella cache e qual è il tempo di scadenza?

Implementazione:
Scrivere i metodi di codifica e decodifica per il servizio TinyURL. Non ci sono restrizioni su come dovrebbe funzionare l'algoritmo di codifica/decodifica. Bisogna solo assicurarsi che un URL possa essere codificato in un tiny URL e che il tiny URL possa essere decodificato nell'URL originale.

Definiamo due hash-map:

; Long2Short
(new Tree 'LS)
; Short2Long
(new Tree 'SL)

Funzione di codifica della url in tiny-url:

(define (tiny-encode url)
  (local (continua out)
          ; se url esiste nella hash-map,
          ; allora restituisco il valore memorizzato
    (cond ((LS (string url))
           (setq out (LS (string url))))
          ; se url non esiste nella hash map
          ; allora genera una tiny-url valida
          (true
           (setq out "")
           (setq continua true)
           (while continua
             (setq out (make-random))
             ; se la stringa casuale non esiste nella hash-map,
             ; allora inserisco i valori nelle hash-map e
             ; termina il ciclo (continua = nil)
             ; altrimenti continua il ciclo
             ; per generare una nuova stringa casuale
             (if (nil? (SL out)) (begin
                 (SL out url)
                 (LS url out)
                 (setq continua nil)))
           )
          )
    )
    out))

Funzione che crea una stringa casuale di 6 caratteri:

(define (make-random)
  (local (str base)
    (setq base "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    (seed (time-of-day))
    (setq str "https://myURL.com/")
    (for (i 0 5)
      (extend str (base (rand 62)))
    )
    str))

(tiny-encode "www.google.com")
"https://myURL.com/UJFmVp"
(tiny-encode "www.pippo.com")
"https://myURL.com/cwpfzB"

Funzione di decodifica da tiny-url a url:

(define (tiny-decode tiny-url)
  (if (SL tiny-url)
      (SL tiny-url)
      nil))

(tiny-decode "https://myURL.com/UJFmVp")
;-> "www.google.com"

(tiny-decode "https://myURL.com/cwpfzB")
;-> "www.pippo.com"

(tiny-decode "https://myURL.com/123abc")
;-> nil


---------------------
Costante di Ramanujan
---------------------

e^(π*√163) = 262537412640768743.999999999999250072597198185688879353856337336990862707537410
(setq R 262537412640768743.999999999999250072597198185688879353856337336990862707537410)

(constant (global 'E)   2.7182818284590451)
(constant (global 'PI)  3.1415926535897931)
(setq rama (pow E (mul PI (sqrt 163))))
;-> 2.625374126407677e+017
(println (format "%36.18f" rama))
;-> 262537412640767710.000000000000000000

(sub R rama)
;-> 1024

(setq eulero (exp 1))
(setq pigreco (mul 2.0 (acos 0.0)))
(setq rama1 (pow eulero (mul pigreco (sqrt 163))))
;-> 2.625374126407677e+017
(println (format "%36.18f" rama1))
;-> 262537412640767710.000000000000000000

(sub R rama1)
;-> 1024

(= rama rama1)
;-> true

Avremmo bisogno di una libreria floating-point a multipla precisione...


-------------------------
Giustificazione del testo
-------------------------

Data una lista di parole e una lunghezza L, formattare il testo in modo che ogni riga contenga esattamente L caratteri e sia completamente giustificata (a sinistra e a destra). Le parole dovrebbero essere inserite con un approccio "avido" (greedy), cioè bisogna inseire quante più parole è possibile in ogni riga. Aggiungere spazi aggiuntivi, quando necessario, in modo che ogni riga abbia esattamente L caratteri.

Gli spazi aggiuntivi tra le parole dovrebbero essere distribuiti nel modo più uniforme possibile. Se il numero di spazi su una riga non si divide equamente tra le parole, agli slot vuoti a sinistra verranno assegnati più spazi rispetto agli slot a destra. L'ultima riga di testo e le righe con una sola parola, devono essere giustificate a sinistra e non bisogna inserire spazi aggiuntivi tra le parole.

L'algoritmo di soluzione è spiegato nei commenti della funzione.

(define (giustifica-testo parole L)
  (local (linee indice conta succ riga diff spazi resto continua)
    ; Output: linee di testo giustificate
    (setq linee '())
    ; Indice della parola corrente
    (setq indice 0)
    ; Ciclo per ogni parola
    (while (< indice (length parole))
      ; Numero di lettere della parola corrente (lunghezza)
      (setq conta (length (parole indice)))
      ; Indice della parola successiva
      (setq succ (+ indice 1))
      ; Ciclo per trovare le parole che entrano in una riga, cioè
      ; la somma della loro lunghezza è minore di L
      ; Valore boolean per terminare la ricerca
      (setq continua true)
      (while (and (< succ (length parole)) continua)
        ; Se superiamo la lunghezza massima di caratteri in una riga...
        (cond ((> (+ (length (parole succ)) conta 1) L)
               ; allora ci fermiamo
               (setq continua nil))
               (true
                ; altrimenti aumentiamo la quantità di caratteri
                ; e passiamo alla parola successiva
                (setq conta (+ conta (length (parole succ)) 1))
                (++ succ))
        )
      )
      ; Ora abbiamo le parole per ogni riga, quindi
      ; dobbiamo aggiungere gli spazi tra le parole.
      ; Ci sono due situazioni da considerare:
      ; 1) Se siamo sull'ultima riga, la riga non deve essere giustificata
      ;    e nessuno spazio aggiuntivo deve essere inserito tra le parole
      ; 2) Se il numero di spazi su una riga non si divide equamente,
      ;    gli spazi vuoti a sinistra saranno maggiori degli spazi a destra.
      ; Linea finale da aggiungere alla lista linee
      (setq riga "")
      ; Differenza del numero di parole
      ; tra la prima e l'ultima parola della riga
      (setq diff (- succ indice 1))
            ; Se siamo sull'ultima riga
            ; o se c'è una sola parola nella riga ...
      (cond ((or (= succ (length parole)) (= diff 0))
             ; Allora giustifichiamo a sinistra
             ; scorrendo le parole della riga
             ; (con gli indici "indice" e "succ")
             ; e aggiungendo uno spazio dopo ogni parola
             (for (i indice (- succ 1))
               (extend riga (parole i) " ")
             )
             ; Abbiamo aggiunto uno spazio extra alla fine
             ; quindi lo rimuoveremo utilizzando la funzione slice.
             (setq riga (slice riga 0 (- (length riga) 1)))
             ; Ora bisogna aggiungere spazi per riempire il resto della riga
             (for (i (length riga) (- L 1))
               (extend riga " ")
             )
            )
            ; Altrimenti trattiamo le altre righe che
            ; devono essere giustificate a destra e sinistra
            (true
              ; Numero di spazi già presenti nella riga
              ; (massimo dei caratteri meno
              ; il numero di caratteri delle parole,
              ; il tutto diviso per la differenza)
              (setq spazi (/ (- L conta) diff))
              ; Numero spazi da aggiungere: (L - count) % difference)
              (setq resto (% (- L conta) diff))
              ; Ciclo sulle parole della riga per aggiungerle
              ; (con gli indici "indice" e "succ")
              (for (i indice (- succ 1))
                (extend riga (parole i))
                ; Se non è l'ultima parola..
                (if (< i (- succ 1))
                    ; allora calcoliamo il numero degli spazi da aggiungere,
                    ; utilizzando la variabile resto,
                    ; e poi li aggiungiamo alla riga
                    (begin
                    (if (< (- i indice) resto)
                        (setq limit (+ spazi 1))
                        (setq limit spazi)
                    )
                    (for (j 0 limit)
                      (extend riga " ")
                    )
                ))
              )
            )
      )
      ; Aggiunge la linea corrente alla lista delle linee
      (push riga linee -1)
      ; L'indice corrente diventa l'indice
      ; dell'ultima parola della linea corrente
      (setq indice succ)
    )
    ; Output: lista di linee giustificate al centro
    linee))

(giustifica-testo '("Questo" "è" "un" "esempio" "di" "testo" "da" "giustificare.") 16)
;-> ("Questo    è   un" "esempio di testo" "da giustificare.  ")

(giustifica-testo '("Questo" "è" "un" "esempio" "di" "testo" "da" "giustificare.") 12)
;-> ("Questo  è un" "esempio   di" "testo     da" "giustificare.   ")


------------
Data e tempo
------------

newLISP mette a disposizione diverse funzioni per le date e il tempo.

La funzione "now" restituisce informazioni sulla data e l'ora correnti come una lista di numeri interi:

(now)
;-> (2021 4 12 14 37 28 909751 102 1 120 2)

Valore   Descrizione
------   -----------
  2021   Anno del calendario Gregoriano
     4   Mese (1–12)
    12   Giorno (1–31)
    14   Ora (0–23) UTC
    37   Minuti (0–59)
    28   Secondi  (0–59)
909751   Microsecondi (0–999999) OS-specifico, risoluzione in millisecondi
   102   Numero giorno dell'anno (1 Gen è 1)
     1   Numero giorno della settimana (1–7) inizianod da Lunedì
   120   Differenza di fuso orario in minuti a ovest del GMT (inclusa l'ora legale)
     2   Tipo di ora legale (0–6) su Linux/Unix o (0–2) su MS Windows

La funzione "time-of-day" restituisce il tempo trascorso dall'inizio del giorno corrente (in millisecondi).

(setq t (time-of-day))
;-> 59999105.675

La funzione "date" restituisce la data e l'ora correnti del fuso orario locale (stringa)

(date)
;-> "Mon Apr 12 16:42:32 2021"

Note: consultare il manuale per vedere le caratteristiche complete delle funzioni elencate sopra e le altre funzioni sulle date "date-value", "date-list" e "date-parse".

Ora del giorno (binaria)
------------------------
Per divertimento vediamo una funzione che restituisce l'ora in formato binario.

(setq data (parse (date) " "))
;-> ("Mon" "Apr" "12" "16:43:59" "2021")
(setq ora (parse (data 3) ":"))
;("16" "43" "59")
(setq lst (map (fn(x) (bits (int x 0 10))) ora))
;-> ("10000" "101011" "111011")

(define (b-time)
(local (data ora lst)
  (setq data (parse (date) " "))
  ;("Mon" "Apr" "12" "16:43:59" "2021")
  (setq ora (parse (data 3) ":"))
  ;("16" "43" "59")
  (setq lst (map (fn(x) (bits (int x 0 10))) ora))
  ;("10000" "101011" "111011")
  (println "     24 16  8  4  2  1")
  (println "     -----------------")
  (dolist (el lst)
    (setq b el)
    (if (< (length b) 6)
        (push (dup "0" (- 6 (length b))) b))
    ;("010000" "101011" "111011")
    (cond ((= $idx 0) (print "ore:"))
          ((= $idx 1) (print "min:"))
          ((= $idx 2) (print "sec:"))
    )
    (dostring (ch b) (print "  " (char ch)))
    (println {})
  )))

(b-time)
;->      24 16  8  4  2  1
;->      -----------------
;-> ore:  0  1  0  0  0  1
;-> min:  1  1  0  0  0  0
;-> sec:  0  1  0  1  1  1


-------------------------
Algoritmo di Gale-Shapley
-------------------------

Supponiamo che ci siano n donne e n uomini. Ogni uomo classifica le donne in ordine di preferenza, e le donne classificano gli uomini allo stesso modo.
Un matrimonio è una perfetta corrispondenza tra gli uomini e le donne in un grafo bipartito completo.
Un matrimonio viene chiamato stabile se non esiste un uomo i e una donna j tali che l'uomo preferisca j alla sua
attuale moglie e la donna preferisce i al suo attuale marito.
L'obiettivo è calcolare un matrimonio stabile dalle 2*n preferenze dichiarate.
La soluzione non è necessariamente unica.

L'algoritmo di Gale–Shapley (1962) risolve questo problema in tempo O(n^2), ma non è detto che la soluzione sia ottimale.
L'algoritmo inizia senza coppie sposate. Quindi, finché ci sono uomini single, l'algoritmo seleziona uno scapolo i e la donna j che piace di più all'uomo i trq quell donne che non sono state ancora considerate. L'algoritmo cerca quindi di sposare i con j. Il matrimonio avrà luogo se j è ancora single o se j è sposata con un uomo k, ma preferisce i a k. In questo caso, k viene "divorziato" e ritorna nel gruppo di uomini single.

Per la complessità, ogni coppia i, j è considerata al massimo una volta dall'algoritmo, e il lavoro da fare per ogni coppia richiede tempo costante. Per la validità è sufficiente osservare che man mano che l'algoritmo procede:
(1) una data donna è sposata con uomini che lei preferisce sempre di più,
(2) mentre un dato uomo è sposato con donne che preferisce sempre di meno
Per dimostrare la validità dell'algoritmo, supponiamo che alla fine esista un uomo sposato una donna j1 e una donna j sposata con un uomo i1 tali che i preferisce j a j1 e j preferisce i a i1. Per l'osservazione (2), ad un certo punto l'algoritmo ha esaminato la coppia i, j. Tuttavia, per (1), l'algoritmo non ha mai sposato i con j. Questo significa che quando è stata considerata la coppia (i, j) la donna j deve essere stata sposata con un uomo k che lei preferisce a i. Questo contraddice il fatto che lei possa essere sposata con un uomo che le piace meno di i.

Nell'implementazione seguente, gli uomini sono numerati da 0 a n−1, così come le donne. L'input è costituito da due array. L'array men contiene, per ogni uomo, la relativa lista di n donne preferite, in ordine decrescente. L'array women contiene, per ogni donna, la relativa lista di n uomini preferiti.
L'array women viene prima trasformato in un array che contiene per ogni donna j e uomo i il grado di preferenza che j ha per i. Ad esempio, se rank(j)(i) = 0, allora i è l'uomo preferito di j, e se rank(j)(i1) = 1, allora i1 è il secondo nella lista per j, ecc.
Infine, l'array link associa a ciascuna donna l'uomo con cui si trova attualmente sposata. La coda singles contiene gli uomini singoli e per ogni uomo i il valore cur-choices(i) indica l'indice della prossima donna nella sua lista di
preferenze.

L'algoritmo può essere applicato a qualunque situazione in cui occorra accoppiare due gruppi in base alle preferenze espresse dai singoli elementi di ogni gruppo. Per questo abbiamo generalizzato le variabili per non legare l'algoritmo solo alla soluzione dei "matrimoni stabili".

(define (couple prefs-a prefs-b)
  (local (len cur-choices links singles rank i j)
    (setq len (length prefs-a))
    (setq cur-choices (array len '(0)))
    (setq links (array len '(nil)))
    (setq rank (array len len '(0)))
    (for (j 0 (- len 1))
      (for (r 0 (- len 1))
        (setf (rank j (prefs-b j r)) r)
      )
    )
    (setq singles (sequence 0 (- len 1)))
    (while singles
      (setq i (pop singles))
      (setq j (prefs-a i (cur-choices i)))
      (++ (cur-choices i))
      (cond ((nil? (links j))
             (setf (links j) i))
            ((< (rank j (links j)) (rank j i))
             (push i singles -1))
            (true
              (push (links j) singles -1)
              (setf (links j) i))
      )
    )
    links))

Vediamo un esempio:

(setq m '((4 1 2 3 0) (1 4 0 2 3) (3 2 1 0 4) (0 1 2 3 4) (4 1 2 3 0)))
(setq w '((4 2 3 0 1) (0 1 2 4 3) (3 4 2 1 0) (4 1 0 3 2) (1 0 3 2 4)))
(couple m w)
;-> (3 1 4 2 0)

Interpretiamo il risultato considerando l'indice 0 come il primo elemento (sia per gli uomini che per le donne):

Woman  Man
-----  ---
W1     M4 (3)
W2     M2 (1)
W3     M5 (4)
W4     M3 (2)
W5     M1 (0)

Per ottenere tutti gli accoppiamenti della soluzione possiamo scrivere:

(sort (map (fn(x) (list $idx x)) (couple m w)))
;-> ((0 3) (1 1) (2 4) (3 2) (4 0))


----------------------------------
Il problema dello zaino (Knapsack)
----------------------------------

Dati n oggetti con pesi p(0),...,p(n−1) e valori v(0),...,v(n−1), e dato uno zaino con una capacità C, dove C è un numero intero, trovare un sottoinsieme degli oggetti con valore totale massimo, il cui peso totale non supera la capacità C.
Questo è un problema NP-Hard.

Per i in {0,...,n − 1} e c in {0,...,C}, assegnare Opt[i][c] come il valore più grande ottenibile tra oggetti con indice da 0 a i senza che il loro peso superi la capacità c. Per il caso base i = 0, abbiamo Opt[0][c] = 0 se (p(0) > c) altrimenti Opt[0][c] = v0.
Per valori maggiori di i, compaiono al massimo due scelte possibili per l'oggetto dell'indice i: possiamo prenderlo o possiamo lasciarlo.
Nel primo caso, la capacità disponibile viene ridotta di p(i). Abbiamo quindi la relazione:

                | opt[i-1][c- p(i)] + v(i) (nel caso in cui prendiamo l'oggetto e (p(i) >= c))
opt[i][c] = max |
                | opt[i-1][c]              (nel caso in cui lasciamo l'oggetto)

Questo è un algoritmo con complessità pseudo-polinomiale O(n*C), cioè un algoritmo che è polinomiale nel valore degli input ma non nella loro dimensione (inquesto caso, aumentando di poco la dimensione di C raddoppia il tempo di esecuzione).

Una matrice booleana Sel viene mantenuta in parallelo con la matrice di programmazione dinamica Opt. Questo ci permette di ricordare le scelte fatte che hanno portato ai valori memorizzati in Opt. Una volta che queste matrici sono state popolate seguendo la formula di ricorrenza sopra descritta, attraversando gli elementi in ordine inverso possiamo estrarre dalla matrice Sel l'insieme di elementi che fornisce il valore totale ottimale.

(define (knapsack p v cmax)
(local (n opt sel cap solution)
  (setq n (length p))
  (setq opt (array n (+ cmax 1) '(0)))
  (setq sel (array n (+ cmax 1) '(nil)))
  (for (cap (p 0) cmax)
    (setf (opt 0 cap) (v 0))
    (setf (sel 0 cap) true)
  )
  (for (i 1 (- n 1))
    (for (cap 0 cmax)
      (cond ((and (>= cap (p i))
                  (> (add (opt (- i 1) (- cap (p i))) (v i)) (opt (- i 1) cap)))
             (setf (opt i cap) (add (opt (- i 1) (- cap (p i))) (v i)))
             (setf (sel i cap) true))
             (true
              (setf (opt i cap) (opt (- i 1) cap))
              (setf (sel i cap) nil))
      )
    )
  )
  (setq cap cmax)
  (setq solution '())
  (for (i (- n 1) 0 -1)
    (if (sel i cap) (begin
        (push i solution)
        (setq cap (- cap (p i))))
    )
  )
  (list (opt (- n 1) cmax) solution)))

(setq p '(1 2 3 2 2))
(setq v '(8 4 0 5 3))
(knapsack p v 4)
;-> (13 (0 3))

(setq p '(10 20 30))
(setq v '(60 100 120))
(knapsack p v 50)
;-> (220 (1 2))

(setq p '(9.9 19.6 29.4))
(setq v '(59.3 99.8 118.5))
(knapsack p v 50)
;-> (218.3 (1 2))

(setq p '(3 4 5 9 4))
(setq v '(3 4 4 10 4))
(knapsack p v 11)
;-> (11 (0 1 4))

(setq p '(12 2 1 1 4))
(setq v '(4 2 1 2 10))
(knapsack p v 15)
;-> (15 (1 2 3 4))


-----------------
Validazione UTF-8
-----------------

Un carattere in UTF-8 può essere lungo da 1 a 4 byte ed è soggetto alle seguenti regole:
Per i caratteri di 1 byte, il primo bit è 0, seguito dal suo codice Unicode.
Per il carattere di n byte, i primi n bit sono tutti uno, il bit n + 1 è 0, seguito da n-1 byte con i 2 bit più significativi 10. Ecco come funziona la codifica UTF-8:

   Intervallo di numeri  |  Sequenza di Ottetti UTF-8
      dei caratteri      |        (binario)
      (esadecimale)      |
   ----------------------+----------------------------------------
   0000 0000-0000 007F   |  0xxxxxxx
   0000 0080-0000 07FF   |  110xxxxx 10xxxxxx
   0000 0800-0000 FFFF   |  1110xxxx 10xxxxxx 10xxxxxx
   0001 0000-0010 FFFF   |  11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

Dato un array di numeri interi che rappresentano i dati, restituire se si tratta di una codifica UTF-8 valida.

Nota: l'input è un array di numeri interi. Per memorizzare i dati vengono utilizzati solo gli 8 bit meno significativi di ciascun numero intero. Ciò significa che ogni numero intero rappresenta solo 1 byte di dati.

Esempio 1:
data = [197, 130, 1], che rappresenta la sequenza di ottetti: 11000101 10000010 00000001.
Restituisce: true
È una codifica utf-8 valida per un carattere di 2 byte seguito da un carattere di 1 byte.

Esempio 2:
data = [235, 140, 4], che rappresentava la sequenza di ottetti: 11101011 10001100 00000100.
Restituisce: nil
I primi 3 bit sono tutti 1 e il 4° bit è 0, questo significa che è un carattere di 3 byte.
Il byte successivo è un byte di continuazione che inizia con 10 ed è corretto.
Ma il secondo byte di continuazione non inizia con 10, quindi non è valido.

(define (utf8? data)
(catch
  (let ((conta 0) (out true))
    (for (i 0 (- (length data) 1))
      (if (zero? conta)
          (cond ((= (bits (>> (data i) 5)) "110")
                 (setq conta 1))
                ((= (bits (>> (data i) 4)) "111")
                 (setq conta 2))
                ((= (bits (>> (data i) 3)) "1111")
                 (setq conta 3))
                ((= (bits (>> (data i) 7)) "1")
                 (throw nil))
          )
          (begin ;else
          (if (!= (>> (data i) 6) 2)
              (throw nil)
          )
          (-- conta))
      )
    )
    (zero? conta))))

(utf8? '(197 130 1))
;-> true

(utf8? '(235 140 1))
;-> nil

Nota: L'algoritmo originale utilizza l'operatore bit-wise ">>>" (unsigned right bit-shift). newLISP non possiede questo operatore ed abbiamo utilizzato l'operatore ">>" (signed right bit-shift). Entrambi dividono il primo operando per 2 elevato al secondo operando.
La differenza tra ">>" e ">>>" appare solo quando si usano numeri negativi. L'operatore ">>" sposta un bit 1 nel bit più significativo se era un 1, invece ">>>" sposta in 0 a prescindere.


------------
Sudoku mania
------------

Un altro programma brute-force per risolvere il sudoku.

; controlla se un tentativo (numero) è valido in un box (3x3)
(define (check-box guess row col grid)
(catch
  (local (xb yb)
    (setq xb (* (/ col 3) 3))
    (setq yb (* (/ row 3) 3))
    (for (y 0 2)
      (for (x 0 2)
        (if (= guess (grid (+ yb y) (+ xb x)))
            (throw nil))))
    true)))
; controlla se un tentativo (numero) è valido in una riga
(define (check-row guess row col grid)
(catch
  (local (tmp)
    (for (x 0 8)
      (if (= guess (grid row x))
          (throw nil)))
    true)))
; controlla se un tentativo (numero) è valido in una colonna
(define (check-col guess row col grid)
(catch
  (local (tmp)
    (for (y 0 8)
      (if (= guess (grid y col))
          (throw nil)))
    true)))
; controlla se un tentativo (numero) è valido
(define (is-safe guess row col grid)
  (if (and (check-row guess row col grid)
           (check-col guess row col grid)
           (check-box guess row col grid))
      true
      nil))
; funzione ausiliaria che risolve il sudoku
(define (sudoku-aux)
(catch
  (local (tmp)
    (for (y 0 8)
      (for (x 0 8)
        (if (zero? (grid y x))
            (begin
              (for (num 1 9)
                (if (is-safe num y x grid)
                    (begin
                      (setf (grid y x) num)
                      (if (sudoku-aux) (throw true))
                      (setf (grid y x) 0)
                    )
                )
              )
              (throw nil)
            )
        )
      )
    )
    true)))
; Funzione principale
(define (sudoku matrix)
  (local (grid)
    (setq grid matrix)
    (if (sudoku-aux) grid nil)))

Vediamo alcuni esempi:

(setq s1 '((3 0 6 5 0 8 4 0 0)
           (5 2 0 0 0 0 0 0 0)
           (0 8 7 0 0 0 0 3 1)
           (0 0 3 0 1 0 0 8 0)
           (9 0 0 8 6 3 0 0 5)
           (0 5 0 0 9 0 6 0 0)
           (1 3 0 0 0 0 2 5 0)
           (0 0 0 0 0 0 0 7 4)
           (0 0 5 2 0 6 3 0 0)))

(sudoku s1)
;-> ((3 1 6 5 7 8 4 9 2)
;->  (5 2 9 1 3 4 7 6 8)
;->  (4 8 7 6 2 9 5 3 1)
;->  (2 6 3 4 1 5 9 8 7)
;->  (9 7 4 8 6 3 1 2 5)
;->  (8 5 1 7 9 2 6 4 3)
;->  (1 3 8 9 4 7 2 5 6)
;->  (6 9 2 3 5 1 8 7 4)
;->  (7 4 5 2 8 6 3 1 9))

(setq escargot
'((1 0 0 0 0 7 0 9 0)
  (0 3 0 0 2 0 0 0 8)
  (0 0 9 6 0 0 5 0 0)
  (0 0 5 3 0 0 9 0 0)
  (0 1 0 0 8 0 0 0 2)
  (6 0 0 0 0 4 0 0 0)
  (3 0 0 0 0 0 0 1 0)
  (0 4 0 0 0 0 0 0 7)
  (0 0 7 0 0 0 3 0 0)))

(time (println (sudoku escargot)))
;-> ((1 6 2 8 5 7 4 9 3)
;->  (5 3 4 1 2 9 6 7 8)
;->  (7 8 9 6 4 3 5 2 1)
;->  (4 7 5 3 1 2 9 8 6)
;->  (9 1 3 5 8 6 7 4 2)
;->  (6 2 8 7 9 4 1 3 5)
;->  (3 5 6 4 7 8 2 1 9)
;->  (2 4 1 9 3 5 8 6 7)
;->  (8 9 7 2 6 1 3 5 4))
;-> 333.887

(setq world
'((8 0 0 0 0 0 0 0 0)
  (0 0 3 6 0 0 0 0 0)
  (0 7 0 0 9 0 2 0 0)
  (0 5 0 0 0 7 0 0 0)
  (0 0 0 0 4 5 7 0 0)
  (0 0 0 1 0 0 0 3 0)
  (0 0 1 0 0 0 0 6 8)
  (0 0 8 5 0 0 0 1 0)
  (0 9 0 0 0 0 4 0 0)))

(time (println (sudoku world)))
;-> ((8 1 2 7 5 3 6 4 9)
;->  (9 4 3 6 8 2 1 7 5)
;->  (6 7 5 4 9 1 2 8 3)
;->  (1 5 4 2 3 7 8 9 6)
;->  (3 6 9 8 4 5 7 2 1)
;->  (2 8 7 1 6 9 5 3 4)
;->  (5 2 1 9 7 4 3 6 8)
;->  (4 3 8 5 2 6 9 1 7)
;->  (7 9 6 3 1 8 4 5 2))
;-> 1840.978

(setq tweezers
'((1 0 0 0 0 0 0 6 0)
  (0 0 0 1 0 0 0 0 3)
  (0 0 5 0 0 2 9 0 0)
  (0 0 9 0 0 1 0 0 0)
  (7 0 0 0 4 0 0 8 0)
  (0 3 0 5 0 0 0 0 2)
  (5 0 0 4 0 0 0 0 6)
  (0 0 8 0 6 0 0 7 0)
  (0 7 0 0 0 5 0 0 0)))

(time (println (sudoku tweezers)))
;-> ((1 8 2 3 9 4 5 6 7)
;->  (9 6 7 1 5 8 2 4 3)
;->  (3 4 5 6 7 2 9 1 8)
;->  (8 2 9 7 3 1 6 5 4)
;->  (7 5 6 2 4 9 3 8 1)
;->  (4 3 1 5 8 6 7 9 2)
;->  (5 9 3 4 1 7 8 2 6)
;->  (2 1 8 9 6 3 4 7 5)
;->  (6 7 4 8 2 5 1 3 9))
;-> 9305.376


---------------------------------------
Radici quadrate con il metodo di Newton
---------------------------------------

Dato un numero intero N e un livello di precisione P, trovare la radice quadrata di N con una precisione superiore a P utilizzando il metodo di Newton.

Esempi:

input: N = 16, P = 0.0000001
output: 4
4 ^ 2 = 16

input: N = 327, P = 0.0000001
output: 18.0831

Metodo di Newton
----------------
Dato un numero qualsiasi N la sua radice quadrata di N è data dalla formula:

radice = 0.5 * (X + (N / X)) dove X è un valore iniziale che può essere assunto come N o 1.

Nota: "radice" è la nuova X da utilizzare per il passo successivo.

Nella formula sopra, X è una qualsiasi radice quadrata presunta di N e "radice" è la radice quadrata corretta di N. La precisione è data dalla differenza assoluta tra X e "radice".

Algoritmo:

1) Assegnare X uguale a N.
2) Ciclo continuo per calcolare la radice ottenendo valori sempre più vicini al valore corretto della radice quadrata di N.
3) Verificare la differenza tra la X presunta e la radice calcolata:
   Se siamo superiori alla precisione richiesta,
    allora aggiornare la radice e continuare.
    altrimenti uscuamo dal ciclo.
4) Restituire il valore della radice.

Di seguito è riportata l'implementazione dell'approccio di cui sopra:
(define (square-root num prec)
(catch
  (local (x conta)
    (setq x num)
    (setq conta 0)
    (while true
      (++ conta)
      (setq radice (mul 0.5 (add x (div num x))))
      (if (< (abs (sub radice x)) prec)
          (throw radice)
      )
      ; aggiornamento valore radice
      (setq x radice)
    )
    nil)))

(square-root 16 0.001)
;-> 4.000000000000051

(square-root 16 0.0000001)
;-> 4

(square-root 1111 0.0000001)
;-> 33.33166662499792
(mul 33.33166662499792 33.33166662499792)
;-> 1111.000000000001


---------
Ippodromo
---------

Un semplice gioco per divertirsi con i bambini (e magari scommettere tra grandi).
La funzione "ippodromo" prende due parametri, il numero di cavalli che partecipano alla corsa (denominati "A", "B", "C", ecc.) e la lunghezza della pista.
Dalla posizione di partenza dobbiamo premere "invio" per far muovere casualmente uno dei cavalli...fino alla fine della corsa.

(define (ippodromo num-cavalli lunghezza)
  (local (cavalli testa mossa cav pos)
    ; inizializzazione dei numeri casuali
    (seed (time-of-day))
    ; crea una lista associativa (cavalli, posizione) di lunghezza num-cavalli
    ; (("A" 0) ("B" 0) ("C" 0) ("D" 0) ...)
    (setq cavalli '())
    (for (i 0 (- num-cavalli 1))
      (push (list (char (+ i 65)) 0) cavalli -1)
    )
    ; Inizia la corsa...
    ; stampa la posizione di partenza
    (println "Posizione di partenza")
    (println (dup "-" (+ lunghezza 1)))
    (for (i 0 (- num-cavalli 1))
      ; nome cavallo corrente
      (setq cav (char (+ 65 i)))
      ; posizione iniziale cavallo corrente
      (println cav (dup "∙" lunghezza))
    )
    (println (dup "-" (+ lunghezza 1)))
    ; posizione del cavallo in testa
    (setq testa 0)
    (while (< testa lunghezza)
      ; Premere invio per il prossimo passo
      (read-line)
      ; mossa (+1) casuale di uno dei cavalli
      (setq mossa (rand num-cavalli))
      ; aggiornamento posizione cavallo mosso
      (++ (lookup (char (+ 65 mossa)) cavalli))
      ; stampa corsa
      (for (i 0 (- num-cavalli 1))
        ; nome cavallo corrente
        (setq cav (char (+ 65 i)))
        ; posizione cavallo corrente
        (setq pos (lookup cav cavalli))
        ; stampa corsa cavallo corrente
        (println (dup " " pos) cav (dup "∙" (- lunghezza pos)))
        ;(println (dup " " pos) cav (dup "." (- lunghezza pos)))
      )
      (println { })
      (println (dup "-" (+ lunghezza 1)))
      ; calcolo della posizione del cavallo in testa
      (setq testa (apply max (map last cavalli)))
    )
    ; la corsa è finita...
    ; ordinamento della lista cavalli in base alla posizione
    (setq arrivo (sort cavalli (fn(x y) (>= (last x) (last y)))))
    ; stampa l'ordine di arrivo
    (println "Ordine di arrivo:")
    (for (i 0 (- num-cavalli 1))
      (println (+ i 1) "° " (arrivo i 0) " (" (arrivo i 1) ")")
    )
    '-----------------))

(ippodromo 2 5)
;-> Posizione di partenza
;-> ------
;-> A∙∙∙∙∙
;-> B∙∙∙∙∙
;-> ------
;->
;-> A∙∙∙∙∙
;->  B∙∙∙∙
;->
;-> ------
;->
;-> A∙∙∙∙∙
;->   B∙∙∙
;->
;-> ------
;->
;->  A∙∙∙∙
;->   B∙∙∙
;->
;-> ------
;->
;->  A∙∙∙∙
;->    B∙∙
;->
;-> ------
;->
;->  A∙∙∙∙
;->     B∙
;->
;-> ------
;->
;->  A∙∙∙∙
;->      B
;->
;-> ------
;-> Ordine di arrivo:
;-> 1° B (5)
;-> 2° A (1)
;-> -----------------

(ippodromo 10 70)
;-> Posizione di partenza
;-> -----------------------------------------------------------------------
;-> A∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> B∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> C∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> D∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> E∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> F∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> G∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> H∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> I∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> J∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> -----------------------------------------------------------------------
;->
...
;->
;-> -----------------------------------------------------------------------
;->                                                          A∙∙∙∙∙∙∙∙∙∙∙∙∙
;->                                                                  B∙∙∙∙∙
;->                                                    C∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;->                                                              D∙∙∙∙∙∙∙∙∙
;->                                                   E∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;->                                                                       F
;->                                               G∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;->                                         H∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;->                                                            I∙∙∙∙∙∙∙∙∙∙∙
;->                                                      J∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙∙
;-> -----------------------------------------------------------------------
;-> Ordine di arrivo:
;-> 1° F (70)
;-> 2° B (65)
;-> 3° D (61)
;-> 4° I (59)
;-> 5° A (57)
;-> 6° J (53)
;-> 7° C (51)
;-> 8° E (50)
;-> 9° G (46)
;-> 10° H (40)
;-> -----------------


------------------------------------------------
Parser di espressioni infisse-prefisse-postfisse
------------------------------------------------

Questa funzione è basata sul modulo "infix.lsp" che si trova nella distribuione di newLISP ed è stata scritta da Lutz Mueller.

La procedura analizza le espressioni infisse, prefisse o suffisse fornite nelle stringhe e restituisce espressioni newLISP, che possono essere valutate. inoltre cattura gli errori di sintassi.

;; @syntax (xlate <str-expression>)
;; @param <str-expression> The expression (infix, postfix, prefix) in a string
;; @return A newLISP expression or 'nil' on failure.
;; When 'nil' is returned then the error message is in 'result'.
;;
;; Note that the parser requires operators, variables and constants surrounded
;; by spaces except where parenthesis are used.
;;
;; @example
;; (xlate "3 + 4") => (add 3 4) ;; parses infix
;; (xlate "+ 3 4") => (add 3 4) ;; parses prefix s-expressions
;; (xlate "3 4 +") => (add 2 4) ;; parses postfix
;;
;; (xlate "3 + * 4") => "ERR: missing argument for +"
;;
;; (eval (xlate "3 + 4")) => 7
;;
;; (xlate "(3 + 4) * (5 - 2)")  => (mul (add 3 4) (sub 5 2))
;;
;; (xlate "(a + b) ^ 2 + (a - b) ^ 2") => (add (pow (add a b) 2) (pow (sub a b) 2))
;;
;; (xlate "x = (3 + sin(20)) * (5 - 2)")  => (setq x (mul (add 3 (sin 20)) (sub 5 2)))
;;
;; (xlate "x = (3 + sin(10 - 2)) * (5 - 2)")
;;         => (setq x (mul (add 3 (sin (sub 10 2))) (sub 5 2)))
;
; operator priority table
; (token operator arg-count priority)
(set 'operators '(
  ("=" setq 2 2)
  ("+" add 2 3)
  ("-" sub 2 3)
  ("*" mul 2 4)
  ("/" div 2 4)
  ("^" pow 2 5)
  ("abs" abs 1 9)
  ("acos" acos 1 9)
  ("asin" asin 1 9)
  ("atan" atan 1 9)
  ("sin" sin 1 9)
  ("sqrt" sqrt 1 9)
  ("tan" tan 1 9)
  ("cos" cos 1 9)
; add what else is needed
  ))
; Main function
(define (xlate str)
  (if (catch (infix-xlate str) 'result)
    result                     ; if starts with ERR: is error else result
    (append "ERR: " result)))  ; newLISP error has occurred
; Auxiliary function
(define (infix-xlate str)
  (set 'tokens (parse str))
  (set 'varstack '())
  (set 'opstack '())
  (dolist (tkn tokens)
  (case tkn
        ("(" (push tkn opstack))
        (")" (close-parenthesis))
        (true (if (assoc tkn operators)
                  (process-op tkn)
                  (push tkn varstack)))))
  (while (not (empty? opstack))
        (make-expression))
  (set 'result (first varstack))
  (if (or (> (length varstack) 1) (not (list? result)))
    (throw "ERR: wrong syntax")
    result))
; pop all operators and make expressions
; until an open parenthesis is found
(define (close-parenthesis)
 (while (not (= (first opstack) "("))
    (make-expression))
 (pop opstack))
; pop all operator, which have higher/equal priority
; and make expressions
(define (process-op tkn)
  (while (and opstack
              (<= (lookup tkn operators 3) (lookup (first opstack) operators 3)))
        (make-expression))
  (push tkn opstack))
; pops an operator from the opstack and makes/returns an
; newLISP expression
(define (make-expression)
  (set 'expression '())
  (if (empty? opstack)
        (throw "ERR: missing parenthesis"))
  (set 'ops (pop opstack))
  (set 'op (lookup ops operators 1))
  (set 'nops (lookup ops operators 2))
  (dotimes (n nops)
    (if (empty? varstack) (throw (append "ERR: missing argument for " ops)))
    (set 'vars (pop varstack))
    (if (atom? vars)
            (if (not (or (set 'var (float vars))
                         (and (legal? vars) (set 'var (sym vars))) ))
                (throw (append vars "ERR: is not a variable"))
                (push var expression))
            (push vars expression)))
  (push op expression)
  (push expression varstack))

Esempi:

Infissa -> Prefissa
(xlate "3 + 4")
;-> (add 3 4)

Prefiss -> Prefissa
(xlate "+ 3 4")
;-> (add 3 4)

Postfissa -> Prefissa
(xlate "3 4 +")
;-> (add 3 4)

(xlate "3 + * 4")
;-> "ERR: missing argument for +"

(eval (xlate "3 + 4"))
;-> 7

(xlate "(3 + 4) * (5 - 2)")
;-> (mul (add 3 4) (sub 5 2))

(xlate "(a + b) ^ 2 + (a - b) ^ 2")
;-> (add (pow (add a b) 2) (pow (sub a b) 2))

(xlate "x = (3 + sin(20)) * (5 - 2)")
;-> (setq x (mul (add 3 (sin 20)) (sub 5 2)))

(xlate "x = (3 + sin(10 - 2)) * (5 - 2)")
;-> (setq x (mul (add 3 (sin (sub 10 2))) (sub 5 2)))


-------------------
Derivate Simboliche
-------------------

Dal libro "Structure and Interpretation of Computer Programs" di Abelson e Sussman.
Capitolo 2 Building Abstractions with Data
Pararafo 2.3.2 Esempio: Derivata simbolica

https://mitpress.mit.edu/sites/default/files/sicp/full-text/sicp/book/node39.html

Nota: funzioni ausiliarie "car" e "cdr"
;(define (car x)    (first x))
;(define (cdr x)    (rest x))
(define car first)
(define cdr rest)
(define (caar x)   (first (first x)))
(define (cadr x)   (first (rest x)))
(define (cdar x)   (rest (first x)))
(define (cddr x)   (rest (rest x)))
(define (caaar x)  (first (first (first x))))
(define (caadr x)  (first (first (rest x))))
(define (cadar x)  (first (rest (first x))))
(define (caddr x)  (first (rest (rest x))))

Come illustrazione della manipolazione dei simboli e un'ulteriore illustrazione dell'astrazione dei dati, si consideri la progettazione di una procedura che esegue la differenziazione simbolica delle espressioni algebriche. Vorremmo che la procedura prendesse come argomenti un'espressione algebrica e una variabile e restituisse la derivata dell'espressione rispetto alla variabile. Ad esempio, se gli argomenti della procedura sono ax^2 + bx + c e x, la procedura dovrebbe restituire 2ax + b. La differenziazione simbolica ha un significato storico speciale in Lisp. È stato uno degli esempi motivanti alla base dello sviluppo di un linguaggio informatico per la manipolazione dei simboli. Inoltre, ha segnato l'inizio della linea di ricerca che ha portato allo sviluppo di potenti sistemi per il calcolo matematico simbolico, che sono attualmente utilizzati da un numero crescente di matematici applicati e fisici.

Nello sviluppo del programma di differenziazione simbolica, seguiremo la stessa strategia di astrazione dei dati che abbiamo seguito nello sviluppo del sistema numerico razionale della sezione 2.1.1. Cioè, definiremo prima un algoritmo di differenziazione che opera su oggetti astratti come "somme", "prodotti" e "variabili" senza preoccuparci di come questi devono essere rappresentati. Solo in seguito affronteremo il problema della rappresentazione.

Il programma di differenziazione con dati astratti
--------------------------------------------------
Per mantenere le cose semplici, prenderemo in considerazione un programma di differenziazione simbolica molto semplice che gestisce espressioni costruite utilizzando solo le operazioni di addizione e moltiplicazione con due argomenti. La differenziazione di tali espressioni può essere effettuata applicando le seguenti regole di riduzione:

   dc
  ---- = 0 per c costante o variabile diversa da x
   dx

   dx
  ---- = 1
   dx

   d(u + v)     du     dv
  ---------- = ---- + ----
      dx        dx     dx

   d(u * v)       dv       du
  ---------- = u*---- + v*----
      dx          dx       dx

Osserva che le ultime due regole sono di natura ricorsiva. Cioè, per ottenere la derivata di una somma troviamo prima le derivate dei termini e le sommiamo. Ciascuno dei termini può a sua volta essere un'espressione che deve essere scomposta. La scomposizione in pezzi sempre più piccoli produrrà alla fine pezzi che sono costanti o variabili, le cui derivate saranno 0 o 1.

Per incorporare queste regole in una procedura, dobbiamo affidarci ad una ipotesi di speranza, come abbiamo fatto nel progettare l'implementazione de numeri razionali. Se avessimo un mezzo per rappresentare espressioni algebriche, dovremmo essere in grado di dire se un'espressione è una somma, un prodotto, una costante o una variabile. Dovremmo essere in grado di estrarre le parti di un'espressione. Per una somma, ad esempio, vogliamo essere in grado di estrarre l'addendo (primo termine) e l'augendo (secondo termine). Dovremmo anche essere in grado di costruire espressioni dalle parti. Supponiamo di avere già procedure per implementare i seguenti selettori, costruttori e predicati:

  (variable? e)	"a" è una variabile?

  (same-variable? v1 v2)	v1 e v2 sono le stesse variabili?

  (sum? e) "e" è una somma?

  (addend e)	Addendo della somma "e"

  (augend e)	Augendo della somma "e"

  (make-sum a1 a2)	Costruisce la somma di "a1" e "a2"

  (product? e) "e" è un prodotto?

  (multiplier e)	Moltiplicatore del prodotto "e"

  (multiplicand e)	Moltiplicando del prodotto "e"

  (make-product m1 m2)	Costruisce il prodotto di "m1" e "m2"

Usando questi, e il predicato primitivo "number?", che identifica i numeri, possiamo esprimere le regole di differenziazione come la seguente procedura:

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        (true
         (println "Espressione sconosciuta:" expr))))

Questa procedura "deriv" incorpora l'algoritmo di differenziazione completo. Poiché è espresso in termini di dati astratti, funzionerà indipendentemente da come scegliamo di rappresentare le  espressioni algebriche, purché progettiamo un insieme appropriato di selettori e costruttori. Questo è il problema che dobbiamo affrontare dopo.

Rappresentare espressioni algebriche
------------------------------------
Possiamo immaginare molti modi per utilizzare la struttura a lista per rappresentare espressioni algebriche. Ad esempio, potremmo usare elenchi di simboli che rispecchiano la solita notazione algebrica, rappresentando ax + b come lista (a * x + b). Tuttavia, una scelta particolarmente semplice è quella di utilizzare la stessa notazione di prefisso tra parentesi che Lisp usa per le combinazioni, ovvero, rappresentare ax + b come (+ (* a x) b). Quindi la nostra rappresentazione dei dati per il problema di differenziazione è la seguente:

Le variabili sono simboli. Sono identificati dal predicato primitivo "symbol?":

(define (variable? x) (symbol? x))

Due variabili sono uguali se i simboli che le rappresentano sono uguali:

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (= v1 v2)))

Le somme e i prodotti sono costruiti come liste:

(define (make-sum a1 a2) (list '+ a1 a2))

(define (make-product m1 m2) (list '* m1 m2))

Le sotto-espressioni devono essere liste con più di 2 elementi:

(define (pair? x) (and (list? x) (> (length x) 2)))

Una somma è una lista il cui primo elemento è il simbolo +:

(define (sum? x)
  (and (pair? x) (= (car x) '+)))

L'addendo è il secondo elemento della lista somma:

(define (addend s) (cadr s))

Il secondo addendo (augend) è il terzo elemento della lista della somma:

(define (augend s) (caddr s))

Un prodotto è una lista il cui primo elemento è il simbolo *:

(define (product? x)
  (and (pair? x) (= (car x) '*)))

Il moltiplicatore è il secondo elemento della lista prodotto:

(define (multiplier p) (cadr p))

Il moltiplicando è il terzo elemento della lista prodotto:

(define (multiplicand p) (caddr p))

Quindi, dobbiamo solo combinarli con l'algoritmo definito da "deriv" per avere un programma di differenziazione simbolica funzionante. Vediamo alcuni esempi del suo comportamento:

(deriv '(+ x 3) 'x)
;-> (+ 1 0)

(deriv '(* x y) 'x)
;-> (+ (* x 0) (* 1 y))

(deriv '(* (* x y) (+ x 3)) 'x)
;-> (+ (* (* x y) (+ 1 0)) (* (+ (* x 0) (* 1 y)) (+ x 3)))
(+ (* (* x y) (+ 1 0))
   (* (+ (* x 0) (* 1 y))
      (+  x 3)))

Il programma produce risposte corrette. Tuttavia, non sono semplificati. È vero che:

 d(x*y)
-------- = x*0 + 1*y
   dx

ma vorremmo che il programma sapesse che x * 0 = 0, 1 * y = y e 0 + y = y. La risposta per il secondo esempio avrebbe dovuto essere semplicemente y. Come mostra il terzo esempio, questo diventa un problema serio quando le espressioni sono complesse.

La nostra difficoltà è molto simile a quella che abbiamo incontrato con l'implementazione dei numeri razionali: non abbiamo ridotto le risposte alla forma più semplice. Per ottenere la riduzione dei numeri razionali, abbiamo dovuto modificare solo i costruttori ei selettori dell'implementazione. Possiamo adottare una strategia simile anche qui. Non cambieremo affatto "deriv". Invece, cambieremo "make-sum" in modo che se entrambi gli addendi sono numeri, "make-sum" li sommerà e restituirà la loro somma. Inoltre, se uno degli addendi è 0, "make-sum" restituirà l'altro addendo.

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (true (list '+ a1 a2))))

Questa funzione utilizza la procedura "=number?", che controlla se un'espressione è uguale a un dato numero:

(define (=number? expr num)
  (and (number? expr) (= expr num)))

Allo stesso modo, cambieremo il "make-product" per incorporare le regole che 0 volte qualsiasi cosa è 0 e 1 volte qualsiasi cosa è la cosa stessa:

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (true (list '* m1 m2))))

Ecco come funziona questa versione sui nostri tre esempi:

(deriv '(+ x 3) 'x)
;-> 1
(deriv '(* x y) 'x)
;-> y
(deriv '(* (* x y) (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))

Sebbene questo sia un bel miglioramento, il terzo esempio mostra che c'è ancora molta strada da fare prima di ottenere un programma che metta le espressioni in una forma che potremmo concordare sia "più semplice". Il problema della semplificazione algebrica è complesso perché, tra le altre ragioni, una forma che può essere più semplice per uno scopo potrebbe non esserlo per un altro.

--------------
Esercizio 2.56
--------------
Mostra come estendere il differenziatore di base per gestire più tipi di espressioni. Ad esempio, implementa la regola di differenziazione:

 d(u^n)               du
-------- = n*u^(n-1)*----
   dx                 dx

aggiungendo una nuova clausola al programma "deriv" e definendo opportune procedure di "esponentiation?", "base", "exponent" e "make-exponentiation". (Puoi usare il simbolo ** per denotare l'elevazione a potenza). Costruisci nelle regole che qualsiasi cosa elevata alla potenza 0 è 1 e qualsiasi cosa elevata alla potenza 1 è la cosa stessa.

--------------
Soluzione 2.56
--------------
Iniziamo con la funzione "make-exponentiation". Come le implementazioni di "make-sum" e "make-product", vogliamo inserire alcune regole che riducano l'espressione alla sua forma più semplice. Per gli esponenti e le basi possiamo definire le seguenti riduzioni:

  Qualunque cosa elevata alla potenza di 0 è 1.
  Qualunque cosa elevata alla potenza di 1 è se stessa.
  0 elevato alla potenza di qualsiasi cosa è 0.
  1 elevato alla potenza di qualsiasi cosa è 1.

Se sia la base che l'esponente sono numeri, l'esponente può calcolare e restituire l'esponente.
In ogni altro caso, costruiamo semplicemente la rappresentazione della lista appropriata e la restituiamo. Questo ci dà la seguente implementazione:

(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((=number? base 0) 0)
        ((=number? base 1) 1)
        ((and (number? base) (number? exponent)) (pow base exponent))
        (true (list '** base exponent))))

Facciamo alcuni test:

(= 1 (make-exponentiation 1 24))
(= 16 (make-exponentiation 2 4))
(= '(** a 3) (make-exponentiation 'a 3))
(= '(** 5 b) (make-exponentiation 5 'b))
(= '(** a b) (make-exponentiation 'a 'b))
(= 'a (make-exponentiation 'a 1))
(= 1 (make-exponentiation 'a 0))
(= 4 (make-exponentiation 4 1))
(= 1 (make-exponentiation 4 0))
(= 0 (make-exponentiation 0 2))
(= 0 (make-exponentiation 0 'x))
(= 1 (make-exponentiation 0 0))
(= 1 (make-exponentiation 2 0))
(= 1 (make-exponentiation 'x 0))
(= 2 (make-exponentiation 2 1))
(= 1234 (make-exponentiation 1234 1))
(= 'x (make-exponentiation 'x 1))
(= 8 (make-exponentiation 2 3))
(= '(** x 3) (make-exponentiation 'x 3))

I selettori e i predicati seguono quindi lo stesso modello degli equivalenti per somme e prodotti.

Selettore per la base:

(define (base e) (cadr e))

Selettore per l'esponente:

(define (exponent e) (caddr e))

Predicato di esponenziazione:

(define (exponentiation? x)
  (and (pair? x) (= (car x) '**)))

Facciamo alcuni test:

(= 2 (base '(** 2 3)))
(= 'x (base '(** x 3)))
(= 3 (exponent '(** 2 3)))
(= 'x (exponent '(** 2 x)))
(= true (exponentiation? (list '** 'x 2)))
(= true (exponentiation? '(** x 2)))

Tutto quello che dobbiamo fare ora è estendere "deriv", aggiungendo una clausola che utilizza la funzione "exponentiation?" per verificare se l'espressione è o meno un esponenziale e, in tal caso, applica la regola di differenziazione:

(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        ((exponentiation? expr)
         (make-product
           (make-product (exponent expr)
                         (make-exponentiation (base expr)
                                              (make-sum (exponent expr) -1)))
           (deriv (base expr) var)))
        (true
         (println "Espressione sconosciuta:" expr))))

(= 1 (deriv '(+ x 4) 'x))
(= 'y (deriv '(+ (* x y) 4) 'x))
(= '(* 2 x) (deriv '(** x 2) 'x))
(= '(+ (* 3 (* 2 x)) 1) (deriv '(+ (* 3 (** x 2)) x) 'x))

(deriv (make-exponentiation 'a 5) 'a)
;-> (* 5 (** a 4))
(deriv (make-exponentiation 'a 'b) 'a)
;-> (* b (** a (+ b -1)))
(deriv (make-exponentiation 'a (make-sum 'a 'b)) 'a)
;-> (* (+ a b) (** a (+ (+ a b) -1)))

--------------
Esercizio 2.57
--------------
Estendi il programma di differenziazione per gestire somme e prodotti di numeri arbitrari di (due o più) termini. Quindi l'ultimo esempio sopra potrebbe essere espresso come:

(deriv '(* x y (+ x 3)) 'x)

Prova a farlo modificando solo la rappresentazione di somme e prodotti, senza modificare affatto la procedura "deriv". Ad esempio, l'addendo di una somma sarebbe il primo termine e l'augendo sarebbe la somma del resto dei termini.

--------------
Soluzione 2.57
--------------
Prima soluzione
---------------
Per risolvere questo problema è necessario cambiare le funzioni "make-sum" e "make-product" in modo che restituiscano rispettivamente la somma o il prodotto degli elementi rimanenti nella lista. Per fare questo scriviamo anche due funzioni ausiliarie "make-sum-list" e "make-product-list".

 (define (make-sum-list l)
   (if (= (length l) 2)
       (list '+ (car l) (cadr l))
       (make-sum (car l) (make-sum-list (cdr l)))))

 (define (make-sum a1 a2)
   (cond ((=number? a1 0) a2)
         ((=number? a2 0) a1)
         ((and (number? a1) (number? a2)) (+ a1 a2))
         (true (make-sum-list (list a1 a2)))))

 (define (make-product-list l)
   (if (= (length l) 2)
       (list '* (car l) (cadr l))
       (make-product (car l) (make-product-list (cdr l)))))

 (define (make-product m1 m2)
   (cond ((or (=number? m1 0) (=number? m2 0)) 0)
         ((=number? m1 1) m2)
         ((=number? m2 1) m1)
         ((and (number? m1) (number? m2)) (* m1 m2))
         (true (make-product-list (list m1 m2)))))

 (define (augend s)
   (let ((a (cddr s)))
     (if (= (length a) 1)
         (car a)
         (make-sum-list a))))

 (define (multiplicand p)
   (let ((m (cddr p)))
     (if (= (length m) 1)
         (car m)
         (make-product-list m))))

 ;; tests
 (deriv '(* (* x y) (+ x 3)) 'x)
 ;; (+ (* x y) (* y (+ x 3)))

 (deriv '(* x y (+ x 3)) 'x)
 ;; (+ (* x y) (* y (+ x 3)))

Seconda soluzione
-----------------
Un'altra soluzione è cambiare le funzioni "augend" e "multiplicand" in modo che restituiscano rispettivamente la somma o il prodotto degli elementi rimanenti nella lista. Mentre le funzioni "make-sum" e "make-product" rimangono invariate.

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (true (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (true (list '* m1 m2))))

(define (augend s)
  (accumulate make-sum 0 (cddr s)))

(define (multiplicand p)
  (accumulate make-product 1 (cddr  p)))

(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

(deriv '(* (* x y) (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))

(deriv '(* x y (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))

La funzione "accumulate" applica ricorsivamente la funzione make per sommare tutte le voci in lista.

 (accumulate make-sum 0 (cddr s))

È analogo a:

 (accumulate +  0 (cddr s))

per dati simbolici. Usiamo (cddr s)) per ottenere il resto della lista che inizia con il terzo elemento.

--------------
Esercizio 2.58
--------------
Supponiamo di voler modificare il programma di differenziazione in modo che funzioni con la notazione matematica ordinaria, in cui + e * sono operatori infissi piuttosto che prefissi. Poiché il programma di differenziazione è definito in termini di dati astratti, possiamo modificarlo per lavorare con diverse rappresentazioni di espressioni unicamente cambiando i predicati, i selettori e i costruttori che definiscono la rappresentazione delle espressioni algebriche su cui il differenziatore deve operare.

a. Mostra come farlo per differenziare le espressioni algebriche presentate in forma infissa, come (x + (3 * (x + (y + 2)))). Per semplificare l'attività, supponiamo che + e * prendano sempre due argomenti e che le espressioni siano completamente tra parentesi.

b. Il problema diventa sostanzialmente più difficile se permettiamo la notazione algebrica standard, come (x + 3 * (x + y + 2)), che elimina le parentesi non necessarie e presume che la moltiplicazione venga eseguita prima dell'addizione. Potete progettare predicati, selettori e costruttori appropriati per questa notazione in modo tale che il nostro programma derivato funzioni ancora?

--------------
Soluzione 2.58
--------------
Per risolvere questo problema possiamo usare la funzione "xlate" che converte le expressioni infisse o postfisse in espressioni prefisse (La funzione "xlate" si trova nel paragrafo "Parser di espressioni infisse-prefisse-postfisse"). Quindi non dobbiamo fare alcuna modifica al programma di differenziazione. Per finire riportiamo come è stato modificato il programma con le soluzioni 2.56 e 2.57.
;
(define car first)
(define cdr rest)
(define (caar x)   (first (first x)))
(define (cadr x)   (first (rest x)))
(define (cdar x)   (rest (first x)))
(define (cddr x)   (rest (rest x)))
(define (caddr x)  (first (rest (rest x))))
;
(define (deriv expr var)
  (cond ((number? expr) 0)
        ((variable? expr)
         (if (same-variable? expr var) 1 0))
        ((sum? expr)
         (make-sum (deriv (addend expr) var)
                   (deriv (augend expr) var)))
        ((product? expr)
         (make-sum
           (make-product (multiplier expr)
                         (deriv (multiplicand expr) var))
           (make-product (deriv (multiplier expr) var)
                         (multiplicand expr))))
        ((exponentiation? expr)
         (make-product
           (make-product (exponent expr)
                         (make-exponentiation (base expr)
                                              (make-sum (exponent expr) -1)))
           (deriv (base expr) var)))
        (true
         (println "Espressione sconosciuta:" expr))))
;
(define (variable? x) (symbol? x))
;
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (= v1 v2)))
;
(define (make-sum a1 a2) (list '+ a1 a2))
;
(define (make-product m1 m2) (list '* m1 m2))
;
(define (pair? x) (and (list? x) (> (length x) 2)))
;
(define (=number? expr num)
  (and (number? expr) (= expr num)))
;
(define (sum? x)
  (and (pair? x) (= (car x) '+)))
;
(define (addend s) (cadr s))
;
;(define (augend s) (caddr s))
;
(define (product? x)
  (and (pair? x) (= (car x) '*)))
;
(define (multiplier p) (cadr p))
;
;(define (multiplicand p) (caddr p))
;
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (true (list '+ a1 a2))))
;
(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (true (list '* m1 m2))))
;
(define (make-exponentiation base exponent)
  (cond ((=number? exponent 0) 1)
        ((=number? exponent 1) base)
        ((=number? base 0) 0)
        ((=number? base 1) 1)
        ((and (number? base) (number? exponent)) (pow base exponent))
        (true (list '** base exponent))))
;
(define (augend s)
  (accumulate make-sum 0 (cddr s)))
;
(define (multiplicand p)
  (accumulate make-product 1 (cddr  p)))
;
(define (accumulate op initial seq)
  (if (null? seq)
      initial
      (op (car seq)
          (accumulate op initial (cdr seq)))))

Facciamo alcune prove:

(deriv '(+ x 3) 'x)
;-> 1
(deriv '(* x y) 'x)
;-> y
(deriv '(* (* x y) (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))
(deriv '(* (* x y) (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))
(deriv '(* x y (+ x 3)) 'x)
;-> (+ (* x y) (* y (+ x 3)))


----------------
Media geotmetica
----------------

La media geometrica aritmetica di due numeri reali positivi viene calcolata prendendo ripetutamente metà della loro somma e la radice quadrata del loro prodotto fino a quando i due numeri convergono.
Ad esempio, la media geometrica aritmetica di 24 e 6 è 13.458171..., che viene calcolata come segue:

0  24                            6
1  15                           12
2  13.5                         13.416407864998738175455042
3  13.458203932499369089227521  13.458139030990984877207090
4  13.458171481745176983217305  13.458171481706053858316334
5  13.458171481725615420766820  13.458171481725615420766806

La media geometrica aritmetica è stata inventata da Lagrange ed è usata oggi per calcolare varie funzioni trascendentali perché converge molto rapidamente.

La media geotmetica ("geothmetic meandian" proposta da Randall Munroe) di qualsiasi insieme di numeri positivi viene calcolata iterando tre sequenze - la media aritmetica, la media geometrica e la mediana - finché non convergono.
Ad esempio, la media geotmetica dell'insieme (1,1,2,3,5) è 2.089..., che viene calcolata come segue:

1  2.4               1.97435048583482  2
2  2.124783495278273 2.116192460544808 2
3  2.080325318607694 2.07953681947958  2.116192460544808
4  2.092018199544028 2.091948604915222 2.080325318607694
5  2.088097374355648 2.08809013312096  2.091948604915222
6  2.08937870413061  2.089377914218487 2.088097374355648
7  2.088951330901582 2.088951243615992 2.089377914218487
8  2.089093496245353 2.089093486565328 2.088951330901582
9  2.089046104570754 2.08904610349584  2.089093486565328
10 2.089061898210641 2.08906189809123  2.089046104570754
11 2.089056633624209 2.089056633610941 2.08906189809123
12 2.089058388442127 2.089058388440653 2.089056633624209
13 2.08905780350233  2.089057803502165 2.089058388440653

Scrivere due funzioni per il calcolo della media geometrica aritmetica e della media geotmetica.

Media geometrica aritmetica
---------------------------

(define (media-geom-arit a b)
  (let ((eps 1e-10) (n1 0) (n2 0))
    (while (> (abs (sub a b)) eps)
      (setq n1 (div (add a b) 2))
      (setq n2 (sqrt (mul a b)))
      (setq a n1 b n2)
    )
    a))

(media-geom-arit 6 24)
;-> 13.45817148174518

Media geotmetica
----------------

(define (media-arit lst)
  (div (apply add lst) (length lst)))

(media-arit (sequence 1 10))
;-> 5.5

(define (media-geom lst)
  (pow (apply mul lst) (div 1 (length lst))))

(media-geom (sequence 1 10))
;-> 4.528728688116765

Per calcolare la mediana di n valori:
1) ordiniamo gli n valori in ordine crescente
2) se il numero n è dispari, la mediana corrisponde al valore centrale che ha posizione (n+1)/2.
3) se il numero n è pari, la mediana è la media aritmetica dei due valori delle posizioni (n/2) e ((n/2)+1)
Nota: gli indici dell'algoritmo iniziano da 1.

(define (mediana lst)
  (let (len (length lst))
    (sort lst)
    (if (odd? len)
        (lst (/ len 2))
        (div (add (lst (- (/ len 2) 1)) (lst (/ len 2))) 2))))

(setq a '(1.98 2.01 1.97 1.96 2.06))
(mediana '(1.98 2.01 1.97 1.96 2.06))
;-> 1.98

(setq b '(0 5 1 2 7 0 3 4 6 5))
(mediana '(0 5 1 2 7 0 3 4 6 5))
;-> 3.5

Verifichiamo le funzioni con i valori dell'esempio sopra (1 1 2 3 5):

(setq t '(1 1 2 3 5))
(media-arit t)
;-> 2.4
(media-geom t)
;-> 1.97435048583482
(mediana t)
;-> 2

Adesso scriviamo la funzione cha calcola la media geotmetica di n numeri positivi:

(define (media-geotmetica lst)
  (local (eps media-g media-a media-n)
    (setq eps 1e-6)
    (sort lst)
    (while (> (abs (sub (lst -1) (lst 0))) eps)
      (setq media-a (media-arit lst))
      (setq media-g (media-geom lst))
      (setq media-n (mediana lst))
      ;(println media-a { } media-g { } media-n)
      ;(read-line)
      (setq lst (sort (list media-a media-g media-n)))
    )
    (lst 0)))

(media-geotmetica '(1 1 2 3 5))
;-> 2.089057803502165


------------------------------------
Verificare l'esistenza di un simbolo
------------------------------------

Per verificare l'esistenza di un simbolo nella tavola dei simboli dobbiamo utilizzare la funzione "sym".
newLISP crea un simbolo "appena lo vede". Per verificare questo comportamento partiamo con una REPL nuova ed entriamo in un nuovo contesto (che non ha simboli):

(context 'demo)
;-> demo>

(symbols)
;-> ()

Se scriviamo un nome qualunque sulla REPL viene creato un simbolo:

test
;-> nil

Verifichiamo:

(symbols)
;-> (test)

La generazione del simbolo avviene anche quando l'espressione è errata:

(+ test x)
;-> ERR: value expected in function + : nil

Nota: quando si genera un errore newLISP ritorna al contesto principale MAIN.

Ritorniamo al contesto "demo" e vediamo i simboli:

(context 'demo)
(symbols)
;-> (test x)

Come si vede è stato creato il simbolo x.

Questo significa che newLISP crea/valuta gli argomenti di ogni funzione prima di applicare la funzione. Quindi, se volessimo sapere se un simbolo esiste nel contesto corrente non possiamo applicare una funzione qualunque (esempio "find") perchè crerebbe il simbolo prima di verificarne l'esistenza e qualunque argomento passato risulta esistente nel contesto:

(find 'a (symbols))
;-> 0
(symbols)
;-> (a test x)

Ma allora, come possiamo conoscere se un simbolo esiste in un determinato contesto?
Come abbiamo detto sopra, occorre utilizzare la funzione "sym". Per esempio se volessimo sapere se il simbolo "var" esiste possiamo scrivere:

(sym "var" demo nil)
;-> nil
(symbols)
;-> (d test x)

Il simbolo "var" non esiste nel contesto demo (e non viene neanche creato).

Proviamo con un simbolo esistente:

(sym "a" demo nil)
;-> a

Il problema è risolto. Comunque se volessimo scrive una funzione dobbiamo tenere conto dei seguenti comportamenti:

(symbols)
;-> (a test x)

Non possiamo passare un simbolo quotato "sym":

(sym 'b demo nil)
;-> b
(symbols)
;-> (a b test x)

Non possiamo passare un simbolo (che viene valutato):

(sym c demo nil)
;-> ERR: number or string expected in function sym : c

Quando la REPL genera un errore ritorna al contesto MAIN.

(context 'demo)
(symbols)
;-> (a b c test x)

Dobbiamo sempre passare la stringa del simbolo:

(sym "d" demo nil)
;-> nil

(sym "a" demo nil)
;-> a

Vediamo se possiamo passare un simbolo convertito in stringa:

(string a)
;-> nil
(string 'a)
;-> "a"
(sym (string 'a) demo nil)
;-> a
(symbols)
;-> (a b c test x)

Ma questo non funziona per i simboli che non esistono perchè (string 'd) genera il simbolo d prima di essere valutato da "sym".

(sym (string 'd) demo nil)
;-> d
(symbols)
;-> (a b c d test x)

Quindi dobbiamo sempre passare una stringa alla funzione "sym".

Scriviamo una funzione:

(define (simbolo? simbolo contesto)
    (sym simbolo (context) nil))

(symbols)
;-> (a b c contesto d simbolo simbolo? test x)

(simbolo? "a")
;-> a
(simbolo? "e")
;-> nil
(symbols)
;-> (a b c contesto d simbolo simbolo? test x)

Anche in questo caso non possiamo applicare "string" al simbolo:

(simbolo? (string 'k))
;-> k
(symbols)
;-> (a b c contesto d k simbolo simbolo? test x)

Però possiamo passare un simbolo (a) che viene valutato in una stringa ("m"):

(setq a "m")
(simbolo? a nil)
;-> nil
(symbols)
;-> (a b c contesto d k simbolo simbolo? test x)

(setq a "k")
(simbolo? a nil)
;-> k
(symbols)
;-> (a b c contesto d k simbolo simbolo? test x)

Per maggiori informazioni sui simboli vedere il paragrafo "Gestione dei simboli".


--------------
Primi troncati
--------------

Il numero 739 è primo. Se togliamo l'ultima cifra otteniamo 73, che è primo. Se togliamo l'ultima cifra otteniamo 7, che è primo.
Determinare tutti i numeri primi fino a 1000 milioni che hanno questa proprietà.

Funzione per calcolare i primi:

(define (primes-to num)
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let (lst '(2))
          (setq arr (array (+ num 1)))
          (for (x 3 num 2)
                (when (not (arr x))
                  (push x lst -1)
                  (for (y (* x x) num (* 2 x) (> y num))
                      (setf (arr y) true)))) lst))))

Funzione che prepara i dati:

(define (prepare-data num)
  (println "Calcolo numeri primi...")
  (setq primi (primes-to num))
  (println "Creazione coppie...")
  (setq coppie (map (fn(x) (list (string x) x)) primi))
  (println "Creazione hash-map delle coppie...")
  (new Tree 'phash)
  (phash coppie)
  (println "data ok."))

Funzione che calcola i primi con la proprietà definita:

(define (primi-troncati)
  ;ciclo per ogni primo...
  (dolist (p primi)
    ; tronca il numero primo
    (setq tronc (/ p 10))
    ; finchè il numero troncato ha almeno due cifre ed è primo...
    (while (and (> (length tronc) 1) (phash (string tronc)))
      ; tronca il numero
      (setq tronc (/ tronc 10))
    )
    ; se il numero troncato ha una cifra ed è primo,
    ; allora il numero primo originale verifica la condizione
    ; e viene stampato
    (if (and (= (length tronc) 1) (phash (string tronc))) (print p { }))
  ))

Proviamo con i primi fino a 1000:

(prepare-data 1000)
;-> Calcolo numeri primi...
;-> Creazione coppie...
;-> Creazione hash-map delle coppie...
;-> data ok.
(primi-troncati)
;-> 23 29 31 37 53 59 71 73 79 233 239 293 311
;-> 313 317 373 379 593 599 719 733 739 797

Proviamo con i primi fino a 100 milioni:

(prepare-data 1e8)
;-> "data-ok"
(primi-troncati)
;-> 23 29 31 37 53 59 71 73 79 233 239 293 311 313 317 373 379 593
;-> 599 719 733 739 797 2333 2339 2393 2399 2939 3119 3137 3733 3739
;-> 3793 3797 5939 7193 7331 7333 7393 23333 23339 23399 23993 29399
;-> 31193 31379 37337 37339 37397 59393 59399 71933 73331 73939 233993
;-> 239933 293999 373379 373393 593933 593993 719333 739391 739393
;-> 739397 739399 2339933 2399333 2939999 3733799 5939333 7393913
;-> 7393931 7393933 23399339 29399999 37337999 59393339 73939133


-------------------------
Contenimento del quadrato
-------------------------

Dato un quadrato K, prendiamo due punti casuali, A e B, all'interno del quadrato. Qual'è la probabilità che il quadrato di diagonale AB sia contenuto nel quadrato K?

Il risultato matematico vale 2/3 (0.66666...). Vediamo come è possibile verificarlo con una simulazione.

Per effettuare la simulazione dobbiamo risolvere il seguente problema geometrico: date le coordinate della diagonale di un quadrato (punti A e B), determinare le altre due coordinate del quadrato (punti C e D). La soluzione è la seguente:

  Calcolare il punto medio M di AB
  delta-x = coordX(A) - coordX(M)
  delta-y = coordY(A) - coordY(M)
  coordX(C) = coordX(M) + delta-y
  coordY(C) = coordY(M) - delta-x
  coordX(D) = coordX(M) - delta-y
  coordY(D) = coordY(M) + delta-x

Per capire meglio le formule, potete vedere una costruzione geometrica interattiva aprendo il file "quadrato.html" che si trova nella cartella "data" (è possibile muovere i punti A e B per vedere come cambia la costruzione).

Nota: senza perdere in generalità supponiamo che il quadrato K sia di coordinate (0,0), (0,1), (1,1) e (1,0). In questo modo i punti A e B sono contenuti tra 0 e 1.

Scrivamo la funzione di simulazione:

(define (interno? x)
  (and (>= x 0) (< x 1)))

(define (quadrato iter)
  (local (xa ya xb yb mx my delta-x delta-y dentro)
    (for (i 1 iter)
      (setq xa (random))
      (setq ya (random))
      (setq xb (random))
      (setq yb (random))
      (setq mx (div (add xa xb) 2))
      (setq my (div (add ya yb) 2))
      (setq delta-x (sub xa mx))
      (setq delta-y (sub ya my))
      (setq xc (add mx delta-y))
      (setq yc (sub my delta-x))
      (setq xd (sub mx delta-y))
      (setq yd (add my delta-x))
      (if (and (interno? xc) (interno? yc) (interno? xd) (interno? yd))
          (++ dentro)
      )
    )
    (div dentro iter)))

Verifichiamo il risultato teorico:

(quadrato 1000)
;-> 0.644

Aumentiamo il numero di iterazioni della simulazione:

(quadrato 1e7)
;-> 0.6667395

=============================================================================

