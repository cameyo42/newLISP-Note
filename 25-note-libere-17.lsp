================

 NOTE LIBERE 17

================

----------
Home Prime
----------

L'Home Prime di un intero n è il valore ottenuto fattorizzando e concatenando ripetutamente i fattori primi di n (in ordine crescente, comprese le ripetizioni) fino a raggiungere un punto fisso (un numero primo).
Ad esempio, l'Home Prime HP(n) di 10 è 773, infatti:

   10=2*5 --> 25=5*5 --> 55=5*11 --> 511=7*73 --> 773 (primo)

Ci sono due modi equivalenti per terminare la sequenza:
a) Finisce con un numero primo
b) Raggiunge un punto fisso, poiché i fattori primi di un numero primo p sono proprio p.

Nota: l'HP di alcuni numeri è (nel 2023) sconosciuto (es. 49, 77, 80, 96)
Nota: l'HP di alcuni numeri è un big-integer (es. 48, 65, 86, 87)

Funzione per verificare se un numero intero è primo:

(define (prime? n)
  (if (< n 2) nil
      (= 1 (length (factor n)))))

Funzione per verificare se un numero big-integer è primo:

(define (prime-i? n)
  (if (< n 2) nil
      (= 1 (length (factor-i n)))))

(define (factor-i num)
"Factorize a big integer number"
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% num 2)) (push '2L out -1) (setq num (/ num 2)))
    (while (zero? (% num 3)) (push '3L out -1) (setq num (/ num 3)))
    (while (zero? (% num 5)) (push '5L out -1) (setq num (/ num 5)))
    (while (zero? (% num 7)) (push '7L out -1) (setq num (/ num 7)))
    (setq k 11L i 0)
    (while (<= (* k k) num)
      (if (zero? (% num k))
        (begin
          (push k out -1)
          (setq num (/ num k)))
        (begin
          (setq k (+ k (dist i)))
          (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> num 1) (push (bigint num) out -1))
    out))

Funzione che converte una stringa di big-integer in un big-integer:

(define (alpha-to-bigint s)
  (local (flag i val)
    (cond ((or (null? s) (< (length s) 1)) 0) ; stringa nulla, valore nullo
          (true
            (setq s (trim s))
            (replace "L" s "")
            (setq flag "+")
            (setq i 0)
            ; acquisizione segno
            (if (= (s 0) "-")
                (begin (setq flag "-") (++ i))
                (if (= (s 0) "+") (++ i))
            )
            (setq val 0L)
            (while (and (> (length s) i) (>= (s i) "0") (<= (s i) "9"))
              (setq val (+ (* val 10) (- (char (s i)) (char "0"))))
              (++ i)
            )
            ; controllo segno del risultato
            (if (= flag "-") (setq val (- 0 val)))
          )
    )
    val))

(alpha-to-bigint "11436234652346234562345623456234562560")
;-> 11436234652346234562345623456234562560L

(alpha-to-bigint "2L2L2L5L13L31L")
;-> 22251331L

Funzione che calcola l'Home Prime di un numero intero:

(define (HP num)
  (until (prime? num)
    (setq num (int (join (map string (factor num))) 0 10))
    ;(print num) (read-line)
  )
  num)

Funzione che calcola l'Home Prime di un numero big-integer:

(define (HP-i num)
  (until (prime-i? num)
    (setq num (alpha-to-bigint (join (map string (factor-i num)))))
    (println num)
  )
  num)

Calcoliamo gli Home Prime per i numeri da 2 a 100:

(setq MAX-INT 9223372036854775807)

I numeri 49, 77, 80, 96 non sono stati ancora calcolati.
I numeri 48, 65, 86, 87 hanno come soluzione un big-integer.

(setq interi
     '(2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27
       28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 50 51 52
       53 54 55 56 57 58 59 60 61 62 63 64 66 67 68 69 70 71 72 73 74 75 76
       78 79 81 82 83 84 85 88 89 90 91 92 93 94 95 97 98 99 100))

Calcoliamo gli HP della lista "numeri":

(time (dolist (el interi) (println el { } (HP el))))
;->  2 2                         50 3517
;->  3 3                         51 317
;->  4 211                       52 2213
;->  5 5                         53 53
;->  6 23                        54 2333
;->  7 7                         55 773
;->  8 3331113965338635107       56 37463
;->  9 311                       57 1129
;-> 10 773                       58 229
;-> 11 11                        59 59
;-> 12 223                       60 35149
;-> 13 13                        61 61
;-> 14 13367                     62 31237
;-> 15 1129                      63 337
;-> 16 31636373                  64 1272505013723
;-> 17 17                        66 2311
;-> 18 233                       67 67
;-> 19 19                        68 3739
;-> 20 3318308475676071413       69 33191
;-> 21 37                        70 257
;-> 22 211                       71 71
;-> 23 23                        72 1119179
;-> 24 331319                    73 73
;-> 25 773                       74 379
;-> 26 3251                      75 571
;-> 27 13367                     76 333271
;-> 28 227                       78 3129706267
;-> 29 29                        79 79
;-> 30 547                       81 193089459713411
;-> 31 31                        82 241
;-> 32 241271                    83 83
;-> 33 311                       84 2237
;-> 34 31397                     85 3137
;-> 35 1129                      88 719167
;-> 36 71129                     89 89
;-> 37 37                        90 71171
;-> 38 373                       91 236122171
;-> 39 313                       92 331319
;-> 40 3314192745739             93 331
;-> 41 41                        94 1319
;-> 42 379                       95 36389
;-> 43 43                        97 97
;-> 44 22815088913               98 277
;-> 45 3411949                   99 71143
;-> 46 223                      100 317047
;-> 47 47
;-> 11867.996

Elenco degli numeri il cui HP è big-integer:

 numero   HP          
 48                   6161791591356884791277
 65       1381321118321175157763339900357651 
 86                6012903280474189529884459
 87               41431881512748629379008933

Proviamo a calcolarli:

(setq big-int '(48 65 86 87))

(time (HP-i 48))
;-> 22223L
;-> 71313L
;-> 3112161L
;-> 313199401L
;-> 19431093517L
;-> 11171098771087L
;-> 231481703946591L
;-> 33753671034726207L
;-> 311251223678242069L
;-> 2345832952795526741L
;-> 35957822911130063089L
;-> 467793678496358995643L
;-> 6161791591356884791277L
;... interrotto

(time (HP-i 65))
;-> 513L
;-> 33319L
;-> 1113233L
;-> 11101203L
;-> 332353629L
;-> 33152324247L
;-> 3337473732109L
;-> 111801316843763L
;-> 151740406071813L
;-> 31313548335458223L
;-> 3397179373752371411L
;-> 157116011350675311441L
;-> 331333391143947279384649L
;-> 11232040692636417517893491L
;-> 711175663983039633268945697L
;-> 292951656531350398312122544283L
;... interrotto

(time (HP-i 86))
;-> 243L
;-> 33333L
;-> 341271L
;-> 3375417L
;-> 31125139L
;-> 476071091L
;-> 1453327647L
;-> 331137114067L
;-> 2314397265829L
;-> 1117891131230631L
;-> 37937943721284657L
;-> 3104571209331666867L
;-> 313732833853254754967L
;-> 7758315642293377850899L
;-> 74398355228357474772229L
;-> ... interrotto

(time (HP-i 87))
;-> 329L
;-> 747L
;-> 3383L
;-> 17199L
;-> 3337713L
;-> 333123619L
;-> 1719595507L
;-> 71477116631L
;-> 371931813963L
;-> 33371377951341L
;-> 373277569966803L
;-> 33318915032724013L
;-> 71137791373085335023L
;-> 3311968382673886045633L
;-> 4909674672720039496037L
;-> 7382186366507054593299L
;-> 3317106975833595192748879L
;-> ... interrotto

Elenco degli numeri il cui HP è sconosciuto (al 2023): 

(setq unknown '(49 77 80 96))

Vediamo dove possiamo arrivare:

(HP-i 49)
;-> 77L
;-> 711L
;-> 3379L
;-> 31109L
;-> 132393L
;-> 344131L
;-> 1731653L
;-> 71143523L
;-> 11115771019L
;-> 31135742029L
;-> 717261644891L
;-> 11193431873899L
;-> 116134799345907L
;-> 3204751189066719L
;-> 31068250396355573L
;-> 62161149980213343L
;-> 336906794442245927L
;-> 734615161567701999L
;-> 31318836286194043641L
;-> 333431436916146111627309L
;-> ... interrotto

(HP-i 77)
;-> 711L
;-> 3379L
;-> 31109L
;-> 132393L
;-> 344131L
;-> 1731653L
;-> 71143523L
;-> 11115771019L
;-> 31135742029L
;-> 717261644891L
;-> 11193431873899L
;-> 116134799345907L
;-> 3204751189066719L
;-> 31068250396355573L
;-> 62161149980213343L
;-> 336906794442245927L
;-> 734615161567701999L
;-> 31318836286194043641L
;-> 333431436916146111627309L
;-> ... interrotto

(HP-i 80)
;-> 22225L
;-> 557127L
;-> 33103601L
;-> 231439287L
;-> 3435333851L
;-> 31521212701L
;-> 1129831190513L
;-> 2491745343789L
;-> 313173758288603L
;-> 47109211289720051L
;-> 52190420751035931L
;-> 3713289276608832661L
;-> 13293974872480075829L
;-> 11131425912906831678277L
;-> 197525345682591170420821L
;-> ... interrotto

(HP-i 96)
;-> 222223L
;-> 613643L
;-> 1932297L
;-> 36110559L
;-> 312036853L
;-> 1743426863L
;-> 10716293709L
;-> 33311241149717L
;-> 161320651730409L
;-> 3232337980459861L
;-> 7131032111634389987L
;-> 77677113269579308471L
;-> 730413649039943138033L
;-> 73607245272587332597533L
;-> ... interrotto


-----------------------------------------
Generazione della permutazione successiva
-----------------------------------------

Data una lista, trovare la successiva permutazione lessicograficamente maggiore della lista data. 
Se non esiste alcuna permutazione maggiore, restituire la permutazione lessicograficamente più piccola della lista data.

Analizziamo alcuni esempi per vedere se riusciamo a riconoscere alcuni schemi.

(3 1 3) = il prossimo numero maggiore è 331
(5 1 3) = il prossimo numero maggiore è 531
(1 2 3) = il prossimo numero maggiore è 132
(1 3 5 4) = il prossimo numero maggiore è 1435
(3 2 1) = non possiamo formare un numero maggiore del numero corrente da tutte le possibili permutazioni

Quindi, è chiaro che per ottenere la prossima permutazione dovremo cambiare il numero in una posizione il più a destra possibile. Ogni permutazione (eccetto la prima) ha un suffisso crescente. 
Ora, se cambiamo il pattern dal punto di pivot (dove il suffisso crescente si interrompe) alla sua successiva possibile rappresentazione lessicografica, otterremo la successiva permutazione maggiore.

Per capire come cambiare il pattern da pivot, vediamo un esempio:

Sequenza iniziale:

  2 4 1 7 5 0

Trovare il suffisso non crescente più lungo: (7 5 0)
      _____
2 4 1 7 5 0

Cercare il pivot (1)
        _
    2 4 1 7 5 0

Trovare il successore più a destra di pivot nel suffisso: (5)
            _
    2 4 1 7 5 0

Scambiare il pivot con il successore più a destra: (1 e 5)
         _   _
     2 4 5 7 1 0

Invertire il suffisso: (0 1 7)
           _____  
     2 4 5 0 1 7

Sequenza finale:

     2 4 5 0 1 7

Algoritmo:
Attraversare la lista dalla fine e trovare il primo indice (pivot) che non segue la proprietà del suffisso non crescente, (cioè, lst(i) < lst(i + 1)).
Se l'indice pivot non esiste significa che la sequenza data nella lista è la più grande possibile.
In questo caso occorre invertire la lista.
Se l'indice del pivot esiste, allora attraversare la lista dalla fine e trovare il successore del pivot nel suffisso.
Scambiare il pivot e il successore.
Ridurre al minimo la parte del suffisso invertendo la lista da (pivot + 1) fino a N.

Vediamo una possibile implementazione:

(define (reverse-part obj idx len)
  (extend (slice obj 0 idx)             ; parte a sinistra dell'inversione
          (reverse (slice obj idx len)) ; parte dell'inversione
          (slice obj (+ idx len))))     ; parte a destra dell'inversione

(define (next-perm lst)
  (local (len idx jdx stop continua)
    (setq len (length lst))
    (setq idx -1 stop nil)
    ; Cerca il pivot
    ; Un pivot è il primo elemento dalla fine della sequenza
    ; che non segue la proprietà del suffisso non crescente
    (for (i (- len 2) 0 -1 stop)
      (if (< (lst i) (lst (+ i 1)))
          (setq idx i stop true)
      )
    )
    (cond
      ; Pivot non trovato
      ((< idx 0) (reverse lst))
      ; Pivot trovato
      (true
        ; Trova il successore del pivot nel suffisso
        (setq jdx (- len 1))
        (setq continua true)
        (while (and (> jdx idx) continua)
          (if (> (lst jdx) (lst idx)) (setq continua nil))
          (-- jdx)
        )
        (++ jdx)
        ; scambia il pivot con il successore
        (swap (lst idx) (lst jdx))
        ; minimizza il suffisso
        (reverse-part lst (+ idx 1) (- len idx))))))

Facciamo alcune prove:

(next-perm '(4 3 2 1))
;-> (1 2 3 4)

(next-perm '(1 2 3 4))
;-> (1 2 4 3)

Verifichiamo la correttezza della funzione "next-perm" confrontando i risultati con quelli della funzione "perm":

(define (perm lst)
"Generates all permutations without repeating from a list of items"
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

(setq base (sort (perm '(1 2 3 4 5))))
(length base)
;-> 120

(setq p '(1 2 3 4 5))
(for (i 1 119)
  (print (base i) { } (setq p (next-perm p)))
  (read-line)
)
;-> (1 2 3 5 4) (1 2 3 5 4)
;-> (1 2 4 3 5) (1 2 4 3 5)
;-> (1 2 4 5 3) (1 2 4 5 3)
;-> (1 2 5 3 4) (1 2 5 3 4)
;-> (1 2 5 4 3) (1 2 5 4 3)
;-> ...
;-> (5 4 1 2 3) (5 4 1 2 3)
;-> (5 4 1 3 2) (5 4 1 3 2)
;-> (5 4 2 1 3) (5 4 2 1 3)
;-> (5 4 2 3 1) (5 4 2 3 1)
;-> (5 4 3 1 2) (5 4 3 1 2)
;-> (5 4 3 2 1) (5 4 3 2 1)

Versione equivalente:

(define (next-perm1 lst)
  (local (len idx jdx stop continua)
    (setq len (length lst))
    (setq idx -1 stop nil)
    ; Cerca il pivot
    ; Un pivot è il primo elemento dalla fine della sequenza
    ; che non segue la proprietà del suffisso non crescente
    (setq idx (- len 2))
    (setq continua true)
    (while (and (> idx -1) continua)
      (if (< (lst idx) (lst (+ idx 1)))
          (setq continua nil)
          (-- idx)
      )
    )
    (cond
      ; Pivot non trovato (è l'ultima permutazione)
      ; inverte la lista (prima permutazione)
      ; (oppure potrebbe ritornare nil)
      ((< idx 0) (reverse lst))
      ; Pivot trovato
      (true
        ; Trova il successore del pivot nel suffisso
        (setq jdx (- len 1))
        (setq continua true)
        (while (and (> jdx idx) continua)
          (if (> (lst jdx) (lst idx))
              (setq continua nil)
              (-- jdx)
          )
        )
        ; scambia il pivot con il successore
        (swap (lst idx) (lst jdx))
        ; minimizza (inverte) il suffisso
        (setq jdx (- len 1))
        (setq idx (+ idx 1))
        (while (< idx jdx)
          (swap (lst idx) (lst jdx))
          (++ idx)
          (-- jdx)
        )
        lst))))

Controllo stessi risultati delle due funzioni "next-perm" e "next-perm1":

(for (i 1 1000)
  (setq t (rand 10 8))
  (if (!= (next-perm t) (next-perm1 t)) (println "ERROR:"  t)))
;-> nil


------------------
Sequenza di Levine
------------------

Nell'estate del 1997 il matematico Lionel Levine scoprì questa sequenza di numeri: 

  1, 2, 2, 3, 4, 7, 14, 42, 213, 2837, ...

La sequenza è composta dal termine finale di ogni riga di questa lista:

 1 1
 1 2
 1 1 2
 1 1 2 3
 1 1 1 2 2 3 4
 1 1 1 1 2 2 2 3 3 4 4 5 6 7
 1 1 1 1 1 1 1 2 2 2 2 2 2 3 3 3 3 3 4 4 4 4 5 5 5 5 6 6 6 7 7 7 8 8 9 9 10 10 11 12 13 14
 ...

La lista è costruita con una semplice regola. 
Inizia con 1 1 e considera ogni riga come base per costruire quella successiva: leggila da destra a sinistra e considerala come un inventario di cifre. 
La prima riga, 1 1, verrebbe letta "un 1 e un 2", quindi otteniamo 1 2 per la seconda riga. 
La seconda riga (sempre leggendo da destra a sinistra) verrebbe letta "due 1 e un 2", dando 1 1 2 per la terza riga.
La terza riga veerrebbe letta "due 1, un 2 e un 3", dando 1 1 2 3 per la quarta riga.
E così via. 
Questo sembra semplice, eppure il ventesimo termine non è ancora stato calcolato.
Il 15-esimo termine vale: 508009471379488821444261986503540.

Sequenza OEIS A011784:
  1, 2, 2, 3, 4, 7, 14, 42, 213, 2837, 175450, 139759600, 6837625106787, 
  266437144916648607844, 508009471379488821444261986503540, 37745517525533091954736701257541238885239740313139682, ...

(define (levine limite)
  (local (curr next idx val out)
    (setq out '(1))
    (setq curr '(1 1))
    (for (i 1 (- limite 1))
      (setq next '())
      (setq idx 1)
      (for (i (- (length curr) 1) 0)
        (setq val (dup idx (curr i)))
        (extend next val)
        (++ idx)
      )
      (setq curr next)
      ;(println (curr -1))
      (push (curr -1) out -1)
    )
    out))

Facciamo alcune prove:

(time (println (levine 8)))
;-> (1 2 2 3 4 7 14 42)
;-> 0
(time (println (levine 9)))
;-> (1 2 2 3 4 7 14 42 213)
;-> 0
(time (println (levine 10)))
;-> (1 2 2 3 4 7 14 42 213 2837)
;-> 15.587
(time (println (levine 11)))
;-> (1 2 2 3 4 7 14 42 213 2837 175450)
;-> 29784.242
(time (println (levine 12)))
...interrotto dopo più di 30 minuti.

Non credo che con questa funzione si possa arrivare molto più lontano.


---------------------------------------
Spazio campionario di N lanci di monete
---------------------------------------

Dato un numero intero positivo N come input, generare lo spazio campionario di N lanci consecutivi di monete. 
La moneta è giusta, cioè le due facce Testa e Croce hanno ciascuna probabilità 0.5.

Per esempio con N=3 lo spazio campionario è il seguente:

  TTT, TTC, TCT, TCC, CTT, CTC, CCT, CCC

La soluzione consiste nel calcolare le permutazioni di 2 elementi (T e C) con N ripetizioni.
Il numero di elementi dello spazio campionario vale: 2^N.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

(perm-rep 3 '(T C))
;-> ((T T T) (C T T) (T C T) (C C T) (T T C) (C T C) (T C C) (C C C))

(perm-rep 4 '(T C))
;-> ((T T T T) (C T T T) (T C T T) (C C T T) (T T C T) (C T C T) (T C C T) 
;->  (C C C T) (T T T C) (C T T C) (T C T C) (C C T C) (T T C C) (C T C C)
;->  (T C C C) (C C C C))
 
(length (perm-rep 12 '(1 0)))
;-> 4096
(pow 2 12)
;-> 4096


------------------------------------
Indovina il numero (con un bugiardo)
------------------------------------

Si tratta di un gioco per due giocatori.
Il primo pensa ad un numero da 1 a N.
Il secondo prova ad indovinare il numero pensato proponendo un numero.
Il primo giocatore deve dire se il numero proposto è "uguale" (fine del gioco) "maggiore" o "minore" al numero che ha pensato.
A questo punto il secondo giocatore propone un nuovo numero, il primo risponde e si continua in questo modo fino a quando non viene indovinato il numero pensato.

Purtroppo il secondo giocatore è un pò bugiardo (cioè non dice sempre la verità).
Il suo comportamento è il seguente:
1) una volta dice il vero e una volta potrebbe dire il falso (cioè potrebbe dire o il vero o il falso).
2) non si conosce se comincia dicendo il vero oppure dicendo o il falso o il vero.
3) se il numero proposto è uguale al numero pensato, allora dice sempre la verità.

(define (start limite)
  (setq num (+ (rand limite) 1))
  (setq prove 0)
  (setq r (rand 2))
  (if (zero? r)
    (setq f1 odd?  f2 even?) ; odd/dispari = vero,  even/pari = falso
    (setq f1 even? f2 odd?)) ; odd/dispari = falso, even/pari = vero
  '---)

(define (guess val)
  (local (bugiardo)
  (++ prove)
  (cond
    ((= val num)
      (println "Esatto. " prove " tentativi"))
    ((> num val)
      (cond
        ((f1 prove) ; dice il vero
          (println val " è minore del numero."))
        ((f2 prove) ; potrebbe dire il falso
          (if (zero? (rand 2)) ; se esce 0 dice il falso
            (println val " è maggiore del numero.")
            ; altrimenti dice il vero
            (println val " è minore del numero.")))))
    ((< num val)
      (cond
        ((f1 prove) ; dice il vero
          (println val " è maggiore del numero."))
        ((f2 prove) ; potrebbe dire il falso
          (if (zero? (rand 2)) ; se esce 0 dice il falso
            (println val " è minore del numero.")
            ; altrimenti dice il vero
            (println val " è maggiore del numero."))))))
  '---))

Provate a indovinare il numero... senza trucchi.

(start 10)
num
;-> 7
f1
;-> odd?@411571
f2
;-> even?@411584
(guess 5)
;-> 5 è minore del numero.


--------------------------------------
"Semplice" esercizio di programmazione
--------------------------------------

L'esercizio sembra molto semplice: stampare "love newLISP" senza i doppi apici, cioè stampare:

love newLISP

Comunque ci sono delle regole da rispettare:
1) non è possibile utilizzare i caratteri "", '', ', {}.
2) non è possibile utilizzare i caratteri numeri (0..9)
3) il programma deve essere il più corto possibile

Una possibile soluzione è quella di utilizzare "read-line" per inserire la stringa da stampare e poi utilizzare "sym" per rendere la stringa un simbolo che viene poi emesso dalla REPL:

(sym(read-line))
love newLISP
;-> love newLISP


----------------------------
Distanza tra coppia di primi
----------------------------

Dato un intero positivo N, scrivere una funzione che restituisce una coppia qualunque di numeri primi la cui differenza è N.

Esempi:

2 -> (3 5) oppure (11 13) oppure (29 31) oppure ...
3 -> (2 5) 
4 -> (3 7) oppure (19 23) oppure ...

Per alcuni valori di N non è sicuro che esista una coppia di primi valida (cioè a distanza N).

Algoritmo
Calcolare i primi fino ad un dato limite
Ciclo su questi primi
  Se (primo-corrente + N) è primo, allora abbiamo trovato una soluzione
Restituire la soluzione o nil

(define (prime? n)
  (if (< n 2) nil
      (= 1 (length (factor n)))))

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

(define (coppia dist limite)
  (local (out primi trovato)
    (setq out nil)
    (setq primi (primes-to limite))
    (setq trovato nil)
    (dolist (p primi trovato)
      (if (prime? (+ p dist)) 
        (begin
          (setq trovato true)
          (setq out (list p (+ p dist)))
        )
      )
    ) 
    out))

Facciamo alcune prove:

(coppia 2 1e4)
;-> (3 5)
(coppia 3 1e4)
;-> (2 5)
(coppia 42 1e4)
;-> (5 47)

Con N=7 non ho trovato nessuna coppia:
(coppia 7 1e7)
;-> nil

Applichiamo la funzione per valori di N da 1 a 20:

(map (fn(x) (list x (coppia x 1e7))) (sequence 1 20))
;-> ((1 (2 3)) (2 (3 5)) (3 (2 5)) (4 (3 7)) (5 (2 7)) (6 (5 11)) 
;->  (7 nil) (8 (3 11)) (9 (2 11)) (10 (3 13)) (11 (2 13)) (12 (5 17))
;->  (13 nil) (14 (3 17)) (15 (2 17)) (16 (3 19)) (17 (2 19)) (18 (5 23))
;->  (19 nil) (20 (3 23)))

Per N = 7, 13 e 19 non ho trovato soluzioni.


----------------------
Coppie autogrammatiche
----------------------

Abbiamo due funzioni, P e Q, entrambi nella stesso linguaggio (newLISP).
Ciascuno di essi riceve un input di un solo carattere.
Se P riceve il carattere K, P dice quante volte K appare in Q.
Viceversa: se Q riceve K, Q dice quante volte K appare in P.

In newLISP una funzione è anche una lista

(define (P ch)
  (length (find-all ch (string Q))))

(define (Q ch)
  (length (find-all ch (string P))))

(string Q)
;-> "(lambda (ch) (length (find-all ch (string P))))"
(string P)
;-> "(lambda (ch) (length (find-all ch (string Q))))"

Facciamo alcune prove:

(P "c")
;-> 2
(Q "c")
;-> 2
(P "P")
;-> 1
(P "Q")
;-> 0
(Q "Q")
;-> 1
(Q "P")
;-> 0


---------------
Numeri di Peano
---------------

I numeri di Peano sono un modo semplice di rappresentare i numeri naturali usando solo il valore zero e una funzione successore:

  0 = 0
  1 = Succ(0)
  2 = Succ(Succ(0))

Rappresentiamo i numeri di Peano con le liste:

  0 = (Z)
  1 = (S (Z))
  2 = (S (S (Z)))

Per trattare con i numeri di Peano scriviamo due funzioni che convertono un numero intero in un numero di Peano (lista) e viceversa.
In questo modo possiamo utilizzare le normali operazioni sui numeri interi.

Funzione che converte un numero intero in un numero di Peano (lista):

(define (numero-peano num)
  (if (= num 0) (cons 'Z)
      (cons 'S (cons (peano (- num 1))))))

Facciamo alcune prove:

(numero-peano 0)
;-> (Z)
(numero-peano 1)
;-> (S (Z))
(numero-peano 10)
;-> (S (S (S (S (S (S (S (S (S (S (Z)))))))))))

(setq lst (numero-peano 4))
;-> (S (S (S (S (Z)))))

La seguente funzione restituisce gli indici di tutti gli elementi di una lista:

(ref-all nil lst (fn (x) true))
;-> ((0) (1) (1 0) (1 1) (1 1 0) (1 1 1) (1 1 1 0) (1 1 1 1) (1 1 1 1 0))

Adesso possiamo calcolare il valore di un numero di peano:

  valore = lunghezza(ultimo elemento) - 1

Funzione che converte un numero di Peano (lista) in un numero intero:

(define (peano-numero lst)
  (- (length ((ref-all nil lst (fn (x) true)) -1)) 1))

Facciamo alcune prove:

(peano-numero '(Z))
;-> 0
(peano-numero '(S(Z)))
;-> 1
(peano-numero (peano 42))
;-> 42

Funzione che applica l'operatore "op" (+,-,*,/) a due numeri di Peano:

(define (arit-peano op p1 p2)
  (op (peano-numero p1) (peano-numero p2)))

(arit-peano * '(S (S (Z))) '(S (S (S (S (S (S (S (S (S (S (Z))))))))))))
;-> 20

(arit-peano + (numero-peano 32) (numero-peano 10))
;-> 42

Nota: solo numeri naturali come operatori e come risultato.


---------------------------------------
Numerazione delle pagine di un giornale
---------------------------------------

Un giornale è composto da più fogli.
Ogni foglio del giornale contiene quattro pagine del giornale finale.
Ecco un esempio di un giornale con tre fogli che compongono un giornale di dodici pagine:

   ___________
  |2    |   11|
  |  ___|_____|_
  | |4    |    9|
  |_|  ___|_____|_
    | |6    |    7|
    |_|     |     |
      |     |     |
      |_____|_____|

   ___________
  |12   |    1|
  |  ___|_____|_
  | |10   |    3|
  |_|  ___|_____|_
    | |8    |    5|
    |_|     |     |
      |     |     |
      |_____|_____|

Scrivere una funzione che genera la numerazione dei fogli dal giorrnale (4 numeri per ogni foglio).
Per esempio, con 3 fogli (12 pagine), si ottiene:

  (1 12 2 11) (3 10 4 9) (5 8 6 7)

Funzione di numerazione delle pagine:

(define (numera2 fogli)
  (local (nums left right)
    (setq nums (dup '() fogli))
    (setq left 0)
    (setq right (+ (* fogli 4) 1))
    (for (f 0 (- fogli 1))
      (push (++ left) (nums f) -1) 
      (push (-- right) (nums f) -1)
      (push (++ left) (nums f) -1) 
      (push (-- right) (nums f) -1)
    )
    nums))

(numera2 3)
;-> ((1 12 2 11) (3 10 4 9) (5 8 6 7))

(numera2 5)
;-> ((1 20 2 19) (3 18 4 17) (5 16 6 15) (7 14 8 13) (9 12 10 11))

(numera2 10)
;-> ((1 40 2 39) (3 38 4 37) (5 36 6 35) (7 34 8 33) (9 32 10 31) 
;->  (11 30 12 29) (13 28 14 27) (15 26 16 25) (17 24 18 23) (19 22 20 21))


---------------------
Vicini di Von Neumann
---------------------

Date le coordinate di una cella (x,y) e una distanza r, restituire tutte le celle che hanno una distanza di Manhattan uguale o inferiore a r (vicini di VonNeumann).

Distanza di manhattan = 1

          (x,y-1)
  (x-1,y)  (x,y)  (x+1,y)
          (x,y+1)

Distanza di manhattan = 2

                    (x,y-2)
          (x-1,y-1) (x,y-1) (x+1,y-1)
  (x-2,y)  (x-1,y)   (x,y)   (x+1,y)  (x+2,y)
          (x-1,y+1) (x,y+1) (x+1,y+1)
                    (x,y+2)

Calcola la distanza di Manhattan (4 direzioni - torre) di due punti P1=(x1 y1) e P2=(x2 y2):

(define (manhattan x1 y1 x2 y2)
  (add (abs (sub x1 x2)) (abs (sub y1 y2))))

(manhattan 1 1 -1 -1)
;-> 4

Funzione che calcola i vicini di VonNeumann di una cella (x,y) con distanza minore o uguale a r:

(define (vicini x y r)
  (let (out '())
    (for (a (- x r) (+ x r))
      (for (b (- y r) (+ y r))
        (if (<= (manhattan x y a b) r) (push (list a b) out -1))
      )
    )
    (unique out)))

(vicini 0 0 2)
;-> ((-2 0) (-1 -1) (-1 0) (-1 1) (0 -2) (0 -1) (0 0) 
;->  (0 1) (0 2) (1 -1) (1 0) (1 1) (2 0))

Funzione che disegna i vicini di VonNeumann di una cella (x,y) con distanza minore o uguale a r:

(define (draw-vicini x y r)
  (local (neib trasla-x trasla-y m)
    (setq neib (vicini x y r))
    (setq trasla-x (abs (apply min (map first neib))))
    (setq trasla-y (abs (apply min (map last neib))))
    (setq m (array (+ x trasla-x r 1) (+ y trasla-y r 1) '(.)))
    ;(println trasla-x { } trasla-y)
    (dolist (el neib)
      (setf (m (+ trasla-x (el 0)) (+ trasla-y (el 1))) 1)
    )
    m))

(draw-vicini -2 -4 3)
;-> ((. . . 1 . . .) 
;->  (. . 1 1 1 . .) 
;->  (. 1 1 1 1 1 .) 
;->  (1 1 1 1 1 1 1) 
;->  (. 1 1 1 1 1 .)
;->  (. . 1 1 1 . .)
;->  (. . . 1 . . .))

(draw-vicini -2 -4 5)
;-> ((. . . . . 1 . . . . .) 
;->  (. . . . 1 1 1 . . . .) 
;->  (. . . 1 1 1 1 1 . . .) 
;->  (. . 1 1 1 1 1 1 1 . .)
;->  (. 1 1 1 1 1 1 1 1 1 .)
;->  (1 1 1 1 1 1 1 1 1 1 1)
;->  (. 1 1 1 1 1 1 1 1 1 .)
;->  (. . 1 1 1 1 1 1 1 . .)
;->  (. . . 1 1 1 1 1 . . .)
;->  (. . . . 1 1 1 . . . .)
;->  (. . . . . 1 . . . . .))

(draw-vicini 2 4 3)
;-> ((. . . . . 1 . . .) 
;->  (. . . . 1 1 1 . .) 
;->  (. . . 1 1 1 1 1 .) 
;->  (. . 1 1 1 1 1 1 1)
;->  (. . . 1 1 1 1 1 .)
;->  (. . . . 1 1 1 . .)
;->  (. . . . . 1 . . .))

=============================================================================

