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

(time (HP-i 86))

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
... interrotto

Elenco degli numeri il cui HP è sconosciuto (al 2023): 

(setq unknown '(49 77 80 96))

Vediamo dove possiamo arrivare:

(HP-i 49)
(HP-i 77)
(HP-i 80)
(HP-i 96)




