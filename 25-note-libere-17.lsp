================

 NOTE LIBERE 17

================

  r = sqrt(sin 2θ) = ∞

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

Vedi anche "Distanze tra coppie di numeri primi adiacenti" su "Note libere 20".
Vedi anche "Distanza massima tra coppie di primi adiacenti" su "Note libere 26".


----------------------
Coppie autogrammatiche
----------------------

Abbiamo due funzioni, P e Q, entrambi nello stesso linguaggio (newLISP).
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

Un altro metodo è il seguente:

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
    ; inserisce caratteri finali
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

Vedi anche "Partizioni di una lista in ordine" su "Note libere 25".


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

Parsing della stringa s con delimitatori " " e "." e ",":

(parse s {[ .,]} 0)
;-> ("dev" "obj" "lisp" "test")

Vedere anche "Parsing di stringhe" su "Note libere 2".


-----------------------
Sharpness di una parola
-----------------------

Lo sharpness (nitidezza) di una parola è la somma degli sharpness di ciascuna delle sue lettere, utilizzando le seguenti regole:

Lettere sharp
A e V hanno sharpness 1
N e Z hanno sharpness 2
M e W hanno sharpness 3

Lettere dull
C e U hanno sharpness -1
S ha sharpness -2
O sharpness -3

Tutte le altre lettere hanno sharpness pari a 0.

(setq alst '(("A" 1) ("V" 1) ("N" 2) ("Z" 2) ("M" 3) ("W" 3)
             ("C" -1) ("U" -1) ("S" -2) ("O" -3)))

(define (sharpness str)
  (local (out alst val)
    (setq out 0)
    (setq alst '(("A" 1) ("V" 1) ("N" 2) ("Z" 2) ("M" 3) ("W" 3)
                ("C" -1) ("U" -1) ("S" -2) ("O" -3)))
    (dolist (ch (explode (upper-case str)))
      (setq val (lookup ch alst))
      ; adesso val può essere nil o un numero intero
      (if val (++ out val))
    )
    out))

(sharpness "NEWLISP")
;-> 3
(sharpness "cameyo")
;-> 0

(define (sharp str)
  (let (alst '(("A" 1) ("V" 1) ("N" 2) ("Z" 2) ("M" 3) ("W" 3)
              ("C" -1) ("U" -1) ("S" -2) ("O" -3)))
    (apply + (map (fn(x) (or (lookup x alst) 0)) (explode (upper-case str))))))

(sharp "NEWLISP")
;-> 3
(sharp "cameyo")
;-> 0



------------------------
Componente di un vettore
------------------------

Abbiamo due vettori a=(a1 a2 ... an) e b=(b1 b2 ... bn) in uno spazio n-dimensionale, dove almeno uno tra b1 ... bn è diverso da zero.
Allora il vettore a può essere scomposto univocamente in due vettori, uno dei quali è un multiplo scalare di b (b*x) e uno è perpendicolare a b (b_perp):

  a = b*x + b_perp, dove b_perp prodotto scalare b = 0.

Trovare il valore di x.

Questo può anche essere pensato nel modo seguente:
Immaginare una linea che passa per l'origine e il punto b.
Quindi tracciare una linea perpendicolare su di essa che passa per il punto a e che denota l'intersezione c.
Infine, trovare il valore di x che soddisfa c = b*x.

       a prodotto scalare b
  x = ----------------------
       b prodotto scalare b

Possiamo usare una formula esplicita, che si presenta quando si calcola la proiezione:

       a1*b1 + a2*b2 + ... + an*bn
  x = -----------------------------
       b1*b1 + b2*b2 + ... + bn*bn

Scriviamo una funzione che implementa la formula:

(define (x a b)
  (div (apply add (map mul a b))
       (apply add (map mul b b))))

Facciamo alcune prove:

(x '(2 7) '(3 1))
;-> 1.3
(x '(2 7) '(-1 3))
;-> 1.9
(x '(3 4 5) '(0 0 1))
;-> 5
(x '(3 4 5) '(1 1 1))
;-> 4
(x '(3 4 5) '(1 -1 -1))
;-> -2
(x '(3 4 5 6) '(1 -2 1 2))
;-> 1.2


-----------
Autoanalisi
-----------

Scrivere una funzione che prende un carattere come input e restituisce il numero di volte in cui quel carattere ricorre all'interno del codice della funzione.

(define (auto ch)
  (length (find-all ch (string auto))))

Vediamo la rappresentazione interna della funzione:

auto
;-> (lambda (ch) (length (find-all ch (string auto))))

(auto "l")
;-> 4
(auto "a")
;-> 4
(auto "s")
;-> 1


-----------------------------
True and False (Vero e Falso)
-----------------------------

Le parole True and False (Vero e Falso) in diversi linguaggi:

https://codegolf.stackexchange.com/questions/205460/make-true-and-false-global

+----------------------+------------+-------------+
| Language             | True       | False (nil) |
+----------------------+------------+-------------+
| Arabic               | sahih      | zaif        |
| Armenian             | irakan     | kelc        |
| Assamese             | asol       | misa        |
| Breton               | gwir       | gaou        |
| Bulgarian            | veren      | neveren     |
| Catalan              | veritable  | fals        |
| Cornish              | gwir       | gaw         |
| Czech                | pravdivy   | nepravdivy  |
| Danish               | sand       | falsk       |
| Dutch                | waar       | onwaar      |
| English              | true       | false       |
| Esperanto            | vera       | malvera     |
| Finnish              | tosi       | epatosi     |
| French               | vrai       | faux        |
| Galician, Portuguese | verdadeiro | falso       |
| Georgian             | namdvili   | cru         |
| German               | wahr       | falsch      |
| Greek                | alithis    | psevdis     |
| Hebrew               | hiyuvi     | shikri      |
| Hindi, Urdu          | thik       | jhutha      |
| Hungarian            | igaz       | hamis       |
| Icelandic            | sannur     | rangur      |
| Indonesian, Malay    | benar      | salah       |
| Irish                | fior       | breagach    |
| Italian              | vero       | falso       |
| Japanese             | shin       | nise        |
| Korean               | cham       | geojit      |
| Latin                | verus      | falsus      |
| Latvian              | patiess    | nepareizs   |
| Mandarin Chinese     | zhen       | jia         |
| Maori                | pono       | pate        |
| Persian              | dorost     | galat       |
| Polish               | prawdziwy  | falszywy    |
| Romanian             | adevarat   | fals        |
| Russian              | vernyj     | falsivyj    |
| Sardinian            | beru       | falsu       |
| Scottish Gaelic      | fior       | breugach    |
| Spanish              | verdadero  | falso       |
| Swedish              | sann       | falskt      |
| Sylheti              | hasa       | misa        |
| Turkish              | dogru      | yanlis      |
| Volapuk              | veratik    | dobik       |
| Welsh                | gwir       | anwir       |
+----------------------+------------+-------------+

All words ASCIIfied from Wiktionary: true, false.
https://en.wiktionary.org/wiki/true#Translations
https://en.wiktionary.org/wiki/false#Translations


---------------------------------
Numero di elementi pari e dispari
---------------------------------

Data una lista di numeri interi positivi, scrivere una funzione che restituisce true se la lista contiene lo stesso numero di elementi pari e di elementi dispari, altrimenti restituisce nil.
La funzione deve essere la più breve possibile.

Soluzione 1:

(define (sol1 lst)
  (local (pari dispari)
    (dolist (el lst)
      (if (odd? el)
          (++ dispari)
          (++ pari)
      )
    )
    (= pari dispari)))

Soluzione 2:

(define (sol2 lst)
  (= (count '(true) (map odd? lst))
     (count '(true) (map even? lst))))

Soluzione 3:

(define (sol3 lst)
  (= (length (filter odd? lst))
     (length (filter even? lst))))

Soluzione 4:

Elevando -1 ad una potenza pari otteniamo +1
Elevando -1 ad una potenza dispari otteniamo -1
Eleviamo -1 a potenza con tutti gli elementi e otteniamo una lista di valori -1 o +1.
Se il numero di elementi pari e di elementi dispari è lo stasso, allora la somma degli elementi della lista di -1 e +1 vale 0.

(define (sol4 lst)
  (zero? (apply + (map (fn(x) (pow -1 x)) lst))))

Facciamo alcune prove:

(setq lst1 '(1 2 3 4 5 6 7 10))
(setq lst2 '(1 2 3 4 5 6 7))
(sol1 lst1)
;-> true
(sol2 lst1)
;-> true
(sol3 lst1)
;-> true
(sol4 lst1)
;-> true
(sol1 lst2)
;-> nil
(sol2 lst2)
;-> nil
(sol3 lst2)
;-> nil
(sol4 lst2)
;-> nil


------------------------------
Numeri con un solo bit a 0 (1)
------------------------------

Scrivere una funzione che verifica se un numero ha un solo bit a 0 nella sua rappresentazione binaria.

Sequenza OEIS A030130:

  0, 2, 5, 6, 11, 13, 14, 23, 27, 29, 30, 47, 55, 59, 61, 62, 95, 111, 119,
  123, 125, 126, 191, 223, 239, 247, 251, 253, 254, 383, 447, 479, 495, 503,
  507, 509, 510, 767, 895, 959, 991, 1007, 1015, 1019, 1021, 1022, 1535, 1791,
  1919, 1983, 2015, 2031, 2039, ...

Esempio:
(setq n 10345)
(bits n)
;-> "10100001101001"
(count '("1") (explode (bits n)))
;-> (6)

Funzione che verifica se la rappresentazione binaria di un numero contiene un solo 0 (o un solo 1, a seconda del parametro "bit"):

(define (onlyone? bit num)
  (= (count (list (string bit)) (explode (bits num))) '(1)))

Verifichiamo la sequenza OEIS:

(filter (curry onlyone? 0) (sequence 0 1000))
;-> (0 2 5 6 11 13 14 23 27 29 30 47 55 59 61 62 95 111 119 123 125 126 191
;->  223 239 247 251 253 254 383 447 479 495 503 507 509 510 767 895 959 991)

I numeri che hanno un solo 1 nella rappresentazione binaria sono le potenze di 2:

(filter (curry onlyone? 1) (sequence 0 1000))
;-> (1 2 4 8 16 32 64 128 256 512)


--------
MetaOEIS
--------

The On-Line Encyclopedia of Integer Sequences: https://oeis.org/

Data una sequenza di numeri interi, scrivere una funzione che accetta una sequenza e genera una funzione che accetta un indice e restituisce il numero della sequenza con quell'indice.
Esempio:
Una funzione f che prende come input una sequenza di numeri interi e restituisce una funzione lambda.
Quando la funzione lambda viene chiamata con un indice n, restituisce l'n-esimo elemento della sequenza.

Soluzione 1:

Usiamo una singola funzione (non creiamo un'altra funzione).
Comunque dobbiamo usare una variabile libera ("seq").

(define (meta-oeis par)
  (if (list? par)
      (setq seq par)
      (seq par)))

(setq sequenza '(0 11 22 33 44 55 66))
(meta-oeis sequenza)
;-> (0 11 22 33 44 55 66)
(meta-oeis 2)
;-> 22

Soluzione 2:

Creiamo un funtore che agisce come contenitore della lista.
Chiamando il funtore con un indice otteniamo l'elemento di quell'indice.
Il funtore prende il nome dalla variabile "name".

(define (make-oeis name lst)
  (setq name (append name ":" name))
  (eval-string (string "(setq " name " '" lst ")")))

(make-oeis "a01" sequenza)
(a01 1)
;-> 11


-------------------
Numeri autodivisori
-------------------

Un numero intero positivo è chiamato "autodivisore" se ogni cifra decimale del numero è un divisore del numero, cioè il numero è divisibile esattamente per ognuna delle sue cifre.

Esempi:
128 è autodivisore è divisibile per 1, 2 e 8 esattamente.
28 non è un autodivisore perché non è divisibile per 8 esattamente.

Il numero 0 non è divisore di alcun numero, quindi qualsiasi numero che contiene la cifra 0 non è un autodivisore.

Ci sono infiniti numeri autodivisori.

Sequenza OEIS A024838:
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22, 24, 33, 36, 44, 48, 55, 66,
  77, 88, 99, 111, 112, 115, 122, 124, 126, 128, 132, 135, 144, 155, 162,
  168, 175, 184, 212, 216, 222, 224, 244, 248, 264, 288, 312, 315, 324,
  333, 336, 366, 384, 396, 412, 424, 432, 444, 448, ...

Soluzione 1:

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (autodiv1? num)
  (let (digit (int-list num))
    (for-all (fn(x) (and (not (zero? x)) (zero? (% num x)))) digit)))

(autodiv1? 128)
;-> true
(autodiv1? 28)
;-> nil

(filter autodiv1? (sequence 1 150))
;-> (1 2 3 4 5 6 7 8 9 11 12 15 22 24 33 36 44 48 55 66
;->  77 88 99 111 112 115 122 124 126 128 132 135 144)

Soluzione 2:

(define (autodiv2? num)
  (let ((out true) (val nil))
    (setq val num)
    (while (and (!= num 0) out)
      (setq d (% num 10))
      (if (or (= d 0) (!= (% val d) 0))
          (setq out nil)
      )
      (setq num (/ num 10))
    )
    out))

(autodiv2? 128)
;-> true
(autodiv2? 28)
;-> nil

(filter autodiv2? (sequence 1 150))
;-> (1 2 3 4 5 6 7 8 9 11 12 15 22 24 33 36 44 48 55 66
;->  77 88 99 111 112 115 122 124 126 128 132 135 144)


------------------
Numeri autocoprimi
------------------

Un numero intero positivo è chiamato "autocoprimo" se ogni cifra decimale del numero è coprima con il numero.

Sequenza OEIS A138708:
  1, 11, 13, 17, 19, 21, 23, 27, 29, 31, 37, 41, 43, 47, 49, 51, 53, 57,
  59, 61, 67, 71, 73, 79, 81, 83, 87, 89, 91, 97, 101, 103, 107, 109, 111,
  113, 117, 119, 121, 127, 131, 133, 137, 139, 141, 143, 149, 151, 157,
  161, 163, 167, 169, 171, 173, 177, 179, 181, 187, 191, ...

Due numeri interi a e b sono coprimi se e solo se gcd(a,b) = 1.

(define (autocoprimo? num)
  (let ((out true) (val nil))
    (setq val num)
    (while (and (!= num 0) out)
      (setq d (% num 10))
      (if (!= (gcd val d) 1)
          (setq out nil)
      )
      (setq num (/ num 10))
    )
    out))

(autocoprimo? 171)
;-> true

(filter autocoprimo? (sequence 1 200))
;-> (1 11 13 17 19 21 23 27 29 31 37 41 43 47 49 51 53 57 59 61 67 71 73
;->  79 81 83 87 89 91 97 111 113 117 119 121 127 131 133 137 139 141 143
;->  149 151 157 161 163 167 169 171 173 177 179 181 187 191 193 197 199)


----------------------------------------------------------
Dividere una lista in due parti con somme uguali (o quasi)
----------------------------------------------------------

Data una lista di almeno due numeri interi positivi trovare una posizione (indice) di taglio che minimizza la differenza assoluta tra le somme delle due parti (a sinistra e a destra di esso).
La posizione dell'indice è quella dell'ultimo elemento della parte sinistra.

Vediamo un esempio:

(setq a '(2 5 1 8 5 4 3 8 8 7))
;-> (2 5 1 8 5 4 3 8 8 7)
; somma della parte destra
(setq right (apply + a))
;-> 49
; somma della parte sinistra
(setq left 0)
; ciclo
; per ogni elemento aggiorniamo la somma delle parti destra e sinistra
; e calcoliamo la differenza assoluta tra le due somme
(dolist (el a)
  ; aggiorna somma sinistra
  (setq left (+ left el))
  ; aggiorna somma destra
  (setq right (- right el))
  (setq diff (abs (- left right)))
  (println $idx { } left { } right { } diff)
  ;(read-line)
)
;-> 0 2 49 47
;-> 1 7 44 37
;-> 2 8 43 35
;-> 3 16 35 19
;-> 4 21 30 9
;-> 5 25 26 1 <-- differenza minima
;-> 6 28 23 5 <-- da qui aumenta la differenza
;-> 7 36 15 21
;-> 8 44 7 37
;-> 9 51 0 51

Scriviamo la funzione che restituisce una lista del tipo:

  (indice somma-sinistra somma-destra)

(define (taglio lst)
  (local (right left prev-diff stop diff indice)
    (setq right (apply + lst))
    (setq left 0)
    (setq prev-diff (abs (- left right)))
    (setq stop nil)
    (dolist (el lst stop)
      (setq left (+ left el))
      (setq right (- right el))
      (setq diff (abs (- left right)))
      ;(println $idx { } left { } right { } diff)
      ; aumenta la differenza?
      (if (> diff prev-diff)
        (begin
          (setq indice (- $idx 1))
          (setq left (- left el))
          (setq right (+ right el))
          (setq stop true)
        )
        (begin
          (setq prev-diff diff)
        )
      )
    )
    (list indice left right)))

Facciamo alcune prove:

(taglio a)
;-> (5 25 26)
(taglio (sequence 1 20))
;-> (13 105 105)
(taglio (sequence 20 1))
;-> (5 105 105)
(taglio '(1 8 5 6 9 8 5 4 8 3 2 3 7 8))
;-> (5 37 40)


----------------
Numeri skip-pure
----------------

I numeri skip-pure sono definiti con questa regola:

   A(0) = 1
   A(1) = 1
   A(n) = il più piccolo numero positivo non nella sequenza tale che:
          A(x) + A(x-2) per ogni x non appare mai

Ad esempio, il termine A(2) è 2, perché 1 è già apparso.
Il termine A(3) è 4, poiché A(2) + A(0) = 3 e 3 non è consentito dalla terza riga della regola.

Sequenza:

  1 1 2 4 6 7 9 10 12 13 14 16 18 19 20 22 24 25 27 28 30 31 33 34
  36 37 39 40 42 43 45 46 48 49 50 52 54 55 56 58 60 61 62 64 66 67
  68 70 72 73 74 76 78 79 80 82 84 85 86 88 90 91 92 94 96 97 99 100
  102 103 105 106 108 109 111 112 114 115 117 118 120 121 123 124 126
  127 129 130 132 133 135 136 138 139 141 142 144 145 147 148

La sequenza può essere generata dalla seguente formula per n>=1:

          | floor(3n/2) - 1, se floor(ln n) è pari e n ≡ 2 (mod 4)
   a(n) = |
          | floor(3n/2), altrimenti

Scriviamo una funzione che implementa la formula:

(define (skip-pure num)
  (cond ((= num 0) 1)
        ((= num 1) 1)
        ((and (= (% num 4) 2) (even? (floor (log num))))
          (sub (floor (mul 1.5 num)) 1))
        (true
          (floor (mul 1.5 num)))))

(map skip-pure (sequence 0 99))
;-> (1 1 2 4 6 7 9 10 12 13 14 16 18 19 20 22 24 25 26 28 30 31 33 34
;->  36 37 39 40 42 43 45 46 48 49 51 52 54 55 57 58 60 61 63 64 66 67
;->  69 70 72 73 75 76 78 79 81 82 84 85 86 88 90 91 92 94 96 97 98 100
;->  102 103 104 106 108 109 110 112 114 115 116 118 120 121 122 124 126
;->  127 128 130 132 133 134 136 138 139 140 142 144 145 146 148)


----------------------------------------------------
Generare una sequenza con numeri positivi e negativi
----------------------------------------------------

Dati due interi 1 <= a <= b, generare tutti gli interi x tali che a <= |x| <= b. Il risultato ordinato è (-b, 1-b, 2-b, ..., -a, a, a 1, a 2,... , b).
La funzione deve essere la più corta possibile.

Esempi:
a=6, b=9
(6,-6,7,-7,8,-8,9,-9) oppure (6,7,8,9,-9,-8,-7,-6) oppure (-8,7,-9,-7,9,8,-6,6) oppure ((6,-6),(7,-7),(8,-8),(9,-9)) oppure ((6,7,8,9),(-6,-7,-8,-9)) ecc.

a=6, b=6
(6,-6) oppure (-6,6) oppure ((6,-6)) oppure ((6),(-6)) ecc.

(define (seq a b) (append (sequence a b) (sequence (- a) (- b))))

(seq 5 10)
;-> (5 6 7 8 9 10 -5 -6 -7 -8 -9 -10)
(seq 6 9)
;-> (6 7 8 9 -6 -7 -8 -9)
(seq 6 6)
;-> (6 -6)


-----------------------
Lista di numeri coprimi
-----------------------

Data una lista di numeri interi positivi, verificare se tutti i numeri sono coprimi tra loro.

Due numeri a e b sono coprimi se e solo se risulta gcd(a,b)=1.

Soluzione 1: (verifichiamo tutte le coppie di numeri)

(define (coprimi? a b) (= (gcd a b) 1))

(define (all-coprimi? lst)
  (local (len stop)
    (setq len (length lst))
    (setq stop nil)
    (for (i 0 (- len 2) 1 stop)
      (for (j (+ i 1) (- len 1) 1 stop)
        (if (not (coprimi? (lst i) (lst j))) (setq stop true))
      )
    )
    (not stop)))

(all-coprimi? '(1 3 5 7 13))
;-> true
(all-coprimi? '(1 2 3 4 5))
;-> nil


Soluzione 2: (algebra)

I numeri sono tutti coprimi se e solo se il minimo comune multiplo di tutti i numeri è uguale al prodotto di tutti i numeri:

  minimo comune multiplo(numeri) = prodotto(numeri)

Dimostrazione

Dati due numeri a e b risulta:

  gcd(a,b)*lcm(a,b) = n*m

Se gcd(a,b)=1, allora risulta:

  lcm(a,b) = a*b

Inoltre la funzione gcd è moltiplicativa, cioè se a1 e a2 sono relativamente primi tra loro (coprimi) allora risulta:

  gcd(a1*a2,b) = (gcd(a1,b)*gcd(a2,b)

Adesso se gcd(a,b*c) = 1, allora risulta:

  gcd(a,b) = 1 e gcd(a,c) = 1

Quindi i numeri di una lista (x1,x2,...,xn) sono tutti coprimi tra loro se e solo se risulta:

                      n
  lcm(x1,x2,...,xn) = Prod[x(i)]
                      x=1

(define (lcm_ a b) (/ (* a b) (gcd a b)))

(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm_ (args) 2))

(define (all-coprimi? lst)
  (= (apply lcm lst) (apply * lst)))

(all-coprimi? '(1 3 5 7 13))
;-> true
(all-coprimi? '(1 2 3 4 5))
;-> nil

Vedi "Coprimi di una lista" su "Note libere 22".


-------------------
FORTRAN typing rule
-------------------

Il Fortran 77 ha sei tipi di dati: CHARACTER, COMPLEX, DOUBLE PRECISION, INTEGER, LOGICAL e REAL.
A qualsiasi oggetto non dichiarato in modo esplicito per avere uno di questi tipi viene assegnato implicitamente un tipo dal compilatore, come determinato dalla prima lettera del nome dell'oggetto.
I tipi impliciti predefiniti sono:

--------------+---------------
Prima lettera | Tipo implicito
--------------+---------------
     A-H      |  REAL
     I-O      |  INTEGER
     O-Z      |  REAL
----------------------------

Ad esempio, l'oggetto chiamato NUMBER (prima lettera N) ha il tipo implicito INTEGER mentre l'oggetto chiamato DUMBER (prima lettera D) ha il tipo implicito REAL.
Queste regole portano al vecchio scherzo che DIO è REALE... a meno che non sia dichiarato INTEGER.

I tipi impliciti predefiniti possono essere sovrascritti utilizzando istruzioni IMPLICIT.
Per esempio:

  IMPLICIT DOUBLE PRECISION (D,X-Z), INTEGER (N-P)

significa che tutti gli oggetti i cui nomi iniziano con D, X, Y o Z ora hanno il tipo implicito DOUBLE PRECISION e quelli che iniziano con N, O o P hanno il tipo implicito INTEGER.
Gli oggetti i cui nomi iniziano con qualsiasi altra lettera mantengono i loro tipi impliciti predefiniti (in questo esempio, REAL per A–C, E–H e Q–W e INTEGER per I–M).


--------------------
Numeri per posizione
--------------------

Creare la seguente lista di numeri:

  (1 22 333 4444 55555 666666 7777777 88888888 999999999)

La funzione deve essere la più corta possibile.

Soluzione 1:

(list '(1 22 333 4444 55555 666666 7777777 88888888 999999999))
;-> (1 22 333 4444 55555 666666 7777777 88888888 999999999)

Soluzione 2:

(map int (map (fn(x) (dup (string x) x)) (sequence 1 9)))
;-> (1 22 333 4444 55555 666666 7777777 88888888 999999999)

Soluzione 3: (non valida, ma interessante)

Usiamo la seguente formula:

         floor(sqrt(8*n - 7)) + 1
  floor(--------------------------),  per n = 1..45
                    2

(define (f n) (/ (+ (floor (sqrt (- (* 8 n) 7))) 1) 2))
(map f (sequence 1 45))
;-> (1 2 2 3 3 3 4 4 4 4 5 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 7
;->  8 8 8 8 8 8 8 8 9 9 9 9 9 9 9 9 9)
(map (fn(x) (/ (+ (floor (sqrt (- (* 8 x) 7))) 1) 2)) (sequence 1 45))
;-> (1 2 2 3 3 3 4 4 4 4 5 5 5 5 5 6 6 6 6 6 6 7 7 7 7 7 7 7
;->  8 8 8 8 8 8 8 8 9 9 9 9 9 9 9 9 9)


-------------
Numeri simili
-------------

Consideriamo simili due numeri interi positivi se hanno la stessa lunghezza e se confrontiamo i caratteri in due posizioni qualsiasi per entrambe le stringhe decimali, i risultati del confronto (minore, uguale o maggiore) devono essere gli stessi in entrambe le stringhe.

Formalmente, per due numeri che possono essere scritti come stringhe decimali a1a2...an, b1b2...bm, sono simili se e solo se n=m e a(i) < a(j) se e solo se b(i) < b(j) per ogni i,j in [1..n].

Ad esempio:
2131 e 8090 sono simili.
1234 e 1111, 1234 e 4321 non sono simili.

Funzione che verifica se due numeri interi sono simili:

(define (simili? a b)
  (if (!= (length a) (length b))
    nil
    ;else
    (local (len stop)
      (setq a (string a))
      (setq b (string b))
      (setq len (length a))
      (setq stop nil)
      (for (i 0 (- len 1) 1 stop)
        (for (j 0 (- len 1) 1 stop)
          (if (!= i j)
              (cond ;check condition
                ((and (= (a i) (a j)) (not (= (b i) (b j)))) (setq stop true))
                ((and (> (a i) (a j)) (not (> (b i) (b j)))) (setq stop true))
                ((and (< (a i) (a j)) (not (< (b i) (b j)))) (setq stop true))
              )
          )
        )
      )
      ; se stop vale nil, allora i due numeri sono simili
      (not stop))))

Facciamo alcune prove:

(simili? 2131 8090)
;-> true
(simili? 1234 1111)
;-> nil
(simili? 1234 4321)
;-> nil

Funzione che trova il prossimo numero simile ad un dato numero:

(define (next-simile num)
  (local (len sol limite stop)
    (setq len (length num))
    (setq sol nil)
    (setq limite (- (pow 10 len) 1))
    ;(println limite)
    (setq stop nil)
    (for (i (+ num 1) limite 1 stop)
      (if (simili? num i) (setq stop true sol i))
    )
    sol))

Facciamo alcune prove:

(next-simile 7316)
;-> 7324
(next-simile 123456)
;-> (123457)
(next-simile 99)
;-> nil

Funzione che trova il precedente numero simile ad un dato numero:

(define (prev-simile num)
  (local (len sol limite stop)
    (setq len (length num))
    (setq sol nil)
    (setq limite (pow 10 (- len 1)))
    ;(println limite)
    (setq stop nil)
    (for (i (- num 1) limite -1 stop)
      (if (simili? num i) (setq stop true sol i))
    )
    sol))

Facciamo alcune prove:

(prev-simile 7324)
;-> 7316
(prev-simile 123457)
;-> 123456
(prev-simile 7316)
;-> 7315
(prev-simile 123456)
;-> nil
(prev-simile 99)
;-> 88

La sequenza di numeri simili può essere definita nel modo seguente:

  a(0) = 0
  a(k) = n, se n e (n-1) sono simili
       = nil, altrimenti

(define (seq-simili limite)
  (let (out '(0))
    (for (n 1 limite) (if (simili? n (- n 1)) (push n out -1)))
    out))

(seq-simili 100)
;-> (0 1 2 3 4 5 6 7 8 9 13 14 15 16 17 18 19 21 24 25 26 27 28 29 31
;->  32 35 36 37 38 39 41 42 43 46 47 48 49 51 52 53 54 57 58 59 61 62
;->  63 64 65 68 69 71 72 73 74 75 76 79 81 82 83 84 85 86 87 91 92 93
;->  94 95 96 97 98)


-------------------------------
Multiplayer Rock-Paper-Scissors
-------------------------------

Per un'introduzione al gioco vedi "Rock Paper Scissors" in "Note libere 4".

Regole standard:

  Rock batte Scissors   |  Sasso batte Forbici
  Paper batte Rock      |  Carta batte Sasso
  Scissors batte Paper  |  Forbici batte Carta

In questo caso abbiamo più di 2 giocatori, cioè il risultato di una mano del gioco è rappresentato da una lista delle figure mostrate da ogni giocatore.
Per esempio con 4 giocatori la lista potrebbe essere:

  (Rock Rock Paper Scissors)

Con le regole standard, se escono tutte e tre le figure, la mano viene considerata un pareggio tra tutti i giocatori. Comunque con molti giocatori la possibilità di pareggiare una mano aumenta drasticamente.
Per questo motivo viene definita la seguente regola per stabilire i vincitori:

Data una lista che contiene Rock, Paper e Scissors (es. (R P P S S P)):

Calcolare il numero di Rock, Paper e Scissors (R P S) (es. 1 3 2)

Se un valore vale 0, allora i vincitori sono stabiliti dalla regola standard.
Altrimenti ad ogni giocatore viene attribuito un punteggio nel modo seguente:
moltiplicare il numero della propria figura per il numero delle figure su cui vince. 
Cioè, Rock ottiene un punteggio R*S, 
      Paper ottiene un punteggio P*R,
      Scissor ottiene un punteggio S*P.

Se i punteggi non sono uguali, vince il giocatore con il punteggio massimo.

Se i punteggi sono uguali tra due giocatori, si stabilisce il giocatore vincente con la regola standard.

Se i punteggi sono uguali tra tutti i giocatori, il risultato è un pareggio.

Associamo le figure a valori interi:

  0 = rock
  1 = paper
  2 = scissors

Funzione che simula una mano con un dato numero di giocatori:

(define (game players)
(local (figs mano nums values max-value indici figure uniq a b)
  ; lista delle figure
  (setq figs '("Rock" "Paper" "Scissor"))
  ; generazione casuale di una mano
  (setq mano (rand 3 players))
  ;(setq mano '(0 0 1 1 2 2))
  (println "Mano: " mano)
  (println "Mano: " (map (fn(x) (figs x)) mano))
  ; conta le figure della mano (R P S)
  (setq nums (count '(0 1 2) mano))
  (println "Conteggio figure: "nums)
  ; lista dei punteggi dei giocatori
  (setq values '())
  ; calcolo punteggi dei giocatori
  (dolist (el mano)
    (cond ((= el 0) (push (* (nums 0) (nums 2)) values -1))
          ((= el 1) (push (* (nums 1) (nums 0)) values -1))
          ((= el 2) (push (* (nums 2) (nums 1)) values -1))
    )
  )
  (println "Punteggi: " values)
  (cond 
    ; tutti punteggi uguali
    ((apply = values)
      (println "0) Pareggio con valore: "(values 0)))
    ; punteggi diversi
    (true
      ; punteggio massimo
      (setq max-value (apply max values))
      ;-> 16
      ; lista dei giocatori con punteggio massimo
      (setq indici (flat (ref-all max-value values)))
      ; lista delle figure con punteggio massimo
      (setq figure (select mano indici))
      (cond ((= (length figure) 1) ; un solo vincitore
              (println "1) Vince: " indici " con figura: " (figs (figure 0))))
            ((apply = figure)      ; vincitori con la stessa figura
              (println "2) Vince: " indici " con figura: " (figs (figure 0))))
            (true                  ; vincitori con la figura maggiore
              ; crea la lista delle figure uniche (sono sempre 2)
              (setq uniq (unique figure))
              (if (> (length uniq) 2) (println "ERRORE!!!"))
              (println "Figure uniche: " uniq)
              (setq a (uniq 0))
              (setq b (uniq 1))
              (println "a: " a {, } "b: " b)
              ; stabilisce il vincitore in base alle regole standard
              (cond ((or (and (= a 0) (= b 2))  ; a vince su b
                        (and (= a 1) (= b 0))
                        (and (= a 2) (= b 1))) 
                      (setq indici (flat (ref-all a mano)))
                      (println "3) Vince: " indici " con figura: " (figs a)))
                    (true  ; b vince su a
                      (setq indici (flat (ref-all b mano)))
                      (println "4) Vince: " indici " con figura: " (figs b)))
              )
            )
      )
    )
  )
  '---------------------))

Facciamo alcune prove:

(game 2)
;-> Mano: (1 0)
;-> Mano: ("Paper" "Rock")
;-> Conteggio figure: (1 1 0)
;-> Punteggi: (1 0)
;-> 1) Vince: (0) con figura: Paper
;-> ---------------------
(game 4)
;-> Mano: (0 2 0 1)
;-> Mano: ("Rock" "Scissor" "Rock" "Paper")
;-> Conteggio figure: (2 1 1)
;-> Punteggi: (2 1 2 2)
;-> Figure uniche: (0 1)
;-> a: 0, b: 1
;-> 4) Vince: (3) con figura: Paper
;-> ---------------------
(game 5)
;-> Mano: (1 0 1 0 0)
;-> Mano: ("Paper" "Rock" "Paper" "Rock" "Rock")
;-> Conteggio figure: (3 2 0)
;-> Punteggi: (6 0 6 0 0)
;-> 2) Vince: (0 2) con figura: Paper
;-> ---------------------
(game 10)
;-> Mano: (0 2 0 0 2 2 2 2 1 1)
;-> Mano: ("Rock" "Scissor" "Rock" "Rock" "Scissor" "Scissor" "Scissor" "Scissor" "Paper" "Paper")
;-> Conteggio figure: (3 2 5)
;-> Punteggi: (15 10 15 15 10 10 10 10 6 6)
;-> 2) Vince: (0 2 3) con figura: Rock
;-> ---------------------


---------------------------
Numeri/simboli intransitivi
---------------------------

Relazione transitiva
--------------------
In matematica una relazione binaria R in un insieme S è transitiva se e solo se, per ogni x, y, z appartenenti a X, se x è in relazione con y e y è in relazione con z, allora x è in relazione con z.

Per esempio, "è maggiore di", "è minore di" e "è uguale a" sono relazioni transitive:

  se x > y e y > z, allora x > z
  se x < y e y < z, allora x < z
  se x = y e y = z, allora x = z

Non è invece transitiva (cioè è intransitiva) la relazione "è perpendicolare a": se la retta A è perpendicolare alla retta B, e la retta B è perpendicolare alla retta C, allora la retta A non è perpendicolare alla retta C.

Nel gioco "Rock, Paper, Scissor" abbiamo la relazione intransitiva "vince su", infatti:

  Rock vince su Scissor
  Scissor vince su Paper
  Paper vince su Rock 
  (per essere transitiva dovrebbe essere: Rock vince su Paper)

In questo caso abbiamo 3 simboli.
Il problema è: come possiamo generare un insieme di N simboli (con N dispari) in cui ogni simbolo vince con (N-1)/2 simboli e perde con (N-1)/2 simboli (cioè vince con il 50% dei simboli e perde con il 50% dei simboli)

Vediamo una possibile soluzione.
Invece di dare i nomi ai simboli, usiamo i numeri interi (altrimenti dovremmo nominare ogni simbolo).
Andiamo da 0 a qualsiasi numero pari arbitrario 2*n (n = (N-1)/2).
Per qualsiasi numero intero compreso tra 0 e 2*n, abbiamo bisogno che batta n altri numeri e perda contro n altri numeri.

Il trucco sta nella definizione delle regole per "cosa batte cosa":

  1) Se si confrontano due numeri dispari, vince il più piccolo.
  2) Se si confrontano due numeri pari, vince quello più piccolo.
  3) Se si confrontano un numero dispari e un numero pari, vince il più grande.

Possiamo dimostrare che, con questa regola, ogni numero da 0 a 2*n batte n altri numeri e perde contro n altri numeri.

Dimostrazione per induzione:
Quando n=1, ci sono tre numeri: 0, 1 e 2. 
0 batte 2 perché sono entrambi pari e 0 è più piccolo. 
1 batte 0 perché 0 è pari, 1 è dispari e 1 è maggiore. 
2 batte 1 perché 1 è dispari, 2 è pari e 2 è maggiore. 
Quindi il processo funziona quando n=1.

Assumiamo che il processo funzioni per n=N e mostriamo che questo implica che il processo funzionerà per n=N+1. 
Abbiamo numeri da 0 a 2*N, ogni numero batte N altri numeri e perde contro N altri numeri. 
Aggiungiamo due nuovi numeri al mix 2*N+1 e 2*N+2.

Tutti i numeri pari da 0 a 2*N ora perdono contro 2*N+1 e battono 2*N+2. 
Quindi tutti questi numeri ora battono N+1 numeri e perdono contro N+1 numeri. 
Funziona ancora tutto.

Tutti i numeri dispari da 0 a 2*N ora battono 2*N+1 e perdono contro 2*N+2. 
Quindi tutti questi numeri ora battono N+1 numeri e perdono contro N+1 numeri. 
Funziona ancora tutto.

2*N+2 è pari e perde contro tutti i numeri pari da 0 a 2*N. 
Esistono N+1 numeri di questo tipo. 
2*N+2 batte tutti i numeri dispari da 0 a 2*N+1. 
Esistono N+1 numeri di questo tipo. 
Quindi 2*N+2 perde contro N+1 numeri e batte N+1 numeri.

2*N+1 è dispari e perde contro tutti i numeri dispari da 0 a 2*N. 
Ci sono N tali numeri. 
Perde anche 2*N+2. 
Quindi perde contro un totale di N+1 numeri. 
Batte tutti i numeri pari da 0 a 2*N. 
Ci sono un totale N+1 di tali numeri. 
Quindi 2N+1 perde contro N+1 numeri e batte N+1 numeri.

Quindi il sistema funziona per n=1 ed essendo vero per ogni n=N, è vero per ogni n=N+1. 
Quindi, è vero per tutti gli n.

Verifichiamo il risultato con una funzione che prende un numero dispari di elementi e crea una lista con le vittorie e le sconfitte di ogni elemento contro tutti gli altri:

(define (check num-element)
  (local (nums values a b)
    ; num-element deve essere dispari
    ; lista dei numeri da 0 a (num-element - 1)
    (setq nums (sequence 0 (- num-element 1)))
    ; lista dei numeri con vittorie e sconfitte
    ; (numero num-vittorie num-sconfitte)
    (setq values (map list nums (dup 0 num-element) (dup 0 num-element)))
    ; ciclo che calcola vittoria o sconfitta per tutte le coppie della lista
    (for (i 0 (- (length nums) 1))
      (setq a (nums i)) ; primo numero
      (for (j 0 (- (length nums) 1))
        (setq b (nums j)) ; secondo numero
              ; la coppia deve essere composta da due elementi diversi
        (cond ((!= i j)
                      ; numeri entrambi pari o entrambi dispari?
                (cond ((or (and (odd? a) (odd? b))
                          (and (even? a) (even? b)))
                        ; vince il più piccolo
                        (if (< a b)
                            (++ (values i 1))
                            (++ (values i 2))))
                      ; numeri uno pari e uno dispari?
                      ((or (and (odd? a) (even? b))
                          (and (even? a) (odd? b)))
                        ; vince il più grande
                        (if (> a b)
                            (++ (values i 1))
                            (++ (values i 2))))
                      ; caso non possibile
                      (true (println "ERRORE"))
                ))
              (true nil)
        )
      )
    )
    values))

Facciamo alcune prove:

(check 11)
;-> ((0 5 5) (1 5 5) (2 5 5) (3 5 5) (4 5 5) (5 5 5)
;->  (6 5 5) (7 5 5) (8 5 5) (9 5 5) (10 5 5))
(check 101)
;-> ((0 50 50) (1 50 50) (2 50 50) (3 50 50) (4 50 50) (5 50 50)
;->  (6 50 50) (7 50 50) (8 50 50) (9 50 50) (10 50 50) (11 50 50)
;->  ...
;->  (89 50 50) (90 50 50) (91 50 50) (92 50 50) (93 50 50) (94 50 50)
;->  (95 50 50) (96 50 50) (97 50 50) (98 50 50) (99 50 50) (100 50 50))

Anche la simulazione dimostra che ogni numero vince e perde un numero uguale di volte.

A questo punto è possibile associare ad ogni numero un simbolo diverso e determinare le relazioni (vittoria e sconfitta) tra tutti i simboli.


-------------------------------------------
Distanze tra i tasti di una tastiera QWERTY
-------------------------------------------

Le distanze tra i tasti delle lettere di una tastiera QWERTY sono piuttosto standardizzate. 
I tasti sono quadrati e sia la spaziatura orizzontale che quella verticale sono di 19,05 mm (quindi se non ci fossero spazi tra i tasti, la loro lunghezza laterale sarebbe di 19,05 mm) e le tre file di tasti sono sfalsate di 1/4 e 1/2 della dimensione del tasto.
La rappresentazione della tastiera e delle distanze si trova nel file "qwerty.png" nella cartella "data".
Le righe della tastiera QWERTY sono disposte nel modo seguente:

  Q W E R T Y U I O P
   A S D F G H J K L
    Z X C V B N M

Scrivere una funzione che prende due tasti con lettere e restituisce la distanza euclidea tra i loro centri.

;(define (dist2d x1 y1 x2 y2)
;  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
;             (mul (sub y1 y2) (sub y1 y2)))))

(define (dist2d P1 P2)
  (let ( (x1 (P1 0)) (y1 (P1 1))
         (x2 (P2 0)) (y2 (P2 1)) )
    (sqrt (add (mul (sub x1 x2) (sub x1 x2))
               (mul (sub y1 y2) (sub y1 y2))))))

Poniamo l'origine degli assi cartesiani (0,0) in basso a sinistra (cioè, lo 0 della x è il punto più a sinistra del tasto Q e lo 0 della y è il punto più in basso del tasto Z).
Per capire meglio la soluzione vedi il file "qwerty.png" nella cartella "data".

(setq dist 19.05)
; prima fila
(setq q (list (div dist 2) (div (mul 5 dist) 2)))
(setq w (list (div (mul 3 dist) 2) (div (mul 5 dist) 2)))
(setq e (list (div (mul 5 dist) 2) (div (mul 5 dist) 2)))
(setq r (list (div (mul 7 dist) 2) (div (mul 5 dist) 2)))
(setq t (list (div (mul 9 dist) 2) (div (mul 5 dist) 2)))
(setq y (list (div (mul 11 dist) 2) (div (mul 5 dist) 2)))
(setq u (list (div (mul 13 dist) 2) (div (mul 5 dist) 2)))
(setq i (list (div (mul 15 dist) 2) (div (mul 5 dist) 2)))
(setq o (list (div (mul 17 dist) 2) (div (mul 5 dist) 2)))
(setq p (list (div (mul 19 dist) 2) (div (mul 5 dist) 2)))
; seconda fila
(setq a (list (div (mul 3 dist) 4) (div (mul 3 dist) 2)))
(setq s (list (div (mul 7 dist) 4) (div (mul 3 dist) 2)))
(setq d (list (div (mul 11 dist) 4) (div (mul 3 dist) 2)))
(setq f (list (div (mul 15 dist) 4) (div (mul 3 dist) 2)))
(setq g (list (div (mul 19 dist) 4) (div (mul 3 dist) 2)))
(setq h (list (div (mul 23 dist) 4) (div (mul 3 dist) 2)))
(setq j (list (div (mul 27 dist) 4) (div (mul 3 dist) 2)))
(setq k (list (div (mul 31 dist) 4) (div (mul 3 dist) 2)))
(setq l (list (div (mul 35 dist) 4) (div (mul 3 dist) 2)))
; terza fila
(setq z (list (div (mul 5 dist) 4) (div dist 2)))
(setq x (list (div (mul 9 dist) 4) (div dist 2)))
(setq c (list (div (mul 13 dist) 4) (div dist 2)))
(setq v (list (div (mul 17 dist) 4) (div dist 2)))
(setq b (list (div (mul 21 dist) 4) (div dist 2)))
(setq n (list (div (mul 25 dist) 4) (div dist 2)))
(setq m (list (div (mul 29 dist) 4) (div dist 2)))

(setq keys '(q w e r t y u i o p a s d f g h j k l z x c v b n m))

Funzione che calcola tutte le distanze tra coppie di tasti con lettera:

(define (keys-distance)
  (local (out alpha len)
    (setq out '())
    (setq alpha '(a b c d e f g h i j k l m n o p q r s t u v w x y z))
    (setq len (length alpha))
    (for (ii 0 (- len 1))
      (for (jj 0 (- len 1))
        (setq k1 (eval (alpha ii)))
        ;(println (alpha ii) { } k1)
        (setq k2 (eval (alpha jj)))
        ;(println (alpha jj) { } k2)
        (push (list (alpha ii) (alpha jj) (dist2d k1 k2)) out -1)
      )
    )
    out))

(keys-distance)
;-> ((a a 0) 
;->  (a b 87.81616095571475) 
;->  (a c 51.29369478795616) 
;->  (a d 38.1) 
;->  (a e 38.39650252627184)
;->  (a f 57.15)
;->  (a g 76.19999999999999)
;->  (a h 95.25)
;->  (a i 129.9909522091826)
;->  (a j 114.3)
;->  (a k 133.35)
;->  (a l 152.4)
;->  (a m 125.2818148216253)
;->  (a n 106.4927374284275)
;->  (a o 148.8614587670362)
;->  (a p 167.7725399350263)
;->  ...
;->  (z o 143.2713253105799)
;->  (z p 161.7147532114804)
;->  (z q 40.69081783707475)
;->  (z r 57.34809418149831)
;->  (z s 21.2985474856855)
;->  (z t 72.69640745078124)
;->  (z u 107.0238765708382)
;->  (z v 57.15000000000001)
;->  (z w 38.39650252627185)
;->  (z x 19.05)
;->  (z y 89.4792512611164)
;->  (z z 0))

La lista di tutti i valori si trova nel file "distance-keys.txt" nella cartella "data".


-----------------------------
Generalizzazione di CAR e CDR
-----------------------------

Le funzioni CAR e CDR ("first" e "rest" in newLISP) derivano dal LISP originale e vengono usate per accedere agli elementi di una lista.

Sebbene CAR e CDR siano stati nomi poco ispirati per quasi 50 anni, sono sopravvissuti perché offrono una geniale funzionalità: puoi aggiungere più lettere "a" e "d" tra "c" e "r", per produrre funzioni con nomi anche più strani.
Allora "caddr" trova il "car" del "cdr" del "cdr", leggiamo da sinistra a destra, sebbene le funzioni siano applicate da destra a sinistra come al solito.

Scriviamo una funzione che ci permette di utilizzare qualunque combinazione di lettere "a" e "d" nelle funzioni "cad" e "cdr":

(define (get str lst)
  (dolist (ch (reverse (explode str)))
    (cond ((= ch "c") nil)
          ((= ch "r") nil)
          ((= ch "d") (setq lst (rest lst)))
          ((= ch "a") (setq lst (first lst)))
    )
  )
  lst)

Facciamo alcune prove:

(get "car" '(1 2 3))
;-> 1
(get "cadr" '(7 3 5))
;-> 3
(get "cadr" (get "cdr" '(7 3 5)))
;-> 5
(get "cadadr" '(0 (1 2 3) 4 5))
;-> 2
(get "caddr" '(7 3 5))
;-> 5
(get "caddr" '(7 3 ((1 2) 5)))
;-> ((1 2) 5)
(get "caaddr" '(7 3 ((1 2) 5)))
;-> (1 2)

Vedere anche "CAR e CDR in newLISP" in "Generale".


-----------------------------
Somma collettiva di un numero
-----------------------------

Dato un numero intero naturale, la sua somma collettiva è la somma dei numeri formati partendo da ogni ogni cifra e prendendo tante cifre dal numero (da sinistra) quanto vale ogni cifra.
Per esempio:

N = 13214
cifra 1: prendiamo 1 cifra -->    1  +
cifra 3: prendiamo 3 cifre -->  132  +
cifra 2: prendiamo 2 cifre -->   13  +
cifra 1: prendiamo 1 cifra -->    1  +
cifra 4: prendiamo 4 cifre --> 1321  =
                              ---------
                               1468

Casi particolari:
1) la cifra 0 lascia la somma inalterata (cioè sommiamo 0)
2) se una cifra è maggiore della lunghezza del numero, allora si prende tutto il numero.

Per esempio:

N = 2051
cifra 2: prendiamo 2 cifra -->   20  +
cifra 0: prendiamo 0 cifre -->    0  +
cifra 5: prendiamo 5 cifre --> 2051  +
cifra 1: prendiamo 1 cifra -->    2  =
                              ---------
                               2073

Funzione che calcola la somma collettiva di un numero intero naturale:

(define (somma num)
  (let ((tot 0) (str (string num)))
    (dolist (ch (explode str))
      (if (!= ch "0") (++ tot (int (slice str 0 (int ch)))))
    )
    tot))

Facciamo alcune prove:

(somma 13214)
;-> 1468
(somma 2051)
;-> 2073

Calcoliamo la somma collettiva dei primi 50 numeri:

(map somma (sequence 0 50))
;-> (0 1 2 3 4 5 6 7 8 9 1 2 13 14 15 16 17 18 19 20 20 23 44 46 48 50 52 54
;->  56 58 30 34 64 66 68 70 72 74 76 78 40 45 84 86 88 90 92 94 96 98 50)


------------------------------
Numero di coprimi di un numero
------------------------------

Dato un numero N, esistono k coprimi di N minori di N.
La sequenza è la seguente:

  a(0) = 0
  a(1) = 2
  a(n) = numero di coprimi di n fino a (n-1)

(define (coprimi? a b) (= (gcd a b) 1))

(define (conta-coprimi num prt)
  (let ((out 0) (res nil))
    (for (i 1 (- num 1))
      (setq res (coprimi? num i))
      (if res (++ out))
      (if (and res prt) (println num {: } i))
    )
    out))

(conta-coprimi 10 true)
;-> 10: 1
;-> 10: 3
;-> 10: 7
;-> 10: 9
;-> 4

(define (seq limite)
  (let (out '(0 2))
    (for (i 2 limite)
      (push (conta-coprimi i) out -1))
    out))

(seq 20)
;-> (0 2 1 2 2 4 2 6 4 6 4 10 4 12 6 8 8 16 6 18 8)


-------------
map vs dolist
-------------

(setq a (rand 1e5 20))
(setq b (rand 1e5 1e4))

1) Funzione primitiva (una lista):

(define (m1 lst) (map integer? lst))

(define (d1 lst)
  (let (out '()) 
    (dolist (el lst) (push (integer? el) out -1))))

Controllo risultati uguali:

(= (m1 a) (d1 a))
;-> true

Velocità con lista da 20 elementi:

(time (m1 a) 1e6)
;-> 768.972
(time (d1 a) 1e6)
;-> 1367.417

Velocità con lista da 10000 elementi:

(time (m1 b) 1e3)
;-> 368.047
(time (d1 b) 1e3)
;-> 660.225

2) Funzione lambda (una lista):

(define (m2 lst) (map (fn(x) (* x x)) lst))

(define (d2 lst)
  (let (out '())
    (dolist (el lst) (push (* el el) out -1))))

Controllo risultati uguali:

(= (m2 a) (d2 a))
;-> true

Velocità con lista da 20 elementi:

(time (m2 a) 1e6)
;-> 1594.744
(time (d2 a) 1e6)
;-> 1481.054

Velocità con lista da 10000 elementi:

(time (m2 b) 1e3)
;-> 759.968
(time (d2 b) 1e3)
;-> 709.113

3) Funzione primitiva (due liste):

(define (m3 lst1 lst2) (map * lst1 lst2))

(define (d3 lst1 lst2)
  (let (out '())
    (dolist (el lst1) (push (* el (lst2 $idx)) out -1))))

Controllo risultati uguali:

(= (m3 a a) (d3 a a))
;-> true

Velocità con lista da 20 elementi:

(time (m3 a a) 1e6)
;-> 1152.946
(time (d3 a a) 1e6)
;-> 2039.577

Velocità con lista da 10000 elementi:

(time (m3 b b) 1e3)
;-> 507.67
(time (d3 b b) 1e3)
;-> 86197.549

4) Funzione lambda (due liste):

(define (m4 lst1 lst2) (map (fn(x y) (+ (* x x) (* y y))) lst1 lst2))

(define (d4 lst1 lst2)
  (let (out '())
    (dolist (el lst1) 
      (push (+ (* el el) (* (lst2 $idx) (lst2 $idx))) out -1))))

Controllo risultati uguali:

(= (m4 a a) (d4 a a))
;-> true

Velocità con lista da 20 elementi:

(time (m4 a a) 1e6)
;-> 2689.037
(time (d4 a a) 1e6)
;-> 3259.285

Velocità con lista da 10000 elementi:

(time (m4 b b) 1e2)
;-> 143.643
(time (d4 b b) 1e2)
;-> 17116.262


-----------------------------
La funzione matematica Torian
-----------------------------

Il Torian è una funzione inventata da Aalbert Torsius.
È definita come:

  T(x) = x!x

usando la definizione di fattoriale di Torsius:

   x!0 = 0
   x!n = Prod[i=1,x](i!*(n-1)) = 1!*(n-1)*2!*(n-1)* ... *x!*(n -1)

I valori di questa funzione crescono molto velocemente.

Sequenza OEIS A068943:

  x   x!x
  0    0
  1    1
  2    2
  3    24
  4    331776
  5    2524286414780230533120
  6    1835696214150575879833179017153997680798171470257149746590743980886
       8887035904000000
  7    5101262518548258728945891181868950955955001607224762539748030927274
       6448100065715053872591918112067939597886702951825720668660103621357
       7136794705113201252691571120270257414100795409915589752123272398890
       7041528666295915651551212054155426312621842773666145180823822511666
       294137239768053841920000000000000000000000000000

(define (torian x n)
  (local (total)
    (cond 
      ((zero? n) x)
      (true
        (setq total 1L)
        (for (i 1 x)
          (setq total (* total (torian i (- n 1))))
        )
        total))))

Facciamo alcune prove:

(torian 0 0)
;-> 
(torian 1 1)
;-> 1L
(torian 2 2)
;-> 2L
(torian 3 3)
;-> 24L
(torian 4 4)
;-> 331776L
(torian 5 5)
;-> 2524286414780230533120L
(torian 6 6)
;-> 1835696214150575879833179017153997680798171470257149746590743980886
;-> 8887035904000000L
(torian 7 7)
;-> 5101262518548258728945891181868950955955001607224762539748030927274
;-> 6448100065715053872591918112067939597886702951825720668660103621357
;-> 7136794705113201252691571120270257414100795409915589752123272398890
;-> 7041528666295915651551212054155426312621842773666145180823822511666
;-> 294137239768053841920000000000000000000000000000L
(torian 8 8)
;-> 4797591615442183876789197721424263193364248576866466456111925738847
;-> ...
;-> 7804686618528488248506273956486421322116628480000000000000000000000
;-> 0000000000000000000000000000000000000000000000000000000000000000000
;-> 0000000000000000000000000000000L

(length (torian 9 9))
;-> 4667
(length (torian 10 10))
;-> 17992
(time (println (length (torian 11 11))))
;-> 69509
;-> 422.088


------------------------------------
Segmento casuale su griglia quadrata
------------------------------------

Consideriamo una griglia quadrata con spaziatura unitaria.
Un segmento di lunghezza intera L viene lasciato cadere in una posizione arbitraria con orientamento arbitrario.
Diciamo che il segmento "tocca" un quadrato se interseca l'interno del quadrato (non solo il suo bordo).
Qual è il numero massimo di quadrati che il segmento può toccare, in funzione di L?

Sequenza OEIS A346232:
  3, 5, 7, 8, 9, 11, 12, 14, 15, 17, 18, 19, 21, 22, 24, 25, 27, 28,
  29, 31, 32, 34, 35, 36, 38, 39, 41, 42, 43, 45, 46, 48, 49, 51, 52,
  53, 55, 56, 58, 59, 60, 62, 63, 65, 66, 68, 69, 70, 72, 73, 75, 76,
  77, 79, 80, 82, 83, 85, 86, 87, 89, 90, 92, 93, 94, 96, 97, ...

La formula è la seguente:

  f(L) = floor(sqrt(2*L^2 - 2)) + 3

Dimostrazione

https://codegolf.stackexchange.com/questions/231176/maximum-number-of-squares-touched-by-a-line-segment

Il layout ottimale utilizza un segmento quasi diagonale la cui estensione orizzontale e verticale è almeno (h, h) o (h, h + 1). Abbiamo bisogno che la lunghezza-L per coprire almeno questa distanza usando il teorema di Pitagora, più qualcosa in più per raggiungere i quadrati e coprirne altri 3.

Questo comporta uno dei seguenti risultati:

1) 2*h + 3 dove h è il più grande intero positivo dove h^2 + h^2 < L^2,

oppure

2) 2*h + 4 dove h è il massimo intero positivo dove h^2 + (h + 1)^2 < L^2,

e vedere quale di questi è più grande.

Vogliamo combinare questi due casi in uno.

Iniziamo facendo sembrare i due casi più simili.

Si noti che il secondo caso può essere riscritto come:

   2*(h + 1/2) + 3, dove 2*(h + 1/2)^2 + 1/2 < L^2

o come:

   2*h + 3, dove 2*h^2 + 1/2 < L^2

dove h è un intero positivo e mezzo.

Il 2*h^2 < L^2 nel primo caso può anche essere scritto come:

   2*h^2 + 1/2 < L^2,

che è equivalente perché entrambi i lati erano numeri interi.

Quindi, i casi ora si fondono in:

   2*h + 3

dove h è il massimo intero positivo o semiintero dove 2*h^2 + 1/2 < L^2

Chiamando 2*h = H, questo è:

   H + 3

dove H è il massimo intero positivo dove 2*(H/2)^2 + 1/2 < L^2.

Questa disuguaglianza è:

  H^2 < 2*L^2,

e poiché questi sono numeri interi, questo è lo stesso di:

   H^2 <= 2*L^2

Il massimo di tali interi positivi H è quindi:

   floor(sqrt(2*L^2 - 2))

quindi il risultato finale è:

   floor(sqrt(2*L^2 - 2)) + 3

Implementazione della funzione:

  f(L) = floor(sqrt(2*L^2 - 2)) + 3

(define (f L) (+ (floor (sqrt (- (* 2 L L) 2))) 3))

Facciamo alcune prove:

(f 3)
;-> 7
(f 5)
;-> 9

(map f (sequence 1 50))
;-> (3 5 7 8 9 11 12 14 15 17 18 19 21 22 24 25 27 28
;->  29 31 32 34 35 36 38 39 41 42 43 45 46 48 49 51 52
;->  53 55 56 58 59 60 62 63 65 66 68 69 70 72 73)


-----------------------------------------
Confrontare due numeri dati come stringhe
-----------------------------------------

Date due stringhe numeriche determinare se rappresentano lo stesso numero.
Le stringhe possono rappresentare numeri interi e floating point (anche in notazione esponenziale).
Nelle stringhe possono comparire degli zeri "0" o spazi " " all'inizio e spazi " " alla fine.

Esempi:

  Stringa1    Stringa2   Risultato
  --------------------------------
  "1e3"       "1000"     true
  "0032.4"    "32.4"     true
  "12.345e2"  "1234.5 "  true
  "12.34e-2"  "0.1234"   true
  "0001"      "1    "    true
  " 23 "      "023 "     true
  "1450"      "1450 "    true
  "0010001"   "10001"    true
  "1"         "1.0"      true
  "0010000"   "  10  "   nil
  "101023"    "101024"   nil

Funzione che compara due stringhe numeriche:

(define (compare str1 str2)
  ; str1 float o integer?
  (if (or (find "." str1) (find "e" str1))
      (setq str1 (float str1))
      ;else
      (setq str1 (int str1 0 10)))
  ; str2 float o integer?
  (if (or (find "." str2) (find "e" str2))
      (setq str2 (float str2))
      ;else
      (setq str2 (int str2 0 10)))
  (= str1 str2))

Verifichiamo gli esempi:

(compare "1e3" "1000")
;-> true
(compare "0032.4" "32.4")
;-> true
(compare "12.345e2" "1234.5 ")
;-> true
(compare "12.34e-2" "0.1234")
;-> true
(compare "0001" "1 ")
;-> true
(compare " 23 " "023 ")
;-> true
(compare "1450" "1450 ")
;-> true
(compare "0010001" "10001")
;-> true
(compare "1" "1.0")
;-> true
(compare "0010000" " 10 ")
;-> nil
(compare "101023" "101024")
;-> nil


--------------------
Operazioni Flip-Flop
--------------------

Operazione flip: inverte i primi k elementi di una lista
Operazione flop: inverte gli ultimi k elementi di una lista

Funzione flip
-------------

(define (flip k lst)
  (setq k (min k (length lst))) ;k <= numero elementi di lst
  (extend (reverse (slice lst 0 k)) (slice lst k)))

Facciamo alcune prove:

(setq a '(1 2 3 4 5 6 7 8 9 10))
(setq b '(3 2 1 4 3 3 2))

(flip 4 a)
;-> (4 3 2 1 5 6 7 8 9 10)
(flip 4 b)
;-> (4 1 2 3 3 3 2)
(flip 20 b)
;-> (2 3 3 4 1 2 3)
(flip 2 a)
;-> (2 1 3 4 5 6 7 8 9 10)
(flip 1 a)
;-> (1 2 3 4 5 6 7 8 9 10)
(flip 0 a)
;-> (1 2 3 4 5 6 7 8 9 10)

Funzione flop
-------------

(define (flop k lst)
  (let (len (length lst))
    (setq k (max 1 (min k (length lst)))) ;k <= numero elementi di lst (!= 0)
    (extend (slice lst 0 (- len k)) (reverse (slice lst (- k))))))

Facciamo alcune prove:

(flop 4 a)
;-> (1 2 3 4 5 6 10 9 8 7)
(flop 13 a)
;-> (10 9 8 7 6 5 4 3 2 1)
(flop 2 a)
;-> (1 2 3 4 5 6 7 8 10 9)
(flop 1 a)
;-> (1 2 3 4 5 6 7 8 9 10)
(flop 0 a)
;-> (1 2 3 4 5 6 7 8 9 10)

Le funzioni flip e flop operano anche sulle stringhe:

(flip 4 "newold")
;-> "owenld"
(flop 4 "newold")
;-> "nedlow"


-------------------------
Trascrizione da DNA a RNA
-------------------------

Dato un filamento di DNA, restituire il suo complemento di RNA (per trascrizione di RNA).
Entrambi i filamenti di DNA e RNA sono una sequenza di nucleotidi.

I quattro nucleotidi presenti nel DNA sono:

  adenina (A), citosina (C), guanina (G) e timina (T).

I quattro nucleotidi trovati nell'RNA sono:

  adenina (A), citosina (C), guanina (G) e uracile (U).

Dato un filamento di DNA, il suo filamento di RNA trascritto si forma sostituendo ogni nucleotide con il suo complemento:

  G -> C
  C -> G
  T -> A
  A -> U

Esempi:

  Input                     Output
  "C"                   ->  "G"

  "A"                   ->  "U"

  "ACGTGGTCTTAA"        ->  "UGCACCAGAAUU"

  "XXX"                 ->  nil

  "ACGTXXXCTTAA"        ->  nil

  "ACTCAGCCGTGGTCTTAA"  ->  "UGAGUCGGCACCAGAAUU"

(char "G")
;-> 71
(char "C")
;-> 67
(char "A")
;-> 65
(char "T")
;-> 84
(char "U")
;-> 85

Versione 1:

(define (dna-rna1 str)
  (let ((rna "") (err nil))
    (dostring (c str err)
      (cond ((= c 71) (extend rna (char 67))) ;G --> C
            ((= c 67) (extend rna (char 71))) ;C --> G
            ((= c 84) (extend rna (char 65))) ;T --> A
            ((= c 65) (extend rna (char 85))) ;A --> U
            (true (setq err true) (setq rna nil))
      )
    )
    rna))

(dna-rna1 "C")
;-> "G"
(dna-rna1 "ACGTGGTCTTAA")
;-> "UGCACCAGAAUU"
(dna-rna1 "XXX")
;-> nil
(dna-rna1 "ACGTGGTCTTAAx")
;-> nil
(dna-rna1 "ACTCAGCCGTGGTCTTAA")
;-> "UGAGUCGGCACCAGAAUU"

Versione 2:

(define (dna-rna2 str)
  (let ((rna "") (err nil) (alst '(("G" "C") ("C" "G") ("T" "A") ("A" "U"))))
    (dolist (ch (explode str) err)
      (setq val (lookup ch alst))
      (if val
          (extend rna val)
          (setq err true rna nil)
      )
    )
    rna))

(dna-rna2 "C")
;-> "G"
(dna-rna2 "ACGTGGTCTTAA")
;-> "UGCACCAGAAUU"
(dna-rna2 "XXX")
;-> nil
(dna-rna2 "ACGTGGTCTTAAx")
;-> nil
(dna-rna2 "ACTCAGCCGTGGTCTTAA")
;-> "UGAGUCGGCACCAGAAUU"


-----------------------
Funzione inversa di map
-----------------------

Nella versione base la funzione "map" applica una funzione agli elementi di una lista.
Dal punto di vista concettuale la funzione inversa di "map" applica una lista di funzioni ad un numero.
Questa nuova funzione, "pam", restituisce uno dei seguenti risultati in base ad un parametro:

1) una lista di elementi in cui ognuno rappresenta l'applicazione della relativa funzione ad un numero.
2) un numero che rappresenta l'applicazione sequenziale di tutte le funzioni a partire dal numero dato.

Per esempio:

(map sqrt '(4 9 16))
;-> (2 3 4)

In questo caso generiamo una lista di due elementi, (sqrt 16) e (string 16)):

(pam 16 '(sqrt string))
;-> (4 "16")

In questo caso generiamo un numero (string (sqrt 16)):

(pam 16 '(sqrt string) true)
;-> "4"

Scriviamo la funzione:

(define (pam num lst one)
  (let (out '())
    (cond ((true? one)
            (setq out num)
            (dolist (f lst)
              (setq out ((eval f) out))))
          (true
            (dolist (f lst)
              (push ((eval f) num) out -1)))
    )
    out))

Facciamo alcune prove:

(pam 5 '(cos sin))
;-> (0.2836621854632263 -0.9589242746631385)
(pam 5 '(cos sin) true)
;-> 0.2798733507685274

Possiamo usare anche funzioni definite dall'utente:

(pam 5 '((fn(x) (* x x)) sin))
;-> (25 -0.9589242746631385)
(pam 5 '((fn(x) (* x x)) sin) true)
;-> -0.132351750097773


---------
Bit-array
---------

Un array di bit (bit-array, bit-vector, bit-mask, bit-set) è una struttura di dati di tipo array (o lista) che memorizza una serie di bit (0 oppure 1).
Può essere utilizzato per implementare una semplice struttura Set.
In alcuni linguaggi un array di bit sfrutta il parallelismo a livello di bit nell'hardware per eseguire operazioni rapidamente (purtroppo newLISP non ha questa struttura come primitiva).

Un array di bit è una mappatura da un dominio ai valori nell'insieme (0, 1).
I due valori possono essere interpretati come vero/falso, si/no, assente/presente,eccetera.
Poichè sono possibili solo due valori, questi possono essere memorizzati in un bit.
Come con gli altri array, l'accesso a un singolo bit viene gestito tramite indici.

Per esempio, supponendo che la dimensione dell'array sia di n bit, l'array può essere utilizzato per specificare un sottoinsieme del dominio (0, 1, 2, ..., n−1), dove 1 bit indica la presenza e 0 bit l'assenza di un numero dell'insieme.

Sebbene la maggior parte delle macchine non sia in grado di indirizzare singoli bit in memoria, né disponga di istruzioni per manipolare singoli bit, ogni bit in una parola può essere individuato e manipolato utilizzando operazioni bit a bit.

Le operazioni bit-wise sui bit-array sono le seguenti:

(setq b1 '(1 1 1 0 1 0 1 0))
(setq b2 '(0 0 0 1 0 1 0 1))

OR (Impostare un bit a 1):
11101010 OR 00000100 = 11101110

AND (Impostare un bit a 0):
11101010 AND 11111101 = 11101000

AND (Determinare se un bit vale 1, zero-test):
11101010 AND 00000001 = 00000000 = 0
11101010 AND 00000010 = 00000010 != 0

XOR (Invertire un bit)
11101010 XOR 00000100 = 11101110
11101110 XOR 00000100 = 11101010

NOT (Invertire tutti i bit):
NOT 10110010 = 01001101

Per ottenere la maschera di bit (bit-mask) necessaria per queste operazioni, possiamo utilizzare un operatore di bit shift per spostare il numero 1 a sinistra del numero appropriato di posizioni, nonché la negazione bit per bit (bitwise) se necessario.

Dati due array di bit, a e b, della stessa dimensione che rappresentano insiemi (set), possiamo calcolare la loro unione, intersezione e differenza degli insiemi (set) utilizzando semplici operazioni di bit:

    unione[i]       := a[i] or b[i]
    intersezione[i] := a[i] and b[i]
    differenza[i]   := a[i] and (not b[i])

Definiamo le funzioni "AND", "OR", "XOR", e "NOT" per i bit-array:

Funzione "AND":
(define (bit-and b1 b2) (map & b1 b2))

Funzione "OR":
(define (bit-or b1 b2) (map | b1 b2))

Funzione "XOR":
(define (bit-xor b1 b2) (map ^ b1 b2))

Funzione "NOT":
(define (bit-not b) (map (fn(x) (- 1 x)) b))

Facciamo una prova:

(bit-and '(1 1 1 0 0) '(0 1 1 1 0))
;-> (0 1 1 0 0)
(bit-or '(1 1 1 0 0) '(0 1 1 1 0))
;-> (1 1 1 1 0)
(bit-xor '(1 1 1 0 0) '(0 1 1 1 0))
;-> (1 0 0 1 0)
(bit-not '(1 1 1 0 0))
;-> (0 0 0 1 1)

newLISP ha funzioni integrate per l'unione ("union"), l'intersezione ("intersection") e la differenza ("difference") tra due insiemi (set).

Vediamo un semplice esempio di intersezione tra insiemi (set) con i bit-array.

Set1 = (1 3 6 8 9)
Bit-Array1 = (0 1 0 1 0 0 1 0 1 1)
              0 1 2 3 4 5 6 7 8 9
(setq b1 '(0 1 0 1 0 0 1 0 1 1))

Set2 = (2 3 5 7 9)
Bit-Array2 = (0 0 1 1 0 1 0 1 0 1)
              0 1 2 3 4 5 6 7 8 9
(setq b2 '(0 0 1 1 0 1 0 1 0 1))

(define (intersezione b1 b2)
  (let ((out '()) (bint (bit-and b1 b2)))
    (dolist (el bint)
      (if (= el 1) (push $idx out -1))
    )
    (println bint)
    out))

(intersezione b1 b2)
;-> (0 0 0 1 0 0 0 0 0 1)
;-> (3 9)

Vediamo alcune funzioni per gestire i bit-array.

Funzione che verifica se un array (o una lista) è un bit-array:

(define (bit-array? b)  (apply (fn(x) (or (= x 0) (= x 1))) b))

(bit-array? '(1 0 0 1 1))
;-> true
(bit-array? '(2 0 0 1 1))
;-> nil

Funzione che imposta i bit tutti a 0:

(define (bit-clear b) (dup 0 (length b)))

(bit-clear '(0 1 1 1 1 0 0 1))
;-> (0 0 0 0 0 0 0 0)

Funzione che imposta i bit tutti a 1:

(define (bit-set b) (dup 1 (length b)))

(bit-set '(0 1 1 1 1 0 0 1))
;-> (1 1 1 1 1 1 1 1)

Funzione che conta gli 0 di un bit-array:

(define (bit-set-count b) (first (count '(1) b)))

(bit-set-count '(0 1 1 1 1 0 0 1))
;-> 5

Funzione che conta gli 1 di un bit-array:

(define (bit-unset-count b) (first (count '(0) b)))

(bit-unset-count '(0 1 1 1 1 0 0 1))
;-> 3

Funzione che inverte un bit-array:

(define (bit-invert b) (reverse b))

(bit-invert '(1 1 1 0 0 1))
;-> (1 0 0 1 1 1)

Funzione che inverte i valori di un bit-array (0 ->1) (1 -> 0):

(define (bit-flip b) (map (fn(x) (- 1 x)) b))

(bit-flip '(1 1 1 0 0 1))
;-> (0 0 0 1 1 0)

Nota: per accedere e gestire i singoli elementi dei bit-array possiamo usare i classici metodi di indicizzazione.


------------------------------------------------------------
Dividere una stringa alla prima occorrenza di ogni carattere
------------------------------------------------------------

Data una stringa ASCII stampabile, dividerla in sottostringhe.
Le sottostringhe iniziano ogni volta che compare un nuovo carattere.

Per esempio:
  massimo --> m, a, ss, im, o
  mississippi --> m, i, ssissi, ppi
  Adam --> A, d, a, m

(define (break str)
  (local (out vecchi tmp)
    (setq out '())
    ; lista dei caratteri visti
    (setq vecchi '())
    ; sottostringa
    (setq tmp "")
    ; ciclo per ogni carattere
    (dolist (ch (explode str))
      (cond ((find ch vecchi) ; se carattere in vecchi
              (extend tmp ch)); allora aumenta la stringa tmp
            (true ; se carattere non in vecchi
              ; mette carattere nei vecchi
              (push ch vecchi)
              ; se tmp non è nulla , allora la inserisce nel risultato
              (if (!= tmp "") (push tmp out -1))
              ; la sottostringa tmp diventa il carattere
              (setq tmp ch)
            )
      )
    )
    ; ; se tmp non è nulla , allora la inserisce nel risultato (ultima)
    (if (!= tmp "") (push tmp out -1))
    out))

Facciamo alcune prove:

(break "")
;-> ()
(break "massimo")
;-> ("m" "a" "ss" "im" "o")
(break "mississippi")
;-> ("m" "i" "ssissi" "ppi")
(break "AAA")
;-> ("AAA")
(break "P P & C G")
;-> ("P" " P " "& " "C " "G")
(break "Adam")
;-> ("A" "d" "a" "m")
(break "newLISP")
;-> ("n" "e" "w" "L" "I" "S" "P")


----------------------
Codice (quasi) segreto
----------------------

Due agenti segreti hanno escogitato il seguente metodo di comunicazione:

1) Prendere il codice ASCII di ogni lettera. (Non vengono usati spazi, numeri o punteggiatura)

2) Per ogni lettera del messaggio, prendiamo il codice ASCII di essa e il codice ASCII della lettera successiva (se esiste, se non esiste, deve essere considerata 0).

3) I due valori vengono moltiplicati (questo prodotto viene memorizzato in una lista) e sommati (questo numero viene memorizzato in una lista diversa).

4) Le due liste (delle somme e dei prodotti) vengono unite (prima le somme, poi i prodotti) in un unica lista che viene trasmessa.

Esempi di coppie di messaggi cifrati e in chiaro:

(173 209 216 219 198 198 225 222 208 100 
 7272 10908 11664 11988 9657 9657 12654 12312 10800 0) -> "HelloWorld"
 
(131 133 164 195 197 99 
 4290 4422 6499 9506 9702 0) -> "ABCabc"

Scrivere due funzioni di codifica e decodifica di questo metodo.

Funzione che cripta una stringa:

(define (crypt str)
  (local (len somma prodotto)
    (setq len (length str))
    (for (i 0 (- len 2))
      ; codice ASCII carattere corrente
      (setq ch1 (char (str i)))
      ; codice ASCII carattere successivo
      (setq ch2 (char (str (+ i 1))))
      ; aggiorna lista prodotto
      (push (* ch1 ch2) prodotto -1)
      ; aggiorna lista somma
      (push (+ ch1 ch2) somma -1)
    )
    ; aggiorna le liste con l'ultimo valore
    (push 0 prodotto -1)
    (push (char (str -1)) somma -1)
    ; unisce le liste
    (append somma prodotto)))

(setq data (crypt "HelloWorld"))
;-> (173 209 216 219 198 198 225 222 208 100 7272 10908 11664 11988 9657 9657 12654 12312
;->  10800 0)

Per decriptare il messaggio è sufficiente prendere la lista delle somme.
Partiamo dall'ultimo valore che rappresenta il codice ASCII dell'ultima lettera del messaggio.
Adesso per trovare la lettera precedente basta sottrarre il codice ASCII dell'ultimo carattere decodificato al numero corrente per ottenere il codice ASCII della lettera.
Ripetere questo procedimento fino all'inizio della lista.

Funzione che decripta una lista di numeri (somme e prodotti):

(define (decrypt lst)
  (setq out "")
  ; serve solo la parte delle somme
  (setq half (slice lst 0 (/ (length lst) 2)))
  ; il precedente dell'ultimo carattere vale 0 (lista inversa)
  (setq prev 0) 
  ; ciclo dalla fine della lista di somme
  (dolist (num (reverse half))
      ; sottrae il codice ASCII precedente
      (setq num-ch (- num prev))
      ; carattere dal codice ASCII
      (extend out (char num-ch))
      ; il codice ASCII corrente diventa il precedente 
      (setq prev num-ch)
  )
  (reverse out)
)

(decrypt data)
;-> "HelloWorld"

(decrypt (crypt "ABCabc"))
;-> "ABCabc"


--------------------------------------
Quanto costa eval in termini di tempo?
--------------------------------------

Vedere anche "eval, eval-string, read-expr" su "Note libere 6".

newLISP mette a disposizione la funzione "eval" (e anche "eval-string") che è molto potente, ma quanto costa la sua esecuzione?

Ad esempio, vediamo la velocità di "eval" nel passaggio per riferimento.

Funzione che valuta l'oggetto passato:

(define (ev obj) (eval obj))

Usiamo tre liste (1000, 1 milione, 10 milioni):

(silent
  (setq a (sequence 1 1e3))
  (setq b (sequence 1 1e6))
  (setq c (sequence 1 1e7)))

(time (ev 'a))
;-> 0
(time (ev 'b))
;-> 8.976
(time (ev 'c))
;-> 95.771

Con 1 milione di elementi "eval" impiega circa 9 millisecondi.
Con 10 milioni di elementi "eval" impiega circa 96 millisecondi.

La velocità di "eval" è inversamente proporzionale al numero degli elementi della struttura da valutare.


------------------
Subset Sum Problem
------------------

Data una lista di numeri interi positivi, dividere la lista in due sottoliste:
1) i numeri che possono essere formati sommando gli altri elementi
2) i numeri che non possono essere formati sommando gli altri elementi

Un numero può essere formato da una lista di numeri se una o più sottoliste di elementi sommano al numero.

Funzione che data una lista e un numero, calcola tutte le sotto-liste che sommano a quel numero:

(define (subset-sum-all lst sum)
  (local (limit val len out)
    (setq out '())
    (setq len (length lst))
    ; numero di subset
    (setq limit (<< 1 len))
    ;(setq limit (pow 2 len))
    (for (i 0 (- limit 1))
      (setq val 0)
      (setq tmp '())
      (setq stop nil)
      (for (j 0 (- len 1) 1 stop)
        ; usa la rappresentazione binaria di "i"
        ; per decidere quali elementi prendere.
        (if (!= (& i (<< 1 j)))
          (begin
            (push (lst j) tmp -1)
            (setq val (+ val (lst j)))
            ; stop se somma del sottoinsieme corrente
            ; supera il valore sum
            (if (> val sum) (setq stop true))
          )
        )
      )
      (if (= val sum)
        ; aggiunge un sottosieme che somma a sum
        (push tmp out -1)
      )
    )
    out))

(subset-sum-all '(1 2 3 4 5) 10)
;-> ((1 2 3 4) (2 3 5) (1 4 5))

(subset-sum-all (sequence 1 10) 10)
;-> ((1 2 3 4) (2 3 5) (1 4 5) (1 3 6) (4 6) (1 2 7) (3 7) (2 8) (1 9) (10))

Funzione che crea le due sottoliste (formabili e non):

(define (separa lst)
  (let ((somme '()) 
        (addendi '())
        (primitivi '())
        (tmp lst))
    (dolist (el lst)
      ; toglie il numero corrente
      (pop tmp $idx)
      ; calcola tutte le somme possibili
      (setq somme (map (fn(x) (apply + x)) (subset-sum-all tmp el)))
      (if (find el somme)
          (push el addendi -1)
          (push el primitivi)
      )
      (setq tmp lst)
    )
    (list addendi primitivi)))

Facciamo alcune prove:

(separa '(2 3 1 1))
;-> ((2 3 1 1) ())
(separa '(2 3 1))
;-> ((3) (1 2))
(separa '(8 2 1 4))
;-> (() (4 1 2 8))
(separa '(7 2 1 4))
;-> ((7) (4 1 2))
(separa '(7 2 1 4 6))
;-> ((7 6) (4 1 2))
(separa (sequence 1 10) 20)
;-> ((3 4 5 6 7 8 9 10) (2 1))

Vedere anche "Somma dei sottoinsiemi (Subset Sum Problem)" su "Note libere 8".


-------------------
Scatola di biscotti
-------------------

Una scatola di biscotti contiene K tipi diversi di biscotti.
Inoltre, contiene quantità diverse di ciascun tipo di biscotto.

I biscotti vanno mangiati con la seguente regola:
  il giorno N-esimo bisogna mangiare N biscotti diversi.

In altre parole:
il giorno 1 dobbiamo mangiare 1 biscotto
il giorno 2 dobbiamo mangiare 2 biscotti (tutti diversi)
il giorno 3 dobbiamo mangiare 3 biscotti (tutti diversi)
ecc.

Se non è possibile seguire la regola, allora non è possibile continuare a mangiare i biscotti.

Trovare il numero massimo di giorni N in cui è possibile mangiare i biscotti.

La lista di input contiene K numeri interi positivi, che specificano il numero di biscotti per ogni diverso tipo.


Soluzione
---------
Occorre "mangiare" 1 ciascuno degli N biscotti con la quantità maggiore ogni giorno, iniziando con N=1, fino a quando non esistono più N biscotti diversi.
Restituire il numero di giorni in cui è stato possibile mangiare i biscotti.

(define (eats lst)
  (let ( (day 1) (stop nil) (eated 0) )
    (until stop
      ; mangia day biscotti diversi
      ; partendo dai tipi con il maggior numero di biscotti
      (sort lst >)
      (setq eated 0)
      (dolist (el lst (= eated day))
        (-- (lst $idx))
        (++ eated)
      )
      ; numero di tipi di biscotti rimasti
      (setq fill (clean zero? lst))
      ; esistono un numero di tipi di biscotti da mangiare
      ; il prossimo giorno?
      (if (< (length fill) (+ day 1)) 
          (setq stop true)
          ;else
          (++ day)
      )
    )
    day))

Facciamo alcune prove:

(eats '(1 2))
;-> 2
(eats '(1 2 3))
;-> 3
(eats '(1 2 3 4 4))
;-> 4
(eats '(1 2 3 3))
;-> 3
(eats '(2 2 2))
;-> 3
(eats '(1 1 1 1))
;-> 2
(eats '(11 22 33 44 55 66 77 88 99))
;-> 9
(eats '(10 20 30 40 50 60 70 80))
 -> 8
(eats '(3 3 3 3 3 3 3 3 3 3 3)) 
;-> 7
(eats '(3 3 3 3 3 3 3 3 3))
;-> 6
(eats '(9 5 6 8 7))
;-> 5
(eats '(1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 3 3 3 3 3 3 3 3
        3 3 3 3 4 4 4 4 4 4 4 4 4 4 4 4 5 5 5 5 5 5 5 5 5 5 5 5 6 6 6 6
        6 6 6 6 6 6 6 6 7 7 7 7 7 7 7 7 7 7 7 7 8 8 8 8 8 8 8 8 8 8 8 8
        9 9 9 9 9 9 9 9 9 9 9 9 10 10 10 10 10 10 10 10 10 10 10 10))
;-> 35
(eats '(1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1
        2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2
        3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2 3 4 5 6 7 8 9 10 1 2 3
        4 5 6 7 8 9 10))
;-> 32


-----------------------------
Numeri armonici generalizzati
-----------------------------

Il concetto di numero armonico può essere generalizzato.
Fissati due interi naturali m ed n, si definisce come n-esimo numero armonico generalizzato di esponente m la somma:

  H(n,m) = Sum[k=1..n](1/k^m)

(define (** num power)
"Calculates the integer power of an integer"
  (if (zero? power) 1
      (let (out 1L)
        (dotimes (i power)
          (setq out (* out num))))))

; Funzioni per il calcolo delle quattro operazioni
; aritmetiche con le frazioni: "+", "-" "*" "/"
; (big-integer enabled)
(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))
(define (+rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (+ (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1L) (r2 1L))))
(define (-rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (- (* (r1 0L) (r2 1L))
          (* (r2 0L) (r1 1L)))
       (* (r1 1) (r2 1))))
(define (*rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 0L))
       (* (r1 1L) (r2 1L))))
(define (/rat r1 r2)
  (setq r1 (list (bigint (r1 0)) (bigint(r1 1))))
  (setq r2 (list (bigint (r2 0)) (bigint(r2 1))))
  (rat (* (r1 0L) (r2 1L))
       (* (r1 1L) (r2 0L))))

Funzione che calcola il valore esatto di un numero armonico generalizzato dato n e m:

(define (H n m)
  (let (sum '(0 1))
    (for (k 1 n) (setq sum (+rat sum (list 1 (** k m)))))
    sum))

Facciamo alcune prove:

(H 3 7)
;-> (282251L 279936L)
(H 6 4)
;-> (14011361L 12960000L)
(H 5 5)
;-> (806108207L 777600000L)
(H 4 8)
;-> (431733409L 429981696L)
(H 3 1)
;-> (11L 6L)
(H 8 3)
;-> (78708473L 65856000L)
(H 7 2)
;-> (266681L 176400L)
(H 6 7)
;-> (940908897061L 933120000000L)
(H 2 8)
;-> (257L 256L)
(H 5 7)
;-> (2822716691183L 2799360000000L)


-------------------
Esercizio Toy-Robot
-------------------

Il "Toy-Robot" è un famoso esercizio che viene comunemente utilizzato come problema nelle interviste per programmatori.

È stato originariamente sviluppato dal programmatore Jon Eaves:
https://joneaves.wordpress.com/2014/07/21/toy-robot-coding-test/

La descrizione dell'esercizio è abbastanza semplice, ma ha una certa complessità di fondo che può portare a qualche difficoltà nel provare a risolverlo.

Le specifiche dell'esercizio "Toy-Robot":
Si tratta di simulare un robot giocattolo che si muove su un tavolo quadrato, di dimensioni 5 unità x 5 unità.
Non ci sono altri ostacoli sulla superficie del tavolo.
Il robot è libero di muoversi sulla superficie del tavolo.
Qualsiasi movimento che provocherebbe la caduta del robot dal tavolo è impedito, tuttavia sono comunque consentiti ulteriori comandi di movimento validi.
Il robot è controllato dai comandi eseguit dalla REPL (o dalla lettura di un file di comandi).

Sono validi i seguenti comandi:

  1) PLACE X,Y,F
  2) MOVE
  3) LEFT
  4) RIGHT
  5) REPORT
  6) SHOW

- PLACE metterà il robot giocattolo sul tavolo in posizione X, Y e rivolto a NORD, SUD, EST o OVEST.
- L'origine (0,0) è l'angolo più a SUD-OVEST.
- Tutti i comandi vengono ignorati finché non viene creato un PLACE valido.
- MOVE sposterà il robot giocattolo di un'unità in avanti nella direzione in cui è attualmente rivolto.
- LEFT e RIGHT ruotano il robot di 90 gradi nella direzione specificata senza modificare la posizione del robot.
- REPORT stampa la posizione e l'orientamento del robot (X, Y e F).
- SHOW stampa la griglia con la posizione e l'orientamento del robot.

Si suppone che il file abbia tutti i comandi sintatticamente corretti.
Tutti i comandi devono essere in maiuscolo.

Implementazione
---------------

Comandi:
  1) (PLACE X Y F)
  2) (MOVE)
  3) (LEFT)
  4) (RIGHT)
  5) (REPORT)
  6) (SHOW)

Funzione SETUP (definisce le variabili globali dell'applicazione):

(define (SETUP)
  ; grid dimension
  (setq side 5)
  ; table grid 5x5 (side x side)
  (setq table (array-list (array side side '(.))))
  ; current position of robot (x y) (col row)
  (setq xpos nil)
  (setq ypos nil)
  ; current direction of robot
  (setq dir nil)
  ; possible directions
  (setq directions '("NORTH" "SUD" "EAST" "WEST"))
  (setq NORTH "NORTH")
  (setq SUD "SUD")
  (setq EAST "EAST")
  (setq WEST "WEST")
  ; symbols of directions
  (setq dir-symbols '("N" "S" "E" "W"))
  (setq dir-symbols '("^" "!" ">" "<"))
  ; these don't works on windows (dos)
  ;(setq dir-symbols '("↑" "↓" "→" "←"))
  ;(setq dir-symbols '("∧" "∨" ">" "<"))
  ; to test symbols
  ;(map println dir-symbols)
  )

Funzione LOAD-FILE (carica ed esegue un file di comandi):

(define (LOAD-FILE filename)
  (let (aFile (open filename "read"))
    (while (setq line (read-line aFile))
      ;(write-line)
      ; skip comment
      (if (!= (line 0) ";") (eval-string line))
    )
    (close aFile)
    'end-of-file))

(LOAD-FILE "robot.txt")

Funzione REPORT:

(define (REPORT)
  (println "Robot is at ("xpos ", " ypos"), facing " dir))

Funzione PLACE:

(define (PLACE x y f)
  (cond
    ; robot position is inside the table?
    ((or (< x 0) (< y 0) (> x (- side 1)) (> y (- side 1))) nil)
    ; robot direction is valid?
    ((not (find f directions)) nil)
    ; setting place values
    (true
      (setq xpos x)
      (setq ypos y)
      (setq dir f))))

Funzione MOVE:

(define (MOVE)
  ; robot already placed?
  (if (nil? dir) nil
    ; else
    (local (xnew ynew)
      (setq xnew xpos)
      (setq ynew ypos)
      ; calculate new position based on actual direction
      (case dir
        ("NORTH" (++ ynew))
        ("SUD"   (-- ynew))
        ("EAST"  (++ xnew))
        ("WEST"  (-- xnew))
      )
      (cond
        ; robot new position is inside the table?
        ((or (< xnew 0) (< ynew 0) (> xnew (- side 1)) (> ynew (- side 1))) nil)
        ; setting place values
        (true
          (setq xpos xnew)
          (setq ypos ynew))))))

Funzione LEFT:

(define (LEFT)
  ; robot already placed?
  (if (nil? dir) nil
    ; else
    (case dir
      ("NORTH" (setq dir "WEST"))
      ("SUD"   (setq dir "EAST"))
      ("EAST"  (setq dir "NORTH"))
      ("WEST"  (setq dir "SUD"))
      (true nil))))

Funzione RIGHT:

(define (RIGHT)
  ; robot already placed?
  (if (nil? dir) nil
    ; else
    (case dir
      ("NORTH" (setq dir "EAST"))
      ("SUD"   (setq dir "WEST"))
      ("EAST"  (setq dir "SUD"))
      ("WEST"  (setq dir "NORTH"))
      (true nil))))

Funzione SHOW:

(define (SHOW)
  ; robot already placed?
  (if (nil? dir) nil
    ;else
    ; tavolo di gioco 5x5 (side x side)
    (begin
      ; setting symbol of direction
      (setq (table ypos xpos) (dir-symbols (find dir directions)))
      ; print grid (as cartesian plane)
      ; row -> y, col -> x
      ; y is reversed
      (for (y (- side 1) 0)
        ; y axis
        (print y { })
        (for (x 0 (- side 1))
          (print (string (table y x) " "))
        )
        (println)
      )
      ; x axis
      (println "  " (join (map string (sequence 0 (- side 1))) " "))
      ; clean table
      (setq (table ypos xpos) ".")
      '------------)))

Facciamo alcune prove:

Giro del tavolo in senso antiorario partendo dall'origine:
(SETUP)
(PLACE 0 0 "EAST")
(REPORT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(LEFT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(LEFT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(LEFT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(SHOW)

Giro del tavolo in senso orario partendo dall'origine (robot.txt):
(SETUP)
(PLACE 0 0 "NORTH")
(REPORT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(RIGHT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(RIGHT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(RIGHT)
(SHOW)
(MOVE) (MOVE) (MOVE) (MOVE)
(SHOW)

(LOAD-FILE "robot.txt")
;-> Robot is at (0, 0), facing NORTH
;-> 4 . . . . .
;-> 3 . . . . .
;-> 2 . . . . .
;-> 1 . . . . .
;-> 0 ^ . . . .
;->   0 1 2 3 4
;-> 4 > . . . .
;-> 3 . . . . .
;-> 2 . . . . .
;-> 1 . . . . .
;-> 0 . . . . .
;->   0 1 2 3 4
;-> 4 . . . . !
;-> 3 . . . . .
;-> 2 . . . . .
;-> 1 . . . . .
;-> 0 . . . . .
;->   0 1 2 3 4
;-> 4 . . . . .
;-> 3 . . . . .
;-> 2 . . . . .
;-> 1 . . . . .
;-> 0 . . . . <
;->   0 1 2 3 4
;-> 4 . . . . .
;-> 3 . . . . .
;-> 2 . . . . .
;-> 1 . . . . .
;-> 0 < . . . .
;->   0 1 2 3 4
;-> end-of-file

Nota: il programmatore Ryan Bigg ha scritto due libri sull'esercizio Toy-Robot,
"A walkthrough for The Toy Robot - The Elixir Version" e 
"A walkthrough for The Toy Robot - The Ruby Version"


--------------------
Estensioni Toy-Robot
--------------------

Alcune funzioni che estendono le funzionalità del Toy-Robot.

Funzione che muove il robot di L caselle (attuale direzione):

(define (MOVES L)
  (if (nil? dir) nil
    ;else
    (for (i 1 L) (MOVE))))

Funzione che inverte di 180 gradi la direzione del robot:

(define (FLIP)
  (if (nil? dir) nil
    ;else
    (LEFT) (LEFT)))

Disegna un punto nella cella corrente del robot:

(define (PLOT)
  (if (nil? dir) nil
    ;else
    (setq (table ypos xpos) "■")))

Pulisce la cella della posizione corrente del robot:

(define (UNPLOT)
  (if (nil? dir) nil
    ;else
    (setq (table ypos xpos) ".■")))

(define (LINE L)
  (if (nil? dir) nil
    ;else
    (for (i 1 L) (PLOT) (MOVE))))

(SETUP)
(PLACE 0 0 "NORTH")
(SHOW)
(PLOT)
(MOVE)
(PLOT)
(MOVE)
(SHOW)
;-> 4 . . . . .
;-> 3 . . . . .
;-> 2 ^ . . . .
;-> 1 ■ . . . .
;-> 0 ■ . . . .
;->   0 1 2 3 4
;-> ------------
(LINE 2)
(SHOW)
(RIGHT)
(LINE 4)
(SHOW)
;-> 4 ■ ■ ■ ■ >
;-> 3 ■ . . . .
;-> 2 ■ . . . .
;-> 1 ■ . . . .
;-> 0 ■ . . . .
;->   0 1 2 3 4
;-> ------------


--------------------
Creare scatole ASCII
--------------------

Dati due numeri interi come altezza e larghezza, disegnare una scatola con i caratteri "[]".
Per esempio,

Input:
  Altezza = 2
  Larghezza = 3
Output:
  [][][]
  [][][]

(define (box height width) (for (i 1 height) (println (dup "[]" width))))

(box 2 3)
;-> [][][]
;-> [][][]
(box 3 10)
;-> [][][][][][][][][][]
;-> [][][][][][][][][][]
;-> [][][][][][][][][][]


-------------------------
Calcolo del punteggio ELO
-------------------------

Calcolare il nuovo punteggio ELO (sistema di valutazione FIDE) per un giocatore dopo aver vinto, perso o pareggiato una partita di scacchi.

Per calcolare il rating ELO sono necessarie due formule:

  R' = R0 + K*(S - E)
  E = 1 / (1 + 10 ^ ((R1 - R0) / 400))

  R = R1 + K*(S - E)
  E = 1 / (1 + 10 ^ ((R2 - R1) / 400))

dove:
  R è la nuova valutazione per player0,
  R1 è la valutazione attuale di player1 e R2 è la valutazione attuale di player2,
  S è il punteggio della partita: 1 se player1 vince, 0 se player1 perde o 0.5 se player1 pareggia,
  K = 40 se la cronologia data ha una lunghezza < 30, anche se supera 2400
  K = 20 se la cronologia data ha una lunghezza >= 30 e non raggiunge mai 2400 (<2400),
  K = 10 se la cronologia data ha una lunghezza >= 30 e supera 2400 in qualunque punto (>=2400)

Se la cronologia non esiste, allora il rating ELO corrente vale 1000.

Input:
1) Lista delle valutazioni del giocatore 1 (numeri interi positivi maggiori di 0), dove l'ultimo elemento è la valutazione attuale del giocatore. (Se non viene fornita alcuna cronologia, la valutazione corrente sarà 1000.)
2) Valore ELO di player2 (numero intero)
3) Punteggio/risultato: 1, 0 o 0.5

Output:
R, nuovo valore dell'ELO di player1 (numero intero)

Implementazione:

(define (new-ELO lst r2 result)
  (local (r1 len k e r)
  ; setting ELO player1 (r1)
  (if (= lst '())
      (setq r1 1000)
      (setq r1 (lst -1))
  )
  ; setting K
  (setq len (length lst))
  (cond ((< len 30) (setq k 40))
        ((and (>= len 30) (find 2400 lst <)) (setq k 10))
        (true (setq k 20))
  )
  ; calculating E
  ; E = 1 / (1 + 10 ^ ((R2 - R1) / 400))
  (setq e (div (add 1 (pow 10 (div (sub r2 r1) 400)))))
  (println "k = " k)
  (println "e = " e)
  ; calculating new ELO for player1
  ; R = R1 + K*(S - E)
  (setq r (add r1 (mul k (sub result e))))
  ; round new ELO to integer
  (int (add r 0.5))))

Facciamo alcune prove:

(new-ELO '() 1500 1)
;-> 1038
(new-ELO '(1000 1025 1050 1075 1100 1125 1150 1175 1200 1225 1250 1275 1300 1325 1350 1375 1400 1425 1450 1475 1500 1525 1550 1575 1600 1625 1650 1675 1700 1725) 1000 0)
;-> 1705
(new-ELO '(1000 1025 1050 1075 1100 1125 1150 1175 1200 1225 1250 1275 1300 1325 1350 1375 1400 1425 1450 1475 1500 1525 1550 1575 1600 1625 1650 1800 2100 2500) 2200 0.5)
;-> 2497
(new-ELO '(2256 25 1253 1278 443 789) 3999 0.5)
;-> 809
(new-ELO '(783 1779 495 1817 133 2194 1753 2169 834 521 734 1234 1901 637) 3291 0.5)
;-> 657
(new-ELO '(190 1267 567 2201 2079 1058 1694 112 780 1182 134 1077 1243 1119 1883 1837) 283 1)
;-> 1837
(new-ELO '(1665 718 85 1808 2546 2193 868 3514 436 2913 6 654 797 2564 3872 2250 2597 1208 1928 3478 2359 3909 581 3892 1556 1175 2221 3996 3346 238) 2080 1)
;-> 248
(new-ELO '(1543 2937 2267 556 445 2489 2741 3200 528 964 2346 3467 2831 3746 3824 2770 3207 613 2675 1692 2537 1715 3018 2760 2162 2038 2637 741 1849 41 193 458 2292 222 2997)  3814  0.5)
;-> 3002


------------------------------------------
Probabilità di vittoria tra due rating ELO
------------------------------------------

Calcola la possibilità di vincita prevista per due giocatori in una partita di scacchi, ciascuno con il proprio punteggio ELO. Il giocatore 1 ha ELO R1 e il giocatore 2 ha ELO R2.

Il punteggio previsto per il giocatore 1 (E1) vale:
E1 = 1 / (1 + 10^((R2 - R1) / 400))

Il punteggio previsto per il giocatore 2 (E2) vale:
E2 = 1 / (1 + 10^((R1 - R2) / 400))

E1 + E2 dovrebbe essere uguale a 1 (a parte gli arrotondamenti dei floating).

Pertanto, il punteggio per un giocatore è il valore atteso di vincere una partita, in decimale.

(define (ELO r1 r2)
  (local (e1 e2)
    (setq e1 (div (add 1 (pow 10 (div (sub r2 r1) 400)))))
    (setq e2 (div (add 1 (pow 10 (div (sub r1 r2) 400)))))
    (println (sub 1 e2) { } (sub 1 e1))
    (list e1 e2)))

Vediamo alcuni esempi:

(ELO 1200 2100)
;-> 0.005591967308834822 0.9944080326911652
;-> (0.005591967308834779 0.9944080326911652)
(ELO 1 1)
;-> 0.5 0.5
;-> (0.5 0.5)
(ELO 1850 2400)
;-> 0.04046332603236424 0.9595366739676356
;-> (0.04046332603236435 0.9595366739676358)
(ELO 2700 2500)
;-> 0.759746926647958 0.2402530733520422
;-> (0.7597469266479578 0.2402530733520421)
(ELO 2500 2400)
;-> 0.6400649998028851 0.3599350001971149
;-> (0.6400649998028851 0.3599350001971149)
(ELO 9999 1)
;-> 1 0
;-> (1 1.011579454259896e-025)


---------------
newLISP QR Code
---------------

https://www.nayuki.io/page/creating-a-qr-code-step-by-step

Text string: newLISP
Error correction level: Low (Low Medium Quartile High)
Force minimum version:  1  (between 1 and 40)
Force mask pattern:    -1  (−1 for automatic, 0 to 7 for manual)

  ██████████████    ██  ████  ██████████████
  ██          ██    ██████    ██          ██
  ██  ██████  ██  ████  ████  ██  ██████  ██
  ██  ██████  ██    ██  ██    ██  ██████  ██
  ██  ██████  ██      ██  ██  ██  ██████  ██
  ██          ██          ██  ██          ██
  ██████████████  ██  ██  ██  ██████████████
                  ████  ████
  ██████  ████████████████  ████      ██
  ████  ██  ██      ████      ████      ████
  ████    ██  ██  ██  ██  ██      ██████████
      ████  ██  ██  ████      ████      ████
  ██████    ██████████    ██  ██  ████  ██
                  ██    ██  ██          ████
  ██████████████  ████████  ██████████  ████
  ██          ██  ████  ██████    ██      ██
  ██  ██████  ██  ████████  ████  ██  ██████
  ██  ██████  ██    ████      ██      ████
  ██  ██████  ██  ██  ██  ██    ████  ██  ██
  ██          ██  ██  ██      ██        ██
  ██████████████  ██  ██  ██  ██      ██████


--------------------------
Cicli su simboli/variabili
--------------------------

Supponiamo di avere N diverse variabili denominate v1,v2,...vN e di voler effettuare un ciclo su di esse (da v1 fino a vN).

Un primo metodo è quello di inserire tutte le variabili in una lista e poi effettuare il ciclo sulla lista:

(setq v1 10 v2 20 v3 30 v4 40 v5 50)
(setq lst (list v1 v2 v3 v4 v5))
(dolist (el lst) (print el { }))
;-> 10 20 30 40 50

Un secondo metodo è quello di utilizzare "sym" ed "eval":

(setq v1 10 v2 20 v3 30 v4 40 v5 50)
(for (i 1 5) (print (eval (sym (string "v" i))) { }))
;-> 10 20 30 40 50


--------------------
Simulazione del Golf
--------------------

Simulazione di una partita di golf (semplificata).

Regole della simulazione
------------------------
Inizialmente la distanza dalla buca è di 700 metri.

Se la distanza è maggiore o uguale a 250 metri:
  95% di fare un colpo random tra 250 e 350 metri
   5% di finire in acqua (+1 tiro e distanza immutata)

Se la distanza è maggiore di 10 metri e minore di 250 metri:
  80% di fare un colpo random tra il 70% e il 90% della distanza
  14% di fare un colpo random tra il 90% e il 99% della distanza
   5% di finire in acqua (+1 tiro e distanza immutata)
   1% di fare il 100% della distanza (palla in buca)

Se la distanza è minore o uguale a 10 metri:
  95% di fare il 100% della distanza (palla in buca)
   5% di fare il 75% della distanza

La distanza è un numero intero.

Funzione che estrae casualmente un indice della lista seguendo le probabilità assegnate:

(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    ;(if (= rnd 1) (println rnd))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero,
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

Funzione che simula una partita di golf per un solo giocatore:

(define (golf)
  (local (dist buca tiri lst action lancio)
    (setq dist 700)
    (println "Distanza dalla buca: " dist)
    (setq buca nil)
    (setq tiri 0)
    (until buca
      (cond ((>= dist 250) (lontano)) ; distanza maggiore o uguale a 250m
            ((and (> dist 10) (< dist 250)) (medio)) ; distanza tra 11m e 249m
            ((<= dist 10) (vicino))) ; distanza minore o uguale a 10m
      (stato)
      (read-line)
    )
    'hole))

Funzione che simula un colpo da lontano (distanza >= 250m):

(define (lontano)
  (println "lontano...")
  (++ tiri)
  ; lista delle probabilità
  (setq lst '(0.95 0.05))
  (setq action (rand-pick lst))
  (cond ((= action 0) ; 95% of distance
          (setq lancio (+ 250 (rand 101)))
          (setq dist (int (add (abs (- dist lancio)) 0.5)))
          ; buca?
          (if (zero? dist) (setq buca true)))
        ((= action 1) ; 5% water
         nil)))

Funzione che simula un colpo da distanza media (10m < distanza < 250m):

(define (medio)
  (println "medio...")
  (++ tiri)
  ; lista delle probabilità
  (setq lst '(0.80 0.14 0.05 0.01))
  (setq action (rand-pick lst))
  (cond ((= action 0) ; 80%
          (setq lancio (+ 70 (rand 21))) ; 70-90% of distance
          (setq lancio (int (add (div (mul lancio dist) 100) 0.5)))
          (setq dist (abs (- dist lancio))))
        ((= action 1) ; 14%
          (setq lancio (+ 90 (rand 11))) ; 90-99% of distance
          (setq lancio (int (add (div (mul lancio dist) 100) 0.5)))
          (setq dist (abs (- dist lancio))))
        ((= action 2) ; 5% water
          nil)
        ((= action 3) ; 1% buca
          (setq buca true)
          (setq lancio dist)
          (setq dist 0))))

Funzione che simula un colpo da vicino (distanza <= 10m):

(define (vicino)
  (println "vicino...")
  (++ tiri)
  ; lista delle probabilità
  (setq lst '(0.95 0.05))
  (setq action (rand-pick lst))
  (cond ((= action 0) ; buca
          (setq buca true)
          (setq lancio dist)
          (setq dist 0))
        ((= action 1) ; 75% of distance
          (setq lancio (int (add (mul 0.75 dist) 0.5)))
          (setq dist (abs (- dist lancio))))))

Funzione che stampa la situazione corrente:

(define (stato)
  (println "Numero di tiri: " tiri)
  (println "Ultimo lancio: " lancio "m")
  (println "Distanza: " dist "m")
)

Facciamo un paio di prove:

(golf)
;-> Distanza dalla buca: 700
;-> lontano...
;-> Numero di tiri: 1
;-> Ultimo lancio: 335m
;-> Distanza: 365m
;-> 
;-> lontano...
;-> Numero di tiri: 2
;-> Ultimo lancio: 261m
;-> Distanza: 104m
;-> 
;-> medio...
;-> Numero di tiri: 3
;-> Ultimo lancio: 79m
;-> Distanza: 25m
;-> 
;-> medio...
;-> Numero di tiri: 4
;-> Ultimo lancio: 79m
;-> Distanza: 25m
;-> 
;-> medio...
;-> Numero di tiri: 5
;-> Ultimo lancio: 19m
;-> Distanza: 6m
;-> 
;-> vicino...
;-> Numero di tiri: 6
;-> Ultimo lancio: 6m
;-> Distanza: 0m
;-> 
;-> hole

(golf)
;-> Distanza dalla buca: 700
;-> lontano...
;-> Numero di tiri: 1
;-> Ultimo lancio: 334m
;-> Distanza: 366m
;-> 
;-> lontano...
;-> Numero di tiri: 2
;-> Ultimo lancio: 310m
;-> Distanza: 56m
;-> 
;-> medio...
;-> Numero di tiri: 3
;-> Ultimo lancio: 42m
;-> Distanza: 14m
;-> 
;-> medio...
;-> Numero di tiri: 4
;-> Ultimo lancio: 10m
;-> Distanza: 4m
;-> 
;-> vicino...
;-> Numero di tiri: 5
;-> Ultimo lancio: 4m
;-> Distanza: 0m
;-> 
;-> hole


----------------
map sugli indici
----------------

Nella sua forma più semplice la funzione "map" applica una funzione ad una lista.
In questo caso vogliamo avere una funzione "mapidx" che applica una funzione ad una lista di indici di elementi di un'altra lista.
Per esempio,
Input:
  funzione --> f(x) = x^2
  lista di indici --> I = (2 4 5)
  lista di elementi --> L = (3 6 2 -5 -2 -6 7)
Output:
  (mapidx f I L) --> (3 6 4 -5 4 36 7)

Funzione che applica una funzione ad una lista di indici di elementi di un'altra lista:
(define (mapidx f I L)
  (dolist (idx I)
    (setf (L idx) (* $it $it))
  )
  L)

(setq indici '(2 4 5))
(setq lst '(3 6 2 -5 -2 -6 7))
(setq f (fn(x) (mul x x)))

(mapidx f indici lst)
;-> (3 6 4 -5 4 36 7)


-------------------------------
La funzione "swap" per stringhe
-------------------------------

Vediamo la definizione della funzione "swap" dal manuale di riferimento:

*****************
>>>funzione SWAP
*****************
sintassi: (swap place-1 place-2)

I contenuti delle due posizioni place-1 e place-2 vengono scambiati. Una posizione può essere il contenuto di un simbolo non quotato o qualsiasi riferimento a una lista o a un array espresso con "n-th", "first", "last" o con indicizzazione implicita o posizioni a cui fanno riferimento "assoc" o "lookup".

swap è un'operazione distruttiva che modifica il contenuto delle liste, degli array o dei simboli coinvolti.

(set 'lst '(a b c d e f))

(swap (first lst) (last lst))
;-> a
lst
;-> (f b c d e a)

(set 'lst-b '(x y z))

(swap (lst 0) (lst-b -1))
;-> f
lst
;-> (z b c d e a)
lst-b
;-> (x y f)

(set 'A (array 2 3 (sequence 1 6))
;-> ((1 2 3) (4 5 6))

(swap (A 0) (A 1))
;-> (1 2 3)
A
;-> ((4 5 6) (1 2 3))

(set 'x 1 'y 2)

(swap x y)
;-> 1
x
;-> 2
y
;-> 1

(set 'lst '((a 1 2 3) (b 10 20 30)))
(swap (lookup 'a lst -1) (lookup 'b lst 1))
lst
;-> ((a 1 2 10) (b 3 20 30))

(swap (assoc 'a lst) (assoc 'b lst))
lst
;-> ((b 3 20 30) (a 1 2 10))

Due posizioni qualsiasi possono essere scambiate nello stesso oggetto o in oggetti diversi.

Quindi "swap" non funziona con le stringhe!!!

Per esempio:

(setq b "12345")
;-> "12345"
(swap (b 0) (b 4))
;-> "1"
b
;-> "12345" ; la stringa b non è cambiata.

Scriviamo una funzione di "swap" per le stringhe:

(define (swap-char str pos1 pos2)
  (local (tmp)
    (setq tmp (str pos1))
    (setq (str pos1) (str pos2))
    (setq (str pos2) tmp)
    str))

(setq b "12345")
(setq b (swap-char b 0 4))
;-> "52341"
b
;-> "52341"

Oppure possiamo usare una macro:

(define-macro (sw-ch str pos1 pos2)
  (local (tmp)
    (setq tmp ((eval str) pos1))
    (setf ((eval str) pos1) ((eval str) pos2))
    (setf ((eval str) pos2) tmp)
    (eval str)))

(setq c "56789")
(sw-ch c 0 4)
;-> "96785"
c
;-> "96785"

Oppure una macro simile:

(define-macro (sw-ch1 str pos1 pos2)
  (local (s tmp)
    (setq s (eval str))
    (setq tmp (s pos1))
    (setf (s pos1) (s pos2))
    (setf (s pos2) tmp)
    (setq (eval str) s)))

(setq d "56789")
(sw-ch1 d 0 4)
;-> "96785"
d
;-> "96785"


-------------------------
Swap encoding di stringhe
-------------------------

Lo "Swap encoding" è un metodo di codifica in cui si esegue l'iterazione di una stringa, invertendone sezioni tra coppie di caratteri identici.

Algoritmo di base
Per ogni carattere della stringa:
Verificare se la stringa contiene di nuovo lo stesso carattere dopo il carattere corrente.
In tal caso, modificare la stringa invertendo la sezione tra il carattere corrente e l'istanza successiva del carattere, inclusa.
Altrimenti non fare niente e continuare con il prossimo carattere.

Esempio:
Stringa da codificare: "mangia il gelato"

"m" nessun carattere uguale -----------> "mangia il gelato"
"a" --> "angia" --> "ainga" -----------> "maigna il gelato"
"i" --> "ignai" --> "iangi" -----------> "mai angil gelato"
" " --> " angil " --> " ligna " -------> "mai ligna gelato"
"l" --> "ligna gel" --> "leg angil" ---> "mai leg angilato"
"e" --> nessun carattere uguale -------> "mai leg angilato"
"g" --> "g ang" --> "gna g" -----------> "mai legna gilato"
"n" --> nessun carattere uguale -------> "mai legna gilato"
"a" --> "a gila" --> "alig a" ---------> "mai legnalig ato"
"l" --> nessun carattere uguale -------> "mai legnalig ato"
"i" --> nessun carattere uguale -------> "mai legnalig ato"
"g" --> nessun carattere uguale -------> "mai legnalig ato"
" " --> nessun carattere uguale -------> "mai legnalig ato"
"a" --> nessun carattere uguale -------> "mai legnalig ato"
"t" --> nessun carattere uguale -------> "mai legnalig ato"
"o" --> nessun carattere uguale -------> "mai legnalig ato"

Stringa codificata: "mai legnalig ato"

Funzione che inverte parte di una stringa:

(define (reverse-part obj idx len)
  (extend (slice obj 0 idx)             ; parte a sinistra dell'inversione
          (reverse (slice obj idx len)) ; parte dell'inversione
          (slice obj (+ idx len))))     ; parte a destra dell'inversione

Funzione che cerca il prossimo carattere uguale di un dato carattere in una stringa:

(define (find-next idx ch str)
  (local (next stop)
    (setq stop nil)
    (setq next nil)
    (for (k (+ idx 1) (- (length str) 1) 1 stop)
      (if (= (str k) ch) (setq next k stop true))
    )
    next))

Funzione di "swap encoding":

(define (encode str)
(local (ch end)
(for (i 0 (- (length str) 2))
  (setq ch (str i))
  (setq end (find-next i ch str))
  ;(println ch { } i { } end)
  (if end (begin
    ;(println "reverse from " i " to " (- end i (- 1)))
    (setq str (reverse-part str i (- end i (- 1))))
    ;(println str)
    ;(read-line)
    )
  )
  ;(println str)
  ;(read-line)
)
str))

Facciamo alcune prove:

(encode "mangia il gelato")
;-> "mai legnalig ato"

(encode "Sandbox for Proposed Challenges")
;-> "SahC Pr foropox dbosenallednges"
(encode "Collatz, Sort, Repeat")
;-> "CoS ,ztrollaepeR ,tat"
(encode "Write a fast-growing assembly function")
;-> "Wrgnufa ylbme asa f g-tesstcnoritiwoin"
(encode "Decompress a Sparse Matrix")
;-> "Dera aM ssrtapmocese Sprix"
(encode "Rob the King: Hexagonal Mazes")
;-> "Rog: Kinob eH lagnaM thezaxes"
(encode "Determine if a dot(comma) program halts")
;-> "Detoc(tlamarommi finerp ha mrgod a) ets"
(encode "Closest Binary Fraction")
;-> "CloinosestiB Fry tcaran"
(encode "Quote a rational number")
;-> "Qunatebmuoiton re al ar"
(encode "Solve the Alien Probe puzzle")
;-> "SorP Alveht en eilzzup elobe"

Altra funzione di "swap encoding":

(define (encode2 str)
(local (lst indici len)
  (setq lst (explode str))
  (for (i 0 (- (length lst) 3))
    ;(println "i: " i)
    (setq indici (ref-all (lst i) (slice lst i)))
    ;(println indici)
    (if (> (length indici) 1)
      (begin
        (setq len (+ 1 (first (indici 1))))
        ;(println (lst i) { } i { } (indici 0) { } (indici 1) { } "len: " len)
        ;(print lst)
        ;(println (join (reverse-part lst i len)))
        (if (> len 2) (setq lst (reverse-part lst i len)))
        ;(println (join lst))
      )
    )
    ;(read-line)
  )
  (join lst)))

Facciamo alcune prove:

(encode2 "mangia il gelato")
;-> "mai legnalig ato"

(encode2 "Sandbox for Proposed Challenges")
;-> "SahC Pr foropox dbosenallednges"
(encode2 "Collatz, Sort, Repeat")
;-> "CoS ,ztrollaepeR ,tat"
(encode2 "Write a fast-growing assembly function")
;-> "Wrgnufa ylbme asa f g-tesstcnoritiwoin"
(encode2 "Decompress a Sparse Matrix")
;-> "Dera aM ssrtapmocese Sprix"
(encode2 "Rob the King: Hexagonal Mazes")
;-> "Rog: Kinob eH lagnaM thezaxes"
(encode2 "Determine if a dot(comma) program halts")
;-> "Detoc(tlamarommi finerp ha mrgod a) ets"
(encode2 "Closest Binary Fraction")
;-> "CloinosestiB Fry tcaran"
(encode2 "Quote a rational number")
;-> "Qunatebmuoiton re al ar"
(encode2 "Solve the Alien Probe puzzle")
;-> "SorP Alveht en eilzzup elobe"

La funzione di decodifica dovrebbe essere la seguente:

  reverse(encode(reverse(string-encoded)))

Per esempio:

(reverse (encode (reverse "mai legnalig ato")))
;-> "mangia il gelato"
(reverse (encode (reverse (encode "mangia il gelato"))))
;-> "mangia il gelato"
(reverse (encode2 (reverse (encode2 "mangia il gelato"))))
;-> "mangia il gelato"

(reverse (encode (reverse (encode "Collatz, Sort, Repeat"))))
;-> "Collatz, Sort, Repeat"
(reverse (encode2 (reverse (encode2 "Collatz, Sort, Repeat"))))
;-> "Collatz, Sort, Repeat"

Comunque alcune frasi non vengono decodificate correttamente (ma non ho capito il perchè):

(reverse (encode (reverse (encode "Solve the Alien Probe puzzle"))))
;-> "SolveilA en eht Probe puzzle"
(reverse (encode2 (reverse (encode2 "Solve the Alien Probe puzzle"))))
;-> "SolveilA en eht Probe puzzle"

(reverse (encode (reverse (encode "Quote a rational number"))))
;-> "Quonar etiota la number"
(reverse (encode2 (reverse (encode2 "Quote a rational number"))))
;-> "Quonar etiota la number"

La codifica delle formule sembra più efficace:

(encode "((a + b)/(a - b))*(a * b)")
;-> "((/)b + a(* a(a - *))b b)"

Comunque dobbiamo verificare se funziona la decodifica:

(reverse (encode (reverse (encode "((a + b)/(a - b))*(a * b)"))))
;-> "((a + b)/(a - b))*(a * b)"

=============================================================================

