================

 NOTE LIBERE 20

================

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

============================================================================

