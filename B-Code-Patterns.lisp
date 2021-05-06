===============

 CODE PATTERNS

===============

Questo file contiene la traduzione libera di alcuni capitoli del documento ufficiale "Code Patterns in newLISP" che si trova al seguente indirizzo web:

http://www.newlisp.org/CodePatterns.html

Il documento ufficiale ha il seguente copyright:

----------------------------------------------------------------------------
Code Patterns in newLISP®
Version 2018 July 12th
newLISP v.10.7.1

Copyright © 2015 Lutz Mueller, www.nuevatec.com. All rights reserved.
Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.2 or any later version published by the Free Software Foundation, with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts. A copy of the license is included in the section entitled GNU Free Documentation License.

newLISP is a registered trademark of Lutz Mueller.
----------------------------------------------------------------------------

=================
 1. Introduzione
=================

Quando si programma in newLISP, alcune funzioni e modelli (pattern) di utilizzo si verificano ripetutamente. Per alcuni problemi un modo ottimale per risolverli si evolve nel tempo. I capitoli seguenti presentano codice di esempio e spiegazioni per la soluzione di problemi specifici durante la programmazione in newLISP.
Alcuni contenuti si sovrappongono al materiale trattato nel manuale "newLISP Users manual and Reference" o vengono presentati qui con un'angolazione diversa.
Utilizzeremo solo un sottoinsieme del repertorio delle funzioni totali di newLISP. Alcune funzioni presentate hanno metodi di chiamata aggiuntivi o applicazioni non menzionate in queste pagine.
Questa raccolta di modelli e soluzioni è un lavoro in corso. Nel tempo, il materiale verrà aggiunto o il materiale esistente migliorato.

========================
 2. newLISP script file
========================

Opzioni della linea di comando
==============================
Su Linux/Unix, inserisci quanto segue nella prima riga del file di script/programma:

#!/usr/bin/newlisp

specificando uno stack più grande:

#!/usr/bin/newlisp -s 100000

oppure

#!/usr/bin/newlisp -s100000

Le shell dei sistemi operativi si comportano in modo diverso durante l'analisi della prima riga e l'estrazione dei parametri. newLISP accetta entrambi i parametri collegati o scollegati. Inserisci le seguenti righe in un piccolo script per testare il comportamento del sistema operativo e della piattaforma sottostanti. Lo script modifica la dimensione dello stack allocata a 100.000 e limita la memoria della cella newLISP a circa 10 Mbyte.

#!/usr/bin/newlisp -s 100000 -m 10

(println (main-args))
(println (sys-info))

(exit) ; importante

Un tipico output che esegue lo script dalla shell di sistema sarebbe:

./arg-test

("/usr/bin/newlisp" "-s" "100000" "-m" "10" "./arg-test")
;-> (308 655360 299 2 0 100000 8410 2)

Notare che pochi programmi in newLISP necessitano di uno stack più grande di quello di base. La maggior parte dei programmi viene eseguita sul valore predefinito di 2048. Ogni posizione dello stack richiede una media di 80 byte. Sono disponibili altre opzioni per avviare newLISP. Vedere il Manuale dell'utente per i dettagli.

Script come pipe
================
The following example shows how a file can be piped into a newLISP script.
L'esempio seguente mostra come un file può essere reindirizzato (pipe) in uno script newLISP.

#!/usr/bin/newlisp
#
# uppercase - demo filter script as pipe
#
# usage:
#          ./uppercase < file-spec
#
# example:
#          ./uppercase < my-text
#
#

(while (read-line) (println (upper-case (current-line))))

(exit)

Il file verrà stampato in uscita standard tradotto in maiuscolo. Il seguente programma funzionerà anche con informazioni binarie non testuali contenenti 0:

#!/usr/bin/newlisp
;
; inout - demo binary pipe
;
; read from stdin into buffer
; then write to stdout
;
; usage: ./inout < inputfile > outputfile
;

(while (read 0 buffer 1024)
    (write 1 buffer 1024))

(exit)

Imposta la dimensione del buffer per ottenere le migliori prestazioni.

Filtro di File
==============
Lo script seguente funziona come un'utilità grep di Unix che itera i file e filtra ogni riga in un file utilizzando un modello (pattern) di espressione regolare.

#!/usr/bin/newlisp
#
# nlgrep - grep utility on newLISP
#
# usage:
#          ./nlgrep "regex-pattern" file-spec
#
# file spec can contain globbing characters
#
# example:
#          ./nlgrep "this|that" *.c
#
# will print all lines containing 'this' or 'that' in *.c files
#

(dolist (fname (3 (main-args)))
    (set 'file (open fname "read"))
    (println "file ---> " fname)
    (while (read-line file)
        (if (find (main-args 2) (current-line) 0)
            (write-line)))
    (close file))

(exit)

L'espressione:

(3 (main-args))

è una forma breve di:

(rest (rest (rest (main-args))))

Restituisce una lista di tutti i nomi di file. Questa forma di specificare gli indici per il resto è chiamata indicizzazione implicita. Vedere il Manuale d'uso per l'indicizzazione implicita con altre funzioni. L'espressione (main-args 2) estrae il terzo argomento dalla riga di comando contenente il modello (pattern) di espressione regolare.

newLISP come pipe
=================
Inserisci una riga direttamente nell'eseguibile per la valutazione di espressioni brevi:

~> echo '(+ 1 2 3)' | newlisp
6
~>

§

==============================
 3. Scrivere codice in moduli
==============================

Strutturare una applicazione
============================
Quando si scrivono applicazioni più grandi o quando più programmatori stanno lavorando sulla stessa base di codice, è necessario dividere la base di codice in moduli. I moduli in newLISP vengono implementati utilizzando i contesti, che sono spazi dei nomi. Gli spazi dei nomi consentono l'isolamento lessicale tra i moduli. Le variabili con lo stesso nome in un modulo non possono entrare in conflitto con le variabili con lo stesso nome in un altro modulo.

In genere, i moduli sono organizzati in un contesto per file.
Un modulo file può contenere routine di accesso al database:

; database.lsp
;
(context 'db)


(define (update x y z)
...
)

(define (erase x y z)
...
)

Un altro modulo può contenere varie utilità:

; auxiliary.lsp
;
(context 'aux)

(define (getval a b)
...
)

In genere, ci sarà un modulo MAIN che carica e controlla tutti gli altri:

; application.lsp
;

(load "auxiliary.lsp")
(load "database.lsp")

(define (run)
    (db:update ....)
    (aux:putval ...)
    ...
    ...
)

(run)

Più di un contesto in un file
=============================
Quando si utilizza più di un contesto per file, ogni sezione del contesto deve essere chiusa con un'istruzione (context MAIN):

; myapp.lsp
;
(context 'A)

(define (foo ...) ...)

(context MAIN)

(context 'B)

(define (bar ...) ...)

(context MAIN)

(define (main-func)
    (A:foo ...)
    (B:bar ...)
)

Si noti che nelle istruzioni dello spazio dei nomi per i contesti A e B i nomi dei contesti sono quotati perché sono stati appena creati, ma MAIN può rimanere non quotato perché esiste già all'avvio di newLISP. Tuttavia, quotarlo non rappresenta un problema.

La riga (context MAIN) che chiude un contesto può essere omessa utilizzando la seguente tecnica:

; myapp.lsp
;
(context 'A)

(define (foo ...) ...)

(context 'MAIN:B)

(define (bar ...) ...)

(context 'MAIN)

(define (main-func)
    (A:foo ...)
    (B:bar ...)
)

La riga (contesto 'MAIN:B) torna a MAIN quindi apre il nuovo contesto B.

La funzione predefinita (default)
=================================
Una funzione in un contesto può avere lo stesso nome del contesto stesso. Questa funzione ha caratteristiche speciali:

(context 'foo)

(define (foo:foo a b c)
...
)

La funzione foo: foo è chiamata funzione di default, perché quando si usa il nome di contesto foo come una funzione, sarà di default foo:foo.

(foo x y z)
; same as
(foo:foo x y z)

La funzione predefinita rende possibile scrivere funzioni che assomigliano a funzioni normali, ma portano il proprio spazio dei nomi lessicale. Possiamo usarlo per scrivere funzioni che mantengono lo stato:

(context 'generator)

(define (generator:generator)
    (inc acc)) ; when acc is nil, assumes 0

(context MAIN)

(generator) → 1
(generator) → 2
(generator) → 3

Quello che segue è un esempio più complesso per una funzione che genera una sequenza di Fibonacci:

(define (fibo:fibo)
    (if (not fibo:mem) (set 'fibo:mem '(0 1)))
    (last (push (+ (fibo:mem -1) (fibo:mem -2)) fibo:mem -1)))

(fibo) → 1
(fibo) → 2
(fibo) → 3
(fibo) → 5
(fibo) → 8
...

Questo esempio mostra anche come una funzione di default viene definita al volo senza la necessità di istruzioni di contesto esplicite. In alternativa, la funzione potrebbe anche essere stata scritta in modo che il contesto sia creato esplicitamente:

(context 'fibo)
(define (fibo:fibo)
        (if (not mem) (set 'mem '(0 1)))
        (last (push (+ (mem -1) (mem -2)) mem -1)))
(context MAIN)

(fibo) → 1
(fibo) → 2
(fibo) → 3
(fibo) → 5
(fibo) → 8

Sebbene la prima forma sia più breve, la seconda è più leggibile.
Although the first form is shorter, the second form is more readable.

Packaging data with contexts
============================
The previous examples already presented functions packaged with data in a namespace. In the generator example the acc variable kept state. In the fibo example the variable mem kept a growing list. In both cases, functions and data are living together in a namespace. The following example shows how a namespace holds only data in a default functor:

(set 'db:db '(a "b" (c d) 1 2 3 x y z))
Just like we used the default function to refer to fibo and generator we can refer to the list in db:db by only using db. This will work in all situations where we do list indexing:

(db 0)    → a
(db 1)    → "b"
(db 2 1)  → d
(db -1)   → z
(db -3)   → x

(3 db)    → (1 2 3 x y z)
(2 1 db)  → ((c d))
(-6 2 db) → (1 2)

Passing objects by reference
============================
When the default functor is used as an argument in a user defined function, the default functor is passed by reference. This means that a reference to the original contents is passed, not a copy of the list or string. This is useful when handling large lists or strings:

(define (update data idx expr)
    (if (not (or (lambda? expr) (primitive? expr)))
        (setf (data idx) expr)
        (setf (data idx) (expr $it))))

(update db 0 99) → a
db:db → (99 "b" (c d) 1 2 3 x y z)

(update db 1 upper-case) → "b"
db:db → (99 "B" (c d) 1 2 3 x y z)

(update db 4 (fn (x) (mul 1.1 x))) →
db:db → (99 "B" (c d) 1 2.2 3 x y z)
The data in db:db is passed via the update function parameter data, which now holds a reference to the context db. The expr parameter passed is checked to determine if it is a built-in function, operator or a user defined lambda expression and then works on $it, the anaphoric system variable containing the old content referenced by (data idx).

Whenever a function in newLISP asks for a string or list in a parameter, a default functor can be passed by its context symbol. Another example:

(define (pop-last data)
(pop data -1))

(pop-last db) → z

db:db         → (99 "B" (c d) 1 2.2 3 x y)

The function update is also a good example of how to pass operators or functions as a function argument (upper-case working on $it). Read more about this in the chapter Functions as data.

=====================
 4. Variabili locali
=====================

Locals in looping functions
===========================
All looping functions like doargs, dolist, dostring, dotimes, dotree and for use local variables. During loop execution, the variable takes different values. But after leaving the looping function, the variable regains its old value. let, define, and lambda expressions are another method for making variables local:

Locals in let, letn, local and letex
let is the usual way in newLISP to declare symbols as local to a block.

(define (sum-sq a b)
    (let ((x (* a a)) (y (* b b)))
        (+ x y)))

(sum-sq 3 4) → 25

; alternative syntax
(define (sum-sq a b)
    (let (x (* a a) y (* b b))
        (+ x y)))

The variables x and y are initialized, then the expression (+ x y) is evaluated. The let form is just an optimized version and syntactic convenience for writing:

((lambda (sym1 [sym2 ...]) exp-body ) exp-init1 [ exp-init2 ...])

When initializing several parameters, a nested let, letn can be used to reference previously initialized variables in subsequent initializer expressions:

(letn ((x 1) (y (+ x 1)))
    (list x y))              → (1 2)

local works the same way but variables are initialized to nil

(local (a b c)
   ...          ; expressions using the locale variables a b c
)
letex works similar to let but variables are expanded in the body to values assigned.

; assign to local variable and expand in body

(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z))
→ (1 (a b c) "hello")

; as in let, parentheses around the initializers can be omitted

(letex (x 1 y 2 z 3) '(x y z))    → (1 2 3)
After exiting any of the let, letn, local or letex expressions, the variable symbols used as locals get their old values back.

Unused parameters as locals
===========================
In newLISP, all parameters in user defined functions are optional. Unused parameters are filled with nil and are of local scope to the dynamic scope of the function. Defining a user function with more parameters than required is a convenient method to create local variable symbols:


(define (sum-sq a b , x y)
    (set 'x (* a a))
    (set 'y (* b b))
    (+ x y))
The comma is not a special syntax feature but only a visual helper to separate normal parameters from local variable symbols. (Technically, the comma, like x and y, is a local variable and is set to nil.)

Default variable values
=======================
In the definition of a function default values can be specified:

(define (foo (a 1) (b 2))
    (list a b))

    (foo)      →  (1 2)
    (foo 3)    →  (3 2)
    (foo 3 4)  →  (3 4)

args as local substitute
========================
Using the args function no parameter symbols need to be used at all and args returns a list of all parameters passed but not taken by declared parameters:

(define (foo)
    (args))

(foo 1 2 3)   → (1 2 3)


(define (foo a b)
    (args))

(foo 1 2 3 4 5)   → (3 4 5)
The second example shows how args only contains the list of arguments not bound by the variable symbols a and b.

Indices can be used to access members of the (args) list:

(define (foo)
      (+ (args 0) (args 1)))

(foo 3 4)   → 7
args and local used together for named variables
(define-macro (foo)
   (local (len width height)
      (bind (args) true)
      (println "len:" len " width:" width " height:" height)
   ))

(foo (width 20) (height 30) (len 10))

len:10 width:20 height:30
local will shadow / protect the values of the variables len, width and height at higher dynamic scoping levels.

===================================
 5. Walking through lists and data
===================================

Recursion or iteration?
=======================
Although recursion is a powerful feature to express many algorithms in a readable form, it can also be inefficient in some instances. newLISP has many iterative constructs and high level functions like flat or the built-in XML functions, which use recursion internally. In many cases this makes defining a recursive algorithm unnecessary.

Some times a non-recursive solution can be much faster and lighter on system resources.

; classic recursion
; slow and resource hungry
(define (fib n)
    (if (< n 2) 1
        (+  (fib (- n 1))
            (fib (- n 2)))))
            
The recursive solution is slow because of the frequent calling overhead. Also, the recursive solution uses a lot of memory for holding intermediate and frequently redundant results.

; iteration
; fast and also returns the whole list
(define (fibo n , f)
    (set 'f '(1 0))
    (dotimes (i n)
         (push (+ (f 0) (f 1)) f)) )

The iterative solution is fast and uses very little memory.

Speed up with memoization
=========================
A memoizing function caches results for faster retrieval when called with the same parameters again. The following function makes a memoizing function from any built-in or user defined function with an arbitrary number of arguments. A namespace is created for the memoizing function as a data cache.

; speed up a recursive function using memoization
(define-macro (memoize mem-func func)
    (set (sym mem-func mem-func)
        (letex (f func  c mem-func)
          (lambda ()
              (or (context c (string (args)))
              (context c (string (args)) (apply f (args))))))))

(define (fibo n)
    (if (< n 2)  1
        (+  (fibo (- n 1))
            (fibo (- n 2)))))

(memoize fibo-m fibo)

(time (fibo-m 25)) → 148
(time (fibo-m 25)) → 0

The function creates a context and default function for the original function with a new name and stores all results in symbols in the same context.

When memoizing recursive functions, include the raw lambda specification of the function so recursive calls are memoized too:

(memoize fibo
    (lambda (n)
        (if(< n 2) 1
            (+  (fibo (- n 1))
                (fibo (- n 2))))))

(time (fibo 100)) → 1
(fibo 80)         → 37889062373143906

The fibo function in the last example would take hours to calculate without memoization. The memoized version takes only about a milli-second for an argument of 100.

Walking a tree
==============
Tree walks are a typical pattern in traditional LISP and in newLISP as well for walking through a nested list. But many times a tree walk is only used to iterate through all elements of an existing tree or nested list. In this case the built-in flat function is much faster than using recursion:

(set 'L '(a b c (d e (f g) h i) j k))

; classic car/cdr and recursion
;
(define (walk-tree tree)
    (cond ((= tree '()) true)
          ((atom? (first tree))
             (println (first tree))
             (walk-tree (rest tree)))
          (true
             (walk-tree (first tree))
             (walk-tree (rest tree)))))

; classic recursion
; 3 times faster
;
(define (walk-tree tree)
    (dolist (elmnt tree)
        (if (list? elmnt)
            (walk-tree elmnt)
            (println elmnt))))

(walk-tree L) →
     a
     b
     c
     d
     e
     ...

Using the built-in flat in newLISP a nested list can be transformed into a flat list. Now the list can be processed with a dolist or map:

; fast and short using 'flat'
; 30 times faster with map
;
(map println (flat L))

; same as

(dolist (item (flat L)) (println item))

Walking a directory tree
========================
Walking a directory tree is a task where recursion works well:

; walks a disk directory and prints all path-file names
;
(define (show-tree dir)
    (when (directory? dir)
        (dolist (nde (directory dir))
            (if (and (directory? (append dir "/" nde))
                     (!= nde ".") (!= nde ".."))
                (show-tree (append dir "/" nde))
                (println (append dir "/" nde))))))

In this example recursion is the only solution, because the entire nested list of files is not available when the function is called but gets created recursively during function execution.

==================================
 6. Modifying and searching lists
==================================
newLISP has facilities for multidimensional indexing into nested lists. There are destructive functions like push, pop, setf, set-ref, set-ref-all, sort and reverse and many others for non-destructive operations, like nth, ref, ref-all, first, last and rest etc.. Many of the list functions in newLISP also work on strings.

Note that any list or string index in newLISP can be negative starting with -1 from the right side of a list:

(set 'L '(a b c d))
(L -1)   → d
(L -2)   → c
(-3 2 L) → (b c)
   
(set 'S  "abcd")
   
(S -1)   → d
(S -2)   → c
(-3 2 S) → "bc")
push and pop
To add to a list use push, to eliminate an element from a list use pop. Both functions are destructive, changing the contents of a list:

(set 'L '(b c d e f))
   
(push 'a L) → (a b c d e f)
(push 'g L -1) ; push to the end with negative index
(pop L)        ; pop first a
(pop L -1)     ; pop last g
(pop L -2)     ; pop second to last e
(pop L 1)      ; pop second c
   
L → (b d f)
   
; multidimensional push / pop
(set 'L '(a b (c d (e f) g) h i))
   
(push 'x L 2 1) → (a b (c x d (e f) g) h i)
   
L → (a b (c x d (e f) g) h i)
   
(pop L 2 1) → x

; the target list is a place reference
(set 'lst '((a 1) (b 2) (c 3) (d)))

(push 4 (assoc 'd lst) -1) → (d 4)

lst → ((a 1) (b 2) (c 3) (d 4))
Pushing to the end of a list repeatedly is optimized in newLISP and as fast as pushing in front of a list.

When pushing an element with index vector V it can be popped with the same index vector V:

(set 'L '(a b (c d (e f) g) h i))
(set 'V '(2 1))
(push 'x L V)
L → (a b (c x d (e f) g) h i))
(ref 'x L) → (2 1) ; search for a nested member
(pop L V) → 'x
Extend using extend
Using extend lists can be appended destructively. Like push and pop, extend modifies the list in the first argument.

(set 'L '(a b c))
(extend L '(d e) '(f g))

L → '(a b c d e f g)

; extending in a place

(set 'L '(a b "CD" (e f)))
(extend (L 3) '(g))
L → (a b "CD" (e f g))
Accessing lists
Multiple indexes can be specified to access elements in a nested list structure:

(set 'L '(a b (c d (e f) g) h i))
   
; old syntax only for one index
(nth 2 L) → (c d (e f) g)
   
; use new syntax for multiple indices
(nth '(2 2 1) L) → f
(nth '(2 2) L) → (e f)
   
; vector indexing
(set 'vec '(2 2))
(nth vec L) → (e f)
   
; implicit indexing
(L 2 2 1) → f
(L 2 2)   → (e f)
   
; implicit indexing with vector
(set 'vec '(2 2 1))
(L vec)   → f
Implicit indexing shown in the last example can make code more readable. Indexes before a list select subsections of a list, which in turn are always lists.

Implicit indexing is also available for rest and slice:

(rest '(a b c d e))      → (b c d e)
(rest (rest '(a b c d e) → (c d e)
; same as
(1 '(a b c d e)) → (b c d e)
(2 '(a b c d e)) → (c d e)
   
; negative indices
(-2 '(a b c d e)) → (d e)
   
; slicing
(2 2 '(a b c d e f g))  → (c d)
(-5 3 '(a b c d e f g)) → (c d e)
Selecting more elements
Sometimes more than one element must be selected from a list. This is done using select:

; pick several elements from a list
(set 'L '(a b c d e f g))
(select L 1 2 4 -1) → (b c e g)
   
; indices can be delivered in an index vector:
(set 'vec '(1 2 4 -1))
(select L vec) → (b c e g)
The selecting process can re-arrange or double elements at the same time:

(select L 2 2 1 1) → (c c b b)
Filtering and differencing lists
Lists can be filtered, returning only those elements that meet a specific condition:

(filter (fn(x) (< 5 x)) '(1 6 3 7 8))    → (6 7 8)
(filter symbol? '(a b 3 c 4 "hello" g)) → (a b c g)
(difference '(1 3 2 5 5 7) '(3 7)) → (1 2 5)
The first example could be written more concisely, as follows:

(filter (curry < 5) '(1 6 3 7 8))
The curry function makes a one argument function out of a two argument function:

(curry < 5) → (lambda (_x) (< 5 _x))
With curry, a function taking two arguments can be quickly converted into a predicate taking one argument.

Changing list elements
setf can be used to change a list element by referencing it with either nth or assoc:

; modify a list at an index
(set 'L '(a b (c d (e f) g) h i))
   
(setf (L 2 2 1) 'x) → x   
L → (a b (c d (e x) g) h i)
(setf (L 2 2) 'z) → z
L → (a b (c d z g) h i)
   
; modify an association list
(set 'A '((a 1) (b 2) (c 3)))
   
; using setf with assoc
(setf (assoc 'b A) '(b 22)) → (b 22)
A → ((a 1) (b 22) (c 3))
; using setf with lookup
(setf (lookup 'c A) 33) → 33
A → ((a 1) (b 22) (c 33))
The anaphoric variable
The internal anaphoric system variable $it holds the old list element. This can be used to configure the new one:

(set 'L '(0 0 0))
(setf (L 1) (+ $it 1)) → 1 ; the new value
(setf (L 1) (+ $it 1)) → 2
(setf (L 1) (+ $it 1)) → 4
L → '(0 3 0)
The following functions use the anaphoric $it:  find-all, if, replace, set-ref, set-ref-all and setf setq.

Replace in simple lists
Replace, which can also be used on strings, can search for and replace multiple elements in a list at once. Together with match and unify complex search patterns can be specified. Like with setf, the replacement expression can use the old element contents to form the replacement.

(set 'aList '(a b c d e a b c d))
     
(replace 'b aList 'B) → (a B c d e a B c d)
The function replace can take a comparison function for picking list elements:

; replace all numbers where 10 < number
(set 'L '(1 4 22 5 6 89 2 3 24))
     
(replace 10 L 10 <) → (1 4 10 5 6 10 2 3 10)
Using the built-in functions match and unify more complex selection criteria can be defined:

; replace only sublists starting with 'mary'
    
(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))
   
(replace '(mary *)  AL (list 'mary (apply + (rest $it))) match)
→ ((john 5 6 4) (mary 14) (bob 4 2 7 9) (jane 3))
    
; make sum in all expressions
    
(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))
   
(replace '(*) AL (list ($it 0) (apply + (rest $it))) match)
→ ((john 15) (mary 14) (bob 22) (jane 3))
    
$0 → 4  ; replacements made
    
; change only sublists where both elements are the same
    
(replace '(X X) '((3 10) (2 5) (4 4) (6 7) (8 8)) (list ($it 0) 'double ($it 1)) unify)
→ ((3 10) (2 5) (4 double 4) (6 7) (8 double 8))
    
$0 → 2  ; replacements made
During replacements $0 and the anaphoric system variable $it contain the current found expression.

After a replacement statement is executed the newLISP system variable $0 contains the number of replacements made.

Replace in nested lists
Sometimes lists are nested, e.g. the SXML results from parsing XML. The functions ref-set, set-ref and set-ref-all can be used to find a single element or all elements in a nested list, and replace it or all.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))
   
(set-ref 'monday data tuesday)
→ ((tuesday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))) 
The function set-ref-all does a set-ref multiple times, replacing all found occurrences of an element.

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))
   
(set-ref-all 'apples data "Apples")
→ ((monday ("Apples" 20 30) (oranges 2 4 9)) (tuesday ("Apples" 5) (oranges 32 1)))
Like find, replace, ref and ref-all, more complex searches can be expressed using match or unify:

(set 'data '((monday (apples 20 30) (oranges 2 4 9)) (tuesday (apples 5) (oranges 32 1))))
   
(set-ref-all '(oranges *) data (list (first $0) (apply + (rest $it))) match)
→ ((monday (apples 20 30) (oranges 15)) (tuesday (apples 5) (oranges 33)))
The last example shows how $0 can be used to access the old list element in the updating expression. In this case the numbers for oranges records have been summed. Instead of $0 the anaphoric system variable $it can also be used.

Passing lists by reference
Sometimes a larger list (more than a few hundred elements) must be passed to a user-defined function for elements in it to be changed. Normally newLISP passes all parameters to user-defined functions by value. But the following snippet shows a technique that can be used to pass a bigger list or string object by reference:

(set 'data:data '(a b c d e f g h))
   
(define (change db i value)
    (setf (db i) value))
   
(change data 3 999) → d
   
data:data → '(a b c 999 d e f g h)
In this example the list is encapsulated in a context named data holding a variable data with the same name.

Whenever a function in newLISP looks for a string or list parameter, a context can be passed, which will then be interpreted as the default functor.

When returning a list or array or an element belonging to a list or array referenced by a symbol, many built-in functions return a //reference// to the list – not a copy. This can be used to nest built-in functions when modifying a list:

(set 'L '(r w j s r b))
   
(pop (sort L)) → b
   
L → (j r r s w)

Variable expansion
==================
Two functions are available to do macro-expansion: expand and letex. The expand function has three different syntax patterns.

Symbols get expanded to their value:

; expand from one or more listed symbols
(set 'x 2 'a '(d e))
(expand '(a x (b c x)) 'x 'a)  → ((d e) 2 (b c 2))
expand is useful when composing lambda expressions or when doing variable expansion inside functions and function macros (fexpr with define-macro):

; use expansion inside a function
(define (raise-to power)
    (expand (fn (base) (pow base power)) 'power))
(define square (raise-to 2))
(define cube (raise-to 3))
(square 5)  → 25
(cube 5)    → 125
expand can take an association list:

; expand from an association list
(expand '(a b c) '((a 1) (b 2)))                → (1 2 c)
(expand '(a b c) '((a 1) (b 2) (c (x y z))))    → (1 2 (x y z))
and the value part in associations can be evaluated first:

; evaluate the value parts in the association list before expansion
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))))      → ((+ 1 2) (+ 3 4))
(expand '(a b) '((a (+ 1 2)) (b (+ 3 4))) true) → (3 7)
expand does its work on variables starting with an uppercase letter when expansion variables have neither been specified stand-alone nor in an association list.

; expand from uppercase variables
(set 'A 1 'Bvar 2 'C nil 'd 5 'e 6)
(expand '(A (Bvar) C d e f))  → (1 (2) C d e f)
Using this, a previous function definition can be made even shorter.

; use expansion from uppercase variables in function factories
(define (raise-to Power) 
    (expand (fn (base) (pow base Power))))
(define cube (raise-to 3)) → (lambda (base) (pow base 3))
(cube 4) → 64
The letex function works like expand, but expansion symbols are local to the letex expression.

; use letex for variable expansion
(letex ( (x 1) (y '(a b c)) (z "hello") ) '(x y z)) → (1 (a b c) "hello")
Note that in the example the body expression in letex: (x y z) is quoted to prevent evaluation.

Destructuring nested lists
==========================
The following method can be used to bind variables to subparts of a nested list:

; uses unify together with bind for destructuring
(set 'structure '((one "two") 3 (four (x y z))))
(set 'pattern '((A B) C (D E))) ; unify needs uppercase for binding
(bind (unify pattern structure))
A → one
B → "two"
C → 3
D → four
E → (x y z)

=================
 7. Program flow
=================