=============

 NOTE LIBERE

=============

----------------
Perchè newLISP ?
----------------

LISP è uno dei linguaggi di programmazione più antichi del mondo, risalente agli anni '50 (progettato da John MacCarthy e sviluppato da Steve Russel nel 1958). Sorprendentemente è sopravvissuto fino ai giorni nostri, ed è ancora vivo e vegeto, anche dopo la nascita di nuovi linguaggi come Python, Ruby o Julia. newLISP è una versione di LISP rivolta principalmente allo scripting, ma in grado di realizzare anche programmi completi. Ecco le principali caratteristiche del linguaggio:

- facile da installare
- veloce
- open-source
- multipiattaforma
- librerie integrate
- espandibile con moduli e shared C-library
- compatibile con il web
- documentazione ottima

Inoltre, infastidisce i puristi del LISP, ed è spesso una buona cosa sfidare lo status quo.
Il creatore del linguaggio è Lutz Mueller (Don Lucio) e la seguente è la cronologia delle release:

Version Year  Changes and Additions
1.0     1991  First version running on Sun4 with SunOS/BSD 4.1
1.3     1993  Windows 3.0 Win16 version released on Compuserve
2.11    1994  Windows 3.0 Win16
3.0     1995  Windows 95 Win32 version
6.0     1999  Open Source UNIX multi platform, licensed GPL
6.3     2001  newLISP-tk Tcl/Tk IDE
6.5.8   2002  PCRE regular expressions
7.1-4   2003  Mac OS X and Solaris support. PDF manual, catch and throw, context variables, Win32 DLL
8.0-3   2004  Arrays, UTF-8 support, forked processes, semaphores, shared memory, default function
8.4-7   2005  Implicit indexing, comma locales, signals and timers, net-eval distributed computing
8.8-9   2006  Prolog-like unify, macro-like variable expansion, more implicit indexing support
9.0     2006  64-bit arithmetic and file support, more array functions, HTTP server mode
9.1     2007  Full 64-bit compile flavor, HTTP/CGI server mode, functors in ref, ref-all, find, replace
9.2     2007  newLISP-GS a Java based GUI library for writing platform independent user interfaces in newLISP
9.3     2008  FOOP – Functional Object Oriented Programming
9.4     2008  Cilk - multiprocessing API implemented in newLISP
10.0    2009  General API cleanup, reference passing, new unified destructive API with setf
10.1    2009  Actor messaging API on Mac OS X, Linux and other UNIX
10.2    2010  FOOP redone with Mutable Objects
10.3    2011  Switchable Internet Protocol between IPv4 and IPv6
10.4    2012  Rewritten message queue interface and extended import API using libffi
10.5    2013  Unlimited precision, integer arithmetic
10.5.2  2013  KMEANS cluster analysis
10.5.7  2014  newLISP in a web browser compiled to JavaScript with good performance
10.6.0  2014  native expansion macro function
10.6.2  2015  minor new functionality
10.7.0  2016  minor new functionality
10.7.1  2017  minor new functionality
10.7.5  2019  minor new functionality and fixed bugs

Indirizzi web:
Home: http://www.newlisp.org
Forum: http://www.newlispfanclub.alh.net/forum/

newLisp ha una sintassi semplice, ma una semantica potente e la sua natura interattiva supporta la prototipazione rapida e incoraggia gli utenti a esplorare e testare soluzioni ai problemi in modo incrementale.

newLISP è un linguaggio di tipo LISP-1, cioè le funzioni e le variabili si trovano nello stesso spazio di nomi (come Scheme). Invece il Common Lisp è un linguaggio di tipo LISP-2, dove le funzioni e le variabili si trovano su due spazi di nomi differenti.


--------------
newLISP facile
--------------

In newLISP tutto è una lista (o s-expression).
Una lista è un insieme di elementi racchiusi da parentesi tonde "(" ")".
Gli elementi di una lista possono essere un'altra lista.
Il primo elemento della lista è "speciale" (funzione).
Il resto della lista sono "normali" (argomenti).
Tutte le liste vengono valutate tranne quelle quotate.

------------------
Apprendere newLISP
------------------

"Alcune considerazioni generali sull'apprendimento della programmazione in newLISP:

Non c'è un "sotto" in newLISP, nessuno stato nascosto, (quasi) tutto è visibile e può essere ispezionato. È possibile utilizzare la funzione "debug" per scorrere attraverso 'define-macro's. Queste non sono macro di espansione compilate come in Common LISP, ma piuttosto fexprs - funzioni senza valutazione automatica dei loro argomenti. Kazimir discute di fexprs in modo più dettagliato sul suo sito.

Non credo sia una buona idea, ad esempio, provare a implementare un "foreach" in newLISP. Ci sono altre funzioni integrate che fanno lo stesso o simili e senza l'overhead di una definizione di funzione / fexpr. Come "map". Kazimir ha semplicemente definito "foreach" come "map".

Non provare a programmare come Common Lisp o Scheme in newLISP. Queste sono linguaggi diversi. Prova a imparare newLISP studiando ed utilizzando le funzioni integrate. Il "nuovo" in newLISP significa una nuova mentalità di programmazione: un approccio Lisp con una mentalità orientata allo scripting di applicazioni, non con una mentalità da Computer Science come sviluppata in Scheme o con una mentalità rivolta alla compilazione del linguaggio come in Common Lisp.

L'introduzione di Cormullion nel WikiBooks è un modo eccellente per imparare nuove LISP. Se si desidera lavorare seriamente in newLISP, è necessario leggere almeno una volta il "Manuale d'uso e riferimento". Ha molti esempi. C'è anche una sezione che raggruppa tutte le funzioni in diverse aree dei problemi. Questo ti aiuterà a scoprire quali funzioni sono già integrate in newLISP.

A volte penso che sarebbe utile avere una "Guida di stile" che definisca determinate convenzioni su come utilizzare il set di funzionalità di newLISP. Poi, pensandoci di nuovo, penso che sarebbe una brutta cosa. Uno dei motivi per cui molti utenti sono attratti da newLISP è la sua malleabilità e flessibilità, che è anche la ragione per cui così tante persone provenienti da professioni creative utilizzano newLISP.

newLISP ti dà la libertà di esprimere la stessa funzionalità in modi e stili diversi, senza costringerti in un "modo giusto" di fare le cose.

Ma sicuramente, ci sono convenzioni emergenti dalla comunità. Ad esempio, racchiudere le macro nel proprio spazio dei nomi è una convenzione adottata spesso."

Lutz

--------------------------
Commentare righe di codice
--------------------------

Per commentare una singola riga utilizzare il carattere ";" ad inizio riga:

;  (println 1 { })

Per commentare una sezione di codice (gruppo di righe) racchiudere la sezione con le parole "[text]" e "[/text]":

[text]
  (print 3 { })
  (print 4 { })
[/text]

(define (test)
;  (println 1 { })
  (print 2 { })
  [text]
  (print 3 { })
  (print 4 { })
  [/text]
  (println 5 { })
)

(test)
;-> 2 5

Per commentare una sezione di codice (gruppo di righe) racchiudere la sezione con i caratteri"{" e "}"

(define (test1)
;  (println 1 { })
  (print 2 { })
{
  (print 3 { })
  (print 4 { })
}
  (println 5 { })
)

(test1)
;-> 2 5

Il risultato è corretto, ma perdiamo il match visivo con le parentesi "{" "}" che si trovano nella sezione commentata. Per risolvere il problema usiamo il carattere doppio apice al posto delle parentesi graffe.

(define (test2)
;  (println 1 " ")
  (print 2 " ")
{
  (print 3 " ")
  (print 4 " ")
}
  (println 5 " ")
)


------------------------
Stile del codice newLISP
------------------------

Ogni linguaggio ha un proprio stile generale nella scrittura el codice. Comunque anche ogni programmatore ha uno stile proprio che deriva dalla sua esperienza. Fortunatamente newLISP permette di scrivere con stili diversi basta che si rispetti la sintassi delle liste (parentesi).
Lo stile non è uno standard, ma solo il modo preferito di scrivere e leggere i programmi. Il problema nasce quando diversi programmatori lavorano sullo stesso codice. In questo caso occorrono delle regole comuni per evitare di avere stili diversi nello stesso programma. Poichè newLISP deriva dal LISP vediamo quali indicazioni vengono raccomandate per questo linguaggio (Common LISP) e quanto sono aderenti a newLISP (e comunque sta a voi scegliere quale stile di scittura si adatta di più al vostro modo di programmare).

--- Regole Generali ---

Funzioni di primo ordine
------------------------
Tutte le funzioni di primo ordine devono iniziare dalla colonna 1.

Chiusura parentesi
Le parentesi chiuse non devono essere precedute dal carattere newline.

Esempio:

;; errato
(define (f x)
  (when (< x 3)
    (++ x)
  )
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x)))

Nota: questa indicazione può non essere la migliore per newLISP.

Diversi programmatori newLISP si allontanano lentamente dalla regola "newline non deve precedere una parentesi chiusa", per usare lo stile di identazione del linguaggio "C". Non solo per una migliore corrispondenza tra le parentesi, ma anche perché è più facile modificare il codice. Nella funzione seguente:

(define (f x)
  (when (< x 3)
    (++ x)
  )
  (pippo x)
)

è molto più facile eliminare o inserire codice prima o dopo le righe in cui le parentesi di chiusura si trovano su righe diverse. Puoi eliminare o inserire una nuova riga senza preoccuparti molto di distruggere l'equilibrio della parentesi. Questo metodo aiuta a gestire programmi con molto codice e la forma visuale delle parentesi facilita l'individuazione dei blocchi di codice.

Comunque è anche vero che lo stile funzionale genera molte parentesi chiuse alla fine di ogni espressione. Quindi ci sono alcuni casi in cui è preferibile chiudere le parentesi sulla stessa linea.

Esempio:

(define (f x)
  (if (< x 3)
    (++ x)
    (begin (pippo x) (++ x))
  )
)

In questo caso la parentesi che chiude "begin" si trova sulla stessa linea.

Per alcuni, il metodo "parentesi chiuse sulla nuova linea" non deve esse usato perchè la lettura dei programmi LISP non deve seguire la corrispondenza delle parentesi, ma seguire l'indentazione. Inoltre  questo metodo richiede più righe per lo stesso codice. In generale, è bene mantenere basso il numero di righe, in modo che più codice si adatti a una pagina o una schermata.

Livello di indentazione
-----------------------
Il livello di indentazione (TAB) dovrebbe essere relativamente piccolo. In genere vengono usati due caratteri spazio per ogni rientro (max 4 caratteri spazio).

Esempio:

;; errato
(define (f x)
    (when (< x 3)
        (++ x)
    )
    (pippo x)
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x)
  )
  (pippo x)
)

;; corretto
(define (f x)
  (when (< x 3)
    (++ x))
  (pippo x))

Con un livello di indentazione piccolo si diminuisce la lunghezza delle righe del programma.

Nomi delle variabili
--------------------
La convenzione è quella di usare lo stile: "dashed-lower-case-names".
I nomi delle variabili vengono scritti in minuscolo e le parole sono separate dal carattere trattino "-" (hyphens). Non utilizzare il carattere underscore "_".
Non utilizzare lettere maiuscole.

giusto: total-time

sbagliato: total_time oppure Total-Time

Un nome di una variabile o funzione (identificatore) deve essere semplice da capire e da leggere. Non dovrebbe essere troppo lungo, ma è meglio un mome lungo che un nome incomprensibile.

giusto: somma-totale

sbagliato: stot

I nomi che rappresentano collezioni di oggetti (es. liste, vettori) devono avere il carattere "s" alla fine (plurale). Non inserire il tipo dell'oggetto nel nome.

giusto: cars

sbagliato: list-of-car

Le variabili globali devono essere racchiuse dal carattere "*" (earmuffing technique):

*global-value*

La variabili costanti devono essere racchiuse dal carattere "+" (earmuffing technique):

+constant-value+

I predicati (funzioni che restituiscono vero (true) o falso (nil) devono avere il carattere "?" alla fine del nome:

primo?

Commenti
--------
1) Numero di punti e virgola ";" (semicolon)
Un singolo punto e virgola viene utilizzato per un commento relativo a una singola riga di codice e si trova sulla stessa riga del codice, ad esempio:

(if (< x err)     ; se x è minore dell'errore
    (calc x)      ; calcola una funzione
    (prova x))    ; altrimenti prova di nuovo

Nota: La funzione "if" è una forma speciale e segue una indentazione differente: le espressioni che devono essere eseguite (calc x) o (prova x) sono allineate alla condizione (< x err).

Due punti e virgola sono usati per un commento che si riferisce a diverse righe di codice. La riga di commento è allineata con le righe di codice e le precede, in questo modo:

(when (< x 2)
  ;; abbandona tutto e ricomincia
  (setq x 0)
  (prova x))

Tre punti e virgola sono usati per i commenti che descrivono una funzione. Tali commenti iniziano sempre nella colonna 1, in questo modo:

;;; Calcola la quantità di spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)
  (map calcola (symbols)))

Quattro punti e virgola sono usati per i commenti che si riferiscono ad un intero file e iniziano sempre dalla colonna 1:

;;;; Libreria per il calcolo con i quaternioni
;;;; Operazioni: +, -, *, /

2) Contenuto dei commenti
Come al solito, cerchiamo di essere brevi, senza perdere il contenuto delle informazioni. Affinché i commenti funzionino con le definizioni, una buona idea è usare la forma imperativa del verbo. In questo modo è possibile evitare espressioni ridondanti come "questa funzione...".

Non scrivere:

;;; Questa funzione calcola lo spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)

Invece, scrivere in questo modo:

;;; Calcola la quantità di spazio tra i simboli
;;; in una lista di valori interi
(define (calcola-spazi-simboli)
  (map calcola (symbols)))

In genere i commenti di una funzione includono anche l'elenco e la spiegazione dei parametri di input/output e i limiti di applicazione degli stessi.

Stringhe di documentazione (documentation string)
-------------------------------------------------
Una stringa di documentazione è una stringa di caratteri che appare in predeterminate posizioni  nel codice (es: la prima espressione nel corpo di una funzione).
Le stringhe di documentazione differiscono dai commenti in quanto sono disponibili in fase di esecuzione. Le stringhe di documentazione devono essere brevi e devono essere associate al nome di una particolare funzione, classe, ecc. Non devono dare spiegazioni generali sul funzionamento di una biblioteca o di una applicazione.
La prima frase di una stringa di documentazione (che in genere si trova nella prima riga),
dovrebbe fornire una breve descrizione dell'oggetto (come il titolo di un giornale).
Il testo successivo della stringa di documentazione dovrebbe espandersi nella descrizione di
l'oggetto. Questa parte della stringa di documentazione (nel caso in cui l'oggetto sia una funzione) potrebbe contenere precondizioni, situazioni di errore che potrebbero essere segnalate e possibili comportamenti inaspettato.
In una stringa di documentazione, quando è necessario fare riferimento a argomenti di funzioni, nomi di classi o altri oggetti lisp, questi nomi vengono scritti in maiuscolo, in modo che essi
siano facili da trovare.

Le stringhe di documentazione possono essere estratte automaticamente (ad esempio per la creazione del manuale di riferimento delle funzioni).

Al seguente indirizzo web potete trovare la guida sullo stile LISP raccomandato da Google:

https://google.github.io/styleguide/lispguide.xml

Un altra lettura molto interessante è "Tutorial on Good Lisp Programming Style" di Peter Norvig:

https://www.cs.umd.edu/~nau/cmsc421/norvig-lisp-style.pdf

Nota: i programmatori Lisp esperti leggono e comprendono il codice in base all'indentazione invece che al controllo del livello/numero delle parentesi.

La mia idea è che ognuno deve creare ed affinare con il tempo il proprio stile di programmazione, sia in termini di scrittura che di logica. Inoltre consiglio di studiare i programmi dei programmatori esperti (questo è uno dei metodi migliori per imparare).

Il mio approccio è quello di scrivere in stile C quando sviluppo una funzione. Una volta che la funzione è definitiva, cioè testata e corretta, converto le parentesi in stile Lisp.


---------------------------------------
Considerazioni sulle parentesi del LISP
---------------------------------------

LISP è l'acronimo di LISt Processing, ma spesso i commenti di scherno di alcuni programmatori lo definiscono come:
Lots of (Insipid | Irritating | Infuriating | Idiotic | ...) (Spurious | Stubborn | Superfluous | Silly | ...) Parentheses. In questo modo la sintassi del LISP viene accusata di rendere il codice incompresibile da leggere e impossibile da scrivere senza errori. Credo che queste idee siano completamente sbagliate.

Prima di tutto le parentesi rendono il codice semplice da leggere (se correttamente indentato) e la loro sintassi può essere compresa da chiunque in 30 minuti. L'unico problema potrebbe essere quello del bilanciamento delle parentesi, ma è dal 1970 che gli editor si prendono cura di risolvere visualmente questo problema. La sintassi del C è molto più complessa e intricata.

Per quanto riguarda la semantica, possiamo notare che la sintassi annidabile e regolare del LISP permette di creare sia una semantica ricorsiva annidabile naturale, che una semantica iterativa/gerarchica.

Un altra critica alla sintassi del LISP è quella rendere il linguaggio a "bassa densità di linee di codice": penso che sia vero il contrario, la semantica dei programmi LISP lo compensa in gran parte con la necessità di scrivere molte meno righe di codice per la stessa funzionalità, rendendo la densità complessiva del codice LISP più alta che in qualsiasi altra linguaggio (inoltre il LISP può estendere la propria semantica tramite le macro e la meta-programmazione).

La struttura di programma cresce naturalmente fino a quando non raggiunge la barriera della comprensione umana, ciò che cambia da una linguaggio all'altro non è questa barriera, propria dell'uomo, ma la quantità di cose utili che si possono esprimere all'interno di questa barriera.

Un altro argomento contro la sintassi di Lisp è che le sue parentesi non aiutano a distinguere la semantica all'interno del codice del programma. Questo è vero, ma in LISP le parentesi indicano l'annidamento del codice, ma non le distinzioni semantiche. Ciò non significa che queste distinzioni non possano essere fatte facilmente in LISP tramite l'utilizzo di altri metodi (moduli, simboli,ecc.)

Quanto a ciò che rende necessarie le parentesi, non è una questione di sintassi prefissa opposta alla sinassi infissa: è una questione di arità fissa contro arità variabile. La sintassi prefissa può funzionare completamente senza parentesi, quando si conosce l'arità di ciascun operatore. In realtà, la prima sintassi prefissa sistematica, la famosa Notazione polacca di Jan Lukasiewicz, è stata ideata proprio come un modo per sbarazzarsi del tutto delle parentesi. La variante postfix di questa notazione, nota come notazione polacca inversa (RPN), si trova nel FORTH, nelle calcolatrici HP, nel PostScript e in molte macchine virtuali.
La necessità delle parentesi è dovuta al fatto che LISP ha una sintassi uniforme ed estensibile che deve adattarsi ad un numero arbitrario di argomenti nei moduli del programma. LISP si standardizza su una sintassi generica che è immediatamente leggibile in modo non ambiguo da qualsiasi Lisper anche senza una conoscenza a priori dell'arità di ogni operatore che appare in un dato dominio. LISP consente inoltre agli utenti di estendere il linguaggio attraverso le macro qualora si desideri una sintassi ad-hoc per un dominio specifico. Quindi, ciò che rende necessarie le parentesi è il fatto che la stessa sintassi deve essere estendibile a funzioni e forme variadiche.

Probabilmente queste critiche alle parentesi sono dovute a diversi fattori:
a) l'uso delle parentesi negli altri linguaggi ha un'interpretazione ambigua
b) aspettative di soluzioni per problemi che provengono da altri linguaggi
c) automatica reazione quando si tratta di imparare qualcosa di nuovo e totalmente diverso

Quelli che conoscono bene il LISP si lamentano di tante cose... ma non della sua sintassi. In fondo le parentesi sono l'emozione del LISP come gli spazi bianchi sono l'emozione di Python.

Per quanto mi riguarda ho imparato più facilmente la sintassi del LISP che quella del C. Il timore iniziale delle "parentesi" si è rapidamente trasformato in simpatia e anche dipendenza. Non è stato un "colpo di fulmine", ma si è trasformato in un sentimento profondo :-)
Le parentesi aiutano benissimo ad isolare le espressioni, che quindi possono essere estratte e riposizionate con facilità all'interno del programma. Inoltre occorre ricordare che: "Un programmatore LISP legge il programma dalla sua indentazione, non controllando l'annidamento delle parentesi."

In genere quando si studia un linguaggio di programmazione è meglio attenersi agli idiomi e ai metodi propri del linguaggio. Solo in seguito, una volta acquisita una sufficiente familiarità, si potranno provare nuove strade o implementare le tecniche di altri linguaggi.

"Learn at least one new [programming] language every year. Different languages solve the same problems in different ways. By learning several different approaches, you can help broaden your thinking and avoid getting stuck in a rut." - The Pragmatic Programmers

"Imparare almeno un nuovo linguaggio di programmazione ogni anno. Linguaggi diversi risolvono gli stessi problemi in modi diversi. Imparando diversi approcci, puoi ampliare il tuo pensiero ed evitare rimanere bloccato in un vicolo cieco." - The Pragmatic Programmers

"newLISP is so much like a pile of clay (in a good way ;-), waiting to be formed into whatever the programming potter wishes it to be, that it's better for it to remain faithful to the simple ideas that originated in LISP and stay a pile of clay. Parentheses and all :-)" - michael


---------------------------------------------
Controllare l'output della REPL (prettyprint)
---------------------------------------------

*************************
>>>funzione PRETTY-PRINT
*************************
sintassi: (pretty-print [int-length [str-tab [str-fp-format]])

Riformatta le espressioni per la stampa, il salvataggio o il sorgente e quando si stampa in una console interattiva (REPL). Il primo parametro, int-length, specifica la lunghezza massima della linea e str-tab specifica la stringa utilizzata per indentare le linee. Il terzo parametro str-fp-format descrive il formato predefinito per la stampa di numeri in virgola mobile. Tutti i parametri sono opzionali. pretty-print restituisce le impostazioni correnti o le nuove impostazioni quando vengono specificati i parametri.

(pretty-print)  → (80 " " "%1.15g")  ; default setting

(pretty-print 90 "\t")  → (90 "\t" "%1.15g")

(pretty-print 100)  → (100 "\t" "%1.15g")

(sin 1)    → 0.841470984807897
(pretty-print 80 " " "%1.3f")
(sin 1)    → 0.841

(set 'x 0.0)
x   → 0.000

Il primo esempio riporta le impostazioni predefinite di 80 colonne per la lunghezza massima della linea e uno spazio per il rientro. Il secondo esempio modifica la lunghezza della linea in 90 e il rientro in un carattere TAB. Il terzo esempio modifica solo la lunghezza della linea. L'ultimo esempio modifica il formato predefinito per i numeri in virgola mobile. Ciò è utile quando si stampano numeri in virgola mobile non formattati senza parti frazionarie e questi numeri dovrebbero essere comunque riconoscibili come numeri in virgola mobile. Senza il formato personalizzato, x verrebbe stampato come 0 indistinguibile dal numero in virgola mobile. Sono interessate tutte le situazioni in cui sono stampati numeri in virgola mobile non formattati.

Si noti che pretty-print non può essere utilizzato per impedire la stampa di interruzioni di riga. Per sopprimere completamente la stampa "pretty print", utilizzare la funzione string per convertire l'espressione in una stringa raw non formattata come nell'esempio seguente:

;; print without formatting

(print (string my-expression))

Esempio base:

(pretty-print)
;-> (80 " " "%1.16g")

(pretty-print 70 " " "%1.16g")
;-> (70 " " "%1.16g")


----------------
File e cartelle
----------------

Cartella --> Directory o Folder

Per vedere la cartella corrente della REPL di newLISP:

!cd
;-> f:\Lisp-Scheme\newLisp\MAX

Per cambiare la cartella corrente della REPL di newLISP:

(change-dir "c:\\util")
;-> true

(change-dir "c:/util")
;-> true

Verifichiamo:

!cd
;-> c:\\util

Ritorniamo alla cartella precedente:

(change-dir "f:\\Lisp-Scheme\\newLisp\\MAX")
;-> true

(change-dir "f:/Lisp-Scheme/newLisp/MAX")
;-> true

Vediamo ora alcune funzioni per stampare la lista dei file e delle cartelle.

"show-tree" mostra tutti i file e le cartelle ricorsivamente:

(define (show-tree dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (show-tree (append dir "/" nde))
          (println (append dir "/" nde)))))

(show-tree "c:\\")

(show-tree "c:/")

(env "newLISPDIR")
;-> "C:\\newlisp"

(show-tree (env "newLISPDIR")) ;; also works on Win32

"show-dir" mostra cartelle dalla cartella corrente:

(define (show-dir dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (if (directory? (append dir "/" nde))
            (println (append dir "/" nde))))))

(show-dir (env "newLISPDIR"))

"show-file" mostra file e cartelle dalla cartella corrente:

(define (show-file dir)
  (dolist (nde (directory dir))
    (println (append dir "/" nde))))

(show-file (env "newLISPDIR"))

(show-file "c:\\")

(show-file "C:\\newlisp\\util")
(show-file "C:/newlisp/util")


----------------
Funzioni e liste
----------------

Definiamo una funzione che somma due numeri:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

La variabile "somma" contiene la definizione (come lista) della funzione lambda:

somma
;-> (lambda (a b) (add a b))

La funzione viene restituita come lista:
(list? somma)
;-> true

Ma è anche una funzione lambda:
(lambda? somma)
;-> true

Quindi una funzione lambda può essere trattata come una lista.
Vediamo i parametri della funzione:

(first somma)
;-> (a b)

Vediamo il corpo della funzione:
(last somma)
;-> (add a b)

Modifichiamo la funzione in modo che calcoli la differenza invece che la somma delle variabili a e b:
(setf (first (last somma)) 'sub)
;-> sub

Controlliamo la modifica:
somma
;-> (lambda (a b) (sub a b))

Eseguiamo la funzione somma:
(somma 6 2)
;-> 4 ; abbiamo ottenuto la differenza

Mi piace questo aspetto del linguaggio: automodificante.

Nota: La funzione "define" è solo "syntactic sugar". Infatti le seguenti espressioni sono equivalenti:

(define (somma a b) (add a b))
;-> (lambda (a b) (add a b))

(setq somma '(lambda (a b) (add a b)))
;-> (lambda (a b) (add a b))

Definiamo la funzione "getdef" che prende come parametro il nome di una funzione utente e restituisce (come lista) la definizione lambda della funzione:

(define (getdef func) (if (lambda? func) func nil))

(getdef somma)
;-> (lambda (a b) (+ a b))

(getdef pow)
;-> nil

Adesso definiamo la funzione "funcall" che esegue la funzione passata.

(define (funcall func) (eval (func (args))))

I parametri di funcall non devono essere valutati quando viene chiamata, quindi quotiamo il parametro (lista) "func":

(funcall '(somma 10 20))
;-> 30

(funcall '(somma (somma 10 20) 6))
;-> 36

(funcall '(sin 12))
;-> -0.5365729180004349

Questo è uno dei motivi per cui mi piace newLISP.


----------
4-4 Puzzle
----------

Definire i seguenti simboli:

zero, uno, due, tre quattro, cinque, sei, sette, otto, nove

utilizzando per ogni numero una espressione matematica che contiene quattro volte il numero 4.
L'espressione può contenere: + add , - sub , * mul , / div , (), separatore decimale, potenza, radice quadrata, fattoriale e numero periodico (es. .4~ = .444444444444444...)

0 - (setq zero (- 44 44))
0 - (setq zero (+ 4 4 (- 4) (- 4)))
0 - (setq zero (+ 4 4 (- (+ 4 4))))
1 - (setq one (/ 44 44))
1 - (setq one (+ (/ 4 4) (- 4 4)))
1 - (setq one (+ (/ 4 4) (+ 4 (- 4))))
2 - (setq due (/ (* 4 4) (+ 4 4)))
2 - (setq due (+ (/ 4 4) (/ 4 4)))
2 - (setq due (- 4 (/ (+ 4 4) 4)))
3 - (setq tre (/ (+ 4 4 4) 4))
4 - (setq quattro (+ 4 (* 4 (- 4 4))))
5 - (setq cinque (/ (+ 4 (* 4 4)) 4))
6 - (setq sei (+ 4 (/ (+ 4 4) 4)))
7 - (setq sette (- (/ 44 4) 4))
7 - (setq sette (- (+ 4 4) (/ 4 4)))
8 - (setq otto (/ (* 4 (+ 4 4)) 4))
8 - (setq otto (- (* 4 4) (+ 4 4)))
8 - (setq otto (- (+ 4 4 4) 4))
9 - (setq nove (+ (+ 4 4) (/ 4 4)))

Possiamo provare anche con altri numeri:

 42  - (setq quarantadue (+ 44 (sqrt 4) (- 4)))
100  - (setq cento (div 44 .44))
200  - (setq duecento (+ (fact 4) (* 4 44)))
666  - (setq beast (div 444 (sqrt .4444444444444444)))
1000 - (setq mille (- (* 4 (pow 4 4)) (fact 4)))


--------------
Il primo Primo
--------------

Non c'è dubbio che per tutto il XVII secolo e l'inizio del XX secolo molti matematici hanno considerato il numero 1 come primo, ma è anche chiaro che questa definizione non è mai stata una visone unificata dei matematici. Euclide, Mersenne, Eulero, Gauss, Dirichlet, Lucas e Landau tutti hanno omesso 1 dai primi. Gli ultimi matematici a considerare il numero 1 come primo sono stati Lebesgue (1899) e Hardy (1933).
Ad oggi, il primo numero Primo è il numero 2.
"What is the Smallest Prime?" Caldwell, Xiong - Journal of Integer Sequences, Vol.15 (2012)


--------------
Uso delle date
--------------

La data in formato ISO 8601: YYYY-MM-DD hh:mm:ss

2019-06-31 12:42:22

Purtroppo la funzione "date-parse" non funziona in windows.

; (date-parse "2019-06-15 12:42:22" "%Y-%m-%d %H:%M:%S")
; (date-parse "2019-06-31" "%Y-%m-%d")
; (date-parse "2007.1.3" "%Y.%m.%d")

(date)

"Thu Jul 18 11:36:02 2019"

Trasformiamo la data dal formato ISO al formato RFC822:

(apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))
;-> 1129464732

(apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))
;-> 1560602542

(apply date-value (map int (parse "2007.1.3" { |\.} 0)))
;-> 1167782400

(date (apply date-value (map int (parse "2005-10-16 12:12:12" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sun, 16 Oct 2005 14:12 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2019-06-15 12:42:22" { |-|:} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Sat, 15 Jun 2019 14:42 W. Europe Daylight Time"

(date (apply date-value (map int (parse "2007.1.3" { |\.} 0)))  0 "%a, %d %b %Y %H:%M %Z")
;-> "Wed, 03 Jan 2007 01:00 W. Europe Standard Time"


-------------------------------------------------
Chiusura transitiva e raggiungibilità in un grafo
-------------------------------------------------

ralph.ronnquist:
----------------
Vediamo come definire una "chiusura transitiva". Data una lista di coppie che rappresenta i link di un grafo, determinare le liste di tutti i nodi connessi transitivamente (in altre parole, unire tutte le sotto-liste che hanno in comune qualche elemento (transitivamente)).

Esempio:

 19 ←→ 9 ←→ 4 ←→ 12    3 ←→ 15 ←→ 8    7 ←→ 5 ←→ 0 ←→ 11
            ↕
           13 ←→ 1

(setq grafo '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

Una soluzione ricorsiva potrebbe essere la seguente:

(define (trans s (x s) (f (and s (curry intersect (first s)))))
  (if s (trans (rest s) (cons (unique (flat (filter f x))) (clean f x))) x))

(trans grafo)
;-> ((7 5 0 11) (9 19 4 13 1 12) (15 8 3))

rickyboy:
---------
L'input s è una lista di insiemi in cui ogni membro è in relazione l'uno con l'altro. Ad esempio, se uno dei membri di s è (1 2 3) ciascuno di 1, 2 e 3 sono collegati a qualsiasi altro. In termini matematici, se l'input s descrive una relazione (simmetrica) R, allora risulta che 1R2, 2R1, 1R3, 3R1, 2R3 e 3R2 sono tutti veri.

Quindi, ad esempio, il primo membro dell'input di esempio (13 1) implica sia 13R1 che 1R13 (quando l'input di esempio descrive R). Questo perché, l'input di trans e il suo output sono simili, sono entrambi descrizioni di relazione - tranne che l'output è garantito per descriva una relazione di transitività.

Ora, guardando l'input invece come un insieme di link di un grafo, allora la funzione "trans" deve assumere che tutti i link che trova nell'input sono bidirezionali, cioè gli archi (collegamenti) del grafo non sono orientati.

La funzione "trans" unisce (cons) il membro che definisce le relazioni transitive parziali che contengono il link (first s) (per assorbimento/sussunzione) (cioè (unique (flat (filter f x)))), con il sottoinsieme dei membri che definiscono le relazioni transitive parziali in x che sono mutualmente esclusive al link (first s) (cioè clean f x)

Quando utilizziamo la funzione "trans" possiamo accoppiarla con la seguente funzione che crea un predicato per essa:

(define (make-symmetric-relation S)
  (letex ([S] S)
    (fn (x y)
      (exists (fn (s) (and (member x s) (member y s)))
              '[S]))))

Ecco un test che mostra la funzione in azione:

(define (test-trans input x y)
  (let (R     (make-symmetric-relation input)
        Rt    (make-symmetric-relation (trans input))
        yesno (fn (x) (if x 'yes 'no)))
    (list ;; is (x,y) in the original relation?
          (yesno (R x y))
          ;; is (x,y) in the transitive closure?
          (yesno (Rt x y)))))

Ad esempio,
(8 15) è nella relazione originale: quindi, sarà anche nella chiusura transitiva.
(9 13) non è nella relazione originale, ma è nella chiusura transitiva.
(9 15) non è in nessuna delle due.

(define input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(test-trans input 8 15)
;-> (yes yes)

(test-trans input 9 13)
;-> (no yes)

(test-trans input 9 15)
;-> (no no)

ralph.ronnquist:
----------------
Esatto, la funzione "trans" tratta la sua lista di input s come una raccolta di classi di equivalenza e combina quelle che si sovrappongono nelle più piccole collezioni di classi.

La funzione simile per le relazioni non riflessive (o per gli archi diretti) riguarderebbe piuttosto la "raggiungibilità transitiva", da un elemento a quelli che sono raggiungibili quando si segue l'articolata relazione (links) in un solo senso (in avanti).

Le seguenti due funzioni svolgono questi metodi: una che determina il raggiungimento individuale di un dato elemento, e una che determina il raggiungimento individuale di tutti gli elementi (mappa di raggiungibilità).

versione iniziale:
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (flat (map (curry reach (clean f s))
                           (map (curry nth 1) (filter f s)))))))

Nota: usare la versione iniziale della funzione "reach".

============================================================================
versione finale (rimuove gli elementi multipli con "unique"):
(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))
============================================================================

(define (reachability s)
  (map (fn (x) (reach s x)) (sort (unique (flat s)))))

 19 ← 9 → 4 → 12    3 → 15 → 8    7 → 5 ← 0 ← 11
          ↓
          13 → 1


(setq grafoD '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(reachability grafoD)
;-> ((0 5) (1) (3 15 8) (4 13 1 12) (5) (7 5) (8)
 ;-> (9 19 4 13 1 12) (11 0 5) (12) (13  1) (15 8) (19))

La "mappa di raggiungibilità" in ogni sottolista indica quali elementi sono raggiungibili dal primo elemento secondo la relazione orientata originale. Per creare la chiusura transitiva basta creare le coppie di associazione dalla mappa di raggiungibilità.

(define (transD s)
  (flat (map (fn (x) (if (1 x) (map (curry list (x 0)) (1 x)) '())) (reachability s)) 1))

(transD grafoD)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Il nuovo input (grafoD) crea nuove coppie: (3 8) (4 1) (9 13) (9 1) (9 12) (11 5)

Adesso, come andiamo nell'altra direzione? Ovvero, come si riduce al minor numero di coppie, o almeno si trova una sottolista in modo che le relazioni implicite vengano omesse dall'elenco?

rickyboy:
---------
Ecco la funzione "untransD" che rimuove le relazioni implicite. LAvora considerando ogni arco in s che può essere visto come coppia (src dst) (sebbene dst non è necessario). La funzione "clean" risponde alla domanda "Questo arco è implicato?", che sarà vero (true) quando la raggiungibilità di src, dopo che abbiamo rimosso l'arco da s, è la stessa della raggiungibilità di src sotto s.

(define (untransD s)
  (clean (fn (edge)
           (let (src (edge 0)
                 remove (fn () (apply replace (args))))
             (= (reach s src)
                (reach (remove edge s) src))))
         s))

Per quelli che non hanno familiarità con newLISP, notare la funzione di "remove" (definita nell'associazioni let). Sembra che stia facendo solo ciò che fa la funzione intrinseca "replace": allora, perché non dire semplicemente (replace edge s) invece di (remove edge s)?
La ragione di questo è sottile. La primitiva "replace" è distruttiva e non vogliamo che s cambi durante il runtime di untransD. Definire "remove" come abbiamo fatto qui lo trasforma in una funzione di rimozione non distruttiva (a causa del modello di chiamata di newLISP: la funzione riceve una copia e non il riferimento dell'oggetto).

Ma forse da un punto di vista dei contratti (di ingegneria del software), non dovremmo fare affidamento sull'ordine degli output delle chiamate raggiunte (cioè la sua stabilità).
Anche se possiamo vedere il codice di raggiungibilità, possiamo anche giocare "giocare sicuro" assumendo che non possiamo vedere l'implementazione e quindi sostituire l'uso di = con l'uso di un altro predicato di uguaglianza in cui l'ordine non ha importanza. Potrebbe esserci un modo migliore di quello proposto di seguito:

(define (set-equal? A B)
  (= (sort A) (sort B)))

Anche la primitiva "sort" è distruttiva. Tuttavia, non abbiamo bisogno di A e B (che sono copie anche loro) per qualsiasi altra cosa nell'ambito di questa funzione (dopo che abbiamo finito possiamo distruggerli). Fortunatamente, possiamo riutilizzare set-equal? nei nostri test.

Innanzitutto, ricordiamo cosa fa "transD" in esecuzione sui dati di esempio (input).

(setq input '((13 1) (9 19) (4 13) (4 12) (15 8) (3 15) (7 5) (9 4) (11 0) (0 5)))

(transD input)
;-> ((0 5) (3 15) (3 8) (4 13) (4 1) (4 12) (7 5) (9 19)
;->  (9 4) (9 13) (9 1) (9 12) (11 0) (11 5) (13 1) (15 8))

Adesso vediamo la funzione "untransD" in azione:

(untransD (transD input))
;-> ((0 5) (3 15) (4 13) (4 12) (7 5) (9 19) (9 4) (11 0) (13 1) (15 8))

L'output della funzione sembra uguale alla lista di ingresso.

Come facciamo a testare meglio queste funzioni? Sembra che dovremmo essere in grado di dire che transD e untransD sono una l'inversa dell'altra. Proviamo.

Innanzitutto, si noti che l'input di esempio stesso è privo di relazioni implicite.

(set-equal? input (untransD input))
;-> true

Questo significa che deve valere anche la seguente identità:

(set-equal? input (untransD (transD input)))
;-> nil

Esplorando tutto il codice, credo di aver trovato un bug.

La seguente identità dovrebbe essere vera: la raggiungibilità della chiusura transitiva dell'input è la stessa della raggiungibilità dell'input.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> nil

Cosa succede?

(reachability (transD input))
;-> ((0 5) (1) (3 15 8 8) (4 13 1 1 12) (5) (7 5)
;->  (8) (9 19 4 13 1 1 12 13 1 1 12) (11 0 5 5)
;->  (12) (13 1) (15 8) (19))

Ok, sembra che alcune raggiungibilità non abbiano elementi unici. Eccone una in particolare.

(reach (transD input) 9)
;-> (9 19 4 13 1 1 12 13 1 1 12)

Sembra che abbiamo bisogno della funzione "unique" nella funzione "reach".

(define (reach s n (f (fn (x) (= n (x 0)))))
  (cons n (if s (unique (flat (map (curry reach (clean f s))
                                   (map (curry nth 1) (filter f s))))))))

Bene, adesso funziona.

(reach (transD input) 9)
;-> (9 19 4 13 1 12)

E l'identità viene rispettata, come atteso.

(set-equal? (reachability input)
            (reachability (transD input)))

;-> true

Grazie a ralph.ronnquist e rickyboy.


-----------
Stalin Sort
-----------

Ecco un algoritmo di ordinamento O(n) (single pass) chiamato StalinSort. L'algoritmo scorre l'elenco degli elementi controllando se sono in ordine. Qualsiasi elemento fuori ordine viene eliminato. Alla fine si ottiene un elenco ordinato.

(define (stalinsort lst op)
  (local (out)
    (setq out '())
    (cond ((null? lst) '())
          (true
            (let (base (first lst))
              (push (first lst) out -1)
              (for (i 1 (- (length lst) 1))
                (if (op (lst i) base)
                ;(if (not (op (lst i) base))
                  (begin
                  (push (lst i) out -1)
                  (setq base (lst i)))
                )
              )
              out
            )
          )
    )
  )
)

(stalinsort '(1 3 4 2 3 6 8 5) <=)
;-> (1)
(stalinsort '(1 3 4 2 3 6 8 5) >=)
;-> (1 3 4 6 8)
(stalinsort '(11 8 4 2 3 6 8 5) <=)
;-> (11 8 4 2)
(stalinsort '(11 8 4 2 3 6 8 5) >=)
;-> (11)
(stalinsort '(11 4 8 2 3 6 8 12) <=)
;-> (11 4 2)
(stalinsort '(11 4 8 2 3 6 8 12) >=)
;-> (11 12)


--------------------
Sequenza triangolare
--------------------

Consideriamo il seguente triangolo di numeri interi:

1
1 2
1 2 3
1 2 3 4
1 2 3 4 5
...

Quando il triangolo è appiattito (flattened), produce la lista (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5 ...).
Il compito è scrivere un programma per generare la sequenza appiattita e per calcolare l'ennesimo elemento nella lista.

(define (triangle n idx)
  (local (out)
    (setq out '())
    (for (i 1 n)
      (push (sequence 1 i) out -1)
    )
    (setq out (flat out))
    (if idx (nth idx out) out)
  )
)

(triangle 3)
;-> (1 1 2 1 2 3)
(triangle 3 2)
;-> 2
(triangle 5)
;-> (1 1 2 1 2 3 1 2 3 4 1 2 3 4 5)
(triangle 5 10)
;-> 1


-------------------------
Vettore/lista di funzioni
-------------------------

Creiamo le funzioni:

(define (f0 x) (add x 1))
(define (f1 x) (mul x x))
(define (f2 x) (mul x x x))

Creiamo il vettore che contiene le funzioni:

(setq vet (array 3 (list f0 f1 f2)))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

Ogni elemento del vettore contiene una funzione:

(vet 0)
;-> (lambda (x) (add x 1))

Possiamo chiamare le funzioni nel modo seguente:

((vet 0) 2)
;-> 3

((vet 1) 2)
;-> 4

((vet 2) 2)
;-> 8

Utilizzando una lista otteniamo lo stesso risultato:

(setq lst (list f0 f1 f2))
;-> ((lambda (x) (add x 1)) (lambda (x) (mul x x)) (lambda (x) (mul x x x)))

(dolist (el lst) (println (el 2)))
;-> 3
;-> 4
;-> 8


------------------------------------
Numeri dispari differenza di quadrati
-------------------------------------

Ogni numero dispari può essere espresso come differenza di due quadrati.

Dimostrazione:

Prendiamo il numero 5 e rappresentiamolo con delle O:
OOOOO

Dividiamo il numero in due parti:
OOO
O
O

Riempiamo il quadrato:
OOO
OXX
OXX

Quadrato totale (9) - quadrato interno (4) = 5

Scriviamo una funzione che calcola questi numeri:

(define (breaknum n)
  (if (even? n) nil
    (list (* (- n (/ n 2)) (- n (/ n 2))) (* (/ n 2) (/ n 2)) )
  )
)

(breaknum 11)
;-> (36 25)

(breaknum 9527)
;-> (22695696 22686169)


----------
Zero? test
----------

In newLISP abbiamo due modi per verificare se un numero n vale 0:

(zero? n) e (= n 0)

Vediamo se hanno la stesssa velocità. Scriviamo due funzioni che hanno una sola differenza: il modo con cui confrontiamo un valore con il numero zero.

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (rand 2)) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (rand 2)) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5324.556

(time (map t2 (sequence 10 10000)))
;-> 5874.991

Il modo (zero? n) è più veloce.

Proviamo con un altro calcolo al posto di "rand":

(define (t1 num)
  (let (k 0)
    (dotimes (x num) (if (zero? (% num (+ x 1))) (++ k)))
    k))

(define (t2 num)
  (let (k 0)
    (dotimes (x num) (if (= 0 (% num (+ x 1))) (++ k)))
    k))

(time (map t1 (sequence 10 10000)))
;-> 5062.827

(time (map t2 (sequence 10 10000)))
;-> 5663.21

Quindi nei test numerici è meglio utilizzare la funzione "zero?"


-----------------------------------------------
Operazioni su elementi consecutivi di una lista
-----------------------------------------------

Supponiamo di voler calcolare la differenza tra gli elementi consecutivi della seguente lista: (7 11 13 17 19 23 29 31 37)

(setq a '(7 11 13 17 19 23 29 31 37))

(define (dist-lst lst) (map - (rest lst) (chop lst)))

(dist-lst a)
;-> (4 2 4 2 4 6 2 6)

(11 - 7 = 4) (13 - 11 = 2) (17 - 13 = 4)...(37 - 31 = 6)

Possiamo generalizzare la funzione per utilizzare anche altri operatori:

(define (calc-lst lst func ) (map func (rest lst) (chop lst)))

(calc-lst a +)
;-> (18 24 30 36 42 52 60 68)

(11 + 7 = 18) (13 + 11 = 24) (17 + 13 = 30)...(37 + 31 = 68)

Possiamo generalizzare ancora la funzione permettendo di stabilire l'ordine degli operandi. Quando il parametro rev vale true, allora viene effettuata l'operazione (el(n) func el(n+1)), altrimenti viene effettuata l'operazione (el(n+1) func el(n))

(define (calc-lst lst func rev)
  (if rev
      (map func (chop lst) (rest lst))
      (map func (rest lst) (chop lst))))

(calc-lst a -)
;-> (4 2 4 2 4 6 2 6)

(calc-lst a - true)
;-> (-4 -2 -4 -2 -4 -6 -2 -6)

(7 - 11 = -4) (11 - 13 = -2) (13 - 17 = -4)...(31 - 37 = -6)


---------------------------------------------------
Il loop implicito del linguaggio Scheme (named let)
---------------------------------------------------

La seguente funzione in linguggio Scheme converte un numero intero in una lista:

(define (number->list n)
  (let loop ((n n)
             (acc '()))
    (if (< n 10)
        (cons n acc)
        (loop (quotient n 10)
              (cons (remainder n 10) acc)))))

Viene definito un ciclo in cui la variabile n è uguale a n e la variabile acc è uguale all'elenco vuoto. Quindi se n è minore di 10, n viene inserito in acc. Altrimenti, "loop" viene applicato con n uguale a n/10 e acc uguale al cons del resto di n / 10 e della lista accumulata precedentemente, quindi chiama se stesso.
L'idea alla base di let è che permette di creare una funzione interna, che può chiamare se stessa e invocarla automaticamente. Possiamo utilizzare questa idea per scrivere in newLISP una funzione simile:

(define (number->list n)
  ; definiamo la funzione "loop" (può avere qualunque nome)
  (define (loop n acc)
    (if (< n 10)
        (cons n acc)
        (loop (/ n 10) (cons (% n 10) acc))
    )
  )
  ; chiamiamo la funzione "loop"
  (loop n '())
)

(number->list '1234)
;-> (1 2 3 4)

Viene chiamato "loop" perché la funzione chiama se stessa dalla posizione di coda. Questo è noto come ricorsione di coda (tail recursion). In Scheme, con la ricorsione di coda, la chiamata ricorsiva ritorna direttamente al chiamante, quindi non è necessario mantenere il frame di chiamata corrente. È possibile eseguire la ricorsione della coda tutte le volte che si desidera senza causare un overflow dello stack. In newLISP non esiste l'ottimizzazione della ricorsione di coda, quindi dobbiamo stare molto attenti a non causare un errore di stack overflow quando usiamo la tecnica della ricorsione.

Vediamo un altro esempio: il calcolo dell'insieme delle parti (powerset) di una lista.

Versione "named let" in Scheme:
(define (power-set-i lst)
  (let loop ((res '(())) (s lst))
    (if (empty? s)
        res
        (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s)))))

Versione "newLISP":
(define (powerset-i lst)
  (define (loop res s)
    (if (empty? s)
      res
      (loop (append (map (lambda (i) (cons (first s) i)) res) res) (rest s))))
  (loop '(()) lst))

(powerset-i '(1 2 3))
;-> ((3 2 1) (3 2) (3 1) (3) (2 1) (2) (1) ())


------------------------------
Brainfuck string encode/decode
------------------------------

Brainfuck è un linguaggio di programmazione esoterico, creato da Urban Müller nel 1993.

Scrivere due funzioni che effettuano le seguenti operazioni:

1) Input -> Stringa, Output -> Programma Brainfuck per stampare la stringa

2) Input -> Programma Brainfuck per stampare la stringa, Output -> stringa

Questa funzione prende una stringa e restituisce un programma (stringa) in linguaggio Brainfuck che stampa la stringa:

(define (gen-bf str)
  (let (o "")
    (dolist (el (explode str))
      (setq o (join (list o (dup "+" (char el)) ".[-]")))
    )
    ;(silent (println o))
  )
)

(gen-bf "ciao")
;-> "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]"

(gen-bf "newLISP")
;-> "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]"

Questa funzione prende un programma (stringa) in linguaggio Brainfuck che stampa la stringa e restituisce la stringa da stampare:

(define (bf str)
  (local (cc)
    (setq cc 0)
    (dolist (el (explode str))
      ; conta i caratteri "+"
      (if (= el "+")
          (++ cc)
          ; e quando finiscono i "+", stampa il carattere relativo al numero dei "+"
          (if (!= cc 0) (begin (print (char cc)) (setq cc 0)))
      )
    )
    (silent (print (format "\n%s " "stop.")))
  )
)

(bf "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]")
;-> ciao
;-> stop.

(bf
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++.[-]")
;-> newLISP
;-> stop.

(bf (gen-bf "Controllo funzioni"))
;-> Controllo funzioni
;-> stop.


------------------------------------
Creare una utilità di sistema (.exe)
------------------------------------

Il codice sorgente e l'eseguibile newLISP.exe possono essere uniti tra loro per creare un'applicazione autonoma utilizzando il flag della riga di comando -x.

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende la prima parola dalla riga di comando e la converte in maiuscolo.

Per compilare questo programma come eseguibile autonomo, eseguire dal terminale la seguente procedura:

Su OSX, Linux e altri UNIX

newlisp -x uppercase.lsp uppercase

chmod 755 uppercase # give executable permission

Su Windows il file di destinazione richiede l'estensione .exe

newlisp -x uppercase.lsp uppercase.exe

newLISP troverà l'eseguibile "newLISP.exe" nel percorso di esecuzione dell'ambiente (PATH) e lo unirà ad una copia del codice sorgente "uppercase.lsp" per creare il programma "uppercase.exe".

Per eseguire il programma eseguire dal terminale il comando:

Su Linux e altri UNIX, se la cartella (directory) corrente si trova nel percorso eseguibile:

uppercase "convert me to uppercase"

Su Linux e altri UNIX, se la directory corrente non si trova nel percorso eseguibile:

./uppercase "convert me to uppercase"

Su windows:

uppercase "convert me to uppercase"

La console dovrebbe stampare:

;-> CONVERT ME TO UPPERCASE

Si noti che nessuno dei file di inizializzazione init.lsp né .init.lsp viene caricato durante l'avvio dei programmi creati in questo modo.

Vediamo come gestire i parametri passati alla linea di comando utilizzando la funzione "main-args".

**********************
>>>funzione MAIN-ARGS
**********************
sintassi: (main-args int-index)

main-args restituisce una lista con diversi elementi di tipo stringa, uno per l'invocazione del programma e uno per ciascuno degli argomenti della riga di comando.

newlisp 1 2 3

> (main-args)
("/usr/local/bin/newlisp" "1" "2" "3")

Dopo che newlisp 1 2 3 viene eseguito al prompt dei comandi, main-args restituisce una lista contenente il nome del programma chiamante e i tre argomenti della riga di comando.

Facoltativamente, main-args può prendere un int-index per l'indicizzazione della lista. Si noti che un indice fuori intervallo causerà la restituzione di zero, non l'ultimo elemento dell'elenco come nell'indicizzazione delle liste.

newlisp a b c

(main-args 0)
;-> "/usr/local/bin/newlisp"
(main-args -1)
;-> "c"
(main-args 2)
;-> "b"
(main-args 10)
;-> nil

Nota che quando newLISP viene eseguito da uno script, main-args restituisce anche il nome dello script come secondo argomento:

#!/usr/local/bin/newlisp
#
# script to show the effect of 'main-args' in script file

(print (main-args) "\n")
(exit)

# end of script file

;; execute script in the OS shell:

script 1 2 3

;-> ("/usr/local/bin/newlisp" "./script" "1" "2" "3")

Prova a eseguire questo script con diversi parametri della riga di comando.


----------------------------
Fattoriale, Fibonacci, Primi
----------------------------

(setq MAXINT 9223372036854775807)

Funzione di fattorizzazione:

(define (factorbig n)
  (local (f k i dist out)
    ; Distanze tra due elementi consecutivi della ruota (wheel)
    (setq dist (array 48 '(2 4 2 4 6 2 6 4 2 4 6 6 2 6 4 2 6 4
                           6 8 4 2 4 2 4 8 6 4 6 2 4 6 2 6 6 4
                           2 4 6 2 6 4 2 4 2 10 2 10)))
    (setq out '())
    (while (zero? (% n 2)) (push '2L out -1) (setq n (/ n 2)))
    (while (zero? (% n 3)) (push '3L out -1) (setq n (/ n 3)))
    (while (zero? (% n 5)) (push '5L out -1) (setq n (/ n 5)))
    (while (zero? (% n 7)) (push '7L out -1) (setq n (/ n 7)))
    (setq k 11L i 0)
    (while (<= (* k k) n)
      (if (zero? (% n k))
        (begin
        (push k out -1)
        (setq n (/ n k)))
        (begin
        ;(++ k (dist i))
        (setq k (+ k (dist i)))
        (if (< i 47) (++ i) (setq i 0)))
      )
    )
    (if (> n 1) (push (bigint n) out -1))
    out
  )
)

Funzione fattoriale:

(define (fact n) (if (= n 0) 1 (apply * (map bigint (sequence 1 n)))))

Definiamo una funzione che stampa il fattoriale e la sua scomposizione in fattori fino a n:

(define (test n)
  (local (f fp)
    (for (i 2 n)
      (setq f (fact i))
      (setq fp (factorbig f))
      (println i { } f)
      (println fp)
    )
  )
)

(test 14)
2 2L
(2L)
3 6L
(2L 3L)
4 24L
(2L 2L 2L 3L)
5 120L
(2L 2L 2L 3L 5L)
6 720L
(2L 2L 2L 2L 3L 3L 5L)
7 5040L
(2L 2L 2L 2L 3L 3L 5L 7L)
8 40320L
(2L 2L 2L 2L 2L 2L 2L 3L 3L 5L 7L)
9 362880L
(2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 7L)
10 3628800L
(2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 5L 7L)
11 39916800L
(2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 5L 5L 7L 11L)
12 479001600L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 11L)
13 6227020800L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 11L 13L)
14 87178291200L
(2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 3L 3L 3L 3L 3L 5L 5L 7L 7L 11L 13L)

(pretty-print)
;-> (80 " " "%1.16g")

(pretty-print 70 " " "%1.16g")

(factorbig (fact 100))
;-> (2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L 2L
;->  2L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L
;->  3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L 3L
;->  3L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L 5L
;->  5L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 7L 11L 11L 11L 11L 11L
;->  11L 11L 11L 11L 13L 13L 13L 13L 13L 13L 13L 17L 17L 17L 17L 17L 19L 19L
;->  19L 19L 19L 23L 23L 23L 23L 29L 29L 29L 31L 31L 31L 37L 37L 41L 41L 43L
;->  43L 47L 47L 53L 59L 61L 67L 71L 73L 79L 83L 89L 97L)

Definiamo una funzione per calcolare i numeri di Fibonacci:

(define (fibo-i n)
  (local (a b c)
    (setq a 0L b 1L c 0L)
    (for (i 0 (- n 1))
      (setq c (+ a b))
      (setq a b)
      (setq b c)
    )
    a
  )
)

(fibo-i 3)
;-> 55L

Definiamo una funzione per verificare se un numero è primo:

(define (isprime? n)
  (if (< n 2) nil
    (= 1 (length (factorbig n)))))

(isprime? (fibo-i 20))
;-> nil

Definiamo una funzione che stampa il numero di Fibonacci e la sua scomposizione in fattori fino a n:

(define (test1 n)
  (local (f fp)
    (for (i 2 n)
      (setq f (fibo-i i))
      (setq fp (factorbig f))
      (println i { } f)
      (println fp)
    )
  )
)

(test1 100)
;-> 2 1L
;-> ()
;-> 3 2L
;-> (2L)
;-> 4 3L
;-> (3L)
;-> 5 5L
;-> (5L)
;-> 6 8L
;-> (2L 2L 2L)
;-> 7 13L
;-> (13L)
;-> 8 21L
;-> (3L 7L)
;-> 9 34L
;-> (2L 17L)
;-> 10 55L
;-> (5L 11L)
;-> 11 89L
;-> (89L)
;-> 12 144L
;-> (2L 2L 2L 2L 3L 3L)
;-> 13 233L
;-> (233L)
;-> ...
;-> 83 99194853094755497L
;-> (99194853094755497L)
;-> 84 160500643816367088L
;-> (2L 2L 2L 2L 3L 3L 13L 29L 83L 211L 281L 421L 1427L)
;-> 85 259695496911122585L
;-> (5L 1597L 9521L 3415914041L)
;-> 86 420196140727489673L
;-> (6709L 144481L 433494437L)
;-> 87 679891637638612258L
;-> (2L 173L 514229L 3821263937L)
;-> 88 1100087778366101931L
;-> (3L 7L 43L 89L 199L 263L 307L 881L 967L)
;-> 89 1779979416004714189L
;-> (1069L 1665088321800481L)
;-> 90 2880067194370816120L
;-> (2L 2L 2L 5L 11L 17L 19L 31L 61L 181L 541L 109441L)
;-> 91 4660046610375530309L
;-> (13L 13L 233L 741469L 159607993L)
;-> 92 7540113804746346429L
;-> (3L 139L 461L 4969L 28657L 275449L)
;-> 93 12200160415121876738L
;-> (2L 557L 2417L 4531100550901L)
;-> 94 19740274219868223167L
;-> (2971215073L 6643838879L)
;-> 95 31940434634990099905L
;-> (5L 37L 113L 761L 29641L 67735001L)
;-> 96 51680708854858323072L
;-> (2L 2L 2L 2L 2L 2L 2L 3L 3L 7L 23L 47L 769L 1103L 2207L 3167L)
;-> 97 83621143489848422977L
;-> (193L 389L 3084989L 361040209L)
;-> 98 135301852344706746049L
;-> (13L 29L 97L 6168709L 599786069L)
;-> 99 218922995834555169026L
;-> (2L 17L 89L 197L 19801L 18546805133L)
;-> 100 354224848179261915075L
;-> (3L 5L 5L 11L 41L 101L 151L 401L 3001L 570601L)
;-> (3L 5L 5L 11L 41L 101L 151L 401L 3001L 570601L)

Adesso cerchiamo i numeri di Fibonacci che sono anche primi fino a n.

(define (primi-fib n)
  (for (i 2 n)
    (if (= 1 (length (factorbig (fibo-i i))))
      (println i { } (fibo-i i))
    )
  )
)

(primi-fib 50)
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L

(time (primi-fib 100))
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L
;-> 83 99194853094755497L
;-> 514886.082 ; 8 minuti e 34 secondi

Definiamo una funzione che converte i millisecondi in minuti e secondi:

(define (ms2min ms)
  (let ((mins (/ ms 1000 60))
       (secs (% (/ ms 1000) 60)))
       (println (format "%d millisec = %d minuti e %d secondi." ms mins secs))
       (list mins secs)
  )
)

(ms2min 514886.082)
;-> 514886 millisec = 8 minuti e 34 secondi.

Sequenza OEIS dei numeri di Fibonacci primi:

2, 3, 5, 13, 89, 233, 1597, 28657, 514229, 433494437, 2971215073,
99194853094755497, 1066340417491710595814572169,
19134702400093278081449423917,

Nota: MAXINT = 9223372036854775807 e MININT = -9223372036854775808

Usiamo la funzione "factor" al posto di "factorbig", ma possiamo arrivare solo fino a n = 92:

(- (fibo-i 92) 9223372036854775807)
;-> -1683258232108429378L

(- (fibo-i 93) 9223372036854775807)
;-> 2976788378267100931L

(define (primi-fib2 n)
  (for (i 2 n)
    (if (= 1 (length (factor (fibo-i i))))
      (println i { } (fibo-i i))
    )
  )
)

(time (primi-fib2 92))
;-> 3 2L
;-> 4 3L
;-> 5 5L
;-> 7 13L
;-> 11 89L
;-> 13 233L
;-> 17 1597L
;-> 23 28657L
;-> 29 514229L
;-> 43 433494437L
;-> 47 2971215073L
;-> 83 99194853094755497L
;-> 1718.801

Il prossimo numero di Fibonacci primo vale:

(fibo-i 131)
;-> 1066340417491710595814572169L)

Vediamo quanto tempo impiega la funzione "factorbig" per verificarlo:

(time (println (factorbig 1066340417491710595814572169L)))

Tanto tanto tempo...


-----
Quine
-----

Un Quine è un programma autoreferenziale che stampa, senza alcun input, il proprio sorgente.
Il nome "quine" fu coniato da Douglas Hofstadter, nel suo famoso libro di scienze "Gödel, Escher, Bach: Un Eterna Ghirlanda Brillante", in onore del filosofo Willard Van Orman Quine (1908–2000), che i coniò l'espressione paradossale "Yields falsehood when appended to its own quotation", yields falsehood when appended to its own quotation, ovvero "Produce una falsità se preceduto dalla propria citazione" produce una falsità se preceduto dalla propria citazione.

Uno degli esempi più famosi (scritto da Chris Hruska) è il seguente:

((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))
;-> ((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))

Infatti valutando l'espressione nella REPL si ottiene come output l'espressione stessa.

Anche il creatore di LISP ha creato un quine (John McCarthy e Carolyn Talcott):

((lambda (x)
   (list x (list (quote quote) x)))
  (quote
     (lambda (x)
       (list x (list (quote quote) x)))))
;-> ((lambda (x) (list x (list (quote quote) x))) (quote (lambda (x)
;->        (list x (list (quote quote) x)))))

Continuiamo con un altro esempio:

((lambda (x) (list x x)) (lambda (x) (list x x)))
;-> ((lambda (x) (list x x)) (lambda (x) (list x x)))

In newLISP, Lutz Mueller (il creatore del linguaggio) ha creato il più corto programma quine:

(lambda (x))
;-> (lambda (x))

Perché in newLISP le espressioni lambda valutano/ritornano a se stesse.

Anche il seguente potrebbe essere un quine (se fossero ammissibili i programmi errati):

ERR: context expected : ERR:
;-> ERR: context expected : ERR:

Invece il seguente è sicuramente un quine:

(lambda (s) (print (list s (list 'quote s))))
;-> (lambda (s) (print (list s (list 'quote s))))


-----------------------------
I buchi delle cifre numeriche
-----------------------------

Quale numero viene dopo la sequenza: 1, 4, 8, 48, 88, 488, ...

Notiamo che 1 non a buchi, 4 ha un buco, 8 ha due buchi, 48 ha tre buchi, 88 ha quattro buchi, 488 ha cinque buchi, quindi il prossimo numero è 888 perchè è il più piccolo numero che ha sei buchi.

Quindi il problema è quello di trovare il numero intero più piccolo con n buchi nelle sue cifre decimali.

Definiamo una lista associativa in cui ci sono due valori (x y), dove x è la cifra numerica e y è il numero di buchi della cifra:

(setq buchi '((0 1) (1 0) (2 0) (3 0) (4 1) (5 0) (6 1) (7 0) (8 2) (9 1)))
(lookup 1 buchi)
;-> 0
(lookup 8 buchi)
;-> 2

La seguente espressione converte un numero in una lista di cifre:

(map int (explode (string 1234)))
;-> (1 2 3 4)

Adesso scriviamo la funzione:

(define (holesequence num)
  (local (val out)
    (setq val 0 out '())
    (dotimes (n num)
      ;somma dei buchi di tutte le cifre che compongono il numero n
      (if (= val (apply +
            (map (fn (x) (lookup x buchi)) (map int (explode (string n))))))
          (begin (push (list val n) out -1) (++ val)))
    )
    out
  )
)

(holesequence 100000)
;-> ((0 1) (1 4) (2 8) (3 48) (4 88) (5 488)
;->  (6 888) (7 4888) (8 8888) (9 48888))

1  ha 0 (zero) buchi
4  ha 1 (uno) buco
8  ha 2 (due) buchi
48 ha 3 (tre) buchi
88 ha 4 (quattro) buchi
...


-------------------
Ordinare tre numeri
-------------------

Esercizio preso dal libro di Bjarne Stroustrup "Principles and Practice Using C++".

Scrivere una funzione che prende 3 valori interi e li stampa in ordine crescente.

Esempio:
input = 10 4 6
output = 4 6 10

È possibile utilizzare solo le seguenti istruzioni:

1) if
2) cond
3) setq
4) println
5) local
6) let
7) and
8) or

(define (ordina x y z)
  (local (a b c)
    (setq a 0 b 0 c 0) ; al termine: a <= b <= c
    (cond ((and (<= x y) (<= x z)) ; x è minore di y e di z
           (setq a x) ; x è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= y z) (setq b y c z) (setq c y b z)))
          ((and (<= y x) (<= y z)) ; y è minore di x e di z
           (setq a y) ; y è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= x z) (setq b x c z) (setq c x b z)))
          (true                    ; z è minore di x e di y
           (setq a z) ; z è il più piccolo
           ; quale dei due numeri rimanenti è minore?
           (if (<= x y) (setq b x c y) (setq c x b y)))
    )
    (println a { } b { } c)
  )
)

(ordina 10 4 6)
;-> 4 6 10

(ordina 4 6 10)
;-> 4 6 10

(ordina 10 6 4)
;-> 4 6 10


----------------
Conteggio strano
----------------

Una bambina conta sulle dita di una mano partendo da 1 sul pollice, 2 sul dito indice, 3 sul medio, 4 sul dito anulare e 5 sul mignolo. Quindi torna indietro nella stessa mano, contando 6 sul'anulare, 7 sul medio, 8 sull'indice e 9 sul pollice. Poi continua indefinitamente contando sempre nello stesso modo. Scrivere un programma che, dato un numero intero n, determina su quale dito terminerà quando il  conteggio raggiunge n.

Il conteggio procede nel modo seguente:

 a   b   c   d   e
POL IND MED ANU MIG
 1   2   3   4   5
 9   8   7   6
    10  11  12  13
17  16  15  14
    18  19  20  21
25  24  23  22
    26  27  28  29
33  32  31  30
    34  35  36  37

Il pattern è il seguente:

  1       5   6     9      13  14      18    21  22    25      29
("a b c d e" "d c b a b c d e" "d c b a b c d e" "d c b a b c d e")
              1 2 3 4 5 6 7 8   9    12      16  17    20  22  24

A parte i primi cinque numeri, troviamo sempre una sequenza ripetuta: "d c b a b c d e".

Quindi risulta che ((n-5) mod 8) indica la posizione (indice) nella sequenza ripetuta:

resto:     1 2 3 4 5 6 7 0
sequenza: "d c b a b c d e"

Possiamo scrivere la funzione:

(define (mano n)
  (cond ((<= n 5)
         (cond ((= n 1) 'pollice)
               ((= n 2) 'indice)
               ((= n 3) 'medio)
               ((= n 4) 'anulare)
               ((= n 5) 'mignolo)))
        ((= 1 (% (- n 5) 8)) 'anulare)
        ((= 2 (% (- n 5) 8)) 'medio)
        ((= 3 (% (- n 5) 8)) 'indice)
        ((= 4 (% (- n 5) 8)) 'pollice)
        ((= 5 (% (- n 5) 8)) 'indice)
        ((= 6 (% (- n 5) 8)) 'medio)
        ((= 7 (% (- n 5) 8)) 'anulare)
        (true 'mignolo)
  )
)

(mano 36)
;-> anulare

(mano 8)
;-> indice

(mano 1000)
;-> indice

Possiamo scrivere la funzione in maniera concisa:

(define (hand n)
  (let ((fingers1 '(pollice indice medio anulare mignolo))
        (fingers2 '(mignolo anulare medio indice pollice indice medio anulare)))
       (if (<= n 5)
           (fingers1 (- n 1))
           (fingers2 (% (- n 5) 8))
       )
  )
)

(hand 36)
;-> anulare

(hand 8)
;-> indice

(hand 1000)
;-> indice

(hand 5)
;-> mignolo


------------------------
Funzioni automodificanti
------------------------

In newLISP le funzioni sono oggetti di prima classe, cioè possono essere passate e restituite da altre funzioni. Inoltre le funzioni possono modificare il codice di altre funzioni durante l'elaborazione (runtime).
Quindi una funzione può modificare e restituire se stessa. Per esempio:

(define (f lst)
  (println (first f))
  (println f)
  (setf (first f) '(lista))
  (println (first f))
  f)

(f '(1 2 3))
;-> (lst)
;-> (lambda (lst) (println (first f)) (println f) (setf (first f) 'lista) (println (first f)) f)
;-> lista
;-> (lambda (lista) (println (first f)) (println f) (setf (first f) 'lista) (println (first f)) f)

In questo caso abbiamo modificato il nome dell'argomento della funzione (da "lst" a "lista"), quindi il comportamento della nuova funzione è uguale al precedente.

Gli elementi che compongono la funzione (argomenti e corpo) vengono identificati con le normali funzioni per il trattamento delle liste:

(define (fun a b) (+ a b))
;-> (lambda (a b) (+ a b))

Gli argomenti della funzione sono il primo elemento della lista/funzione:

(setq arg (first fun))
;-> (a b)

Il corpo della funzione sono tutti i rimanenti elementi della lista/funzione:

lista di tutte le espressioni:
(setq corpo (rest fun))
;-> ((+ a b))

ultima espressione:
(setq corpo (last fun))
;-> (+ a b)

Possiamo modificare questi elementi (arg e corpo) direttamente nella lista/funzione oppure possiamo creare una nuova funzione e poi assegnarla alla funzione desiderata. Per identificare le varie parti della lista/funzione utilizziamo la funzione "nth" (non possiamo utilizzare l'indicizzazione implicita e l'uso di "first" e "rest" è abbastanza scomodo).

(nth 0 fun)
;-> (a b)

(nth 1 fun)
;-> (+ a b)

(nth '(1 0) fun)
;-> +

Adesso supponiamo di voler modificare la funzione fun in modo che faccia la sottrazione degli argomenti (invece che la somma).

Nel caso della modifica diretta della funzione possiamo scrivere:

(setf (nth '(1 0) fun) '-)
;-> -

Abbiamo modificato la funzione "fun":

fun
;-> (lambda (a b) (- a b))

Infatti adesso effettua la sottrazione degli argomenti:

(fun 1 2)
;-> -1

Nel caso in cui creiamo una nuova funzione possiamo scrivere:

(setq fun '(lambda (a b) (+ a b)))
;-> (lambda (a b) (+ a b))

(fun 1 2)
;-> 3

Oppure:

(setq f-aux (append '(lambda (a b)) '((- a b))))
;-> (lambda (a b) (- a b))

(f-aux 1 2)
;-> -1

Oppure:

(setq f-aux (append '(lambda) (list (nth 0 fun) '(- a b))))
;-> (lambda (a b) (- a b))

(setq fun f-aux)
;-> (lambda (a b) (- a b))

(fun 1 2)
;-> -1

Proviamo a scrivere una funzione automodificante ad ogni chiamata alterna l'addizione e la sottrazione dei suoi argomenti:

(define (boh a b)
  ; AUTOMODIFICA
  ; modifichiamo la funzione alternando gli operatori + e -
  ; (+ a b) --> (- a b)
  ; (- a b) --> (+ a b)
  (if (= (nth '(2 0) boh) '+) (setf (nth '(2 0) boh) '-) (setf (nth '(2 0) boh) '+))
  ; calcolo dell'operazione
  (+ a b)
)

(nth '(2 0) boh)
;-> +

(boh 2 3)
;-> -1

(boh 2 3)
;-> 5

(boh 2 3)
;-> -1

Ad ogni chiamata la funzione alterna tra addizione e sottrazione degli argomenti.

Vediamo una funzione leggermente più complessa:

(define (massimo a b)
  (local (out)
    (if (< a b)
        (setq out b)
        (setq out a))
    (println "il massimo vale: " out)
    out
  )
)

(massimo 2 4)
;-> il massimo vale: 4
;-> 4

massimo
;-> (lambda (a b)
;->  (local (out)
;->   (if (< a b)
;->    (setq out b)
;->    (setq out a))
;->   (println "il massimo vale: " out) out))

(nth 0 massimo)
;-> (a b)

(nth 1 massimo)
;-> (local (out)
;->  (if (< a b)
;->   (setq out b)
;->   (setq out a))
;->  (println "il massimo vale: " out) out)

(length (nth 1 massimo))
;-> 5

(nth '(1 0) massimo)
;-> local

(nth '(1 1) massimo)
;-> (out)

(nth '(1 2) massimo)
;-> (if (< a b) (setq out b) (setq out a))

(nth '(1 3) massimo)
;-> (println "il massimo vale: " out)

(nth '(1 4) massimo)
;-> out

Per modificare le funzioni è fondamentale identificare con "nth" l'esatta posizione della espressione da trattare.

Vediamo un altro esempio:

(define (prova a b)
  (setq x (+ a b))
  (setq y (- a b))
  (* x y))

(nth 0 prova)
;-> (a b)
(length (nth 0 prova))
;-> 2

(nth 1 prova)
;-> (setq x (+ a b))
(length (nth 1 prova))
;-> 3

(nth 2 prova)
;-> (setq y (- a b))
(length (nth 2 prova))
;-> 3

(nth 3 prova)
;-> (* x y)
(length (nth 3 prova))
;-> 3

L'oggetto "lambda" in newLISP non è una parola chiave come una funzione o un operatore incorporato, ma un attributo speciale di una lista: un lista lambda, che si presenta in questo modo:

(lambda)
;-> (lambda )

Come si vede, una lista lambda valuta su se stessa in newLISP e non è necessario quotarla quando la si utilizza come parametro per un'altra funzione.

Quando si costruiscono liste lambda con "append" o "cons", allora "append" associa la proprietà lambda a destra e "cons" a sinistra:

(append (lambda) '((x) (+ x x)))
;-> (lambda (x) (+ x x))

(cons '(x) (lambda (+ x x)))
;-> (lambda (x) (+ x x))

L'esempio "cons" mostra che lambda non è il primo elemento di una lista, ma piuttosto una proprietà di quella lista. Infatti risulta:

(empty? (lambda))
;-> true

(lambda? (lambda))
;-> true


Il metodo di generare funzioni tramite codice viene utilizzato anche per lo sviluppo di "malware", poichè queste funzioni sono "invisibili" ai programmi anti-virus basati su pattern.

Nota: la scrittura di funzioni (auto) modificanti rende il programma difficile da interpretare e da analizzare con il debugger.

Vediamo un altro esempio, una funzione che si comporta come un generatore automodificandosi.

(define (sum (x 0)) (my-inc 0 x))
(define (selfmod x) (setf (last selfmod) (+ (last selfmod) 1)) 0)
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 0)

Vediamo come funziona:

(selfmod)
;-> 1

Adesso rivediamo la definizione della funzione:

selfmod
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 1)
La funzione ha modificato il suo ultimo parametro (dal valore 0 al valore 1).

(selfmod)
;-> 2
selfmod
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 2)

(selfmod)
;-> 3
selfmod
;-> (lambda (x) (setf (last selfmod) (+ (last selfmod) 1)) 3)

Un altro modo di creare un generatore:

(define (selfinc x) (myinc x) 0)
;-> (lambda (x) (myinc x) 0)

(define (myinc x) (inc (last selfinc) x))
;-> (lambda (x) (inc (last selfinc) x))

(selfinc 1)
;-> 1
(selfinc 2)
;-> 3
(selfinc 3)
;-> 6
selfinc
;-> (lambda (x) (myinc x) 6)

Nota: Una funzione definita dall'utente non ha modo di fare riferimento alla funzione da cui è stata invocata, tranne quando ha una sua precedente conoscenza. Quando abbiamo questa necessità, in cui una funzione deve conoscere il nome della chiamante, basta renderla un parametro della chiamata di funzione.


---------------
I cicli (loops)
---------------

In newLISP sono supportati la maggior parte dei metodi di loop tradizionali. Ogni volta che esiste una variabile di loop, è locale nell'ambito del loop, comportandosi secondo le regole di scoping dinamico all'interno dello spazio dei nomi o del contesto corrente:

*** DOTIMES ***
; ripete per un numero di volte
; "i" va da 0 a N - 1
(dotimes (i N)
    ...
)

; dimostra la località di "i"
(dotimes (i 3)
    (print i ":")
    (dotimes (i 3) (print i))
    (println)
)
;-> 0:012
;-> 1:012
;-> 2:012

*** DOLIST ***
; ciclo attraverso una lista
; la variabile "e" prende il valore di ciascun elemento della lista aList
(dolist (e aList)
    ...
)

La funzione "dolist" ha anche una variabile $idx che tiene traccia dell'indice numerico dell'elemento corrente (partendo da 0):

(dolist (e '(a b c d)) (println (list $idx e)))
;-> (0 a)
;-> (1 b)
;-> (2 c)
;-> (3 d)

*** DOSTRING ***
; ciclo attraverso una stringa
; "e" prende il valore numerico ASCII o UTF-8 di ogni carattere della stringa aString
(dostring (e aString)
    ...
)

Per attraversare una stringa possiamo usare anche "dolist" insieme ad "explode".

; ciclo attraverso una stringa
; "e" prende il valore del carattere ASCII o UTF-8 di ogni carattere della stringa aString
(dolist (e (explode aString))
    ...
)

*** DOTREE ***
; ciclo attraverso i simboli di un contesto
; ordinati in ordine alfabetico
(dotree (s CTX)
    ...
)

*** FOR ***
; ciclo che parte da un valore "init",
; termina quando "i" diventa uguale a "N",
; con passo opzionale "step".
; Il segno del passo è irrilevante (dipende solo da N e init)
(for (i init N step)
    ...
)

(for (i 1 9) (print i))
;-> 123456789

(for (i 1 9 2) (print i))
;-> 13579

(for (i 9 1 -2) (print i))
;-> 97531

(for (i 9 1 2) (print i))
;-> 97531

*** WHILE ***
; ciclo finchè una condizione è vera;
; prima controlla la condition, poi esegue il corpo
(while condition
    ...
)

*** UNTIL ***
; ciclo finchè una condizione è falsa;
; prima controlla la condition, poi esegue il corpo
(until condition
    ...
)

*** DO-WHILE ***
; ciclo finchè una condizione è vera;
; prima esegue il corpo poi controlla la condition.
; Il corpo viene eseguito almeno una volta.
(do-while condition
    ...
)

*** DO-UNTIL ***
; ciclo finchè una condizione è falsa;
; prima esegue il corpo poi controlla la condition.
; Il corpo viene eseguito almeno una volta.
(do-until condition
    ...
)

Le funzioni di loop "dolist", "dotimes" e "for" possono anche prendere una condizione di interruzione (break) come argomento aggiuntivo. Quando la condizione di interruzione restituisce true, il ciclo termina:

(dolist (x '(a b c d e f g) (= x 'e))
    (print x))
;->  abcd


---------------------
L'alfabeto web "Leet"
---------------------

L'alfabeto Leet ("Leet") è un altro alfabeto per il linguaggio inglese usato principalmente su internet e sulla messaggistica.
Alcune lettere vengono sosituite con delle cifre. In genre si ha la seguente corrispondenza:

0 = O
1 = I
2 = Z
3 = E
4 = A
5 = S
6 = G
7 = T
8 = B
9 = J

Possiamo scrivere una funzione che converte una stringa in linguaggio Leet.

(setq leet '((O 0) (I 1) (Z 2) (E 3) (A 4) (S 5) (G 6) (T 7) (B 8) (9 J)))

(define (toLeet str)
  (local (out)
    (setq out (explode (upper-case str)))
    (set-ref-all "O" out "0")
    (set-ref-all "I" out "1")
    (set-ref-all "Z" out "2")
    (set-ref-all "E" out "3")
    (set-ref-all "A" out "4")
    (set-ref-all "S" out "5")
    (set-ref-all "G" out "6")
    (set-ref-all "T" out "7")
    (set-ref-all "B" out "8")
    (set-ref-all "J" out "9")
    (join out)
  )
)

(toLeet "Questa frase convertita in Leet")
;-> "QU3574 FR453 C0NV3R7174 1N L337"

Nota che set-ref-all restituisce la stringa modificata oppure nil se non trova una corrispondenza (e quindi non avviene alcuna modifica).

(set-ref-all "C" '("C" "V" "B" "C") "Z")
;-> ("Z" "V" "B" "Z")

(set-ref-all "A" '("C" "V" "B" "C") "Z")
;-> nil

Possiamo scrivere la funzione anche in un altro modo:

(define (toLeet str)
  (local (out)
    (setq out (explode (upper-case str)))
    (dolist (el out)
      (cond ((= el "O") (setq (out $idx) "0"))
            ((= el "I") (setq (out $idx) "1"))
            ((= el "Z") (setq (out $idx) "2"))
            ((= el "E") (setq (out $idx) "3"))
            ((= el "A") (setq (out $idx) "4"))
            ((= el "S") (setq (out $idx) "5"))
            ((= el "G") (setq (out $idx) "6"))
            ((= el "T") (setq (out $idx) "7"))
            ((= el "B") (setq (out $idx) "8"))
            ((= el "J") (setq (out $idx) "9"))
      )
    )
    (join out)
  )
)

(toLeet "Questa frase convertita in Leet")
;-> "QU3574 FR453 C0NV3R7174 1N L337"


----------
Autogrammi
----------

Un autogramma (in greco: αὐτός = sé, γράμμα = lettera) è una frase autodescrittiva nel senso che fornisce la lista dei suoi caratteri. Sono stati inventati da Lee Sallows, che ha anche coniato la parola autogramma. Una caratteristica essenziale è l'uso dei nomi completi dei numeri cardinali come "uno", "due", ecc., nella registrazione dei conteggi dei caratteri. Gli autogrammi sono anche chiamati frasi "auto-enumeranti" o "auto-documentanti". In genere, viene registrato solo il conteggio delle lettere, mentre i segni di punteggiatura vengono ignorati, come in questo esempio (in inglese):

This sentence employs two a's, two c's, two d's, twenty-eight e's, five f's, three g's, eight h's, eleven i's, three l's, two m's, thirteen n's, nine o's, two p's, five r's, twenty-five s's, twenty-three t's, six v's, ten w's, two x's, five y's, and one z.

Se avete tempo potete verificarlo...

Il primo autogramma pubblicato (Sallows 1982) è apparso nella rubrica "Metamagical Themas" di Douglas Hofstadter in Scientific American.

Il compito di produrre un autogramma è intricato e complesso perché l'oggetto da descrivere non può essere conosciuto fino a quando la sua descrizione non è completa.

Per cominciare proviamo a contare le vocali di una frase. Prediamo una frase base con valori iniziali nulli:

(setq a "zero" e "zero" i "zero" o "zero" u "zero")
(setq base '(0 0 0 0 0))
(setq str (string a " a, " e " e, " i " i, " o " o " "e " u " u."))
;-> "zero a, zero e, zero i, zero o e zero u."

Poi contiamo le vocali nella frase:

(setq res (count '("a" "e" "i" "o" "u") (explode str)))
;-> (1 7 1 6 1)

In questo caso: (0 0 0 0 0) != (1 7 1 6 1), cioè i numeri iniziali delle vocali (0 0 0 0 0) non corrispondono a quanto calcolato nella stringa: (1 7 1 6 1).

Quindi la nuova lista base vale:

(setq base res)
;-> (1 7 1 6 1)

Convertiamo questi valori numerici in cifre e ricostruiamo la stringa:

; lista associativa: cifra -> stringa
(setq cifre '((0 "zero") (1 "una") (2 "due") (3 "tre") (4 "quattro")
              (5 "cinque") (6 "sei") (7 "sette") (8 "otto") (9 "nove")))

(setq a (lookup (base 0) cifre))
;-> "una"
(setq e (lookup (base 1) cifre))
;-> "sette"
(setq i (lookup (base 2) cifre))
;-> "una"
(setq o (lookup (base 3) cifre))
;-> "sei"
(setq u (lookup (base 4) cifre))
;-> "una"

(setq str (string a " a, " e " e, " i " i, " o " o " "e " u " u."))
;-> "una a, sette e, una i, sei o e una u."

Poi contiamo le vocali nella frase:

(setq res (count '("a" "e" "i" "o" "u") (explode str)))
;-> (4 5 2 1 4)

Nella stringa ci sono 4 "a", 5 "e", 2 "i" 1 "o" e 4 "u".

In questo caso: (1 7 1 6 1) != (4 5 2 1 4)

Quindi la nuova lista base vale:

(setq base res)
;-> (4 5 2 1 4)

...continuare in questo modo fino a che non si trova una soluzione oppure si entra in un ciclo infinito.

Questo metodo (partendo da (0 0 0 0 0)) genera il seguente ciclo:

 1  (1 7 1 6 1)
 2  (4 5 2 1 4)
 3  (4 4 2 3 6)
 4  (3 5 2 3 4)
 5  (2 6 2 2 4)
 6  (2 6 2 2 5) <--
 7  (1 7 3 1 5)   |
 8  (3 6 2 1 4)   |  Ciclo infinito
 9  (3 5 2 2 4)   |
10  (2 6 2 2 5) <--

La seguente funzione cerca una soluzione e controlla se si entra in un ciclo infinito, inoltre permette di impostare due parametri: i valori della lista iniziale e una stringa all'inizio della frase (che ci permette poi di 'pareggiare i conti'):

(define (autogram start-list init-str)
  (local (a e i o u base res cifre str all)
    (setq found nil)
    (setq ciclo nil)
    (setq all '())
    ; lista associativa: cifra -> stringa
    (setq cifre '((0 "zero") (1 "una") (2 "due") (3 "tre") (4 "quattro")
                  (5 "cinque") (6 "sei") (7 "sette") (8 "otto") (9 "nove")))
    ; lista cifre iniziali
    (setq base start-list)
    ; cifre iniziali
    (setq a (lookup (base 0) cifre))
    (setq e (lookup (base 1) cifre))
    (setq i (lookup (base 2) cifre))
    (setq o (lookup (base 3) cifre))
    (setq u (lookup (base 4) cifre))
    ; fino a che non troviamo una soluzione oppure non troviamo un ciclo...
    (until (or found ciclo)
      ; impostare la stringa
      (setq str (string init-str
            a " a, " e " e, " i " i, " o " o " "e " u " u."))
      ; contare le vocali
      (setq res (count '("a" "e" "i" "o" "u") (explode str)))
      ; se la lista base è uguale alla lista del conteggio -> stop
      ; altrimenti aggiorna i valori dei nuovi conteggi
      (if (= base res) (setq found true) (setq base res))
      (setq a (lookup (base 0) cifre))
      (setq e (lookup (base 1) cifre))
      (setq i (lookup (base 2) cifre))
      (setq o (lookup (base 3) cifre))
      (setq u (lookup (base 4) cifre))
      (println "try: " base)
      ; inserimento lista conteggi per controllo ciclo
      (if (find base all) ; se esiste il conteggio...
        (setq ciclo true) ; allora siamo in un ciclo
        (push base all)   ; altrimenti inserisci conteggio
      )
    )
    (if found (println "sol: " base) (println "ciclo infinito"))
    (println str)
  )
)

(autogram '(0 0 0 0 0) "")
;-> try: (1 7 1 6 1)
;-> try: (4 5 2 1 4)
;-> try: (4 4 2 3 6)
;-> try: (3 5 2 3 4)
;-> try: (2 6 2 2 4)
;-> try: (2 6 2 2 5)
;-> try: (1 7 3 1 5)
;-> try: (3 6 2 1 4)
;-> try: (3 5 2 2 4)
;-> try: (2 6 2 2 5)
;-> ciclo infinito
;-> tre a, cinque e, due i, due o e quattro u.

Potremmo provare con altri valori iniziali, ma in questo caso notiamo che dopo (2 6 2 2 4) troviamo (2 6 2 2 5). Quindi aggiungendo una "u" (per passare da 4 a 5), renderebbe la frase un autogramma. Per fare questo passiamo la seguente stringa iniziale: "Hu! "

(autogram '(0 0 0 0 0) "Hu! ")
;-> try: (1 7 1 6 2)
;-> try: (3 6 2 1 5)
;-> try: (2 6 3 1 5)
;-> try: (2 6 3 1 5)
;-> sol: (2 6 3 1 5)
;-> Hu! due a, sei e, tre i, una o e cinque u.

Abbiamo trovato un'autogramma (anche se con un piccolo trucco):

"Hu! due a, sei e, tre i, una o e cinque u."

Il trucco di aggiungere una stringa iniziale è possibile solo quando tutti i valori delle vocali di una stringa sono minori o uguali a quelli della stringa immediatamente successiva.

"Questa frase ha nove a, una b, sette c, undici d, sedici e, due f, una g, due h, dodici i, una l, sette n, otto o, cinque q, quattro r, sette s, quattordici t, dodici u e due v."

Per ulteriori informazioni: https://en.wikipedia.org/wiki/Autogram

Nota: "QUESTA FRASE HA CINQUE PAROLE" è una frase autoreferenziale.



--------------------------------------------
Ambito dinamico e ambito lessicale (statico)
--------------------------------------------

La nozione di ambito (scope) nei linguaggi di programmazione è tradizionalmente
legata a quella delle associazioni (bindings). Un'associazione (binding) è un legame tra un simbolo (o una variabile) e un valore. L'ambito dell'associazione definisce il tipo di"visibilità" del simbolo (o variabile) nel programma e può essere "dinamico" o "lessicale" ("statico").
Secondo l'ambito lessicale (statico), in una espressione, una variabile fa riferimento al costrutto più interno in cui viene dichiarata la variabile (ad esempio, al blocco di codice in cui è definita).
Invece l'ambito dinamico prevede che la variabile esista e possa essere usata solo durante l'estensione dinamica (esecuzione) di una espressione. Una variabile con ambito dinamico viene anche chiamata 'parametro'.
L'associazione dinamica associa i dati all'esecuzione del contesto corrente, e quindi consente di passare i dati alle funzioni senza dover dichiarare esplicitamente questi dati nell'interfaccia della funzione.
Una caratteristica particolare dei binding dinamici è che non sono catturati da una chiusura lessicale (lexical closure). Questo consente alcuni benefici, come la concisione, la modularità e l'adattabilità. Esempi tipici sono il reindirizzamento dell'output di un programma, la definizione di gestori di eccezioni (exception handler), la gestione dello stato dell'host locale in un sistema distribuito, ecc.

newLISP utilizza l'ambito dinamico per la visibilità delle variabili/identificatori, ma può anche usare l'ambito lessicale utilizzando i contesti (context).

In un linguaggio con ambito dinamico è possibile fare riferimento a un identificatore, non solo nel blocco in cui è dichiarato, ma anche in qualsiasi funzione o procedura richiamata dall'interno di quel blocco, anche se la procedura chiamata è dichiarata all'esterno del blocco.

Vediamo un esempio:

(setq x 42)
(define (f x) (g (+ x 2)))
(define (g y) (+ y x))

Quando chiamiamo (f 1) in newLISP accade questo:

(f 1) --> (g (+ 1 2)) --> (g 3) --> (+ 3 1) --> 4

Invece nel linguaggio Scheme (che ha un ambito lessicale) accade questo:

(f 1) --> (g (+ 1 2)) --> (g 3) ---> (+ 3 42) --> 45

In Scheme g può vedere solo la x definita al livello superiore (o qualsiasi livello al di sopra di essa in una definizione nidificata). In newLISP, g vede la x definita "attraverso" la chiamata della funzione applicata f (da cui il termine "dinamico"), poiché quella x è il parametro formale di f.

Vediamo un altro esempio del funzionamento dell'ambito dinamico:

(define (f a b)
  (local (LOC)
    (setq LOC 'dynamic)
    (println "pre f: a -> " a " b -> " b)
    (g a b)
    (println "post f: a -> " a " b -> " b)
  )
)

(define (g x y)
  (println LOC)
  (println "pre g: a -> " a " b -> " b)
  (println "pre g: x -> " x " y -> " y)
  (setq a (* a a))
  (setq b (* b b))
  (setq x (* x x))
  (setq y (* y y))
  (println "post g: a -> " a " b -> " b)
  (println "post g: x -> " x " y -> " y)
)

(f 2 3)
;-> pre f: a -> 2 b -> 3
;-> dynamic               ; "g" vede LOC perchè chiamata dall'interno di "f"
;-> pre g: a -> 2 b -> 3  ; "g" vede "a" perchè chiamata dall'interno di "f"
;-> pre g: x -> 2 y -> 3  ; "g" vede "b" perchè chiamata dall'interno di "f"
;-> post g: a -> 4 b -> 9
;-> post g: x -> 4 y -> 9
;-> post f: a -> 4 b -> 9 ; "f" vede i nuovi valori di "a" e "b".

Questo perchè le variabili libere "a" e "b" sono associate con dei valori nella funzione "f" e l'ambito dinamico permette alla funzione "g" di vedere queste associazioni perchè viene chiamata dall'interno della funzione "f".

Se chiamiamo direttamente la funzione "g" otteniamo un errore:

(g 2 3)
;-> nil                      ; la variabile LOC non esiste
;-> pre g: a -> nil b -> nil ; le variabili "a" e "b" esistono
;-> pre g: x -> 2 y -> 3
;-> ERR: value expected in function * : nil ; errore perchè "a" non esiste.

Questo perchè le variabili libere "a" e "b" non sono associate ad alcun valore e quindi valgono nil.

Ecco un ulteriore esempio:

(define (uno)
  (local (x)
    (setq x 10)
    (due)))

(define (due)
  (local (y)
    (setq y 20)
    (println (+ x y))))

(uno)
;-> 30
x
;-> nil
y
;-> nil

Quando la funzione "uno" chiama la funzione "due" il suo ambito (in particolare il valore della variabile "x") viene passato alla funzione "due". Quindi la funzione "due" conosce sia "x" (che proviene dal contesto di "uno"), sia "y" che è una variabile del proprio contesto.

Il problema dell'ambito dinamico risiede nel fatto, che se usiamo simboli che non sono stati definiti nella nostra funzione, non possiamo sapere se il simbolo è globale oppure è stato "ereditato" da una chiamata di funzione.

Utilizzando i contesti (context) possiamo utilizza l'ambito lessicale anche in newLISP:

(define (f x) (g (+ x 2)))
(context 'g)
(setq x 42)
(define (g:g y) (+ y x))
(context MAIN)
(f 1)

;-> 45

Comunque è molto meglio scrivere funzioni che non hanno variabili "libere" e quindi non occorre creare contesti per queste funzioni.

Ad esempio, si noti che il corpo di g ha due variabili x e y. y è una variabile associata in g, poiché è un parametro formale di g. Tuttavia, x non è associato, ovvero è "libera".

Nelle funzioni non dovrebbero esistere variabili "libere" (devono essere legate a un let o un local), ma nel caso fossero presenti devono riferirsi a variabili globali con nomi racchiusi da asterischi "*" (earmuffing), per evitare di entrare in conflitto con le varibili locali (quelle che entrano nello stack). Per esempio, *MAX-VAL* è una variabile globale (per convenzione).

Questo metodo di programmazione è principio di base della "programmazione strutturata" ed è valido per quasi tutti i linguaggi programmazione.

L'utilizzo dei contesti per avere un ambito lessicale è utile quando si lavora a programmi grandi e/o con un gruppo di programmatori: in questo modo nessuno influisce sul codice degli altri.

Comunque i contesti hanno un proprio ambito dinamico internamente, essi isolano il proprio ambito dinamico rispetto agli altri contesti (in altre parole un contesto è un nuovo spazio di nomi).

Lutz suggerisce anche un altro metodo per utilizzare le variabili globali (e le costanti): inserirle tutte in un contesto. Per esempio:

(set 'Setup:datapath "/home/data")
(set 'Setup:language "english")
(set 'Setup:n-records 12345)

Questo ha anche il vantaggio che tutte le variabili globali e le costanti possono essere salvate/caricate su un file tutte insieme:

Salvataggio variabili e costanti:
(save "setup.lsp" 'Setup)

Caricamento variabili e costanti:
(load "setup.lsp")

L'ambito dinamico costringe il programmatore a scrivere funzioni senza effetti collaterali (side effect).

newLISP comunque permette di utilizzare entrambi gli ambiti: dinamico e lessicale (o statico).

Un libro molto interessante su questo argomento e sul LISP in generale è:
"COMMON LISP: A Gentle Introduction to Symbolic Computation" di David Touretzky.

Alcune raccomandazioni per evitare i problemi dell'ambito dinamico:

(1) Non passare mai simboli quotati alle funzioni. Per passare i riferimenti, utilizzare i  contesti e i funtori di default.

(2) Non utilizzare mai variabili libere all'interno di una funzione, ad eccezione delle variabili chiaramente contrassegnate per l'uso globale da alcune convenzioni di denominazione (ad esempio *earmuffing*).

(3) Inserisci sempre le define-macro nel proprio spazio dei nomi. O ignorale completamente. Non sono una nuova funzionalità essenziale di newLISP.

Seguendo queste tre regole newLISP si comporterà come un linguaggio con ambito lessicale.

Infine, vediamo il perchè della parola "lessicale":

nell'ambito statico, una variabile si riferisce sempre all'associazione di chiusura più vicina (binding). Questa è una proprietà del testo del programma e non è correlata allo stack delle chiamate di runtime. Poiché la corrispondenza di una variabile con l'associazione richiede solo l'analisi del testo del programma, questo tipo di ambito viene chiamato anche "ambito lessicale".

Dal punto di vista storico, newLISP ci comporta come il LISP originale di McCarthy. Poi  Scheme ha introdotto l'ambito lessicale che è stato seguito anche dal Common Lisp (sebbene CL supporti l'ambito dinamico se si dichiarano le variabili locali come speciali). È una delle questioni più controverse nella famiglia dei linguaggi LISP.


----------------------------------
Uso delle espressioni condizionali
----------------------------------

Analizzeremo i metodi consigliati nell'uso delle espressioni: "if", "when", "unless", "cond" e "case".

Quando utilizzare l'espressione "cond"
--------------------------------------
Ci sono alcuni casi in cui "cond" è preferibile ad "if":

1) Quando abbiamo una catena di "if" (skip chain)

sbagliato:

(if condizione1
    esegui-1
    (if condizione-2
        esegui-2
        esegui-3))

giusto:

(cond (condizione-1 esegui-1)
      (condizione-2 esegui-2)
      (true esegui-3)

2) Quando la parte 'then' o 'else' contiene diverse espressioni da valutare (che richiederebbe l'uso di "begin")

sbagliato:

(if condizione-1
    (begin azione-1a
           azione-1b)
    (begin azione-2a
           azione-2b)

giusto:

(cond (condizione-1 esegui-1a esegui-1b)
      (true esegui-2a esegui-2b))

L'espressione "cond" ha una definizione implicita di "begin" per ogni clausola.

3) Quando viene il risultato della condizione rappresenta l'espressione di ritorno

sbagliato:

(let ((val (calcolo-complicato a b c)))
  (if val
      val
      (esegui-altro x y z)))

giusto:

(cond ((calcolo-complicato a b c))
      (true (esegui altro x y z)))

Quando utilizzare l'espressione "case"
--------------------------------------
L'espressione condizionale "case" può essere vista come un caso speciale del condizionale "cond" che risolve il problema di testare il valore di un'espressione con un certo numero di valori costanti (questi valori devono essere costanti perchè non vengono valutati da newLISP).
Il "case" esiste perchè è molto più veloce del cond per questo caso speciale (il compilatore può utilizzare una tabella hash invece di dover testare ogni clausola in sequenza).

sbagliato:

(cond ((= val 1) esegui-1)
      ((= val 2) esegui-2)
      ((= val 3) esegui-3)
      ((= val 4) esegui-4)
      (true esegui-5))

giusto:

(case val
  (1 esegui-1)
  (2 esegui-2)
  (3 esegui-3)
  (4 esegui-4)
  (true esegui-5))

Quando utilizzare l'espressione "when" e "unless"
-------------------------------------------------
Quando l'espressione "if" ha un solo ramo ('then' oppure 'else'), allora è meglio utilizzare "when" o "unless". L'uso di queste due espressioni permettono di risparmiare spazio e rendono il codice più preciso (leggibile).

sbagliato:

(if (un-test a b c)
    (begin (calcolo-1 a b c)
           (calcolo-2 a b c)
           (calcolo-3 a b c)
           ...))

giusto:

(when (un-test a b c)
  (calcolo-1 a b c)
  (calcolo-2 a b c)
  (calcolo-3 a b c)
  ...)

Quando si usa "when" o "unless" la condizione di test non deve essere negata con l'espressione "not".

sbagliato:

(when (not (un-test a b c))
  (calcolo-1 a b c)
  (calcolo-2 a b c)
  (calcolo-3 a b c)
  ...)

giusto:

(unless (un-test a b c)
  (calcolo-1 a b c)
  (calcolo-2 a b c)
  (calcolo-3 a b c)
  ...)

L'uso del test "null?" è consigliato nel caso seguente:

sbagliato:

(when (rest lst))
  (calcolo-1 a b c)
  (calcolo-2 a b c)
  (calcolo-3 a b c)
  ...)

giusto:

(unless (null? (rest lst))
  (calcolo-1 a b c)
  (calcolo-2 a b c)
  (calcolo-3 a b c)
  ...)

Ricordiamo che in newLISP "nil" è diverso dalla lista vuota '():

(= nil '())
;-> nil

Ma si comportano allo stesso modo con l'espressione di test "null?":

(if (null? '()) (println "nullo") (println "non nullo"))
;-> nullo
(if (null? nil) (println "nullo") (println "non nullo"))
;-> nullo
(if (null? 0) (println "nullo") (println "non nullo"))
;-> nullo


------------------------------
select e unselect (antiselect)
------------------------------

Prendiamo dal manuale la definizione della funzione built-in "select":

********************
>>>funzione SELECT
********************
sintassi: (select list list-selection)
sintassi: (select list [int-index_i ... ])

Nelle prime due forme, "select" seleziona uno o più elementi dall'elenco utilizzando uno o più indici specificati dalla list-selection o da int-index_i.

(set 'lst '(a b c d e f g))

(select lst '(0 3 2 5 3))
;-> (a d c f d)

(select lst '(-2 -1 0))
;-> (f g a)

(select lst -2 -1 0)
;-> (f g a)

Nelle seconde due forme, "select" seleziona uno o più caratteri dalla stringa utilizzando uno o più indici specificati dalla list-selection o da int-index_i.

(set 'str "abcdefg")

(select str '(0 3 2 5 3))
;-> "adcfd"

(select str '(-2 -1 0))
;-> "fga"

(select str -2 -1 0)
;-> "fga"

Gli elementi selezionati possono essere ripetuti e non devono apparire in ordine, sebbene ciò acceleri l'elaborazione. L'ordine in list-selection o int-index_i può essere modificato per riorganizzare gli elementi.

Ecco un altro esempio:

(select { ILPSaegilnouw} '(1 9 0 9 8 10 7 12 5 7 7 8 11 0 10 6 13 2 1 4 3))
;-> "Il linguaggio newLISP"

Adesso vediamo la funzione opposta "unselect" che elimina dalla lista "lst" gli elementi che hanno gli indici elencati dalla lista "sel": (unselect lst sel)

(setq lst '(a b c d nil f))

Funzione proposta da newbert:

(define (unselect1 lst sel)
  (select lst (difference (sequence 0 (- (length lst) 1)) sel)))

(unselect1 lst '(1 2))
;-> (a d nil f)

Funzione proposta da fdb:

(define (unselect2 lst sel)
    (select lst (difference (sequence 0 (dec (length lst))) sel)))

(unselect2 lst '(1 2))
;-> (a d nil f)

Funzione proposta da ralph.ronnquist:

(define (unselect3 lst sel) (let (n -1) (clean (fn (x) (member (inc n) sel)) lst)))

(unselect3 lst '(1 2))
;-> (a d nil f)

Vediamo quale funzione è più veloce:

(setq lista '(a b c d nil f g h i j k l m n o p q r s t nil v w x y nil))

(setq sel '(3 7 5 4 7 9 11 3 22 25 4 0 7 13 20 19 18 20 25))

(unselect1 lista sel)
;-> (b c g i k m o p q r v x y)

(unselect2 lista sel)
;-> (b c g i k m o p q r v x y)

(unselect3 lista sel)
;-> (b c g i k m o p q r v x y)

(time (unselect1 lista sel) 100000)
;-> 430.979

(time (unselect2 lista sel) 100000)
;-> 425.475

(time (unselect3 lista sel) 100000)
;-> 1225.691


------------
Generatori 1
------------

Un generatore è una funzione che produce un risultato diverso (generalmente in sequenza) ogni volta che viene chiamata.
Per fare questo occorre ricordare/memorizzare lo stato corrente della funzione. Per questo scopo si usa un contesto (context) che contiene la funzione (funtore del contesto) e i dati necessari. In altra parole si tratta di una funzione con memoria.

(define (gen:gen)
  (setq gen:sum
    (if gen:sum (inc gen:sum) 1)))

Questo potrebbe essere scritto più brevemente, perché "inc" considera nil come zero:

(define (gen:gen)
  (inc gen:sum))

(gen)
;-> 1
(gen)
;-> 2

Quando si scrive gen:gen, viene creato un context chiamato "gen". Questo è uno spazio di nomi (namespace) lessicale contenente i propri simboli usati come variabili e come funzioni. In questo caso il nome-spazio "gen" contiene due simboli: "gen" (funzione/funtore) e "sum" (variabile).
Il primo simbolo di un contesto ha lo stesso nome del contesto in cui è contenuto e viene chiamato "funtore" di default del contesto. In questo caso il contesto si chiama "gen" e quindi il funtore si chiama "gen". Quando si utilizza un nome di contesto al posto di un nome di funzione, newLISP assume il funtore predefinito. Quindi possiamo chiamare la nostra funzione generatore usando (gen). Non è necessario chiamare la funzione usando (gen:gen), (gen) verrà impostato automaticamente su (gen:gen).

Possiamo aggiungere altre funzioni al contesto "gen", ad esempio una funzione che inizializza il generatore:

(define (gen:init x)
  (setq gen:sum x))

(gen:init -1)
;-> -1

(gen)
;-> 0

(gen)
;-> 1

Possiamo usare anche un'altro metodo:

(define (foo:foo x) (if x (set 'foo:sum x)) (inc foo:sum))

(foo)
;-> 1
(foo)
;-> 2
(foo 10)
;-> 11
(foo)
;-> 12
(foo 8)
;-> 9
foo:sum
;-> 9

Queso metodo è meglio perché non è necessario scrivere funzioni aggiuntive per accedere alla somma.Inoltre foo:sum porta in primo piano il qualificatore 'foo'. Infine, ma non meno importante, questo è più facile da capire di una chiusura (closure).

Adesso proviamo a scrivere un generatore di numeri primi.

Prima definiamo la funzione che verifica se un numero è primo:

(define (primo:isprime? n)
  (if (< n 2) nil
    (= 1 (length (factor n)))))

Poi scriviamo la funzione che inizializza il valore dello stato della funzione (cioè la funzione che imposta il valore di partenza della funzione):

(define (primo:start x)
  (setq primo:val x))

Una funzione per verificare il valore dello stato:

(define (primo:print-val) primo:val)

Infine scriviamo la funzione/funtore del contesto "primo" (il parametro "dir" può assumere true o nil e specifica se generare il  primo successivo oppure il primo precedente):

(define (primo:primo dir)
  (local (found num)
    (setq found nil)
    (if (null? dir)
      (setq num (+ primo:val 1))
      (setq num (- primo:val 1))
    )
    (until found
      (if (primo:isprime? num)
          (setq primo:val num found true)
      )
      (if (null? dir)
        (++ num)
        (-- num)
      )
    )
    primo:val
  )
)

Proviamo il tutto:

(primo:start 13)
;-> 13

(primo:print-val)
;-> 13

(primo:isprime? 13)
;-> true

(primo)
;-> 17

(primo)
;-> 19

(primo)
;-> 23

(primo true)
;-> 19

(primo true)
;-> 17

(primo)
;-> 19

Nota: quando programmiamo con i contesti è utile analizzare i simboli che sono stati definiti con la seguente funzione:

(define (simboli contesto)
  (dotree (el contesto) (println el)))

(simboli primo)
;-> primo:isprime?
;-> primo:primo
;-> primo:print-val
;-> primo:start
;-> primo:val

Nota: quando la situazione diventa "caotica" è possibile (consigliato) chiudere la REPL corrente e rilanciare una nuova REPL (per avere tutti i simboli di default).


------------
Generatori 2
------------

In newLISP le funzioni sono oggetti di prima classe (cioè possono essere assegnati alle variabili, passati e/o restituiti da una funzione e possono essere modificati da codice). Questa caratteristica permette di scrivere un altro tipo di generatori utilizzando una funzione automodificante. Supponiamo di avere una funzione somma/accumulatore del tipo seguente:

(setq a 0)
(define (somma (x a)) (inc a x))
;-> (lambda ((x a)) (inc a x))

Se chiamiamo la funzione senza parametri otteniamo il valore di "a":

(somma)
;-> 0

Se chiamiamo la funzione con un parametro otteniamo la somma di "a" e del parametro (che viena assegnata ad "a"):

(somma 3)
;-> 3
a
;-> 3

(somma 2)
;-> 5
a
;-> 5

newLISP ci permette di sostituire il simbolo "a" con il simbolo "0":

(define (somma (x 0)) (inc 0 x))
;-> (lambda ((x 0)) (inc 0 x))

(somma)
;-> 0

(somma 1)
;-> 1

(somma 5)
;-> 6

(somma 15)
;-> 21

Per capire meglio questo metodo analizziamo come è cambiata la funzione "somma" dopo la sua esecuzione:

somma
;-> (lambda ((x 0)) (inc 21 x))

Il simbolo iniziale "0" è stato modificato dalla funzione stessa nel valore della somma "21". Questo processo viene eseguito durante la valutazione e l'espansione dei parametri che vengono applicati al corpo della funzione.

Un altro esempio di generatore utilizza la funzione "expand" per creare funzioni che effettuano lo stream (flusso) di liste o di stringhe:

(define (make-stream lst)
    (letex (stream lst)
        (lambda () (pop 'stream))))
;-> (lambda (lst)
;->  (letex (stream lst) (lambda () (pop 'stream))))

(set 'lst '(a b c d e f g h))

Adesso definiamo la funzione di stream sulla lista "lst":

(define mystream (make-stream lst))
;-> (lambda () (pop '(a b c d e f g h)))

Attiviamo lo stream degli elementi:

(mystream)
;-> a
(mystream)
;-> b
(mystream)
;-> c
Poiché pop funziona sia con le liste che con le stringh, la stessa funzione generatrice può essere utilizzata per generare uno stream di stringhe:

(setq str "abcddefgh")

(define mystream (make-stream str))
;-> (lambda () (pop '"abcddefgh"))

(mystream)
;-> "a"
(mystream)
;-> "b"


-------------------------------
Shift logico e Shift aritmetico
-------------------------------

Shift = Spostamento

Lo shift logico e lo shift aritmetico sono operazioni di manipolazione dei bit (operazioni bitwise).

Shift Logico
------------

Uno "shift logico sinistro" sposta ogni bit di una posizione a sinistra. Il bit meno significativo libero (LSB) viene riempito con zero e il bit più significativo (MSB) viene scartato.

              MSB                         LSB
             +---+---+---+---+---+---+---+---+
scartato <-- | 1 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | <-- 0
             +---+---+---+---+---+---+---+---+
                  /   /   /   /   /   /   /
                 /   /   /   /   /   /   /
                /   /   /   /   /   /   /
             +---+---+---+---+---+---+---+---+
             | 0 | 1 | 1 | 0 | 0 | 1 | 1 | 0 |
             +---+---+---+---+---+---+---+---+

Uno "shift logico destro" sposta ogni bit di una posizione a destra. Il bit meno significativo (LSB) viene scartato e il bit più significativo (MSB) che è vuoto viene riempito con zero.

              MSB                         LSB
             +---+---+---+---+---+---+---+---+
             | 1 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | --> scartato
             +---+---+---+---+---+---+---+---+
                \   \   \   \   \   \   \
                 \   \   \   \   \   \   \
                  \   \   \   \   \   \   \
             +---+---+---+---+---+---+---+---+
       0 --> | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 1 |
             +---+---+---+---+---+---+---+---+

Shift Aritmetico
----------------

Uno "shift aritmetico sinistro" sposta ogni bit di una posizione a sinistra. Il bit meno significativo  (LSB)  che è vuoto viene riempito con zero e il bit più significativo (MSB) viene scartato. È identico allo shift logico sinistro.

              MSB                         LSB
             +---+---+---+---+---+---+---+---+
scartato <-- | 1 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | <-- 0
             +---+---+---+---+---+---+---+---+
                  /   /   /   /   /   /   /
                 /   /   /   /   /   /   /
                /   /   /   /   /   /   /
             +---+---+---+---+---+---+---+---+
             | 0 | 1 | 1 | 0 | 0 | 1 | 1 | 0 |
             +---+---+---+---+---+---+---+---+

Uno "shift aritmetico destro" sposta ogni bit di una posizione verso destra. Il bit meno significativo (LSB) viene scartato e il bit più significativo (MSB) che è vuoto viene riempito con il valore dell'MSB precedente (ora spostato di una posizione verso destra).

              MSB                         LSB
             +---+---+---+---+---+---+---+---+
             | 1 | 0 | 1 | 1 | 0 | 0 | 1 | 1 | --> scartato
             +---+---+---+---+---+---+---+---+
               |\   \   \   \   \   \   \
               | \   \   \   \   \   \   \
               |  \   \   \   \   \   \   \
             +---+---+---+---+---+---+---+---+
             | 1 | 1 | 0 | 1 | 1 | 0 | 0 | 1 |
             +---+---+---+---+---+---+---+---+

In newLISP viene implementato solo lo "shift aritmetico" (quindi manca solo lo shift logico destro).

Vediamo la definizione delle operazioni di Shift dal manuale:

********************
>>>funzione << e >>
********************
sintassi: (<< int-1 int-2 [int-3 ... ])
sintassi: (>> int-1 int-2 [int-3 ... ])
sintassi: (<< int-1)
sintassi: (>> int-1)

Il numero int-1 viene shiftato (spostato) aritmeticamente verso sinistra o verso destra dal numero di bit dato da int-2, quindi shiftato da int-3 e così via. Ad esempio, gli interi a 64 bit possono essere spostati fino a 63 posizioni. Quando si sposta a destra, il bit più significativo viene duplicato (shift aritmetico):

(>> 0x8000000000000000 1)  → 0xC000000000000000  ; not 0x0400000000000000!

(<< 1 3)      →  8
(<< 1 2 1)    →  8
(>> 1024 10)  →  1
(>> 160 2 2)  → 10

(<< 3)        →  6
(>> 8)        →  4

Quando int-1 è l'unico argomento << e >> shifta int-1 di un bit.

Le operazioni di shift aritmetico possono essere utilizzate per dividere o moltiplicare un numero  intero.

Moltiplicazione con lo shift a sinistra
---------------------------------------
Il risultato di un'operazione di shift a sinistra è una moltiplicazione per 2^n, dove n è il numero di posizioni di bit shiftate.

Esempio:

10 * 2 = 20
(<< 10)
;-> 20

-3 * 4 = -12
(<< -3 2)
;-> -12

Divisione con lo shift a destra
-------------------------------
Il risultato di un'operazione di shift a destra è una divisione per 2^n, dove n è il numero di posizioni di bit shiftate.

Esempio:

10 / 2 = 5
(>> 10)
;-> 5

-20 / 4 = -5
(>> -20 2)
;-> -5


----------------------
fold-left e fold-right
----------------------

La funzione generica "fold" rappresenta il modello base di ricorsione su una lista. Anche se newLISP non ha l'ottimizzazione della ricorsione di coda (tail recursion) è interessante e utile capire il funzionamento di questa funzione.

Supponiamo di voler sommare una lista di numeri (1 2 3 4). Il modo più immediato è il seguente:

1 + 2 + 3 + 4

In altre parole, abbiamo inserito l'operatore "+" in mezzo ad ogni elemento. Valutiamo l'espressione:

((1 + 2) + 3) + 4

(3 + 3) + 4

6 + 4  ==>  10

La funzione "fold-left" fa esattamente questo: prende una procedura che ha due parametri, un valore iniziale e una lista. Nel nostro caso la procedura è "+", il valore iniziale è 0 e la lista è (1 2 3 4). La lista iniziale viene "ripiegata" (fold) a "sinistra" (left), quindi si parte dall'ultima elemento della lista e si procede verso sinistra (questo non è un problema perchè l'operazione di somma gode della proprietà associativa a + b = b + a).

Vediamo un esempio di applicazione della funzione "fold-left" in termini di s-espressioni in notazione prefissa:

(fold-left + '(1 2 3 4) 0)

(+ 4 (+ 3 (+ 2 (+ 1 0))))

(+ 4 (+ 3 (+ 2 1)))

(+ 4 (+ 3 3))

(+ 4 6)  ==>  10

Il valore iniziale è importante perchè se la lista di input è vuota, allora questo è il valore che ritorna la funzione "fold-left".

(fold-left + '() 0)  ==>  0

Così possiamo definire una funzione somma in termini di "fold-left":

(define (somma lst) (fold-left + lst 0))

(somma '(1 2 3 4))   ==>  10

(somma '())          ==>  0

La procedura "fold-left" riduce la lista ad un singolo valore.

Vediamo un altro esempio di utilizzo della funzione "fold-left" con i seguenti parametri:

valore iniziale -> lista vuota '()
procedura       -> cons

Eseguiamo la valutazione della seguente espressione:

(fold-left cons '(1 2 3) '())

(cons 3 (cons 2 (cons 1 '())))

(cons 3 (cons 2 '(1)))

(cons 3 '(2 1))

==> '(3 2 1)

Il risultato è l'inversione della lista di input.

Vediamo l'implementazione della funzione "fold-left":

(define (fold-left func lst init)
    (if (null? lst) init
        (fold-left func (rest lst) (func (first lst) init))))

Proviamo a verificare gli esempi:

(fold-left + '(1 2 3 4) 0)
;-> 10

(fold-left + '() 0)
;-> 0

(fold-left cons '(1 2 3) '())
;-> (3 2 1)

Altri esempi:

(fold-left - '(1 2 3 4) 0)
;-> 2
(- 4 (- 3 (- 2 (- 1 0))))
(- 4 (- 3 (- 2 (1))))
(- 4 (- 3 1))
(- 4 2)  ==>  2

(fold-left - '(4 3 2 1) 0)
;-> -2
(- 1 (- 2 (- 3 (- 4 0))))
(- 1 (- 2 (- 3 4)))
(- 1 (- 2 (- 1)))
(- 1 3)  ==> -2

La funzione "fold-left" ha una sorella chiamata "fold-right" che "ripiega" la lista a destra, cioè dal primo valore della lista all'ultimo.

(define (fold-right func lst end)
    (if (null? lst) end
        (func (first lst) (fold-right func (rest lst) end))))

Se la lista è vuota, restituire il valore finale end. In caso contrario, applicare la funzione al primo elemento della lista e al risultato del "folding" di questa funzione e del valore finale verso il resto della lista. Poiché l'operando di destra viene piegato per primo, abbiamo un "folding"  associativo a destra.

Per la maggior parte delle operazioni associative come + e *, "fold-left" e "fold-right" sono completamente equivalenti. Tuttavia, esiste almeno un'importante operazione binaria che non è associativa: cons. Per tutte le nostre funzioni di manipolazione di liste, quindi, dovremo scegliere tra il "folding" associativo sinistro e destro.

Rivediamo la funzione "fold-left":

(define (fold-left func lst init)
    (if (null? lst) init
        (fold-left func (rest lst) (func (first lst) init))))

Questa inizia allo stesso modo della versione associativa di destra, con il test per la lista vuota che restituisce il valore iniziale (accumulatore). Questa volta, tuttavia, applichiamo la funzione all'accumulatore e al primo elemento della lista, invece di applicarla al primo elemento e al risultato del folding della lista. Ciò significa che elaboriamo prima l'inizio, generando una  associatività a sinistra. Una volta raggiunta la fine della lista '(), restituiamo il risultato che abbiamo progressivamente accumulato.

Si noti che func prende i suoi argomenti nell'ordine opposto da "fold-right". In "fold-right", l'accumulatore (end) rappresenta l'ultimo valore da utilizzare dopo il folding della lista. In "fold-left", l'accumulatore (init) rappresenta il calcolo completato per la parte a sinistra della lista. Al fine di preservare la commutatività degli operatori, l'accumulatore deve essere l'argomento a sinistra della nostra operazione in "fold-left", ma l'argomento a destra in "fold-right".

(fold-right - '(1 2 3 4) 0)
;-> -2
(- 1 (- 2 (- 3 (- 4 0))))
(- 1 (- 2 (- 3 4)))
(- 1 (- 2 -1))
(- 1 3) ==> -2

(fold-right - '(4 3 2 1) 0)
;-> 2

La funzione "fold-right" con operatore "cons" e lista vuota '() come valore iniziale, produce una copia della lista:

(fold-right cons '(4 3 2 1) '())
;-> (4 3 2 1)

Possiamo anche definire una funzione "unfold" che è l'opposto di "fold". Data una funzione unaria, un valore iniziale e un predicato unario, "unfold" continua ad applicare la funzione all'ultimo valore fino a quando il predicato è vero, costruendo una lista mentre procede.

(define (unfold func init pred)
  (if (pred init)
      (cons init '())
      (cons init (unfold func (func init) pred))))

Se il predicato è vero, allora "cons" la lista vuota '() sull'ultimo valore, terminando la lista. Altrimenti, "cons" il risultato di "unfolding" del valore successivo (func init) con il valore corrente.

Esempi:

(unfold (fn(x) (* x x)) 2 (fn(x) (> (* x x) 100)))
;-> (2 4 16)

(unfold (fn(x) (sqrt x)) 64 (fn(x) (< x 2)))
;-> (64 8 2.82842712474619 1.681792830507429)

La funzione "fold" (left e right) è una funzione universale, nel senso che ci permette di generare molte altre funzioni. Vediamo alcuni esempi:

Inversione di una lista:

(define (inverte lst) (fold-left cons lst '()))
(inverte '(4 3 2 1))
;-> (1 2 3 4)

Somma degli elementi di una lista:

(define (somma lst) (fold-left + lst 0))
(somma '(1 3 -2 3))
;-> 5

Moltiplicazione degli elementi di una lista:

(define (moltiplica lst) (fold-left * lst 1))
(moltiplica '(1 3 -2 3))
;-> -18

Operatore AND agli elementi di una lista:

(define (and-lst lst) (fold-left and lst true))
(and-lst '(true true nil))
;-> nil
(and-lst '(true true true))
;-> true

Operatore OR agli elementi di una lista:

(define (or-lst lst) (fold-left or lst nil))
(or-lst '(true true nil))
;-> true
(or-lst '(nil nil))
;-> nil

Valore massimo degli elementi di una lista:

(define (max-lst lst)
  (fold-left (fn (old cur) (if (> old cur) old cur)) (rest lst) (first lst)))
(max-lst '(1 3 3 4 8 3 2 4))
;-> 8

Valore minimo degli elementi di una lista:

(define (min-lst lst)
  (fold-left (fn (old cur) (if (< old cur) old cur)) (rest lst) (first lst)))
(min-lst '(1 3 3 4 8 3 2 4))
;-> 1

Lunghezza di una lista:

Pensiamo in termini di definizione di un ciclo. L'accumulatore inizia da 0 e viene incrementato di 1 ad ogni iterazione. Questo ci dà sia il nostro valore di inizializzazione, 0, sia la nostra funzione (fn (x y) (+ x 1)). Un altro modo di vedere questo è "La lunghezza di una lista vale 1 + la lunghezza della sotto-lista alla sua sinistra".

(define (lunghezza lst) (fold-left (fn (x y) (+ x 1)) lst 0))
(lunghezza '(1 2 3 5 8 4 6))
;-> 7

Filtraggio degli elementi di una lista:

Questa funzione mantiene solo gli elementi di una lista che soddisfano un predicato, eliminando tutti gli altri.

(define (filtra pred lst) (fold-right (fn (x y) (if (pred x) (cons x y) y)) lst '()))
(filtra (fn (x) (> x 5)) '(1 45 34 2 3 6))
;-> 45 34 6

Viene testato il valore corrente rispetto al predicato. Se è vero, sostituisce "cons" con "cons", cioè non cambia nulla. Se è falso, elimina il "cons" e restituisce il resto dell'elenco. Questo elimina tutti gli elementi che non soddisfano il predicato, creando una nuova lista che include solo quelli che lo soddisfano.

Nota: la chiave per programmare con il metodo "fold" è pensare solo in termini di ciò che accade ad ogni iterazione. Questo metodo cattura il modello di ricorsione in una lista e i problemi ricorsivi si risolvono meglio lavorando un passo alla volta.

Le stesse due funzioni possono essere scritte anche in modo leggermente diverso. Infatti sono scambiati i parametri (func --> op, init --> base, lst --> xs):

(define (fold-left op base xs)
  (if (null? xs)
      base
      (fold-left op (op base (car xs)) (cdr xs))))

(define (fold-right op base xs)
  (if (null? xs)
      base
      (op (car xs) (fold-right op base (cdr xs)))))

Il metodo Fold utilizza una funzione specificata dall'utente per ridurre una lista di valori a un singolo valore e rappresenta uno delgi idiomi fondamentali della programmazione funzionale. "Fold-left" lavora da sinistra a destra attraverso l'elenco xs, applicando la funzione binaria op alla base e al primo elemento di xs, quindi applicando la funzione binaria op al risultato della prima funzione op e del secondo elemento di xs, e così via, applicando ad ogni passo la funzione binaria op al risultato della precedente funzione op e all'elemento corrente di xs. "fold-right" funziona allo stesso modo, ma da destra a sinistra.


-----------------------
La divisione di Feynman
-----------------------

Ecco un puzzle proposto da Feynman: Divisione lunga.

Ogni punto "." (dot) rappresenta una cifra (qualsiasi cifra da 0 a 9). Ogni "A" rappresenta la stessa cifra (ad esempio, un 3). Nessuno dei punti "." ha lo stesso valore di "A" (cioè, nessun punto "." può valere 3 se "A" vale 3).

    ....A..   | .A.
    ..AA      |------
    ----      | ..A.
     ...A     |
      ..A     |
    -----     |
      ....    |
      .A..    |
      ----    |
       ....   |
       ....   |
       ----   |
          .   |

Per risolvere il problema possiamo pensare di lavorare al contrario, cioè calcolare il valore del prodotto tra il risultato e il divisore e sottoponendolo ad alcuni vincoli.

Per cominciare inseriamo le variabili (A, b, c, d, e, f) per il divisore e il risultato:

  il divisore vale:  ".A."  --> bAc
  il risultato vale: "..A." --> deAf

Quindi calcoliamo il valore (bAc * deAf) = "....A.."

Alcune considerazioni che trasformiamo in vincoli:

1) Il valore cercato ha sette cifre.

2) Il valore A è diverso da b, c, d, e, f.

3) La prima linea della divisione implica che d * bAc deve valere AA modulo 100.

4) La seconda linea della divisione implica che e * bAc deve valere A modulo 10.

5) La terza linea della divisione implica A * bAc è un numero con quattro cifre e la seconda cifra deve essere A.

(define (feynman)
  (local (a b c d e f m1 m2)
    (for (a 0 9)
      (for (b 0 9)
        (for (c 0 9)
          (for (d 0 9)
            (for (e 0 9)
              (for (f 0 9)
                ; calcoliamo i due numeri del prodotto
                ; (moltiplicando e moltiplicatore)
                (setq m1 (+ (* b 100) (* a 10) c))
                (setq m2 (+ (* d 1000) (* e 100) (* a 10) f))
                ; impostiamo i vincoli
                        ; A è diverso dalle altre cifre
                (if (and (!= a b) (!= a c) (!= a d) (!= a e) (!= a f)
                        ; il prodotto ha sette cifre
                          (< 999999 (* m1 m2) 10000000)
                        ; il quinto numero deve valere A
                          (= (int ((explode (string (* m1 m2))) 4)) a)
                        ; d * bAc deve valere AA modulo 100
                          (= (% (* d m1) 100) (+ (* a 10) a))
                        ; e * bAc deve valere A modulo 10
                          (= (% (* e m1) 10) a)
                        ; A * bAc deve avere quattro cifre
                          (< 999 (* a m1))
                        ; la seconda cifra di A * bAc deve valere A
                          (= (int ((explode (string (* a m1))) 1)) a)
                    )
                    (println (list b a c) { * } (list d e a f))
                )))))))))

(feynman)
;-> (4 3 7) * (9 9 3 9)
;-> (4 8 4) * (7 2 8 9)
;-> (4 8 4) * (7 7 8 9)

Non abbiamo una soluzione unica, quindi dobbiamo inserire altri vincoli. Prima di fare questo verifichiamo il primo risultato per vedere se stiamo procedendo con la giusta logica:

(* 437 9939)
;-> 4343343

(* bAc deAf)

; Impostiamo le cifre
(setq b 4 a 3 c 7 d 9 e 9 f 9)
; Calcoliamo i due fattori (moltiplicando e moltiplicatore)
(setq m1 (+ (* b 100) (* a 10) c))
;-> 437
(setq m2 (+ (* d 1000) (* e 100) (* a 10) f))
;-> 9939

; Applichiamo i vincoli:
; A è diverso dalle altre cifre
(and (!= a b) (!= a c) (!= a d) (!= a e) (!= a f))
;-> true
; il prodotto ha sette cifre
(< 999999 (* m1 m2) 10000000)
;-> true
; il quinto numero deve valere A
(= (int ((explode (string (* m1 m2))) 4)) a)
;-> true
; d * bAc deve valere AA modulo 100
(= (% (* d m1) 100) (+ (* a 10) a))
;-> true
; e * bAc deve valere A modulo 10
(= (% (* e m1) 10) a)
;-> true
; A * bAc deve avere quattro cifre
(< 999 (* a m1))
;-> true
; la seconda cifra di A * bAc deve valere A
(= (int ((explode (string (* a m1))) 1)) a)
;-> true

Per ora, sembra che sia tutto corretto.
Un altro vincolo viene osservando che "e" deve essere inferiore a "d", poiché (e * bAc) è un numero di tre cifre, ma (d * bAc) è un numero di quattro cifre. Questo si traduce nella seguente espressione: (< e d).

Riscriviamo la funzione con il nuovo vincolo:

(define (feynman)
  (local (a b c d e f m1 m2)
    (for (a 0 9)
      (for (b 0 9)
        (for (c 0 9)
          (for (d 0 9)
            (for (e 0 9)
              (for (f 0 9)
                ; calcoliamo i due numeri del prodotto
                ; (moltiplicando e moltiplicatore)
                (setq m1 (+ (* b 100) (* a 10) c))
                (setq m2 (+ (* d 1000) (* e 100) (* a 10) f))
                ; impostiamo i vincoli
                        ; A è diverso dalle altre cifre
                (if (and (!= a b) (!= a c) (!= a d) (!= a e) (!= a f)
                        ; il prodotto ha sette cifre
                          (< 999999 (* m1 m2) 10000000)
                        ; il quinto numero deve valere A
                          (= (int ((explode (string (* m1 m2))) 4)) a)
                        ; d * bAc deve valere AA modulo 100
                          (= (% (* d m1) 100) (+ (* a 10) a))
                        ; e * bAc deve valere A modulo 10
                          (= (% (* e m1) 10) a)
                        ; A * bAc deve avere quattro cifre
                          (< 999 (* a m1))
                        ; la seconda cifra di A * bAc deve valere A
                          (= (int ((explode (string (* a m1))) 1)) a)
                        ; "e" deve essere minore di "d"
                          (< e d)
                    )
                    (println (list b a c) { * } (list d e a f) { -> }
                             (list a b c d e f))
                )))))))))

(feynman)
;-> (4 8 4) * (7 2 8 9) -> (8 4 4 7 2 9)

(* 484 7289)
;-> 3527876

Quindi la divisione finale è la seguente:

3527876   | 484
3388      |------
----      | 7289
 1398     |
  968     |
-----     |
  4307    |
  3872    |
  ----    |
   4356   |
   4356   |
   ----   |
      0   |


----------------------------------------
Il linguaggio di programmazione Fractran
----------------------------------------

Fractran è un linguaggio di programmazione esoterico Turing-completo inventato dal matematico John Conway. Un programma Fractran è una lista ordinata di frazioni positive e un numero intero positivo iniziale n. Il programma viene eseguito aggiornando l'intero n come segue:

1) per la prima frazione f nell'elenco per cui n*f è un numero intero, sostituire n con n*f

2) ripetere questa regola fino a quando nessuna frazione dell'elenco produce un numero intero se moltiplicata per n, quindi arrestarsi.

Nel 1987 Conway ha scritto il seguente programma per generare i numeri primi:

(17/91 78/85 19/51 23/38 29/33 77/29 95/23 77/19 1/17 11/13 13/11 15/14 15/2 55/1)

A partire da n = 2, questo programma genera la seguente sequenza di numeri interi:

2, 15, 825, 725, 1925, 2275, 425, 390, 330, 290, 770, ...

Dopo 2, questa sequenza contiene le seguenti potenze di 2:

2^2 = 4, 2^3 = 8, 2^5 = 32, 2^7 = 128, 2^11 = 2048
2^13 = 8192, 2^17 = 131072, 2^19 = 5244288, ...

in cui le potenze rappresentano i numeri primi.

Rappresentiamo il programma Fractran come una lista:

(setq primegame '((17L 91L) (78L 85L) (19L 51L) (23L 38L) (29L 33L)
(77L 29L) (95L 23L) (77L 19L) (1L 17L) (11L 13L) (13L 11L) (15L 14L) (15L 2L) (55L 1L)))

La funzione "fractran" prende il programma e un valore iniziale e restituisce il prossimo valore oppure si ferma se non viene trovato alcun valore intero.

(define (fractran prog n)
  (local (value stop)
    (setq stop nil)
    (dolist (el prog stop)
      (setq value (/ (* (first el) n) (last el)))
      (cond ((null? prog) (setq stop true))
            ((= 0 (% (* (first el) n) (last el)))
                (setq stop true))))
    value))

Nota: Poichè i numeri superano presto il limite degli interi a 64 bit dobbiamo utilizzare i big-integer.

La funzione "run" esegue l'intero programma fractran:

(define (run program start step)
  (dotimes (x step)
    (println start)
    (setq start (fractran program start)))
  'stop)

Proviamo ad eseguire il programma fractran:

(run primegame 2L 10)
;-> 2L
;-> 15L
;-> 825L
;-> 725L
;-> 1925L
;-> 2275L
;-> 425L
;-> 390L
;-> 330L
;-> 290L
;-> stop

Per estrarre i numeri primi occorre verificare se un dato numero intero è una potenza di due.

Definiamo due funzione "ipow" (calcola la potenza intera di un numero) e "ilog" (calcola il logaritmo intero di un numero):

(define (ipow x n)
  (cond ((zero? n) 1)
        ((even? n) (ipow (* x x) (/ n 2)))
        (true (* x (ipow (* x x) (/ (- n 1) 2))))))

(define (ilog n b)
  (if (zero? n) -1
    (+ (ilog (/ n b) b) 1L)))

Un numero n è potenza di due se risulta:

(= n (ipow 2 (ilog n 2)))

(= 1122 (ipow 2 (ilog 1122 2)))
;-> nil
(= 4096 (ipow 2 (ilog 4096 2)))
;-> true

Adesso possiamo scrivere la funzione "run2" che estre i numeri primi:

(define (run2 program start step)
  (dotimes (x step)
    (if (= start (ipow 2 (ilog start 2)))
      (print (ilog start 2) {, }))
    (setq start (fractran program start)))
  'stop)

Eseguiamo il programma per generare i numeri primi:

(run2 primegame 2L 1e6)
;-> 1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, stop

Conway è un ragazzo molto "cattivo" :-)

Da ralph.ronnquist:

(define (run2 program start step)
  (dotimes (x step)
    (let (b (bits x))
       (or (find "1" (1 b)) (print (dec (length b)) ", ")))
    (setq start (fractran program start)))
  'stop)

(run2 primegame 2 100)
;-> 0, 0, 1, 2, 3, 4, 5, 6 stop
(run2 primegame 2 1e6)
;-> 0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, stop

Purtroppo la funzione "bits" non funziona con i big integer.

Allora usiamo la seguente funzione:

; Compute "bits" for bigint and int
(constant 'MAXINT (pow 2 62))
(define (prep s) (string (dup "0" (- 62 (length s))) s))
(define (bitsL n)
    (if (<= n MAXINT) (bits (int n))
      (string (bitsL (/ n MAXINT))
              (prep (bits (int (% n MAXINT)))))))


----------------------------
La funzione map semplificata
----------------------------

Definiamo una funzione che simula la funzione "map". Per semplificare esaminiamo solo la situazione unaria, cioè scriveremo una funzione "mappa" che applica una funzione unaria (es. sin, log, ecc.) ad una sola lista.

(define (mappa func lst)
  (if (null? lst) '()
      (cons (func (first lst)) (mappa func (rest lst)))))

(mappa sin '(3 4 5))
;-> (0.1411200080598672 -0.7568024953079282 -0.9589242746631385)

(mappa sqrt '(4 9 25))
;-> (2 3 5)

Possiamo anche applicare una funzione lambda definita dall'utente:

(mappa (fn(x) (* x x)) '(2 3 5))
;-> (4 9 25)


-----------------------------------------------
Generazione della documentazione con newLISPdoc
-----------------------------------------------

Vediamo come sia possibile generare automaticamente la documentazione per le funzioni (sorgenti) di un modulo creato dall'utente.
Supponiamo di voler creare un modulo con due funzioni per la conversione da gradi Celsius a gradi Fahrenheit e viceversa.

Questo è il contenuto del file "doc-demo.lsp":

;; @module doc-demo.lsp
;; @author X Y, xy@doc-demo.com
;; @version 1.0
;;
;; Questo modulo è un esempio per mostrare
;; il funzionamento del programma newlispdoc
;; che genera automaticamente documentazione
;; per i sorgenti newLISP.

;; @syntax (demo:celsius->fahrenheit gradi-celsius)
;; @param <gradi-celsius> valore in gradi Celsius.
;; @return restituisce il valore in gradi Fahrenheit.
;;
;; La funzione 'celsius->fahrenheit' converte
;; i gradi Celsius in gradi Fahrenheit.
;;
;; @example
;; (celsius->fahrenheit 0)        ==> 32
;; (celsius->fahrenheit 100)      ==> 212
;; (celsius->fahrenheit -273.15)  ==> -459.67

; Creiamo le funzioni in un nuovo contesto
(context 'demo)

(define (celsius->fahrenheit gradi-celsius)
  (add (div (mul gradi-celsius 9) 5) 32))

;; @syntax (demo:fahrenheit->celsius gradi-fahrenheit)
;; @paramn <gradi-fahrenheit> valore in gradi Fahrenheit.
;; @return restituisce il valore in gradi Celsius.
;;
;; The function 'celsius->fahrenheit' converte
;; i gradi Celsius in gradi Fahrenheit.
;;
;; @example
;; (fahrenheit->celsius 32)       ==> 0
;; (fahrenheit->celsius 212)      ==> 100
;; (fahrenheit->celsius -459.67)  ==> -273.15

(define (fahrenheit->celsius gradi-fahrenheit)
  (div (mul (sub gradi-fahrenheit 32) 5) 9))

; Ritorniamo al contesto principale
(context MAIN)
; eof ;

Adesso creiamo una cartella (es. doc-demo) in cui copiamo questo file "doc-demo.lsp" e il file "newlispdoc" (c:\newlisp\util\newlispdoc). Poi apriamo il Command Prompt, ci posizioniamo sulla cartella, e digitiamo la seguente riga di comando:

newlisp newlispdoc doc-demo.lsp

Adesso nella cartella troviamo anche i file "index.html" e "doc-demo.lsp.html" che sono la documentazione al nostro modulo.

Se digitiamo il seguente comando:

newlisp newlispdoc -s doc-demo.lsp

viene creato anche il file "doc-demo.lsp.src.html" che è il sorgente (evidenziato) del nostro modulo in formato HTML.

Per maggiori informazioni consultare l'Appendice su newlispdoc.

Per testare il nostro modulo dobbiamo prima caricarlo nella sessione di newLISP:

(load "doc-demo.lsp")
MAIN

Adesso possiamo usare le due funzione definite nel modulo:

(demo:fahrenheit->celsius 32)
;-> 0

(demo:celsius->fahrenheit 100)
;-> 212


-----------------------
Ancora sui numeri primi
-----------------------

Queste sono cinque funzioni simili che verificano se un numero è primo.

(define (primo? n)
   (if (< n 2) nil
       (= 1 (length (factor n)))))

(define (primoa? n)
  ; il numero viene considerato primo 
  ; fino a che non troviamo un divisore preciso
  (setq out true) 
  (cond ((<= n 3) (setq out true))
        ((or (= (% n 2) 0) (= (% n 3) 0)) (setq out nil))
        (true (setq i 5)
              (while (and (<= (* i i) n) out)
                (if (or (= (% n i) 0) (= (% n (+ i 2)) 0)) (setq out nil))
                (setq i (+ i 6))
              ))) out)

(define (primob? n)
  (local (idx step out)
    (setq out true)
    (cond ((or (= n 2) (= n 3)) true)
          ((or (< n 2) (= (% n 2) 0) (= (% n 3) 0)) nil)
          (true
            (setq idx 5 step 2)
            (while (and (<= (* idx idx) n) out)
              (if (= 0 (% n idx)) (setq out nil))
              (setq idx (+ idx step))
              (setq step (- 6 step ))
            )
            out))))

(define (primoc? n)
  (local (r f test)
    (setq test true)
    (cond ((= n 1) nil)
          ((< n 4) true) ; 2 e 3 sono primi
          ((even? n) nil)
          ;((= (% n 2) 0) nil)
          ((< n 9) true) ; abbiamo già escluso 4,6 e 8
          ((= (% n 3) 0) nil)
          (true
              (setq r (floor (sqrt n)))
              (setq f 5)
              (while (and test (<= f r))
                (if (= (% n f) 0) (setq test nil))
                (if (= (% n (+ f 2)) 0) (setq test nil))
                (++ f 6)
              )
              test))))

(define (primod? n)
  (let ((out true)
        (i 0)
        (w 0)
        (r 0))
    (cond ((= n 1) (setq out nil))
          ((= n 2) (setq out true))
          ((= n 3) (setq out true))
          ((zero? (% n 2)) (setq out nil))
          ((zero? (% n 3)) (setq out nil))
          (true
            (setq i 5)
            (setq w 2)
            (setq r (floor (sqrt n)))
            (while (and out (<= i r))
              (if (zero? (% n i)) (setq out nil))
              (++ i w)
              (setq w (- 6 w))
            )
          )
    )
   out))

Controlliamo che le funzioni diano i risultati corretti:

(= (map primo? (sequence 2 500000)) (map primoa? (sequence 2 500000)))
;-> true
(= (map primo? (sequence 2 500000)) (map primob? (sequence 2 500000)))
;-> true
(= (map primo? (sequence 2 500000)) (map primoc? (sequence 2 500000)))
;-> true
(= (map primo? (sequence 2 500000)) (map primod? (sequence 2 500000)))
;-> true

Vediamo la velocità delle funzioni:

(time (map primo? (sequence 1 1000000)))
;-> 1109.48
(time (map primoa? (sequence 1 1000000)))
;-> 3984.891
(time (map primob? (sequence 1 1000000)))
;-> 6172.891
(time (map primoc? (sequence 1 1000000)))
;-> 3552.159
(time (map primod? (sequence 1 1000000)))
;-> ;-> 5063.098

La funzione più veloce è quella che usa la funzione "factor".

Se invece dobbiamo calcolare i primi n numeri primi, una routine ad hoc è più veloce dell'utilizzo di "factor", perchè non dobbiamo fattorizzare il numero, ma ci fermiamo quando troviamo un divisore del numero:

(define (primi-fino1 n)
  (setq lst '(2))
  (for (i 3 n 2)
    (if (primo? i) (push i lst -1))) lst)

(define (primi-fino2 n)
   (setq arr (array (+ n 1)) lst '(2))
   (for (x 3 n 2)
      (when (not (arr x))
         (push x lst -1)
         (for (y (* x x) n (* 2 x) (> y n))
            (setf (arr y) true)))) lst)

(= (primi-fino1 1000000) (primi-fino2 1000000))
;-> true

(time (primi-fino1 1e6))
;-> 656.265
(time (primi-fino2 1e6))
;-> 203.137

La funzione che non usa "factor" è più veloce.

Infine, una funzione di Kazimir Majorinc per calcolare quanti numeri primi ci sono fino a n.

(setq sieve (lambda(size)
              (let ((flags (array (+ size 1)))
                    (sqrtsize (sqrt size))
                    (total 0))
                   (for (i 2 sqrtsize)
                     (when (not (flags i))
                           (for (k (* i i) size i)
                             ;(nth-set (flags k) 0))
                             (setf (flags k) 0))
                           (inc total)))
                   (for (i (+ sqrtsize 1) size)
                     (unless (flags i)
                             (inc total)))
                   total)))

(sieve 10)
;-> 4
(sieve 100)
;-> 25
(sieve 1000)
;-> 168
(sieve 10000)
;-> 1229
(sieve 1e7)
;-> 664579


----------------------------------------
Un algoritmo: matrice con somme positive
----------------------------------------

Supponiamo di avere una matrice N x M di numeri interi positivi e negativi. Le operazioni possibili sono:
1) cambiare di segno a tutti i numeri di una riga
2) cambiare di segno a tutti i numeri di una colonna

Determinare (se esiste) un algoritmo che utilizzando soltanto le operazioni 1) e 2) rende positiva la somma di ogni riga e ogni colonna della matrice (consideriamo positiva una somma con valore zero).

In genere un algoritmo è un insieme finito di operazioni possibili applicati ad una "situazione iniziale" per trasformarla in una "situazione finale" (quella desiderata).

Quando sviluppiamo un algoritmo dobbiamo rispondere alle seguenti domande:

1) Esiste un insieme finito di operazioni che risolve il problema?

2) Qual'è l'insieme di operazioni che risolve il problema?

Durante l'applicazione delle operazioni la "situazione iniziale" cambia stato numerose volte prima di raggiungere (eventualmente) la "situazione finale": come possiamo essere certi che ogni stato successivo è "migliore" di quello precedente? Quanto ci avviciniamo alla soluzione ad ogni passo?

Nota: per evitare il Paradosso di Zenone (tanti piccoli passi che diminuiscono di valore e non raggiungono mai la meta finale), si può definire un valore minimo P di miglioramento che deve essere affettuato ad ogni passo.

Per il nostro problema possiamo fare la seguente osservazione:

Se una riga (o colonna) ha una somma negativa, allora cambiando il segno a tutti i numeri di quella riga (o colonna) la somma diventa positiva, ma modifichiamo anche le somme delle altre colonne (righe).

Come possiamo essere sicuri di aver migliorato la situazione dopo ogni passo (cioè dopo aver cambiato di segno ad una riga o ad una colonna)?

Per rispondere a questa domanda pensiamo alla somma di tutti i numeri della matrice. Questa è uguale alla somma delle righe o alla somma delle colonne:

ST = Somma Totale = Somma delle Righe = Somma delle Colonne

Quando modifichiamo una riga con somma negativa -S, otteniamo una riga con somma S. Quindi incrementiamo la Somma Totale (ST) di un valore pari a 2*S. Poichè esiste un numero finito di valori di ST (al massimo 2^(n+m)) e ST aumenta sempre ogni volta che cambiamo una riga (o una colonna) negativa, allora dobbiamo per forza raggiungere, alla fine, una situazione in cui tutte le somme delle righe e delle colonne sono positive.

L'algoritmo quindi esiste ed è il seguente:

Per ogni riga (o colonna) della matrice:
se la somma è negativa, allora invertire il segno di tutti i numeri (che rende la somma positiva)

Scriviamo adesso le funzioni necessarie per risolvere il problema.

Genera un numero intero casuale n nell 'intervallo [a..b] (cioè, a <= n <= b):

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1)))
)

Genera una matrice N x M con numeri interi casuali compresi tra "a" e "b":

(define (genera-matrice m n a b)
  (array m n (map (fn(x) (rand-range a b)) (sequence 1 (* a b)))))

(setq m (genera-matrice 5 4 -10 10))
;-> ((2 3 7 7) (3 5 1 -3) (-7 5 1 9) (-5 -7 2 4) (2 -3 0 -9))

(setq m '((2 3 7 7) (3 5 1 -3) (-7 5 1 9) (-5 -7 2 4) (2 -3 0 -9)))

Calcola la somma della riga di una matrice (passate come argomento):

(define (sum-row matrice riga) (apply + (matrice riga)))

(sum-row m 0)
;-> 19

Calcola la somma della colonna di una matrice (passate come argomento):

(define (sum-col matrice col) (apply + ((transpose matrice) col)))

(sum-col m 0)
;-> -5

Cambia il segno di ogni numero della riga di una matrice (passate come argomento):

(define (flip-row matrice riga)
  (for (i 0 (- (length (matrice riga)) 1))
    (setf (matrice riga i) (- (matrice riga i)))) matrice)

(setq m (flip-row m 2))
;-> ((2 3 7 7) (3 5 1 -3) (7 -5 -1 -9) (-5 -7 2 4) (2 -3 0 -9))

Cambia il segno di ogni numero della riga di una matrice (passate come argomento):

(define (flip-col matrice col)
  (for (i 0 (- (length matrice) 1))
    (setf (matrice i col) (- (matrice i col)))) matrice)

(setq m (flip-col m 0))
;-> ((-2 3 7 7) (-3 5 1 -3) (-7 -5 -1 -9) (5 -7 2 4) (-2 -3 0 -9))

Controlla se una matrice ha somma positiva per tutte le righe e tutte le colonne:

(define (check-sum matrice)
    (let (out true)
      (for (i 0 (- (length matrice) 1)) ; righe
        (if (< (sum-row matrice i) 0) (setq out nil)))
      (for (i 0 (- (length (matrice 0)) 1)) ; colonne
        (if (< (sum-col matrice i) 0) (setq out nil)))
      out))

(check-sum m)
;-> nil

La funzione finale che risolve il problema:

(define (solve matrice)
  (until (check-sum matrice)
    (print 'r)
    (for (i 0 (- (length matrice) 1)) ; righe
      (if (< (sum-row matrice i) 0) (setf matrice (flip-row matrice i))))
    (print 'c)
    (for (i 0 (- (length (matrice 0)) 1)) ; colonne
      (if (< (sum-col matrice i) 0) (setf matrice (flip-col matrice i)))))
    matrice)

(setq m (genera-matrice 5 4 -10 10))
;-> ((1 -3 10 3) (-7 -3 -8 5) (9 2 -10 -4) (-9 3 -8 7) (8 2 5 7))

(setq m '((1 -3 10 3) (-7 -3 -8 5) (9 2 -10 -4) (-9 3 -8 7) (8 2 5 7)))

(setq sol (solve m))
;-> rc((1 3 10 3) (7 -3 8 -5) (-9 2 10 4) (9 3 8 -7) (8 -2 5 7))

(check-sum sol)
;-> true

Con matrici più grandi dobbiamo invertire diverse righe e colonne prima di arrivare alla soluzione:

(setq m (genera-matrice 50 40 -1000 1000))
(silent (setq sol (solve m)))
;-> rcrcrcrc

(check-sum sol)
;-> true

Il numero di inversioni dipende dal numero delle righe, dal numero delle colonne e dal valore dei numeri della matrice (non credo che sia facilmente calcolabile a priori).


------------------
Dadi e probabilità
------------------

Quesito 1
---------
In media, quante volte occorre lanciare un dado prima di ottenere tutti i sei i numeri?

Dal punto di vista matematico il numero medio di lanci vale:

  6   6   6   6   6   6
  - + - + - + - + - + - = 14.7
  6   5   4   3   2   1

(add (div 6 6) (div 6 5) (div 6 4) (div 6 3) (div 6 2) (div 6 1)) = 14.7

Vediamo di simulare l'evento con alcune funzioni:

Funzione per il lancio di un dado:

(define (dado num-dadi num-facce)
  (+ num-dadi (apply + (rand num-facce num-dadi))))

(dado 1 6)
;-> 5

Funzione che conta quante volte bisogna lanciare il dado prima di ottenere tutti i valori:

(define (num-lanci)
  (let ((lst (dup 0 7)) (num 0))
    (until (= (apply + lst) 6)
      (setf (lst (dado 1 6)) 1)
      (++ num))
    num))

(num-lanci)
;-> 18

Funzione che calcola la media del numero dei lanci:

(define (solve iter)
  (let (somma 0)
    (for (i 1 iter)
      (setq somma (+ somma (num-lanci))))
    (div somma iter)))

Proviamo a vedere se otteniamo lo stesso valore (14.7):

(solve 1000)
;-> 14.546

(solve 100000)
;-> 14.69487

(solve 1000000)
;-> 14.703081

Quesito 2
---------
In media, quante volte occorre lanciare contemporaneamente 6 dadi prima di ottenere una mano con tutti i numeri (1,2,3,4,5 e 6) in qualunque ordine?

Dal punto di vista matematico il numero medio di lanci vale:

1   6*5*4*3*2*1
- = ----------- = 0.0154321  ==> n = 64.8
n   6*6*6*6*6*6

(div (pow 6 6) (apply * '(1 2 3 4 5 6))) = 64.8

Vediamo di simulare l'evento con alcune funzioni.

Funzione che conta quante volte bisogna lanciare il dado prima di ottenere tutti i valori:

(define (num-lanci6)
  (let ((lst (dup 0 7)) (num 0))
    (until (= (apply + lst) 6)
      (setq lst (dup 0 7))
      (setf (lst (dado 1 6)) 1)
      (setf (lst (dado 1 6)) 1)
      (setf (lst (dado 1 6)) 1)
      (setf (lst (dado 1 6)) 1)
      (setf (lst (dado 1 6)) 1)
      (setf (lst (dado 1 6)) 1)
      (++ num))
    num))

(num-lanci6)
;-> 18

Funzione che calcola la media del numero dei lanci:

(define (solve6 iter)
  (let (somma 0)
    (for (i 1 iter)
      (setq somma (+ somma (num-lanci6))))
    (div somma iter)))

Proviamo a vedere se otteniamo lo stesso valore (64.8):

(solve6 1000)
;-> 64.477

(solve6 10000)
;-> 63.9149

(solve6 100000)
;-> 64.81573

(solve6 500000)
;-> 64.810948


--------------------
Test Vettori e Liste
--------------------

Creazione di un vettore di 10000 elementi:

(silent (setq vet (array 10000 (sequence 0 9999))))
(length vet)
;-> 10000

Creazione di una lista associativa con 10000 elementi:

(silent (setq lst (map list (sequence 0 9999) (sequence 0 9999))))
(length lst)
;-> 10000

Genera un numero casuale in [a..b]:

(define (rand-range a b)
  (if (> a b) (swap a b))
  (+ a (rand (+ (- b a) 1))))

Test accesso sequenziale:

(time (dolist (el vet) (setq x el)) 1000)
;-> 439.966

(time (dolist (el lst) (setq x el)) 1000)
;-> 995.0391314

Test accesso random:

(time (for (i 0 (- (length vet) 1)) (setq x (vet (rand-range 0 9999)))) 1000)
;-> 3452.562

(time (for (i 0 (- (length lst) 1)) (setq x (assoc (rand-range 0 9999) lst))) 1000)
;-> 204534.455

Modifica di una lista on-place:

(silent (setq lst (sequence 0 9999)))
(time (dolist (el lst) (setf (lst $idx) (* el 2))) 100)
;-> 8299.447

Modifica di un vettore on-place con "dolist":

(silent (setq vet (array 10000 (sequence 0 9999))))
(time (dolist (el vet) (setf (vet $idx) (* el 2))) 100)
;-> 91.947

Modifica di un vettore on-place con "for":

(silent (setq vet (array 10000 (sequence 0 9999))))
(time (for (i 0 (- (length vet) 1)) (setf (vet i) (* (vet i) 2))) 100)
;-> 93.917
Nota: stessa velocità di "dolist", ma con "for" facciamo due accessi ad ogni elemento del vettore (vet i).

Modifica di una lista con lista di appoggio:

(setq lst (sequence 0 9999))
(setq out '())
(time (dolist (el lst) (push (* el 2) out -1)) 1000)
;-> 768.231

Modifica di una lista con "map":

(setq lst (sequence 0 9999))
(time (map (fn(x) (* x 2)) lst) 1000)
;-> 940.893

Somma elementi di una lista con "dolist":

(setq lst (sequence 0 9999))
(setq somma 0)
(time (dolist (el lst) (++ somma el)) 1000)
;-> 555.431

Somma elementi di un vettore con "dolist":

(silent (setq vet (array 10000 (sequence 0 9999))))
(setq somma 0)
(time (dolist (el vet) (++ somma el)) 1000)
;-> 552.455

Somma elementi di un vettore con "for":

(silent (setq vet (array 10000 (sequence 0 9999))))
(setq somma 0)
(time (for (i 0 (- (length vet) 1)) (++ somma (vet i))) 1000)
;-> 620.386

Somma elementi di una lista con "apply":

(setq lst (sequence 0 9999))
(time (apply + lst) 1000)
;-> 169.736

Nota: le funzioni "map" e "apply" non sono applicabili ai vettori.


----------------------------------
Un motore per espressioni regolari
----------------------------------

Nel libro "The Practice of Programming" di Rob Pike e Brian Kernighan viene presentato un programma che implementa un interessante motore per le espressioni regolari.

Il programma gestisce le seguenti regole per le espressioni regolari:

    c    matches any literal character c
    .    matches any single character
    ^    matches the beginning of the input string
    $    matches the end of the input string
    *    matches zero or more occurrences of the previous character

Per maggiori informazioni potete riferirvi all'articolo "A Regular Expression Matcher" disponibile sul web:

https://www.cs.princeton.edu/courses/archive/spr09/cos333/beautiful.html

Sul forum di newLISP rickiboy ha pubblicato una versione del programma in newLISP.

Riportiamo questo elegante programma (grazie rickiboy):

Funzioni ausiliarie:

(define-macro (second)
  (letex (xs (args 0)) (if (> (length xs) 1) (xs 1))))

(define (some pred coll) (and (exists pred coll) true))

Codice del motore per le espressioni regolari:

(define (tails coll)
  (map (curry slice coll) (sequence 0 (- (length coll) 1))))

(define (matchstar c regexp text)
  (some (curry matchhere regexp)
        (filter (fn (xs) (or (= c (first xs)) (= "." c) (empty? xs)))
                (tails text))))

(define (matchhere regexp text)
  (if (empty? regexp) true
      (= "*" (second regexp)) (matchstar (first regexp) (slice regexp 2) text)
      (= "$" regexp) (empty? text)
      (empty? text) false
      (= "." (first regexp)) (matchhere (rest regexp) (rest text))
      (= (first regexp) (first text)) (matchhere (rest regexp) (rest text))))

(define (match* regexp text)
  (if (= "^" (first regexp))
      (matchhere (rest regexp) text)
      (some (curry matchhere regexp) (tails text))))

Vediamo alcuni esempi:

(match* "^a" "apro")
;-> true

(match* ".a" "apro")
;-> nil

(match* "a" "apro")
;-> true

(match* ".ro" "apro")
;-> true

(match* "^a..i" "appi")
;-> true

(match* "f*" "ffi")
;-> true

Veramente impressionante.


---------------------------------
Insiemi (set) senza reinserimento
---------------------------------

Definire una struttura insieme che non permette di aggiungere elementi già cancellati. Ad esempio:
lista = (1 2 3 4 5)
(set-add 3) --> lista = (1 2 3 4 5) ; elemento già presente
(set-add 8) --> lista = (1 2 3 4 5 8)
(set-del 5) --> lista = (1 2 3 4 8)
(set-add 5) --> lista = (1 2 3 4 8) ; elemento cancellato

Definiamo due liste, una contiene gli elementi esistenti e una contiene gli elementi cancellati.

(setq items '())
(setq deleted '())

Funzione per aggiungere gli elementi:

(define (set-add el)
  ;se l'elemento è presente oppure è stato cancellato...
  (if (or (find el items) (find el deleted))
      nil ; non fare nulla
      (push el items -1)) ; altrimenti, aggiunge l'elemento al set
  items)

Funzione per cancellare gli elementi:

(define (set-del el)
  (let (idx -1)
    ; se l'elemento è stato cancellato...
    (if (find el deleted)
        nil ; non fare nulla
        ; se l'elemento si trova nella lista...
        (if (setq idx (find el items))
            ;(pop items (find el items))
            ; eliminalo al set e aggiungilo ai cancellati
            (begin (pop items idx) (push el deleted -1))
            ; altrimenti non fare nulla
            nil))
    items))

Aggiungiamo 10 numeri (0..9) alla lista items:

(dotimes (x 10) (set-add x))
;-> (0 1 2 3 4 5 6 7 8 9)

Cancelliamo i numeri 3 e 5:

(set-del 3)
;-> (0 1 2 4 5 6 7 8 9)

(set-del 5)
;-> (0 1 2 4 6 7 8 9)

Aggiungiamo 15 numeri (0..14):

(dotimes (x 15) (set-add x))
;-> (0 1 2 4 6 7 8 9 10 11 12 13 14)


-------------------------------
Funzioni con parametri nominali
-------------------------------

Possiamo passare dei parametri nominali ad una funzione con la seguente tecnica:

(define (func-par)
  (let (x nil y nil)
    (apply set (args))
    (println "x = " x ", y = " y)))

Possiamo chiamare la funzione soltanto con i parametri x e y:

(func-par 'x 1 'y 2)
;-> x = 1, y = 2

Infatti con altri parametri otteniamo nil:

(func-par 'a 1 'b 2)
;-> x = nil, y = nil

Però possiamo inserire x e y in qualunque ordine:

(func-par 'y 2 'x 1)
;-> x = 1, y = 2

Nota: non possiamo usare "setq" al posto di "set" perchè i parametri non devono essere valutati.

Potremmo usare anche una macro:

(define-macro (funcpar)
  (let (x nil y nil)
    (apply set (args))
    (println "x = " x ", y = " y)))

(funcpar x 1 y 2)
;-> x = 1, y = 2

(funcpar a 1 b 2)
;-> x = nil, y = nil

(funcpar y 2 x 1)
;-> x = 1, y = 2


-------------------------
la funzione COMMAND-EVENT
-------------------------

**************************
>>>funzione COMMAND-EVENT
**************************
sintassi: (command-event sym-event-handler | func-event-handler)
sintassi: (command-event nil)

Specifica una funzione definita dall'utente per la preelaborazione della riga di comando newLISP prima che venga valutata. Questo può essere usato per scrivere shell di newLISP interattive personalizzate e per trasformare richieste HTTP durante l'esecuzione in modalità server.

command-event accetta il simbolo di una funzione definita dall'utente o una funzione lambda. La funzione del gestore eventi (event-handler) deve restituire una stringa oppure la riga di comando verrà passata non tradotta a newLISP.

Per forzare solo un prompt e disabilitare l'elaborazione dei comandi, la funzione deve restituire la stringa vuota "". Per ripristinare il comando-evento, utilizzare la seconda sintassi.

L'esempio seguente fa funzionare la shell newLISP come una normale shell Unix quando il comando inizia con una lettera. Ma iniziando la linea con una parentesi aperta o uno spazio avvia la valutazione di newLISP.

(command-event (fn (s)
	(if (starts-with s "[a-zA-Z]" 0) (append "!" s) s)))

Vedere anche la funzione correlata "prompt-event" che può essere utilizzata per personalizzare ulteriormente la modalità interattiva modificando il prompt newLISP.

Il seguente programma può essere utilizzato autonomo o incluso nel file di avvio init.lsp di newLISP:

#!/usr/local/bin/newlisp

; set the prompt to the current directory name
(prompt-event (fn (ctx) (append (real-path) "> ")))

; pre-process the command-line
(command-event (fn (s)
    (if
        (starts-with s "cd")
        (string " " (true? (change-dir (last (parse s " ")))))
        (starts-with s "[a-zA-Z]" 0)
        (append "!" s)
        true s)))

Nella definizione della funzione di traduzione della riga di comando, il comando "cd" Unix riceve un trattamento speciale, per assicurarsi che la directory venga cambiata  anche per il processo newLISP. In questo modo quando utilizziamo un comando shell con "!" al ritorno, newLISP manterrà il cambio della directory.

Command lines for newLISP must start either with a space or an opening parenthesis. Unix commands must start at the beginning of the line.
Note, that the command line length as well as the line length in HTTP headers is limited to 512 characters for newLISP.

Le righe di comando per newLISP devono iniziare con uno spazio o una parentesi aperta.
I comandi Unix devono iniziare all'inizio della riga.
Si noti che la lunghezza della riga di comando e la lunghezza della riga nelle intestazioni HTTP sono limitate a 512 caratteri in newLISP.

Esempio presentato da Cormullion sul forum di newLISP:

(define (show l)
  (map (fn (f)
    (println (format {%s is %s} (map string (select (facts f) '(0 1)))))) l))

(define-macro (is a b)
  (cond
    ((= a 'who)   (show (ref-all (list '? b) facts match)))
    ((= a 'what)  (show (ref-all (list b '?) facts match)))
    (true         (push (list (sym a) (sym b)) facts))))

(command-event (fn (s)
   (if (find "is " s)
       (string {(is } (replace {is } s {}) {)})
       s)))
;-> $command-event

Adesso possiamo scrivere nella REPL:

mike is tall
;-> ((mike tall))
john is tall
;-> ((john tall) (mike tall))
peter is old
;-> ((peter old) (john tall) (mike tall))
john is old
;-> ((john old) (peter old) (john tall) (mike tall))
what is john
;-> john is old
;-> john is tall
;-> ("john is old" "john is tall")
john is smart
;-> ((john smart) (john old) (peter old) (john tall) (mike tall))
what is john
;-> john is tall
;-> ("john is smart" "john is old" "john is tall")
who is smart
;-> john is smart
;-> ("john is smart")
who is old
;-> john is old
;-> peter is old
;-> ("john is old" "peter is old")
mike is old
;-> ((mike old) (john smart) (john old) (peter old) (john tall) (mike tall))
who is old
;-> mike is old
;-> john is old
;-> peter is old
;-> ("mike is old" "john is old" "peter is old")

Questo funziona come un preprocessore all'interno di un gestore eventi. Quindi, praticamente, il codice tratta tratta "x IS y" come dati e li trasforma in qualcosa di più leggibile.

----------------------------
Massimo Comun Divisore (MCD)
----------------------------
MCD - Massimo Comune Divisore
GCD - Greatest Common Divisor

Vediamo alcune funzioni per calcolare il MCD:

(define (gcd1_ a b)
  (let (r (% b a))
    (if (= r 0) a (gcd1_ r a))))

(define-macro (my-gcd1) (apply gcd1_ (args) 2))

Questo è un semplice algoritmo non ottimizzato per la velocità. Uno migliore è il seguente:

(define (gcd2_ x y , r)
  (while (> y 0)
    (setq r (% x y))
    (if (> r (>> y 1))(setq r (- y r)))
    (setq x y y r)
  )
  x
)

(define-macro (my-gcd2) (apply gcd2_ (args) 2))

Uno ancora migliore è l'algoritmo binario con spostamento a destra. Il codice originale è in linguaggio C preso da un libro di teoria dei numeri, quella che segue è la traduzione in newLISP:

(define (gcd3_ x y , g t)
  (setq g 0)
  (while (~ (& (| x y) 1))
    (setq x (>> x 1)
          y (>> y 1)
          g (+ g 1)
    )
  )
  (while (~ (& x 1))(setq x (>> x 1)))
  (while (~ (& y 1))(setq y (>> y 1)))
  (while (!= x y)
    (if (< x y)
        (setq t x x y y t))
    (setq x (- x y))
    (while (~ (& x 1))
        (setq x (>> x 1)))
  )
  (<< x g)
)

Tuttavia, quando eseguiamo questo programma rimaniamo bloccati in un ciclo infinito.

Probabilmente il ciclo infinito si trova nelle seguenti espressioni:

(while (~ (& x 1))(setq x (>> x 1)))
(while (~ (& y 1))(setq y (>> y 1)))

oppure qui:

(while (~ (& (| x y) 1))

Il linguaggio C considera lo 0 (zero) com un falso logico e il ciclo while esce quando il valore vale 0. In newLISP lo 0 è invece un vero logico, e "~" (tilde) è una negazione binaria (bit flip), non logica. Quindi le espressioni sopra dovrebbero essere scritte nel modo seguente:

(while (= 0 (& x 1)) ...)

oppure:

(while (zero? (& x 1)) ...)

Quindi la versione finale è questa:

(define (gcd3_ x y , g t)
  (setq g 0)
  (while (zero? (& (| x y) 1))
    (setq x (>> x 1)
          y (>> y 1)
          g (+ g 1)
    ))
  (while (zero? (& x 1))(setq x (>> x 1)))
  (while (zero? (& y 1))(setq y (>> y 1)))
  (while (!= x y)
    (if (< x y)
        (setq t x x y y t))
    (setq x (- x y))
    (while (zero? (& x 1))
        (setq x (>> x 1))))
  (<< x g)
)

(gcd3_ 2018478412740 21241241994)
;-> 6

(define-macro (my-gcd3) (apply gcd_ (args) 2))

Per completezza vediamo anche il calcolo del Minimo Comune Multiplo (mcm):

;Returns the least common multiple of two integers x and y.

(define (lcm_ x y)(* x (/ y (gcd x y))))

(define-macro (lcm)(apply lcm_ (args) 2))

Infine vediamo alcuni test di velocità delle funzioni.

(setq number1 (map int (random 1 1e8 10000)))
(setq number2 (map int (random 1 1e8 10000)))

(time (map gcd1_ number1 number2) 100)
;-> 3187.894
(time (map gcd2_ number1 number2) 100)
;-> 2768.187
(time (map gcd3_ number1 number2) 100)
;-> 8453.914

Vediamo la funzione standard "gcd" (che è la più veloce):

(time (map gcd number1 number2) 100)
;-> 281.56


------------------------
Indicizzazione implicita
------------------------
È possibile creare forme implicite di "rest" e "slice" anteponendo alla lista uno o due numeri per indicare l'offset e la lunghezza. Se la lunghezza è negativa, inizia a contare dalla fine della lista:

(set 'lst '(a b c d e f g))
; or as array
(set 'lst (array 7 '(a b c d e f g)))

(1 lst)      → (b c d e f g)
(2 lst)      → (c d e f g)
(2 3 lst)    → (c d e)
(-3 2 lst)   → (e f)
(2 -2 lst)   → (c d e)

; resting and slicing is always on 8-bit char borders
; even on UTF8 enabled versions

(set 'str "abcdefg")

(1 str)      → "bcdefg"
(2 str)      → "cdefg"
(2 3 str)    → "cde"
(-3 2 str)   → "ef"
(2 -2 str)   → "cde"

(setq lst '(a b c d e))

(0 -1 lst)
;-> (a b c d)
lst
;-> (a b c d e)

(chop lst)
;-> (a b c d)
lst
;-> (a b c d e)

(pop lst)
;-> a
lst
;-> (b c d e)

Se credi che l'indicizzazione implicita sia confusa da interpretare, allora puoi creare una funzione:

(define (drop-last var)(0 -1 var))

Quindi:
(drop-last '("a" "b" "c" "d" "e"))
;-> ("a" "b" "c" "d")

Equivalente a:
(chop '("a" "b" "c" "d" "e"))
;-> ("a" "b" "c" "d")


------------------------------------
nil come valore e nil come risultato
------------------------------------

Ricordiamo che la lista vuota non è "true" o "nil":

(nil? '())
;-> nil

(true? '())
;-> nil

(empty? '())
;-> true

(list? '())
;-> true

(= '() '())
;-> true

Ma in un contesto booleano risulta falsa (nil):

(if '() "vero" "falso")
;-> "falso"

Questo fatto ci permette di velocizzare il codice nel modo seguente:

(setq lst '())
;-> ()

La lista vuota non è uguale a "nil" come valore:

(nil? lst)
;-> nil

Ma è considerata falsa (nil) quando è vuota in un contesto booleano:

(if lst (println "vero") (println "falso"))
;-> falso

Questo permette di scrivere:

(time (if lst 'si 'no) 1000000)
;-> 31.247

Che è molto più veloce di:

(time (if (not (empty? lst)) 'si 'no) 1000000)
;-> 62.506

Inoltre, se non è presente alcuna clausola "else" nell'istruzione "if", viene restituita la valutazione della condizione:

(if lst 'si)
;-> ()

Mentre nel secondo caso avremmo:

(if (not (empty? lst)) 'si)
;-> nil

Questa potrebbe essere una distinzione importante quando si controlla il valore di ritorno di una funzione/macro, per distinguere tra un elemento nil restituito oppure il risultato nil come mancata applicazione della funzione/macro. Supponiamo di voler scrivere una macro che elimina l'ultimo oggetto da una lista. Se utilizziamo la primitiva "pop" otteniamo un errore quando viena applicata alla lista vuota:

(setq lst '(a))
;-> (a)
(pop lst -1)
;-> a

Adesso lst è vuota:
lst
;-> ()

Applicando "pop" otteniamo un errore:

(pop lst -1)
;-> ERR: invalid list index in function pop

Con una macro (Lutz) possiamo scrivere:

(macro (drop L) (if L (pop L -1)))
;-> (lambda-macro (L) (expand '(if L (pop L -1))))

(setq lst '(a))
;-> (a)

(drop lst)
;-> a
(drop lst)
;-> ()

In questo caso, quando la lista è vuota "drop" produce una lista vuota e non un errore.


---------------------
Simulare un iteratore
---------------------

Per simulare velocemente un iteratore possiamo utilizare un lista di numeri:

(setq s '(3 2 1))

(pop s) ;-> 3
(pop s) ;-> 2
(pop s) ;-> 1
(pop s) ;-> nil

Per simulare un generatore crescente non possiamo usare "pop" con il parametro -1 (cioè non possiamo togliere l'ultimo elemento) perchè si avrebbe un errore quando la lista è vuota:

(setq s '(3 2 1))

(pop s -1) ;-> 1
(pop s -1) ;-> 2
(pop s -1) ;-> 3
(pop s -1) ;-> ERR: invalid list index in function pop

Quindi usiamo una sequenza inversa:

(setq s '(1 2 3))
(pop s) ;-> 1
(pop s) ;-> 2
(pop s) ;-> 3
(pop s) ;-> nil


-------------------------------
"Don't underrate an iterate..."
-------------------------------

"Non sottovalutate l'iterazione..."
Questa è una legge di Lutz, il creatore di newLISP.
Non sempre dobbiamo usare "dolist" per iterare attraverso una lista.

(setq lst (series 1 2 12))
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048)

(map (fn (n) (apply add n)) (explode lst 3))
;-> (7 56 448 3584)

(dolist (n (explode lst 3)) (println (apply add n)))
;-> 7
;-> 56
;-> 448
;-> 3584

(do-while lst (println (apply add (list (pop lst) (pop lst) (pop lst)))))
;-> 7
;-> 56
;-> 448
;-> 3584

(setq lst (series 1 2 12))
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048)
(map (fn (x) (println (x 0) "-" (x 1) "-" (x 2))) (explode lst 3))
;-> 1-2-4
;-> 8-16-32
;-> 64-128-256
;-> 512-1024-2048
;-> (4 32 256 2048)

(map (curry apply (fn (i j k) (println i "-" j "-" k))) (explode lst 3))
;-> 1-2-4
;-> 8-16-32
;-> 64-128-256
;-> 512-1024-2048
;-> (4 32 256 2048)

Da notare l'opzione "int-reduce" in "apply". Quando "int-reduce" è 2, il comportamento è simile alla funzione "fold" o "reduce", quando è più grande di 2 è ancora più divertente.

(apply (fn(_ a b c)(println a {-} b {-} c)) (cons nil lst) 4)
;-> 1-2-4
;-> 8-16-32
;-> 64-128-256
;-> 512-1024-2048

(apply (fn(_ a b c)(println a b c)) (cons nil (sequence 1 9)) 4)
;-> 123
;-> 456
;-> 789


----------------------------
Simboli che iniziano con "$"
----------------------------

Tutti i simboli che iniziano con il carattere "$" sono sempre definiti in MAIN.
Esempio:
(context 'Demo)
;-> Demo
Demo>
(setq $demo "hi!")
;-> "hi!"
Fred>
(symbols)
;-> ()
Demo>
(context MAIN)
;-> MAIN
(symbols)
;-> (! != $ $0 $1 $10 $11 $12 $13 $14 $15 $2 $3 $4 $5 $6 $7 $8 $9
;->  $args $count $demo $idx $it $main-args $x % & * + ++ , - -- /
;->  : < << <= = > >= >> ? @ Class Demo MAIN NaN? Tree ...)

Spiegazione (Lutz):
I simboli che iniziano con $ sono variabili modificate/gestite da newLISP in MAIN e sono accessibili a livello globale. Le variabili da $0 a $15 vengono utilizzate per contenere informazioni delle espressioni regolari e $0 contiene anche l'espressione di sostituzione per diversi "set" e per la funzione "replace". $idx è l'indice corrente di "dolist". $args contiene l'elenco restituito dalla funzione "args" e $main-args contiene lla lista restituita dalla funzione "main-args". Tutti questi simboli sono globali e tutti, tranne $0 a $15, sono protetti e non possono essere modificati dall'utente. L'utente può impostare da $0 a $15 perché ci sono casi in cui ciò è necessario quando si lavora con espressioni regolari.

Inoltre, i simboli che iniziano con $ non vengono salvati quando si salva un contesto (es. (save 'MyContext) o quando si serializzano nuovi oggetti LISP con la funzione "source".

Nota: il nome di una variabile può iniziare con qualsiasi carattere tranne una cifra numerica o un punto e virgola ";" o il cancelletto "#".
Se il primo carattere è un "+" o "-" nessuna cifra può seguirlo.
Dopodiché può seguire qualsiasi carattere tranne "(" ")" "," ":" """ "'" spazio ";" "#"  che terminerà la variabile.
Un simbolo che inizia con "[" e termina con "]" può contenere qualunque carattere all'interno, ad esempio:

[1 &*$()}]

è un simbolo legale.


-------------------------------
Uso di map nelle liste annidate
-------------------------------

In alcuni casi abbiamo bisogno di applicare una funzione a tutti gli elementi di una lista annidata. Ad esempio, poter scrivere qualcosa del tipo:

(map-all abs '(-1 -2 (-3 -4)))

ed ottenere come risultato (1 2 (3 4)) dove tutti i sotto-elementi vengono elaborati e viene mantenuto l'annidamento della lista originale.

La funzione "map" non è progettata per risolvere questo problema, quindi occorre scrivere una funzione specifica.

(define (map-all f lst)
  (let (result '())
    (dolist (el lst)
      (if (list? el)
        (push (map-all f el) result -1)
        (push (f el) result -1)))
    result))

(map-all abs '(-1 -2 (-3 -4)))
;-> (1 2 (3 4))

(define (doppio x) (* 2 x))

(map-all doppio '(-1 -2 (-3 -4)))
;-> (-2 -4 (-6 -8))

(map-all doppio (map-all abs '(-1 -2 (-3 -4))))
;-> (2 4 (6 8))

(map-all doppio '(((1)) 2 ((3) (4 5 ((6)))) ((6) 7) (8 9)))
;-> (((2)) 4 ((6) (8 10 ((12)))) ((12) 14) (16 18))


------------------------------
Funzioni ordinali con le liste
------------------------------
Ecco alcune funzioni per estrarre elementi da una lista in base alla loro posizione ordinale:

(define (primo lst)   (if (> (length lst) 0) (nth 0 lst) 'nil))
(define (secondo lst) (if (> (length lst) 1) (nth 1 lst) 'nil))
(define (terzo lst)   (if (> (length lst) 2) (nth 2 lst) 'nil))
(define (quarto lst)  (if (> (length lst) 3) (nth 3 lst) 'nil))
(define (quinto lst)  (if (> (length lst) 4) (nth 4 lst) 'nil))
(define (sesto lst)   (if (> (length lst) 5) (nth 5 lst) 'nil))
(define (settimo lst) (if (> (length lst) 6) (nth 6 lst) 'nil))
(define (ottavo lst)  (if (> (length lst) 7) (nth 7 lst) 'nil))
(define (nono lst)    (if (> (length lst) 8) (nth 8 lst) 'nil))
(define (decimo lst)  (if (> (length lst) 9) (nth 9 lst) 'nil))

(primo '())
;-> nil
(primo '(1 2 3))
;-> 1
(decimo '(1 2 3 4 5 6 7 8 9 10))
;-> 10


------------------------
gensym e macro igieniche
------------------------

Nei LISP tradizionali esiste la funzione GENSYM che serve per generare un simbolo nuovo ed univoco. Questa funzione viene utilizzata soprattutto per rendere le macro igieniche.
Comunque in newLISP possiamo ottenere lo stesso scopo ed evitare l'acquisizione variabile, utilizzando la funzione "args" per accedere agli argomenti macro o funzioni:

(define-macro (setq1)
   (set (args 0) (eval (args 1))))

(setq1 x 123)
;-> 123
x
;-> 123

Per il templating possiamo usare le funzioni "expand" e "letex". Ecco un esempio per l'uso di "letex" insieme a una definizione di "gensym":

(define (gensym:gensym)
   (if gensym:count
      (inc gensym:count)
      (setq gensym:count 1))
   (sym (string "gs" gensym:count) MAIN))

(gensym)
;-> gs1
(gensym)
;-> gs2

(define setq2
   (letex (s (gensym) v (gensym))
      (lambda-macro (s v) (set s (eval v)))))

;-> (lambda-macro (gs3 gs4) (set gs3 (eval gs4)))

(setq2 y 456)
;-> 456
y
;-> 456

o per avere un "gensym" ancora più sicuro possiamo usare la funzione "uuid":

(define (gen-sym) (string "gs" (uuid)))

(gen-sym)
;-> "gs7D1365E2-78A6-48A6-8C31-B6034840B528"

La prima funzione genera simboli più leggibili dall'uomo, mentre la seconda è utile per il codice interno alla macchina ed sicuro al 100%. "uuid" da sola genera un stringa ID univoca e universale, utile per gli ID di sessione nella programmazione web ecc.

Per le macro, ciò che funziona meglio la maggior parte delle volte, è semplicemente usare "args" come nel primo esempio.


---------------------------
La variabile anaforica $idx
---------------------------
La variabile interna di sistema $idx (variabile anaforica) tiene traccia dell'indice relativo del ciclo (numero intero). 
$idx è protetta e non può essere modificata dall'utente.
La variabile anaforica $idx viene utilizzata dalle seguenti funzioni: "dolist", "dostring", "doargs", "dotree", "series", "while", "do-while", "until", "do-until", "map". 

Esempi:

(map (fn(x) (list $idx x)) '(a b c))
;-> ((0 a) (1 b) (2 c))

(dolist (el '(a b c)) (print (list $idx el) { }))
;-> (0 a) (1 b) (2 c)

Nota: quando si utilizzano queste funzioni in modo innestato, la variabile $idx fa riferimento sempre al ciclo in cui si trova. Ad esempio:

(define (test)
  (setq lst '((1 2 3) (1 2 3) (1 2 3)))
  (dolist (el lst)
    (setq i 0)
    (while (< i 3)
      (println $idx {-} i)
      (++ i)
    )
  )
)

(test)
;-> 0-0
;-> 1-1
;-> 2-2
;-> 0-0
;-> 1-1
;-> 2-2
;-> 0-0
;-> 1-1
;-> 2-2

Il valore di $idx non è quello della lista, ma quello del ciclo while.
Per usare $idx della lista all'interno del ciclo while occorre utilizzare una variabile ausiliaria (setq idx-lst $idx) ed utilizzare questa all'interno cel ciclo while.

(define (test)
  (setq lst '((1 2 3) (1 2 3) (1 2 3)))
  (dolist (el lst)
    (setq idx-lst $idx)
    (setq i 0)
    (while (< i 3)
      (println idx-lst {-} i)
      (++ i)
    )
  )
)

(test)
;-> 0-0
;-> 0-1
;-> 0-2
;-> 1-0
;-> 1-1
;-> 1-2
;-> 2-0
;-> 2-1
;-> 2-2


--------------------
Gestione dei simboli
--------------------
newLISP fornisce tre funzioni per la gestione dei simboli: "symbols", "symbol?" e "sym".
Vediamo la traduzione delle funzioni dal manuale di newLISP.

*******************
>>>funzione SYMBOLS
*******************
sintassi: (symbols [context])

Quando viene chiamato senza argomento, restituisce una lista ordinata di tutti i simboli nel contesto corrente. Se viene specificato un simbolo di contesto, vengono restituiti i simboli definiti in quel contesto.

*******************
>>>funzione SYMBOL?
*******************
sintassi: (symbol? exp)

Valuta l'espressione exp e restituisce true se il valore è un simbolo. In caso contrario, restituisce nil.

(set 'x 'y)  → y

(symbol? x)  → true 

(symbol? 123)  → nil

(symbol? (first '(var x y z)))  → true

La prima istruzione imposta il contenuto di x sul simbolo y. La seconda istruzione controlla quindi il contenuto di x. L'ultimo esempio controlla il primo elemento di una lista.

***************
>>>funzione SYM
***************
sintassi: (sym string [sym-context [nil-flag]])
sintassi: (sym number [sym-context [nil-flag]])
sintassi: (sym symbol [sym-context [nil-flag]])

Converte il primo argomento di tipo stringa, numero o simbolo in un simbolo e lo restituisce. Se non viene specificato un contesto (opzionale) in sym-context, allora viene utilizzato il contesto corrente durante la ricerca o la creazione dei simboli. I simboli verranno creati solo se non esistono già. Quando il contesto non esiste e il contesto è specificato da un simbolo quotato, viene creato anche il simbolo. Se la specifica di contesto non è quotata, il contesto è il nome specificato o la specifica di contesto è una variabile che contiene il contesto.

sym può creare simboli all'interno della tabella dei simboli che non sono simboli legali nel codice sorgente newLISP (ad es. numeri o nomi contenenti caratteri speciali come parentesi, due punti, ecc.). Ciò rende sym utilizzabile come funzione per l'accesso alla memoria associativa, proprio come l'accesso alla tabella hash in altri linguaggi di scripting.

Come terzo argomento facoltativo, è possibile specificare nil per sopprimere la creazione del simbolo se il simbolo non viene trovato. In questo caso, sym non restituisce nil se il simbolo cercato non esiste. Usando quest'ultima forma, sym può essere usato per verificare l'esistenza di un simbolo.

(sym "some")           → some
(set (sym "var") 345)  → 345
var                    → 345
(sym "aSym" 'MyCTX)    → MyCTX:aSym
(sym "aSym" MyCTX)     → MyCTX:aSym  ; unquoted context

(sym "foo" MyCTX nil)  → nil  ; 'foo does not exist
(sym "foo" MyCTX)      → foo  ; 'foo is created
(sym "foo" MyCTX nil)  → foo  ; foo now exists

Poiché la funzione sym restituisce il simbolo cercato o creato, le espressioni con sym possono essere incorporate direttamente in altre espressioni che usano simboli come argomenti. L'esempio seguente mostra l'uso di sym come una funzione simile all'hash per l'accesso alla memoria associativa, nonché l'utilizzo di simboli che non sono simboli legali nel codice newLISP:

;; using sym for simulating hash tables

(set (sym "John Doe" 'MyDB) 1.234)
(set (sym "(" 'MyDB) "parenthesis open")
(set (sym 12 'MyDB) "twelve")

(eval (sym "John Doe" 'MyDB))  → 1.234
(eval (sym "(" 'MyDB))         → "parenthesis open"
(eval (sym 12 'MyDB))          → "twelve"

;; delete a symbol from a symbol table or hash
(delete (sym "John Doe" 'MyDB))  → true

L'ultima espressione mostra come può essere eliminato un simbolo usando "delete".

La terza sintassi consente di utilizzare i simboli anziché le stringhe per il nome del simbolo nel contesto di destinazione. In questo caso, sym estrae il nome dal simbolo e lo utilizzerà come stringa del nome per il simbolo nel contesto di destinazione:

(sym 'myVar 'FOO)  → FOO:myVar

(define-macro (def-context)
  (dolist (s (rest (args)))
    (sym s (first (args)))))

(def-context foo x y z)

(symbols foo)  → (foo:x foo:y foo:z)

La macro "def-context" mostra come questo potrebbe essere usato per creare una macro che crea contesti e le loro variabili in modo dinamico.

Una sintassi della funzione "context" può anche essere utilizzata per creare, impostare e valutare simboli.

Dopo aver letto la definizione delle tre funzioni, vediamo un esempio per capire come newLISP crea/gestisce i simboli.

Creiamo un contesto:
(context 'demo)

Non ci sono simboli nel contesto demo:
(symbols)
;-> ()

Creiamo il simbolo "aa":
(setq aa 10)
(symbols)
;-> (aa)

La funzione "symbol?" valuta l'argomento e verifica se valuta su un simbolo:

(symbol? aa)
;-> nil 
Il simbolo "aa" non valuta ad un simbolo, ma al numero 10.

Creiamo un altro simbolo "bb":
(setq bb 'aa)
(symbols)
;-> (aa bb)

(symbol? bb)
;-> true
Questa volta il simbolo "bb" viene valutato e otteniamo il simbolo "aa".

Vediamo cosa accade se applichiamo la funzione "symbol?" ad un simbolo che ancora non esiste "cc":

(symbol? cc)
;-> nil

Sembra tutto corretto, ma vediamo i simboli del contesto:
(symbols)
;-> (aa bb cc)

È stato creato il simbolo "cc". Cosa è successo? 
Prima di applicare una funzione newLISP valuta gli argomenti (in questo caso "cc"). Anche se tale valutazione restituisce nil (come in questo caso), newLISP crea comunque un simbolo per la variabile (con valore nil).

Anche quando scriviamo un nome qualunque sulla REPL viene creato un simbolo:

un-nome
;-> nil
(symbols)
;-> (aa bb cc un-nome)

Questo significa che newLISP crea/valuta gli argomenti di ogni funzione prima di applicare la funzione. Quindi, se volessimo sapere se un simbolo esiste nel contesto corrente non possiamo applicare una funzione qualunque (esempio "find") perchè crerebbe il simbolo prima di verificarne l'esistenza e qualunque argomento passato risulta esistente nel contesto:

(symbols)
;-> (aa bb cc un-nome)
(find 'dd (symbols))
;-> 3
(symbols)
;-> (aa bb cc dd un-nome)

Ma allora, come possiamo conoscere se un simbolo esiste in un determinato contesto? 
Dobbiamo usare la funzione "sym":

(sym "var" demo nil)
;-> nil
(symbols)
;-> (aa bb cc dd un-nome)

Il simbolo "var" non esiste nel contesto demo (e non viene neanche creato).
Problema risolto.


