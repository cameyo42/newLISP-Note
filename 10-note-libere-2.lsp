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


