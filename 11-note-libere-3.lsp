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


