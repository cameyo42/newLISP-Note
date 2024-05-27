=======================

 KAZIMIR MAJORINC BLOG

=======================

In questo documento sono presentati alcuni post del blog di Kazimir Majorinc presenti nel sito:

http://kazimirmajorinc.blogspot.com/

Kazimir è un vero esperto sul linguaggio LISP e approfondisce in modo molto interessante alcune caratteristiche di newLISP (in particolar modo quelle proprie della famiglia dei linguaggi LISP).
Alcune parti del codice di esempio sono state aggiornate alla versione 10.7.5 di newLISP.
I sorgenti e i commenti ai post non sono stati tradotti.

Tutti i diritti sono di Kazimir Majorinc.

Indice degli articoli
---------------------
  Starting with newLISP
  Embedding blocks into Functions
  Evaluation of Large Expressions in Newlisp
  Eval and Anti-eval
  Promote Your Functions!
  Assignment Macro Beast Unleashed
  Does the Function Really Evaluate to Itself?
  New Copies Discovered
  If lambda Gives let, What About lambda-macro?
  Verbose Functions and Macros
  On Calling and Applying Newlisp Functions and Macros
  Conversions to Functions and Macros
  Speed of The Evaluation vs. Length of The Names of The Variables
  Exploring The Reference
  Three Techniques for Avoidance of Multiple Copies
  For-like Syntax for Rnd Function and Generalized Floor and The Friends
  Light Your Pipe
  Two Phases Evaluation
  The Predicates =?, >? and Friends
  Majorinc.default-library.lsp uploaded
  Macrocall
  Don't Fear Dynamic Scope
  Don't Fear Dynamic Scope (2)
  Swap Without Temporary Variable
  Short or Long Function Names?
  Avoiding Function Names Clashes
  Two Definitions of IF Function
  Challenged by Common Lispers
  Test for Unnecessary Arguments
  Calculate or Ask
  Apply Has Its Secrets Too
  Random Sublists
  Trees, Branches and Leaves
  The Most Probable Cond
  More on Usenet and Google Groups Posting Frequency
  Where is Letex!
  Multiple Loops
  Add and Multiply Digits
  The First Use of Identity Function
  Text Titles
  Quote is Identity Fexpr
  Gensym and Genlet
  Genlocal
  Genloops
  Supernatural Symbols
  On Macros, Eval and Generated Code in Lisp
  Crawler Tractor
  Supressed Printing
  On Serial Substitution and Not Reading The Manual
  Propositional Variables and Formulas
  Reader Macros in Newlisp?
  eval-string or eval?
  Random Propositional Formulas of a Given Average Length
  On Expected Truth Value of a Random Propositional Formula
  On Expected Truth Value of a Random Propositional Formula (2)
  The Probability That Random Propositional Formula is Tautology
  Lists of Propositional Formulas
  Debug-wrapping Around Built-in Primitives
  One Hundred Propositional Tautologies (1)
  One Hundred Propositional Tautologies (2)
  Opinions on Eval in Lisp, Python and Ruby - The Result of The Pool
  Why You Do Not Use Lisp? The Results of The Poll
  One Hundred Propositional Tautologies (3)
  One Hundred Propositional Tautologies (4)
  One Hundred Propositional Tautologies (5)
  Tortelvis
  Relatively Short Propositional Formulas and Symbols Instead of Pointers and Tables
  Symbols as Sexprs and Hygienic Fexprs
  Alan Kay on Lisp and Fexprs
  Composition of Functions or Macros
  Composing Fexprs Preserves Short-circuit Evaluation.
  How many syllogisms are there?
  The program for derivation of syllogisms, condense...
  McCarthy - Dijkstra short polemics in 1976.
  Interesting Case of Mismatched Parentheses.
  Short notes on McCarthy's "Recursive Functions ... "
  Using (sin cos 0.5) instead of (sin (cos 0.5)) in Newlisp
  McCarthy's 1960 "Recursive Functions ..." Lisp in Newlisp
  McCarthy-60 Lisp Implemented as Association List in McCarthy-60 Lisp
  McCarthy-60 Lisp in McCarthy-60 Lisp in ... in McCarthy-60 Lisp.
  On Pitman's "Special forms in Lisp"
  Lambda Calculus Interpreter
  Expansion of Free Variables
  Do You Need Five Hundred Random Lambda-Expressions?
  In Search for The Irreducible Lambda-Expressions
  Cantor's Enumerations (1)
  Cantor's Enumerations (2)
  Cantor's Enumerations (3)
  Enumeration of Lambda-Expressions
  199019 Reduced Lambda-Expressions
  Lambda Calculus Interpreter (2)
  Some differences between lambda-calculus and Lisp (1)
  Some differences between lambda-calculus and Lisp (2)
  Some Basic Concepts Implemented and Reduced in Lambda-calculus
  Lambda Calculus Meta-variables Supported in my Newlisp Library
  Parallel "Expand"
  Conflation of Subtraction and Additive Inverse in Lisp
  Tangent
  More Sophisticated Encoding of S-exprs into Symbols.
  Another Encoding of S-expressions in Symbols
  Implementing Data Structures with Symbols
  Three meanings of the term 'S-expression'
  The Similarities Between Axioms of Natural Numbers and Axioms of S-expressions

------------------------------------------------------------------------------

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
newLISP è un nuovo linguaggio, sviluppato da un uomo, lo psicologo e scienziato informatico americano Lutz Mueller e ha una piccola comunità di utenti e contributori, quindi ha meno funzionalità rispetto ad alcune implementazioni mature di Common Lisp e Scheme. Tuttavia, nessuna delle funzionalità mancanti sembra essere essenziale per i miei programmi e, si spera, se il linguaggio stesso avrà successo, le librerie newLISP e le funzionalità native cresceranno. Sebbene abbiamo visto che newLISP supera altri dialetti Lisp in termini di potenza espressiva della lingua principale, l'autore afferma che il linguaggio è sviluppato principalmente "per essere utile per risolvere problemi del mondo reale" e che "cose come espressioni regolari, funzioni di rete e supporto per popolari protocolli come XML o HTTP sono tutti integrati in newLISP senza la necessità di librerie esterne." Alcuni utenti di newLISP affermano di aver attivato newLISP proprio per questo, non per le funzionalità astratte che ho elencato.

Gestione della memoria
----------------------
La mia unica preoccupazione è che newLISP non consente che le strutture dati condividano parti comuni in memoria. Altri utenti di Lisp lo menzionano spesso come un punto debole, e sembra così a prima vista. Tuttavia, in questo momento, non sono in grado di stimare tutte le conseguenze di quella politica, quindi mi baso sull'aspettativa che Mueller, che è stato in grado di migliorare da solo le basi del Lisp, non abbia commesso errori significativi in questa parte del linguaggio. Spero che imparerò come compensare questa limitazione. Una possibilità potrebbe essere nello sfruttamento dei fatti che le strutture dati possono, tuttavia, contenere gli stessi simboli e i simboli possono essere usati come riferimenti di strutture dati.

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
http://kazimirmajorinc.blogspot.com/2008/05/embeding-blocks-into-functions.html

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


------------------------------------------
Evaluation of Large Expressions in Newlisp
------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/05/evaluation-of-large-expressions-in.html

; This time I'll try different eval benchmark; instead of
; evaluating simple expressions many time, I'll write the program
; that construct large s-expression and measures the time of its
; evaluation

(setq large-s-expression 1)

(setq counter 1)
(do-while (< counter 1000000)
    (setq counter (+ counter 1))
    (setq large-s-expression
          (list 'eval
                (list 'quote
                      (list '+ counter large-s-expression))))
    (when (= (% counter 100) 0)
          (println counter
                   " > "
                   (time (eval large-s-expression)))))

; This is how those z that are evaluated
; look like for counter=2,3,...

;(eval (quote (+ 2 1)))
;(eval (quote (+ 3 (eval (quote (+ 2 1))))))
;(eval (quote (+ 4 (eval (quote (+ 3 (eval (quote (+ 2 1)))))))))

; 100 > 0
; 200 > 15
; 300 > 15
; 400 > 31
; 500 > 46
; 600 > 78
; 700 > 109
; 800 > 140
; 900 > 234
; 1000 > 281
; 1100 >

; ERR: call stack overflow in function eval : quote
;
; Newlisp returns to REPL after that stack overflow. The speed
; is satisfactory, although it seems it is not stable, in some
; executions I got numbers like 900 ms for evaluation of the
; expression with 1000 evals.

; Also, stack overflow happens earlier than in other Scheme
; or Lisp implementations. Clisp and PLT stack overflow
; happens for counter = about 4000, Lispworks and Allegro (free
; editons somewhere near 50 000, while Petit Chez Scheme works
; happily for counter > 10 000 000 and more. Stack overflow
; results in crash of PLT IDE and Chez Scheme interpreter
; respectively.

; However, that stack overflow in Newlisp is not the result of
; eval and quote, because it happens even earlier if eval and
; quote are replaced with sin and cos.

; Conclusion: for evaluation of very large expressions, Newlisp
; is satisfactory, but there is a lot of room for improvement.

Commenti
--------
*** cormullion 18 May 2008 at 18:20
you could always change the stack size:

newlisp -s 100000
newLISP v.9.3.11 on OSX IPv4 UTF-8, execute 'newlisp -h' for more info.

>... your code

1
1
100 > 2
200 > 10
300 > 21
...
3600 > 6150
3700 > 22911
3800 > 113175

it gets very slow though... :)


------------------
Eval and Anti-eval
------------------
http://kazimirmajorinc.blogspot.com/2008/05/eval-and-anti-eval.html

;---------------------------------------------------------------
; I again need some functions and macros I already defined.
; For the rest of the text see bellow.

(set 'macro
    (lambda-macro()
        (eval (append '(lambda-macro) (args)))))

(set 'expression-and-value
    (macro(expression-and-value-arg)
        (list '->
              expression-and-value-arg
              (eval expression-and-value-arg))))

(set '§ (macro()
         (doargs(§arg)
           (println (eval (list 'expression-and-value §arg))))))

;---------------------------------------------------------------
;
;                  Eval and Anti-eval.
;
; Quote and eval can be seen as inverse functions;
; But, they are not exactly that:

(set 'x "I am the value of x")

         (println (= x (quote (eval x))))  ; -> nil! UGLY! UGLY!
         (println (= x (eval (quote x))))  ; -> true

; What really happens?

(§ (quote (eval x)))  ;(-> (quote (eval x)) (eval x))
(§ (eval (quote x)))  ;(-> (eval (quote x)) "I am the value of x")

; Say we want real inverse of eval, i.e. function anti-eval
; such that everything works as expected.

                 (set 'anti-eval
                      (macro(argument)
                            (if (and (list? argument)
                                     (not (empty? argument))
                                     (= (first argument) 'eval))
                                (eval (first (rest argument)))
                                argument)))

;Tests:

                     (§ (anti-eval (eval x)))
                     (§ (eval (anti-eval x)))

                     (§ (anti-eval (eval (quote (+ 2 3)))))
                     (§ (eval (anti-eval (quote (+ 2 3)))))

                     (§ (eval (anti-eval (eval (anti-eval x)))))
                     (§ (anti-eval (eval (anti-eval (eval x)))))

;Results:

  ;(-> (anti-eval (eval x)) "I am the value of x")
  ;(-> (eval (anti-eval x)) "I am the value of x")

  ;(-> (anti-eval (eval (quote (+ 2 3)))) (+ 2 3))
  ;(-> (eval (anti-eval (quote (+ 2 3)))) (+ 2 3))

  ;(-> (eval (anti-eval (eval (anti-eval x)))) "I am the value of x")
  ;(-> (anti-eval (eval (anti-eval (eval x)))) "I am the value of x")

;So far, so good.

;And even this one:

                     (§ (eval (anti-eval (anti-eval (eval x)))))
                     (§ (anti-eval (eval (eval (anti-eval x)))))

;(-> (eval (anti-eval (anti-eval (eval x)))) "I am the value of x")
;(-> (anti-eval (eval (eval (anti-eval x)))) "I am the value of x")

; But I wouldn't be surprised it is broken for more complicated
; expression. I'll keep an eye on it. But this is only blog.

; Is there any practical use of anti-eval? I don't know,
; but it would be strange that there is no use whatsoever.

Commenti
--------
*** cormullion 20 May 2008 at 17:44
Good post! These are very interesting ideas.

One question: Why do you say this:

(println (= x (quote (eval x)))) ; -> nil! UGLY! UGLY!

Why is this really ugly to you? To me (unburdened by knowledge of Common Lisp or Scheme), it looks like asking whether an evaluated symbol is equal to an unevaluated entity.

*** Kazimir Majorinc 21 May 2008 at 02:32
You are right, it has a perfect sense in Lisp and Newlisp.

It is ugly only because some inverse functions in mathematics behave on prettier way, i.e. exp and log, differentiation and integration. It is simpler to think about these pairs.

So, I was provoked by the question, is it possible to have something that is full left and right side inverse to eval.

And can it be useful?

Actually, answer on that last question is already known - it can, that is why CL and Scheme provide something similar, i.e

(= 3 (quasiquote (unquote 3))) ;=> true

i.e. quasiquote behave just as quote - except unquote - which is something similar to eval - is able to "fight against" quasiquote not from outside (like eval fight against quote) but from inside.

But, again, unquote cannot fight against quasiquote from outside.

(= 3 (unquote (quasiquote 3)) => ERROR.

However, eval can do that.

(= 3 (eval (quasiquote 3))) => true

I somehow think it also turned to be too complicated and there should be some generalized concept that on a mathematically elegant way covers all of the functionalities of quote, eval, quasiquote and unquote - and maybe beyond.

I just play a bit in that direction with this blog entry.

*** Kazimir Majorinc 21 May 2008 at 02:51
These examples of quasiquote are from Scheme, it is similar (but I'd say worse in CL) where ` is used instead of quasiquote and , instead of unquote. Surprisingly, in CL

(equal ``3 ''3) => T


-----------------------
Promote Your Functions!
-----------------------
http://kazimirmajorinc.blogspot.com/2008/06/promote-your-functions.html

;---------------------------------------------------------------
; As usually, few definitions I frequently use.

(set 'macro (lambda-macro()(append (lambda-macro) (args))))
(set 'function (macro() (append (lambda) (args))))

(set '-line (dup "-" 64))
(set '--- (function()(println -line)))

(set '§§ (macro(§-argument)
               (list '-> §-argument (eval §-argument))))
(set '§ (macro() (doargs(§§-argument)
                 (println (eval (list '§§ §§-argument))))))

;---------------------------------------------------------------
; I'll try to define some tools for defining of the very simple
; class of the higher order functions, based on the "ordinary"
; functions. For example, for a given function add, I want to
; define addf, which does not sum the numbers, but functions.
;
; But, what does it mean? What is the sum of the functions,
; say, sin and cos? The simplest and in mathematics most
; frequently used definition is that the result is the function
; sin + cos such that
;
;         (sin + cos)(x) = sin x + cos x
;
; In Newlisp terms, it is
;
;         ((addf 'sin 'cos) x) = (add (sin x) (cos x))

; Furthermore, after I learn how to define addf manually, I want
; to develop tool, i.e function that does the same, so I can simply
; write

;         (set 'addf (increase-order 'add))

; I have to write such programs very gradually, starting with
; simple examples, and slowly generalizing. Otherwise, I find
; myself guessing about errors in the code I only partially understand.

; So, let's start with expression (add (sin 3)(cos 3)):

(§ (add (sin 3) (cos 3)))

; RESULT: (-> (add (sin 3) (cos 3)) -0.8488724885)

; Now, an easy part. How function that takes 3 as an argument and
; returns -0.84888... looks like? Obviously,
;
;               (lambda(x)(add (sin x) (cos x))).
;
; Or, using previously defined "function:"

(§ ((function(x)(add (sin x) (cos x))) 3))

; RESULT: (-> ((lambda (x) (add (sin x) (cos x))) 3) -0.8488724885)
; As expected, it works.

;---------------------------------------------------------------
; Now, look at the list (add (sin x) (cos x) ....). It appears
; that part can be generated by appending of the list (add) and list
; ((sin x) (cos x) ...). This second can be the result of some
; function that accepts two arguments: list of the function names,
; (or more generally, s-expressions that evaluate to functions) and
; of an argument on which functions will be applied.
; Let's call that function pamq, because it is somehow
; dual to the function map. So, I want

;         (pamq (list 'sin 'cos) 'x) => ((sin x) (cos x))

; it is not complete dual. Because in Newlisp, (map 'sin (list 'x 'y))
; does not evaluate to ((sin x) (sin y)); instead, map tries to apply
; sin on x and y, and if these have values, say 1 and 2 respectively,
; it evaluates to

;                 (0.8414709848 0.9092974268),

(---)
(set 'pamq (function(L a)
             (map (function(li)(list li a)) L)))

; Does it work?

(§ (pamq (list 'sin 'cos) 'x))

; It does: (-> (pamq (list 'sin 'cos) 'x) ((sin x) (cos x)))
; However, if I'm already here, I'll also write real pam, to be dual to
; map; and mapq to be dual to pamq, I'll put these functions in
; my library, just in the case I'll need them
; in future.

(---)
(set 'pam (function(L a)
            (map (function(fi)(eval (list fi a))) L)))

(set 'mapq (function(f L)
               (map (function(li)(list f li)) L)))

(§ (pam (list 'sin 'cos) 3)) ;(-> ... (0.1411200081 -0.9899924966))
(§ (mapq 'sin (list 'x 'y))) ;(-> ... ((sin x) (sin y)))

; They work. Back to the task of writing function addf such that
; (addf f1 ... fn) evaluates to (lambda(x)(add (f1 x)(f2 x)...(fn x))).

(set 'addf (function()
               (append '(lambda(x))
                       (list (append '(add) (pamq (args) 'x))))))

; Does it work?

(---)
(§ (addf 'sin 'cos)) ;(-> ... (lambda (x) (add (sin x) (cos x))))
(§ ((addf 'sin 'cos) 3)) ; (-> ... -0.8488724885)

; It does. The definition of 'addf is rather complicated. It is
; complicated because I must leave the expression (args) unquoted.

; Now, I'll make one generalization further. Sumation of the functions
; have sense for functions that accept more than one argument.
; For example, * and / accept two arguments and they can be added too.

; So, I want function that takes functions f1, f2 ... etc as argument
; and evaluates to

;     (lambda()(add (apply f1 (args)) .... (apply fn (args))))

; suddenly, my pretty function pamq is rather useless, and the best thing
; I can do is to write similar, but special function for this purpose:

(set 'pamq-special (function (L)
                      (map (function(li)(list 'apply li '(args))) L)))

(---)
(§ (pamq-special (list 'sin 'cos)))

; It works: (-> ... ((apply sin (args)) (apply cos (args))))

(set 'addf (function()
               (append '(lambda())
                       (list (append '(add) (pamq-special (args)))))))

(§ (addf 'sin 'cos)) ;(-> ... (lambda () (add (apply sin (args))
                      ;                        (apply cos (args)))))
(§ ((addf 'sin 'cos) 3)) ; (-> ... -0.8488724885)

; It's even better; pamq-special and addf use fewer symbols.
; Another test: the function +*/ is defined as sum of  two
; functions of two arguments, * and /. The result should be
; (+*/ 4 2) = (+ (* 4 2) (/4 2)) = 10.

(---)
(set '+*/ (addf '* '/))
(§ (+*/ 4 2))

; OK, it works. Now, I'm ready for the last and most productive
; generalization - instead of using addf defined "by hand", I'll
; define function "increase-order" that accepts "ordinary" function as
; argument and returns it higher-order version.
;
; For example, "increase-order" should be able to take add as argument,
; and return value of already defined addf,
;
;    (function()
;       (append '(lambda())
;               (list (append '(add) (pamq-special (args)))))))

(set 'increase-order
     (function()
         (eval (list 'function '()
                  (list 'append ''(lambda())
                        (list 'list (list 'append (list 'quote (args))
                                                 '(pamq-special (args)))))))))

; Again, it is rather complicated. Not long, but complicated.
; There are lot of "lists" and "eval."; Why they are necessary?
; Because I had to ensure that the first occurence of (args) is free,
; i.e. it is not quoted, and Newlisp has no "quasiquote" yet.

; But it is relatively pretty function; it does not use any local
; variable. One can complain that it requires my user-made
; functions "function" and "pamq-special", but they can be eliminated.

(---)
(§ (increase-order 'add))

; (-> ... (lambda ()
;            (append '(lambda ())
;                     (list (append (quote (add))
;                                   (pamq-special (args)))))) )

; Hm ... it could work

(set 'addf (increase-order 'add))
(set '+f (increase-order '+))

(set 'sin+cos (addf 'sin 'cos))
(set '+*/ (+f '* '/))

(§ (sin+cos 3)) ; (-> (sin+cos 3) -0.8488724885)
(§ (+*/ 4 2)) ; (-> (+*/ 4 2) 10)

; Yap, it does work. But, what is the advantage of defining such
; functions? Shortening of the programs, clarity of the conceptions
; and possibly, easier detection of errors.

;---------------------------------------------------------------
; Example: increase-order is used for definition of reversef function
; that doesn't reverse the lists, but generates the function that
; reverses the lists, beside doing something else.

(---)
(set 'reversef (increase-order 'reverse))
(set 'reversed-map (reversef 'map)) ;

(§ reversed-map)
(§ (reversed-map 'sqrt (list 1 4 9 16)))

; (-> reversed-map (lambda () (reverse (apply map (args)))))
; (-> (reversed-map 'sqrt (list 1 4 9 16)) (4 3 2 1))

; Of course, the same result can be achieved without reversef,
; just it will require seven instead of two tokens and 16 instead of 5
; if we count apostroph and parentheses as well.


--------------------------------
Assignment Macro Beast Unleashed
--------------------------------
http://kazimirmajorinc.blogspot.com/2008/06/assignment-macro-beast-unleashed.html

;===============================================================
;
; C has a lot of handy assignment operators like += and *=.
; Someone might want them in Newlisp - in fact, I've seen some
; already asked for them on Newlisp forum. This article
; is about such operators. Just like usually, you can simply cut
; and past and run the whole code, with comments.

; We have a luck. Equivalent macros can be easily defined in Newlisp.

(set 'setq+ (lambda-macro()
              (set (first (args))
                   (apply + (map eval (args))))))

; TEST:

(setq x 4)
(setq+ x (* 5 5))
(println "Value of x should be 29 and it is actually " x ".")

;===============================================================
;
; Of course, setq+ is only one of many potentially useful similar
; assignement. That justifies the writing of the higher order
; function that accept name of the function (say +) and returns
; appropriate "assignement macro (like set+).

; I'll use "expand" function I learnt these days. With expand,
; I can easily use definition of setq+ in more general form.
; "Expand" can significantly simplify writing of macros.

(set 'hsetq
     (lambda-macro()
           (let ((operator (first (args))))
                (expand '(lambda-macro()
                            (set (first (args))
                                 (apply operator
                                        (map eval (args)))))
                        'operator))))

; TEST:

(set 'setq* (hsetq '*))
(setq* x (+ 1 1))
(println "Value of x should be 58 and it is actually " x ".")

;===============================================================

; If we agree that names setq+, setq* ... etc are acceptable
; for all of our assignment macros, we can improve hsetq so it
; does not only define new assignment macro, but also gives the
; appropriate name to the assignement macro.

(set 'hsetq
     (lambda()
        (letn ((old-operator (first (args)))
               (new-operator (sym (append "setq"
                                               (string old-operator))))
               (new-operator-definition
                   (expand '(lambda-macro()
                               (set (first (args))
                                    (apply old-operator
                                            (map eval (args)))))
                                'old-operator)))
              (set new-operator new-operator-definition))))

; TEST:

(set 'x 20)
(hsetq '/)
(setq/ x 5)

(println "Value of x should be 4 and it is actually " x ".")

;===============================================================
;
; In Newlisp tradition, it seems that set is more popular than
; setq. So, let us improve our hsetq to define both versions,
; for example, setq+ and set+

(set 'hset
     (lambda()
        (letn ((old-operator (first (args)))
               (new-operator (sym (append "setq"
                                                (string old-operator))))
               (new-operator2 (sym (append "set"
                                                (string old-operator))))
               (new-operator-definition
                   (expand '(lambda-macro()
                               (set (first (args))
                                    (apply old-operator
                                           (map eval (args)))))
                                'old-operator))
               (new-operator-definition2
                   (expand '(lambda-macro()
                                (set (eval (first (args)))
                                     (apply old-operator
                                           (map eval
                                               (cons (eval (first (args)))
                                                     (rest (args)))))))
                            'old-operator)))
              (set new-operator new-operator-definition)
              (set new-operator2 new-operator-definition2))))

(set 'x 10)
(hset '-)
(setq- x 5)
(println "Value of x should be 5 and it is actually " x ".")
(set- (sym "x") 3)
(println "Value of x should be 2 and it is actually " x ".")

;===============================================================
;
; And now, we'll define whole buch of new assignment macros.
;

(println "\nWatch out!")
(sleep 1000)
(println "\nThe beast will be unleashed in few moments!\n")
(sleep 3000)

(set 'counter 0)
(dolist (x (symbols))
        (when (or (lambda? (eval x))
                  (primitive? (eval x))
                  (macro? (eval x)))
              (hset x)
              (print "set" x " setq" x " "))
              (setq+ counter 2)) ;-)

(println "\n\n" counter " new assignment macros defined.")
(println "Compares well with C, I guess.")

; TEST

(println)
(set 'L '(1 2 3))

(setappend (sym "L") '(7 8))

(println "Value of L should be (1 2 3 7 8) and it is " L ".")

(setqlist? L)

(println "Value of L should be true and it is " L ".")
(exit)


--------------------------------------------
Does the Function Really Evaluate to Itself?
--------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/06/does-newlisp-function-really-evaluate.html

; It is usually said that Newlisp functions evaluate to themselves.
; Is it really the truth? Let us test this claim.

(println "===================")
(set 'f (lambda(x)x))

(println f)
(println (eval f))

; Both of these are (lambda(x)x). OK, let us ask interpreter if
; they are equal directly:

(println "===================")
(println (= f (eval f))) ; true

; Hm ... one can be still suspicious. Let us try this one:

(println "===================")
(set 'f (lambda(x)x))
(push '(println "Hello!") f 1)

(println f)        ;(lambda (x) (println "Hello!") x)
(println (eval f)) ;(lambda (x) (println "Hello!") x)

; So far so good. And what if we push something in (eval f)?

(println "===================")
(set 'f (lambda(x)x))
(push '(println "Hello!") (eval f) 1)

(println f)          ;(lambda(x)x)
(println (eval f))   ;(lambda(x)x)

; Huh? The outputs are still equal, but how it is that our pushing
; of a friendly expression is not accepted neither in f nor in
; (eval f)? What is the explanation?

; Strictly speaking, functions do not evaluate EXACTLY to themselves,
; instead, they evaluate to the freshly generated copies of themselves.
; In last example, (eval f) was such a new copy, and (println "Hello")
; es pushed in the copy of the function f, not in the function itself.

; When (eval f) is called second time, in (println (eval f))
; another, completely new copy of f is returned - and it does not
; know that we already tried to teach previous copy new tricks.


---------------------
New Copies Discovered
---------------------
http://kazimirmajorinc.blogspot.com/2008/06/new-copies-discovered.html

; Let us define f and L on the following way:

(set 'f (lambda(x)(eval x)))
(set 'L '(0))

; what is the result of the evaluation of (f 'L)?

(println (f 'L)) ; output: (0)

; It appears that that particular function call evaluates to the
; value of L. However, just like in my last post - it is not actual
; value of the L, but its copy. We can test it on the following way:

(print "Attempt to push 1. ")
(push 1 L)
(println "L=" L) ; output: L=(1 0), attempt succeeded

; However,

(print "Attempt to push 2. ")
(push 2 (f 'L))
(println "L=" L) ; output: L=(1 0), attempt failed

; The value of (f 'L) is EQUAL to the value of L, but not the SAME.
; In some purely functional language, it wouldn't be the issue,
; however, Newlisp is not purely functional language - and in my
; opinion, it is good that it is not. Primitive function push is
; mutator - its result is not important, its side effect on one
; particular instance of the value is.

; Why f didn't returned exactly the value of L, but its copy?
; Who made this copy? Since f is (lambda(x)(eval x)), there are
; two possibilities. The first is that eval is responsible for a
; copy, and the second is that function does not return the result
; of the evaluation of the last experssion, but the COPY of that result.

; We can test whether it is eval who did the copy easily. Let
; us evaluate:

(print "Attempt to push 3. ")
(push 3 (eval 'L))
(println "L=" L) ; output: L=(3 1 0), attempt succeeded

; So, the function is responsible. It returns the copy of the result
; of the evaluation of the last expression in its body.

; I tested several other syntactical constructs of Newlisp and
; observed that many of do the same. The most notable, macros
; do.

(print "Attempt to push 4. ")
(set 'f (lambda-macro(x)(eval x)))
(push 4 (f L))
(println "L=" L) ; output: L=(3 1 0), attempt failed

; And also:

(print "Attempt to push 5. ")
(push 5 (let()L))
(println "L=" L) ; output: L=(3 1 0), attempt failed

(print "Attempt to push 6. ")
(push 6 (begin L))
(println "L=" L) ; output: L=(3 1 0), attempt failed

; Programmer cannot write the function (or even macro) that behaves
; exactly as primitive function eval on his own. It is impossible
; even by using actual eval in the function definition - because
; whatever one does, function will never return actual value of
; some variable, say L - but always some copy of that value - and
; as we've seen (eval L) returns actual value of L.

; The solution is to return the symbol L, not its value. Such a
; symbol can be evaluated in the environment of the caller, and
; result will be exactly the value of L.

(print "Attempt to push 7. ")
(set 'f '(lambda(x)x))

(push 7 (eval (f 'L)))
(println "L=" L)  ; output: L=(7 3 1 0), attempt succeeded
(exit)

; Semantically, difference is not big. Syntactically, however,
; extra eval in the caller environment is annoyance, more from
; eaesthetical than practical point of vew. But, aesthetic is the
; pride of Lisp, and it could be worth to research the possibility
; of the syntactical constructs equivalent to lambda, lambda macro,
; and possibly begin and let expressions - differing only by
; returning actual values of the last subexpression.


---------------------------------------------
If lambda Gives let, What About lambda-macro?
---------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/06/if-lambda-gives-let-what-about-lambda.html

;---------------------------------------------------------------
; INTRODUCTION
;
; In Lisp generally, including Newlisp, let is defined through
; lambda. According to Newlisp manual
;
;   (let ((sym1 exp-init1) [ (sym2 exp-init2) ... ] ) body)
;
; is equivalent to
;
;          ((lambda (sym1 [sym2 ... ])
;                   exp-body)
;                   exp-init1 [ exp-init2 ...])
;
; What happens if we use lambda-macro instead lambda on the same
; way?

;---------------------------------------------------------------
; I'll define
;
;              (met ((sym1 exp-init1)
;                    ...
;                    (symn exp-initn))
;                    body)
;
; as a macro call that translates to the expression
;
;             ((lambda-macro(sym1 ... symn)
;                           body)
;              exp-init1
;              ...
;              exp.initn)
;
; end evaluates it.

(set 'met (lambda-macro()
             (letn((initializations (first (args)))
                   (new-macro (append (lambda-macro)
                                     (list (map 'first
                                                 initializations))
                                     (rest (args))))
                   (equivalent-expression
                             (cons new-macro
                                   (map (lambda(x)
                                          (first (rest x)))
                                        initializations))))
                   (eval equivalent-expression))))

; What such a met control structure does? Almost the same thing as
; let, just initialization will be done in "macro style", ie. if
; I write
;
;         (met ((sym1 (+ 2 3))
;               (sym2 (+ 3 4)))
;              ...)
;
; the value of sym1 will not be RESULT of evaluation of (+ 2 3),
; but expressions (+ 2 3) itself, just like I wrote
;
;        (let ((sym1 '(+ 2 3))
;              (sym2 '(+ 3 4)))
;             ...)
;
;Test:

(met ((sym1 (1 2 3))
      (sym2 (4 5 6)))
     (println (append sym1 sym2)) ; output: (1 2 3 4 5 6)
     (println (list sym1 sym2)))  ; output: ((1 2 3) (4 5 6))

; Yap, it works. But, what happens if I make tricky attack on
; my new account with something like?

(met ((sym1))
     (println "sym1=" sym1))

; It works as well, output is sym1=nil, just like it would be with
; let. It is the consequence of the (first (rest x)) returning nil,
; if x has only one element, unlike (nth 1 x) that produces error.
; (Newlisp has the "local" expression that can be used for similar
; purposes. Check it - it is good thing.)

; Another tricky attack with "empty" met, as a edge case? Does it work?

(met ()
     (println "Hello world"))

; It does - it doesn't generate an error, and that's all we need.

;---------------------------------------------------------------
; If "let" has a relative "letn", what about equivalent relative
; "metn" of "met"?
;
; (metn ((sym1 exp-init1)
;        (sym2 exp-init2)
;        ....
;        (symn exp-initn))
;        body)
;
; should be equivalent to
;
; (met ((sym1 exp-init1))
;      (met ((sym2 exp-init2))
;            ...
;            body)...))

; However, there is no use of that, because in both metn and met,
; exp-init1, ... are NOT evaluated until body starts to be evaluated,
; hence met and metn should have exactly the same effect - except
; that met should be faster. Why - see my post "New copies discovered".

;---------------------------------------------------------------
; CONCLUSION:
;
; Is such a "met" useful? Theoretically, it is as useful as lambda-macro.
; It spares one apostroph and makes programs more readable. However,
; let-expressions are already complicated enough so extra apostroph
; is not nearly such a nuisance as it can be in some macro calls that
; look like control structures. Nevertheless - why not?


----------------------------
Verbose Functions and Macros
----------------------------
http://kazimirmajorinc.blogspot.com/2008/07/verbose-functions.html

; --------------------------------------------------------------
; Back in 1970's, one of the best programmers in the local
; public computer center started to behave on strange way. During
; one of our conversations he said " The highest level of the
; programming is when you do not need computer any more,
; you simply sit on the sofa, eat chips and think how program
; should work. Strange argument, but nevertheless, not illogical.
; Sure, if you use your mind as a computer, you cannot
; really make million calculations in few seconds, but as I
; already knew - results are not important - programs are important.

; I felt that something was wrong about it, but the best critical
; I was able to formulate was: if you write programs in your mind,
; they ALWAYS work, right?

; Very soon, my young friend left programming for good; I didn't
; and my programs still do not work.

; One of the best method for fixing them is to make them not only
; evaluate, but also to produce verbose output similar
; to one I used in my blog article on macros:

; ==============================================================
; (-> min-used-cells 945)
; (-> max-used-cells 945)
; --------------------------------------------------------------
; |||||Macro (fibom2 4) called.
; |||||||||Macro (fibom2 (- ex 1)) called.
; |||||||||||||Macro (fibom2 (- ex 1)) called.
; ||||||||||||||Macro (fibom2 (- ex 1)) returns 1.
; |||||||||||||Macro (fibom2 (- ex 2)) called.
; ||||||||||||||Macro (fibom2 (- ex 2)) returns 1.
; ||||||||||Macro (fibom2 (- ex 1)) returns 2.
; |||||||||Macro (fibom2 (- ex 2)) called.
; ||||||||||Macro (fibom2 (- ex 2)) returns 1.
; ||||||Macro (fibom2 4) returns 3.
; --------------------------------------------------------------
; (-> (fibom2 32) 2178309)
; (-> (time (fibom2 32)) 9734)
; (-> min-used-cells 945)
; (-> max-used-cells 1269)
; ==============================================================

; Everyone likes such outputs. If there is some error, it is
; easier to find it. To achieve that, I wrote the macro fibom2
; on the complicated way:

'(set 'fibom2 (macro(x)
               (print-ln (evaluation-level-indent)
                         "Macro (fibom2 " x ") called.")
               (letn ((ex (eval x))
                      (result (if (< ex 3)
                                 1
                                 (+ (fibom2 (- ex 1))
                                    (fibom2 (- ex 2))))))
                    (print-ln (evaluation-level-indent)
                              "Macro (fibom2 " x ") returns " result ".")
                    (memory-watch)
                    result)))

; However, the "real" code that evaluates
; Fibonacci numbers is concentrated in the middle, in the part

;               (letn ((ex (eval x))
;                      (result (if (< ex 3)
;                                 1
;                                 (+ (fibom2 (- ex 1))
;                                    (fibom2 (- ex 2))))))

; So, it might be possible to automatize production of such
; verbose functions, writing macros that turn "normal" functions
; into verbose, and vice-versa. And also, turning normal macros
; in verbose macros and vice versa.

; Also, the output I used in article about macros is not optimal.
; It is nice for small programs, but sometimes, output required
; for debugging could be quite large - thousands of lines, dozens
; of nested function calls. One possibility of the output is in
; use of the nested s-expressions.

'(fibo (in 4)
       (caller 4)
       (fibo (in 3)
             (caller (- x 1))
             (fibo (in 2)
                   (caller (- x 1))
                   (time 0)
                   (memory 13 (total 1262))
                   (out 1))
             (fibo (in 1)
                   (caller (- x 2))
                   (time 0)
                   (memory 13 (total 1263))
                   (out 1))
             (time 24)
             (memory 13 (total 1200))
             (out 2))
       (fibo (in 2)
             (caller (- x 2))
             (time 0)
             (memory 13 (total 1201))
             (out 1))
       (time 49)
       (memory 10 (total 1144))
       (out 3))

; This is not the code - this is output of the verbose function.
; Now, why such output? Because, if it is very long, and I find
; that some (out x) part is wrong - I can use text editor to
; show me where is appropriate (in ...). For that purpose, editors
; that highlight whole s-expressions, not only parentheses are better.

; This is Dr. Scheme. Such a highlighting is very useful if
; s-expressions are very long.

; the function that produced output above looked like:

(set 'debug-indent 0)
(set 'fibo (lambda-macro ()
            '(original-function-definition
              (lambda-macro (`x)
                   (let ((x (eval `x)))
                        (if (<= x 2)
                         1
                         (+ (fibo (- x 1)) (fibo (- x 2)))))))
          (let ((t)
               (result)
               (used-memory (sys-info 0)))
           (print (dup " " debug-indent) "(fibo (in")
           (doargs (arg)(print " " (eval arg)))
           (println ")")
           (inc 'debug-indent 6)
           (print (dup " " debug-indent) "(caller")
           (doargs (arg)(print " " arg))
           (println ")")
           (set 't (time (set 'result (eval (append (list

           ; Here is original macro
           ; ------------------------------------------
           (lambda-macro (`x)
                    (let ((x (eval `x)))
                     (if (<= x 2)
                      1
                      (+ (fibo (- x 1)) (fibo (- x 2))))))
           ;--------------------------------------------
                                                          )(args))))))
           (println (dup " " debug-indent)
                    "(time " t ")\n"
                    (dup " " debug-indent)
                    "(memory " (- (sys-info 0) used-memory)
                    " (total " (sys-info 0) "))\n"
                    (dup " " debug-indent)
                    "(out " result "))")
           (dec 'debug-indent 6) result)))

(fibo 4)

; It might look complicated - but it is not, it is
; only relatively large - and macros that transform original version
; in the version above are relatively simple.

; I use storing blocks of data into function body, already described
; in one of the previous blogs, so you can  scroll
; down until last few paragraphs:

(set 'block?
     (lambda()
              (and (list? (first (args)))
                   (not (empty? (first (args)))))))
(set 'get-block-name
     (lambda(some-block)
              (if (not (block? some-block))
                  (throw-error (list "get-block-name applied on non-block"
                                     some-block))
                  (first some-block))))
(set 'quoted-block?
     (lambda(argument)
         (if (or (quote? argument)
                 (and (list? argument)
                      (not (empty? argument))
                      (= (first argument) 'quote)))
             (block? (eval argument)))))

(set 'beginize-block
     (lambda(some-block)
              (append '(begin)
                      (rest some-block))))

(set 'get-block-from-list-containing-quoted-blocks
     (lambda(block-name L)
              (catch (dolist (i L)
                        (if (and (quoted-block? i)
                                 (= block-name
                                    (get-block-name (eval i))))
                            (throw (eval i)))))))

(set 'or-function-macro? (lambda(L)
                            (or (lambda? L) (macro? L))))

(set 'set-quoted-block-in-list
     (lambda(b L)
       (catch (begin (dolist(i L)
                       (when (and (quoted-block? i)
                                  (= b (get-block-name (eval i))))
                             (prinln "set-quoted-block: pronadjen.")
                             (throw (nth-set (L $idx) b))))
                      (println "set-quoted-block: nije pronadjen u listi.")
                      (push (list 'quote b)
                            L
                            (if (or-function-macro? L) 1 0))
                      (println "set-quoted-block-returns " L)))))

(set 'evaluate-block-from-list-containing-quoted-blocks
     (lambda (block-name list-containing-quoted-blocks)
               (eval (beginize-block
                         (get-block-from-list-containing-quoted-blocks
                              block-name
                              list-containing-quoted-blocks)))))

;---------------------------------------------------------------
; Finally, here are these two macros. Also, global variable, named
; debug-indent has to be maintained, so indents can be more
; precisely calculated.

;===============================================================
; DEBUG-WRAP & DEBUG-UNWRAP
; usage: (debug-wrap <function-name>)
;        (debug-unwrap <function-name>)

(set 'blank (lambda(x)(dup " " x)))
(set 'debug-indent 0)
(set 'debug-wrap
     (lambda-macro()
      (letn ((`function-name (first (args)))
             (function-name (eval `function-name))
             (debug-indent-step (+ (length (string `function-name))
                                   2))
             (in-line (append "(" (string `function-name) " (in")))
            (set `function-name
                 (expand
                    (lambda-macro()
                      '(original-function-definition function-name)
                      (let ((t)
                            (result)
                            (used-memory-before)
                            (used-memory-after))

                           (print (blank debug-indent) in-line)
                           (doargs(arg/debug-wrap)
                                (print " " (eval arg/debug-wrap)))
                           (println ")")

                           (inc 'debug-indent debug-indent-step)

                           (print (blank debug-indent) "(caller")
                           (doargs(arg/debug-wrap)
                                (print " " arg/debug-wrap))
                           (println ")")

                           (set 'used-memory-before (sys-info 0))
                           (set 't
                                (time (set 'result
                                            (eval (cons function-name
                                                          (args))))))
                           (set 'used-memory-after (sys-info 0))

                           (println (blank debug-indent)
                                    "(time " t ")\n"
                                    (blank debug-indent)
                                    "(memory " (- used-memory-after
                                                  used-memory-before)
                                    " (total " (sys-info 0) "))\n"
                                    (blank debug-indent)
                                    "(out " result "))")

                           (dec 'debug-indent debug-indent-step)
                                 result))
                          'function-name
                          'debug-indent-step
                          'in-line)))))

(set 'debug-unwrap
     (lambda-macro()
       (letn ((`function-name (first (args)))
              (function-name (eval `function-name)))
             (set `function-name
                  (evaluate-block-from-list-containing-quoted-blocks
                     'original-function-definition
                      function-name)))))

;===============================================================

(set 'fibo (lambda(x)(if (>= x 3)
                         (+ (fibo (- x 1))
                            (fibo (- x 2)))
                         1)))

(println "debug-wrap test --------------------------------------")
(debug-wrap fibo)
(fibo 4)

;Output is as follows:

; (fibo (in 4)
;       (caller 4)
;       (fibo (in 3)
;             (caller (- x 1))
;             (fibo (in 2)
;                   (caller (- x 1))
;                   (time 0)
;                   (memory 0 (total 1079))
;                   (out 1))
;             (fibo (in 1)
;                   (caller (- x 2))
;                   (time 0)
;                   (memory 0 (total 1080))
;                   (out 1))
;             (time 3)
;             (memory 0 (total 1029))
;             (out 2))
;       (fibo (in 2)
;             (caller (- x 2))
;             (time 0)
;             (memory 0 (total 1030))
;             (out 1))
;       (time 8)
;       (memory 0 (total 983))
;       (out 3))
;

(println "debug-unwrap test ------------------------------------")
(debug-unwrap fibo)
(println (fibo 4)) ; 3

; And it appears it works. I tested these two macros, debug-wrap
; and debug-unwrap not only on functions, but on macros also, and
; also on the functions and macros that use arguments from (args)
; and it also worked.

; Dr Scheme "program counture" shows 550 lines output of "verbose" (fibo 10).
; It should be pretty because the ratio between (fibo n) and (fibo (- n 1)), always
; called in pairs converges toward golden ratio. Is it pretty?

; One possible improvement could be writing in the file instead on the screen.

; The debug-wrap and debug-unwrap demonstrate one advantage of the Newlisp.
; The macros can be switched from "normal" to "verbose" versions and back automatically
; because they are the first class citizens, so they can be arguments
; of debug-wrap and debug-unwrap.


----------------------------------------------------
On Calling and Applying Newlisp Functions and Macros
----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/07/on-calling-and-applying-newlisp.html

;---------------------------------------------------------------
; I continue with my researches of the Newlisp basics. It might be
; boring to some of the readers, but there will be plenty of
; time for other topics.
;
; The macros and the functions are, due to dynamic scoping, more
; similar in Newlisp than in other languages from Lisp family. The
; difference is only in the way arguments are passed to these two.

(set 'x 10 'y 20)

((lambda()(println (args)))
     1 2 "a" x y + - (+ x y)
     '1 '2 '"a" 'x 'y '+ '-  '(+ x y))
((lambda-macro()(println (args)))
     1 2 "a" x y + - (+ x y)
     '1 '2 '"a" 'x 'y '+ '-  '(+ x y))

; RESULTS:

;(1 2 "a" 10 20 + <40C365> - <40C380> 30 1 2 "a" x y + - (+ x y))
;(1 2 "a" x y + - (+ x y) '1 '2 '"a" 'x 'y '+ '- '(+ x y))

; (arg) in the CALLED function is list of evaluated arguments
; (arg) in the CALLED macro is list of unevaluated arguments

;---------------------------------------------------------------
; However, APPLYING of functions and macros on list works slightly
; different. Let as suppose that function and macro are APPLIED
; on list L.

(set 'L '(1 2 "a" (lambda()) x y + - (+ x y)
         '1 '2 '"a" 'x 'y '+ '-  '(+ x y)))

(apply (lambda()(push 4 (args))(println(args)))
       L)

(apply (lambda-macro()(println(args)))
       L)

; RESULTS:

;(1 2 "a" x y + - (+ x y) '1 '2 '"a" 'x 'y '+ '- '(+ x y))
;(1 2 "a" 'x 'y '+ '- '(+ x y) ''1 ''2 ''"a" ''x ''y ''+ ''- ''(+ x y))

;(args) in APPLIED function is copy of the L.
;       it is not original L; I tested that.

;(args) in APPLIED macro is OPTIMIZED list of the quoted elements of L
;       where OPTIMIZED means that "self-evaluating" elements are COPIED,
;       not quoted.

; That optimization in macro application is not harmful, because it
; holds that, inside APPLIED macro, (map eval (args)) is equal to L.

(apply (lambda-macro()(println (= L (map eval (args))))) L) ; true


-----------------------------------
Conversions to Functions and Macros
-----------------------------------
http://kazimirmajorinc.blogspot.com/2008/07/conversions-to-functions-and-macros.html

;===============================================================
; CONVERSION OF FUNCTIONS TO MACROS AND VICE VERSA
;
;
; If you think on the way I do, then you sometimes have the function,
; and you want macro - to avoid using of one extra quote in the
; function call. Or, you have a macro, and you want function to pass
; it value stored in some variable.

; In this post, I'll define two cute functions for exactly that purpose;
;
; macro-from-function
; function-from-macro

; Lets start with one meaningless function and macro for illustration
; of the idea.

(set 'set-first-to-0-function
      (lambda()
         (set-nth ((first (args)) 0) 0)))

(set 'set-last-to-0-macro
     (lambda-macro()
         (set-nth ((first (args)) -1) 0)))

; The definitions are nearly equal, the difference is
; in the way we call these two:

(println (set-first-to-0-function '(1 2 3 4 5))) ; (0 2 3 4 5)
(println (set-last-to-0-macro (1 2 3 4 5)))   ; (1 2 3 4 0)

;---------------------------------------------------------------
; The similarity of these two definitions is striking, but it
; is not completely trivial to convert one to another - because
; lambda and lambda-macro definitions are not simply lists with
; the first elements lambda or lambda-macro. They are more something
; like special kinds of lists, as it can be seen from following
; expressions:

(println (first (lambda(x)(print x)))) ;(x)
(println (rest (lambda(x)(print x)))) ;((print x))

; Cons can surprise you:

(println (cons (lambda-macro) (lambda()(print))))

(lambda (lambda-macro ) () (print))

; But append behaves nice, so, it is maybe the most natural
; way to exchange lambda and lambda-macro:

(println (append (lambda-macro) (lambda(x)(print x))))

; result: (lambda-macro(x)(print x))

(set 'function-from-macro (lambda()
                             (append '(lambda) ; quote can be omitted
                                      (first (args)))))
(set 'macro-from-function (lambda()
                             (append '(lambda-macro)
                                      (first (args)))))

;---------------------------------------------------------------
; Does it work?

(set 'set-first-to-0-macro
     (macro-from-function set-first-to-0-function))

(set 'set-last-to-0-function
     (function-from-macro set-last-to-0-macro))

(println (set-first-to-0-macro (1 2 3 4 5))) ; (0 2 3 4 5)
(println (set-last-to-0-function '(1 2 3 4 5)))   ; (1 2 3 4 0)

;===============================================================
; CONVERSION OF BUILT-INS to LAMBDA AND LAMBDA-MACRO EXPRESSIONS.

; In Newlisp, there is no clear distinction between built in
; functions and built in macros. The program cannot test whether
; built in is function or macro, and in the reference manual,
; all of them are called functions. But some of the built ins
; really behave as functions, while some behave more like
; macros. For example, "reverse" is function. You have to call it
; with argument that evaluate to list, not list itself.

(println (reverse '(1 2 3)))

; Unlike "reverse", "for" behaves like macro:

(for (i 7 9) (println i))

; obviously, the expressions (i 7 9) and (println i) are not evaluated
; prior to the call of the "for."
;
; So, one might want to use macro version of reverse, something like
;
;                 (reverse-macro (1 2 3))
;
; or functional version of for:
;
;                 (for-function '(i 7 9) '(println i))
;
; Unfortunately, our function-from-macro and macro-from-function
; do not work for "reverse" and "for." They need lambda and
; lambda-macro expressions.

; We'll solve this problem by writing two functions that transform
; built in functions in lambda expressions, and built in macros in
; lambda-macro expressions. After that, function-from-macro and
; macro-from-function can be applied.

; How can we define the lambda and lambda-macro expressions
; doing exactly the same thing as reverse and for?

; These are some possibilities:

(lambda()
   (apply 'reverse $args))

(lambda-macro()
   (eval (cons 'for $args)))

; Let's test it:

(println "======================================================")
(println ((lambda()
           (apply 'reverse $args))
           '(1 2 3)))

; and

((lambda-macro()
      (eval (cons 'for $args)))
 (i 7 9)
 (println i))

; RESULT:
; (3 2 1)
; 7
; 8
; 9

; It works.

; It is obviously the trick; but it serves its purpose.
; Now, we can automatize such transformation of built-ins into
; equivalent lambda and lambda-macro expressions:

(println "======================================================")

(set 'lambda-form
     (lambda(built-in-name)
       (expand '(lambda()(apply 'built-in-name $args))
               'built-in-name)))

(set 'lambda-macro-form
     (lambda(built-in-name)
        (expand '(lambda-macro()(eval (cons 'built-in-name $args)))
                'built-in-name)))

; Does it work?

(set 'reverse-macro (macro-from-function (lambda-form 'reverse)))
(set 'for-function (function-from-macro (lambda-macro-form 'for)))

(println (reverse-macro (1 2 3)))
(for-function '(i 1 100) '(print i))

; It does.

(exit)


----------------------------------------------------------------
Speed of The Evaluation vs. Length of The Names of The Variables
----------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/07/speed-of-evaluation-vs-length-of.html

; Newlisp is an interpreter; so one question bothered me: does the
; length of the variables influence the speed of the evaluation?
; Is my program any faster if I use, say, x instead of xxx? It
; should be at least bit faster. But how much faster?

; I wrote the program that evaluates essentially same expression,
; but with different variables;

; (for (a 1 10) ...
; (for (aa 1 10) ...
; (for (aaaa 1 10) ...

; and so forth.

; On my surprise, there are no noticeable differences in the
; time required for evaluation. Here are the results:

; length(var)=1, length(expression)=35, time=340
; length(var)=2, length(expression)=38, time=339
; length(var)=4, length(expression)=44, time=336
; length(var)=8, length(expression)=56, time=364
; length(var)=16, length(expression)=80, time=359
; length(var)=32, length(expression)=128, time=350
; length(var)=64, length(expression)=224, time=354
; length(var)=128, length(expression)=416, time=364
; length(var)=256, length(expression)=800, time=352
; length(var)=512, length(expression)=1568, time=337
; length(var)=1024, length(expression)=3104, time=332
; length(var)=2048, length(expression)=6176, time=360
; length(var)=4096, length(expression)=12320, time=342
; length(var)=8192, length(expression)=24608, time=337
; length(var)=16384, length(expression)=49184, time=337
; length(var)=32768, length(expression)=98336, time=351
; length(var)=65536, length(expression)=196640, time=338
; length(var)=131072, length(expression)=393248, time=339
; length(var)=262144, length(expression)=786464, time=341
; length(var)=524288, length(expression)=1572896, time=356
; length(var)=1048576, length(expression)=3145760, time=348
; length(var)=2097152, length(expression)=6291488, time=341
; length(var)=4194304, length(expression)=12582944, time=336
; length(var)=8388608, length(expression)=25165856, time=347

; And i did it for another expression, this time bit more
; complicated, again, there is no visible influence of the
; length of the variable and length of the expression on
; evaluation time.

; length(var)=1, length(expression)=79, time=1565
; length(var)=2, length(expression)=87, time=1562
; length(var)=4, length(expression)=103, time=1574
; length(var)=8, length(expression)=135, time=1559
; length(var)=16, length(expression)=199, time=1568
; length(var)=32, length(expression)=327, time=1557
; length(var)=64, length(expression)=583, time=1555
; length(var)=128, length(expression)=1095, time=1545
; length(var)=256, length(expression)=2119, time=1544
; length(var)=512, length(expression)=4167, time=1554
; length(var)=1024, length(expression)=8263, time=1564
; length(var)=2048, length(expression)=16455, time=1553
; length(var)=4096, length(expression)=32839, time=1560
; length(var)=8192, length(expression)=65607, time=1557
; length(var)=16384, length(expression)=131143, time=1559
; length(var)=32768, length(expression)=262215, time=1557
; length(var)=65536, length(expression)=524359, time=1554
; length(var)=131072, length(expression)=1048647, time=1539
; length(var)=262144, length(expression)=2097223, time=1521
; length(var)=524288, length(expression)=4194375, time=1527
; length(var)=1048576, length(expression)=8388679, time=1550
; length(var)=2097152, length(expression)=16777287, time=1536
; length(var)=4194304, length(expression)=33554503, time=1534
; length(var)=8388608, length(expression)=67108935, time=1535

(setq varname 'a)
(for (i 1 24)
     (set 'expr
          (expand '(for (varname 1 100)
                        (+ (- varname 1) (- varname 2)))
                   'varname))
     (set 'evtime
          (time (eval (eval expr)) 10000))

     (print "length(var)=" (length (string varname)))
     (print ", length(expression)=" (length (string expr)))
     (println ", time=" evtime)

     (setq varname (sym (dup (string varname) 2))))

(println)

(setq varname1 'a)
(setq varname2 'b)
(for (i 1 24)
     (set 'expr
          (expand '(begin (set 'varname1
                               (lambda(varname2)
                                      (if (< varname2 3)
                                          1
                                          (+ (varname1 (- varname2 1))
                                             (varname1 (- varname2 2))))))
                          (varname1 12))
                  'varname1
                  'varname2))
     (set 'evtime
          (time (eval expr) 10000))

     (print "length(var)=" (length (string varname1)))
     (print ", length(expression)=" (length (string expr)))
     (println ", time=" evtime)

     (setq varname1 (sym (dup (string varname1) 2)))
     (setq varname2 (sym (dup (string varname2) 2))))

Commenti
--------
*** Anonymous 29 July 2008 at 17:34
Before newLISP evaluates an expression, the reader compiles each expression to an internal tree structure of lisp cells, where a variable is just a memory pointer to a symbol.
Any difference in execution time would only be visible during source code loading or during execution of newLISP functions, which itself translate variable names when creating symbols, like (sym ...).


------------------------
Exploring The References
------------------------
http://kazimirmajorinc.blogspot.com/2008/08/exploring-references.html

;===============================================================
; Programming languages differ in the memory management systems
; they use. The Newlisp has its own, original system named ORO -
; One Reference Only, which is something in between manual
; memory management and garbage collection. In this post I
; explore use of the references inside of ORO.
;
; The "references" are the symbols with special names,
; "reference 1", "reference 2" ... (without quotes). Idea is,
; that sometimes, instead of storing values in the variables,
; the values can be stored in "references". Because references
; take constant space in memory, they can be copied faster than
; large values, and also, many variables can evaluate to same
; reference.
;
;                        NOW IT IS LIKE THIS:
;
;                +---------+             +---------+
;                |         |           \ |         |
;                |    X    |------------>|   317   |
;                |         |           / |         |
;                +---------+             +---------+
;
;
;                +---------+             +---------+
;                |         |           \ |         |
;                |    Y    |------------>| (1 7 2) |
;                |         |           / |         |
;                +---------+             +---------+
;
;
;                +---------+             +---------+
;                |         |           \ |         |
;                |    Z    |------------>| (1 7 2) |
;                |         |           / |         |
;                +---------+             +---------+
;
;                 VARIABLES                VALUES
;
;
;                         I WANT THIS ALSO:

;
;    +---------+                                     +---------+
;    |         |                                   \ |         |
;    |    X    |------------------------------------>|   317   |
;    |         |                                   / |         |
;    +---------+                                     +---------+
;
;
;    +---------+             +---------+             +---------+
;    |         |           \ |         |           \ |         |
;    |    Y    |------------>| ref. 1  |------------>| (1 7 2) |
;    |         |           / |         |           / |         |
;    +---------+             +----A----+             +---------+
;                                /|\
;                                /
;    +---------+               ,'
;    |         |          _,,-'
;    |    Z    |--------''
;    |         |
;    +---------+
;
;    VARIABLES              REFERENCES                  VALUES
;
; Picture above is made with Jave editor, http://www.jave.de/
;
; Let's start with code, the examples will explain the purpose
; if reader is in doubt.
;
;---------------------------------------------------------------
; REFERENCE-COUNTER
;
; Global variable containing number of already defined references.
; Used internally by reference. The largest number is
; 9223372036854775807. Hence, program can reference correctly for
; limited but very long time, i.e. millions of years with current
; computer speed.

(set 'reference-counter 0)

;---------------------------------------------------------------
; REFERENCE
;
; (reference <expr>) =
;    previously unused symbol of the form "reference 1", "reference 2"
;    etc is created; its value is initalized to result of the evaluation
;    of <expr>. The reference is returned as the result of the function
;    call (reference <expr>).

(set 'reference
      (lambda(reference-value)
          (inc 'reference-counter)
          (set 'new-reference
               (sym (append "reference " (string reference-counter))))
          (set new-reference reference-value)
               new-reference))

; EXAMPLES

(println "\nREFERENCE EXAMPLES ---------------------------------")

(println (reference nil))         ;reference 1
(println (eval (reference nil)))  ;nil
(set 'z (reference (list 1 2 3)))
(println z)                       ;reference 3

;---------------------------------------------------------------
; REFERENCE?
;
; (reference? <expr>) = true if <expr> EVALUATES to reference
;                       nil otherwise

(set 'reference?
     (lambda(arg)
        (and (symbol? arg))
             (starts-with (string arg) "reference " )))

; EXAMPLES:

(println "\nREFERENCE? EXAMPLES --------------------------------")

(println (reference? (list 1 2 3)))             ; nil
(println (reference? (reference (list 1 2 3)))) ; true
(println (reference? z))                        ; true

;---------------------------------------------------------------
; DEREFERENCE
;
; (dereference <expr>) =
;    if <expr> evaluates to reference:         that reference
;    if <expr> doesn't evaluate to reference:  error
;
; Usage note: dereference is frequently used in combination with eval.
; See example bellow. That eval cannot be integrated in DEREFERENCE
; because in that case, COPY of the value stored in the reference
; would be returned, and it ruins main purpose of the references,
; to avoid making copies.

(set 'dereference
     (lambda-macro()
        (if (reference? (eval (first $args)))
            (eval (first $args))
            (throw-error (append "(dereference "
                                 (string (first $args))
                                 ") error: argument doesn't"
                                 " evaluate to reference: "
                                 (string (eval (first $args))))))))

; EXAMPLES

(println "\nDEREFERENCE EXAMPLES -------------------------------")

(set 'Borg (reference (list 1 2 3)))
(set 'Locutus Borg)

(println (eval (dereference Borg)))        ; (1 2 3)
(println (eval (dereference Locutus)))     ; (1 2 3)

(push 40 (eval (dereference Locutus)))
(println (eval (dereference Borg)))        ; (40 1 2 3)
(println (eval (dereference Locutus)))     ; (40 1 2 3)

;---------------------------------------------------------------
; DEREFERENCE-IF-NEEDED

; (dereference-if-needed <expr>) =
;    if <expr> evaluates to reference: that reference
;                                else: quoted result of
;                                      evaluation of <expr>
;
; Purpose: to be able to treat references and other values uniformly,
; i.e (eval (dereference-if-needed x)) can replace x.

(set 'dereference-if-needed
     (lambda-macro()
        (if (reference? (eval (first $args)))
            (eval (first $args))
            (eval (list 'quote (first $args))))))

; EXAMPLES:

(println "\nDEREFERENCE-IF-NEEDED EXAMPLES ---------------------")

(set 'L (list (list 1 2 3)
              (list 4 5 6)
              (list 7 8 9)))

; What happens if in some kind of loop we push 40 in all sublists
; of list L?

(dolist(i L)
  (print "i before push=" i)
  (push 40 i)
  (println ", after push= " i))

; i before push=(1 2 3), after push= (40 1 2 3)
; i before push=(4 5 6), after push= (40 4 5 6)
; i before push=(7 8 9), after push= (40 7 8 9)

; Which one of the changes lasted in L?

(dolist(i L)
   (println "i=" (eval (dereference-if-needed i))))
;
; i=(1 2 3)
; i=(4 5 6)
; i=(7 8 9)
;
; Obviously, neither one.
;
; Now, let us try to change L so it contains one reference, and
; use (eval (dereference-if-needed i)) instead of i directly.

(println "---------")

(set 'L (list (list 1 2 3)
              (reference (list 4 5 6))
              (list 7 8 9)))

(dolist(i L)
  (print "(eval (deref... i) before push="
         (eval (dereference-if-needed i)))
  (push 40 (eval (dereference-if-needed i)))
  (println ", after push= " (eval (dereference-if-needed i))))

; (eval (deref... i) before push=(1 2 3), after push= (40 1 2 3)
; (eval (deref... i) before push=(4 5 6), after push= (40 4 5 6)
; (eval (deref... i) before push=(7 8 9), after push= (40 7 8 9)

; Which changes lasted?

(dolist(i L)
   (println "(eval (deref... i)=" (eval (dereference-if-needed i))))

; (eval (deref... i)=(1 2 3)
; (eval (deref... i)=(40 4 5 6) <========= :)
; (eval (deref... i)=(7 8 9)

; Another example:

(println "---------")

(set 'M (list 1))
(push 70 (eval (dereference-if-needed M)))
(println M); (70 1)

;===============================================================
; FUNCTIONS THAT RECOGNIZE REFERENCES
;
; The problem is, of course, that (eval (dereference-if-needed M))
; is large and unpractical. Of course, in practice, it would be
; useful to rename dereference-if-needed to something shorter, like &&&.
; Unfortunately we cannot get rid of eval.
;
; However, in we use our own functions, we can delegate the care about
; references to the functions. And it is not really complicated. For example,
; if I want to define function push/r which does exactly the same
; thing as push, but it also accept references, only thing I have
; to do in (push/r <expr1> <expr2>) is to construct expression
;
;       (push (eval(dereference-if-needed <expr1>))
;             (eval(dereference-if-needed <expr2>))
;
; and then, to evaluate it. It can be easily achieved in Newlisp.

(set 'push/r
   (lambda-macro(my-pusharg1 my-pusharg2)
       (eval (expand '(push (eval (dereference-if-needed my-pusharg1))
                            (eval (dereference-if-needed my-pusharg2)))
                     'my-pusharg1
                     'my-pusharg2))))

; The function println/r is bit more complicated. It accepts
; undefined number of arguments; (println/r <expr1> .... <exprn>
; should construct
;
;     (println (eval(dereference-if-needed <expr1>))
;              ...
;              (eval(dereference-if-needed <exprn>)))
;
; and then evaluate it.

(set 'println/r
     (lambda-macro()
        (eval (append '(println)
                      (map (lambda(maparg)
                             (expand '(eval (dereference-if-needed
                                            maparg))
                                     'maparg))
                           $args)))))

; EXAMPLES:

(println "\nFUNCTIONS THAT RECOGNIZE REFERENCES ----------------")

(set 'N (list 1))
(set 'O (reference (list 1)))
(push/r (list "N") N)
(push/r (list "O") O)
(println/r N O) ; (("N") 1)(("O") 1)

;===============================================================
; AUTOMATIC GENERATIONS OF THE FUNCTIONS THAT RECOGNIZE REFERENCES

; As we have seen in examples, especially from println - definition of
; push/r and println/r is quite mechanic. Somehow it happened even
; the names of the functions are not innovative. Hence, generation
; of such functions can be automatized.

(set 'reference-enable
     (lambda(normal-function-name)
        (set (sym (append (string normal-function-name) "/r"))
             (expand '(lambda-macro()
                        (eval (append '(normal-function-name)
                                      (map (lambda(maparg)
                                             (expand '(eval (dereference-if-needed
                                                               maparg))
                                                     'maparg))
                                           $args))))
                     'normal-function-name))))

; EXAMPLES:

(reference-enable 'sin)
(println/r (sin/r (reference 50))) ;-0.2623748537

(reference-enable 'slice)
(println/r (slice/r (reference (list 10 9 8 7 6 5 4)) 2 3)); (8 7 6)

(reference-enable 'sort)
(reference-enable '<)
(apply 'println/r (sort/r (reference (list (reference 8)
                                           2
                                           (reference 4)))
                           </r)) ; (2 4 8)

;---------------------------------------------------------------
; Now, we'll do our usual trick; pass through the list of all symbols
; and define "reference-enabled" versions of all primitives,
; functions and macros - just in case.

(dolist(f (symbols))
  (let ((ef (eval f)))
       (when (or (primitive? ef)
                 (lambda? ef)
                 (macro? ef))
             (reference-enable f))))

; EXAMPLES

(println/r (reverse/r (reference (list 2 7 5 4)))) ;(4 5 7 2)

(println/r (add (mul   (sin 26)
                       (sin/r (reference 26)))
                (mul/r (reference (cos 26))
                       (cos/r (reference 26))))) ; 1

; Yes, even the last one evaluates correctly.

; Functions defined on this way work just fine.
; However, they do not eliminate the need for explicit dereferencing.
; For example
;
;       (dolist/r (reference (list 'i 'L)) ...)
;
; can be useful sometimes, but it doesn't replace
;
;     (dolist (i (eval (dereference-if-needed L))) ... )

;===============================================================
; WHAT NEXT?
;
; Obviously, the technique is promissing. However, some problems
; are left. One of them is well known - memory management. Each call
; (reference <expr>) defines new symbol, and it is not automatically
; deleted once it is not used any more as other values generated
; during runtime. So, either "manual" or "automatic" memory
; deallocation could be required.

; Conveniently, I'll leave that topic for other occasion.

(exit)

Commenti
--------
*** Anonymous 3 August 2008 at 18:04
Excellent article. Very good!

Are you getting major speed benefits from doing this?

*** Kazimir Majorinc 3 August 2008 at 22:07
If algorithm is naive, i.e one didn't used anything similar for the same purpose, and values are large, benefits are huge:

(set 'zref (reference (sequence 0 1 0.000001)))
(set 'z (sequence 0 1 0.000001))

(set 'fref (lambda(x)(add (last/r x) (first/r x))))
(set 'f (lambda(x)(add (last x) (first x))))

(println "references time=" (time (fref zref) 1000))
(println "without references time=" (time (f z) 1000))
(exit)

references time=14
without references time=24825


-------------------------------------------------
Three Techniques for Avoidance of Multiple Copies
-------------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/08/three-techniques-for-avoidance-of.html

;===============================================================
; AVOIDING MULTIPLE COPIES.
;
; Few posts ago I discovered that functions, macros and lot of control
; structures in Newlisp copy the results of evaluation, instead of
; passing it directly. Of course, it was discovery for myself -
; experienced Newlispers knew that, and it is certainly written somewhere
; in manual. But you know how it is, the manual is the last resort,
; powerful magic that shouldn't be used unless absolutely necessary.
;
; Anycase, the fact that copies of the values are so frequent opens
; interesting and important questions about possible inefficiencies
; and techniques for their avoidance.
;
; In this post I summarize four techniques I tried for returning
; of the values from blocks and functions. They are tested on
; two implementations of the very simple function
; that for given n returns the list (1 ... n), and empty list if
; n=0. Also, if n<0 function should generate error, othwerwise
; it increases counter for 1.
;
; First implementation, f is non-recursive and uses built in
; function sequence; second implementation, g is recursive and doesn't
; use the sequence.
;
; Each of these two are tested for correctness, and then for speed of
; evaluation, for different values of n.
;
;---------------------------------------------------------------
; TECHNIQUE I. "STRAIGHT" IMPLEMENTATION
;
; It is the most natural one.

(set 'counter 0)
(set 'f (lambda(n)(if (< n 0)
                      (error "Negative")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (list)
                                 (sequence 1 n 1))))))

(set 'g (lambda(n)(if (< n 0)
                      (error "Negative.")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (list)
                                 (append (g (- n 1))
                                         (list n)))))))

(println "======================================================")
(println "I. STRAIGHT IMPLEMENTATION.")

; Test is the function that calls f and g with various parameters,
; measures time and print results. Not really interesting,
; so I suggest you to skip over it.

(set 'test
     (lambda(eval-needed)
       (println)
       (println "Correctness:")
       (println)
       (println (if eval-needed (eval (f 10)) (f 10)))
       (println (if eval-needed (eval (f 10)) (f 10)))
       (println)
         (set 'maxf 7)
         (set 'maxg 3)
         (for (j 0 maxf 1)
            (letn ((argument (pow 10 j))
                   (to-repeat (pow 10 (- maxf j)))
                   (t (if eval-needed
                          (div (mul (time (eval (f argument)) to-repeat)
                                  1000000)
                               to-repeat)
                          (div (mul (time (f argument) to-repeat)
                                  1000000)
                               to-repeat))))

                   (println "(f "  (format "%10d" argument) ") "
                            (format "%12d" (div t 10)) "0 ns/list, "
                            (format "%8d" (div t argument)) " ns/element")))

         (println)

         (for (j 0 maxg 1)
            (letn ((argument (pow 10 j))
                   (to-repeat (* (pow 10 (- maxg j)) 100))
                   (expr (if eval-needed '(eval (g argument)) '(g argument)))
                   (t (if eval-needed
                          (div (mul (time (eval (g argument)) to-repeat)
                                    1000000)
                               to-repeat)
                          (div (mul (time (g argument) to-repeat)
                                    1000000)
                               to-repeat))))
                    (println "(g "  (format "%10d" argument) ") "
                             (format "%12d" (div t 10)) "0 ns/list, "
                             (format "%8d" (div t argument)) " ns/element")))

        (println)))

(test nil); nil will be explained later

;---------------------------------------------------------------
; II. RETURNING VARIABLES AND EVALUATING IN CALLER ENVIRONMENT
;
; This technique I discussed on Newlisp Forum already. Idea is
; that instead of, for example, block
;
; [1]   (begin ... (list 1 2 3 4))
;
; that returns (1 2 3 4) we can use
;
; [2]   (eval ... (begin ... (set 'temp (list 1 2 3 4)) 'temp))
;
; On the same way, instead of
;
; [3]   (set 'f (lambda() ... (list 1 2 3 4)))
;
; we should write
;
; [4]   (set 'f (lambda(...) .... (set 'temp (list 1 2 3 4)) 'temp))
;
; And so forth. What was achieved? In [1] list (1 2 3 4) which
; is constructed inside begin block is not returned directly, but
; its copy. In [2] symbol temp is returned and later evaluated.
; Symbol temp is also copied, but it is - small. So, we spare
; one copy of the potentially large list. True,
;
;    (set 'temp (list 1 2 3 4))
;
; maybe copy the value (1 2 3 4). If it does, then it is still only
; one copy, and typically there is more than one nested block. Second,
; some tests suggests me that Newlisp is already optimized to do
; (set 'temp <value>) without copies if <value> is temporary, i.e.
; it is not assigned to some other variable. Still, I do not know is
; it true, but even if it is not, the first advantage still remains.

(set 'f (lambda(n)(if (< n 0)
                      (error "Negative")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (begin (set 'temp (list))
                                        'temp)
                                 (begin (set 'temp (sequence 1 n 1))
                                        'temp))))))

(set 'g (lambda(n)(if (< n 0)
                      (error "Negative.")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (begin (set 'temp (list))
                                        'temp)
                                 (begin (set 'temp
                                             (append (eval (g (- n 1)))
                                                     (list n)))
                                        'temp))))))

(println "======================================================")
(println "II. RETURNING VARIABLES AND EVALUATING IN CALLER ENVIRONMENT.")

(test true); true = needs eval in caller environment

;---------------------------------------------------------------
; III. RETURNING EXPRESSIONS AND EVALUATING THEM IN CALLER ENVIRONMENT
;
; But - if we return values in variables, and then we evaluate
; these variables - we can return expressions used for definitions
; of variables as well. It is pretty radical, and very "Lispy" idea,
; if anything is "code=data" that is. However, there is a problem
; as well: Lisp code is - ehm - list; Code that generates lists is
; not necessarily smaller than list itself - although it is almost
; certainly smaller than some large lists.
;
; Function "expand" is useful for elimination of the various local
; variables from code of the function that should be returned.

(set 'f (lambda(n)(if (< n 0)
                      (error "Negative")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 '(list)
                                 (expand '(sequence 1 n 1)
                                         'n))))))

(set 'g (lambda(n)(if (< n 0)
                      (error "Negative.")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 '(list)
                                 (expand '(append (eval (g (- n 1)))
                                                  (list n))
                                         'n))))))

(println "======================================================")
(println "III. RETURNING EXPRESSIONS AND EVALUATING IN CALLER ENVIRONMENT")

(test true)

;---------------------------------------------------------------
; IV. USING CONTEXTS
;
; In recent Newlisp versions, context variables are also returned
; by reference. So, they can be used for optimization as well, and
; they could be returned without need for eval in the caller environment.

(set 'f (lambda(n)(if (< n 0)
                      (error "Negative")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (begin (set 'q:q (list))
                                        q:q)
                                 (begin (set 'q:q (sequence 1 n 1))
                                        q:q))))))

(set 'g (lambda(n)(if (< n 0)
                      (error "Negative.")
                      (begin (inc 'counter)
                             (if (= n 0)
                                 (begin (set 'q:q (list))
                                        q:q)
                                 (begin (set 'q:q
                                             (append (g (- n 1))
                                                     (list n)))
                                        q:q))))))

(println "======================================================")
(println "IV. CONTEXTS")

(test nil)
(exit)
;===============================================================
;                          RESULTS
;
; Comment or cut them out if you want to evaluate the code,
; I cannot resist this beautiful green - blue combination.
; "ns" stands for nanoseconds.

======================================================
I. STRAIGHT IMPLEMENTATION.

Correctness:

(1 2 3 4 5 6 7 8 9 10)
(1 2 3 4 5 6 7 8 9 10)

(f          1)          1220 ns/list,     1225 ns/element
(f         10)          2420 ns/list,      242 ns/element
(f        100)         13580 ns/list,      135 ns/element
(f       1000)        132000 ns/list,      132 ns/element
(f      10000)       1312000 ns/list,      131 ns/element
(f     100000)      14970000 ns/list,      149 ns/element
(f    1000000)     155900000 ns/list,      155 ns/element
(f   10000000)    1954000000 ns/list,      195 ns/element

(g          1)          2180 ns/list,     2180 ns/element
(g         10)         18800 ns/list,     1880 ns/element
(g        100)        705000 ns/list,     7050 ns/element
(g       1000)      80390000 ns/list,    80390 ns/element

======================================================
II. RETURNING VARIABLES AND EVALUATING IN CALLER ENVIRONMENT.

Correctness:

(1 2 3 4 5 6 7 8 9 10)
(1 2 3 4 5 6 7 8 9 10)

(f          1)          1300 ns/list,     1306 ns/element
(f         10)          1990 ns/list,      199 ns/element
(f        100)          9370 ns/list,       93 ns/element
(f       1000)         87700 ns/list,       87 ns/element
(f      10000)        722000 ns/list,       72 ns/element
(f     100000)       7380000 ns/list,       73 ns/element
(f    1000000)      72100000 ns/list,       72 ns/element
(f   10000000)     689000000 ns/list,       68 ns/element

(g          1)          3570 ns/list,     3570 ns/element
(g         10)         20000 ns/list,     2000 ns/element
(g        100)        440000 ns/list,     4400 ns/element
(g       1000)      33960000 ns/list,    33960 ns/element

======================================================
III. RETURNING EXPRESSIONS AND EVALUATING IN CALLER ENVIRONMENT

Correctness:

(1 2 3 4 5 6 7 8 9 10)
(1 2 3 4 5 6 7 8 9 10)

(f          1)          2000 ns/list,     2008 ns/element
(f         10)          2690 ns/list,      269 ns/element
(f        100)          9580 ns/list,       95 ns/element
(f       1000)         89200 ns/list,       89 ns/element
(f      10000)        702000 ns/list,       70 ns/element
(f     100000)       7610000 ns/list,       76 ns/element
(f    1000000)      74100000 ns/list,       74 ns/element
(f   10000000)     755000000 ns/list,       75 ns/element

(g          1)          4940 ns/list,     4940 ns/element
(g         10)         41500 ns/list,     4150 ns/element
(g        100)        653000 ns/list,     6530 ns/element
(g       1000)      38600000 ns/list,    38600 ns/element

======================================================
IV. CONTEXTS

Correctness:

(1 2 3 4 5 6 7 8 9 10)
(1 2 3 4 5 6 7 8 9 10)

(f          1)          1500 ns/list,     1501 ns/element
(f         10)          3370 ns/list,      337 ns/element
(f        100)         25260 ns/list,      252 ns/element
(f       1000)        276600 ns/list,      276 ns/element
(f      10000)       2384000 ns/list,      238 ns/element
(f     100000)      21970000 ns/list,      219 ns/element
(f    1000000)     215000000 ns/list,      215 ns/element
(f   10000000)    2162000000 ns/list,      216 ns/element

(g          1)          3900 ns/list,     3900 ns/element
(g         10)         25600 ns/list,     2560 ns/element
(g        100)       1068000 ns/list,    10680 ns/element
(g       1000)     118160000 ns/list,   118160 ns/element

; Comment.

; Look at third column, it is most important. I our example,
; straight technique I. is the best only if lists are very small.
; If lists have some 8-15 elements, then technique II. is the
; best, and technique III. is slightly worse, but if lists
; have some 12-80 elements it is also better than technique I.
; As lists grow, both techniques are 2-3 times better than I.
; Technique IV. is worse than I. in all cases.
;
; Note that factor 2-3 is not universal - it depends on the depth
; of the nested control structures. The advantage is so significant
; that in any time critical program, technique II. could be
; unavoidable.

; Both technique II. and III. are pretty safe for use, i.e.
; incidence of errors probably doesn't increase significantly.
; Technique II. uses global variable, hence, it might cause the
; problems in some cases of multiprocessing, but it is safe for
; all uniprocessing situations. Technique III. doesn't use global
; variables, so it should be always safe.
;
; One problem is evaluation in the caller environment - it requires
; lot of eval's in the source code. As it has no alternative if one
; want to maximize the speed of his code, it gives the weight to my
; proposal for new forms of lambda/eval and lambda-macro/eval expressions
; evaluating in the caller environment without need for explicit
; call of eval.

Commenti
--------
Anonymous 7 August 2008 at 14:07
In "IV. Contexts" you are not returning a context reference but the full variable. To return as a reference return in the last line use: q not q:q. The way it is written now it returns the contents of the variable q:q and internally doing the copy.

Returning a context reference and evaluating in the callers environment is then the same as returning a variable reference:

; evaluate in called function
(define (foo1 n)
(set 'v (sequence 1 n)))

; return var ref and caller evaluates
(define (foo2 n)
(set 'v (sequence 1 n))
'v)

: return context ref and caller evaluates
(define (foo3 n)
(set 'q:q (sequence 1 n))
q)

; get timings
(time (begin (foo1 1000)) 10000) => 895
(time (begin (foo2 1000) v) 10000) => 653
(time (begin (foo3 1000) q:q) 10000) =>657

Now the timings make more sense ;-)

What is new in the recent version is not returning context references but passing them into newLISP built-in functions. Contexts always have been returned and passed to user-defined functions as references. The recent additions is, that default functors can be passed to any built-in function:

(set 'q:q '(3 2 4 5 7 3))
(sort q) => (2 3 3 4 5 7)
q:q => (2 3 3 4 5 7)

*** Kazimir Majorinc 9 August 2008 at 06:56

OK, I see the point about contexts. One question:

(define(f n)
(set 'q:q (sequence 1 n))
q)

; This works

(reverse (f 5)); => (5 4 3 2 1)

; But for printing,

(println (f 5)) ; doesn't
(println (eval (f 5))) ; doesn't

; the best I've find
(println (eval (default (f 5))))

Bit longer, I can live with that, but default is deprecated.
What is the alternative?


----------------------------------------------------------------------
For-like Syntax for Rnd Function and Generalized Floor and The Friends
----------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2008/08/for-like-syntax-for-rnd-function-and.html

;===============================================================
; I like for loop. It is only one loop I can write automatically,
; for all other loops I always have to think what happens
; inside, and what is really exit condition. It seems that for
; loop somehow fit well into my intuition, and I observed the same
; on my students.
;
; On the other side, I was never quite comfortable with functions
; for random numbers, I always had to think whether upper limit
; is included or not, and what happens if I extend the segment
; or shift it. Not that it is some higher level mathematics,
; but it was never quite smooth for me.
;
; After quite a lot of programming, only yesterday I came to idea
; to use syntax for rnd resembling lovely "for" loop so I do not
; need to care about borderline cases any more. For example:
;
;   if (for i 0 10 2)    generates      0 2 4 6 8 and 10
;      (rnd   0 10 2)    should return  0, 2, 4, 6, 8 or 10
;
;   if (for   3  4 0.25) generates      3, 3.25, 3.5, 3.75 and 4
;      (rnd   3  4 0.25) should return  3, 3.25, 3.5, 3.75 or  4
;
; You got the idea. If "step" is 1, then it can be omitted, like in
; many for loops. But what about real numbers - is special syntax
; still required? No, for these - step is simply 0. It
; has some mathematical sense. "For" loop doesn't move if your
; step is 0, but rnd

; First, one cute set of replacements for sub, add etc.
; Usual sings for mathematically operations, followed by "."
; which should remind me on "point" from "floating point."
; It is also easier to visually parse and switch from floating point
; to integer versions and vice versa.

(set '-. sub '+. add '*. mul '/. div)

; Append for symbols.

(set 'symappend
     (lambda()(sym (apply 'append
                          (map string $args)))))

; As said, generalized floor (and when I'm here, ceil and round
; as well). There is no reason number should be ceiled
; to some multiple of 1 and not to multiple of any other number,
; not necessarily power of 10 either. It comes handy in this
; particular case.

(dolist(j (list 'floor 'ceil 'round))
   (set (symappend 'g j)
        (expand (lambda(x step)
                   (if (= step 0)
                      x
                      (*. (j (/. x step)) step)))
                   'j)))

; I'm very happy with the loop above, it demostrate few nice
; features.

(println (gfloor 3.1415926 0.001))      ;3.141
(println (gceil 324.12567 (/. 100 3)))  ;333.3333333
(println (ground 4.1888876 0.0125))     ;4.1875

(set 'rnd
     (lambda(a b step)
        (if (> a b)
            (rnd b a step) ; because of specificity of Newlisp for
            (begin (when (not step) (set 'step 1))

                   (if (and (= step 0)
                            (= (random) (random)))  ;[?]
                       b

                       (let ((scale (+. (gfloor (- b a) step) ; [??]
                                        step)))
                            (+. a (gfloor (*. scale (random))
                                          step))))))))

; Maybe only two details deserve explanation: ? and ??.
;
; [?] Why that strange (= (random) (random))?

; It is the result of distribution of the random real numbers,
; provided by majority of programming tools, so I guess that in
; Newlisp random number is also chosen from [0,1>, if adjusted for
; offset and scale, from [a,b>.
;
; That means, in ideal case, probability that a is chosen is 0,
; but it is still possible. On the other hand, not only that
; probability that (random)=b is zero, but it is completely
; impossible.
;
; Since I want that right edge of the segment has equal chances
; as a left border, I gave it one extra chance. If function generates
; two equal random numbers - I'll count it as 1. If it doesn't,
; radnom number is determined in [0, 1>. That is the idea.
;
; [??] Why formula for scale is that complicated?
;
; Because "for i:=0 to 5 step 2" is legal, and managing that case
; complicates things a bit compared to only "for i:=0 to 4 step 2."

; TEST

(seed (date-value))

(dolist(x (list '(rnd 0 5 2)
                '(rnd 3 4 0.25)
                '(rnd 1 4)
                '(rnd -6.666 -5.555 0)
                '(rnd +2 -2 0.01)))
    (println)
    (dotimes(i 6)
       (println x " = " (eval x))))

(exit)

After exit, I do not need ";" for comments any more.

RESULTS:

(rnd 0 5 2) = 0
(rnd 0 5 2) = 2
(rnd 0 5 2) = 2
(rnd 0 5 2) = 4
(rnd 0 5 2) = 0
(rnd 0 5 2) = 2

(rnd 3 4 0.25) = 3.25
(rnd 3 4 0.25) = 3.75
(rnd 3 4 0.25) = 3.5
(rnd 3 4 0.25) = 3.5
(rnd 3 4 0.25) = 3.25
(rnd 3 4 0.25) = 4

(rnd 1 4) = 1
(rnd 1 4) = 1
(rnd 1 4) = 4
(rnd 1 4) = 1
(rnd 1 4) = 3
(rnd 1 4) = 1

(rnd -6.666 -5.555 0) = -5.844655354
(rnd -6.666 -5.555 0) = -5.862020386
(rnd -6.666 -5.555 0) = -6.024592486
(rnd -6.666 -5.555 0) = -6.231477462
(rnd -6.666 -5.555 0) = -6.409919187
(rnd -6.666 -5.555 0) = -6.586712912

(rnd 2 -2 0.01) = 1
(rnd 2 -2 0.01) = 1.47
(rnd 2 -2 0.01) = -1.53
(rnd 2 -2 0.01) = -1.63
(rnd 2 -2 0.01) = 1.48
(rnd 2 -2 0.01) = -0.98

Commenti
--------
*** Anonymous 9 August 2008 at 19:29
Using the function 'sequence' and 'amb' you could define a shorter 'rnd'

(apply amb (sequence 3 4 0.25))

'sequence' works similar to 'for' but gives you a list to work on. 'amb' picks randomly a number from the list.


---------------
Light your pipe
---------------
http://kazimirmajorinc.blogspot.com/2008/08/light-your-pipe.html

(println i " = " (eval i))
;-> (+ 2 2) = 5
;-> 5
(println j " = " (eval j))
;-> 4 = 5
;-> 5

Any ideas how i did it? It is a feature, not a bug.

Commenti
--------
Anonymous9 August 2008 19:36
A little hint from anonymous :-)

> ; secret statement redefining something

> (+ 2 2)
5
> (+ 1 2 3)
7
> (+ 0)
1
>

*** newlisper 10 August 2008 16:10
You could redefine the println function:

(define ([println])
(map print (0 -1 (args)))
(print (+ 1 ((args) -1)) ))

(constant 'println [println])

but I bet you didn't do that...

*** Anonymous 10 April 2009 16:07
Using things I learned from this blog:

(set 't (sym "(+ 2 2)"))
(set 'i t)
(set i 5)
(println i " = " (eval i))

*** Kazimir Majorinc 13 April 2009 02:55
Yap, anonymous, you are right. :-)


---------------------
Two Phases Evaluation
---------------------
http://kazimirmajorinc.blogspot.com/2008/08/two-phases-evaluation.html

;---------------------------------------------------------------
;
; In this post, I implement simple support for "two phases" evaluation,
; in the form of function "prepare" that accepts code as an argument,
; and returns "prepared" code. Prepared code consists of original
; expressions, except
;
; [1] expressions of a form
;
;       (prepare-time expr1 ... exprn)

;     Such expressions are evaluated during prepare-time and replaced
;     with their results in prepared code. Again, except
;
;     [1a] if result of the evaluation during prepare time is
;          symbol !! then expression is omitted from prepared code.
;
; [2] expressions of the form (F expr1 ... exprn) where F evaluates to
;     function or macro which contains 'prepare-time symbol, for
;     example
;
;            (lambda-macro(x)
;               'prepare-time
;                (list '* x x))
;
;     Such function or macro calls are evaluated duringe prepare-time
;     and replaced in prepared code with results of their evaluation.
;
;---------------------------------------------------------------
;
; mapg and cleang are versions of map and clean that respect
; lambda and lambda-macro expressions.

(set 'mapg (lambda(f L)
             (append (cond ((lambda? L) (lambda))
                           ((macro? L)  (lambda-macro))
                           (true '()))
                      (map f L))))

(set 'cleang (lambda(f L)
               (append (cond ((lambda? L) (lambda))
                             ((macro? L)  (lambda-macro))
                             (true '()))
                        (clean f L))))

;---------------------------------------------------------------

(set 'prepare-time begin)
(set '!! '!!)

(set 'prepare-time-fn?
      (lambda(expr)(and (symbol? expr)
                        (or (lambda? (eval expr)) (macro? (eval expr)))
                        (= (nth 1 (eval expr)) ''prepare-time))))

(set 'prepare
     (lambda(expr)
        (let ((result
              (if (and (list? expr)
                       (not (empty? expr)))

                   (if (= (first expr) 'prepare-time)
                       (eval expr)           ; [1]

                       (begin (set 'expr (mapg prepare expr)); recursion

                              (if (prepare-time-fn? (first expr))
                                  (eval expr) ; [2]
                                  expr)))
                   expr)))                    ; general case

             (if (list? result)
                 (cleang (lambda(x)(= x !!)) result) ; [1a]
                  result))))

; And that's it. Really simple.
;---------------------------------------------------------------
; Now, I'll test it. I'll first define one macro (in CL Scheme style)
; in normal code, and one "normal" function, bot of them will be
; used in code that should be prepared.

(set 'diff-squares
     (lambda-macro(x y)
        'prepare-time
        (expand '(- (* x x) (* y y))
                'x 'y)))

(set 'mirror (lambda(x)
                (append x (reverse x))))

; and here is relatively complicated code that uses already
; defined macro, with some prepare-time expressions, and one
; of them even contain definition of new, recursive "prepare-time"
; macro. Prepare-time statements frequently end with !!, but not
; always.

(set 'code
     '(begin (println "Eval time: starting.")
             (prepare-time (println "Prepare-time: starting.")!!)

             (println (diff-squares (+ 3 1) (- 3 1)))
             (println (mirror '(1 2 3)))
             (prepare-time (println "Prepare-time:"
                                    (mirror '(1 0 4 0 5)))!!)
             (prepare-time (set 'fib
                                (lambda-macro(n)
                                  'prepare-time
                                  (let ((en (eval n)))
                                       (if (< en 2)
                                           '1
                                           (let ((n1 (- en 1))
                                                 (n2 (- en 2)))
                                                (list '+
                                                      (fib n1)
                                                      (fib n2)))))))!!)
             (prepare-time (set 'fibi (eval (fib 6)))!!)
             (println "Eval time: " (prepare-time fibi) " is prepared.")
             (prepare-time (println "Prepare-time: " fibi " is prepared.")!!)
             (println (diff-squares (fib 3) (fib 2)))))

; TEST

(println "------------------------------------------------------")
(println "CODE: ")
(println)
(println code)
(println "------------------------------------------------------")
(println "PREPARE TIME:")
(println)
(set 'prepared-code (prepare code))
(println "------------------------------------------------------")
(println "PREPARED CODE:")
(println)
(println prepared-code)
(println "------------------------------------------------------")
(println "EVALUATION OF PREPARED CODE:")
(println)
(eval prepared-code)

(exit)

;======================================================
; RESULTS:
;------------------------------------------------------
; CODE:
;
; (begin
;  (println "Eval time: starting.")
;  (prepare-time (println "Prepare-time: starting.") !!)
;  (println (diff-squares (+ 3 1) (- 3 1)))
;  (println (mirror '(1 2 3)))
;  (prepare-time (println "Prepare-time:" (mirror '(1 0 4 0 5))) !!)
;  (prepare-time (set 'fib (lambda-macro (n) 'prepare-time
;     (let ((en (eval n)))
;      (if (< en 2)
;       '1
;       (let ((n1 (- en 1)) (n2 (- en 2)))
;        (list '+ (fib n1) (fib n2))))))) !!)
;  (prepare-time (set 'fibi (eval (fib 6))) !!)
;  (println "Eval time: " (prepare-time fibi) " is prepared.")
;  (prepare-time (println "Prepare-time: " fibi " is prepared.") !!)
;  (println (diff-squares (fib 3) (fib 2))))
;
; ------------------------------------------------------
; PREPARE TIME:
;
; Prepare-time: starting.
; Prepare-time:(1 0 4 0 5 5 0 4 0 1)
; Prepare-time: 13 is prepared.
; ------------------------------------------------------
; PREPARED CODE:
;
; (begin
;  (println "Eval time: starting.")
;  (println (- (* (+ 3 1) (+ 3 1)) (* (- 3 1) (- 3 1))))
;  (println (mirror '(1 2 3)))
;  (println "Eval time: " 13 " is prepared.")
;  (println (- (* (+ (+ 1 1) 1) (+ (+ 1 1) 1)) (* (+ 1 1) (+ 1 1)))))
; ------------------------------------------------------
; EVALUATION OF PREPARED CODE:
;
; Eval time: starting.
; 12
; (1 2 3 3 2 1)
; Eval time: 13 is prepared.
; 5
;
;
; It works.


---------------------------------
The Predicates =?, >? and Friends
---------------------------------
http://kazimirmajorinc.blogspot.com/2008/08/predicates-and-friends.html

;===============================================================
; Predicates =?, >? and friends

(dolist (predicate '(< > = <= >= !=))
  (set 'left (sym (append (string predicate) "?")))
  (set 'right (expand (lambda(x)
                         (expand (lambda(y)
                                     (predicate y x))
                                 'x))
                      'predicate))
  (set left right))

(println (filter (<=? 3) '(1 2 3 4 5 1 2 3 4 5)))
(println (map (=? 4)     '(1 2 3 4 5 1 2 3 4 5)))
(println (clean (>? 1)   '(1 2 3 4 5 1 2 3 4 5)))
(exit)

RESULTS:

(1 2 3 1 2 3)
(nil nil nil true nil nil nil nil true nil)
(1 1)

Commenti
--------
*** Anonymous 17 August 2008 at 00:35
I like watching you program, Kasimir! creative, like a musician...

a less creative way:

(find-all 3 '(1 2 3 4 5 1 2 3 4 5) $0 >=)
;-> (1 2 3 1 2 3)

(find-all 1 '(1 2 3 4 5 1 2 3 4 5) $0 >=)

;-> (1 1)

*** Unknown 4 December 2008 at 01:19
Built-in curry is much faster then handmade one:

(map (curry = 3) '(1 2 3 4 5 6))

But I like this technique of generating the "postfixed" versions of existing functions, too! My favorite is here (the surronding text is in Russian, bud you don't need to read it: newlisp itself is enough! ;-)

https://slobin.livejournal.com/148287.html

You can't scare the real Lisp fanatic with parentheses. But still, sometimes, in some contexts, they seem superfluous. Let's try to highlight one useful idiom. We write a macro of six lines:

(define-macro (make-pass)
  (doargs (arg)
    (letex ((Old arg)
            (New (sym (append (string arg) "&"))))
      (define-macro (New)
        (Old (eval (args)))))))

We list the functions we need:

(make-pass catch not print)

And we use:

(catch& while (read-line)
  (setq line (current-line))
  (if (not& empty? line)
      (print& format "%s\n" line)
      (throw 'empty)))

In my opinion, it turned out well. I like. Ampersand - it's all kind of infix, it's easy to believe that it combines two functions into one. It is almost certainly possible to translate this to Common Lisp, to the Scheme with its hygienic macros - I'm not sure.

*** Kazimir Majorinc 4 December 2008 at 18:55
Yes, your right that curry is faster than =?. At least their results (=? 3) and (curry = 3) are about equally fast!

Good code that one with not& etc. I didn't know it is so simple.


-------------------------------------
Majorinc.default-library.lsp uploaded
-------------------------------------
http://kazimirmajorinc.blogspot.com/2008/09/majorincdefault-librarylsp-uploaded-on.html

That library contains some generally useful functions described in this blog already.

http://kazimirmajorinc.com/Default.lsp

Commenti
--------
*** Anonymous 9 October 2008 at 18:39
a typo and a question:

(set '***? (lambda(predicate)
(local (left rigth)

here, rigth should be right ?

Also, what does this say?

(println "set-quoted-block: nije pronadjen u listi.")

:)

*** Kazimir Majorinc 11 October 2008 at 22:58
Hey thanx. This typo could cause
hard to find errors.

"nije pronadjen u listi" is
"not found in list" on Croatian.

I'll fix that in next version.
Currently I'm trying to improve those debug wrap.


---------
Macrocall
---------
http://kazimirmajorinc.blogspot.com/2008/10/syntax-for-macro-parameters.html

;===============================================================
;
;
;         Generalized syntax for macro parameters.
;         ========================================
;
; Let us take a look on simple and typical macro call:

                 ((lambda-macro(X Y)
                      (println "X=" X "; Y=" Y))

                      (+ 1 2)
                      (- (* 4 5)))

; This macro call should produce output
;
;          X=(+ 1 2); Y= (- (* 4 5))
;
; I'll try to define version of lambda-macro that accepts parameters
; in more general form: for example, one might find compelling
; to define
;
;          ((lambda-macro L
;                         (println "L=" L))
;
;                         (+ 1 2)
;                         (- (* 4 5)))
;
; and output should be
;
;          L=((+ 1 2) (- (* 4 5)))
;
; or
;
;         ((lambda-macro (X (Y Z))
;                        (println "X=" X "; Y=" Y "; Z=" Z))
;
;                        (+ 1 2) (- (* 4 5)))
;
; And output is
;
;          X=(+ 1 2); Y=-; Z=(* 4 5)
;
; So, improvement is in the way values are assigned to the parameters
; of the macros X, Y, Z and L. Some kind of unification will be
; used.
;
;
;             Macrocall instead of lambda-macro.
;             ==================================
;
; It would be complicated to insist on syntax above; I'd
; have to write my own interpreter if I want it understands new
; lambda-macro. Because of that, I'll use syntax inspired partly
; with common Lisp and partly with Pico Lisp. Instead of
;
;               ((lambda-macro(X Y)
;                    (println "X=" X "; Y=" Y))
;
;                    (+ 1 2)
;                    (- (* 4 5)))
;
; I'll use
;
;        (macrocall '((X Y)(println "X=" X "; Y=" Y))
;                   '((+ 1 2) (- (* 4 5))))
;
; The first list '((X Y)(println "X=" X "; Y=" Y)) can be
; understood as macro definition; also, I'll use
;
;        (macrocall '(L (println "L=" L))
;                   '((+ 1 2) (- (* 4 5))))
;
; (macrocall '((X (Y Z)) (println "X=" X "; Y=" Y "; Z=" Z))
;            '((+ 1 2) (- (* 4 5))))
;
;
;                Implementation of macrocall
;                ===========================
;
; How can we do that? We know that let can be defined using
; lambda. On similar way, lambda can be defined using let.
; And on very similar way, lambda-macro can be defined using let.
;
; As our macrocall is like lambda-macro with different syntax,
; it should generate and then evaluate following expression:

              (let ((X '(+ 1 2))
                    (Y '(- (* 4 5))))
                   (println "X=" X "; Y=" Y))

; I had a luck. Newlisp has function "unify" that simplify my
; job here.
;
; For example,
;
;    (unify '(X Y) '((+ 1 2) (- (* 4 5))))
;
; results in
;
;    ((X (+ 1 2)) (Y (- * 4 5)))
;
; It is already similar to (let ((X '(+ 1 2))) ... )
;
; Implementation of macrocall function is routineous, so it doesn
; deserve comment or even thinking about.

(set 'quote-second (lambda(x)
                        (list (first x)
                              (apply quote (rest x)))))

(set 'equivalent-let-block
     (lambda (definition arguments)
             (list 'let
                    (map quote-second
                         (unify (first definition)
                                        arguments))
                    (last definition))))

(set 'macrocall
     (lambda (definition arguments)
             (eval (equivalent-let-block definition arguments))))

; OK, now we can test macrocall to see if it works.

(macrocall '((X Y)(println "X=" X "; Y=" Y))
           '((+ 1 2) (- (* 4 5))))

(macrocall '(L (println "L=" L))
           '((+ 1 2) (- (* 4 5))))

(macrocall '((X (Y Z)) (println "X=" X "; Y=" Y "; Z=" Z))
           '((+ 1 2) (- (* 4 5))))

; X=(+ 1 2); Y=(- (* 4 5))
; L=((+ 1 2) (- (* 4 5)))
; X=(+ 1 2); Y=-; Z=(* 4 5)
;
; It works
;
;                 From macros to functions
;                 ========================
;
; And, what about function calls? Functioncall as analogous to
; macrocall can be easily defined. But, I'll do something else -
; redefine macrocall so if I want some argument to be evalluated in
; caller environment, I'll denote respective parameter with X#
; instead of X, Y# instead Y etc.
;
;      (macrocall '((X# Y#)(println "X=" X "; Y=" Y))
;                 '((+ 1 2) (- (* 4 5))))
;
; Is it complicated? Not at all - I just need to adjust the function
; quote-second so equivalent-let-block produces

(let ((X (+ 1 2))
      (Y (- (* 4 5))))
     (println "X=" X "; Y=" Y))

; I.e. without quotes that prevetn evaluation of (+ 1 2)

(set 'quote-second (lambda(x)
                       (if (ends-with (string (first x)) "#")
                            (list (sym (chop (string (first x))))
                                  (last x))
                            (list (first x)
                                  (apply quote (rest x))))))

(macrocall '((X# Y#)(println "X=" X "; Y=" Y))
           '((+ 1 2) (- (* 4 5))))

; X=3; Y=-20    - It works
;
; I should add that it is not complicated to write macros that
; behave like functions in standard Newlisp. Just parameters
; have to be evaluated somewhere in the body, so macrocall still
; has some syntactical advantage.
;
;
;              Between macros and functions.
;              =============================
;
; Also, it is possible to produce "crossbreeds", macros/fuctions
; that force evaluating some - but not all - arguments of the macro
; calls before assigning it to the parameter.

(macrocall '((X (Y Z#)) (println "X=" X "; Y=" Y "; Z=" Z))
           '((+ 1 2) (- (* 4 5))))

; X=(+ 1 2); Y=-; Z=20   - It works

;                      Conclusion
;                      ==========
;
;
; Macrocall is developed with so little substantial code that
; its advantages are surprising.
;
; (1) no need for special syntax for macro-definitions. If
;     "macrocall" is defined, one does not need to write lambda
;     or lambda-macro ever again. Unfortunately, he has to write
;     "macrocall" all the time. It can be shortened on one
;     character - but for complete elimination, one should
;     make the change in the interpreter.
;
; (2) arguments are assigned to parameters on general and
;     natural, unification inspired way.
;
; (3) functions and "crossbreeds" between functions and macros
;     can be defined as well using "macrocall." X#, Y# etc syntax
;     for function-like parameters is somehow arbitrary. I can
;     think about better syntax, but I decided to leave that for
;     further articles.


------------------------
Don't Fear Dynamic Scope
------------------------
http://kazimirmajorinc.blogspot.com/2008/11/dont-fear-dynamic-scope.html

;
;
;                         INTRODUCTION.
;
;
; Dilemma between dynamic and static scope is old and frequent
; subject of discussion in the Lisp community, and many Lisp
; dialects tried different approach.
;
; Dynamic scope, in my opinion, fits better in main Lisp design
; goals than static scope. The main reason I believe that with
; dynamic scope, symbols and expressions passed as arguments
; to the function retain their semantics, while in the case
; of the static scope, semantics is stripped away and called
; function can see only form of the s-expression.
;
;
;                          THE PROBLEM.
;
;
; Dynamic scope allows some interactions that static scope
; does not allow. Because of that, it is more difficult to
; understand behaviour of the functions and it is more probable
; that called functions will show behaviour not intended by
; programmer. Newlisp contexts provide lexical scope, allowing
; programmer to avoid this kind of the problems. In this post,
; we discuss what can be done if programmer doesn't want to
; give up from dynamic scope.
;
; For example, let us write the function sum that, for given function
; f and integer n evaluates
;
;                        f(1)+...+f(n)

(set 'sum (lambda(f n)(set 'result 0)
                           (for (i 1 n)
                                (inc result (f i)))
                           result))

(println "-----\nTest of sum for f(x)=x:")

(set 'f (lambda(x)x))
(println (sum f 100))

; Result 1+2+ ... +100=5050 - exactly as young Gauss said!
;
; Next, I'll try to write code that evaluates
;
;           1 + 2 + 3 + ... + 10
;
;            2   2   2          2
;           1 + 2 + 3 + ... + 10
;
;                   ...
;
;            5   5   5          5
;           1 + 2 + 3 + ... + 10
;
; I just want to see these numbers:

(println "-----\nTest (for (j 1 5) ...):")

(for (j 1 5)
     (set 'f (lambda(x)(pow x j)))
     (println j ": " (sum f 10)))

; 1: 55
; 2: 385
; 3: 3025
; 4: 25333
; 5: 220825
;
; Beautiful, isn't it? But, what would happen if I used variable i,
; and not j in my loop?

(println "-----\nTest (for (i 1 5) ...):")

(for (i 1 5)
     (set 'f (lambda(x)(pow x i)))
     (println i ": " (sum f 10)))

; 1: 1.040507132e+010
; 2: 1.040507132e+010
; 3: 1.040507132e+010
; 4: 1.040507132e+010
; 5: 1.040507132e+010
;
; What a mess! Why the result is not the same - numbers from 55 to
; 220825? The problem is, the function sum in its definition also
; uses variable i, and that i - and i from loop (for i 1 5) interacted
; on the unintended way. That code evaluates just like

(println "-----\nTest of nested loops:")

(for (i 1 5)
     (set 'f (lambda(x)(pow x i)))
     (set 'result 0)
     (print i ": ")
     (for (i 1 10)
          (inc result (f i)))
     (println result))

; 1: 1.040507132e+010
; 2: 1.040507132e+010
; 3: 1.040507132e+010
; 4: 1.040507132e+010
; 5: 1.040507132e+010
;
; The function f is defined in outer loop - but, because f contains
; expression (pow x i), it is also redefined in inner loop. An error
; in our original, dynamic scope example is exactly the same, but
; it is harder to detect, because code is distributed on few, possibly
; many functions, and programmer is maybe (or even probably) unaware
; of the internal, local variables in those functions.
;
; If you write libraries, you do not expect that people who use
; your libraries know local variables you used, right?
;
; So, the problem can be serious.
;
;
;                 THE SOLUTION - THE WEAK ONE.
;
;
; Very simple - and surprisingly efficient - technique is to accept
; naming convention for variables. For example, sum can be defined on
; following way:

(set 'sum (lambda(sum.f sum.n)
                 (set 'sum.result 0)
                 (for (sum.i 1 sum.n)
                      (inc sum.result (sum.f sum.i)))
                 sum.result))

; Knowing that convention, one has only to avoid variable names
; like sum.i, sum.n, sum.f and similar - and it is easy. I guess
; you never used such names - and you especially wouldn't use
; such names if you are warned.
;
; Prefix "sum" is somehow annoying while developing the function
; but it can be added later, after function is already developed
; and tested.
;
;
;                   THE PROBLEM PERSISTS.
;
;
; However, the problem doesn't disappear completely -  even if
; programmer does not use variables named like sum.f intentionally,
; he can knowingly or unknowingly use same function on few recursive
; way. Look at this expression:

(println "-----\nTest of complex expression (1):")

(println (sum (lambda(n)(sum pow n)) 2))

; The function sum called itself. Am I sure that I understand
; what happens inside and is it what I intended? Impossible to
; say, unless I know what exactly I intended. But I can say it -
; I intended to keep evaluation of "inner sum" and "outer sum"
; separate, i.e. neither one variable used in evaluation of these
; two should be shared. That is what people usually want.

; By other words, this is what I intended to write, just in more
; abstract and more general way:

(println (sum (lambda(n)(cond ((= n 1) (pow 1))
                              ((= n 2) (+ (pow 1) (pow 2))))) 2))

; So, did I succeeded? Unfortunately, I didn't - result of the
; first expression is 10 and result of the second expression is
; 6. Somewhere on the way, Newlisp confused some variables of
; inner sum and outer sum.
;
; Note it is not fair description - I'm the one who caused the
; problem, not Newlisp - I didn't understood how recursive
; call in the dynamic scope works.
;
; Nevertheless - the problem stays, just, the question is - what
; should I (and not Newlisp) do to prevent the confusion.
;
;
;                  THE SOLUTION - THE STRONGER ONE.
;
;
; So, how can I avoid accidental overshadowing and keep advantage
; of dynamic scope? It would be ideal if for EACH CALL of the
; function different variables are used. For example, in third call
; of the function sum instead of "unsafe" version

(lambda(f n)                                     ;
       (set 'result 0)                           ;
       (for (i 1 n)                              ; UNSAFE SUM
            (inc result (f i)))                  ;
       result)                                   ;

; following, "safe" version is called:

(lambda(sum.f.3 sum.n.3)                         ;
     (set 'sum.result.3 0)                       ;
     (for (sum.i.3 1 sum.n.3)                    ; SAFE SUM
          (inc sum.result.3 (sum.f.3 sum.i.3)))  ;
     sum.result.3)                               ;

; if I can organize that, then there is no chance that two
; recursive calls can "confuse" same variables. Each call will
; use its own, independent variables.
;
; But, how to organize it? Let's go gradually.

; "Safe" version of the function sum is result of evaluation of

    (let ((f       'sum.f.3)                   ;
          (n       'sum.n.3)                   ;  SAFE SUM
          (i       'sum.i.3)                   ;  GENERATING
          (result  'sum.result.3))             ;  EXPRESSION
          (expand
                   ; original function

                   (lambda(f n)
                      (set 'result 0)
                      (for (i 1 n)
                           (inc result (f i)))
                      result)

                   'f 'n 'i 'result))

; Try it, and you'll see it works. And that expression is,
; in turn result of application of following function:

(set 'safet                                      ; FUNCTION
     (lambda(safe-name unsafe-function vars k)   ; GENERATING
            (list 'let                           ; SAFE VERSION
                     (map (lambda(v)             ; GENERATING
                             (list v             ; EXPRESSION
                                  (list 'quote
                                        (sym (append (string safe-name)
                                                     "."
                                                     (string v)
                                                     "."
                                                     (string k))))))
                           vars)
                     (append (list 'expand)
                             (list unsafe-function)
                             (map (lambda(v)(list 'quote v)) vars)))))

; So, (eval (safet 'sum unsafe-sum '(f n i result) 3)) should
; produce safe version of function sum.

(println "-----\nTest of safet:")

(set 'unsafe-sum (lambda(f n)
                     (set 'result 0)
                     (for (i 1 n)
                          (inc result (f i)))
                          result))

(println (eval (safet 'sum unsafe-sum '(f n i result) 3)))

; The next step is - to define the function that behave like unsafe-sum
; but in fact, it accept the arguments, produces 1st, 2nd, 3rd etc
; version of unsafe-sum, evaluate it and return result. For something
; like that, we'll need to add one global counter, let's denote it
; sum.counter.

(set 'sum.counter 0)
(set 'sum (lambda-macro()
              (inc sum.counter)

              ;-------------------------------------------
              ;        This part only for test.

              (println "---\nNow I'll evaluate:")
              (println (cons (eval (safet 'sum
                                          unsafe-sum
                                          '(f n i result)
                                          sum.counter))
                             (args)))

              ;        Delete it if you want for real.
              ;--------------------------------------------

              (eval (cons (eval (safet 'sum
                                        unsafe-sum
                                        '(f n i result)
                                        sum.counter))
                          (args)))))

; OK, let's test it:

(println "---------\nTest of safe sum:")

(println (sum (lambda(x)x) 1))
(println (sum (lambda(x)x) 10))
(println (sum (lambda(x)x) 100))

; These are results: if you are still with me, you can see, it
; works.
;
; ------------------
; Now I'll evaluate:
; ((lambda (sum.f.1 sum.n.1) (set 'sum.result.1 0)
;   (for (sum.i.1 1 sum.n.1)
;    (inc sum.result.1 (sum.f.1 sum.i.1))) sum.result.1)
;  (lambda (x) x) 1)
; 1
; ------------------
; Now I'll evaluate:
; ((lambda (sum.f.2 sum.n.2) (set 'sum.result.2 0)
;   (for (sum.i.2 1 sum.n.2)
;    (inc sum.result.2 (sum.f.2 sum.i.2))) sum.result.2)
;  (lambda (x) x) 10)
; 55
; ------------------
; Now I'll evaluate:
; ((lambda (sum.f.3 sum.n.3) (set 'sum.result.3 0)
;   (for (sum.i.3 1 sum.n.3)
;    (inc sum.result.3 (sum.f.3 sum.i.3))) sum.result.3)
;  (lambda (x) x) 100)
; 5050
;

; There is only one step left. I want to automatize production
; of safe functions on demand, i.e. to write unsafe-sum, then
; evaluate following function call:
;
;       (protect 'sum 'unsafe-sum '(f n i result))
;
; and that result is equivalent to evaluation of the previous
; two expressions:
;
; (set 'sum.counter 0)
; (set 'sum ...
;

(set 'protect
     (lambda(safe-name unsafe-name vars)
        (let ((counter-name (sym (append (string safe-name)
                                         ".counter"))))
             (set counter-name 0)

             (eval  (expand
                      '(set 'safe-name
                            (lambda-macro()
                               (inc counter-name)

                               ;---------------------------
                               ; This part only for test

                               (println "---\nNow I'll evaluate:")
                               (println (cons (eval (safet 'safe-name
                                                         unsafe-name
                                                         'vars
                                                         counter-name))
                                               (args)))

                               ; Delete it if you want for real
                               ;---------------------------

                               (eval (cons (eval (safet 'safe-name
                                                         unsafe-name
                                                         'vars
                                                         counter-name))
                                           (args)))))
                       'safe-name
                       'unsafe-name
                       'vars
                       'counter-name)))))
;
; Let us see whether it works:
;

(println "--------\nTest function protect")

(delete 'sum)
(protect 'sum 'unsafe-sum '(f n i result))

(println (sum (lambda(x)x) 1))
(println (sum (lambda(x)x) 10))
(println (sum (lambda(x)x) 100))

; It works.

; Another test:

(println "-----\nTest of complex expression (2):")

(println (sum (lambda(n)(sum pow n)) 2))

; The protected version gave result - 6. As it is expected.
;
;
; Two things can be noted.
;
; (1) In this example, I "protected" all of the variables used
; in the function unsafe-sum: by consistently changing  f, n, i and
; result. It is not necessary - some of these variables can be
; intentionally left with the same name in all function calls.
;
; (2) Even such, protected sum contains one variables that does
; not change its names from one call to another: sum.counter. Is
; it possible that the problem isn't solved? No, sum.counter
; is designed to allow communication between different recursive
; calls
;
; OK, enough for now.
;
(exit)

Commenti
--------
***Anonymous 25 November 2008 at 21:16
Great article!

Although I had trouble understanding what you were doing for a while. You're passing an anonymous function as an argument to another function, I think. ? I always define my functions to have 'let' or 'local', and I very rarely pass functions like you mathematicians whizzes do! :)

*** Kazimir Majorinc 26 November 2008 at 02:24
Thanks, yes, I'm using these anonymous functions here.

I start with "unsafe function", say f.

Then I construct safe version Sf, which is some kind of "wrap" around original f. Sf contains f inside, and transfer arguments to that f.

But - here is the point - not always to same f, but to its copy which differs only in names of the used variables. Each time Sf is called, new and different copy of f is generated and applied. So functionality is same but accidental overshadowing is impossible - even in the case of recursive functions.

Next step is automatization of such wrapping so f --> Sf doesn't have to be done manually.

(These "mutated copies" are those anonymous functions you've seen.)

You are right that let and local are usually more than enough of protection.

Anonymous26 November 2008 at 03:34
This looks more like an argument against dynamic programming to me.

*** Anonymous26 November 2008 at 03:34
*dynamic scope.

*** Kazimir Majorinc 26 November 2008 at 04:42
Why?

*** Anonymous26 November 2008 at 06:01
Because it puts complex code and libraries at jeopardy, as you mentioned in your post, and the solution to the problem is more of a hack then a real solution (no offense).

You're having to jump through hoops just to make functions safe to use in libraries, and your function isn't part of the newLISP standard library. Even if it was, its solution isn't very pretty, nor is it very efficient as it could potentially lead to the creation of many thousands of symbols. This would slow down the overall operation of the interpreter, just to do symbol lookups.

Of course, I may be mistaken, feel free to correct me if I am.

*** Kazimir Majorinc 26 November 2008 at 11:31
I'll try to address that in one of the next posts.

*** don Lucio 30 November 2008 at 18:56
The correct solution to safe variable encapsulation in newLISP is using contexts/namespaces. They can be passed as parameters to user-defined functions and are easier to understand.

Kazimir's functions are very interesting from a theoretical point of view, exploring how dynamic scoping works in newLISP.

I don't think he meant them to be used as a practical solution for passing around variable environments. That is what lexical namespaces in newLISP are for.


----------------------------
Don't Fear Dynamic Scope (2)
----------------------------
http://kazimirmajorinc.blogspot.com/2008/11/my-last-post-that-presented-two.html

; My last post presented two techniques for safe use of
; dynamic scope. The post was criticized for a few reasons
; and this post is attempt for answer. You can read it if previous
; post was sufficiently interesting to you.
;
; One of the two presented techniques was simple renaming of the
; variables on the way it is unlikely that one will use same
; variable names independently. That technique was, however,
; not enough if two instances of the same function communicate
; between themselves. These two instances necessarily share
; same variable names!

; More sophisticated and interesting technique consisted of
; "protecting" function with one macro wrapped around it.
;
; Let's say that SF is our protected version of the function F.
; When SF is called, it transfers all arguments to F. Not really
; original F, but slightly mutated one. For example, if original
; F used x, y and z then its mutated version uses
;
;      F.x.1, F.y.1, F.z.1 first time SF is called,
;      F.x.2, F.y.2, F.z.2 second time SF is called
;
; and so forth.
;
; On that way, advantages of dynamic scope are kept, while
; there is no danger of unintentional overshadowing of the original
; semantics.
;
; That post attracted criticism, from both technical and lets say,
; philosophical point of view, and some criticals were justified.
;
; From technical point of view, reader noted that my protected
; functions leak - symbols. And really, they do. One thing
; I didn't seen was that Newlisp interpreter keep names
; of variables used in anonymous functions in symbol list.
; For example, look at the following communication copied from :
; Newlisp REPL

;             newLISP v.9.9.93 on Win32 IPv4...
;
;             > (lambda(x))
;             (lambda (x))
;             > (find "x" (map string (symbols)))
;             355
;             > (find "y" (map string (symbols)))
;             nil
;             >

; As you can see, x is not deleted automatically. It has to
; be deleted explicitly. So, I had to take care about deleting
; extra variables. Solution, however, didn't required any
; additional technique, just addition of few "delete" expressions.

; Two useful versions of append. These functions append strings
; and symbols, without need for explicit conversion.

(set 'symappend (lambda()(sym (apply append (map string (args))))))
(set 'stringappend (lambda()(string (apply symappend (args)))))

; Manually defined protected version of "sum":

(set 'sum
     (lambda-macro()
        (inc sum.counter)
        (let ((c (string sum.counter)))
             (first
               (list
                 (eval
                   (let ((f      (symappend "sum" "." "f" "." c))
                         (n      (symappend "sum" "." "n" "." c))
                         (i      (symappend "sum" "." "i" "." c))
                         (result (symappend "sum" "." "result" "." c)))
                        (cons (expand

                                  ; ORIGINAL SUM GOES HERE

                                  (lambda(f n)

                                      (set 'result 0)
                                      (for (i 1 n)
                                           (inc result (f i)))
                                      result)

                                   ; THE LIST OF PROTECTED VARS

                                   'f 'n 'i 'result )

                              (args))))
                 (begin (delete (symappend "sum" "." "f" "." c))
                        (delete (symappend "sum" "." "n" "." c))
                        (delete (symappend "sum" "." "i" "." c))
                        (delete (symappend "sum" "." "result" "." c))))))))

; The function protect that takes few arguments, most importantly
; unprotected function; variables that should be protected and
; finally, name of the new function.

(set 'protect
     (lambda(safename unsafename vars)
        (letex ((c1 (symappend safename ".counter"))
                (c2 (map (lambda(x)(list x
                                        (list 'symappend
                                              (string safename)
                                              "."
                                              (string x)
                                              "."
                                              'c)))
                         vars))
                (c3 (append (list 'expand (eval unsafename))
                            (map quote vars)))
                (c4 (append '(begin)
                            (map (lambda(x)(list 'delete
                                                 (list 'symappend
                                                       (string safename)
                                                       "."
                                                       (string x)
                                                       "."
                                                       'c)))
                                 vars))))
               (lambda-macro()
                 (inc c1)
                 (let  ((c (string c1)))
                       (first (list (eval
                                      (let c2
                                           (cons c3 (args))))
                                    c4)))))))

; "Protect" is short, but very complicated function. It is function
; of the third order, i.e. it returns macros that generate functions.
; It is hard to understand what it does by looking at source.
; But it was not really hard to write "protect" because it is
; "linear:" there is no loops or recursions whatsoever and
; it can be easily tested. It can be applied on unsafe
; version of "sum" and result can be compared with manually
; defined safe version.

; Now I'll define function unprotected-sum, and generate
; protected-sum using function protect.

(set 'unprotected-sum (lambda(f n)
                       (set 'result 0)
                       (for (i 1 n)
                            (inc result (f i)))
                            result))

(set 'protected-sum (protect 'protected-sum
                        'unprotected-sum '(f n i result)))

;===============================================================
; The following code tests correctness and symbol leaking of protected
; function and compares speed of the protected and unprotected sum.

(println "\nCorectness and symbol leaking test.")
(println "\nNumber of symbols before test: " (length (symbols)))

(println "Should be 5050: " (protected-sum (lambda(x)x) 100))
(println "Should be    6: " (protected-sum (lambda(n)
                                               (protected-sum pow n))
                                               2))

(for (i 1 1000)(protected-sum (lambda(x)x) i))
(for (i 1 1000)(protected-sum (lambda(n)(protected-sum pow n)) 2))

(println "Number of symbols after test:  " (length (symbols)))

(println "\nSpeed comparison.")
(println "\nUnprotected sum time: "
         (time (for (i 1 10000)(unprotected-sum (lambda(x)x) i)))
         " ms")

(println "Protected sum time:   "
         (time (for (i 1 10000)(protected-sum (lambda(x)x) i)))
         " ms" )

(exit)

;                              THE RESULTS
;
; Corectness and symbol leaking test.
;
; Number of symbols before test: 382
; Should be 5050: 5050
; Should be    6: 6
; Number of symbols after test:  382
;
; Speed comparison.
;
; Unprotected sum time: 20833 ms
; Protected sum time:   24533 ms
;
;---------------------------------------------------------------
;
; Other, more essential and less technical part of the criticism
; is also interesting. Here is whole critical.
;
;            (Dynamic scope is bad) because it
;            puts complex code and libraries
;            at jeopardy, as you mentioned in
;            your post, and the solution to
;            the problem is more of a hack then
;            a real solution (no offense).
;
;            You're having to jump through hoops
;            just to make functions safe
;            to use in libraries, and your
;            function isn't part of the newLISP
;            standard library. Even if it was,
;            its solution isn't very pretty,
;            nor is it very efficient as it
;            could potentially lead to the creation
;            of many thousands of symbols.
;            This would slow down the overall
;            operation of the interpreter,
;            just to do symbol lookups.
;
;            Of course, I may be mistaken,
;            feel free to correct me if I am.
;
;
; The solution, as presented here, doesn't leak variables. Slow
; down caused by substition of new variables linearly depends on
; length of original function. More exactly, it is
;
;          constant * length(F) * log (number of vars)
;
; From theoretical point of view, it can be considered satisfactory.
;
; Is there a problem that functions like "protect" are not part
; of Newlisp, its core or standard library? In principle, nothing
; prevents introduction of function similar to protect to standard
; libraries or maybe even core language - fact is, however, there
; is little if any demand for that.
;
; Using static scope, called function cannot access to the environment
; of the caller, so there is no such problems at all. It is safer,
; but less expressive choice. The need for dynamic scope is recognized
; in another one Common Lisp and Scheme construct - macros.

Commenti
--------
*** don Lucio 14 December 2008 at 19:30
Although it is very interesting to explore the nature of dynamic scoping in newLISP, we must not forget the following points:

(1) Many of the disadvantages associated with dynamic scoping can be avoided by avoiding free variables. If globals must be used, they should be distinguishable by some sort of naming convention.

(2) newLISP has a context namespace mechanism to totally shield against the disadvantages of dynamic scoping. The namespace overhead memory -and speed- wise is minimal. This way we can reap the benefits of both, dynamic and lexical scoping without the disadvantages of either.

I find Kazimir's experiments enlightening and appreciate all of his posts very much. But I am also afraid that they feed the prejudice of less informed readers, who are unable to look at newLISP from any other than a Common LIsp or Scheme perspective.

*** Unknown 4 September 2013 at 18:51
But, if you don't use free variables, you cannot say that you get the "benefits" of dynamic scope, because you aren't using dynamic scope at all. If you don't use free variables, you don't use dynamic scope, with independence from the "implementation" of your language.


-------------------------------
Swap Without Temporary Variable
-------------------------------
http://kazimirmajorinc.blogspot.com/2008/12/swap-without-temporary-variable.html

; Short one, inspired by blog post posted by Cormullion on Newlisp forum:
; Swap values of two variables without using temporary variable.

(set 'a 1 'b 2)

(println a "," b); 1, 2

(set 'a (+ a b))
(set 'b (- a b))
(set 'a (- a b))

(println a "," b); 2, 1

(exit)

Commenti
--------
*** Anonymous 23 February 2009 at 16:28
(set 'a 1 'b 2)

(println a "," b); 1, 2

(map set '(a b) (list b a))

(println a "," b); 2, 1

Reply

*** Kazimir Majorinc 13 March 2009 at 00:13
Good idea!


-----------------------------
Short or Long Function Names?
-----------------------------
http://kazimirmajorinc.blogspot.com/2009/01/short-or-long-function-names.html

I am frequently in doubt should I use short or long variable names. In some circumstances, long names look better - for example, when I start using some function, it is easier to remember long name. And it is especially easier to explain programs to other people if functions have long, descriptive names.

On the other side, after some use, long names are counterproductive - code is longer, and it takes more time to write it.

Recently, I came to idea to define functions with two names, long and short one. I think it is not accidental that we usually have two names - original, long name - and then shorter name, nickname, acronym or abbreviation. Look at this:

Philosophy Doctor --> Ph.D.
United States of America --> USA
Robert --> Bob
In my humble opinion --> IMHO

It cannot be accidental, right? So, now, I'm in experimental period of defining double names. For example, I have Lispy name string-append and Perly $+, identity-function (lambda(x)x) and IF, identity-macro (lambda-macro(x)x) and IM.

So far, so good. I'll report experiences in future. Try it, maybe you'll like it also.


-------------------------------
Avoiding Function Names Clashes
-------------------------------
http://kazimirmajorinc.blogspot.com/2009/01/avoiding-function-name-clashes.html

My "default-library" has grown to define 464 new symbols, mostly functions. Most of these are generated, so they are not interesting. Nevertheless, there is significant probability that I'll try to use same name twice - especially if I use abbreviations.

That's why I defined version of "set" named set-undefined - if symbol already has value, set-undefined throws an error.

(set 'set-undefined
     (lambda-macro(var-expr val-expr)
            (let ((evar-expr (eval var-expr)))
                 (when (eval evar-expr)
                       (throw-error (append (char 8)
                                            (char 8)
                                            (char 8)
                                            ": "
                                             "(SU " (string var-expr)
                                             " " (string val-expr)
                                             ") where "
                                             (string var-expr)
                                             " => "
                                             (string evar-expr)
                                             " => "
                                             (string (eval evar-expr)))))
                 (set 'toeval (list 'set
                                    (list 'quote evar-expr)
                                    val-expr))
                 (eval toeval)
                 nil)))

(set-undefined 'SU set-undefined)
SU is especially useful.

Ops. I didn't syntax-colored this post. OK, we can live with that.


------------------------------
Two Definitions of IF Function
------------------------------
http://kazimirmajorinc.blogspot.com/2009/01/two-definitions-of-if-function.html

;---------------------------------------------------------------
; Last few days I played with definition of IF as function.
; It is typically not possible in Lisp family, but Newlisp
; can do that. I present here two definitions of IF that are
; specific not only because of that, but also because the
; definitions do not use any equivalent built in (like if, cond,
; case) and also, definitions do not use any variables.
;---------------------------------------------------------------

(set 'IF (lambda()
           (eval
             ((args)
               (- 5 (length
                       (string
                          (true?
                             (eval (first (args)))))))))))
(let ((x 2)(y 3))
     (IF '(< x y)
         '(println  x " is less than " y)
         '(println  x " is not less than " y))

     (IF '(> x y)
         '(println x " is greater than " y)
         '(println x " is not greater than " y)))

;---------------------------------------------------------------

(set 'IF (lambda()
           (eval
             ((args)
               (find (true? (eval (first (args))))
                     '(* true nil))))))

(let ((x 2)(y 3))
     (IF '(< x y)
         '(println  x " is less than " y)
         '(println  x " is not less than " y))

     (IF '(> x y)
         '(println x " is greater than " y)
         '(println x " is not greater than " y)))

(exit)


----------------------------
Challenged by Common Lispers
----------------------------
http://kazimirmajorinc.blogspot.com/2009/01/challenged-by-common-lispers.html

; Trying to answer some criticals on Newlisp in Usenet newsgroup
; comp.lang.lisp I was challenged to "show some code" and demonstrate
; my claims that Newlisp macros have some advantages over CL macros on
; examples.
;
; I defined macro at-least, generalized version of the operator or.
; Macro call (at-least expr1 ... exprn) should return true if
; expr2 ... exprn evaluate to true - at least expr1 times. As a special
; case, (at-least 0 ...) should always return true. This is example
; of how code that tests at-least could look alike.

;; Both Newlisp and Common Lisp
(let ((x 1) (y 2) (z 3) (n 3))
   (print (at-least n
                 (at-least (- n 1) (= x 7) (= y 2) (= z 3))
                 (at-least (- n n) nil nil nil nil)
                 (at-least (* 1 z) 1 (= 2 2) (let ((z 100))
                                                  (= z 1000))))))

; The result of this test is nil, and if 1000 is replaced with 100, true.
; My Newlisp definition was:

;;Newlisp
(define-macro (at-least atn)
      (let ((aten (eval atn)))
           (doargs(ati (zero? aten))
                  (when (eval ati)
                        (dec aten)))
           (zero? aten)))

; The best definition Common Lispers managed to do appears to be
; Raffael Cavallaro's definition:

;;Common Lisp
(defmacro at-least (n &rest es &aux (nsym (gensym)) (carsym (gensym)))
 (if (null es) nil
   `(let ((,nsym ,n))
      (if (zerop ,nsym) t
        (let ((,carsym ,(car es)))
          (if (= ,nsym 1) (or ,carsym ,@`,(cdr es))
            (at-least (if ,carsym (1- ,nsym) ,nsym) ,@`,(cdr es))))))))

; How that CL definition compares with my Newlisp definition?
;
; The first and most important, CL macro is not the first-class
; object, so Cavallaro cannot, for example, map or apply his at-least,
; pass it as an argument, return from the function (or other macro) etc.
; This cannot be improved in Common Lisp, macros are not
; the first class citizens.
;
; Other, less important problem with Cavallaro's definition is that
; it requires quadratic macroexpansion time. It can be reduced to
; linear, and in some, special situations it can be the problem.
;
; To be fair, CL definition is safer, i.e. it is harder to accidentally
; shoot oneself in the foot. For programs small enough, it is not
; the problem. But, it might become the problem if program grows
; significantly. However, this problem can be routinely fixed in
; Newlisp - by use of the Newlisp lexical scope features named
; contexts or applying techniques I described on this blog. The contexts
; are general mechanism designed to prevent accidental name clashes
; not reserved for macros, but also functions, variables - all symbols.
; It this case, applying naming convention once code is written
; and tested solves the problem completely. For example,

;;Newlisp
(define-macro (at-least at-least_n)
      (let ((at-least_en (eval at-least_n)))
           (doargs(at-least_i (zero? at-least_en))
                  (when (eval at-least_i)
                        (dec at-least_en)))
           (zero? at-least_en)))

; is equally "safe" code as CL macro. Newlispers, however, typically
; use contexts for that purpose.
;
; One of the problems with Common Lisp macros is their complexity.
; Cavallaro is obviously good programmer. His macro has 57 tokens
; vs my 18 tokens - so it is 3.5 times longer. Relatively advanced
; features, like gensym  and list splicing (,@) are used. I can
; safely say, according to my experience, that not many people are
; able - or motivated - to write such code.

; Rainer Joswig wrote shorter macro that should be slightly
; changed to return (at-least 0 ...) to be always true. To be fair,
; he wrote it before I specifically mentioned that (at-least 0 ...)
; should always be true (although it is logical, isn't it?)

; Common Lisp
(defmacro at-least (n &rest es &aux (c (gensym)))
  `(let ((,c 0))
      (or ,@(loop for e in es collect `(and ,e (= (incf ,c) ,n))))))

; Still, my Newlisp macro has some advantages:
;
;   *   Joswig's CL macro has 31 token, Newlisp macro has 18 tokens.
;
;   *   Joswig's CL macro has 11 nesting levels, Newlisp macro has 5.
;
;   *   Joswig's CL macro uses some advanced features like backquote and
;       macro LOOP with irregular syntax. Newlisp macro is just one
;       loop - there is nothing remotedly advanced here.
;
;   *   Finally, Joswig's macro is not the first class citizen
;       while Newlisp macro is.
;
; However, is there any reason one might prefer CL over Newlisp macros?
;
; Yes, there is. If use of at-least is simple, i.e. at-least is
; mentioned only in expressions like in my test, but never anything
; like (map at-least ...), (apply at-least ...), (eval (at-least ...))
; - CL macro allows compilation and compiled code can run significantly
; faster. This is the main reason Common Lispers avoid eval. Newlisp
; code presented here, even if, theoretically, compiled (Newlisp
; actually has no compiler) wouldn't run that fast. However, if code
; contains the expressions like those mentioned above then Newlisp
; version is either only possible, or it allows significantly faster
; evaluation, because macroexpansion can be avoided - In Common Lisp,
; macroexpansion during runtime is very slow.
;
; As conclusion, I'll cite Alexander Burger, the author of Pico Lisp
; who wrote in 2004:
;

"The Lisp community seems to suffer from a paranoia of “unefficient”
Lisp. This is probably due to the fact that for decades they had
to defend their language against claims like “Lisp is slow” and
“Lisp is bloated”. Partly, this used to be true. But on today’s
hardware raw execution speed doesn’t matter for many practical
applications. "

Commenti
--------
Larry Clapp 30 January 2009 at 16:50
Please respond to killerstorm's comment (https://www.reddit.com/r/lisp/comments/7tkdo/challenged_by_common_lispers/c07d8he/), to wit, that your macro isn't apply-able either. Perhaps he did it wrong?

*** killersorm 30 January 2009 at 16:53
can you map or apply your at-least so it will retain its short-circuiting feature in Newlisp?

if it doesn't retain short-circuiting, you can get same behaviour in Common Lisp by automatically translating macro into a closure:

(defmacro macrofn (mname)
`(lambda (&rest rest)
(eval `(,',mname ,@rest))))

then you can use it in apply:

CL-USER> (apply (macrofn or) '(nil 1 2 3 nil 4))
1

and map:

CL-USER> (mapcar (macrofn or) '(1 nil 3) '(nil 2 nil))
(1 2 3)

but i doubt anyone needs this, as macros that should be called as functions should be functions.

*** Kazimir Majorinc 30 January 2009 at 20:04
It retains short circuiting, but if you call normal apply, then macro
will see list of elements - all of them containing one extra quote.

In my opinion it is logical, since in Lisp, only difference between macros and functions is that macro call does not evaluate its arguments. Apply is the same in both cases, hence, macros get one apostrophe extra on each argument.

If you want that it works as you expect, you need bit of work (but really bit only) to define different apply, one that will strip extra quotes:

(define (apply-macro m L)(eval (cons m L)))

Now that's it:

(println (apply-macro at-least '(2 (print "a") (print "b") (print "c"))))

=>abtrue

If you want apply-general, that works like default apply on functions, and apply-macro on macros, you can define it easily.

(define (applyg x L)
(cond ((or (primitive? x) (lambda? x))(apply x L))
((macro? x)(apply-macro x L))
(true (println "don't ** with me!"))))

(println (applyg sin '(1)))
(println (applyg at-least '(2 (print "a") (print "b") (print "c"))))
(exit)

*** killersorm 30 January 2009 at 22:29
but do you actually use this apply-macro in your programs? i betcha you do not, and all this first-classness is totally worthless.

by the way, it is possible to write apply-macro in Common Lisp too and it will work not worse (if you use only special variables), so Newlisp is not unique in this, and macros in CL can be as first-class as in Newlisp from practical standpoint, if one really needs it.

*** Kazimir Majorinc 31 January 2009 at 02:10
I never applied macro yet, but I use to pass it as variable.

*** Nguyen Vu Ngoc Tung13 July 2009 at 21:21
For me, macro in CL is a hell. It has so much of exceptions and rules which it is difficult to apply and remember.

*** grant rettke 30 December 2011 at 17:33
Make me wonder how much "easier" it might be just to write it with lazy evaluation and a normal function.


------------------------------
Test for Unnecessary Arguments
------------------------------
http://kazimirmajorinc.blogspot.com/2009/02/test-for-unnecessary-arguments.html

;
; Recently someone said that it would be nice if Newlisp macro
; or function can check whether someone tried to supply more
; arguments than it is necessary. For example, if you accidentally
; call (sin x y), then sin complains that it got too many arguments.
;
; Such functions can be easily defined. But, it is also interesting
; that addition of the test can be automatized, because Newlisp
; function is equal to its definition.
;
; In this code, I defined macro forbid-args that inserts the code
; that throws an error in the body of supplied function.

(set 'forbid-args
      (lambda-macro(f)
         (push (letex ((message (append "Too many arguments in "
                                        (string f))))
                      '(when (> (length $args) 0)
                                  (throw-error message)))
                (eval f)
                1)))

(set 'my-macro (lambda-macro(x y)
                  (println "I got " x " and " y "." )))

(println my-macro)

    ;
    ; (lambda-macro (x y) (println "I got " x " and " y "."))
    ;

(my-macro 6 7 8)

    ; I got 6 and 7.

(forbid-args my-macro)

(println my-macro)

    ; (lambda-macro (x y)
    ;    (when (> (length $args) 0)
    ;          (throw-error "Too many arguments in my-macro"))
    ;          (println "I got " x " and " y "."))

(my-macro 6 7 8)

    ; ERR: user error : Too many arguments in my-macro


----------------
Calculate or Ask
----------------
http://kazimirmajorinc.blogspot.com/2009/02/calculate-or-ask.html

; I compared some monitors, and tried to calculate some data
; about size of pixels, area etc, using windows calculator, and
; it turned to be surprisingly slow and boring.
;
; Then I tried to write program in Newlisp, but then it turned
; that program itself had lot of redundancies, lot of sets,
; readlines etc.
;
; I decided to write macro that might help me if I'll ever
; need to write such a trivial programs. Almost certainly I'll do.
;
; The macro is called with list of arguments.
; If argument is list of one element, its value is readed.
; If argument is list of two elements, the value of the second is.
; assigned to the first.

; Nothing really important, but it can be handy.

(set 'calculate-or-ask
     (lambda-macro()
        (dolist (i $args)
           (print (first i)
               (dup " " (- 20 (length (string (first i)))))
               " = ")
           (set (first i) (if (> (length i) 1)
                              (println (eval (nth 1 i)))
                              (float (read-line)))))))

(calculate-or-ask
     (Diagonal)
     (Width)
     (Height)
     (Price)
     (Pixels               (* Height Width))
     (Area                 (/ (* Diagonal Diagonal Width Height)
                              (+ (* Width Width)
                                 (* Height Height))))
     (Pixels/Unit-of-area  (/ Pixels Area))
     (Pixels/Unit-of-price (/ Pixels Price)))

(exit)


-------------------------
Apply Has Its Secrets Too
-------------------------
http://kazimirmajorinc.blogspot.com/2009/02/apply-has-its-secrets-too.html

; What (apply f L) really does? If you only want to know what it
; does, and not how I concluded that, jump to the end of the post.

; But, is there any doubt what apply really does? It applies
; functions or macros on list. Here it is:

(println (apply + (list 1 2 3 4 5)))

; Result will be 15. What else? Well, there is the reason. One of
; the characteristics of Lisp is that some values evaluate to
; themselves - because of that we can sometimes write simpler
; expressions. On the other side, because of that, we do not have
; to face with errors, so we can successefully use some concepts,
; without really understanding it. At least, it holds to me. So,
; I have to write some tests to understand what really happens,
; ie. if + and 1, 2 ... are evaluated - and if they are, how
; many times!. I'll start with following.

(println (apply '+ (list 1 2 3 4 5)))

15

; Ha - it works. Quoted + doesn't harm! That means that not actually
; '+ is applied, but evaluated '+. If I defined some function f

(set 'f (lambda()(- (last $args) (first $args))))

; I can use apply in both of these forms:

(println (apply 'f (list 1 2 3 4 5)))
(println (apply f (list 1 2 3 4 5)))

; Both of these work and give same result - 4. Interesting, isn't
; it? Now, I'll try to quote those 's in the list:

(println (apply '+ (list '1 '2 '3 '4 '5)))

; It works. So, one might think that evaluated '+ is applied on
; evaluated elements of the list. But it is premature conclusion
; since list as operation itself will remove those quotes. So, we
; can test this one:

(println (apply '+ (list ''1 ''2 ''3 ''4 ''5)))

; Result is - ERR: value expected in function + : ''1

; OK; it would be too much. But look at that error: it appears
; that + got ''1 as argument! Not just '+, but ''+ - like one quote
; is not stripped during evaluation of (list ''1 ''2 ''3 ''4 ''5).
; It cannot be! We'll make another test to confirm our suspects!
; I'll replace ' with quote to catch interpreter "in act."

(println (apply '+ (list (quote (quote 1)) (quote (quote 2)))))

; ERR: value expected in function + : '(quote 1)

; Here you are! That extra ' is added by interpreter.
; Now we have all we need!

; let's say that
;
;           exprL is expression that evaluate to list,
;                 that if printed looks like
;                 (value1 value2 ... valuen)
;
;           exprf is expression that evaluates to anything
;
; Then,
;

        (apply exprf exprL)

; is equivalent to

        ((eval exprf) 'value1 'value2 ... 'valuen))

; For example

        (apply * (list 1 2 3 4 5))

; is really equivalent to

        ((eval *) '1 '2 '3 '4 '5)

; You didn't seen that eval and those quotes, did you? Maybe you
; did, but I did not.


---------------
Random Sublists
---------------
http://kazimirmajorinc.blogspot.com/2009/02/random-sublists.html

; This is old trick but some might be interested. The problem is:
; define function that returns random, n element sublist of a given
; list.

; There are many ways it can be done in Newlisp, and here is one
; that requires O(length(L)) time, no matter of n. That is pretty
; good, and if lists are implemented as linked lists, better order
; of value is not possible.
;
; Algorithm pass through whole list once and inspect all elements,
; from first to last. Lets say L=(2 6 7 9 4) and we want to find
; random three element sublist.

; First we'll consider 2 as a candidate for our sublist. The
; probability that it will be included in list should be 3/5=0.6.

; We chose random number between 0 and 1 and if it is less than
; 0.6, number 2 will be inserted in sublist. Then we proceed to
; chose two elements from (6 7 9 4).
;
; If random number between 0 and 1 is greater than 0.8, we do
; not include it in sublist, and then we proceed to chose three
; elements from (6 7 9 4).

(set 'random-sublist
    (lambda(L pick-from-list)

      (let ((result '())
            (left-in-list (length L)))

           (when (> pick-from-list left-in-list)
            (throw-error (append "There is no n=" (string pick-from-list)
                                 " elements in L.")))

           (dolist (element L (= pick-from-list 0))
                   (let ((probability (div pick-from-list
                                           left-in-list)))

                         (when (<= (random 0 1) probability)
                               (push element result -1)
                               (dec pick-from-list))
                         (dec left-in-list)))

            result)))

(seed (date-value))
(for (j 0 5)
  (for (i 1 15)
     (print (random-sublist '(1 2 3 4 5) j)))
     (println))

; Here is what happens if one tries to chose larger sublist than
; list:

(random-sublist '(2 3 4 5 6) 8)

; Result:

()()()()()()()()()()()()()()()
(1)(3)(4)(2)(3)(5)(2)(4)(3)(3)(5)(3)(4)(3)(2)
(1 3)(1 2)(2 3)(3 4)(2 5)(3 4)(4 5)(4 5)(1 2)(3 5)(1 2)(1 2)(1 2)(2 3)(4 5)
(3 4 5)(1 3 4)(1 2 4)(1 3 5)(2 3 5)(2 3 4)(2 4 5)(2 3 4)(1 3 4)(1 2 3)(1 3 4)(1 2 4)(1 3 5)(3 4 5)(1 2 3)
(2 3 4 5)(1 3 4 5)(1 2 3 4)(1 2 4 5)(1 2 3 4)(1 2 4 5)(1 2 3 5)(1 3 4 5)(1 2 4 5)(1 2 3 5)(2 3 4 5)(1 2 3 5)(1 2 3 4)(1 2 3 4)(1 2 4 5)
(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)(1 2 3 4 5)

ERR: user error : There is no n=8 elements in L.
called from user defined function random-sublist


--------------------------
Trees, Branches and Leaves
--------------------------
http://kazimirmajorinc.blogspot.com/2009/02/trees-branches-and-leaves.html

; We can easily imagine s-expression as a tree, for example
; '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))
;
;                            +-+
;                            |+|
;                           _+-+_
;                        _,'  |  `._
;                     _.'     |     `._
;                  _.'        |        `._
;                .'           |           `.
;              +-+           +-+           +-+
;              |-|           |+|           |-|
;              +-+           +-+           +-+
;             /   \         /   \         /   \
;            /     \       /     \       /     \
;           /       \     /       \     /       \
;         +-+      +-+  +-+       +-+ +-+       +-+
;         |1|      |2|  |3|       |4| |5|       |+|
;         +-+      +-+  +-+       +-+ +-+       +-+
;                                              /   \
;                                             /     \
;                                            /       \
;                                          +-+       +-+
;                                          |6|       |7|
;                                          +-+       +-+
;
; When we see it as tree, we can easily recognize branches and
; leaves of that tree - they are subexpressions of the original
; s-expression. In this case, our intuition is good enough so
; I can avoid mathematical definitions, and instead write two
; functions that return list of all branches and leafs of a given
; s-expression. By definition, original s-expression and all
; leaves are also branches.

(set 'branches
     (lambda(L)
       (if (list? L)
           (cons L (apply append (map branches (rest L))))
           (list L))))

(set 'leafs
     (lambda(L)
       (if (list? L)
           (apply append (map leafs (rest L)))
           (list L))))

(println (branches '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))))
(println (leafs '(+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))))

; ((+ (- 1 2) (+ 3 4) (- 5 (+ 6 7)))
; (- 1 2) 1 2 (+ 3 4) 3 4 (- 5 (+ 6 7)) 5 (+ 6 7) 6 7)
; (1 2 3 4 5 6 7)

; Note that expression '(+ 1 2) is leaf, while (quote (+ 1 2))
; isn't.
; Graph is drawn with excellent ASCII editor Jave, www.jave.de
;

(exit)


----------------------
The Most Probable Cond
----------------------
http://kazimirmajorinc.blogspot.com/2009/02/most-probable-cond.html

; The expression cond branches evaluation of the program on
; the condition which is first evaluated to be true. Theoretically
; there might be some interest in branching program on the
; condition which is *most probably true*.
;
; What does it mean? I want syntax of the following kind
;
;
; (let ((x1 0.4) (x2 0.6))
;      ((y1 0.2) (y2 0.3))
;      ((z1 0.1) (z6 0.7))
;
;      (most-probable-cond
;              (div 1 x1 y1 zy x2 y2 z2)
;              ((< (random 0 1) x1) (println "First!"))
;              ((< (random 0 1) x2) (println "Second!"))
;              ((< (random 0 1) x3) (println "Third!"))))
;
; Semantics is: each of the clauses, in this case (< (random 0 1) x1)
; and similar, will be evaluated exactly (div 1 x1 y1 zy x2 y2 z2)
; times - where that number is evaluated only once.
; After that, program will branch on clause which evaluated to
; be true more times than others. If some clauses happened to be
; true equal number of times, then any of branches will be chosen.

; Here is Newlisp macro. It is long, because I used descriptive
; variable names and lot of prints to see how macro works. Otherwise,
; it is not really long and complicated.

(set 'most-probable-cond
    (lambda-macro(formula-for-a-number-of-evals)
       (let ((number-of-evals (eval formula-for-a-number-of-evals))
             (maximal-clause-index -1)
             (maximal-clause-successes -1))

            (println "Number of evals: " number-of-evals)
            (doargs(clause)
                (let ((counter-of-successes 0))

                     (dotimes (this-eval number-of-evals)
                          (when (eval (first clause))
                                (inc counter-of-successes)))

                     (println "Clause: " $idx
                              ". " ($args $idx)
                              ": " counter-of-successes
                              " times.")

                     (when (> counter-of-successes
                              maximal-clause-successes)
                           (set 'maximal-clause-index $idx)
                           (set 'maximal-clause-successes
                                 counter-of-successes))))

            (println "Max: " maximal-clause-index
                     ". " ($args maximal-clause-index)
                     ": " maximal-clause-successes " times.")

            (eval (last ($args maximal-clause-index))))))

; Test

(seed (date-value))

(let ((x1 0.4) (x2 0.6)
      (y1 0.2) (y2 0.3)
      (z1 0.1) (z2 0.7))

     (most-probable-cond
             (div 1 x1 x2 y1 y2 z1 z2)
             ((< (random 0 1) x1) (println "First!"))
             ((< (random 0 1) y1) (println "Second!"))
             ((< (random 0 1) z1) (println "Third!"))))

; Number of evals: 992.0634921
; Clause: 0. ((< (random 0 1) x1) (println "First!")): 398 times.
; Clause: 1. ((< (random 0 1) y1) (println "Second!")): 199 times.
; Clause: 2. ((< (random 0 1) z1) (println "Third!")): 106 times.
; Max: 0. ((< (random 0 1) x1) (println "First!")): 398 times.
; First!

; Expressions like (maximal-clause-index -1) suggest that on this
; place some of "functional programming" features can be inserted.
; Really, they can - resulting in the shorter, but usually harded
; to understand definitions.

(define-macro (most-probable-cond f-n-evals)
 (let ((n-evals (eval f-n-evals)))
   (eval
     (last ((args)
            (let ((temp (map (lambda(clause counter)
                               (dotimes (dotimes-iterator n-evals)
                                        (when (eval (first clause))
                                        (inc counter)))
                                counter)
                              (args))))
                 (find (apply max temp) temp)))))))

(let ((x1 0.4) (x2 0.1)
      (y1 0.55) (y2 0.3)
      (z1 0.5) (z2 0.7))

     (most-probable-cond
             (div 1 x1 x2 y1 y2 z1 z2)
             ((< (random 0 1) x1) (println "First!"))
             ((< (random 0 1) y1) (println "Second!"))
             ((< (random 0 1) z1) (println "Third!"))))

(exit)


--------------------------------------------------
More on Usenet and Google Groups Posting Frequency
--------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/02/more-on-usenet-posting-frequency.html

; Inspired by Xah Lee's analysis of frequency of Usenet newsgroups
; I decided to do same in Newlisp, and to add automatic processing
; and output in the form of modern, graphical user interface.

; Data about frequency of posting is collected from Google's interface
; to Usenet. For example, this is the page on address

; http://groups.google.com/group/comp.lang.pascal/about

; That page contains data on the posting frequency on Usenet
; group comp.lang.pascal. Here is the critical part of the
; source of the same page:

  (println "The program shows frequency of Usenet posts.")
  (println "Kazimir Majorinc, Institute for Programming, 2009.")
  (println "Free for non-commercial use.")

  (until (begin (print "\n\n\nNewsgroup [enter for exit]: ")
                (set 'group (replace " " (read-line) ""))
                (empty? group))

    ;; Following read-file retrieves the content of the page in
    ;; txt form.

    (let ((f (read-file (format "http://groups.google.com/group/%s/about"
                                group)))
          (data (list))
          (max-posts/year 0))   ; / is just part of the name

      (for (year 1980 (first (now)))
        (let (posts/year)
           (for (month 1 12)

             ;; extracting information about number of posts in
             ;; given year and month:

             (when (find (format "%04d-%02d\">(.*)<" year month) f 0)
                (inc posts/year (int (replace "&nbsp;" (copy $1) "")))))

           (when posts/year
             (push (list year posts/year) data -1)
             (set 'max-posts/year (max posts/year max-posts/year)))))

       ;; Display - if it doesn't look good with your font,
       ;; replace \219 with something else, for example #

       (unless (zero? max-posts/year)
          (println "\n ^ posts/year (max = " max-posts/year ")\n |")
          (for (i 20 1 -1)
            (println " |"
               (apply append
                      (map (lambda(x)
                              (if (> (x 1)
                                     (* i (/ max-posts/year 20)))
                                  "\219\219 "
                                  "   "))
                            data))))
          (print " +" (dup "--+" (length data) ) "-->\n ")
          (dolist (j data)
             (print " " (slice (string (j 0)) 2))))))

  (exit)

;; You need installed Newlisp v10 to run this program.

;; The result will be as on the following picture:

;; Also, program will work for all "Google Groups," not only Usenet Groups.

Commenti
--------
*** Sam 21 August 2011 at 14:45
I get this error:

Newsgroup [enter for exit]: comp.lang.ruby

ERR: symbol is protected in function replace : $1

Using newLISP v.10.3.2 on OSX IPv4/6 UTF-8.

*** Kazimir Majorinc 21 November 2011 at 10:09
OK, I just updated it - Newlisp changed, not Google. Now it should work again.

*** Kazimir Majorinc 21 November 2011 at 13:07
Yes, I replaced $1 with (copy $1) and it works again. Obviously Lutz made $1, ... immutable in the meantime.

*** Kazimir Majorinc 21 November 2011 at 13:17
I also updated it, replacing hard coded 2009 with (first (now)); now it works to current date.


---------------
Where is Letex!
---------------
http://kazimirmajorinc.blogspot.com/2009/02/where-is-letex.html

; It is easy to oversight letex as just another of less important
; relative of let. But letex is really different. It is perfect
; if we want to use macros as functions - the topic I discussed
; several times but not nearly exhausted. For example, "for" is
; the primitive that behaves as macro:

  (for (i 1 50) (print "*"))

  (println)

; (i 1 50) and (print i) are not evaluated before "for" is called.
; If they are, (i 1 50) would cause error. But, what if I want
; (for L (print i)) where L is random choice of three different
; lists, (i 1 10), (i 1 10 2), (i 10 1 -1)?
;
; The first guess,
;
; (set 'L (amb '(i 1 10) '(i 1 10 2) '(i 10 1 -1)))
; (for L (print i))
;
; results in ERR: list expected in function for : L.
;
; Standard way of doing that would be

  (set 'L (amb '(i 1 10) '(i 1 10 2) '(i 10 1 -1)))
  (eval (append '(for) (list L) '((print i))))

  (println)

; I constructed list (for (i 1 50) (print "*")) and evaluated it.
; Semantically, everything is OK, but syntactically, this expression
; is cumbersome. That's where letex come on stage:

  (letex ((L (amb '(i 1 10) '(i 1 10 2) '(i 10 1 -1))))
         (for L (print i)))

  (println)

; Much simpler. However, sometimes, I find that using letex is not
; that smooth and that I, more frequently than not, write my letex
; expressions starting from the back side, like I did in this example.

; Why? Because in mathematics, and ordinary language, word "where"
; is typically used for that task. And one writes the result first,
; with some variables with meaning he'll explain later.

; Really, even in formulation of this problem, I used that word:
; "where L is random choice." Because of that, I'll define macro
; "where." Actually, I'll define wherex and where, "for completeness",
; although I ; expect that I'll always need wherex. It is simple
; addition, but it can be useful.

(set 'where
   (lambda-macro()
      (eval (append '(let)
              (cons (last (args))
                (reverse (rest (reverse (args)))))))))

(set 'wherex
   (lambda-macro()
      (eval (append '(letex)
              (cons (last (args))
                (reverse (rest (reverse (args)))))))))

; Test:

(wherex (for condition body)
       ((condition (amb '(i 1 10) '(i 1 10 2) '(i 10 1 -1)))
        (body '(println i "-"))))

; It works.

(exit)


--------------
Multiple Loops
--------------
http://kazimirmajorinc.blogspot.com/2009/02/multiple-loops.html

; Sometimes programmer needs deeply nested loops over the same
; list of values. For example,

 (dolist (i '(0 1))
   (dolist (j '(0 1))
     (dolist (k '(0 1))
        (dolist (l '(0 1))
          (println i j k l)))))

; For such, relatively rare, but still realistic situations, it
; might be useful to have "multi" version of the loop, and write
; something like:
;
;
; (dolist-multi ((i j k l) '(0 1))
;                  (println i j k l))
;
;
; Such a multi loop can be used even if all variables are known only
; during runtime, using letex (or wherex defined in the previous posts.)
;
;
; (letex ((L (random-sublist '(i j k l m n o p q r s t u v))))
;   (dolist-multi (L '(0 1))
;       (println= ... )))
;
;
; I'll use recursive definition:
;
; 1° Base
; --------
;
; (dolist-multi (() ___)                   (begin
;      expr1                                   expr1
;      ...                  <===>              ...      if n # 1
;      exprn)                                  exprn)
;
;                                              expr1    in n = 1
;
; 2° Step
; --------
;
; (dolist-multi((v1 ... vn) ...)   (dolist (v1 ...)
;   expr1;                            (dolist-multi ((v2 ... vn) ...)
;   ...;             <===>               expr1
;   exprn);                              ...
;                                        exprn))
;
; First one simple, but frequently needed function that transforms
; list of expressions into single expression by inserting "begin"
; in the list - but only if it is needed. If list has only one
; expression, then this expression is returned.

(set 'list-to-single-expression
     (lambda(L)
       (if (= (length L) 1)
           (first L)
           (cons 'begin L))))

(set 'dolist-multi
     (lambda-macro(L)
       (let ((variables (first L)))

         (if (empty? variables)
             (eval (list-to-single-expression (args)))

             (letex ((head1 (cons (first variables) (rest L)))
                     (head2 (cons (rest variables) (rest L)))
                     (body (list-to-single-expression (args))))

                     (dolist head1
                             (dolist-multi head2
                                           body)))))))

; Tests:

(dolist-multi(() (list 0 1))
   (println 5))

(dolist-multi((i) (list 0 1))
   (println "i = " i))

(dolist-multi((i j k) (list 0 1))
   (println "i =" i ", j = " j ", k = " k))

; Appears to work.

; However, now, when I'm here - many newlisp loops, not only dolist
; have the syntax
;
;          (<loop name> (<control variable> ...) <body>)
;
; For all of these, multi as defined here has a sense. So, it appears
; that defining multi-version of many loops is "low hanging fruit."
; It is also excelent example of the power of the Newlisp metaprogramming.
;
; I'll define the function multiloop that
;
;       *  accepts the name of the loop as argument,
;       *  generates new, multiloop macro, and
;       *  gives the appropriate name to it.

(set 'multiloop
   (lambda(loop)
     (let ((new-loop (sym (append (string loop) "-multi"))))

        (set new-loop
           (expand
             (lambda-macro(L)
                (let ((variables (first L)))

                  (if (empty? variables)
                      (eval (list-to-single-expression (args)))

                      (letex ((head1 (cons (first variables) (rest L)))
                              (head2 (cons (rest variables) (rest L)))
                              (body  (list-to-single-expression (args))))

                              (loop head1
                                    (new-loop head2
                                                  body))))))
                    'loop
                    'new-loop)))))

; Next, I'll apply multiloop on all Newlisp loops of the form
; (<loop name> (<control variable> ... ) <body>)

  (map multiloop '(doargs dolist dostring dotimes dotree for))

; TEST

; Simple expression that contains two nested multiloops.

(for-multi ((i j) 0 8 4)
   (dotimes-multi ((i j) 5) (print "*"))
   (println " i= " i ", j=" j))

; RESULT:

; ************************* i= 0, j=0
; ************************* i= 0, j=4
; ************************* i= 0, j=8
; ************************* i= 4, j=0
; ************************* i= 4, j=4
; ************************* i= 4, j=8
; ************************* i= 8, j=0
; ************************* i= 8, j=4
; ************************* i= 8, j=8

(exit)


-----------------------
Add and Multiply Digits
-----------------------
http://kazimirmajorinc.blogspot.com/2009/02/add-and-multiply-digits.html

; Discussing some possible extension of Newlisp's add and mul functions
; suggested by Jeremy Dunn, I wrote these few simple functions.
; Just in case that someone is interested.

(set 'println= (lambda-macro(x)(println x " = " (eval x))))

(set 'factorial
     (lambda(n)
       (let((result 1))
         (when (> n 0)
              (for(i 1 n 1)
               (set 'result (* result i))))
          result)))

; one might expect that "sequence" work better than loop here,
; but sequence definition is really different, so it requires some
; changes that at the end, make definition more similar to loop.

(println= (factorial 6))
(println= (factorial 0))

(set 'double-factorial
     (lambda(n)
       (let((result 1))
        (when (> n 0)
         (for(i n 1 -2)
            (set 'result (* result i))))
         result)))

(println= (double-factorial 5))
(println= (double-factorial 6))
(println= (double-factorial 0))

(set 'add-digits
     (lambda(n)
        (apply + (map int (explode (string n))))))

(println= (add-digits 12345))

(set 'multiply-digits
      (lambda(n)
        (apply * (map int (explode (string n))))))

(println= (multiply-digits 12345))

(set 'recursively-add-digits
     (lambda(n)
        (if (< n 10)
            n
            (recursively-add-digits
               (add-digits n)))))

(println= (recursively-add-digits 12345))

(set 'recursively-multiply-digits
     (lambda(n)
       (if (< n 10)
           n
           (recursively-multiply-digits
                (multiply-digits n)))))

(println= (recursively-multiply-digits 12345))

; (factorial 6) = 720
; (factorial 0) = 1
; (double-factorial 5) = 15
; (double-factorial 6) = 48
; (double-factorial 0) = 1
; (add-digits 12345) = 15
; (multiply-digits 12345) = 120
; (recursively-add-digits 12345) = 6
; (recursively-multiply-digits 12345) = 0
;


----------------------------------
The First Use of Identity Function
----------------------------------
http://kazimirmajorinc.blogspot.com/2009/03/first-use-of-identity-function.html

; I defined identity function long time ago in my library, "just
; in case." It, however, turned longer than I expected before I
; actually used it on natural way. Here is example, where I define
; my own combination of slice and sequence - where identity function
; is needed to compenstate for a difference between lists and
; strings. For example,
;
;
;        > (set 'L "ABC")
;        "ABC"
;
;        > (append (nth 0 L) (nth 1 L) (nth 2 L))
;        "ABC"
;
; But
;
;        > (set 'L '(1 2 3))
;        (1 2 3)
;
;        > (append (nth 0 L) (nth 1 L) (nth 2 L))
;
;        ERR: array, list or string expected : 1
;
;
; I have to "insert" one "list" if I want to use append:
;
; > (append (list (nth 0 L)) (list (nth 1 L)) (list (nth 2 L)))
; (1 2 3)
;
;
; I used it in my own definition of slice-sequence combination.
; I wanted this:
;
;    (slice-sequence "abcdefgh" 0 7 2) => "aceg"
;    (slice-sequence '(1 2 3 4 5 6 7 8) 0 7 2) => (1 3 5 7)
;
;
;

(set 'identity-function (lambda(x)x))

(set 'slice-sequence
     (lambda(X)
        (apply append
              (map (lambda(i)((if (string? X)
                                  identity-function ; <==== HERE
                                  list)
                              (nth i X)))
                   (eval (cons 'sequence (args)))))))

; Yes, it is possible without identity-function, but it is, I think
; the most natural solution.

; My identity macro is still waiting.


-----------
Text Titles
-----------
http://kazimirmajorinc.blogspot.com/2009/03/text-titles.html

; If program outputs lot of plain text, then it is useful to break
; the text in smaller parts clearly divided with underlined or
; boxed titles, like
;
;                       Main title
;                       ==========
; or
;
;                    +----------------+
;                    | Another title. |
;                    +----------------+
;
; Yesterday, I was bored by manual writing of such titles and
; decided to write some support for it. It turned there are many
; special cases, and code is longer than I expected.

(set 'number-of-columns 64)
(set 'max-title-width 24)

(set 'nth-cyclic
     (lambda(i l)(nth (mod i (length l)) l)))

(set 'find-last
     (lambda(d l)
       (let ((result (find (reverse d) (reverse l))))
            (if result (- (length l) result (length d))))))

(set 'break-title
  (lambda(title-string)
    (let ((title-string (trim title-string))
          (lts (length title-string)))
      (if (<= lts max-title-width)
          (list (trim title-string))
          (let ((s (or (find-last " " (slice title-string 0 max-title-width))
                       max-title-width)))
              (cons (trim (slice title-string 0 s))
                     (break-title (slice title-string
                                         s
                                         (- lts s)))))))))

(set 'clean-string
     (lambda(x)
        (dolist(i (list (list "  " " ")
                         (list (char 13) "")
                         (list (char 10) "")))
           (while (find (i 0) x)
               (replace (i 0) x (i 1))))
        x))

(set 'underline
 (lambda(title-text underline-string)
  (let ((cc 0))
    (dolist(i (break-title (clean-string title-text)))
      (let ((indent (dup " " (round (div (sub number-of-columns
                                              (length i)
                                              +0.1)
                                          2)))))
          (print indent i "\n" indent)
          (dotimes(j (length i))
             (inc cc)
             (print (nth-cyclic cc underline-string)))
          (println)))
     (println))))

(set 'box
     (lambda(title-text box-string)
       (println)
       (letn ((cc 0)
              (L (map trim (break-title (clean-string title-text))))
              (maxlength (apply max (map length L)))
              (indent (dup " " (/ (- number-of-columns maxlength 4)
                                   2))))
           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (dolist(i L)
               (print indent (nth-cyclic cc box-string))
               (print (dup " " (+ 1 (round (div (sub maxlength (length i) +0.1) 2)))))
               (inc cc)
               (print i)
               (print (dup " " (+ 1 (round (div (sub maxlength (length i) -0.1) 2)))))
               (println (nth-cyclic cc box-string))
               (inc cc))

           (print indent)
           (for(i 1 (+ maxlength 4))
              (print (nth-cyclic cc box-string))
              (inc cc))
           (println)

           (println))))

(set 'box-standard
     (lambda(title-text box-string)
       (println)
       (letn ((cc 0)
              (L (break-title (clean-string title-text)))
              (maxlength (apply max (map length L)))
              (indent (dup " " (/ (- number-of-columns maxlength 4)
                                   2))))
           (print indent)
           (println "+" (dup "-" (+ maxlength 2)) "+")

           (dolist(i L)
               (print indent "|")
               (print (dup " " (+ 1 (round (div (sub maxlength (length i) +0.1) 2)))))
               (print i)
               (print (dup " " (+ 1 (round (div (sub maxlength (length i) -0.1) 2)))))
               (println "|"))

           (print indent)
           (println "+" (dup "-" (+ maxlength 2)) "+")

           (println))))

(underline "newLISP focuses on the core components of Lisp: lists,
      symbols, and lambda expressions. To these, newLISP adds
      arrays, implicit indexing on lists and arrays, and dynamic
      and lexical scoping. Lexical scoping is implemented using
      separate namespaces called contexts." "-*")

(box-standard "newLISP focuses on the core components of Lisp: lists,
      symbols, and lambda expressions. To these, newLISP adds
      arrays, implicit indexing on lists and arrays, and dynamic
      and lexical scoping. Lexical scoping is implemented using
      separate namespaces called contexts.")

(box "newLISP focuses on the core components of Lisp: lists,
      symbols, and lambda expressions. To these, newLISP adds
      arrays, implicit indexing on lists and arrays, and dynamic
      and lexical scoping. Lexical scoping is implemented using
      separate namespaces called contexts." "/\\")

;                      newLISP focuses on the
;                      *-*-*-*-*-*-*-*-*-*-*-
;                        core components of
;                        *-*-*-*-*-*-*-*-*-
;                      Lisp: lists,  symbols,
;                      *-*-*-*-*-*-*-*-*-*-*-
;                     and lambda expressions.
;                     *-*-*-*-*-*-*-*-*-*-*-*
;                      To these, newLISP adds
;                      -*-*-*-*-*-*-*-*-*-*-*
;                         arrays, implicit
;                         -*-*-*-*-*-*-*-*
;                      indexing on lists and
;                      -*-*-*-*-*-*-*-*-*-*-
;                       arrays, and dynamic
;                       *-*-*-*-*-*-*-*-*-*
;                       and lexical scoping.
;                       -*-*-*-*-*-*-*-*-*-*
;                        Lexical scoping is
;                        -*-*-*-*-*-*-*-*-*
;                        implemented using
;                        -*-*-*-*-*-*-*-*-
;                       separate namespaces
;                       *-*-*-*-*-*-*-*-*-*
;                         called contexts.
;                         -*-*-*-*-*-*-*-*
;
;
;                   +-------------------------+
;                   | newLISP focuses on the  |
;                   |   core components of    |
;                   | Lisp: lists,  symbols,  |
;                   | and lambda expressions. |
;                   | To these, newLISP adds  |
;                   |    arrays, implicit     |
;                   |  indexing on lists and  |
;                   |   arrays, and dynamic   |
;                   |  and lexical scoping.   |
;                   |   Lexical scoping is    |
;                   |    implemented using    |
;                   |   separate namespaces   |
;                   |    called contexts.     |
;                   +-------------------------+
;
;
;                   /\/\/\/\/\/\/\/\/\/\/\/\/\/
;                   \ newLISP focuses on the  /
;                   \   core components of    /
;                   \ Lisp: lists,  symbols,  /
;                   \ and lambda expressions. /
;                   \ To these, newLISP adds  /
;                   \    arrays, implicit     /
;                   \  indexing on lists and  /
;                   \   arrays, and dynamic   /
;                   \  and lexical scoping.   /
;                   \   Lexical scoping is    /
;                   \    implemented using    /
;                   \   separate namespaces   /
;                   \    called contexts.     /
;                   \/\/\/\/\/\/\/\/\/\/\/\/\/\
;

Example of actual use.

              +---------------------------------+
              | Axioms are loading into theory. |
              +---------------------------------+

Axiom 1. (-> B (-> A B)) loaded.
Axiom 2. (-> (-> A (-> B C)) (-> (-> A B) (-> A C))) loaded.
Axiom 3. (-> A (not (not A))) loaded.

                                Theory
                                ======

1. (-> B (-> A B))
2. (-> (-> A (-> B C)) (-> (-> A B) (-> AC)))
3. (-> A (not (not A)))

              +-----------------------------------+
              | Test that axioms are tautologies. |
              +-----------------------------------+

                     Axiom 1. (-> B (-> A B))
                     ------------------------

1. (B A)=(nil nil) => true
2. (B A)=(nil true) => true
3. (B A)=(true nil) => true
4  (B A)=(true true) => true

tautology=true; satisfiable=true;


-----------------------
Quote is Identity Fexpr
-----------------------
http://kazimirmajorinc.blogspot.com/2009/03/quote-is-identity-macro.html

(quote anything)
;-> anything

(map quote (sequence 1 10 1))
;-> (1 2 3 4 5 6 7 8 9 10)
Kazimir output: ('1 '2 '3 '4 '5 '6 '7 '8 '9 '10)

(set 'identity-macro (lambda-macro(x) x))
;-> (lambda-macro (x) x)

(identity-macro anything)
;-> anything

(map identity-macro (sequence 1 10 1))
;-> (1 2 3 4 5 6 7 8 9 10)
Kazimir output: ('1 '2 '3 '4 '5 '6 '7 '8 '9 '10)

It works that way in Newlisp only, because Newlisp macros are actually fexprs.

Nota:
(setq a '('1 '2))
;-> ('1 '2)


-----------------
Gensym and Genlet
-----------------
http://kazimirmajorinc.blogspot.com/2009/03/gensym-and-genlet.html

; Gensym is one of the important tools in the Lisp languages. It is
; function that returns variable. The point is - each time it is called
; it returns different variable. Gensym is typically used if one
; wants to avoid accidental name clashes while defining macros, but
; it is not its sole use.

; Newlisp has not gensym yet, but it is easy to make one. One example
; can be seen in Jeff Ober's article In defense of Newlisp, and it
; is also included in his Util library. His implementation supports
; contexts, and since I do not need contexts in this article, I'll
; define another gensym, slightly simpler, but not without some charm.

(set 'gensym-counter 0)

(set 'gensym
     (lambda(i)
       (inc gensym-counter)
       (sym (append (string i)
                    " ("
                    (string gensym-counter)
                    ". generated symbol)"))))

; Let us see how variables generated by our gensym look like:

(for(j 1 5)
  (println (gensym 'i)))

; Output:
;
;                     i (1. generated symbol)
;                     i (2. generated symbol)
;                     i (3. generated symbol)
;                     i (4. generated symbol)
;                     i (5. generated symbol)
;
;
; The blanks and parentheses - all that is the part of the generated
; symbol. I defined such symbol name intentionally, because it is
; impossible to accidentally use such name in programs; it must be
; generated during runtime. Also, these names are pretty descriptive,
; so they can be useful in debugging.
;
;
; I'll say that, for example, i (1. generated symbol) - is generated
; symbol that used symbol i as its base. It might have sense.
;
;
; Once generated, symbols are elements of the symbols-table until
; explicitly deleted. It is an implementation detail. Although not
; important for normal symbols, there might be millions of generated
; symbols, and it might be good to delete generated symbols immidietely
; when theye are not needed any more.

                    (for (j 1 3)
                         (set 'v (gensym 'j))
                         (println v)
                         (delete v))

; Topic I'd try to adress here is how to define "generated" versions
; of let and local, so programmer can write:
;
;    (genlet ((i 1)
;             (j 2))
;            (println 'i "= " i ", " 'j "= " j))

; While in fact, not ordinary symbols i and j are used inside
; of the genlet expression, but their gensymed versions. It is
; relatively easy to accomplish it by using powerful letex
; expression:

        (letex ((i (gensym 'i))
                (j (gensym 'j)))
                (let ((i 1)
                      (j 2))
                     (println 'i "= " i ", " 'j "= " j)))

; letex will literally replace i and j with "generated versions"
; in the inner let expression and then evaluate such, mutated inner
; expression.
;
; Output is:
;
; i (9. generated symbol)= 1, j (10. generated symbol)= 2
;
; As it can be seen, really, not i and j, but their "gensymed"
; versions are actually used. Each time this block is evaluated,
; different version is used.
;
;
; However, it becomes more complicated if I want to delete
; generated symbols. And I must do that, because if gensym is
; in some large loop, it could easily generate millions of symbols,
; and finally exhaust memory.

(letex ((i (gensym 'i))
        (j (gensym 'j)))
       (first (list (let ((i 1)
                          (j 2))
                         (begin
                            (println 'i "= " i ", " 'j "= " j)))

                    (begin (delete 'i)
                           (delete 'j)))))

; With this construction I ensure that inner let expression is
; evaluated, after that gensymed variables are deleted, and finally,
; the result of the inner let expression is returned as result.
;
;
; This is how macro that "expands" into expression above looks
; like. I'll use wherex, which is inverse letex I defined few
; posts earlier, so I'll load my library from Internet. The
; definition of genlet is technical and not very interesting,
; so you can skip it.

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set 'genlet
  (lambda-macro(head)
    (let ((body (args)))
         (wherex

                 (letex H1
                     (first (list (let H2
                                       H3)
                                  H4)))

         ; where

                 ((H1 (map (lambda(x)
                             (list (nth 0 x)
                                   (list 'gensym
                                         (list 'quote (nth 0 x)))))
                           head))

                  (H2 head)

                  (H3 (cons 'begin body))

                  (H4 (cons 'begin (map (lambda(x)
                                          (list 'delete
                                                (list 'quote
                                                       (nth 0 x))))
                                         head))))))))

; Does it work?

         (genlet ((i 1)
                  (j 2))
                 (println 'i "= " i ", " 'j "= " j))

; Output:
;
;      (13. generated symbol)= 1, j (14. generated symbol)= 2
;
; It works.
;
; And what happens if I do something like

              (genlet ((i 1))
                      (genlet ((i 2))
                          (println 'i "= " i))
                      (println 'i "= " i))

; Output:
;
; i (15. generated symbol) (16. generated symbol)= 2
; i (15. generated symbol)= 1
;
;
; What is
;
;    i (15. generated symbol) (16. generated symbol)?
;
; It is generated symbol, that uses for its basis generated symbol
; i (15. generated symbol), that uses i for its basis symbol i.
;
; Another test:

               (println= (genlet ((i 7))
                            (genlet ((j 8))
                               (* i j))))

; Output:

;      (genlet ((i 7)) (genlet ((j 8)) (* i j)))=56;
;
; Again, everything works.
;
; If you do have problems with understanding this code, don't
; let this discourage you. It is really complicated, and it is
; enough to remember that some genlet is defined here - and come
; back if you find you might need it.

; Next time - genlocal!

                          (exit)


--------
Genlocal
--------
http://kazimirmajorinc.blogspot.com/2009/03/in-previous-blogpost-i-defined-gensym.html

; In previous blogpost I defined gensym and genlet. If you didn't
; read it, read that post first.
;
; I'll repeat the definition of the gensym again, to remind my
; readers, and also, to allow evaluation of this post as a code.
; Also, I slightly improve name of my generated variables.

(set 'gensym-counter 0)

(set 'gensym
     (lambda(i)
       (inc gensym-counter)
       (sym (append "("
                    (string i)
                    " - "
                    (string gensym-counter)
                    ". generated symbol)"))))

; genlet defined in the last post had same purpose as let, except
; it actually defined not variables, but generated versions of
; variables.

; Newlisp is, unlike other Lisp dialects, characterized with
; large number of constructs that implicitly define local variables.
; Beside let, there is a mighty letex, and also whole plethora
; of loops. All of these can have their own generated versions.
;
; But, there is one primitive in Newlisp that serves only to ensure
; that variables used inside that expression will be local. That is
; - expression local.

(set 'i 40)

(local(i)
  (println i)) ; Output => nil

; Just like local serves as general expression that can be wrapped
; around any other expression or list of expression to ensure
; they use local variables, we can define genlocal, which ensures
; that listed variables will be both generated and local.

; For example, genlocal call

;   (genlocal(a b c)
;      (set 'a 1)
;      (set 'b 2)
;      (set 'c 3))
;

;  should be transformed into

(letex((a (gensym 'a))
       (b (gensym 'b))
       (c (gensym 'c)))

   (first (list (local(a b c)
                      (set 'a 1)
                      (set 'b 2)
                      (set 'c 3))

                (begin (delete 'a)
                       (delete 'b)
                       (delete 'c)))))

; It is very similar to definition of genlet from previous post,
; so I can almost cut and paste our previous macro:

(set 'genlocal
  (lambda-macro(head)
    (let ((body (args)))
         (letex
                 ; look body first, head later.

                 ; head

                        ((H1 (map (lambda(x)
                                     (list x
                                           (list 'gensym
                                                 (list 'quote x))))
                                   head))

                          (H2 (cons 'local (cons head body)))

                          (H3 (cons 'begin (map (lambda(x)
                                                  (list 'delete
                                                        (list 'quote
                                                               x)))
                                                 head))))
                 ; body:

                 (letex H1
                     (first (list H2

                                  H3)))))))

; I'll try that:

  (genlocal(a b c)
     (set 'a 1)
     (set 'b 2)
     (set 'c 3)
     (println 'a " = " a  "\n" 'b " = " b "\n" 'c " = " c))

; OUTPUT
;
; (a - 4. generated symbol) = 1
; (b - 5. generated symbol) = 2
; (c - 6. generated symbol) = 3
;

(exit)


--------
Genloops
--------
http://kazimirmajorinc.blogspot.com/2009/03/in-third-post-in-this-generated-serial.html

; In third post in this "generated" serial, I'll define "generated"
; versions of loops. By generated, I mean that you use them as
; normal loops, and they substitute normal symbols with generated
; symbols.
;
; The loops for, doargs, dolist, dostring, dotimes and dotree have
; same syntax:
;
;              (<loopname> (<symbol> ...) body)
;
;
; I'll try to define genfor, gendoargs, gendolist, gendostring and
; gendotimes so they are used on the following way:
;
;
;              (gen<loopname> (<symbol> ...) <body>)
;                 ^
;                 |
;                only "gen" is inserted, analogously to gensym.
;
;
; Such "generated loops" should be evaluated like
;
;
;              (genlocal(<symbol>)
;                      (<loopname>(<symbol> ...) <body>))
;
;
; Definitions of gensym and genlocal pasted from previous post:

        (set 'gensym-counter 0)

        (set 'gensym
             (lambda(i)
               (inc gensym-counter)
               (sym (append "("
                            (string i)
                            " - "
                            (string gensym-counter)
                            ". generated symbol)"))))

        (set 'genlocal
          (lambda-macro(head)
            (let ((body (args)))
                 (letex ((H1 (map (lambda(x)
                                     (list x
                                        (list 'gensym
                                              (list 'quote x))))
                                    head))
                          (H2 (cons 'local (cons head body)))
                          (H3 (cons 'begin
                                    (map (lambda(x)
                                           (list 'delete
                                                 (list 'quote
                                                        x)))
                                         head))))
                         (letex H1
                             (first (list H2
                                          H3)))))))

; Definition of "generated loops" genfor, gendoarg, gendolist,
; gendostring, gendotimes so they behave like described above.
; Again, code is complicated but technical, but idea is important.

(dolist (loopname '(for doargs dolist dostring dotimes))
  (set (sym (append "gen" (string loopname))) ; for -> genfor etc

       (letex ((loopname loopname))
         (lambda-macro(head)
           (let ((body (args)))
             (letex((H1 (list (first head)))
                    (H2 (append (list 'loopname head) body)))
                   (genlocal H1
                             H2)))))))

; Next, I'll memorize (symbols), to show that that all generated
; symobls will be actually, cleaned.

(set 'symbols-before-genloops (symbols))

; Tests that new genfors really work:

(genfor (i 10 20 5)
        (println 'i " = " i))

(println)

(gendolist (j '(a b c))
           (println 'j " = " j))

(println)

(gendotimes(k 4)(println 'k " = " k))

(println)

; OUTPUT

; (i - 1. generated symbol) = 10
; (i - 1. generated symbol) = 15
; (i - 1. generated symbol) = 20

; (j - 2. generated symbol) = a
; (j - 2. generated symbol) = b
; (j - 2. generated symbol) = c

; (k - 3. generated symbol) = 0
; (k - 3. generated symbol) = 1
; (k - 3. generated symbol) = 2
; (k - 3. generated symbol) = 3

; Test that gensyms are deleted:

(println (difference (symbols) symbols-before-genloops))

; OUTPUT
;
; (a b c j k)
;
; OK.

(exit)


--------------------
Supernatural Symbols
--------------------
http://kazimirmajorinc.blogspot.com/2009/03/supernatural-symbols.html

; Newlisp interpreter analyzes the expression and inserts symbols
; used in the expression into symbol-table *before* evaluation
; of the expression.
;
; Because of that, one can write the function that assigns the
; value to the symbols of the block before the symbols are
; actually defined, or even mentioned in the block.
;
; Don't look first at the function - it is technical. Take a look
; at main program block first and analyze the function only if
; that block is interesting to you.

(set 'self-conscious-symbols
  (lambda()
     (if (not symbols1)
         (set 'symbols1 (symbols)))
     (let ((symbols2
             (difference (symbols)
                 symbols1
                 '(i symbols1 symbols2 self-conscious-symbols))))
       (dolist(i symbols2)
            (set i (append "I am " (string i) ". I feel "
                       (string (apply amb
                                     (difference symbols2
                                           (list i))))
                       " is close."))))))

(self-conscious-symbols)
(seed (date-value))

(begin (self-conscious-symbols)
       (println Sri-Aurobindo)

       '(set 'i (list Maharishi
                      Sri-Chinmoy
                      Sai-Baba
                      Dalai-Lama)))

; OUTPUT
;
; I am Sri-Aurobindo. I feel Sri-Chinmoy is close.

Commenti
--------
*** Anonymous 5 April 2009 at 20:13
Interesting, but what is the point of this:

(let ((symbols2
(difference (symbols)
symbols1
'(i symbols1 symbols2 self-conscious-symbols))))

The code seems to run just fine if I use this:

(let ((symbols2 (difference (symbols) symbols1)))

*** Kazimir Majorinc 6 April 2009 at 04:20
You are right, it is remain from the time symbols1 was defined explicitly on the beginning of the program

(set 'symbol1 (symbols))

Then I decided to "pull" it inside function, to increase dramatic effect and didn't simplified that expression.

Congratulations, you understood the program better than I did.


------------------------------------------
On Macros, Eval and Generated Code in Lisp
------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/04/on-macro-expansion-evaluation-and.html

; Unlike Common Lisp or Scheme macros, Newlisp macros do not expand
; during compile time; instead, these are evaluated during runtime,
; similarly like functions.
;
; That kind of macros - under the name of fexprs - existed in older
; dialects of Lisp. Probably the most influential work on fexprs
; is Kent Pitman's "Special Forms in Lisp" presented at 1980s'
; Lisp Conference. Pitman described few reasons pro and contra
; fexprs and macros and advised omission of fexprs from the future
; Lisp dialects. Regarding runtime efficiency, Pitman argues that

;       "In the compiler, MACRO's are used to transform source code into
;       compilable code which contains no MACRO forms. Hence, a MACRO
;       definition can in some sense afford to use more time in its
;       transformation than any other type of operator can afford to
;       do in similar case analysis at runtime. This is because a macro
;       form will be expanded exactly once (at compile time) while any
;       other type of operator may be called repeatedly at runtime and
;       will have to make decisions anew each time it is called."
;

; However, it is not discussed what happens if the same code has
; to be evaluated only once or few times, especially if code is
; generated during runtime. In that case macroexpansion itself
; might require significant, theoretically unlimited time.
;
;
; I'll demonstrate it by comparing evaluation times of one Lisp
; expression in recent implementation of Newlisp and six versions
; of the CL: Allegro, Clozure, Corman, LispWorks, GNU CL and GNU
; Clisp. The code is
;

 (dotimes (i 177000)
        (eval '(at-least 6 t     ;;For Newlisp use true, not t
                           nil
                           nil
                           nil
                           nil
                           nil
                           t
                           nil
                           nil
                           nil
                           nil
                           nil
                           t
                           nil
                           nil
                           nil
                           nil
                           nil
                           t
                           nil
                           nil
                           nil
                           nil
                           nil)))

; Where at-least is macro, generalized version of the operator
; OR. For example (at-least 2 (= x 3) (> 7 2) (= 6 6)) is true
; if and only if, well, at least two of these expressions are true.

; The purpose of the loop (dotimes(i 177000) is only to allow me
; to measure the time of the evaluation of the expression inside.
; Otherwise, running time would be too short. Nothing else.
; So, no, main expression, compilation or macroexpansion
; cannot be factored out of loop.

; Strange number 177000 was my rough estimation of realistic evaluation.
; time. The form (eval '(....)) is used because I want to replicate
; the situation in which code is generated during runtime.
;
; I use only t and nil to minimize influence of other operations
; on test. But, the macros I'll use are defined for general case,
; discussed in the previous post Challenged by Common Lispers:
;

;;Newlisp - author Kazimir Majorinc
(define-macro (at-least at-least_n)
      (let ((at-least_en (eval at-least_n)))
           (doargs(at-least_i (zero? at-least_en))
                  (when (eval at-least_i)
                        (dec at-least_en)))
           (zero? at-least_en)))

;;Common Lisp - author Raffael Cavallaro
(defmacro at-least (n &rest es &aux (nsym (gensym)) (carsym (gensym)))
 (if (null es) nil
   `(let ((,nsym ,n))
      (if (zerop ,nsym) t
        (let ((,carsym ,(car es)))
          (if (= ,nsym 1) (or ,carsym ,@`,(cdr es))
            (at-least (if ,carsym (1- ,nsym) ,nsym) ,@`,(cdr es))))))))

;; Common Lisp - author Rainer Joswig [doesn't work for n=0]
(defmacro at-least (n &rest es &aux (c (gensym)))
  `(let ((,c 0))
      (or ,@(loop for e in es collect `(and ,e (= (incf ,c) ,n))))))

                      #################
                      #  THE RESULTS  #
                      #################

                     |  Majorinc  |  Cavallaro  |  Joswig
     =======================================================
     Newlisp 10.0.3  |    1.115   |       X     |     X
     -------------------------------------------------------
     Gnu Clisp 2.43  |     X      |     81.323  |   27.533
     -------------------------------------------------------
     Gnu CL 2.6.1    |     X      |     77.033  |   29.617
     -------------------------------------------------------
     ABCL 0.18       |     X      |    135.862  |   38.301
     -------------------------------------------------------
     Lispworks 5.1   |     X      |    156.018  |   48.374
     -------------------------------------------------------
     Allegro 8.1     |     X      |   1296.929  |  382.676
     -------------------------------------------------------
     Corman 3.01     |     X      |   8900.000  |  987.907
     -------------------------------------------------------
     Clozure 1.3     |     X      |  23000.000  | 1871.000
     -------------------------------------------------------
     SBCL 1.0.29     |     X      |  12800.000  | 3700.000
     -------------------------------------------------------

; all times are expressed in seconds. The numbers for Clozure and SBCL
; are estimations: loop was evaluated 17700 times and result was
; multiplied with ten.

; As you can see, in this particular case, using macros writen
; by me and two competent Common Lisp programmers, and few existing
; Common Lisp implementations working on Windows, Common Lisp is
; between 25 and 25 000 times slower. Hence, Common Lisp kind of
; macros slows down evaluation of the code generated during runtime
; considerably, while Newlisp style macros also known as fexprs do not
; have such effect.
;
; Furthermore, note that many Common Lisp built in operators (setf,
; push, pop ...) are defined as macros and cannot be easily avoided.
;
; Common Lisp advocates can argue that their programs are faster
; if they do not have to generate and evaluate code during runtime
; and time spent for compilation and macroexpansion doesn't count.
;

Commenti
--------
*** Anonymous 3 April 2009 at 10:31
You can say what you want, that NewLisp names FEXPRs 'macros' does not make them macros. They are still FEXPRs. A totally different mechanism from macros. You are comparing apples and oranges. MACROS are defined by some expansion/replacement mechanism. That's how macros work in C, C++, macro assemplers, Lisp etc. Since Newlisp FEXPRs don't do macro expansion, they are no macros. They are just another evaluation strategy. Claiming that Newlisp FEXPRs are macros is just silly. Even if they can compute similar things does not make them macros. They simply lack an macro mechansim. The original idea of a macro is that it is a code template where parts of the expressions can be filled in - before runtime. People were using assembler and were tired to write similar expressions with some variations. So macros assemblers where used, where groups of instructions were used as a template, with some values filled in from macro parameters. The assembler then ran an macro expansion phase, before the assembly phase.

Common Lisp advocates argue that they compile code like yours at runtime once and then call it repeatedly. Your example is trivial. It runs in 4ms on my laptop - including runtime compilation.

*** Kazimir Majorinc 3 April 2009 at 11:41
Do you understand why I have loop? It is just like I want to benchmark addition, and (+ 2 2) is too fast, so I do (dotimes(i 177000)(+ 2 2)). There is no point in "factoring out" addition and doing (dotimes(i 177000)4).

On the same way, there is no point in factoring out compilation or macroexpansion in this example. I could rewrite this test so it makes 177000 different random expressions, and compiling is impossible. But there is no need for that.

Then, about terminology, you are maybe right that fexpr would be historically or generally better. I am not sure, but you are maybe right. However, Newlisp author called it macro. I try to write on the way everyone understands me.

*** Anonymous 3 April 2009 at 12:03
Everyone but Newlisp understands 'macro' to be something different. Better change the Newlisp terminology than confuse everybody but Newlisp users.

You may want to work on examples where FEXPRs are actually useful.

(dotimes (i 824082304) 4) - a Lisp compiler may replace that with just 4.

(dotimes (i 8402983) (+ 2 2)) - still a Lisp compiler may replace that with 4.

It simply makes no sense to evaluate code that is static in shape to evaluate over and over.
The majority of code is like that. Common Lisp implementations are putting the optimizations into the compiler - because that is the default most developers use. Some popular implementations don't even have an interpreter anymore (SBCL) or don't use it by default (CCL).

No matter how you want to sell Newlisp fexprs, for the majority of code a Lisp compiler will outperform Newlisp and its Fexprs by several orders of magnitudes.

*** Anonymous 3 April 2009 at 23:09
fexprs are called macros in newLISP, because from an usage/application's point of view fexprs in newLISP are used for a similar *purpose* macros are used in Common Lisp: to write special forms with special evaluation rules. E.g. to write a form like "dotimes" in Common Lisp you would use a macro. If "dotimes" wouldn't exist in newLISP you could use fexprs (define-macro in newLISP) to do the same.

L.M.

*** Anonymous 4 April 2009 at 13:00
I don't have a car. I use a bicycle for shopping. Is my bicycle now a car?

Languages BEFORE Common Lisp and neWLisp had already BOTH macros AND fexprs as DIFFERENT mechanisms. Newlisp has fexprs, no macros and named fexprs as macros.

In languages like Common Lisp DOTIMES could also be implemented as functions: (my-dotimes 10 'print) would print the numbers from 0 to 9. Often code is implemented like that and the macro only improves the syntax, but the implementation is not done in the macro, it expands to the functional expression.


---------------
Crawler Tractor
---------------
http://kazimirmajorinc.blogspot.com/2009/04/crawler-tractor.html

Example of the self-processing Lisp program is presented. The function f, written in Newlisp dialect of Lisp, continously increments the value of the variable counter and prints its value. However, implementation of f doesn't contain a loop or recursion. Instead, the function changes the code of its definition during evaluation.

(set 'f
     (lambda()
       (begin (print "Hi for the "
                     (inc counter)
                     ". time. ")
              (push (last f) f -1)
              (if (> (length f) 3)
                  (pop f 1)))))

The result of evaluation of (f) is:

Hi for the 1. time.
Hi for the 2. time.
Hi for the 3. time.
Hi for the 4. time.
...
The evaluation reminds on the work of the crawler tractor, popular construction vehicle. Initially, interpreter encountered "stack overflow" after counter was incremented few hundreds of thousands times. Lutz Mueller, the author of Newlisp promptly resolved the issue. The speed penalty was, according to Mueller, very low.

As a proof of the concept, Joel Ericson defined two factorial functions that evaluate on similar way. In one of these even variables are not used.

(define (f)
  (begin
    (when (> (length f) 2)
             (pop f -1))
    (push '(if (> 0 1)
               (begin ; Increase return value

                      (setf ((last f) -1)
                            (* $it ((last f) 1 1)))

                      ; Change exit condition

                      (dec ((last f) 1 1))

                      ; Shorten f if too long

                      (if (> (length f) 4)
                          (pop f 2))

                      (push (last f) f -1))
               1)
          f
          -1)
    (setq ((last f) 1 1) (args 0))))

The result of evaluation of (f 4) is 24.

Commenti
--------
*** Carlos 1 October 2011 at 07:44
Just evaluated this 12996734 is like 30 seconds. Very interesting little piece of code. Thanks for sharing.

*** Joel Ericson 17 January 2013 at 16:49
I made a "crawling" factorial function, just as a proof of concept.

(define (f:f y)
  (begin
    (setq f:n 1)
    (setq f:current 0)
    (push
      '(if (> y 1)
         (begin
           (inc f:current)
           (setq f:n (* f:n y))
           (dec y)
           (if (and (> (length f:f) 3) (> f:current 2))
             (pop f:f 2))
           (push (last f:f) f:f -1))
         f:n)
      f:f -1)))

*** Joel Ericson 17 January 2013 at 23:16
And another one, where the list to be pushed is modified instead of using variables.

(define (f)
  (begin
    (while (> (length f) 2) (pop f -1))
    (push
      '(if (> 0 1)
         (begin
           (setf ((last f) -1) (* $it ((last f) 1 1))) ;; Increase return value
           (dec ((last f) 1 1)) ;; Change exit condition
           (if (> (length f) 4) ;; Shorten the function if it's too long
             (pop f 2))
           (push (last f) f -1))
         1)
      f -1)
    (setq ((last f) 1 1) (args 0))))

*** Kazimir Majorinc 6 November 2013 at 20:11
Brilliant, Joel!


------------------
Supressed Printing
------------------
http://kazimirmajorinc.blogspot.com/2009/05/instprog-library-is-growing-now-it.html

; The Instprog library is growing - now it defines 146 functions
; and 87 macros, although many of these are duplicated, for example,
; set-undefined and SU do same thing, much like USA and united-states-...
; I admit, most of these are more, well, "conceptual" than practical.
;
; In recent versions, all functions and macros in the library are
; protected with my function protect1 already described in this
; blog. Although I do not use contexts, the naming conventions
; should ensure that functions and macros are equally "safe".
;
; Also, the library is pretty verbose. It performs about 60 tests
; and report results. In recent versions I redefined functions
; print and println so these reports can be turned off.

(set 'print.supressed true
     'println.supressed true)

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set 'print.supressed nil
     'println.supressed nil)

(exit)

; Redefinitions of print and println are in the library, so after
; library is loaded, any printing can be supressed on the same way.

(set 'print.original print 'println.original println)
(set 'lambda-last (lambda()(last(args))))

(constant 'print
          (lambda-macro()(eval (cons (if print.supressed
                                         lambda-last
                                         print.original)
                                         (args)))))

(constant 'println (lambda-macro()(eval (cons (if println.supressed
                                                  lambda-last
                                                  println.original)
                                             (args)))))

; Redefined print can be combined with "device" expression.

Note: in new version, one should use [print.supressed] and [println.supressed] instead of print.supressed and println.supressed.

Commenti
--------
*** unixtechie 3 June 2009 at 09:14
Hi, Kazimir, this is "unixtechie" from the newlisp forum.

I really enjoy your posts, so I recently looked at your sites again - and realized you are "on a mission" to study and create a library or a catalogue of useful higher-order programming techniques.

That reminded me of something that might come useful (and something I myself wanted to do some time ago, actually).
There's a book, which can be viewed as an expostulation of results of several years of thinking on programming paradigms and programming primitives, the most basic ones, that those paradigms are built from. Or this book can be viewed as a course in Computer Science, whatever your preference is.

The approach by the authors is this: let's take a minimal number of the most simple functionalities (such as assignement) and see what is necessary to build "pure functional programming" . Let's then add something to it, such as a concept of "laziness" or "state" etc. - and see how this expands into another paradigm.

The book is "Concepts, TEchniques and Models of Computer Programming" by Peter Van Roy and Seif Haridi - and a draft from 2003 (published by MIT in 2004) is available on the Net.
The official web site is http://www.info.ucl.ac.be/~pvr/book.html - and I've got a PDF, but do not remember where I got it from.

The book is written using Mozart-Oz programming language, but it is independent from the language itself - examples in the text can be treated as simply "pseudocode", as the main usefullness of the work lies in their "core language" approach, the reduction of programming to a set of basics.

My idea was to translate - or express - the primitives in NewLisp.
This would be not only interesting as a mental exercise, but very, very practical too. And possibly with academic value, as an application of the general approach to practical programming in a Lisp type of language.

A web search gives the URL of the PDF right from the book official site:
www.info.ucl.ac.be/~pvr/Concepts.pdf

Check it

*** unixtechie 3 June 2009 at 09:20
Sorry, the book URL was wrong - that pdf was a 20-page presentation.
The book is at: http://www.librecours.org/documents/5/521.pdf

*** Kazimir Majorinc 3 June 2009 at 18:11
Hi, unixtechie
thank you on recommendation, it is great and large book. I have two projects in following 2-3 years, one is writing of one automated theorem proving tool, another is research of metaprogramming in Newlisp, by metaprogramming I think on things like eval or that crawler tractor etc. So, it is more narrow than Concept, Techniques and Models ... but I agree with you, it is great idea and book and it would be great if someone does that, even in less extensive version of some 200-300 pages.


-------------------------------------------------
On Serial Substitution and Not Reading The Manual
-------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/06/on-serial-substitution-and-not-reading.html

; I defined no less than six functions performing serial
; substitution:
;
; (serial-substitute '(-> (A B) (B (A B)) (-> B (A C) (B C)))
;                    '((A abc) (B cde) (C xxx)))
;
; =>
;
; (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
;
; until I learnt that built in primitive function "expand", in one
; of its polymorphic versions, does exactly that. However, I decided
; to publish my versions, just for archive. The final one is only
; four times slower than built in substitution.

(set 'substitute
  (lambda(substitute-a l b)
      (if (= l substitute-a)
          b
          (if (list? l)
              (map (lambda(x)(substitute substitute-a x b))
                   l)
              l))))

(set 'serial-substitute1
  (lambda(l A)
     (let ((result l))
       (dolist(i A)
          (set 'result (substitute (i 0) result (i 1))))
       result)))

(set 'metex
   (lambda-macro(head)
     (eval (append '(letex)
                   (list (map (lambda(x)
                                 (list (first x)
                                       (list 'quote (last x))))
                               head))
                   (args)))))

(set 'serial-substitute2
     (lambda(l A)
        (eval (list 'metex A (list 'quote l)))))

(set 'serial-helper3 (lambda(x)(list (first x)
                                      (list 'quote (last x)))))

(set 'serial-substitute3
     (lambda(l A)
        (eval (list 'letex (map serial-helper3
                                A)
                           (list 'quote l)))))

(set 'ss4 '(metex A 'l))
(set 'serial-substitute4
     (lambda(l A)
        (eval (expand ss4 'A 'l))))

(set 'serial-substitute5
     (lambda(l A)
        (letex ((A A)(l l))(metex A 'l))))

(set 'serial-substitute6
     (lambda(F s)
        (eval (let((vars (map first s)))
                  (list 'local
                        vars
                        '(bind s)
                        (append '(expand F)
                                 (map quote vars)))))))

(set 'serial-substitute7 expand) ; this is one built in

(set 'serial-substitute8 '(lambda())) ; just to test empty loop

(set 'formula '(-> (A B) (B (A B)) (-> B (A C) (B C))))
(set 'substitution ' ((A abc) (B cde) (C xxx)))

(dolist (s '(serial-substitute1 serial-substitute2 serial-substitute3
             serial-substitute4 serial-substitute5 serial-substitute6
             serial-substitute7 serial-substitute8))
   (println s " time (ms): " (time ((eval s) formula substitution) 100000))
   (println s " result:    " ((eval s) formula substitution)))

(exit)

serial-substitute1 time (ms): 10681
serial-substitute1 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute2 time (ms): 2084
serial-substitute2 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute3 time (ms): 1544
serial-substitute3 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute4 time (ms): 2114
serial-substitute4 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute5 time (ms): 2134
serial-substitute5 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute6 time (ms): 1174
serial-substitute6 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute7 time (ms): 386
serial-substitute7 result:    (-> (abc cde) (cde (abc cde)) (-> cde (abc xxx) (cde xxx)))
serial-substitute8 time (ms): 119
serial-substitute8 result:    nil


------------------------------------
Propositional Variables and Formulas
------------------------------------
http://kazimirmajorinc.blogspot.com/2009/08/propositional-variables-and-formulas.html

; GROUP:        PROPOSITIONAL VARIABLES AND FORMULAS
;
; Description:  Few elementary functions related to propositional
;               formulas, implemented on the simplest way.
;               Some of the functions can redefine values of
;               the variables in the propositional formulas.
;
;               They use some other library functions I wrote,
;               so this code cannot be just cutted and pasted
;               in editor, but I'll publish it in library soon
;               (or I already did it.)
;
; Names:        propositional-variables, PV
;
;               tautology
;               falsifiable
;               satisfiable
;               contradiction
;
;               satisfaction
;               falsification
;
; Type:         functions
;
; Examples:     (propositional-variables '(-> nil (-> nil nil)))
;               ===> '()
;
;               (propositional-variables '(-> A (or B (and D true) nil)))
;                ===> '(A B D)
;
;               (tautology? '(-> A B)) ==> nil
;
;               (tautology? (-> nil (-> nil nil))) ==> true
;
;               (falsifiable '(-> A B)) ==> true
;
;               (falsifiable (-> nil (-> nil nil))) ==> nil
;
;               (falsification '(-> A B)) ==> ((A true) (B nil))
;
;               (satisfaction '(-> A (not A))) ==> '((A nil)))
;

(SU 'propositional-variables ; SU is my version of set, it warns
                             ; if variable is already defined

  (lambda(f)(difference (unique (leafs f)) ; (leafs '(-> (-> x y) z)) ==> (x y z)
                        booleans)))        ; booleans = '(true nil)

        (SU 'PV propositional-variables)
        (P1S 'propositional-variables '(f)) ; P1S is my protection
                                            ; function roughly equivalent
                                            ; to built in contexts.

                                            ; I use it instead of contexts
                                            ; primarily because I can
                                            ; experiment.
        (P1S 'PV '(f))

        (test "propositional-variables 1"
          (= (propositional-variables '(-> nil (-> nil nil)))
             '()))
                   ; -> is implication, the propositional logical
                   ; connective like or and not, defined
                   ; earlier in library.

        (test "propositional-variables 2"
          (= (propositional-variables '(-> A (or B (and D true) nil)))
             '(A B D)))

(SU 'tautology?
  (lambda(formula)
    (let ((tautology true))
      (letex ((L (propositional-variables formula)))
        (dolist-multi(L booleans (not tautology))
          (setand 'tautology (eval formula)))) ; (setand 'x y) = (set 'x (and x y))
      tautology)))

          (test "tautology" (not (tautology? '(-> A B))))
          (test "tautology2" (tautology? (-> nil (-> nil nil))))

(SU 'falsifiable? (not^ tautology?))  ; not^ is a higher order not;
                                      ; it can be applied on functions
                                      ; ((not^ f) x) = (not (f x))
                                      ; for every x

          (test "falsifiable? 1" (not (falsifiable? true)))
          (test "falsifiable? 2" (falsifiable? '(-> A B)))

          (P1S 'tautology? '(formula tautology L))
          (P1S 'falsifiable? '(formula tautology L))

(SU 'falsification
  (lambda(formula)
    (let ((tautology true)
          (result nil))
      (letex ((L (propositional-variables formula)))
        (dolist-multi(L booleans (not tautology))
          (setand 'tautology (eval formula))
          (unless tautology
                  (set 'result (map (lambda(x)(list x (eval x)))
                                    'L)))))
      result)))

           (test "falsification" (= (falsification '(-> A B))
                                    '((A true) (B nil))))

           (P1S 'falsification '(formula tautology result L))

(SU 'satisfiable? (lambda(f)(falsifiable? (list 'not f))))
(SU 'satisfaction (lambda(f)(falsification (list 'not f))))
(SU 'contradiction? (not^ satisfiable?))

          (test "satisfaction" (= (satisfaction '(-> A (not A))) '((A nil))))

          (P1S 'satisfiable? '(f))
          (P1S 'satisfaction '(f))
          (P1S 'contradiction? '(f))

Related posts: Random Propositional Formulas of a Given Lenght.


-------------------------
Reader Macros in Newlisp?
-------------------------
http://kazimirmajorinc.blogspot.com/2009/09/reader-macros-in-newlisp.html

Ted Walther On Newlisp forum, Ted Walther recently proposed introduction of user defined reader macros in Newlisp. User defined reader macros already exist in Common Lisp and some dialects of Scheme. Built-in, but not user defined reader macros exist in Clojure, and to lesser extent in Scheme and even Pico Lisp. Newlisp has no reader macros at all.

Ted Walther's main reason appears to be ability to use other languages in combination with Newlisp.

Example he posted was:

(add-reader-macro 'c-lang)
(add-reader-macro 'sql-lang)
(add-reader-macro 'html-lang)

(println "hi")

(C
   printf("foo%d",1);
   i++;
)

(sql
     SELECT * FROM ,(amb "table1" "table2")
)

(html
       <h1>foo</h1>
       ,(generate-some-tables))
)

My answer on Newlisp forum is republished here.

I think reader macros make writing code (programming) more friendly, but writing code that processes code (metaprogramming) more difficult.

I do not think that "one who does not want to use reader macros shouldn't use them" is enough. What would happen if someone writes useful library that uses reader macros? Programmers will start to use it. Theoretically, we can remember both new syntax and how it translates into normal Lisp, but in reality, we can only remember and understand limited amount of information, especially if we use Newlisp irregularly. So we'd start using that library, and later more and more of Lisp as any other language, without understanding how to process code.

This practice would, in turn, influence future development of the language. Although Lutz Muellermakes decisions, these are made on the base of the perceived problems and discussions by other programmers.

I could admit that finally, it is not known whether metaprogramming is good idea and that I only believe it is good idea. The failure of Lisp dialects to establish itself as a mainstream language is not a good sign, but recently it appears that Ruby users practice metaprogramming a lot. Any case, metaprogramming is differentia specifica of Lisp. If it is bad idea, Lisp itself is failure. And if it is good idea, it is comparative advantage of Lisp that should be promoted and not discouraged.

From my point of view, following syntax looks OK:

(load "c-lang")
(load "sql-lang")
(load "html-lang")

(println "hi")

(C "printf(\"foo%d\",1);
   i++;")

(sql (append "SELECT * FROM" (amb "\"table1\""       "\"table2\"")))

(html (append "<h1>foo<\h1>"
              (generate-some-tables)))

It is understandable why Ted likes his syntax better. Back while I used PLT Scheme, I used °s-expr instead of (println 's-expr "=" s-expr) equivalent. It was good for debugging, it was enough to insert or delete one ° before suspicious expression. Reader macros can be fun. However, Ted can implement his own, private preprocessor - on that way, whole thing is interesting and challenging private experiment, and not a language policy.

(preprocess
(add-reader-macro 'c-lang)
(add-reader-macro 'sql-lang)
(add-reader-macro 'html-lang)

(println "hi")

(C "printf(\"foo%d\",1);"
   "i++;"))

Of course, Ted was aware of that, his opinion is that reader macros are generally useful. (I wrote about preprocessing in this blog previously, in posts EVALUATION IN TWO STAGES and MACROCALL.)


--------------------
eval-string or eval?
--------------------
http://kazimirmajorinc.blogspot.com/2009/09/eval-string-or-eval.html

; The problem that could be solved using metaprogramming
; techniques was discussed today on Newlisp forum. Programmer
; newdep proposed integration of unary predicates (the
; functions accepting only one argument and returning true or
; false) and "if" primitive. Instead of, for example, printing
;
;     (if (integer? x) (print "integer!") (print "isn't integer"))
;
; newdep thought about following:
;
;     (if-integer x (print "integer!) (print "isn't integer"))
;
; In further discussion it was noted that such macro would be
; smarter, but less general. Nevertheless, programmer cormullion
; suggested simple macro to accomplish that:

(define-macro (if-integer)
                (if (integer? (eval (args 0)))
                  (eval (args 1))
                  (eval (args 2))))

(if-integer 34.5 (println "yes") (println "no")) ;--> "no"

; As this is routine operation, it can be used as good example
; of the techniqe that allows one to define lot of macros, related
; to all already defined predicates similar to if.
;
; It is already adressed in several posts, but this time, we
; have example of the code that could be processed easier
; in the form of a string, than in the form of s-expression.
; Usually, eval is better than eval-string, and McCarthy actually
; attributed relative success of Lisp to s-expressions, being simpler
; for metaprogramming, compared with normal strings as in POP
; for example.

; We'll first define helper function - almost the metapredicate:
; predicate predicate? Accepting symbol as argument, predicate?
; will check whether symbol ends with "?". Also, the predicate
; must be different than symbol '? itself which serves other
; purposes.

(define (predicate? i)
        (and (ends-with (string i) "?")
             (!= i '?)))

; Now we should loop through all predicates and do what cormullion
; done for integer. First, using strings and eval-string:

(dolist(i (symbols))
  (when (predicate? i)

     (eval-string
        (replace "integer"

                 (copy "(define-macro (if-integer)
                                      (if (integer? (eval (args 0)))
                                          (eval (args 1))
                                          (eval (args 2))))")

                 (append (chop (string i)))))))

(if-zero 0 (println "yes") (println "no")) ;--> "yes"

; Then using s-expressions and eval

(dolist(i (symbols))
  (when (predicate? i) ; for example, i=positive?

    (set (sym (append "if-" (chop (string i)))) ; positive?->if-positive
         (expand (lambda-macro()
                       (if (i (eval (args 0)))
                           (eval (args 1))
                           (eval (args 2))))
                 'i))))

(if-zero 34 (println "yes") (println "no")) ;--> "no"


-------------------------------------------------------
Random Propositional Formulas of a Given Average Length
-------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/09/random-propositional-formulas-of-given.html

; My naive attempt to generate random propositional formula
; recursively, giving equal probability to standard logical
; constants true and nil and connectives not, and, and ->
; failed:

(set 'random-formula
      (lambda()
         (amb true
              nil
              (list 'not (random-formula))
              (list 'and (random-formula) (random-formula))
              (list 'or (random-formula) (random-formula))
              (list '-> (random-formula) (random-formula)))))

(dotimes(i 30)(println i ". " (random-formula)))

Error: newlisp.exe has stopped working

; The problem is in infinite recursion. The expectation is that
; random-formula will call seven times another instance of random-formula
; in 6 calls, so it is unlikely that random formula construction
; will be completed. This time, solution is very simple:

(seed (date-value))

(set 'random-formula
      (lambda()
         (amb true true
              nil nil
              (list 'not (random-formula))
              (list 'and (random-formula) (random-formula))
              (list 'or (random-formula) (random-formula))
              (list '-> (random-formula) (random-formula)))))

(dotimes(i 20)(println i ". " (random-formula)))

; The results:

0. (not (and (not (and true nil)) (-> (-> (or (and nil nil) nil) true) nil)))
1. true
2. true
3. nil
4. nil
5. (not (not (-> (not nil) true)))
6. (and true (-> true (or (or (or (and true nil) nil) nil) (not (or (not (-> true
(not (or (not (not (or true (and (not true) true)))) (-> nil nil))))) (-> nil
(-> (and nil true) (and (-> (or (or (not (-> true true)) (and (-> nil nil) nil))
(or nil (not true))) (or nil (or true (or true (not nil))))) true))))))))
7. nil
8. nil
9. (or (and nil (not true)) true)
10. (or true (and true (or (or (or nil (not true)) (-> (-> nil (and (or nil true
) nil)) true)) (and (-> nil (or nil nil)) true))))
11. true
12. true
13. (not nil)
14. nil
15. true
16. (and nil (and (-> (or true (or true (-> true (not (-> (or (and (and nil nil)
(not nil))(not nil)) nil)))))(and (and true (or true (-> nil (or true nil))))
(not (and nil nil)))) (or true (and (-> nil (and true (or (not (not (and
(or true nil) (or (and nil (not (or (not (and nil (not true))) true)))(not (not
nil)))))) nil))) true))))
17. (or nil (-> (and nil true) true))
18. nil
19. (and (not (not nil)) (or (or nil (and (not (-> (or (-> nil nil) true) (not (
not (and (or (or (and (not nil) (and true true)) true) true) true))))) (not true)))
nil))

; Now, it is possible, but unlikely that random-formula will
; generate random-formula calls infinitely. In eight function calls,
; new function call will be generated seven times.
;
; Interesting question that occurs immidietely is: but, how big
; is average formula generated on this way? By size of the formula,
; we'll simply count number of connectives and constants in formula,
; i.e. number of nodes in imagined graph. Size of (or true (not nil))
; is, for example, four.

; We'll estimate of average length of formula using the fact that
; Random formula is defined recursively. Let us denote *expected length*
; of average formula as x. Then
;
;          1 + 1 + 1 + 1 + (1+x) + (1+2x) + (1+2x) + (1+2x)
;     x = --------------------------------------------------
;                               8
;
; where 1, 1, 1, 1 are sizes of the trivial formulas: true, true,
; nil and nil; (1+x) is expected size of the formula (list 'not (random-formula))
; and (1+2x) is expected size of other three formulas.
;
; If we solve that equation, we'll get x=8. Let us test that:

(set 'size-of
     (lambda(f)
       (cond ((or (= f true) (= f nil)) 1)
             ((= (first f) 'not) (+ (size-of (last f)) 1))
             (true (+ (size-of (nth 1 f))
                      (size-of (nth 2 f))
                      1)))))

(set 'sum 0)
(dotimes(i 100000)
  (inc sum (size-of (random-formula))))
(println (div sum 100000)) ; 8.01414 - OK

; Now, when we are here, we'll try to answer the next question:
; How to define the function that generates random formulas of
; expected length, say, 20. For that purpose, we need slightly
; redefined, more general, random-formula. Instead of repeating
; true and nil two times, we'll repeat it a times, where a is
; real number.

(set 'random-formula
      (lambda(a)
         (let ((r (random 0 (add 4 (mul 2 a)))))
              (cond
                 ((<= 0 r 1) (list 'not (random-formula a)))
                 ((<= 1 r 2) (list 'and (random-formula a) (random-formula a)))
                 ((<= 2 r 3) (list 'or (random-formula a) (random-formula a)))
                 ((<= 3 r 4) (list '-> (random-formula a) (random-formula a)))
                 ((<= 4 r (add 4 a)) true)           ; if a=2 then
                 ((<= (add 4 a) r (add 4 a a)) nil)))))

(set 'sum 0)
(dotimes(i 100000)
  (inc sum (size-of (random-formula 2))))
(println (div sum 100000)) ; 7.93368 - OK

; Now, my formula for estimation of expected size will get
; this form:
;
;         (1+x) + (1+2x) + (1+2x) + (1+2x) + 2a
;    x = ----------------------------------------
;                         6+2a
;
; If we express a explicitly,
;
;                         3x + 4
;                     a = ------
;                         2(x-1)
;
; particularly, for x=20, a=1.684210.

(set 'sum 0)
(dotimes(i 100000)
  (inc sum (size-of (random-formula 1.6842105))))
(println (div sum 100000)) ; 19.74605 - not bad either.

; Finally, for convenience, we'll redefine random-formula so it
; accepts x as variable, not a.

(set 'random-formula
      (lambda(x)
         (letn ((a (div (add (mul x 3) 4) (mul 2 (sub x 1))))
               (r (random 0 (add 4 (mul 2 a)))))
              (cond
                 ((<= 0 r 1) (list 'not (random-formula x)))
                 ((<= 1 r 2) (list 'and (random-formula x) (random-formula x)))
                 ((<= 2 r 3) (list 'or (random-formula x) (random-formula x)))
                 ((<= 3 r 4) (list '-> (random-formula x) (random-formula x)))
                 ((<= 4 r (add 4 a)) true)           ; if a=2 then
                 ((<= (add 4 a) r (add 4 a a)) nil)))))

(set 'sum 0)
(dotimes(i 100000)
  (inc sum (size-of (random-formula 100))))
(println (div sum 100000)) ; 98.71964

(exit)

Related posts: Propositional Variables and Formulas


---------------------------------------------------------
On Expected Truth Value of a Random Propositional Formula
---------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/09/on-expected-length-of-random.html

Is it more probable that random propositional formula, as defined
in previous blogpost using true, nil and traditional connectives or,
and, not and -> is true or false? One would expect that it is equally
probable. Let us test this hypothesis.

(set 'random-formula
      (lambda(x)
        (if (= x 1)
            (amb true nil)
            (letn ((a (div (add (mul x 3) 4) (mul 2 (sub x 1))))
                  (r (random 0 (add 4 (mul 2 a)))))

                 (cond
                    ((<= 0 r 1) (list 'not (random-formula x)))
                    ((<= 1 r 2) (list 'and (random-formula x) (random-formula x)))
                    ((<= 2 r 3) (list 'or (random-formula x) (random-formula x)))
                    ((<= 3 r 4) (list '-> (random-formula x) (random-formula x)))
                    ((<= 4 r (add 4 a)) true)           ; if a=2 then
                    ((<= (add 4 a) r (add 4 a a)) nil))))))

(set '-> (lambda(x y)(or (not x) y)))

(for (j 1 50)
  (set 'sum 0)
  (dotimes(i 100000)
    (if (eval (random-formula j)) ; power of eval
        (inc sum)))
  (println "Random formula of a length " j ". is true in "
           (div (mul 100 sum) 100000) "% of cases"))

Results:

Random formula of a length 1. is true in 49.855% of cases
Random formula of a length 2. is true in 52.099% of cases
Random formula of a length 3. is true in 52.636% of cases
Random formula of a length 4. is true in 53.104% of cases
Random formula of a length 5. is true in 53.224% of cases
Random formula of a length 6. is true in 53.577% of cases
Random formula of a length 7. is true in 53.339% of cases
Random formula of a length 8. is true in 53.484% of cases
Random formula of a length 9. is true in 53.513% of cases
Random formula of a length 10. is true in 53.87% of cases
Random formula of a length 11. is true in 53.889% of cases
Random formula of a length 12. is true in 53.571% of cases
Random formula of a length 13. is true in 53.917% of cases
Random formula of a length 14. is true in 53.837% of cases
Random formula of a length 15. is true in 54.14% of cases
Random formula of a length 16. is true in 53.973% of cases
Random formula of a length 17. is true in 53.811% of cases
Random formula of a length 18. is true in 54.059% of cases
Random formula of a length 19. is true in 53.929% of cases
Random formula of a length 20. is true in 53.98% of cases
Random formula of a length 21. is true in 53.818% of cases
Random formula of a length 22. is true in 54.109% of cases
Random formula of a length 23. is true in 53.999% of cases
Random formula of a length 24. is true in 54.001% of cases
Random formula of a length 25. is true in 54.095% of cases
Random formula of a length 26. is true in 54.03% of cases
Random formula of a length 27. is true in 54.215% of cases
Random formula of a length 28. is true in 54.048% of cases
Random formula of a length 29. is true in 54.12% of cases
Random formula of a length 30. is true in 53.972% of cases
Random formula of a length 31. is true in 53.752% of cases
Random formula of a length 32. is true in 54.154% of cases
Random formula of a length 33. is true in 54.229% of cases
Random formula of a length 34. is true in 54.159% of cases
Random formula of a length 35. is true in 53.972% of cases
Random formula of a length 36. is true in 54.063% of cases
Random formula of a length 37. is true in 53.926% of cases
Random formula of a length 38. is true in 53.899% of cases
Random formula of a length 39. is true in 54.078% of cases
Random formula of a length 40. is true in 54.247% of cases
Random formula of a length 41. is true in 54.14% of cases
Random formula of a length 42. is true in 54.036% of cases
Random formula of a length 43. is true in 54.05% of cases
Random formula of a length 44. is true in 54.16% of cases
Random formula of a length 45. is true in 53.964% of cases
Random formula of a length 46. is true in 53.988% of cases
Random formula of a length 47. is true in 54.075% of cases
Random formula of a length 48. is true in 54% of cases
Random formula of a length 49. is true in 53.975% of cases
Random formula of a length 50. is true in 53.954% of cases

Why probability that random formula is true is consistently greater
than 50%? Because of asymmetry of traditionally basic logical connectives
and, or and ->. These are the truth tables (0 = nil, 1 = true):

 x y (or x y)        x y (and x y)       x y (-> x y)
 ------------        -------------       ------------
 0 0   0             0 0   0             0 0  1
 0 1   1             0 1   0             0 1  1
 1 0   1             1 0   0             1 0  0
 1 1   1             1 1   1             1 1  1

Look at the last column in each of these definitions - there are
total seven 1's and five 0's.

If formula of a given length, say l has connective or, and or
-> on a top level, the probability that it is true should be greater
than probability that it is false.

On the other side, if formula of the same length l has connective not
on the top level, then it is more probable that formula is false -
because not is applied on a random formula of a length l-1 which
is, supposedly more probable to be true. However, there is less of
formulas of length l-1 than formulas of a length l, so formulas
starting with not cannot compensate for formulas starting with
and, or and ->.

We proved that random formula of the length l is probably true -
if formula of the length l-1 is probably true. To complete the proof,
we must prove that random formula is probably true for some base
case:

1: true, false => 1 true, 1 false
2: (not true), (not false) => 1 true, 1 false
3: (or false false), (or false true), (or true false), (or true true),
   (and false false), (and false true), (and true false), (and true true),
   (-> false false), (-> false true), (-> true false), (-> true true)
   (not (not true)), (not (not false)) => 8 true, 6 false.

If formula of a length 3 is probably true, then formula of the
length 4 is probably true and so on ...

Note that our random formulas have no fixed length - but they have
fixed average length, and it is enough that this asymmetry breaks
through.

Related posts: Propositional Variables and Formulas
               Random Propositional Formulas of a Given Length


-------------------------------------------------------------
On Expected Truth Value of a Random Propositional Formula (2)
-------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/09/on-expected-length-of-random_25.html

; Random propositional formula - is it true or false?

; Another function for definition of the random propositional formula
; is implemented. This time not the probability that graph edge is
; leaf (true or nil) is given, instead, the size of the formula is
; exactly controlled. For example, if (random-formula 5) is called,
; then, first, logical connective is randomly chosen, and then,
; if that logical connective is not then
;
;   (list 'not (random-formula 4))
;
; is returned. If binary logical connective is chosen, the pair
; (n1, n2) is also randomly chosen so n1+n2=4, and
;
;   (list connective (random-formula n1) (random-formula n2))
;
; is returned. There are also few simple special cases.

(set 'random-formula2
  (lambda(x)
    (cond ((= x 1) (amb true nil))
          ((= x 2) (list 'not (random-formula2 1)))

          (true (let ((connective (amb 'not 'or 'and '->)))

                     (cons connective

                           (if (= connective 'not)
                               (list (random-formula2 (- x 1)))

                               (let ((r (apply amb (sequence 1 (- x 2)))))
                                     (list (random-formula2 r)
                                           (random-formula2 (- x 1 r)))))))))))

; I'll use debug-wrap from my library to demonstrate how function
; calls itself:

(load "http://www.instprog.com/Instprog.default-library.lsp")

(debug-wrap random-formula2)
(random-formula2 7)
;
; (random-formula2 (in 7)
;                  (random-formula2 (in 5)
;                                   (random-formula2 (in 4)
;                                                    (random-formula2 (in 1)
;                                                                     (out true))
;                                                    (random-formula2 (in 2)
;                                                                     (random-formula2 (in 1)
;                                                                                      (out true))
;                                                                     (out (not true))); m=2
;                                                    (out (or true (not true)))); t=31; m=5
;                                   (out (not (or true (not true))))); t=31; m=7
;                  (random-formula2 (in 1)
;                                   (out true))
;                  (out (-> (not (or true (not true))) true))); t=46; m=10
;

(debug-unwrap random-formula2)

; Let us look once again whether propositional formulas are really
; more probably true than false ...

(for (x 0 10)
  (set 'j (pow 10 x))
  (set 'sum 0)
  (dotimes(i 1000)
    (if (eval (random-formula2 j)) ; power of eval
        (inc sum)))
  (println "Random formula of a length " j " is true in "
           (div (mul 100 sum) 1000) "% of cases"))

; Random formula of a length 1 is true in 49.2% of cases
; Random formula of a length 10 is true in 55.2% of cases
; Random formula of a length 100 is true in 57.9% of cases
; Random formula of a length 1000 is true in 56.6% of cases
; Random formula of a length 10000 is true in 60% of cases
; Random formula of a length 100000 is true in 59.5% of cases


--------------------------------------------------------------
The Probability That Random Propositional Formula is Tautology
--------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/09/probability-that-random-propositional.html

; In last few posts we have shown that radnom propositional formula
; using classical connectives or, and and ->, and without variables
; is more probably true than false. In this post, we'll show that
; probability that propositional formula with variables is tautology
; is surprisingly high.

(load "http://www.instprog.com/Instprog.default-library.lsp")

; The function rnd-pf returns random propositional formula. For
; example, (rnd-pf 10 '(true nil x y z) '(not) '(or and ->)) will
; return radnom formula of the size 10, with leafs true, nil, x, y
; and z; unary connective not and binary connectives or, and and ->.

(set 'element find)

(set 'rnd-pf
  (lambda(len leafs unary binary)
    (let ((connectives (append unary binary)))
      (cond ((= len  1)
               (apply amb leafs))
            ((= len  2)
               (list (apply amb unary)
                 (rnd-pf 1 leafs unary binary)))

            ((> len  2)
               (let ((connective (apply amb connectives)))
                 (cons connective
                       (if (element connective unary)
                           (list (rnd-pf (- len  1) leafs unary binary))
                           (let ((r (apply amb (sequence 1 (- len  2)))))
                                 (list (rnd-pf r leafs unary binary)
                                       (rnd-pf (- len 1 r) leafs unary binary)))))))))))

; In following part of the program, 1000 random propositional formulas
; of the size 1000 (that means, 1000 nodes in graph) are constructed,
; and probability that random formula is tautology is calculated. It
; is done for various number of variables, from no variables at all
; to 17 variables.

(set 'vars '(a b c d e f g h i j k l m n o p q r s t u v w x y z))

(dotimes(j 20)
  (set 'tautologies 0)
   (dotimes(i 1000)
     (set 'rf (rnd-pf 1000 (append '(true nil) (slice vars 0 j)) '(not) '(and or ->)))
  (when (tautology? rf)
        (inc tautologies)))

(println "Formulas with " j " variables: " (/ tautologies 10) "% tautologies."))

; The results are:
;
; Formulas with 0 variables: 58% tautologies.
; Formulas with 1 variables: 51% tautologies.
; Formulas with 2 variables: 42% tautologies.
; Formulas with 3 variables: 42% tautologies.
; Formulas with 4 variables: 34% tautologies.
; Formulas with 5 variables: 31% tautologies.
; Formulas with 6 variables: 31% tautologies.
; Formulas with 7 variables: 30% tautologies.
; Formulas with 8 variables: 27% tautologies.
; Formulas with 9 variables: 22% tautologies.
; Formulas with 10 variables: 22% tautologies.
; Formulas with 11 variables: 21% tautologies.
; Formulas with 12 variables: 22% tautologies.
; Formulas with 13 variables: 16% tautologies.
; Formulas with 14 variables: 18% tautologies.
; Formulas with 15 variables: 19% tautologies.
; Formulas with 16 variables: 16% tautologies.
; Formulas with 17 variables: 16% tautologies.


-------------------------------
Lists of Propositional Formulas
-------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/lists-of-propositional-formulas.html

; We continue discussing propositional formulas. After few
; functions for generation of random propositional formulas are defined,
; in this post we publish function that generate the list of all
; propositional formulas defined with
;
;  * length of the list
;  * list of leafs (logical constants and variables)
;  * list of unary logical connectives
;  * list of binary logical connectives.
;
; For example, (all-pf 4 '(a b c) '(not) '(and or ->)) is:
;
; ((not (not (not a))) (not (not (not b))) (not (not (not c)))
;  (not (and a a)) (not (and a b)) (not (and a c)) (not (and b a))
;  (not (and b b)) (not (and b c)) (not (and c a)) (not (and c b))
;  (not (and c c)) (not (or a a)) (not (or a b)) (not (or a c))
;  (not (or b a)) (not (or b b)) (not (or b c)) (not (or c a))
;  (not (or c b)) (not (or c c)) (not (-> a a)) (not (-> a b))
;  (not (-> a c)) (not (-> b a)) (not (-> b b)) (not (-> b c))
;  (not (-> c a)) (not (-> c b)) (not (-> c c)) (and a (not a))
;  (and a (not b)) (and a (not c)) (and b (not a)) (and b (not b))
;  (and b (not c)) (and c (not a)) (and c (not b)) (and c (not c))
;  (and (not a) a) (and (not a) b) (and (not a) c) (and (not b) a)
;  (and (not b) b) (and (not b) c) (and (not c) a) (and (not c) b)
;  (and (not c) c) (or a (not a)) (or a (not b)) (or a (not c))
;  (or b (not a)) (or b (not b)) (or b (not c)) (or c (not a))
;  (or c (not b)) (or c (not c)) (or (not a) a) (or (not a) b)
;  (or (not a) c) (or (not b) a) (or (not b) b) (or (not b) c)
;  (or (not c) a) (or (not c) b) (or (not c) c) (-> a (not a))
;  (-> a (not b)) (-> a (not c)) (-> b (not a)) (-> b (not b))
;  (-> b (not c)) (-> c (not a)) (-> c (not b)) (-> c (not c))
;  (-> (not a) a) (-> (not a) b) (-> (not a) c) (-> (not b) a)
;  (-> (not b) b) (-> (not b) c) (-> (not c) a) (-> (not c) b)
;  (-> (not c) c))
;
; All should be here.

(load "http://www.instprog.com/Instprog.default-library.lsp")

; The function *list is "product" of two lists, Cartesian product.
; with few experiments, I discovered that "imperative" version is
; about three times faster than "functional."

(set '*list (lambda(l1 l2)
              (let ((result '()))
                   (dolist(i l1)
                     (dolist(j l2)
                       (push (list i j) result -1)))
                   result)))

(println (*list '(1 2 3) '(4 5 6)))

; => ((1 4) (1 5) (1 6) (2 4) (2 5) (2 6) (3 4) (3 5) (3 6))

; another helper function

(set 'appendall (lambda(a b)
                  (apply append (map a b))))

(println (appendall (lambda(x)(list x (sqrt x x)))
                    '(1 2 3 4 5)))

;(1 1 2 1.414213562 3 1.732050808 4 2 5 2.236067977)

; Finally, the function.

(set 'all-pf
  (lambda(len leafs unary binary)
     (if (= len 1)
         leafs
         (append (appendall (lambda(connective)
                               (map (lambda(x)(list connective x))
                                    (all-pf (- len 1) leafs unary binary)))
                            unary)
                 (if (> len 2)
                     (appendall (lambda(connective)
                                   (appendall (lambda(r)
                                                (map (lambda(x)(cons connective x))
                                                     (*list (all-pf r leafs unary binary)
                                                            (all-pf (- len 1 r) leafs unary binary))))
                                              (sequence 1 (- len 2))))
                                 binary)
                     '())))))

;Using this function, it is easy to count number of tautologies:

(set 'formulas (all-pf 7 '(true nil a b c) '(not) '(and or ->)))

(println '(all-pf 7 '(true nil a b c) '(not) '(and or ->)) " contains "
   (length formulas) " formulas and " (length (filter true? (map tautology? formulas)))
   " of these are tautologies.")

; (all-pf 7 '(true nil a b c) '(not) '(and or ->)) contains 119255
; formulas and 39150 of these are tautologies.
;
; Again, we can be surprised how many formulas are actually
; tautologies.


-----------------------------------------
Debug-wrapping Around Built-in Primitives
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/debug-wrapping-around-built-in.html

; Debug-wrap is one of the most practical functions resulted from
; deliberations on this blog. It is described in this post:
;
; http://kazimirmajorinc.blogspot.com/2008/07/verbose-functions.html
;
; version described in the blog maybe doesn't work any more as it is,
; because Newlisp changed in the meantime. But essence is the same, and
; updated version is in Instprog.default-library.lsp.

; Classical examples are Fibonacci's numbers.

(load "http://www.instprog.com/Instprog.default-library.lsp")

; (load "C:\\Newlisp\\Instprog.default-library.lsp")
;

(set 'fib (lambda(n)(if (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))))
(debug-wrap fib)

(fib 5)

;
; Result:
;
; (fib (in 5)
;      (fib (in 4)
;           (fib (in 3)
;                (fib (in 2)
;                     (out 1))
;                (fib (in 1)
;                     (out 1))
;                (out 2)); t=22
;           (fib (in 2)
;                (out 1))
;           (out 3)); t=43
;      (fib (in 3)
;           (fib (in 2)
;                (out 1))
;           (fib (in 1)
;                (out 1))
;           (out 2)); t=22
;      (out 5)); t=86
;
; "comments" like t=113 are the time of the evaluation of the function,
; in microseconds .The result is in form of s-expression, because
; that is readable format, and also, because it allows one to inspect
; debugging output in some s-expression aware text editor, that
; can highlight left and right parenths. I had best experiences
;  with PLT Scheme editor. Debug-wrap can be applied on macros and
; built in primitives as well.

 (debug-wrap +)
 (fib 5)

; (fib (in 5)
;      (+ (in (fib (- n 1)) (fib (- n 2)))
;         (fib (in 4)
;              (+ (in (fib (- n 1)) (fib (- n 2)))
;                 (fib (in 3)
;                      (+ (in (fib (- n 1)) (fib (- n 2)))
;                         (fib (in 2)
;                              (out 1))
;                         (fib (in 1)
;                              (out 1))
;                         (out 2)); t=23
;                      (out 2)); t=35
;                 (fib (in 2)
;                      (out 1))
;                 (out 3)); t=57
;              (out 3)); t=71
;         (fib (in 3)
;              (+ (in (fib (- n 1)) (fib (- n 2)))
;                 (fib (in 2)
;                      (out 1))
;                 (fib (in 1)
;                      (out 1))
;                 (out 2)); t=21
;              (out 2)); t=34
;         (out 5)); t=131
;      (out 5)); t=141
;
; OK, it works. But, what will happen if I try something relatively
; naive:
;
; (debug-wrap when)
;
; (fib 5)
;

Error: newlisp.exe has stopped working

;
; Why? The function when is used inside the definition of new,
; debug version of when. So, when calls another instance of when,
; which calls another instance of when and so forth.
;
; So, what is the solution for this case? We'll replace all occurences
; of symbol when in the body of debug-wrap with symbol [when.original].
; There are few trivial details also.

(debug-unwrap fib)
(debug-unwrap +)

(set '[when.original] when)
(set 'debug-wrap (expand debug-wrap '((when [when.original]))))

(debug-wrap when)
(debug-wrap fib)

(fib 5)

; it works. Wrapped when is not problem any more.

; Now, I'll debug-wrap all primitives used in fib: +, - and if.
; I'll use few functions that semi-automatize that. Main idea is
; relatively simple, but there are quite a few technical details.
; My suggestion is - don't bother much about details, just get the
; idea. First, I'll clean the tails left from previous debugging
; sessions of fib.

(debug-unwrap when)
(debug-unwrap fib)

; Function original accepts symbol, say z as argument and returns
; symbol [z.original]

(set 'original
  (lambda([original.x])
    (sym (append "[" (string [original.x])
                     ".original]"))))

; this loop is equivalent to (set '[+.original] +) and same for
; - and if.

(dolist(i '(+ - if))
  (if (primitive? (eval i))
      (set (original i)
           (eval i))))

; The function originalize replace all simbols like + with [+.original]
; in the body of the fname.

(set 'originalize
  (lambda(fname symbolist)
    (eval (list (if (protected? (eval fname))
                    'set
                    'constant)
                'fname
                (expand (eval fname)
                        (map (lambda(s)      ;this map will produce
                                (list s      ;((+ [+.original])...)
                                      (original s)))
                             symbolist))))))

(originalize 'debug-wrap '(+ - if))
(originalize 'println '(+ - if)) ; I must do that because my library
                                 ; redefines println on the way that
                                 ; contains if, and if I do not use
                                 ; original if, infinite loops is
                                 ; created.
(originalize 'print '(+ - if))   ; The same as println.

(debug-wrap fib)
(debug-wrap +)
(debug-wrap -)
(debug-wrap if)
(===)
(fib 5)

(exit)

; RESULT

; (fib (in 5)
;      (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;          (+ (in (fib (- n 1)) (fib (- n 2)))
;             (- (in n 1)
;                (out 4))
;             (fib (in 4)
;                  (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                      (+ (in (fib (- n 1)) (fib (- n 2)))
;                         (- (in n 1)
;                            (out 3))
;                         (fib (in 3)
;                              (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                  (+ (in (fib (- n 1)) (fib (- n 2)))
;                                     (- (in n 1)
;                                        (out 2))
;                                     (fib (in 2)
;                                          (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                              (out 1))
;                                          (out 1)); t=10
;                                     (- (in n 2)
;                                        (out 1))
;                                     (fib (in 1)
;                                          (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                              (out 1))
;                                          (out 1)); t=14
;                                     (out 2)); t=64
;                                  (out 2)); t=78
;                              (out 2)); t=89
;                         (- (in n 2)
;                            (out 2))
;                         (fib (in 2)
;                              (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                  (out 1))
;                              (out 1)); t=11
;                         (out 3)); t=143
;                      (out 3)); t=153
;                  (out 3)); t=164
;             (- (in n 2)
;                (out 3))
;             (fib (in 3)
;                  (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                      (+ (in (fib (- n 1)) (fib (- n 2)))
;                         (- (in n 1)
;                            (out 2))
;                         (fib (in 2)
;                              (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                  (out 1)); t=1
;                              (out 1)); t=13
;                         (- (in n 2)
;                            (out 1))
;                         (fib (in 1)
;                              (if (in (< n 3) 1 (+ (fib (- n 1)) (fib (- n 2))))
;                                  (out 1))
;                              (out 1)); t=13
;                         (out 2)); t=75
;                      (out 2)); t=88
;                  (out 2)); t=101
;             (out 5)); t=302
;          (out 5)); t=311
;      (out 5)); t=325
;

; In next few weeks, I'll integrate all that in the library, so use of the
; debug-wrap will be simpler even when built-in primitives are
; debug-wrapped.


-----------------------------------------
One Hundred Propositional Tautologies (1)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-1.html

; I write program that derives one hundred propositional tautologies.
; Then I identify one which is not interesting, and try to improve
; program so next time it derives one hundred of more interesting
; propositional tautologies. We'll see where is this going.
;
;
; Preparing part:

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set '*list (lambda(l1 l2)
              (let ((result '()))
                   (dolist(i l1)
                     (dolist(j l2)
                       (push (list i j) result -1)))
                   result)))

(set 'appendall (lambda(a b)
                  (apply append (map a b))))

(set 'all-pf
  (lambda(len leafs unary binary)
     (if (= len 1)
        leafs
        (append (appendall (lambda(connective)
                              (map (lambda(x)(list connective x))
                                   (all-pf (- len 1) leafs unary binary)))
                           unary)
                (if (> len 2)
                    (appendall (lambda(connective)
                                  (appendall (lambda(r)
                                               (map (lambda(x)(cons connective x))
                                                    (*list (all-pf r leafs unary binary)
                                                           (all-pf (- len 1 r) leafs unary binary))))
                                             (sequence 1 (- len 2))))
                                binary)
                    '())))))

(set 'element find)

(set 'size-pf
     (lambda(f)
       (if (list? f)
           (apply + (map size-pf f))
           1)))

; For the first time, I has the right on a wild guess. So, I'll
; of the length 3 and 4, using true, nil and variables a b c d e,
; and classical connectives and filter tautologies.

(---)
(set 'tautologies (filter tautology? (append (all-pf 3 '(true nil a b c d e)
                                                       '(not)
                                                       '(and or -> <->))

                                             (all-pf 4 '(true nil a b c d e)
                                                       '(not)
                                                       '(and or -> <->)))))

(map (lambda(x)(println (+ $idx 1) ". " x))
     tautologies)

;===============================================================
;
; RESULTS:

1. (not (not true))
2. (and true true)
3. (or true true)
4. (or true nil)
5. (or true a)
6. (or true b)
7. (or true c)
8. (or true d)
9. (or true e)
10. (or nil true)
11. (or a true)
12. (or b true)
13. (or c true)
14. (or d true)
15. (or e true)
16. (-> true true)
17. (-> nil true)
18. (-> nil nil)
19. (-> nil a)
20. (-> nil b)
21. (-> nil c)
22. (-> nil d)
23. (-> nil e)
24. (-> a true)
25. (-> a a)
26. (-> b true)
27. (-> b b)
28. (-> c true)
29. (-> c c)
30. (-> d true)
31. (-> d d)
32. (-> e true)
33. (-> e e)
34. (<-> true true)
35. (<-> nil nil)
36. (<-> a a)
37. (<-> b b)
38. (<-> c c)
39. (<-> d d)
40. (<-> e e)
41. (not (not (not nil)))
42. (not (and true nil))
43. (not (and nil true))
44. (not (and nil nil))
45. (not (and nil a))
46. (not (and nil b))
47. (not (and nil c))
48. (not (and nil d))
49. (not (and nil e))
50. (not (and a nil))
51. (not (and b nil))
52. (not (and c nil))
53. (not (and d nil))
54. (not (and e nil))
55. (not (or nil nil))
56. (not (-> true nil))
57. (not (<-> true nil))
58. (not (<-> nil true))
59. (and true (not nil))
60. (and (not nil) true)
61. (or true (not true))
62. (or true (not nil))
63. (or true (not a))
64. (or true (not b))
65. (or true (not c))
66. (or true (not d))
67. (or true (not e))
68. (or nil (not nil))
69. (or a (not nil))
70. (or a (not a))
71. (or b (not nil))
72. (or b (not b))
73. (or c (not nil))
74. (or c (not c))
75. (or d (not nil))
76. (or d (not d))
77. (or e (not nil))
78. (or e (not e))
79. (or (not true) true)
80. (or (not nil) true)
81. (or (not nil) nil)
82. (or (not nil) a)
83. (or (not nil) b)
84. (or (not nil) c)
85. (or (not nil) d)
86. (or (not nil) e)
87. (or (not a) true)
88. (or (not a) a)
89. (or (not b) true)
90. (or (not b) b)
91. (or (not c) true)
92. (or (not c) c)
93. (or (not d) true)
94. (or (not d) d)
95. (or (not e) true)
96. (or (not e) e)
97. (-> true (not nil))
98. (-> nil (not true))
99. (-> nil (not nil))
100. (-> nil (not a))
101. (-> nil (not b))
102. (-> nil (not c))
103. (-> nil (not d))
104. (-> nil (not e))
105. (-> a (not nil))
106. (-> b (not nil))
107. (-> c (not nil))
108. (-> d (not nil))
109. (-> e (not nil))
110. (-> (not true) true)
111. (-> (not true) nil)
112. (-> (not true) a)
113. (-> (not true) b)
114. (-> (not true) c)
115. (-> (not true) d)
116. (-> (not true) e)
117. (-> (not nil) true)
118. (-> (not a) true)
119. (-> (not b) true)
120. (-> (not c) true)
121. (-> (not d) true)
122. (-> (not e) true)
123. (<-> true (not nil))
124. (<-> nil (not true))
125. (<-> (not true) nil)
126. (<-> (not nil) true)

Even for this, very first attempt, some interesting formulas
are derived. For example,

5.  (or true a)
11. (or a true)
19. (-> nil a)            lie implies anything
24. (-> a true)           anything implies truth
25. (-> a a)              reflexivity of implication
36. (<-> a a)             reflexivity of equivalence
45. (not (and nil a))
50. (not (and a nil))
70. (or a (not a))        (not a) is right inverse of a
88. (or (not a) a)        (not a) is left inverse of a

So, 10 interesting out of 126 tautologies. Not that bad. The first
tautology that is not interesting is 6. (or true b), because difference
in the name of the variable appears not to be significant enough.

Next thing to do is to filter tautologies and keep only those
that cannot be obtained from other tautologies by simple rename
of the variables.

Commenti:
---------
*** Anonymous 5 October 2009 at 19:22
I wonder if it's time for you to split up the 3000 line library into more than one file... ? I wanted to use debug-wrap, but kept on getting pages of tautologies.. :) And I couldn't work out how to suppress the printing...
cormullion

*** Kazimir Majorinc 5 October 2009 at 22:18
Cormullion,
maybe you're right but I prolong it, because my experience in the past was that it will only become more complicated if I'd have to take care about order of the load. Anycase, it appears to work for me (although version on the net lags behind things described on the blog).

(load "http://www.instprog.com/Instprog.default-library.lsp")
(debug-wrap fibo)
(fibo 4)

(set 'print.supressed true)
(print "supressed" " is " " it")
(set 'print.supressed false)
(print "isnt supressed" " this " " is")

(exit)

Note that print is now macro, hence it wouldn't work with (args) or $idx any more after my library is loaded.

If you find some relatively simple code where it doesn't work, please, post it to me.

Thank you for opinion.


-----------------------------------------
One Hundred Propositional Tautologies (2)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-2.html

;
; In previous, the first post of this serial, I simply defined few hundreds
; tautologies and checked whether they are tautologies. However,
; it was obvious that there are many of duplicates that differed
; only in using different variables. This time, we'll try to filter
; these tautologies, so these duplicated are rejected. First, we'll
; define the base of the formulas and tautologies.
;

(load "C:\\Newlisp\\Instprog.default-library.lsp")

(set 'formulas (append (all-pf 3 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))

                       (all-pf 4 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))

                       (all-pf 5 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))))

(println "We started with " (length formulas) ". formulas.")

(set 'tautologies (filter tautology? formulas))

(println "Filtered to " (length tautologies) ". tautologies.")

; I'll define the notion of the "prime tautology", in analogy to
; the prime numbers. Let us assume that tautologies are ordered
; in the list t1, t2, t3, ....

; the prime tautology is tautology that is not *an instance* of
; some other tautology that occured on the earlier place in the
; list.
;
; What does it mean that tautology (or more generally, the formula)
; f2 is "an instance" of other formula f1? Intuitively, that means
; that f2 is the special case of the more general formula f1. Just
; like in natural language, "London cathedral" is a special case of
; "Christian church."
;
; For example, (and (or x y) (not z)) is an instance of (and a b), because
; the substitution of a with (or x y), and b with (not z) will result in
; (and (or x y) z). Similarly, (or (and x y) (not z)) is not an instance
; of (and a b), because no substitution can transform that top level
; "and" into top-level "or."
;
; How can we check whether tautology t1 is instance of the tautology t2?
; First, because of technical reasons we should ensure that variables used
; in t1 are different than variables used in t2. Humans can understand
; that formula (or (not x) (not y)) is a special case of (or x y),
; because he'll understand that x and y are used in two different
; contexts, but with computers, this only complicates the issue.
;
; Because of that, we'll first change the form (or x y) into (or X Y),
; ie., we'll replace lowercase variables with uppercase.

(set 'upper-case-formula
     (lambda(f)
       (cond ((list? f)(map upper-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (upper-case (string f)))))))

; Now, we'll filter tautologies; we'll define another list, prime-tautologies,
; initially empty. Then, we'll take tautologies from the list, and
; check, one by one, whether these are instances of some of the
; formulas from prime-tautologies. If it is not, they will be
; added to prime tautologies.
;
; But, how can we check whether formula f is an instance of some
; other formula g? It would be the most complicated part. Fortunately,
; Newlisp has more general functions - unify. Unify doesn't test
; whether there is a substition s, such that f=s(g), but whether
; there is "unification" u, such that u(f)=u(g). During such test,
; unify will consider *only* symbols starting with upper case as variables.

(println (unify '(or (not x) (not y)) '(or X Y)))  ; ((X (not x)) (Y (not y)))
(println (unify '(or (not x) (not y)) '(and X Y))) ; nil

(set 'prime-tautologies '())
(dolist(f1 tautologies)
   (set 'composite nil)
   (dolist(f2 prime-tautologies composite)
      (if (unify f1 f2)
          (set 'composite true)))
   (when (not composite)
         (push (upper-case-formula f1) prime-tautologies -1)))

(println "Filtered to " (length tautologies) ". prime tautologies")

(map (lambda(x)(print $idx ". " x)) prime-tautologies)
(exit)

; RESULTS
;
; Now, this is pure beauty. All important formulas, if short enough
; are here. Among others, controversial (-> A (not (not A))) and
; (-> (not (not A)) A). I cannot, however, decide whether formulas
; containing only constants are interesting. Clearly, (not (not true))
; is interesting formula, but what with others? (not (not (not nil)))
; looks as less interesting, but why?

We started with 12957. formulas.
Filtered to 2465. tautologies.
Filtered to 348. prime tautologies
0. (not (not true))
1. (and true true)
2. (or true true)
3. (or true nil)
4. (or true A)
5. (or nil true)
6. (or A true)
7. (-> true true)
8. (-> nil true)
9. (-> nil nil)
10. (-> nil A)
11. (-> A true)
12. (-> A A)
13. (<-> true true)
14. (<-> nil nil)
15. (<-> A A)
16. (not (not (not nil)))
17. (not (and true nil))
18. (not (and nil true))
19. (not (and nil nil))
20. (not (and nil A))
21. (not (and A nil))
22. (not (or nil nil))
23. (not (-> true nil))
24. (not (<-> true nil))
25. (not (<-> nil true))
26. (and true (not nil))
27. (and (not nil) true)
28. (or nil (not nil))
29. (or A (not nil))
30. (or A (not A))
31. (or (not nil) nil)
32. (or (not nil) A)
33. (or (not A) A)
34. (-> true (not nil))
35. (-> A (not nil))
36. (-> (not true) nil)
37. (-> (not true) A)
38. (<-> true (not nil))
39. (<-> nil (not true))
40. (<-> (not true) nil)
41. (<-> (not nil) true)
42. (not (not (not (not true))))
43. (not (not (and true true)))
44. (not (not (or true true)))
45. (not (not (or true nil)))
46. (not (not (or true A)))
47. (not (not (or nil true)))
48. (not (not (or A true)))
49. (not (not (-> true true)))
50. (not (not (-> nil true)))
51. (not (not (-> nil nil)))
52. (not (not (-> nil A)))
53. (not (not (-> A true)))
54. (not (not (-> A A)))
55. (not (not (<-> true true)))
56. (not (not (<-> nil nil)))
57. (not (not (<-> A A)))
58. (not (and true (not true)))
59. (not (and A (not true)))
60. (not (and A (not A)))
61. (not (and (not true) true))
62. (not (and (not true) A))
63. (not (and (not A) A))
64. (not (or nil (not true)))
65. (not (or (not true) nil))
66. (not (-> true (not true)))
67. (not (-> (not nil) nil))
68. (not (<-> true (not true)))
69. (not (<-> nil (not nil)))
70. (not (<-> A (not A)))
71. (not (<-> (not true) true))
72. (not (<-> (not nil) nil))
73. (not (<-> (not A) A))
74. (and true (not (not true)))
75. (and true (and true true))
76. (and true (or true true))
77. (and true (or true nil))
78. (and true (or true A))
79. (and true (or nil true))
80. (and true (or A true))
81. (and true (-> true true))
82. (and true (-> nil true))
83. (and true (-> nil nil))
84. (and true (-> nil A))
85. (and true (-> A true))
86. (and true (-> A A))
87. (and true (<-> true true))
88. (and true (<-> nil nil))
89. (and true (<-> A A))
90. (and (not nil) (not nil))
91. (and (not (not true)) true)
92. (and (and true true) true)
93. (and (or true true) true)
94. (and (or true nil) true)
95. (and (or true A) true)
96. (and (or nil true) true)
97. (and (or A true) true)
98. (and (-> true true) true)
99. (and (-> nil true) true)
100. (and (-> nil nil) true)
101. (and (-> nil A) true)
102. (and (-> A true) true)
103. (and (-> A A) true)
104. (and (<-> true true) true)
105. (and (<-> nil nil) true)
106. (and (<-> A A) true)
107. (or nil (not (not true)))
108. (or nil (and true true))
109. (or nil (or true true))
110. (or nil (or true nil))
111. (or nil (or true A))
112. (or nil (or nil true))
113. (or nil (or A true))
114. (or nil (-> true true))
115. (or nil (-> nil true))
116. (or nil (-> nil nil))
117. (or nil (-> nil A))
118. (or nil (-> A true))
119. (or nil (-> A A))
120. (or nil (<-> true true))
121. (or nil (<-> nil nil))
122. (or nil (<-> A A))
123. (or A (not (not true)))
124. (or A (and true true))
125. (or A (or true true))
126. (or A (or true nil))
127. (or A (or true A))
128. (or A (or true B))
129. (or A (or nil true))
130. (or A (or A true))
131. (or A (or B true))
132. (or A (-> true true))
133. (or A (-> nil true))
134. (or A (-> nil nil))
135. (or A (-> nil A))
136. (or A (-> nil B))
137. (or A (-> A true))
138. (or A (-> A nil))
139. (or A (-> A A))
140. (or A (-> A B))
141. (or A (-> B true))
142. (or A (-> B B))
143. (or A (<-> true true))
144. (or A (<-> nil nil))
145. (or A (<-> nil A))
146. (or A (<-> A nil))
147. (or A (<-> A A))
148. (or A (<-> B B))
149. (or (not (not true)) nil)
150. (or (not (not true)) A)
151. (or (and true true) nil)
152. (or (and true true) A)
153. (or (or true true) nil)
154. (or (or true true) A)
155. (or (or true nil) nil)
156. (or (or true nil) A)
157. (or (or true A) nil)
158. (or (or true A) A)
159. (or (or true A) B)
160. (or (or nil true) nil)
161. (or (or nil true) A)
162. (or (or A true) nil)
163. (or (or A true) A)
164. (or (or A true) B)
165. (or (-> true true) nil)
166. (or (-> true true) A)
167. (or (-> nil true) nil)
168. (or (-> nil true) A)
169. (or (-> nil nil) nil)
170. (or (-> nil nil) A)
171. (or (-> nil A) nil)
172. (or (-> nil A) A)
173. (or (-> nil A) B)
174. (or (-> A true) nil)
175. (or (-> A true) A)
176. (or (-> A true) B)
177. (or (-> A nil) A)
178. (or (-> A A) nil)
179. (or (-> A A) A)
180. (or (-> A A) B)
181. (or (-> A B) A)
182. (or (<-> true true) nil)
183. (or (<-> true true) A)
184. (or (<-> nil nil) nil)
185. (or (<-> nil nil) A)
186. (or (<-> nil A) A)
187. (or (<-> A nil) A)
188. (or (<-> A A) nil)
189. (or (<-> A A) A)
190. (or (<-> A A) B)
191. (-> true (not (not true)))
192. (-> true (and true true))
193. (-> true (or true true))
194. (-> true (or true nil))
195. (-> true (or true A))
196. (-> true (or nil true))
197. (-> true (or A true))
198. (-> true (-> true true))
199. (-> true (-> nil true))
200. (-> true (-> nil nil))
201. (-> true (-> nil A))
202. (-> true (-> A true))
203. (-> true (-> A A))
204. (-> true (<-> true true))
205. (-> true (<-> nil nil))
206. (-> true (<-> A A))
207. (-> A (not (not true)))
208. (-> A (not (not A)))
209. (-> A (and true true))
210. (-> A (and true A))
211. (-> A (and A true))
212. (-> A (and A A))
213. (-> A (or true true))
214. (-> A (or true nil))
215. (-> A (or true A))
216. (-> A (or true B))
217. (-> A (or nil true))
218. (-> A (or nil A))
219. (-> A (or A true))
220. (-> A (or A nil))
221. (-> A (or A A))
222. (-> A (or A B))
223. (-> A (or B true))
224. (-> A (or B A))
225. (-> A (-> true true))
226. (-> A (-> true A))
227. (-> A (-> nil true))
228. (-> A (-> nil nil))
229. (-> A (-> nil A))
230. (-> A (-> nil B))
231. (-> A (-> A true))
232. (-> A (-> A A))
233. (-> A (-> B true))
234. (-> A (-> B A))
235. (-> A (-> B B))
236. (-> A (<-> true true))
237. (-> A (<-> true A))
238. (-> A (<-> nil nil))
239. (-> A (<-> A true))
240. (-> A (<-> A A))
241. (-> A (<-> B B))
242. (-> (not (not nil)) nil)
243. (-> (not (not nil)) A)
244. (-> (not (not A)) A)
245. (-> (and true nil) nil)
246. (-> (and true nil) A)
247. (-> (and true A) A)
248. (-> (and nil true) nil)
249. (-> (and nil true) A)
250. (-> (and nil nil) nil)
251. (-> (and nil nil) A)
252. (-> (and nil A) nil)
253. (-> (and nil A) A)
254. (-> (and nil A) B)
255. (-> (and A true) A)
256. (-> (and A nil) nil)
257. (-> (and A nil) A)
258. (-> (and A nil) B)
259. (-> (and A A) A)
260. (-> (and A B) A)
261. (-> (and A B) B)
262. (-> (or nil nil) nil)
263. (-> (or nil nil) A)
264. (-> (or nil A) A)
265. (-> (or A nil) A)
266. (-> (or A A) A)
267. (-> (-> true nil) nil)
268. (-> (-> true nil) A)
269. (-> (-> true A) A)
270. (-> (<-> true nil) nil)
271. (-> (<-> true nil) A)
272. (-> (<-> true A) A)
273. (-> (<-> nil true) nil)
274. (-> (<-> nil true) A)
275. (-> (<-> A true) A)
276. (<-> true (not (not true)))
277. (<-> true (and true true))
278. (<-> true (or true true))
279. (<-> true (or true nil))
280. (<-> true (or true A))
281. (<-> true (or nil true))
282. (<-> true (or A true))
283. (<-> true (-> true true))
284. (<-> true (-> nil true))
285. (<-> true (-> nil nil))
286. (<-> true (-> nil A))
287. (<-> true (-> A true))
288. (<-> true (-> A A))
289. (<-> true (<-> true true))
290. (<-> true (<-> nil nil))
291. (<-> true (<-> A A))
292. (<-> nil (not (not nil)))
293. (<-> nil (and true nil))
294. (<-> nil (and nil true))
295. (<-> nil (and nil nil))
296. (<-> nil (and nil A))
297. (<-> nil (and A nil))
298. (<-> nil (or nil nil))
299. (<-> nil (-> true nil))
300. (<-> nil (<-> true nil))
301. (<-> nil (<-> nil true))
302. (<-> A (not (not A)))
303. (<-> A (and true A))
304. (<-> A (and A true))
305. (<-> A (and A A))
306. (<-> A (or nil A))
307. (<-> A (or A nil))
308. (<-> A (or A A))
309. (<-> A (-> true A))
310. (<-> A (<-> true A))
311. (<-> A (<-> A true))
312. (<-> (not (not true)) true)
313. (<-> (not (not nil)) nil)
314. (<-> (not (not A)) A)
315. (<-> (and true true) true)
316. (<-> (and true nil) nil)
317. (<-> (and true A) A)
318. (<-> (and nil true) nil)
319. (<-> (and nil nil) nil)
320. (<-> (and nil A) nil)
321. (<-> (and A true) A)
322. (<-> (and A nil) nil)
323. (<-> (and A A) A)
324. (<-> (or true true) true)
325. (<-> (or true nil) true)
326. (<-> (or true A) true)
327. (<-> (or nil true) true)
328. (<-> (or nil nil) nil)
329. (<-> (or nil A) A)
330. (<-> (or A true) true)
331. (<-> (or A nil) A)
332. (<-> (or A A) A)
333. (<-> (-> true true) true)
334. (<-> (-> true nil) nil)
335. (<-> (-> true A) A)
336. (<-> (-> nil true) true)
337. (<-> (-> nil nil) true)
338. (<-> (-> nil A) true)
339. (<-> (-> A true) true)
340. (<-> (-> A A) true)
341. (<-> (<-> true true) true)
342. (<-> (<-> true nil) nil)
343. (<-> (<-> true A) A)
344. (<-> (<-> nil true) nil)
345. (<-> (<-> nil nil) true)
346. (<-> (<-> A true) A)
347. (<-> (<-> A A) true)

Commenti:
---------
*** dasuxullebt 13 October 2009 at 16:33
Why do you have <-> and ->. You wouldnt need both if you have -> and "and". In classical logic, you can also omit "and" by defining (and a b) by (-> (a -> (b -> nil))).

*** Kazimir Majorinc 13 October 2009 at 17:27
You are right. However, my intention is not to reduce number of existing logical operators and simplify expressions, but to try to derive expressions meaningful for people. Possibly to get some idea why some of these are meaningful.

Many logical systems have <->, and mathematicians use "if and only if" frequently, so probably there is something about that. Density of information, I guess, because

      (a <-> b)

is significantly shorter than

      (and (a -> b) (b -> a)).

Thanx on comment, come again.


-------------------------------------------------------------------
Opinions on Eval in Lisp, Python and Ruby - The Results of The Poll
-------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/opinions-on-eval-in-lisp-python-and.html

During September 2009, I made three polls with question "what do you think about eval?" for Lisp, Python and Ruby programmers separately. In total, there were 104 votes, between 30-40 for each language. Here are the results, graph and interpretations:

.                                                  Lisp          %     Python          %       Ruby          %
--------------------------------------------------------------------------------------------------------------
Eval is evil, harmful or at least unnecessary         2        4.9          7       21.9          0        0.0
Eval is useful but overused                          11       26.8          6       18.8          9       29.0
Eval has just the right place                        16       39.0         10       31.3         19       61.3
Eval is useful but neglected                          3        7.3          4       12.5          1        3.2
Eval is a single most important feature               5       12.2          0        0.0          0        0.0
I do not care for eval                                4        9.8          5       15.6          2        6.5
--------------------------------------------------------------------------------------------------------------
Total                                                41      100.0         32      100.0         31      100.0

Nota: Vedi il grafico "eval-graph.png" nella cartella "data".
(Those who voted they do not care about eval are ignored on graph.)

Great majority of Ruby programmers are satisfied with eval, and significant minority believe that eval is useful but overused. That means that Ruby designer should slightly discourage use of eval, or Ruby community should discuss the issue to reach understanding why and how not to use eval, or why use of eval is justified. Rubyists are not extremists - no one has extreme opinion, and it suggests that they have good capacity for cooperation - at least from the point of view of this, single aspect - which is not unimportant, since recently Ruby is frequently discussed in connection with metaprogramming.

The difference between Python programmers is more significant; majority of them think that eval has the right place in Python, and nearly equal number think that it is overused or neglected. However, large number of Python programmers believe that "eval is evil." Such a large group with extreme opinion suggests that Python community might separate in future on the group that wants Python to be more static, probably compiled - and others. Or, one group will prevail, and others will leave.

In Lisp community, it is exactly opposite: almost 15% Lisp programmers think that eval is essential, and about 5% think eval is evil. It is somehow strange that more Lispers than Rubyists are extremely against eval. Both extremes are significant, and it guarantees consistent disagreements and discussions on the topic. That means, community cannot be united - and it is not united, of course. Even in this single issue, fragmentation of Lisp community is justified.

Another possibility is that some Lisp programmers are not attracted by technical merits of the language, but by its allure - result of Lisp's long history, romantic AI past, and compliments given by programmers - celebrities like Yukihiro Matsumoto, Eric S. Raymond, Alan Kay, Paul Graham, Richard Stallman, Gregory Chaitin. However, I believe that those who do not like the language itself, especially its syntax, give up very early.

Comments are welcome.


------------------------------------------------
Why You Do Not Use Lisp? The Results of The Poll
------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/why-you-do-not-use-lisp-results-of-poll.html

0. Introduction

During early October 2009, I conducted the poll with question "Why you do not use Lisp?" on this blog. The poll was announced on related Usenet newsgroups comp.lang.lisp, comp.lang.programming, comp.lang.functional, and also on popular social sites Reddit and Digg.

Thirteen reasons were offered. It was specified that even people who use Lisp part of the time can answer why they do not use it in other part of the time. Lisp in this context means all Lisp dialects; and it was also specified. Multiple answers were allowed.

1. Results

I use Lisp, at least sometimes. 49 (44%)
It has not enough support for modern programming practice (libraries, threads and similar.) 42 (37%)
Its syntax repulses me. 26 (23%)
It is socially inadequate (small, not very alive community.)  23 (20%)
It doesn't have any technical advantage I might want. 20 (18%)
Its IDE is not good enough. 18 (16%)
I'd like to use Lisp, but my superiors or colleagues do not want that.  15 (13%)
It has not enough support for higher level programming (laziness, logic programming...) 15 (13%)
It is socially inadequate (arrogant, unhelping community.)  14 (12%)
It is too slow or bloated.  12 (10%)
It has attractive technical advantages, but these are hard to learn, use and not worth effort.  11 (9%)
It is OK, but only in some commercial version - and I want free or much cheaper one.  10 (9%)
It is so marginal that I never considered it. 9 (8%)

2. Comments

Presented on this way, it is not easy to recognize the message of the poll. All answers are expected, but what their relative importance means? However, I believe we can filter out important information, if we take into account two things: first, voters have much higher than average interest in Lisp and functional or metaprogramming than usually. Those who do not care for Lisp didn't care to vote on this poll as well. About 13% of voters would like to use Lisp, but they cannot because other their colleagues and bosses do not allow it. This is surprisingly low number of people - whatever your favourite language, the chance that your boss will prefer something else is large. If anything can be concluded it is that majority of Lispers somehow managed to group together or work on their own.

Lot of voters (37%) miss some libraries, or support for some modern feature. However, it doesn't say us much: lack of the libraries is universal phenomenon. I believe many people would say they do not use some mainstream language, say, Python because they've found that Ruby, Java or Perl have some specific library supported better. Second, this reason is somehow circular - less libraries means less users etc. Taking it into account, even if Lisp community wrote libraries as no one did, the result wouldn't be much better. It would be much better regarding libraries, but not much regarding programmers. Many of these who complain about lack of libraries probably already use Lisp part of the time.

The second reason is much stronger: 23% of voters do not like Lisp syntax. I incline to think that very few people who do not like Lisp syntax use Lisp on the first place. So, almost the half of the voters who do not use Lisp (56%) - on this poll - do that because of the syntax. If we assume that interest of the voters for Lisp is above average, we can safely say that Lisp syntax is the most important reason for majority of people who do not use Lisp.

One surprise, for me, is popularity of the answers "Lisp doesn't have any technical advantage I may want." (18%) "it has not enough support for higher level programming" (and it includes static typing) (13%) and "It has attractive technical advantages, but these are hard to learn, use and not worth effort" (9%) we have another revealing information - Lisp community didn't succeeded to develop or demonstrate technical advantages of Lisp. Functional languages programmers certainly understand these advantages, but they still think these are not that significant.

Good news is that Lisp got rid of its image as bloated and slow. Only 10% of voters complained about that. For, say, Modula-2, even that would be too much, but for Lisp family, which is certainly not designed to be among the leanest possible languages, the result is quite good.

Social inadequacy, i.e. small, not very alive community - rates surprisingly high (20%). I had no clue that people like to communicate that much. One might think that large community means lot of libraries. It does - but it still doesn't mean that voter will get the library he wants. So, it is, I believe, more of a human instinct for joining large, progressing, vibrant, active community, perhaps related to survival. Well, good information for all Lisp programmers and especially my Newlisp fellows; communication matters. On a related matter, significant number of voters (12%) believe that Lisp users are arrogant and unhelpful community.

Some 16% of voters missed good IDE. Well, two commercial Common Lisps have good IDE, and have free personal versions. PLT Scheme has nice IDE as well. Newlisp has very simple IDE. Personally I use Scite, which is text editor that can cooperate with command line tools easily, and it is good enough for me. About 9% of voters miss something in free versions, and it can be easily that it is again IDE.

Another poll that might interest you:

 Opinions on Eval in Lisp, Python and Ruby. The Results of The Poll.

Commenti:
---------
*** Anonymous 21 October 2009 at 16:14
did voters have to pick one answer or could they give various weights adding up to 100 pts?

*** Kazimir Majorinc 21 October 2009 at 17:01
The voters could pick as many answer as they want of listed 13. There was no weighting. Total number of answers is 264, that means voters chosen 2.4 answers on average.

*** Jacques Mattheij 21 October 2009 at 18:15
Hey Kazimir,
Thank you for an excellent post, some of the results were quite different than what I expected and that's why polls like this are interesting (after all, if the result is what you expected you learned, but not as much).
best regards,
Jacques

*** John F. Miller 23 October 2009 at 19:29
I would like to nuance your view of community and in paricular the "It has attractive technical advantages, but these are hard to learn..." answer. The Lisp community has tended to self-select towards formally eductated programmers who have, by the time they become lisp enthusiasts, already written their own lisp interpreter, etc. I spent my time in college studying physics and learning C. I now program in Ruby. I know that there are some amazing things one can do with lisp, but no one has ever presented me with a good tutorial on how to do them. There are lots of good resources on how lisp works, but this is like learning the rules of Chess, but never learning any stratagity. One ends up just pushing pieces randomly and loosing a lot. Once I learn the syntac, then what?

Rather then more of "How lisp works" I would like to see more "Using lisp to do really cool things"

*** Anonymous 9 March 2011 at 08:32
To my is simple, the mayor part of programmers are autodidacts who learned in books like Java for dummies.
Other important part with high education (BS. MS. ..) learn in courses based on structured programing inherited from numerical methods with fortran or pascal, but using newer languages like java.
Lisp is mainly learned by computer scientist, not always as a first language. One program in a language where one feels comfortable and productive.
Just very few learn to be productive with languages like lisp, scheme, haskell, ml, prolog, curry, etc.
That requires better education, more theoretical computer science oriented. A very small subset of programmers.

*** Agnius Vasiliauskas 28 November 2011 at 23:12
I think LISP suffers from the same illness as "pure" functional languages suffers - for the practical reasons they are MOST useful in scientific-related problem area - area which is mostly un-populated by the so called "mainstream" (industry) developers [C/C++,C#,JAVA,etc.]. There may be some data-centric uses with LISP/ Ocaml/etc. in the world of auto-trading software systems, but again in mission critical auto-trade tasks, C/C++ will be chosen because of speed issues (sometimes even linux kernel may be modified for lowering system latency). That is to say LISP/ML/other FP are cool languages, but in essence only for prototyping of some problems where BIG amount of fast prototyping is needed. And this is not the case of what 99,99% of industry developers day job consists. Maybe that is the reason why LISP didn't departure from the academics "airport"... Good luck.

*** Anonymous 2 February 2012 at 06:08
"Social inadequacy, i.e. small, not very alive community - rates surprisingly high (20%). I had no clue that people like to communicate that much."

Is that a joke? The sole reason of civilization is communicating.

Even survival is secondary. People with ample food but isolated, more likely to end up killing themselves.

But this is not exactly it in this case (see below):

"One might think that large community means lot of libraries. It does - but it still doesn't mean that voter will get the library he wants. So, it is, I believe, more of a human instinct for joining large, progressing, vibrant, active community, perhaps related to survival."

Isn't it obvious what it means?

Lot's of libraries.
MORE likely to get the library I want.
Lot's of JOBS.
Lot's of BOOKS and material on the language.
Lot's of FORUMS where I can find questions to my problems.
Lot's of TOOLING for the language.
Lot's of commercial support.
...

Anonymous2 February 2012 at 06:09
Plus:
More PROGRESS in the language and compiler development.

*** Preston L. Bannister 25 March 2012 at 17:12
I used Lisp quite a bit in school (UCI Lisp in the late 1970's) - a definite gain. At the time, Lisp was too fat for a lot of domains. Later, Lisp was either unfamiliar, or freaked out my coworkers. A programming language is not just for communicating with a computer, but also with coworkers. If I wrote code in Lisp, my coworkers would be entirely lost - not good.

Lisp is not good to use with (most) coworkers.

.... perhaps the above item should be on your survey. :-)

*** Kazimir Majorinc25 March 2012 at 21:09
You're right, Preston. It is especially true for people who do not program full time, for example, scientists and engineers.

*** Anonymous 13 January 2013 at 03:22
One thing I don't like about Lisp, especially Common Lisp, is that the language is not really evolving. Getting the Ansi process done wore out some of the best minds behind the language or something. And there is a lot of kruft laying about that is obsolete and a lot of simple things that are just not covered. But good luck getting anyone to seriously consider revving the spec. Part of that is for Lispers rolling your own way to bypass the ugly parts is pretty easy. But then you see how long a nice book like Practical Common Lisp fooled around just to handle file system directories without being bogged down in concerns that are part of Ansi Common Lisp that are no longer particularly relevant.


-----------------------------------------
One Hundred Propositional Tautologies (3)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-3.html

; By closer inspection of "prime tautologies" from my article
; `One hundred propositional tautologies (2)´, I noted that some of them are like

;                     (not (not (or true true)))

; It contains subformula (or true true), which is an instance of
; tautology

;                          (or true A).

; Hence, this formula doesn't say nothing new, but (not (not true)).
; and it should be removed from list of interesting tautologies.
; Generally, formula that has tautology as subformula (eccept
; trivial case - formula "true") is not interesting one. So, I
; decided to add one loop that will filter out such formulas from
; the list of 100 propositional tautologies, originally stored in
; prime-tautologies 1.

; The helper function, (lower-case-formula f) returns same formula as
; f, just  with all upper-case symbols changed to lower case. I need
; it because lower case is used as constant in unify.

; Helper function

(set 'lower-case-formula
     (lambda(f)
       (cond ((list? f)(map lower-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (lower-case (string f)))))))

(set 'prime-tautologies1 (map lower-case-formula prime-tautologies1)) ; lower case - constants
(set 'prime-tautologies2 '())

(dolist(f1 prime-tautologies1)
  (set 'found-instance nil)
  (dolist(f2 prime-tautologies2 found-instance)
     (dolist(f3 (branches f1) found-instance)
        (unless(= f3 true)      ; othervise every subformula true
                                ; would be recognized as a special case.
         (when (unify f3 f2)
               (set 'found-instance true)
               (println "formula " f1 ", subformula " f3 " is instance of " f2 ")" )))))

  (unless found-instance
          (push (upper-case-formula f1) prime-tautologies2 -1)))

(println "Filtered to " (length prime-tautologies2) ". prime tautologies2")
(map (lambda(x)(println $idx ". " x)) prime-tautologies2)

; Output:

; We started with 12971 formulas.
; Filtered to 2467 tautologies.
; Filtered to 350. prime tautologies1
;
; formula (not (not (or true true))), subformula (or true true) is instance of (or true A))
; formula (not (not (or true nil))), subformula (or true nil) is instance of (or true A))
; ...
; Filtered to 178. prime tautologies2
;
; 0. true
; 1. (not nil)
; 2. (not (not true))
; 3. (and true true)
; 4. (or true true)
; 5. (or true nil)
; 6. (or true A)
; 7. (or nil true)
; 8. (or A true)
; 9. (-> true true)
; 10. (-> nil true)
; 11. (-> nil nil)
; 12. (-> nil A)
; 13. (-> A true)
; 14. (-> A A)
; 15. (<-> true true)
; 16. (<-> nil nil)
; 17. (<-> A A)
; 18. (not (not (not nil)))
; 19. (not (and true nil))
; 20. (not (and nil true))
; 21. (not (and nil nil))
; 22. (not (and nil A))
; 23. (not (and A nil))
; 24. (not (or nil nil))
; 25. (not (-> true nil))
; 26. (not (<-> true nil))
; 27. (not (<-> nil true))
; 28. (and true (not nil))
; 29. (and (not nil) true)
; 30. (or nil (not nil))
; 31. (or A (not nil))
; 32. (or A (not A))
; 33. (or (not nil) nil)
; 34. (or (not nil) A)
; 35. (or (not A) A)
; 36. (-> true (not nil))
; 37. (-> A (not nil))
; 38. (-> (not true) nil)
; 39. (-> (not true) A)
; 40. (<-> true (not nil))
; 41. (<-> nil (not true))
; 42. (<-> (not true) nil)
; 43. (<-> (not nil) true)
; 44. (not (not (not (not true))))
; 45. (not (not (and true true)))
; 46. (not (and true (not true)))
; 47. (not (and A (not true)))
; 48. (not (and A (not A)))
; 49. (not (and (not true) true))
; 50. (not (and (not true) A))
; 51. (not (and (not A) A))
; 52. (not (or nil (not true)))
; 53. (not (or (not true) nil))
; 54. (not (-> true (not true)))
; 55. (not (-> (not nil) nil))
; 56. (not (<-> true (not true)))
; 57. (not (<-> nil (not nil)))
; 58. (not (<-> A (not A)))
; 59. (not (<-> (not true) true))
; 60. (not (<-> (not nil) nil))
; 61. (not (<-> (not A) A))
; 62. (and true (not (not true)))
; 63. (and true (and true true))
; 64. (and (not nil) (not nil))
; 65. (and (not (not true)) true)
; 66. (and (and true true) true)
; 67. (or nil (not (not true)))
; 68. (or nil (and true true))
; 69. (or A (not (not true)))
; 70. (or A (and true true))
; 71. (or A (-> A nil))
; 72. (or A (-> A B))
; 73. (or A (<-> nil A))
; 74. (or A (<-> A nil))
; 75. (or (not (not true)) nil)
; 76. (or (not (not true)) A)
; 77. (or (and true true) nil)
; 78. (or (and true true) A)
; 79. (or (-> A nil) A)
; 80. (or (-> A B) A)
; 81. (or (<-> nil A) A)
; 82. (or (<-> A nil) A)
; 83. (-> true (not (not true)))
; 84. (-> true (and true true))
; 85. (-> A (not (not true)))
; 86. (-> A (not (not A)))
; 87. (-> A (and true true))
; 88. (-> A (and true A))
; 89. (-> A (and A true))
; 90. (-> A (and A A))
; 91. (-> A (or nil A))
; 92. (-> A (or A nil))
; 93. (-> A (or A A))
; 94. (-> A (or A B))
; 95. (-> A (or B A))
; 96. (-> A (-> true A))
; 97. (-> A (-> B A))
; 98. (-> A (<-> true A))
; 99. (-> A (<-> A true))
; 100. (-> (not (not nil)) nil)
; 101. (-> (not (not nil)) A)
; 102. (-> (not (not A)) A)
; 103. (-> (and true nil) nil)
; 104. (-> (and true nil) A)
; 105. (-> (and true A) A)
; 106. (-> (and nil true) nil)
; 107. (-> (and nil true) A)
; 108. (-> (and nil nil) nil)
; 109. (-> (and nil nil) A)
; 110. (-> (and nil A) nil)
; 111. (-> (and nil A) A)
; 112. (-> (and nil A) B)
; 113. (-> (and A true) A)
; 114. (-> (and A nil) nil)
; 115. (-> (and A nil) A)
; 116. (-> (and A nil) B)
; 117. (-> (and A A) A)
; 118. (-> (and A B) A)
; 119. (-> (and A B) B)
; 120. (-> (or nil nil) nil)
; 121. (-> (or nil nil) A)
; 122. (-> (or nil A) A)
; 123. (-> (or A nil) A)
; 124. (-> (or A A) A)
; 125. (-> (-> true nil) nil)
; 126. (-> (-> true nil) A)
; 127. (-> (-> true A) A)
; 128. (-> (<-> true nil) nil)
; 129. (-> (<-> true nil) A)
; 130. (-> (<-> true A) A)
; 131. (-> (<-> nil true) nil)
; 132. (-> (<-> nil true) A)
; 133. (-> (<-> A true) A)
; 134. (<-> true (not (not true)))
; 135. (<-> true (and true true))
; 136. (<-> nil (not (not nil)))
; 137. (<-> nil (and true nil))
; 138. (<-> nil (and nil true))
; 139. (<-> nil (and nil nil))
; 140. (<-> nil (and nil A))
; 141. (<-> nil (and A nil))
; 142. (<-> nil (or nil nil))
; 143. (<-> nil (-> true nil))
; 144. (<-> nil (<-> true nil))
; 145. (<-> nil (<-> nil true))
; 146. (<-> A (not (not A)))
; 147. (<-> A (and true A))
; 148. (<-> A (and A true))
; 149. (<-> A (and A A))
; 150. (<-> A (or nil A))
; 151. (<-> A (or A nil))
; 152. (<-> A (or A A))
; 153. (<-> A (-> true A))
; 154. (<-> A (<-> true A))
; 155. (<-> A (<-> A true))
; 156. (<-> (not (not true)) true)
; 157. (<-> (not (not nil)) nil)
; 158. (<-> (not (not A)) A)
; 159. (<-> (and true true) true)
; 160. (<-> (and true nil) nil)
; 161. (<-> (and true A) A)
; 162. (<-> (and nil true) nil)
; 163. (<-> (and nil nil) nil)
; 164. (<-> (and nil A) nil)
; 165. (<-> (and A true) A)
; 166. (<-> (and A nil) nil)
; 167. (<-> (and A A) A)
; 168. (<-> (or nil nil) nil)
; 169. (<-> (or nil A) A)
; 170. (<-> (or A nil) A)
; 171. (<-> (or A A) A)
; 172. (<-> (-> true nil) nil)
; 173. (<-> (-> true A) A)
; 174. (<-> (<-> true nil) nil)
; 175. (<-> (<-> true A) A)
; 176. (<-> (<-> nil true) nil)
; 177. (<-> (<-> A true) A)


-----------------------------------------
One Hundred Propositional Tautologies (4)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-4.html

; In list of the propositional tautologies from the last article
; in this series, I have found another redundancy. For example,
; both (or true nil) and (or true A) are still in the 100 formulas,
; although (or true nil) is special case of (or true A).

; How it happened? (or true A) is discovered after
; (or true nil). So, tests confirmed that (or true A) is not the instance
; of any tautology, but (or true nil) suddenly became the instance.
; of later developed theorem. And what now?

; (or true nil) becomes some kind of a formula for museum. In time it
; was discovered, it was interesting enough, but now - it cannot
; be effectively used any more in future development. So, what to
; do with that? I'll build special list, and call it museum. OK,
; I could use the word "archive", but this word is somehow overloaded,
; so I'll use museum.
;
; Then, I'll change the program on this way: first,
;
;    (1) it generates all propositional formulas of a given length,
;        making a list PF.
;
;    (2) it filters out tautologies - and makes the list T1
;
;    (3) one by one, it passes through tautologies in T1 and tests
;        whether some of them are instances of other, previously
;        developed tautologies in T1. More than that, it tests
;        whether some of the subformulas of tautologies is an
;        instance of the previously developed tautologies. Only
;        those tautologies, proved not to be an instances are
;        inserted in new list T2.
;
;    (4) Some of the formulas from T2 are "obsolete", because
;        some of the tautologies generated later are more general
;        - more general in a sense - older formula is and instance
;        - of new formula, or some subformula of the older formula
;        is an instance of a newer formula. These formulas are
;        moved to "museum", I'll name it M2.

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set 'PF (apply append (map (lambda(x)(all-pf x '(true nil a b c d e)
                                                '(not)
                                                '(and or -> <->)))
                            (sequence 1 5))))

(println "Generated " (length PF) " formulas.")

(set 'T1 (filter tautology? PF))

(println "Filtered to " (length T1) " tautologies in T1.")

(set 'T2 (list))
(dolist(f1 T1)
   (set 'is-instance nil)
   (dolist(f2 T2 is-instance)
      (let((uf2 (upper-case-formula f2)))
          (dolist (sf1 (difference (branches f1) booleans) is-instance)
            (set 'u (unify sf1 uf2))
            (when (or u (= u '()))
                  (set 'is-instance true)))))
    (unless is-instance
            (push f1 T2 -1)))

(println "Filtered to " (length T2) " tautologies in T2.")

(set 'T2 (reverse T2))
(set 'T3 (list))
(set 'M3 (list))

(dolist(f1 T2)
   (set 'f1counter $idx)
   (set 'is-instance nil)
   (dolist(f2 T2)
     (when (> f1counter $idx)
        (let((uf2 (upper-case-formula f2)))
          (dolist (sf1 (difference (branches f1) booleans) is-instance)
            (set 'u (unify sf1 uf2))
            (when (or u (= u '()))
                  ;(println "--- " f1counter " ---")
                  ;(println=  "\nInstance discovered: \n" f1 "\n" sf1 "\n" uf2)
                  (set 'is-instance true))))))
   (if is-instance (push f1 M3)
                   (push f1 T3)))

(println "Filtered to " (length T3) " tautologies in T3 and "
                        (length M3) " tautologies in M3.")

(println "\n\n\n*** T3 ***\n")
(map (lambda(x)(println (+ $idx 1) ". " x)) T3)

(println "\n\n\n*** M3 ***\n")
(map (lambda(x)(println (+ $idx 1) ". " x)) M3)

(exit)

;---------------------------------------------------------------
; OUTPUT

Generated 12971 formulas.
Filtered to 2467 tautologies in T1.
Filtered to 137 tautologies in T2.
Filtered to 84 tautologies in T3 and 53 tautologies in M3.

*** T3 ***

1. true
2. (not nil)
3. (not (not true))
4. (and true true)
5. (or true a)
6. (or a true)
7. (-> nil a)
8. (-> a true)
9. (-> a a)
10. (<-> a a)
11. (not (and nil a))
12. (not (and a nil))
13. (not (or nil nil))
14. (not (-> true nil))
15. (not (<-> true nil))
16. (not (<-> nil true))
17. (or a (not a))
18. (or (not a) a)
19. (-> (not true) a)
20. (<-> nil (not true))
21. (<-> (not true) nil)
22. (not (and a (not true)))
23. (not (and a (not a)))
24. (not (and (not true) a))
25. (not (and (not a) a))
26. (not (or nil (not true)))
27. (not (or (not true) nil))
28. (not (-> true (not true)))
29. (not (<-> a (not a)))
30. (not (<-> (not a) a))
31. (or a (-> a b))
32. (or a (<-> nil a))
33. (or a (<-> a nil))
34. (or (-> a b) a)
35. (or (<-> nil a) a)
36. (or (<-> a nil) a)
37. (-> a (not (not a)))
38. (-> a (and true a))
39. (-> a (and a true))
40. (-> a (and a a))
41. (-> a (or a b))
42. (-> a (or b a))
43. (-> a (-> b a))
44. (-> a (<-> true a))
45. (-> a (<-> a true))
46. (-> (not (not a)) a)
47. (-> (and nil a) b)
48. (-> (and a nil) b)
49. (-> (and a b) a)
50. (-> (and a b) b)
51. (-> (or nil nil) a)
52. (-> (or nil a) a)
53. (-> (or a nil) a)
54. (-> (or a a) a)
55. (-> (-> true nil) a)
56. (-> (-> true a) a)
57. (-> (<-> true nil) a)
58. (-> (<-> true a) a)
59. (-> (<-> nil true) a)
60. (-> (<-> a true) a)
61. (<-> nil (and nil a))
62. (<-> nil (and a nil))
63. (<-> a (not (not a)))
64. (<-> a (and true a))
65. (<-> a (and a true))
66. (<-> a (and a a))
67. (<-> a (or nil a))
68. (<-> a (or a nil))
69. (<-> a (or a a))
70. (<-> a (-> true a))
71. (<-> a (<-> true a))
72. (<-> a (<-> a true))
73. (<-> (not (not a)) a)
74. (<-> (and true a) a)
75. (<-> (and nil a) nil)
76. (<-> (and a true) a)
77. (<-> (and a nil) nil)
78. (<-> (and a a) a)
79. (<-> (or nil a) a)
80. (<-> (or a nil) a)
81. (<-> (or a a) a)
82. (<-> (-> true a) a)
83. (<-> (<-> true a) a)
84. (<-> (<-> a true) a)

*** M3 ***

1. (or true true)
2. (or true nil)
3. (or nil true)
4. (-> true true)
5. (-> nil true)
6. (-> nil nil)
7. (<-> true true)
8. (<-> nil nil)
9. (not (and true nil))
10. (not (and nil true))
11. (not (and nil nil))
12. (-> (not true) nil)
13. (not (and true (not true)))
14. (not (and (not true) true))
15. (not (<-> true (not true)))
16. (not (<-> (not true) true))
17. (or a (-> a nil))
18. (or (-> a nil) a)
19. (-> a (or nil a))
20. (-> a (or a nil))
21. (-> a (or a a))
22. (-> a (-> true a))
23. (-> (and true nil) nil)
24. (-> (and true nil) a)
25. (-> (and true a) a)
26. (-> (and nil true) nil)
27. (-> (and nil true) a)
28. (-> (and nil nil) nil)
29. (-> (and nil nil) a)
30. (-> (and nil a) nil)
31. (-> (and nil a) a)
32. (-> (and a true) a)
33. (-> (and a nil) nil)
34. (-> (and a nil) a)
35. (-> (and a a) a)
36. (-> (or nil nil) nil)
37. (-> (-> true nil) nil)
38. (-> (<-> true nil) nil)
39. (-> (<-> nil true) nil)
40. (<-> nil (and true nil))
41. (<-> nil (and nil true))
42. (<-> nil (and nil nil))
43. (<-> nil (or nil nil))
44. (<-> nil (-> true nil))
45. (<-> nil (<-> true nil))
46. (<-> nil (<-> nil true))
47. (<-> (and true nil) nil)
48. (<-> (and nil true) nil)
49. (<-> (and nil nil) nil)
50. (<-> (or nil nil) nil)
51. (<-> (-> true nil) nil)
52. (<-> (<-> true nil) nil)
53. (<-> (<-> nil true) nil)


-----------------------------------------
One Hundred Propositional Tautologies (5)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-5.html

The same like last post, but this time 1500 tautologies, and
these are in the infix form. It is very easy to change prefix
into infix in Newlisp. And vice versa - same function can be
used for changing infix to prefix. But, tautologies are great.

(set 'infix<->prefix
  (lambda(L)
    (cond ((symbol? L) L)
          ((= (length L) 2) (map infix<->prefix L))
          ((= (length L) 3) (let((L1 (map infix<->prefix L)))
                                (list (nth 1 L1) (nth 0 L1) (nth 2 L1)))))))

Generated 1005725 formulas.
Filtered to 187105 tautologies in T1.
Filtered to 2730 tautologies in T2.
Filtered to 1581 tautologies in T3 and 1149 tautologies in M3.

Per l'output vedi il file "tautologie.txt" nella cartella "data".


---------
Tortelvis
---------
http://kazimirmajorinc.blogspot.com/2009/11/tortelvis.html

What the Heck is Tortelvis?

Tortelvis is agile 130 kg strong Elvis impersonator singer of Dread Zeppelin,
the band that plays Led Zeppelin covers in a reggae style. Definitely
fascinating. But, sometimes, you do not want the copy, you want the real thing.
Look here:
> (set 'L (list 1 2 3))
(1 2 3)
> (set 'push-right (lambda(a b)(push a b -1)))
(lambda (a b) (push a b -1))
> (push-right 4 L)
(1 2 3 4)
> L
(1 2 3)

Did you expected (1 2 3 4)? Well, Newlisp is sometimes too functional. This
time it passed copy of L to the push-right. OK, we'll fix it now.

> (set 'push-right (lambda-macro(a b)(eval (expand '(push a b -1) 'a 'b))))
(lambda-macro (a b) (eval (expand '(push a b -1) 'a 'b)))
> (push-right 5 L)
(1 2 3 5)
> L
(1 2 3 5)

Commenti:
---------
Anonymous10 November 2009 at 17:51
Is it not easier this way:

(set 'push-right (lambda-macro (a b) (push (eval a) (eval b) -1 )))

and safer:

(define (push-right a b) (push a b -1))
(set 'L:L '(1 2 3)
(push 4 L)
L:L -> '(1 2 3 4)

*** Anonymous 10 November 2009 at 17:52
correction:

(push-right 4 L)
L:L -> '(1 2 3 4)

*** Kazimir Majorinc 10 November 2009 at 18:42
Let me see, yes, you're right - the first is easier and the second is safer.


----------------------------------------------------------------------------------
Relatively Short Propositional Formulas and Symbols Instead of Pointers and Tables
----------------------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/11/relatively-short-propositional-formulas.html

; Boolean functions are functions from set {0, 1} to set {0, 1}.
; Our well known logical connectives and, or and not are such
; Boolean functions. In usual mathematical notation, it would be
; written:
;
;         or(0,0)=0; or(0,1)=1; or(1,0)=1; or(1,1)=1.
;
; Frequently, Booleans functions are defined in the form of the
; "truth-table".
;
;                   a  b (or a b)
;                  ---------------
;                   0  0    0
;                   0  1    1
;                   1  0    1
;                   1  1    1
;
; Boolean function is determined by third column, in this case,
; 0111. For each Boolean function, there are many possible formulas
; that define the function. In our example (or a b), but also
; (not (and a b)), (and (not a) (not b)), (-> (not a) b), and
; many others. Boolean functions and propositional formulas are very
; important, because computers are machines that calculate boolean
; functions, using physical realization of proposition formulas.
;
; The following program analyzes given list of all propositional
; formulas, and search for minimal between equivalent formulas.
;
; For all formulas f in list (f0 f1 ... fn),
;
;   (i) Boolean function B defined with f is found
;   (ii) it is tested whether f is a first formula that defines B,
;        or it is shorter than other formulas defining B.
;
; The program builds data structure, defining and using symbols.
; For example, if list ((or a b) (not (and a b)) (-> (not a) b)) is
; given, the program would first found that (or a b) defines Boolean
; function given with column 0111 in truth table. Then it would define
; two symbols and values:
;
;     [Boolean-function.0111] => ((or a b))
;     [propositional-formulas.(or a b)] => [Boolean-function.0111]
;
; After that, (not (and a b)) is found to define same Boolean function,
; but it is longer than (or a b), so nothing changes. If some shorter
; formula defining same Boolean function is found, then
; value [Boolean-function.0111] would be redefined.
;
; In this program, symbols are used instead of hash tables, in some
; other languages, where syntax would be something like
; Boolean-function[0111] instead. One might be surprised with such
; use of the symbols, and think it is abuse of the symbols. But,
; I think it is actually apropriate use, because, in general case,
; there is no reasons for distinction between hash table name,
; and key.
;
; In following program, such procedure is applied on all formulas
; with seven or less "nodes", and finally, all defined Boolean
; functions, and shortest formulas defining these Boolean functions
; are printed.

(set '[println.supressed] true '[print.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(set '[println.supressed] nil '[print.supressed] nil)

(set 'PF (apply append (map (lambda(x)(all-pf x '(true nil A B C)
                                                '(not)
                                                '(and or -> <->)))
                            (sequence 1 7))))

(box-standard "Generated " (length PF) " formulas.")

(set 'truth-column
     (lambda(f)(let ((result '()))
                    (letex((L (propositional-variables f)))
                          (dolist-multi(L '(nil true))
                             (push (eval f) result -1))
                    result))))

(set 'truth-column01
     (lambda(f)(apply string (map (lambda(x)(if x "1" "0"))
                                  (truth-column f)))))

(set 'symexpr (lambda()
                 (let ((result "["))
                      (dolist(i (args))
                        (set 'result (append result (string i) ".")))
                      (setf (last result) "]")
                      (sym result))))

(dolist(formula PF)
  (dolist(subformula (branches formula)) ; for formulas, branches are subformulas
    (set 'canonized-subformula (canon subformula)) ; canon: variables occur in alphabetical order
    (set 'canonized-subformula-symbol
         (symexpr "propositional-formula" canonized-subformula))
    (if (= (eval canonized-subformula-symbol) nil)
        ; new canonized subformula
       (begin (set 'Boolean-function-symbol
                   (symexpr "Boolean-function" (truth-column01 canonized-subformula)))
              (set canonized-subformula-symbol Boolean-function-symbol)
              (if (= (eval Boolean-function-symbol) nil)
                  ; new category
                  (set Boolean-function-symbol (list canonized-subformula))
                  ; old category
                  (if (< (size canonized-subformula)   ;new formula is leader of subcategory
                         (size (first (eval Boolean-function-symbol))))
                       ; canonized subformula is the best represent of category
                       (set Boolean-function-symbol (list canonized-subformula))
                       ; canonized subformula isn't the best represent of category
                       "do nothing")))
          ;old canonized subformula
          "do nothing")))

(set 'counter 1)
(dolist(formula PF)
  (when (= formula (canon formula))
     (set 'propositional-formula-symbol (symexpr "propositional-formula" formula))
     (set 'Boolean-function-symbol (symexpr "Boolean-function" (truth-column01 formula)))
     (when (= formula (first (eval Boolean-function-symbol)))
           (println counter ". " formula ", " Boolean-function-symbol)
           (inc counter))))
(exit)

                      +------------------+
                      | Generated 287535 |
                      |    formulas.     |
                      +------------------+

1. true, [Boolean-function.1]
2. nil, [Boolean-function.0]
3. A, [Boolean-function.01]
4. (not A), [Boolean-function.10]
5. (and nil A), [Boolean-function.00]
6. (and A B), [Boolean-function.0001]
7. (or true A), [Boolean-function.11]
8. (or A B), [Boolean-function.0111]
9. (-> A B), [Boolean-function.1101]
10. (<-> A B), [Boolean-function.1001]
11. (not (and A B)), [Boolean-function.1110]
12. (not (or A B)), [Boolean-function.1000]
13. (not (-> A B)), [Boolean-function.0010]
14. (not (<-> A B)), [Boolean-function.0110]
15. (and (not A) B), [Boolean-function.0100]
16. (or A (not B)), [Boolean-function.1011]
17. (and nil (and A B)), [Boolean-function.0000]
18. (and A (and B C)), [Boolean-function.00000001]
19. (and A (or true B)), [Boolean-function.0011]
20. (and A (or B C)), [Boolean-function.00000111]
21. (and A (-> B C)), [Boolean-function.00001101]
22. (and A (<-> B C)), [Boolean-function.00001001]
23. (and (or true A) B), [Boolean-function.0101]
24. (and (or A B) C), [Boolean-function.00010101]
25. (and (-> A B) C), [Boolean-function.01010001]
26. (and (<-> A B) C), [Boolean-function.01000001]
27. (or true (and A B)), [Boolean-function.1111]
28. (or A (and B C)), [Boolean-function.00011111]
29. (or A (or B C)), [Boolean-function.01111111]
30. (or A (-> B C)), [Boolean-function.11011111]
31. (or A (<-> B C)), [Boolean-function.10011111]
32. (or (and A B) C), [Boolean-function.01010111]
33. (or (-> A B) C), [Boolean-function.11110111]
34. (or (<-> A B) C), [Boolean-function.11010111]
35. (-> A (and nil B)), [Boolean-function.1100]
36. (-> A (and B C)), [Boolean-function.11110001]
37. (-> A (-> B C)), [Boolean-function.11111101]
38. (-> A (<-> B C)), [Boolean-function.11111001]
39. (-> (or A B) C), [Boolean-function.11010101]
40. (-> (-> A B) C), [Boolean-function.01011101]
41. (-> (<-> A B) C), [Boolean-function.01111101]
42. (<-> A (and B C)), [Boolean-function.11100001]
43. (<-> A (or B C)), [Boolean-function.10000111]
44. (<-> A (-> B C)), [Boolean-function.00101101]
45. (<-> A (<-> B C)), [Boolean-function.01101001]
46. (<-> (and nil A) B), [Boolean-function.1010]
47. (<-> (and A B) C), [Boolean-function.10101001]
48. (<-> (or A B) C), [Boolean-function.10010101]
49. (<-> (-> A B) C), [Boolean-function.01011001]
50. (not (and A (and B C))), [Boolean-function.11111110]
51. (not (and A (or B C))), [Boolean-function.11111000]
52. (not (and A (-> B C))), [Boolean-function.11110010]
53. (not (and A (<-> B C))), [Boolean-function.11110110]
54. (not (and (or A B) C)), [Boolean-function.11101010]
55. (not (and (-> A B) C)), [Boolean-function.10101110]
56. (not (and (<-> A B) C)), [Boolean-function.10111110]
57. (not (or A (and B C))), [Boolean-function.11100000]
58. (not (or A (or B C))), [Boolean-function.10000000]
59. (not (or A (-> B C))), [Boolean-function.00100000]
60. (not (or A (<-> B C))), [Boolean-function.01100000]
61. (not (or (and A B) C)), [Boolean-function.10101000]
62. (not (or (-> A B) C)), [Boolean-function.00001000]
63. (not (or (<-> A B) C)), [Boolean-function.00101000]
64. (not (-> A (and B C))), [Boolean-function.00001110]
65. (not (-> A (-> B C))), [Boolean-function.00000010]
66. (not (-> A (<-> B C))), [Boolean-function.00000110]
67. (not (-> (or A B) C)), [Boolean-function.00101010]
68. (not (-> (-> A B) C)), [Boolean-function.10100010]
69. (not (-> (<-> A B) C)), [Boolean-function.10000010]
70. (not (<-> A (and B C))), [Boolean-function.00011110]
71. (not (<-> A (or B C))), [Boolean-function.01111000]
72. (not (<-> A (-> B C))), [Boolean-function.11010010]
73. (not (<-> A (<-> B C))), [Boolean-function.10010110]
74. (not (<-> (and A B) C)), [Boolean-function.01010110]
75. (not (<-> (or A B) C)), [Boolean-function.01101010]
76. (not (<-> (-> A B) C)), [Boolean-function.10100110]
77. (and A (and (not B) C)), [Boolean-function.00000100]
78. (and A (or B (not C))), [Boolean-function.00001011]
79. (and (not A) (and B C)), [Boolean-function.00010000]
80. (and (not A) (or B C)), [Boolean-function.01110000]
81. (and (not A) (-> B C)), [Boolean-function.11010000]
82. (and (not A) (<-> B C)), [Boolean-function.10010000]
83. (and (not (and A B)) C), [Boolean-function.01010100]
84. (and (not (or A B)) C), [Boolean-function.01000000]
85. (and (not (<-> A B)) C), [Boolean-function.00010100]
86. (and (or A (not B)) C), [Boolean-function.01000101]
87. (or A (not (and B C))), [Boolean-function.11101111]
88. (or A (not (or B C))), [Boolean-function.10001111]
89. (or A (not (-> B C))), [Boolean-function.00101111]
90. (or A (not (<-> B C))), [Boolean-function.01101111]
91. (or A (and (not B) C)), [Boolean-function.01001111]
92. (or A (or B (not C))), [Boolean-function.10111111]
93. (or (and A B) (not C)), [Boolean-function.10101011]
94. (or (-> A B) (not C)), [Boolean-function.11111011]
95. (or (<-> A B) (not C)), [Boolean-function.11101011]
96. (or (and (not A) B) C), [Boolean-function.01110101]
97. (-> A (and (not B) C)), [Boolean-function.11110100]
98. (<-> A (and (not B) C)), [Boolean-function.10110100]
99. (<-> A (or B (not C))), [Boolean-function.01001011]
100. (<-> (and (not A) B) C), [Boolean-function.10011010]
101. (<-> (or A (not B)) C), [Boolean-function.01100101]
102. (not (and (or A (not B)) C)), [Boolean-function.10111010]
103. (not (or A (and (not B) C))), [Boolean-function.10110000]
104. (not (or (and (not A) B) C)), [Boolean-function.10001010]
105. (and nil (and A (and B C))), [Boolean-function.00000000]
106. (and A (and B (or true C))), [Boolean-function.00000011]
107. (and A (and (or true B) C)), [Boolean-function.00000101]
108. (and A (or true (and B C))), [Boolean-function.00001111]
109. (and A (-> B (and nil C))), [Boolean-function.00001100]
110. (and A (<-> (and nil B) C)), [Boolean-function.00001010]
111. (and (or true A) (and B C)), [Boolean-function.00010001]
112. (and (or true A) (or B C)), [Boolean-function.01110111]
113. (and (or true A) (-> B C)), [Boolean-function.11011101]
114. (and (or true A) (<-> B C)), [Boolean-function.10011001]
115. (and (or A B) (or true C)), [Boolean-function.00111111]
116. (and (or A B) (or B C)), [Boolean-function.00110111]
117. (and (or A B) (-> A C)), [Boolean-function.00110101]
118. (and (or A B) (-> B C)), [Boolean-function.00011101]
119. (and (or A B) (-> C B)), [Boolean-function.00111011]
120. (and (or A B) (<-> A C)), [Boolean-function.00100101]
121. (and (or A B) (<-> B C)), [Boolean-function.00011001]
122. (and (-> A B) (or true C)), [Boolean-function.11110011]
123. (and (-> A B) (or A C)), [Boolean-function.01010011]
124. (and (-> A B) (or B C)), [Boolean-function.01110011]
125. (and (-> A B) (-> B C)), [Boolean-function.11010001]
126. (and (-> A B) (-> C A)), [Boolean-function.10100011]
127. (and (-> A B) (-> C B)), [Boolean-function.10110011]
128. (and (-> A B) (<-> A C)), [Boolean-function.10100001]
129. (and (-> A B) (<-> B C)), [Boolean-function.10010001]
130. (and (<-> A B) (or true C)), [Boolean-function.11000011]
131. (and (<-> A B) (or A C)), [Boolean-function.01000011]
132. (and (<-> A B) (-> A C)), [Boolean-function.11000001]
133. (and (<-> A B) (-> C A)), [Boolean-function.10000011]
134. (and (<-> A B) (<-> A C)), [Boolean-function.10000001]
135. (and (or true (and A B)) C), [Boolean-function.01010101]
136. (and (or A (and B C)) B), [Boolean-function.00010011]
137. (and (or A (or B C)) B), [Boolean-function.00110011]
138. (and (-> A (and nil B)) C), [Boolean-function.01010000]
139. (and (-> A (and B C)) B), [Boolean-function.00110001]
140. (and (<-> A (and B C)) B), [Boolean-function.00100001]
141. (and (<-> (and nil A) B) C), [Boolean-function.01000100]
142. (or true (and A (and B C))), [Boolean-function.11111111]
143. (or A (and (or true B) C)), [Boolean-function.01011111]
144. (or A (-> B (and nil C))), [Boolean-function.11001111]
145. (or A (<-> (and nil B) C)), [Boolean-function.10101111]
146. (or (and A B) (-> C B)), [Boolean-function.10111011]
147. (or (and A B) (<-> A C)), [Boolean-function.10100111]
148. (or (and A B) (<-> B C)), [Boolean-function.10011011]
149. (or (<-> A B) (and A C)), [Boolean-function.11000111]
150. (or (<-> A B) (and B C)), [Boolean-function.11010011]
151. (or (<-> A B) (<-> A C)), [Boolean-function.11100111]
152. (or (<-> A B) (<-> B C)), [Boolean-function.11011011]
153. (or (-> A (and nil B)) C), [Boolean-function.11110101]
154. (or (<-> A (or B C)) B), [Boolean-function.10110111]
155. (or (<-> A (<-> B C)) B), [Boolean-function.01111011]
156. (-> A (and nil (and B C))), [Boolean-function.11110000]
157. (-> A (-> B (and nil C))), [Boolean-function.11111100]
158. (-> A (<-> (and nil B) C)), [Boolean-function.11111010]
159. (-> (or A B) (and nil C)), [Boolean-function.11000000]
160. (-> (or A B) (and A C)), [Boolean-function.11000101]
161. (-> (or A B) (<-> A C)), [Boolean-function.11100101]
162. (-> (or A B) (<-> B C)), [Boolean-function.11011001]
163. (-> (-> A B) (<-> A C)), [Boolean-function.10101101]
164. (-> (-> A B) (<-> B C)), [Boolean-function.10011101]
165. (-> (<-> A B) (and nil C)), [Boolean-function.00111100]
166. (-> (<-> A B) (and A C)), [Boolean-function.00111101]
167. (-> (<-> A B) (<-> A C)), [Boolean-function.10111101]
168. (<-> A (and B (or A C))), [Boolean-function.11100011]
169. (<-> A (and (or true B) C)), [Boolean-function.10100101]
170. (<-> A (and (-> B A) C)), [Boolean-function.10110101]
171. (<-> A (and (<-> A B) C)), [Boolean-function.10110001]
172. (<-> A (or B (<-> A C))), [Boolean-function.01000111]
173. (<-> A (or (<-> A B) C)), [Boolean-function.00100111]
174. (<-> A (-> (-> B A) C)), [Boolean-function.10000101]
175. (<-> A (-> (<-> A B) C)), [Boolean-function.10001101]
176. (<-> A (<-> B (and A C))), [Boolean-function.00111001]
177. (<-> A (<-> B (or A C))), [Boolean-function.01100011]
178. (<-> A (<-> B (-> A C))), [Boolean-function.11001001]
179. (<-> A (<-> B (-> C A))), [Boolean-function.10010011]
180. (<-> A (<-> (and nil B) C)), [Boolean-function.01011010]
181. (<-> (and nil A) (and B C)), [Boolean-function.11101110]
182. (<-> (and nil A) (or B C)), [Boolean-function.10001000]
183. (<-> (and nil A) (-> B C)), [Boolean-function.00100010]
184. (<-> (and nil A) (<-> B C)), [Boolean-function.01100110]
185. (<-> (and A B) (and B C)), [Boolean-function.11101101]
186. (<-> (and A B) (or B C)), [Boolean-function.10001011]
187. (<-> (and nil (and A B)) C), [Boolean-function.10101010]
188. (<-> (and A (and B C)) B), [Boolean-function.11001101]
189. (<-> (and A (or B C)) B), [Boolean-function.11001011]
190. (<-> (or (<-> A B) C) B), [Boolean-function.00011011]
191. (<-> (-> A (and B C)) C), [Boolean-function.01011011]


-------------------------------------
Symbols as Sexprs and Hygienic Fexprs
-------------------------------------
http://kazimirmajorinc.blogspot.com/2009/12/symbols-as-sexprs.html

; During last year of use of Newlisp I changed my opinion about
; one important thing: encoding information in symbols.

; Initially, I thought it is mistake, or attempt for escape from
; dry, but essential Lisp syntax, known in most of Lisp languages.
; See, for example, apostrophe - or even worse, "loop" in some
; dialects. I criticized my Newlisp coleague Cyril Slobin
; who did it once.

; However, soon I concluded that there is no good alternative for
; encoding of information in symbols. For example, in one of the
; first posts here, I tried to define operators similar to +=,
; -=, *= etc in C. If you didn't used these operators, x+=1 is
; same thing as x=x+1; x*=2 is same as x=x*2.
;
; What does it mean, encoding information in symbols? Take a look
; on C operators
;
;                          +=, -=, *=,
;
;
; again. The names of these operators are not *just names*, but also
; descriptions of the operators. The programmer who learns C probably
; mentally parse these names while programming for some time, until he
; automatizes use of the operators.
;
; If these operators are defined in Newlisp program, then the
; names must be defined by program as well. And what should be the
; names of the operators defined with
;
;          (operator1 x y) <=> (setq x (+ x y))
;          (operator2 x y) <=> (setq x (- x y))
;          ...?
;
; From my point of view, natural choice of the names could be
; setq+ and setq-.
;
; Another example of generated symbol names I used is in post
; in which I defined functions for prevention of accidental name
; clashes. If function f is, for example, defined with
;
;                  (set 'f (lambda(x)(x y)))
;
; then (protect1 'f '(x y)) replaced definition of f with
;
;                    (lambda(f.x)(f.x f.y))
;
; and later, I replaced it with
;
;                  (lambda([f.x])([f.x] [f.y]))
;
; How bracket get into combination? Because, I have find that
; I might need to distinguish names like
;
;                    f.[x.1] and [f.x].1
;
; At this point, my variable names started to look increasingly
; like s-expression, so I assumed that it might be useful to
; assume that our usual one-word symbols as just special cases
; of symbols in the form of s-expressions.
;
; Newlisp allow us to use "ilegal" symbol names, so theoretically,
; I can use symbols of the form (f x) - with blanks and parenthesis
; as characters - but such symbols cannot be printed out and readed
; again. So, symbols - sexprs must use different forms of parentheses
; and delimiters.

; Unfortunately, dot is not good choice for delimiter, because dot
; can be part of the number, so [f.1.3] is ambigious - is it (f 1.3),
; or (f 1 3)?
;
; Also, square and curly brackets have special meanings in Newlisp
; syntax, so more exotic choices are necessary.

; In following part of the code, I'll show how I defined symbols in
; the form of s-expression and how these are used to redefine functions
; protect1 (fast - and protecting from practically all kinds of accidental
; variable clashes) and protect2 (slow - protecting from accidental
; variable name clashes in some rare, in Newlisp practice unknown.
; but still possible cases.)
; Details are described in my previous posts in series
;
; "Don't fear dynamic scope."
;
; "Don't fear dynamic scope (2)."

;---------------------------------------------------------------
; First, we'll define equivalents in one, centralized place

(set 'left-parenthesis-equivalent ".<.")
(set 'right-parenthesis-equivalent ".>.")
(set 'blank-equivalent "___")
(set 'apostrophe-equivalent "`")
(set 'quotation-mark-equivalent "~")

;---------------------------------------------------------------
; Next, we'll define two pairs of functions for conversion from
; s-expression to string and vice versa.

(set 'symbol-to-sexpr
     (lambda(S)
       (setq S (string S))
       (setq S (replace left-parenthesis-equivalent S "("))
       (setq S (replace right-parenthesis-equivalent S ")"))
       (setq S (replace blank-equivalent S " "))
       (setq S (replace apostrophe-equivalent S "'"))
       (setq S (replace quotation-mark-equivalent "\""))
       (eval-string (append "'" S))))

(set 'sexpr-from-symbol symbol-to-sexpr)

(set 'sexpr-to-symbol
     (lambda(L)
       (setq L (string L))
       (setq L (replace "(" L left-parenthesis-equivalent))
       (setq L (replace ")" L right-parenthesis-equivalent))
       (setq L (replace " " L blank-equivalent))
       (setq L (replace "'" L apostrophe-equivalent ))
       (setq L (replace "\"" L quotation-mark-equivalent ))
       (sym L)))

(set 'symbol-from-sexpr sexpr-to-symbol)

; Let us see on example, how these functions work:

(println (symbol-from-sexpr '(* (+ x y) (- x y))))

;
;           .<.*___.<.+___x___y.>.___.<.-___x___y.>..>.
;
; Pretty much like normal s-expression, while < and > pretend to be
; parenthesis, and exotic dots pretend to be blank characters.
;
;---------------------------------------------------------------
; Now, I'll define "protected version" of function set:
;
;   * (set-protected1 function/macro-name original-code variables)

(set 'set-protected1
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (eval (list 'letex
                  (map (lambda(x)
                         (list x
                               (list 'quote
                                     (symbol-from-sexpr
                                        (list function/macro-name
                                              x)))))
                        variables)
                  definition-code)))))

;---------------------------------------------------------------
; Example:

(set-protected1 'f (lambda(x y z)(x y z)) '(x z))

(println f) ;=> (lambda (.<.f___x.>. y .<.f___z.>.)
            ;              (.<.f___x.>. y .<.f___z.>.))

;---------------------------------------------------------------
; Similarly, the version protect1 that protects the functions
; that already exist:

(set 'protect1 (lambda(function/macro-name variables)
                  (set-protected1 function/macro-name
                                (eval function/macro-name)
                                variables)))

;---------------------------------------------------------------
; In next step, I'll use set-protected1 and protect1 to define -
; protected versions of set-protected1 and protect1.

((copy set-protected1) 'set-protected1
                        set-protected1
                        '(function/macro-name definition-code
                                              variables
                                              x))

((copy protect1) 'protect1 '(function/macro-name variables))

;---------------------------------------------------------------
; In following step, I'll define set-protect2 and protect2. These
; two functions should be able to protect functions even from the
; most demanding funarg problems. Details are explained in "Don't
; fear dynamic scope." articles, links are above.

(set 'set-protected2
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (expand (lambda-macro()
                (let((name-and-counter
                        (symbol-from-sexpr (list 'function/macro-name
                                                 (inc counter)))))

                    (set-protected1 name-and-counter
                                    definition-code
                                    'variables)

                    (first (list (eval (cons name-and-counter
                                             $args))
                                 (dolist(i 'variables)
                                    (delete (symbol-from-sexpr
                                              (list name-and-counter
                                                    i))))
                                 (delete name-and-counter)))))

               'function/macro-name 'definition-code 'variables))))

; set-protected2 is the most important function in this post.
; In this version it is more than twice shorter and, I hope,
; simpler than in last version.

;---------------------------------------------------------------
; Example of set-protected2

(set-protected2 'f (lambda(x y z)(x y z)) '(x z))
(println f)

; (lambda-macro ()
;  (let ((name-and-counter (symbol-from-sexpr (list 'f (inc counter)))))
;   (set-protected1 name-and-counter (lambda (x y z) (x y z)) '(x z))
;   (first (list (apply name-and-counter $args)
;     (dolist (i '(x z))
;      (delete (symbol-from-sexpr (list name-and-counter i))))
;     (delete name-and-counter)))))

;---------------------------------------------------------------
; Similarly, the version protect2 that protects the functions
; and macros that already exist:

(set 'protect2
     (lambda(function/macro-name variables)
        (set-protected2 function/macro-name
                        (eval function/macro-name)
                        variables)))

;---------------------------------------------------------------
; In next step, I'll use protect1 to define -
; protected versions of set-protected2 and protect2.

(protect1 'set-protected2 '(function/macro-name definition-code
                            variables counter name-and-counter i))

(protect1 'protect2 '(function/macro-name variables))

;---------------------------------------------------------------
; Finally, hard example of funarg problem: recursive fexpr hard-example
; call itself, passing the function encapsulating one free variable
; from one instance of the hard-example to another. We'll see whether
; protect2 will protect it.
;
; If (hard-example (lambda(x)x)) returns 1 2 3 1 2 3 then free variable
; is overshadowed with same variable in other instance.
;
; If (hard-example (lambda(x)x)) returns 1 1 1 1 2 3 then it is not
; overshadowed.

(define-macro (hard-example f)
      (for(i 1 3)
         (unless done          ; avoiding infinite
             (set 'done true)  ; recursion
             (hard-example (lambda(x)i)))
                               ; One recursive call with function
                               ; (lambda(x)i)

         (println i " =>" (f i)))) ; which i will be printed?
                                   ; i=1 2 3 means inner is overriden

;---------------------------------------------------------------
; First, without protection:

(set 'done nil)
(hard-example (lambda(x)x))

; 1 =>1
; 2 =>2
; 3 =>3
; 1 =>1
; 2 =>2
; 3 =>3

; Overshadowing happened.

;---------------------------------------------------------------
; Then, after protection:

(set 'done nil)
(protect2 'hard-example '(f i x))
(hard-example (lambda(x)x))

; 1 =>1
; 2 =>1
; 3 =>1
; 1 =>1
; 2 =>2
; 3 =>3

; Overshadowing prevented.

;---------------------------------------------------------------
; Finally, we'll take a look whether all variables intended to
; be temporary, like .<.hard-example___1.>. etc. are deleted.

(dolist(i (symbols))
  (if (starts-with (string i) left-parenthesis-equivalent)
      (println i)))

; .<.*___.<.+___x___y.>.___.<.-___x___y.>..>.
; .<.f___x.>.
; .<.f___z.>.
; .<.protect1___function/macro-name.>.
; .<.protect1___variables.>.
; .<.protect2___function/macro-name.>.
; .<.protect2___variables.>.
; .<.set-protected1___definition-code.>.
; .<.set-protected1___function/macro-name.>.
; .<.set-protected1___variables.>.
; .<.set-protected1___x.>.
; .<.set-protected2___counter.>.
; .<.set-protected2___definition-code.>.
; .<.set-protected2___function/macro-name.>.
; .<.set-protected2___i.>.
; .<.set-protected2___name-and-counter.>.
; .<.set-protected2___variables.>.
;
; Yes, they are deleted.
;
; Another test, this one taken from recent John Shutt's disertation
; on Kernel programming language.

(define y 3)
(set 'f (lambda (x) (+ x y)))
(set 'g (lambda (y) (+ 1 (f y))))
(println (g 5))                     ;=> 11

; This code in lexically scoped Lisp evaluates to 9. In dynamically
; scoped Lisp it evaluates to 11. If you are surprised with 11,
; that means you didn't recognized that y from definition of g will
; overshadow top level y during evaluation of (f y). But - it will.
; If you want to use different objects, you have to use different
; names; and, if it is boring to invent new names for bounded variables,
; set-protected (both versions) will do that for you:

(define y 3)
(set-protected2 'f (lambda (x) (+ x y)) '(x))
(set-protected2 'g (lambda (y) (+ 1 (f y))) '(y))
(println (g 5))     ;=> 9

(exit)

; In further posts, I'll explore that idea of symbols as sexprs
; deeper.

Commenti:
---------
cormullion14 December 2009 at 23:45
I see what you were asking about brackets for now! amazing stuff...
cormullion

*** Kazimir Majorinc 15 December 2009 at 08:00
Thanx cormullion. On the way of development, I also accidentally ruined println.supressed - when I replaced it with [println.supressed].

But I experimented for some time until I discovered that these characters: ¨ and ˙ are relatively readable and relatively well supported by all kinds of consolas, web browsers, text editors, and they are unlikely to occur accidentally in programs.


---------------------------
Alan Kay on Lisp and Fexprs
---------------------------
http://kazimirmajorinc.blogspot.com/2010/02/alan-kay-on-fexprs.html

Alan Kay is designer of Smalltalk. This citation is known, but not as well as it should be, and I think it deserves attention separately of many posts I wrote on fexprs.

  "I could hardly believe how beautiful and wonderful the idea of LISP was. I say it this way because LISP had not only been around enough to get some honest barnacles, but worse, there were deep flaws in its logical foundations. By this, I mean that the pure language was supposed to be based on functions, but its most important components -- such as lambda expressions, quotes, and conds -- were not functions at all, and instead were called special forms. Landin and others had been able to get quotes and cons in terms of lambda by tricks that were variously clever and useful, but the flaw remained in the jewel. In the practical language things were better. There were not just EXPRs (which evaluated their arguments), but FEXPRs (which did not). My next questions was, why on Earth call it a functional language? Why not just base everything on FEXPRs and force evaluation on the receiving side when needed?

I could never get a good answer, but the question was very helpful when it came time to invent Smalltalk, because this started a line of thought that said 'take the hardest and most profound thing you need to do, make it great, an then build every easier thing out of it.'"

Alan Kay,
The Early History of Smalltalk.,
in: Bergin, Jr., T.J., and R.G. Gibson.
History of Programming Languages - II,
ACM Press, New York NY, and
Addison-Wesley Publ. Co., Reading MA 1996,
pp. 511-578


----------------------------------
Composition of Functions or Macros
----------------------------------
http://kazimirmajorinc.blogspot.com/2010/02/composition-of-functions-or-macros.html

; The composition of the functions is one of the basic mathematical
; operations. In this post, I'll try to define composition of
; functions and macros (Newlisp macros=fexprs) in Newlisp.
;
; Such composition should satisfy the following:
;
;     ((composition 'f1 ... 'fn) _ _ _) = (f1 (f2 ... (fn _ _ _)))
;
; for all functions and macros.
;
; It wasn't that easy as I thought. First, I limited myself on the
; case of the composition of two functions. After some experimentation
; I came to that:

(set 'compose2 (lambda(f g)
                 (expand (lambda-macro()(letex((L (cons 'g (args))))(f L)))
                          'f 'g)))

; I tested it on simple example:

(println (compose2 'sin 'cos))

; (lambda-macro ()
;  (letex ((L (cons 'cos (args)))) (sin L)))

(println ((compose2 'sin 'cos) 3) (sin (cos 3))) ; OK, it works.

; Then I tested it on two special, well, entities, i.e. identity
; function and identity macro:

(set 'I (lambda(x)x))
(set 'IM (lambda-macro(x)x))

(println ((compose2 'I 'sin) 3)) ; 0.1411200081, as it should be, i.e. (I (sin 3))
(println ((compose2 'sin 'I) 3)) ; 0.1411200081, as it should be, i.e. (sin (I 3))
(println ((compose2 'IM 'sin) 3)) ; (sin 3), as it should be, i.e. (IM (sin 3))
(println ((compose2 'sin 'IM) 3)) ; 0.1411200081, as it should be (sin (IM 3))

; OK; it appears it worked. Now I'll have to solve multi-version,
; I.e. composition of many functions or macros

(set 'compose (lambda()
                 (case (length (args))
                    (0 I)               ; because (I (S x)) <=> (S x),
                                        ; no matter if S is function or macro
                                        ; so I can be always added from the left.
                    (1 (first (args)))
                    (2 (apply compose2 (args)))
                    (true (compose2 (first (args)) (apply compose (rest (args))))))))

(println ((compose sqrt) 65536)) ; 256
(println ((compose sqrt sqrt) 65536)) ; 16
(println ((compose sqrt sqrt sqrt) 65536)) ; 4

; OK, it works as well. However, result of the composing is
; rather complicated because of recursive definition

(println (compose 'f1 'f2 'f3 'f4))

; (lambda-macro ()
;   (letex ((L (cons '(lambda-macro ()(letex ((L (cons '(lambda-macro ()(letex ((L (cons 'f4 (args))))
;                                                                              (f3 L)))
;                                                      (args))))
;                                             (f2 L)))
;                    (args))))
;         (f1 L)))
;
;
; If iteration is used for definition of compose, then composition
; can be both shorter and faster - but not more elegant.


---------------------------------------------------
Composing Fexprs Preserves Short-circuit Evaluation
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/02/composing-fexprs-preserves-short.html

; One of the well known advantages of special operators over
; functions is that special operators apply "short-cuirciting".
;
; For example, operator "and" that evaluates
;
;  (and (= 1 1) (= 2 2) (= 3 4) (= 5 (slow-function 6)))
;
; will never evaluate clause (= 5 (slow-function 6)). Instead,
; after (= 3 4) is recognized to be false, there is no theoretical
; possibility that whole expression evaluates to true, and
; nil is returned without evaluating other clauses.
;
; This is significant difference between operators and functions.
; If "and" was defined as function, all clauses would be evaluated
; first, and then passed to the operator "and."
;
; Only today I came to idea to test whether operator compose I
; defined few days ago, which can be applied on fexprs as well as
; on functions, preserves short-circuiting.
;
; I'll test it by defining two well known logical operators,
; nor and nand.

(set 'nor (compose not or))
(set 'nand (compose not and))

; Let us test whether 'nor' and 'nand' preserve short-circuit
; evaluation.

(nand (println "this should be done ")
      (println "and this should be done")
      (println (setf j nil))
      (println "but this shouldn't be done"))

; this should be done
; and this should be done
; nil
;

(println "---")

(nor (println (= 1 2))
     (println (= 1 3))
     (println "and something different")
     (println "this shouldn't be done"))

; ---
; nil
; nil
; and something different

; Everything works. Beautiful, isn't it?

(exit)

Commenti:
--------
*** Wolverrum 24 February 2010 at 01:54
>Beautiful compose() is a good enough approach to make code shorter, I like it :)

*** Kazimir Majorinc 24 February 2010 at 03:27
Actually, it is not that bad weather if one sits in the bar, drink tea and rum, and watch the world through windows. I have another similar function, it is "increase-order". On that way I can increase order of functions, so these can apply on other functions. For example, I can define +f

(setf +f (increase-order +))

and +f will add functions, not numbers.

((+f sin cos) x) ==> (+ (sin x) (cos x))

It was one of my first posts, so maybe it doesn't work any more - Newlisp changed, but version in my library works.

*** Wolverrum 27 February 2010 at 12:24
Blogger Wolverrum said...

As I understanding increasOrder properly it has type:
increaseOrder :: (b->c) -> ((a->b) -> (a->c))

At least above I was able to create using C#2 :)

FuncX<FuncX<A, B>, FuncX<A, C>> Up< B, C>(FuncX<B, C> fn)
{return delegate(FuncX<A, B> h) {
return Compose(h, fn); }; }

*** Kazimir Majorinc 28 February 2010 at 02:29
Hey, its pretty elegant solution.


------------------------------
How Many Syllogisms are There?
------------------------------
http://kazimirmajorinc.blogspot.com/2010/03/how-many-syllogisms-are-there.html

1. Introduction

Asyllogism or logical appeal is a kind of logical argument, developed by Aristotle, in which one proposition (the conclusion) is inferred from two others (the premises) of a certain form. The simplest and the most popular syllogisms are categorical syllogisms, like this one:

Some cats have no tails.  (premise)
All cats are mammals. (premise)
Some mammals have no tails.     (conclusion)
Both premises and conclusions of the syllogism are called propositions. There are four "types"of propositions:

All S are P (universal affirmative)
Some S are P  (particular affirmative)
Some S aren't P     (particular negative)
No S are P  (universal negative)
Some syllogisms are valid, like one with cats and mammals. That means, as long as form is preserved, no matter of terms used instead of cats, tails and mammals - if premises are true, then conclusion is also true. Not all syllogisms are valid. Discovering and describing all valid syllogisms is challenging logical problem and it seems it was the main activity of the logicians in period of more than two thousands years, until Göttlib Frege discovered predicate logic in late 19th century.

Surprisingly, it appears that there is no consensus about how many valid syllogisms exist. Some sources on Internet claim that there are 19 of them, others claim from 14 to 24. Newlisp program for construction and testing of syllogisms, i.e. discovering all valid syllogisms is described. The results of its work are given.

2. The Program

The program might look like

(dolist (p1 all-possible-1st-premises)
  (dolist (p2 all-possible-2nd-premises)
    (dolist (c all-possible-conclusions)
      (check-validity-of-syllogism p1 p2 c))))
where all these parts are, unfortunately, nontrivial. Let us assume that we know how loops can be organized. How can program know that syllogism is valid? For instance, this is how schematically written silogism about cats and tails and mamals might look alike:

Some cats have no tails.  (premise)       ==>  Some-arent M P
All cats are mammals.     (premise)       ==>  All-are M S
Some mammals have no tails. (conclusion)  ==>  Some-arent S P

where M = cats, P = creatures with tails and S = mammals.

Humans easily understand that syllogism is valid. The algorithm that allows program to recognize the validity is simple but not trivial: it analyzes all possible worlds. If in all possible worlds, each time both premises of syllogism are true then conclusion is also true - we'll say that syllogism is valid. The phrase "all possible worlds" sounds scary; However, if irelevant details are omitted, it turns that there are not that many essentially different worlds.

More precisely, theworlds are completey determined with relations between terms S, M and P. In some possible worlds all cats have tails; in other possible worlds only some cats have tails, and others have not. In some worlds, no cats have tails at all. In some worlds, only cats and noone else have tails. In some worlds, cats are not only beings with tails. In some worlds all beings have tails, except cats.

For our purpose, two possible worlds differ if there is some combination of S or (not S), M and (not M), P and (not P), such that in one world there are the beings that satisfy particular combination, and in other world there are no such beings.

Every world can be depicted with Venn's diagram like a following one.

Fig. 1. Venn's diagram of one Aristotle's world
Nota: vedi immagine "venn-aristotele.png" nella cartella "data".

This particular diagram represents the world in which there are beings that satisfy S and (not M) and (not P), and there are the beings that satisfy (not S) and (not M) and P but there are no beings that satisfy any other combination of S or (not S), M and (not M), P and (not P).

We can start defining the list of all possible worlds. Let us note that all areas in the Venn's diagram are denoted with sublists of letters from list (S M P). We can even say that large area out of S, M and P is denoted - with empty list, where empty list is also sublist of (S M P). Let us first define the function sublist, that accept list as argument, and returns list of all sublists of taht list.

(set 'sublists
   (lambda(L)
     (if (= (length L) 0) '(())
         (let ((s (sublists (chop L))))
              (append s
                      (map (lambda(x)(append x (list (last L))))
                           s))))))

For those who use some other Lisps, last and chop in Newlisp are in the same relation as first and rest. Let us define the list Areas that contains all sublists of (S M P), i.e. (() (S) (M) (S M) (P) (S P) (M P) (S M P)).

(set 'Areas (sublists '(S M P)))

Each possible world is determined by existance of being  in these areas. For our purpose, two worlds are equivalent if and only if they have elements in exactly same areas. Hence, we can say that single world is completely determined by sublist of the areas, containing only areas with some elements in.

For instance, the world depicted with Venns diagram above is completely described with ((S) (P)). There are beings that satisfy the property S (but nothing else) and there are also beings that satisfy P, but nothing else. Let us define the list of all possible worlds:

(set 'Worlds (sublists Areas))

Total, there are 256 worlds. In the next step, the number of the considered worlds is reduced. In Aristotle's logic - just like in everyday speech, empty terms are ignored. If someone says that all yetis are tall - one will say that there are no yetis, and he'll avoid any direct answer "it is true" or "it is false." That's why, for example, in Aristotle's logic,

All S are P implies Some S are P.

In some areas of reasoning, particularly mathematics, it is not assumed that terms are non-empty. For instance, the world ((S)) is not Aristotle's world, because neither one area in the world ((S)) contains P or M. On the other side, (() (S M) (P)) is Aristotle's world.

(set 'Aristotles-worlds
     (filter (lambda(x)(= (length (unique (flat x))) 3))
             Worlds))

There are 218 elements in Aristotles-worlds. In the next step, the function true-in-world will be defined. When we say something like "there is only one truth", we can say it because we think on only one world - our phisical world. If we consider more than one world, or even all possible worlds, we must speak about truth in particular world.

The function true-in-world accepts proposition (defined with pair of quantifier and copula (like all-are, some-are etc.) two terms) and one world, and returns true if proposition is true in that world, and nil otherwise.

For instance, we want that (true-in-world all-are 'S 'P '((S P) (P))) returns true, because for each "area" in ((S P) (P)) if S is in area, then P is in area as well.

(set 'true-in-world
   (lambda(qc term1 term2 w) ; qc = quantifier and copula
      (not
         (not
            (case qc
                  (all-are
                     (for-all (lambda (area)
                                      (if (find term1 area)
                                          (find term2 area)
                                          true))
                              w))
                  (some-are
                     (exists (lambda (area)
                                     (and (find term1 area)
                                          (find term2 area)))
                             w))
                  (some-arent
                     (exists (lambda (area)
                                     (and (find term1 area)
                                          (not (find term2
                                                     area))))
                             w))
                  (no-are
                     (for-all (lambda (area)
                                      (if (find term1 area)
                                          (not (find term2
                                                     area))
                                          true))
                              w)))))))

The function proposition-to-string is only to format the output to be more readable.

(define (proposition-to-string qc t1 t2)
  (letn((sqc (string qc))
        (fsqc (find "-" sqc)))
     (append (slice sqc 0 fsqc) " " (string t1) " "
             (slice sqc (+ fsqc 1) (- (length sqc) fsqc 1))
             " " (string t2))))

The loops should be organized for testing all possible syllogisms. Traditionally, syllogisms are systematized in Figures.

                  FIGURE 1    FIGURE 2    FIGURE 3    FIGURE 4
Premise major     - M - P     - P - M     - M - P     - P - M
Premise minor     - S - M     - S - M     - M - S     - M - S
                  ---------   --------    --------    ---------
                  - S - P     - S - P     - S - P     - S - P

Conclusion

Each figure determines subject and predicate in both premises. In all conclusions, subject is S and predicate is P. Theoretically, the figures like

FIGURE 1A

- M - P
- S - M
---------
- P - S

could be considered, but, if symbols S and P are replaced, the resulting figure

- M - S
- P - M
--------
- S - P

is the same as Figure 4, with one irrelevant change - replaced order of propositions.

(for (figure 1 4)
   (if (or (= figure 1) (= figure 3)) (set 'major1 'M 'major2 'P)
                                      (set 'major1 'P 'major2 'M))
   (if (or (= figure 1) (= figure 2)) (set 'minor1 'S 'minor2 'M)
                                      (set 'minor1 'M 'minor2 'S))

   (println "\n\nFigure " figure ": ")
   (println "=========")
   (println "Premise major: " major1 " - " major2)
   (println "Premise minor: " minor1 " - " minor2)
   (println "Conclusion:    S - P")

   (dolist (major-qc '(all-are some-are some-arent no-are))
      (dolist (minor-qc '(all-are some-are some-arent no-are))

        (set 'worlds-satisfying-both-premises
              (filter (lambda(m)(and (true-in-world major-qc
                                                    major1
                                                    major2
                                                    m)
                                     (true-in-world minor-qc
                                                    minor1
                                                    minor2
                                                    m)))
                       Aristotles-worlds))

        (dolist (conclusion-qc '(all-are some-are some-arent no-are))

           (when (for-all (lambda(m)
                             (true-in-world conclusion-qc 'S 'P m))
                          worlds-satisfying-both-premises)

              (println "\n----- " (inc syllogism) ". syllogism:\n")
              (println "  Premise major: "
                       (proposition-to-string major-qc major1 major2))
              (println "  Premise minor: "
                       (proposition-to-string minor-qc minor1 minor2))
              (println "  Conclusion:    "
                       (proposition-to-string conclusion-qc 'S 'P)
                       " ("
                       (length worlds-satisfying-both-premises)
                       " worlds.)"))))))

(exit)

3. The Results

The output of the program is the list of all valid syllogisms.

Figure 1:
=========
Premise major: M - P
Premise minor: S - M
Conclusion:    S - P

----- 1. syllogism:

  Premise major: all M are P
  Premise minor: all S are M
  Conclusion:    all S are P (8 worlds.)

----- 2. syllogism:

  Premise major: all M are P
  Premise minor: all S are M
  Conclusion:    some S are P (8 worlds.)

----- 3. syllogism:

  Premise major: all M are P
  Premise minor: some S are M
  Conclusion:    some S are P (32 worlds.)

----- 4. syllogism:

  Premise major: no M are P
  Premise minor: all S are M
  Conclusion:    some S arent P (4 worlds.)

----- 5. syllogism:

  Premise major: no M are P
  Premise minor: all S are M
  Conclusion:    no S are P (4 worlds.)

----- 6. syllogism:

  Premise major: no M are P
  Premise minor: some S are M
  Conclusion:    some S arent P (24 worlds.)

Figure 2:
=========
Premise major: P - M
Premise minor: S - M
Conclusion:    S - P

----- 7. syllogism:

  Premise major: all P are M
  Premise minor: some S arent M
  Conclusion:    some S arent P (24 worlds.)

----- 8. syllogism:

  Premise major: all P are M
  Premise minor: no S are M
  Conclusion:    some S arent P (4 worlds.)

----- 9. syllogism:

  Premise major: all P are M
  Premise minor: no S are M
  Conclusion:    no S are P (4 worlds.)

----- 10. syllogism:

  Premise major: no P are M
  Premise minor: all S are M
  Conclusion:    some S arent P (4 worlds.)

----- 11. syllogism:

  Premise major: no P are M
  Premise minor: all S are M
  Conclusion:    no S are P (4 worlds.)

----- 12. syllogism:

  Premise major: no P are M
  Premise minor: some S are M
  Conclusion:    some S arent P (24 worlds.)

Figure 3:
=========
Premise major: M - P
Premise minor: M - S
Conclusion:    S - P

----- 13. syllogism:

  Premise major: all M are P
  Premise minor: all M are S
  Conclusion:    some S are P (16 worlds.)

----- 14. syllogism:

  Premise major: all M are P
  Premise minor: some M are S
  Conclusion:    some S are P (32 worlds.)

----- 15. syllogism:

  Premise major: some M are P
  Premise minor: all M are S
  Conclusion:    some S are P (32 worlds.)

----- 16. syllogism:

  Premise major: some M arent P
  Premise minor: all M are S
  Conclusion:    some S arent P (28 worlds.)

----- 17. syllogism:

  Premise major: no M are P
  Premise minor: all M are S
  Conclusion:    some S arent P (12 worlds.)

----- 18. syllogism:

  Premise major: no M are P
  Premise minor: some M are S
  Conclusion:    some S arent P (24 worlds.)

Figure 4:
=========
Premise major: P - M
Premise minor: M - S
Conclusion:    S - P

----- 19. syllogism:

  Premise major: all P are M
  Premise minor: all M are S
  Conclusion:    some S are P (8 worlds.)

----- 20. syllogism:

  Premise major: all P are M
  Premise minor: no M are S
  Conclusion:    some S arent P (4 worlds.)

----- 21. syllogism:

  Premise major: all P are M
  Premise minor: no M are S
  Conclusion:    no S are P (4 worlds.)

----- 22. syllogism:

  Premise major: some P are M
  Premise minor: all M are S
  Conclusion:    some S are P (32 worlds.)

----- 23. syllogism:

  Premise major: no P are M
  Premise minor: all M are S
  Conclusion:    some S arent P (12 worlds.)

----- 24. syllogism:

  Premise major: no P are M
  Premise minor: some M are S
  Conclusion:    some S arent P (24 worlds.)


-----------------------------------------------------------
The program for derivation of syllogisms, condensed version
-----------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/03/how-many-syllogisms-are-there-condensed.html

; "Factoring out" is a sword with two blades. Typical result of the
; factoring out is that code is shorter, more concise, approaching
; the essence of the problem, but in the same time, much harder
; to understand. Here is my last program for derivation of syllogisms,
; in condensed version.

(load "http://www.instprog.com/Instprog.default-library.lsp")
(dolist (fig1 '((S M)(M S)))
  (dolist (fig2 '((M P)(P M)))
    (dolist-multi((majqc minqc conqc)(map first (setf qc '((all-are '(for-all if begin))
                                                           (some-are '(exists and begin))
                                                           (some-arent '(exists and not))
                                                           (no-are '(for-all if not))))))
      (when (for-all (fn(m (truew (fn(p)((eval ((setf d (eval (append '(case (p 0)) qc))) 0))
                                         (fn(a)(eval (list (d 1)
                                                           (find (p 1) a)
                                                           (list (d 2) (find (p 2) a))
                                                           true)))
                                         m))))(if (and (= (length (unique (flat m))) 3)
                                                       (truew (setf major (cons majqc fig2)))
                                                       (truew (setf minor (cons minqc fig1))))
                                                  (truew (setf concl (cons conqc '(S P))))
                                                  true))
                    (sublists (sublists '(S M P))))
        (println= "\n" (++ syllogism) "\n\n  " major "\n  " minor "\n  " concl)))))

; For better explained, longer code and results, see here: How many syllogisms are there?


------------------------------------------
McCarthy - Dijkstra short polemics in 1976
------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/04/mccarthy-dijkstra-short-polemics-in.html

To Professor John McCarthy

Dear Colleague,

thank you for your amazing letter of August 18, 1976. But you really don't need to be sorry for me because the output of your xerographic printer hurts my eye. (For after all, all of us need our daily dose of irritation: I satisfy my needs in this respect by exposure to audible wallpaper, xerographic computer output and similar would-be services to the consumer.)

I am puzzled by your ban on my use of the verb "to degrade": I thought I had used it correctly, in the sense of "to impair the quality of". But let me propose a deal: you allow me to dislike your poor xerographic printer output (and to say so), and I promise not to mind if you call me a snob.

As far as the mechanics of manuscript production are concerned, I can warmly recommend to all prospective authors to train themselves to get their texts nearly right the first time: it is a fast, efficient, and cheap way of working that almost always gives great esthetic and intellectual satisfaction.

And finally: if you have the text of your recent letter still in your computer files, you could do me three favours: inserting the missing "W." in the first line of the address, and correcting the spelling errors in the next two lines of the address.

As EWD581 - 1 your letter will get the same distribution as EWD574, my letter to Zohar.

Greetings and best wishes!
Yours ever,
Edsger W. Dijkstra
Dear Professor Dijkstra:

Zohar Manna showed me your letter of 26 July. I am sorry you "vehemently abhor" computer produced manuscripts in different type fonts. I wish our xerographic printer had higher resolution and didn't make smudges when it hasn't recently been adjusted; we do the best we can. You are entitled to your tastes, but when you claim that people with different tastes are using computers to "degrade our lives", you are contributing to an atmosphere of snobbery that has done much to degrade discussion of programming style. Consider this also a protest against the language used in your campaign against gotos. (Sorry our boldface isn't bolder).

As the inventor of one of the first languages (LISP) that allowed programming without gotos, I nevertheless consider that they have their uses. However, my main objection is to the character of the campaign you launched against them, which seemed to be based on an appeal to snobbery and seemed to encourage more snobbery.

As you see, justified right margins are optional in computer produced documents. Many people share your preference for unjustified lines, but it is wrong to make a moral issue of it. As a matter of taste, I find the backwards words fi and od unpleasing and would prefer parentheses or begins and ends for resolving ambiguities.

I am glad you like the content of Manna's and Waldinger's report. Manna would be an excellent expositor even if his reports had to be incised in clay tablets and baked, but the polished style and the prompt appearance may owe something to the opportunity for frequent revision afforded by computer produced documents. Certainly, this was one of our main reasons for pioneering them at this laboratory. Moreover, we cannot afford the secretarial time required to make several versions of a typescript.

If you felt like distributing this protest to your EWD list, I would be grateful.

Sincerely,
John McCarthy
transcribed by Carl Ludwigson
revised Sun, 9 Sep 2007

Edsger W. Dijkstra, A somewhat open letter to Professor John McCarthy, 1976, EWD551.

Commenti:
---------
*** Robert Giles 28 April 2010 at 05:20
It's very fascinating to me, as a fan of typography & programming, to see two geniuses sperging out over fonts. I think typography is underrated in importance by most people.

*** Unknown 1 March 2011 at 12:41
I tend to agree with McCarthy in just about everything he says in the letter.

I'd really like to know what Dijkstra seems to think is wrong with right justification, thought. Maybe he has a point, but I'm inclined not to think so.

On the post you mentioned at the beginning of this article, he clearly does not understand Lisp nor does he devote much effort in doing so, although he goes on to despise the language based on a single poor written language manual. Had he tried to see beyond the thin layer of Lisp's "atrocious syntax", as he calls it, I believe he would've been able to appreciate the giant leap forward that was Lisp in comparison to what was in use to that day (and actually much of what we still have today).


------------------------------------------
Interesting Case of Mismatched Parentheses
------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/05/interesting-case-of-mismatched.html

  * Programming language: Lisp. One of the most important programming
    languages, and probably the most important if we discuss parentheses.

  * Author: John McCarthy, the creator of Lisp.

  * Article: Recursive Functions of Symbolic Expressions, Communications
    of the ACM, April 1960, probably the most important article on Lisp.

  * Place: definition of arguably the most important function ever: eval.

The holiest place for programmers not afraid of parentheses!

Yet, parentheses do not match there.

This is not typical Lisp S-expression, it is so called "meta expression".

Here is original version of the article:

Fig.1 par-error01.png (nella cartella "data")

And here is the same mismatch in the version retyped using Latex.

Fig.2 par-error02.png (nella cartella "data")

I'll not say where is the error. I'll leave you to play
with that. Here is the text, so you can copy and paste it in
your editor. The simplest way to check my claim that there is
an error is that your editor counts left and right brackets.
Notepad++ says there are 68 left and 66 right brackets here.

eval[e; a] = [
atom [e] -> assoc [e; a];
atom [car [e]] -> [
eq [car [e]; QUOTE] -> cadr [e];
eq [car [e]; ATOM] -> atom [eval [cadr [e]; a]];
eq [car [e]; EQ] -> [eval [cadr [e]; a] = eval [caddr [e]; a]];
eq [car [e]; COND] -> evcon [cdr [e]; a];
eq [car [e]; CAR] -> car [eval [cadr [e]; a]];
eq [car [e]; CDR] -> cdr [eval [cadr [e]; a]];
eq [car [e]; CONS] -> cons [eval [cadr [e]; a]; eval [caddr [e];
             a]]; T -> eval [cons [assoc [car [e]; a];
                                          evlis [cdr [e]; a]]; a]];
eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]];
                        cons [list [cadar [e]; car [e]; a]];
eq [caar [e]; LAMBDA] -> eval [caddar [e];
                             append [pair [cadar [e]; evlis [cdr [e]; a]; a]]]

Some puritans might insist that it is brackets mismatch and not
parentheses mismatch. Wikipedia thinks that brackets are one type
of parentheses.

Of course, I cannot say that it is one of the most important
parentheses mismatches in history of programming. It had no effect
whatsoever, as far as I know.

Herbert Stoyan wrote about this error, and it is mentioned
in Latex version of the McCarthy's article, 1995.

Similar error in Lisp I. Programmer's Manual.

It is brought to my attention that intern unofficial publication,
"LISP I. Programmer's manual" from March 1960, has different definition:

Fig.3 par-error03.png (nella cartella "data")

However, it is also likely wrong. Look at the line with
LABEL, and two occurrences of cdr[e]. With some help of Shubert
who commented this post, I believe that the it should be:

eval[e; a] =
  [
   atom [e] -> assoc [e; a];
   atom [car [e]] ->
     [
      eq [car [e]; QUOTE] -> cadr [e];
      eq [car [e]; ATOM] -> atom [eval [cadr [e]; a]];
      eq [car [e]; EQ] -> [eval [cadr [e]; a] = eval [caddr [e]; a]];
      eq [car [e]; COND] -> evcon [cdr [e]; a];
      eq [car [e]; CAR] -> car [eval [cadr [e]; a]];
      eq [car [e]; CDR] -> cdr [eval [cadr [e]; a]];
      eq [car [e]; CONS] -> cons [eval [cadr [e]; a]; eval [caddr [e]; a]];
      T -> eval [cons [assoc [car [e]; a]; evlis [cdr [e]; a]]; a]
     ];
   eq [caar [e]; LABEL] -> eval [ cons [caddar [e]; cdr [e]];
                                  cons [list [cadar [e]; car [e]]; a]
                                ];
   eq [caar [e]; LAMBDA] -> eval [caddar [e];
                                  append [pair [cadar [e];
                                                evlis [cdr [e]; a]
                                               ];
                                          a
                                         ]
                                 ]
  ]

Similar error in Memo 8.

It is very interesting that error existed also in the third document,
memo of AI project on MIT, 1959, which contains different definition of eval:

Fig.4 par-error04.png (nella cartella "data")

For tried and tested EVAL see my post McCarthy's Lisp in Newlisp.

Commenti:
--------
*** G Shubert 10 May 2010 at 18:50
An editor which shows matching parentheses is a useful tool here. The missing close parenstheses appear to be in the last two eq clauses -- the ones with LABEL and LAMBDA. Change to:

eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]]; cons [list [cadar [e]; car [e]; a]]);

eq [caar [e]; LAMBDA] -> eval [caddar [e]; append [pair [cadar [e]; evlis [cdr [e]; a]; a]]])

I've used ')' to show where I inserted characters. I note that Paul Graham's implementation of eval in Common Lisp has parenthenses in these places.

*** Mark Stock 30 July 2010 at 04:07
If I am reading Paul Graham's implementation of eval in Common Lisp correctly, I think that the ')' goes in a different place for LABEL

eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]]; cons [list [cadar [e]; car [e]); a]];

I think that the second cons function takes two parameters:
list [cadar [e]; car [e]]
a


----------------------------------------------------
Short notes on McCarthy's "Recursive Functions ... "
----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/05/short-notes-on-mccarthys-recursive.html

Vedi "Majorinc-short-notes-on-McCarthys-recursive-functions.pdf" nella cartella "data".


---------------------------------------------------------
Using (sin cos 0.5) instead of (sin (cos 0.5)) in Newlisp
---------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/07/using-sin-cos-05-instead-of-sin-cos-05.html

; Recently, Jeremy Dunn on Newlisp forum expressed desire to use
; the single argument functions in Newlisp in following fashion:
;
;     (sin cos 0.5) = (sin (cos 0.5))
;
; The motivation is well know in Lisp world: avoidance of parentheses.
; I believe that regularity of the Lisp syntax should be preserved
; and that it is better to be consistent, although more verbose.
;
; However, the problem is interesting.
;
; At least two works are already done in Newlisp in that dyrection. Cyril
; Slobin described make-pass macro:
;
;         http://slobin.livejournal.com/148287.html
;
; (define-macro (make-pass)
;   (doargs (arg)
;     (letex ((Old arg)
;             (New (sym (append (string arg) "&"))))
;       (define-macro (New)
;         (Old (eval (args)))))))
;
; (make-pass catch not print)
;
; Here is how it works:
;
; (catch& while (read-line)
;   (setq line (current-line))
;   (if (not& empty? line)
;     (print& format "%s\n" line)
;     (throw 'empty)))
;
; My construct for composition of arbitrary functions
; or fexprs should be mentioned as well.
;
;   http://kazimirmajorinc.blogspot.com/2010/02/composition-of-functions-or-macros.html
;
; Its syntax should be:
;
; ((compose sin cos) 0.5)
;
; Needless to say, compose is "in the spirit" of the Lisp,
; but it is syntactically heavier than original (sin (cos 0.5)).
; And Jeremy didn't liked even Cyril's (sin& cos 5).
;
; So, I adapted Cyril's idea to work without that extra &, but
; then it had to work both like sin& and original sin.

(println (sin 3))
(println (sin (cos 4)))
(println (sin (cos (sin 5))))

; 0.1411200081
; -0.6080830096
; 0.5433319155

(define-macro (make-pass-adapted)
  (doargs (arg)
     (constant arg
        (letex((arg (eval arg)))
           (lambda-macro()
              (arg (eval (if (> (length (args)) 1)
                             (args)
                             (first (args))))))))))

(make-pass-adapted sin cos)

(println (sin (+ (cos 0) (cos 0) (cos 0))))
(println (sin cos 4))
(println (sin cos sin (+ 2 3)))

; 0.1411200081
; -0.6080830096
; 0.5433319155

; I'll test it whether it works with Cyril's example.

 (make-pass-adapted catch not print)

 (catch while (read-line)
   (setq line (current-line))

   (if (not empty? line)
     (print format "%s\n" line)
     (throw 'empty)))

; It's really easy, so I had doubt whether it is important enough
; to blog about that, lets say, sinful sin. However, I noticed
; that it is interesting example of the function that is replaced
; with FEXPR.


---------------------------------------------------------
McCarthy's 1960 "Recursive Functions ..." Lisp in Newlisp
---------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/08/mccarthys-1960-recursive-functions-lisp.html

;===============================================================
;
; McCarthy's Lisp, as described in  "Recursive functions", 1960,
; (40+ functions and operators)  is implemented in Newlisp. I'll
; use the term "McCarthy60 Lisp" for that dialect.
;
;     http://www-formal.stanford.edu/jmc/recursive.html
;
; As  syntax  of  Newlisp  and  McCarthy60  Lisp  are  the same,
; implementation  is  very  simple:  it  is   enough  to  define
; McCarthy60  Lisp functions  and operators as Newlisp functions
; or eventually, fexprs. It is convenient that Newlisp functions
; use lower case letters, while McCarthy60 Lisp uses upper case.
;
; There  are  some  important  differences  between  Newlisp and
; McCarthy60  Lisp.  Newlisp  doesn't  have  dottedpairs, it has
; lists only.  McCarthy60 Lisp uses T for 'true' and F (not NIL)
; for 'false'.  Newlisp uses true and nil.  In some Lisp dialect
; without   these   two   differences,   for   example,  Scheme,
; implementation could be even simpler. However, taking this into
; consideration, Newlisp and McCarthy60 Lisp can be mixed freely.
;
; The implementation could be of  interest for those who want to
; understand  and  who  are  not   sure   about   some  details,
; particularly because there are few errors in original article,
; as recently discussed in this blog.
;
; There  are lot of  comments and  examples "apostrophed out" in
; code.
;
; If you have some comment, or you think something could be done
; better, I'd like to hear it.
;
; Inspired by MARK STOCK'S recent project
;
;      http://hoop-la.ca/apple2/2010/retrochallenge.html
;
; Much more geeky than this one.
;
; Another very  useful discussion is Paul Graham's "The Roots of
; Lisp."
;
;         http://www.paulgraham.com/rootsoflisp.html
;
;---------------------------------------------------------------

   (set '[println.supressed] true)
   (load "http://www.instprog.com/Instprog.default-library.lsp")
   (set '[println.supressed] nil)

;---------------------------------------------------------------
; Newlisp has not dotted pairs, so they are emulated here.
;---------------------------------------------------------------

(define (dotform-atom? L)
  (atom? L))

(define (dotform-base? L)
  (and (list? L)
        (= (length L) 3)
        (= (nth 1 L) '.)))

(define (dotform-recursive? L)
   (or (dotform-atom? L)
        (and (dotform-base? L)
              (dotform-recursive? (first L))
              (dotform-recursive? (last L)))))

(define (listform-atom?)
   (and (atom? L)
         (not (= L 'NIL))))

(define (listform-base? L)
   (and (list? L)
         (not (dotform-base? L))))

(define (listform-recursive? L)
  (or (listorm-atom? L)
       (and (listform-base? L)
             (for-all? listform-recursive? L))))

(define (dotform L)
  (cond ((dotform-atom? L) L)
         ((dotform-base? L) (list  (dotform (first L))
                                    '.
                                    (dotform (last L))))
         ((= (length L) 0) 'NIL)
         ((> (length L) 0) (list (dotform (first L))
                                  '.
                                  (dotform (rest L))))))

(define (listform L)
  (cond ((listform-atom? L) L)
         ((= L '()) L)
         ((listform-base? L) (cons (listform (first L))
                                    (listform (rest L))))
         ((= L 'NIL) '())
         ((dotform-base? L) (let((L1 (listform (first L)))
                                 (L2 (listform (last L))))
                                (if (listform-base? L2)
                                    (cons L1 L2)
                                    (list L1 '. L2))))))

(define (listform-args L)
   (cond ((empty? L) L)
         ((= (first L) (quote .))(listform (rest L)))
         (true (listform L))))

  '(println= (listform-args '()))
  '(println= (listform-args '(. OOOPS)))
  '(println= (listform-args '(a b c d)))

(dolist (X '(NIL                    ()                       (())
            (NIL)                   ((NIL))                  (NIL . (NIL . NIL))
            ((NIL . NIL) . NIL)     ((A . NIL) . (B . NIL))  (A)
            (A . B)                 (() . ())                (B . (C))
            (A B C)))
        '(println= X (dotform X) (listform X)))

;===============================================================
; DEFINITION OF FEW BASIC OPERATORS.
; THESE OPERATORS ARE ELEMENTS OF META-LANGUAGE, DEFINED IN
; META-META-LANGUAGE (Newlisp)
;---------------------------------------------------------------

      (define-macro (COND)
         (letn((done nil)
               (result nil)
               (arglist (args))
               (largs (listform-args (args))))
             (dolist(clause largs done)
                 (when (= (eval (nth 0 clause)) 'T)
                       (setf result (eval (nth 1 clause)))
                       (setf done true)))
             (if (not done)
                 (throw-error "COND without any alternative satisfied.")
                 result)))

      (define-macro (AND)
         (letn((arglist (args))
               (largs (listform arglist)))
          (if (eval (cons 'and (map (lambda(x)(expand '(= x (quote T))
                                                      'x))
                                     largs)))
              (quote T)
              (quote F))))

          '(println= (AND 1 2) "should be F." )

     (define-macro (OR)
          (letn((arglist (args))
                (largs (listform arglist)))
              (if (eval (cons 'or (map (lambda(x)(expand '(= x (quote T))
                                                         'x))
                                        largs)))
                  (quote T)
                  (quote F))))

      (define-macro (NOT x)
         (let ((lx (listform x)))
          (if (= (eval lx) (quote T))
              (quote F)
              (if (= (eval lx) (quote F))
                  (quote T)
                  (throw-error
                    " NOT called with argument evaluating to T OR F.")))))

         '(println= (NOT (quote T)) (NOT (quote F))
                    "should be F AND T respectively.")

      ;---------------------------------------------------------------
      ; ABBREVIATION LIST
      ;
      ; STATUS OF THE ABBREVIATION LIST IS NOT CLEAR, i.e. IS IT DEFINED USING
      ; BOTH META-LANGUAGE OR IN META-META-LANGUAGE.
      ;
      ; AS IT CANNOT BE S-FUNCTION I THINK IT iS BEST TO CONSIDER IT AS
      ; ANOTHER SPECIAL OPERATOR OF META-LANGUAGE DEFINED IN META-META-LANGUAGE,
      ; SIMILAR TO COND.
      ;
      ; (LIST (quote e1) ... (quote en)) => (e1 . (... . (en . NIL)))
      ;---------------------------------------------------------------

      (define (LIST)
        (let((a (args)))
            (cond ((empty? a) (quote NIL))
                  ((quote T) (list (dotform (first a))
                                   '. (dotform (rest a)))))))

          '(println= (listform (LIST (quote e1) (quote e2)
                                     (quote ...) (quote en)))
                     "should be (e1 e2 ... en).")

      ;---------------------------------------------------------

      (define-macro (QUOTE x) x)
          '(println= (QUOTE (X X)) "should be (X X).")

      ;---------------------------------------------------------

      (define-macro (LAMBDA)
           (append (lambda) (args)))

        '(println ((LAMBDA(x)x) (QUOTE A)))

      ;---------------------------------------------------------

      (define-macro (LABEL)
        (let((l1 (first (args)))
             (l2 (last (args))))
            ;(println l1 l2)
            (set l1 (eval l2))))

;===============================================================
; FIVE ELEMENTARY S-FUNCTIONS.
;
; THESE S-FUNCTIONS ARE ELEMENTS OF THE META LANGUAGE, AND THEY ARE
; DEFINED IN META-META-LANGUAGE (NEWLISP).
;
; ALL S-FUNCTIONS ACCEPT ARGUMENTS IN FORM (A . B) AND (A B).

;---------------------------------------------------------------
; 1. ATOM
;---------------------------------------------------------------

(define (ATOM x)
        (if (atom? (dotform x)) (quote T) (quote F)))

'(println= (ATOM 'X) "should be T.")
'(println= (ATOM '(X . A)) "should be F.")

;---------------------------------------------------------------
; 2. EQ
;---------------------------------------------------------------

(define (EQ x y)
        (let((x (dotform x))
             (y (dotform y)))
          (if (and (atom? (dotform x)) (atom? (dotform y)))
              (if (= x y) (quote T) (quote F))
              (throw-error (string "** EQ undefined for " x " AND " y "**")))))

'(println= (EQ 'X 'X) "should be T.")
'(println= (EQ 'X 'A) "should be F.")
'(println= (EQ 'X '(X . A)) "should be undefined.")

;---------------------------------------------------------------
; 3. CAR
;---------------------------------------------------------------

(define (CAR x)
  (let ((x (dotform x)))
     (cond ((= x 'NIL) (throw-error "CAR undefined for NIL."))
            ((atom? x)
             (throw-error (string "CAR undefined for atomic symbol " x)))
            (true (first x)))))

'(println= (CAR '(X . A)) "should be X.")
'(println= (CAR '((X . A) . Y)) "should be (X . A).")

;---------------------------------------------------------------
; 4. CDR
;---------------------------------------------------------------

(define (CDR x)
  (let ((x (dotform x)))
     (cond ((= x 'NIL)
               (throw-error "CAR undefined for NIL."))
           ((atom? x)
               (throw-error (string "CDR undefined for atomic symbol " x)))
           (true (last x)))))

'(println= (CDR '(X . A)) "should be A.")
'(println= (CDR '((X . A) . Y)) "should be Y.")

;---------------------------------------------------------------
; 5. CONS
;---------------------------------------------------------------

(define (CONS x y)
     (let ((x (dotform x))
           (y (dotform y)))
           (list x '. y)))

'(println= (CONS 'X 'A) "should be (X . A).")
'(println= (CONS '(X . A) 'Y) "should be ((X . A). Y).")

;---------------------------------------------------------------
; DEFINITION OF IMPORTANT S-FUNCTIONS IN META-LANGUAGE
; STRICTLY FOLLOWED MCCARTHY'S ARTICLE. LOOK EXAMPLES AS BEST
; EXPLANATION

;---------------------------------------------------------------
; FF
;
; Returns first element of the LIST recursively
;---------------------------------------------------------------

(define (FF x)
        (COND ((ATOM x) x)
              ((QUOTE T) (FF (CAR x)))))

'(println= (FF (QUOTE A)) "should be A.")
'(println= (FF (QUOTE ((A . B) . C))) "should be A.")
'(println= (FF (QUOTE (((D) . B) . C))) "should be D.")

;---------------------------------------------------------------
; SUBST
;
; (SUBST x y z) returns result of substitution of x for y in z
;---------------------------------------------------------------

(define (SUBST x y z)
        (COND ((ATOM z) (COND ((EQ z y) x)
                              ((QUOTE T) z)))
              ((QUOTE T) (CONS (SUBST x y (CAR z))
                               (SUBST x y (CDR z))))))

'(println= (SUBST (QUOTE (X . A)) (QUOTE B) (QUOTE ((A . B) . C)))
          "should be ((A . (X . A)) . C)")

;---------------------------------------------------------------
; EQUAL
;
; Generalization of S-function EQ for all s-expressions.
;---------------------------------------------------------------

(define (EQUAL x y)
        (OR (AND (ATOM x) (ATOM y) (EQ x y))
            (AND (NOT (ATOM x))
                 (NOT (ATOM y))
                 (EQUAL (CAR x) (CAR y))
                 (EQUAL (CDR x) (CDR y)))))

'(println= (EQUAL (QUOTE (A . B)) (QUOTE (A . B))) "should be T")

;---------------------------------------------------------------
; NULL
;---------------------------------------------------------------

(define (NULL x)
        (AND (ATOM x) (EQ x (QUOTE NIL))))

'(println= (NULL (QUOTE NIL)) "should be T")

;---------------------------------------------------------------
; S-functions CAAR, CADR etc
;
; (CADDAR x) = (CAR (CDR (CDR (CAR x))))
;---------------------------------------------------------------

(define (CAAR   x)(CAR (CAR   x)))
(define (CADR   x)(CAR (CDR   x)))
(define (CDAR   x)(CDR (CAR   x)))
(define (CDDR   x)(CDR (CDR   x)))
(define (CAAAR  x)(CAR (CAAR  x)))
(define (CAADR  x)(CAR (CADR  x)))
(define (CADAR  x)(CAR (CDAR  x)))
(define (CADDR  x)(CAR (CDDR  x)))
(define (CDAAR  x)(CDR (CAAR  x)))
(define (CDADR  x)(CDR (CADR  x)))
(define (CDDAR  x)(CDR (CDAR  x)))
(define (CDDDR  x)(CDR (CDDR  x)))
(define (CADDAR x)(CAR (CDDAR x)))

            ;-------------------------------------------------
            ; THIS IS HOW IT CAN BE DONE IN META-META-LANGUAGE

            ; (let((L '(CAR CDR))
            ;      (n 10000))
            ;    (dotimes(i (/ n 2))
            ;      (let ((s (pop L)))
            ;        (dolist(j '(CAR CDR))
            ;          (set 's0 (sym (APPEND (chop (string j)) (rest (string s)))))
            ;          (set s0 (expand (lambda(x)(j (s x))) 's 'j))
            ;          (push s0 L -1)))))
            ;

'(dolist (i '(CAR CDR
             CAAR  CADR  CDAR  CDDR
             CAAAR CAADR CADAR CADDR
             CDAAR CDADR CDDAR CDDDR))
    (eval (expand '(println= (i (QUOTE (((1 . 2).(3 . 4)).((5 . 6).(7 . 8))))))
                  'i)))

;---------------------------------------------------------------
; S-FUNCTIONS USEFUL WHEN S-EXPRESSIONS ARE REGARDED AS LISTS
; DEFINED IN META-LANGUAGE IN MCCARTHY'S PAPER
;---------------------------------------------------------------

;---------------------------------------------------------------
; 1. APPEND
;---------------------------------------------------------------

(define (APPEND x y)
    (COND ((NULL x) y)
          ((QUOTE T) (CONS (CAR x) (APPEND (CDR x) y)))))

'(println= (listform (APPEND (QUOTE (A B)) (QUOTE (C D E))))
          "should be (A B C D E).")

;---------------------------------------------------------------
; 2. AMONG
;
; (AMONG (QUOTE <s>) (QUOTE <l>))
;
; returns T if <s> is element of the LIST <l>
;         F otherwise
;
;---------------------------------------------------------------

(define (AMONG x y)
        (AND (NOT (NULL y))
             (OR (EQUAL x (CAR y))
                 (AMONG x (CDR y)))))

'(println= (AMONG (QUOTE X) (QUOTE (A B X C))) "should be T.")
'(println= (AMONG (QUOTE X) (QUOTE (A B D C))) "should be F.")

;---------------------------------------------------------------
; PAIR
;
; (PAIR (QUOTE (<s1> ... <sn>)) (QUOTE (<t1> ... <tn>))) =>
;       ((<s1> <t1>) ... (<sn> <tn>))
;---------------------------------------------------------------

(define (PAIR x y)
        (COND ((AND (NULL x) (NULL y)) (QUOTE NIL))
              ((AND (NOT (ATOM x)) (NOT (ATOM y))) (CONS (LIST (CAR x) (CAR y))
                                                         (PAIR (CDR x) (CDR y))))))

'(println= (listform (PAIR (QUOTE (A B C)) (QUOTE (X (Y Z) U))))
          "should be ((A X)(B (Y Z)) (C U))")

;---------------------------------------------------------------
; ASSOC
;
; ASSOC returns the "value" of variable x in "association LIST" y.
; for example,
;
;  (ASSOC (QUOTE X) (QUOTE ((W (A B)) (X (C D)) (Y (E F)))))
;
; returns (C D).
;
; If variable is NOT "stored" in association LIST, then there
; will be error in attempt to find CAAR of empty list.

(define (ASSOC x y)
  (COND ;((AND (ATOM y)
        ;  (EQ y (QUOTE NIL))) (throw-error "ASSOC " x " in " y " is impossible."))
        ((EQ (CAAR y) x) (CADAR y))
        ((QUOTE T) (ASSOC x (CDR y)))))

'(println= (listform (ASSOC (QUOTE X) (QUOTE ((W (A B)) (X (C D)) (Y (E F))))))
          "should be (C D).")

;---------------------------------------------------------------
; SUBLIS (substitution defined by LIST).
;---------------------------------------------------------------

(define (SUB2 x z)
        (COND ((NULL x) z)
              ((EQ (CAAR x) z) (CADAR x))
              ((QUOTE T) (SUB2 (CDR x) z))))

(define (SUBLIS x y)
        (COND ((ATOM y) (SUB2 x y))
              ((QUOTE T) (CONS (SUBLIS x (CAR y))
                               (SUBLIS x (CDR y))))))

'(println= (listform (SUBLIS (QUOTE ((X (A B)) (Y (B C))))
                            (QUOTE (A . (X . Y)))))
          "should be (A (A B) B C).")

;---------------------------------------------------------------
; APPQ
;
; (APPQ (QUOTE (<expr1> ... <exprn>)))
;
;                        ===> ((QUOTE <expr1>)...(QUOTE <exprn>))
;---------------------------------------------------------------

(define (APPQ m)
        (COND ((NULL m) (QUOTE NIL))
              ((QUOTE T) (CONS (LIST (QUOTE QUOTE) (CAR m))
                               (APPQ (CDR m))))))

'(println= (listform (APPQ (QUOTE ((+ 1 1) 2 3))))
         "should be ((QUOTE (+ 1 1)) (QUOTE 2) (QUOTE 3)).")

;---------------------------------------------------------------
; EVAL
;
; in original code there is no branching on EVAL-QUOTE and similar
; functions, but this version is not significantly different, but
; it is much more practical for experiments.
;---------------------------------------------------------------

(define (EVAL e a)
   (COND ((ATOM e) (ASSOC e a))
         ((ATOM (CAR e))

             (COND ((EQ (CAR e) (QUOTE QUOTE)) (EVAL-QUOTE e a))
                   ((EQ (CAR e) (QUOTE ATOM))  (EVAL-ATOM e a))
                   ((EQ (CAR e) (QUOTE EQ))    (EVAL-EQ e a))
                   ((EQ (CAR e) (QUOTE COND))  (EVAL-COND e a))
                   ((EQ (CAR e) (QUOTE CAR))   (EVAL-CAR e a))
                   ((EQ (CAR e) (QUOTE CDR))   (EVAL-CDR e a))
                   ((EQ (CAR e) (QUOTE CONS))  (EVAL-CONS e a))
                   ((QUOTE T)                  (EVAL-REST e a))))

         ((EQ (CAAR e) (QUOTE LABEL))          (EVAL-LABEL e a))
         ((EQ (CAAR e) (QUOTE LAMBDA))         (EVAL-LAMBDA e a))
         ((QUOTE T)
             (throw-error
                (string "EVAL unexpected case, e=" e ", a=" a ".")))))

    ;-----------------------------------------------------------------+
    ; EVCON:                                                          |
    ;                                                                 |
    ; (EVCON (QUOTE ((<p1> <e1>)..(<pn> <en>))) <a>) =                |
    ;                                                                 |
    ; calculates (EVAL <p1> <a>), (EVAL <p2> <a>),... until it find   |
    ; first (EVAL <pi> <a>) that evaluates to T.                      |
    ;                                                                 |
    ; Then it returns (EVAL <ei> <a>).                                |
    ;-----------------------------------------------------------------+

        (define (EVCON c a)
                (COND ((EVAL (CAAR c) a) (EVAL (CADAR c) a))
                      ((QUOTE T)         (EVCON (CDR c) a))))

    ;---------------------------------------------------------------
    ; EVLIS:
    ;
    ; (EVLIS (QUOTE (<expr1> ... <exprn>)) a)    =>   (<r1> ... <rn>)
    ;
    ; where <ri> = result of the (EVAL (QUOTE <expri> a))
    ;---------------------------------------------------------------

        (define (EVLIS m a)
                (COND ((NULL m)  (QUOTE NIL))
                      ((QUOTE T) (CONS (EVAL (CAR m) a)
                                       (EVLIS (CDR m) a)))))

        ;-------
        ; (EVAL (QUOTE (QUOTE expr1)) a) evaluates to expr1

        (define (EVAL-QUOTE e a)
           (CADR e))

           '(println= (EVAL (QUOTE (QUOTE A)) (QUOTE ()))
                      "should be A")

        ;-------

        (define (EVAL-ATOM e a)
           (ATOM (EVAL (CADR e) a)))

           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((X A))))
                      "should be T.")
           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((Y OH)(X NIL))))
                      "should be T.")
           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((X (A)))))
                      "should be F.")

        ;-------

        (define (EVAL-EQ e a)
           (EQ (EVAL (CADR e) a) (EVAL (CADDR e) a)))

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE B))) (QUOTE NIL))
                      "should be F.")
           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE A))) (QUOTE NIL))
                      "should be T.")
           '(println= (EVAL (QUOTE (EQ X (QUOTE A))) (QUOTE ((X A))))
                      "should be T.")

        ;-------

        (define (EVAL-COND e a)
           (EVCON (CDR e) a))

           '(println= (EVAL (QUOTE (COND ((ATOM X)(QUOTE FIRST-CHOICE))
                                        ((QUOTE T)(QUOTE SECOND-CHOICE))))
                           (QUOTE ((X Z))))
                     "should be FIRST-CHOICE.")

           '(println= (EVAL (QUOTE (COND ((ATOM X)(QUOTE FIRST-CHOICE))
                                        ((QUOTE T)(QUOTE SECOND-CHOICE))))
                           (QUOTE ((X (EXTRA Z)))))
                     "should be SECOND-CHOICE.")

        ;-------

        (define (EVAL-CAR e a)
           (CAR (EVAL (CADR e) a)))

           '(println= (EVAL (QUOTE (CAR (QUOTE (X Y))))
                            (QUOTE ((A B))))
                     "should be X.")

        ;-------

        (define (EVAL-CDR e a)
           (CDR (EVAL (CADR e) a)))

             '(println= (listform (EVAL (QUOTE (CDR (QUOTE (X Y))))
                                        (QUOTE ((A B)))))
                     "should be (Y).")

        ;-------

        (define (EVAL-CONS e a)
           (CONS (EVAL (CADR e) a)
                 (EVAL (CADDR e) a)))

                 '(println= (EVAL (QUOTE (CONS (QUOTE X) (QUOTE Y)))
                                  (QUOTE ((X Z))))
                         "should be (X . Y).")

                 '(println= (EVAL (QUOTE (CONS X (QUOTE Y)))
                                  (QUOTE ((X Z))))
                         "should be (Z . Y).")

    ;-------------------------------------------------------
    ; EVAL-REST is the strangest rule for evaluation, from modern point
    ; of view. It is used for evaluation of the lists of the form
    ;
    ;     (FUN <expr1> <expr2> ... <exprn>)
    ;
    ;
    ; where FUN is some user-defined symbol, so EVAL search its
    ; value in association list a given as argument. EVAL first
    ; calculate the LIST of the evaluated elements
    ;
    ;    (<efun> (EVAL <expr1> a) ... (EVAL <exprn> a))
    ;
    ; and result is then evaluated once again. Some people, for
    ; example, Paul Graham in his paper "Roots of Lisp" suggests
    ; that this is bug, AND I believe he is right. Instead of that,
    ; it will be evaluated as
    ;
    ;    ((ASSOC FUN a) <expr1> ... <exprn>)
    ;-------------------------------------------------------

        (define (EVAL-REST e a)
           (EVAL (listform (CONS (ASSOC (CAR e) a)
                                 (CDR e))) ; This (CDR e) is used
                                           ; instead of original version
                                           ; (EVLIS (CDR e) a),
                                           ; that is likely bug.
                 a))

                '(println= (EVAL (QUOTE (P (QUOTE (QUOTE A))))
                                (QUOTE ((P ATOM))))
                          "should be F.")

                '(println= (EVAL (QUOTE (P (QUOTE (QUOTE (QUOTE A)))))
                                (QUOTE ((P ATOM))))
                          "should be F.")

                '(println= (EVAL (QUOTE (P (QUOTE A)))
                                (QUOTE ((P R)(R S)(S ATOM))))
                          "should be T.")

                '(println= (listform (EVAL (QUOTE (P (QUOTE (X)) (QUOTE (Y))))
                                          (QUOTE ((P R)(R CONS)))))
                          "should be ((X) Y).")

        ;-------------------------------------------------------
        ; LAMBDA-expressions are evaluates by transforming
        ;
        ;  (EVAL (QUOTE ((LAMBDA(p1...pn) expr) expr1 ... exprn))
        ;        (QUOTE ((a1 e1)...(am em))))
        ;
        ; to
        ;
        ;  (EVAL (QUOTE expr)
        ;        (QUOTE ((p1 expr1)...(pn exprn)(a1 e1) ...(an em))))
        ;
        ; and transformed expression is evaluated and result is returned.
        ;-------------------------------------------------------

        (define (EVAL-LAMBDA e a)
           (EVAL (CADDAR e)
                 (listform (APPEND (PAIR (CADAR e) (EVLIS (CDR e) a)) a))))

           '(println= (listform (EVAL (QUOTE ((LAMBDA (X)
                                                  (CONS X (QUOTE NIL)))
                                              (QUOTE A)))
                                     (QUOTE (()))))

                     "should be (A).")

           '(println= (listform (EVAL (QUOTE ((LAMBDA (X)(CONS X (QUOTE NIL)))
                                              (CONS G (QUOTE NIL))))
                                      (QUOTE ((G (HOP-CUP-POSKOCIT-CU))))))

                     "should be (((HOP-CUP-POSKOCIT-CU))).")

        ;-------------------------------------------------------
        ; LABEL-expressions are evaluated by transforming
        ;         ;
        ; (EVAL (QUOTE ((LABEL f (LAMBDA...)) expr1 ... exprn))
        ;       (QUOTE ((a1 e1)...(am em))))
        ;
        ; to
        ;
        ; (EVAL (QUOTE ((LAMBDA ...) expr1 ... exprn))
        ;       (QUOTE ((f (LABEL f (LAMBDA...)))(a1 e1)...(am em))))
        ;
        ; and transformed expression is evaluated, and result is returned.
        ;
        ; Locally, it is enough to define label once, it will work:
        ;
        ;  (EVAL(QUOTE ((LABEL f (LAMBDA(X)(CONS X (CONS X (QUOTE NIL)))))
        ;               (f (f (f (f (f (f (f (f (f (QUOTE A))))))))))))
        ;               (QUOTE ()))
        ;-------------------------------------------------------

        (define (EVAL-LABEL e a)
           (EVAL (listform (CONS (CADDAR e) (CDR e)))
                 (listform (CONS (LIST (CADAR e) (CAR e)) a))))

           '(println= (EVAL-LABEL (QUOTE ((LABEL f (LAMBDA (X Y)(CONS X Y)))
                                (QUOTE (A))
                                (QUOTE (B))))
                        (QUOTE ((A1 E1)(A2 E2)))))

           '(println= (EVAL-LABEL
               (QUOTE ((LABEL f (LAMBDA(X)(CONS X (CONS X (QUOTE NIL)))))
                       (f (g (f (g (f (g (f (g (f (QUOTE A))))))))))))
               (QUOTE ((g (LAMBDA(Y)(CONS Y (CONS (QUOTE 1) (QUOTE NIL)))))))))

           '(println= (listform
               (EVAL (QUOTE ((LABEL SUBST
                              (LAMBDA (X Y Z)
                                  (COND ((ATOM Z)
                                         (COND ((EQ Y Z) X)
                                               ((QUOTE T) Z)))
                                        ((QUOTE T)
                                             (CONS (SUBST X Y (CAR Z))
                                                   (SUBST X Y (CDR Z)))))))
                             (QUOTE (A)) (QUOTE B) (QUOTE (Z B C))))

                    (QUOTE (()))))
                "should be (Z (A) C).")

           '(println= (listform
              (EVAL (QUOTE (SUBST (QUOTE (A)) (QUOTE B) (QUOTE (Z B C))))
                    (QUOTE ((SUBST
                            (LAMBDA (X Y Z)
                                (COND ((ATOM Z)
                                       (COND ((EQ Y Z) X)
                                             ((QUOTE T) Z)))
                                      ((QUOTE T)
                                           (CONS (SUBST X Y (CAR Z))
                                                 (SUBST X Y (CDR Z)))))))))))
               "should be (Z (A) C).")

           '(println= (listform (EVLIS (QUOTE (A . NIL))
                                      (QUOTE ((POKOS CAR)(A (X Y))))))
                     "should be ((X Y)).")

           '(println= (EVAL (QUOTE A) (QUOTE ((A VAL))))
                     "should be VAL.")

           '(println= (EVAL (QUOTE B)
                           (QUOTE ((A  VAL1) (B VAL2) (C VAL3))))
                     "should be VAL2.")

           '(println= (EVAL (QUOTE (QUOTE A)) (QUOTE ((A VAL))))
                     "should be A.")

           '(println= (EVAL (QUOTE (ATOM (QUOTE A)) (QUOTE ((T1 T2)))))
                     "should be T.")

           '(println= (EVAL (QUOTE (ATOM A)) (QUOTE ((A VAL))))
                     "should be T.")

           '(println= (EVAL (QUOTE (ATOM A)) (QUOTE ((A (VAL)))))
                     "should be F.")

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE A))) (QUOTE NIL))
                     "should be T.")

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE B))) (QUOTE NIL))
                     "should be F.")

           '(println= (EVAL (QUOTE (EQ A B)) (QUOTE ((A Z)(B Z))))
                     "should be T.")

           '(println= (EVAL (QUOTE (EQ A B)) (QUOTE ((A Y)(B Z))))
                     "should be F.")

           '(println= (EVAL (QUOTE (COND ((QUOTE T) (QUOTE A))))
                           (QUOTE ((A HI))))
                     "should be A.")

           '(println= (EVAL (QUOTE (COND ((QUOTE F) (QUOTE A))
                                        ((QUOTE T) B)))
                           (QUOTE ((B HI))))
                     "should be HI.")

           '(println= (EVAL (QUOTE (CAR (QUOTE ((A B) (C D)))))
                           (QUOTE ((A X))))
                     "should be (A . (B . NIL)).")

           '(println= (EVAL (QUOTE (CDR (QUOTE ((A B) (C D)))))
                           (QUOTE ((A X))))
                     "should be ((C . (D . NIL)) . NIL).")

           '(println= (EVAL (QUOTE (CONS A (QUOTE B)))
                           (QUOTE ((A X) (B Y))))
                     "should be (X . B).")

           '(println= (EVAL (QUOTE V2)
                           (QUOTE ((V1 X) (V2 Y) (V3 Z))))
                     "should be Y.")

;---------------------------------------------------------------
; APPLY
;---------------------------------------------------------------

(define (APPLY f a)
  (EVAL (CONS f (APPQ a)) (QUOTE NIL)))

'(println (APPLY (QUOTE CONS) (QUOTE (A (B)))))

(println "Definition of McCarthy60 Lisp for Newlisp.")
(println "Kazimir Majorinc, 2010.")
(println "\nAvailable functions and operators: \n")

(println "AMONG, AND, APPEND, APPLY APPQ, ASSOC, ATOM, CAR, CDR, C...R,\n"
         "COND, CONS, EVAL, EQ, EQUAL, EVCON, EVLIS, FF, LABEL, LAMBDA, \n"
         "LIST, NOT, OR, PAIR, QUOTE, SUB2, SUBLIS, SUBST.\n\n"
         "listform, dotform, debug-wrap, debug-unwrap\n"

         "Can be used and combined with other Newlisp functions.")

(println "\n")

(dolist(i '(((listform (QUOTE (A . (B)))))
            ((dotform (QUOTE (A . (B)))))
            ((CONS (QUOTE (X Y)) (QUOTE (Y Z))))
            ((listform (CONS (QUOTE (X Y)) (QUOTE (Y Z)))))
            ((time (cons (quote (X Y Z)) (quote (Y Z V))) 10000))
            ((time (CONS (QUOTE (X Y Z)) (QUOTE (Y Z V))) 1000))
            ((time (EVAL (QUOTE (CONS (QUOTE (X Y Z)) (QUOTE (Y Z V))))) 100))
            ((debug-wrap CONS)
             (CONS (CONS (QUOTE (X Y)) (QUOTE NIL)) (QUOTE (Y Z))))
            ((debug-unwrap CONS)(CONS (QUOTE (X Y)) (QUOTE (Y Z))))))
   (println "            Example "
            (+ $idx 1) ". \n")
   (println "Evaluation of:\n")
   (dolist(j i)(println "   " j))
   (println "\nproduces output:\n")
   (local(k)
   (dolist(j i)
     (setf k (eval j)))
   (println "\nand result:\n")
   (println "   " k "\n-----------------------------------")))


--------------------------------------------------------------------
McCarthy-60 Lisp Implemented as Association List in McCarthy-60 Lisp
--------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/08/mccarthy-60-lisp-implemented-as.html

; In my last post, McCarthy-60 Lisp in Newlisp

;  (1) McCarthy-60 Lisp, the version from his "Recursive functions..."
;      paper was defined in Newlisp. "Defined" because Newlisp is
;      Lisp, so McCarthy-60 Lisp functions (and special operators)
;      can be "just defined" as Newlisp functions and special
;      operator. Such a Newlisp + defined function behaves like
;      original McCarthy's Lisp. I guess that it could be done
;      even more easily in Lisp dialects more similar to McCarthy
;      60 Lisp, for example, Picolisp or Scheme.

;  (2) The legendary McCarthy's function EVAL was defined. Some
;      care was required, because the function as defined in McCarthy's
;      article, but also in other contemporary manuals and memos
;      had errors. Paul Graham's paper "The Roots of Lisp" can be
;      recommended.

; In this post another instance of McCarthy-60 Lisp running on top
; of that is implemented.

; For clarity, different keywords will be used in each "instance"
; of Lisp. For example, if we write:
;
;     (lambda(xx)(cons xx (cons xx (quote ()))))
;
; in Newlisp, then
;
;     (LAMBDA(XX)(CONS XX (CONS XX (QUOTE ()))))
;
; will be used in McCarthy-60 Lisp defined in Newlisp, and also
;
;     (LAMBDA.1(XX)(CONS.1 XX (CONS.1 XX (QUOTE.1 ()))))
;
; in McCarthy-60 Lisp interpreted in previous Lisp. And also
;
;     (LAMBDA.2(XX)(CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
;
; in McCarthy-60 Lisp interpreted in previous Lisp, described in
; this post.
;
;
;
;                       --------------
;
;
; McCarthy-60 EVAL has two arguments:
;
;                       (EVAL <e> <a>)
;
; where <e> is expression that is evaluated, and <a> is association
; list that contains values of the functions and variables used in
; <e>. For example, <a> might look like:
;
;         ((X 37)(f (LAMBDA.1(x)(CONS.1 x (QUOTE.1 NIL)))))
;
; if X or f occurs in <e>, the respective values will be used.
; McCarthy-60 EVAL is not very efficient, but is conceptually
; simple.
;
; Such definition of EVAL allows definition of whole interpreters
; as association list, and that's what is described in this post:
; interpreter of McCarthy-60 Lisp, in the form of association
; list that can be supplied to - McCarthy-60 Lisp.
;
; This is how this interpreter looks like:

(setf McCarthy-60-interpreter

 '(QUOTE

    (
      ;-------------------------
      (EVAL.1 (LABEL.1 EVAL.1
         (LAMBDA.1 (e a)
            (COND.1
               ((ATOM.1 e) (ASSOC.1 e a))
               ;-------------------------
               ((ATOM.1 (CAR.1 e))

                (COND.1

                    ((EQ.1 (CAR.1 e) (QUOTE.1 QUOTE.2))
                           (CAR.1 (CDR.1 e)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 ATOM.2))
                           (ATOM.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 EQ.2))
                           (EQ.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                         a)
                                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                         a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 COND.2))
                           (EVCON.1 (CDR.1 e) a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 AND.2))
                       (EVAL.1 (CONS.1 (QUOTE.1 COND.2)
                                  (CONS.1 (CDR.1 e)
                                     (QUOTE.1 (((QUOTE.2 T)
                                                (QUOTE.2 F))))))
                               a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CAR.2))
                           (CAR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CDR.2))
                           (CDR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CONS.2))
                           (CONS.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)
                                   (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                           a)))
                    ;-------------------------
                    ((QUOTE.1 T) (EVAL.1 (CONS.1 (ASSOC.1 (CAR.1 e)
                                                          a)
                                                 (CDR.1 e))
                                         a))))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LABEL.2))
                    (EVAL.1 (CONS.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                                    (CDR.1 e))
                            (CONS.1 (LIST.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                            (CAR.1 e))
                                    a)))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LAMBDA.2))
                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                         (APPEND.1 (PAIR.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                           (EVLIS.1 (CDR.1 e) a))
                                   a)))

       ))))
      ;-------------------------
      (APPEND.1 (LABEL.1 APPEND.1
         (LAMBDA.1(X Y)
            (COND.1 ((NULL.1 X) Y)
               ((QUOTE.1 T)
                   (CONS.1 (CAR.1 X) (APPEND.1 (CDR.1 X) Y)))))))
      ;-------------------------
      (ASSOC.1 (LABEL.1 ASSOC.1
         (LAMBDA.1 (X Y)
            (COND.1
               ((EQ.1 (CAR.1 (CAR.1 Y)) X) (CAR.1 (CDR.1 (CAR.1 Y))))
               ((QUOTE.1 T)                (ASSOC.1 X (CDR.1 Y)))))))
      ;-------------------------
      (PAIR.1 (LABEL.1 PAIR.1
         (LAMBDA.1 (X Y)
            (COND.1 ((AND.1 (NULL.1 X) (NULL.1 Y)) (QUOTE.1 NIL))
                    ((AND.1 (NOT.1 (ATOM.1 X)) (NOT.1 (ATOM.1 Y)))
                            (CONS.1 (LIST.1 (CAR.1 X) (CAR.1 Y))
                                    (PAIR.1 (CDR.1 X) (CDR.1 Y))))))))
      ;-------------------------
      (EVLIS.1 (LABEL.1 EVLIS.1
         (LAMBDA.1 (m a)
            (COND.1 ((NULL.1 m)  (QUOTE.1 NIL))
                    ((QUOTE.1 T) (CONS.1 (EVAL.1 (CAR.1 m) a)
                                         (EVLIS.1 (CDR.1 m) a)))))))
      ;-------------------------
      (EVCON.1 (LABEL.1 EVCON.1
         (LAMBDA.1 (c a)
            (COND.1 ((EVAL.1 (CAR.1 (CAR.1 c)) a)
                             (EVAL.1 (CAR.1 (CDR.1 (CAR.1 c))) a))
                    ((QUOTE.1 T)
                             (EVCON.1 (CDR.1 c) a))))))
      ;-------------------------
      (NULL.1 (LAMBDA.1 (X)
                 (AND.1 (ATOM.1 X) (EQ.1 X (QUOTE.1 NIL)))))
      ;-------------------------
      (NOT.1 (LAMBDA.1 (X)
                 (COND.1 (X          (QUOTE.1 F))
                         ((QUOTE.1 T)(QUOTE.1 T)))))
      ;-------------------------
      (LIST.1 (LAMBDA.1 (X Y) (CONS.1 X (CONS.1 Y (QUOTE.1 NIL)))))

    )
  )
)

; Is there any difference between EVAL.1 and EVAL defined in
; last post? Yes, EVAL used "building blocks" like operators AND
; or LIST. These can be easily defined in Newlisp, but require
; different approach in McCarthy-60 Lisp, where one cannot use
; variable number of arguments or define special operators.

; How code that could be evaluated by EVAL.1 look like? Well, it
; uses keywords like QUOTE.2, ATOM.2, CONS.2. And how it is called?
; Here is an example:
;
;
; (eval (expand '(EVAL (QUOTE (EVAL.1 (QUOTE.1
;                                       ((LAMBDA.2 (XX)
;                                           (CONS.2 XX
;                                                   (CONS.2 XX
;                                                           (QUOTE.2 ()))))
;                                        (QUOTE.2 somedata)))
;                                     (QUOTE.1 ())
;                             )
;                      )
;                      McCarthy-60-interpreter
;                )
;                'McCarthy-60-interpreter
;       )
; )
;
; The result should be (somedata somedata).
;
; In the rest of this post, McCarthy-60 Lisp is defined in Newlisp,
; more-less, like it was done in previous post, and then the code
; above (using somedata) will be evaluated, so those who are
; interested can, as usually, cut and paste whole post in their
; editor and evaluate in Newlisp. The result of the evaluation
; of the code above (with debug-wrap feature from my library) is
; correct; this is how part of the output on screen can look like.

   (load "http://www.instprog.com/Instprog.default-library.lsp")

;---------------------------------------------------------------
; Newlisp has not dotted pairs, so they are emulated here.
;---------------------------------------------------------------

(define (dotform-atom? L)
  (atom? L))

(define (dotform-base? L)
  (and (list? L)
       (= (length L) 3)
       (= (nth 1 L) '.)))

(define (dotform-recursive? L)
   (or (dotform-atom? L)
       (and (dotform-base? L)
             (dotform-recursive? (first L))
             (dotform-recursive? (last L)))))

(define (listform-atom?)
   (and (atom? L)
        (not (= L 'NIL))))

(define (listform-base? L)
   (and (list? L)
        (not (dotform-base? L))))

(define (listform-recursive? L)
  (or (listorm-atom? L)
      (and (listform-base? L)
           (for-all? listform-recursive? L))))

(define (dotform L)
  (cond ((dotform-atom? L) L)
         ((dotform-base? L) (list  (dotform (first L))
                                    '.
                                    (dotform (last L))))
         ((= (length L) 0) 'NIL)
         ((> (length L) 0) (list (dotform (first L))
                                  '.
                                  (dotform (rest L))))))

(define (listform L)
  (cond ((listform-atom? L) L)
         ((= L '()) L)
         ((listform-base? L) (cons (listform (first L))
                                    (listform (rest L))))
         ((= L 'NIL) '())
         ((dotform-base? L) (let((L1 (listform (first L)))
                                 (L2 (listform (last L))))
                                (if (listform-base? L2)
                                    (cons L1 L2)
                                    (list L1 '. L2))))))

(define (listform-args L)
   (cond ((empty? L) L)
         ((= (first L) (quote .))(listform (rest L)))
         (true (listform L))))

;===============================================================
; DEFINITION OF FEW BASIC OPERATORS.
; THESE OPERATORS ARE ELEMENTS OF META-LANGUAGE, DEFINED IN
; META-META-LANGUAGE (Newlisp)
;---------------------------------------------------------------

      (define-macro (COND)
         (letn((done nil)
               (result nil)
               (arglist (args))
               (largs (listform-args (args))))
             (dolist(clause largs done ind)
                 (setf ind (eval (symbol-from-sexpr '(debug-wrap indent))))
                 ;'(println (dup " " ind) "????? COND clause: " (nth 0 clause))
                 (let ((l (eval (nth 0 clause))))
                 (if  (= l 'T)
                      (begin '(println (dup " " ind) "+++++ COND clause "
                              (nth 0 clause) " evaluates to: " (listform l))
                             (setf result (listform (eval (nth 1 clause))))
                             (setf done true))
                      '(println (dup " " ind) "----- COND clause evaluates to: "
                                (listform l))
                      )))
             (if (not done)
                 (throw-error (append (dup " " ind)
                        "!!!!! COND without any alternative satisfied."))
                 (begin '(println (dup " " ind) "!!!!! COND expr evaluates to "
                                  (listform result))
                        result))))

      (define-macro (AND)
         (letn((arglist (args))
               (largs (listform arglist)))
          (if (eval (cons 'and (map (lambda(X)(expand '(= X (quote T))
                                                      'X))
                                     largs)))
              (quote T)
              (quote F))))

     (define-macro (OR)
          (letn((arglist (args))
                (largs (listform arglist)))
              (if (eval (cons 'or (map (lambda(X)(expand '(= X (quote T))
                                                         'X))
                                        largs)))
                  (quote T)
                  (quote F))))

      (define-macro (NOT X)
         (let ((lx (listform X)))
          (if (= (eval lx) (quote T))
              (quote F)
              (if (= (eval lx) (quote F))
                  (quote T)
                  (throw-error
                    " NOT called with argument evaluating to T OR F.")))))

      ;---------------------------------------------------------------

      (define (LIST)
        (listform (let((a (args)))
                    (cond ((empty? a) (quote NIL))
                          ((quote T) (list (dotform (first a))
                                           '. (dotform (rest a))))))))

      ;---------------------------------------------------------

      (define-macro (QUOTE X) (listform X))

      ;---------------------------------------------------------

      (define-macro (LAMBDA)
           (append (lambda) (args)))

      ;---------------------------------------------------------

      (define-macro (LABEL)
        (let((l1 (first (args)))
             (l2 (last (args))))
            ;(println l1 l2)
            (set l1 (eval l2))))

;===============================================================
; FIVE ELEMENTARY S-FUNCTIONS.

;---------------------------------------------------------------
; 1. ATOM
;---------------------------------------------------------------

(define (ATOM X)
   (if (atom? (dotform X)) (quote T) (quote F)))

;---------------------------------------------------------------
; 2. EQ
;---------------------------------------------------------------

(define (EQ X Y)
   (let((X (dotform X))
        (Y (dotform Y)))
     (if (and (atom? (dotform X)) (atom? (dotform Y)))
         (if (= X Y) (quote T) (quote F))
         (throw-error (string "** EQ undefined for " X " AND " Y "**")))))

;---------------------------------------------------------------
; 3. CAR
;---------------------------------------------------------------

(define (CAR X)
  (listform
      (let ((X (dotform X)))
         (cond ((= X 'NIL) (throw-error "CAR undefined for NIL."))
                ((atom? X)
                 (throw-error (string "CAR undefined for atomic symbol " X)))
                (true (first X))))))

;---------------------------------------------------------------
; 4. CDR
;---------------------------------------------------------------

(define (CDR X)
  (listform
    (let ((X (dotform X)))
       (cond ((= X 'NIL) (throw-error "CAR undefined for NIL."))
             ((atom? X) (throw-error
                          (string "CDR undefined for atomic symbol " X)))
             (true (last X))))))

;---------------------------------------------------------------
; 5. CONS
;---------------------------------------------------------------

(define (CONS X Y)
     (listform (let ((X (dotform X))
                     (Y (dotform Y)))
                    (list X '. Y))))

;---------------------------------------------------------------
; DEFINITION OF IMPORTANT S-FUNCTIONS IN META-LANGUAGE
; STRICTLY FOLLOWED MCCARTHY'S ARTICLE. LOOK EXAMPLES AS BEST
; EXPLANATION

;---------------------------------------------------------------
; NULL
;---------------------------------------------------------------

(define (NULL X)
   (listform  (AND (ATOM X) (EQ X (QUOTE NIL)))))

;---------------------------------------------------------------
; S-FUNCTIONS USEFUL WHEN S-EXPRESSIONS ARE REGARDED AS LISTS
; DEFINED IN META-LANGUAGE IN MCCARTHY'S PAPER
;---------------------------------------------------------------

;---------------------------------------------------------------
; 1. APPEND
;---------------------------------------------------------------

(define (APPEND X Y)
    (listform (COND ((NULL X) Y)
                    ((QUOTE T) (CONS (CAR X) (APPEND (CDR X) Y))))))

;---------------------------------------------------------------
; PAIR
;
; (PAIR (QUOTE (<s1> ... <sn>)) (QUOTE (<t1> ... <tn>))) =>
;       ((<s1> <t1>) ... (<sn> <tn>))
;
;---------------------------------------------------------------

(define (PAIR X Y)
  (listform
    (COND ((AND (NULL X) (NULL Y)) (QUOTE NIL))
          ((AND (NOT (ATOM X)) (NOT (ATOM Y)))
                               (CONS (LIST (CAR X) (CAR Y))
                                     (PAIR (CDR X) (CDR Y)))))))

;---------------------------------------------------------------
; ASSOC
;
; ASSOC returns the "value" of variable X in "association LIST" y.
; for example,
;
;  (ASSOC (QUOTE (X)) (QUOTE ((W (A B)) (X (C D)) (Y (E F)))))
;
; returns (C D).
;
; If variable is NOT "stored" in association LIST, then there
; will be error in attempt to find CAAR of empty list.

(define (ASSOC X Y)
  (let((X (dotform X))
       (Y (listform Y)))
     (when (or (= X 'F) (= X 'T))
           (throw-error "ASSOC CALLED WITH WRONG ARGUMENT."))
     (listform (COND ((AND (ATOM Y)
                           (EQ Y (QUOTE NIL)))
                           (throw-error (string "ASSOC " X " in "
                                                Y " is impossible.")))
                     ((EQ (CAR (CAR Y)) X) (CAR (CDR (CAR Y))))
                     ((QUOTE T) (ASSOC X (CDR Y)))))))

;---------------------------------------------------------------
; APPQ
;
; (APPQ (QUOTE (<expr1> ... <exprn>)))
;
;                        ===> ((QUOTE <expr1>)...(QUOTE <exprn>))
;---------------------------------------------------------------

(define (APPQ m)
     (listform (COND ((NULL m) (QUOTE NIL))
                     ((QUOTE T) (CONS (LIST (QUOTE QUOTE) (CAR m))
                                      (APPQ (CDR m)))))))

;---------------------------------------------------------------
; EVAL, EVCON, EVLIS
;---------------------------------------------------------------

 (define (EVLIS m a)
     (listform (COND ((NULL m)  (QUOTE NIL))
                     ((QUOTE T) (CONS (EVAL (CAR m) a)
                                      (EVLIS (CDR m) a))))))

(define (EVCON c a)
            (COND ((EVAL (CAR (CAR c)) a) (EVAL (CAR (CDR (CAR c)))
                                                 a))
                  ((QUOTE T)         (EVCON (CDR c) a))))

(define (EVAL e a)
  (listform
    (COND ((ATOM e) (listform (ASSOC e a)))
          ;----------------------------
          ((ATOM (CAR e))
              ;----------------------------
              (COND ((EQ (CAR e) (QUOTE QUOTE.1))
                         (CAR (CDR e)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE ATOM.1))
                         (ATOM (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE EQ.1))
                         (EQ (EVAL (CAR (CDR e)) a)
                             (EVAL (CAR (CDR (CDR e))) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE COND.1)) (EVCON (CDR e) a))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE AND.1))
                         (EVAL (CONS (QUOTE COND.1)
                                     (CONS (CDR e)
                                           (QUOTE (((QUOTE.1 T)
                                                    (QUOTE.1 F))))))
                               a))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CAR.1))
                                 (CAR (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CDR.1))
                         (CDR (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CONS.1))
                         (CONS (EVAL (CAR (CDR e)) a)
                               (EVAL (CAR (CDR (CDR e))) a)))
                    ;----------------------------
                    ((QUOTE T) (EVAL (listform (CONS (ASSOC (CAR e) a)
                                                            (CDR e)))
                                     a))))
          ;----------------------------
          ((EQ (CAR (CAR e)) (QUOTE LABEL.1))
               (EVAL (listform (CONS (CAR (CDR (CDR (CAR e))))
                                     (CDR e)))
                     (listform (CONS (LIST (CAR (CDR (CAR e)))
                                     (CAR e))
                     a))))
          ;----------------------------
          ((EQ (CAR (CAR e)) (QUOTE LAMBDA.1))
            (EVAL (listform (CAR (CDR (CDR (CAR e)))))
                  (listform (APPEND (PAIR (CAR (CDR (CAR e)))
                                          (EVLIS (CDR e) a)) a)))))))

(debug-wrap EVAL)

(eval (expand '(EVAL (QUOTE (EVAL.1 (QUOTE.1 ((LAMBDA.2 (XX)
                             (CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
                                              (QUOTE.2 somedata)))
                                    (QUOTE.1 ())
                            )
                     )
                     McCarthy-60-interpreter
               )

               'McCarthy-60-interpreter
      )
)

(exit)


---------------------------------------------------------------
McCarthy-60 Lisp in McCarthy-60 Lisp in ... in McCarthy-60 Lisp
---------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/09/mccarthy-60-lisp-in-mccarthy-60-lisp-in.html

; In this article, I'll show how John McCarthy's Lisp can be interpreted
; in McCarthy's Lisp, which is interpreted in McCarthy's Lisp ...
; and so on, n times.
;
; One of the reasons for harder understanding of early Lisps is
; McCarthy's decision to use same identifiers for Lisp implemented
; in machine code, and for Lisp interpreted by EVAL function.
;
; For example, if McCarthy-60 Lisp expression
;
;
;    (EVAL (QUOTE ((LAMBDA (XX) (CONS XX (CONS XX (QUOTE ()))))
;                  (QUOTE somedata)))
;          (QUOTE ()))
;
;
; is evaluated, the first and the last oocurences of QUOTE are
; evaluated as special operators defined in base language (in my
; case Newlisp, in original implementation it was machine code),
; while second and third occurence of QUOTE are interpreted
; following the rules defined in John McCarthy-60 EVAL function.
;
; McCarthy's decision isn't incorrect, but using slightly
; different symbols is not wrong either and it certainly contributes
; to easier understanding. In second article I redefined EVAL so
; it evaluates expressions containing symbols like CONS.1, QUOTE.1
; ... for example:
;
;
;  (EVAL (QUOTE ((LAMBDA.1 (XX) (CONS.1 XX (CONS.1 XX (QUOTE.1 ()))))
;                (QUOTE.1 somedata)))
;        (QUOTE ()))
;
;
; If we can define LAMBDA.1, QUOTE.1, ... then, why not EVAL.1 as well?
;
; That definition was described in previous article on this topic. It is very
; dry and formal definition, because definition of EVAL.1, and
; all needed helper functions should be written in limited McCarthy-60
; Lisp EVAL interpreter, and given to EVAL in the form of quoted
; association list.
;
;
;  (EVAL <quoted expression to be evaluated>
;        <quoted association list>             ;<======= HERE
;  )
;
;
; If quoted association list is named McCarthy-60-interpreter.1,
; then example of such expressions is
;
;
; (EVAL (QUOTE (EVAL.1 (QUOTE.1 ((LAMBDA.2 (XX)
;                                  (CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
;                                (QUOTE.2 somedata)))
;                                     (QUOTE.1 ())
;                             )
;                      )
;        <McCarthy-60-interpreter.1>
;        )
;
;
; This is how McCarthy-60-interpreter.1 looks like:
; (McCarthy-60-Lisp in Newlisp library first.)

(load (append "http://www.instprog.com/McCarthy-60-LISP/"
              "McCarthy-60-LISP-in-Newlisp.lsp"))

(setf McCarthy-60-interpreter.1

 '(QUOTE

    (
      ;-------------------------
      (EVAL.1 (LABEL.1 EVAL.1
         (LAMBDA.1 (e a)
            (COND.1
               ((ATOM.1 e) (ASSOC.1 e a))
               ;-------------------------
               ((ATOM.1 (CAR.1 e))

                (COND.1

                    ((EQ.1 (CAR.1 e) (QUOTE.1 QUOTE.2))
                           (CAR.1 (CDR.1 e)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 ATOM.2))
                           (ATOM.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 EQ.2))
                           (EQ.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                         a)
                                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                         a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 COND.2))
                           (EVCON.1 (CDR.1 e) a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 AND.2))
                       (EVAL.1 (CONS.1 (QUOTE.1 COND.2)
                                  (CONS.1 (CDR.1 e)
                                     (QUOTE.1 (((QUOTE.2 T)
                                                (QUOTE.2 F))))))
                               a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CAR.2))
                           (CAR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CDR.2))
                           (CDR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CONS.2))
                           (CONS.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)
                                   (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                           a)))
                    ;-------------------------
                    ((QUOTE.1 T) (EVAL.1 (CONS.1 (ASSOC.1 (CAR.1 e)
                                                          a)
                                                 (CDR.1 e))
                                         a))))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LABEL.2))
                    (EVAL.1 (CONS.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                                    (CDR.1 e))
                            (CONS.1 (LIST.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                            (CAR.1 e))
                                    a)))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LAMBDA.2))
                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                         (APPEND.1 (PAIR.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                           (EVLIS.1 (CDR.1 e) a))
                                   a)))

       ))))
      ;-------------------------
      (APPEND.1 (LABEL.1 APPEND.1
         (LAMBDA.1(X Y)
            (COND.1 ((NULL.1 X) Y)
               ((QUOTE.1 T)
                   (CONS.1 (CAR.1 X) (APPEND.1 (CDR.1 X) Y)))))))
      ;-------------------------
      (ASSOC.1 (LABEL.1 ASSOC.1
         (LAMBDA.1 (X Y)
            (COND.1
               ((EQ.1 (CAR.1 (CAR.1 Y)) X) (CAR.1 (CDR.1 (CAR.1 Y))))
               ((QUOTE.1 T)                (ASSOC.1 X (CDR.1 Y)))))))
      ;-------------------------
      (PAIR.1 (LABEL.1 PAIR.1
         (LAMBDA.1 (X Y)
            (COND.1 ((AND.1 (NULL.1 X) (NULL.1 Y)) (QUOTE.1 NIL))
                    ((AND.1 (NOT.1 (ATOM.1 X)) (NOT.1 (ATOM.1 Y)))
                            (CONS.1 (LIST.1 (CAR.1 X) (CAR.1 Y))
                                    (PAIR.1 (CDR.1 X) (CDR.1 Y))))))))
      ;-------------------------
      (EVLIS.1 (LABEL.1 EVLIS.1
         (LAMBDA.1 (m a)
            (COND.1 ((NULL.1 m)  (QUOTE.1 NIL))
                    ((QUOTE.1 T) (CONS.1 (EVAL.1 (CAR.1 m) a)
                                         (EVLIS.1 (CDR.1 m) a)))))))
      ;-------------------------
      (EVCON.1 (LABEL.1 EVCON.1
         (LAMBDA.1 (c a)
            (COND.1 ((EVAL.1 (CAR.1 (CAR.1 c)) a)
                             (EVAL.1 (CAR.1 (CDR.1 (CAR.1 c))) a))
                    ((QUOTE.1 T)
                             (EVCON.1 (CDR.1 c) a))))))
      ;-------------------------
      (NULL.1 (LAMBDA.1 (X)
                 (AND.1 (ATOM.1 X) (EQ.1 X (QUOTE.1 NIL)))))
      ;-------------------------
      (NOT.1 (LAMBDA.1 (X)
                 (COND.1 (X          (QUOTE.1 F))
                         ((QUOTE.1 T)(QUOTE.1 T)))))
      ;-------------------------
      (LIST.1 (LAMBDA.1 (X Y) (CONS.1 X (CONS.1 Y (QUOTE.1 NIL)))))

    )
  )
)

; variable McCarthy-60-interpreter.1 cannot be used directly. It
; has to be replaced with its value first.
;
; Once McCarthy-60-interpreter.1 is defined, it is easy to generalize
; it and define McCarthy-60-interpreter.2, McCarthy-60-interpreter.3,...
; Just respective indexes should be changed.
;
; Here is Newlisp function that calculate these interpreters, for
; given n:

(define (McCarthy-60-interpreter n)

  (if (= n 1)

      McCarthy-60-interpreter.1

      (letn((symbols-in-McCarthy-60-interpreter.1
                  (difference (unique (flat McCarthy-60-interpreter.1))
                              '(T F NIL)))

            (assoc-list1
               (map (lambda(x)
                      (list x
                           (if (find x '(QUOTE e a X Y m c))

                               (sym (append "°"
                                            (string x)
                                            "."
                                            (string (- n 1))))

                               (let ((parsed-x (parse (string x) ".")))

                                   (case (last parsed-x)
                                     ("1" (sym (append "°"
                                                 (first parsed-x)
                                                  "."
                                                 (string n))))
                                     ("2" (sym (append "°"
                                                 (first parsed-x)
                                                  "."
                                                 (string (+ n 1))))))))))

                     symbols-in-McCarthy-60-interpreter.1))

             (assoc-list2
                (map (lambda(x)
                        (list (last x) (sym (rest (string (last x))))))
                     assoc-list1)))

              (local(result)
                (setf result (expand McCarthy-60-interpreter.1
                                     assoc-list1))

                (setf result (expand result assoc-list2))

                result))))

; And this is an example how these interpreters could be used

(setf McCarthy-60-interpreter.2 (McCarthy-60-interpreter 2))

(debug-wrap EVAL)

                  (eval
                    (expand
                      '(EVAL
                         (QUOTE
                           (EVAL.1
                             (QUOTE.1
                               (EVAL.2
                                 (QUOTE.2
                                   (QUOTE.3 somedata))
                                 (QUOTE.2 ())
                               )
                             )
                             McCarthy-60-interpreter.2
                           )
                         )
                         McCarthy-60-interpreter.1
                       )

                      'McCarthy-60-interpreter.1
                      'McCarthy-60-interpreter.2
                    )
                  )

; McCarthy's EVAL is, however, very inefficient - its purpose was
; purely theoretical, so, if you want to really evaluate this simple
; expression prepare yourself on long waiting. (Less than one hour
; on modern PC, however.)


-----------------------------------
On Pitman's "Special forms in Lisp"
-----------------------------------
http://kazimirmajorinc.blogspot.com/2010/10/on-pitmans-special-forms-in-lisp.html

1. Introduction
---------------
It appears that during last few years controversial concept of fexprs is actualized in Lisp community. Newlisp and Picolisp, two small, dynamically scoped Lisps supporting fexprs are actively developed and respective communities slowly, but consistently, grow. Fexprs are frequently discussed on authoritative Lambda the Ultimate web site, passionately advocated by Schemers Thomas Lord and Ray Dillinger. Related links and discussions appear in other Internet forums and blogs. Recently, John Shutt published Ph.D. thesis on programming language Kernel, his attempt to extend Scheme with fexprs, while keeping lexical scope. Shutt's ideas attracted significant attention and few efforts for implementation are reported.

On the first sight, fexprs are elegant and powerful feature. The reason for their discontinuation in most important Lisp dialects is not obvious. According to Christian Quiennec, fexprs were „put to death“ by Kent Pitman who in his 1980 conference presentation „Special Forms in Lisp“

„suggested that, in the design of future Lisp dialects, serious consideration be given to the proposition that FEXPR's should be omitted from the language altogether.“
Pitman's opinion was representative:

„It is widely held among members of the MIT Lisp community that FEXPR, NLAMBDA, and related concepts could be omitted from the Lisp language with no loss of generality and little loss of expressive power, and that doing so would make a general improvement in the quality and reliability of program-manipulating programs.“
The presentation “Special forms in Lisp” covers many fexpr related issues. Unfortunately, some relevant properties of fexprs could be misunderstood or omitted.

2. Importance of Fexprs
-----------------------
It appears that Pitman's conclusion cited above is more result of the counting small and practical pros and cons of fexprs than making of “the big picture.” And that is exactly where fexprs shine. That argument is expressed on particularly strong and inspiring way by Smalltalk designer Alan Kay :

„I could hardly believe how beautiful and wonderful the idea of LISP was. I say it this way because LISP had not only been around enough to get some honest barnacles, but worse, there were deep flaws in its logical foundations. By this, I mean that the pure language was supposed to be based on functions, but its most important components -- such as lambda expressions, quotes, and conds -- were not functions at all, and instead were called special forms ... My next questions was, why on Earth call it a functional language? Why not just base everything on FEXPRs and force evaluation on the receiving side when needed? I could never get a good answer...“
Fexprs really do add to the generality of the language, on particularly interesting way – by exposing the most important elements of Lisp language to processing as a first class objects, during runtime, like functions and other data are processed.

Furthermore, fexprs can replace both functions and macros, making Lisp not only more general, but also conceptually simpler, with more regular semantics. The implementation of Lisp can be, at least theoretically, smaller. Even the number of basic, built-in fexprs can be reduced, since quote is equivalent to (lambda-fexpr(x)x), if lambda-fexpr is, conveniently, fexpr version of lambda.

3. Expandability of Fexprs
--------------------------
Second, comparison of macros and fexprs is done in “macros in general” vs “fexprs in general” fashion. In such comparison, all macros have some desirable properties that all fexprs cannot have. Pitman wrote:

Perhaps the most important reason why macro's are important is that they offer transparency of functionality. It is possible, without evaluating the macro form, to determine what the form will do in terms of primitive lisp operations. This is true because the macro definition need not be invoked only by the evaluator.
That means, macros are expandable during compile time. Particularly, expansion allows "code walking" and various optimizations during compile time. Unlike macros, in general case, fexprs cannot be expanded at all, let alone before runtime. However, comparison is not fair, because fexprs in general are more expressive than macros in general. The macros should be compared with fexprs that could be used as an alternative.

For a given macro M, defined with

(define-macro (M v1 ...  vn) _ _ _)

we can easily define associated macro-like fexpr with

(define-fexpr (F v1 ...  vn)(eval (begin _ _ _))).

Fexpr F is equivalent to macro M in following sense: every program P that uses M, and the program P[F/ M], obtained by replacement of M with F evaluate to same result. Furthermore, if F is macro-like fexpr equivalent to macro M, we can define expansion of fexpr call (F ... ) as expansion of macro call (M ... ). Macro-like fexpr calls can be expanded during compiling, and expansion can be used in “code walkers” as well. It could be said that macros are equivalent to one class of fexprs that can be inlined and optimized during compile time.

typical macro:

(define-macro (ifnt condition
                   else-branch
                   then-branch)
  `(if ,condition
       ,then-branch
       ,else-branch))

typical fexpr:

(define-fexpr (ifnt condition
                    else-branch
                    then-branch)
    (if (eval condition)
        (eval then-branch)
        (eval else-branch))

macro-like fexpr:

(define-fexpr (ifnt condition
                    else-branch
                    then-branch)
   (eval `(if ,condition)
              ,then-branch
              ,else-branch)))

Possible objection is that compiler cannot know that particular fexpr is not used as the first class object. But programmer can do that; he only needs to recognize that fexpr can be implemented as macro. It is sound approach: programmer, generally, knows more than it can be deduced from the code he wrote. Another possible objection is that, if fexprs are used as macros, the advantage of the fexprs is lost. It is true if programmer limits himself on macro-like fexprs. But, he can also use more general fexprs – if loss of "transparence of functionality" is acceptable.

Assuming that compiler can optimize fexprs on described – indeed, very simple way – then, for every program that uses macros, there is equivalent and equally fast program that uses fexprs instead of macros. Inverse is not true. Neither one macro can replace fexpr in programs that use fexpr as the first class value. Rare Lisp dialects support the first class macros (not fexprs!), but these are not discussed here.

4. The Price of Macro Expansion
-------------------------------
Third, although Pitman warned that macro expansion is space-demanding, the possibility that macro expansion can be time-demanding was not discussed. Usually, time required for macro-expansion is not important, because expansion is done only once, before compiling, and after that, the program is used in executable form only. However, Lisp, perhaps more than other languages, is designed to be used for generation of the code during runtime. Generated code can be evaluated using eval; in that case, macro calls are expanded during runtime. Slightly less obviously, if program generates lambda-expressions and compile (convert, coerce) these in form that can be “applied” or “funcalled” then expansion during runtime is unavoidable, even if eval isn't explicitly used.

The problem of macro expansion during runtime was known in Lisp community and some efforts were invested in solving it. See “Evolution of Lisp” for discussion. The problem can be avoided if non-expanding fexprs are used instead of macros. Surprisingly, that comparative advantage of fexprs is not well described in literature. Pitman doesn’t discuss it. Few years later, Z. Lichtman reported moderate slowdown (15%) if macros are used instead of fexprs. As shown in some earlier posts, the price can be higher.

It can be confusing that I wrote about expandable fexprs, and now, I claim that fexprs benefit from non-expanding. There is no single fexpr alternative to given macro; there are many of these. Some are expandable, and others are not.

For instance, take a look on fexpr at-least, generalized or, such that

(at-least e0 e1 ... en)

is true if and only if, well, at least e0 of expressions e1, ..., en evaluate to true. There are many ways this fexpr can be defined – some of these expand, and others do not. For instance, the first of the following two fexprs (slightly changed Newlisp) doesn’t expand, and second expands - and expansion can be done before runtime:

(define-fexpr (at-least n)
      (let ((en (eval n)))
           (doargs(i (zero? en))
                  (when (eval i)
                        (dec en)))
           (zero? en)))

(define-fexpr (at-least n)
  (eval (let ((central (cons 'or
                         (map (lambda(x)(list 'and
                                              x
                                              '(inc counter)
                                              '(= counter n)))
                              (args)))))
               (expand '(let((counter 0))
                            central
                            (= counter n))
                       'central 'n))))

As a side note (because that issue is not discussed in “Special forms”) careless use of fexprs, just like careless use of macros, might result in accidental overshadowing of variables. The solutions are similar (i.e. using gensyms or some kind of predefined “hygiene”). Shutt's approach is novel.

In “Special forms” the technique of wrapping macro around function for reduction of size of the expanded code is described:

(DEFUN f FEXPR (var) . body) =>

(DEFUN f MACRO (FORM)
       (LIST 'EXPR-f
             (LIST 'QUOTE (CDR FORM))))

(DEFUN EXPR-f (var) . body)

The same technique can improve speed of macro expansion of the code during runtime; it alleviates the problem, but doesn’t solve it completely.

5. Conclusions
--------------
Although Pitman's article contains number of valid arguments, including some in favour of fexprs - three important arguments seem to be omitted:

  1. Lisp with fexprs has simpler, more regular and more expressive semantics than Lisp with functions, with or without macros.
  2. The existance of expandable, macro-like fexprs is not recognized. For every macro, there is equivalent expandable, macro-like fexpr with same desirable properties. Particularly, if simple optimization of expandable fexprs is applied, for every program that uses macros there is at least equally fast equivalent program that uses fexprs.
  3. In some cases, the programs using fexprs are much faster than programs using macros.

These claims constitute strong case for fexprs, particularly because one of the main arguments against fexprs was their influence on the speed of the programs.

References
----------
Kay A., The early history of Smalltalk, in: Bergin, Jr., T.J., and Gibson, R. G., History of Programming Languages - II, ACM Press, New York, and Addison-Wesley Publ. Co., Reading 1996, pp. 511-78.
Burger A., The Picolisp reference, retrieved 25 October 2010.
Jaffer A., SCM, Scheme implementation, retrieved 25 October 2010.
Lichtman Z., Sometimes an FEXPR is better than a macro, ACM SIGART Bulletin archive, Issue 97, July 1986, pp. 20-2.
Majorinc K., Challenged By Common Lispers,  On macro expansion, EVAL and generated Code, Symbols as S-exprs and hygienic FEXPRs, posts on kazimirmajorinc.blogspot.com
Mueller L., Newlisp user manual and report, the post on newlisp.org, retrieved 25 October 2010.
Pitman K., Special forms in Lisp, Conference Record of the 1980 Lisp Conference, Stanford University, August 25-27, 1980.
Queineec, C., Lisp in small pieces, Cambridge University press, Cambridge, 1996.
Shutt J. N., Abstraction in programming -- working definition, Worcester Polytechnic Institute, Worcester, 1999.
Shutt J. N., S-expressiveness and the abstractive power of programming languages, W orcester Polytechnic Institute, Worcester, 1999.
Shutt J. N., Revised-1 report on the Kernel programming language, Worcester Polytechnic Institute, Worcester, 2009. retrieved 25 October 2010.
Shutt J. N., Fexprs as the basis of Lisp function application or $vau: the ultimate abstraction, Worcester Polytechnic Institute, Worcester, 2010.
Steele, G. L., Gabriel, R. P., The evolution of Lisp, extended version, retrieved 25 October 2010.


---------------------------
Lambda Calculus Interpreter
---------------------------
http://kazimirmajorinc.blogspot.com/2010/12/lambda-calculus-interpreter.html

Later edit: there is newer, improved version of this interpreter, check
this post (http://kazimirmajorinc.blogspot.com/2011/01/lambda-calculus-interpreter-2.html) and few posts before that.

; Lambda calculus implemented in Newlisp. It would be too ambitious
; to explain what is lambda calculus in this post, so I'll assume
; that reader familiarized himself with notion of lambda calculus
; somewhere else, and I'll provide only code for evaluation ("reduction")
; of lambda-expressions. Instead of lambda symbol, I'll use ^ -
; and it was original symbol used by Church.

; Only beta-reduction (but this is only important one) and normal
; order evaluation (better one, used for Haskell and fexprs) - from
; outside to inside implemented.

(set 'is-variable (lambda(x)(symbol? x)))

(set 'is-function (lambda(L)(and (list? L)
                                 (= (first L) '^)
                                 (= (nth 2 L) '.))))

(set 'function-variable (lambda(f)(nth 1 f)))
(set 'function-body (lambda(f)(last f)))

(set 'is-application (lambda(L)(and (list? L)
                                    (= (length L) 2))))

(set 'substitute-free-occurences ; of variable V in E with F
     (lambda(V E F)
       (cond ((is-variable E) (if (= E V) F E))

             ((is-function E)

                  (if (= (function-variable E) V)

                      E ; V is bounded in E - no substitution

                      (list '^
                            (function-variable E)
                            '.
                            (substitute-free-occurences V
                                   (function-body E)
                                   F))))
              ((is-application E)
               (list (substitute-free-occurences V (first E) F)
                     (substitute-free-occurences V (last E) F))))))

(set 'reduce-once
     (lambda(E)
        (cond ((is-variable E) E)
              ((is-function E) E)
              ((is-application E)
                (let ((E1 (first E))
                      (E2 (last E)))
                (if (is-function E1)
                    ;E=((^V._) E2) ==> E10[V:=E2]
                    (substitute-free-occurences (function-variable E1)
                                                (function-body E1)
                                                E2)

                     ;E=(E1 E2) ==>
                     (let ((new-E1 (reduce-once E1)))
                           (if (!= new-E1 E1)
                               (list new-E1 E2)
                               (list E1 (reduce-once E2))))))))))

(set 'reduce (lambda(new-expression)
                (local(expression)
                  (println "\n--------------\n\n" (string new-expression))
                  (do-while (!= new-expression expression)
                            (setf expression new-expression)
                            (setf new-expression (reduce-once expression))
                            (if (!= new-expression expression)
                                (println " ==> " (string new-expression))
                                (println "\n     Further reductions are impossible."))
                new-expression))))

; The list of reduced expressions

(dolist (i '( x
             (^ x . x)
             ((^ x . x) y)
             ((^ x . a) ((^ y . y) z))
             ((^ y . (^ z . z)) ((^ x . (x x)) (^ v . (v v))))
             ((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . x))) a) b)
             ((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . y))) a) b)
             ; (^ f . ((^ x . (f (x x))) (^ x . (f (x x))))) Y-combinator - test it!
             ((^ x . (x x)) (^ x . (x x)))
             ;((^ x . (x (x x))) (^ x . (x (x x))))
             ))

   ;(println "\n\n=== " (+ $idx 1) ": "  i "\n\n")

   (reduce i))

(exit)

                                      OUTPUT

--------------

x

     Further reductions are impossible.

--------------

(^ x . x)

     Further reductions are impossible.

--------------

((^ x . x) y)
 ==> y

     Further reductions are impossible.

--------------

((^ x . a) ((^ y . y) z))
 ==> a

     Further reductions are impossible.

--------------

((^ y . (^ z . z)) ((^ x . (x x)) (^ v . (v v))))
 ==> (^ z . z)

     Further reductions are impossible.

--------------

((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . x))) a) b)
 ==> (((^ t . (^ f . (((^ x . (^ y . x)) t) f))) a) b)
 ==> ((^ f . (((^ x . (^ y . x)) a) f)) b)
 ==> (((^ x . (^ y . x)) a) b)
 ==> ((^ y . a) b)
 ==> a

     Further reductions are impossible.

--------------

((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . y))) a) b)
 ==> (((^ t . (^ f . (((^ x . (^ y . y)) t) f))) a) b)
 ==> ((^ f . (((^ x . (^ y . y)) a) f)) b)
 ==> (((^ x . (^ y . y)) a) b)
 ==> ((^ y . y) b)
 ==> b

     Further reductions are impossible.

--------------

((^ x . (x x)) (^ x . (x x)))

     Further reductions are impossible.


---------------------------
Expansion of Free Variables
---------------------------
http://kazimirmajorinc.blogspot.com/2010/12/expansion-of-free-variables.html

; The function "expand" is a Newlisp version of mathematical operation
; of the substitution. It is very useful function. For example,
; in code
;
;               (setf 'x 'new-variable)
;               (expand '(lambda(x y)(print x)) 'x)
;
;   ===>        (lambda (new-variable y) (print new-variable))
;
; Newlisp "expands" all occurences of the symbol x with symbol
; new-variable.
;
; However, it is not always convenient to apply substitution on
; all occurences. For example, let us assume that you want to
; write interpreter for some other dialect of Lisp in Newlisp.
; That interpreter should be able to compute expressions like
;
;      ((lambda(x)(+ x (* 2 x) (let((x 5))(* x x)))) 3).
;
; It can be accompplished by substituting argument of the function (3)
; on place of parameter of the function (x) of the body of the
; function
;               (+ x (* 2 x) (let((x 5))(* x x))).
;
; However, the substitution is needed only for first two occurences
; of x, while not for third, fourth and fifth occurence - these
; occurences are not "free", they are "bounded."
;
; I defined expand-free-variable function so it recognizes few most
; important ways for binding of the variables: lambda, lambda-macro,
; local, let, letn and letex. As many of these operations are
; "polymorphic", only the most basic form is supported. It turned
; to be relatively hard to write, because almost every binding
; operator, every form of it, requires slightly different code.

(set 'function-parameters (lambda(f)(first f)))
(set 'function-body (lambda(f)(rest f)))

(set 'expand-free-variables
  (lambda(E)
    (let ((vars-to-expand (args)))

         (cond ((symbol? E) (eval (append '(expand)
                                           (map quote (list E))
                                           (map quote vars-to-expand))))

               ;------------------------------------------------

               ((or (lambda? E)
                    (macro? E))

                    (letn((new-vars-to-expand
                             (difference vars-to-expand
                                         (function-parameters E)))

                          (new-expand-function
                             (append (lambda(expr))
                                (list (append '(expand-free-variables expr)
                                               (map quote new-vars-to-expand))))))

                         (append (cond ((lambda? E) '(lambda))
                                       ((macro? E) '(lambda-macro)))

                                 (list (function-parameters E))

                                 (map new-expand-function
                                      (function-body E)))))

                ;-----------------------------------------------

                ((and (list? E)
                      (starts-with E 'local))

                    (letn((new-vars-to-expand (difference vars-to-expand
                                                          (nth 1 E)))

                         (new-expand-function
                           (append (lambda(expr))
                             (list (append '(expand-free-variables expr)
                                            (map quote new-vars-to-expand))))))

                         (append '(local)
                                  (list (nth 1 E))
                                  (map new-expand-function
                                       (rest (rest E))))))

                ;-----------------------------------------------

                ((and (list? E)
                      (or (starts-with E 'let)
                          (starts-with E 'letn)
                          (starts-with E 'letex)))

                     (letn((new-vars-to-expand
                              (difference vars-to-expand
                                          (map first (nth 1 E))))

                           (new-expand-function
                              (append (lambda(expr))
                                 (list (append '(expand-free-variables expr)
                                                (map quote new-vars-to-expand))))))

                         (append (cond ((starts-with E 'let) '(let))
                                       ((starts-with E 'letn) '(letn))
                                       ((starts-with E 'letex) '(letex)))

                                  (list (first (rest E)))
                                  (map new-expand-function
                                       (rest (rest E))))))

               ;------------------------------------------------

               ((list? E)(let((new-expand-function
                                (append (lambda(expr))
                                  (list (append '(expand-free-variables expr)
                                                 (map quote vars-to-expand))))))

                              (map new-expand-function E)))

               ;------------------------------------------------

               ((or (number? E)
                    (string? E))
                    E)

               ;------------------------------------------------

               ((quote? E)
                (list 'quote (eval (append '(expand-free-variables)
                                            (list (list 'quote (eval E)))
                                            (map quote vars-to-expand)))))

               ;------------------------------------------------

               (true (println "Expand for " E " is not defined.\n")
                     (throw-error "expand isn't defined."))))))



;                     FEW TESTS


(setf x 1 y 2 z 3 v 4 w 5)
(println (expand-free-variables '(local(x y z)x y z v w 7) 'x 'v))

; (local (x y z)
;  x y z 4 w 7)

(println (expand-free-variables '('('(x)) '('(z)) '''y (local(x)x y)) 'x 'y))

; ((quote ((quote (1)))) (quote ((quote (z)))) (quote (quote (quote 2)))
;  (local (x)
;   x 2))
;

(println (expand-free-variables '(lambda(x a y) x b z) 'x 'y 'z 'w))

; (lambda (x a y) x b 3)

(setf x 'new-variable)
(println (expand-free-variables (list 'x '(lambda(x y)(print x))) 'x))

; (new-variable
;  (let ((x 3))
;   (x even-newer-variable
;    (letex ((y 4)) y))))
;

(setf x 'new-variable y 'even-newer-variable)
(println (expand-free-variables '(x (let((x 3)) (x y (letex((y 4))y)))) 'x 'y))

; (lambda (x a y) x b 3)

(exit)

---------------------------------------------------
Do You Need Five Hundred Random Lambda-Expressions?
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/do-you-need-five-hundred-random-lambda.html

; Just in case ...
;
; Newlisp source:

(set 'random-var (lambda(nvars)(sym (char (+ 97 (rand nvars))))))

; (random-^-expr nvars nocc) returns random lambda-expression
; with at most nvars variables in total of exactly nocc occurences

(set 'random-^-expr
   (lambda(nvars nocc)
      (cond ((= nocc 1) (random-var nvars))
            ((> nocc 1)
             (amb (let ((r (+ (rand (- nocc 1)) 1)))
                       (list (random-^-expr nvars r)
                             (random-^-expr nvars (- nocc r))))
                  (list '^
                        (random-var nvars)
                        '.
                        (random-^-expr nvars (- nocc 1))))))))

(set 'pretty-form
   (lambda(t)
      (replace " . " (replace "^ " (replace ") (" (string t) ")(") "^") ".")))

(for(nvars 1 25 1)
  (for(nocc 1 20 1)
       (println (pretty-form (random-^-expr nvars nocc)))))

(exit)

Nota: per vedere l'output aprire il file "500lambda.txt" nella cartella "data".


------------------------------------------------
In Search for The Irreducible Lambda-Expressions
------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/in-search-for-irreducible-lambda.html

; In last post, I wrote the program that generates random lambda
; expressions, 500 of these. This is the program that generates
; roughly 3500000 random lambda expressions, then attempts to
; reduce these, and makes list of lambda-expressions such that
; reduction to normal form failed. There are two different kinds of
; lambda-expressions on that list:
;
;  (i)  the program proves that reductions fail to terminate, i.e.
;       lambda-expression is reduced to the form that is further
;       reduced to itself.
;
;  (ii) the program doesn't prove that reductions fail to terminate
;       generally, but it shows that after n (in our case 25)
;       reductions the lambda expression is still not in normal
;       form.
;
; The lambda expressions on the list are normalized, i.e. two lambda
; expressions are considered to be equivalent if there is
; alpha-conversion that transform one expression in the other.
; For example, there is alpha-conversion from (^ x . x) to (^ y . y).
;
; The results are at the bottom of the post. If you decide to try
; the program, be patient, it might need one hour of time. If
; you want it to run faster, change the constant in line
;
;              (dotimes(dummy 200000) ...

(setf [println.supressed] true [print.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(setf [println.supressed] nil [print.supressed] nil)

;---------------------------------------------------------------
; is-variable, is-function and is-application are predicated
; that return true or false

(set 'is-variable (lambda(x)(symbol? x)))

(set 'is-function (lambda(L)(and (list? L)
                                 (= (first L) '^)
                                 (= (nth 2 L) '.))))

(set 'is-application (lambda(L)(and (list? L)
                                    (= (length L) 2))))

;---------------------------------------------------------------
; function-variable and function-body return parts of the
; lambda-expression. For example
;
;       (function-variable '(^ x . (x x))) returns x
;       (function-body '(^ x . (x x))) returns (x x)

(set 'function-variable (lambda(f)(nth 1 f)))
(set 'function-body (lambda(f)(last f)))

;---------------------------------------------------------------
;
; (substitute-free-occurences V E F)
;
; Substitutes free occurences of variable V in expression E with F.
; Don't change bounded occurences of the variable.

(set 'substitute-free-occurences ; of variable V in E with F
     (lambda(V E F)
       (cond ((is-variable E) (if (= E V) F E))

             ((is-function E)
                  (if (= (function-variable E) V)

                      E ; V is bounded in E - no substitution

                      (list '^
                            (function-variable E)
                            '.
                            (substitute-free-occurences V
                                   (function-body E)
                                   F))))

              ((is-application E)
               (list (substitute-free-occurences V (first E) F)
                     (substitute-free-occurences V (last E) F))))))

;---------------------------------------------------------------
;
;                      (reduce-once E)
;
; performs beta-reduction on lambda-expression E. It returns pair
;
;                      (success result)
; where
;
;     success = true or nil, dependently if E is reduced
;     result  = reduced E if reduction is possible
;               original E if reduction is not possible

(set 'reduce-once

     (lambda(E)

        (cond ((is-variable E) (list 'nil E))

              ((is-function E)
               (let((rfb (reduce-once (function-body E))))
                 (if (first rfb) ; success
                     (list 'true (append (chop E)
                                         (list (last rfb))))

                     (list 'nil E))))

              ((is-application E)
                (let ((F (first E))
                      (G (last E)))

                  (if (is-function F)

                      ;E=((^V._) G) ==> E10[V:=E2]

                      (list 'true (substitute-free-occurences (function-variable F)
                                                              (function-body F)
                                                              G))

                       ;E=(F G) ==>

                       (let ((rF (reduce-once F)))

                             (cond ((= (first rF) true)
                                    (list 'true (list (last rF) G)))

                                   ((= (first rF) nil)

                                    (let ((rG (reduce-once G)))

                                         (cond ((= (first rG) true)
                                                (list 'true (list F (last rG))))
                                               ((= (first rG) nil)
                                                (list 'nil (list F G))))))))))))))

; (println= (reduce-once 'a))
; (println= (reduce-once '(a b)))
; (println= (reduce-once '(^ x . x)))
; (println= (reduce-once '((^ x . x) y)))
; (println= (reduce-once '((^ x . y) y)))
;

(set 'pretty-form
   (lambda(t)
      (replace " . " (replace "^ " (replace ") (" (string t) ")(") "^") ".")))

;---------------------------------------------------------------
;                     (bounded-var i)
;
; returns i-th of variables A0, B0, C0, ... A1, B1, C1 ...

(set 'bounded-var
     (lambda(i)(sym (append (char (+ 64 (% i 25)))
                            (string (/ i 25))))))


;---------------------------------------------------------------
; alpha-convert converts expressions, so beta-reduction can be
; performed on the way it is defined.

(set 'init-and-alpha-convert
     (lambda(E)
        (setf bounded-vars-counter 0)
        (alpha-convert E)))

(set 'alpha-convert
     (lambda(E)
        (cond ((is-variable E) E)
              ((is-function E)
               (begin (inc bounded-vars-counter)
                      (let (new-E-1 (bounded-var bounded-vars-counter))

                           (list '^
                                 new-E-1
                                 '.
                                 (expand (alpha-convert (E 3))
                                         (list (list (E 1) new-E-1)))))))

              ((is-application E)
               (list (alpha-convert (E 0))
                     (alpha-convert (E 1)))))))

;---------------------------------------------------------------
;
;      (reduce new-expression reduce-max to-print)
;
; reduces new-expression in at most reduce-max steps, producing
; output if to-print is set to true.
;
; It returs list
;
;            (terminating result result-counter)
;
; where
;
;       terminating = true if further reductions are impossible
;                   = nil  if cyclical reduction is discovered
;                   = undefined if reduction is quited because of
;                     lack of computing resources
;
;       result = last lambda-expression in process
;       result-counter = numbers of derived lambda-expression
;                        before further derivation is canceled
;                        independently of a reason

(set 'reduce
  (lambda(new-expr reduce-max to-print)
    (when to-print
          (println "\n--------------\n\n " (pretty-form new-expr)))

    (let ((reduce-counter 0)
          (terminating 'undefined)
          (result 'undefined)
          (reduce-end nil))

        (setf new-expr (init-and-alpha-convert new-expr))
        (when to-print (println " ==[alpha]==> "
                                (pretty-form new-expr)))

        (until reduce-end
          ;(println "unless loop")
          (letn ((old-expr new-expr)
                 (r (reduce-once old-expr))
                 (reduce-once-succeeded (first r)))

            (cond ((not reduce-once-succeeded)

                   (begin (setf reduce-end true)
                          (setf terminating true)
                          (setf result old-expr)

                          (when to-print
                                (println "\n There are no further reductions"))))

                  (reduce-once-succeeded

                   (begin (inc reduce-counter)
                          (setf new-expr (last r))
                          (when to-print
                                (println " ==[beta " reduce-counter
                                         ".]==> " (pretty-form new-expr)))

                          (setf new-expr (init-and-alpha-convert new-expr))
                          (when to-print
                               (println " ==[alpha]==> " (pretty-form new-expr)))

                          (cond ((= old-expr new-expr)
                                (begin (setf reduce-end true)
                                       (setf terminating nil)
                                       (setf result old-expr)

                                       (when to-print
                                         (println "\n Self-evaluating expression."))))

                               ((>= reduce-counter reduce-max)
                                   (begin (setf reduce-end true)
                                          (setf terminating 'undefined)
                                          (setf result new-expr)
                                          (when to-print
                                            (println "\n Maximal number of the reductions reached."))))))))))
          ;(println= "unless loop ended." old-expr new-expr reduce-end)
          (list terminating result reduce-counter))))

;---------------------------------------------------------------
;
;                  EXAMPLE OF REDUCTION

(reduce '((^ c . (c c)) (^ c . (c (c (^ c . c))))) 15 true)

; --------------
;
;  ((^A0.(A0 A0))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[alpha]==> ((^A0.(A0 A0))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[beta 1.]==> ((^B0.(B0 (B0 (^C0.C0))))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[alpha]==> ((^A0.(A0 (A0 (^A0.A0))))(^C0.(C0 (C0 (^D0.D0)))))
;  ==[beta 2.]==> ((^C0.(C0 (C0 (^D0.D0))))((^C0.(C0 (C0 (^D0.D0))))(^A0.A0)))
;  ==[alpha]==> ((^A0.(A0 (A0 (^B0.B0))))((^C0.(C0 (C0 (^D0.D0))))(^E0.E0)))
;  ==[beta 3.]==> (((^C0.(C0 (C0 (^D0.D0))))(^E0.E0))(((^C0.(C0 (C0 (^D0.D0))))(^E0.E0))(^B0.B0)))
;  ==[alpha]==> (((^A0.(A0 (A0 (^B0.B0))))(^C0.C0))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[beta 4.]==> (((^C0.C0)((^C0.C0)(^B0.B0)))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[alpha]==> (((^A0.A0)((^B0.B0)(^C0.C0)))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[beta 5.]==> (((^B0.B0)(^C0.C0))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[alpha]==> (((^A0.A0)(^B0.B0))(((^C0.(C0 (C0 (^C0.C0))))(^E0.E0))(^F0.F0)))
;  ==[beta 6.]==> ((^B0.B0)(((^C0.(C0 (C0 (^C0.C0))))(^E0.E0))(^F0.F0)))
;  ==[alpha]==> ((^A0.A0)(((^B0.(B0 (B0 (^B0.B0))))(^D0.D0))(^E0.E0)))
;  ==[beta 7.]==> (((^B0.(B0 (B0 (^B0.B0))))(^D0.D0))(^E0.E0))
;  ==[alpha]==> (((^A0.(A0 (A0 (^A0.A0))))(^C0.C0))(^D0.D0))
;  ==[beta 8.]==> (((^C0.C0)((^C0.C0)(^A0.A0)))(^D0.D0))
;  ==[alpha]==> (((^A0.A0)((^B0.B0)(^C0.C0)))(^D0.D0))
;  ==[beta 9.]==> (((^B0.B0)(^C0.C0))(^D0.D0))
;  ==[alpha]==> (((^A0.A0)(^B0.B0))(^C0.C0))
;  ==[beta 10.]==> ((^B0.B0)(^C0.C0))
;  ==[alpha]==> ((^A0.A0)(^B0.B0))
;  ==[beta 11.]==> (^B0.B0)
;  ==[alpha]==> (^A0.A0)
;
;  There are no further reductions
;
;---------------------------------------------------------------
;
;                    (random-var nvars)
;
; return random of the first nvars variables of
; a0, b0, c0, ..., a1, b1, c1 ...
;


(set 'random-var
     (lambda(nvars)
       (let((r (rand nvars)))
           (sym (append (char (+ 97 (% r 25)))
                        (string (/ r 25)))))))


;---------------------------------------------------------------
;
;               (random-^-expr nvars number-of-occurences)
;
; returns random lambda-expression with at most nvars variables
; in total of exactly number-of-occurences occurences

(set 'random-^-expr
   (lambda(nvars number-of-occurences)
      (cond ((= number-of-occurences 1) (random-var nvars))
            ((> number-of-occurences 1)
             (amb (let ((r (+ (rand (- number-of-occurences 1)) 1)))
                       (list (random-^-expr nvars r)
                             (random-^-expr nvars (- number-of-occurences r))))
                  (list '^
                        (random-var nvars)
                        '.
                        (random-^-expr nvars (- number-of-occurences 1))))))))

;---------------------------------------------------------------
;
;                         (normalized E)
;
; returns normalized expression E, i.e. variables sorted by some
; natural and unique order. It is important only for order of
; free variables. The order of bounded variables is sorted on
; natural and unique way using function init-and-alpha-convert.

(set 'normalized
  (lambda(E)
    (let((varcounter 0)
         (F (flat E)))
      (dolist(i F)

        (when (and (!= i '^)
                   (!= i '.)
                   (= (string i)
                      (lower-case (string i))))

          (inc varcounter)
          (setf E
             (expand E ;((i _i))
                (list (list i
                        (sym (append "_"
                                (lower-case (string (bounded-var varcounter)))))))))))

     (eval-string (append "'" (replace "_" (string E) ""))))))


; (println= (normalized '(b0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0))))

;---------------------------------------------------------------
; The program will generate large number of lambda-expressions,
; and attempt to reduce these. The lambda-expressions not reduced in
; 20 steps or more are good candidates for unreducible lambda-expressions.

(for(number-of-occurences 6 8 1)

  (setf successes 0
        failures 0
        attempts 0
        total-number-of-steps 0
        max-number-of-steps-if-reduction-succeeded 0)

  (setf max-number-of-reductions 25)
  (setf unreduced '())

  (println= "\n\n----------------" number-of-occurences)
  (for(nvars 1 (- number-of-occurences 1) 1)
    (dotimes(dummy 200000)
      (letn((F (random-^-expr nvars number-of-occurences))
            (G (init-and-alpha-convert F)))
           (inc attempts)

           (letn((H (reduce G
                            max-number-of-reductions
                            nil)))

                 (cond ((= (H 0) true) ; reduction succeeded
                        (inc total-number-of-steps (H 2))
                        (inc successes)
                        (when (> (H 2) max-number-of-steps-if-reduction-succeeded)
                              (setf max-number-of-steps-if-reduction-succeeded (H 2))
                              (setf longest-reduction G)))

                      ((= (H 0) nil) ; reduction failed
                       (begin (inc failures)
                              ;(print "!")
                              (if (= (% failures 80) 0) (println))

                              (push (append (string (normalized G)) "  failed.")
                                    unreduced
                                    -1)))

                      ((= (H 0) 'undefined) ; reduction canceled
                       (begin (inc failures)
                              ;(print "?")
                              (if (= (% failures 80) 0) (println))

                              (push (append (string (normalized G))
                                            "  didn't succeeded in "
                                            (string max-number-of-reductions)
                                            " steps.")
                                    unreduced
                                    -1))))))))

   (println= "\n\n" attempts "\n" successes "\n" failures
             "\n" max-number-of-reductions "\n" total-number-of-steps
             "\n" max-number-of-steps-if-reduction-succeeded
             "\n" longest-reduction)

   (println "\nUnreduced (without duplicates):\n")
   (dolist(s (unique (sort unreduced)))
     (println (+ $idx 1) ".  " s)))

(exit)

Output: (!'s and ?'s are printed during execution of the program)

----------------number-of-occurences=6;

attempts=1000000;
successes=998677;
failures=1323;
max-number-of-reductions=25;
total-number-of-steps=596444;
max-number-of-steps-if-reduction-succeeded=3;
longest-reduction=(((^ A0 . (A0 A0)) (^ B0 . B0)) a0);

Unreduced (without duplicates):

1. ((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) failed.

----------------number-of-occurences=7;

attempts=1200000;
successes=1197916;
failures=2084;
max-number-of-reductions=25;
total-number-of-steps=908464;
max-number-of-steps-if-reduction-succeeded=5;
longest-reduction=((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 b0))));

Unreduced (without duplicates):

1. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) failed.
2. ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0))) failed.
3. ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0))) failed.
4. ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0))) failed.
5. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
6. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
7. ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
8. ((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
9. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0))) failed.
10. ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0))) failed.
11. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) failed.
12. (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.

----------------number-of-occurences=8;

attempts=1400000;
successes=1396693;
failures=3307;
max-number-of-reductions=25;
total-number-of-steps=1278600;
max-number-of-steps-if-reduction-succeeded=15;
longest-reduction=((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 (B0 c0)))));

Unreduced (without duplicates):

1. ((((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) a0) failed.
2. ((((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) b0) failed.
3. (((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0))) a0) failed.
4. (((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0))) b0) failed.
5. (((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0))) a0) failed.
6. (((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0))) a0) didn't succeeded in 25 steps.
7. (((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) a0))) a0) didn't succeeded in 25 steps.
8. (((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0)))) a0) didn't succeeded in 25 steps.
9. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (^ C0 . C0)) failed.
10. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (^ C0 . a0)) failed.
11. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (a0 a0)) failed.
12. (((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 B0)))) b0) didn't succeeded in 25 steps.
13. (((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0))) a0) failed.
14. (((^ A0 . (^ B0 . (B0 B0))) a0) (^ C0 . (C0 C0))) failed.
15. (((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0))) a0) failed.
16. (((^ A0 . A0) (^ B0 . (B0 B0))) (^ C0 . (C0 C0))) failed.
17. ((^ A0 . (((A0 A0) A0) A0)) (^ B0 . (B0 B0))) failed.
18. ((^ A0 . (((A0 A0) A0) a0)) (^ B0 . (B0 B0))) failed.
19. ((^ A0 . (((A0 A0) a0) A0)) (^ B0 . (B0 B0))) failed.
20. ((^ A0 . (((^ B0 . A0) A0) A0)) (^ C0 . (C0 C0))) failed.
21. ((^ A0 . (((^ B0 . A0) a0) A0)) (^ C0 . (C0 C0))) failed.
22. ((^ A0 . (((^ B0 . B0) A0) A0)) (^ C0 . (C0 C0))) failed.
23. ((^ A0 . ((A0 (A0 A0)) A0)) (^ B0 . (B0 B0))) failed.
24. ((^ A0 . ((A0 (A0 A0)) a0)) (^ B0 . (B0 B0))) failed.
25. ((^ A0 . ((A0 A0) (A0 A0))) (^ B0 . (B0 B0))) failed.
26. ((^ A0 . ((A0 A0) (^ B0 . A0))) (^ C0 . (C0 C0))) failed.
27. ((^ A0 . ((A0 A0) (^ B0 . B0))) (^ C0 . (C0 C0))) failed.
28. ((^ A0 . ((A0 A0) (^ B0 . a0))) (^ C0 . (C0 C0))) failed.
29. ((^ A0 . ((A0 A0) (a0 A0))) (^ B0 . (B0 B0))) failed.
30. ((^ A0 . ((A0 A0) (a0 a0))) (^ B0 . (B0 B0))) failed.
31. ((^ A0 . ((A0 A0) A0)) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
32. ((^ A0 . ((A0 A0) A0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
33. ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
34. ((^ A0 . ((A0 A0) A0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
35. ((^ A0 . ((A0 A0) a0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
36. ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
37. ((^ A0 . ((A0 A0) a0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
38. ((^ A0 . ((A0 a0) (A0 A0))) (^ B0 . (B0 B0))) failed.
39. ((^ A0 . ((^ B0 . (A0 A0)) A0)) (^ C0 . (C0 C0))) failed.
40. ((^ A0 . ((^ B0 . (A0 A0)) a0)) (^ C0 . (C0 C0))) failed.
41. ((^ A0 . ((^ B0 . (A0 B0)) A0)) (^ C0 . (C0 C0))) failed.
42. ((^ A0 . ((^ B0 . (B0 A0)) A0)) (^ C0 . (C0 C0))) failed.
43. ((^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) a0) failed.
44. ((^ A0 . ((^ B0 . (B0 B0)) A0)) (^ C0 . (C0 C0))) failed.
45. ((^ A0 . ((^ B0 . B0) (A0 A0))) (^ C0 . (C0 C0))) failed.
46. ((^ A0 . ((a0 (A0 A0)) A0)) (^ B0 . (B0 B0))) failed.
47. ((^ A0 . ((a0 (A0 A0)) a0)) (^ B0 . (B0 B0))) failed.
48. ((^ A0 . ((a0 A0) (A0 A0))) (^ B0 . (B0 B0))) failed.
49. ((^ A0 . (A0 ((A0 A0) A0))) (^ B0 . (B0 B0))) failed.
50. ((^ A0 . (A0 ((A0 A0) a0))) (^ B0 . (B0 B0))) failed.
51. ((^ A0 . (A0 ((^ B0 . A0) a0))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
52. ((^ A0 . (A0 ((^ B0 . B0) A0))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
53. ((^ A0 . (A0 (A0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
54. ((^ A0 . (A0 (A0 (^ B0 . A0)))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
55. ((^ A0 . (A0 (A0 A0))) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
56. ((^ A0 . (A0 (A0 A0))) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
57. ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
58. ((^ A0 . (A0 (A0 A0))) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
59. ((^ A0 . (A0 (^ B0 . (A0 B0)))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
60. ((^ A0 . (A0 (^ B0 . (B0 B0)))) (^ C0 . (C0 C0))) failed.
61. ((^ A0 . (A0 (^ B0 . A0))) (^ C0 . ((C0 a0) C0))) didn't succeeded in 25 steps.
62. ((^ A0 . (A0 (a0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
63. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (B0 B0))) a0)) didn't succeeded in 25 steps.
64. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (B0 C0))) a0)) didn't succeeded in 25 steps.
65. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (C0 B0))) a0)) didn't succeeded in 25 steps.
66. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (C0 C0))) a0)) didn't succeeded in 25 steps.
67. ((^ A0 . (A0 A0)) ((^ B0 . B0) (^ C0 . (C0 C0)))) didn't succeeded in 25 steps.
68. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) B0) B0))) didn't succeeded in 25 steps.
69. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) B0))) didn't succeeded in 25 steps.
70. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) a0))) didn't succeeded in 25 steps.
71. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) b0))) didn't succeeded in 25 steps.
72. ((^ A0 . (A0 A0)) (^ B0 . (((^ C0 . B0) B0) B0))) didn't succeeded in 25 steps.
73. ((^ A0 . (A0 A0)) (^ B0 . (((^ C0 . C0) B0) B0))) didn't succeeded in 25 steps.
74. ((^ A0 . (A0 A0)) (^ B0 . ((B0 (B0 B0)) B0))) didn't succeeded in 25 steps.
75. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (B0 B0)))) didn't succeeded in 25 steps.
76. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (B0 a0)))) didn't succeeded in 25 steps.
77. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . B0)))) didn't succeeded in 25 steps.
78. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . C0)))) didn't succeeded in 25 steps.
79. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . a0)))) didn't succeeded in 25 steps.
80. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (a0 B0)))) didn't succeeded in 25 steps.
81. ((^ A0 . (A0 A0)) (^ B0 . ((B0 a0) (B0 B0)))) didn't succeeded in 25 steps.
82. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (B0 C0)) B0))) didn't succeeded in 25 steps.
83. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (C0 B0)) B0))) didn't succeeded in 25 steps.
84. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (C0 C0)) B0))) didn't succeeded in 25 steps.
85. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . B0) (B0 B0)))) didn't succeeded in 25 steps.
86. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . C0) (B0 B0)))) didn't succeeded in 25 steps.
87. ((^ A0 . (A0 A0)) (^ B0 . ((a0 a0) (B0 B0)))) didn't succeeded in 25 steps.
88. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((B0 B0) B0)))) didn't succeeded in 25 steps.
89. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((^ C0 . B0) B0)))) didn't succeeded in 25 steps.
90. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((^ C0 . C0) B0)))) didn't succeeded in 25 steps.
91. ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 (B0 B0))))) didn't succeeded in 25 steps.
92. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (B0 B0))))) failed.
93. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (B0 C0))))) didn't succeeded in 25 steps.
94. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (C0 B0))))) failed.
95. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (C0 C0))))) failed.
96. ((^ A0 . (A0 A0)) (^ B0 . (B0 (a0 (B0 B0))))) didn't succeeded in 25 steps.
97. ((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 (B0 B0))))) didn't succeeded in 25 steps.
98. ((^ A0 . (A0 A0)) (^ B0 . (a0 (a0 (B0 B0))))) didn't succeeded in 25 steps.
99. ((^ A0 . (^ B0 . ((A0 A0) A0))) (^ C0 . (C0 C0))) failed.
100. ((^ A0 . (^ B0 . ((A0 A0) B0))) (^ C0 . (C0 C0))) failed.
101. ((^ A0 . (^ B0 . ((A0 A0) a0))) (^ C0 . (C0 C0))) failed.
102. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . ((C0 C0) C0))) didn't succeeded in 25 steps.
103. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . ((C0 C0) a0))) didn't succeeded in 25 steps.
104. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 (C0 C0)))) didn't succeeded in 25 steps.
105. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (a0 (C0 C0)))) didn't succeeded in 25 steps.
106. ((^ A0 . (^ B0 . (B0 (A0 A0)))) (^ C0 . (C0 C0))) failed.
107. ((^ A0 . (^ B0 . (^ C0 . (A0 A0)))) (^ D0 . (D0 D0))) failed.
108. ((^ A0 . (^ B0 . (a0 (A0 A0)))) (^ C0 . (C0 C0))) failed.
109. ((^ A0 . (a0 ((A0 A0) a0))) (^ B0 . (B0 B0))) failed.
110. ((^ A0 . (a0 (A0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
111. ((^ A0 . (a0 (A0 A0))) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
112. ((^ A0 . (a0 (A0 A0))) (^ B0 . ((B0 B0) b0))) didn't succeeded in 25 steps.
113. ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
114. ((^ A0 . (a0 (A0 A0))) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
115. ((^ A0 . (a0 (A0 A0))) (^ B0 . (b0 (B0 B0)))) didn't succeeded in 25 steps.
116. ((^ A0 . (a0 (^ B0 . (A0 A0)))) (^ C0 . (C0 C0))) failed.
117. ((^ A0 . (a0 (b0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
118. ((^ A0 . A0) ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) failed.
119. ((a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) a0) failed.
120. ((a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) b0) failed.
121. ((a0 a0) ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.
122. ((a0 b0) ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.
123. (^ A0 . (((^ B0 . (B0 B0)) (^ C0 . (C0 C0))) A0)) failed.
124. (^ A0 . (((^ B0 . (B0 B0)) (^ C0 . (C0 C0))) a0)) failed.
125. (^ A0 . ((^ B0 . ((B0 B0) A0)) (^ C0 . (C0 C0)))) failed.
126. (^ A0 . ((^ B0 . ((B0 B0) B0)) (^ C0 . (C0 C0)))) failed.
127. (^ A0 . ((^ B0 . ((B0 B0) a0)) (^ C0 . (C0 C0)))) failed.
128. (^ A0 . ((^ B0 . (A0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
129. (^ A0 . ((^ B0 . (B0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
130. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) A0)))) didn't succeeded in 25 steps.
131. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) C0)))) didn't succeeded in 25 steps.
132. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) a0)))) didn't succeeded in 25 steps.
133. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (A0 (C0 C0))))) didn't succeeded in 25 steps.
134. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 (C0 C0))))) didn't succeeded in 25 steps.
135. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (a0 (C0 C0))))) didn't succeeded in 25 steps.
136. (^ A0 . ((^ B0 . (^ C0 . (B0 B0))) (^ D0 . (D0 D0)))) failed.
137. (^ A0 . ((^ B0 . (a0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
138. (^ A0 . (A0 ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
139. (^ A0 . (^ B0 . ((^ C0 . (C0 C0)) (^ D0 . (D0 D0))))) failed.
140. (^ A0 . (a0 ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
141. (a0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0)) failed.
142. (a0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) b0)) failed.
143. (a0 ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0)))) failed.
144. (a0 ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0)))) failed.
145. (a0 ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0)))) failed.
146. (a0 ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0)))) didn't succeeded in 25 steps.
147. (a0 ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) b0)))) didn't succeeded in 25 steps.
148. (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0))))) didn't succeeded in 25 steps.
149. (a0 ((^ A0 . (A0 A0)) (^ B0 . (b0 (B0 B0))))) didn't succeeded in 25 steps.
150. (a0 ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0)))) failed.
151. (a0 ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0)))) failed.
152. (a0 (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
153. (a0 (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0))))) failed.


---------------------------
Two Thoughts on Lisp Syntax
---------------------------
http://kazimirmajorinc.blogspot.com/2011/01/two-thoughts-on-lisp-syntax.html

;                     1. Lisp has syntax
;
; It is frequently said that Lisp has no syntax. It is simplification:
; there is a syntax, just it is relatively simple and uniform,
; compared to other languages. For example, look at these two
; expressions:
                         (setq x 3 y 4)

                       (setq (x 3) (y 4))

; It is easy to imagine that these two expressions have same semantics,
; and that difference is purely syntactic. Even if we use some formal
; definition of syntax. For example, Wikipedia defines syntax as
;
;      "set of rules that defines the combinations of symbols
;       that are considered to be correctly structured programs
;       in that language."
;
;
;                    2. Which syntax is better?
;
; If code is written by programmer, then it is slightly easier
; to use (setq x 3 y 4) form. But if code is generated by program,
; then form (setq (x 3) (y 4)) is more suitable. For example, the
; function that extract variables from the setq expression in the
; form (setq x 3 y 4) might look like

   (define (setq-places s)
           (let((counter 0)
                (result '()))

               (dolist(i s)
                  (inc counter)
                  (when (even? counter)
                        (push i result -1))) ; push on the right side

                result))

; It is very simple, but verbose code. If I have luck and my Lisp
; supports some  suitable functions, it might be even simpler. However,
; it appears that it is always simpler to extract the variables
; from the form (setq (x 3) (y 4)):

        (define (setq-places s)
                (map first (rest s)))

; So, I'd say that overall, form (setq (x 3) (y 4)) is better.

Commenti:
---------
*** Unknown 8 February 2011 at 17:35
Though, this form (setq (x 3) (y 4)) kinda breaks a syntax-semantic correspondence consistency with the rest of lisp, because in general the first syntactical element in (a b c d ...) is a operator.

In the (setq (x 3) (y 4)) case, the x and y isn't operator. I can't think of a similar example in lisp right now.


-------------------------
Cantor's Enumerations (1)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-1.html

; George Cantor discovered that set of all pairs of the natural
; numbers is countable; i.e, there is bijective map
;
;                     N -> N × N
;
; where N is set of all natural numbers. This is the simplest
; bijection of that kind:
;
Nota: vedi immagine "Cantor_Pairing_Function.png" nella cartella "data".
;
; Each natural number, n is mapped to some pair of natural numbers,
; (r, c). That pair is on diagonale d. Inverse mapping is defined
; as well; for every pair of natural numbers, (r, c) there is a
; natural number n such that n is mapped to (r, c). However, if we
; want to write programs that use Cantor's enumeration, then we need
; explicit formulas.
;
; Let's say that n is given. First, we can calculate d, the diagonale
; on which n is placed. From picture
;
;           n <= 1 + 2 + ... + d = d * (d + 1) / 2
;
; i.e. we search for minimal natural number d such
;
;                d^2 + d - 2n >= 0
;
;                d = ceil ( - 1 + sqrt (1 + 8*n) / 2)
;
; When we know d, then it is easy to calculate
;
;                r = n - d * (d - 1) / 2
;
;                c = d - r + 1
;
; Inversly, if r and c are given, then d can be calculated as
;
;                d = c + r - 1
;
; and            n = d * (d - 1) /2 + r
;
; I'll define Newlisp functions, using longer names;
;
; First, lets define functions that calculate d, r and c on the
; base of n. I'll give longer names to these functions:
; cantors-diagonal1, cantors-row and cantors-column respectively.

(setf cantors-diagonal1
  (lambda(n)(ceil (div (add (- 1)
                            (sqrt (add 1 (mul 8 n))))
                        2))))

(setf cantors-row
   (lambda (n)
      (let ((cd (cantors-diagonal1 n)))
           (- n (/ (* cd
                      (- cd 1))
                   2)))))

(setf cantors-column (lambda (n) (+ (cantors-diagonal1 n)
                                    (- (cantors-row n))
                                    1)))

; Second, lets define functions that calcualte d and n on the base
; of r and c. I'll give longer names to these functions:
; cantors-diagonal2, and cantors-number.

(setf cantors-diagonal2 (lambda(r c)(+ c r (- 1))))

(setf cantors-number
      (lambda(r c)
         (let ((cd (cantors-diagonal2 r c)))
               (+ (/ (* cd (- cd 1)) 2) r))))

; Lets try two simple tests:

(for(n 1 10)
  (println (format "%2d" n) " -> " (list (cantors-row n) (cantors-column n))
             ", diagonal="  (cantors-diagonal1 n)))
(println)

(for(r 1 3)
  (for(c 1 3)
     (print "(" r "," c ") => "
            (format "n=%2d, " (cantors-number r c))
            (format "d=%1d;  " (cantors-diagonal2 r c))))
  (println))
(exit)

; Everything works.
;
;
;  1 -> (1 1), diagonal=1
;  2 -> (1 2), diagonal=2
;  3 -> (2 1), diagonal=2
;  4 -> (1 3), diagonal=3
;  5 -> (2 2), diagonal=3
;  6 -> (3 1), diagonal=3
;  7 -> (1 4), diagonal=4
;  8 -> (2 3), diagonal=4
;  9 -> (3 2), diagonal=4
; 10 -> (4 1), diagonal=4
;
; (1,1) => n= 1, d=1;  (1,2) => n= 2, d=2;  (1,3) => n= 4, d=3;
; (2,1) => n= 3, d=2;  (2,2) => n= 5, d=3;  (2,3) => n= 8, d=4;
; (3,1) => n= 6, d=3;  (3,2) => n= 9, d=4;  (3,3) => n=13, d=5;
;
; Cantor's row and Cantor's column remind on well known operators
; "div" and "mod", don't they?


-------------------------
Cantor's Enumerations (2)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-2.html

; It is possible to enumerate not only pairs of the natural numbers,
; but triplets as well. For a first step, I'll combine functions
; cantors-row and cantors column into one
;
;                  cantors-enumeration-2:N->N×N,
;
; and I'll also define inverse function
;
;               cantors-enumeration-2-inverse:N×N->N
;
; (If you want to "run" these examples, you might need to concatenate
; text of this post to text of previous post. Or, you can just read
; it as it is.)

(define cantors-enumeration-2
        (lambda(n)(list (cantors-row n) (cantors-column n))))

(define cantors-enumeration-2-inverse
        (lambda(r c)(cantors-number r c)))

; Now, cantor enumeration of triplets can be defined as
;
;                cantors-enumeration-3: N-> N x N x N

(define cantors-enumeration-3
        (lambda(n)(append (list (cantors-row n))
                          (cantors-enumeration-2 (cantors-column n)))))
;
; Is it bijection? Yes, it is - for completeness, here is the proof,
; but I advice you to skip through that, since it is very dry and
; "straight-forward."
;
; [1] Is it injection? It is, because, for every n1 and n2,
;     it is either
;
;    (1.1) (cantors-row n1) is different than (cantors-row n2), or
;    (1.2) (cantors-column n1) is different than (cantors-column n2)
;
;    if (1.1) then by definition (cantors-enumeration-3 n1) is different
;             than (cantors-enumeration-3 n2).
;    if (1.2) then (cantors-enumeration-2 (cantors-column n1)) is
;             different than (cantors-enumeration-2 (cantors-column n2))
;             because cantors-enumeration-2 is bijection, and then
;             (cantors-enumeration-3 n1) is different than
;             (cantors-enumeration-3 n2).
;
; [2] Is it surjection? First, there is m such that
;     (cantors-enumeration-2 m)=(y z). Also, there is n such that
;     (cantros-enumeration-2 n)=(x (cantors-column m)). So, yes,
;     it is surjection as well.
;
;  We can also define inverse enumeration:

(define cantors-enumeration-3-inverse
        (lambda(x y z)(let((m (cantors-enumeration-2-inverse y z)))
                          (cantors-enumeration-2-inverse x m))))
; lets test it:

(println "\ncantors-enumeration-3 and cantors-enumeration-3-inverse test:\n")

(for(i1 1 8)
   (letn((i2 (cantors-enumeration-3 i1))
         (i3 (apply cantors-enumeration-3-inverse i2)))
      (println (format "%2d" i1) " -> " i2 " => " (format "%2d" i3))))

;  1 -> (1 1 1) =>  1
;  2 -> (1 1 2) =>  2
;  3 -> (2 1 1) =>  3
;  4 -> (1 2 1) =>  4
;  5 -> (2 1 2) =>  5
;  6 -> (3 1 1) =>  6
;  7 -> (1 1 3) =>  7
;  8 -> (2 2 1) =>  8

(println)

(for(i 1 2)
  (for(j 1 2)
     (for(k 1 2)
        (letn((i1 (list i j k))
              (i2 (cantors-enumeration-3-inverse i j k))
              (i3 (cantors-enumeration-3 i2)))
        (println i1 " -> " (format "%2d" i2) " => " i3)))))

; (1 1 1) ->  1 => (1 1 1)
; (1 1 2) ->  2 => (1 1 2)
; (1 2 1) ->  4 => (1 2 1)
; (1 2 2) -> 11 => (1 2 2)
; (2 1 1) ->  3 => (2 1 1)
; (2 1 2) ->  5 => (2 1 2)
; (2 2 1) ->  8 => (2 2 1)
; (2 2 2) -> 17 => (2 2 2)

; By inductions, enumeration can be defined for p-tuples, where
; p is any natural number. Perhaps p=1 is unnecessary case, but I
; defined it, however, for sake of completeness.

(define (cantors-enumeration p n)
        (cond ((= p 1) (list n))
              ((> p 1) (cons (cantors-row n)
                             (cantors-enumeration (- p 1) (cantors-column n))))))


(define (cantors-enumeration-inverse)
        ; p is not needed since it can be calculated from the
        ; number of arguments
        (letn((arguments (args))
             (p (length arguments)))
            (cond ((= p 1) (first arguments))
                  ((> p 1) (apply cantors-number
                                  (cons (first arguments)
                                        (apply cantors-enumeration-inverse
                                               (rest arguments))))))))

; Test again

(println "\ncantors-enumeration and cantors-enumeration-inverse test:\n")

(for(i1 1 16)
    (letn((i2 (cantors-enumeration 4 i1))
          (i3 (apply cantors-enumeration-inverse i2)))
      (println (format "%2d" i1) " -> " i2 " => " (format "%2d" i3))))

;  1 -> (1 1 1) =>  1
;  2 -> (1 1 2) =>  2
;  3 -> (2 1 1) =>  3
;  4 -> (1 2 1) =>  4
;  5 -> (2 1 2) =>  5
;  6 -> (3 1 1) =>  6
;  7 -> (1 1 3) =>  7
;  8 -> (2 2 1) =>  8
;  9 -> (3 1 2) =>  9
; 10 -> (4 1 1) => 10
; 11 -> (1 2 2) => 11
; 12 -> (2 1 3) => 12
; 13 -> (3 2 1) => 13
; 14 -> (4 1 2) => 14
; 15 -> (5 1 1) => 15
; 16 -> (1 3 1) => 16

(println)

(for(i 1 2)
  (for(j 1 2)
    (for(k 1 2)
       (for(l 1 2)
          (letn((i1 (list i j k l))
                (i2 (cantors-enumeration-inverse i j k l))
                (i3 (cantors-enumeration 4 i2)))
            (println i1 " -> " (format "%3d" i2) " => " i3))))))

; (1 1 1 1) ->   1 => (1 1 1 1)
; (1 1 1 2) ->   2 => (1 1 1 2)
; (1 1 2 1) ->   7 => (1 1 2 1)
; (1 1 2 2) ->  56 => (1 1 2 2)
; (1 2 1 1) ->   4 => (1 2 1 1)
; (1 2 1 2) ->  11 => (1 2 1 2)
; (1 2 2 1) ->  29 => (1 2 2 1)
; (1 2 2 2) -> 137 => (1 2 2 2)
; (2 1 1 1) ->   3 => (2 1 1 1)
; (2 1 1 2) ->   5 => (2 1 1 2)
; (2 1 2 1) ->  12 => (2 1 2 1)
; (2 1 2 2) ->  68 => (2 1 2 2)
; (2 2 1 1) ->   8 => (2 2 1 1)
; (2 2 1 2) ->  17 => (2 2 1 2)
; (2 2 2 1) ->  38 => (2 2 2 1)
; (2 2 2 2) -> 155 => (2 2 2 2)

; Everything works.

(exit)


-------------------------
Cantor's Enumerations (3)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-3.html

; Grand finale of these few posts on Cantor's enumerations is
; enumeration of all finite sequences of natural numbers - including
; singles. Same Cantor's trick, but this time on more abstract
; level, can be used:
;
;    a11, a12, .... is enumerated list of all singles
;    a21, a22, .... is enumerated list of all pairs
;    a31, a32, .... is enumerated list of all triplets
;    ...
;
; It doesn't matter that aij's are the result of the Cantor's enumeration;
; Same Cantor's enumeration can be applied again:
;    a11, a12, a21, a31, a22, a32 ...
;
; After such enumeration, all finite sequences will be on our list, enumerated.
;
; What might be the next step - enumerating all infinite sequences?
; Unfortunately, it is impossible.
;
; If you want to run this post as program, you need to cut and paste
; previous two posts on the beginning. Alternatively, you can simply
; read the posts and believe me about results.

(println)

(define cantors-enumeration-finite
        (lambda(n)
          (cantors-enumeration (cantors-row n) (cantors-column n))))

(define cantors-enumeration-finite-inverse
        (lambda()
          (let((arguments (args)))
            (cantors-enumeration-inverse (length arguments)
                                         (apply cantors-enumeration-inverse arguments)))))

; Test

(for(i1 1 45)
  (letn((i2 (cantors-enumeration-finite i1))
        (i3 (apply cantors-enumeration-finite-inverse i2)))
        (println (format "%2d" i1) " -> " i2 " -> " (format "%2d" i3))))

; The result is pretty:

 1 -> (1) ->  1
 2 -> (2) ->  2
 3 -> (1 1) ->  3
 4 -> (3) ->  4
 5 -> (1 2) ->  5
 6 -> (1 1 1) ->  6
 7 -> (4) ->  7
 8 -> (2 1) ->  8
 9 -> (1 1 2) ->  9
10 -> (1 1 1 1) -> 10
11 -> (5) -> 11
12 -> (1 3) -> 12
13 -> (2 1 1) -> 13
14 -> (1 1 1 2) -> 14
15 -> (1 1 1 1 1) -> 15
16 -> (6) -> 16
17 -> (2 2) -> 17
18 -> (1 2 1) -> 18
19 -> (2 1 1 1) -> 19
20 -> (1 1 1 1 2) -> 20
21 -> (1 1 1 1 1 1) -> 21
22 -> (7) -> 22
23 -> (3 1) -> 23
24 -> (2 1 2) -> 24
25 -> (1 2 1 1) -> 25
26 -> (2 1 1 1 1) -> 26
27 -> (1 1 1 1 1 2) -> 27
28 -> (1 1 1 1 1 1 1) -> 28
29 -> (8) -> 29
30 -> (1 4) -> 30
31 -> (3 1 1) -> 31
32 -> (2 1 1 2) -> 32
33 -> (1 2 1 1 1) -> 33
34 -> (2 1 1 1 1 1) -> 34
35 -> (1 1 1 1 1 1 2) -> 35
36 -> (1 1 1 1 1 1 1 1) -> 36
37 -> (9) -> 37
38 -> (2 3) -> 38
39 -> (1 1 3) -> 39
40 -> (3 1 1 1) -> 40
41 -> (2 1 1 1 2) -> 41
42 -> (1 2 1 1 1 1) -> 42
43 -> (2 1 1 1 1 1 1) -> 43
44 -> (1 1 1 1 1 1 1 2) -> 44
45 -> (1 1 1 1 1 1 1 1 1) -> 45


---------------------------------
Enumeration of Lambda-Expressions
---------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/enumeration-of-lambda-expressions.html

(setf [println.supressed] true [print.supressed] true)
(load "http://instprog.com//Instprog.default-library.lsp")
(setf [println.supressed] nil [print.supressed] nil)

; The lambda-expressions are defined on following way:
;
; (a) a, b, c, ... are lambda-expressions. These lambda expressions
;     are named "variables".
;
; (b) if X is variable and E is lambda-expression, then
;
;                            (^ X . E)
;
;     is lambda-expression as well. These lambda-expressions are
;     named "functions".
;
; (c) if E and F are lambda-expressions, then (E F) is lambda-
;     expression as well. These lambda expressions are named
;     "applications."
;
; Using functions for Cantor's enumeration developed in last few
; posts, now in my library, I'll define functions for enumeration
; of all lambda-expressions, i.e. bijective function
;
;                    lam: N -> all lambda-exprsions
;
; Enumerations of variables, functions, and applications will be
; defined independently.
;
;       var1, var2, ..., varn, ...
;       fun1, fun2, ..., funn, ...
;       app1, app2, ..., appn, ...
;
; After that, all lambda expressions will be enumerated on following
; way:
;
;       var1, fun1, app1, var2, fun2, app2, ...
;
;---------------------------------------------------------------
;
; First - enumeration of variables; and inverse enumeration.
;
; If alphabet is, for example, "xyz", I'll enumerate variables
; on following way:
;
;       x, y, z, x1, y1, z1, x2, y2, z2 ...
;
; It slightly complicates enumeration, but it looks better than
;
;       x0, y0, z0, x1, y1, ...

(setf var (lambda(n alphabet)
             (letn((l (length alphabet))
                   (first-char (alphabet (% (- n 1) l)))
                   (rest-chars (let((n1 (/ (- n 1) l)))
                               (if (= n1 0) "" (string n1)))))
                  (sym (append first-char rest-chars)))))

(setf var-inverse (lambda(v alphabet)
                     (letn((l (length alphabet))
                           (first-char (first (string v)))
                           (rest-chars (rest (string v))))
                          (when (= rest-chars "")
                                (setf rest-chars "0"))
                          (+ (* (int rest-chars) l)
                             (find first-char alphabet) 1))))
;
;---------------------------------------------------------------
;
; Second, enumeration of functions - and inverse enumeration.
;
; Every function has form (^ <var> <lambda-expression>), where
; any variable and lambda-expression is allowed. All pairs of
; variables and lambda-expressions can be enumerated using
; Cantor's enumeration:

(setf fun (lambda(n alphabet)
             (list '^
                   (var (cantors-row n) alphabet)
                   '.
                   (lam (cantors-column n) alphabet))))

(setf fun-inverse
  (lambda(f alphabet)
     (cantors-enumeration-inverse (var-inverse (f 1) alphabet)
                                  (lam-inverse (f 3) alphabet))))
;
;---------------------------------------------------------------
;
; Third, enumeration of applications - and inverse enumeration.
;
; Every application has form (<lambda-expression1> <lambda-expression2>),
; For enumeration of pairs of lambda-expressions, we need Cantors
; enumeration again.

(setf app (lambda(n alphabet)
            (list (lam (cantors-row n) alphabet)
                  (lam (cantors-column n) alphabet))))

(setf app-inverse
  (lambda(a alphabet)
    (cantors-enumeration-inverse (lam-inverse (first a) alphabet)
                                 (lam-inverse (last a) alphabet))))

;
;---------------------------------------------------------------
;
; Finally, enumeration of lambda expressions - and inverse enumeration:

(setf lam (lambda(n alphabet)
            (letn((n1 (- n 1))
                  (row (+ (% n1 3) 1))
                  (column (+ (/ n1 3) 1)))

              (case row (1 (var column alphabet))
                        (2 (fun column alphabet))
                        (3 (app column alphabet))))))

; For lam-inverse, I need few helper predicates:

(setf var? (lambda(l)(symbol? l)))
(setf fun? (lambda(l)(and (list? l) (= (length l) 4))))
(setf app? (lambda(l)(and (list? l) (= (length l) 2))))

(setf lam-inverse
      (lambda(l alphabet)
         (local(row column)
           (cond ((var? l)(setf row 1)
                          (setf column (var-inverse l alphabet)))
                 ((fun? l)(setf row 2)
                          (setf column (fun-inverse l alphabet)))
                 ((app? l)(setf row 3)
                          (setf column (app-inverse l alphabet))))
            (+ (* 3 (- column 1)) row))))

;---------------------------------------------------------------
;
;                          TEST

(for(i1 1 10)
  (letn((i2 (lam i1 "xyz"))
       (i3 (lam-inverse i2 "xyz")))
       (println i1 " -> " i2 " => " i3)))

; Here is output - ten nice lambda expressions

; 1 -> x => 1
; 2 -> (^ x . x) => 2
; 3 -> (x x) => 3
; 4 -> y => 4
; 5 -> (^ x . (^ x . x)) => 5
; 6 -> (x (^ x . x)) => 6
; 7 -> z => 7
; 8 -> (^ y . x) => 8
; 9 -> ((^ x . x) x) => 9
; 10 -> x1 => 10
;
; In case you like these, here is one million lambda-expressions.
;
;
; (set 'out-file (open "C://lambda-expressions.txt" "write"))
; (for(i1 1 1000000)
;   (letn((i2 (lam i1 "xyz"))
;         (i3 (append (string i1) ".  " (string i2))))
;        (write-line out-file i3)))
; (close out-file)
;

(exit)

---------------------------------
199019 Reduced Lambda-Expressions
---------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/many-reduced-lambda-expressions.html

; The function that enumerates all lambda-expressions and the
; functions that perform few well known reductions of lambda-
; expressions are described in last posts. Recently, I wrote
; the program that generates and attempts to reduce all lambda-
; expressions to normal.
;
; Lambda expressions are enumerated and generated using Cantor's style
; enumeration of all lambda-expressions described in previous posts.
; However, some lambda expressions generated that way are obviously
; redundant. For example,
;
;                           ((^a.a) b)
;
; and
;                           ((^b.b) a)
;
; differ only in names of variables. To avoid such redundancies,
; program attempted to reduce only lambda expressions such that
; variables occur in alphabetical order, i.e. ((^a.a) b), but
; not ((^a.a) c) or ((^b.b) a). Program is left to work long
; enough so
;
;    23 969 511 lambda-expressions are generated
;
;       200 000 of these were non-redundant in just defined sense, and
;               attempts for reduction of these lambda-expressions
;               to normal form is done.
;
;       199 019 lambda-expressions are successefully reduced to
;               normal form,
;
;           934 lambda-expressions are proven irreducible, because
;               cycle is discovered and
;
;            47 lambda-expressions are not reduced: in 35 reductions
;               normal form wasn't reached, but cycle wasn't discovered
;               either. It appears that almost all of these
;               lambda-expressions grow infinitely.
;
; Standard lambda-reductions are used:
;
;    alpha reduction :  (^ x . x) <-> (^ y . y), i.e. bounded
;                       variables can be freely renamed.
;
;    eta reduction:     (^ x . (F x)) -> F i.e. elimination of
;                       redundant function definition
;
;    beta reduction:    ((^ x . F) G) -> F[x:=G], i.e. substitution
;                       of G for x in F. Beta reduction is not defined
;                       if G contains x as free variable.
;
; The reduction algorithm uses normal order of evaluation (i.e.
; like Lisp fexprs and Haskell functions), which is known to be
; superior to applicative order of evaluation (like functions in
; Lisp and in almost all other programming languages.)
;
; The program performs alpha-conversion after each reduction. Bounded
; variables are renamed to
;
;              x, y, z, x1, y1, z1, x2, ...
;
; The algorithm attempts to make eta-reduction before beta reduction.
; Although eta-reduction is prefered, it was done only 3047 times
; total, while beta-reduction is performed 304254 times, i.e. 100
; times more frequently.
;
; Here is one of them:
;
;   ------  8167/277305. ------
;
;   1. ==[ start ]==> ((^a.(a (a a)))((^a.(a a))(^a.a)))
;   2. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y y))(^z.z)))
;   3. ==[ beta  ]==> (((^y.(y y))(^z.z))(((^y.(y y))(^z.z))((^y.(y y))(^z.z))))
;   4. ==[ alpha ]==> (((^x.(x x))(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   5. ==[ beta  ]==> (((^y.y)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   6. ==[ alpha ]==> (((^x.x)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   7. ==[ beta  ]==> ((^y.y)(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   8. ==[ alpha ]==> ((^x.x)(((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1))))
;   9. ==[ beta  ]==> (((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1)))
;  10. ==[ alpha ]==> (((^x.(x x))(^y.y))((^z.(z z))(^x1.x1)))
;  11. ==[ beta  ]==> (((^y.y)(^y.y))((^z.(z z))(^x1.x1)))
;  12. ==[ alpha ]==> (((^x.x)(^y.y))((^z.(z z))(^x1.x1)))
;  13. ==[ beta  ]==> ((^y.y)((^z.(z z))(^x1.x1)))
;  14. ==[ alpha ]==> ((^x.x)((^y.(y y))(^z.z)))
;  15. ==[ beta  ]==> ((^y.(y y))(^z.z))
;  16. ==[ alpha ]==> ((^x.(x x))(^y.y))
;  17. ==[ beta  ]==> ((^y.y)(^y.y))
;  18. ==[ alpha ]==> ((^x.x)(^y.y))
;  19. ==[ beta  ]==> (^y.y)
;  20. ==[ alpha ]==> (^x.x)
;
;      REDUCED to normal form.
;
; For others, go to
;
;      Reduced lambda-expressions       1 -  25 000
;      Reduced lambda-expressions  25 001 -  50 000
;      Reduced lambda-expressions  50 001 -  75 000
;      Reduced lambda-expressions  75 001 - 100 000
;      Reduced lambda-expressions 100 001 - 125 000
;      Reduced lambda-expressions 125 001 - 150 000
;      Reduced lambda-expressions 150 001 - 175 000
;      Reduced lambda-expressions 175 001 - 200 000
;
; Alternatively, 200 000 of reduced lambda expressions in one large text file:
;
;      200 000 Reduced lambda-expressions
;
; Warning: that file is large: 60 MB.

Commenti:
---------
*** Kazimir Majorinc 13 November 2013 at 22:18
I'm glad you like it, Shaun. The files are just moved on http://kazimirmajorinc.com, currently under the "Programs".


-------------------------------
Lambda Calculus Interpreter (2)
-------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/lambda-calculus-interpreter-2.html

Use of "reduce^" from Newlisp REPL

c:\Newlisp>newlisp
newLISP v.10.2.18 on w1n32 IPv4/6. execute 'newl1sp -h' for more info.

> (setf [pr1ntln.supressed] true [print.supressed] true)
true
> (load "http://instprog.com/instprog.default-library.lsp")
true
(setf [println.supressed] nil [print.supressed] nil)
nil
> (reduce^ '(^ a . (a (a a)))((^ a . (a a))(^ a . a))) 25 true)
;   1. ==[ start ]==> ((^a.(a (a a)))((^a.(a a))(^a.a)))
;   2. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y y))(^z.z)))
;   3. ==[ beta  ]==> (((^y.(y y))(^z.z))(((^y.(y y))(^z.z))((^y.(y y))(^z.z))))
;   4. ==[ alpha ]==> (((^x.(x x))(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   5. ==[ beta  ]==> (((^y.y)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   6. ==[ alpha ]==> (((^x.x)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   7. ==[ beta  ]==> ((^y.y)(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   8. ==[ alpha ]==> ((^x.x)(((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1))))
;   9. ==[ beta  ]==> (((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1)))
;  10. ==[ alpha ]==> (((^x.(x x))(^y.y))((^z.(z z))(^x1.x1)))
;  11. ==[ beta  ]==> (((^y.y)(^y.y))((^z.(z z))(^x1.x1)))
;  12. ==[ alpha ]==> (((^x.x)(^y.y))((^z.(z z))(^x1.x1)))
;  13. ==[ beta  ]==> ((^y.y)((^z.(z z))(^x1.x1)))
;  14. ==[ alpha ]==> ((^x.x)((^y.(y y))(^z.z)))
;  15. ==[ beta  ]==> ((^y.(y y))(^z.z))
;  16. ==[ alpha ]==> ((^x.(x x))(^y.y))
;  17. ==[ beta  ]==> ((^y.y)(^y.y))
;  18. ==[ alpha ]==> ((^x.x)(^y.y))
;  19. ==[ beta  ]==> (^y.y)
;  20. ==[ alpha ]==> (^x.x)

    REDUCED to normal form.
(reduced (^ x . x) 20)

(setf [println.supressed] true [print.supressed] true)
(load "http://instprog.com/Instprog.default-library.lsp" )
(setf [println.supressed] nil [print.supressed] nil)

;---------------------------------------------------------------
; Interpreter for lambda-calculus, described in recent posts is now
; integrated in my library for Newlisp, as function "reduce^".
;
; Here is example demonstrating how it works. If you want to see
; implementatition details, check the library. Check the previous
; posts also.

(println  (reduce^ '((^ x . (x (x x))) (^ y . (y (y y)))) ;lambda-expression

                        10   ;maximal number of reductions,
                             ;useful for non-terminating lambda-expressions

                        true ;true if you want reduction steps are printed on screen
                             ;nil if you want "silent" interpretation
                        ))

(println  (reduce^ '((^ x . x) (^ x . x))

                        10

                        true

                        ))

(println (reduce^ '((^ x . (x x)) (^ x . (x x)))

                        10

                        true
                        ))


(exit)

; OUTPUT:
;
;   1. ==[ start ]==> ((^x.(x (x x)))(^y.(y (y y))))
;   2. ==[ beta  ]==> ((^y.(y (y y)))((^y.(y (y y)))(^y.(y (y y)))))
;   3. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y (y y)))(^z.(z (z z)))))
; ...
;
;      UNREDUCED: maximal number of reductions reached.
;
; (unreduced ((((^ y . (y (y y))) ((^ y . (y (y y))) (^ y . (y (y y))))) (((^ z . (
;        z
;        (z z)))
;      (^ x1 . (x1 (x1 x1))))
;     ((^ y1 . (y1 (y1 y1))) (^ z1 . (z1 (z1 z1))))))
;   (((^ x2 . (x2 (x2 x2))) (^ y2 . (y2 (y2 y2)))) ((^ z2 . (z2 (z2 z2))) (^ x3 . (
;       x3
;       (x3 x3)))))) 10)
;
;   1. ==[ start ]==> ((^x.x)(^x.x))
;   2. ==[ alpha ]==> ((^x.x)(^y.y))
;   3. ==[ beta  ]==> (^y.y)
;   4. ==[ alpha ]==> (^x.x)
;
;      REDUCED to normal form.
;
; (reduced (^ x . x) 4)
;
;   1. ==[ start ]==> ((^x.(x x))(^x.(x x)))
;   2. ==[ alpha ]==> ((^x.(x x))(^y.(y y)))
;   3. ==[ beta  ]==> ((^y.(y y))(^y.(y y)))
;   4. ==[ alpha ]==> ((^x.(x x))(^y.(y y)))
;
;      IRREDUCIBLE: cycle.
;
; (irreducible ((^ x . (x x)) (^ y . (y y))) 4)
;
;
;

If you like this post, you'll probably like: "Almost two hundred thousand reduced lambda-expressions".


-----------------------------------------------------
Some differences between lambda-calculus and Lisp (1)
-----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/some-differences-between-lambda.html

;                        0. Introduction
;
;
; At the first sight, Lisp dialects appear like extensions of the
; lambda-calculus. Syntax of the two is especially similar. For
; instance,
;
;                          ((^ x . x) y)
;
; in lambda-calculus is very similar to
;
;                         ((lambda(x)x) y)
;
; in Lisp. However, it turns that there are many important
; differences between lambda-calculus and Lisp, some of these
; are obvious, and others are quite subtle. In this post, I'll
; list and comment few of these I've find to be interesting and
; important. The post is not tutorial on lambda-calculus, but
; another view that might be interesting to those who already
; know lambda-calculus, but maybe also - to some extent - to those
; who do not know it yet.
;
;
;
;        1. The notion of lambda-expression
;
;
; There is significant difference even in basic terminology.
; For instance, this is definition of lambda-expression in Common
; Lisp Hyperspec:
;
;    "lambda expression n. a list which can be used in place of a
;     function name in certain contexts to denote a function by
;     directly describing its behavior rather than indirectly by
;     referring to the name of an established function; its name
;     derives from the fact that its first element is the symbol
;     lambda."
;
; In lambda-calculus, lambda-expression is the name used for
; all allowed expressions of lambda-calculus. According to definition,
; lambda expressions are:
;
;       1. variables: a, b, c, d ... a1, a2, ...
;       2. functions: (^ v . F), where v is any variable, F any lambda-expr.
;       3. applications: (E F), where E and F are lambda-expressions.
;
; This difference, although not essential is very confusing one.
;
;
;
;                 2. Evaluation vs. reduction
;
;
; In Lisp, expressions are "evaluated." For instance,
;
;            ((lambda(x)x) y) => value of y.
;
; In lambda-calculus, expressions are "reduced". Reduction
; doesn't require replacement of the variables with values, so
;
;                   ((^ x . x) y) => y
;
; and not
;
;                   ((^ x . x) y) => value of y.
;
; If we remember high school math, some of the exercises were of
; the form "simplify" or "expand", and didn't required knowledge
; about value of the variables to be solved.
;
;           (x+1)^2 -1 ==> (x^2+2x+1) -1 = x(x+2)
;
; Other group of exercises clearly required evaluation:
;
;       "Find the area of the rhomboid with sides
;        a=4, b=3, and angle of 30° between them."
;
;
;
;       3. Recursiveness of evaluation in Lisp
;                                 vs.
;           non-recursiveness of beta-reduction
;                     in lambda-calculus
;
;
; There are three reductions in lambda-calculus; only short
; resume here - formal definition find somewhere else.
;
;     1. Beta-reduction: the application of the function
;
;                ((^x.x) a) => a,
;                ((^x.(x x)) a) => (a a).
;
;     2. Alpha-reduction: renaming of the bounded variables
;
;                (^x.x) => (^y.y).
;
;     3. Eta-reduction: elimination of the redundant function
;
;                (^x.((^y.y)x)) => (^y.y).
;
;        (eta-reduction is not essential; it can be replaced
;         with other two.)
;
; Beta-reduction is very similar to function application
; in Lisp. However, there are significant differences.
;

;
; In Lisp, evaluation of the function application, for instance,
;
;                  ((lambda(x)(x x)) (a b))
;
; is performed on the following way:
;
;    - argument (here (a b)) is evaluated;
;    - result is assigned to the parameter (here x), and
;    - body of the function, (here (x x)) is evaluated.
;    - the result is returned as the result of  evaluation of
;      whole expression.
;
;
; In lambda-calculus, beta-reduction of the application,
; for instance,
;
;                    ((^x.(x x)) (a b))
;
; is performed on a following way:
;
;     - argument (here (a b)) is substituted for parameter (here x)
;       in the body of the function (here (x x)).
;     - the result of the substitution is result of beta-reduction.
;
; The result of the two is significantly different.
;
;     Note that beta reduction does significantly less than
;     evaluation. Beta-reduction doesn't apply itself recursively
;     on y and on (x x), while evaluation in Lisp does - it requires
;     evaluation of
;
;
;
;      3.1. Example: Church's lambda in Newlisp
;
;
; I'll use previous discussion to define
;
;                        lambda-Church
;
; in Newlisp, so expressions using it are evaluated just like
; lambda-expressions are beta reduced in lambda-calculus. For
; instance, I want
;
;                   ((lambda-Church (x) (x x)) (a b))
;
; to evalute to
;
;                      ((a b)(a b)).
;
; What should I do? In Newlisp, because it has fexprs, its easy.
; Expression
;
;                     (lambda-Church (x) (x x))
;
; should be evaluated to
;
;               (lambda-macro(x)(expand (quote (x x))
;                                       (quote x)))
;
; and that's all.

(define-macro (lambda-Church head body)
  (let ((var (first head)))
     (expand (lambda-macro(var)(expand (quote body)
                                       (quote var)))
             (quote body)
             (quote var))))

; Let's test it.

(println (lambda-Church (x)(x x)))

;    ==> (lambda-macro (x) (expand (quote (x x)) (quote x)))

(println ((lambda-Church (x)(x x)) (a b)))

;    ==> ((a b) (a b))
;
; It works. In future, lambda-Church expressions can
; be freely mixed with other Newlisp expressions.
;
;
;
; To be  continued  ...


-----------------------------------------------------
Some differences between lambda-calculus and Lisp (2)
-----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/some-differences-between-lambda_31.html


; This is the second part of  previous post .
;
;
;
;                4. Evaluation in Lisp vs.
;    reduction to normal form in lambda-calculus
;
;
; As noted in previous post, in Lisp, evaluation of the function
; application is defined recursively:
;
;      1.  evaluation of the function arguments is performed
;      2.  resulting values are assigned to the parameters of
;          the function
;      2.  evaluation of the function body is performed
;
; In lambda calculus, beta-reductions do not recurse on that way.
; There is no "automatic" beta-reductions of the argument of the
; application.
;
; Because of that, in general case, one applies reductions many
; times to achieve similar effect. How many times? Typically,
; until further reduction is impossible; in that case, it is
; said that expression is reduced to normal form.
;
; There are few differences between evaluation in Lisp and
; reduction to normal form in lambda-calculus:
;
;
;              4.1. Order of reductions in
;            lambda-calculus is not defined
;
;
; Lambda-calculus is not an algorithm. It is a "formal system". One
; who performs reductions - human or computer - can pick the order of
; reductions by any criteria.
;
;
;     4.2. Lisp evaluation strategy is not the best for
;                     lambda-calculus
;
;
; In Lisp, order of evaluations is "from inside"; if application
; is evaluated, for example,
;
;          ((lambda(x)(+ x x)) ((lambda(x)(* x x)) 3) 2)
;
; then inner left argument, in this case
;
;                     ((lambda(x)(* x x)) 3)
;
; is evaluated first. That order is called "applicative order".
; In lambda-calculus, some expressions cannot be reduced applying
; that order of reductions. For example,
;
;               ((^x.a) ((^x.(x x)) (^x.(x x))))
;
; would be reduced indefinitely, because reduction of
;
;                   ((^x.(x x)) (^x.(x x)))
;
; doesn't terminate. Some other evaluation strategies, for example,
; "normal order", "from outside", as defined in lambda-Church, terminate:
;
(println ((lambda-Church (x) a) ((lambda-Church(x)(x x))
                                 (lambda-Church(x)(x x)))))

;        => a
;
;
;
;        4.3. Reduction to normal form is more
;           extensive than single evaluation
;
;
; 1. In Lisp, function, like
;
;              (lambda(x)((lambda(y)y) x)),
;
;    if evaluated is either evaluated to some "compiled value",
;    i.e. it is not S-expression any more - or evaluates to
;    itself, as in Newlisp.
;
;    In lambda-calculus, reduction is performed inside the function
;    body. For example,
;
;               (^x.((^y.y) x)) => (^x.x).
;
; 2. In Lisp, result of the evaluation of the S-expression is frequently
;    in form that allows further evaluation.
;
;               ((lambda(x)(list '+ 1 2 x)) 3) => '(+ 1 2 3)
;
;But, it is not evaluated automatically.

;
;
; To be continued ...


--------------------------------------------------------------
Some Basic Concepts Implemented and Reduced in Lambda-calculus
--------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/02/some-basic-concepts-implemented-and.html

; After support for meta-variables in lambda-calculus is integrated
; in my Newlisp library, I can easily demonstrate few fundamental
; concepts: Boolean constants, integers, IF, predecessor, successor,
; multiplication and recursion are implemented in lambda calculus
; and how reduction of the expressions really looks like.
;
; At the end, factorial function is implemented - this time without
; full reduction, because even reduction of (FACTORIAL 0) is too
; large to be published in blog. However, you can try it for yourself.
;
; Watch out: it is frequently said this can be done, but it is
; rarely actually done.
;
;                    LOADING LIBRARY
;

(setf [print.supressed] true [println.supressed] true)
(load "http://instprog.com/Instprog.default-library.lsp")
(setf [print.supressed] nil [println.supressed] nil)

;---------------------------------------------------------------

(setf TRUE '(^ x .(^ y . x)))

    (expand-and-reduce^ '((TRUE a) b) ; <- lambda-expression
                         5000         ; <- max number of expansions
                                      ;    and reductions
                         true)        ; <- true if output is needed

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((TRUE a) b)
;
;     1. ==[ original ]==> ((TRUE a) b)
;     2. ==[ expanded ]==> (((^x.(^y.x)) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^x.(^y.x)) a) b)
;     2. ==[ beta     ]==> ((^y.a) b)
;     3. ==[ alpha    ]==> ((^x.a) b)
;     4. ==[ beta     ]==> a
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------


(setf FALSE '(^ x . (^ y . y)))

     (expand-and-reduce^ '((FALSE a) b)
                         5000
                         true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((FALSE a) b)
;
;     1. ==[ original ]==> ((FALSE a) b)
;     2. ==[ expanded ]==> (((^x.(^y.y)) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^x.(^y.y)) a) b)
;     2. ==[ beta     ]==> ((^y.y) b)
;     3. ==[ alpha    ]==> ((^x.x) b)
;     4. ==[ beta     ]==> b
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf IF '(^ v .(^ t . (^ f . ((v t) f)))))

     (expand-and-reduce^ '(((IF a) b) c)
                         5000
                         true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF a) b) c)
;
;     1. ==[ original ]==> (((IF a) b) c)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f)))) a) b) c)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f)))) a) b) c)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z)))) a) b) c)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y))) a) b) c)
;     4. ==[ eta      ]==> ((((^x.x) a) b) c)
;     5. ==[ beta     ]==> ((a b) c)
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

     (expand-and-reduce^ '(((IF TRUE) a) b)
                          5000
                          true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF TRUE) a) b)
;
;     1. ==[ original ]==> (((IF TRUE) a) b)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.x))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.x))) a) b)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z))))(^u.(^v.u))) a) b)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y)))(^u.(^v.u))) a) b)
;     4. ==[ alpha    ]==> ((((^x.(^y.(x y)))(^z.(^u.z))) a) b)
;     5. ==[ eta      ]==> ((((^x.x)(^z.(^u.z))) a) b)
;     6. ==[ alpha    ]==> ((((^x.x)(^y.(^z.y))) a) b)
;     7. ==[ beta     ]==> (((^y.(^z.y)) a) b)
;     8. ==[ alpha    ]==> (((^x.(^y.x)) a) b)
;     9. ==[ beta     ]==> ((^y.a) b)
;    10. ==[ alpha    ]==> ((^x.a) b)
;    11. ==[ beta     ]==> a
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

     (expand-and-reduce^ '(((IF FALSE) a) b)
                          5000
                          true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF FALSE) a) b)
;
;     1. ==[ original ]==> (((IF FALSE) a) b)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.y))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.y))) a) b)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z))))(^u.(^v.v))) a) b)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y)))(^u.(^v.v))) a) b)
;     4. ==[ alpha    ]==> ((((^x.(^y.(x y)))(^z.(^u.u))) a) b)
;     5. ==[ eta      ]==> ((((^x.x)(^z.(^u.u))) a) b)
;     6. ==[ alpha    ]==> ((((^x.x)(^y.(^z.z))) a) b)
;     7. ==[ beta     ]==> (((^y.(^z.z)) a) b)
;     8. ==[ alpha    ]==> (((^x.(^y.y)) a) b)
;     9. ==[ beta     ]==> ((^y.y) b)
;    10. ==[ alpha    ]==> ((^x.x) b)
;    11. ==[ beta     ]==> b
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf APPLY '(^ v .(^ f . (v f))))

     (expand-and-reduce^ '((APPLY a) b)
                          5000
                          true)

;----------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((APPLY a) b)
;
;     1. ==[ original ]==> ((APPLY a) b)
;     2. ==[ expanded ]==> (((^v.(^f.(v f))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^v.(^f.(v f))) a) b)
;     2. ==[ alpha    ]==> (((^x.(^y.(x y))) a) b)
;     3. ==[ eta      ]==> (((^x.x) a) b)
;     4. ==[ beta     ]==> (a b)
;
;        REDUCED TO NORMAL FORM.
;
;----------------------------------------------------------------

; Y-combinator is tool that could be used for implementation of
; recursion

(setf Y '(^ f . ((^ x . (f (x x))) (^ x . (f (x x))))))

     (expand-and-reduce^ '(Y g)
                         12
                         true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (Y g)
;
;     1. ==[ original ]==> (Y g)
;     2. ==[ expanded ]==> ((^f.((^x.(f (x x)))(^x.(f (x x))))) g)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^f.((^x.(f (x x)))(^x.(f (x x))))) g)
;     2. ==[ alpha    ]==> ((^x.((^y.(x (y y)))(^z.(x (z z))))) g)
;     3. ==[ beta     ]==> ((^y.(g (y y)))(^z.(g (z z))))
;     4. ==[ alpha    ]==> ((^x.(g (x x)))(^y.(g (y y))))
;     5. ==[ beta     ]==> (g ((^y.(g (y y)))(^y.(g (y y)))))
;     6. ==[ alpha    ]==> (g ((^x.(g (x x)))(^y.(g (y y)))))
;     7. ==[ beta     ]==> (g (g ((^y.(g (y y)))(^y.(g (y y))))))
;     8. ==[ alpha    ]==> (g (g ((^x.(g (x x)))(^y.(g (y y))))))
;     9. ==[ beta     ]==> (g (g (g ((^y.(g (y y)))(^y.(g (y y)))))))
;    10. ==[ alpha    ]==> (g (g (g ((^x.(g (x x)))(^y.(g (y y)))))))
;    11. ==[ beta     ]==> (g (g (g (g ((^y.(g (y y)))(^y.(g (y y))))))))
;    12. ==[ alpha    ]==> (g (g (g (g ((^x.(g (x x)))(^y.(g (y y))))))))
;
;        UNREDUCED: MAX NUMBER OF REDUCTIONS REACHED.
;
; Take a look on the way "reduced" lambda-expression looks like;
;
;  (Y g) is reduced to (g (Y g))! If we use some more complicated
;  formula instead of g, and normal order of reduction, then
;  g will be evaluated first.
;
;---------------------------------------------------------------
(setf ZERO '(^ f . (^ x . x)))

   (expand-and-reduce^ ZERO
                       5000
                       true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (^f.(^x.x))
;
;     1. ==[ original ]==> (^f.(^x.x))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (^f.(^x.x))
;     2. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf SUCCESSOR '(^ n . (^ f . (^ x . (f ((n f) x))))))

   (expand-and-reduce^ '(SUCCESSOR ZERO)
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (SUCCESSOR ZERO)
;
;     1. ==[ original ]==> (SUCCESSOR ZERO)
;     2. ==[ expanded ]==> ((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))
;     2. ==[ alpha    ]==> ((^x.(^y.(^z.(y ((x y) z)))))(^u.(^v.v)))
;     3. ==[ beta     ]==> (^y.(^z.(y (((^u.(^v.v)) y) z))))
;     4. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.u)) x) y))))
;     5. ==[ beta     ]==> (^x.(^y.(x ((^u.u) y))))
;     6. ==[ alpha    ]==> (^x.(^y.(x ((^z.z) y))))
;     7. ==[ beta     ]==> (^x.(^y.(x y)))
;     8. ==[ eta      ]==> (^x.x)
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf ONE '(^ x . x))

   (expand-and-reduce^ '(SUCCESSOR (SUCCESSOR ZERO))
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (SUCCESSOR (SUCCESSOR ZERO))
;
;     1. ==[ original ]==> (SUCCESSOR (SUCCESSOR ZERO))
;     2. ==[ expanded ]==> ((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     2. ==[ alpha    ]==> ((^x.(^y.(^z.(y ((x y) z)))))((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))))
;     3. ==[ beta     ]==> (^y.(^z.(y ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) y) z))))
;     4. ==[ alpha    ]==> (^x.(^y.(x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x) y))))
;     5. ==[ beta     ]==> (^x.(^y.(x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x) y))))
;     6. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x) y))))
;     7. ==[ beta     ]==> (^x.(^y.(x ((^u.(x (((^v.(^w.w)) x) u))) y))))
;     8. ==[ alpha    ]==> (^x.(^y.(x ((^z.(x (((^u.(^v.v)) x) z))) y))))
;     9. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.v)) x) y)))))
;    10. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.u)) x) y)))))
;    11. ==[ beta     ]==> (^x.(^y.(x (x ((^u.u) y)))))
;    12. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.z) y)))))
;    13. ==[ beta     ]==> (^x.(^y.(x (x y))))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf ZERO? '(^ n . ((n (TRUE FALSE)) TRUE)))

   (expand-and-reduce^ '(ZERO? ZERO)
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (ZERO? ZERO)
;
;     1. ==[ original ]==> (ZERO? ZERO)
;     2. ==[ expanded ]==> ((^n.((n (TRUE FALSE)) TRUE))(^f.(^x.x)))
;     3. ==[ expanded ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))(^f.(^x.x)))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))(^f.(^x.x)))
;     2. ==[ alpha    ]==> ((^x.((x ((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w))))(^q.(^r.r)))
;     3. ==[ beta     ]==> (((^q.(^r.r))((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w)))
;     4. ==[ alpha    ]==> (((^x.(^y.y))((^z.(^u.z))(^v.(^w.w))))(^p.(^q.p)))
;     5. ==[ beta     ]==> ((^y.y)(^p.(^q.p)))
;     6. ==[ alpha    ]==> ((^x.x)(^y.(^z.y)))
;     7. ==[ beta     ]==> (^y.(^z.y))
;     8. ==[ alpha    ]==> (^x.(^y.x))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

   (expand-and-reduce^ '(ZERO? (SUCCESSOR ZERO))
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (ZERO? (SUCCESSOR ZERO))
;
;     1. ==[ original ]==> (ZERO? (SUCCESSOR ZERO))
;     2. ==[ expanded ]==> ((^n.((n (TRUE FALSE)) TRUE))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     3. ==[ expanded ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     2. ==[ alpha    ]==> ((^x.((x ((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w))))((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1))))
;     3. ==[ beta     ]==> ((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w)))
;     4. ==[ alpha    ]==> ((((^x.(^y.(^z.(y ((x y) z)))))(^u.(^v.v)))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1)))
;     5. ==[ beta     ]==> (((^y.(^z.(y (((^u.(^v.v)) y) z))))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1)))
;     6. ==[ alpha    ]==> (((^x.(^y.(x (((^z.(^u.u)) x) y))))((^v.(^w.v))(^p.(^q.q))))(^r.(^x1.r)))
;     7. ==[ beta     ]==> ((^y.(((^v.(^w.v))(^p.(^q.q)))(((^z.(^u.u))((^v.(^w.v))(^p.(^q.q)))) y)))(^r.(^x1.r)))
;     8. ==[ alpha    ]==> ((^x.(((^y.(^z.y))(^u.(^v.v)))(((^w.(^p.p))((^q.(^r.q))(^x1.(^y1.y1)))) x)))(^z1.(^u1.z1)))
;     9. ==[ beta     ]==> (((^y.(^z.y))(^u.(^v.v)))(((^w.(^p.p))((^q.(^r.q))(^x1.(^y1.y1))))(^z1.(^u1.z1))))
;    10. ==[ alpha    ]==> (((^x.(^y.x))(^z.(^u.u)))(((^v.(^w.w))((^p.(^q.p))(^r.(^x1.x1))))(^y1.(^z1.y1))))
;    11. ==[ beta     ]==> ((^y.(^z.(^u.u)))(((^v.(^w.w))((^p.(^q.p))(^r.(^x1.x1))))(^y1.(^z1.y1))))
;    12. ==[ alpha    ]==> ((^x.(^y.(^z.z)))(((^u.(^v.v))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1))))
;    13. ==[ beta     ]==> (^y.(^z.z))
;    14. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf MULTIPLY '(^ m . (^ n . (^ f . (m (n f))))))

   (expand-and-reduce^ '((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))
                                   (SUCCESSOR (SUCCESSOR ZERO)))
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))(SUCCESSOR (SUCCESSOR ZERO)))
;
;     1. ==[ original ]==> ((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))(SUCCESSOR (SUCCESSOR ZERO)))
;     2. ==[ expanded ]==> (((^m.(^n.(^f.(m (n f)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^m.(^n.(^f.(m (n f)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))
;     2. ==[ alpha    ]==> (((^x.(^y.(^z.(x (y z)))))((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))))
;     3. ==[ beta     ]==> ((^y.(^z.(((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1))))(y z))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))))
;     4. ==[ alpha    ]==> ((^x.(^y.(((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))))(x y))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))))
;     5. ==[ beta     ]==> (^y.(((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) y)))
;     6. ==[ alpha    ]==> (^x.(((^y.(^z.(^u.(z ((y z) u)))))((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)))
;     7. ==[ beta     ]==> (^x.((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u))))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)))
;     8. ==[ alpha    ]==> (^x.((^y.(^z.(y ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) y) z))))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)))
;     9. ==[ beta     ]==> (^x.(^z.((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) z))))
;    10. ==[ alpha    ]==> (^x.(^y.((((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))) x)((((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))(((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))((^x2.(^y2.(^z2.(y2 ((x2 y2) z2)))))(^u2.(^v2.v2)))) x)) y))))
;    11. ==[ beta     ]==> (^x.(^y.(((^u.(^v.(u ((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))) u) v)))) x)((((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))(((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))((^x2.(^y2.(^z2.(y2 ((x2 y2) z2)))))(^u2.(^v2.v2)))) x)) y))))
;    12. ==[ alpha    ]==> (^x.(^y.(((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u)))) x)((((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))(((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))((^r1.(^x2.(^y2.(x2 ((r1 x2) y2)))))(^z2.(^u2.u2)))) x)) y))))
;    13. ==[ beta     ]==> (^x.(^y.((^u.(x ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) x) u)))((((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))(((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))((^r1.(^x2.(^y2.(x2 ((r1 x2) y2)))))(^z2.(^u2.u2)))) x)) y))))
;    14. ==[ alpha    ]==> (^x.(^y.((^z.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x) z)))((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y))))
;    15. ==[ beta     ]==> (^x.(^y.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x)((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y)))))
;    16. ==[ alpha    ]==> (^x.(^y.(x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x)((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y)))))
;    17. ==[ beta     ]==> (^x.(^y.(x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x)((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y)))))
;    18. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x)((((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y)))))
;    19. ==[ beta     ]==> (^x.(^y.(x ((^u.(x (((^v.(^w.w)) x) u)))((((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y)))))
;    20. ==[ alpha    ]==> (^x.(^y.(x ((^z.(x (((^u.(^v.v)) x) z)))((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y)))))
;    21. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.v)) x)((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y))))))
;    22. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.u)) x)((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r)))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y))))))
;    23. ==[ beta     ]==> (^x.(^y.(x (x ((^u.u)((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r)))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y))))))
;    24. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.z)((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y))))))
;    25. ==[ beta     ]==> (^x.(^y.(x (x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))
;    26. ==[ alpha    ]==> (^x.(^y.(x (x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p)))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))
;    27. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.(u (((^w.(^p.p)) u) v))))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))
;    28. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.(z (((^v.(^w.w)) z) u))))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y)))))
;    29. ==[ beta     ]==> (^x.(^y.(x (x ((^u.((((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) u))) y)))))
;    30. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.((((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))) x)(((^z1.(^u1.u1))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) z))) y)))))
;    31. ==[ beta     ]==> (^x.(^y.(x (x ((((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))) x)(((^z1.(^u1.u1))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y))))))
;    32. ==[ alpha    ]==> (^x.(^y.(x (x ((((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))) x)(((^y1.(^z1.z1))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y))))))
;    33. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.(u ((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))) u) v)))) x)(((^y1.(^z1.z1))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y))))))
;    34. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u)))) x)(((^x1.(^y1.y1))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y))))))
;    35. ==[ beta     ]==> (^x.(^y.(x (x ((^u.(x ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) x) u)))(((^x1.(^y1.y1))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y))))))
;    36. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x) z)))(((^r.(^x1.x1))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y))))))
;    37. ==[ beta     ]==> (^x.(^y.(x (x (x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x)(((^r.(^x1.x1))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y)))))))
;    38. ==[ alpha    ]==> (^x.(^y.(x (x (x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x)(((^q.(^r.r))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y)))))))
;    39. ==[ beta     ]==> (^x.(^y.(x (x (x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x)(((^q.(^r.r))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y)))))))
;    40. ==[ alpha    ]==> (^x.(^y.(x (x (x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x)(((^p.(^q.q))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))))
;    41. ==[ beta     ]==> (^x.(^y.(x (x (x ((^u.(x (((^v.(^w.w)) x) u)))(((^p.(^q.q))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))))
;    42. ==[ alpha    ]==> (^x.(^y.(x (x (x ((^z.(x (((^u.(^v.v)) x) z)))(((^w.(^p.p))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))))
;    43. ==[ beta     ]==> (^x.(^y.(x (x (x (x (((^u.(^v.v)) x)(((^w.(^p.p))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y))))))))
;    44. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (((^z.(^u.u)) x)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y))))))))
;    45. ==[ beta     ]==> (^x.(^y.(x (x (x (x ((^u.u)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y))))))))
;    46. ==[ alpha    ]==> (^x.(^y.(x (x (x (x ((^z.z)(((^u.(^v.v))(((^w.(^p.(^q.(p ((w p) q)))))((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))) x)) y))))))))
;    47. ==[ beta     ]==> (^x.(^y.(x (x (x (x (((^u.(^v.v))(((^w.(^p.(^q.(p ((w p) q)))))((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))) x)) y)))))))
;    48. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (((^z.(^u.u))(((^v.(^w.(^p.(w ((v w) p)))))((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))) x)) y)))))))
;    49. ==[ beta     ]==> (^x.(^y.(x (x (x (x ((^u.u) y)))))))
;    50. ==[ alpha    ]==> (^x.(^y.(x (x (x (x ((^z.z) y)))))))
;    51. ==[ beta     ]==> (^x.(^y.(x (x (x (x y))))))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf PREDECESSOR '(^ n . (((n (^ p . (^ z . ((z (SUCCESSOR (p TRUE)))
                                              (p TRUE)))))
                             (^ z . ((z ZERO) ZERO)))
                           FALSE)))

    (expand-and-reduce^ '(PREDECESSOR ONE)
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (PREDECESSOR ONE)
;
;     1. ==[ original ]==> (PREDECESSOR ONE)
;     2. ==[ expanded ]==> ((^n.(((n (^p.(^z.((z (SUCCESSOR (p TRUE)))(p TRUE)))))(^z.((z ZERO) ZERO))) FALSE))(^x.x))
;     3. ==[ expanded ]==> ((^n.(((n (^p.(^z.((z ((^n.(^f.(^x.(f ((n f) x)))))(p (^x.(^y.x)))))(p (^x.(^y.x)))))))(^z.((z (^f.(^x.x)))(^f.(^x.x)))))(^x.(^y.y))))(^x.x))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(((n (^p.(^z.((z ((^n.(^f.(^x.(f ((n f) x)))))(p (^x.(^y.x)))))(p (^x.(^y.x)))))))(^z.((z (^f.(^x.x)))(^f.(^x.x)))))(^x.(^y.y))))(^x.x))
;     2. ==[ alpha    ]==> ((^x.(((x (^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1))))(^r1.r1))
;     3. ==[ beta     ]==> ((((^r1.r1)(^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     4. ==[ alpha    ]==> ((((^x.x)(^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     5. ==[ beta     ]==> (((^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     6. ==[ alpha    ]==> (((^x.(^y.((y ((^z.(^u.(^v.(u ((z u) v)))))(x (^w.(^p.w)))))(x (^q.(^r.q))))))(^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1)))))(^w1.(^p1.p1)))
;     7. ==[ beta     ]==> ((^y.((y ((^z.(^u.(^v.(u ((z u) v)))))((^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1))))(^w.(^p.w)))))((^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1))))(^q.(^r.q)))))(^w1.(^p1.p1)))
;     8. ==[ alpha    ]==> ((^x.((x ((^y.(^z.(^u.(z ((y z) u)))))((^v.((v (^w.(^p.p)))(^q.(^r.r))))(^x1.(^y1.x1)))))((^z1.((z1 (^u1.(^v1.v1)))(^w1.(^p1.p1))))(^q1.(^r1.q1)))))(^x2.(^y2.y2)))
;     9. ==[ beta     ]==> (((^x2.(^y2.y2))((^y.(^z.(^u.(z ((y z) u)))))((^v.((v (^w.(^p.p)))(^q.(^r.r))))(^x1.(^y1.x1)))))((^z1.((z1 (^u1.(^v1.v1)))(^w1.(^p1.p1))))(^q1.(^r1.q1))))
;    10. ==[ alpha    ]==> (((^x.(^y.y))((^z.(^u.(^v.(u ((z u) v)))))((^w.((w (^p.(^q.q)))(^r.(^x1.x1))))(^y1.(^z1.y1)))))((^u1.((u1 (^v1.(^w1.w1)))(^p1.(^q1.q1))))(^r1.(^x2.r1))))
;    11. ==[ beta     ]==> ((^y.y)((^u1.((u1 (^v1.(^w1.w1)))(^p1.(^q1.q1))))(^r1.(^x2.r1))))
;    12. ==[ alpha    ]==> ((^x.x)((^y.((y (^z.(^u.u)))(^v.(^w.w))))(^p.(^q.p))))
;    13. ==[ beta     ]==> ((^y.((y (^z.(^u.u)))(^v.(^w.w))))(^p.(^q.p)))
;    14. ==[ alpha    ]==> ((^x.((x (^y.(^z.z)))(^u.(^v.v))))(^w.(^p.w)))
;    15. ==[ beta     ]==> (((^w.(^p.w))(^y.(^z.z)))(^u.(^v.v)))
;    16. ==[ alpha    ]==> (((^x.(^y.x))(^z.(^u.u)))(^v.(^w.w)))
;    17. ==[ beta     ]==> ((^y.(^z.(^u.u)))(^v.(^w.w)))
;    18. ==[ alpha    ]==> ((^x.(^y.(^z.z)))(^u.(^v.v)))
;    19. ==[ beta     ]==> (^y.(^z.z))
;    20. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf FACTORIAL '(Y (^ f . (^ n .((((IF ZERO?) n) ONE)
                                   ((MULTIPLY n) (f (PREDECESSOR n))))))))

  (expand-and-reduce^ '(FACTORIAL (SUCCESSOR (SUCCESSOR ONE)))
                       5000
                       true)
;---------------------------------------------------------------
;
; Roughly ten minutes and 100000 of lines later, on my computer
;
; ...
;
; 2379. ==[ beta     ]==> (^x.(^y.(x (x (x (x (x (x ((^u.u) y)))))))))
; 2380. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (x (x ((^z.z) y)))))))))
; 2381. ==[ beta     ]==> (^x.(^y.(x (x (x (x (x (x y))))))))
;
;       REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
;                        EVERYTHING WORKS!

(exit)


--------------------------------------------------------------
Lambda Calculus Meta-variables Supported in my Newlisp Library
--------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/02/lambda-calculus-metavariables-supported.html

Lambda calculus is very small and still "Turing complete" language. However, because of its simplicity and small size, it is very hard to write real programs - even harder than in assembly language. Most of the materials demonstrating programming in lambda calculus> use meta-variables. For instance, TRUE is defined as

'(^ x .(^ y . x))),

and after that, TRUE is used instead of given expression. If such meta-variables are used, lambda-expressions are much shorter and more readable, however, there is no essential difference, since before reduction, all meta-variables are "expanded" into real lambda-expressions.

I already implemented support for reduction of lambda expressions in my Newlisp library. The code that deals with meta-variables is rather simple. It is  just recursive substitution of meta-variable's value for meta-variable itself.

You can see how it works in my previous post "Some Basic Concepts Implemented and Reduced in Lambda-calculus", now updated.


-----------------
Parallel "Expand"
-----------------
http://kazimirmajorinc.blogspot.com/2011/04/parallel-expand.html

Almost all Lisp dialects support both "parallel" and "serial" assignment operators like let and letn in Newlisp. For example

    (setf y 1)
    (let((y 2)(x y)) x)  ==> 1   (parallel)

but

   (setf y 1)
   (letn((y 2)(x y)) x)  ==> 2   (serial)

Expand-expression in Newlisp

   (expand '(x y) 'x 'y)

results in replacement of x and y in (x y) with values of x and y. Expand-expression in other form:

   (expand '(x y) ((x <value1>)(y <value2>)))

results in replacement of x and y in (x y) with <value1> and  <value2>.

In both cases, the replacement is performed in serial fashion. For  example,

   (expand '(x y) '((x y)(y 3))) ==> (3 3)

In this post I present the implementation of parallel expand,  expand// in Newlisp; two slashes in name remind on parallel lines such that, for instance

   (expand// '(x y) '((x y)(y 3))) ==> (y 3).

Parallel expand expression can be reduced to serial expand with introduction of new variables.

  (expand// <expr> '((<var1> <val1>)...(<varn> <valn>))) =

  (expand <expr> '((<var1>   expand//1) ... (<varn>   expand//<n>)
                   (expand//1 <val1>  ) ... (expand//n <valn>)))

Fexpr expand// can use always the same temporary variables expand//1, ..., expand//n, without need for generating fresh variables each time expand// is called. Other form of expand//,

  (expand// <expr> '<var0> ... '<varn>)

can be reduced on form

  (expand <expr>
         '((<var0>   expand//0) ...        (<varn> expand//<n>)
           (expand//0 <value of var0>) ... (expand//<n> <value of var<n>>))).

Using that idea, the implementation is not very technical

(define (expand// expr)
  (letn((a (args))
        (expand//sym (lambda(n)(sym (append "expand//" (string n)))))
        (expandlist

    (if (empty? a)
        (throw-error "expand//: arguments missing.")

        (cond ((symbol? (first a))
               (append (map (lambda(i)(list i (expand//sym $idx))) a)
                       (map (lambda(i)(list (expand//sym $idx) (eval i))) a)))

              ((list? (first a))
               (append (map (lambda(i)(list (i 0) (expand//sym $idx))) (first a))
                       (map (lambda(i)(list (expand//sym $idx) (i 1))) (first a))))))))


       (println "expandlist=" expandlist)
       (expand expr expandlist)))

(setf x 'y)
(setf y 3)
(println (expand '(x y) 'x 'y))           ; => (3 3)
(println (expand// '(x y) 'x 'y))         ; => (y 3)
(println (expand '(x y) '((x y)(y 3))))   ; => (3 3)
(println (expand// '(x y) '((x y)(y 3)))) ; => (y 3)

(exit)


------------------------------------------------------
Conflation of Subtraction and Additive Inverse in Lisp
------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/05/conflation-of-subtraction-and-additive.html

In mathematics, the symbol - is used as name of two different operations: subtraction and additive inverse. For instance, that symbol has different meaning in the expressions (-3)+7 and (6-3)+7. There is no ambiguity. The edge case of subtraction

c - b1 - b2 - ... - bn

for n = 0, i.e. subtraction with zero subtrahends, is c, which is clearly different than additive inverse of c: - c. However, in prefix notation use of the same symbol for two different operators will cause ambiguity so (- c) can be interpreted as both additive inverse of c and the edge case of subtraction with zero subtrahends. Designers of almost all Lisp dialects have chosen to keep the same symbol and implement both operations. The decision is based on the number of operands: if there is only one operand, operator - behaves as additive inverse; if there is two or more operands - behaves as subtraction.

This decision rarely causes any problems with "hand written" expressions because humans automatically, without much thinking, reduce edge case of subtraction to minuend, so, we'll not see the edge case of subtraction in any mathematical formulas. However, if expressions are processed by programs the reduction of the edge case doesn't happen automatically. For instance, the program that simplifies arithmetic expression could contain the function that deletes zeroes from subtrahends. That function should accept expression as

(- c b1 0 b2 0 0 0)

as argument and return expression

(- c b1 b2).

However, simple implementation like this one in Newlisp
(define (simplify E)
  (let ((operator (first E))
        (minuend (first (rest E)))
        (subtrahends (rest (rest E))))
       (setf new-subtrahends (clean zero? subtrahends))
       (append (list operator)
               (list minuend)
               new-subtrahends)))

will not work correctly, because, for instance, (- 3 0) will be reduced into (- 3) and these two expressions have not the same value. Explicit treatment of the edge case is required:

(define (simplify E)
  (let ((operator (first E))
        (minuend (first (rest E)))
        (subtrahends (rest (rest E))))
       (setf new-subtrahends (clean zero? subtrahends))
       (if (empty? new-subtrahends)
           minuend
           (append (list operator)
                   (list minuend)
                   new-subtrahends))))

The second definition is significantly (~ 15%) larger and less consistent: one can get rid of subtrahends equal to zero only if he removes whole subtraction. On the other hand, edge cases for some other operations like addition are well supported in all Lisp dialects: not only that (+ a 0) can be safely simplified to (+ a), but even (+ 0 0) can be simplified to (+).

Hence, merging of the two operators into one could be design mistake. It would be, arguably, better to
define new operator for additive inverse and
extend definition of subtraction on special case with zero subtrahends.
Of course, S-expressions would look even less similar to arithmetic expressions, however, clarity and consistency over convenience is, I think, the element of the philosophy of Lisp.

It is even more surprising that this merging is generalized: division operator, / which is not used as divisional inverse in mathematical expressions is used on the way analogous to - in almost all Lisp dialects.

It is hard to expect change in existing Lisp dialects because lot of existing code uses "conflated operator", although I think that such changes should be, gradually, done: the past is finite and future is infinite. However, I think that for future Lisp dialects it would be better to keep the difference between subtraction (division) and additive (multiplicative) inverse.


-------
Tangent
-------
http://kazimirmajorinc.blogspot.com/2011/05/tangent.html


The specificity of Lisp is, maybe, best visible on problems that require processing of data naturally represented as S-expressions. An example of such problem is "Probability that random propositional formula is tautology." In this post, the variation of classical example - symbolic differentiation - is presented: newLISP (and it is very similar in other Lisps) program that computes the tangent of the graph of the function f of single variable, defined as composition of elementary functions (+, -, sin, cos ...) in given point x0. The tangent of the function f in x0 is defined as linear function

y(x) = a·(x - x0) + b,

where a = f '(x0) and b = f(x0). The program consists of:

The function tangent that accepts two arguments: the function f in form of lambda list and the floating point number x0. The function tangent analyzes the code of the function f, calculates the values a and b according to mathematical definition of tangent (see above) and constructs the code of the function

(lambda(x)(+. (*. a (-. x x0)) b))

where symbols a, b and x0 are replaced with their respective values; that function is then returned as result of the function tangent. The implementation is very short, but it delegates main part of the work to the function d.
The function d accepts two arguments: formula and variable. It returns the expression obtained by symbolic differentiation of the formula for given variable. It is main function in this program, typical recursive "code walking" through formula. Simple "domain specific language" is used for descriptions of the rules  for symbolic differentiation that should be applied, for example

(+. (*. df g) (*. f dg))

for multiplication. The application of  rules for symbolic differentiation frequently give result that can be simplified. For instance, derivation of (*. 2 x) is

(+. (*. 0 x) (*. 2 1))

so function simplify is called when appropriate.
The function simplify accepts only one argument: symbolic expression formula. It analyzes and simplify formula, again, using typical recursive "code walking". For instance, S-expression (- x x) is simplified to 0. There are infinitely many possible rules for simplification; the function performs only few of these. The function uses eval at one place: if some expression contains only operators and constants, but not variables then the easisest way to simplify it is to eval it. (One might speculate that simplify is generalized eval.) Simplification is, actually, not necessary for computation of the tangent. However, its use in the context of symbolic differentiation is reasonable.
Few operators from my library are used; function expand// i.e. parallel expand, fexpr println= for convenient printing and floating point arithmetic operators +., -., *. and /., synonymous for built-in add, sub, mul and div. These functions are not essential.

The graph of the complicated function and tangent on the curve suggests that program, generally, works.

(setf f0 (lambda(x)
           (+. (sin (*. 12 x))
               (cos (*. 32 x))
               (tan (*. x 1.4))
               (asin x)
               (acos  x)
               (atan x)
               (*. x (cos (/. 7 x)))
               (sqrt (/. 9 x))
               (pow x x)
               (*. x (sinh x))
               (*. x (cosh x))
               (asinh x)
               (sin (acosh (+. x 1)))
               (atanh x))))
(setf x0 0.4)
(println= (tangent f0 x0))
; (tangent f0 x0)=(lambda (x) (+. (*. -21.491 (-. x 0.4)) 10.252))

Note: vedi immagine "tangent.png" nella cartella "data".

Finally, the code:
(setf [print.supressed] true [println.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(setf [print.supressed] nil [println.supressed] nil)

(define (tangent f x0)
   (letn((variable           (first (first f)))
         (expression         (last f))
         (derived-expression (d expression variable))

         (a                  (eval (expand derived-expression
                                           (list (list variable x0)))))
         (b                  (f x0)))

       (expand// '(lambda(x)(+. (*. a (-. x x0)) b))
                  'a 'b 'x0)))

(define (d formula variable)
  (simplify
    (cond
      ((= formula variable) 1)
      ((atom? formula) 0)
      ((list? formula)
       (letn((operator (first formula))
             (operands (rest formula))
             (lexpand
               (lambda(expr)
                 (letn((flatexpr (flat expr))
                       (f  (if (find 'f  flatexpr)(operands 0)))
                       (df (if (find 'df flatexpr)(d f variable)))
                       (g  (if (find 'g  flatexpr)(operands 1)))
                       (dg (if (find 'dg flatexpr)(d g variable))))
                   (expand// expr 'f 'df 'g 'dg)))))

         (case operator

           (+. (cons '+. (map (lambda(op)(d op variable)) operands)))
           (-. (cons '-. (map (lambda(op)(d op variable)) operands)))

           (*. (case (length operands)
                 (1    (lexpand 'df))
                 (2    (lexpand '(+. (*. df g) (*. f dg))))
                 (true (d (list '*. (first operands)
                                    (cons '*. (rest operands)))
                           variable))))

           (/. (case (length operands)
                 (1    (d (list '/. 1 (first operands)) variable))
                 (2    (lexpand '(/. (-. (*. df g) (*. f dg)) (*. g g))))
                 (true (d (list '/.  (first operands)
                                     (cons '*. (rest operands)))
                       variable))))

           (pow (d (lexpand '(exp (*. g (log f)))) variable))
           (exp (lexpand '(*. f df)))
           (log (if (= (length operands) 1)
                    (lexpand '(/. df f))
                    (d (lexpand '(/. (log f) (log g))) variable)))

           (sqrt  (lexpand '(*. 0.5 df (/. 1 (sqrt f)))))
           (sin   (lexpand '(*. (cos f) df)))
           (cos   (lexpand '(*. (-. (sin f)) df)))
           (tan   (lexpand '(/. df (pow (cos f) 2))))
            (asin (lexpand '(/. df (sqrt (-. 1 (*. f f))))))
           (acos  (lexpand '(-. (/. df (sqrt (-. 1 (*. f f)))))))
           (atan  (lexpand '(/. df (+. 1 (*. f f)))))
           (sinh  (lexpand '(*. (cosh f) df)))
           (cosh  (lexpand '(*. (sinh f) df)))
           (tanh  (lexpand '(*. (-. 1 (pow (tanh f) 2)) df)))
           (asinh (lexpand '(/. df (sqrt (+.(*. f f) 1)))))
           (acosh (lexpand '(/. df (sqrt (-. (*. f f) 1)))))
           (atanh (lexpand '(/. df (-. 1 (*. f f)))))

           ))))))

(define (simplify formula)
  (cond
    ((atom? formula) formula)
    ((list? formula)
     (letn((operator (first formula))
           (operands (map simplify (rest formula)))
           (formula (cons operator operands)))

       (cond

         ; if all operands are constants, then
         ; simplified formula is evaluated formula

         ((for-all number? operands)(eval formula))

         ; (*. x), (+. x) => x

         ((and (or (= operator '*.) (= operator '+.))
               (= (length operands) 1))
           (first operands))

         ; (*. ... 0 ...) => 0

         ((and (= operator '*.) (find 0 operands)) 0)

         ; (*. ... 1 ...) => (*. ...)

         ((and (= operator '*.) (find 1 operands))
          (simplify (clean (curry = 1) formula)))

         ; (+. ... 0 ...) => 0

         ((and (= operator '+.) (find 0 operands))
          (simplify (clean zero? formula)))

         ; (-. (-. ...)) => ...

         ((match '(-. (-. ?)) formula)
           (last (last formula)))

         ; (-. minuend ...)

         ((and (= operator '-.) (> (length operands) 1))

          (letn((minuend (first operands))
                (subtrahends (rest operands))
                (subtrahend  (simplify (cons '+. subtrahends))))

            (cond ((zero? minuend)        (simplify (list '-.
                                                          subtrahend)))
                  ((zero? subtrahend)     minuend)
                  ((= minuend subtrahend) 0)
                  (true                   (list '-. minuend
                                                    subtrahend)))))

         ; (/. (/. ...))

         ((match '(/. (/. ?)) formula) (last (last formula)))

         ; (/. dividend ...)

         ((and (= operator '/.) (> (length operands) 1))
          (letn((dividend (first operands))
                (divisors (rest operands))
                (divisor  (simplify (cons '*. divisors))))

            (cond ((zero? dividend)     0)
                  ((= divisor 1)        dividend)
                  ((= divisor -1)       (simplify (list '-. dividend)))
                  ((= dividend divisor) 1)
                  (true                 (list '/. dividend divisor)))))

         (true formula))))))


---------------------------------------------------
More Sophisticated Encoding of S-exprs into Symbols
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/more-sophisticated-encoding-of-s-exprs.html

Encoding of S-expressions into symbols is frequent topic of discussion in this blog. It is motivated by the idea that names should be equally flexible as S-expressions. (Actually, it might be the best if not only every symbol is S-expression, but also every S-expression is the symbol. OK, it is almost mystical statement.)

Trivial encoding was demonstrated in last post: S-expression is encoded in symbol which has exactly same characters as printed representation of S-expression. For instance, S-expression (+ a b) is encoded into symbol (+ a b). This trivial encoding has some limitations. For instance, if we look at symbol

((+ a b) c)

and try to decode it, we'll find that it cannot be determined whether (+ a b) is S-expression, or it is symbol. In some Lisp dialects (Common Lisp, Picolisp, ISLisp) there is no such problem. Symbol (+ a b) is written as |(+ a b)| so difference between S-expression and symbol is obvious. However, in these dialects, repeated encoding results in the symbols that grow exponentially.

In this post more sophisticated encoding, without that problem, is presented. Let us define encoding k, such that for every S-expression e, k(e) is defined as follows.
If e is symbol, then k(e) = e;
if e = (e1 ... en) then k(e) = [k(e1) k(e2) ... k(en)];
Semi-colon is part of the symbol. For instance

k(a) = a;
k((a b)) = [k(a) k(b)]; = [a;b;];

If only codes of the S-expressions contain characters [, ] and ;, then encoding k is injection, i.e. for two S-expressions e and f,

k( e ) = k( f ) => e = f.

Furthermore, there is no exponential explosion in case of multiple encoding. For instance,

k((a b)) = [a;b;];
k(k((a b))) = [a;b;];;
k(k(k((a b)))) = [a;b];;;

Here is implementation of encoding and decoding in R5RS Scheme.
(define (sexpr->string L)
  (string-append
     (if (symbol? L) (symbol->string L)
                     (string-append
                        "["
                        (apply string-append
                               (map sexpr->string L))
                        "]"))
     ";"))

(define (sexpr->symbol L)
  (string->symbol (sexpr->string L)))

(define (string->sexpr S)
  (let((S1 (substring S 0 (- (string-length S) 1))))
    (if (equal? (string-ref  S1 (- (string-length S1) 1)) #\])
      (let((substring-begin 1)
           (level 0)
           (result (list)))
        (do ((i 1 (+ i 1)))
            ((= i (string-length S1)) result)
          (if (and (= level 0)
                   (equal? (string-ref S1 i) #\;)
                   (not (equal? (string-ref S1 (+ i 1)) #\;)))
            (begin
              (set! result
                    (append result
                            (list (string->sexpr
                                    (substring S1
                                               substring-begin
                                               (+ i 1))))))
              (set! substring-begin (+ i 1))))
          (cond ((equal? (string-ref S1 i) #\[)
                 (set! level (+ level 1)))
                ((equal? (string-ref S1 i) #\])
                 (set! level (- level 1))))))
      (string->symbol (substring S 0 (- (string-length S) 1))))))

(define (symbol->sexpr s)
  (string->sexpr (symbol->string s)))

-------------------------

> (sexpr->symbol (quote (a b)))
|[a;b;];|
> (define s2 (sexpr->symbol (quote (|[a;b;];| c))))
> s2
|[[a;b;];;c;];|
> (symbol->sexpr s2)
(|[a;b;];| c)


--------------------------------------------
Another Encoding of S-expressions in Symbols
--------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/another-encoding-of-s-expressions-in.html

Unlike encoding from the last post, this one maintains form of S-expression. If e is S-expression, then its code is symbol (Q e).

Encoding is relatively simple, because built in functions for conversion of symbols and strings into symbols can be used; especially if symbols converted to strings are not encapsulated within vertical bars or quotation marks. Decoding is slightly more complicated. For instance, symbol

(Q (a (Q b)))

should be decoded into list (a (Q b)) where (Q b) isn't list, but symbol. Hence, built in conversion functions are not enough, but one must define his own "code walker." The code in Newlisp follows.

(define (sexpr->symbol r) (sym (string (list (quote Q) r))))

(define (qlist? r)
    (and (list? r)
         (not (empty? r))
         (= (first r) (quote Q))))

(define (symbol->sexpr r)
  (let((codewalker
         (lambda(r)
           (cond ((symbol? r) r)
                 ((qlist? r) (sym (string r)))
                 ((not (qlist? r)) (map codewalker r))))))
     (codewalker (last (read-expr (string r))))))

--------

> (setq s (sexpr->symbol (quote (a b))))
(Q (a b))
> (symbol? s)
true
> (setq q0 (sexpr->symbol (quote b)))
(Q b)
> (setq s (sexpr->symbol (list (quote a) q0)))
(Q (a (Q b)))
> (symbol? s)
true
> (setq s0 (symbol->sexpr s))
(a (Q b))
> (symbol? s0)
nil
> (symbol? (last s0))
true

Behaviour of Q strongly reminds on QUOTE.


----------------------------------------------------
More on Another Encoding of S-expressions in Symbols
----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/more-on-another-encoding-of-s.html

In previous post, I have shown another interesting method for encoding of S-expressions into symbols. In this post, I'll show how it can be implemented in Lisp dialects that print symbols on different way from S-expressions, i.e. encapsulated in vertical bars or other symbols (Common Lisp, ISLisp, Picolisp, some implementations of Scheme). This is, normally, good feature. However, repeated encoding of the symbols results in exponential growth. So, we must get rid of those vertical bars inside our symbols.

The code, here in Common Lisp, is sort of trickier than it is in Newlisp or it would be in Clojure.
(defun decode-deep (r)
  (cond ((symbolp r) (let((result (read-from-string (string r))))
                        (if (symbolp result)
                            result
                            (decode-deep result))))
        ((listp r) (mapcar (quote decode-deep) r))))

(defun sexpr->symbol (r)
  (make-symbol (write-to-string (list 'q (decode-deep r)))))

(defun encode-deep (r)
  (cond ((symbolp r) r)
        ((listp r)(if (eq (first r) (quote q))
                      (make-symbol (write-to-string r))
                      (mapcar (quote encode-deep) r)))))

(defun strip-q (r) (first (rest r)))

(defun symbol->sexpr (r)
  (encode-deep (strip-q (read-from-string (string r)))))

-------------

[43]> (setq q0 (sexpr->symbol (list (quote b) (quote c))))
#:|(Q (B C))|
[44]> (setq s (sexpr->symbol (list (quote a) q0)))
#:|(Q (A (Q (B C))))|
[45]> (setq s0 (symbol->sexpr s))
(A #:|(Q (B C))|)


-----------------------------------------
Implementing Data Structures with Symbols
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/implementing-data-structures-with.html

Original Lisp had only symbols as atoms. Symbol names, if used on the same way variables are used in mathematics, are flexible enough to support wide variety (all?) data structures.

For instance, matrices 2 x 2 can be implemented with symbols as a11 instead of a[1,1] in some other language, or (a 1 1) in Lisp and names could be created as needed.

The code will be more complicated and less efficient than if matrices are directly supported by language, but neither one is essential problem - complexity of the code can be "abstracted away" with functions, and computational complexity is increased only for factor of constant * log n where n is the number of used symbols (if symbol reaching in Lisp is implemented efficiently.) Newlisp code follows.

(define (matrix-element m i j)
  (sym (append (string m) (string i) (string j))))

(define (set-matrix m m11 m12 m21 m22)
  (for(i 1 2)
    (for(j 1 2)
      (set (matrix-element m i j)
           (nth (+ (* 2 (- i 1)) (- j 1))
                (list m11 m12 m21 m22))))))

(define (println-matrix m)
  (for(i 1 2)
    (for(j 1 2)
       (println m "[" i "," j "]="
          (eval (matrix-element m i j))))))

(define (multiply-matrix a b c)
  (for(i 1 2)
    (for(j 1 2)
      (set (matrix-element c i j) 0)
      (for(k 1 2)
         (set (matrix-element c i j)
              (+ (eval (matrix-element c i j))
                 (* (eval (matrix-element a i k))
                    (eval (matrix-element b k j)))))))))

(set-matrix (quote X) 1 2 3 4)
(set-matrix (quote Y) 2 3 4 5)
(multiply-matrix (quote X) (quote Y) (quote Z))
(println-matrix (quote Z))

---------------------------
Program output

Z[1,1]=10
Z[1,2]=13
Z[2,1]=22
Z[2,2]=29

Commenti:
---------
*** Anonymous 20 November 2011 at 14:52
Erlang, which derives its basic syntax directly from Prolog, uses syms exactly like that, as meaningful entities, which in other langs would be implemented with vars, or strings.

E.g. messages between erlang processes are passed as symbols.

I do not see why meaningful syms cannot be used in other languages, too.

You are perfectly right.

*** Anonymous 21 November 2011 at 11:14
I could probably tell even more:
Erlang uses syms as meaningful semantic entities not only because it follows tradition from Prolog (in 'logical_programming' it's kind of natural to have syms stand for words, as it basically manipulates 'predicates'). Syms are naturally immutable, created once and never changed, and in Erlang it serves a purpose, eliminating potential conflicts in parallel distributed computing - no chance that the same var gets assigned to in different places dragging into the pot all kinds of race conditions and need for locks.

In Newlisp which allows sending serialized content to remote instances for remote evaluation, it may make full sense too - when Newlisp uses Erlang-like programming.
Now with 'messaging' btw parent and child added, this interesting way to architect programs becomes available to Newlisp too, and who knows, messaging with lists of syms (instead of lists of vars or lists of constant strings) might make sense.

Basically, syms with meaningful names are just one more kind of entities, and whether and how to use them depends probably on how convenient they are to manipulate - with the bulit-in means a given language provides.
(i.e. how easy it is to match them, compare on their names - or whether one would need to cast syms into strings to do recognition and manipulation etc. etc.)

But inherent immutability is one more reason to view syms as more than named placeholders for values, as vars do.

p.s. i am 'unixtechie' at newlisp forum. i post anonymously because i dislike the idea that my wanderings around the Net should be easily tracked by god knows whom, for god knows what purposes, and forever.
So i just did not enter my auth credentials when posted my first comment


-----------------------------------------
Three meanings of the term 'S-expression'
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2011/08/three-meanings-of-term-s-expression.html

"Symbolic expressions" or "S-expressions" are the basic data type in Lisp. Particularly, Lisp programs are S-expressions as well. The notion has immense importance in Lisp community.

Surprisingly, designers of recent Lisp dialects avoid the term "symbolic expression" or "S-expression". It is used once in Picolisp documentation; only twice, almost accidentally, in CLtL2, and it isn't used in CL Hyperspec or recent Scheme standards. Clojure, according to its web site "extends the code-as-data system beyond parenthesized lists (s-expressions) to vectors and maps." Only Newlisp documentation appear to regularly uses the term.

However, the term S-expression is still extensively used in daily communication and literature. Unfortunately, there is no universal, unique meaning. Inconsistent use is sometimes noted; for instance, in P. Siebel's "Practical Common Lisp." More frequently, it is ignored.

For J. McCarthy, S-expression is finite sequence consisting of dots and parentheses and symbols. The symbols, truly atomic, cannot be analysed on characters. For instance, S-expression (left.right) is sequence of five elements: (, left, ., right and ).

More often1, S-expression is seen as sequence of characters. In that meaning, S-expression (left . right) is sequence consisting of 14 elements.

The most usually2, S-expression is data structure, perhaps tree consisting of cons cells and symbols. In that meaning S-expression (left . right) is cons cell, containing adresses of symbols left and right in memory.

1  For instance, in E. Shaphiro, "Common Lisp - an interactive approach"; F. Turbak and D. Gifford, "Design concept of programming languages."

2  For instance, in J. and G. Sussman and H. Abelson, "SICP"; D. Touretsky, "Common Lisp - A gentle introduction to symbolic computation"; R. Finkel, "Advanced programming languages design".


------------------------------------------------------------------------------
The Similarities Between Axioms of Natural Numbers and Axioms of S-expressions
------------------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/08/similarities-between-axioms-of-natural.html

In last post, it was shown that in Lisp practice, the term "symbolic expression", shorter "s-expression", "sepxr", "sexp" is used on few different, although similar meanings.
It is not unusual. Other terms, even mathematical ones, like "lines" or "numbers" are not uniquely defined as well. Ambiguity usually motivates the search for the essence of the discussed entities; the result of the search is axiomatic theory. For example, the axioms of natural numbers are developed in late 1880's by R. Dedekind and G. Peano.
Axioms of Natural Numbers
-------------------------
There is a set N ("numbers"), distinctive element of the N denoted with 1 ("base", "initial number") and mapping
  successor: N → N
such that

1. all numbers, except 1, are successors of some numbers, i.e.
{ successor(n) | n ∈ N } = N \ {1};

2. the successor function is injection, or
successor(n) = successor(m) => n = m;

3. if S is a set of numbers such that
   i. S contains all initial numbers (i.e. 1);
  ii. if S contains n, then S contains successor(n);
then S contains all numbers.

Search for axioms of symbolic expressions might be equally justified. I designed following axioms (version in which lists are only shorter way of writing "dotted pairs") to emphasize the similarities to axioms of natural numbers.

Axioms of Symbolic Expressions
------------------------------
There is a set SEXPR ("symbolic expressions"), infinite set of distinct elements of the SEXPR denoted with A ("atoms") and mapping
cons: SEXPR × SEXPR → SEXPR
such that
1. all symbolic expressions, except atoms, are conses, i.e.
{ cons(x, y) | x, y ∈ SEXPR } = SEXPR \ A;

2. the function cons is injection, i.e.
cons(n, p) = cons(m, q) => n = m and p = q;

3. if S is a set of symbolic expressions such that
   i. S contains all atoms;
  ii. if S contains n and p then S contains cons(n, p);
then S contains all symbolic expressions.

Symbolic expressions in all three meanings satisfy the axioms; cons structures satisfy axiom (3) only if cyclic structures are not allowed, like in original, McCarthy's Lisp. I'm not aware of unintended, perverse models that satisfy given axioms; but I am not sure that such models do not exist.

There are only two differences between these axiom systems.

1. There is one "base element" for numbers and infinitely many for S-expressions.

2. The function "successor" is function of a single variable; the function "cons" is function of two variables.

It is not obvious that symbolic expressions require infinitely many atoms; it could be only convenience. Perhaps S-expressions like (A . (B . (C . D))) can be used instead of symbols like ABCD, eliminating need for infinitely many atoms.

It remains unclear why these two systems of axioms are so similar.

Commenti:
---------
*** karnataka state board of secondary education 20 June 2012 at 13:39
The natural numbers can be easily understand by the graphs.Like if we have to represent set of positive and negative numbers simultaneously.Then we can make four quadrants and represent them.


---------
Sexpron I
---------
http://kazimirmajorinc.com/Documents/All-symbolic-expressions/Sexpron-I.lsp

Sexpron I, Newlisp program for generation of symbolic expressions and one million generated symbolic expressions, (compressed file), Aaron Schwartz Memorial Hackathon, Hacklab Mama, Zagreb, November 8-10th, 2013.

(load "http://kazimirmajorinc.com/Default.lsp")

(setf ALPHABET "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(println "xxx")
(define (atomic-symbol n)
        (letn ((l (length))
               (last-char  (ALPHABET (% (- n 1) l)))
               (other-chars (let ((n1 (/ (- n 1) l)))
                                 (if (= n1 0)
                                     ""
                                     (atomic-symbol n1)))))
              (sym (append (string other-chars) last-char))))

(define (pair n)
        (list (symbolic-expression (cantors-row n))
              (symbolic-expression (cantors-column n))))

(define (symbolic-expression n)
        (letn((n1 (- n 1))
              (row (+ (% n1 2) 1))
              (column (+ (/ n1 2) 1)))
          (println row " -> " (cantors-row n) ", " column " ->" (cantors-column n))
          (case row (1 (atomic-symbol column))
                    (2 (pair          column)))))

(define (symbolic-expression-external n)
        (replace " " (string (symbolic-expression n)) "."))

(for (i 1 1000)
  (println i ".---------")
  (println "-----------> " (symbolic-experssion-external i)))

; (setf out-file (open "C://symbolic-expressions.txt" "write"))
;
; (for(i 1 1000000)
;   (write-line out-file
;               (append (string i)
;                       ". "
;                       (symbolic-expression-external i ALPHABET))))
;
; (close out-file)
;
(exit)

=============================================================================

