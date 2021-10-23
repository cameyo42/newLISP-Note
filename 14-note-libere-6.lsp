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

=============================================================================

