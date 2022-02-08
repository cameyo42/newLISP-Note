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

oppure:

;(new-hash 'pippo)

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
  (new Tree (sym x)))

Esempi:
(hash-create 'hh)
;-> hh

;(hash-create "hh")

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
;-> ()
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


-------------------------------------
Stati, Transizioni e catene di Markov
-------------------------------------

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

Altro test con probabilità di transizione verso altri stati pari a 0.5:

(setq test '((0 (0   0.5 0.5))
             (1 (0.5 0   0.5))
             (2 (0.5 0.5 0))))

(markov test 0 100 100000)
;-> (33229 33450 33321)
(markov test 1 100 100000)
;-> (33299 33437 33264)
(markov test 2 100 100000)
;-> (33226 33430 33344)

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


------------------------------------
Modifica di una lista con un pattern
------------------------------------

Supponiamo di avere una lista con degli elementi qualsiasi:

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))

Un pattern, cioè una lista di elementi:

(setq pat '(A 1))

E una lista di sostituzione (replace):

(setq rep '(X Y))

Quello che vogliamo ottenere è una nuova lista dove tutte le sequenze del pattern (A 1) sono sostituite dalla lista di sostituzione (replace):

  (X Y B 2 "1" "2" X Y 2 B 3.14)

La funzione è la seguente con le spiegazioni nei commenti:

(define (replace-pattern pat lst rep)
  ; se il pattern è un carattere,
  ; allora usiamo la funzione built-in "replace"
  (if (= (length pat) 1)
      (replace (first pat) lst (first rep))
      ; altrimenti...
  (local (idx end found end-pat stop)
    (setq idx 0)
    (setq end (- (length lst) (length pat)))
    ; ciclo per tutta la lista lst
    (while (<= idx end)
      ; se elemento corrente = primo elemento pattern
      (if (= (lst idx) (pat 0))
        (begin
          ; controlla se sono uguali i successivi elementi
          ; della lista con i successivi elementi del pattern
          (setq end-pat (- (length pat) 1))
          (setq found true)
          (setq stop nil)
          (setq k 1)
          (for (i (+ idx 1) (+ idx end-pat) 1 stop)
            ; basta un elemento diverso per 
            ; stabilire che il pattern è diverso
            (if (!= (lst i) (pat k))
                (set 'found nil 'stop true)
            )
            ; aumenta indice della lista pat
            (++ k)
          )
          ; se il pattern è stato trovato,
          ; allora modifichiamo gli elementi della lista lst
          ; con gli elementi della lista rep
          (if found
            (begin
              (setq k 0)
              (for (i idx (+ idx end-pat))
                (setf (lst i) (rep k))
                ; aumenta indice della lista pat
                (++ k)
              )
            )
          )
        )
      )
      ; aumenta indice della lista lst
      (++ idx)
    )
    lst)))

Facciamo alcune prove:

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(A 1))
(setq rep '(X Y))
(replace-pattern pat lst rep)
;-> (X Y B 2 "1" "2" X Y 2 B 3.14)

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(B 3.14))
(setq rep '(X Y))
(replace-pattern pat lst rep)
;-> (A 1 B 2 "1" "2" A 1 2 X Y)

(setq lst '(A 1 B 2 "1" "2" A 1 2 B 3.14))
(setq pat '(2 "1"))
(setq rep '(X Y))
(replace-pattern pat lst rep)

(setq lst '(-8 6 -4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 3))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 -4 8 3 4 0 2 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 3))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 0 0 0 4 0 2 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(-8 6 4 8 3 4 0 2 4 8))
(setq rep '(0 0 0 0 0 0 0 0 0 0))
(replace-pattern pat lst rep)
;-> (0 0 0 0 0 0 0 0 0 0 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(-8 6 4 8 3 4 0 2 4 8 3))
(setq rep '(0 0 0 0 0 0 0 0 0 0 0))
(replace-pattern pat lst rep)
;-> (0 0 0 0 0 0 0 0 0 0 0)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4 8 1))
(setq rep '(0 0 0))
(replace-pattern pat lst rep)
;-> (-8 6 4 8 3 4 0 2 4 8 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 3))
(setq pat '(4))
(setq rep '(A))
(replace-pattern pat lst rep)
;-> (-8 6 A 8 3 A 0 2 A 8 3)

(setq lst '(-8 6 4 8 3 4 0 2 4 8 4 8))
(setq pat '(4 8))
(setq rep '(B B))
(replace-pattern pat lst rep)
;-> (-8 6 B B 3 4 0 2 B B B B)


--------------------
Fisher-Yates shuffle
--------------------

Data una lista di n elementi, scrivere una funzione che "mescola" gli elementi della lista in modo casuale (uniforme).

Come primo approccio usiamo la seguente procedura:

- attraversare la lista (con indice idx)
- generare un numero random j tra 0 e (n - 1) (compreso)
- scambiare i valori di lst(idx) e lst(j)

(define (shuffle1 lst)
  (local (len j)
    (setq len (length lst))
    (for (idx 0 (- len 1))
      (setq j (rand len))
      (swap (lst idx) (lst j))
    )
    lst))

Proviamo la funzione:

(setq lst (sequence 1 10))
;-> (1 2 3 4 5 6 7 8 9 10)
(shuffle1 lst)
;-> (1 3 6 7 5 2 9 10 8 4)
(shuffle1 lst)
;-> (7 10 8 3 6 2 4 5 9 1)
(shuffle1 lst)
;-> (2 3 5 6 4 8 1 7 10 9)

Sembra che i risultati siano corretti, ma dobbiamo ancora verificare se la procedura genera risultati uniformi. Per fare questo usiamo una lista con tre elementi:

(setq lst '(1 2 3))

Applichiamo la funzione "shuffle1" per "iter" volte e calcoliamo la frequenza dei risultati che possono essere 6: (1 2 3), (1 3 2), (2 1 3), (2 3 1), (3 1 2), (3 2 1)

(define (test1 iter)
  (local (res freq out)
    (setq res '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)))
    (setq freq (array 6 '(0)))
    (for (i 1 iter)
      (++ (freq (find (shuffle1 lst) res)))
    )
    freq))

(test1 100000)
;-> (14742 18437 18564 18587 14913 14757)

Il risultato non sembra uniforme. Perchè?
La procedura scambia tre volte (cioè quanti sono gli elementi), quindi ci sono 3^3 = 27 possibili risultati (di cui alcuni uguali). Abbiamo visto che gli unici risultati possibili sono 6, un numero che non divide esattamente 27, quindi alcuni risultati sono in numero maggiore.

Per rendere la funzione uniforme occorre che la probabilità di scegliere un qualunque indice/elemento valga 1/n. Questo può essere fatto con la seguente procedura (algoritmo di Fisher-Yates):

- attraversare la lista (con indice idx)
- generare un numero random j tra idx e (n - 1) (compreso)
- scambiare i valori di lst(idx) e lst(j)

(define (shuffle2 lst)
  (local (len j)
    (setq len (length lst))
    (for (idx 0 (- len 1))
      (setq j (+ idx (rand (- len idx))))
      (swap (lst idx) (lst j))
    )
    lst))

Proviamo la funzione:

(setq lst (sequence 1 10))

(shuffle2 lst)
;-> (4 9 5 2 6 3 8 1 7 10)
(shuffle2 lst)
;-> (7 8 3 5 10 1 4 9 6 2)
(shuffle2 lst)
;-> (4 1 6 5 10 7 9 2 8 3)

Adesso proviamo l'uniformità:

(setq lst '(1 2 3))

(define (test2 iter)
  (local (res freq out)
    (setq res '((1 2 3) (1 3 2) (2 1 3) (2 3 1) (3 1 2) (3 2 1)))
    (setq freq (array 6 '(0)))
    (for (i 1 iter)
      (++ (freq (find (shuffle2 lst) res)))
    )
    freq))

(test2 100000)
;-> (16571 16829 16710 16567 16678 16645)

(test2 1000000)
;-> (166943 166926 166139 166296 167037 166659)

Quindi questo algoritmo garantisce anche l'uniformità dei risultati. Perchè?

Per provarlo abbiamo bisogno di utilizzare un "invariante del ciclo" (loop invariant).
L'invariante è il seguente: ad ogni indice idx del ciclo, tutti gli indici prima di idx hanno la stessa probabilità di contenere un qualuanque elemento della lista.
Consideriamo idx = 0: poichè scambiamo lst(0) con un indice casuale cha varia per tutta la lunghezza della lista, lst(0) ha una probabilità uniforme di essere un qualunque elemento della lista. Quindi l'invariante è vero per il caso base.
Ora consideriamo che il nostro invariante sia vero fino a idx e consideriamo il ciclo a (idx + 1). Dobbiamo calcolare la probabilità che alcuni elementi si trovino all'indice (idx + 1). Questa è uguale alla probabilità di non selezionare quell'elemento fino a idx e poi prenderlo a (idx + 1). 
Tutti i potenziali elementi rimanenti non devono essere stati ancora selezionati, il che significa che non sono stati prelevati da 0 a idx, e questa probabilità vale:

   (n - idx)     (n - 2)           (n - idx -1)
  ----------- * --------- * ... * --------------
      n          (n - 1)            (n - idx) 

Adesso dobbiamo scegliere effettivamente l'elemento. Poichè rimangono (n - idx - 1) elementi per la scelta, questa probabilità è pari a:

        1
  --------------
   (n - idx -1)

Mettendo tutto insieme, la probabilità cercata vale:

   (n - idx)     (n - 2)           (n - idx -1)          1           1
  ----------- * --------- * ... * -------------- * -------------- = ---
      n          (n - 1)            (n - idx)       (n - idx -1)     n

Quindi l'invariante è sempre valido e la dimostrazione è terminata.


----------------------------------------
Una funzione trigonometrica interessante
----------------------------------------

Nel libro "Calculus early transcendentals" di Stewart, Clegg, Watson viene riportata questa funzione trigonometrica:

               Sin(Tan x) - Tan(Sin x)
f(x) = ---------------------------------------
         ArcSin(ArcTan x) - ArcTan(ArcSin x)

(define (func x)
  (div (sub (sin (tan x)) (tan (sin x)))
      (sub (asin (atan x)) (atan (asin x)))))

Calcolare la funzione nei seguenti valori di x: 1, 0.1, 0.01, 0,001 e 0.0001:

(func 1)
;-> 1.183831989375579
Valore vero:
1.183831989375580

(func 0.1)
;-> 1.016735904116213
Valore vero:
1.016735904116213

(func 0.01)
;-> 0.9896373056994818
Valore vero:
0.989637305699482

(func 0.001)
;-> 0
Valore vero:
0.

(func 0.0001)
;-> -1#IND
Valore vero: 
ComplexInfinity

(func 0)
;-> -1#IND
Valore vero: 
Indeterminate

Calcolare il limite della funzione per x->0:

Valore vero:
lim f(x) = 1
 x->0

Proviamo ad avvicinarsi a 0:

(setq x-val '(0.002 0.001 0.0009 0.0008 0.0007 0.0006 0.0005 
              0.0004 0.0003 0.0002 0.0001 0.00001))

(map (fn(x) (list x (func x))) x-val)
;-> ((0.002 -1.#IND) 
;->  (0.001 0) 
;->  (0.0009 -0) 
;->  (0.0008 -1.#IND) 
;->  (0.0007 -1.#IND) 
;->  (0.0006 -1)
;->  (0.0005 -1.#IND)
;->  (0.0004 0)
;->  (0.0003 -1)
;->  (0.0002 -1.#IND)
;->  (0.0001 -1.#IND)
;->  (1e-005 -1.#IND))


Per capire la "variabilità" di questa funzione vedere il grafico "trigo-funzione.png" nella cartella "data".


-----------------------------------
Modificare le liste di associazione
-----------------------------------

Suppuniamo di voler utilizzare una lista di associazione (key value) come una hash-map. Per esempio,

(setq alst '((1 "a") (3 "f") (6 "b") (-1 "x")))

Primo problema: come modificare il valore associato ad una chiave?

(define (update key value)
  (setf (assoc key alst) (list key value)))

(update 1 "k")
;-> (1 "k")
alst
;-> ((1 "k") (3 "f") (6 "b") (-1 "x"))

Ma se la chiave non esiste otteniamo un errore:

(update 11 "z")
;-> ERR: no reference found : nil
;-> called from user function (update 11 "z")

Quindi prima di aggiornare il valore dobbiamo verificare se esiste la chiave:

(define (update key value)
  (if (lookup key alst)
      (setf (assoc key alst) (list key value))))

(update 1 "y")
;-> (1 "y")
alst
;-> ((1 "y") (3 "f") (6 "b") (-1 "x"))

Proviamo con una chiave inesistente:

(update 21 "p")
;-> nil
alst
((1 "y") (3 "f") (6 "b") (-1 "x"))

Nota: anche la seguente funzione opera correttamente perchè la lista "alst" non è un parametro della funzione (quindi non viene copiata in una variabile locale della funzione).

(define (update1 key value)
  (let (item (assoc key alst))
       (if item
           (setf (assoc key alst) (list key value)))))

(update1 1 "aa")
;-> (1 "aa")
alst
;-> ((1 "aa") (3 "f") (6 "b") (-1 "x"))

Secondo problema: poichè una hash-map non contiene chiavi multiple, come impedire l'inserimento di chiavi multiplde nella lista di associazione?

Modifichiamo la funzione "update" in modo che, se la chiave esiste, allora viene aggiornato il valore associato (anche se è lo stesso), altrimenti (cioè quando la chiave non esiste) viene aggiunta una coppia (chiave valore) alla lista.

(define (update key value)
  (if (lookup key alst)
      (setf (assoc key alst) (list key value))
      (push (list key value) alst -1)))

Aggiorniamo il valore con chiave 6:

(update 6 "new")
;-> (6 "new")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "x"))

Aggiorniamo il valore con chiave -1:

(update -1 "xyz")
;-> (-1 "xyz")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz"))

Aggiungiamo una coppia (chiave valore):

(update 21 "ventuno")
;-> (21 "ventuno")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz") (21 "ventuno"))

Per finire scriviamo una funzione per eliminare una coppia (chiave valore) dalla lista di associazione.
In questo caso dovremmo prima verificare se la chiave esiste e poi, eventualmente, eliminare la coppia (chiave valore). Però newLISP ha una funzione integrata "pop-assoc" per eliminare un elemento (chiave valore) di una lista associativa utilizzando la chiave come parametro (la funzione restituisce nil se la chiave non esiste).

(define (remove key) (pop-assoc key alst))

(remove 44)
;-> alst
((1 "aa") (3 "f") (6 "new") (-1 "xyz") (21 "ventuno"))
(remove 21)
;-> (21 "ventuno")
alst
;-> ((1 "aa") (3 "f") (6 "new") (-1 "xyz"))

Nota: per utilizzare una lista associativa conme parametro delle funzioni "update" e "remove" occorre utilizzare i funtori dei contesti come contenitori delle liste (es. (set 'alst:alst '((1 "a") (3 "f")))). In questo modo le liste vengono passate per riferimento e non per valore.

From StackOverflow: modifying association list
----------------------------------------------

-------
0: Jakub M.
-------
I have a problem with modifying entries of an association list. 
When I run this code:

Example A
(set 'Dict '(("foo" "bar")))
(letn (key "foo"
       entry (assoc key Dict))
  (setf (assoc key Dict) (list key "new value")))
(println Dict)

the result is:

(("foo" "new value")) ; OK

which is expected. With this code

Example B
(set 'Dict '(("foo" "bar")))
(letn (key "foo"
       entry (assoc key Dict))
  (setf entry (list key "new value"))) ; the only change is here
(println Dict)

the result is:

(("foo" "bar")) ; huh?

Why the Dict is not being updated in the second case?

What I want is to check if an entry is in the Dict and if it is - update it, otherwise leave it alone. With letn I want to avoid a duplicated code

(letn (key "foo"
       entry (assoc key Dict))
  (if entry ; update only if the entry is there
    (setf entry (list key "new value")))

-------
1: newlisp
-------
In the letn expression the variable entry contains a copy of the association not a reference. Set the association directly as shown in Cormullion's example:

(setf (assoc key Dict) (list key "new value"))

In the newLISP programming model everything can be referenced only once. Assignment always makes a copy.

-------
2: cormullion
-------
My understanding of association lists is that they work like this:

> (set 'data '((apples 123) (bananas 123 45) (pears 7)))
((apples 123) (bananas 123 45) (pears 7))
> (assoc 'pears data)
(pears 7)
> (setf (assoc 'pears data) '(pears 8))
(pears 8)
> data
((apples 123) (bananas 123 45) (pears 8))
> (assoc 'pears data)
(pears 8)
>

If you want to check for the existence of a key and update its value, do something like this:

(letn (key "foo")
   (if (lookup key Dict)
       (setf (assoc key Dict) (list key "new value"))))


--------------------------------------------------
Estrazione di elementi con probabilità predefinite
--------------------------------------------------

Data una lista con dei valori di probabilità associati ai rispettivi indici, scrivere una funzione che estrae casualmente un indice della lista seguendo le probabilità assegnate.

Nota: per maggiori informazioni vedi "Numeri casuali con distribuzione discreta predefinita" nel capitolo "02-funzioni-varie" in cui abbiamo definito la seguente funzione per risolvere il problema:

(define (rand-prob probs)
  (local (out inter cur val found)
    (setq found nil)
    (setq inter '(0.0))
    (setq cur 0)
    ; creazione della lista degli intervalli
    (dolist (el probs)
      (setq cur (round (add cur el) -4))
      (push cur inter -1)
    )
    ; l'ultimo valore della lista degli intervalli deve valere 1
    (if (!= (last inter) 1) (println "Errore: somma probabilita diversa da 1"))
    ;(print inter)
    ; generazione numero random con probabilità predefinite
    (setq val (random))
    (setq out nil)
    ; ricerca in quale intervallo cade il numero random
    ; e restituisce l'indice corrispondente
    (for (i 0 (- (length inter) 2) 1 found)
      (if (and (>= val (inter i)) (<= val (inter (+ i 1))))
        (begin
        (setq out i)
        (setq found true))
      )
    )
    out))

Adesso vediamo un metodo migliore che viene spiegato nei commenti della funzione seguente:

(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1 
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    (if (= rnd 1) (println rnd))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero, 
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

(setq p '(0.05 0.15 0.35 0.45))

Nota: la somma delle probabilità deve valere 1.
(apply add p)
;-> 1

(rand-pick p)
;-> 2

Facciamo alcune prove per verificare la correttezza della funzione:

(setq p '(0.05 0.15 0.35 0.45))
(apply add p)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (50087 150175 349614 450124)
(apply + vet)
;-> 1000000

(setq p '(0.02 0.08 0.7 0.2))
(apply add p)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick p))))
vet
;-> (19943 80205 700466 199386)

Vediamo la differenza di velocità delle due funzioni:

1) "rand-prob"
(setq p '(0.02 0.08 0.7 0.2))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(time (for (i 0 999999) (++ (vet (rand-prob p)))))
;-> 3427.212
vet
;-> (20243 79942 699964 199851)

2) "rand-pick"
(setq p '(0.02 0.08 0.7 0.2))
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(time (for (i 0 999999) (++ (vet (rand-pick p)))))
;-> 724.643
vet
;-> (19974 80153 699845 200028)


--------------------------------------------------------------
Disporre i numeri di una lista nella forma: basso->alto->basso
--------------------------------------------------------------

Data una lista di numeri interi, riorganizzarla in modo che i numeri rispettino la seguente regola:

  basso -> alto -> basso -> alto -> basso -> alto -> ...

In altre parole, ogni elemento pari deve essere maggiore dei suoi elementi a sinistra e destra.

Nota: Supponiamo che nella lista non siano presenti elementi duplicati.

Una soluzione è quella di ordinare prima la lista in ordine crescente. Quindi usare un vettore ausiliario e riempirlo con gli elementi della lista ordinata partendo dai due estremi di quest'ultima e in ordine alternato. Ecco l'algoritmo completo:

  a) Ordinare la lista in ordine crescente.
  b) Inizializzare due indici "i" (inizio lista) e "j" (fine lista) (es. i = 0 e j = n-1).
  c) Creare un vettore "vet" con lunghezza pari a quella della lista.
  d) Inizializzare un indice k = 0 (indice del vettore).
  e) Riempire il vettore con il seguente ciclo:
     (while (i < j)
         vet[k++] = lst[i++]
         vet[k++] = lst[j–-]
     )
  f) Se la lista contiene un numero dispari di elementi,
     allora bisogna aggiungere l'ultimo elemento della lista ordinata al vettore.
  g) Restituire il vettore "vet"

Complessita temporale: O(n*log(n))
Complessita spaziale: O(n)

(define (high-low lst)
  (local (i j k out)
    (setq out (array (length lst) '(0)))
    (setq i 0)
    (setq j (- (length lst) 1))
    (sort lst)
    (setq k 0)
    (while (< i j)
      (setf (out k) (lst i))
      (++ k) (++ i)
      (setf (out k) (lst j))
      (++ k) (-- j)
    )
    ; se la lista contiene un numero dispari di elementi
    ; bisogna aggiungere l'ultimo elemento
    ; della lista ordinata al risultato (out)
    (if (= i j)
        (setf (out (+ i j)) (lst i))
    )
    out))

Proviamo la funzione:

(setq nums '(1 6 5 7 9 2))
(high-low nums)
;-> (1 9 2 7 5 6)

(setq nums '(9 6 8 3 7))
(high-low nums)
;-> (3 9 6 8 7)

Una soluzione più efficiente è quella di iniziare dal secondo elemento della lista e incrementare l'indice di 2 ad ogni passo del ciclo. Se il precedente elemento è maggiore dell'elemento corrente, allora scambiare gli elementi. Allo stesso modo, se l'elemento successivo è maggiore dell'elemento corrente, scambiare gli elementi. Alla fine del ciclo, otterremo la lista nella forma voluta.

Complessita temporale: O(n)
Complessita spaziale: O(1)

(define (h-l lst)
  ; inizia dal secondo elemento e incrementa l'indice
  ; di 2 ad ogni passo del ciclo
  (for (i 1 (- (length lst) 1) 2)
    ; se l'elemento precedente è maggiore dell'elemento corrente,
    ; allora scambia gli elementi  
    (if (> (lst (- i 1)) (lst i))
        (swap (lst (- i 1)) (lst i))
    )
    ; se l'elemento successivo è maggiore dell'elemento corrente,
    ; allora scambia gli elementi
    ; prima controlla che non abbia raggiunto
    ; la fine della lista
    (if (and (< (+ i 1) (length lst))
             (> (lst (+ i 1)) (lst i)))
        (swap (lst (+ i 1)) (lst i)
    )
  )
  lst))

Proviamo la funzione:

(setq nums '(1 6 5 7 9 2))
(h-l nums)
;-> (1 6 5 9 2 7)

(setq nums '(9 6 8 3 7))
(h-l nums)
;-> (6 9 3 8 7)

Vediamo i tempi di esecuzione:

(setq nums (randomize (sequence 1 500)))

(time (high-low nums) 1000)
;-> 247.437

(time (h-l nums) 1000)
;-> 622.307

Malgrado la funzione "h-l" non prevede l'ordinamento della lista o l'uso di un vettore aggiuntivo, risulta più lenta della funzione "high-low". Questo perchè le operazioni di indicizzazione di una lista sono lente.
Infatti se proviamo le funzioni utilizzando un vettore (che ha un tempo di accesso molto più basso di quello di una lista), otteniamo i risultati previsti:

(setq numsvet (array (length nums) nums))

(time (high-low numsvet) 1000)
;-> 105.825

(time (h-l numsvet) 1000)
;-> 76.606


------------
Poker d'assi
------------

Calcolare la probabilità di avere un poker d'assi servito.

numero carte          --> n = 52
insieme degli assi    --> a = 4
insieme non-assi      --> r = n - a = 48
numero carte estratte --> e = 5

Utilizziamo la distribuzione ipergeometrica per trovare la probabilità che estrando 5 carte dal mazzo (senza reinserimento) si ottengano k = 4 assi:

                       binom(a k) * binom((n-a) (e-k))
  P(poker) = P(k=4) = --------------------------------- =
                                binom(n e)

     binom(4 4) * binom(48 1)     1 * 48        1
  = -------------------------- = --------- = ------- = 
          binom(52 5))            2598960     54145
  
  = 1.846892603195124e-005

Quindi,in media, si verifica un poker di assi servito ogni 54145 mani.

Formula per il calcolo del binomiale:

(define (binom num k)
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

Vediamo di scrivere una funzione di simulazione:

(define (poker-servito iter)
  (local (deck sum)
    (seed (time-of-day))
    (setq sum 0)
    (setq deck (sequence 1 52))
    (for (i 1 iter)
      (if (= (difference '(1 2 3 4) (slice (randomize deck) 0 5)) '())
          (++ sum)
      )
    )
    (println sum)
    (div sum iter)))

Dalla formula teorica vediamo quante volte deve uscire un poker di assi servito ogni 1e7 mani:

(div 1e7 54145)
;-> 184.6892603195124

Verifichiamo la funzione di simulazione:

(poker-servito 1e7)
;-> 183
;-> 1.83e-005

Sembra che i risultati concordino.


-------------
Sparse matrix
-------------

Una matrice sparsa (sparse matrix) è una matrice in cui la maggior parte degli elementi ha valore zero.
In genere risulta conveniente rappresentare queste matrici con strutture dati particolari ed utilizare algoritmi specifici. Infatti le operazioni matriciali standard sono molto lente quando abbiamo una sparse-matrix (e sprechiamo anche una grande quantità di memoria). 

Possiamo pensare di comprimere i dati di una sparse-matrix in una struttura dati come una hash-map.
Un elemento (cioè una coppia chiave-valore) della hash-map rappresenta un elemento non-nullo della sparse-matrix, ad esempio se abbiamo un valore 3 alla riga 125 e alla colonna 450 possiamo scrivere:

  ("125-450" 3)

In altre parole, comprimiamo i dati memorizzando nella hash-map solo i valori della matrice diversi da zero.

Scriviamo le funzioni di base per la gestione di una sparse.matrix con una hash-map.

Funzione per creare una sparse-matrix vuota:

(define (sm-new sm-str matrix)
    ; create sparse matrix as hash-table
    (new Tree (sym sm-str)))
    ;((eval (sym sm-str)) (string row "-" col) (list row col))

(sm-new "test")
(test)
;-> ()

Funzione per inserire o modificare o eliminare un valore in una sparse-matrix:

(define (sm-set sm row col value)
  (let (idx (string row "-" col))
       (if (zero? value)
           (sm idx nil)      ; delete value from sm
           (sm idx value)))) ; add/modify value to sm

(sm-set test 2 41 128)
;-> 128
(test)
;-> (("2-41" 128))

Se la chiave (row-col) non esiste, allora crea l'elemento (row-col value).
Se la chiave (row-col) esiste allora aggiorna il valore.
Se il valore vale 0 (zero), allora l'elemento viene eliminato.

Nota: la funzione "sm-set" non controlla se row o col superano i limiti della matrice

Funzione per recuperare un valore da una chiave (row-col):

(define (sm-get sm row col)
  (let (idx (string row "-" col))
       (sm idx)))

(sm-get test 3 4)
;-> nil
(sm-get test 2 41)
;-> 128

Funzione che copia una matrice in una sparse-matrix:

(define (sm-init sm matrix)
  (local (row col val)
    (setq row (length matrix))
    (setq col (length (matrix 0)))
    (for (r 0 (- row 1))
      (for (c 0 (- col 1))
        (if (!= (setq val (matrix r c)) 0)
            (sm (string r "-" c) val)
        )
      )
    )
    (sm)))

(silent (setq m (array 1000 1000 '(0))))
(setf (m 342 28) 1)
(setf (m 213 672) 1)
(setf (m 0 0) 1)
(setf (m 912 421) 1)

(sm-init test m)
;-> (("0-0" 1) ("2-41" 128) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Vediamo meglio la funzione "sm-set":

Aggiorna il valore di una chiave (row e col) esistente:

(sm-set test 0 0 256)
;-> 256
(test)
;-> (("0-0" 256) ("2-41" 128) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Elimina l'elemento con chiave (row-col) dalla sparse-matrix se il valore vale 0:

(sm-set test 213 672 0)
;-> nil
(test)
;-> (("0-0" 256) ("2-41" 128) ("342-28" 1) ("912-421" 1))

Funzione per eliminare tutti gli elementi di una sparse-matrix:

(define (sm-clear sm)
  (map delete (symbols sm))
  nil)

(sm-clear test)
;-> nil
(test)
;-> ()

Funzione per eliminare una sparse-matrix:

(define (sm-destroy sm)
  (delete sm) (delete sm))

(sm-destroy 'test)
;-> true
(test)
;-> ERR: invalid function : (test)

Vediamo alcuni confronti tra una matrice e la relativa sparse-matrix:

Creiamo una nuova sparse-matrix:

(sm-new "demo")
;-> (demo)

Creiamo una matrice con alcuni valori:
(silent (setq m (array 1000 1000 '(0))))
(setf (m 342 28) 1)
(setf (m 213 672) 1)
(setf (m 0 0) 1)
(setf (m 912 421) 1)

Inizializziamo la sparse-matrix:
(sm-init demo m)
;-> (("0-0" 1) ("213-672" 1) ("342-28" 1) ("912-421" 1))

Sommiamo tutti i valori della matrice:
(apply add (flat (array-list m)))
;-> 4

Sommiamo tutti i valori della sparse-matrix:
(apply add (map last (demo)))
;-> 4

Vediamo i tempi di esecuzione:

(time (apply add (flat (array-list m))) 100)
;-> 3209.517

(time (apply add (map last (demo))) 100)
;-> 0

Con 1000000 di elementi nella matrice e 4 elementi nella sparse-matrix era ovvio che la sommatoria sarebbe stata più veloce nel secondo caso.
Vediamo allora il caso in cui le due strutture contengono lo stesso numero di elementi.

Creiamo una nuova sparse-matrix:

(sm-new "demo1")
;-> (demo1)

Creiamo una matrice con alcuni valori:

(silent (setq m1 (array 1000 1000 '(1))))

Inizializziamo la sparse-matrix:

(silent (sm-init demo1 m1))
(length (demo1))
;-> 1000000

Sommianmo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m1)))
;-> 1000000

(apply add (map last (demo1)))
;-> 1000000

(time (apply add (flat (array-list m1))) 100)
;-> 5881.547

(time (apply add (map last (demo1))) 100)
;-> 85486.121

In questo caso la sparse-matrix è molto più lenta. Quindi esiste un limite superiore al numero degli elementi non-nulli della matrice affinchè la sparse-matrix relativa risulti conveniente.
Se i tempi fossero lineari (direttamente proporzionali) con il numero degli elementi, allora potremmo calcolare tale limite nel modo seguente:

Tempo per processare un elemento nella matrice
(div 5188 1e6)
;-> 0.005188

Tempo per processare un elemento nella sparse-matrix

(div 85486 1e6)
;-> (0.085486)

Quindi nel tempo necessario alla matrice di processare tutti gli elementi (5188) la sparse-matrix processa circa 60688 elementi:

(div 5188 0.085486)
;-> 60688.29983857006

Vediamo di verificare questo limite superiore con una matrice che ha 60688 elementi non-nulli.

Creiamo una nuova sparse-matrix:

(sm-new "demo2")
;-> (demo2)

Creiamo una matrice 250*250 = 62500 valori non-nulli:

(silent (setq m2 (array 1000 1000 '(0))))
(for (i 0 249) (for (j 0 249) (setf (m2 i j) 1)))
(count '(1) (flat (array-list m2)))
;-> (62500)

Inizializziamo la sparse-matrix:

(silent (sm-init demo2 m2))
(length (demo2))
;-> 62500

Sommiamo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m2)))
;-> 62500

(apply add (map last (demo2)))
;-> 62500

(time (apply add (flat (array-list m2))) 100)
;-> 3545.95

(time (apply add (map last (demo2))) 100)
;-> 1304.68

In questo caso la sommatoria della sparse-matrix è quasi 3 volte più veloce.

Proviamo con una matrice che ha 100000 elementi non-nulli.

Creiamo una nuova sparse-matrix:

(sm-new "demo3")
;-> (demo3)

Creiamo una matrice 316*316 = 99856 valori non-nulli:

(silent (setq m3 (array 1000 1000 '(0))))
(for (i 0 315) (for (j 0 315) (setf (m3 i j) 1)))
(count '(1) (flat (array-list m3)))
;-> (99856)

Inizializziamo la sparse-matrix:

(silent (sm-init demo3 m3))
(length (demo3))
;-> 99856

Sommiamo tutti i valori e vediamo i tempi di esecuzione in entrambi i casi:

(apply add (flat (array-list m3)))
;-> 99856

(apply add (map last (demo3)))
;-> 99856

(time (apply add (flat (array-list m3))) 100)
;-> 3944.996

(time (apply add (map last (demo3))) 100)
;-> 2883.198

Anche in questo caso la sommatoria della sparse-matrix è più veloce.

Anche se il tempo di esecuzione non è proprio lineare con il numero degli elementi possiamo concludere che la sparse-matrix è conveniente in termini di velocità quando il numero di elementi non-nulli è inferiore al 10% di tutti gli elementi della matrice.

Per maggior rigore il confronto di velocità tra le due strutture dovrebbe essere effettuato dopo aver sviluppato e tenuto conto anche le altre operazioni sulle matrici:

  1) Addizione di uno scalare
  2) Addizione e Sottrazione di matrici
  3) Moltiplicazione tra matrici
  4) Trasposta di una matrice
  5) Inversa di una matrice
  6) Determinante di una matrice
  7) ecc.


------------------------
Perchè (-) × (-) = (+) ?
------------------------

A scuola abbiamo imparato che "meno per meno = più", cioè (-) × (-) = (+).
Ma perchè?

La moltiplicazione gode della proprietà commutativa:

  5 × 4 (volte) = 5 × 4 = 20
  4 × 5 (volte) = 4 × 5 = 20

Ma cosa accade con i numeri negativi?

Nel caso in cui solo il primo moltiplicando è negativo:

  -3 × 4 (volte) = -3 × 4 = -12

Questo risultato deriva dal fatto che una moltiplicazione è una somma ripetuta, cioè -3 ripetuto 4 volte:

  (-3) + (-3) + (-3) + (-3) = -12

Il caso in cui solo il secondo moltiplicando è negativo è più strano.

  3 × -4 (volte) = 3 × -4 = -12
  
Cosa significa ripetere il 3 per -4 volte?

Questo dilemma viene aggirato utilizzando la proprietà commutativa della moltiplicazione:

  3 × -4 (volte) = -4 × 3 (volte) = -4 × 3 = (-4) + (-4) + (-4) = -12

Adesso incontriamo il caso finale dove entrambi i moltiplicandi sono negativi:

  -3 × -4 (volte) =

Cosa significa sommare una quantità negativa un numero negativo di volte?

Prima di rispondere vediamo le proprietà della moltiplicazione:

  Proprietà Commutativa:             a × b = b × a
  
  Proprietà Associativa:             (a × b) × c = a × (b × c)
  
  Esistenza Elemento neutro:         a × 1 = a
  
  Esistenza Elemento assorbente:     a × 0 = 0
  
  Distributiva rispetto addizione:   a × (b + c) = a × b + a × c

Il trucco consiste nell'utilizzare la proprietà dell'esistenza dell'elemento assorbente e la proprietà distributiva della moltiplicazione rispetto all'addizione. Prendiamo un numero negativo qualunque (es. -6) e moltiplichiamolo per una quantità nulla (es. [2 + (-2)] = 0):

  -6 × [2 + (-2)] =
  
Risolviamo questa operazione in due modi
1) non applico la proprietà distributiva

  -6 × 0 = 0

2) applico la proprietà distributiva

  (-6 × 2) + (-6) × (-2) = 
  
  = -12 + (-6) × (-2) = 0
  
Poichè il risultato deve valere 0, allora la quantità (-6) × (-2) deve valere -12. 

Quindi possiamo concludere che:

  (-) × (-) = (+)

Nota: più che una dimostrazione sembra di aver trovato il risultato per esclusione di tutti gli altri casi possibili (tipo Sherlock Holmes: "Quando hai escluso l’impossibile ciò che resta, per quanto improbabile, è la verità").


---------------------------------
Perchè newLISP indicizza da zero?
---------------------------------

Sebbene la maggior parte dei programmatori ci sia abituata, non tutti conoscono perché nella maggior parte dei linguaggi di programmazione è stata scelta l'indicizzazione di liste/vettori che inizia da 0 (0-based). Comunque esistono anche importanti linguaggi che indicizzano partendo da 1 (es. fortran, octave, lua, mathematica, ecc.).

Su questo argomento profondo e pratico allo stesso tempo hanno discusso parecchi informatici. In particolare è interessante l'articolo di Dijkstra "Why numbering should start at zero":
(https://www.cs.utexas.edu/users/EWD/ewd08xx/EWD831.PDF)

Se vogliamo rappresentare i numeri naturali da 2 a 10, abbiamo quattro possibilità (dove "[" e "]" significano intervallo "chiuso" (cioè valore compreso nell'intervallo), mentre "(" e ")" significano intervallo "aperto" (cioè valore non compreso nell'intervallo):

a) 2 <= i <  10  ==>  [2, 10)  ==>  2 3 4 5 6 7 8 9
b) 2 <  i <= 10  ==>  (2, 10]  ==>  3 4 5 6 7 8 9 10
c) 2 <= i <= 10  ==>  [2, 10]  ==>  2 3 4 5 6 7 8 9 10
d) 2 <  i <  10  ==>  (2, 10)  ==>  3 4 5 6 7 8 9

Ci sono ragioni per preferire una delle quattro rappresentazioni?
Certamente:
1) nelle forme a) e b) la differenza tra il limite superiore (10) e il limite inferiore (2) rappresenta il numero di elementi (8).
2) Inoltre in due liste adiacenti il limite inferiore della seconda lista è uguale al limite superirore della prima lista.
3) Per scegliere tra a) e b) occorre notare che la sequenza generata da b) parte da 3 ed esclude il 2 iniziale, che non è quello che ci si aspetta.

Se diamo per vere queste 3 motivazioni possiamo notare che se una lista di N elementi viene indicizzata a partire da 0, allora gli indici validi sono rappresentati dall'intervallo semi-aperto [0, N).

Utilizzare l'intervallo semi-aperto [0, N) è comodo nella maggior parte dei casi:

A) Per memorizzare una lista/vettore bidimensionale (es. un'immagine) utilizzando l'indicizzazione 0-based l'elemento alla riga "i" e colonna "j" si trova all'indice (Col * i) + j, mentre con indicizzazione 1-based lo stesso elemento si trova all'indice (Col * (i - 1)) + j. Nel caso di liste/vettori multidimensionali il vantaggio è ancora maggiore.

B) Usando l'indicizzazione basata su 0, scriviamo la formula per trovare l'elemento centrale di una lista/vettore. Se calcoliamo l'indice centrale con la formula (floor (div (length list) 2)), questo dividerà la lista in due parti, sinistra e destra, ciascuna con una lunghezza pari ad almeno (- (floor (div (length list) 2)) 1).
La parte sinistra avrà sempre tale dimensione e non includerà l'elemento centrale.
La parte destra inizierà dall'elemento centrale e avrà la stessa dimensione se il numero totale di elementi della lista è pari o avrà un elemento in più se è dispari.

C) Scriviamo una tabella hash che associa ogni numero intero (come chiave) ad uno di N slot. Se la lista degli slot è indicizzata a partire da 0, possiamo scrivere slot = chiave mod N, ma se è indicizzato a partire da 1, dobbiamo scrivere slot = (chiave mod N) + 1.

D) Supponiamo di voler inserire le lettere da "A" a "Z" in una lista di lunghezza 26 e con la funzione "char"  che associa un carattere al suo valore ASCII. Con liste 0-based, il carattere "c" viene inserito all'indice  (- (char c) (char "A")), mentre con liste 1-based il carattere viene inserito all'indice (+ 1 (- (char c) (char "A"))).

Dal punto di vista storico il linguaggio più vecchio e importante che usa l'indicizzazione 0-based è il C.
Questo perchè in C un vettore non è altro che una scorciatoia per utilizzare l'aritmetica dei puntatori. Un riferimento all'indice dell'array è intercambiabile con l'aritmetica del puntatori.
Quando dichiariamo un vettore/array:

int a[10];

"a" sta effettivamente memorizzando l'indirizzo di memoria del primo elemento dell'array.

Il valore del primo elemento è accessibile tramite il puntatore:
  *(a)

Se vogliamo accedere al secondo elemento incrementiamo di un passo il puntatore:
  *(a+1)

All'interno del compilatore, a[1] e *(a+1) sono equivalenti. Quindi vediamo, se iniziamo a contare gli indici dell'array da 0, possiamo accedere facilmente agli elementi. Se invece dovessimo iniziare a contare da 1 allora per accedere al primo elemento dovremmo scrivere *(a+1-1) poiché la posizione del primo elemento è a se stesso (cioè richiede una sottrazione aggiuntiva).

Nota: un puntatore *(n) restituisce semplicemente il valore memorizzato nella posizione della memoria 'n'.

Dal punto di vista concettuale il problema deriva dal pensare all'indice come a un numero ordinale.
Per esempio, "primo" elemento è in a[1].
Invece dovremmo pensare all'indice come a un offset dall'inizio.
Per esempio, il "primo" elemento è si trova ad una distanza pari a zero dall'inizio, cioè a[0].
Quindi, per i linguaggi 0-based è comodo pensare in termini di offset, non di numeri ordinali.

Il concetto di offset nasce da come vengono immagazzinati i dati del vettore nelle celle della memoria: un offset zero si posiziona all'inizio dell'array e aumentandolo si sposta dal punto iniziale. In altre parole, l'offset è la distanza dal primo elemento (il primo elemento è a distanza zero dall'inizio).

  ordinale:   1   2   3         N
            +---+---+---+     +---+
            | a | b | c | ... | z |
            +---+---+---+     +---+
  offset:   0   1   2   3   (N-1)

Comunque, anche senza l'analogia con la disposizione dei dati in memoria, il metodo 0-based è preferibile perchè semplifica la scrittura di molti algoritmi.

Nota: la notazione della matematica è 0-based.

Un altra considerazione è che con un linguaggio 0-based possiamo simulare il comportamento di un linguaggio 1-based: infatti possiamo semplicemente allocare l'array in modo che abbia dimensione N + 1 e non usare l'elemento all'indice 0. Il contrario, cioè simulare un comportamento 0-based con un linguaggio 1-based, non è così semplice. Quindi, possiamo concludere che partire da 0 è la scelta corretta (anche se la linguaggio permette di specificare il punto di partenza, il valore 0 dovrebbe essere il valore predefinito).

Nota: il linguaggio Modula-2 (inventato dal Prof. Niklaus Wirth) consente di definire i limiti di inizio e fine di un array (per esempio, da -10 a +10), inoltre è possibile avere anche array indicizzati con tipi enumerati.

Per finire ecco la risposta alla domanda del titolo:

newLISP è 0-based perchè deriva dal LISP (ed è scritto in C).


-------------------
Encode e decode URL
-------------------

(define (url-encode s) (replace "([^a-zA-z0-9\-_\.~])" s (format "%%%X" (char $1)) 0))

(define (url-decode s) (replace "%([0-9A-F][0-9A-F])" s (char (int $1 0 16)) 0))

(url-encode "http://www.newlispfanclub.alh.net/forum/")
;-> "http%3A%2F%2Fwww.newlispfanclub.alh.net%2Fforum%2F"
(url-decode (url-encode "http://www.newlispfanclub.alh.net/forum/"))
;-> "http://www.newlispfanclub.alh.net/forum/"


-------------------------
Divisione di due polinomi
-------------------------

Dati due polinomi, calcolare la loro divisione.
Supponiamo che i polinomi siano rappresentati come liste con la seguente struttura:

f(x) = a0 + a1*x + a2*x^2 + ... + an*x^n

lista = (a0 a1 a2 ... an)

(define (div-poly p1 p2)
  (local (res normalizer coef)
    ; l'algoritmo polynomial synthetic division
    ; funziona con i polinomi rappresentati inversamente
    ; rispetta alla nostra scelta
    (reverse p1)
    (reverse p2)
    ; copia del dividendo
    (setq res p1)
    (setq normalizer (p2 0))
    (for (i 0 (- (length p1) (- (length p2) 1) 1))
      ; per la divisione polinomiale generale (quando i polinomi non sono monomi)),
      ; dobbiamo normalizzare dividendo il coefficiente per il primo coefficiente del divisore
      (setf (res i) (div (res i) normalizer))
      (setq coef (res i))
      (if (!= coef 0) ; inutile moltiplicare per coef = 0
          ; Saltiamo il primo coefficiente del divisore perchè
          ; serve soltanto a normalizzare i coefficienti del dividendo
          (for (j 1 (- (length p2) 1))
            ; La lista res contiene sia il quoziente che il resto
            ; Il resto ha la stessa dimensione/grado del divisore perchè
            ; è quello che non possiamo dividere dal dividendo
            (setf (res (+ i j)) (sub (res (+ i j)) (mul (p2 j) coef)))
          )
      )
    )
    ; calcolo della posizione/indice che divide 
    ; la lista res in quoziente e resto
    (setq separator (- (length res) (- (length p2) 1)))
    (list (reverse (slice res 0 separator)) (reverse (slice res separator)))))

Proviamo con la seguente divisione: 

  (x^3 - 12*x*x - 42) / (x - 3)

Il cui risultato vale:

  x^3 - 12*x^2 - 42 = (x^2 - 9*x - 27)*(x - 3) - 123

(div-poly '(-42 0 -12 1) '(-3 1))
;-> ((-27 -9 1) (-123))

quoziente = - 27 - 9*x + x^2 = x^2 - 9*x - 27
resto = -123

Proviamo un'altra divisione:

  (6*x^7 - 14*x^6 + 4*x^5 - 14*x^4 + 16*x^3 - 44*x^2 + 26*x + 20)
  --------------------------------------------------------------- = 
            (3*x^5 - x^4 + 3*x^3 - 2*x^2 + 7*x - 10)

  = (2*x^2 - 4*x - 2)

(div-poly '(20 26 -44 16 -14 4 -14 6) '(-10 7 -2 3 -1 3))
;-> ((-2 -4 2) (0 0 0 0 0))

oppure

(div-poly (reverse '(6 -14 4 -14 16 -44 26 20)) (reverse '(3 -1 3 -2 7 -10)))
;-> ((-2 -4 2) (0 0 0 0 0))

quoziente = - 2 - 4*x + 2*x^2 = 2*x^2 - 4*x - 2
resto = 0


----------------
Coda di priorità
----------------

Una coda di priorità (Priority Queue) è un tipo di dati astratto simile a una coda, tuttavia, nella coda di priorità, ogni elemento ha una priorità. La priorità degli elementi determina l'ordine in cui gli elementi vengono rimossi dalla coda di priorità. Pertanto tutti gli elementi sono disposti in ordine crescente o decrescente.

Quando due elementi diversi hanno la stessa priorità ci sono diveri modi per trattare il problema:

1) uno solo degli elementi viene mantenuto 
  1a) un elemento eliminato casualmente
  1b) vecchio elemento eliminato
  1c) nuovo elemento eliminato

2) vengono mantenuti entrambi gli elementi
  2a) estratti casualmente
  2b) estratti in base all'ordine FIFO (First In First Out)
  2c) estratti in base ad altro criterio

L'implementazione seguente mantiene un solo elemento, quello nuovo (cioè quello che viene inserito per ultimo).
Utilizziamo una hash-map per simulare una coda di priorità, dove la chiave della hash-map rappresenta la priorità della coda e il valore rappresenta l'elemento della coda:

               key = priority
               value = element
  (hash key value) ==> (hash priority element)

  Item of priority queue ==> (priority element)

Elenco delle funzioni standard di una coda di priorità:

1) pq_create (creates a priority queue)
2) pq_destroy (destroy a priority queue)
3) pq_push (insert an item (priority element))
4) pq_max (return element with highest priority)
5) pq_min (return element with lowest priority)
6) pq_pop_max (extract element (and delete item) with highest priority)
7) pq_pop_min (extract element (and delete item) with lowest priority)
8) pq_length (length of priority queue)

Funzione per creare una coda di priorità:

(define (pq_create pq)
  (new Tree (sym pq)))

(pq_create 'test)
;-> test

Funzione per eliminare una coda di priorità:

(define (pq-destroy pq)
  (delete pq) (delete pq))

Funzione per inserire un item (priority element) in una coda di priorità:

(define (pq_push pq prior value)
  (pq prior value))

(pq_push test 3 "Nagarjuna")
(pq_push test 2 "newLISP")
(pq_push test 4 "LISP")
(pq_push test 1 "Luna")
(test)
;-> (("1" "Luna") ("2" "newLISP") ("3" "Nagarjuna") ("4" "LISP"))

Funzione per vedere l'elemento con priorità massima:

(define (pq_max pq)
  (last (first (pq))))

(pq_max test)
;-> "Luna"

Funzione per vedere l'elemento con priorità minima:

(define (pq_min pq)
  (last (last (pq))))

(pq_min test)
;-> "LISP"

Funzione per estrarre l'elemento con priorità massima:

(define (pq_pop_max pq)
  (local (lst item element priority) 
    (setq lst (pq))
    (setq item (first lst))
    (setq element (last item))
    (setq priority (first item))
    (pq priority nil)
    element))

(pq_pop_max test)
;-> "Luna"
(test)
;-> (("2" "newLISP") ("3" "Nagarjuna") ("4" "LISP"))

Funzione per estrarre l'elemento con priorità minima:

(define (pq_pop_min pq)
  (local (lst item element priority) 
    (setq lst (pq))
    (setq item (last lst))
    (setq element (last item))
    (setq priority (first item))
    (pq priority nil)
    element))

(pq_pop_min test)
;-> "LISP"
(test)
;-> (("2" "newLISP") ("3" "Nagarjuna"))

Sembra che tutto stia andando bene, ma abbiamo un problema causato dai seguenti comportamenti:
- una hash-map è sempre ordinata in ordine lessicografico.
- la chiave di ogni coppia di una hash-map è sempre una stringa

Questo vuol dire che i valori di priorità sono stringhe e non seguono l'ordinamento naturale dei numeri. Per esempio inseriamo un item con priorità "22" e poi visualizziamo la coda di priorità:

(pq_push test 22 "dove")
;-> "dove"
(test)
;-> (("2" "newLISP") ("22" "dove") ("3" "Nagarjuna"))

L'item ("22" "dove") non si trova all'ultimo posto (22 > 3) perchè nell'ordine lessicografico la stringa "22" viene prima della stringa "3".

Quindi la nostra coda di priorità simulata con una hash-map funziona con priorità ordinate in modo lessicografico (e questo la rende poco utilizzabile).

Proviamo ad implementare una coda di priorità con una lista associativa:

  ((priorità1 elemento1) (priorità2 elemento2) ... (prioritàN elementoN))

Funzione per la creazione di una lista (associativa) vuota:

(define (la_create cp)
  (set (sym cp cp) '()))

(la_create 'lst)
;-> ()
lst:lst
;-> ()

Nota: la lista definita è il funtore di default del contesto creato (in questo caso "lst").

Funzione per l'eliminazione di una lista (associativa):

(define (la_destroy cp)
  (delete cp))

(la_destroy 'lst:lst)
;-> true
lst:lst
;-> nil

Funzione per l'inserimento di un item (priorità elemento):

(define (la_push cp priority element)
  (push (list priority element) cp)
  (sort cp))

(la_push lst 3 "Nagarjuna")
(la_push lst 2 "newLISP")
(la_push lst 4 "LISP")
(la_push lst 1 "Luna")
lst:lst
;-> ((1 "Luna") (2 "newLISP") (3 "Nagarjuna") (4 "LISP"))

Funzione per vedere l'elemento con priorità massima:

(define (la_max cp)
  (last (first cp)))

(la_max lst)
;-> "Luna"

Funzione per vedere l'elemento con priorità minima:

(define (la_min cp)
  (last (last cp)))

(la_min lst)
;-> "LISP"

Funzione per estrarre l'elemento con priorità massima:

(define (la_pop_max cp)
    (last (pop cp)))

(la_pop_max lst)
;-> "Luna"
lst:lst
;-> ((2 "newLISP") (3 "Nagarjuna") (4 "LISP"))

Funzione per estrarre l'elemento con priorità minima:

(define (la_pop_min cp)
    (last (pop cp -1)))

(la_pop_min lst)
;-> "LISP"
lst:lst
;-> ((2 "newLISP") (3 "Nagarjuna"))

Funzione per calcolare la lughezza di una lista associativa:

(define (la_length cp)
  (length cp))

(length lst)
;-> 3

Inseriamo un item con priorità 22:

(la_push lst 22 "dove")
;-> ((2 "newLISP") (3 "Nagarjuna") (22 "dove"))

Adesso l'ordinamento delle priorità è quello numerico.

Per quanto riguarda il problema degli item con la stessa priorità, viene estratto l'elemento che viene prima nell'ordinamento. Per esempio nel caso seguente l'elemento "dove" viene prima di "quando":

(la_push lst 22 "quando")
;-> ((2 "newLISP") (3 "Nagarjuna") (22 "dove") (22 "quando"))

Nel caso seguente i numeri (123) vengono prima delle stringhe ("dove" e "quando").

(la_push lst 22 123)
;-> ((2 "newLISP") (3 "Nagarjuna") (22 123) (22 "dove") (22 "quando"))

Nota: negli esempi visti abbiamo definito la variabile lst:lst come una lista che simula la coda di priorità. Non possiamo utilizzare un simbolo/variabile con il nome "lst" perchè "lst:lst" rappresenta il simbolo "lst" nel contesto "lst" (ed è protetto). Per esempio:

(setq lst 10)
;-> ERR: symbol is protected in function setf : lst


------------------
Triangoli eroniani
------------------

La formula di Erone per l'area di un triangolo data la lunghezza dei suoi tre lati a, b e c è data da:

   Area = sqrt[S*(S-a)*(S-b)*(S-c)]
  
dove S è la metà del perimetro del triangolo:

  S = (a+b+c)/2

I "triangoli eroniani" sono triangoli i cui i lati e l'area sono tutti numeri interi (e quindi anche il perimetro). Un esempio è il triangolo di lati 3, 4, 5 la cui area è 6 (e il cui perimetro è 12).

Notare che qualsiasi triangolo i cui lati sono tutti un multiplo intero di 3, 4, 5 (come 6, 8, 10) è un triangolo eroniano.

Definiamo "triangolo eroniano primitivo" un triangolo eroniano in cui il massimo comune divisore di tutti e tre i lati è 1 (unità). Questo esclude, ad esempio, il triangolo 6, 8, 10.

Scrivere una funzione che calcola tutti i triangoli primitivi eroniani con lati <= n.

Funzione cha calcola l'area di un triangolo con la formula di Erone:

(define (heron-area a b c)
  (let (s (div (add a b c) 2))
        (sqrt (mul s (sub s a) (sub s b) (sub s c)))))

Per verificare se un numero x è un intero possiamo scrivere:

(define (int? x) (zero? (mod x 1)))

(int? 3)
;-> true
(int? 3.0)
;-> true
(int? 0.0)
;-> true
(int? 0.1)
;-> nil
(int? 10.0000001)
;-> nil

Attenzione, se il numero x è "molto prossimo" ad un intero, allora la funzione restituisce un risultato errato:

(int? (add 1 1e-15))
;-> nil ; corretto
(int? (add 1 1e-16))
;-> true ; errato

(int? (add 10 1e-15))
;-> nil ; corretto
(int? (add 10 1e-16))
;-> true ; errato

(int? (add 100 1e-15))
;-> true ; errato

Funzione che verifica se un triangolo è eroniano:

(define (heron? area)
  (and (zero? (mod area 1)) (!= area 0)))

Funzione per calcolare i triangoli eroniani con i lati <= n:

(define (heronian n)
  (local (out)
    (setq out '())
    (for (c 1 n)
      (for (b 1 c)
        (for (a 1 b)
          (if (and (= (gcd a b c) 1) (heron? (heron-area a b c)) (> (+ c b) a))
              ;(push (list a b c (+ a b c) (int (heron-area a b c))) out)
              (push (list (int (heron-area a b c)) (+ a b c) a b c) out)
          )
        )
      )
    )
    (sort out)))
    
Calcoliamo il numero di triangoli eroniani con lati <= 200:

(length (setq h (heronian 200)))
;-> 517

Triangoli Eroniani con area = 210:

(filter (fn(x) (= (first x) 210)) h)
;-> ((210 70 17 25 28) (210 70 20 21 29) 
;->  (210 84 12 35 37) (210 84 17 28 39) 
;->  (210 140 7 65 68) (210 300 3 148 149))


-----------------------------------------------------------
Benchmark: passaggio per valore e passaggio per riferimento
-----------------------------------------------------------

Vediamo la differenza di velocità di una funzione utilizzando il passaggio dei parametri per valore e il passaggio dei parametri per riferimento.

Nota: utilizzare un REPL nuova per effettuare questo test.

Funzione di test:

(define (test lst tipo-somma iter)
  (for (i 1 iter)
      (if (= tipo-somma 1)
          (somma1 lst)
          (somma2 lst)
      )))

Somma con metodo iterativo:

(define (somma1 lst)
  (let (sum 0)
    (dolist (k lst) (++ sum k))
    sum))

Somma con "apply":

(define (somma2 lst) (apply + lst))

Benchmark con lista da 1e5 elementi:

(setq items 1e5)
(silent (setq lst (sequence 1 items)))
(silent (set 'ab:ab (sequence 1 items)))

(time (println (length lst)))
;-> 10000000
;-> 3.001
(time (println (length ab:ab)))
;-> 10000000
;-> 2

(time (test lst 1 1000))
;-> 8885.252
(time (test lst 2 1000))
;-> 3329.597

(time (test ab 1 1000))
;-> 7648.372
(time (test ab 2 1000))
;-> 1984.02

Benchmark con lista da 1e7 elementi:

(setq items 1e7)
(silent (setq lst (sequence 1 items)))
(silent (set 'ab:ab (sequence 1 items)))

(time (println (length lst)))
;-> 10000000
;-> 39.658
(time (println (length ab:ab)))
;-> 10000000
;-> 34.923

(time (test lst 1 1))
;-> 1600.369
(time (test lst 2 1))
;-> 619.414

(time (test ab 1 1))
;-> 876.286
(time (test ab 2 1))
;-> 652.971

Il passaggio per riferimento (call-by-reference) è più veloce del passaggio per valore (call-by-value).
Comunque questa differenza varia molto in base alle situazione del contesto (RAM disponibile, velocità hard-disk, numero di processi in esecuzione, ecc.)


---------------
Sort topologico
---------------

In teoria dei grafi un ordinamento topologico (topological sort) è un ordinamento di tutti i vertici di un grafo aciclico diretto (DAG, directed acyclic graph). 
I vertici di un grafo si definiscono ordinati topologicamente se i vertici sono disposti in modo tale che ogni nodo viene prima di tutti i vertici collegati ai suoi archi uscenti. In altre parole, v(1),v(2),v(3),...v(n) è un ordinamento topologico dei vertici tale che se c'è un arco entrante nel vertice "v(j)" dal vertice "v(i)", allora v(i) viene prima di v(j).
L'ordinamento topologico non è un ordinamento totale, poiché la soluzione può non essere unica. Nel caso peggiore infatti si possono avere n! ordinamenti topologici diversi che corrispondono a tutte le possibili permutazioni degli n vertici. 

Per avere un ordinamento topologico il grafo non deve contenere cicli. Per dimostrarlo, assumiamo che esista un ciclo formato dai vertici v(1), v(2), v(3) ... v(n). Ciò significa che esiste un arco diretto tra v(i) e v(i+1) (1 <= i < n) e tra v(n) e v(1). Quindi ora, se eseguiamo l'ordinamento topologico, allora v(n) deve precedere v(1) a causa dell'arco diretto da v(n) a v(1). Chiaramente, v(i+1) verrà dopo v(i), a causa dell'arco diretto da v(i) a v(i+1), ciò significa che v(1) deve precedere v(n). Siamo caduti in una contraddizione, quindi l'ordinamento topologico può essere ottenuto solo per i grafici aciclici diretti (DAG).

Esempi
L'applicazione canonica dell'ordinamento topologico risiede nel problema di pianificare l'esecuzione di una sequenza di attività in base alle loro dipendenze. Le attività sono rappresentate dai nodi di un grafo: vi è un arco tra x e y se l'attività x deve essere completata prima che possa iniziare l'esecuzione dell'attività y. Un ordinamento topologico del grafo così ottenuto fornisce un ordine in cui eseguire le attività.

Ad esempio la sequenza di attività:

  x     ( y )
  -----------
  0 --> (1 3)
  1 --> (2 3)
  2 --> (3 4 5)
  3 --> (4 5)
  4 --> (5)
  5 --> ()

viene rappresentata dal grafico riportato nella parte superiore del file "toposort.png" disponibile nella cartella "data".

Un ordinamento topologico valido è 0,1,2,3,4,5.

La seguente sequenza di attività genera il grafico riportato nella parte inferiore del file "toposort.png" disponibile nella cartella "data".

  x      ( y )
  -----------
  0  --> () 
  1  --> (4 6)
  2  --> (7)
  3  --> (4 7)
  4  --> (5)
  5  --> ()
  6 -->  ()
  7 -->  (0 5 6)

Alcuni ordinamenti topologici validi sono:

  3, 2, 1, 7, 4, 0, 5, 6 (graficamente da sinistra a destra e dall'alto al basso)
  1, 2, 3, 4, 7, 0, 5, 6 (prima i nodi con i valori minori della loro numerazione)
  1, 3, 4, 2, 7, 6, 0, 5
  2, 3, 1, 4, 7, 6, 5, 0
  3, 2, 7, 1, 6, 4, 5, 0 (prima i nodi con i valori maggiori della loro numerazione)
  3, 2, 7, 0, 1, 4, 5, 6

Un esempio pratico di attività in sequenza è data dalle propedeuticità di un corso di laurea composto da n esami: alcuni esami sono propedeutici ad altri esami e il tutto forma un grafo DAG. Per rappresentare il grafo bisogna indicare ogni esame come un nodo e inserire un arco dall'esame "i" all'esame "j" se "i" è propedeutico a "j".
Per esempio:
   0  Fondamenti di Elettronica
   1  Fondamenti di Informatica
   2  Fondamenti di Programmazione
   3  Fondamenti di Matematica
   4  Analisi I
   5  Analisi II
   6  Algoritmi e Strutture dei Dati I
   7  Algoritmi e Strutture dei Dati II
   8  Paradigmi di Programmazione
   9  Sistemi Operativi
  10  Teoria della Computazione
  11  Ricerca Operativa
  12  Calcolo Numerico
  13  Matematica Discreta
  14  Calcolo delle Probabilità
  15  Statistica
  16  Metodi di Problem Solving
  17  Data Analysis
  18  Intelligenza Artificiale
  
  0  --> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18)
  1  --> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18)
  2  --> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18)
  3  --> (4 5 6 7 8 9 10 11 12 13 14 15 16 17 18)
  4  --> (5 14 16 17 18)
  5  --> (12 13 15)
  6  --> (7)
  7  --> (8 9 10)
  8  --> (10)
  9  --> ()
  10 --> (18)
  11 --> (16 17)
  12 --> ()
  13 --> ()
  14 --> (15)
  15 --> (17)
  16 --> (18)
  17 --> ()
  18 --> ()

Esistono diversi algoritmi per trovare un ordinamento topologico (anche in tempo lineare).

L'algoritmo harvtxt, descritto da Kahn (1962),[1] sceglie i vertici rispettando l'ordinamento topologico. Inizialmente, costruisce un insieme di vertici che non hanno archi entranti (grado entrante=0). Dato che il grafo è aciclico esiste almeno uno di questi nodi. Poi:

  L ← lista vuota che conterrà gli elementi ordinati topologicamente
  S ← insieme di nodi senza archi entranti
  while S non è vuoto do
      rimuovi un vertice u da S
      inserisci u in L
      for each vertice v con un arco e da u a v do
          rimuovi arco e dal grafo
          if v non ha altri archi entranti then
              inserisci v in S
  if il grafo ha ancora archi then
      ritorna un errore (il grafo ha almeno un ciclo)
  else
      ritorna L (l'ordinamento topologico)

Se il grafo è un DAG, la soluzione è contenuta nella lista L (non necessariamente unica). Altrimenti, il grafo ha almeno un ciclo ed è impossibile ottenere un ordinamento topologico.

L'insieme S può essere un set, una coda o una pila dato che non importa in quale ordine vengono estratti i vertici. Differenti soluzioni sono dovute all'ordine in cui i nodi vengono estratti da S.

Per un grafo G(V,E) dove V è l'insieme dei nodi e E l'insieme degli archi, entrambi gli algoritmi presentano una complessità lineare O(|V|+|E|), mentre l'inserimento di ciascuno dei |V| vertici in testa alla lista concatenata richiede tempo costante. Complessivamente, quindi, gli algoritmi impiegano tempo O(|V|+|E|).

Un altro algoritmo consiste nel trovare una permutazione dei vertici in cui per ogni vertice v(i), tutti i vertici v(j) aventi archi uscenti e diretti verso v(i) precedono v(i). Usiamo una lista "topo" per contenere l'ordinamento topologico. Per un generico grafo avente "n" vertici, abbiamo un vettore "in-degree" di dimensione "n" il cui i-esimo elemento indica il numero di vertici che non sono già inseriti in "topo" e da essi c'è un arco incidente sul vertice "i". Aggiungiamo i vertici v(i) all'array "topo", e poi diminuiamo il valore di "in-degree(v(j))" di 1 per ogni arco da v(i) a v(j). Ciò significa che abbiamo inserito un vertice con arco diretto verso v(j). Quindi in qualsiasi momento possiamo inserire solo quei vertici per i quali il valore di "in-degree" è 0. 

L'implementazione seguente usa l'algoritmo Best-First-Search per visitare il grafo. 
Inoltre il grafo viene rappresentato con una matrice di adiacenza binaria A con V righe e V colonne. L'elemento A(i,j) vale 1 se c'è un arco dal vertice "i" al vertice "j", altrimenti A(i,j) vale 0.

(define (toposort dag)
  (local (num-vertex topo visited in-degree vertex queue)
    (setq num-vertex (length dag))
    (setq topo '())
    (setq visited (array num-vertex '(0)))
    (setq in-degree (array num-vertex '(0)))
    (setq queue '())
    (for (i 0 (- num-vertex 1))
      (for (j 0 (- num-vertex 1))
        (if (= (dag i j) 1)
            (++ (in-degree j))
        )
      )
    )
    (for (i 0 (- num-vertex 1))
      (if (zero? (in-degree i))
        (begin
          (push i queue)
          (setf (visited i) 1)
        )
      )
    )
    (while queue
      (setq vertex (pop queue -1))
      (push vertex topo -1)
      (for (j 0 (- num-vertex 1))
        (if (and (= (dag vertex j) 1) (zero? (visited j)))
          (begin
            (-- (in-degree j))
            (if (zero? (in-degree j))
              (begin
                (push j queue)
                (setf (visited j) 1)
              )
            )
          )
        )
      )
    )
    topo))

Applichiamo la funzione agli esempi precedenti:

(setq dag1 '((0 1 0 1 0 0)
             (0 0 1 1 0 0)
             (0 0 0 1 1 1)
             (0 0 0 0 1 1)
             (0 0 0 0 0 1)
             (0 0 0 0 0 0)))

(toposort dag1)
;-> (0 1 2 3 4 5)

(setq dag2 '((0 0 0 0 0 0 0 0)
             (0 0 0 0 1 0 1 0)
             (0 0 0 0 0 0 0 1)
             (0 0 0 0 1 0 0 1)
             (0 0 0 0 0 1 0 0)
             (0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0)
             (1 0 0 0 0 1 1 0)))

(toposort dag2)
;-> (1 2 3 4 7 0 5 6)

(setq dag3 '((0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
             (0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
             (0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
             (0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1)
             (0 0 0 0 0 1 0 0 0 0 0 0 0 0 1 1 1 1 1)
             (0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1 0 0 0)
             (0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
             (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)))

(toposort dag3)
;-> (0 1 2 3 4 6 11 5 14 16 7 12 13 15 8 9 17 10 18)

=============================================================================

