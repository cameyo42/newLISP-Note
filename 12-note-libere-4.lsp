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

In questo paragrafo vengono implementati gli algoritmi tratti dal libro:

"Primality Testing in Polynomial Time" di Martin Dietzfelbinger

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

Nota: l'espressione deve contenere solo variabili, gli operatori logici "and", "or", "not" e i caratteri "(" ")".


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

=============================================================================

