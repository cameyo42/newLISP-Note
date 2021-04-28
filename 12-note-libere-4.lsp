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

;
; TODO
;
(define (todo)
  (local (todo-filename todo-file todo-lines
          items funcs link nitems in choice)
    (println "TODO MANAGER")
    (println "============")
    ; voci del menu
    (setq items '("Elenco note" "Nuova nota" "Modifica nota" "Elimina nota" "Cerca... " "Fine"))
    ; funzioni del menu
    (setq funcs (list show-note new-note edit-note delete-note search-note quit))
    (setq link (map list items funcs))
    ; numero di voci/funzioni del menu
    (setq nitems (length items))
    ; nome del file di testo
    (setq todo-filename "todo-test.txt")
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
    ; visualizza le voci del menu
    (setq choice nil)
    (dolist (el items) (println (+ $idx 1) ". " el))
    ; scelta della funzione...
    (while (not choice)
      (print "Seleziona: ")
      (setq in (int (read-line) 0 10))
      (if (or (< in 1) (> in nitems))
          (println "Numero inesistente:" in)
          (setq choice true)
      )
    )
    (println "")
    ; chiama la funzione selezionata
    ((funcs (- in 1)))
)
;
; RETURN-MENU
;
(define (return-menu)
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
    (println "- "linea)
  )
  (return-menu)
)
;
; NEW-NOTE
;
(define (new-note)
  (println "Nuova nota:")
  (print "> ")
  ; legge e inserisce la nota nella lista
  (push (read-line) todo-lines -1)
  (println "Nota inserita.")
  (return-menu)
)
;
; EDIT-NOTE
;
(define (edit-note) (println "edit-note"))
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
  (return-menu)
)
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

(todo)


