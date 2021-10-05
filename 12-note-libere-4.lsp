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

dove |X| e |Y| sono le cardinalità dei due liste (cioè il numero di elementi in ogni lista).
L'indice di Sorensen è uguale al doppio del numero di elementi comuni a entrambe le liste (intersezione) diviso per la somma del numero di elementi di ogni lista.

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

Ecco una implementazione dell'algoritmo di Duval che restituisce la fattorizzazione di Lyndon di una stringa str:

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


----------------------
Rimozione dei multipli
----------------------

Dato un numero N e un insieme di numeri s = (s1 s2 ... sn} dove s1 < s2 < ... < sn < N, rimuovere tutti i multipli di (s1 s2 ... sn) dall'intervallo 1...N.
Per esempio, con n = 10 e lst = (2 4 5) si ottiene: (1 3 7 9).

È possibile risolverlo in tempo O(n*log(n)) e memoria extra O(n) usando qualcosa di simile al Crivello di Eratostene.

(define (delete-multiple n lst)
  (local (multipli out)
    (setq out '())
    (setq multipli (array (+ n 1) '(nil)))
    (dolist (el lst)
      (setq t el)
      (while (<= t n)
        (setf (multipli t) true)
        (setq t (+ t el))
      )
    )
    (for (i 1 n)
      (if (not (multipli i))
          (push i out -1)
      )
    )
    out))

(delete-multiple 10 '(2 4 5))
;-> (1 3 7 9)

(delete-multiple 100 '(2 3 4 5 6 7 8 9 10))
;-> (1 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 89 97)

Questa funzione utilizza O(n) di spazio per memorizzare la lista "multipli".

La complessità temporale è O(n*log(n)). Infatti, il ciclo while interno verrà eseguito N/s1 volte per il primo elemento in S, quindi N/s2 per il secondo e così via. Quindi dobbiamo stimare la grandezza di N/s1 + N/s2 + ... + N/sn.

  N/s1 + N/s2 + ... + N/sn =
= N * (1/s1 + 1/s2 + ... + 1/sn) <= N * (1/1 + 1/2 + .. . + 1/n).

L'ultima disuguaglianza è dovuta al fatto che s1 < s2 <... <sn, quindi il caso peggiore è quando assumono valori (1 2 ... n}.

Si può dimostrare che la serie armonica (1/1 + 1/2 + .. . + 1/n) è O(log(n)), quindi l'algoritmo è O(n*(log(n))).


-------------------
Rock Paper Scissors
-------------------

Rock paper scissors (noto anche come "morra cinese" è un gioco a mano giocato tra due persone, in cui ogni giocatore forma simultaneamente una delle tre forme con una mano tesa. Queste forme sono "rock/sasso" (un pugno chiuso), "paper/carta" (una mano piatta) e "scissors/forbici" (un pugno con l'indice e il medio estesi, formando una V). "scissors/forbici" è identico al segno V con due dita (che indica anche "vittoria" o "pace") tranne per il fatto che è puntato orizzontalmente invece di essere tenuto in posizione verticale in aria.

Si tratta di un gioco a somma zero ed ha solo due possibili esiti: un pareggio o una vittoria per un giocatore e una sconfitta per l'altro. Un giocatore che decide di giocare "rock" batterà un altro giocatore che ha scelto "scissors" ("il sasso schiaccia le forbici"), ma perderà contro chi ha giocato con "paper" ("la carta copre il sasso"). La forma "paper" perde contro le "forbici" ("le forbici tagliano la carta"). Se entrambi i giocatori scelgono la stessa forma, la partita è in parità. Il tipo di gioco ha avuto origine in Cina.

Questo gioco viene utilizzato anche come metodo di scelta equo tra due persone, simile al lancio di monete o al lancio di dadi. Tuttavia, a differenza dei metodi di selezione veramente casuali, il gioco Rock-Paper-Scissors può essere giocato con un certo grado di abilità riconoscendo e sfruttando il comportamento non casuale degli avversari.

Esistono diverse strategie di gioco (soprattutto per il computer), ma la casualità assoluta è il metodo migliore nel gioco tra umani (a meno che l'altro giocatore non sia estrememente prevedibile).

Scriviamo una funzione per giocare contro il computer:

(define (rps)
  (local (p1 p2 np1 np2 tot mosse link win)
    ; inizializza il generatore di numeri casuali
    (seed (time-of-day))
    ; mosse possibili
    (setq mosse '("R" "P" "S" "Q"))
    ; lista associativa
    (setq link '(("R" "Rock") ("P" "Paper") ("S" "Scissors")))
    (setq tot 0 np1 0 np2 0)
    (setq win "")
    (println "    ROCK, PAPER, SCISSORS")
    (println "-----------------------------")
    (println " - Type Q to quit the game - ")
    (println)
    ; ciclo continuo
    (while (!= win "end")
      (println "Turn: " (+ 1 tot))
      ; mossa del computer
      (setq p2 (first (select '("R" "P" "S") (rand 3))))
      ; mossa dell'utente
      (print "(R)ock, (P)aper, (S)cissors: ")
      (setq p1 (upper-case (read-line)))
      (while (not (find p1 mosse))
          (print "(R)ock, (P)aper, (S)cissors: ")
          (setq p1 (upper-case (read-line)))
      )
      ; aumenta il conto delle partite
      (++ tot)
      ; controllo vittoria
      (cond ((and (= p1 "R") (= p2 "R")) (setq win ""))
            ((and (= p1 "R") (= p2 "P")) (setq win "p2"))
            ((and (= p1 "R") (= p2 "S")) (setq win "p1"))
            ((and (= p1 "P") (= p2 "R")) (setq win "p1"))
            ((and (= p1 "P") (= p2 "P")) (setq win ""))
            ((and (= p1 "P") (= p2 "S")) (setq win "p2"))
            ((and (= p1 "S") (= p2 "R")) (setq win "p2"))
            ((and (= p1 "S") (= p2 "P")) (setq win "p1"))
            ((and (= p1 "S") (= p2 "S")) (setq win ""))
            ((= p1 "Q") (setq win "end"))
      )
      ; stampa risultato
      (cond ((= win "")
             (println (lookup p1 link) " vs " (lookup p2 link) ": Draw.")
             ( println "User: " np1 " - Computer: " np2))
            ((= win "p1")
             (++ np1)
             (println (lookup p1 link) " vs " (lookup p2 link) ": User wins.")
             (println "User: " np1 " - Computer: " np2))
            ((= win "p2")
             (++ np2)
             (println (lookup p1 link) " vs " (lookup p2 link) ": Computer wins.")
             (println "User: " np1 " - Computer: " np2))
            ((= win "end")
             (println "User: " np1 " - Computer: " np2)
             (println "End of game."))
      )
      (println)
    )))

Proviamo a fare una partita:

(rps)
;->     ROCK, PAPER, SCISSORS
;-> -----------------------------
;->  - Type Q to quit the game -
;->
;-> Turn: 1
;-> (R)ock, (P)aper, (S)cissors: w
;-> (R)ock, (P)aper, (S)cissors: w
;-> (R)ock, (P)aper, (S)cissors: 1
;-> (R)ock, (P)aper, (S)cissors: r
;-> Rock vs Scissors: User wins.
;-> User: 1 - Computer: 0
;->
;-> Turn: 2
;-> (R)ock, (P)aper, (S)cissors: p
;-> Paper vs Rock: User wins.
;-> User: 2 - Computer: 0
;->
;-> Turn: 3
;-> (R)ock, (P)aper, (S)cissors: s
;-> Scissors vs Scissors: Draw.
;-> User: 2 - Computer: 0
;->
;-> Turn: 4
;-> (R)ock, (P)aper, (S)cissors: q
;-> User: 2 - Computer: 0
;-> End of game.

Adesso simuliamo una partita di N turni tra due giocatori che fanno mosse casuali.

Prima di tutto scriviamo una funzione che restituisce il risultato di un turno:

(define (check-turn p1 p2)
  (cond ((and (= p1 "R") (= p2 "R")) 0)
        ((and (= p1 "R") (= p2 "P")) 2)
        ((and (= p1 "R") (= p2 "S")) 1)
        ((and (= p1 "P") (= p2 "R")) 1)
        ((and (= p1 "P") (= p2 "P")) 0)
        ((and (= p1 "P") (= p2 "S")) 2)
        ((and (= p1 "S") (= p2 "R")) 2)
        ((and (= p1 "S") (= p2 "P")) 1)
        ((and (= p1 "S") (= p2 "S")) 0)))

(check-turn "R" "R")
;-> 0
(check-turn "P" "R")
;-> 1
(check-turn "P" "S")
;-> 2

Poi scriviamo una funzione che genera una lista con un numero predefinito di mosse casuali:

(define (make-moves num)
  (select '("R" "P" "S") (rand 3 num)))

(make-moves 10)
;-> ("R" "S" "R" "S" "S" "S" "S" "P" "P" "R")

Infine scriviamo una funzione che gioca una partita con N turni:

(define (play-rps num)
  (local (lst1 lst2 turns result)
    (seed (time-of-day))
    (setq lst1 (select '("R" "P" "S") (rand 3 num)))
    (setq lst2 (select '("R" "P" "S") (rand 3 num)))
    (setq turns (map check-turn lst1 lst2))
    (setq result (count '(0 1 2) turns))
    (println "Draw: " (result 0))
    (println "Player1: " (result 1))
    (println "Player2: " (result 2))
    result))

Per esempio:

(setq lst1 '("P" "R" "S" "S" "P"))
(setq lst2 '("S" "R" "S" "R" "S"))

(play-rps 5)
;-> Draw: 2
;-> Player1: 0
;-> Player2: 3
;-> (2 0 3)

Simuliamo un paio di partite con 1 milione di turni:

(play-rps 1e6)
;-> Draw: 333509
;-> Player1: 333857
;-> Player2: 332634
;-> (333509 333857 332634)
(play-rps 1e6)
;-> Draw: 333756
;-> Player1: 332973
;-> Player2: 333271
;-> (333756 332973 333271)


----------------
TODO application
----------------

Una semplice applicazione TODO.

;-------------------------------------------------------------
;
; TODO
;
(define (todo file)
  (local (todo-filename todo-file todo-lines items funcs nitems)
    (println (format "\n%s\n%s\n%s\n" "============" "TODO Manager" "============"))
    ; voci del menu
    (setq items '("Elenco note" "Nuova nota" "Modifica nota" "Elimina nota" "Cerca... " "Ordina note" "Salva" "Esce"))
    ; funzioni del menu
    (setq funcs (list show-note new-note edit-note delete-note search-note sort-note save-note quit))
    ; numero di voci/funzioni del menu
    (setq nitems (length items))
    ; se il file non esiste, allora lo crea
    (if (not (file? file)) (close (open file "w")))
    ; nome del file di testo
    (setq todo-filename file)
    ; legge il file delle note
    ; (handle del file)
    (setq todo-file (read-file todo-filename))
    ; crea una lista con le linee del file
    (setq todo-lines (parse todo-file "\r\n"))
    ; elimina gli spazi (prima e dopo ogni linea)
    (setq todo-lines (map trim todo-lines))
    ; elimina le linee vuote
    (setq todo-lines (filter (fn(x) (not (empty? x))) todo-lines))
    ; mostra il menu
    (show-menu)))
;
; SHOW-MENU
;
(define (show-menu)
  (local (val num))
    ; visualizza le voci del menu
    (setq val nil)
    (println "MENU:")
    ; usa format %d (todo con più di 9 elementi)
    (dolist (el items) (println " " (+ $idx 1) ". " el))
    ; scelta della funzione...
    (while (not val)
      (print "Seleziona: ")
      (setq num (int (read-line) 0 10))
      (if (or (< num 1) (> num nitems))
          (println "Numero inesistente:" num)
          (setq val true)
      )
    )
    (println "")
    ; chiama la funzione selezionata
    ((funcs (- num 1))))
;
; RETURN-MENU
;
(define (return-menu)
  (println)
  (print "--- Premere Invio per tornare al menu ---")
  (read-line)
  (println "")
  (show-menu))
;
; SHOW-NOTE
;
(define (show-note)
  ; stampa tutte le linee
  (println "Elenco note:")
  (dolist (linea todo-lines)
    (println " - " linea)
  )
  (return-menu))
;
; NEW-NOTE
;
(define (new-note)
  (println "Nuova nota:")
  (print "> ")
  ; legge e inserisce la nuova nota nella lista
  (push (read-line) todo-lines -1)
  (println "Nota inserita.")
  (return-menu))
;
; EDIT-NOTE
;
(define (edit-note)
(catch
  (local (val num)
    (println "Modifica nota:")
    ; stampa tutte le note
    (dolist (linea todo-lines)
      (println (+ $idx 1) ": " linea)
    )
    ; input numero nota da eliminare
    (setq val nil)
    (while (not val)
      (print "Numero da modificare (-1 menu): ")
      (setq num (int (read-line) 0 10))
      ; esce dalla funzione senza nessuna modifica
      (cond ((= num -1) (throw (return-menu)))
            ((or (< num 1) (> num (length todo-lines)))
             (println "Numero errato:" num))
            (true
             (setq val true))
      )
    )
    ; stampa la nota selezionata
    ;(println "Nota in modifica:")
    ;(print (format "\n%s\r" (todo-lines (- num 1))))
    (println "Nota: " (todo-lines (- num 1)))
    (print "> ")
    ; legge e modifica la nota nella lista
    (replace (todo-lines (- num 1)) todo-lines (read-line))
    (println "Nota modificata.")
    (return-menu))))
;
; DELETE-NOTE
;
(define (delete-note)
(catch
  (local (val num)
    (println "Elimina nota:")
    ; stampa tutte le note
    (dolist (linea todo-lines)
      (println (+ $idx 1) ": " linea)
    )
    ; input numero nota da eliminare
    (setq val nil)
    (while (not val)
      (print "Numero da eliminare (-1 menu): ")
      (setq num (int (read-line) 0 10))
      ; esce dalla funzione senza nessuna modifica
      (cond ((= num -1) (throw (return-menu)))
            ((or (< num 1) (> num (length todo-lines)))
             (println "Numero errato:" num))
            (true
             (setq val true))
      )
    )
    ; elimina la nota dalla lista
    (println "Nota eliminata:")
    (println (pop todo-lines (- num 1)))
    (return-menu))))
;
; SEARCH-NOTE
;
(define (search-note)
  (local (str)
  (println "Cerca..."))
  (print "Testo da cercare: ")
  (setq str (read-line))
  (dolist (linea todo-lines)
    (if (find str linea) (println linea))
  )
  (return-menu))
;
; SORT-NOTE
;
(define (sort-note)
  (sort todo-lines)
  (println "Note ordinate.")
  (return-menu))
;
; SAVE-NOTE
;
(define (save-note)
  (local (text)
    ; crea testo con le linee
    (setq text "")
    (dolist (linee todo-lines)
      (extend text linee "\r\n")
    )
    ; salva il file
    (write-file todo-filename text)
    (println "Note salvate: " todo-filename)
    (return-menu)))
;
; QUIT
;
(define (quit)
  (local (text)
    ; crea testo con le linee
    (setq text "")
    (dolist (linee todo-lines)
      (extend text linee "\r\n")
    )
    ; salva il file
    (write-file todo-filename text)
    (println "Fine")))
;-------------------------------------------------------------
;eof

Vediamo come funziona:

(todo "todo-test.txt")
;-> ============
;-> TODO Manager
;-> ============
;->
;-> MENU:
;->  1. Elenco note
;->  2. Nuova nota
;->  3. Modifica nota
;->  4. Elimina nota
;->  5. Cerca...
;->  6. Ordina note
;->  7. Salva
;->  8. Esce
;-> Seleziona:

Per usare il programma possiamo salvarlo in un file (es. todo.lsp) e poi caricarlo con (load "todo.lsp").


---------------
Quine e Narciso
---------------

Un programma Quine non accetta input, ma produce in output una copia del proprio codice sorgente. Al contrario, Un "narcisista" (o programma Narciso) prende una stringa in input e produce in output "1" (true) se quella stringa corrisponde al proprio codice sorgente, oppure "0" (nil) se non corrisponde.

Un esempio di questo ultimo tipo di programma è il seguente:

(define (narciso) (and (= (slice (read-line) 18) (slice (string narciso) 11)) (= (slice (current-line) 0 18) "(define (narciso) ")))
;-> (lambda () (and (= (slice (read-line) 18) (slice (string narciso) 11)) (= (slice current-line 0 18) "(define (narciso) ")))

(narciso)
;(define (narciso) (and (= (slice (read-line) 18) (slice (string narciso) 11)) (= (slice (current-line) 0 18) "(define (narciso) ")))
;-> true

Come funziona?
La prima condizione: (= (slice (read-line) 18) (slice (string narciso) 11)) verifica che la stringa inserita corrisponda al corpo della funzione nella rappresentazione interna.
La seconda condizione: (= (slice (current-line) 0 18) "(define (narciso) ") verifica che i primi 18 caratteri della stringa inserita siano uguali a "(define (narciso) " (poichè nella rappresentazione interna la testa della funzione vale "(lambda () ").

In maniera analoga possiamo scrivere un programma Quine:

(define (quine) (print "(define (quine) ") (println (slice (string quine) 11)))
(quine)
;-> (define (quine) (print "(define (quine) ") (println (slice (string quine) 11)))


-----------------
Test di primalità
-----------------

In questo paragrafo vengono implementati gli algoritmi tratti dal libro "Primality Testing in Polynomial Time" di Martin Dietzfelbinger:

  - Algoritmo "Trial Division"
  - Algoritmo "Lehmann's Primality Test"
  - Algoritmo "Fast Modular Exponentiation"
  - Algoritmo "Perfect Power Test"
  - Algoritmo "Euclidean Algorithm"
  - Algoritmo "Extended Euclidean Algorithm"
  - Algoritmo "The Sieve of Eratosthenes"
  - Algoritmo "Fermat Test"

Funzioni ausiliarie
-------------------

"primo?" verifica se un numero è primo:

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

"sign" assegna -1 oppure 0 oppure +1 in base al segno del numero:

(define (sign n)
  (cond ((> n 0) 1)
        ((< n 0) -1)
        (true 0)))

(sign -10)
;-> -1
(sign 3)
;-> 1
(sign 0)
;-> 0

"rand-int" genera un numero casuale intero x tale che 1 <= x <= n
(non funziona con i biginteger):

(define (rand-int n) (+ 1 (rand n)))

"rand-range" genera un numero casuale intero x tale che a <= n <= b:

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

"powmod" calcola l'esponenziazione modulare veloce (b^e mod m):

(define (powmod b e m)
  (local (r)
    (cond ((= m 1) (setq r 0))
          (true
            (setq r 1L)
            (setq b (% b m))
            (while (> e 0)
              (if (= (% e 2) 1) (setq r (% (* r b) m)))
              (setq e (/ e 2))
              (setq b (% (* b b) m))
            )
          )
    )
    r))

(powmod 1024 313 42)
;-> 16L

"ipow" calcola la potenza di due numeri interi:

(define (ipow x n)
  (local (pot out)
    (if (zero? n)
        (setq out 1L)
        (begin
          (setq pot (ipow x (/ n 2)))
          (if (odd? n) (setq out (* x pot pot))
                       (setq out (* pot pot)))
        )
    )
    out))

(ipow -2 15)
;-> -32768
(ipow 11L 12L)
;-> 3138428376721L

"psetq" macro che permette l'assegnazione multipla:

(define-macro (psetq)
  (let ((_var '()) (_ex '()))
    (for (i 0 (- (length (args 1)) 1))
      (setq _ex (expand (args 1 i) (args 0 0)))
      (for (j 1 (- (length (args 0)) 1))
        (setq _ex (expand _ex (args 0 j)))
      )
      (push _ex _var -1)
    )
    (dolist (el _var)
      (set (args 0 $idx) (eval el))
    )))

(setq x 2 y 3)
(psetq (x y) ((+ 1 y) (+ 1 x)))
(list x y)
;-> (4 3)
---------------------------------------------------------------------

Algoritmi
---------

Algoritmo "Trial Division"
Input: integer n >= 2

(define (trial-div n)
  (catch
    (let (i 2L)
      (while (<= (* i i) n)
        (if (= zero? (% n i)) (throw nil))
        (++ i)
      )
      true)))

(trial-div 113)
;-> true

(= (map primo? (sequence 2 10000)) (map trial-div (sequence 2 10000)))
;-> true
---------------------------------------------------------------------

Algoritmo "Lehmann's Primality Test"
Input: odd integer n >= 3
       integer p >= 2

(define (lehmann n p)
  (catch
    (local (a b c)
      (if (= p nil) (setq p 20))
      (setq b (array (+ p 1) '(0)))
      (for (i 1 p)
        (setq a (rand-int (- n 1)))
        (setq c (powmod a (/ (- n 1) 2) n))
        (if (and (!= c 1) (!= c (- n 1)))
            (throw nil)
            (setq (b i) c)
        )
      )
      (for (i 1 p)
            (if (and (!= (b i) 1) (!= (b i) (- n 1)))
                (throw nil)
            )
      )
      true)))

(seed (time-of-day))

(lehmann 113)
;-> true

(= (map primo? (sequence 3 10001 2)) (map lehmann (sequence 3 10001 2)))
;-> true
---------------------------------------------------------------------

Algoritmo "Fast Modular Exponentiation"
Input: integer a, n e m >= 1

(define (fastmodexp a n m)
  (local (u s c)
    (setq u n)
    (setq s (% a m))
    (setq c 1L)
    (while (>= u 1)
      (if (odd? u) (setq c (% (* c s) m)))
      (setq s (* s (% s m)))
      (setq u (/ u 2))
    )
    c))

(fastmodexp 1024 313 42)
;-> 16L
(fastmodexp 1024 1024 77)
;-> 23L
(powmod 1024 1024 77)
;-> 23L
---------------------------------------------------------------------

Algoritmo "Perfect Power Test"
Input: integer n >= 2

(define (perfect-power-test n)
  (catch
    (local (a b c m)
      (setq b 2L)
      (while (<= (ipow 2L b) n)
        (setq a 1L)
        (setq c n)
        (while (>= (- c a) 2)
          (setq m (/ (+ a c) 2))
          ; "min" don't work with biginteger
          ;(setq p (min (ipow m b) (+ n 1)))
          (if (< (ipow m b) (+ n 1))
              (setq p (ipow m b))
              (setq p (+ n 1))
          )
          (if (= p n) (throw (list m b)))
          (if (< p n)
              (setq a m)
              (setq c m)
          )
        )
        (++ b)
      )
      nil)))

(perfect-power-test 2047)
;-> nil
(perfect-power-test 1024)
;-> (32L 2L)
(ipow 1194052296529L 2L)
;-> 1425760886846178945447841L
(perfect-power-test 1425760886846178945447841L)
;-> (1194052296529L 2L)
---------------------------------------------------------------------

Algoritmo "Euclidean Algorithm"
Input: integer n m

(define (euclidean n m)
  (local (a b ta tb)
    (setq n (abs n))
    (setq m (abs m))
    (if (>= n m)
        (setq a n b m)
        (setq a m b n)
    )
    (while (> b 0)
      ;(setq ta a)
      ;(setq tb b)
      ;(setq a tb)
      ;(setq b (% ta tb))
      (psetq (a b) (b (% a b)))
    )
    a))

(euclidean 4 31)
;-> 1
(euclidean 400 24)
;-> 8
(euclidean 400L 24L)
;-> 8L
---------------------------------------------------------------------

Algoritmo "Extended Euclidean Algorithm"
Input: integer n m

(define (extended-euclidean n m)
  (local (a b xa ya xb yb q)
    (if (> (abs n) (abs m))
        (begin (setq a (abs n))
               (setq b (abs m))
               (setq xa (sign n))
               (setq ya 0)
               (setq xb 0)
               (setq yb (sign m)))
        (begin (setq a (abs m))
               (setq b (abs n))
               (setq xa 0)
               (setq ya (sign m))
               (setq xb (sign n))
               (setq yb 0))
    )
    (while (> b 0)
      (setq q (/ a b))
      (psetq (a b) (b (- a (* q b))))
      (psetq (xa ya xb yb) (xb yb (- xa (* q xb)) (- ya (* q yb))))
    )
    (list a xa ya)
  )
)

(extended-euclidean 120 30)
;-> (30 0 1)
(extended-euclidean 120 23)
;-> (1 -9 47)
---------------------------------------------------------------------

Algoritmo "The Sieve of Eratosthenes"
Input: integer n >= 2

(define (eratosthenes n)
  (local (m i j)
    (setq m (array (+ n 1) '(0)))
    (setq j 2)
    (while (<= (* j j) n)
      (if (= (m j) 0)
        (begin (setq i (* j j))
               (while (<= i n)
                 (if (= (m i) 0) (setq (m i) j))
                 (setq i (+ i j))
               ))
      )
      (++ j)
    )
    (slice m 2 (- n 1))))

(eratosthenes 10)
;-> (0 0 2 0 2 0 2 3 2)
idx  2 3 4 5 6 7 8 9 10

Nota: i numeri primi sono gli indici per cui il valore vale 0 (il vettore parte dall'indice 2).
---------------------------------------------------------------------

Algoritmo "Fermat Test"
Input: odd integer n >= 3

(define (fermat-test n)
  (let (a (rand-range 2 (- n 2)))
    (if (!= (powmod a (- n 1) n) 1)
        nil
        true)))

(fermat-test 91)
;-> nil
(fermat-test 91)
;-> true ; output errato
(fermat-test 91)
;-> nil
(fermat-test 91)
;-> nil
(fermat-test 91)
;-> nil
---------------------------------------------------------------------

Algoritmo "Iterated Fermat Test"
Input: odd integer n >= 3
           integer p >= 1

(define (iterated-fermat-test n p)
  (catch
    (local (a)
      (if (= p nil) (setq p 20))
      (dotimes (x p)
        (setq a (rand-range 2 (- n 2)))
        (if (!= (powmod a (- n 1) n) 1)
            (throw nil))
      )
      true)))

(for (i 1 100000) (if (iterated-fermat-test 91 10) (println "error")))
;-> error
;-> error
;-> nil
(for (i 1 100000) (if (iterated-fermat-test 91 30) (println "error")))
;-> nil
---------------------------------------------------------------------

-----------------------------------
Passeggiata casuale lungo una linea
-----------------------------------

Supponiamo di avere un agente casuale che si muove lungo una linea (asse x) partendo dalla posizione 0. Ad ogni passo può spostarsi di un qualunque valore contenuto in una lista (es. (-1 +1)). Data una lista di posizioni, determinare (con una simulazione) dopo quanti passi l'agente si trova in quelle posizioni (positive o negative).
Per esempio,

Lista dei valori di un passo (testa o croce):
(setq passi '(-1 +1))

Lista delle posizioni:
(setq posizioni '(1000 2000 3000 4000 5000))

Scriviamo la funzione:

(define (random-walk steps positions)
  (local (x numsteps idx passo freq)
    ; inizializza il generatore di numeri casuali
    (seed (time-of-day))
    ; numero massimo dei passi
    (setq max-walks 1e8)
    ; posizione iniziale dell'agente
    (setq x 0)
    ; numero elementi della lista passi
    (setq numsteps (length steps))
    ; lista delle frequenze dei passi
    (setq freq (dup 0 numsteps))
    ; stampa intestazione
    (println "Passi        Posizione")
    ; ciclo fino a che la lista posizioni non è vuota
    ; oppure fino al nuimero massimo dei passi
    (for (i 1 max-walks 1 (empty? positions))
      ; seleziona indice del passo casuale
      (setq idx (rand numsteps))
      ; aggiorna la lista delle frequenze dei passi
      (++ (freq idx))
      ; seleziona valore del passo casuale
      (setq passo (steps idx))
      ; aggiorna posizione dell'agente
      (setq x (+ x passo))
      ; se siamo arrivati ad una posizione
      ; che si trova nella lista delle posizioni...
      ; (controlla anche il valore negativo)
      (if (find (abs x) positions)
          (begin
            ; stampa i risultati correnti
            (println (format "%-12d %-+10d" i x))
            ; elimina la posizione trovata dalla lista delle posizioni
            (pop positions (find (abs x) positions))
            ; stampa la percentuale delle frequenze dei passi
            (println (map (fn(x) (div x i)) freq))
          )))))

Nota: Il programma restituisce "true" se sono state trovate tutte le posizioni.

Facciamo alcune prove:

(setq passi '(-1 +1))
(setq posizioni '(1000 2000 3000 4000 5000))
(random-walk passi posizioni)
;-> Passi        Posizione
;-> 1960406      -1000
;-> (0.5002550492091944 0.4997449507908056)
;-> 5578618      +2000
;-> (0.4998207441341207 0.5001792558658793)
;-> 10919650     +3000
;-> (0.4998626329598476 0.5001373670401524)
;-> 21807322     +4000
;-> (0.4999082876842925 0.5000917123157076)
;-> 25400818     +5000
;-> (0.4999015779728039 0.5000984220271961)
;-> true

(setq passi '(-1 +1 -2 +2))
(setq posizioni '(3000 6000 9000))
(random-walk passi posizioni)
;-> Passi        Posizione
;-> 10998991     -3000
;-> (0.2497767295200078 0.2501136695175039 0.2502072235535059 0.2499023774089823)
;-> 14960430     -6000
;-> (0.2498848629350894 0.2501099901540263 0.2501591197579214 0.2498460271529629)
;-> 52664246     +9000
;-> (0.2498900487438859 0.2500522840486504 0.2500266689472778 0.2500309982601859)
;-> true

(setq passi '(-1 +1 -2 +2))
(setq posizioni '(100 200 500 1000 3000 5000 8000 10000 15000))
(random-walk passi posizioni)
;-> Passi        Posizione
;-> 3691         -100
;-> (0.2525060959089678 0.260633974532647 0.2522351666215118 0.2346247629368735)
;-> 5309         -200
;-> (0.2535317385571671 0.2569222075720475 0.2550386136748917 0.2345074401958938)
;-> 21737        -500
;-> (0.250126512398215 0.2463541427059852 0.2565671435800708 0.246952201315729)
;-> 382613       +1000
;-> (0.2497771900066124 0.2502946841848029 0.2494400347087004 0.2504880910998842)
;-> 10389970     -3000
;-> (0.2501266124926251 0.2501273824659744 0.2499453800155342 0.2498006250258663)
;-> 52122407     +5000
;-> (0.2501090749703865 0.2500241594752138 0.2498881718950547 0.249978593659345)
;-> 53204355     +8000
;-> (0.2501033608996858 0.2500143832210728 0.2498812926122307 0.2500009632670108)
;-> 59041077     +10000
;-> (0.250097910646176 0.2500267398577434 0.2498775386499132 0.2499978108461673)
;-> 65311093     +15000
;-> (0.2500656052410576 0.2500676569598981 0.2498764643243683 0.249990273474676)
;-> true


--------------------------------------
Serie di teste e croci (valore atteso)
--------------------------------------

In media (valore atteso), quante volte dobbiamo lanciare una moneta per ottenere una serie consecutiva di N risultati uguali (N teste consecutive oppure N croci consecutive)?

L'aspettativa matematica è un concetto importante nella teoria della probabilità. Matematicamente, per una variabile discreta X con funzione di probabilità P (X), il "valore atteso" E[X] è dato da Σ(xi * P(xi)) la somma ricorre su tutti i valori distinti xi che la variabile può assumere. Ad esempio, per un esperimento di lancio di dadi, l'insieme di risultati discreti è (1 2 3 4 5 6) e ciascuno di questo risultato ha la stessa probabilità 1/6. Quindi, il valore atteso di questo esperimento sarà 1/6 * (1 + 2 + 3 + 4 + 5 + 6) = 21/6 = 3.5. Per una variabile continua X con funzione di densità di probabilità P(x), il valore atteso E[X] è dato da ∫x*P(x)dx.

È importante capire che "valore atteso" non è uguale a "valore più probabile" - piuttosto, non è nemmeno necessario che sia uno dei valori probabili. Ad esempio, in un esperimento di lancio di dadi, il valore atteso, vale a dire 3.5, non è affatto uno dei possibili risultati.

La regola della "linearità dell'aspettativa" dice che E[x1+x2] = E[x1] + E[x2].

Prima di applicare la teoria al nostro caso, vediamo un problema più semplice: qual'è il numero previsto di lanci di monete per ottenere due teste consecutive?

Sia x il numero atteso di lanci di monete. L'analisi del caso procede come segue:
a. Se il primo lancio è croce, allora abbiamo sprecato un lancio. La probabilità di questo evento è 1/2 e il numero totale di lanci richiesti è x + 1
b. Se il primo lancio è testa e il secondo è croce, allora abbiamo sprecato due lanci. La probabilità di questo evento è 1/4 e il numero totale di lanci richiesti è x + 2
c. Se il primo lancio è testa e anche il secondo è testa, allora abbiamo finito. La probabilità di questo evento è 1/4 e il numero totale di lanci richiesti è 2.

Sommando tutti i termini, l'equazione che otteniamo è:

x = (1/2)*(x+1) + (1/4)*(x+2) + (1/4)*2 = 6

Pertanto, il numero previsto di lanci di monete (valore atteso) per ottenere due teste consecutive è 6.

Generalizzando: qual'è il numero previsto di lanci di monete per ottenere N teste consecutive, dato N?

Sia x il numero previsto di lanci di monete. Sulla base degli esercizi precedenti, possiamo concludere l'intera analisi del caso in due parti fondamentali:

a) Se otteniamo la prima, la seconda, la terza, ..., l'ennesima croce come prima croce nell'esperimento, allora dobbiamo ricominciare tutto da capo.
b) Altrimenti abbiamo finito.

Per il 1° lancio come croce, la parte dell'equazione è (1/2)*(x + 1)
Per il 2° lancio come croce, la parte dell'equazione è (1/4)*(x + 2)
...
Per il k-esimo lancio come croce, la parte dell'equazione è (1/(2^k))*(x + k)
...
Per l'ennesima croce, la parte dell'equazione è (1/(2^N))*(x + N)

La parte dell'equazione che corrisponde al caso (b) è (1/(2^N))*(N)

Sommando i termini:

x = (1/2)*(x+1) + (1/4)*(x+2) + ... + (1/(2^k))*(x+k) + .. + (1/(2^N))*(x+N) + (1/(2^N))*(N)

Risolvendo l'equazione si ottiene:

x = 2^(N+1) - 2 = 2*(2^n -1)

Poichè il nostro problema originale considera anche la probabilità di ottenere N croci consecutive (oltre a N teste consecutive), il valore atteso vale la metà del risultato precedente:

x = (2^n -1)

(define (atteso num) (- (pow 2 num) 1))

Scriviamo una funzione che simula questo processo:

(define (serie num iter)
  (local (conta num-lanci tot-lanci prec lancio found delta)
    ;numero totale dei lanci
    (setq tot-lanci 0)
    ; scostamento massimo: numero massimo di lanci
    ; per ottenere 5 valori consecutivi uguali
    (setq delta 0)
    (for (i 1 iter)
      ; azzera la lista contatore
      (setq conta '(0 0))
      ; primo lancio (0=croce, 1=testa)
      (setq prec (rand 2))
      (setq numlanci 1)
      ; mostra lancio
      ;(print prec)
      ; aggiorna la lista contatore
      (++ (conta prec))
      (setq found nil)
      ; cerca la serie consecutiva di num teste o croci
      (until found
        ; lancio moneta
        (setq lancio (rand 2))
        ; mostra lancio
        ;(print lancio)
        (++ numlanci)
        ; se il lancio attuale è uguale al precedente
        (cond ((= lancio prec)
               ; aggiorna la lista contatore
               (++ (conta prec)))
              ; altrimenti
              (true ; il lancio attuale è diverso dal precedente
               ; azzera il contatore
               (setq conta '(0 0))
               ; aggiorna il valore del lancio precedente
               (setq prec lancio)
               ; aggiorna la lista contatore
               (++ (conta prec)))
        )
        ; se abbiamo raggiunto num ripetizioni
        ; consecutive di croci o teste
        ; N teste oppure N croci
        (if (or (= (conta 0) num) (= (conta 1) num))
        ; N teste
        ;(if (= (conta 0) num)
            (begin
            (setq found true)
            ; aggiorna il numero totale dei lanci
            (setq tot-lanci (+ tot-lanci numlanci))
            ; aggiorna scostamento massimo
            (setq delta (max delta numlanci))
            ; mostra risultati intermedi
            ;(println)
            ;(println conta { } numlanci)
            ;(read-line)
            )
        )
      )
    )
    ; stampa lo scostamento massimo, cioè il massimo numero di lanci
    ; che è sato necessario per ottenere N eventi consecutivi uguali
    (println "Max lanci: " delta)
    (div tot-lanci iter)
  )
)

Proviamo la funzione di simulazione:

(serie 5 100000)
;-> Max lanci: 305
;-> 31.04894

Vediamo il valore matematico:
(atteso 5)
;-> 31

(serie 8 100000)
;-> Max lanci: 3354
;-> 254.9056
(atteso 8)
;-> 255

La simulazione conferma il risultato matematico.


--------------------------------------
Ricerca con caratteri jolly (wildcard)
--------------------------------------

Dato un testo e un modello (pattern) di caratteri jolly (wildcard), implementare l'algoritmo di corrispondenza del modello di caratteri jolly che rileva se il modello di caratteri jolly è abbinato al testo. La corrispondenza dovrebbe coprire l'intero testo (non il testo parziale).
Il motivo jolly può includere i caratteri "?" e "*":

"?" - corrisponde a qualsiasi singolo carattere

"*": Corrisponde a qualsiasi sequenza di caratteri (inclusa la sequenza vuota)

Per esempio,

Testo = "abbaino",
Modello = "*ba*ino" , output : true
Modello = "ab*?"    , output : true
Modello = "ba*a?"   , output : false
Modello = "abba?no" , output : true
Modello = "abba?o"  , output : false

Ogni occorrenza del carattere "?" nel modello di caratteri jolly può essere sostituito con qualsiasi altro carattere e ogni occorrenza di "*" con una sequenza di caratteri tale che il modello di caratteri jolly diventa identico alla stringa di input dopo la sostituzione.

Consideriamo qualsiasi carattere nel modello:

Caso 1: il carattere è "*"
Qui sorgono due sottocasi:
1) Possiamo ignorare il carattere "*" e passare al carattere successivo nel modello.
2) Il carattere "*" corrisponde a uno o più caratteri nel testo. Qui ci sposteremo al carattere successivo nel Testo.

Caso 2: il carattere è "?"
Possiamo ignorare il carattere corrente nel testo e passare al carattere successivo nel modello e nel Testo.

Caso 3: il carattere non è un carattere jolly
Se il carattere corrente in Testo corrisponde al carattere corrente in modello, ci spostiamo al carattere successivo in modello e in Testo.
Se non corrispondono, il motivo jolly e il testo non corrispondono.

Possiamo usare la programmazione dinamica per risolvere questo problema.

Sia DP[i][j] true se i primi i caratteri nel Testo dato corrispondono ai primi j caratteri del modello.

Inizializzazione della matrice DP:

; sia il Testo che il modello sono nil
DP[0][0] = true;

; il modello è nil
DP[i][0] = nil

; il Testo è nil
DP[0][j] = DP[0][j - 1] se modello[j – 1] è '*'

Relazione DP:

Se i caratteri correnti corrispondono, il risultato è lo stesso di risultato per le lunghezze meno uno.
I caratteri corrispondono in due casi:
a) Se il carattere del modello è "?" quindi corrisponde con qualsiasi carattere di testo.
b) Se i caratteri correnti nel modello e nel Testo corrispondono
if (modello[j – 1] == "?") || (modello[j – 1] == text[i - 1])
   DP[i][j] = DP[i-1][j-1]

Se incontriamo "*", sono possibili due scelte:
a) Ignoriamo il carattere "*" e passiamo al successivo
    carattere nel modello, ad esempio "*" indica una sequenza vuota.
b) Il carattere '*' corrisponde all'i-esimo carattere in ingresso
else if (modello[j – 1] == "*")
        DP[i][j] = DP[i][j-1] || DP[i-1][j]
else if (modello[j – 1] != text[i - 1])
        DP[i][j] = nil

Adesso possiamo scrivere la funzione:

(define (match? str modello)
  (local (n m dp)
    (setq n (length str))
    (setq m (length modello))
    ; matrice di lookup
    (setq dp (array (+ n 1) (+ m 1) '(nil)))
    ; un modello vuoto si abbina con la stringa vuota
    (setf (dp 0 0) true)
    ; solo "*" si abbina con la stringa vuota
    (for (j 1 m)
      (if (= (modello (- j 1)) "*")
          (setf (dp 0 j) (dp 0 (- j 1)))
      )
    )
    ; riempie la matrice in modo bottom-up
    (for (i 1 n)
      (for (j 1 m)
        (cond ((= (modello (- j 1)) "*")
               ; Due casi se vediamo un '*':
               ; a) Ignoriamo il carattere '*' 'e ci muoviamo
               ; al carattere successivo nel pattern,
               ; ad esempio, "*" indica una sequenza vuota
               ; b) Il carattere "*" si abbina con l'i-esimo
               ; carattere in input
               (setf (dp i j) (or (dp i (- j 1)) (dp (- i 1) j))))
              ((or (= (modello (- j 1)) "?") (= (modello (- j 1)) (str (- i 1))))
               ; I caratteri correnti sono considerati come
               ; abbinati in due casi:
               ; (a) il carattere corrente del pattern è "?"
               ; (b) i caratteri corrispondono effettivamente
               (setf (dp i j) (dp (- i 1) (- j 1))))
              (true
               ; i caratteri non si abbinano
               (setf (dp i j) nil))
        )
      )
    )
    (dp n m)))

Facciamo alcune prove:

(match? "baaabab" "*b???b*")
;-> true
(match? "abbaino" "*ba*ino")
;-> true
(match? "abbaino" "ab*?"   )
;-> true
(match? "abbaino" "ba*a?"  )
;-> nil
(match? "abbaino" "abba?no")
;-> true
(match? "abbaino" "abba?o" )
;-> nil


-------------------------
Funzioni logiche booleane
-------------------------

newLISP mette a disposizione tre funzioni "and", "or" e "not" per l'algebra booleana (AND, OR e NOT). Con queste funzioni possiamo creare tutte le altre funzioni necessarie (es. NAND, XOR, NOR, ecc.). Per esempio:

Funzione NAND
(define (nand a b) (not (and a b)))

Funzione NOR
(define (nor a b) (not (or a b)))

Funzione XOR
(define (xor a b) (if (nand a b) (or a b) nil))

Funzione XNOR
(define (xnor a b) (not (xor a b)))

Per ragioni di efficienza abbiamo utilizzato la funzione "nand" per definire "xor" e la funzione "xor" per definire "xnor", cioè abbiamo usato questo insieme di connettivi logici (not and or nand xor) per definire le funzioni che producono tutte le possibili tabelle di verità con due valori di ingresso (a b).

Completezza funzionale
----------------------
In logica, un insieme funzionalmente completo di connettivi logici o operatori booleani è quello che può essere utilizzato per esprimere tutte le possibili tabelle di verità combinando i membri dell'insieme in un'espressione booleana. Un noto insieme completo di connettivi è (AND NOT), oppure (OR NOT). Anche ciascuno degli insiemi singleton (NAND) e (NOR) è funzionalmente completo.
Questo vuol dire che l'insieme di operatori logici scelto è sufficiente per "esprimere tutte le possibili tabelle di verità". L'insieme di tutte le tabelle di verità indica tutti i possibili insiemi di 4 valori booleani che possono essere il risultato di un'operazione tra 2 valori booleani. Poiché ci sono 2 possibili valori per un booleano, ci sono 2^4 o 16 possibili tabelle di verità.

A B | 0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15
----+------------------------------------------------
T T | T  T  T  T  T  T  T  T  F  F  F  F  F  F  F  F
T F | T  T  T  T  F  F  F  F  T  T  T  T  F  F  F  F
F T | T  T  F  F  T  T  F  F  T  T  F  F  T  T  F  F
F F | T  F  T  F  T  F  T  F  T  F  T  F  T  F  T  F

Prendendo come esempio l'insieme (OR NOT), ecco una tabella di verità per i numeri (0-15) con la combinazione di OR e NOT che la producono e una descrizione.

Tabella |  Operazione                         | Descrizione
--------+----------------------------------+-------------
  0     | A or not A                          | TRUE
  1     | A or B                              | OR
  2     | A or not B                          | B IMPLICA A
  3     | A                                   | A
  4     | not A or B                          | A IMPLICA B
  5     | B                                   | B
  6     | not(not A or not B) or not(A or B)  | XNOR (equals)
  7     | not(not A or not B)                 | AND
  8     | not A or not B                      | NAND
  9     | not(A or not B) or not(not A or B)  | XOR
 10     | not B                               | NOT B
 11     | not(not A or B)                     | NOT A IMPLICA B
 12     | not A                               | NOT A
 13     | not(A or not B)                     | NOT B IMPLICA A
 14     | not(A or B)                         | NOR
 15     | not(A or not A)                     | FALSE

Nota: in elettronica si preferisce utilizzare la porta NAND perchè fa due cose (la porta AND solo una). Una porta NAND è una porta AND seguita da una porta NOT. Quell'inversione "extra" (in realtà è gratuita nella maggior parte delle implementazioni di circuiti) la rende molto più versatile di una semplice AND. Possiamo creare tutte le altre funzioni logiche usando solo la porta NAND grazie al Teorema di DeMorgan, quindi in pratica è tutto ciò di cui abbiamo bisogno.


----------------
Tavole di verità
----------------

Scrivere una funzione che prende un'espressione logica in ingresso e restituisce la tavola di verità dell'espressione. Gli operatori logici consentiti sono "and", "or" e "not".

Utilizziamo la funzione "xlate" che converte una espressione infissa in una espressione prefissa aggiungendo le seguenti funzioni logiche:

; Funzione NAND
(define (nand a b) (not (and a b)))
; Funzione NOR
(define (nor a b) (not (or a b)))
; Funzione XOR
(define (xor a b) (if (nand a b) (or a b) nil))
; Funzione XNOR
(define (xnor a b) (not (xor a b)))

Funzione "xlate"

; Main function
(define (xlate str)
(local (result operators)
  (if (catch (infix-xlate str) 'result)
    result                      ; if starts with ERR: is error else result
    (append "ERR: " result))))  ; newLISP error has occurred
; Auxiliary function
(define (infix-xlate str)
(local (tokens varstack opstack expression ops op nops var vars)
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
    ; added
    ("not" not 1 9)
    ("and" and 2 9)
    ("or" or 2 9)
    ("nand" nand 2 9)
    ("nor" nor 2 9)
    ("xor" xor 2 9)
    ("xnor" xnor 2 9)
  ; add what else is needed
  ))
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
    result)))
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

(xlate "((a and b) or (c and (d or e)))")
;-> (or (and a b) (and c (or d e)))

(setq a nil b nil c true d nil e true)
(eval (xlate "((a and b) or (c and (d or e)))"))
;-> true

(eval (xlate "(a nand b) or (c and e)"))
;-> true

Poi scriviamo una funzione che genera la tabella dei valori da assegnare alle variabili:

(define (make-values num-vars)
  (setq len num-vars)
  (setq num (pow 2 len))
  (setq out '())
  (for (i 0 (- num 1))
    (setq fmt (string "%0" len "s"))
    ;(println (format fmt (bits i)))
    (setq val (explode (format fmt (bits i))))
    (replace "1" val true)
    (replace "0" val nil)
    (push val out -1)
  )
  out)

(make-values 3)
;-> ((nil nil nil)
;->  (nil nil true)
;->  (nil true nil)
;->  (nil true true)
;->  (true nil nil)
;->  (true nil true)
;->  (true true nil)
;->  (true true true))

Inoltre abbiamo bisogno di una funzione che estrae le variabili dall'espressione di input:

(define (extract-symbols exp-str)
  (local (tmp)
       (setq tmp (unique (parse exp-str)))
       (setq tmp (difference tmp '("(" ")" "and" "or" "not" "nand" "nor" "xor" "xnor")))
       (map sym tmp)))

(extract-symbols "((a and b) or (c nand (d or e)))")
;-> (a b c d e)

(extract-symbols "(a xnor b) xor (c or a)")
;-> (a b c)

(define (truth-table exp-str)
  (local (vars num-vars values binds res)
    (setq vars (extract-symbols exp-str))
    (setq num-vars (length vars))
    (setq values (make-values num-vars))
    (println exp-str)
    (dolist (el vars)
      (print (format "%4s" (string el)))
    )
    (println (format "%5s" "out"))
    (dolist (val values)
      (setq binds (map set vars val))
      (dolist (el val)
        ; print "true "nil"
        ;(print (format "%5s" (string el)))
        ; print "1" "0"
        (if el
            (print (format "%4s" "1"))
            (print (format "%4s" "0"))
        )
      )
      ; print "true "nil"
      ;(println (format "%5s" (string (eval (xlate exp-str)))))
      ; print "1 "0"
      (setq res (eval (xlate exp-str)))
      (if res
          (println (format "%5s" "1"))
          (println (format "%5s" "0"))
      )
    )
    '----------))

Facciamo alcune prove:

(truth-table "(not (A and B))")
;-> (not (A and B))
;->    A   B  out
;->    0   0    1
;->    0   1    1
;->    1   0    1
;->    1   1    0
;-> ----------

(truth-table "(A nand B)")
;-> (A nand B)
;->    A   B  out
;->    0   0    1
;->    0   1    1
;->    1   0    1
;->    1   1    0

(truth-table "(a or (b and c))")
;-> (a or (b and c))
;->    a   b   c  out
;->    0   0   0    0
;->    0   0   1    0
;->    0   1   0    0
;->    0   1   1    1
;->    1   0   0    1
;->    1   0   1    1
;->    1   1   0    1
;->    1   1   1    1
;-> ----------

(truth-table "(a xnor b) xor (c or a)")
;-> (a xnor b) xor (c or a)
;->    a   b   c  out
;->    0   0   0    1
;->    0   0   1    0
;->    0   1   0    0
;->    0   1   1    1
;->    1   0   0    1
;->    1   0   1    1
;->    1   1   0    0
;->    1   1   1    0
;-> ----------

(truth-table "((a and b) or (c and (d or e)))")
;-> ((a and b) or (c and (d or e)))
;->    a   b   c   d   e  out
;->    0   0   0   0   0    0
;->    0   0   0   0   1    0
;->    0   0   0   1   0    0
;->    0   0   0   1   1    0
;->    0   0   1   0   0    0
;->    0   0   1   0   1    1
;->    0   0   1   1   0    1
;->    0   0   1   1   1    1
;->    0   1   0   0   0    0
;->    0   1   0   0   1    0
;->    0   1   0   1   0    0
;->    0   1   0   1   1    0
;->    0   1   1   0   0    0
;->    0   1   1   0   1    1
;->    0   1   1   1   0    1
;->    0   1   1   1   1    1
;->    1   0   0   0   0    0
;->    1   0   0   0   1    0
;->    1   0   0   1   0    0
;->    1   0   0   1   1    0
;->    1   0   1   0   0    0
;->    1   0   1   0   1    1
;->    1   0   1   1   0    1
;->    1   0   1   1   1    1
;->    1   1   0   0   0    1
;->    1   1   0   0   1    1
;->    1   1   0   1   0    1
;->    1   1   0   1   1    1
;->    1   1   1   0   0    1
;->    1   1   1   0   1    1
;->    1   1   1   1   0    1
;->    1   1   1   1   1    1
;-> ----------

Nota: l'espressione deve contenere solo variabili, gli operatori logici "and", "or", "not", "nand", "nor", "xor", "xnor" e i caratteri "(" ")".


-----------------
Numeri Brasiliani
-----------------

I numeri Brasiliani sono così chiamati come furono presentati formalmente per la prima volta durante le Olimpiadi IberoAmericane di matematica nel 1994 a Fortaleza, in Brasile.
I numeri Brasiliani sono definiti come tutti i numeri interi positivi in ​​cui ogni numero N ha almeno un numero naturale B dove 1<B<N-1 dove la rappresentazione di N in base B ha tutte le cifre uguali.

Per esempio:
1, 2 e 3 non possono essere brasiliani: non esiste una base B che soddisfi la condizione 1<B<N-1.
4 non è brasiliano: 4 in base 2 è 100. Le cifre non sono tutte uguali.
5 non è brasiliano: 5 in base 2 è 101, in base 3 è 12. Non c'è rappresentazione B in cui le cifre sono le stesse.
6 non è brasiliano: 6 in base 2 è 110, in base 3 è 20, in base 4 è 12. Non c'è rappresentazione B in cui le cifre sono le stesse.
7 è brasiliano: 7 in base 2 è 111. C'è almeno una rappresentazione B in cui le cifre sono tutte uguali.
8 è brasiliano: 8 in base 3 è 22. C'è almeno una rappresentazione B in cui le cifre sono tutte uguali.
e così via...

Tutti i numeri interi pari 2*P> = 8 sono brasiliani perché 2*P = 2*(P-1) + 2, che è 22 in base P-1 quando P-1>2. Ciò diventa vero quando P>=4.
Più comune: per tutti gli interi R e S, dove R>1 e anche S-1>R, allora R*S è brasiliano perché R*S = R*(S-1) + R, che è RR in base S-1.
Gli unici numeri problematici sono i quadrati dei numeri primi, dove R = S. Solo 11^2 è brasiliano in base 3.
Tutti i numeri interi primi, che sono brasiliani, possono avere solo la cifra 1. Altrimenti si potrebbe fattorizzare la cifra, quindi non può essere un numero primo. Principalmente in forma di 111 in base Integer(sqrt(numero primo)). Deve essere un conteggio dispari di 1 per rimanere dispari come i numeri primi > 2.

Funzione che verifica se le cifre di un numero in una base sono tutte uguali:

(define (same-digits num base)
(catch
  (let (f (% num base))
    (while (> (setq num (/ num base)) 0)
      (if (!= (% num base) f) (throw nil))
    )
    true)))

Funzione che verifica se un numero è brasiliano:

(define (brasiliano? num)
(catch
  (cond ((< num 7) nil)
        ((zero? (% num 2)) true)
        (true
          (for (b 2 (- num 2))
            (if (same-digits num b) (throw true))
          )
          nil))))

(brasiliano? 13)
;-> true

Funzone che calcola i primi N numeri brasiliani:

(define (brasiliani num)
  (local (k conta out)
    (setq out '())
    (setq conta 0)
    (setq k 1)
    (while (< conta num)
      (cond ((brasiliano? k)
             (push k out -1)
             (++ conta))
      )
      (++ k)
    )
    out))

(brasiliani 20)
;-> (7 8 10 12 13 14 15 16 18 20 21 22 24 26 27 28 30 31 32 33)

Funzione che calcola l'N-esimo numero brasiliano:

(define (brasiliano-indice idx)
  (local (k conta)
    (setq conta 0)
    (setq k 1)
    (while (!= conta idx)
      (if (brasiliano? k) (++ conta))
      (++ k)
    )
    (- k 1)))

(brasiliano-indice 20)
;-> 33

Vediamo quanto vale il 100.000-esimo numero brasiliano (e quanto tempo ci vuole a calcolarlo):

(time (println (brasiliano-indice 100000)))
;-> 110468
;-> 964206.462 ; 16 minuti


------------------------
Probabilità condizionata
------------------------

Si definisce "probabilità condizionata" di un evento A condizionata (subordinata) all'evento B e si indica con P(A|B), la probabilità che si verifichi A nell'ipotesi che B si sia già verificato.

Eventi dipendenti
-----------------
Si hanno eventi dipendenti se il verificarsi o meno dell'evento B altera la probabilità del verificarsi del successivo evento A.

Viene definita dalla relazione:

            P(A ∩ B)
  P(A|B) = ------------
              P(B)

e viceversa:

            P(A ∩ B)
  P(B|A) = ------------
              P(A)

dove:
- P(A) è la probabilità che si verifichi l'evento A.
- P(B) è la probabilità che si verifichi l'evento B.
- P(A|B) è la probabilità che si verifichi l'evento A dopo che si è verificato l'evento B.
- P(B|A) è la probabilità che si verifichi l'evento B dopo che si è verificato l'evento A.
- P(A ∩ B) è la probabilità che in un singolo tentativo si verifichino simultaneamente l'evento A e l'evento B.

Nel caso di eventi dipendenti tra loro, il teorema del prodotto (probabilità composta) vale:

  P(A ∩ B) = P(A)*P(B|A) = P(B)*P(A|B)

La probabilità dell'intersezione tra due eventi è uguale al prodotto delle probabilità di uno degli eventi per la probabilità condizionata dell'altro, purchè sia verificato il primo evento.

Eventi indipendenti
-------------------
Due eventi A e B si dicono indipendenti se il verificarsi dell'uno non influenza il verificarsi dell'altro.
Nel lancio di due dadi il risultato di uno non influenza il risultato dell'altro, però se si estraggono due carte
da un mazzo (senza reinserimento) la probabilità di avere una carta nera la seconda volta è legata al fatto di avere incontrato o no una carta nera la prima volta, quindi questi eventi sono dipendenti.

Se gli eventi A e B sono indipendenti fra loro risulta:

  P(A|B)=P(A) e P(B|A)=P(B)

Quindi le formule della probabilità condizionata diventano:

          P(A ∩ B)
  P(A) = ------------  ==>  P(A ∩ B) = P(A)*P(B)
            P(B)

          P(A ∩ B)
  P(B) = ------------  ==>  P(A ∩ B) = P(A)*P(B)
            P(A)

La probabilità che in un singolo tentativo si verifichino gli eventi indipendenti A e B è pari al prodotto delle singole probabilità.

Estendendo il teorema a tre eventi A, B e C abbiamo (ponendo D = A ∩ B):

  P(A ∩ B ∩ C) = P(D|C) = P(D) * P(C|D) = P(A ∩ B) * P(C|(A ∩ B)) =

               = P(A) * P(B|A) * P(C|(A ∩ B))

Il teorema del prodotto viene ulteriormente semplificato nel caso gli eventi siano "collettivamente indipendenti", cioè quando ogni evento risulta indipendente non solo dagli altri, ma anche da tutte le possibili intersezioni:

  P(A|C) = P(A)
  P(C|A) = P(C)
  P(B|C) = P(B)
  P(A|(B ∩ C)) = P(A)
  P(B|(A ∩ C)) = P(B)
  P(C|(A ∩ B)) = P(C)

in questo caso il teorema del prodotto vale (per tre eventi):

  P(A ∩ B ∩ C) = P(A)*P(B)*P(A)

La probabilità che in un singolo tentativo si verifichino gli eventi indipendenti A, B e C è pari al prodotto delle singole probabilità.

Generalizzando per n eventi indipendenti E1, E2, ... ,En:

  P(E1 ∩ E2 ∩ ... ∩ En) = P(E1) * P(E2) * ... * P(En)

La probabilità che in un singolo tentativo si verifichino tutti gli eventi indipendenti di un insieme è pari al prodotto delle singole probabilità.

Esempio eventi dipendenti
-------------------------
Il lancio di due dadi produce una somma di punti minore di 7, calcolare la probabilità che i due dadi abbiano lo stesso valore.

I due  eventi sono:

  A = somma dei punti minore di 7

  6 · · · · · ·
  5 ■ · · · · ·
  4 ■ ■ · · · ·
  3 ■ ■ ■ · · ·
  2 ■ ■ ■ ■ · ·
  1 ■ ■ ■ ■ ■
    1 2 3 4 5 6

  P(A) = 15/36

  B = dadi con lo stesso valore

  6 · · · · · ■
  5 · · · · ■ ·
  4 · · · ■ · ·
  3 · · ■ · · ·
  2 · ■ · · · ·
  1 ■ · · · · ·
    1 2 3 4 5 6

  P(B) = 6/36 = 1/6

Dai grafici si deduce che la probabilità che entrambi gli eventi si verifichino in un unico tentativo vale:

  6 · · · · · ·
  5 · · · · · ·
  4 · · · · · ·
  3 · · ■ · · ·
  2 · ■ · · · ·
  1 ■ · · · · ·
    1 2 3 4 5 6

  P(A ∩ B) = P(A) * P(B) = 3/36

Adesso per calcolare P(B|A), cioè la probabilità che i due dadi abbiano lo stesso valore sapendo che la somma è un numero minore di 7, utilizziamo la formula della probabilità condizionata:

            P(A ∩ B)         3/36
  P(B|A) = ------------ = --------- = 3/15 = 1/5
              P(A)          15/36

In questo caso il fatto che gli eventi sono dipendenti lo si può riconosce dal fatto che risulta P(B|A) ≠ P(B):

  P(B|A) = 1/5 ≠ (P|B) = 1/6


Esempio eventi indipendenti
---------------------------
Estraendo una carta da un mazzo napoletano di 40 carte si ottiene una figura (Fante, Cavallo, Re). Qual'è la probabilità che la carta sia del seme Bastoni o Coppe?

  A = estrazione figura (Fante o Cavallo o Re)

  Denari  · · · · · · · ■ ■ ■
  Spade   · · · · · · · ■ ■ ■
  Bastoni · · · · · · · ■ ■ ■
  Coppe   · · · · · · · ■ ■ ■
          A 2 3 4 5 6 7 F C R

  P(A) = 12/40 = 3/10

  B = estrazione carta Bastoni o Coppe

  Denari  · · · · · · · · · ·
  Spade   · · · · · · · · · ·
  Bastoni ■ ■ ■ ■ ■ ■ ■ ■ ■ ■
  Coppe   ■ ■ ■ ■ ■ ■ ■ ■ ■ ■
          A 2 3 4 5 6 7 F C R

  P(B) = 20/40 = 1/2

Dai grafici notiamo che se è stata già estratta una figura (A), la probabilità che si tratti di una carta Bastoni o Coppe (B) vale:

  P(B|A) = 6/12 = 1/2

Viceversa che se è stata già estratta una carta Bastoni o Coppe (B), la probabilità che si tratti di una figura (A) vale:

  P(A|B) = 6/20 = 3/10

L'intersezione dei due insiemi vale:

  P(A ∩ B) = 6/40 = 3/20

Applicando le formule della probabilità condizionata:

             P(A ∩ B)       60/40
  P(B|A) = ------------ = --------- = 6/12 = 1/2   ==> P(B|A) = P(B)
               P(A)         12/40

             P(A ∩ B)        6/20
  P(A|B) = ------------ = --------- = 6/20 = 3/10  ==> P(A|B) = P(A)
               P(B)         20/40


------------------
Teorema di Bayes 1
------------------

Un importante teorema della teoria della probabilità e della statistica è il teorema di Bayes che si basa sul concetto di probabilità condizionata. Viene impiegato per calcolare la probabilità della causa che, a priori, ha generato un dato evento verificato a posteriori.
Una prima formulazione del teorema di Bayes (o teorema della probabilità delle cause) si ricava dal principio della probabilità composta. Consideriamo uno spazio dei campioni costituito da n eventi mutuamente (reciprocamente) esclusivi: A1, A2,...An.

  +--------------+------+-------+-------------------+
  |              |      |       |                   |
  |  A1          |      |       |                   |
  |              |      |       |                   |
  |              |      |       |                   |
  |              |      |       |                   |
  |              |      |       |        +----------+
  +--------------+      |       |        |          |
  |                     |       |        |          |
  |  A2                 |       |   A4   |   A5     |
  |                     |  A3   |        |          |
  +---------------------+-------+--------+----------+


Ipotizziamo che questi eventi A1, A2,...An costituiscano una partizione dello spazio dei campioni. Questo significa che l'intersezione di due eventi qualsiasi è sempre nulla e l'unione di tutti gli eventi Ai costituisce lo spazio dei campioni (universo degli eventi).

  +--------------+------+--------+-------------------+
  |              |      |        |                   |
  |  A1          |      |        |                   |
  |      OOOOOOOOOOOOOOOOOOOOOOO |                   |
  |      O       |      |      O |                   |
  |      O  B∩A1 |      | B∩A3 O |                   |
  |      O       | B∩A2 |      O |        +----------+
  +------O-------+      |      O |        |          |
  |      OOOOOOOOOOOOOOOOOOOOOOO |        |          |
  |  A2                 |        |   A4   |   A5     |
  |                     |  A3    |        |          |
  +---------------------+------- +--------+----------+

Consideriamo ora un altro evento B dello stesso spazio dei campioni e supponiamo che siano note le probabilità P(Ai) e le probabilità condizionate P(B|Ai). In queste condizioni è possibile calcolare la probabilità:

  P(B) = P(A1)*P(B ∩ A1) + P(A2)*P(B ∩ A2) + ... + P(An)*P(B ∩ An)

dove quando B ∩ Ai = (), si ha P(B ∩ Ai) = 0

Per il teorema del prodotto risulta:

  P(B ∩ Ai) = P(Ai)*P(B|Ai)

e sostituendo nella formula per calcolare P(B):

  P(B) = P(A1)*P(B|A1) + P(A2)*P(B|A2) + ... + P(An)*P(B|An) =
         n
       = ∑ P(Ai)*P(B|Ai)
         i

Teorema della probabilità assoluta

  +--------------------------+
  |         n                |
  |  P(B) = ∑ P(Ai)*P(B|Ai)  |
  |         i                |
  +--------------------------+

Esempio
-------
Ci sono tre cassetti uguali contenenti:
- il primo 3 anelli d'argento (G) e 1 d'oro (O)
- il secondo 1 anello d'argento (G) e 3 d'oro (O)
- il terzo 2 anelli d'argento (G)
Aprendo un cassetto a caso e prendendo un anello a caso, qual'è la probabilità di prendere un anello d'oro?

     +------------------+
  A1 |  G G G        O  |
     +------------------+
  A2 |  G          O O  |
     +------------------+
  A3 |  G G             |
     +------------------+

Indichiamo con B l'evento di aver trovato un anello d'oro e con A1 A2 e A3 l'eventualità di aver aperto il primo, il secondo o il terzo cassetto.
Dato che i cassetti sono uguali possiamo assumere come probabilità :

  P(A1) = P(A2) = P(A3) = 1/3

Le probabilità valgono:

  P(B|A1) = 1/4 (il primo cassetto contiene 1 anello su 4)
  P(B|A2) = 2/3 (il primo cassetto contiene 2 anelli su 3)
  P(B|A2) = 0   (il primo cassetto contiene 0 anelli su 2)

Per il teorema della probabilità totale si ha

  P(B) = P(A1)*P(B|A1) + P(A2)*P(B|A2) + P(A3)*P(B|A3) =
       = 1/3*1/4 + 1/3*2/3 + 1/3*0 = 11/36

Quindi aprendo un cassetto a caso, la probabilità di prendere un anello d'oro vale 11/36.

Supponendo, ora, di sapere che l'evento B si è verificato calcoliamo la probabilità che si verifichi l'evento Ai. Dal teorema del prodotto si ha:

  P(Ai ∩ B) = P(Ai)*P(B|Ai) = P(B)*P(Ai|B)

da cui si ottiene:

              P(Ai ∩ B)       P(Ai)*P(B|Ai)
  P(Ai|B) = ------------- = -----------------
                P(B)              P(B)

Adesso sostituendo P(B) con il valore dato dalla formula della probabilità totale otteniamo la Formula di Bayes:

  Formula di Bayes
  +---------------------------------+
  |               P(Ai)*P(B|Ai)     |
  |  P(Ai|B) = -------------------  |
  |              ∑ P(Ai)*P(B|Ai)    |
  +---------------------------------+

Esempio
-------
Ci sono tre urne A1 A2 e A3 che contengono delle palline:
- A1: contiene 12 palline rosse e  8 verdi
- A2: contiene 10 palline rosse e 15 verdi
- A3: contiene  9 palline rosse e  6 verdi
Si lancia un dado e se il punto non è superiore a 3 si estrae una pallina dall'urna A1, se viene un numero superiore a 4 si estrae una pallina dall'urna A2 e se esce il numero 4 si estrae la pallina dall'urna A3.
Esce una pallina rossa: quale è la probabilità che essa sia stata estratta dall'urna A1?

Indichiamo con:
 R: pallina rossa
 V: pallina verde

Indichiamo con A1, A2 e A3 gli eventi
 A1: viene estratta una pallina dall'urna A1
 A2: viene estratta una pallina dall'urna A2
 A3: viene estratta una pallina dall'urna A3

Le probabilità di estrazione dai cassetti valgono:

  P(A1) =  3/6 = 1/2 probabilità che venga estratta una pallina dall'urna A1.
  P(A2) =  2/6 = 1/3 probabilità che venga estratta una pallina dall'urna A2.
  P(A3) =  1/6 probabilità che venga estratta una pallina dall'urna A3.

Per l'urna A1 abbiamo:

  P(R|A1) = 12/20 = 3/5 probabilità di estrarre una pallina rossa dall'urna A1.
  P(V|A1) = 8/20 = 2/5 probabilità di estrarre una pallina rossa dall'urna A1.

Per l'urna A2 abbiamo:

  P(R|A2) = 10/25 = 2/5 probabilità di estrarre una pallina rossa dall'urna A2.
  P(V|A2) = 15/25 = 3/5 probabilità di estrarre una pallina verde dall'urna A2.

Per l'urna A3 abbiamo:

  P(R|A3) = 9/15 = 3/5 probabilità di estrarre una pallina rossa dall'urna A3.
  P(V|A3) = 6/15 = 2/5 probabilità di estrarre una pallina verde dall'urna A3.

in base al grafico seguente:

     P(A1)=1/2
  +-------------A1--+------R-- P(R|A1) = 3/5
  |                 |
  |                 +------V-- P(V|A1) = 2/5
  |  P(A2)=1/3
  +-------------A2--+------R-- P(R|A2) = 2/5
  |                 |
  |                 +------V-- P(V|A2) = 3/5
  |  P(A3)=1/6
  +-------------A3--+------R-- P(R|A3) = 3/5
                    |
                    +------V-- P(V|A3) = 2/5

Quindi per la pallina rossa (R) avremo:

  ∑ P(Ai)*P(R|Ai) = P(A1)*P(R|A1) + P(A2)*P(R|A2) + P(A2)*P(R|A3) = 8/15

Adesso applicando il Teorema di Bayes otteniamo la probabilità che la pallina rossa sia stata estratta dall'urna A1:

               P(A1)*P(R|A1)        3/5 * 1/2
  P(A1|R) = ------------------- = ------------- = 9/16
              ∑ P(Ai)*P(R|Ai)         8/15


------------------
Teorema di Bayes 2
------------------

Il teorema di Bayes (conosciuto anche come formula di Bayes o teorema della probabilità delle cause), proposto da Thomas Bayes (1702-1761), deriva da due teoremi fondamentali delle probabilità: il teorema della probabilità composta e il teorema della probabilità assoluta. Viene impiegato per calcolare la probabilità di una causa che ha scatenato l'evento verificato.
Formalmente il teorema di Bayes è valido in tutte le interpretazioni della probabilità.

Considerando un insieme di alternative A1,A2, ..., An che partizionano lo spazio degli eventi S (ossia (Ai ∩ Aj)=() per ogni i≠j e Unione(Ai)=S) vale la seguente espressione per la probabilità condizionata:

              P(Ai)*P(E|Ai)         P(Ai)*P(E|Ai)
  P(Ai|E) = ------------------- = -------------------
                  P(E)             ∑ P(Aj)*P(E|Aj)

dove:

  P(A) è la probabilità a priori o probabilità marginale di A. "A priori" significa che non tiene conto di nessuna informazione riguardo E.
  P(A|E) è la probabilità condizionata di A, noto E. Viene anche chiamata probabilità a posteriori, visto che è derivata o dipende dallo specifico valore di E.
  P(E|A) è la probabilità condizionata di E, noto A.
  P(E) è la probabilità a priori di E, e funge da costante di normalizzazione.

Intuitivamente, il teorema descrive il modo in cui le opinioni nell'osservare A siano arricchite dall'aver osservato l'evento E.

Il teorema deriva dalla definizione di probabilità condizionata. La probabilità di un evento A, noto un evento B, risulta:

            P(A ∩ B)
  P(A|B)= ------------
              P(B)

In modo analogo, la probabilità di un evento B noto un evento A:

            P(A ∩ B)
  P(B|A)= ------------
              P(A)

Pertanto:

  P(A ∩ B) = P(B|A)*P(A)

Sostituendo nella prima uguaglianza, si trova il teorema di Bayes:

            P(A ∩ B)       P(B|A)*P(A)
  P(A|B)= ------------ = ---------------
              P(B)            P(B)

Esempio
-------
Si consideri una scuola che ha il 60% di studenti maschi e il 40% di studentesse femmine.
Le studentesse indossano in egual numero gonne o pantaloni mentre gli studenti indossano tutti quanti i pantaloni. Un osservatore, da lontano, nota un generico studente coi pantaloni. Qual è la probabilità che quello studente sia una femmina?

Il problema può essere risolto con il teorema di Bayes, ponendo l'evento A che lo studente osservato sia femmina, e l'evento B che lo studente osservato indossi i pantaloni. Per calcolare P(A|B), dovremo sapere:

P(A), ovvero la probabilità che lo studente sia femmina senza nessun'altra informazione. Dato che l'osservatore vede uno studente a caso, ciò significa che tutti gli studenti hanno la stessa probabilità di essere osservati. Essendo le studentesse il 40% del totale, la probabilità risulterà 2/5.

P(A'), ovvero la probabilità che lo studente sia maschio senza nessun'altra informazione. Essendo A' l'evento complementare di A, risulta 3/5.

P(B|A), ovvero la probabilità che uno studente femmina indossi i pantaloni (ossia la probabilità che, verificato l'evento che lo studente sia femmina, si verifichi l'evento che indossi i pantaloni). Poiché indossano gonne e pantaloni in egual numero, la probabilità sarà di 1/2.

P(B|A'), ovvero la probabilità che uno studente indossi i pantaloni, noto che lo studente è maschio. Tutti gli studenti maschi indossano i pantaloni, quindi vale 1.

P(B), ovvero la probabilità che uno studente qualsiasi (maschio o femmina) indossi i pantaloni. Poiché il numero di coloro che indossano i pantaloni è di 80 (60 maschi + 20 femmine) su 100 studenti fra maschi e femmine, la probabilità P(B) è di 80/100 = 4/5.

Adesso possiamo applicare il teorema:

          P(B|A)*P(A)       1/2 * 2/5
P(A|B)= --------------- = ------------- = 1/4
             P(B)              4/5

Quindi la probabilità che lo studente sia femmina vale 1/4, cioè il 25%.

Nota: in questo semplice esempio, la verifica dell'esattezza del risultato è immediata se consideriamo la definizione di "probabilità di un evento" = "numero dei casi favorevoli all'evento/numero dei casi possibili". Il numero dei casi possibili che lo studente/studentessa osservato indossi i pantaloni vale 80 (60 maschi + 20 femmine) mentre quello dei casi favorevoli (cioè le femmine che indossano pantaloni) è 20, quindi la probabilità che si tratti di una femmina è 20/80 cioè 1/4.

Sensibilità e Specificità
---------------------------
La "Sensibilità" e la "Specificità" sono misure statistiche delle prestazioni di un test di classificazione binario e furono introdotti dal biostatistico americano Jacob Yerushalmy nel 1947:

"Sensibilità" (tasso di veri positivi): misura la proporzione di positivi identificati correttamente (cioè la proporzione di coloro che hanno una condizione (affetta) che sono correttamente identificati come affetti dalla condizione).

"Specificità" (tasso veri negativi): misura la proporzione di negativi che sono correttamente identificati (cioè la proporzione di coloro che non hanno la condizione (non affetti) che sono correttamente identificati come non affetti dalla condizione).

I termini "vero positivo", "falso positivo", "vero negativo" e "falso negativo" si riferiscono al risultato di un test e alla correttezza della classificazione. Ad esempio, se la condizione è una malattia, "vero positivo" significa "correttamente diagnosticato come malato", "falso positivo" significa "erroneamente diagnosticato come malato", "vero negativo" significa "correttamente diagnosticato come non malato" e "falso negativo "significa" diagnosticato erroneamente come non malato".
Pertanto, se la sensibilità di un test è del 97% e la sua specificità è del 92%, il suo tasso di falsi negativi è del 3% e il suo tasso di falsi positivi è dell'8%.

In un test diagnostico, la sensibilità è una misura della capacità di un test di identificare i veri positivi.
La sensibilità può anche essere definita come il tasso di richiamo, il tasso di successo o il tasso di vero positivo. È la percentuale, o proporzione, di veri positivi su tutti i campioni che presentano la condizione (veri positivi e falsi negativi). La sensibilità di un test può aiutare a mostrare quanto bene può classificare i campioni che hanno la condizione.

In un test, la specificità è una misura della capacità di un test di identificare i veri negativi. La specificità viene anche definita selettività o tasso di veri negativi ed è la percentuale, o proporzione, dei veri negativi tra tutti i campioni che non presentano la condizione (veri negativi e falsi positivi).

In un test "buono" (uno che cerca di identificare con precisione le persone che hanno la condizione), i falsi positivi dovrebbero essere molto bassi. Cioè, le persone identificate come affette da una condizione dovrebbero avere molte probabilità di avere veramente la condizione. Questo perché le persone identificate come affette da una condizione (ma che non ce l'hanno, in verità) possono essere sottoposte a grande stress.

Per tutti i test, sia diagnostici che di screening, esiste un compromesso tra sensibilità e specificità. Sensibilità più elevate significheranno specificità inferiori e viceversa.

Esempio
-------
Supponiamo che un test per determinare se qualcuno ha usato cannabis sia "Sensibile" al 90%, il che significa che il Tasso di Veri Positivi (TPR) = 0,90. Pertanto porta al 90% di risultati positivi veri (corretta identificazione del consumo di droga) per i consumatori di cannabis.

Il test è anche "Specifico" all'80%, il che significa che il "Tasso di Veri Negativi" (TNR) = 0,80. Pertanto il test identifica correttamente l'80% di risultati negativi veri (corretta identificazione di non utilizzo) per i non-drogati, ma genera anche il 20% di falsi positivi, o Tasso di Falsi Positivi (FPR) = 0,20, per i non-drogati.

Assumendo una "Prevalenza" dello 0,05, ovvero il 5% delle persone usa cannabis, qual è la probabilità che una persona a caso che risulta positiva al test sia davvero un consumatore di cannabis?

Il "Valore Predittivo Positivo" (PPV) di un test è il rapporto tra il numero di persone che sono effettivamente positive e il numero di persone risultate positive e può essere calcolato da un campione come:

  PPV = Veri_positivi / Testati_positivi

Se si conoscono "Sensibilità", "Specificità" e "Prevalenza", il PPV può essere calcolato utilizzando il teorema di Bayes.

Poniamo che P(Consumatore|Positivo) = P(C|P) significa "la probabilità che qualcuno sia un consumatore di cannabis dato che risulta positivo al test " (che è ciò che si intende per PPV). Inoltre P(Positivo|Non-consumatore) = P(P|N) è "la probabilità che qualcuno risulti positivo non essendo consumatore di cannabis".
Allora possiamo scrivere:

             P(P|C)*P(C)             P(P|C)*P(C)
  P(C|P) = --------------- = ----------------------------- =
                P(P)           P(P|C)*P(C) + P(P|N)*P(N)

                 0.9 * 0.05
         = ----------------------- = 0.19148... (19.1%)
             0.9*0.05 + 0.2*0.95

Il fatto che P(P) = P(P|U)*P(U) + P(P|N)*P(N) è un'applicazione diretta della Legge della Probabilità Totale. In questo caso, dice che la probabilità che qualcuno sia positivo è la probabilità che un consumatore sia positivo, moltiplicata per la probabilità di essere un consumatore, più la probabilità che un non consumatore risulti positivo, moltiplicata per la probabilità di essere un non consumatore .

Questo è vero perché le classificazioni consumatore e non consumatore formano una partizione di un insieme, cioè l'insieme di persone che fanno il test antidroga. Ciò combinato con la definizione di probabilità condizionale risulta nella dichiarazione di cui sopra.

Anche se qualcuno risulta positivo, la probabilità che sia un consumatore di cannabis è solo del 19%, perché in questo gruppo solo il 5% delle persone sono consumatori, la maggior parte dei positivi sono falsi positivi provenienti dal restante 95%.

Se sono state testate 1.000 persone:
- 950 sono non consumatori e 190 di loro danno un falso positivo (0,20 × 950)
- 50 di loro sono consumatori e 45 di loro danno un vero positivo (0,90 × 50)

Le 1.000 persone quindi producono 235 test positivi, di cui solo 45 sono veri consumatori di droghe, circa il 19%.

In definitiva abbiamo:

1) Consumatori e Positivi: 45 su 50
2) Non consumatori e Positivi: 190 su 950
3) Non consumatori e negativi: 750 su 950
4) Consumatori e negativi: 5 su 50


---------------------
Probabilità bayesiane
---------------------

In newLISP, due funzioni, "bayes-train" e "bayes-query", lavorano insieme per fornire un modo semplice per calcolare le probabilità bayesiane per insiemi di dati.
Vediamo come utilizzare le due funzioni per prevedere la probabilità che un breve testo sia stato scritto da uno di due autori.
Prima di tutto, scegliamo i testi "The Sign of Four" di Conan Doyle e "The Picture of Dorian Gray" di Oscar Wilde e poi generiamo il relativo set di dati per ciascuno.

(silent
(setq doyle-data
  (parse (lower-case
         (read-file "sign-of-four.txt")) {\W} 0)))

Il parametro {\W} indica a regex di prendere solo le parole (Words).

Vediamo come è strutturato il set di dati:

(length doyle-data)
;-> 59456
(slice doyle-data 100 20)
;-> ("some" "little" "time" "his" "eyes" "rested"
;->  "thoughtfully" "" "upon" "the" "sinewy" "forearm"
;->  "and" "wrist" "all" "dotted" "and" "scarred" "with" "")

(silent
(setq wilde-data
  (parse (lower-case
         (read-file "dorian-grey.txt")) {\W} 0)))

(length wilde-data)
;-> 110762
(slice wilde-data 100 20)
;-> ("are" "corrupt" "without" "" "being" "charming"
;->  "" "" "this" "is" "a" "fault" "" "" "" ""
;->  "those" "who" "find" "beautiful")

La funzione "bayes-train" può ora scansionare queste due liste di dati e memorizzare le frequenze delle parole in un nuovo contesto, che chiameremo Lessico:

(bayes-train doyle-data wilde-data 'Lessico)
;-> (59456 110762)

Questo contesto ora contiene un elenco di parole che ricorrono nei testi e le frequenze di ciascuna. Ad esempio:

Lessico:_always
;-> (21 110)

cioè la parola "always" appare 21 volte nel testo di Doyle e 110 volte in quello di Wilde.

Possiamo salvare il contesto "Lessico" in un file:

(save "lessico.lsp" 'Lessico)
;-> true

Per essere pronto ad essere caricato quando è necessario con:

(load "lessico.lsp")
;-> MAIN

Adesso possiamo usare la funzione "bayes-query" per analizzare una lista di parole contro quelle del contesto "Lessico" e restituire due valori: la probabilità delle parole di appartenere alla prima lista di parole (doyle-data) o alla seconda lista di parole (wilde-data).

Vediamo tre domande:

1) Parole da analizzare: "the latest vegetable alkaloid" prese dal libro di Conan Doyle "A Study in Scarlet".

(setq frase1
  (bayes-query (parse (lower-case
                "the latest vegetable alkaloid") {\W} 0)
               'Lessico))
;-> (0.9888389301533436 0.01116106984665644)

Questo significa che la frase è attribuita a Doyle al 97.3% e al 2.7% a Wilde.

2) Parole da analizzare: "after breakfast he flung himself down on a divan and lit a cigarette" prese dal libro di Oscar Wilde "Lord Arthur Savile's Crime".

(setq frase2
  (bayes-query (parse (lower-case
                "after breakfast he flung himself down on a divan and lit a cigarette" ){\W} 0)
               'Lessico))
;-> (0.02500058589218207 0.9749994141078178)

Questo significa che la frase è attribuita a Doyle al 2.5% e al 97.5% a Wilde.

3) Parole da analizzare: "observations of threadbare morality to listen to" prese dal libro di Jane Austin "Pride and Prejudice" .

(setq frase3
  (bayes-query (parse (lower-case
                "observations of threadbare morality to listen to" ) {\W} 0)
               'Lessico))
;-> (0.5 0.5)

Questo significa che la frase è attribuita a Doyle al 50% e al 50% a Wilde, cioè non è in grado di decidere a quale dei due appartenga la frase (stesse probabilità).


Proviamo a togliere tutte le parole vuote da entrambi i set di dati e vedere se otteniamo risultati diversi:

Eliminiamo il contesto di training precedente:

(delete 'Lessico)

Togliamo le parole vuote "":

(silent (setq d-data (clean null? doyle-data)))
(length d-data)
;-> 43814
(silent (setq w-data (clean null? wilde-data)))
(length w-data)
;-> 80416

Creazione del contesto di training:

(bayes-train d-data w-data 'Lessico)
;-> (43814 80416)

Esecuzione delle tre domande:

(setq frase1
  (bayes-query (parse (lower-case
                "the latest vegetable alkaloid") {\W} 0)
               'Lessico))
;-> (0.988422932469966 0.01157706753003401)

(setq frase2
  (bayes-query (parse (lower-case
                "after breakfast he flung himself down on a divan and lit a cigarette" ){\W} 0)
               'Lessico))
;-> (0.02340957380124487 0.9765904261987551)

(setq frase3
  (bayes-query (parse (lower-case
                "observations of threadbare morality to listen to" ) {\W} 0)
               'Lessico))
;-> (0.5 0.5)

I risultati sono sostanzialmente gli stessi.


----
Dadi
----

I dadi comuni sono piccoli cubi, il più delle volte 16mm (0,63 pollici) di diametro, le cui facce sono numerate da uno a sei, di solito con punti rotondi chiamati pips (anche se occasionalmente si vede l'uso di numeri arabi).

I dadi sono misurati in millimetri (mm) da un lato all'altro e, sebbene le dimensioni dei dadi possano variare da 5mm fino a 100mm o più, ci sono alcune dimensioni dei dadi considerate "standard": 5mm, 12mm, 16mm, 19mm, 25mm e 50mm.

Un pollice equivale a 25.4 millimetri, quindi un dado da 16mm ha una dimensione di circa 2/3 di pollice e un dado da 19mm è di circa 3/4 di pollice.

I valori dei numeri dei lati opposti di un dado moderno sommano a sette, richiedendo che le facce 1, 2 e 3 condividano un vertice. Le facce di un dado possono essere posizionate in senso orario o antiorario attorno a questo vertice. Se le facce 1, 2 e 3 girano in senso antiorario, il dado viene chiamato "destrorso". Se quelle facce girano in senso orario, il dado viene chiamato "mancino".
I dadi occidentali sono normalmente destrorsi, mentre i dadi cinesi sono normalmente mancini.

Senso anti-orario (destrorso "right-handed"):

  +---+
  | 3 |
  +---+---+---+---+
  | 6 | 5 | 1 | 2 |
  +---+---+---+---+
  | 4 |
  +---+

Senso orario (mancino "left-handed"):

  +---+
  | 4 |
  +---+---+---+---+
  | 6 | 5 | 1 | 2 |
  +---+---+---+---+
  | 3 |
  +---+

Nota: vengono scambiate le posizioni del 3 e del 4.

I dadi comunemente disponibili favoriscono alcuni numeri più di altri perché alcuni lati sono più leggeri dei lati opposti a causa del diverso numero di "pin" e anche perché ci sono altre imprecisioni nel processo di produzione. Questo fatto diventerà evidente solo dopo un numero considerevolmente alto di lanci. Se questo è un problema, allora possiamo prendere i dadi di precisione utilizzati nei casinò "casino dice".

I dadi del casinò sono chiamati dadi perfetti o di precisione a causa del modo in cui sono fatti. Sono il più vicino possibile ad essere veri cubi perfetti, misurati entro una frazione di millimetro, fabbricati in modo che ogni dado abbia la stessa possibilità di atterrare su una qualsiasi delle sue sei facce.
Questi dadi vengono realizzati a mano in acetato di cellulosa con una tolleranza di 0.0005 di pollice. I punti vengono forati e riempiti con materiale di peso uguale a quello rimosso. Di solito i lati sono a filo e i bordi affilati. Sono prevalentemente rossi trasparenti ma possono essere disponibili in altri colori come il verde, il viola o il blu. Alcuni dadi da casinò possono avere una finitura levigata che li renderà traslucidi e non completamente trasparenti. I punti sono generalmente solidi ed è possibile trovare un numero di disegni diversi, comunque si ritiene che tutti i dadi da casinò dovrebbero essere "destrorsi" e avere la stessa disposizione convenzionale di facce e pin.

Vediamo come simulare il lancio di dadi.

Funzione che ritorna l'opposto del numero di un dado a sei facce:

(define (dado-opposto num) (- 7 num))

Scriviamo una funzione che simula il lancio di N dadi ognuno con F facce:

(rand 6 10)
;-> (4 1 4 2 5 4 0 2 3 2)

(define (dado num-dadi num-facce)
  (+ num-dadi (apply + (rand num-facce num-dadi))))

Scriviamo una funzione che calcola la probabilità di ogni numero generato dalla funzione "dado" con parametri predefiniti:

(define (test-dado num-dadi num-facce iter)
  (local (out max-val)
    ; valore massimo
    (setq max-val (* num-dadi num-facce))
    ; vettore delle frequenze
    (setq out (array (+ max-val 1) '(0)))
    ; ciclo di simulazione
    (for (i 1 iter)
      ; aumenta la frequenza del numero uscito
      (++ (out (dado num-dadi num-facce)))
    )
    ; calcola la percentuale di ogni frequenza
    (map (fn(x) (round (div x iter) -4)) (slice out 1))))

Facciamo alcune prove:

Un dado da 6:
(test-dado 1 6 100000)
;-> (0.1653 0.1679 0.1662 0.1672 0.1679 0.1655)
I numeri 1..6 sono tutti equiprobabili.

Due dadi da 12:
(test-dado 2 6 100000)
;-> (0 0.0273 0.056 0.0833 0.1111 0.1388 0.1672 0.1401 0.1103 0.0827 0.0552 0.028)
Il numero 7 è più probabile in 1..12.
Il numero 1 non è possibile (percentuale = 0).

Tre dadi da 6:
(test-dado 3 6 1000000)
;-> (0 0 0.0049 0.0139 0.0286 0.0467 0.0695 0.0946 0.1162 0.1248
;->  0.1251 0.1162 0.0964 0.0702 0.0463 0.0278 0.0139 0.0048)

Tre dadi da 6 (più iterazioni):
(test-dado 3 6 1e8)
;-> (0 0 0.0046 0.0139 0.0278 0.0463 0.0695 0.0973 0.1157 0.125
;->  0.125 0.1158 0.0972 0.0694 0.0463 0.0278 0.0139 0.0046)
I numero 10 e 11 sono più probabili in 1..18.
I numeri 1 e 2 non sono possibili (percentuale = 0).


----------------
replace multiplo
----------------

La funzione "replace" permette di sostituire in una lista ogni occorrenza di un elemento con un altro elemento. Se abbiamo bisogno di effettuare diverse sostituzioni dobbiamo applicare tante volte la funzione "replace". Per esempio:

(setq lst '(1 3 5 4 3 1 5 5 7 1 2))
(replace 1 lst 'a)
;-> (a 3 5 4 3 a 5 5 7 a 2)
(replace 2 lst 'b)
;-> (a 3 5 4 3 a 5 5 7 a b)
(replace 3 lst 'c)
;-> (a c 5 4 c a 5 5 7 a b)

Comunque possiamo usare anche il metodo seguente:

(setq lst '(1 3 5 4 3 1 5 5 7 1 2))
(setq sost '((1 a) (2 b) (3 c)))
(dolist (s sost)
    (replace (first s) lst (last s)))
;-> (a c 5 4 c a 5 5 7 a b)

Questo metodo permette di tenere insieme le coppie da sostituire nel caso ci sia una lunga lista di modifiche.

Possiamo convertire il metodo in una macro igienica:

(define-macro (replace-all)
    (dolist (r (eval (args 0)))
      (replace (first r) (eval (args 1)) (last r))))

(setq lst '(1 3 5 4 3 1 5 5 7 1 2))
;-> (1 3 5 4 3 1 5 5 7 1 2)
(replace-all sost lst)
;-> (a c 5 4 c a 5 5 7 a b)

La macro può essere applicata anche alle stringhe:

(setq str "newlisp è difficile")
(setq sost '(("newlisp" "newLISP") ("difficile" "divertente")))
(replace-all sost str)
;-> "newLISP è divertente"


----------------
ASCII Mandelbrot
----------------

Ecco una versione base per stampare sul terminale il frattale di Mandelbrot.

Prima di tutto ci servono alcune funzioni per calcolare i numeri complessi:

; Estrae la parte reale di un numero complesso
(define (real num) (first num))
; Estrae la parte immaginaria di un numero complesso
(define (imag num) (last num))
; Calcola il modulo di un numero complesso
(define (modulo num)
  (sqrt (add (mul (real num) (real num)) (mul (imag num) (imag num)))))
; Calcola la somma di due numeri complessi
(define (cx-add num1 num2)
  (list (add (real num1) (real num2)) (add (imag num1) (imag num2))))
; Calcola la moltiplicazione di due numeri complessi
(define (cx-mul num1 num2)
  (list (sub (mul (real num1) (real num2)) (mul (imag num1) (imag num2)))
        (add (mul (imag num1) (real num2)) (mul (real num1) (imag num2)))))

Poi scriviamo una funzione per calcolare il frattale di Mandelbrot:

(define (mandelbrot)
  (local (x y z)
    (for (y -1.2 1.2 0.05)
      (for (x -2.05 0.55 0.03)
        (setq z '(0 0))
        (dotimes (i 100)
          (setq z (cx-add (cx-mul z z) (list x y)))
        )
        (if (< (modulo z) 2)
            (print "#")
            (print ".")
        )
      )
      (println))))

Proviamo:

(mandelbrot)
..............................................................................
...........................................................##.................
........................................................######................
........................................................#######...............
.........................................................######...............
.....................................................#.#.###..#.#.............
..............................................##....################..........
.............................................###.######################.###...
..............................................############################....
...........................................###############################....
...........................................################################...
........................................#####################################.
.........................................###################################..
.........................##.####.#......####################################..
.........................###########....####################################..
.......................###############.######################################.
.......................###############.#####################################..
...................##.#####################################################...
.#.###...#..############################################################......
...................##.#####################################################...
.......................###############.#####################################..
.......................###############.######################################.
.........................###########....####################################..
.........................##.####.#......####################################..
.........................................###################################..
........................................#####################################.
...........................................################################...
...........................................###############################....
..............................................############################....
.............................................###.######################.###...
..............................................##....################..........
.....................................................#.#.###..#.#.............
.........................................................######...............
........................................................#######...............
........................................................######................
...........................................................##.................
..............................................................................


-------
Yahtzee
-------
Yahtzee è un gioco di strategia che si svolge con 5 dadi. Si gioca da soli cercando di fare il punteggio migliore o contro uno o più avversari.

Sono previste diverse combinazioni che ogni giocatore deve realizzare lanciando i dadi. Ottenuta la combinazione il giocatore guadagna il punteggio previsto per la combinazione. Una combinazione non può essere ripetuta quindi il gioco termina dopo 13 turni di lancio dei dadi, anche quando non sono state realizzate tutte le combinazioni.

Ad ogni turno il giocatore può lanciare i dadi tre volte. Al primo lancio il giocatore lancia tutti i dadi, mentre nei successivi due lanci il giocatore può scegliere di trattenere uno o più dadi favorevoli ad ottenere la combinazione cercata. Il giocatore può anche scegliere di non trattenere alcun dado o di non utilizzare successivi lanci, nel caso ad esempio si sia già realizzata una combinazione utile. Al termine dei tre lanci il giocatore deve segnare obbligatoriamente un punteggio in una delle caselle del segnapunti non ancora utilizzata. Se alla fine del turno di gioco non viene realizzata una delle possibili combinazioni ancora "libera" sul tabellone, il giocatore deve segnare "0" (zero) in una delle caselle ancora a sua disposizione.

Vince il giocatore che ha totalizzato il maggior numero di punti.

Le combinazioni valide sono le seguenti:

  Dadi uguali con 1 (punteggio dato dalla somma dei dadi con 1):
  si ottiene quando almeno un dado è 1. Il punteggio è la somma dei dadi che riportano 1. Ad esempio: 1-3-4-6-1 vale 2.

  Dadi uguali con 2 (punteggio dato dalla somma dei dadi con 2):
  si ottiene quando almeno un dado è 2. Il punteggio è la somma dei dadi che riportano 2. Ad esempio: 2-1-2-2-5 vale 6.

  Dadi uguali con 3 (punteggio dato dalla somma dei dadi con 3):
  si ottiene quando almeno un dado è 3. Il punteggio è la somma dei dadi che riportano 3. Ad esempio: 3-1-3-4-3 vale 9.

  Dadi uguali con 4 (punteggio dato dalla somma dei dadi con 4):
  si ottiene quando almeno un dado è 4. Il punteggio è la somma dei dadi che riportano 4. Ad esempio: 4-1-2-2-1 vale 4.

  Dadi uguali con 5 (punteggio dato dalla somma dei dadi con 5):
  si ottiene quando almeno un dado è 5. Il punteggio è la somma dei dadi che riportano 5. Ad esempio: 5-1-5-5-2 vale 15.

  Dadi uguali con 6 (punteggio dato dalla somma dei dadi con 6):
  si ottiene quando almeno un dado è 6. Il punteggio è la somma dei dadi che riportano 6. Ad esempio: 6-3-2-6-1 vale 12,

  Bonus (35 punti):
  si ottiene quando la somma dei punteggi per le 6 combinazioni precedenti supera o raggiunge 63.

  Piccola Scala (30 punti):
  quando 4 dadi sono ordinati in modo crescente (1-2-3-4 o 2-3-4-5 o 3-4-5-6)

  Grande Scala (40 punti):
  quando 5 dadi sono ordinati in modo crescente (1-2-3-4-5 o 2-3-4-5-6)

  Tris (punteggio dato dalla somma di tutti i dadi):
  quando 3 dei cinque dadi sono uguali. Ad esempio 3-3-3-5-2 vale 16.

  Poker (punteggio dato dalla somma di tutti i dadi):
  quando 4 dei 5 dadi sono uguali. Ad esempio 5-5-5-5-1 vale 21.

  Full (25 punti):
  quando ci sono 3 dadi di un tipo e due di un altro. Ad esempio 4-4-4-1-1.

  Yahtzee (50 punti):
  quando si ottengono 5 dadi uguali. Ad esempio 1-1-1-1-1 o 4-4-4-4-4. Se Yahtzee viene ripetuto può essere inserito solo in un'altra combinazione libera con il relativo punteggio.

  Chance (punteggio dato dalla somma dei 5 dadi):
  qualsiasi combinazione ottenuta. Questa è una possibilità da sfruttare quando non si riesce a realizzare nessuna delle combinazioni precedenti o la combinazione realizzata è già stata utilizzata precedentemente. Anche questa combinazione può essere utilizzata una sola volta.

Nota: alcune combinazioni offrono al giocatore la possibilità di scegliere in quale categoria classificarle. Ad esempio, un Full potrebbe essere segnato nelle categorie Full, Tris o Chance.

Scriviamo una funzione che calcola i valori di tutte le combinazioni per un determinato lancio:

;----------------------------------------------
(define (chance? lst)
  (apply + lst))
(chance? '(1 2 4 6 5))
;-> 18
;----------------------------------------------
(define (yahtzee? lst)
  (if (apply = lst) 50 0))
(yahtzee? '(1 1 1 1 1))
;-> 50
(yahtzee? '(1 2 1 1 1))
;-> 0
;----------------------------------------------
(define (poker? lst)
  (if (or (>= (first (count '(1) lst)) 4)
          (>= (first (count '(2) lst)) 4)
          (>= (first (count '(3) lst)) 4)
          (>= (first (count '(4) lst)) 4)
          (>= (first (count '(5) lst)) 4)
          (>= (first (count '(6) lst)) 4))
      (apply + lst)
      0))
(poker? '(1 2 2 2 2))
;-> 9
(poker? '(1 2 2 2 1))
;-> 0
(poker? '(3 4 3 3 3))
;-> 16
(poker? '(1 1 1 1 1))
;-> 5
;----------------------------------------------
(define (tris? lst)
  (if (or (>= (first  (count '(1) lst)) 3)
          (>= (first  (count '(2) lst)) 3)
          (>= (first  (count '(3) lst)) 3)
          (>= (first  (count '(4) lst)) 3)
          (>= (first  (count '(5) lst)) 3)
          (>= (first  (count '(6) lst)) 3))
      (apply + lst)
      0))
(tris? '(4 4 1 1 4))
;-> 14
(tris? '(1 2 2 2 2))
;-> 9
(tris? '(1 2 2 5 1))
;-> 0
(tris? '(3 4 3 3 3))
;-> 16
;----------------------------------------------
(define (full? lst)
  (let (tmp (sort (copy lst)))
    (if (or (and (= (tmp 0) (tmp 1)) (= (tmp 2) (tmp 3) (tmp 4)) (!= (tmp 0) (tmp 4)))
            (and (= (tmp 0) (tmp 1) (tmp 2)) (= (tmp 3) (tmp 4)) (!= (tmp 0) (tmp 4))))
        25
        0)))
(full? '(1 2 1 2 1))
;-> 25
(full? '(1 1 1 1 1))
;-> 0
(full? '(2 3 2 3 1))
;-> 0
(full? '(2 3 2 3 2))
;-> 25
;----------------------------------------------
(define (scala-piccola? lst)
  (let (tmp (sort (copy lst)))
    (if (or (= (count '(1 2 3 4) tmp) '(1 1 1 1))
            (= (count '(2 3 4 5) tmp) '(1 1 1 1))
            (= (count '(3 4 5 6) tmp) '(1 1 1 1)))
        30
        0)))
(scala-piccola? '(1 3 2 4 6))
;-> 30
(scala-piccola? '(1 3 2 4 5))
;-> 30
(scala-piccola? '(6 3 2 4 5))
;-> 30
(scala-piccola? '(1 5 5 3 2))
;-> 0
;----------------------------------------------
;(define (scala-grande? lst)
;  (let (tmp (sort (copy lst)))
;    (if (and (apply < tmp) ; lista strettamente crescente?
;            (= (- (tmp 4) (tmp 0)) 4)) ; differenza primo e ultimo elemento
;        40
;        0)))
;
(define (scala-grande? lst)
  (let (tmp (sort (copy lst)))
    (if (or (= tmp '(1 2 3 4 5)) (= tmp '(2 3 4 5 6)))
        40
        0)))
(scala-grande? '(1 2 3 4 5))
;-> 40
(scala-grande? '(1 5 3 2 4))
;-> 40
(scala-grande? '(2 4 3 6 5))
;-> 40
(scala-grande? '(2 2 3 6 5))
;-> 0
(scala-grande? '(1 3 4 5 6))
;-> 0
(scala-grande? '(2 3 4 5 6))
;-> 40
;----------------------------------------------
(define (dadi? x lst)
  (mul x (first (count (list x) lst))))
(dadi? 1 '(1 2 3 4 1))
;-> 2
(dadi? 2 '(1 2 3 2 3))
;-> 4
(dadi? 5 '(1 2 5 5 5))
;-> 15
(dadi? 3 '(1 2 5 5 5))
;-> 0
;----------------------------------------------
(define (yahtzee lst totale)
  (local (bonus)
    (if (nil? totale)
        (setq bonus 0)
        (setq bonus totale)
    )
    (if (>= (+ (dadi? 1 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 1" (dadi? 1 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 1: " (dadi? 1 lst))))
    (if (>= (+ (dadi? 2 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 2" (dadi? 2 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 2: " (dadi? 2 lst))))
    (if (>= (+ (dadi? 3 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 3" (dadi? 3 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 3: " (dadi? 3 lst))))
    (if (>= (+ (dadi? 4 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 4" (dadi? 4 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 4: " (dadi? 4 lst))))
    (if (>= (+ (dadi? 5 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 5" (dadi? 5 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 5: " (dadi? 5 lst))))
    (if (>= (+ (dadi? 6 lst) bonus) 63)
        (println (format "%-10s%3d%-5s%2d" "Dadi 6" (dadi? 6 lst) "  Bonus: " 35))
        (println (format "%-10s%3d" "Dadi 6: " (dadi? 6 lst))))
    (println (format "%-10s%3d" "Tris: " (tris? lst)))
    (println (format "%-10s%3d" "Poker: " (poker? lst)))
    (println (format "%-10s%3d" "Full: " (full? lst)))
    (println (format "%-10s%3d" "Scaletta: " (scala-piccola? lst)))
    (println (format "%-10s%3d" "Scala: " (scala-grande? lst)))
    (println (format "%-10s%3d" "Yahtzee: " (yahtzee? lst)))
    (println (format "%-10s%3d" "Chance: " (chance? lst)))
  ))

(yahtzee '(1 1 2 2 2) 62)
;-> Dadi 1      2  Bonus: 35
;-> Dadi 2      6  Bonus: 35
;-> Dadi 3:     0
;-> Dadi 4:     0
;-> Dadi 5:     0
;-> Dadi 6:     0
;-> Tris:       8
;-> Poker:      0
;-> Full:      25
;-> Scaletta:   0
;-> Scala:      0
;-> Yahtzee:    0
;-> Chance:     8
(yahtzee '(1 2 3 4 5))
;-> Dadi 1:     1
;-> Dadi 2:     2
;-> Dadi 3:     3
;-> Dadi 4:     4
;-> Dadi 5:     5
;-> Dadi 6:     0
;-> Tris:       0
;-> Poker:      0
;-> Full:       0
;-> Scaletta:  30
;-> Scala:     40
;-> Yahtzee:    0
;-> Chance:    15


------------
Gioco del 15
------------

Il gioco del quindici è un puzzle creato nel 1874 da Noyes Palmer Chapman e reso noto nel 1880 da Samuel Loyd. Il gioco consiste di una tabellina di forma quadrata, solitamente di plastica, divisa in quattro righe e quattro colonne (quindi 16 posizioni), su cui sono posizionate 15 tessere quadrate, numerate progressivamente a partire da 1 fino a 15. Le tessere possono scorrere in orizzontale o verticale, ma il loro spostamento è limitato dall'esistenza di un singolo spazio vuoto. Lo scopo del gioco è riordinare le tessere dopo averle "mescolate" in modo casuale (la posizione da raggiungere è quella con il numero 1 in alto a sinistra e gli altri numeri a seguire da sinistra a destra e dall'alto in basso, fino al 15 seguito dalla casella vuota).

Posizione finale (soluzione) del gioco del 15

  ╔════╦════╦════╦════╗
  ║  1 ║  2 ║  3 ║  4 ║
  ╠════╬════╬════╬════╣
  ║  5 ║  6 ║  7 ║  8 ║
  ╠════╬════╬════╬════╣
  ║  9 ║ 10 ║ 11 ║ 12 ║
  ╠════╬════╬════╬════╣
  ║ 13 ║ 14 ║ 15 ║    ║
  ╚════╩════╩════╩════╝

Il compito è scrivere un programma per giocare al gioco del 15 sul terminale.

Rappresentiamo una posizione del puzzle con una lista dove lo spazio vuoto vale 0 (zero):

(setq pos '((10 2 6 4) (15 0 7 8) (9 1 11 13) (12 14 5 3)))
(setq sol '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 0)))

Prima di tutto scriviamo una funzione che stampa il puzzle:

;(define (print-puzzle grid)
;  (println "+----+----+----+----+")
;  (for (i 0 3)
;    (for (j 0 3)
;      (if (zero? (grid i j))
;          (print "|    ")
;          (print (format "|%3d " (grid i j))))
;    )
;    (println "|")
;    (println "+----+----+----+----+")
;  ))

(define (print-puzzle grid)
  (println "╔════╦════╦════╦════╗")
  (for (i 0 3)
    (for (j 0 3)
      (if (zero? (grid i j))
          (print "║    ")
          (print (format "║%3d " (grid i j))))
    )
    (println "║")
    (if (< i 3)
        (println "╠════╬════╬════╬════╣")
        (println "╚════╩════╩════╩════╝")
    )
  ))

(print-puzzle pos)
;-> ╔════╦════╦════╦════╗
;-> ║ 10 ║  2 ║  6 ║  4 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 15 ║    ║  7 ║  8 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║  1 ║ 11 ║ 13 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 12 ║ 14 ║  5 ║  3 ║
;-> ╚════╩════╩════╩════╝

Poi ci serve una funzione che restituisce le mosse valide partendo da una posizione del puzzle:

Indici della griglia:

  +----+----+----+----+
  | 00 | 01 | 02 | 03 |
  +----+----+----+----+
  | 10 | 11 | 12 | 13 |
  +----+----+----+----+
  | 20 | 21 | 22 | 23 |
  +----+----+----+----+
  | 30 | 31 | 32 | 33 |
  +----+----+----+----+

(define (valid-moves grid)
  ; hard-coded valid moves
  ; based on position of "0"
  (case (ref 0 grid)
    ((0 0) '((0 1) (1 0)))
    ((0 1) '((0 0) (0 2) (1 1)))
    ((0 2) '((0 1) (0 3) (1 2)))
    ((0 3) '((0 2) (1 3)))
    ((1 0) '((0 0) (1 1) (2 0)))
    ((1 1) '((0 1) (1 0) (1 2) (2 1)))
    ((1 2) '((0 2) (1 1) (1 3) (2 2)))
    ((1 3) '((0 3) (1 2) (2 3)))
    ((2 0) '((1 0) (2 1) (3 0)))
    ((2 1) '((1 1) (2 0) (2 2) (3 1)))
    ((2 2) '((1 2) (2 1) (2 3) (3 2)))
    ((2 3) '((1 3) (2 2) (3 3)))
    ((3 0) '((2 0) (3 1)))
    ((3 1) '((2 1) (3 0) (3 2)))
    ((3 2) '((2 2) (3 1) (3 3)))
    ((3 3) '((2 3) (3 2)))
    (true nil)))

(setq g '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 0)))
(valid-moves g)
;-> ((2 3) (3 2))

Adesso abbiamo bisogno di una funzione per verificare se una posizione è la soluzione del puzzle (cioè se il puzzle è stato risolto):

(define (endgame? grid)
  (= grid '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 0))))

Adesso possiamo scrivere la funzione che accetta l'input di una mossa da parte dell'utente:

(define (read-move grid)
  (local (move pos valid row col ok)
    (setq ok nil)
    ; fino a che la mossa non è valida...
    (until ok
      (print "(" num-mosse ") - Numero (1..15): ")
      (setq move (int (read-line)))
      ; accetta solo numeri da 1 a 15
      (while (or (< move 1) (> move 15) (not (integer? move)))
          (print "(" num-mosse ") - Numero (1..15): ")
          (setq move (int (read-line)))
      )
      ; controlla validità mossa
      (setq pos (ref move grid))
      (setq valid (valid-moves grid))
      (if (find pos valid)
          (setq ok true)
          (println "Errore: numero fisso")
      )
    )
    pos))

(print-puzzle pos)
;-> ╔════╦════╦════╦════╗
;-> ║ 10 ║  2 ║  6 ║  4 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 15 ║    ║  7 ║  8 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║  1 ║ 11 ║ 13 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 12 ║ 14 ║  5 ║  3 ║
;-> ╚════╩════╩════╩════╝
(read-move pos)
;-> (0) - Numero (1..15): 10
;-> Errore: numero fisso
;-> (0) - Numero (1..15): 2
;-> (0 1)

Prima di scrivere la parte del programma che gestisce tutto il gioco, dobbiamo creare una posizione di partenza per il puzzle. La prima idea è quella di generare una lista/matrice 4x4 con numeri da 0 a 15 posizionati in modo casuale. Per esempio:

(define (crea-puzzle)
  (explode (randomize '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)) 4))

(print-puzzle (crea-puzzle))
;-> ╔════╦════╦════╦════╗
;-> ║  6 ║ 13 ║ 11 ║  7 ║
;-> ╠════╬════╬════╬════╣
;-> ║  4 ║  1 ║  2 ║ 14 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║ 10 ║ 15 ║  5 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 12 ║    ║  8 ║  3 ║
;-> ╚════╩════╩════╩════╝

Purtroppo non è così semplice perchè il problema è che non tutte le posizioni casuali di partenza sono risolvibili (tralasciamo la dimostrazione matematica). Comunque esiste un algoritmo che permette di determinare se una posizione è risolvibile o meno.

In generale, per una data griglia di dimensione N, un puzzle (N*N - 1) è risolvibile o meno in base alle seguenti regole:

a) Se N è dispari, l'istanza del puzzle è risolvibile se il numero di inversioni è pari nello stato iniziale di input.

b) Se N è pari, l'istanza del puzzle è risolvibile se
  1) lo spazio vuoto (zero) è su una riga pari contando dal basso (penultima, quarto-ultima, ecc.) e il numero di inversioni è dispari
  oppure
  2) lo spazio vuoto si trova su una riga dispari contando dal basso (ultima, terzultima, quintultima, ecc.) e il numero di inversioni è pari

Per tutti gli altri casi, l'istanza del puzzle non è risolvibile.

Cos'è un'inversione?
Se assumiamo che le tessere (numeri) siano scritte in una singola riga (1D Array) invece di essere distribuite in N-file (2D Array), allora una coppia di tessere (a, b) formano un'inversione se a appare prima di b, ma a > b.

Per esempio considerando le tessere scritte in questo modo:

2 1 3 4 5 6 7 8 9 10 11 12 13 14 15 X

allora formano solo una (1) inversione, ovvero (2, 1).

Scriviamo una funzione che calcola il numero di inversioni per una posizione del puzzle:

(define (inversion grid)
  (local (lst inver)
    (setq lst (flat grid))
    ; tolgo lo zero
    (pop lst (ref 0 lst))
    (setq inver 0)
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (if (and (< i j) (> (lst i) (lst j)))
            (++ inver)
        )
      )
    )
    inver))

(inversion '(2 1 3 4 5 6 7 8 9 10 11 12 13 14 15 0))
;-> 1
(inversion '((13 2 10 3) (1 12 8 4) (5 0 9 6) (15 14 11 7)))
;-> 41
(inversion '((6 13 7 10) (8 9 11 0) (15 2 12 5) (14 3 1 4)))
;-> 62
(inversion '((3 9 1 15) (14 11 4 6) (13 0 10 12) (2 7 8 5)))
;-> 56

Adesso scriviamo una funzione che verifica se una posizione del puzzle è risolvibile:

(define (solvable grid)
  (local (zero zero-row zero-col)
    (setq zero (ref 0 grid))
    (setq zero-row (first zero))
    (setq zero-col (last zero))
    (setq inver (inversion grid))
    (if (or (and (even? zero-row) (odd? inver))
            (and (odd? zero-row) (even? inver)))
        true
        nil
    )))

(solvable '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 0)))
;-> true
(solvable '((13 2 10 3) (1 12 8 4) (5 0 9 6) (15 14 11 7)))
;-> true
(solvable '((6 13 7 10) (8 9 11 0) (15 2 12 5) (14 3 1 4)))
;-> true
(solvable '((3 9 1 15) (14 11 4 6) (13 0 10 12) (2 7 8 5)))
;-> nil

Adesso possiamo scrivere la funzione che crea un puzzle valido:

(define (crea-puzzle)
  (local (grid lst ok)
    (setq ok nil)
    (setq lst '(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))
    (until ok
      (setq grid (explode (randomize lst) 4))
      (if (solvable grid)
        (setq ok true)
      )
    )
    grid))

Proviamo a generare un paio di puzzle:

(crea-puzzle)
;-> ((12 0 2 14) (15 5 4 1) (3 9 13 11) (6 8 10 7))
(print-puzzle (crea-puzzle))
;-> ╔════╦════╦════╦════╗
;-> ║  9 ║ 11 ║  2 ║ 15 ║
;-> ╠════╬════╬════╬════╣
;-> ║  8 ║ 12 ║  4 ║ 14 ║
;-> ╠════╬════╬════╬════╣
;-> ║  7 ║  5 ║ 10 ║    ║
;-> ╠════╬════╬════╬════╣
;-> ║  1 ║  3 ║ 13 ║  6 ║
;-> ╚════╩════╩════╩════╝

Un altro metodo di creare una posizione iniziale per il puzzle è il seguente:
1) partendo dalla posizione di soluzione del puzzle
2) generare un predefinito numero di mosse casuali valide

In questo modo la posizione finale è sicuramente risolvibile.

(define (create-puzzle level)
  (local (grid iter valid mossa mossa-row mossa-col zero zero-row zero-col)
    (seed (time-of-day))
    ; posizione iniziale (puzzle risolto)
    (setq grid '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 0)))
    ; numero di iterazioni (mosse casuali)
    (setq iter (* level 10))
    (for (i 0 iter)
      ; trova mosse valide
      (setq valid (valid-moves grid))
      (setq mossa (valid (rand (length valid))))
      (setq mossa-row (first mossa))
      (setq mossa-col (last mossa))
      ; trova posizione dello zero
      (setq zero (ref 0 grid))
      (setq zero-row (first zero))
      (setq zero-col (last zero))
      ; effettua la mossa (scambia le due posizioni)
      (swap (grid zero-row zero-col) (grid mossa-row mossa-col))
    )
    grid))

Con questo metodo possiamo gestire (più o meno) la complessità del puzzle generato, infatti maggiore è il numero dei passi effettuati e più difficile (lunga) sarà la soluzione (generalmente).

Puzzle semplicissimo:

(print-puzzle (create-puzzle 0))
;-> ╔════╦════╦════╦════╗
;-> ║  1 ║  2 ║  3 ║  4 ║
;-> ╠════╬════╬════╬════╣
;-> ║  5 ║  6 ║  7 ║  8 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║ 10 ║ 11 ║ 12 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 13 ║ 14 ║    ║ 15 ║
;-> ╚════╩════╩════╩════╝

Puzzle più complicato
(print-puzzle (create-puzzle 1000))
;-> ╔════╦════╦════╦════╗
;-> ║  9 ║    ║ 11 ║ 10 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 15 ║ 13 ║  3 ║  6 ║
;-> ╠════╬════╬════╬════╣
;-> ║  4 ║ 14 ║  8 ║ 12 ║
;-> ╠════╬════╬════╬════╣
;-> ║  5 ║  2 ║  7 ║  1 ║
;-> ╚════╩════╩════╩════╝

Verifichiamo che i puzzle creati da quest'ultima funzione siano risolvibili:

(solvable (create-puzzle 100))
;-> true
(solvable (create-puzzle 200))
;-> true

Finalmente siamo arrivati ad implementare la funzione finale che gestisce tutto il gioco:

(define (puzzle15 level)
  (local (griglia num-mosse mossa mossa-row mossa-col zero zero-row zero-col end-game)
    (setq end-game nil)
    (setq num-mosse 0)
    ;(setq griglia '((10 2 6 4) (15 0 7 8) (9 1 11 13) (12 14 5 3)))
    (setq griglia (create-puzzle level))
    ;(setq griglia '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 0 15)))
    (println "Puzzle 15")
    (until end-game
      (print-puzzle griglia)
      ; input mossa
      (setq mossa (read-move griglia))
      (println { })
      ; aggiorna numero mosse
      (++ num-mosse)
      ; aggiornamento della griglia (applica mossa)
      (setq mossa-row (first mossa))
      (setq mossa-col (last mossa))
      (setq zero (ref 0 griglia))
      (setq zero-row (first zero))
      (setq zero-col (last zero))
      (swap (griglia zero-row zero-col) (griglia mossa-row mossa-col))
      ; controllo puzzle risolto
      (cond ((endgame? griglia)
              (print-puzzle griglia)
              (println "(" num-mosse ") - Bravo!!!")
              (setq end-game true))
      )
     )))

Iniziamo una partita:

(puzzle15 100)
Puzzle 15
;-> ╔════╦════╦════╦════╗
;-> ║ 10 ║ 12 ║  5 ║  8 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║  3 ║  7 ║  4 ║
;-> ╠════╬════╬════╬════╣
;-> ║ 13 ║    ║  6 ║ 14 ║
;-> ╠════╬════╬════╬════╣
;-> ║  1 ║  2 ║ 15 ║ 11 ║
;-> ╚════╩════╩════╩════╝
;-> (0) - Numero (1..15): 13
;->
;-> ╔════╦════╦════╦════╗
;-> ║ 10 ║ 12 ║  5 ║  8 ║
;-> ╠════╬════╬════╬════╣
;-> ║  9 ║  3 ║  7 ║  4 ║
;-> ╠════╬════╬════╬════╣
;-> ║    ║ 13 ║  6 ║ 14 ║
;-> ╠════╬════╬════╬════╣
;-> ║  1 ║  2 ║ 15 ║ 11 ║
;-> ╚════╩════╩════╩════╝
;-> (1) - Numero (1..15):


-----------
Numeri rari
-----------

I numeri rari sono quei numeri che quando aggiunti o sottratti al suo rovescio danno un quadrato perfetto. In altre parole, i numeri rari sono numeri interi positivi n dove:

  - n è espresso in base dieci
  - r è il contrario di n (cifre decimali)
  - n deve essere non palindromo (n ≠ r)
  - (n + r) è la somma
  - (n-r) è la differenza e deve essere positiva
  - la somma e la differenza devono essere quadrati perfetti

Sequenza OEIS: A035519
65, 621770, 281089082, 2022652202, 2042832002, 868591084757, 872546974178,
872568754178, 6979302951885, 20313693904202, 20313839704202, 20331657922202,
20331875722202, 20333875702202, ...

Funzione che verifica se un numero è un quadrato perfetto:

(define (square? num)
  (local (a)
    (setq a num)
    (while (> (* a a) num)
      (setq a (/ (+ a (/ num a)) 2))
    )
    (= (* a a) num)))

Non utilizziamo i big-integer, quindi possiamo arrivare a trovare solo i primi cinque numeri rari (limite dovuto alla funzione "square?"):

(setq MAX-INT 9223372036854775807)
(> MAX-INT (* 1e10 1e10))
;-> true

Funzione che verifica se un numero è un numero raro:

(define (rare? num)
  (local (rev sum diff)
    (setq rev (int (reverse (string num)) 0 10))
    (setq sum (+ num rev))
    (setq diff (- num rev))
    (cond ((< diff 0) nil)
          ((= num rev) nil)
          ((and (square? diff) (square? sum)) true)
          (true nil))))

(rare? 65)
;-> true

Funzione che calcola i numeri rari fino ad un dato numero:

(define (rare-to num)
  (for (i 10 num)
    (if (rare? i) (println i))))

(time (rare-to 1e6))
;-> 65
;-> 621770
;-> 1809.423

Però questo algoritmo è molto lento:

(time (rare-to 1e8))
;-> 65
;-> 621770
;-> 156984.385

(time (rare-to 1e9))
;-> 65
;-> 621770
;-> 281089082
;-> 2296520.643 ; circa 38 minuti

Proprietà dei numeri rari
-------------------------
Dato un numero ABCD...MNPQ con qualunque numero di cifre:

1) Il valore di A può essere solo 2,4,6,8 (i numeri rari non possono iniziare con una cifra dispari).

2) Se A = 2 allora risulta Q = 2 e B = P.
Se A = 4 allora Q = 0 e B - P = cifra pari positiva o negativa, cioè -8, -6, -4, -2, 0, 2, 4, 6, 8.
Se A = 6 allora Q = 0 o 5 e B - P = cifra dispari positiva o negativa cioè -9, -7, -5, -3, -1, 1, 3, 5, 7, 9.
Se A = 8 allora Q = 2, 3, 7 o 8: se Q = 2 allora B + P = 9, se Q = 3 allora B - P = 7 per B>P e B - P = -3 per B<P e B non può mai essere uguale a P, se Q = 7 allora B + P = 11 per B>1 e B + P = 1 per B<1, se Q = 8 allora B = P.
È chiaro dalla (1) e (2) sopra che se la prima e l'ultima cifra sono uguali, possono essere 2 o 8 e anche la seconda cifra B e P dovranno essere uguali. Anche la differenza tra la prima e l'ultima cifra, ad esempio A-Q di qualsiasi numero raro, può essere solo 0, 1, 4, 5 o 6. Il valore di Q non può mai essere 1, 4, 6, 9.

3) la radice digitale può avere solo i valori 2, 5, 8 o 9.

Le proprietà di cui sopra possono essere riassunte nella seguente forma tabellare:

 +---+-------+------------------------+
 | A |   Q   | B e P                  |
 +---+-------+------------------------+
 | 2 |   2   | B = P                  |
 +---+-------+------------------------+
 | 4 |   0   | |B - P| = pari         |
 +---+-------+------------------------+
 | 6 | 0 o 5 | |B - P| = dispari      |
 +---+-------+------------------------+
 | 8 |   2   | B + P = 9              |
 +---+-------+------------------------+
 | 8 |   3   | B - P = 7 o P - B = 3  |
 +---+-------+------------------------+
 | 8 |   7   | B + P = 11 o B + P = 1 |
 +---+-------+------------------------+
 | 8 |   8   | B = P                  |
 +---+-------+------------------------+

(define (prop num)
  (local (ns A B P Q)
    (setq ns (string num))
    (setq A (int (ns 0)))
    (setq B (int (ns 1)))
    (setq P (int (ns -2)))
    (setq Q (int (ns -1)))
    (cond ((odd? A) nil)
          ((= A 2) (and (= Q 2) (= B P)))
          ((= A 4) (and (= Q 0) (even? (abs (- B P)))))
          ((= A 6) (and (or (= Q 0) (= Q 5)) (odd? (abs (- B P)))))
          ((= A 8) (cond ((= Q 2) (= (+ P B) 9))
                         ((= Q 3) (or (= (- B P) 7) (= (- P B) 3)))
                         ((= Q 7) (or (= (+ B P) 11) (= (+ P B) 1)))
                         ((= Q 8) (= B P))
                         (true nil)
                   )
          )
     )
   ))

Proviamo la funzione sui numeri della sequenza OEIS:

(setq rare '(621770 281089082 2022652202 2042832002 868591084757 872546974178
872568754178 6979302951885 20313693904202 20313839704202 20331657922202
20331875722202 20333875702202))

(map prop rare)
;-> (true true true true true true true true true true true true true)

La funzione "rare?" diventa:

(define (rare? num)
  (if (prop num)
      (local (rev sum diff)
        (setq rev (int (reverse (string num)) 0 10))
        (setq sum (+ num rev))
        (setq diff (- num rev))
        (cond ((< diff 0) nil)
              ((= num rev) nil)
              ((and (square? diff) (square? sum)) true)
              (true nil)
        )
      )
      nil))

(time (rare-to 1e6))
;-> 65
;-> 621770
;-> 1575.227

(time (rare-to 1e8))
;-> 65
;-> 621770
;-> 163324.193

(time (rare-to 1e9))
;-> 65
;-> 621770
;-> 281089082
;-> 1582493.526 ; circa 26 minuti

Vediamo perchè questo algoritmo non è applicabile per grandi numeri (> 1e10).
Un ciclo "for" pulito (senza nessuna istruzione all'interno) fino a 1e10 ha la seguente durata:

(define (test-for n) (for (i 1 n)))
(time (test-for 1e10))
;-> 75291.609 ; 75 secondi

Se all'interno del ciclo inseriamo una sola operazione di addizione, allora il tempo di esecuzione diventa:

(define (test-for2 n) (for (i 1 n) (++ k)))
(time (test-for2 1e10))
;-> 280509.596 ; 280 secondi (4 minuti e 40 secondi)

Il tempo di esecuzione è troppo grande per poter processare qualcosa all'interno del ciclo.
Quindi questo approccio non è applicabile per calcolare i numeri rari con più di 10 cifre.


-------------
Patience Sort
-------------

L'ordinamento della pazienza (patience sort) è un algoritmo di ordinamento che prende il nome da una variante semplificata del gioco di carte della pazienza. Una variante dell'algoritmo calcola in modo efficiente la lunghezza e i valori della più lunga sottosequenza crescente in una data lista.

Il gioco inizia con un mazzo di carte mescolato. Le carte vengono distribuite una alla volta in una sequenza di pile sul tavolo, secondo le seguenti regole:

Inizialmente, non ci sono pile. La prima carta estratta forma una nuova pila composta dalla singola carta.
Ogni carta successiva viene posizionata sulla pila esistente più a sinistra la cui prima carta ha un valore maggiore o uguale al valore della nuova carta, o alla destra di tutte le pile esistenti, formando così una nuova pila.
Quando non ci sono più carte da distribuire, il gioco finisce.

Questo gioco di carte viene trasformato in un algoritmo di ordinamento a due fasi nel modo seguente:
Data una lista di n elementi da un dominio totalmente ordinato, considerare questa lista come una raccolta di carte e simulare il gioco di smistamento della pazienza. Quando il gioco è finito, recuperare la sequenza ordinata raccogliendo ripetutamente la carta minima visibile. In altre parole, eseguire una fusione k-way delle pile, ciascuna delle quali è ordinata internamente.

Algoritmo per trovare la sottosequenza crescente più lunga
Innanzitutto, eseguire l'algoritmo di ordinamento come descritto sopra. Il numero di pile è la lunghezza della sottosequenza più lunga. Ogni volta che una carta viene posizionata in cima a una pila, mettere un puntatore (indietro) sulla carta in cima alla pila precedente (che, per ipotesi, ha un valore inferiore a quello della nuova carta). Alla fine, seguire tutti i puntatori creati dalla prima carta nell'ultima pila per recuperare una sottosequenza decrescente della lunghezza più lunga. Il suo inverso è la sottosequenza crescente più lunga.

Vediamo un'implementazione dell'ordinamento della pazienza:

(define (patience lst)
  (local (pile i j minimo curr-riga len stop out)
  (setq len (length lst))
  (setq conta (array len '(0)))
  (setq pile (array len len '(0)))
  (setq out (array len '(nil)))
  (setq stop nil)
  (for (i 0 (- len 1))
    (setq stop nil)
    (for (j 0 (- len 1) 1 stop)
      (if (or (zero? (conta j)) (and (> (conta j) 0) (>= (pile j (- (conta j) 1)) (lst i))))
        (begin
          (setf (pile j (conta j)) (lst i))
          (++ (conta j))
          ;(println i { } j)
          (setq stop true)
        )
      )
    )
  )
  (setq minimo (pile 0 (- (conta 0) 1)))
  (setq curr-riga 0)
  (for (i 0 (- len 1))
    (for (j 0 (- len 1))
      (if (and (> (conta j) 0) (< (pile j (- (conta j) 1)) minimo))
        (begin
          (setq minimo (pile j (- (conta j) 1)))
          (setq curr-riga j)
        )
      )
    )
    (setf (out i) minimo)
    (-- (conta curr-riga))
    (setq stop nil)
    (for (j 0 (- len 1) 1 stop)
      (if (> (conta j) 0)
        (begin
          (setq minimo (pile j (- (conta j) 1)))
          (setq curr-riga j)
          (setq stop true)
        )
      )
    )
  )
  out))

(patience '(2 4 3 7 9 4 1 3 6 3 2))
;-> (1 2 2 3 3 3 4 4 6 7 9)

(patience (randomize (sequence -10 10)))
;-> (-10 -9 -8 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10)


------------------
Lista degli indici
------------------

Supponiamo di avere una lista annidata e di voler conoscere la struttura della lista. Possiamo scrivere una funzione che elenca tutte le sotto-liste e i relativi elementi:

(define (elements-aux lst)
  (if (null? lst)
      '()
      (cond ((atom? lst)
             (push lst out -1))
            ((list? lst)
             (push lst out -1)
             (println $idx)
             (elements-aux (first lst))
             (elements-aux (rest lst)))
      )
  )
)

(define (elements lst)
  (let (out '())
    (dolist (el lst)
      (elements-aux el)
    )
    out))

(setq a '((1 2) ((2 (3)) (4 4)) (((7)))))

(elements a)
;-> ((1 2)
;->  1
;->  (2)
;->  2
;->  ((2 (3)) (4 4))
;->  (2 (3))
;->  2
;->  ((3))
;->  (3)
;->  3
;->  ((4 4))
;->  (4 4)
;->  4
;->  (4)
;->  4
;->  (((7)))
;->  ((7))
;->  (7)
;->  7)

Però quello che ci interessa non sono i valori, ma tutti gli indici della lista. Allora ho chiesto un aiuto al forum di newLISP (vedi il thread in fondo a questo articolo) e ho ottenuto la seguente funzione che genera la lista di tutti gli indici degli elementi di una lista data:

(define (index-list lst)
  (local (mylist mv)
    (setq mylist '())
    (define (h-index-list lst agg)
      (dolist (x lst)
        (setq mv (append agg (list $idx)))
        (push mv mylist -1)
        (if (list? x)
          (h-index-list x mv)))
      mylist)
  (h-index-list lst '())))

(setq lst '(1 2 3 4 5))
(setq i (index-list lst))
;-> ((0) (1) (2) (3) (4))
(lst (i 0))
;-> 1

(setq a '((1 2) ((2 (3)) (4 4)) (((7)))))
(setq i (index-list a))
;-> ((0) (0 0) (0 1) (1) (1 0) (1 0 0) (1 0 1) (1 0 1 0)
;->  (1 1) (1 1 0) (1 1 1) (2) (2 0) (2 0 0) (2 0 0 0))

Con questa lista di indici possiamo elencare tutti i valori delle sotto-liste e degli elementi della lista originale:

(dolist (el i) (println el { - } (a el)))
;-> (0) - (1 2)
;-> (0 0) - 1
;-> (0 1) - 2
;-> (1) - ((2 (3)) (4 4))
;-> (1 0) - (2 (3))
;-> (1 0 0) - 2
;-> (1 0 1) - (3)
;-> (1 0 1 0) - 3
;-> (1 1) - (4 4)
;-> (1 1 0) - 4
;-> (1 1 1) - 4
;-> (2) - (((7)))
;-> (2 0) - ((7))
;-> (2 0 0) - (7)
;-> (2 0 0 0) - 7
;-> (1 2)
;-> 1
;-> 2
;-> ((2 (3)) (4 4))
;-> (2 (3))
;-> 2
;-> (3)
;-> 3
;-> (4 4)
;-> 4
;-> 4
;-> (((7)))
;-> ((7))
;-> (7)
;-> 7

Quando creiamo una struttura dati con le liste creiamo spesso una struttura annidata, ad esempio supponiamo di voler memorizzare in una lista la seguente struttura-dati (uno studente e l'elenco degli esami superati):

Studente
--------
Identificativo: (nome cognome matricola)
Esami: (materia (voto-orale voto-scritto) professore)

Una lista che rappresenta la struttura sopra può essere la seguente:

alunno = ((nome cognome matricola) ((materia (voto-orale voto-scritto) professore)))

Per esempio:

(setq a1 '((mario rossi 7112) ((matematica (6 6) A) (storia (7 8) B) (scienze (5 5) A))))
;-> ((mario rossi 7112) ((matematica (6 6) A) (storia (7 8) B) (scienze (5 5) A)))

Adesso possiamo visualizzare le associazioni tra indici della lista e valori corrispondenti:

(setq i (index-list a1))
(dolist (el i) (println el { - } (a1 el)))
;-> (0) - (mario rossi 7112)
;-> (0 0) - mario
;-> (0 1) - rossi
;-> (0 2) - 7112
;-> (1) - ((matematica (6 6) A) (storia (7 8) B) (scienze (5 5) A))
;-> (1 0) - (matematica (6 6) A)
;-> (1 0 0) - matematica
;-> (1 0 1) - (6 6)
;-> (1 0 1 0) - 6
;-> (1 0 1 1) - 6
;-> (1 0 2) - A
;-> (1 1) - (storia (7 8) B)
;-> (1 1 0) - storia
;-> (1 1 1) - (7 8)
;-> (1 1 1 0) - 7
;-> (1 1 1 1) - 8
;-> (1 1 2) - B
;-> (1 2) - (scienze (5 5) A)
;-> (1 2 0) - scienze
;-> (1 2 1) - (5 5)
;-> (1 2 1 0) - 5
;-> (1 2 1 1) - 5
;-> (1 2 2) - A

In questo modo è molto più semplice gestire gli accessi alla nostra lista/struttura.

Ecco il thread originale del forum di newLISP:

List of indexes
---------------
Post by cameyo » Wed May 12, 2021 1:36 pm

How to create a list of indexes of all the elements of original list?
Example:
(setq lst '(1 (2 (3 4)) (5 6)))
(lst 0)
;-> 1
(lst 1)
;-> (2 (3 4))
(lst 1 0)
;-> 2
(lst 1 1)
;-> (3 4)
(lst 1 1 0)
;-> 3
(lst 1 1 1)
;-> 4
(lst 2)
;-> (5 6)
(lst 2 0)
;-> 5
(lst 2 1)
;-> 6

List of indexes:
((0) (1) (1 0) (1 1) (1 1 0) (1 1 1) (2) (2 0) (2 1))
or
(0 1 (1 0) (1 1) (1 1 0) (1 1 1) 2 (2 0) (2 1))
------------------------------------------------------------
Re: List of indexes
Post by fdb » Wed May 12, 2021 7:04 pm

Something like below? (not very elegant, I know)

(define (index-list lst)
  (setq mylist '())
  (define (h-index-list lst agg)
    (dolist (x lst)
      (setq mv (append agg (list $idx)))
      (push mv mylist -1)
      (if (list? x)
        (h-index-list x mv)))
    mylist)
  (h-index-list lst '()))
------------------------------------------------------------
Re: List of indexes
Post by rickyboy » Wed May 12, 2021 8:12 pm

Here's a version that uses recursive calls in a classic way (think, SICP) where even the loop is handled by recursive call. (Nota bene: This is not a good newLISP implementation because newLISP doesn't turn tail calls into loops. fdb's implementation is the better one for newLISP.)

(define (get-indices L (child 0) (parents '()) (result '()))
  (if (empty? L)
      result
      (list? (L 0))
      (get-indices (1 L) (+ 1 child) parents
                   (append (snoc result (snoc parents child))
                           (get-indices (L 0) 0 (snoc parents child))))
      (get-indices (1 L) (+ 1 child) parents
                   (snoc result (snoc parents child)))))

You will need this utility function, snoc, which acts like cons but does the reverse (it says it in the name lol :) : it takes the element argument and puts it at the end of the list. (Note also that the arguments are reversed as compared with cons.)

(define (snoc xs x) (push x xs -1))

(λx. x x) (λx. x x)
------------------------------------------------------------
Re: List of indexes
Post by rickyboy » Wed May 12, 2021 8:13 pm

You could also "factor out" the repeated code, but it may not make the code more readable.

(define (get-indices L (child 0) (parents '()) (result '()))
  (if (empty? L)
      result
      (get-indices (1 L) (+ 1 child) parents
        (append
          (snoc result (snoc parents child))
          (if (list? (L 0))
              (get-indices (L 0) 0 (snoc parents child))
              '())))))

(λx. x x) (λx. x x)
------------------------------------------------------------
Re: List of indexes
Post by cameyo » Wed May 12, 2021 8:38 pm

Thank you guys
Very nice solutions
------------------------------------------------------------


------------------
Buche sulle strada
------------------

Una macchina può riparare con una sezione tutte le buche lungo una strada fino a 3 unità di lunghezza. Un'unità di strada sarà rappresentata da un punto in una stringa. Ad esempio, "..." è una sezione di 3 unità di strada di lunghezza. Le buche sono contrassegnate con una "X" sulla strada e contano come 1 unità di lunghezza. Scrivere una funzione che, data una strada di lunghezza N, restituisce il minor numero possibile di sezioni che la macchina deve effettuare per riparare tutta la strada. Ecco alcuni esempi:

  strada       sezioni minime necessarie
  .X.          1
  .X ... X     2
  XXX.XXXX     3
  .X.XX.XX.X   3

(define (asfalta str)
  (local (idx len out)
    (setq out 0)
    (setq idx 0)
    (setq len (length str))
    (while (> len idx)
      (cond ((= (str idx) ".")
             (++ idx))
            ((= (str idx) "X")
             (setq idx (+ idx 3))
             (++ out))
      )
    )
    out))

(asfalta "...X..XX")
;-> 2
(asfalta "...X..X.X")
;-> 2
(asfalta "...X..X.X.")
;-> 2
(asfalta "...X..X..X.")
;-> 3
(asfalta "...X..X..X..")
;-> 3
(asfalta "...X..X..X...")
;-> 3
(asfalta "...X..X...X.")
;-> 3
(asfalta "...X..X...X..")
;-> 3
(asfalta "...X..X...X.")
;-> 3
(asfalta "...X..X...X")
;-> 3
(asfalta "XX.XX.XX.X")
;-> 4


----------------------
Storia delle variabili
----------------------

Qualche volta abbiamo bisogno di conoscere la storia di una o più variabili durante o dopo l'esecuzione di un programma. La soluzione seguente è valida solo per variabili di tipo numerico (ed è non molto elegante).

Per definire la variabile da storicizzare usiamo la funzione "storia":

(define (storia var-str val)
  (set (sym var-str) val)
  (set (sym (extend var-str "@")) (list val))
  val
)

Questa funzione prende il nome della variabile (passata come stringa) e il valore iniziale della variabile. Per esempio:

(storia "a" 1)
;-> 1

La funzione definisce anche una variabile globale di tipo lista denominata var-str"@" che contiene i valori sorici della variabile var-str:

a@
;-> (1)

Per aggiornare la variabile nel programma dobbiamo usare una funzione specifica "aggiorna"

(define (aggiorna var-str val)
  (local (expr log-var)
    (setq expr (string "(setq " var-str " " val")"))
    (eval-string expr)
    (setq log-var (string var-str "@"))
    (setq expr (string "(push " val " " log-var " -1)"))
    (eval-string expr)
    val
  ))

Anche questa funzione prende il nome della variabile (passata come stringa) e il valore da assegnare lla variabile. Per esempio:

(aggiorna "a" (add a 18 2))
;-> 21
a@
;-> (1 21)
(aggiorna "a" (add a a 2))
;-> 44
a@
;-> (1 21 44)

Nota: la lista a@ (var-str"@") è una variabile/simbolo globale.

L'implementazione può essere migliorata con delle macro per permettere la storicizzazione anche di stringhe e liste. Inoltre dovrebbe essere creato un contesto apposito, ma per le mie necessità è sufficiente.


----------------
Numeri di Chowla
----------------

Il numero di Chowla di un intero positivo n è definito come la somma dei divisori di n escludendo l'unità (1) e n.
La sequenza prende il nome dala matematico indiano Sarvadaman Chowla (1907-1995).

Sequenza OEIS A048050:
0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21, 10, 13, 0, ...

Funzione che calcola la fattorizzazione di un numero:

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

Funzione che calcola la somma dei divisori di un numero:

(define (divisors-sum num)
  (local (sum out)
    (if (= num 1) '1
        (begin
          (setq out 1)
          (setq lst (factor-group num))
          (dolist (el lst)
            (setq sum 0)
            (for (i 0 (last el))
              (setq sum (+ sum (pow (first el) i)))
            )
            (setq out (* out sum)))))))

Funzione che calcola il numero di Chowla per un dato numero:

(define (chowla num)
  (if (= num 1)
      0
      (- (divisors-sum num) num 1)))

Vediamo se otteniamo la stessa sequenza OEIS:

(map chowla (sequence 1 20))
;-> (0 0 0 2 0 5 0 6 3 7 0 15 0 9 8 14 0 20 0 21)


------------------
Secondi -> periodo
------------------

Scrivere una funzione che accetta in ingresso un numero intero positivo che rappresenta una durata in secondi e   restituisce una stringa che mostra la stessa durata scomposta in settimane, giorni, ore, minuti e secondi.
Per esempio:

  Secondi     Output
  7259        2h 59s
  86400       1d
  6000000     9wk 6d 10h 40m

Devono essere utilizzate le seguenti cinque unità:

  Unità              Codice    Conversione
  week (settimana)    w        1 week = 7 days
  day (giorno)        d        1 day = 24 hours
  hour (ora)          h        1 hour = 60 minutes
  minute (minuto)     m        1 minutes = 60 secondi
  second (secondo)    s        1 secondo = 1 secondo

Tuttavia, includere nell'output solo quantità con valori diversi da zero (ad esempio, restituire "1d" e non "0wk 1d, 0h 0m 0s").

Utilizziamo la seguente lista per memorizzare i codici e l'espressione di conversione:

(setq conv '(("w" (* 7 24 60 60 1))
             ("d"   (* 24 60 60 1))
             ("h"      (* 60 60 1))
             ("m"         (* 60 1))
             ("s"               1)))

La funzione è la seguente:

(define (periodo sec)
  (local (name expr val)
    (dolist (el conv)
      (setq name (el 0))
      (setq expr (eval (el 1)))
      ; valore della corrente unità
      (setq val (/ sec expr))
      ; numero di secondi rimasti
      ; (resto della divisione)
      (setq sec (% sec expr))
      (if (> val 0)
        (print val name " ")
      )
    )
    (println)))

Verifichiamo i risultati deglki esempi:

(periodo 7259)
;-> 2h 59s
(periodo 86400)
;-> 1d
(periodo 6000000)
;-> 9wk 6d 10h 40m
(periodo 12000)
;-> 3h 20m

Adesso scriviamo una funzione che converte i millisecondi in un periodo (può servire per convertire l'output della funzione "time"). Utilizziamo i seguenti valori di conversione (senza week):

(setq conv '(("d"   (* 24 60 60 1000))
             ("h"      (* 60 60 1000))
             ("m"         (* 60 1000))
             ("s"         (*  1 1000))
             ("ms"                 1)))

(define (period msec show)
  (local (conv unit expr val out)
    (setq conv '(("d" 86400000) ("h" 3600000) ("m" 60000) ("s" 1000) ("ms" 1)))
    (setq out '())
    (setq msec (int msec))
    (dolist (el conv)
      (setq unit (el 0))
      (setq expr (el 1))
      (setq val (/ msec expr))
      ; numero di millisecondi rimasti
      ; (resto della divisione)
      (setq msec (% msec expr))
      (push val out -1)
      (if (and (> val 0) show)
        (print val unit " ")
      )
    )
    (if show (println))
    out))

(period 1000 true)
;-> 1s
;-> (0 0 0 1 0)
(period 1184567 true)
;-> 19m 44s 567ms
;-> (0 0 19 44 567)
(period 163458000)
;-> (1 21 24 18 0)


-----------------------------------------------------
Partizione di una lista in due parti con somme uguali
-----------------------------------------------------

Determinare se è possibile partizionare una lista in due sotto-liste in modo che la somma di ogni sotto-lista sia la stessa. Per esempio, la lista di numeri A = (7 5 6 11 3 4) può essere divisa in due sotto-liste con la stessa somma (18) in due modi diversi:

a) (5 6 7) e (11 3 4)

b) (3 4 5 6) e (11 7)

Supponendo che la somma di tutti gli elementi della lista sia S, ciò implica che le due sotto-liste devono avere una somma uguale a S/2. Quidi se la somma di tutti gli elementi della lista è dispari, allora non è possibile suddividere la lista in due parti con somma uguale.

Se la somma degli elementi è pari, allora possiamo utilizzare due metodi per provare a suddividere la lista: brute-force e programmazione dinamica.

Metodo Brute-force
------------------
Questo è un metodo ricorsivo in cui consideriamo ogni possibile sottoinsieme della lista e controlliamo se la sua somma è uguale o meno alla somma totale S/2, eliminando l'ultimo elemento della lista ad ogni turno.
L'algoritmo è il seguente:
  1) Per ogni ricorsione del metodo, dividi il problema in due sottoproblemi in modo che:
    1.1) Creare un nuovo sottoinsieme della lista includendo l'ultimo elemento della lista se il suo valore non supera S/2 e ripetere il passaggio ricorsivo 1 di nuovo per il nuovo sottoinsieme.
    1.2) Creare un nuovo sottoinsieme della lista escludendo l'ultimo elemento della lista e ripetire il passaggio ricorsivo 2 di nuovo per il nuovo sottoinsieme.
    1.3) Se la somma di uno qualsiasi dei sottoinsiemi precedenti è uguale a S/2, restiture true altrimenti restituire nil (false).
  2) Se uno qualsiasi dei problemi di cui sopra restituisce true, restituire true, altrimenti restituire nil.

Implementazione metodo brute force:

(define (partition? lst)
  (let (sum (apply + lst))
    (cond ((odd? sum) nil)
          (true (subset lst (length lst) (/ sum 2))))))

(define (subset lst len sum)
  (catch
  (local (tmp)
    (if (zero? sum) (throw true))
    (if (and (zero? len) (!= sum 0)) (throw nil))
    (if (> (lst (- len 1)) sum)
        (throw (subset lst (- len 1) sum))
    )
    (or (subset lst (- len 1) sum) (subset lst (- len 1) (- sum (lst (- len 1))))))))

(partition? '(7 5 6 11 3 4))
;-> true
(partition? '(1 2 3 4 6 12))
;-> true
(partition? '(3 1 4 4))
;-> nil
(partition? '(6 4 3 2 3))
;-> true
(partition? '(6 -4 -3 2 3))
;-> true

La complessità temporale del caso peggiore vale O(2^n), dove n è il numero totale di elementi della lista.
La complessità spaziale vale O(n), che viene utilizzata per memorizzare lo stack della ricorsione.

Programmazione dinamica
-----------------------
Utilizzando la programmazione dinamica memorizziamo le valutazioni di ogni passaggio ricorsivo e riutilizziamo questi  valori qualora dovessimo ricalcolarli di nuovo nei passaggi futuri.

  Chi non ricorda il passato è condannato a ripeterlo.
  - Programmazione dinamica

In questo caso, creiamo una lista bidimensionale di elementi booleani che rappresentano vero (true) o falso (nil) a seconda che si possa creare un sottoinsieme avente somma uguale alla riga e con gli elementi di questo sottoinsieme rappresentati nella colonna. Decidiamo se aggiungere o meno un elemento nel sottoinsieme a seconda che il suo valore sia minore o meno della somma. Riempiamo la lista in modo bottom-up fino a raggiungere l'ultimo elemento dell'array, che sarà la risposta finale.

L'algoritmo è il seguente:
1) Per ogni elemento i nell'array e il valore di somma s (incrementato fino a raggiungere il valore S / 2),
  1.1) Controllare se il sottoinsieme con somma uguale a s può essere formato escludendo l'elemento i.
  1.2) Verificare la condizione che il valore dell'elemento sia inferiore a s,
      1.2.1) Se la condizione di cui sopra è vera, controlla se il sottoinsieme con somma uguale a s può essere formato includendo l'elemento i.
  1.3) Se una qualsiasi delle condizioni di cui sopra è vera, allora memorizzare vero (true) nel valore della lista in i-esima riga e s-esima colonna, cioè possiamo formare il sottoinsieme di elementi con somma uguale a s.

(define (partition? lst)
  (local (sum len dp)
    (setq len (length lst))
    (setq sum (apply + lst))
    (cond ((odd? sum) nil)
          (true
           (let (s (/ sum 2))
            (setq dp (array (+ len 1) (+ s 1) '(nil)))
            (for (i 0 len)
              (setf (dp i 0) true)
            )
            (for (i 1 len)
              (for (j 1 s)
                (setf (dp i j) (dp (- i 1) j))
                (if (>= j (lst (- i 1)))
                    (setf (dp i j) (or (dp i j) (dp (- i 1) (- j (lst (- i 1))))))
                )
              )
            )
            (dp len s))
          ))))

(partition? '(7 5 6 11 3 4))
;-> true
(partition? '(1 2 3 4 6 12))
;-> true
(partition? '(3 1 4 4))
;-> nil
(partition? '(6 4 3 2 3))
;-> true

La complessità temporale del caso peggiore vale O(n*s), dove n è il numero totale di elementi della lista e s è il valore della somma di tutti gli elementi della lista.
La complessità spaziale vale O(n*s), che viene utilizzata per memorizzare la matrice di tutti i sottoinsiemi con le relative somme.

Nota: l'algoritmo che usa la programmazione dinamica è molto più veloce dell'algoritmo brute-force, ma non funziona con liste che hanno numeri negativi. Per esempio:

(partition? '(6 -4 -3 2 3))
;-> ERR: array index out of bounds : 5

Nota: il problema della partizione è indicato come un problema NP-completo in informatica e la soluzione di cui sopra è una soluzione di programmazione dinamica in tempo pseudo-polinomiale. Viene anche definito "il problema difficile più semplice".


-------------------
Numeri di Zumkeller
-------------------
I numeri Zumkeller sono l'insieme di numeri i cui divisori possono essere partizionati in due insiemi disgiunti che si sommano allo stesso valore. Ogni somma deve contenere valori di divisori che non sono nell'altra somma e tutti i divisori devono essere nell'una o nell'altra. Non ci sono restrizioni sul modo in cui i divisori devono essere partizionati, solo che le somme delle due partizione devono essere sono uguali.
Per esempio:
6 è un numero Zumkeller: i divisori (1 2 3 6) possono essere partizionati in due gruppi (1 2 3) e (6) che sommano entrambi a 6.
10 non è un numero Zumkeller: i divisori (1 2 5 10) non possono essere suddivisi in due gruppi in alcun modo che sommino entrambi allo stesso valore.
12 è un numero Zumkeller: i divisori (1 2 3 4 6 12) possono essere partizionati in due gruppi (1 3 4 6) e (2 12) che sommano entrambi a 14.

I numeri pari di Zumkeller sono comuni mentre i numeri dispari di Zumkeller lo sono molto meno. Per valori inferiori a  un milione (10^6), c'è almeno un numero Zumkeller ogni 12 numeri interi consecutivi e la stragrande maggioranza di essi è pari.

Sequenza OEIS A083207:
  6, 12, 20, 24, 28, 30, 40, 42, 48, 54, 56, 60, 66, 70, 78, 80, 84,
  88, 90, 96, 102, 104, 108, 112, 114, 120, 126, 132, 138, 140, 150,
  156, 160, 168, 174, 176, 180, 186, 192, 198, 204, 208, 210, 216,
  220, 222, 224, 228, 234, 240, 246, 252, 258, 260, 264, 270, 272, ...

Funzione che calcola tutti i divisori di un numero:

(define (divisors num)
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; funzione ausiliaria
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

Funzione che fattorizza un numero:

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

Funzione che verifica se una lista può essere partizionata in due sotto-liste con somma uguale:

(define (partition? lst)
  (local (sum len dp)
    (setq len (length lst))
    (setq sum (apply + lst))
    (cond ((odd? sum) nil)
          (true
           (let (s (/ sum 2))
            (setq dp (array (+ len 1) (+ s 1) '(nil)))
            (for (i 0 len)
              (setf (dp i 0) true)
            )
            (for (i 1 len)
              (for (j 1 s)
                (setf (dp i j) (dp (- i 1) j))
                (if (>= j (lst (- i 1)))
                    (setf (dp i j) (or (dp i j) (dp (- i 1) (- j (lst (- i 1))))))
                )
              )
            )
            (dp len s))
          ))))

Funzione che verifica se un dato numero è un numero di Zumkeller:

(define (zumkeller? num)
  (local (divs sum abund)
    (setq divs (divisors num))
    (setq sum (apply + divs))
    (cond ((odd? sum) nil)
          ((odd? num)
           (setq abund (- sum (* 2 num)))
           ; se num è dispari usiamo l'ottimizzazione 'abundant odd number'
           (and (> abund 0) (even? abund)))
          ; se num e sum sono pari, allora verifichiamo la partizione
          (true (partition? divs))
    )))

(zumkeller? 30)
;-> true

Funzione che calcola i numeri di Zumkeller fino ad dato numero:

(define (zumkeller-to num)
  (let (out '())
    (for (i 1 num)
      (if (zumkeller? i)
          (push i out -1)))
    out))

(zumkeller-to 200)
;-> (6 12 20 24 28 30 40 42 48 54 56 60 66 70 78 80
;->  84 88 90 96 102 104 108 112 114 120 126 132 138
;->  140 150 156 160 168 174 176 180 186 192 198)

Calcoliamo i tempi di esecuzione:

(time (zumkeller-to 1000))
;-> 919.568
(time (zumkeller-to 2000))
;-> 4234.699
(time (zumkeller-to 10000))
;-> 137405.41

La funzione non è molto veloce.

Proviamo a vedere come varia la frequenza dei numeri di Zumkeller pari e dispari al crescere di n.

(define (zumkeller-freq num)
  (local (np nd)
    (setq np 0 nd 0)
    (for (i 1 num)
      (if (zumkeller? i)
          (if (odd? i)
              (++ nd)
              (++ np)
          )
      )
    )
    (println (format "%s%6d %5.2f%s %5.2f%s"
    "   pari:" np (mul 100 (div np num)) "%" (mul 100 (div np (+ np nd))) "%"))
    (println (format "%s%6d %5.2f%s %5.2f%s"
    "dispari:" nd (mul 100 (div nd num)) "%" (mul 100 (div nd (+ np nd))) "%"))))

(zumkeller-freq 1000)
;->    pari:   223 22.30% 99.55%
;-> dispari:     1  0.10%  0.45%
(zumkeller-freq 10000)
;->    pari:  2271 22.71% 99.00%
;-> dispari:    23  0.23%  1.00%
(zumkeller-freq 100000)  ; ci vuole molto tempo...
;->    pari: 22843 22.84% 99.10%
;-> dispari:   208  0.21%  0.90%

Vediamo i primi n numeri di Zumkeller dispari che non terminano con 5:

(define (zumkeller-odd num)
  (local (nd)
    (setq nd 0)
    (setq i 1)
    (while (< nd num)
      (if (!= (% i 10) 5)
          (if (zumkeller? i)
              (println (++ nd) { - } i)))
      (++ i 2))))

(zumkeller-odd 100)
;-> 1 - 81081
;-> 2 - 153153
;-> 3 - 171171
;-> 4 - 189189
;-> 5 - 207207
;-> 6 - 223839
;-> 7 - 243243
;-> 8 - 261261
;-> 9 - 279279
;-> 10 - 297297
;-> 11 - 351351
;-> 12 - 459459
;-> ...
;-> 96 - 2963961
;-> 97 - 2980593
;-> 98 - 2999997
;-> 99 - 3054051
;-> 100 - 3072069


------------------
Numeri di Leonardo
------------------

I numeri Leonardo (serie di Leonardo) sono una sequenza di numeri definita da:

  L(0) = 1
  L(1) = 1
  L(n) = L(n-1) + L(n-2) + 1

  dove il + 1 sarà qui noto come il numero di aggiunta.

I numeri di Leonardo sono legati ai numeri di Fibonacci tramite la seguente relazione:

  L(n) = 2 * Fib(n + 1) - 1

I primi numeri di Leonardo (sequenza OEIS A001595) sono i seguenti:

 1 1 3 5 9 15 25 41 67 109 177 287 465 753 1219 1973 3193 5167 8361 ···

Scriviamo una funzione iterativa:

(define (leonardo L0 L1 sum num)
  (local (out tmp)
    (setq out (list L0 L1))
    (for (i 3 num)
      (push (+ L0 L1 sum) out -1)
      (setq tmp L0)
      (setq L0 L1)
      (setq L1 (+ L1 tmp sum))
    )
    out))

(leonardo 1 1 1 20)
;-> (1 1 3 5 9 15 25 41 67 109 177 287 465 753 1219 1973 3193 5167 8361 13529)

Se poniamo L0 = 1, L1 = 1 e sum = 0, allora otteniamo la sequenza di Fibonacci:

(leonardo 0 1 0 20)
;-> (0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181)


-------------------
Frequenza caratteri
-------------------

Aprire un file di testo e contare le occorrenze di ogni lettera.
Contare solo i caratteri ASCII da 32 a 126.

(define (freq-chars nomefile)
  (local (file fr out)
    (setq fr (array 127 '(0)))
    (setq file (open nomefile "read"))
    (while (setq line (read-line file))
      (dostring (ch line)
        ; solo caratteri ASCII (32-126)
        (if (and (>= ch 32) (<= ch 126))
            (++ (fr ch))
        )
      )
    )
    (close file)
    (setq tot (apply + (array-list fr)))
    (println "File: " nomefile)
    (println "Caratteri ASCII: " tot)
    (for (i 32 126)
      (println (format "%s%s%6d%s%5.2f"
                (char i) " - " (fr i) " - " (mul 100 (div (fr i) tot))))
    )
    ))

(freq-chars "newLISP-Note.lsp")
;-> File: newLISP-Note.lsp
;-> Caratteri ASCII: 3229530
;->   - 704059 - 21.80
;-> ! -    715 -  0.02
;-> " -  27572 -  0.85
;-> # -   1297 -  0.04
;-> $ -    527 -  0.02
;-> % -   1337 -  0.04
;-> & -     99 -  0.00
;-> ' -   9170 -  0.28
;-> ( -  96370 -  2.98
;-> ) -  96977 -  3.00
;-> * -   9263 -  0.29
;-> + -   9387 -  0.29
;-> , -  11284 -  0.35
;-> - - 104385 -  3.23
;-> . -  20989 -  0.65
;-> / -   3470 -  0.11
;-> 0 -  44895 -  1.39
;-> 1 -  49245 -  1.52
;-> 2 -  32763 -  1.01
;-> 3 -  23072 -  0.71
;-> 4 -  18349 -  0.57
;-> 5 -  17760 -  0.55
;-> 6 -  15716 -  0.49
;-> 7 -  14520 -  0.45
;-> 8 -  14380 -  0.45
;-> 9 -  16949 -  0.52
;-> : -   9331 -  0.29
;-> ; -  18388 -  0.57
;-> < -   1583 -  0.05
;-> = -  33884 -  1.05
;-> > -  14902 -  0.46
;-> ? -   2671 -  0.08
;-> @ -    234 -  0.01
;-> A -   5516 -  0.17
;-> B -   2827 -  0.09
;-> C -   4489 -  0.14
;-> D -   2802 -  0.09
;-> E -   3595 -  0.11
;-> F -   2358 -  0.07
;-> G -   1224 -  0.04
;-> H -    994 -  0.03
;-> I -   6139 -  0.19
;-> J -    366 -  0.01
;-> K -    512 -  0.02
;-> L -   7557 -  0.23
;-> M -   2586 -  0.08
;-> N -   3564 -  0.11
;-> O -   3135 -  0.10
;-> P -   5643 -  0.17
;-> Q -   1718 -  0.05
;-> R -   2576 -  0.08
;-> S -   5568 -  0.17
;-> T -   2950 -  0.09
;-> U -   1509 -  0.05
;-> V -   1277 -  0.04
;-> W -    611 -  0.02
;-> X -    994 -  0.03
;-> Y -    452 -  0.01
;-> Z -    491 -  0.02
;-> [ -   1353 -  0.04
;-> \ -    924 -  0.03
;-> ] -   1350 -  0.04
;-> ^ -   1167 -  0.04
;-> _ -   1297 -  0.04
;-> ` -     10 -  0.00
;-> a - 147948 -  4.58
;-> b -  20117 -  0.62
;-> c -  61092 -  1.89
;-> d -  62168 -  1.92
;-> e - 202033 -  6.26
;-> f -  31728 -  0.98
;-> g -  26543 -  0.82
;-> h -  18604 -  0.58
;-> i - 176672 -  5.47
;-> j -   1644 -  0.05
;-> k -   4222 -  0.13
;-> l - 104036 -  3.22
;-> m -  59301 -  1.84
;-> n - 131782 -  4.08
;-> o - 139597 -  4.32
;-> p -  50090 -  1.55
;-> q -  14166 -  0.44
;-> r - 109208 -  3.38
;-> s - 100981 -  3.13
;-> t - 127276 -  3.94
;-> u -  62764 -  1.94
;-> v -  22856 -  0.71
;-> w -   6012 -  0.19
;-> x -  11657 -  0.36
;-> y -   8256 -  0.26
;-> z -  19150 -  0.59
;-> { -    677 -  0.02
;-> | -   5120 -  0.16
;-> } -    684 -  0.02
;-> ~ -     49 -  0.00

Da notare che il 3% dei caratteri sono "(" e ")"... sicuramente è un testo che parla di LISP.


----------------
Frequenza parole
----------------

Aprire un file di testo e contare le occorrenze e la frequenza di ogni parola.

Funzione che calcola il numero e la frequenza degli elementi della lista data:

(define (calc-freq lst)
  (local (tot palo conta out)
    ; numero totale degli elementi della lista
    (setq tot (length lst))
    ; (println tot)
    (cond ((= lst '()) '())
          (true
           (setq out '())
           (setq palo (first lst))
           (setq conta 0)
           (dolist (el lst)
              ; se l'elemento è uguale al precedente aumentiamo il suo conteggio
              (if (= el palo) (++ conta)
                  ; altrimenti costruiamo la coppia (conta el) e la aggiungiamo al risultato
                  (begin (push (list conta palo (mul 100 (div conta tot))) out -1)
                         (setq conta 1)
                         (setq palo el)
                  )
              )
           )
           ; aggiungiamo l'ultima tripla di valori
           ;(extend out (list(list conta palo (mul 100 (div conta tot)))))
           (push (list conta palo (mul 100 (div conta tot))) out -1)
          )
    )
    out))

Funzione che calcola il numero e la frequenza delle parole di un file:

(define (freq-words nomefile)
  (local (data)
    ; importa tutte le parole del file in una lista
    (setq data (parse (lower-case (read-file nomefile)) {\W} 0))
    ; toglie le parole nulle ""
    (setq data (clean null? data))
    ; ordina le parole della lista
    (sort data)
    ; calcola il numero e la frequenza delle parole
    (calc-freq data)))

Proviamo la funzione con il romanzo di Conan Doyle "The Sign of Four":

(silent (setq wf (freq-words "sign-of-four.txt")))

Vediamo le prime 10 parole (ordine alfabetico):

(slice wf 0 10)
;-> ((1 "1857" 0.002282375496416671)
;->  (1 "1871" 0.002282375496416671)
;->  (2 "1878" 0.004564750992833341)
;->  (3 "1882" 0.006847126489250011)
;->  (1 "221b" 0.002282375496416671)
;->  (1 "28th" 0.002282375496416671)
;->  (3 "3" 0.006847126489250011)
;->  (1 "340" 0.002282375496416671)
;->  (2 "34th" 0.004564750992833341)
;->  (1 "37" 0.002282375496416671))

Vediamo le ultime 10 parole (ordine alfabetico):

(slice wf -10 10)
;-> ((2 "yonder" 0.004564750992833341)
;->  (543 "you" 1.239329894554252)
;->  (19 "young" 0.04336513443191674)
;->  (107 "your" 0.2442141781165838)
;->  (7 "yours" 0.0159766284749167)
;->  (9 "yourself" 0.02054137946775004)
;->  (2 "yourselves" 0.004564750992833341)
;->  (3 "youth" 0.006847126489250011)
;->  (1 "zigzag" 0.002282375496416671)
;->  (2 "zum" 0.004564750992833341))

Vediamo le 10 parole più frequenti:

(silent (sort wf >))
(slice wf 0 10)
;-> ((2341 "the" 5.343041037111425)
;->  (1237 "i" 2.823298489067422)
;->  (1187 "and" 2.709179714246588)
;->  (1122 "of" 2.560825306979504)
;->  (1095 "a" 2.499201168576254)
;->  (1093 "to" 2.494636417583421)
;->  (697 "it" 1.590815721002419)
;->  (681 "in" 1.554297713059753)
;->  (645 "he" 1.472132195188753)
;->  (631 "that" 1.440178938238919))

Nota: la lista delle frequenze delle parole può servire anche per trovare le parole con errori di ortografia.


------------
Magic 8-Ball
------------

La Magic 8-Ball è una sfera di plastica, simile alla palla da biliardo numero otto, che viene utilizzata per predire il futuro o per chiedere consigli. È stata inventata nel 1950 da Albert Carter e Abe Bookman ed è attualmente prodotta da Mattel. L'utente fa una domanda del tipo si/no alla palla, quindi la gira per rivelare la risposta che compare in una finestra sulla palla. Una Magic 8 Ball standard ha 20 possibili risposte, di cui: 10 risposte affermative, 5 risposte evasive e 5 risposte negative.

Versione inglese:

Affirmative
-----------
- It is Certain.
- It is decidedly so.
- Without a doubt.
- Yes definitely.
- You may rely on it.
- As I see it, yes.
- Most likely.
- Outlook good.
- Yes.
- Signs point to yes.

Non-committal
-------------
- Reply hazy, try again.
- Ask again later.
- Better not tell you now.
- Cannot predict now.
- Concentrate and ask again.

Negative
--------
- Don't count on it.
- My reply is no.
- My sources say no.
- Outlook not so good.
- Very doubtful.

(define (eight-ball)
(catch
  (local (responses question)
    (setq responses
         '("It is certain" "It is decidedly so" "Without a doubt"
           "Yes definitely" "You may rely on it" "As I see it, yes"
           "Most likely" "Outlook good" "Yes" "Signs point to yes"
           "Reply hazy try again" "Ask again later"
           "Better not tell you now" "Cannot predict now"
           "Concentrate and ask again" "Don't count on it"
           "My reply is no" "My sources say no" "Outlook not so good"
           "Very doubtful"))
    (while true
      (println "\nWhat do you want to know?")
      (setq question (read-line))
      (if (= question "exit") (throw 'good-luck))
      (sleep 1000)
      (println (responses (rand 20)))
    ))))

(eight-ball)

;-> What do you want to know?
;-> I'm the best?
;-> Ask again later

;-> What do you want to know?
;-> newLISP?
;-> Yes definitely

;-> What do you want to know?
;-> exit
;-> good-luck

Versione italiana:

Affermative
-----------
- È certo.
- È decisamente così.
- Senza dubbio
- Si, assolutamente
- Puoi contarci.
- Per come la vedo io, sì.
- Molto probabile
- Buone prospettive.
- Si.
- I segni indicano sì.

Evasive
-------
- Risposta confusa, riprova.
- Chiedilo di nuovo più tardi.
- Meglio non dirtelo ora.
- Non posso prevedere adesso.
- Concentrati e chiedi di nuovo.

Negative
--------
- Non contarci.
- La mia risposta è no.
- Le mie fonti dicono di no.
- Prospettive non così buone.
- Molto dubbioso.

(define (otto)
(catch
  (local (responses question)
    (setq responses
        '("È certo" "È decisamente così" "Senza dubbi" "Si, assolutamente"
          "Puoi contarci" "Per come la vedo io, sì" "Molto probabile"
          "Buone prospettive" "Si" "I segni indicano sì"
          "Risposta confusa, riprova" "Chiedilo di nuovo più tardi"
          "Meglio non dirtelo ora" "Non posso prevedere adesso"
          "Concentrati e chiedi di nuovo" "Non contarci"
          "La mia risposta è no" "Le mie fonti dicono di no"
          "Prospettive non così buone" "Molto dubbioso"))
    (while true
      (println "\nChe cosa vuoi sapere?")
      (setq question (read-line))
      (if (= question "esci") (throw 'buona-fortuna))
      (sleep 1000)
      (println (responses (rand 20)))
    ))))

(otto)

;-> Che cosa vuoi sapere?
;-> Torino salvo?
;-> Molto probabile

;-> Che cosa vuoi sapere?
;-> Tanti soldi?
;-> Concentrati e chiedi di nuovo

;-> Che cosa vuoi sapere?
;-> esci
;-> buona-fortuna


-------
I Ching
-------

Scriviamo un programma per generare casualmente uno dei 64 esagrammi degli "I Ching". Per informazioni dettagliate consultare:

"I Ching. Il libro dei mutamenti." a cura di Richard Wilhelm, Traduzione di Veneziani e Ferrara. Editore Adelphi, 1995

Un esagramma è un simbolo costituito da sei linee sovrapposte. Le linee possono essere di 4 tipi:

  1) linea (yin) spezzata mobile:   ■■■■■  ■■■■■∙
  2) linea (yang) intera fissa:     ■■■■■■■■■■■■
  3) linea (yin) spezzata fissa:    ■■■■■  ■■■■■
  4) linea (yang) intera mobile:    ■■■■■■■■■■■■∙

Le linee intere sono linee yang, le linee spezzate sono linee yin. Ciascuna di queste linee può presentarsi sotto due forme: fissa e mobile.

L'esagramma viene costruito generando casualmente sei linee partendo dal basso e proseguendo verso l'alto (cioè la prima linea è quella più in basso, mentre la sesta e ultima linea è quella più in alto). Il numero di esagrammi è pari a 2^6 = 64.

Esempio di esagramma:

  6   ■■■■■  ■■■■■∙
  5   ■■■■■■■■■■■■
  4   ■■■■■  ■■■■■
  3   ■■■■■■■■■■■■∙
  2   ■■■■■■■■■■■■
  1   ■■■■■■■■■■■■

Tradizionalmente la generazione casuale dell'esagramma utilizza due metodi che hanno lo scopo di generare una serie di sei numeri compresi tra 6 e 9 (oppure 1 e 4), che vengono trasformati nelle sei linee dell'esagramma. Adesso possono presentarsi due casi:

1) Se l'esagramma ottenuto non contiene linee mobili, si ricerca semplicemente l'esagramma nel testo dell'I Ching e il responso dell'oracolo sarà dato dal testo generale che accompagna l'esagramma.

2) Se l'esagramma ottenuto contiene linee mobili, esso muterà in un secondo esagramma che viene ricavato dal primo ribaltando le linee mobili nel loro opposto, e cioè:
- la linea (yin) spezzata mobile ■■■■■  ■■■■■∙ diventerà una linea (yang) intera fissa ■■■■■■■■■■■■
- la linea (yang) fissa mobile ■■■■■■■■■■■■∙ diventerà una linea (yin) spezzata fissa ■■■■■  ■■■■■
In questo caso, il responso dell'oracolo sarà dato:
a) dal testo generale del primo esagramma ottenuto (che viene cercato nel testo dell'I CHING senza considerare le linee mobili, cioè come se fosse composto solo da linee fisse)
b) dal testo delle specifiche linee mobili del primo esagramma (contate sempre dal basso verso l'alto)
c) dal testo generale del secondo esagramma ottenuto.

In generale, possiamo dire che il primo esagramma rappresenta la situazione attuale o di partenza, le sue linee mobili rappresentano i mutamenti che si verificheranno entro breve tempo, mentre il secondo esagramma rappresenta il risultato finale (spiegazioni più dettagliate sul modo di interpretare l'oracolo nei vari casi si possono trovare nel libro citato sopra).

I due metodi per generare l'esagramma sono:
1) il metodo delle monete
2) il metodo degli steli di millefoglie

Da un punto di vista del calcolo delle probabilità i due metodi non sono uguali poichè assegnano probabilità differenti al processo di estrazione delle linee. I due metodi non differiscono tanto per il carattere, "Yin" (spezzata) o "Yang" (fissa), delle linee risultanti, quanto piuttosto per il tipo di linea, fissa o mobile. La tabella seguente mostra i valori di probabilità associata ad ogni evento dei due metodi:

  Probabilità delle linee   Monete      Steli
  -----------------------------------------------
  1) linea spezzata mobile    1/8     4/64 = 1/16
  2) linea intera fissa       3/8    20/64 = 5/16
  3) linea spezzata fissa     3/8    28/64 = 7/16
  4) linea intera mobile      1/8    12/64 = 3/16

Il nostro programma genera i due esagrammi (e i relativi numeri) che dovranno essere sottoposti ad interpretazione utilizzandon il libro citato sopra.

Per la rappresentazione degli esagrammi utilizziamo la seguente lista:

(setq lsm "■■■■■  ■■■■■∙") ; yin mobile  -  spezzata mobile
(setq lif "■■■■■■■■■■■■")  ; yang fissa  -  intera fissa
(setq lsf "■■■■■  ■■■■■")  ; yin fissa   -  spezzata fissa
(setq lim "■■■■■■■■■■■■∙") ; yang mobile -  intera mobile

(setq linee '("" "■■■■■  ■■■■■∙" "■■■■■■■■■■■■" "■■■■■  ■■■■■" "■■■■■■■■■■■■∙"))
(setq linee '("" lsm lif lsf lim))

Gli indici e i valori della lista sono:

  1 = "■■■■■  ■■■■■∙"  ;spezzata mobile
  2 = "■■■■■■■■■■■■ "  ;intera fissa
  3 = "■■■■■  ■■■■■ "  ;spezzata fissa
  4 = "■■■■■■■■■■■■∙"  ;intera mobile

Funzione che genera una linea con il metodo della monete (genera un numero da 1 a 4):

(define (linea-monete)
  (let (val (rand 8))
    (cond ((zero? val) 1)
          ((and (>= val 1) (<= val 3)) 2)
          ((and (>= val 4) (<= val 6)) 3)
          ((= val 7) 4))))

(linea-monete)
;-> 3

Controllo correttezza:
(setq f (array 5 '(0)))
(for (i 1 1000000)
  (++ (f (linea-monete))))
f
;-> (0 124759 375367 375260 124614)
(div 3 8)
;-> 0.375
(div 8)
;-> 0.125

Funzione che genera una linea con il metodo degli steli di millefoglie (genera un numero da 1 a 4):

(define (linea-steli)
  (let (val (rand 64))
    (cond ((and (>= val 0) (<= val 3)) 1)
          ((and (>= val 4) (<= val 23)) 2)
          ((and (>= val 24) (<= val 51)) 3)
          ((and (>= val 52) (<= val 63)) 4))))

(linea-steli)
;-> 3

Controllo correttezza:
(setq f (array 5 '(0)))
(for (i 1 1000000)
  (++ (f (linea-steli))))
f
;-> (0 62625 312456 437907 187012)
(div 4 64)
;-> 0.0625
(div 20 64)
;-> 0.3125
(div 28 64)
;-> 0.4375
(div 12 64)
;-> 0.1875

Funzione che genera i due esagrammi che ha come parametro il metodo da utilizzare per generare casualmente le linee (1=monete (default) 2=steli):

(define (ching metodo)
  (local (esagrammi linee linea esa-A esa-AA esa-B num-AA num-B)
    ; metodo da utilizzare (monete = 1 oppure steli = 2)
    (if (and (!= metodo 1) (!= metodo 2)) (setq metodo 1))
    ; rappresentazione dei 64 esagrammi (1..64)
    (setq esagrammi '((0)
        (2 2 2 2 2 2) (3 3 3 3 3 3) (3 2 3 3 3 2) (2 3 3 3 2 3) (3 2 3 2 2 2)
        (2 2 2 3 2 3) (3 3 3 3 2 3) (3 2 3 3 3 3) (2 2 3 2 2 2) (2 2 2 3 2 2)
        (3 3 3 2 2 2) (2 2 2 3 3 3) (2 2 2 2 3 2) (2 3 2 2 2 2) (3 3 3 2 3 3)
        (3 3 2 3 3 3) (3 2 2 3 3 2) (2 3 3 2 2 3) (3 3 3 3 2 2) (2 2 3 3 3 3)
        (2 3 2 3 3 2) (2 3 3 2 3 2) (2 3 3 3 3 3) (3 3 3 3 3 2) (2 2 2 3 3 2)
        (2 3 3 2 2 2) (2 3 3 3 3 2) (3 2 2 2 2 3) (3 2 3 3 2 3) (2 3 2 2 3 2)
        (3 2 2 2 3 3) (3 3 2 2 2 3) (2 2 2 2 3 3) (3 3 2 2 2 2) (2 3 2 3 3 3)
        (3 3 3 2 3 2) (2 2 3 2 3 2) (2 3 2 3 2 2) (3 2 3 2 3 3) (3 3 2 3 2 3)
        (2 3 3 3 2 2) (2 2 3 3 3 2) (3 2 2 2 2 2) (2 2 2 2 2 3) (3 2 2 3 3 3)
        (3 3 3 2 2 3) (3 2 2 3 2 3) (3 2 3 2 2 3) (3 2 2 2 3 2) (2 3 2 2 2 3)
        (3 3 2 3 3 2) (2 3 3 2 3 3) (2 2 3 2 3 3) (3 3 2 3 2 2) (3 3 2 2 3 2)
        (2 3 2 2 3 3) (2 2 3 2 2 3) (3 2 2 3 2 2) (2 2 3 3 2 3) (3 2 3 3 2 2)
        (2 2 3 3 2 2) (3 3 2 2 3 3) (3 2 3 2 3 2) (2 3 2 3 2 3)))
    ; lista dei tipi di linee
    (setq linee '("" "■■■■■  ■■■■■∙" "■■■■■■■■■■■■" "■■■■■  ■■■■■" "■■■■■■■■■■■■∙"))
    ; inizializza il generatore di numeri casuali
    (seed (time-of-day))
    (setq esa-A '())
    (setq esa-B '())
    ; Crea esagrammi A e B
    ; la prima linea è quella più in basso
    ; (l'ultima nelle liste esa-A e esa-B)
    ; la sesta (ultima) linea è quella più in alto
    ; (la prima nelle liste esa-A e esa-B)
    (for (i 1 6)
      (if (= metodo 1)
          (setq linea (linea-monete))
          (setq linea (linea-steli))
      )
      ; esagramma A
      (push linea esa-A)
      ; esagramma B
      (cond ((= linea 1) (push 2 esa-B) (push 3 esa-AA))
            ((= linea 2) (push 2 esa-B) (push 2 esa-AA))
            ((= linea 3) (push 3 esa-B) (push 3 esa-AA))
            ((= linea 4) (push 3 esa-B) (push 2 esa-AA))
      )
    )
    ; Cerca i numeri degli esagrammi AA e B
    (setq num-AA (find esa-AA esagrammi))
    (setq num-B (find esa-B esagrammi))
    ; Stampa degli esagrammi
    (print (format "  %-20d%-20d\n" num-AA num-B))
    (for (i 0 5)
      (print (format "  %-20s%-20s\n" (linee (esa-A i)) (linee (esa-B i))))
    )
  'i-ching))

Proviamo a generare un paio di esagrammi:

(ching 2)
;-> 10                  61
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■
;-> ■■■■■■■■■■■■∙       ■■■■■  ■■■■■
;-> ■■■■■  ■■■■■        ■■■■■  ■■■■■
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■

(ching)
;-> 20                  33
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■
;-> ■■■■■■■■■■■■        ■■■■■■■■■■■■
;-> ■■■■■  ■■■■■∙       ■■■■■■■■■■■■
;-> ■■■■■  ■■■■■∙       ■■■■■■■■■■■■
;-> ■■■■■  ■■■■■        ■■■■■  ■■■■■
;-> ■■■■■  ■■■■■        ■■■■■  ■■■■■


------------
Problema ABC
------------

Data una raccolta di blocchi ABC (simili a quelli che avevamo da bambini). Ci sono venti blocchi con due lettere su ogni blocco. Un alfabeto completo è garantito su tutti i lati dei blocchi.
La raccolta di blocchi è la seguente:

 (B O) (X K) (D Q) (C P) (N A) (G T) (R E) (T G) (Q D) (F S)
 (J W) (H U) (V I) (A N) (O B) (E R) (F S) (L Y) (P C) (Z M)

Scrivire una funzione che accetta una parola (stringa) e determina se la parola può essere scritta con la raccolta di blocchi data. L'unica regola è che una volta che una lettera su un blocco viene utilizzata, quel blocco non può essere riutilizzato.

(setq blocks '(("B" "O") ("X" "K") ("D" "Q") ("C" "P")
               ("N" "A") ("G" "T") ("R" "E") ("T" "G")
               ("Q" "D") ("F" "S") ("J" "W") ("H" "U")
               ("V" "I") ("A" "N") ("O" "B") ("E" "R")
               ("F" "S") ("L" "Y") ("P" "C") ("Z" "M")))

Nota: la descrizione del problema implica (e l'analisi dei blocchi lo conferma) che se una lettera, X, appare su più di un blocco, la lettera abbinata sarà la stessa su tutti i blocchi. Questo rende il problema abbastanza semplice.

(define (possible? word)
(catch
  (local (chars len)
    (setq chars (explode word))
    (setq len (length chars))
    (setq copia blocks)
    (dolist (ch chars)
      (setq idx (ref ch copia))
      (cond ((nil? idx) (throw nil))
            (true
             (pop copia (first idx)))
      )
    )
    true)))

(possible? "A")
;-> true
(possible? "BARK")
;-> true
(possible? "BOOK")
;-> nil
(possible? "TREAT")
: true
(possible? "COMMON")
;-> nil
(possible? "SQUAD")
;-> true
(possible? "CONFUSE")
;-> true


------------------------------------------------
Compressione/Decompressione intervallo di valori
------------------------------------------------

Un formato per esprimere un elenco ordinato di numeri interi consiste nell'utilizzare una lista di elementi che possono contenere un valore o un intervallo (coppia di valori). La coppia di valori ha come valori l'inizio dell'intervallo e la fine dell'intervallo). Per esempio:

Numeri ordinati = 1 2 3 5 7 8 9 11
Lista = ((1 3) (5) (7 9) 11))

La funzione che effettua la compressione consiste in un ciclo che percorre i valori e crea gli intervalli:

(define (compress-range lst)
  (local (out cur)
    (setq out '())
    (setq i 0)
    (while (< i (length lst))
      (setq idx i)
      ; valore inizio intervallo
      (setq a (lst i))
      ; valore fine intervallo
      (setq b (lst i))
      ; finchè il valore successivo è uguale
      ; al valore corrente + 1,
      ; allora aggiorna la fine dell'intervallo
      (while (and (< idx (- (length lst) 1)) (= (+ (lst idx) 1) (lst (+ idx 1))))
        (setq b (lst (+ idx 1)))
        (++ idx)
      )
      ; i valori i e i+1 differiscono...
      ; se primo e ultimo valore sono uguali
      (if (= a b)
          ; inserisce solo un valore
          (push (list a) out -1)
          ;else
          ; invece se l'intervallo vale 2
          ; inserisce due valori
          (if (= (+ a 1) b)
              (begin
                (push (list a) out -1)
                (push (list b) out -1)
              )
              ;else
              ; intervallo > 2
              ; inserisce l'intervallo
              (push (list a b) out -1)
          )
      )
      ; aggiorna indice i
      (setq i (++ idx))
    )
    out))

(compress-range (sequence 1 10))
;-> ((1 10))

(compress-range '(-5 -3 -2 -1 0 1 2 4 6 7 8 11 12 14 15 16 17 18 19 21))
;-> ((-5) (-3 2) (4) (6 8) (11) (12) (14 19) (21))

(compress-range '(0 1 2 4 6 7 8 11 12 14 15 16 17 18 19 20 21 22
                  23 24 25 27 28 29 30 31 32 33 35 36 37 38 39))
;-> ((0 2) (4) (6 8) (11) (12) (14 25) (27 33) (35 39))

In questo caso la sintassi dell'intervallo viene utilizzato solo per ogni intervallo che si espande a più di due valori. Comunque preferisco che l'intervallo valga anche per soli due numeri vicini (es. (11 12) invece che (11) (12)).

(define (compress-range lst)
  (local (out cur)
    (setq out '())
    (setq i 0)
    (while (< i (length lst))
      (setq idx i)
      (setq a (lst i))
      (setq b (lst i))
      (while (and (< idx (- (length lst) 1)) (= (+ (lst idx) 1) (lst (+ idx 1))))
        (setq b (lst (+ idx 1)))
        (++ idx)
      )
      (if (= a b)
          (push (list a) out -1)
      ;else
          (push (list a b) out -1)
      )
      (setq i (++ idx))
    )
    out))

(compress-range (sequence 1 10))
;-> ((1 10))

(compress-range '(0 1 2 4 6 7 8 11 12 14 15 16 17 18 19 20 21 22
                  23 24 25 27 28 29 30 31 32 33 35 36 37 38 39))
;-> ((0 2) (4) (6 8) (11 12) (14 25) (27 33) (35 39))

(compress-range '(-5 -3 -2 -1 0 1 2 4 6 7 8 11 12 14 15 16 17 18 19 21))
;-> ((-5) (-3 2) (4) (6 8) (11 12) (14 19) (21))

Adesso scriviamo la funzione che effettua la decompressione di una lista compressa.

(define (decompress-range lst)
  (local (out)
    (setq out '())
    (dolist (val lst)
      ; se la sottolista è composta da un solo elemento
      (if (= (length val) 1)
          ; allora aggiunge l'elemento alla lista di output
          (push (val 0) out -1)
          ; altrimenti aggiunge tutti i valori del range
          ; definito dai due elementi della sottolista
          (for (i (val 0) (val 1))
            (push i out -1)
          )
      )
    )
    out))

(decompress-range '((1 10)))
;-> (1 2 3 4 5 6 7 8 9 10)

(decompress-range '((0 2) (4) (6 8) (11 12) (14 25) (27 33) (35 39)))
;-> (0 1 2 4 6 7 8 11 12 14 15 16 17 18 19 20 21 22
;->  23 24 25 27 28 29 30 31 32 33 35 36 37 38 39)

(decompress-range (compress-range (extend (sequence 1 5) (sequence 8 12))))
;-> (1 2 3 4 5 8 9 10 11 12)

La funzione di decompressione funziona per entrambe le funzioni di compressione:

(decompress-range '((-3 -1) (2) (3)))
;-> (-3 -2 -1 2 3)


----------------
Plot di funzioni
----------------

Scrivere un programma che stampa una funzione matematica al terminale. I parametri del programma sono:
1) funzione da plottare
2) valore x minimo
3) valore x massimo

Funzione che normalizza una lista di valori:

(define (normalize lst-num val-min val-max)
  (local (hi lo k out)
    (setq out '())
    (setq hi (apply max lst-num))
    (setq lo (apply min lst-num))
    (setq k (div (sub val-max val-min) (sub hi lo)))
    (dolist (val lst-num)
      (push (add val-min (mul (sub val lo) k)) out -1))
    out))

Funzione che stampa la funzione matematica:

(define (plot-function func a b asse-x asse-y)
  (local (xx yy step matrix)
    ; lista per valori x
    (setq xx '())
    ; lista per valori y
    (setq yy '())
    ; numero passi
    (setq step (div (sub b a) asse-x))
    ; calcola valori x,y della funzione
    (for (val a b step)
      (push val xx -1)
      (push (func val) yy -1)
    )
    (setq y-min (apply min yy))
    (setq y-max (apply max yy))
    ; calcola valori normalizzati asse x
    (setq xx (normalize xx 0 asse-x))
    (setq xx (map round xx))
    (setq xx (map int xx))
    ; calcola valori normalizzati asse x
    (setq yy (normalize yy 0 asse-y))
    (setq yy (map round yy))
    (setq yy (map int yy))
    ; crea matrice di stampa
    ; (inserisce "■" nella matrice alle coordinate x y)
    (setq matrix (array (+ asse-y 2) (+ asse-x 2) '(" ")))
    (for (i 0 (- (length xx) 1))
      (setf (matrix (yy i) (xx i)) "■")
    )
    ; stampa valori reali min e max
    (println "x min = " a {  -  } "x max = " b)
    (println "y min = " y-min {  -  } "y max = " y-max)
    ; stampa matrice (funzione)
    ; (alla matrice vengono invertite le righe)
    (dolist (el (reverse (array-list matrix)))
      (println (join el))
    )
  'end))

Vediamo la funzione seno (sin):

(plot-function sin -6.3 6.3 75 20)
;-> x min = -6.3  -  x max = 6.3
;-> y min = -0.9996824042410868  -  y max = 0.9996824042410868
;->
;->         ■■■■                                 ■■■■
;->        ■    ■                               ■    ■■
;->       ■      ■                             ■       ■
;->      ■        ■                           ■
;->     ■          ■                         ■          ■
;->    ■            ■                                    ■
;->                                         ■             ■
;->   ■              ■
;->  ■                                     ■               ■
;->                   ■                   ■
;-> ■                  ■                                    ■                  ■
;->                                      ■                   ■
;->                     ■               ■                                     ■
;->                                                           ■              ■
;->                      ■             ■
;->                       ■                                    ■            ■
;->                        ■          ■                         ■          ■
;->                                  ■                           ■        ■
;->                         ■       ■                             ■      ■
;->                          ■■    ■                               ■    ■
;->                            ■■■■                                 ■■■■

Vediamo una parabola:

(define (g x) (mul x x))

(plot-function g -5 5 60 25)
;-> x min = -5  -  x max = 5
;-> y min = 0  -  y max = 25
;->
;-> ■                                                           ■
;->
;->  ■                                                         ■
;->   ■                                                       ■
;->
;->    ■                                                     ■
;->     ■                                                   ■
;->
;->      ■                                                 ■
;->       ■                                               ■
;->        ■                                             ■
;->
;->         ■                                           ■
;->          ■                                         ■
;->           ■                                       ■
;->            ■                                     ■
;->             ■                                   ■
;->              ■                                 ■
;->               ■                               ■
;->                ■                             ■
;->                 ■■                         ■■
;->                   ■                       ■
;->                    ■■                   ■■
;->                      ■■               ■■
;->                        ■■■         ■■■
;->                           ■■■■■■■■■


Vediamo una funzione polinomiale fratta:

         x^3 + x^2 - 5x
f(x) = ------------------
            x^2 + 1

(define (f x)
  (div (add (mul x x x) (mul x x) (mul -5 x))
       (add (mul x x) 1)))

(plot-function f -4 4 75 20)
;-> x min = -4  -  x max = 4
;-> y min = -1.791478768959859  -  y max = 3.529411764705882
;->
;->                                                                            ■
;->                                                                          ■■
;->                                                                        ■■
;->                                                                      ■■
;->                            ■■■■■                                    ■
;->                          ■■     ■                                 ■■
;->                        ■■        ■                              ■■
;->                      ■■           ■                            ■
;->                     ■              ■                         ■■
;->                   ■■                                        ■
;->                 ■■                  ■                     ■■
;->                ■                                         ■
;->              ■■                      ■                  ■
;->            ■■                                         ■■
;->           ■                           ■              ■
;->         ■■                                          ■
;->       ■■                               ■           ■
;->     ■■                                           ■■
;->   ■■                                    ■       ■
;-> ■■                                       ■    ■■
;->                                           ■■■■

Provare: (plot-function tan -1 1 25 30)

Vedi anche "Grafico di coppie di coordinate" per una versione migliore della funzione "plot".


====================
Spirale di Archimede
====================

Una spirale di Archimede può essere descritta dall'equazione:

r = a + b * theta

dove a e b sono numeri reali.

Disegnare una spirale di Archimede.

(define (spiral)
  (local (xx yy h w a b m r k step matrix)
    (setq xx '() yy '())
    (setq asse-x 60 asse-y 30)
    (setq x-max 0 y-max 0)
    (setq h 96 w 144 a 1 b 1)
    (setq m (mul 8 3.1415926))
    (setq step 0.1)
    (setq matrix (array (+ asse-y 2) (+ asse-x 2) '(" ")))
    (for (t step m)
      (setq r (add a (mul b t)))
      (setq x (add (mul r (cos t)) w))
      (setq y (add (mul r (sin t)) h))
      (push x xx -1)
      (push y yy -1)
    )
    (setq xx (normalize xx 0 asse-x))
    (setq xx (map round xx))
    (setq xx (map int xx))
    ; calcola valori normalizzati asse x
    (setq yy (normalize yy 0 asse-y))
    (setq yy (map round yy))
    (setq yy (map int yy))
    ; Costruisce matrice di stampa
    ; (inserisce un numero crescente nella matrice alle coordinate x y)
    (setq k 1)
    (for (i 0 (- (length xx) 1))
      (setf (matrix (yy i) (xx i)) (string k))
      (++ k)
    )
    ; stampa matrice (funzione)
    ; (alla matrice vengono invertite le righe)
    (dolist (el (reverse (array-list matrix)))
      (println (join el))
    )))

(spiral)
;->
;->                                        21
;->              22
;->
;->                                15
;->
;->
;->              16
;->                            9
;->
;->
;->                                     8       14
;->                  10
;->                            3                         20
;->                        4      2
;-> 23                             1
;->                                      7
;->                         5                                   26
;->         17
;->                  11            6
;->                                           13
;->
;->
;->                             12
;->
;->                                             19
;->
;->                       18
;->
;->              24
;->
;->                                          25


===============
Misure angolari
===============

Gli angoli geometrici vengono misurati utilizzando diverse unità di misura.

Le unità che consideriamo sono le seguenti:

 - grado (degree)
 - gradiante (gradian)
 - mil (mil)
 - radiante (radian)

Le scale tra queste unità angolari sono le seguenti:

  Un giro completo vale 360 gradi (360°).
  - 1 grado è 1/360 di giro
  - 1 gradian è 1/400 di giro
  - 1 mil è 1/6400 di giro
  - 1 radiante è 1/2 * π di giro (o 0,5 / π} di giro)

Oppure, in un altro modo, in un giro completo:
  - ci sono 360 gradi
  - ci sono 400 gradians
  - ci sono 6.400 mil
  - ci sono 2 * π radianti (approssimativamente pari a 6,283 ...)

Un mil è approssimativamente uguale a un milliradiante (che è 1/1000 di radiante).

Scrivere le funzioni di conversione tra tutte le unità di misura.

(setq pi 3.1415926535897931)
;
(define (DegToDeg a) (mod a 360))
(define (GradToGrad a) (mod a 400))
(define (MilToMil a) (mod a 6400))
(define (RadToRad a) (mod a (mul 2 pi)))
;
(define (DegToGrad a) (GradToGrad (mul (div a 360) 400)))
(define (DegToRad a) (RadToRad (mul (div a 360) (mul 2 pi))))
(define (DegToMil a) (MilToMil (mul (div a 360) 6400)))
;
(define (GradToDeg a) (DegToDeg (mul (div a 400) 360)))
(define (GradToRad a) (RadToRad (mul (div a 400) (mul 2 pi))))
(define (GradToMil a) (MilToMil (mul (div a 400) 6400)))
;
(define (MilToDeg a) (DegToDeg (mul (div a 6400) 360)))
(define (MilToGrad a) (GradToGrad (mul (div a 6400) 400)))
(define (MilToRad a) (RadToRad (mul (div a 6400) (mul 2 pi))))
;
(define (RadToDeg a) (DegToDeg (mul (div a (mul 2 pi)) 360)))
(define (RadToGrad a) (GradToGrad (mul (div a (mul 2 pi)) 400)))
(define (RadToMil a) (MilToMil (mul (div a (mul 2 pi)) 6400)))

Funzione che converte un angolo nelle altre unità angolari:

(define (convert-angle a unit)
  (local (out)
    (cond ((= unit "deg")
           (setq grad (DegToGrad a))
           (setq rad (DegToRad a))
           (setq mil (DegToMil a))
           (println a " gradi =")
           (print (format "%7.5f %s\n%7.5f %s\n%7.5f %s\n"
                   grad "grad" rad "rad" mil "mil")))
          ((= unit "grad")
           (setq deg (GradToDeg a))
           (setq rad (GradToRad a))
           (setq mil (GradToMil a))
           (println a " gradianti =")
           (print (format "%7.5f %s\n%7.5f %s\n%7.5f %s\n"
                   deg "deg" rad "rad" mil "mil")))
          ((= unit "rad")
           (setq grad (RadToGrad a))
           (setq deg (RadToDeg a))
           (setq mil (RadToMil a))
           (println a " radianti =")
           (print (format "%7.5f %s\n%7.5f %s\n%7.5f %s\n"
                   grad "grad" deg "deg" mil "mil")))
          ((= unit "mil")
           (setq grad (MilToGrad a))
           (setq deg (MilToDeg a))
           (setq rad (MilToRad a))
           (println a " mil =")
           (print (format "%7.5f %s\n%7.5f %s\n%7.5f %s\n"
                   grad "grad" deg "deg" rad "rad")))
    )
    'end))

(convert-angle 1 "mil")
;-> 1 mil =
;-> 0.06250 grad
;-> 0.05625 deg
;-> 0.00098 rad

(convert-angle 360 "deg")
;-> 360 gradi =
;-> 0.00000 grad
;-> 0.00000 rad
;-> 0.00000 mil


-------------------
Numero di settimane
-------------------

Determinare se un determinato anno ha 52 o 53 settimane.

L'agoritmo per risolvere il problema è il seguente:

p(y) = (y + floor(y/4) - floor(y/100) + floor(y/400)) mod 7

               | 1, if (p(y) = 4 or p(y-1) = 3
week(y) = 52 + |
               | 0, altrimenti

Maggiori informazioni:

Gent, Robert H. "The Mathematics of the ISO 8601 Calendar".
https://webspace.science.uu.nl/~gent0113/calendar/isocalendar.htm

Vediamo l'implementazione delle funzioni:

(define (p y)
  (% (+ y (/ y 4) (- (/ y 100)) (/ y 400)) 7))

(define (weeks year)
  (if (or (= (p year) 4) (= (p (- year 1)) 3))
      53
      52))

(map weeks (sequence 2000 2100 10))
;-> (52 52 53 52 52 52 53 52 52 52 52)

Tutti gli anni con 53 settimane dal 2020 al 2100:

(for (i 2020 2100) (if (= (weeks i) 53) (print i { })))
;-> 2020 2026 2032 2037 2043 2048 2054 2060
;-> 2065 2071 2076 2082 2088 2093 2099


---------------
Il gioco del 21
---------------

21 è un gioco tra due giocatori che si svolge scegliendo un numero (1, 2 o 3) da aggiungere al totale parziale (che parte da 0).

I giocatori si alternano fornendo un numero da aggiungere al totale parziale.

La partita viene vinta dal giocatore il cui numero scelto fa sì che il totale parziale raggiunga esattamente 21.

Scrivere un programma per giocare contro il computer.

Funzione che gestisce il gioco:

(define (game21 player)
  (local (turn totale val)
    (println "21 GAME")
    (setq totale 0)
    (if (or (nil? player) (= player 0))
        (setq turn "Human")
        (setq turn "Computer")
    )
    (while (< totale 21)
      (if (= turn "Human")
          (setq val (human-move))
          ; else
          (setq val (computer-move totale))
      )
      (setq totale (+ totale val))
      (println turn {: } val)
      (println "Totale = " totale)
      (if (< totale 21)
          (if (= turn "Human")
              (setq turn "Computer")
              (setq turn "Human"))
      )
    )
    (println turn " wins!!!")
  'end))

Nota: per calcolare la mossa del computer basta notare che per vincere bisogna raggiungere i valori 5, 9, 13, e 17. In altre parole, bisogna calcolare (totale % 4) e questo rappresenta l'indice della lista di mosse codificate/precalcolate (1 1 3 2).

Funzione che calcola la mossa del computer:

(define (computer-move totale)
  (let (coded '(1 1 3 2))
       (coded (% totale 4))))

Funzione che accetta l'inserimento di un numero (1, 2 o 3) da parte dell'utente:

(define (human-move)
	(print "Numero (1,2,3): ")
	(do-until (and (> input 48)(< input 52)) (setq input (read-key)))
	(println (- input 48)))

Parametri della funzione "game21":

(game21 0) o (game21) --> Inizia a giocare: Human
(game21 1) --> Inizia a giocare: Computer

Facciamo una partita:

(game21 1)
;-> Numero (1,2,3): 3
;-> Human: 3
;-> Totale = 3
;-> Computer: 2
;-> Totale = 5
;-> Numero (1,2,3): 2
;-> Human: 2
;-> Totale = 7
;-> Computer: 2
;-> Totale = 9
;-> Numero (1,2,3): 1
;-> Human: 1
;-> Totale = 10
;-> Computer: 3
;-> Totale = 13
;-> Numero (1,2,3): 3
;-> Human: 3
;-> Totale = 16
;-> Computer: 1
;-> Totale = 17
;-> Numero (1,2,3): 2
;-> Human: 2
;-> Totale = 19
;-> Computer: 2
;-> Totale = 21
;-> Computer wins!!!


------------------------------------
Fattoriale sinistro (Left factorial)
------------------------------------

Il fattoriale di sinistra del numero intero N è definito come segue:

  !N = Sum[k=0, n-1] k!
  !0 = 0

Sequenza OEIS A003422:
  0, 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114, 4037914, 43954714,
  522956314, 6749977114, 93928268314, 1401602636314, 22324392524314,
  378011820620314, 6780385526348314, 128425485935180314,
  2561327494111820314, 53652269665821260314, ...

Scrivere una funzione che calcola il fattoriale di sinistra di un numero N.

Funzione che calcola il fattoriale di un numero:

(define (fact num)
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(fact 0)
;-> 1

Funzione che calcola il fattoriale sinistro di un numero:

(define (fact-left num)
  (if (zero? num)
      0L
      (let (sum 0L)
        (for (i 0 (- num 1))
          (setq sum (+ sum (fact i)))))))

(fact-left 0)
;-> 0L
(fact-left 12)
;-> 43954714L

Vediamo i fattoriali sinistri dei primi 22 numeri (0..21):

(map fact-left (sequence 0 21))
;-> (0L 1L 2L 4L 10L 34L 154L 874L 5914L 46234L 409114L 4037914L
;->  43954714L 522956314L 6749977114L 93928268314L 1401602636314L
;->  22324392524314L 378011820620314L 6780385526348314L
;->  128425485935180314L 2561327494111820314L)

(length (fact-left 1000))
;-> 2565

La funzione produce risultati corretti, ma possiamo renderla più veloce evitando di calcolare ripetutamente il fattoriale. Infatti, basta notare che fact(n) = n*fact(n-1). Allora la funzione può essere riscritta nel modo seguente:

(define (fact-left2 num)
  (if (zero? num)
      0L
      (let (sum 1L fact 1L)
        (for (i 1 (- num 1))
          (setq fact (* fact i))
          (setq sum (+ sum fact))))))

(fact-left2 12)
;-> 43954714L

(map fact-left2 (sequence 0 21))
;-> (0L 1L 2L 4L 10L 34L 154L 874L 5914L 46234L 409114L 4037914L
;->  43954714L 522956314L 6749977114L 93928268314L 1401602636314L
;->  22324392524314L 378011820620314L 6780385526348314L
;->  128425485935180314L 2561327494111820314L)

(length (fact-left2 1000))
;-> 2565

Vediamo la differenza di velocità:

(time (println (length (fact-left 1000))))
;-> 2565
;-> 185.804
(time (println (length (fact-left2 1000))))
;-> 2565
;-> 6.013

La seconda funzione è 30 volte più veloce della prima.

Calcoliamo quante cifre ha il fattoriale sinistro di 10000:

(length (fact-left2 10000))
;-> 35656


-------------------
Numeri primi lunghi
-------------------

I numeri primi lunghi sono numeri primi i cui reciproci (in decimali) hanno una lunghezza del periodo inferiore di uno al numero primo.

Esempio
7 è il primo numero primo lungo, il reciproco di sette è 1/7, che è uguale alla frazione decimale ripetuta 0,142857(142857)...
La lunghezza della parte ripetuta della frazione decimale è sei, (la parte tra parentesi) che è uno in meno del numero primo 7.
Quindi 7 è un numero primo lungo.

Nota: Il 2 non viene considerato un numero primo lungo.

Sequenza OEIS: A001913
  7, 17, 19, 23, 29, 47, 59, 61, 97, 109, 113, 131, 149, 167, 179, 181,
  193, 223, 229, 233, 257, 263, 269, 313, 337, 367, 379, 383, 389, 419,
  433, 461, 487, 491, 499, 503, 509, 541, ...

Funzione che verifica se un numero è primo:

(define (prime? num)
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che genera tutti i numeri primi minori o uguali a un dato numero:

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

(primes-to 50)
;-> (2 3 5 7 11 13 17 19 23 29 31 37 41 43 47)

Funzione che calcola il periodo del reciproco di un numero intero positivo:

(define (find-period num)
    (setq r 1)
    (setq rr 0)
    (setq period 0)
    (for (i 1 (+ num 1))
      (setq r (% (* r 10) num))
    )
    (setq rr r)
    (do-while (!= r rr)
      (setq r (% (* r 10) num))
      (++ period)
    )
    period)

(find-period 7)
;-> 6

(map find-period (sequence 1 10))
;-> (1 1 1 1 1 1 6 1 1 1)

Funzione che verifica se un numero è un primo lungo:

(define (long-prime? num)
  (and (> num 2) (prime? num) (= (find-period num) (- num 1))))

(long-prime? 2)
;-> nil
(long-prime? 499)
;-> true

Funzione che restituisce tutti i numeri primi lunghi fino ad un determinato numero:

(define (long-primes-to num)
  ; elimina il numero 2 dalla lista dei primi
  (let (primi (slice (primes-to num) 1))
    (filter long-p? primi)))

(define (long-p? primo) (= (find-period primo) (- primo 1)))

(long-primes-to 500)
;-> (7 17 19 23 29 47 59 61 97 109 113 131 149 167 179 181
;->  193 223 229 233 257 263 269 313 337 367 379 383 389 419
;->  433 461 487 491 499)

Funzione che calcola il numero di primi lunghi fino ad un determinato numero:

(define (long-primes-to-count num)
  (let ((primi (slice (primes-to num) 1)) (out 0))
    (dolist (p primi)
      (if (long-p? p) (++ out))
    )
    out))

(long-primes-to-count 500)
;-> 35

(time (println (long-primes-to-count 100000)))
;-> 3617
;-> 59944.711 ; 1 minuto

Vediamo quanti primi lunghi ci sono fino a 1 milione:

(time (println (long-primes-to-count 1000000)))
;-> 29500
;-> 5022833.606 ; quasi 84 minuti


----------
Numeri Tau
----------

Un numero Tau è un numero intero positivo divisibile per il numero dei suoi divisori.

Sequenza OEIS A033950:
  1, 2, 8, 9, 12, 18, 24, 36, 40, 56, 60, 72, 80, 84, 88, 96, 104,
  108, 128, 132, 136, 152, 156, 180, 184, 204, 225, 228, 232, 240,
  248, 252, 276, 288, 296, 328, 344, 348, 360, 372, 376, 384, 396,
  424, 441, 444, 448, 450, 468, 472, 480, 488, 492, 504, ...

Funzione che fattorizza un numero intero:

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

(factor-group 36)
;-> ((2 2) (3 2))

Funzione che conta il numero di divisori di un numero intero:

(define (divisors-count num)
  (if (= num 1)
      1
      (let (lst (factor-group num))
        (apply * (map (fn(x) (+ 1 (last x))) lst)))))

(divisors-count 36)
;-> 9

Funzione che verifica se un numero è Tau:

(define (tau? num)
  (zero? (% num (divisors-count num))))

(tau? 8)
;-> true

Funzione che calcola i numeri Tau fino ad un dato numero:

(define (tau-to num)
  (let (out '())
    (for (i 1 num)
      (if (tau? i)
        (push i out -1)))
    out))

Calcoliamo i numeri Tau fino a 500:

(tau-to 500)
;-> (1 2 8 9 12 18 24 36 40 56 60 72 80 84 88 96 104 108 128 132 136
;->  152 156 180 184 204 225 228 232 240 248 252 276 288 296 328 344
;->  348 360 372 376 384 396 424 441 444 448 450 468 472 480 488 492)


--------------------
Sequenza Yellowstone
--------------------

La sequenza di Yellowstone, chiamata anche permutazione di Yellowstone, è definita nel modo seguente

  Per n <= 3: a(n) = n
  Per n > 3:  a(n) = il numero più piccolo non già in sequenza tale che a(n) sia primo relativamente ad a(n-1) e non è relativamente primo ad a(n-2)

Esempio:
a(4) vale 4 perché 4 è il numero più piccolo che segue 1, 2, 3 nella sequenza che è relativamente primo rispetto al numero prima di esso (3), e non è relativamente primo rispetto al numero due posti prima di esso (2).

La sequenza è una permutazione dei numeri naturali.

Sequenza OEIS A098550:
  1, 2, 3, 4, 9, 8, 15, 14, 5, 6, 25, 12, 35, 16, 7, 10, 21, 20, 27, 22,
  39, 11, 13, 33, 26, 45, 28, 51, 32, 17, 18, 85, 24, 55, 34, 65, 36,
  91, 30, 49, 38, 63, 19, 42, 95, 44, 57, 40, 69, 50, 23, 48, 115, 52,
  75, 46, 81, 56, 87, 62, 29, 31, 58, 93, 64, 99, 68, 77, 54, 119, 60, ...

Un altro metodo di definire la sequenza è il seguente:

  Per n <= 3: a(n) = n
  Per n > 3: gcd(a(n), a(n-1)) = 1 e gcd(a(n), a(n-2)) > 1.

Scrivere una funzione che calcola i primi n numeri di yellowstone.
Scrivere una funzione che plotta il grafico dei primi n numeri di yellowstone (con asse-x = n e asse-y = a(n)).

Funzione che calcola la sequenza di Yellowstone:

(define (yellowstone limite)
  (local (ys i j cur-val)
    ; vettore per i valori della sequenza
    (setq ys (array (+ limite 1) '()))
    (setq (ys 0) 0)
    (setq (ys 1) 1)
    (setq (ys 2) 2)
    (setq (ys 3) 3)
    ; ciclo fino
    (for (i 4 limite)
      (setq cur-val 3)
      (setq continua true)
      ; ricerca i-esimo valore
      (while continua
        ; cur-val è il valore di prova per i-esimo valore
        (++ cur-val)
        ; se cur-val non soddisfa le condizioni continuiamo con il ciclo while
        ; per provare cur-val = cur-val + 1
        (cond ((or (= (gcd cur-val (ys (- i 2))) 1) (> (gcd cur-val (ys (- i 1))) 1))
                nil)
              (true
                ; altrimenti cerchiamo se esiste cur-val nella sequenza
                (setq trovato nil)
                (for (j 1 (- i 1) 1 trovato)
                  (if (= (ys j) cur-val) (setq trovato true))
                )
                ; Se cur-val viene trovato, allora non può essere
                ; inserito nella sequenza e continuiamo
                ; con cur-val = cur-val + 1 (ciclo while)
                ; Se cur-val non viene trovato, allora viene inserito nella sequenza
                ; e passiamo al prossimo valore (i = i + 1) (ciclo for)
                (if (not trovato) (begin
                    (setq (ys i) cur-val)
                    (setq continua nil))
                ))
         )
       )
     )
     ;(array-list(slice ys 1))))
     ys))

(yellowstone 30)
;-> (0 1 2 3 4 9 8 15 14 5 6 25 12 35 16 7 10 21
;->  20 27 22 39 11 13 33 26 45 28 51 32 17)

La funzione è abbastanza lenta. Un miglioramento potrebbe essere quella di inserire i valori della sequenza in una hash-map invece che in un vettore, in questo modo la ricerca dei valori nella sequenza sarebbe molto più veloce.

(time (yellowstone 1000))
;-> 2178.186
(time (yellowstone 2000))
;-> 16728.302
(time (yellowstone 4000))
;-> 133255.977
(time (yellowstone 10000))
;-> 2097865.029 ; 35 minuti

Funzione che stampa il grafico della sequenza:

(define (plot-ys limite)
  (local (ys max-row max-col matrix)
    ; calcolo valori della sequenza
    (setq ys (yellowstone limite))
    ; creazione matrice di caratteri (stampa)
    (setq max-row (+ (apply max ys) 2))
    (setq max-col (+ limite 2))
    ;(setq matrix (array (+ limite 2) (+ limite 2) '(" ")))
    (setq matrix (array max-row max-col '(" ")))
    ; inserimento "punti" nella matrice
    ; y = riga della matrice
    ; x = colonna della matrice
    (for (i 0 (- (length ys) 1))
      (setf (matrix (ys i) i) "■")
    )
    ; stampa matrice
    ; (alla matrice vengono invertite le righe)
    (dolist (el (reverse (array-list matrix)))
      (println (join el))
    )))

(plot-ys 30)
;->                            ■
;->
;->
;->
;->
;->
;->                          ■
;->
;->
;->
;->
;->
;->                     ■
;->
;->
;->
;->             ■
;->
;->                        ■
;->                             ■
;->
;->
;->
;->                           ■
;->                   ■
;->                         ■
;->           ■
;->
;->
;->                    ■
;->                 ■
;->                  ■
;->
;->
;->                              ■
;->              ■
;->       ■
;->        ■
;->                       ■
;->            ■
;->                      ■
;->                ■
;->     ■
;->      ■
;->               ■
;->          ■
;->         ■
;->    ■
;->   ■
;->  ■
;-> ■

La sequenza viene chiamata Yellowstone perchè il suo grafico assomiglia al getto di un geyser del parco Yellowstone.


----------------
Distanza di Jaro
----------------

La distanza Jaro è una misura della somiglianza tra due stringhe.
Maggiore è la distanza Jaro per due stringhe, più simili sono le stringhe.
Il punteggio è normalizzato in modo tale che 0 equivale a nessuna somiglianza e 1 è una corrispondenza esatta (le stringhe sono uguali).

La distanza di Jaro dj per due stringhe s1 e s2 vale:

        | 0, se m = 0
  dj =  |
        | 1/3 * (m/|s1| + m/|s2| + (m-t)/m), in tutti gli altri casi

dove:

  m = numero di caratteri corrispondenti
  t = metà del numero di trasposizioni

Due caratteri rispettivamente da s1 e s2 sono considerati corrispondenti solo se sono uguali e non più lontani di floor(max(|s1|,|s2|)/2) - 1.
Ogni carattere di s1 viene confrontato con tutti i suoi caratteri corrispondenti in s2.
Il numero di caratteri corrispondenti (ma con l'ordine di sequenza diverso) diviso per 2 definisce il numero di trasposizioni.

For example, in comparing CRATE with TRACE, only 'R' 'A' 'E' are the matching characters, i.e. m=3. Although 'C', 'T' appear in both strings, they are farther apart than 1 (the result of floor(5/2) - 1). Therefore, t=0 . In DwAyNE versus DuANE the matching letters are already in the same order D-A-N-E, so no transpositions are needed.

Ad esempio, confrontando CRATE con TRACE, solo 'R' 'A' 'E' sono i caratteri corrispondenti, ovvero m = 3. Sebbene 'C', 'T' compaiano in entrambe le stringhe, sono più distanti di 1 (il risultato di floor (5/2) - 1), quindi t = 0. In DwAyNE contro DuANE le lettere corrispondenti sono già nello stesso ordine D-A-N-E, quindi non sono necessarie trasposizioni.

(define (jaro s t)
  (if (and (zero? (length s)) (zero? (length t)))
      1
  (local (len-s len-t)
    (if (> (length s) (length t))
        (swap s t)
    )
    (setq len-s (length s))
    (setq len-t (length t))
    (setq match-dist (- (/ (max len-s len-t) 2) 1))
    (setq s-match (array len-s '(nil)))
    (setq t-match (array len-t '(nil)))
    (setq matches 0)
    (setq transp 0)
    (for (i 0 (- len-s 1))
      (setq start (max 0 (- i match-dist)))
      (setq end (min (+ i match-dist 1) len-t))
      (setq stop nil)
      (for (j start (- end 1) 1 stop)
        (cond ((t-match j) nil)
              ((!= (s i) (t j)) nil)
              (true
                (setf (s-match i) true)
                (setf (t-match j) true)
                (++ matches)
                (setq stop true))
        )
      )
    )
    (cond ((zero? matches) 0)
          (true
            (setq k 0)
            (for (i 0 (- len-s 1))
              (cond ((not (s-match i)) nil)
                    (true
                      (while (not (t-match k))
                        (++ k)
                      )
                      (if (!= (s i) (t k))
                        (++ transp)
                      )
                      (++ k))
              )
            )
            (div (add (div matches len-s)
                      (div matches len-t)
                      (div (sub matches (div transp 2)) matches))
                 3))
    ))))

(jaro "giovanna" "goivanna")
;-> 0.9583333333333334
(jaro "fantastic" "bombastic")
;-> 0.6370370370370371
(jaro "abc" "abc")
;-> 1
(jaro "abc" "ABC")
;-> 0
(jaro "abc" "abcd")
;-> 0.9166666666666666
(jaro "abc" "abcde")
;-> 0.8666666666666667
(jaro "abc" "abcdef")
;-> 0.8333333333333334
(jaro "grattacielo" "palazzo")
;-> 0.5670995670995671
(jaro "newlisp" "abcdefghijklmnopqrstuvwxyz")
;-> 0.4917582417582418
(jaro "common lisp" "abcdefghijklmnopqrstuvwxyz")
;-> 0.532488344988345


-------------------------------------
Pietre e gioielli (Stones and Jewels)
-------------------------------------

Data una stringa in cui i caratteri rappresentano "gioielli" e una stringa in cui i caratteri rappresentano le "pietre". Determinare quante "pietre" sono "gioielli".
I caratteri dei "gioielli" sono tutti diversi.
I caratteri delle "pietre" possono essere uguali.
I caratteri sono solo le lettere dell'alfabeto (minuscole e maiuscole)
I caratteri minuscoli sono diversi da quelli maiuscoli.

In altre parole, vogliamo sapere quanti "gioielli" ci sono nelle "pietre".

(define (pietre-gioielli p g)
  (apply + (count (explode g) (explode p))))

(pietre-gioielli "aAAbbbb" "aA")
;-> 3

(pietre-gioielli "fkjhQD" "aDf")
;-> 2

(pietre-gioielli "fkjhQD" "adF")
;-> 0

--------------
Numeri super-d
--------------

Un numero super-d è un numero intero decimale positivo (in base dieci) n tale che d × nᵈ ha almeno d cifre consecutive d dove

   2 ≤ d ≤ 9

Ad esempio, 753 è un numero super-3 perché 3 × 753³ = 1280873331.

Funzione cha calcola la potenza intera di un numero intero:

(define (pow-i num power)
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))
        )
    )
    out))

Altra funzione cha calcola la potenza intera di un numero intero:

(define (** num power)
    (let (out 1L)
        (dotimes (i power)
            (setq out (* out num)))))

Funzione che calcola i numeri super-d fino ad un dato numero:

(define (super-d d limite)
  (local (test tot num val out)
    (setq test (dup (string d) d))
    (setq tot 0)
    (setq num 0)
    (while (< tot limite)
      (++ num)
      (setq val (* (bigint d) (** num d)))
      ;(setq val (* (bigint d) (pow-i (bigint num) d)))
      (if (find test (string val))
        (begin
          (++ tot)
          (push num out -1)
        )
      )
    )
    out))

Calcoliamo i primi 10 numeri super-d per d da 2 a 9:

(super-d 2 10)
;-> (19 31 69 81 105 106 107 119 127 131)
(super-d 3 10)
;-> (261 462 471 481 558 753 1036 1046 1471 1645)
(super-d 4 10)
;-> (1168 4972 7423 7752 8431 10267 11317 11487 11549 11680)
(super-d 5 10)
;-> (4602 5517 7539 12955 14555 20137 20379 26629 32767 35689)
(time (println (super-d 6 10)))
;-> (27257 272570 302693 323576 364509 502785 513675 537771 676657 678146)
;-> 1609.883
(time (println (super-d 7 10)))
;-> (140997 490996 1184321 1259609 1409970 1783166 1886654 1977538 2457756 2714763)
;-> 7234.281
(time (println (super-d 8 10)))
;-> (185423 641519 1551728 1854230 6415190 12043464 12147605 15517280 16561735 18542300)
;-> 55858.5 ; quasi 56 secondi
(time (println (super-d 9 10)))
;-> (17546133 32613656 93568867 107225764 109255734 113315082
;->  121251742 175461330 180917907 182557181)
;-> 600068.062 ; 10 minuti


----------------------
Algoritmo di Bresenham
----------------------

L'algoritmo di Bresenham è un algoritmo per disegnare linee in una griglia bidimensionale (raster) conoscendo il punto di inizio e di fine della linea. Questo algoritmo è uno dei primi ad essere stato introdotto nel campo della computer grafica e viene comunemente usato per disegnare linee primitive in un'immagine bitmap (es. lo schermo di un computer), poiché utilizza solo addizione, sottrazione e shift di interi. È un algoritmo di errore incrementale che non supporta l'antialiasing, ma è molto veloce. Per un metodo che supporta l'antialiasing vedi l'algoritmo di Wu.

Per informazioni dettagliate vedere:
"Michael Abrash's Graphics Programming Black Book Special Edition"
http://www.phatcode.net/res/224/files/html/index.html

(define (bresenham x0 y0 x1 y1)
  (local (dx dy err x y sx sy out)
    (setq out '())
    (setq dx (abs (- x1 x0)))
    (setq dy (abs (- y1 y0)))
    (set 'x x0 'y y0)
    (if (> x0 x1)
        (setq sx -1)
        (setq sx 1)
    )
    (if (> y0 y1)
        (setq sy -1)
        (setq sy 1)
    )
    (cond ((> dx dy)
            (setq err (div dx 2))
            (while (!= x x1)
              (push (list x y) out -1)
              (setq err (sub err dy))
              (if (< err 0)
                  (set 'y (add y sy) 'err (add err dx))
              )
              (setq x (add x sx))
            ))
          (true
            (setq err (div dy 2))
            (while (!= y y1)
              (push (list x y) out -1)
              (setq err (sub err dx))
              (if (< err 0)
                  (set 'x (add x sx) 'err (add err dy))
              )
              (setq y (add y sy))
            ))
    )
    (push (list x y) out -1)
    out))

(bresenham 1 1 10 6)
;-> ((1 1) (2 2) (3 2) (4 3) (5 3) (6 4) (7 4) (8 5) (9 5) (10 6))

Con la funzione "plot" (vedi il capitolo "Funzioni varie"):
(plot (bresenham 1 1 10 6) 9 5)
;-> x: 1.000        10.000
;-> y: 1.000        6.000
;->
;->           ■
;->         ■■
;->       ■■
;->     ■■
;->   ■■
;->  ■

(bresenham -4 5 10 -12)
;-> ((-4 5) (-3 4) (-2 3) (-2 2) (-1 1) (0 0) (1 -1) (2 -2) (3 -3) (3 -4) (4 -5) (5 -6)
;->  (6 -7) (7 -8) (8 -9) (8 -10) (9 -11) (10 -12))

(plot (bresenham -4 5 10 -12) 14 17)
;-> x: -4.000       10.000
;-> y: -12.000      5.000
;->      ·
;->  ■   ·
;->   ■  ·
;->    ■ ·
;->    ■ ·
;->     ■·
;->  ····O···········
;->      ·■
;->      · ■
;->      ·  ■
;->      ·  ■
;->      ·   ■
;->      ·    ■
;->      ·     ■
;->      ·      ■
;->      ·       ■
;->      ·       ■
;->      ·        ■
;->      ·         ■


------------------------------------------
Associare gli elementi di una lista ogni k
------------------------------------------

Definire una funzione che prende una lista e associa tutti gli elementi ogni k in sottoliste. Restituire la lista delle sottoliste.

(define (glue-k lst k precise)
  (transpose (explode lst k precise)))

(setq lst (sequence 1 16))
(glue-k lst 3)
;-> ((1 4 7 10 13 16) (2 5 8 11 14 nil) (3 6 9 12 15 nil))
(glue-k lst 3 true)
;-> ((1 4 7 10 13) (2 5 8 11 14) (3 6 9 12 15))

(setq lst '(1 1 1 2 2 2 3 3 3 4 4 4))
(glue-k lst 3)
;-> ((1 2 3 4) (1 2 3 4) (1 2 3 4))

(setq lst '(1 1 1 2 2 2 3 3 3))
(glue-k lst 3)
;-> ((1 2 3) (1 2 3) (1 2 3))

(setq lst (sequence 1 8))
(glue-k lst 7)
;-> ((1 8) (2 nil) (3 nil) (4 nil) (5 nil) (6 nil) (7 nil))
(glue-k lst 7 true)
;-> ((1) (2) (3) (4) (5) (6) (7))
(glue-k lst 8)
;-> ((1) (2) (3) (4) (5) (6) (7) (8))
(glue-k lst 8 true)
;-> ((1) (2) (3) (4) (5) (6) (7) (8))
(glue-k lst 9)
;-> ((1) (2) (3) (4) (5) (6) (7) (8))
(glue-k lst 9 true)
;-> ERR: matrix expected : ()

(setq lst '(a b c d e f g h))
(glue-k lst (/ (length lst) 2))
;-> ((a e) (b f) (c g) (d h))
(setq lst '(a b c d e f g h i))
(glue-k lst (/ (length lst) 2))
;-> ((a e i) (b f nil) (c g nil) (d h nil))
(glue-k lst (/ (length lst) 2) true)
;-> ((a e) (b f) (c g) (d h))


-------------------------------
Somma delle potenze delle cifre
-------------------------------

Data un numero intero n con cifre decimali abc...d scrivere una funzione che calcola:

  a(n) = a^a + b^b +...+ d^d

Sequenza OEIS A045503: If decimal expansion of n is ab...d, a(n) = a^a + b^b +...+ d^d.

(define (A045503 num)
  (if (zero? num) 1
    (let ((out 0) (power '(1 1 4 27 256 3125 46656 823543 16777216 387420489)))
      (while (!= num 0)
        (setq out (+ out (power (% num 10))))
        (setq num (/ num 10)))
      out)))

(map A045503 (sequence 0 20))
;-> (1 1 4 27 256 3125 46656 823543 16777216 387420489 2 2
;->  5 28 257 3126 46657 823544 16777217 387420490 5)

Invece di sommare ogni volta, alterniamo l'addizione e la sottrazione:

  a(n) = a^a - b^b +...-+ d^d

Sequenza OEIS A344658: If decimal expansion of n is abc...d, a(n) = a^a - b^b + c^c -...-+ d^d.
Author: Massimo Corinaldesi, May 26 2021

(define (A344658 n)
  (if (zero? n) 1
    (local (sign out power)
      (setq power '(1 1 4 27 256 3125 46656 823543 16777216 387420489))
      (setq out 0)
      (if (odd? (length n))
          (setq sign 1)
          (setq sign -1))
      (while (!= n 0)
        (setq out (+ out (* sign (power (% n 10)))))
        (setq sign (* sign -1))
        (setq n (/ n 10)))
      out)))

(map A344658 (sequence 0 20))
;-> (1 1 4 27 256 3125 46656 823543 16777216 387420489 0 0
;->  -3 -26 -255 -3124 -46655 -823542 -16777215 -387420488 3)


------------------
Bruchi saltellanti
------------------

Date N foglie numerate da 1 a N. Un bruco salta di foglia in foglia in multipli di Aj (Aj, 2Aj, 3Aj).
L'indice j è specifico per il bruco. Ogni volta che un bruco raggiunge una foglia, la mangia un pò. Determinare quante foglie, da 1 a N, sono rimaste non mangiate dopo che tutti i bruchi K hanno raggiunto la fine. Ogni bruco ha il proprio fattore di salto indicato da Aj, e ogni bruco inizia a contare il primo salto dalla foglia numero 1.

(define (bruchi numleaf jump)
  (local (leaf goodleaf out)
    (setq out '())
    (setq leaf (sequence 0 numleaf))
    ; vettore di foglie sane
    (setq goodleaf (array (+ numleaf 1) '(1)))
    ; per ogni foglia...
    (for (i 1 numleaf)
      ; per ogni salto dei bruchi...
      (dolist (br jump)
        ; se il numero della foglia è multiplo del salto
        (if (zero? (% (leaf i) br))
            ; allora la foglia viene "mangiata" un pò
            ; (poniamo il relativo indice della lista goodleaf a 0)
            (setf (goodleaf i) 0)
        )
      )
    )
    ; costruzione della lista risultato
    ; ricerca dei numeri delle foglie sane
    (for (i 1 numleaf)
      (if (= (goodleaf i) 1) (push i out -1))
    )
    out))

(bruchi 10 '(2 3 5))
;-> (1 7)

(bruchi 100 '(1))
;-> '()

(bruchi 50 '(2 3 4 5 7))
;-> (1 11 13 17 19 23 29 31 37 41 43 47)


---------------
Buste matrioska
---------------

Dato un numero di buste con larghezze e altezze date come una coppia di numeri interi (w, h). Una busta può entrare in un'altra se e solo se sia la larghezza che l'altezza di una busta sono maggiori della larghezza e dell'altezza dell'altra busta.
Qual è il numero massimo di buste che inserire una dentro l'altra come una bambola russa (matrioska)?

Possiamo ordinare le buste per altezza in ordine crescente e larghezza in ordine decrescente. Quindi per i valori della larghezza trovare la sottosequenza crescente più lunga. Questo problema viene quindi convertito nel problema di trovare la sottosequenza crescente più lunga.

Ordinamento standard:

(setq m '((3 8) (4 6) (2 11) (2 10) (2 12) (20 3) (10 1)))

(sort (copy m))
;-> ((2 10) (2 11) (2 12) (3 8) (4 6) (10 1) (20 3))

Ordinamento con una funzione di comparazione (ascendente in x e discendente in y (per valori uguali di x)):

(define (cmp x y)
  (if (= (first x) (first y))
      (> (last x) (last y))
      (< (first x) (first y))))

(setq m '((3 8) (4 6) (2 11) (2 10) (2 12) (20 3) (10 1)))

(sort m cmp)
;-> ((2 12) (2 11) (2 10) (3 8) (4 6) (10 1) (20 3))

Funzione che calcola la lunghezza della sottosequenza crescente più lunga:

(define (lis lst)
  (local (len vet out)
    (setq out 1)
    (setq len (length lst))
    (setq vet (array len '(1)))
    (for (i 0 (- len 1))
      (setq j 0)
      (while (< j i)
        (if (> (lst i) (lst j))
            (setf (vet i) (max (vet i) (+ (vet j) 1)))
        )
        (++ j)
      )
      (setq out (max (vet i) out))
    )
    out))

Funzione che calcola la soluzione:

(define (matrioska dolls)
  (local (lst height)
    (sort dolls cmp)
    (setq height (map last dolls))
    (lis height)))

(matrioska '((6 4) (6 7) (1 8) (2 3) (5 2) (5 4)))
;-> 3


-----------
ASCII Julia
-----------

Ecco una versione base per stampare sul terminale l'insieme di Julia.

Prima di tutto ci servono alcune funzioni per calcolare i numeri complessi:

; Estrae la parte reale di un numero complesso
(define (real num) (first num))
; Estrae la parte immaginaria di un numero complesso
(define (imag num) (last num))
; Calcola il modulo di un numero complesso
(define (modulo num)
  (sqrt (add (mul (real num) (real num)) (mul (imag num) (imag num)))))
; Calcola la somma di due numeri complessi
(define (cx-add num1 num2)
  (list (add (real num1) (real num2)) (add (imag num1) (imag num2))))
; Calcola la moltiplicazione di due numeri complessi
(define (cx-mul num1 num2)
  (list (sub (mul (real num1) (real num2)) (mul (imag num1) (imag num2)))
        (add (mul (imag num1) (real num2)) (mul (real num1) (imag num2)))))

Poi scriviamo una funzione per calcolare l'insieme di Julia:

(define (julia width height)
  (local (c z limite i)
    (setq limite 40)
    (setq c '(-0.8 0.156))
    (for (y 1 height)
      (for (x 1 width)
        (setq i limite)
        (setq z (list (div (mul 3 (sub x (div width 2))) width)
                      (div (mul 2 (sub y (div height 2))) height)))
        (while (and (< (modulo z) 2) (> i 0))
          (setq z (cx-add (cx-mul z z) c))
          (-- i)
        )
        (if (> i 0)
            (print " ")
            (print "#")
        )
      )
      (println))))

(julia 61 24)
;->                                     #
;->                                   ####
;->                                  ## ##
;->                              # ###     ####
;->                            ######### ##########        ### #
;->             ###   #        ######################   #########
;->             #  ### ##       #############        #   ##### ## #  ##
;->           ######### ####     ##########      ### #    ### #  ### ## ##
;->    # ###  ######        ##     ########     ##        ######  ### #
;-> ## ## ###  # ###    # ###      ##########     #### #########
;->    ##  # ## #####   #        #############       ## ###  #
;->          #########   ######################        #   ###
;->           # ###        ########## #########
;->                            ####     ### #
;->                                 ## ##
;->                                 ####
;->                                  #

(julia 141 50)
;->                                                                        ##
;->                                                                      ##
;->                                                                     #######
;->                                                                      ########
;->                                                                        #   ##
;->                                                                 # ###  ##  #
;->                                                         #      #####   ####       ##     ##
;->                                                          #    ######         ##########   #
;->                                                               ########     ##########    #
;->                                                          ##   ###### ########################                       ###
;->                                                          ################ ################### ##             ## # ### #
;->                                                        #  #####################################             #  ###  ##
;->                          # #                           ############################# ###########          # ######    ###
;->                          #   #       ##                  ########################### #    ########       ################# #
;->                          # #    ####                    #####################  ###             ####      #####################
;->                        ###    ############             ######################  # #               ###     ################ ###     # # #
;->                        ###  # #################         ######################                    ##      ########### #      ##  ######
;->                      ###########################           ####################           ######  ##       ##########     ### #   ###   # ##
;->                     ################ ##      ######          #################           ######## ##       #  ######     ## ##   ####     ###
;->         #  #         ########### #             ####         #############   ####        ###  #######       ###########    ##    ######
;->        ##########    ############                ##           #  ##########  #           ##                ############    ##########
;->       ######    ##    ###########       #######  ###        ####   #############         ####             # ###########         #  #
;-> ##     ####   ## ##     ######  #       ## ########           #################          ######      ## ################
;-> ## #   ###   # ###     ##########       ##  ######           ####################           ###########################
;->      ######  ##      # ###########      ##                    ######################         ################# #  ###
;->      # # #     ### ################     ###               # #  ######################             ############    ###
;->               #####################      ####             ###  #####################                    ####    # #
;->                 # #################       ########    # ###########################                  ##       #   #
;->                    ###    ###### #          ########### #############################                           # #
;->                       ##  ###  #             #####################################  #
;->                      # ### # ##             ## ################### ################
;->                      ###                       ######################## ######   ##
;->                                                   #    ##########     ########
;->                                                  #   ##########         ######    #
;->                                                  ##     ##       ####   #####      #
;->                                                                 #  ##  ### #
;->                                                                ##   #
;->                                                                ########
;->                                                                  #######
;->                                                                      ##
;->                                                                    ##

Nota: Quest'ultimo grafico dell'insieme è largo circa 155 caratteri, quindi per vederlo correttamente occorre visualizzarlo con righe maggiori di 155 caratteri.


-----------------------
Dado da 7 con dado da 5
-----------------------

Dato un generatore di uguale probabilità di uno degli interi da 1 a 5 come dado5, creare dado7 che genera un intero pseudo-casuale da 1 a 7 con uguale probabilità usando solo dadi5 come fonte di numeri casuali e controllare la distribuzione dei risultati per almeno un milione di lanci.

Algoritmo:
Lanciare 5 volte "dadi5", se il numero ottenuto è maggiore di 21, allora ripetere i 5 lanci di "dado5", altrimenti dividere le 21 combinazioni in 7 gruppi da tre e restituire l'indice del gruppo a cui appartiene il numero.

(define (dado5) (+ (rand 5) 1))
(dado5)
;-> 2

(define (dado7)
  ; genera un numero casuale da 0 a 24 con uquali probabilità
  (let (val (+ (* 5 (dado5)) (dado5) -6))
    ; se val < 21, allora prendiamo come risultato (val % 7) + 1
    ; altrimenti scartiamo il valore (val) e
    ; generiamo un nuovo valore rilanciando la funzione "dado7"
    (if (< val 21)
      (+ 1 (% val 7))
      (dado7))))

(dado7)
;-> 4

Controlliamo la distribuzione dei valori (1..7):

(define (check-dado7 limite)
  (let (freq (array 8 '(0)))
    (for (i 1 limite)
      (++ (freq (dado7))))
    (println (slice freq 1))
    (println (slice (map (fn(x) (div x limite)) freq) 1))))

(check-dado7 1e6)
;-> (142884 143126 142924 142771 142699 142583 143013)
;-> (0.142884 0.143126 0.142924 0.142771 0.142699 0.142583 0.143013)
(apply + '(142884 143126 142924 142771 142699 142583 143013))
;-> 1000000
(apply add '(0.142884 0.143126 0.142924 0.142771 0.142699 0.142583 0.143013))
;-> 1

(check-dado7 1e8)
;-> (14281766 14288029 14287001 14284639 14290141 14281342 14287082)
;-> (0.14281766 0.14288029 0.14287001 0.14284639 0.14290141 0.14281342 0.14287082)
(apply add '(0.14281766 0.14288029 0.14287001 0.14284639 0.14290141 0.14281342 0.14287082))
;-> 1
(apply + '(14281766 14288029 14287001 14284639 14290141 14281342 14287082))
;-> 100000000

Controlliamo anche la distribuzione del numero "val" in "dado7" (0..24):

(define (check-val limite)
  (let (freq (array 25 '(0)))
    (for (i 1 limite)
      (++ (freq (+ (* 5 (dado5)) (dado5) -6))))
    (println (slice freq 1))
    (println (slice (map (fn(x) (div x limite)) freq) 1))))

(check-val 1e6)
;-> (39900 39858 40061 39717 40064 39781 40031
;->  40248 40064 39950 39879 40036 40012 39988
;->  40246 40072 40045 39940 39958 40145 39985
;->  39825 40107 39754)
;-> (0.0399 0.039858 0.040061 0.039717 0.040064 0.039781 0.040031
;->  0.040248 0.040064 0.03995 0.039879 0.040036 0.040012 0.039988
;->  0.040246 0.040072 0.040045 0.03994 0.039958 0.040145 0.039985
;->  0.039825 0.040107 0.039754)

(check-val 1e8)
;-> (4001367 4001057 4001661 3999623 4000304 4002462 3999824
;->  3996966 3999206 4000869 3998084 4000704 4000113 4001563
;->  4000824 4001220 3995496 3999672 4000310 4002547 4000921
;->  3999067 3999375 3998509)
;-> (0.04001367 0.04001057 0.04001661 0.03999623 0.04000304 0.04002462 0.03999824
;->  0.03996966 0.03999206 0.04000869 0.03998084 0.04000704 0.04000113 0.04001563
;->  0.04000824 0.0400122 0.03995496 0.03999672 0.0400031 0.04002547 0.04000921
;->  0.03999067 0.03999375 0.03998509)


-----------------
42 in newLISP e C
-----------------

Dialogo dal libro "Guida galattica per autostoppisti" di Douglas Adams:

"What do you get if you multiply six by nine?"

"Six by nine. Forty two."

"That's it. That's all there is."

"I always thought something was fundamentally wrong with the universe"

In italiano:

"Cosa ottieni se moltiplichi sei per nove?"

"Sei per nove. Quarantadue."

"Questo è tutto. Questo è tutto quello che c'è."

"Ho sempre pensato che ci fosse qualcosa di fondamentalmente sbagliato nell'universo"

Vediamo come può risultare 6 * 9 = 42.

In newLISP possiamo notare che:

   6(b13) × 9(b13) = 42(b13)

dove (b13) indica base 13

(define (n42 a b)
  (let (n (* a b)) (string (/ n 13) (% n 13))))

(n42 6 9)
;-> "42"

In C possiamo utilizzare il preprocessore dei #define:

#include <stdio.h>
#define sei  1+5
#define nove 8+1
int main()
{
  printf("Cosa ottieni se moltiplichi sei per nove?\n");
  printf("%i x %i = %i\n", sei, nove, sei*nove);
}

;-> Cosa ottieni se moltiplichi sei per nove?
;-> 6 x 9 = 42

Nota: sei*nove ==> (1 + 5 * 8 + 1)


------------------------
Uguaglianza approssimata
------------------------

A volte, quando si verifica la correttezza di una soluzione numerica, la differenza nei calcoli in virgola mobile tra le diverse implementazioni dei linguaggi diventa significativa.

Ad esempio, una differenza tra i calcoli in virgola mobile a 32 bit e 64 bit può apparire intorno all'ottava cifra significativa nell'aritmetica in base 10.

Creare una funzione che restituisce true se due numeri in virgola mobile sono "approssimativamente" uguali, cioè uguali a meno di un certo valore (errore assoluto).

(define (abs-err x y) (abs (sub x y)))

(define (approx-equals x y abs-err-max)
  (< (abs-err x y) abs-err-max))

(approx-equals 0.03781234001 0.03781234002 1e-8)
;-> true
(approx-equals 0.03781234001 0.03781234002 1e-12)
;-> nil
(approx-equals 100000000000000.01 100000000000000.011 1e-8)
;-> true
(approx-equals 100000000000000.01 100000000000000.011 1e-1)
;-> true
(sub 100000000000000.01 100000000000000.011)
;-> 0
(approx-equals 100.01 100.011 1e-8)
;-> nil
(approx-equals 100.01 100.011 1e-1)
;-> true
(sub 100.01 100.011)
;-> -0.000999999999990564

Da notare che con numeri grandi il valore di abs-err-max perde di significato.

Another way to measure the difference between a floating-point number and the real number it is approximating is relative error, which is simply the difference between the two numbers divided by the real number. For example the relative error committed when approximating 3.14159 by 3.14 × 100 is .00159/3.14159  .0005.

(define (rel-err x y)
  (div (abs-err x y) x))

(rel-err 0.03781234001 0.03781234002)
;-> 2.644639507832383e-010
(rel-err 100000000000000.01 100000000000000.011)
;-> 0
(rel-err 100.01 100.011)
;-> 9.999000099895649e-006

Nota: sulle operazioni in floating-point bisogna assolutamente leggere:
"What Every Computer Scientist Should Know About Floating-Point Arithmetic" di David Goldberg, 1991


----------
Primi sexy
----------

I primi sexy sono numeri primi che differiscono l'uno dall'altro di sei. Ad esempio, i numeri 5 e 11 sono entrambi numeri primi sexy, perché 11 - 6 = 5. Il termine "primi sexy" è un gioco di parole che deriva dal fatto che in latino la parola "sex" significa "sei".

Coppie prime sexy: sono gruppi di due numeri primi che differiscono di 6. Esempi: (5 11), (7 13), (11 17)
Sequenze: OEIS:A023201 e OEIS:A046117

Triple di primi sexy: sono gruppi di tre numeri primi in cui ciascuno differisce dal successivo di 6. Esempi: (5 11 17), (7 13 19), (17 23 29)
Sequenze: OEIS:A046118, OEIS:A046119 e OEIS:A046120

Quadruple di prime sexy: sono gruppi di quattro numeri primi in cui ciascuno differisce dal successivo di 6. Esempio: (5 11 17 23), (11 17 23 29)
Sequenze: OEIS:A023271, OEIS:A046122, OEIS:A046123 e OEIS:A046124

Quintuple di primi sexy: sono gruppi di cinque numeri primi in cui ciascuno differisce dal successivo di 6. In una progressione aritmetica di cinque termini con differenza comune 6, uno dei termini deve essere divisibile per 5, perché 5 e 6 sono relativamente primi. Quindi l'unica quintupla di primi sexy possibile vale (5 11 17 23 29).

Funzione che verifica se un numero è primo:

(define (prime? num)
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che calcola tutte le coppie di primi sexy fino a un determinato numero:

(define (sexy-pairs-to num)
  (let (out '())
    (for (i 2 (- num 6))
      (if (and (prime? i) (prime? (+ i 6)))
          (push (list i (+ i 6)) out -1)
      )
    )
    out))

(sexy-to 100)
;-> ((5 11) (7 13) (11 17) (13 19) (17 23) (23 29) (31 37) (37 43) (41 47) (47 53) (53 59)
;->  (61 67) (67 73) (73 79) (83 89))

(length (sexy-to 1e6))
;-> 16386

Funzione che restituisce il numero di tutte le coppie, le triple, le quadruple e le quintuple di numeri primi sexy fino a un determinato numero:

(define (sexy-all-to-count num)
  (local (p2 p3 p4 p5)
    (for (i 2 (- num 6))
      (if (and (prime? i) (prime? (+ i 6))) (begin
          (++ p2)
          (if (prime? (+ i 12)) (begin
              (++ p3)
              (if (prime? (+ i 18)) (begin
                  (++ p4)
                  (if (prime? (+ i 24))
                      (++ p5)))))))))
    (list p2 p3 p4 p5)))

Calcoliamo fino a 1000:

(sexy-all-to-count 1000)
;-> (74 28 7 1)
74 coppie, 28 triple, 7 quadruple e 1 quintupla.

Calcoliamo fino a 1 milione:

(sexy-all-to-count 1e6)
;-> (16386 2900 325 1)

Vediamo i tempi di esecuzione:

(time (sexy-all-to-count 1e6))
;-> 871.882
(time (sexy-all-to-count 1e7))
;-> 18786.703

Funzione che restituisce tutte le coppie, le triple, le quadruple e le quintuple di numeri primi sexy fino a un determinato numero:

(define (sexy-all-to num)
  (local (arr)
    (setq arr (array 4 '(())))
    (for (i 2 (- num 6))
      (if (and (prime? i) (prime? (+ i 6))) (begin
          (push (list i (+ i 6)) (arr 0) -1)
          (if (prime? (+ i 12)) (begin
              (push (list i (+ i 6) (+ i 12)) (arr 1) -1)
              (if (prime? (+ i 18)) (begin
                  (push (list i (+ i 6) (+ i 12) (+ i 18)) (arr 2) -1)
                  (if (prime? (+ i 24))
                      (push (list i (+ i 6) (+ i 12) (+ i 18) (+ i 24)) (arr 3) -1)))))))))
    arr))

Calcoliamo fino a 1000:

(setq sp (sexy-all-to 1000))
(length (sp 0))
;-> 74
(length (sp 1))
;-> 28
(length (sp 2))
;-> 7
(length (sp 3))
;-> 1
(sp 3)
;-> ((5 11 17 23 29))
(sp 2)
;-> ((5 11 17 23) (11 17 23 29) (41 47 53 59) (61 67 73 79)
;->  (251 257 263 269) (601 607 613 619) (641 647 653 659))
((sp 2) 0)
;-> (5 11 17 23)

Calcoliamo fino a 1 milione:

(silent (setq sp (sexy-all-to 1e6)))
(length (sp 0))
;-> 16386
(length (sp 1))
;-> 2900
(length (sp 2))
;-> 325
(length (sp 3))
;-> 1
((sp 2) 324)
;-> (997091 997097 997103 997109)

Vediamo i tempi di esecuzione:

(time (sexy-all-to 1e6))
;-> 872.753

(time (sexy-all-to 1e7))
;-> 18895.465

Possiamo scrivere un'altra funzione che utilizza una hash-map per contenere i numeri primi.

Funzione che calcola i primi fino ad un determinato numero e li mette in una hash-map (che verrà definita nella funzione successiva):

(define (primes-to-h num)
;(new Tree 'primih)
  (cond ((= num 1) (primih))
        ((= num 2) (primih "2" "2") (primih))
        (true
         (let (arr (array (+ num 1)))
          (primih "2" "2")
          (for (x 3 num 2)
                (when (not (arr x))
                  (primih x x)
                  (for (y (* x x) num (* 2 x) (> y num))
                      (setf (arr y) true)))) (primih)))))

Test con hash-map "primih" definita dentro la funzione (bisogna togliere il commento alla riga (new Tree 'primih)):

(length (primes-to-h 10000000))
;-> 664579
(delete 'primih)
(time (primes-to-h 1e6))
;-> 195.527
(delete 'primih)
(time (primes-to-h 1e7))
;-> 2046.079
(delete 'primih)

Funzione che restituisce il numero di tutte le coppie, le triple, le quadruple e le quintuple di numeri primi sexy fino a un determinato numero:

(define (sexy-all-to-count2 num)
  (local (p2 p3 p4 p5)
    (new Tree 'primih)
    (primes-to-h num)
    (dolist (p (primih))
      (if (primih (+ (int (p 1)) 6)) (begin
          (++ p2)
          (if (primih (+ (int (p 1)) 12)) (begin
              (++ p3)
              (if (primih (+ (int (p 1)) 18)) (begin
                  (++ p4)
                  (if (primih (+ (int (p 1)) 24))
                      (++ p5)))))))))
    (delete 'primih)
    (list p2 p3 p4 p5)))

Calcoliamo fino a 1000:

(sexy-all-to-count2 1000)
;-> (74 28 7 1)

Calcoliamo fino a 1 milione:

(sexy-all-to-count2 1e6)
;-> (16386 2900 325 1)

Vediamo i tempi di esecuzione:

(time (sexy-all-to-count2 1e6))
;-> 260.973

(time (sexy-all-to-count2 1e7))
;-> 2779.626

(time (sexy-all-to-count2 1e8))
;-> 30688.684

La funzione che utilizza la hash-map è molto più veloce (quasi 7 volte più veloce).


-----------------
Tavola pitagorica
-----------------

Scrivere una funzione che stampa la tavola pitagorica (Tavola/tabella delle moltiplicazioni) fino a un determinato numero.

(define (pitagorica num)
    (print "\n    ·")
    (for (i 1 num)
      (print (format "%4d" i))
    )
    (println (format "\n%s" (dup "·" (* (+ num 2) 4))))
    (for (i 1 num)
      (print (format "%3d%s" i " ·"))
      (for (j 1 num)
        (print (format "%4d" (* i j)))
      )
      (println "\n    ·")
    )
    'end)

(pitagorica 12)
;->
;->     ·   1   2   3   4   5   6   7   8   9  10  11  12
;-> ························································
;->   1 ·   1   2   3   4   5   6   7   8   9  10  11  12
;->     ·
;->   2 ·   2   4   6   8  10  12  14  16  18  20  22  24
;->     ·
;->   3 ·   3   6   9  12  15  18  21  24  27  30  33  36
;->     ·
;->   4 ·   4   8  12  16  20  24  28  32  36  40  44  48
;->     ·
;->   5 ·   5  10  15  20  25  30  35  40  45  50  55  60
;->     ·
;->   6 ·   6  12  18  24  30  36  42  48  54  60  66  72
;->     ·
;->   7 ·   7  14  21  28  35  42  49  56  63  70  77  84
;->     ·
;->   8 ·   8  16  24  32  40  48  56  64  72  80  88  96
;->     ·
;->   9 ·   9  18  27  36  45  54  63  72  81  90  99 108
;->     ·
;->  10 ·  10  20  30  40  50  60  70  80  90 100 110 120
;->     ·
;->  11 ·  11  22  33  44  55  66  77  88  99 110 121 132
;->     ·
;->  12 ·  12  24  36  48  60  72  84  96 108 120 132 144
;->     ·


----------------------------------------------------------------------
Sottostringa più piccola che contiene tutti i caratteri di una stringa
----------------------------------------------------------------------

Data una stringa, trovare la sottostringa più piccola con tutti i caratteri distinti della stringa data.
Per esempio:

Stringa = "aabcbcdbca"
Soluzione = "dbca"
Dell'insieme delle possibili sottostringhe 'dbca' è la sottostringa più corta con tutti i caratteri distinti della stringa data.

Stringa = "aaab"
Soluzione = "ab"
Dell'insieme delle possibili sottostringhe 'ab' è la sottostringa più corta con tutti i caratteri distinti della stringa data.

Utilizziamo la tecnica sliding window (finestra scorrevole) per arrivare alla soluzione. Questa tecnica mostra come un ciclo for annidato in alcuni problemi può essere convertito in un singolo ciclo for e quindi riducendo la complessità temporale.

Metodo: Fondamentalmente manteniamo una finestra di caratteri utilizzando due puntatori, uno di inizio e uno di fine. Questi puntatori di inizio e fine possono essere utilizzati rispettivamente per ridurre e aumentare le dimensioni della finestra. Ogni volta che la finestra contiene tutti i caratteri di una determinata stringa, la finestra viene ridotta dal lato sinistro per rimuovere i caratteri extra e quindi la sua lunghezza viene confrontata con la finestra più piccola trovata finora.
Se nella finestra presente non è possibile eliminare più caratteri allora iniziamo ad aumentare la dimensione della finestra utilizzando la fine fino a quando tutti i caratteri distinti presenti nella stringa sono presenti anche nella finestra. Infine, troviamo la dimensione minima di ogni finestra.

  1. Mantenere un vettore (visited) del massimo di caratteri possibili (256 caratteri) e non appena ne troviamo uno nella stringa, contrassegnare quell'indice nell'array (questo per contare tutti i caratteri distinti nella stringa).
  2. Prendere due puntatori inizio e fine che segneranno l'inizio e la fine della finestra.
  3. Prendere un contatore=0 che verrà utilizzato per contare i caratteri distinti nella finestra.
  4. Adesso iniziare a leggere i caratteri della stringa data e se ci imbattiamo in un carattere non ancora visitato incrementare il contatore di 1.
  5. Se il contatore è uguale al numero totale di caratteri distinti, provare a ridurre la finestra.
  6. Per restringere la finestra:
      a. Se la frequenza del carattere all'inizio del puntatore è maggiore di 1, incrementare il puntatore poiché è ridondante.
      b. Ora confrontare la lunghezza della finestra attuale con la lunghezza minima della finestra.

(define (find-substr str)
  (local (len-str curr-count start start-index dist-count visited idx conta min-len len-window)
    (setq len-str (length str))
    ; conta tutti i caratteri distinti
    (setq dist-count 0)
    (setq visited (array 256 '(nil)))
    (for (i 0 (- len-str 1))
      (setq idx (char (str i)))
      (if (nil? (visited idx))
        (begin
          (setq idx (char (str i)))
          (setf (visited idx) true)
          (++ dist-count)
        )
      )
    )
    ; Fondamentalmente manteniamo una finestra di caratteri
    ; che contiene tutti i caratteri della stringa data.
    (setq start 0 start-index -1 min-len 999999)
    (setq conta 0)
    (setq curr-count (array 256 '(0)))
    (for (j 0 (- len-str 1))
      ; Conta l'occorrenza dei caratteri di stringa
      (setq idx (char (str j)))
      (++ (curr-count idx))
      ; Se qualsiasi carattere distinto corrisponde, quindi aumentare il conteggio
      (if (= (curr-count idx) 1)
          (++ conta)
      )
      ; se tutti i caratteri sono abbinati
      (if (= conta dist-count) (begin
          ; Provare a ridurre a icona la finestra, ad esempio controllare se
          ; qualsiasi carattere si verifica un numero di volte maggiore
          ; rispetto al numero delle sue occorrenze nel modello, se sì
          ; allora rimuoverlo dall'inizio e rimuovere anche
          ; i caratteri inutili
          (setq idx (char (str start)))
          (while (> (curr-count idx) 1)
            (if (> (curr-count idx) 1)
                (-- (curr-count idx))
            )
            (++ start)
            (setq idx (char (str start)))
          )
          ; Aggiorna le dimensioni della finestra
          (setq len-window (+ j 1 (- start)))
          (if (> min-len len-window) (begin
              (setq min-len len-window)
              (setq start-index start))
          )
      ))
    )
    ; Restituisce la sottostringa a partire da start_index e di lunghezza min_len
    (slice str start-index min-len)))

(find-substr "aabcbcdbca")
;-> "dbca"
(find-substr "aaab")
;-> "ab"
(find-substr "supercalifragilisticexpialidocious")
;-> "fragilisticexpialidociou"

Nota:
"Supercalifragilisticexpialidocious" è una canzone scritta dai fratelli Richard Sherman e Robert Sherman, che fa parte della colonna sonora di Mary Poppins, film Disney del 1964.
Nella versione originale la parola ha un significato ben preciso, che si evince scomponendola: Super (sopra) – cali (bellezza) – fragilistic (delicato) – expiali (fare ammenda) – docious (istruibile). Quindi il significato delle sue parti sarebbe “fare ammenda per la possibilità di insegnare attraverso la delicata bellezza”.
La versione italiana "Supercalifragilistichespiralidoso" è cantata da Tina Centi, Rita Pavone e Nancy Cuomo.


------------------------
Algoritmo Floyd-Warshall
------------------------

L'algoritmo di Floyd-Warshall viene utilizzato per trovare i percorsi più brevi tra tutte le coppie di vertici di un grafo orientato con pesi degli archi positivi o negativi. Supponiamo che il grafo non ha cicli, archi paralleli o cicli negativi.

Ciclo (Loop):
Nella teoria dei grafi, un ciclo (loop o self-loop o buckle) è un arco che collega un vertice (nodo) a se stesso. Un grafo semplice non contiene cicli

Archi Paralleli (Parallel Edge):
Gli archi paralleli (parallel edge o multi-edge) sono, in un grafo non orientato, due o più archi incidenti agli stessi due vertici, o in un grafo orientato, due o più archi con la stessa direzione incidenti a due stessi vertici. Un grafo semplice non ha archi paralleli.

Cicli Negativi (Negative cycle):
Se un grafo contiene un "ciclo negativo" (cioè un ciclo i cui archi si sommano a un valore negativo) che è raggiungibile dalla sorgente, allora non esiste un percorso più economico: qualsiasi percorso che ha un punto sul ciclo negativo può essere reso più economico da un altro giro intorno al ciclo negativo.

Scrivere una funzione che implementa questo algoritmo (vedi wikipedia per maggiori informazioni).

Grafo di esempio:

        {1}
        · \
     4 /   \ -2
      /  3  ·
    {2}----·{3}
      ·     /
    -1 \   / 2
        \ ·
        {4}

  Vertici: (1 2 3 4)
  Archi: (1 3) dist -2
         (2 1) dist 4
         (2 3) dist 3
         (3 4) dist 2
         (4 2) dist -1

Rappresentiamo questo grafo come una lista di archi adiacenti:

  Lista archi adiacenti: (v1 v2 val)
  v1 = nodo di partenza
  v2 = nodo di arrivo
  val = peso dell'arco

(setq grafo '((1 3 -2) (2 1 4) (2 3 3) (3 4 2) (4 2 -1)))

Scriviamo la funzione:

(define (floyd-warshall graph num-vertex)
  (local (num-edge dist next u v coppia coppia-dist vertex out)
    (setq out '())
    (setq num-edge (length graph))
    (setq dist (array num-vertex num-vertex '(999999)))
    (for (i 0 (- num-edge 1))
      (setf (dist (- (graph i 0) 1) (- (graph i 1) 1)) (graph i 2))
    )
    (setq next (array num-vertex num-vertex '(999999)))
    (for (i 0 (- (length next) 1))
      (for (j 0 (- (length next) 1))
        (if (!= i j)
            (setf (next i j) (+ j 1))
        )
      )
    )
    (for (k 0 (- num-vertex 1))
      (for (i 0 (- num-vertex 1))
        (for (j 0 (- num-vertex 1))
          (if (< (+ (dist i k) (dist k j)) (dist i j))
            (begin
              (setf (dist i j) (+ (dist i k) (dist k j)))
              (setf (next i j) (next i k))
            )
          )
        )
      )
    )
    ; ricostruisce i percorsi minimi (soluzioni)
    (for (i 0 (- (length next) 1))
      (for (j 0 (- (length next) 1))
        (if (!= i j)
          (begin
            (setq u (+ i 1))
            (setq v (+ j 1))
            (setq coppia (list u v))
            (setq coppia-dist (dist i j))
            (setq vertex '())
            (push u vertex -1)
            (do-while (!= u v)
              (setq u (next (- u 1) (- v 1)))
              (push u vertex -1)
            )
            (push (list coppia coppia-dist vertex) out -1)
          )
        )
      )
    )
    out))

Proviamo con il grafo di esempio:
(setq grafo '((1 3 -2) (2 1 4) (2 3 3) (3 4 2) (4 2 -1)))

(setq sol (floyd-warshall grafo 4))
;-> (((1 2) -1 (1 3 4 2))
;->  ((1 3) -2 (1 3))
;->  ((1 4)  0 (1 3 4))
;->  ((2 1)  4 (2 1))
;->  ((2 3)  2 (2 1 3))
;->  ((2 4)  4 (2 1 3 4))
;->  ((3 1)  5 (3 4 2 1))
;->  ((3 2)  1 (3 4 2))
;->  ((3 4)  2 (3 4))
;->  ((4 1)  3 (4 2 1))
;->  ((4 2) -1 (4 2))
;->  ((4 3)  1 (4 2 1 3)))

Definiamo una funzione che estrae il percorso minimo tra due vertici:

(define (path v1 v2 sol)
  (let (idx (first (ref (list v1 v2) sol)))
    (println "Da " v1 " a " v2)
    (println "Distanza minima: " (sol idx 1))
    (println "Percorso: " (sol idx 2))))

(path 3 1 sol)
;-> Da 3 a 1
;-> Distanza minima: 5
;-> Percorso: (3 4 2 1)

Proviamo con un altro grafo (da disegnare con carta e penna):

(setq graph '((1 2 50) (1 3 30) (1 4 10)
              (2 1 50) (2 6 40)
              (3 1 30) (3 2 10) (3 4 10) (3 5 10)
              (4 1 10) (4 3 10) (4 7 10)
              (5 3 10) (5 4 20)
              (6 2 40) (6 5 20)
              (7 6 80)))

(setq sol (floyd-warshall graph 7))
;-> (((1 2) 30 (1 4 3 2))
;->  ((1 3) 20 (1 4 3))
;->  ((1 4) 10 (1 4))
;->  ((1 5) 30 (1 4 3 5))
;->  ((1 6) 70 (1 4 3 2 6))
;->  ((1 7) 20 (1 4 7))
;->  ((2 1) 50 (2 1))
;->  ((2 3) 70 (2 1 4 3))
;->  ((2 4) 60 (2 1 4))
;->  ((2 5) 60 (2 6 5))
;->  ((2 6) 40 (2 6))
;->  ((2 7) 70 (2 1 4 7))
;->  ((3 1) 20 (3 4 1))
;->  ((3 2) 10 (3 2))
;->  ((3 4) 10 (3 4))
;->  ((3 5) 10 (3 5))
;->  ((3 6) 50 (3 2 6))
;->  ((3 7) 20 (3 4 7))
;->  ((4 1) 10 (4 1))
;->  ((4 2) 20 (4 3 2))
;->  ((4 3) 10 (4 3))
;->  ((4 5) 20 (4 3 5))
;->  ((4 6) 60 (4 3 2 6))
;->  ((4 7) 10 (4 7))
;->  ((5 1) 30 (5 4 1))
;->  ((5 2) 20 (5 3 2))
;->  ((5 3) 10 (5 3))
;->  ((5 4) 20 (5 4))
;->  ((5 6) 60 (5 3 2 6))
;->  ((5 7) 30 (5 4 7))
;->  ((6 1) 50 (6 5 4 1))
;->  ((6 2) 40 (6 2))
;->  ((6 3) 30 (6 5 3))
;->  ((6 4) 40 (6 5 4))
;->  ((6 5) 20 (6 5))
;->  ((6 7) 50 (6 5 4 7))
;->  ((7 1) 130 (7 6 5 4 1))
;->  ((7 2) 120 (7 6 2))
;->  ((7 3) 110 (7 6 5 3))
;->  ((7 4) 120 (7 6 5 4))
;->  ((7 5) 100 (7 6 5))
;->  ((7 6) 80 (7 6)))

(path 7 1 sol)
;-> Da 7 a 1
;-> Distanza minima: 130
;-> Percorso: (7 6 5 4 1)


-----------------
Triangoli casuali
-----------------

Dati tre punti casuali nel piano cartesiano xy, determinare se possono formare un triangolo.
Questo è semplice: tre punti su un piano determinano sempre un triangolo, tranne quando sono tutti e tre allineati.

Dati tre segmenti di lunghezza casuale, determinare se possono formare un triangolo.

Poniamo che a, b e c siano le lunghezze di tre segmenti, allora questi possono formare un triangolo se risultano vere tutte le seguenti condizioni:

  1. a + b > c
  2. a + c > b
  3. b + c > a

Quindi possiamo scrivere la seguente funzione:

(define (tri1? a b c)
  (if (or (<= (add a b) c) (<= (add a c) b) (<= (add b c) a))
      nil
      true))

(tri1? 7 10 5)
;-> true
(tri1? 1 1 1)
;-> true
(tri1? 1 1 2)
;-> nil
(tri1? 1 2 4)
;-> nil

Nota: usiamo l'operatore "or" perchè valuta true al primo valore true dell'espressione.

Analogamente possiamo osservare che se la somma dei tre segmenti è maggiore del doppio del lato maggiore, allora è possibile formare un triangolo (cioè se c'è un lato più lungo della somma degli altri due):

(define (tri2? a b c)
  (> (add a b c) (mul 2 (max a b c))))

(tri2? 7 10 5)
;-> true
(tri2? 1 1 1)
;-> true
(tri2? 1 1 2)
;-> nil
(tri2? 1 2 4)
;-> nil

Vediamo la frequenza dei segmenti che possono formare un triangolo.

Funzione per generare un numero float in un intervallo chiuso:

(define (rnd-range min-val max-val)
  (add min-val (mul (random) (sub max-val min-val))))

; Funzione per generare un numero float normalizzato (distribuzione uniforme):
;(define (rnd-range min-val max-val)
;  (mul (random) (sub max-val min-val)))

La seguente chiamata può generare anche 10 o 20:

(rnd-range 10 20)
;-> 18.88943144016846

(for (i 1 100000) (if (= (rnd-range 10 20) 10) (println "10")))

Adesso definiamo una funzione che crea, per un determinato numero di volte, tre segmenti casuali e controlla se possono formare un triangolo :

(define (test-triangle min-d max-d iter)
  (local (tri a b c)
    (seed (time-of-day))
    (setq tri 0)
    (for (i 1 iter)
      (setq a (rnd-range min-d max-d))
      (setq b (rnd-range min-d max-d))
      (setq c (rnd-range min-d max-d))
      (if (tri1? a b c)
          (++ tri)
      )
    )
    (println tri { } (- iter tri))))

(test-triangle 10 20 1e6)
;-> 1000000 0 ; perchè la somma di due lati qualunque è sempre maggiore del terzo.

(test-triangle 100 200 1e6)
;-> 1000000 0 ; perchè la somma di due lati qualunque è sempre maggiore del terzo.

(test-triangle 10 60 1e6)
;-> 743012 256988

Il numero di triangoli possibili diminuisce con l'aumentare della lunghezza dei lati:

(test-triangle 10 110 1e6)
;-> 635927 364073
(test-triangle 10 1010 1e6)
;-> 514827 485173
(test-triangle 10 10010 1e6)
;-> 502024 497976
(test-triangle 10 100010 1e6)
;-> 500194 499806
(test-triangle 10 1000010 1e6)
;-> 499571 500429
(test-triangle 10 10000010 1e6)
;-> 499791 500209
(test-triangle 10 100000010 1e6)
;-> 500058 499942

Ma non scende mai sotto il 50%.

Infatti se utilizziamo un intervallo normalizzato otteniamo il 50%:

(test-triangle 0 1 1e6)
;-> 500054 499946
(test-triangle 0 1000 1e6)
;-> 500018 499982

Dal punto di vista matematico, siano a,b,c i tre numeri. La probabilità che c > a+b è data da:

 1     c    (c-b)
 ∫dc * ∫db * ∫da = 1/6
 0     0     0

Una qualsiasi delle tre variabili potrebbe essere la più grande, quindi moltiplichiamo per 3 e otteniamo 1/2.

Geometricamente, supponiamo che il più grande dei tre sia a. Quindi gli altri due devono trovarsi nel quadrato di area a^2. In quel quadrato, la diagonale nord-ovest-sudest è la linea dove gli altri due si sommano ad a. Al di sotto di quella linea, gli altri due sommano a meno di a. Chiaramente quella linea taglia il quadrato a metà. Quindi, per ogni a, la probabilità è 1/2.


----------------------
Triangoli e bastoncini
----------------------

Abbiamo un bastoncino di una lunghezza unitaria. Due punti sul bastoncino vengono selezionati casualmente (uniformemente lungo la lunghezza del bastoncino) e indipendentemente. Quindi rompiamo il bastoncino in questi due punti in modo da ottenere tre pezzi dal bastoncino. Qual è la probabilità che questi tre pezzi formino un triangolo?

Poniamo che a, b e c siano le lunghezze dei tre segmenti del bastoncino, allora questi possono formare un triangolo se risultano vere tutte le seguenti condizioni:

  1. a + b > c
  2. a + c > b
  3. b + c > a

Quindi possiamo scrivere la seguente funzione:

(define (tri? a b c)
  (if (or (<= (add a b) c) (<= (add a c) b) (<= (add b c) a))
      nil
      true))

Nota: usiamo l'operatore "or" perchè valuta true al primo valore true dell'espressione.

(tri? 7 10 5)
;-> true
(tri? 1 1 1)
;-> true
(tri? 1 1 2)
;-> nil
(tri? 1 2 4)
;-> nil

(define (dist2d x1 y1 x2 y2)
"Calculate 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

Scriviamo la funzione di simulazione:

(define (bastoncino iter)
  (local (tri a b c)
    (seed (time-of-day))
    (setq tri 0)
    (for (i 1 iter)
      (setq t1 (random))
      (setq t2 (random))
      (if (> t1 t2) (swap t1 t2))
      (setq a t1)
      (setq b (sub t2 t1))
      (setq c (sub 1 t2))
      (if (tri? a b c)
          (++ tri)
      )
    )
    (println tri { } (- iter tri))))

(bastoncino 1000)
;-> 247 753
(bastoncino 10000)
;-> 2582 7418
(bastoncino 1e6)
;-> 250813 749187
(time (println (bastoncino 1e8)))
;-> 25001002 74998998
;-> 50731.957

Quindi la probabilità che si formi un triangolo vale il 25% (1/4).

Dal punto di vista matematico, poniamo l'origine sull'estremità sinistra del bastone. Sia X la lunghezza dall'origine al primo punto selezionato. Sia Y la lunghezza dall'origine al secondo punto selezionato.
Nota che quando X=Y, abbiamo solo due pezzi e non possono formare un triangolo, quindi assumiamo X≠Y.
Assumiamo innanzitutto che X<Y. Quindi, dopo aver rotto il bastone, abbiamo tre pezzi di lunghezza X, Y−X e 1−Y, rispettivamente.

                   Y
    -----|---------|-------
    0    X                1

    -----  ---------  -------
      X     (Y - X)   (1 - Y)

Consideriamo ora le condizioni per cui tre segmenti di lunghezza a, b e c formino un triangolo in generale:

  a + b > c
  b + c > a
  c + a > b

e sostituiamo a,b e c con i parametri dei tre segmenti:

        X + (Y - X) > (1 -Y)
  (Y - X) + (1 - Y) > X
        (1 - Y) + X > (Y - X)

e semplificando otteniamo:

  Y > 1/2
  X < 1/2
  Y < X + 1/2

In alternativa, possiamo trovare la probabilità per il caso X > Y come segue. Per argomento di simmetria, dobbiamo semplicemente scambiare X e Y e ottenere le condizioni:

  X > 1/2
  Y < 1/2
  X < Y + 1/2

La soluzione di questi due sistemi di disuguaglianze viene rappresentata nella figura "bastoncino.png" presente nella cartella "data".

Poichè la funzione di densità congiunta di X e Y è distribuita uniformemente sul quadrato unitario, la probabilità che tre pezzi formino un triangolo sotto l'assunzione X < Y è data dall'area grigia della regione triangolare contrassegnata con A, che vale 1/8.
Per simmetria, il caso X > Y dà la stessa probabilità (1/8) raffigurata dalla regione triangolare B. Quindi, la probabilità totale vale:

  P(T | X > Y) + P(T | Y > X) = 1/8 + 1/8  = 1/4


----------------------------------------------------------
Generazione di una lista di numeri casuali che sommano a 1
----------------------------------------------------------

Per generare una lista di numeri casuali che sommano a 1 possiamo generare una lista di numeri casuali tra 0 e 1 e poi dividerli per la loro somma.

(define (rnd-list-one num)
  (let (tmp (random 0 1 num))
    (setq sum (apply add tmp))
    (map (fn(x) (div x sum)) tmp)))

(rnd-list-one 10)
;-> (0.1265890983499499 0.1624363272236493 0.06672036222734991
;->  0.03061191170708346 0.09963428969480603 0.09536222734990639
;->  0.04756410814576168 0.06689995210936479 0.139606643737211
;->  0.1645750794549175)

Verifichiamo che la somma valga sempre 1 (o 0.9999999999999999):

(dotimes (x 9) (println (apply add (rnd-list-one 10))))
;-> 1
;-> 1
;-> 0.9999999999999999
;-> 1
;-> 0.9999999999999998
;-> 1
;-> 1
;-> 0.9999999999999999
;-> 0.9999999999999999
;-> 0.9999999999999999

Nota:
(add 0.9999999999999999 1)
;-> 2

Purtroppo questo metodo non produce una distribuzione uniforme dei valori (perchè una distribuzione uniforme non è più tale dopo un'operazione di scala).

Invece, il seguente algoritmo dovrebbe produrre una distribuzione uniforme di N numeri casuali che sommano a 1.

1. Creare una lista di N - 1 numeri casuali tra 0 e 1
2. Aggiungere alla lista 0 e 1 (ottenendo una lista di N + 1 numeri)
3. Ordinare la lista
4. Calcolare le differenze delle coppie di elementi(cioè, calcolare le N differenze num(i) - num(i-1)) ottenendo un totale di N numeri).

(define (rnd-list num)
  (let (tmp (random 0 1 (- num 1)))
    (push 0 tmp)
    (push 1 tmp -1)
    (sort tmp)
    ; crea una lista con le differenze
    ; delle coppie di elementi el(i) - el(i-1)
    (map sub (rest tmp) (chop tmp))))

(setq a (rnd-list 5))
;-> (0.174108096560564 0.5363933225501267 0.03610339671010465 0.1123386333811457 0.141056550798059)

(apply add a)
;-> 1

Possiamo estrapolare la funzione alla generazione di numeri interi con somma predefinita:

(for (i 1 100000) (if (= 100 (rand 100)) (println "0")))

(define (rnd-int-list num sum)
  (let (tmp (rand sum (- num 1)))
    (push 0 tmp)
    (push sum tmp -1)
    (sort tmp)
    (println tmp)
    ; crea una lista con le differenze
    ; delle coppie di elementi el(i) - el(i-1)
    (map sub (rest tmp) (chop tmp))))

(setq b (rnd-int-list 5 100))
;-> (14 24 31 10 21)
(apply + b)
;-> 100
(setq b (rnd-int-list 100 1000))
;-> (10 1 4 6 1 40 6 31 2 1 0 14 2 12 14 1 4 2 10 6 9 8 9 27 6
;->  9 7 20 1 27 1 6 7 5 4 33 2 6 14 19 14 9 17 2 5 21 15 1 8
;->  42 17 15 15 8 9 9 2 18 2 4 5 8 2 2 7 12 26 21 1 7 4 40 5
;->  14 7 23 7 17 0 2 1 21 3 1 5 16 1 3 5 20 29 15 3 0 8 10 4 5 7 13)
(apply + b)
;-> 1000


---------------
Numeri disarium
---------------

Sono quei numeri tali che la somma delle sue cifre elevate alle potenze consecutive (1,2,3,...) è uguale al numero stesso.
La potenza vale 1 partendo dalla cifra più significativa (quella più a sinistra del numero).

Sequenza OEIS A032799:
  0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 89, 135, 175, 518, 598,
  1306, 1676, 2427, 2646798, 12157692622039623539, ...

Funzione che verifica se un numero è disarium:

(define (disarium? num)
  (if (zero? num) 0
      (local (sum numero p)
        (setq numero num)
        (setq sum 0)
        (setq len (length num))
        (setq p len)
        (while (and (!= num 0) (<= sum numero))
        ;(while (!= num 0)
          (setq sum (+ sum (pow (% num 10) p)))
          (-- p)
          (setq num (/ num 10))
        )
        (= sum numero))))

(disarium? 89)
;-> true
(disarium? 17557)

(apply + (list (pow 7 1) (pow 5 2) (pow 5 3) (pow 7 4) (pow 1 5)))

Funzione che calcola i numeri disarium fino ad un determinato limite:

(define (disarium-to limite)
  (let (out '())
    (for (i 0 limite)
      (if (disarium? i) (push i out -1)))
    out))

(disarium-to 10000)
;-> (0 1 2 3 4 5 6 7 8 9 89 135
;->  175 518 598 1306 1676 2427)

(time (println (disarium-to 1e7)))
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427 2646798)
;-> 19445.957 ; 20 secondi circa

Il numero successivo, 12157692622039623539, non è calcolabile con questa funzione. Però possiamo verificare che sia effettivamente un numero disarium:

(disarium? 12157692622039623539)
;-> ERR: number out of range in function <=
;-> called from user function (disarium? 12157692622039623539L)

Oops, il numero è maggiore di MAX-INT = 9223372036854775807, quindi dobbiamo usare i big-integer:

(define (** num power)
    (let (out 1L)
        (dotimes (i power)
            (setq out (* out num)))))

(define (disarium-big? num)
  (if (zero? num) 0L
      (local (sum numero)
        (setq numero num)
        (setq sum 0L)
        (setq len (length num))
        (while (and (!= num 0) (<= sum numero))
          (setq sum (+ sum (** (% num 10) len)))
          (-- len)
          (setq num (/ num 10))
        )
        (= sum numero))))

(disarium-big? 2427)
;-> true
(disarium-big? 12157692622039623539)
;-> true

Cambiamo anche la funzione che calcola i numeri disarium fino ad un determinato limite per gestire i big-integer:

(define (disarium-big-to limite)
  (let (out '())
    (for (i 0 limite)
      (if (disarium-big? i) (push i out -1)))
    out))

(disarium-big-to 10000)
;-> (0 1 2 3 4 5 6 7 8 9 89 135
;->  175 518 598 1306 1676 2427)

(time (println (disarium-big-to 1e7)))
;-> (0 1 2 3 4 5 6 7 8 9 89 135 175 518 598 1306 1676 2427 2646798)
;-> 223413.805

Chiaramente neanche con questa funzione possiamo calcolare il valore 12157692622039623539 (o quello successivo).


--------------
Numeri promici
--------------

Un numero si dice promico (pronico) se è il prodotto di due numeri interi consecutivi.
Ad esempio, se consideriamo il numero 72, è il prodotto di due interi consecutivi 8 e 9. Pertanto, 72 è un numero promico.
Ora, se consideriamo il numero 16, è il prodotto di 2 e 8 o 4 e 4 ma nessuno è gli interi consecutivi. Pertanto, 16 non è un numero promico.

Sequenza OEIS A002378:
  0, 2, 6, 12, 20, 30, 42, 56, 72, 90, 110, 132, 156, 182, 210, 240, 272,
  306, 342, 380, 420, 462, 506, 552, 600, 650, 702, 756, 812, 870, 930,
  992, 1056, 1122, 1190, 1260, 1332, 1406, 1482, 1560, 1640, 1722, 1806,
  1892, 1980, 2070, 2162, 2256, 2352, 2450, 2550, ...

Algoritmo:
Eseguire un ciclo da 1 a metà del numero e se il numero è il prodotto di due numeri consecutivi qualsiasi, il numero è un numero promico, altrimenti no.

(define (promico? num)
  (let (out nil)
    (for (i 1 (/ num 2) 1 out)
      (if (= num (* i (+ i 1)))
          (setq out true))
    )
  out))

(promico? 0)
;-> true
(promico? 72)
;-> true
(promico? 30)
;-> true
(promico? 100)
;-> nil

Per trovare tutti i numeri promici fino ad un certo limite la funzione è la seguente:

(define (promici-to limite)
  (let ((prom 0) (i 0) (out '()))
    (while (< prom limite)
      (push prom out -1)
      (++ i)
      (setq prom (* i (+ i 1)))
    )
    out))

(promici-to 2600)
;-> (0 2 6 12 20 30 42 56 72 90 110 132 156 182 210 240 272
;->  306 342 380 420 462 506 552 600 650 702 756 812 870 930
;->  992 1056 1122 1190 1260 1332 1406 1482 1560 1640 1722
;->  1806 1892 1980 2070 2162 2256 2352 2450 2550)


----------------
Formula di Erone
----------------

La formula di Erone permette di calcolare l'area di un triangolo di cui sono note le misure dei lati.
Indichiamo co n a,b,c i lati di untriangolo qualsiasi e sia sp il suo semiperimetro:

  sp = (a + b + c)/2

La formula di Erone stabilisce che l'area del triangolo è pari alla radice quadrata del semiperimetro per la differenza tra il semiperimetro e il primo lato, moltiplicato per la differenza tra il semiperimetro e il secondo lato, moltiplicato per la differenza tra il semiperimetro e il terzo lato.

  Area = sqrt(sp*(sp - a)*(sp - b)*(sp - c))

La funzione è la seguente:

(define (erone a b c)
  (let (sp (div (add a b c) 2))
    (sqrt (mul sp (sub sp a) (sub sp b) (sub sp c)))))

(erone 15 20 25)
;-> 150

Nota: l'altezza di un triangolo conoscendo i lati a,b,c vale:

                  (a^2 + c^2 - b^2)^2
  h = sqrt(a^2 - ---------------------)
                        4*c^2


---------------------------------------------------------
Tre funzioni per calcolare la potenza di un numero intero
---------------------------------------------------------

Funzione 1:

(define (** num power)
    (let (out 1L)
        (dotimes (i power)
            (setq out (* out num)))))

Funzione 2:

(define (power b e)
  (local (tmp out)
    (setq out 1L)
    (setq tmp b)
    (while (> e 0)
      (if (= (% e 2) 1)
          (setq out (* out tmp))
      )
      (setq tmp (* tmp tmp))
      (setq e (/ e 2))
    )
    out))

Funzione 3:

(define (pow-i num power)
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))
        )
    )
    out))

(= (power 12345L 1234L) (pow-i 12345L 1234L))
;-> true

(= (** 12345L 1234L) (pow-i 12345L 1234L))
;-> true

Vediamo i tempi di esecuzione:

Valori grandi:
(time (** 12345L 123L) 100000)
;-> 2035.584
(time (power 12345L 123L) 100000)
;-> 930.511
(time (pow-i 12345L 123L) 100000)
;-> 732.511

Valori piccoli:
(time (** 123L 12L) 100000)
;-> 162.583
(time (power 123L 12L) 100000)
;-> 326.134
(time (pow-i 123L 12L) 100000)
;-> 304.169

Il risultati sono contrastanti: la funzione 1 è la più veloce per valori piccoli, mentre la funzione 3 è la più veloce per valori grandi.


----------------
Numeri Armstrong
----------------

I numeri Armstrong (PlusPerfect o narcisistici) sono numeri con m cifre che sono uguali alla somma di ogni cifra elevata a m.
Sequenza OEIS A005188:
  1, 2, 3, 4, 5, 6, 7, 8, 9, 153, 370, 371, 407, 1634, 8208, 9474,
  54748, 92727, 93084, 548834, 1741725, 4210818, 9800817, 9926315,
  24678050, 24678051, 88593477, 146511208, 472335975, 534494836,
  912985153, 4679307774, 32164049650, 32164049651

Funzione 1 che calcola la potenza di un numero intero:

(define (pow-i num power)
  (local (pot out)
    (if (zero? power)
        (setq out 1L)
        (begin
          (setq pot (pow-i num (/ power 2)))
          (if (odd? power)
              (setq out (* num pot pot))
              (setq out (* pot pot)))
        )
    )
    out))

Funzione 2 che calcola la potenza di un numero intero:

(define (** num power)
    (let (out 1L)
        (dotimes (i power)
            (setq out (* out num)))))

Funzione che verifica se un numero è Armstrong:

(define (armstrong? num)
  (local (p digit sum tmp)
    (setq p (length num))
    (setq tmp num)
    (setq sum 0)
    (while (!= 0 tmp)
      (setq digit (% tmp 10))
      ; time 1: pow-i
      (setq sum (+ sum (pow-i digit p)))
      ; time 2: **
      ;(setq sum (+ sum (** digit p)))
      (setq tmp (/ tmp 10))
    )
    (= sum num)))

(armstrong? 4)
;-> true

Funzione che calcola i numeri Armstrong fino ad un determinato limite:

(define (armstrong-to limit)
  (local (out)
    (for (i 1 limit)
      (if (armstrong? i)
        (push i out -1)))
    out))

; time 1: pow-i
(time (println (armstrong-to 1e6)))
;-> (1 2 3 4 5 6 7 8 9 153 370 371 407 1634
;->  8208 9474 54748 92727 93084 548834)
;-> 8710.681
(time (println (armstrong-to 1e7)))
;-> (1 2 3 4 5 6 7 8 9 153 370 371 407 1634 8208 9474 54748
;->  92727 93084 548834 1741725 4210818 9800817 9926315)
;-> 101966.673

; time 2: **
(time (println (armstrong-to 1e6)))
;-> (1 2 3 4 5 6 7 8 9 153 370 371 407 1634
;->  8208 9474 54748 92727 93084 548834)
;-> 8282.203
(time (println (armstrong-to 1e7)))
;-> (1 2 3 4 5 6 7 8 9 153 370 371 407 1634 8208 9474 54748
;->  92727 93084 548834 1741725 4210818 9800817 9926315)
;-> 108572.944

I numeri Armstrong vengono utilizzati nella sicurezza sulla trasmissione di dati. Il primo passo consiste nell'assegnare un colore univoco a ciascun destinatario (receiver). Ogni colore è rappresentato con un insieme di tre valori. Ad esempio il colore rosso viola è rappresentato in formato RGB come (238, 58,140). Poi si assegna una serie di tre valori chiave a ciascun destinatario. Il mittente (sender) è a conoscenza del destinatario richiesto a cui devono essere inviati i dati. Quindi il colore univoco del destinatario viene utilizzato come password. Il set di tre valori chiave viene aggiunto ai valori del colore originale e crittografato dal lato del mittente. Questo colore crittografato funge effettivamente da password. I dati effettivi vengono crittografati utilizzando i numeri Armstrong.


---------------------------------------------------------------------
Evoluzione dell'algoritmo per la moltiplicazione di due numeri interi
---------------------------------------------------------------------

L'algoritmo standard per la moltiplicazione di interi è quello scolastico con riporto ed ha una complessità temporale O(N^2). Solo nel 1960 è stato sviluppato un nuovo algoritmo (karatsuba) con tempo O(N^1.58) e nel 1970 è stato dimostrato che l'agoritmo più veloce possibile ha complessità O(N*logN).

Ci sono voluti più di 60 anni per passare da O(N^2) a O(N*logN), ma è stato un viaggio interessante. Questo è un momento importante perché si tratta di uno dei pochi argomenti fondamentali che l'uomo sia riuscito a capire ed ottimizzare al limite.

Nel 1971 è stato sviluppato l'algoritmo di Schonhage Strassen che funziona con tempo O(N*logN*loglogN) e ha mantenuto il record per 36 anni prima di essere battuto dall'algoritmo di Furer nel 2007. Da allora, i progressi sono stati costanti e un algoritmo con tempo O(N*logN), scoperto nel marzo 2019, è la possibile fine di questa ricerca umana.

La tabella seguente gli algoritmi che hanno definito questa era:

Algoritmo                  Complessità               Anno    Note
-------------------------- ------------------------------------------------
School Multiplication      O(N^2)                    100 AC  -
Russian Peasant Method     O(N^2 * logN)             1000    -
Karatsuba                  O(N^1.58)                 1960    -
Toom Cook multiplication   O(N^1.46)                 1963    -
Schonhage Strassen         O(N * logN * loglogN)     1971    FFT
Furer                      O(N * logN * 2^O(log*N))  2007    -
DKSS                       O(N * logN * 2^O(log*N))  2008    Modulare
Harvey, Hoeven, Lecerf     O(N * logN * 2^3 log*N)   2015    Primi Mersenne
Covanov and Thomé          O(N * logN * 2^2 log*N)   2015    Primi Fermat
Harvey and van der Hoeven  O(N * logN)               2019    Fine (!?)

Nota: la complessità temporale considera la moltiplicazione di due numeri di N cifre.

Approcci di base O(N^2)
-----------------------
La moltiplicazione intera inizia con l'approccio di base insegnato a scuola che ha una complessità temporale di O(N^2). Sebbene ci sia voluto un tempo significativo per migliorare la complessità del tempo, questo non ci ha impedito di apportare miglioramenti su questo.

Un miglioramento è stato ridurre la moltiplicazione a N addizioni poiché nei sistemi informatici l'addizione è molto più veloce. Questo potrebbe non essere vero nei sistemi moderni poiché entrano in scena diverse ottimizzazioni.

Un altro approccio era effettuare la moltiplicazione in potenze di due (algoritmo del contadino russo). Sebbene questo aumenti la complessità temporale, le prestazioni reali sono buone poiché la moltiplicazione per 2 viene eseguita utilizzando un'operazione di spostamento a sinistra che richiede un tempo costante O(1).

Ci sono molte altre varianti, ma il vero progresso è stato fatto a partire dagli anni '60 quando sono stati scoperti diversi ottimi algoritmi.

Anni '60: da O(N^2) a O(N^1.58) a O(N^1.46)
-------------------------------------------
Tutto è iniziato con l'algoritmo Karatsuba che è stato il primo algoritmo a dimostrare che la moltiplicazione intera può essere eseguita più velocemente di O(N^2). Era un momento in cui gli scienziati erano bloccati in questo problema.

L'algoritmo è stato scoperto nel 1960 da Anatoly Karatsuba. È basato su un approccio divide et impera e ha una complessità temporale di O(N^1.58).

I progressi successivi furono fatti rapidamente e nel 1963 Toom Cook formulò un algoritmo cha ha una complessità temporale di O(N^1.46).

Le notizie dei progressi si diffusero velocemente anche in quei giorni senza internet e questo campo era di nuovo in attiva ricerca. Ci sono voluti circa altri 7 anni per scoprire un nuovo algoritmo che avrà un enorme impatto per decenni.

Anni '70s: l'inizio di una nuova sfida
--------------------------------------
L'algoritmo di Schonhage Strassen è uno dei più grandi progressi compiuti nella moltiplicazione dei numeri interi. È stato formulato nel 1971 ed è rimasto il più importante algoritmo di moltiplicazione di numeri interi per oltre 36 anni.

Ha una complessità temporale di O(N*logN*loglogN) e utilizza l'idea della Fast Fourier Transform.

Sebbene questo fosse un passo importante, ci sono voluti diversi anni per migliorarlo. Questo ha dato la sensazione che il dominio stesse diventando troppo complicato da affrontare ma, come sappiamo, alla fine ce l'abbiamo fatta.

2007: la svolta
---------------
L'algoritmo di Furer è stato un importante passo avanti in quanto dal 1971 al 2007 non sono stati compiuti progressi fondamentali. Comunque ha dimostrato che sono possibili ulteriori progressi. Inoltre ha migliorato la complessità temporale a O(N*logN*2^O(logN)).

Ha migliorato la parte loglogN dell'algoritmo Schonhage Strassen che è vero per grandi numeri come 2^2^64.

Nonostante ciò, rimane di interesse teorico solo a causa di diverse sfide importanti per il suo utilizzo in applicazioni pratiche. Ciò ha aperto un nuovo interesse per il problema e negli anni successivi sono state proposte diverse ottimizzazioni, ma nessuna lo ha reso adatto all'uso pratico. Quindi, l'algoritmo di Schonhage Strassen ha continuato ad essere utilizzato in tutti gli usi pratici.

Ulteriori miglioramenti fino a O(N*logN)
-----------------------------------
Dal 2007 sono stati apportati diversi miglioramenti agli algoritmi di Furer.

L'algoritmo DKSS è stato un approccio notevole in quanto ha raggiunto la stessa complessità temporale dell'algoritmo di Furer. Si basa sull'aritmetica modulare ed è più semplice. È uscito nel 2008 e ha una complessità temporale di O(N*logN*2^O(logN)). Questo è più veloce dell'algoritmo Schonhage Strassen per i numeri maggiori di 10^10^4796.

Nel 2015, Harvey, Hoeven e Lecerf hanno inventato un algoritmo con una costante limitata migliore rispetto all'algoritmo di Furer. Si basava sui numeri primi di Mersenne e aveva una complessità temporale di O(N*logN*2^(3*logN)) dove la costante è 3 mentre nell'algoritmo di Furer non è limitata e può essere più grande come 8.

Presto, Covanov e Thomé nello stesso anno 2015, hanno inventato un altro algoritmo basato su Fermat Primes e hanno migliorato il fattore costante a 2. La complessità temporale è migliorata a O(N*logN*2^(2^logN)).

Nonostante questi miglioramenti, gli algoritmi non erano adatti all'uso pratico e venivano apportati miglioramenti minimi. Per una nota positiva, abbiamo diversi algoritmi con diverse idee di base.

I maggiori progressi sono stati compiuti nel marzo 2019 da Harvey e van der Hoeven. Hanno proposto un algoritmo con complessità temporale di O(N logN). Questo è significativo in quanto nel 1971 Volker Strassen dimostrò che la migliore complessità possibile per la moltiplicazione intera dovrebbe essere O(N*logN) e quindi siamo arrivati ​​alla fine. Comunque questo risultato è in corso di verifica.


--------------------
Indice di equilibrio
--------------------

Data una lista trovare, se esiste, un indice tale che la somma della sottolista a sinistra dell'indice è uguale alla somma della sottolista a  destra dell'indice: tale indice viene chiamato "Indice di equilibrio". In formula:

  A(0) + A(1) + … + A(i-1) = A(i+1) + A(i+2) + … + A(n-1), dove 0 < i < n-1

Per esempio:
lista = (3 4 1 5 2 6)
indice di equilibrio: 3

Infatti, lista(3) = 5, (3 + 4 + 1) = (2 + 6)

Metodo brute-force, confrontiamo le somme destre e sinistre per ogni indice:

(define (eq-idx1 lst)
(catch
  (local (lsum rsum)
    (dolist (el lst)
      (setq lsum (- (apply + (slice lst 0 (+ $idx 1))) el))
      (setq rsum (- (apply + (slice lst $idx)) el))
      ;(println lsum { } rsum)
      (if (= lsum rsum) (throw $idx))
    )
    nil)))

(eq-idx1 '(3 4 1 5 2 6))
;-> 3
(eq-idx1 '(5 7 4 5 8 8))
;-> 3
(eq-idx1 '(1 2 3 4 5 10))
;-> 4
(eq-idx1 '(1 2 5 4 5 6))
;-> nil

Questo algoritmo impiega O(n) tempo per attraversare ogni indice e O(n) tempo per calcolare la somma delle sottoliste per ogni indice, quindi la complessità temporale totale è O(n^2).
Poichè non utilizziamo spazio extra, la complessità spaziale è costante O(1).

Metodo con lista dei suffissi e dei prefissi:

Passo 1: attraversare la lista da sinistra a destra e calcolare e memorizzare la somma cumulativa in corrispondenza di ogni elemento in una lista. Questo lista è la somma dei prefissi.
Passo 2: l'ultimo elemento in questa lista di prefissi è la somma di tutti gli elementi della lista.
Passo 3: prendere una nuova lista e assegnare questa somma al suo primo elemento. Ad ogni elemento, sottrai il valore dell'elemento dal valore calcolato in precedenza e memorizzalo nella lista. Questa lista sè la somma dei suffissi.
Passo 4: confrontare le due liste e trovare, se esiste, l'indice in cui entrambe le liste hanno elementi identici e stampare questo indice.

Per esempio:
lista: 1 6 2 7
lista somma prefisso: 1 7 9 16
lista somma suffisso: 16 15 9 7
All'indice 2 entrambe le liste hanno lo stesso elemento (9), quindi 2 è l'indice di equilibrio.

(define (eq-idx2 lst)
(catch
  (local (len pref-sum suff-sum)
    (setq len (length lst))
    ; calcola lista dei prefissi
    (setq pref-sum (array len '(0)))
    (setf (pref-sum 0) (lst 0))
    (for (i 1 (- len 1))
      (setf (pref-sum i) (+ (pref-sum (- i 1)) (lst i)))
    )
    ; calcola lista dei suffissi
    (setq suff-sum (array len '(0)))
    (setf (suff-sum 0) (pref-sum (- len 1)))
    (for (i 1 (- len 1))
      (setf (suff-sum i) (- (suff-sum (- i 1)) (lst (- i 1))))
    )
    ;(println pref-sum { } suff-sum)
    (for (i 1 (- len 2))
      (if (= (pref-sum i) (suff-sum i))
          (throw i)
      )
    )
    nil)))

(eq-idx2 '(1 6 2 7))
;-> 2
(eq-idx2 '(3 4 1 5 2 6))
;-> 3
(eq-idx2 '(5 7 4 5 8 8))
;-> 3
(eq-idx2 '(1 2 3 4 5 10))
;-> 4
(eq-idx2 '(1 2 5 4 5 6))
;-> nil

Questo algoritmo impiega O(n) tempo per creare la lista somma dei prefissi, O(n) tempo per formare la lista delle somme dei suffissi e O(n) tempo per trovare l'indice con elementi identici nelle due liste. Quindi la complessità temporale totale vale O(n).
Poiché abbiamo creato altre due liste, ciascuno di dimensione n, la complessità spaziale vale O(n).
Potremmo migliorare quest'ultimo algoritmo evitando di calcolare la lista dei suffissi, infatti risulta:

  suff-sum(i) = pref-sum(N) - pref-sum(i)

Questo perchè:

  pref-sum(N) = a1 + a2 + ... + aN

  pref-sum(i) = a1 + a2 + ... + ai

Quindi, pref-sum(N) - pref-sum(i) = a(i+1) + ... + aN

Di conseguenza, suff-sum(i) = pref-sum(N) - pref-sum(i).

Per calcolare i tempi di esecuzione generiamo due liste con 100 e 1000 numeri casuali da 0 10 e troviamone due che hanno un indice di equilibrio:

(for (i 1 1000)
  (setq test (rand 10 100))
  (if (eq-idx2 test)
      (setq a test)))
(eq-idx1 a)
;-> 47
(eq-idx2 a)
;-> 47

(for (i 1 1000)
  (setq test (rand 10 1000))
  (if (eq-idx2 test)
      (setq b test)))
(eq-idx1 b)
;-> 486
(eq-idx2 b)
;-> 488

Adesso vediamo la differenza di velocità tra le due funzioni:

(time (eq-idx1 a) 10000)
;-> 1008.312
(time (eq-idx2 a) 10000)
;-> 398.961

(time (eq-idx1 b) 10000)
;-> 97280.153
(time (eq-idx2 b) 10000)
;-> 13656.492


------------------------------------------------
Numero soluzioni equazione lineare a k variabili
------------------------------------------------

Trovare il numero di soluzioni non negative di un'equazione lineare con k variabili a coefficienti interi positivi:

  a1*x1 + a2*x2 + ...  + an*xn = c

Per esempio, consideriamo l'equazione lineare in due variabili 3a1 + a2 = 9. Le soluzioni non negative (a1 a2) di questa equazione sono: (0 9), (1 6), (2 3) e (3 0). Quindi l'equazione ha 4 soluzioni non negative.

Esempio:
Input:  coeff = (1 3 5 7), c = 8
Output: 6 (numero totale di soluzioni)

L'input sopra rappresenta l'equazione a + 3b + 5c + 7d = 8 che ha le seguenti 6 soluzioni positive intere:

  ( a = 1, b = 0, c = 0, d = 1 )
  ( a = 0, b = 1, c = 1, d = 0 )
  ( a = 2, b = 2, c = 0, d = 0 )
  ( a = 3, b = 0, c = 1, d = 0 )
  ( a = 5, b = 1, c = 0, d = 0 )
  ( a = 8, b = 0, c = 0, d = 0 )

Esempio:
Input:  coeff = (1 2 3), c = 4
Output: 4 (numero totale di soluzioni)

L'input sopra rappresenta l'equazione x + 2y + 3z = 4 che ha le seguenti 4 soluzioni positive intere:

  ( x = 1, y = 0, z = 1 )
  ( x = 0, y = 2, z = 0 )
  ( x = 2, y = 1, z = 0 )
  ( x = 4, y = 0, z = 0 )

Il problema è simile a quello di trovare il numero totale di modi per ottenere un certo valore con un insieme di monete diverse. In questo caso i coefficienti dell'equazione possono essere considerati come i valori delle monete e il termine noto "c" dell'equazione rappresenta il valore da ottenere.
La definizione ricorsiva del problema è la seguente:

  count-sol(coeff, k, c) = count-sol(coeff, k, c - coeff(k)) + count-sol(coeff, k - 1, c)

Cioè, per ogni coefficiente di ogni variabile:
  - Includere il coefficiente corrente coeff(k) nella soluzione e ricorrere con il valore rimanente c - coeff(k) .
  - Escludere il coefficiente corrente coeff(k) dalla soluzione e ricorrere ai coefficienti rimanenti k-1 .
Infine, restituire i modi totali includendo o escludendo il coefficiente corrente.
I casi base della ricorsione sono:
1) quando viene trovata la soluzione (cioè, c diventa 0), oppure
2) la soluzione non esiste (quando non sono rimasti coefficienti, o c diventa negativo).

(define (count-sol coeff k c)
  (local (include exclude)
         ; se c = 0, allora abbiamo trovato una soluzione
  (cond ((= c 0) 1)
         ; se c diventa negativo o non ci sono più coefficienti
         ; allora restituisce 0
        ((or (< c 0) (< k 0)) 0)
        (true
          ; altrimenti
          ; Caso 1. Includere il coeff corrente "coeff[k]" nella soluzione e
          ;         ricorsione con il valore rimanente "c - coeff[k]"
          (setq include (count-sol coeff k (- c (coeff k))))
          ; Caso 2. Escludere il coeff corrente "coeff[k]" dalla soluzione e
          ;         ricorsione con il valore rimanente "k - 1"
          (setq exclude (count-sol coeff (- k 1) c))
          ; restituire i modi totali includendo o escludendo il coefficiente corrente
          (+ include exclude)))))

(define (solutions coeff k c)
    (count-sol coeff (- k 1) c))

(solutions '(1 2 3) 3 4)
;-> 4
(solutions '(1 3 5 7) 4 8)
;-> 6

Questo algoritmo ha complssità temporale esponenziale ed utilizza parecchio spazio nello stack per le chiamate ricorsive.

Possiamo scrivere una versione bottom-up utilizzando la tecnica di memoizzazione:

(define (conta-sol coeff k c)
  (let (dp (array (+ c 1) '(0)))
    (setf (dp 0) 1)
    (for (i 0 (- k 1))
      (for (j (coeff i) c)
        (setf (dp j) (+ (dp j) (dp (- j (coeff i)))))
      )
    )
    (dp c)))

(conta-sol '(1 2 3) 3 4)
;-> 4

(conta-sol '(1 3 5 7) 4 8)
;-> 6


--------------
Internet-point
--------------

Un internet-point possiede N computer. I clienti sono rappresentati da una stringa di caratteri. Ogni carattere è ripetuto due volte: la prima occorrenza rappresenta l'ingresso nel locale, la seconda occorrenza rappresenta l'uscita dal locale.
Le regole di utilizzo di un computer sono le seguenti:
1) quando arriva un cliente, se è libero un computer, allora lo occupa, altrimenti si mette in attesa.
2) quando si libera un computer, se esistono clienti in attesa, allora il primo della lista occupa un computer.
3) i clienti possono lasciare il locale anche senza aver utilizzato un computer.

Determinare il numero di clienti che hanno utilizzato un computer e il numero di quelli che non lo hanno utilizzato.

Esempio:
stringa: "ABCDDBAC"
computer: 2
sequenza clienti: A B C D D B A C
Cliente A -> entra e prende computer
Cliente B -> entra e prende computer
Cliente C -> entra e attende
Cliente D -> entra e attende
Cliente D -> esce dal locale
Cliente B -> lascia computer ==> C prende computer (era in attesa)
Cliente A -> lascia computer (attesa è vuota)
Cliente C -> lascia computer

Clienti computer: 3 (A B C)
Clienti no-computer: 1 (D)

Esempio:
stringa: "ABCDBACD"
computer: 2
sequenza clienti: A B C D B A C D
Cliente A -> entra e prende computer
Cliente B -> entra e prende computer
Cliente C -> entra e attende
Cliente D -> entra e attende
Cliente B -> lascia computer ==> C prende computer (era in attesa)
Cliente A -> lascia computer ==> D prende computer (era in attesa)
Cliente C -> lascia computer ==> (nessuno in attesa)
Cliente D -> lascia computer ==> (nessuno in attesa)

Clienti computer: 4 (A B C D)
Clienti no-computer: 0

La spiegazione del metodo di soluzione si trova nei commenti alla funzione.

(define (fila seq computer)
  (local (liberi serv noserv clienti attesa fatti)
  (setq liberi computer)
  (setq serv 0) ; numero clienti serviti
  (setq noserv 0) ; numero clienti non serviti
  (setq attesa '()) ; lista clienti in attesa
  (setq fatti '()) ; lista clienti fatti
  (setq clienti (explode seq)) ; sequenza temporale dei clienti
  ; per ogni elemento nella sequenza (azione del cliente)
  (dolist (cl clienti)
    ; cliente nella lista attesa?
    (setq a (find cl attesa))
    ; cliente nella lista fatti?
    (setq f (find cl fatti))
    ; controllo della tipologia del cliente...
    ; 1) Cliente nuovo, oppure
    ; 2) Cliente che esce dal locale (dalla lista di attesa), oppure
    ; 3) Cliente che esce dal locale (dalla lista di fatti)
    (cond ((and (nil? a) (nil? f)) ; Se è un cliente nuovo
           (if (> liberi 0) ; se ci sono computer liberi
            (begin
               (-- liberi) ; prende un computer
               (push cl fatti) ; cliente nella lista fatti
            )
            (begin ; altrimenti
               (push cl attesa -1) ; cliente in attesa
            )))
          ((not (nil? f)) ; Se il cliente esce dal locale servito
           (print cl { })
           (++ serv)      ; aumenta clienti serviti
           (++ liberi)    ; libera un computer
           (pop fatti f)  ; esce dalla lista di fatti
           (if (> (length attesa) 0) ; se ci sono clienti in attesa
            (begin
               ; prendo il primo cliente in attesa
               ; e lo inserisco nella lista fatti
               (push (pop attesa) fatti)
               (-- liberi) ; occupa un computer
            )))
          ((not (nil? a)) ; Se il cliente esce dal locale non servito
           (++ noserv)     ; aumenta clienti non serviti
           (pop attesa a)) ; esce dalla lista di attesa
    )
  )
  (list serv noserv)))

Facciamo alcune prove:

(fila "ABCDDBAC" 2)
;-> B A C (3 1)
(fila "ABCDBACD" 2)
;-> B A C D (4 0)
(fila "ABCDDCEFFEBGAG" 2)
;-> B A G (3 4)
(fila "ABCDDCEFFBEGAG" 2)
;-> B E A G (4 3)
(fila "ABCDDCEFBEGAFG" 2)
;-> B E A F G (5 2)
(fila "ABCBDAEDFCFGEG" 2)
;-> B A D C F E G (7 0)

=============================================================================

