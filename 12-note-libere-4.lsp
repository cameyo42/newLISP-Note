===============

 NOTE LIBERE 4

===============

------------------------
Una relazione tra π ed e
------------------------

Tra il numero pi greco (π = 3.1415926535897931) e il numero di Eulero (Nepero) (e = 2.7182818284590451) esiste la seguente relazione:

(π^4 + π^5)^(1/6) = 2.718281808611915 ≈ e = 2.7182818284590451

(setq e 2.7182818284590451)
(setq π 3.1415926535897931)
(setq x (pow (add (pow π 4) (pow π 5)) (div 6)))
;-> 2.718281808611915

Differenza tra il valore x e il numero di eulero "e":

(sub e x)
;-> 1.984713016156547e-008


--------------------------
Ricerca del numero diverso
--------------------------

Una lista contiene tutti numeri positivi uguali tranne uno. Determinare l'indice del numero diverso.

Le spiegazioni della seguente implementazione si trovano nei commenti.

(define (diverso1 lst)
(catch
  (local (a b ia ib na nb)
    ; ripetizioni del numero "a"
    (setq na -1)
    ; ripetizioni del numero "b"
    (setq nb 0)
    ; Il numero "a" è il primo elemento della lista
    (setq a (lst 0))
    ; Il numero "b" vale -1
    ; perchè non ancora assegnato
    (setq b -1)
    ; indice del numero "a"
    (setq ia 0)
    ; per ogni numero della lista...
    (dolist (el lst)
            ; se l'elemento corrente è uguale ad "a"...
      (cond ((= el a)
             ; allora aumento il numero delle ripetizioni di "a"
             (++ na))
            ; altrimenti
            (true
             ; se b=-1 allora assegno l'elemento corrente a "b"
             ; e l'indice corrente all'indice del numero b"
             (if (= b -1) (setq b el ib $idx))
             ; aumento il numero delle ripetizioni di "b"
             (++ nb))
      )
      ; se le ripetizioni di "a" sono maggiori di 1 e
      ; "b" non vale -1 (cioè "b" è stato trovato)
      ; allora restituisco l'indice di b
      (if (and (> na 1) (!= b -1)) (throw ib))
      ; se le ripetizioni di "b" sono maggiori di 1
      ; allora restituisco l'indice di a
      (if (> nb 1) (throw ia))
    ))))

Facciamo alcune prove:

(setq lst '(11 4 11 11 11 11))
(diverso1 lst)
;-> 1

(setq lst '(4 11 11 11 11 11))
(diverso1 lst)
;-> 0

(setq lst '(11 11 11 11 11 4))
(diverso1 lst)
;-> 5

(setq lst '(11 11 4 11 11 11))
(diverso1 lst)
;-> 2

Possiamo utilizzare anche altri metodi:

(define (diverso2 lst)
(catch
  (cond ((and (= (lst 0) (lst 1)) (!= (lst 0) (lst 2))) throw 2)
        ((and (= (lst 0) (lst 2)) (!= (lst 0) (lst 1))) throw 1)
        ((and (= (lst 1) (lst 2)) (!= (lst 0) (lst 1))) throw 0)
        (true
          (for (i 3 (- (length lst) 1))
            (if (!= (lst i) (lst (- i 1)))
                (throw i)
            )
          )
        )
  )))

Facciamo alcune prove:

(setq lst '(11 4 11 11 11 11))
(diverso2 lst)
;-> 1

(setq lst '(4 11 11 11 11 11))
(diverso2 lst)
;-> 0

(setq lst '(11 11 11 11 11 4))
(diverso2 lst)
;-> 5

(setq lst '(11 11 4 11 11 11))
(diverso2 lst)
;-> 2


--------------------------
Ricerca del numero singolo
--------------------------

In una lista di numeri interi positivi, un numero compare una sola volta, mentre gli altri numeri compaiono un numero pari di volte (2*k con k=1,2,3,...). Scrivere una funzione per trovare il numero singolo.

Possiamo usare la funzione "xor" che ha la seguente proprietà: (x xor x) = 0, lo "xor" con lo stesso numero produce 0. Infatti risulta:

(^ 5 5)
;-> 0
(^ 11 11)
;-> 0

Lo "xor" ha anche le seguenti proprietà:

  xor è commutativo: A xor B = B xor A
  xor è associativo: (A xor B) xor C = A xor (B xor C)
  xor con 0 non cambia il valore: A xor 0 = A
  xor lo stesso numero produce 0: A xor A = 0

Nota: Lo "xor" in newLISP si chiama "^".

Quindi applicando lo "xor" agli elementi della seguente lista:

(2 3 3 4 7 1 7 4 2)

possiamo scrivere:

(2 xor 2) xor (3 xor 3) xor (4 xor 4) xor (7 xor 7) xor 1 =
= (0 xor 0) xor (0 xor 0) xor 1 =
= (0 xor 0) xor 1 =
= 0 xor 1 = 1

Quindi la nostra funzione è molto semplice:

(define (singolo lst)
  (apply ^ lst))

(singolo '(2 3 3 4 7 1 7 4 2))
;-> 1

Nota: questa funzione è valida solo se un numero compare una sola volta, mentre gli altri numeri compaiono un numero pari di volte nella lista.

Se volessimo ottenere l'indice del numero singolo potremmo scrivere:

(define (singolo-index lst)
  (find (apply ^ lst) lst))

(singolo-index '(2 3 3 4 7 1 7 4 2))
;-> 5


-----------------------
Punti in un semicerchio
-----------------------

Scegliendo n punti a caso su una circonferenza, qual'è la probabilità che tutti i punti si trovino in un semicerchio?

Supponiamo che il punto "i" abbia angolo 0 (l'angolo è arbitrario in questo problema) - essenzialmente questo è l'evento in cui il punto "i" è il "primo" o "punto iniziale" nel semicerchio. Quindi vogliamo che tutti i punti siano nello stesso semicerchio, cioè che i punti rimanenti finiscano tutti nel semicerchio superiore.
Questo è come il lancio di moneta per ogni punto rimanente, quindi la probabilità che i restanti (n − 1) punti siano nel semicerchio in senso orario di un dato punto è pari a 1/2^(n−1). Ci sono n punti e l'evento che qualsiasi punto i sia il "punto iniziale" è disgiunto dall'evento che qualsiasi altro punto j sia il "punto iniziale" (ed esattamente uno di essi deve accadere affinché i punti si trovino a semicerchio), quindi la probabilità finale vale n/2^(n−1) (cioè possiamo semplicemente sommare la probabilità degli n eventi).

  P = n/2^(n−1)

Nota: se abbiamo 1 o 2 punti, la probabilità deve essere 1, il che è vero in entrambi i casi.

(define (semi n)
  (div n (pow 2 (- n 1))))

(semi 1)
;-> 1
(semi 2)
;-> 1
(semi 3)
;-> 0.75

Scriviamo una funzione che simula questo processo:

(define (simula n iter)
  (local (p diff conta)
    (setq p (array n '(0)))
    (setq conta 0)
    (for (i 1 iter)
      ; genera n punti/eventi random (0,1)
      (for (j 0 (- n 1))
        (setf (p j) (random))
      )
      (sort p)
      (setq k 0)
      (while (< k n)
        ; calcola distanza tra due punti
        (setq diff (sub (p k) (p (% (+ k 1) n))))
        ; verifica se i due punti si trovano
        ; nello stesso semicerchio (0, 0.5)
        (if (< diff 0) (inc diff))
        (if (< diff 0.5)
            (setq conta (+ conta 1) k n)
        )
        (++ k)
      )
    )
    (div conta iter)))

Proviamo la funzione:

(simula 1 10)
;-> 1
(simula 2 10)
;-> 1
(simula 3 1000)
;-> 0738
(simula 3 10000)
;-> 0.7473
(simula 3 1000000)
;-> 0.749872

Proviamo con 10 punti:

(semi 10)
;-> 0.01953125
(simula 10 1e6)
;-> 0.020556


-----------------------------
Coefficiente di Sorensen-Dice
-----------------------------

Il coefficiente Sorensen – Dice è una statistica utilizzata per misurare la somiglianza di due campioni ed è stato sviluppato indipendentemente da Dice nel 1945 e Sorensen nel 1948.
La formula originale di Sørensen doveva essere applicata a dati discreti. Dati due insiemi, X e Y, il coefficiente è definito come:

         2*|X ∩ Y|
  DSC = -----------
         |X| + |Y|

dove |X| e |Y| sono le cardinalità dei due liste (cioè il numero di elementi in ogni lista). L'indice di Sorensen è uguale al doppio del numero di elementi comuni a entrambe le liste (intersezione) diviso per la somma del numero di elementi di ogni lista.

(define (sorensen lst1 lst2)
  (div (* 2 (length (intersect lst1 lst2)))
       (+ (length lst1) (length lst2))))

Due liste uguali producono un coefficiente pari a 1:

(setq lst1 '(1 2 3 4 5 6))
(setq lst2 '(1 2 3 4 5 6))
(sorensen lst1 lst2)
;-> 1

(sorensen (sequence 1 100) (sequence 100 199))
;-> 0.01
(sorensen (sequence 1 1000) (sequence 1000 1999))
;-> 0.001

Nota: il coefficiente non tiene conto della magnitude (valore) degli elementi.

Vediamo come varia il coefficiente al variare del numero di elementi distinti tra le due liste che hanno lo stesso numero di elementi:

(define (test-sorensen len)
  (local (lst1 lst2 fmt)
    (for (i 0 len)
      (setq lst1 (sequence 1 len))
      (setq lst2 (sequence (+ i 1) (+ len i)))
      (setq diversi (length (difference lst1 lst2)))
      (setq l1 (string (length (string lst1))))
      (setq l2 (string (length (string lst2))))
      (setq dd (string (+ 1 len (length (string lst1)) (- (length (string lst2))))))
      (println (format (string "%-" l1 "s " "%-" l2 "s " "%" dd "d %8.3f")
               (string lst1) (string lst2) diversi (sorensen lst1 lst2)))
    )))

(test-sorensen 5)
;-> (1 2 3 4 5) (1 2 3 4 5)      0    1.000
;-> (1 2 3 4 5) (2 3 4 5 6)      1    0.800
;-> (1 2 3 4 5) (3 4 5 6 7)      2    0.600
;-> (1 2 3 4 5) (4 5 6 7 8)      3    0.400
;-> (1 2 3 4 5) (5 6 7 8 9)      4    0.200
;-> (1 2 3 4 5) (6 7 8 9 10)     5    0.000

(test-sorensen 10)
;-> (1 2 3 4 5 6 7 8 9 10) (1 2 3 4 5 6 7 8 9 10)           0    1.000
;-> (1 2 3 4 5 6 7 8 9 10) (2 3 4 5 6 7 8 9 10 11)          1    0.900
;-> (1 2 3 4 5 6 7 8 9 10) (3 4 5 6 7 8 9 10 11 12)         2    0.800
;-> (1 2 3 4 5 6 7 8 9 10) (4 5 6 7 8 9 10 11 12 13)        3    0.700
;-> (1 2 3 4 5 6 7 8 9 10) (5 6 7 8 9 10 11 12 13 14)       4    0.600
;-> (1 2 3 4 5 6 7 8 9 10) (6 7 8 9 10 11 12 13 14 15)      5    0.500
;-> (1 2 3 4 5 6 7 8 9 10) (7 8 9 10 11 12 13 14 15 16)     6    0.400
;-> (1 2 3 4 5 6 7 8 9 10) (8 9 10 11 12 13 14 15 16 17)    7    0.300
;-> (1 2 3 4 5 6 7 8 9 10) (9 10 11 12 13 14 15 16 17 18)   8    0.200
;-> (1 2 3 4 5 6 7 8 9 10) (10 11 12 13 14 15 16 17 18 19)  9    0.100
;-> (1 2 3 4 5 6 7 8 9 10) (11 12 13 14 15 16 17 18 19 20) 10    0.000

Il coefficiente di Dice può essere utilizzato per misurare quanto siano simili due stringhe in termini di numero di bigrammi comuni (un bigramma è una coppia di lettere adiacenti nella stringa).
Il coefficiente per due stringhe x e y viene calcolato come segue:

        2*nt
  d = ---------
       nx + ny

dove: nt è il numero di bigrammi che si trovano in entrambe le stringhe,
      nx è il numero di bigrammi nella stringa x,
      ny è il numero di bigrammi nella stringa y.

Vediamo una semplice implementazione (non molto efficiente):

(define (bigrammi str)
  (let (lst-str (explode str))
    (map string (chop lst-str) (rest lst-str))))

(bigrammi "pippo")
;-> ("pi" "ip" "pp" "po")

(bigrammi "pappa")
;-> ("pa" "ap" "pp" "pa")

(define (sorensen-string str1 str2)
  (local (nx-lst ny-lst nt-lst)
    (setq bigram-x (bigrammi str1))
    (setq bigram-y (bigrammi str2))
    (setq nx (length bigram-x))
    (setq ny (length bigram-y))
    (setq nt (length (intersect bigram-x bigram-y)))
    (div (* 2 nt) (+ nx ny))))

Facciamo alcune prove:

(sorensen-string "pippo" "pappa")
;-> 0.25

(sorensen-string "gggg" "gg")
;-> 0.5

(sorensen-string "healed" "sealed")
;-> 0.8

(sorensen-string "algorithms are fun" "logarithms are not")
;-> 0.5882352941176471

(sorensen-string "Questa è una stringa" "e questa è un'altra stringa")
;-> 0.66666666666666

(sorensen-string "This is a string" "And this is another string")
;-> 0.55

Nota: questa implementazione tratta più occorrenze di un bigramma come uniche.
La correttezza di questo comportamento si nota quando si calcola il coefficiente per le stringhe "GG" e "GGGGGGGG", che ovviamente non deve essere 1.


----------------
Parole di Lyndon
----------------

Dato un intero n e una lista di caratteri S, generare tutte le parole di Lyndon di lunghezza n con i caratteri contenuti in S.

Una parola di Lyndon è una stringa che è strettamente inferiore a tutte le sue rotazioni in ordine lessicografico. Ad esempio, la stringa "012" è una parola di Lyndon poiché è inferiore alle rotazioni "120" e "201", ma "102" non è una parola di Lyndon in quanto è maggiore della sua rotazione "021".
Nota: "000" non è considerata una parola di Lyndon in quanto è uguale alla stringa ruotata.

Vediamo un paio di esempi:

Input: n = 2, S = ("0" "1" "2")
Output: "01" "02" "12"

Le altre possibili stringhe di lunghezza 2 sono "00", "11", "20", "21" e "22". Tutti queste sono maggiori o uguali a una delle loro rotazioni.

Input: n = 1, S = ("0" "1" "2")
Output: "0" "1" "2"

Esiste un algoritmo efficiente per generare parole di Lyndon (proposto da Jean-Pierre Duval) che può essere utilizzato per generare tutte le parole di Lyndon di lunghezza n con tempo proporzionale al numero di tali parole (vedi "Average cost of Duval’s algorithm for generating Lyndon words" di Berstel e Pocchiola)

L'algoritmo genera le parole di Lyndon in ordine lessicografico. Se w è una parola di Lyndon, la parola successiva si ottiene con i seguenti passaggi:

1) Ripetere w per formare una stringa v di lunghezza n, tale che v[i] = w[i mod |w|].
2) Affinchè l'ultimo carattere di v è l'ultimo nell'ordinamento di S, rimuoverlo.
3) Sostituire l'ultimo carattere di v con il suo successore nell'ordinamento di S.

Ad esempio, se n = 5, S = (a b c d) e w = "add", otteniamo v = "addad".
Poiché "d" è l'ultimo carattere nell'ordinamento ordinato di S, lo rimuoviamo per ottenere "adda" e quindi sostituire l'ultima "a" con il suo successore "b" per ottenere la parola di Lyndon "addb".

Vediamo una possibile implementazione:

(define (lyndon n str)
  (local (k w m out)
    (setq out '())
    (setq k (length str))
    (sort str)
    ; Lista per memorizzare gli indici dei caratteri
    (setq w '(-1))
    ; Ciclo finché w non è vuoto
    (while w
      ; Incrementa l'ultimo carattere
      (setf (w -1) (+ (w -1) 1))
      (setq m (length w))
      (if (= m n)
          ;(println (join (select str w)))
          (push (join (select str w)) out -1)
      )
      ; Ripete w per ottenere una stringa lunga n
      (while (< (length w) n)
        (push (w (- m)) w -1)
      )
      ; Rimuove l'ultimo carattere fintanto che è uguale al
      ; carattere più grande nella stringa
      (while (and w (= (w -1) (- k 1)))
        (setq w (chop w))
      )
    )
    out))

(lyndon 2 '("0" "1" "2"))
;-> ("01" "02" "12")

(lyndon 1 '("0" "1" "2"))
;-> ("0" "1" "2")

(lyndon 3 '("0" "1" "2"))
;-> ("001" "002" "011" "012" "021" "022" "112" "122")


-------------------------
Fattorizzazione di Lyndon
-------------------------

Una stringa è chiamata parola di Lyndon (o semplice), se è strettamente più piccola di uno qualsiasi dei suoi suffissi non banali. Esempi di stringhe semplici sono: a, b, ab, aab, abb, ababb, abcd. Si può dimostrare che una stringa è semplice, se e solo se è strettamente più piccola di tutte le sue rotazioni cicliche non banali.

Quindi, data stringa s la fattorizzazione di Lyndon della stringa s è una fattorizzazione s = w1w2… wk, dove tutte le stringhe wi sono semplici e sono in ordine non crescente w1≥w2≥ ... ≥w

Si può dimostrare che per ogni stringa tale fattorizzazione esiste ed è unica.

Algoritmo di Duval
------------------
L'algoritmo di Duval costruisce la fattorizzazione di Lyndon in tempo O (n) utilizzando la memoria aggiuntiva O (1).

Per prima cosa introduciamo un'altra nozione: una stringa t è chiamata pre-semplice, se ha la forma t = ww ... w (w), dove w è una stringa semplice e (w) è un prefisso di w (possibilmente vuoto). Anche una semplice stringa è pre-semplice.

L'algoritmo di Duval è greedy (avido). In qualsiasi momento durante la sua esecuzione, la stringa s sarà effettivamente divisa in tre stringhe s = s1s2s3, dove la fattorizzazione di Lyndon per s1 è già trovata e finalizzata, la stringa s2 è pre-semplice (e conosciamo la lunghezza della stringa semplice in esso), e s3 è completamente intatta. In ogni iterazione l'algoritmo Duval prende il primo carattere della stringa s3 e cerca di aggiungerlo alla stringa s2. Se s2 non è più pre-semplice, la fattorizzazione di Lyndon per una parte di s2 diventa nota e questa parte passa a s1.

Descriviamo l'algoritmo in modo più dettagliato. Il puntatore i punterà sempre all'inizio della stringa s2. Il ciclo esterno verrà eseguito fintanto che i < n. All'interno del ciclo utilizziamo due puntatori aggiuntivi, j che punta all'inizio di s3 e k che punta al carattere corrente che stiamo attualmente confrontando. Vogliamo aggiungere il carattere s[j] alla stringa s2, che richiede un confronto con il carattere s[k].
Possono esserci tre casi diversi:

  1) s[j] = s[k]: se è così, l'aggiunta del simbolo s[j] a s2 non viola la sua pre-semplicità. Quindi incrementiamo semplicemente i puntatori j e k.
  2) s[j] > s [k]: qui la stringa s2 + s[j] diventa semplice. Possiamo incrementare j e riportare k all'inizio di s2, in modo che il carattere successivo possa essere confrontato con l'inizio della parola semplice.
  3) s[j] < s[k]: la stringa s2 + s[j] non è più pre-semplice. Quindi divideremo la stringa pre-semplice s2 nelle sue stringhe semplici e il resto, possibilmente vuoto. La stringa semplice avrà la lunghezza j − k. Nella successiva iterazione si ricomincia con la restante s2.

Ecco una implementazione dell'algoritmo di Duval che restituisce la fattorizzazione di Lyndon di una string str:

(define (duval str)
  (local (len i j k out)
    (setq len (length str))
    (setq i 0)
    (setq out '())
    (while (< i len)
      (setq j (+ i 1))
      (setq k i)
      (while (and (< j len) (<= (str k) (str j)))
        (if (< (str k) (str j))
            (setq k i)
            (++ k)
        )
        (++ j)
      )
      (while (<= i k)
        (push (slice str i (- j k)) out -1)
        (setq i (+ i j (- k)))
      )
    )
    out))

(duval "345210012")
;-> ("345" "2" "1" "0012")

(duval "1821234")
;-> ("182" "1234")

