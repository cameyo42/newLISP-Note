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
      ;(println (string el))
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

