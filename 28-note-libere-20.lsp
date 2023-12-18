================

 NOTE LIBERE 20

================

-------
For Fun
-------

  π to √-1: get real
  √-1 to π: be rational

  π to √-1: π/π
  √-1 to π: (√-1)²


------------
Segment Tree
------------

Traduzione parziale da:
https://e-maxx.ru/algo/segment_tree
created by e-maxx aka maxdiver aka Ivanov Maxim
https://cp-algorithms.com/data_structures/segment_tree.html

Segment tree
------------
Un "segment tree" (albero dei segmenti) è una struttura dati che memorizza informazioni sugli intervalli di un array in un albero.
A Segment Tree is a data structure that stores information about array intervals as a tree.
Questo consente di rispondere in modo efficiente alle query sugli intervalli di un array, pur essendo sufficientemente flessibile da consentire una rapida modifica dell'array.
È possibile trovare la somma di elementi consecutivi dell'array a[l..r] o trovare l'elemento minimo in tale intervallo in tempo O(log(n)).
Oltre a rispondere a queste domande, il segment tree consente di modificare l'array sostituendo un elemento o anche modificando gli elementi di un intero sottosegmento (ad esempio assegnando tutti gli elementi a[l..r] a qualsiasi valore o aggiungendo un valore a tutti gli elementi del sottosegmento).

In generale, un segment tree è una struttura dati molto flessibile e con essa è possibile risolvere un grande numero di problemi.
Inoltre, è anche possibile applicare operazioni più complesse e rispondere a domande più complesse.
(vedi Versioni avanzate dei segment tree).

In particolare il segment tree può essere facilmente generalizzato a dimensioni maggiori.
Ad esempio, con un segment tree bidimensionale è possibile rispondere a domande di somma o minimo su un sottorettangolo di una determinata matrice in tempo O(log^2(n))

Una proprietà importante dei segment tree è che richiedono solo una quantità lineare di memoria.
Il Segment Tree standard richiede 4n vertici per lavorare su un array di dimensione n.

Forma più semplice di un Segment Tree
-------------------------------------
Per iniziare in modo semplice, consideriamo la forma più semplice di un segment-tree.
Vogliamo rispondere alle domande di somma di sottointervalli in modo efficiente.
La definizione formale del nostro compito è:
Dato un array a[0..(n-1)] il segment tree deve essere in grado di trovare la somma degli elementi tra gli indici "l" e "r" (ovvero calcolando la somma Sum[i=l..r](a[i])), e anche gestire la modifica dei valori degli elementi nell' array (cioè eseguire assegnamenti nella forma a[i] = x).
Il segment-tree dovrebbe essere in grado di elaborare entrambe le query in tempo O(log n).

Questo è un miglioramento rispetto agli approcci più semplici.
Un'implementazione ingenua dell'array, che utilizza un semplice array, può aggiornare gli elementi in O(1), ma richiede O(n) per calcolare ciascuna query di somma.
E le somme dei prefissi precalcolati possono calcolare le query di somma in O(1), ma l'aggiornamento di un elemento dell'array richiede
O(n) per cambiare le somme dei prefissi.

Struttura del segment tree
--------------------------
Possiamo adottare un approccio divide et impera quando si tratta di segmenti di array.
Calcoliamo e memorizziamo la somma degli elementi dell'intero array, ovvero la somma del segmento a[0..(n-1)].
Quindi dividiamo l'array in due metà a[0..(n/2-1)] e a[n/2..(n-1)], calcoliamo la somma di ciascuna metà e le memorizziamo.
Ognuna di queste due metà viene a sua volta divisa a metà e così via finché tutti i segmenti raggiungono la dimensione 1.

Possiamo vedere questi segmenti come se formassero un albero binario: la radice di questo albero è il segmento a[0..(n-1)], e ogni vertice (eccetto i vertici foglia ha esattamente due vertici figli.
Questo è il motivo per cui la struttura dati è chiamata "Segment Tree", anche se nella maggior parte delle implementazioni l'albero non è costruito esplicitamente (vedi Implementazione).

Ecco una rappresentazione visiva di tale segment-tree sull'array a = [1, 3, -2, 8, -7]:

                               +---------+
                               | a[0..4] |
                               | sum = 3 |
                               +---------+
                              /           \
                             /             \
                            /               \
                 +---------+                 +---------+
                 | a[0..2] |                 | a[3..4] |
                 | sum = 2 |                 | sum = 1 |
                 +---------+                 +---------+
                /           \               /           \
               /             \             /             \
          +---------+   +---------+   +---------+   +---------+
          | a[0..1] |   | a[2..2] |   | a[3..3] |   | a[4..4] |
          | sum = 4 |   | sum =-2 |   | sum = 8 |   | sum = 7 |
          +---------+   +---------+   +---------+   +---------+
         /           \
        /             \
   +---------+    +---------+
   | a[0..0] |    | a[1..1] |
   | sum = 1 |    | sum = 3 |
   +---------+    +---------+

Da questa breve descrizione della struttura dati, possiamo già concludere che un Segment Tree richiede solo un numero lineare di vertici.
Il primo livello dell'albero contiene un singolo nodo (la radice), il secondo livello conterrà due vertici, nel terzo conterrà quattro vertici, finché il numero di vertici non raggiunge n.
Pertanto il numero di vertici nel caso peggiore può essere stimato dalla somma:
1 + 2 + 4 + ... + 2^(ceil(log2(n)) < 2^(ceil(log2(n))+1) < 4n.

Vale la pena notare che ogni volta che n non è una potenza di due, non tutti i livelli del segment-tree saranno completamente riempiti.
Possiamo vedere quel comportamento nella figura sopra.
Per ora possiamo dimenticare questo fatto, ma diventerà importante più avanti durante il processo di implementazione.

L'altezza del segment-tree è O(log(n)), perché scendendo dalla radice alle foglie la dimensione dei segmenti diminuisce circa della metà.

Costruzione
-----------
Prima di costruire il segment tree, dobbiamo decidere:

1) il valore che viene memorizzato in ciascun nodo del segment tree.
Ad esempio, in un segment-tree di somma, un nodo memorizzerebbe la somma degli elementi nel suo intervallo [l, r].

2) l'operazione di unione che unisce due fratelli (sibling) in un segment-tree.
Ad esempio, in un segment-tree somma, i due nodi che corrispondono agli intervalli a[l1..r1] e a[l2..r2] verrebbe unito in un nodo corrispondente all'intervallo a[l1..r2] sommando i valori dei due nodi.

Si noti che un vertice è un "vertice foglia" (leaf), se il segmento corrispondente copre solo un valore nell'array originale.
È presente al livello più basso di un segment-tree.
Il suo valore sarebbe pari all'elemento (corrispondente) a[i].

Ora, per la costruzione del segment-tree, iniziamo dal livello inferiore (i vertici delle foglie) e assegniamo loro i rispettivi valori.
Sulla base di questi valori possiamo calcolare i valori del livello precedente, utilizzando la funzione di unione (merge).
E sulla base di questi possiamo calcolare i valori del precedente e ripetere la procedura fino a raggiungere il vertice della radice.

È conveniente descrivere questa operazione ricorsivamente nell'altra direzione, cioè dal vertice della radice ai vertici della foglia.
La procedura di costruzione, se chiamata su un vertice non foglia, fa quanto segue:

1. costruisce ricorsivamente i valori dei due vertici figli
2. unisce i valori calcolati di questi figli.

Iniziamo la costruzione dal vertice della radice e quindi siamo in grado di calcolare l'intero segment-tree.

La complessità temporale di questa costruzione è O(n), presupponendo che l'operazione di unione sia a tempo costante (l'operazione di unione viene chiamata n volte, che è uguale al numero di nodi interni nel segment-tree).

Domande (query) di somma
------------------------
Per ora risponderemo alle domande di somma.
Riceviamo in input due numeri interi l e r e dobbiamo calcolare la somma del segmento a[l...r] in tempo O(log(n)).

Per fare ciò, attraverseremo il segment tree e utilizzeremo le somme precalcolate dei segmenti.
Supponiamo di trovarci attualmente nel vertice che copre il segmento a[tl...tr].
Ci sono tre casi possibili.

Il caso più semplice è quando il segmento a[l...r] è uguale al segmento corrispondente del vertice corrente (cioè a[l...r] = a[tl...tr]), allora abbiamo finito e può restituire la somma precalcolata memorizzata nel vertice.

In alternativa, il segmento della query può ricadere completamente nel dominio del figlio sinistro o destro.
Ricordiamo che il figlio di sinistra copre il segmento a[tl...tm] e il vertice di destra copre il segmento a[tm+1...tr] con tm = (tl + tr)/2.
In questo caso possiamo semplicemente andare al vertice figlio, il cui segmento corrispondente copre il segmento della query, ed eseguire l'algoritmo qui descritto con quel vertice.

E poi c'è l'ultimo caso, il segmento di query si interseca con entrambi i figli.
In questo caso non abbiamo altra scelta che effettuare due chiamate ricorsive, una per ogni figlio.
Per prima cosa andiamo al figlio di sinistra, calcoliamo una risposta parziale per questo vertice (cioè la somma dei valori dell'intersezione tra il segmento della query e il segmento del figlio di sinistra), poi andiamo al figlio di destra, calcoliamo la risposta parziale utilizzando quel vertice, quindi combina le risposte sommandole.
In altre parole, poiché il figlio di sinistra rappresenta il segmento a[tl...tm] e il figlio di destra il segmento a[tm+1...tr], calcoliamo la query di somma a[l...tm] utilizzando il figlio sinistro e la query di somma a[tm+1...r] utilizzando il figlio corretto.

Quindi l'elaborazione di una query di somma è una funzione che richiama se stessa ricorsivamente una volta con il figlio sinistro o destro (senza modificare i limiti della query), o due volte, una volta per il figlio sinistro e una volta per quello destro (dividendo la query in due sottoquery ).
E la ricorsione termina ogni volta che i confini del segmento di query corrente coincidono con i confini del segmento del vertice corrente. In tal caso la risposta sarà il valore precalcolato della somma di questo segmento, che viene memorizzato nell'albero.

In altre parole, il calcolo della query è un attraversamento dell'albero, che si estende attraverso tutti i rami necessari dell'albero e utilizza i valori di somma precalcolati dei segmenti nell'albero.

Ovviamente inizieremo l'attraversamento dal vertice radice del Segment Tree.

La procedura è illustrata nell'immagine seguente.

Anche in questo caso viene utilizzato l'array a = [1, 3, -2, 8, -7] e qui vogliamo calcolare la somma sum{i=2..4}a[i].
Verranno visitati i vertici viola e utilizzeremo i valori precalcolati dei vertici verdi.
Questo ci dà il risultato -2 + 1 = -1.

                                  Viola
                               +---------+
                               | a[0..4] |
                               | sum = 3 |
                               +---------+
                              /           \
                             /             \
                    Viola   /               \   Verde
                 +---------+                 +---------+
                 | a[0..2] |                 | a[3..4] |
                 | sum = 2 |                 | sum = 1 |
                 +---------+                 +---------+
                /           \               /           \
               /             \Verde        /             \
          +---------+   +---------+   +---------+   +---------+
          | a[0..1] |   | a[2..2] |   | a[3..3] |   | a[4..4] |
          | sum = 4 |   | sum =-2 |   | sum = 8 |   | sum = 7 |
          +---------+   +---------+   +---------+   +---------+
         /           \
        /             \
   +---------+    +---------+
   | a[0..0] |    | a[1..1] |
   | sum = 1 |    | sum = 3 |
   +---------+    +---------+

Perché la complessità di questo algoritmo è O(log(n))?
Per mostrare questa complessità guardiamo ogni livello dell'albero.
Si scopre che per ogni livello visitiamo solo non più di quattro vertici.
E poiché l'altezza dell'albero è O(log(n)), otteniamo il tempo di esecuzione desiderato.

Possiamo dimostrare che questa proposizione (al massimo quattro vertici per livello) è vera per induzione.
Al primo livello visitiamo solo un vertice, il vertice radice, quindi qui visitiamo meno di quattro vertici.
Consideriamo ora un livello arbitrario.
Per ipotesi di induzione visitiamo al massimo quattro vertici.
Se visitiamo solo al massimo due vertici, il livello successivo avrà al massimo quattro vertici.
Questo è banale, perché ogni vertice può causare al massimo due chiamate ricorsive.
Supponiamo quindi di visitare tre o quattro vertici nel livello attuale.
Da questi vertici, analizzeremo più attentamente i vertici al centro.
Poiché la query di somma richiede la somma di un sotto-array continuo, sappiamo che i segmenti corrispondenti ai vertici visitati al centro saranno completamente coperti dal segmento della query di somma.
Pertanto questi vertici non effettueranno alcuna chiamata ricorsiva.
Quindi solo il vertice più a sinistra e quello più a destra avranno il potenziale per effettuare chiamate ricorsive.
E queste creeranno solo al massimo quattro chiamate ricorsive, quindi anche il livello successivo soddisferà l'asserzione.
Possiamo dire che un ramo si avvicina al limite sinistro della query e il secondo ramo si avvicina a quello destro.

Pertanto visitiamo al massimo 4*log(n) vertici in totale, e ciò equivale a un tempo di esecuzione di O(log(n)).

In conclusione la query funziona dividendo il segmento di input in più sottosegmenti per i quali tutte le somme sono già precalcolate e memorizzate nell'albero. E se interrompiamo il partizionamento ogni volta che il segmento della query coincide con il segmento del vertice, allora abbiamo bisogno solo di O(log(n)) tali segmenti, il che produce l'efficacia del segment tree.

Domande (query) di aggiornamento
--------------------------------

Ora vogliamo modificare un elemento specifico nell'array, diciamo che vogliamo eseguire l'assegnazione a[i] = x.
E dobbiamo ricostruire il segment tree, in modo che corrisponda al nuovo array modificato.

Questa query è più semplice della query di somma.
Ogni livello di un albero di segmenti costituisce una partizione dell'array.
Pertanto un elemento a[i] contribuisce solo ad un segmento per ciascun livello.
Pertanto solo i vertici O(log(n)) devono essere aggiornati.

È facile vedere che la richiesta di aggiornamento può essere implementata utilizzando una funzione ricorsiva.
Alla funzione viene passato il vertice corrente dell'albero e si richiama ricorsivamente con uno dei due vertici figli (quello che contiene a[i] nel suo segmento), quindi ricalcola il suo valore di somma, in modo simile a come viene fatto nel metodo build (ovvero come somma dei suoi due figli).

Anche in questo caso ecco una visualizzazione che utilizza lo stesso array.
Qui eseguiamo l'aggiornamento a[2] = 3.
I vertici verdi sono i vertici che visitiamo e aggiorniamo.

                                  Verde
                               +---------+
                               | a[0..4] |
                               | sum = 8 |
                               +---------+
                              /           \
                             /             \
                    Verde   /               \
                 +---------+                 +---------+
                 | a[0..2] |                 | a[3..4] |
                 | sum = 7 |                 | sum = 1 |
                 +---------+                 +---------+
                /           \               /           \
               /             \Verde        /             \
          +---------+   +---------+   +---------+   +---------+
          | a[0..1] |   | a[2..2] |   | a[3..3] |   | a[4..4] |
          | sum = 4 |   | sum = 3 |   | sum = 8 |   | sum = 7 |
          +---------+   +---------+   +---------+   +---------+
         /           \
        /             \
   +---------+    +---------+
   | a[0..0] |    | a[1..1] |
   | sum = 1 |    | sum = 3 |
   +---------+    +---------+

Implementazione
---------------
La considerazione principale è come memorizzare il segment tree.
Naturalmente possiamo definire una struttura 'Vertex' e creare oggetti che memorizzano i confini del segmento, la sua somma e inoltre anche i puntatori ai suoi vertici figli.
Tuttavia, ciò richiede la memorizzazione di molte informazioni ridondanti sotto forma di puntatori.
Utilizzeremo un semplice trucco per renderlo molto più efficiente utilizzando una struttura dati implicita: memorizzare solo le somme in un array. (Un metodo simile viene utilizzato per gli heap binari).
La somma del vertice radice all'indice 1, la somma dei suoi due vertici figli agli indici 2 e 3, la somma dei figli di questi due vertici agli indici da 4 a 7 e così via.
Con l'indicizzazione 1, convenientemente il figlio sinistro di un vertice all'indice i viene memorizzato nell'indice 2i e quello destro nell'indice 2i + 1.
In modo equivalente, il genitore di un vertice all'indice i viene memorizzato in i/2 (divisione intera ).

Questo semplifica molto l'implementazione.
Non abbiamo bisogno di memorizzare la struttura dell'albero in memoria. È definito implicitamente.
Abbiamo bisogno solo di un array che contenga la somma di tutti i segmenti.

Come notato prima, dobbiamo memorizzare al massimo 4n vertici. Potrebbe essere inferiore, ma per comodità assegniamo sempre un array di dimensione 4n. Ci saranno alcuni elementi nell'array sum che non corrisponderanno ad alcun vertice nell'albero reale, ma ciò non complica l'implementazione.

Quindi, memorizziamo il segment tree semplicemente come un array t[] con una dimensione pari a quattro volte la dimensione dell'input n:

int n, t[4*MAXN];

La procedura per costruire il segment tree da un dato array a[] è simile alla seguente: è una funzione ricorsiva con i parametri a[] (l'array di input), v (l'indice del vertice corrente) e i confini tl e tr del segmento corrente.
Nel programma principale questa funzione verrà chiamata con i parametri del vertice radice: v = 1, tl = 0 e tr = n - 1.

void build(int a[], int v, int tl, int tr) {
    if (tl == tr) {
        t[v] = a[tl];
    } else {
        int tm = (tl + tr) / 2;
        build(a, v*2, tl, tm);
        build(a, v*2+1, tm+1, tr);
        t[v] = t[v*2] + t[v*2+1];
    }
}

Inoltre la funzione per rispondere alle domande di somma è anche una funzione ricorsiva, che riceve come parametri informazioni sul vertice/segmento corrente (cioè l'indice v e i confini tl e tr) e anche le informazioni sui confini della query, l e r.
Per semplificare il codice, questa funzione esegue sempre due chiamate ricorsive, anche se ne è necessaria una sola: in tal caso la chiamata ricorsiva superflua avrà l > r, e questo può essere facilmente colto utilizzando un controllo aggiuntivo all'inizio della funzione.

int sum(int v, int tl, int tr, int l, int r) {
    if (l > r)
        return 0;
    if (l == tl && r == tr) {
        return t[v];
    }
    int tm = (tl + tr) / 2;
    return sum(v*2, tl, tm, l, min(r, tm))
           + sum(v*2+1, tm+1, tr, max(l, tm+1), r);
}

Infine la query di aggiornamento. 
La funzione riceverà anche informazioni sul vertice/segmento corrente e inoltre anche il parametro della query di aggiornamento (ovvero la posizione dell'elemento e il suo nuovo valore).

void update(int v, int tl, int tr, int pos, int new_val) {
    if (tl == tr) {
        t[v] = new_val;
    } else {
        int tm = (tl + tr) / 2;
        if (pos <= tm)
            update(v*2, tl, tm, pos, new_val);
        else
            update(v*2+1, tm+1, tr, pos, new_val);
        t[v] = t[v*2] + t[v*2+1];
    }
}

Implementazione Memory efficient
--------------------------------
La maggior parte delle persone utilizza l'implementazione della sezione precedente.
Se guardi l'array t puoi vedere che segue la numerazione dei nodi dell'albero nell'ordine di un attraversamento BFS (attraversamento dell'ordine dei livelli).
Utilizzando questo attraversamento i figli del vertice v sono rispettivamente 2v e 2v+1.
Tuttavia, se n non è una potenza di due, questo metodo salterà alcuni indici e lascerà alcune parti dell'array t inutilizzate.
Il consumo di memoria è limitato a 4n, anche se un segment tree di un array di n elementi richiede solo 2n - 1 vertici.

Tuttavia può essere ridotto.
Rinumeriamo i vertici dell'albero nell'ordine di un attraversamento del tour di Eulero (attraversamento in preordine) e scriviamo tutti questi vertici uno accanto all'altro.

Consideriamo un vertice con indice v, e sia responsabile del segmento [l, r], e poniamo mid = (l + r)/2.
È ovvio che il figlio di sinistra avrà indice v+1.
Il figlio di sinistra è responsabile del segmento [l, mid], ad es. in totale ci saranno 2 * (mid - l + 1) - 1 vertici nel sottoalbero del figlio di sinistra.
Possiamo quindi calcolare l'indice del figlio destro di v.
L'indice sarà v + 2 * (mid - l + 1). Con questa numerazione otteniamo una riduzione della memoria necessaria a 2n.

L'articolo continua con versioni avanzate della struttura segment tree "Advanced versions of Segment Trees" e analizza i seguenti argomenti:

 - Finding the maximum
 - Finding the maximum and the number of times it appears
 - Compute the greatest common divisor / least common multiple
 - Counting the number of zeros, searching for the k-th zero
 - Searching for an array prefix with a given amount
 - Searching for the first element greater than a given amount
 - Finding subsegments with the maximal sum
 - Find the smallest number greater or equal to a specified number. No modification queries.
 - Find the smallest number greater or equal to a specified number. With modification queries.
 - Find the smallest number greater or equal to a specified number. Acceleration with "fractional cascading".
 - Range updates - Addition on segments - Assignment on segments - Adding on segments, querying for maximum
 - Generalization to higher dimensions
 - Compression of 2D Segment Tree
 - Preserving the history of its values (Persistent Segment Tree)
 - Finding the k-th smallest number in a range
 - Dynamic segment tree (implicit segment tree or sparse segment tree)


----------------------------------------
Somma quadrata dei quadrati dei divisori
----------------------------------------

Determinare la sequenza dei numeri la cui somma dei quadrati dei divisori è anch'essa un numero quadrato.

Sequenza OEIS A046655:
Numbers whose sum of the squares of divisors is also a square number
  1, 42, 246, 287, 728, 1434, 1673, 1880, 4264, 6237, 9799, 9855, 18330,
  21352, 21385, 24856, 36531, 39990, 46655, 57270, 66815, 92664, 125255,
  156570, 182665, 208182, 212949, 242879, 273265, 380511, 391345, 411558,
  539560, 627215, 693160, 730145, 741096, ...

Esempio:
Numero = 42
Divisori: 1 2 3 6 7 14 21 42
Quadrati dei divisori: 1, 4, 9, 36, 49, 196, 441, 1764
Somma dei Quadrati dei divisori = 2500
Poichè 50x50 = 2500 si tratta di un quadrato perfetto, quindi il numero 42 fa parte della sequenza.

(define (divisors num)
"Generate all the divisors of an integer number"
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))
; auxiliary function
(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

Funzione che fattorizza un numero intero:

(define (factor-group num)
  (if (= num 1) '((1 1))
    (letn (fattori (factor num)
          unici (unique fattori))
      (transpose (list unici (count unici fattori))))))

Funzione che verifica se un numero intero è un quadrato perfetto:

(define (square? n) (let (v (+ (sqrt n 0.5))) (= n (* v v))))

Funzione che verifica se un numero appartiene alla sequenza:

(define (seq? num)
  (square? (apply + (map (fn(x) (* x x)) (divisors num)))))

(time (println (filter seq? (sequence 1 1e6))))
;-> (1 42 246 287 728 1434 1673 1880 4264 6237 9799 9855 18330
;->  21352 21385 24856 36531 39990 46655 57270 66815 92664 125255
;->  156570 182665 208182 212949 242879 273265 380511 391345 411558
;->  539560 627215 693160 730145 741096 773224 814463 931722 992680)
;-> 19144.706


----------------------------------
I tre numeri interi sono distinti?
----------------------------------

Dati tre numeri a, b e c determinare quanti sono quelli distinti.

Esempi:
  numeri: 1 2 3 (3 numeri distinti: 1, 2 e 3)
  numeri: 1 2 2 (2 numeri distinti: 1 e 2)
  numeri: 2 2 2 (1 numero distinto: 2)

(define (check a b c)
  (cond ((!= a b c) 3) ; numeri tutti diversi
        ((= a b c) 1)  ; numeri tutti uguali
        (true 2)))     ; numeri in cui uno di loro è duplicato

(check 1 2 3)
;-> 3
(check 1 2 2)
;-> 2
(check 2 2 2)
;-> 1

Se i numeri vengono dati come elementi di una lista possiamo usare "apply":

(apply check '(1 2 3))
;-> 3
(apply check '(1 2 2))
;-> 2
(apply check '(2 2 2))
;-> 1


--------------------
Un problema del 1953
--------------------

Il 20 giugno 1953 George Gamow inviò il seguente telegramma a Stanislaw Ulam:

"Caro Stan, un problema per te: usando 20 lettere diverse scrivi una lunga parola contenente qualche migliaio di lettere.
Quanto dovrebbe essere lunga questa parola per avere buone probabilità di trovarci dentro tutte le parole di 10 lettere?
Pregoti telegrafarmi risposta."

Stan rispose immediatamente da Los Alamos:

"Pregoti telegrafarmi se consentito saltare lettere in parola lunga per formare parole 10 lettere. Se si, risposta abbastanza breve.
Se solo lettere contigue consentite risposta molto maggiore dieci alla ventesima potenza e Carson spedirà questa parola a carico destinatario.
Con affetto, Stan."

Quante parole di 10 lettere posso generare con un alfabeto di 20 simboli?

Se ogni simbolo può essere utilizzato più volte in una parola e l'ordine dei simboli è significativo, allora abbiamo 20^10 possibilità.
Questo è perché abbiamo 20 opzioni per il primo simbolo, 20 per il secondo, e così via, fino al decimo simbolo.
Quindi, il numero totale di parole possibili sarà 10^20.

Se, invece, l'ordine dei simboli non è significativo e possiamo utilizzare ciascun simbolo solo una volta, allora stiamo parlando di una combinazione.
In questo caso, il numero di combinazioni è data da:

  (n−r)!r!
  --------
     n!

  dove, n è il numero totale di simboli (20).
        r è la lunghezza della parola (10)

Quindi abbiamo:

  (20-10)!10!
  -----------
      20!

Questo rappresenta il numero di parole uniche di 10 simboli che possiamo generare usando 20 simboli diversi senza ripetizione e con l'ordine non significativo.

La probabilità di trovare una specifica parola di 10 lettere in una sequenza di k lettere, dove ogni lettera può essere una delle 20 diverse lettere con probabilità uniforme, è data da:

  P = 1 - (1 - 1/20^10)^k

Nell'equazione, la probabilità P rappresenta la probabilità di trovare almeno una volta la parola di 10 lettere in una sequenza di k lettere.

Possiamo fissare un valore desiderato per P (ad esempio, 0.95 per una probabilità del 95%) e risolvere l'equazione per k:

  0.95 = 1 - (1 - 1/20^10)^k

  0.95 + (10239999999999/10240000000000)^k = 1

  (10239999999999/10240000000000)^k = 0.05

  k ≈ 3.12305×10^13

Quindi con una parola lunga 3.12305×10^13 abbiamo il 95% di probabilità di trovare tutte le parole di 10 lettere che si possono creare con 20 simboli.


-----------------------
Software version number
-----------------------

Quando viene pubblicato un software, gli viene assegnato un numero di versione.
Per aggiornare il software all'ultima versione, gli utenti devono capire quale versione dovrebbe essere più recente.
Consideriamo solo i numeri di versione che sono alcune cifre intervallate da punti.
In particolare:
   - Un numero di versione è una stringa non vuota che può contenere solo cifre (0..9) e punti (.).
   - I punti non sarebbero il primo/ultimo carattere di un numero di versione.
   - Ci devono essere alcune cifre tra i punti. Non possono apparire due punti consecutivi.

Esempi:
  2         1        18.04     18.4     
  1.0.0     1        7.010     7.8      
  1.0       1.0.0    1.0.0.1.0 1.00.00.2
  1.2.42    1.2.41   00.00.01  0.0.0.1  
  1.1.56789 1.2.0    0.0.1     0.1      
  1.10      1.2      42.0      4.2.0    
  1.20      1.150    999.999   999.999.1
  2018.08.1 2018.08

Questo problema può essere risolto usando il natural-sort.

(define (natural-sort l)
  (let (natural-key (lambda (s) (filter true?
    (flat (transpose (list
            (parse s "[0-9]+" 0)
            (map int (find-all "[0-9]+" s))))))))
    (sort l (fn (x y) (< (natural-key x)
            (natural-key y))))
))

(setq lst '("2" "1" "1.0.0" "1" "1.0" "1.0.0" "1.2.42" "1.2.41" "1.1.56789"
            "1.2.0" "1.10" "1.2" "1.20" "1.150" "18.04" "18.4" "7.010" "7.8"
            "1.0.0.1.0" "1.00.00.2" "00.00.01" "0.0.0.1" "0.0.1" "0.1" "42.0"
            "4.2.0" "999.999" "999.999.1" "2018.08.1" "2018.08"))

(natural-sort lst)
;-> ("0.0.0.1" "0.0.1" "00.00.01" "0.1" "1" "1" "1.0" "1.0.0" "1.0.0"
;->  "1.0.0.1.0" "1.00.00.2" "1.1.56789" "1.2" "1.2.0" "1.2.41" "1.2.42"
;->  "1.10" "1.20" "1.150" "2" "4.2.0" "7.8" "7.010" "18.4" "18.04" "42.0"
;->  "999.999" "999.999.1" "2018.08" "2018.08.1")


------------------
Primi in un numero
------------------

Dato un numero trovare al suo interno i "sottonumeri" primi.
Un "sottonumero" primo è una sequenza consecutiva di cifre (prese dal numero dato), che rappresenta un numero primo.

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (find-primi num)
  (local (out len str val)
    (setq out '())
    (setq len (length num))
    (setq str (string num))
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        ;(println i { } j)
        (setq val (int (slice str i j) 0 10))
        ;(print val { })
        (if (prime? val) (push val out -1))
      )
    )
    out))

Proviamo:

(find-primi 1234567890)
;-> (2 23 23456789 3 4567 5 67 7 89)

(find-primi 1234567891011121314)
;-> (1234567891 12345678910111 2 23 23456789 3 4567 4567891 45678910111
;->  45678910111213 5 56789101 67 67891 678910111213 7 789101 78910111213
;->  89 89101 9101112131 101 10111 11 1112131 11 1112131 11 11213 1213 2 
;->  2131 13 131 3 31)


-----------------------------------------------------------
Selezionare/rimuovere/inserire elementi da una lista ogni k
-----------------------------------------------------------

Vediamo tre funzioni per selezionare, rimuovere e inserire elementi di una lista ogni k elementi.

Funzione che rimuove gli elementi ogni k:

(define (remove-k lst k)
  (let (out '())
    (dolist (el lst) (if (!= (% (+ $idx 1) k) 0) (push el out -1)))
    out))

Proviamo:

(setq a (sequence 1 50))

(remove-k a 3)
;-> (1 2 4 5 7 8 10 11 13 14 16 17 19 20 22 23 25 26 28 
;->  29 31 32 34 35 37 38 40 41 43 44 46 47 49 50)

(remove-k a 1)
;-> ()

Funzione che seleziona gli elementi ogni k:

(define (select-k lst k)
  (let (out '())
    (dolist (el lst) (if (= (% (+ $idx 1) k) 0) (push el out -1)))
    out))

Proviamo:
(select-k a 3)
;-> (3 6 9 12 15 18 21 24 27 30 33 36 39 42 45 48)

(select-k a 1)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
;->  20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35
;->  36 37 38 39 40 41 42 43 44 45 46 47 48 49 50)

Verifichiamo la correttezza delle due funzioni:

(= (sort (extend (select-k a 3) (remove-k a 3))) (sort a))
;-> true

(setq b '(46 45 94 74 10 59 38 73 60 57 36 15 22
          42 80 51 98 75 34 16 65 49 6 69 50))

(= (sort (extend (select-k b 7) (remove-k b 7))) (sort b))
;-> true

Per finire la funzione che inserisce un elemento in una lista ogni k:

(define (insert-k val lst k)
"Inserts element into a list every k"
  (let (out '())
    (dolist (el lst) 
      (if (zero? (% (+ $idx 1) k))
          (extend out (list el val))
          (push el out -1)))
    out))

Proviamo:

(insert-k ', '(1 2 3 4 5 6 7 8 9) 1)
;-> (1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 ,)
(insert-k ', '(1 2 3 4 5 6 7 8 9) 2)
;-> (1 2 , 3 4 , 5 6 , 7 8 , 9)
(insert-k ', '(1 2 3 4 5 6 7 8 9) 3)
;-> (1 2 3 , 4 5 6 , 7 8 9 ,)
(insert-k ', '(1 2 3 4 5 6 7 8 9) 4)
;-> (1 2 3 4 , 5 6 7 8 , 9)


---------------------
La regola di Naismith
---------------------

La regola di Naismith aiuta nella pianificazione di una spedizione a piedi o di una escursione calcolando quanto tempo ci vorrà per percorrere il percorso previsto, compreso l'eventuale tempo extra impiegato quando si cammina in salita.
Questa regola pratica fu ideata da William W. Naismith, un alpinista scozzese, nel 1892.
Una versione moderna può essere formulata come segue:
"Calcolare un'ora ogni 5 km in piano, più un'ora aggiuntiva per ogni 600 m di salita"
Questa regola di base presuppone che gli escursionisti abbiano una forma fisica ragionevole, su un terreno tipico e in condizioni normali.
Non tiene conto dei ritardi, come le pause prolungate per riposarsi o visitare la città, o degli ostacoli alla navigazione.

  velocità-piana = 5000 / 60 = 83.333333 metri/min
  velocità-salità = 600 / 60 = 10 metri/min

(define (naismith dist-piana dist-salita)
  (local (v1 v2 t1 t2)
    (setq v1 (div 5000 60))
    (setq v2 (div 600 60))
    (setq t1 (div dist-piana v1))
    (setq t2 (div dist-salita v2))
    (add t1 t2))

Proviamo:

(naismith 2000 1000)
;-> 124 ;minuti

(naismith 1000 2000)
;-> 212 ;minuti


-------------------
Prodotto più comune
-------------------

Dato un elenco di numeri interi positivi con più di un elemento, restituisce il prodotto più comune di due elementi nell'array.

Ad esempio, l'MCM della lista (2 3 4 5 6) è 12, poiché una tabella di prodotti è:

      2  3  4  5  6
    +---------------
  2 | -  6  8  10 12
  3 | -  -  12 15 18
  4 | -  -  -  20 24
  5 | -  -  -  -  30
  6 | -  -  -  -  -

Poiché 12 appare più volte (due volte come 2*6 e 3*4).
Non vengono considerati i prodotti di un elemento per se stesso.
Tuttavia, gli elementi identici vengono comunque moltiplicati, quindi la tabella per (2 3 3) avrà il seguente aspetto:

      2  3  3
    +--------
  2 | -  6  6
  3 | -  -  9
  3 | -  -  -

Con l'MCM pari a 6.

(setq lst '(2 3 4 5 6))

(define (mcm lst)
  (local (out freq uniq)
    (setq out '())
    (setq freq '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        ;(println (lst i) { } (lst j))
        (push (* (lst i) (lst j)) freq -1)
      )
    )
    (setq uniq (unique freq))
    (setq freq (sort (map (fn(x y) (list x y)) (count uniq freq) uniq) >))
    ;(println freq)
    (setq massimo (freq 0 0))
    ;(println massimo)
    (dolist (el freq) 
      ;(println el)
      (if (= (el 0) massimo) (push el out -1))
    )
    out))

Facciamo alcune prove:

(mcm (sequence 1 10))
;-> ((2 40) (2 30) (2 24) (2 20) (2 18) (2 12) (2 10) (2 8) (2 6))

(mcm '(2 3 4 5 6))
;-> ((2 12))

(mcm '(7 2))
;-> ((1 14))

(mcm '(2 3 3))
;-> ((2 6))

(mcm '(3 3 3))
;-> ((3 9))

(mcm '(1 1 1 1 2 2))
;-> ((8 2))

(mcm '(6 200 10 120))
;-> ((2 1200))

(mcm '(2 3 4 5 6 7 8 8))
;-> ((3 24))

(mcm '(5 2 9 10 3 4 4 4 7))
;-> ((4 20))

(mcm '(9 7 10 9 7 8 5 10 1))
;-> ((4 90) (4 70) (4 63))


----------------------------------------------------
A Million Random Digits with 100,000 Normal Deviates
----------------------------------------------------

"A Million Random Digits with 100,000 Normal Deviates" è un libro di numeri casuali pubblicato dalla RAND Corporation nel 1955.
Il libro, composto da un elenco di numeri casuali, è stato un importante strumento nel settore della statistica.
È stato creato a partire dal 1947 usando la simulazione elettronica di una roulette connessa ad un computer i cui risultati, adeguatamente filtrati, sono stati inseriti nel libro. Questo fu molto importante in quanto non esisteva un elenco di numeri casuali di tali dimensioni.
Oggi siamo abituati ad utilizzare il generatore di numeri pseudo-casuali codificato in una routine, ma all'epoca questo non era possibile.

Nel 1949, durante la progettazione del computer Manchester Mark I, Alan Turing progettò un generatore di numeri casuali che sfruttava una sorgente di rumore elettronico veramente casuale.

John Von Neumann disse che "Any one who considers arithmetical methods of producing random digits is, of course, in a state of sin."
In italiano, "chiunque prenda in considerazione i metodi aritmetici per generare numeri casuali commette, ovviamente, peccato."

"Random numbers should not be generated with a method chosen at random."
"I numeri casuali non dovrebbero essere generati con un metodo scelto a caso."
Donald E. Knuth

Esistono due categorie principali di generatori di numeri casuali:
A) Generatori di numeri Pseudo Random (Generatori lineari congruenti, Mersenne Twister, altri)
B) Generatori di numeri random veri (Generatori fisici di rumore, caos, altri)

I numeri, che sono di pubblico dominio, sono riportati nel file "rand-million.txt" nella cartella "data".
Ogni riga contiene una cifra da 0 a 9.

Vediamo per curiosità la frequenza delle cifre contenute nel file:

(silent (setq nums (parse (read-file "rand-million.txt"))))

(setq digit (map string (sequence 0 9)))
;-> ("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")

(count digit nums)
;-> (99803 100050 100640 100311 100094 100214 99942 99559 100107 99280)

Vedi anche "Generatore di numeri casuali" su "Note libere 1".


-----------------------------
Partizioni prime di un numero
-----------------------------

La partizione prima si riferisce al processo di divisione di un dato numero in un insieme di numeri primi.
Ad esempio, se il numero è 6, può essere partizionato come 2 + 2 + 2 o 3 + 3 (nota che 1 non viene considerato primo).
L'obiettivo di generare tutte le partizioni prime di un dato numero è elencare tutti i modi possibili per dividere il numero in numeri primi .

Per generare tutte le partizioni prime di un numero, possiamo utilizzare un approccio ricorsivo.
Per prima cosa identifichiamo i numeri primi che possono essere utilizzati per la partizione.
Quindi prendiamo ciascun numero primo e partizioniamo ricorsivamente il numero rimanente finché non raggiungiamo una partizione in cui tutti i numeri sono primi.

Sequenza OEIS A000607: Number of partitions of n into prime parts
  1, 0, 1, 1, 1, 2, 2, 3, 3, 4, 5, 6, 7, 9, 10, 12, 14, 17, 19, 23, 26, 30,
  35, 40, 46, 52, 60, 67, 77, 87, 98, 111, 124, 140, 157, 175, 197, 219,
  244, 272, 302, 336, 372, 413, 456, 504, 557, 614, 677, 744, 819, 899, 987,
  1083, 1186, 1298, 1420, 1552, 1695, 1850, 2018, 2198, 2394, 2605, 2833,
  3079, 3344, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che genera una lista con valori true negli indici primi:

(define (primes num) (map prime? (sequence 0 num)))

Funzione che genera le partizioni in modo ricorsivo:

(define (partition value idx sum num)
  (cond ((= sum num) 
          (push (slice result 0 idx) out -1)
          (if show (println (slice result 0 idx))))
        ((or (>= idx (/ num 2)) (> sum num)) nil) ; condizione di stop
        (true
          (for (i value num)
            (if (prime i)
              (begin
                (setf (result idx) i)
                ; trova il prossimo elemento
                (partition i (+ idx 1) (+ sum i) num)
              ))))))

Funzione che genera tutte le partizioni di un numero con tutti numeri primi:

(define (prime-part num show)
  (local (out result prime)
    (setq out '())
    (setq result (array (/ num 2) '(0)))
    (setq prime (primes num))
    (partition 2 0 0 num)
    out))

Facciamo alcune prove:

(prime-part 7)
;-> ((2 2 3) (2 5) (7))

(prime-part 9)
;-> ((2 2 2 3) (2 2 5) (2 7) (3 3 3))

(prime-part 17)
;-> ((2 2 2 2 2 2 2 3) (2 2 2 2 2 2 5) (2 2 2 2 2 7) (2 2 2 2 3 3 3) 
;->  (2 2 2 3 3 5) (2 2 2 11) (2 2 3 3 7) (2 2 3 5 5) (2 2 13) (2 3 3 3 3 3)
;->  (2 3 5 7) (2 5 5 5) (3 3 3 3 5) (3 3 11) (3 7 7) (5 5 7) (17))

(prime-part 21 true)
;-> (2 2 2 2 2 2 2 2 2 3)
;-> (2 2 2 2 2 2 2 2 5)
;-> (2 2 2 2 2 2 2 7)
;-> (2 2 2 2 2 2 3 3 3)
;-> (2 2 2 2 2 3 3 5)
;-> (2 2 2 2 2 11)
;-> (2 2 2 2 3 3 7)
;-> (2 2 2 2 3 5 5)
;-> (2 2 2 2 13)
;-> (2 2 2 3 3 3 3 3)
;-> (2 2 2 3 5 7)
;-> (2 2 2 5 5 5)
;-> (2 2 3 3 3 3 5)
;-> (2 2 3 3 11)
;-> (2 2 3 7 7)
;-> (2 2 5 5 7)
;-> (2 2 17)
;-> (2 3 3 3 3 7)
;-> (2 3 3 3 5 5)
;-> (2 3 3 13)
;-> (2 3 5 11)
;-> (2 5 7 7)
;-> (2 19)
;-> (3 3 3 3 3 3 3)
;-> (3 3 3 5 7)
;-> (3 3 5 5 5)
;-> (3 5 13)
;-> (3 7 11)
;-> (5 5 11)
;-> (7 7 7)
;-> ((2 2 2 2 2 2 2 2 2 3) (2 2 2 2 2 2 2 2 5) (2 2 2 2 2 2 2 7) 
;->  (2 2 2 2 2 2 3 3 3) (2 2 2 2 2 3 3 5) (2 2 2 2 2 11) (2 2 2 2 3 3 7)
;->  (2 2 2 2 3 5 5) (2 2 2 2 13) (2 2 2 3 3 3 3 3) (2 2 2 3 5 7) 
;->  (2 2 2 5 5 5) (2 2 3 3 3 3 5) (2 2 3 3 11) (2 2 3 7 7) (2 2 5 5 7)
;->  (2 2 17) (2 3 3 3 3 7) (2 3 3 3 5 5) (2 3 3 13) (2 3 5 11) (2 5 7 7)
;->  (2 19) (3 3 3 3 3 3 3) (3 3 3 5 7) (3 3 5 5 5) (3 5 13) (3 7 11) 
;->  (5 5 11) (7 7 7))

(length (prime-part 42))
;-> 372

(time (println (length (prime-part 99))))
;-> 38257
;-> 5280.173

(map (fn(x) (length (prime-part x))) (sequence 2 42))
;-> (1 1 1 2 2 3 3 4 5 6 7 9 10 12 14 17 19 23 26 30 35 40 46 52 60 67
;->  77 87 98 111 124 140 157 175 197 219 244 272 302 336 372)

Il numero di partizioni di un numero N in numeri primi può essere calcolato con la seguente formula:

  k(N) = (1/N) * (SFP(N) + Sum[j=1..(N-1)](SFP(j)*k(N-j)))
  k(0) = 1 
  k(1) = 0

dove SFP(N) è la somma dei fattori primi distinti di N:

(define (SFP num) (apply + (unique (factor num))))
(SFP 12)
;-> 5

Vedi anche "Lista di tutte le partizioni di un numero" su "Funzioni varie".


---------------------------------
Percorsi Hamiltoniani in un grafo
---------------------------------

Dato un grafo con N vertici, calcolare tutti i percorsi (cammini) hamiltoniani presenti nel grafo. 
Un percorso hamiltoniano è un percorso che visita ogni vertice esattamente una volta e ritorna al vertice di partenza.

Usiamo un algoritmo che esplora tutti i possibili percorsi nel grafico utilizzando il backtracking.
Inizia da ciascun vertice del grafico ed esploriamo ricorsivamente tutti i vertici adiacenti, contrassegnandoli come visitati.
Se viene trovato un percorso di lunghezza N (numero di vertici) e il vertice corrente è il vertice iniziale, significa che è stato trovato un percorso hamiltoniano.

L'algoritmo utilizza un array (visited) per tenere traccia dei vertici visitati e un array (result) per memorizzare il percorso corrente esplorato.
L'array dei vertici visitati viene azzerato all'inizio di ogni iterazione
La funzione "hamilton" avvia il processo di esplorazione partendo da ciascun vertice del grafo chiamando la funzione "findHamiltonian".

La complessità temporale di questo algoritmo è esponenziale, poiché esplora tutti i possibili percorsi nel grafico.
Nel caso peggiore, il numero di percorsi da esplorare può essere N!. Questo perché per ogni vertice può esserci (N-1)! possibili permutazioni dei restanti vertici in un cammino hamiltoniano. Pertanto, la complessità temporale dell'algoritmo è O(N!*N^2). Questo rende l'algoritmo inefficiente per grafi di grandi dimensioni.

(define (findHamilton graph visited result node start counter)
  (cond ((and (= counter N) (= node start))
          (setf (result counter) node)
          (println result))
        ((or (>= counter N) (!= (visited node) -1)) nil)
        (true
          (setf (visited node) 1)
          (setf (result counter) node)
          (for (i 0 (- N 1))
            (if (= (graph node i) 1)
                (findHamilton graph visited result i start (+ counter 1))
            )
          )
          (setf (visited node) -1))))

(define (hamilton graph)
  (local (N result visited)
    (setq N (length graph))
    (setq result (array (+ N 1) '(nil)))
    (for (i 0 (- N 1))
      (setq visited (array N '(-1)))
      (findHamilton graph visited result i i 0)
    )
    '---------))

Proviamo con il seguente grafo:

           0-------5
           │       │\
           │       │ \
        1--|-------|--4
        │\ │       │ /
        │ \│       │/
        │  2-------3    
        │          │
        +----------+

(setq g '((0 0 1 0 0 1)  
          (0 0 1 1 1 0)  
          (1 1 0 1 0 0)  
          (0 1 1 0 1 1)  
          (0 1 0 1 0 1)  
          (1 0 0 1 1 0)))

(hamilton g)
;-> (0 2 1 3 4 5 0)
;-> (0 2 1 4 3 5 0)
;-> (0 2 3 1 4 5 0)
;-> (0 5 3 4 1 2 0)
;-> (0 5 4 1 3 2 0)
;-> (0 5 4 3 1 2 0)
;-> (1 2 0 5 3 4 1)
;-> (1 2 0 5 4 3 1)
;-> (1 3 2 0 5 4 1)
;-> (1 3 4 5 0 2 1)
;-> (1 4 3 5 0 2 1)
;-> (1 4 5 0 2 3 1)
;-> (2 0 5 3 4 1 2)
;-> (2 0 5 4 1 3 2)
;-> (2 0 5 4 3 1 2)
;-> (2 1 3 4 5 0 2)
;-> (2 1 4 3 5 0 2)
;-> (2 3 1 4 5 0 2)
;-> (3 1 2 0 5 4 3)
;-> (3 1 4 5 0 2 3)
;-> (3 2 0 5 4 1 3)
;-> (3 4 1 2 0 5 3)
;-> (3 4 5 0 2 1 3)
;-> (3 5 0 2 1 4 3)
;-> (4 1 2 0 5 3 4)
;-> (4 1 3 2 0 5 4)
;-> (4 3 1 2 0 5 4)
;-> (4 3 5 0 2 1 4)
;-> (4 5 0 2 1 3 4)
;-> (4 5 0 2 3 1 4)
;-> (5 0 2 1 3 4 5)
;-> (5 0 2 1 4 3 5)
;-> (5 0 2 3 1 4 5)
;-> (5 3 4 1 2 0 5)
;-> (5 4 1 3 2 0 5)
;-> (5 4 3 1 2 0 5)


--------
List Mix
--------

Date N liste L1, L2, ..., LN con lo stesso numero di elementi M generare una lista con il seguente formato:

  (L1(0) L2(0) ... LN(0) L1(1) L2(1) ... LN(1) ... L1(M-1) L2(M-1) ... LN(M-1))

In altre parole, la lista da generare è fatta nel modo seguente:

(primo elemento prima lista, primo elemento seconda lista, ... primo elemento N-esima lista
 secondo elemento prima lista, secondo elemento seconda lista, ... secondo elemento N-esima lista
 ...
 ultimo elemento prima lista, ultimo elemento seconda lista, ... ultimo elemento N-esima lista)

Esempio:
L1 = (1 2 3)
L2 = (a b c)
L3 = (+ - *)

Output = (1 a + 2 b - 3 c *)

Poichè non sappiamo a priori quante liste vengono passate alla funzione e quanti sono gli elementi di queste liste, dobbiamo usare la funzione "args".
Poi con due cicli innestati possiamo creare la lista richiesta.

(define (mixxa)
  (local (out num-args elements)
    (setq out '())
    ; numero di argomenti (liste)
    (setq num-args (length (args)))
    ; numero di elementi delle liste
    (setq elements (length (args 0)))
    ;(println num-args { } elements)
    ; ciclo per ogni elemento
    (for (e 0 (- elements 1))
      ; ciclo per ogni argomento (lista)
      (for (a 0 (- num-args 1))
        ; inserisce elemento e-esimo dell'argomento (lista) a-esimo
        ; nella lista di output
        (push ((args a) e) out -1)))
    out))

Proviamo:

(mixxa '(1 2 3) '(a b c) '(+ - *))
;-> (1 a + 2 b - 3 c *)

Un altro metodo è quello di utilizzare la funzione "transpose":

**********************
>>>funzione TRANSPOSE
**********************
sintassi: (transpose matrix)

Traspone una matrice invertendo le righe e le colonne.
Qualsiasi tipo di matrice-lista può essere trasposta.
Le matrici vengono rese rettangolari riempiendo nil per gli elementi mancanti, omettendo elementi dove appropriato o espandendo gli atomi nelle righe in elenchi.
Le dimensioni della matrice vengono calcolate utilizzando il numero di righe nella matrice originale per le colonne e il numero di elementi nella prima riga come numero di righe per la matrice trasposta.

La matrice da trasporre può contenere qualsiasi tipo di dati.

Le dimensioni di una matrice sono definite dal numero di righe e dal numero di elementi nella prima riga.
Una matrice può essere una lista annidata o un array.

(set 'A '((1 2 3) (4 5 6)))
(transpose A)
;-> ((1 4) (2 5) (3 6))

(transpose (list (sequence 1 5)))
;-> ((1) (2) (3) (4) (5))

; any data type is allowed in the matrix
(transpose '((a b) (c d) (e f)))
;-> ((a c e) (b d f))

; arrays can be transposed too
(set 'A (array 2 3 (sequence 1 6)))
(set 'M (transpose A))
M
;-> ((1 4) (2 5) (3 6))

Quindi per risolvere il nostro problema possiamo semplicemente scrivere:

(define (mix) (flat (transpose (args))))

(mix '(1 2 3) '(a b c) '(+ - *))
;-> (1 a + 2 b - 3 c *)

Oppure se le liste da mixare sono elementi di una lista:

(apply mix '((1 2 3) (a b c) (+ - *)))
;-> (1 a + 2 b - 3 c *)


------------------------
I punteggi del gioco 421
------------------------

Il gioco del 421 utilizza 3 dadi. In questo articolo consideriamo soltanto i punteggi del gioco.
Vediamo quali sono questi punteggi basati sull'uscita dei dadi:

421
---
Un 4, un 2 e un 1. Valore = 10

Triple 1
--------
Tre 1. Valore = 7

Two Alike and One Different
---------------------------
Due dadi uguali e uno differente. Valore = dado differente
Esempio: 663, valore = 3.

Barracks
--------
Tre dadi uguali. Valore = dado
Esempio: 222, valore = 2.

Sequence
--------
Tre cifre consecutive. Valore = 2.

Nenette
-------
Due 1 e un 2. Valore = 2.

Qualsiasi altra combinazione ha valore 1.

Scrivere una funzione che calcola i punti di un lancio di 3 dadi.

(define (p421 a b c)
  (let (d (sort (list a b c) >))
    (cond ((and (= (d 0) 4) (= (d 1) 2) (= (d 2) 1))
            (list "421" 10))
          ((and (= a 1) (= b 1) (= c 1))
            (list "Triple 1" 7))
          ((apply = d)
            (list "Barracks" (d 0)))
          ((and (= (d 0) (+ (d 1) 1)) (= (d 1) (+ (d 2) 1)))
            (list "Sequence" 2))
          ((and (= (d 0) 2) (= (d 1) 2) (= (d 2) 1))
            (list "Nenette" 2))
          ((and (= a b) (!= b c)) (list "Two alike" c))
          ((and (= a c) (!= a b)) (list "Two alike" b))
          ((and (= b c) (!= a b)) (list "Two alike" a))
          (true (list "Other" 1)))))

Proviamo:

(p421 4 2 1)
;-> ("421" 10)

(p421 1 1 1)
;-> ("Triple 1" 7)

(p421 4 5 6)
;-> ("Sequence" 2)

(p421 2 1 3)
;-> ("Sequence" 2)

(p421 4 4 2)
;-> ("Two alike" 2)

(p421 6 3 6)
;-> ("Two alike" 3)

(p421 2 2 1)
;-> ("Nenette" 2)

(p421 1 1 2)
;-> ("Two alike" 2)

(p421 1 3 5)
;-> ("Other" 1)


-------------------
Sort pari e dispari
-------------------

Data una lista di numeri interi scrivere una funzione che permette di ordinare la lista in due modi:
1) prima i numeri dispari ordinati e poi i numeri pari ordinati
oppure
2) prima i numeri pari ordinati e poi i numeri dispari ordinati

(define (sort-odd-even lst flag)
  (if flag
    ; numeri pari prima (even)
    (extend (sort (filter even? lst)) (sort (filter odd? lst)))
    ; numeri dispari prima (odd)
    (extend (sort (filter odd? lst)) (sort (filter even? lst)))))

(sort-odd-even '(1 2))
;-> (1 2)
(sort-odd-even '(1 2) true)
;-> (2 1)

(sort-odd-even '(3 4 3))
;-> (3 3 4)
(sort-odd-even '(3 4 3) true)
;-> (4 3 3)

(setq a '(98 44 -11 0 0 -37 -53 57 -60 60 -16 -66 -45 35 -5 -60 78 -80 51 -30))

(sort-odd-even a)
;-> (-53 -45 -37 -11 -5 35 51 57 -80 -66 -60 -60 -30 -16 0 0 44 60 78 98)

(sort-odd-even a true)
;-> (-80 -66 -60 -60 -30 -16 0 0 44 60 78 98 -53 -45 -37 -11 -5 35 51 57)


----------------------------------------------------------
Ordinare una lista in base alla radice digitale dei numeri
----------------------------------------------------------

Data una lista di numeri interi, ordinare la lista in base alla radice digitale dei numeri e al valore del numero (ordine crescente).
In altre parole, se due numeri hanno la stessa radice digitale, allora deve comparire prima il numero più piccolo.
Per esempio:

(setq a '((1 4) (1 3) (3 2) (3 1) (2 10)))
(sort a)
;-> ((1 3) (1 4) (2 10) (3 1) (3 2))

La radice digitale di un numero è la somma delle cifre fino a che non si ottiene una singola cifra.
Per esempio:

  35 -> 3 + 5 = 8
  3624 -> 3 + 6 + 2 + 4 = 15 -> 1 + 5 = 6

(define (digit-root num)
"Calculates the repeated sum of the digits of an integer"
    (+ 1 (% (- (abs num) 1) 9)))

(define (sort-digital-root lst)
  (sort (map (fn(x) (list (digit-root x) x)) lst)))

(setq a '(6724 6309 7456 8974 550 9401 1206 8431 711 1394 3603 8707 9683
          8455 349 5089 9443 6147 5288 9448 9169 7559 2266 5916 4459 6923
          520 5963 8351 7788 6422 4425 9478 9802 9374 3063 7669 3170 4682
          3185 2299 4852 1217 3934 3704 5564 6663 7764 2980 1634))

(sort-digital-root a)
;-> ((1 550) (1 2980) (1 3934) (1 4852) (1 6724) (1 7669) (1 8974) (1 9478)
;->  (1 9802) (2 1217) (2 3170) (2 4682) (2 5564) (2 6923) (2 9443) (3 3063)
;->  (3 3603) (3 5916) (3 6663) (3 7788) (4 2299) (4 4459) (4 5089) (4 7456)
;->  (4 8455) (4 8707) (5 1634) (5 3704) (5 5288) (5 5963) (5 6422) (5 9374)
;->  (5 9401) (6 4425) (6 7764) (7 349) (7 520) (7 2266) (7 8431) (7 9169)
;->  (7 9448) (8 1394) (8 3185) (8 7559) (8 8351) (8 9683) (9 711) (9 1206)
;->  (9 6147) (9 6309))

(sort-digital-root (sequence 1 100))
;-> ((1 1) (1 10) (1 19) (1 28) (1 37) (1 46) (1 55) (1 64) (1 73) (1 82)
;->  (1 91) (1 100) (2 2) (2 11) (2 20) (2 29) (2 38) (2 47) (2 56) (2 65)
;->  (2 74) (2 83) (2 92) (3 3) (3 12) (3 21) (3 30) (3 39) (3 48) (3 57)
;->  (3 66) (3 75) (3 84) (3 93) (4 4) (4 13) (4 22) (4 31) (4 40) (4 49)
;->  (4 58) (4 67) (4 76) (4 85) (4 94) (5 5) (5 14) (5 23) (5 32) (5 41)
;->  (5 50) (5 59) (5 68) (5 77) (5 86) (5 95) (6 6) (6 15) (6 24) (6 33)
;->  (6 42) (6 51) (6 60) (6 69) (6 78) (6 87) (6 96) (7 7) (7 16) (7 25)
;->  (7 34) (7 43) (7 52) (7 61) (7 70) (7 79) (7 88) (7 97) (8 8) (8 17)
;->  (8 26) (8 35) (8 44) (8 53) (8 62) (8 71) (8 80) (8 89) (8 98) (9 9)
;->  (9 18) (9 27) (9 36) (9 45) (9 54) (9 63) (9 72) (9 81) (9 90) (9 99))


----------------
Il gioco Tac Tix
----------------

TacTix è un semplice gioco in cui si prendono pezzi, una sorta di "Nim bidimensionale".
Due giocatori si alternano nel prendere pezzi dalla scacchiera: un numero qualsiasi di pezzi contigui in una riga o colonna.
Perde chi prende l'ultimo pezzo.
TacTix è stato inventato da Piet Hein e reso popolare da Martin Gardner nella sua rubrica sui giochi matematici del febbraio 1958.

Il gioco si svolge con un quadrato di pezzi NxN (i numeri servono solo per riferimento al testo) da cui i giocatori prendono a turno pedine da una qualsiasi riga orizzontale o verticale, però sempre in modo che le pedine risultino adiacenti fra loro, senza spazi vuoti intermedi.

   1  2  3  4
   5  6  7  8
   9 10 11 12
  13 14 15 16

Se per esempio un giocatore ha preso in una mossa 8 e 12, l'avversario non può prendere in una sola mossa 4 e 16 perché non adiacenti, mentre potrà prendere 12 e 16 se il primo giocatore avrà preso 4 e 8.
Nel classico "Tac Tix" "Misere" perde il giocatore che prende l'ultimo pezzo.
Nel "Tac Tix" "Non-Misere" vince il giocatore che prende l'ultimo pezzo.
L'introduzione di queste semplici regole ha reso l'analisi matematica del gioco estremamente complessa.
Secondo Martin Gardner, la dimensione migliore è 6x6, perché "è abbastanza piccola da evitare che il gioco sia lungo e noioso, ma abbastanza complessa da renderlo emozionante e imprevedibile".

Nota:  La versione "Non-Misere" non viene utilizzata perchè esiste una strategia vincente:

Primo Giocatore Se N è Dispari (Non-Misere):
Prendere il pezzo centrale. 
Poi copiare ogni mossa che il tuo avversario fa simmetricamente. 
Alla fine prendere l'ultimo pezzo per vincere.

Secondo Giocatore Se N è Pari (Non-Misere):
Copiare le mosse dell' avversario simmetricamente. 
Alla fine prendere l'ultimo pezzo per vincere.

Due problemi in cui bisogna trovare la mossa vincente:

Problema 1:

            4
      6  7  8
   9 10 11 12
  13 14 15 16

Problema 2:

      2
      6
   9 10 11 12
        15

Soluzioni:
Problema 1: varie soluzioni, prendere 9, 10, 11, 12 oppure 4, 8, 12, 16.
Problema 2: prendere 9 oppure 10.

Scriviamo alcune funzioni per poter giocare a Tac Tix.

Funzione che stampa la griglia di gioco:

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    (println "  " (join (map (fn(x) (format "%2d" x)) (sequence 0 (- col 1)))))
    (for (i 0 (- row 1))
      ;(setq fmt (string "%2d "))
      (print (format "%2d " i))
      (for (j 0 (- col 1))
        (cond ((= (grid i j) 0) (print "· ")) ; libera
              ((= (grid i j) 1) (print "x ")) ; occupata
              (true (println "Error: cell " i j ": " (grid i j)))
        )
      )
      (println)))
      '-----------)

(print-grid '((1 1 1 1 1 1) (1 1 1 1 1 1) (1 1 1 1 1 1)
              (1 1 1 1 1 1) (1 1 1 1 1 1) (1 1 1 1 1 1)))

Funzione che verifica se due coordinate sono contigue:

(define (contigui r1 c1 r2 c2)
  (let (valid true)
    (cond ((and (!= r1 r2) (!= c1 c2)) (setq valid nil))
          ((= r1 r2)
            (for (c c1 c2)
              (if (zero? (grid r1 c)) (setq valid nil))
            ))
          ((= c1 c2)
            (for (r r1 r2)
              (if (zero? (grid r c1)) (setq valid nil))
            ))
    )
    valid))

Funzione che effettua una mossa sulla griglia:

(define (move r1 c1 r2 c2)
  (if (contigui r1 c1 r2 c2)
      (cond ((= r1 r2) (for (c c1 c2) (setf (grid r1 c) 0)))
            ((= c1 c2) (for (r r1 r2) (setf (grid r c1) 0)))
      )
      ;else
      (println "Impossible move")
  )
  (print-grid grid))

Funzione che inizia una nuova partita:

(define (new-game N)
  (setq grid (array N N '(1)))
  (print-grid grid))

Iniziamo una partita:

(new-game 4)
;->    0 1 2 3
;->  0 x x x x
;->  1 x x x x
;->  2 x x x x
;->  3 x x x x
;-> -----------

(move 0 0 0 2)
;->    0 1 2 3
;->  0 · · · x
;->  1 x x x x
;->  2 x x x x
;->  3 x x x x
;-> -----------

(move 1 0 3 0)
;->    0 1 2 3
;->  0 · · · x
;->  1 · x x x
;->  2 · x x x
;->  3 · x x x
;-> -----------

(move 1 1 3 3)
;-> Impossible move
;->    0 1 2 3
;->  0 · · · x
;->  1 · x x x
;->  2 · x x x
;->  3 · x x x
;-> -----------

(move 1 0 1 2)
;-> Impossible move
;->    0 1 2 3
;->  0 · · · x
;->  1 · x x x
;->  2 · x x x
;->  3 · x x x
;-> -----------


----------------------------
Calcolo dei punti a Briscola
----------------------------

La briscola è un gioco che viene fatto con un mazzo di 40 carte con i valori asso, 2, 3, 4, 5, 6, 7, fante, cavallo, re, di semi italiani o francesi.
Si può giocare in due o in quattro a coppie.
I punteggi delle carte sono elencati nella seguente tabella:

 +---------+--------------+--------+
 |  Carta  |   Numero     | Valore |
 +---------+--------------+--------+
 | Asso    |  (1)         |   11   |
 | Tre     |  (3)         |   10   |
 | Re      | (10)         |    4   |
 | Cavallo |  (9)         |    3   |
 | Fante   |  (8)         |    2   |
 | Altre   |  (2,4,5,6,7) |    0   |
 +---------+--------------+--------+

Date due liste che rappresentano le prese di due giocatori, calcolare i rispettivi punteggi.
Il punteggio totale di tutte le carte vale 120.

Le due liste, insieme, contengono tutte le 40 carte della briscola, ma sono distribuite in modo casuale.
Poichè il seme delle carte (Spade, Denari, Coppe e Bastoni) non conta per il punteggio, supponiamo che le 40 carte siano rappresentate dai numeri 1..10 ripetuti 4 volte. Per esempio:

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (1 3 10 3 6 2 8 7 5 4 6 6 2 7 6 1 9 5 5 2 10
;->  10 5 4 10 1 4 9 2 9 3 8 7 3 8 9 1 7 8 4)

(define (briscola lst1 lst2)
  (local (pair p1 p2)
    (setq pair '((1 11) (2 0) (3 10) (4 0) (5 0) 
                 (6 0) (7 0) (8 2) (9 3) (10 4)))
    (setq p1 (apply + (map (fn(x) (lookup x pair)) lst1)))
    (setq p2 (apply + (map (fn(x) (lookup x pair)) lst2)))
    (list p1 p2)))

Facciamo alcune prove:

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (10 6 5 8 1 7 6 9 3 6 3 5 2 10 4 4 1 3 9 7 
;->  5 5 3 4 9 9 6 2 10 1 10 8 8 8 7 2 7 1 4 2)
(setq lst1 (slice carte 0 20))
;-> (10 6 5 8 1 7 6 9 3 6 3 5 2 10 4 4 1 3 9 7)
(setq lst2 (slice carte 20))
;-> (5 5 3 4 9 9 6 2 10 1 10 8 8 8 7 2 7 1 4 2)
(briscola lst1 lst2)
;-> (68 52)

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (2 10 4 5 3 2 5 8 10 6 6 5 10 4 3 9 6 5 2 7
;->  7 10 3 1 9 8 7 6 8 3 7 1 1 4 9 8 1 2 4 9)
(setq lst1 (slice carte 0 10))
;-> (2 10 4 5 3 2 5 8 10 6)
(setq lst2 (slice carte 10))
;-> (6 5 10 4 3 9 6 5 2 7 7 10 3 1 9 8 7 6 8 3 7 1 1 4 9 8 1 2 4 9)
(briscola lst1 lst2)
;-> (20 100)

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (3 9 10 9 5 1 4 7 6 4 5 9 9 2 3 10 5 2 10 1
;->  2 3 4 7 7 1 8 2 4 6 8 5 8 1 3 10 6 8 6 7)
(setq lst1 (slice carte 0 24))
;-> (3 9 10 9 5 1 4 7 6 4 5 9 9 2 3 10 5 2 10 1 2 3 4 7)
(setq lst2 (slice carte 24))
;-> (7 1 8 2 4 6 8 5 8 1 3 10 6 8 6 7)
(briscola lst1 lst2)
;-> (76 44)


-----------------------------
Calcolo dei punti a Tressette
-----------------------------

Il Tressette è un gioco che viene fatto con un mazzo di 40 carte con i valori asso, 2, 3, 4, 5, 6, 7, fante, cavallo, re, di semi italiani o francesi.
Si può giocare in due o in quattro a coppie.
I punteggi delle carte sono elencati nella seguente tabella:

 +---------+------------+--------+
 |  Carta  |   Numero   | Valore |
 +---------+------------+--------+
 | Asso    |  (1)       |    11  |
 | Re      | (10)       |   1/3  |
 | Cavallo |  (9)       |   1/3  |
 | Fante   |  (8)       |   1/3  |
 | Tre     |  (3)       |   1/3  |
 | Due     |  (2)       |   1/3  |
 | Altre   |  (4,5,6,7) |     0  |
 +---------+------------+--------+

Date due liste che rappresentano le prese di due giocatori, calcolare i rispettivi punteggi.
Il punteggio totale di tutte le carte vale 10 e 2/3 (10.666...).

Le due liste, insieme, contengono tutte le 40 carte del tressette, ma sono distribuite in modo casuale.
Poichè il seme delle carte (Spade, Denari, Coppe e Bastoni) non conta per il punteggio, supponiamo che le 40 carte siano rappresentate dai numeri 1..10 ripetuti 4 volte. Per esempio:

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (7 6 1 8 2 3 4 10 1 6 9 3 3 2 7 9 7 1 5 10 
;->  8 6 2 8 10 9 4 2 7 8 5 5 4 5 10 9 3 6 1 4)

(define (tressette lst1 lst2)
  (local (pair p1 p2 val)
    (setq val (div 1 3))
    (setq pair '((1 1) (2 val) (3 val) (4 0) (5 0)
                 (6 0) (7 0) (8 val) (9 val) (10 val)))
    (setq p1 (apply add (map (fn(x) (eval (lookup x pair))) lst1)))
    (setq p2 (apply add (map (fn(x) (eval (lookup x pair))) lst2)))
    (list (format "%2.2f" p1) (format "%2.2f" p2))))

Facciamo alcune prove:

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (4 10 5 4 9 2 7 5 1 8 9 1 2 3 2 6 6 6 10 7
;->  9 1 4 8 5 8 8 6 4 10 5 2 1 9 3 10 7 7 3 3)

(setq lst1 (slice carte 0 20))
;-> (4 10 5 4 9 2 7 5 1 8 9 1 2 3 2 6 6 6 10 7)
(setq lst2 (slice carte 20))
;->  (9 1 4 8 5 8 8 6 4 10 5 2 1 9 3 10 7 7 3 3)
(tressette lst1 lst2)
("5.00" "5.67")

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (6 2 1 6 8 5 4 1 6 7 7 10 7 9 8 4 9 3 8 4 5
;->  10 9 5 2 3 3 1 3 4 2 5 7 2 10 9 10 8 1 6)
(setq lst1 (slice carte 0 10))
;-> (6 2 1 6 8 5 4 1 6 7)
(setq lst2 (slice carte 10))
;-> (7 10 7 9 8 4 9 3 8 4 5 10 9 5 2 3 3 1 3 4 2 5 7 2 10 9 10 8 1 6)
> (tressette lst1 lst2)
;-> ("2.67" "8.00")

(setq carte (randomize (flat (dup (sequence 1 10) 4))))
;-> (9 7 2 5 4 9 1 2 7 10 7 6 5 3 8 1 6 5 8 6 4
;->  8 4 9 3 6 8 10 3 1 5 7 1 9 10 3 2 2 4 10)
(setq lst1 (slice carte 0 24))
;-> (9 7 2 5 4 9 1 2 7 10 7 6 5 3 8 1 6 5 8 6 4 8 4 9)
(setq lst2 (slice carte 24))
;-> (3 6 8 10 3 1 5 7 1 9 10 3 2 2 4 10)
(tressette lst1 lst2)
;-> ("5.33" "5.33")


---------------------------------------------
Distanze minime tra gli elementi di due liste
---------------------------------------------

Calcolare le distanze assolute per ogni intero di una lista L1 e l'intero più vicino di una lista L2.

Esempi:

X = (1 5,9)
Y = (3,4,7)
Le distanze sono 2 (1 da 3), 1 (5 da 4) e 2 (9 da 7).

X = (1,2,3)
Y = (0,8)
Le distanze sono 1 (1 da 0), 2 (2 da 0) e 3 (3 da 0).

Algoritmo
Ordinare le liste in modo crescente.
Iterare sulla lista L1 tenendo traccia dell'elemento L2(j) più vicino a L1(i) e confrontarlo con L2(j) e L2(j+1) (questo è possibile poiché uno di questi è il più vicino a L1(i+1).

(define (distanze X Y)
  (setq i 0 j 0 s 0)
  (while (< i (length X))
    (setq v (abs (- (Y j) (X i))))
    (if (and (< (+ j 1) (length Y)) (> v (- (Y (+ j 1)) (X i))))
        (++ j)
        ;else
        (begin (println v)
        (setq s (+ s v))
        (++ i)))
  )
  s)


(define (distanze l1 l2)
  (local (i j len1 len2 d out)
    (setq out '())
    (setq len1 (length l1))
    (setq len2 (length l2))
    (sort l1)
    (sort l2)
    (set 'i 0 'j 0)
    (while (< i len1)
      (setq d (abs (- (l2 j) (l1 i))))
      (if (and (< (+ j 1) len2) (> d (- (l2 (+ j 1)) (l1 i))))
          (++ j)
          ;else
          (begin (push d out -1) (++ i))
      )
    )
    out))

Proviamo:

(distanze '(5 1 9) '(4 7 3))
;-> 2 1 2
(distanze '(3 1 2) '(8 0))
;-> (1 2 3)
(distanze '(1 2 3 4 5 6) '(-1 -2 -3 -4 -5 -6))
;-> (2 3 4 5 6 7)


---------------------------------
Algoritmo Round-Robin (scheduler)
---------------------------------

Il round-robin (RR) è uno degli algoritmi utilizzati dagli scheduler di rete e dei processi.
Gli intervalli di tempo (noti anche come quanti di tempo) vengono assegnati a ciascun processo in parti uguali e in una sequenza circolare, rendendo tutti i processi senza priorità (cyclic executive).
Lo scheduler round-robin è semplice e viene utilizzato anche nella pianificazione dei pacchetti di dati nelle reti di computer.

Waiting Time:
L'intero tempo trascorso dal processo nello stato pronto in attesa della CPU è noto come tempo di attesa.

Burst Time:
Ogni operazione del sistema richiede del tempo per essere completata.
In questo calcolo sono inclusi sia il tempo CPU che quello I/O.
Il tempo della CPU è la quantità di tempo necessaria alla CPU per completare un'attività.
La quantità di tempo necessaria a un processo per eseguire un'operazione di I/O è nota come tempo di I/O.
Quando analizziamo un processo, solitamente ignoriamo il tempo di I/O e consideriamo solo il tempo della CPU.
Di conseguenza, il tempo di burst è il tempo totale necessario per l'esecuzione del processo sulla CPU.

Turnaround Time:
L'intervallo di tempo tra il momento in cui un processo viene inviato e il momento in cui viene completato è noto come turnarounnd time (TAT).
Può anche essere pensato come la somma del tempo impiegato nell'attesa di entrare in memoria o il tempo passato nella coda dei processi pronti, nonché del tempo impiegato nell'esecuzione del codice sulla CPU e nell'esecuzione di input/output.
Il turnaround time è un parametro importante negli algoritmi di un sistema operativo.

; Calculate waiting time of given process by using quantum time
(define (find-waiting-time processes bt wt quantum n)
  (local (pending-bt process-time work)
    ; Array used to find waiting time
    (setq pending-bt (array n '(0)))
    ; Get burst time
    (setq pending-bt bt)
    ; Current time
    (setq process-time 0)
    (setq work true)
    ; Execute round robin process until work are not complete
    (while (= work true)
      ; Set that initial no work at this time
      (setq work nil)
      ; Execute process one by one repeatedly
      (for (i 0 (- n 1))
        (if (> (pending-bt i) 0)
        ; When pending process are exists: Active work
          (begin
            (setq work true)
            (if (> (pending-bt i) quantum)
              (begin
                ; Update the process time
                (++ process-time quantum)
                ; Reduce padding burst time of current process
                (-- (pending-bt i) quantum)
              )
              ;else
              (begin
                ; Add the remains padding BT (burst time)
                (++ process-time (pending-bt i))
                ; Get waiting time of i process
                (setf (wt i) (- process-time (bt i)))
                ; Set that no remaining pending time
                (setf (pending-bt i) 0)
              )
            )
          )
        )
      )
    )
    ; update global waiting-time array
    (setq waiting-time wt)))

(define (find-avg-time processes burst-time quantum n)
  (local (turnaround-time waiting-time
          total-waiting-time total-turnaround-time i)
    ; Arrays to store waiting time and turnaround time          
    (setq turnaround-time (array n '(0)))
    (setq waiting-time (array n '(0)))
    (setq total-waiting-time 0)
    (setq total-turnaround-time 0)
    (find-waiting-time processes burst-time waiting-time quantum n)
    ; Calculate turnaround time 
    (setq i 0)
    (for (i 0 (- n 1))
      ; Get turn around time for ith processes
      (setf (turnaround-time i) (+ (burst-time i) (waiting-time i)))
    )
    ; Display result
    (println " (Process) (Burst Time) (Waiting Time) (Turn Around Time)")
    (for (i 0 (- n 1))
      ; Calculate waiting time
      (setq total-waiting-time (+ total-waiting-time (waiting-time i)))
      ; Calculate turnaround time
      (setq total-turnaround-time (+ total-turnaround-time (turnaround-time i)))
      ; Calculate the average waiting time and average turn around time
      (println "  " (processes i) " \t\t" (burst-time i) " \t\t" (waiting-time i) " \t\t" (turnaround-time i))
    )
    (println "Average Waiting Time: " (div total-waiting-time n))
    (println "Average Turn Around Time: " (div total-turnaround-time n))))

Proviamo:

(setq processes '(1 2 3 4))
(setq burst-time '(4 3 5 9))
(setq n (length processes))
(setq quantum 2)
(find-avg-time processes burst-time quantum n)
;->  (Process) (Burst Time) (Waiting Time) (Turn Around Time)
;->   1             4               6               10
;->   2             3               8               11
;->   3             5               11              16
;->   4             9               12              21
;-> Average Waiting Time: 9.25
;-> Average Turn Around Time: 14.5

Nota: il codice è una traduzione dal linguaggio python e non ho adattato lo stile a newLISP.


---------
Isogrammi
---------

Un isogramma è una parola composta solo da lettere senza duplicati (senza distinzione tra maiuscole e minuscole).
La stringa vuota è un isogramma.

(define (isogram? str)
  (let (lst (explode (lower-case str)))
    (= (unique lst) lst)))

Proviamo:

(isogram? "ciao")
;-> true

(isogram? "Dermatoglyphics")
;-> true

(isogram? "Oaxaca")
;-> nil

(isogram? "")
;-> true


-------------------
Alfabeto Farfallino
-------------------

Il farfallino o alfabeto farfallino è una lingua in cui le vocali vengono "codificate" per parlare in codice segreto (molto usato dai bambini).
Per trasformare una generica stringa in una stringa in farfallino occorre raddoppiare ogni vocale con l'aggiunta di una f interposta.
In altre parole occorre effettuare le seguenti sostituzioni nella stringa generica:

  a -> afa
  e -> efe
  i -> ifi
  o -> ofo
  u -> ufu

Per esempio:

ciao --> cifiafaofo
alfabeto farfallino --> afalfafabefetofo fafarfafallifinofo

Funzione che trasforma (codifica) una stringa generica in una stringa in farfallino:
Prima versione

(define (farfallino1 str)
  (replace "a" str "afa")
  (replace "e" str "efe")
  (replace "i" str "ifi")
  (replace "o" str "ofo")
  (replace "u" str "ufu"))

(farfallino1 "ciao")
;-> "cifiafaofo"
(farfallino1 "alfabeto farfallino")
;-> "afalfafabefetofo fafarfafallifinofo"

Funzione che trasforma (codifica) una stringa generica in una stringa in farfallino:
Seconda versione

(define (farfallino2 str)
  (let (sost '(("a" "afa") ("e" "efe") ("i" "ifi") ("o" "ofo") ("u" "ufu")))
    (dolist (s sost) 
      (replace (first s) str (last s)))))

(farfallino2 "ciao")
;-> "cifiafaofo"
(farfallino2 "alfabeto farfallino")
;-> "afalfafabefetofo fafarfafallifinofo"

Funzione che trasforma (decodifica) una stringa in farfallino in una stringa generica:

(define (normale str)
  (let (sost '(("afa" "a") ("efe" "e") ("ifi" "i") ("ofo" "o") ("ufu" "u")))
    (dolist (s sost) 
      (replace (first s) str (last s)))))

(normale "cifiafaofo")
;-> "ciao"
(normale "afalfafabefetofo fafarfafallifinofo")
;-> "alfabeto farfallino"


-----------------------
Orario minimo e massimo
-----------------------

Abbiamo una lista di numeri interi nell'intervallo (0..9).
Questi numeri rappresentano un'orario del tipo HH:MM:SS.

Per esempio:
lista = (1 2 3 4 5 6)
orario = 12:34:56 (12 hours, 34 minutes 56 seconds)

Gli orari HH:MM:SS hanno la seguente struttura:
  HH = Hours:   (0..23)
  MM = Minutes: (0..59)
  SS = Seconds: (0..59)

Se consideriamo tutte le permutazioni dei numeri della lista otteniamo 6! = 720 orari diversi.
Comunque non tutti gli orari sono validi (es. 12:60:21 non è valido).

Scrivere una funzione che restituisce gli orari validi minimo e massimo.

Esempio:

lista = (2 3 7 1 9 3)

Orari = 
  "123739" "123739" "123937" "123937" "132739" "132739" "132937" "132937"
  "133729" "133729" "133927" "133927" "172339" "172339" "172933" "172933"
  "173239" "173239" "173329" "173329" "173923" "173923" "173932" "173932"
  "192337" "192337" "192733" "192733" "193237" "193237" "193327" "193327"
  "193723" "193723" "193732" "193732" "213739" "213739" "213937" "213937"
  "231739" "231739" "231937" "231937" "233719" "233719" "233917" "233917"

Orario minimo e massimo = ("12:37:39" "23:39:17")

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

Funzione che restituisce gli orari validi minimo e massimo:

(define (times lst)
  (local (tt permutation h m s t1 t2)
    (setq tt '())
    (setq permutation (perm lst))
    (dolist (p permutation)
      (setq h (+ (* 10 (p 0)) (p 1)))
      (setq m (+ (* 10 (p 2)) (p 3)))
      (setq s (+ (* 10 (p 4)) (p 5)))
      (if (and (<= h 23) (<= m 59) (<= s 59))
        (push (string h m s) tt)
      )
    )
    (cond ((!= tt '())
            (sort tt)
            ;(println tt)
            (setq t1 (tt 0))
            (setq t2 (tt -1))
            (setq t1 (string (t1 0) (t1 1)":"(t1 2)(t1 3)":"(t1 4) (t1 5)))
            (setq t2 (string (t2 0) (t2 1)":"(t2 2)(t2 3)":"(t2 4) (t2 5)))
            (list t1 t2))
          (true (list "" "")))))

Proviamo:

(times '(2 3 7 1 9 3))
;-> ("12:37:39" "23:39:17")

(times '(2 3 6 7 8 4))
;-> ("" "")

(times '(1 2 3 4 5 6))
;-> ("12:34:56" "23:56:41")


--------------------
Numeri di Schlosberg
--------------------

I numeri di Schlosberg sono i numeri interi positivi che soddisfano la seguente espressione:

  Sum[k=1..n]floor(n/k) = numero intero pari

Questo avviene per i numeri in cui risulta:

  floor(sqrt(n)) = intero pari

Sequenza OEIS A280682:
  0, 4, 5, 6, 7, 8, 16, 17, 18, 19, 20, 21, 22, 23, 24, 36, 37, 38, 39,
  40, 41, 42, 43, 44, 45, 46, 47, 48, 64, 65, 66, 67, 68, 69, 70, 71, 
  72, 73, 74, 75, 76, 77, 78, 79, 80, 100, 101, 102, 103, 104, 105, 106,
  107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, ...

(define (schlosberg? num) (even? (floor (sqrt num))))


(filter schlosberg? (sequence 0 120))
;-> (0 4 5 6 7 8 16 17 18 19 20 21 22 23 24 36 37 38 39 40 41 42 43 44
;->  45 46 47 48 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 100
;->  101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117
;->  118 119 120)


----------------
Matrici di Walsh
----------------

Una matrice di Walsh è un tipo speciale di matrice quadrata che viene usata nelle applicazioni per il processo dei segnali (es. CDMA - Code Division Multiple Access).
Entrambe le dimensioni della matrice sono sempre una potenza di 2.
Se indichiamo queste matrici con W(0), W(1), W(2), ... possiamo scrivere:

  W(0) = ((1))

  W(n) = ((W(n-1)  W(n-1))
          (W(n-1) -W(n-1))) per n > 0

Esempi:

W(1) = ((1  1)
        (1 -1))

W(2) = ((1  1  1  1)
        (1 -1  1 -1)
        (1  1 -1 -1)
        (1 -1 -1  1))

Scrivere una funzione che genera la matrice di Walsh W(n), con n numero intero positivo.

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    ; converto matrice in lista?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; valore massimo della lunghezza di un elemento (come stringa)
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    ; calcolo spazio per gli elementi
    (setq digit (+ 1 lenmax))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "s"))
    ; stampa la matrice
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

(define (merge-matrix A B position mtx)
"Merge two matrix"
  (local (out rowsA colsA rowsB colsB)
    (setq out '())
    (setq rowsA (length A))
    (setq colsA (length (A 0)))
    (setq rowsB (length B))
    (setq colsB (length (B 0)))
    (cond ((= position "n") ; B sopra A (nord) con (colsA == colsB)
            (dolist (r B) (push r out -1))
            (dolist (r A) (push r out -1)))
          ((= position "s") ; B sotto A (sud) con (colsA == colsB)
            (dolist (r A) (push r out -1))
            (dolist (r B) (push r out -1)))
          ((= position "e") ; B a destra di A (est) con (rowsA == rowsB)
            (dolist (r A)
              (push (append r (B $idx)) out -1)))
          ((= position "o") ; B a sinistra di A (ovest) con (rowsA == rowsB)
            (dolist (r A)
              (push (append (B $idx) r) out -1)))
    )
    ; mtx = true --> matrice di output è un array
    ; mtx = nil  --> matrice di output è una lista (default)
    (if mtx (array (length out) out)
            out)))

(setq m1 '((1 2 3 4) (5 6 7 8)))
;-> ((1 2 3 4)
;->  (5 6 7 8))
(setq m2 '((11 22 33 44) (55 66 77 88)))
;-> ((11 22 33 44)
;->  (55 66 77 88))

(merge-matrix m1 m2 "e")
;-> ((1  2  3  4 11 22 33 44)
;->  (5  6  7  8 55 66 77 88))

(merge-matrix m1 m2 "o")
;-> ((11 22 33 44  1  2  3  4)
;->  (55 66 77 88  5  6  7  8))

(merge-matrix m1 m2 "n")
;-> ((11 22 33 44)
;->  (55 66 77 88)
;->  ( 1  2  3  4)
;->  ( 5  6  7  8))

(merge-matrix m1 m2 "s")
;-> (( 1  2  3  4)
;->  ( 5  6  7  8)
;->  (11 22 33 44)
;->  (55 66 77 88))

Funzione che genera la matrice di Walsh W(n):

(define (walsh num)
  (local (w wi wup wdown)
    (cond ((= num 0) (print-matrix '((1))))
          ((= num 1) (print-matrix '((1 1) (1 -1))))
          (true
            (setq w (array 2 2 '(1 1 1 -1)))
            (setq wi (mat * w -1))
            (for (i 2 num)
              (setq wup   (merge-matrix w w "e"))
              (setq wdown (merge-matrix w wi "e"))
              (setq w (merge-matrix wup wdown "s" true))
              (setq wi (mat * w -1))
            )
            w))))

Proviamo:

(print-matrix (walsh 0))
;-> 1

(print-matrix (walsh 1))
;-> 1  1
;-> 1 -1

(print-matrix (walsh 2))
;-> 1  1  1  1
;-> 1 -1  1 -1
;-> 1  1 -1 -1
;-> 1 -1 -1  1

(print-matrix (walsh 3))
;-> 1  1  1  1  1  1  1  1
;-> 1 -1  1 -1  1 -1  1 -1
;-> 1  1 -1 -1  1  1 -1 -1
;-> 1 -1 -1  1  1 -1 -1  1
;-> 1  1  1  1 -1 -1 -1 -1
;-> 1 -1  1 -1 -1  1 -1  1
;-> 1  1 -1 -1 -1 -1  1  1
;-> 1 -1 -1  1 -1  1  1 -1

(print-matrix (walsh 4))
;-> 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
;-> 1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1
;-> 1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1
;-> 1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1
;-> 1  1  1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1
;-> 1 -1  1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1
;-> 1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1  1  1
;-> 1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1  1 -1
;-> 1  1  1  1  1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1
;-> 1 -1  1 -1  1 -1  1 -1 -1  1 -1  1 -1  1 -1  1
;-> 1  1 -1 -1  1  1 -1 -1 -1 -1  1  1 -1 -1  1  1
;-> 1 -1 -1  1  1 -1 -1  1 -1  1  1 -1 -1  1  1 -1
;-> 1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1
;-> 1 -1  1 -1 -1  1 -1  1 -1  1 -1  1  1 -1  1 -1
;-> 1  1 -1 -1 -1 -1  1  1 -1 -1  1  1  1  1 -1 -1
;-> 1 -1 -1  1 -1  1  1 -1 -1  1  1 -1  1 -1 -1  1

La funzione è un pò lenta:

(time (walsh 10))
;-> 265.555
(time (walsh 11))
;-> 1125.12
(time (walsh 12))
;-> 7172.301

Invece di combinare le sotto-matrici possiamo riempire la matrice copiando gli elementi.
Per fare questo usiamo due cicli per copiare il primo quarto della matrice (alto-sinistra) su tutti gli altri quarti della matrice.

(define (walsh2 num)
  (local (dim out)
    (setq dim (pow 2 num))
    (setq out (array dim dim '(0)))
    ; aggiorna elemento (0 0)
    (setf (out 0 0) 1)
    (setq k 1)
    (while (< k dim)
      ; Cicli per copiare gli elementi sugli altri quarti della matrice
      (for (i 0 (- k 1))
        (for (j 0 (- k 1))
          (setf (out (+ i k) j) (out i j))
          (setf (out i (+ j k)) (out i j))
          (setq (out (+ i k) (+ j k)) (- (out i j)))
        )
      )
      (++ k k)
    )
    out))

Proviamo:

(print-matrix (walsh2 2))
;-> 1  1  1  1
;-> 1 -1  1 -1
;-> 1  1 -1 -1
;-> 1 -1 -1  1
(print-matrix (walsh2 4))
;-> 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
;-> 1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1
;-> 1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1
;-> 1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1
;-> 1  1  1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1
;-> 1 -1  1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1
;-> 1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1  1  1
;-> 1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1  1 -1
;-> 1  1  1  1  1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1
;-> 1 -1  1 -1  1 -1  1 -1 -1  1 -1  1 -1  1 -1  1
;-> 1  1 -1 -1  1  1 -1 -1 -1 -1  1  1 -1 -1  1  1
;-> 1 -1 -1  1  1 -1 -1  1 -1  1  1 -1 -1  1  1 -1
;-> 1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1
;-> 1 -1  1 -1 -1  1 -1  1 -1  1 -1  1  1 -1  1 -1
;-> 1  1 -1 -1 -1 -1  1  1 -1 -1  1  1  1  1 -1 -1
;-> 1 -1 -1  1 -1  1  1 -1 -1  1  1 -1  1 -1 -1  1

Vediamo la velocità di questa funzione:

(time (walsh2 10))
;-> 155.941
(time (walsh2 11))
;-> 614.845
(time (walsh2 12))
;-> 2532.056
(time (walsh2 13))
;-> 18985.052

Questa funzione è molto più veloce, ma le dimensioni delle matrici di Walsh crescono molto velocemente (es 2^13 = 8192).
I due cicli innestati rendono la complessità temporale pari a O(n^2).

Dal punto di vista matematico è stato dinostrato che il valore della coordinata (x y) della matrice vale:

  (-1)^popcount(x & y)

dove "popcount" è una funzione che conta i bit a 1 di un numero e "&" è l'operatore bitwise "and".

(define (popcount num)
  (let (conta 0)
    (while (> num 0)
      (setq num (& num (- num 1)))
      (++ conta)
    )
    conta))

(define (walsh3 num)
  (local (dim out)
    (setq dim (pow 2 num))
    (setq out (array dim dim '(0)))
    ; aggiorna elemento (0 0)
    (setf (out 0 0) 1)
    ; Cicli per copiare gli elementi sugli altri quarti della matrice
    (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (out i j) (pow -1 (popcount (& i j))))
        )
    )
    out))

> (print-matrix (walsh3 2))
;-> 1  1  1  1
;-> 1 -1  1 -1
;-> 1  1 -1 -1
;-> 1 -1 -1  1

> (print-matrix (walsh3 4))
;-> 1  1  1  1  1  1  1  1  1  1  1  1  1  1  1  1
;-> 1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1  1 -1
;-> 1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1
;-> 1 -1 -1  1  1 -1 -1  1  1 -1 -1  1  1 -1 -1  1
;-> 1  1  1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1
;-> 1 -1  1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1
;-> 1  1 -1 -1 -1 -1  1  1  1  1 -1 -1 -1 -1  1  1
;-> 1 -1 -1  1 -1  1  1 -1  1 -1 -1  1 -1  1  1 -1
;-> 1  1  1  1  1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1
;-> 1 -1  1 -1  1 -1  1 -1 -1  1 -1  1 -1  1 -1  1
;-> 1  1 -1 -1  1  1 -1 -1 -1 -1  1  1 -1 -1  1  1
;-> 1 -1 -1  1  1 -1 -1  1 -1  1  1 -1 -1  1  1 -1
;-> 1  1  1  1 -1 -1 -1 -1 -1 -1 -1 -1  1  1  1  1
;-> 1 -1  1 -1 -1  1 -1  1 -1  1 -1  1  1 -1  1 -1
;-> 1  1 -1 -1 -1 -1  1  1 -1 -1  1  1  1  1 -1 -1
;-> 1 -1 -1  1 -1  1  1 -1 -1  1  1 -1  1 -1 -1  1

Vediamo se le funzioni producono gli stessi risultati:

(= (walsh 4) (walsh2 4) (walsh3 4))
;-> true
(= (walsh 8) (walsh2 8) (walsh3 8))
;-> true

Vediamo la velocità di questa funzione:

(time (walsh3 10))
;-> 642.185
(time (walsh3 11))
;-> 2639.838
(time (walsh3 12))
;-> 11005.218
(time (walsh3 13))
;-> 55119.123


-------------------------------------------
Somma delle rotazioni distinte di un numero
-------------------------------------------

Dato un intero positivo calcolare la somma di tutte le permutazioni.

Esempi:
num = 123
Le rotazioni sono 123 (nessuna rotazione), 231 (una rotazione) e 312 (due rotazioni).
La somma di questi vale 123 + 231 + 312 = 666.

num = 4928. 
Le rotazioni sono 4928, 9284, 2849 e 8492. 
La somma di questi quattro numeri vale 4928 + 9284 + 2849 + 8492 = 25553.

num = 445445, 
Le rotazioni distinte sono 445445, 454454 e 544544.
La somma vale 445445 + 454454 + 544544 = 1444443.

num = 777
Esiste solo una rotazione distinta che vale 777.

Sequenza OEIS A045876:
Sum of different permutations of digits of n (leading 0's allowed)
  1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 11, 33, 44, 55, 66, 77, 88, 99, 110, 22,
  33, 22, 55, 66, 77, 88, 99, 110, 121, 33, 44, 55, 33, 77, 88, 99, 110, 
  121, 132, 44, 55, 66, 77, 44, 99, 110, 121, 132, 143, 55, 66, 77, 88, 
  99, 55, 121, 132, 143, 154, 66, 77, 88, 99, 110, 121, 66, 143, ...

(define (rotate-sum num)
  (let ( (lst '()) (s (string num)) )
    (for (i 0 (- (length num) 1))
      (push (int (rotate s) 0 10) lst)
    )
    (apply + (unique lst))))

Proviamo:

(rotate-sum 1)
;-> 1
(rotate-sum 123)
;-> 666
(rotate-sum 4892)
;-> 25553
(rotate-sum 445445)
;-> 1444443
(rotate-sum 777)
;-> 777

(map rotate-sum (sequence 1 100))
;-> (1 2 3 4 5 6 7 8 9 11 11 33 44 55 66 77 88 99 110 22
;->  33 22 55 66 77 88 99 110 121 33 44 55 33 77 88 99 110
;->  121 132 44 55 66 77 44 99 110 121 132 143 55 66 77 88
;->  99 55 121 132 143 154 66 77 88 99 110 121 66 143 154 
;->  165 77 88 99 110 121 132 143 77 165 176 88 99 110 121
;->  132 143 154 165 88 187 99 110 121 132 143 154 165 176 
;->  187 99 111)


----------------------
Simbolo di Levi-Civita
----------------------

The three-dimensional Levi-Civita symbol is a function f taking triples of numbers (i,j,k) each in {1,2,3}, to {-1,0,1}, defined as:

f(i,j,k) = 0 when i,j,k are not distinct, i.e. i=j or j=k or k=i
f(i,j,k) = 1 when (i,j,k) is a cyclic shift of (1,2,3), that is one of (1,2,3), (2,3,1), (3,1,2).
f(i,j,k) = -1 when (i,j,k) is a cyclic shift of (3,2,1), that is one of (3,2,1), (2,1,3), (1,3,2).
The result is the sign of a permutation of (1,2,3), with non-permutations giving 0. Alternatively, if we associate the values 1,2,3 with orthogonal unit basis vectors e_1, e_2, e_3, then f(i,j,k) is the determinant of the 3x3 matrix with columns e_i, e_j, e_k.

There are 27 possible inputs.

Il simbolo tridimensionale di Levi-Civita è una funzione f che prende triple di numeri (i,j,k) ciascuno in (1..3) restituisce un valore tra (-1,0,1).
La funzione viene definita come:

f(i,j,k) = 0 quando i,j,k non sono distinti, cioè i=j o j=k o k=i

f(i,j,k) = 1 quando (i,j,k) è uno spostamento ciclico di (1,2,3), ovvero uno tra (1,2,3), (2,3,1), (3,1,2).

f(i,j,k) = -1 quando (i,j,k) è uno spostamento ciclico di (3,2,1), cioè uno tra (3,2,1), (2,1,3 ), (1,3,2).

Quindi il risultato è il segno di una permutazione di (1,2,3), con le non-permutazioni che danno 0.
In alternativa, se associamo i valori 1,2,3 ai vettori base unitari ortogonali e_1, e_2, e_3, allora f(i,j,k) è il determinante della matrice 3x3 con colonne e_i, e_j, e_k.

Ci sono 27 possibili input con relativi output:

  (1 1 1) --> 0
  (1 1 2) --> 0
  (1 1 3) --> 0
  (1 2 1) --> 0
  (1 2 2) --> 0
  (1 2 3) --> 1
  (1 3 1) --> 0
  (1 3 2) --> -1
  (1 3 3) --> 0
  (2 1 1) --> 0
  (2 1 2) --> 0
  (2 1 3) --> -1
  (2 2 1) --> 0
  (2 2 2) --> 0
  (2 2 3) --> 0
  (2 3 1) --> 1
  (2 3 2) --> 0
  (2 3 3) --> 0
  (3 1 1) --> 0
  (3 1 2) --> 1
  (3 1 3) --> 0
  (3 2 1) --> -1
  (3 2 2) --> 0
  (3 2 3) --> 0
  (3 3 1) --> 0
  (3 3 2) --> 0
  (3 3 3) --> 0

1) Versione banale:

(define (levi1 i j k)
  (let (val (+ (* i 100) (* j 10) k))
    (cond ((= val 111) 0 )
          ((= val 112) 0 )
          ((= val 113) 0 )
          ((= val 121) 0 )
          ((= val 122) 0 )
          ((= val 123) 1 )
          ((= val 131) 0 )
          ((= val 132) -1)
          ((= val 133) 0 )
          ((= val 211) 0 )
          ((= val 212) 0 )
          ((= val 213) -1)
          ((= val 221) 0 )
          ((= val 222) 0 )
          ((= val 223) 0 )
          ((= val 231) 1 )
          ((= val 232) 0 )
          ((= val 233) 0 )
          ((= val 311) 0 )
          ((= val 312) 1 )
          ((= val 313) 0 )
          ((= val 321) -1)
          ((= val 322) 0 )
          ((= val 323) 0 )
          ((= val 331) 0 )
          ((= val 332) 0 )
          ((= val 333) 0 ))))

Verifichiamo la correttezza della funzione:

(setq input '((1 1 1) (1 1 2) (1 1 3) (1 2 1) (1 2 2) (1 2 3) (1 3 1) (1 3 2)
              (1 3 3) (2 1 1) (2 1 2) (2 1 3) (2 2 1) (2 2 2) (2 2 3) (2 3 1)
              (2 3 2) (2 3 3) (3 1 1) (3 1 2) (3 1 3) (3 2 1) (3 2 2) (3 2 3)
              (3 3 1) (3 3 2) (3 3 3)))

(setq output '(0 0 0 0 0 1 0 -1 0 0 0 -1 0 0 0 1 0 0 0 1 0 -1 0 0 0 0 0))

(= (map (fn(x) (apply levi1 x)) input) output)
;-> true

2) Versione banale compressa:

(define (levi2 i j k)
  (let (val (+ (* i 100) (* j 10) k))
    (cond ((or (= val 111) (= val 112) (= val 113) (= val 121) (= val 122)
               (= val 131) (= val 133) (= val 211) (= val 212) (= val 221)
               (= val 222) (= val 223) (= val 232) (= val 233) (= val 311)
               (= val 313) (= val 322) (= val 323) (= val 331) (= val 332)
               (= val 333)) 0)
          ((or (= val 123) (= val 231) (= val 312)) 1)
          ((or (= val 132) (= val 213) (= val 321)) -1))))

Verifichiamo la correttezza della funzione:

(= (map (fn(x) (apply levi2 x)) input) output)
;-> true

3) Versione matematica:

Se associamo i valori 1,2,3 ai vettori base unitari ortogonali e_1, e_2, e_3, allora f(i,j,k) è il determinante della matrice 3x3 con colonne e_i, e_j, e_k.
Esempi:

i=1 j=1 k=1
Matrice:
  e1 e1 e1
   1  1  1
   0  0  0
   0  0  0

i=1 j=2 k=2
Matrice:
  e1 e2 e2
   1  0  0
   0  1  1
   0  0  0

i=1 j=3 k=2
Matrice:
  e1 e3 e2
   1  0  0
   0  0  1
   0  1  0

(define (levi3 i j k)
  (setq matrix (array 3 3 '(0)))
  (setf (matrix (- i 1) 0) 1)
  (setf (matrix (- j 1) 1) 1)
  (setf (matrix (- k 1) 2) 1)
  (or (det matrix) 0))

Verifichiamo la correttezza della funzione:

(= (map (fn(x) (apply levi3 x)) input) output)

4) Versione analizzando le differenze degli indici

Consideriamo le differenze i-j, j-k, k-i.

Se (i, j, k) è una rotazione di (1, 2, 3), le differenze sono una rotazione di (-1, -1, 2). Prendendo il prodotto, otteniamo (-1) * (-1) * 2 = 2.
Se (i, j, k) è una rotazione di (3, 2, 1), le differenze sono una rotazione di (1, 1, -2). Prendendo il prodotto, otteniamo 1 * 1 * (-2) = -2.
Per (i, i, j) (o una rotazione), dove i e j possono essere uguali, le differenze sono (0, i-j, j-i). Prendendo il prodotto, otteniamo 0 * (i-j) * (j-i) = 0.
Quindi per ottenere il risultato corretto è sufficiente dividere per 2 il prodotto delle differenze (i-j), (j-k) e (k-i).

(define (levi4 i j k) (/ (* (- i j) (- j k) (- k i)) 2))

Verifichiamo la correttezza della funzione:

(= (map (fn(x) (apply levi4 x)) input) output)
;-> true

Vediamo la velocità delle funzioni:
(time (map (fn(x) (apply levi1 x)) input) 1e4)
;-> 461.832
(time (map (fn(x) (apply levi2 x)) input) 1e4)
;-> 401.342
(time (map (fn(x) (apply levi3 x)) input) 1e4)
;-> 1049.973
(time (map (fn(x) (apply levi4 x)) input) 1e4)
;-> 131.559


------------------------------------
La funzione "GetTickCount" (windows)
------------------------------------

Funzione "GetTickCount" (sysinfoapi.h) (kernel32.dll)

La funzione restituisce il numero di millisecondi trascorsi dall'avvio del sistema (boot).
La risoluzione della funzione GetTickCount è limitata alla risoluzione del timer di sistema, che in genere è compreso tra 10 millisecondi e 16 millisecondi.
Il tempo trascorso viene memorizzato come valore DWORD.
Pertanto, il valore tornerà a zero se il sistema viene eseguito ininterrottamente per 49.7 giorni.
Per evitare questo problema, utilizzare la funzione "GetTickCount64".

Facciamo una prova:

(import "kernel32.dll" "GetTickCount")
(import "kernel32.dll" "GetTickCount64")
(GetTickCount64) (GetTickCount)

(define (test iter)
  (let (start (GetTickCount))
    (for (i 1 iter) (for (j 1 iter)))
    (- (GetTickCount) start)))

(test 10000)
;-> 734

(time (test 10000))
;-> 731.947


---------------------------------------------------------------
G. Polya e "How to Solve It!" (G. Polya and "How to Solve It!")
---------------------------------------------------------------

***Versione Italiana***

Un quadro generale per la risoluzione dei problemi è stato descritto da G. Polya in un libro intitolato "How to Solve It!" (2a edizione, Princeton University Press).
Sebbene l’attenzione di Polya fosse rivolta alla risoluzione di problemi di matematica, le strategie sono molto più generali e ampiamente applicabili.
Il ragionamento induttivo è alla base della maggior parte dei processi creativi nel "mondo reale".
La Fisica (N.d.T. e anche la Programmazione) fornisce un'attività ideale per sviluppare abilità nel ragionamento induttivo e nella scoperta.

Ecco uno schema della struttura di Polya:

1. Comprendere il problema [Identificare l'obiettivo]
-----------------------------------------------------
Il primo passo è leggere il problema e assicurarsi di averlo compreso chiaramente.

Poniti le seguenti domande:

- Quali sono le incognite?

-Quali sono le quantità indicate?

- Quali sono le condizioni previste?

- Ci sono dei vincoli?

Per molti problemi è utile

- tracciare un diagramma

e identificare le quantità date e richieste sul diagramma.

Di solito è necessario

- introdurre una notazione adeguata

Nella scelta dei simboli per le quantità sconosciute usiamo spesso lettere come a, b, c, x e y, ma nella maggior parte dei casi è utile usare le iniziali come simboli suggestivi, ad esempio V per volume o t per tempo.

2. Elaborare un piano
---------------------
Trova una connessione tra le informazioni fornite e l'ignoto che ti consentirà di calcolare l'ignoto.
Spesso ti aiuta a chiederti esplicitamente: "Come posso mettere in relazione il dato con l'ignoto?"
Se non vedi immediatamente una connessione, le seguenti idee potrebbero essere utili per elaborare un piano.

- Stabilire sotto-obiettivi (dividerli in sottoproblemi)
In un problema complesso è spesso utile stabilire dei sotto-obiettivi.
Se riusciamo prima a raggiungere questi sotto-obiettivi, allora potremmo essere in grado di basarci su di essi per raggiungere il nostro obiettivo finale.

- Prova a riconoscere qualcosa di familiare
Collegare la situazione data alle conoscenze precedenti.
Guarda l'ignoto e prova a ricordare un problema più familiare che ha un'incognita simile o coinvolge principi simili.

- Prova a riconoscere i modelli
Alcuni problemi vengono risolti riconoscendo che si sta verificando un qualche tipo di schema.
Il modello potrebbe essere geometrico, numerico o algebrico.
Se riesci a vedere la regolarità o la ripetizione in un problema, potresti essere in grado di indovinare qual è lo schema continuo e quindi dimostrarlo.
[Questo è uno dei motivi per cui devi risolvere molti problemi, in modo da sviluppare una base di schemi!]

- Usa l'analogia
Prova a pensare a un problema analogo, cioè un problema simile, correlato, ma più semplice del problema originale.
Se riesci a risolvere un problema simile e più semplice, questo potrebbe darti gli indizi necessari per risolvere il problema originale, più difficile.
Ad esempio, se il problema riguarda la geometria tridimensionale, potresti cercare un problema simile nella geometria bidimensionale.
Oppure, se il problema con cui inizi è generale, potresti prima provare un caso speciale. [
Bisogna fare molti problemi per costruire un database di analogie!]

- Introduci qualcosa in più
A volte può essere necessario introdurre qualcosa di nuovo, un aiuto ausiliario, per aiutare a stabilire la connessione tra il dato e l'ignoto.
Ad esempio, in un problema in cui un diagramma è utile, l'aiuto ausiliario potrebbe essere una nuova linea tracciata in un diagramma.
In un problema più algebrico potrebbe essere una nuova incognita correlata all'incognita originale.

- Prendi i casi
A volte potremmo dover suddividere un problema in diversi casi e fornire una soluzione diversa per ciascuno dei casi.
Ad esempio, spesso dobbiamo utilizzare questa strategia quando si tratta di valore assoluto.

- Lavora all'indietro (assumi la risposta)
Spesso è utile immaginare che il proprio problema sia risolto e lavorare a ritroso, passo dopo passo, fino ad arrivare ai dati forniti.
Quindi potresti essere in grado di invertire i tuoi passi e quindi costruire una soluzione al problema originale.
Questa procedura è comunemente usata per risolvere le equazioni.
Ad esempio, nel risolvere l'equazione 3x-5 = 7, supponiamo che x sia un numero che soddisfa 3x-5=7 e lavoriamo all'indietro.
Aggiungiamo 5 a ciascun lato dell'equazione e poi dividiamo ciascun lato per 3 per ottenere x = 4.
Poiché ciascuno di questi passaggi può essere invertito, abbiamo risolto il problema.

- Ragionamento indiretto
A volte è opportuno affrontare un problema indirettamente.
Utilizzando la prova per assurdo per dimostrare che P implica Q, assumiamo che P sia vero e Q sia falso e proviamo a vedere perché ciò non può accadere.

3. Realizzare il Piano
----------------------
Nella fase 2 è stato ideato un piano.
Nell'attuare quel piano dobbiamo controllare ogni fase del piano e scrivere i dettagli che dimostrano che ogni fase è corretta.
Una serie di equazioni non è sufficiente!

4. Guarda indietro
------------------
Sii critico nei confronti del tuo risultato.
Cerca difetti nelle tue soluzioni (ad esempio, incoerenze, ambiguità o passaggi errati).
Sii il critico più duro di te stesso!
Puoi controllare il risultato? Lista di controllo:

- Esiste un metodo alternativo che possa fornire una risposta almeno parziale?

- Prova lo stesso approccio per qualche problema simile ma più semplice.

- Controllare le unità (sempre, sempre, sempre!).

- Se esiste una risposta numerica, l'ordine di grandezza è corretto o ragionevole?

- Tendenze. La risposta varia come previsto se si variano uno o più parametri?
Ad esempio, se è coinvolta la gravità, la risposta cambia come previsto se si varia g?

- Controlla i casi limite in cui la risposta è facile o conosciuta.
Prendi il limite poiché le variabili o i parametri raggiungono determinati valori.
Ad esempio, supponiamo che la massa sia zero o infinita.

- Controllare casi particolari in cui la risposta è facile o conosciuta.
Potrebbe trattarsi di un angolo speciale (0, 45 o 90 gradi) o del caso in cui tutte le masse sono impostate uguali tra loro.

- Usa la simmetria.
La tua risposta riflette qualche simmetria della situazione fisica?

- Se possibile, fai un semplice esperimento per vedere se la tua risposta ha senso.

Esamineremo le potenziali strategie mentre risolviamo i problemi.
L'enfasi qui è sull'essere consapevoli delle nostre strategie di risoluzione dei problemi e sulla costruzione di una soluzione che rifletta i passaggi sopra delineati.

***English Version***

An overall framework for problem solving was described by G. Polya in a book called "How to Solve It!" (2nd Ed., Princeton University Press).
Although Polya’s focus was on solving math problems, the strategies are much more general and are broadly applicable.
Inductive reasoning is the basis of most of the creative processes in the "real world".
Physics provides an ideal activity for building skill in inductive reasoning and discovery.

Here is an outline of Polya’s framework:

1. Understand the Problem [Identify the goal]
----------------------------------------------
The first step is to read the problem and make sure that you understand it clearly.

Ask yourself the following questions:

- What are the unknowns?

- What are the given quantities?

- What are the given conditions?

- Are there any constraints?

For many problems it is useful to

- draw a diagram

and identify the given and required quantities on the diagram.

Usually it is necessary to

- introduce suitable notation

In choosing symbols for the unknown quantities we often use letters such as a, b, c, x, and y, but in most cases it helps to use initials as suggestive symbols, for instance, V for volume or t for time.

2. Devise a Plan
----------------
Find a connection between the given information and the unknown that will enable you to calculate the unknown. 
It often helps you to ask yourself explicitly: "How can I relate the given to the unknown?" 
If you do not see a connection immediately, the following ideas may be helpful in devising a plan.

- Establish subgoals (divide into subproblems)
In a complex problem it is often useful to set subgoals. 
If we can first reach these subgoals, then we may be able to build on them to reach our final goal.

- Try to recognize something familiar
Relate the given situation to previous knowledge. 
Look at the unknown and try to recall a more familiar problem that has a similar unknown or involves similar principles.

- Try to recognize patterns
Some problems are solved by recognizing that some kind of pattern is occurring.
The pattern could be geometric, or numerical, or algebraic.
If you can see regularity or repetition in a problem, you might be able to guess what the continuing pattern is and then prove it.
[This is one reason you need to do lots of problems, so that you develop a base of patterns!]

- Use analogy
Try to think of an analogous problem, that is, a similar problem, a related problem, but one that is easier than the original problem.
If you can solve the similar, simpler problem, then it might give you the clues you need to solve the original, more difficult problem.
For instance, if the problem is in three-dimensional geometry, you could look for a similar problem in two-dimensional geometry.
Or if the problem you start with is a general one, you could first try a special case. [
One must do many problems to build a database of analogies!]

-  Introduce something extra
It may sometimes be necessary to introduce something new, an auxiliary aid, to help make the connection between the given and the unknown.
For instance, in a problem where a diagram is useful the auziliary aid could be a new line drawn in a diagram.
In a more algebraic problem it could be a new unknown that is related to the original unknown.

-  Take cases
We may sometimes have to split a problem into several cases and give a di.erent solution for each of the cases.
For instance, we often have to use this strategy in dealing with absolute value.

-  Work backward (assume the answer)
It is often useful to imagine that your problem is solved and work backward, step by step, until you arrive at the given data.
Then you may be able to reverse your steps and thereby construct a solution to the original problem.
This procedure is commonly used in solving equations.
For instance, in solving the equation 3x-5 = 7, we suppose that x is a number that satisfies 3x-5=7 and work backward.
We add 5 to each side of the equation and then divide each side by 3 to get x = 4.
Since each of these steps can be reversed, we have solved the problem.

-  Indirect reasoning
Sometimes it is appropriate to attack a problem indirectly.
In using proof by contradiction to prove that P implies Q we assume that P is true and Q is false and try to see why this cannot happen.

3. Carry out the Plan
---------------------
In step 2 a plan was devised.
In carrying out that plan we have to check each stage of the plan and write the details that prove that each stage is correct.
A string of equations is not enough!

4. Look Back 
------------
Be critical of your result. 
Look for flaws in your solutions (e.g., inconsistencies or ambiguities or incorrect steps).
Be your own toughest critic!
Can you check the result? Checklist of checks:

- Is there an alternate method that can yield at least a partial answer?

- Try the same approach for some similar but simpler problem.

- Check units (always, always, always!).

- If there is a numerical answer, is the order of magnitude correct or reasonable?

- Trends. Does the answer vary as you expect if you vary one or more parameters? 
For example, if gravity is involved, does the answer change as expected if you vary g?

- Check limiting cases where the answer is easy or known.
Take the limit as variables or parameters reach certain values.
For example, take a mass to be zero or infinite.

- Check special cases where the answer is easy or known.
This might be a special angle (0 or 45 or 90 degrees) or the case when all masses are set equal to each other.

- Use symmetry.
Does your answer reflect any symmetries of the physical situation?

- If possible, do a simple experiment to see if your answer makes sense.

We will examine potential strategies as we solve problems. 
The emphasis here is on being conscious of our problem-solving strategies and on constructing a solution that reflects the steps outlined above.


-------------------------
Lunghezza di una funzione
-------------------------

Alle volte abbiamo la necessità/curiosità di conoscere quanto ♪ lunga una funzione (in termini di caratteri).
La seguente funzione risolve il problema convertendo la funzione (che è una lista speciale) in stringa e poi calcolando la sua lunghezza.

(define (length-f func) (length (string func)))

(length-f length-f)
;-> 38

Anche autoreferenziale::

(define (howlong) (length (string howlong?)))
(howlong)
;-> 38


--------------------
Intersezione di geni
--------------------

Vediamo un esempio per capire cosa intendiamo per intersezione dei geni.
Abbiamo due sequenze di DNA (G C C G G G C A) e (A A A T T T T T) e due punti di crossover 2 e 5.
La sequenza risultante vale (G C A T T G C A) perchè:

CrossOver:   |     |
Indici:  0 1 2 3 4 5 6 7

Gene 1:  G C C G G G C A
Gene 2:  A A A T T T T T

Output:  G C A T T G C A

Nota: Nucleotidi DNA: adenina (A), citosina (C), guanina (G) e timina (T).

Condizioni:
Le sequenze sono sempre della stessa lunghezza.
I punti crossover possono essere 0 o più di uno.
I punti crossover sono tutti distinti e ordinati in modo crescente.
Il valore dei punti crossover è minore della lunghezza delle sequenze (0-index).

(define (geni g1 g2 cross)
  (local (out len idx k break seq)
    (setq out '())
    (setq len (length cross))
    (set 'idx 0 'k 0)
    ; primo punto crossover
    (setq break (cross 0))
    ; partenza con la prima sequenza
    (setq seq 1)
    ; ciclo per ogni gene della sequenza
    (for (g 0 (- (length g1) 1))
      ; indice-corrente = punto-crossover ?
      (cond ((= g break)
        (setq seq (- 3 seq)) ; flip tra 1 e 2
        ; imposta il punto crossover corrente
        (if (< k (- len 1)) (set 'k (+ k 1) 'break (cross k))))
      )
      (if (= seq 1)
        ; inserisce gene dalla prima sequenza
        (push (g1 idx) out -1)
        ; inserisce gene dalla seconda sequenza
        (push (g2 idx) out -1)
      )
      ; aggiorna indice (prossimo gene)
      (++ idx)
    )
    (join out)))

Proviamo:

(geni "GCCGGGCA" "AAATTTTT" '(2 5))
;-> "GCATTGCA"

(geni "AAAAAAA" "TTTTTTT" '(2 5))
;-> "AATTTAA"

(geni '("G" "C" "C" "G" "G" "A") '("T" "T" "T" "T" "T" "A") '(1 3 5))
;-> "GTTGGA"

(geni '("G" "C" "C" "G" "G" "A") '("T" "T" "T" "T" "T" "A") '(0))
;-> "TTTTTA"


------------------------------
Le mosse del Cavallo (scacchi)
------------------------------

Vedi anche "Posizione di scacchi casuale - random chess position" su "Note libere 11".

Un Cavallo (kNight) degli Scacchi è posizionato in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili del Cavallo.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, un Cavallo sulla casella (x y) può muoversi in:

   (x−2,y−1), (x−2,y+1), (x−1,y−2), (x−1,y+2),
   (x+1,y−2), (x+1,y+2), (x+2,y−1) o (x+2,y+1)

con una sola mossa.

     Scacchiera con                          Matrice della posizione
     coordinate algebriche                   (riga = x, colonna = y)
                                              0   1   2   3   4   5   6   7
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  8 |   |   |   |   |   |   |   |   |     0 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  7 |   |   |   |   |   |   |   |   |     1 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  6 |   |   |   |   |   |   |   |   |     2 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |   |     3 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |   |     4 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |   |     5 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |   |     6 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  1 |   |   |   |   |   |   |   |   |     7 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
      a   b   c   d   e   f   g   h

Funzione che converte da notazione matriciale a notazione algebrica:

(char "a")
;-> 97

(define (mat-alg ij)
  (local (col-char row-num)
    (setq col-char (char (+ 97 (ij 1))))
    (setq row-num (- 8 (ij 0)))
    (string col-char row-num)))

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))

(mat-alg '(3 4))
;-> "e5"

Funzione che converte da notazione algebrica a notazione matriciale:

(define (alg-mat c)
  (local (i j)
    (setq j (- (char (c 0)) 97))
    (setq i (- 8 (int (c 1))))
    (list i j)))

(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))

(alg-mat "e5")
;-> (3 4)

(mat-alg (alg-mat "a1"))
;-> "a1"

(alg-mat (mat-alg '(7 0)))
;-> (7 0)

Funzione che stampa la scacchiera:

(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che verifica se gli indici (i j) di una casella sono interni alla scacchiera:

(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))

Funzione che genera le mosse di un Cavallo posizionato in una casella (notazione algebrica) della scacchiera:

(define (knight-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '(((− x 2) (− y 1)) ((− x 2) (+ y 1))
                  ((− x 1) (− y 2)) ((− x 1) (+ y 2))
                  ((+ x 1) (− y 2)) ((+ x 1) (+ y 2))
                  ((+ x 2) (− y 1)) ((+ x 2) (+ y 1))))
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    (setf (board x y) "N")
    ; creazione di tutte le mosse valide
    (dolist (m moves)
      (setq nx (eval (m 0)))
      (setq ny (eval (m 1)))
      ;(println nx ny)
      (if (valid? nx ny)
        (begin
          (setf (board nx ny) "x")
          (push (mat-alg (list nx ny)) out)))
          ;(println " N" cell "-" (mat-alg (list nx ny)))))
    )
    (print-board board)
    out))

Proviamo:

(knight-from "c3")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . x . x . . . .
;->  x . . . x . . .
;->  . . N . . . . .
;->  x . . . x . . .
;->  . x . x . . . .
;-> ("d1" "b1" "e2" "a2" "e4" "a4" "d5" "b5")

(knight-from "a1")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . x . . . . . .
;->  . . x . . . . .
;->  N . . . . . . .
;-> ("c2" "b3")


---------------------------------------
Le mosse dell'Alfiere/Vescovo (scacchi)
---------------------------------------

Un Alfiere (Bishop -> Vescovo) degli Scacchi è posizionato in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili dell'Alfiere.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, un Alfiere sulla casella (x y) può muoversi in:

  basso-destra:   (x+1,y+1)...(7, 7)
  basso-sinistra: (x+1,y-1)...(7, 0)
  alto-sinistra:  (x-1,y-1)...(0, 0)
  alto-destra:    (x-1,y+1)...(0, 7)

con una sola mossa.

Funzioni ausiliarie:

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))
(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))
(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))
(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che genera le mosse di un Alfiere posizionato in una casella (notazione algebrica) della scacchiera:

(define (bishop-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    (setf (board x y) "B")
    ; creazione della lista di tutte le mosse
    (for (k 1 7)
      ; basso-destra
      (push (list (+ x k) (+ y k)) moves)
      ; basso-sinistra
      (push (list (+ x k) (- y k)) moves)
      ; alto-sinistra
      (push (list (- x k) (- y k)) moves)
      ; alto-destra
      (push (list (- x k) (+ y k)) moves)
    )
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " B" cell "-" (mat-alg (list nx ny)))))
    )
    (print-board board)
    out))

Proviamo:

(bishop-from "a1")
;->  . . . . . . . x
;->  . . . . . . x .
;->  . . . . . x . .
;->  . . . . x . . .
;->  . . . x . . . .
;->  . . x . . . . .
;->  . x . . . . . .
;->  B . . . . . . .
;-> ("b2" "c3" "d4" "e5" "f6" "g7" "h8")

(bishop-from "e4")
;->  x . . . . . . .
;->  . x . . . . . x
;->  . . x . . . x .
;->  . . . x . x . .
;->  . . . . B . . .
;->  . . . x . x . .
;->  . . x . . . x .
;->  . x . . . . . x
;-> ("a8" "b1" "b7" "c2" "c6" "d3" "d5" "f3" "f5" "g2" "g6" "h1" "h7")


------------------------------
Le mosse della Torre (scacchi)
------------------------------

Una Torre (Rook) degli Scacchi è posizionata in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili della Torre.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, una Torre sulla casella (x y) può muoversi in:

  basso:    (x+1,y)...(7, y)
  sinistra: (x,y-1)...(x, 0)
  alto:     (x-1,y)...(0, y)
  destra:   (x,y+1)...(x, 7)

con una sola mossa.

Funzioni ausiliarie:

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))
(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))
(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))
(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che genera le mosse di una Torre posizionata in una casella (notazione algebrica) della scacchiera:

(define (rook-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    (setf (board x y) "R")
    ; creazione della lista di tutte le mosse
    (for (k 1 7)
      ; basso
      (push (list (+ x k) y) moves)
      ; sinistra
      (push (list x (- y k)) moves)
      ; alto
      (push (list (- x k) y) moves)
      ; destra
      (push (list x (+ y k)) moves)
    )
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " R" cell "-" (mat-alg (list nx ny)))))
    )
    (print-board board)
    out))

Proviamo:

(rook-from "a1")
;->  x . . . . . . .
;->  x . . . . . . .
;->  x . . . . . . .
;->  x . . . . . . .
;->  x . . . . . . .
;->  x . . . . . . .
;->  x . . . . . . .
;->  R x x x x x x x
;-> ("a2" "b1" "a3" "c1" "a4" "d1" "a5" "e1" "a6" "f1" "a7" "g1" "a8" "h1")

(rook-from "d4")
;->  . . . x . . . .
;->  . . . x . . . .
;->  . . . x . . . .
;->  . . . x . . . .
;->  x x x R x x x x
;->  . . . x . . . .
;->  . . . x . . . .
;->  . . . x . . . .
;-> ("d3" "c4" "d5" "e4" "d2" "b4" "d6" "f4" "d1" "a4" "d7" "g4" "d8" "h4")


-------------------------------------
Le mosse della Regina/Donna (scacchi)
-------------------------------------

Una Regina/Donna (Queen) degli Scacchi è posizionata in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili della Regina.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, una Regina sulla casella (x y) può muoversi in:

   (mosse di una Torre)
   basso:    (x+1,y)...(7, y)
   sinistra: (x,y-1)...(x, 0)
   alto:     (x-1,y)...(0, y)
   destra:   (x,y+1)...(x, 7)

   (mosse di un Alfiere)
   basso-destra:   (x+1,y+1)...(7, 7)
   basso-sinistra: (x+1,y-1)...(7, 0)
   alto-sinistra:  (x-1,y-1)...(0, 0)
   alto-destra:    (x-1,y+1)...(0, 7)

con una sola mossa.

Funzioni ausiliarie:

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))
(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))
(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))
(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che genera le mosse di una Torre posizionata in una casella (notazione algebrica) della scacchiera:

(define (queen-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    (setf (board x y) "Q")
    ; creazione della lista di tutte le mosse
    ; mosse da Torre
    (for (k 1 7)
      ; basso
      (push (list (+ x k) y) moves)
      ; sinistra
      (push (list x (- y k)) moves)
      ; alto
      (push (list (- x k) y) moves)
      ; destra
      (push (list x (+ y k)) moves)
    )
    ; mosse da Alfiere
    (for (k 1 7)
      ; basso-destra
      (push (list (+ x k) (+ y k)) moves)
      ; basso-sinistra
      (push (list (+ x k) (- y k)) moves)
      ; alto-sinistra
      (push (list (- x k) (- y k)) moves)
      ; alto-destra
      (push (list (- x k) (+ y k)) moves)
    )
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " Q" cell "-" (mat-alg (list nx ny)))))
    )
    (print-board board)
    out))

Proviamo:

(queen-from "a1")
;->  x . . . . . . x
;->  x . . . . . x .
;->  x . . . . x . .
;->  x . . . x . . .
;->  x . . x . . . .
;->  x . x . . . . .
;->  x x . . . . . .
;->  Q x x x x x x x
;-> ("a2" "b1" "a3" "c1" "a4" "d1" "a5" "e1" "a6" "f1" "a7" 
;->  "g1" "a8" "h1" "b2" "c3" "d4" "e5" "f6" "g7" "h8")

(queen-from "d4")
;->  . . . x . . . x
;->  x . . x . . x .
;->  . x . x . x . .
;->  . . x x x . . .
;->  x x x Q x x x x
;->  . . x x x . . .
;->  . x . x . x . .
;->  x . . x . . x .
;-> ("d3" "c4" "d5" "e4" "d2" "b4" "d6" "f4" "d1" "a4" "d7" "g4" "d8" "h4"
;->  "e3" "c3" "c5" "e5" "f2" "b2" "b6" "f6" "g1" "a1" "a7" "g7" "h8")


-------------------------
Le mosse del Re (scacchi)
-------------------------

Un Re (King) degli Scacchi è posizionato in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili della Re.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, una Re sulla casella (x y) può muoversi in:
  
  (mosse da Torre di un passo)
  basso:    (x+1,y)
  sinistra: (x,y-1)
  alto:     (x-1,y)
  destra:   (x,y+1)

  (mosse da Alfiere di un passo)
  basso-destra:   (x+1,y+1)
  basso-sinistra: (x+1,y-1)
  alto-sinistra:  (x-1,y-1)
  alto-destra:    (x-1,y+1)

con una sola mossa.

Funzioni ausiliarie:

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))
(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))
(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))
(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che genera le mosse di una Torre posizionata in una casella (notazione algebrica) della scacchiera:

(define (king-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    (setf (board x y) "K")
    ; creazione della lista di tutte le mosse
    ; mosse da Torre di un passo
    ; basso
    (push (list (+ x 1) y) moves)
    ; sinistra
    (push (list x (- y 1)) moves)
    ; alto
    (push (list (- x 1) y) moves)
    ; destra
    (push (list x (+ y 1)) moves)
    ; mosse da Alfiere di un passo
    ; basso-destra
    (push (list (+ x 1) (+ y 1)) moves)
    ; basso-sinistra
    (push (list (+ x 1) (- y 1)) moves)
    ; alto-sinistra
    (push (list (- x 1) (- y 1)) moves)
    ; alto-destra
    (push (list (- x 1) (+ y 1)) moves)
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " K" cell "-" (mat-alg (list nx ny)))))
    )
    (print-board board)
    out))

Proviamo:

(king-from "a1")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  x x . . . . . .
;->  K x . . . . . .
;-> ("a2" "b1" "b2")

(king-from "d4")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . x x x . . .
;->  . . x K x . . .
;->  . . x x x . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("d3" "c4" "d5" "e4" "e3" "c3" "c5" "e5")


-----------------------------
Le mosse del Pedone (scacchi)
-----------------------------

Un Pedone (Pawn) degli Scacchi è posizionato in una casella della scacchiera.
Scrivere una funzione che genera tutte le mosse possibili della Pedone.

La casella è in notazione algebrica: colonna (a..h) e traversa (riga) (1..8).

Negli scacchi, un Pedone Bianco sulla casella (x y) può muoversi in:
  
  0 caselle: per x = 7 o x = 0
  
  1 casella:
  (x-1, y) per (1 <= x <= 5)
  
  2 caselle:
  (x-1, y) e (x-2, y) per (x = 6)
  
  caselle controllate:
  (x-1, y-1) e (x-1, y+1)

con una sola mossa.

Negli scacchi, un Pedone Nero sulla casella (x y) può muoversi in:

  0 caselle: per x = 0 o y = 7
  1 casella:
  (x+1, y) per (2 <= x <= 6)
  2 caselle:
  (x+1, y) e (x+2, y) per (x = 1)
  caselle controllate:
  (x+1, y-1) e (x+1, y+1)

con una sola mossa.

Funzioni ausiliarie:

(define (mat-alg ij) (string (char (+ 97 (ij 1))) (- 8 (ij 0))))
(define (alg-mat c) (list (- 8 (int (c 1))) (- (char (c 0)) 97)))
(define (valid? x y) (and (>= x 0) (<= x 7) (>= y 0) (<= y 7)))
(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))))
    (println)))

Funzione che genera le mosse di un Pedone Bianco posizionato in una casella (notazione algebrica) della scacchiera:

(define (pawn-white-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    ; creazione della lista di tutte le mosse
    (cond ((or (= x 0) (= x 7)) 
            (push (list x y) moves))
          ((= x 6)
            (push (list (- x 1) y) moves)
            (push (list (- x 2) y) moves))
          (true ; x in (1..5)
            (push (list (- x 1) y) moves))
    )
    ; caselle controllate
    (push (list (- x 1) (- y 1)) moves)
    (push (list (- x 1) (+ y 1)) moves)
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " P" cell "-" (mat-alg (list nx ny)))))
    )
    (setf (board x y) "P")
    (print-board board)
    out))

Proviamo:

(pawn-white-from "d1")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . x . x . . .
;->  . . . P . . . .
;-> ("d1" "c2" "e2")

(pawn-white-from "d2")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . x . . . .
;->  . . x x x . . .
;->  . . . P . . . .
;->  . . . . . . . .
;-> ("d3" "d4" "c3" "e3")

(pawn-white-from "d7")
;->  . . x x x . . .
;->  . . . P . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("d8" "c8" "e8")

(pawn-white-from "d8")
;->  . . . P . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("d8")

Funzione che genera le mosse di un Pedone Nero posizionato in una casella (notazione algebrica) della scacchiera:

(define (pawn-black-from cell)
  (local (out board moves coord x y nx ny)
    (setq out '())
    (setq board (array 8 8 '(" ")))
    (setq moves '())
    (setq coord (alg-mat cell))
    (setq x (coord 0))
    (setq y (coord 1))
    ; creazione della lista di tutte le mosse
    (cond ((or (= x 0) (= x 7)) 
            (push (list x y) moves))
          ((= x 1)
            (push (list (+ x 1) y) moves)
            (push (list (+ x 2) y) moves))
          (true ; x in (2..6)
            (push (list (+ x 1) y) moves))
    )
    ; caselle controllate
    (push (list (+ x 1) (- y 1)) moves)
    (push (list (+ x 1) (+ y 1)) moves)
    ; ricerca mosse valide
    (dolist (el moves)
      (if (valid? (el 0) (el 1))
        (begin
          (setf (board (el 0) (el 1)) "x")
          (push (mat-alg el) out)))
          ;(println " p" cell "-" (mat-alg (list nx ny)))))
    )
    (setf (board x y) "p")
    (print-board board)
    out))

Proviamo:

(pawn-black-from "b8")
;->  . p . . . . . .
;->  x . x . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("b8" "a7" "c7")

(pawn-black-from "b7")
;->  . . . . . . . .
;->  . p . . . . . .
;->  x x x . . . . .
;->  . x . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("b6" "b5" "a6" "c6")

(pawn-black-from "b4")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . p . . . . . .
;->  x x x . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> ("b3" "a3" "c3")

(pawn-black-from "b2")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . p . . . . . .
;->  x x x . . . . .
;-> ("b1" "a1" "c1")

(pawn-black-from "b1")
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . p . . . . . .
;-> ("b1")


--------------------------------
Antistringa (funzione swap-case)
--------------------------------

L'anti-stringa di una data stringa è la stringa con tutte le lettere invertite.
Per esempio:  AmmmOrE -> aMMMoRe

Scrivere la funzione più corta possibile che restituisce l'antistringa di una stringa.
La stringa in input è costituita solo da lettere minuscole e maiuscole.

(char "A")
;-> 65
(char "Z")
;-> 90

(char "a")
;-> 97
(char "z")
;-> 122
;-> 32

(- 97 65)
;-> 32
(- 122 90)
;-> 32

Prima funzione:

(define (anti1 str)
  (let (out "")
    (dostring (c str)
      (if (and (>= c 97) (<= c 122)) (push (char (- c 32)) out -1)
          (and (>= c 65) (<= c 92))  (push (char (+ c 32)) out -1)))))

(anti1 "AbCdEfGhIlMnOp")
;-> "aBcDeFgHiLmNoP"

Per calcolare la lunghezza della funzione vediamo come viene memorizzata da newLISP:

anti1
;-> (lambda (str)
;->  (let (out "")
;->   (dostring (c str)
;->    (if (and (>= c 97) (<= c 122))
;->     (push (char (- c 32)) out -1)
;->     (and (>= c 65) (<= c 92))
;->     (push (char (+ c 32)) out -1)))))

Quindi convertiamo la funzione in stringa e poi ne calcoliamo la lunghezza:

(length (string anti1))
;-> 166

Nota: cambiare il nome della funzione non modifica la sua lunghezza perchè il nome della funzione non compare nella rappresentazione interna.

Poichè la stringa è costituita solo da lettere minuscole e maiuscole risulta:

  se (char c) >= 97, allora c è maiuscolo, altrimenti è minuscolo  

Inoltre, usiamo "extend" invece di "push" e accorciamo il nome delle variabili.

Seconda funzione:

(define (anti2 s)
  (let (o "")
    (dostring (c s)
      (if (>= c 97) (extend o (char (- c 32)))
                    (extend o (char (+ c 32)))))))

(anti2 "AbCdEfGhIlMnOp")
;-> "aBcDeFgHiLmNoP"

Rappresentazione della funzione in newLISP:

anti2
;-> (lambda (s)
;->  (let (o "")
;->   (dostring (c s)
;->    (if (>= c 97)
;->     (extend o (char (- c 32)))
;->     (extend o (char (+ c 32)))))))

Lunghezza della funzione:

(length (string anti2))
;-> 111

Adesso usiamo "map".

Terza funzione:

(define (anti3 s)
  (join (map (fn(x) (if (>= x "a") (char (- (char x) 32)) (char (+ (char x) 32)))) (explode s))))

(anti3 "AbCdEfGhIlMnOp")
;-> "aBcDeFgHiLmNoP"

Rappresentazione della funzione:

anti3
;-> (lambda (s) (join (map (lambda (x)
;->     (if (>= x "a")
;->      (char (- (char x) 32))
;->      (char (+ (char x) 32))))
;->    (explode s))))

Lunghezza della funzione:

(length (string anti3))
;-> 112

(define (anti4 s)
(define (do k) (char c) k)
(define (do k) (char (k (char "a") 32)))
(do -)
(char (- (char x) 32))  
  (for (i 0 (- (length s) 1))
    (if (>= (s i) "a") (setq (s i) (char (- (char (s i)) 32)))
                       (setq (s i) (char (+ (char (s i)) 32)))))
  s)

(anti4  "AbCdEfGhIlMnOp")
(length (string anti4))
(setq maiuscole (map char (sequence 65 90))
(setq minuscole (map char (sequence 97 122))
(time )

Per finire scriviamo la funzione "swap-case" generica:

(define (swap-case str)
  (let (out "")
    (dostring (c str)
      (cond ((and (>= c 97) (<= c 122)) ; minuscolo -> maiuscolo
              (extend out (char (- c 32))))
            ((and (>= c 65) (<= c 92))  ; maiuscolo -> minuscolo
              (extend out (char (+ c 32))))
            (true ; altro carattere -> altro carattere
              (extend out (char c)))))))

(swap-case "a.B.c.D_e_F_g~H~i~L^m^N^o*P")
;-> "A.b.C.d_E_f_G~h~I~l^M^n^O*p"


------------------------------
Spalmare i valori di una lista
------------------------------

Data una lista di numeri interi, generare una lista ordinata con il carattere "." al posto dei numeri mancanti.

Esempio:
Input  = (3 5 -2 -1 -6 7 -1)
Output = (-6 . . . -2 -1 . . . 3 . 5 . 7)

Inoltre la funzione deve avere come argomenti due valori (minimo e massimo) che rappresentano i valori di inizio e di fine (che possono anche non essere presenti nei numeri della lista di input).

I numeri duplicati nella lista di input vengono riportati sono una volta nella lista di output.

Esempio:
Input  = (3 5 -2 -1 -6 7 3)
         Valore minimo = -8
         Valore massimo = 10
Output = (. . -6 . . . -2 -1 . . . 3 . 5 . 7 . . .)

(define (spread lst a b)
  (local (vmin vmax len ar)
    (setq vmin (or a (apply min lst)))
    (setq vmax (or b (apply max lst)))
    (setq len (- vmax vmin (- 1)))
    (setq ar (array len '(.)))
    (for (i 0 (- (length lst) 1))
      ; (- (lst i) vmin) is the index of ar for the value (lst i)
      (setf (ar (- (lst i) vmin)) (lst i))
    )
    ar))

Proviamo:

(spread '(3 5 -2 -1 -6 7 3))
;-> (-6 . . . -2 -1 . . . 3 . 5 . 7)

(spread '(3 5 -2 -1 -6 7 -1) -8 10)
;-> (. . -6 . . . -2 -1 . . . 3 . 5 . 7 . . .)

(spread (sequence 1 11 2))
;-> (1 . 3 . 5 . 7 . 9 . 11)

(spread (sequence 1 11 2) 0 12)
;-> (. 1 . 3 . 5 . 7 . 9 . 11 .)

(define (carte num)
  (let (seq (sequence 1 13))
    (println "Cuori:  " (spread (slice (randomize seq) 0 num) 1 13))
    (println "Quadri: " (spread (slice (randomize seq) 0 num) 1 13))
    (println "Fiori:  " (spread (slice (randomize seq) 0 num) 1 13))
    (println "Picche: " (spread (slice (randomize seq) 0 num) 1 13))
    '--------))

(carte 6)
;-> Cuori:  (. 2 3 . . . 7 8 . . 11 . 13)
;-> Quadri: (. 2 3 4 5 . . . . 10 . 12 .)
;-> Fiori:  (. . . 4 5 6 . . 9 10 11 . .)
;-> Picche: (. 2 . 4 . . 7 . 9 . 11 . 13)

============================================================================

