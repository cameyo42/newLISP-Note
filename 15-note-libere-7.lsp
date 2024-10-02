===============

 NOTE LIBERE 7

===============

There is surely nothing other than the single purpose of the present moment.
A man's whole life is a succession of moment after moment.
If one fully understands the present moment, there will be nothing else to do,
and nothing else to pursue.
"Hagakure Kikigaki" by Yamamoto Tsunetomo

Di certo non esiste altro che il particolare scopo del momento presente.
Tutta la vita di un uomo è fatta di momenti che si susseguono.
Chi sa comprendere pienamente il momento presente, non dovrà fare altro né dovrà porsi altri scopi.
"Hagakure: Il Libro Segreto dei Samurai" di Yamamoto Tsunetomo

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

Aggiornamento dei valori di una hash-map
----------------------------------------
Quando si impostano i valori hash, la variabile anaforica di sistema "$it" può essere utilizzata per riferirsi al vecchio valore quando si imposta il nuovo:

(myhash "bar" "hello world")
;-> "hello world"

(myhash "bar" (upper-case $it))
;-> "HELLO WORLD"

(myhash "bar")
;-> "HELLO WORLD"

Supponiamo di voler inserire in una chiave della hash-map una lista di valori, cioè ogni volta che accediamo ad una coppia chiave-valore vogliamo aggiungere un nuovo valore (chiave (valore nuovo-valore)).
Il valore iniziale di una coppia (chiave valore) è nil, quindi non possiamo usare "append" o "extend" per aggiungere un nuovo valore. La soluzione consiste nel controllare il valore di $it ed effettuare operazioni diverse nel caso il valore sia nil oppure no. Vediamo un esempio:

Creiamo una hash-map:

(new Tree 'hh)
(hh)
;-> ()

Aggiungiamo 5 coppie (chiave valore) dove la chiave vale "i" e il valore è una lista con numeri che vanno da 1 a i:

(for (i 1 5)
  (setq key (string i))
  (for (k i 1 -1)
    (hh key (if $it (extend (list k) $it)  (list k)))
  )
)

Vediamo il contenuto della hash-map:

(hh)
;-> (("1" (1)) ("2" (1 2)) ("3" (1 2 3)) ("4" (1 2 3 4)) ("5" (1 2 3 4 5)))

L'espressione chiave è:

(hh key (if $it (extend (list k) $it)  (list k))))

Se $it vale nil, allora inserisce il numero come lista
altrimenti aggiunge il numero alla lista $it.

Vediamo un altro esempio dove il valore nella coppia (chiave valore) è una lista di coppie di valori.

Eliminiamo e ricreiamo la hash-map:

(delete 'hh)
(new Tree 'hh)

(for (i 1 5)
  (setq key (string i))
  (for (k i 1 -1)
    (hh key (if $it (extend (list (list i k)) $it)  (list (list i k))))
  )
)

Vediamo il contenuto della hash-map:

(hh)
;-> (("1" ((1 1)))
;->  ("2" ((2 1) (2 2)))
;->  ("3" ((3 1) (3 2) (3 3)))
;->  ("4" ((4 1) (4 2) (4 3) (4 4)))
;->  ("5" ((5 1) (5 2) (5 3) (5 4) (5 5))))

Salvataggio delle hash-map
--------------------------
Le hash-map possono essere salvate in un file e ricaricate in un secondo momento:

; save dictionary
(save "myhash.lsp" 'myhash)
;-> true

Caricamento di una hash-map dal file "myhash.lsp":

(load "myhash.lsp")
;-> MAIN
(myhash)
(("1" "a") ("2" "b") ("3" 4) ("5" 6) ("bar" "HELLO WORLD"))

Per ulteriori informazioni, vedere "Hash-map e contesti" nel capitolo "Note libere 5".


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
HASH-SET-ALIST: Inserimento degli elementi (coppie chiave-valore) di una lista associativa
HASH-SET-LIST: Inserimento degli elementi (coppie chiave-valore) di una lista (chiave autocreata)
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
HASH-SET-ALIST: inserimento degli elementi (coppie chiave-valore) di una lista associativa
-----------------------------------------------------------------------------------------
(define (hash-set-alist hash lst)
  (hash lst))

Esempi:
(hh)
;-> (("3" "c") ("4" "d"))
(setq lista '((1 "A") ("2" "B")))
(hash-set-alist hh lista)
;-> hh
(hh)
;-> (("1" "A") ("2" "B") ("3" "c") ("4" "d"))

-------------------------------------------------------------------------------------------------
HASH-SET-LIST: Inserimento degli elementi (coppie chiave-valore) di una lista (chiave autocreata)
-------------------------------------------------------------------------------------------------
La chiave è un numero sequenziale da 1 al numero di elementi della lista.
Le coppie (chiave valore) sono del tipo (string-num list-element).

(define (hash-set-list hash lst)
  (hash (map list (sequence 1 (length lst)) lst)))

Esempi:
(hash-create 'bb)
;-> bb
(bb)
;-> ()
(setq lista '("a" "A" "b" "B"))
(hash-set-list bb lista)
;-> bb
(bb)
;-> (("1" "a") ("2" "A") ("3" "b") ("4" "B"))

Nota: la funzione crea le chiavi come numeri da 1 alla lunghezza della lista. Se la hash-map contiene valori con le stesse chiavi, allora i valori della lista sovrascrivono i valori (coppie chiave-valore) della hash-map.

(setq nuova '("g" "h"))
(hash-set-list bb nuova)
;-> bb
(bb)
;-> (("1" "g") ("2" "h") ("3" "b") ("4" "B"))

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

Vediamo un altro esempio. Data la lista associativa:

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))

come possiamo rimuovere le stringhe "fred" "jim" "arthur" e "dave"?

Primo metodo
------------
Utilizziamo "pop" in ciascuna sotto-lista

; remove the element at offset 2 in each sublist
(dotimes (i (length al))
   (pop (al i) 2))

al
;-> (("A" 123 2) ("B" 234 3) ("C" 345 4) ("D" 456 5))

Secondo metodo
--------------
Consideriamo che 'al' è una lista annidata e usiamo due indici per individuare l'elemento che deve essere eliminato (popped):

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
; remove at i 2 of al
(dotimes (i (length al))
  (pop al i 2))

al
;-> (("A" 123 2) ("B" 234 3) ("C" 345 4) ("D" 456 5))

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
; remove at (list i 2) of al
(dotimes (i (length al))
  (pop al (list i 2)))

al
;-> (("A" 123 2) ("B" 234 3) ("C" 345 4) ("D" 456 5))

nel secondo esempio gli indici sono in una lista, simile a quello che ritorna "ref":

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(ref "fred" al)
(0 2)

Terzo metodo
------------
Indicizziamo la sottolista come se fosse una lista associativa:

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(pop (assoc "A" al) 2) => "fred"
al
;-> (("A" 123 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5))

Quarto metodo
-------------
Usiamo "replace", "append" e "match" per evitare il ciclo:

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(replace '(*) al (append (0 2 $it) (-1 $it)) match)
al
;-> (("A" 123 2) ("B" 234 3) ("C" 345 4) ("D" 456 5))

L'espressione match cerca corrispondenze per tutte le liste di primo livello in 'al', che sono le sottoliste in $it. $it non è modificabile, quindi dobbiamo costruire la nuova sottolista aggiungendo le varie parti.

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(set 'al (map (fn (e) (append (0 2 e) (-1 e))) al))
;-> (("A" 123 2) ("B" 234 3) ("C" 345 4) ("D" 456 5))

Quinto metodo
-------------
(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(replace '(*) al (list (select $it '(0 1 3))) match)
;-> ((("A" 123 2)) (("B" 234 3)) (("C" 345 4)) (("D" 456 5)))

oppure:

(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(replace '(*) al (select $it 0 1 3) match)
;-> ((("A" 123 2)) (("B" 234 3)) (("C" 345 4)) (("D" 456 5)))

Sesto metodo
-------------
Soluzione non distruttiva
(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(map (fn(x) (replace (x 2) x)) al)
;-> ((("A" 123 2)) (("B" 234 3)) (("C" 345 4)) (("D" 456 5)))

Settimo metodo
--------------
(set 'al '( ("A" 123 "fred" 2) ("B" 234 "jim" 3) ("C" 345 "arthur" 4) ("D" 456 "dave" 5)))
(for (x 0 (dec (length al))) (pop (al x) 2) )
al
;-> ((("A" 123 2)) (("B" 234 3)) (("C" 345 4)) (("D" 456 5)))

Vediamo un altro esempio:

(setq myScheduler '(
(at
  (
   (days 1 7 14 21)         ;; Scheduler per i giorni 1, 7, 14, 21
   (times "11:00" "23:00")  ;; Alle ore 11:00 e ore 12:00
  )
)
(client-nodes
  (
   ("10.100.2.12"  3322)
   ("10.100.3.198" 1234)
  )
)
))

Usiamo (lookup) controllare i dati nella lista. Per esempio:

(lookup 'client-nodes myScheduler)
;-> (("10.100.2.12" 3322) ("10.100.3.198" 1234))

Adesso, dopo aver trovato un valore associato a una chiave (nodo), come possiamo aggiornare quel nodo?
Well, after I found a value associated to a key (node), how can I quickly update that node)?

Usiamo "setf" con "lookup" o con "assoc":

(setq lst '((a 1 2 3) (b 4 5 6) (c 7 8 9)))
;-> ((a 1 2 3) (b 4 5 6) (c 7 8 9))

(setf (assoc 'b lst) '(B 40 50 60))
;-> (B 40 50 60)
lst
;-> ((a 1 2 3) (B 40 50 60) (c 7 8 9))
(setf (lookup 'c lst 2) 80)
;-> 80
lst
;-> ((a 1 2 3) (B 40 50 60) (c 7 80 9))




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
    ;(if (= rnd 1) (println rnd))
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

Nota: più che una dimostrazione sembra di aver trovato il risultato per esclusione di tutti gli altri casi possibili (tipo Sherlock Holmes: "Quando hai escluso l'impossibile ciò che resta, per quanto improbabile, è la verità").

Per una trattazione con assiomi vedi:
https://codegolf.stackexchange.com/questions/143822/a-%c3%97-a-a-%c3%97-a

Ecco un riassunto:

Assiomi:

  1) a+(b+c)=(a+b)+c
  2) a+0=a
  3) a+(−a)=0
  4) a+b=b+a
  5) a*(b*c)=(a*b)*c
  6) a*1=a
  7) 1*a=a
  8) a*(b+c)=(a*b)+(a*c)
  9) (b+c)*a=(b*a)+(c*a)

Dimostrazione che -(-a)=a:

  -(-a) = (-(-a)) + 0          Assioma 2
        = 0 + (-(-a))          Assioma 4
        = (a + (-a)) + (-(-a)) Assioma 3
        = a + ((-a) + (-(-a))) Assioma 1
        = a + 0                Assioma 3
        = a                    Assioma 2

Lemma: a*0=0

Prova:
  a * 0 = (a * 0) + 0                        Assioma 2
        = (a * 0) + ((a * b) + (-(a * b)))   Assioma 3
        = ((a * 0) + (a * b)) + (-(a * b))   Assioma 1
        = (a * (0 + b)) + (-(a * b))         Assioma 8
        = (a * (b + 0)) + (-(a * b))         Assioma 4
        = (a * b) + (-(a * b))               Assioma 2
        = 0                                  Assioma 3

Teorema:
  (a * 0) + (b * 0) = 0

Prova:
  (a * 0) + (b * 0) = 0 + (b * 0)  Lemma
                    = (b * 0) + 0  Assioma 4
                    = b * 0        Assioma 2
                    = 0            Lemma

Alcune dimostrazioni che (-a)*(-a) = a*a.

By Etoplay:
(-a)*(-a)
    = ((-a)*(-a))+0                                            Assioma 2
    = ((-a)*(-a))+(((a*a)+(a*(-a)))+(-((a*a)+(a*(-a)))))       Assioma 3
    = (((-a)*(-a))+((a*a)+(a*(-a))))+(-((a*a)+(a*(-a))))       Assioma 1
    = (((a*a)+(a*(-a)))+((-a)*(-a)))+(-((a*a)+(a*(-a))))       Assioma 4
    = ((a*a)+((a*(-a))+((-a)*(-a))))+(-((a*a)+(a*(-a))))       Assioma 1
    = ((a*a)+((a+(-a))*(-a)))+(-((a*a)+(a*(-a))))              Assioma 9
    = ((a*a)+(0*(-a)))+(-((a*a)+(a*(-a))))                     Assioma 3
    = ((a*(a+0))+(0*(-a)))+(-((a*a)+(a*(-a))))                 Assioma 2
    = ((a*(a+(a+(-a))))+(0*(-a)))+(-((a*a)+(a*(-a))))          Assioma 3
    = (((a*a)+(a*(a+(-a))))+(0*(-a)))+(-((a*a)+(a*(-a))))      Assioma 8
    = ((a*a)+((a*(a+(-a)))+(0*(-a))))+(-((a*a)+(a*(-a))))      Assioma 1
    = (a*a)+(((a*(a+(-a)))+(0*(-a)))+(-((a*a)+(a*(-a)))))      Assioma 1
    = (a*a)+((((a*a)+(a*(-a)))+(0*(-a)))+(-((a*a)+(a*(-a)))))  Assioma 8
    = (a*a)+(((a*a)+((a*(-a))+(0*(-a))))+(-((a*a)+(a*(-a)))))  Assioma 1
    = (a*a)+(((a*a)+((a+0)*(-a)))+(-((a*a)+(a*(-a)))))         Assioma 9
    = (a*a)+(((a*a)+(a*(-a)))+(-((a*a)+(a*(-a)))))             Assioma 2
    = (a*a)+0                                                  Assioma 3
    = a*a                                                      Assioma 2

By Emil Jeřábek (Jerabek):
a*a = a*a + 0                                                 Assioma 2
    = a*a + ((a*(-a) + a*(-a)) + (-(a*(-a) + a*(-a))))        Assioma 3
    = (a*a + (a*(-a) + a*(-a))) + (-(a*(-a) + a*(-a)))        Assioma 1
    = (a*a + a*((-a) + (-a))) + (-(a*(-a) + a*(-a)))          Assioma 8
    = a*(a + ((-a) + (-a))) + (-(a*(-a) + a*(-a)))            Assioma 8
    = a*((a + (-a)) + (-a)) + (-(a*(-a) + a*(-a)))            Assioma 1
    = a*(0 + (-a)) + (-(a*(-a) + a*(-a)))                     Assioma 3
    = a*((-a) + 0) + (-(a*(-a) + a*(-a)))                     Assioma 4
    = a*(-a) + (-(a*(-a) + a*(-a)))                           Assioma 2
    = (a + 0)*(-a) + (-(a*(-a) + a*(-a)))                     Assioma 2
    = (a + (a + (-a)))*(-a) + (-(a*(-a) + a*(-a)))            Assioma 3
    = ((a + a) + (-a))*(-a) + (-(a*(-a) + a*(-a)))            Assioma 1
    = ((-a) + (a + a))*(-a) + (-(a*(-a) + a*(-a)))            Assioma 4
    = ((-a)*(-a) + (a + a)*(-a)) + (-(a*(-a) + a*(-a)))       Assioma 9
    = ((-a)*(-a) + (a*(-a) + a*(-a))) + (-(a*(-a) + a*(-a)))  Assioma 9
    = (-a)*(-a) + ((a*(-a) + a*(-a)) + (-(a*(-a) + a*(-a))))  Assioma 1
    = (-a)*(-a) + 0                                           Assioma 3
    = (-a)*(-a)                                               Assioma 2

By Anders Kaseorg:
(-a)*(-a)
    = (-a)*(-a) + 0                             Assioma 2
    = (-a)*(-a) + ((-a)*a + -((-a)*a))          Assioma 3
    = ((-a)*(-a) + (-a)*a) + -((-a)*a)          Assioma 1
    = ((-a)*(-a) + ((-a) + 0)*a) + -((-a)*a)    Assioma 2
    = ((-a)*(-a) + ((-a)*a + 0*a)) + -((-a)*a)  Assioma 9
    = (((-a)*(-a) + (-a)*a) + 0*a) + -((-a)*a)  Assioma 1
    = ((-a)*((-a) + a) + 0*a) + -((-a)*a)       Assioma 8
    = ((-a)*(a + (-a)) + 0*a) + -((-a)*a)       Assioma 4
    = ((-a)*0 + 0*a) + -((-a)*a)                Assioma 3
    = (0*a + (-a)*0) + -((-a)*a)                Assioma 4
    = ((a + (-a))*a + (-a)*0) + -((-a)*a)       Assioma 3
    = ((a*a + (-a)*a) + (-a)*0) + -((-a)*a)     Assioma 9
    = (a*a + ((-a)*a + (-a)*0)) + -((-a)*a)     Assioma 1
    = (a*a + (-a)*(a + 0)) + -((-a)*a)          Assioma 8
    = (a*a + (-a)*a) + -((-a)*a)                Assioma 2
    = a*a + ((-a)*a + -((-a)*a))                Assioma 1
    = a*a + 0                                   Assioma 3
    = a*a                                       Assioma 2


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

Da "Code Snippets": http://www.newlisp.org/index.cgi?page=Code_Snippets

URL encode and decode
; Character strings in URLs and POST data when
; using HTTP methods must not use certain unsafe
; characters. These routines encode and decode
; to save URL format.
;
; (url-encode "this is a test?")
;   => "this%20is%20a%20test%3F"
; (url-decode "this%20is%20a%20test%3F")
;   => "this is a test?"
;
; (url-encode "所有的愛是公平的")
; =>  "%e6%89%80%e6%9c%89%e7%9a%84%e6%84%9b%e6%98%af%e5%85%ac%e5%b9%b3%e7%9a%84"
; (url-decode (url-encode ""所有的愛是公平的")) => "所有的愛是公平的"

; simple encoder
(define (url-encode str)
  (replace {([^a-zA-Z0-9])} str (format "%%%2X" (char $1)) 0))

; UTF-8 encoder, encodes everything into %xx form
(define (url-encode str) ; for UTF-8 strings
  (join (map (fn (c) (format "%%%02x" c)) (unpack (dup "b" (length str)) str))))

; universal decoder, works for ASCII and UTF-8
  (define (url-decode url (opt nil))
    (if opt (replace "+" url " "))
    (replace "%([0-9a-f][0-9a-f])" url (pack "b" (int $1 0 16)) 1))


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
L'algoritmo descritto in "Topological sorting of large networks" di Kahn (1962), sceglie i vertici rispettando l'ordinamento topologico.
Inizialmente, costruisce un insieme di vertici che non hanno archi entranti (grado entrante=0). Dato che il grafo è aciclico esiste almeno uno di questi nodi. Poi:

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

L'implementazione seguente usa l'algoritmo Breadth-First-Search per visitare il grafo.
Il grafo viene rappresentato con una matrice di adiacenza binaria A, con V righe e V colonne. L'elemento A(i,j) vale 1 se c'è un arco dal vertice "i" al vertice "j", altrimenti A(i,j) vale 0.

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


----------------------------------------------------
Creazione dinamica di variabili e funtori di default
----------------------------------------------------

Qualche volta abbiamo bisogno di creare un simbolo/variabile il cui nome viene conosciuto soltanto durante il run-time. La seguente funzione crea un simbolo/variabile associato ad un determinato valore

(define (create-var name value) (set (sym name) value))

Possiamo passare il nome della variabile da creare come simbolo quotato o come stringa:

Crea la variabile "a" con valore 4:

(create-var 'a 4)
;-> 4
a
;-> 4

Crea la variabile "b" con valore (1 2 3):

(create-var "b" '(1 2 3))
;-> (1 2 3)
b
;-> (1 2 3)

La funzione sovrascrive i simboli che hanno lo stesso nome (cioè quelli che sono già esistenti):

(create-var "b" "new")
;-> "new"
b
;-> "new"

Sopponiamo di avere la seguente lista i cui elementi sono coppie del tipo (nome valore):

(setq info '(("tipo" "a") ("data" "2022-09-02") ("price" 120)))

Scriviamo una funzione che prende questa lista e crea le variabili con nome "nome" e associa il relativo valore "valore":

(define (test lst)
  (dolist (el lst)
    (create-var (el 0) (el 1))
  ))

(test info)
;-> 120

Adesso stampiamo i valori delle variabili appena create:

(println tipo { } data { } price)
;-> a 2022-09-02 120

Altro esempio:

(setq info '((tipo "b") (data "2000-09-02") (price 111)))
(test info)
;-> 111
(println tipo { } data { } price)
;-> b 2000-09-02 111

Altro esempio:

(test '((x 3) (y "ab") (z '(1 2))))
;-> '(1 2)
(println x { } y { } z)
;-> 3 ab '(1 2)

Nota: possiamo associare un simbolo/variabile come funtore di default di un contesto.
In questo modo il simbolo/variabile creato può essere passato alle funzioni per riferimento. Questo è utile quando il valore associato al simnolo/variabile occupa molta memoria e non vogliamo che venga fatta una sua copia ogni volta che viene passato come parametro ad una funzione.

La seguente funzione crea un simbolo/variabile come funtore di default di un contesto:

(define (create-var-ctx name value)
  (set (sym name name) value))

Creazione della variabile foo:foo = (1 2):

(create-var-ctx 'foo '(1 2))
;-> '(1 2)

In questo caso la variabile foo:foo è il funtore di default del contesto foo:

foo:foo
;-> '(1 2)
(println foo:foo)
;-> '(1 2)

Nota: non può esistere nessun simbolo con nome uguale ad un contesto,

(setq foo 1)
;-> ERR: symbol is protected in function setf : foo
(setq foo:foo "sono il funtore")
;-> "sono il funtore"
foo:foo
;-> "sono il funtore"

Se esiste un simbolo con lo stesso nome del contesto che vogliamo creare otteniamo un errore:

(setq tipo:tipo "errore")
;-> ERR: context expected in function setf : tipo
Infatti il simbolo/variabile "tipo" è già esistente.

Ma simboli esistenti non generano errore con la funzione "create-var":

(create-var-ctx 'tipo "ok")
tipo:tipo
;-> "ok"

La seguente espressione non genera errori perchè il simbolo/variabile "nuovo" non esiste:

(setq nuovo:nuovo "corretto")
;(create-var-ctx 'nuovo "corretto")
nuovo:nuovo
;-> "corretto"

Vedi anche "Creazione dinamica di variabili" nel file "Note libere 5".


----------------
Formula shoelace
----------------

Dati (n + 1) vertici x[0], y[0] .. x[N], y[N] di un poligono semplice descritto in senso orario, l'area del poligono può essere calcolata con la formula "shoelace" (laccio per scarpe):

  Area = abs((somma(x[0]*y[1] + ... x[n-1]*y[n]) + x[N]*y[0]) -
             (somma(x[1]*y[0] + ... x[n]*y[n-1]) + x[0]*y[N])) / 2

Nota: un poligono semplice è un poligono i cui lati non si intersecano.

La formula prende il nome dal fatto che il risultato si ottiene moltiplicando in croce le coordinate corrispondenti seguendo uno schema simile a quello dei lacci delle scarpe.

Prototipo nella REPL:

(setq punti '((3 4) (5 11) (12 8) (9 5) (5 6)))
;-> ((3 4) (5 11) (12 8) (9 5) (5 6))
(setq px (map first punti))
;-> (3 5 12 9 5)
(setq py (map last punti))
;-> (4 11 8 5 6)
(setq sum 0)
;-> 0
(for (i 0 (- (length punti) 1))
  (setq sum (add sum (sub (mul (px (- i 1)) (py i))
                          (mul (px i) (py (- i 1))))))
)
;-> -60
(div (abs sum) 2)
;-> 30

Adesso scriviamo una funzione per calcolare l'area con questa formula.

(define (shoelace polygon)
  (local (px py sum)
    (setq px (map first polygon))
    (setq py (map last polygon))
    (setq sum 0)
    (for (i 0 (- (length punti) 1))
      (setq sum (add sum (sub (mul (px (- i 1)) (py i))
                              (mul (px i) (py (- i 1))))))
    )
    (div (abs sum) 2)))

Facciamo un paio di prove:

(setq poligono '((3 4) (5 11) (12 8) (9 5) (5 6)))
(shoelace poligono)
;-> 30

(setq poly '((2 2) (4 4) (2 6) (7 6) (7 2)))
(shoelace poly)
;-> 16

Nota: l'applicazione della formula "shoelace" comporta una perdita di precisione se x,y hanno grandi offset.
Prima di applicare la formula rimuovere questi offset. Per esempio,
x = x - media(x)
y = y - media(y)
oppure
x = x - x[0]
y = y - y[0]


---------------------------
Numeri casuali e intervalli
---------------------------

Dati N numeri casuali tra 0.0 e 1.0 e definito il numero M di intervalli di lunghezza L tra 0.0 e 1.0, determinare quanti numeri casuali esistono in ogni intervallo.
Per esempio, data la seguente lista di numeri casuali:

(setq lst (random 0 1 100))

Prendendo un intervallo di lunghezza len-inter = 0.1 otteniamo il numero di intervalli num-inter:

(setq len-inter 0.1)
;-> 0.1
(setq num-inter (div 1.0 len-inter))
;-> 10

Dal punto di vista grafico abbiamo la seguente situazione:

  0   0.1  0.2  0.3  0.4  0.5  0.6  0.7  0.8  0.9  1.0
  |----|----|----|----|----|----|----|----|----|----|

Adesso dobbiamo inserire ogni numero casuale della lista nell'intervallo corrispondente (cioè, calcolare quanti numeri casuali cadono in ogni intervallo).

L'indice dell'intervallo è dato dalla seguente formula:

  idx = floor(rnd-number/num-inter)

Comunque dobbiamo tener conto del caso in cui "rnd-number" vale 1.0, infatti questo genera un indice uguale a "len-inter" che genera un errore di "Index out of bound".

Un altro fattore di cui tener conto è quando la lunghezza dell'intervallo non divide esattamente l'intervallo (0.0, 1.0) in parti uguali.

Scriviamo la funzione che calcola la lista delle frequenze di una lista di numeri casuali "lst-rnd" in intervalli di determinata lunghezza "len-inter".

(define (freqs lst-rnd len-inter all)
  (local (num-inter f idx)
    ; calcolo del numero di intervalli
    (setq num-inter (int (floor (div 1 len-inter))))
    (setq f (array (+ num-inter 1) '(0)))
    (dolist (el lst-rnd)
      ; calcolo dell'indice dell'intervallo
      ; in cui ricade il numero casuale corrente
      (setq idx (int (floor (div el len-inter))))
      ; aggiornamento del vettore delle frequenze
      (++ (f idx))
    )
    ; se "all" vale true, cioè siamo nel caso
    ; in cui l'ultimo intervallo è diverso
    ; e vogliamo tutti gli intervalli
    ; quindi restituiamo la lista delle frequenze
    (if all (array-list f)
        ; altrimenti gli intervalli sono uguali (non è mai vero!).
        ; e aggiunge il valore dell'ultimo intervallo
        ; al valore del penultimo intervallo
        ; per tenere conto del caso in cui il numero casuale vale 1.0
        ; in qual caso l'indice idx vale num-inter, ma dovrebbe
        ; valere (num-inter - 1).
        (begin
          (++ (f -2) (f -1))
          ; restituisce una lista con le frequenze dei numeri casuali
          (array-list (slice f 0 num-inter))
        )
    )))

Facciamo alcune prove:

(silent (setq lst (random 0 1 1e6)))

Vediamo alcuni esempi in cui la lunghezza dell'intervallo divide esattamente l'intervallo (0.0, 1.0) in parti uguali:

(freqs lst 0.1)
;-> (100061 99913 100260 100263 100236 99852 100224 99848 99972 99371)
(freqs lst 0.1 true)
;-> (100061 99913 100260 100263 100236 99852 100224 99848 99972 99339 32)
(freqs lst 0.2)
;-> (199974 200523 200088 200072 199343)
(freqs lst 0.2 true)
;-> (199974 200523 200088 200072 199311 32)
(freqs lst 0.25)
;-> (250099 250634 250071 249196)
(freqs lst 0.25 true)
;-> (250099 250634 250071 249164 32)
(freqs lst 0.5)
;-> (500733 499267)
(freqs lst 0.5 true)
;-> (500733 499235 32)
(freqs lst 0.333333333)
;-> (333416 333954 332630)
(freqs lst 0.333333333 true)
;-> (333416 333954 332598 32)

Quando "all" vale nil, allora i 32 numeri casuali che valgono 1.0 vengono aggiunti all'intervallo precedente.

Vediamo alcuni casi in cui la lunghezza dell'intervallo non divide esattamente l'intervallo (0.0, 1.0) in parti uguali:

(freqs lst 0.4)
;-> (400497 599503)
(freqs lst 0.4 true)
;-> (400497 400160 199343)
(freqs lst 0.35)
;-> (350048 649952)
(freqs lst 0.35 true)
;-> (350048 350761 299191)

Se la lista di numeri casuali non contiene il valore 1.0, allora abbiamo i seguenti risultati:

(silent (setq lst1 (random 0 .999999 1e6)))

(freqs lst1 0.1)
;-> (100271 100053 99725 99822 99998 100285 99918 99934 99838 100156)
(freqs lst1 0.1 true)
;-> (100271 100053 99725 99822 99998 100285 99918 99934 99838 100156 0)
(freqs lst1 0.2)
;-> (200324 199547 200283 199852 199994)
(freqs lst1 0.2 true)
;-> (200324 199547 200283 199852 199994 0)
(freqs lst1 0.25)
;-> (250197 249672 250183 249948)
(freqs lst1 0.25 true)
;-> (250197 249672 250183 249948 0)
(freqs lst1 0.5)
;-> (499869 500131)
(freqs lst1 0.5 true)
;-> (499869 500131 0)
(freqs lst1 0.333333333)
;-> (333196 333712 333092)
(freqs lst1 0.333333333 true)
;-> (333196 333712 333092 0)

Comunque il parametro "all" è ancora utile per i casi in cui l'ultimo intervallo ha lunghezza diversa:

(freqs lst1 0.4)
;-> (399871 600129)
(freqs lst1 0.4 true)
;-> (399871 400135 199994)
(freqs lst1 0.35)
;-> (349713 650287)
(freqs lst1 0.35 true)
;-> (349713 350359 299928)


--------------------------------
Distribuzione casuale modificata
--------------------------------

Dato un generatore uniforme di numeri casuali creare un generatore di numeri casuali che ha una distribuzione determinata da una funzione predefinita.

Occorre utilizzare un generatore uniforme di numeri casuali che genera numeri nell'intervallo 0.0 .. 1.0 (es. rgen) e un modificatore di funzione(x) che prende un numero nello stesso intervallo e genera la probabilità che l'input venga generato, nello stesso intervallo 0..1.
Quindi implementare il seguente algoritmo per generare numeri casuali con probabilità data da una funzione modificatrice:

  while True:
      random1 = rgen()
      random2 = rgen()
      if random2 < modifier(random1):
          answer = random1
          break
      endif
  endwhile

Per generare una distribuzione di probabilità a forma di "V" per i numeri casuali usiamo la seguente funzione modificatrice:

  funzione(x) = 2*(0.5 - x) per x < 0.5
                2*(x - 0.5) per x >= 0.5

Adesso scriviamo un generatore di numeri casuali con distribuzione di probabilità data dalla funzione precedente.

Prima scriviamo la funzione modificatrice:

(define (modif x)
  (if (< x 0.5)
      (mul (sub 0.5 x) 2)
      (mul (sub x 0.5) 2)))

Adesso scriviamo la funzione che implementa l'algoritmo proposto:

(define (random-modif)
(catch
  (local (rnd1 rnd2)
    (while true
      (setq rnd1 (random))
      (setq rnd2 (random))
      (if (< rnd2 (modif rnd1))
          (throw rnd1)
      )))))

(random-modif)
;-> 0.8087405011139256
(random-modif)
;-> 0.7466048158207953
(random-modif)
;-> 0.858943449201941
(random-modif)
;-> 0.01498458815271462
(random-modif)
;-> 0.3644520401623585
(random-modif)
;-> 0.00466933194982757

Ci serve una funzione per stampare l'istogramma di una lista:

(define (istogramma lst hmax (calc nil))
  (local (unici linee hm scala f-lst)
    (if calc
      ;calcolo la lista delle frequenze partendo da lst
      (begin
        ;trovo quanti numeri diversi ci sono nella lista
        (setq unici (length (unique lst)))
        ;creo la lista delle frequenze
        (setq f-lst (array unici '(0)))
        ; calcolo dei valori delle frequenze
        (dolist (el lst)
          (++ (f-lst (- el 1)))
        )
      )
      ;else
      ;lst è la lista delle frequenze
      (begin (setq f-lst lst))
    )
    (setq hm (apply max f-lst))
    (setq scala (div hm hmax))
    (setq linee (map (fn (x) (round (div x scala))) f-lst))
    (dolist (el linee)
      ;(println (format "%3d %s %0.2f" (add $idx 1) (dup "*" el) (f-lst $idx)))
      (println (format "%3d %s %4d" $idx (dup "*" el) (f-lst $idx)))
    )
  );local
)

Infine scriviamo la funzione per verificare la forma della distribuzione:

(define (test num-rnds num-bins)
  (local (out bin bin-size idx)
    (setq out '())
    (setq bin (array (+ num-bins 1) '(0)))
    (setq bin-size (div 1.0 num-bins))
    ; calcolo dei numeri random modificati
    (for (i 1 num-rnds)
      (push (random-modif) out -1)
    )
    ; creazione lista delle frequenza (num-bins elementi)
    (dolist (r out)
      ; calcolo indice del bin per il numero random corrente
      (setq idx (int (floor (div r bin-size))))
      (++ (bin idx))
    )
    ; disegna istogramma
    (istogramma (slice (array-list bin) 0 num-bins) 70)
    'end))

Proviamo la funzione:

(test 10000 50)
  0 **********************************************************************  386
  1 *********************************************************************  378
  2 ***************************************************************  350
  3 ******************************************************************  362
  4 ************************************************************  331
  5 ***********************************************************  323
  6 *****************************************************  294
  7 ************************************************  262
  8 ***************************************************  280
  9 ***********************************************  257
 10 ********************************************  242
 11 *****************************************  228
 12 **********************************  187
 13 **********************************  186
 14 *****************************  161
 15 ************************  134
 16 **********************  122
 17 ******************   99
 18 ***************   84
 19 ******************  102
 20 ****************   89
 21 **********   53
 22 *********   48
 23 *****   27
 24 *    7
 25 *    6
 26 ****   23
 27 *******   37
 28 *********   50
 29 ************   68
 30 ****************   88
 31 **********************  119
 32 *************************  136
 33 *************************  138
 34 **************************  145
 35 ****************************  157
 36 ************************************  198
 37 *************************************  202
 38 *******************************************  235
 39 ********************************************  240
 40 ********************************************  244
 41 ********************************************  240
 42 ********************************************************  308
 43 **************************************************  278
 44 **********************************************************  321
 45 ****************************************************************  354
 46 **************************************************************  344
 47 *************************************************************  334
 48 ********************************************************************  375
 49 *******************************************************************  367
end


------------------------
Short-circuit evaluation
------------------------

Alcuni linguaggi valutano tutte le espressioni booleane completamente, mentre altri linguaggi valutano completamente soltanto alcune espressioni booleane (short-circuit evaluation).
Cosa significa?

Supponiamo di voler calcolare le espressioni (f1 and f2) e (f1 or f2), dove f1 e f2 sono due funzioni che restituiscono un valore booleano (true o false).

1) Linguaggi a valutazione completa
Espressione: (f1 and f2)
Valuta f1, poi valuta f2 e poi applica l'operatore "and" e restituisce il risultato.
Espressione: (f1 or f2)
Valuta f1, poi valuta f2 e poi applica l'operatore "or" e restituisce il risultato.

2) Linguaggi a valutazione short-circuit
Espressione: (f1 and f2)
Valuta f1, se f1 è nil, allora restituisce nil. ALtrimenti valuta f2 e poi applica l'operatore "and" e restituisce il risultato.
Espressione: (f1 or f2)
Valuta f1, se f1 è true, allora restituisce true. ALtrimenti valuta f2 e poi applica l'operatore "or" e restituisce il risultato.

In altre parole, i linguaggi a valutazione short-circuit sfruttano il fatto che l'operatore "and" restituisce sempre nil sei il primo parametro è nil, mentre l'operatore "or" restituisce sempre true sei il primo parametro è true.

Per vedere come funziona newLISP scriviamo due funzioni booleane che stampano il lore nome quando vengono eseguite/valutate:

La funzione f1 restituisce true se il valore passsato è maggiore di 0:

(define (f1 x) (println "f1") (> x 0))

La funzione f2 restituisce true se il valore passsato è minore di 10:
(define (f2 x) (println "f2") (< x 10))

Adesso scriviamo le funzioni per testare gli operatori "and" e "or":

(define (test-and x) (and (f1 x) (f2 x)))
(define (test-or x) (or (f1 x) (f2 x)))

Vediamo come si comporta newLISP:

(test-and 3)
;-> f1
;-> f2
;-> true
(test-and -3)
;-> f1
;-> nil

(test-or 3)
;-> f1
;-> true
(test-or -3)
;-> f1
;-> f2
;-> true

Quindi newLISP è un linguaggio con valutazione short-circuit.

Nota: questo può servire per velocizzare i programmi facendo eseguire prima le funzioni più veloci (nel caso di valutazioni booleane).


------------------------------------------------------
Algoritmo di Bellman-Ford (bellman-ford and dijskstra)
------------------------------------------------------

L'algoritmo di Bellman-Ford ci permette di trovare il percorso più breve da un vertice a tutti gli altri vertici di un grafo diretto pesato. È simile all'algoritmo di Dijkstra, ma funziona anche con grafi in cui gli archi hanno pesi negativi. I pesi negativi si trovano in varie applicazioni dei grafi. Ad esempio, invece di pagare un costo per un percorso, potremmo ottenere qualche vantaggio se seguiamo il percorso.
Bellman-Ford funziona meglio di Dijkstra per i sistemi distribuiti. A differenza di Dijkstra dove dobbiamo trovare il valore minimo di tutti i vertici, in Bellman-Ford, i vertici sono considerati uno per uno.
Bellman-Ford non funziona con un grafo non orientato con archi negativi poiché verrà dichiarato come ciclo negativo.

L'algoritmo di Bellman-Ford procede per "rilassamento degli archi" (come quello di Dijkstra), in cui le approssimazioni della distanza minima vengono sostituite da quelle migliori fino a raggiungere la soluzione. In entrambi gli algoritmi, la distanza approssima da ciascun vertice è sempre una sovrastima della distanza reale ed è sostituita dal minimo del suo vecchio valore e dalla lunghezza di un nuovo percorso trovato. Tuttavia, l'algoritmo di Dijkstra utilizza una coda di priorità per selezionare in modo greedy il vertice più vicino che non è stato ancora elaborato ed esegue questo processo di rilassamento su tutti i suoi archi in uscita. Al contrario, l'algoritmo Bellman-Ford rilassa semplicemente tutti gli archi e fa questo (v - 1) volte, dove "v" è il numero di vertici nel grafo. In ciascuna di queste ripetizioni cresce il numero di vertici con distanze calcolate correttamente, da cui ne consegue che alla fine tutti i vertici avranno le distanze corrette (minime). Questo metodo consente di applicare l'algoritmo Bellman-Ford a una classe di grafi più ampia rispetto a Dijkstra. Entrambi gli algoritmi producono gli stessi risultati.

La complessità temporale di questo algoritmo vale O(V*E), dove V = numero dei vertici e E = numero degli archi (Edge).

Nell'algoritmo di Bellman-Ford il modo più conveniente di rappresentare il grafo è quello di utilizzare una lista che contiene tanti elementi quanti sono i suoi vertici. L'elemento i-esimo della lista rappresenta l'arco i-esimo del grafo e contiene la seguente terna di valori:

  1) nodo sorgente
  2) nodo destinazione
  2) peso dell'arco

Quindi un vertice ha la seguente struttura:

  (nodo-sorgente nodo-destinazione peso-arco)

Per esempio il grafo seguente:

  +---+  5   +---+  3   +---+
  | 0 |----->| 1 |----->| 3 |
  +---+      +---+      +---+
    |          ^          |
    |          | 6        |
    |          |          |
    | 4      +---+      2 |
    +------->| 2 |<-------+
             +---+
  +-------------+---------------+-------------------+------+
  | Numero Arco | Nodo sorgente | Nodo destinazione | Peso |
  +-------------+---------------+-------------------+------+
  |  0          |  0            |  1                |  5   |
  |  1          |  0            |  2                |  4   |
  |  2          |  1            |  3                |  3   |
  |  3          |  2            |  1                |  6   |
  |  4          |  3            |  2                |  2   |
  +-------------+---------------+-------------------+------+

Viene rappresentato con la lista:

  ((0 1 5) (0 2 4) (1 3 3) (2 1 6) (3 2 2)))

Valore massimo per il peso di un vertice: MAX-VAL = 9999999

Scriviamo la funzione:

(define (bellman-ford graph start)
  (local (dist edge u v w MAX-VAL)
    (setq MAX-VAL 9999999)
    (setq archi (length graph))
    (setq vertici (length (unique (flat (map (fn(x) (list (x 0) (x 1))) graph)))))
    (setq edge (array archi '((0 0 0))))
    (setq dist (array vertici (list MAX-VAL)))
    ; Passo 1: vertice di partenza
    (setf (dist start) 0)
    ; Passo 2: rilassamento archi
    (for (i 1 (- vertici 1))
      (for (j 0 (- archi 1))
        (setq u ((graph j) 0))
        (setq v ((graph j) 1))
        (setq w ((graph j) 2))
        (if (and (!= (dist u) MAX-VAL)
                (< (add (dist u) w) (dist v)))
            (setf (dist v) (add (dist u) w))
        )
      )
    )
    ; Passo 3: ricerca cicli negativi
    ; se il valore cambia, abbiamo un ciclo negativo nel grafo
    ; e non riusciamo a trovare le distanze più brevi
    (for (j 0 (- archi 1))
      (setq u ((graph j) 0))
      (setq v ((graph j) 1))
      (setq w ((graph j) 2))
      (if (and (!= (dist u) MAX-VAL)
               (< (add (dist u) w) (dist v)))
          (setq negative true)
      )
    )
    (if negative
        (println "ciclo negativo")
        ;else stampa la soluzione
        (for (i 0 (- vertici 1)) (println i { - } (dist i)))
    )))

Proviamo con il grafo dell'esempio:

(setq grafo '((0 1 5) (0 2 4) (1 3 3) (2 1 6) (3 2 2)))
(bellman-ford grafo 0)
;-> 0 - 0
;-> 1 - 5
;-> 2 - 4
;-> 3 - 8

Proviamo con un altro grafo:

  +---+   -1  +---+  2   +---+
  | 0 |------>| 1 |----->| 4 |
  +---+       +---+      +---+
    |        /   ^ \         |
    |     3 /    |  \ 2      |
  4 |      /   1 |   \       | -3
    |     .      |    .      |
    |    +---+   +----+      |
    +--->| 2 |<--| 3  |<-----+
         +---+   +----+

(setq grafo1 '((0 1 -1) (0 2 4) (1 2 3) (1 3 2) (1 4 2) (3 2 5) (3 1 1) (4 3 -3)))
(bellman-ford grafo1 0)
;-> 0 - 0
;-> 1 - -1
;-> 2 - 2
;-> 3 - -2
;-> 4 - 1

La soluzione consiste in tante coppie di valori quanti sono i vertici del grafo:

  (indice vertice, distanza minima dal vertice di partenza)

Bene, ma in genere vogliamo conoscere non solo il valore, ma anche il percorso di ogni distanza minima. Per fare questo utilizziamo un vettore di predecessori "pred" che memorizza il vertice precedente quando troviamo una distanza minore durante il rilassamento degli archi:

        (if (and (!= (dist u) MAX-VAL)
                (< (add (dist u) w) (dist v)))
          (begin
            (setf (dist v) (add (dist u) w))
            (setf (pred v) u)
          )
        )

Al termine possiamo creare il percorso dalla sorgente ad ogni destinazione seguendo il vettore "pred" al contrario con il seguente algoritmo (eseguito per ogni vertice-destinazione):

  percorso = ()
  vertice-corrente = vertice-destinazione
  while vertice-corrente != nil:
     push vertice-corrente percorso
     vertice-corrente = pred(vertice-current)

La funzione restituisce una lista i cui elementi hanno la seguente struttura:

  (nodo-sorgente nodo-destinazione (vertici-percorso) distanza-percorso)

Funzione "bellman-ford":

(define (bellman-ford graph start)
  (local (MAX-VAL archi vertici edge dist pred u v w)
    (setq MAX-VAL 9999999)
    (setq archi (length graph))
    (setq vertici (length (unique (flat (map (fn(x) (list (x 0) (x 1))) graph)))))
    ;(println "archi: " archi)
    ;(println "vertici: " vertici)
    (setq edge (array archi '((0 0 0))))
    (setq dist (array vertici (list MAX-VAL)))
    (setq path '())
    (setq pred (array vertici '(nil)))
    ; Passo 1: distanza dal vertice di partenza (zero)
    (setf (dist start) 0)
    ; Passo 2: rilassamento archi
    (for (i 1 (- vertici 1))
      (for (j 0 (- archi 1))
        (setq u ((graph j) 0))
        (setq v ((graph j) 1))
        (setq w ((graph j) 2))
        (if (and (!= (dist u) MAX-VAL)
                 (< (add (dist u) w) (dist v)))
          (begin
            (setf (dist v) (add (dist u) w))
            (setf (pred v) u)
          )
        )
      )
    )
    ; Passo 3: ricerca cicli negativi
    ; se il valore cambia, abbiamo un ciclo negativo nel grafo
    ; e non riusciamo a trovare le distanze più brevi
    (for (j 0 (- archi 1))
      (setq u ((graph j) 0))
      (setq v ((graph j) 1))
      (setq w ((graph j) 2))
      (if (and (!= (dist u) MAX-VAL)
               (< (add (dist u) w) (dist v)))
          (setq negative true)
      )
    )
    (if negative
        ; se esiste un ciclo negativo, allora restituisce nil
        nil
        ; altrimenti restituisce la soluzione
        (make-solution)
    )
))

Funzione che crea la lista della soluzione:

(define (make-solution)
  (let (out '())
    (for (i 0 (- vertici 1))
      (cond ((= start i)
             (push (list start i (list i) 0) out -1)
            )
            (true
             (push (list start i (build-path pred i) (dist i)) out -1)
            )
      )
    )
    out))

Funzione che ricostruisce il percorso minimo da "start" a "dest":

(define (build-path pred dest)
  (local (path curr))
  (setq path '())
  (setq curr dest)
  (while (!= curr nil)
    (push curr path)
    (setq curr (pred curr))
  )
  path)

Facciamo alcune prove:

(bellman-ford grafo 0)
;-> ((0 0 (0) 0) (0 1 (0 1) 5) (0 2 (0 2) 4) (0 3 (0 1 3) 8))

(bellman-ford grafo 3)
;-> ((3 0 (0) 9999999) (3 1 (3 2 1) 8) (3 2 (3 2) 2) (3 3 (3) 0))

(bellman-ford grafo1 0)
;-> ((0 0 (0) 0) (0 1 (0 1) -1) (0 2 (0 1 2) 2) (0 3 (0 1 4 3) -2) (0 4 (0 1 4) 1))

(bellman-ford grafo1 3)
;-> ((3 0 (0) 9999999) (3 1 (3 1) 1) (3 2 (3 1 2) 4) (3 3 (3) 0) (3 4 (3 1 4) 3))

(bellman-ford grafo1 1)
;-> ((1 0 (0) 9999999) (1 1 (1) 0) (1 2 (1 2) 3) (1 3 (1 4 3) -1) (1 4 (1 4) 2))

Per finire vediamo il codice degli algoritmi Bellman-Ford e Dijkstra a confronto:

-------------------------------------------------------
function bellman-ford(G, S)
  for each vertex V in G
    distance[V] <- infinite
    previous[V] <- nil

  distance[S] <- 0

  for each vertex V ln G
    for each edge (U,V) in G
      tempDistance <- distance[U] + edge_weight(U, V)
      if tempDistance < distance[V]
          distance[V] <- tempDistance
          previous[V] <- U

  for each edge (U,V) in G
    if distance[U] + edge_weight(U, V) < distance[V]
        Error: Negative Cycle Exists

  return distance[], previous[]
-------------------------------------------------------

-------------------------------------------------------
function dijkstra(G, S)
  for each vertex V in G
    distance[V] <- infinite
    previous[V] <- nil
    If V != S, add V to Priority Queue Q

    distance[S] <- 0

    while Q is not empty
      U <- Extract min from Q
      for each unvisited neighbour V of U
        tempDistance <- distance[U] + edge_weight(U, V)
        if tempDistance < distance[V]
            distance[V] <- tempDistance
            previous[V] <- U

    return distance[], previous[]
-------------------------------------------------------


-----------------------
Fattoriale quasi esatto
-----------------------

Fattoriale di un numero intero (output: big-integer):

(define (fact-i num)
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(fact-i 100)
;-> 9332621544394415268169923885626670049071596826438162146859
;-> 2963895217599993229915608941463976156518286253697920827223
;-> 758251185210916864000000000000000000000000L

Fattoriale di un numero intero (output: big-integer):

(define (fact2-i num) (if (= num 0) 1 (apply * (map bigint (sequence 1 num)))))

(fact2-i 100)
;-> 9332621544394415268169923885626670049071596826438162146859
;-> 2963895217599993229915608941463976156518286253697920827223
;-> 758251185210916864000000000000000000000000L

La funzione Gamma (di Eulero) è una funzione continua sui numeri reali positivi, che estende il concetto di fattoriale ai numeri complessi, nel senso che per ogni numero intero non negativo n si ha:

  Gamma(n+1) = n!

Utilizziamo la funzione integrata "gammaln" per calcolare il fattoriale di un numero n.

Fattoriale di un numero intero (output: float):

(define (fact-f num)
  (exp (gammaln (++ num))))

Il risultato è "vicino" al valore vero del fattoriale:

(fact-f 4)
;-> 23.99999999999999
(fact-f 8)
;-> 40320.00000000948

(fact-i 4)
;-> 24L
(fact-i 8)
;-> 40320L

(fact-f 100)
;-> 9.332621545372994e+157


-------------------------------------------------
Algoritmo "Fast inverse square root" e 0x5f3759df
-------------------------------------------------

Ricercando sul web le parole "Fast inverse square root" e "0x5f3759df" troviamo un algoritmo in C per il calcolo dell'inverso della radice quadrata di un numero = 1/sqrt(x).
Questo algoritmo è diventato famoso dopo che la id Software ha reso open source il motore del gioco Quake III.
Questo codice fornisce un'ottima approssimazione di questa funzione, abbastanza buona per essere utilizzata nei videogiochi degli anni 90 (anche oggi (2022), con le moderne CPU, è ancora un po' più veloce del calcolo diretto della radice quadrata inversa). Il fatto più sorprendente di questo codice è l'apparizione di una costante magica 0x5f3759df (notare che questo è codice C, inclusi i commenti originali)

float Q_rsqrt( float number )
{
    long i;
    float x2, y;
    const float threehalfs = 1.5F;

    x2 = number * 0.5F;
    y  = number;
    i  = * ( long * ) &y;                       // evil floating point bit level hacking
    i  = 0x5f3759df - ( i >> 1 );               // what the f*ck?
    y  = * ( float * ) &i;
    y  = y * ( threehalfs - ( x2 * y * y ) );   // 1st iteration
//  y  = y * ( threehalfs - ( x2 * y * y ) );   // 2nd iteration, this can be removed

    return y;
}

oppure

float InvSqrt (float x)
{
    float xhalf = 0.5f*x;
    int i = *(int*)&x;
    i = 0x5f3759df - (i>>1);
    x = *(float*)&i;
    x = x*(1.5f - xhalf*x*x);
    return x;
}

Il codice è stato attribuito a John Carmack, ma la costante era stata già usata da Cleve Moler e Gregory Walsh che avevano preso l'idea da un articolo non pubblicato di William Kahan K.C. Ng alla fine degli anni '80.

Potete trovare un'ottima spiegazione del codice (che è abbastanza complicato) su youtube al seguente indirizzo:

https://www.youtube.com/watch?v=p8u_k2LIZyo (Fast Inverse Square Root — A Quake III Algorithm).

Nota: i compilatori C attuali utilizzano una funzione per il calcolo diretto di 1/sqrt(x) che è ancora più lenta della funzione presentata sopra. Comunque è possibile specificare un parametro durante la compilazione che permette di usare l'istruzione SSE "rsqrtss" che è più veloce della funzione (SSE "rsqrtss" with compiler switch optimization).
E se abbiamo molti numeri per cui dobbiamo calcolare la radice quadrata, allora l'istruzione SIMD "rsqrtps"  sarà ancora più veloce.


---------------------------------
Composizione multipla di funzioni
---------------------------------

La composizione delle funzioni è una delle operazioni matematiche di base. Cerchiamo di definire la composizione di funzioni e macro (in newLISP macros=fexprs).

Tale composizione dovrebbe soddisfare la seguente espression:

     ((composizione 'f1 ... 'fn) _ _ _) = (f1 (f2 ... (fn _ _ _)))

per tutte le funzioni e le macro.

Il primo tentativo per una funzione "compose" è il seguente:

(define (compose f g) (expand (lambda (x) (f (g x))) 'f 'g))

Nota: in questo caso le funzioni "f" e "g" accettano un solo parametro.

Proviamo la funzione con alcuni esempi:

Esempio 1:

(define sincos (compose 'sin 'cos))
;-> (lambda (x) (sin (cos x)))
(sincos 2)
;-> -0.4042391538522658
(sin (cos 2))
;-> -0.4042391538522658

Esempio 2:

(define (f1 x) (+ x 1))
(define (f2 x) (+ x 2))

(define f1f2 (compose f1 f2))
;-> (lambda (x) ((lambda (x) (+ x 4)) ((lambda (x) (- x 5)) x)))
(f1f2 0)
;-> 3

Adesso proviamo la funzione "compose" con due espressioni particolari:

1) la funzione identità FI:

(setq FI (lambda (x) x))

2) la macro identità MI:

(setq MI (lambda-macro (x) x))

(compose 'FI 'sin)
;-> (lambda (x) (FI (sin x)))
((compose 'FI 'sin) 3)
;-> 0.1411200080598672

(compose 'sin 'FI)
;-> (lambda (x) (sin (FI x)))
((compose 'sin 'FI) 3)
;-> 0.1411200080598672

(compose 'MI 'sin)
;-> (lambda (x) (MI (sin x)))
((compose 'MI 'sin) 3)
;-> (sin 3)

(compose 'sin 'MI)
;-> (lambda (x) (sin (MI x)))
((compose 'sin 'MI) 3)
;-> ERR: value expected in function sin : (MI x)

In questo ultimo caso l'errore è provocato dal fatto che la macro identità non viene espansa.

Scriviamo una nuova funzione "compose2" (Kazimir Majorinc):

(define (compose2 f g)
  (expand (lambda-macro () (letex ((_ex (cons 'g (args)))) (f _ex)))
                           'f 'g))
;-> (lambda (f g) (expand (lambda-macro ()
;->    (letex ((_ex (cons 'g (args)))) (f _ex))) 'f 'g))

Facciamo alcune prove:

(println (compose2 'sin 'cos))
;-> (lambda-macro ()
;->  (letex ((_ex (cons 'cos (args)))) (sin _ex)))

((compose2 'sin 'cos) 2)
;-> -0.4042391538522658
(sin (cos 2))
;-> -0.4042391538522658

(define (f1 x) (+ x 1))
(define (f2 x) (+ x 2))
(define f1f2 (compose2 f1 f2))
;-> (lambda-macro ()
;->  (letex ((_ex (cons '(lambda (x) (+ x 2)) (args)))) ((lambda (x) (+ x 1)) _ex)))
(f1f2 0)
;-> 3

(compose2 'FI 'sin)
;-> (lambda-macro ()
;->  (letex ((_ex (cons 'sin (args)))) (FI _ex)))
((compose2 'FI 'sin) 3)
;-> 0.1411200080598672

(compose2 'sin 'FI)
;-> (lambda-macro ()
;->  (letex ((_ex (cons 'FI (args)))) (sin _ex)))
((compose2 'sin 'FI) 3)
;-> 0.1411200080598672

(compose2 'MI 'sin)
;-> (lambda-macro ()
;->  (letex ((_ex (cons 'sin (args)))) (MI _ex)))
((compose2 'MI 'sin) 3)
;-> (sin 3)

(compose2 'sin 'MI)
;-> (lambda-macro ()
;->  (letex ((_ex (cons 'MI (args)))) (sin _ex)))
((compose2 'sin 'MI) 3)
;-> 0.1411200080598672

Quindi "compose2" si comporta correttamente anche con le macro.

Adesso vediamo una funzione che compone un numero variabile di funzioni o macro (Kazimir Majorinc):

(set 'multicompose
  (lambda() (case (length (args))
            (0 I) ; because (I (S x)) <=> (S x),
                  ; no matter if S is function or macro
                  ; so I can be always added from the left.
            (1 (first (args)))
            (2 (apply compose2 (args)))
            (true (compose2 (first (args)) (apply compose2 (rest (args))))))))
;-> (lambda ()
;->  (case (length (args))
;->   (0 I)
;->   (1 (first (args)))
;->   (2 (apply compose2 (args)))
;->   (true (compose2 (first (args)) (apply compose (rest (args)))))))

Facciamo alcuni esempi:

((multicompose sqrt) 65536)
;-> 256
((multicompose sqrt sqrt) 65536)
;-> 16
((multicompose sqrt sqrt sqrt) 65536)
;-> 4
((multicompose sin cos sin) 5)
;-> 0.5433319155414624

Sembra che tutto funzioni correttamente. Comunque, il risultato della composizione è piuttosto complicato a causa della definizione ricorsiva.

(multicompose 'f1 'f2 'f3 'f4)
;-> (lambda-macro ()
;->  (letex ((_ex (cons '(lambda-macro ()
;->       (letex ((_ex (cons 'f3 (args)))) (f2 _ex)))
;->      (args))))
;->   (f1 _ex)))

Se si usasse l'iterazione per definire la composizione di più funzioni, allora il risultato potrebbe essere più breve e veloce, ma non più elegante.

Adesso vediamo due macro per la composizione di funzioni (Kazimir Majorinc):

(define-macro (make-pass-adapted)
  (doargs (arg)
     (constant arg
        (letex((arg (eval arg)))
           (lambda-macro()
              (arg (eval (if (> (length (args)) 1)
                             (args)
                             (first (args))))))))))

(sin 3)
;-> 0.1411200080598672
(sin (cos 4))
;-> -0.6080830096407656
(sin (cos (sin 5)))
;-> 0.5433319155414624

(make-pass-adapted sin cos)
;-> (lambda-macro () ((lambda-macro ()
;->    (if (> (length (args)) 1)
;->     (cos.original (eval (args)))
;->     (cos.original (eval (first (args))))))
;->   (eval
;->    (if (> (length (args)) 1)
;->     (args)
;->     (first (args))))))

(sin (+ (cos 0) (cos 0) (cos 0)))
;-> 0.1411200080598672
(sin cos 4)
;-> -0.6080830096407656
(sin cos sin (+ 2 3))
;-> 0.5433319155414624

Nota: per eseguire questa seconda macro occorre utilizzare una nuova REPL perchè, altrimenti, le definizioni delle funzioni "sin" e "cos" sono già modificate dalla macro "make-pass-adapted" (scherzi delle macro...). Kazimir: "In my opinion , bad happened. I like it. ".

(define-macro (make-pass-adapted2)
  (doargs (arg)
    (letex ((Old arg)
            (Old.original (sym (append (string arg) ".original")))
            (New (sym (string arg))))
      (setf Old.original Old)
      (constant 'New (lambda-macro()
                        (if (> (length (args)) 1)
                            (Old.original (eval (args)))
                            (Old.original (eval (first (args))))))))))

(make-pass-adapted2 sin cos)
;-> (lambda-macro ()
;->  (if (> (length (args)) 1)
;->   (cos.original (eval (args)))
;->   (cos.original (eval (first (args))))))

(println (sin.original (cos.original 3)) " = " (sin cos 3))
;-> -0.8360218615377305 = -0.8360218615377305
(println (cos.original (sin.original (cos.original 3))) " = " (cos sin cos 3))
;-> 0.6704198299761109 = 0.6704198299761109

Vediamo un altro metodo per realizzare la composizione di funzioni:

; https://github.com/pepdiz/newlisp:
; only applicable to lambda functions and builtins (no special forms)
; composition requires currification, but this is not checked (relies on programmer)
; --checking this woin't be a real trouble but adds computation:
; -- (define (º f g)
; --   (if (and (= (length (first f)) 1) (= (length (first g)) 1))
; --     (expand (lambda (x) (g (f x))) 'g 'f)
; --     (throw-error "functions must be curryfied")))

; mathematical composition (but reversed notation)
(define (º f g) (expand (lambda (x) (g (f x))) 'g 'f))

; ((º inc dec) 4)
; (º (curry map inc) print)
; ((º (curry map inc) print) '(1 2 3))

; extending composition to several functions
; newlisp hasn't a way to explicitly define variadic functions
; but newlisp doesn't complain about matching formal arguments and actual ones
; for user defined funtions (built-in's are another song)
; so a function defined without arguments behaves as a variadic function
; provided you access arguments throug args function
(define (->) (apply º (args) 2))

; --- TESTS
(define (test e v) (if (= (eval e) v) (print "test " e " ok") (print "test " e " failed")))

(test '((º inc dec) 4) 4)
(test '((º (º inc dec) inc) 4) 5)
(test '((º (curry map inc) print) '(1 2 3)) '(2 3 4))
(test '((-> inc dec inc) 4) 5)


------------------------------------------------
Regressione lineare (Metodo dei minimi quadrati)
------------------------------------------------

Il metodo dei minimi quadrati (Least-squares) è una tecnica di ottimizzazione (o regressione) che permette di trovare una funzione, rappresentata da una curva ottima (o curva di regressione), che si avvicini il più possibile ad un insieme di dati (in genere punti del piano). In particolare, la funzione trovata deve essere quella che minimizza la somma dei quadrati delle distanze tra i dati osservati e quelli della curva che rappresenta la funzione stessa.

Di seguito vengono presentati due metodi di regressione con i minimi quadrati:

1) la regressione lineare (per dati lineari)
2) la regressione lineare (per dati non lineari)

1) Regressione lineare (per dati lineari)
-----------------------------------------
La regressione lineare è un metodo semplice per adattare un insieme di dati che tende a variare linearmente.
Abbiamo un insieme di n punti (xi,yi) con i = 0...(n-1).
La curva di regressione (interpolazione) è una retta con la forma:

  f(x) ==> y = a*x + b

dove "a" e "b" sono i coefficienti incogniti da determinare.

In una retta "a" e "b" rappresentano:

  a = Pendenza o Gradiente (quanto è ripida la linea)
  b = Intercetta Y (dove la linea attraversa l'asse Y)

L'idea alla base del metodo dei minimi quadrati è di ridurre al minimo i quadrati delle differenze tra i valori dei dati e i valori della funzione (in questo caso una retta). L'errore totale che si verifica considerando tutti gli n punti vale:

    (n-1)
  E = ∑ [d(x(i))]^2
     i=0

dove d(x(i)) è la differenza tra y(i) e il valore della retta di regressione in xi (cioè, f(xi)).

Quindi sostituendo con l'equazione della retta:

    (n-1)
  E = ∑ [y(i) - f(x(i))]^2
     i=0

Il metodo dei minimi quadrati si basa sul fatto (dimostrato dall'analisi matematica) che una funzione ha valore minimo quando le sue derivate parziali sono zero. Quindi per trovare le variabili "a" e "b" dobbiamo risolvere le seguenti due equazioni alle derivate parziali:

  dp(E)             dp(E)
  ----- = 0    e    ----- = 0
   d(a)              d(b)

Vediamo direttamente la soluzione, cioè le formule per il calcolo di "a" e "b":

      n * ∑xy - ∑x * ∑y
a = ---------------------
        n * ∑x² - ∑x

      ∑y * ∑x² - ∑xy * ∑x
b = -----------------------
         n * ∑x² - ∑x

La seguente funzione "linear-regression" restituisce i valori di "a" e "b" oppure, se il parametro "func" vale true, una funzione che rappresenta la retta f(x) = a*x + b.

(define (linear-regression lst func)
  (local (n x y sx sy sxy sx2 a b)
    (setq n (length lst))
    (set 'sx 0 'sy 0 'sxy 0 'sx2 0)
    (setq x (map first lst))
    (setq y (map last lst))
    (for (i 0 (- n 1))
      (setq sx (add sx (x i)))
      (setq sy (add sy (y i)))
      (setq sxy (add sxy (mul (x i) (y i))))
      (setq sx2 (add sx2 (mul (x i) (x i))))
    )
    (setq den (sub (mul n sx2) (mul sx sx)))
    (setq a (div (sub (mul n sxy) (mul sx sy)) den))
    (setq b (div (sub (mul sy sx2) (mul sxy sx)) den))
    (if func ; if func = true
      ; return a function
      (let (f (string "(lambda (x) (add (mul " a " x) " b "))"))
           (eval-string f))
      ; else: return a and b
      (list a b)
    )))

Vadiamo alcuni esempi:

Esempio 1:

(setq points '((10 2.2) (15 4.6) (20 4.2) (25 7.0) (30 6.6) (35 9.2)))

Restituisce la coppia (a b):

(linear-regression points)
;-> (0.2502857142857143 0.001904761904756361)

Restituisce la funzione (fx) = a*x + b:

(define reg-line (linear-regression points true))
;-> (lambda (x) (add (mul 0.2502857142857143 x) 0.001904761904756361))

(reg-line 10)
;-> 2.504761904761899
(reg-line 15)
;-> 3.75619047619047

Il grafico dei punti e della linea di regressione è rappresentato nel file "linefit.png" nella cartella "data".

Esempio 2:

(setq punti '((2 4) (3 5) (5 7) (7 10) (9 15)))

Restituisce la coppia (a b):

(linear-regression punti)
;-> (1.518292682926829 0.3048780487804878)

Restituisce la funzione (fx) = a*x + b:

(define reg-linea (linear-regression punti true))
;-> (lambda (x) (add (mul 1.518292682926829 x) 0.3048780487804878))

(reg-linea 2)
;-> 3.341463414634146

(reg-linea 3)
;-> 4.859756097560975

Possiamo calcolare l'errore che commettiamo per ogni punto:

(setq xp (map first punti))
;-> (2 3 5 7 9)
(setq yp (map last punti))
;-> (4 5 7 10 15)
(setq errore (map sub (map reg-linea xp) yp))
;-> (-0.6585365853658542 -0.1402439024390247 0.8963414634146325
;->   0.9329268292682915 -1.030487804878051)

Esempio 3:

(setq p '((1.21 1.69)  (3 5.89)  (5.16 4.11)  (8.31 5.49)  (10.21 8.65)))

Restituisce la coppia (a b):

(linear-regression p)
;-> (0.5615004009523624 2.033950763487721)

Restituisce la funzione (fx) = a*x + b:

(define reg-linea2 (linear-regression p true))
;-> (lambda (x) (add (mul 0.5615004009523624 x) 2.033950763487721))

(reg-linea2 5.16)
;-> 4.931292832401911

2) la regressione lineare (per dati non lineari)
------------------------------------------------

Funzione interpolatrice:

  f(X) = Y = A*X^B

Applichiamo il logaritmo:

  log(Y) = B*log(X) + log(A)

Che è della forma:

  y = a*x + b

dove: y = log(Y), x = log(X), b = log(A), a = B

Quindi possiamo utilizzare la formula per la regressione lineare per calcolare "a" e "b" e poi calcolare i valori di "A" e "B" con le seguenti formule:

  A = 10^b
  B = a

Esempio:

(setq pts '((1 0.1) (2 0.7) (3 0.9) (4 1.7) (5 2.1)))
(setq px (map first pts))
(setq py (map last pts))

Prima applichiamo il logaritmo alle coordinate dei punti:

(setq pxlog (map (fn(x) (log x 10)) px))
;-> (0 0.3010299956639811 0.4771212547196624 0.6020599913279623
;->  0.6989700043360188)
(setq pylog (map (fn(x) (log x 10)) py))
;-> (-0.9999999999999998 -0.1549019599857432 -0.04575749056067512
;->   0.2304489213782739 0.3222192947339193)

Ricostruiamo i punti:

(setq ptslog (map list pxlog pylog))

Poi applichiamo la formula della regressione lineare:

(linear-regression ptslog)
;-> (1.854157246411439 -0.9006240416792385)

Poi calcoliamo le costanti A e B:

(setq A (pow 10 -0.9006240416792385))
;-> 0.1257117749488202
(setq B 1.854157246411439)
;-> 1.854157246411439

Quindi la funzione interpolatrice vale:

  f(x) = y = A*x^B = 0.1257117749488202*x^1.854157246411439

Nota: Esistono altri tipi di equazioni a cui può essere applicato questo metodo di regressione lineare, ad esempio:

Funzione interpolatrice:

  Y = A*e^(B*X)

Applichiamo il logaritmo naturale

  ln(Y) = ln(A) + B*X*ln(e)

  ln(e) = 1  ==>  ln(Y) = ln(A) + B*X

Che è della forma: y = a*x + b

dove y = ln(Y), x = X, b = ln(A), a = B


----------------------------------------------------
Regressione polinomiale (Metodo dei minimi quadrati)
----------------------------------------------------

Il metodo di regressione polinomiale è un metodo adatto per quelle serie di punti [(xi yi) per i=0...(n-1)] che descrivono una curva dall'andamento polinomiale. Un polinomio di ordine m viene scritto nel modo seguente:

  g(x) = a0 + a1*x + a2*x² + a3*x³ + ... + am*x^m

dove a0, a1, a2, a3, ..., am sono i coefficienti incogniti.

Questi coefficienti sono determinati partendo dall'errore totale E come somma dei quadrati degli errori per tutti i punti dati:

    (n-1)
  E = ∑ [d(x(i))]^2
     i=0

dove d(x(i)) è la differenza tra y(i) e il valore del polinomio di regressione in xi (cioè, f(xi)).

Quindi sostituendo con l'equazione del polinomio:

    (n-1)
  E = ∑ [y(i) - g(x(i))]^2
     i=0

    (n-1)
  E = ∑ [y(i) - (a0 + a1*xi + a2*xi² + a3*xi³ + ... + am*xi^m)]^2
     i=0

Gli (m + 1) coefficienti a0, a1, a2, a3, ..., am si ricavano minimizzando E rispetto ai coefficienti incogniti (least-squares regression). Per fare questo dobbiamo eguagliare a 0 tutte le (m + 1) derivate parziali:

  dp(E)        |
  ----- = 0    |
  d(a0)        |
               |
  dp(E)        |
  ----- = 0    |
  d(a1)        |
               |
  dp(E)        |
  ----- = 0    |
  d(a2)        |  (m + 1) equazioni
               |
  dp(E)        |
  ----- = 0    |
  d(a3)        |
               |
  ...          |
               |
  dp(E)        |
  ----- = 0    |
  d(am)        |

Sviluppando queste derivate si trova un sistema di equazioni lineari che, una volta risolto, fornisce i valori di tutti i coefficienti del polinomio.
Il sistema di equazioni da risolvere ha la seguente struttura:

| n     ∑xi       ∑xi^2     ... ∑xi^m     |   | a0 |   | ∑yi      |
| ∑xi   ∑xi^2     ∑xi^3     ... ∑xi^(m+1) |   | a1 |   | ∑xiyi    |
| ∑xi^2 ∑xi^3     ∑xi^4     ... ∑xi^(m+2) | * | a2 | = | ∑xi^2*yi |
| ...   ...       ...       ... ...       |   | ...|   | ...      |
| ∑xi^m ∑xi^(m+1) ∑xi^(m+2) ... ∑xi^(2m)  |   | am |   | ∑xi^m*yi |

Utilizziamo il metodo di gauss per risolvere il sistema:

(define (gauss A b)
  (local (n m p rowx amax xfac temp temp1 x)
    ; conta il numero di scambio righe
    (setq rowx 0)
    (setq n (length A))
    (setq x (dup '0 n))
    (for (k 0 (- n 2))
      (setq amax (abs (A k k)))
      (setq m k)
      ; trova la riga con il pivot più grande
      (for (i (+ k 1) (- n 1))
        (setq xfac (abs (A i k)))
        (if (> xfac amax) (setq amax xfac m i))
      )
      ; scambio delle righe
      (if (!= m k) (begin
          (++ rowx)
          (setq temp1 (b k))
          (setq (b k) (b m))
          (setq (b m) temp1)
          (for (j k (- n 1))
            (setq temp (A k j))
            (setq (A k j) (A m j))
            (setq (A m j) temp)
          ))
      )
      (for (i (+ k 1) (- n 1))
        (setq xfac (div (A i k) (A k k)))
        (for (j (+ k 1) (- n 1))
          (setq (A i j) (sub (A i j) (mul xfac (A k j))))
        )
        (setq (b i) (sub (b i) (mul xfac (b k))))
      )
    )
    ; sostituzione all'indietro (backward sostitution)
    (for (j 0 (- n 1))
      (setq p (sub n j 1))
      (setq (x p) (b p))
      (if (<= (+ p 1) (- n 1))
        (for (i (+ p 1) (- n 1))
          (setq (x p) (sub (x p) (mul (A p i) (x i))))
        )
      )
      (setq (x p) (div (x p) (A p p)))
    )
    x))

Adesso scriviamo una funzione che genera il sistema di equazioni partendo dagli n punti iniziali.

(define (polyfit points order)
  (local (n m a b x y k)
    (setq n (length points))
    (setq m order)
    ; matrice del sistema
    (setq a (array (+ m 1) (+ m 1) '(0)))
    ; vettore termini noti
    (setq b (array (+ m 1) '(0)))
    (setq x (map first points))
    (setq y (map last points))
    (for (ir 0 m)
      (for (ic 0 m)
        (setq k (+ ir ic))
        (for (i 0 (- n 1))
          (setf (a ir ic) (add (a ir ic) (pow (x i) k)))
        )
      )
      (for (i 0 (- n 1))
        (setf (b ir) (add (b ir) (mul (y i) (pow (x i) ir))))
      )
    )
    ;(list a b)
    ; calcola i coefficienti del polinomio di regressione
    ; risolvendo il sistema lineare
    (gauss a b)))

Facciamo un esempio:

Creiamo una lista di punti:

(setq punti '((0 1.00762) (5 1.00392) (10 1.00153) (15 1) (20 0.99907)
              (25 0.99852) (30 0.99826) (35 0.99818) (40 0.99828)
              (45 0.99849) (50 0.99878) (55 0.99919) (60 0.99967)
              (65 1.00024) (70 1.00091) (75 1.00167) (80 1.00253)
              (85 1.00351) (90 1.00461) (95 1.00586) (100 1.00721)))
(length punti)
;-> 21
(setq px (map first punti))
;-> (0 5 10 15 20 25 30 35 40 45 50
;->  55 60 65 70 75 80 85 90 95 100))
(setq py (map last punti))
;-> (1.00762 1.00392 1.00153 1.00000 0.99907 0.99852 0.99826
;->  0.99818 0.99828 0.99849 0.99878 0.99919 0.99967 1.00024
;->  1.00091 1.00167 1.00253 1.00351 1.00461 1.00586 1.00721)

Proviamo la funzione "polyfit" utilizzando un polinomio di ordine 3:

g(x) = a0 + a1*x + a2*x^2 + a3*x^4

(polyfit punti 3)
;-> (1.00644556747601
;->  -0.0004985711478970345
;->  8.453810415389021e-006
;->  -3.453389732580245e-008)

Quindi i coefficienti del polinomio valgono:

a0 = 1.00644556747601
a1 = -0.0004985711478970345
a2 = 8.453810415389021e-006
a3 = -3.453389732580245e-008

Il grafico dei punti e del polinomio di regressione è rappresentato nel file "polyfit.png" nella cartella "data".

Possiamo creare una funzione che rappresenta il polinomio con la seguente funzione che prende una lista di coefficienti (in ordine inverso: prima il coefficiente con il grado più alto):

(define (crea-polinomio coeff)
  (local (fun body)
    (reverse coeff)
    (setq fun '(lambda (x) x)) ;funzione lambda base
    (setq body '()) ;corpo della funzione
    (push 'add body -1)
    (push (first coeff) body -1) ;termine noto
    (push (list 'mul 'x (coeff 1)) body -1) ;termine lineare
    (for (i 2 (- (length coeff) 1))
      (push (list 'mul (list 'pow 'x i) (coeff i)) body -1)
    )
    (setq (last fun) body) ;modifica corpo della funzione
    fun
  )
)

(setq reverse-coeff (reverse '(1.00644556747601
                               -0.0004985711478970345
                               8.453810415389021e-006
                               -3.453389732580245e-008)))

(define poly (crea-polinomio reverse-coeff))
;-> (lambda (x) (add 1.00644556747601
;->             (mul x -0.0004985711478970345)
;->             (mul (pow x 2) 8.453810415389021e-006)
;->             (mul (pow x 3) -3.453389732580245e-008)))

Calcoliamo i valori del polinomio alle coordinate x dei punti:

(map poly px)
;-> (1.00644556747601
;->  1.004159740259744
;->  1.002270703141253
;->  1.000752555697543
;->  0.9995793975056184
;->  0.9987253281424867
;->  0.9981644471851524
;->  0.9978708542106215
;->  0.9978186487958997
;->  0.9979819305179923
;->  0.9983347989539055
;->  0.9988513536806446
;->  0.9995056942752152
;->  1.000271920314623
;->  1.001124131375874
;->  1.002036427035973
;->  1.002982906871926
;->  1.003937670460739
;->  1.004874817379418
;->  1.005768447204968
;->  1.006592659514394)


-----------------------------------
Ordinamento naturale (Natural Sort)
-----------------------------------

Supponiamo di avere la seguente lista:

(setq alist '("a10" "b2" "a2" "a1" "b1" "a14" "b12"))

Se applichiamo l'ordinamento standard con la funzione "sort" otteniamo la lista:

(setq sort-lst (sort (copy alist)))
;-> ("a1" "a10" "a14" "a2" "b1" "b12" "b2")

Questo è l'ordinamento alfabetico, ma alcune volte abbiamo bisogno di avere un "ordinamento naturale" in cui le lettere sono seguite dai numeri in ordine numerico, cioè:

 ("a1" "a2" "a10" "a14" "b1" "b2" "b12")

L'ordinamento naturale è l'ordinamento delle stringhe in ordine alfabetico, tranne per il fatto che i numeri a più cifre vengono trattati atomicamente, cioè come se fossero un singolo carattere. Il termine "naturale" deriva dal fatto che è più adatto all'uomo ("naturale") rispetto all'ordinamento alfabetico puro.

La funzione seguente ordina una lista di stringhe in modo "naturale":

; ported to newLISP by G. Fischer
(define (natural-sort l)
  (let (natural-key (lambda (s) (filter true?
    (flat (transpose (list
            (parse s "[0-9]+" 0)
            (map int (find-all "[0-9]+" s))))))))
    (sort l (fn (x y) (< (natural-key x)
            (natural-key y))))
))

(natural-sort alist)
;-> ("a1" "a2" "a10" "a14" "b1" "b2" "b12")

(natural-sort '("1a" "11a" "a12" "c01" "01c" "010b" "b1" "a01" "a001"))
;-> ("1a" "01c" "010b" "11a" "a001" "a01" "a12" "b1" "c01")

(setq test
 '("1-2" "1-02" "1-20" "10-20" "fred" "jane" "pic01" "pic2" "pic02"
   "pic02a" "pic3" "pic4" "pic 4 else" "pic 5" "pic05" "pic 5 " ))
   "pic 5 something" "pic 6" "pic   7" "pic100" "pic100a" "pic120"
   "pic121" "pic02000" "tom" "x2-g8" "x2-y7" "x2-y08" "x8-y8"

(natural-sort test)
;-> ("1-02" "1-2" "1-20" "10-20" "fred" "jane" "pic01" "pic02" "pic2"
;->  "pic02a" "pic3" "pic4" "pic05" "pic100" "pic100a" "pic120" "pic121"
;->  "pic02000" "pic 4 else" "pic 5" "pic 5 " "pic 5 something" "pic 6"
;->  "pic   7" "tom" "x2-g8" "x2-y08" "x2-y7" "x8-y8")


------------------------
D. Backspace e AlphaCode
------------------------

Un problema (difficile) dal sito Codeforces:

https://codeforces.com/problemset/problem/1553/D

Questo problema è interessante perchè è stato affrontato e risolto dal programma AI AlphaCode che è in grado di creare codice in C++ o python per risolvere problemi di programmazione definiti in modo testuale. Maggiori informazioni ai seguenti link:

https://deepmind.com/blog/article/Competitive-programming-with-AlphaCode

https://storage.googleapis.com/deepmind-media/AlphaCode/competition_level_code_generation_with_alphacode.pdf

Il testo del problema è il seguente:

Abbiamo due stringhe s e t, entrambe composte da lettere inglesi minuscole.
Digitare la stringa carattere per carattere, dal primo all'ultimo carattere.

Quando si digita un carattere, invece di premere il pulsante corrispondente, è possibile premere il pulsante "Backspace". Questo elimina l'ultimo carattere digitato tra quelli che non sono ancora stati eliminati (o non fa nulla se non ci sono caratteri nella stringa corrente). Ad esempio, se s è "abcbd" e premiamo Backspace invece di digitare il primo e il quarto carattere, otteniamo la stringa "bd" (la prima pressione di Backspace non cancella nessun carattere, e la seconda pressione cancella il carattere "c"). Un altro esempio, se s è "abcaa" e si preme Backspace invece delle ultime due lettere, il testo risultante è "a".

Il compito è determinare se è possibile ottenere la stringa t, se digitando la stringa s e premendo "Backspace" invece di digitare i diversi (anche zero) caratteri di s.

La funzione deve stampare "YES" se è possibile ottenere la stringa t digitando la stringa s e sostituendo alcuni caratteri premendo il pulsante "Backspace", oppure stampare "NO" se questo non è possibile.

Esempi:

  s       t      Risultato
  ------------------------
  ababa   ba     true
  ababa   bb     nil
  aaa     aaaa   nil
  aababa  ababa  true

Riportiamo la soluzione generata da AlphaCode (in python):

  t=int(input())
  for i in range(t):
    s=input()          ;
    t=input()          ;
    a=[]               ;
    b=[]               ; First Alpha Code reads
    for j in s:        ; the two phrases.
      a.append(j)      ;
    for j in t:        ;
      b.append(j)      ;
    a.reverse()                          ;
    b.reverse()                          ; If the letters at the end
    c=[]                                 ; of both phrases don't match,
    while len(b)!=0 and len(a)!=0:       ; the last letter must be deleted.
      if a[0]==b[0]:                     ; If the do match we can move
          c.append(b.pop(0))             ; onto the second last letter
          a.pop(0)                       ; and repeat
      elif a[0]!=b[0] and len(a)!=1:     ;
          a.pop(0)     ; Backspace deletes two letters. The letter you press
          a.pop(0)     ; backspace instead of, and the letter before it.
      elif a[0]!=b[0] and len(a)==1:
          a.pop(0)
    if len(b)==0:        ;
        print("YES")     ; If we have matched every letter,
    else:                ; it is possible and we output that.
        print("NO")      ;

Convertiamo la stessa funzione in newLISP:

(define (write? s t)
  (local (a b c)
    (setq a (reverse (explode s)))
    (setq b (reverse (explode t)))
    (setq c '())
    (while (and (!= (length b) 0) (!= (length a) 0))
      (cond ((= (a 0) (b 0))
             (push (pop b) c)
             (pop a)
            )
            ((and (!= (a 0) (b 0)) (!= (length a) 1))
             (pop a)
             (pop a)
            )
            ((and (!= (a 0) (b 0)) (= (length a) 1))
             (pop a)
            )
      )
    )
    (if (= (length b) 0)
        (println "YES")
        (println "NO")
    )))

Proviamo la funzione:

(write? "ababa"   "ba"   )
;-> YES
(write? "ababa"   "bb"   )
;-> "NO"
(write? "aaa"     "aaaa" )
;-> "NO"
(write? "aababa"  "ababa")
;-> YES

Adesso scriviamo una soluzione "umana" (le spiegazioni nei commenti):

(define (possible? s t)
  (setq n (length s))
  (setq m (length t))
  (setq i (- n 1))
  (setq ok true)
  (setq stop nil)
  ; ciclo sulla stringa t (all'indietro)
  (for (j (- m 1) 0 -1 stop)
    ; ciclo sulla stringa s (all'indietro)
    ; finchè i caratteri correnti di s e t sono diversi
    (while (and (> i 0) (!= (s i) (t j)))
      ; diminuiamo l'indice di s di 2
      (-- i 2)
    )
    ; se la stringa s è terminata
    ; allora non è possibile scrivere t da s
    (if (< i 0) (set 'ok nil 'stop true))
    ; passiamo al prossimo carattere di s
    (-- i)
  )
  (if ok
      (println "YES")
      (println "NO")
  ))

Proviamo la funzione:

(possible? "ababa"   "ba"   )
;-> YES
(possible? "ababa"   "bb"   )
;-> "NO"
(possible? "aaa"     "aaaa" )
;-> "NO"
(possible? "aababa"  "ababa")
;-> YES

Nota:
"AlphaZero" è il più bravo giocatore di scacchi del mondo.
"AlphaGo" è il più bravo giocatore di go del mondo.
"AlphaCode" forse diventerà il più bravo programmatore del mondo.
Comunque noi esseri umani giochiamo ancora a scacchi, a go e sicuramente continueremo a programmare anche solo per divertimento.


-------------------------
isclose(x, y) di python 3
-------------------------

Confrontare correttamente se due numeri in virgola mobile (floating-point) sono quasi uguali è abbastanza complicato. Il linguaggio python 3 mette a disposizione la funzione "isclose" che determina se un valore è approssimativamente uguale o "vicino" a un altro valore.

La funzione ha la seguente struttura: isclose(a, b, rel_tol=1e-9, abs_tol=0.0)

a e b: sono i due valori da verificare per la vicinanza relativa

rel_tol: è la tolleranza relativa -- è la quantità di errore consentita, relativa al valore assoluto più grande di a o b. Ad esempio, per impostare una tolleranza del 5%, passare tol=0,05. La tolleranza predefinita è 1e-9, che assicura che i due valori siano gli stessi entro circa 9 cifre decimali. rel_tol deve essere maggiore di 0.0.

abs_tol: è un livello di tolleranza assoluto minimo (utile per confronti vicini allo zero).

Riportiamo le implementazioni in python 3 della versione preliminare e della versione finale della funzione "isclose". Nei commenti delle due funzioni troviamo le spiegazioni dei metodi utilizzati. Per maggiori informazioni sul funzionamento della routine vedi:

  https://www.python.org/dev/peps/pep-0485/

Definizione preliminare di "isclose":
-------------------------------------
#!/usr/bin/env python3

"""
Test implementation for an isclose() function, for possible inclusion in
the Python standard library -- PEP0485
This version has multiple methods in it for experimentation and testing.
The "final" version can be found in isclose.py
This implementation is the result of much discussion on the python-ideas list
in January, 2015:
   https://mail.python.org/pipermail/python-ideas/2015-January/030947.html
   https://mail.python.org/pipermail/python-ideas/2015-January/031124.html
   https://mail.python.org/pipermail/python-ideas/2015-January/031313.html
Copyright: Christopher H. Barker
License: Apache License 2.0 http://opensource.org/licenses/apache2.0.php
"""
import cmath

def isclose(a,
            b,
            rel_tol=1e-9,
            abs_tol=0.0,
            method='weak'):
    """
    returns True if a is close in value to b. False otherwise
    :param a: one of the values to be tested
    :param b: the other value to be tested
    :param rel_tol=1e-8: The relative tolerance -- the amount of error
                         allowed, relative to the magnitude of the input
                         values.
    :param abs_tol=0.0: The minimum absolute tolerance level -- useful for
                        comparisons to zero.
    :param method: The method to use. options are:
                  "asymmetric" : the b value is used for scaling the tolerance
                  "strong" : The tolerance is scaled by the smaller of
                             the two values
                  "weak" : The tolerance is scaled by the larger of
                           the two values
                  "average" : The tolerance is scaled by the average of
                              the two values.
    NOTES:
    -inf, inf and NaN behave similar to the IEEE 754 standard. That
    -is, NaN is not close to anything, even itself. inf and -inf are
    -only close to themselves.
    Complex values are compared based on their absolute value.
    The function can be used with Decimal types, if the tolerance(s) are
    specified as Decimals::
      isclose(a, b, rel_tol=Decimal('1e-9'))
    See PEP-0485 for a detailed description
    """
    if method not in ("asymmetric", "strong", "weak", "average"):
        raise ValueError('method must be one of: "asymmetric",'
                         ' "strong", "weak", "average"')

    if rel_tol < 0.0 or abs_tol < 0.0:
        raise ValueError('error tolerances must be non-negative')

    if a == b:  # short-circuit exact equality
        return True
    # use cmath so it will work with complex or float
    if cmath.isinf(a) or cmath.isinf(b):
        # This includes the case of two infinities of opposite sign, or
        # one infinity and one finite number. Two infinities of opposite sign
        # would otherwise have an infinite relative tolerance.
        return False
    diff = abs(b - a)
    if method == "asymmetric":
        return (diff <= abs(rel_tol * b)) or (diff <= abs_tol)
    elif method == "strong":
        return (((diff <= abs(rel_tol * b)) and
                 (diff <= abs(rel_tol * a))) or
                (diff <= abs_tol))
    elif method == "weak":
        return (((diff <= abs(rel_tol * b)) or
                 (diff <= abs(rel_tol * a))) or
                (diff <= abs_tol))
    elif method == "average":
        return ((diff <= abs(rel_tol * (a + b) / 2) or
                (diff <= abs_tol)))
    else:
        raise ValueError('method must be one of:'
                         ' "asymmetric", "strong", "weak", "average"')

Definizione finale di "isclose":
--------------------------------
#!/usr/bin/env python3

"""
Test implementation for an isclose() function, for possible inclusion in
the Python standard library -- PEP0485
This is the result of much discussion on the python-ideas list
in January, 2015:
   https://mail.python.org/pipermail/python-ideas/2015-January/030947.html
   https://mail.python.org/pipermail/python-ideas/2015-January/031124.html
   https://mail.python.org/pipermail/python-ideas/2015-January/031313.html
Copyright: Christopher H. Barker
License: Apache License 2.0 http://opensource.org/licenses/apache2.0.php
"""

import math

def isclose(a, b, rel_tol=1e-9, abs_tol=0.0):
    """
    returns True if a is close in value to b. False otherwise
    :param a: one of the values to be tested
    :param b: the other value to be tested
    :param rel_tol=1e-9: The relative tolerance -- the amount of error
                         allowed, relative to the absolute value of the
                         larger input values.
    :param abs_tol=0.0: The minimum absolute tolerance level -- useful
                        for comparisons to zero.
    NOTES:
    -inf, inf and NaN behave similarly to the IEEE 754 Standard. That
    is, NaN is not close to anything, even itself. inf and -inf are
    only close to themselves.
    The function can be used with any type that supports comparison,
    substratcion and multiplication, including Decimal, Fraction, and
    Complex
    Complex values are compared based on their absolute value.
    See PEP-0485 for a detailed description
    """

    if a == b:  # short-circuit exact equality
        return True

    if rel_tol < 0.0 or abs_tol < 0.0:
        raise ValueError('error tolerances must be non-negative')

    # use cmath so it will work with complex ot float
    if math.isinf(abs(a)) or math.isinf(abs(b)):
        # This includes the case of two infinities of opposite sign, or
        # one infinity and one finite number. Two infinities of opposite sign
        # would otherwise have an infinite relative tolerance.
        return False
    diff = abs(b - a)

    return (((diff <= abs(rel_tol * b)) or
             (diff <= abs(rel_tol * a))) or
            (diff <= abs_tol))

Adesso scriviamo la versione finale di "isclose" in newLISP:

(define (isclose? a b rel-tol abs-tol)
  (if (nil? abs-tol) (setq abs-tol 0.0))
  (if (nil? rel-tol) (setq rel-tol 1e-9))
  (cond ((= a b) true)
        ((or (inf? (abs a)) (inf? (abs b))) nil)
        (true
         (let (diff (abs (sub b a)))
              (or (<= diff (abs (mul rel-tol b)))
                  (<= diff (abs (mul rel-tol a)))
                  (<= diff abs-tol))))))

rel-tol, la tolleranza relativa, viene moltiplicata per entrambi i valori degli argomenti. All'aumentare dei valori, aumenta anche la differenza consentita tra loro pur considerandoli uguali.
abs-tol, la tolleranza assoluta, viene applicata così com'è in tutti i casi.
Se la differenza è inferiore a una di queste tolleranze, i valori sono considerati uguali ("vicini").

Proviamo la funzione con gli esempi riportati nel manuale di riferimento di python3:

La tolleranza relativa è la differenza massima consentita tra gli argomenti di "isclose?", rispetto al valore assoluto più grande:

(setq a 5.0)
(setq b 4.99998)
(isclose? a b 1e-5 0.0)
;-> true
(isclose? a b 1e-8 0.0)
;-> nil

È anche possibile confrontare due valori utilizzando la tolleranza assoluta, che deve essere un valore non negativo:

(isclose? a b 1e-9 0.00003)
;-> true
(isclose? a b 1e-9 0.00001)
;-> nil


-------------------------------------------------------
Dimostrazione della soluzione dell'equazione quadratica
-------------------------------------------------------

La soluzione di un equazione quadratica del tipo:

  a*x² + b*x + c = 0

vale:

       -b ± sqrt(b² - 4ac)
  x = ---------------------
               2a

Prima di dimostrare questa formula, vediamo cosa significa "completare il quadrato".

Completare il quadrato
----------------------
Data un'espressione con due termini del tipo: (x² + b*x), determinare il termine y² da aggiungere in modo l'espressione finale risulti il quadrato di un binomio: x² + b*x + y² = (x + y)².
Uguagliamo i termini uno ad uno:

  x²    --> x²
  2*y*x --> b*x ==> y = b/2
  y²    --> y²  ==> y² = (b/2)²

Dimostrazione
-------------
1) Completare il quadrato

Nell'espressione ax² + bx + c la variabile sconosciuta "x" compare due volte, dobbiamo fare in modo che compaia una sola volta.

Partiamo da:

  ax² + bx + c = 0

Dividiamo per a:

  x² + (b/a)x + (c/a) = 0

Spostiamo l'ultimo termine a destra:

  x² + (b/a)x = (c/a)

Completiamo il quadrato aggiungendo (b/2a)² a sinistra e a destra:

  x² + (b/a)x + (b/2a)² = (c/a) + (b/2a)²

Adesso la parte sinistra è della forma (x + 2dx + d²) = (x + d)², dove d = (b/2a):

  (x + b/2a)² = - c/a + (b/2a)²

2) Risolvere rispetto alla x

Partendo dall'ultima espressione:

  (x + b/2a)² = - c/a + (b/2a)²

Estraiamo la radice di entrambi i membri:

  x + b/2a = ± (sqrt -c/a + (b/2a)²)

Spostiamo b/2a a sinistra:

  x =  - b/2a ± (sqrt -c/a + (b/2a)²) (soluzione!)

Moltiplichiamo la parte destra per 2a/2a:

       - b/2a ± (sqrt -c/a*(2a)² + (b/2a)²*(2a)²)
  x = --------------------------------------------
                         2a

Semplifichiamo ed otteniamo la soluzione:

       - b ± (sqrt b² - 4ac)
  x = -----------------------
               2a

Questa dimostrazione è abbastanza artificiale e richiede di memorizzare alcuni passaggi algebrici. Un altro metodo per dimostrare la soluzione di una equazione quadratica si trova nell'articolo "A Simple Proof of the Quadratic Formula" di Po-Shen Loh disponibile su web all'indirizzo:

  https://arxiv.org/pdf/1910.06709.pdf

Vediamo l'idea di base, ma consiglio di leggere l'articolo originale che non solo spiega le idee, ma inquadra il problema nel giusto contesto storico (il metodo era conosciuto anche dai babilonesi).

Supponiamo di avere un'equazione quadratica da risolvere:

  x² + B*x + C = 0.

Per semplificare le cose, assumiamo che x² abbia un coefficiente di 1 (se abbiamo un'equazione quadratica con qualche altro coefficiente a*x², possiamo sempre dividere tutto per a):

   ax² + b*x + c = 0 ==> x² + (b/a)*x + (c/a) = 0 ==> x² + B*x + C = 0, dove B = b/a e C = c/a.

Ora fattorizzando una forma quadratica possiamo riscrivere l'equazione nella forma:

  (x - r)*(x - s) = 0

il che implica che x = r e x = s sono le due soluzioni. Se moltiplichiamo la suddetta fattorizzazione otteniamo:

  x² - (r + s)*x + r*s = 0

il che significa che stiamo cercando valori r e s il cui prodotto è C e la cui somma è -B.

Partendo da r + s = -B, dividiamo entrambi i membri per 2:

  (r + s)/2 = -B/2

Il lato sinistro è la media di r e s, che si trova a metà strada tra loro sulla linea dei numeri. Usiamo "u" per denotare la distanza da r a -b/2. Poiché -b/2 è a metà tra r e s, u deve essere anche la distanza tra -b/2 e s. Quindi possiamo scrivere r e s nella forma:

  r, s = -b/2 ± u

Ora sappiamo che il prodotto r*s vale C e moltiplicandoli otteniamo una differenza di quadrati:

  C = r*s = (-B/2 + u)*(-B/2 - u) = (-B/2)² - u²

Ora risolvere per "u" è facile, basta isolare u² su un lato dell'equazione e applicare la radice quadrata:

  u = sqrt(B²/4 - c)

Ciò significa che le soluzioni sono:

  r, s = -B/2 ± u = -B/2 ± sqrt(B²/4 - c)

Possiamo usare lo stesso metodo partendo da ax^2 + bx + c = 0 per derivare la formula quadratica standard che include un valore arbitrario di "a", anche se l'algebra richiesta diventa abbastanza tediosa.


-------------------------
La parola chiave "lambda"
-------------------------

In newLISP, la parola "lambda" da sola come simbolo non esiste, indica solo un tipo di lista speciale, la lista lambda. È l'unica parola chiave insieme a lambda-macro riconosciuta durante l'analisi del codice sorgente. La parola lambda indica un tipo specializzato di lista che può essere utilizzato e applicato come una funzione o un operatore.

La parola "lambda" indica che è una lista lambda:

(length (lambda))
;-> 0

lambda non è un simbolo, le liste lambda valutano se stesse:

(lambda)
;-> (lambda)

Una lista lambda è un sottotipo del tipo lista:

(lista? (lambda))
;-> true
(lambda? (lambda))
;-> true

(first (lambda (x y z)))
;-> (x y z)

Non possiamo usare l'indicizzazione implicita:

((lambda (x y z)) 0)
;-> nil

Quando si compongono liste lambda da zero, assicurarsi di iniziare con un lista di tipo lambda, ad esempio:

(append (lambda) '((x) (+ x x)))
;-> (lambda (x) (+ x x))

Possiamo usare "set" o "define" in modo equivalente:

(set 'doppio (aggiungi (lambda) '((x) (+ x x))))
;-> (lambda (x) (+ x x))
(doppio 123)
;-> 246

Nota: al posto di "lambda" e "lambda-macro" si possono usare anche le parole "fn" e "fn-macro".

Lutz:
-----
lambda in newLISP is not a keyword like a built-in function or operator, but a special attribute of a list: a lambda list, so it could occur like this:

(lambda)
;-> (lambda )

As you can see, a lambda list evaluates to itself in newLISP and you don't need to quote it when using it as a parameter to another function.

When constructing lambda lists with 'append' or 'cons' then 'append' associates the lambda property to the right and 'cons' to the left:

(append (lambda) '((x) (+ x x)))
;-> (lambda (x) (+ x x))
(cons '(x) (lambda (+ x x)))
;-> (lambda (x) (+ x x))

The 'cons' example shows you that lambda is not the first element of a list but rather a property of that list.

(empty? (lambda))
;-> true
(lambda? (lambda))
;-> true

By definition there cannot be implicit indexing for (lambda).

(nth 0 '(lambda (x) a b c))
;-> (x)
;-> ('(lambda (x) a b c) 0)
nil

The following example shows why:
((lambda (x) (+ x x)) 1)
;-> 2

lambda is used in an applicative context/situation. Implicit indexing is giving lists or numbers functionality when using in an applicative context. For lambda expression this applicative functionality is already defined as applying the lambda expression to the arguments following it.

But there is implicit slicing for lambda:

(1 (lambda (x) (+ x x)))
;-> ((+ x x))
(0 1 (lambda (x) (+ x x)))
;-> ((x))

because now the lambda list can be treated just like a normal list.

ps: note that quoting lambda is not necessary, as lambda evaluates to itself.


---------------------------------
Addizioni e sottrazioni alternate
---------------------------------

Data una lista di numeri (a b c d e ... n) scrivere una funzione per calcolare:

  1) a + b - c + d - e + ... n
  2) a - b + c - d + e - ... n

Vediamo la soluzione proposta da Rick per risolvere il caso 1:

; Addition with alternating signs
; thanks to Rick for an improved, faster version
;
; (+- a b c d e ... n) is equivalent to
; a + b - c + d - e + ... n
;
; example:
;
; (+- 1 2 3 4 5)             => -1
; (apply +- (sequence 1 5))  => -1
; (sub (add (sub (add 1 2) 3) 4) 5) => -1

(define (+-)
 (let (signs (cons 1 (series 1 -1 (- (length (args)) 1))))
   (apply add (map mul signs (args)))))

Facciamo alcune prove:

(setq lst '(1 2 3 4 5))
(apply +- lst)
;-> -1

(setq lst '(1 -2 3 -4 5 -6))
(apply +- lst)
;-> -19

(apply +- (sequence 1 1e6))
;-> 500002

Adesso scriviamo una funzione analoga per risolvere il caso 2:

; Subtraction with alternating signs
;
; (-+ a b c d e ... n) is equivalent to
; a - b + c - d + e - ... n
;
; example:
;
; (-+ 1 2 3 4 5)             => 3
; (apply -+ (sequence 1 5))  => 3
; (add (sub (add (sub 1 2) 3) 4) 5) => 3

(define (-+)
 (let (signs (cons 1 (series -1 -1 (- (length (args)) 1))))
   (apply add (map mul signs (args)))))

Facciamo alcune prove:

(setq lst '(1 2 3 4 5))
(apply -+ lst)
;-> 3

(setq lst '(1 -2 3 -4 5 -6))
(apply -+ lst)
;-> 21

(apply -+ (sequence 1 1e6))
;-> -500000

Le funzioni sono scritte in stile LISP, ma vediamo la differenza con due versioni scritte in stile iterativo:

Versione per tipo 1:

(define (add-sub lst)
  (let (out (lst 0))
    (dolist (el (slice lst 1))
      (if (even? $idx)
          (setq out (add out el))
          (setq out (sub out el))
      )
    )
    out))

Facciamo alcune prove:

(setq lst '(1 2 3 4 5))
(add-sub lst)
;-> -1

(setq lst '(1 -2 3 -4 5 -6))
(add-sub lst)
;-> -19

(add-sub (sequence 1 1e6))
;-> 500002

Versione per tipo 2:

(define (sub-add lst)
  (let (out (lst 0))
    (dolist (el (slice lst 1))
      (if (odd? $idx)
          (setq out (add out el))
          (setq out (sub out el))
      )
    )
    out))

Facciamo alcune prove:

(sub-add (sequence 1 5))
;-> 3
(setq lst '(1 -2 3 -4 5 -6))
(sub-add lst)
;-> 21
(sub-add (sequence 1 1e6))
;-> -500000

Adesso vediamo la differenza di velocità tra le funzioni:

(time (println (apply +- (sequence 1 1e6))))
;-> 500002
;-> 112.3
(time (println (add-sub (sequence 1 1e6))))
;-> 500002
;-> 85.122

(time (println (apply -+ (sequence 1 1e6))))
;-> -500000
;-> 110.02
(time (println (sub-add (sequence 1 1e6))))
;-> -500000
;-> 83.355

In questo caso le funzioni iterative sono più veloci delle funzioni in stile LISP.


---------------------------------------------------------------
Creazione di vettori/matrici (array) e liste con valori casuali
---------------------------------------------------------------

La funzione "array" ha la seguente sintassi:

sintassi: (array int-n1 [int-n2 ... ] [list-init])

Crea una matrice con "int-n1" elementi, che può essere inizializzata (facoltativo) con il contenuto della lista "list-init". È possibile specificare fino a sedici dimensioni per le matrici multidimensionali.

Per creare matrici con valori casuali utilizziamo il parametro "list-init". Ad esempio se vogliamo creare una matrice 3x3 con valori casuali 0 e 1 possiamo scrivere:

(array 3 3 (rand 2 9))
;-> ((0 1 0) (1 1 0) (0 1 1))

Quindi il nostro problema si riduce a creare una lista con tanti numeri casuali quanti sono gli elementi della nostra matrice. Allora scriviamo una funzione che prende 4 parametri:

nums     -> numero di numeri casuali
min-val  -> valore minimo dei numeri casuali
max-val  -> valore massimo dei numeri casuali
type-num -> genera numeri interi (true) o floating (nil)

(define (random-list nums min-val max-val type-num)
  (let (out '())
    (if type-num
      ; numeri interi
      (for (i 1 nums)
        (push (+ min-val (rand (+ (- max-val min-val) 1))) out -1)
      )
      ; numeri floating
      (for (i 1 nums)
        (push (add min-val (random 0 (sub max-val min-val))) out -1)
      )
    )
    out))

Facciamo alcune prove:

(random-list 9 0 1 true)
;-> (0 0 0 1 1 1 0 0 1)

(random-list 9 0 1 nil)
;-> (0.2507095553453169 0.9622180852687154 0.7090060121463668
;->  0.6700949125644704 0.1468550675984985 0.2431409649952696
;->  0.05359050263985107 0.7868282113101596 0.206244087038789)

Adesso facciamo alcuni test per vedere se la funzione si comporta correttamente.

Creiamo una lista con un milione di elementi che vanno da -10 a 25 (estremi compresi):

(silent (setq lst (random-list 1e6 -10 25)))

Vediamo se troviamo i valori -10 e 25:

(find -10 (random-list2 1000000 -10 25))
;-> 4996
(find 25 (random-list2 1000000 -10 25))
;-> 698

Vediamo se esistono valori minori di -10 o maggiori di 25:

(filter (fn(x) (or (> x 25) (< x -10))) (random-list2 1000000 -10 25))
;-> ()

Per generare le matrici scriviamo una funzione simile:

(define (rand-matrix rows cols min-val max-val type-num)
  (let ( (out '()) (nums (* rows cols)) )
    (if type-num
      ; numeri floating
      (for (i 1 nums)
        (push (add min-val (random 0 (sub max-val min-val))) out -1)
      )
      ; numeri interi
      (for (i 1 nums)
        (push (+ min-val (rand (+ (- max-val min-val) 1))) out -1)
      )
    )
    (explode out cols)))

Proviamo:

(rand-matrix 4 5 0 1)
;-> ((0 0 1 1 0) (0 0 1 0 0) (0 1 1 1 1) (1 1 1 0 1))

(rand-matrix 3 3 0 5 true)
;-> ((2.012085329752495 1.268501846369823 0.6826990569780572)
;->  (4.275948362681967 0.3308206427198095 2.139042329172643)
;->  (2.866756187627796 1.511429181798761 2.740256965849788))


----------------------------
Alcune funzioni sugli angoli
----------------------------

Funzione di lerping tra due angoli:

(define (angle-lerp from to frac)
  (if (> (- to from) 180)
    (setq to (sub to 360)))
  (if (< (- to from) -180)
    (setq to (add to 360)))
  (add from (mul frac (sub to from))))

(angle-lerp 120 180 0.5)
;-> 150
(angle-lerp 120 180 0.4)
;-> 144
(angle-lerp -90 90 0.5)
;-> 0
(angle-lerp 1 2.2 0.1)
;-> 1.12

Funzione per sottrarre due angoli (ritorna sempre un valore da -180 a 180):

(define (angle-sub a1 a2)
  (let (a (- a1 a2))
    (while (> a 180) (-- a 360))
    (while (< a -180) (++ a 360))
    a))

(angle-sub 270 90)
;-> 180
(angle-sub 185 -345)
;-> 170

Funzione per sommare due angoli (ritorna sempre un valore da -180 a 180):

(define (angle-add a1 a2)
  (let (a (+ a1 a2))
    (while (> a 180) (-- a 360))
    (while (< a -180) (++ a 360))
    a))

(angle-add 270 90)
;-> 0
(angle-add 185 -345)
;-> -160

Funzione di normalizzazione di un angolo nell'intervallo (0 <= angolo < 360):

(define (angle-360 a)
  (while (<= a -360) (setq a (add a 360)))
  (while (>= a  360) (setq a (sub a 360)))
  a)

(angle-360 12)
;-> 12
(angle-360 3600)
;-> 0
(angle-360 3601)
;-> 1

Funzione di normalizzazione di un angolo nell'intervallo (-180 < angolo <= 180):

(define (angle-180 a)
  (setq a (angle-360 a))
  (if (> a 180) (setq a (sub a 360)))
  a)

(angle-180 359)
;-> -1
(angle-180 15637)
;-> 157
(angle-180 -15637)
;-> -157


--------------------------------
Formattazione di numeri ordinali
--------------------------------

Funzione per formattare i numeri ordinali in lingua Inglese:

; Format ordinal numbers
;
; (ordinal 3) => "3rd"
; (ordinal 4) => "4th"
; (ordinal 65) => "65th"
;
; contributed by Ted Walther, 2014
;
(define (ordinal n)
  (let (nn (string n))
    (cond
      ((regex {1[123]$} nn) (string nn "th"))
      ((regex {1$} nn) (string nn "st"))
      ((regex {2$} nn) (string nn "nd"))
      ((regex {3$} nn) (string nn "rd"))
      ((regex {[4567890]$} nn) (string nn "th"))
      (true nn))))

(for (i 1 20) (print (ordinal i) { }))
;-> 1st 2nd 3rd 4th 5th 6th 7th 8th 9th 10th
;-> 11th 12th 13th 14th 15th 16th 17th 18th 19th 20th

Funzione per formattare i numeri ordinali in lingua Italiana:

(define (ordinale n)
  (let (nn (string n))
    (cond
      ((= nn  "1") "primo")
      ((= nn  "2") "secondo")
      ((= nn  "3") "terzo")
      ((= nn  "4") "quarto")
      ((= nn  "5") "quinto")
      ((= nn  "6") "sesto")
      ((= nn  "7") "settimo")
      ((= nn  "8") "ottavo")
      ((= nn  "9") "nono")
      ((= nn "10") "decimo")
      ((> nn "10") (string nn "-esimo"))
      (true nn))))

(for (i 1 20) (print (ordinale i) { }))
;-> primo secondo terzo quarto quinto sesto settimo ottavo nono decimo
;-> 11-esimo 12-esimo 13-esimo 14-esimo 15-esimo
;-> 16-esimo 17-esimo 18-esimo 19-esimo 20-esimo

(ordinale 77)
;-> "77-esimo"
(ordinale "77")
;-> "77-esimo"
(ordinale "pippo")
;-> "pippo-esimo"


-----------------------------------------------
Programmazione Funzionale e Pensiero Funzionale
-----------------------------------------------

La definizione teorica/standard della Programmazione Funzionale è la seguente:

Programmazione Funzionale (PF)
------------------------------
1. un paradigma di programmazione caratterizzato dall'uso di "funzioni matematiche" ed evitare "effetti collaterali"
2. uno stile di programmazione che utilizza solo funzioni pure senza "effetti collaterali"

Functional Programming (FP)
---------------------------
1. a programming paradigm characterized by the use of "mathematical functions" and the avoidance of "side effects"
2. a programming style that uses only "pure functions" without "side effects"

Gli "effetti collaterali" (side effects) sono qualsiasi cosa una funzione fa oltre a restituire a valore, come un operazione di I/O o la modifica di uno stato globale.
Questo può generare problemi perché gli effetti collaterali si verificano ogni volta che la funzione viene chiamata. In genere abbiamo bisogno solo del valore di ritorno e non degli effetti collaterali (che quindi creano comportamenti indesiderati). Lo stile di programmazione funzionale tende ad evitare gli effetti collaterali (o quanto meno ridurli al minimo).

Le "funzioni pure" sono funzioni i cui valori di ritorno dipendono solo dai loro argomenti e non hanno effetti collaterali.
Dati gli stessi argomenti, produrranno sempre lo stesso valore di ritorno. Il termine "funzioni matematiche" viene utilizzato per distinguerle dalle funzioni integrate del linguaggio. Lo stile di programmazione funzionale preferisce l'uso delle funzioni pure perché sono più facili da capire e controllare.

La programmazione funzionale "pura" è molto importante in ambito accademico (es. lambda calcolo), ma non è adatta per applicazioni pratiche. Lo stile di programmazione funzionale "pratico" deve utilizzare gli effetti collaterali e le funzioni impure (cercando di minimizzarli).
Vediamo come affrontare questi problemi:

1) FP ha bisogno di effetti collaterali
La definizione aferma che FP evita gli effetti collaterali, ma gli effetti collaterali sono il motivo per cui eseguiamo il nostro programma. A cosa serve un software di elaborazione testi se non salva i documenti? La definizione indica di evitare completamente gli effetti collaterali, mentre ne abbiamo la necessità in alcuni casi.

2) FP è in grado di gestire gli effetti collaterali
Gli effetti collaterali sono necessari ma problematici, quindi la FP mette a disposizione molti strumenti per lavorare con loro. Inoltre la definizione implica l'utilizzo esclusivo di funzioni pure. Al contrario, occorre utilizzare anche le funzioni impure. Esistono molte tecniche funzionali che le rendono più facili da usare.

3) FP è pratica
La definizione fa sembrare FP come se fosse principalmente matematica è poco pratica per il software del mondo reale. Invece ci sono molti importanti programmi scritti utilizzando la programmazione funzionale.

In definitiva, la programmazione funzionale pratica non è (esattamente) quella della definizione di FP riportata all'inizio.

Comunque i concetti più importanti della FP possono essere applicati anche alla programmazione orientata agli oggetti e alla programmazione procedurale in (quasi) tutti i linguaggi di programmazione.

Dal punto di vista funzionale è fondamentale distinguere nel software da sviluppare le seguenti categorie: azioni, calcoli e dati.

1. Azioni
Tutto ciò che dipende da quando viene eseguito o da quante volte viene eseguito, o entrambi, è un'azione.

2. Calcoli
I calcoli sono le computazioni che trasforma un input in un output. I calcoli devono sempre restituire gli stessi output con gli stessi input. Possiamo eseguirli quando e come vogliamo senza modificare nulla al di fuori di loro. Questo li rende sicuri e facili da testare.

3. Dati
I dati sono fatti o misure registratidi determinati fenomeni (cose o eventi). Distinguiamo i dati perché non sono complessi come il codice eseguibile e hanno delle proprietà ben definite. I dati sono interessanti perché hanno significato anche senza essere "eseguiti". In genere ogni dato può essere interpretato in più modi.

I programmatori funzionali identificano queste categorie quando esaminano il codice di un programma
I programmatori funzionali preferiscono i dati ai calcoli e preferiscono i calcoli alle azioni.

FP dispone di strumenti per la gestione di ogni categoria:

1. Azioni
- Strumenti per cambiare lo stato in sicurezza nel tempo
- Modi per garantire l'ordine delle operazioni
- Strumenti per garantire che le azioni avvengano esattamente una sola volta

2. Calcoli
- Analisi statica per favorire la correttezza
- Strumenti matematici che funzionano bene con la FP
- Strategie di test

3. Dati
- Modi per organizzare i dati per un accesso efficiente
- Regole per mantenere i record a lungo termine
- Principi per trattare ed catturare il significato dei dati

Il pensiero funzionale
----------------------
Il pensiero funzionale è l'insieme di abilità e idee che i programmatori funzionali usano per risolvere i problemi con il software.
Le idee fondamentali nella programmazione funzionale sono:

1) distinguere azioni, calcoli e dati e

2) usare astrazioni di prima classe.

Queste non sono le uniche idee in FP, ma forniscono una base solida e pratica su cui costruire.

1) Distinguere azioni, calcoli e dati
I programmatori funzionali separano tutto il codice in una delle tre categorie: azioni, calcoli o dati (anche se i termini potrebbero essere diversi). Queste categorie corrispondono alla difficoltà di comprendere, testare e riutilizzare il codice.

2) Utilizzo di astrazioni di prima classe
I programmatori di ogni tipo scrivono funzioni generali per poterle riutilizzare. I programmatori funzionali fanno lo stesso, ma spesso possono riutilizzare più funzioni passando le funzioni ad altre funzioni. L'idea sembra strana, ma è estremamente pratica.

Le tecniche utilizzate da un progammatore funzionale devono avere le seguenti caratteristiche:

1) Non devono basarsi su caratteristiche specifiche del linguaggio
Ci sono molti linguaggi di programmazione funzionali che supportano direttamente alcune di queste tecniche (linguaggi tipizzati, omoiconici, ecc.), ma occorre sviluppare le abilità che sono indipendenti dalle caratteristiche linguistiche. Comunque occorre sfruttare anche tutte le facilitazioni che mette a disposizione il linguaggio utilizzato.

2) Devono avere un beneficio pratico immediato
La FP è utilizzato sia nell'industria che nel mondo accademico. Il mondo accademico produce la teoria e sviluppa idee nuove, ma a livello pratico abbiamo bisogno di tecniche pratiche e utili.

3) Devono poter essere applicate indipendentemente dalla situazione attuale del codice
I programmatori non iniziano solo progetti nuovi, spesso devono analizzare e mantenere codice di progetti esistenti. Queste tecniche devono aiutarci, indipendentemente dalla nostra situazione. Non occorre sempre effettuare una riscrittura funzionale, ma fare scelte pragmatiche e lavorare con il codice che abbiamo.

Funzioni pure e impure
----------------------
Le funzioni pure assomigliano molto alle funzioni matematiche: non fanno altro che calcolare un valore di output in base ai loro valori di input.

a) Funzioni pure
- L'output dipende interamente dagli argomenti di input.
- Non causa effetti collaterali.

b) Funzioni impure
- Fattori diversi dagli argomenti di input possono influire sull'output.
- Può causare effetti collaterali.

Per chiarire questa definizione, dobbiamo definire esattamente cosa sia un effetto collaterale. Si dice che una funzione ha effetti collaterali se esegue una delle seguenti operazioni:

1) Modifica lo stato globale
"Globale" qui indica qualsiasi stato visibile al di fuori dell'ambito della funzione. Ad esempio, un campo di istanza privata è considerato globale perché è visibile da tutti i metodi all'interno della classe.

2) Modifica i suoi argomenti di input: gli argomenti passati dal chiamante sono effettivamente lo stato che una funzione condivide con il suo chiamante: se una funzione muta uno dei suoi argomenti, questo è un effetto collaterale visibile al chiamante.

3) Genera eccezioni: è possibile ragionare su funzioni pure isolate, tuttavia, se una funzione genera eccezioni, il risultato della sua chiamata dipende dal contesto, cioè, differisce a seconda che la funzione venga chiamata in un try/catch.

4) Esegue qualsiasi operazione di I/O: include qualsiasi interazione tra il programma e il mondo esterno, inclusa la lettura o la scrittura sulla console, il filesystem o un database, e l'interazione con qualsiasi processo al di fuori del confine dell'applicazione.

In sintesi, le funzioni pure non hanno effetti collaterali e il loro output è determinato esclusivamente dai loro input.

Si noti che entrambe le condizioni devono valere:
a) Una funzione che non ha effetti collaterali può essere ancora impura, vale a dire, se legge da uno stato mutevole globale, allora il suo output è influenzato da fattori diversi dal suo input.
b) Una funzione il cui output dipende interamente dai suoi input può anche essere impura, infatti potrebbe comunque avere effetti collaterali.

La natura deterministica delle funzioni pure (cioè il fatto che restituiscono sempre lo stesso output per lo stesso input) ha alcune conseguenze interessanti. Le funzioni pure sono facili da testare e da analizzare.

Inoltre, il fatto che gli output dipendano solo dagli input significa che l'ordine di valutazione non è importante. Sia che valutiamo il risultato di una funzione ora o in un secondo momento, il risultato non cambierà. Ciò significa che le parti del programma costituite interamente da funzioni pure possono essere ottimizzate in diversi modi:

  - Parallelizzazione: thread diversi eseguono attività in parallelo
  - Valutazione pigra (lazy): valuta i valori solo se necessario
  - Memoizzazione: memorizza nella cache il risultato di una funzione in modo che venga calcolato una sola volta

D'altra parte, l'uso di queste tecniche con funzioni impure può portare a bug piuttosto complicati da trovare. Per questi motivi, FP preferisce ed utilizza le funzioni pure quando possibile.

Valori immutabili
----------------
La programmazione funzionale è la programmazione che utilizza funzioni pure che manipolano valori immutabili.
Se le funzioni pure costituiscono il motore dei programmi funzionali, i valori immutabili sono il suo carburante.
Com'è possibile scrivere applicazioni completamente funzionanti usando solo funzioni e valori puri che non possono mai cambiare?

La risposta breve è: le funzioni pure stanno facendo copie di dati e le trasmettono. Abbiamo bisogno di costrutti specifici nel linguaggio per poter programmare facilmente usando le copie.

Significato e tipi di concorrenza
--------------------------------
La concorrenza è il concetto generale di avere più cose che accadono contemporaneamente.
Più formalmente, la concorrenza è quando un programma avvia un'attività prima che un altra sia stata completata, in modo che le diverse attività vengano eseguite in finestre temporali sovrapposte.
Esistono diversi scenari in cui può verificarsi la concorrenza:

- Asincrono: significa che il programma esegue operazioni non bloccanti.
Ad esempio, può avviare una richiesta per una risorsa remota tramite HTTP e quindi svolgere un'altra attività mentre attende la ricezione della risposta.

- Parallelismo: significa che il tuo programma sfrutta l'hardware multicore per eseguire contemporaneamente i compiti del lavoro (che vengono eseguiti ciascuno su un core separato.

- Multithreading: questa è un'implementazione software che consente a diversi thread di
essere eseguito contemporaneamente. Un programma multithread sembra che stia facendo diverse cose allo stesso tempo anche quando è in esecuzione su una macchina single-core.

----------------------------------------------------------------------------

Cos'è la programmazione funzionale?
-----------------------------------
La programmazione funzionale (chiamata anche FP) è un modo di pensare alla costruzione del software creando funzioni pure. Cerca di evitare i concetti di stati condivisi e dati mutevoli che troviamo nella programmazione orientata agli oggetti.

I linguaggi funzionali si basa su espressioni e dichiarazioni piuttosto che sull'esecuzione di istruzioni. Pertanto, a differenza di altre procedure che dipendono da uno stato locale o globale, l'output del valore in FP dipende solo dagli argomenti passati alla funzione.

Caratteristiche della programmazione funzionale
-----------------------------------------------
Il metodo di programmazione funzionale si concentra sui risultati, non sul processo.
L'enfasi è su ciò che deve essere calcolato.
I dati sono immutabili (quasi tutti).
La Programmazione funzionale scompone il problema in "funzioni".
Si basa sul concetto di funzioni matematiche che utilizza espressioni condizionali e ricorsione per eseguire i calcoli.
Non supporta l'iterazione come le istruzioni di ciclo e le istruzioni condizionali come If-Else (ma alcuni linguaggi funzionali li supportano).

La base per la programmazione funzionale è il Lambda Calcolo. È stato sviluppato negli anni '30 per lo studio delle funzioni ricorsive.
Il LISP, progettato da Mccarthy negli anni '60, è stato il primo linguaggio di programmazione funzionale (anche se non è puro).
L'obiettivo di qualsiasi linguaggio FP è imitare le funzioni matematiche. Tuttavia, il processo di base del calcolo è diverso nella programmazione funzionale. Attualmente esistono molti linguagi funzionali (puri e non):

- LISP
- ML/OCaml
- Clojure
- Scala
- Scheme
- Haskell
- F#
- PureScript
- Erlang
- ecc.

La Programmazione Funzionale si basa su diversi concetti fondamentali:

Dati immutabili
---------------
Dati immutabili significa che dovremmo essere in grado di creare facilmente strutture di dati invece di modificare quelle già esistenti.

Trasparenza referenziale
------------------------
I programmi funzionali dovrebbero eseguire operazioni come se fosse sempre la prima volta. In questo modo è più facile controllare cosa accadde durante l'esecuzione del programma e i suoi effetti collaterali (trasparenza referenziale).

Modularità
----------
Il design modulare aumenta la produttività. I moduli piccoli (funzioni) possono essere codificati rapidamente e hanno maggiori possibilità di riutilizzo, il che porta sicuramente a uno sviluppo più rapido dei programmi. A parte questo, i moduli possono essere testati separatamente, il che aiuta a ridurre il tempo per il test e il debug.

Manutenibilità
--------------
Manutenibilità è un termine semplice che significa che la programmazione FP è più facile da mantenere in quanto non è necessario preoccuparsi di modificare accidentalmente qualcosa al di fuori della funzione stessa.

Funzione di prima classe
------------------------
"Funzione di prima classe" è una definizione, attribuita a quelle entità del linguaggio che non hanno restrizioni sul loro utilizzo. Pertanto, le funzioni di prima classe possono apparire ovunque nel programma.

Chiusura (Closure)
------------------
La chiusura è una funzione interna che può accedere alle variabili della funzione genitore, anche dopo che la funzione genitore è stata eseguita.

Funzioni di ordine superiore
----------------------------
Le funzioni di ordine superiore accettano altre funzioni come argomenti o le restituiscono come risultati.
Le funzioni di ordine superiore consentono applicazioni parziali o curry. Questa tecnica applica una funzione ai suoi argomenti uno alla volta, poiché ogni applicazione restituisce una nuova funzione che accetta l'argomento successivo.

Funzione pura
-------------
Una "funzione pura" è una funzione il cui risultato dipende solo dai suoi parametri. Inoltre, restituisce sempre lo stesso output per i gli stessi parametri di input. Una funzione pura non ha effetti collaterali.

Esempio:
(define (pure x y) (add x y))

Funzioni impure
---------------
Nelle funzioni impure l'output non dipende solo dai suoi argomenti e/o produce effetti collaterali. Le funzioni impure non possono essere utilizzate o testate isolatamente poiché hanno dipendenze.

Esempio:
(setq z 10)
(define (impura) (add z 10))

Composizione della funzioni
---------------------------
La composizione delle funzioni combina 2 o più funzioni per crearne una nuova.

Effetti collaterali
-------------------
Gli effetti collaterali sono qualsiasi cambiamento di stato che si verifica al di fuori di una funzione chiamata. L'obiettivo principale di qualsiasi linguaggio di programmazione FP è ridurre al minimo gli effetti collaterali, separandoli dal resto del codice del software. Nella programmazione FP è fondamentale eliminare gli effetti collaterali dal resto della logica del programma.

Vantaggi della programmazione funzionale
----------------------------------------
Consente di evitare alcuni errori nel codice
Facilita il test e il debug del programma
Permette l'elaborazione parallela e la concorrenza
Offre una migliore modularità con un codice più breve
Aumenta la produttività dello sviluppatore
Permette la nidificazione delle funzioni
Supporta costrutti funzionali come Lazy, Map, ecc.
Permette un uso efficace del Lambda Calcolo

Mi fermo qui, per chi vuole imparare a programmare in modo funzionale (pratico) consiglio i seguenti libri:
"Grokking Simplicity" di Eric Normand e "Grokking Functional Programming" di Michal Plachta.

Nota: newLISP non è un linguaggio di programmazione funzionale "puro". Si tratta di un mix tra programmazione iterativa e programmazione funzionale (con un pò di programmazione ad oggetti - FOOP).

Vedi anche "Le caratteristiche di un linguaggio funzionale" su "Note libere 22".


----------------------------------
Unione di liste di attributi (zip)
----------------------------------

Supponiamo di avere le seguenti liste di attributi:

(setq nomi '(massimo eva roby luna))
(setq eta '(50 20 40 1))
(setq peso '(80 45 50 18))
(setq altezza '(180 175 165 120))

L'indice i-esimo delle liste contiene il record i-esimo, per esempio il record 0 vale:

(massimo 50 80 180)

Scrivere una funzione prende tutte le liste di attributi e crea una lista con tutti i record.
Il numero di attributi deve essere uguale per tutte le liste di attributi.

(define (build)
  (local (out num-records))
  (setq out '())
  ; Il numero di records è il numero di attributi
  ; di ogni lista
  (setq num-records (length (args 0)))
  ; crea una lista con num-records liste vuote
  (setq out (dup '() num-records))
  (dolist (lst (args))
    (dolist (el lst)
      ; inserisce l'attributo nel record
      (push (lst $idx) (out $idx) -1)
    )
  )
  out)

Facciamo alcune prove:

(build '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(build '(1 2 3) '(a b c) '(A B C))
;-> ((1 a A) (2 b B) (3 c C))

(build '(1 2) '(a b) '(A B))
;-> ((1 a A) (2 b B))

(build nomi eta peso altezza)
;-> ((massimo 50 80 180) (eva 20 45 175) (roby 40 50 165) (luna 1 18 120))

La funzione produce i risultati voluti.

Se interpretiamo l'input come una matrice, ad esempio '(1 2 3) '(a b c), possiamo notare che il risultato ottenuto è la matrice trasposta dell'input:

input         output = trasposta(input)

|1 2 3|       |1 a|
|a b c|  ==>  |2 b|
              |3 c|

Allora possiamo utilizzare la funzione integrata "transpose" per scrivere una funzione molto più semplice ed elegante:

; Multiple list zipper
; Transpose multiple lists into one
; written by Nigel et altri
(define (zip) (transpose (args)))

(zip '(1 2 3) '(a b c))
;-> ((1 a) (2 b) (3 c))

(zip '(1 2 3) '(a b c) '(A B C))
;-> ((1 a A) (2 b B) (3 c C))

(zip '(1 2) '(a b) '(A B))
;-> ((1 a A) (2 b B))

(zip nomi eta peso altezza)
;-> ((massimo 50 80 180) (eva 20 45 175) (roby 40 50 165) (luna 1 18 120))

Per effettuare l'operazione opposta, cioè prendere una lista di record e creare le relative liste di attributi, basta utilizzare la funzione "apply":

(zip '(1 2 3) '(a b c) '(x y z))
;-> ((1 a x) (2 b y) (3 c z))
(apply zip '((1 a x) (2 b y) (3 c z)))
;-> ((1 2 3) (a b c) (x y z))

(apply zip (zip '(1 2) '(a b)))
;-> ;-> ((1 2) (a b))


-----------------------------------------------------
net-eval e calcolo distribuito (distribute computing)
-----------------------------------------------------

La funzione "net-eval" permette di far valutare un'espressione da un server remoto.

----------------------------------------------------------------------------
syntax: (net-eval str-host int-port exp [int-timeout [func-handler]])
syntax: (net-eval '((str-host int-port exp) ... ) [int-timeout [func-handler]])

Can be used to evaluate source remotely on one or more newLISP servers. This function handles all communications necessary to connect to the remote servers, send source for evaluation, and wait and collect responses.

The expression in exp will be evaluated remotely in the environment of the target node. The exp is either a quoted expression, or it is enclosed in string delimiters. For bigger expressions [text] ... [/text] delimiters can be used instead of double quotes " ... ". Only one expression should be enclosed in the string. When more than one are specified, all will get evaluated in the target node, but only the result of the first will be returned.

The remote TCP/IP servers are started in the following way:

newlisp -c -d 4711 &

; preloading function definitions

newlisp preload.lsp -c -d 12345 &

; logging connections

newlisp -l -c -d 4711 &

; communicating via Unix local domain sockets

newlisp -c /tmp/mysocket

The -c option is necessary to suppress newLISP emitting prompts.

The -d daemon mode allows newLISP to maintain state between connections. When keeping state between connections is not desired, the inetd daemon mode offers more advantages. The Internet inetd or xinetd services daemon will start a new newLISP process for each client connection. This makes for much faster servicing of multiple connections. In -d daemon mode, each new client request would have to wait for the previous request to be finished. See the chapter inetd daemon mode on how to configure this mode correctly.

Instead of 4711, any other port number can be used. Multiple nodes can be started on different hosts and with the same or different port numbers. The -l or -L logging options can be specified to log connections and remote commands.

In the first syntax, net-eval talks to only one remote newLISP server node, sending the host in str-host on port int-port a request to evaluate the expression exp. If int-timeout is not given, net-eval will wait up to 60 seconds for a response after a connection is made. Otherwise, if the timeout in milliseconds has expired, nil is returned; else, the evaluation result of exp is returned.

; the code to be evaluated is given in a quoted expression
(net-eval "192.168.1.94" 4711 '(+ 3 4))       → 7

; expression as a string (only one expression should be in the string)
(net-eval "192.168.1.94" 4711 "(+ 3 4)")      → 7

; with timeout
(net-eval "192.168.1.94" 4711 '(+ 3 4) 1)     → nil  ; 1ms timeout too short
(net-error)                                   → (17 "ERR: Operation timed out")

(net-eval "192.168.1.94" 4711 '(+ 3 4) 1000)  → 7

; program contained in a variable
(set 'prog '(+ 3 4))
(net-eval "192.168.1.94" 4711 prog)           → 7

; specify a local-domain Unix socket (not available on MS Windows)
(net-eval "/tmp/mysocket" 0 '(+ 3 4))         → 7

The second syntax of net-eval returns a list of the results after all of the responses are collected or timeout occurs. Responses that time out return nil. The last example line shows how to specify a local-domain Unix socket specifying the socket path and a port number of 0. Connection errors or errors that occur when sending information to nodes are returned as a list of error numbers and descriptive error strings. See the function net-error for a list of potential error messages.

; two different remote nodes different IPs
(net-eval '(
    ("192.168.1.94" 4711 '(+ 3 4))
    ("192.168.1.95" 4711 '(+ 5 6))
    ) 5000)
→ (7 11)

; two persistent nodes on the same CPU different ports
(net-eval '(
    ("localhost" 8081 '(foo "abc"))
    ("localhost" 8082 '(myfunc 123)')
    ) 3000)

; inetd or xinetd nodes on the same server and port
; nodes are loaded on demand
(net-eval '(
    ("localhost" 2000 '(foo "abc"))
    ("localhost" 2000 '(myfunc 123))
    ) 3000)

The first example shows two expressions evaluated on two different remote nodes. In the second example, both nodes run on the local computer. This may be useful when debugging or taking advantage of multiple CPUs on the same computer. When specifying 0 for the port number , net-eval takes the host name as the file path to the local-domain Unix socket.

Note that definitions of foo and myfunc must both exist in the target environment. This can be done using a net-eval sending define statements before. It also can be done by preloading code when starting remote nodes.

When nodes are inetd or xinetd-controlled, several nodes may have the same IP address and port number. In this case, the Unix daemon inetd or xinetd will start multiple newLISP servers on demand. This is useful when testing distributed programs on just one machine. The last example illustrates this case. It is also useful on multi core CPUs, where the platform OS can distribute different processes on to different CPU cores.

The source sent for evaluation can consist of entire multiline programs. This way, remote nodes can be loaded with programs first, then specific functions can be called. For large program files, the functions put-url or save (with a URL file name) can be used to transfer programs. The a net-eval statement could load these programs.

Optionally, a handler function can be specified. This function will be repeatedly called while waiting and once for every remote evaluation completion.

(define (myhandler param)
    (if param
        (println param))
)

(set 'Nodes '(
    ("192.168.1.94" 4711)
    ("192.168.1.95" 4711)
))

(set 'Progs '(
    (+ 3 4)
    (+ 5 6)
))

(net-eval (map (fn (n p) (list (n 0) (n 1) p)) Nodes Progs) 5000 myhandler)
→
("192.168.1.94" 4711 7)
("192.168.1.95" 4711 11)

The example shows how the list of node specs can be assembled from a list of nodes and sources to evaluate. This may be useful when connecting to a larger number of remote nodes.

(net-eval (list
  (list (Nodes 0 0) (Nodes 0 1) (Progs 0))
  (list (Nodes 1 0) (Nodes 1 1) (Progs 1))
 ) 3000 myhandler)

While waiting for input from remote hosts, myhandler will be called with nil as the argument to param. When a remote node result is completely received, myhandler will be called with param set to a list containing the remote host name or IP number, the port, and the resulting expression. net-eval will return true before a timeout or nil if the timeout was reached or exceeded. All remote hosts that exceeded the timeout limit will contain a nil in their results list.

For a longer example see this program: "mapreduce". The example shows how a word counting task gets distributed to three remote nodes. The three nodes count words in different texts and the master node receives and consolidates the results.

Nota: il file "mapreduce.lsp" si trova nella cartella DATA.
----------------------------------------------------------------------------

Possiamo vedere il funzionamento di "net-eval" anche su un singolo computer.

1) Esecuzione dei server TCP/IP (sul proprio computer)
  a) Aprire un command prompt e digitare: newlisp -c -d 4477
     In questo modo abbiamo lanciato un server (pc1) newlisp sulla porta 4477
  b) Aprire un altro command prompt e digitare: newlisp -c -d 5588
     In questo modo abbiamo lanciato un altro server (pc2) newlisp sulla porta 5588

2) Esecuzione del client TCP/IP (sul proprio computer)
  a) Aprire un altro command prompt e digitare: newlisp.exe
  In questo modo abbiamo lanciato il client newlisp che ci permette di dialogare con i due server (pc1 sulla porta 4477 e pc2 sulla porta 5588)

3) Definiamo due funzioni che ci permettono di valutare espressioni utilizzando i server a disposizione:

(define (do-pc1 expr) (net-eval "localhost" 4477 expr))
(define (do-pc2 expr) (net-eval "localhost" 5588 expr))

Adesso possiamo provare a valutare espressioni dai server:

(do-pc1 '(+ 1 3))
;-> 4

(do-pc2 '(setq a (+ 1 3)))
;-> 4

(do-pc2 '(+ a 2))
;-> 6

La seguente espressione inserisce codice nel server remoto pc1 (code injection):

(do-pc1 '(define (pippo a b) (pow a b)))
;-> (lambda (a b) (pow a b))
(do-pc1 '(pippo 5 3))
;-> 125

La seguente espressione inserisce codice nel server remoto pc2 (code injection):

(do-pc2 '(define (pluto a) (div (sqrt a))))
(do-pc2 '(pluto 4))
;-> 0.5

Adesso possiamo utilizzare espressioni che valutano le sotto-espressioni con i server remoti:

(max (do-pc2 '(pluto 1)) (do-pc1 '(pippo 2 1)))
;-> 2


--------------------
Numeri di Lynch-Bell
--------------------

Trova l'intero più grande in base 10 le cui cifre sono tutte diverse ed è esattamente divisibile per ciascuna delle sue singole cifre.
Questi numeri sono anche noti come numeri Lynch-Bell, cioè hanno le seguenti proprietà:

1) tutte le cifre del numero sono diverse
2) tutte le singole cifre dividono esattamente il numero
3) non compare la cifra 0 (perchè 0 non divide esattamente)

Esempio: 135 è esattamente divisibile per 1, 3 e 5.

Poichè le cifre devono essere tutte univoche, un numero in base dieci avrà al massimo 9 cifre.

Scriviamo una funzione per trovare tutti i numeri di Lynch-Bell che utilizza la forza bruta considerando che il solo ciclo "for" da 1 a 987654321 impiega circe 7 secondi:

(time (for (i 987654321 1)))
;-> (7091.53)

(define (int-lst num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (lynch-bell)
  (local (out stop digits)
    (setq out '())
    (setq stop nil)
    (for (i 987654321 1 -1)
      (setq stop nil)
      (setq digits (int-lst i))
      ; se tutte le cifre sono diverse...
      (if (= digits (unique digits))
        (begin
          ; controllo divisione esatta di tutte le cifre
          (dolist (d digits stop)
            (if (or (zero? d) (!= (% i d) 0))
                (setq stop true)
            )
          )
          ; se tutte divisioni esatte...
          (if (nil? stop)
              ; inserisce il numero corrente nella soluzione
              (push i out -1)
          )
        )
      )
    )
    out))

Lanciamo la funzione e portiamo fuori il cane (32 minuti circa):

(time (setq lb (lynch-bell)))
;-> 1925587.173 ; 32 minuti circa

(length lb)
;-> 548

Il numero cercato è il primo della lista:

(lb 0)
;-> 9867312

lb
;-> (9867312 9812376 9782136 9781632 9723168 9718632 9678312 9617832 9617328
;->  9283176 9278136 9237816 9231768 9182376 9176832 9176328 9163728 8973216
;->  8912736 8796312 8731296 8617392 8367912 8312976 8219736 8176392 8163792
;->  8123976 7921368 7916832 7916328 7892136 7891632 7863912 7861392 7839216
;->  7836192 7829136 7639128 7613928 7398216 7392168 7361928 7329168 7291368
;->  7231896 7198632 7168392 6971832 6971328 6913872 6893712 6731928 6719832
;->  6719328 6391728 6389712 6387192 6379128 6139728 3928176 3927168 3869712
;->  3867192 3817296 3816792 3796128 3768912 3712968 3678192 3619728 3298176
;->  3297168 3271968 3196872 3187296 3186792 2983176 2978136 2937816 2931768
;->  2831976 2819376 2793168 2789136 2317896 2189376 2138976 2137968 1982736
;->  1936872 1923768 1876392 1863792 1823976 1738296 1687392 1679832 1679328
;->  1382976 1376928 1372896 1369872 1293768 1289736 984312 981432 978264
;->  976248 948312 943128 941832 941328 934128 932184 931824 931248 927864
;->  923184 921384 918432 914832 914328 913824 913248 912384 897624 894312
;->  891432 873264 864312 861432 849312 846312 843912 843216 843192 842136
;->  841632 841392 836472 834912 834216 834192 832416 831624 831264 824376
;->  824136 823416 819432 816432 814632 814392 813624 813264 796824 789264
;->  783216 768432 762384 746928 742896 732816 732648 689472 684312 681432
;->  671832 671328 648312 643128 641832 641328 634872 634128 632184 631824
;->  631248 627984 623784 623184 621384 618432 614832 614328 613872 613824
;->  613248 612384 498312 493128 491832 491328 489312 486312 483912 483672
;->  483216 483192 482136 481632 481392 478632 478296 469728 468312 463128
;->  461832 461328 439128 438912 438216 438192 436128 432816 432768 432168
;->  431928 428736 428136 427896 423816 423168 421368 419832 419328 418632
;->  418392 416832 416328 413928 412368 394128 392184 391824 391248 384912
;->  384216 384192 382416 381624 381264 376824 367248 364728 364128 362184
;->  361872 361824 361248 349128 348912 348216 348192 346128 342816 342168
;->  341928 329184 328416 326184 324816 324168 321984 321864 321648 319824
;->  319248 318624 318264 316824 316248 314928 312984 312864 312648 297864
;->  293184 291384 284136 283416 281736 273168 263184 261384 248976 248136
;->  247968 243816 243768 243168 241368 239184 238416 236184 234816 234168
;->  231984 231864 231648 219384 218736 216384 214368 213984 213864 213648
;->  198432 194832 194328 193824 193248 192384 189432 186432 184632 184392
;->  183624 183264 172368 168432 167832 167328 164832 164328 163824 163248
;->  162384 149832 149328 148632 148392 146832 146328 143928 142368 139824
;->  139248 138624 138264 136824 136248 134928 132984 132864 132648 129384
;->  126384 124368 123984 123864 123648 98136 93816 93168 92736 91728 91476
;->  91368 89712 89136 87192 84672 84312 84216 82416 81936 81624 81432 81264
;->  79632 79128 78624 73962 73416 73248 73164 72184 68712 64128 62184 61824
;->  61248 48312 48216 46872 46128 43176 43128 42816 42168 41832 41328 39816
;->  39168 38472 37926 37296 37128 36792 34128 32184 31968 31896 31824 31248
;->  29736 28416 27384 26184 24816 24168 23184 21864 21784 21648 21384 19368
;->  18936 18624 18432 18264 17248 16824 16248 14832 14728 14328 13968 13896
;->  13824 13248 12864 12768 12648 12384 9864 9648 9612 9432 9324 9315 9216
;->  9162 9135 9126 8736 8496 8136 6984 6912 6432 6384 6324 6312 6192 6132
;->  4968 4932 4896 4872 4632 4392 4368 4236 4172 4128 3924 3915 3864 3816
;->  3648 3624 3612 3492 3276 3264 3216 3195 3168 3162 3126 2916 2436 2364
;->  2316 2196 2184 2136 1962 1935 1926 1824 1764 1692 1632 1395 1368 1362
;->  1326 1296 1248 1236 936 864 824 816 784 735 728 672 648 624 612 432 412
;->  396 384 324 315 312 264 248 216 184 175 168 162 135 132 128 126 124 48
;->  36 24 15 12 9 8 7 6 5 4 3 2 1)

Per migliorare la funzione possiamo fare le seguenti osservazioni (alcune sono valide solo per il calcolo del numero più grande di Lynch-Bell):

1) Il numero più grande non deve contenere la cifra 0, altrimenti la divisione non sarebbe possibile.

2) Il numero più grande non deve essere dispari, altrimenti non sarebbe divisibile per 2.

3) Il numero più grande non deve contenere la cifra 5, perchè il numero è divisibile per 5 solo se termina con 0 o con 5, ma le osservazioni 1) e 2) nopn permettono questo.

4) Il numero più grande, senza 0 e 5, vale 98764321. Il numero non è divisibile per 3 perchè la somma delle cifre vale 40 che non è divisibile per 3, quindi l'intero più grande possibile non deve utilizzare più di 7 cifre (poiché 3, 6 e 9 verrebbero eliminati). Quindi il numero più grande vale 9876432.

5) Il numero più grande deve essere divisibile per 7, 8 e 9. In questo caso il numero è anche divisibile per 2, 3, 4 e 6.

6) Il numero più grande deve essere divisibile per 7 * 8 * 9 = 504, quindi partiamo dal multiplo di 504 più vicino a 9876432, cioè 9876384:

(div 9876432 504)
;-> 19596.09523809524
(* 19596 504)
;-> 9876384

Con l'osservazione 6) possiamo scrivere una nuova funzione per calcolare tutti i numeri di Lynch-Bell:

(define (lynch-bell-fast)
  (local (out stop digits)
    (setq out '())
    (setq stop nil)
    (for (i 9876384 1 -1)
      (setq stop nil)
      (setq digits (int-lst i))
      (if (= digits (unique digits))
        (begin
          (dolist (d digits stop)
            (if (or (zero? d) (!= (% i d) 0))
                (setq stop true)
            )
          )
          (if (nil? stop)
              (push i out -1)
          )
        )
      )
    )
    out))

Vediamo il tempo di esecuzione e se le due funzioni producono lo stesso risultato:

(time (setq lbf (lynch-bell-fast)))
;-> 15823.918
(length lbf)
;-> 548
(lbf 0)
;-> 9867312
(difference lb lbf)
;-> ()

Adesso scriviamo una funzione per trovare solo il numero di Lynch-Bell più grande. Partiamo da 9876384 e procediamo all'indietro per multipli di 504 (inoltre non deve contenere la cifra 5):

(define (lynch-bell-max)
  (local (out stop num digits found)
    (setq out '())
    (setq found nil)
    (setq stop nil)
    (for (i 19596 1 -1 found)
      (setq num (* i 504))
      (setq stop nil)
      (setq digits (int-lst num))
      (if (= digits (unique digits))
        (begin
          (dolist (d digits stop)
            (if (or (zero? d) (= d 5) (!= (% num d) 0))
                (setq stop true)
            )
          )
          (if (nil? stop)
              (setq found true)
          )
        )
      )
    )
    num))

(lynch-bell-max)
;-> 9867312

(time (println (lynch-bell-max)))
;-> 1.006

I numeri di Lynch-Bell sono la sequenza OEIS A115569:
 1, 2, 3, 4, 5, 6, 7, 8, 9, 12, 15, 24, 36, 48, 124, 126, 128, 132, 135,
 162, 168, 175, 184, 216, 248, 264, 312, 315, 324, 384, 396, 412, 432,
 612, 624, 648, 672, 728, 735, 784, 816, 824, 864, 936, 1236, 1248, 1296,
 1326, 1362, 1368, 1395, 1632, 1692, 1764, 1824...

(slice (reverse (copy lbf)) 0 55)
;-> (1 2 3 4 5 6 7 8 9 12 15 24 36 48 124 126 128 132 135
;->  162 168 175 184 216 248 264 312 315 324 384 396 412 432
;->  612 624 648 672 728 735 784 816 824 864 936 1236 1248 1296
;->  1326 1362 1368 1395 1632 1692 1764 1824)


----------------------------------------------------
Algoritmo Lee - Ricerca del percorso in un labirinto
----------------------------------------------------

Dato un labirinto a forma di matrice rettangolare binaria (1 0), trovare la lunghezza del percorso più breve da un nodo sorgente a un nodo destinazione.
Possiamo muoverci solo nei nodi con valore 1 e nelle 4 direzioni alto, destra, basso e sinistra (nord, est, sud e ovest)
Quindi le mosse dal nodo (x y) possono essere:

    Alto: (x, y) --> (x – 1, y)
  Destra: (x, y) --> (x, y + 1)
  Basso:  (x, y) --> (x + 1, y)
Sinistra: (x, y) --> (x, y – 1)

L'algoritmo di Lee è una soluzione per la ricerca del percorso minimo in un labirinto basato sulla ricerca in ampiezza (BFS - Breadth–first search). Fornisce sempre una soluzione ottimale, se esiste, ma è più lento di altri algoritmi e richiede memoria per la matrice dei nodi visitati. Vediamo lo pseudo-codice dell'algoritmo:

1) Creare una coda vuota e accodare il nodo di origine con una distanza 0 dal nodo sorgente (se stesso) e contrassegnarlo come visitato.
2) Ripetere finché la coda non è vuota:
   2.1) prendere il primo nodo dalla coda
   2.2) se il nodo è la destinazione, allora stampa la soluzione e termina.
        altrimenti, per ciascuno dei 4 nodi dal nodo corrente, accodare ogni nodo valido con una distanza di +1 e contrassegnarli come visitati.
3) Se tutti i nodi della coda vengono elaborati e la destinazione non viene raggiunta, restituire nil.
   Altrimenti stampare la soluzione.

Nota che con la BFS, tutti i nodi che hanno il percorso più breve come 1 vengono visitati per primi, seguiti dai loro nodi adiacenti che hanno il percorso più breve come 1 + 1 = 2 e così via... Quindi, se raggiungiamo un nodo in BFS, il suo percorso più breve è uno più del percorso più breve del genitore. Quindi, la prima occorrenza del nodo di destinazione ci fornisce il risultato e possiamo interrompere la nostra ricerca. È impossibile che il percorso più breve esista da qualche altro nodo per la quale non abbiamo ancora raggiunto il nodo specificato. Se un tale percorso fosse stato possibile, l'avremmo già esplorato.

Funzione per stampare la matrice soluzione:

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

Funzione per verificare se un nodo è raggiungibile:

(define (valid? grid visited row col)
  (let ((len-row (length grid))
        (len-col (length (grid 0))))
    (and (>= row 0) (< row len-row) (>= col 0) (< col len-col)
         (= (grid row col) 1) (= (visited row col) -1))))

Funzione che implementa l'algoritmo di Lee:

(define (lee grid x y x-end y-end)
  (local (row col num-rows num-cols visited queue min-dist found node dist)
    ; permette di partire da una cella qualsiasi
    (if (zero? (grid x y)) (setf (grid x y) 1))
    ; liste per i quattro possibili movimenti dal nodo corrente
    (setq row '(-1 0 0 1))
    (setq col '(0 -1 1 0))
    ; matrice num-rows x num-cols
    (setq num-rows (length grid))
    (setq num-cols (length (grid 0)))
    ; matrice che tiene traccia delle celle visitate (e della distanza)
    (setq visited (array num-rows num-cols '(-1)))
    ; creazione di una coda vuota
    (setq queue '())
    ; marca la cella di partenza come visitata (distanza = 0)
    (setf (visited x y) 0)
    ; aggiunge il nodo di partenza alla coda
    (push (list x y 0) queue)
    ; lunghezza del percorso minimo dalla sorgente alla destinazione
    (setq min-dist 999999999)
    ; percorso trovato?
    (setq found nil)
    ; ciclo finché la coda è vuota (o percorso trovato)
    (while (and queue (nil? found))
      ; prende il primo nodo dalla coda e lo processa
      (setq node (pop queue))
      ; (x, y) rappresenta il nodo corrente
      ; "dist" è la distanza minima dalla sorgente
      (setq x (node 0))
      (setq y (node 1))
      (setq dist (node 2))
      ; se abbiamo raggiunto la destinazione,
      ; allora aggiorna "min-dist" e si ferma
      (cond ((and (= x x-end) (= y y-end))
             (set 'min-dist dist 'found true)
            )
            ; altrimenti
            ; controlla tutti e quattro i possibili movimenti dal nodo corrente
            ; e accoda ogni movimento valido
            (true
              (for (k 0 3)
                ; verifica se è possibile andare in posizione
                ; (x riga[k], y col[k]) dalla posizione corrente
                (if (valid? grid visited (+ x (row k)) (+ y (col k)))
                  (begin
                    ; aggiorna matrice dei nodi visitati
                    (setf (visited (+ x (row k)) (+ y (col k))) (+ dist 1))
                    ; accoda il nodo corrente
                    (push (list (+ x (row k)) (+ y (col k)) (+ dist 1)) queue)
                  )
                )
              )
            )
      )
    )
    ; valore da resitituire
    (if (= min-dist 999999999)
        ; non è possibile raggiungere la destinazione
        nil
        (begin
          ; stampa la soluzione
          (print-matrix visited)
          ; restituisce la distanza minima
          min-dist)
    )))

(setq matrix '(( 1 1 1 1 1 0 0 1 1 1 )
               ( 0 1 1 1 1 1 0 1 0 1 )
               ( 0 0 1 0 1 1 1 0 0 1 )
               ( 1 0 1 1 1 0 1 1 0 1 )
               ( 0 0 0 1 0 0 0 1 0 1 )
               ( 1 0 1 1 1 0 0 1 1 0 )
               ( 0 0 0 0 1 0 0 1 0 1 )
               ( 0 1 1 1 1 1 1 1 0 0 )
               ( 1 1 1 1 1 0 0 1 1 1 )
               ( 0 0 1 0 0 1 1 0 0 1 )))

(lee matrix 0 0 7 5)
;->   0  1  2 -1 -1 -1 -1 -1 -1 -1
;->  -1  2  3  4 -1 -1 -1 -1 -1 -1
;->  -1 -1  4 -1 -1 -1 -1 -1 -1 -1
;->  -1 -1  5  6  7 -1 -1 -1 -1 -1
;->  -1 -1 -1  7 -1 -1 -1 -1 -1 -1
;->  -1 -1  9  8  9 -1 -1 -1 -1 -1
;->  -1 -1 -1 -1 10 -1 -1 -1 -1 -1
;->  -1 16 15 12 11 12 -1 -1 -1 -1
;->  16 15 14 13 12 -1 -1 -1 -1 -1
;->  -1 -1 15 -1 -1 -1 -1 -1 -1 -1
;-> 12

(lee matrix 0 5 7 5)
;->  -1 -1 -1 -1  1  0 -1 -1 -1 -1
;->  -1 -1 -1 -1  2  1 -1 -1 -1 -1
;->  -1 -1 -1 -1  3  2  3 -1 -1 -1
;->  -1 -1 -1 -1 -1 -1  4  5 -1 -1
;->  -1 -1 -1 -1 -1 -1 -1  6 -1 -1
;->  -1 -1 -1 -1 -1 -1 -1  7  8 -1
;->  -1 -1 -1 -1 -1 -1 -1  8 -1 -1
;->  -1 -1 -1 -1 -1 11 10  9 -1 -1
;->  -1 -1 -1 -1 -1 -1 -1 10 11 12
;->  -1 -1 -1 -1 -1 -1 -1 -1 -1 13
;-> 11

(lee matrix 4 0 7 5)
;-> nil

Vedi anche "Labirinti (calcolo percorsi)" su "Problemi vari".
Vedi anche "Labirinti (Maze)" su "Note libere 3".
Vedi anche "Generazione di labirinti" su "Note libere 26"


------------
Fredkin gate
------------

La porta di Fredkin (anche porta CSWAP e porta logica conservativa) è un circuito computazionale adatto al calcolo reversibile, inventato da Edward Fredkin. È universale, il che significa che qualsiasi operazione logica o aritmetica può essere costruita interamente da Fredkin Gate. La porta di Fredkin è dispositivo con tre ingressi e tre uscite che trasmette il primo bit invariato e scambia gli ultimi due bit se, e solo se, il primo bit è 1.

La porta Fredkin di base è una porta di scambio controllato che mappa tre ingressi (C, I1, I2) su tre uscite (C, O1, O2). L'ingresso C viene mappato direttamente sull'uscita C. Se C = 0, non viene eseguito alcuno scambio: I1 mappa su O1 e I2 mappa su O2. In caso contrario, le due uscite vengono scambiate in modo che I1 venga mappato su O2 e I2 venga mappato su O1. È facile vedere che questo circuito è reversibile, cioè "si ricostruisce" quando viene eseguito all'indietro. Una porta Fredkin generalizzata nxn passa i suoi primi n−2 ingressi invariati alle uscite corrispondenti e scambia le sue ultime due uscite se e solo se i primi n−2 ingressi sono tutti 1.

La porta di Fredkin è la porta reversibile a tre bit che scambia gli ultimi due bit se, e solo se, il primo bit è 1.

Tavola di verità

  +-----------------------------+
  | Input        | Output       |
  +-----------------------------+
  | C  | I1 | I2 | C  | O1 | O2 |
  +----+----+----+----+----+----+
  | 0  | 0  | 0  | 0  | 0  |  0 |
  +----+----+----+----+----+----+
  | 0  | 0  | 1  | 0  | 0  |  1 |
  +----+----+----+----+----+----+
  | 0  | 1  | 0  | 0  | 1  |  0 |
  +----+----+----+----+----+----+
  | 0  | 1  | 1  | 0  | 1  |  1 |
  +----+----+----+----+----+----+
  | 1  | 0  | 0  | 1  | 0  |  0 |
  +----+----+----+----+----+----+
  | 1  | 0  | 1  | 1  | 1  |  0 |
  +----+----+----+----+----+----+
  | 1  | 1  | 0  | 1  | 0  |  1 |
  +----+----+----+----+----+----+
  | 1  | 1  | 1  | 1  | 1  |  1 |
  +----+----+----+----+----+----+

Ha la proprietà utile che i numeri di 0 e 1 sono conservati nella trasformazione, cioè il numero di 0 e di 1 all'ingresso sono uguali al numero di 0 e di 1 all'uscita.

La funzione per simulare la porta di Fredkin è semplice:

(define (fredkin c i1 i2)
  (cond ((= c 0) (list c i1 i2))
        ((= c 1) (list c i2 i1))))

(fredkin 1 1 0)
;-> (1 0 1)

(apply fredkin '(1 1 0))
;-> (1 0 1)

(apply fredkin (fredkin 1 1 0))
;-> (1 1 0)

La porta di Fredkin può essere definita utilizzando le funzioni booleane AND, OR, XOR e NOT:

O1     = I1 XOR S
O2     = I2 XOR S
C(out) = C(in)

dove S = (I1 XOR I2) AND C

Oppure:

O1     = (NOT C AND I1) OR (C AND I2)
O2     = (C AND I1) OR (NOT C AND I2)
C(out) = C(in)

Le funzioni booleane AND, OR, XOR e NOT possono essere definite utilizzando la porta di Fredkin:

If I2 = 0, then O2 = C AND I1.
If I2 = 1, then O1 = C OR I1.
If I1 = 0 and I2 = 1, then O2 = NOT C.

Questo fatto rende la porta di Fredkin "universale", cioè può essere usata per costruire qualunque tipo di circuito logico.


-----------------
La funzione "amb"
-----------------

****************
>>>funzione AMB
****************
sintassi: (amb exp-1 [exp-2 ... ])

Una delle espressioni exp-1 ... n viene selezionata a caso e viene restituito il risultato della sua valutazione.

(amb 'a 'b 'c 'd 'e) → uno di: a, b, c, d oppure e a caso

(dotimes (x 10) (stampa (amb 3 5 7))) → 35777535755

Internamente, newLISP utilizza la stessa funzione di rand per selezionare un numero casuale. Per generare numeri casuali in virgola mobile, utilizzare "random", "randomize" o "normal". Per inizializzare il processo di generazione di numeri pseudo casuali in un punto di partenza specifico, utilizzare la funzione "seed".

Vedaimo alcuni esempi:

(amb 1 2 3 4 5)
;-> 5
(apply amb '(1 2 3 4 5))
;-> 4

(amb (+ 1 2) (+ 2 2) (- 10 5))
;-> 4
(eval (apply amb '((+ 1 2) (+ 2 2) (- 10 5))))
;-> 3

Scriviamo una funzione che si comporta come "amb":

(define (amb-f) (nth (rand (length (args))) (args)))

(amb-f 1 2 3 4 5)
;-> 4
(apply amb-f '(1 2 3 4 5))
;-> 5

(amb-f (+ 1 2) (+ 2 2) (- 10 5))
;-> 4
(eval (apply amb-f '((+ 1 2) (+ 2 2) (- 10 5))))
;-> 5

Scriviamo una macro che si comporta come "amb":

(define-macro (amb-m) (eval (nth (rand (length (args))) (args))))

(amb-m 1 2 3 4 5)
;-> 4
(apply amb-m '(1 2 3 4 5))
;-> 2

(amb-m (+ 1 2) (+ 2 2) (- 10 5))
;-> 5
(eval (apply amb-m '((+ 1 2) (+ 2 2) (- 10 5))))
;-> 5

Adesso vediamo come applicare "amb" per risolvere il seguente puzzle.

Anna, Carla, Daniela, Beatrice, Eva e Francesca parcheggiano le rispettive automobili una di seguito all'altra lungo la strada.
Sapendo che:

  1) C non è la prima
  2) B non è l'ultima
  3) E si trova dopo A
  4) D si trova prima di F
  5) A non è l'ultima
  6) E non è la prima
  7) B non è adiacente (prima o dopo) a F
  8) D non è adiacente (prima o dopo) a E
  9) C si trova prima di D
  10) B si trova dopo D

Come sono parcheggiate le automobili?

Possiamo risolvere questo problema utilizzando la funzione non-deterministica "amb".

(define (come n)
  (local (i a b c d e f  found)
    (set 'i 1 'found nil)
    ; inizializzazione generatore random
    ; la funzione "amb" usa il generatore random
    (seed (time-of-day))
    ;(while (and (< i n) (= found nil))
    (while (< i n)
      ; genera un parcheggio random delle automobili
      (setq a (amb 1 2 3 4 5 6))
      (setq b (amb 1 2 3 4 5 6))
      (setq c (amb 1 2 3 4 5 6))
      (setq d (amb 1 2 3 4 5 6))
      (setq e (amb 1 2 3 4 5 6))
      (setq f (amb 1 2 3 4 5 6))
      ; controllo dei vincoli
      (if (and (not (= c 1))
               (not (= b 6))
               (> e a)
               (< d f)
               (not (= a 6))
               (not (= e 1))
               (not (= b (- f 1)))
               (not (= b (+ f 1)))
               (not (= d (- e 1)))
               (not (= d (+ e 1)))
               (< c d)
               (> b d)
               (= (list a b c d e f)
                  (unique (list a b c d e f))))
          (begin
            (setq found true)
            (println i ": " (list a b c d e f))
          )
      )
      (++ i)
    )
    found))

(come 100)
;-> nil
(come 10000)
;-> nil
(come 100000)
;-> 48589: (1 4 2 3 5 6)
;-> 78585: (1 4 2 3 5 6)
;-> true

Quindi la posizione delle automobili è la seguente:

  A al posto 1 |
  B al posto 4 |
  C al posto 2 |
  D al posto 3 |
  E al posto 5 |
  F al posto 6 |

+---+---+---+---+---+---+
| A | C | D | B | E | F |
+---+---+---+---+---+---+

In questo caso un modo migliore è quello di utilizzare la funzione "randomize":

(define (come2 n)
  (local (i a b c d e f)
    (setq i 1)
    ; inizializzazione generatore random
    ; la funzione "randomize" usa il generatore random
    (seed (time-of-day))
    ;(while (and (< i n) (= found nil))
    (while (< i n)
      ; genera un parcheggio random delle automobili
      (setq parc (randomize '(1 2 3 4 5 6)))
      (map set '(a b c d e f) parc)
      ; controllo dei vincoli
      (if (and (not (= c 1))
               (not (= b 6))
               (> e a)
               (< d f)
               (not (= a 6))
               (not (= e 1))
               (not (= b (- f 1)))
               (not (= b (+ f 1)))
               (not (= d (- e 1)))
               (not (= d (+ e 1)))
               (< c d)
               (> b d))
          (println i ": " (list a b c d e f))
      )
      (++ i)
    )))

(come2 100)
;-> 100
(come2 1000)
;-> 375: (1 4 2 3 5 6)
;-> 1000
(come2 1000)
;-> 40: (1 4 2 3 5 6)
;-> 323: (1 4 2 3 5 6)
;-> 570: (1 4 2 3 5 6)
;-> 683: (1 4 2 3 5 6)
;-> 1000

Adesso vediamo come utilizzare la funzione "amb" per trovare il percorso in un labirinto.
Si tratta di un algoritmo simile alla "passeggiata dell'ubriaco":

1) iniziamo dalla posizione di partenza
2) spostarsi in una delle 4 direzioni possibili (nord, est, sud, ovest)
3) se abbiamo raggiunto la destinazione, allora ci fermiamo.
   Altrimenti continuare al passo 2).

Possiamo muoverci solo nelle celle che hanno valore 1 nella matrice che rappresenta il labirinto.

Funzione che implementa l'algoritmo:

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

(define (valid? grid row col)
  (let ((len-row (length grid))
        (len-col (length (grid 0))))
    (and (>= row 0) (< row len-row) (>= col 0) (< col len-col)
         (= (grid row col) 1))))

(define (blind grid x y x-end y-end iter)
  (local (num-rows num-cols visited found passi)
    ; permette di partire da una cella qualsiasi
    (if (zero? (grid x y)) (setf (grid x y) 1))
    ; matrice num-rows x num-cols
    (setq num-rows (length grid))
    (setq num-cols (length (grid 0)))
    ; matrice che tiene traccia delle celle visitate (quante volte)
    (setq visited (array num-rows num-cols '(0)))
    ; marca la cella di partenza come visitata una volta
    (setf (visited x y) 1)
    ; percorso trovato?
    (setq found nil)
    (setq passi 0)
    ; ciclo finché la coda è vuota (o percorso trovato)
    (while (and (not found) (<= passi iter))
      (setq dir (amb 1 2 3 4))
      (cond ((= dir 1) (setq xp x)       (setq yp (+ y 1))) ; nord
            ((= dir 2) (setq xp (+ x 1)) (setq yp y)) ; est
            ((= dir 3) (setq xp x)       (setq yp (- y 1))) ; sud
            ((= dir 4) (setq xp (- x 1)) (setq yp y)) ; ovest
      )
      ; se mossa valida, allora ci spostiamo
      ; e aggiorniamo la matrice delle celle visitate
      (if (valid? grid xp yp)
        (begin
          (setq x xp)
          (setq y yp)
          (++ (visited x y))
          (++ passi)
        )
      )
      ; destinazione raggiunta?
      (if (and (= x x-end) (= y y-end)) (setq found true))
    )
    (print-matrix visited)
    (list found passi)))

Proviamo con un labirinto semplice:

(setq test '((1 1 1 0)
             (0 1 0 1)
             (0 1 1 1)
             (1 0 0 1)))

(blind test 0 0 2 3 1000)
;->  6 10  1  0
;->  0  6  0  0
;->  0  3  1  1
;->  0  0  0  0
;-> (true 27)

Aumentiamo le dimensioni del labirinto:
                ;start
(setq matrix '(( 1 1 1 1 1 0 0 1 1 1 )
               ( 0 1 1 1 1 1 0 1 0 1 )
               ( 0 0 1 0 1 1 1 0 0 1 )
               ( 1 0 1 1 1 0 1 1 0 1 )
               ( 0 0 0 1 0 0 0 1 0 1 )
               ( 1 0 1 1 1 0 0 1 1 0 )
               ( 0 0 0 0 1 0 0 1 0 1 )
               ( 0 1 1 1 1 1 1 1 0 0 )
               ( 1 1 1 1 1 0 0 1 1 1 )
               ( 0 0 1 0 0 1 1 0 0 1 )))

(blind matrix 0 0 7 5 1000)
;->  3 4 2 1 1 0 0 0 0 0
;->  0 1 6 1 2 0 0 0 0 0
;->  0 0 6 0 3 0 0 0 0 0
;->  0 0 4 5 4 0 0 0 0 0
;->  0 0 0 1 0 0 0 0 0 0
;->  0 0 0 1 1 0 0 0 0 0
;->  0 0 0 0 1 0 0 0 0 0
;->  0 0 0 0 1 1 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0
;->  0 0 0 0 0 0 0 0 0 0
;-> (true 48) ; che fortuna!!!

(blind matrix 0 0 7 5 1000)
;->  22 66 63 56 43  0  0  0  0  0
;->   0 45 74 49 89 47  0  0  0  0
;->   0  0 26  0 58 51 17  0  0  0
;->   0  0 17 23 24  0 10  4  0  0
;->   0  0  0 15  0  0  0  0  0  0
;->   0  0  4 13  7  0  0  0  0  0
;->   0  0  0  0  6  0  0  0  0  0
;->   0  4  1  5  5  1  0  0  0  0
;->   1  8  6  5  1  0  0  0  0  0
;->   0  0  1  0  0  0  0  0  0  0
;-> (true 866)


Vediamo la velocità della funzione:

(time (blind matrix 0 0 7 5 1000))
;-> 2.991
(time (blind matrix 0 0 7 5 1000))
;-> 1.994
(time (blind matrix 0 0 7 5 1000))
;-> 4.987
(time (blind matrix 0 0 7 5 1000))
;-> 2.274
(time (blind matrix 0 0 7 5 1000))
;-> 2.671
(time (blind matrix 0 0 7 5 1000))
;-> 3.268

Aumentiamo il labirinto:

(setq big '((1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 1)
            (0 1 1 1 1 1 0 1 0 1 0 1 1 1 1 1 0 1 0 1 0 1 1 1 1 1 0 1)
            (0 0 1 0 1 1 1 0 0 1 0 0 1 0 1 1 1 0 0 1 0 0 1 0 1 1 1 0)
            (1 0 1 1 1 0 1 1 0 1 1 0 1 1 1 0 1 1 0 1 1 0 1 1 1 0 1 1)
            (0 0 0 1 0 0 0 1 0 1 0 0 0 1 0 0 0 1 0 1 0 0 0 1 0 0 0 1)
            (1 0 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1)
            (0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 0 1)
            (0 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1)
            (1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 1 0 0 1 1)
            (0 0 1 0 0 1 1 0 0 1 0 0 1 0 0 1 1 0 0 1 1 1 1 1 0 0 1 1)
            (1 1 1 1 1 0 0 1 1 1 1 1 1 1 1 0 0 1 1 1 1 1 1 0 0 1 1 0)
            (0 1 1 1 1 1 0 1 0 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 1 1 1)
            (0 0 1 0 1 1 1 0 0 0 0 0 1 0 1 1 1 0 0 0 1 0 1 1 1 0 1 1)
            (1 0 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0)
            (0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0)
            (1 0 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 1 0 0 1 1 0)
            (0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 1 1 0)
            (0 1 1 1 1 1 1 1 0 1 0 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 1)
            (0 1 1 1 1 1 0 1 0 1 0 1 1 1 1 1 0 1 0 1 1 1 1 1 0 1 1 1)
            (0 0 1 0 1 1 1 0 0 0 0 0 1 0 1 1 1 0 0 0 1 0 1 1 1 0 1 1)
            (1 0 1 1 1 0 1 1 1 0 1 0 1 1 1 0 1 1 1 0 1 1 1 0 1 1 1 0)
            (0 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0)
            (1 0 1 1 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 0 1 1 1 0 0 1 1 0)
            (0 0 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 1 0 0 0 0 1 0 0 1 1 1)))

(blind big 0 0 23 27 10000)
;-> (nil 10001)

(blind big 0 0 23 27 100000)
;->  16  44  46  42  23   0   0   2   3   6   5  12  20  43  36   0   0  29  27  49  44  81  75  64  41   0   0   0
;->   0  33  61  44  62  30   0   1   0   0   0   9  23  41  66  24   0  16   0  34   0  59 112  73  87  36   0   0
;->   0   0  27   0  54  41  16   0   0   0   0   0  13   0  39  31  23   0   0  40   0   0  54   0  50  45  30   0
;->   0   0  20  62  49   0  11  11   0   0   0   0  14  24  20   0  25  30   0  58  15   0  38  40  24   0  29  18
;->   0   0   0  50   0   0   0   9   0   0   0   0   0  15   0   0   0  34   0  24   0   0   0  16   0   0   0  13
;->   0   0  24  59  18   0   0   4   0   0   0   0   7  19  13   0   0  50  15   0   0   0  12  27  24   0   0  18
;->   0   0   0   0  10   0   0   2   0   0   0   0   0   0  18   0   0  38   0   0   0   0   0   0  34   0   0  21
;->   0   0   1   3   8   6   5   7   0   0   0  15  22  26  45  36  45  66   0   0   0  72 101  75  66  47  47  33
;->   4   5   2   5   5   0   0  12  17  28  15  22  21  14  19   0   0  48  41  74  97 116 122  83   0   0  33  37
;->   0   0   0   0   0   0   0   0   0  26   0   0  12   0   0   0   0   0   0  77 114 107 115  59   0   0  25  19
;->   0   0   0   0   0   0   0  17  22  52  20  24  17   8   3   0   0  39  46  91  99 102  64   0   0  25  30   0
;->   0   0   0   0   0   0   0   6   0  14   0  17  18   8   5   2   0  19   0  42  85  60  81  42   0  23  51  39
;->   0   0   0   0   0   0   0   0   0   0   0   0   9   0   4   2   0   0   0   0  65   0  73  66  37   0  48  40
;->   0   0   0   0   0   0   0   0   0   0   0   0   6  10   5   0   0   0   0   0  82  94  55   0  41  57  32   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   6   0   0   0   0   0   0   0  50   0   0   0  35   0   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   4   5   0   0   0   0   0   0  34  84  43   0   0  53  30   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  32   0   0  39  37   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  16  30  40  54  45  27  39  38  23
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  17  43  37  50  39   0  18  33  45
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  24   0  41  36  21   0  24  29
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  24  43  28   0  24  29  18   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  28   0   0   0  17   0   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  23  59  46   0   0  19  12   0
;->   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0   0  25   0   0  15  16   1
;-> (true 8688)

(time (blind big 0 0 23 27 100000))
;-> 44.293
(time (blind big 0 0 23 27 100000))
;-> 129.206
(time (blind big 0 0 23 27 100000))
;-> 74.92400000000001
(time (blind big 0 0 23 27 100000))
;-> 37.808
(time (blind big 0 0 23 27 100000))
;-> 98.779

Quando il "caso" è veloce, allora (quasi) tutto è possibile.


-------------------------------------------------------------
Numeri con somma uguale delle cifre con indice pari e dispari
-------------------------------------------------------------

Trovare tutti i numeri con n cifre (n = 2..9) (da 10 a 999999999) che hanno la somma delle cifre degli indici pari uguale alla somma delle cifre degli indici dispari.

Proviamo a risolvere il problema con la forza bruta (ciclo da 1 a n).

Funzione che restituisce "true" se la somma delle cifre con indice dispari è uguale alla somma delle cifre con indice pari:

(define (sum-equal-odd-even? num)
  (let ((diff 0) (flip true))
    (while (!= num 0)
      (if flip
          (++ diff (% num 10))
          (-- diff (% num 10))
      )
      (setq flip (not flip))
      (setq num (/ num 10))
    )
    ; se diff vale 0, allora le somme pari e dispari sono uguali
    (zero? diff)))

(equal-sum-odd-even? 21032)
;-> true

Funzione che calcola tutti i numeri con somma uguale fino a un determinato numero di cifre:

(define (sum-equal num-digits)
  (local (iter out)
    (setq out '())
    ; calcola il limite superiore
    ; se num-digits = 4, allora iter = 9999
    (setq iter (int (dup "9" num-digits)))
    (for (i 1 iter)
      (if (sum-equal-odd-even? i)
          (push i out -1)
      )
    )
    out))

(time (setq num4 (sum-equal 4)))
;-> 8.976000000000001
(length num4)
;-> 669 ; sono compresi anche i numeri con 2 e 3 cifre
(time (setq num5 (sum-equal 5)))
;-> 96.387
(length num5)
;-> 4839
(time (setq num6 (sum-equal 6)))
;-> 1142.292
(length num6)
;-> 55251

Vediamo i primi 10 numeri con 6 cifre:

(find 100001 num6)
;-> 4839
(slice num6 4839 10)
;-> (100001 100012 100023 100034 100045 100056 100067 100078 100089 100100)

(time (setq num7 (sum-equal 7)))
;-> 13012.137
(length num7)
;-> 436974

(time (setq num8 (sum-equal 8)))
;-> 145308.025
(length num8)
;-> 4816029

(time (setq num9 (sum-equal 9)))
;-> 1613876.858 ; quasi 27 minuti
(length num9)
;-> 40051494 ; circa 40 milioni di numeri...

Usiamo un altro metodo per risolvere il problema. Invece di provare a "trovare" questi numeri, cerchiamo di "costruire" questi numeri.
Utilizzando la ricorsione aggiungiamo cifre da 0 a 9 al numero parzialmente formato e ricorriamo con una cifra in meno in ogni punto della ricorsione. Manteniamo anche una variabile per memorizzare la differenza tra cifre pari e dispari del numero parzialmente formato. Se abbiamo riempito n-cifre e la differenza è 0, allora abbiamo trovato una soluzione.
Un caso speciale da gestire è controllare che il numero non inizi con 0.
L'algoritmo parte dal primo indice e riempe ricorsivamente le cifre da sinistra a destra (bottom-up).

Funzione di appoggio per la ricorsione:

(define (equal-sum-ex res num diff)
  ; se il numero non è a num-cifre
  (if (> num 0)
      (let ((ch (char "0")) (tmp-diff 0))
        ; il numero non può iniziare con la cifra 0
        (if (= res "") (setq ch (char "1")))
        ; ciclo che prende ogni cifra valida
        ; e la inserisce nell'indice corrente
        ; e ricorre con l'indice successivo
        (while (<= ch (char "9"))
          # aggiorna la differenza tra cifre pari e dispari
          (if (odd? num)
              ; dispari
              (setq tmp-diff (add diff (sub ch (char "0"))))
              ; pari
              (setq tmp-diff (sub diff (sub ch (char "0"))))
          )
          ; ricorsione con l'indice successivo
          (equal-sum-ex (string res (char ch)) (- num 1) tmp-diff)
          ; prossima cifra
          (++ ch)
        )
      )
  ;else
      ; se il numero diventa a num-cifre con
      ; con somma uguale delle cifre pari e dispari,
      ; lo aggiunge alla lista soluzione
      ;(if (and (zero? num) (zero? (abs diff)))
      (if (and (zero? num) (zero? diff))
          ;(print res { })
          (push (int res) out -1)
      )))

Funzione "equal-sum" (main):

(define (equal-sum num)
  (let (out '())
    (equal-sum-ex "" num 0)
    out))

Proviamo a calcolare questi numeri:

(equal-sum 2)
;-> (11 22 33 44 55 66 77 88 99)

(equal-sum 3)
;-> (110 121 132 143 154 165 176 187 198 220 231 242 253 264 275
;->  286 297 330 341 352 363 374 385 396 440 451 462 473 484 495
;->  550 561 572 583 594 660 671 682 693 770 781 792 880 891 990)

La funzione produce risultati corretti, ma è molto lenta per n > 5:

(time (setq n4 (equal-sum 4)))
;-> 6.982
(length n4)
;-> 615

(time (setq n5 (equal-sum 5)))
;-> 307.883
(length n5)
;-> 4170

(time (setq n6 (equal-sum 6)))
;-> 15388.151
(length n6)
;-> 50412

Vediamo i primi numeri con 6 cifre:

(slice n6 0 10)
;-> (100001 100012 100023 100034 100045 100056 100067 100078 100089 100100)

Questa funzione è più lenta di quella iterativa poichè la complessità temporale è esponenziale e la ricorsione richiede spazio per lo stack delle chiamate.


-----------------------------
Velocità dei cicli in newLISP
-----------------------------

Funzioni che effettuano solo un ciclo:

"for":
(define (ciclo-for from to) (for (i from to)))

"while":
(define (ciclo-while from to) (while (<= from to) (++ from)))

"dolist":
(define (ciclo-dolist from to) (dolist (x (sequence from to))))

Vediamo i tempi di esecuzione:

(time (ciclo-for 1 1e5))
;-> 0.996
(time (ciclo-while 1 1e5))
;-> 8.974
(time (ciclo-dolist 1 1e5))
;-> 6.981

Funzioni che effettuano un ciclo con operazione di assegnamento e indicizzazione di un vettore:

"for":
(define (ciclo-for1 from to sum)
  (for (i from to) (setq (arr i) i)))

"while":
(define (ciclo-while1 from to sum)
  (while (<= from to) (++ sum (arr from)) (++ from)))

"dolist":
(define (ciclo-dolist1 from to sum)
  (dolist (x arr) (++ sum x)))

Vediamo i tempi di esecuzione:

(silent (setq arr (array (+ 1e5 1) '(1))))

(time (ciclo-for1 1 1e5 0))
;-> 4.011
(time (ciclo-while1 1 1e5 0))
;-> 8.976
(time (ciclo-dolist1 1 1e5 0))
;-> 4.957

Funzioni che effettuano un ciclo con operazione di assegnamento e indicizzazione di una lista:

"for":
(define (ciclo-for2 from to sum)
  (for (i from to) (++ sum (lst i))))

"while":
(define (ciclo-while2 from to sum)
  (while (<= from to) (++ sum (lst from)) (++ from)))

"dolist":
(define (ciclo-dolist2 from to sum)
  (dolist (x lst) (++ sum x)))

Vediamo i tempi di esecuzione:

(silent (setq lst (dup 1 (+ 1 1e5))))

(time (ciclo-for2 1 1e5 0))
;-> 7052.048
(time (ciclo-while2 1 1e5 0))
;-> 7119.878
(time (ciclo-dolist2 1 1e5 0))
;-> 5.983

Funzioni che effettuano un ciclo con operazione di assegnamento e indicizzazione di una lista:

"for":
(define (ciclo-for2 from to)
  (for (i from to) (setq (lst i) i)))

"while":
(define (ciclo-while2 from to)
  (while (<= from to) (setq (lst from) from) (++ from)))

"dolist":
(define (ciclo-dolist2 from to)
  (dolist (x lst) (setq (lst x) $idx)))

Vediamo i tempi di esecuzione:

(silent (setq lst (dup 0 (+ 1 1e5))))

(time (ciclo-for2 1 1e5))
;-> 11241.424
(time (ciclo-while2 1 1e5))
;-> 11920.221
(time (ciclo-dolist2 1 1e5))
;-> 11408.515

Nota: se all'interno del loop indicizziamo una lista o un vettore, allora usare "dolist" (se possibile), altrimenti usare il ciclo "for". Il ciclo "while" solo per funzione in cui la velocità non conta (o non è possibile utilizzare "dolist" e "for").

Posiamo utilizzare anche $idx come contatore:

(time (while (< (++ i) 3000000)))
;-> 88.79
(time (while (< $idx 3000000)))
;-> 72.834
(time (dotimes (x 3000000)))
;-> 21.969
(time (for (i 1 3000000)))
;-> 21.94

Cicli con interruzione
----------------------
La funzioni "do-list" e "for" hanno un parametro booleano che permette di interrompere il ciclo (quando il parametro diventa true).
L'uso di questo parametro rallenta leggermente la velocità di esecuzione del ciclo.

(define (do-list-break lst)
  (dolist (el lst break)))

(define (do-list lst)
  (dolist (el lst)))

(setq k (sequence 1 10000))

(time (do-list-break k) 10000)
;-> 2250.054
(time (do-list k) 10000)
;-> 1984.428

(define (for-list-break lst)
  (for (i 0 (- (length lst) 1) 1 break)))

(define (for-list lst)
  (for (i 0 (- (length lst) 1))))

(time (for-list-break k) 10000)
;-> 1656.548
(time (for-list k) 10000)
;-> 1390.832


-------------------
Quicksort iterativo
-------------------

Vedi anche "QuickSort" su "Problemi vari" e "Common Lisp Quicksort" su "Note Libere 2".

Abbiamo già visto l'algoritmo quicksort ricorsivo per ordinare una lista di numeri, adesso vediamo una versione iterativa.
La base è quella di utilizzare uno stack per memorizzare l'indice iniziale e finale delle sotto-liste per poterle utilizzare nell'elaborazione successiva. La logica di partizionamento rimarrebbe la stessa.

(define (partition start end)
  (local (pivot p-idx)
    ; Prende come pivot l'elemento più a destra della lista
    (setq pivot (a end))
    ; gli elementi inferiori al pivot andranno a sinistra di "p-idx" ;
    ; gli elementi più del pivot andranno a destra di "p-idx"
    ; elementi uguali possono andare da entrambe le parti
    (setq p-idx start)
    ; ogni volta che troviamo un elemento minore o uguale al pivot,
    ; "p-idx" viene incrementato e quell'elemento
    ; deve essere posizionato prima del pivot.
    (for (i start (- end 1))
      (if (<= (a i) pivot)
          (begin
            (swap (a i) (a p-idx))
            (++ p-idx)
          )
      )
    )
    (swap (a p-idx) (a end))
    p-idx))

(define (quicksort-i a)
  (local (start end stack)
    ; indice iniziale e finale dell lista
    (setq start 0)
    (setq end (- (length a) 1))
    ; stack per memorizzare l'indice di inizio e fine della sotto-lista
    (setq stack '())
    (push (list start end) stack)
    ; ciclo finchè lo stack non è vuoto
    (while stack
      ; rimuove la prima coppia dallo stack
      ; e prende gli indici di inizio e fine della sotto-lista
      (map set '(start end) (pop stack))
      ; riorganizza gli elementi attraverso il pivot
      (setq pivot (partition start end))
      ; impila gli indici della sotto-lista contenenti elementi
      ; che sono inferiore al pivot corrente
      (if (> (- pivot 1) start)
          (push (list start (- pivot 1)) stack)
      )
      ; impila gli indici della sotto-lista contenenti elementi
      ; che sono superiori al pivot corrente
      (if (< (+ pivot 1) end)
          (push (list (+ pivot 1) end) stack)
      )
    )
    ; ritorna la lista ordinata
    a))

(quicksort-i '(3 9 8 -3 5 -6 7 1 -4))
;-> (-6 -4 -3 1 3 5 7 8 9)

(quicksort-i (randomize (sequence 1 1000)))
;-> (1 2 3 4 5 ... 1000)

(quicksort-i '(1 3 3 -3 -3 -2 -2 11 11 -11 -11))
;-> (-11 -11 -3 -3 -2 -2 1 3 3 11 11)


------------------
Funzioni con stato
------------------

L'uso dei contesti ci permette di scrivere funzioni che "ricordano" uno stato.


Scriviamo due funzioni che generano una il prossimo numero pari e l'altra il prossimo numero dispari.

Funzione che genera il prossimo numero dispari (odd):

(define (next-odd:next-odd)
  (if next-odd:curvalue
    (inc next-odd:curvalue 2)
    (setq next-odd:curvalue 1)))

(next-odd)
;-> 1
(next-odd)
;-> 3
(next-odd)
;-> 5

Funzione che genera il prossimo numero pari (even):

(define (next-even:next-even)
  (if next-even:curvalue
    (inc next-even:curvalue 2)
    (setq next-even:curvalue 0)))

(next-even)
;-> 0
(next-even)
;-> 2
(next-even)
;-> 4

Funzioni per resettare i due generatori:

(define (next-odd-reset) (setq next-odd:curvalue nil))
(define (next-even-reset) (setq next-even:curvalue nil))

(next-odd-reset)
;-> nil
(next-odd)
;-> 1
(next-odd)
;-> 3

(next-even-reset)
;-> nil
(next-even)
;-> 0
(next-even)
;-> 2

Funzioni per definire il numero iniziale dei generatori:

(define (next-odd-set start) (setq next-odd:curvalue start))
(define (next-even-set start) (setq next-even:curvalue start))

(next-odd-set 11)
;-> 11
(next-odd)
;-> 13

(next-even-set 100)
;-> 100
(next-even)
;-> 102

Nota: le ultime due funzioni possono sostituire "next-odd-reset" e "next-even-reset".

(next-odd-set)
;-> nil
(next-odd)
;-> 1
(next-even-set)
;-> nil
(next-even)
;-> 0

Un altro metodo è il seguente:

(define (foo x) (inc (last foo) x) 0)
;-> (lambda (x) (inc (last foo) x) 0)
(foo 1)
;-> 1
(foo 1)
;-> 2
(foo 10)
;-> 12

In newLISP è meglio realizzare le funzioni con stato utilizzando i contesti (gli spazi dei nomi):

(define (gen:gen)
    (inc gen:sum))

(gen)
;-> 1
(gen)
;-> 2

Nota: è possibile modificare un'espressione lambda solo in questo modo. La riassegnazione della funzione all'interno del suo corpo provocherebbe il crash del sistema:

(define (foo) (define (foo) "hello"))

(foo) ==> crash

Vedi anche "Chiusure, contesti e funzioni con stato (Lutz Mueller)" nelle Appendici.


---------------------------------
Collisione dei contesti (context)
---------------------------------

http://www.newlispfanclub.alh.net/forum/viewtopic.php?f=15&t=4312

lotabout:
---------
Se due programmatori scrivono due moduli diversi senza conoscere l'altro, potremmo incontrare una collisione di contesto, ovvero usare lo stesso nome per il contesto.
Esempio:

Nel modulo 'A', definiamo una macro 'my-set' e la mettiamo nel contesto 'my-set' (solo per illustrare):

; A.lsp
(context 'my-set)
(define-macro (my-set a b)
  (set (eval a) b))
(context MAIN)
(context 'A)
(define (my-test x)
  (letex (x x) (my-set:my-set 'y x)))
(context MAIN)

E ora scriviamo il modulo 'B' senza riconoscere l'esistenza del modulo 'A':

; B.lsp
(context 'my-set)
(define-macro (my-set a b)
  (set  (eval b) a))
(context MAIN)
(context 'B)
(define (my-test x)
  (letex (x x) (my-set:my-set x 'y)))
(context MAIN)

Ora si vede che abbiamo due implementazioni della macro "my-set" nella stesso contesto, se carichiamo questi due file contemporaneamente, uno interromperà l'altro.

Se carichiamo prima "A.lsp" e poi "B.lsp", allora la definizione di 'my-set' in B lo sovrascriverà in "A.lsp", quindi la funzione "my-test" in "A.lsp" fallirà.

Questo perchè i contesti possono essere visti globalmente e non vengono oscurati (shadowed) dagli altri contesti. E potremmo utilizzare moduli scritti da programmatori diversi che possono avere il problema della collisione dei contesti.

Lutz:
-----
Soluzione: Utilizzare un solo contesto per modulo (file). Programmatori diversi mantengono contesti diversi. Il contesto MAIN è l'unico luogo in cui devono essere caricati altri contesti per poter controllare l'organizzazione principale del programma che deve essere gestita da un programmatore capo. Nessun contesto dovrebbe ridefinire le funzioni durante il runtime in contesti non gestiti dallo stesso sviluppatore.

lotabout:
---------
L'utilizzo di un solo contesto per ogni modulo (file) è una buona convenzione. Ma in questo caso, non ci sarà una soluzione facile per risolvere il problema della "cattura delle variabili" durante la definizione di macro (in un modulo).
Inoltre, ciò significa che non possiamo utilizzare i contesti come "dict" o "hash-map" durante la scrittura di moduli.
Come affrontare questa situazione?

Lutz:
-----
Gli hash/dizionari sono contesti (dati) accessibili a livello globale, che possono essere modificati dagli altri moduli. Perché questo dovrebbe essere un problema quando lo stesso accade ai database o ad altri dati globali destinati all'uso globale?

Ciò che accade nel tuo esempio non è causato dalla cattura delle variabili o dall'ambito dinamico, ma è semplicemente l'effetto della ridefinizione del contesto "my-set" durante l'esecuzione. Ho ampliato l'esempio con la stampa delle istruzioni e l'utilizzo della funzione "my-test" per mostrare gli effetti:

; A.lsp
(context 'my-set)
(define-macro (my-set:my-set a b)
  (set (eval a) b))
(context MAIN)
(context 'A)
(println "A before " my-set:my-set)
(define (my-test x)
  (letex (x x) (my-set:my-set 'y x)))
(my-test 123)
(println "A after " my-set:my-set)
(context MAIN)

; B.lsp
(context 'my-set)
(define-macro (my-set:my-set a b)
  (set  (eval b) a))
(context MAIN)
(context 'B)
(println "B before " my-set:my-set)
(define (my-test x)
  (letex (x x) (my-set:my-set x 'y)))
(my-test 456)
(println "B after " my-set:my-set)
(context MAIN)

e questo è l'output:

;-> A before (lambda-macro (my-set:a my-set:b) (set (eval my-set:a) my-set:b))
;-> A after (lambda-macro (my-set:a my-set:b) (set (eval my-set:a) my-set:b))
;-> B before (lambda-macro (my-set:a my-set:b) (set (eval my-set:b) my-set:a))
;-> B after (lambda-macro (my-set:a my-set:b) (set (eval my-set:b) my-set:a))

L'unico effetto che possiamo vedere è causato dalla ridefinizione esplicita della funzione my-set:my-set. Le funzioni A:my-test e B:my-test non hanno effetto su my-set:myset.

La cattura delle variabili tramite macro (realmente fexprs) del tipo descritto qui:
http://www.newlisp.org/downloads/newlisp_manual.html#scoping
è possibile solo tramite interazioni all'interno dello stesso contesto. Quel contesto è sotto il controllo di uno sviluppatore, o meglio, hai tutte le macro nel loro contesto. Quindi qualsiasi simbolo portato nello spazio della macro è estraneo e non può interagire.

Più in generale:

L'ambito dinamico è spesso citato come argomento contro newLISP. In pratica, non ho mai visto problemi di cattura delle variabili nel mio codice o nel codice di altri. Quando ci si attiene alla regola dei "contesti separati" e si inseriscono le macro nei propri contesti, non possono verificarsi problemi.

Alcuni anni fa ho lavorato per oltre un anno in un team di sette preogrammatori allo sviluppo di un'applicazione distribuita multi-modulo per la ricerca. Tutti, tranne me, programmavano in newLISP per la prima volta, alcuni dei erano programmatori esperti, altri nuovi nel mestiere. Uno era un programmatore esperto in Common LISP. Non abbiamo mai riscontrato problemi causati dall'ambito dinamico. Molti utenti di newLISP non comprendono nemmeno completamente l'intero concetto ed evitano le variabili libere come questione di un buon stile di programmazione.

Oggi credo che i problemi con l'ambito dinamico siano enormemente esagerati, il che è triste, perché le persone hanno smesso di utilizzare l'ambito dinamico come strumento per realizzare la "separation of concerns" e lo "switching".

Nota: Separation of concerns (SoC) è un principio di progettazione per separare un programma in sezioni distinte.

I veri problemi nei linguaggi dinamici sono di diversa natura. Per esempio. variabili errate, perché non è necessario pre-dichiararle o confondere tipi di variabili diverse nelle funzioni tipizzate duck.

Nota: Nel "duck typing", un oggetto è di un determinato tipo se ha tutti i metodi e le proprietà richiesti da quel tipo. Per esempio in un linguaggio non duck-tipizzato si può creare una funzione che prende un oggetto di tipo Anatra(duck) e chiama i metodi starnazza(quack) e cammina(walk) di quell'oggetto. In un linguaggio duck-tipizzato, la funzione equivalente avrebbe preso un oggetto di qualunque tipo e chiamato i metodi walk e quack di quell'oggetto. Se quindi l'oggetto non ha i metodi chiamati, la funzione segnala un errore in run-time. È quest'azione di ogni oggetto avente i corretti metodi quack e walk che vengono accettati dalla funzione che effettua la chiamata e quindi il nome di questa forma di tipizzazione.

lotabout:
---------
Adesso ho più confidenza nell'uso dell'ambito dinamico e ho compreso che possiamo evitare la cattura delle variabili inserendo le macro (fexprs) in un contesto separato per utilizzarle all'interno di un altro contesto. Senza interazioni, non accadrà mai la cattura delle variabili alle macro (fexprs).

Consideriamo un'altra situazione in cui abbiamo le seguenti regole per la scrittura dei moduli:
1. separare le macro => tutte in un contesto separato.
2. inserire tutto il codice in un contesto => cioè il nome del modulo.
3. utilizzare un solo contesto (specificato dal punto 2) ad eccezione di quelli utilizzati come contenitori di dati (come dict/hash table)

E se due sviluppatori utilizzassero lo stesso nome di contesto per scopi diversi? Qui utilizziamo contesti come dati (dict/tabella hash, ecc.) all'interno di un contesto globale (per specificare il nome del modulo). Supponiamo che lo sviluppatore A utilizzi il contesto "dict" per memorizzare coppie (parola significato) e che lo sviluppatore B utilizzi lo stesso contesto per contenere coppie (parola frequenza). Ora quando useremo entrambi i moduli ognuno influenzerà l'altro operando sullo stesso contesto "dict", quindi entrambi falliranno in una certa misura.
Come risolvere questo problema?

Ho poca esperienza nello sviluppo di grandi progetti, ma credo che con l'aumento dei moduli, aumenta anche la probabilità di una collisione di nomi. Una possibile soluzione è quella di avere tutti i contesti denominati con un prefisso come "A-dict" o qualcosa del genere.

cormullion:
-----------
Penso che questo problema dovrebbe essere considerato come parte della gestione del progetto, non della progettazione del linguaggio. Se due sviluppatori che lavorano a stretto contatto sullo stesso progetto non stanno già lavorando in modo coerente ad alcune politiche concordate, allora il progetto probabilmente fallirà comunque...

Lutz:
-----
I conflitti di nome si verificano in qualsiasi linguaggio di programmazione e devono essere affrontati come parte della gestione dello sviluppo, come afferma Cormullion. I conflitti di nomi si verificano in diversi linguaggi di programmazione in momenti diversi. Possono verificarsi in C, C++ e anche in Java. Nei linguaggi completamente compilati, possono essere rilevati durante la fase di compilazione prima dell'esecuzione.

Il problema è più critico in linguaggi completamente dinamici come newLISP, dove puoi creare ed eliminare simboli durante il runtime. Per il normale raggruppamento del codice in moduli di contesto, le regole delineate sopra funzionano, perché questi vengono creati e gestiti prima del runtime. Per gli hash creati ed eliminati in fase di esecuzione, procedere come segue:

Usando la funzione "uuid" è possibile creare un dizionario in fase di esecuzione e garantirne l'unicità. Fortunatamente i contesti in newLISP possono essere indicati con variabili, che potrebbero essere locali a un contesto. Quindi non devi conoscere il nome del contesto del dizionario quando scrivi il tuo programma prima che il contesto venga creato e non devi gestire stringhe UUID difficili da ricordare.

Il codice seguente mostra questo come esempio:

(context 'A)
(set 'mydict (let (s (sym (append "dict" (uuid)) MAIN)) (new Tree s)))
(bayes-train (parse "this sentence has words and words") mydict)
(bayes-train (parse "and more words") mydict)
(println "mydict in A:" (mydict))
(context MAIN)

(context 'B)
(set 'mydict (let (s (sym (append "dict" (uuid)) MAIN)) (new Tree s)))
(mydict "foo" "hello world")
(mydict "bar" 1234567)
(println "mydict in B:" (mydict))
(println "association in B: " (mydict "foo"))
(context MAIN)
(exit)

Entrambi i contesti A e B usano lo stesso nome interno mydict per riferirsi a un contesto di dizionario creato usando le funzioni sym e uuid. Questo è l'output:

mydict in A:(("and" (2)) ("has" (1)) ("more" (1)) ("sentence" (1)) ("this" (1)) ("words" (3)))
mydict in B:(("bar" 1234567) ("foo" "hello world"))
association in B: hello world

In A vengono contate le frequenze delle parole. Nota che le frequenze sono tra parentesi, perché puoi contare e confrontare diversi corpus usando bayes-query. In B vengono effettuate associazioni generali.

Vedi anche: http://www.newlisp.org/downloads/newlisp_manual.html#hash

lotabout:
---------
Questo trucco funziona!
E penso che dovremmo sempre usare questo trucco quando utilizziamo un contesto come contenitore di dati all'interno di un modulo.
Grazie ancora per essere così paziente. E sicuramente rimarrò con newlisp, è semplicemente fantastico.

bairui:
-------
Mi piacerebbe saperne di più su questo: "separation of concerns" e "switching"). Mi sono un convertito con difficoltà al mondo della programmazione funzionale e l'ambito dinamico mi sconcerta.

rickyboy:
---------
Proverò a spiegare come differiscono l'ambito dinamico delle variabili e l'ambito statico (lessicale) delle variabili. Se non lo capisci dopo aver letto questo, scommetto che è colpa della mia cattiva spiegazione. :)

Variabili libere e vincolate
----------------------------
Per rispondere a questa domanda, dovremmo prima esaminare una semplice classificazione delle variabili: variabili libere rispetto a variabili vincolate/associate. Per spiegare cosa sono le variabili libere e vincolate, considera questo frammento di codice che è al livello più alto in newLISP.

(define x 42)  ; <-- 0
(+ x y)  ; <-- 1
(let (y 1) (+ x y))  ; <-- 2
(let (x 42 y 1) (+ x y))  ; <-- 3
(lambda (y) (+ x y))  ; <-- 4
(define (dumb-sum y) (+ x y)) ; <-- 5

L'espressione 1 ha due variabili: x e y. Entrambe sono liebere. L'espressione 2 ha le stesse variabili, ma solo x è libera -- y è vincolata. Come mai? Perché il let è responsabile dell'associazione y (e questo è il motivo per cui il secondo elemento di qualsiasi forma  let è chiamato "the let bindings").

Ecco una buona idea da tenere a mente nel determinare se una variabile è libera o vincolata in un'espressione: ogni variabile è libera finché non è *vincolata* da qualcosa, cioè finché qualcosa non la vincola, o la lega. Questo è ciò che ha fatto a y nell'espressione 2.
(cattivo let!) :))

(A parte: non è convenzionale dire che il livello superiore (non-lambda) definisce (come nell'espressione 0) variabili vincolate ("bind"). Quindi, pur associando x a 42, x non è considerato vincolato ad esso. In breve, ignora le definizioni di primo livello non-lambda)

L'espressione 3 ha x e y entrambi vincolati, cioè sono entrambe variabili legate e nessuna variabile in quell'espressione è libera.

Quando si scrive una forma lambda, l'elenco dei parametri indica quali variabili verranno vincolate da lambda. Quindi, l'espressione 4 ha y legata e x libera. L'espressione 5, pur essendo una definizione di primo livello, definisce una lambda e, come abbiamo detto sulle lambda, legano le variabili. Quindi, nell'Espressione 5, come abbiamo visto nell'Espressione 4, y è legato e x è libero.

I seguenti operatori sono "vincolanti" ("binders") di variabili: let, lambda, local, ecc. (guarda il manuale per ottenere un elenco esaustivo, ma spero che tu abbia un'idea).

Ambito dinamico e ambito statico (o lessicale)
----------------------------------------------
Ora, considera il seguente frammento di codice, sempre al livello più alto.

(define x 42)

(define (f y) (let ((x 13)) (g y)))
(define (g z) (list x z))

(define (h x y) (list x y))

Si noti che f chiama g prima che possa "restituire" un valore. Chiama g con il proprio parametro y. Ora la domanda è, con queste definizioni, quale dovrebbe essere il valore dell'espressione (f 3)?

Chiaramente, questo dipende da quale sia il valore di x. Come mai? Perché x è libero in g, ovvero, x è libero in questa espressione: (lambda (z) (lista x z)). Ebbene, x può assumere uno dei due valori: 42 o 13. Quindi, ciò significa che il valore di (f 3) è (42 3) o (13 3). Allora qual è?

La risposta ha a che fare con il tipo di ambito delle variabili viene usato nel linguaggio. Il valore di (f 3) in Scheme (che ha ambito statico) è (42 3), ma in newLISP (ambito dinamico), è (13 3). Questo perché Scheme "vede" solo il valore di x della definizione di livello superiore, ma newLISP vede x che lega lo stack di chiamate (poiché f chiama g, c'è quella let interposta).

(f 3)
;-> (13 3)

Infine, non dimentichiamo la funzione h definita sopra. Qual è il valore di (h 1 2)? La risposta è che la lista (1 2), sia nei linguaggi con ambito dinamico CHE in quelli con ambito statico.

(h 1 2)
;-> (1 2)

Quindi, la domanda su quale sia il valore di questo e quello nell'ambito dinamico rispetto all'ambito lessicale, dipende solo da come le variabili libere vengono risolte (o valutate) nell'espressione superiore che viene valutata. Al centro dello schema di ambito (scoping) delle variabili (che sia dinamico o statico) c'è questo problema di "come vengono risolte le variabili libere". Questo è praticamente tutto.

Ecco perché è buona pratica di programmazione non avere variabili libere nelle espressioni quando non ne hai bisogno. (In parole povere, pensa ai "confini" delle tue variabili e non essere un programmatore pigro. :)) Tuttavia, ci sono momenti in cui è necessario avere una variabile libera nell'espressione, ad esempio se si desidera collegare un interruttore di runtime nel codice (Lutz lo ha menzionato in precedenza in questo thread), ma in generale, quando si codifica si dovrebbe trattare solo con variabili associate.
Questa pratica/disciplina aiuterà davvero a eliminare molti problemi che potrebbero insinuarsi nel tuo codice se non la utilizzi. (Le variabili libere "involontarie" tendono ad essere un problema minore con l'ambito lessicale. Tuttavia, essere consapevoli del "limite" delle variabili dovrebbe essere osservato come pratica anche con i linguaggi con ambito lessicale).

bairui:
-------
Sono abituato a linguaggi con ambito lessicale in cui qualsiasi modifica a x sarebbe una modifica permanente, quindi fare riferimento a x all'ambito principale dopo la chiamata (f 2) produrrebbe il valore ora modificato, 13 (nelle lingue che uso). Quindi, il codice (let ((x 13)) ...) oscura temporaneamente (dici vincola) la variabile globale (dici libero (il termine libero potrebbe non essere limitato ai globali... giusto?)) x con la valore 13. Quando l'espressione (let) termina, l'associazione termina e quindi x torna ad essere il valore che era prima di questa modifica dinamica dell'ambito, 42.
Ok. A parte alcune ovvie stranezze nella mia terminologia, diciamo che ora l'ho capito. Grazie! Quindi, ora vorrei capire cosa intendeva Lutz quando ha detto che c'erano tecniche dell'ambito dinamico non disponibili nell'ambito statico (lessicale). Potresti approfondire: "switching and separation of concerns"?

Lutz:
-----
Se vuoi sapere tutto e hai tempo in questo fine settimana:

http://en.wikipedia.org/wiki/Separation_of_concerns

Quindi fondamentalmente "concerns" sono gruppi di requisiti che devono essere coperti dal tuo programma. Lo strumento più famoso al momento per raggiungere questo obiettivo è la programmazione orientata agli oggetti (OOP). Ma anche l'ambito dinamico può farlo. Nell'esempio di Rickyboy, diversi concerns sono espressi tramite il valore della variabile x, che è 42 per impostazione predefinita, ma potrebbe essere oscurato (shadowed) con altri valori, ad es. 13 in funzione f.

Ora le cose si complicano quando affronti "concers" che si intersecano. È possibile risolvere la situazione usando OOP, ma complicato:

http://en.wikipedia.org/wiki/Cross-cutting_concern

La soluzione è Aspect Oriented Programming (AOP):

http://en.wikipedia.org/wiki/Aspect-oriented_programming

Ecco come Pascal Costanza dimostra che il tipo di programmazione AOP è davvero una cosa naturale per i linguaggi con scope dinamico:

http://www.p-cos.net/documents/dynfun.pdf

C'è un modo accurato per cambiare i concerns usando i contesti in newLISP. Immagina che il tuo compito sia la formattazione dei documenti. I tuoi due metodi principali sono HTML o Markdown (un semplice linguaggio di markup di John Gruber).

A un livello superiore, vuoi scrivere solo un programma che esegue la formattazione, ma vuoi anche un modo semplice per passare da uno all'altro, e forse vuoi aggiungere LATEX in seguito, ma non cambiare il tuo programma principale.

Ecco come farlo in newLISP utilizzando i contesti (context):

(context 'HTML)

(define (format-title text)
    (string "<h1>" text "</h2>"))

(context MAIN)

(context 'Markdown)

(define (format-title text)
    (string "===" text "==="))

(context MAIN)

(define (format-page method text)
    (method:format-title text))

(println (format-page HTML "hello world"))
(println)
(println (format-page Markdown "hello world"))

(exit)

e questo è l'output:

<h1>hello world</h2>

===hello world===

Quindi in pratica usiamo una variabile con nome del metodo per utilizzare il contesto relativo.


------------------------------
Simulazione del lancio di dadi
------------------------------

Scriviamo una funzione che prende i seguenti parametri:

  numero dei dadi                --> num-dice
  lista delle facce di ogni dado --> lst-faces
  numero di lanci da effettuare  --> iter

e restituisce una lista di elementi (uno per ogni numero possibile del lancio dei dadi) che hanno la seguente struttura:

  (numero contatore frequenza)

dove:

  numero    --> numero (uno dei numeri possibili del lancio dei dadi)
  contatore --> quante volte è uscito il numero
  frequenza --> frequenza del numero

Funzione che calcola il prodotto cartesiano di due liste:

(define (cp lst1 lst2)
  (let (out '())
    (dolist (el1 lst1)
      (dolist (el2 lst2)
        (push (list el1 el2) out -1)))))

Funzione che calcola il prodotto cartesiano di una lista di liste:

(define (prod-cart lst-lst)
  (let (out '())
    (dolist (el (apply cp lst-lst 2))
      (push (flat el) out -1))))

Funzione che simula il lancio dei dadi:

(define (dice-stat num-dice lst-faces iter)
  (local (min-val max-val counts freqs tmp tot-faces out)
    ; number of all faces
    (setq tot-faces (length (flat lst-faces)))
    ; find min and max values of throwing dices
    (setq min-val 0)
    (setq max-val 0)
    (dolist (el lst-faces)
      (setq min-val (+ min-val (apply min el)))
      (setq max-val (+ max-val (apply max el)))
    )
    ; array: count of numbers
    (setq freqs (array (+ max-val 1) '(0)))
    ; array: frequency of numbers
    (setq counts (array (+ max-val 1) '(0)))
    ; simulate the throw of dice "iter" times
    (for (i 1 iter)
      (setq tmp 0)
      (for (k 0 (- num-dice 1))
        (setq tmp (+ tmp (lst-faces k (rand (length (lst-faces k))))))
      )
      ; update the count of number (tmp)
      (++ (counts tmp))
    )
    ; calulate frequencies of numbers
    (setq freqs (map (fn(x) (div x iter)) counts))
    ; check results:
    ; sum of counts must be equal to iter
    (if (!= iter (apply + counts))
        (println "Error counts: " (apply + counts))
    )
    ; sum of probabilities must be equal to 1
    (if (> (abs (sub 1.0 (apply add freqs))) 1e-6)
        (println "Error freqs " (apply add freqs))
    )
    ; create a sorted list with all possible result of throwing dices
    ; (use the cartesian product function)
    (if (= (length lst-faces) 1)
        (setq values (sort (flat lst-faces)))
        (setq values (sort (unique (map (fn(x) (apply + x)) (prod-cart lst-faces)))))
    )
    ; (println values { } counts { } freqs)
    ; create list of output: (value counter frequency)
    (setq out '())
    (dolist (el values)
      ;(push (list el (counts el) (freqs el)) out -1)
      (push (list el (counts el) (round (freqs el) -4)) out -1)
    )
    out))

(dice-stat 3 '((1 2 3) (1 2 3) (10 11 12)) 1)
;-> ((12 0 0) (13 0 0) (14 0 0) (15 0 0) (16 1 1) (17 0 0) (18 0 0))

(dice-stat 3 '((1 2 3) (1 2 3) (10 11 12)) 100)
;-> ((12 1 0.01) (13 14 0.14) (14 21 0.21) (15 28 0.28)
;->  (16 21 0.21) (17 11 0.11) (18 4 0.04))

(dice-stat 1 '((1 2 3 4 5 6)) 1e6)
;-> ((1 166192 0.1662) (2 166805 0.1668) (3 166936 0.1669)
;->  (4 166928 0.1669) (5 166565 0.1666) (6 166574 0.1666))

(dice-stat 3 '((1 2) (1 2 3) (1 2 3 4)) 1e6)
;-> ((3  41803 0.0418)
;->  (4 124753 0.1248)
;->  (5 208508 0.2085)
;->  (6 250475 0.2505)
;->  (7 207885 0.2079)
;->  (8 125210 0.1252)
;->  (9  41366 0.0414))

(dice-stat 2 '((1 2 3 4 5 6) (1 2 3 4 5 6)) 1e6)
;-> ((2 27599 0.0276) (3 55067 0.0551) (4 83716 0.0837)
;->  (5 111210 0.1112) (6 138393 0.1384) (7 166750 0.1668)
;->  (8 139317 0.1393) (9 111126 0.1111) (10 83366 0.0834)
;->  (11 55637 0.0556) (12 27819 0.0278))

(dice-stat 2 '((2 2) (2 2)) 10000)
;-> ((4 10000 1))

(dice-stat 2 '((1 2 3) (3 2 1)) 1e6)
;-> ((2 111137 0.1111) (3 222129 0.2221) (4 333639 0.3336)
;->  (5 222573 0.2226) (6 110522 0.1105))

(dice-stat 2 '((1 3 5) (2 4 6)) 1e6)
;-> ((3 110991 0.111)
;->  (5 223027 0.223)
;->  (7 333773 0.3338)
;->  (9 221395 0.2214)
;->  (11 110814 0.1108))

(dice-stat 3 '((1 2 3) (1 2 3) (10 11 12)) 1e6)
;-> ((12 37099  0.0371)
;->  (13 111249 0.1112)
;->  (14 221902 0.2219)
;->  (15 259005 0.259)
;->  (16 222338 0.2223)
;->  (17 111343 0.1113)
;->  (18 37064  0.0371))

(dice-stat 3 '((1 4 9) (1 8 27) (2 3 5)) 1e6)
;-> ((4 37171 0.0372) (5 36838 0.0368) (7 73983 0.074) (8 37029 0.037)
;->  (10 36995 0.037) (11 36912 0.0369) (12 73984 0.074) (13 36906 0.0369)
;->  (14 74154 0.0742) (15 73780 0.0738) (17 36997 0.037) (19 37090 0.0371)
;->  (20 36881 0.0369) (22 37427 0.0374) (30 36759 0.0368) (31 36810 0.0368)
;->  (33 74649 0.0746) (34 37082 0.0371) (36 37144 0.0371) (38 37045 0.037)
;->  (39 36970 0.037) (41 37394 0.0374))


-------------------------------------
Creazione di immagini con ImageMagick
-------------------------------------

https://imagemagick.org/

ImageMagick è un programma freeware e multipiattaforma che viene usato per creare, modificare, comporre o convertire immagini digitali.

Con ImageMagick è possibile creare immagini da newLISP.

Il seguente comando di ImageMagick crea un'immagine "image.png" da un file di testo "pixels.txt":

   convert pixels.txt image.png

Il seguente comando di ImageMagick crea un'immagine "image.png" (con uno sfondo bianco) da un file di testo "pixels.txt":

   convert pixels.txt -background white -flatten image.png

La struttura del file di testo è la seguente:

# ImageMagick pixel enumeration: 4,4,255,rgba
0,0: (187,102,127,128)
0,1: ( 51,153,127,10)
0,2: (204,102,127,255)
0,3: ( 68,153,127,128)
1,1: ( 51,153,127,200)
1,2: (204,102,127,255)
1,3: ( 68,153,127,255)
2,0: (187,102,127,150)
2,1: ( 51,153,127,128)
2,2: (204,102,127,45)
3,0: (187,102,127,255)
3,1: ( 51,153,127,255)
3,2: (204,102,127,150)

La prima riga (intestazione) del file contiene le informazioni di base sull'immagine.
Le informazioni sono composte da:

File Magic: l'intestazione dell'immagine "# ImageMagick pixel enumeration:" definisce questo file come uno speciale formato immagine di testo IM

Dimensione immagine: I prossimi due numeri (4,4) definiscono la dimensione dell'immagine contenuta in questo file. Moltiplicando questi numeri insieme si ottiene il numero di righe che possono seguire l'intestazione per definire completamente l'immagine.

MaxValue: l'ultimo numero nell'intestazione definisce il 'valore massimo' dei dati dell'immagine che è possibile. Nell'esempio vale "255", che indica una profondità di 8 bit.

Spazio colore: l'ultimo elemento nell'intestazione definisce lo spazio colore dei dati che seguono. In questo esempio "rgba" indica uno spazio di colore RGB con trasparenza (a=alpha)

Dopo l'intestazione seguono le righe che rappresentano i punti dell'immagine che hanno il seguente formato:

x,y: (r,g,b,a)  ==>  0,0: (187,102,127,128)

a) Non è necessario definire tutti i pixel nell'immagine.
b) Non è necessario che i pixel siano ordinati

ImageMagick legge il file e disegna i pixel su una immagine vuota.

Ecco un altro esempio:

# ImageMagick pixel enumeration: 2,2,65535,rgb
0,0: (48059,26214,32767)  #BBBB66667FFF  rgb(73.3333%,40%,49.9992%)
1,0: (13107,39321,32767)  #333399997FFF  rgb(20%,60%,49.9992%)
0,1: (52428,26214,32767)  #CCCC66667FFF  rgb(80%,40%,49.9992%)
1,1: (17476,39321,32767)  #444499997FFF  rgb(26.6667%,60%,49.9992%)

In questo esempio MaxValue è 65535, quindi l'immagine ha una profondità di 16 bit.

Le informazioni del tipo "#BBBB66667FFF  rgb(73.3333%,40%,49.9992%)" non vengono considerate durante la creazione del file.

Naturalmente è possibile l'operazione inversa, cioè creare un file di testo da una immagine:

  convert image.png pixels.txt

Questo si rivela utile per vedere come vengono codificate le varie informazioni da ImageMagick (spazio colore, ecc.).

Maggiori informazioni a: https://legacy.imagemagick.org/Usage/files/#txt

Nota: le coordinate dei punti devono essere non negative, altrimenti ImageMagick genera un errore.

Nota: l'errore "...pixel not authentic..." di ImageMagick indica un errore nelle coordinate dei pixel o nella riga di intestazione.

Per creare un'immagine da newLISP (senza trasparenza, il canale Aplha 'a' non viene considerato):

(exec "convert pixels.txt image.png")

oppure (con trasparenza, con il canale Alpha):

(exec "convert pixels.txt -background white -flatten pixels.png")

Adesso vediamo un semplice esempio scrivendo una funzione che crea un'immagine con colori casuali (cioè un file di testo nel formato di ImageMagick):

(define (random-IM width height file-str)
  (local (outfile x y r g b a line)
    (setq outfile (open file-str "write"))
    (print outfile { }) ; handle del file
    ; intestazione del file
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                width "," height ",256,rgba"))
    ;(setq alpha 255) ; fixed alpha
    ; random color pixel
    (for (x 0 (- width 1))
      (for (y 0 (- height 1))
        (map set '(r g b) (rand 255 3))
        (setq alpha (rand 256)) ; random alpha
        (setq line (string x ", " y ": (" r "," g "," b "," alpha ")"))
        (write-line outfile line)
      )
    )
    (close outfile)))

Generiamo il file di testo che rappresenta l'immagine (64x64):

(random-IM 64 64 "casual.txt")

Convertiamo il file di testo in una immagine con ImageMagick:

(exec "convert casual.txt -background white -flatten casual.png")

Nota: (exec "convert casual.txt casual.png") produce risultati differenti (trasparente senza background) solo se i colori hanno un alpha diversa da 255.

Il file "casual.png" si trova nella cartella "data".

Idee di utilizzo
----------------
1) random walk
2) grafici di funzioni
3) generative art
4) attrattori di clifford
5) superformula 2D/3D

Vediamo una funzione generica per generare immagini RGBA a 8 bit per canale (0..255).

(define (list-IM lst file-str)
  (local (outfile x-width y-height line)
    ; remove duplicate pixel
    (setq lst (sort (unique lst)))
    ; open output file
    (setq outfile (open file-str "write"))
    (print outfile { }) ; debug
    ; calcolo dimensioni immagine
    ; calculate image dimension (width and height)
    (setq x-width (add 1 (apply max (map (fn(c) (c 0)) lst))))
    (setq y-height (add 1 (apply max (map (fn(c) (c 1)) lst))))
    ; write file (ImageMagick format: rgba, 8bit)
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (setq mode (length (lst 0)))
    (cond ((= mode 2) ; only coords
            (dolist (el lst)
              (setq line (string (string (el 0)) ", " (string (el 1))
                    ": (0,0,0,255)")) ; color black with alpha=100%
              (write-line outfile line)))
          ((= mode 5) ; coords and r g b
            (dolist (el lst)
              (setq line (string (string (el 0)) ", " (string (el 1)) ": ("
                    (string (el 1)) ", " (string (el 2)) ", " (string (el 3))
                    ", 255)")) ; color r g b with alpha=100%
              (write-line outfile line)))
          ((= mode 6) ; coords and r g b a
            (dolist (el lst)
              (setq line (string (string (el 0)) ", " (string (el 1)) ": ("
                    (string (el 1)) ", " (string (el 2)) ", " (string (el 3))
                    ", " (string (el 4)))) ; color r g b with alpha=100%
              (write-line outfile line)))
          (true (println "Error: only 2, 5 or 6 elements are allowed")))
    (close outfile)))

Proviamo:

Immagine bianco e nero (senza trasparenza):

(silent
  (setq x (rand 200 1000))
  (setq y (rand 200 1000))
  (setq IM1 (map list x y))
)
(list-IM IM1 "IM1.txt")
(exec "convert IM1.txt -background white -flatten IM1.png")

Immagine RGB (senza trasparenza):

(setq IM2 (map (fn(x) (append x (list (rand 255) (rand 255) (rand 255)))) IM1))
(list-IM IM2 "IM2.txt")
(exec "convert IM2.txt -background white -flatten IM2.png")

Immagine RGBA (con trasparenza):

(setq IM3 (map (fn(x) (append x (list (rand 255)))) IM2))
(list-IM IM3 "IM3.txt")
(exec "convert IM3.txt -background white -flatten IM3.png")

I file "IM1.png", "IM2.png" e "IM3.png" si trovano nella cartella "data".


----------------------
Attrattore di Clifford
----------------------

L'attrattore di Clifford, noto anche come "fractal dream attractor", è definito dal sistema di equazioni:

  x(n+1) = sin[a*y(n)] + c*cos[a*x(n)]
  y(n+1) = sin[b*x(n)] + d*cos[b*y(n)]

dove a, b, c e d sono costanti. È un attrattore perché per determinati valori di a, b, c e d, qualsiasi punto iniziale (x0,y0) ripeterà lo stesso pattern.

L'algoritmo per creare i punti di un attrattore è il seguente:
1) prendere un punto qualsiasi p0 = (x0, y0),
2) calcolare il punto successivo p(n+1) = (x(n+1), y(n+1)) con le formule
3) ripetere più volte il punto 2...

È possibile creare un'ampia gamma di forme grafiche modificando le costanti. I seguenti valori producono attrattori interessanti:

   a = -1.4, b = 1.6,  c = 1.0,  d = 0.7
   a = 1.6,  b = -0.6, c = -1.2, d = 1.6
   a = 1.5,  b = -1.8, c = 1.6,  d = 0.9
   a = 1.7,  b = 1.7,  c = 0.6,  d = 1.2
   a = -1.7, b = 1.3,  c = -0.1, d = -1.2
   a = -1.7, b = 1.8,  c = -1.9, d = -0.4
   a = -1.8, b = -2.0, c = -0.5, d = -0.9
   a = 2,    b = 2,    c = 1,    d = −1
   a = 2,    b = 1,    c = −0.5, d = −1.01

Per creare gli attrattori scriviamo alcune funzioni.

Funzione che crea la lista dei punti di un attrattore:

(define (clifford a b c d x0 y0 iter)
  (local (out cur-x cur-y tmp-x tmp-y)
    (setq cur-x x0)
    (setq cur-y y0)
    (setq out '())
    (push (list cur-x cur-y) out -1)
    (for (i 1 iter)
      (setq tmp-x cur-x)
      (setq tmp-y cur-y)
      (setq cur-x (add (sin (mul a tmp-y)) (mul c (cos (mul a tmp-x)))))
      (setq cur-y (add (sin (mul b tmp-x)) (mul d (cos (mul b tmp-y)))))
      (push (list cur-x cur-y) out -1)
    )
    out))

(silent (setq cli1 (clifford -1.4 1.6 1.0 0.7 1 1 1000000)))

Vediamo i primi 5 punti calcolati:

(slice cli1 0 5)
;-> ((1 1)
;->  (-0.8154825870882191 0.979133937430603)
;->  (-0.5639934344312477 -0.9618963402690747)
;->  (1.679121223105813 -0.7625802163942428)
;->  (0.1727911152773017 0.6799287925667465))

Adesso normalizziamo i punti (che sono numeri float), cioè li moltiplichiamo per un fattore di zoom, li rendiamo numeri interi e li trasliamo sul quadrante positivo del piano cartesiano.
Funzione che crea normalizza una lista di punti di un attrattore:

(define (cliff-norm points zoom)
  (local (norm max-x min-x max-y min-y trasla-x trasla-y out)
    ; moltiplica le coordinate dei punti per il valore "zoom"
    ; e li rende numeri interi
    (setq norm (explode (map (fn(x) (int (mul zoom x))) (flat points)) 2))
    (setq max-x (norm 0 0))
    (setq min-x (norm 0 0))
    (setq max-y (norm 0 1))
    (setq min-y (norm 0 1))
    (dolist (el norm)
      ;(setq max-x (max (el 0) max-x))
      (setq min-x (min (el 0) min-x))
      ;(setq max-y (max (el 1) max-y))
      (setq min-y (min (el 1) min-y))
    )
    ; calcola i valori per la traslazione dei punti
    (setq trasla-x (add 10 (abs min-x)))
    (setq trasla-y (add 10 (abs min-y)))
    ; traslazione dei punti
    ; (solo se min-x e/o min-y minori di zero)
    (cond ((and (< min-x 0) (< min-y 0))
           (setq norm (map (fn(n) (list (add trasla-x (n 0)) (add trasla-y (n 1)))) norm)))
          ((< min-x 0)
           (setq norm (map (fn(n) (list (add trasla-x (n 0)) (n 1))) norm)))
          ((< min-y 0)
           (setq norm (map (fn(n) (list (n 0) (add trasla-y (n 1)))) norm)))
    )
    norm))

Normalizziamo i punti calcolati sopra:

(silent (setq cli1-norm (cliff-norm cli1 1000)))

Vediamo i primi 5 punti normalizzati:

(slice cli1-norm 0 5)
;-> ((2429 2314) (614 2293) (866 353) (3108 552) (1601 1993))

Vediamo quanti sono i punti unici:

(length cli1-norm)
;-> 1000001
(length (unique cli1-norm))
;-> 716405

Vediamo i valori massimi e minimi dei punti:

(apply max (map first cli1-norm))
;-> 3408
(apply max (map last cli1-norm))
;-> 2849

(apply min (map first cli1-norm))
;-> 10
(apply min (map last cli1-norm))
;-> 10

Il prossimo passo è quello di rappresentare graficamente tutti i punti. L'approccio è quello scrivere un file di testo dei punti ed utilizzare un programma esterno per la visualizzazione. Il formato del file di testo dipende dal programma scelto. Ad esempio con Wolfram Mathematica possiamo scrivere un file con il seguente formato (es. clifford.txt):

  2429 2314
  614 2293
  866 353
  3108 552
  1601 1993
  1585 1912
  1662 1964
  ...  ...

E poi possiamo visualizzare l'attrattore con il seguente comando:

ListPlot[Import["clifford.txt", "Table"], PlotStyle -> PointSize[0.0001]]

Invece di utilizzare Mathematica, vediamo di creare l'immagine dei punti con "ImageMagick".
Il formato del file di testo per ImageMagick è il seguente:

# ImageMagick pixel enumeration: 4,4,255,rgba
0,0: (187,102,127,128)
0,1: ( 51,153,127,10)
0,2: (204,102,127,255)
0,3: ( 68,153,127,128)
1,1: ( 51,153,127,200)
1,2: (204,102,127,255)
1,3: ( 68,153,127,255)
2,0: (187,102,127,150)
2,1: ( 51,153,127,128)
2,2: (204,102,127,45)
3,0: (187,102,127,255)
3,1: ( 51,153,127,255)
3,2: (204,102,127,150)

Per informazioni dettagliate su questo formato vedi il capitolo precedente "Creazione di immagini con ImageMagick".

Scriviamo una funzione che esporta i punti nel formato richiesto da ImageMagick:

(define (list-IM lst file-str)
  (local (outfile x-width y-height line)
    (setq lst (sort (unique lst)))
    (setq outfile (open file-str "write"))
    (print outfile { })
    ; calcolo dimensioni immagine
    (setq x-width (add 1 (apply max (map first lst))))
    (setq y-height (add 1 (apply max (map last lst))))
    ; scrittura del file in formato ImageMagick
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el lst)
      (setq line (string (string (el 0)) ", " (string (el 1))
            ": (0,0,0,128)")) ; colore nero con alpha=50%
      (write-line outfile line)
    )
    (close outfile)))

In questo caso il colore di ogni punto è nero con alpha = 128 (50%). Vedremo in seguito altri metodi per colorare i punti.

(list-IM cli1-norm "cli1-IM.txt")
;-> 3 true

Adesso per creare l'immagine possiamo apriamo una finestra DOS (command prompt) e digitiamo:

  convert cli1-IM.txt cli1-IM.png

oppure

  convert cli1-IM.txt -background white -flatten cli1-IM.png

In alternativa possiamo eseguire i comandi direttamente dalla REPL di newLISP con la funzione "exec":

(exec "convert cli1-IM.txt cli1-IM.png")

oppure

(exec "convert cli1-IM.txt -background white -flatten cli1-IM.png")

Nota: naturalmente dovete aver installato il programma ImageMagick.

Le immagini create con questo metodo non sono così attraenti come quelle che è possibile trovare sul web (es. http://paulbourke.net/fractals/clifford/). Questo è dovuto al fatto che dobbiamo colorare i punti in qualche modo.

Domanda: Come vengono colorati i punti?

Risposta: Il fatto principale è che non viene disegnato l'attrattore direttamente come immagine finale. Piuttosto viene creata una grande griglia di 32 bit (int o float) e invece di disegnarla con un colore viene calcolato quante volte ogni punto viene attraversato dalla curva. Quindi è essenzialmente un istogramma 2D di frequenza. Successivamente viene applicato il processo di colorazione, cioè viene applicata una formula che genera un colore in funzione della frequenza del punto. Per avere più informazioni (cioè per ottenere sfumature di colore più uniformi) si deve valutare un numero maggiore di punti.
Si può anche salvare la griglia come raw a 16 o 32 bit, aprirla in GIMP e applicare la "color map" desiderata (GIMP Menu: Colors->Map->Set Colormap...).

Vediamo come creare un file con la frequenza di passaggio dei punti che verrà utilizzata per colorare i punti.

(define (list-IM-freq lst file-str)
  (local (outfile freq all x-width y-height line r g b alpha)
    (sort lst)
    ; calcolo dimensioni immagine
    (setq x-width (+ 1 (apply max (map first lst))))
    (setq y-height (+ 1 (apply max (map last lst))))
    ; calcolo frequenza dei punti
    (setq freq (count (flat (explode lst) 1) lst))
    ; creazione lista di elementi: ((x y) freq)
    (setq all (map list lst freq))
    ; eliminazione degli elementi con freq = 0
    (setq all (clean (fn(n) (zero? (n 1))) all))
    ; scrittura del file in formato ImageMagick
    (setq outfile (open file-str "write"))
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el all)
      ; (el 0 0) --> x
      ; (el 0 0) --> y
      ; (el 1)   --> freq
      ; calcola il colore
      (map set '(r g b alpha) (make-col (el 1)))
      (setq line (string (el 0 0) ", " (el 0 1) ": ("
                  r "," g "," b "," alpha ")"))
      (write-line outfile line)
    )
    (print outfile { })
    (close outfile)))

La funzione per colorare i punti assegna sempre il colore rosso con alpha in funzione lineare della frequenza di passaggio:

(define (make-col num)
  (let ((r 90) (g 20) (b 20))
    (setq alpha (% (+ 128 num) 255))
    (list r g b alpha)))

Calcoliamo i punti dell'attrattore con i nuovi colori:

(list-IM-freq cli1-norm "cli1-IM-freq.txt")
;-> 3 true

Creiamo l'immagine con ImgeMagick:

(exec "convert cli1-IM-freq.txt -background white -flatten cli1-IM-freq.png")

Il risultato delle due immagini è visibile nel file "clifford.png" che si trova nella cartella "data".

Nota: per risultati "artistici" occorre scrivere funzioni più complesse per la generazione del colore dei punti.


---------------------------------------------
Controllare se un numero è NaN (Not a Number)
---------------------------------------------

In informatica, NaN è un simbolo indicante che il risultato di un'operazione (numerica) è stato ottenuto eseguendola su operandi non validi. Il suo nome è l'acronimo di "Not a Number" (non è un numero). Esempi sono la divisione per zero o la radice quadrata di un numero negativo o il logaritmo naturale di un numero negativo, a cui le FPU assegnano come risultato "NaN".

newLISP gestisce NaN come definito dallo standard IEEE 754 e mette a disposizione una funzione per verificare se un simbolo è NaN: "NaN?".

(setq a (log -1))
;-> 1.#QNAN

(NaN? a)
;-> true

Se volessimo scrivere una funzione che verifica se un simbolo è NaN dobbiamo utilizzare una proprietà particolare del simbolo:

  Un simbolo NaN non è uguale ad alcun altro simbolo, anche a se stesso.

Questo ci permette di stabilire un test per stabilire se un simbolo è NaN:

  Un simbolo è NaN se è diverso da se stesso (poichè tutti gli altri simboli sono uguali a se stessi)

(define (isNaN? x) (!= x x))

(isNaN? a)
;-> true


-------------------------
Interpolazione dei colori
-------------------------

L'interpolazione (lerping) è una tecnica che consente di "inserire un numero" tra due numeri. L'interpolazione più comune è quella lineare basata su tre parametri, il punto iniziale "a", il punto finale "b" e un valore "t" compreso tra 0 e 1 che ci permette di spostarci lungo il segmento che collega i numeri "a" e "b":

  c = a + (b-a)*t

Quando t=0, viene restituito "a".
Quando t=1, viene restituito "b".

Questa formula è facile da capire, efficiente da implementare e funziona in qualsiasi dimensione.

L'interpolazione in due (tre) dimensioni richiede solo che l'interpolazione delle componenti X e Y (X,Y e Z) siano indipendenti. L'interpolazione restituisce sempre punti sulla retta che collega "a" e "b", indipendentemente dal numero di dimensioni.
Quindi una interpolazione RGB standard può essere scritta nel modo seguente:

(define (lerpRGB c1 c2 t)
  (let ((r1 (c1 0)) (g1 (c1 1)) (b1 (c1 2))
        (r2 (c2 0)) (g2 (c2 1)) (b2 (c2 2)))
    (list (int (add r1 (mul (sub r2 r1) t)))
          (int (add g1 (mul (sub g2 g1) t)))
          (int (add b1 (mul (sub b2 b1) t))))))

(lerpRGB '(0 0 0) '(255 255 255) 0.5)
;-> (127 127 127)

Funzione che genera un determinato numero di colori interpolati tra un colore iniziale e un colore finale:

(define (lerpColors c1 c2 numcolors)
  (local (t tmp out)
    (setq out '())
    (setq t (div numcolors))
    (push c1 out)
    (for (i 1 numcolors)
      (setq tmp (lerpRGB c1 c2 t))
      (setq c1 tmp)
      (push c1 out -1)
    )
    (push c2 out -1)
    out))

Vediamo una scala di toni di grigio con 5 colori che va dal bianco al nero:

(lerpColors '(255 255 255) '(0 0 0) 5)
;-> ((255 255 255) (204 204 204) (163 163 163) (130 130 130)
;-> (104 104 104) (83 83 83) (0 0 0))

Purtroppo, anche se l'interpolazione lineare funziona come ci si aspetta in tre dimensioni, lo stesso non può dirsi per i colori. Infatti c'è una differenza fondamentale tra gli spazi XYZ e RGB: il modo con cui l'occhio umano percepisce i colori non è lineare come lo spazio RGB.

L'argomento è abbastanza complicato, per maggiori informazioni:
https://www.alanzucconi.com/2016/01/06/colour-interpolation/
https://web.archive.org/web/20151229203152/https://www.stuartdenman.com/improved-color-blending/


-----------------------
Distanza tra due colori
-----------------------

La distanza o differenza tra due colori è una metrica della scienza del colore. La quantificazione di queste proprietà è di fondamentale per coloro che lavorano con i colori.
Il calcolo di questa distanza non è immediato in quanto la percezione umana dei colori non è lineare come lo spazio di colore RGB. Questo comporta che non è corretto usare la distanza euclidea tra due colori RGB (es. col1 = (10 30 150) e col2 = (250 30 50)).
Esistono diverse formule che producono risultati simili in alcuni casi, ma differenti in altri.

Vediamo una funzione che calcola la distanza tra due colori utilizzando la distanza euclidea:

(define (dist-color1 r1 g1 b1 r2 g2 b2)
  (sqrt (add (mul (sub r1 r2) (sub r1 r2))
             (mul (sub g1 g2) (sub g1 g2))
             (mul (sub b1 b2) (sub b1 b2)))))

(dist-color1 10 30 150 250 30 50)
;-> 260
(dist-color1 10 30 150 250 30 60)
;-> 256.32011

Vediamo un'altra funzione:

(define (dist-color2 r1 g1 b1 r2 g2 b2)
  (local (r g b rmean)
    (setq rmean (div (add r1 r2) 2))
    (setq r (sub r1 r2))
    (setq g (sub g1 g2))
    (setq b (sub b1 b2))
    (sqrt (add (>> (int (mul (add 512 rmean) r r)) 8)
               (mul 4 g g)
               (>> (int (mul (add 767 rmean) b b)) 8)))))

(dist-color2 10 30 150 250 30 50)
;-> 423.6614214204546
(dist-color2 10 30 150 250 30 60)
;-> 415.7294793492519

La seguente funzione permette di utilizzare diversi metodi per calcolare la distanza tra due colori.
Riporto la versione che ho scritto in linguaggio Processing (java) per un programma di grafica.

//*********************************
double deltaE(color col1, color col2, int m)
{
  double result = 0.0;
  if (col1 == col2) { return result; }
  //if (col1==color(0,0,0)) {col1=color(1,1,1);}
  //if (col2==color(0,0,0)) {col2=color(1,1,1);}
  double[] xyz1 = rgb2xyz(col1);
  double[] lab1 = xyz2lab(xyz1);

  double[] xyz2 = rgb2xyz(col2);
  double[] lab2 = xyz2lab(xyz2);

  double c1 = Math.sqrt(lab1[1]*lab1[1]+lab1[2]*lab1[2]);
  double c2 = Math.sqrt(lab2[1]*lab2[1]+lab2[2]*lab2[2]);
  double dc = c1-c2;
  double dl = lab1[0]-lab2[0]; // lightness difference
  double da = lab1[1]-lab2[1]; // color difference
  double db = lab1[2]-lab2[2]; // opponent difference

  double dh = Math.sqrt((da*da)+(db*db)-(dc*dc));

  // color distance CIE76
  // deltaE = 2.3 correspond to JND (just noticeable difference)
  if (m == 1)
  {
    result = Math.sqrt((da*da)+(db*db)+(dc*dc));
    if (isNaN(result)) { println("is NaN"); };
  }

  double primo, secondo, terzo;

  // color distance CIE94 (graphic arts)
  if (m == 2)
  {
    primo = dl;
    secondo = dc / (1.0 + 0.045*c1);
    terzo = dh / (1.0 + 0.015*c1);
    result = (Math.sqrt(primo*primo + secondo*secondo + terzo*terzo));
    if (isNaN(result)) { println("is NaN"); };

  }

  // color distance CIE94 (textiles)
  if (m == 3)
  {
    primo = dl / 2.0;
    secondo = dc / (1.0 + 0.048*c1);
    terzo = dh / (1.0 + 0.014*c1);
    result = (Math.sqrt(primo*primo + secondo*secondo + terzo*terzo));
    if (isNaN(result)) { println("is NaN"); };
  }
  return result;
}

//*********************************
double [] rgb2xyz(color rgb)
{
  double[] result = new double[3];

  //double rr = red(rgb)/255.0;
  //double gg = green(rgb)/255.0;
  //double bb = blue(rgb)/255.0;
  double rr = ((rgb >> 16) & 0xFF) / 255.0;
  double gg = ((rgb >> 8) & 0xFF) / 255.0;
  double bb = (rgb & 0xFF) / 255.0;

  if (rr > 0.04045) {
    rr = (rr + 0.055) / 1.055;
    rr = Math.pow(rr, 2.4);
  } else {
    rr = rr / 12.92;
  }
  if (gg > 0.04045) {
    gg = (gg + 0.055) / 1.055;
    gg = Math.pow(gg, 2.4);
  } else {
    gg = gg / 12.92;
  }
  if (bb > 0.04045) {
    bb = (bb + 0.055) / 1.055;
    bb = Math.pow(bb, 2.4);
  } else {
    bb = bb / 12.92;
  }

  bb *= 100.0;
  rr *= 100.0;
  gg *= 100.0;

  result[0] = rr * 0.4124 + gg * 0.3576 + bb * 0.1805;
  result[1] = rr * 0.2126 + gg * 0.7152 + bb * 0.0722;
  result[2] = rr * 0.0193 + gg * 0.1192 + bb * 0.9505;

  return result;
}

//*********************************
double [] xyz2lab(double[] xyz)
{
  double[] result = new double[3];

  // luminance values
  double x = xyz[0] / 95.047;
  double y = xyz[1] / 100.0;
  double z = xyz[2] / 108.8900;

  if (x > 0.008856) {
    x = Math.pow(x, 1.0/3.0);
  } else {
    x = 7.787*x + 16.0/116.0;
  }
  if (y > 0.008856) {
    y = Math.pow(y, 1.0/3.0);
  } else {
    y = (7.787*y) + (16.0/116.0);
  }
  if (z > 0.008856) {
    z = Math.pow(z, 1.0/3.0);
  } else {
    z = 7.787*z + 16.0/116.0;
  }

  result[0] = 116.0*y - 16.0;
  result[1] = 500.0*(x-y);
  result[2] = 200.0*(y-z);

  return result;
}

//*********************************
boolean isNaN(double x)
{
  return (x != x);
}


-----------
Random-walk
-----------

Una passeggiata casuale (random-walk) è un processo che descrive un percorso che consiste in una successione di passaggi casuali su uno spazio matematico (in questo caso in un piano cartesiano).

L'approccio è quello di costruire una lista di punti visitati dalla passeggiata con associato il numero di volte che si è passati sul quel punto (frequenza). Poi convertiamo i punti nel formato di ImageMagick e creiamo le immagini finali.

La seguente funzione genera una lista con elementi della seguente struttura:

  ((x y) frequenza)

dove x,y = coordinate di un punto della camminata
     frequenza = numero di passaggi sul punto

(define (rnd-walk start iter)
  (local (pos moves path unici freq min-x min-y start-x start-y out)
    ; inizializzazione generatore numeri random
    (seed (time-of-day))
    ; mosse possibili: -1 o +1 lungo x o lungo y
    (setq moves '(-1 +1))
    ; posizione iniziale
    (setq pos start)
    ; lista dei punti visitati (anche quelli multipli)
    (setq path '())
    ; posizione iniziale visitata
    (push pos path -1)
    ; inizio della passeggiata...
    (for (i 1 iter)
      ; aggiorna coordinate x o y (pos)
      (++ (pos (rand 2)) (moves (rand 2)))
      ; aggiorna la lista del percorso
      (push pos path -1)
    )
    ; calcola i valori per la traslazione dei punti
    ; sul quadrante positivo
    (setq min-x (apply min (map first path)))
    (setq min-y (apply min (map last path)))
    ;(println min-x { } min-y)
    ; traslazione dei punti
    ; (solo se min-x e/o min-y minori di zero)
    ; e calcolo della posizione iniziale dopo la traslazione
    (setq start-x (start 0))
    (setq start-y (start 1))
    (cond ((and (< min-x 0) (< min-y 0))
           (setq start-x (abs min-x))
           (setq start-y (abs min-y))
           (setq path (map (fn(n) (list (add (abs min-x) (n 0)) (add (abs min-y) (n 1)))) path)))
          ((< min-x 0)
           (setq start-x (abs min-x))
           (setq path (map (fn(n) (list (add (abs min-x) (n 0)) (n 1))) path)))
          ((< min-y 0)
           (setq start-y (abs min-y))
           (setq path (map (fn(n) (list (n 0) (add (abs min-y) (n 1)))) path)))
    )
    (println start-x { } start-y)
    ; crea lista con elementi del tipo: (frequenza (x y))
    (setq unici (unique path))
    (setq freq (count unici path))
    (setq out (sort (map list unici freq)))
    (push (list (list start-x start-y) 1) out)
    out
  ))

(rnd-walk '(0 0) 10)
;-> 2 0
;-> (((2 0) 1) ((0 2) 1) ((0 3) 1) ((1 1) 1) ((1 2) 2)
;->  ((1 3) 2) ((2 0) 1) ((2 1) 1) ((2 2) 1) ((2 3) 1))

Adesso dobbiamo scrivere la funzione che converte i punti nel formato di ImageMagick (file di testo). Usiamo due metodi per applicare il colore ai punti:
1) colore uguale per tutti i punti (nero con alpha=50%)
2) colore che va dal rosso (255 0 0) al blu (0 0 255) in funzione della frequenza (anche alpha varia).

Per questo secondo caso usiamo le seguenti funzioni per calcolare il colore:

(define (lerpRGB c1 c2 t)
  (let ((r1 (c1 0)) (g1 (c1 1)) (b1 (c1 2))
        (r2 (c2 0)) (g2 (c2 1)) (b2 (c2 2)))
    (list (int (add r1 (mul (sub r2 r1) t)))
          (int (add g1 (mul (sub g2 g1) t)))
          (int (add b1 (mul (sub b2 b1) t))))))

(lerpRGB '(0 0 0) '(255 255 255) 0.5)
;-> (127 127 127)

(define (make-col num max-num)
  (push (int (mul (div num max-num) 255))
        (lerpRGB '(255 0 0) '(0 0 255) (div num max-num)) -1))

(make-col 10 60)
;-> (212 0 42 42)

Adesso scriviamo la funzione per creare il file di testo per ImageMagick:

(define (walk-IM lst-freq file-str tipo)
  (local (outfile x-width y-height max-f line r g b alpha)
    ; calcolo dimensioni immagine
    (setq x-width (+ 1 (apply max (map (fn(n) (n 0 0)) lst-freq))))
    (setq y-height (+ 1 (apply max (map (fn(n) (n 0 1)) lst-freq))))
    ; calcolo frequenza massima
    (setq max-f (apply max (map (fn(n) (n 1)) lst-freq)))
    ; scrittura del file in formato ImageMagick
    (setq outfile (open file-str "write"))
    (print outfile { }) ; handle del file
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                (string x-width) "," (string y-height) ",256,rgba"))
    (dolist (el lst-freq)
      ; (el 0 0) --> x
      ; (el 0 0) --> y
      ; (el 1)   --> freq
      ; Assegna  il colore
      (if (= tipo 0)
          ; colore nero - alpha=50%
          (set 'r 0 'g 0 'b 0 'alpha 128)
          ; altrimenti calcola il colore in base alla frequenza
          (map set '(r g b alpha) (make-col (el 1) max-f))
      )
      (setq line (string (el 0 0) ", " (el 0 1) ": ("
                  r "," g "," b "," alpha ")"))
      (write-line outfile line)
    )
    ; posizione iniziale: colore rosso (255,0,0)
    (setq line (string (lst-freq 0 0 0) ", " (lst-freq 0 0 1) ": (255,0,0,255)"))
    (write-line outfile line)
    (close outfile)))

Proviamo a fare quattro passeggiate, le prime due con 1 milione di passi e le altre due con 10 milioni di passi:

Passeggiata 1
-------------
Creazione dei punti:
(silent (setq w01 (rnd-walk '(0 0) 1e6)))
;-> 1190 51

Colore unico:
(walk-IM w01 "w01a.txt" 0)
;-> 3 true

Colore in funzione della frequenza:
(walk-IM w01 "w01b.txt")
;-> 3 true

Creazione file .png:
(exec "convert w01aa.txt -background white -flatten w01aa.png")
(exec "convert w01b.txt -background white -flatten w01b.png")

Passeggiata 2
-------------
Creazione dei punti:
(silent (setq w02 (rnd-walk '(0 0) 1e6)))
;-> 137 81

Colore unico:
(walk-IM w02 "w02a.txt" 0)
;-> 3 true

Colore in funzione della frequenza:
(walk-IM w02 "w02b.txt")
;-> 3 true

Creazione file .png:
(exec "convert w02a.txt -background white -flatten w02a.png")
(exec "convert w02b.txt -background white -flatten w02b.png")

Passeggiata 3
-------------
Creazione dei punti:
(silent (setq w03 (rnd-walk '(0 0) 1e7)))
;-> 242 3818

Colore unico:
(walk-IM w03 "w03a.txt" 0)
;-> 3 true

Colore in funzione della frequenza:
(walk-IM w03 "w03b.txt")
;-> 3 true

Creazione file .png:
(exec "convert w03a.txt -background white -flatten w03a.png")
(exec "convert w03b.txt -background white -flatten w03b.png")

Passeggiata 4
-------------
Creazione dei punti:
(silent (setq w04 (rnd-walk '(0 0) 1e7)))
;-> 2404 1700

Colore unico:
(walk-IM w04 "w04a.txt" 0)
;-> 3 true

Colore in funzione della frequenza:
(walk-IM w04 "w04b.txt")
;-> 3 true

Creazione dei file .png:
(exec "convert w04a.txt -background white -flatten w04a.png")
(exec "convert w04b.txt -background white -flatten w04b.png")

Potete caricare le immagini in GIMP e poi applicare la mappa di colore desiderata:
GIMP Menu: Colors->Map->Set Colormap...

Versione finale
---------------
La lista "lst" contiene punti 2D nel seguente formato: ((x0 y0) (x1 y1) ... (xn yn)).

(define (list-IM lst file-str col1 col2 tipo)
  (local (min-x min-y unique-points lst-freq x-width y-height
          min-f max-f outfile line r g b alpha)
    ; calcola i valori per la traslazione dei punti
    ; sul quadrante positivo
    (setq min-x (apply min (map first lst)))
    (setq min-y (apply min (map last lst)))
    (println "min-x = " min-x)
    (println "min-y = " min-y)
    ; traslazione dei punti
    ; (solo se min-x e/o min-y minori di zero)
    (cond ((and (< min-x 0) (< min-y 0))
           (setq lst (map (fn(n) (list (add (abs min-x) (n 0)) (add (abs min-y) (n 1)))) lst)))
          ((< min-x 0)
           (setq lst (map (fn(n) (list (add (abs min-x) (n 0)) (n 1))) lst)))
          ((< min-y 0)
           (setq lst (map (fn(n) (list (n 0) (add (abs min-y) (n 1)))) lst)))
    )
    ; crea lista delle frequenze con elementi del tipo: ((x y) frequenza)
    (setq unique-points (unique lst))
    (setq lst-freq (count unique-points lst))
    (setq lst-freq (sort (map list unique-points lst-freq)))
    ; calcolo dimensioni immagine
    (setq x-width (+ 1 (apply max (map (fn(n) (n 0 0)) lst-freq))))
    (setq y-height (+ 1 (apply max (map (fn(n) (n 0 1)) lst-freq))))
    ; calcolo frequenza massima
    (setq min-f (apply min (map (fn(n) (n 1)) lst-freq)))
    (setq max-f (apply max (map (fn(n) (n 1)) lst-freq)))
    (println "min-f = " min-f)
    (println "max-f = " max-f)
    ; scrittura del file in formato ImageMagick
    (setq outfile (open file-str "write"))
    (println "handle = " outfile) ; handle del file
    (write-line outfile (string "# ImageMagick pixel enumeration: "
                x-width "," y-height ",256,rgba"))
    (dolist (el lst-freq)
      ; (el 0 0) --> x
      ; (el 0 0) --> y
      ; (el 1)   --> freq
      ; Assegna il colore ai punti
      (cond ((= tipo 0) ; random color - alpha = 99.9%
             (setq alpha 254)
             (map set '(r g b) (rand 256 3)))
            ((= tipo 1) ; colore 1 - alpha = 99.9%
             (setq alpha 254)
             (set 'r (col1 0) 'g (col1 1) 'b (col1 2)))
            ((= tipo 2) ; colore 2 - alpha = 99.9%
             (setq alpha 254)
             (set 'r (col2 0) 'g (col2 1) 'b (col2 2)))
            (true ; gradiente colori (dal col1 a col2) in base alla frequenza
             (map set '(r g b alpha) (make-col col1 col2 (el 1) min-f max-f)))
      )
      (setq line (string (el 0 0) ", " (el 0 1) ": ("
                  r "," g "," b "," alpha ")"))
      (write-line outfile line)
    )
    (close outfile)))

(define (lerpRGB c1 c2 t)
  (let ((r1 (c1 0)) (g1 (c1 1)) (b1 (c1 2))
        (r2 (c2 0)) (g2 (c2 1)) (b2 (c2 2)))
    (list (int (add r1 (mul (sub r2 r1) t)))
          (int (add g1 (mul (sub g2 g1) t)))
          (int (add b1 (mul (sub b2 b1) t))))))

(lerpRGB '(0 0 0) '(255 255 255) 0.5)
;-> (127 127 127)

(define (make-col col1 col2 num min-num max-num)
  ;(push 255
  (push (int (mul (div num max-num) 255))
        (lerpRGB col1 col2 (div num max-num)) -1))

(make-col '(0 0 0) '(255 255 255) 128 0 255)
;-> (128 128 128 128)

Funzione che genera i punti di una passeggiata casuale su un piano cartesiano 2D:

(define (rnd-walk start iter)
  (local (pos moves path)
    ; inizializzazione generatore numeri random
    (seed (time-of-day))
    ; mosse possibili: -1 o +1 lungo x o lungo y
    (setq moves '(-1 +1))
    ; posizione iniziale
    (setq pos start)
    ; lista dei punti visitati (anche quelli multipli)
    (setq path '())
    ; posizione iniziale visitata
    (push pos path -1)
    ; inizio della passeggiata...
    (for (i 1 iter)
      ; aggiorna coordinate x o y (pos)
      (++ (pos (rand 2)) (moves (rand 2)))
      ; aggiorna la lista del percorso
      (push pos path -1)
    )
    path))

(time (setq walk (rnd-walk '(0 0) 1e7)))
;-> 2478.029

(time (list-IM walk "walk.txt" '(100 100 0) '(255 10 10)))
;-> min-x = -484
;-> min-y = -2791
;-> min-f = 1
;-> max-f = 73
;-> handle = 3 - 61903.019
(exec "convert walk.txt walk-tr.png")
(exec "convert walk.txt -background white -flatten walk.png")

Un risultato tra le tante prove: "random-walk.png" nella cartella "data".


-----------------------------------------
Script e argomenti della linea di comando
-----------------------------------------

newLISP permette di creare un file eseguibile (exe) partendo da uno script con il seguente comando dal Command Prompt:

  newlisp -x "script.exe" "script.nl"

Possiamo scrivere una funzione per crearlo dalla REPL:

(define (make-exe file-lsp file-exe)
  (local (cmd)
    (setq cmd (string "newlisp -x " file-lsp " " file-exe))
    (println cmd)
    (exec cmd)
  ))

Il file "script.nl" contiene il seguente script:

------------------------------------------------
; script.nl
; only for Windows
; Command line arguments of a script
(define (info)
  (setq dir (real-path))
  (println "Directory corrente: " dir)
  ; argomenti della linea di comando
  (setq argv (main-args)) ; argument values
  (println "Linea di comando: " argv)
  (setq argc (length argv)) ; argument count
  (println "Numero di argomenti: " argc)
  (if (> argc 1) (begin
      ; Check running mode of script
      (cond ((find "newlisp" (argv 0))
            ; running script.lsp with newlisp.exe
            (setq exe (argv 0))
            (setq script (argv 1)))
            (true
            ; running script.exe
            (setq exe (argv 0))
            (setq script nil))
      )
      (println "Nome eseguibile: " exe)
      (println "Nome script: " script)
  ))
  ; lista di tutti i parametri
  (map (fn(x) (println "arg"$idx " = " x)) argv)
  )

(info)
; don't exit when script is loaded
; from REPL with "load"
(if (> argc 1) (exit))
------------------------------------------------

Impostiamo la cartella corrente dove si trova lo script:

(change-dir "F:\\newLisp\\script")
(real-path)

Creiamo lo script eseguibile con il seguente comando:

(make-exe "script.nl" "script.exe")

Adesso, dal Command Prompt, eseguiamo "script.exe" oppure "script.nl" in diversi modi e vediamo come cambiano gli argomenti della linea di comando all'interno dello script stesso:

1) Tramite newlisp eseguiamo lo script "script.nl" (con tre parametri)

  newlisp.exe script.nl 1 2 3

Con il seguente output:
;-> Linea di comando: ("newlisp.exe" "script.nl" "1" "2" "3")
;-> Numero di argomenti: 5
;-> Nome eseguibile: newlisp.exe
;-> Nome script: script.nl
;-> arg0 = newlisp.exe
;-> arg1 = script.nl
;-> arg2 = 1
;-> arg3 = 2
;-> arg4 = 3

2) Eseguiamo lo script eseguibile "script.exe" (con tre parametri)

  script.exe 1 2 3

Con il seguente output:
;-> Directory corrente: f:\Lisp-Scheme\newLisp\MAX\script
;-> Linea di comando: ("script.exe" "1" "2" "3")
;-> Numero di argomenti: 4
;-> Nome eseguibile: script.exe
;-> Nome script: nil
;-> arg0 = script.exe
;-> arg1 = 1
;-> arg2 = 2
;-> arg3 = 3

3) Eseguiamo lo "script.nl" sfruttando l'associazione di file di windows:

   script.nl 1 2 3

Con il seguente output:
;-> Directory corrente: f:\Lisp-Scheme\newLisp\MAX\script
;-> Linea di comando: ("C:\\newlisp\\newlisp.exe" "F:\\Lisp-Scheme\\newLisp\\MAX\\script\\script.nl" "1"
;->  "2" "3")
;-> Numero di argomenti: 5
;-> Nome eseguibile: C:\newlisp\newlisp.exe
;-> Nome script: F:\Lisp-Scheme\newLisp\MAX\script\script.nl
;-> arg0 = C:\newlisp\newlisp.exe
;-> arg1 = F:\Lisp-Scheme\newLisp\MAX\script\script.nl
;-> arg2 = 1
;-> arg3 = 2
;-> arg4 = 3

Nota: per associare i file .nl con newlisp.exe ho usato Total Commander con la seguente impostazione:

  newLISP file ("C:\newlisp\newlisp.exe" "%1" %*)
  newLISP file (C:\newlisp\newlisp.exe "1" "%1")

Uso l'estensione .nl per gli script che dovranno essere convertiti in eseguibili (.exe) e l'estensione .lsp per gli script che utilizzo dalla REPL.

4) Utilizzando la REPL utilizziamo la funzione "load":

(load "script.nl")

;-> Directory corrente: F:\Lisp-Scheme\newLisp\MAX\script
;-> Linea di comando: ("newlisp.exe")
;-> Numero di argomenti: 1
;-> arg0 = newlisp.exe
;-> nil

Come si nota, i valori dei parametri della linea di comando nello script variano in base alla modalità che viene usata per eseguire lo script.
Questo comportamento deve essere considerato quando usiamo gli argomenti all'interno dello script.


--------------------------------
Creazione di una serie di colori
--------------------------------

Vediamo un metodo per generare un file .png con una serie di colori.
Utilizziamo il modulo "guiserver.lsp" che contiene funzione per la creazione di GUI e grafica 2D.

Funzione che genera un colore da un numero n:

(define (c-new-color n , r g b)
  (set 'r (round (div (/ n 100) 9) -1)
       'n (% n 100)
       'g (round (div (/ n 10) 9) -1)
       'b (round (div (% n 10) 9) -1))
  (list r g b)
)

Poi utilizziamo il seguente script per creare l'immagine .png con N=1000 colori:

(load (append (env "NEWLISPDIR") "/guiserver.lsp"))
(gs:init)
(gs:frame 'Colors 0 0 1700 950 "colors") ; crea finestra
(gs:set-border-layout 'Colors)
(gs:canvas 'MyCanvas 'Colors) ; crea canvas grafico
(gs:add-to 'Colors 'MyCanvas "center")
(gs:set-background 'MyCanvas gs:white) ; colore background canvas
(gs:set-paint gs:black) ; default color (if not specified in shape or text)
(set 'R 15) ; raggio del cerchio di colore
(set 'x -15 'y -20) ; posizione del cerchio
; ciclo per la creazione dei colori
(dotimes (N 1000)
  (set 'x (add x 30))
  (if (= (% N 56) 0) ; nuova riga
    (set 'x 15 'y (add y 50)) ; posizione corrente del cerchio
  )
  (set 'c-curr (c-new-color N)) ; crea colore
  (gs:fill-circle 'C x y R c-curr) ; crea cerchio
  (gs:draw-text 'T (string N) (- x 10) (+ y 25) gs:black) ; crea testo
)
(gs:set-visible 'Colors true) ; rende visibile la finestra
(gs:export "color1000.png") ; esporta la finestra come file .png
(gs:listen) ; exit application when the guiserver exit

Possiamo trovare il file "color1000.png" nella cartella "data".

Nota: guiserver.lsp è molto interessante e necessita di un capitolo a parte (forse in futuro...).


--------------------------------
Traslazione e scalatura di punti
--------------------------------

Problema: trasferire i punti contenuti in un rettangolo (finestra) in un altro rettangolo (finestra). In altre parole si tratta delle operazioni di traslazione e scalatura di punti nel piano cartesiano.

Finestra di partenza: (x-min, x-max, y-min, y-max)
Punti di partenza: (x, y)
Finestra di arrivo: (v-min, v-max, w-min, w-max)
Punti di arrivo: (v, w)

Algoritmo:
Calcolare: delta-x = x-max - x-min, delta-y = x-max - x-min
Calcolare: delta-v = v-max - v-min, delta-w = w-max - w-min
Calcolare: scale-x = delta-v/delta-x
Calcolare: scale-y = delta-w/delta-y
Calcolare: scale = min(scale-x, scale-y) (mantiene le proporzioni)

Formula per le coordinate nei nuovi punti traslati e scalati:
  v = v-min + (x - xmin) * scale
  w = w-min + (y - ymin) * scale

Vediamo un esempio:

Finestra di partenza
(setq x-min -20)
(setq x-max -10)
(setq y-min -20)
(setq y-max -10)

Finestra di arrivo
(setq v-min 10)
(setq v-max 50)
(setq w-min 10)
(setq w-max 20)

Creazione dei punti della finestra di partenza:
(setq pts '())
(push (list x-min y-min) pts -1)
(push (list x-min y-max) pts -1)
(push (list x-max y-min) pts -1)
(push (list x-max y-max) pts -1)
(push '(-15 -12) pts -1)
;-> ((-20 -20) (-20 -10) (-10 -20) (-10 -10) (-15 -12))

Calcolo parametri di traslazione e scalatura:
(setq delta-x (sub x-max x-min))
(setq delta-y (sub y-max y-min))
(setq delta-v (sub v-max v-min))
(setq delta-w (sub w-max w-min))
(setq scale-x (div delta-v delta-x))
(setq scale-y (div delta-w delta-y))
; keep proportion
(setq scale (min scale-x scale-y))

Calcolo delle nuove coordinate dei punti:
(dolist (p pts)
  ; formula di trasformazione delle coordinate
  ; (traslazione e scalatura)
  (setq v (add v-min (mul (sub (p 0) x-min) scale)))
  (setq w (add w-min (mul (sub (p 1) y-min) scale)))
  (println v "," w)
)
;-> 10,10
;-> 10,20
;-> 20,10
;-> 20,20
;-> 15,18

Scriviamo la funzione finale:

(define (move-pts pts x-min x-max y-min y-max v-min v-max w-min w-max)
  (local (delta-x delta-y delta-v delta-w
         scale-x scale-y scale v w out)
    ; calcolo parametri di traslazione e scalatura:
    (setq delta-x (sub x-max x-min))
    (setq delta-y (sub y-max y-min))
    (setq delta-v (sub v-max v-min))
    (setq delta-w (sub w-max w-min))
    (setq scale-x (div delta-v delta-x))
    (setq scale-y (div delta-w delta-y))
    ; keep proportion
    (setq scale (min scale-x scale-y))
    ; calcolo delle nuove coordinate dei punti:
    (dolist (p pts)
      ; formula di trasformazione delle coordinate
      ; (traslazione e scalatura)
      (setq v (add v-min (mul (sub (p 0) x-min) scale)))
      (setq w (add w-min (mul (sub (p 1) y-min) scale)))
      ; (println v "," w)
      (push (list v w) out -1)
    )
    out))

(move-pts pts -20 -10 -20 -10 10 50 10 20)
;-> ((10 10) (10 20) (20 10) (20 20) (15 18))

Per verificare la funzione creiamo i punti di un attrattore di Clifford e li visualizziamo con il modulo "guiserver.lsp".

Funzione che genera un determinato numero di punti di un attrattore di Clifford:

(define (clifford a b c d x0 y0 iter)
  (local (out cur-x cur-y tmp-x tmp-y)
    (setq cur-x x0)
    (setq cur-y y0)
    (setq out '())
    (push (list cur-x cur-y) out -1)
    (for (i 1 iter)
      (setq tmp-x cur-x)
      (setq tmp-y cur-y)
      (setq cur-x (add (sin (mul a tmp-y)) (mul c (cos (mul a tmp-x)))))
      (setq cur-y (add (sin (mul b tmp-x)) (mul d (cos (mul b tmp-y)))))
      (push (list cur-x cur-y) out -1)
    )
    out))

Calcoliamo due liste di punti:
(silent (setq cli1 (clifford 1.5 -1.8 1.6 0.9 1 1 1e6)))
(silent (setq cli2 (clifford -1.4 1.6 1.0 0.7 1 1 1e6)))

Calcoliamo i valori min e max delle coordinate:

(setq x-min (apply min (map first cli1)))
;-> -1.414198192056608
(setq x-max (apply max (map first cli1)))
;-> 1.979049915412105
(setq y-min (apply min (map last cli1)))
;-> -1.30441834932098
(setq y-max (apply max (map last cli1)))
;-> 1.531612564048264

Trasliamo e scaliamo i punti con la funzione "move-pts":

(silent (setq points (move-pts cli1 x-min x-max y-min y-max 10 1850 10 950)))
(slice points 0 5)
;-> ((852.7468822251383 814.4249994149275)
;->  (218.9992905664541 807.1410865893224)
;->  (306.7889757764142 129.5673810757355)
;->  (1089.81411858894 199.1445361433653)
;->  (563.9852922103936 702.6947309382435))

I punti devono avere coordinate intere per essere disegnati come pixel:

(silent (setq points (map (fn(n) (list (int (n 0)) (int (n 1)))) points)))
(slice points 0 5)
;-> ((852 814) (218 807) (306 129) (1089 199) (563 702))

Adesso usiamo il modulo "guiserver.lsp" per visualizzare i punti e salvare l'immagine finale:

(setq width 1900)
(setq height 1000)
; importa le routine del server grafico
(load (append (env "NEWLISPDIR") "/guiserver.lsp"))
(gs:init) ; inizializza il server grafico
(gs:frame 'Test 0 0 width height "colors") ; crea finestra "Test"
(gs:set-border-layout 'Test) ; imposta tipo della finestra
(gs:canvas 'MyCanvas 'Test) ; crea canvas grafico "MyCanvas"
(gs:add-to 'Test 'MyCanvas "center") ; aggiunge il canvas alla finestra
(gs:set-background 'MyCanvas gs:white) ; colore background canvas
(gs:set-paint gs:black) ; default color (if not specified in shape or text)
(setq r 1) ; raggio del cerchio di colore
; ciclo per la creazione dei colori
(dolist (p points)
  (setq x (p 0))  ; x del punto
  (setq y (p 1))  ; y del punto
  (gs:fill-circle 'C x y r) ; crea punto (nero)
  ;(gs:draw-text 'T (string x " " y) (- x 10) (+ y 25) gs:black) ; crea testo
)
(gs:set-visible 'Test true) ; rende visibile il canvas
(gs:export "cli001.png") ; esporta la finestra come file .png
;(gs:listen) ; exit application when the guiserver exit
(gs:listen true) ; don't exit application when the guiserver exit

Attendere pochi secondi per vedere il risultato.

Note: l'immagine è riflessa lungo l'asse y perchè nel monitor lo 0,0 è in alto a sinistra (cioè la coordinata y cresce dall'alto verso il basso).


--------------------
SameGame - ChainShot
--------------------

SameGame (ChainShot) si gioca su una griglia rettangolare, inizialmente riempita con blocchi colorati posizionati a caso. Selezionando un gruppo di blocchi adiacenti dello stesso colore, un giocatore può rimuoverli dalla griglia.
I blocchi che non sono più supportati cadranno verso il basso, e una colonna senza blocchi scorrerà sempre a sinistra. L'obiettivo del gioco è rimuovere il maggior numero di blocchi possibile.
Ci sono tre livelli di difficoltà: 3 colori per principianti, 4 colori per i giocatori intermedi e 5 colori per esperti. Non ci sono vincoli di tempo durante il gioco.

Scriviamo una versione per di questo gioco per il terminale DOS.

; Funzione per creare la lista dei colori
(define (create-colors num-palette)
  ; normal colors
  (setq red "\027[0;31m")
  (setq green "\027[0;32m")
  (setq yellow "\027[0;33m")
  (setq blue "\027[0;34m")
  (setq magenta "\027[0;35m")
  (setq cyan "\027[0;36m")
  (setq black "\027[0;30m")
  (define white "\027[0;37m")
  ; bright colors
  (setq red-b "\027[0;91m")
  (setq green-b "\027[0;92m")
  (setq yellow-b "\027[0;93m")
  (setq blue-b "\027[0;94m")
  (setq magenta-b "\027[0;95m")
  (setq cyan-b "\027[0;96m")
  (setq black-b "\027[0;90m")
  (setq white-b "\027[0;97m")
  ; restore color to default
  (setq reset-color "\027[39;49m")
  ;(println reset-color)
  ; palettes of colors
  (if (= num-palette 1)
    (setq color '(red green yellow blue cyan black))
    ;else
    (setq color '(red-b green-b yellow-b blue-b cyan-b black))
  )
)

; Funzione per creare una griglia casuale
(define (create-grid row col num-colors)
  (array-list (array row col (rand num-colors (* row col)))))

; Funzione per visualizzare la griglia
(define (show-grid grid)
  (local (r c ch)
    (setq ch "█")
    (setq r (length grid))
    (setq c (length (grid 0)))
    (print "    ")
    (for (i 0 (- c 1))
      (print white (format "%-2d" i))
    )
    (println)
    (for (i 0 (- r 1))
      (print white (format "%4d" i))
      (for (j 0 (- c 1))
        (print (eval (color (grid i j))) ch)
        (print (eval (color (grid i j))) ch)
      )
      (println)
    )
    (print reset-color)))

;Funzione che mostra le regole del gioco
(define (show-info)
  (println "******************************************")
  (println "******  SAME-GAME by cameyo (2022)  ******")
  (println "******************************************")
  (println "SameGame is played on a rectangular grid, ")
  (println "initially filled with colored blocks placed at random.")
  (println "By selecting a group of adjoining blocks of the same color, ")
  (println "a player may remove them from the grid.")
  (println "Blocks that are no longer supported will fall down, ")
  (println "and a column without any blocks will always slides to the left.")
  (println "The goal of the game is to remove as many blocks as possible.")
  (println "There are 3 difficulty levels:")
  (println "  3 colors for beginners")
  (println "  4 colors for intermediate players")
  (println "  5 colors for experts.")
  (println "There are no time constraints during the game.")
  (println "Good Luck!!! \n")
)

; Funzione che conta i blocchi vuoti in una gliglia
(define (empty-count grid empty)
  (local (rows cols vuoti)
    (setq vuoti 0)
    (setq rows (length grid))
    (setq cols (length (grid 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
        (if (= (grid r c) empty) (++ vuoti))
      )
    )
    vuoti))

; Funzione per inserimento di numeri interi da parte dell'utente
(define (input-integer message min-val max-val)
  (local (val)
    (print message)
    (until (and (integer? (setq val (int (read-line))))
                (>= val min-val) (<= val max-val))
    (print message)
  )
  (int (current-line))))

; Funzione che verifica se il gioco è terminato
(define (endgame? grid empty)
  (local (rows cols val out)
    (setq out true)
    (setq rows (length grid))
    (setq cols (length (grid 0)))
    (for (r 0 (- rows 1))
      (for (c 0 (- cols 1))
                 ; blocco non vuoto
        (if (and (not (= (grid r c) empty))
                 ; blocco non isolato
                 (not (alone? r c grid)))
            (setq out nil)
        )
      )
    )
    out))

; Funzione che verifica se un blocco è isolato, cioè se non ha alcun blocco adiacente (alto, basso, destra, sinistra) dello stesso colore:
(define (alone? r c grid)
  (local (rows cols val out)
    (setq out true)
    (setq rows (length grid))
    (setq cols (length (grid 0)))
    (setq val (grid r c))
    ; basso
    (if (< (+ r 1) rows)
        (if (= val (grid (+ r 1) c))
            (setq out nil)))
    ; alto
    (if (>= (- r 1) 0)
        (if (= val (grid (- r 1) c))
            (setq out nil)))
    ; sinistra
    (if (< (+ c 1) cols)
        (if (= val (grid r (+ c 1)))
            (setq out nil)))
    ; destra
    (if (>= (- c 1) 0)
        (if (= val (grid r (- c 1)))
            (setq out nil)))
    out))

; Funzione che, partendo da una cella (riga,colonna) modifica la cella
; e tutte le celle adiacenti nel colore nero
; (cioè sono eliminate perchè il colore nero è invisibile)
(define (flood-fill grid r c new-value)
  (local (old-value dir max-r max-c)
    (setq max-r (length grid))
    (setq max-c (length (grid 0)))
    (setq dir '((0 1) (0 -1) (1 0) (-1 0)))
    ;----------------------------------
    ; recursive fill
    (define (fill r c)
    (catch
      (local (new-r new-c)
        (setq old-value (grid r c))
        (if (= old-value new-value) (throw grid))
        (setf (grid r c) new-value)
        (for (i 0 (- (length dir) 1))
          (setq new-r (+ r (dir i 0)))
          (setq new-c (+ c (dir i 1)))
          (cond ((or (< new-r 0) (>= new-r max-r) (< new-c 0) (>= new-c max-c)) nil)
                ((!= (grid new-r new-c) old-value) nil)
                (true (fill new-r new-c))
          )
        )
        grid)))
     ;----------------------------------
     (fill r c)))

; Funzione per compattare la nuova griglia dopo il flood-fill
; usa una tecnica del tipo bubble-sort
(define (compress grid value)
  (local (rows cols change tr vuoti)
    (setq rows (length grid))
    (setq cols (length (grid 0)))
    ;
    ; scroll down empty block
    ;
    ; ciclo fino a che esistono scambi di blocchi
    (do-while change
      (setq change nil)
      ; ciclo dal blocco in basso a destra per righe e colonne
      (for (c (- cols 1) 0 -1)
        (for (r (- rows 1) 0 -1)
          ; blocco nero e riga > 0 e blocco sopra non-nero
          (cond ((and (= (grid r c) value)
                      (> r 0)
                      (!= (grid (- r 1) c) value))
                 (swap (grid r c) (grid (- r 1) c))
                 ; scambio avvenuto
                 (setq change true))
          )
        )
      )
    )
    ; (setq debug grid)
    ;
    ; scroll columns to the left
    ; (instead scroll up rows of the transpose)
    ;
    (setq tr (transpose grid))
    (setq change nil)
    ; ciclo fino a che esistono scambi di colonne
    (do-while change
      (setq change nil)
      ; ciclo sulle righe della trasposta
      (for (r 0 (- cols 2))
        ; riga vuota?
        (setq vuoti (first (count (list empty) (tr r))))
        (cond ((and (= vuoti rows) ; tutta la riga vuota?
                    (< r cols) ; riga valida?
                    ; prossima riga non vuota?
                    (!= (first (count (list empty) (tr (+ r 1)))) rows))
               ; scambia le righe
               (swap (tr r) (tr (+ r 1)))
               ; scambio avvenuto
               (setq change true))
        )
      )
    )
    (setq grid (transpose tr))
    grid))

; Funzione principale
(define (samegame)
  (local (score num-colors num-rows num-cols palette
          cur-row cur-col empty)
  ; show game information
  (show-info)
  ; Input user values for starting game
  (setq num-colors (input-integer "Number of colors (3..5): " 3 5))
  (setq num-rows (input-integer "Number of rows (height) (4..42): " 4 42))
  (setq num-cols (input-integer "Number of columns (width) (4..42): " 4 42))
  (setq palette (input-integer "Normal colors (1) or Bright colors (2): " 1 2))
  ; define colors
  (create-colors palette)
  ; create table-grid
  (setq table (create-grid num-rows num-cols num-colors))
  ; color of empty block (5 = black)
  (setq empty 5)
  ; punteggio giocatore
  (setq score 0)
  ; game loop
  (until (endgame? table empty)
    ; show grid
    (show-grid table)
    ; calculate current score
    ; (number of empty blocks)
    (setq score (empty-count table empty))
    (println "Score: " score)
    ; user input: row and colum of a block
    (setq input nil)
    (until input
      ; read input values of block row and column to select
      (setq cur-row (input-integer (string "Block row (0.." (- num-rows 1) "): ") 0 (- num-rows 1)))
      (setq cur-col (input-integer (string "Block col (0.." (- num-cols 1) "): ") 0 (- num-cols 1)))
      ; check values
      (if (or (= (table cur-row cur-col) empty) ; blocco vuoto?
              (alone? cur-row cur-col table))   ; blocco isolato?
          ; input error
          (println "Block (" cur-row "," cur-col ") empty or fixed.")
          ;else input ok
          (setq input true)
      )
    )
    ; fill table from selected block
    (setq table (flood-fill table cur-row cur-col empty))
    ; compress empty block (blocks down then columns left)
    (setq table (compress table empty))
  )
  ; game end
  (show-grid table)
  (setq score (empty-count table empty))
  (println "Perfect score: " (* num-rows num-cols))
  (println "Your Score: " score)
  'End-of-Game.))

Facciamo una partita:

(samegame)

Buona fortuna!!!


-----------
Stooge Sort
-----------

Stooge sort è un algoritmo di ordinamento ricorsivo. L'algoritmo è definito come segue:

  Se il valore all'inizio è maggiore del valore alla fine, scambiali.
  Se sono presenti 3 o più elementi nell'elenco, allora:
  stooge sort dei 2/3 iniziali della lista
  stooge sort degli ultimi 2/3 della lista
  stooge sort ancoara dei 2/3 iniziali della lista

È importante ottenere la dimensione dell'ordinamento intero utilizzata nelle chiamate ricorsive arrotondando i 2/3 per eccesso, ad es. l'arrotondamento 2/3 di 5 dovrebbe dare 4 anziché 3, altrimenti l'ordinamento non risulta corretto.

La complessità temporale di questo algoritmo vale: O(n) = O(n^2.7095). Quindi è peggiore del Bubble Sort (O(n^2)).

Questa è un'implementazione in pseudocodice:

function stoogesort(array L, i = 0, j = length(L)-1)
(
  ; If the leftmost element is larger than the rightmost element
  if L[i] > L[j] then
      ; Swap the leftmost element and the rightmost element
      L[i] ↔ L[j]
  ; If there are at least 3 elements in the array
  if (j - i + 1) > 2 then
      t = floor((j - i + 1) / 3)
      ; Sort the first 2/3 of the array
      stoogesort(L, i  , j-t)
      ; Sort the last 2/3 of the array
      stoogesort(L, i+t, j)
      ; Sort the first 2/3 of the array again
      stoogesort(L, i  , j-t)
  return L
)

Vediamo l'implementazione:

(define (stoogesort lst)
  (local (out)
    (setq out lst)
    (stoogesort-aux 0 (- (length out) 1))))

(define (stoogesort-aux i j)
  (if (> (out i) (out j)) (swap (out i) (out j)))
  (if (> (sub j i -1) 2)
    (begin
      (let (t (int (floor (div (sub j i -1) 3))))
        (stoogesort-aux i (- j t))
        (stoogesort-aux (+ i t) j)
        (stoogesort-aux i (- j t))
      )
    )
  )
  out)

Proviamo la funzione:

(setq a (randomize (sequence 1 15)))
;-> (5 2 4 8 6 7 15 11 9 10 3 13 14 1 12)
(stoogesort a)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)


---------
Slow Sort
---------

Lo "slowsort" è un algoritmo di ordinamento ricorsivo che modifica gli elementi direttamente (on-place) ed è di tipo stabile, cioè non cambia l'ordine dei valori uguali.

Questa è un'implementazione in pseudocodice:

function slowsort(A[], i, j)     // Sort list A[i...j] in-place.
    if i ≥ j then
        return
    m := floor( (i+j)/2 )
    slowsort(A, i, m)            // (1.1)
    slowsort(A, m+1, j)          // (1.2)
    if A[j] < A[m] then
        swap A[j] , A[m]         // (1.3)
    slowsort(A, i, j-1)          // (2)

Ordina la prima metà, in modo ricorsivo (1.1).
Ordina la seconda metà, in modo ricorsivo (1.2).
Trova il massimo dell'intera lista confrontando i risultati di 1.1 e 1.2 e posizionalo alla fine dell'elenco (1.3).
Ordina l'intero elenco (tranne il massimo che adesso si trova alla fine), in modo ricorsivo (2).

La seguente implementazione richiede che la lista venga passata per riferimento:

(define (slowsort lst i j)
  (slowsort-aux lst 0 (- (length lst) 1)))

(define (slowsort-aux lst i j)
  (cond ((>= i j) 'end)
        (true
            (setq m (int (floor (/ (+ i j) 2))))
            (slowsort-aux lst i m)
            (slowsort-aux lst (+ m 1) j)
            (if (< (lst j) (lst m))
                (swap (lst j) (lst m))
            )
            (slowsort-aux lst i (- j 1)))))

Proviamo la funzione:

(set 'a:a (randomize (sequence 1 15)))
;-> (1 9 5 13 11 10 6 15 14 2 3 8 12 4 7)

(slowsort a)
;-> end

a:a
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15)

La complessità temporale di questo algoritmo vale: O(n) = 2*O(n/2) + O(n-1) + 1.
Slowsort non è in tempo polinomiale, anche il caso migliore è peggiore del Bubble sort.

Infatti per ordinare una lista di 25 elementi occorrono quasi 21 secondi:

(set 'd:d (randomize (sequence 1 25)))
;-> (3 17 5 13 24 6 23 4 12 22 2 14 21 8 19 20 10 7 1 15 16 9 11 18 25)

(time (slowsort d))
;-> 20872.33
d:d
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)


---------
Bogo sort
---------

Bogo Sort o Bogus Sort è un algoritmo di ordinamento che, ripetutamente, mescola la lista e poi controlla se è ordinata. Il nome deriva dalla parola "bogus" (falso, finto).

Algoritmo:
 1) Controllare se è ordinata. Se è così, fine.
 2) Altrimenti, mescolare i valori della lista e ripetere il passo 1.

Vediamo l'implementazione che è molto breve grazie alle primitive di newLISP:

(define (bogosort lst op)
  (until (apply op lst)
    (setq lst (randomize lst)))
  lst)

Facciamo alcune prove:

(setq a (sequence 15 1))
;-> (15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)
(time (println (bogosort a >=)))
;-> (15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)
;-> 0

(setq b (randomize (sequence 1 10)))
;-> (3 10 6 9 5 8 7 1 2 4)
(time (println (bogosort b <=)))
;-> (10 9 8 7 6 5 4 3 2 1)
;-> 1259.736
(time (println (bogosort b <=)))
;-> (10 9 8 7 6 5 4 3 2 1)
;-> 3121.243
(time (println (bogosort b <=)))
;-> (10 9 8 7 6 5 4 3 2 1)
;-> 329.952

Provate solo se avete tempo (o tanta fortuna):

(setq c (randomize (sequence 1 12)))
;-> (10 8 6 11 4 9 1 5 7 12 3 2)
(time (println (bogosort c <=)))

Questo algoritmo di ordinamento ha prestazioni terribili (ovviamente). Il suo tempo di esecuzione è relativo alla probabilità di mescolare in ordine la lista.
Supponendo che il generatore casuale sia uniforme, la probabilità è uguale a:

  P(lista ordinata) = 1 / (numero di permutazioni di N elementi) = 1/N!

Prestazione caso medio: O(n*n!)
Prestazione caso peggiore: O(∞)
Prestazione caso migliore: O(n) ; (la lista è già ordinata)

Quantum Bogosort
----------------
Quantum bogosort è un ipotetico algoritmo di ordinamento basato su bogosort, creato come uno scherzo tra gli informatici. L'algoritmo genera una permutazione casuale del suo input utilizzando una fonte quantistica di entropia, controlla se l'elenco è ordinato e, in caso contrario, distrugge l'universo. Assumendo che l'interpretazione dei "molti mondi" sia valida, l'uso di questo algoritmo risulterà in almeno un universo sopravvissuto in cui l'input è stato ordinato con successo in tempo O(n).


-----------------------------
CriptoAritmetica (Alfametica)
-----------------------------

La criptoaritmetica è l'arte di risolvere puzzle costituiti da un'equazione matematica tra numeri sconosciuti, le cui cifre sono rappresentate da lettere dell'alfabeto. L'obiettivo è identificare la cifra associata ad ogni lettera. Il nome può essere esteso a puzzle che utilizzano simboli non alfabetici al posto delle lettere.
L'equazione è un'operazione di base dell'aritmetica, come addizione, moltiplicazione o divisione.
L'esempio classico presentato nel 1924 da Henry Dudeney è:

    S E N D +
    M O R E =
  -----------
  M O N E Y

Ogni lettera rappresenta una cifra diversa e la cifra iniziale di un numero non deve essere zero.
Un buon puzzle dovrebbe formare una frase compiuta (e preferibilmente avere una soluzione unica).

Risolvere le seguenti operazioni di criptoaritmetica sapendo che ad ogni lettera corrisponde una cifra (0..9).

----------------------------------------
ABC + BCA + CAB = ABBC

    A B C +
    B C A +
    C A B =
  ---------
  A B B C

(define (uno iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (slice (randomize (sequence 0 9)) 0 3))
    (setq a (digits 0))
    (setq b (digits 1))
    (setq c (digits 2))
    (setq term1 (+ (* a 100) (* b 10) c))
    (setq term2 (+ (* b 100) (* c 10) a))
    (setq term3 (+ (* c 100) (* a 10) b))
    (setq all (+ (* a 1000) (* b 100) (* b 10) c))
    (if (= (+ term1 term2 term3) all)
        (println term1 { + } term2 { + } term3 { = } all)
    )
    (++ idx)))

(uno 10000)
;-> 198 + 981 + 819 = 1998

    1 9 8 +
    9 8 1 +
    8 1 9 =
  ---------
  1 9 9 8

----------------------------------------
SEND + MORE = MONEY

    S E N D +
    M O R E =
  -----------
  M O N E Y

(define (due iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (slice (randomize (sequence 0 9)) 0 8))
    (setq s (digits 0))
    (setq e (digits 1))
    (setq n (digits 2))
    (setq d (digits 3))
    (setq m (digits 4))
    (setq o (digits 5))
    (setq r (digits 6))
    (setq y (digits 7))
    (setq term1 (+ (* s 1000) (* e 100) (* n 10) d))
    (setq term2 (+ (* m 1000) (* o 100) (* r 10) e))
    (setq all (+ (* m 10000) (* o 1000) (* n 100) (* e 10) y))
    (if (= (+ term1 term2) all)
        (println term1 { + } term2 { = } all)
    )
    (++ idx)))

(due 1e6)
;-> 3719 + 457 = 4176
;-> 7534 + 825 = 8359
;-> 8542 + 915 = 9457
;-> 7643 + 826 = 8469
;-> 6419 + 724 = 7143
;-> ...
;-> 9567 + 1085 = 10652
;-> ...

    9 5 6 7 +
    1 0 8 5 =
  -----------
  1 0 6 5 2

----------------------------------------
FORTY + TEN + TEN = SIXTY

  F O R T Y +
      T E N +
      T E N =
  -----------
  S I X T Y

(define (tre iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (randomize (sequence 0 9)))
    (setq f (digits 0))
    (setq o (digits 1))
    (setq r (digits 2))
    (setq t (digits 3))
    (setq y (digits 4))
    (setq e (digits 5))
    (setq n (digits 6))
    (setq s (digits 7))
    (setq i (digits 8))
    (setq x (digits 9))
    (setq term1 (+ (* f 10000) (* o 1000) (* r 100) (* t 10) y))
    (setq term2 (+ (* t 100) (* e 10) n))
    (setq term3 term2)
    (setq all (+ (* s 10000) (* i 1000 ) (* x 100) (* t 10) y))
    (if (= (+ term1 term2 term3) all)
        (println term1 { + } term2 { + } term3 { = } all)
    )
    (++ idx)))

(tre 1e7)
;-> 29786 + 850 + 850 = 31486

  2 9 7 8 6 +
      8 5 0 +
      8 5 0 =
  -----------
  3 1 4 8 6

----------------------------------------
ABCD × 4 = DCBA

  A B C D ×
        4 =
  ---------
  D C B A

(define (quattro iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (slice (randomize (sequence 0 9)) 0 4))
    (setq a (digits 0))
    (setq b (digits 1))
    (setq c (digits 2))
    (setq d (digits 3))
    (setq term1 (+ (* a 1000) (* b 100) (* c 10) d))
    (setq term2 4)
    (setq all (+ (* d 1000) (* c 100) (* b 10) a))
    (if (= (* term1 term2) all)
        (println term1 { * } term2 { = } all)
    )
    (++ idx)))

(quattro 1e5)
;-> 2178 * 4 = 8712

  2 1 7 8 ×
        4 =
  ---------
  8 7 1 2

----------------------------------------
ABCDEF × 5 = FABCDE

  A B C D E F ×
            5 =
  -------------
  F A B C D E

(define (cinque iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (slice (randomize (sequence 0 9)) 0 6))
    (setq a (digits 0))
    (setq b (digits 1))
    (setq c (digits 2))
    (setq d (digits 3))
    (setq e (digits 4))
    (setq f (digits 5))
    (setq term1 (+ (* a 100000) (* b 10000) (* c 1000) (* d 100) (* e 10) f))
    (setq term2 5)
    (setq all (+ (* f 100000) (* a 10000) (* b 1000) (* c 100) (* d 10) e))
    (if (= (* term1 term2) all)
        (println term1 { * } term2 { = } all)
    )
    (++ idx)))

(cinque 1e6)
;-> 142857 * 5 = 714285

  1 4 2 8 5 7 ×
            5 =
  -------------
  7 1 4 2 8 5

----------------------------------------
ABCDE × A = EEEEEE

    A B C D E ×
            A =
  -------------
  E E E E E E

(define (sei iter)
  (setq idx 0)
  (while (< idx iter)
    (setq digits (slice (randomize (sequence 0 9)) 0 5))
    (setq a (digits 0))
    (setq b (digits 1))
    (setq c (digits 2))
    (setq d (digits 3))
    (setq e (digits 4))
    (setq term1 (+ (* a 10000) (* b 1000) (* c 100) (* d 10) e))
    (setq term2 a)
    (setq all (+ (* e 100000) (* e 10000) (* e 1000) (* e 100) (* e 10) e))
    (if (= (* term1 term2) all)
        (println term1 { * } term2 { = } all)
    )
    (++ idx)))

(sei 1e5)
;-> 79365 * 7 = 555555

    7 9 3 6 5 ×
            7 =
  -------------
  5 5 5 5 5 5

Vediamo una funzione più generale che cerca di risolvere le espressioni criptoaritmetiche che hanno i seguenti vincoli:

a) solo tutte somme o solo tutte moltiplicazione nell'espressione
b) massimo dieci lettere diverse nell'espressione
c) nessun numero nell'espressione

Funzione che prende una stringa e una lista di associazione (carattere numero) e restituisce il numero intero rappresentato dalla stringa:

(define (termine str link)
  (local (res len-ter)
    (setq res 0)
    (setq len-ter (length str))
    (dolist (ch (explode str))
      (setq res (+ res (* (lookup ch link) (pow 10 (- len-ter $idx 1)))))
    )
    ; il risultato è valido se il numero e la stringa
    ; hanno la stessa lunghezza
    ; (elimina il caso con 0 come prima cifra)
    (if (= (length res) (length str))
       res
       ; restituisce un risultato negativo
       ; che sicuramente non verifica l'espressione
       (- (int (dup "9" (length str))))
       -99999999999
    )))

(termine "abc" '(("a" 1) ("b" 2) ("c" 3)))
;-> 123
(termine "cccabc" '(("a" 1) ("b" 2) ("c" 3)))
;-> 333123

Funzione che risolve l'espressione di criptoaritmetica (con lo stesso metodo delle funzioni precedenti, ma questa volta in modo generalizato):

(define (solve (lst-term-str) res-str op iter tipo)
  (local (out strings chars len-chars stop digits link
          calc-termini totale)
    ; lista delle soluzioni
    (setq out '())
    ; crea lista dei caratteri unici
    (setq strings (append lst-term-str (list res-str)))
    (setq chars (sort (unique (flat (map explode strings)))))
    ; lunghezza della lista dei caratteri unici
    (setq len-chars (length chars))
    ; ciclo di tentativi...
    (setq stop nil)
    (for (i 1 iter 1 stop)
      ; selezione casuale delle cifre
      (setq digits (slice (randomize (sequence 0 9)) 0 len-chars))
      ; associazione caratteri-cifre
      (setq link (map list chars digits))
      (if (= op "+")
        ; caso della somma "+"
        (setq calc-termini 0)
        ; caso della moltiplicazione "*"
        (setq calc-termini 1)
      )
      ; calcolo della somma o moltiplicazione di tutti i termini
      (dolist (s lst-term-str)
        (if (= op "+")
            (setq calc-termini (+ calc-termini (termine s link)))
            (setq calc-termini (* calc-termini (termine s link)))
        )
      )
      ; valore del termine totale
      (setq totale (termine res-str link))
      ; soluzione trovata?
      (cond ((= calc-termini totale)
             ; aggiunge la soluzione (se non esiste già)
             (if (not (ref link out)) (push link out -1))
             ; stop o ricerca altre soluzioni?
             (if (!= tipo "all") (setq stop true)))
      )
    )
    ; restituisce la lista delle soluzioni
    out))

Proviamo la funzione con gli esempi precedenti:

ABC + BCA + CAB = ABBC
(solve '("abc" "bca" "cab") "abbc" "+" 1e8)
;-> ((("a" 1) ("b" 9) ("c" 8)))

SEND + MORE = MONEY
(solve '("send" "more") "money" "+" 1e8)
;-> ((("d" 7) ("e" 5) ("m" 1) ("n" 6) ("o" 0) ("r" 8) ("s" 9) ("y" 2)))

In italiano:

MOLTI + SOLDI = CHIEDO

    M O L T I +       76903 +
    S O L D I =       46953 =
  -------------      --------
  C H I E D O        123856

(solve '("molti" "soldi") "chiedo" "+" 1e8)
;-> ((("c" 1) ("d" 5) ("e" 8) ("h" 2) ("i" 3) ("l" 9) ("m" 7) ("o" 6) ("s" 4) ("t" 0)))

FORTY + TEN + TEN = SIXTY
(solve '("forty" "ten" "ten") "sixty" "+" 1e8)
;-> ((("e" 5) ("f" 2) ("i" 1) ("n" 0) ("o" 9) ("r" 7) ("s" 3) ("t" 8) ("x" 4) ("y" 6)))

ABCDE × A = EEEEEE
(solve '("abcde" "a") "eeeeee" "*" 1e8)
;-> ((("a" 7) ("b" 9) ("c" 3) ("d" 6) ("e" 5)))

Altro esempio in italiano:

POCHI + POCHI = MOLTI

  P O C H I +      39640 +
  P O C H I =      39640 =
  -----------      ------
  M O L T I        79280

(solve '("pochi" "pochi") "molti" "+" 1e8)
;-> ((("c" 6) ("h" 4) ("i" 0) ("l" 2) ("m" 7) ("o" 9) ("p" 3) ("t" 8)))

Proviamo con un esempio diverso (di cui sappiamo che esistono più soluzioni):

A × B = CD
CD × EF = GHI

Possiamo scrivere: A × B × EF = GHI

(solve '("a" "b" "ef") "ghi" "*" 1e5 "all")
;-> ((("a" 7) ("b" 1) ("e" 6) ("f" 9) ("g" 4) ("h" 8) ("i" 3))
;->  (("a" 3) ("b" 6) ("e" 1) ("f" 5) ("g" 2) ("h" 7) ("i" 0))
;->  (("a" 4) ("b" 5) ("e" 3) ("f" 6) ("g" 7) ("h" 2) ("i" 0))
;->  (("a" 1) ("b" 8) ("e" 5) ("f" 9) ("g" 4) ("h" 7) ("i" 2))
;->  (("a" 6) ("b" 7) ("e" 1) ("f" 2) ("g" 5) ("h" 0) ("i" 4))
;->  (("a" 1) ("b" 8) ("e" 6) ("f" 3) ("g" 5) ("h" 0) ("i" 4))
;->  (("a" 7) ("b" 1) ("e" 5) ("f" 6) ("g" 3) ("h" 9) ("i" 2))
;->  (("a" 4) ("b" 1) ("e" 8) ("f" 9) ("g" 3) ("h" 5) ("i" 6))
;->  (("a" 7) ("b" 2) ("e" 6) ("f" 1) ("g" 8) ("h" 5) ("i" 4))
;->  (("a" 7) ("b" 5) ("e" 1) ("f" 8) ("g" 6) ("h" 3) ("i" 0))
;->  (("a" 5) ("b" 1) ("e" 4) ("f" 6) ("g" 2) ("h" 3) ("i" 0))
;->  (("a" 1) ("b" 3) ("e" 6) ("f" 9) ("g" 2) ("h" 0) ("i" 7))
;->  (("a" 8) ("b" 3) ("e" 1) ("f" 9) ("g" 4) ("h" 5) ("i" 6))
;->  (("a" 3) ("b" 4) ("e" 7) ("f" 1) ("g" 8) ("h" 5) ("i" 2))
;->  (("a" 4) ("b" 5) ("e" 3) ("f" 8) ("g" 7) ("h" 6) ("i" 0))
;->  (("a" 5) ("b" 1) ("e" 7) ("f" 6) ("g" 3) ("h" 8) ("i" 0))
;->  (("a" 3) ("b" 4) ("e" 8) ("f" 1) ("g" 9) ("h" 7) ("i" 2))
;->  (("a" 5) ("b" 4) ("e" 3) ("f" 8) ("g" 7) ("h" 6) ("i" 0))
;->  (("a" 1) ("b" 7) ("e" 5) ("f" 2) ("g" 3) ("h" 6) ("i" 4))
;->  (("a" 1) ("b" 5) ("e" 6) ("f" 4) ("g" 3) ("h" 2) ("i" 0))
;->  (("a" 5) ("b" 7) ("e" 1) ("f" 8) ("g" 6) ("h" 3) ("i" 0))
;->  (("a" 8) ("b" 1) ("e" 7) ("f" 9) ("g" 6) ("h" 3) ("i" 2))
;->  (("a" 4) ("b" 1) ("e" 9) ("f" 2) ("g" 3) ("h" 6) ("i" 8))
;->  (("a" 6) ("b" 4) ("e" 3) ("f" 8) ("g" 9) ("h" 1) ("i" 2))
;->  (("a" 8) ("b" 1) ("e" 9) ("f" 4) ("g" 7) ("h" 5) ("i" 2))
;->  (("a" 4) ("b" 5) ("e" 3) ("f" 9) ("g" 7) ("h" 8) ("i" 0))
;->  (("a" 6) ("b" 9) ("e" 1) ("f" 3) ("g" 7) ("h" 0) ("i" 2))
;->  (("a" 9) ("b" 2) ("e" 4) ("f" 1) ("g" 7) ("h" 3) ("i" 8))
;->  (("a" 9) ("b" 5) ("e" 1) ("f" 6) ("g" 7) ("h" 2) ("i" 0))
;->  (("a" 5) ("b" 4) ("e" 1) ("f" 9) ("g" 3) ("h" 8) ("i" 0))
;->  (("a" 5) ("b" 9) ("e" 1) ("f" 4) ("g" 6) ("h" 3) ("i" 0)))

Adesso dobbiamo togliere tutte le soluzioni in A × B è un numero da una cifra (infatti deve valere CD che ha due cifre):

((("a" 3) ("b" 6) ("e" 1) ("f" 5) ("g" 2) ("h" 7) ("i" 0))
 (("a" 4) ("b" 5) ("e" 3) ("f" 6) ("g" 7) ("h" 2) ("i" 0))
 (("a" 6) ("b" 7) ("e" 1) ("f" 2) ("g" 5) ("h" 0) ("i" 4))
 (("a" 7) ("b" 2) ("e" 6) ("f" 1) ("g" 8) ("h" 5) ("i" 4))
 (("a" 7) ("b" 5) ("e" 1) ("f" 8) ("g" 6) ("h" 3) ("i" 0))
 (("a" 8) ("b" 3) ("e" 1) ("f" 9) ("g" 4) ("h" 5) ("i" 6))
 (("a" 3) ("b" 4) ("e" 7) ("f" 1) ("g" 8) ("h" 5) ("i" 2))
 (("a" 4) ("b" 5) ("e" 3) ("f" 8) ("g" 7) ("h" 6) ("i" 0))
 (("a" 3) ("b" 4) ("e" 8) ("f" 1) ("g" 9) ("h" 7) ("i" 2))
 (("a" 5) ("b" 4) ("e" 3) ("f" 8) ("g" 7) ("h" 6) ("i" 0))
 (("a" 5) ("b" 7) ("e" 1) ("f" 8) ("g" 6) ("h" 3) ("i" 0))
 (("a" 6) ("b" 4) ("e" 3) ("f" 8) ("g" 9) ("h" 1) ("i" 2))
 (("a" 4) ("b" 5) ("e" 3) ("f" 9) ("g" 7) ("h" 8) ("i" 0))
 (("a" 6) ("b" 9) ("e" 1) ("f" 3) ("g" 7) ("h" 0) ("i" 2))
 (("a" 9) ("b" 2) ("e" 4) ("f" 1) ("g" 7) ("h" 3) ("i" 8))
 (("a" 9) ("b" 5) ("e" 1) ("f" 6) ("g" 7) ("h" 2) ("i" 0))
 (("a" 5) ("b" 4) ("e" 1) ("f" 9) ("g" 3) ("h" 8) ("i" 0))
 (("a" 5) ("b" 9) ("e" 1) ("f" 4) ("g" 6) ("h" 3) ("i" 0)))

Facciamo delle verifiche a caso:

A × B × EF = GHI
(= (* 3 6 15) 270)
;-> true
(= (* 4 5 36) 720)
;-> true
(= (* 5 9 14) 630)
;-> true

Nota: la funzione "solve" è casuale, quindi non è sicuro che riesca a trovare una (o più) soluzioni all'espressione di criptoaritmetica.

Nel caso di espressioni con sottrazione (o divisione) possiamo convertire l'espressione in addizione (o moltiplicazione prima di applciare la funzione "solve"), per esempio la seguente espressione:

  C O U N T -
    C O I N =
  -----------
    S N U B

Può essere riscritta così:

    S N U B +       9567 +
    C O I N =       1085 =
  -----------      -------
  C O U N T        10652

(solve '("snub" "coin") "count" "+" 1e8)
;-> ((("b" 7) ("c" 1) ("i" 8) ("n" 5) ("o" 0) ("s" 9) ("t" 2) ("u" 6)))

Proviamo un paio di esempi casuali (cioè non sappiamo se esiste zero, una o più soluzioni:

    B O Y +
  G I R L =
  ---------
  L O V E

(solve '("boy" "girl") "love" "+" 1e6 "all")
;-> ((("b" 3) ("e" 5) ("g" 8) ("i" 7) ("l" 9) ("o" 0) ("r" 1) ("v" 2) ("y" 6))
;->  (("b" 5) ("e" 0) ("g" 2) ("i" 9) ("l" 3) ("o" 4) ("r" 1) ("v" 6) ("y" 7))
;->  (("b" 8) ("e" 5) ("g" 1) ("i" 7) ("l" 2) ("o" 6) ("r" 4) ("v" 0) ("y" 3))
;->  (("b" 8) ("e" 9) ("g" 6) ("i" 5) ("l" 7) ("o" 3) ("r" 1) ("v" 4) ("y" 2))
;->  (("b" 9) ("e" 2) ("g" 3) ("i" 1) ("l" 4) ("o" 0) ("r" 5) ("v" 6) ("y" 8))
;->  (("b" 5) ("e" 3) ("g" 8) ("i" 6) ("l" 9) ("o" 1) ("r" 0) ("v" 2) ("y" 4))
;->  (("b" 9) ("e" 5) ("g" 6) ("i" 3) ("l" 7) ("o" 2) ("r" 1) ("v" 4) ("y" 8))
;->  (("b" 5) ("e" 0) ("g" 8) ("i" 7) ("l" 9) ("o" 2) ("r" 3) ("v" 6) ("y" 1))
;->  (("b" 9) ("e" 0) ("g" 3) ("i" 2) ("l" 4) ("o" 1) ("r" 5) ("v" 7) ("y" 6))
;->  (("b" 8) ("e" 7) ("g" 5) ("i" 4) ("l" 6) ("o" 3) ("r" 9) ("v" 2) ("y" 1))
;->  (("b" 6) ("e" 3) ("g" 7) ("i" 4) ("l" 8) ("o" 0) ("r" 1) ("v" 2) ("y" 5))
;->  (("b" 4) ("e" 7) ("g" 5) ("i" 8) ("l" 6) ("o" 3) ("r" 9) ("v" 2) ("y" 1))
;->  (("b" 9) ("e" 4) ("g" 5) ("i" 1) ("l" 6) ("o" 0) ("r" 2) ("v" 3) ("y" 8))
;->  (("b" 9) ("e" 8) ("g" 6) ("i" 4) ("l" 7) ("o" 3) ("r" 2) ("v" 5) ("y" 1))
;->  (("b" 2) ("e" 3) ("g" 7) ("i" 9) ("l" 8) ("o" 1) ("r" 4) ("v" 6) ("y" 5))
;->  (("b" 5) ("e" 9) ("g" 6) ("i" 8) ("l" 7) ("o" 3) ("r" 1) ("v" 4) ("y" 2))
;->  (("b" 1) ("e" 4) ("g" 7) ("i" 9) ("l" 8) ("o" 0) ("r" 2) ("v" 3) ("y" 6))
;->  (("b" 4) ("e" 8) ("g" 6) ("i" 9) ("l" 7) ("o" 3) ("r" 2) ("v" 5) ("y" 1))
;->  (("b" 9) ("e" 1) ("g" 3) ("i" 6) ("l" 4) ("o" 5) ("r" 2) ("v" 8) ("y" 7))
;->  (("b" 5) ("e" 9) ("g" 2) ("i" 8) ("l" 3) ("o" 4) ("r" 7) ("v" 1) ("y" 6))
;->  (("b" 3) ("e" 1) ("g" 4) ("i" 8) ("l" 5) ("o" 2) ("r" 7) ("v" 0) ("y" 6))
;->  (("b" 7) ("e" 1) ("g" 8) ("i" 5) ("l" 9) ("o" 3) ("r" 6) ("v" 0) ("y" 2)))

     LISP *
      FUN =
  ---------
  NEWLISP

(time (println (solve '("lisp" "fun") "newlisp" "*" 1e7 "all")))
;-> ((("e" 9) ("f" 7) ("i" 6) ("l" 2) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 8))
;->  (("e" 8) ("f" 2) ("i" 3) ("l" 7) ("n" 1) ("p" 0) ("s" 6) ("u" 5) ("w" 4))
;->  (("e" 9) ("f" 2) ("i" 8) ("l" 7) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 6)))
;-> 108669.307

Verifichiamo:
(mul (termine "lisp" '(("e" 8) ("f" 2) ("i" 3) ("l" 7) ("n" 1) ("p" 0) ("s" 6) ("u" 5) ("w" 4)))
     (termine "fun"  '(("e" 8) ("f" 2) ("i" 3) ("l" 7) ("n" 1) ("p" 0) ("s" 6) ("u" 5) ("w" 4))))
;-> 1847360
(termine "newlisp"   '(("e" 8) ("f" 2) ("i" 3) ("l" 7) ("n" 1) ("p" 0) ("s" 6) ("u" 5) ("w" 4)))
;-> 1847360

(mul (termine "lisp" '(("e" 9) ("f" 7) ("i" 6) ("l" 2) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 8)))
     (termine "fun"  '(("e" 9) ("f" 7) ("i" 6) ("l" 2) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 8))))
;-> 1982640
(termine "newlisp"   '(("e" 9) ("f" 7) ("i" 6) ("l" 2) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 8)))
;-> 1982640

(mul (termine "lisp" '(("e" 9) ("f" 2) ("i" 8) ("l" 7) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 6)))
     (termine "fun"  '(("e" 9) ("f" 2) ("i" 8) ("l" 7) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 6))))
;-> 1967840
(termine "newlisp"   '(("e" 9) ("f" 2) ("i" 8) ("l" 7) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 6)))
;-> 1967840

Anton Pavlis nel 1983 ha costruito la seguente espressione con 41 addendi:

  SO+MANY+MORE+MEN+SEEM+TO+SAY+THAT+
  THEY+MAY+SOON+TRY+TO+STAY+AT+HOME+
  SO+AS+TO+SEE+OR+HEAR+THE+SAME+ONE+
  MAN+TRY+TO+MEET+THE+TEAM+ON+THE+
  MOON+AS+HE+HAS+AT+THE+OTHER+TEN
  =TESTS

La soluzione vale: TRANHYSMOE=9876543210)

Proviamo a risolverla con "solve":

(solve '("SO" "MANY" "MORE" "MEN" "SEEM" "TO" "SAY" "THAT" "THEY" "MAY" "SOON" "TRY" "TO" "STAY" "AT" "HOME" "SO" "AS" "TO" "SEE" "OR" "HEAR" "THE" "SAME" "ONE" "MAN" "TRY" "TO" "MEET" "THE" "TEAM" "ON" "THE" "MOON" "AS" "HE" "HAS" "AT" "THE" "OTHER" "TEN") "TESTS" "+" 1e6)
;-> (("A" 7) ("E" 0) ("H" 5) ("M" 2) ("N" 6)
;->  ("O" 1) ("R" 8) ("S" 3) ("T" 9) ("Y" 4)))

Per finire scriviamo una funzione che trova (se esistono) tutte le soluzioni di una espressione di criptoaritmetica.

Usiamo una funzione che genera tutte le permutazioni delle 10 cifre:

(define (perm lst)
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

(length (perm '(0 1 2 3 4 5 6 7 8 9)))
;-> 36628800

Precalcoliamo tutte le permutazioni delle 10 cifre:

(silent (setq all-digits (perm '(0 1 2 3 4 5 6 7 8 9))))

Scriviamo la funzione "solve-all" che è molto simile a "solve":

(define (solve-all (lst-term-str) res-str op)
  (local (out strings chars len-chars digits link
          calc-termini totale)
    ; lista delle soluzioni
    (setq out '())
    ; crea lista dei caratteri unici
    (setq strings (append lst-term-str (list res-str)))
    (setq chars (sort (unique (flat (map explode strings)))))
    ; lunghezza della lista dei caratteri unici
    (setq len-chars (length chars))
    (if (> len-chars 10) (println "ERRORE: Troppi caratteri " len-chars))
    ; ciclo su tutte le permutazioni...
    (dolist (p all-digits)
      ; selezione delle cifre
      (setq digits (slice p 0 len-chars))
      ; associazione caratteri-cifre
      (setq link (map list chars digits))
      (if (= op "+")
        ; caso della somma "+"
        (setq calc-termini 0)
        ; caso della moltiplicazione "*"
        (setq calc-termini 1)
      )
      ; calcolo della somma o moltiplicazione di tutti i termini
      (dolist (s lst-term-str)
        (if (= op "+")
            (setq calc-termini (+ calc-termini (termine s link)))
            (setq calc-termini (* calc-termini (termine s link)))
        )
      )
      ; valore del termine totale
      (setq totale (termine res-str link))
      ; soluzione trovata?
      (cond ((= calc-termini totale)
             ; aggiunge la soluzione (se non esiste già)
             (if (not (ref link out)) (push link out -1)))
             ; stop o ricerca altre soluzioni?
             ;(if (!= tipo "all") (setq stop true)))
      )
    )
    ; restituisce la lista delle soluzioni
    out))

Facciamo alcune prove:

ABC + BCA + CAB = ABBC
(time (println (solve-all '("abc" "bca" "cab") "abbc" "+")))
;-> ((("a" 1) ("b" 9) ("c" 8)))
;-> 31872.032

LISP + FUN = NEWLISP
(time (println (solve-all '("lisp" "fun") "newlisp" "*")))
;-> ((("e" 8) ("f" 2) ("i" 3) ("l" 7) ("n" 1) ("p" 0) ("s" 6) ("u" 5) ("w" 4))
;->  (("e" 9) ("f" 7) ("i" 6) ("l" 2) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 8))
;->  (("e" 9) ("f" 2) ("i" 8) ("l" 7) ("n" 1) ("p" 0) ("s" 4) ("u" 5) ("w" 6)))
;-> 51814.976

(time (println (solve-all '("SO" "MANY" "MORE" "MEN" "SEEM" "TO" "SAY" "THAT" "THEY" "MAY" "SOON" "TRY" "TO" "STAY" "AT" "HOME" "SO" "AS" "TO" "SEE" "OR" "HEAR" "THE" "SAME" "ONE" "MAN" "TRY" "TO" "MEET" "THE" "TEAM" "ON" "THE" "MOON" "AS" "HE" "HAS" "AT" "THE" "OTHER" "TEN") "TESTS" "+")))
;-> ((("A" 7) ("E" 0) ("H" 5) ("M" 2) ("N" 6)
;->   ("O" 1) ("R" 8) ("S" 3) ("T" 9) ("Y" 4)))
;-> 726961.943

FOUR + FIVE = EIGHT
(time (println (solve-all '("four" "five") "eight" "+")))
;-> ((("e" 1) ("f" 6) ("g" 3) ("h" 7) ("i" 2) ("o" 0) ("r" 4) ("t" 5) ("u" 8) ("v" 9))
;->  (("e" 1) ("f" 8) ("g" 7) ("h" 4) ("i" 6) ("o" 0) ("r" 2) ("t" 3) ("u" 5) ("v" 9))
;->  (("e" 1) ("f" 6) ("g" 3) ("h" 4) ("i" 2) ("o" 0) ("r" 7) ("t" 8) ("u" 5) ("v" 9))
;->  (("e" 1) ("f" 8) ("g" 0) ("h" 3) ("i" 7) ("o" 2) ("r" 5) ("t" 6) ("u" 4) ("v" 9))
;->  (("e" 1) ("f" 8) ("g" 7) ("h" 2) ("i" 6) ("o" 0) ("r" 4) ("t" 5) ("u" 3) ("v" 9))
;->  (("e" 1) ("f" 8) ("g" 0) ("h" 5) ("i" 7) ("o" 2) ("r" 3) ("t" 4) ("u" 6) ("v" 9))
;->  (("e" 1) ("f" 7) ("g" 2) ("h" 3) ("i" 5) ("o" 6) ("r" 9) ("t" 0) ("u" 4) ("v" 8))
;->  (("e" 1) ("f" 6) ("g" 3) ("h" 7) ("i" 2) ("o" 0) ("r" 4) ("t" 5) ("u" 9) ("v" 8))
;->  (("e" 1) ("f" 8) ("g" 7) ("h" 2) ("i" 6) ("o" 0) ("r" 4) ("t" 5) ("u" 9) ("v" 3))
;->  (("e" 1) ("f" 6) ("g" 7) ("h" 8) ("i" 2) ("o" 5) ("r" 9) ("t" 0) ("u" 4) ("v" 3))
;->  (("e" 1) ("f" 8) ("g" 9) ("h" 0) ("i" 6) ("o" 2) ("r" 4) ("t" 5) ("u" 7) ("v" 3))
;->  (("e" 1) ("f" 6) ("g" 7) ("h" 8) ("i" 2) ("o" 5) ("r" 9) ("t" 0) ("u" 3) ("v" 4))
;->  (("e" 1) ("f" 7) ("g" 2) ("h" 3) ("i" 5) ("o" 6) ("r" 9) ("t" 0) ("u" 8) ("v" 4))
;->  (("e" 1) ("f" 8) ("g" 0) ("h" 3) ("i" 7) ("o" 2) ("r" 5) ("t" 6) ("u" 9) ("v" 4))
;->  (("e" 1) ("f" 6) ("g" 3) ("h" 4) ("i" 2) ("o" 0) ("r" 7) ("t" 8) ("u" 9) ("v" 5))
;->  (("e" 1) ("f" 8) ("g" 7) ("h" 4) ("i" 6) ("o" 0) ("r" 2) ("t" 3) ("u" 9) ("v" 5))
;->  (("e" 1) ("f" 7) ("g" 8) ("h" 2) ("i" 4) ("o" 3) ("r" 9) ("t" 0) ("u" 6) ("v" 5))
;->  (("e" 1) ("f" 7) ("g" 8) ("h" 2) ("i" 4) ("o" 3) ("r" 9) ("t" 0) ("u" 5) ("v" 6))
;->  (("e" 1) ("f" 8) ("g" 0) ("h" 5) ("i" 7) ("o" 2) ("r" 3) ("t" 4) ("u" 9) ("v" 6))
;->  (("e" 1) ("f" 8) ("g" 9) ("h" 0) ("i" 6) ("o" 2) ("r" 4) ("t" 5) ("u" 3) ("v" 7)))
;-> 41793.88

THESE + TEASE + TIRED = READER
(time (println (solve-all '("these" "tease" "tired") "reader" "+")))
;-> ((("a" 0) ("d" 9) ("e" 6) ("h" 3) ("i" 2) ("r" 1) ("s" 4) ("t" 5)))
;-> 49866.527

UNO + DUE = TRE
(length (solve-all '("uno" "due") "tre" "+"))
;-> 492

Soluzione fornita da rickyboy:

;; Puzzle posed by user cameyo on the newLISP Forum at:
;; http://www.newlispfanclub.alh.net/forum/viewtopic.php?f=12&t=5197

;; The method here is still brute-force but the reason this is faster
;; than the naive brute-force -- which does P(10,9) = 3,628,800
;; iterations -- is because we instead do P(10,7) = 604,800 iterations
;; by leaving two letters, namely E and W, out and (when we get a
;; match on the other 7 letters) just check if E and W are distinct
;; and not in the original 7-permutation.

(define (doit)
  "Find all the solutions of LISP * FUN = NEWLISP"
  (let (perms (make-k-permutations 7 (sequence 0 9))
        res (list))
    (dolist (p perms)
      (letn (LISP    (slice p 0 4)
             FUN     (4 p)
             NEWLISP (laven (* (neval LISP) (neval FUN)))
             E       (NEWLISP 1)
             W       (NEWLISP 2))
        (if (and ;; are the LISPs equal?
                 (= LISP (slice NEWLISP 3 4))
                 ;; are the Ns equal?
                 (= (FUN 2) (NEWLISP 0))
                 ;; are E and W distinct and not members of p?
                 (not (= E W))
                 (not (member E p))
                 (not (member W p)))
            (push (list 'LISP LISP 'FUN FUN 'NEWLISP NEWLISP)
                  res))))
    res))

(define (neval xs (max-digits 7))
  "Convert list of numbers to a number, e.g., (neval '(2 6 4 0)) -> 2640"
  (apply + (map * (reverse xs)
                  (map (fn (x) (pow 10 x))
                       (sequence 0 (- max-digits 1))))))

(define (laven n (max-digits 7))
  "The inverse of neval, e.g., (laven 2640) -> (0 0 0 2 6 4 0)"
  (first
   (apply (fn (acc ignore)
            (let (n (acc 1))
              (list (cons (% n 10) (acc 0))
                    (/ n 10))))
          (cons (cons (list) n)
                (sequence 0 (- max-digits 1)))
          2)))

;; Find the next two functions at:
;; http://www.newlisp.org/index.cgi?page=Code_Snippets
(define (make-k-permutations k multiset)
  (let ((pivots (unique multiset)))
    (if (= k 1)
        (map list pivots)
        (let ((acc '()))
          (dolist (p pivots)
            (let ((sub-multiset (remove1 p multiset)))
              (dolist (sub-perm
                       (make-k-permutations (- k 1) sub-multiset))
                (push (cons p sub-perm) acc))))
          acc))))

(define (remove1 elt lst)
  (let ((elt-pos (find elt lst)))
    (if elt-pos (pop lst elt-pos))
    lst))

;;----------------------------------------------------------------------
;; Application:

;; > (load "lisp*fun=newlisp.lsp")
;; DONE
;; > (doit)
;; ((LISP (2 6 4 0) FUN (7 5 1) NEWLISP (1 9 8 2 6 4 0))
;;  (LISP (7 8 4 0) FUN (2 5 1) NEWLISP (1 9 6 7 8 4 0))
;;  (LISP (7 3 6 0) FUN (2 5 1) NEWLISP (1 8 4 7 3 6 0)))
;; >

'DONE
;;----------------------------------------------------------------------

(time (println (doit)))
;-> ((LISP (2 6 4 0) FUN (7 5 1) NEWLISP (1 9 8 2 6 4 0))
;->  (LISP (7 8 4 0) FUN (2 5 1) NEWLISP (1 9 6 7 8 4 0))
;->  (LISP (7 3 6 0) FUN (2 5 1) NEWLISP (1 8 4 7 3 6 0)))
;-> 6571.633


--------------------------------
Centroide di un insieme di punti
--------------------------------

Il centroide (cx, cy) di un insieme di N punti viene calcolato con la seguente formula:

       N                   N
       ∑(xi)               ∑(yi)
      i=1                 i=1
cx = -------,       cy = -------
        N                   N

Scriviamo prima una funzione in stile funzionale:

(define (centroid1 points)
  (let (num-points (length points))
    (list (div (apply add (map first points)) num-points)
          (div (apply add (map last points)) num-points))))

Poi una funzione in stile iterativo:

(define (centroid2 points)
  (local (sum-x sum-y num-points out)
    (setq num-points (length points))
    (setq sum-x 0)
    (setq sum-y 0)
    (dolist (p points)
      (setq sum-x (add sum-x (p 0)))
      (setq sum-y (add sum-y (p 1)))
    )
    (list (div sum-x num-points)
          (div sum-y num-points))))

Per verificare la correttezza e la velocità delle due funzioni creiamo 1 milione di punti casuali:

(silent
  (setq x (random 1 100 1e6))
  (setq y (random 1 100 1e6))
  (setq pts (map list x y)))

(length pts)
;-> 1000000
(pts 0)
;-> (1.125125888851589 50.36368907742546)

(time (println (centroid1 pts)))
;-> (50.99634344218945 51.00998672902124)
;-> 279.816

(time (println (centroid2 pts)))
;-> (50.99634344218945 51.00998672902124)
;-> 262.728

Le due funzioni hanno la stessa velocità, ma accade un effetto strano: la funzione "centroid1" aumenta il tempo di esecuzione nelle chiamate successive:

(time (centroid1 pts))
;-> 683.119
(time (centroid1 pts))
;-> 1125.398

Se generiamo un errore, ad esempio:

(unknow)
;-> ERR: invalid function : (unknow)

La funzione "riparte" dal tempo di esecuzione minimo (ed aumenta nelle chiamate successive):

(time (centroid1 pts))
;-> 274.307
(time (centroid1 pts))
;-> 674.237
(time (centroid1 pts))
;-> 1135.259

La risposta di Lutz:
"Over time environment and stack memory gets fragmented by certain functions. The error forces a total low level freeing and reallocation of this memory. There is nothing we can do about it without slowing down everywhere, but it is a rare enough problem. Until now, I have never seen this before."

Invece il tempo della funzione "centroid2" rimane costante:

(time (centroid2 pts))
;-> 725.645
(time (centroid2 pts))
;-> 709.218

Il perchè è un mistero (forse una gestione errata della memoria da parte del S.O.), comunque questo non si verifica se abbiamo un numero inferiore di punti (es.100.000):

(silent
  (setq x (random 1 100 1e5))
  (setq y (random 1 100 1e5))
  (setq pts (map list x y)))

(length pts)
;-> 100000

(time (println (centroid1 pts)))
;-> (50.99634344218945 51.00998672902124)
;-> 62.478
(time (centroid1 pts))
;-> 53.411
(time (centroid1 pts))
;-> 53.39
(time (centroid1 pts))
;-> 68.99

(time (println (centroid2 pts)))
;-> (50.99634344218945 51.00998672902124)
;-> 31,273
(time (centroid2 pts))
;-> 37.769
(time (centroid2 pts))
;-> 46.86
(time (centroid2 pts))
;-> 46.856
(time (centroid2 pts))
;-> 46.856
(time (centroid2 pts))
;-> 46.869


-------------
guiserver.lsp
-------------

guiserver.lsp è un modulo per interfacciarsi con guiserver.jar, un'applicazione server Java per la generazione di GUI (interfacce utente grafiche) e grafica 2D per applicazioni newLISP. Il modulo guiserver.lsp, implementa un'API newLISP molto più piccola e astratta delle API delle librerie Java Swing con cui si interfaccia. Per questo motivo, le applicazioni GUI possono essere create molto più velocemente rispetto a quando si utilizzano le API Java originali.

Manuale di guiserver: http://www.newlisp.org/guiserver/guiserver.lsp.html

Vediamo un esempio di come è possibile creare una finestra grafica e disegnare qualche primitiva:

(load (append (env "NEWLISPDIR") "/guiserver.lsp"))
(gs:init)
(gs:frame 'Colors 0 0 1280 900 "colors") ; crea finestra
(gs:set-border-layout 'Colors) ; imposta il layout della finestra
(gs:canvas 'MyCanvas 'Colors) ; crea canvas grafico
(gs:add-to 'Colors 'MyCanvas "center")
(gs:set-background 'MyCanvas gs:white) ; colore background canvas
(gs:set-paint gs:black) ; default color (if not specified in shape or text)
; disegniamo alcune linee
(gs:draw-line 'L 10 50 630 590 '(1 0 0))
(gs:draw-line 'L 20 40 630 590 '(0 1 0))
(gs:draw-line 'L 30 30 630 590 '(0 0 1))
(gs:draw-line 'L 50 100 630 590 '(.2 0 0))
(gs:draw-line 'L 50 150 630 590 '(.1 .1 1))
(gs:draw-line 'L 50 250 630 590 '(.1 .1 .1))
(gs:draw-line 'L 50 350 630 590) ; senza colore NON disegna
(gs:draw-line 'L 50 450 630 590 gs:green)
(gs:draw-line 'L 0 640 640 0 gs:red)
(gs:draw-line 'L 0 610 637 0 gs:orange) ; sembra più giallo
;; rettangoli
(gs:draw-rect 'R 100 150 250 200 gs:red)
(gs:draw-rect 'R 120 170 250 200 gs:green)
(gs:draw-rect 'R 140 190 250 200 gs:blue)
(gs:draw-rect 'R 160 210 250 200) ;; senza colore lo disegna
;; rettangoli pieni
(gs:fill-rect 'R 30 50 100 60 gs:pink)
(gs:fill-rect 'R 230 50 100 60 gs:yellow)
(gs:fill-rect 'R 400 50 100 60)
;; e poi...
(gs:draw-round-rect 'R 30 80 100 60 30 20 gs:black)
(gs:fill-round-rect 'R 35 85 30 20 10 7 gs:blue)
; cerchi
(gs:draw-circle 'C 120 300 100 gs:green)
(gs:fill-circle 'C 120 300 30 gs:green)
(gs:fill-circle 'C 120 300 10)
; ellisse
(gs:draw-ellipse 'E 220 300 100 60 gs:blue)
; archi
(gs:draw-arc 'A 475 300 100 150 30 300)
(gs:fill-arc 'A 500 325 50 100 30 270)
; testo
(gs:set-font 'MyCanvas "Lucida Sans Regular" 40 "italic")
(gs:draw-text 'T "Prima prova"  60 100)
(gs:set-font 'MyCanvas "Monospaced" 40 "plain")
(gs:draw-text 'T "con forme e linee"  60 160 gs:green -15)
(gs:set-font 'MyCanvas "Monospaced" 20 "plain")
(gs:draw-text 'T
         "angoli scritte positivi se orari"  60 160 gs:black 30)
(gs:set-font 'MyCanvas "Lucida Sans Regular" 40 "bold")
(gs:draw-text 'T "dedicato a Giulia"  100 600) ; only for testing
; listen for incoming action requests and dispatch
(gs:listen)
(gs:set-visible 'Colors true) ; rende visibile la finestra
(gs:export "uno.png") ; esporta la finestra come file .png
; (gs:listen) ; exit application when the guiserver exit
(gs:listen true) ; don't exit application when the guiserver exit
;; eof


--------------------------
La funzione "memcmp" del C
--------------------------

Nel linguaggio di programmazione C, la funzione "memcmp" restituisce un numero intero negativo, zero o positivo a seconda che i primi n caratteri (bytes) della stringa s1 siano minori, uguali o maggiori dei primi n caratteri (byutes) della stringa s2. In realtà "memcmp" confronta i byte come caratteri senza segno di due blocchi di memoria, ma in questo caso considereremo un byte come un carattere, cioè scriveremo una funzione "memcmp" per applicarla alle stringhe.
Quindi nel nestro caso, la funzione "memcmp" restituirà un numero intero negativo, zero o positivo a seconda che i primi n caratteri della stringa da s1 siano minori, uguali o maggiori dei primi n caratteri della stringa s2.
Schematicamente:
  = 0  --> s1 e s2 sono uguali
  < 0  --> Il primo carattere diverso di s1 è più piccolo di quello di s2
  > 0  --> Il primo carattere diverso di s1 è più grande di quello di s2

(define (memcmp s1 s2 num-char)
  (let ((out 0) (stop nil))
    (for (i 0 (- num-char 1) 1 stop)
      (if (!= (s1 i) (s2 i))
          (cond ((or (and (>= (s1 i) 0) (>= (s2 i) 0))
                     (and (<  (s1 i) 0) (<  (s2 i) 0)))
                 (setq stop true)
                 (setq out (- (char (s1 i)) (char (s2 i)))))
                ((and (< (s1 i) 0) (>= (s2 i) 0))
                 (setq stop true)
                 (setq out 1))
                ((and (< (s2 i) 0) (>= (s1 i) 0))
                 (setq stop true)
                 (setq out -1))
          )
      )
    )
    out))

Vediamo un paio di esempi:

(memcmp "abcdef" "abc" 3)
;-> 0
(memcmp "abcdef" "abb" 3)
;-> 1
(memcmp "abcdef" "abd" 3)
;-> -1

(setq str1 "C memcmp with newLISP");
(setq str2 "C memcmp is a memory compare function");
(memcmp str1 str2 9)
;-> 0
(memcmp str1 str2 10)
;-> -8


----------------------------
Algoritmi di string matching
----------------------------

Possiamo trovare molte implementazioni di algoritmi di string-matching al seguente indirizzo:
https://www-igm.univ-mlv.fr/~lecroq/string/
Gli autori sono Christian Charras e Thierry Lecroq del Laboratorio di Informatica dell'Università di Rouen in Francia.
Vengono presentati 35 algoritmi di string-matching scritti in linguaggio C:

Brute Force algorithm
Deterministic Finite Automation algorithm
Karp-Rabin algorithm
Shift Or algorithm
Morris-Pratt algorithm
Knuth-Morris-Pratt algorithm
Simon algorithm
Colussi algorithm
Galil-Giancarlo algorithm
Apostolico-Crochemore algorithm
Not So Naive algorithm
Boyer-Moore algorithm
Turbo BM algorithm
Apostolico-Giancarlo algorithm
Reverse Colussi algorithm
Horspool algorithm
Quick Search algorithm
Tuned Boyer-Moore algorithm
Zhu-Takaoka algorithm
Berry-Ravindran algorithm
Smith algorithm
Raita algorithm
Reverse Factor algorithm
Turbo Reverse Factor algorithm
Forward Dawg Matching algorithm
Backward Nondeterministic Dawg Matching algorithm
Backward Oracle Matching algorithm
Galil-Seiferas algorithm
Two Way algorithm
String Matching on Ordered Alphabets algorithm
Optimal Mismatch algorithm
Maximal Shift algorithm
Skip Search algorithm
KMP Skip Search algorithm
Alpha Skip Search algorithm

Vediamo un paio di algoritmi riscritti in newLISP:

String algorithm: Brute Force
-----------------------------

(define (BF x y)
(catch
  (let ((m (length x)) (n (length y)))
    (for (j 0 (- n m))
      (setq i 0)
      (while (and (< i m) (= (x i) (y (+ i j)))) (++ i))
      (if (>= i m) (throw j))))))

(setq x "GCAGAGAG")
(setq y "GCATCGCAGAGAGTATACAGTACG")

(BF x y)
;-> 5

(find "GCAGAGAG" "GCATCGCAGAGAGTATACAGTACG")
;-> 5

String algorithm: Not So Naive
------------------------------

(define (NSN x y)
(catch
  (local (m n k ell j)
    (setq m (length x))
    (setq n (length y))
    ; preprocessing
    (cond ((= (x 0) (x 1))
          (setq k 2) (setq ell 1))
          (true
          (setq k 1) (setq ell 2))
    )
    ; searching
    (setq j 0)
    (while (<= j (- n m))
      (cond ((!= (x 1) (y (+ j 1)))
             (setq j (+ j k)))
            ((zero? (memcmp (slice x 2) (slice y (+ j 2)) (- m 2)))
             (throw j)
            )
            (true (setq j (+ j ell))))))))

(NSN x y)
;-> 5

I migliori algoritmi di string-matching (senza preprocessing) hanno un complessità temporale uguale a O(n).
Comunque le funzioni integrate (es. find) sono sicuramente più veloci di qualunque implementazione di questi algoritmi in newLISP.


--------------------------
La funzione "assert" del C
--------------------------

Quando si effettua il debug di un programma, è spesso utile sapere che una condizione o un insieme di condizioni è vera. Prima di eseguire una determinata elaborazione, vengono dichiarate alcune "asserzioni" che devono essere verificate. Il linguaggio C fornisce la macro "assert()" per definire queste asserzioni. Se un'asserzione fallisce, la macro provvede alla stampa di un messaggio diagnostico che descrive la condizione che avrebbe dovuto essere vera, ma non lo era, quindi termina il programma.

Vediamo un esempio dell'utilizzo di assert() in C:

#include <assert.h>
int func(int a, double b)
{
  assert(a <= 0 && b >= 1);
  ...
}

Se l'asserzione fallisce, viene stampato un messaggio simile a questo:

file.c:5: func: assertion failed: a <= 0 && b >= 1

e termina il programma chiamando "abort".

Le asserzioni vengono utilizzate principalmente per verificare situazioni logicamente impossibili. Ad esempio, possono essere utilizzate per controllare uno stato prima dell'avvio dell'elaborazione o lo stato al termine dell'elaborazione. A differenza della normale gestione degli errori, in genere le asserzioni vengono disabilitate in fase di esecuzione.
Nota: non scrivere espressioni in assert() che causano effetti collaterali (es. assert(x = 2)).

Possiamo scrivere una macro che simula "assert()":

(define-macro (assert condition)
  (if (eval condition) true
      (throw-error (format "assert failed: %s " (string condition)))))

Proviamo la funzione:

(define (test a b)
  (assert (!= b 0))
  (div a b))

(test 10 2)
;-> 5

(test 10 0)
;-> ERR: user error : assert failed: (!= b 0)
;-> called from user function (assert (!= b 0))
;-> called from user function (test 10 0)

Quando l'asserzione fallisce viene mostrata l'espressione non vera, ma senza valori (cioè, "b" non viene valutato nella prima riga di output). Per fare questo possiamo modificare la funzione nel modo seguente:

Funzione che valuta solo i simboli non-primitivi:

(define (eval-var x)
  (if (primitive? (eval x))
      x
      (eval x)))

Funzione che applica una funzione a tutti gli elementi di una lista annidata:

(define (map-all f lst)
  (let (result '())
    (dolist (el lst)
      (if (list? el)
        (push (map-all f el) result -1)
        (push (f el) result -1)))
    result))

Nuova funzione "assert1":

(define-macro (assert1 condition)
  (if (eval condition) true
      (throw-error (format "assert failed: %s "
        (join (map string (map-all eval-var condition)) " ")))))

Proviamo con lo stesso esempio precedente:

(define (test1 a b)
  (assert1 (!= b 0))
  (div a b))

(test1 10 0)
;-> ERR: user error : assert failed: != 0 0
;-> called from user function (assert1 (!= b 0))
;-> called from user function (test1 10 0)

Un esempio con più variabili:

(set 'a 1 'b 1 'c 3 'd 3)
(define (test2)
  (assert1 (or (and (= a b) (> c d)) (> a b))))

(test2)
;-> ERR: user error : assert failed: or (and (= 1 1) (> 3 3)) (> 1 1)
;-> called from user function (assert1 (or (and (= a b) (> c d)) (> a b)))
;-> called from user function (test2)

Un esempio con una funzione in "assert":

(define (double x) (* x x))
(define (test3 a b)
  (assert1 (> (double a) 5))
  (+ a b))

(test3 2 3)
;-> ERR: user error : assert failed: > ((lambda (x) (* x x)) 2) 5
;-> called from user function (assert1 (> (double a) 5))
;-> called from user function (test3 2 3)

In genere utilizzo la funzione "assert" e, invece di creare un'unica asserzione complessa, preferisco inserire più asserzioni con condizioni semplici.


------------------------------------------------------------------------
Rappresentazione dei grafi: Lista di Adiacenza <--> Matrice di Adiacenza
------------------------------------------------------------------------

Lista di adiacenza: viene utilizzata un vettore (lista) di liste. La dimensione del vettore è uguale al numero di nodi (vertici). L'elemento i-esimo del vettore contiene la lista dei vertici adiacenti a quell'i-esimo nodo all'i-esimo vertice.
Nota: la rappresentazione che useremo contiene anche il valore "i" del nodo i-esimo.

Matrice di adiacenza: La matrice di adiacenza è una matrice 2D di dimensioni NxN dove N è il numero di nodi in un grafo. L'elemento mat[i][j] = 1 indica che esiste un arco dal nodo "i" al nodo "j".

Per esempio il seguente grafo ha tutti gli archi bidirezionali:

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 3 |   | 4 |
          +---+   +---+   +---+
         /          |    /
        /           |   /
       /            |  /
  +---+           +---+
  | 2 |           | 5 |
  +---+           +---+

E viene rappresentato con la seguente lista di adiacenza:

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4))))

Algoritmo per convertire da "Lista di adiacenza" a "Matrice di adiacenza":
   - Inizializzare una matrice con tutti 0.
   - Iterare sui nodi della lista di adiacenza
   - Per ogni j-esimo nodo della lista di adiacenza, attraversare i suoi nodi vicini.
   - Per ogni nodo "i" con cui il j-esimo nodo ha un arco, porre mat[i][j] = 1.

(define (adjlist-adjmatrix graph)
  (local (num-vertex matrix)
    (setq num-vertex (length graph))
    (setq matrix (array num-vertex num-vertex '(0)))
    (dolist (nodo g)
      (setq j (nodo 0))
      (dolist (i (nodo 1))
        (setf (matrix i j) 1)
      )
    )
    matrix))

(setq m (adjlist-adjmatrix g))
;-> ((0 1 0 1 1 0)
;->  (1 0 1 0 0 0)
;->  (0 1 0 0 0 0)
;->  (1 0 0 0 0 1)
;->  (1 0 0 0 0 1)
;->  (0 0 0 1 1 0))

Algoritmo per convertire da "Matrice di adiacenza" a "Lista di adiacenza":
  - Creare un vettore di liste e attraversa la matrice di adiacenza.
  - Per ogni cella in cui risulta mat[i][j] == 1 (cioè c'è un arco da "i" a "j"), inserire "j" nell'elenco nella i-esima posizione del vettore di liste.

(define (adjmatrix-adjlist graph)
  (local (num-vertex vet lst)
    (setq num-vertex (length graph))
    (setq vet (array num-vertex '(())))
    (setq lst '())
    (for (i 0 (- num-vertex 1))
      (for (j 0 (- num-vertex 1))
        (if (= (graph i j) 1)
            (push j (vet i) -1)
        )
      )
    )
    ; creazione lista di adiacenza dal vettore
    (for (i 0 (- num-vertex 1))
      (push (list i (vet i)) lst -1)
    )
    lst))

(adjmatrix-adjlist m)
;-> ((0 (1 3 4)) (1 (0 2)) (2 (1)) (3 (0 5)) (4 (0 5)) (5 (3 4)))

(= (adjmatrix-adjlist m) g)
;-> true


---------------------------------------------------------------
Attraversamento di grafi - Algoritmo BFS (Breadth-First Search)
---------------------------------------------------------------

L'attraversamento di un grafo è il processo di spostamento da un nodo radice a tutti gli altri nodi del grafo. L'ordine dei nodi dato da un attraversamento varia a seconda dell'algoritmo utilizzato per il processo.

La ricerca in ampiezza (BFS - Breadth-First Search) si basa sull'attraversamento dei nodi mediante l'aggiunta del vicino di ogni nodo, a partire dal nodo radice, alla coda di attraversamento. L'algoritmo BFS per un grafo è simile a quello per un albero, l'unica differenza è che i grafi possono contenere cicli. A differenza della ricerca in profondità (DFS (Depth-First Search), vengono esplorati tutti i nodi alla profondità corrente prima di passare al livello successivo.

Algoritmo BFS
  - Prendere come input una lista di adiacenza che rappresenta il grafo.
  - Inizializzare una coda FIFO (First In First Out).
  - Accodare il nodo radice (cioè inserire il nodo radice all'inizio della coda).
  - Eliminare dalla coda la testa (o il primo elemento), quindi accodare tutti i suoi nodi vicini, partendo da sinistra a destra. Se un nodo non ha nodi vicini che devono essere esplorati, rimuovere semplicemente la testa dalla coda e continuare il processo. (Nota: se appare un vicino già esplorato o in coda, non metterlo in coda, saltarlo semplicemente.)
  - Continuare a ripetere questo processo finché la coda non è vuota.

Casi particolari
Ora, c'è sempre il rischio che il grafo da esplorare abbia uno o più cicli. Ciò significa che c'è la possibilità di tornare a un nodo che abbiamo già esplorato. Per risolvere questo problema manteniamo un array per tutti i nodi. L'array all'inizio del processo avrà tutti i suoi elementi inizializzati su 0 (o false). Dopo aver esplorato un nodo una volta, l'elemento corrispondente nell'array verrà impostato su 1 (o true). Quindi accodiamo i nodi solo se il valore del loro elemento corrispondente nell'array è 0 (o falso).

Cosa succede quando il grafo fornito come input è un grafo disconnesso? In altre parole, cosa succede quando il grafo non ha una, ma più componenti che non sono collegate? Come sopra, manterremo un array per tutti gli elementi nel grafo. L'idea è di eseguire in modo iterativo l'algoritmo BFS per ogni elemento dell'array che non è impostato su 1 dopo il completamento dell'esecuzione iniziale dell'algoritmo BFS. Questo è ancora più rilevante nel caso dei grafi diretti a causa dell'aggiunta del concetto di "direzione" di attraversamento.

La complessità temporale del BFS vale O(nodi + archi) dove "nodi" è il numero di nodi nel grafico ed "archi" è il numero di archi.

Poiché l'algoritmo richiede una coda per memorizzare i nodi che devono essere attraversati, la complessità spaziale vale O(nodi).

Vediamo un esempio di un grafo con tutti gli archi bidirezionali:

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 3 |   | 4 |
          +---+   +---+   +---+
         /          |    /
        /           |   /
       /            |  /
  +---+           +---+
  | 2 |           | 5 |
  +---+           +---+

Vediamo di eseguire l'algoritmo passo per passo:

Enqueue => aggiunge un elemento alla fine alla coda
Dequeue => rimuove un elemento all'inizio della coda

Passo 1: Enqueue(0).
Coda dopo passo 1: 0

Passo 2: Dequeue(0), Enqueue(1), Enqueue(3), Enqueue(4).
Coda dopo passo 2: 1 3 4

Passo 3: Dequeue(1), Enqueue(2).
Coda dopo passo 3: 3 4 2

Passo 4 : Dequeue(3), Enqueue(5). Poiché 0 è già stato esplorato, non aggiungiamo nuovamente 1 alla coda.
Coda dopo passo 4: 4 2 5

Passo 5: Dequeue(4).
Coda dopo passo 5: 2 5

Passo 6: Dequeue(2).
Coda dopo passo 6: 5

Passo 7: Dequeue(5).
Coda dopo passo 7:
Poiché la coda è di nuovo vuota a questo punto, interrompiamo il processo.

Adesso vediamo una possibile implementazione dell'algoritmo.

Il grafo ha tutti gli archi bidirezionali e viene rappresentato con la seguente lista di adiacenza:

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4))))

Numero di nodi:
(length g)
;-> 6

Funzione BFS:

(define (BFS graph start)
  (local (out num-vertex visited queue)
    (setq out '()) ; lista dei nodi BFS
    (setq num-vertex (length graph)) ; numero di vertici/nodi
    (setq visited (array num-vertex '(nil))) ; array di nodi da visitare
    (setq queue '()) ; coda FIFO
    (setf (visited start) true) ; nodo di partenza: visitato
    (push start queue) ; nodo di partenza inserito in cima alla coda
    (while (!= queue '()) ; ciclo sulla coda
      (setq start (pop queue)) ; rimuove il primo elemento della coda
      (push start out -1) ; inserisce l'elemento nella soluzione
      ; ciclo sui nodi collegati al nodo corrente (start)
      (dolist (el (graph start 1))
        ; inserisce nella coda tutti i "vicini" del nodo start
        ; che non sono stati visitati
        (cond ((not (visited el))
               (setf (visited el) true)
               (push el queue -1))
        )
      )
    )
    out))

(BFS g 0)
;-> (0 1 3 4 2 5)

(BFS g 2)
;-> (2 1 0 3 4 5)

Altro grafo (disconesso):

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 3 |   | 4 |
          +---+   +---+   +---+
         /          |    /
        /           |   /
       /            |  /
  +---+           +---+       +---+   +---+
  | 2 |           | 5 |       | 6 |---| 7 |
  +---+           +---+       +---+   +---+

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4)) (6 (7)) (7 (6))))

(BFS g 0)
;-> (0 1 3 4 2 5)

(BFS g 6)
;-> (6 7)

(BFS g 7)
;-> (7 6)


---------------------------------------------------------------
Attraversamento di grafi - Algoritmo DFS (Depth-First Search)
---------------------------------------------------------------

La ricerca in profondità (DFS - Depth-First Search) è un algoritmo di attraversamento del grafo che inizia a esplorare da un nodo di origine (generalmente il nodo radice) e quindi esplora quanti più nodi possibile prima di tornare indietro (backtracking). A differenza della ricerca in ampiezza, l'esplorazione dei nodi con questo metodo è per natura molto disuniforme.

Algoritmo DFS
  - Prendere come input una lista di adiacenza che rappresenta il grafo.
  - Inizializzare una pila (stack).
  - Mettere il nodo radice all'inizio della pila.
  - Se il nodo radice non ha vicini, fermarsi qui. Altrimenti, inserire il nodo vicino più a sinistra che non è già stato esplorato nello stack. Continuare questo processo fino a quando si incontra un nodo che non ha vicini (o i cui vicini sono già stati aggiunti allo stack), allora occorre fermare il processo, estrarre un nodo dalla pila e continuare il processo con il nuovo nodofai scoppiare la testa e quindi continuare il processo per il nodo che è saltato.
  - Continuare a ripetere questo processo fino a quando la pila non diventa vuota.

Casi particolari
Ora, c'è sempre il rischio che il grafo da esplorare abbia uno o più cicli. Ciò significa che c'è la possibilità di tornare a un nodo che abbiamo già esplorato. Per risolvere questo problema manteniamo un array per tutti i nodi. L'array all'inizio del processo avrà tutti i suoi elementi inizializzati su 0 (o false). Dopo aver esplorato un nodo una volta, l'elemento corrispondente nell'array verrà impostato su 1 (o true). Inseriamo semplicemente i nodi nella pila solo se il valore del loro elemento corrispondente nell'array è 0 (o falso).

Cosa succede se il grafico fornito è un grafico disconnesso? In altre parole, cosa succede quando il grafo non ha una, ma più componenti che non sono collegate? Come sopra, manterremo un array per tutti gli elementi nel grafo. L'idea è di eseguire in modo iterativo l'algoritmo DFS per ogni elemento dell'array che non è impostato su 1 dopo il completamento dell'esecuzione iniziale dell'algoritmo DFS.

La complessità temporale del DFS vale O(nodi + archi) dove "nodi" è il numero di nodi nel grafico ed "archi" è il numero di archi.

Poiché l'algoritmo richiede una pila per memorizzare i nodi che devono essere attraversati, la complessità spaziale vale O(nodi).

L'algoritmo DFS può essere implementato in modo ricorsivo e in modo iterativo.
L'implementazione non ricorsiva è simile alla ricerca in ampiezza (BFS) ma differisce da essa in due modi:
1) usa una pila invece di una coda
2) ritarda il controllo se un vertice è stato visitato fino a quando il vertice non viene estratto dalla pila piuttosto che effettuare questo controllo prima di aggiungere il vertice.

Se G è un albero, la sostituzione della coda dell'algoritmo di ricerca in ampiezza con una pila produrrà un algoritmo di ricerca in profondità. Per un generico grafo, la sostituzione della pila nell'implementazione iterativa della ricerca in profondità con una coda produce un algoritmo di ricerca in ampiezza, sebbene in qualche modo non standard.

Ecco un esempio di un grafo con tutti gli archi bidirezionali:

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 3 |   | 4 |
          +---+   +---+   +---+
         /          |    /
        /           |   /
       /            |  /
  +---+           +---+
  | 2 |           | 5 |
  +---+           +---+

Il grafo ha tutti gli archi bidirezionali e viene rappresentato con la seguente lista di adiacenza:

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4))))

Vediamo una possibile implementazione iterativa:

(define (DFS graph start)
  (local (out num-vertex visited stack)
    (setq out '()) ; lista dei nodi DFS
    (setq num-vertex (length graph)) ; numero di vertici/nodi
    (setq visited (array num-vertex '(nil))) ; array di nodi da visitare
    (setq stack '()) ; pila LIFO
    (push start stack) ; nodo di partenza inserito in cima alla pila
    (while (!= stack '()) ; ciclo sulla coda
      (setq start (pop stack)) ; rimuove il primo elemento della pila
      (cond ((nil? (visited start))
             (push start out -1)
             (setf (visited start) true)) ; nodo visitato
      )
      ; ciclo sui nodi collegati al nodo corrente (start)
      (dolist (el (graph start 1))
        ; inserisce nella pila tutti i "vicini" del nodo start
        ; che non sono stati visitati
        (cond ((not (visited el))
               (push el stack))
        )
      )
    )
    out))

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4))))

(DFS g 0)
;-> (0 4 5 3 1 2)

Altro grafo (disconesso):

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 3 |   | 4 |
          +---+   +---+   +---+
         /          |    /
        /           |   /
       /            |  /
  +---+           +---+       +---+   +---+
  | 2 |           | 5 |       | 6 |---| 7 |
  +---+           +---+       +---+   +---+

(setq g '((0  (1 3 4)) (1  (0 2)) (2  (1))
          (3  (0 5)) (4 (0 5)) (5 (3 4)) (6 (7)) (7 (6))))

(DFS g 0)
;-> (0 4 5 3 1 2)

(DFS g 6)
;-> (6 7)

(DFS g 7)
;-> (7 6)

Proviamo con un altro grafo (da wikipedia):

                  +---+
                  | 0 |
                  +---+
                 /  |  \
                /   |   \
               /    |    \
          +---+   +---+   +---+
          | 1 |   | 2 |   | 4 |
          +---+   +---+   +---+
         /    |      |      |
        /     |      |      |
       /      |      |      |
  +---+     +---+  +---+    |
  | 3 |     | 5 |  | 6 |    |
  +---+     +---+  +---+    |
              |             |
              |             |
              +-------------+

(setq w '((0  (1 2 4)) (1 (0 3 5)) (2  (0 6)) (3 (1))
          (4  (0 5)) (5  (1 4)) (6 (2))))

(DFS w 0)
;-> (0 4 5 1 3 2 6)


-------------------------------------------------
Passare una funzione con argomenti come parametro
-------------------------------------------------

Possiamo passare una funzione con parametri nel modo seguente:

(define (do-func func arg) (func arg))
;-> (lambda (func arg) (func arg))

Proviamo con una funzione integrata:

(do-func upper-case "ciao")
;-> "HELLO"

E con una funzione definita dall'utente:

(define (doppio x) (* 2 x))
(do-func doppio 2)
;-> 4

Se la funzione da passare ha due parametri possiamo scrivere una funzione simile:

(define (do-func2 func arg1 arg2) (func arg1 arg2))
;-> (lambda (func arg1 arg2) (func arg1 arg2))

(define (somma a b) (+ a b))
(do-func2 somma 3 5)
;-> 8

Possiamo anche scrivere una funzione più generale che esegue una funzione passata con un numero qualunque di parametri:

(define (do-func3)
  (eval (args)))

Facciamo alcune prove:

(do-func3 upper-case "ciao")
;-> "CIAO"

(do-func3 sin 10)
;-> -0.5440211108893698

(do-func3 doppio 10)
;-> 20

(do-func3 somma 10 20)
;-> 30


--------------------
Funzioni nelle liste
--------------------

Utilizzando la funzione "eval" possiamo eseguire funzioni che si trovano all'interno di liste.
Supponiamo di avere la lista seguente:

(setq lst '(string "a" "b"))

Per applicare la funzione "string" alle stringhe "a" e "b" possiamo scrivere

((eval (lst 1)) (lst 0) (lst 2))
;-> "ab"

Vediamo un altro esempio:

(setq lst '((nome trim) (anni int)))
(setq nome "pippo    ")
(setq anni 5.4)

(setq nome (eval (list (lst 0 1) (eval (lst 0 0)))))
;-> pippo
(setq anni (eval (list (lst 1 1) (eval (lst 1 0)))))
;-> 5


---------------------------------
Limite di annidamento delle liste
---------------------------------

Non ci sono limiti alla profondità di annidamento delle liste, l'unico vero limite è la memoria del sistema:

(setq L '((((((((((((((((((((((((((((((((((((x)))))))))))))))))))))))))))))))))))))
;-> ((((((((((((((((((((((((((((((((((((x))))))))))))))))))))))))))))))))))))
(setq V (ref 'x L))
;-> (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
(L V)
;-> x
(nth V L)
;-> x
(setf (L V) 99)
;-> 99
L
;-> ((((((((((((((((((((((((((((((((((((99))))))))))))))))))))))))))))))))))))
(nth '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) L)
;-> 99
(pop L V)
;-> 99
L
;-> (((((((((((((((((((((((((((((((((((())))))))))))))))))))))))))))))))))))

newLISP è l'unico LISP con questo tipo di supporto per le liste indicizzate, altri LISP devono scrivere algoritmi ricorsivi complessi per raggiungere questo obiettivo.

=============================================================================

