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


