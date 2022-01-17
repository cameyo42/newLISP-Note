===============

 NOTE LIBERE 7

===============

------------------------------
Hash-Map Quick Reference Guide
------------------------------

Creazione di una hash-map:

(new Tree 'myhash)
;-> myhash

(for (i 16 256) (println (char i)))

Funzione per creare una hash-map:

(define (new-hash str) (new Tree (sym str)))

(new-hash "pippo")
(pippo "1" "a")
;-> "a"
(pippo)
;-> (("1" "a"))

Altra funzione per creare un contesto/hash-map (Lutz):

(define (create-context-from-name str)
   (sym str (sym str MAIN))
)

Eliminazione di una hash-map:

(delete 'myhash)
;-> true

Funzione per eliminare una hash-map:

(define (del-hash str) (delete (sym str)))
(del-hash "pippo")
;-> true
(pippo)
;-> ERR: invalid function : (pippo)

(del-hash "boh")
;-> true

Inserimento di una coppia (chiave-valore) nella hash-map:

(new Tree 'myhash)
(myhash "1" "a")
;-> "a"
(myhash "2" "b")
;-> "b"

Aggiornamento di un valore di una chiave utilizzando il valore attuale:

(myhash "2" (string "a" (myhash "2")))
;-> "ab"

Elenco delle coppie in una hash-map:

(myhash)
;-> (("1" "a") ("2" "ab"))

Aggiornamento di un valore di una chiave:

(myhash "2" "b")
;-> "b"

Eliminazione di una coppia (chiave-valore) nella hash-map:

(myhash "1" nil)
;-> nil
(myhash)
;-> (("2" "b"))

(myhash "1" "a")
;-> "a"

Lunghezza di una hash-map:

(length (myhash))
;-> 2

Funzione che elenca le coppie chiave-valore di una hash-map:

(define (list-hash str)
  (eval-string (append "(" (string str) ")")))

(list-hash myhash)
;-> (("1" "a") ("2" "b"))

Creazione di hash-map da una variabile:

(setq a "demo")
(new Tree (sym (eval a)))
(demo)
;-> ()

(setq a "prova")
(new-hash a)
(prova)
;-> ()

Ricerca di una chiave sulla hash-map:

(myhash "1")
;-> "a"
(myhash 1)
;-> "a"
(myhash "a")
;-> nil
(myhash "4")
;-> nil
(true? (myhash "1"))
;-> true

Una hash-map non è una lista, ma possiamo usare lo stesso dolist per elencare tutte le coppie chiave-valore:

(list? myhash)
;-> nil
(dolist (cp (myhash)) (println (list (cp 0) (cp 1))))
;-> ("1" "a")
;-> ("2" "b")

Per creare una lista di associazione da una hash-map basta assegnare la valutazione della hash-map ad una variabile:

(setq alst (myHash))
;-> (("#1234" "hello world") ("1" "uno") ("_y" (1 2))
;->  ("il numero" 123) ("var" (a b c d)) ("x" "stringa"))

(list? alst)
;-> true

Per popolare una hash-map possiamo anche usare una lista associativa (chiave valore):

(myhash '((3 4) (5 6)))
;-> myhash

(myhash)
;-> (("1" "a") ("2" "b") ("3" 4) ("5" 6))

Nota: le chiavi del dizionario sono ordinate in maniera lessicografica.

Cosa accade alle liste che hanno valori della chiave ripetuti?

Nella lista seguente le chiavi "1" e "3" sono ripetute:

(setq lst '(("4" 4) ("1" 0) ("2" 2) ("3" 0) ("1" 1) ("3" 3) ("5" 5)))

Quando assegniamo la lista ad una hash-map i valori con chiave multipla vengono memorizzati soltanto una volta...ma quali elementi sceglie e quali elimina newLISP?
Facciamo una prova:

(new Tree 'hash)
(hash lst)
;-> hash
(hash)
;-> (("1" 1) ("2" 2) ("3" 3) ("4" 4) ("5" 5))

Gli elementi ("1" 0) e ("3" 0) sono stati eliminati... cioè quelli che si trovavano prima.
In newLISP la hash-map inserisce gli elementi partendo dal fondo della lista (poi nella hash-map gli elementi sono ordinati in base alla chiave). Quindi quando incontra elementi multipli prende l'ultimo che compare nella lista (cioè il primo partendo dal fondo della lista).

Lista di tutti i simboli di una hash-map (contesto):

(symbols myhash)
;-> (myhash:_1 myhash:_2 myhash:_3 myhash:_5 myhash:myhash)

Nota: Le chiavi (simboli) vengono memorizzate precedute dal contesto e dal carattere underscore "_".

le espressioni hash restituiscono un riferimento al loro contenuto che può essere modificato direttamente:

(pop (myHash "var"))
;-> a

(myHash "var")
;-> (b c d)

(push 'z (myHash "var"))
;-> (z b c d)

(myHash "var")
;-> (z b c d)

Quando si impostano i valori hash, la variabile anaforica di sistema "$it" può essere utilizzata per riferirsi al vecchio valore quando si imposta il nuovo:

(myhash "bar" "hello world")
;-> "hello world"

(myhash "bar" (upper-case $it))
;-> "HELLO WORLD"

(myhash "bar")
;-> "HELLO WORLD"

Le hash-map possono essere salvate in un file e ricaricate in un secondo momento:

; save dictionary
(save "myhash.lsp" 'myhash)
;-> true

Caricamento di una hash-map dal file "myhash.lsp":

(load "myhash.lsp")
;-> MAIN
(myhash)
(("1" "a") ("2" "b") ("3" 4) ("5" 6) ("bar" "HELLO WORLD"))

Per ulteriori informazioni, vedere "Hash-map e contesti" nel file "13-note-libere-5.lsp".


-------------------------------------
Hash-Map General management functions
-------------------------------------

Alcune funzioni generali per la gestione delle hash-map:

HASH-CREATE: Creazione di una hash-map
HASH-SET: Inserimento di una coppia (chiave-valore)
HASH-GET-VAL: Lettura di un valore tramite chiave
HASH-GET-KEY: Lettura di una chiave tramite valore
HASH-KEYS: Lista di tutte le chiavi
HASH-VALUES: Lista di tutti i valori
HASH-ITEMS: Lista associativa di tutti gli elementi (coppie chiave-valore)
HASH-DEL: Eliminazione di un valore tramite chiave
HASH-SIZE: Numero di elementi (coppie chiave-valore)
HASH-KEY?: Chiave esistente?
HASH-VALUE?: Valore esistente?
HASH-EMPTY?: Hash-Map vuota?
HASH-CLEAR: Eliminazione di tutti gli elementi (coppie chiave-valore)
HASH-DESTROY: Eliminazione di una hash-map
HASH-SET-LIST: Inserimento degli elementi (coppie chiave-valore) di una lista associativa
HASH?: Hash-map esistente?
HASH-MAP-LAMBDA: Applica una funzione (kv-fn) agli elementi (coppie chiave-valore)

--------------------------------------
HASH-CREATE: Creazione di una hash-map
--------------------------------------
(define (hash-create x)
  (new Tree x))

Esempi:
(hash-create 'hh)
;-> hh

---------------------------------------------------
HASH-SET: Inserimento di una coppia (chiave-valore)
---------------------------------------------------
(define (hash-set hash key value)
  (hash key value))

Esempi:
(hash-set hh 1 "a")
;-> "a"
(hash-set hh 2 "b")
;-> "b"
(hash-set hh 3 "c")
;-> "c"
(hash-set hh 4 "d")
;-> "d"

-------------------------------------------------
HASH-GET-VAL: Lettura di un valore tramite chiave
-------------------------------------------------
(define (hash-get-val hash key)
  (hash key))

Esempi:
(hash-get-val hh "1")
;-> "a"
(hash-get-val hh 1)
;-> "a"
(hash-get-val hh 5)
;-> nil

--------------------------------------------------
HASH-GET-KEY: Lettura di una chiave tramite valore
--------------------------------------------------
(define (hash-get-key hash value)
  (local (key break)
    (dolist (item (hash) break)
      (if (= (last item) value)
          (set 'key (first item) 'break true)
      )
    )
    key))

Esempi:
(hash-get-key hh "c")
;-> "3"
(hash-get-key hh "z")
;-> nil

Versione alternativa (più lenta):

(define (hash-get-key2 hash value)
    (if (ref value (hash))
        ((hash) (first (ref value (hash))) 0)
        nil))

Nota: questa funzione è molto lenta, come risulta dal seguente esempio,

Creiamo una nuova hash-map:
(new Tree 'ab)
;-> ab

Creiamo una lista di coppie:
(setq lst (map list (map string (randomize (sequence 1 1000))) (sequence 1 1000)))

Assegniamo i valori (1000 coppie) della lista alla hash-map:
(ab lst)

Vediamo il valore associato alla chiave "300":
(ab "300")
;-> 926

Vediamo la chiave associata al valore 926:
(hash-get-key ab 926)
;-> "300"
(hash-get-key2 ab 926)
;-> "300"

Calcoliamo la velocità delle due funzioni:

(time (hash-get-key ab 926) 10000)
;-> 963.984
(time (hash-get-key2 ab 922) 10000)
;-> 2886.201

La funzione inversa, che trova il valore data una chiave, "hash-get-val" è molto più veloce (quasi immediata):

(hash-get-val ab "300")
;-> 926
(time (hash-get-val ab "300") 10000)
;-> 15.585

-----------------------------------
HASH-KEYS: Lista di tutte le chiavi
-----------------------------------
(define (hash-keys hash)
  (map first (hash)))

Esempi:
(hash-keys hh)
;-> ("1" "2" "3" "4")

------------------------------------
HASH-VALUES: Lista di tutti i valori
------------------------------------
(define (hash-values hash)
  (map last (hash)))

Esempi:
(hash-values hh)
;-> ("a" "b" "c" "d")

--------------------------------------------------------------------------
HASH-ITEMS: Lista associativa di tutti gli elementi (coppie chiave-valore)
--------------------------------------------------------------------------
(define (hash-items hash)
  (hash))

Esempi:
(hash-items hh)
;-> (("1" "a") ("2" "b") ("3" "c") ("4" "d"))

--------------------------------------------------
HASH-DEL: Eliminazione di un valore tramite chiave
--------------------------------------------------
(define (hash-del hash key)
  (hash key nil))

Esempi:
(hash-del hh "1")
;-> nil
(hash-del hh 2)
;-> nil
(hash-del hh 5)
;-> nil
(hash-items hh)
;-> (("3" "c") ("4" "d"))

----------------------------------------------------
HASH-SIZE: Numero di elementi (coppie chiave-valore)
----------------------------------------------------
(define (hash-size hash)
  (length (hash)))

Esempi:
(hash-size hh)
;-> 2

----------------------------
HASH-KEY?: Chiave esistente?
----------------------------
(define (hash-key? hash key)
  (if (hash (string key)) true nil))

Esempi:
(hash-key? hh 1)
;-> nil
(hash-key? hh 3)
;-> true
(hash-key? hh "4")
;-> true

------------------------------
HASH-VALUE?: Valore esistente?
------------------------------
(define (hash-value? hash value)
  (let (out nil)
    (dolist (item (hash) out)
      (if (= (last item) value)
          (setq out true)
      )
    )
    out))

Esempi:
(hash-value? hh 3)
;-> nil
(hash-value? hh "c")
;-> true

----------------------------
HASH-EMPTY?: Hash-Map vuota?
----------------------------
(define (hash-empty? hash)
  (empty? (hash)))

Esempi:
(hash-empty? hh)
;-> nil

---------------------------------------------------------------------
HASH-CLEAR: Eliminazione di tutti gli elementi (coppie chiave-valore)
---------------------------------------------------------------------
(define (hash-clear hash)
  (map delete (symbols hash))
  nil)

Esempi:
(hash-create 'aa)
;-> aa
(hash-set aa 1 "x")
;-> "x"
(hash-set aa 2 "y")
;-> "y"
(hash-set aa 3 "z")
;-> "z"
(aa)
;-> (("1" "x") ("2" "y") ("3" "z"))
(hash-clear aa)
;-> nil
(aa)
;-> ()

------------------------------------------
HASH-DESTROY: Eliminazione di una hash-map
------------------------------------------
(define (hash-destroy hash)
  (delete hash) (delete hash))

Esempi:
(aa)
(hash-set aa 1 "x")
;-> "x"
(hash-set aa 2 "y")
;-> "y"
(aa)
;-> (("1" "x") ("2" "y"))
(hash-destroy 'aa)
;-> true
(aa)
;-> ERR: invalid function : (aa)

-----------------------------------------------------------------------------------------
HASH-SET-LIST: inserimento degli elementi (coppie chiave-valore) di una lista associativa
-----------------------------------------------------------------------------------------
(define (hash-set-list hash lst)
  (hash lst))

Esempi:
(hh)
;-> (("3" "c") ("4" "d"))
(setq lista '((1 "A") ("2" "B")))
(hash-set-list hh lista)
;-> hh
(hh)
;-> (("1" "A") ("2" "B") ("3" "c") ("4" "d"))

----------------------
HASH?: hash esistente?
----------------------
(define (hash? hash)
  (and (context? (eval hash))
       (not (list? (eval (sym (term hash) hash nil))))))

Esempi:
(hash? hh)
;-> true
(hash? aa)
;-> nil
(hash? xx)
;-> nil

Come funziona?
Cerchiamo tutti i contesti il cui funtore non è una funzione (list?).
L'espressione (sym (term hash) hash nil) restituisce il funtore hash:hash e poi verifichiamo se tale funtore sia una funzione (in questo caso list? restituisce true) oppure no (in questo caso list? restituisce nil).
Questo metodo identifica correttamente tutte le hash-map create con la funzione "new Tree" (fortemente consigliato).

----------------------------------------------------------------------------------
HASH-MAP-LAMBDA: applica una funzione (kv-fn) agli elementi (coppie chiave-valore)
----------------------------------------------------------------------------------
(define (hash-map-lambda kv-fn hash)
  (let (acc)
    (dotree (h hash true)
      (push (kv-fn (rest (term h)) (eval h)) acc -1))
    acc))

Questa funzione permette di applicare una funzione lambda ("kv-fn") a tutti gli elementi (cioè a tutte le coppie chiave-valore) di una hash-map  (kv-fn --> KeyValue-Function). Il risultato è una lista associativa.

Esempi:
(define (hm-keys hash)
  ;;(map first (hash))
  (hash-map-lambda (fn (key _) key) hash))

(hm-keys hh)
;-> ("1" "2" "3" "4")

(define (hm-values hash)
  (hash-map-lambda (fn (_ value) value) hash))

(hm-values hh)
;-> ("A" "B" "c" "d")

(define (hm-items hash)
  (hash-map-lambda (fn (key value) (list key value)) hash))

(hm-items hh)
;-> (("1" "A") ("2" "B") ("3" "c") ("4" "d"))


-------------------
KiloByte e KibiByte
-------------------

Il computer lavora con un sistema binario (0 e 1) e per consuetudine si è deciso di unire le cifre a gruppi di otto. Ogni gruppo di 8 bit prende il nome di "byte".

Un byte può assumere 256 valori, da 0 (00000000) a 255 (11111111).

Nota: Esiste anche il raggruppamento a 4 bit che prende il nome di "nibble" (mezzo byte).

Come per tutte le grandezze comunemente utilizzate, anche per i byte si utilizzano i moltiplicatori che agevolano la scrittura di numeri grandi, con una piccola differenza: mentre nel caso dei Grammi, dei Metri, dei Volt e di tante altre grandezze fisiche, i prefissi K, M, G, ecc... moltiplicano per un fattore 1000 (che è una potenza di 10), nel caso dei byte il fattore di moltiplicazione è 1024 (che è una potenza di 2).

Quindi, fino al 1998, in informatica si utilizzavano i seguenti moltiplicatori:

1 KByte (KiloByte o KB) = 1024 Byte
1 MByte (MegaByte o MB) = 1024 KByte
1 GByte (GigaByte o GB) = 1024 MByte
1 TByte (TeraByte o TB) = 1024 GByte
ecc...

Quando compriamo una memoria di massa la sua capacità viene espressa con questi moltiplicatori. Però quando inseriamo la nostra memoria su un computer, questo ci informa che la capacità è inferiore. Perchè?
I produttori di memorie dichiarano un hard disk da 2 TB utilizzando il fattore 1000 del sistema decimale (cioè circa 2.000.000.000.000 = duemila miliardi di byte), ma quando viene utilizzato dal computer che, più correttamente, fa i conti nel sistema binario, si ottiene uno spazio libero di 1,82 TB, cioè 2.000.000.000.000∕1024∕1024∕1024∕1024 = 1,818989403545856.

A partire dal 1998, sono stati creati dei moltiplicatori appositi per i Byte (in base 2 anziché base 10) che sono identificati dal suffisso bi (binary):

1 KibiByte (KiB) = 1024 Byte
1 MebiByte (MiB) = 1024 KibiByte
1 GibiByte (GiB) = 1024 MebiByte
1 TebiByte (TiB) = 1024 GibiByte
ecc...

Con questi nuovi moltiplicatori l'informatica dispone delle unità di misura corrette della memoria, mentre i costruttori di memorie di massa continuano ad utilizzare i moltiplicatori in base 10 anziché quelli in base 2.
Comunque i nuovi moltiplicatori non sono entrati nell'uso comune e ognuno continua ad usare il sistema che più gli conviene.

Scriviamo una funzione che converte tra queste due unità di misura (e relativi moltiplicatori):

(setq unit-name '("TB" "GB" "MB" "KB" "Byte"
                  "TiB" "GiB" "MiB" "KiB"))

(setq unit-value '(1e12 1.e9 1e6 1e3 1
      1099511627776 1073741824 1048576 1024))

(define (byte val unit)
  (local (idx scala)
    (setq idx (find unit unit-name))
    (setq scala (mul val (unit-value idx)))
    (println val " " unit " is:")
    (dolist (el unit-name)
      (cond ((!= el unit)
            (println (format "%.6f %s" (div scala (unit-value $idx)) el)))
      )
    )))

(byte 2 "TB")
;-> 2 TB is:
;-> 2000.000000 GB
;-> 2000000.000000 MB
;-> 2000000000.000000 KB
;-> 2000000000000.000000 Byte
;-> 1.818989 TiB
;-> 1862.645149 GiB
;-> 1907348.632813 MiB
;-> 1953125000.000000 KiB


--------------------
Blog di Cyril Zlobin
--------------------

Cyril Zlobin scrive un blog su newLISP al seguente indirizzo web:

https://slobin.livejournal.com/tag/lispa%C4%B5oj

Purtoppo non è di facile consultazione perchè è scritto in russo.

Vediamo un post interessante:

Le parentesi non spaventano un vero fanatico di Lisp. Eppure, a volte, in alcuni contesti, sembrano superflue. Proviamo a mettere in evidenza un metodo utile. Scriviamo una macro di sei righe:

(define-macro (make-pass)
  (doargs (arg)
    (letex ((Old arg)
      (New (sym (append (string arg) "&"))))
      (define-macro (New)
        (Old (eval (args)))))))

Trattiamo le funzioni di cui abbiamo bisogno:

(make-pass catch not print)

catch&
;-> (lambda-macro () (catch (eval (args))))
not&
;-> (lambda-macro () (not (eval (args))))
print&
;-> (lambda-macro () (print (eval (args))))

E poi le usiamo in questo modo:

(catch& while (read-line)
  (setq line (current-line))
  (if (not& empty? line)
    (print& format "%s \n" line)
  (throw 'empty)))

Possiamo pensare che le funzioni che terminano con il carattere ampersand "&" combinano due funzioni in una.


-------------------
Lambda the Ultimate
-------------------

Traduzione da "Lambda the Ultimate" di William Cushing

https://softwareengineering.stackexchange.com/questions/107687/what-is-the-origin-and-meaning-of-the-phrase-lambda-the-ultimate

Lambda The Ultimate si riferisce all'idea che le funzioni lambda del lambda-calcolo possono implementare efficacemente ogni concetto di ogni linguaggio di programmazione. Classi, Moduli, Package, Oggetti, Metodi, Flussi di controllo, Strutture dati, MAcro, Continuazioni, Coroutine, Generatori, List comprehensions, Stream, ecc.

Guarda caso, quella natura ultima consiste nella creazione di una funzione anonima (Anonymous Function). Ma le lambda non sono, in sostanza, limitate alle sole funzioni anonime. Viene insegnato in questo modo, ma l'essenza di lambda va molto più in profondità delle funzioni matematiche senza nomi. In altre parole, parliamo di:

  "Capisco cosa significhi "lambda", l'idea di una funzione anonima è sia semplice che potente, ma non riesco a capire cosa significhi "the ultimate" in questo contesto".

In pratica, l'uso di lambda come astrazioni sintattiche ("macro"), che non sono call-by-value (quali sono le funzioni matematiche), è assolutamente cruciale per accettare l'idea che le lambda possano davvero fungere da nucleo di ogni sistema di elaborazione del linguaggio di programmazione.

Per la teoria: c'è un collegamento interessante con il paradosso di Bertrand Russell e gli assiomi di comprensione (ed estensione) nella teoria degli insiemi. Un lambda è per le funzioni ciò che la notazione del generatore di insiemi è per gli insiemi: i lambda sono una notazione per generare funzioni. C'è una differenza importante, solitamente ignorata, tra (lambda (x) (* x x)) e ciò che restituisce (la funzione che calcola il quadrato). Se non si riesce in generale a distinguere tra i due, cioè tra la notazione e la denotazione (un errore commesso anche da Church e Frege), allora si entra in conflitto con i paradossi. Per gli insiemi e per Frege, è il Barbiere di Siviglia di Bertrand Russell a illustrare l'errore, mentre per le funzioni e Church, è l'oracolo di halting di Alan Turing.

Nota che i paradossi sono cose buone, pratiche. Vogliamo che EVAL sia esprimibile e vogliamo che lambda significhi qualcosa di più delle semplici funzioni. Che supporre il contrario porti alla contraddizione è il risultato desiderabile, serve come un bel test di sanità mentale: i lambda difficilmente possono essere definitivi/fondamentali se esprimono solo mere funzioni.

"Racket" (precedentemente PLT Scheme) continua a perseguire l'idea che i linguaggi di programmazione pratici possano davvero essere costruiti, da zero, con "just lambda" (http://racket-lang.org/).

"Kernel", di Shutt, sostiene che lambda non è davvero l'astrazione definitiva. Sostiene che esiste un concetto ancora più primitivo (soprannominato vau) che era noto a Sussman come FEXPR (http://www.wpi.edu/Pubs/ETD/Available/etd-090110-124904/).

Felleisen e compagnia (per Racket) ottengono gran parte della potenza del vau di Shutt usando il concetto di fasi, o metalivelli, che approssimativamente significa eseguire il codice sorgente attraverso più fasi di traduzione (come con la preelaborazione C, ma usando la stessa linguaggio in ogni 'passo' e i 'passi' non sono in realtà del tutto distinti nel tempo). (Quindi, sostengono che un lambda in una fase superiore approssima abbastanza bene un vau). In effetti, sostengono che le fasi sono migliori delle FEXPR, proprio per essere più limitate: in breve, "le FEXPR sono troppo potenti" (vedi il lavoro di Wand, contro il quale Shutt si oppone).

Il Lisp-3 di Brian Smith, "Procedural reflection in programming languages", tenta una rigorosa riformulazione della teoria dei linguaggi simili a LISP lungo le linee di una netta distinzione tra le notazioni (simboli/linguaggio/programmi) e le denotazioni (cose/riferimenti/valori/risultati). http://dspace.mit.edu/handle/1721.1/15961

"The Theory of FEXPRs is Trivial" di Mitchell Wand manda più chiodi nella bara (temporanea?) che Kent Pittman ha costruito per i FEXPR (che, come Felleisen, si oppone ai FEXPR perché rendono la compilazione troppo difficile).

Paul Graham sostiene con forza e a lungo in "On Lisp" che il vero potere sono i lambda come trasformatori di sintassi (macro), piuttosto che come trasformatori di valori (funzioni matematiche). Lo sviluppo di Plotkin del calcolo lambda applicativo potrebbe essere considerato in qualche modo contrastante, perché Plotkin limita il calcolo di Church al suo sottoinsieme call-by-value/applicativo. Naturalmente, gestire la parte applicativa in modo efficiente è molto importante, quindi è importante sviluppare una teoria specializzata per quell'uso di lambda. (Plotkin e Graham non discutono l'uno contro l'altro.)

In effetti, in generale, la nozione di Lambda come Ultimate è solo una questione nell'eterno dibattito tra efficienza ed espressività. La posizione è che lambda è lo strumento definitivo per l'espressività e, con uno studio sufficiente, alla fine si rivelerà anche lo strumento definitivo per l'efficienza. In altre parole, possiamo, se vogliamo, vedere il futuro dei linguaggi di programmazione come niente di più e niente di meno che lo studio di come implementare in modo efficiente tutti i frammenti praticamente rilevanti del calcolo lambda.

"The Next 700 Programming Languages" di Landin, http://www.cs.cmu.edu/~crary/819-f09/Landin66.pdf, è un riferimento accessibile che contribuisce allo sviluppo del concetto che Lambda è Ultimate.


=====================================
Stati, Transizioni e catene di Markov
=====================================

Una catena di Markov può essere pensata come descrizione probabilistica che alcuni eventi si verifichino seguiti da altri eventi. Più matematicamente, descrive le probabilità associate ad uno stato di un sistema di passare a qualsiasi altro stato.
Ad esempio, supponiamo che un sistema con tre stati abbia le seguenti probabilità di transizione:

  (A, A, 0.9)
  (A, B, 0.075)
  (A, C, 0.025)
  (B, A, 0.15)
  (B, B, 0.8)
  (B, C, 0.05)
  (C, A, 0.25)
  (C, B, 0.25)
  (C, C, 0.5)

Ciò indica che se iniziamo con lo stato A, dopo una transizione c'è una probabilità del 90% che lo stato rimanga in A, una probabilità del 7,5% che lo stato cambi in B e un 2,5% che lo stato cambi in C.

Dato uno stato iniziale, una lista con le probabilità di transizione e un numero di transizioni, eseguire la catena di Markov associata fino al numero di transizioni dato e determinare lo stato finale.

Inoltre, calcolare la frequenza di ogni stato per un dato numero di iterazioni della catena di Markov.

Sostituiamo A,B e C con 0,1,2 e rappresentiamo la catena con un grafo:

                       0.025
        >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
        |                                 |
        |      0.15     0.8     0.25      |
      +---+ <--------- +---+ <--------- +---+
  0.9 | 0 |            | 1 |            | 2 | 0.5
      +---+ ---------> +---+ ---------> +---+
        |     0.075             0.05      |
        |              0.25               |
        <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

Le probabilità di transizione sono:

  0 -> 0 con probabilità = 0.9
  0 -> 1 con probabilità = 0.075
  0 -> 2 con probabilità = 0.025
  1 -> 0 con probabilità = 0.15
  1 -> 1 con probabilità = 0.8
  1 -> 2 con probabilità = 0.05
  2 -> 0 con probabilità = 0.25
  2 -> 1 con probabilità = 0.25
  2 -> 2 con probabilità = 0.5

Nota: la somma delle probabilità di transizione associate ad ogni stato deve essere uguale ad 1:

  P(0) = 0.9 + 0.075 + 0.025 = 1
  P(1) = 0.15 + 0.8 + 0.05 = 1
  P(2) = 0.25 + 0.25 + 0.5 = 1

Rappresentiamo gli stati e le relative probabilità di transizione con la lista seguente:

(setq states '((0 (0.9 0.075 0.025))
               (1 (0.15 0.8 0.05))
               (2 (0.25 0.25 0.5))))

Nota: in genere le probabilità di transizione vengono rappresentate con una matrice.

Definiamo una funzione che passa da uno stato ad un altro stato:

(define (next-state cur-state probs)
  (local (rnd stop prob res)
    ; generiamo un numero random
    ; diverso da 1
    (while (= (setq rnd (random)) 1))
    (setq stop nil)
    (setq prob (last (states cur-state)))
    (dolist (p prob stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero, 
      ; allora restituiamo l'indice della probabilità
      (if (< rnd 0)
          (set 'res $idx 'stop true)
      )
    )
    res))

(define (markov states start step iter)
  (local (probs freq)
    ; estrazione lista delle probabilità
    (setq probs '())
    (dolist (s states)
      (push (last s) probs -1)
    )
    ; vettore delle frequenze degli stati finali
    (setq freq (array (length states) '(0)))
    (for (i 1 iter)
      (setq cur-state start)
      (for (t 1 step)
        ;(setq prob (lookup cur-state states))
        ;(setq prob (last (states cur-state)))
        (setq cur-state (next-state cur-state prob))
      )
      ; aggiorna frequenza dello stato finale
      (++ (freq cur-state))
    )
    ; controllo di correttezza
    ;(println (apply + freq))
    freq))

Testiamo la funzione con degli stati che hanno probabilità di transizione su se stessi pari a 1. In questo modo dopo qualunque numero di transizioni deve risultare lo stesso stato iniziale.

(setq test '((0 (0 1 0))
             (1 (0 1 0))
             (2 (0 1 0))))

(markov test 0 100 100000)
;-> (100000 0 0)
(markov test 1 100 100000)
;-> (0 100000 0)
(markov test 2 100 100000)
;-> (0 0 100000)

Adesso proviamo la funzione con i valori di probabilità del problema:

(setq states '((0 (0.9 0.075 0.025))
               (1 (0.15 0.8 0.05))
               (2 (0.25 0.25 0.5))))

Con 100 transizioni partendo da ogni stato otteniamo:

(markov states 0 100 100000)
;-> (62389 31312 6299)
62389 volte stato finale = 0
31312 volte stato finale = 1
 6299 volte stato finale = 2

(markov states 1 100 100000)
;-> (62418 31220 6362)

(markov states 2 100 100000)
;-> (62627 31239 6134)

=============================================================================

