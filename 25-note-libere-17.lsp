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


-------------------
Maggior numero di 1
-------------------

Data una lista di numeri interi, trovare l'elemento che ha il maggior numero di bit impostati a 1.

(define (max-uno lst)
  (local (max-1 val-max-1 val-1)
    (setq max-1 0)
    (setq val-max-1 0)
    (dolist (el lst)
      (setq val-1 (length (find-all "1" (bits el))))
      (if (> val-1 max-1) (setq max-1 val-1 val-max-1 el))
    )
    (list val-max-1 max-1)))

Facciamo alcune prove:

(max-uno (sequence 1 100))
;-> (63 6)

(max-uno '(2141234 127168 11674 233871))
;-> (233871 10)

(setq nums (rand 1e7 100))
(max-uno nums)
;-> (8346812 16)


---------------------------------------
Fattorizzazione di una forma quadratica
---------------------------------------

Fattorizzare una espressione quadratica significa esprimere la forma quadratica dell'espressione come prodotto di due monomi:

  f(x) = ax² + bx + c = k(x - x1)(x- x2)

Passo 1: identificare una data funzione quadratica e semplificarla completamente se necessario
Passo 2: assicurati che la funzione sia nella forma f(x) = ax² + bx + c
Passo 3: trovare le radici x1 e x2 utilizzando la formula:

           -b +- sqrt(b^2 - 4ac)
  x1,x2 = -----------------------
                    2a

Passo 4: la fattorizzazione vale: f(x) = ax² + bx + c = a(x - x1)(x-x2)

Nota: il metodo sopra funziona indipendentemente dal fatto che le radici siano reali o meno.

Se la forma quadratica è del tipo x^2 + ax + b una tecnica comune è trovare due numeri p e q tali che:

  p + q = a
  pq = b

Scriviamo una funzione che risolve questo caso (solo per equazioni con soluzioni reali):

(define (fattorizza a b)
  (local (p q)
   (setq p (add (div a 2) (sqrt (sub (div (mul a a) 4) b))))
   (setq q (sub a p))
   (list p q)))

Facciamo alcune prove:

(fattorizza 2 -15)
;-> (5 -3)
(fattorizza -22 85)
;-> (-5 -17)
(fattorizza 6 -16)
;-> (8 -2)
(fattorizza -8 -240)
;-> (12 -20)
(fattorizza -1 -272)
;-> (16 -17)
(fattorizza 17 16)
;-> (16 1)
(fattorizza -4 0)
;-> (0 -4)
(fattorizza 3 -54)
;-> (9 -6)
(fattorizza 13 40)
;-> (8 5)
(fattorizza -29 198)
;-> (-11 -18)
(fattorizza 11 -12)
;-> (12 -1)
(fattorizza 4 -320)
;-> (20 -16)
(fattorizza 4 4)
;-> (2 2)


--------------------------------
Numeri palindromi senza quadrati
--------------------------------

Un numero palindromo è un numero che ha lo stesso valore se letto da sinistra a destra o da destra a sinistra.
Un numero senza quadrati (square-free) non è divisibile esattamente per un numero quadrato (cioè non contiene un fattore primo ripetuto).
Ad esempio, 44=22*11 non è senza quadrati, mentre 66=2*3*11 è senza quadrati.

Sequenza OEIS A071251:
  1, 2, 3, 5, 6, 7, 11, 22, 33, 55, 66, 77, 101, 111, 131, 141, 151, 161,
  181, 191, 202, 222, 262, 282, 303, 313, 323, 353, 373, 383, 393, 434, 454,
  474, 494, 505, 515, 535, 545, 555, 565, 595, 606, 626, 646, 707, 717, ...

Funzione per verificare se un dato numero è palindromo senza quadrati:

(define (pali-sqfree? num)
  (cond
    ((< num 1) nil)
    ((= num 1) true)
    (true
      (let ((f (factor num)) (s (string num)))
        (and (= s (reverse (copy s)))
            (= f (unique f)))))))

Facciamo alcune prove:

(pali-sqfree? 44)
;-> nil
(pali-sqfree? 66)
;-> true
(pali-sqfree? 77)
;-> true

(filter pali-sqfree? (sequence 1 500))
;-> (1 2 3 5 6 7 11 22 33 55 66 77 101 111 131 141 151 161 181 191
;->  202 222 262 282 303 313 323 353 373 383 393 434 454 474 494)


----------------------------------------------------------
Notazioni: Snake case, Kebab case, Camel case, Pascal Case
----------------------------------------------------------

Quasi tutti i linguaggi di programmazione hanno un metodo standard che utilizza le maiuscole e le minuscole per nominare le variabili. I principali metodi di notazione sono i seguenti:

1) (snake_case)
   Snake Case: tutte le lettere sono minuscole, con caratteri di sottolineatura che separano le parole.

2) (kebab-case)
   Kebab Case: tutte le lettere sono minuscole, con trattini che separano le parole.

3) (camelCase)
   Camel Case: la prima lettera di ogni parola dopo la prima è in maiuscolo, senza spazi.

4) (PascalCase)
   Pascal Case: La prima lettera di ogni parola è in maiuscolo, senza spazi.

Nota: in newLISP si usa in genere la notazione "kebab-case" con qualche eccezione per variabili che cominciano con una maiuscola.

Non credo ci sarà mai un accordo su un singolo sistema da utilizzare e dobbiamo alternare tra i vari metodi.

Scrivere una funzione che converte tra i vari metodi di notazione.

(define (upper? ch) (and (>= ch "A") (<= ch "Z")))

(define (nota metodo str)
  (local (out len next-upper)
    ;(setq str (lower-case str))
    (setq out "")
    (setq len (length str))
    (cond
      ((= metodo 1) ; to snake_case
        (replace "-" str "_")
        (for (i 0 (- len 1))
          (if (and (upper? (str i)) (!= i 0) (!= (out -1) "_"))
              (extend out "_")
          )
          (extend out (lower-case (str i)))
        )
      )
      ((= metodo 2) ; to kebab_case
        (replace "_" str "-")
        (for (i 0 (- len 1))
          (if (and (upper? (str i)) (!= i 0) (!= (out -1) "-"))
              (extend out "-")
          )
          (extend out (lower-case (str i)))
        )
      )
      ((= metodo 3) ; to camelCase
        (for (i 0 (- len 1))
          (cond ((or (= (str i) "-") (= (str i) "_"))
                  (setq next-upper true))
                (next-upper
                  (extend out (upper-case (str i)))
                  (setq next-upper nil))
                (true
                  (if (zero? i)
                    (extend out (lower-case (str i)))
                    (extend out (str i))))
          )
        )
      )
      ((= metodo 4) ; to PascalCase
        (for (i 0 (- len 1))
          (cond ((or (= (str i) "-") (= (str i) "_"))
                  (setq next-upper true))
                (next-upper
                  (extend out (upper-case (str i)))
                  (setq next-upper nil))
                (true
                  (if (zero? i)
                      (extend out (upper-case (str i)))
                      (extend out (str i))))
          )
        )
      )
    )
    out))

Facciamo alcune prove:

(setq tipi '("snake_case" "kebab-case" "camelCase" "PascalCase"))
(map (curry nota 1) tipi)
;-> ("snake_case" "kebab_case" "camel_case" "pascal_case")
(map (curry nota 2) tipi)
;-> ("snake-case" "kebab-case" "camel-case" "pascal-case")
(map (curry nota 3) tipi)
;-> ("snakeCase" "kebabCase" "camelCase" "pascalCase")
(map (curry nota 4) tipi)
;-> ("SnakeCase" "KebabCase" "CamelCase" "PascalCase")

(setq lst '("this-Var" "This-Var" "this-var" "thisVar" "This_Var" "This-var"))
(map (curry nota 1) lst)
;-> ("this_var" "this_var" "this_var" "this_var" "this_var" "this_var")
(map (curry nota 2) lst)
;-> ("this-var" "this-var" "this-var" "this-var" "this-var" "this-var")
(map (curry nota 3) lst)
;-> ("thisVar" "thisVar" "thisVar" "thisVar" "thisVar" "thisVar")
(map (curry nota 4) lst)
;-> ("ThisVar" "ThisVar" "ThisVar" "ThisVar" "ThisVar" "ThisVar")

(setq lst '("_sotTo" "ABcDE" "ab-cd-fg" "_A"))
(map (curry nota 1) lst)
;-> ("_sot_to" "a_bc_d_e" "ab_cd_fg" "_a")
(map (curry nota 2) lst)
;-> ("-sot-to" "a-bc-d-e" "ab-cd-fg" "-a")
(map (curry nota 3) lst)
;-> ("SotTo" "aBcDE" "abCdFg" "A")
(map (curry nota 4) lst)
;-> ("SotTo" "ABcDE" "AbCdFg" "A")


-----------------
Radicale perfetto
-----------------

Dato un numero intero positivo n trovare il suo radicale perfetto.

Un radicale perfetto r di un intero positivo n è la radice intera più piccola di n di qualsiasi indice k:

  r = n^(1/k)

dove r è un numero intero.

In altre parole k è l'esponente massimo tale che r elevato a k vale n:

  n = r^k

Sequenza OEIS A052410:
  1, 2, 3, 2, 5, 6, 7, 2, 3, 10, 11, 12, 13, 14, 15, 2, 17, 18, 19, 20,
  21, 22, 23, 24, 5, 26, 3, 28, 29, 30, 31, 2, 33, 34, 35, 6, 37, 38, 39,
  40, 41, 42, 43, 44, 45, 46, 47, 48, 7, 50, 51, 52, 53, 54, 55, 56, 57,
  58, 59, 60, 61, 62, 63, 2, 65, 66, 67, 68, 69, 70, 71, ...

Funzione che trova il radicale perfetto di un numero:

(define (radicale num)
  (if (= num 1) 1
  ;else
  (local (k r)
    (setq k num)
    (setq r (pow num (div k)))
    ;(println r { } (mod r 1))
    ;(while (and (!= (mod r 1) 0) (> k 0))
    (while (!= (mod r 1) 0)
      (setq r (pow num (div k)))
      ;(println r { } (mod r 1))
      (-- k)
    )
    ;(print (list num r (+ k 1)) { })
    r)))

(map radicale (sequence 1 50))
;-> (1 2 3 2 5 6 7 2 3 10 11 12 13 14 15 2 17 18 19 20 21 22 23 24 5 26 3
;->  28 29 30 31 2 33 34 35 6 37 38 39 40 41 42 43 44 45 46 47 48 7 50)

Funzione che calcola il radicale perfetto da 1 fino ad un certo limite:

def upto(n):
    list = [1] + [0] * (n - 1)
    for i in range(2, n + 1):
        if not list[i - 1]:
            j = i
            while j <= n:
                list[j - 1] = i
                j *= i
    return list

(define (radicali limite)
  (setq rad (array limite '(0)))
  (setf (rad 0) 1)
  (for (i 2 limite)
    (if (zero? (rad (- i 1)))
      (begin
        (setq j i)
        (while (<= j limite)
          (setf (rad (- j 1)) i)
          (setq j (* j i)))))
  )
  rad)

(radicali 50)
;-> (1 2 3 2 5 6 7 2 3 10 11 12 13 14 15 2 17 18 19 20 21 22 23 24 5 26 3
;->  28 29 30 31 2 33 34 35 6 37 38 39 40 41 42 43 44 45 46 47 48 7 50)


-----------------------
Moltiplicare o dividere
-----------------------

Iniziare con 1. Continuare moltiplicando o dividendo per n.
Moltiplicare per n quando a(n-1) è minore di n.
Dividere per n quando a(n-1) è maggiore di n e prendere il valore intero
(questo serve a garantire che a(n) > 0 per ogni n)
La definizione matematica della sequenza è la seguente:

         | n*a(n-1), se a(n-1) < n,
  a(n) = |
         | floor(a(n-1)/n), altrimenti.

Sequenza OEIS A076039:
  1, 2, 6, 1, 5, 30, 4, 32, 3, 30, 2, 24, 1, 14, 210, 13, 221, 12, 228, 11,
  231, 10, 230, 9, 225, 8, 216, 7, 203, 6, 186, 5, 165, 4, 140, 3, 111, 2,
  78, 1, 41, 1722, 40, 1760, 39, 1794, 38, 1824, 37, 1850, 36, 1872, 35,
  1890, 34, 1904, 33, 1914, 32, 1920, 31, 1922, 30, 1920, ...

(define (mul-div limite)
  (local (out)
    (setq out '(1))
    (for (n 1 limite)
      (if (< (out (- n 1)) n)
          (push (* n (out (- n 1))) out -1)
          (push (/ (out (- n 1)) n) out -1)
      )
    )
    (slice out 1)))

(mul-div 50)
;-> (1 2 6 1 5 30 4 32 3 30 2 24 1 14 210 13 221 12 228 11
;->  231 10 230 9 225 8 216 7 203 6 186 5 165 4 140 3 111 2
;->  78 1 41 1722 40 1760 39 1794 38 1824 37 1850)


--------------------------------
Numerologia e parole compatibili
--------------------------------

In numerologia, due parole (stringhe composte interamente da lettere) sono compatibili se producono lo stesso numero con la seguente procedura (usiamo la stringa hello come esempio):

Associare ogni lettera a un numero (ignorando maiuscole e minuscole) in base alla seguente tabella:

  1 2 3 4 5 6 7 8 9
  a b c d e f g h i
  j k l m n o p q r
  s t u v w x y z

Il numero in cima alla colonna in cui si trova una lettera è il suo valore
(ad esempio a -> 1, x -> 6).

  newLISP -> (5 5 5 3 9 1 7)

Sommare questi numeri: (5 + 5 + 5 + 3 + 9 + 1 + 7) = 35.

Calcolare la radice digitale del numero (cioè calcolare la somma delle cifre fino a che non si ottiene una singola cifra): 35 -> 3 + 5 = 8.

Alla parola "newLISP" viene associato il numero 8.
In questo caso, tutte le parole che producono 8 sono simili a "newLISP".

(define (number word)
  (local (table sum)
    (setq table
      '(("a" 1) ("b" 2) ("c" 3) ("d" 4) ("e" 5) ("f" 6) ("g" 7) ("h" 8) ("i" 9)
        ("j" 1) ("k" 2) ("l" 3) ("m" 4) ("n" 5) ("o" 6) ("p" 7) ("q" 8) ("r" 9)
        ("s" 1) ("t" 2) ("u" 3) ("v" 4) ("w" 5) ("x" 6) ("y" 7) ("z" 8)))
    (setq word (lower-case word))
    (setq sum 0)
    ; calcola la somma dei caratteri
    (dolist (ch (explode word))
      (++ sum (lookup ch table))
    )
    ; calcula la radice digitale della somma
    (+ 1 (% (- (abs sum) 1) 9))))

Facciamo alcune prove:

(number "newLISP")
;-> 8
(number "programming")
;-> 5

(setq lang '("fortran" "c" "basic" "pascal" "lisp" "prolog" "python"
             "java" "processing" "forth" "newlisp"))

(sort (map (fn(x) (list (number x) x)) lang))
;-> ((2 "fortran") (2 "lisp") (2 "prolog")
;->  (3 "c")
;->  (4 "forth")
;->  (7 "basic") (7 "java") (7 "pascal")
;->  (8 "newlisp") (8 "processing") (8 "python"))


-------------------
Fattoriale in Haiku
-------------------

Crea un programma che calcola il fattoriale di un numero senza utilizzare funzioni fattoriali incorporate. L'intero programma deve essere in forma haiku, cioè devono seguire (quando si pronuncia) il formato di 5-7-5 sillabe.

Soluzione di Cornullion:

(define (fac n (so))            ; define fac n so
(if (= n 0) 1                   ; if equals n zero 1
(* n (fac (dec n)))))           ; times n fac dec n

(for (n 0 10)                   ; for n zero ten
; let's test from zero to ten
(println (fac n thus)))         ; printline fac n thus

  Lisp code consists of

  numerous parentheses

  and a few functions


-----------------
Numeri primissimi
-----------------

Si tratta di tutti i numeri primi che hanno la somma delle cifre prima e la radice digitale prima.

Sequenza OEIS A207294:
  2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 83, 101, 113, 131, 137, 151,
  173, 191, 223, 227, 241, 263, 281, 311, 313, 317, 331, 353, 401, 421,
  443, 461, 599, 601, 641, 797, 821, 887, 911, 977, 1013, 1019, 1031,
  1033, 1051, 1091, 1103, 1109, 1123, 1163, 1181, 1213, 1217 , ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se un numero è primissimo:

(define (primissimo? num)
  (and (prime? num) (prime? (digit-sum num)) (prime? (digit-root num))))

(filter primissimo? (sequence 2 1250))
;-> (2 3 5 7 11 23 29 41 43 47 61 83 101 113 131 137 151 173 191 223 227
;->  241 263 281 311 313 317 331 353 401 421 443 461 599 601 641 797 821
;->  887 911 977 1013 1019 1031 1033 1051 1091 1103 1109 1123 1163 1181
;->  1213 1217 1231)


-------------------------------
Minimo e massimo con due numeri
-------------------------------

Dati due numeri naturali a 3 cifre, costruire due numeri a 2 cifre che sono il valore minimo e il valore massimo di tutti i numeri che rispettano le seguenti regole:

1) In ciascuno dei numeri da costruire, una cifra viene presa da un numero di input e l'altra dall'altro numero.

2) I due numeri da costruire non devono avere zeri iniziali

Esempi:

  123, 912 --> 11, 93
  888, 906 --> 68, 98
  100, 100 --> 10, 11
  222, 222 --> 22, 22
  123, 222 --> 12, 32
  798, 132 --> 17, 93

(define (min-max a b)
  (local (out minimo massimo)
    (setq out '())
    (setq minimo 999)
    (setq massimo 0)
    (setq lst1 (explode (string a)))
    (setq lst2 (explode (string b)))
    ; prodotto cartesiano
    (dolist (el1 lst1)
      (dolist (el2 lst2)
        (if (!= el1 "0")
          (push (int (string el1 el2) 0 10) out -1)
        )
        (if (!= el2 "0")
          (push (int (string el2 el1) 0 10) out -1)
        )
      )
    )
    ;(println out)
    (setq minimo (apply min out))
    (setq massimo (apply max out))
    (list minimo massimo)))

Facciamo alcune prove:

(min-max 123 912)
;-> (11 93)
(min-max 888 906)
;-> (68 98)
(min-max 100 100)
;-> (10 11)
(min-max 222 222)
;-> (22 22)
(min-max 123 222)
;-> (12 32)
(min-max 798 132)
;-> (17 93)


-------------------
Numeri senza numeri
-------------------

Scrivere una funzione o espressione che stampa 2023 senza utilizzare nessuno dei caratteri 0123456789 e indipendentemente da qualsiasi variabile esterna come la data o l'ora o un numero casuale.

prima soluzione: codice ASCII
  2023 = 60 * 35 - 77
(char 60)
;-> "<"
(char 35)
;-> "#"
(char 77)
;-> "M"
(println (- (* (char "<") (char "#")) (char "M")))
;-> 2023

Seconda soluzione: codice UTF
(setq s (char 2023))
;-> "▀º"
(char "▀º")
;-> 2023


----------------
Numeri Loeschian
----------------

Un numero intero positivo N è un numero Loeschian se può essere espresso come:

  N = x*x + y*y + x*y,  dove i, j >= 0.

Nota: Per ogni coppia di interi (i,j) c'è una coppia di interi non negativi che produce lo stesso N.

Sequenza OEIS A003136:
  0, 1, 3, 4, 7, 9, 12, 13, 16, 19, 21, 25, 27, 28, 31, 36, 37, 39, 43,
  48, 49, 52, 57, 61, 63, 64, 67, 73, 75, 76, 79, 81, 84, 91, 93, 97,
  100, 103, 108, 109, 111, 112, 117, 121, 124, 127, 129, 133, 139, 144,
  147, 148, 151, 156, 157, 163, 169, 171, 172, 175, 181, 183, 189, 192, ...

Funzione che verifica se un numero è Loaschian (true o nil):

(define (loeschian? num)
  (local (limit stop)
  (cond
    ((= (% num 3) 2) nil)
    ((or (= num 0) (= num 1) (= num 3)) true)
    (true
      (setq limit (int (add 0.5 (mul 2 (sqrt (div num 3))))))
      (setq stop nil)
      (for (y 0 limit 1 stop)
        (for (x 0 y 1 stop)
          (if (= num (+ (* x x) (* y y) (* x y))) (setq stop true))
        )
      )
      stop))))

Facciamo alcune prove:

(loeschian? 4)
;-> true
(loeschian? 21)
;-> true
(loeschian? 42)
;-> nil
(loeschian? 49)
;-> true

Generiamo la sequenza OEIS:

(filter loeschian? (sequence 0 200))
;-> (0 1 3 4 7 9 12 13 16 19 21 25 27 28 31 36 37 39 43 48 49 52 57 61
;->  63 64 67 73 75 76 79 81 84 91 93 97 100 103 108 109 111 112 117 121
;->  124 127 129 133 139 144 147 148 151 156 157 163 169 171 172 175 181
;->  183 189 192 193 196 199)

Funzione che verifica se un numero è Loeschian (in questo caso può generare la prima coppia o tutte le coppie che producono N):

(define (loeschian num all)
  (local (out limit stop)
  (setq out '())
  (cond
    ((= (% num 3) 2) (setq out nil))
    ((= num 0) (setq out '((0 0 0))))
    ((= num 1)
      (if all
          (setq out '((1 0 1) (1 1 0)))
          (setq out '((1 0 1)))))
    ((= num 3) (setq out '((3 1 1))))
    (true
      (setq limit (int (mul 2 (sqrt (div num 3)))))
      (setq stop nil)
      (for (y 0 limit 1 stop)
        (for (x 0 y 1 stop)
          (if (= num (+ (* x x) (* y y) (* x y)))
            (begin
              (push (list (+ (* x x) (* y y) (* x y)) x y) out -1)
              (if (not all) (setq stop true)))))))
  )
  out))

Facciamo alcune prove:

(loeschian 21)
;-> ((21 1 4))
(loeschian 49)
;-> ((49 3 5))
(loeschian 49 true)
;-> ((49 3 5) (49 0 7))
(loeschian 8281 true)
;-> ((8281 49 56) (8281 39 65) (8281 19 80) (8281 11 85) (8281 0 91))

Nota: Per ogni soluzione (num x y) esiste anche la soluzione simmetrica (num y x), che non vengono calcolate dalla funzione "loeschian".

Vediamo quale numero (da 0 a 1000) ha il maggior numero di coppie:

(setq mille '())
(for (i 0 1000)
  (push (list (length (loeschian i true)) i) mille)
)
(slice (sort mille >) 0 3)
;-> ((3 931) (3 637) (2 988))

(loeschian 931 true)
;-> ((931 14 21) (931 9 25) (931 1 30))
(loeschian 637 true)
;-> ((637 12 17) (637 7 21) (637 4 23))
(loeschian 988 true)
;-> ((988 14 22) (988 6 28))


--------------------
Stringhe ASCII prime
--------------------

Una stringa ASCII è considerata prima se il suo numero è primo.

Ad ogni stringa vengono assegnati 3 numeri:

  Numero 1: somma dei valori ASCII dei singoli caratteri
  Numero 2: somma delle cifre del Numero 1
  Numero 3: radice digitale del Numero 1 (1..9)

Se il Numero 1 è primo, allora la stringa è prima di tipo 1.
Se il Numero 2 è primo, allora la stringa è prima di tipo 2.
Se il Numero 3 è primo, allora la stringa è prima di tipo 3.

Caratteri ASCII (32..126):

(char 32)
;-> " "
(char 126)
;-> "~"

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se una stringa è prima:

(define (prima-ascii str)
  (local (t1 t2 t3)
    (setq t1 0)
    (dostring (ch str) (++ t1 ch))
    (setq t2 (digit-sum t1))
    (setq t3 (digit-root t1))
    ;(println t1 { } t2 { } t3)
    (list (prime? t1) (prime? t2) (prime? t3))))

Facciamo alcune prove:

(prima-ascii "newLISP")
;-> (nil nil true)
(prima-ascii "trovare una stringa prima per tutti e tre i tipi")
;-> (nil nil true)
(prima-ascii (string prima-ascii))
;-> (nil nil true)

Queste sono stringhe prime per tutti e tre i tipi:

(prima-ascii "What are you studying?")
;-> (true true true)
(prima-ascii "I'm sleepy")
;-> (true true true)


--------------------------
select con indici multipli
--------------------------

La funzione "select" può selezionare solo elementi di primo livello in una lista (non può selezionare un elemento annidato).

(setq data '((0 "zero") (1 "uno") (2 "due") (3 "tre")))

(select data '(1 2))
;-> ((1 "uno") (2 "due"))

Proviamo a selezionare la stringa "due":

(select data '((2 1)))
;-> ERR: value expected in function select : (2 1)

Scriviamo una funzione che seleziona anche gli elementi annidati.
La lista "idx" ha la seguente struttura:

  ((i1 j1 ...) (i2 j2 ...) ... (in jn ...))

(define (selects lst idx)
  (let (out '())
    (dolist (el idx)
      (push (lst el) out -1))
    out))

(selects data '((2 1)))
;-> ("due")

(selects data '((0 1) (1 1) (2 1) (3 1)))
;-> ("zero" "uno" "due" "tre")

Nota: possiamo anche usare la funzione "find-all" nella maggior parte dei casi.

Vedere anche "select e unselect (antiselect)" in "Note libere 1".


---------------------------
Numeri casuali di Fibonacci
---------------------------

I numeri di Fibonacci vengono generati dalla seguente relazione:

  F(n) = F(n-1) + F(n-2), con F(1) = F(2) = 1

I numeri casuali di Fibonacci vengono generati dalla seguente relazione:

         |F(n-1) + F(n-2), (probabilità = 0.5),
  F(n) = |                                      con F(1) = F(2) = 1
         |F(n-1) - F(n-2), (probabilità = 0.5),

Funzione di Fibonacci (ricorsiva):

(define (fibo n)
  (if (< n 3) 1
      (+ (fibo (- n 1)) (fibo (- n 2)))))

Funzione di Fibonacci (iterativa):

(define (fibo-i n)
    (local (a b c)
      (setq a 0L b 1L c 0L)
      (for (i 0 (- n 1))
        (setq c (+ a b))
        (setq a b)
        (setq b c)
      )
    a))

(map fibo-i (sequence 1 10))
;-> (1L 1L 2L 3L 5L 8L 13L 21L 34L 55L)
(map fibo (sequence 1 10))
;-> (1 1 2 3 5 8 13 21 34 55)

Verifichiamo che le due funzioni producono gli stessi risultati:

(= (map fibo-i (sequence 1 30)) (map fibo (sequence 1 30)))
;-> true

Adesso vediamo le versione probabilistiche.

Funzione di Fibonacci casuale (ricorsiva):

(define (fibo-rnd n)
  (if (< n 3) 1
    (if (zero? (rand 2))
      (+ (fibo-rnd (- n 1)) (fibo-rnd (- n 2)))
      (- (fibo-rnd (- n 1)) (fibo-rnd (- n 2))))))

(seed 1)
(fibo-rnd 10)
;-> 9

Funzione di Fibonacci casuale (iterativa):

(define (fibo-i-rnd n)
    (local (a b c)
      (setq a 0L b 1L c 0L)
      (for (i 0 (- n 1))
        (if (zero? (rand 2))
            (setq c (+ a b))
            (setq c (- a b))
        )
        (setq a b)
        (setq b c)
      )
    a)))

(seed 1)
(fibo-i-rnd 10)
;-> 5L

Le due funzioni "fibo-rnd" e "fibo-i-rnd" non producono gli stessi risultati neanche se partiamo dallo stesso seme casuale (seed 1), questo perchè le due funzioni effettuano un diverso numero di chiamate alla funzione "rnd".
Comunque possiamo valutare se, dopo tante esecuzioni delle funzioni con lo stesso parametro, abbiamo dei risultati congruenti.

(setq a (sort (unique (collect (fibo-rnd 10) 1000))))
;-> (-21 -19 -17 -15 -13 -11 -9 -7 -5 -3 -1 1 3 5 7 9 11 13 15 17 19 21 23 25)
(setq b (sort (unique (collect (fibo-i-rnd 10) 1000))))
;-> (-55L -29L -25L -23L -19L -17L -15L -13L -11L -9L -7L -5L -3L -1L 1L
;->  3L 5L 7L 9L 11L 13L 15L 17L 19L 23L 25L 29L 55L)

(difference b a)
;-> (-55L -29L -25L 23L 55L)

Gli unici risultati differenti sono quelli minori o maggiori, quindi le due funzioni sembrano che siano corrette.

Versione con la funzione "amb":

(define (fibo-i-amb n)
    (local (a b c)
      (setq a 0L b 1L c 0L)
      (for (i 0 (- n 1))
        (eval (amb '(setq c (+ a b)) '(setq c (- a b))))
        (setq a b)
        (setq b c)
      )
    a))

(setq c (sort (unique (collect (fibo-i-amb 10) 1000))))
;-> (-55L -29L -25L -23L -19L -17L -13L -11L -9L -7L -5L -3L -1L 1L 3L 5L 7L 9L 11L 13L
;->  15L 17L 19L 23L 25L 29L 55L)


-------------
Mouse pointer
-------------

Lo Xerox Alto, originariamente rilasciato nel 1973, è stato il primo computer a presentare l'ormai familiare puntatore angolato del mouse.
La bitmap del puntatore dell'Alto aveva questo aspetto:

  16  *
  15  **
  14  ***
  13  ****
  12  *****
  11  ******
  10  *******
   9  ****
   8  ** **
   7  *  **
   6      **
   5      **
   4       **
   3       **
   2        **
   1        **
      12345678


Immagine originale al seguente indirizzo:

http://bitsavers.trailing-edge.com/pdf/xerox/parc/techReports/VLSI-81-1_The_Optical_Mouse.pdf

(define (mouse ch)
  (println ch)
  (println (dup ch 2))
  (println (dup ch 3))
  (println (dup ch 4))
  (println (dup ch 5))
  (println (dup ch 6))
  (println (dup ch 7))
  (println (dup ch 4))
  (println (dup ch 2) { } (dup ch 2))
  (println ch {  } (dup ch 2))
  (println {    } (dup ch 2))
  (println {    } (dup ch 2))
  (println {     } (dup ch 2))
  (println {     } (dup ch 2))
  (println {      } (dup ch 2))
  (println {      } (dup ch 2))
  'pointer)

The Xerox Alto, originally released in 1973, was the first computer to feature the now-familiar angled mouse pointer. The Alto's bitmapped pointer looked like this (redrawn from Fig. 2 here):
http://bitsavers.trailing-edge.com/pdf/xerox/parc/techReports/VLSI-81-1_The_Optical_Mouse.pdf

(mouse "■")        (mouse "▀")        (mouse "█")

■                  ▀                  █
■■                 ▀▀                 ██
■■■                ▀▀▀                ███
■■■■               ▀▀▀▀               ████
■■■■■              ▀▀▀▀▀              █████
■■■■■■             ▀▀▀▀▀▀             ██████
■■■■■■■            ▀▀▀▀▀▀▀            ███████
■■■■               ▀▀▀▀               ████
■■ ■■              ▀▀ ▀▀              ██ ██
■  ■■              ▀  ▀▀              █  ██
    ■■                 ▀▀                 ██
    ■■                 ▀▀                 ██
     ■■                 ▀▀                 ██
     ■■                 ▀▀                 ██
      ■■                 ▀▀                 ██
      ■■                 ▀▀                 ██


----------------------
Congettura di Legendre
----------------------

La Congettura di Legendre è un'affermazione non dimostrata che riguarda la distribuzione dei numeri primi. Essa afferma che esiste almeno un numero primo nell'intervallo (n^2,(n-1)^2) per tutti gli n naturali.

Scrivere una funzione che verifica (o falsifica) la congettura di Legendre fino ad un dato limite.

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

Funzione che verifica la congettura di Legendre fino ad un dato numero:

(define (legendre limite show)
  (local (max-primo primi stop p)
    (setq max-primo (* limite limite))
    (setq primi (primes-to max-primo))
    (setq stop nil)
    (for (i 2 limite 1 stop)
      (setq p (intersect primi (sequence i (* (- i 1) (- i 1)))))
      (if show (println i { } (* (- i 1) (- i 1)) { } p))
      ; se l'intersezione è vuota la congettura è falsa
      (if (= p '()) (setq stop true))
    )
    stop))

Facciamo alcune prove:

(legendre 10 true)
;-> 2 1 (2)
;-> 3 4 (3)
;-> 4 9 (5 7)
;-> 5 16 (5 7 11 13)
;-> 6 25 (7 11 13 17 19 23)
;-> 7 36 (7 11 13 17 19 23 29 31)
;-> 8 49 (11 13 17 19 23 29 31 37 41 43 47)
;-> 9 64 (11 13 17 19 23 29 31 37 41 43 47 53 59 61)
;-> 10 81 (11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79)
;-> nil

(time (println (legendre 100)))
;-> nil
;-> 39.825

(time (println (legendre 1000)))
;-> nil
;-> 52875.876


-------------------------------
Scambio delle potenze dei primi
-------------------------------

Abbiamo un numero n che ha la sequente forma: n = p^q.
I numeri p e q sono numeri primi e sono sconosciuti.
Scrivere una funzione che calcola q^p per un dato n solo se n = p^q, altrimenti restituisce nil.

Un numero n che ha la forma p^q (con p e q primi) ha la seguente scomposizione in fattori primi:

   q volte
  ---------
  p p ... p

In altre parole il numero p viene moltiplicato q volte per se stesso.
Per esempio, 3^5 = 243

(factor 243)
;-> (3 3 3 3 3)

Il numero q^p è semplicemente il numero q moltiplicato q volte.
In altre parole q vale il numero di fattori, mentre p è uno qualunque dei fattori (perchè sono tutti uguali).

Per controllare se una lista ha tutti i numeri uguali possiamo utilizzare "apply".

(define (cambio num)
  (let (f (factor num))
    (if (apply = f)
        (pow (length f) (f 0))
        nil)))

Facciamo alcune prove:

(cambio 243)
;-> 125
(cambio 125)
;-> 243

(define (cambio-to limite)
  (let ((out '()) (val nil))
    (for (i 2 limite)
      (setq val (cambio i))
      (if val (push (list i val) out -1))
    )
    out))

(cambio-to 1000)
;-> ((4 4) (8 9) (9 8) (16 16) (25 32) (27 27) (32 25) (49 128) (64 36) (81 64)
;->  (121 2048) (125 243) (128 49) (169 8192) (243 125) (256 64) (289 131072)
;->  (343 2187) (361 524288) (512 81) (529 8388608) (625 1024) (729 216)
;->  (841 536870912) (961 2147483648))


-------------------
XOR di due stringhe
-------------------

Date due stringhe di caratteri ASCII restituire lo XOR delle stringhe.

Come si effettua lo XOR tra due stringhe:
Per ogni carattere nella prima stringa, prendere il codice ASCII (es. A=65), fare lo XOR con il valore della seconda stringa che ha l'indice corrispondente e inserirlo nel risultato.
Se una stringa è più lunga dell'altra, allora occorre aggiungere al risultato i caratteri rimanenti della stringa più lunga.

(define (xor str1 str2)
  (cond 
    ((= str1 "") str2)
    ((= str2 "") str1)
    (true
      (local (out len1 len2)
        (setq out "")
        (setq len1 (length str1))
        (setq len2 (length str2))
        ; str1 diventa/rimane la più corta
        (if (> len1 len2) (begin (swap str1 str2) (swap len1 len2)))
        ; (a xor b) = (b xor a)
        ; (a xor 0) = a
        ; (0 xor b) = b
        (for (i 0 (- len1 1))
          (extend out (char (^ (or (char (str1 i)) 0)
                              (or (char (str2 i)) 0))))
        )
        (extend out (slice str2 len1))
        out))))

Facciamo alcune prove:

(xor "abcde" "01234")
;-> "QSQWQ"
(xor "lowercase" "9?'      ")
;-> "UPPERCASE"
(xor "test" "")
;-> "test"
(xor "12345" "98765")
;-> "\b\n\004\002\000"
(xor "123" "ABCDE")
;-> pppDE
(xor "01" "qsCDE")
;-> ABCDE
(xor "`c345" "QQ")
;-> 12345


------------------
Funtore come lista
------------------

Per creare una lista in un funtore (di un contesto) possiamo scrivere:

(setq z:z '(1 2 3 4))
;-> (1 2 3 4)
(z 1)
;-> 2

Come fare lo stesso con una variabile? (es. (setq nome "z:z"))

Un metodo è quello di usare "eval-string":

(setq name "z:z")
;(println (string "(setq " name " '(11 22 33 44))"))
(eval-string (string "(setq " name " '(11 22 33 44))"))
;-> (11 22 33 44)
(z 1)
;-> 22

Un altro metodo è il seuente:

(setq name "y")
; crea il contesto
(context (sym name))
; crea la variabile/funtore nel contesto
(setq name "y")
; assegna la lista al funtore/variabile
(set (sym name) '(5 6 7))
(context MAIN)
y:y
;-> (5 6 7)
(y 1)
;-> 6
(context 'y)
y:y
;-> (5 6 7)
y
;-> (5 6 7)
(y 0)
;-> 5
(context MAIN)


----------------------------------------------
Dividere una stringa in tutti i modi possibili
----------------------------------------------

Data una stringa, dividerla in tutti i modi possibili.

Per esempio:

"123"  -> ("123" "12 3" "1 23" "1 2 3")

"ABCD" -> ("ABCD" "ABC D" "A BCD" "AB CD" "AB C D" "A BC D" "A B CD" "A B C D")

"8451" -> ("8451" "845 1" "8 451" "84 51" "84 5 1" "8 45 1" "8 4 51" "8 4 5 1")

"ABCDE"-> ("ABCDE" "ABCD E" "A BCDE" "ABC DE" "AB CDE" "ABC D E" "A BCD E" 
           "A B CDE" "AB CD E"  "AB C DE" "A BC DE" "AB C D E" "A BC D E" 
           "A B CD E" "A B C DE" "A B C D  E")

Notiamo che il numero totale delle parole divise vale 2^(n-1), dove n è la lunghezza della stringa data.
Possiamo considerare l'operazione di divisione della stringa come fosse fatta da un numero binario.
Il numero binario è lungo (n - 1) e varia da 0 a (2^n - 1).
La cifra 1 di un numero indica un taglio, la cifra 0 indica nessun taglio.

Per esempio:

stringa "123"
binario  00 --> nessun taglio --> "123"

stringa "123"
binario  01 --> taglio tra i e i+1 (tra indice 1 e indice 2) --> "12 3"

stringa "123"
binario  10 --> taglio tra i e i+1 (tra indice 0 e indice 1) --> "1 23"

stringa "123"
binario  11 --> taglio tra i e i+1 (tra indice 0 e indice 1) 
                taglio tra i e i+1 (tra indice 1 e indice 2) --> "1 2 3"

Algoritmo
Ciclo da 0 a (2^n - 1)
  Taglia stringa con binario corrente
  Inserisce risultato nella soluzione

Per prima cosa dobbiamo scrivere una funzione che prende una stringa e un numero binario e taglia la stringa in corrispondenza degli 1 del numero binario:

(define (divide str binary)
  (let (out "")
    (for (i 0 (- (length binary) 1))
      (if (= (binary i) "1")
          ; taglio
          (extend out (string (str i) { }))
          ; nessun taglio
          (extend out (str i))
      )
    )
    ; inserisce caratteri finale
    (extend out (str -1))
    out))

(divide "123" "00")
;-> "123"
(divide "123" "01")
;-> "12 3"
(divide "123" "10")
;-> "1 23"
(divide "123" "11")
;-> "1 2 3"

Adesso scriviamo la funzione finale:

(define (split str)
  (local (out len max-tagli taglio fmt)
    (setq out '())
    (setq len (length str))
    ; numero massimo di tagli
    (setq max-tagli (- len 1))
    ; formattazione con 0 davanti
    (setq fmt (string "%0" max-tagli "s"))
    (for (i 0 (- (pow 2 max-tagli) 1))
      ; taglio corrente
      (setq taglio (format fmt (bits i)))
      ; taglia la stringa con taglio corrente
      (push (divide str taglio) out -1)
    )
    out))

Facciamo alcune prove:

(split "123")
;-> ("123" "12 3" "1 23" "1 2 3")

(split "ABCD")
;-> ("ABCD" "ABC D" "AB CD" "AB C D" "A BCD" "A BC D" "A B CD" "A B C D")

(split "ABCDE")
;-> ("ABCDE" "ABCD E" "ABC DE" "ABC D E" "AB CDE" "AB CD E" "AB C DE" 
;->  "AB C D E" "A BCDE" "A BCD E" "A BC DE" "A BC D E" "A B CDE" 
;->  "A B CD E" "A B C DE" "A B C D E")

(length (split "12345"))
;-> 16

(length (split "123456"))
;-> 32


-----------------------------------
Estrazione di interi da una stringa
-----------------------------------

Data una stringa estrarre tutti i numeri interi che compaiono nella stringa.
Per esempio:
stringa = "10 palline, 7 carte e 2 penne"
Output = (10 7 2)

Per fare questo possiamo usare la funzione "parse":

  (parse str-data [str-break [regex-option]])

Applichiamo "parse" senza alcun parametro opzionale (in questo caso viene effettua il parsing della stringa come se fosse codice sorgente newLISP):

(setq str "10 palline, 7 carte, e 2 penne")
(setq token (parse str))
;-> ("10" "palline" "," "7" "carte" "e" "2" "penne")
(setq int-nil (map int token))
;-> (10 nil nil 7 nil nil 2 nil)
(setq interi (clean nil? int-nil))
;-> (10 7 2)

Vediamo cosa accade quando ci sono numeri in virgola mobile nella stringa:

(setq str "10 palline, 7 carte e 2.5 penne.")
;-> "10 palline, 7 carte e 2e3 penne."
(setq token (parse str))
;-> ("10" "palline" "," "7" "carte" "e" "2e3" "penne.")
(setq int-nil (map int token))
;-> (10 nil nil 7 nil nil 2 nil)
(setq interi (clean nil? int-nil))
;-> (10 7 2)

In questo caso 2.5 è un numero in virgola mobile e non deve essere estratto (in questo caso viene estratta la prima cifra 2 come numero intero).
Per risolvere questo problema confrontiamo se (int x) è uguale a (float x), in tal caso x è un numero intero.

(= (int 2) (float 2))
;-> true
(= (int 2.5) (float 2.5))
;-> nil

Quindi possiamo scrivere:

(setq str "10 palline, 7 carte e 2.5 penne.")
;-> "10 palline, 7 carte e 2.5 penne."
(setq token (parse str))
;-> ("10" "palline" "," "7" "carte" "e" "2.5" "penne.")
(setq int-nil (map (fn(x) (if (= (int x) (float x)) (int x) nil)) token))
;-> (10 nil nil 7 nil nil nil nil)
(setq interi (clean nil? int-nil))
;-> (10 7)

La funzione "parse" accetta anche una espressione regolare, per esempio:

(setq s "dev.obj,lisp test")

Parsing della stringa s con delimitatori " " o "." o ",":

(parse s {[ .,]} 0)
;-> ("dev" "obj" "lisp" "test")

Vedere anche "Parsing di stringhe" su "Note libere 2".

=============================================================================

