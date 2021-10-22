===============

 NOTE LIBERE 6

===============

In questo documento sono tradotti alcuni post del blog di Kazimir Marjoncic del sito:

http://kazimirmajorinc.blogspot.com/

Kazimir è un vero esperto sul linguaggio LISP e approfondisce in modo molto interessante alcune caratteristiche di newLISP.
ALcune parti dei codici di esempio sono state aggiornate alla versione 10.7.5 di newLISP.
I commenti ai post non sono stati tradotti.

Tutti i diritti sono di Kazimir Marjoncic.

---------------------
Starting with newLISP
---------------------
http://kazimirmajorinc.blogspot.com/2008/05/starting-with-newlisp-blog.html

Ho deciso che nei prossimi mesi, e forse più a lungo, utilizzerò il linguaggio di programmazione newLISP. Il motivo principale è che ho riconosciuto alcune caratteristiche importanti coerenti con i principali obiettivi di progettazione di Lisp e, credo, forniscono funzionalità potenti e astratte che rendono i problemi algoritmici complessi, in particolare i problemi di intelligenza artificiale più facili da risolvere. Negli ultimi decenni, sembra che i dialetti Lisp abbiano trascurato lo sviluppo della lingua centrale, invece, gli sforzi sembrano essere investiti principalmente nella produzione di implementazioni più adatte all'uso pratico.

Valutazione (eval) senza limitazioni
------------------------------------
La funzione "eval" è la pietra angolare del paradigma "code=data" per cui Lisp è noto. Se il codice viene trattato come dati, significa che può essere elaborato e valutato durante il runtime. La valutazione del codice è fornita attraverso l'applicazione della funzione "eval" sulla pace del codice. In qualche modo sorprendentemente, sia Common Lisp che Scheme implementano una versione in qualche modo ristretta di eval, ovvero una che non vede "variabili locali". La valutazione di newLISP non è limitata in questo modo.

(let ((a 1) (b 2))
      (println (eval '(+ a b))))

Questo codice restituisce 3 in newLISP, mentre in altri dialetti Lisp questo codice produce l'errore "variabile non definita/non associata". Alcuni utenti Lisp affermano che eval senza restrizioni impedisce alcune ottimizzazioni durante la compilazione del codice. Forse - ma affermare che qualche caratteristica astratta dovrebbe essere scartata perché lenta è stranamente radicale e ingiustificata: si può semplicemente usarla quando il tempo non è critico, ed evitarla se lo è. Non penso che dovrebbe essere accettato come normale che linguaggi come Python abbiano "eval" più potenti di Common Lisp o Scheme.

Macro di prima classe
---------------------
Inoltre, newLISP ha macro semplici ma potenti. In newLISP, le macro sono proprio come le funzioni, tranne per il fatto che accettano argomenti non valutati. Sono "cittadini di prima classe", valori che possono essere utilizzati nelle espressioni ed essere il risultato della valutazione delle espressioni. Possono essere passati come argomenti e restituiti come risultati delle funzioni o di altre macro. Le macro newLISP sono più facili da scrivere perché possono eseguire direttamente determinate attività, invece di generare codice che eseguirà tale attività. Come puoi vedere nell'esempio seguente, non sono necessarie virgolette e virgole.

(set 'my-print (lambda-macro(x)
                 (print "(-> " x " " (eval x )")")))

(my-print (+ 3 7))
;-> (-> (+ 3 7) 10)

I vecchi Lisp, negli anni '70, avevano questa caratteristica. È stato chiamato fexpr ma è stato abbandonato a favore delle macro come le conosciamo in questi giorni.

La critica di Pitman a Fexpr
----------------------------
Da Wikipedia,
alla "Conference on Lisp and Functional Programming del 1980", Kent Pitman presentò un documento "Special Forms in Lisp" in cui discuteva i vantaggi e gli svantaggi di macro e feexprs e alla fine condannò fexprs. La sua obiezione centrale era che, in un dialetto Lisp che consente fexprs, l'analisi statica non può determinare generalmente se un operatore rappresenta una funzione ordinaria o un feexpr - quindi, l'analisi statica non può determinare se gli operandi verranno valutati o meno. In particolare, il compilatore non è in grado di stabilire se una sottoespressione può essere ottimizzata in modo sicuro, poiché la sottoespressione potrebbe essere trattata come dati non valutati in fase di esecuzione.

Questo è un argomento simile a quello per la restrizione di "eval". Non solo ignorare la potente funzionalità perché non può essere ottimizzata è una decisione ingiustificata, ma in questo caso particolare, non è nemmeno vero che fexpr non può essere ottimizzato. Se le fexpr Lisp (macro newLISP) sono scritte nello stesso stile delle macro Lisp equivalenti e le chiamate feexpr sono inline, allora forniscono esattamente le stesse opportunità di ottimizzazione delle chiamate macro Lisp. La valutazione delle chiamate macro di Common Lisp è separata in due fasi: macroespansione e valutazione del codice macroespanso. Di solito, anche se non sempre, l'espansione macro non dipende da alcun valore noto solo in runtime, quindi l'espansione macro può essere eseguita durante la fase di compilazione. Ma in tali casi, parti della chiamata fexpr equivalente e inline possono essere valutate e ottimizzate durante la fase di compilazione allo stesso modo. L'implementazione di newLISP non lo fa, è un interprete - nessun problema per me, tendo a non preoccuparmi per niente del processo di compilazione - ma tali ottimizzazioni sono tuttavia possibili.

Un altro motivo per cui Pitman preferisce le macro Lisp rispetto ai fexprs Lisp è che desidera una sorta di analisi automatica del codice. Ad esempio, supponiamo che si voglia definire la macro Lisp (USED-ON-PARTICULAR-WAY [variabile] [espressione]) che restituisce 1 se, beh, se [variabile] è usato sul modo particolare in [espressione], e 0 se non lo è. Se [espressione] contiene macro, queste macro possono essere espanse in USED-ON-PARTICULAR-WAY (usando MACROEXPAND di Common Lisp) e analizzate in modo che USED-ON-PARTICULAR-WAY possa trovare la risposta di cui ha bisogno. Non può essere fatto se [espressione] contiene fexprs invece di macro. Le fexprs sono come scatole nere e USED-ON-PARTICULAR-WAY non possono vedere cosa succede al loro interno. Pitman ha parzialmente ragione. In parte, perché non è escluso che [variabile] sia comunque utilizzata in modo particolare durante la fase di macroespansione, e non sia visibile nel codice macroespanso! Il codice macroespanso non contiene necessariamente tutte le informazioni rilevanti. Ma se supponiamo che l'analisi automatica della fase di macroespansione non sia necessaria, qualunque sia la ragione, sì, ha ragione. Tuttavia, le macro di newLISP risolvono anche questo problema e si rivelano ancora più "trasparenti" e adatte al tipo di analisi che sostiene. Ecco perché:

Funzioni e macro sono le loro definizioni
-----------------------------------------
In Common Lisp e Scheme, le funzioni sono tipi speciali di valori risultanti dalle valutazioni delle loro definizioni. Possono essere usati come valori e applicati, ma le loro definizioni non sono accessibili e non possono essere analizzati e modificati durante il runtime. In newLISP, le funzioni non sono risultati della valutazione delle definizioni, sono esattamente la stessa cosa delle loro definizioni. Quindi, possono essere analizzati (e mutati) durante il runtime. E lo stesso vale per le macro newLISP. L'esempio seguente dimostra tale funzionalità.

(set 'my-print (lambda-macro(x)
                 (print "(->" x " " (eval x ) ")" )))

(set 'replace-print-with-println
      (lambda-macro(f)
         (set-nth 1
                 (eval f)
                 (append '(println) (rest (nth 1 (eval f)))))))

(println my-print)
(replace-print-with-println my-print)
(println my-print)

; Output:                                                      
;(lambda-macro (x) (print "(->" x " " (eval x) ")"))           
;(lambda-macro (x) (println "(->" x " " (eval x) ")"))  

Quindi, sì, le macro newLISP e persino le funzioni newLISP possono essere analizzate da altre funzioni e macro, e questo è un miglioramento sostanziale nello spirito del paradigma "code=data".

Problemi del mondo reale
------------------------
newLISP è un nuovo linguaggio, sviluppato da un uomo, lo psicologo e scienziato informatico americano Lutz Mueller e ha una piccola comunità di utenti e contributori, quindi ha meno funzionalità rispetto ad alcune implementazioni mature di Common Lisp e Scheme. Tuttavia, nessuna delle funzionalità mancanti sembra essere essenziale per i miei programmi e, si spera, se il linguaggio stesso avrà successo, le librerie newLISP e le funzionalità native cresceranno. Sebbene abbiamo visto che newLISP supera altri dialetti Lisp in termini di potenza espressiva della lingua principale, l'autore afferma che il linguaggio è sviluppato principalmente "per essere utile per risolvere problemi del mondo reale" e che "cose ​​come espressioni regolari, funzioni di rete e supporto per popolari protocolli come XML o HTTP sono tutti integrati in newLISP senza la necessità di librerie esterne." Alcuni utenti di newLISP affermano di aver attivato newLISP proprio per questo, non per le funzionalità astratte che ho elencato.

Gestione della memoria
----------------------
La mia unica preoccupazione è che newLISP non consente che le strutture dati condividano parti comuni in memoria. Altri utenti di Lisp lo menzionano spesso come un punto debole, e sembra così a prima vista. Tuttavia, in questo momento, non sono in grado di stimare tutte le conseguenze di quella politica, quindi mi baso sull'aspettativa che Mueller, che è stato in grado di migliorare da solo le basi del Lisp, non abbia commesso errori significativi in ​​questa parte del linguaggio. Spero che imparerò come compensare questa limitazione. Una possibilità potrebbe essere nello sfruttamento dei fatti che le strutture dati possono, tuttavia, contenere gli stessi simboli e i simboli possono essere usati come riferimenti di strutture dati.

(set 'x (list 1 2))
(set 'a 'x)
(set 'b 'x)
(eval a)
;-> (1 2)
(setf ((eval a) 0) 2)
;-> 2
(eval a)
;-> (2 2)
x
;-> (2 2)

(print-expr-and-value-lns a b (eval a) (eval b))

;Results in:
;(-> a x)
;(-> b x)
;(-> (eval a) (2))
;(-> (eval b) (2))

Tornerò sicuramente sull'argomento nei prossimi mesi.

Commenti
--------
*** Anonymous9 May 2008 at 15:36

"... and symbols can be used as references of data structures"

Yes, and this is how you can do it in 9.3.0. A trivial example how to do reference passing:

(define foo:data '(a b c d e f))

(define (pop-last aList)
(pop aList:data -1))

(pop-last foo) => f

foo:data => (a b c d e)

Additionally in development version 9.3.11 and after you can do:

(define foo:foo '(a b c d e f))

(define (pop-last aList)
(pop aList -1))

(pop-last foo) => f

foo:foo => (a b c d e)

foo:foo is called the "default functor" (usage of the namespace name "foo" defaults to the symbol in it of the same name "foo:foo").

*** Anonymous9 May 2008 at 18:33

..previous commentator already said what I was going to add ;))

[1] I.e. if a symbol is declared as belonging to some "context", then newLISP keeps it as a static var, and its use in other expressions will automatically reuse "the same parts".

One can freely copy from a context-defined symbols. For example if I have a string a:string, then, say, some function

(reverse (string a:string))

which on the surface uses redundant cast into string of what is already a string in fact creates a COPY of the original a:string, and if this hypothetical reverse is destructive, it won't affect the original a:string.

No such trick - and you'll be changing the original.

[2] "Contexts" are in my view a nice and powerful instrument. Actually, each "context" is a "hash", to use a Perl term (a red-black tree), and can even get back its symbols in alphabetical order, which is sometimes nice for kind-of built-in sorting without extra overhead.
(see the "dotree" operator)


-------------------------------
Embedding Blocks into Functions
-------------------------------

; I'm trying to "embed" blocks into functions or macros, they
; can be useful for calls similar to
;
; (help function)
; (test f)
;
; etc. There are lot of ways it can be done, for example, using
; contexts. Or closures where available. Or hash tables containing
; functions for tests and help. But i tried this one.

;---------------------------------------------------------------
; I want to use "function" and "macro" as keywords
; instead of "lambda" and "lambda-macro"

(set 'function
    (lambda-macro()
        (eval (append '(lambda) (args)))))
        
(set 'macro
    (lambda-macro()
        (eval (append '(lambda-macro) (args)))))

; Tests: later

;---------------------------------------------------------------
; One macro useful for printing. I learnt that I almost always
; use output in this form. In the same time, test for "macro"

(set 'expression-and-value
    (macro(x)
        (list '-> x (eval x))))
        
; Tests:

                    (println expression-and-value)
                    (println (expression-and-value (+ 3 3)))

; Results:

;(lambda-macro (x) (list '-> x (eval x)))
;(-> (+ 3 3) 6)

;---------------------------------------------------------------
; As expression-and-value is used almost exclusively in print
; and it is frequently used, it justifies definition of one
; special print functions, with a very short name.
; I'll use this name: §

(set '§ (macro()
         (doargs(x)
           (println (eval (list 'expression-and-value x))))))


; Test (it is enough to test §)

                                (set 'z 1)
                                (§ z (sin z) (+ z 4))

; Result:

;(-> z 1)
;(-> (sin z) 0.8414709848);
;(-> (+ z 4) 5)

;---------------------------------------------------------------
; I define block as non-empty list. Intention is to make
; generalization of begin-block. Following functions are very
; simple and they do not require any comments.

(set 'block?
     (function(candidate)
              (if (list? candidate)
                  (not (empty? candidate)))))

; Tests:

        (§ (block? '(hello-world (println "hello, world"))))
        (§ (block? '()))
        (§ (block? 3))
        (§ (block? '(nil print)))

; Results:

;(-> (block? '(hello-world (println "hello, world"))) true)
;(-> (block? '()) nil)
;(-> (block? 3) nil)
;(-> (block? '(nil print)) true)

;---------------------------------------------------------------
(set 'get-block-name
     (function(some-block)
              (if (not (block? some-block))
                  (throw-error (list "get-block-name applied on non-block"
                                     some-block))
                  (first some-block))))

;Tests

          (§ (get-block-name '(hello (println "hello"))))

;(§ (get-block-name '()))
;(§ (get-block-name 3))

; Results:

;(-> (get-block-name '(hello (println "hello"))) hello)
; other two really return excpected error

;---------------------------------------------------------------
(set 'quoted-block?
     (function(candidate)
         (if (quote? candidate)
             (block? (eval candidate)))))
             
; Tests:

                (§ (quoted-block? ''(hello (println "hello!"))))
                (§ (quoted-block? ''()))
                (§ (quoted-block? '3))
                (§ (quoted-block? ''(nil print)))

; Results:

;(-> (quoted-block? ''(hello (println "hello!"))) true)
;(-> (quoted-block? ''()) nil)
;(-> (quoted-block? '3) nil)
;(-> (quoted-block? ''(nil print)) true)

;---------------------------------------------------------------

(set 'begin-block-from-any-block
     (function(some-block)
              (append '(begin)
                      (rest some-block))))

; Test:

                    (§ (begin-block-from-any-block
                                  '(hello (println "Hello!"))))

; Result: works OK

;---------------------------------------------------------------

(set 'get-block-from-list-containing-quoted-blocks
     (function(block-name list-containing-quoted-blocks)
              (catch (dolist (i list-containing-quoted-blocks)
                        (if (and (quoted-block? i)
                                 (= block-name
                                    (get-block-name (eval i))))
                            (throw (eval i)))))))

; Tests:

          (§ (get-block-from-list-containing-quoted-blocks
                  'test
                  (list ''(wrong) '(test) 0 ''(test) '(false))))
          (§ (get-block-from-list-containing-quoted-blocks
                  'test
                  (list '(wrong) '(right) 0 '(false))))
          (§ (get-block-from-list-containing-quoted-blocks
                  'test
                  (list)))
          (§ (get-block-from-list-containing-quoted-blocks
                  'test
                  '()))

; Results: everything works OK

;---------------------------------------------------------------

(set 'evaluate-block-from-list-containing-quoted-blocks
     (function (block-name list-containing-quoted-blocks)
               (eval (begin-block-from-any-block
                         (get-block-from-list-containing-quoted-blocks
                              block-name
                              list-containing-quoted-blocks)))))

;---------------------------------------------------------------
; OK, everything is ready for a final test.
; I'll define one cute function, "integer-quote" with two cute
; blocks, "help" and "test," and see what happens.

(set 'integer-quote
    (macro(i expr)
    '(help
        (println "\nInteger-guote help:")
        (println "  Syntax: (integer-quote <integer> <expression>)")
        (println "  Example: " (expression-and-value (integer-quote 2 x)))
        (println "  Example: " (expression-and-value (integer-quote -3 x)))
        (println "  Example: " (expression-and-value (integer-quote 0 x)))
        (println "End of integer-quote help.\n"))
    '(test
        (println "\nInteger-quote test:")
        (if (= (integer-quote 2 x) '(quote (quote x)))
            (println "  First test passed.")
            (println "  First test failed."))
        (if (= (integer-quote -3 x) '(eval (eval (eval x))))
            (println "  Second test passed.")
            (println "  Second test failed."))
        (if (= (integer-quote 0 x) 'x)
            (println "  Third test passed.")
            (println "  Third test failed."))
        (println "End of quote-eval test.\n"))
    (cond
        ((= i 0) expr)
        ((> i 0) (eval (list 'integer-quote
                                (- i 1)
                                (list 'quote expr))))
        ((< i 0) (eval (list 'integer-quote
                                (+ i 1)
                                (list 'eval expr)))))))
                                
;---------------------------------------------------------------
; Tests

(println "\n\n\nOK, let me see how it works.")

(evaluate-block-from-list-containing-quoted-blocks 'help integer-quote)
(evaluate-block-from-list-containing-quoted-blocks 'test integer-quote)
(§ (integer-quote -7 (i-o-lets-go!)))

;Results

;Integer-guote help:
;  Syntax: (integer-quote <integer> <expression>)
;  Example: (-> (integer-quote 2 x) (quote (quote x)))
;  Example: (-> (integer-quote -3 x) (eval (eval (eval x))))
;  Example: (-> (integer-quote 0 x) x)
;End of integer-quote help.

;Integer-quote test:
;  First test passed.
;  Second test passed.
;  Third test passed.
;End of quote-eval test.

;(-> (integer-quote -7 (i-o-lets-go!))
;(eval (eval (eval (eval (eval (eval (eval (i-o-lets-go!)))))))))

;Everything works fine.
;Sure, i can use shorter names.
=============================================================================

