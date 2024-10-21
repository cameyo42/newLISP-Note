================

 NOTE LIBERE 20

================

         444         222222
        4444       222222222
       44444      222     222
      444444      222     222
     444 444      222     222
    444  444            2222
   444   444          2222
  444    444        2222
  4444444444444    222
  4444444444444   222
         444      222      222
         444      222222222222
         444      222222222222

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


----------------------------------------------------------------
Soluzione del ponte di Wheatstone sbilanciato con il metodo mesh
----------------------------------------------------------------

                 R2              R5
         +-----*****-----+-----*****-----+
         |               |               |
         |               *               |
  Va ----+            R3 *               +---- Vb
         |               *               |
         |       R1      |       R4      |
         +-----*****-----+-----*****-----+

 Vab = 24 Volt
 R1 = 150 Ohm
 R2 = 50 Ohm
 R3 = 100 Ohm
 R4 = 300 Ohm
 R5 = 250 Ohm

Loop 1:
  I1 = R1-R3-R2 (antiorario)
Loop 2:
  I2 = R4-R3-R5 (orario)
Loop 3:
  I3 = R4-R1    (antiorario)

Kirchhoff's Voltage Law (Loop 1):

  R2I1 + R3(I1+I2) + R1(I1−I3) = 0 Volt
  50I1 + 100(I1+I2) + 150(I1−I3) = 0 Volt

1) 300I1 + 100I2 − 150I3 = 0 Volt

Kirchhoff's Voltage Law (Loop 2):

  R5I2 + R3(I2+I1) + R4(I2+I3) = 0 Volt
  250I2 + 100(I2+I1) + 300(I2+I3) = 0 Volt

2) 100I1 + 650I2 + 300I3 = 0 Volt

Kirchhoff's Voltage Law (Loop 3):

  24 + R1(I3−I1) + R4(I3+I2) = 0 Volt
  24 + 150(I3−I1) + 300(I3+I2) = 0 Volt

3) −150I1 + 300I2 + 450I3 = -24 Volt

Solve the 3x3 system:

  300I1 + 100I2 − 150I3  = 0
  100I1 + 650I2 + 300I3  = 0
  −150I1 + 300I2 + 450I3 = -24

(setq a '((300 100 -150)
          (100 650  300)
          (-150 300 450)))
(setq b '(0 0 -24))

Function "sislin-g" is "yo.lsp" library:
(sislin-g a b)
;-> (-0.09379310344827588 0.07724137931034483 -0.1360919540229885)

Calculate branch resistor current values:

  IR1 = I3 − I1 = 136.092 − 93.793 = 42.299 mA

  IR2 = I1 = 93.793 mA

  IR3 = I1 − I2 = 93.793 − 77.241 = 16.552 mA

  IR4 = I3 − I2 = 136.092 − 77.241 = 58.851 mA

  IR5 = I2 = 77.241 mA

Calculate voltage drops:

  VR1 = IR1*R1 = (0.042299)*(150) = 6.3448 Volt

  VR2 = IR2*R5 = (0.093793)*(50) = 4.6897 Volt

  VR3 = IR3*R5 = (0.016552)*(100) = 1.6552 Volt

  VR4 = IR4*R5 = (0.058851)*(300) = 17.6553 Volt

  VR5 = IR5*R5 = (0.077241)*(250) = 19.3103 Volt


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

Vedere anche "List merge" su "Note libere 21".


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

Vedi anche "Consigli sparsi sul Problem Solving" su "Note libere 26".

***Versione Italiana***

Un quadro generale per la risoluzione dei problemi è stato descritto da G. Polya in un libro intitolato "How to Solve It!" (2a edizione, Princeton University Press).
Sebbene l'attenzione di Polya fosse rivolta alla risoluzione di problemi di matematica, le strategie sono molto più generali e ampiamente applicabili.
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
Although Polya's focus was on solving math problems, the strategies are much more general and are broadly applicable.
Inductive reasoning is the basis of most of the creative processes in the "real world".
Physics provides an ideal activity for building skill in inductive reasoning and discovery.

Here is an outline of Polya's framework:

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

Alle volte abbiamo la necessità/curiosità di conoscere quanto è lunga una funzione (in termini di caratteri).
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


-------------------------------
Forum: Address of list elements
-------------------------------

m35:
----
I'm working with a DLL that takes a char** as an argument (an array of char*).
It would be nice it I could keep the strings being passed in a list, and just pack the addresses of those list elements.

e.g.

(setq x '("a" "b" "c"))
(setq arg (eval (cons pack (cons (dup "ld" (length x)) (map address x)))))
(My_Dll_Func arg)

However, my tests don't suggest I'm getting the addresses of the list elements:

(setq x '("a" "b" "c"))
;-> ("a" "b" "c")
(address x)
;-> 12081232
(address (x 0))
;-> 12209376
(address (x 1))
;-> 12209776
(address (x 2))
;-> 12209296
(address (nth 0 x))
;-> 12209376
(address (nth 1 x))
;-> 12209776
(address (nth 2 x))
;-> 12209296
(map address x)
;-> (12209152 12209440 12209408)

Work-arounds I've considered:
* Put every string into a separate symbol so I can get the addresses.
* Pack every string into one big string, then get the address of this big string, and add the offsets of each substring.

Neither of these work-arounds make me very happy.
Is there any better solution?

Lutz:
-----
* Put every string into a separate symbol so I can get the addresses.
* Pack every string into one big string, then get the address of this big string, and add the offsets of each substring.

Either one would work. Only the symbol (variable) guarantees you a fixed addresss for the string contained. All other methods just get addresses of volatile memory objects. The symbol acts like a pointer to the string contained.

(set 'V '(v1 v2 v3))
;-> (v1 v2 v3)
(map set V '("A" "B" "C"))
;-> ("A" "B" "C")

(set 'char** (eval (append (cons pack (dup "lu" (length V))) V)))
"PN║\000`M║\000 L║\000" ; 3 32-bit addresses = 12 bytes

(length char**) ; the length function works on binary contents
;-> 12

(get-string (get-int (+ (address char**) 0)))
;-> "A"
(get-string (get-int (+ (address char**) 4)))
;-> "B"
(get-string (get-int (+ (address char**) 8)))
;-> "C"

Similar to your first approach, but the difference is that the strings are referenced via the symbols v1,v2,v3.
Symbols holding strings work like C pointers.

ps:
(append (cons 'pack (dup "lu" (length V))) V)
;-> (pack "lululu" v1 v2 v3)

The quote before the pack isn't really required, but makes for better looking output ;)


-----------------------------------------
Postulato di Bertrand e primi di Bertrand
-----------------------------------------

Il postulato di Bertrand (1845) afferma che per ogni intero n > 3 esiste almeno un numero primo p tale che n < p < 2n − 2.
Una formulazione più debole, ma più concisa è: tra un numero n > 1 ed il suo doppio esiste almeno un numero primo.
Un'altra formulazione, dove p(n) è l'n-esimo primo, è la seguente: p(n+1) < 2*p(n).
Questa congettura fu completamente dimostrata da Chebyshev nel 1852 e quindi il postulato è anche chiamato teorema di Bertrand-Chebyshev o teorema di Chebyshev.

I Primi di Bertrand sono definiti nel modo seguente:
  a(1) = 2
  a(n) è il primo più grande < 2*a(n-1), per n > 1

Sequenza OEIS A006992:
Bertrand primes: a(n) is largest prime < 2*a(n-1) for n > 1, with a(1) = 2.
  2, 3, 5, 7, 13, 23, 43, 83, 163, 317, 631, 1259, 2503, 5003, 9973, 19937,
  39869, 79699, 159389, 318751, 637499, 1274989, 2549951, 5099893, 10199767,
  20399531, 40799041, 81598067, 163196129, 326392249, 652784471, 1305568919,
  2611137817, ...

Scrivere una funzione per generare la sequenza dei Primi di Bertrand:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (previous-prime num)
  (until (prime? (-- num)))
  num)

(define (bertrand limit)
  (let (out '(2))
    (for (i 1 limit)
      (push (previous-prime (* 2 (out (- i 1)))) out -1))
    out))

Proviamo:

(bertrand 30)
;-> (2 3 5 7 13 23 43 83 163 317 631 1259 2503 5003 9973 19937 39869 79699
;->  159389 318751 637499 1274989 2549951 5099893 10199767 20399531 40799041
;->  81598067 163196129 326392249 652784471)


---------------------------------
Forum: Controlling function scope
---------------------------------

Jeff:
-----
Is there a way to control the context in which code is evaluated at runtime? For example, let's say I have this context:

(context 'foo)
(set 'a 10)
(context MAIN)

If I have a function, (fn () (println a)), is there a way I can apply it in the context of foo?

In Javascript, you can do some_function.apply(foo, args), which is the same as:

foo.fn = some_function;
foo.fn(args);
delete foo.fn;

From within the function call, the 'this' keyword would then refer to the scope 'foo'. Can this be done in newLISP?

cormullion:
-----------
I'm not too sure what you mean, Jeff. My reading of your question, based on my limited understanding of newLISP, leads to this:

(context 'foo)
;-> (set 'a 10)

(context 'bar)
;-> (set 'a 20)

(context MAIN)
;-> MAIN

(define (p c s)
   (println (eval (sym s c))))

(p 'foo 'a)
;-> 10

(p 'bar 'a)
;-> 20

But I suspect that you don't mean anything as simple as this...?! :-)

Jeff:
-----
I'm talking about dynamically binding a function to a context for the period of execution, something perhaps along the lines of:

(set 'foo:a 10)
(set 'a 20)
(define (f) (println a))
(def-new 'f 'foo:f)
;-> (foo:f)
(delete 'foo:f)
;-> true

Lutz:
-----

I'm talking about dynamically binding a function to a context for the period of execution.

no, all symbols occuring in your function are bound during code translation, not application.

For example: (in a new REPL)

(set 'x "hello")
;-> "hello"
(set 'x "main hello")
;-> "main hello"
(set 'ctx:x "ctx hello")
;-> "ctx hello"
(define (foo) (println x))
;-> (lambda () (println x))
(set 'ctx:foo foo)
;-> (lambda () (println x))
(ctx:foo)
;-> main hello
;-> "main hello"
(foo)
;-> main hello
;-> "main hello"

Jeff:
-----
Does def-new and new bind new symbols in the target context, then? What about a dynamically built lambda or a lambda templated from a macro? Are their symbols late-bound in the context in which they were created? Or are they bound in the context in which the forming function is defined?

Lutz:
-----

Does def-new and new bind new symbols in the target context, then?

yes, they create new symbols in the target context

What about a dynamically built lambda or a lambda templated from a macro?

yes, you can build lambda expressions dynamically, just like you can create lists dynamically, but using existing symbols.

Are their symbols late-bound in the context in which they were created?

yes, for example in this case (in a new REPL):

(define (foo ctx value) (set 'ctx:data value))
;-> (lambda (ctx value) (set 'ctx:data value))

(context 'myctx) (context MAIN)
;-> myctx
;-> MAIN
(foo myctx 123)
;-> 123
myctx:data
;-> 123

When foo is called with 'myctx' as a context, 'myctx:data' does not yet exist, but gets created on demand. Before 'foo' was called the first time 'data' did not exist in any context. After the call it exists in 'myctx'.
When calling 'foo' again with yet another context, a new 'data' in that other context could be created if it does not exist yet.

Any object system for newLISP should not try to build objects as namespaces but rather use lists and use the namespace only to store class methods.
Read the new chapter "17. Object-Oriented Programming in newLISP" in the latest development release regarding all this.
Any object system trying to imitate Scheme closures or JavaScript like function namespaces will not work well for newLISP because of the relative inefficiency of deleting symbols.

For newLISP the best way to do OO programming is, to use namespaces only for organizing methods into classes and build objects using lists, where the first list member points to the class, and the new ':' colon operator implements polymorphism (read chapter 17).
Doing it this way objects can be anonymous, have very little overhead and can be memory managed by newLISP efficiently.

Jeff:
-----
I wasn't intending to use newLISP for OOP. I was writing an event-based application and one thing that is extremely helpful in that is controlling the environment in which a callback is executed. Javascript has a very neat model for this. The ability to dynamically bind a function to the scope desired makes event-based programming efficient and elegant. It's a shame newLISP can't do this.

Lutz:
-----
The ability to dynamically bind a function to the scope desired makes event-based programming efficient and elegant.

Event-based programming is very much related to OO programming and message passing. Originally OO programming was developed for implementening event based programs (see the Simula programming language). In the new newLISP OOP model you could see objects as implementing different scopes receiving a message:

(:message object)

The : operator ensures the late binding of the message to the suiting scope and method of the object.

ps: there is a second (older) method of binding functions to different scopes based on the dynamic scoping mechanism inside one namespace in newISP. You could pass your function as parameter to another lambda-object:

(define (report-message)
    (print x))

(define (object-a f (x "hello"))
    (f x))

(define (object-b f (x "world"))
    (f x))

(object-a report-message)
;-> hello"hello"
(object-b report-message)
;-> world"world"

of course this works only if objects are in the same namespace.
The OOP based method would not have this limitation.

Fanda:
------
I also tried:

(context 'foo)
(set 'x 5)
(define (ctx-eval-string)
   (apply eval-string (args)))

(context 'bar)
(set 'x 10)
(define (ctx-eval-string)
   (apply eval-string (args)))

(context MAIN)

(define (f) x)
(define (g a) (* a x))

(define (fn->ctx-fn _ctx _f)
   (apply (sym 'ctx-eval-string _ctx) (list (string _f))))

Example:

f
;-> (lambda () x)
g
;-> (lambda (a) (* a x))
(fn->ctx-fn 'foo f)
;-> (lambda () foo:x)
(fn->ctx-fn 'bar f)
;-> (lambda () bar:x)
(fn->ctx-fn 'foo g)
;-> (lambda (foo:a) (* foo:a foo:x))
(fn->ctx-fn 'bar g)
;-> (lambda (bar:a) (* bar:a bar:x))
((fn->ctx-fn 'foo f))
;-> 5
((fn->ctx-fn 'foo g) 10)
;-> 50
((fn->ctx-fn 'bar f))
;-> 10
((fn->ctx-fn 'bar g) 10)
;-> 100

(set 'myg (fn->ctx-fn 'foo g))
;-> (lambda (foo:a) (* foo:a foo:x))
(myg 10)
;-> 50

It works as long as 'ctx-eval-string' function is in every context you want to work with.


--------------------------------
Rotazione di colonne di stringhe
--------------------------------

Date le seguenti tre stringhe, ruotare n volte l'n-ennesima colonna verso il basso.

  " bC#eF&hI)kL,nO/qR2tU5wX8z"
  "A!cD$fG'iJ*lM-oP0rS3uV6xY9"
  "aB"dE%gH(jK+mN.pQ1sT4vW7yZ"

  " !"#$%&'()*+,-./0123456789"
  "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  "abcdefghijklmnopqrstuvwxyz"

(define (ruota-stringhe)
  (local (m mt)
    (setq m '(
      (" " "b" "C" "#" "e" "F" "Z" "h" "I" "Z" "k" "L" "," "n" "O" "/" "q" "R" "2" "t" "U" "5" "w" "X" "8" "z" )
      ("A" "!" "c" "D" "$" "f" "G" "'" "i" "J" "*" "l" "M" "-" "o" "P" "0" "r" "S" "3" "u" "V" "6" "x" "Y" "9" )
      ("a" "B" "\"" "d" "E" "%" "g" "H" "(" "j" "K" "+" "m" "N" "." "p" "Q" "1" "s" "T" "4" "v" "W" "7" "y" "Z")))
    (setq mt (transpose m))
    ;(print-matrix mt)
    (for (r 0 (- (length mt) 1)) (rotate (mt r) (- (% r len))))
    (print-matrix (transpose mt))
    (dolist (el (transpose mt)) (println (join el)))
    '--------))

(ruota-stringhe)
;->   ! " # $ % Z ' ( Z * + , - . / 0 1 2 3 4 5 6 7 8 9
;-> A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
;-> a b c d e f g h i j k l m n o p q r s t u v w x y z
;-> !"#$%Z'(Z*+,-./0123456789
;-> ABCDEFGHIJKLMNOPQRSTUVWXYZ
;-> abcdefghijklmnopqrstuvwxyz
;-> --------


---------------------------
Acquisto e vendita di merce
---------------------------

Abbiamo una certa quantità di soldi da investire e conosciamo i prezzi di vendita/acquisto di una certa merce per i prossimi N giorni.
Possiamo effettuare solo un'operazione al giorno (comprare o vendere).
Scrivere una funzione che massimizza il guadagno.

Per esempio, immaginiamo di acquistare e vendere vino con i seguenti dati:
Soldi da investire = 10$
Prezzo di 1 litro di vino nei prossimi 4 giorni: (4 10 5 20)
Per massimizzare il profitto occorre:
Il primo giorno acquistiamo 10$ di vino a 4$/l, (10$ / 4$/l = 2.5l), 2.5l
Il secondo giorno vendiamo 2.5l di vino a 10$/l, (2.5l * 10$/l = 25$), 25$
Il terzo giorno acquistiamo 25$ di vino a 5$/l (25$ / 5$/l = 5l), 5l
Il quarto giorno vendiamo 5l di vino a 20$, (5l * 20$/l = 100$), 100$

Vediamo altri esempi:

Soldi = 20$
Prezzi = (10 8 3)
Profitto max = 20
Perché è meglio non comprare/vendere la merce.

Soldi = 10$
Prezzi = 8 10 14
Profitto max = 17.5
Si acquista la merce il primo giorno e si rivende al terzo giorno.

Soldi = 10
Prezzi = (4 2 10 5 20)
Profitto max = 200
Molto simile al primo esempio, ma questa volta aspettiamo che il prezzo scenda a 2 prima di effettuare il primo acquisto.

Algoritmo
I rapporti tra il termine successivo e il termine precedente di ogni termine della lista dei prezzi produce il valore del rendimento di quell'acquisto/vendita combinato.
Per esempio con i prezzi (2 4 10 5) otteniamo:

  ((4 / 2) (10 / 4) (5 /10)) = (2 2.5 0.5)

Se acquistiamo il primo giorno e vendiamo il secondo giorno abbiamo un rendimento pari a (4 / 2) = 2
Se acquistiamo il secondo giorno e vendiamo il terzo giorno abbiamo un rendimento pari a (10 /4) = 2.5
Se acquistiamo il terzo giorno e vendiamo il quarto giorno abbiamo un rendimento pari a (5 / 10) = 0.5

Poichè il nostro scopo è di massimizzare il guadagno, allora dobbiamo acquistare/vendere nei giorni in cui il rendimento è maggiore di 1.
Inoltre, poichè la nostra cifra inziale viene moltiplicata per tutti i rendimenti, per ottenere il rendimento massimo basta moltiplicare la cifra iniziale per tutti i rendimenti maggiori di 1.

(define (commerce money lst)
  (local (pair ones max-values))
    ; divisione a coppie di numeri (secondo / primo)
    (setq pair (map div (rest lst) (chop lst)))
    ; genera una lista con tutti 1
    (setq ones (dup 1 (length pair)))
    ; calcola il valore max tra le coppie di elementi di pair e ones
    ; (in pratica imposta a 1 tutti i valori inferiori a 1)
    (setq max-values (map max pair ones))
    (println "pair: " pair)
    (println "ones: " ones)
    (println "max-values: " max-values)
    ; calcola il profitto max moltiplicando tutti i rendimenti
    ; e il capitale iniziale
    ; (i rendimenti minori di 1 sono stati posti a 1
    ; e non influiscono nella moltiplicazione)
    (mul money (apply mul max-values)))

Proviamo:

(commerce 12 '(4 10 5 20))
;-> pair: (2.5 0.5 4)
;-> ones: (1 1 1)
;-> max-values: (2.5 1 4)
;-> 120

(commerce 20 '(10 8 3))
;-> pair: (0.8 0.375)
;-> ones: (1 1)
;-> max-values: (1 1)
;-> 20

(commerce 10 '(8 10 14))
;-> pair: (1.25 1.4)
;-> ones: (1 1)
;-> max-values: (1.25 1.4)
;-> 17.5

(commerce 10 '(4 2 10 5 20))
;-> pair: (0.5 5 0.5 4)
;-> ones: (1 1 1 1)
;-> max-values: (1 5 1 4)
;-> 200

Se vogliamo conoscere quando comprare e quando vendere esplicitamente possiamo scrivere:

(define (comme money lst)
  (local (pair ones max-values)
    ; divisione a coppie di numeri (secondo / primo)
    (setq pair (map div (rest lst) (chop lst)))
    (dolist (r pair)
      (cond ((> r 1)
              (println "Giorno " (+ $idx 1) ": comprare a " (lst $idx))
              (println "Giorno " (+ $idx 2) ": vendere a " (lst (+ $idx 1))))
      ))))

Comunque questa funzione non restituisce sempre i valori corretti:

; corretto
(comme 12 '(4 10 5 20))
;-> Giorno 1: comprare a 4
;-> Giorno 2: vendere a 10
;-> Giorno 3: comprare a 5
;-> Giorno 4: vendere a 20

; corretto
(comme 20 '(10 8 3))
;-> nil

; errato
(comme 10 '(8 10 14))
;-> Giorno 1: comprare a 8
;-> Giorno 2: vendere a 10
;-> Giorno 2: comprare a 10
;-> Giorno 3: vendere a 14

; corretto
(comme 10 '(4 2 10 5 20))
;-> Giorno 2: comprare a 2
;-> Giorno 3: vendere a 10
;-> Giorno 4: comprare a 5
;-> Giorno 5: vendere a 20

Il caso errato dipende dal fatto che non si può comprare e vendere nello stesso giorno.
Allora eliminiamo tutti i valori doppi.

(define (commercio money lst)
  (local (out pair len parziale qty one max-values)
    (setq out '())
    ; divisione a coppie di numeri (secondo / primo)
    (setq pair (map div (rest lst) (chop lst)))
    ;(println pair)
    (setq len (length pair))
    ; guadagno parziale
    (setq parziale money)
    ; ciclo per ogni rendimento
    (for (i 0 (- len 1))
      ;se rendimento > 1, allora inseriamo in una lista:
      ; (giorno di acquisto, prezzo) e
      ; (giorno di vendita, prezzo)
      (if (> (pair i) 1) (begin
          (push (list (+ i 1) (lst i)) out -1)
          (push (list (+ i 2) (lst (+ i 1))) out -1)))
          ; the following don't work when we wait for a better price
          ;(println "xxx Giorno " (+ i 1) ": comprare a " (lst i))
          ;(println "xxx Giorno " (+ i 2) ": vendere a " (lst (+ i 1)))))
    )
    ;(println out)
    ; elimina tutte le coppie di valori duplicate (diverso da "unique")
    ; es. ((1 8) (2 10) (2 10) (3 14)) --> ((1 8) (3 14))
    (setq out (filter (fn(x) (= (count (list x) out) '(1))) out))
    ; stampa le azioni per massimizzare il profitto
    (dolist (el out)
      (cond
        ((even? $idx)
         ; quantità di merce acquistata
         (setq qty (div parziale (el 1)))
         (println "Giorno " (el 0) ": comprare a " (el 1) "$ (" qty " unità)"))
        ((odd? $idx)
         ; guadagno parziale
         (setq parziale (mul qty (el 1)))
         (println "Giorno " (el 0) ": vendere a " (el 1) "$ (" parziale "$)"))
      )
    )
    ; calcolo del guadagno totale
    (setq ones (dup 1 (length pair)))
    (setq max-values (map max pair ones))
    (mul money (apply mul max-values))
    (println "Guadagno totale = " (mul money (apply mul max-values)) "$")
    out
    '------------))

Proviamo:

(commercio 12 '(4 10 5 20))
;-> Giorno 1: comprare a 4$ (3 unità)
;-> Giorno 2: vendere a 10$ (30$)
;-> Giorno 3: comprare a 5$ (6 unità)
;-> Giorno 4: vendere a 20$ (120$)
;-> Guadagno totale = 120$
;-> ------------

(commercio 21 '(10 8 3))
;-> Guadagno totale = 21$
;-> ------------

(commercio 10 '(8 10 14))
;-> Giorno 1: comprare a 8$ (1.25 unità)
;-> Giorno 3: vendere a 14$ (17.5$)
;-> Guadagno totale = 17.5$
;-> ------------

(commercio 10 '(4 2 10 5 20))
;-> Giorno 2: comprare a 2$ (5 unità)
;-> Giorno 3: vendere a 10$ (50$)
;-> Giorno 4: comprare a 5$ (10 unità)
;-> Giorno 5: vendere a 20$ (200$)
;-> Guadagno totale = 200$
;-> ------------

Vediamo la funzione più corta per risolvere il problema iniziale:

(define (solve money lst)
    (mul money (apply mul
        (map max (map div (rest lst) (chop lst))
                 (dup 1 (length pair))))))

(solve 12 '(4 10 5 20))
;-> 120
(solve 20 '(10 8 3))
;-> 20
(solve 10 '(8 10 14))
;-> 17.5
(solve 10 '(4 2 10 5 20))
;-> 100

Vedi anche "Acquistare e vendere azioni" in "Note libere 5".


-------------------------------
Confrontare due liste di numeri
-------------------------------

Possiamo confrontare due liste di numeri con gli operatori ">", "<", ">=", "<=" e "=".

(setq a '(3 4 7 2))
(setq b '(4 2 1 3))
(< a b)
;-> true
Perchè il primo numero della lista "a" (3) è minore del primo numero della lista "b" (4).

Se i primi numeri delle due liste sono uguali, allora newLISP confronta i secondi numeri e cosi via.

(setq a '(3 4 7 2))
(setq b '(3 2 1 3))
(> a b)
;-> true
Perchè 3=3 e 4>2.

Questo metodo di confronto si applica anche alle liste annidate.

(setq a '(3 (4 1) 3))
(setq b '(3 (3 7) 3))
(> a b)
;-> true
(setq a '(3 (4 7) 3))
(setq b '(3 (4 7) 2))
(> a b)
;-> true

(setq a '((1 2) (1 3) (4 2) (4 2) (4 3) (4 3 (9)) (4 3 (1 3)) (4 3 (1 4))))
(setq b '((1 2) (1 3) (4 2) (4 2) (4 3) (4 3 (1)) (4 3 (1 3)) (4 3 (1 4))))
(> a b)
;-> true

Nota: anche la funzione "sort" ha questo comportamento, cioè ordina anche le sottoliste.
(setq a '((4 3 (1 4)) (4 3 (1 3)) (1 3) (1 2 3 4) (1 2) (4 3) (4 3 (1)) (4 2)))
(sort a)
;-> ((1 2) (1 2 3 4) (1 3) (4 2) (4 3) (4 3 (1)) (4 3 (1 3)) (4 3 (1 4)))


------------------------------------------------------------
Radici, minimi e massimi di polinomi con coefficienti interi
------------------------------------------------------------

Per trovare le radici di un polinomio con coefficienti interi abbiamo a disposizione diverse tecniche di analisi (metodo di Newton, algoritmo di Bairstow, ecc).
Per trovare i minimi e i massimi locali possiamo uguagliare a 0 la derivata prima del polinomio e calcolare le sue radici.
Per esempio, calcoliamo i minimi e massimi del seguente polinomio:

  p(x) = x^3 - 12x^2 + 45x + 8.
  Derivata prima: 3x^2 − 24x + 45
  Radici dell'equazione: 3x^2 − 24x + 45 = 0, x = 3 e x = 5.
  p(3) = 62 (massimo locale)
  p(5) = 58 (minimo locale)

Comunque in questo caso proviamo a risolvere il problema non con tecniche di analisi, ma con tecniche numeriche di forza bruta.

Per calcolare i minimi e i massimi di un polinomio possiamo calcolare i valori della funzione in un determinato intervallo (con un certo passo di campionamento) e controllare se e dove la funzione cambia da crescente in decrescente (massimo locale) o viceversa da decrescente a crescente (minimo locale).
La precisione del risultato aumenta con il diminuire del passo di campionamento (step).

(define (min-max func xmin xmax step)
  (local (up) ; up = true -> direzione crescente
    ; controllo dei primi due valori di f(x) per determinare se
    ; la funzione è crescente o decrescente
    (if (>= (func (add xmin step)) (func xmin)) (setq up true) (setq up nil))
    ; ciclo da xmin a xmax con passo step
    (for (x (add xmin (mul 2 step)) xmax step)
            ; cambio della funzione da decrescente a crescente (minimo locale)
      (cond ((and (> (func x) (func (sub x step))) (= up nil))
              (setq up true)
              (println "Minimo per x = " (format "%4.4f" x)
                        " e y = " (format "%4.4f" (func x))))
            ; cambio della funzione da crescente a decrescente (massimo locale)
            ((and (< (func x) (func (sub x step))) (= up true))
              (setq up nil)
              (println "Massimo per x = " (format "%4.4f" x)
                        " e y = " (format "%4.4f" (func x))))))))

Facciamo qualche prova:

p(x) = x^3 - 12x^2 + 45x + 8
(define (f x) (add (mul x x x) (mul -12 x x) (mul 45 x) 8))
(solve f -10 10 0.001)
;-> Massimo per x = 3.0010 e y = 62.0000
;-> Minimo per x = 5.0010 e y = 58.0000

Poichè le soluzioni sono 3 e 5, possiamo diminuire l'intervallo e il passo di campionamento per migliorare il risultato:

(solve f 2 6 0.00001)
;-> Minimo o Massimo per x = 3.0000 e y = 62.0000
;-> Minimo o Massimo per x = 5.0000 e y = 58.0000

Possiamo verificare i valori:
(f 3)
;-> 62
(f 5)
;-> 58

p(x) = x^2 - 2
(define (f x) (add (mul x x) -2))
(solve f -10 10 0.001)
;-> Minimo o Massimo per x = 0.0010 e y = -2.0000
(solve f -1 1 0.00001)
;-> Minimo o Massimo per x = 0.0000 e y = -2.0000

p(x) = 2x^3 + 3x^2 - 36x + 10
(define (f x) (add (mul 2 x x x) (mul 3 x x) (mul -36 x) 10))
(solve f -10 10 0.001)
;-> Minimo o Massimo per x = -2.9990 e y = 91.0000
;-> Minimo o Massimo per x = 2.0010 e y = -34.0000
(solve f -4 3 0.00001)
;-> Minimo o Massimo per x = -3.0000 e y = 91.0000
;-> Minimo o Massimo per x = 2.0000 e y = -34.0000

p(x) = x^4 - 8x^3 +22x^2 - 24x + 8
(define (f x) (add (mul x x x x) (mul -8 x x x) (mul 22 x x) (mul -24 x) 8))
(solve f -10 10 0.001)
;-> Minimo o Massimo per x = 1.0010 e y = -1.0000
;-> Minimo o Massimo per x = 2.0010 e y = -0.0000
;-> Minimo o Massimo per x = 3.0010 e y = -1.0000
(solve f 0 4 0.00001)
;-> Minimo o Massimo per x = 1.0000 e y = -1.0000
;-> Minimo o Massimo per x = 2.0000 e y = -0.0000
;-> Minimo o Massimo per x = 3.0000 e y = -1.0000

La velocità della funzione dipende dalla dimensione dell'intevallo e dal valore del passo di campionamento:
(define (f x) (add (mul x x x x) (mul -8 x x x) (mul 22 x x) (mul -24 x) 8))
(time (solve f -10 10 0.001))
;-> 11.948
(time (solve f -10 10 0.0001))
;-> 106.184
(time (solve f -10 10 0.00001))
;-> 1035.695
(time (solve f -20 20 0.00001))
;-> 2061.509

Per quanto riguarda il calcolo delle radici del polinomio, adottiamo la stessa tecnica (intervallo di campionamento) verificando se due valori f(x) e f(x+step) sono uno maggiore di zero e uno minore di zero.
In questo caso poniamo la radice uguale a (f(x) + f(x+step))/2.

(define (roots func xmin xmax step)
  (for (x xmin xmax step)
       (if (or (and (>= (f x) 0)  (< (f (add x step)) 0))
               (and (<= (f x) 0)  (> (f (add x step)) 0)))
            (println "Radice: " (div (add x (add x step)) 2)))))

Funzione molto simile:

(define (roots func xmin xmax step)
  (for (x xmin xmax step)
    (cond ((zero? (f x)) (println "Radice: " x { } (f x)))
          ((or (and (> (f x) 0)  (< (f (add x step)) 0))
               (and (< (f x) 0)  (> (f (add x step)) 0)))
            (println "Radice: " (div (add x (add x step)) 2))))))

Nota: per polinomi con coefficienti interi, il valore assoluto di qualsiasi radice è strettamente inferiore alla somma dei valori assoluti dei coefficienti.
Questo ci permette di limitare l'intervallo di campionamento.
Per esempio, la somma dei valori assoluti dei coefficienti del polinomio p(x) = (x+1)(x-2)(x-3) = x^3 - 4 x^2 + x + 6 vale 1 + 4 + 1 + 6 = 12. Quindi non possono esistere radici al di fuori dell'intervallo (-12, 12).

Facciamo alcune prove:

(define (f x) (add (mul x x x) (mul -4 x x) x 6))
(roots f -10 10 0.001)
;-> Radice: -1.0005             ; -1
;-> Radice: -0.9995000000000001 ; -1
;-> Radice: 1.999500000000001   ; 2
;-> Radice: 2.0005              ; 2
;-> Radice: 3.0005
(roots f -2 4 0.000001)
;-> Radice: -0.9999994999999999
;-> Radice: 2.0000005
;-> Radice: 3.0000005

(define (f x) (add (mul x x x) (mul -12 x x) (mul 45 x) 8))
(roots f -66 66 0.001)
;-> Radice: -0.1695000000000017
(roots f -1 0 0.000001)
;-> Radice: -0.1699655000000001
(f -0.1699655000000001)
;-> -1.676373999259795e-005

(define (f x) (add (mul x x) 2))
(roots f -10 10 0.001)
;-> nil

(define (f x) (add (mul x x) -2))
(roots f -3 3 0.001)
;-> Radice: -1.4145
;-> Radice: 1.4145
(roots f -2 2 0.000001)
;-> Radice: -1.4142135
;-> Radice: 1.4142135
(f 1.4142135)
;-> -1.764177499641306e-007
(f -1.4142135)
;-> -1.764177499641306e-007

(define (f x) (add (mul 2 x x x) (mul 3 x x) (mul -36 x) 10))
(roots f -51 51 0.001)
;-> Radice: -5.169500000000001
;-> Radice: 0.2855000000000037
;-> Radice: 3.383500000000002
(roots f -6 4 0.000001)
;-> Radice: -5.1692485
;-> Radice: 0.2858864999999996
;-> Radice: 3.383361499999999
(f -5.1692485)
;-> 1.325659076201191e-005
(f 0.2858864999999996)
;-> 1.09036737789836e-005
(f 3.383361499999999)
;-> -1.692382952001026e-005

(define (f x) (add (mul x x x x) (mul -8 x x x) (mul 22 x x) (mul -24 x) 8))
(roots f -65 65 0.001)
;-> Radice: 0.5855000000000079
;-> Radice: 2.0005
;-> Radice: 3.414500000000001
(roots f 0 4 0.000001)
;-> Radice: 0.5857865
;-> Radice: 2.0000005
;-> Radice: 3.4142135
(f 0.5857865)
;-> -3.528354692861058e-007
(f 2.0000005)
;-> -4.973799150320701e-013
(f 3.4142135)
;-> -3.528355136950268e-007

Nota: questi metodi per calcolare le radici e i minimi/massimi di un polinomio sono molto spartani, ma a volte possono essere utili per una valutazione di massima.


------------------------
Matrice (Grafo) connessa
------------------------

Un grafo G = (V, E) è detto connesso se, per ogni coppia di vertici (u, v) di V, esiste un cammino che collega u a v.
Un grafo è connesso se esso è composto di una sola componente connessa.

Se in un grafo esiste una coppia di vertici (u, v) di V che non ammette un cammino che li colleghi, tale grafo si dice disconnesso.

Nel caso di una matrice di 0 e 1 possiamo dire che la matrice è connessa se da ogni cella della matrice che contiene un 1 è possibile raggiungere tutte le altre celle con valore 1.
Abbiamo due tipi di connessione tra le celle:
- connessione con le quattro celle adiacenti (alto, basso, sinistra, destra)
- connessione con le otto celle adiacenti (alto, basso, sinistra, destra, basso-sinistra, basso-destra, alto-sinistra, alto-destra)

Possiamo risolvere il problema con una ricerca (BFS, Breadth-First Search) o DFS (Depth-First-search).

Vedi "Attraversamento di grafi - Algoritmo BFS (Breadth-First Search)" e "Attraversamento di grafi - Algoritmo DFS (Depth-First Search)" in "Note libere 8".

Funzione che controlla se la cella rientra nei limiti della matrice, è un '1' e non è stata ancora visitata:

(define (isvalid matrix row col rows cols)
  (and (>= row 0) (< row rows) (>= col 0) (< col cols)
       (= (matrix row col) 1)
       (not (visited row col))))

Funzione che effettua la ricerca DFS:

(define (dfs matrix row col rows cols)
  ;Mosse possibili(4): alto, basso, sinistra, destra
  (setq moves '((-1 0) (1 0) (0 -1) (0 1)))
  (setf (visited row col) true)
  (dolist (m moves)
    (setq newrow (+ row (m 0)))
    (setq newcol (+ col (m 1)))
    (if (isvalid matrix newrow newcol rows cols)
        (dfs matrix newrow newcol rows cols))))

Funzione che verifica se una matrice è connessa:

(define (isconnected matrix)
  (setq out true)
  (setq rows (length matrix))
  (setq cols (length (matrix 0)))
  (setq visited (array rows cols '(nil)))
  ; Cerca il primo '1' nella matrice sui cui avviare il DFS
  (for (r 0 (- rows 1))
    (for (c 0 (- cols 1))
      (if (and (= (matrix r c) 1) (not (visited r c)))
          (dfs matrix r c rows cols)
          ; controlla se c'è qualche cella '1' che non è stata visitata
          (for (i 0 (- rows 1))
            (for (j 0 (- cols 1))
              (if (and (= (matrix i j) 1) (not (visited i j)))
                  (setq out nil)
              )
            )
          )
      )
    )
  )
  out)

Facciamo alcune prove:

(setq m '((1 1 0 0)
          (1 0 0 1)
          (0 0 1 1)
          (1 1 1 1)))
(isconnected m)
;-> nil

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 1 1 1)
          (1 1 1 1)))
(isconnected m)
;-> true

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 0 1 1)
          (1 1 1 1)))
(isconnected m)
;-> nil

(setq m '((1 1 1 1)
          (1 0 0 1)
          (1 0 0 1)
          (1 1 1 1)))
(isconnected m)
;-> true

Possiamo ottimizzare le funzioni sfruttando l'ambito dinamico.

Le variabili 'matrix', 'cols' e 'rows' non cambiano, quindi possiamo non passarle alle funzioni:
Funzione che controlla se la cella rientra nei limiti della matrice, è un '1' e non è stata ancora visitata:

(define (isvalid row col)
  (and (>= row 0) (< row rows) (>= col 0) (< col cols)
       (= (matrix row col) 1)
       (not (visited row col))))

Funzione che effettua la ricerca DFS:

(define (dfs row col)
  (local (newrow newcol)
    (setf (visited row col) true)
    (dolist (m moves)
      (setq newrow (+ row (m 0)))
      (setq newcol (+ col (m 1)))
      (if (isvalid newrow newcol)
          (dfs newrow newcol)))))

I cicli 'for' che controllano gli '1' visitati possono essere interrotti al primo nil.
Inoltre aggiungiamo un parametro 'mosse' che permette di specificare il tipo di connessione: 4 per quattro movimenti e 8 per otto movimenti.

Funzione che verifica se una matrice è connessa:

(define (isconnected matrice mosse)
  (local (out rows cols visited matrix moves)
    (setq out true)
    (setq matrix matrice)
    (if (or (= mosse 4) (= mosse nil))
        ; Mosse possibili(4): alto, basso, sinistra, destra
        (setq moves '((-1 0) (1 0) (0 -1) (0 1)))
        ;else
        ; Mosse possibili(8): alto, basso, sinistra, destra,
        ; basso-sinistra, basso-destra, alto-sinistra, alto-destra
        (setq moves '((-1 0) (1 0) (0 -1) (0 1) (1 1) (-1 1) (-1 -1) (1 -1)))
    )
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (setq visited (array rows cols '(nil)))
    ; Cerca il primo '1' nella matrice sui cui avviare il DFS
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (if (and (= (matrix r c) 1) (not (visited r c)))
            (dfs r c)
            ; controlla se c'è qualche cella '1' che non è stata visitata
            (for (i 0 (- rows 1) 1 (not out))
              (for (j 0 (- cols 1) 1 (not out))
                (if (and (= (matrix i j) 1) (not (visited i j)))
                    (setq out nil)
                )
              )
            )
        )
      )
    )
    out))

Facciamo alcune prove:

(setq m '((1 1 0 0)
          (1 0 0 1)
          (0 0 1 1)
          (1 1 1 1)))
(isconnected m)
;-> nil

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 1 1 1)
          (1 1 1 1)))
(isconnected m)
;-> true

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 0 1 1)
          (1 1 1 1)))
(isconnected m)
;-> nil
Con 8 direzioni possibili la matrice è connessa:
(isconnected m 8)
;-> true

(setq m '((1 1 1 1)
          (1 0 0 1)
          (1 0 0 1)
          (1 1 1 1)))
(isconnected m)
;-> true

(setq m '((1 0 0 1)
          (0 1 1 0)
          (0 1 1 0)
          (1 0 0 1)))
(isconnected m)
;-> true
(isconnected m 8)
;-> true


-------------
Hitori Puzzle
-------------

Hitori si gioca con una griglia di quadrati o celle, dove ciascuna cella inizialmente contiene un numero.
Il gioco si gioca eliminando i quadrati/numeri e questo viene fatto oscurandoli (casella nera).
L'obiettivo è trasformare la griglia in uno stato in cui tutte e tre le seguenti regole siano vere:
1) nessuna riga o colonna può avere più di una occorrenza di un dato numero
2) le celle nere non possono essere adiacenti orizzontalmente o verticalmente, sebbene possano essere diagonali tra loro.
3) le restanti celle numerate devono essere tutte collegate tra loro, orizzontalmente o verticalmente (cioè devono essere connesse).

Tecniche di risoluzione
Una volta stabilito che una cella non può essere nera, alcuni giocatori trovano utile cerchiare il numero, poiché rende più facile la lettura del puzzle man mano che la soluzione procede. Di seguito assumiamo che questa convenzione venga seguita.

- Quando viene stabilito che una cella deve essere nera, tutte le celle ortogonalmente adiacenti non possono essere nere e quindi possono essere cerchiate.

- Se una cella è stata cerchiata per indicare che non può essere nera, tutte le celle contenenti lo stesso numero in quella riga e colonna devono essere nere.

- Se oscurando una cella si causa la separazione di un'area connessa non nera in diversi componenti non collegati, la cella non può essere nera e quindi può essere cerchiata.

- In una sequenza di tre numeri identici e adiacenti, il numero centrale non può essere nero e le celle su entrambi i lati devono essere nere. Il motivo è che se uno dei numeri finali rimane non nero, ciò risulterà in due celle nere adiacenti o in due celle con lo stesso numero nella stessa riga o colonna, nessuna delle quali è consentita. (Questo è un caso speciale dell'elemento successivo.)

- In caso di due numeri identici e adiacenti, se nella stessa riga o colonna è presente un'altra cella contenente lo stesso numero, quest'ultima cella deve essere nera. Altrimenti, se rimane non nero, ciò risulterebbe in due celle con lo stesso numero nella stessa riga o colonna, oppure in due celle nere adiacenti, nessuna delle quali è consentita.

- Qualsiasi numero che abbia due numeri identici su lati opposti non può essere nero, perché uno dei due numeri identici deve essere nero e non può essere adiacente a un'altra cella nera.

- Quando due coppie di numeri identici si trovano in un quadrato a due a due sulla griglia, due di essi devono essere neri lungo una diagonale. Ci sono solo due combinazioni possibili, e talvolta è possibile decidere quale sia quella corretta determinando se una variazione taglierà i quadrati non neri dal resto della griglia.

- Quando due coppie di numeri identici formano un quadrato nell'angolo di una griglia, il quadrato d'angolo e quello diagonalmente opposto devono essere neri. L'alternativa lascerebbe la casella d'angolo isolata dagli altri numeri non neri.

Nota: Hitori è NP-completo.
Il nome "NP-completo" è l'abbreviazione di "nondeterministic polynomial-time complete".
Nella teoria della complessità computazionale, un problema è NP-completo quando:
1) È un problema decisionale, nel senso che per qualsiasi input al problema, l'output è "sì" o "no".
2) Quando la risposta è "sì", ciò può essere dimostrato attraverso l'esistenza di una soluzione breve (di lunghezza polinomiale).
3) La correttezza di ciascuna soluzione può essere verificata rapidamente (cioè in tempo polinomiale) e un algoritmo di ricerca a forza bruta può trovare una soluzione provando tutte le soluzioni possibili.
4) Il problema può essere utilizzato per simulare ogni altro problema per il quale possiamo verificare rapidamente che una soluzione sia corretta.
In questo senso, i problemi NP-completi sono i problemi più difficili le cui soluzioni possono essere verificate rapidamente.
Se potessimo trovare rapidamente le soluzioni di qualche problema NP-completo, potremmo trovare rapidamente le soluzioni di ogni altro problema per il quale una data soluzione può essere facilmente verificata.

Funzioni del gioco implementate:

(newgame)   -> inizia un nuovo puzzle
(black r c) -> attiva/disattiva la casella nera (r = riga, c = colonna)
(mark r c)  -> attiva/disattiva la sottolineatura (marcatura)
(automark)  -> sottolinea le caselle adiacenti alle caselle nere
(solved?)   -> verifica se il gioco è risolto
(restart)   -> reinizializza il puzzle corrente
(puzzle)    -> stampa il puzzle corrente

(define (print-grid grid)
  (local (row col)
    (setq row (length grid))
    (setq col (length (first grid)))
    ; indici della griglia in verde
    (println "  \027[0;32m"
             (join (map (fn(x) (format "%2d" x)) (sequence 0 (- col 1))))
             "\027[0m")
    (for (i 0 (- row 1))
      ;(setq fmt (string "%2d "))
      ; indici della griglia in verde
      (print "\027[0;32m" (format "%2d " i) "\027[0m")
      (for (j 0 (- col 1))
        (cond ((= (grid i j) -1) (print "\027[0;31m* \027[0m")) ; casella nera (rossa)
              (true
                (if (= (marked i j) 0)
                    ; numero normale
                    (print (grid i j) " ")
                    ; numero sottolineato
                    (print "\027[4m"(grid i j) "\027[0m ")))
        )
      )
      (println)))
      '---------------------)

Funzione che stampa il puzzle:

(define (puzzle (print-grid grid)))

Funzione che verifica se due indici indicano una casella valida:

(define (valid? r c) (and (>= r 0) (< r N) (>= c 0) (< c N)))

Funzione che attiva/disattiva una casella nera:

(define (black r c)
  (cond ((and (valid? r c) (= (grid r c) -1))
          (setf (grid r c) (base r c)))
        ((and (valid? r c) (!= (grid r c) -1))
          (setf (grid r c) -1))
        (true (println "Mossa impossibile: " r {, } c)))
  (print-grid grid))

Funzione che attiva/disattiva la sottolineatura di una casella:

(define (mark r c)
  (if (and (valid? r c) (!= (grid r c) -1))
      (setf (marked r c) (- 1 (marked r c)))
      ;else
      (println "Impossibile sottolineare: " r {, } c))
  (print-grid grid))

Funzione che sottolinea tutte le caselle che sono adiacenti alle caselle nere:

(define (automark)
  ; toglie tutte le sottolineature
  (setq marked (array N N '(0)))
  ; ciclo per ogni casella
  (for (r 0 (- N 1))
    (for (c 0 (- N 1))
      ; se incontra una casella nera...
      (cond ((= (grid r c) -1)
              ; allora sottolinea le caselle (valide) adiacenti.
              (if (valid? (+ r 1) c) (setf (marked (+ r 1) c) 1))
              (if (valid? (- r 1) c) (setf (marked (- r 1) c) 1))
              (if (valid? r (+ c 1)) (setf (marked r (+ c 1)) 1))
              (if (valid? r (- c 1)) (setf (marked r (- c 1)) 1))))))
  (print-grid grid))

Funzione che reinizializza il puzzle corrente:

(define (restart)
  (setq grid base)
  (setq marked (array N N '(0)))
  (print-grid grid))

Funzione che genera un nuovo puzzle:

(define (newgame hitori)
  (cond ((integer? hitori)
         (setq N hitori)
         ; genera una griglia casuale (può non essere risolvibile)
         (setq grid (array N N (slice (randomize (flat (dup (sequence 1 9) N))) 0 (* N N)))))
        (true
          (setq N (length hitori))
          (setq grid (array N N (flat hitori))))
  )
  ; matrice per reinizializzare il gioco e annullare le operazioni
  (setq base grid)
  (setq marked (array N N '(0)))
  (print-grid grid))

Funzioni per verificare se una matrice è connessa.

(define (isvalid row col)
  (and (>= row 0) (< row rows) (>= col 0) (< col cols)
       (= (matrix row col) 1)
       (not (visited row col))))

Funzione che effettua la ricerca DFS:

(define (dfs row col)
  (local (newrow newcol)
    (setf (visited row col) true)
    (dolist (m moves)
      (setq newrow (+ row (m 0)))
      (setq newcol (+ col (m 1)))
      (if (isvalid newrow newcol)
          (dfs newrow newcol)))))

Funzione che verifica se una matrice è connessa:

(define (isconnected matrice mosse)
  (local (out rows cols visited matrix moves)
    (setq out true)
    (setq matrix matrice)
    (if (or (= mosse 4) (= mosse nil))
        ; Mosse possibili(4): alto, basso, sinistra, destra
        (setq moves '((-1 0) (1 0) (0 -1) (0 1)))
        ;else
        ; Mosse possibili(8): alto, basso, sinistra, destra,
        ; basso-sinistra, basso-destra, alto-sinistra, alto-destra
        (setq moves '((-1 0) (1 0) (0 -1) (0 1) (1 1) (-1 1) (-1 -1) (1 -1)))
    )
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (setq visited (array rows cols '(nil)))
    ; Cerca il primo '1' nella matrice sui cui avviare il DFS
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (if (and (= (matrix r c) 1) (not (visited r c)))
            (dfs r c)
            ; controlla se c'è qualche cella '1' che non è stata visitata
            (for (i 0 (- rows 1) 1 (not out))
              (for (j 0 (- cols 1) 1 (not out))
                (if (and (= (matrix i j) 1) (not (visited i j)))
                    (setq out nil)))))))
    out))

Proviamo:

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 0 1 1)
          (1 1 1 1)))
(isconnected m)
;-> nil
(isconnected m 8)
;-> true

(setq m '((1 1 0 0)
          (1 1 0 1)
          (0 1 1 1)
          (1 1 1 1)))
(isconnected m)
;-> true

Funzione che verifica se un puzzle è risolto:

(define (solved?)
  (let ( (ok true) (nere 0) )
    ; controllo per le caselle nere adiacenti
    (for (r 0 (- N 1))
      (for (c 0 (- N 1))
        ; se incontriamo una casella nera...
        (cond ((= (grid r c) -1)
                (++ nere)
                ; controlliamo che non ci sia una casella nera adiacente
                ; in basso, alto, destra, sinistra
                (if (and (valid? (+ r 1) c) (= (grid (+ r 1) c) -1)) (begin
                    (println "Errore: " r "," c " e " (+ r 1) "," c " caselle nere adiacenti")
                    (setq ok nil)))
                (if (and (valid? (- r 1) c) (= (grid (- r 1) c) -1)) (begin
                    (println "Errore: " r "," c " e " (- r 1) "," c " caselle nere adiacenti")
                    (setq ok nil)))
                (if (and (valid? r (+ c 1)) (= (grid r (+ c 1)) -1)) (begin
                    (println "Errore: " r "," c " e " r "," (+ c 1) " caselle nere adiacenti")
                    (setq ok nil)))
                (if (and (valid? r (- c 1)) (= (grid r (- c 1)) -1)) (begin
                    (println "Errore: " r "," c " e " r "," (- c 1) " caselle nere adiacenti")
                    (setq ok nil))))
        )
      )
    )
    ; controllo se tutti i numeri sono diversi per ogni riga
    (for (r 0 (- N 1))
      ;(setq nums (filter integer? (array-list (grid r))))
      (setq nums (replace -1 nums))
      (if (!= nums (unique nums)) (begin
          (println "Errore: riga " r " = "  (grid r) ", numeri duplicati")
          (setq ok nil)))
    )
    ; controllo se tutti i numeri sono diversi per ogni colonna
    ; (controllo le righe della matrice trasposta)
    (setq tr (transpose grid))
    (for (r 0 (- N 1))
      ;(setq nums (filter integer? (array-list (tr r))))
      (setq nums (replace -1 nums))
      (if (!= nums (unique nums)) (begin
          (println "Errore: colonna " r " = " (tr r) ", numeri duplicati")
          (setq ok nil)))
    )
    ; controllo se i numeri sono tutti connessi
    ; trasforma la matrice grid in una matrice di 0 e 1 'bin'
    ; 0 per grid(x y) = -1 (casella nera)
    ; 1 per tutti gli altri valori
    (setq bin (array N N '(0)))
    (for (r 0 (- N 1))
      (for (c 0 (- N 1))
        (if (= (grid r c) -1)
            (setf (bin r c) 0)
            (setf (bin r c) 1))))
    ; verifica se la matrice è connessa
    (setq out (isconnected bin))
    ; risultato
    (list ok nere)))

Facciamo alcune prove:

(newgame 4)
;->    0 1 2 3
;->  0 8 1 4 8
;->  1 3 6 7 9
;->  2 7 2 6 7
;->  3 6 3 2 2
---------------------
(black 0 3)
;->    0 1 2 3
;->  0 8 1 4 *
;->  1 3 6 7 9
;->  2 7 2 6 7
;->  3 6 2 2 2
;-> ---------------------

(black 2 0)
;->    0 1 2 3
;->  0 8 1 4 *
;->  1 3 6 7 9
;->  2 * 2 6 7
;->  3 6 3 2 2
;-> ---------------------

(black 3 3)
;->    0 1 2 3
;->  0 8 1 4 *
;->  1 3 6 7 9
;->  2 * 2 6 7
;->  3 6 3 2 *

(automark) ; i numeri sottolineati non si vedono qui
;->    0 1 2 3
;->  0 8 1 4 *
;->  1 3 6 7 9
;->  2 * 2 6 7
;->  3 6 3 2 *
(solved?)
;-> (true 3)

(newgame '((9 5 7 3)
           (5 5 7 9)
           (2 1 4 9)
           (8 2 3 1)))
(black 0 2)
;->    0 1 2 3
;->  0 9 5 * 3
;->  1 5 5 7 9
;->  2 2 1 4 9
;->  3 8 2 3 1
;-> ---------------------
(black 1 1)
;->    0 1 2 3
;->  0 9 5 * 3
;->  1 5 * 7 9
;->  2 2 1 4 9
;->  3 8 2 3 1
;-> ---------------------
(black 2 3)
;->    0 1 2 3
;->  0 9 5 * 3
;->  1 5 * 7 9
;->  2 2 1 4 *
;->  3 8 2 3 1
(automark)
(solved?)
;-> (true 3)

Per finire vediamo alcuni puzzle con soluzione:

  5 5 2 2 5   * 5 * 2 *
  3 1 2 5 6   3 1 2 5 6
  3 3 3 1 6   * 3 * 1 *
  5 2 6 3 4   5 2 6 3 4
  2 2 4 2 1   2 * 4 * 1

  1 1 3 3 1   * 1 * 3 *
  3 4 2 5 1   3 4 2 5 1
  1 1 3 4 3   1 * 3 4 *
  3 5 5 1 3   * 5 * 1 3
  5 3 1 2 2   5 3 1 2 *

  5 6 5 1 2 4   * 6 5 * 2 4
  2 4 6 1 5 5   2 4 6 1 * 5
  4 5 4 6 5 2   4 * 4 6 5 2
  6 2 4 5 3 1   6 2 * 5 3 1
  4 3 1 2 1 6   * 3 1 2 * 6
  3 1 4 4 6 5   3 1 * 4 6 *


---------------------------------------------
Distanze tra coppie di numeri primi adiacenti
---------------------------------------------

Consideriamo tutti i numeri primi fino a N.
Quante coppie di primi adiacenti hanno distanza k?

Per esempio con N = 30 abbiamo:

Numeri primi = 2 3 5 7 11 13 17 19 23 29 31
Distanza tra i numeri primi adiacenti = 1 2 2 4 2 4 2 4 6 2
Con il seguente risultato,
    1 coppia con distanza 1
    5 coppie con distanza 2
    3 coppie con distanza 4
    1 coppia con distanza 6

Nota: non esistono coppie adiacenti con distanza dispari (a parte la prima 2 e 3 che ha distanza 1).
Infatti se aggiungiamo un numero dispari ad un numero primo (a parte il 2) otteniamo un numero pari, che non è primo.

(setq d (map - (rest pri) (chop pri)))

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

(define (coppie N)
  (local (out primi dist d num-coppie)
    (setq out '((1 1)))
    (setq primi (primes-to N))
    (setq dist (map - (rest primi) (chop primi)))
    (setq d 2)
    (while (> (setq num-coppie (first (count (list d) dist))) 0)
      (push (list num-coppie d) out -1)
      (++ d 2)
    )
    out))

Facciamo alcune prove:

(coppie 1e3)
;-> (1 1) (35 2) (40 4) (44 6) (15 8) (16 10) (7 12) (7 14))

(time (println (coppie 1e6)))
;-> ((1 1) (8169 2) (8143 4) (13549 6) (5569 8) (7079 10) (8005 12) (4233 14)
;->  (2881 16) (4909 18) (2401 20) (2172 22) (2682 24) (1175 26) (1234 28)
;->  (1914 30) (550 32) (557 34) (767 36) (330 38) (424 40) (476 42) (202 44)
;->  (155 46) (196 48) (106 50) (77 52) (140 54) (53 56) (54 58) (96 60) (16 62)
;->  (24 64) (48 66) (13 68) (22 70) (13 72) (12 74) (6 76) (13 78) (3 80) (5 82)
;->  (6 84) (4 86) (1 88) (4 90) (1 92))
;-> 836.302

(time (println (coppie 1e7)))
;-> ((1 1) (58980 2) (58621 4) (99987 6) (42352 8) (54431 10) (65513 12)
;->  (35394 14) (25099 16) (43851 18) (22084 20) (19451 22) (27170 24)
;->  (12249 26) (13255 28) (21741 30) (6364 32) (6721 34) (10194 36)
;->  (4498 38) (5318 40) (7180 42) (2779 44) (2326 46) (3784 48) (2048 50)
;->  (1449 52) (2403 54) (1072 56) (1052 58) (1834 60) (543 62) (559 64)
;->  (973 66) (358 68) (524 70) (468 72) (218 74) (194 76) (362 78) (165 80)
;->  (100 82) (247 84) (66 86) (71 88) (141 90) (37 92) (39 94) (65 96)
;->  (29 98) (36 100) (34 102) (21 104) (12 106) (26 108) (11 110) (11 112)
;->  (11 114) (7 116) (4 118) (10 120) (3 122) (4 124) (8 126) (2 128)
;->  (1 130) (5 132) (1 134) (2 136) (2 138) (2 140))
;-> 23487.007

Nota:
Il divario tra due numeri primi consecutivi non è prevedibile con assoluta certezza, ma il teorema dei numeri primi fornisce alcune informazioni sul comportamento medio.
Il teorema dei numeri primi afferma che il divario medio tra numeri primi consecutivi vicini a N è approssimativamente ln(N) (ln = logaritmo naturale).
Ciò significa che man mano che N diventa sempre più grande, la distanza media tra numeri primi consecutivi cresce logaritmicamente (anche se possono esserci ampie fluttuazioni negli spazi effettivi tra i numeri primi).
Mentre la distanza media tra numeri primi consecutivi cresce logaritmicamente con N, non è noto alcun limite superiore alla distanza tra numeri primi consecutivi.
Cioè, non sappiamo se esiste una dimensione massima del gap che può essere osservata infinitamente spesso al crescere di N. Questa rimane una questione aperta nella teoria dei numeri.

Vedi anche "Distanza tra coppia di primi" su "Note libere 17".
Vedi anche "Distanza massima tra coppie di primi adiacenti" su "Note libere 26".


------------------------------
Forza 4 (Connect4) Interattivo
------------------------------

Forza 4 è un gioco da tavolo di allineamento prodotto dalla Milton Bradley nel 1974.

Viene giocato su una matrice di sei righe e sette colonne e richiama i giochi del Tris e Gomoku.
In questo caso l'obiettivo è mettere in fila (orizzontale, verticale o diagonale) quattro pedine proprie.
Ma l'elemento fondamentale del gioco, che lo rende del tutto originale, è la forza di gravità: la scacchiera è posta in verticale fra i giocatori, e le pedine vengono fatte cadere lungo una griglia verticale, in modo tale che una pedina inserita in una certa colonna vada sempre a occupare la posizione libera situata più in basso nella colonna stessa.

Forza 4 è un gioco "risolto", nel senso che il giocatore che comincia la partita ed esegue tutte le mosse "giuste" finirà inevitabilmente per vincere l'incontro.

Funzione per iniziare un nuovo gioco:

(define (newgame)
  (setq rows 6)
  (setq cols 7)
  (setq empty ".")
  (setq grid (array-list (array rows cols (list empty))))
  (print-table grid))

Funzione per stampare la griglia di gioco:

(define (print-table grid)
  (local (row col space)
    (setq row (length grid))
    (setq col (length (first grid)))
    (setq space "  ")
    (println space "  1   2   3   4   5   6   7")
    (println space "|   |   |   |   |   |   |   |")
    (for (i 0 (- row 1))
      (print space "|")
      (for (j 0 (- col 1))
        (print " " (grid i j) " |")
      )
      (println)))
      '---------------------------------)

(newgame)
;->     1   2   3   4   5   6   7
;->   |   |   |   |   |   |   |   |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;-> ---------------------------------

Funzione per la mossa del giocatore 0:

(define (p0 colonna)
  (setq c (- colonna 1))
  (setq found nil)
  (cond ((and (>= c 0) (<= c 6))
          (for (r 5 0 1 found)
            (if (= (grid r c) empty)
              (begin
                (setf (grid r c) 0)
                (setq found true)))))
  )
  (if (not found) (println "Mossa impossibile"))
  (endgame? grid)
  (print-table grid))

Funzione per la mossa del giocatore 1:

(define (p1 colonna)
  (setq c (- colonna 1))
  (setq found nil)
  (cond ((and (>= c 0) (<= c 6))
          (for (r 5 0 1 found)
            (if (= (grid r c) empty)
              (begin
                (setf (grid r c) 1)
                (setq found true)))))
  )
  (if (not found) (println "Mossa impossibile"))
  (endgame? grid)
  (print-table grid))

Funzioni ausiliarie per verificare se una partita è terminata:
(vedi "Gomoku" su "Note libere 19")

(define (diag1 matrix)
  (local (out row cols)
    (setq out '())
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    ; prima metà
    (for (i 0 (- cols 1))
      (setq tmp '())
      (for (j i 0)
        (if (< (- i j) rows) (push (matrix (- i j) j) tmp -1))
      )
      (push tmp out -1)
    )
    ;(println out)
    ; seconda metà
    (for (i 1 (- rows 1))
      (setq tmp '())
      (setq k i)
      (for (j (- cols 1) 0)
        (if (< k rows) (begin (push (matrix k j) tmp -1) (++ k)))
      )
      (push tmp out -1)
    )
    out))

(define (swap-cols matrix)
  (local (rows cols)
    (setq rows (length matrix))
    (setq cols (length (matrix 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- (/ cols 2) 1))
        (swap (matrix r c) (matrix r (- cols c 1)))
      )
    )
  matrix))

(define (diag2 matrix) (diag1 (swap-cols matrix)))

Funzione per verificare (se una partita è trerminata:

(define (endgame? grid)
  (local (winner str)
    (setq winner "")
    ; Ricerca orizzontale
    (setq str (join (map join (map (fn(x) (map string x)) grid)) empty))
    (cond ((find "1111" str) (setq winner "1"))
          ((find "0000" str) (setq winner "0")))
    ; Ricerca verticale
    ; per unire le colonne trasponiamo la matrice e poi uniamo le righe
    (setq str (join (map join (map (fn(x) (map string x)) (transpose grid))) empty))
    (cond ((find "1111" str) (setq winner "1"))
          ((find "0000" str) (setq winner "0")))
    ; Ricerca diagonale'/'
    (setq str (join (map join (map (fn(x) (map string x)) (diag1 grid))) empty))
    (cond ((find "1111" str) (setq winner "1"))
          ((find "0000" str) (setq winner "0")))
    ; Ricerca diagonale'\'
    (setq str (join (map join (map (fn(x) (map string x)) (diag2 grid))) empty))
    (cond ((find "1111" str) (setq winner "1"))
          ((find "0000" str) (setq winner "0")))
    (if (!= winner "") (println "Vince il giocatore: " winner))))

Facciamo una partita:

(newgame)
;->   |   |   |   |   |   |   |   |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;-> ---------------------------------
(p0 4)
(p1 3)
(p0 4)
(p1 4)
(p0 5)
(p1 2)
(p0 5)
(p1 5)
(p0 6)
(p1 7)
(p0 3)
;->     1   2   3   4   5   6   7
;->   |   |   |   |   |   |   |   |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | 1 | 1 | . | . |
;->   | . | . | 0 | 0 | 0 | . | . |
;->   | . | 1 | 1 | 0 | 0 | 0 | 1 |
;-> ---------------------------------
(p1 2)
(p0 6)
;-> Vince il giocatore: 0
;->     1   2   3   4   5   6   7
;->   |   |   |   |   |   |   |   |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | . | . | . | . |
;->   | . | . | . | 1 | 1 | . | . |
;->   | . | 1 | 0 | 0 | 0 | 0 | . |
;->   | . | 1 | 1 | 0 | 0 | 0 | 1 |
;-> ---------------------------------

Vedi anche "Forza 4 - Connect Four" su "Note libere 12")


------------------
Intervallo di date
------------------

Abbiamo due date data1 e data2 nel formato (anno mese giorno).
Scrivere una funzione che genera tutte le date tra data1 e data2 (comprese).

Algoritmo
Partiamo dal 1 gennaio dell'anno della data1 e generiamo tutti i giorni successivi fino alla data2.
Le eventuali date minori di data1 vengono scartate.
Per esempio, se partiamo dalla data (1900 12 30) fino alla data (1901 1 10) generiamo date non comprese nell'intervallo dalla data (1900 1 1) alla data (1900 12 29). Queste date vengono scartate.

Per confrontare le date le trasformiamo in numeri interi.
Per esempio, 1901 2 6 --> 1901 02 06 --> 19010206.

Funzione che verifica se un anno è bisestile:

(define (isleap? year)
  (or (zero? (% year 400))
      (and (zero? (% year 4)) (not (zero? (% year 100))))))

Funzione che genera tutte le date tra date1 e date2:

(define (daylist date1 date2)
"Generates a list of dates (YYYY MM DD) from date1 date2"
  (local (y1 m1 d1 y2 m2 d2 out md n1 n2 days fdate num-date stop)
    ; unpack date
    (map set '(y1 m1 d1) date1)
    (map set '(y2 m2 d2) date2)
    (setq out '())
    ; lista (mese giorni)
    (setq md '((1 31) (2 28) (3 31) (4 30) (5 31) (6 30)
              (7 31) (8 31) (9 30) (10 31) (11 30) (12 31)))
    ; valore numerico date1
    (setq n1 (int (format "%d%02d%02d" y1 m1 d1)))
    ; valore numerico date2
    (setq n2 (int (format "%d%02d%02d" y2 m2 d2)))
    (if (< n2 n1) (setq stop nil))
    ; ciclo anni
    (for (yy y1 y2 1 stop)
      ;ciclo mesi
      (for (mm 1 12 1 stop)
        (setq days (lookup mm md))
        ; mese febbraio e anno palindromo?
        (if (and (= mm 2) (isleap? yy)) (setq days 29))
        ; ciclo giorni
        (for (dd 1 days 1 stop)
          ; data formattata yy-mm-dd
          ;(setq date (format "%d-%d-%d" yy mm dd))
          (setq fdate (list yy mm dd))
          ; valore numerico date corrente
          (setq num-date (int (format "%d%02d%02d" yy mm dd)))
          ;controllo (date1 <= date corrente <= date2)
          (cond ((< num-date n1) nil)
                ((and (>= num-date n1) (<= num-date n2))
                  (push fdate out -1))
                ((> num-date n2 (setq stop true)))
          )
        )
      )
    )
    out))

Facciamo alcune prove:

(daylist '(1900 12 30) '(1901 1 10))
;-> ((1900 12 30) (1900 12 31) (1901 1 1) (1901 1 2) (1901 1 3) (1901 1 4)
;->  (1901 1 5) (1901 1 6) (1901 1 7) (1901 1 8) (1901 1 9) (1901 1 10))

(daylist '(1900 12 1) '(1900 12 10))
;-> ((1900 12 1) (1900 12 2) (1900 12 3) (1900 12 4) (1900 12 5) (1900 12 6)
;-> (1900 12 7) (1900 12 8) (1900 12 9) (1900 12 10))

(daylist '(1980 2 20) '(1980 3 1))
;-> ((1980 2 20) (1980 2 21) (1980 2 22) (1980 2 23) (1980 2 24) (1980 2 25)
;->  (1980 2 26) (1980 2 27) (1980 2 28) (1980 2 29) (1980 3 1))

(daylist '(1980 12 1) '(1901 2 10))
;-> ()

(length (daylist '(1981 1 1) '(1981 12 31)))
;-> 365
(length (daylist '(1980 1 1) '(1980 12 31)))
;-> 366

(length (daylist '(1980 2 22) '(1981 8 10)))
;-> 536

Per curiosità vediamo quali sono le date palindrome e/o prime in un dato intervallo.

(define (pali-prima data1 data2)
  (local (pali prima lst str-data num-data)
    (setq pali '())
    (setq prima '())
    (setq lst (daylist data1 data2))
    (dolist (el lst)
      ; data palindroma?
      (setq str-data (format "%d%d%d" (el 0) (el 1) (el 2)))
      (if (= str-data (reverse (copy str-data))) (push el pali -1))
      ; data prima?
      (setq num-data (int str-data 0 10))
      (if (= 1 (length (factor num-data))) (push el prima -1))
    )
    (println "Date palindrome: " (length pali))
    (println "Date prime: " (length prima))
    (println "Date palindrome e prime: " (length (intersect pali prima)))))

(pali-prima '(1000 1 1) '(2000 1 1))
;-> Date palindrome: 358
;-> Date prime: 27127
;-> Date palindrome e prime: 53

Scriviamo una funzione per contare i giorni tra due date (comprese).

(define (daycount data1 data2)
  (local (y1 m1 d1 y2 m2 d2 out md n1 n2 days num-data stop)
    ; unpack date
    (map set '(y1 m1 d1) data1)
    (map set '(y2 m2 d2) data2)
    (setq out 0)
    ; lista (mese giorni)
    (setq md '((1 31) (2 28) (3 31) (4 30) (5 31) (6 30)
              (7 31) (8 31) (9 30) (10 31) (11 30) (12 31)))
    ; valore numerico data1
    (setq n1 (int (format "%d%02d%02d" y1 m1 d1)))
    ; valore numerico data1
    (setq n2 (int (format "%d%02d%02d" y2 m2 d2)))
    (if (< n2 n1) (setq stop nil))
    ; ciclo anni
    (for (yy y1 y2 1 stop)
      ;ciclo mesi
      (for (mm 1 12 1 stop)
        (setq days (lookup mm md))
        ; mese febbraio e anno palindromo?
        (if (and (= mm 2) (isleap? yy)) (setq days 29))
        ; ciclo giorni
        (for (dd 1 days 1 stop)
          ; valore numerico data corrente
          (setq num-data (int (format "%d%02d%02d" yy mm dd)))
          ;controllo (data1 <= data corrente <= data2)
          (cond ((and (>= num-data n1) (<= num-data n2)) (++ out))
                ((> num-data n2 (setq stop true)))
          )
        )
      )
    )
    out))

Proviamo:

(daycount '(1980 2 22) '(1981 8 10))
;-> 536
(length (daylist '(1980 2 22) '(1981 8 10)))
;-> 536

(daycount '(1980 2 22) '(1980 2 23))
;-> 2
(length (daylist '(1980 2 22) '(1980 2 23)))
;-> 2

(daycount '(1980 2 22) '(1980 2 22))
;-> 1
(length (daylist '(1980 2 22) '(1980 2 22)))
;-> 1

(time (println (daycount '(1000 1 1) '(2000 12 31))))
;-> 365608
;-> 406.188
(time (println (length (daylist '(1000 1 1) '(2000 12 31)))))
;-> 365608
;-> 499.911


-------------------------------------
Giorno successivo e giorno precedente
-------------------------------------

Partendo da una data iniziale (anno mese giorno), scrivere due funzioni che generano:
1) il giorno successivo della data corrente
2) il giorno precedente della data corrente

Per esempio,
data iniziale = (2023 12 26)
giorno successivo = (2023 12 27) ; avanti di 1 giorno
giorno successivo = (2023 12 28) ; avanti di 1 giorno
giorno precedente = (2023 12 27) ; indietro di un giorno
giorno precedente = (2023 12 26) ; indietro di un giorno
giorno precedente = (2023 12 25) ; indietro di un giorno

Utilizziamo una variabile globale 'DAY' per memorizzare la data corrente come una lista (anno mese giorno).

Poi scriviamo le seguenti 4 funzioni:

 start-day --> imposta la data iniziale
 day-now   --> mostra la data corrente
 next-day  --> aumenta di un giorno la data corrente
 prev-day  --> diminuisce di un giorno la data corrente

Funzione per impostare la data iniziale:
(start-day year month day) oppure (start-day '(year month day))

(define (start-day)
  (let (len-args (length (args)))
  (cond ((= len-args 1) (setq DAY (args 0)))
        ((= len-args 3) (setq DAY (list (args 0) (args 1) (args 2))))
        (true nil))))

(start-day '(1901 2 3))
;-> (1901 2 3)
(start-day 1901 2 3)
;-> (1901 2 3)

Funzione che mostra la data corrente:

(define (day-now) DAY)
(day-now)
;-> (1901 2 3)

Funzione che genera il giorno successivo alla data corrente:

(define (next-day)
  (local (day month year days-month)
    (map set '(year month day) DAY)
    ; giorni per ogni mese
    (setq days-month '(0 31 28 31 30 31 30 31 31 30 31 30 31))
    ; anno bisestile?
    (if (or (zero? (% year 400))
            (and (zero? (% year 4)) (not (zero? (% year 100)))))
        (setf (days-month 2) 29))
    ; incrementa il giorno
    (++ day)
    ; Se il giorno supera il numero di giorni del mese,
    ; reimpostare il giorno a 1 e incrementare il mese di 1.
    (if (> day (days-month month))
      (begin
        (setq day 1)
        (++ month)
        ; Se il mese supera Dicembre,
        ; reimpostare il mese a 1 e incrementare l'anno di 1
        (if (> month 12)
          (begin
            (setq month 1)
            (++ year)
          )
        )
      )
    )
    (setf (DAY 0) year)
    (setf (DAY 1) month)
    (setf (DAY 2) day)
    (list year month day)))

(silent (for (i 1 777) (next-day)))
(day-now)
;-> (1903 3 22)

Funzione che genera il giorno precedente alla data corrente:

(define (prev-day)
  (local (day month year days-month)
    (map set '(year month day) DAY)
    ; giorni per ogni mese
    (setq days-month '(0 31 28 31 30 31 30 31 31 30 31 30 31))
    ; anno bisestile?
    (if (or (zero? (% year 400))
            (and (zero? (% year 4)) (not (zero? (% year 100)))))
        (setf (days-month 2) 29))
    ; decrementa il giorno
    (-- day)
    ; Se il giorno diventa 0, diminuire il mese di 1
    (if (= day 0)
      (begin
        (-- month)
        ; se il mese diventa 0,
        ; impostare il mese a 12 (Dicembre) e diminuire l'anno di 1
        (if (= month 0)
          (begin
            (setq month 12)
            (-- year)
          )
        )
        ; impostare il giorno
        (setq day (days-month month))
      )
    )
    (setf (DAY 0) year)
    (setf (DAY 1) month)
    (setf (DAY 2) day)
    (list year month day)))

(silent (for (i 1 777) (prev-day)))
(day-now)
;-> (1901 2 3)


--------------------------
Numeri binari in un numero
--------------------------

Dato un intero positivo n, restituire il valore degli interi positivi le cui rappresentazioni binarie si presentano come sottostringhe nella rappresentazione binaria di n.

Ad esempio, 13 restituisce (13 6 5 3 2 1), perché 13 in binario è 1101 le cui sottostringhe sono 1101, 110, 101, 11, 10, 1 e i relativi valori sono (13 6 5 3 2 1).
I numeri binari che iniziano con zero non vengono considerati (quindi anche lo zero stesso).

Funzione che genera tutte le sottoliste contigue di una lista:

(define (contigue lst)
  (local (out len)
    (setq out '())
    (setq len (length lst))
    (for (i 0 (- len 1))
      (for (j 1 (- len i))
        ;(println i { } j)
        (push (slice lst i j) out -1)
      )
    )
    out))

Funzione che restituire il valore degli interi positivi le cui rappresentazioni binarie si presentano come sottostringhe nella rappresentazione binaria di num:

(define (in-binary num)
  (local (bin str-bin uniq lst out)
  ; rappresentazione binaria
  (setq bin (explode (bits num)))
  ; lista delle sottostringhe binarie (caratteri)
  (setq str-bin (contigue bin))
  ; elementi unici delle sottostringhe
  (setq uniq (unique str-bin))
  ; rimozione dei termini che iniziano con 0
  (setq lst (clean (fn(x) (= (first x) "0")) uniq))
  ; unione dei caratteri e conversione delle sottostringhe in valori interi
  (setq out (map (fn(x) (int x 0 2)) (map join lst)))
  out))

Facciamo alcune prove:

(in-binary 13)
;-> (1 3 6 13 2 5)

(in-binary 1000)
;-> (1 3 7 15 31 62 125 250 500 1000 30 61 122 244 488 14
;->  29 58 116 232 6 13 26 52 104 2 5 10 20 40 4 8)

Sequenza OEIS A122953:
a(n) = number of distinct positive integers represented in binary which are substrings of binary expansion of n

  1, 2, 2, 3, 3, 4, 3, 4, 4, 4, 5, 6, 6, 6, 4, 5, 5, 5, 6, 6, 5, 7, 7, 8,
  8, 8, 8, 9, 9, 8, 5, 6, 6, 6, 7, 6, 7, 8, 8, 8, 8, 6, 8, 10, 9, 10, 9,
  10, 10, 10, 10, 11, 10, 10, 11, 12, 12, 12, 12, 12, 12, 10, 6, 7, 7, 7,
  8, 7, 8, 9, 9, 8, 7, 9, 10, 10, 11, 11, 10, 10, 10, 10, 11, 9, 7, 11,
  11, 13, 13, 12, ...

(map (fn(x) (length (in-binary x))) (sequence 1 100))
;-> (1 2 2 3 3 4 3 4 4 4 5 6 6 6 4 5 5 5 6 6 5 7 7 8 8 8 8 9 9 8 5 6 6
;->  6 7 6 7 8 8 8 8 6 8 10 9 10 9 10 10 10 10 11 10 10 11 12 12 12 12
;->  12 12 10 6 7 7 7 8 7 8 9 9 8 7 9 10 10 11 11 10 10 10 10 11 9 7 11
;->  11 13 13 12 11 14 13 13 11 12 12 12 12 12)

Possiamo scrivere la funzione in modo più compatto:

(define (in-bin num)
  (map (fn(x) (int x 0 2))
        (map join
              (clean (fn(x) (= (first x) "0"))
                    (unique (contigue (explode (bits num))))))))

Proviamo:

(in-bin 13)
;-> (1 3 6 13 2 5)

(in-bin 1000)
;-> (1 3 7 15 31 62 125 250 500 1000 30 61 122 244 488 14
;->  29 58 116 232 6 13 26 52 104 2 5 10 20 40 4 8)

(map (fn(x) (length (in-bin x))) (sequence 1 100))
;-> (1 2 2 3 3 4 3 4 4 4 5 6 6 6 4 5 5 5 6 6 5 7 7 8 8 8 8 9 9 8 5 6 6
;->  6 7 6 7 8 8 8 8 6 8 10 9 10 9 10 10 10 10 11 10 10 11 12 12 12 12
;->  12 12 10 6 7 7 7 8 7 8 9 9 8 7 9 10 10 11 11 10 10 10 10 11 9 7 11
;->  11 13 13 12 11 14 13 13 11 12 12 12 12 12)


---------------------------------------------------------------
Punti con coordinate intere tra due punti con coordinate intere
---------------------------------------------------------------

Dati due punti p1(x1,y1) e p2(x2,y2) con coordinate intere calcolare il numero di punti con coordinate intere che giacciono sulla retta che li congiunge.
Esempi:

1. Se il segmento p1p2 è parallelo all'asse X, allora il numero dei punti vale:
   abs(y1 - y2) - 1

2. Se il segmento p1p2 è parallelo all'asse Y, allora il numero dei punti vale:
   abs(x1 - x2) - 1

3. Altrimenti, il numero dei punti vale:
   GCD(abs(x1 - x2), abs(y1 - y2)) - 1

Per la dimostrazione vedi "Teorema di Pick" su "Problemi vari".

(define (pts x1 y1 x2 y2)
  (cond ((= x1 x2) ; punti paralleli asse X
         (- (abs (- y1 y2)) 1))
        ((= y1 y2) ; punti paralleli asse Y
         (- (abs (- x1 x2)) 1))
        (true
          (- (gcd (abs (- x1 x2)) (abs (- y1 y2))) 1))))

Proviamo:

(pts 1 5 3 7)
;-> 1
(pts 1 1 5 4)
;-> 0
(pts 1 5 5 1)
;-> 3
(pts 1 9 8 16)
;-> 6

Se invece vogliamo sapere le coordinate dei punti interi possiamo usare la seguente funzione:

(define (pts-int x1 y1 x2 y2)
  (local (out dx dy step-x step-y x y continue)
    (setq out '())
    ; Calcola la variazione di x e y
    (setq dx (- x2 x1))
    (setq dy (- y2 y1))
    ; Determina la direzione dei passi
    (if (> dx 0) (setq step-x 1) (setq step-x -1))
    (if (> dy 0) (setq step-y 1) (setq step-y -1))
    ; Gestione delle linee più verticali o orizzontali
    (if (> (abs dy) (abs dx)) (setq step-x (div dx (abs dy))))
    (if (> (abs dx) (abs dy)) (setq step-y (div dy (abs dx))))
    ; Punto di partenza
    (setq x x1)
    (setq y y1)
    ;(println step-x { } step-y)
    (setq continue true)
    (while continue
      ; Aggiunge il punto corrente se è intero e se è nei limiti del segmento
      ;(print x { } y) (read-line)
      (if (and (= x (int x)) (= y (int y))
               (>= x (min x1 x2)) (<= x (max x1 x2))
               (>= y (min y1 y2)) (<= y (max y1 y2)))
          (push (list x y) out -1))
      ; Muove al prossimo punto
      (setq x (add x step-x))
      (setq y (add y step-y))
      ; Stop se abbiamo raggiunto o passato P2
      (if (or (and (> step-x 0) (> x x2))
              (and (< step-x 0) (< x x2))
              (and (> step-y 0) (> y y2))
              (and (< step-y 0) (< y y2)))
          (setq continue nil))
    )
    ; Inserimento ultimo punto (se non presente)
    ; (dovuto ad eventuali errori dei numeri floating-point)
    (if (!= (out -1) (list x2 y2)) (push (list x2 y2) out -1))
    out))

Proviamo:

(pts-int 1 5 3 7)
;-> ((1 5) (2 6) (3 7))
(pts-int 1 1 5 4)
;-> ((1 1) (5 4))
(pts-int 1 1 10 8)
;-> ((1 1) (10 8))
(pts-int 1 5 5 1)
;-> ((1 5) (2 4) (3 3) (4 2) (5 1))
(pts-int 1 9 8 16)
;-> ((1 9) (2 10) (3 11) (4 12) (5 13) (6 14) (7 15) (8 16))


---------------------------
Rango di una stringa (Rank)
---------------------------

Il rango di una stringa (Rank) è definito come la posizione della stringa quando tutte le possibili permutazioni delle sue lettere sono disposte in ordine alfabetico a..z (non importa se le stringhe/parole hanno significato o meno).

Scrivere una funzione che calcola il rango di una stringa costituita solo da lettere alfabetiche minuscole.

Esempio e Algoritmo:

stringa = casa
(setq str "casa")

Calcolare gli anagrammi di "casa"
(anagrams "casa")
;-> ("asac" "asca" "aacs" "aasc" "acsa" "acas" "saca" "saac" "scaa" "scaa"
;->  "saac" "saca" "acas" "acsa" "aasc" "aacs" "asca" "asac" "casa" "caas"
;->  "csaa" "csaa" "caas" "casa")

Ordinare gli anagrammi in ordine crescente
(sort (anagrams "casa"))
;-> ("aacs" "aacs" "aasc" "aasc" "acas" "acas" "acsa" "acsa" "asac" "asac"
;->  "asca" "asca" "caas" "caas" "casa" "casa" "csaa" "csaa" "saac" "saac"
;->  "saca" "saca" "scaa" "scaa")

Eliminare i duplicati dagli anagrammi ordinati (gli anagrammi duplicati sono causati dai caratteri duplicati che si trovano nella stringa)
(unique (sort (anagrams "casa")))
;-> ("aacs" "aasc" "acas" "acsa" "asac" "asca" "caas" "casa" "csaa" "saac"
;->  "saca" "scaa")

Calcolare la posizione (indice) della stringa neglia anagrammi unici ordinati (indexing 1-based):
(+ (find "casa" (sort (unique (anagrams "casa")) < )) 1)
;-> 8

Funzione per generare gli anagrammi:

(define (anagrams str)
"Calculates all the anagrams of a string"
  (map (fn (perm) (select str perm))
       (permute-aux (sequence 0 (- (length str) 1)))))
; auxiliary permutation function
(define (permute-aux lst)
  (if (= (length lst) 1)
   lst
   (apply append (map (fn (rot)
                      (map (fn (perm) (cons (first rot) perm))
                           (permute-aux (rest rot))))
                      (rotate-aux lst)))))
; auxiliary rotation function
(define (rotate-aux lst)
  (map (fn (x) (rotate lst)) (sequence 1 (length lst))))

Funzione che calcola il rango di una stringa:

(define (rank str)
  (+ (find str (sort (unique (anagrams str)) < )) 1))

Facciamo alcune prove:

(rank "casa")
;-> 8

(rank "abcd")
;-> 1

(rank "bada")
;-> 8

(rank "pietra")
;-> 420

(rank "newlisp")
;-> 2264

Nota: con parole più lunghe di 10 caratteri ci vuole troppo tempo per calcolare gli anagrammi (permutazioni)

Stringa con 9 caratteri:
(time (println (rank "nagarjuna")))
;-> 17604
;-> 2500.013

Stringa con 10 caratteri:
(time (println (rank "jihgfedcba")))
;-> 3628800
;-> 42138.639


-----------------
Teorema di Rosser
-----------------

Il teorema dei numeri primi mostra che l'n-esimo numero primo p(n) ha il valore asintotico:

  p(n) ≈ n*ln(n) come n->infinito

Il teorema di Rosser (1938) rende questo limite inferiore rigoroso affermando che:

  p(n) > n*ln(n) per n >= 1

Questo risultato è stato successivamente migliorato (Dusart 1999) in:

  p(n) > n*(ln(n) + ln(ln(n)) - 1)

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

Funzione che verifica il teorema di Rosser di tutti i primi fino ad un determinato numero:

(define (rosser-to limit show)
  (local (primi n)
    (setq primi (primes-to limit))
    (dolist (p primi)
      (setq n (+ $idx 1))
      (if show (println n { } p { } (mul n (log n))))
      (if (<= p (mul n (log n)))
          (println "### "n { } p { } (mul n (log n)))))))

Proviamo:

(rosser-to 50 true)
;-> 1 2 0
;-> 2 3 1.386294361119891
;-> 3 5 3.295836866004329
;-> 4 7 5.545177444479562
;-> 5 11 8.047189562170502
;-> 6 13 10.75055681536833
;-> 7 17 13.62137104338719
;-> 8 19 16.63553233343869
;-> 9 23 19.77502119602598
;-> 10 29 23.02585092994046
;-> 11 31 26.37684800078208
;-> 12 37 29.81887979745601
;-> 13 41 33.34434164699998
;-> 14 43 36.94680261461362
;-> 15 47 40.62075301653315
;-> nil

(rosser-to 1e5)
;-> nil
(rosser-to 1e7)
;-> nil


---------------------------------
Somma massima tra elementi uguali
---------------------------------

Data una lista di numeri interi, determinare la somma massima degli elementi contenuti tra coppie di elementi uguali.

Per esempio, data la lista (1 2 -5 3 5 3 1) ci sono due coppie di elementi uguali 1,1 e 3,3.
Tra 1,1 ci sono gli elementi 1 2 -5 3 5 3 1, la cui somma vale 10.
Tra 3,3 ci sono gli elementi 3 5 3, la cui somma vale 11.
Quindi la somma massima vale 11 data dalla sottolista (3 5 3).

Algoritmo
Per ogni elemento della lista, cerchiamo il primo elemento uguale e, se lo troviamo, calcoliamo la somma della sottolista ed eventualmente aggiorniamo la somma massima.

(define (max-sum lst)
  (local (MIN-INT sum-max sum-lst len arr found)
    (setq MIN-INT -9223372036854775808)
    ; lunghezza della lista
    (setq len (length lst))
    (cond ((< len 2) '(nil ()))
          (true
            ; somma massima
            (setq sum-max MIN-INT)
            ; sottolista con somma massima
            (setq sum-lst '())
            ; vettore per velocizzare i cicli
            (setq arr (array len lst))
            ; ciclo per ogni numero
            (for (i 0 (- len 2))
              (setq found nil)
              ; ciclo per cercare un numero uguale al numero corrente (lst i)
              (for (j (+ i 1) (- len 1) 1 found)
                ; se trova numero uguale...
                (if (= (arr i) (arr j))
                  (begin
                    (setq found true)
                    ; calcola la somma corrente e la sottolista corrente
                    (setq cur-lst (slice arr i (+ (- j i) 1)))
                    (setq cur-sum (apply + cur-lst))
                    ;(println i { } j { - } (lst i) { } (lst j))
                    ;(println cur-lst { } cur-sum)
                    ; controlla somma corrente con somma massima
                    ; e aggiorna i valori di conseguenza
                    (if (> cur-sum sum-max)
                        (set 'sum-max cur-sum 'sum-lst cur-lst)))
                )
              )
            )
            (if (= sum-max MIN-INT)
                '(nil ())
                ;else
                (list sum-max sum-lst))))))

Facciamo alcune prove:

(setq a '(1 2 -5 3 5 3 1))
(max-sum a)
;-> (11 (3 5 3))

(max-sum '())
;-> (nil ())

(max-sum '(1 2 3))
;-> (nil ())

(max-sum '(1 2 -5 3 5 3 1 21 1))
;-> (23 (1 21 1))

(max-sum '(1 2 -2 4 1 4))
;-> 9

(max-sum '(1 2 1 2))
;-> 5

(max-sum '(-1 -2 -1 -2))
;-> -4

(max-sum '(1 1 1 8 -1 8))
;-> 15

(max-sum '(1 1 1 -1 6 -1))
;-> 4

(max-sum '(2 8 2 -3 2))
;-> 12

(max-sum '(1 1 80))
;-> 2

(max-sum '(2 8 2 3 2))
;-> 17

(setq b (rand 1000 1000))
(max-sum b)
;-> (476948 (57 607 783 802 519 301 875 726 955 925
;-> ...
;-> 875 796 305 394 481 52 651 0 768 756 219 154 57))

Questo algoritmo è lento per liste/vettori con molti elementi:

(silent (setq b (rand 10000 10000)))
(time (max-sum b))
;-> 2775.132


--------------------------------------
Ricerca di una stringa in una funzione
--------------------------------------

Data una stringa, scrivere una funzione che restituisce "true" se la stringa è una sottostringa del codice sorgente della funzione, altrimenti restituisce "nil".

Se prendiamo come 'sorgente' della funzione la rappresentazione interna di newLISP la funzione potrebbe essere la seguente:

(define (check str) (if (find str (string check)) true nil))

In questo caso la rappresentazione interna della funzione vale è la seguente:

(string check)
;-> "(lambda (str) (if (find str (string check)) true nil))"

Proviamo la funzione:

(check "find ")
;-> true
(check "lambda")
;-> true

Comuqnue non troviamo "define" e il nome della funzione "check":

(check "define")
;-> nil
(check "check")

Per risolvere questo problema possiamo 'riscrivere' la parte mancante della funzione all'interno della funzione della funzione stessa.
In altre parole, dopo aver trasformato la funzione in stringa, possiamo sostituire la parte 'lambda' con il nome della funzione e ricostruire la funzione originale.

(define (lookfor str)
  ; conversione della funzione in stringa
  (setq func (string lookfor))
  ; sostituzione parte 'lambda'
  (replace "(lambda (" func "(define (lookfor ")
  ; (println func)
  ; ricerca della stringa sulla funzione ricostruita
  (if (find str func) true nil))

(string lookfor)
"(lambda (str) (setq func (string check2)) (replace \"(lambda (\" func \"(define (lookfor \") (if (find str func) true nil))"

Proviamo:

(lookfor "find ")
;-> true

Questa volta non troviamo "lambda":

(lookfor "lambda")
;-> nil

Ma troviamo "define" e il nome della funzione "lookfor":

(lookfor "define")
;-> true

(lookfor "lookfor")
;-> true


-------------------------------------------
Contare il numero di cambiamenti dei valori
-------------------------------------------

Data una lista di numeri interi, contare il numero di volte, leggendo da sinistra a destra, in cui il valore cambia.

Esempio:
lista = (1 1 1 2 2 5 5 5 5 17 3)
cambi =        1   2       3  4

Primo metodo: scorrere la lista e contare quanti cambiamenti avvengono

(define (cambi lst)
  (if (= lst '())
      0
      ;else
      (let ( (conta 0) (base (lst 0)) )
        (dolist (el lst)
          (cond ((and (> $idx 0) (!= el base))
                  (setq base el)
                  (++ conta))))
        conta)))

Proviamo:

(setq a '(1 1 1 2 2 5 5 5 5 17 3))
(cambi a)
;-> 4

(cambi '())
;-> 0
(cambi '(0))
;-> 0
(cambi '(0 0))
;-> 0
(cambi '(0 1))
;-> 1
(cambi '(1 1 1 2 2 3))
;-> 2
(cambi '(-3 3 3 -3 3 -3))
;-> 4
(cambi (sequence 1 20))
;-> 19

Secondo metodo: calcolare la differenza di tutte le coppie di numeri adiacenti e poi contare quante di queste differenze sono diverse da zero

Differenza tra coppie di numeri adiacenti:

(map - (rest a) (chop a))
;-> (0 0 1 0 3 0 0 0 12 -14)

Quando il valore risultante vale 0, allora i due numeri sono uguali, altrimenti sono diversi.
Ci sono 4 valori diversi da 0, quindi abbiamo 4 cambiamenti di valore.

(define (change lst) (length (clean zero? (map - (rest lst) (chop lst)))))

Proviamo:

(change a)
;-> 4
(change '())
;-> 0
(change '(0))
;-> 0
(change '(0 0))
;-> 0
(change '(0 1))
;-> 1
(change '(1 1 1 2 2 3))
;-> 2
(change '(-3 3 3 -3 3 -3))
;-> 4
(change (sequence 1 20))
;-> 19


--------------------------
Gemelli unici in due liste
--------------------------

Date due liste di numeri interi trovare l'intero più grande che appare in entrambe le liste ed è anche unico in entrambe le liste.

Esempio:
lista1 = (2 2 2 6 3 5 8 2))
lista2 = (8 7 5 8)
Esistono 2 coppie di gemelli nelle liste i numeri (5 5) e (8 8).
Il numero 5 compare 1 volta nella lista1 e nella lista2.
Il numero 8 compare 1 volta nella lista1 e 2 volte nella lista2.
Quindi la coppia gemella univoca è data dal numero 5, (5 5).

(define (twins lst1 lst2)
  (local (gemelli comuni)
    (setq gemelli nil)
    ; trova gli elementi in comune tra le due liste (e li ordina)
    (setq comuni (sort (intersect lst1 lst2)))
    ; ricerca nella lista 'comuni' gli elementi che compaiono
    ; solo una volta in entrambe le liste
    (dolist (el comuni)
      (if (and (= (length (ref-all el lst1)) 1)
               (= (length (ref-all el lst2)) 1))
          (setq gemelli el)
      )
    )
    gemelli))

Proviamo:

(setq a '(2 2 2 6 3 5 8 2))
(setq b '(8 7 5 8))
(twins a b)
;-> 5

(twins '(3) '(1 3))
;-> 3

(twins '(3 4) '(1 2))
;-> nil

(twins '(1 1 2 2 3 3 4) '(1 2 3 4))
;-> 4

(twins '(1 1 2 2 3 3 4) '(1 2 3 4 4))
;-> nil


--------------------------------------------------------
Teorema delle scimmie infinite (Infinite monkey theorem)
--------------------------------------------------------

Il teorema delle scimmie infinite afferma che una scimmia che prema a caso i tasti di una tastiera per un tempo infinitamente lungo certamente riuscirà a comporre qualsiasi testo prefissato.

Data una tastiera con T tasti e un testo da riprodurre di K caratteri, la probabilità di non effettuarlo in N tentativi (indipendenti) vale:

  (1 - 1/(T^K))^N

e il limite per N -> Infinito porta l'espressione a 0, perciò la probabilità di riprodurre un testo prefissato se si prova all'infinito vale 1.

Per "scimmiottare" una data stringa S, possiamo eseguire i seguenti passaggi:

1) Partire da una stringa vuota T.
2) Scegliere in modo casuale (uniforme) un carattere ASCII stampabile e aggiungerlo alla stringa T.
3) Se S è una sottostringa di T, allora T è la stringa "scimmiottata".
   Altrimenti, ripetere il passo 2 finché T non diventa una sottostringa di S.

Poichè non possiamo continuare all'infinito dobbiamo stabilire alcune regole:
a) la stringa A è costituita solo da caratteri minuscoli e spazi.
b) la lunghezza della stringa T deve essere un parametro della funzione.

(define (monkey str max-len show)
  (local (chars alfabeto len t)
    (setq chars 0)
    (setq alfabeto '(" " "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
                     "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
    (setq len (length alfabeto))
    (setq t "")
    (until (or (find str t) (> chars max-len))
      (extend t (alfabeto (rand len)))
      ;(print t (read-line))
      (++ chars)
    )
    ; restituisce l'indice della stringa 'str' in 't' (oppure nil)
    (if show (println t))
    (find str t)))

Facciamo alcune prove:

(monkey "a" 100 true)
;-> nhu wjoetpygez rhvgdxda
;-> 22

(monkey "ab" 1000 true)
;-> wfbzrifp ccvngrrgcuhkvqyobnvclimxmztpyxkdun blhpkibchue bhebvlwwku
;-> xilchevzxixdofykalkf dvnqwqawxjdwupfw yguosivousuedasscdulygoksiby
;-> prljcyqmqb ergkdhfnizhr lgoo qqpiaogvxasyrp dtccyycfgrksdlcarcslad
;-> dzhsnugnnhnocrfotxqq mfhzuylpcbwrhnotdlfhvwrplxpdikhqggmjgszlbfhfi
;-> ijffsmzr uwxsqqwvhjvbueivqptmqhshptengdkpdeixoafvamzterdtdjlcgbhtn
;-> yhonxzcuxbvgtpemcfpwtlvualsucovxmpwovrsiigeyppkjnej ufcmavbvpflgfa
;-> trdijayab
;-> 403

(monkey "abc" 1000)
;-> nil

(monkey "abc" 100000)
;-> 5017

(monkey "lisp" 100000)
;-> nil

(monkey "lisp" 100000)
;-> 74016

Questa funzione è lenta perchè creiamo una stringa sempre più lunga:

(time (println (monkey "abcd" 100000)))
;-> nil
;-> 4136.959

Comunque per vedere se 'str' si trova in 't' è sufficiente mantenere la lunghezza di 't' uguale a quella di 'str'.
Per fare questo, partiamo da una stringa 't' lunga quanto 'str' e poi ad ogni iterazione togliamo il primo carattere di 't' e ne aggiungiamo uno casuale a 't' (in fondo).
In questo modo la stringa 't' rimane sempre della stessa lunghezza di 'str' e possiamo fare il confronto.

(define (scimmia str max-len)
  (local (chars len-str alfabeto t trovato k)
    (setq chars 0)
    (setq len-str (length str))
    (setq alfabeto '(" " "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
                     "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
    (setq len (length alfabeto))
    (setq t "")
    (for (i 1 len-str) (extend t (alfabeto (rand len))))
    ;(print t) (read-line)
    (setq trovato nil)
    (setq k 0)
    (for (i 1 max-len 1 trovato)
      (cond ((find str t) (setq trovato true))
            (true
              (++ k)
              (pop t)
              (push (alfabeto (rand len)) t -1)
              ;(print t (read-line))
            )
      )
    )
    (if trovato k nil)))

Vediamo se le due funzioni generano gli stessi risultati:

(seed 1)
(monkey "aa" 10000)
;-> 414
(seed 1)
(scimmia "aa" 10000)
;-> 414

(seed 1)
(monkey "abc" 100000)
;-> 10102
(seed 1)
(scimmia "abc" 100000)
;-> 10102

Facciamo alcune prove:

(scimmia "lisp" 100000)
;-> nil

(scimmia "lisp" 100000)
;-> 97482

(time (println (scimmia "abcd" 1e5)))
;-> nil
;-> 37.765

(time (println (scimmia "abcd" 1e6)))
;-> nil
;-> 372.005

(time (println (scimmia "abcd" 1e7)))
;-> 143485
;-> 54.964

(time (println (scimmia "newlisp" 1e7)))
;-> nil
;-> 3755.983

(time (println (scimmia "newlisp" 1e8)))
;-> nil
;-> 37579.662

Vediamo un altro metodo che consiste nel considerare se il carattere casuale corrente è uguale a quello della stringa (partendo dall'indice 0). Se i caratteri sono uguali aumentiamo l'indice di 1, altrimenti poniamo l'indice a 0.
Se il valore dell'indice raggiunge la lunghezza della stringa, allora abbiamo trovato la stringa 'str' in 't'.

(define (sci str max-len)
  (local (t alfabeto)
    (setq len-str (length str))
    (setq alfabeto '(" " "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
                     "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))
    (setq len (length alfabeto))
    (setq conta 0)
    (setq trovato nil)
    ; indice
    (setq idx 0)
    (for (i 1 max-len 1 trovato)
      (++ conta)
      ; se caratteri uguali...
      (if (= (str idx) (alfabeto (rand len)))
          ; incrementa indice
          (++ idx)
          ; altrimenti azzera l'indice
          (setq idx 0)
      )
      ; indice = lunghezza 'str' ?
      (if (= idx len-str) (setq trovato true))
    )
    (if trovato (- conta len-str) nil)))

Vediamo se la funzione genera gli stessi risultati:

(seed 1)
(monkey "aa" 10000)
;-> 414
(seed 1)
(sci "aa" 10000)
;-> 414

(seed 1)
(monkey "abc" 100000)
;-> 10102
(seed 1)
(sci "abc" 100000)
;-> 10102

Facciamo alcune prove:

(sci "lisp" 100000)
;-> nil

(sci "lisp" 100000)
;-> 97486

(time (println (sci "abcd" 1e5)))
;-> nil
;-> 24.754

(time (println (sci "abcd" 1e6)))
;-> 221538
;-> 55.85

(time (println (sci "abcd" 1e7)))
;-> 24003
;-> 6.981

(time (println (sci "newlisp" 1e7)))
;-> nil
;-> 2454.46

(time (println (sci "newlisp" 1e8)))
;-> nil
;-> 24523.419

(time (println (sci "newlisp" 1e9)))
;-> nil
;-> 245823.935


----------------------------
Base di un numero senza zeri
----------------------------

Dato un intero positivo N, restituire la base B più piccola (>= 2) in cui la rappresentazione di N in base B (senza considerare eventuali zeri iniziali) non contiene zeri.

Sequenza OEIS A106370:
Smallest b>1 such that n contains no zeros in its base b representation.
  2, 3, 2, 3, 3, 4, 2, 3, 4, 4, 4, 5, 3, 3, 2, 3, 3, 5, 5, 6, 4, 3, 3, 5, 3, 3,
  4, 6, 4, 4, 2, 5, 5, 5, 6, 5, 4, 4, 4, 3, 3, 4, 3, 3, 4, 4, 4, 5, 3, 3, 6, 3,
  3, 4, 4, 5, 4, 4, 4, 7, 4, 4, 2, 5, 6, 5, 3, 3, 5, 3, 3, 5, 5, 5, 7, 3, 3, 7,
  3, 3, 5, 5, 5, 5, 4, 4, 4, 5, 4, 4, 4, 5, 4, 4, 4, 5, 5, 5, 5, 6, 4, 4, 4, 6,
  4, ...

(define (nozeri num)
  (local (val base)
    ; valore iniziale uguale al numero dato
    (setq val num)
    ; base iniziale
    (setq base 2)
    ; ciclo affinchè val maggiore di 0
    (while (> val 0)
      ; se divisibile val e base...
      (if (zero? (% val base))
        (begin
          ; aumentiamo la base e
          (++ base)
          ; il valore ritorna uguale a num
          (setq val num)
        )
        ; else
        ; altrimenti dividiamo val per la base
        (setq val (/ val base))
      )
    )
    base))

(map nozeri (sequence 1 50))
;-> (2 3 2 3 3 4 2 3 4 4 4 5 3 3 2 3 3 5 5 6 4 3 3 5 3 3
;->  4 6 4 4 2 5 5 5 6 5 4 4 4 3 3 4 3 3 4 4 4 5 3 3)


----------------------------------------------------------------
Funzioni per la gestione di un mazzo di carte (Carte Napoletane)
----------------------------------------------------------------

Le carte da gioco italiane consistono in un mazzo da 40 carte di 4 diversi semi, ma c'è una grande varietà grafica nel disegno delle carte, che dipende soprattutto dall'area geografica.
Le carte da gioco appaiono in Italia nella seconda metà del XIV secolo.
I semi sono 4: Bastoni, Coppe, Denari e Spade.
I valori sono 10: Asso (1), 2, 3, 4, 5, 6, 7, Fante (8), Cavallo (9), e Re (10).

In questo caso useremo la seguente rappresentazione grafica per le carte:

  Spade   Denari   Bastoni   Coppe
    |       +-+      | |     \   /
  --+--     | |      | |      | |
    |       +-+      | |      +-+

Asso di Spade    5 di Denari   Fante di Bastoni  Re di Coppe
  +-------+       +-------+       +-------+       +-------+
  |A      |       |5      |       |F      |       |R      |
  |   |   |       |  +-+  |       |  | |  |       | \   / |
  | --+-- |       |  | |  |       |  | |  |       |  | |  |
  |   |   |       |  +-+  |       |  | |  |       |  +-+  |
  |      A|       |      5|       |      F|       |      R|
  +-------+       +-------+       +-------+       +-------+

Funzione che genera un valore casuale:

(define (rand-valore)
  (let (valore (string (+ 1 (rand 10))))
    (if (= valore "1")  (setq valore "A")  ; Asso
        (= valore "8")  (setq valore "F")  ; Fante
        (= valore "9")  (setq valore "C")  ; Cavallo
        (= valore "10") (setq valore "R")) ; Re
    valore))

Funzione che genera un seme casuale:

(define (rand-seme)
  (let (seme (string (rand 4)))
    (if (= seme "0") (setq seme "B")  ; Bastoni
        (= seme "1") (setq seme "C")  ; Coppe
        (= seme "2") (setq seme "D")  ; Denari
        (= seme "3") (setq seme "S")) ; Spade
    seme))

Funzione che stampa una carta:

(define (print-carta lst)
  (let ( (valore (lst 0)) (seme (lst 1)) )
    (println (string "  " "+-------+"))
    (println (string "  " "|" valore "      |"))
    (cond ((= seme "B") ; Bastoni
            (println (string "  " "|  | |  |"))
            (println (string "  " "|  | |  |"))
            (println (string "  " "|  | |  |")))
          ((= seme "C") ; Coppe
            (println (string "  " "| \\   / |"))
            (println (string "  " "|  | |  |"))
            (println (string "  " "|  +-+  |")))
          ((= seme "D") ; Denari
            (println (string "  " "|  +-+  |"))
            (println (string "  " "|  | |  |"))
            (println (string "  " "|  +-+  |")))
          ((= seme "S") ; Spade
            (println (string "  " "|   |   |"))
            (println (string "  " "| --+-- |"))
            (println (string "  " "|   |   |")))
    )
    (println (string "  " "|      " valore "|"))
    (println (string "  " "+-------+")) '>))

(print-carta '("A" "B"))
;->   +-------+
;->   |A      |
;->   |  | |  |
;->   |  | |  |
;->   |  | |  |
;->   |      A|
;->   +-------+

Funzione che stampa una mano:

(define (print-mano mano)
  (local (draw valore seme)
    (setq draw (array 7 '("")))
    (dolist (m mano)
      (setq valore (m 0))
      (setq seme (m 1))
      ;(println valore { } seme)
      (setq (draw 0) (extend (draw 0) (string "    " "+-------+")))
      (setq (draw 1) (extend (draw 1) (string "    " "|" valore "      |")))
      (cond ((= seme "B") ; Bastoni
              (setq (draw 2) (extend (draw 2) (string "    " "|  | |  |")))
              (setq (draw 3) (extend (draw 3) (string "    " "|  | |  |")))
              (setq (draw 4) (extend (draw 4) (string "    " "|  | |  |"))))
            ((= seme "C") ; Coppe
              (setq (draw 2) (extend (draw 2) (string "    " "| \\   / |")))
              (setq (draw 3) (extend (draw 3) (string "    " "|  | |  |")))
              (setq (draw 4) (extend (draw 4) (string "    " "|  +-+  |"))))
            ((= seme "D") ; Denari
              (setq (draw 2) (extend (draw 2) (string "    " "|  +-+  |")))
              (setq (draw 3) (extend (draw 3) (string "    " "|  | |  |")))
              (setq (draw 4) (extend (draw 4) (string "    " "|  +-+  |"))))
            ((= seme "S") ; Spade
              (setq (draw 2) (extend (draw 2) (string "    " "|   |   |")))
              (setq (draw 3) (extend (draw 3) (string "    " "| --+-- |")))
              (setq (draw 4) (extend (draw 4) (string "    " "|   |   |"))))
      )
      (setq (draw 5) (extend (draw 5) (string "    " "|      " valore "|")))
      (setq (draw 6) (extend (draw 6) (string "    " "+-------+")))
    )
    (map println draw) '>))

(print-mano '(("7" "S")))
;->     +-------+
;->     |7      |
;->     |   |   |
;->     | --+-- |
;->     |   |   |
;->     |      7|
;->     +-------+

> (print-mano '(("2" "C") ("A" "S") ("F" "B") ("R" "D")))
;->     +-------+    +-------+    +-------+    +-------+
;->     |2      |    |A      |    |F      |    |R      |
;->     | \   / |    |   |   |    |  | |  |    |  +-+  |
;->     |  | |  |    | --+-- |    |  | |  |    |  | |  |
;->     |  +-+  |    |   |   |    |  | |  |    |  +-+  |
;->     |      2|    |      A|    |      F|    |      R|
;->     +-------+    +-------+    +-------+    +-------+

Funzione che mischia un mazzo (40 carte):

(define (shuffle)
  (local (mazzo valori bastoni coppe denari spade)
    (setq mazzo '())
    (setq valori '("A" "2" "3" "4" "5" "6" "7" "F" "C" "R"))
    (setq bastoni (map (fn(x y) (list x y)) valori (dup "B" 10 true)))
    (setq coppe (map (fn(x y) (list x y)) valori (dup "C" 10 true)))
    (setq denari (map (fn(x y) (list x y)) valori (dup "D" 10 true)))
    (setq spade (map (fn(x y) (list x y)) valori (dup "S" 10 true)))
    (extend mazzo bastoni coppe denari spade)
    (randomize mazzo)))

(setq mazzo (shuffle))
;-> (("3" "B") ("C" "C") ("R" "B") ("C" "D") ("5" "C") ("A" "D")
;->  ("4" "C") ("7" "D") ("6" "D") ("4" "B") ("5" "B") ("C" "B")
;->  ...
;->  ("3" "S") ("R" "D") ("6" "S") ("F" "D") ("6" "B") ("7" "S"))

Nota: 'mazzo' è una variabile globale che, all'inizio, contiene le 40 carte mischiate.

Funzione che crea una mano prendendo le prime di 'num' carte (prese dal mazzo mischiato):

(define (get-mano num)
  (cond ((<= num (length mazzo))
          (setq mano '())
          (for (i 1 num) (push (pop mazzo) mano -1)))
        (true (setq mano '()))
  )
  mano)

(print-mano (get-mano 3))
;->     +-------+    +-------+    +-------+
;->     |C      |    |5      |    |A      |
;->     |  +-+  |    | \   / |    |  +-+  |
;->     |  | |  |    |  | |  |    |  | |  |
;->     |  +-+  |    |  +-+  |    |  +-+  |
;->     |      C|    |      5|    |      A|
;->     +-------+    +-------+    +-------+
(length mazzo)
;-> 37

Funzione che prende la prima carta dal mazzo mischiato:

(define (get-carta)
  (if (> (length mazzo) 0)
      (pop mazzo)
      ;else
      '()))

(print-carta (get-carta))
;->   +-------+
;->   |R      |
;->   |  +-+  |
;->   |  | |  |
;->   |  +-+  |
;->   |      R|
;->   +-------+

(length mazzo)
;-> 36

Funzione "shuffle" per un mazzo di carte francesi:

(define (shuffle)
  (local (mazzo valori cuori quadri fiori picche)
    (setq mazzo '())
    (setq valori '("A" "2" "3" "4" "5" "6" "7" "8" "9" "10" "J" "Q" "K"))
    (setq cuori (map (fn(x y) (list x y)) valori (dup "c" 13 true)))
    (setq quadri (map (fn(x y) (list x y)) valori (dup "q" 13 true)))
    (setq fiori (map (fn(x y) (list x y)) valori (dup "f" 13 true)))
    (setq picche (map (fn(x y) (list x y)) valori (dup "p" 13 true)))
    (extend mazzo cuori quadri fiori picche)
    (randomize mazzo)))


-------------------------------
Interi come somma di palindromi
-------------------------------

L'articolo seguente prova che ogni intero positivo può essere scritto come somma di tre numeri palindromi per ogni base b>=5.
"Every positive integer is a sum of three palindromes"
di Javier Cilleruelo, Florian Luca, Lewis Baxter
https://arxiv.org/pdf/1602.06208v2.pdf

Limitandoci alla base b=10, scrivere una funzione che, dato un numero, calcola tutte le triple di numeri palindromi distinti la cui somma è uguale al numero dato.

Possono esistere più triple di numeri distinti la cui somma è uguale al numero dato.
Per esempio,
Numero = 111
Triple = (1 9 101) (1 11 99) (1 22 88) (1 33 77) (1 44 66) (2 8 101)
         (3 7 101) (3 9 99) (4 6 101) (4 8 99) (5 7 99))

Inoltre, poichè vogliamo solo le triple (non coppie o numeri singoli) i numeri minori di 6 non hanno alcuna tripla.

Funzione che verifica se un numero è palindromo:

(define (pali? num) (let (s (string num)) (= s (reverse (copy s)))))

(filter pali? (sequence 1 30))
;-> (1 2 3 4 5 6 7 8 9 11 22)

Funzione che trova tutte le triple di numeri di una lista la cui somma è uguale a un dato numero:

Per 2 numeri che sommano a N vedi:
"Somma di numeri in una lista (Google)" su "Domande".

Per 3 numeri che sommano a N vedi:
"Triple con una data somma (Uber)" su "Domande".

Algoritmo: uso di due puntatori dopo aver ordinato la lista.

(define (triple lst somma)
  (local (l r x n out)
    (setq out '())
    (setq n (length lst))
    (sort lst)
    (for (i 0 (- n 2))
      (setq l (+ i 1))
      (setq r (- n 1))
      (setq x (lst i))
      (while (< l r)
        (cond ((= (+ x (lst l) (lst r)) somma)
               ;(println x { } (lst l) { } (lst r))
               (push (list x (lst l) (lst r)) out -1)
               (++ l)
               (-- r))
              ((< (+ x (lst l) (lst r)) somma)
               (++ l))
              (true (-- r))
        )
      )
    )
    out))

Funzione che, dato un numero, calcola tutte le triple di numeri palindromi distinti la cui somma è uguale al numero dato:

(define (pali-sum num)
  (triple (filter pali? (sequence 1 num)) num))

Facciamo qualche prova:

(pali-sum 6)
;-> ((1 2 3))

(pali-sum 132)
;-> ((2 9 121) (3 8 121) (4 7 121) (5 6 121) (9 22 101) (11 22 99) (11 33 88)
;->  (11 44 77) (11 55 66) (22 33 77) (22 44 66) (33 44 55))

Scriviamo una funzione che verifica se tutti i numeri fino ad un certo limite hanno almeno una tripla di numeri palindromi distinti che sommano al numero:

(define (check limit)
  (let (pali (sequence 1 5))
    (for (k 6 limit)
      (if (pali? k) (push k pali))
      ;(print k { } pali) (read-line)
      (if (= '() (tripla pali k)) (println k)))))

(time (println (check 1000)))
;-> nil
;-> 711.104
(time (println (check 2000)))
;-> nil
;-> 3554.805
(time (println (check 3000)))
;-> 7728.546


------------------------------------
Esponenti massimi e minimi dei primi
------------------------------------

Dato un intero N >= 2, scrivere una funzione che restituisce l'esponente più grande e l'esponente più piccolo nella sua scomposizione in fattori primi.

Per esempio,
N = 200 = 2*2*2*5*5 = 2^3*5^2
Esponente massimo = 3
Esponente minimo = 2

Sequenza OEIS A051903:
Maximal exponent in prime factorization of n
  0, 1, 1, 2, 1, 1, 1, 3, 2, 1, 1, 2, 1, 1, 1, 4, 1, 2, 1, 2, 1, 1, 1, 3,
  2, 1, 3, 2, 1, 1, 1, 5, 1, 1, 1, 2, 1, 1, 1, 3, 1, 1, 1, 2, 2, 1, 1, 4,
  2, 2, 1, 2, 1, 3, 1, 3, 1, 1, 1, 2, 1, 1, 2, 6, 1, 1, 1, 2, 1, 1, 1, 3,
  1, 1, 2, 2, 1, 1, 1, 4, 4, 1, 1, 2, 1, 1, 1, 3, 1, 2, ...

Sequenza OEIS A051904:
Minimal exponent in prime factorization of n
  0, 1, 1, 2, 1, 1, 1, 3, 2, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1,
  2, 1, 3, 1, 1, 1, 1, 5, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 6, 1, 1, 1, 1, 1, 1, 1, 2,
  1, 1, 1, 1, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, ...

Algoritmo:
(setq num 200)
;-> 200
(setq fattori (factor num))
;-> (2 2 2 5 5)
(setq unici (unique fattori))
;-> (2 5)
(setq esponenti (count unici fattori))
;-> (3 2)
Esponente massimo:
(apply max esponenti)
;-> 3
Esponente minimo:
(apply min esponenti)
;-> 2

(define (max-factor num)
  (let (fattori (factor num))
    (apply max (count (unique fattori) fattori))))

(max-factor 200)
;-> 3

(map max-factor (sequence 2 80))
;-> (1 1 2 1 1 1 3 2 1 1 2 1 1 1 4 1 2 1 2 1 1 1 3 2 1 3 2 1 1 1 5 1 1
;->  1 2 1 1 1 3 1 1 1 2 2 1 1 4 2 2 1 2 1 3 1 3 1 1 1 2 1 1 2 6 1 1 1
;->  2 1 1 1 3 1 1 2 2 1 1 1 4)

(define (min-factor num)
  (let (fattori (factor num))
    (apply min (count (unique fattori) fattori))))

(min-factor 200)
;-> 2

(map min-factor (sequence 2 80))
;-> (1 1 2 1 1 1 3 2 1 1 1 1 1 1 4 1 1 1 1 1 1 1 1 2 1 3 1 1 1 1 5 1 1
;->  1 2 1 1 1 1 1 1 1 1 1 1 1 1 2 1 1 1 1 1 1 1 1 1 1 1 1 1 1 6 1 1 1
;->  1 1 1 1 2 1 1 1 1 1 1 1 1)


------------------------------
Sequenza di interi concatenati
------------------------------

Consideriamo la sequenza di interi positivi:

  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, ...

Concateniamo le cifre della sequenza:

  1234567891011121314151617181920212223242526...

Adesso vogliamo dividere la sequenza in due modi differenti:

1) lista in cui l'elemento n-esimo contiene n cifre

(1)(23)(456)(7891)(01112)(131415)(1617181)(92021222)(324252627) ...
---------------------------------------------------------------
 1  2    3     4     5       6       7        8          9      ...

2) lista in cui l'elemento n-esimo contiene n numeri

(1)(23)(456)(78910)(1112131415)(161718192021)(22232425262728) ...
-------------------------------------------------------------
 1  2    3     4        5            6              7         ...

Scrivere una funzione per ognuno dei due tipi di divisione.
La funzione prende come parametro la lunghezza della sequenza iniziale (ovvero l'ultimo numero della sequenza).
Per esempio:

lista tipo 1 con N=13
(divide1 13) -> (1 23 456 7891 01112)
Le cifre del 13 non compaiono perchè non sono sufficienti a creare il successivo elemento (131415).

lista tipo 2 con N=11 elementi:
(divide2 11) -> (1 23 456 78910)
Il numero 11 non compare perchè non è sufficiente a creare il successivo elemento (1112131415).

1) Funzione (divide1)

(define (list-break lst lst-len)
"Breaks a list into sub-lists of specified lengths"
  (let ((i 0) (q 0) (out '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) out -1)
    )
    out))

Algoritmo:

(setq seq (sequence 1 13))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13)
(setq lst (explode (join (map string seq))))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "1" "0" "1" "1" "1" "2" "1" "3")
(setq len-lst (length lst))
;-> 17
; la somma dei numeri da 1 a k vale: somma = (k*(k-1))/2
; len-lst è il numero di cifre totali (che è la nostra somma)
; risolvendo per k otteniamo k = (1 + sqrt(1 + 8*(len-lst)))/2
; quindi l'ultimo indice della lista divisa vale: (int k) - 1.
; In questo caso è last-num:
(setq last-num (- (int (div (add 1 (sqrt (add 1 (mul 8 len-lst)))) 2)) 1))
;-> 5
; Spezziamo la lista di cifre con la sequenza 1..last-num
; e uniamo le cifre di ogni elemento della lista
(map join (list-break lst (sequence 1 last-num)))
;-> ("1" "23" "456" "7891" "01112")

(define (divide1 N)
  (local (seq lst len-lst last-num)
    (setq seq (sequence 1 N))
    (setq lst (explode (join (map string seq))))
    (setq len-lst (length lst))
    (setq last-num (- (int (div (add 1 (sqrt (add 1 (mul 8 len-lst)))) 2)) 1))
    (map join (list-break lst (sequence 1 last-num)))))

Proviamo:

(divide1 13)
;-> ("1" "23" "456" "7891" "01112")

(divide1 50)
;-> ("1" "23" "456" "7891" "01112" "131415" "1617181" "92021222" "324252627"
;->  "2829303132" "33343536373" "839404142434" "4454647484950")

Verifichiamo che l'elemento n-esimo ha n cifre:

(map length (divide1 50))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13)

2) Funzione (divide2)

Algoritmo:

(setq seq (sequence 1 11))
;-> (1 2 3 4 5 6 7 8 9 10 11)
(setq lst (map string seq))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11")
; la somma dei numeri da 1 a k vale: somma = (k*(k-1))/2
; N è il numero di elementi totali (che è la nostra somma)
; risolvendo per k otteniamo k = (1 + sqrt(1 + 8*N))/2
; quindi l'ultimo indice della lista divisa vale: (int k) - 1.
; In questo caso è last-num:
(setq last-num (- (int (div (add 1 (sqrt (add 1 (mul 8 11)))) 2)) 1))
;-> 4
; Spezziamo la lista di cifre con la sequenza 1..last-num
; e uniamo i numeri di ogni elemento della lista
(map join (list-break lst (sequence 1 last-num)))
;-> ("1" "23" "456" "78910")

(define (divide2 N)
  (local (seq lst last-num)
    (setq seq (sequence 1 N))
    (setq lst (map string seq))
    (setq last-num (- (int (div (add 1 (sqrt (add 1 (mul 8 N)))) 2)) 1))
    (map join (list-break lst (sequence 1 last-num)))))

Proviamo:

(divide2 11)
;-> ("1" "23" "456" "78910")

(divide2 50)
;-> ("1" "23" "456" "78910" "1112131415" "161718192021" "22232425262728"
;->  "2930313233343536" "373839404142434445")


--------------------------------------------------------
Somma delle differenze tra sequenze di cifre consecutive
--------------------------------------------------------

Consideriamo la sequenza di interi positivi:

  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, ...

Concateniamo le cifre della sequenza:

  1234567891011121314151617181920212223242526...

Scrivere una funzione per calcolare la somma delle differenze di tutte le coppie di cifre consecutive da num1 a num2.

Per esempio, con num1 = 1 e num2 = 12 abbiamo:

  sequenza = (1 2 3 4 5 6 7 8 9 10 11 12)
  concatenazione = 123456789101112
  differenze tra coppie consecutive = ((2 - 1) (3 - 2) (4 - 3) (5 - 4) (6 - 5)
  (7 - 6) (8 - 7) (9 - 8) (1 - 9) (0 - 1) (1 - 0) (1 - 1) (1 - 1) (2 - 1)) =
  = (1 1 1 1 1 1 1 -8 -1 1 0 0 1)
  Somma = 1 + 1 + 1 + 1 + 1 + 1 + 1 + -8 + -1 + 1 + 0 + 0 + 1 = 1

Algoritmo:

; sequenza
(setq seq (sequence 1 12))
;-> (1 2 3 4 5 6 7 8 9 10 11 12)
; cifre (stringhe)
(setq cifre (explode (join (map string seq))))
;-> ("1" "2" "3" "4" "5" "6" "7" "8" "9" "1" "0" "1" "1" "1" "2")
; cifre (interi)
(setq digit (map int cifre))
;-> (1 2 3 4 5 6 7 8 9 1 0 1 1 1 2)
; differenze
(setq diff (map - (rest digit) (chop digit)))
;-> (1 1 1 1 1 1 1 1 -8 -1 1 0 0 1)
; somma delle differenze
(setq somma (apply + diff))
;-> 1

(define (sum-diff1 num1 num2)
  (let (digit (map int (explode (join (map string (sequence num1 num2))))))
    (apply + (map - (rest digit) (chop digit)))))

(sum-diff1 1 12)
;-> 1

(sum-diff1 21 123)
;-> 1

(sum-diff1 11 1099)
;-> 8

Nota: matematicamente risulta che la somma di tutte le differenze tra cifre consecutive è la differenza tra l'ultima e la prima cifra.

(define (sum-diff2 num1 num2)
  (- (int (last (string num2))) (int (first (string num1)))))

(sum-diff2 1 12)
;-> 1

(sum-diff2 21 123)
;-> 1

(sum-diff2 11 1099)
;-> 8


------------------
La rana saltatrice
------------------

La "rana saltatrice" è un animale che salta tra i numeri interi, fino ad arrivare al 3 o al 19.
La rana usa il seguente metodo per saltare tra i numeri:

1) la rana parte da un numero intero positivo casuale n>=2:
2) se n = 3 o n = 19:
   la rana smette di saltare (3 o 19).
3) se n è primo:
   la rana salta nella posizione (2*n - 1).
   Poi torna al passo 2.
4) se f è composito:
   la rana salta nella posizione (f - d), dove d è il divisore primo maggiore.
   Poi torna al passo 2.

(define (rana num)
  (let (f (factor num))
    (print num { })
    (cond ((or (= num 3) (= num 19)) nil)
          ((= (length f) 1) (rana (- (* 2 num) 1)))
          (true (rana (- num (last f)))))))

(rana 23)
;-> 23 45 40 35 28 21 14 7 13 25 20 15 10 5 9 6 3 nil

(define (frog-aux num)
  (let (f (factor num))
    ;(print num { })
    (push num out -1)
    (cond ((or (= num 3) (= num 19)) nil)
          ((= (length f) 1) (frog-aux (- (* 2 num) 1)))
          (true (frog-aux (- num (last f)))))))

(define (frog num)
  (let (out '())
    (frog-aux num)
    out))

(frog 23)
;-> (23 45 40 35 28 21 14 7 13 25 20 15 10 5 9 6 3)

(length (frog 1e6))
;-> 414

I numeri 3 e 19 creano due cicli:

(define (ciclo-aux num)
  (let (f (factor num))
    (cond ((ref num out) nil)
          ((= (length f) 1)
            (push num out -1)
            (ciclo-aux (- (* 2 num) 1)))
          (true
            (push num out -1)
            (ciclo-aux (- num (last f)))))))

(define (ciclo num)
  (let (out '())
    (ciclo-aux num)
    (push num out -1)
    out))

(ciclo 3)
;-> (3 5 9 6 3)
(ciclo 19)
;-> (19 37 73 145 116 87 58 29 57 38 19)


---------------
Quadrati binari
---------------

Un quadrato binario di un numero N viene costruito nel modo seguente:

1) Prendere la sequenza dei numeri naturali positivi:

  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, ...

2) Convertire ogni numero in binario:

1, 10, 11, 100, 101, 110, 111, 1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111, 10000, 10001, ...

3) Concatenare tutti i numeri binari:

  11011100101110111100010011010101111001101111011111000010001 ...

Partendo da k=1, generare matrici quadrate di dimensione k prendendo i valori necessari dalla sequenza dei numeri binari concatenati fino a restituire la matrice per k = N

Valori usati per le matrici quadrate:

  1 1011 100101110 1111000100110101 0111100110111101111100001 0001 ...

Matrici quadrate:

  k=1
  1

  k=2
  1 0
  1 1

  k=3
  1 0 0
  1 0 1
  1 1 0

  k=4
  1 1 1 1
  0 0 0 1
  0 0 1 1
  0 1 0 1

  k=5
  0 1 1 1 1
  0 0 1 1 0
  1 1 1 1 0
  1 1 1 1 1
  0 0 0 0 1

  k=6
  ...

Scrivere una funzione per generare il quadrato binario di un numero N.

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    (if (array? matrix) (setq matrix  (array-list matrix)))
    (setq row (length matrix))
    (setq col (length (first matrix)))
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    (setq digit (+ 1 lenmax))
    (setq fmtstr (append "%" (string digit) "s"))
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println)) '>))

Il primo problema è sapere quante cifre binarie occorrono per creare la matrice quadrata del numero N.

La somma dei quadrati dei primi N numeri vale:

  Sum[i=1..N](i^2) = (N*(N+1)*(2N+1))/6

(define (sumsq num) (div (* num (+ num 1) (+ (* 2 num) 1)) 6))

Per esempio con N = 10 ci servono 385 cifre:

(setq N 10)
(setq cifre (sumsq N))
;-> 385

Adesso per avere 385 cifre binarie fino a che numero decimale bisogna arrivare?
Generiamo la stringa di cifre binarie partendo dal numero decimale 1 fino a che non raggiungiamo almeno 385 cifre binarie:

(setq len-bin 1)
(setq num 1)
(setq bin "1")

(while (< len-bin cifre)
  (++ num)
  (setq len-bin (+ len-bin (length (bits num))))
  (extend bin (bits num))
)
;-> "11011100101110111100010011010101111001101111011111000010001100101001110
;->  10010101101101011111000110011101011011111001110111110111111000001000011
;->  00010100011100100100101100110100111101000101001101010101011101100101101
;->  10111010111111000011000111001011001111010011010111011011011111100011100
;->  11110101110111111001111011111101111111000000100000110000101000011100010
;->  010001011000110100011110010001001001"

Adesso estraiamo tutte le matrici (i quadrati binari) fino alla matrice N-esima (10):

(setq idx 0)

(for (k 1 N)
  (setq m (slice bin idx (* k k)))
  (setq quad (array k k (explode m)))
  (setq idx (+ idx (* k k)))
  (print-matrix quad) (read-line)
)

(print-matrix quad)
;->  1 1 1 0 1 0 1 1 1 0
;->  1 1 1 1 1 1 0 0 1 1
;->  1 1 0 1 1 1 1 1 1 0
;->  1 1 1 1 1 1 1 0 0 0
;->  0 0 0 1 0 0 0 0 0 1
;->  1 0 0 0 0 1 0 1 0 0
;->  0 0 1 1 1 0 0 0 1 0
;->  0 1 0 0 0 1 0 1 1 0
;->  0 0 1 1 0 1 0 0 0 1
;->  1 1 1 0 0 1 0 0 0 1

Scriviamo la funzione finale:

(define (quad-bin N)
  (local (num-cifre num bin len-bin idx m quad)
    (setq num-cifre (div (* N (+ N 1) (+ (* 2 N) 1)) 6))
    (setq num 1)
    (setq bin "1")
    (setq len-bin 1)
    (while (< len-bin num-cifre)
      (++ num)
      (setq len-bin (+ len-bin (length (bits num))))
      (extend bin (bits num))
    )
    (setq idx 0)
    (for (k 1 N)
      (setq m (slice bin idx (* k k)))
      (setq quad (array k k (explode m)))
      (setq idx (+ idx (* k k)))
      ;(print-matrix quad) (read-line)
    )
    (print-matrix quad)))

Proviamo:

(quad-bin 4)
;->  1 1 1 1
;->  0 0 0 1
;->  0 0 1 1
;->  0 1 0 1

(quad-bin 7)
;->  0 0 0 1 1 0 0
;->  1 1 1 0 1 0 1
;->  1 0 1 1 1 1 1
;->  0 0 1 1 1 0 1
;->  1 1 1 1 0 1 1
;->  1 1 1 1 0 0 0
;->  0 0 1 0 0 0 0

(quad-bin 12)
;->  1 0 1 0 1 0 1 1 0 1 1 1
;->  0 1 1 1 0 0 1 0 1 1 1 0
;->  1 1 0 1 1 1 1 0 1 0 1 1
;->  1 1 1 1 1 0 0 0 0 0 1 1
;->  0 0 0 0 1 1 1 0 0 0 1 0
;->  1 1 0 0 0 1 1 1 1 0 0 1
;->  0 0 1 1 0 0 1 0 1 1 1 0
;->  0 1 1 0 1 1 0 0 1 1 1 1
;->  1 0 1 0 0 0 1 1 0 1 0 0
;->  1 1 1 0 1 0 1 0 1 1 0 1
;->  0 1 1 1 1 0 1 1 0 0 1 1
;->  0 1 1 0 1 1 1 0 1 1 1 0


---------------
Numeri N-gonali
---------------

L'N-esimo numero N-gonale è definito come l'N-esimo numero della sequenza formata da un poligono di N lati.

Sequenza OEIS A060354:
The n-th n-gonal number: a(n) = n*(n^2 - 3*n + 4)/2
  0, 1, 2, 6, 16, 35, 66, 112, 176, 261, 370, 506, 672, 871, 1106, 1380,
  1696, 2057, 2466, 2926, 3440, 4011, 4642, 5336, 6096, 6925, 7826, 8802,
  9856, 10991, 12210, 13516, 14912, 16401, 17986, 19670, 21456, 23347,
  25346, 27456, 29680, 32021, ...

(define (n-gonal num)
  (/ (* num (+ (* num num) (* -3 num) 4)) 2))

(map n-gonal (sequence 0 40))
;-> (0 1 2 6 16 35 66 112 176 261 370 506 672 871 1106 1380 1696 2057 2466
;->  2926 3440 4011 4642 5336 6096 6925 7826 8802 9856 10991 12210 13516
;->  14912 16401 17986 19670 21456 23347 25346 27456 29680)


--------------------
Distanza tra N punti
--------------------

Data una lista con N coordinate che rappresentano la posizione di N punti in una griglia 2D, scrivere una funzione che restituisce per ogni punto le distanze con tutti gli altri punti (e la loro somma).
Per esempio,
  N = 3
  p1 = (2 3)
  p2 = (-5 5)
  p3 = (0 -1)
  distanza(p1 p2) = 7.2801
  distanza(p1 p3) = 4.4721
  distanza(p2 p3) = 7.8102
  somma-distanze(p1) = 7.2801 + 4.4721 = 11.7522
  somma-distanze(p2) = 7.2801 + 7.8102 = 15.093
  somma-distanze(p3) = 4.4721 + 7.8102 = 12.2823

Nell'esempio abbiamo usato la distanza euclidea tra due punti, ma la funzione deve poter operare con i seguenti tipi di distanze:

1) Distanza euclidea
2) Distanza di Manhattan (4 direzioni)
3) Distanza di Manhattan (8 direzioni)
4) Distanza terrestre (latitudine-longitudine)

(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

(define (dist-manh4 x1 y1 x2 y2)
"Calculates Manhattan distance (4 directions - rook) of two points P1=(x1 y1) e P2=(x2 y2)"
  (add (abs (sub x1 x2)) (abs (sub y1 y2))))

(define (dist-manh8 x1 y1 x2 y2)
"Calculates Manhattan distance (8 directions - queen) of two points P1=(x1 y1) e P2=(x2 y2)"
  (max (abs (sub x1 x2)) (abs (sub y1 y2))))

(define (dist-earth lat1 lon1 lat2 lon2)
  (define (deg-rad deg) (div (mul deg 3.1415926535897931) 180))
"Calculates the minimal distance of two points on a sphere with haversine formula"
  (local (r dlat dlon a c d)
  (setq r 6371) ; raggio medio della terra in km
  (setq dlat (deg-rad (sub lat2 lat1))) ; delta lat (in radianti)
  (setq dlon (deg-rad (sub lon2 lon1))) ; delta lon (in radianti)
  (setq a (add (mul (sin (div dlat 2)) (sin (div dlat 2)))
               (mul (cos (deg-rad lat1)) (cos (deg-rad lat2))
                    (sin (div dlon 2)) (sin (div dlon 2)))))
  (setq c (mul 2 (atan2 (sqrt a) (sqrt (sub 1 a)))))
  (setq d (mul r c)))) ; distanza in km

Funzione che calcola le distanze tra tutti i punti:

(define (distanze pts func)
  (setq len (length pts))
  (setq dist (array len len '(0)))
  (for (i 0 (- len 2))
    (for (j (+ i 1) (- len 1))
      (setq x1 (pts i 0))
      (setq y1 (pts i 1))
      (setq x2 (pts j 0))
      (setq y2 (pts j 1))
      (setq d (func x1 y1 x2 y2))
      (setf (dist i j) d)
      (setf (dist j i) d)
    )
  )
  (for (row 0 (- len 1))
    (println "p" (+ row 1) " = " (dist row) " (" (apply add (dist row)) ")")
  ))

Proviamo:

(distanze '((2 3) (-5 5) (0 -1)) dist2d)
;-> p1 = (0 7.280109889280518 4.47213595499958) (11.7522458442801)
;-> p2 = (7.280109889280518 0 7.810249675906654) (15.09035956518717)
;-> p3 = (4.47213595499958 7.810249675906654 0) (12.28238563090623)

(distanze '((2 3) (-5 5) (0 -1)) dist-manh4)
;-> p1 = (0 9 6) (15)
;-> p2 = (9 0 11) (20)
;-> p3 = (6 11 0) (17)

(distanze '((2 3) (-5 5) (0 -1)) dist-manh8)
;-> p1 = (0 7 4) (11)
;-> p2 = (7 0 6) (13)
;-> p3 = (4 6 0) (10)

(distanze '((2 3) (-5 5) (0 -1)) dist-earth)
;-> p1 = (0 809.4522894613095 497.1980008482959) (1306.650290309606)
;-> p2 = (809.4522894613095 0 867.808561372754) (1677.260850834064)
;-> p3 = (497.1980008482959 867.808561372754 0) (1365.00656222105)


-----------------------
Potenze prime dei primi
-----------------------

Le potenze prime dei numeri primi si riferiscono ai numeri primi elevati a una potenza intera positiva.
In altre parole, questi sono numeri della forma p^n , dove p è un numero primo e n è un intero positivo maggiore di 1.

Consideriamo ad esempio il numero primo 2:

- 2^2 = 4 (una potenza prima, poiché 4 è 2^2 )
- 2^3 = 8 (una potenza prima)
- 2^4 = 16 (non una potenza prima, poiché 16 non è un numero primo)

Allo stesso modo, per il numero primo 3:

- 3^2 = 9 (una potenza prima)
- 3^3 = 27 (una potenza prima)
- 3^4 = 81 (non una potenza primaria)

È importante notare che mentre tutte le potenze prime sono numeri della forma p^n, non tutti i numeri di questa forma sono potenze prime.
Una potenza prima si riferisce specificamente al caso in cui sia p che n sono primi.

Sequenza OEIS A053810 :
Prime powers of prime numbers
  4, 8, 9, 25, 27, 32, 49, 121, 125, 128, 169, 243, 289, 343, 361, 529,
  841, 961, 1331, 1369, 1681, 1849, 2048, 2187, 2197, 2209, 2809, 3125,
  3481, 3721, 4489, 4913, 5041, 5329, 6241, 6859, 6889, 7921, 8192, 9409,
  10201, 10609, 11449, 11881, 12167, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

Funzione che verifica se un numero è potenza prima di un numero primo:

(define (ppp? num)
  (local (f len)
    (setq f (factor num))
    (setq len (length f))
    ; numero composito: (> len 1)
    ; tutti i fattori uguali: (apply = f)
    ; lunghezza dei fattori prima: (prime? len))))
    (and (> len 1) (apply = f) (prime? len))))

(filter ppp? (sequence 1 10000))
;-> (4 8 9 25 27 32 49 121 125 128 169 243 289 343 361 529 841 961 1331 1369
;->  1681 1849 2048 2187 2197 2209 2809 3125 3481 3721 4489 4913 5041 5329
;->  6241 6859 6889 7921 8192 9409)


------------------------
Lista continua di interi
------------------------

Data una lista contenente numeri interi, scrivere una funzione che inserisce i numeri interi necessari per renderla continua.

Per esempio,

  lista = (4 2 6 1)
  lista continua = (4 3 2 3 4 5 6 5 4 3 2 1)

  lista = (10 10)
  lista continua = (10 10)

  lista = (-1 3 5)
  lista continua = (-1 0 1 2 3 4 5)

  lista = (1 -3 3 3 4 4 5 5 7 -1)
  lista continua = (1 0 -1 -2 -3 -2 -1 0 1 2 3 3 4 4 5 5 6 7 6 5 4 3 2 1 0 -1)

Funzione che rende continua una lista di interi:

(define (continua lst)
  (local (len out)
  (setq len (length lst))
  (cond ((zero? len) (setq out '()))
        ((= len 1) (setq out lst))
        (true
          (for (i 0 (- (length lst) 2))
            (cond ((= (lst i) (lst (+ i 1))) ; primo = secondo
                    ; aggiunge solo primo numero
                    (push (lst i) out -1))
                  ((> (lst i) (lst (+ i 1))) ; primo maggiore di secondo
                    ; aggiunge sequenza decrescente (tranne ultimo numero)
                    (extend out (sequence (lst i) (+ (lst (+ i 1)) 1))))
                  ((< (lst i) (lst (+ i 1))) ; primo minore del secondo
                    ; aggiunge sequenza crescente (tranne ultimo numero)
                    (extend out (sequence (lst i) (- (lst (+ i 1)) 1))))
            )
          )
          ; aggiunge eventuale ultimi numeri
          ; caso ultima operazione: sequenza
          (if (!= (out -1) (lst -1)) (push (lst -1) out -1))
          ; caso ultima operazione: due numeri uguali
          (if (= (lst -1) (lst -2)) (push (lst -1) out -1)))
  )
  out))

Proviamo:

(continua '())
;-> ()
(continua '(1))
;-> (1)

(continua '(4 2 6 1))
;-> (4 3 2 3 4 5 6 5 4 3 2 1)

(continua '(10 10))
;-> (10 10)

(continua '(-1 3 5))
;-> (-1 0 1 2 3 4 5)

(continua '(1 -3 3 3 4 4 5 5 7 -1))
;-> (1 0 -1 -2 -3 -2 -1 0 1 2 3 3 4 4 5 5 6 7 6 5 4 3 2 1 0 -1)

(continua '(10 10 10))
;-> (10 10 10)


------------------------------------
Radice fattoriale prima di un numero
------------------------------------

La radice fattoriale prima di un numero è il numero che emerge quando si prendono i fattori primi di un numero, li si sommano e si ripete il processo sul numero risultante, continuando finché non si ottiene un numero primo (che ha se stesso come suo unico fattore primo, ed è quindi la propria radice fattoriale prima).

Per esempio con il numero 24:
  24 = 2*2*2*3 --> 2 + 2 + 2 + 3 = 9
  9  = 3*3     --> 3 + 3 = 6
  6  = 2*3     --> 2 + 3 = 5 (numero primo)
Quindi la radice fattoriale prima di 24 vale 5.

Sequenza OEIS A029908:
Starting with n, repeatedly sum prime factors (with multiplicity) until reaching 0 or a fixed point.
Then a(n) is the fixed point (or 0).
  0, 2, 3, 4, 5, 5, 7, 5, 5, 7, 11, 7, 13, 5, 5, 5, 17, 5, 19, 5, 7, 13, 23,
  5, 7, 5, 5, 11, 29, 7, 31, 7, 5, 19, 7, 7, 37, 7, 5, 11, 41, 7, 43, 5, 11,
  7, 47, 11, 5, 7, 5, 17, 53, 11, 5, 13, 13, 31, 59, 7, 61, 5, 13, 7, 5, 5,
  67, 7, 5, 5, 71, 7, 73, 5, 13, 23, 5, 5, 79, 13, 7, 43, 83, 5, 13, ...

Nota: la radice fattoriale prima di 4 è 4, poiché 2*2=2+2, e questa è l'unica radice fattoriale prima non prima di un intero maggiore di 1 (che è un altro caso speciale, poiché non ha fattori primi).

(define (radice-fattoriale num)
  (cond ((= num 1) 0)
        ((= num 4) 4)
        (true
          (let (fattori (factor num))
            (until (= (length fattori) 1)
              (setq num (apply + fattori))
              (setq fattori (factor num))
            )
          (fattori 0)))))

Proviamo:

(radice-fattoriale 24)
;-> 5

(map radice-fattoriale (sequence 1 50))
;-> (0 2 3 4 5 5 7 5 5 7 11 7 13 5 5 5 17 5 19 5 7 13 23 5 7 5 5 11
;->  29 7 31 7 5 19 7 7 37 7 5 11 41 7 43 5 11 7 47 11 5 7)


-------------------------
Numeri con potenze simili
-------------------------

Dato un intero p > 1, trovare il più piccolo intero q > p tale che l'elenco degli esponenti nella scomposizione in fattori primi di q sia lo stesso di quello di p, indipendentemente dall'ordine o dal valore dei fattori primi.

Esempi
La scomposizione in fattori primi di p = 20 vale 2^2 * 5^1.
Il più piccolo intero maggiore di p con esponenti identici nella sua scomposizione in fattori primi è q = 28 = 2^2 x 7^1.

La scomposizione in fattori primi di p = 2500 è 2^2 x 5^4.
Il più piccolo intero maggiore di p con esponenti identici nella sua scomposizione in fattori primi è q = 2704 = 2^4 x 13^2.

Sequenza OEIS A081761:
Least number >n having same type of prime factorization, a(1)=1.
  1, 3, 5, 9, 7, 10, 11, 27, 25, 14, 13, 18, 17, 15, 21, 81, 19, 20, 23,
  28, 22, 26, 29, 40, 49, 33, 125, 44, 31, 42, 37, 243, 34, 35, 38, 100,
  41, 39, 46, 54, 43, 66, 47, 45, 50, 51, 53, 80, 121, 52, 55, 63, 59, 56,
  57, 88, 58, 62, 61, 84, 67, 65, 68, 729, 69, 70, 71, 75, 74, 78, ...

(define (simile num)
  (if (= num 1) 1
  ;else
  (local (fattori unici potenze cur cur-pot)
    (setq fattori (factor num))
    (setq unici (unique fattori))
    (setq potenze (sort (count unici fattori)))
    (setq cur num)
    (setq cur-pot '())
    (while (!= potenze cur-pot)
      (++ cur)
      (setq fattori (factor cur))
      (setq unici (unique fattori))
      (setq cur-pot (sort (count unici fattori)))
    )
    cur)))

Proviamo:

(simile 1)
;-> 1
(simile 123)
;-> 129
(simile 75600)
;-> 105840

(map simile (sequence 1 50))
;-> (1 3 5 9 7 10 11 27 25 14 13 18 17 15 21 81 19 20 23 28 22 26 29 40
;->  49 33 125 44 31 42 37 243 34 35 38 100 41 39 46 54 43 66 47 45 50
;->  51 53 80 121 52)


---------------------------------------------
Distribuzione di frequenza del lancio di dadi
---------------------------------------------

Dati due numeri interi positivi F e D, restituire la distribuzione di frequenza del lancio di D dadi con F facce.
Una distribuzione di frequenza elenca la frequenza di ogni possibile somma se ogni possibile sequenza di lanci di dadi si verifica una volta.
Pertanto, le frequenze sono numeri interi la cui somma è uguale a F^D.

Vedi anche "Frequenze dei numeri con N dadi" su "Note libere 15".

(define (cartesian-product lst-lst)
"Calculates the cartesian product of a list of lists"
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1)
    )
    out))

; auxiliary function: cartesian product of two list
(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        '()
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(setq a (cartesian-product '((1 2 3 4 5 6) (1 2 3 4 5 6) (1 2 3 4 5 6))))
;-> ((1 1 1) (1 1 2) (1 1 3) (1 1 4) (1 1 5) (1 1 6) (1 2 1) (1 2 2) (1 2 3)
;->  (1 2 4) (1 2 5) (1 2 6) (1 3 1) (1 3 2) (1 3 3) (1 3 4) (1 3 5) (1 3 6)
;->  (1 4 1) (1 4 2) ...
;->  ...
;->  (6 4 1) (6 4 2) (6 4 3) (6 4 4) (6 4 5) (6 4 6) (6 5 1) (6 5 2) (6 5 3)
;->  (6 5 4) (6 5 5) (6 5 6) (6 6 1) (6 6 2) (6 6 3) (6 6 4) (6 6 5) (6 6 6))

Funzione che calcola le frequenze del lancio di Dadi con Facce:

(define (frequenze dadi facce)
  (if (= dadi 1) (dup 1 facce)
  ;else
  (local (max-val min-val lst all sum freq pre)
    ; valore massimo di un lancio
    (setq max-val (* dadi facce))
    ; valore minimo di un lancio
    (setq min-val dadi)
    ; lista dei dadi
    (setq lst (dup (sequence 1 facce) dadi))
    ; lista di tutti i lanci
    (setq all (cartesian-product lst))
    ; somma di ogni lancio
    (setq sum (map (fn(x) (apply + x)) all))
    ; frequenza di ogni numero possibile (del lancio dei dadi)
    (setq freq (flat (count (sequence min-val max-val) sum)))
    ; prefix dei valori che hanno frequenza 0
    (setq pre (dup '0 min-val))
    (extend pre freq))))

Proviamo:

(frequenze 1 6)
;-> (1 1 1 1 1 1)

(frequenze 3 6)
;-> (0 0 0 1 3 6 10 15 21 25 27 27 25 21 15 10 6 3 1)

(pow 6 3)
;-> 216
(apply + (frequenze 3 6))
;-> 216

(time (println (frequenze 6 8)))
;-> (0 0 0 0 0 0 1 6 21 56 126 252 462 792 1281 1966 2877 4032 5432 7056
;->  8856 10752 12642 14412 15946 17136 17892 18152 17892 17136 15946
;->  14412 12642 10752 8856 7056 5432 4032 2877 1966 1281 792 462 252
;->  126 56 21 6 1)
;-> 484.253

(time (println (frequenze 8 6)))
;-> (0 0 0 0 0 0 0 0 1 8 36 120 330 792 1708 3368 6147 10480 16808 25488
;->  36688 50288 65808 82384 98813 113688 125588 133288 135954 133288
;->  125588 113688 98813 82384 65808 50288 36688 25488 16808 10480 6147
;->  3368 1708 792 330 120 36 8 1)
;-> 4141.002

Con dadi > 10 e facce > 10 il sistema va in crash (causa: la funzione che calcola il prodotto cartesiano genera una lista troppo grande).


--------------------------------------
Media delle medie di due numeri interi
--------------------------------------

Consideriamo le seguenti medie per due numeri interi a e b:

  La radice quadrata media: sqrt((a^2 + b^2)/2).

  La media aritmetica: (a + b)/2.

  La media geometrica: sqrt(a*b)

  La media armonica: 2/(1/a + 1/b) = 2*a*b/(a + b).

Scrivere una funzione che calcola la media delle medie sopra riportate.

(define (media a b)
  (div (add (sqrt (div (add (mul a a) (mul b b)) 2))
            (div (add a b) 2)
            (sqrt (mul a b))
            (div (mul 2 a b) (add a b)))
        4))

Proviamo:

(media 7 6)
;-> 6.490370391287243
(media 10 10)
;-> 10
(media 23 1)
;-> 8.747829696519773
(media 2 4)
;-> 2.914342862895309
(media 200 400)
;-> 291.4342862895309

============================================================================

