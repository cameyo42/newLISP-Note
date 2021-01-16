===============

 NOTE LIBERE 2

===============

-----------------------------
Creare una lista di frequenza
-----------------------------

Data una lista di lettere dell'alfabeto, costruire la lista delle frequenze.
Esempio:
input  -> (a b g f a f g f g h)
output -> ((a 2) (b 1) (g 3) (f 3) (h 1))

Usiamo una hashmap e vediamo le operazioni fondamentali.

Creiamo una hashmap:
(new Tree 'myHash)

Inserimento di un valore 1 (value) associato ad una chiave K (key) -> (myHash "key" value):
(myHash "K" 1)
;-> 1

Recuperiamo il valore tramite la chiave:
(myHash "K")
;-> 1

Inserimento di un nuovo valore 2 (value) associato ad una chiave W (key) -> (myHash "key" value):
(myHash "W" 2)
;-> 2

Elenco di tutti gli elementi (chiave valore) della hashmap:
(myHash)
;-> (("K" 1) ("W" 2))

Se una chiave non esiste, allora newLISP restituisce nil:
(myHash "X")
;-> nil
(myHash "X")
;-> nil

Per eliminare un valore occorre assegnare il valore nil:
(myHash "K" nil)
;-> nil
(myHash)
;-> (("W" 2))

Aggiorniamo il valore associato ad una chiave esistente ($it = valore precedente):
(myHash "W" (+ $it 3))
;-> 5
(myHash)
;-> (("W" 5))

Adesso scriviamo la funzione che calcola le frequenze:

(define (freq lst)
  (local (out)
    (setq out '())
    (new Tree 'myHash)
    (dolist (el lst)
      ; se la chiave non esiste nella hashmap...
      (if (null? (myHash (string el)))
          ; allora inserisce la chiave con il valore 1
          (myHash (string el) 1)
          ; altrimenti aggiunge uno al valore associato alla chiave (che esiste)
          (myHash (string el) (+ $it 1))
      )
    )
    ; assegna la hashmap ad una lista
    (setq out (myHash))
    ; elimina la hashmap
    (delete 'myHash)
    out))

(freq '(a b g f a f g f g h))
;-> (("a" 2) ("b" 1) ("f" 3) ("g" 3) ("h" 1))
(freq '(1 2 3 4 5 5 4 3 2 1))
;-> (("1" 2) ("2" 2) ("3" 2) ("4" 2) ("5" 2))
(freq '())
;-> ()




--------------------------------------
Approssimazione razionale di un numero
--------------------------------------

Supponiamo di avere un numero x compreso tra 0 e 1. Vogliamo trovare un'approssimazione razionale per x, ma si desidera considerare solo le frazioni con denominatori al di sotto di un determinato valore N.
Ad esempio, supponiamo che x = 1/e = 0.367879...
Le approssimazioni razionali con potenze di 10 nel denominatore sono banali da trovare: 3/10, 36/100, 367/1000, ecc. Ma supponiamo di limitare il valore del denominatore ad un numero intero N=10. Esiste un'approssimazione migliore di 3/10? Sì, 3/8 = 0.375 è un'approssimazione migliore. Quando N=100, allora la frazione migliore vale 32/87 = 0,36781 (che è molto meglio di 36/100).
Come trovare la migliore approssimazione?
Per iniziare usiamo la ricerca con la forza bruta. Ad esempio, se la dimensione massima del denominatore è N, possiamo provare tutte le frazioni con denominatori inferiori o uguali a N.

La funzione è la seguente:

(define (frac x N)
  (local (num den err val)
    (setq err 999999)
    (for (i 1 N)
      (for (j (+ i 1) N)
        (setq val (abs (sub x (div i j))))
        (if (< val err)
            (begin
              (setq err val)
              (setq num i)
              (setq den j)
            ))
      )
    )
    (list num den)
  )
)

(frac 0.367879 100)
;-> (32 87)
(div 32 87)
;-> 0.367816091954023

(frac 0.605551 30)
;-> (17 28)

(frac 0.36 100)
;-> (9 25)
(div 9 25)
;-> 0.36

Nota: se abbiamo un numero x maggiore di 1 allora possiamo calcolare la frazione approssimatrice del suo inverso. Ad esempio se vogliamo calcolare una frazione per approssimare pi greco:

(setq pi (mul 2.0 (acos 0.0)))
;-> 3.141592653589793

Il suo inverso vale:

(div 1 3.141592653589793)
;-> 0.3183098861837907

L'inverso di un numero può essere calcolato più velocemente se non inseriamo 1 nella divisione:

(div 3.141592653589793)
;-> 0.3183098861837907

(frac 0.3183098861837907 1000)
;-> (113 355)

Vediamo quanto vale questa frazione (o meglio, il suo inverso):

(div 355 113)
;-> 3.141592920353983

L'errore vale:

(sub pi (div 355 113))
;-> -2.667641894049666e-007

Possiamo migliorare la precisione della frazione utilizzando un valore di N maggiore (ma non sempre):

(frac 0.3183098861837907 10000)
;-> (113 355)

In questo caso abbiamo ottenuto la stessa frazione approssimatrice. Anche con N=30000 otteniamo lo stesso risultato:

(frac 0.3183098861837907 50000)
;-> (113 355)

Proviamo con il primo esempio (1/e = 0.367879...) e poniamo N=10000:

(frac 0.367879 10000)
;-> (1143 3107)

Con N=1000 avevamo ottenuto:

(frac 0.367879 1000)
;-> (323 878)

Vediamo il valore degli errori in entrambi i casi:

(abs (sub 0.367879 (div 1143 3107)))
;-> 1.705825558584451e-008

(abs (sub 0.367879 (div 323 878)))
;-> 2.548974943061833e-006

Come previsto con N=10000 il risultato è più preciso.

Con questo metodo otteniamo sempre il risultato ottimo, ma possiamo usare solo valori di N minori di 100000, altrimenti il tempo di calcolo diventa molto lungo.
Esiste un algoritmo molto più efficiente che è correlato alla sequenza di Farey.
L'idea è di iniziare con due frazioni, a/b = 0/1 e c/d = 1/1. Aggiorniamo a/b oppure c/d ad ogni passaggio in modo che a/b sia il limite inferiore migliore di x con denominatore non più grande di b, e c/d sarà il limite superiore migliore con denominatore non più grande di d. Ad ogni passo facciamo una sorta di ricerca binaria introducendo il valore "mediant" dei limiti superiore e inferiore. Il valore di "mediant" di a/b e c/d è la frazione (a + c)/(b + d) che si trova sempre tra a/b e c/d.

Scriviamo la funzione:

(define (fraction x N)
  (catch
  (local (a b c d mediant)
    (setq a 0 b 1)
    (setq c 1 d 1)
    (while (and (<= b N) (<= d N))
      (setq mediant (div (+ a c) (+ b d)))
      (cond ((= x mediant)
             (if (<= (+ b d) N)
                 (throw (list (+ a c) (+ b d)))
                 (if (> d b)
                     (throw (list c d))
                     (throw (list a b)))))
            ((> x mediant)
             (setq a (+ a c))
             (setq b (+ b d)))
            (true
             (setq c (+ a c))
             (setq d (+ b d)))
      )
    )
    (if (> b N)
        (throw (list c d))
        (throw (list a b)))
  )))

Questo algoritmo è molto più veloce, ma non produce sempre il risultato ottimo:

(fraction 0.367879 100)
;-> (32 87)

(fraction 0.605551 30)
;-> (3 5)

Questo non è il risultato ottimo, infatti con la funzione "frac" avevamo ottenuto (17 28), che è un'approssimazione migliore per il numero 0.605551.
Inoltre possiamo migliorare l'espressione (= x mediant) con l'espressione:

(< (abs (sub x mediant)) epsilon)

dove epsilon (per esempio 1e-6) rappresenta il valore di accuratezza (infatti non si può determinare correttamente l'uguaglianza tra due numeri in virgola mobile).

Vediamo un altro esempio con il numero "e":

(exp 1)
;-> 2.718281828459045
(div (exp 1))
;-> 0.3678794411714423

(frac (div (exp 1)) 100)
;-> (32 87)
(div 87 32)
;-> 2.71875

(frac (div (exp 1)) 1000)
;-> (323 878)
(div 878 323)
;-> 2.718266253869969

(frac (div (exp 1)) 10000)
;-> (1001 2721)
(div 2721 1001)
;-> 2.718281718281718

Esistono altri metodi per calcolare l'approsimazione razionale di un numero (ad esempio utilizzando le frazioni continue), ma la scelta del metodo dipende dall'uso che vogliamo fare del risultato. In genere ricorriamo ad una frazione quando i numeri in virgola mobile non hanno la precisione che ci serve oppure per velocizzare il calcolo (usando numeri interi i calcoli sono molto più veloci).


----------------------------
Modificare le liste annidate
----------------------------

Per modificare una lista annidata possiamo usare la funzione "setf":

(setq lst '(a 0 (a 1 (b 2 3 4 (c 5 6 7)))))
;-> (a 0 (a 1 (b 2 3 4 (c 5 6 7))))

Adesso per modificare il valore del simbolo "c" possiamo calcolare il suo indice nella lista:

(setq r (ref 'c lst))
;-> (2 2 4 0)

E poi usare l'indicizzazione implicita:

(setf (lst r) 1311234123)
;-> 1311234123

lst
;-> (a 0 (a 1 (b 2 3 4 (1311234123 5 6 7))))


---------------------------------------
Criptare un file sorgente o un contesto
---------------------------------------

Supponiamo di avere un file "fenc.lsp" che contiene le seguenti funzioni:

(define (showinfo) (println "demo encrypt file"))

(define (somma x y) (add x y))

Per criptare questo file possiamo utilizzare la seguente espressione:

(write-file "fenc.enc" (encrypt (read-file "fenc.lsp") "password"))
;-> 106 ;numero di caratteri del file

Adesso possiamo eseguire una funzione dal file criptato nel modo seguente:

(eval-string (encrypt (read-file "fenc.enc") "password"))
;-> (lambda (x y) (add x y))

Viene restitutia solo l'ultima funzione valutata, ma possiamo eseguire qualunque funzione contenuta nel file "fenc.enc":

(showinfo)
;-> demo encrypt file
;-> "demo encrypt file"

(somma 10 4)
;-> 14

Per verificare se un simbolo esiste in un contesto possiamo usare la seguente espressione:

(sym "somma" 'MAIN nil)
;-> somma

(sym "showinfo" 'MAIN nil)
;-> showinfo

(sym "aaabbb" MAIN nil)
;-> nil

Per eliminare tutti i simboli (creati dall'utente) di un contesto possiamo scrivere:

(map delete (symbols 'MAIN))

In questo modo vengono cancellati solo i simboli del contesto che sono stati definiti dall'utente:
(sym "somma" 'MAIN nil)
;-> nil
(sym "showinfo" 'MAIN nil)
;-> nil
(sym "aaabbb" MAIN nil)
;-> nil
(sym "sin" MAIN nil)
;-> sin

Scriviamo due funzioni che salvano/caricano un contesto in/da un file criptato:

;;
;; Salva un contesto in un file criptato con password
;;
;; esempio:
;;
;; (save-encrypted "mycontext.enc" "password" 'MyCTX)
;;
(define (save-encrypted file-name pwd ctx)
  (save ".enctmp" ctx)
  (write-file file-name (encrypt (read-file ".enctmp") pwd))
  (delete-file ".enctmp"))

;;
;; Carica/valuta un file sorgente criptato
;;
;; esempio:
;;
;; (load-encrypted "mycontext.enc" "password")
;;
(define (load-encrypted file-name pwd)
  (write-file ".enctmp" (encrypt (read-file file-name) pwd))
  (load ".enctmp")
  (delete-file ".enctmp"))

Nota: il contesto caricato non deve contenere la funzione "load-encrypted".
L'overload di una funzione in esecuzione provoca l'arresto anomalo del sistema. Inoltre, per un breve periodo di tempo i dati si trovano in un file ".enctmp" in forma non crittografata durante il salvataggio o il caricamento, ma questo file viene eliminato in seguito.


--------------------------
Leggere e stampare un file
--------------------------

Per stampare un file possiamo usare il codice seguente:

(setq fh (open "fenc.lsp" "read"))
(while (read-line fh)
  (setq tl (current-line))
  (println tl)
)
(close fh)
;-> 3
;-> ; demo encrypt file
;-> (define (showinfo) (println "demo encrypt file"))
;->
;-> (define (somma x y) (add x y))
;-> "(define (somma x y) (add x y))"
;-> true

Se vogliamo estrarre solo le linee uniche da un file di testo possiamo usare la seguente funzione:

(set 'uniqueLines '())
  (while (read-line inFile)
    (if (not (member (current-line) uniqueLines))
        (set 'uniqueLines (append uniqueLines (list (current-line))))))
  (close inFile)
  (map (lambda (aLine) (write-line aLine outFile)) uniqueLines)
  (close outFile)


-----------
Lisp reader
-----------

Un "Lisp reader" si riferisce a una procedura Lisp, vale a dire la funzione "read", che legge i caratteri da un flusso di input e li interpreta e li converte come rappresentazioni di oggetti Lisp (AST Abstract Syntax Tree).

In newLISP per valutare un file di testo possiamo usare due metodi:

1) (load "file.lsp")
2) (eval-string (read-file "file.lsp"))

L'unica differenza tra questi due metodi è che la funzione "load" legge il file e allo stesso tempo valuta le espressioni, mentre il secondo metodo legge interamente il file in una stringa e poi la valuta. In altre parole, "load" gestisce senza problemi anche file molto grandi perchè valuta le S-espressioni appena vengono lette, convertendo ed valutando al volo.

newLISP ha anche una funzione "eval" che funziona soltanto con il formato interno delle S-espressioni e non con le stringhe:

(setq x '(+ 3 4))
;-> (+ 3 4)
x
;-> (+ 3 4)
(eval x)
;-> 7

(eval-string "(+ 3 4)")
;-> 7

La seguente funzione simula (in modo semplificato) il comportamento della funzione "read" in Common Lisp:

(define (read readstr readret)
   (cond
      ((float readstr)
       (if (find "." readstr)
         (setq readret (float readstr))
         (setq readret (integer readstr))
       )
      )
      ((=(slice readstr 0 1)"(")
         (setq readret(eval-string(append "'" readstr)))
      )
      (true
         (setq readret (symbol readstr))
      )
   )
)


------------------------
Liste e vettori annidati
------------------------

La struttura dati di base è la lista, ma newLISP permette di utilizzare anche i vettori.
I vettori vengono dichiarati con la funzione "array".

*******************
>>> funzione ARRAY
*******************
sintassi: (array int-n1 [int-n2 ...] [list-init])
Crea un vettore con elementi int-n1, inizializzandolo facoltativamente con il contenuto di list-init. È possibile specificare fino a sedici dimensioni per matrici multidimensionali.

Internamente, newLISP crea vettori multidimensionali usando vettori come elementi di un vettore. I vettori/matrici in newLISP devono essere utilizzati ogni volta che l'indicizzazione casuale in un grande lista diventa troppo lenta. Non tutte le funzioni delle liste possono essere utilizzate sui vettori. Per una discussione più dettagliata, consultare il capitolo sui vettori.

(array 5)
;-> (nil nil nil nil nil)

(array 5 (sequence 1  5))
;-> (1 2 3 4 5)

(array 10 '(1 2))
;-> (1 2 1 2 1 2 1 2 1 2)

I vettori possono essere inizializzati con oggetti di qualsiasi tipo. Se vengono forniti meno inizializzatori rispetto agli elementi, l'elenco viene ripetuto fino a quando non vengono inizializzati tutti gli elementi del vettore.

(set 'myarray (array 3 4 (sequence 1 12)))
;-> ((1 2 3 4) (5 6 7 8) (9 10 11 12))

I vettori vengono modificati e sono accessibili utilizzando la maggior parte delle stesse funzioni utilizzate per modificare le litse:

(setf (myarray 2 3) 99) → 99)
myarray
;-> ((1 2 3 4) (5 6 7 8) (9 10 11 99))

(setf (myarray 1 1) "hello")
;-> "hello"
myarray
;-> ((1 2 3 4) (5 "hello" 7 8) (9 10 11 99))

(setf (myarray 1) '(a b c d))
;-> (a b c d)
myarray
;-> ((1 2 3 4) (a b c d) (9 10 11 99))

(nth 1 myarray)
;-> (a b c d)  ; access a whole row

;; use implicit indexing and slicing on arrays

(myarray 1)
;-> (a b c d)

(myarray 0 -1)
;-> 4

(2 myarray)
;-> ((9 10 11 99))

(-3 2 myarray)
;-> ((1 2 3 4) (a b c d))

Bisogna fare attenzione ad usare un vettore quando si sostituisce un'intera riga. La funzione "array-list" può essere usata per riconvertire i vettori in liste:

(array-list myarray)
;-> ((1 2 3 4) (a b c d) (1 2 3 99))

Per riconvertire un elenco in una lista, applicare la funzione "flat" alla lista:

(set 'aList '((1 2) (3 4)))
;-> ((1 2) (3 4))

(set 'aArray (array 2 2 (flat aList)))
;-> ((1 2) (3 4))

La funzione "array?" viene usata per determinare se un'espressione è un vettore:

(array? myarray)
;-> true

(array? (array-list myarray))
;-> nil

Quando si serializzano i vettori usando la funzione "source" o "save", il codice generato include l'istruzione array necessaria per crearli. In questo modo, le variabili che contengono il vettore vengono serializzate correttamente quando si salva con "save" o si creano stringhe di sorgente usando "source".

(set 'myarray (array 3 4 (sequence 1 12)))

(save "array.lsp" 'myarray)

;; Contenuto del file array.lsp ;;

(set 'myarray (array 3 4 (flat '(
  (1 2 3 4)
  (5 6 7 8)
  (9 10 11 12)))))

I vettori possono contenere tipi di dati diversi:

(setq vet (array 10 '(1 2)))
;-> (1 2 1 2 1 2 1 2 1 2)
(vet 1)
;-> 2
(setf (vet 1) "a")
;-> "a"
vet
;-> (1 "a" 1 2 1 2 1 2 1 2)

Considerando le strutture dati annidate possiamo avere i seguenti accoppiamenti di base:

1) lista di liste
2) lista di vettori
3) vettore di liste
4) vettore di vettori (matrici)

Vediamo con semplici esempi il loro uso caso per caso.

Lista di Liste
--------------
Definiamo una lista di liste:

(setq lst-lst '((1 2) (a b) ("c" "d")))

Possiamo accedere agli elementi di questa struttura con l'indicizzazione implicita:

(lst-lst 1)
;-> (a b)

(lst-lst 2 0)
;-> "c"

Per modificare un elemento usiamo ancora l'indicizzazione implicita con la funzione "setf":

(setf (lst-lst 1) 9)
;-> 9
lst-lst
;-> ((1 2) 9 ("c" "d"))

(setf (lst-lst 2 0) "z")
;-> "z"
lst-lst
;-> ((1 2) 9 ("z" "d"))

Per aggiungere un elemento alla lista usiamo la funzione "push":

(push '(k1 k2) lst-lst -1)
;-> ((1 2) 9 ("z" "d") (k1 k2))

Lista di Vettori
----------------
Definiamo tre vettori:

(setq vet1 (array 2 '(1 2)))
;-> (1 2)

(setq vet2 (array 2 '(a b)))
;-> (a b)

(setq vet3 (array 2 '("c" "d")))
;-> ("c" "d")

Definiamo una lista che contiene i tre vettori:

(setq lst-vet (list vet1 vet2 vet3))
;-> ((1 2) (a b) ("c" "d"))

(lst-vet 1)
;-> (a b)

Comunque in questo modo i vettori vengono trasformati in liste all'interno della lista che li contiene:

(array? (lst-vet 1))
;-> nil
(list? (lst-vet 1))
;-> true

Proviamo ad utilizzare la funzione "push" per creare la lista:

(setq lst-vet '())
;-> ()
(push vet1 lst-vet -1)
;-> ((1 2))
(push vet2 lst-vet -1)
;-> ((1 2) (a b))
(push vet3 lst-vet -1)
;-> ((1 2) (a b) ("c" "d"))
lst-vet
;-> ((1 2) (a b) ("c" "d"))

In questo modo i vettori rimangono tali all'interno della lista globale:

(array? (lst-vet 1))
;-> true
(list? (lst-vet 1))
;-> nil

Anche in questo caso possiamo accedere agli elementi di questa struttura con l'indicizzazione implicita (anche se con una sintassi leggermente diversa dovuta al fatto che usiamo i vettori):

(lst-vet 1)
;-> (a b)

((lst-vet 1) 0)
;-> a

Per modificare un elemento usiamo ancora l'indicizzazione implicita con la funzione "setf":

(setf ((lst-vet 1) 0) 'z)
;-> z
lst-vet
;-> ((1 2) (z b) ("c" "d"))

(setf ((lst-vet 2) 0) "z")
;-> "z"
lst-vet
;-> ((1 2) (z b) ("z" "d"))

Per aggiungere un elemento alla lista usiamo la funzione "push":

(push '(k1 k2) lst-vet -1)
;-> ((1 2) 9 ("z" "d") (k1 k2))

(lst-vet 3)
;-> (k1 k2))

Attenzione, in questo modo abbiamo aggiunto una lista (k1 k2), non un vettore:

(list? (lst-vet 3))
;-> true

Vettore di Liste
----------------
Definiamo un vettore di liste inizializzando il vettore direttamente con il valore delle liste:

(setq vet-lst (array 4 '((1 2) (a b) (8 9) ("c" "d"))))
;-> ((1 2) (a b) (8 9) ("c" "d"))
(vet-lst 0)
;-> (1 2)

Verifichiamo che gli elementi del vettore siano delle liste:

(array? vet-lst)
;-> true
(list? (vet-lst 0))
;-> true

Per accedere ad un valore di una lista contenuta nel vettore usiamo l'indicizzazione implicita:

((vet-lst 0) 0)
;-> 1

Per modificare un valore di una lista contenuta nel vettore usiamo l'indicizzazione implicita:

(setf ((vet-lst 0) 0) "0")
;-> "0"

vet-lst
;-> (("0" 2) (a b) (8 9) ("c" "d"))

Per aggiungere un valore ad una lista contenuta nel vettore usiamo l'indicizzazione implicita:

(vet-lst 1)
;-> (a b)

(push 'c (vet-lst 1) -1)
;-> (a b c)
vet-lst
;-> (("0" 2) (a b c) (8 9) ("c" "d"))

Vettore di vettori
------------------
In questo caso stiamo parlando di una matrice, che viene gestita come un vettore con i relativi indici.

Infine scriviamo una funzione che permette di accedere a tutti gli elementi di una lista annidata (uno x uno):

(define (walk-tree tree-list)
    (dolist (elmnt tree-list)
        (if (list? elmnt)
            (walk-tree elmnt)
            (do-something-to elmnt))))

Sostituiamo "do-something-to" con la funzione "print":

(define (walk-tree tree-list)
    (dolist (elmnt tree-list)
        (if (list? elmnt)
            (walk-tree elmnt)
            (print elmnt { }))))

(walk-tree '(a b (c d (e f) g) h i))
;-> a b c d e f g h i " "

(walk-tree '(a (b (c (d (e (f (g (h (i))))))))))
;-> a b c d e f g h i " "

Il nome della funzione "walk-tree" è dovuto al fatto che la lista può rappresentare un albero, come nel seguente esempio:

           A
          / \
         /   \
        /     \
       B       C
      / \     / \
     /   \   /   \
    D     E ()    F
                 / \
                /   \
               G    ()

(setq tree '(A (B (D () ()) (E () ())) (C () (F (G () ()) ()))))

(walk-tree tree)
;-> A B D E C F G nil

La funzione "walk-tree" attraversa l'albero nello stesso ordine della funzione "(bst-traverse-preorder tree)" che abbiamo visto nella sezione dedicata agli alberi binari:

(bst-traverse-preorder tree)
;-> (A B D E C F G)


------------------------------------------------
Conversione di un numero da una base ad un'altra
------------------------------------------------

https://cs.stackexchange.com/questions/10318/the-math-behind-converting-from-any-base-to-any-base-without-going-through-base/10321

Per convertire un numero da una base ad un'altra base dobbiamo fare una considerazione astratta: un numero non è la sua rappresentazione numerica.
Un numero è un oggetto matematico astratto, mentre la sua rappresentazione numerica è una cosa concreta, vale a dire una sequenza di simboli su un foglio (o una sequenza di bit in memoria, o una sequenza di suoni che emettiamo quando comunichiamo un numero). Ciò che confonde è il fatto che non vediamo mai un numero, ma sempre la sua rappresentazione numerica. Quindi finiamo per pensare che il numero sia la rappresentazione.

Pertanto, la domanda corretta da porre non è "come convertire da una base all'altra", ma piuttosto "come faccio a scoprire quale numero è rappresentato da una determinata lista di cifre" e "come trovo la rappresentazione delle cifre di un dato il numero ".

Scriviamo due funzioni, una per convertire una rappresentazione numerica in un numero e un'altra per fare il contrario.
Nota: quando eseguiamo la funzione sullo schermo verrà visualizzato il numero ottenuto nella base 10, ma questo non significa che il computer mantenga i numeri nella base 10 (infatti non è così). Non è rilevante il modo in cui il computer rappresenta i numeri.

(define (todigits n b)
; Converte un numero positivo n nelle cifre della rappresentazione in base b
  (let (digits '())
    (while (> n 0)
      (push (% n b) digits)
      (setq n (/ n b))
    )
    digits))

(todigits 10 2)
;-> (1 0 1 0)

(define (fromdigits digits b)
; Calcola il numero rappresentato dalle cifre (digits) in base b
  (let (n 0)
    (dolist (x digits)
      (setq n (+ (* b n) x))
    )))

(todigits 84 2)
;-> (1 0 1 0 1 0 0)
(todigits 84 3)
;-> (1 0 0 1 0)
(fromdigits '(1 0 0 1 0) 3)
;-> 84

(todigits 100 16)
;-> (6 4)
(fromdigits '(6 4) 16)
;-> 100

(todigits 92 3)
;-> (1 0 1 0 2)
(fromdigits '(1 0 1 0 2) 3)
;-> 92

(fromdigits '(1 0 1 0 2) 4)
;-> 274
(todigits 274 4)
;-> (1 0 1 0 2)

Utilizzando queste due funzioni possiamo scrivere la funzione che risolve il problema:

(define (convert-base digits b c)
; Converte le cifre che rappresentano un numero in base b
; nele cifre che rappresentano il numero in base c
  (todigits (fromdigits digits b) c))

(convert-base '(1 1 2 0) 3 2)
;-> (1 0 1 0 1 0)

Nota: la conversione non passa attraverso una rappresentazione in base 10. Abbiamo convertito la rappresentazione di base b nel numero, quindi il numero in base c. Il numero non era in nessuna rappresentazione (a parte quella interna del computer).

Per rappresentare le cifre contenute in digits in una simbologia standard (0..Z) possiamo usare la funzione seguente:

(define (tosymbol digits b)
; Rappresenta la rappresentazione delle cifre in base b in un simbolo
; valore massimo per la base b = 36
  (local (alfabeto simbolo)
    (setq alfabeto '(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))
    (setq simbolo "")
    (dolist (s digits)
      (setq simbolo (string simbolo (alfabeto s)))
    )
    simbolo))

(length alfabeto)
(todigits 10 2)
;-> (1 0 1 0)
(tosymbol '(1 0 1 0) 2)
"1010"

(todigits 31 16)
;-> (1 15)
(fromdigits '(1 15) 16)
;-> 31
(tosymbol '(1 15) 16)
"1F"

(todigits 255 16)
;-> (15 15)
(tosymbol '(15 15) 16)
"FF"


-------------------------------------------
Convertire una stringa in un numero univoco
-------------------------------------------

Data una stringa di lunghezza n costituita da alcuni dei seguenti caratteri  0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ determinare un algoritmo che converte la stringa in un numero univoco. In altre parole, due stringhe differenti devono produrre numeri differenti.

Naturalmente, poichè i numeri interi sono limitati (MAXINT 9223372036854775807) la lunghezza della stringa deve essere inferiore ad un certo valore.

Il nostro algoritmo assegna il numero nel modo seguente:

(setq alfabeto '(0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z))

La stringa "A6HJ92B" si trasforma nel numero:

10×36⁶ + 6×36⁵ + 17×36⁴ + 19×36³ + 9×36² + 2×36 + 11 = 22160072099.

Quindi la funzione è la seguente:

(define (str-int str)
  (local (alfabeto pot n)
    ; valore massimo della potenza
    (setq pot (- (length str) 1))
    (setq alfabeto '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"))
    (setq n 0)
    (dolist (ch (explode str))
      (setq n (+ n (* (find ch alfabeto) (pow 36 (- pot $idx)))))
    )
    n
  )
)

(str-int "A6HJ92B")
;-> 22160072099

(str-int "MASSIMO")
;-> 48542232912

Un numero negativo come risultato indica un overflow nella conversione:

(str-int "DFHASFHASFGHASDFJASDHASDDF")
;-> -3908018479449362464


------
Reduce
------

Il LISP ha la funzione "reduce" che applica una funzione "tra" gli elementi di una lista. Prende il nome dal fatto che riduce la lista ad un singolo elemento. Questo risultato viene ottenuto applicando la funzione ai primi due elementi della lista, poi applicando la funzione al risultato e al terzo elemento della lista, ecc.

In newLISP possiamo scrivere (funzione è stata proposta da nigelbrown):

(define (reduce funct lst)
  (cond
    ;;no elements - return nil
    ((not lst) nil)
    ;; one element - return it
    ((not (rest lst)) (first lst))
    ;; more than one element - recurse
    (true (apply funct (list (first lst) (my-reduce funct (rest lst)))))))

(reduce 'append '((A B) (C D) (E F G) () (H I)))
;-> (A B C D E F G H I)

(reduce '+ '(1 3 4 5))
;-> 13

(reduce 'gcd '(12 32 16))
;-> 4

Attualmente newLISP ha integrato la funzionalità di "reduce" nella funzione "apply":

(apply 'append '((A B) (C D) (E F G) () (H I)))

(apply '+ '(1 3 4 5))
;-> 13

(apply 'gcd '(12 32 16))
;-> 4

(apply 'append '((A B) (C D) (E F G) () (H I)))

Inoltre, possiamo anche specificare il numero di parametri che utilizza la funzione ogni volta che applica la riduzione. Per esempio, se vogliamo usare una funzione che utilizza tre parametri possiamo scrivere:

(define (tri a b c) (+ a b c))

(tri 1 2 3)
;-> 6

Adesso riduciamo la lista utilizzando tre parametri (elementi) per volta:

(apply 'tri '(1 2 3 4 5 6 7) 3)
;-> 28

(1 + 2 + 3) = 6
6 + (4 + 5) = 15
15 + (6 + 7) = 28

Attenzione, la funzione "tri" vuole sempre tre parametri:

(apply 'tri '(1 2 3 4 5 6 7) 2)
;-> ERR: value expected in function + : c
;-> called from user function (tri 1 2)


-----------------
Quadrati nascosti
-----------------

Dato un numero intero n non negativo, determinare quanti quadrati perfetti esistono leggendo le cifre da sinistra a destra.

Esempio:

n = 1625649
quadrati perfetti: (165649 169 16 169 16 1 625 64 256 25 64 49 4 9)

165649 -> (1)(6)2(5)(6)(4)(9)
169    -> (1)(6)2564(9)
16     -> (1)(6)25649
169    -> (1)625(6)4(9)
16     -> (1)(6)25649
1      -> (1)625649
625    -> 1(6)(2)(5)649
64     -> 1(6)256(4)9
256    -> 16(2)(5)(6)49
25     -> 16(2)(5)649
64     -> 1625(6)(4)9
49     -> 16256(4)(9)
4      -> 16256(4)9
9      -> 162564(9)

Da notare che un quadrato perfetto può comparire più di una volta (16, 64 e 169)

La funzione che calcola l'insieme potenza genera tutti i numeri:

(define (powerset lst)
  (if (empty? lst)
      (list '())
      (let ( (element (first lst))
             (p (powerset (rest lst))))
           (append (map (fn (subset) (cons element subset)) p) p) )))

(powerset '(a b c))
;-> ((a b c) (a b) (a c) (a) (b c) (b) (c) ())

Prima dobbiamo scomporre il numero in una lista di cifre-stringa:

(powerset (explode (string 162)))
;-> (("1" "6" "2") ("1" "6") ("1" "2") ("1") ("6" "2") ("6") ("2") ())

Poi ci serve una funzione che ricompone ogni numero rappresenta come cifra-stringa:

(define (lst2int lst) (int (join lst)))

(lst2int '("1" "2" "3"))
;-> 123

(lst2int '())
;-> nil

Poi utilizziamo una funzione che verifica se un numero è un quadrato perfetto:

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(square? 25)
;-> true
(square? 0)
;-> true

Adesso possiamo scrivere la funzione finale:

(define (hidden-square n)
  (local (lst num out)
    (setq out '())
    (setq lst (powerset (explode (string n))))
    (dolist (el lst)
      ;(println el)
      (setq num (lst2int el))
      (if (and num (square? num))
        (push num out -1)
      )
    )
    out))

Proviamo con il numero dell'esempio:

(hidden-square 1625649)
;-> (165649 169 16 169 16 1 625 64 256 25 64 49 4 9)

(hidden-square 1234567890)
;-> (13456 134689 13689 1369 169 16 1 256 25 289 36 49 4 9 0)

Attenzione ai numeri con diversi 1 e 0:

(hidden-square 11110000)
;-> (10000 100 100 100 100 100 100 1 10000 100 100 100 100
;->  100 100 1 10000 100 100 100 100 100 100 1 10000 100 100
;->  100 100 100 100 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)


-----------------
Push, cons e list
-----------------

Vediamo alcune differenze nell'applicazione delle funzioni "push", "cons" e "list". Consideriamo le seguenti operazioni:
1) aggiunta di un elemento ad una lista
2) aggiunta di una lista ad un'altra lista

Primo caso
----------
Aggiungiamo un elemento all'inizio di una lista:

(push 1 '(2 3))
;-> (1 2 3)
(cons 1 '(2 3))
;-> (1 2 3)
(list 1 '(2 3))
;-> (1 (2 3))

Aggiungiamo un elemento in fondo ad una lista:

(push 1 '(2 3) -1)
;-> (2 3 1)
(cons '(2 3) 1)
;-> ((2 3) 1)
(list '(2 3) 1)
;-> ((2 3) 1)

Secondo caso
------------
Aggiungiamo una lista ad un'altra lista:

(push '(1 2) '(3 4))
;-> ((1 2) 3 4)
(cons '(1 2) '(3 4))
;-> ((1 2) 3 4)
(list '(1 2) '(3 4))
;-> ((1 2) (3 4))


-------------
Append esteso
-------------

Vediamo la definizione del manuale della funzione "append":

*******************
>>>funzione APPEND
*******************
sintassi: (append list-1 [list-2 ... ])
sintassi: (append array-1 [array-2 ... ])
sintassi: (append str-1 [str-2 ... ])

Nella prima forma, append funziona con le liste, appendendo le liste list-1 fino a list-nn per formare una nuova lista. Le liste originali non vengono modificate.

(append '(1 2 3) '(4 5 6) '(a b))
;-> (1 2 3 4 5 6 a b)

(set 'aList '("hello" "world"))
;-> ("hello" "world")

(append aList '("here" "I am"))
;-> ("hello" "world" "here" "I am")

Nella seconda forma "append" funziona con i vettori:

(set 'A (array 3 2 (sequence 1 6)))
;-> ((1 2) (3 4) (5 6))
(set 'B (array 2 2 (sequence 7 10)))
;-> ((7 8) (9 10))

(append A B)
;-> ((1 2) (3 4) (5 6) (7 8) (9 10))

(append B B B)
;-> ((7 8) (9 10) (7 8) (9 10) (7 8) (9 10))

Nella terza forma, "append" funziona con le stringhe. Le stringhe in str-n vengono concatenate in una nuova stringa e poi viene restituita.

(set 'more " how are you")
;-> " how are you"

(append "Hello " "world," more)
;-> "Hello world, how are you"

"append" è anche adatta per l'elaborazione di stringhe binarie contenenti zeri. La funzione "string" taglierà le stringhe con zero byte.

È possibile unire caratteri o stringhe utilizzando la funzione "join". Utilizzare la funzione "string" per convertire gli argomenti in stringhe e appenderle in un solo passaggio.

Utilizzare le funzioni "extend" e "push" per appendere ad una lista esistente o ad una stringa modificando la destinazione.

Questa funzione non permette di inserire liste nulle:

(setq a '(1 2))
(append a '(3) '(4) '(5))
;-> (1 2 3 4 5)

(append b '(3) '(4) '(5))
;-> ERR: array, list or string expected in function append : nil

Scriviamo una funzione che permette di utilizzare liste nulle (nil):

(define (append-nil alist )
   (if alist
      (begin
      (setq _nlst alist)
      (dolist (_lst (args))(setq _nlst(append _nlst _lst))))
      (begin
      (setq _nlst (list ))
      (dolist (_lst (args))(setq _nlst(append _nlst _lst))))
   ))

(setq a '(1 2))
;-> (1 2)
(append-nil a '(3)'(4)'(5))
;-> (1 2 3 4 5)
(append-nil b '(3)'(4)'(5))
;-> (3 4 5)

Oppure, utilizzando 'apply append' al posto di 'dolist':

(define (append-nil alist)
  (if alist (append alist (apply append (args)))
            (apply append (args))))

(setq a '(1 2))
;-> (1 2)
(append-nil a '(3)'(4)'(5))
;-> (1 2 3 4 5)
(append-nil b '(3)'(4)'(5))
;-> (3 4 5)


-----------------------------------
newLISP Keywords (Parole riservate)
-----------------------------------

Possiamo ottenere la lista delle parole riservate (keywords) di newLISP con la seguente funzione:

(define (keywords)
  (let (k '())
    (dolist (s (symbols)) (if (primitive? (eval s)) (push s k)))
    ; dobbiamo aggiungere "nil" e "true" perchè:
    ; (primitive? (eval nil))  -> nil
    ; (primitive? (eval true)) -> nil
    (push 'true k)
    (push 'nil k)
    (sort k)))

(keywords)

Nota: i simboli "nil" e "true" non vengono ordinati

(setq a '(nil true b a))
(sort a)
;-> (nil true a b)

Possiamo superare il problema nel modo seguente:

(setq lst '(true nil true b a))
(map sym (sort (map string lst)))
;-> (a b nil true true)


--------------------------------------
Estrazione di dati da un file di testo
--------------------------------------

Supponiamo di voler estrarre tutti i numeri contenuti in un testo (file o stringa).
Un trucco è quello di utlizzare la funzione "replace" con una espressione regolare nel modo seguente:

; Impostare il testo da analizzare
; per un file
(setq txt (read-file "myfile.txt"))
; per una stringa
(setq txt "11 testo 11n1 1000 01 numeri 28 39 20 non 56")
; per una riga csv
(setq txt "11,testo,11,n,1,1000,01,numeri,28,39,20,non,56")

; Impostare il modello (pattern) dell'espressione regolare
; Solo numeri (anche quelli che iniziano con 0)
(setq expr {[0-9]+})
; Solo numeri (senza quelli che iniziano con 0)
(setq expr {[1-9][0-9]+})

; Inizializzare la lista che conterrà i numeri (stringa)
(setq tokens '())

; Utilizzare la funzione "replace"
(replace expr txt (push $0 tokens -1) 0)

; Visualizzare il risultato
; la lista tokens contiene tutti i numeri (token) trovati
tokens

L'elaborazione viene eseguita dall'espressione "replace" che inserisce il numero (token) trovato alla fine della lista e restituisce il numero stesso, quindi "txt" rimarrà invariato al termine.
In altri termini, "replace" è la funzione che analizza il testo.

Vediamo un esempio completo:

(setq txt "11,testo,11,n,1,1000,01,numeri,28,39,20,non,56")
(setq expr {[0-9]+})
(setq tokens '())
(replace expr txt (push $0 tokens -1) 0)
tokens
;-> ("11" "11" "1" "1000" "01" "28" "39" "20" "56")


----------------------------
File di testo windows e unix
----------------------------

In windows il terminatore di ogni linea di un file di testo vale "\r\n".
In unix/linux il terminatore di ogni linea di un file di testo vale "\n".
Per scrivere un file di testo in windows con il terminatore di unix possiamo usare la seguente macro proposta da Lutz:

(define-macro (println-unix)
    (apply print (map eval (args)))
    (print "\n"))

Proviamo:

(device (open "newfile.txt" "write"))
;-> 3
(println-unix "prima riga")
;-> "\n"
(println-unix "seconda riga")
(close (device))
;-> true

Adesso il file "newfile.txt" ha il terminatore di linea di tipo unix. Con notepad++ possiamo verificarlo tramite il menu Edit -> EOL Conversion.


-----
CRC32
-----

Il "cyclic redundancy check" (ovvero controllo di ridondanza ciclico, acronimo CRC) è un metodo per il calcolo di somme di controllo (checksum in inglese). Il controllo CRC viene usato per l'individuazione di errori casuali nella trasmissione dati (a causa di interferenze, rumore di linea, distorsione). Il metodo non è invece affidabile per verificare la completa correttezza dei dati contro tentativi intenzionali di manomissione. A questo scopo è meglio usare altri algoritmi di hash quali MD5 e SHA1.

NewLISP ha una funzione integrata per il calcolo del CRC:

******************
>>>funzione CRC32
******************
sintassi: (crc32 str-data)
Calcula il CRC a 32-bit dal buffer di str-data, iniziando con un valore di CRC uguale a 0xffffffff per il primo byte. "crc32" usa un algoritmo pubblicvato da www.w3.org.

(crc32 "abcdefghijklmnopqrstuvwxyz")
;-> 1277644989

La funzione "crc32" viene spesso utilizzato per verificare l'integrità dei dati nelle trasmissioni di dati non sicure.

Nel forum di newLISP l'utente Sammo ha proposto la seguente versione:

;;   crc32
;;   adapted from CMUCL code written by R. Matthew Emerson
;;   <rme@acm.org> in August 1999 and placed in the public domain
;;
;;   examples and test cases
;;   (format "%08X" (crc "ABC")) --> A3830348
;;   (format "%08X" (crc "abc")) --> 352441C2
;;   (format "%08X" (crc "123456789")) --> CBF43926
;;

(define (my-crc32 buf)
   (update-crc32 0 buf) )

(define (update-crc32 crc buf , i)
   (set 'crc (^ crc 0xFFFFFFFF))
   (dotimes (n (length buf))
      (set 'i (& 0xFF (^ crc (char buf n))))
      (set 'crc (^ (nth i CRC32-TABLE) (>> (& 0x7FFFFFFF (>> crc 1)) 7))) )
   (^ crc 0xFFFFFFFF) )

(setq CRC32-TABLE
   '(0x00000000 0x77073096 0xEE0E612C 0x990951BA 0x076DC419 0x706AF48F
     0xE963A535 0x9E6495A3 0x0EDB8832 0x79DCB8A4 0xE0D5E91E 0x97D2D988
     0x09B64C2B 0x7EB17CBD 0xE7B82D07 0x90BF1D91 0x1DB71064 0x6AB020F2
     0xF3B97148 0x84BE41DE 0x1ADAD47D 0x6DDDE4EB 0xF4D4B551 0x83D385C7
     0x136C9856 0x646BA8C0 0xFD62F97A 0x8A65C9EC 0x14015C4F 0x63066CD9
     0xFA0F3D63 0x8D080DF5 0x3B6E20C8 0x4C69105E 0xD56041E4 0xA2677172
     0x3C03E4D1 0x4B04D447 0xD20D85FD 0xA50AB56B 0x35B5A8FA 0x42B2986C
     0xDBBBC9D6 0xACBCF940 0x32D86CE3 0x45DF5C75 0xDCD60DCF 0xABD13D59
     0x26D930AC 0x51DE003A 0xC8D75180 0xBFD06116 0x21B4F4B5 0x56B3C423
     0xCFBA9599 0xB8BDA50F 0x2802B89E 0x5F058808 0xC60CD9B2 0xB10BE924
     0x2F6F7C87 0x58684C11 0xC1611DAB 0xB6662D3D 0x76DC4190 0x01DB7106
     0x98D220BC 0xEFD5102A 0x71B18589 0x06B6B51F 0x9FBFE4A5 0xE8B8D433
     0x7807C9A2 0x0F00F934 0x9609A88E 0xE10E9818 0x7F6A0DBB 0x086D3D2D
     0x91646C97 0xE6635C01 0x6B6B51F4 0x1C6C6162 0x856530D8 0xF262004E
     0x6C0695ED 0x1B01A57B 0x8208F4C1 0xF50FC457 0x65B0D9C6 0x12B7E950
     0x8BBEB8EA 0xFCB9887C 0x62DD1DDF 0x15DA2D49 0x8CD37CF3 0xFBD44C65
     0x4DB26158 0x3AB551CE 0xA3BC0074 0xD4BB30E2 0x4ADFA541 0x3DD895D7
     0xA4D1C46D 0xD3D6F4FB 0x4369E96A 0x346ED9FC 0xAD678846 0xDA60B8D0
     0x44042D73 0x33031DE5 0xAA0A4C5F 0xDD0D7CC9 0x5005713C 0x270241AA
     0xBE0B1010 0xC90C2086 0x5768B525 0x206F85B3 0xB966D409 0xCE61E49F
     0x5EDEF90E 0x29D9C998 0xB0D09822 0xC7D7A8B4 0x59B33D17 0x2EB40D81
     0xB7BD5C3B 0xC0BA6CAD 0xEDB88320 0x9ABFB3B6 0x03B6E20C 0x74B1D29A
     0xEAD54739 0x9DD277AF 0x04DB2615 0x73DC1683 0xE3630B12 0x94643B84
     0x0D6D6A3E 0x7A6A5AA8 0xE40ECF0B 0x9309FF9D 0x0A00AE27 0x7D079EB1
     0xF00F9344 0x8708A3D2 0x1E01F268 0x6906C2FE 0xF762575D 0x806567CB
     0x196C3671 0x6E6B06E7 0xFED41B76 0x89D32BE0 0x10DA7A5A 0x67DD4ACC
     0xF9B9DF6F 0x8EBEEFF9 0x17B7BE43 0x60B08ED5 0xD6D6A3E8 0xA1D1937E
     0x38D8C2C4 0x4FDFF252 0xD1BB67F1 0xA6BC5767 0x3FB506DD 0x48B2364B
     0xD80D2BDA 0xAF0A1B4C 0x36034AF6 0x41047A60 0xDF60EFC3 0xA867DF55
     0x316E8EEF 0x4669BE79 0xCB61B38C 0xBC66831A 0x256FD2A0 0x5268E236
     0xCC0C7795 0xBB0B4703 0x220216B9 0x5505262F 0xC5BA3BBE 0xB2BD0B28
     0x2BB45A92 0x5CB36A04 0xC2D7FFA7 0xB5D0CF31 0x2CD99E8B 0x5BDEAE1D
     0x9B64C2B0 0xEC63F226 0x756AA39C 0x026D930A 0x9C0906A9 0xEB0E363F
     0x72076785 0x05005713 0x95BF4A82 0xE2B87A14 0x7BB12BAE 0x0CB61B38
     0x92D28E9B 0xE5D5BE0D 0x7CDCEFB7 0x0BDBDF21 0x86D3D2D4 0xF1D4E242
     0x68DDB3F8 0x1FDA836E 0x81BE16CD 0xF6B9265B 0x6FB077E1 0x18B74777
     0x88085AE6 0xFF0F6A70 0x66063BCA 0x11010B5C 0x8F659EFF 0xF862AE69
     0x616BFFD3 0x166CCF45 0xA00AE278 0xD70DD2EE 0x4E048354 0x3903B3C2
     0xA7672661 0xD06016F7 0x4969474D 0x3E6E77DB 0xAED16A4A 0xD9D65ADC
     0x40DF0B66 0x37D83BF0 0xA9BCAE53 0xDEBB9EC5 0x47B2CF7F 0x30B5FFE9
     0xBDBDF21C 0xCABAC28A 0x53B39330 0x24B4A3A6 0xBAD03605 0xCDD70693
     0x54DE5729 0x23D967BF 0xB3667A2E 0xC4614AB8 0x5D681B02 0x2A6F2B94
     0xB40BBE37 0xC30C8EA1 0x5A05DF1B 0x2D02EF8D))

Proviamo:

(my-crc32 "abcdefghijklmnopqrstuvwxyz")
;-> 1277644989


-------------------
Mescolare le parole
-------------------

Una ricerca dell'Universita di Cambridge, ha scoperto che non è importante in quale ordine appaiono le lettere di una parola o di una frase, ma l'unica cosa importante è che la prima e l'ultima lettera siano al posto giusto. Il resto può essere totalmente casuale e saremmo in grado di leggere la parola o la frase senza problemi. Questo perchè la mente umana non legge le singole lettere, ma l'intera parola.

Per verificare questa ricerca usiamo due funzioni: la prima che cambia l'ordine dei caratteri di una parola e la seconda che fa lo stesso con tutte le parole di una frase.

; mescola i caratteri di una parola (es. "hello" -> "hlelo")
; written by Fanda
(define (mix str)
  (if (> (length str) 3)
    (append (str 0) (join (randomize (explode (1 (- (length str) 2) str)))) (str -1))
    str))

; mescola i caratteri delle parole di una frase
; written by Fanda
(define (jumble str)
  (let (w "" break ",. -:?!()[]{}+/\|=*&^%$#@!~`'<>" result "")
    (dolist (c (explode str))
      (if (find c break)
        (begin
          (write-buffer result (append (mix w) c))
          (setq w ""))
        (write-buffer w c)))
    (write-buffer result (mix w))
    result))

(setq str "Una ricerca dell'Universita di Cambridge, ha scoperto che non è importante in quale ordine appaiono le lettere di una parola o di una frase, ma l'unica cosa importante è che la prima e l'ultima lettera siano al posto giusto. Il resto può essere totalmente casuale e saremmo in grado di leggere la parola o la frase senza problemi. Questo perchè la mente umana non legge le singole lettere, ma l'intera parola.")

(println "\n" (jumble str) "\n")
;-> Una rirccea dlel'Unrvtseiia di Crdmibage, ha sropetco che non è iprtmantoe in qlaue odnrie ainaoppo le ltteere di una poarla o di una fsrae, ma l'uicna csoa intaotpmre è che la pimra e l'uimtla ltetera sinao al pstoo gituso. Il rtseo può eersse ttaontmele casaule e srmmaeo in gdaro di lergege la proala o la fsare szena preolbmi. Qetuso pcehrè la metne unama non legge le soginle leertte, ma l'iertna porala.


-------------------
Parsing di stringhe
-------------------

Per fare il parsing di stringhe newLISP mette a disposizione la funzione "parse".

******************
>>>funzione PARSE
******************
sintassi: (parse str-data [str-break [regex-option]])

Divide la stringa risultante dalla valutazione di str-data in token stringa, che vengono quindi restituiti in una lista. Quando non viene fornita alcuna interruzione di stringa "str-break", l'analisi tokenizza secondo le regole di analisi interne di newLISP. Una stringa può essere specificata in "str-break" per la tokenizzare solo al verificarsi di una stringa. Se viene specificato un numero di "regex-regex" o una stringa, è possibile utilizzare un modello di espressione regolare in str-break.

Quando "str-break" non è specificato, la dimensione massima del token è 2048 per le stringhe tra virgolette e 256 per gli identificatori. In questo caso, newLISP utilizza lo stesso tokenizzatore veloce che utilizza per l'analisi dei sorgenti di newLISP. Se si specifica "str-break", non ci sono limiti alla lunghezza dei token. Viene utilizzato un algoritmo diverso che suddivide i dati della stringa di origine "str-data" quando si verifica la stringa "str-break".

; no break string specified
(parse "hello how are you")     → ("hello" "how" "are" "you")

; strings break after spaces, parentheses, commas, colons and numbers.
; Spaces and the colon are swollowed
(parse "weight is 10lbs")       →
(parse "one:two:three" ":")     → ("one" "two" "three")

;; specifying a break string
(parse "one--two--three" "--")  → ("one" "two" "three")

; a regex option causes regex parsing
(parse "one-two--three---four" "-+" 0)
→ ("one" "two" "three" "four")

(parse "hello regular   expression 1, 2, 3" {,\s*|\s+} 0)
→ ("hello" "regular" "expression" "1" "2" "3")

Gli ultimi due esempi mostrano un'espressione regolare come stringa di interruzione con l'opzione predefinita 0 (zero). Invece di { e } (parentesi graffe sinistra e destra), è possibile utilizzare virgolette doppie per limitare il modello/pattern. In questo caso, è necessario utilizzare doppie barre rovesciate all'interno del modello. L'ultimo modello potrebbe essere utilizzato per l'analisi dei file CSV (Comma Separated Values). Per i numeri relativi alle opzioni delle espressioni regolari, vedere regex.

L'analisi/parsing restituirà i campi vuoti attorno ai separatori come stringhe vuote:

; empty fields around separators returned as empty strings
(parse "1,2,3," ",") → ("1" "2" "3" "")
(parse "1,,,4" ",")  → ("1" "" "" "4")
(parse "," ",")      → ("" "")

(parse "")      → ()
(parse "" " ")  → ()

Questo comportamento è necessario durante l'analisi dei record con campi vuoti.

L'analisi di una stringa vuota comporterà sempre una lista vuota.

Utilizzare la funzione regex per spezzare le stringhe e le funzioni directory, find, find-all, regex, replace e search per utilizzare le espressioni regolari.

Possiamo anche usare la seguente funzione per fare il parsing di una stringa:

; Funzione Split
; written by Fanda

(define (parse-no-empty str c)
  (filter (lambda (x) (not (empty? x))) (parse str c)))

(define (split str-data str-break)
  (if (empty? str-break)
    (explode str-data)
    (begin
      (setq str-data (list str-data))
      (dolist (c (explode str-break))
        (setq str-data (flat (map (lambda (s) (parse-no-empty s c)) str-data)))))))


(split "Simple sentence, but useful!" ",! ")
;-> ("Simple" "sentence" "but" "useful")

(split "http://www.yahoo.com" ":/.")
;-> ("http" "www" "yahoo" "com")

(split "Hi++++Hello-----Bye!" "+-!")
;-> ("Hi" "Hello" "Bye")


--------------------------------------
Formattazione di elementi di una lista
--------------------------------------

Quando abbiamo una lista dei valori o variabili possiamo formattare la stampa di questi elementi (alcuni o tutti) utilizzando l'indicizzazione implicita nel modo seguente:

(setq lst '("bob" "this" "that" 3 2 10 "a" 96 "----" 456))
(println (format "%s,%d,%s,%d\n" (lst 0) (lst 4) (lst 1) (lst 7)))
;-> bob,2,this,96

Comunque possiamo anche usare la seguente funzione (scritta da Sammo) che permette di usare "select":

(define (myformat str) (apply format (cons str (flat (args)))))
(println (myformat "%s,%d,%s,%d\n" (select lst 0 4 1 7)))
;-> bob,2,this,96

(println (format "%s,%d,%s,%d\n" (select lst 0 4 1 7)))
;-> bob,2,this,96


-------------
Slice mapping
-------------

Il funzionamento della funzione "map" è il seguente:

(setq data '((1 2) (2 3) (3 4)))
;-> ((1 2) (2 3) (3 4))
(println (map first data))
;-> (1 2 3)

Adesso proviamo un'altra espressione:

(println (map 0 data))
;-> ((1 2) (2 3) (3 4))

e ancora

(println (map 1 data))
;-> ((2) (3) (4))

Per capire gli ultimi due risultati occorre sapere che la forma (idx lst) non rappresenta l'indicizzazione implicita (nth), ma lo "slice" implicito:

(0 '(1 2 3 4))
;-> (1 2 3 4)
(1 '(1 2 3 4))
;-> (2 3 4)
(1 2 '(1 2 3 4))
;-> (2 3)

Quindi (idx lst) applica la funzione "slice" alla lista lst partendo dall'indice idx.

L'indicizzazione implicita ha la forma (lst idx):

(setq data '(1 2 3 4 5))
;-> (1 2 3 4 5)
(data 0)
;-> 1
(data 1)
;-> 2

La funzione "map" applica sempre il primo parametro ad ogni elemento della lista che segue. Comunque è sempre possibile scrivere:

(setq data '(a b c d))
(map 'data '(3 2 1 0))
;-> (d c b a)

Notare che la lista data viene quotata perchè "map" valuta sempre il primo parametro prima di applicarlo (come fa anche l'indicizzazione implicita).
Lo "slice mapping" è utile per raccogliere tutti i primi elementi di una serie di liste e raccoglierli in un'altra lista.


--------------------------------------------
Valore minimo/massimo di una lista di numeri
--------------------------------------------

Il metodo standard per trovare il valore massimo di una lista di numeri è quello di usare la funzione "apply":

(setq num '(3 4 1 6 8 2 34 12 5 8 9 42 3))
(apply max num)
;-> 42

Ma esiste anche un altro metodo (unortodosso):

Inseriamo il simbolo max nella lista num:

(push max num)
;-> (max@40D985 3 4 1 6 8 2 34 12 5 8 9 42 3)

Valutiamo la lista (e troviamo il numero massimo):

(eval num)
;-> 42

Adesso dobbiamo togliere il simbolo "max" dalla lista:

(pop num)
;-> max@40D985
num
;-> (3 4 1 6 8 2 34 12 5 8 9 42 3)

Proviamo con la funzione "min":

(push min num)
;-> (min@40D972 3 4 1 6 8 2 34 12 5 8 9 42 3)
(eval num)
;-> 1
(pop num)
;-> min@40D972
num
;-> (3 4 1 6 8 2 34 12 5 8 9 42 3)

Misuriamo la velocità dei due metodi:

(define (test lst)
    (push max lst 0)
    (eval lst)
    (pop lst))

(time (test num) 1000000)
;-> 234.71

(time (apply max num) 1000000)
;-> 187.861

Inoltre se vogliamo usare una funzione dobbiamo anche restituire il valore, quindi dobbiamo scrivere:

(define (mymax lst)
  (let (out nil)
    (push max lst 0)
    (setq out (eval lst))
    (pop lst)
    out))

(mymax num)
;-> 42

(time (mymax num) 1000000)
;-> 359.282
num
;-> (3 4 1 6 8 2 34 12 5 8 9 42 3)

(time (apply max num) 1000000)
;-> 187.45

Il metodo normale è più veloce, ma il metodo unortodosso è interessante.


-------------------
Sommare una stringa
-------------------

In una stringa composta da cifre e altri caratteri non numerici, le cifre formano una serie di numeri interi positivi. Ad esempio, la stringa "123abc45def" contiene gli interi 123 e 45, la cui somma corrisponde a 168.
Scrivere un programma che accetta una stringa e restituisce la somma degli interi incorporati nella stringa.

; la stringa
(setq str "o123p010iru5")
; la lista che contiene i numeri della stringa
(setq numeri '())
; espressione regolare per individuare i numeri
(setq expr {[0-9]+})
; espressione che estrae i numeri dalla stringa
; e li inserisce nella lista numeri
(replace expr str (push $0 numeri -1) 0)
numeri
;-> ("123" "010" "5")

; conversione delle stringhe in interi e somma di tutti i numeri
; da notare che (int "010") -> 8 (ottale)
(apply + (map (fn (x) (int x 0 10)) numeri))
;-> 138

Adesso scriviamo la funzione finale:

(define (sumstr str)
  (local (numeri expr)
    (setq numeri '())
    (setq expr {[0-9]+})
    (replace expr str (push $0 numeri -1) 0)
    (apply + (map (fn (x) (int x 0 10)) numeri))
  ))

(sumstr "o123p010iru5")
;-> 138

(sumstr "0a0b0c0d")
;-> 0

(sumstr "")
;-> 0

Nel forum di newLISP l'utente fdb ha proposto queste due funzioni:

(define (parse-str str)
  (apply + (map int (clean empty? (parse str {[^0-9]} 0)))))

(parse-str "o123p010iru5")
;-> 136

(define (parse-str str)
  (let (total 0)
    (dolist (s (parse str {[^0-9]} 0))
      (unless (empty? s)
        (inc total (int s))))
    total))

Purtroppo queste non funzionano correttamente ci sono numeri con lo 0 iniziale (che vengono convertiti dalla funzione "int" in base ottale, invece che in base decimale).

Comunque l'ultima funzione di fdb è più veloce.

(time (parse-str "o123p010iru5") 100000)
;-> 184.9
(time (sumstr "o123p010iru5") 100000)
;-> 254.863

Altre funzione proposta da newBert:

 (apply + (map (fn (x) (int (if (starts-with x "0") (rest x) x))) (find-all {[0-9]+} "o123p010iru5")))
;-> 138

Altre funzioni (corrette) proposte da fdb:

(apply + (map int (find-all {[1-9][0-9]*} "o123p010iru5")))
;-> 138

(apply (fn(x y) (+ (int x) (int y))) (find-all {[1-9]\d*} "o123p0010iru5") 2)
;-> 138


-----------------
Numeri palindromi
-----------------

Trovare il numero palindromo più grande che sia il prodotto di due numeri con tre cifre ognuno.
Un palindromo è un numero in cui l'ordine delle cifre è lo stesso quando viene letto da sinistra o da destra, per esempio 104401, 9023209 ecc.
Nel nostro caso: 111111 è un palindromo che è il prodotto di 777 e 143.

Soluzione forza bruta (brute-force)

Funzione che verifica se un numero è palindromo:

(define (palindromo? num)
  (let (str (string num))
    (= str (reverse (copy str)))))

Numero massimo di numeri da verificare:

(* 999 999)
;-> 998001

Ma, poichè i numeri hanno tre cifre, il numero massimo vale:

(* (- 999 100) (- 999 100))
;-> 808201

Inoltre, per evitare ripetizioni, l'indice del secondo ciclo (j) inizia con il valore corrente dell'indice primo ciclo (i).

(define (palnum1)
  (local (num big a b)
    (setq big 0)
    (setq a 100)
    (setq b 100)
    (for (i 100 999)
      (for (j i 999)
        (setq num (* i j))
        (if (palindromo? num)
            (if (> num big) (begin
              (setq big num)
              (setq a i)
              (setq b j))
            )
        )
      )
    )
    (list a b big)
  )
)

(palnum1)
;-> (906609 913 993)

Ottimizzazione della funzione
La soluzione (il più grande palindromo) deve avere almeno 6 cifre poiché stiamo moltiplicando 2 numeri a tre cifre, quindi il numero deve avere almeno 3 cifre univoche che indichiamo con X, Y e Z.

Sol = 100000 * X + 10000 * Y + 1000 * Z + 100 * Z + 10 * Y + X

Possiamo semplificarlo come:

Sol = 100001 * X + 10010 * Y + 1100 * Z

Sol = 11 * (9091 * X + 910 * Y + 100 * Z)

Quindi la soluzione deve essere un multiplo di 11. Dato che 11 è un numero primo, uno dei due numeri moltiplicati deve essere un multiplo di 11. Per questo, se il numero del loop esterno non è un multiplo di 11, il loop interno deve essere un multiplo di 11 e, quindi, possiamo scartare diverse possibilità.

la funzione è la seguente:

(define (palnum2)
  (local (num a b big step)
    (setq big 0)
    (setq step 1)
    (for (i 100 999)
      (setq j 0)
      (if (zero? (% i 11))
          (setq step 1 j 1)
          (setq step 11 j (- i (% i 11)))
      )
      (while (> j 99)
        (setq num (* i j))
        (if (palindromo? num)
            (if (> num big) (begin
              (setq big num)
              (setq a i)
              (setq b j))
            )
        )
        (setq j (- j step))
      )
    )
    (list a b big)
  )
)

(palnum2)
;-> (993 913 906609)

Vediamo la differenza di velocità:

(time (palnum1) 10)
;-> 2417.706

(time (palnum2) 10)
;-> 218.113

La versione ottimizzata è 10 volte più veloce.


-----------------
Frazioni continue
-----------------

Il calcolo della frazione continua di un numero reale consiste nella ripetizione di due operazioni: prendere la parte intera di un numero e prendere il reciproco della sua parte frazionaria.

Ovvero, dato un numero reale "r", ponendo "i" la sua parte intera e "f" la sua parte frazionaria, si ha:

r = i + f = i + 1/(1/f)

Ora 1/f è un numero maggiore di 1, e quindi si può prendere la sua parte intera, e calcolare successivamente gli altri coefficienti. Se in un qualunque momento f è 0, l'algoritmo si ferma: questo avviene se e solo se r è razionale.

Esempio: ricerca della frazione continua di 3.245:

3  |   (3.245 - 3) = 0.245 | 1/0.245 = 4.082
   |                       |
4  |   (4.082 - 4) = 0.082 | 1/0.082 = 12.250
   |                       |
12 | (12.250 - 12) = 0.250 | 1/0.250 = 4.000
   |                       |
4  |   (4.000 - 4) = 0.000 | stop

Questo algoritmo è adatto per i numeri reali, ma può condurre a risultati errati se vengono utilizzati i numeri a virgola mobile (floating point), in quanto piccoli errori nella parte frazionaria possono generare (tramite l'operazione di inversione) grandi differenze nel termine successivo.

Per esempio:

(define (num2fc x)
  (local (out i f)
    (setq out '())
    (setq i (int x))
    (setq f (sub x i))
    (println i { } f { } (div 1 f))
    (while (!= f 0)
      (push i out -1)
      (setq i (int (div 1 f)))
      (setq f (sub (div 1 f) i))
      (println i { } f { } (div 1 f))
      (read-line)
    )
    out
  )
)

(num2fc 3.245)
;-> 3 0.2450000000000001 4.081632653061223
;-> 4 0.0816326530612228 12.25000000000025
;-> 12 0.2500000000002522 3.999999999995964
;-> 3 0.9999999999959641 1.000000000004036
;-> 1 4.035882739117369e-012 247777268231.2113

Come si nota, la frazione continua non converge al valore corretto.

Possiamo lavorare con i numeri interi se utilizziamo l'algoritmo di euclide, infatti i quozienti che compaiono quando applichiamo l'algoritmo ai valori di input a e b sono proprio i numeri che compaiono nella rappresentazione in frazione continua della frazione a/b. Per esempio con a = 1071 e b = 1029 otteniamo:

1071 = 1029 × 1 + 42
              -
1029 = 42 × 24 + 21
            --
42 = 21 × 2 + 0
          -

Quindi la frazione continua di 1071/1029 vale (1 24 2), cioè:

1071            1
----- = 1 + ----------
1029               1
             24 + ---
                   2

Per capire come viene usato l'algoritmo di Euclide per calcolare le frazioni continue possiamo calcolare il massimo comun divisore fra a e b nel modo seguente:

 a          r0           1              1
--- = q0 + ---- = q0 + ----- = q0 + ---------- =
 b          m0           m0                r1
                        ----         q1 + ----
                         r0                r0

              1                          1
= q0 + ----------------  = q0 + ---------------------- = ...
                 1                          1
        q1 + ----------          q1 + ----------------
                    r2                          1
              q2 + ----                q2 + ----------
                    r1                             r3
                                             q3 + ----
                                                   r3

in cui m0 > r0 > r1 > r2 > r3 > ... > 0. Per semplicità si scrive:

a/b = [q0, q1, ..., q(n-1), qn]

Osserviamo che se qn >= 2, allora risulta:

[q0, q1, ..., q(n-1), qn] = [q0, q1, ..., q(n-1), qn-1, 1]

Se a/b è irrazionale allora l'algoritmo euclideo non ha termine, ma la sequenza di quozienti che si calcola costituisce sempre la rappresentazione (ora infinita) di a/b in frazione continua.

Quindi con una variante dell'algoritmo di euclide si ottengono i risultati corretti, ma dobbiamo utilizzare come input il numeratore e il denominatore della frazione che rappresenta il numero razionale (es. 3.245 -> 3245/1000):

(define (fract2fc a b)
  (local (fc r out)
    (setq out '())
    (while (!= 0 r)
      (setq r (% a b))
      (setq fc (/ a b))
      (push fc out -1)
      (setq a b)
      (setq b r)
    )
    ;(println a)
    out
  )
)

(fract2fc 3245 1000)
;-> (3 4 12 4)

3245              1
----- = 3 + ---------------
1000                 1
             4 + ----------
                        1
                  12 + ---
                        4

Un altro esempio:

(fract2fc 1071 1029)
;-> (1 24 2)

1071            1         51
----- = 1 + ---------- = ----
1029               1      49
             24 + ---
                   2

Il valore reale vale:

(div 1071 1029)
;-> 1.040816326530612

Un altro esempio:

(fract2fc 79 22)
;-> (3 1 1 2 4)

Adesso dobbiamo scrivere una funzione che converte una frazione continua in un numero fratto (numeratore e denominatore).
Utilizziamo le seguenti funzioni per calcolare la somma di due frazioni:

(define (rat n d)
  (let (g (gcd n d))
    (map (curry * 1L)
         (list (/ n g) (/ d g)))))

(define (+rat r1 r2)
  (rat (+ (* (r1 0) (r2 1))
          (* (r2 0) (r1 1)))
       (* (r1 1) (r2 1))))

(define (fc2fract lst)
  (local (num den frac tempfrac)
    (setq tempfrac '())
    (setq fc (reverse lst))
    (setq tempfrac (list 1 (first fc)))
    (println tempfrac) ; prima frazione convergente
    (for (i 1 (- (length fc) 2))
      (setq tempfrac (+rat tempfrac (list (fc i) 1)))
      (swap (tempfrac 0) (tempfrac 1))
      (println tempfrac) ; i-esima frazione convergente
    )
    (setq tempfrac (+rat (list (last fc) 1) tempfrac))
    (list tempfrac (div (first tempfrac) (last tempfrac)))
  )
)

(fc2fract '(1 24 2))
;-> ((51L 49L) 1.040816326530612)

Infatti risulta:

(gcd 1071 1029)
;-> 21

(/ 1071 (gcd 1071 1029))
;-> 51

(/ 1029 (gcd 1071 1029))
;-> 49

(fract2fc 159 49)
;-> (3 4 12)
(fc2fract '(3 4 12))
;-> ((159L 49L) 3.244897959183673)

(fract2fc 79 22)
;-> (3 1 1 2 4)
(div 79 22)
;-> 3.590909090909091
(fc2fract '(3 1 1 2 4))
;-> ((79L 22L) 3.590909090909091)

(fract2fc 3245 1000)
;-> (3 4 12 4)
(fc2fract '(3 4 12 4))
;-> ((649L 200L) 3.245)
(fc2fract '(3 4 12 3 1))
;-> ((649L 200L) 3.245)

Nota:
numero aureo = (1 + sqrt(5))/2 =
1.6180339887498948482045868343656381177203091798057628621354486227052...

(fc2fract '(1 1 1 1 1 1 1 1 1 1 1 1))
;-> ((233L 144L) 1.618055555555556)
(fc2fract '(1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1))
;-> ((514229L 317811L) 1.618033988754323)


-----------------------------------
Liste formate da coppie di elementi
-----------------------------------

Quando abbiamo una lista di elementi e vogliamo lavorare con coppie di elementi è possibile accoppiare gli elementi prima di operare su di essi. Per esempio, data la lista:

(setq lst '(a b c d e f g h))

Possiamo accoppiare gli elementi con la seguente funzione:

;; pair - raggruppa gli elementi di una lista in coppie
;;
;; (pair '(a b c d e f)) => ((a b) (c d) (e f))
;;
(define (pair lst)
  (array-list (array (/ (length lst) 2) 2 lst)))

(pair '(a b c d e f g h))
;-> ((a b) (c d) (e f) (g h))

Se gli elementi da accoppiare si trovano in due liste diverse possiamo usare la funzione "map":

(setq lst1 '(1 2 3 4))
(setq lst2 '(a b c d))
(map list lst1 lst2)
;-> ((1 a) (2 b) (3 c) (4 d))

Adesso possiamo usare una funzione che usa i due valori:

(define (use x y) (string "Params:" x "," y))
(use x y)
;-> "Params:nil,nil"

Esempio: iterazione su una lista di coppie

Sintassi newLISP (non valida):
(dolist ((x y) '(x1 y1 x2 y2)) (use x y))

(map (lambda (z) (apply use z)) '((x1 y1) (x2 y2)))
;-> ("Params:x1,y1" "Params:x2,y2")

Sintassi newLISP (non valida):
(dolist ((name age) '("John" 32 "Richard" 41 "Lucy" 37)) (use name age))

(map (lambda (x) (apply use x)) '(("John" 32) ("Richard" 41) ("Lucy" 37)))
;-> ("Params:John,32" "Params:Richard,41" "Params:Lucy,37")

Esempio: iterazione con due liste

Sintassi newLISP (non valida):
(dolist (a '(a1 a2 a3) b '(b1 b2 b3)) (use a b))

(map use '(a1 a2 a3) '(b1 b2 b3))
;-> ("Params:a1,b1" "Params:a2,b2" "Params:a3,b3")

Esempio: iterazione su una lista di coppie con due indici

Sintassi newLISP (non valida):
(dolist ((x y) '((1 2) (3 4) (5 6))) (use x y))

(map (lambda (x) (apply use x)) '((1 2) (3 4) (5 6)))
;-> ("Params:1,2" "Params:3,4" "Params:5,6")

Nota: "apply" non valuta gli argomenti prima di applicare l'operazione, ma possiamo forzare newLISP a farlo nel modo seguente:

(apply use (map eval '(x1 x2)))

Se vogliamo raggruppare gli elementi di una lista con un numero di elementi variabile possiamo usare la seguente funzione:

(define (group lst n)
  (map (lambda (i) (slice lst i n)) (sequence 0 (sub (length lst) 1) n)))

(group '(1 2 3 4 5 6) 2)
;-> ((1 2) (3 4) (5 6))

(group '(1 2 3 4 5 6 7 8 9) 4)
;-> ((1 2 3 4) (5 6 7 8) (9))

Oppure possiamo usare la funzione integrata "explode":

(explode '(1 2 3 4 5 6) 2)
;-> ((1 2) (3 4) (5 6))

(explode '(1 2 3 4 5 6 7 8 9) 4)
;-> ((1 2 3 4) (5 6 7 8) (9))

Vediamo una funzione che raggruppa con alcuni parametri supplementari:

;; This function performs a multiple slice on a given list
;; One supplies a list and an integer n. The list is broken into a list of sublists of
;; length n. If n is negative the list items are collected going from the end of the list
;; to the beginning. If the optional bool argument is supplied then remaining elements are
;; included in the result.
;; (group '(1 2 3 4 5 6 7) 3)       -> ((1 2 3)(4 5 6))
;; (group '(1 2 3 4 5 6 7) 3 true)  -> ((1 2 3)(4 5 6)(7))
;; (group '(1 2 3 4 5 6 7) -3 true) -> ((1)(2 3 4)(5 6 7))
(define (group lst n bool , len num rep rem start)
  (setq num (abs n))
  (if (< n 0)
      (reverse (map reverse (group (reverse lst) num bool)))
      (= n 0)
      nil
      (begin
        (setq len   (length lst)
              rep   (/ len num)
              rem   (% len num)
              start '()
        )
        (if (< num len)
            (begin
              (dotimes (x rep)
                (setq start (cons (slice lst (* x num) num) start)))
              (if (and bool (> rem 0))
                  (setq start (cons (slice lst (* num rep) rem) start)))
              (reverse start))
            (list lst)))))

(group '(1 2 3 4 5 6 7) 3)
;-> ((1 2 3)(4 5 6))
(group '(1 2 3 4 5 6 7) 3 true)
;-> ((1 2 3)(4 5 6)(7))
(group '(1 2 3 4 5 6 7) -3 true)
;-> ((1)(2 3 4)(5 6 7))
(group '(1 2 3 4 5 6 7) -3)
;-> ((2 3 4) (5 6 7))

Nota: "dolist" itera su una lista, "map" itera su una lista e colleziona i risultati.
Esempi:

(setq L '((1 2) (3 4) (5 6)))
(map first L)
;-> (1 3 5)

(time (dotimes (i 1000000) (map first L)))
;-> 200.49
(time (dotimes (i 1000000) (map (lambda (x) (nth 0 x)) L)))
;-> 420.015
(time (dotimes (i 1000000) (setq r '())(dolist (x L)(push (x 0) r -1))))
;-> 287.697
(time (dotimes (i 1000000) (dolist (x L) (first x))))
;-> 199.496

Infine, vediamo la funzione "dispose" che ragruppa gli elementi di più liste:

(define (dispose) (transpose (args)))

(dispose '(1 2 3) '(4 5 6))
;-> ((1 4) (2 5) (3 6))

(dispose '(1 2 3) '(4 5 6) '(7 8 9))
;-> ((1 4 7) (2 5 8) (3 6 9))

(setq m '(1 2 3 4 5 6 7))
(setq n '(7 6 5 4 3 2 1))
(dispose m n)
;-> ((1 7) (2 6) (3 5) (4 4) (5 3) (6 2) (7 1))


-------------
Liste quotate
-------------

Supponiamo di avere la seguente lista:

(setq L '(1 '(2 3 4)))
(L 0)
;-> 1
(L 1)
;-> '(2 3 4)

Adesso incontriamo uno strano comportamento:

(first (L 1))
;-> ERR: array, list or string expected in function first : (L 1)

Invece la seguente espressione è valida:

(first '(2 3 4))
;-> 2

Proviamo con la funzione "quote" al posto del carattere "'":

(setq Q (quote (1 (quote (2 3 4)))))
(Q 0)
;-> 1
(Q 1)
;-> (quote (2 3 4))

(first (Q 1))
;-> quote

Verifichiamo se la lista interna è quotata:

(quote? (L 1))
;-> true

(quote? (Q 1))
;-> nil

La sottolista '(2 3 4) è un tipo di dato speciale: "quoted-list" (che è un sottotipo del tipo "list"). È simile al sottotipo "lambda" di una lista.

La funzione "quote" e il carattere "'" sono equivalenti quando avviene la valutazione:
in newLISP similar to lambda-type sub-type of list.

(= 'x (quote x))
;-> true

e

(quote? (quote 'x))
;-> true

Ma nelle espressioni seguenti l'espressione (quote x) non viene valutata:

(quote? '(quote x))
;-> nil

e

(list? '(quote x))
;-> true

Proprio come "lambda" il carattere "'" vien risolto durante la traduzione del codice (source parsing). Questo è il perchè abbiamo i predicati "quote?" e "lamba?".

Sia il carattere "'" che la funzione "quote" hanno lo stesso scopo: proteggere una espressione dalla valutazione. Comunque "'" è processato molto più velocemente perchè viene tradotto durante il caricamento del sorgente. La funzione "quote" è necessaria quando vogliamo proteggere una espressione durante il runtime.

Per questo motivo, quando si desidera riscrivere la definizione originale di McCarthy di LISP in newLISP, è necessario utilizzare la funzione "quote" anziché il carattere "'":

(first (first (rest (quote (1 (quote 2 3 4))))))
;-> quote

ottenendo gli stessi risultati di Scheme e del Common Lisp.

Vedi anche il capitolo "La funzione quote e il simbolo '".


------------------------
Il limite sulle stringhe
------------------------

newLISP pone un limite all'utilizzo di stringhe: massimo 2048 caratteri.
Questo crea dei vincoli a diverse operazioni:

- una espressione non può superare 2048 caratteri
- un input da stdin con la funzione "read-line" non può superare 2048 caratteri.
- la funzione "print" non può usare stringhe con più di 2048 caratteri.
- la funzione "parse" non può usare token-size maggiori di 2048 caratteri
- ecc.

Questo limite è stato imposto per ottenere una maggiore velocità nel trattamento delle stringhe, ma può risultare un problema in certi casi. Fortunatamente newLISP offre la possibilità di superare questo problema a scapito di una diminuzione della velocità delle operazioni: utilizzare il tag [text] e [/text].

Creiamo una stringa maggiore di 2048 cartteri e stampiamola:

(setq str (dup "01" 1025))

newLISP crea automaticamente la stringa delimitata dal tag:

[text]01010101.......[/text]

quindi possiamo stamparla senza ulteriori accorgimenti:

(println str)

Se invece vogliamo stampare un testo creato internamente alla funzione "print", dobbiamo usare i tag:

(print
[text]
  <html>
  long long text
  </html>
[/text])

I tag [text] e [/ text] sono usati per delimitare stringhe lunghe (> 2048 char) e sopprimere la traduzione dei caratteri di escape.

Nota: Il trattamento di stringhe maggiori di 2048 caratteri rallenta molto la velocità di esecuzione dei programmi.


-----------------
Aggiunta di liste
-----------------

Se vogliamo aggiungere tutti gli elementi di una lista ad un'altra lista possiamo utilizzare diversi metodi:

(setq lst1 '(a b c d))
(setq lst2 '(1 2 3 4))

Uso di "append":
(setq lst-all (append lst1 lst2))
;-> (a b c d 1 2 3 4)

Uso di "extend"
(setq lst-all (extend lst1 lst2))
;-> (a b c d 1 2 3 4)

In questo ultimo esempio la funzione "extend" aggiunge lst2 a lst1, quindi dopo aver eseguito l'espressione abbiamo lst1 = lst-all (lst1 viene modificato).

Uso di "push":
(setq lst-all '())
(setq lst1 '(a b c d))
(setq lst2 '(1 2 3 4))
(map (fn(x) (push x lst-all -1)) lst1)
;-> ((a) (a b) (a b c) (a b c d))
lst-all
;-> (a b c d)
(map (fn(x) (push x lst-all -1)) lst2)
;-> ((a b c d 1) (a b c d 1 2) (a b c d 1 2 3) (a b c d 1 2 3 4))
lst-all
;-> (a b c d 1 2 3 4)


----------------------
Liberare una variabile
----------------------

Supponiamo di avere una lista L che occupa diversi megabyte di memoria.
Qual'è il modo corretto di liberare quella memoria da uno script in esecuzione?

Basta assegnare il valore nil alla variabile in questione:

(setq L nil)

Il momento che la memoria liberata verrà assegnata alla memoria generale del sistema dipende dal sistema operativo utilizzato. Potrebbe rimanere assegnata al processo fino a che il sistema operativo non la reclamerà, ma newLISP la libera nello stesso momento in cui avviene l'assegnazione a nil.
Se la variabile è locale in una funzione definita dall'utente (con local o let), allora la variabile verrà assegnata a nil al termine della funzione.


------------------------------
Massimo prodotto di due numeri
------------------------------

Trovare i due numeri distinti che formano il prodotto massimo in una lista di numeri interi non negativi.
Input: una lista di n numeri interi non negativi.
Output: il valore massimo che può essere ottenuto moltiplicando due elementi diversi della lista.
In termini matematici, data una lista di numeri interi non negativi (a1, a2, ... an), calcolare:

 max(ai*aj) dove 1<=i<=n e 1<=j<=n

da notare che deve risultare i<>j, ma può essere ai = aj.

Il problema è abbastanza semplice, ma la soluzione ottima (in termini di numero di operazioni dell'algoritmo utilizzato) non è immediata.

La soluzione esaustiva (forza bruta) è quella di calcolare i prodotti di tutte le coppie possibili di numeri e trovare il prodotto maggiore.

(define (maxprod1 lst)
  (let (prodotto 0)
    (for (i 0 (- (length lst) 1))
      (for (j 0 (- (length lst) 1))
        (if (!= i j)
            (if (< prodotto (* (lst i) (lst j)))
                (setq prodotto (* (lst i) (lst j)))
            )
        )
      )
    )
    prodotto
  )
)

(maxprod1 '(1 2 3 4 5 6))
;-> 30

Possiamo migliorare l'algoritmo iniziando il secondo ciclo con j = i + 1.
Purtroppo (o per fortuna) newLISP ha un ciclo "for" che non funziona esattamente come quello degli altri linguaggi. Infatti se il valore dell'indice è superiore a quello del numero limite, allora le espressioni all'interno del ciclo vengono eseguite ugualmente perchè newlisp considera che il ciclo abbia un indice che va all'indietro (-1). Quando l'indice è uguale al numero limite, allora il ciclo termina.

(define (test-for n)
    (for (i 0 n)
      (for (j (+ i 1) n)
        (println i { } j)
      )))

(test-for 2)
;-> 0 1
;-> 0 2
;-> 1 2
;-> 2 3 ; in questo caso risulta j > n, ma newLISP lo esegue lo stesso
;-> 2 2 ; perchè considera che il passo dellindice sia negativo (-1).

Quindi dobbiamo usare "while" nel secondo ciclo:

(define (maxprod2 lst)
  (let (prodotto 0)
    (for (i 0 (- (length lst) 1))
      (setq j (+ i 1))
      (while (<= j (- (length lst) 1))
        (if (< prodotto (* (lst i) (lst j)))
            (setq prodotto (* (lst i) (lst j)))
        )
        (++ j)
      )
    )
    prodotto
  )
)

(maxprod2 '(1 2 3 4 5 6))
;-> 30

Possiamo anche eliminare l'espressione "if" utilizzando la funzione "max":

(define (maxprod3 lst)
  (let (prodotto 0)
    (for (i 0 (- (length lst) 1))
      (setq j (+ i 1))
      (while (<= j (- (length lst) 1))
        (setq prodotto (max prodotto (* (lst i) (lst j))))
        (++ j)
      )
    )
    prodotto
  )
)

(maxprod3 '(1 2 3 4 5 6))
;-> 30

La complessità temporale delle tre funzioni vale O(n^2) (perchè abbiamo due cicli innestati). Verifichiamo le funzioni calcolando i tempi di esecuzione:

(time (maxprod1 (sequence 1 100)) 1000)
;-> 1820.132
(time (maxprod2 (sequence 1 100)) 1000)
;-> 1669.535
(time (maxprod3 (sequence 1 100)) 1000)
;-> 1632.634

Cerchiamo un algoritmo migliore.
Considerando che il massimo prodotto si ottiene moltiplicando i due valori maggiori della lista, possiamo pensare di cercare questi due valori con l'utilizzo di due cicli: un ciclo per trovare l'elemento maggiore e un secondo ciclo per trovare il secondo elemento maggiore.
La funzione che utilizza questo algoritmo è la seguente:

(define (maxprod4 lst)
  (local (idx1 idx2)
    (setq idx1 0)
    (for (i 1 (- (length lst) 1))
      (if (> (lst i) (lst idx1))
          (setq idx1 i))
    )
    (if (= idx1 0)
        (setq idx2 1)
        (setq idx2 0))
    (for (i 0 (- (length lst) 1))
         (if (and (!= i idx1) (> (lst i) (lst idx2)))
             (setq idx2 i))
    )
    (* (lst idx1) (lst idx2))
  )
)

(maxprod4 '(1 2 3 4 5 6))
;-> 30

Questa funzione ha complessità temporale pari a O(2*n) (perchè i due cicli "for" usati sono in serie e non innestati come nei casi precedenti).

(time (maxprod4 (sequence 1 100)) 1000)
;-> 32.91

La funzione "maxprod4" è 50 volte più veloce delle precedenti.

Proviamo ad utilizzare le funzioni integrate di newLISP per risolvere il problema, in particolare la funzione "sort":

(define (maxprod5 lst)
  (sort lst >)
  (* (lst 0) (lst 1)))

(maxprod5 '(1 2 3 4 5 6))
;-> 30

(time (maxprod5 (sequence 1 100)) 1000)
;-> 25.906

Come si vede, la funzione "sort" (che fa molto di più che cercare i due numeri maggiori) è molto veloce. Spesso le soluzioni che utilizzano le funzioni integrate sono molto più semplici da scrivere, anche se non sono le migliori dal punto di vista della complessità computazionale.


----------------
Test di funzioni
----------------

Ok, abbiamo scritto una funzione per risolvere il nostro problema: ma come possiamo assicurarci che sia una soluzione corretta?
Possiamo affidarci a dei test specifici, ma nessuno può effettuare dei test rispetto a tutti i casi che si possono presentare nella vita reale. Inoltre, con l'esperienza, si impara che i nostri programmi non sono quasi mai corretti quando li eseguiamo per la prima volta. Per rendere "solido" un programma dovremo provarlo con una serie di test/casi attentamente progettati.
Nota: Imparare come implementare algoritmi, nonché testare ed eseguire il debug dei programmi sono delle abilità fondamentali per un programmatore.
La capacità di creare "test specifici" dipende fortemente dall'esperienza del programmatore e dalla conoscenza delle strutture dati che vengono utilizzate nella soluzione.

Un metodo che si affianca a quello dei "test specifici" è lo "stress-test", che utilizza la creazione di test in modo automatico per ricercare un eventuale errore nel programma.
Uno "stress-test" consiste di quattro parti:

1. Una implementazione corretta di un algoritmo (anche banale e lenta)

2. Un'implementazione alternativa che vogliamo testare

3. Un generatore casuale di test (input del programma)

4. Un ciclo di tutti i test generati per consentire il confronto tra i risultati delle due implementazioni dell'algoritmo: se i risultati di un qualunque test differiscono, allora dobbiamo visualizzare i valori di input e i valori dell'output.

L'idea alla base dello stress test è che due implementazioni corrette dovrebbe dare la stessa risposta per ogni test (a condizione che la risposta al il problema sia univoca). Se, tuttavia, una delle implementazioni non è corretta, esisterà un test in cui le loro risposte sono diverse. L'unico caso in cui questo non si verifica è quando le implementazioni hanno lo stesso errore (ma questo è molto improbabile).
La generazione automatica dei test (cioè di valori diversi di unput) permette di effettuare migliaia di verifiche/confronti sulle nostre funzioni.

Prendiamo ad esempio le funzioni "maxprod" del capitolo precedente e proviamo a scrivere un generatore automatico di test. In questo caso ogni test necessita di una lista di numeri come input che viene generata in modo casuale:

(setq num-rnd (+ 100 (rand 1000)))
;-> 293
(setq input (sequence 0 num-rnd))
;-> (0 1 ... 293)
(extend input input)
;-> (0 1 ... 293 0 1 ... 293)
(setq test (slice (randomize input) 0 num-rnd))
;-> (181 50 283 207 233 190 146 ...)

La funzione finale:

(define (test n)
  (local (input test nun-rnd)
    ; lunghezza della sequenza
    (setq num-rnd (+ 100 (rand 1000)))
    ; creazione sequenza di numeri
    (setq input (sequence 0 num-rnd))
    ; raddoppiamo la sequenza per avere anche numeri doppi nella lista di input
    (extend input input)
    ; ciclo dei test
    (for (i 1 n)
      (print i { })
      ; generiamo un test: un valore per la lista di input
      (setq test (slice (randomize input) 0 num-rnd))
      ; verifichiamo i risultati delle funzioni
      (if (or (!= (maxprod1 test) (maxprod2 test))
              (!= (maxprod2 test) (maxprod3 test))
              (!= (maxprod3 test) (maxprod4 test))
              (!= (maxprod4 test) (maxprod5 test)))
          ; stampa input e output quando i risultati sono diversi
          (println (maxprod1 test) { } (maxprod2 test) { }
                   (maxprod3 test) { } (maxprod4 test) { }
                   (maxprod5 test) { } test)
      )
    )
    'end-test
  )
)

(test 100)
;->  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;->  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
;->  92 93 94 95 96 97 98 99 100 end-test

Nota: la correttezza dei risultati dello "stress-test" dipende dalla correttezza della funzione "test".


-----------------------------------------
Sostituzioni multiple in liste o stringhe
-----------------------------------------

newLISP ha una funzione integrata per modificare liste o stringhe: "replace". Vediamo la definizione del manuale:

*******************
>>>funzione REPLACE
*******************
liste
sintassi: (replace exp-key list exp-replacement [func-compare])
sintassi: (replace exp-key list)

stringhe
sintassi: (replace str-key str-data exp-replacement)
sintassi: (replace str-pattern str-data exp-replacement regex-option)

Sostituzione nelle liste
------------------------
Se il secondo argomento è una lista, "replace" sostituisce tutti gli elementi nella lista list che sono uguali all'espressione in exp-key. L'elemento viene sostituito con exp-replacement. Se manca exp-replacement, tutte le istanze di exp-key verranno eliminate dalla lista.

Si noti che "replace" è distruttiva. Cambia la lista passato ad esso e restituisce la lista modificata. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count quando la funzione ritorna. Durante l'esecuzione delle sostituzioni delle espressioni, la variabile di sistema anaforica $it è impostata sull'espressione da sostituire.

Facoltativamente, func-compare può specificare un operatore di confronto o una funzione definita dall'utente. Per impostazione predefinita, func-compare è il = (segno di uguale).

;; list replacement

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B)
;-> (a B c d e a B c d)
aList
;-> (a B c d e a B c d)
$count
;-> 2  ; number of replacements

;; list replacement with special compare functor/function

; replace all numbers where 10 < number
(set 'L '(1 4 22 5 6 89 2 3 24))

(replace 10 L 10 <)
;-> (1 4 10 5 6 10 2 3 10)
$count
;-> 3

; same as:

(replace 10 L 10 (fn (x y) (< x y)))
;-> (1 4 10 5 6 10 2 3 10)

; change name-string to symbol, x is ignored as nil

(set 'AL '((john 5 6 4) ("mary" 3 4 7) (bob 4 2 7 9) ("jane" 3)))

(replace nil AL (cons (sym ($it 0)) (rest $it))
                (fn (x y) (string? (y 0)))) ; parameter x = nil not used
;-> ((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3))

; use $count in the replacement expression
(replace 'a '(a b a b a b) (list $count $it) =)
;-> ((1 a) b (2 a) b (3 a) b)

Utilizzando le funzioni "match" e "unify" è possibile formulare ricerche sulla lista che sono potenti come le ricerche con le espressioni regolari sulle stringhe:

; calculate the sum in all associations with 'mary

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(mary *)  AL (list 'mary (apply + (rest $it))) match)
;-> ((john 5 6 4) (mary 14) (bob 4 2 7 9) (jane 3))
$count
;-> 1

; make sum in all expressions

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(*) AL (list ($it 0) (apply + (rest $it))) match)
;-> ((john 15) (mary 14) (bob 22) (jane 3))
$count
;-> 4

; using unify, replace only if elements are equal
(replace '(X X) '((3 10) (2 5) (4 4) (6 7) (8 8)) (list ($it 0) 'double ($it 1)) unify)
;-> ((3 10) (2 5) (4 double 4) (6 7) (8 double 8))

Eliminazione nelle liste
------------------------
L'ultima forma di "replace" per le liste ha solo due argomenti: l'espressione exp e la lista list. Questa forma rimuove tutte le espressioni exp trovate nella lista.

;; removing elements from a list

(set 'lst '(a b a a c d a f g))
(replace 'a lst)
;-> (b c d f g)
lst
;-> (b c d f g)

$count
;-> 4

Sostituzione nelle stringhe senza espressioni regolari
------------------------------------------------------
Se tutti gli argomenti sono stringhe, "replace" sostituisce tutte le occorrenzw di str-key in str-data con l'espressione valutata exp-replacement e ritorna la stringa modificata. L'espressione in exp-replacement viene valutata per ogni sostituzione. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count. Questa forma di "replace" può processare anche gli 0 (zero) binari
If all arguments are strings, replace replaces all occurrences of str-key in str-data with the evaluated exp-replacement, returning the changed string. The expression in exp-replacement is evaluated for every replacement. The number of replacements made is contained in the system variable $count. This form of replace can also process binary 0s (zeros).

;; string replacement
(set 'str "this isa sentence")
(replace "isa" str "is a")
;-> "this is a sentence"
$count
;-> 1

Sostituzione con le espressioni regolari
----------------------------------------
La presenza di un quarto parametro indica che deve essere effettuata una ricerca con le espressioni regolari il cui modello/pattern viene specificato da str-pattern e da un numero, regex-option, che specifica l'opzione della regex (es. 1 (one) o "i" per ricerche case-insensitive o 0 (zero) per una ricerca standard PCRE (Perl Compatible Regular Expression) senza opzioni). Vedi anche "regex" per maggiori dettagli.

Per default, "replace" sostituisce tutte le occorrenze nella stringa anche se viene inclusa la specifica di beginning-of-line nel modello/pattern di ricerca. Dopo ogni sostituzione, parte una nuova ricerca dalla nuova posizione in str-data. Impostare il bit di opzione a 0x8000 in regex-option costringe "replace" ad sostituire solo la prima occorrenza. La stringa modificata viene restituita.

"replace" con le espressioni regolari imposta anche le variabili di sistema $0, $1 e $2 con il contenuto della espressione e delle sotto-espressioni trovate. La variabile anaforica di sistema $it ha lo stesso valore di $0. Queste variabili possono essere usate per sostituzioni che dipendono dal contenuto dell'espressione trovata durante la sostituzione. I simboli $0, $1, $2 e $it possono essere usati nelle espressioni come tutti gli altri simboli. L'espressione di sostituzione valuta su un valore diverso da una stringa, allora non viene effettuata alcuna sostituzione. In alternativa, si può accedere al contenuto di queste variabili utilizzando ($ 0), ($ 1), ($ 2), ecc. Questo metodo permette l'accesso indicizzato (es ($ i), dove i è un intero) .

Dopo che sono state effettuate tutte le sostituzioni, il numero di sostituzioni è contenuto nella variabile di sistema $count.

;; using the option parameter to employ regular expressions

(set 'str "ZZZZZxZZZZyy")
;-> "ZZZZZxZZZZyy"
(replace "x|y" str "PP" 0)
;-> "ZZZZZPPZZZZPPPP"
str
;-> "ZZZZZPPZZZZPPPP"

;; using system variables for dynamic replacement

(set 'str "---axb---ayb---")
(replace "(a)(.)(b)" str (append $3 $2 $1) 0)
;-> "---bxa---bya---"

str
;-> "---bxa---bya---"

;; using the 'replace once' option bit 0x8000

(replace "a" "aaa" "X" 0)
;-> "XXX"

(replace "a" "aaa" "X" 0x8000)
;-> "Xaa"

;; URL translation of hex codes with dynamic replacement

(set 'str "xxx%41xxx%42")
(replace "%([0-9A-F][0-9A-F])" str
               (char (int (append "0x" $1))) 1)
;-> xxxAxxxB
str
;-> "xxxAxxxB"

$count
;-> 2

La funzione "setf" insieme a "nth", "first" o "last" possono anche essere usate per modificare gli elementi in una lista.

Vedi anche "directory", "find", "find-all", "parse", "regex" e "search" per le altre funzioni che usano le espressioni regolari.

Come abbiamo visto la funzione "replace" sostituisce gli elementi utilizzando una stringa di ricerca. Quando dobbiamo effettuare sostituzioni con diverse stringhe di ricerca occorre applicare la funzione "replace" per ognuna di queste stringhe. Per esempio:

(setq text "albero mela cucina pesce")
(replace "albero" text "pera" 0)
;-> "pera mela cucina pesce"
(replace "cucina" text "formaggio" 0)
;-> "pera mela formaggio pesce"

Possiamo accopiare e mettere tutte le stringhe di ricerca e modifica in una lista e poi utilizzare la seguente espressione:

(setq text "albero mela cucina pesce")
(setq repls '(("albero" "pera") ("cucina" "formaggio")))

(dolist (r repls)
    (replace (first r) text (last r)))
;-> "pera mela formaggio pesce"

Per utilizzare questo metodo, Lutz ha fornito la seguente macro:

(define-macro (replace-all)
    (dolist (r (eval (args 0)))
        (replace (first r) (eval (args 1)) (last r))))

(setq text "albero mela cucina pesce")
;-> "albero mela cucina pesce"
(replace-all repls text)
;-> "pera mela formaggio pesce"
text
"pera mela formaggio pesce"

Risulta comodo accoppiare le modifiche nel caso ci siano parecchie modifiche da effettuare.


-------------
Cambio monete
-------------

Calcolare il numero minimo di monete necessarie per cambiare un valore dato in monete da 1, 5 e 10.

Fino a che il totale è maggiore di zero (totale > 0), prendere una moneta con il valore più grande possibile che non superi il totale, sottrarre il valore della moneta al totale e aggiungere uno al numero che conteggia la quantità di quel taglio di moneta.

return int(money/10) + int((money mod 10)/5) + (money mod 5)

(define (cambio tot)
  (local (m10 m5 m1)
    (setq m10 0 m5 0 m1 0)
    (while (> tot 0)
      (cond ((>= tot 10)
             (setq tot (- tot 10) m10 (+ m10 1)))
            ((>= tot 5)
             (setq tot (- tot 5) m5 (+ m5 1)))
            (true
             (setq tot (- tot 1) m1 (+ m1 1)))
      )
    )
    (list m10 m5 m1 (+ (* m10 10) (* m5 5) (* m1 1)))
  )
)

(cambio 11)
;-> (1 0 1 11)

Se volessimo sapere solo quante monete sono necessarie per cambiare un certo totale, è sufficiente la seguente funzione:

(define (cambionum tot) (+ (/ tot 10) (/ (% tot 10) 5) (% tot 5)))

(cambionum 11)
;-> 2


-----------------
Funzione Harakiri
-----------------

Il titolo non è proprio corretto, perchè non è possibile scrivere una funzione autodistruttiva, ma newLISP permette di scrivere una macro che svolge il compito di "distruzione":

(define-macro (killme)
    (let (temp (eval (args)))
      (delete (args 0))
      temp))

(define (ei-fu x) (+ x x))

(killme ei-fu 21)
;-> 42

Vediamo se la funzione esiste nei simboli di newLISP:

(sym "ei-fu" MAIN nil)
;-> nil

No...la funzione non esiste più!


--------------------------
Ciclo for con numeri float
--------------------------

newLISP permette di utilizzare i numeri floating point come indici per il ciclo for:

(for (t 1 0.0 0.1) (println t))
;-> 1
;-> 0.9
;-> 0.8
;-> 0.7
;-> 0.6
;-> 0.5
;-> 0.3999999999999999
;-> 0.2999999999999999
;-> 0.2
;-> 0.09999999999999998
;-> 0

Questo è dovuto al fatto che non esiste un modo preciso per convertire esattamente un numero da decimale a binario e viceversa.
Quando si confrontano i float è sempre necessario confrontare la differenza dei numeri
contro qualche altra piccola quantità.
La differenza tra:

(setq x 1)
(for (i 1 10) (println (dec 'x 0.1)))
;-> 0.9
;-> 0.8
;-> 0.7000000000000001
;-> 0.6000000000000001
;-> 0.5000000000000001
;-> 0.4000000000000001
;-> 0.3000000000000002
;-> 0.2000000000000002
;-> 0.1000000000000001
;-> 1.387778780781446e-016

e

(for (i 1 0.0 0.1) (println i))
;-> 1
;-> 0.9
;-> 0.8
;-> 0.7
;-> 0.6
;-> 0.5
;-> 0.3999999999999999
;-> 0.2999999999999999
;-> 0.2
;-> 0.09999999999999998
;-> 0

è che newLISP quando esegue cicli "for" e sequenze cerca di evitare l'accumulo
dell'errore di arrotondamento calcolando prima il numero totale di iterazioni,
quindi calcola la variabile del ciclo "i" come prodotto di "step * count"
e non come un incremento ripetuto come nel primo esempio.
In questo modo newLISP non crea mai errori di underrun o overrun nei cicli.

Comunque se vogliamo utilizzare i valori della variabile del ciclo possiamo arrotondarla con le cifre desiderate:

(for (i 1 0.0 0.1) (println (round i -1)))
;-> 1
;-> 0.9
;-> 0.8
;-> 0.7
;-> 0.6
;-> 0.5
;-> 0.4
;-> 0.3
;-> 0.2
;-> 0.1
;-> 0


--------------------------
Nascondere la finestra DOS
--------------------------

Possiamo nascondere la finestrea DOS quando eseguiamo uno script newLISP.
Il seguente esempio mostra le funzioni necessarie per questo problema.

Salvare il seguente script in un file (es. hide.lsp) e poi eseguire dal prompt del DOS:

newlisp hide.lsp

In questo modo la console di newLISP viene nascosta.

; Esempio di script che nasconde la console del DOS (console)
; import functions
(import "kernel32.dll" "FreeConsole")
(import "user32.dll" "MessageBoxA")
; hide console
(FreeConsole)
; function to show messageBox
(define (message-box text (title "newLISP"))
  (let ((MB_OK 0))
    (MessageBoxA 0 text title MB_OK)))
; show a message
(message-box "Ciao da windows")
;(read-line)
(exit)


-----------------------
Funzioni come parametri
-----------------------

In newLISP possiamo passare delle funzioni come parametri:

(define (do-func func arg) (func arg))

(do-func upper-case "hello")
;-> "HELLO"

Per le funzioni definite dall'utente:

(define (stampa txt) (println txt))

(do-func stampa "pippo")
;-> pippo

Se la funzione da passare si trova all'interno di una lista (come simbolo):

(define (do-func func arg) (setq func (eval (first func))) (func arg))

(do-func '(upper-case lower-case) "hello")
;-> "HELLO"


------------------------
Valutazione input utente
------------------------

newLISP ha due funzioni di valutazione: "eval" e "eval-string".
La prima, "eval", accetta un'espressione e la valuta:

(set 'expr '(+ 1 2))
(eval expr)
;-> 3

La seconda, "eval-string", accetta una stringa e la valuta:

(set 'expr "(+ 1 2)")
(eval-string expr)
;-> 3

In realtà ne esiste anche una terza, "read-expr", che prende una stringa e la converte in una espressione (non valutata):

(read-expr "(+ 3 4)")
;-> (+ 3 4)
(eval (read-expr "(+ 3 4)"))
;-> 7

Quindi "eval-string" è una combinazione di "read-expr" e "eval".

Un modo per valutare l'input dell'utente potrebbe essere questo:

(print "Enter the 1st number: ")
(set 'num1 (int (read-line)))
(print "Enter the 2nd number: ")
(set 'num2 (int (read-line)))
(print "Enter an operator [+ - * /]: ")
(set 'op (eval-string (read-line)))
(set 'result (op num1 num2))
(print result)
(exit)

oppure:

(set 'op (eval (sym (read-line))))

La parte fondamentale è l'espressione:

(op num1 num2)

dove op è ovviamente un simbolo.
Bisogna assicurarsi che questo simbolo sia valutato come una funzione,
in questo caso alla funzione built-in della moltiplicazione fra interi "*".
Il carattere "*" di per sé non è la funzione built-in, ma è il simbolo che valuta alla funzione primitiva della moltiplicazione (analogamente a (set 'f (lambda (x) x)), dove f è un simbolo che valuta alla lista lambda).
Occorre definire op in modo che la sua valutazione sia la stessa di "*" (non al simbolo "*"). Possiamo farlo nei modi seguenti:

(set 'op *)

che è equivalente a:

(set 'op (eval '*)) ;

che è equivalente a:

(set 'op (eval (sym "*")));

che è equivalente a:

(set 'op (eval-string "*"))

Invece, (set 'op' *) non funziona, poichè imposta il valore del simbolo op al simbolo "*" (e non alla sua valutazione).

Vediamo la descrizione delle funzioni "eval", "eval-string" e "read-expr" dal manuale:

*****************
>>>funzione EVAL
*****************
sintassi: (eval exp)

"eval" calcola il risultato della valutazione dell'espressione "exp".
La valutazione viene effettuata nel contesto corrente delle variabili.

Esempi:

(set 'expr '(+ 3 4))
;-> (+ 3 4)
(eval expr)
;-> 7
(eval (list + 3 4))
;-> 7
(eval ''x)
;-> x
(set 'y 123)
(set 'x 'y)
;-> y
(eval x)
;-> 123

La valutazione delle variabili avviene nel contesto corrente:

(set 'x 3 'y 4)
(eval '(+ x y))
;-> 7

Vediamo "eval" in un contesto locale:

(let ( (x 33) (y 44) )
    (eval '(+ x y)))
;-> 77

Ancora "eval" nel vecchio contesto dopo essere usciti dal contesto locale:

(eval '(+ x y))
;-> 7

newLISP passa tutti gli argomenti per valore. Utilizzando un simbolo quotato, le espressioni possono essere passate per riferimento attraverso il simbolo. eval può essere utilizzato per accedere al contenuto originale del simbolo:

(define (change-list aList) (push 999 (eval aList)))

(set 'data '(1 2 3 4 5))

(change-list 'data)
;-> (999 1 2 3 4 5)

Nell'esempio, il parametro 'data è quotato, quindi push lavora sulla lista originale.

newLISP permette un metodo più sicuro per passare argomenti per riferimento racchiudendo i dati all'interno di oggetti contesto. Passare i riferimenti nella funzione definita dall'utente usando gli id dello spazio dei nomi evita la cattura della variabile del simbolo passato, nel caso in cui il simbolo passato sia lo stesso di quello usato come parametro nella funzione. Vedi il paragrafo successivo "Passare dati per riferimento".

************************
>>>funzione EVAL-STRING
************************
sintassi: (eval-string str-source [sym-context [exp-error [int-offset]]])

int-offset specifies an optional offset into str-source, where to start evaluation.

La stringa in str-source viene compilata nel formato interno di newLISP e quindi valutata. Il risultato della valutazione viene restituito. Se la stringa contiene più di un'espressione, allora viene restituito il risultato dell'ultima valutazione.

Un secondo argomento facoltativo può essere utilizzato per specificare il contesto in cui la stringa deve essere analizzata e tradotta.

Se si verifica un errore durante l'analisi e la valutazione di str-source, verrà valutato exp-error e verrà restituito il suo risultato.

int-offset specifica un offset opzionale in str-source, da dove iniziare la valutazione.

(eval-string "(+ 3 4)")
;-> 7
(set 'X 123)
;-> 123
(eval-string "X")
;-> 123

(define (repl) ; read print eval loop
  (while true
    (println "=> " (eval-string (read-line) MAIN (last-error)))
  )
)

(set 'a 10)
(set 'b 20)
(set 'foo:a 11)
(set 'foo:b 22)

(eval-string "(+ a b)")
;-> 30
(eval-string "(+ a b)" 'foo)
;-> 33

Il secondo esempio mostra un semplice ciclo eval dell'interprete newLISP.

L'ultimo esempio mostra come specificare un contesto di destinazione per la traduzione. I simboli a e b si riferiscono ora ai simboli e ai loro valori nel contesto foo anziché MAIN.

**********************
>>>funzione READ-EXPR
**********************
sintassi: (read-expr str-source [sym-context [exp-error [int-offset]]])

read-expr analizza le prime espressioni che trova in str-source e restituisce l'espressione tradotta senza valutarla. Un contesto opzionale in sym-context specifica uno spazio dei nomi per l'espressione tradotta.

Dopo una chiamata a read-expr, la variabile di sistema $count contiene il numero di caratteri scansionati.

Se si verifica un errore durante la traduzione di str-source, l'espressione in exp-error viene valutata e il risultato restituito.

int-offset specifica un offset opzionale in str-source dove dovrebbe iniziare l'elaborazione. Quando si chiama ripetutamente read-expr questo numero può essere aggiornato usando $count, il numero di caratteri elaborati.

(set 'code "; a statement\n(define (double x) (+ x x))")

(read-expr code) → (define (double x) (+ x x))

$count
;-> 41

read-expr si comporta in modo simile a eval-string, ma senza il passaggio di valutazione:

(read-expr "(+ 3 4)")
;-> (+ 3 4)

(eval-string "(+ 3 4)")
;-> 7

Utilizzando read-expr è possibile programmare un pre-elaboratore di espressioni di codice personalizzato prima della loro valutazione.

Vedere anche event-reader per il processamento di espressioni basate su eventi.


----------------------------
Passare dati per riferimento
----------------------------

Un funtore di default di un contesto può essere usato per contenere dati. Se questi dato contiene una lista o una stringa, allora possiamo usare il nome del contesto come un riferimento al dato stesso:

;; the default functor for holding data

(define Mylist:Mylist '(a b c d e f g))

(Mylist 3) → d

(setf (Mylist 3) 'D) → D

Mylist:Mylist → (a b c D e f g)

;; access list or string data from a default functor

(first Mylist) → a

(reverse Mylist) → (g f e D c b a)

(set 'Str:Str "acdefghijklmnop")

(upper-case Str) → "ACDEFGHIJKLMNOP"

Il più delle volte, newLISP passa i parametri per copia del valore. Ciò rappresenta un potenziale problema quando si passano liste o stringhe di grandi dimensioni a funzioni o macro definite dall'utente. Le stringhe e le liste che vengono inglobate in uno spazio dei nomi utilizzando i funtori di default vengono passati automaticamente per riferimento:

;; use a default functor to hold a list

(set 'Mydb:Mydb (sequence 1 100000))

(define (change-db obj idx value)
    (setf (obj idx) value))

; pass by context reference
(change-db Mydb 1234 "abcdefg")

(Mydb 1234)
;-> "abcdefg"

Qualsiasi argomento di una funzione built-in che richiede una lista o una stringa, ma nessun altro tipo di dati, può ricevere dati passati per riferimento. Qualsiasi funzione definita dall'utente può accettare qualsiasi normale argomento. Qualsiasi funzione definita dall'utente può accettare variabili normali o può accettare un nome di contesto per passare un riferimento al funtore predefinito contenente una lista o una stringa.

Si noti che nelle liste con meno di circa 100 elementi o stringhe di meno di circa 50000 caratteri, la differenza di velocità tra passaggio per riferimento e passaggio per valore è trascurabile. Ma con oggetti (dati) più grandi, le differenze di velocità e di utilizzo della memoria tra passaggio per riferimento e passaggio per valore possono essere significative.

Le funzioni integrate e definite dall'utente sono adatte per entrambi i tipi di argomenti, ma quando si passano i nomi di contesto, i dati verranno passati per riferimento.

I simboli tra virgolette possono anche essere utilizzati per passare i dati per riferimento, ma questo metodo presenta degli svantaggi:

(define (change-list aList) (push 999 (eval aList)))

(set 'data '(1 2 3 4 5))

; note the quote ' in front of data
(change-list 'data)
;-> (999 1 2 3 4 5)

data
;-> (999 1 2 3 4 5)

Sebbene questo metodo sia semplice da comprendere e utilizzare, pone il potenziale problema della cattura della variabile quando si passa lo stesso simbolo utilizzato come parametro di funzione:

;; pass data by symbol reference

(set 'aList '(a b c d))
;-> (a b c d)
(change-list 'aList)
;-> ERR: list or string expected : (eval aList)
;-> called from user defined function change-list

Prima abbiamo visto come inserire i dati in uno spazio dei nomi (contesto) usando il funtore predefinito. Oltre al funtore predefinito è possibile utilizzare qualsiasi simbolo del contesto per memorizzare i dati. Lo svantaggio è che la funzione chiamante deve avere conoscenza del simbolo utilizzato:

;; pass data by context reference

(set 'Mydb:data (sequence 1 100000))

(define (change-db obj idx value)
    (setf (obj:data idx) value))

(change-db Mydb 1234 "abcdefg")

(nth 1234 Mydb:data)
;-> "abcdefg"
; or
(Mydb:data 1234)
;-> "abcdefg"

La funzione riceve lo spazio dei nomi nella variabile obj, ma deve avere la consapevolezza che la lista a cui accedere è contenuta nel simbolo dei dati di quello spazio dei nomi (contesto).

Vediamo la differenza di velocità tra passaggio per riferimento e passaggio per valore:

(silent (setq refer:refer (sequence 1 100000)))
(silent (setq value (sequence 1 100000)))

(define (somma lst) (apply + lst))

(time (somma value) 1000)
;-> 3135.194
(time (somma refer) 1000)
;-> 1916.157


---------------------
Pagamento giornaliero
---------------------

Abbiamo un lingotto d'oro massiccio, contrassegnato con 7 divisioni uguali come segue:

| - | - | - | - | - | - | - |

Bisogna pagare un dipendente ogni giorno per una settimana con un pezzo di lingotto al giorno. È possibile fare questo utilizzando solo due tagli del lingotto?

Possiamo pagare il dipendente se numeriamo il lingotto e poi lo nella maniera seguente:

lingotto numerato

| 1 | 2 | 3 | 4 | 5 | 6 | 7 |

lingotto tagliato in tre parti (taglio tra 12 e 2 e taglio tra 4 e 5):

| 1 |     | 2 | 3 |     | 4 | 5 | 6 | 7 |

Abbiamo ottenuto un pezzo da 1 blocco, un pezzo da 2 blocchi e un pezzo di 4 blocchi.
Per pagare il dipendente dobbiamo operare nel modo seguente:

1° giorno: consegnare il pezzo da 1 blocco
noi: 6 - dipendente: 1
2° giorno: consegnare il pezzo da 2 blocchi e riprendere il pezzo da 1 blocco
noi: 5 - dipendente: 2
3° giorno: consegnare il pezzo da 1 blocco
noi: 4 - dipendente: 3
4° giorno: consegnare il pezzo da 4 blocchi e riprendere i pezzi da 1 e 2 blocchi
noi: 3 - dipendente: 4
5° giorno: consegnare il pezzo da 1 blocco
noi: 2 - dipendente: 5
6° giorno: consegnare il pezzo pezzo da 2 blocchi e riprendere il pezzo da 1 blocco
noi: 1 - dipendente: 6
7° giorno: consegnare il pezzo da 1 blocco
noi: 0 - dipendente: 7

Con questo metodo abbiamo pagato il dipendente 1 blocco d'oro al giorno.

Nota: in altre parole abbiamo utilizzato l'aritmetica binaria.


-------------------------
Differenze tra let e letn
-------------------------

In Common Lisp abbiamo le primitive "let" e "let*", in newLISP abbiamo "let" e "letn".
La differenza tra "let" e "letn": associazione parallela rispetto all'associazione sequenziale.

Sequenziale. Significa che le associazioni vengono fatte una dopo l'altra e possono vedere le associazioni precedenti.

Parallelo. Significa che le associazioni prendono vita allo stesso tempo e non vedono le altre associazioni (no shadow).

Supponiamo di avere il seguente codice:

CommonLisp:

(print (let ((c 1))
         (let ((c 2)
               (a (+ c 1)))
           a)))

(print (let ((c 1))
         (let* ((c 2)
                (a (+ c 1)))
           a)))

newLISP:

(let ((c 1))
  (let ((c 2) (a (+ c 1)))
   a))
;-> 2

(let ((c 1))
  (letn ((c 2) (a (+ c 1)))
   a))
;-> 3

Nel primo esempio, l'associazione (bindings) di "a" si riferisce al valore esterno di "c" cioè 1).

Nel secondo esempio, dove letn consente alle associazioni di fare riferimento alle associazioni precedenti, il legame di "a" si riferisce al valore interno di c (cioè 2).

La funzione "let" può essere simulata con la funzione "lambda" in questo modo:

(let ((a1 b1) (a2 b2) ... (an bn))
  (some-code a1 a2 ... an))

è uguale a:

((lambda (a1 a2 ... an)
   (some-code a1 a2 ... an))
 b1 b2 ... bn)

Invece "letn" può essere simulata in un altro modo:

(letn ((a1 b1) (a2 b2) ... (an bn))
  (some-code a1 a2 ... an))

è uguale a:

((lambda (a1)
    ((lambda (a2)
       ...
       ((lambda (an)
          (some-code a1 a2 ... an))
        bn))
      b2))
   b1)

Quindi "let" è più semplice di "letn" (almeno per il compilatore/interprete).

"let" semplifica la comprensione del codice. Tutte le associazioni possono essere lette singolarmente senza la necessità di comprendere il flusso top-down/left-right degli "effetti" delle associazioni (rebindings). L'uso di "letn" segnala al programmatore (quello che legge il codice) che le associazioni non sono indipendenti, ma esiste un di flusso top/down che complica le cose.

Il Lisp ha la regola che i valori per le associazioni (binding) in "let" sono calcolati da sinistra a destra. Come vengono valutati gli argomenti di una chiamata di funzione, da sinistra a destra. Quindi, "let" è l'istruzione concettualmente più semplice e dovrebbe essere utilizzata per impostazione predefinita.

La differenza non è importante solo per il compilatore. Uso "let" e "letn" come suggerimento per me stesso di ciò che sta succedendo. Quando vedo "let" nel mio codice, so che le associazioni (binding) sono indipendenti e quando vedo "letn", so che le associazioni (binding) dipendono una dall'altra. Ma lo so solo perché mi assicuro di usare "let" e "letn" in modo coerente.


------------
Tecnica RAID
------------

RAID, acronimo di "Redundant Array of Independent Disks" ovvero insieme ridondante di dischi indipendenti, (originariamente "Redundant Array of Inexpensive Disks", insieme ridondante di dischi economici), è una tecnica di installazione in un computer di diversi dischi rigidi in modo che appaiano e siano utilizzabili come se fossero un unico volume di memorizzazione.
Il principio di base della tecnica RAID si basa sulla funzione XOR.

Tabella di verità XOR
Input A   Input B   Output
  0         0         0
  0         1         1
  1         0         1
  1         1         0

Proprietà dello XOR
Commutativa: A xor B = B xor A
L'ordine dei parametri non modifica il risultato

Associativa: A xor ( B xor C ) = ( A xor B ) xor C
Questo significa che le operazioni XOR possono essere concatenate e l'ordine non ha importanza.

Elemento identità: A xor 0 = A
Questo significa che lo xor di qualsiasi valore con zero rimane invariato.

Auto-inverso: A xor A = 0
Questo significa che qualsiasi valore XOR con se stesso produce zero.

Supponiamo di avere N dischi e di memorizzare su un altro disco (N+1) il valore XOR di tutti gli altri dischi:

D = D1 xor D2 xor … xor Dn

Questa viene chiamata "ridondanza": se accade un errore in un disco (per esempio D1), allora possiamo recuperare i dati utilizzando tutti gli altri dischi:

  D2 xor … xor Dn xor D
= D2 xor … xor Dn xor (D1 xor D2 xor … xor Dn)  (definizione di D)

= D1 xor (D2 xor D2) xor… xor (Dn xor Dn) (commutativa e associativa: arrangiando i termini)

= D1 xor 0 xor… xor 0 (auto-inverso)

= D1  (elemento identità)

Vediamo un esempio con delle liste che simulano i valori contenuti nei dischi:

(setq d1 '(1 1 3))
(setq d2 '(6 5 6))
(setq d3 '(7 8 8))

Calcoliamo i valori xor di tutti i dischi:

(apply ^ '(1 6 7))
;-> 0
(apply ^ '(1 5 8))
;-> 12
(apply ^ '(3 6 8))
;-> 13

In modo equivalente:
(setq d (map (fn (x) (apply ^ x)) (map list d1 d2 d3)))
;-> (0 12 13)

Supponiamo di perdere il valore "5" dalla lista d2, allora possiamo recuperarlo nel modo seguente:

d2(1) = (xor (d1(1) xor d3(1)) d(1)) = (xor (xor 1 8) 12) = 5

Verifichiamo:

(^ (^ 1 8) 12)
;-> 5

Nel caso (altamente improbabile) in cui due dischi si guastassero contemporaneamente, con questa tecnica non ci sarebbe modo di recuperare i dati.


----------
Crypto XOR
----------

La funzione XOR può essere usata per cifrare/decifrare un messaggio.

(define (cryptoXOR msg key)
  (local (k len-key out)
    (setq k 0)
    (setq len-key (length key))
    ;(dolist (el (explode msg)) ; non UTF-8
    (dolist (el (unpack (dup "s" (length msg)) msg)) ; UTF-8
      ;(println (^ (char el) (char (key k))) { } (char el) { } (char (key k)))
      (push (^ (char el) (char (key k))) out -1)
      (++ k)
      (setq k (% k len-key))
    )
    ;(println out)
    (join (map char out))
  ))

(cryptoXOR "messaggio cifrato" "chiave")
;-> "\014\r\026\018\023\002\004\001\006A\021\f\005\026\b\021\025"

(cryptoXOR "\014\r\026\018\023\002\004\001\006A\021\f\005\026\b\021\025" "chiave")
;-> "messaggio cifrato"

(cryptoXOR (cryptoXOR "domani" "key") "key")
;-> "domani"

(cryptoXOR (cryptoXOR "cryptomessage" "password") "password")
;-> cryptomessage

La forza della criptazione dipende dalla lunghezza della chiave, più è lunga la chiave e maggiore sarà la sicurezza.


--------------------
Lancio di una moneta
--------------------

Abbiamo una moneta con due facce: "testa" e "croce".
In teoria lanciando/girando la moneta n volte, dovremmo ottenere il 50% "testa" e il 50% "croce" (circa).
Purtoppo dopo 1000 prove la nostra moneta produce il seguente risultato: 750 volte "testa" e 250 volte "croce".
Come possiamo ottenere una probabilità equa (50% "testa" e 50% "croce") da questa moneta?

Possiamo utilizzare una tecnica indicata da vonNeumann:

Passo 1. Lanciare/girare la moneta due volte.
Passo 2. Se i due risultati sono diversi,
         prendere come evento il primo risultato:
         TC diventa l'evento "testa",
         CT diventa l'evento "croce".
         La procedura è terminata.
Passo 3. Se i due risultati sono gli stessi (TT o CC),
         scartare la prova e tornare al passo 1.

In questo modo i risultati TC e CT sono simmetrici e quindi hanno uguale probabilità.

Vediamo come funziona:
supponiamo che il risultato "testa" abbia il 75% di probabilità e "croce" abbia il 25% di probabilità.
Poichè ogni lancio di moneta è un evento indipendente possiamo calcolare direttamente la probabilità delle coppie:

 TC si verifica (0.75)*(0.25) = 0.1875
 CT si verifica (0.25)*(0.75) = 0.1875

Come si nota, i due eventi coppia sono ugualmente probabili e quindi le possibilità sono pari.

Vediamo di simulare la funzione di vonNeumann:

(define (faircoin)
  (local (a b res)
    (setq res nil)
    (while (= res nil)
      (setq a (rand 2))
      (setq b (rand 2))
      (if (!= a b)
          (setq res a))) res))

(faircoin)
;-> 0

Eseguiamo la funzione n volte:

(define (test n)
  (let ((t 0) (c 0))
    (dotimes (i n)
      (if (= (faircoin) 0)
          (++ t)
          (++ c)))
    (println "testa: " t { - } "croce: "c)))

(test 10000000)
;-> testa: 5001000 - croce: 4999000
(test 100000000)
;-> testa: 49999363 - croce: 50000637

Vediamo il risultato con una simulazione standard (usando direttamente la funzione "rand"):

(define (testreal n)
  (let ((t 0) (c 0))
    (dotimes (i n)
      (if (= (rand 2) 0)
          (++ t)
          (++ c)))
    (println "testa: " t { - } "croce: "c)))

(testreal 10000000)
;-> testa: 5001680 - croce: 4998320
(testreal 100000000)
;-> testa: 50001412 - croce: 49998588

Per vedere se la funzione "faircoin" restiutisce il risultato corretto proviamo a modificare la funzione assegnando a "testa" la probabilità del 75% e a "croce" la probabilità del 25%.

(define (faircoin)
  (local (a b res)
    (setq res nil)
    (while (= res nil)
      (setq a (rand 100))
      (if (> a 25)
          (setq a 0)
          (setq a 1)
      )
      (setq b (rand 100))
      (if (> b 25)
          (setq b 0)
          (setq b 1)
      )
      (if (!= a b)
          (setq res a))) res))

(faircoin)
;-> 0

Proviamo la nuova funzione con n lanci:

(test 10000000)
;-> testa: 4997544 - croce: 5002456
(test 100000000)
;-> testa: 50002280 - croce: 49997720

La procedura di vonNeumann produce risultati equi.

Nota: nella vita reale una moneta non è mai equa, questo è dovuto sia a motivi geometrici/fisici della moneta stessa, sia al modo con cui vengono eseguite le prove (lancio e cattura della moneta oppure rotazione della moneta su un piano). Quindi sarebbe meglio usare la procedura di vonNeumann o utilizzare un generatore di numeri casuali per ottenere una probabilità equa.

Nota: analizziamo il lancio e la cattura di una moneta. Si consideri una moneta, lanciata dalla posizione "testa" per un certo numero di volte, che gira testa-croce attraverso l'aria (con tempi diversi):

lancio 1: T C T C T C T C T C T C T C T C T C T C    ==> (10 T e 10 C)
lancio 2: T C T C T C T C T C T C T C T C T C T      ==> (10 T e 9 C)
lancio 3: T C T C T C T C T C T C                    ==> (6 T e 6 C)
lancio 4: T C T C T C T C T C T C T C T              ==> (8 T e 7 C)

Come si nota, se partiamo dalla posizione "testa" non possiamo mai ottenere un lancio in cui il numero delle croci è superiore al numero delle teste. Invece abbiamo dei lanci in cui il numero delle teste supera di una unità il numero delle croci. In altre parole, in un dato momento, o la moneta avrà trascorso lo stesso tempo negli stati di "testa" e "croce", oppure avrà trascorso più tempo nello stato di "testa". Nel complesso, è leggermente più probabile che la moneta mostri "testa" in un dato momento, incluso il momento in cui la moneta viene catturata. Questo indica che la probabilità dell'evento "testa" è maggiore (anche se di poco) del 50%. Vediamo una simulazione di questo processo:

(define (lancio n)
  (local (t c res)
    (setq t 0 c 0)
    (dotimes (x n)
      ; crea una lista di 0 e 1 alternati di lunghezza casuale (da 3 a 22)
      ; che inizia con 0 (testa).
      ; Restituisce una lista con il numero di 0 e di 1.
      (setq res (count '(0 1) (slice (flat (dup '(0 1) 11)) 0 (+ (rand 19) 3))))
      (setq t (+ t (first res)))
      (setq c (+ c (last res)))
    )
    (println "testa: " t " - " (mul 100 (div t (add t c))))
    (println "croce: " c " - " (mul 100 (div c (add t c))))))

(lancio 100000)
;-> testa: 628056 - 52.19116884498278
;-> croce: 575320 - 47.80883115501722
(lancio 10000000)
;-> testa: 62623070 - 52.19285897839979
;-> croce: 57360911 - 47.80714102160021


------------
Area massima
------------

Data una corda di 4 metri di lunghezza, tagliandola in due possiamo costruire una circonferenza (con il primo pezzo) e un quadrato con il secondo pezzo. Determinare il taglio ottimo che massimizza la somma delle aree della circonferenza e del quadrato.

Risolviamo il problema con una simulazione.

(define (taglio step)
  (setq pi 3.1415926535)
  (setq corda 4)
  (for (i 0 4 step)
    (setq t1 i)
    (setq t2 (sub corda i))
    (setq l (div t1 4))
    (setq quad (mul l l))
    (setq r (div t2 (mul 2 pi)))
    (setq circle (mul r r pi))
    (println i ": t1=" t1 " t2=" t2 " area=" (add quad circle))
  )
)

(taglio 0.1)
;-> 0: t1=0 t2=4 area=1.273239544771555
;-> 0.1: t1=0.1 t2=3.9 area=1.210998342248459
;-> 0.2: t1=0.2 t2=3.8 area=1.151598689156328
;-> 0.3: t1=0.3 t2=3.7 area=1.095040585495162
;-> 0.4: t1=0.4 t2=3.6 area=1.041324031264959
;-> 0.5: t1=0.5 t2=3.5 area=0.9904490264657215
;-> 0.6: t1=0.6 t2=3.4 area=0.9424155710974482
;-> 0.7: t1=0.7 t2=3.3 area=0.8972236651601393
;-> 0.8: t1=0.8 t2=3.2 area=0.8548733086537949
;-> 0.9: t1=0.9 t2=3.1 area=0.815364501578415
;-> 1: t1=1 t2=3 area=0.7786972439339993
;-> 1.1: t1=1.1 t2=2.9 area=0.7448715357205482
;-> 1.2: t1=1.2 t2=2.8 area=0.7138873769380616
;-> 1.3: t1=1.3 t2=2.7 area=0.6857447675865397
;-> 1.4: t1=1.4 t2=2.6 area=0.6604437076659817
;-> 1.5: t1=1.5 t2=2.5 area=0.6379841971763884
;-> 1.6: t1=1.6 t2=2.4 area=0.6183662361177595
;-> 1.7: t1=1.7 t2=2.3 area=0.6015898244900951
;-> 1.8: t1=1.8 t2=2.2 area=0.5876549622933953
;-> 1.9: t1=1.9 t2=2.1 area=0.5765616495276595
;-> 2: t1=2 t2=2 area=0.5683098861928886
;-> 2.1: t1=2.1 t2=1.9 area=0.562899672289082
;-> 2.2: t1=2.2 t2=1.8 area=0.5603310078162398
;-> 2.3: t1=2.3 t2=1.7 area=0.560603892774362
;-> 2.4: t1=2.4 t2=1.6 area=0.5637183271634487
;-> 2.5: t1=2.5 t2=1.5 area=0.5696743109834999
;-> 2.6: t1=2.6 t2=1.4 area=0.5784718442345155
;-> 2.7: t1=2.7 t2=1.3 area=0.5901109269164955
;-> 2.8: t1=2.8 t2=1.2 area=0.60459155902944
;-> 2.9: t1=2.9 t2=1.1 area=0.6219137405733488
;-> 3: t1=3 t2=1 area=0.6420774715482222
;-> 3.1: t1=3.1 t2=0.8999999999999999 area=0.66508275195406
;-> 3.2: t1=3.2 t2=0.7999999999999998 area=0.6909295817908623
;-> 3.3: t1=3.3 t2=0.6999999999999997 area=0.719617961058629
;-> 3.4: t1=3.4 t2=0.5999999999999996 area=0.7511478897573601
;-> 3.5: t1=3.5 t2=0.5 area=0.7855193678870556
;-> 3.6: t1=3.6 t2=0.3999999999999999 area=0.8227323954477156
;-> 3.7: t1=3.7 t2=0.2999999999999998 area=0.8627869724393401
;-> 3.8: t1=3.8 t2=0.1999999999999997 area=0.905683098861929
;-> 3.9: t1=3.9 t2=0.09999999999999965 area=0.9514207747154824
;-> 4: t1=4 t2=0 area=1

Quindi conviene avere la maggior corda possibile per il cerchio.
Nota: fra tutte le curve chiuse nel piano di fissato perimetro, la circonferenza massimizza l'area della regione inclusa (problema isoperimetrico).


--------------
Sole o pioggia
--------------

In un certo posto il tempo è soleggiato o piovoso, niente in mezzo.
In una giornata di sole, ci sono le stesse possibilità che il giorno successivo pioverà o sarà soleggiato.
In una giornata piovosa, invece, c'è un 70 per cento di possibilità che il giorno successivo pioverà contro una probabilità del 30% che sarà soleggiato.
In media, quante volte piove in questo posto?

(define (test n)
  (local (prob_sole prob_pioggia day dole pioggia)
    ; 0=sole 1=pioggia
    (setq sole 0 pioggia 0)
    (setq day (rand 2))
    (if (= 0 day) (++ sole) (++ pioggia))
    (for (i 2 n)
      (cond ((= day 0) ; se il giorno prima c'era il sole
             (setq day (rand 2))
             (if (= 0 day) (++ sole) (++ pioggia))
            )
            ((= day 1) ; se il giorno prima c'era la pioggia
             (if (< (rand 100) 30)
                 ; se minore di 30 allora giorno di sole
                 (setq sole (+ sole 1) day 0)
                 ; altrimenti giorno di pioggia
                 (setq pioggia (+ pioggia 1) day 1)
             )
            )
      )
    )
    (println "sole: " sole)
    (println "pioggia: " pioggia)
    (println "totale: " (+ sole pioggia))
    (println "%pioggia = " (mul 100 (div pioggia (+ sole pioggia))))
  )
)

(test 10000000)
;-> sole: 3749166
;-> pioggia: 6250834
;-> totale: 10000000
;-> %pioggia = 62.50834

Quindi in quel posto piove il 62.5% dei giorni.


--------------
Roulette russa
--------------

Facciamo una partita alla roulette russa. Si tratta di un gioco d'azzardo che consiste nel posizionare un solo proiettile in una pistola, ruotare il tamburo senza guardare, puntarla verso la propria testa e premere il grilletto. Nel caso in cui il primo colpo non sia mortale, puoi decidere se sparare subito un secondo colpo oppure ruotare (rullare) il tamburo una seconda volta prima di sparare.
Dal punto di vista delle probabilità di sopravvivenza, cosa conviene scegliere?

Dal punto di vista matematico risulta:

% sopravvivenza con un rullaggio:
(setq v (div 4 6))
;-> 0.6666666666666666

% sopravvivenza con due rullaggi:
(setq v (mul (div 5 6) (div 5 6)))
;-> 0.6944444444444445

Cerchiamo di verificare questa soluzione con una simulazione.

(define (russa n)
  (local (gun vivo morto morto1 morto2)
    ; morto1 conta le morti al primo colpo
    ; morto2 conta le morti al secondo colpo
    ; test con un solo rullaggio (due colpi consecutivi)
    (setq vivo 0 morto 0 morto1 0 morto2 0)
    (for (i 1 n)
      (setq gun (rand 6))
      (if (> gun 1) ; se gun=0 o gun=1, allora morto
          (++ vivo)
          (if (= gun 0)
              (++ morto1)
              (++ morto2)
          )
      )
    )
    (println "Un rullaggio: vivo = " vivo " & morto1 = " morto1 " & morto2 = " morto2)
    (println "totale: " (+ vivo morto1 morto2))
    (println "%vivo: " (mul 100 (div vivo (add vivo morto1 morto2))))
    (setq vivo 0 morto 0 morto1 0 morto2 0)
    ; test con due rullaggi (un colpo dopo ogni rullaggio)
    (for (i 1 n)
      ; primo rullaggio e colpo
      (setq gun (rand 6))
      (if (= gun 0)
          (++ morto1)
          (begin ; se vivo allora
            ; secondo rullaggio e colpo
            (setq gun (rand 6))
            (if (= gun 0)
                (++ morto2)
                (++ vivo)
            )
         )
      )
    )
    (println "Due rullaggi: vivo = " vivo " & morto1 = " morto1 " & morto2 = " morto2)
    (println "totale: " (+ vivo morto1 morto2))
    (println "%vivo: " (mul 100 (div vivo (add vivo morto1 morto2))))
  )
)

(russa 10000000)
;-> Un rullaggio: vivo = 6669793 & morto1 = 1665755 & morto2 = 1664452
;-> totale: 10000000
;-> %vivo: 66.69793
;-> Due rullaggi: vivo = 6942370 & morto1 = 1666709 & morto2 = 1390921
;-> totale: 10000000
;-> %vivo: 69.4237

Quindi conviene scegliere di rullare il tamburo due volte.
La teoria della probabilità può salvarti la vita.


---------------------
Common LISP Quicksort
---------------------

La seguente funzione, scritta in Common LISP, implementa l'algoritmo di ordinamento Quicksort.
Vediamo come convertirla in newLISP.

(defun qsort (lst)
   (when lst
     (let* ((x  (car lst))
	          (xs (cdr lst))
	          (lt  (loop for y in xs when (< y x) collect y))
	          (gte (loop for y in xs when (>= y x) collect y)))
     (append (qsort lt) (list x) (qsort gte)))))

La funzione "defun" diventa "define".
La funzione "let*" diventa "letn".
Le funzioni "loop" e "collect" vengono sostituite con "dolist".

(define (qsort lst)
   (when lst
     (letn ((x (first lst))
	          (xs (rest lst))
            (lt '())
            (gte '()))
     (dolist (y xs) (if (< y x) (push y lt -1)))
     (dolist (y xs) (if (>= y x) (push y gte -1)))
     ;(println lt) ;(println gte)
     (append (qsort lt) (list x) (qsort gte))
   )))

(qsort (randomize (sequence 1 100)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;->  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
;->  92 93 94 95 96 97 98 99 100)

Proviamo la velocità:

(silent (setq lst (rand 10000 100000)))
(time (qsort lst))
;-> 374.831


------------------------------------------
Ambito dinamico e parametri delle funzioni
------------------------------------------

Vediamo alcuni esempi per capire meglio come funziona la "visibilità" delle variabili e dei parametri delle funzioni in newLISP (che utilizza l'ambito dinamico).
Un aspetto fondamentale è il seguente:
la funzione chiamata "vede" tutte le variabili locali della funzione chiamante (a meno che la funzione chiamata non abbia variabili locali con nomi/simboli uguali a quelli della funzione chiamante (shadowing)).
L'output degli esempi è autoesplicativo sul funzionamento della visibilità delle variabili.

Esempio 1
---------

(define (f1)
  (local (a b)
    (println "f1-pre: a=" a " e b=" b)
    (f2)
    (println "f1-post: a=" a " e b=" b)))

(define (f2)
  (println "f2-pre: a=" a " e b=" b)
  (setq a 10 b 20)
  (println "f2-post: a=" a " e b=" b)
  (println "f2-pre: c=" c " e d=" d)
  (f3)
  (println "f2-post: c=" c " e d=" d))

(define (f3)
  (local (c d)
    (println "f3-pre: a=" a " e b=" b)
    (println "f3-pre: c=" c " e d=" d)
    (setq c 30 d 40)
    (println "f3-post: c=" c " e d=" d)))

(f1)
;-> f1-pre: a=nil e b=nil
;-> f2-pre: a=nil e b=nil
;-> f2-post: a=10 e b=20
;-> f2-pre: c=nil e d=nil
;-> f3-pre: a=10 e b=20
;-> f3-pre: c=nil e d=nil
;-> f3-post: c=30 e d=40
;-> f2-post: c=nil e d=nil
;-> f1-post: a=10 e b=20

Esempio 2
---------

(define (f1)
  (local (a b)
    (println "f1-pre: a=" a " e b=" b)
    (f2)
    (println "f1-post: a=" a " e b=" b)))

(define (f2)
  (local (aa bb)
    (println "f2-pre: a=" a " e b=" b)
    (println "f2-pre: c=" c " e d=" d)
    (setq a 10 b 20)
    (f3 a b)
    (println "f2-post: a=" a " e b=" b)
    (println "f2-post: c=" c " e d=" d)
    (println "f2-post: x=" x " e y=" y)))

(define (f3 x y)
  (local (c d)
    (println "f3-pre: a=" a " e b=" b)
    (println "f3-pre: c=" c " e d=" d)
    (println "f3-pre: x=" x " e y=" y)
    (setq c 30 d 40)
    (setq x 88 y 99)
    (println "f3-post: a=" a " e b=" b)
    (println "f3-post: c=" c " e d=" d)
    (println "f3-post: x=" x " e y=" y)))

(f1)
;-> f1-pre: a=nil e b=nil
;-> f2-pre: a=nil e b=nil
;-> f2-pre: c=nil e d=nil
;-> f3-pre: a=10 e b=20
;-> f3-pre: c=nil e d=nil
;-> f3-pre: x=10 e y=20
;-> f3-post: a=10 e b=20
;-> f3-post: c=30 e d=40
;-> f3-post: x=88 e y=99
;-> f2-post: a=10 e b=20
;-> f2-post: c=nil e d=nil
;-> f2-post: x=nil e y=nil
;-> f1-post: a=10 e b=20

Esempio 3
---------

(define (f1 x y)
  (local (a b)
    (println "f1-pre: a=" a " e b=" b)
    (println "f1-pre: x=" x " e y=" y)
    (setq a x b y)
    (f2)
    (println "f1-post: a=" a " e b=" b)
    (println "f1-post: x=" x " e y=" y)))

(define (f2)
    (println "f2-pre: a=" a " e b=" b)
    (println "f2-pre: x=" x " e y=" y)
    (setq a 10 b 20)
    (setq x 11 y 22)
    (println "f2-post: a=" a " e b=" b)
    (println "f2-post: x=" x " e y=" y))

(f1 1 2)
;-> f1-pre: a=nil e b=nil
;-> f1-pre: x=1 e y=2
;-> f2-pre: a=1 e b=2
;-> f2-pre: x=1 e y=2
;-> f2-post: a=10 e b=20
;-> f2-post: x=11 e y=22
;-> f1-post: a=10 e b=20
;-> f1-post: x=11 e y=22

Esempio 4
---------
Shadowing delle variabili a e b

(define (f1)
  (local (a b)
    (println "f1-pre: a=" a " e b=" b)
    (setq a 1 b 2)
    (f2)
    (println "f1-post: a=" a " e b=" b)))

(define (f2)
  (local (a b)
    (println "f2-pre: a=" a " e b=" b)
    (setq a 10 b 20)
    (println "f2-post: a=" a " e b=" b)))

(f1)
;-> f1-pre: a=nil e b=nil
;-> f2-pre: a=nil e b=nil
;-> f2-post: a=10 e b=20
;-> f1-post: a=1 e b=2


-------------
Torte e tagli
-------------

Un numero poligonale centrale designa il numero massimo di pezzi in cui può essere diviso una torta con n tagli. La formula generatrice è: n*(n + 1)/2 + 1.

Quando un cerchio viene tagliato n volte per produrre il numero massimo di pezzi, rappresentato come p = f(n), si deve considerare l'ennesimo taglio: il numero di pezzi prima dell'ultimo taglio è f(n - 1), mentre il numero di pezzi aggiunti dall'ultimo taglio è n.
Per ottenere il numero massimo di pezzi, l'ennesima linea di taglio deve attraversare tutte le altre linee di taglio precedenti all'interno del cerchio, ma non incrociare alcuna intersezione delle linee di taglio precedenti. Pertanto, l'ennesima linea stessa viene tagliata in n - 1 punti e in n segmenti di linea. Ogni segmento divide ogni pezzo del pancake ((n - 1) pezzi) in 2 parti, aggiungendo esattamente n al numero di pezzi. La nuova linea non può avere più segmenti poiché può attraversare ogni linea precedente solo una volta. Una linea di taglio può sempre attraversare tutte le linee di taglio precedenti, poiché ruotando il coltello di un piccolo angolo attorno a un punto che non è un'intersezione esistente, e se l'angolo è abbastanza piccolo, intersecheremo tutte le linee precedenti, inclusa l'ultima aggiunta.

Pertanto, il numero totale di pezzi dopo n tagli vale:

f(n) = n + f(n − 1)

Questa relazione di ricorrenza può essere risolta.

Se f(n − 1) si espande di un termine la relazione diventa:

f(n) = n + (n − 1) + f(n − 2)

L'espansione del termine f(n - 2) può continuare fino a quando l'ultimo termine non viene ridotto a f(0), quindi:

f(n) = n + (n − 1) + (n − 2) + ... + 1 + f(0)

Poichè f(0) = 1, perchè c'è un pezzo prima di eseguire qualsiasi taglio, questo può essere riscritto come:

f(n) = 1 + ( 1 + 2 + 3 + ... + n ) .

Questo può essere semplificato, utilizzando la formula per la somma di una progressione aritmetica:

f(n) = 1 + n*(n + 1)/2 = (n^2 + n + 2)/2

La funzione in newLISP è semplice:

(define (torta tagli) (/ (+ (* tagli tagli) tagli 2)2))

(torta 5)
;-> 16

(torta 12)
;-> 79


------------
Il ciclo for
------------

Vediamo la definizione della funzione "for" dal manuale di riferimento:

****************
>>>funzione FOR
****************
sintassi: (for (sym num-from num-to [num-step [exp-break]]) body)

Valuta ripetutamente le espressioni nel corpo (body) per un intervallo di valori specificato in num-from e num-to, inclusi. È possibile specificare una dimensione del passo con num-passo. Se non viene specificata alcuna dimensione del passo, si assume 1.

Facoltativamente, una condizione per l'uscita anticipata dal ciclo può essere definita in exp-break. Se l'espressione break restituisce un valore diverso da zero, il ciclo for restituisce il valore di exp-break. La condizione di rottura viene testata prima di valutare il corpo. Se viene definita una condizione di interruzione, è necessario definire anche num-step.

Il simbolo sym è locale in ambito dinamico rispetto all'espressione for. Assume ogni valore successivamente nell'intervallo specificato come valore intero se non viene specificata alcuna dimensione del passo o come valore in virgola mobile quando è presente una dimensione del passo. Dopo la valutazione dell'istruzione for sym assume il valore precedente.

(for (x 1 10 2) (println x))
;-> 1
;-> 3
;-> 5
;-> 7
;-> 9

(for (x 8 6 0,5) (println x))
;-> 8
;-> 7.5
;-> 7
;-> 6.5
;-> 6

(for (x 1100 2 (> (* x x) 30)) (println x))
;-> 1
;-> 3
;-> 5
;-> true

Il secondo esempio utilizza un intervallo di numeri dal più alto al più basso. Notare che la dimensione del passo è sempre un numero positivo. Nel terzo esempio, viene verificata una condizione di interruzione.

Usare la funzione "sequence" per creare una sequenza di numeri.

Sembra che il ciclo "for" di newLISP sia simile a quello di altri linguaggi (ad esempio il C), invece ci sono alcune importanti differenze. Vediamo alcuni esempi:

Esempio 1
---------
(setq i 10)
(for (i 1 3) (print i { }))
;-> 1 2 3 " "
(println i)
;-> 10

La variabile del ciclo "i" è locale alla funzione "for", quindi non possiamo usarla "fuori" della funzione a meno di utilizzare una seconda variabile:

(setq j 0)
(setq i 10)
(for (i 1 3) (setq j i) (print i { }))
;-> 1 2 3 " "
(setq i j)
;-> 3
(println i)
;-> 3

Esempio 2
---------
(for (i 1 5 1 (> i 2)) (print i { }))
;-> 1 2 true

Quando inseriamo una condizione di uscita (break) dobbiamo specificare anche il passo del ciclo. Inoltre il ciclo "for" restituisce true se la condizione di uscita viene verificata (altrimenti restituisce l'ultima espressione valutata).

(for (i 1 5 1 (> i 10)) (print i { }))
;-> 1 2 3 4 5 " "

Anche se la condizione di uscita viene verificata all'inizio del ciclo viene restituito true:

(for (i 1 5 1 (< i 3)) (print i { }))
;-> true

Esempio 3
---------
(for (i 5 1 1) (print i { }))
;-> 5 4 3 2 1 " "

Notare che il valore del passo vale 1 ed è sempre positivo. Sembra più logico scrivere (for i 5 1 -1), cioè partire dal numero cinque e arrivare al numero 1 utilizzando un passo uguale a -1, ma newLISP "ragiona" in un modo leggermente diverso: quello che è importante è la differenza tra il valore di arrivo e quello di partenza. Se la differenza è negativa, allora utilizza un passo negativo, altrimenti utilizza un passo positivo.
Nel nostro esempio abbiamo:

(arrivo - partenza) = (1 - 5) = -4, quindi newLISP utilizza un passo negativo (di valore 1)

Se specifichiamo un passo negativo, newLISP prende il valore assoluto e poi calcola la direzione del ciclo con il suo metodo:

(for (i 1 5 -1) (print i { }))
;-> 1 2 3 4 5 " "

Questo comporta che newLISP esegue sempre il corpo del ciclo (indipendentemente dal valore logico che si ottiene inizialmente confrontando il valore di partenza, quello di arrivo e il passo):

; partenza = arrivo
(for (i 1 1) (print i { }))
;-> 1 " "

; partenza > arrivo e passo positivo
; in altri linguaggi il corpo del ciclo non viene eseguito
; perchè non possiamo arrivare a 1 partendo da 3 con un passo positivo di valore 1
; invece newLISP...
(for (i 3 1 1) (print i { }))
;-> 3 2 1 " "
(for (i 3 1 -1) (print i { }))
;-> 3 2 1 " "

; partenza < arrivo e passo negativo
; in altri linguaggi il corpo del ciclo non viene eseguito
; perchè non possiamo arrivare a 3 partendo da 1 con un passo negativo di valore 1
; invece newLISP...
(for (i 1 3 -1) (print i { }))
;-> 1 2 3 " "
(for (i 1 3 1) (print i { }))
;-> 1 2 3 " "

Ricordare che il segno del passo non viene considerato da newLISP, quindi il corpo del ciclo "for" viene sempre eseguito (almeno una volta).


------------------------------------------------------------------
Perché uno specchio inverte destra e sinistra invece che su e giù?
------------------------------------------------------------------

GLi specchi non invertono sinistra e destra: questa è solo la nostra interpretazione di ciò che accade.
Il nostro riflesso nello specchio è in realtà invertito da davanti a dietro: se hai un neo sul lato sinistro del tuo viso, appare ancora sul lato sinistro del riflesso. Ma siamo abituati a vedere i volti di altre persone e istintivamente eseguiamo la rotazione mentale perché sappiamo che si sono girati di 180 gradi per fronteggiarci. L'immagine nello specchio viene riflessa, non ruotata, quindi quando la ruotiamo indietro nella nostra testa, appare invertita.
Ogni sezione dello specchio riflette semplicemente ciò che è direttamente di fronte ad esso. Quindi qualunque cosa sia alla mia destra mentre guardo nello specchio sarà alla mia destra nello specchio. Niente è stato invertito, è solo una riflessione, tutto qui.


--------------
Treni e mosche
--------------

Si racconta che sia stato chiesto a John von Neumann di risolvere un problema del seguente tipo:
Due treni sono diretti l'uno verso l'altro sullo stesso binario, ciascuno viaggiando a 60 km/ora. Quando sono a 2 km di distanza, una mosca parte dall'inizio del primo treno e viaggia a 90 km/ora fino alla parte anteriore dell'altro treno. Quindi torna al primo treno, e così via, avanti e indietro fino a che i due treni si scontrano tra loro. Quanto spazio ha coperto viaggia la mosca?

Esiste un modo rapido e un modo analitico per risolvere questo problema.

Il modo analitico è quello di calcolare la somma di una serie geometrica infinita.
La mosca completa la prima tappa del suo viaggio (viaggiando da un treno all'altro) in 4/5 di un minuto, poiché in questo tempo il treno in arrivo percorre 4/5 di km e la mosca vola per 6/5 di un km. Pertanto, dopo 4/5 di minuto, abbiamo una versione simile del problema originale, ma con i treni alla distanza di 2 - 2 x 4/5 = 2/5 km, o 1/5 della distanza originale, a parte. Questo schema continua, formando una serie geometrica infinita di distanze, la cui somma la distanza totale percorsa dalla mosca:

  6/5 * (1 + 1/5 + (1/5)^2 + (1/5)^3 + ...)

Dobbiamo trovare la somma delle serie geometriche infinite del tipo:

  S = 1 + r + r^2 + r^3 + ...

dove r è un numero reale con -1 < r < 1. (Abbiamo bisogno di questi limiti su r in modo che la serie
converga).
Moltiplicando per r, otteniamo:

  S*r =  r +  r^2 + r^3 + r^4 + ...

Sottraendo la seconda equazione dalla prima si ottiene:

  S - S*r = 1   ==>   S*(1 - r) = 1

e quindi:

  S = 1/(1 - r),

Ponendo r = 1/5, completiamo il nostro calcolo della distanza percorsa dalla mosca:

6/5 * 1/(1 - 1/5) = 3/2 km = 1.5 km

In newLISP possiamo calcolare una serie infinita nel modo seguente:

(define (sum r n)
  (let (s 1)
    (for (i 1 n)
      (setq s (add s (pow r i)))
    )
    s))

Oppure:

(define (sum r n)
  (add 1 (apply add (map (fn(x) (pow r x)) (sequence 1 n)))))

Proviamo il calcolo con 20 termini:

(sum .2 20)
;-> 1.249999999999998

Adesso moltiplichiamo per la costante 6/5 ed otteniamo la soluzione:

(mul (div 6 5) (sum .2 20))
;-> 1.499999999999997

In newLISP otteniamo una soluzione approssimata (dipende da quanti termini della serie calcoliamo).

Il modo più veloce di risolvere il problema è rendersi conto che i treni si scontrano dopo 1 minuto (dato che partono a 2 km di distanza e viaggiano alla velocità di 1 km al minuto). Poiché la mosca viaggia alla velocità di 1.5 km al minuto, allora in questo tempo (1 minuto) percorre 1.5 km.

La storia racconta che von Neumann rispose correttamente al problema... calcolando a mente il valore della serie infinita. E solo dopo si rese conto che esisteva un modo più semplice di ottenere la soluzione.


---------------------
Gestione degli errori
---------------------

Vediamo la definizione delle funzioni per la gestione degli errori dal manuale di riferimento.

************************
>>>funzione ERROR-EVENT
************************
sintassi: (error-event sym-event-handler | func-event-handler)
sintassi: (error-event nil)

sym-event-handler contiene una funzione utente per la gestione degli errori (error handler) . Quando si verifica un errore, il sistema esegue la funzione "reset" ed esegue la funzione utente per la gestione degli errori. Questa funzione può utilizzare la funzione predefinita "last-error" per recuperare il numero e il testo dell'errore. La funzione per la gestione degli errori può essere specificata come simbolo quotato o come funzione lambda

Per disabilitare "error-event" utilizare la seconda sintassi.

(define (my-handler)
  (print "error # " (first (last-error)) " has occurred\n") )

(error-event 'my-handler)  → my-handler

;; specify a function directly

(error-event my-handler)  → $error-event

(error-event
  (fn () (print "error # " (first (last-error)) " has occurred\n")))

(error-event exit)  → $error-event

Vedi anche la funzione "catch" che fornisce un modo diverso per gestire gli errori. Utilizzare "throw-error" per gestire gli errori dell'utente.

***********************
>>>funzione LAST-ERROR
***********************
sintassi: (last-error)
sintassi: (last-error int-error)

Riporta l'ultimo errore generato da newLISP a causa di errori di sintassi o esaurimento di alcune risorse. Per un riepilogo di tutti i possibili errori, vedere il capitolo Codici di errore in appendice del manuale di riferimento.

Se non si è verificato alcun errore dall'avvio della sessione newLISP, viene restituito nil.
Quando viene specificato int-error, viene restituito una lista contenente numero e testo dell'errore.

(last-error)  → nil

(abc)

ERR: invalid function: (abc)

(last-error) → (24 "ERR: invalid function: (abc)")

(last-error 24) → (24 "invalid function")
(last-error 1) → (1 "not enough memory")
(last-error 12345) → (12345 "Unknown error")

Per i numeri di errore fuori intervallo, viene fornita la stringa "Unknown error" per il testo dell'errore.

Gli errori possono essere intercettati da "error-event" e gestori di errori definiti dall'utente.

Vedere anche "net-error" per gli errori generati dalle condizioni di rete e "sys-error" per gli errori generati dal sistema operativo.

(last-error 1000)
;-> (1000 "Unknown error")
(last-error 0)
;-> nil

Lista degli errori
------------------

(define (get-errors)
  (let (err '())
    (for (i 1 100)
      (if (!= (list i "Unknown error") (last-error i))
          (push (last-error i) err -1)))
    (for (i 0 (- (length err) 1) 2)
      (println (err i) { } (err (+ i 1))))
  ))

(get-errors)
(1 "not enough memory")                (39 "regular expression")
(2 "environment stack overflow")       (40 "end of text [/text] tag")
(3 "call or result stack overflow")    (41 "mismatch in number of arguments")
(4 "problem accessing file")           (42 "problem in format string")
(5 "illegal token or expression")      (43 "data type and format don't match")
(6 "missing parenthesis")              (44 "invalid parameter")
(7 "string token too long")            (45 "invalid parameter: 0.0")
(8 "missing argument")                 (46 "invalid parameter: NaN")
(9 "number or string expected")        (47 "invalid UTF8 string")
(10 "value expected")                  (48 "illegal parameter type")
(11 "string expected")                 (49 "symbol not in MAIN context")
(12 "symbol expected")                 (50 "symbol not in current context")
(13 "context expected")                (51 "target cannot be MAIN")
(14 "symbol or context expected")      (52 "invalid list index")
(15 "list expected")                   (53 "array index out of bounds")
(16 "list or array expected")          (54 "invalid string index")
(17 "list or symbol expected")         (55 "nesting level to deep")
(18 "list or string expected")         (56 "list reference changed")
(19 "list or number expected")         (57 "invalid syntax")
(20 "array expected")                  (58 "user error")
(21 "array, list or string expected")  (59 "user reset -")
(22 "lambda expected")                 (60 "received SIGINT -")
(23 "lambda-macro expected")           (61 "function is not reentrant")
(24 "invalid function")                (62 "not allowed on local symbol")
(25 "invalid lambda expression")       (63 "no reference found")
(26 "invalid macro expression")        (64 "list is empty")
(27 "invalid let parameter list")      (65 "I/O error")
(28 "problem saving file")             (66 "no working directory found")
(29 "division by zero")                (67 "invalid PID")
(30 "matrix expected")                 (68 "cannot open socket pair")
(31 "wrong dimensions")                (69 "cannot fork process")
(32 "matrix is singular")              (70 "no comm channel found")
(33 "invalid option")                  (71 "ffi preparation failed")
(34 "throw without catch")             (72 "invalid ffi type")
(35 "problem loading library")         (73 "ffi struct expected")
(36 "import function not found")       (74 "bigint type not applicable")
(37 "symbol is protected")             (75 "not a number or infinite")
(38 "number out of range")             (76 "cannot convert NULL to string")

Definiamo una funzione utente per la gestione degli errori:

(define (error-handler)
  (print "Verificato errore # " (first (last-error)) "\n"))

Attiviamo la gestione degli errori da parte della funzione utente:

(error-event 'error-handler)

Proviamo:

(/ 10 0)
;-> Verificato errore # 29
(a 1)
;-> Verificato errore # 24

Disabilitiamo la gestione degli errori da parte della funzione utente:
(error-event nil)
;-> nil

La gestione degli errori è tornata al sistema:

(/ 20 0)
;-> ERR: division by zero in function /

Vediamo cosa accade quando si verifica un errore durante l'esecuzione di una funzione:

(define (error-handler)
  (print "Verificato errore # " (first (last-error)) "\n")
  (println a)
  (error-event nil))

(define (test)
  ; abilita la gestione degli errori
  ; da parte di una funzione utente
  (error-event 'error-handler)
  (setq a 10)
  ; questa istruzione genera un errore ==> esegue "error-handler" e poi esce
  (/ 10 0)
  ; questa istruzione non viene eseguita
  (println a))

(test)
;-> Verificato errore # 29
10

Adesso vediamo la definizione della funzione "reset".

******************
>>>funzione RESET
******************
sintassi: (reset)

"reset" torna al livello di valutazione superiore, disattiva la modalità di trace e passa al contesto/spazio dei nomi MAIN. "reset" ripristina l'ambiente delle variabili di primo livello utilizzando le variabili dell'ambiente salvate nello stack. Inoltre genera un errore "user-reset no error" che può essere segnalato con gestori di errori definiti dall'utente. Dalla versione 10.5.5 "reset" interrompe anche l'elaborazione dei parametri della riga di comando.
reset percorre l'intero spazio delle celle, operazione che potrebbe richiedere alcuni secondi in un sistema molto carico.
"reset" avviene automaticamente dopo una condizione di errore.

Per finire vediamo come gestire gli errori con la funzione "catch":

(define (check-division x y)
    (catch (/ x y) 'check-zero)
    (if (not (integer? check-zero))
        (setq check-zero "Division by zero."))
     check-zero
)

(println (check-division 10 4))
;-> 2
(println (check-division 4 0))
;-> Division by zero
(println (check-division 20 5))
;-> 4
(println (check-division 11 0))
;-> Division by zero


-------------------
Effetto percentuali
-------------------

La banca ci comunica che oggi il valore delle nostre azioni è aumentato del 10%. Comunque ieri era diminuito del 10%, quindi siamo in pareggio... o no?
Purtroppo siamo in perdita, infatti, supponendo che il valore originale fosse 1000 euro, abbiamo:

ieri: val = 1000 - 10% = 1000 - 100 = 900
oggi: val = 900 + 10% = 900 + 90 = 990

Anche viceversa (prima guadagno e poi perdita) saremmo in perdita (della stessa quantità):

ieri: val = 1000 + 10% = 1000 + 100 = 1100
oggi: val = 1100 - 10% = 1100 - 110 = 990

Quindi quanto dovrebbe valere la percentuale (di oggi) per recuperare la perdita di ieri?

Poniamo:

f = p/100

ad esempio: p = 20%   ==>   f = 20/100 = 0.2

val = x      ==>  x + p     = x + x*f              = x*(1 + f)
val = 1000   ==>  val + 20% = 1000 + 1000*(20/100) = 1000 + 1000*0.2

Il valore originale vale:         x

Il valore dopo la perdita vale:   x*(1 + f1)

Il valore dopo il guadagno vale: (x*(1 + f1)) * (1 + f2)

Quindi deve risultare:

x = (x*(1 + f1)) - (x*(1 + f1)) * (1 + f2)
x = x + f1*x - (x + x*f1)*(1 + f2)
x = x + f1*x - (x + x*f2 + x*f1 + x*f1*f2)
x = x + f1*x - x - x*f2 - x*f1 - x*f1*f2
x = - x*f2 - x*f1*f2
x + x*f2 + x*f1*f2 = 0
x + f2*(x + x*f1) = 0   ==>   f2 = -x/(x + x*f1)

Con la formula di f2 possiamo scrivere la funzione:

(define (perc2 x perc1) (div x (add x (mul x (div perc1 100)))))

(perc2 1000 -10)
;-> 1.111111111111111
(mul 900 (perc2 1000 -10))
;-> 1000
Cioè, se perdiamo il 10%, poi dobbiamo guadagnare l'11.1% per ritornare allo stesso valore (1000).

(perc2 1000 10)
;-> 0.9090909090909091
(mul 1100 (perc2 1000 10))
;-> 1000
Cioè, se guadagniamo il 10%, poi dobbiamo perdere il 9.09% per ritornare allo stesso valore (1000).

Attenzione alle percentuali!


----------------------------------------------
Teorema di Euclide (infinità dei numeri primi)
----------------------------------------------

Teorema: Esistono infiniti numeri primi.
In altre parole, per quanto grande si scelga un numero naturale n, esiste sempre un numero primo maggiore di n.

Dimostrazione per assurdo
Si supponga che i numeri primi non siano infiniti, ma solo P=(p1,p2,... ,pn). pn sarebbe allora il più grande dei numeri primi.
Poniamo M = p1*p2*...*pn (prodotto degli n numeri primi).
Consideriamo il valore (M + 1) = (p1*p2*...*pn) + 1: è un numero primo o è un numero composto?

Per completare il ragionamento abbiamo bisogno del Teorema Fondamentale dell’Aritmetica:
un numero o è primo o è ottenuto univocamente dal prodotto di numeri primi (composto).

Inoltre possiamo notare che per ogni numero primo pi risulta che la divisione (M + 1)/pi ha sempre resto 1.

Adesso abbiamo due possibilità:
1) il numero (M + 1) è primo
Abbiamo però che (M + 1) > pn, ma ciò contraddice la nostra ipotesi che pn sia il massimo dei numeri primi. Ne consegue che, se (M + 1) è primo, allora pn non è il massimo dei numeri primi.

2) il numero (M + 1) è composto
Se (M + 1) è un numero composto, deve essere per forza divisibile per un divisore. Ma abbiamo visto che, per costruzione, (M + 1) non può essere diviso né da p1, né da p2, né da pn, perché la divisione di un numero così costruito per questi fattori da sempre resto 1.
Se (M + 1) è composto, allora deve esistere un altro numero primo pm che deve essere forzatamente maggiore di pm perché diverso da tutti gli altri primi (questo è dovuto al teorema fondamentale dell'aritmetica).
Ma se pm > pn allora vuol dire che pn non è il massimo dei numeri primi.

In entrambi i casi abbiamo una contraddizione e si può affermare che:
supponendo che i numeri primi siano finiti si ottiene sempre una contraddizione e di conseguenza i numeri primi devono essere necessariamente infiniti.


----------------------
Il programma più corto
----------------------

In newLISP il programma più corto che può essere eseguito nella REPL è il seguente:

;

Il carattere che rappresenta l'inizio di un commento.


------------------------
Frequenza cifre pi greco
------------------------

pi greco = (acos -1) = 3.141592653589793...

Pi greco è un numero con cifre casuali. Per verificare questa affermazione prendiamo n cifre del numero pi greco e calcoliamo la loro frequenza. I file di testo con milioni di cifre per pi greco sono disponibili al seguente indirizzo:

https://archive.org/details/Math_Constants

Per spezzare un file possiamo usare la seguente funzione:

(define (file-copy from-file to-file from-char to-char)
    (setq i 1)
    (set 'in-file (open from-file "read"))
    (set 'out-file (open to-file "write"))
    (while (and (set 'chr (read-char in-file)) (<= i to-char))
        (if (>= i from-char) (write-char out-file chr))
        (++ i))
    (close in-file)
    (close out-file)
    "finished")

Partendo da un file con 1 miliardo (1000 milioni) di cifre:

file con 1 milione di cifre (senza 3.):
(file-copy "pi_dec_1000m.txt" "pi_dec_1m.txt" 3 1000002)
;-> "finished"
file con 10 milioni di cifre (senza 3.):
(file-copy "pi_dec_1000m.txt" "pi_dec_10m.txt" 3 10000002)
;-> "finished"
file con 100 milioni di cifre (senza 3.):
(file-copy "pi_dec_1000m.txt" "pi_dec_100m.txt" 3 100000002)
;-> "finished"

Adesso scriviamo la funzione che calcola la frequenza delle cifre per un file:

(define (freq-file file)
  (local (data chr freq)
    (setq freq (array 10 '(0)))
    (setq data (open file "read"))
    (while (setq num (eval-string (char (read-char data))))
        (if (number? num) (++ (freq num)))
    )
    (close data)
    freq
  ))

Vediamo cosa succede:

(freq-file "pi_dec_1m.txt")
;-> (99959 99758 100026 100229 100230 100359 99548 99800 99985 100106)
(freq-file "pi_dec_10m.txt")
;-> (999440 999333 1000306 999964 1001093 1000466 999337 1000207 999814 1000040)
(freq-file "pi_dec_100m.txt")
;-> (9999922 10002475 10001092 9998442 10003863 9993478 9999417 9999610 10002180 9999521)

Sembra proprio che le cifre di pi greco siano casuali...

Provate a trovare una data nelle cifre di pi greco con la seguente funzione:

(define (pi-birthday num-date)
  (setq file (open "pi_dec_100m.txt" "r"))
  (setq idx (search file (string num-date)))
  (close file)
  idx)

Cerchiamo la data 21 settembre 1980:
(pi-birthday 19800921)
;-> 9165287

Cerchiamo il giorno dello sbarco sulla luna 21 luglio 1969:
(pi-birthday 19690721)
;-> 2035915


-------------------------
Conversione a big-integer
-------------------------

Per definire un numero big-integer occorre aggiungere il carattere "L" al numero:

(+ 10L 20L)
;-> 30L

Per convertire un numero intero in big-integer possiamo usare la funzione integrata "bigint":

(bigint 10)
;-> 10L

Oppure utilizzare la conversione implicita (il tipo del risultato dipende dal primo operando):

(+ 0L 10)
;-> 10L

(+ 0 10L)
;-> 10

(++ 9L)
;-> 10L

Se passiamo un numero superiore a int64 viene convertito in big-integer (anche se non specifichiamo la lettera finale "L":

(+ 12378461278940612789346127804678120463871246234612784612545 1)
;-> 12378461278940612789346127804678120463871246234612784612546L

(+ 12378461278940612789346127804678120463871246234612784612545L 1)
;-> 12378461278940612789346127804678120463871246234612784612546L

Ma non vale se il primo operando è un int64 (e il secondo è un big-integer):

(+ 1 12378461278940612789346127804678120463871246234612784612545)
;-> ERR: number out of range in function +

(+ 1 12378461278940612789346127804678120463871246234612784612545L)
;-> ERR: number out of range in function +

La funzione "gcd" supporta con i big-integer:

(gcd 12378461278940612789346127804678120463871246234612784612545L
     66432828761348769123496764312340293782893478962349320991193L)
;-> 3L

(gcd 12378461278940612789346127804678120463871246234612784612545
     66432828761348769123496764312340293782893478962349320991193)
;-> 3L

(gcd 134 321)
;-> 1

(gcd 134L 321L)
;-> 1L

Anche in questo caso se il primo operando è un int64 (e il secondo un big-integer) otteniamo un errore:

(gcd 134 66432828761348769123496764312340293782893478962349320991193)
;-> ERR: number out of range in function gcd


----------------------------------------------------------------
Congettura 8424432925592889329288197322308900672459420460792433L
----------------------------------------------------------------

Si congettura che i due numeri prodotti dalle equazioni n^17 + 9 e (n+1)^17 + 9 per un dato n siano sempre coprimi (cioè, il loro massimo comune divisore è 1).

Funzione che calcola la potenza intera di due numeri interi (biginteger):

(define (** x p)
  (let (y 1L)
    (dotimes (i p)
      (setq y (* y x)))))

Funzione che calcola i due numeri e il loro Massimo Comun Divisore (gcd):

(define (f n)
  (local (a b)
    (setq a (+ (** n 17) 9))
    (setq b (+ (** (+ n 1) 17) 9))
    ;(println a { - } b)
    (gcd a b)))

(define (test n)
  (for (i 1 n)
    (if (!= (f i) 1) (println i))))

(test 100)
;-> nil

(time (test 1000000))
;-> 35222.204

Proviamo ad usare un'altra versione della funzione che calcola la potenza di due numeri interi:

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

(ipow (bigint 12) (bigint 101))
;-> 9938156942641746031009010831488421976193473742246733225
;-> 570422369239059031961454676453243399562296232626880512L

(define (g n)
  (local (a b)
    ;(bigint n)
    (setq a (+ (ipow (bigint n) 17L) 9L))
    (setq b (+ (ipow (+ 1L n) 17L) 9L))
    ;(setq a (+ (ipow n 17L) 9L))
    ;(setq b (+ (ipow (+ 1L n) 17L) 9L))
    ;(println a { - } b)
    (gcd a b)))

(g 25)
;-> 1L

(define (test1 n)
  (for (i 1 n)
    (if (!= (g i) 1) (println i))))

(test1 100)
;-> nil

(time (test1 1000000))
;-> 37550.083

Fino a n=1000000 i due numeri sono coprimi, ma, indipendentemente da quanto ottimizziamo le funzioni, non possiamo mai arrivare a calcolare se la congettura sia corretta o meno. Infatti il primo controesempio si ha per:

n = 8424432925592889329288197322308900672459420460792433

(f 8424432925592889329288197322308900672459420460792433L)
;-> 8936582237915716659950962253358945635793453256935559L
(g 8424432925592889329288197322308900672459420460792433L)
;-> 8936582237915716659950962253358945635793453256935559L

a = 54223994342646179058380356618237600945332452744447783811633226444
706840145560253543265726036832145128177789432208521052474357871396552
883725682145297321498918218354478800485735694975861256807297728953769
893103929230098025052894514403466394770904990028864878976324044044821
592051416751962701035874218121600183036261502732591815729434037884804
160927983508505810505709192305952680056837370387376148379793216718560
488169006176612685719519514795214718954001125189050831787603289426211
911180030081853896340397250694989280033195161440928768764775227010883
495154027281535795894248762159201471694414123617755674247339993539066
734119817112437829533591829524422255729623239462090029154069350527783
184704923865907347725268780279846639423625020376803594419176767107084
931496192777949752067359482586926753862402083283934355276863776930054
10063448224075882352899690251043898231682422328806149679482L

b = 54223994342646179058380356618237600945332452744447893232399225375
209266712078431719483738073648487224059383831697999678327408100141336
991025881588579477964498533991409989912763419887691604377050455544019
054574804855529430469982522730989408672965187161333391643781413916588
545511024186259721689804571708801881316258497013141186296413148273718
400779029194737615474809188738518912788375420535118546429527937700302
149462398156084100850976785997309801553853766736897061232608205624871
298724159587383286059335663902625524582680124910168097058456424147988
880721305500824538567368687499354308989937809076241065086298676278672
263416684098360012514500425402719785361771648158147911462496374525910
033905217420022640052099451351878592869628864404070519454212140328594
703336995154486215002765901658624392447143569841733943999245865859272
00563811508612111669423809712025508253890314787725191020553L

Vediamo la velocità della funzione quando usiamo i big-integer:

(define (testbig start end)
  (for (i start end)
    (if (!= (f i) 1) (println i))))

(testbig 8424432925592889329288197322308900672459420460792430L 8424432925592889329288197322308900672459420460792433L)
;-> ERR: number out of range in function for
;-> called from user function (testbig ...

La funzione "for" non supporta i big-integer come indice, allora usiamo la funzione "while":

(define (testbig start end)
  (while (< start end)
    (if (!= (f start) 1) (println start))
    (++ start)))

(testbig 8424432925592889329288197322308900672459420460792430L 8424432925592889329288197322308900672459420460792433L)
;-> 8424432925592889329288197322308900672459420460792433L

Vediamo quanto tempo occorre per calcolare 100000 di valori con i numeri big-integer:

(- 8424432925592889329288197322308900672459420460792433L 100000L)
;-> 8424432925592889329288197322308900672459420460692433L

(time (testbig 8424432925592889329288197322308900672459420460692433L 8424432925592889329288197322308900672459420460792433L))
;-> 37737.671

Quanto tempo ci vuole per arrivare a questo numero partendo da 1?

(* 37737L (/ 8424432925592889329288197322308900672459420460792433L 100000L))
;-> 3179128253130988646193487023519709846766011499254359L ;millisecondi

Trasformiamo i millisecondi in anni:

(define (ms2time ms)
  (letn ((mins (/ ms 1000 60))
        (secs (% (/ ms 1000) 60))
       ;(println (format "%d millisec = %d minuti e %d secondi." ms mins secs))
       ;(println mins secs))
        (hours (/ mins 60))
        (days (/ hours 24))
        (years (/ days 365)))
        years))

(ms2time 3179128253130988646193487023519709846766011499254359L)
;-> 100809495596492536979752886336875629336821L ;anni!!!

Ci vogliono 1.008094955964925e+041 anni.

L'età dell'universo è 13.8 miliardi di anni (1.38e+010)...

In realtà non hanno calcolato il numero, ma hanno costruito il problema in modo che la soluzione fosse quella desiderata. Nella teoria dei numeri, ci sono vari teoremi che ti dicono come si relazioneranno due numeri e, se vengono usati in modo intelligente, è possibile creare problemi come questo.

Un altro esempio è il seguente:

(n^19 + 6) e (n+1)^16 + 9

n = 1578270389554680057141787800241971645032008710129107338825798

(define (f n)
  (local (a b)
    (setq a (+ (** n 19) 6))
    (setq b (+ (** (+ n 1) 19) 6))
    ;(println a { - } b)
    (gcd a b)))

(define (test n)
  (for (i 1 n)
    (if (!= (f i) 1) (println i))))

(test 100)
;-> nil

(time (test 1000000))
;-> 43908.677

(f 1578270389554680057141787800241971645032008710129107338825798L)
;-> 5299875888670549565548724808121659894902032916925752559262837L


-------------------
floor, ceil e fract
-------------------

Definizioni:

(floor x) = max (m ≤ x) dove m è intero
(ceil x) = min (n ≥ x) dove n è intero
(fract x) = x - (floor x)

QUindi risulta:

(x - 1) < m ≤ x ≤ n < (x + 1)

(x mod y) = x - y*(floor x/y)

|  x   | Floor | Ceiling | Fractional |
+------+-------+---------+------------+
|  2   |   2   |   2     |   0        |
|  2.4 |   2   |   3     |   0.4      |
|  2.9 |   2   |   3     |   0.9      |
| −2.7 |  −3   |  −2     |   0.3      |
| −2   |  −2   |  −2     |   0        |

La notazione matematica è la seguente:

(floor x) con trattino basso "˩"
(ceil x) con trattino basso "˥"
(fract x) con parentesi graffe "{}"

Vediamo alcuni esempi:
(ceil -10.3)
;-> -10
(ceil 10.3)
;-> 11
(ceil -10.6)
;-> -10
(ceil 10.6)
;-> 11
(floor -10.3)
;-> -11
(floor 10.3)
;-> 10
(floor -10.6)
;-> -11
(floor 10.6)
;-> 10


----------------
Multipli di nove
----------------
Un fatto noto nella teoria dei numeri è che se prendiamo un intero positivo e sottraiamo la somma delle sue cifre da quel numero, otteniamo un multiplo di 9.

(define (mul9 n)
  (- n (apply + (map int (explode (string n))))))

(mul9 12375621)
;-> 12375594

(% 12375594 9)
;-> 0

Verifichiamo il teorema:

(define (test num)
  (if (!= 0 (% (mul9 num) 9)) (println num)))

(test 100000)
;-> nil


---------------
fizzbuzz esteso
---------------

Problema:
Stampare i numeri da 1 a 100, tranne nei seguenti casi
1) se il numero è divisibile per 3, allora scrivi "fizz"
2) se il numero è divisibile per 5, scrivi invece "buzz"
3) se il numero è divisibile per 15, scrivi invece "fizzbuzz".

Questo problema, nato come un gioco per bambini, è diventato un test di base per la valutazione dei programmatori di computer.

Versione 1 (naif)
-----------------

(setq fb
'(1  2 fizz  4 buzz fizz  7  8 fizz buzz 11 fizz 13 14 fizzbuzz
 16 17 fizz 19 buzz fizz 22 23 fizz buzz 26 fizz 28 29 fizzbuzz
 31 32 fizz 34 buzz fizz 37 38 fizz buzz 41 fizz 43 44 fizzbuzz
 46 47 fizz 49 buzz fizz 52 53 fizz buzz 56 fizz 58 59 fizzbuzz
 61 62 fizz 64 buzz fizz 67 68 fizz buzz 71 fizz 73 74 fizzbuzz
 76 77 fizz 79 buzz fizz 82 83 fizz buzz 86 fizz 88 89 fizzbuzz
 91 92 fizz 94 buzz fizz 97 98 fizz buzz))

(define (fizzbuzz1)
  (dolist (num fb) (print num { })))

(fizzbuzz1)

Versione 2 (base)
-----------------

(define (fizzbuzz2)
  (for (num 1 100)
    (cond ((zero? (% num 15)) (print "fizzbuzz "))
          ((zero? (% num 5))  (print "buzz "))
          ((zero? (% num 3))  (print "fizz "))
          (true (print num { })))))

(fizzbuzz2)

Versione 3 (ciclica)
--------------------

(setq ciclo15 '(fizzbuzz 0 0 fizz 0 buzz fizz 0 0 fizz buzz 0 fizz 0 0))

(define (fizzbuzz3)
  (for (num 1 100)
    (if (zero? (ciclo15 (% num 15)))
        (print num { })
        (print (ciclo15 (% num 15)) { }))))

(fizzbuzz3)

Versione 4 (euclide)
--------------------

(define (fizzbuzz4)
  (local (alto basso)
    (for (num 1 100)
      (setq alto (max num 15))
      (setq basso (min num 15))
      (while (> (% alto basso) 0)
        (map set '(alto basso) (list (+ basso) (% alto basso))))
      ;(println basso)
      (cond ((= basso 15) (print "fizzbuzz "))
            ((= basso 5) (print "buzz "))
            ((= basso 3) (print "fizz "))
            ((= basso 1) (print num { }))
            (true (print "ERRORE "))
            ))))

(fizzbuzz4)

Versione 5 (trigonometria)
--------------------------

(define (fizzbuzz5)
  (local (f b)
    (for (num 1 100)
      (setq f (cos (div (mul num 2 PI) 3)))
      (setq b (cos (div (mul num 2 PI) 5)))
      (cond ((and (= f 1) (= b 1)) (print "fizzbuzz "))
            ((= b 1) (print "buzz "))
            ((= f 1) (print "fizz "))
            (true (print num { }))))))

(fizzbuzz5)

Versione 6 (moltiplicazione matrici)
------------------------------------

(define (fizzbuzz6)
  (local (a b ab val)
    (setq a '((1 0 0) (2 -2 0) (2 0 -2) (3 -3 -3)))
    (for (num 1 100)
      (setq b (list (list 1 (% num 3) (% num 5))))
      (setq ab (multiply a (transpose b)))
      (setq val (ref (apply max (flat ab)) (flat ab)))
      (cond ((= val '(3)) (print "fizzbuzz "))
            ((= val '(2)) (print "buzz "))
            ((= val '(1)) (print "fizz "))
            ((= val '(0)) (print num { }))
            (true (print "ERRORE "))))))

(fizzbuzz6)

Versione 7 (stringhe)
---------------------

(define (fizzbuzz7)
  (local (vec)
    (setq vec (array 101 '("")))
    (for (num 1 100)
      (if (zero? (% num 3)) (setf (vec num) (append (vec num) "fizz")))
      (if (zero? (% num 5)) (setf (vec num) (append (vec num) "buzz")))
      (if (and (!= (% num 3) 0) (!= (% num 5) 0) (setf (vec num) (string num))))
    )
    (for (i 1 100) (print (vec i) { }))))

(fizzbuzz7)

Tutte le versioni stampano il seguente risultato:
;-> 1 2 fizz 4 buzz fizz 7 8 fizz buzz 11 fizz 13 14 fizzbuzz
;-> 16 17 fizz 19 buzz fizz 22 23 fizz buzz 26 fizz 28 29 fizzbuzz
;-> 31 32 fizz 34 buzz fizz 37 38 fizz buzz 41 fizz 43 44 fizzbuzz
;-> 46 47 fizz 49 buzz fizz 52 53 fizz buzz 56 fizz 58 59 fizzbuzz
;-> 61 62 fizz 64 buzz fizz 67 68 fizz buzz 71 fizz 73 74 fizzbuzz
;-> 76 77 fizz 79 buzz fizz 82 83 fizz buzz 86 fizz 88 89 fizzbuzz
;-> 91 92 fizz 94 buzz fizz 97 98 fizz buzz


----------------------------------------------------
Conversione tra liste, stringhe, caratteri e simboli
----------------------------------------------------

Definiamo due funzioni che convertono una stringa in una lista di caratteri e vicerversa.

Stringa --> lista di caratteri
------------------------------
(define (str-chars str) (explode str))

(str-chars "explode")
;-> ("e" "x" "p" "l" "o" "d" "e")
(str-chars "0123")
;-> ("0" "1" "2" "3")

Lista di caratteri --> stringa
------------------------------
(define (chars-str lst) (join lst))

(chars-str '("j" "o" "i" "n"))
;-> "join"
(chars-str '("0" "1" "2" "3"))
;-> "0123"

(str-chars (chars-str '("e" "x" "p" "l" "o" "d" "e")))
;-> ("e" "x" "p" "l" "o" "d" "e")
(chars-str (str-chars "explode"))
;-> "explode"

Adesso definiamo due funzioni che convertono una lista di simboli in una stringa.

Lista di simboli --> stringa
----------------------------
(define (lst-str lst merge)
  (if merge
      (join (map string lst))
      (join (map string lst) " ")))

Il parametro "merge" permette di riunire tutti gli elementi della lista in una stringa unica.

(lst-str '(a f 3 t h u))
;-> "a f 3 t h u"
(lst-str '(a f 3 t h u) true)
;-> "af3thu"
(lst-str '(af3thu))
;-> "af3thu"
(lst-str '(af3thu) true)
;-> "af3thu"

Stringa -> lista di simboli
(define (str-lst str merge)
  (if (or merge (find " " str))
      (map sym (parse str))
      (map sym (explode str))))

Il parametro "merge" permette di creare una lista con un unico simbolo (tutta la stringa).

(str-lst "af3thu")
;-> (a f 3 t h u)
(str-lst "af3thu" true)
;-> (af3thu)
(str-lst "a f 3 t h u"))
;-> (a f 3 t h u)
(str-lst "a f 3 t h u" true)
;-> (a f 3 t h u)

Nota: La funzione "sym" crea un simbolo anche per il carattere spazio " ".
Utilizzare il carattere " " come simbolo nei programmi è una delle strade per diventare matti.

(setq lista (map sym (explode "a b c")))
;-> (a   b   c)
(length lista)
;-> 5
(string (lista 1) (lista 2))
;-> " b"


---------------------
Divisori di un numero
---------------------

Abbiamo visto diverse funzioni che calcolano i divisori di un numero, la somma dei divisori o il numero dei divisori. Riportiamo le funzioni che consideriamo più veloci e i relativi algoritmi. Da notare che gli algoritmi usati non sono quelli migliori/ottimali, ma quelli che risultano più veloci all'interno di newLISP. In questo caso sfruttiamo il fatto che la funzione "factor" è integrata in newLISP, quindi è molto veloce.

Scomposizione in fattori primi di un numero:

num = p(1)^a(1) * p(2)^a(2) * ... * p(k)^a(k)

p(i) = numero primo
a(i) = esponente

numero dei divisori = (a(1) + 1) * (a(2) + 1) * ... * (a(k) + 1)

somma dei divisori = (1 + p(1) + p(1)^2 + ... + p(1)^a(1)) *
                     (1 + p(2) + p(2)^2 + ... + p(2)^a(2)) * ... *
                     (1 + p(k) + p(k)^2 + ... + p(k)^a(k))

I divisori possono essere generati ricorsivamente utilizzando tutti i primi p(i) e le loro occorrenze a(i). Ogni fattore primo p(i), può essere incluso x volte dove 0 ≤ x ≤ a(i).

Lista dei divisori
------------------

(define (divisors-aux cur-index cur-divisor)
  (cond ((= cur-index (length f))
         (push cur-divisor out -1)
        )
        (true
         (for (i 0 (f cur-index 1))
           (divisors-aux (+ cur-index 1) cur-divisor)
           (setq cur-divisor (* cur-divisor (f cur-index 0)))
         ))))

(define (divisors num)
  (local (f out)
    (cond ((= num 1) '(1))
          (true
           (setq f (factor-group num))
           (setq out '())
           (divisors-aux 0 1)
           (sort out)))))

(divisors 1)
;-> (1)
(divisors 360)
;-> (1 2 3 4 5 6 8 9 10 12 15 18 20 24 30 36 40 45 60 72 90 120 180 360)
(divisors 123456789)
;-> (1 3 9 3607 3803 10821 11409 32463 34227 13717421 41152263 123456789)

Numero di divisori
------------------

(define (divisors-count num)
  (if (= num 1) '1
      (begin
        (setq lst (factor-group num))
        (apply * (map (fn(x) (+ 1 (last x))) lst)))))

(divisors-count 1)
;-> 1
(divisors-count 360)
;-> 24
(divisors-count 123456789)
;-> 12

Somma dei divisori
------------------

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

(divisors-sum 1)
;-> 1
(divisors-sum 360)
;-> 1170
(divisors-sum 123456789)
;-> 178422816


-------------------
Sequenza di Collatz
-------------------

Vediamo alcune funzioni per giocare con la sequenza di collatz:

Funzionale:

(define (collatzf n)
  (if (= n 1) '(1)
    (cons n (collatzf (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

(collatzf 50)
;-> (50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

(time (collatzf 123456789) 1000)
;-> 106.748

(define (collatzf-length n)
  (if (= n 1) 1
    (+ 1 (collatzf-length (if (even? n) (/ n 2) (+ 1 (* 3 n)))))))

(collatzf-length 123456789)
;-> 178

(time (collatzf-length 123456789) 10000)
;-> 317.179

Iterativo:

(define (collatzi n)
  (let (out (list n))
    (while (!= n 1)
      (if (even? n)
          (setq n (/ n 2))
          (setq n (+ (* 3 n) 1))
      )
      (push n out -1)
    )
    out))

(collatzi 50)
;-> (50 25 76 38 19 58 29 88 44 22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1)

(time (collatzi 123456789) 1000)
;-> 23.965

(define (collatzi-length n)
  (let (c 1)
    (while (!= n 1)
      (if (even? n)
          (setq n (/ n 2))
          (setq n (+ (* 3 n) 1))
      )
      (++ c)
    )
    c))

(collatzi-length 123456789)
;-> 178

(time (collatzi-length 123456789) 10000)
;-> 207.01

Le funzioni iterative sono più veloci di quelle funzionali.

Test di correttezza:

(for (i 1 10000) (if (!= (collatzf i) (collatzi i)) (println i)))
;-> nil
(for (i 1 10000) (if (!= (collatzf-length i) (collatzi-length i)) (println i)))
;-> nil


----------
Generatore
----------

Vediamo come possiamo creare un generatore di elementi di una lista. Quando gli elementi sono finiti il generatore produce nil.

(context 'list-gen)

(define (list-gen:init lst)
  (let (n (length lst))
    (setq
          list-gen:items (array n lst)
          list-gen:i 0
          list-gen:end n)))

(define (list-gen:next)
  (if (= list-gen:i list-gen:end)
      nil
      (begin (++ list-gen:i) (list-gen:items (- list-gen:i 1)))))

(context MAIN)
(list-gen:init (sequence 10 12))
;-> 3 ; numero di elementi della lista
(list-gen:next)
;-> 10
(list-gen:next)
;-> 11
(list-gen:next)
;-> 12
(list-gen:next)
;-> nil

Il numero di elementi della lista ci dice quante volte possiamo chiamare la funzione "list-gen:next" prima di ottenere nil.


------------------------
Multiplo con tutti 1 e 0
------------------------

Un teorema afferma che per ogni numero intero positivo N, esiste un multiplo di N che consiste solo di cifre 1 e 0.
Scrivere una funzione che dato un numero N calcola il multiplo di N che contiene solo cifre 1 e 0.

La soluzione più semplice è quella di moltiplicare ripetutamente il numero e verificare se il valore è costituito solo da 1 e 0.

Scriviamo una funzione che verifica se un numero è costituito solo da 1 e 0:

(define (check-num num)
  (let (out true)
    (while (and (!= num 0) out)
      (if (> (% num 10) 1) (setq out nil))
      (setq num (/ num 10))) out))

(check-num 123)
;-> nil
(check-num 1010)
;-> true
(check-num 10101011L)
;-> true

Adesso scriviamo la funzione che calcola il numero costituito solo da 1 e 0:

(define (uno-zero num iter)
  (catch
    (let (a (bigint num))
    (for (i 1 iter)
      (if (check-num (* a i)) (throw (list a i (* a i))))))))

(uno-zero 3 100)
;-> (3L 37 111L)
(uno-zero 12 1000)
;-> (12L 925 11100L)
(uno-zero 21 1000)
;-> (21L 481 10101L)
(uno-zero 12345 1000000)
;-> (12345L 891058 11000111010L)
(uno-zero 123456 10000000)
;-> nil

Come si nota, dobbiamo specificare il numero di moltiplicazioni (iterazioni) e quindi non sempre otteniamo un risultato. Inoltre dobbiamo utilizzare i big-integer. Proviamo con un ciclo infinito:

(define (uno-zero num)
  (catch
    (let ((a (bigint num)) (i 1))
    (while true
      (if (check-num (* a i)) (throw (list a i (* a i))))
      (++ i)))))

(uno-zero 3)
;-> (3L 37 111L)
(uno-zero 12)
;-> (12L 925 11100L)
(uno-zero 21)
;-> (21L 481 10101L)
(uno-zero 12345)
;-> (12345L 891058 11000111010L)

Putroppo (uno-zero 123456) non finisce in un tempo ragionevole...

Per trovare un'altro metodo facciamo il seguente ragionamento:
Consideriamo gli (N + 1) numeri interi 1, 11, 111, ... , 111...1, (N+1 1).
Quando vengono divisi per N, lasciano (N + 1) resti. Secondo il principio dei cassetti o della piccionaia (pigeonhole principle), due di questi resti sono uguali, quindi la differenza tra i due interi corrispondenti è un intero costituito solo da cifre 1 e 0 che è divisibile per N. Per inciso, questa è anche una dimostrazione del teorema.

Esempio 1:
N = 3
; lista di 3+1 numeri con tutti 1
(setq one '(1 11 111 1111))
; calcolo dei resti
(map (fn(x) (% x 3)) one)
;-> (1 2 0 1)
Abbiamo due resti uguale a 1, che corrispondono ai numeri 1 e 1111.
Calcoliamo la differenza tra questi due numeri:
(- 1111 1)
;-> 1110
Abbiamo ottenuto un numero "1110" composto solo da 1 e 0.
Dividiamo il numero per verificare la correttezza:
(div 1110 3)
;-> 370
Quindi il numero 3 moltiplicato per 370 genera il numero 1110 che è costituito solo da 1 e 0.

Esempio 2:
N=12
(setq one '(1 11 111 1111 11111 111111 1111111 11111111 111111111 1111111111 11111111111 111111111111 1111111111111))
(map (fn(x) (% x 12)) one)
;-> (1 11 3 7 11 3 7 11 3 7 11 3 7)
Prendiamo i due numeri che hanno resto 11 (il secondo e il quinto):
(- 11111 11)
;-> 11100
(div 11100 12)
;-> 925
Quindi il numero 12 moltiplicato per 925 genera il numero 111100 che è costituito solo da 1 e 0.

Quindi il nostro algoritmo sarà il seguente:

0. creare una hash-map (che conterrà elementi con chiave uguale al resto e valore uguale al relativo numero con tutti 1).
1. generare il prossimo numero con tutti 1 (numero one)
2. calcolare il resto della divisione tra il numero one e il numero dato
3. se il resto non esiste nella hash-map,
      allora inserirlo nella hash-map (resto one) e andare al passo 1
      altrimenti recuperare il numero nella hash-map che ha la chiave uguale a resto e sottrarlo al numero one attuale.
      Fine.

Scriviamo la funzione in forma estesa:

(define (uz num)
  (let ((out 0L) (val 1L) (dv 0) (primo 0) (secondo 0))
    (new Tree 'myHash)
    (myHash "1L" 1L)
    (for (i 1 num 1 (!= out 0))
      ;calcola il prossimo numero con tutti 1 (11, 111, 1111, ...)
      (setq val (+ (pow-i 10L i) val))
      ; calcola il resto della divisione tra il numero con tutti 1 e il numero dato
      (setq dv (% val num))
      ;(println "val: " val { } "dv: " dv)
      (cond ((= dv 0) (setq out val))
            (true
              ; se la chiave non esiste nella hashmap...
              (if (null? (myHash (string dv)))
                  (begin
                    ; allora inserisce la chiave (dv) con il valore (val)
                    ;(println "insert: " dv { } val)
                    (myHash (string dv) val)
                  )
                  ; altrimenti calcoliamo il risultato
                  (begin
                    ;(println "calcolo...")
                    ; prendo il primo valore con lo stesso resto dala hash map
                    (setq primo (myHash (string dv)))
                    ; prendo il secondo valore con lo stesso resto (ultimo valore)
                    (setq secondo val)
                    ;(println "primo: " primo { } "secondo: " secondo)
                    ; calcolo la differenza
                    (setq out (- secondo primo))
                    ;(println "out: " out)
                  )
              )
              ;(read-line)
            )
      )
    )
    ; elimina la hashmap
    (delete 'myHash)
    (list out (/ out num))))

(uz 3)
;-> (111L 37L)
(* 37 3)
;-> 111
(uz 12)
;-> (11100L 925L)
(uz 10)
;-> (10L 1L)
(uz 21)
;-> (111111L 5291L)
(uz 1234)
;-> (11111111111111111111111111111111111111111111111111111111111111111111111111111111111111110L
;->  9004141905276427156491986313704303979830722132180803169457950657302359085179182423915L)
(div 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111110L
     9004141905276427156491986313704303979830722132180803169457950657302359085179182423915L)
;-> 1234

Le funzioni (uno-zero e uz) producono due risultati differenti, ma entrambi sono corretti (cioè sono multipli di N e contengono solo cifre 1 e 0). La seconda funzione produce numeri più grandi.

La funzione (uz 12345) produce un numero molto lungo:

(length (last (uz 12345)))
;-> 818

Riscriviamo la funzione in maniera più compatta:

(define (uz num)
  (let ((out 0L) (val 1L) (dv 0L))
    (new Tree 'myHash)
    (myHash "1L" 1L)
    (for (i 1 num 1 (!= out 0))
      ; calcola il prossimo numero con tutti 1 (11, 111, 1111, ...)
      (setq val (+ (pow-i 10L i) val))
      ; calcola il resto della divisione tra il numero con tutti 1 e il numero dato
      (setq dv (% val num))
      (cond ((= dv 0) (setq out val))
            (true
              ; se la chiave non esiste nella hashmap...
              (if (null? (myHash (string dv)))
                  ; allora inserisce la chiave (dv) con il valore (val)
                  (myHash (string dv) val)
                  ; altrimenti calcoliamo il risultato...
                  ; che è la differenza tra il valore attuale del numero one (val)
                  ; e il valore del numero one (nella hash-map) che ha lo stesso resto
                  ; del numero one attuale (myHash (string dv))
                  (setq out (- val (myHash (string dv))))
              )
            )
      )
    )
    ; elimina la hashmap
    (delete 'myHash)
    (list out (/ out num))))

(uz 3)
;-> (111L 37L)
(* 37 3)
;-> 111
(uz 10)
;-> (10L 1L)
(uz 123)
;-> (111111111111111L 903342366757L)
(uz 1234)
;-> (11111111111111111111111111111111111111111111111111111111111111111111111111111111111111110L
(11111111111111111111111111111111111111111111111111111111111111111111111111111111111111110L
 9004141905276427156491986313704303979830722132180803169457950657302359085179182423915L)
(div 11111111111111111111111111111111111111111111111111111111111111111111111111111111111111110L
 9004141905276427156491986313704303979830722132180803169457950657302359085179182423915L)
 ;-> 1234

Con questa ultima funzione possiamo usare come parametro dei numeri maggiori:

(length (last (uz 12345)))
;-> ;-> 818
(length (last (uz 123456)))
;-> 321

Ma anche in questo caso i numeri raggiungono presto dei valori praticamente intrattabili:

(time (println (length (last (uz 1234567)))))
;-> 34013      ; cifre del multiplo di 1234567 che contiene solo 1 e 0.
;-> 99618.592  ; circa 100 secondi

Comunque è interessante la dimostrazione del teorema.


---------------------------
Risolvere i sistemi lineari
---------------------------

Funzioni per la soluzione di un sistema lineare:
1) sislin-g (metodo di eliminazione di Gauss)
1) sislin-c (metodo di Cramer)

;; @syntax (sislin-g matrix terms)
;; @description Solve a linear system with Gauss's method (elimination with pivot and backwards substitution)
;; @param <matrix> matrix of the linear system
;; @param <terms> known terms
;; @return list of solutions (sol1 sol2...soln) (float) or nil
;; @example
;; (sislin-g '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))   ==> (-1 2 1)
;; (sislin-g '((1 2 3) (-3 -2 3) (4 -5 2)) '(1 -1 1))  ==> (0.3620689655172414 0.1379310344827586 0.1206896551724138)
;; (sislin-g '((2 1 1) (4 -1 1) (4 2 2)) '(1 -5 5))    ==> nil
(define (sislin-g matrix terms)
  (local (n m p rowx amax xfac temp temp1 x)
    (setq rowx 0) ;conta il numero di scambio righe
    (setq n (length matrix))
    ;(setq x (dup '0 n))
    (setq x (array n (dup '0 n)))
    (for (k 0 (- n 2))
      (setq amax (abs (matrix k k)))
      (setq m k)
      ; trova la riga con il pivot più grande
      (for (i (+ k 1) (- n 1))
        (setq xfac (abs (matrix i k)))
        (if (> xfac amax) (setq amax xfac m i))
      )
      ; scambio delle righe
      (if (!= m k) (begin
          (++ rowx)
          (setq temp1 (terms k))
          (setq (terms k) (terms m))
          (setq (terms m) temp1)
          (for (j k (- n 1))
            (setq temp (matrix k j))
            (setq (matrix k j) (matrix m j))
            (setq (matrix m j) temp)
          ))
      )
      (for (i (+ k 1) (- n 1))
        (setq xfac (div (matrix i k) (matrix k k)))
        (for (j (+ k 1) (- n 1))
          (setq (matrix i j) (sub (matrix i j) (mul xfac (matrix k j))))
        )
        (setq (terms i) (sub (terms i) (mul xfac (terms k))))
      )
    )
    ; sostituzione all'indietro (backward sostitution)
    (for (j 0 (- n 1))
      (setq p (sub n j 1))
      (setq (x p) (terms p))
      (if (<= (+ p 1) (- n 1))
        (for (i (+ p 1) (- n 1))
          (setq (x p) (sub (x p) (mul (matrix p i) (x i))))
        )
      )
      (setq (x p) (div (x p) (matrix p p)))
    )
    (if (or (find true (map inf? x)) (find true (map NaN? x)))
        nil
        x)))

;; @syntax (sislin-c matrix terms)
;; @description Solve a linear system with Cramer's method (determinant)
;; @param <matrix> matrix of the linear system
;; @param <terms> known terms
;; @return list of solutions (sol1 sol2...soln) (float) or nil
;; @example
;; (sislin-c '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5))   ==> (-1 2 1)
;; (sislin-c '((1 2 3) (-3 -2 3) (4 -5 2)) '(1 -1 1))  ==> (0.3620689655172414 0.1379310344827586 0.1206896551724138)
;; (sislin-c '((2 1 1) (4 -1 1) (4 2 2)) '(1 -5 5))    ==> nil
(define (sislin-c matrix terms)
  (local (dim detm det-i sol copia)
    (setq dim (length matrix))
    (setq sol '())
    (setq copia matrix)
    (setq detm (det copia 0.0))
    ; la soluzione è indeterminata se il determinante vale zero.
    (if (= detm 0) (setq sol nil)
    ;(println detm)
      (for (i 0 (- dim 1))
        (for (j 0 (- dim 1))
          (setf (copia j i) (terms j))
        )
        ; 0.0 -> restituisce 0 (invece di nil),
        ; quando la matrix è singolare
        (setq det-i (det copia 0.0))
        (push (div det-i detm) sol -1)
        (setq copia matrix)
      )
    )
    sol))

Funzione per il controllo della soluzione del sistema:

(define (check-sislin matrix terms sol)
  (let (err '())
    (dolist (row matrix)
      (push (sub (terms $idx) (apply add (map mul row sol))) err -1))))

Come funziona? Sostituisce la soluzione alle incognite e calcola il valore di ogni equazione:

(sub (first '(1 -5 5)) (apply add (map mul '(2 1 1) '(-1 2 1))))
;-> 0
(sub (first (rest '(-1 -5 5))) (apply add (map mul '(4 -1 1) '(-1 2 1))))
;-> 0
(sub (last '(-1 -5 5)) (apply add (map mul '(-1 1 2) '(-1 2 1))))
;-> 0

(check-sislin '((2 1 1) (4 -1 1) (-1 1 2)) '(1 -5 5) '(-1 2 1))
;-> (0 0 0)

Funzione che elimina l'output automatico della REPL:

(define (noecho expr) (silent expr) (print "\r\n>"))

Sistema con 51 equazioni:

(setq m '())
(for (i 1 51)
  (push (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 100 150))) m -1))
(length m)
;-> 51
(length (first m))
;-> 51

(setq t (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 100 150))))
(length t)
;-> 51

(det m)
;-> -2.455307809771113e+138

(sislin-c m t)

(sislin-g m t)

Differenza tra le soluzioni:

(map sub (sislin-c m t) (sislin-c m t))
;-> (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)

Sistema con 200 incognite:

(setq m '())
(for (i 1 200)
  (push (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1000 1199))) m -1))
(length m)
;-> 200
(length (first m))
;-> 200

(setq t (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1000 1199))))
(length t)
;-> 200

(sislin-c m t)
;-> (-1.#IND -1.#IND -1.#IND -1.#IND -1.#IND -1.#IND -1.#IND
;->  ...
;->  -1.#IND -1.#IND -1.#IND -1.#IND -1.#IND -1.#IND -1.#IND)

Il metodo di Cramer fallisce perchè non riesce a calcolare il determinante (probabilmente perchè il numero è troppo grande):

(det m)
;-> -1.#INF

(sislin-g m t)
;-> (0.4363372503633707 -2.648733303674789 -3.608251827329319
;->  ...
;->  0.8024036199836556 1.712882404517861 -0.8461290786683825)

(time (sislin-g m t))
;-> 3328.499

Convertiamo la lista m in vettore:

(setq mvec (array 200 200 (flat m)))
(length mvec)
;-> 200
(length (first mvec))
;-> 200

(setq tvec (array 200 t))
(length tvec)
;-> 200

Con i vettori il calcolo è molto più veloce:

(time (sislin-g mvec tvec))
;-> 298.122

Sistema con 500 incognite:

(noecho
(setq m '())
(for (i 1 500)
  (push (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1 500))) m -1))
)
(length m)
;-> 500
(length (first m))
;-> 500

(noecho
(setq t (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1 500))))
(length t))
;-> 500

Convertiamo la lista m in vettore:

(noecho (setq mvec (array 500 500 (flat m))))
(length mvec)
;-> 500
(length (first mvec))
;-> 500

(setq tvec (array 500 t))
(length tvec)
;-> 500

(time (println (sislin-g mvec tvec)))
;-> 4437.562

Sistema con 1000 incognite:

(noecho
(setq m '())
(for (i 1 1000)
  (push (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1 1000))) m -1))
)
(length m)
;-> 1000
(length (first m))
;-> 1000

(setq t (map (fn(x) (if (zero? (rand 2)) (- x) (+ x))) (randomize (sequence 1 1000))))
(length t)
;-> 1000

Convertiamo la lista m in vettore:

(noecho (setq mvec (array 1000 1000 (flat m))))
(length mvec)
;-> 1000
(length (first mvec))
;-> 1000

(setq tvec (array 1000 t))
(length tvec)
;-> 1000

(time (println (sislin-g mvec tvec)))
;-> 35597.271

Occorrono quasi 36 secondi per risolvere un sistema di 1000 equazioni (non male).

Controllo soluzioni:

(silent (setq soluz (sislin-g mvec tvec)))
(setq errors (check-sislin mvec tvec soluz))

Calcolo errore massimo:

(apply max errors)
;-> 6.141362973721698e-009


-----------
Sudoku test
-----------

Vediamo alcuni puzzle sudoku considerati difficili da risolvere, prima però scriviamo la funzione per risolverli.

(define (sudoku board)
  (let (sol nil)
    (if (valid? board) (solveSudoku board)
        (setq sol '(nil)))
    sol))

(define (solveSudoku board)
(catch
  (local (i j row col is-empty solved)
    (setq row -1 col -1)
    (setq is-empty true)
    (setq i 0 j 0)
    (while (and is-empty (< i (length board)))
      (while (and is-empty (< j (length board)))
        (if (= (board i j) 0)
            ; Esistono ancora dei valori nulli nel puzzle
            (setq row i col j is-empty nil)
        )
        (++ j)
      )
      (setq j 0)
      (++ i)
    )
    (if is-empty (begin (setq sol board) (throw true)))
    ;else
    (for (num 1 (length board))
        (cond ((safe? board row col num)
                 (setf (board row col) num)
                 (if (solveSudoku board) (throw true))
                 (setf (board row col) 0)
              )
        )
    )
    nil)))

(define (valid? pos)
  (local (safe blk)
    (setq safe true)
    ; numeri compresi tra 0 (casella vuota) e 9
    (for (r 0 8)
      (for (c 0 8)
        (if (or (< (pos r c) 0) (> (pos r c) 9))
            (setq safe nil))))
    ; numero unico sulla riga (row-clash)
    (if safe (begin
      (for (r 0 8)
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) (pos r)) <)
          (setq safe nil)))))
    ; numero unico sulla colonna (row-clash)
    (if safe (begin
      (for (c 0 8)
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) ((transpose pos) c)) <)
          (setq safe nil)))))
    ; numero unico sui 9 blocchi 3x3 (block-clash)
    (if safe (begin
        (setq blk (list (pos 0 0) (pos 0 1) (pos 0 2) (pos 1 0) (pos 1 1) (pos 1 2) (pos 2 0) (pos 2 1) (pos 2 2)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 0 3) (pos 0 4) (pos 0 5) (pos 1 3) (pos 1 4) (pos 1 5) (pos 2 3) (pos 2 4) (pos 2 5)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 0 6) (pos 0 7) (pos 0 8) (pos 1 6) (pos 1 7) (pos 1 8) (pos 2 6) (pos 2 7) (pos 2 8)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 3 0) (pos 3 1) (pos 3 2) (pos 4 0) (pos 4 1) (pos 4 2) (pos 5 0) (pos 5 1) (pos 5 2)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 3 3) (pos 3 4) (pos 3 5) (pos 4 3) (pos 4 4) (pos 4 5) (pos 5 3) (pos 5 4) (pos 5 5)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 3 6) (pos 3 7) (pos 3 8) (pos 4 6) (pos 4 7) (pos 4 8) (pos 5 6) (pos 5 7) (pos 5 8)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 6 0) (pos 6 1) (pos 6 2) (pos 7 0) (pos 7 1) (pos 7 2) (pos 8 0) (pos 8 1) (pos 8 2)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 6 3) (pos 6 4) (pos 6 5) (pos 7 3) (pos 7 4) (pos 7 5) (pos 8 3) (pos 8 4) (pos 8 5)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    (if safe (begin
        (setq blk (list (pos 6 6) (pos 6 7) (pos 6 8) (pos 7 6) (pos 7 7) (pos 7 8) (pos 8 6) (pos 8 7) (pos 8 8)))
        (if (find 1 (count '(1 2 3 4 5 6 7 8 9) blk) <) (setq safe nil))))
    safe))

(define (safe? board row col num)
  (local (safe blk-row blk-col)
    (setq safe true)
    ; numero unico sulla riga (row-clash)
    (for (c 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella riga
      ; restituire falso (nil)
      (if (= (board row c) num)
          (setq safe nil)
      )
    )
    (if safe (begin
    ; numero unico sulla colonna (column-clash)
    (for (r 0 (- (length board) 1))
      ; Se il numero che stiamo provando
      ; è presente in quella colonna
      ; restituire falso (nil)
      (if (= (board r col) num)
          (setq safe nil)
      )
    )))
    (if safe (begin
    ; numero unico in ogni blocco 3x3 (block-clash)
    (setq blk-row (- row (% row 3)))
    (setq blk-col (- col (% col 3)))
    (for (r blk-row (+ blk-row 2))
      (for (c blk-col (+ blk-col 2))
        (if (= (board r c) num)
            (setq safe nil)
        )
      )
    )))
    ; se non c'è conflitto, allora è sicuro
    safe))

Un sudoku vuoto...

(setq x
'((0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 0 0 0 0)))

(time (println (sudoku x)))
;-> ((1 2 3 4 5 6 7 8 9)
;->  (4 5 6 7 8 9 1 2 3)
;->  (7 8 9 1 2 3 4 5 6)
;->  (2 1 4 3 6 5 8 9 7)
;->  (3 6 5 8 9 7 2 1 4)
;->  (8 9 7 2 1 4 3 6 5)
;->  (5 3 1 6 4 2 9 7 8)
;->  (6 4 2 9 7 8 5 3 1)
;->  (9 7 8 5 3 1 6 4 2))
;-> 13.968

I dieci sudoku più difficili:

(setq escargot
'((1 0 0 0 0 7 0 9 0)
  (0 3 0 0 2 0 0 0 8)
  (0 0 9 6 0 0 5 0 0)
  (0 0 5 3 0 0 9 0 0)
  (0 1 0 0 8 0 0 0 2)
  (6 0 0 0 0 4 0 0 0)
  (3 0 0 0 0 0 0 1 0)
  (0 4 0 0 0 0 0 0 7)
  (0 0 7 0 0 0 3 0 0)))

(time (println (sudoku escargot)))
;-> ((1 6 2 8 5 7 4 9 3)
;->  (5 3 4 1 2 9 6 7 8)
;->  (7 8 9 6 4 3 5 2 1)
;->  (4 7 5 3 1 2 9 8 6)
;->  (9 1 3 5 8 6 7 4 2)
;->  (6 2 8 7 9 4 1 3 5)
;->  (3 5 6 4 7 8 2 1 9)
;->  (2 4 1 9 3 5 8 6 7)
;->  (8 9 7 2 6 1 3 5 4))
;-> 211.984

(setq killer
'((0 0 0 0 0 0 0 7 0)
  (0 6 0 0 1 0 0 0 4)
  (0 0 3 4 0 0 2 0 0)
  (8 0 0 0 0 3 0 5 0)
  (0 0 2 9 0 0 7 0 0)
  (0 4 0 0 8 0 0 0 9)
  (0 2 0 0 6 0 0 0 7)
  (0 0 0 1 0 0 9 0 0)
  (7 0 0 0 0 8 0 6 0)))

(time (println (sudoku killer)))
;-> ((9 5 4 8 2 6 1 7 3)
;->  (2 6 8 3 1 7 5 9 4)
;->  (1 7 3 4 9 5 2 8 6)
;->  (8 1 9 7 4 3 6 5 2)
;->  (6 3 2 9 5 1 7 4 8)
;->  (5 4 7 6 8 2 3 1 9)
;->  (4 2 1 5 6 9 8 3 7)
;->  (3 8 6 1 7 4 9 2 5)
;->  (7 9 5 2 3 8 4 6 1))
;-> 2681.012

(setq diamond
'((1 0 0 5 0 0 4 0 0)
  (0 0 9 0 3 0 0 0 0)
  (0 7 0 0 0 8 0 0 5)
  (0 0 1 0 0 0 0 3 0)
  (8 0 0 6 0 0 5 0 0)
  (0 9 0 0 0 7 0 0 8)
  (0 0 4 0 2 0 0 1 0)
  (2 0 0 8 0 0 6 0 0)
  (0 0 0 0 0 1 0 0 2)))

(time (println (sudoku diamond)))
;-> ((1 2 8 5 7 6 4 9 3)
;->  (5 4 9 1 3 2 7 8 6)
;->  (3 7 6 9 4 8 1 2 5)
;->  (7 6 1 2 8 5 9 3 4)
;->  (8 3 2 6 9 4 5 7 1)
;->  (4 9 5 3 1 7 2 6 8)
;->  (6 5 4 7 2 3 8 1 9)
;->  (2 1 3 8 5 9 6 4 7)
;->  (9 8 7 4 6 1 3 5 2))
;-> 294.358

(setq wormhole
'((0 8 0 0 0 0 0 0 1)
  (0 0 7 0 0 4 0 2 0)
  (6 0 0 3 0 0 7 0 0)
  (0 0 2 0 0 9 0 0 0)
  (1 0 0 0 6 0 0 0 8)
  (0 3 0 4 0 0 0 0 0)
  (0 0 1 7 0 0 6 0 0)
  (0 9 0 0 0 8 0 0 5)
  (0 0 0 0 0 0 0 4 0)))

(time (println (sudoku wormhole)))
;-> ((9 8 4 2 7 6 3 5 1)
;->  (3 1 7 9 5 4 8 2 6)
;->  (6 2 5 3 8 1 7 9 4)
;->  (5 6 2 8 3 9 4 1 7)
;->  (1 4 9 5 6 7 2 3 8)
;->  (7 3 8 4 1 2 5 6 9)
;->  (4 5 1 7 9 3 6 8 2)
;->  (2 9 3 6 4 8 1 7 5)
;->  (8 7 6 1 2 5 9 4 3))
;-> 3833.182

(setq labyrinth
'((1 0 0 4 0 0 8 0 0)
  (0 4 0 0 3 0 0 0 9)
  (0 0 9 0 0 6 0 5 0)
  (0 5 0 3 0 0 0 0 0)
  (0 0 0 0 0 1 6 0 0)
  (0 0 0 0 7 0 0 0 2)
  (0 0 4 0 1 0 9 0 0)
  (7 0 0 8 0 0 0 0 4)
  (0 2 0 0 0 4 0 8 0)))

(time (println (sudoku labyrinth)))
;-> ((1 6 5 4 9 7 8 2 3)
;->  (2 4 7 5 3 8 1 6 9)
;->  (8 3 9 1 2 6 4 5 7)
;->  (6 5 1 3 4 2 7 9 8)
;->  (3 7 2 9 8 1 6 4 5)
;->  (4 9 8 6 7 5 3 1 2)
;->  (5 8 4 2 1 3 9 7 6)
;->  (7 1 6 8 5 9 2 3 4)
;->  (9 2 3 7 6 4 5 8 1))
;-> 1983.587

(setq circles
'((0 0 5 0 0 9 7 0 0)
  (0 6 0 0 0 0 0 2 0)
  (1 0 0 8 0 0 0 0 6)
  (0 1 0 7 0 0 0 0 4)
  (0 0 7 0 6 0 0 3 0)
  (6 0 0 0 0 3 2 0 0)
  (0 0 0 0 0 6 0 4 0)
  (0 9 0 0 5 0 1 0 0)
  (8 0 0 1 0 0 0 0 2)))

(time (println (sudoku circles)))
;-> ((4 8 5 6 2 9 7 1 3)
;->  (7 6 9 3 4 1 8 2 5)
;->  (1 3 2 8 7 5 4 9 6)
;->  (5 1 3 7 9 2 6 8 4)
;->  (9 2 7 4 6 8 5 3 1)
;->  (6 4 8 5 1 3 2 7 9)
;->  (2 5 1 9 8 6 3 4 7)
;->  (3 9 4 2 5 7 1 6 8)
;->  (8 7 6 1 3 4 9 5 2))
;-> 2424.274

(setq squadron
'((6 0 0 0 0 0 2 0 0)
  (0 9 0 0 0 1 0 0 5)
  (0 0 8 0 3 0 0 4 0)
  (0 0 0 0 0 2 0 0 1)
  (5 0 0 6 0 0 9 0 0)
  (0 0 7 0 9 0 0 0 0)
  (0 7 0 0 0 3 0 0 2)
  (0 0 0 4 0 0 5 0 0)
  (0 0 6 0 7 0 0 8 0)))

(time (println (sudoku squadron)))
;-> ((6 5 3 7 4 9 2 1 8)
;->  (7 9 4 8 2 1 6 3 5)
;->  (1 2 8 5 3 6 7 4 9)
;->  (4 6 9 3 5 2 8 7 1)
;->  (5 3 1 6 8 7 9 2 4)
;->  (2 8 7 1 9 4 3 5 6)
;->  (8 7 5 9 1 3 4 6 2)
;->  (3 1 2 4 6 8 5 9 7)
;->  (9 4 6 2 7 5 1 8 3))
;-> 2702.114

(setq honeypot
'((1 0 0 0 0 0 0 6 0)
  (0 0 0 1 0 0 0 0 3)
  (0 0 5 0 0 2 9 0 0)
  (0 0 9 0 0 1 0 0 0)
  (7 0 0 0 4 0 0 8 0)
  (0 3 0 5 0 0 0 0 2)
  (5 0 0 4 0 0 0 0 6)
  (0 0 8 0 6 0 0 7 0)
  (0 7 0 0 0 5 0 0 0)))

(time (println (sudoku honeypot)))
;-> ((1 8 2 3 9 4 5 6 7)
;->  (9 6 7 1 5 8 2 4 3)
;->  (3 4 5 6 7 2 9 1 8)
;->  (8 2 9 7 3 1 6 5 4)
;->  (7 5 6 2 4 9 3 8 1)
;->  (4 3 1 5 8 6 7 9 2)
;->  (5 9 3 4 1 7 8 2 6)
;->  (2 1 8 9 6 3 4 7 5)
;->  (6 7 4 8 2 5 1 3 9))
;-> 5773.664

(setq tweezers
'((1 0 0 0 0 0 0 6 0)
  (0 0 0 1 0 0 0 0 3)
  (0 0 5 0 0 2 9 0 0)
  (0 0 9 0 0 1 0 0 0)
  (7 0 0 0 4 0 0 8 0)
  (0 3 0 5 0 0 0 0 2)
  (5 0 0 4 0 0 0 0 6)
  (0 0 8 0 6 0 0 7 0)
  (0 7 0 0 0 5 0 0 0)))

(time (println (sudoku tweezers)))
;-> ((1 8 2 3 9 4 5 6 7)
;->  (9 6 7 1 5 8 2 4 3)
;->  (3 4 5 6 7 2 9 1 8)
;->  (8 2 9 7 3 1 6 5 4)
;->  (7 5 6 2 4 9 3 8 1)
;->  (4 3 1 5 8 6 7 9 2)
;->  (5 9 3 4 1 7 8 2 6)
;->  (2 1 8 9 6 3 4 7 5)
;->  (6 7 4 8 2 5 1 3 9))
;-> 5714.483

(setq brokenbrick
'((4 0 0 0 6 0 0 7 0)
  (0 0 0 0 0 0 6 0 0)
  (0 3 0 0 0 2 0 0 1)
  (7 0 0 0 0 8 5 0 0)
  (0 1 0 4 0 0 0 0 0)
  (0 2 0 9 5 0 0 0 0)
  (0 0 0 0 0 0 7 0 5)
  (0 0 9 1 0 0 0 3 0)
  (0 0 3 0 4 0 0 8 0)))

(time (println (sudoku brokenbrick)))
;-> 137.515

The World's Hardest Sudoku:

(setq world
'((8 0 0 0 0 0 0 0 0)
  (0 0 3 6 0 0 0 0 0)
  (0 7 0 0 9 0 2 0 0)
  (0 5 0 0 0 7 0 0 0)
  (0 0 0 0 4 5 7 0 0)
  (0 0 0 1 0 0 0 3 0)
  (0 0 1 0 0 0 0 6 8)
  (0 0 8 5 0 0 0 1 0)
  (0 9 0 0 0 0 4 0 0)))

(time (println (sudoku world)))
;-> ((8 1 2 7 5 3 6 4 9)
;->  (9 4 3 6 8 2 1 7 5)
;->  (6 7 5 4 9 1 2 8 3)
;->  (1 5 4 2 3 7 8 9 6)
;->  (3 6 9 8 4 5 7 2 1)
;->  (2 8 7 1 6 9 5 3 4)
;->  (5 2 1 9 7 4 3 6 8)
;->  (4 3 8 5 2 6 9 1 7)
;->  (7 9 6 3 1 8 4 5 2))
;-> 1122.131

In genere i puzzle più difficili per gli umani vengono risolti in breve tempo (pochi secondi) con la nostra funzione brute-force. Adesso vediamo un puzzle considerato difficile per il metodo brute-force:

(setq beast
'((0 0 0 0 0 0 0 0 0)
  (0 0 0 0 0 3 0 8 5)
  (0 0 1 0 2 0 0 0 0)
  (0 0 0 5 0 7 0 0 0)
  (0 0 4 0 0 0 1 0 0)
  (0 9 0 0 0 0 0 0 0)
  (5 0 0 0 0 0 0 7 3)
  (0 0 2 0 1 0 0 0 0)
  (0 0 0 0 4 0 0 0 9)))

(time (print (sudoku beast)))
;-> ((9 8 7 6 5 4 3 2 1)
;->  (2 4 6 1 7 3 9 8 5)
;->  (3 5 1 9 2 8 7 4 6)
;->  (1 2 8 5 3 7 6 9 4)
;->  (6 3 4 8 9 2 1 5 7)
;->  (7 9 5 4 6 1 8 3 2)
;->  (5 1 9 2 8 6 4 7 3)
;->  (4 7 2 3 1 9 5 6 8)
;->  (8 6 3 7 4 5 2 1 9))
;-> 1619210.766 ; 27 minuti
(div (div 1619210.766 1000) 60)
;-> 26.9868461

In effetti, ci sono voluti 27 minuti per risolverlo.

Un altro sudoku difficile con la tecnica brute-force:

(setq hell
'((9 0 0 8 0 0 0 0 0)
  (0 0 0 0 0 0 5 0 0)
  (0 0 0 0 0 0 0 0 0)
  (0 2 0 0 1 0 0 0 3)
  (0 1 0 0 0 0 0 6 0)
  (0 0 0 4 0 0 0 7 0)
  (7 0 8 6 0 0 0 0 0)
  (0 0 0 0 3 0 1 0 0)
  (4 0 0 0 0 0 2 0 0)))

(time (print (sudoku hell)))
((9 7 2 8 5 3 6 1 4)
 (1 4 6 2 7 9 5 3 8)
 (5 8 3 1 4 6 7 2 9)
 (6 2 4 7 1 8 9 5 3)
 (8 1 7 3 9 5 4 6 2)
 (3 5 9 4 6 2 8 7 1)
 (7 9 8 6 2 1 3 4 5)
 (2 6 5 9 3 4 1 8 7)
 (4 3 1 5 8 7 2 9 6))
;-> 54630842.335 ; 910 minuti (tutta la notte)
(div (div 54630842.335 1000) 60)
;-> 910.5140389166667


------------------
Integrali definiti
------------------

Gli integrali... proprio quelli delle superiori e (per qualcuno) dell'università. Vediamo alcuni metodi per calcolare l'integrale definito di una funzione nell'intervallo [a,b]. Ricordiamo che per calcolare l'integrale definito la funzione deve essere continua in tutto l'intervallo [a,b].

Metodo del trapezio
-------------------
La regola del trapezio approssima l'integrale, cioè l'area della regione piana compresa fra il grafico della funzione f(x) e l'asse delle ascisse, con l'area del trapezio di vertici (a,f(a)),(b,f(b)),(b,0),(a,0). Quindi si ottiene:

 b                   f(a) + f(b)
∫ f(x)dx ≈ (b - a)*---------------
a                         2

Questa approssimazione è accettabile se nell'intervallo di integrazione la funzione ha un andamento quasi sempre lineare. Se questo non accade si può suddividere l'intervallo complessivo [a,b] in un numero n di sottointervalli: in questo modo in ciascun sottointervallo accade (in genere) che la funzione ha un andamento quasi lineare. Quindi la regola del trapezio applicata a tutti i sottointervalli genera la seguente formula:


 b                      f(a) + f(b)                          (b - a)
∫ f(x)dx ≈ (b - a) * (--------------- + Sum[1..n-1] f(a + k*---------))
a                            2                                  n

Questo metodo è generalmente efficace, ma non approssima molto bene le funzioni che variano velocemente (es. e^x).
Maggiore è la pendenza della funzione, maggiore è l'errore che dobbiamo aspettarci dall'utilizzo del metodo trapezioale. Comunque possiamo sempre aumentare il numero di iterazioni per migliorare il risultato.

(define (trapezio func a b iter)
  (local (h s x)
    (setq h (div (sub b a) iter))
    (setq s (mul 0.5 (func a) (func b)))
    (for (i 1 (- iter 1))
      (setq x (add a (mul i h)))
      (setq s (add s (func x)))
    )
    (mul s h)))

Metodo di Romberg
-----------------
L'algoritmo di romberg è l'applicazione dell'interpolazione di Richardson a ciascuna iterazione delle approssimazioni trapezioali. Questo permette di ottenere un'interpolazione di ordine superiore e quindi un risultato più preciso.

(define (romberg func a b iter)
  (local (r h sum)
    (setq r (array (+ iter 1) (+ iter 1) '(0)))
    (setq h (sub b a))
    (setq (r 1 1) (mul (mul h 0.5) (add (func a) (func b))))
    (for (i 2 iter)
      (setq h (mul h 0.5))
      (setq sum 0)
      (for (k 1 (- (pow 2 (- i 1)) 1) 2)
        (setq sum (add sum (func (add a (mul k h)))))
      )
      (setq (r i 1) (add (mul 0.5 (r (- i 1) 1)) (mul sum h)))
      (for (j 2 i)
        (setq (r i j) (add (r i (- j 1))
                          (div (sub (r i (- j 1)) (r (- i 1) (- j 1)))
                                (sub (pow 4 (- j 1)) 1))))
      )
    )
    (r iter iter)))

Quadratura gaussiana
--------------------
Le formule gaussiane di quadratura a n punti sono formule di quadratura numerica con alto grado di precisione, utilizzate per l'approssimazione di un integrale definito della funzione f(x) conoscendo n+1 valori della funzione f nell'intervallo [a,b].

Quadratura gaussiana a 2 punti:

(define (gauss-quad2p func a b iter)
  (local (h x0 x1 x2 x3 sum)
    (setq h (div (sub b a) iter))
    (setq sum 0)
    (for (i 1 (- iter 1))
      (setq x0 (add a (mul i h)))
      (setq x1 (add x0 (mul 0.5 h (sub 1 (sqrt (div 3))))))
      (setq x2 (add x0 (mul 0.5 h (add 1 (sqrt (div 3))))))
      (setq sum (add sum (func x1) (func x2)))
    )
    (setq sum (mul sum 0.5 h))))

Quadratura gaussiana a 3 punti:

(define (gauss-quad3p func a b iter)
  (local (h x0 x1 x2 x3 sum)
    (setq h (div (sub b a) iter))
    (setq sum 0)
    (for (i 1 (- iter 1))
      (setq x0 (add a (mul i h)))
      (setq x1 (add x0 (mul 0.5 h (sub 1 (sqrt (div 3 5))))))
      (setq x2 (add x0 (mul 0.5 h)))
      (setq x3 (add x0 (mul 0.5 h (add 1 (sqrt (div 3 5))))))
      (setq sum (add sum
                     (mul (div 5 9) (func x1))
                     (mul (div 8 9) (func x2))
                     (mul (div 5 9) (func x3))))
    )
    (setq sum (mul sum 0.5 h))))

Proviamo a calcolare alcuni integrali:

(setq PI 3.1415926535897931)

(define (f x) (sin x))
(trapezio f 0 PI 10000)
;-> 1.999999983550661
(romberg f 0 PI 10)
;-> 2
(gauss-quad2p f 0 PI 100)
;-> 1.99950655991486
(gauss-quad3p f 0 PI 100)
;-> 1.999506560365733
Valore reale: 2

(define (f1 x) (div 4 (add 1 (mul x x))))
(trapezio f1 0 1 10000)
;-> 3.14169265192314
(romberg f1 0 1 10)
;-> 3.141592653589793
(gauss-quad2p f1 0 1 100000)
;-> 3.141552653589758
(gauss-quad3p f1 0 1 100000)
;-> 3.141552653589891
Valore reale: 3.1415926535897931 (pi greco)

(define (g x) (pow x 5))
(trapezio g 0 1 10000)
;-> 0.1666166708333333
(romberg g 0 1 10)
;-> 0.1666666666666667
(gauss-quad2p g 0 1 100)
;-> 0.166666666527625
(gauss-quad3p g 0 1 100)
;-> 0.1666666666665
Valore vero: 1.(6) (1.6666666...)

(define (g1 x) (pow x 2))
(trapezio g1 1 2 10000)
;-> 2.333283334999989
(romberg g1 1 2 10)
;-> 2.333333333333334
(gauss-quad2p g1 1 2 10000)
;-> 2.333233323333007
(gauss-quad3p g1 1 2 10000)
;-> 2.333233323333004
Valore vero: 2.(3)

(define (g2 x) (mul (cos x) (cos x)))
(trapezio g2 0 (mul 2 PI) 100000)
;-> 3.141561237663232
(romberg g2 0 (mul 2 PI) 10)
;-> 3.141592653589793
(gauss-quad2p g2 0 (mul 2 PI) 100000)
;-> 3.141529821736828
(gauss-quad3p g2 0 (mul 2 PI) 100000)
;-> 3.141529821736874
Valore vero: 3.1415926535897931 (pi greco)

(define (g3 x) (div (mul 4 x) (sub 2 (mul 8 (pow x 2)))))
(trapezio g3 3 5 100000)
;-> -0.259940049615719
(romberg g3 3 5 10)
;-> -0.259942947161294
(gauss-quad2p g3 3 5 100000)
;-> -0.2599395186019513
(gauss-quad3p g3 3 5 100000)
;-> -0.2599395186019479
Valore vero: -0.259942947161294
(div (sub (log 70) (log 198)) 4)
;-> -0.259942947161294

(define (g3 x) (div (mul 4 x) (sub 2 (mul 8 (pow x 2)))))
(trapezio g3 -1 1 100000)
;-> -1.#INF
(romberg g3 -1 1 10)
;-> -1.#IND
(gauss-quad2p g3 -1 1 100000)
;-> -1.333349378033419e-005
(gauss-quad3p g3 -1 1 100000)
;-> -1.333343700649166e-005
Valore vero: divergente per x = 1/2 e x = -1/2

(define (g4 x) (sin x))
(trapezio g4 0 PI 10000)
;-> 1.999999983550661
(romberg g4 0 PI 10)
;-> 2
(gauss-quad2p g4 0 PI 10000)
;-> 1.999999950651962
(gauss-quad3p g4 0 PI 10000)
;-> 1.999999950651979
Valore vero: 2

(define (g5 x) (div 4 (add 1 (mul x x))))
(trapezio g5 0 1 100000)
;-> 3.141602653573153
(romberg g5 0 1 10)
;-> 3.141592653589793
(gauss-quad2p g5 0 1 100000)
;-> 3.141552653589758
(gauss-quad3p g5 0 1 100000)
;-> 3.141552653589891
Valore vero: 3.1415926535897931 (pi greco)


---------------
Fattorizzazione
---------------

Per fattorizzare un numero intero abbiamo la funzione integrata "factor":

(factor 1372000)
;-> (2 2 2 2 2 5 5 5 7 7 7)

In cui compaiono tutti i fattori del numero. Se volessimo raggruppare i fattori in comune dobbiamo scrivere una funzione. Vediamo diversi metodi per trovare quello più veloce.

Funzione 1:

(define (factor-g1 num)
  (if (< num 2) nil
      (letn (fattori (factor num)
            unici (unique fattori))
            (transpose (list unici (count unici fattori))))))

(factor-g1 1372000)
;-> ((2 5) (5 3) (7 3))

Funzione 2:

(define (factor-g2 x)
  (letn (fattori (factor x)
         unici (unique fattori))
        (map list unici (count unici fattori))))

(factor-g2 1372000)
;-> ((2 5) (5 3) (7 3))

Funzione 3:

(define (factor-g3 num)
  (if (< num 2) nil
      (let (factorlist (factor num) factorlist-grouped '())
        (dolist (y (unique factorlist))
           (push (append (list y) (count (list y) factorlist)) factorlist-grouped -1))
        factorlist-grouped)))

(factor-g3 1372000)
;-> ((2 5) (5 3) (7 3))

Funzione 4:
il quarto metodo usa la tecnica Run Lenght Encode (infatti applicando l'algoritmo RLE al risultato della funzione "factor" si ottiene il risultato):

(define (factor-g4 num)
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(factor-g4 1372000)
;-> ((2 5) (5 3) (7 3))

Vediamo se le quattro funzioni producono gli stessi risultati:

(= (map factor-g1 (sequence 2 10000))
   (map factor-g2 (sequence 2 10000))
   (map factor-g3 (sequence 2 10000))
   (map factor-g4 (sequence 2 10000)))
;-> true

Vediamo i tempi di esecuzione:

(silent (setq seq (sequence 1e6 1e7)))
(time (map factor-g1 seq))
;-> 28214.053
(time (map factor-g2 seq))
;-> 28532.154
(time (map factor-g3 seq))
;-> 40389.041
(time (map factor-g4 seq))
;-> 23980.14

L'ultima funzione è quella più veloce.


--------------
"setq" o "set"
--------------

Notiamo che "setq" è più veloce di "set":

(time (setq a 10 b 20 c 30) 10000000)
;-> 382.001
(time (set 'a 10 'b 20 'c 30) 10000000)
;-> 479.744

(time (for (i 1 10000) (setq a 10)) 10000)
;-> 2287.881
(time (for (i 1 10000) (set 'd 10)) 10000)
;-> 2638.974

E possiamo sempre divertirci scrivendo:

(setq --> setq)
(--> a 3)
a
;-> 3


-------
Memfrob
-------

Memfrob è un algoritmo di crittografia leggero che funziona facendo lo xor tra il numero 42(10) = 00101010(2) con ogni (carattere (byte) di input per creare un output crittografato. La decrittazione è simmetrica alla crittografia. Memfrob è più o meno equivalente a ROT13 nella sicurezza crittografica.

Codifica di un carattere:
(char (^ (char "a") 42))
;-> "K"

Decodifica del carattere:
(char (^ (char "K") 42))
;-> "a"

Le funzioni di codifica e decodifica di un carattere sono uguali:

(define (frob c) (char (^ (char c) 42)))

Scriviamo la funzione per criptare/decriptare una stringa:

(define (memfrob str) (join (map frob (explode str))))

(memfrob "pippo")
;-> "ZCZZE"

(memfrob "ZCZZE")
;-> "pippo"

(memfrob (memfrob "newLISP is fun"))
;-> "newLISP is fun"

Nota: il numero 42 ricorda il libro "Guida Galattica per Autostoppisti" di Douglas Adams.


----------------------
Generatore di sequenze
----------------------

Scriviamo un programma che genera la seguente sequenza:

1, 5, 10, 50, 100, 500, 1000, 5000, 10000

La sequenza si ottiene partendo da 1 e moltiplicando il numero alternativamente per 5 e per 2:

1
1*5    -> 5
5*2    -> 10
10*5   -> 50
50*2   -> 100
100*5  -> 500
500*2  -> 1000
...

Una possibile soluzione è la seguente:

(define (seq1 n)
  (local (out m1 m2 val flip)
    (setq out '(1))
    (setq val 1)
    (setq m1 5 m2 2)
    (setq flip nil)
    (while (<= (* val m2) n)
      (if flip
          (setq val (* val m2) flip nil)
          (setq val (* val m1) flip true)
      )
      (push val out -1)
    )
    out))

(seq1 50001)
;-> (1 5 10 50 100 500 1000 5000 10000 50000)

Possiamo scrivere una funzione più generale per generare questo tipo di sequenze utilizzando una lista circolare e parametrizzando l'operatore aritmetico. La lista circolare contiene i valori dei moltiplicatori e l'operatore aritmetico "+" oppure "*" viene passato come parametro alla funzione.

Funzioni per la gestione di una lista circolare:

; creiamo un contesto per la struttura
(context 'circ-list)
; inizializzazione della lista circolare
(define (circ-list:init lst)
  (let (n (length lst))
    (setq
          circ-list:items (array n lst)
          circ-list:i 0
          circ-list:end n)))
; valore elemento corrente della lista circolare (con avanzamento)
(define (circ-list:next)
  (cond ((= circ-list:i circ-list:end)
          (setq circ-list:i 0)
          (++ circ-list:i)
          (circ-list:items (- circ-list:i 1)))
        (true
          (++ circ-list:i)
          (circ-list:items (- circ-list:i 1)))))
; valore elemento corrente della lista circolare (senza avanzamento)
(define (circ-list:cur) (circ-list:items (- circ-list:i 1)))
; indice del prossimo elemento della lista circolare
(define (circ-list:index) circ-list:i)
; lunghezza della lista circolare
(define (circ-list:len) circ-list:end)
;valore della lista circolare
(define (circ-list:values) circ-list:items)
; ritorniamo al contesto principale
(context MAIN)

Adesso definiamo la nostra funzione per generare sequenze:

(define (sequenza start n val-lst op)
  (local (out val)
    ; inizializziamo la lista circolare
    (circ-list:init val-lst)
    (setq out (list start))
    (setq val start)
    (while (<= val n) ; calcola qualche elemento di troppo...
      (setq val ((eval op) val (circ-list:next)))
      (push val out -1)
    )
    ; ...elimina gli elementi di troppo.
    (filter (fn(x) (<= x n)) out)))

Verifichiamo la funzione con la sequenza iniziale:

(sequenza 1 100001 '(5 2) '*)
;-> (1 5 10 50 100 500 1000 5000 10000 50000 100000)

Adeesso possiamo generare altre sequenze:

(sequenza 1 10 '(2 1) '+)
;-> (1 3 4 6 7 9 10)
(sequenza 10 200 '(2 1) '*)
;-> (10 20 20 40 40 80 80 160 160)

Non possiamo utilizzare gli operatori aritmetici "-" e "/" perchè non permettono di definire un limite per n. Però possiamo definire un'altra funzione che genera una sequenza di n numeri (invece che fino al numero n).

(define (sequenza-n start num val-lst op)
  (local (out val)
    ; inizializziamo la lista circolare
    (circ-list:init val-lst)
    (setq out (list start))
    (setq val start)
    (for (i 2 num)
      (setq val ((eval op) val (circ-list:next)))
      (push val out -1)
    )
    out))

(sequenza-n 1 7 '(2 1) '+)
;-> (1 3 4 6 7 9 10)

(sequenza-n 10 9 '(2 1) '*)
;-> (10 20 20 40 40 80 80 160 160)

(sequenza-n 10 9 '(2 1) '-)
;-> (10 8 7 5 4 2 1 -1 -2)

(sequenza-n 1000 9 '(4 3) '/)
;-> (1000 250 83 20 6 1 0 0 0)

(sequenza-n 0 10 '(1 2 3) '+)
;-> (0 1 3 6 7 9 12 13 15 18)


-----------
Massimo gap
-----------

Data una lista non ordinata di interi positivi, trovare la differenza massima tra gli elementi successivi nella sua forma ordinata e gli indici dei relativi valori. Restituire la differenza massima, gli indici dei relativi valori e la lista ordinata.

Funzione che applica un operatore matematico ad ogni coppia di elementi di una lista:

(define (do-pair lst func rev)
  (if rev
      (map func (chop lst) (rest lst))
      (map func (rest lst) (chop lst))))

(do-pair '(1 4 5 10 12) -)
;-> (3 1 5 2)

Funzione che restituisce il valore massimo di una lista e il relativo indice:

(define (max-with-idx lst)
  (let ((m -1) (i nil))
    (dolist (el lst)
      (if (> el m) (setq m el i $idx))
    )
    (list m i)))

(max-with-idx '(3 1 5 2))
;-> (5 2)

Funzione che trova la soluzione finale:

(define (max-gap lst)
  (let (out (max-with-idx (do-pair (sort lst) -)))
    (list (push (+ (last out) 1) out -1) lst)))

(max-gap '(1 5 12 10 4))
;-> ((5 2 3) (1 4 5 10 12))


