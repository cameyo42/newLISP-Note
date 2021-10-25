===============

 NOTE LIBERE 6

===============

In questo documento sono presentati alcuni post del blog di Kazimir Majorinc dal sito:

http://kazimirmajorinc.blogspot.com/

Kazimir è un vero esperto sul linguaggio LISP e approfondisce in modo molto interessante alcune caratteristiche di newLISP (in particolar modo quelle proprie della famiglia dei linguaggi LISP).
Alcune parti del codice di esempio sono state aggiornate alla versione 10.7.5 di newLISP.
I sorgenti e i commenti ai post non sono stati tradotti.

Tutti i diritti sono di Kazimir Majorinc.


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

=============================================================================


