===============

 NOTE LIBERE 1

===============

  śūnyatā

---------------
Perchè newLISP?
---------------

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
10.7.6  2021  minor new functionality and fixed bugs

Indirizzi web:
Home: http://www.newlisp.org
Forum: http://www.newlispfanclub.alh.net/forum/
Downloads: http://www.newlisp.org/downloads/
Development: http://www.newlisp.org/downloads/development/
Moduli: http://www.newlisp.org/modules/

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

Questo metodo è molto comodo quando dobbiamo commentare una grande quantità di codice.

Per commentare una sezione di codice (gruppo di righe) possiamo anche racchiudere la sezione con i caratteri "{" e "}"

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

"There is no single, correct way to format newLISP code.
Do whatever makes it easier for you to understand the code's structure.
Lutz intentionally uses various code formats in the manual to help encourage freedom in this area."

"Non esiste un modo unico e corretto per formattare il codice newLISP.
Fai qualsiasi cosa ti renda più facile comprendere la struttura del codice.
Lutz utilizza intenzionalmente vari formati di codice nel manuale per incoraggiare la libertà in quest'area."

Ogni linguaggio ha un proprio stile generale nella scrittura el codice. Comunque anche ogni programmatore ha uno stile proprio che deriva dalla sua esperienza. Fortunatamente newLISP permette di scrivere con stili diversi basta che si rispetti la sintassi delle liste (parentesi).
Lo stile non è uno standard, ma solo il modo preferito di scrivere e leggere i programmi. Il problema nasce quando diversi programmatori lavorano sullo stesso codice. In questo caso occorrono delle regole comuni per evitare di avere stili diversi nello stesso programma. Poichè newLISP deriva dal LISP vediamo quali indicazioni vengono raccomandate per questo linguaggio (Common LISP) e quanto sono aderenti a newLISP (e comunque sta a voi scegliere quale stile di scittura si adatta di più al vostro modo di programmare).

--- Regole Generali ---

Funzioni di primo ordine
------------------------
Tutte le funzioni di primo ordine devono iniziare dalla colonna 1.

Chiusura parentesi
------------------
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

Per alcuni, il metodo "parentesi chiuse sulla nuova linea" non deve esse usato perchè la lettura dei programmi LISP non deve seguire la corrispondenza delle parentesi, ma seguire l'indentazione. Inoltre  questo metodo richiede più righe per lo stesso codice. In generale, è bene mantenere basso il numero di righe, in modo che la logica del codice sia contenuta in una pagina (o schermata).

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

Questa funzione è utile quando vogliamo salvare qualcosa come file di testo.
Ogni volta che salviamo un file, di default, le interruzioni di riga vengono impostate ad 80 colonne o simili, per esempio:

(setf foo (rand 1000 100))
(save "foo.lsp" 'foo)

foo.lsp:
(set 'foo '(1 563 193 808 585 479 350 895 822 746 174 858 710 513 303 14 91 364 147
  165 988 445 119 4 8 377 531 571 601 607 166 663 450 352 57 607 783 802 519 301
  875 726 955 925 539 142 462 235 862 209 779 843 996 999 611 392 266 297 840 23
  375 92 677 56 8 918 275 272 587 691 837 726 484 205 743 468 457 949 744 108 599
  385 735 608 572 361 151 225 425 802 517 989 751 345 168 657 491 63 699 504))

Se usiamo "pretty-print" possiamo impostare le interruzioni di riga ad un valore maggiore di 80:

(pretty-print 8192 " ")
;-> (8192 " " "%1.16g")

(setf foo (rand 1000 100))
(save "foo.lsp" 'foo)

foo.lsp
(set 'foo '(147 949 141 905 692 303 426 70 966 683 153 877 821 582 191 177 817 475 155 503 732 405 279 568 682 755 721 475 123 367 834 35 517 662 426 104 949 921 549 345 471 374 846 316 456 271 982 297 739 567 195 761 839 397 500 890 27 994 572 50 531 194 843 626 657 197 842 123 109 743 314 941 286 336 140 733 834 707 600 747 252 144 1 61 806 852 210 115 553 14 113 454 752 686 543 73 436 201 696 290))


---------------------------
Gestione di file e cartelle
---------------------------

Vediamo alcune funzioni per gestire file e cartelle (folder/directory). Queste funzioni si basano sulle seguenti primitive:

  change-dir      changes to a different drive and directory
  copy-file       copies a file
  delete-file     deletes a file
  directory       returns a list of directory entries
  file-info       gets file size, date, time, and attributes
  make-dir        makes a new directory
  real-path       returns the full path of the relative file path
  remove-dir      removes an empty directory
  rename-file     renames a file or directory

e i predicati "directory?" e "file?".

Vediamo le definizioni del manuale delle funzioni "directory", "directory?" e "file?".

**********************
>>>funzione DIRECTORY
**********************
sintassi: (directory [str-path])
sintassi: (directory str-path str-pattern [regex-option])

Viene restituita una lista di nomi di cartelle per il percorso specificato in str-path. In caso di fallimento, viene restituito nil. Quando str-path viene omesso, viene restituito l'elenco delle cartelle della cartella corrente.

(directory "/ bin")

(directory "c: /")

Il primo esempio restituisce la cartella di / bin, il secondo restituisce una lista di cartelle della cartella  principale (root) dell'unità C:. Notare che sui sistemi MS Windows, è possibile includere una barra (/) nei nomi dei percorsi. Quando viene usata, una barra rovesciata (\) deve essere preceduta da una seconda barra rovesciata (\\).

Nella seconda sintassi, directory può accettare un modello di espressione regolare in str-pattern. Solo i nomi di file che corrispondono al modello verranno restituiti nella lista delle cartelle. In regex-option, possono essere specificate opzioni di espressioni regolari speciali (vedi regex per i dettagli).

(directory "." "\\. c") → ("foo.c" "bar.c")
;; o utilizzando le parentesi graffe come delimitatori del modello di stringa
(directory "." {\ .c}) → ("foo.c" "bar.c")

; mostra solo i file nascosti (che iniziano con il punto)
(directory "." "^ [.]") → ("." ".." ".profile" ".rnd" ".ssh")

L'espressione regolare forza la directory a restituire solo i nomi di file contenenti la stringa ".c".

; tutte le cartelle e i file tranne "." e "..":
(directory "./" "[^.\*]" 0)

***********************
>>>funzione DIRECTORY?
***********************
sintassi: (directory? str-path)

Controlla se str-path è una cartella. Restituisce true o nil a seconda del risultato.

(directory? "/etc")
;-> true
(directory? "/usr/local/bin/emacs/")
;-> nil

*****************
>>>funzione FILE?
*****************
syntax: (file? str-path-name [bool])

Verifica l'esistenza di un file in str-name. Restituisce true se il file esiste, in caso contrario, restituisce nil. Questa funzione restituirà true anche per le cartelle. Se il valore facoltativo bool è true, il file non deve essere una cartella e viene restituito str-path-name o nil se il file è una cartella. L'esistenza di un file non implica nulla sulle sue autorizzazioni di lettura o scrittura per l'utente corrente.

(if (file? "afile") (set 'fileNo (open "afile" "read")))

(file? "/usr/local/bin/newlisp" true)
;-> "/usr/local/bin/newlisp"
(file? "/usr/bin/foo" true)
;-> nil
-------------------------------------------------------------------

Per vedere la cartella corrente della REPL di newLISP:

(real-path)
;-> f:\\Lisp-Scheme\\newLisp\\MAX

Per cambiare la cartella corrente della REPL di newLISP:

(change-dir "c:\\util")
;-> true

(change-dir "c:/util")
;-> true

Verifichiamo:

(real-path)
;-> c:\\util

Ritorniamo alla cartella precedente:

(change-dir "f:\\Lisp-Scheme\\newLisp\\MAX")
;-> true

(change-dir "f:/Lisp-Scheme/newLisp/MAX")
;-> true

La funzione "show-tree" mostra tutti i file e le cartelle ricorsivamente a partire da un cartella predefinita:

(define (show-tree dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (show-tree (append dir "/" nde))
          (println (append dir "/" nde)))))

(show-tree "f:\\Lisp-Scheme\\newLisp\\MAX")

(show-tree "c:/")

Possiamo anche inserire un contatore per il livello delle cartelle:

(define (show-tree dir counter)
 (dolist (nde (directory dir))
   (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
        (show-tree (append dir "/" nde) (+ counter 1))
        (println counter ": "(append dir "/" nde)))))

(show-tree "c:/Borland" 0)
;-> 0: c:/Borland/.
;-> 0: c:/Borland/..
;-> 1: c:/Borland/BCC55/.
;-> 1: c:/Borland/BCC55/..
;-> 2: c:/Borland/BCC55/Bin/.
;-> 2: c:/Borland/BCC55/Bin/..
;-> 2: c:/Borland/BCC55/Bin/bcc32.cfg
;-> 2: c:/Borland/BCC55/Bin/bcc32.exe

La funzione primitiva "env" recupera il valore di una variabile d'ambiente del s.o.:

(env "PATH")
;-> "c:\\Program Files (x86)\\Common Files\\..."
(env "USERNAME")
;-> "u42"
(env "PATH")
;-> "c:\\Program Files (x86)\\Common Files\\..."

(env "newLISPDIR")
;-> "C:\\newlisp"
(show-tree (env "newLISPDIR"))

La funzione "show-dir" mostra tutte le cartelle della cartella passata come parametro:

(define (show-dir dir)
  (dolist (nde (directory dir))
    (if (and (directory? (append dir "/" nde)) (!= nde ".") (!= nde ".."))
          (if (directory? (append dir "/" nde))
            (println (append dir "/" nde))))))

(show-dir (env "newLISPDIR"))
(show-dir (real-path))

La funzione "show-file" mostra tutti i file e le cartelle della cartella passata come parametro:

(define (show-file dir)
  (dolist (nde (directory dir))
    (println (append dir "/" nde))))

(show-file (env "newLISPDIR"))
(show-file (real-path))

Per visualizzare/filtrare solo determinati file possiamo usare la funzione seguente:

(filter (fn (f) (ends-with f ".ahk")) (directory))
;-> ("npp-newlisp.ahk" "test.ahk" "_npp-newlisp.ahk" "_vscode.ahk")

(filter (fn (f) (ends-with f ".ahk")) (directory))

Oppure possiamo usare i comandi della shell in due modi:

(exec "dir *.ahk /b")
;-> ("npp-newlisp.ahk" "test.ahk" "_npp-newlisp.ahk" "_vscode.ahk")

(exec "cmd /c dir *.ahk /b")
;-> ("npp-newlisp.ahk" "test.ahk" "_npp-newlisp.ahk" "_vscode.ahk")

Per estrarre il percorso completo di un file:

Unix
(join (chop (parse (real-path "_TODO.txt") "/")) "/")

Windows
(join (chop (parse (real-path "_TODO.txt") "\\")) "\\")
;-> "f:\\Lisp-Scheme\\newLisp\\MAX"

Per creare cartelle (anche annidate) possiamo usare la funzione "makedir":

(define (makedir path)
  (let (old-path (real-path))
        (dolist (p (parse path "/"))
                (make-dir p)
                (change-dir p))
        (change-dir old-path)))

(makedir "one/two/three")
;-> true

Oppure la funzione "mkdirs":

(define (mkdirs path  p)
  (dolist (l (parse path "/"))
    (push l p -1)
    (unless (empty? l) (make-dir (join p "/")))))

(mkdirs "/uno/due/tre")
;-> true

(mkdirs "uno/due/tre")
;-> true

Per cambiare cartella partendo dal percorso di un file:

(define (.. f)
  (join (chop (parse (real-path f) "\\") 2) "\\") )

(define (. f)
  (join (chop (parse (real-path f) "\\") 1) "\\") )

Adesso possiamo cambiare la cartella in due modi:

(change-dir (.. "f:\\Lisp-Scheme\\newLisp\\MAX\\_TODO.txt"))
;-> true
(real-path)
;-> "f:\\Lisp-Scheme\\newLisp"

(change-dir (. "f:\\Lisp-Scheme\\newLisp\\MAX\\_TODO.txt"))
;-> true
(real-path)
;-> "f:\\Lisp-Scheme\\newLisp\\MAX"

Per verificare se una cartella è vuota:

(define (empty-dir? path-to-check)
  (empty? (clean (lambda (x) (or (= "." x) (= ".." x))) (directory path-to-check)))
)

Per verificare se un file esiste all'interno della cartella corrente:

(define (file-exists? file bool) (file? file bool))

(file-exists? "_TODO.txt")
;-> true
(file-exists? "O.txt")
;-> nil
(file-exists? "_TODO.txt" true)
;-> "_TODO.txt"

Per verificare se una cartella esiste all'interno della cartella corrente:

(define (directory-exists? folder) (directory? folder bool))

(directory-exists? "newLISP-Note")
;-> true
(directory-exists? "newLISP-No")
;-> nil
(directory-exists? "MAX")
;-> nil

Per ottenere informazioni su un file o su una cartella usiamo la funzione primitiva "file-info".

**********************
>>>funzione FILE-INFO
**********************
sintassi: (file-info str-name [int-index [bool-flag]])

Restituisce una lista di informazioni sul file o sulla cartella in str_name. L'indice facoltativo int-index specifica il membro della lista da restituire. Quando non viene specificato alcun bool-flag o quando il bool-flag vale nil, vengono restituite informazioni sul collegamento se il file è un collegamento a un file originale. Se bool-flag è diverso da nil, allora vengono restituite le informazioni sul file originale a cui fa riferimento il collegamento.

Offset  Contents
------  --------
  0     size
  1     mode (differs with true flag)
  2     device mode
  3     user ID
  4     group ID
  5     access time
  6     modification time
  7     status change time

A seconda del flag di bool impostato, la funzione riporta sul collegamento (nessun flag o flag nil) o sul file collegato originale (flag vero).

(file-info ".bashrc")
;-> (124 33188 0 500 0 920951022 920951022 920953074)

(file-info ".bashrc" 0)
;-> 124

Nel secondo esempio, viene recuperata l'ultima data di modifica dello stato per la cartella /etc.

file-info fornisce le statistiche del file (dimensione) per un file collegato, non il collegamento, ad eccezione per il campo mode.

(date (file-info "_TODO.txt" 7))
;-> "Wed May 08 17:07:39 2020"

(file-info "README.md" 0)
;-> 948
(date (file-info "README.md" 5))
;-> "Wed Dec 28 16:01:14 2022"
(date (file-info "README.md" 6))
;-> "Mon Dec 26 20:52:57 2022"
(date (file-info "README.md" 7))
;-> "Fri Feb 19 10:32:29 2021"

Comandi shell
-------------
Se un ! (punto esclamativo) viene inserito come primo carattere sulla riga di comando seguito da un comando di shell, il comando verrà eseguito. Ad esempio, !ls su Unix o !dir su MS Windows mostrerà un elenco della cartella di lavoro corrente. Non sono consentiti spazi tra il ! e il comando della shell. Simboli che iniziano con ! sono ancora consentiti all'interno delle espressioni o sulla riga di comando se preceduti da uno spazio. Nota: questa modalità funziona solo quando è in esecuzione nella shell e non funziona quando si controlla newLISP da un'altra applicazione.

Per uscire dalla shell newLISP su Linux/Unix, premere Ctrl-D. Su MS Windows, digita (esci) o Ctrl-C, quindi il tasto x.

Utilizzare la funzione exec per accedere ai comandi della shell da altre applicazioni o per passare i risultati a newLISP.
Ad esempio, per creare una lista con tutti i file PDF della cartella corrente basta eseguire:

(setq pdfs (exec "dir *.pdf /B /On"))
;-> ("newLISP.pdf" "test.pdf" "nr.pdf")


-------------------
Funzioni come liste
-------------------

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

Nota: Le parole chiave "lambda" e "fn" incorporate come attributi di una liste e non sono simboli, per esempio:

(first (lambda (x) (+ x x)))
;-> (x) ; non lambda

Quando abbiamo una funzione (o una macro) del tipo:

(define (double x) (+ x x))
;-> (lambda (x) (+ x x))

Possiamo accedere facilmente al corpo della funzione (o della macro):

(last double)
;-> (+ x x)

e modificarlo:

(setf (last double) '(+ x x x))
;-> (+ x x x)

double
;-> (lambda (x) (+ x x x))

Eseguendo la funzione viene eseguito il nuovo corpo della funzione:

(double 3)
;-> 9

Il corpo di una funzione è sempre accessibile ed è un oggetto di prima classe (ordine) in newLISP. In Common LISP o Scheme dopo la valutazione delle funzioni e delle macro (define/defun/lambda/) le espressioni che definiscono le funzioni/macro non sono più accessibili e le parole chiave "lambda" o "macro" sono dei simboli come "print", "map", ecc.
In newLISP la parola "lambda" individua un tipo speciale di lista: la "lambda list". Possiamo utilizzare "cons" su di essa o "append" ad essa e valuta su se stessa.
Le macro funzionano in modo molto diverso in newLISP rispetto al Common LISP o Scheme.

Questo è uno dei motivi per cui mi piace newLISP.


----------
4-4 Puzzle
----------

Definire i seguenti numeri:

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

Vediamo cosa accade se utilizziamo una lista con i simboli delle funzioni.

Creiamo due funzioni:

(define (f1 a b) (+ a b))
(define (f2 a b) (- a b))

E poi creiamo una lista con i simboli delle funzioni:

(setq funcs '(f1 f2))
;-> (f1 f2)

Adesso per eseguire le funzioni nella lista delle funzioni occorre utilizzare la funzione "eval":

((eval(funcs 0)) 2 3)
;-> 5

ALtro esempio:

(setq f '(sin cos))

((eval (f 0)) 1)
;-> 0.8414709848078965

Per usarle come nel primo metodo occorre creare la lista delle funzioni con le funzioni vere e proprie invece che il loro simbolo:

(setq funcs (list f1 f2))
;-> ((lambda (a b) (+ a b)) (lambda (a b) (- a b)))

Adesso possiamo chiamare le funzioni senza utilizzare "eval":

((funcs 0) 6 2)
;-> 8
((funcs 1) 6 2)
;-> 4

Possiamo inserire altre funzioni nella lista delle funzioni:

(define (f3 a b) (* a b))

(push f3 funcs -1)
;-> (lambda (a b) (* a b))

funcs
;-> ((lambda (a b) (+ a b)) (lambda (a b) (- a b)) (lambda (a b) (* a b)))

((funcs 2) 6 2)
;-> 12


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

Per compilare questo programma come eseguibile autonomo, occorre salvare il file con un nome (uppercase.lsp) e poi eseguire dal terminale la seguente procedura:

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

Con lo stesso metodo possiamo scrivere altre funzioni di sistema:

CAT
;;  cat
;;  concatena file
;;  c:> cat file1 file2 file3 ... >stdout
;;
;;  cat.make
;;  (load {c:\newlisp\link.lsp})
;;  (link {c:\newlisp\newlisp.exe} "cat.exe" "cat.lsp")

(map (fn (F) (write-line (read-file F))) (rest (main-args)))
(exit)

newlisp -x cat.lsp cat.exe

TAIL
1) legge tutto il file il cui nome è (nth 1 (main-args))
2) parse in linee
3) usa 'slice' per estrarre le ultime (nth 2 (main-args)) linee (come integer)
4) join e print il risultato

;;  tail
;;
(print (join
        (slice
            (parse (read-file (nth 1 (main-args))) "\r\n")
            (- (integer (nth 2 (main-args)))))
        "\r\n"))
(exit)

newlisp -x tail.lsp tail.exe


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

(fibo-i 10)
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

Sequenza OEIS A005478 (numeri di Fibonacci primi):
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

Un altro quine è il seguente:

; Versione originale di PvE:
(define (make-me)
	(println (source 'make-me))
	(println "(println (make-me))")
	(println "(exit)")
	(println ""))
(println (make-me))
;(exit)

; Versione migliorata da Lutz:
(define (quine )
  (println (source 'quine) "(quine)")
  (exit))
(quine)

Vedi anche "Metaquine" su "Note libere 23".


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

Vedi anche "Massimo di tre numeri" su "Note libere 24".


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

Possiamo scrivere la funzione in maniera più concisa:

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

Proviamo a scrivere una funzione automodificante che ad ogni chiamata alterna l'addizione e la sottrazione dei suoi argomenti:

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

Nota: Una funzione definita dall'utente non ha modo di fare riferimento alla funzione da cui è stata invocata, tranne quando ha una sua precedente conoscenza. Quando abbiamo questa necessità, in cui una funzione deve conoscere il nome della chiamante, basta renderla un parametro della chiamata della funzione.

Nota: non modificare le parti della funzione che sono in esecuzione.
Per esempio, il codice seguente produce:

(define (f a (b (define (f a) "D"))) a)
(println (f "A" 1) (f "B") (f "C"))
;-> AnilD

Per produrre "ADD" dobbiamo scrivere:

(define (f a (b (setf (nth 1 f) "D"))) a)
(println (f "A" 1) (f "B") (f "C"))
;-> "ADD"

newLISP è un linguaggio completamente autoriflessivo che può introspezione o modificarsi in fase di esecuzione. Nell' esempio la funzione f sta ridefinendo se stessa durante l'esecuzione. La vecchia definizione della funzione viene mantenuta dalla gestione della memoria e l'esecuzione viene eseguita indirizzando una memoria non valida causando risultati imprevisti o arresti anomali.

Quando le funzioni si modificano, è necessario prestare attenzione a non sostituire parti del codice che sono in esecuzione nello stesso momento.


---------------
I cicli (loops)
---------------

In newLISP sono supportati la maggior parte dei metodi di loop tradizionali.
Ogni volta che esiste una variabile di loop, è locale nell'ambito del loop, comportandosi secondo le regole di scoping dinamico all'interno dello spazio dei nomi o del contesto corrente:

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

Lutz:
-----
The length of a list is not known to 'dolist' (or any other function) when it starts iterating through the list.
Same is true most of the time for the last element.
It is stored sometimes in the envelope cell of the list, but cannot be found there reliably, but only after a previous access to the last cell.

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
Alcune lettere vengono sosituite con delle cifre. In genere si ha la seguente corrispondenza:

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

La nozione di ambito (scope) nei linguaggi di programmazione è tradizionalmente legata a quella delle associazioni (bindings). Un'associazione (binding) è un legame tra un simbolo (o una variabile) e un valore. L'ambito dell'associazione definisce il tipo di"visibilità" del simbolo (o variabile) nel programma e può essere "dinamico" o "lessicale" ("statico").
Secondo l'ambito lessicale (statico), in una espressione, una variabile fa riferimento al costrutto più interno in cui viene dichiarata la variabile (ad esempio, al blocco di codice in cui è definita).
Invece l'ambito dinamico prevede che la variabile esista e possa essere usata solo durante l'estensione dinamica (esecuzione) di una espressione. Una variabile con ambito dinamico viene anche chiamata 'parametro'.
L'associazione dinamica associa i dati all'esecuzione del contesto corrente, e quindi consente di passare i dati alle funzioni senza dover dichiarare esplicitamente questi dati nell'interfaccia della funzione.
Una caratteristica particolare dei binding dinamici è che non sono catturati da una chiusura lessicale (lexical closure). Questo consente alcuni benefici, come la concisione, la modularità e l'adattabilità. Esempi tipici sono il reindirizzamento dell'output di un programma, la definizione di gestori di eccezioni (exception handler), la gestione dello stato dell'host locale in un sistema distribuito, ecc.

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

Un altro esempio un pò più complicato:

(define (myfun2 fun)
	(let (a 20)
		(println (apply fun '()))))

(define (myfun)
	(let (a 10)
		(myfun2 (lambda () (setq a 30)))
		a))

(myfun)
;-> 30
;-> 10

Dobbiamo ragionare in termini di ambito dinamico. Ciò significa che l'applicazione di (lambda()(setq a 30)) non si riferisce al legame di "a" nel punto della definizione di (lambda()(setq a 30)), in questo caso in "myfun", ma al legame di "a" nel punto dell'applicazione, ovvero in "myfun2".

newLISP funziona come il Lisp originale di McCarthy's. Quindi Scheme ha introdotto l'ambito lessicale ed è stato seguito dal Common Lisp (sebbene CL supporti l'ambito dinamico se si dichiarano le variabili locali come speciali). È una delle questioni più controverse dei vari Lisp.

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

Vediamo il perchè della parola "lessicale":
nell'ambito statico, una variabile si riferisce sempre all'associazione di chiusura più vicina (binding). Questa è una proprietà del testo del programma e non è correlata allo stack delle chiamate di runtime. Poiché la corrispondenza di una variabile con l'associazione richiede solo l'analisi del testo del programma, questo tipo di ambito viene chiamato anche "ambito lessicale".

Dal punto di vista storico, newLISP ci comporta come il LISP originale di McCarthy. Poi  Scheme ha introdotto l'ambito lessicale che è stato seguito anche dal Common Lisp (sebbene CL supporti l'ambito dinamico se si dichiarano le variabili locali come speciali). È una delle questioni più controverse nella famiglia dei linguaggi LISP.

Infine riportiamo alcune considerazioni di Lutz:

Per i meno iniziati qui, ecco alcune regole e spiegazioni relative alla cattura delle variabili e ai pericoli percepiti quando non ce ne sono.

- non vi è alcun pericolo di acquisizione di variabili quando si riutilizzano nomi di variabili nelle funzioni nidificate, 'let' ed espressioni di loop nidificati. Tutte le variabili dei parametri vengono salvate internamente su uno stack di ambiente e ripristinate dopo l'uso. Puoi anche fare quanto segue senza pericolo:

(dotimes (i 3) (println "->" i)
    (dotimes (i 3) (println i)))

sebbene il ciclo interno usi lo stesso nome di variabile del ciclo esterno, è totalmente sicuro in newLISP e non sicuro in molte altre lingue.

Lo stesso vale per le funzioni create con 'define'. Anche il seguente codice un pò folle funzionerà perfettamente con 'let' riutilizzando gli stessi nomi di variabili:

(define (foo x y)
   (println x ":" y)
   (let ((x (div x 2)) (y (div y 2)))
      (println x "::" y))
   (println x ":" y))

(foo 3 4)
;-> 3:4
;-> 1.5::2
;-> 3:4
;-> 4 ;restituisce il valore di foo

L'espressione 'let' sa che la x sinistra non è la stessa della x destra. La x sinistra proviene dal 'let' interno e la x destra dal parametro di 'foo'. Dopo aver lasciato 'let' tutto è come prima. Potresti anche chiamare una funzione 'bar' con i nomi dei parametri x e y dall'interno di 'foo' o 'let' e non succederebbe niente di male.

Quando si usano le normali funzioni create con 'define', la cattura variabile può avvenire solo quando si passano simboli tra virgolette. Passare simboli quotati è qualcosa che accade molto raramente in newLISP. Se devi farlo, allora isola quella funzione in un contesto/spazio dei nomi o usa 'args' per recuperare i parametri. Entrambi i metodi sono sicuri contro la cattura delle variabili.

- l'unico vero pericolo di acquisizione variabile si verifica nelle fexpr (define-macro in newLISP). L'uso di qualcosa come "gensym" e "eval" per aggirare il problema funzionerà, ma continuerà a influire sulle prestazioni e ad ogni chiamata verranno creati sempre più simboli da "gensym" e spreco di memoria. Potrebbero essere eliminati dopo l'uso, ma richiederebbero ancora più cicli della CPU. È meglio usare 'args' e non avere alcuna variabile come parametro o racchiudere la macro-funzione e i parametri nel proprio contesto:

(define-macro (foo:foo foo:x foo:y)
   ....
)

; or as an alternative

(context 'foo)
(define-macro (foo x y)
    ...
)
(context MAIN)

; and in either case you can call with the simple name

(foo ...)

'foo' è ora una macro globale (in realtà fexpr) e completamente sicura contro l'acquisizione di variabili, anche quando si passano simboli quoatai. Non si verificano perdite di prestazioni in questo modo, anche quando si scrivono milioni di macro.

- anche qualsiasi altra funzione o macro (fexpr) in un modulo 'foo:this', 'foo:that' è completamente sicuro contro la cattura/confusione variabili, anche quando si passano simboli quotati.

- in ultimo, ma non meno importante: perché newLISP chiama le macro fexprs? Perché dal punto di vista dell'uso vengono utilizzate per ottenere lo stesso risultato: scrivere funzioni che non seguono le solite regole di valutazione dei parametri per la valutazione iniziale di tutti i parametri ma controllano da sole la valutazione dei parametri usando 'eval'. Trovo più utile usare una definizione orientata all'applicazione.

Breve riassunto
---------------

Cos'è l'ambito (scope)?
-----------------------
L'ambito si riferisce ai punti in un programma in cui una variabile è visibile e può essere referenziata.
Una situazione interessante è quando una funzione ha variabili libere.
Consideriamo l'esempio seguente:

(setq x 1)             ; riga 1

(define (f a) (+ a x)) ; riga 2

(define (g)            ; riga 3
  (setq x 2)           ; riga 4
  (f 0))               ; riga 5

(g)                    ; riga 6
Cosa restituisce (g)?

Alla riga 1, creiamo una mappatura per x con valore 1.
Alla riga 2 definiamo una funzione f il cui corpo utilizza il parametro a, ma anche la variabile libera x.
Alla riga 3, definiamo una funzione g, il cui corpo crea una nuova mappatura per x con valore 2, e quindi chiama f(0).
(Si noti che la funzione g (riga 4) non aggiorna la mappatura creata alla riga 1).
Infine, alla riga 6, chiamiamo g().

Quale valore restituisce g quando viene chiamato?
A quale mappatura si riferisce la variabile libera x sulla riga 2?
Si riferisce alla mappatura sulla riga 1 che era visibile quando f è stata definita?
O si riferisce alla mappatura sulla riga 4 che è stata creata poco prima che f fosse chiamata?

Ambito lessicale
----------------
Sotto l'ambito lessicale (noto anche come ambito statico), l'ambito di una variabile è determinato dalla struttura lessicale (cioè testuale) di un programma.

Nell'esempio precedente, la definizione di x sulla riga 1 crea un ambito che inizia dopo la sua definizione e si estende nei corpi di f e g.
Tuttavia, la seconda definizione di x alla riga 4 crea un nuovo ambito che (1) offusca la precedente definizione di x e (2) non si estende alla chiamata f(0) alla riga 5.
Guardando questo da un'altra direzione, l'uso di x alla riga 2 rientra nell'ambito creato dalla definizione alla riga 1, e quindi si riferisce a tale definizione.

Pertanto, in ambito lessicale, il programma di esempio restituisce 1.

La maggior parte dei linguaggi di programmazione che usiamo oggi ha un ambito lessicale.
Intuitivamente, un essere umano (o un compilatore) può determinare l'ambito di una variabile semplicemente esaminando il codice sorgente di un programma.
In altre parole, un compilatore può determinare a quale definizione si riferisce ciascuna variabile, ma potrebbe non essere in grado di determinare i valori di ciascuna variabile.

Ambito dinamico
---------------
Nell'ambito dinamico, una variabile è associata al valore più recente assegnato a quella variabile, ovvero l'assegnazione più recente durante l'esecuzione del programma.

Nell'esempio precedente, la variabile libera x nel corpo di f viene valutata quando f(0) viene chiamato alla riga 5.
A quel punto (durante l'esecuzione del programma), l'assegnazione più recente era alla riga 4.

Pertanto, in ambito dinamico, il programma di esempio restituisce 2.

I linguaggi di programmazione con ambito dinamico includono bash, LaTeX, newLISP e la versione originale di Lisp.
Emacs Lisp ha un ambito dinamico, ma consente al programmatore di selezionare l'ambito lessicale.
Al contrario, Perl e Common Lisp hanno un ambito lessicale per impostazione predefinita, ma consentono al programmatore di selezionare l'ambito dinamico.


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

Questo metodo è meglio perché non è necessario scrivere funzioni aggiuntive per accedere alla somma. Inoltre foo:sum porta in primo piano il qualificatore 'foo'. Infine, ma non meno importante, questo è più facile da capire di una chiusura (closure).

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
    (setq primo:val (or primo:val 1))
    (setq found nil)
    (if (null? dir)
      (setq num (+ primo:val 1))
      (setq num (- primo:val 1))
    )
    (if (< num 2) 
        (setq primo:val 2)
        ;else
        (until found
          (if (primo:isprime? num)
              (setq primo:val num found true)
          )
          (if (null? dir)
            (++ num)
            (-- num)
          )
        )
    )
    primo:val))

Proviamo il tutto:

(primo:start 13)
;-> 13

(primo:print-val)
;-> 13

(primo:isprime? 13)
;-> true

Possiamo usare solo "primo" al posto di "primo:primo" perchè è il funtore del contesto.

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

Poiché pop funziona sia con le liste che con le stringhe, la stessa funzione generatrice può essere utilizzata per generare uno stream di stringhe:

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

Le operazioni di shift aritmetico possono essere utilizzate per dividere o moltiplicare un numero intero.

Lutz:
-----
The left shift << in newLISP is a rotating shift: bits shifted out at the left come in in on the right side, to avoid this do a:

(<< (& 0x7FFFFFFF x) 1) instaed of (<< x 1)

this masks the most left bit to zero.

If you shift 8 bits to the left do a:

(<< (& 0x00FFFFFF crc) 8) instead (<< x 8)

you have to mask all 8 bits on the left, not only 1 as now you are shifing 8 bits.

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

Il metodo Fold utilizza una funzione specificata dall'utente per ridurre una lista di valori a un singolo valore e rappresenta uno degli idiomi fondamentali della programmazione funzionale. "Fold-left" lavora da sinistra a destra attraverso l'elenco xs, applicando la funzione binaria op alla base e al primo elemento di xs, quindi applicando la funzione binaria op al risultato della prima funzione op e del secondo elemento di xs, e così via, applicando ad ogni passo la funzione binaria op al risultato della precedente funzione op e all'elemento corrente di xs. "fold-right" funziona allo stesso modo, ma da destra a sinistra.

Conclusioni
-----------
Il folding (piegamento, noto anche come reduce o accumulate) è un metodo per ridurre una sequenza di termini fino a un singolo termine. Ciò si ottiene fornendo una funzione di folding con un operatore binario, un valore iniziale (o identità) e una sequenza.

Ci sono due tipi di "fold": uno destra e uno sinistra.

(define car first)
(define cdr rest)

Funzione "fold-right":

(define (fold-right f init seq)
  (if (null? seq)
      init
      (f (car seq)
         (fold-right f init (cdr seq)))))

(fold-right + 0 '(1 2 3 4))
; expands to (+ 1 (+ 2 (+ 3 (+ 4 0))))

Funzione "fold-left":

(define (fold-left f init seq)
  (if (null? seq)
      init
      (fold-left f
                 (f init (car seq))
                 (cdr seq))))

(fold-left + 0 '(1 2 3 4))
; expands to (+ (+ (+ (+ 0 1) 2) 3) 4)

Usiamo "fold-left" per definire una funzione che inverte gli elementi di una lista:

 (define (reverse_ lst)
   (fold-left (lambda (x y) (cons y x))
              '()
              lst))

(reverse_ '(1 2 3))
;-> (3 2 1)


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

Allora usiamo la seguente funzione (ralph.ronnquist):

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

Nel libro "The Practice of Programming" di Rob Pike e Brian Kernighan viene presentato un programma che implementa un interessante motore per le espressioni regolari:

  /* match: search for regexp anywhere in text */
  int match(char *regexp, char *text)
  {
      if (regexp[0] == '^')
          return matchhere(regexp+1, text);
      do {    /* must look even if string is empty */
          if (matchhere(regexp, text))
              return 1;
      } while (*text++ != '\0');
      return 0;
  }

  /* matchhere: search for regexp at beginning of text */
  int matchhere(char *regexp, char *text)
  {
      if (regexp[0] == '\0')
          return 1;
      if (regexp[1] == '*')
          return matchstar(regexp[0], regexp+2, text);
      if (regexp[0] == '$' && regexp[1] == '\0')
          return *text == '\0';
      if (*text!='\0' && (regexp[0]=='.' || regexp[0]==*text))
          return matchhere(regexp+1, text+1);
      return 0;
  }

  /* matchstar: search for c*regexp at beginning of text */
  int matchstar(int c, char *regexp, char *text)
  {
      do {    /* a * matches zero or more instances */
          if (matchhere(regexp, text))
              return 1;
      } while (*text != '\0' && (*text++ == c || c == '.'));
      return 0;
  }

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

Comunque a e b hanno i valori passati:

(println a { } b)
;-> 1 2

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


---------------------------
la funzione "command-event"
---------------------------

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

Un'altro è l'algoritmo binario con spostamento a destra. Il codice originale è in linguaggio C preso da un libro di teoria dei numeri, quella che segue è la traduzione in newLISP:

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

Nel Lisp tradizionale (es. Common Lisp), quando si valuta una lista di S-espressioni, il primo elemento nella posizione "functor" deve essere una funzione o un operatore valido. newLisp consente al primo elemento di essere un tipo di simbolo di contesto, una lista, un array o un numero intero.

Indicizzazione delle liste
--------------------------
(setq lst '(a b c d e))
;-> (a b c d e)

(lst 2)
;-> c
(lst 0)
;-> a
(lst 5)
;-> ERR: invalid list index

Per prima cosa assegniamo alla variabile "lst" un elenco di simboli. Quindi utilizziamo la stessa variabile nella posizione "functor" della S-epressione, seguita da un argomento intero. Anche se "lst" non è una "funzione", newLisp valuta questa espressione, trattandola come un'operazione di "indicizzazione", restituendo il terzo elemento della lista (gli indici iniziano da zero). Viene segnalato un errore quando si indicizza oltre la dimensione della lista.

La funzione "nth"
-----------------
Avremmo anche potuto usare la funzione integrata "nth" per accedere all'elemento della lista, ma newLisp supporta la scorciatoia sopra.

(nth 2 lst)
;-> c
(nth 0 lst 0)
;-> a
(nth 5 lst)
;-> ERR: invalid list index

Indicizzazione delle liste annidate
-----------------------------------
Vediamo l'indicizzazione di liste annidate:

(setq lista '(a b (c d) e))
;-> (a b (c d) e)

(lista 2)
;-> (c d)
(lista 2 1)
;-> d
('(1 2 3 4) 0)
;-> 1

Possiamo accedere a un elemento della lista annidata in due modi: con uno o più indici.
L'ultimo esempio mostra che possiamo usare direttamente una lista con valori come primo argomento.

Indicizzazione degli array
--------------------------
Creiamo due array unidimensionali:

(setq vet1 (array 4 (sequence 1 4)))
;-> (1 2 3 4)
(setq vet2 (array 3 '(5 (6 7 8) a)))
;-> (5 (6 7 8) a))

Il secondo array sopra ha un elemento nidificato che contiene 3 elementi.

Possiamo accedere agli elementi dell'array in questo modo:

(vet1 0)
;-> 1
(vet1 3)
;-> 4
(vet2 1)
;-> (6 7 8)
((vet2 1) 0)
;-> 6

Array Multi-Dimensionali
------------------------
Per gli array multi-dimensionali la logica è simile, creiamo un array 2x3:

(setq vet3 (array 2 3 '(1 2 3 4 5 6)))
;-> ((1 2 3) (4 5 6))

Analogamente alle liste annidate (in questo caso gli indici rappresentano riga e colonna):

(vet3 0 1)
;-> 2
(vet3 0)
;-> (1 2 3)

Indici negativi
----------------
È anche possibile utilizzare un indice negativo (l'indice dell'ultimo elemento dell'array vale -1, il penultimo vale -2, ecc.):

(vet3 0 -2)
;-> 2

Indicizzazione delle stringhe
-----------------------------
Le stringhe sono array di caratteri e possiamo utilizzare lo stesso meccanismo di indicizzazione:

(setq str "newLISP")
;-> "newLISP"
(str 3)
;-> "L"
(str -2)
;-> "S"

Slice implicito di una lista
----------------------------
Un'estensione naturale dell'"indicizzazione implicita" che abbiamo visto finora è lo "slicing implicito". Lo Slicing entra in scena quando utilizziamo un numero intero nella posizione "functor":

(setq lst '(a b c d))
;-> (a b c d)

(1 lst)
;-> (b c d)
(1 2 lst)
;-> (b c)

(setq lista '(a b (c d) e))
;-> (a b (c d) e)
(1 2 lista)
;-> (b (c d))
(0 lista)
;-> (a b (c d) e)

La prima espressione restituisce una sottolista a partire dal secondo elemento (1) della lista data.
Un altro argomento intero, se fornito, specifica il numero di elementi da estrarre dalla posizione iniziale.

Slice di array e stringhe
-------------------------
Di seguito viene illustrato lo slicing applicato su array e stringhe:

(2 vet2)
;-> (a)
(1 vet2)
;-> ((6 7 8) a)

(3 4 "newLISP")
;-> "LISP"
(3 "newLISP")
;-> "LISP"

L'indice può essere una variabile
---------------------------------
Per lo slicing possiamo anche usare variabili intere invece dei numeri:

(set 'start 1 'nums 2)
(start nums lista)
;-> (b (c d))

L'indicizzazione implicita è facoltativa (possiamo sempre usare "nth", ecc.), ma è più veloce dell'indicizzazione esplicita.

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

Nota: l'indicizzazione implicita non può usare indici multipli per attraversare tipi diversi (es. liste e stringhe).
Per esempio:

(setq lista '("abc" "efg"))

Per estrarre il carattere "a" della prima stringa della lista non possiamo scrivere:

(lista 0 0)
;-> "abc"

che restituisce il primo elemento della lista, ma dobbiamo scrivere:

((lista 0) 0)
;-> "a"

Oppure:

(first (lista 0))
;-> "a"


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

Per simulare velocemente un iteratore possiamo utilizzare un lista di numeri:

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

(setq lst '(((1)) 2 ((3) (4 5 ((6)))) ((6) 7) (8 9)))
(map-all doppio lst)
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

Nota: "symbol?" ritorna true solo se la valutazione di exp ritorna un simbolo.

(set (sym "var") 345)
;-> 345
(symbol? var)
nil

In questo caso viene ritornato "nil" perchè la valutazione di "var" produce un numero 345 e non un simbolo.

(set 'x 'var)
;-> var

(symbol? x)
;-> true    ; valuta x che è il simbolo var

(symbol? (first '(var x y z)))
;-> true

Se quotiamo l'espressione, allora "symbol?" ritorna sempre "true":
(symbol? 'var)
;-> true

(symbol? 'xxx)
;-> true

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
Problema risolto. Ma forse è meglio scrivere una funzione ad-hoc:

(define (is-sym symbol ctx)
    (sym symbol (context) nil))

(is-sym "non-presente")
;-> nil

Adesso vediamo un esempio di nome speciale per un simbolo, cioè un nome che può essere generato solo utilizzando la funzione "sym".
Le seguenti espressioni generano un errore:

(set '"name" 3)
;-> ERR: symbol expected in function set : '"name"
(set (quote "name") 3)
;->ERR: symbol expected in function set : '"name"

Ma le seguenti sono valide:

(setf '"name" 3)
;-> -> 3
(setq "name" 3)
;-> 3

Però il simbolo "name" non esiste nei simboli di MAIN:

(sym {"name"} MAIN nil)
;-> nil

Allora dobbiamo utilizzare "sym" per poter usare il nome "name" (con i doppi apici) per un simbolo. Creiamo il simbolo:

(set (sym {"name"}) 3)
;-> 3

Vediamo se si trova nei simboli di MAIN:

(sym {"name"} MAIN nil)
;-> "name"

Per recuperare il valore del simbolo utilizziamo "eval":

(eval (sym {"name"}))
;-> 3

Per cancellare un simbolo dobbiamo usare la funzione "delete".

******************
>>>funzione DELETE
******************
sintassi: (delete symbol [bool])
sintassi: (delete sym-context [bool])

Nella prima sintassi elimina un simbolo simbolo e i riferimenti al simbolo che si trovano in altre espressioni vengono posti al valore nil.

Nella seconda sintassi tutti i simboli dello spazio dei nomi (contesto) a cui fa riferimento sym-context verranno eliminati e i riferimenti ad essi che si trovano in altre espressioni verranno posti a nil. Il simbolo di contesto sym-context verrà modificato in un simbolo normale con valore nil.

Quando l'espressione in bool vale true, i simboli vengono eliminati solo quando non sono referenziati in altre espressioni.

Quando l'espressione in bool vale nil, i simboli verranno eliminati senza alcun controllo di riferimento. Si noti che questa modalità deve essere utilizzata solo se non esistono riferimenti al simbolo al di fuori del suo spazio dei nomi. Se esistono riferimenti esterni, questa modalità può causare arresti anomali del sistema, poiché il riferimento esterno non è impostato a nil quando si utilizza questa modalità. Questa modalità può essere utilizzata per eliminare gli hash dello spazio dei nomi e per eliminare gli spazi dei nomi nei sistemi a oggetti, dove le variabili sono trattate come private.

I simboli protetti di funzioni integrate e simboli speciali come nil e true non possono essere eliminati.

delete restituisce true se il simbolo è stato eliminato correttamente o nil se il simbolo non è stato eliminato.

Quando si elimina un simbolo di contesto, la prima chiamata a delete rimuove il contenuto dello spazio dei nomi di contesto e riduce il simbolo di contesto in un normale simbolo mono-variabile. Una seconda chiamata di delete rimuoverà il simbolo dalla tabella dei simboli. "This behavior is necessary when using local variable symbols in functions as contexts." Lutz

(set 'lst '(a b aVar c d))
(delete 'aVar)  ; aVar deleted, references marked nil
lst
;-> (a b nil c d)

(set 'lst '(a b aVar c d))
(delete 'aVar true)
;-> nil ; protect aVar if referenced

lst
;-> (a b aVar c d)

;; delete all symbols in a context
(set 'foo:x 123)
(set 'foo:y "hello")
(delete 'foo)
;-> nil  ; foo:x, foo:y deleted

Nell'ultimo esempio verranno eliminati solo i simboli all'interno del contesto foo, ma non il simbolo contestuale stesso. Verrà convertito in un normale simbolo non protetto e conterrà nil.

Si noti che l'eliminazione di un simbolo che fa parte di un'espressione che è attualmente in esecuzione può causare l'arresto anomalo del sistema o avere altri effetti imprevisti.

Per cancellare tutti i simboli di un contesto X possiamo utilizzare la seguente espressione:

(map delete (symbols 'X))

che elimina tutti i simboli contenuti nel contesto X.


-------------------
Funzioni e contesti
-------------------

La seguente funzione permette di definire funzioni come funtori di default nel proprio contesto.

(define (def-static s body)
      (def-new 'body (sym s s)))

Vediamo un esempio di utilizzo:

(def-static 'acc (fn (x) (inc sum x)))
;-> acc:acc
(acc 1)
;-> 1
(acc 1)
;-> 2
(acc 1)
;-> 3
(acc 5)
;-> 8
acc:acc
;-> (lambda (acc:x) (inc acc:sum acc:x))

è possibile utilizzare "def-static" anche come lambda-macro:

(def-static 'mysetq (lambda-macro (p1 p2) (set p1 (eval p2))))
;-> mysetq:mysetq
(mysetq x 123)
;-> 123

e questo è quello che viene generato:

mysetq:mysetq
;-> (lambda-macro (mysetq:p1 mysetq:p2) (set mysetq:p1 (eval mysetq:p2)))

Per avere informazioni sui contesti definiti e sul contesto corrente possiamo usare le seguenti espressioni/funzioni:

(define (contexts-info) (filter context? (map eval (symbols 'MAIN))))
(contexts-info)
;-> (Class MAIN Tree aac mysetq)
(context)
;-> MAIN

(symbols)


------------------
Buon 2020 (e 2021)
------------------

Conto alla rovescia per il nuovo anno:

10 * 9 * 8 + (7 + 6) * 5 * 4 * (3 + 2) * 1 = 2020

...e anche per il prossimo:

10 * 9 * 8 + (7 + 6) * 5 * 4 * (3 + 2) + 1 = 2021

(define (buon-anno)
  (println "Buon " (+ (* 10 9 8) (* (+ 7 6) 5 4 (+ 3 2) 1))))

(buon-anno)
;-> Buon 2020

(setq a (+ (* 10 9 8) (* (+ 7 6) 5 4 (+ 3 2) 1)))
;-> 2020
(setq b (+ (* 10 9 8) (* (+ 7 6) 5 4 (+ 3 2)) 1))
;-> 2021


--------------------------------------
Nascita della teoria della probabilità
--------------------------------------

Chevelier de Mere (1607-1684) era un gentiluomo francese giocatore d'azzardo che è entrato nella storia per aver chiesto aiuto a Blaise Pascal nel risolvere un problema relativo al gioco dei dadi.

La situazione di Chevelier de Mere prevedeva due giochi di dadi. Nel primo, De Mere puntava con probabilità pari di ottenere almeno un sei su quattro tiri di un dado non truccato. Il suo ragionamento era il seguente: con il lancio di un dado il numero 6 ha probabilità 1/6 di uscire (corretto). Poi ha pensato che con il lancio di quattro dadi la probabilità sarebbe 4*(1/6) = 4/6 = 2/3 (sbagliato). Sebbene il suo ragionamento fosse errato, nel corso degli anni ha fatto molti soldi facendo questa scommessa.

Con il successo del primo gioco, de Mere ha modificato il gioco scommettendo con pari probabilità di ottenere almeno un doppio sei lanciando 24 volte una coppia di dadi. Egli riteneva correttamente che la possibilità di ottenere un doppio sei lanciando una coppia di dadi è 1/6 * 1/6 = 1/36. Tuttavia, sbagliava nel pensare che in 24 lanci di una coppia di dadi, la possibilità di ottenere un doppio sei sarebbe stata 24 * 1/36 = 24/36 = 2/3.

Dopo avere perso molti soldi intuì che qualcosa non andava nel secondo gioco dei dadi. Quindi chiese aiuto al suo rinomato amico Blaise Pascal per trovare una spiegazione al problema. In una serie di lettere tra Pascal e Pierre de Fermet, il quesito di de Mere à stato risolto. Da questo sforzo congiunto furono gettate le basi per la teoria della probabilità.
La chiave della soluzione ai problemi di de Mere è la distribuzione binomiale.

Vediamo perché il primo gioco è stato redditizio per de Mere e perché il secondo gioco non lo è stato.

Primo gioco

La probabilità di ottenere un 6 con un dado vale 1/6.
La probabilità di non ottenere almeno un 6 con un dado vale 5/6, quindi la probabilità di non ottenere alcun 6 lanciando 4 dadi vale: (5/6)*(5/6)*(5/6)*(5/6) = (5/6)^4 = 0.482253.
Quindi la probabilità di avere almeno un 6 lanciando 4 dadi vale:

P(un 6 con 4 dadi) = 1 - P(nessun 6 con 4 dadi) =
= 1 - 0.482253 = 0.517747

La probabilità di ottenere almeno un sei su quattro tiri di un dado giusto è 0.517747. Su 100 partite, de Mere avrebbe vinto in media 52 partite. Su 1000 partite, avrebbe vinto in media 518 partite. Supponiamo che ogni scommessa sia di un euro. Quindi de Mere avrebbe guadagnato 36 euro per ogni 1000 euro. Con un guadagno pari al 3.6% (circa).

Secondo gioco

In un lancio di una coppia di dadi, ci sono un totale di 36 possibili esiti (cioè i sei risultati del primo dado combinati con i sei risultati del secondo dado). Di questi 36 risultati, solo uno di questi è un doppio sei. Quindi, la probabilità di ottenere un doppio sei è 1/36 nel tirare un paio di dadi. Allo stesso modo, la probabilità di non ottenere un doppio sei è 35/36.

La probabilità di non ottenere un doppio sei in 24 tiri di una coppia di dadi è:

P(nessun doppio sei in 24 tiri) = (35/36)^24 = 0.5086

Quindi la probabilità di ottenere almeno un doppio sei in 24 tiri è:

P (almeno un doppio sei in 24 rotoli) = 1 - P (nessun doppio sei in 24 rotoli) =
= 1 - 0.5086 = 0.4914

La probabilità di ottenere almeno un doppio sei in 24 tiri di una coppia di dadi è 0.4914. In media, De Mere avrebbe vinto solo circa 49 partite su 100 e l'avversario avrebbe vinto circa 51 partite. Se ogni scommessa vale un euro, la parte avversaria di de Mere vincerebbe 2 franchi per ogni 100 franchi scommessi (con un guadagno di circa il 2%).

Verifichiamo i risultati con una simulazione.

(define (dado) (+ 1 (rand 6)))

(define (game1 n)
  (let ((mere 0) (break nil))
    (for (i 1 n)
      (setq break nil)
      (for (j 1 4 1 break)
        (if (= (dado) 6) (begin
            (++ mere)
            (setq break true)
        ))
      )
    )
    (println "games: " n { } "mere wins: " mere { - } (div mere n)"%")
    (list n mere (div mere n))
  )
)

(game1 1e4)
;-> games: 10000 mere wins: 5149 - 0.5149%
;-> (10000 5149 0.5149)
(game1 1e5)
;-> games: 100000 mere wins: 51845 - 0.51845%
;-> (100000 51845 0.51845)
(game1 1e6)
;-> games: 1000000 mere wins: 518265 - 0.518265%
;-> (1000000 518265 0.518265)
(game1 1e7)
;-> games: 10000000 mere wins: 5180712 - 0.5180712%
;-> (10000000 5180712 0.5180712)
(game1 1e8)
;-> games: 100000000 mere wins: 51774774 - 0.51774774%
;-> (100000000 51774774 0.51774774)
(game1 1e8)
;-> games: 100000000 mere wins: 51774196 - 0.51774196%
;-> (100000000 51774196 0.51774196)

Nota:
se per ogni lancio le vittorie sono il numero di 6 ottenuti, allora la probabilità di vittoria vale 2/3.

(define (game1 n)
  (let ((mere 0) (break nil))
    (for (i 1 n)
      ;(setq break nil)
      (for (j 1 4 1 break)
        (if (= (dado) 6) (begin
            (++ mere)
            ;(setq break true)
        ))
      )
    )
    (println "games: " n { } "mere wins: " mere { - } (div mere n)"%")
    (list n mere (div mere n))
  )
)

(game1 1e7)
;-> games: 10000000 mere wins: 6665579 - 0.6665579% ; 2/3 come pensava de Mere !!!)
;-> (10000000 6665579 0.6665579)

Nota: le seguenti funzioni producono risultati differenti

(define (dadi1) (+ 2 (rand 11)))
(define (dadi) (+ (+ 1 (rand 6)) (+ 1 (rand 6))))

Vediamo la distribuzione dei numeri random creati.

Funzione dadi1:

(setq res1 (array 13))
(for (i 1 10000) (++ (res1 (dadi1))))
res1
;-> (nil nil 927 896 862 863 918 914 882 980 902 968 888)
La distribuzione dei numeri da 2 a 12 è uniforme.

Funzione dadi:

(setq res (array 13))
(for (i 1 10000) (++ (res (dadi))))
res
;-> (nil nil 264 540 850 1098 1427 1703 1388 1073 825 571 261)
La distribuzione dai numeri da 1 a 12 non è uniforme. Questo è corretto ed è dovuto al fatto che i numeri non sono equiprobabili (ad esempio il numero 7 ha la probabilità più alta, perchè può essere formato da 1+6, 2+5, 3+4, 6+1, 4+3 e 5+2)

(define (game2 n)
  (let ((mere 0) (break nil))
    (for (i 1 n)
      (setq break nil)
      (for (j 1 24 1 break)
        (if (= (dadi) 12) (begin
            (++ mere)
            (setq break true)
        ))
      )
    )
    (println "games: " n { } "mere wins: " mere { - } (div mere n)"%")
    (list n mere (div mere n))
  )
)

(game2 1e3)
; games: 1000 mere wins: 524 - 0.524%
;-> (1000 524 0.524)
(game2 1e4)
;-> games: 10000 mere wins: 4933 - 0.4933%
;-> (10000 4933 0.4933)
(game2 1e5)
;-> games: 100000 mere wins: 49140 - 0.4914%
;-> (100000 49140 0.4914)
(game2 1e6)
;-> games: 1000000 mere wins: 491200 - 0.4912%
;-> (1000000 491200 0.4912)
(game2 1e7)
;-> games: 10000000 mere wins: 4914713 - 0.4914713%
;-> (10000000 4914713 0.4914713)

(time (game2 1e7))
;-> 60520.989

Nota: nel 1933 una monografia del matematico russo A. Kolmogorov sviluppa un approccio assiomatico che costituisce la base per la moderna teoria della probabilità ("Foundations of Probability Theory", Chelsea, New York, 1950).


------------------
Fibonacci (104911)
------------------

Questo è il più grande numero noto di Fibonacci che è anche primo. Contieneo 21925 cifre ed è stato dimostrato primo da Mathew Steine e Bouk de Water nel 2015.

Con newLISP possiamo calcolare questo numero, ma non possiamo verificare se è primo perchè richiederebbe un tempo lunghissimo.

(define (fibonacci n)
  (let (L '(0L 1L))
    (dotimes (i n)
      (setq L (list (L 1) (apply + L)))
    )
    ;(L 1)
    (last L)
  )
)

(length (setq a (fibonacci 104911)))
;-> 21925

(setq a (fibonacci 104911))


-------------
Conta e leggi
-------------

La sequenza di interi 1, 11, 21, 1211, 111221, ... viene creata partendo dal numero 1 e leggendo i numeri nel modo seguente:

     1 viene letto come 1 volta 1 ==> 11
    11 viene letto come 2 volte 1 ==> 21
    21 viene letto come 1 volta 2 e 1 volta 1 ==> 1211
  1211 viene letto come 1 volta 1, 1 volta 2 e 2 volte 1 ==> 111221
111221 viene letto come 3 volte 1, 2 volte 2 e 1 volta 1 ==> 312211
...

Scrivere una programma che genera questa sequenza fino ad un numero n passato come parametro.

Il problema può essere risolto utilizzando una semplice iterazione.

(define (conta n)
  (local (rip cur out i j res)
    (setq res '("1"))
    (setq out "1")
    (setq i 1)
    (while (< i n)
      (setq cur "")
      (setq rip 1)
      (setq j 1)
      (while (< j (length out))
        (if (= (out j) (out (- j 1)))
          (++ rip)
          (begin
            (setq cur (string cur rip (out (- j 1))))
            (setq rip 1)
          )
        )
        (++ j)
      )
      (setq cur (string cur rip (out (- (length out) 1))))
      (setq out cur)
      (push out res -1)
      (++ i)
    )
    res
  )
)

(conta 6)
;-> ("1" "11" "21" "1211" "111221" "312211")
(conta 12)
;-> ("1" "11" "21" "1211" "111221" "312211" "13112221"
;-> "1113213211" "31131211131221" "13211311123113112211"
;-> "11131221133112132113212221" "3113112221232112111312211312113211")

Nota: la funzione è lenta per numeri superiore a poche decine perchè le stringhe che rappresentano i numeri crescono molto rapidamente e newLISP utilizza il tag [text][/text] per delimitare le stringhe che superano 2047 caratteri. Questo rallenta molto l'esecuzione.

Ecco un altro metodo proposto da Norman:

(println (first (setq n '( 1 ))))
(do-until (< 1000 (length n))
 (dolist (x n (!= (n 0) x)) (push x r))
  (setq n ((length r) n))
  (push (length r) o -1)
  (push (r 0) o -1)
  (setq r '())
  (if (empty? n) (begin (setq n o) (setq o '()) (println (join(map string n ) "")) ))
)


----------------------
Assegnazione parallela
----------------------

newLISP non ha alcuna funzione per l'assegnazione parallela delle variabili. Vediamo la differenza tra assegnazione sequenziale e assegnazione parallela.

(setq a 1 b 1)

Assegnazione sequenziale
(setq a (+ a b))
;-> 2
(setq b (- a b))
;-> 1

Assegnazione parallela
(psetq (a b) ((+ a b) (- a b)))
a -> 2
b -> 0

Cioè entrambe le espressioni (+ a b) e (- a b) vengono calcolate con i valori iniziali a=1 e b=1.

Per definire l'assegnazione parallela scriveremo una macro "psetq" che ha due argomenti:

1. (a b) che rappresenta la lista delle variabili
2. ((+ a b) (- a b)) che rappresenta la lista delle espressioni

Il metodo è quello di valutare (con la funzione "expand") le espressioni sostituendo il valore delle variabili:

(setq a 1 b 1)

(expand (+ a b) 'a 'b)
;-> 2

(expand (- a b) 'a 'b)
;-> 0

Poi assegniamo queste "espansioni" alle variabili della prima lista. Questo è possibile perchè una macro non valuta gli argomenti, infatti se scriviamo le stesse espressioni non in una macro, non possiamo ottenere il risultato voluto:

(setq a (expand (+ a b) 'a 'b))
;-> 2
(setq b (expand (- a b) 'a 'b))
;-> 1 ; questo valore doveva essere 0

Questo perchè l'espressione (setq b (expand (- a b) 'a 'b)) valuta prima gli argomenti e trova che a = 2.

Vediamo come funziona la macro:

(define-macro (psetq)
  (let ((_tx (expand (args 1 0) (args 0 0) (args 0 1)))
        (_ty (expand (args 1 1) (args 0 0) (args 0 1))))
       (println _tx)
       (println _ty)
       (list (set (args 0 0) (eval _tx))
             (set (args 0 1) (eval _ty)))))

Facciamo l'espansione delle espressioni e inseriamo il risultato in "_tx" e "_ty":
(_tx (expand (args 1 0) (args 0 0) (args 0 1)))
(_ty (expand (args 1 1) (args 0 0) (args 0 1)))

Poi assegniamo la valutazione di queste espressioni alle relative variabili:
(set (args 0 0) (eval _tx))
(set (args 0 1) (eval _ty)))))

Proviamo la macro:

(setq a 1 b 1)
(psetq (a b) ((+ a b) (- a b)))
;-> (+ 1 1)
;-> (- 1 1)
;-> (2 0)

(list a b)
;-> (2 0)

La macro funziona correttamente, ma dobbiamo renderla più generale, nel senso che deve permettere di avere qualunque numero di variabili e di espressioni come argomenti (adesso la macro funziona solo con due variabili e due espressioni).

Invece di usare due variabili ("_tx" e "_ty") inseriamo le espressioni espanse in una lista "_var" e poi attraversiamo questa lista assegnando la valutazione delle espressioni alle relative variabili della lista delle variabili.
La lista delle variabili è (args 0), mentre la lista delle espressioni è (args 1).

(define-macro (psetq)
  (let ((_var '()) (_ex '()))
    ; per ogni espressione in (args 1)...
    (for (i 0 (- (length (args 1)) 1))
      ; espande l'espressione i-esima con il valore
      ; di ogni variabile (args 0)
      (setq _ex (expand (args 1 i) (args 0 0)))
      ; ciclo che espande l'espressione i-esima per ogni variabile
      (for (j 1 (- (length (args 0)) 1))
        (setq _ex (expand _ex (args 0 j)))
        (println _ex)
      )
      ; aggiunge l'espressione espansa ad una lista
      (push _ex _var -1)
    )
    (println _var)
    ; assegna ad ogni variabile la valutazione
    ; della relativa espressione della lista creata
    (dolist (el _var)
      (set (args 0 $idx) (eval el))
    )
  )
)

Vediamo alcuni esempi:

(setq x 2 y 3)

(psetq (x y) ((+ 1 y) (+ 1 x)))
;-> (+ 1 3)
;-> (+ 1 2)
;-> ((+ 1 3) (+ 1 2))
(list x y)
;-> (4 3)

(psetq (x y) (3 4))
;-> 3
;-> 4
;-> (3 4)
(list x y)
;-> (3 4)
----------------------

(setq x 2)
(setq y 4)
(setq a 2)

(setq x (- y 1 a))
;-> 1
(setq y (+ x y))
;-> 5

(setq x 2)
(setq y 4)
(setq a 2)

(psetq (x y) ((- y 1 a) (+ y x)))
;-> (- 4 1 a)
;-> (+ 4 2)
;-> ((- 4 1 a) (+ 4 2))
(list x y)
;-> (1 6)
----------------------

(setq x 1)
(setq y 2)
(setq z 3)

(setq x (+ x y z))
;-> 6
(setq y (- z y x))
;-> -5
(setq z (- x y z))
;-> 8

(setq x 1)
(setq y 2)
(setq z 3)

(psetq (x y z) ((+ x y z) (- z y x) (- x y z)))
;-> (+ 1 2 z)
;-> (+ 1 2 3)
;-> (- z 2 1)
;-> (- 3 2 1)
;-> (- 1 2 z)
;-> (- 1 2 3)
;-> ((+ 1 2 3) (- 3 2 1) (- 1 2 3))
(list x y z)
;-> (6 0 -4)
----------------------

(define (test a b c)
  (psetq (a b c) ((+ a b c) (- c b a) (- a b c)))
  (list a b c))

(test 1 2 3)
;-> (+ 1 2 c)
;-> (+ 1 2 3)
;-> (- c 2 1)
;-> (- 3 2 1)
;-> (- 1 2 c)
;-> (- 1 2 3)
;-> ((+ 1 2 3) (- 3 2 1) (- 1 2 3))
;-> (6 0 -4)

(psetq (x y z) (2 3 4))
;-> 2
;-> 2
;-> 3
;-> 3
;-> 4
;-> 4
;-> (2 3 4)

Nel forum di newLISP newBert ha proposto un altro metodo che utilizza la funzione "map":

(setq x 2 y 3)
;-> 3
(map set '(x y) (list (+ 1 y) (+ 1 x)))
;-> (4 3)

(setq x 1 y 2 z 3)
;-> 3
(map set '(x y z) (list (+ x y z) (- z y x) (- x y z)))
;-> (6 0 -4)

Fanda ha proposto una versione che scambia i valori di n simboli:

(define-macro (exchange) (map set (args) (map eval (rotate (args) -1))))

(set 'a 1 'b 2)
(exchange a b)
;-> (2 1)
(list a b)
;-> (2 1)

(set 'a 1 'b 2 'c 3 'd 4)
; a = b, b = c, c = d, d = a
(exchange a b c d)
;-> (2 3 4 1)
(list a b c d)
;-> (2 3 4 1)


----------------------------
Generatore di numeri casuali
----------------------------

Generatore lineare congruenziale
--------------------------------
Il generatore congruenziale lineare (LCG) è l'algoritmo più comune e più vecchio per la generazione di numeri pseudo-cauali. Il generatore è definito dalla relazione di ricorrenza:

X(n+1) = (a*X(n) + c) mod m

dove:
X è la sequenza di valori pseudo-casuali
m,    0 < m         -> modulo
a,    0 < a < m     -> moltiplicatore
c,    0 ≤ c < m     -> incremento
X(0), 0 ≤ X(0) < m  -> il valore iniziale (seed)

Generiamo il numero intero casuale successivo utilizzando il numero intero casuale precedente (con le costanti intere "a" (moltiplicatore) e "c" (incremento). All'inizio occorre fornire anche un valore di partenza (seed), "X(0)". La caratteristica della casualità viene fornita dall'utilizzo dell'aritmetica modulare.

Il periodo di un LCG è al più m, e per alcune scelte di a può essere molto più piccolo. Il LCG ha un periodo pieno se e solo se:

1. c e m sono coprimi (con c > 0)
2. a-1 è divisibile per tutti i fattori primi di m,
3. a-1 è un multiplo/divisibile di 4 se m è un multiplo/divisibile di 4.

Nonostante gli LCG siano generalmente in grado di produrre numeri pseudocasuali decenti, la loro qualità è molto sensibile alla scelta dei coefficienti c, m ed a.

Le caratteristiche principali di un LCG

Efficiente: LCG può produrre molti numeri in breve tempo.

Deterministico: una data sequenza di numeri può essere riprodotta in un secondo momento se si conosce il punto iniziale nella sequenza. Il determinismo è utile se è necessario riprodurre nuovamente la stessa sequenza di numeri in una fase successiva (debug).

Periodico: i LCG sono periodici, il che significa che la sequenza alla fine si ripeterà. Mentre la periodicità non è quasi mai una caratteristica desiderabile, i LCG moderni hanno un periodo così lungo che può essere ignorato per la maggior parte degli scopi pratici.

I LCG sono adatti per applicazioni in cui sono richiesti molti numeri casuali e in cui è utile riprodurre facilmente la stessa sequenza (per esempio, le applicazioni di simulazione e modellazione). I LCG non sono adatti per applicazioni in cui è importante che i numeri siano davvero casuali (imprevedibili), come la crittografia dei dati e il gioco d'azzardo.

Esempio:

(define (LCG m a c s n)
  (let (out '())
    (dotimes (x n)
      (push (setq s (% (+ (* a s) c) m)) out -1))))

(LCG 5 3 1 1 6)
;-> (4 3 0 1 4 3)

Ecco una lista di parametri per LCG in uso in diversi compilatori:

                     m       a                    c
GCC                  2³¹     1103515245           12345
Delphi               2³²     134775813            1
Visual C             2³²     214013               2531011
MMIX (Donald Knuth)  2⁶⁴     6364136223846793005  1442695040888963407
Numerical Recipes    2³²     1664525              1013904223
C++11 (MINSTD)       2³¹−1   48271                0

2^64 = 18446744073709551616
2^32 = 4294967296

(LCG 4294967296 1103515245 12345 1 10)
;-> (1103527590 2524885223 662824084 3295386429 4182499122
;->  2516284547 3655513600 2633739833 3210001534 267834847)

(LCG 4294967296 1103515245 (int (time-of-day)) 1 10)
;-> (1174154431 3237027237 1954923411 4185058793 1775773831
;->  2432844237 1673943195 3515535953 3289127119 3959783541)

Quando "c" vale 0, abbiamo un generatore di numeri casuali di tipo Lehmer (chiamato anche generatore di Park-Miller):

X(n+1) = a*X(n) mod m

Un esempio è il famoso RANDU creato dall'IBM negli anni '60. La formula di questo generatore è la seguente:

V(j+1)=65539*V(j) mod 2^(31)

con V(0) numero intero dispari. Genera interi pseudocasuali V(j) che sono distribuiti uniformemente nell'intervallo [1, 2^31 - 1], ma nelle applicazioni pratiche sono spesso mappati in numeri razionali pseudocasuali X(j) nell'intervallo (0, 1), con la formula:

X(j) = V(j)/2^31

Il RANDU è considerato uno dei peggiori generatori di numeri casuali progettati, ed è stato descritto come "veramente orribile" da Donald Knuth. Il test spettrale ha esito negativo per dimensioni maggiori di 2 e ogni risultato intero è dispari. Tuttavia, almeno otto bit di ordine inferiore vengono eliminati quando convertiti in virgola mobile a precisione singola (32 bit, 24 bit mantissa).

Vediamo un generatore di numeri casuali fornito da Lutz:
(set 'IM 139968)
(set 'IA 3877)
(set 'IC 29573)
(set 'LAST 42)

(define (gen_random maximum)
	(set 'LAST (mod (add (mul LAST IA) IC) IM))
	(div (mul maximum LAST) IM))

(gen_random 100)
;-> 37.46499199817101
(gen_random 100)
;-> 72.90237768632831
(gen_random 100)
;-> 63.64669067215363

Vedi anche "A Million Random Digits with 100,000 Normal Deviates" in "Note libere 20".
Vedi anche "Generatore di numeri casuali" su "Note libere 1".
Vedi anche "Il metodo middle-square per generare numeri casuali" su "Note libere 22".
Vedi anche "Generatore casuale di Neumann" su "Note libere 26".
Vedi anche "Generatore casuale di Engel" su "Note libere 26".
Vedi anche "Generatore casuale LCG (Linear Congruential Generator)" su "Note libere 26".

---------------------
Liste di associazione
---------------------

Una lista di associazione è una lista con la seguente struttura:

((chiave1 valore11 valore12 valore13 ... valore1N) (chiave2 valore21 valore22 valore23 ... valore2N) ...
 (chiaveM valoreM1 valoreM2 valoreM3 ... valoreMN))

Le funzioni specifiche di queste liste sono:
1) assoc
2) lookup
3) pop-assoc

Vediamo alcuni esempi:

FUNZIONE "assoc"
sintassi: (assoc exp-key list-alist)
sintassi: (assoc list-exp-key list-alist)

(setq lst '((key1 value1) (key2 value2) (key3 value3)))

Recuperare l'associazione con chiave key1:
(assoc 'key1 lst)
;-> (key1 value1)

FUNZIONE "lookup"
sintassi: (lookup exp-key list-assoc [int-index [exp-default]])

Recuperare solo il valore dell'associazione con chiave key1:
(lookup 'key1 lst)
;-> value1

Con int-index = 0:
(lookup 'key1 lst 0 'null)
;-> key1

Con int-index = 1:
(lookup 'key1 lst 1 'null)
;-> value1

Con int-index = 2: (in questo caso non esiste un elemento con indice 2 nella sottolista con chiave key1 e viene restituito l'ultimo elemento associato)
(lookup 'key1 lst 2 'null)
;-> value1

Con una chiave inesistente key5:
(lookup 'key5 lst 1 'null)
;-> null

Usiamo una lista associativa con valori multipli:

(setq lst1 '((key1 value1 value11) (key2 value2 value22) (key3 value3 value33)))

(lookup 'key1 lst1)
;-> value11

Con int-index = 0:
(lookup 'key1 lst1 0 'null)
;-> key1

Con int-index = 1:
(lookup 'key1 lst1 1 'null)
;-> value1

Con int-index = 2: (in questo caso esiste un elemento con indice 2 nella sottolista con chiave key1 e quindi viene restituito)
(lookup 'key1 lst1 2 'null)
;-> value11

Liste associative annidate
--------------------------
(setq lsta '((nome "eva") (eta "23") (esami ((storia 27) (chimica 28)))))

(lookup 'esami lsta)
;-> ((storia 27) (chimica 28))

Verificare se una chiave esiste ed (eventualmente) aggiornare il valore associato:

(letn (key 'nome)
  (if (lookup key lsta)
      (setf (assoc key lsta) (list key "max"))))
;-> (nome "max")
lsta
;-> ((nome "max") (eta "23") (esami ((storia 27) (chimica 28))))

Possiamo scriviamo una versione semplificata delle funzioni "assoc" e "lookup":

(define (car x)    (first x))
(define (cdr x)    (rest x))
(define (caar x)   (first (first x)))
(define (cadar x)  (first (rest (first x))))

(setq lst '((2 a) (1 b) (3 c)))

(define (assoc. key lst)
  (cond ((null? lst) nil)
        ((= (caar lst) key) (cadar lst))
        (true (assoc. key (cdr lst)))))

(assoc. 1 lst)
;-> b
(assoc. 4 lst)
;-> nil

(assoc. 4 '((2 a) (1 b) (3 c)))

(define (lookup. key lst)
  (cond ((null? lst) nil)
        ((= (caar lst) key) (car lst))
        (true (lookup. key (cdr lst)))))

(lookup. 1 lst)
;-> (1 b)
(lookup. 4 lst)
;-> nil

Vedi anche "Modificare le liste di associazione" nel capitolo "09-Note-libere-1".
Vedi anche "Ricerca nelle liste di associazione" nel capitolo "19-Note-libere-11".


-------------------------------
Funzione Z e ipotesi di Riemann
-------------------------------

La funzione zeta di Riemann è una funzione che riveste una fondamentale importanza nella teoria dei numeri e ha notevoli risvolti in fisica, teoria della probabilità e statistica.
I primi studi su questa funzione furono effettuati da Leonhard Euler nel diciottesimo secolo, ma il nome deriva da Bernhard Riemann, che nel testo "Über die Anzahl der Primzahlen unter einer gegebenen Grösse" del 1859, avanzò l'ipotesi di una relazione tra gli zeri della funzione e la distribuzione dei numeri primi, la celebre "Congettura di Riemann".

Z(s) = 1/1^s + 1/2^s + 1/3^s + 1/4^s + ... =
     = Sum[1/i^s], (1 <= i <= ∞)

Eulero ha dimostrato che:

Z(s) = Prod[1/(1 - p^(-s))], (p numeri primi)

Quindi risulta:

Z(s) = 1/1^s + 1/2^s + 1/3^s + 1/4^s + ... =
     = (1/(1 - 1/2^s)) * (1/(1 - 1/3^s)) * (1/(1 - 1/5^s)) * (1/(1 - 1/7^s)) * ...

(define (ipow x n)
  (cond ((zero? n) 1)
        ((even? n) (ipow (* x x) (/ n 2)))
        (true (* x (ipow (* x x) (/ (- n 1) 2))))))

(ipow 21L 25L)
;-> 1136272165922724266740722458520501L

(define (Z s n)
  (let (out 0L)
    (for (i 1 n)
      (setq out (add out (div (ipow (bigint i) (bigint s)))))
    )
  out))

(setq PI (mul 2.0 (acos 0.0)))
;-> 3.141592653589793
(setq PI (mul 2.0 (asin 1.0)))
;-> 3.141592653589793

Eulero ha dimostrato che per s=2 e s=4 otteniamo:

Z(2) = (PI^2)/6 =
(setq Z2 (div (mul PI PI) 6))
;-> 1.644934066848226

Z(4) = (PI^4)/90 =
(setq Z4 (div (mul PI PI PI PI) 90))
;-> 1.082323233711138

Proviamo con la nostra funzione Z:

(Z 2 100000)
;-> 1.644924066898242
(Z 4 100000)
;-> 1.082323233710861

Vediamo l'errore:

(sub (Z 2 100000) Z2)
;-> -9.999949984074164e-006
(sub (Z 4 100000) Z4)
;-> -2.76889622341514e-013

Notiamo che per s = 0 otteniamo:

Z(0) = 1/1^0 + 1/2^0 + 1/3^0 + ... = 1 + 1 + 1 + ... = infinito

E per valori di (s < 0) otteniamo:

Z(-1) = 1/(1^-1) + 1/2^0 + 1/3^0 + ... = 1^1 + 2^1 + 3^1 + ... = infinito

Quindi per (s <= 0) la funzione Z tende all'infinito.

Riemann ha trovato una funzione analoga a Z(s):

            1          ∞    1        ∞               n!
ζ(s) = ------------- * ∑ --------- * ∑ (-1)^k * ----------- * (k + 1)^-s
         1-2^(1-s)    n=0 2^(n+1)   k=0          k!(n - k)!

ζ(2) = (PI^2)/6

ζ(4) = (PI^4)/90

Ma il valore di ζ(1) è indefinito.

Calcolo degli zeri della funzione ζ:

ζ(s) = 0 per s = -2, -4, -6, -8, -10, ... (per tutti i valori negativi pari di s)

Per i numeri s positivi risulta:

ζ(1/2 + 14.134725142i) = 0
ζ(1/2 + 21.022039639i) = 0
ζ(1/2 + 25.010857580i) = 0
ζ(1/2 + 30.424876126i) = 0

L'ipotesi di Riemann (RH) afferma che tutti gli zeri non banali di ζ si trovano sulla linea 1/2 + iR.
(Gli zeri banali sono quelli per cui s è un numero negativo pari).

L'istituto Clay Mathematics ha messo in palio 1.000.000 di dollari a chi dimostrerà questa ipotesi.

Per finire scriviamo una funzione che calcola Z(s) con numeri floating-point:

(define (Z s n)
  (let (out 0)
    (for (i 1 n)
      (setq out (add out (div (pow i s))))
    )
  out))

(Z 2 1000000)
;-> 1.64493306684877

(Z 4 1000000)
;-> 1.082323233710861


-------------------------------------
Rotazione di stringhe, liste e numeri
-------------------------------------

Scrivere una funzione che produce tutte le rotazioni di una stringa (e di una lista)
Esempio: "abc" -> "abc" "bca" "cab"

(define (ruota str)
  (let ((len (length str))
        (out '()))
    (dotimes (x len)
      (push (rotate str) out))))

(ruota "abc")
;-> ("abc" "bca" "cab")

Funziona anche per le liste:

(ruota '(1 2 3))
;-> ((1 2 3) (2 3 1) (3 1 2))

(setq lst '(a b c))

Vediamo un altro metodo:

(define (ruota2 lst)
  (let (out '())
    (dotimes (x (length lst))
    (push (push (pop lst) lst -1) out))))

(ruota2 '(a b c))
;-> ((a b c) (c a b) (b c a))

Funziona anche per le stringhe:

(ruota2 "abc")
;-> ("abc" "cab" "bca")

Vediamo la differenza di velocità:

(time (ruota (sequence 1 100)) 10000)
;-> 2181.789

(time (ruota2 (sequence 1 100)) 10000)
;-> 1959.412

(time (ruota "abcdefghijklmnopqrstuvwxyz") 10000)
;-> 91.905

(time (ruota2 "abcdefghijklmnopqrstuvwxyz") 10000)
;-> 164.827

Quindi con le stringhe è meglio usare "ruota", mentre con le liste è meglio "ruota2".

Per i numeri possiamo utilizzare un algoritmo diverso notando che risulta:

r(n) = (n + (10^(L(n)) - 1)*(n mod 10))/10

dove L(n) è la lunghezza del numero n.

La funzione che ruota una cifra di un numero:

(define (rotate-num n)
  (/ (+ n (* (- (pow 10 (length n)) 1) (% n 10))) 10))

(rotate-num 123)
;-> 312

Funzione che crea la lista di tutti i numeri ruotati di n (n compreso):

(define (ruota-num num)
  (local (val out)
    (setq val num)
    (setq out '())
    (push val out)
    (for (i 1 (- (length num) 1))
      (setq val (rotate-num val))
      (push val out -1)
    )
    out))

(ruota-num 123456)
;-> (123456 612345 561234 456123 345612 234561)


------------------------------
Quadrato di una lista ordinata
------------------------------

Data una lista di numeri interi ordinati in ordine non decrescente, una funzione che restituISCE una lista con i quadrati di ciascun numero, anch'essa ordinata in ordine non decrescente.
Ad esempio, data (-2 3 7 7 8), l'output desiderato è (4 9 49 49 64).
Attenzione: data (-4 -1 0 3 10), l'output desiderato è (0 1 9 16 100).

(define (quad lst)
  (let (out '())
    (sort (map (fn (x) (* x x)) lst))))

(quad '(-2 3 7 7 8))
;-> (4 9 49 49 64)
(quad '(-4 -1 0 3 10))
;-> (0 1 9 16 100)


-------------------
Somma da due numeri
-------------------

Dato una lista di numeri interi e un numero intero s, trovare tutte le coppie di numeri interi nella lista che si sommano all'intero s oppure restituire che non esistono coppie di questo tipo.
Consideriamo tre algoritmi con le seguenti complessità temporali: O(n²), O(n*log(n)) e O(n).

Il metodo più semplice è quello di considerare ogni elemento della lista sommandolo a tutti gli altri e controllare se sommano al valore s. Complessità temporale O(n²).

(define (find-coppie lst somma)
  (let (out '())
    (for (i 0 (- (length lst) 2))
      (for (j (+ i 1) (- (length lst) 1))
        (if (= somma (+ (lst i) (lst j)))
          (push (list (lst i) (lst j)) out -1)
        )))
  out))

(find-coppie '(1 5 7 -1 5) 6)
;-> ((1 5) (1 5) (7 -1))
(find-coppie '(2 5 17 -1) 7)
;-> (2 5)
(find-coppie '(3 5 6 -1) 10)
;-> ()
(find-coppie '(2 3 4 -2 6 8 9 11) 6)
;-> ((2 4) (-2 8))
(find-coppie (sequence 1 10) 6)
;-> ((1 5) (2 4))

Un altro metodo è quello di ordinare la lista e poi con due indici (basso e alto) attraversiamo la lista:

(define (find-coppie2 lst somma)
  (local (out alto basso)
    (setq out '())
    (setq alto (- (length lst) 1))
    (setq basso 0)
    (sort lst)
    (while (< basso alto)
      (if (= somma (+ (lst basso) (lst alto)))
          (push (list (lst basso) (lst alto)) out -1)
      )
      (if (> (+ (lst basso) (lst alto)) somma)
          (setq alto (- alto 1))
          (setq basso (+ basso 1))
      )
    )
    out))

(find-coppie2 '(1 5 7 -1 5) 6)
;-> ((-1 7) (1 5))
(find-coppie2 '(-1 1 5 5 7) 6)
;-> ((-1 7) (1 5))
(find-coppie2 '(2 5 17 -1) 7)
;-> ((2 5))
(find-coppie2 '(3 5 6 -1) 10)
;-> ()
(find-coppie2 '(2 3 4 -2 6 8 9 11) 6)
;-> ((-2 8) (2 4))
(find-coppie2 (sequence 1 10) 6)
;-> ((1 5) (2 4))

La complessità temporale di questo secondo metodo non è calcolabile esattamente, poichè utilizziamo la funzione "sort" di newLISP (che dovrebbe utilizzare il merge-sort O(n*log(n)). Comunque è il metodo più veloce proprio perchè utilizziamo la versione integrata (compilata) della funzione "sort".

Il terzo metodo è quello di utilizzare una hash-map con il seguente algoritmo:

  Creare una hash-map
  Per ogni numero della lista
    Se il numero corrente si trova nella hash-map,
        allora inserire il numero corrente e (somma - numero corrente) nella soluzione
    Aggiungere (somma - numero corrente) nella hash-map
  Restituire la soluzione

(define (find-coppie3 lst somma)
  (local (out)
    (setq out '())
    (new Tree 'hash)
    (dolist (el lst)
      (if (hash el)
        (push (list (- somma el) el) out -1)
      )
      (hash (string (- somma el)) (- somma el))
    )
    (delete 'hash)
    out))

(find-coppie3 '(1 5 7 -1 5) 6)
;-> ((1 5) (7 -1) (1 5))
(find-coppie3 '(-1 1 5 5 7) 6)
;-> ((1 5) (1 5) (-1 7))
(find-coppie3 '(2 5 17 -1) 7)
;-> ((2 5))
(find-coppie3 '(3 5 6 -1) 10)
;-> ()
(find-coppie3 '(2 3 4 -2 6 8 9 11) 6)
;-> ((2 4) (-2 8))
(find-coppie3 (sequence 1 10) 6)
;-> ((2 4) (1 5))

Questo algoritmo ha complessità temporale O(n).

Vediamo quale metodo è più veloce:

(time (find-coppie (sequence 1 1000) 500) 10)
;-> 5126.398

(time (find-coppie2 (sequence 1 1000) 500) 10)
;-> 17.951

(time (find-coppie3 (sequence 1 1000) 500) 10)
;-> 11.001


---------------------
Mescolamento perfetto
---------------------

Un mescolamento (shuffle) perfetto, divide un mazzo di carte in due metà uguali (deve esserci un numero pari di carte), quindi le interfoglia perfettamente. Alla fine una serie di mescolamenti perfetti riporta un mazzo al suo ordine originale. Ad esempio, con un mazzo di 8 carte (1 2 3 4 5 6 7 8), il primo mescolamento riordina le carte in (1 5 2 6 3 7 4 8), il secondo mescolamento riordina le carte in (1 3 5 7 2 4 6 8) e il terzo mescolamento ripristina l'ordine originale (1 2 3 4 5 6 7 8).

Scrivere una funzione che esegue un mescolamento perfetto. Scrivere una funzione che calcola quanti mescolamenti perfetti sono necessari per riportare un mazzo di n carte all'ordine originale.
Quante mescolamenti perfetti sono necessari per un mazzo da 52 carte?

(setq lst '(1 2 3 4 5 6 7 8))

Funzione che esegue un mescolamento perfetto:

(define (shuffle lst)
  (let ((out '()) (len (length lst)))
    (for (i 0 (- (/ len 2) 1))
      (push (lst i) out -1) ; inserisce il valore i-esimo
      (push (lst (+ i (/ len 2))) out -1) ; inserisce il valore (i + len/2)-esimo
    )
    out))

(shuffle lst)
;-> (1 5 2 6 3 7 4 8)

(shuffle (shuffle (shuffle lst)))
;-> (1 2 3 4 5 6 7 8)

Funzione che calcola il numero di mescolamenti perfetti per avere nuovamente la lista originale:

(define (shuffle-number lst)
  (local (number calc)
    (setq number 1)
    (setq calc (shuffle lst))
    ; fino a che le liste non sono uguali...
    (while (!= lst calc)
      ; calcola un altro mescolamento perfetto
      (setq calc (shuffle calc))
      (++ number)
    )
    (list (length lst) number)
  ))

(shuffle-number lst)
;-> (8 3)
(shuffle-number (sequence 1 52))
;-> (52 8)

Funzione che calcola il numero di mescolamenti perfetti per tutte le liste fino al valore num:

(define (shuffle-list num)
  (let (out '())
    (for (i 2 num 2)
      (push (shuffle-number (sequence 1 i)) out -1)
    )
    out))

(shuffle-list 128)
;-> ((2 1) (4 2) (6 4) (8 3) (10 6) (12 10) (14 12) (16 4)
;->  (18 8) (20 18) (22 6) (24 11) (26 20) (28 18) (30 28) (32 5)
;->  (34 10) (36 12) (38 36) (40 12) (42 20) (44 14) (46 12) (48 23)
;->  (50 21) (52 8) (54 52) (56 20) (58 18) (60 58) (62 60) (64 6)
;->  (66 12) (68 66) (70 22) (72 35) (74 9) (76 20) (78 30) (80 39)
;->  (82 54) (84 82) (86 8) (88 28) (90 11) (92 12) (94 10) (96 36)
;->  (98 48) (100 30) (102 100) (104 51) (106 12) (108 106) (110 36)
;->  (112 36) (114 28) (116 44) (118 12) (120 24) (122 110) (124 20)
;->  (126 100) (128 7))

Notiamo che risulta: (2 1), (4 2), (8 3), (16 4), (32 5), (64 6), (128 7).

Disegniamo un grafico (spartano) con questi dati:

(setq data (shuffle-list 128))

(dolist (el data) (println (el 0) { - } (dup "*" (el 1))))

  2 - *
  4 - **
  6 - ****
  8 - ***
 10 - ******
 12 - **********
 14 - ************
 16 - ****
 18 - ********
 20 - ******************
 22 - ******
 24 - ***********
 26 - ********************
 28 - ******************
 30 - ****************************
 32 - *****
 34 - **********
 36 - ************
 38 - ************************************
 40 - ************
 42 - ********************
 44 - **************
 46 - ************
 48 - ***********************
 50 - *********************
 52 - ********
 54 - ****************************************************
 56 - ********************
 58 - ******************
 60 - **********************************************************
 62 - ************************************************************
 64 - ******
 66 - ************
 68 - ******************************************************************
 70 - **********************
 72 - ***********************************
 74 - *********
 76 - ********************
 78 - ******************************
 80 - ***************************************
 82 - ******************************************************
 84 - **********************************************************************************
 86 - ********
 88 - ****************************
 90 - ***********
 92 - ************
 94 - **********
 96 - ************************************
 98 - ************************************************
100 - ******************************
102 - ****************************************************************************************************
104 - ***************************************************
106 - ************
108 - **********************************************************************************************************
110 - ************************************
112 - ************************************
114 - ****************************
116 - ********************************************
118 - ************
120 - ************************
122 - **************************************************************************************************************
124 - ********************
126 - ****************************************************************************************************
128 - *******

Proviamo a migliorare la funzione "shuffle" scrivendola in stile lisp per renderla più veloce.

La funzione "take" restituisce i primi n elementi di una lista:

(define (take n lst) (slice lst 0 n))

La funzione "drop" restituisce tutti gli elementi di una lista tranne i primi n:

(define (drop n lst) (slice lst n))

(setq lst '(1 2 3 4 5 6 7 8))

(setq lun (length lst))
;-> 8

(take (/ lun 2) lst)
;-> (1 2 3 4)

(drop (/ lun 2) lst)
;-> (5 6 7 8)

(define (shuf lst)
  (let (len (length lst))
    (flat (map (fn(x y) (cons x y)) (take (/ len 2) lst) (drop (/ len 2) lst)))))
    ;(flat (map (fn(x y) (list x y)) (take (/ len 2) lst) (drop (/ len 2) lst)))))

(shuf lst)
;-> (1 5 2 6 3 7 4 8)

(shuf (shuf (shuf lst)))
;-> (1 2 3 4 5 6 7 8)

Test di velocità:

(silent (setq a (sequence 1 10000)))

(time (shuffle a) 10)
;-> 5313.681

(time (shuf a) 10)
;-> 52.914

La funzione "shuf" è 100 volte più veloce della funzione "shuffle".


---------
Mergesort
---------

Il merge sort è un algoritmo di ordinamento basato su confronti che utilizza un processo di risoluzione ricorsivo, sfruttando la tecnica del Divide et Impera, che consiste nella suddivisione del problema in sottoproblemi della stessa natura di dimensione via via più piccola. Fu inventato da John von Neumann nel 1945.
Concettualmente, l'algoritmo funziona nel seguente modo:
1. Se la lista da ordinare ha lunghezza 0 oppure 1, è già ordinata. Altrimenti:
2. La lista viene divisa (divide) in due metà (se la lista contiene un numero dispari di elementi, viene divisa in due sottoliste di cui la prima ha un elemento in più della seconda)
3. Ognuna di queste sottoliste viene ordinata, applicando ricorsivamente l'algoritmo (impera)
4. Le due sottoliste ordinate vengono fuse (combinate). Per fare questo, si estrae ripetutamente il minimo delle due sottoliste e lo si pone nella lista in uscita, che risulterà ordinata.

Nota: le funzioni utilizzano le variabili locali definite durante la chiamata della funzione (sono quelle che compaiono dopo la virgola). In newLISP le funzioni possono essere chiamate con un numero inferiore di argomenti: le variabili non passate dalla chiamata vengono inizializzate a nil e possiamo usarle come variabili locali. Il carattere "," è un simbolo che viene usato per separare le variabili passate da quelle locali.

Questa funzione combina due liste ordinate:

(define (merge a b , c)
  (while (and a b)
    (if (> (a 0) (b 0))
      (begin (push (b 0) c -1) (pop b))
      (begin (push (a 0) c -1) (pop a))
    )
  )
  (while a
    (push (a 0) c -1)
    (pop a))
  (while b
    (push (b 0) c -1)
    (pop b))
  c
)

(merge '(1 7 15) '(2 8 16))
;-> (1 2 7 8 15 16)

Questa funzione esegue il sort:

(define (mergesort a , n l1 l2)
  (set 'n (length a))
  (if (<= n 1)
    a
    (begin
      (dotimes (i (/ n 2))
        (push (pop a) l1 -1))
      (while a
        (push (pop a) l2 -1))
      (set 'l1 (mergesort l1))
      (set 'l2 (mergesort l2))
      (merge l1 l2)
    )
  )
)

(mergesort '(1 3 8 4 2 10 3))
;-> (1 2 3 3 4 8 10)

(mergesort (randomize (sequence 1 100)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;->  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
;->  92 93 94 95 96 97 98 99 100)

Proviamo a scrivere una versione leggermente diversa:

(define (merge1 a b , c)
  (while (and a b)
    (if (> (a 0) (b 0))
        (push (pop b) c -1)
        (push (pop a) c -1)
    )
  )
  (while a (push (pop a) c -1))
  (while b (push (pop b) c -1))
  c
)

(merge1 '(1 7 15) '(2 8 16))
;-> (1 2 7 8 15 16)

(define (mergesort1 a , n l1 l2)
  (set 'n (length a))
  (if (<= n 1)
    a
    (merge1 (mergesort(0 (/ n 2) a) ) (mergesort ((/ n 2) a)))
  )
)

(mergesort1 (randomize (sequence 1 100)))
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
;->  26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
;->  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91
;->  92 93 94 95 96 97 98 99 100)

Vediamo la differenza di velocità:

(silent (setq data (randomize (sequence 1 100000))))

(time (mergesort data) 10)
;-> 7724.649

(time (mergesort1 data) 10)
;-> 7466.869

Proviamo la funzione "sort" di newLisp:

(time (sort data) 10)
;-> 406.836

Nota: Questo algoritmo ha complessità temporale O(n log n) (sempre!).


-----------------------------
Cifre crescenti e decrescenti
-----------------------------

Scrivere un programma che genera una lista con le cifre da 1 a n e quelle da (n - 1) a 1. Ad esempio, se n = 5, il programma dovrebbe generare (1 2 3 4 5 4 3 2 1). È consentito utilizzare solo un singolo ciclo e 0 < n < 10.

Nella prima soluzione sfruttiamo il fatto che newLISP permette di aggiungere un elemento sia all'inizio che alla fine di una lista:

(define (cifre1 n)
  (let (out '())
    (push n out)
    ; ciclo unico
    (for (i (- n 1) 1 -1)
      (push i out)    ; aggiunge all'inizio della lista
      (push i out -1) ; aggiunge alla fine della lista
    )
    out))

(cifre1 5)
;-> (1 2 3 4 5 4 3 2 1)

Nella seconda soluzione utilizziamo la funzione "sequence":

(define (cifre2 n)
  (let (out '())
  (extend out (sequence 1 n) (sequence (- n 1) 1))))

(cifre2 5)
;-> (1 2 3 4 5 4 3 2 1)

Vediamo la velocità delle due funzioni:

(time (cifre1 9) 100000)
;-> 155.373

(time (cifre2 9) 100000)
;-> 79.931


---------------
Somma di numeri
---------------

Dati due interi positivi M e N, trovare N numeri che si sommano a M e la differenza tra il più alto e il più basso di questi numeri non dove essere più di uno. Ad esempio: con M = 26 e N = 7, il risultato è (4 4 4 4 4 3 3).

(define (somma n m)
  (let ((q (/ m n))
        (r (% m n)))
    (append (dup (+ q 1) r)
            (dup q (- n r)))))

(somma 7 26)
;-> (4 4 4 4 4 3 3)

(somma 2 10)
;-> (5 5)

(somma 5 11)
;-> (3 2 2 2 2)

(somma 11 3)
;-> (1 1 1 0 0 0 0 0 0 0 0)


----------------
Operatori logici
----------------

newLISP mette a disposizione gli operatori logici AND, OR e NOT. Possiamo scrivere altri operatori logici utilizzando quelli disponibili:

Funzioni booleane:

(define (nand a b) (not (and a b)))
(define (nor a b) (not (or a b)))
(define (xor a b) (if (nand a b) (or a b) nil))
(define (xnor a b) (not (xor a b)))

Funzioni bitwise:

(define (~& a b) (~ (& a b))) ; nand, bitwise
(define (~| a b) (~ (| a b))) ; nor, bitwise

Lo xor is è disponibile come funzione integratea "^":

(define (~^ a b) (~ (^ a b))) ; xnor, bitwise

Proviamo le funzioni:

(setq lst1 '(true true nil nil))
(setq lst2 '(true nil true nil))

(map and lst1 lst2)
;-> (true nil nil nil)

(map or lst1 lst2)
;-> (true true true nil)

(map nand lst1 lst2)
;-> (nil true true true)

(map nor lst1 lst2)
;-> (nil nil nil true)

(map xor lst1 lst2)
;-> (nil true true nil)

(map xnor lst1 lst2)
;-> (true nil nil true)

newLISP non opera una valutazione completa delle espressioni che contengono più di un operatore logico se una bvalutazione parziale è sufficiente per valutare correttamente il risultato:
Ad esempio:

(setq a nil)
(if (or (> 4 3) (setq a 10)))
;-> true

Poichè la prima espressione è vera (> 4 3) newLISP non valuta la successiva espressione (setq a 10) poichè non è necessaria per valutare l'intera espressione a "true":

a
;-> nil

Lo stesso con l'operatore AND:

(setq b nil)
(if (and (< 4 3) (setq b 10)))
;-> nil

Poichè la prima espressione è vera (< 4 3) newLISP non valuta la successiva espressione (setq b 10) poichè non è necessaria per valutare l'intera espressione a "nil":

b
;-> nil


------------
Quick Select
------------
QuickSelect è un algoritmo di selezione per trovare l'elemento K-esimo più piccolo in un elenco non ordinato.

Algoritmo
Dopo aver trovato il pivot (una posizione (indice) che suddivide la lista in due parti: ogni elemento a sinistra è inferiore al pivot e ogni elemento a destra è più grande del pivot) l'algoritmo ricorre solo per la parte che contiene il k-esimo elemento più piccolo.
Se l'indice dell'elemento partizionato (pivot) è superiore a k, l'algoritmo ricorre per la parte sinistra.
Se l'indice (pivot) è uguale a k, allora abbiamo trovato il k-esimo elemento più piccolo e viene restituito.
Se l'indice (pivot) è inferiore a k, l'algoritmo ricorre per la parte destra

Vediamo lo pseudocodice:

A) Selezione
quickSelect(list, left, right, k)
   if left = right
      return list[left]
   // Select a pivotIndex between left and right
   pivotIndex := partition(list, left, right, pivotIndex)
   if k = pivotIndex
      return list[k]
   else if k < pivotIndex
      right := pivotIndex - 1
   else
      left := pivotIndex + 1

B) Partizione
La partizione è trovare il pivot come menzionato sopra. (Ogni elemento a sinistra è inferiore al pivot e ogni elemento a destra è più grande del pivot) Esistono due algoritmi per trovare il pivot della partizione: Lomuto e Hoare

Partizione Lomuto
Questa partizione sceglie un pivot che in genere è l'ultimo elemento della lista. L'algoritmo mantiene l'indice i mentre esegue la scansione della lista utilizzando un altro indice j in modo tale che gli elementi da i (compresi) siano minori o uguali al pivot e che gli elementi da i+1 a j-1 (inclusi) siano maggiori del pivot.
Questo schema degrada a O (n^2) quando la lista è ordinata.

Lomuto(A, lo, hi) is
   pivot := A[hi]
   i := lo
   for j := lo to hi - 1 do
       if A[j] < pivot then
           if i != j then
               swap A[i] with A[j]
           i := i + 1
   swap A[i] with A[hi]
   return i

Partizione Hoare
Hoare utilizza due indici che iniziano alle estremità della lista da partizionare, quindi si muovono l'uno verso l'altro fino a quando non rilevano un'inversione: una coppia di elementi, uno maggiore o uguale al pivot, uno inferiore o uguale al pivot, che sono nell'ordine sbagliato l'uno rispetto all'altro.
Gli elementi invertiti vengono quindi scambiati. Quando gli indici si incontrano, l'algoritmo si interrompe e restituisce l'indice finale. Esistono molte varianti di questo algoritmo.

Hoare(A, lo, hi) is
   pivot := A[lo]
   i := lo - 1
   j := hi + 1
   loop forever
       do
           i := i + 1
       while A[i] < pivot
       do
           j := j - 1
       while A[j] > pivot
       if i >= j then
           return j
       swap A[i] with A[j]

Implementazione
Per definire questa funzione non seguiremo lo pseudocodice, ma utilizzeremo le primitive di newLISP perchè sono più veloci (in particolare la funzione "sort").
Il parametro k può variare da 1 fino alla lunghezza della lista.

(define (kthsmall lst k)
  (cond ((or (> k (length lst)) (< k 1)) nil)
        (true ((sort lst) (- k 1)))))

(kthsmall '(7 10 4 3 20 15) 1)
;-> 3
(kthsmall '(7 10 4 3 20 15) 6)
;-> 20
(kthsmall '(7 10 4 3 20 15) 0)
;-> nil
(kthsmall '(7 10 4 3 20 15) 7)
;-> nil

Con questo metodo possiamo anche definire la funzione "kthbig":

(define (kthbig lst k)
  (cond ((or (> k (length lst)) (< k 1)) nil)
        (true ((sort lst >) (- k 1)))))

(kthbig '(7 10 4 3 20 15) 1)
;-> 20
(kthbig '(7 10 4 3 20 15) 6)
;-> 3
(kthbig '(7 10 4 3 20 15) 0)
;-> nil
(kthbig '(7 10 4 3 20 15) 7)
;-> nil


------------------
Macchina di Turing
------------------

Una macchina di Turing (o più brevemente MdT) è una macchina ideale che manipola i dati contenuti su un nastro di lunghezza potenzialmente infinita, secondo un insieme prefissato di regole ben definite. In altre parole, è un modello astratto che definisce una macchina in grado di eseguire algoritmi e dotata di un nastro potenzialmente infinito su cui vengono letti o scritti dei simboli.

È un potente strumento teorico che viene usato nella teoria della calcolabilità e nello studio della complessità degli algoritmi, in quanto è di notevole aiuto nel comprendere i limiti del calcolo meccanico. La sua importanza è tale che oggi, per definire in modo formalmente preciso la nozione di algoritmo, si tende a ricondurlo alle elaborazioni effettuabili con macchine di Turing.

La MdT come modello di calcolo è stata introdotta nel 1936 da Alan Turing per dare risposta all'Entscheidungsproblem (problema di decisione) proposto da Hilbert nel suo programma di fondazione formalista della matematica.
La questione di Hilbert era la seguente: «esiste sempre, almeno in linea di principio, un metodo meccanico (cioè una metodo rigoroso) attraverso cui, dato un qualsiasi enunciato matematico, si possa stabilire se esso sia vero o falso?»

Nel 1936 Turing pubblicò un articolo intitolato "On computable numbers, with an application to the Entscheidungsproblem", in cui l'autore risolveva negativamente l'Entscheidungsproblem o problema della decidibilità lanciato nel 1900 da David Hilbert e Wilhelm Ackermann.

La soluzione proposta da Turing consiste nell'utilizzo di un modello matematico capace di simulare il processo di calcolo umano, scomponendolo nei suoi passi ultimi.
La macchina è formata da una testina di lettura e scrittura con cui è in grado di leggere e scrivere su un nastro potenzialmente infinito partizionato, in maniera discreta, in caselle. Ad ogni istante di tempo t1, la macchina si trova in uno stato interno s1 ben determinato, risultato dell'elaborazione compiuta sui dati letti.

Lo stato interno, o configurazione, di un sistema è la condizione in cui si trovano le componenti della macchina ad un determinato istante di tempo t. Le componenti da considerare sono:

- il numero della cella osservata
- il suo contenuto
- l'istruzione da eseguire

Tra tutti i possibili stati, si distinguono:

- una configurazione iniziale, per t=t0 (prima dell'esecuzione del programma)
- una configurazione finale, per t=tn (al termine dell'esecuzione del programma)
- delle configurazioni intermedie, per t=ti (prima dell'esecuzione dell'istruzione oi)

Implementare un algoritmo in questo contesto significa effettuare una delle quattro operazioni elementari:

- spostarsi di una casella a destra
- spostarsi di una casella a sinistra
- scrivere un simbolo preso da un insieme di simboli a sua disposizione su una casella
- cancellare un simbolo già scritto sulla casella che sta osservando
- oppure fermarsi

Eseguire un'operazione o1, tra gli istanti di tempo t1 e t2, vuol dire passare dallo stato interno s1 allo stato s2. Più formalmente questo si esprime in simboli come: {s1,a1,o1,s2} da leggersi come: nello stato interno s1 la macchina osserva il simbolo a1, esegue l'operazione o1 e si ritrova nello stato interno s2.
Turing poté dimostrare che un tale strumento è in grado di svolgere un qualsiasi calcolo, ma non si fermò qui: egli capì che la calcolabilità era parente stretta della dimostrabilità e dunque, così come Gödel aveva distrutto i sogni di gloria dei Principia Mathematica di Russell e Whitehead, così le sue macchine potevano definitivamente chiudere la questione dell'Entscheidungsproblem.

L'importanza della MdT deriva dal fatto che permette di compiere tutte le elaborazioni effettuate da tutte le macchine (elettroniche o meccaniche) apparse nella storia dell'umanità, incluse le elaborazioni degli odierni computer, e perfino tutte le dimostrazioni matematiche conosciute.
Infatti, tutte le macchine che si conoscono possono essere ricondotte al modello estremamente semplice di Turing.

Per ogni problema calcolabile esista una MdT in grado di risolverlo: questa è la cosiddetta congettura di Church-Turing, la quale postula in sostanza che per ogni funzione calcolabile esista una macchina di Turing equivalente, ossia che l'insieme delle funzioni calcolabili coincida con quello delle funzioni ricorsive (tuttavia, questa congettura riguarda la calcolabilità degli algoritmi, e non la loro trattabilità).

Gli algoritmi che possono essere implementati da una MdT si dicono "algoritmi Turing-computabili".

Si conoscono diverse varianti della MdT, ma sono tutte equivalenti. Noi useremo una macchina di Turing deterministica formata da un nastro con istruzioni a cinque campi.

Spiegazione informale
---------------------
La macchina può agire sopra un nastro che si presenta come una sequenza di caselle nelle quali possono essere registrati simboli di un ben determinato alfabeto finito. Essa è dotata di una testina di lettura e scrittura (I/O) con cui è in grado di effettuare operazioni di lettura e scrittura su una casella del nastro. La macchina si evolve nel tempo e ad ogni istante si può trovare in uno stato interno ben determinato facente parte di un insieme finito di stati. Inizialmente sul nastro viene posta una stringa che rappresenta i dati che caratterizzano il problema che viene sottoposto alla macchina. La macchina è dotata anche di un repertorio finito di istruzioni che determinano la sua elaborazione in conseguenza dei dati iniziali. L'elaborazione si sviluppa per passi successivi che corrispondono a una sequenza discreta di istanti successivi. Le proprietà precedenti sono comuni a molte macchine formali (automa a stati finiti, automa a pila, ...). Caratteristica delle MdT è quella di disporre di un nastro potenzialmente infinito, cioè estendibile quanto si vuole qualora questo si renda necessario.

Ogni passo dell'elaborazione viene determinato dallo stato attuale s nel quale la macchina si trova e dal carattere c che la testina di I/O trova sulla casella del nastro su cui è posizionata e si concretizza nell'eventuale modifica del contenuto della casella, nell'eventuale spostamento della testina di una posizione verso destra o verso sinistra e nell'eventuale cambiamento dello stato. Quali azioni vengono effettuate a ogni passo viene determinato dalla istruzione, che supponiamo unica, che ha come prime due componenti s e c. Le altre tre componenti dell'istruzione forniscono nell'ordine il nuovo stato, il nuovo carattere e una richiesta di spostamento verso sinistra, nullo o verso destra.

Un'elaborazione della macchina consiste in una sequenza di sue possibili "configurazioni", ogni configurazione essendo costituita dallo stato interno attuale, dal contenuto del nastro (una stringa di lunghezza finita) e dalla posizione sul nastro della testina di I/O. Nei casi più semplici l'elaborazione ad un certo punto si arresta in quanto non si trova nessuna istruzione in grado di farla proseguire. Si può avere un arresto in una configurazione "utile" dal punto di vista del problema che si vuole risolvere, in tal caso quello che si trova registrato sul nastro all'atto dell'arresto rappresenta il risultato dell'elaborazione. Si può avere però anche un arresto "inutile" che va considerato come una conclusione erronea dell'elaborazione. Può anche accadere che un'elaborazione non abbia mai fine (Problema della fermata).

Spiegazione formale
-------------------
Si definisce macchina di Turing deterministica a un nastro e istruzioni a cinque campi, termine che abbreviamo con MdT1n5i, una macchina formale della seguente forma:

T = <S, s0, F, A, β, δ> dove

S è un insieme finito detto insieme degli stati della macchina;

s0 è un elemento di S detto stato iniziale della T;

F è un sottoinsieme di S detto insieme degli stati finali della T;

A è un alfabeto finito detto alfabeto del nastro della T
β è un carattere dell'alfabeto A detto segno di casella vuota del nastro della T

δ : S x A -> S x A x {-1, 0, +1} è detta funzione di transizione della macchina.

Se δ(s,a) = <t,b,m>, la corrispondente quintupla <s,a,t,b,m> può considerarsi come l'istruzione che viene eseguita quando la macchina si trova nello stato "s" e la testina di I/O legge "a" sulla casella sulla quale è posizionata. Essa comporta la transizione allo stato "t", la scrittura del carattere "b" e:

- quando m = -1 lo spostamento della testina di una posizione a sinistra,
- quando m = 0 nessuno spostamento della testina,
- quando m = +1 lo spostamento della testina di una posizione a destra.

Il problema dell'arresto e la sua indecidibilità
------------------------------------------------
In talune circostanze può essere utile considerare una MdT che presenta un'evoluzione illimitata (infatti si considerano infinite le risorse di spazio e tempo a disposizione della macchina). Ad esempio interessa far procedere "illimitatamente" (cioè "quanto risulta utile") una MdT che genera gli elementi di una successione di oggetti (ad es. i successivi numeri primi, o i successivi numeri di Mersenne, o le successive cifre decimali di un numero irrazionale come pi greco). In altri casi invece un'evoluzione illimitata di una MdT è considerata un insuccesso. Quando si vuole che una MdT ricerchi in un insieme numerabile un elemento con determinate caratteristiche ed essa procede nella ricerca senza fornire alcuna indicazione, ci si trova in una situazione decisamente insoddisfacente: non si sa se interrompere un'elaborazione inutile oppure attendere ancora un risultato che potrebbe essere fornito dopo un ulteriore lavoro in tempi accettabili.

È dunque importante poter stabilire se una MdT, o un altro sistema formale equivalente ("lambda-calcolo" di Church, ad es.), quando le si sottopone una stringa (di dati) si arresti o meno. Questo è detto problema della fermata o problema dell'arresto della macchina di Turing. Si trovano casi nei quali si dimostra o si verifica che si ha l'arresto, casi per i quali si dimostra che l'evoluzione non si arresta (ma potrebbe procedere all'infinito) e casi per i quali non si sa dare risposta.

Sembra ragionevole cercare un procedimento generale per decidere uno di questi problemi. Dato che le MdT si rivelano in grado di risolvere tutti i problemi che si sanno risolvere con gli altri procedimenti noti, è sensato chiedersi se esiste una macchina di Turing in grado di decidere per una qualsiasi coppia (M, d) costituita da una MdT M e da una stringa di dati d se, quando si fornisce d a M, questa si evolve fino ad arrestarsi o meno. Questa richiesta è resa ancor più significativa dall'esistenza, dimostrata dallo stesso Turing, di una cosiddetta macchina di Turing universale, macchina in grado di simulare qualsiasi evoluzione di qualsiasi MdT (anche le evoluzioni di se stessa!). Ebbene Turing ha dimostrato che la macchina di Turing universale non è in grado di decidere in ogni caso il problema dell'arresto. Quindi nessuna macchina di Turing può farlo. Questo risultato negativo si esprime dicendo che il problema dell'arresto è Turing-indecidibile. Se si accetta la congettura di Church-Turing sulla portata della macchina di Turing, si conclude che il problema dell'arresto della macchina di Turing è indecidibile.

Questo risultato negativo costituisce un limite per tutti i meccanismi computazionali: esso costituisce un risultato limitativo di grande importanza generale e per lo studio degli algoritmi. L'importanza generale dipende dal fatto che ogni procedimento dimostrativo automatico si trova equivalente a una computazione che può effettuarsi con una macchina di Turing. Va posto in rilievo che la Turing-indecidibilità del problema dell'arresto si dimostra equivalente al teorema di incompletezza di Gödel, il primo fondamentale risultato limitativo per la matematica. Si trova inoltre nello studio degli algoritmi e della loro complessità che dalla indecidibilità dell'arresto si deducono abbastanza agevolmente molti altri risultati limitativi.

Macchina di Turing Universale
-----------------------------
Il problema con le MdT è che è necessario costruirne una diversa per ogni nuovo calcolo da eseguire, per ogni relazione di input/output.
Questo è il motivo per cui introduciamo l'idea di una macchina di turing universale (MdTU), che prende come parametri di ingresso sia i dati di input sul nastro che la descrizione di una MdT. La MdTU può continuare quindi a simulare la MdT sul resto del contenuto del nastro di input. Una macchina di turing universale può quindi simulare qualsiasi altra macchina.

=============================================================================

