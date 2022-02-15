; +=========================+
; | Introduction to newLISP |
; +=========================+
;
; Original version:
; http://en.wikibooks.org/wiki/Introduction_to_newLISP
; License:
; Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
; Original version creator: Cormullion
; This version creator: cameyo

; This document is based on:
; "Introduction to newLISP" (by Cormullion)
; (this is a modified/reduced text version with max row length = 100)
; All the errors are mine.
; Some infos from:
;          "official newLISP forum"
;          "Kazimir Majorinc blog"
;          "Cormullion blog"

; Advantage of this version:
; - all the source in plain text
; - execute the code when reading tutorial (from within the editor)
; - add and try your comment/code to better understand

; the semicolon ";" is the comment character

; ";->" is a way of saying "the output is"

; Y combinator
; Y = λf.(λx.f(xx))(λx.f(xx))

; MULTI-LINE CODE IN REPL
; =======================

; 1) by enclosing the lines between [cmd] and [/cmd] OR
; 2) use the enter key on a blank line to begin and also to end the multi-line block.

(define (doppio x)
  (mul x x))

[cmd]
(define (doppio x)
  (mul x x))
[/cmd]

(define (fibonacci n)
  (if (< n 2)
      1
      (+ (fibonacci (- n 1)) (fibonacci (- n 2)))))

(div (time (fibonacci 20) 100) 100.0)

; newLISP-GS provides a graphical toolkit for newLISP applications.

; You can edit newLISP scripts in your favourite text editor.
; You can use npp-newLISP.ahk on windows.

; Use (exit) to quit newLISP REPL.


; ==============================================================
; INDEX
; ==============================================================
; Introduction to newLISP
;   Welcome to newLISP
;   Resources
;
; The basics
;   Downloading and installation
;   Using newLISP with notepad++
;   Getting started
;   The three basic rules of newLISP
;   Rule 1: a list is a sequence of elements
;   Rule 2: the ﬁrst element in a list is special
;   Rule 3: Quoting prevents evaluating
;   Symbols and Quote
;   Setting and define Symbols
;   Destructive functions
;
; Controlling the ﬂow
;   Tests: "if" statement
;   Looping
;   Working through a list "dolist"
;   Working through a string "dostring"
;   A certain number of time ("dotimes"  and "for")
;   Breaking loops
;   Until something happens or while something is true
;   Blocks: groups of expressions ("begin", "or", "and")
;   Random expressions: the "amb" function
;   Selection: "if", "cond", and "case"
;   Local variables
;   Make your own functions
;   Local and Global variables
;   Default values for parameters
;   Arguments: "args"
;   Other function to control the flow of code
;   Scope of variables
;
; Lists
;   Funtions to build lists
;   Make a destructive function non-destructive
;   Working with whole lists
;   List analysis: testing and searching
;   Finding items on a list
;   Filtering lists: "filter", "clean", and "index"
;   Testing lists
;   Searching on lists
;   Summary: compare and contrast
;   Selecting items from lists
;   Picking elements: "nth", "select", and "slice"
;   Implicit addressing
;   Selecting elements using implicit addressing
;   Selecting slice using implicit addressing
;   List surgery
;   Shortening Lists
;   Changing items in lists
;   Replacing information: "replace"
;   Modifying lists
;   Find and replace matching elements: "set-ref"
;   Find and replace all matching elements: "set-ref-all"
;   Working with two or more lists
;   Association lists
;   Replaces sublists in association lists
;   Adding new items to association lists
;   "find-all" and association lists
;
; Strings
;   Strings in code
;   Making strings
;   String surgery
;   Substring
;   String slices
;   Changing the ends of strings
;   "push" and "pop" work on strings too
;   Modifying strings
;   Using index numbers in strings
;   Changing substrings
;   Regular expressions
;   System Variables $0, $1, ...
;   The replacement expression
;   Testing and comparing strings
;   Strings to lists
;   Parsing strings
;   Other string functions
;   Formatting strings
;   Strings that make newLISP think
;
; Apply and map: applying functions to lists
;   Making functions and data work together
;   "apply" and "map" in more detail
;   Write one in terms of the other?
;   More tricks
;   Lispiness
;   Currying
;
; Introducing contexts
;   What is a context?
;   Contexts: the basics
;   Creating contexts implicitly
;   Functions in context
;   The default function
;   Passing parameters by reference
;   Functions with a memory
;   Dictionaries and tables
;   Saving and loading contexts
;   Using newLISP modules
;   Scoping
;   Objects
;   FOOP in a nutshell
;   Polymorphism
;   Modifying objects
;
; Macros
;   Introducing macros
;   When do things get evaluated
;   Tools for building macros
;   Symbol confusion
;   Other ideas for macro
;   A Tracer macro
;
; Working with numbers
;   Integers and ﬂoating-point numbers
;   Integer and ﬂoating-point maths
;   Conversions: explicit and implicit
;   Invisible conversion and rounding
;   Number testing
;   Absolute signs, from ﬂoor to ceiling
;   Number formatting
;   Format Cheat Sheet
;   Number utilities
;   Creating numbers
;   Sequences and series
;   Random numbers
;   Randomness
;   General numbers tools
;   Floating-point utilities
;   Trigonometry
;   Arrays
;   Functions available for arrays
;   Getting and setting values
;   Matrices
;   Statistics, ﬁnancial, and modelling functions
;   Bayesian analysis
;   Financial functions
;   Logic programming
;   Bit operators
;   Bigger numbers
;
; Working with dates and times
;   Date and time functions
;   The current time and date
;   Reading dates and times: "parse-date"
;   Timing and timers
;
; Working with ﬁles
;   Interacting with the ﬁle system
;   File information
;   File management
;   Reading and writing data
;   Standard Input and output
;   Command line arguments
;
; Working with pipes, threads, and processes
;   Processes, pipes, threads, and system functions
;   Multitasking
;   Forked processes
;   Reading and writing to threads
;   Communicating with other processes
;   Working with XML
;   Converting XML into lists
;   Changing SXML
;   Outputting SXML to XML
;   A simple practical example
;
; The debugger
;
; The internet
;   HTTP and networking
;   Accessing web pages
;   A simple HTML Form
;   A simple IRC client
;
; More examples
;   On your own terms
;   Using a SQLite database
;   Querying the data
;   Simple countdown timer
;   Editing text ﬁles in folders and hierarchies
;
; Graphical interfaces
;   Introduction
;   A simple application
;   Source code
; ==============================================================

; INTRODUCTION TO newLISP
; =======================

; WELCOME TO NEWLISP
; ==================

; RESOURCES
; =========



; THE BASICS
; ==========

; DOWNLOADING AND INSTALLATION
; ============================

; Download from: http://www.newlisp.org/
; Install following the instructions on the site.

; USING newLISP WITH NOTEPAD++
; ============================


; GETTING STARTED
; ===============

; Launch the newLISP REPL (newlip.exe on windows)

; THE THREE BASIC RULES OF NEWLISP
; ================================

; ==========================================================================
; RULE 1
; A LIST IS A SEQUENCE OF ELEMENTS ENCLOSED IN PARENTHESES.
; ==========================================================================

; a list of integers
'(1 2 3 4 5)

; a list of strings
'("the" "cat" "sat")

; a list of symbol names
'(x y z foo bar)

; a list of newLISP functions
'(sin cos tan atan)

; a mixed list
'(1 2 "stitch" x sin)

; a list with a list inside it
'(1 2 (1 2 3) 3 4 )

; a list of lists
'((1 2) (3 4) (5 6))

; ==========================================================================
; RULE 2
; THE FIRST ELEMENT IN A LIST IS SPECIAL.
; newLISP TREATS THE FIRST ELEMENT AS A FUNCTION AND THEN TRIES
; TO USE THE REMAINING ELEMENTS AS PARAMETERS OF THE FUNCTION.
; ==========================================================================

; sum of integers
(+ 10 22 12 34 88)
;-> 166

(+ 1.2 3.2)
;-> 4

; sum of floats
(add 1.2 3.2)
;-> 4.4

; There is no (reasonable) limit to the length of the list.
; newLISP has over 380 functions:

(directory "c://")
(directory "/")
(read-file "e://demo.txt")

; ------------------------------------------
; Every newLISP expressions returns a value.
; ------------------------------------------

; ==========================================================================
; RULE 3
; QUOTING PREVENTS EVALUATING.
; USE THE VERTICAL APOSTROPHE (ASCII CODE 39) TO QUOTE LISTS AND SYMBOLS.
; ==========================================================================

(+ 2 2)
;-> 4

'(+ 2 2)
;-> (+ 2 2)

; SYMBOLS AND QUOTES
; ==================

; A symbol is a newLISP thing with a name.
; You define something in your code and assign a name to it.
; Then you can refer to that something, using the name rather than the contents.

(set 'alphabet "abcdefghijklmnopqrstuvwxyz")
;-> "abcdefghijklmnopqrstuvwxyz"

(upper-case alphabet)
;-> "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

(print alphabet)

; newLISP hasn't permanently changed the value of the symbol,
; because upper-case always creates and returns a new string,
; leaving the one stored in the symbol unchanged.

; Symbols correspond to variables in other programming languages.

; SETTING AND DEFINE SYMBOLS
; ==========================

; There are various ways to create and set the value of symbols.
; You can use "define" or "set".

(set 'x (+ 2 2))
;-> 4

(define y (+ 2 2))
;-> 4

; "set" expects to be followed by a symbol, but evaluates its first argument first.
; So you should either quote a symbol to prevent it being evaluated,
; or supply an expression that evaluates to a symbol.
; "define" doesn't expect the argument to be quoted.
; You can also use "setf" and "setq" to set the value of symbols.
; These expect a symbol or a symbol reference as the first argument,
; so you don't have to quote it.

(setf y (+ 2 2))
;-> 4
(setq y (+ 2 2))
;-> 4

; These two functions (which have the same action) can "set" the contents of
; a "symbol" (variable), a list, an array, or a string.
; Use "setq" when setting a symbol.
; Use "setf" when setting an element of a list or array.
; "define" is also used to define functions.

; DESTRUCTIVE FUNCTIONS
; =====================

; Some newLISP functions modify the values of the symbols that they operate on,
; others create a copy of the value and return that.
; The ones that modify the contents of symbols are described as destructive functions,
; although you'll often be using them to create new data.
; In this document I'll describe functions such as "push" and "replace" as destructive.
; This simply means that they change the value of something rather than return a modified copy.

; CONTROLLING THE FLOW
; ====================

; true and false
; nil -> false
; ()  -> false
; but "nil" is different from "()":

(= 'nil '())
;-> nil

; Anything that newLISP doesn't know the value of is false .
; Other values are true.

; (keyword expr1 expr2 ... exprN)

; TEST: if STATEMENT
; ==================

(set 'x 10)
(if (< x 0) (print "minore di zero"))
;-> nil

(if x 1)
; if x is true, return the value 1

(if 1 (launch-missile))
; missiles are launched, because 1 is true

(if 0 (launch-missile))
; missiles are launched, because 0 is true

(if nil (launch-missile))
;-> nil, there's no launch, because nil is false

(if '() (launch-missile))
;-> (), and the missiles aren't launched

; You can use anything that evaluates to either true or false as a test:

(if (> 4 3) (launch-missile))
;-> it's true that 4 > 3, so the missiles are launched

(if (> 4 3) (println "4 is bigger than 3"))

; If a symbol evaluates to nil (because it doesn't exist or hasn't been assigned a value),
; newLISP considers it false and the test returns nil
; (because there was no alternative action provided):

(if snark (launch-missile))
;-> nil ; that symbol has no value

(if boojum (launch-missile))
;-> nil ; can't find a value for that symbol

(if untrue (launch-missile))
;-> nil ; can't find a value for that symbol either

(if false (launch-missile))
;-> nil
; never heard of it, and it doesn't have a value

; You can add a third expression, which is the else action.
; If the test expression evaluates to nil or (), the third expression is evaluated,
; rather than the second, which is ignored:

(if x 1 2)
; if x is true, return 1, otherwise return 2

(if 1
  (launch-missile)
  (cancel-alert))
; missiles are launched

(if nil
  (launch-missile)
  (cancel-alert))
; alert is cancelled

(if false
  (launch-missile)
  (cancel-alert))
; alert is cancelled

(if (and socket (net-confirm-request)) ; test
    (net-flush) ; action when true
    (finish "could not connect")) ; action when false

; You can use if with an unlimited number of tests and actions.
; In this case, the if list consists of a series of test-action pairs.
; newLISP works through the pairs until one of the tests succeeds,
; then evaluates that test's corresponding action.

(if
    (< x 0) (define a "impossible")
    (< x 10) (define a "small")
    (< x 20) (define a "medium")
    (>= x 20) (define a "large")
)

; This is a simple alternative to "cond", the conditional function.
; newLISP provides the traditional "cond" structure as well.

(define (menu option)
  (cond
      ((= option 1) (setq a 10) (println "1"))
      ((= option 2) (setq a 20) (println "2"))
      ((> option 1) (setq a 30) (println "3"))
      (setq error "bad selection")
  )
)

; To do two or more actions if a test is successful or not, you can use "when",
; which is like an "if" without an 'else' part.

(when (> x 0)
  (define a "positive")
  (define b "not zero")
  (define c "not negative"))

; When newLISP sees a list, it treats the first element as a function.
; It evaluates the first element, before applying it to the arguments:

(define x 1)
((if (< x 5) + *) 3 4) ; which function to use, + or *?
;-> 7 ; it added

(define x 10)
((if (< x 5) + *) 3 4)
;-> 12 ; it multiplied

; In newLISP every expression returns some value, even an if expression:

(define x (if flag 1 -1)) ; x is either 1 or -1

(define result
  (if
    (< x 0) "impossible"
    (< x 10) "small"
    (< x 20) "medium"
             "large"))

; LOOPING
; =======

; Repeat a series of actions more than once:
; - on every item in a list
; - on every item in a string
; - a certain number of times
; - until something happens
; - while some condition prevails
; newLISP has a solution for all of these, and more.

; WORKING THROUGH A LIST "dolist"
; ===============================

(define counter 1)
  (dolist (i (sequence -5 5))
    (println "Element " counter ": " i)
    (inc counter)) ; increment counter by 1

; Unlike "if", the "dolist" function lets you write a series of expressions one after the other.
; Here both the "println" and the "inc" functions are called for each element of the list.

; newLISP automatically maintains a loop counter for you, in a system variable called $idx:

(dolist (i (sequence -5 5))
  (println "Element " $idx ": " i))

; You can use the mapping function "map" for processing a list.
; "map" can be used to apply a function (either an existing function or a temporary definition)
; to every element in a list, without going through the list using a local variable.

(map sqrt '(1 2 3 4))
;-> (1 1.414213562373095 1.732050807568877 2)

(define counter 0)
(map (fn (i) (println " Element " counter ": " i)
             (inc counter))
     (sequence -5 5))

; "fn" is a synonym for "lambda".

; Another function to work on all the elements of a list is "apply".
; It applies a function (primitive, user-defined, or lambda expression) to the arguments in list.

(apply add '(1.2 3.4 4.5))

; The next example shows how apply's reduce functionality can be used
; to convert a two-argument function into one that takes multiple arguments.

;; find the greatest common divisor of two or more integers
;; note that newLISP already has a gcd function

(define (gcd_ a b)
    (let (r (% b a))
        (if (= r 0) a (gcd_ r a))))

(define-macro (my-gcd)
    (apply gcd_ (map eval (args)) 2))

(my-gcd 12 18 6)
(my-gcd 1200 282823283 2341237618 232326 433332)

; Improper divisor  function (for fun)
(define (improper-divisor n) (unique (cons n (factor 10))))
(improper-divisor 100)
(improper-divisor 16)

; To flattening a list use "flat"

(set 'a '(1 2 (3 4) (5 (6 7))))

(flat a)
;-> (1 2 3 4 5 6 7)

; To work through the arguments supplied to a function, you can use the "doargs" function.

; WORKING THROUGH A STRING ("dostring")
; =====================================

(define alphabet "abcdefghijklmnopqrstuvwxyz")
(dostring (letter alphabet)
  (print (char letter) { } ))

; A CERTAIN NUMBER OF TIMES ("dotimes" AND "for")
; ===============================================

(dotimes (c 10)
  (println c " times 3 is " (* c 3)))

; You must supply a local variable with these forms.
; Even if you don't use it, you have to provide one.
; Counting starts at 0 and continues to n - 1, never actually reaching the specified value.

; Use "for" when you known how many repetitions should be made, given start, end, and step values:

(for (c 1 -1 .5)
  (println c))

; BREAKING LOOP
; =============

; You can use a test expression to break the loop:

(define number-list '(100 300 500 701 900 1100 1300 1500))

; first version
(dolist (n number-list)
  (println (/ n 2)))

; second version
; Stops looping if the test for n being odd, (!= (mod n 2) 0), returns true.
(dolist (n number-list (!= (mod n 2) 0)) ; escape if true
  (println (/ n 2)))

; You can supply escape route tests with "for" and "dotimes" too.

; UNTIL SOMETHING HAPPENS OR WHILE SOMETHING IS TRUE
; ==================================================

; Test for a situation that returns nil or () when something interesting happens,
; but otherwise returns a true value, which you're not interested in.
; To repeatedly carry out a series of actions until the test fails, use "until" or "do-until":

(until (disk-full?)
  (println "Adding another file")
  (add-file)
  (inc counter))

(do-until (disk-full?)
  (println "Adding another file")
  (add-file)
  (inc counter))

; In "until", the test is made first, then the actions in the body are evaluated if the test fails.
; In "do-until", the actions in the body are evaluated first, before the test is made,
; then the test is made to see if another loop is possible.

; "while" and "do-while" are the complementary opposites of "until" and "do-until",
; repeating a block while a test expression remains true.

(while (disk-has-space)
  (println "Adding another file")
  (add-file)
  (inc counter))

(do-while (disk-has-space)
  (println "Adding another file")
  (add-file)
  (inc counter))

; Choose the do- variants of each to do the action block before evaluating the test.

; BLOCKS: GROUPS OF EXPRESSIONS ("begin", "or", "and")
; ====================================================

(begin
  (set 'a 10)
  (set 'b 20)
  (+ a b))

; Only the value of the last expression is returned, as the value of the entire block.
; "dotimes" or "dolist" constructions do not needs "begin",
; because these already allow more than one expression.

; The "and" function works through a block of expressions,
; but finishes the block immediately if one of them returns nil(false).
; To get to the end of the "and" block, every single expression has to return a true value.
; If one expression fails, evaluation of the block stops
; and newLISP ignores the remaining expressions,
; returning nil so that you know it didn't complete normally.

(and
  (set 'a 10)
  (set 'b 20)
  (< a b)
  (> a 0)
  (/ b a))   ; I get here only if all tests succeeded

; The "or" function is more easily pleased than its counterpart "and".
; The expressions are evaluated one at a time until one returns a true value.
; The rest are then ignored.
; You could use this to work through a list of important conditions,
; where any one failure is important enough to abandon the whole enterprise.
; Or, conversely, use "or" to work through a list where any one success is enough to continue.
; Whatever, remember that as soon as newLISP gets a non-nil result, the "or" function completes.

(for (x -100 100)
  (or
  (< x 1)         ; x mustn't be less than 1
  (> x 50)        ; or greater than 50
  (> (mod x 3) 0) ; or leave a remainder when divided by 3
  (> (mod x 2) 0) ; or when divided by 2
  (> (mod x 7) 0) ; or when divided by 7
  (println x)))

;-> 42

; RANDOM EXPRESSIONS: THE "amb" FUNCTION
; ======================================

; Given a series of expressions in a list, "amb" will choose and evaluate just one of them,
; but you don't know in advance which one.
; Use it to choose alternative actions at random:

(dotimes (x 20)
  (amb
  (println "Ho vinto!!!")
  (println "Ho perso")
  (println "Non so...")))

; SELECTION: "if", "cond", "case"
; ===============================

; To test for a series of alternative values, you can use "if", "cond", or "case".
; The "case" function lets you execute expressions based on the value of a switching expression.
; It consists of a series of match value/expression pairs:

(set 'n 3)
(case n
  (1 (println "uno"))
  (2 (println "due"))
  (3 (println "tre"))
  (4 (println "quattro"))
  (true (println "diverso")))

; newLISP works through the pairs in turn, seeing if n matches any of the values 1, 2, 3, or 4.
; As soon as a value matches, the expression is evaluated and the "case" function finishes,
; returning the value of the expression.
; It's a good idea to put a final pair with true
; and a catch-all expression to cope with no matches at all.
; n will always be true, if it's a number, so put this at the end.
; The potential match values are not evaluated.
; If you prefer to have a version of case that evaluates its arguments, create a macro.

; A "cond" statement in newLISP has the following structure:
; (cond
;   (test action1 action2 etc)
;   (test action1 action2 etc)
;   (test action1 action2 etc)
;   ; ...
; )

; Where each list consists of a test followed by one or more expressions
; or actions that are evaluated, if the test returns true.
; newLISP does the first test, does the actions if the test is true,
; then ignores the remaining test/action loops.
; Often the test is a list or list expression, but it can also be a symbol or a value.

(cond
  ((< x 0) (define a "impossible") )
  ((< x 10) (define a "small") )
  ((< x 20) (define a "medium") )
  ((>= x 20) (define a "large") )
)

; The version with "if";
(if
  (< x 0) (define a "impossible")
  (< x 10) (define a "small")
  (< x 20) (define a "medium")
  (>= x 20) (define a "large")
)

; If you want the action for a particular test to evaluate more than one expression,
; cond's extra set of parentheses can give you shorter code:

(cond
  ((< x 0) (define a -1) ; if would need a begin here
           (println a) ; but cond doesn't
           (define b -1))
  ((< x 10) (define a 5))
)

; LOCAL VARIABLES
; ===============

; Using "let" and "letn" functions, you can define variables that exist only inside a list.
; They aren't valid outside the list,
; and they lose their value once the list has finished being evaluated.

; The first item in a let list is a sublist containing variables (which don't have to be quoted)
; and expressions to initialize each variable.
; The remaining items in the list are expressions that can access those variables.
; It's a good idea to line up the variable/starting value pairs:

(let
  (x (* 2 2)
   y (* 3 3)
   z (* 4 4))
   ; end of initialization
  (println x)
  (println y)
  (println z))

; If you want to refer to a local variable elsewhere in the first initialization section
; use "letn" rather than "let":

(letn
  (x 2
   y (pow x 3)
   z (pow x 4))
  (println x)
  (println y)
  (println z))

; MAKE YOUR OWN FUNCTIONS
; =======================

; The basic structure of a function definition is like this:
;
; (define (func1)
;   (expression-1)
;   (expression-2)
;   ...
;   (expression-n)
; )
;
; (define (func1 v1 v2 ... vn)
;   (expression-1)
;   (expression-2)
;   ...
;   (expression-n)
; )

; When the function is called, each expression in the body is evaluated in sequence.
; The value of the last expression to be evaluated is returned as the function's value.

(define (is-3? n)
  (= n 3))

(is-3? 2)
;-> nil
(is-3? 3)
;-> true

; If you want to explicitly specify the value to return,
; add an expression at the end that evaluates to the right value:

(define (bigger a b)
  (set 'out (> a b))
  (set 'delta (- a b))
  out)

(bigger 2 3)

; To make a function return more than one value, you can return a list.

; newLISP is smart to check the function parameters:

(define (test n)
  (println n))

(test) ; no n supplied, so print nil
;-> nil

(test 1)
;-> 1

(test 1 2 3) ; 2 and 3 ignored
;-> 1

; Symbols that are defined in the function's argument list are local to the function,
; even if they exist outside the function.

; LOCAL AND GLOBAL VARIABLES
; ==========================

; Use "let" or "letn" to define a local variable,
; which doesn't affect its symbol outside the function:

(define x 10)
(define y 20)

(define (testxy)
  (let (x 15)
  (println "my x is " x))
  (set 'y 25)
  (println "my y is " y)
)

(testxy)
;-> my x is 15
;-> my y is 25
(println "outside x is " x)
;-> outside x is 10
;-> outside y is 25
(println "outside y is " y)

; Instead of "let" and "letn" you can use the "local" function.
; In this case you don't have to supply any values for the local variables.
; They're just nil until you set them:

(define (test)
  (local (a b c)
    (println a " " b " " c)
    (set 'a 1 'b 2 'c 3)
    (println a " " b " " c)))

(test)

;-> nil nil nil
;-> 1 2 3

(define a 10)
(define b 20)
(define c 30)

(define (test a b c)
    (println a " " b " " c)
    (set 'a 1 'b 2 'c 3)
    (println a " " b " " c))

(test 100 200 300)
;-> 100 200 300
;-> 1 2 3

; The comma "," is a symbol too:
(set ', "Simbolo")
(println ,)

; DEFAULT VALUES FOR PARAMETERS
; =============================

; The local variables defined in the function's argument list can have default values,
; which will be used if you don't specify values when you call the function.

(define (test (a 1) b (c 2))
  (println a " " b " " c))

; The symbols a and c will take the values 1 and 2 if you don't supply values in the call,
; but b will be nil unless you supply a value for it.

(test)
;-> 1 nil 2

; ARGUMENTS: "args"
; =================

; You can write definitions that accept any number of arguments.

(define (test v1)
  (println "the arguments were " v1 " and " (args)))

(test)
;-> the arguments were nil and ()

(test 1 2 3)
;-> the arguments were 1 and (2 3)

; Notice that v1 contains the first argument passed to the function,
; but that any remaining unused arguments are in the list returned by (args).

; With args you can write functions that accept different types of input.
; Notice how the following function can be called without arguments,
; with a string argument, with numbers, or with a list:

(define (flexible)
  (println "arguments are " (args))
  (dolist (a (args))
  (println "-> argument " $idx " is " a)))

(flexible)

;-> arguments are ()
;-> nil

(flexible "ok")
;-> arguments are ("ok")
;-> -> argument 0 is ok

(flexible 1 2 3)
;-> arguments are (1 2 3)
;-> -> argument 0 is 1
;-> -> argument 1 is 2
;-> -> argument 2 is 3

; "args" allows you to write functions that accept any number of arguments:

(define (somma)
  (apply + (args)))

(somma 1 2 3 4 5)
;-> 15

; The "doargs" function can be used instead of "dolist"
; to work through the arguments returned by "args":

(define (flexible)
  (println " arguments are " (args))
  (doargs (a) ; instead of dolist
    (println " -> argument " $idx " is " a)))

; OTHER FUNCTION TO CONTROL THE FLOW OF CODE
; ==========================================

; There are "catch" and "throw", which allow you to handle and trap errors and exceptions.
; There's "silent", which operates like a quiet version of "begin".
; Used it to hide the print of last evaluated expression.

(define (stampa)
  (println " arguments are " (args))
  (silent))

(stampa "d")
;-> arguments are ("d")

; If you want more, you can write your own language keywords, using newLISP macros,
; which can be used in the same way that you use the built-in functions.

; SCOPE OF VARIABLES
; ==================

(define (stampa)
  (println "s is " s)
  (silent))

(stampa)
;-> s is nil

(set 's "string")
(stampa)
;-> s is string

; Notice that this function refers to some unspecified symbol x.
; This may or may not exist when the function is defined or called,
; and it may or may not have a value.
; When this function is evaluated, newLISP looks for
; the nearest symbol called 's', and finds its value.

(for (s 1 3)
  (dolist (s '(sin cos tan))
  (stampa))
(stampa))

;-> s is sin
;-> s is cos
;-> s is tan
;-> s is 1
;-> s is sin
;-> s is cos
;-> s is tan
;-> s is 2
;-> s is sin
;-> s is cos
;-> s is tan
;-> s is 3

(stampa)
;-> s is string

; newLISP always gives the value of the current' x by dynamically keeping track
; of which 's' is active, even though there might be other xs lurking in the background.

; LISTS
; =====

; Quote the list to stop it being evaluated immediately:

(set 'vowels '("a" "e" "i" "o" "u"))

; FUNCTIONS TO BUILD LISTS:
; =========================

; "list" makes a new list from expressions
; "append" glues lists together to form a new list
; "cons" prepends an element to a list or makes a list
; "push" inserts a new member in a list
; "dup" duplicates an element

(set 'rhyme (list 1 2 "buckle my shoe"
'(3 4) "knock" "on" "the" "door"))

; "cons" accepts exactly two expressions, and can do two jobs:
; 1) insert the first element at the start of an existing list, or
; 2) build a new two element list.

(cons 1 2) ; makes a new list

(cons 1 '(2 3)) ; inserts an element at the start

(cons (first '(a b c)) (rest '(a b c)))
;-> (a b c)

(cons '(1 2) '(3 4))
;-> ((1 2) 3 4)

; To glue two or more lists together, use "append":

(set 'odd '(1 3 5 7) 'even '(2 4 6 8))

(set 'a '(a b (c)) 'b '(1 2 (3)))

; Difference between "list" and "append"
; a) "list" preserves the source lists when making the new list.
; b) "append" uses the elements of each source list to make a new list.

(list a b)
;-> ((a b (c)) (1 2 (3)))

(append a b)
;-> (a b (c) 1 2 (3))

; "push" is a powerful command that you can use to:
; 1) make a new list or
; 2) insert an element at any location in an existing list.

; Despite its constructive nature, it's technically a destructive function,
; because it changes the target list permanently, so use it carefully.
; It returns the whole list.

{MANUAL ERROR}

(set 'vowels '("e" "i" "o" "u"))
(push (char 97) vowels)

; The index (location) of an element in a list is zero-based.
; "push" use a third expression to specify the index of new element:

(set 'vowels '("e" "i" "o"))

(push "u" vowels -1) ; add element to the end of list

(push "a" vowels 0) ; add element in front of list

; If the symbol you supply as a list doesn't exist,
; push creates it (you don't have to declare it first).

(for (c 1 10)
  (push c number-list -1) ; doesn't fail first time!
  (println number-list))

; Create a list of randomize numbers:

(randomize (sequence 1 99))

; "push" has an opposite, "pop", which destructively removes an element from a list.
; It returns the removed element.

(set 'p '(a b c))
(pop p 1)

(set 'p '(a 2 (x y (m n) z)))
(pop p -1 2 0)

; "push" and "pop" works with string too.

; MAKE A DESTRUCTIVE FUNCTION NON-DESTRUCTIVE
; ===========================================

; Some destructive functions can be made non-destructive
; wrapping the target object into the copy function.

(set 'aList '(a b c d e f))

(replace 'c (copy aList))
;-> (a b d e f)

; The list in aList is left unchanged.

; Building lists of duplicate elements with "dup"

(dup 1 6)
;-> (1 1 1 1 1 1)

(dup '(a b c) 2))
;-> ((a b c) (a b c))

(dup "x" 6) ; a string of strings
;-> "xxxxxx"

(dup "x" 6 true) ; a list of strings
;-> ("x" "x" "x" "x" "x" "x")

; WORKING WITH WHOLE LIST
; =======================

(set 'vowels '("a" "e" "i" "o" "u"))

(dolist (v vowels)
  (print (apply upper-case (list v)) { }))
;-> A E I O U " "

; In this example, "apply" expects a function and a list,
; and uses the elements of that list as arguments to the function.
; So it repeatedly applies the upper-case function to the loop variable's value in v.
; Since upper-case works on strings but "apply" expects a list,
; we must use the list function to convert
; the current value of v (a string) in each iteration to a list.

;A better way to do this is to use "map":

(map upper-case '("a" "e" "i" "o" "u"))
;-> ("A" "E" "I" "O" "U")

; The advantage of "map" is that it both traverses the list
; and applies the function to each item of the list in one pass.
; The result is a list, too, which might be more useful for subsequent processing.

; "reverse", "sort", "randomize"

(reverse '("a" "b" "c" "d"))
;-> ("d" "c" "b" "a")

(for (c (char "a") (char "z"))
  (push (char c) alphabet -1))

(for (i 1 26)
  (push i numbers -1))

(set 'data (append alphabet numbers))
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p"
; "q" "r" "s" "t" "u" "v" "w" "x" "y" "z" 1 2 3 4 5 6 7 8 9 10 11 12
; 13 14 15 16 17 18 19 20 21 22 23 24 25 26)

(randomize data)
;-> ("l" "r" "f" "k" 17 10 "u" "e" 6 "j" 11 15 "s" 2 22 "d" "q" "b"
; "m" 19 3 5 23 "v" "c" "w" 24 13 21 "a" 4 20 "i" "p" "n" "y" 14 "g"
; 25 1 8 18 12 "o" "x" "t" 7 16 "z" 9 "h" 26)

(sort data)
;-> (1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24
; 25 26 "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o"
; "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

; To change the sort method, you can supply one built-in comparison functions, such as >.
; Adjacent objects are considered to be correctly sorted
; when the comparison function is true for each adjacent pair:

(for (c (char "a") (char "z"))
  (push (char c) alphabet -1))

alphabet
;-> ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n"
; "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

(sort alphabet >)
;-> ("z" "y" "x" "w" "v" "u" "t" "s" "r" "q" "p" "o" "n"
; "m" "l" "k" "j" "i" "h" "g" "f" "e" "d" "c" "b" "a")

; You can supply a custom sort function.
; This is a function that takes two arguments and returns true if they're in the right order
; (ie if the first should come before the second), and false if they aren't.
; Example: sort a list of file names so that the shortest name appears first.

(define (shorter? a b) ; two arguments, a and b
  (< (length a) (length b)))

  (sort (directory) shorter?)
;-> ("." ".." "libMAX.lsp" "gldemo.lsp" "newLISP-tips.lsp" "newLISP-tutorial.lsp")

; Advanced newLISPers often write a nameless function and supply it directly to the sort command:

(sort (directory) (fn (a b) (< (length a) (length b))))

; You can use either fn or lambda to define an inline or anonymous function.

; "unique" returns a copy of a list with all duplicates removed:

(set 'data '( 1 1 2 2 2 2 2 2 2 3 2 4 4 4 4))
(unique data)
;-> (1 2 3 4)

; "flat" is useful for dealing with nested lists, because it shows what they look like
; without a complicated hierarchical structure:

(set 'data '(0 (0 1 2) 1 (0 1) 0 1 (0 1 2) ((0 1) 0)))
(length data)
;-> 8

(length (flat data))
;-> 15

(flat data)
;-> (0 0 1 2 1 0 1 0 1 0 1 2 0 1 0)

; "flat" is non-destructive:

data
;-> (0 (0 1 2) 1 (0 1) 0 1 (0 1 2) ((0 1) 0)) ; still nested

; "transpose" is designed to work with matrices.
; If you imagine a list of lists as a table, it flips rows and columns:

(set 'a-list
  '(("a" 1)
    ("b" 2)
    ("c" 3)))

(transpose a-list)
;-> (("a" "b" "c")( 1 2 3))

(set 'table
'((A1 B1 C1 D1 E1 F1 G1 H1)
  (A2 B2 C2 D2 E2 F2 G2 H2)
  (A3 B3 C3 D3 E3 F3 G3 H3)))

(transpose table)
;-> ((A1 A2 A3) (B1 B2 B3) (C1 C2 C3) (D1 D2 D3) (E1 E2 E3) (F1 F2 F3) (G1 G2 G3) (H1 H2 H3))

; Reverse the values of sublist:

(set 'table '((A 1) (B 2) (C 3) (D 4) (E 5)))
;-> ((A 1) (B 2) (C 3) (D 4) (E 5))
(set 'table (transpose (rotate (transpose table))))
;-> ((1 A) (2 B) (3 C) (4 D) (5 E))

(set 'table '((A 1 q) (B 2 q) (C 3 q) (D 4 q) (E 5 q)))
(set 'table (transpose (rotate (transpose table))))
;-> ((q A 1) (q B 2) (q C 3) (q D 4) (q E 5))

; Equivalent code (but slower):

(set 'table (map (fn (i) (rotate i)) table))

; The "explode" function lets you blow up a list:

(explode (sequence 1 10))
;-> ((1) (2) (3) (4) (5) (6) (7) (8) (9) (10))

; You can specify the size of the pieces, too:

(explode (sequence 1 10) 2)
;-> ((1 2) (3 4) (5 6) (7 8) (9 10))

(explode (sequence 1 10) 3)
;-> ((1 2 3) (4 5 6) (7 8 9) (10))

; LIST ANALYSIS: TESTING AND SEARCHING
; ====================================

; The "starts-with" and "ends-with" functions test the start and ends of lists:

(for (c (char "a") (char "z"))
 (push (char c) alphabet -1))
;-> alphabet is ("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l"
; "m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

(starts-with alphabet "a") ; list starts with item "a"?
;-> true

(starts-with (join alphabet) "abc") ; convert to string and test
;-> true

(ends-with alphabet "z") ; testing the list version
;-> true

; These functions work equally well with strings, too (and they take regular expressions).

; FINDING ITEMS ON A LIST
; =======================

; Does this list contain this item?, and whether the list is a nested list or a flat one.
; "find": if you want a simple answer with a quick top-level-only search.
; "member": if you want the item and the rest of the list as well.
; "ref" and "ref-all": find the index number of the first occurrence (with nested lists too).
; "find-all": if you want a new list containing all the elements that match your search element.
; "match": if you want to know whether or not the list contains a certain pattern of elements.
; "filter", "clean", and "index" find all items that satisfy a function (built-in or user-defined).
; "exists" and "for-all" if you want to check elements in a list to see if they pass a test.
; "replace": if you want to find elements in a list purely to change them to something else
; You can also find and replace list elements using the "set-ref" function.
; If you want to know how many occurrences there are of items in the list, use "count".
; Let's look at some examples of each function:

; "find" looks through a list for an expression and returns an integer or nil.
; The integer is the index of the first occurrence of the search term in the list.

(silent
(set 'sign-of-four
  (parse (read-file "e://Lisp-Scheme/newLISP/MAX//sign-of-four.txt") {\W} 0)))

; The list is a list of string elements generated by parse,
; which breaks up a string into a list of smaller strings according to a pattern.

(if (find "Moriarty" sign-of-four) ; Moriarty anywhere?
  (println "Moriarty is mentioned")
  (println "No mention of Moriarty"))

(if (find "Lestrade" sign-of-four)
  (println "Lestrade is mentioned")
  (println "No mention of Lestrade"))

(find "Watson" sign-of-four)
; The integer returned is the first occurrence of the string element in the list.

; "find" lets you use regular expressions.
; You can find any string elements in a list that match a string pattern:

(set 'loc (find "(tea|cocaine|morphine|tobacco)" sign-of-four 1))

(if loc
  (println "The drug " (sign-of-four loc) " is mentioned.")
  (println "No trace of drugs"))

; This form of "find" look for regular expression patterns in the string elements of a list.
; You can use regular expressions again when explore strings.

(set 'word-list '("none" "scientist" "being" "sufficient" "vein" "weird"))

(find {(c)(ie)(?# i before e except after c)} word-list 0)

; Starting with "(?#" is a comments in regular expressions.
; "find" can also accept a comparison function.

; "find" finds only the first occurrence in a list.
; To find all occurrences, you could keep repeating "find" until it returns nil.

(set 'word-list '("none" "scientist" "being" "sufficient" "vein" "weird"))

(while
  (set 'temp (find {(cie)(?# i before e before c.)} word-list 0))
  (println (pop word-list temp)))

; But in this case it's much easier to use filter:
(filter (fn (w) (find {(c)(ie)} w 0)) word-list)

; Alternatively, you can use "ref-all" to get a list of indices.

; "count" wants two list and then looks through the second list
; and counts how many times each item in the first list occurs.

(count '("Sherlock" "Holmes" "Watson" "Lestrade" "Moriarty" "Moran") sign-of-four)
;-> (34 135 24 1 0 0)

; The list of results produced by "count" shows
; how many times each element in the first list occurs in the second list.

; "find" examines only flat list.
; With nested lists, you should use "ref" rather than find, because ref looks inside sublists.

(set 'maze '((1 2) (1 2 3) (1 2 3 4)))

(find 4 maze)
;-> nil

(ref 4 maze)
;-> (2 3) ; element 3 of element 2

; The member function returns the rest of the source list rather than index numbers or counts:

(set 's (sequence 1 100 7)) ; 7 times table
;-> (1 8 15 22 29 36 43 50 57 64 71 78 85 92 99)

(member 78 s)
;-> (78 85 92 99)

; There's a powerful and complicated function called match, which looks for patterns in lists.
; It accepts the wild card characters *, ?, and +, which you use to define a pattern of elements.
; + means one or more elements, * means zero or more elements, and ? means one element.
; For example, suppose you want to examine a list of random digits between 0 and 9 for patterns.
; First, generate a list of 10000 random numbers as source data:

(dotimes (c 10000) (push (rand 10) data))
;-> (7 9 3 8 0 2 4 8 3 ...)

; Next, you decide that you want to find the following pattern (1 2 3) somewhere in the list.
; Use "match" like this:

(match '(* 1 2 3 *) data)

; The list pattern (* 1 2 3 *) means any sequence of atoms or expressions (or nothing),
; followed by a 1, then a 2, then a 3, followed by any number of atoms or expressions or nothing.
; The answer returned by this match function is another list, consisting of two sublists,
; one corresponding to the first *, the other corresponding to the second:
; ((7 9 3 8 . . . 0 4 5) (7 2 4 1 . . . 3 5 5 5))
; and the pattern you were looking for first occurred in the gap between these lists
; (in fact it occurs half a dozen times later on in the list as well).
; "match" can also handle nested lists.

(set 'data '(1 2 4 3 5 6 7 8 9 6 7 1 2 3))

(match '(* 5 6 7 *) data)
;-> ((1 2 4 3) (8 9 6 7 1 2 3))

; To find all occurrences of a pattern, not just the first,
; you can use "match" in a "while" loop.

; To find and remove every 0 followed by another 0 in a list:

(set 'number-list '(2 4 0 0 4 5 4 0 3 6 2 3 0 0 2 0 0 3 3 4 2 0 0 2))

(while (set 'temp-list (match '(* 0 0 *) number-list))
  (println temp-list)
  (set 'number-list (apply append temp-list)))

; If you don't have to find elements first before replacing them:
; just use replace, which does the finding and replacing in one operation.
; And you can use match as a comparison function for searching lists.

; "find-all" is a powerful function with a number of different forms,
; suitable for searching lists, association lists, and strings.
; For list searches, you supply four arguments:
; the search key, the list, an action expression, and the functor,
; which is the comparison function you want to use for matching the search key:

(set 'food '("bread" "cheese" "onion" "pickle" "lettuce"))

{MANUAL ERROR}

(find-all "onion" food $it >)
;-> ("bread" "cheese" "lettuce")

; Here, "find-all" is looking for the string "onion" in the list food.
; It's using the > function as a comparison function,
; so it will find anything that "onion" is greater than.
; Unlike other functions that let you provide comparison functions
; (namely find, ref, ref-all, replace when used with lists, set-ref, set-ref-all, and sort),
; the comparison function must be supplied.

; The "ref" function returns the index of the first occurrence of an element in a list.
; It's particularly suited for use with nested lists, because it looks inside all the sublists.
; (Remember that "first" don't works on nested list).
; It returns the address of the first appearance of an element.

(set 'data '((1 a1 ((c1 s1) (c2 s2) (c3 s3))) (2 a2 ((c1 s1) (c2 s2) (c3 s3)))))

(ref 'c1 data)
;-> (0 2 0 0)
; in list element 0: (1 a1 ((c1 s1) (c2 s2) (c3 s3)))
; then in sublist element 2: ((c1 s1) (c2 s2) (c3 s3))
; then in sublist element 0: (c1 s1)
; then in sublist element 0: (c1)

; "ref-all" does a similar job, and returns a list of addresses:

(ref-all 'c1 data)
;-> ((0 2 0 0) (1 2 0 0))

; These functions can also accept a comparison function.
; Use "ref" and "ref-all" when you're searching for something in a nested list.
; If you want to replace it when you've found it, use the "set-ref" and "set-ref-all" functions.

; FILTERING LISTS: "filter", "clean", AND "index"
; ===============================================

; Another way of finding things in lists is to filter the list.
; You can create a filter that keeps only the stuff you want, removing the unwanted stuff away.

; The functions filter and index have the same syntax.
; "filter" returns the list elements;
; "index" returns the index numbers (indices) of the wanted elements.
; These functions don't work on nested lists.

; The functions "filter", "clean", and "index" use another function for testing elements:
; the element appears in the results list according to whether it passes the test or not.
; You can either use a built-in function or define your own.
; Typically, functions that tests and return true or false (sometimes called predicate functions)
; have names ending with question marks:
; NaN? array? atom? context? directory? empty? file? float? global? integer? lambda? legal?
; list? macro? nil? null? number? primitive? protected? quote? string? symbol? true? zero?

; Use "filter" to remove floating-point numbers from data:

(set 'data '(0 1 2 3 4.01 5 6 7 8 9.1 10))

(filter integer? data)
;-> (0 1 2 3 5 6 7 8 10)

; "filter" has a complementary called "clean" which removes elements that satisfy the test:

(set 'data '(0 1 2 3 4.01 5 6 7 8 9.1 10))

(clean integer? data)
;-> (4.01 9.1)

; Using custom function with "filter":

(set 'data '("pappa" "panna" "canna" "sella" "nonna" "colla"))

(filter (fn (s) (find "nn" s)) data)
;-> ("panna" "nanna" "nonna")

; Use "index" when you want to access the list elements by index number rather than their values.
; "ref" found the index of only the first occurrence.
; "index" return the index numbers of every occurrence of an element.

(set 'word-list '("agencies" "being" "believe" "ceiling"
"conceit" "conceive" "deceive" "financier" "foreign"
"neither" "receive" "science" "sufficient" "their" "vein"
"weird"))

(define (i-before-e-after-c? wd) ; a predicate function
(find {(c)(ie)(?# i before e after c...)} wd 0))

(index i-before-e-after-c? word-list)
;-> (0 7 11 12)
; agencies, financier, science, sufficient

; Remember that lists can contain nested lists,
; and that some functions won't look inside the sub-lists:

(set 'maze '((1 2.1) (1 2 3) (1 2 3 4)))

(filter integer? maze)
;-> () ; I was sure it had integers...

(filter list? maze)
;-> ((1 2.1) (1 2 3) (1 2 3 4)) ; ah yes, they're sublists!

(filter integer? (flat maze))
;-> (1 1 2 3 1 2 3 4) ; one way to do it...

; TESTING LISTS
; =============

; The "exists" and "for-all" functions check elements in a list to see if they pass a test.
; "exists" returns either the first element in the list that passes the test,
; or nil if none of them do.

(exists string? '(1 2 3 4 5 6 "hello" 7))
;-> "hello"

(exists string? '(1 2 3 4 5 6 7))
;-> nil

; "for-all" returns either true or nil.
; If every list element passes the test, it returns true.

(for-all number? '(1 2 3 4 5 6 7))
;-> true

(for-all number? '("zero" 2 3 4 5 6 7))
;-> nil

; SEARCHING ON LISTS
; ==================

; "find", "ref", "ref-all" and "replace" look for items in lists.
; Usually, you use these functions to find items that equal what you're looking for.
; However, equality is just the default test:
; all these functions can accept an optional comparison function
; that's used instead of a test for equality.
; This means that you can look for list elements that satisfy any test.

(set 's (sequence 1000 1010))
;-> (1000 1001 1002 1003 1004 1005 1006 1007 1008 1009 1010)
(set 'n 1002)
; find the first something that n is less than:
(find n s <)
;-> 3, the index of 1003 in s

; You can write your own comparison function:
(set 'a-list '("elephant" "antelope" "giraffe" "dog" "cat" "lion" "shark" ))

(define (longer? x y)
  (> (length x) (length y)))

(find "tiger" a-list longer?)
;-> 3 ; "tiger" is longer than element 3, "dog"

; You could supply an anonymous (or lambda) function as part of the "find" function:

(find "tiger" a-list (fn (x y) (> (length x) (length y))))

; You can also use comparison functions with "ref", "ref-all", and "replace".
; A comparison function can be any function that takes two values and returns true or false.

(set 'data '(31 23 -63 53 8 -6 -16 71 -124 29))

(define (my-func x y)
  (and (> x y) (> y 6)))

(find 15 data my-func)
;-> 4 ; there's an 8 at index location 4

; SUMMARY: COMPARE AND CONTRAST
; =============================

; To summarize these contains functions, here they are in action:

(set 'data
'("this" "is" "a" "list" "of" "strings" "not" "of" "integers"))

(find "of" data) ; equality is default test
;-> 4 ; index of first occurrence

(ref "of" data) ; where is "of"?
;-> (4) ; returns a list of indexes

(ref-all "of" data)
;-> ((4) (7)) ; list of address lists

(filter (fn (x) (= "of" x)) data) ; keep every of
;-> ("of" "of")

(index (fn (x) (= "of" x)) data) ; indexes of the of's
;-> (4 7)

(match (* "of" * "of" *) data) ; three lists between the of's
;-> (("this" "is" "a" "list") ("strings" "not") ("integers"))

(member "of" data) ; and the rest
;-> ("of" "strings" "not" "of" "integers")

(count (list "of") data) ; remember to use two lists
;-> (2) ; returns list of counts

; SELECTING ITEMS FROM LISTS
; ==========================

; There are various functions for getting at the information stored in a list:
; - "first" gets the first element
; - "rest" gets all but the first element
; - "last" returns the last element
; - "nth" gets the nth element
; - "select" selects certain elements by index
; - "slice" extracts a sublist
; The "first" and "rest" functions are better names for the traditional LISP "car" and "cdr".

; PICKING ELEMENTS: "nth", "select", AND "slice"
; ==============================================

; "nth" gets the nth element of a list:

(set 'phrase '("the" "quick" "brown" "fox" "jumped" "over" "the" "lazy" "dog"))
(nth 1 phrase)
;-> "quick"

; "nth" can also look inside nested lists, because it accepts more than one index number:

(set 'zoo '(("ape" 3) ("bat" 47) ("lion" 4)))
(nth '(2 1) zoo) ; item 2, then subitem 1
;-> 4

; If you want to pick a group of elements out of a list, you'll find "select" useful.
; You can use it in two different forms.
; The first form lets you supply a sequence of loose index numbers:

(set 'phrase '("the" "quick" "brown" "fox" "jumped" "over" "the" "lazy" "dog"))
(select phrase 0 -2 3 4 -4 6 1 -1)
;-> ("the" "lazy" "fox" "jumped" "over" "the" "quick" "dog")

; A positive number selects an element by counting forward from the beginning,
; and a negative number selects by counting backwards from the end:

;    0     1       2       3     4        5      6     7      8
; ("the" "quick" "brown" "fox" "jumped" "over" "the" "lazy" "dog")
;   -9    -8      -7      -6    -5       -4     -3    -2     -1

; You can also supply a list of index numbers to select.
; For example, you can use the "rand" function
; to generate a list of 20 random numbers between 0 and 8,
; and then use this list to select elements from phrase at random:

(select phrase (rand 9 20))
;-> ("jumped" "lazy" "over" "brown" "jumped" "dog" "the" "dog" "dog"
; "quick" "the" "dog" "the" "dog" "the" "brown" "lazy" "lazy" "lazy" "quick")

; Notice the duplicates. If you had written this instead:
(randomize phrase)
; there would be no duplicates: (randomize phrase) shuffles elements without duplicating them.

; "slice" lets you extract sections of a list.
; Supply it with the list, followed by one or two numbers.
; The first number is the start location.
; If you miss out the second number, the rest of the list is returned.
; The second number, if positive, is the number of elements to return.

(slice (explode "schwarzwalderkirschtorte") 7)
;-> ("w" "a" "l" "d" "e" "r" "k" "i" "r" "s" "c" "h" "t" "o" "r" "t" "e")

(slice (explode "schwarzwalderkirschtorte") 7 6)
;-> ("w" "a" "l" "d" "e" "r")

; If negative, the second number specifies an element at the other end of the slice
; counting backwards from the end of the list, -1 being the final element:

(slice (explode "schwarzwalderkirschtorte") 19 -1)
;-> ("t" "o" "r" "t")

; It reaches as far as - but doesn't include - the element you specify.

; IMPLICIT ADDRESSING
; ===================

; newLISP provides a faster and more efficient way of selecting and slicing lists.
; Instead of using a function, you can use index numbers and lists together.
; This technique is called implicit addressing.

; SELECTING ELEMENTS USING IMPLICIT ADDRESSING
; ============================================

; As an alternative to using nth,
; put the list's symbol and an index number in a list, like this:

(set 'r '("the" "cat" "sat" "on" "the" "mat"))
(r 1) ; element index 1 of r
;-> "cat"

(nth 1 r) ; the equivalent using nth
;-> "cat"

(r 0)
;-> "the"

(r -1)
;-> "mat"

; With a nested list, you can supply a sequence of index numbers
; that identify the list in the hierarchy:

(set 'zoo '(("ape" 3) ("bat" 47) ("lion" 4))) ; three sublists in a list

(zoo 2 1)
;-> 4

(nth '(2 1) zoo) ; the equivalent using nth
;-> 4

; SELECTING A SLICE USING IMPLICIT ADDRESSING
; ===========================================

; You can also use implicit addressing to get a slice of a list.
; Put one or two numbers to define the slice, before the list's symbol, inside a list:

(set 'alphabet '("a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l"
"m" "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"))

(13 alphabet) ; start at 13, get the rest
;-> ("n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

(slice alphabet 13) ; equivalent using slice
;-> ("n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z")

(3 7 alphabet) ; start at 3, get 7 elements
;-> ("d" "e" "f" "g" "h" "i" "j")

(slice alphabet 3 7) ; equivalent using slice
;-> ("d" "e" "f" "g" "h" "i" "j")

; How to remember the difference between the two types of implicit addressing?
; "sLice" numbers go in the Lead, "sElect" numbers go at the End.

; LIST SURGERY
; ============

; SHORTENING LISTS
; ================

; To shorten a list, by removing elements from the front or back, use "chop" or "pop".
; "chop" makes a copy and works from the end.
; "pop" changes the original and works from the front.
; "chop" returns a new list by cutting the end off the list:

(set 'vowels '("a" "e" "i" "o" "u"))
(chop vowels)
;-> ("a" "e" "i" "o")

(println vowels)
;-> ("a" "e" "i" "o" "u") ; original unchanged

; An optional third argument for "chop" specifies how many elements to remove:

(chop vowels 3)
;-> ("a" "e")

(println vowels)
;-> ("a" "e" "i" "o" "u") ; original unchanged

; "pop" (the opposite of "push") permanently removes the specified element from the list.
; It works with list indices rather than lengths:

(set 'vowels '("a" "e" "i" "o" "u"))

(pop vowels) ; defaults to 0-th element
(println vowels)
;-> ("e" "i" "o" "u")

(pop vowels -1)
(println vowels)
;-> ("e" "i" "o")

; You can also use replace to remove items from lists.

; CHANGING ITEMS IN LISTS
; =======================

; You can easily change elements in lists, using the following functions:
; "replace" changes or removes elements
; "swap" swaps two elements
; "setf" sets the value of an element
; "set-ref" searches a nested list and changes an element
; "set-ref-all" searches for and changes every element in a nested list
; These are destructive functions (just like "push", "pop", "reverse", "sort")
; and change the original lists, so use them carefully.

; To set the nth element of a list (or array) to another value, use the versatile "setf" command:

(set 'data (sequence 100 110))
;-> (100 101 102 103 104 105 106 107 108 109 110)

(setf (data 5) 0)
;-> 0

data
;-> (100 101 102 103 104 0 106 107 108 109 110)

; Notice how the "setf" function returns
; the value that has just been set, 0, rather than the changed list.
; This example uses the faster implicit addressing.
; You could of course use nth to create a reference to the nth element first:

(set 'data (sequence 100 110))
;-> (100 101 102 103 104 105 106 107 108 109 110)

(setf (nth 5 data) 1)
;-> 1

data
;-> (100 101 102 103 104 1 106 107 108 109 110)

; "setf" must be used on a list or array or element stored in a symbol.
; You can't pass raw data to it:

(setf (nth 5 (sequence 100 110)) 1)
;-> ERR: no symbol reference found

(setf (nth 5 (set 's (sequence 100 110))) 1)
; 'temporary' storage in symbol s
;-> 1

s
;-> (100 101 102 103 104 1 106 107 108 109 110)

; Sometimes when you use "setf", you want to refer to the old value when setting the new value.
; To do this, use the system variable "$it".
; During a "setf" expression, "$it" contains the old value.
; So to increase the value of the first element of a list by 1:

(set 'lst (sequence 0 9))
;-> (0 1 2 3 4 5 6 7 8 9)

(setf (lst 0) (+ $it 1))
;-> 1
lst
;-> (1 1 2 3 4 5 6 7 8 9)

; You can do this with strings too. Here's how to 'increment' the first letter of a string:

(set 'str "cream")
;-> "cream"

(setf (str 0) (char (inc (char $it))))
;-> "d"
str
;-> "dream"

; REPLACING INFORMATION: "replace"
; ================================

; You can use "replace" to change or remove elements in lists.
; Specify the element to change and the list to search in,
; and also a replacement if there is one.

(set 'data (sequence 1 10))

(replace 5 data) ; no replacement specified
;-> (1 2 3 4 6 7 8 9 10) ; the 5 has gone

(set 'data '(("a" 1) ("b" 2)))
(replace ("a" 1) data) ; data is now (("b" 2))

; Every matching item is deleted.

; "replace" returns the changed list:

(set 'data (sequence 1 10))

(replace 5 data 0) ; replace 5 with 0
;-> (1 2 3 4 0 6 7 8 9 10)

; The replacement can be a simple value, or any expression that returns a value.

(set 'data (sequence 1 10))

(replace 5 data (sequence 0 5))
;->(1 2 3 4 (0 1 2 3 4 5) 6 7 8 9 10)

; "replace" updates a set of system variables $0, $1, $2, up to $15,
; and the special variable $it, with the matching data.
; For list replacements, only $0 and $it are used, and they hold the value of the found item,
; suitable for using in the replacement expression.

(replace 5 data (list (dup $0 2))) ; $0 holds 5
;-> (1 2 3 4 ((5 5)) 6 7 8 9 10)

; For more about system variables and their use with string replacements, see System variables.

; If you don't supply a test function, = is used:

(set 'data (sequence 1 10))

(replace 5 data 0 =)
;-> (1 2 3 4 0 6 7 8 9 10)

(set 'data (sequence 1 10))

(replace 5 data 0)              ; = is assumed
;-> (1 2 3 4 0 6 7 8 9 10)

; You can make "replace" find elements that pass a different test, other than equality.
; Supply the test function after the replacement value:

(set 'data (randomize (sequence 1 10)))
;-> (5 10 6 1 7 4 8 3 9 2)

(replace 5 data 0 <)  ; replace everything that 5 is less than
;-> (5 0 0 1 0 4 0 3 0 2)

; The test can be any function that compares two values and returns a true or false value.
; This can be amazingly powerful. Suppose you have a list of names and their scores:

(set 'scores '(
   ("adrian" 234 27 342 23 0)
   ("hermann" 92 0 239 47 134)
   ("neville" 71 2 118 0)
   ("eric" 10 14 58 12 )))

; How easy is it to add up the numbers for all those people whose scores included a 0?
; Well, with the help of the 'match' function, this easy:

(replace '(* 0 *) scores (list (first $0) (apply + (rest $0))) match)

(("adrian" 626)
 ("hermann" 512)
 ("neville" 191)
 ("eric" 10 14 58 12))

; For each matching element, the replacement builds a list with name and sum of the scores.
; "match" is employed as a comparator function:
; only matching list elements are selected for totalization,
; so Eric's scores weren't totalled since he didn't manage to score 0.

; MODIFYING LISTS
; ===============

; FIND AND REPLACE MATCHING ELEMENTS: "set-ref"
; =============================================

; The "set-ref" function lets you modify the first matching element in a list:

(set 'l '((aaa 100) (bbb 200)))
;-> ((aaa 100) (bbb 200))

; To change that 200 to a 300, use "set-ref" like this:

(set-ref 200 l 300)               ; change the first 200 to 300
;-> ((aaa 100) (bbb 300))

; FIND AND REPLACE ALL MATCHING ELEMENTS: "set-ref-all"
; =====================================================

; "set-ref" finds the first matching element in a nested list and changes it.
; "set-ref-all" can replace every matching element.
; Consider the following nested list that contains data on the planets:

 (("Mercury"
      (p-name "Mercury")
      (diameter 0.382)
      (mass 0.06)
      (radius 0.387)
      (period 0.241)
      (incline 7)
      (eccentricity 0.206)
      (rotation 58.6)
      (moons 0))
  ("Venus"
      (p-name "Venus")
      (diameter 0.949)
      (mass 0.82)
      (radius 0.72)
      (period 0.615)
      (incline 3.39)
      (eccentricity 0.0068)
      (rotation -243)
      (moons 0))
  ("Earth"
      (p-name "Earth")
      (diameter 1)
;      ...
  )

; How could you change every occurrence of that 'incline' symbol to be 'inclination'?
; It's easy using "set-ref-all":

(set-ref-all 'incline planets 'inclination)   ; key - list - replacement

; This returns the list with every 'incline changed to 'inclination.

; As with "replace", the default test for finding matching elements is equality.
; But you can supply a different comparison function.
; This is how you could examine the list of planets and change every entry
; where the moon's value is greater than 9 to say "lots" instead of the actual number.

(set-ref-all '(moons ?) planets (if (> (last $0) 9) "lots" (last $0)) match)

; The replacement expression compares the number of moons
; (the last item of the result which is stored in $0)
; and evaluates to "lots" if it's greater than 9.
; The search term is formulated (using match-friendly wildcard syntax),
; to match the choice of comparison function.

; The "swap" function can exchange two elements of a list, or the values of two symbols.
; This changes the original list:

(set 'fib '(1 2 1 3 5 8 13 21))
(swap (fib 1) (fib 2))
;-> 2
fib
;-> (1 1 2 3 5 8 13 21) ; is 'destructive'

; Usefully, "swap" can also swap the values of two symbols without a temporary variable.

(set 'x 1 'y 2)
(swap x y)
;-> 1
x
;-> 2
y
;-> 1

; This parallel assignment can make life easier sometimes.
; See this iterative version to find the Fibonacci numbers:

(define (fibonacci n)
  (let (current 1 next 0)
    (dotimes (j n)
    (print current " ")
    (inc next current)
    (swap current next))))

(fibonacci 200)
;-> 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597 2584 4181 6765

; WORKING WITH TWO OR MORE LISTS
; ==============================

; How many items are in both lists?
; Which items are in only one of the lists?
; How often do the items in this list occur in another list?

; Here are some useful functions for answering these questions:
; "difference" finds the set difference of two lists
; "intersect" finds the intersection of two lists
; "count" counts the number of times each element in one list occurs in a second list

; For example, to calculate how many vowels there are in a sentence:
; put the known vowels in one list, and the sentence in another
; (use explode to turn the sentence into a list of characters)

(count '("a" "e" "i" "o" "u") (explode "the quick brown fox jumped over the lazy dog"))
;-> (1 4 1 4 2)

(count (explode "aeiou") (explode "the quick brown fox jumped over the lazy dog"))
;-> (1 4 1 4 2)

; The result, (1 4 1 4 2), means that there are 1 a, 4 e, 1 i, 4 o, and 2 u in the sentence.

; "difference" and "intersect" are functions that will remind you of those Venn diagrams.
; In newLISP lists can represent sets.

; "difference" returns a list of elements in the first list that are not in the second list.

(set 'd1 (directory "/Users/me/Library/Application Support/BBEdit"))
(set 'd2 (directory "/Users/me/Library/Application Support/TextWrangler"))

(difference d1 d2)
;-> ("AutoSaves" "Glossary" "HTML Templates" "Stationery" "Text Factories")

(difference d2 d1)
;-> ()

; It's important which list you put first!
; There are five files or directories in directory d1 that aren't in directory d2.
; But there are no files or directories in d2 that aren't also in d1.

; The intersect function finds the elements that are in both lists.

(intersect d2 d1)
;-> ("." ".." "Language Modules" "Menu Scripts" "Plug-Ins" "Scripts" "Unix Support")

; Both these functions can take an additional argument,
; which controls whether to keep or discard any duplicate items.

; You could use the "difference" function to compare two revisions of a text file.
; Use parse (Parsing strings) to split the files into lines first:

(set 'd1 (parse (read-file "/Users/me/f1-(2006-05-29)-1.html") "\r" 0))
(set 'd2 (parse (read-file "/Users/me/f1-(2006-05-29)-6.html") "\r" 0))

(println (difference d1 d2))
;-> (" <p class=\"body\">You could use this function to find" ...)

; ASSOCIATION LISTS
; =================

; There are various techniques available in newLISP for storing information.
; One very easy and effective technique is to use a list of sublists,
; where the first element of each sublist is a key.
; This structure is known as an association list.
; You could also think of it as a dictionary,
; since you look up information in the list by first looking for the key element.
; You can also implement a dictionary using newLISP's contexts.

; You can make an association list using basic list functions.
; For example, you can supply a hand-crafted quoted list:

(set 'ascii-chart '(("a" 97) ("b" 98) ("c" 99)
; ..
))

; Or you could use functions like list and push to build the association list:

(for (c (char "a") (char "z"))
  (push (list (char c) c) ascii-chart -1))

ascii-chart
;-> (("a" 97) ("b" 98) ("c" 99) ... ("z" 122))

; It's a list of sublists, and each sublist has the same format.
; The first element of a sublist is the key.
; The key can be a string, a number, or a symbol.
; You can have any number of data elements after the key.

(set 'sol-sys
  '(("Mercury" 0.382 0.06 0.387 0.241 7.00 0.206 58.6 0)
    ("Venus" 0.949 0.82 0.72 0.615 3.39 0.0068 -243 0)
    ("Earth" 1.00 1.00 1.00 1.00 0.00 0.0167 1.00 1)
    ("Mars" 0.53 0.11 1.52 1.88 1.85 0.0934 1.03 2)
    ("Jupiter" 11.2 318 5.20 11.86 1.31 0.0484 0.414 63)
    ("Saturn" 9.41 95 9.54 29.46 2.48 0.0542 0.426 49)
    ("Uranus" 3.98 14.6 19.22 84.01 0.77 0.0472 -0.718 27)
    ("Neptune" 3.81 17.2 30.06 164.8 1.77 0.0086 0.671 13)
    ("Pluto" 0.18 0.002 39.5 248.5 17.1 0.249 -6.5 3)
   )
; 0: Planet name 1: Equator diameter (earth) 2: Mass (earth)
; 3: Orbital radius (AU) 4: Orbital period (years)
; 5: Orbital Incline Angle 6: Orbital Eccentricity
; 7: Rotation (days) 8: Moons
)

; A good practice: include useful comments within the code.
; The planet name is the key.

; newLISP offers ad-hoc functions to work with these dictionary or association lists:
; "assoc" finds the first occurrence of the keyword and return the sublist
; "lookup" looks up the value of a keyword inside the sublist

; Both "assoc" and "lookup" take the first element of the sublist, the key,
; and retrieve some data from the appropriate sublist.

; Here's "assoc" in action, returning the sublist:

(assoc "Uranus" sol-sys)
;-> ("Uranus" 3.98 14.6 19.22 84.01 0.77 0.0472 -0.718 27)

; And here's "lookup", which gets data out of an element of one of the sublists
; (or the final element if you don't specify one):

(lookup "Uranus" sol-sys)
;-> 27, moons - value of the final element of the sublist

(lookup "Uranus" sol-sys 2)
;-> 14.6, element 2 of the sublist is the planet's mass

; This saves you having to use a combination of "assoc" and "nth".

; One problem that you might have when working with association lists with long sublists
; is that you can't remember what the index numbers represent.
; Here's one solution:

(constant 'orbital-radius 3)
(constant 'au 149598000) ; 1 au in km
(println "Neptune's orbital radius is "
  (mul au (lookup "Neptune" sol-sys orbital-radius))
  " kilometres")
;-> Neptune's orbital radius is 4496915880 kilometres

; Here we've defined orbital-radius and au (astronomical unit) as constants.
; You can use orbital-radius to refer to the right column of a sublist.
; This also makes the code easier to read.
; The "constant" function is like set, but the symbol you supply is protected
; against accidental change by another use of "set".
; You can change the value of the symbol only by using the "constant" function again.

; With these constants, here's an expression that lists
; the different orbits of the planets (in km):

(silent
(dolist (planet-data sol-sys) ; go through list
  (set 'planet (first planet-data)) ; get name
  (set 'orb-rad (lookup planet sol-sys orbital-radius)) ; get radius
  (println (format "%-8s %12.2f %18.0f" planet orb-rad (mul au orb-rad))))
)

; To manipulate floating-point numbers,
; use the floating-point arithmetic operators "add", "sub", "mul", "div".
; The operators "+", "-", "*", and "/" works with (and convert values to) integers.

; REPLACING SUBLISTS IN ASSOCIATION LISTS
; =======================================

; To change values stored in an association list:
; 1) use the "assoc" function to find the matching sublist, then
; 2) use "setf" on that sublist to change the value to a new sublist.

(setf (assoc "Jupiter" sol-sys) '("Jupiter" 11.2 318 5.20 11.86 1.31 0.0484 0.414 64))

; ADDING NEW ITEMS TO ASSOCIATION LISTS
; =====================================

; Association lists are ordinary lists: you can use all the newLISP techniques with them.
; Want to add a new 10th planet to our sol-sys list? Just use push:

(push '("Sedna" 0.093 0.00014 .0001 502 11500 0 20 0) sol-sys -1)

; Check that it was added OK with:

(assoc "Sedna" sol-sys)
;-> ("Sedna" 0.093 0.00014 0.0001 502 11500 0 20 0)

; You can use sort to sort the association list.
; (Remember though that sort changes lists permanently.)
; Here's a list of planets sorted by mass.
; Since you don't want to sort them by name,
; you use a custom sort to compare the mass (index 2) values of each pair:

(constant 'mass 2)
(sort sol-sys (fn (x y) (> (x mass) (y mass))))

(println sol-sys)

;-> ("Jupiter" 11.2 318 5.2 11.86 1.31 0.0484 0.414 63)
;-> ("Saturn" 9.41 95 9.54 29.46 2.48 0.0542 0.426 49)
;-> ("Neptune" 3.81 17.2 30.06 164.8 1.77 0.0086 0.671 13)
;-> ("Uranus" 3.98 14.6 19.22 84.01 0.77 0.0472 -0.718 27)
;-> ("Earth" 1 1 1 1 0 0.0167 1 1)
;-> ("Venus" 0.949 0.82 0.72 0.615 3.39 0.0068 -243 0)
;-> ("Mars" 0.53 0.11 1.52 1.88 1.85 0.0934 1.03 2)
;-> ("Mercury" 0.382 0.06 0.387 0.241 7 0.206 58.6 0)
;-> ("Pluto" 0.18 0.002 39.5 248.5 17.1 0.249 -6.5 3)

; You can also easily combine the data in the association list with other lists:

; restore to standard order - sort by orbit radius

(sort sol-sys (fn (x y) (< (x 3) (y 3))))

; define Unicode symbols for planets

(set 'unicode-symbols
  '(("Mercury" 0x263F )
    ("Venus" 0x2640 )
    ("Earth" 0x2641 )
    ("Mars" 0x2642 )
    ("Jupiter" 0x2643 )
    ("Saturn" 0x2644 )
    ("Uranus" 0x2645 )
    ("Neptune" 0x2646 )
    ("Pluto" 0x2647)))

(map (fn (planet) (println (char (lookup (first planet) unicode-symbols))
                   "\t" (first planet))) sol-sys)

{MANUAL ERROR - UTF8 only some chars}

; Here we've created a temporary inline function that map applies to each planet in sol-sys:
; lookup finds the planet name and retrieves the Unicode symbol for that planet
; from the unicode-symbols association list.

; You can remove an element from an association list with pop-assoc:

(pop-assoc (sol-sys "Pluto"))

; This removes the Pluto element from the list.

; newLISP offers powerful data storage facilities in the form of contexts,
; which you can use for building dictionaries, hash tables, objects, and so on.
; You can use association lists to build dictionaries
; and work with the contents of dictionaries using association list functions.
; You can also use a database engine.

; "find-all" AND ASSOCIATION LISTS
; ================================

; Another form of "find-all" lets you
; search an association list for a sublist that matches a pattern.
; You can specify the pattern with wildcard characters.
; For example, here's an association list:

(set 'symphonies
  '((Beethoven 9)
    (Haydn 104)
    (Mozart 41)
    (Mahler 10)
    (Wagner 1)
    (Schumann 4)
    (Shostakovich 15)
    (Bruckner 9)))

; To find all the sublists that end with 9, use the match pattern (? 9),
; where the question mark matches any single item:

(find-all '(? 9) symphonies)
;-> ((Beethoven 9) (Bruckner 9))

; You can also use this form with an additional action expression after the association list:

(find-all '(? 9) symphonies
  (println (first $0) { wrote 9 symphonies.}))

;-> Beethoven wrote 9 symphonies.
;-> Bruckner wrote 9 symphonies.

; STRINGS
; =======

; To use UTF8 on windows you must
; 1) use newLISP utf8 enabled
; 2) run the command !chcp 65001

; String-handling tools are an important part of a programming language.
; newLISP has many easy to use and powerful string handling tools.
; You can easily add more tools to your toolbox if your particular needs aren't met.

; STRINGS IN CODE
; ===============

; You can write strings in three ways:
; - enclosed in double quotes
; - embraced by curly braces
; - marked-up by markup codes
; like this:

(set 's "this is a string")
(set 's {this is a string})
(set 's [text]this is a string[/text])

; All three methods can handle strings of up to 2048 characters.
; For strings longer than 2048 characters,
; always use the [text] and [/text] tags to enclose the string.
; Always use the first method, quotation marks, if you want escaped characters
; such as \n and \t, or code numbers (\046), to be processed.

(set 's "this is a string \n with two lines")
(println s)
;-> this is a string
;-> with two lines

(println "\110\101\119\076\073\083\080") ; decimal ASCII
;-> newLISP

(println "\x6e\x65\x77\x4c\x49\x53\x50") ; hex ASCII
;-> newLISP

; The double quotation and backslash character must be escaped with backslashes.

; Use the second method, braces (or 'curly brackets') when:
; 1) strings are shorter than 2048 characters
; 2) and you don't want any escaped characters to be processed

(set 's {strings can be enclosed in \n"quotation marks" \n })
(println s)
;-> strings can be enclosed in \n"quotation marks" \n

; This is a really useful way of writing strings because:
; 1) you don't have to worry about putting backslashes before every quotation character,
; 2) or backslashes before other backslashes.
; You can nest pairs of braces inside a braced string, but you can't have an unmatched brace.

; Using braces for strings face the correct way to work (which plain dumb quotation marks don't).
; Maybe your text editor might be able to balance and match them.

; The third method, using [text] and [/text] markup tags,
; is intended for longer text strings running over many lines.
; It is used automatically by newLISP when it outputs large amounts of text.
; Again, you don't have to worry about which characters you can and can't include:
; You can put anything you like in, with the obvious exception of [/text].
; Escape characters such as \n or \046 aren't processed either.

(set 'novel (read-file {my-latest-novel.txt}))
;->  [text]
;->  It was a dark and "stormy" night...
;->  ...
;->  The End.
;->  [/text]

; If you want to know the length of a string, use "length":

(length novel)
;-> 575196

; Strings of millions of characters can be handled easily by newLISP.
; Rather than "length", use "utf8len" to get the length of a Unicode string:

(utf8len (char 955))
;-> 1

(length (char 955))
;-> 2

; MAKING STRINGS
; ==============

; Many functions, such as the file-reading ones, return strings or lists of strings for you.
; But if you want to build a string from scratch, one way is to start with the "char" function.
; This converts the supplied number to the equivalent character string with that code number.
; It can also reverse the operation,
; converting the supplied character to its equivalent code number.

(char 33)
;-> "!"

(char "!")
;-> 33

(char 955) ; Unicode lambda character, decimal code
;-> "��"
;-> "\206\187"

(char 0x2643) ; Unicode symbol for Jupiter, hex code
;-> "���"
;-> "\226\153\131"


; Test UTF8:

(println (char 937))               ; displays Greek uppercase omega

(println (lower-case (char 937)))  ; displays lowercase omega

; Note: Only the output of println will be displayed as a character;
;       println's return value will appear on the console as a multi-byte ASCII character.

;-> You can use "char" to build strings in other ways:

(join (map char (sequence (char "a") (char "z"))))
;-> "abcdefghijklmnopqrstuvwxyz"

; "join" can also take a separator when building strings:

(join (map char (sequence (char "a") (char "z"))) "-")
;-> "a-b-c-d-e-f-g-h-i-j-k-l-m-n-o-p-q-r-s-t-u-v-w-x-y-z"

;-> Similar to "join" is "append", which works directly on strings:

(append "con" "cat" "e" "nation")
;-> "concatenation"

; But even more useful is "string", which turns
; any collection of numbers, lists, and strings into a single string:

(string '(sequence 1 10) { produces } (sequence 1 10) "\n")
;-> (sequence 1 10) produces (1 2 3 4 5 6 7 8 9 10)

; The "string" function, combined with the various string markers such as braces and markup tags,
; is one way to include the values of variables inside strings:

(set 'x 42)

(string {the value of } 'x { is } x)
;-> "the value of x is 42"

; You can also use "format" to combine strings and symbol values.

; "dup" makes copies:

(dup "spam" 10)
;-> "spamspamspamspamspamspamspamspamspamspam"

; And "date" makes a date string:
(date)

;-> "Fri Oct 26 09:52:38 2018"
(nth 0 (date))
;-> "F"

; STRING SURGERY
; ==============

; Some string function are destructive: they change the string permanently (modify information).
; Others are constructive: producing a new string and leaving the old one unharmed.

; reverse is destructive:

(set 't "a hypothetical one-dimensional subatomic particle")

(reverse t)
;-> "elcitrap cimotabus lanoisnemid-eno lacitehtopyh a"

; Now t has changed for ever.

; The case-changing functions aren't destructive:

(set 't "a hypothetical one-dimensional subatomic particle")

(upper-case t)
;-> "A HYPOTHETICAL ONE-DIMENSIONAL SUBATOMIC PARTICLE"

(lower-case t)
;-> "a hypothetical one-dimensional subatomic particle"

(title-case t)
;-> "A hypothetical one-dimensional subatomic particle"

; SUBSTRING
; =========

;-> The functions "first", "rest" and "last" works with string too:

(set 't "a hypothetical one-dimensional subatomic particle")

(first t)
;-> "a"

(rest t)
;-> " hypothetical one-dimensional subatomic particle"

(last t)
;-> "e"

(t 2) ; counting from 0
;-> "h"

;-> You can also use this technique with lists.

; STRING SLICES
; =============

; "slice" gives you a new slice of an existing string:
; counting either forwards from the cut (positive integers) or
; backwards from the end (negative integers),
; for the given number of characters or to the specified position:

(set 't "a hypothetical one-dimensional subatomic particle")

(slice t 15 13)
;-> "one-dimension"

(slice t -8 8)
;-> "particle"

(slice t 2 -9)
;-> "hypothetical one-dimensional subatomic"

(slice "schwarzwalderkirschtorte" 19 -1)
;-> "tort"

; Shortcut: put the required start and length before the string in a list:

(15 13 t)
;-> "one-dimension"

(0 14 t)
;-> "a hypothetical"

; To pick some characters for a new string use the "select" function,
; followed by a sequence of character index numbers:

(set 't "a hypothetical one-dimensional subatomic particle")

(select t 3 5 24 48 21 10 44 8)
;-> "yosemite"

(select t (sequence 1 49 12)) ; every 12th char starting at 1
;-> " lime"

; which is good for code/decode secret text messages.

; CHANGING THE ENDS OF STRINGS
; ============================

; "trim" and "chop" are both constructive string-editing functions
; that work from the ends of the original strings inwards.
; "chop" works from the end:

(chop t) ; defaults to the last character
;-> "a hypothetical one-dimensional subatomic particl"

(chop t 9) ; chop 9 characters off
;-> "a hypothetical one-dimensional subatomic"

; trim can remove characters from both ends:

(set 's " ce ntred ")

(trim s) ; defaults to removing spaces
;-> "centred"

(set 's "------centred------")

(trim s "-")
;-> "centred"

(set 's "------centred******")

(trim s "-" "*") ; front and back
;-> "centred"

; "push" AND "pop" WORK ON STRINGS TOO
; ====================================

; "push" and "pop" add and remove items from lists.
; Use "push" to add characters to a string,
; and "pop" to remove one character from a string.

; Strings are added to or removed from the start
; of the string, unless you specify an index.

(set 't "some ")

(push "this is " t)
;-> "this is some"

(push "text " t -1)
;-> "this is some text"

"push" returns the modified target of the action.

"pop" always returns what was popped:

; It's useful when you want to break up a string and process the pieces as you go.
; It's easier to work from the right-hand side of the string
; and use pop to extract the information and remove it in one operation.

(set 'version-string (string (sys-info -2)))
; eg: version-string is now "10303"

(set 'dev-version (pop version-string -2 2)) ; always two digits
; dev-version is "03", version-string is "103"

(set 'point-version (pop version-string -1)) ; always one digit
; point-version is "3", version-string is now "10"

(set 'version version-string) ; one or two digits
(println version "." point-version "." dev-version)
;-> 10.7.01

; MODIFYING STRINGS
; =================

; There are two approaches to changing characters inside a string:
; 1) use the index numbers of the characters, or
; 2) specify the substring you want to find or change.

; USING INDEX NUMBERS IN STRINGS
; ==============================

; Use "setf" to change characters by their index numbers.
; "setf" is the general purpose function for changing strings, lists, and arrays:

(set 't "a hypothetical one-dimensional subatomic particle")
(setf (t 0) "A")
;-> "A"

t
;-> "A hypothetical one-dimensional subatomic particle"

; You could also use "nth" with "setf" to specify the location:

(set 't "a hypothetical one-dimensional subatomic particle")
;-> "a hypothetical one-dimensional subatomic particle"

(setf (nth 0 t) "A")
;-> "A"

t
;-> "A hypothetical one-dimensional subatomic particle"

; Here's how to 'increment' the first (zeroth) letter of a string:

(set 'wd "cream")
;-> "cream"

(setf (wd 0) (char (+ (char $it) 1)))
;-> "d"

wd
;-> "dream"

; $it contains the value found by the first part of the setf expression,
; and its numeric value is incremented to form the second part.

; CHANGING SUBSTRINGS
; ===================

; "replace" is a powerful destructive function
; that does all kinds of useful operations on strings.
; Use it in the form:

(replace <old-string> <source-string> <replacement>)

(set 't "a hypothetical one-dimensional subatomic particle")
(replace "hypoth" t "theor")
;-> "a theoretical one-dimensional subatomic particle"

; replace is destructive, but you can use the "copy" function to retain original string:

(set 't "a hypothetical one-dimensional subatomic particle")
(replace "hypoth" (copy t) "theor")
;-> "a theoretical one-dimensional subatomic particle"

t
;-> "a hypothetical one-dimensional subatomic particle"

; The copy is modified by replace. The original string t is unaffected.

; REGULAR EXPRESSIONS
; ===================

; "replace" is one functions that accept regular expressions for defining patterns in text.
; For most of them, you must add two parameters:
; 1) the regular expression pattern and
; 2) an extra number at the end of the expression:
;    0 means basic matching,
;    1 means case-insensitive matching, and so on.

set 't "a hypothetical one-dimensional subatomic particle")
(replace {h.*?l(?# h followed by l but not too greedy)} t {} 0)
;-> "a one-dimensional subatomic particle"

; Text between (?# and the following closing parenthesis is ignored: it is a comment.

; The functions replace and its regex-using cousins
; find, regex, find-all, parse, starts-with, ends-with, directory, and search,
; use Perl-compatible Regular Expressions (PCRE) (see newLISP manual).

; Your pattern must pass through both the newLISP reader and the regular expression processor.
; Remember the difference between strings enclosed in quotes and strings enclosed in braces?
; Quotes allow the processing of escaped characters, whereas braces don't.
; Braces have some advantages:
;  - they face each other visually,
;  - they don't have smart and dumb versions to confuse you,
;  - your text editor might balance them for you,
;  - and they let you use the quotation characters in strings without
;    having to escape them all the time.

; But if you use quotes, you must double the backslashes,
; so that a single backslash survives intact as far as the regular expression processor:

(set 'str "\s")

(replace str "this is a phrase" "|" 0) ; oops, not searching for \s (white space) ...
;-> thi| i| a phra|e ; but for the letter s

(set 'str "\\s")

(replace str "this is a phrase" "|" 0)
;-> this|is|a|phrase ; ah, better!

; SYSTEM VARIABLES: $0, $1, ...
; =============================

; "replace" updates a set of system variables $0, $1, $2, up to $15, with the matches.
; These refer to the parenthesized expressions in the pattern.
; example:

(set 'quotation {"I cannot explain." She spoke in a low, eager voice,
with a curious lisp in her utterance. "But for God's sake do what I
ask you. Go back and never set foot upon the moor again."})

(replace {(.*?),.*?curious\s*(l.*p\W)(.*?)(moor)(.*)}
quotation
(println {$1 } $1 { $2 } $2 { $3 } $3 { $4 } $4 { $5 } $5)
4)

;-> $1 "I cannot explain." She spoke in a low $2 lisp $3 in her utterance.
;-> "But for God's sake do what I ask you. Go back and never set foot upon
;-> the $4 moor $5 again."

; Here we've looked for five patterns, separated by any string
; starting with a comma and ending with the word curious.
; $0 stores the matched expression, $1 stores the first parenthesized sub-expression, and so on.

; If you prefer to use quotation marks rather than the braces,
; remember that certain characters have to be escaped with a backslash.

; THE REPLACEMENT EXPRESSION
; ==========================

; The function replace works with strings, lists and any newLISP expression.
; Each time the pattern is found, the replacement expression is evaluated.
; You can use this to provide a replacement value that's calculated dynamically,
; or you could do anything else you wanted to with the found text.
; It's even possible to evaluate an expression that's got nothing to do with found text at all.

; Here's another example:
; search for the letter t followed either by the letter h or by any vowel,
; and print out the combinations that replace found:

(set 't "a hypothetical one-dimensional subatomic particle")
(replace {t[h]|t[aeiou]} t (println $0) 0)
;-> th
;-> ti
;-> to
;-> ti
;-> "a hypothetical one-dimensional subatomic particle"

; For every matching piece of text found, the third expression (println $0) was evaluated.
; This is a good way of seeing what the regular expression engine is doing when is running.

; In this example, the original string appears to be unchanged, but in fact it did change,
; because (println $0) did two things:
; it prints the string and returns the value to replace,
; thus replacing the found text with itself.
; If the replacement expression doesn't return a string, no replacement occurs.

; You could do other useful things too, such as build a list of matches for later processing.
; You can use the newLISP system variables and any other function to use the text that was found.

; Example, we look for the letters a, e, or c, and force each occurrence to upper-case:

(replace "a|e|c" "This is a sentence" (upper-case $0) 0)
;-> "This is A sEntEnCE"

; Example, a simple search and replace operation that keeps count of
; how many times the letter 'o' has been found in a string,
; and replaces each occurrence in the original string with the count so far.
; The replacement is a block of expressions grouped into a single begin expression.
; This block is evaluated every time a match is found:

(set 't "a hypothetical one-dimensional subatomic particle")
(set 'counter 0)
(replace "o" t
  (begin
    (inc counter)
    (println {replacing "} $0 {" number } counter)
    (string counter)) ; the replacement text should be a string
0)
;-> "a hypothetical one-dimensional subatomic particle"
;-> 0
;-> replacing "o" number 1
;-> replacing "o" number 2
;-> replacing "o" number 3
;-> replacing "o" number 4
;-> "a hyp1thetical 2ne-dimensi3nal subat4mic particle"

; The output from println doesn't appear in the string.
; The final value of the entire begin expression is a string version of the counter,
; so that gets inserted into the string.

; Example: suppose I have a text file, consisting of the following:

; 1 a = 15
; 2 another_variable = "strings"
; 4 x2 = "another string"
; 5 c = 25
; 3x=9

; We write a script that re-numbers the lines in multiples of 10, starting at 10,
; and aligns the text so that the equals signs line up, like this:

; 10 a                 = 15
; 20 another_variable  = "strings"
; 30 x2                = "another string"
; 40 c                 = 25
; 50 x                 = 9

(set 'file (open ((main-args) 2) "read"))
(set 'counter 0)
(while (read-line file)
  (set 'temp
    (replace {^(\d*)(\s*)(.*)} ; the numbering
      (current-line)
      (string (inc counter 10) " " $3)
    0))
  (println
    (replace {(\S*)(\s*)(=)(\s*)(.*)} ; the spaces around =
      temp
      (string $1 (dup " " (- 20 (length $1))) $3 " " $5)
    0))
)
(exit)

; I've used two replace operations inside the while loop, to keep things clearer.
; The first one sets a temporary variable to the result of a replace operation.
; The search string ({^(\d*)(\s*)(.*)}) is a regular expression that's looking for
; any number at the start of a line, followed by some space, followed by anything.
; The replacement string:
; ((string (inc counter 10) " " $3) 0)) consists of a incremented counter value,
; by the third match (ie the anything I just looked for).
; The result of the second replace operation is printed.
; Searching the temporary variable temp for more strings and spaces with an equals sign inside:
; ({(\S*)(\s*)(=)(\s*)(.*)})

; The replacement expression is built up from the important found elements ($1, $3, $5),
; but it also calculate the amount of space required to put the equals sign at 20,
; which should be the difference between the first item's width and position 20
; (which I've chosen arbitrarily as the location for the equals sign).
; Regular expressions aren't very easy for the newcomer, but they're very powerful,
; particularly with newLISP's replace function, so they're worth learning.

; TESTING AND COMPARING STRINGS
; =============================

; There are various tests that you can run on strings.
; Comparison operators work by finding and comparing the code numbers of the characters
; until a decision can be made:

(> {Higgs Boson} {Higgs boson}) ; nil
(> {Higgs Boson} {Higgs}) ; true
(< {dollar} {euro}) ; true
(> {newLISP} {LISP}) ; true
(= {fred} {Fred}) ; nil
(= {fred} {fred}) ; true

; newLISP's flexible argument handling lets you test loads of strings at the same time:

(< "a" "c" "d" "f" "h")
;-> true

; These comparison functions also let you use them with a single argument.
; If you supply only one argument, newLISP assumes that you mean 0 or "",
; depending on the type of the first argument:

(> 1) ; true - assumes > 0
(> "fred") ; true - assumes > ""

; To check whether two strings share common features, you can either use
; a) "starts-with" and "ends-with" or
; b) general pattern matching functions "member", "regex", "find", and "find-all".

(starts-with "newLISP" "new") ; does newLISP start with new?
;-> true

(ends-with "newLISP" "LISP")
;-> true

; They can also accept regular expressions, using one of the regex options
; (0 being the most commonly used):

(starts-with {newLISP} {[a-z][aeiou](?\#lc followed by lc vowel)} 0)
;-> true
(ends-with {newLISP} {[aeiou][A-Z](?\# lc vowel followed by UCase)} 0)
;-> false

; "find", "find-all", "member", and "regex" look everywhere in a string.
; "find" returns the "index" of the matching substring:

(set 't "a hypothetical one-dimensional subatomic particle")
(find "atom" t)
;-> 34

(find "l" t)
;-> 13

(find "L" t)
;-> nil           ; search is case-sensitive

; "member" looks to see if one string is in another.
; It returns the rest of the string, including the search string,
; rather than the index of the first occurrence:

(member "game" "a good game-book to play")
;-> game-book to play

; Both "find" and "member" let you use regular expressions:

(set 'quotation {"I cannot explain." She spoke in a low,
eager voice, with a curious lisp in her utterance. "But for
Gods sake do what I ask you. Go back and never set foot upon
the moor again."})

(find "lisp" quotation) ; without regex
;-> 69 ; character 69

(find {i} quotation 0) ; with regex
;-> 15 ; character 15

(find {s} quotation 1) ; case insensitive regex
;-> 20 ; character 20

; "find" return the index of just the first match.
; "find-all" works like find, but returns a list of all matching strings.
; It always takes regular expressions, so don't need to put regex option numbers at the end.

(set 'quotation {"I cannot explain." She spoke in a low,
eager voice, with a curious lisp in her utterance. "But for
Gods sake do what I ask you. Go back and never set foot upon
the moor again."})

(find-all "[aeiou]{2,}" quotation $0) ; two or more vowels
;-> ("ai" "ea" "oi" "iou" "ou" "oo" "oo" "ai")

; We can use "regex": it returns nil if the string doesn't contain the pattern.
; Otherwise, it returns a list with the matched strings and substrings,
; and the start and length of each string.
; The results can be quite complicated:

(set 'quotation
{She spoke in a low, eager voice, with a curious lisp in her utterance.})

(println (regex {(.*)(l.*)(l.*p)(.*)} quotation 0))

;-> ("She spoke in a low, eager voice, with a curious lisp in
;-> her utterance." 0 70 "She spoke in a " 0 15 "low, eager
;-> voice, with a curious " 15 33 "lisp" 48 4 " in her
;-> utterance." 52 18)

; This results list can be interpreted as:
; the first match was from character 0 continuing for 70 characters,
; the second from character 0 continuing for 15 characters,
; another from character 15 for 33 characters', and so on.

; The matches are also stored in the system variables ($0, $1, ...).
; They can be inspect easily with a simple loop:

(for (x 1 4)
  (println {$} x ": " ($ x)))

;-> $1: She spoke in a
;-> $2: low, eager voice, with a curious
;-> $3: lisp
;-> $4: in her utterance.

; STRINGS TO LISTS
; ================

; Two functions let you convert strings to lists: "explode" and "parse".
; The explode function cracks a string and returns a list of single characters:

(set 't "a hypothetical one-dimensional subatomic particle")

(explode t)
;-> ("a" " " "h" "y" "p" "o" "t" "h" "e" "t" "i" "c" "a" "l"
;-> " " "o" "n" "e" "-" "d" "i" "m" "e" "n" "s" "i" "o" "n" "a"
;-> "l" " " "s" "u" "b" "a" "t" "o" "m" "i" "c" " " "p" "a" "r"
;-> "t" "i" "c" "l" "e")

;-> The explosion is easily reversed with "join".
;-> "explode" can also take an integer. This defines the size of the fragments:

(explode (replace " " t "") 10)
;-> ("ahypo" "theti" "calon" "e-dim" "ensio" "nalsu" "batom" "icpar" "ticle")

; You can do similar tricks with find-all. Watch the error at end, though:

(find-all ".{3}" t) ; this regex drops chars!
;-> ("a h" "ypo" "the" "tic" "al " "one" "-di" "men"
; "sio" "nal" " su" "bat" "omi" "c p" "art" "icl")

; PARSING STRINGS
; ===============

; parse is a powerful way of breaking strings up and returning the pieces
; It breaks strings apart, usually at word boundaries, eats the boundaries,
; and returns a list of the remaining pieces:

(parse t) ; defaults to spaces...
;-> ("a" "hypothetical" "one-dimensional" "subatomic" "particle")

; Or you can supply a delimiting character,
; and parse breaks the string whenever it meets that character:

(set 't (dup "spam" 8))
;-> "spamspamspamspamspamspamspamspam"

(parse t {am}) ; break on "am"
;-> ("sp" "sp" "sp" "sp" "sp" "sp" "sp" "sp" "")

; Best of all, though, you can specify a regular expression delimiter.
; Make sure you supply the options flag (0 or whatever):

(set 't {/System/Library/Fonts/Courier.dfont})

(parse t {[/aeiou]} 0) ; split at slashes and vowels
;-> ("" "Syst" "m" "L" "br" "ry" "F" "nts" "C" "" "r" "" "r.df" "nt")

; Here's that well-known quick and not very reliable HTML-tag stripper:

(set 'html (read-file "/Users/Sites/index.html"))
(println (parse html {<.*?>} 4)) ; option 4: dot matches newline

; For parsing XML strings, newLISP provides the function xml-parse.

; Take care when using "parse" on text.
; It thinks you're passing it newLISP source code.
; This can produce surprising results:

(set 't {Eats, shoots, and leaves ; a book by Lynn Truss})

(parse t)
;-> ("Eats" "," "shoots" "," "and" "leaves") ; she's gone!

; The semicolon is considered a comment character in newLISP:
; so parse has ignored it and everything that followed on that line.

; Tell it what you really want, using delimiters or regular expressions:

(set 't {Eats, shoots, and leaves ; a book by Lynn Truss})

(parse t " ")
;-> ("Eats," "shoots," "and" "leaves" ";" "a" "book" "by" "Lynn" "Truss")

; or

(parse t "\\s" 0) ; white space
;-> ("Eats," "shoots," "and" "leaves" ";" "a" "book" "by" "Lynn" "Truss")

; To chop strings up in other ways, consider using find-all,
; which returns a list of strings that match a pattern.
; If you can specify the chopping operation as a regular expression, you're in luck.
; Example, if you want to split a number into groups of three digits, use this technique:

(set 'a "1212374192387562311")

(println (find-all {\d{3}|\d{2}$|\d$} a))
;-> ("121" "237" "419" "238" "756" "231" "1")

; The pattern has to consider cases where there are 2 or 1 digits left over at the end.
; Alternatively:

(explode a 3)
;-> ("121" "237" "419" "238" "756" "231" "1")

; "parse" eats the delimiters once they've done their work.
; "find-all" finds things and returns what it finds.

(find-all {\w+} t ) ; word characters
;-> ("Eats" "shoots" "and" "leaves" "a" "book" "by" "Lynn" "Truss")

(parse t {\w+} 0 ) ; eats and leaves delimiters
;-> ("" ", " ", " " " "; " " " " " " " " " "")

; OTHER STRING FUNCTIONS
; ======================

; There are other functions that work with strings.
; "search" looks for a string inside a file on disk:
; pag. 151

(set 'f (open {/private/var/log/system.log} {read}))
(search f {kernel})
(seek f (- (seek f) 64)) ; rewind file pointer
(dotimes (n 3)
  (println (read-line f)))
(close f)

; This example looks in system.log for the string kernel.
; If it's found, rewinds the file pointer by 64 characters, then prints out three lines.
; There are also functions for working with base64-encoded files, and for encrypting strings.

; FORMATTING STRINGS
; ==================

; The "format" function insert the values of expressions into a predefined template string.
; Use %s to represent the location of a string expression inside the template.
; Use other % codes to include numbers.
; For example, suppose you want to display a list of files like this:
; folder: Library
; file: mach
; A suitable template for folders (directories) looks like this:

"folder: %s" ; or
" file: %s"

; The format function has a template string,
; followed by the expression (f) that produces a file or folder name:

(format "folder: %s" f) ; or
(format " file: %s" f)

; When this is evaluated, the contents of f is inserted into the string where the %s is.
; Here is the code to generate a directory listing in this format,
; using the "directory" function:

(dolist (f (directory))
  (if (directory? f)
    (println (format "folder: %s" f))
    (println (format " file: %s" f))))

; I'm using the directory? function to choose the right template string.
; A typical listing looks like this:

;-> folder: .
;-> folder: ..
;-> file: .DS_Store
;-> file: .hotfiles.btree
;-> folder: .Spotlight-V100
;-> folder: .Trashes
;-> folder: .vol
;-> file: .VolumeIcon.icns
;-> folder: Applications
;-> folder: Applications (Mac OS 9)
;-> folder: automount
;-> folder: bin
;-> folder: Cleanup At Startup
;-> folder: cores
;-> ...

; There are lots of formatting codes that you use to produce the output you want.
; Use numbers to control the alignment and precision of the strings and numbers.
; The % constructions in the format string must:
; a) match the expressions or symbols that appear after it
; b) and that there are the same number of each.

; Example to display the first 400 or so Unicode characters in decimal, hexadecimal and binary.
; We'll use the bits function to generate a binary string.
; We feed a list of three values to format after the format string, which has three entries:

(for (x 0 0x01a0)
  (println (char x)           ; the character, then
    (format "%4d\t%4x\t%10s"    ; decimal \t hex \t binary-string
    (list x x (bits x)))))

;-> 32 20 100000
;-> ! 33 21 100001
;-> " 34 22 100010
;-> # 35 23 100011
;-> $ 36 24 100100
;-> % 37 25 100101
;-> & 38 26 100110
;-> ' 39 27 100111
;-> ( 40 28 101000
;-> ) 41 29 101001
;-> ...

; STRINGS THAT MAKE NEWLISP THINK
; ===============================

; Lastly, I must mention "eval" and "eval-string".
; Both of these let you give newLISP code to newLISP for evaluation.
; If it's valid newLISP, you'll see the result of the evaluation.
; "eval" wants an expression:

(set 'expr '(+ 1 2))
(eval expr)
;-> 3

; "eval-string" wants a string:

(set 'expr "(+ 1 2)")
(eval-string expr)
;-> 3

; This means that you can build and evaluate newLISP code inside your programs.
; "eval" is particularly useful when you're defining MACROS:
; functions that delay evaluation until you choose to do it.
; You could use "eval" and "eval-string" to write programs that write programs.

; The following curious piece of newLISP continually and mindlessly rearranges a few strings
; and tries to evaluate the result.
; Unsuccessful attempts are safely caught.
; When it finally becomes valid newLISP, it will be evaluated successfully
; and the result will satisfy the finishing condition and finish the loop.

(set 'code '(")" "set" "'valid" "true" "("))
(set 'valid nil)
(until valid
  (set 'code (randomize code))
  (println (join code " "))
  (catch (eval-string (join code " ")) 'result))

;-> true 'valid set ) (
;-> ) ( set true 'valid
;-> 'valid ( set true )
;-> set 'valid true ( )
;-> 'valid ) ( true set
;-> set true ) ( 'valid
;-> true ) ( set 'valid
;-> 'valid ( true ) set
;-> true 'valid ( ) set
;-> 'valid ) ( true set
;-> true ( 'valid ) set
;-> set ( 'valid ) true
;-> set true 'valid ( )
;-> ( set 'valid true )

; "apply" AND "map": APPLYING FUNCTIONS TO LISTS
; ==============================================

; MAKING FUNCTIONS AND DATA WORK TOGETHER
; =======================================

; We have some data stored in a list and we want to apply a function to it.

(setq data '(0.1 3.2 -1.2 1.2 -2.3 0.1 1.4 2.5 0.3))
(println data)

; For example, we want to calculate the average value of data values.
; Try with "add" function:

(add 0.1 3.2 -1.2 1.2 -2.3 0.1 1.4 2.5 0.3)
;-> 5.300000000000001

; Now, put data list on expression:

(add data)
;-> ERR: value expected in function add : data

; This don't work because "add" function wants numbers to add, not a list.
; Then, we can write a loop:

(set 'total 0)
(dolist (i data)
  (inc total i))
(println total)
;-> 5.300000000000001

; Ok, this works fine.
; But newLISP has a much more powerful solution, for this and many other problems.
; You can treat functions as data and data as functions.
; You can manipulate functions as easily as you can manipulate your data.

; There are two important functions for doing this: "apply" and "map".

; "apply" takes a function and a list, and makes them work together:

(apply add data)
;-> 5.300000000000001

(div (apply add data) (length data))
;-> 0.5888888889

; and this produces the required result.

; We have used the "add" function as an argument to another function
; You don't need to quote it (although you can),
; because apply is already expecting the name of a function.

; "map" applies a function to each item of a list, one by one.

; For example, to calculate the "floor" function to each element of the data list
; (to round them down to the nearest integer):

(map floor data)
;-> (0 3 -2 1 -3 0 1 2 0)

; The "floor" function is applied to each element of the data.
; The results are combined and returned in a new list.

; "apply" AND "map" IN MORE DETAIL
; ================================

; Both "apply" and "map" let you treat functions as data.
; They have the same basic form:

(apply f l)

(map f l)

; where f is the name of a function and l is a list.

; The idea is that you tell newLISP to process a list using the function you specify.

; APPLY
;  _____________
;  ↓           ↓
; add      (1 2 3 4) ==> 10

; "apply" uses all the elements in the list as arguments to the function
; and evaluates the result.

(apply reverse '("this is a string"))
;-> "gnirts a si siht"

(reverse "this is a string")
;-> "gnirts a si siht"

(reverse '(this is a list))
;-> (string a is this)

; "apply" looks at the list (a single string) and feeds the elements to the function as arguments.
; The string gets reversed.
; Notice that you don't have to quote the function, but you do have to quote the list.
; Because you don't want newLISP to evaluate it
; before the designated function gets a chance to consume it.

; MAP
;  __________________________
;  ↓                ↓   ↓   ↓
; upper-case      ("a" "b" "c") ==> ("A" "B" "C")

; The "map" function, on the other hand, works through the list, element by element,
; and applies the function to each element in turn, using the element as the argument.
; However, "map" remembers the result of each evaluation as it goes,
; collects them up, and returns them in a new list.

; "map" looks like a control-flow word, a bit like dolist,
; "apply" is a way of controlling the newLISP list evaluation process from within your program,
; calling a function when and where you want it called,
; not just as part of the normal evaluation process.

; If we adapt the previous example for "map", it gives a similar result,
; although the result is a list, not a string:

(map reverse '("this is a string"))
;-> ("gnirts a si siht")

(map reverse '("this is a string"))
;-> ("gnirts a si siht")

; Because we've used a list with only one element,
; the result is almost identical to the "apply" example:
; although notice that "map" returns a list whereas, in this example, "apply" returns a string:

(apply reverse '("this is a string"))
;-> "gnirts a si siht"

; The string has been extracted from the list, reversed,
; and then stored in another list created by "map".
; In the next example:

(map reverse '("this" "is" "a" "list" "of" "strings"))
;-> ("siht" "si" "a" "tsil" "fo" "sgnirts")

; Now, "map" has applied reverse to each element of the list in turn,
; and returned a list of the resulting reversed strings.

; WRITE ONE IN TERMS OF THE OTHER?
; ================================

There is a relationship between these two functions.
Here is an attempt at defining "map" in terms of "apply":

(define (my-map f l , r)
; declare a local variable r to hold the results

(dolist (e l)
  (push (apply f (list e)) r -1)))


; Pushing the result of applying a function f to each list item to the end of a temporary list,
; and then relying on push returning the list at the end, just as map would do.
; This works, at least for simple expressions:

(my-map explode '("this is a string"))
;-> ("t" "h" "i" "s" " " "i" "s" " " "a" " " "s" "t" "r" "i" "n" "g")

(map explode '("this is a string"))
;-> (("t" "h" "i" "s" " " "i" "s" " " "a" " " "s" "t" "r" "i" "n" "g"))

; This example illustrates why map is so useful.
; It's an easy way to transform all the elements of a list without the hassle
; of working through them element by element using a dolist expression.

; MORE TRICKS
; ===========

; Both "map" and "apply" have more tricks up their sleeves.
; "map" can traverse more than one list at the same time.
; If you supply two or more lists, newLISP interleaves the elements of each list together,
; starting with the first elements of each list, and passes them as arguments to the function:

(map append '("cats " "dogs " "birds ") '("miaow" "bark" "tweet"))
;-> ("cats miaow" "dogs bark" "birds tweet")

; Here the first element of each list is passed as a pair to append,
; followed by the second element of each list, and so on.

; This weaving together of strands is a bit like knitting with lists.
; Or like doing up a zip.

; "apply" has a trick too.
; A third argument indicates how many of the preceding list's arguments the function should use.
; So if a function takes two arguments, and you supply three or more, "apply" comes back
; and makes another attempt, using the result of the first application and another argument.
; It continues eating its way through the list until all the arguments are used up.
; To see this, let's first define a function that takes two arguments and compares their lengths:

(define (longest s1 s2)
  (println s1 " is longest so far, is " s2 " longer?") ; feedback
  (if (>= (length s1) (length s2)) ; compare
      s1
      s2))

; Now you can apply this function to a list of strings,
; using the third argument to tell "apply" to use up the arguments two strings at a time:

(apply longest '("green" "purple" "violet" "yellow" "orange"
"black" "white" "pink" "red" "turquoise" "cerise" "scarlet"
"lilac" "grey" "blue") 2)

;-> green is longest so far, is purple longer?
;-> purple is longest so far, is violet longer?
;-> purple is longest so far, is yellow longer?
;-> purple is longest so far, is orange longer?
;-> purple is longest so far, is black longer?
;-> purple is longest so far, is white longer?
;-> purple is longest so far, is pink longer?
;-> purple is longest so far, is red longer?
;-> purple is longest so far, is turquoise longer?
;-> turquoise is longest so far, is cerise longer?
;-> turquoise is longest so far, is scarlet longer?
;-> turquoise is longest so far, is lilac longer?
;-> turquoise is longest so far, is grey longer?
;-> turquoise is longest so far, is blue longer?
;-> "turquoise"

; It's like walking along the beach and finding a pebble,
; and holding on to it until an even better one turns up.

; "apply" can also works through a list applyinf a function to each pair of items:

(apply (fn (x y) (println {x is } x {, y is } y)) (sequence 0 10) 2)
;-> x is 0, y is 1
;-> x is 1, y is 2
;-> x is 2, y is 3
;-> x is 3, y is 4
;-> x is 4, y is 5
;-> x is 5, y is 6
;-> x is 6, y is 7
;-> x is 7, y is 8
;-> x is 8, y is 9
;-> x is 9, y is 10

; The value returned by the "println" function is the second member of the pair,
; and this becomes the value of the first element of the next pair.

; LISPINESS
; =========

; Passing around the names of functions, as if they were bits of data, it's very useful.
; This is very characteristic of newLISP and you will find many uses for it.
; Sometimes using functions that you don't think will be useful with "map".

; Here, for example, is set working hard under the control of map:

(map set '(a b) '(1 2))
;-> a is 1, b is 2

(map set '(a b) (list b a))
;-> a is 2, b is 1

; This method is another way to assign values to symbols in parallel, rather than sequentially.
; You can use swap as well.

; Some uses of "map" are simple:

(map char (explode "hi there"))
;-> (104 105 32 116 104 101 114 101)

(map (fn (h) (format "%02x" h)) (sequence 0 15))
;-> ("00" "01" "02" "03" "04" "05" "06" "07" "08" "09" "0a" "0b" "0c" "0d" "0e" "0f")

; Others can become quite complex.
; For example, given a string of data in this form, stored in a symbol image-data:

("/Users/me/graphics/file1.jpg" " pixelHeight: 978" " pixelWidth: 1181")

; The two numbers can be extracted with:

(map set '(height width) (map int (map last (map parse (rest image-data)))))

; CURRYING
; ========

; Some of the built-in newLISP functions do things with other functions.
; An example is "curry", which creates a copy of a two-argument function
; and creates a single-argument version with a pre-determined first argument.
; So if a function f1 was often called like this:

(f1 arg1 arg2)

; You can use "curry" to make a new function f2 that has a ready-to-use built-in arg1:

(set 'f2 (curry f1 arg1))

; Now you can forget about that first argument, and just supply the second one to f2:

(f2 arg2)

; Why is this useful?
; Consider the "dup" function, which often gets used to insert multiple blank spaces:

(dup { } 10)

; Using "curry", you can create a new function called, say, blank,
; that's a special version of dup that always gets called with a blank space as the string:

(set 'blank (curry dup { }))

; Now you can use (blank n):

(blank 10)
;-> ; 10 spaces

; "curry" can be useful for creating temporary or anonymous functions with map:

(map (curry pow 2) (sequence 1 10))
;-> (2 4 8 16 32 64 128 256 512 1024)

(map (fn (x) (pow 2 x)) (sequence 1 10)) ; equivalent
;-> (2 4 8 16 32 64 128 256 512 1024)

; But avoid using curry on destructive functions like "inc".
; For example:

(setq a-list-of-pairs (sequence 2 10 2))
;-> (2 4 6 8 10)

(map (curry inc 3) a-list-of-pairs) ;-> you would expect (5 7 9 11 13), instead you get
;-> (5 9 15 23 33)

; One proper way to get every number incremented by 3 would be
(map (curry + 3) a-list-of-pairs)
;-> (5 7 9 11 13)

; or if you insist in using inc, then provide a copy of the increment
; so the reference inc gets doesn't mess up things
(map (curry inc (copy 3)) a-list-of-pairs)
;-> (5 7 9 11 13)

; INTRODUCING CONTEXTS
; ====================

; newLISP programmers use contexts to organize their code.

; WHAT IS A CONTEXT?
; ==================

; A newLISP context provides a named container for symbols.
; Symbols in different contexts can have the same name without clashing.
; For example, in one context I can define the symbol called meaning-of-life with the value 42,
; but, in another context, the identically-named symbol could have the value dna-propagation,
; and, in yet another, worship-of-deity.

; Unless you specifically choose to create and/or switch contexts,
; all your newLISP work is carried out in the default context, called MAIN.
; So far in this document, when new symbols have been created,
; they've been added to the MAIN context.

; Contexts are very versatile - you can use them for dictionaries,
; or software objects, or super-functions, depending on the task in hand.

; CONTEXTS: THE BASICS
; ====================

; The context function can be used for a number of different tasks:
; - to create a new context
; - to switch from one context to another
; - to retrieve the value of an existing symbol in a context
; - to see what context you're in
; - to create a new symbol in a context and assign a value to it

; newLISP can usually read your mind, and knows what you want to do,
; depending on how you use the context function. For example:

(context 'Test)

; creates a new context called Test, as you might expect.
; If you type this in interactively, you'll see that newLISP changes the prompt
; to tell you that you're now working in another context:

(context 'Test)
;-> Test
;-> Test>

; And you can switch between contexts freely:

(context MAIN)
;-> MAIN

(context Test)
;-> Test
;-> Test>

Used on its own, it just tells you where you are:

(context)
;-> MAIN

; Once a context exists, you don't have to quote the name (but you can if you like).
; Notice that I've used an upper-case letter for my context name.
; This is not compulsory, just a convention.
; A context contains symbols and their values.
; There are various ways to create a symbol and give it a value.

(context 'Doyle "villain" "moriarty")
;-> "moriarty"

; This creates a new context (notice the quote, because newLISP hasn't seen this before)
; and a new symbol called "villain", with a value of "Moriarty", but stays in the MAIN context.
; If the context already exists, you can omit the quote:

(context Doyle "hero" "holmes")
;-> "holmes"

; To obtain the value of a symbol, you can do this:

(context Doyle "hero")
;-> "holmes"

; or, if you're using the console, this step by step approach:

(context Doyle)
;-> Doyle

Doyle> hero
;-> "holmes"
;-> Doyle>

; or, from the MAIN context:

Doyle:hero
;-> "holmes"

; You can use this list of symbols in the usual way, such as stepping through it with dolist.

(dolist (s (symbols Doyle))
  (println s))

;-> Doyle:hero
;-> Doyle:period
;-> Doyle:villain

; To see the values of each symbol, use eval to find its value,
; and term to return just the symbol's name.

(dolist (s (symbols Doyle))
  (println (term s) " is " (eval s)))

;-> hero is Holmes
;-> period is Victorian
;-> villain is Moriarty

; There's a more efficient (slightly faster) technique for looping through symbols in a context.
;-> Use the dotree function:

(dotree (s Doyle)
  (println (term s) " is " (eval s)))

;-> hero is Holmes
;-> period is Victorian
;-> villain is Moriarty

; CREATING CONTEXTS IMPLICITLY
; ============================

; As well as explicitly creating contexts with context,
; you can have newLISP create contexts for you automatically.
; For example:

(define (C:greeting)
  (println "greetings from context " (context)))

(C:greeting)
;-> greetings from context C

; Here, newLISP has created a new context C and a function called greeting in that context.
; You can create symbols this way too:

(define D:greeting "this is the greeting string of context D")
  (println D:greeting)

;-> this is the greeting string of context D

; In both these examples, notice that you stayed in the MAIN context.
; The following code creates a new context L containing a new list ls that contains strings:

(set 'L:ls '("this" "is" "a" "list" "of" "strings"))
;-> ("this" "is" "a" "list" "of" "strings")

; FUNCTIONS IN CONTEXT
; ====================

; Contexts can contain functions and symbols.
; To create a function in a context other than MAIN, either do this:

(context Doyle)                ; switch to existing context
(define (hello-world)          ; define a local function
  (println "Hello World"))

; or do this

(context MAIN) ; stay in MAIN
(define (Doyle:hello-world)    ; define function in context
  (println "Hello World"))

; This second syntax lets you create both the context and the function inside the context,
; while remaining safely in the MAIN context all the time.

(define (Moriarty:helloworld)
  (println "(evil laugh) Hello World"))

; You don't have to quote the new context name here because we're using define,
; and define (by definition) isn't expecting the name of an existing symbol.
; To use functions while you're in another context,
; remember to call them using this context:function syntax.

; THE DEFAULT FUNCTION
; ====================

; If a symbol in a context has the same name as the context, it's known as the default function
; (although in fact it can be either a function, or a symbol containing a list or a string).
; For example, here is a context called Evens, and it contains a symbol called Evens:

(define Evens:Evens (sequence 0 30 2))
;-> (0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30)

Evens:Evens
;-> (0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30)

; And here is a function called Double in a context called Double:

(define (Double:Double x)
  (mul x 2))

; So Evens and Double are the default functions for their contexts.

; There are lots of good things about default functions.
; If the default function has the same name as the context,
; it is evaluated whenever you use the name of the context in expressions,
; unless newLISP is expecting the name of a context.
; For example, although you can always switch to the Evens context
; by using the context function in the usual way:

(context Evens)
; Evens
Evens> (context MAIN)
; MAIN

; you can use Evens as a list (because Evens:Evens is a list):

(reverse Evens)
;-> (30 28 26 24 22 20 18 16 14 12 10 8 6 4 2 0)

; You can use the default function without supplying its full address.
; Similarly, you can use the Double function as an ordinary function
; without supplying the full colon-separated address:

(Double 3)
;-> 6

; You can still switch to the Double context in the usual way:

(context Double)
;-> Double
;-> Double>

; newLISP is able to understand whether
; to use the default function of a context or the context itself.

; PASSING PARAMETERS BY REFERENCE
; ===============================

; There are important differences between default functions
; when used as symbols and their more ordinary siblings.
; When you use a default function to pass data to a function,
; newLISP uses a reference to the data rather than a copy.
; For larger lists and strings, references are much quicker for newLISP
; to pass around between functions, so your code will be faster
; if you can use store data as a default function and use the context name as a parameter.

; As a consequence functions change the contents
; of any default functions passed as reference parameters.
; Ordinary symbols are copied when passed as parameters.
; Observe the following code.
; I'll create two symbols, one of which is a 'default function', the other is a plain symbol:

(define Evens:Evens (sequence 0 30 2))  ; symbol is the default function for the Evens context
;-> (0 2 4 6 8 10 12 14 16 18 20 22 24 26 28 30)

(define odds (sequence 1 31 2))             ; ordinary symbol
;-> (1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31)

; this function reverses a list
(define (my-reverse lst)
  (reverse lst))

(my-reverse Evens)                          ; default function as parameter
;-> (30 28 26 24 22 20 18 16 14 12 10 8 6 4 2 0)

(my-reverse odds)                           ; ordinary symbol as parameter
;-> (31 29 27 25 23 21 19 17 15 13 11 9 7 5 3 1)

; So far, it looks as if they're behaving identically.
; But now inspect the original symbols:

Evens:Evens
;-> (30 28 26 24 22 20 18 16 14 12 10 8 6 4 2 0)
odds
;-> (1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31)

; The list that was passed as a default function - as a reference - was modified,
; whereas the ordinary list parameter was copied, as usual, and wasn't modified.

; FUNCTIONS WITH A MEMORY
; =======================

; In the following example, we create a context called Output,
; and a default function inside it, also called Output.
; This function prints its arguments,
; and increments a counter by the number of characters output.
; Because the default function has the same name as the context,
; it is executed whenever we use the name of the context in other expressions.

; Inside this function, the value of a variable counter (inside the context Output)
; is incremented if it exists, or created and initialized if it doesn't.
; Then the function's main task - the printing of the arguments - is done.
; The counter symbol keeps count of how many characters were output.

(define (Output:Output)               ; define the default function
  (unless Output:counter
    (set 'Output:counter 0))
  (inc Output:counter (length (string (args))))
  (map print (args))
  (println))

(dotimes (x 90)
  (Output                             ; use context name as a function
  "the square root of " x " is " (sqrt x)))
  (Output "you used " Output:counter " characters")

;-> the square root of 0 is 0
;-> the square root of 1 is 1
;-> the square root of 2 is 1.414213562
;-> the square root of 3 is 1.732050808
;-> the square root of 4 is 2
;-> the square root of 5 is 2.236067977
;-> the square root of 6 is 2.449489743
;-> the square root of 7 is 2.645751311
;-> the square root of 8 is 2.828427125
;-> the square root of 9 is 3
;-> ...
;-> the square root of 88 is 9.38083152
;-> the square root of 89 is 9.433981132
;-> you used 3895 characters

; The Output function effectively remembers how much work it's done since it was first created.
; It could even append that information to a log file. Think of the possibilities.
; You could log the usage of all your functions, and see how often the users use them.
; You can override the built-in println function so that it uses this code when it's called.

; DICTIONARIES AND TABLES
; =======================

; A common use for a context is a dictionary:
; an ordered set of unique key/value pairs, arranged so that you can obtain
; the current value of a key, or add a new key/value pair.
; newLISP makes creating dictionaries easy.
; First, I downloaded Sir Arthur Conan Doyle's The Sign of Four from Project Gutenberg,
; then I loaded the file as a list of words.

(set 'file "/Users/me/Sherlock Holmes/sign-of-four.txt")

;read file and remove all white-spaces, returns a list.
(set 'data (clean empty? (parse (read-file file) "\\W" 0)))

; Next, I define an empty dictionary:

(define Doyle:Doyle)

; This defines the Doyle context and the default function,
; but leaves that default function uninitialized.
; If the default function is left empty,
; use the following expressions to build and examine a dictionary:

; - (Doyle key value) - set key to value
; - (Doyle key) - get value of key
; - (Doyle key nil) - delete key

; To build a dictionary from the word list, you scan through the words, and,
; if the word is not in the dictionary, add it as the key, and set the value to 1.
; But if the word is already in the dictionary, get the value, add 1, and save the new value:

(dolist (word data)
  (set 'lc-word (lower-case word))
  (if (set 'tally (Doyle lc-word))
    (Doyle lc-word (inc tally))
    (Doyle lc-word 1)))

; This shorter alternative eliminates the conditional:

(dolist (word data)
  (set 'lc-word (lower-case word))
  (Doyle lc-word (inc (int (Doyle lc-word)))))

; or, even shorter still:

(dolist (word data)
  (Doyle (lower-case word) (inc (Doyle (lower-case word)))))

; Each word is added to the dictionary, and the value (the number of occurrences) increased by 1.
; Inside the context, the names of the keys have been prefixed with an underscore ("_").
; This is so that nobody gets confused between the names of keys and newLISP reserved words,
; many of which occur in Conan-Doyle's text.
; There are various ways you can browse the dictionary.
; To look at individual symbols:

(Doyle "baker")
;-> 10

(Doyle "street")
;-> 26

; To look at the symbols as they are stored in a context,
; work through the context evaluating each symbol, using dotree:

(dotree (wd Doyle)
  (println wd { } (eval wd)))

;-> Doyle:Doyle nil
;-> Doyle:_1 1
;-> Doyle:_1857 1
;-> Doyle:_1871 1
;-> Doyle:_1878 2
;-> Doyle:_1882 3
;-> Doyle:_221b 1
;-> ...
;-> Doyle:_your 107
;-> Doyle:_yours 7
;-> Doyle:_yourself 9
;-> Doyle:_yourselves 2
;-> Doyle:_youth 3
;-> Doyle:_zigzag 1
;-> Doyle:_zum 2

; To see the dictionary as an association list, use the dictionary name on its own.
; This creates a new association list:

;-> (Doyle)
;-> (("1" 1)
;-> ("1857" 1)
;-> ("1871" 1)
;-> ("1878" 2)
;-> ("1882" 3)

; SAVING AND LOADING CONTEXTS
; ===========================

; If you want to use the dictionary again, you can save the context in a file:

(save "/Users/me/Sherlock Holmes/doyle-context.lsp" 'Doyle)

; This collection of data, wrapped up in a context called Doyle,
; can be quickly loaded  by another script or newLISP session using:

(load "/Users/me/Sherlock Holmes/doyle-context.lsp")

; and newLISP will automatically recreate all the symbols in the Doyle context,
; switching back to the MAIN (default) context when done.

; USING newLISP MODULES
; =====================

; Contexts are used as containers for software modules
; because they provide lexically-separated namespaces.
; The modules supplied with the newLISP installation usually define a context
; that contains a set of functions handling tasks in a specific area.
; Here's an example. The POP3 module lets you check POP3 email accounts.
; You first load the module:

(load "/usr/share/newlisp/modules/pop3.lsp")

; The module has now been added to the newLISP system. You can switch to the context:

(context POP3)

; and call the functions in the context.
; For example, to check your email, use the get-mail-status function,
; supplying user name, password, and POP3 server name:

(get-mail-status "someone@example.com" "secret" "mail.example.com")
;-> (3 197465 37)
; (totalMessages, totalBytes, lastRead)

; If you don't switch to the context,
; you can still call the same function by supplying the full address:

(POP3:get-mail-status "someone@example.com" "secret" "mail.example.com")

; SCOPING
; =======

; You've already seen the way newLISP dynamically finds the current version of a symbol (Scope).
; However, when you use contexts, you can employ a different approach, called lexical scoping.
; With lexical scoping, you can explicitly control which symbol is used,
; rather than rely on newLISP to keep track of similarly-named symbols for you automatically.

; In the following code, the width symbol is defined inside the Right-just context.

(context 'Right-just)
(set 'width 30)

(define (Right-just:Right-just str)
  (slice (string (dup " " width) str) (* width -1)))

(context MAIN)
(set 'width 0) ; this is a red herring

(dolist (w (symbols))
  (println (Right-just w)))

;->                  !
;->                 !=
;->                  $
;->                 $0
;->                 $1
;->                ...
;->         write-line
;->          xml-error
;->          xml-parse
;->      xml-type-tags
;->              zero?
;->                  |
;->                  ~

; The second (set 'width ...) line is a red herring:
; changing this here makes no difference at all,
; because the symbol, which is actually used by the right-justification function,
; is inside a different context.

; You can still reach inside the Right-just context to set the width:

(set 'Right-just:width 15)

; There's been much discussion about the benefits and disadvantages of the two approaches.
; Whatever you choose, make sure you know
; where the symbols are going to get their values from in the code.
; For example:

(define (f y)
  (+ y x))

; Here, y is the first argument to the function, and is independent of any other y.
; But what about x? Is it a global symbol, or has the value been defined in some other function?
; Or perhaps it has no value at all!
; It's best to avoid using these free symbols, and to use local variables
; (defined with let or local) wherever possible.
; Perhaps you can adopt a convention such as putting asterisks around a global symbol.
; (ie. *status*)

; OBJECTS
; =======

; This section is just a quick glance at the subject.
; newLISP is agile enough to enable more than one style of OOP,
; and you can easily find references to these on the web,
; together with discussions about the merits of each.

; For this introduction, I'll briefly outline just one of these styles:
; FOOP, or Functional Object-Oriented Programming.

; FOOP IN A NUTSHELL
; ==================

; In FOOP, each object is stored as a list.
; Class methods and class properties are stored in a context.
; (ie functions and symbols that apply to every object of that class)
; Objects are stored in lists because lists are fundamental to newLISP.
; The first item in an object list is a symbol identifying the class of the object,
; the remaining items are the values that describe the properties of an object.
; All the objects in a class share the same properties but these can have different values.
; The class can also have properties that are shared between all objects in the class:
; these are the class properties.
; Functions stored in the class context provide the various methods
; for managing the objects and processing the data they hold.
; To illustrate these ideas, consider the following code that works with times and dates.
; It builds on top of the basic date and time functions provided by newLISP.
; A moment in time is represented as a time object.
; An object holds two values: the number of seconds that have elapsed since the beginning of 1970,
; and the time zone offset, in minutes west of Greenwich.
; So the list to represent a typical time object looks like this:

(Time 1219568914 0)

; where Time is a symbol representing the class name,
; and the two numbers are the values of this particular time
; (these numbers represent a time around 10 in the morning on Sunday August 24 2008,
; somewhere in England).
; The code required to build this object is straightforward using generic FOOP constructor:

(new Class 'Time) ; defines Time context

(setq some-england-date (Time 1219568914 0))

; However, you might want to define a different constructor:
; for example, you might want to give this object some default values.
; To do that you have to redefine the default function which is acting as the constructor:

(define (Time:Time (t (date-value)) (zone 0))
(list Time t zone))

; It's a default function for the Time context that builds a list with
; the class name in the first position, and two more integers to represent the time.
; When values are not supplied, they default to the current time and zero offset.
; You can now use the constructor without supplying some or any parameters:

(set 'time-now (Time))
;-> your output *will* differ for this one but will be something like (Time 1324034009 0)

(set 'my-birthday (Time (date-value 2008 5 26)))
;-> (Time 1211760000 0)

(set 'christmas-day (Time (date-value 2008 12 25)))
;-> (Time 1230163200 0)

; Next, you can define other functions to inspect and manage time objects.
; All these functions live together in the context.
; They can extract the seconds and zone information
; getting them from the object by using the self function.
; So (self 1) gets the seconds and (self 2) gets the time zone offset
; from the object passed as parameter.
; Notice the definitions do not require you to state the object parameter.
; Here are a few obvious class functions:

(define (Time:show)
  (date (self 1) (self 2)))
(define (Time:days-between other)
  "Return difference in days between two times."
  (div (abs (- (self 1) (other 1))) (* 24 60 60)))

(define (Time:get-hours)
  "Return hours."
  (int (date (self 1) (self 2) {%H})))

(define (Time:get-day)
  "Return day of week."
  (date (self 1) (self 2) {%A}))

(define (Time:leap-year?)
  (let ((year (int (date (self 1) (self 2) {%Y}))))
    (and (= 0 (% year 4))
      (or (!= 0 (% year 100)) (= 0 (% year 400))))))

; These functions are called by using the colon operator
; and providing the object which we want the function to act upon:

(set 'time-now (Time))
;-> your output *will* differ for this one but will be something like (Time 1324034009 0)

(:show christmas-day)
;-> Thu Dec 25 00:00:00 2008

(:show my-birthday)
;-> Mon May 26 01:00:00 2008

; Notice how we used the colon operator as a prefix to the function,
; without separating it with a space, this is a matter of style.
; You can use it with ot whitout spaces:

(:show christmas-day) ; same as before
;-> Thu Dec 25 00:00:00 2008

(: show christmas-day) ; notice the space between colon and function
;-> Thu Dec 25 00:00:00 2008

; This technique allows to provide a feature that object-oriented programmers love: polymorphism.

; POLYMORPHISM
; ============

; Let's add another class which works on durations
; - the gap between two time objects - measured in days.

(define (Duration:Duration (d 0))
  (list Duration d))

(define (Duration:show)
  (string (self 1) " days "))

; There's a new class constructor Duration:Duration for making new duration objects,
; and a simple show function.
; They can be used with the time objects like this:

; define two times
(set 'time-now (Time) 'christmas-day (Time (date-value 2008 12 25)))

; show days between them using the Time:days-between function
(:show (Duration (:days-between time-now christmas-day)))
;-> "122.1331713 days

; Compare that :show function call with the :show in the previous section:

(:show christmas-day)
;-> Thu Dec 25 00:00:00 2008

; You can see that newLISP is choosing which version of the show function to evaluate,
; according to the class of :show's parameter.
; Because christmas-day is a Time object, newLISP evaluates Time:show.
; But when the argument is a Duration object, it evaluates Duration:show.
; The idea is that you can use a function on various types of object:
; you perhaps don't need to know what class of object you're dealing with.
; With this polymorphism, you can apply the show function to a list of objects of differing types,
; and newLISP selects the appropriate one each time:

(map (curry :show)
  (list my-birthday (Duration (:days-between time-now christmas-day))))
;-> ("Mon May 26 01:00:00 2008" "123.1266898 days ")

; Note: We must use "curry" here because "map" needs to use both the colon operator
; as well as the show function.

; MODIFYING OBJECTS
; =================

; We're calling this particular style of OOP FOOP because it's considered to be functional.
; Here, the term 'functional' refers to the style of programming encouraged by newLISP
; which emphasizes the evaluation of functions, avoiding state and mutable data.
; As you've seen, many newLISP functions return copies of lists rather than modify the originals.

; There are, though, a small number of functions that are called destructive,
; and these are considered to be less purely functional.
; But FOOP doesn't provide for destructive object methods, so can be considered more functional.
; A key point to notice about FOOP is that objects are immutable:
; they can't be modified by class functions.
; For example, a function for the Time class that adds a given number of days to a time object:

(define (Time:adjust-days number-of-days)
  (list Time (+ (* 24 60 60 number-of-days) (self 1)) (self 2)))

; When this is called, it returns a modified copy of the object; the original is unchanged:

(set 'christmas-day (Time (date-value 2008 12 25)))
;-> (Time 1230163200 0)

(:show christmas-day)
;-> "Thu Dec 25 00:00:00 2008"

(:show (:adjust-days christmas-day 3))
;-> "Sun Dec 28 00:00:00 2008"

(:show christmas-day)
;-> "Thu Dec 25 00:00:00 2008"
; notice it's unchanged

; The original date of the christmas-day object didn't change,
; although the :adjust-days function returned a modified copy adjusted by 3 days.

; In other words, to make changes to objects, use the familiar newLISP approach:
; using the value returned by a function:

(set 'christmas-day (:adjust-days christmas-day 3))

(:show christmas-day)
;-> "Sun Dec 28 00:00:00 2008"

; christmas-day now contains the modified date.
; You can find a more complete working out of this idea
; by searching the newLISP forum for timeutilities.
; Also make sure to read the section on FOOP in the reference manual:
; it has a nice example on nested objects, that is, objects containing other objects.

; MACROS
; ======

; INTRODUCING MACROS
; ==================

; We've covered the basics of newLISP, but there are plenty of powerful features left to discover.
; Once you've grasped the main rules of the language,
; you can decide which of the more advanced tools you want to add.
; One feature that you might want to explore is newLISP's provision of macros.

; A macro is a special type of function that you can use to change the way your code is evaluated.
; For example, you can create new types of control functions,
; such as your own version of if or case.

; With macros, you can start to make newLISP work exactly the way you want it to.
; Strictly speaking, newLISP's macros are fexprs, not macros.
; Fexprs are called macros partly because it's much easier to say 'macros' than 'fexprs',
; but mainly because they serve a similar purpose to macros in other LISP dialects:
; they allow you to define special forms such as your own control functions.

; WHEN DO THINGS GET EVALUATED
; ============================

; To understand macros, let's jump back to one of the very first examples in this introduction.
; Consider the way this expression is evaluated:

(* (+ 1 2) (+ 3 4))
;-> (* 3 7)
;-> 21

; The * function doesn't see the + expressions at all, only their results.
; newLISP has enthusiastically evaluated the addition expressions and
; then handed just the results to the multiplication function.
; This is usually what you want, but there are times
; when you don't want every expression evaluated immediately.

; Consider the operation of the built-in function if:

(if (<= x 0) (exit))

; If x is greater than 0, the test returns nil so the (exit) function isn't evaluated.
; Now suppose that you want to define your own version of the if function.
; It ought to be easy:

(define (my-if test true-action false-action)
  (if test true-action false-action))

(my-if (> 3 2) (println "yes it is" ) (exit))
;-> yes it is
;-> $

; But this doesn't work. If the comparison returns true, newLISP prints a message and then exits.
; Even if the comparison returned false, newLISP would still exit, without printing a message.
; The problem is that (exit) is evaluated before the my-if function is called,
; even when you don't want it to be.
; For ordinary functions, expressions in arguments are evaluated first.
; Macros are similar to functions, but they let you control when (and if) arguments are evaluated.
; You use the definemacro function to define macros,
; in the same way that you define functions using define.
; Both these defining functions let you make your own functions that accept arguments.
; The important difference is that, with the ordinary define,
; arguments are evaluated before the function runs.
; But when you call a macro function defined with definemacro,
; the arguments are passed to the definition in their raw and unevaluated form.
; You decide when the arguments are evaluated.

; A macro version of the my-if function looks like this:

(define-macro (my-if test true-action false-action)
  (if (eval test) (eval true-action) (eval false-action)))

(my-if (> 3 2) (println "yes it is" ) (exit))
;-> "yes it is"

; The test and action arguments aren't evaluated immediately,
; only when you want them to be, using eval.
; And this means that the (exit) isn't evaluated before the test has been made.
; This ability to postpone evaluation gives you the ability to write your own control structures
; and add powerful new forms to the language.

; TOOLS FOR BUILDING MACROS
; =========================

; newLISP provides a number of useful tools for building macros.
; As well as define-macro and eval, there's "letex", which gives a way of expanding local symbols
; into an expression before evaluating it, and "args",
; which returns all the arguments that are passed to your macro.

; SYMBOL CONFUSION
; ================

; One problem to be aware of when you're writing macros is the way that symbol names in macros
; can be confused with symbol names in the code that calls the macro.
; Here's a simple macro which adds a new looping construct to the language
; that combines dolist and do-while.
; A loop variable steps through a list while a condition is true:

(define-macro (dolist-while:dolist-while)
  (letex (var (args 0 0)
          lst (args 0 1)
          cnd (args 0 2)
          body (cons 'begin (1 (args))))
    (let (res)
      (catch (dolist (var lst)
                     (if (set 'res cnd) body (throw res)))))))

; It's called like this:

(dolist-while (x (sequence 20 0) (> x 10))
(println {x is } (dec x 1)))

;-> x is 19
;-> x is 18
;-> x is 17
;-> x is 16
;-> x is 15
;-> x is 14
;-> x is 13
;-> x is 12
;-> x is 11
;-> x is 10

; And it appears to work well.
; But there's a subtle problem: you can't use a symbol called y as the loop variable,
; even though you can use x or anything else.

; Put a (println y) statement in the loop to see why:

(dolist-while (x (sequence 20 0) (> x 16))
  (println {x is } (dec x 1))
  (println {y is } y))
;-> x is 19
;-> y is nil
;-> x is 18
;-> y is nil
;-> x is 17
;-> y is nil

; If you try to use y, it won't work:

(dolist-while (y (sequence 20 0) (> y 10))
  (println {y is } (dec y 1)))

;-> y is
;-> value expected in function dec : y

; The problem is that y is used by the macro to hold the condition value,
; even though it's in its own let expression.
; It appears as a true/nil value, so it can't be decremented.
; To fix this problem, enclose the macro inside a context,
; and make the macro the default function in that context:

(context 'dolist-while)
(define-macro (dolist-while:dolist-while)
  (letex (var (args 0 0)
          lst (args 0 1)
          cnd (args 0 2)
          body (cons 'begin (1 (args))))
    (let (res)
      (catch (dolist (var lst)
                     (if (set 'res cnd) body (throw res)))))))
(context MAIN)

; This can be used in the same way, but without any problems:

(dolist-while (y (sequence 20 0) (> y 16))
  (println {y is } (dec y 1)))
;-> y is 19
;-> y is 18
;-> y is 17
;-> y is 16

; OTHER IDEAS FOR MACROS
; ======================

; newLISP users find many different reasons to use macros.
; Here are a couple of macro definitions I've found on the newLISP user forums.
; Here's a version of case, called ecase (evaluated-case) that really does evaluate the tests:

(define-macro (ecase _v)
  (eval (append
    (list 'case _v)
    (map (fn (_i) (cons (eval (_i 0)) (rest _i)))
      (args)))))

(define (test n)
  (ecase n
    ((/ 4 4) (println "n was 1"))
    ((- 12 10) (println "n was 2"))))

(set 'n 2)
(test n)

;-> n was 2

; You can see that the divisions (/ 4 4) and (- 12 10) were both evaluated.
; They wouldn't have been with the standard version of case.
; Here's a macro that creates functions:

(define-macro (create-functions group-name)
  (letex
    ((f1 (sym (append (term group-name) "1")))
     (f2 (sym (append (term group-name) "2"))))

  (define (f1 arg) (+ arg 1))
  (define (f2 arg) (+ arg 2))))

(create-functions foo)
; this creates two functions starting with 'foo'

(foo1 10)
;-> 11

(foo2 10)
;-> 12

(create-functions bar)
; and this creates two functions starting with 'bar'

(bar1 12)
;-> 13

(bar2 12)
;-> 14

; A TRACER MACRO
; ==============

; The following code changes the operation of newLISP
; so that every function defined using define will, when evaluated,
; add its name and details of its arguments to a log file.
; When you run a script, the log file will contain
; a record of the functions and arguments that were evaluated.

(context 'tracer)

(define-macro (tracer:tracer farg)
  (set (farg 0)
  (letex (func  (farg 0)
          arg   (rest farg)
          arg-p (cons 'list (map (fn (x) (if (list? x) (first x) x)) (rest farg)))
          body  (cons 'begin (args)))
         (lambda
            arg
            (append-file
                (string (env "HOME") "/trace.log")
                (string 'func { } arg-p "\n"))
            body))))

(context MAIN)

(constant (global 'newLISP-define) define)
; redefine the built-in define:

(constant (global 'define) tracer)

; To run a script with this simple tracer, load the context before you run:

(load {tracer.lsp})

; The log file generated contains:
; a list of every function that was called, and the arguments it received:

;-> Time:Time (1211760000 0)
;-> Time:Time (1230163200 0)
;-> Time:Time (1219686599 0)
;-> show ((Time 1211760000 0))
;-> show ((Time 1230163200 0))
;-> get-hours ((Time 1219686599 0))
;-> get-day ((Time 1219686599 0))
;-> days-between ((Time 1219686599 0) (Time 1230163200 0))
;-> leap-year? ((Time 1211760000 0))
;-> adjust-days ((Time 1230163200 0) 3)
;-> show ((Time 1230422400 0))
;-> Time:Time (1219686599 0)
;-> days-between ((Time 1219686599 0) (Time 1230422400 0))
;-> Duration:Duration (124.256956)
;-> period-to-string ((Duration 124.256956))
;-> days-between ((Time 1219686599 0) (Time 1230422400 0))
;-> Duration:Duration (124.256956)
;-> Time:print ((Time 1211760000 0))
;-> Time:string ((Time 1211760000 0))
;-> Duration:print ((Duration 124.256956))
;-> Duration:string ((Duration 124.256956))

; It will slow execution quite a lot.

; WORKING WITH NUMBERS
; ====================

; newLISP includes most of the basic functions that you'd expect to find, plus many more.
; This section is designed to help you make the best use of them
; and to avoid some of the minor pitfalls that you might encounter.
; As always, see the official documentation for full details.

; INTEGERS AND FLOATING-POINT NUMBERS
; ===================================

; newLISP handles two different types of number: the integer and the floating-point number.
; Integers are precise, whereas floating-point numbers (floats) are less precise.
; There are advantages and disadvantages to each.
; If you need to use very large integers, larger than 9 223 372 036 854 775 807,
; you can choose between large (64-bit) integers and big integers (of unlimited size).
; The arithmetic operators +, -, *, /, and % always return integer values.
; The arithmetic operators "add", "sub", "mul", "div" works with floating numbers.
; A common mistake is to use / and * forgetting that they're carrying out integer arithmetic:

(/ 10 3)
;-> 3

; This might not be what you were expecting!

(div 10 3)
;-> 3.333333333333334

; Floating-point numbers keep only the 15 or 16 most important digits
; (ie the digits at the left of the number, with the highest place values).
; The philosophy of a floating-point number is that's close enough,
; rather than that's the exact value.
; Suppose you try to define a symbol PI to store the value of pi to 50 decimal places:

(constant 'PI 3.14159265358979323846264338327950288419716939937510)
;-> 3.141592654

(println PI)
;-> 3.141592654

; It looks like newLISP has cut about 40 digits off the right hand side!
; In fact about 15 or 16 digits have been stored,
; and 35 of the less important digits have been discarded.
; How does newLISP store this number? Let's look using the format function:

(format {%1.50f} PI)
;-> "3.14159265358979310000000000000000000000000000000000"

; Now let's make a little script to compare both numbers as strings,
; so we don't have to grep visually the differences:

(setq original-pi-str "3.14159265358979323846264338327950288419716939937510")
(setq pi (float original-pi-str))
(setq saved-pi-str (format {%1.50f} pi))
(println pi " -> saved pi (float)")
(println saved-pi-str " -> saved pi formatted")
(println original-pi-str " -> original pi")
(dotimes (i (length original-pi-str) (!= (original-pi-str i) (saved-pi-str i)))
  (print (original-pi-str i)))
(println " -> original and saved versions are equal up to this")

;-> "3.14159265358979323846264338327950288419716939937510"
;-> "3.14159265358979310000000000000000000000000000000000"
;-> 3.141592653589793 -> saved pi (float)
;-> 3.14159265358979310000000000000000000000000000000000 -> saved pi formatted
;-> 3.14159265358979323846264338327950288419716939937510 -> original pi
;-> 3.141592653589793 -> original and saved versions are equal up to this

; The value is accurate up to 9793, but then drifts away
; from the more precise string you originally supplied.
; The numbers after 9793 are typical of the way all computers store floating-point values.
; It isn't newLISP being creative with your data!

; The largest float you can use seems to be - on my machine, at least - about 10^308.
; Only the first 15 or so digits are stored, though,
; so that's mostly zeroes, and you can't really add 1 to it.
; Another example of the motto of a floating-point number: that's close enough!
; The above comments are true for most computer languages, by the way, not just newLISP.
; Floating-point numbers are a compromise between convenience, speed, and accuracy.

; INTEGER AND FLOATING POINT MATHS
; ================================

; With float numbers, use the floating-point arithmetic operators add, sub, mul, div and mod.
; With integer numbers, use +, -, *, /, and %, their integer-only equivalents.

(mul PI 2)
;-> 6.283185307

; To see the value that newLISP is storing
; (because the REPL's default output resolution is 9 or 10 digits):

(format {%1.16f} (mul PI 2))
;-> "6.2831853071795862"

; If you forget to use mul here, and use * instead,
; the numbers after the decimal point are thrown away:

(format {%1.16f} (* PI 2))
;-> "6.0000000000000000"

; Here, pi was converted to 3 and then multiplied by 2.
; You can re-define the familiar arithmetic operators
; so that they default to using floating-point routines
; rather than integer-only arithmetic:

; before
(+ 1.1 1.1)
;-> 2

(constant (global '+) add)
; after
(+ 1.1 1.1)
;-> 2.2

; You could put these definitions in your init.lsp file to have them available for all work.
; The main problem you'll find is when sharing code with others, or using imported libraries.
; Their code might produce surprising results, or yours might!

; CONVERSIONS: EXPLICIT AND IMPLICIT
; ==================================

; To convert strings into numbers, or numbers of one type into another,
; use the "int" and "float" functions.
; The main use for these is to convert a string into a number - either an integer or a float.
; For example, you might be using a regular expression
; to extract a string of digits from a longer string:

(map int (find-all {\d+} {the answer is 42, not 41}))
;-> (42 41) ; a list of integers

(map float (find-all {\d+(\.\d+)?} {the value of pi is 3.14, not 1.618}))
;-> (3.14 1.618) ; a list of floats

; A second argument passed to "int" specifies a default value
; which should be used if the conversion fails:

(int "x")
;-> nil

(int "x" 0)
;-> 0

; "int" can also convert strings representing numbers in number bases other than 10 into numbers.
; For example, to convert a hexadecimal number in string form to a decimal number,
; make sure it is prefixed with 0x, and don't use letters beyond f:

(int (string "0x" "1F"))
;-> 31

(int (string "0x" "decaff"))
;-> 14600959

; And you can convert strings containing octal numbers by prefixing them with just a 0:

(int "035")
;-> 29

; Binary numbers can be converted by prefixing them with 0b:

(int "0b100100100101001001000000000000000000000010100100")
;-> 160881958715556

; Even if you never use octal or hexadecimal, it's worth knowing about these conversions,
; because one day you might, either deliberately or accidentally, write this:

(int "08")
;-> 0

; which evaluates to 0 rather than the expected decimal 8 (a failed octal-decimal conversion).
; For this reason, it's always a good idea to specify not only a default value,
; but also a number base whenever you use int on string input:

(int "08" 0 10) ; default to 0 and assume base 10
;-> 8

; If you're working with big integers (integers larger than 64-bit integers),
; use "bigint" rather than "int".

; INVISIBLE CONVERSION AND ROUNDING
; =================================

; Some functions convert floating-point numbers to integers automatically.
; Since newLISP version 10.2.0 all operators made of letters of the alphabet produce floats
; and operators written with special characters produce integers.

; So using "+" will convert and round your numbers to integers,
; and using "inc" will convert your numbers to floats:

(setq an-integer 2)
;-> 2

(float? an-integer)
;-> nil

(inc an-integer)
;-> 3

(float? an-integer)
;-> true

(setq a-float (sqrt 2))
;-> 1.414213562

(integer? a-float)
;-> nil

(++ a-float)
;-> 2

(integer? a-float)
;-> true

; To make "inc" and "dec" work on lists you need to access specific elements
; or use "map" to process all:

(setq numbers '(2 6 9 12))
;-> (2 6 9 12)

(inc (numbers 0))
;-> 3

numbers
;-> (3 6 9 12)

(map inc numbers)
;-> (4 7 10 13)
; but WATCH OUT!

(map (curry inc 3) numbers) ; this one doesn't produce what you expected
;-> (6 12 21 33)

; use this instead:
(map (curry + 3) numbers)
;-> (6 9 12 15)

; Many newLISP functions automatically convert integer arguments into floating-point values.
; This usually isn't a problem.
; But it's possible to lose some precision if you pass extremely large integers
; to functions that convert to floating-point:

(format {%15.15f} (add 1 922337203685477580))
;-> "922337203685477632.000000000000000"

; Because the "add" function converted the very large integer to a float,
; a small amount of precision was lost (amounting to about 52, in this case).
; Close enough? If not, think carefully about how you store and manipulate numbers.

; NUMBER TESTING
; ==============

; Sometimes you will want to test whether a number is an integer or a float:

(set 'PI 3.141592653589793)
;-> 3.141592654
(integer? PI)
;-> nil
(float? PI)
;-> true
(number? PI)
;-> true
(zero? PI)
;-> nil

; With "integer?" and "float?", you test whether the number is stored as an integer or float,
; not whether the number is mathematically an integer or a floating-point value.
; For example, this test returns nil, which might surprise you:

(integer? (div 30 3))
;-> nil

; It's not that the answer isn't 10 (it is), but rather that the answer is a floating-point 10,
; not an integer 10, because the div function always returns a floating-point value.

; ABSOLUTE SIGNS, FROM FLOOR TO CEILING
; =====================================

; The "floor" and "ceil" functions return floating-point numbers that contain integer values.
; For example, if you use "floor" to round pi down to the nearest integer, the result is 3,
; but it's stored as a float not as an integer:

(integer? (floor PI))
;-> nil

(floor PI)
;-> 3

(float? (ceil PI))
;-> true

; The "abs" and "sgn" functions can also be used when testing and converting numbers.
; "abs" always returns a positive version of its argument.
; "sgn" returns 1, 0, or -1, depending on whether the argument is positive, zero, or negative.
; The "round" function rounds numbers to the nearest whole number, with floats remaining floats.
; You can also supply an optional additional value
; to round the number to a specific number of digits.
; Negative numbers round after the decimal point,
; positive numbers round before the decimal point.

(set 'n 1234.6789)

(for (i -6 6)
  (println (format {%4d %12.5f} i (round n i))))

; -6 1234.67890
; -5 1234.67890
; -4 1234.67890
; -3 1234.67900
; -2 1234.68000
; -1 1234.70000
; 0 1235.00000
; 1 1230.00000
; 2 1200.00000
; 3 1000.00000
; 4 0.00000
; 5 0.00000
; 6 0.00000

; "sgn" has an alternative syntax that lets you evaluate up to three different expressions
; depending on whether the first argument is negative, zero, or positive.

(for (i -5 5)
  (println i " is " (sgn i "below 0" "0" "above 0")))

; -5 is below 0
; -4 is below 0
; -3 is below 0
; -2 is below 0
; -1 is below 0
; 0 is 0
; 1 is above 0
; 2 is above 0
; 3 is above 0
; 4 is above 0
; 5 is above 0

; NUMBER FORMATTING
; =================

; To convert numbers into strings, use the "string" and "format" functions:

(reverse (string PI))
;-> "456395141.3"

; Both "string" and "println" use only the first 10 or so digits,
; even though more (up to 15 or 16) are stored internally.

; Use "format" to output numbers with more control:

(format {%1.15f} PI)
;-> "3.141592653589793"

; The "format" specification string uses the widely-adopted printf-style formatting.
; Remember too that you can use the results of the "format" function:

(string "the value of pi is " (format {%1.15f} PI))
;-> "the value of pi is 3.141592653589793"

; The "format" function lets you output numbers as hexadecimal strings as well:

(format "%x" 65535)
;-> "ffff"

; FORMAT CHEAT SHEET
; ==================

; syntax: (format str-format exp-data-1 [exp-data-2 ... ])
; syntax: (format str-format list-data)

; Constructs a formatted string from exp-data-1
; using the format specified in the evaluation of str-format.

; The format specified is identical to the format used
; for the printf() function in the ANSI C language.

; Two or more exp-data arguments can be specified
; for more than one format specifier in str-format.

; In an alternative syntax, the data to be formatted can be passed inside a list in list-data.

; "format" checks for a valid format string, matching data type,
; and the correct number of arguments.
; Wrong formats or data types result in error messages.
; int, float, or string can be used to ensure correct data types and to avoid error messages.

; The format string has the following general format:

; "%w.pf"

; The % (percent sign) starts a format specification.
; To display a % inside a format string, double it: %%

; On Linux the percent sign can be followed by a single quote %'
; to insert thousand's separators in number formats.

; The "w" represents the width field.
; Data is right-aligned, except when preceded by a minus sign, in which case it is left-aligned.
; If preceded by a + (plus sign), positive numbers are displayed with a +.
; When preceded by a 0 (zero), the unused space is filled with leading zeroes.
; The width field is optional and serves all data types.

; The "p" represents the precision number of decimals (floating point only)
; or strings and is separated from the width field by a period.
; Precision is optional. When using the precision field on strings,
; the number of characters displayed is limited to the number in p.

; The "f" represents a type flag and is essential, it cannot be omitted.

; Below are the types in "f":

; ----------------------------------------------------------------------
; |format | description                                                |
; ----------------------------------------------------------------------
; |  s    | text string                                                |
; |  c    | character (value 1 - 255)                                  |
; |  d    | decimal (32-bit)                                           |
; |  u    | unsigned decimal (32-bit)                                  |
; |  x    | hexadecimal lowercase                                      |
; |  X    | hexadecimal uppercase                                      |
; |  o    | octal (32-bits) (not supported on all of newLISP flavors)  |
; |  f    | floating point                                             |
; |  e    | scientific floating point                                  |
; |  E    | scientific floating point                                  |
; |  g    | general floating point                                     |
; ----------------------------------------------------------------------

; Formatting 64-bit numbers using the 32-bit format specifiers from above table will truncate
; and format the lower 32 bits of the number on 64-bit systerms
; and overflow to 0xFFFFFFFF on 32-bit systems.

; For 32-bit and 64-bit numbers use the following format strings.
; 64-bit numbers will be truncated to 32-bit on 32-bit platforms:

; -------------------------------------------------
; | format    | description                       |
; -------------------------------------------------
; | ld        | decimal (32/64-bit)               |
; | lu        | unsigned decimal (32/64-bit)      |
; | lx        | hexadecimal (32/64-bit)           |
; | lX        | hexadecimal uppercase (32/64-bit) |
; -------------------------------------------------

; Examples
(format ">>>%6.2f<<<" 1.2345)           → ">>>  1.23<<<"
(format ">>>%-6.2f<<<" 1.2345)          → ">>>1.23  <<<"
(format ">>>%+6.2f<<<" 1.2345)          → ">>> +1.23<<<"
(format ">>>%+6.2f<<<" -1.2345)         → ">>> -1.23<<<"
(format ">>>%-+6.2f<<<" -1.2345)        → ">>>-1.23 <<<"

(format "%e" 123456789)                 → "1.234568e+08"
(format "%12.10E" 123456789)            → "1.2345678900E+08"

(format "%10g" 1.23)                    → "      1.23"
(format "%10g" 1.234)                   → "     1.234"

(format "Result = %05d" 2)              → "Result = 00002"

(format "%14.2f" 12345678.12)           → "   12345678.12"

; on UNIX glibc compatible platforms only (Linux, MAC OS X 10.9) on some locales
(format "%'14.2f" 12345678.12)          → " 12,345,678.12"

(format "%8d" 12345)                    → "   12345"

; on UNIX glibc compatible platforms only (Linux, MAC OS X 10.9) on some locales
(format "%'8d" 12345)                   → "  12,345"

(format "%-15s" "hello")                → "hello          "
(format "%15s %d" "hello" 123)          → "          hello 123"
(format "%5.2s" "hello")                → "   he"
(format "%-5.2s" "hello")               → "he   "

(format "%o" 80)                        → "120"

(format "%x %X" -1 -1)                  → "ffffffff FFFFFFFF"

; 64 bit numbers on Windows
(format "%I64X" 123456789012345678)     → "1B69B4BA630F34E"

; 64 bit numbers on Unix (except TRU64)
(format "%llX" 123456789012345678)      → "1B69B4BA630F34E"

(format "%c" 65)                        → "A"

; The data to be formatted can be passed inside a list:

(set 'L '("hello" 123))
(format "%15s %d" L)                    → "          hello 123"

; If the format string requires it, newLISP's format will automatically
; convert integers into floating points or floating points into integers:

(format "%f" 123)                       → 123.000000

(format "%d" 123.456)                   → 123

; NUMBER UTILITIES
; ================

; CREATING NUMBERS
; ================

; SEQUENCE AND SERIES
; ===================

; "sequence" produces a list of numbers in an arithmetical sequence.
; Supply start and finish numbers (inclusive), and a step value:

(sequence 1 10 1.5)
;-> (1 2.5 4 5.5 7 8.5 10)

; If you specify a step value, all the numbers are stored as floats,
; even if the results are integers,
; otherwise they're integers:

; with step value sequence gives floats:

(sequence 1 10 2)
;-> (1 3 5 7 9)

(map float? (sequence 1 10 2))
;-> (true true true true true)

; without step value sequence gives integers:

(sequence 1 5)
;-> (1 2 3 4 5)

> (map float? (sequence 1 5))
;-> (nil nil nil nil nil)

; "series" multiplies its first argument by its second argument a number of times.
; The number of repeats is specified by the third argument.
; This produces geometric sequences:

(series 1 2 20)
;-> (1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768 65536 131072 262144 524288)

; Every number is stored as a float.
; The second argument of series can also be a function.
; The function is applied to the first number, then to the result, then to that result, and so on.

(series 10 sqrt 20)
;-> (10 3.16227766 1.77827941 1.333521432 1.154781985 1.074607828 1.036632928
;-> 1.018151722 1.009035045 1.004507364 1.002251148 1.001124941 1.000562313
;-> 1.000281117 1.000140549 1.000070272 1.000035135 1.000017567 1.00000878
;-> 1.000004392)

; The "normal" function returns a list of floating-point numbers
; with a specified mean and a standard deviation.
; For example, a list of 6 numbers with a mean of 10
; and a standard deviation of 5 can be produced as follows:

(normal 10 5 6)
;-> (6.5234375 14.91210938 6.748046875 3.540039062 4.94140625 7.1484375)

; RANDOM NUMBERS
; ==============

; "rand" creates a list of randomly chosen integers less than a number you supply:

(rand 7 20)
; 20 numbers between 0 and 6 (inclusive) or 7 (exclusive)
;-> (0 0 2 6 6 6 2 1 1 1 6 2 0 6 0 5 2 4 4 3)

; Obviously (rand 1) generates a list of zeroes and isn't useful.
; (rand 0) doesn't do anything useful either,
; but it's been assigned the job of initializing the random number generator.
; If you leave out the second number, it just generates a single random number in the range.
; "random" generates a list of floating-point numbers multiplied by a scale factor,
; starting at the first argument:

(random 0 2 10)
; 10 numbers starting at 0 and scaled by 2
;-> (1.565273852e-05 0.2630755763 1.511210644 0.9173002638
;->  1.065534475 0.4379183727 0.09408923243 1.357729434
;->  1.358592812 1.869385792))

; RANDOMNESS
; ==========

; Use "seed" to control the randomness of rand (integers), random (floats),
; randomize (shuffled lists), and amb (list elements chosen at random).
; If you don't use "seed", the same set of random numbers appears each time.
; This provides you with a predictable randomness - useful for debugging.
; When you want to simulate the randomness of the real world,
; seed the random number generator with a different value each time you run the script:
; Without seed:

; today
(for (i 10 20)
  (print (rand i) { }))
7 1 5 10 6 2 8 0 17 18 0

; tomorrow
(for (i 10 20)
  (print (rand i) { }))
7 1 5 10 6 2 8 0 17 18 0 ; same as yesterday

; With seed:

; today
(seed (date-value))
(for (i 10 20)
  (print (rand i) { }))
2 10 3 10 1 11 8 13 6 4 0

; tomorrow
(seed (date-value))
(for (i 10 20)
  (print (rand i) { }))
0 7 10 5 5 8 10 16 3 1 9

; GENERAL NUMBER TOOLS
; ====================

; "min" and "max" work as you would expect though they always return floats.
; Like many of the arithmetic operators, you can supply more than one value:

(max 1 2 13.2 4 2 1 4 3 2 1 0.2)
;-> 13.2
(min -1 2 17 4 2 1 43 -20 1.1 0.2)
;-> -20
(float? (max 1 2 3))
;-> true

; The comparison functions allow you to supply just a single argument.
; If you use them with numbers, newLISP helpfully assumes that you're comparing with 0.
; Remember that you're using postfix notation:

(set 'n 3)
(> n)
;-> true, assumes test for greater than 0

(< n)
;-> nil, assumes test for less than 0

(set 'n 0)
(>= n)
;-> true

; The "factor" function finds the factors for an integer and returns them in a list.
; It's a useful way of testing a number to see if it's prime:

(factor 5)
;-> (5)
(factor 42)
;-> (2 3 7)

(define (prime? n)
  (and
    (set 'lst (factor n))
    (= (length lst) 1)))

(for (i 0 30)
(if (prime? i) (println i)))

; FLOATING-POINT UTILITIES
; ========================

; If omitted, the second argument to the "pow" function defaults to 2.

(pow 2) ; default is squared
;-> 4

(pow 2 2 2 2) ; (((2 squared) squared) squared)
;-> 256

(pow 2 8) ; 2 to the 8
;-> 256

(pow 2 3)
;-> 8

(pow 2 0.5) ; square root
;-> 1.414213562

; You can also use "sqrt" to find square roots. To find cube and other roots, use "pow":

(pow 8 (div 1 3)) ; 8 to the 1/3
;-> 2

; The "exp" function calculates e^x,
; where e is the mathematical constant 2.718281828, and x is the argument:

(exp 1)
;-> 2.71828128

; The "log" function has two forms. If you omit the base, natural logarithms are used:

(log 3) ; natural (base e) logarithms
;-> 1.098612289

; Or you can specify another base, such as 2 or 10:

(log 3 2)
;-> 1.584962501

(log 3 10) ; logarithm base 10
;-> 0.4771212547

; Other mathematical functions available by default in newLISP are "fft" (fast Fourier transform),
; and "ifft" (inverse fast Fourier transform).

; TRIGONOMETRY
; ============

; All the trigonometry functions "sin", "cos", "tan", "asin", "acos", "atan", "atan2",
; and the hyperbolic functions "sinh", "cosh", and "tanh", work in radians.
; If you prefer to work in degrees, you can define alternative versions as functions:

(constant 'PI 3.141592653589793)

(define (rad->deg r)
  (mul r (div 180 PI)))

(define (deg->rad d)
  (mul d (div PI 180)))

(define (sind _e)
  (sin (deg->rad (eval _e))))

(define (cosd _e)
  (cos (deg->rad (eval _e))))

(define (tand _e)
  (tan (deg->rad (eval _e))))

(define (asind _e)
  (rad->deg (asin (eval _e))))

(define (atan2d _e _f)
  (rad->deg (atan2 (deg->rad (eval _e)) (deg->rad (eval _f)))))

; and so on...

; When writing equations, one approach is to build them up from the end first.
; For example, to convert an equation like this:

; alfa = arctan( (sin(lamda) * cos(epsilon))/ (cos(epsilon)))

; build it up in stages, like this:

; 1                                  (tand beta)
; 2                                  (tand beta) (sind epsilon)
; 3                             (mul (tand beta) (sind epsilon))
; 4 (sind lamda)                (mul (tand beta) (sind epsilon))
; 5 (sind lamda) (cosd epsilon) (mul (tand beta) (sind epsilon))
; 6 (sub (mul (sind lamda) (cosd epsilon))
;                               (mul (tand beta) (sind epsilon)))
; 7 (atan2d (sub (mul (sind lamda) (cosd epsilon)) (mul (tand beta)(sind epsilon)))
;           (cosd lamda))
; 8 (set 'alpha

; and so on...

; It's often useful to line up the various expressions in your text editor:

(set 'right-ascension
  (atan2d
    (sub
      (mul
        (sind lamda)
        (cosd epsilon))
      (mul
        (tand beta)
        (sind epsilon)))
    (cosd lamda)))

; If you have to convert a lot of mathematical expressions from infix to postfix notation,
; you might want to investigate the infix.lsp module (available from the newLISP website):

(load "/usr/share/newlisp/modules/infix.lsp")
(INFIX:xlate
"(sin(lamda) * cos(epsilon)) - (cos(beta) * sin(epsilon))")
;-> (sub (mul (sin lamda) (cos epsilon)) (mul (tan beta) (sin epsilon)))

; ARRAYS
; ======

; newLISP provides multidimensional arrays. Arrays are very similar to lists,
; and you can use most of the functions that operate on lists on arrays too.

; A large array can be faster than a list of similar size.
; The following code uses the "time" function to compare how fast arrays and lists work.

(for (size 950 1000)
  ; create an array
  (set 'arry (array size (randomize (sequence 0 size))))
  ; create a list
  (set 'lst (randomize (sequence 0 size)))
  (set 'array-time
    (time (dotimes (x (/ size 2))
      (nth x arry)) 1000))
  ; repeat at least 1000 times to get non-zero time!
  (set 'list-time
    (time (dotimes (x (/ size 2))
      (nth x lst)) 1000))
  (println "with " size " elements: array access: "
    array-time
    " - list access: "
    list-time
    " "
    (div list-time array-time )))

;-> with 950 elements: array access: 15.857 - list access: 187.485 11.82348489626033
;-> with 951 elements: array access: 15.625 - list access: 203.108 12.998912
;-> with 952 elements: array access: 15.625 - list access: 218.731 13.998784
;-> with 953 elements: array access: 15.637 - list access: 203.109 12.9890004476562
;-> ...
;-> with 997 elements: array access: 15.628 - list access: 234.519 15.00633478372153
;-> with 998 elements: array access: 15.642 - list access: 234.356 14.98248305843243
;-> with 999 elements: array access: 31.243 - list access: 203.114 6.501104247351408
;-> with 1000 elements: array access: 15.623 - list access: 234.352 15.0004480573513

; The exact times will vary from machine to machine, but typically,
; with 200 elements, arrays and lists are comparable in speed.
; As the sizes of the list and array increase, the execution time of the nth function increases.
; By the time the list and array contain 1000 elements each,
; the array is 2 to 3 times faster to access than the list.

; To create an array, use the "array" function.
; You can make a new empty array, make a new one and fill it with default values,
; or make a new array that's an exact copy of an existing list.

(set 'table (array 10)) ; new empty array

(set 'lst (randomize (sequence 0 20))) ; new full list

(set 'arry (array (length lst) lst)) ; new array copy of a list

; To make a new list that's a copy of an existing array, use the array-list function:

(set 'lst2 (array-list arry)) ; makes new list

; To see the difference between lists and arrays, use the "list?" and "array?" predicates:

(array? arry)
;-> true

(list? lst)
;-> true

; FUNCTIONS AVAILABLE FOR ARRAYS
; ==============================

; The following general-purpose functions work equally well on arrays and lists:
; "first", "last", "rest", "mat", "nth", "setf", "sort", "append", and "slice".

; There are also some functions for arrays and lists that provide matrix operations:
; "invert", "det", "multiply", "transpose".

; Arrays can be multi-dimensional.
; For example, to create a 2 by 2 table, filled with 0s, use this:

(set 'arry (array 2 2 '(0)))
;-> ((0 0) (0 0))

; The third argument to array supplies some initial values used to fill the array.
; newLISP uses the value as effectively as it can.
; So, for example, you can supply a more than sufficient initializing expression:

(set 'arry (array 2 2 (sequence 0 10)))
arry
;-> ((0 1) (2 3)) ; don't need all of them

; or just provide a hint or two:

(set 'arry (array 2 2 (list 1 2)))
arry
;-> ((1 2) (1 2))

(set 'arry (array 2 2 '(42)))
arry
;-> ((42 42) (42 42))

; This array initialization facility is cool, you can use it even when creating lists:

(set 'maze (array-list (array 10 10 (randomize (sequence 0 10)))))
;-> ((9 4 0 2 10 6 7 1 8 5)
;->  (3 9 4 0 2 10 6 7 1 8)
;->  (5 3 9 4 0 2 10 6 7 1)
;->  (8 5 3 9 4 0 2 10 6 7)
;->  (1 8 5 3 9 4 0 2 10 6)
;->  (7 1 8 5 3 9 4 0 2 10)
;->  (6 7 1 8 5 3 9 4 0 2)
;->  (10 6 7 1 8 5 3 9 4 0)
;->  (2 10 6 7 1 8 5 3 9 4)
;->  (0 2 10 6 7 1 8 5 3 9))

; GETTING AND SETTING VALUES
; ==========================

; To get values from an array, use the "nth" function, which expects
; a list of indices for the dimensions of the array, followed by the name of the array:

(set 'size 10)
(set 'table (array size size (sequence 0 (pow size))))

(dotimes (row size)
  (dotimes (column size)
    (print (format {%3d} (nth (list row column) table))))
  ; end of row
  (println {}))

;->   0  1  2  3  4  5  6  7  8  9
;->  10 11 12 13 14 15 16 17 18 19
;->  20 21 22 23 24 25 26 27 28 29
;->  30 31 32 33 34 35 36 37 38 39
;->  40 41 42 43 44 45 46 47 48 49
;->  50 51 52 53 54 55 56 57 58 59
;->  60 61 62 63 64 65 66 67 68 69
;->  70 71 72 73 74 75 76 77 78 79
;->  80 81 82 83 84 85 86 87 88 89
;->  90 91 92 93 94 95 96 97 98 99

; "nth" also works with lists and strings.

; As with lists, you can use implicit addressing to get values:

(set 'size 10)

(set 'table (array size size (sequence 0 (pow size))))

(table 3)
;-> (30 31 32 33 34 35 36 37 38 39) ; row 3 (0-based!)

(table 3 3) ; row 3 column 3 implicitly
;-> 33

; To set values, use "setf".
; The following code replaces every number that isn't prime with 0:

(set 'size 10)
(set 'table (array size size (sequence 0 (pow size))))
(dotimes (row size)
(dotimes (column size)
(if (not (= 1 (length (factor (nth (list row column) table)))))
(setf (table row column) 0))))
table
;-> ((0 0 2 3 0 5 0 7 0 0)
;->  (0 11 0 13 0 0 0 17 0 19)
;->  (0 0 0 23 0 0 00 0 29)
;->  (0 31 0 0 0 0 0 37 0 0)
;->  (0 41 0 43 0 0 0 47 0 0)
;->  (0 0 0 53 0 0 0 0 0 59)
;->  (0 61 0 0 0 0 0 67 0 0)
;->  (0 71 0 73 0 0 0 0 0 79)
;->  (0 0 0 83 0 0 0 0 0 89)
;->  (0 0 0 0 0 0 0 97 0 0))

; Instead of the implicit addressing (table row column),
; I could have written (setf (nth (list row column) table) 0).
; Implicit addressing is slightly faster, but using "nth" can make code easier to read.

; MATRICES
; ========

; There are functions that treat an array or a list (with the correct structure) as a matrix.
; - "invert" returns the inversion of a matrix
; - "det" calculates the determinant
; - "multiply" multiplies two matrices
; - "mat" applies a function to two matrices or to a matrix and a number
; - "transpose" returns the transposition of a matrix

; "transpose" is also useful when used on nested lists.

; STATISTICS, FINANCIAL, AND MODELLING FUNCTIONS
; ==============================================

; newLISP has an extensive set of functions for financial and statistical analysis,
; and for simulation modelling.

; Given a list of numbers, the "stats" function returns
; 1) the number of values,
; 2) the mean,
; 3) average deviation from mean value,
; 4) standard deviation (population estimate),
; 5) variance (population estimate),
; 6) skew of distribution,
; 7) and kurtosis of distribution:

(set 'data (sequence 1 10))
;->(1 2 3 4 5 6 7 8 9 10)

(stats data)
(10 5.5 2.5 3.02765035409749 9.16666666666667 0 -1.56163636363636)

; Here's a list of other functions built in:
; - "beta" calculate the beta function
; - "betai" calculate the incomplete beta function
; - "binomial" calculate the binomial function
; - "corr" calculate the Pearson product-moment correlation coefficient
; - "crit-chi2" calculate the Chi square for a given probability
; - "crit-f" calculate the critical minimum F for a given confidence probability
; - "crit-t" calculate the critical minimum Student's t for a given confidence probability
; - "crit-z" calculate the critical normal distributed Z value of a given cumulated probability
; - "erf" calculate the error function of a number
; - "gammai" calculate the incomplete gamma function
; - "gammaln" calculate the log gamma function
; - "kmeans-query" calculate the Euclidian distances from the data vector to centroids
; - "kmeans-train" perform Kmeans cluster analysis on matrix-data
; - "normal" produce a list of normal distributed floating point numbers
; - "prob-chi2" calculate the cumulated probability of a Chi square
; - "prob-f" find the probability of an observed statistic
; - "prob-t" find the probability of normal distributed value
; - "prob-z" calculate the cumulated probability of a Z value
; - "stats" find statistical values of central tendency and distribution moments of values
; - "t-test" use student's t-test to compare the mean value

; BAYESIAN ANALYSIS
; =================

; Statistical methods developed initially by Reverend Thomas Bayes in the 18th century
; have proved versatile and popular enough to enter the programming languages of today.
; In newLISP, two functions, "bayes-train" and "bayesquery", work together to provide
; an easy way to calculate Bayesian probabilities for datasets.
; Here's how to use the two functions to predict the likelihood that a short piece of text
; is written by one of two authors.
; First, choose texts from the two authors, and generate datasets for each.
; I've chosen Oscar Wilde and Conan Doyle.

(set 'doyle-data
  (parse (lower-case
    (read-file "/Users/me/Documents/sign-of-four.txt")) {\W} 0))

(set 'wilde-data
  (parse (lower-case
    (read-file "/Users/me/Documents/dorian-grey.txt")) {\W} 0))

; The "bayes-train" function can now scan these two data sets and
; store the word frequencies in a new context, which I'm calling Lexicon:

(bayes-train doyle-data wilde-data 'Lexicon)

; This context now contains a list of words that occur in the texts, and the frequencies of each.
; For example:

Lexicon:_always
;-> (21 110)

; ie the word always appeared 21 times in Conan Doyle's text, and 110 times in Wilde's.
; Next, the Lexicon context can be saved in a file:

(save "/Users/me/Documents/lex.lsp" 'Lexicon)

; and reloaded whenever necessary with:

(load "/Users/me/Documents/lex.lsp")

; Now you can use the "bayes-query" function to look up a list of words in a context,
; and return two numbers:
; the probabilities of the words belonging to the first or second set of words.
; Here are three queries.
; Remember that the first set was Doyle, the second was Wilde:

(set 'quote1
  (bayes-query
    (parse (lower-case
     "the latest vegetable alkaloid" ) {\W} 0)
    'Lexicon))
;-> (0.973352412 0.02664758802)

(set 'quote2
  (bayes-query
    (parse (lower-case
     "observations of threadbare morality to listen to" ) {\W} 0)
    'Lexicon))
;-> (0.5 0.5)

(set 'quote3
  (bayes-query
    (parse (lower-case
     "after breakfast he flung himself down on a divan and lit a cigarette" ){\W} 0)
    'Lexicon))
;-> (0.01961482169 0.9803851783)

; These numbers suggest that quote1 is probably (97% certain) from Conan Doyle,
; that quote2 is neither Doylean nor Wildean, and that quote3 is likely to be from Oscar Wilde.

; Perhaps that was lucky, but it's a good result.
; The first quote is from Doyle's A Study in Scarlet,
; and the third is from Wilde's Lord Arthur Savile's Crime,
; both texts that were not included in the training process
; but - apparently - typical of the author's vocabulary.
; The second quote is from Jane Austen, and the methods developed
; are unable to assign it to either of the authors.

; FINANCIAL FUNCTIONS
; ===================

; newLISP offers the following financial functions:
; - "fv" returns the future value of an investment
; - "irr" returns the internal rate of return
; - "nper" returns the number of periods for an investment
; - "npv" returns the net present value of an investment
; - "pmt" returns the payment for a loan
; - "pv" returns the present value of an investment

; LOGIC PROGRAMMING
; =================

; The programming language Prolog made popular a type of logic programming called unification.
; newLISP provides a "unify" function that can carry out unification, by matching expressions.

(unify '(X Y) '((+ 1 2) (- (* 4 5))))
((X (+ 1 2)) (Y (- (* 4 5))))

; When using "unify", unbound variables start with an uppercase character
; to distinguish them from symbols:

; BIT OPERATORS
; =============

; The bit operators treat numbers as if they consist of 1's and 0's.
; We'll use the "bits" function that prints out numbers in binary format:

(define (binary n)
  (if (< n 0)
    ; use string format for negative numbers
    (println (format "%6d %064s" n (bits n)))
    ; else, use decimal format to be able to prefix with zeros
    (println (format "%6d %064d" n (int (bits n))))))

(binary 6)
;-> 6 0000000000000000000000000000000000000000000000000000000000000110
;-> " 6 0000000000000000000000000000000000000000000000000000000000000110"

; The "shift" functions (<< and >>) move the bits to the right or left:

(binary (<< 6)) ; shift left
;-> 12 0000000000000000000000000000000000000000000000000000000000001100
;->" 12 0000000000000000000000000000000000000000000000000000000000001100"

(binary (>> 6)) ; shift right
;-> 3 0000000000000000000000000000000000000000000000000000000000000011
;->" 3 0000000000000000000000000000000000000000000000000000000000000011"

; The following operators compare the bits of two or more numbers.
; Using 4 and 5 as examples:

(map binary '(5 4))
;-> 5 0000000000000000000000000000000000000000000000000000000000000101
;-> 4 0000000000000000000000000000000000000000000000000000000000000100
;-> (" 5 0000000000000000000000000000000000000000000000000000000000000101"
;-> " 4 0000000000000000000000000000000000000000000000000000000000000100")

(binary (^ 4 5)) ; exclusive or: 1 if only 1 of the two bits is 1
;-> 1 0000000000000000000000000000000000000000000000000000000000000001
;->" 1 0000000000000000000000000000000000000000000000000000000000000001"

(binary (| 4 5)) ; or: 1 if either or both bits are 1
;-> 5 0000000000000000000000000000000000000000000000000000000000000101
;->" 5 0000000000000000000000000000000000000000000000000000000000000101"

(binary (& 4 5)) ; and: 1 only if both are 1
;-> 4 0000000000000000000000000000000000000000000000000000000000000100
;->" 4 0000000000000000000000000000000000000000000000000000000000000100"

; The negate or not function "~" reverses all the bits in a number, exchanging 1's and 0's:

(binary (~ 5)) ; not: 1 <-> 0
;-> -6 1111111111111111111111111111111111111111111111111111111111111010
;->" -6 1111111111111111111111111111111111111111111111111111111111111010"

; The binary function that prints out these strings uses
; the & function to test the last bit of the number to see if it's a 1,
; and the >> function to shift the number 1 bit to the right, ready for the next iteration.
; One use for the OR operator (|) is when you want
; to combine regular expression options with the regex function.

; "crc32" calculates a 32 bit CRC (Cyclic Redundancy Check) for a string.

; BIGGER NUMBERS
; ==============

; For most applications, integer calculations involve whole numbers
; up to 9223372036854775807 or down to -9223372036854775808.
; These are the largest integers you can store using 64 bits.
; If you add 1 to the largest 64- bit integer, you'll 'roll over' (or wrap round)
; to the negative end of the range:

(set 'large-int 9223372036854775807)
(+ large-int 1)
;-> -9223372036854775808

; But newLISP can handle much bigger integers than this, the 'bignums' or 'big integers':

(set 'number-of-atoms-in-the-universe
100000000000000000000000000000000000000000000000000000000000000000000000000000000)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000000L

(++ number-of-atoms-in-the-universe)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000001L

(length number-of-atoms-in-the-universe)
;-> 81

(float number-of-atoms-in-the-universe)
;->1e+80

; Notice that newLISP indicates a big integer using a trailing "L".
; Usually, you can do calculations with big integers without any thought:

(* 100000000000000000000000000000000 100000000000000000000000000000)
;-> 10000000000000000000000000000000000000000000000000000000000000L

; Here both operands are big integers, so the answer is automatically big as well.

; However, you need to take more care when your calculations
; combine big integers with other types of number.
; The rule is that the first argument of a calculation determines whether to use big integers.
; Compare this loop:

(for (i 1 10) (println (+ 9223372036854775800 i)))
;-> 9223372036854775801
;-> 9223372036854775802
;-> 9223372036854775803
;-> 9223372036854775804
;-> 9223372036854775805
;-> 9223372036854775806
;-> 9223372036854775807
;-> -9223372036854775808
;-> -9223372036854775807
;-> -9223372036854775806
;-> -9223372036854775806

; with this:

(for (i 1 10) (println (+ 9223372036854775800L i))) ; notice the "L"
;-> 9223372036854775801L
;-> 9223372036854775802L
;-> 9223372036854775803L
;-> 9223372036854775804L
;-> 9223372036854775805L
;-> 9223372036854775806L
;-> 9223372036854775807L
;-> 9223372036854775808L
;-> 9223372036854775809L
;-> 9223372036854775810L
;-> 9223372036854775810L

; In the first example, the first argument of the function was a large (64-bit integer).
; So adding 1 to the largest possible 64 bit integer caused a roll-over,
; the calculation stayed in the large integer realm.
; In the second example, the L appended to the first argument of the addition forced newLISP
; to switch to big integer operations even though both the operands were 64 bit integers.
; The size of the first argument determines the size of the result.
; If you supply a literal big integer, you don't have to append the "L",
; since it's obvious that the number is a big integer:

(for (i 1 10) (println (+ 92233720368547758123421231455634 i)))
;-> 92233720368547758123421231455635L
;-> 92233720368547758123421231455636L
;-> 92233720368547758123421231455637L
;-> 92233720368547758123421231455638L
;-> 92233720368547758123421231455639L
;-> 92233720368547758123421231455640L
;-> 92233720368547758123421231455641L
;-> 92233720368547758123421231455642L
;-> 92233720368547758123421231455643L
;-> 92233720368547758123421231455644L
;-> 92233720368547758123421231455644L

; There are other ways you can control the way newLISP converts between large and big integers.
; For example, you can convert something to a big integer using the "bigint" function:

(set 'bignum (bigint 9223372036854775807))

(* bignum bignum)
;-> 85070591730234615847396907784232501249L

(set 'atoms (bigint 1E+80))
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000000L

(++ atoms)
;-> 100000000000000000000000000000000000000000000000000000000000000000000000000000001L

; WORKING WITH DATES AND TIMES
; ============================

; DATE AND TIME FUNCTIONS
; =======================

; To work with dates and times, use the following functions:
; - "date" convert a seconds count to a date/time, or return date/time for now
; - "date-value" return the time in seconds since 1970-1-1 for a date and time, or for now
; - "now" return the current date/time information in a list
; - "time-of-day" return milliseconds since the start of today till now

; "date-value" and "now" work in UT, not your local time.
; "date" can take account of the time difference between your local time and UT.

; THE CURRENT TIME AND DATE
; =========================

; All four functions can be used to return information about the current time.
; "date-value" returns the number of seconds between 1970 and the current time (in UT):

(date-value)
;-> 1142798985

; "now" returns a list of integers with information about the current date and time (in UT):

(now)
;-> (2006 3 19 20 5 2 125475 78 1 0 0)

; This provides the following information:
; 1) year, month, day (2006, 3, 19)
; 2) hour, minute, second, microsecond (20, 5, 2, 125475)
; 3) day of current year (78)
; 4) day of current week (1)
; 5) local time zone offset (in minutes west of GMT) (0)
; 6) daylight savings time flag (0)

; To extract the information you want, use a slice or pick out the elements:

(slice (now) 0 3) ; year month day using explicit slice

(0 3 (now)) ; year month day using implicit slice

(select (now) '(0 1 2)) ; year month day using selection

(3 3 (now)) ; hour minute second

(nth 8 (now)) ; day of the week, starting from Sunday

; "date" used on its own will give you the current date and time for the local time zone
; "now" and "date-value" return values in UCT/UTC, not relative to your local time zone):

(date)
;-> "Mon Mar 19 20:05:02 2006"

; It can also tell you the date of an integer number of seconds since 1970
; (the start of the Unix epoch), adjusted for your local time zone:

(date 0) ; a US newLISP user sees this
;-> "Wed Dec 31 16:00:00 1969"

(date 0) ; a European newLISP user sees this
;-> "Thu Jan 1 01:00:00 1970"

; "date-value" can calculate the number of seconds for a specific date or date/time (in UT):

(date-value 2006 5 11) ; just the date
;-> 1147305600

(date-value 2006 5 11 23 59 59) ; date and time (in UT)
;-> 1147391999

; Because "date-value" can accept the year, month, day, hours, minutes, and seconds as input,
; it can be applied to the output of now:

(apply date-value (now))
;-> 1164723787

; By converting different times to these date values, you can do calculations.
; For example, to subtract November 13 2003 from January 3 2005:

(- (date-value 2005 1 3) (date-value 2003 11 13))
;-> 36028800
; seconds, which is

(/ 36028800 (* 24 60 60))
;-> 417
; this is a duration in days - don't convert this to a date!

; You can find out the date that is 12 days after Christmas Day 2005
; by adding 12 days-worth of seconds to the date:

(+ (date-value 2005 12 25) (* 12 24 60 60))
; seconds in 12 days
;-> 1136505600
; this is an instant in time, so it can be converted!

; This seconds value can be converted to a human-friendly date by date in its longer form,
; when it takes a seconds since-1970 value and converts it to a local time zone representation
; of this UT-based value:

(date 1136505600)
;-> "Fri Jan 6 00:00:00 2006" ; for this European user...

; Of course (date (date-value)) is the same as (date), but
; you'll have to use the longer form if you want to change the date format.
; "date" accepts an additional formatting string (preceded by a time-zone offset in minutes).
; If you're familiar with C-style strftime formatting, you'll know what to do:

(date (date-value) 0 "%Y-%m-%d %H:%M:%S") ; ISO 8601
;-> 2006-06-08 11:55:08

(date 1136505600 0 "%Y-%m-%d %H:%M:%S")
;-> "2006-01-06 00:00:00"

(date (date-value) 0 "%Y%m%d-%H%M%S") ; in London
;-> "20061207-144445"

(date (date-value) (* -8 60) "%Y%m%d-%H%M%S") ; in Los Angeles
;-> "20061207-064445" ; 8 hours offset

; READING DATES AND TIMES: "parse-date"
; =====================================

; The "parse-date" function (which is, unfortunately, not available on Windows)
; can convert date and time strings to seconds-since-1970 values.

; You supply a date-time format string after the string:

(parse-date "2006-12-13" "%Y-%m-%d")
;-> 1165968000

(date (parse-date "2007-02-08 20:12" "%Y-%m-%d %H:%M"))
;-> "Thu Feb 8 20:12:00 2007"

; TIMING AND TIMERS
; =================

; For timing purposes, you can use these functions:
; - "time" return the time taken to evaluate an expression, in milliseconds
; - "timer" set a timer to wait for a certain number of seconds and then evaluate expression
; - "sleep" stop working for a certain number of milliseconds
; - "time" is useful for finding out how much time expressions take to evaluate:

(time (read-file "/Users/me/Music/iTunes/iTunes Music Library.xml"))
;-> 27 ; milliseconds

; You can supply a repetition count as well, which probably gives a more accurate picture:

(time (for (x 1 1000) (factor x)) 100) ; 100 repetitions
;-> 426

; If you can't or don't want to enclose expressions,
; more simple timing can be done using time-of-day:

(set 'start-time (time-of-day))

(for (i 1 1000000)
  (set 'temp (sqrt i)))

(string {that took } (div (- (time-of-day) start-time) 1000) { seconds})
;-> "that took 0.238 seconds"

; "timer" is basically an alarm clock.
; Set it and then forget about it until the time comes.
; You supply a symbol specifying the alarm action, followed by the number of seconds to wait:

(define (teas-brewed)
  (println (date) " Your tea has brewed, sir!"))

(timer teas-brewed (* 3 60))

; and three minutes later you'll see this:

;-> Sun Mar 19 23:36:33 2006 Your tea has brewed, sir!

Without any arguments, this function returns the name of the current symbol
that's been assigned as the alarm action:

(timer)
;-> teas-brewed

; If you're waiting for the alarm to go off, and want to see how much time has elapsed so far,
; use the function with the name of the assigned symbol but without a seconds value:

(timer teas-brewed)
;-> 89.135747
; waited only a minute and a bit so far.

; WORKING WITH FILES
; ==================

; Functions for working with files can be grouped into two main categories:
; interacting with the operating system, and reading and writing data to and from files.

; INTERACTING WITH THE FILE SYSTEM
; ================================

; The concept of a current working directory is maintained in newLISP.
; When you start newLISP by typing newLISP in a terminal,
; your current working directory becomes newLISP's current directory:

$ pwd
;-> /Users/me/projects/programming/lisp

$ newlisp

;-> newLISP v.10.7.1 on OSX UTF-8, execute 'newlisp -h' for more info.

; or on windows:

;-> newLISP v.10.7.1 64-bit on Windows IPv4/6 UTF-8 libffi, options: newlisp -h

(env "PWD")
;-> "/Users/me/projects/programming/lisp"

(exit)

$ pwd
; /Users/me/projects/programming/lisp
$

; You can also check your current working directory
; using the real-path function without arguments:

(real-path)
;-> "/Users/me/projects/programming/lisp"

; But when you run a newLISP script from elsewhere, such as from inside a text editor,
; the current working directory and other settings may be different.
; It's a good idea, therefore, to use change-dir to establish the current working directory,
; if you're not sure:

(change-dir "/Users/me/Documents")
;-> true

; Other environment variables can be accessed with env:

(env "HOME")
;-> "/Users/me"

(env "USER")
;-> "u42"

; Again, running newLISP from a text editor rather than in an interactive terminal session
; will affect which environment variables are available and their values.
; Once you have the correct working directory, use "directory" to list its contents:

(directory)
;-> ("." ".." ".bash_history" ".bash_profile" ".inputrc" ".lpoptions"
;-> ".sqlite_history" ".ssh" ".subversion" "bin" "Desktop" "Desktop Folder"
"Doc;-> uments" "Library" ...

; and so on. Notice that it gives you the relative filenames, not the absolute pathnames.
; "directory" can list the contents of directories other than the current working directory too,
; if you supply a path.
; And in this extended form, you can use regular expressions to filter the contents:

(directory "./") ; just a pathname
;-> ("." ".." ".bash_history" ".bash_profile" ".inputrc" ".lpoptions"
;->  ".sqlite_history" ".ssh" ".subversion" "bin" "Desktop" "Desktop Folder"
;->  "Documents" "Library" ...

(directory "./" {^[^.]}) ; exclude files starting "."
;-> ("bin" "Desktop" "Desktop Folder" "Documents" "Library" ... )

; Again, notice that the results are relative to the current working directory.
; It's often useful to store the path of the directory that you're listing,
; in case you have to use it later to build full pathnames.
; real-path returns the full pathname of a file or directory,
; either in the current working directory:

(real-path ".subversion")
;-> "/Users/me/.subversion"

; or specified by another relative pathname:

(real-path "projects/programming/lisp/lex.lsp")
;-> "/Users/me/projects/programming/lisp/lex.lsp"

; To find the containing directory of an item on disk,
; you can just remove the file name from the full pathname:

(set 'f "lex.lsp")
(replace f (real-path f) "")
;-> "/Users/me/projects/programming/lisp/"

; This won't always work, if the file name appears as a directory name earlier in the path.
; A simple solution is to do a regex search for f occurring
; only at the very end of the pathname, using the $ option:

(replace (string f "\$") (real-path f) "" 0)

; To scan a section of your file system recursively,
; use a function that calls itself recursively.
; Here, just the full path name is printed:

(define (search-tree dir)
  (dolist (item (directory dir {^[^.]}))
    (if (directory? (append dir item))
    ; search the directory
      (search-tree (append dir item "/"))
    ; or process the file
      (println (append dir item)))))

(search-tree {/usr/share/newlisp/})
;-> /usr/share/newlisp/guiserver/allfonts-demo.lsp
;-> /usr/share/newlisp/guiserver/animation-demo.lsp
;-> ...
;-> /usr/share/newlisp/util/newlisp.vim
;-> /usr/share/newlisp/util/syntax.cgi

; See also Editing text files in folders and hierarchies.

; You'll find some testing functions useful:
; - "file?" does this file or directory exist?
; - "directory?" is this pathname a directory or a file?

; Remember the difference between relative and absolute pathnames:

(file? "System")
;-> nil

(file? "/System")
;-> true

; FILE INFORMATION
; ================

; You can get information about a file with "file-info".
; This function asks the operating system about the file and
; returns the information in a series of numbers:
;   0 is the size
;   1 is the mode
;   2 is the device mode
;   3 is the user id
;   4 is the group id
;   5 the access time
;   6 the modification time
;   7 the status change time
; To find out the size of files, for example, look at the first number returned by file-info.
; The following code lists the files in a directory and includes their sizes too.

(set 'dir {/usr/share/newlisp/modules})
(dolist (i (directory dir {^[^.]}))
  (set 'item (string dir "/" i))
    (if (not (directory? item))
        (println (format {%7d %-30s} (nth 0 (file-info item)) item))))

;-> 35935 /usr/share/newlisp/modules/canvas.lsp
;-> 6548 /usr/share/newlisp/modules/cgi.lsp
;-> 5460 /usr/share/newlisp/modules/crypto.lsp
;-> 4577 /usr/share/newlisp/modules/ftp.lsp
;-> 16310 /usr/share/newlisp/modules/gmp.lsp
;-> 4273 /usr/share/newlisp/modules/infix.lsp
;-> 12973 /usr/share/newlisp/modules/mysql.lsp
;-> 16606 /usr/share/newlisp/modules/odbc.lsp
;-> 9865 /usr/share/newlisp/modules/pop3.lsp
;-> 12835 /usr/share/newlisp/modules/postgres.lsp
;-> 31416 /usr/share/newlisp/modules/postscript.lsp
;-> 4337 /usr/share/newlisp/modules/smtp.lsp
;-> 10433 /usr/share/newlisp/modules/smtpx.lsp
;-> 16955 /usr/share/newlisp/modules/sqlite3.lsp
;-> 21807 /usr/share/newlisp/modules/stat.lsp
;-> 7898 /usr/share/newlisp/modules/unix.lsp
;-> 6979 /usr/share/newlisp/modules/xmlrpc-client.lsp
;-> 3366 /usr/share/newlisp/modules/zlib.lsp

; Notice that we stored the name of the directory in dir.
; The directory function returns relative file names,
; but you must pass absolute pathname strings to file-info
; unless the string refers to a file that's in the current working directory.
; You can use implicit addressing to select the item you want.
; So instead of (nth 0 (file-info item)), you can write (file-info item 0).

; FILE MANAGEMENT
; ===============

; To manage files, you can use the following functions:
; - "rename-file" renames a file or directory
; - "copy-file" copies a file
; - "delete-file" deletes a file
; - "make-dir" makes a new directory
; - "remove-dir" removes an empty directory

; For example, to renumber all files in the current working directory
; so that the files sort by modification date, you could write something like this:

(set 'dir {/Users/me/temp/})
(dolist (i (directory dir {^[^.]}))
  (set 'item (string dir "/" i))
  (set 'mod-date (date (file-info item 6) 0 "%Y%m%d-%H%M%S"))
  (rename-file item (string dir "/" mod-date i)))

;-> before
;-> image-001.png
;-> image-002.png
;-> image-003.png
;-> image-004.png

;-> after
;-> 20061116-120534image-001.png
;-> 20061116-155127image-002.png
;-> 20061117-210447image-003.png
;-> 20061118-143510image-004.png

; The (file-info item 6) extracts the modification time (item 6) of the file.
; Always test scripts like this before you use them for real work!
; A misplaced punctuation character can wreak havoc.

; READING AND WRITING DATA
; ========================

; newLISP has a good selection of input and output functions.
; An easy way of writing text to a file is "append-file",
; which adds a string to the end of a file.
; The file is created if it doesn't exist.
; It's very useful for creating log files and files that you write to periodically:

(dotimes (x 10)
  (append-file "/Users/me/Desktop/log.log"
  (string (date) " logging " x "\n")))

; and there's now a file on my desktop with the following contents:

;-> Sat Sep 26 09:06:08 2009 logging 0
;-> Sat Sep 26 09:06:08 2009 logging 1
;-> Sat Sep 26 09:06:08 2009 logging 2
;-> Sat Sep 26 09:06:08 2009 logging 3
;-> Sat Sep 26 09:06:08 2009 logging 4
;-> Sat Sep 26 09:06:08 2009 logging 5
;-> Sat Sep 26 09:06:08 2009 logging 6
;-> Sat Sep 26 09:06:08 2009 logging 7
;-> Sat Sep 26 09:06:08 2009 logging 8
;-> Sat Sep 26 09:06:08 2009 logging 9

; You don't have to worry about opening and closing the file.
; To load the contents of a file into a symbol in one gulp, use "read-file":

(set 'contents (read-file "/usr/share/newlisp/init.lsp.example"))
;-> ";; init.lsp - newLISP initialization file\n;; gets loaded automatically on
;-> ...
(load (append $HOME {/.init.lsp})) 'error))\n\n;;;; end of file ;;;;\n\n\n

; The symbol contents stores the file's contents as a single string.
; "open" returns a value which acts as a reference or 'handle' to a file.
; You'll probably want to use the file later, so store the reference in a symbol:

(set 'data-file (open "newfile.data" "read")) ; in current directory

; and later
(close data-file)

; Use "read-line" to read a file one line at a time from a file handle.
; Each time you use read-line, the next line is stored in a buffer
; which you can access with the "current-line" function.
; The basic approach for reading a file is like this:

(set 'file (open ((main-args) 2) "read")) ; the argument to the script
(while (read-line file)
  (println (current-line))) ; just output the line

; "read-line" discards the line feed at the end of each line.
; "println" adds one at the end of the text you supply.
; For more about argument handling and main-args, see STDIO.
; For small to medium-size files, reading a source file line by line is much slower
; than loading the whole file into memory at once.
; For example, the file for this book is about 6000 lines of text, or about 350KBytes.
; It's about 10 times faster to process the file using read-file and parse, like this:

(set 'source-text (read-file "/Users/me/introduction.txt"))
(dolist (ln (parse source-text "\n" 0))
  (process-line ln))

; than using read-line, like this:

(set 'source-file (open "/Users/me/introduction.txt" "read"))
(while (read-line source-file)
  (process-line (current-line)))

; The "device" function is a handy way of switching output between the console and a file:

(set 'output-file (open "/tmp/file.txt" "write"))
(println "1: this goes to the console")

(device output-file)
(println "2: this goes to the temp file")

(device 0)
(println "3: this goes to the console")
(close output-file)

; This go to console REPL:

;-> 1: this goes to the console
;-> 3: this goes to the console

; This go to /tmp/file.txt:

;-> 2: this goes to the temp file

; Suppose that your script accepts a single argument, and you want to write
; the output to a file with the same name but with a .out suffix.
; Try this:

(device (open (string ((main-args) 2) ".out") "write"))

(set 'file-contents (read-file ((main-args) 2)))

; Now you can process the file's contents and output any information using println statements.
; The "load" and "save" functions are used to load newLISP source code from a file,
; and to save source code into a file.
; The "read-line" and "write-line" functions can be used
; to read and write lines to threads as well as files.
; See Reading and writing to threads.

; STANDARD INPUT AND OUTPUT
; =========================

; To read from STDIO (standard input) and write to STDOUT (standard output),
; use read-line and println.
; For example, here's a simple filter that converts standard input to lower-case
; and outputs it to standard output:

#!/usr/bin/newlisp
(while (read-line)
  (println (lower-case (current-line))))
(exit)

; And it can be run in the shell like this:

$ ./lower-case.lsp
HI
;-> hi

HI THERE
;-> hi there
;-> ...

; The following short script is a useful newLISP formatter submitted to user forum by Echeam:

#!/usr/bin/env newlisp
(set 'indent " ")
(set 'level 0)
(while (read-line)
  (if (< level 0) (println "ERROR! Too many close-parenthesis. " level))
  (letn ((ln (trim (current-line))) (fc (first ln)))
    (if (!= fc ")") (println (dup indent level) ln)) ; (indent & print
    (if (and (!= fc ";") (!= fc "#")) ; don't count if line starts with ; or #
        (set 'level
          (+ level (apply - (count (explode "()") (explode (current-line)))))))
    (if (= fc ")") (println (dup indent level) ln))) ; (dedent if close-parenthesis
)
(if (!= level 0) (println "ERROR! Parenthesis not balanced. " level))
(exit)

; which you can run from the command-line like this:

$ format.lsp < inputfile.lsp

; COMMAND LINE ARGUMENTS
; ======================

; To use newLISP programs on the command line,
; you can access the arguments with the main-args function.
; For example, if you create this file:

#!/usr/bin/newlisp
(println (main-args))
(exit)

; make it executable, and then run it in the shell,
; you'll see a list of the arguments that were supplied to the script when you run it:

$ test.lsp 1 2 3
;-> ("/usr/bin/newlisp" "/Users/me/bin/test.lsp" "1" "2" "3")
$

; "main-args" returns a list of the arguments that were passed to your program.
; The first two arguments, which you probably don't want to process,
; are the path of the newLISP program, and the pathname of the script being executed:

(main-args)
;-> ("/usr/bin/newlisp" "/path/script.lsp" "1" "2" "3")

; So you probably want to process the arguments starting with the one at index 2:

((main-args) 2)
;-> 1

(main-args 2) ; slightly simpler
;-> 1

; which is returned as a string.

; Or, to process all the arguments, starting at index 2, use a slice:
(2 (main-args))
;-> ("1" "2" "3")

; and the arguments are returned in a list of strings.

; Often, you'll want to work through all the main arguments in your script.
; A convenient phrase for this is:

(dolist (a (2 (main-args)))
  (println a))

; A slightly more readable equivalent is this,
; which works through the rest of the rest of the arguments:

(dolist (a (rest (rest (main-args))))
  (println a))

; Here's a short script that filters out unwanted Unicode characters from a text file,
; except for a few special ones that are allowed through:

(set 'file (open ((main-args) 2) "read")) ; one file

(define (in-range? n low high)
  ; is n between low and high inclusive?
  (and (<= n high) (>= n low)))

(while (read-line file)
  (dostring (c (current-line))
    (if
      (or
        (in-range? c 32 127) ; ascii
        (in-range? c 9 10) ; tab newline
        (in-range? c 12 13) ; \f \r
        (= c (int "\0xbb")) ; right double angle
        (= c (int "\0x25ca")) ; diamond
        (= c (int "\0x2022")) ; bullet
        (= c (int "\0x201c")) ; open double quote
        (= c (int "\0x201d")) ; close double quote
      )
    (print (char c)))) ; nothing to do
    (println) ; because read-line swallows line endings
)

; For some more examples of argument processing, see Simple countdown timer.

; WORKING WITH PIPES, THREADS, AND PROCESSES
; ==========================================

; PROCESSES, PIPES, THREADS, AND SYSTEM FUNCTIONS
; ===============================================

; The following functions allow you to interact with the operating system:
; - "!" runs a command in the operating system
; - "abort" stops all spawned processes
; - "destroy" kills a process
; - "exec" runs a process and reads from or writes to it
; - "fork" launches a newLISP child process thread (Unix)
; - "pipe" creates a pipe for interprocess communication
; - "process" launches a child process, remap standard I/O and standard error
; - "semaphore" creates and controls semaphores
; - "share" shares memory with other processes and threads
; - "spawn" creates a new newLISP child process
; - "sync" monitors and synchronizes spawned processes
; - "wait-pid" waits for a child process to end

; Because these commands interact with your operating system,
; you should refer to the documentation for platformspecific issues and restrictions.

; "!" runs a system command and shows you the results in the console.
; The "exec" function does a similar job, but it waits for the operating system to finish,
; then returns the standard output as a list of strings, one for each line:

(exec "ls -Rat /usr | grep newlisp")

;-> ("newlisp" "newlisp-edit" "newlispdoc" "newlisp" "newlisp.1"
;-> "newlispdoc.1" "/usr/share/newlisp:"
;-> "/usr/share/newlisp/guiserver:"
;-> "/usr/share/newlisp/modules:" "/usr/share/newlisp/util:"
;-> "newlisp.vim" "newlisp" "/usr/share/doc/newlisp:"
;-> "newlisp_index.html" "newlisp_manual.html"
;-> "/usr/share/doc/newlisp/guiserver:")

; You'll have all the fun of quoting and double-quoting to get your commands through the shell.
; With "exec", your script will wait until the command finishes before your script continues.

(exec (string "du -s " (env "HOME") "/Desktop"))

; You'll see the results only when the command finishes.
; To interact with another process running alongside newLISP,
; rather than wait until a process finishes, use "process".
; See Processes.

; MULTITASKING
; ============

; All the newLISP expressions we've evaluated so far have run serially, one after the other,
; so one expression has to finish evaluating before newLISP can start on the next one.
; This is usually OK. But sometimes you want to start an expression and
; then move on to another while the first is still being evaluated.
; Or you might want to divide a large job into a number of smaller ones,
; perhaps taking advantage of any extra processors your computer has.
; newLISP does this type of multitasking using three functions:
; 1) "spawn" for creating new processes to run in parallel,
; 2) "sync" for monitoring and finishing them, and
; 3) "abort" for stopping them before they've finished.

(define (pulsar ch interval)
  (for (i 1 20)
    (print ch)
    (sleep interval))
  (println "I've finished"))

; When you run this normally, you'll see 20 characters printed, one every interval milliseconds.
; The execution of this function blocks everything else, and you'll have to wait for all 20,
; or stop execution using Control-C.
; To run this function in a parallel process alongside the current one, use the "spawn" function.
; Supply a symbol to hold the result of the expression,
; followed by the expression to be evaluated:

(spawn 'r1 (pulsar "." 3000))
;-> 2882
;-> .

; The number returned by the function is the process ID.
; You can now carry on using newLISP in the terminal
; while the pulsar continues to interrupt you.
; It's very irritating - dots keep appearing in the middle of your typing!
; Start a few more:

(spawn 'r2 (pulsar "-" 5000))
;-> 2883

(spawn 'r3 (pulsar "!" 7000))
;-> 2884

(spawn 'r4 (pulsar "@" 9000))
;-> 2885

; To see how many processes are active (and haven't yet finished),
; use the "sync" function without arguments:

> (sync)
;-> (2885 2884 2883 2882)

; If you want to stop all the pulsar processes, use "abort":

(abort)
;-> true

; On MacOS X, try this more entertaining version that uses the resident spoken voice:

(define (pulsar w interval)
  (for (i 1 20)
    (! (string " say " w))
    (sleep interval))
  (println "I've finished"))

(spawn 'r1 (pulsar "spaghetti" 2000))
(spawn 'r2 (pulsar "pizza" 3000))
(spawn 'r3 (pulsar "parmesan" 5000))

; "sync" also lets you keep an eye on currently running processes.
; Supply a value in milliseconds: newLISP will wait for that time,
; and then check to see if the spawned processes have finished:

(spawn 'r1 (pulsar "." 3000))
;-> 2888
;-> .

(sync 1000)
;-> nil

; If the result is nil, then the processes haven't finished.
; If the result is true, then they've all finished.
; Now - and only now, after the "sync" function runs:
; the value of the return symbol r1 is set to be the value returned by the process.
; In the case of the pulsar, this will be the string "I've finished".

;-> I've finished

r1
;-> nil

(sync 1000)
;-> true

r1
;-> "I've finished"

; Notice that the process finished - or rather, it printed its concluding message -
; but the symbol r1 wasn't set until the "sync" function was executed and returned true.
; This is because sync returns true, and the return symbols have values,
; only if all the spawned processes have finished.
; You could execute a loop if you wanted to wait for all the processes to complete:

(until (sync 1000))

; which checks every second to see if the processes have completed.

; As a bonus, many modern computers have more than one processor,
; and your scripts might be able to run faster
; if each processor can devote its energies to one task.
; newLISP leaves it to the operating system:
; to schedule tasks and processors according to the hardware at its disposal.

; FORKED PROCESSES
; ================

; There are some lower-level functions for manipulating processes.
; These aren't as convenient or as easy to use as the spawned process technique described,
; but they provide a few additional features that you might find a use for some day.

; You can use "fork" to evaluate an expression in another process.
; Once the process is launched, it won't return a value to the parent process,
; so you'll have to think about how to obtain its results.
; Here's a way of calculating prime numbers in a separate process
; and saving the output in a file:

(define (isprime? n)
  (if (= 1 (length (factor n)))
    true))

(define (find-primes l h)
  (for (x l h)
    (if (isprime? x)
      (push x results -1)))
  results)

(fork (append-file "/Users/me/primes.txt"
  (string "the result is: " (find-primes 500000 600000))))

; Here, the new child process launched by "fork" knows how to find prime numbers,
; but, unlike the previous spawned processes,
; can't return information to its parent process to report how many it's found.
; It is possible for processes to share information.
; The "share" function sets up a common area of memory, like a notice board,
; that all processes can read and write to.
; There's a simple example of "share" in a later chapter: see A simple IRC client.)

; To control how processes access shared memory, newLISP provides a "semaphore" function.

; READING AND WRITING TO THREADS
; ==============================

; If you want forked threads to communicate with each other,
; you'll have to do a bit of plumbing first.
; Use "pipe" to set up communications channels,
; then arrange for one thread to listen to another.
; "pipe" returns a list containing read and write handles
; to a new inter-process communications pipe,
; and you can then use these as channels for
; the "read-line" and "write-line" functions to read and write to.

(define (isprime? n)
  (if (= 1 (length (factor n)))
  true))

(define (find-primes l h)
  (for (x l h)
    (if (isprime? x)
    (push x results -1)))
  results)

(define (generate-primes channel)
  (dolist (x (find-primes 100 300))
    (write-line channel (string x)))) ; write a prime

(define (report-results channel)
  (do-until (> (int i) 290)
    (println (setq i (read-line channel))))) ; get next prime

(define (start)
  (map set '(in out) (pipe)) ; do some plumbing
  (set 'generator (fork (report-results in)))
  (set 'reporter (fork (generate-primes out)))
  (println "they've started"))

(start)

;-> they've started
;-> 101
;-> 103
;-> 107
;-> 109
;-> ...

(wait-pid generator)
(wait-pid reporter)

; Notice how the "they've started" string appears before any primes are printed,
; even though that "println" expression occurs after the threads start.
; The "wait-pid" function waits for the thread launched by "fork" to finish,
; of course you don't have to do this immediately.

; COMMUNICATING WITH OTHER PROCESSES
; ==================================

; To launch a new operating system process that runs alongside newLISP, use "process".
; As with fork, you first want to set up some suitable plumbing,
; so that newLISP can both talk and listen to the process,
; which in the following example is the Unix calculator bc.

; The "write-buffer" function writes to the myout pipe, which is read by bc via bcin.
; bc's output is directed through bcout and read by newLISP using "read-line".

;                          write-buffer            in
;                     |--------->------------------>---------|
;                     |       myout               bcin       |
;                     |                                      |
;      newLISP  -------                                      ------- bc
;
;      newLISP  -------                                      ------- bc
;                     |                                      |
;                     |       myin                bcout      |
;                     |---------<------------------<---------|
;                           read-line              out

(map set '(bcin myout) (pipe)) ; set up the plumbing

(map set '(myin bcout) (pipe))

(process "/usr/bin/bc" bcin bcout) ; start the bc process

(set 'sum "123456789012345 * 123456789012345")

(write-buffer myout (string sum "\n"))

(set 'answer (read-line myin))

(println (string sum " = " answer))
;-> 123456789012345 * 123456789012345 = 15241578753238669120562399025

(write-buffer myout "quit\n") ; don't forget to quit!

; WORKING WITH XML
; ================

; CONVERTING XML INTO LISTS
; =========================

; XML files are widely used these days, and you might have noticed that
; the highly organized tree structure of an XML file is similar
; to the nested list structures that we've met in newLISP.
; So wouldn't it be good if you could work with XML files as easily as you can work with lists?

; You've met the two main XML-handling functions already. (See "ref" and "ref-all")
; The "xml-parse" and "xml-type-tags" functions allows to convert XML into a newLISP list.
; ("xml-error" is used for diagnosing errors.)

; "xml-type-tags" determines how the XML tags are processed by xml-parse,
; which does the actual processing of the XML file, turning it into a list.

; To see the use of these functions, we'll use the RSS newsfeed from the newLISP forum:

(set 'xml (get-url "http://newlispfanclub.alh.net/forum/feed.php"))

; and store the retrieved XML in a file, to save hitting the server repeatedly:

(save {/Users/me/Desktop/newlisp.xml} 'xml) ; save symbol in file

(load {/Users/me/Desktop/newlisp.xml}) ; load symbol from file

; The XML starts like this:

;-> <?xml version="1.0" encoding="UTF-8"?>
;-> <feed xmlns="http://www.w3.org/2005/Atom" xml:lang="en-gb">
;-> <link rel="self" type="application/atom+xml" href="http://nlfc.alh.net/forum/feed.php" />
;-> <title>nlfc.alh.net</title>
;-> <subtitle>Friends and Fans of NewLISP</subtitle>
;-> <link href="http://nlfc.alh.net/forum/index.php" />
;-> <updated>2010-01-11T09:51:39+00:00</updated>
;-> <author><name><![CDATA[nlfc.alh.net]]></name></author>
;-> <id>http://nlfc.alh.net/forum/feed.php</id>
;-> <entry>
;-> <author><name><![CDATA[kosh]]></name></author>
;-> <updated>2010-01-10T12:17:53+00:00</updated>
;-> ...


; If you use "xml-parse" to parse the XML,
; but don't use "xml-type-tags" first, the output looks like this:

(xml-parse xml)

;-> (("ELEMENT" "feed" (("xmlns" "http://www.w3.org/2005/Atom")
;->   ("xml:lang" "en-gb"))
;->   (("TEXT" "\n") ("ELEMENT" "link" (("rel" "self")
;->    ("type" "application/atom+xml")
;->      ("href" "http://nlfc.alh.net/forum/feed.php"))
;->     ())
;->    ("TEXT" "\n\n")
;->    ("ELEMENT" "title" () (("TEXT" "nlfc.alh.net")))
;->    ("TEXT" "\n")
;->    ("ELEMENT" "subtitle" () (("TEXT" "Friends and Fans of NewLISP")))
;->    ("TEXT" "\n")
;->    ("ELEMENT" "link" (("href" "http://nlfc.alh.net/forum/index.php")) ())
;->   ...

; Although it looks a bit LISP-y already,
; there are elements have been labelled as "ELEMENT", "TEXT".
; For now, we could do without all these labels,
; and that's basically the job that "xml-type-tags" does.
; It lets you determine the labels for four types of XML tag:
; TEXT, CDATA, COMMENTS, and ELEMENTS.
; We'll hide them altogether with four nils.
; We'll also use some options for xml-parse to tidy up the output even more.

(xml-type-tags nil nil nil nil)

(set 'sxml (xml-parse xml 15)) ; options: 15 (see below)
;-> ((feed ((xmlns "http://www.w3.org/2005/Atom") (xml:lang "en-gb")) (link ((rel "self")
;->     (type "application/atom+xml")
;->     (href "http://nlfc.alh.net/forum/feed.php")))
;->   (title "nlfc.alh.net")
;->   (subtitle "Friends and Fans of NewLISP")
;->   (link ((href "http://nlfc.alh.net/forum/index.php")))
;->   (updated "2010-01-11T09:51:39+00:00")
;->   (author (name "nlfc.alh.net"))
;->   (id "http://nlfc.alh.net/forum/feed.php")
;->   (entry (author (name "kosh"))
;->    (updated "2010-01-10T12:17:53+00:00")
;->    (id "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471")
;->    (link ((href "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471")))
;->    (title ((type "html")) "newLISP in the real world \226\128\162 Re: newLISP manual CHM")
;->    (category ((term "newLISP in the real world")
;->     (scheme "http://nlfc.alh.net/forum/viewforum.php?f=16")
;->      (label "newLISP in the real world")))
;->    (content ((type "html")
;->    (xml:base "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471"))
;->     "\nhello kukma.<br />\nI tried to make the newLISP.chm, and this is it.<br />\n
;->     <br />\n<!-- m --><a class=\"postlink\"
;->  ...

; This is now a useful newLISP list, albeit quite a complicated one,
; stored in a symbol called sxml. (This way of representing XML is called S-XML.)
; If you're wondering what that 15 was doing in the "xml-parse" expression,
; it's just a way of controlling how much of the auxiliary XML information is translated.
; The options are as follows:
; 1 - suppress whitespace text tags
; 2 - suppress empty attribute lists
; 4 - suppress comment tags
; 8 - translate string tags into symbols
; 16 - add SXML (S-expression XML) attribute tags

; You add them up to get the options code number.
; For example, 15 (+ 1 2 4 8) uses the first four of these options:
; suppress unwanted stuff, and translate strings tags to symbols.
; As a result of this, new symbols have been added to newLISP's symbol table:

; (author category content entry feed href id label link rel scheme subtitle term
; title type updated xml:base xml:lang xmlns)

; These correspond to the string tags in the XML file,
; and they'll be useful almost immediately.

; NOW WHAT?

; The story so far is basically this:

(set 'xml (get-url "http://newlispfanclub.alh.net/forum/feed.php"))
; we stored this in a temporary file while exploring

(xml-type-tags nil nil nil nil)

(set 'sxml (xml-parse xml 15))

; which has given us a list version of the news feed stored in the sxml symbol.

; Because this list has a complicated nested structure,
; it's best to use "ref" and "ref-all" rather than find to look for things.
; "ref" finds the first occurrence of an expression in a list and returns the address:

(ref 'entry sxml)
;-> (0 9 0)

; These numbers are the address in the list of the first occurrence of the symbol item:
; (0 9 0) means start at item 0 of the whole list, then go to item 9 of that item,
; then go to item 0 of that one. (0-based indexing, of course!)

; To find the higher-level or enclosing item,
; use "chop" to remove the last level of the address:

(chop (ref 'entry sxml))
;-> (0 9)

This now points to the level that contains the first item.
It's like chopping the house number off an address, leaving the street name.
Now you can use this address with other expressions that accept a list of indices.
The most convenient and compact form is probably the implicit address,
which is just the name of the source list followed by the set of indices in a list:

(sxml (chop (ref 'entry sxml))) ; a (0 9) slice of sxml

;-> (entry (author (name "kosh")) (updated "2010-01-10T12:17:53+00:00") (id
;-> "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471")
;->   (link ((href "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471")))
;->   (title ((type "html")) "newLISP in the real world \226\128\162 Re: newLISP manual CHM")
;->   (category ((term "newLISP in the real world") (scheme
;->              "http://nlfc.alh.net/forum/viewforum.php?f=16")
;->     (label "newLISP in the real world")))
;-> (content ((type "html") (xml:base
;->           "http://nlfc.alh.net/forum/viewtopic.php?t=3447&amp;p=17471#p17471"))
;-> ...

; That found the first occurrence of entry, and returned the enclosing portion of the SXML.
; Another technique available to you is to treat sections of the list as association lists:

(lookup 'title (sxml (chop (ref 'entry sxml))))
;-> newLISP in the real world • Re: newLISP manual CHM

; Here we've found the first item, as before,
; and then looked up the first occurrence of title using lookup.

; Use "ref-all" to find all occurrences of a symbol in a list.
; It returns a list of addresses:

(ref-all 'title sxml)
;-> ((0 3 0)
;-> (0 9 5 0)
;-> (0 10 5 0)
;-> (0 11 5 0)
;-> (0 12 5 0)
;-> (0 13 5 0)
;-> (0 14 5 0)
;-> (0 15 5 0)
;-> (0 16 5 0)
;-> (0 17 5 0)
;-> (0 18 5 0))

With a simple list traversal, you can quickly show all the titles in the file,
at whatever level they may be:

(dolist (el (ref-all 'title sxml))
  (println (rest (rest (sxml (chop el))))))
;-> ()
;-> ("newLISP in the real world \226\128\162 Re: newLISP manual CHM")
;-> ("newLISP newS \226\128\162 Re: newLISP Advocacy")
;-> ("newLISP in the real world \226\128\162 Re: newLISP-gs opens only splash picture")
;-> ("... DO with newLISP? \226\128\162 Re: Conception of Adaptive Programming Languages")
;-> ("Dragonfly \226\128\162 Re: Dragonfly 0.60 Released!")
;-> ("... DO with newLISP? \226\128\162 Takuya Mannami, Gauche Newlisp Library")
;-> ...

; Without the two rests in there, you would have seen this:

;-> (title "newlispfanclub.alh.net")
;-> (title ((type "html")) "newLISP in the real world \226\128\162 Re: newLISP manual CHM")
;-> (title ((type "html")) "newLISP newS \226\128\162 Re: newLISP Advocacy")
;-> ...

; As you can see, there are many different ways to access the information in the SXML data.
; To produce a concise summary of the news in the XML file,
; one approach is to go through all the items, and extract the title and description entries.
; Because the description elements are a mass of escaped entities,
; we'll write a quick and dirty tidying routine as well:

(define (cleanup str)
  (let (replacements
  '(({&amp;amp;} {&amp;})
    ({&amp;gt;} {>})
    ({&amp;lt;} {<})
    ({&amp;nbsp;} { })
    ({&amp;apos;} {'})
    ({&amp;quot;} {"})
    ({&amp;#40;} {(})
    ({&amp;#41;} {)})
    ({&amp;#58;} {:})
    ("\n" "")))
  (and
    (!= str "")
    (map (fn (f) (replace (first f) str (last f))) replacements)
    (join (parse str {<.*?>} 4) " "))))

(set 'entries (sxml (chop (chop (ref 'title sxml)))))

(dolist (e (ref-all 'entry entries))
  (set 'entry (entries (chop e)))
  (set 'author (lookup 'author entry))
  (println "Author: " (last author))
  (set 'content (lookup 'content entry))
  (println "Post: " (0 60 (cleanup content)) {...}))

Author: kosh
Post: hello kukma. I tried to make the newLISP.chm, and this is it...
Author: Lutz
Post: ... also, there was a sign-extension error in the newLISP co...
Author: kukma
Post: Thank you Lutz and welcome home again, the principle has bec...
Author: Kazimir Majorinc
Post: Apparently, Aparecido Valdemir de Freitas completed his Dr...
Author: cormullion
Post: Upgrade seemed to go well - I think I found most of the file...
Author: Kazimir Majorinc
Post: http://github.com/mtakuya/gauche-nl-lib Statistics: Post...
Author: itistoday
Post: As part of my work on Dragonfly, I've updated newLISP's SMTP...
Author: Tim Johnson
Post: itistoday wrote: Tim Johnson wrote: Have you done any...
; ...

; CHANGING SXML
; =============

; You can use similar techniques to modify data in XML format.
; For example, suppose you keep the periodic table ofelements in an XML file,
; and you wanted to change the data about elements' melting points,
; currently stored in degrees Kelvin, to degrees Celsius.
; The XML data looks like this:

; <?xml version="1.0"?>
; <PERIODIC_TABLE>
;   <ATOM>
;   ...
;   </ATOM>
;   <ATOM>
;     <NAME>Mercury</NAME>
;     <ATOMIC_WEIGHT>200.59</ATOMIC_WEIGHT>
;     <ATOMIC_NUMBER>80</ATOMIC_NUMBER>
;     <OXIDATION_STATES>2, 1</OXIDATION_STATES>
;     <BOILING_POINT UNITS="Kelvin">629.88</BOILING_POINT>
;     <MELTING_POINT UNITS="Kelvin">234.31</MELTING_POINT>
;     <SYMBOL>Hg</SYMBOL>
; ...

; When the table has been loaded into the symbol sxml,
; using (set 'sxml (xml-parse xml 15)) (where xml contains the XML source),
; we want to change each sublist that has the following form:

; (MELTING_POINT ((UNITS "Kelvin")) "629.88")

; You can use the "set-ref-all" function to find and replace elements in one expression.
; First, here's a function to convert a temperature from Kelvin to Celsius:

(define (convert-K-to-C n)
  (sub n 273.15))

; Now the set-ref-all function can be called just once
; to find all references and modify them in place,
; so that every melting-point is converted to Celsius.
; The form is:

(set-ref-all key list replacement function)

; where the function is the method used to find list elements given the key.

(set-ref-all
  '(MELTING_POINT ((UNITS "Kelvin")) *)
  sxml
  (list
    (first $0)
    '((UNITS "Celsius"))
    (string (convert-K-to-C (float (last $0)))))
  match)

; Here the "match" function searches the SXML list using a wild-card construction
; (MELTING_POINT ( (UNITS "Kelvin") ) *) to find every occurrence.
; The replacement expression builds a replacement sublist
; from the matched expression stored in $0.
; After this has been evaluated, the SXML changes from this:

;-> ...
;-> (ATOM
;->     (NAME "Mercury")
;->     (ATOMIC_WEIGHT "200.59")
;->   (ATOMIC_NUMBER "80")
;->   (OXIDATION_STATES "2, 1")
;->   (BOILING_POINT ((UNITS "Kelvin")) "629.88")
;->   (MELTING_POINT ((UNITS "Kelvin")) "234.31")
;-> ...

; to this:

;-> ...
;-> (ATOM
;->     (NAME "Mercury")
;->     (ATOMIC_WEIGHT "200.59")
;->     (ATOMIC_NUMBER "80")
;->     (OXIDATION_STATES "2, 1")
;->     (BOILING_POINT ((UNITS "Kelvin")) "629.88")
;->     (MELTING_POINT ((UNITS "Celsius")) "-38.84")
;-> ...

; XML isn't always as easy to manipulate as this,
; there are attributes, CDATA sections, and so on.

; Outputting SXML to XML
; ======================

; If you want to go the other way and convert a newLISP list to XML,
; the following function suggests one possible approach.
; It recursively works through the list:

(define (expr2xml expr (level 0))
  (cond
    ((or (atom? expr) (quote? expr))
      (print (dup " " level))
      (println expr))
    ((list? (first expr))
      (expr2xml (first expr) (+ level 1))
      (dolist (s (rest expr)) (expr2xml s (+ level 1))))
    ((symbol? (first expr))
      (print (dup " " level))
      (println "<" (first expr) ">")
      (dolist (s (rest expr)) (expr2xml s (+ level 1)))
      (print (dup " " level))
      (println "</" (first expr) ">"))
    (true
      (print (dup " " level))
      (println "<error>" (string expr) "<error>"))))

(expr2xml sxml)

; <rss>
;   <version>
;   0.92
;   </version>
;  <channel>
;   <docs>
;   http://backend.userland.com/rss092
;   </docs>
;   <title>
;   newLISP Fan Club
;   </title>
;   <link>
;   http://www.alh.net/newlisp/phpbb/
;   </link>
;   <description>
;     Friends and Fans of newLISP
;   </description>
;   <managingEditor>
;   newlispfanclub-at-excite.com
;   </managingEditor>
;   ...

; A SIMPLE PRACTICAL EXAMPLE
; ==========================

; The following example was originally set in the shipping department of a small business.
; I've changed the items to be pieces of fruit.
; The XML data file contains entries for all items sold, and the charge for each.
; We want to produce a report that lists how many at each price were sold, and the total value.
; Here's an extract from the XML data:

; <FRUIT>
;   <NAME>orange</NAME>
;   <charge>0</charge>
;   <COLOR>orange</COLOR>
; </FRUIT>
; <FRUIT>
;   <NAME>banana</NAME>
;   <COLOR>yellow</COLOR>
;   <charge>12.99</charge>
; </FRUIT>
; <FRUIT>
;   <NAME>banana</NAME>
;   <COLOR>yellow</COLOR>
;   <charge>0</charge>
; </FRUIT>
; <FRUIT>
;   <NAME>banana</NAME>
;   <COLOR>yellow</COLOR>
;   <charge>No Charge</charge>
; </FRUIT>

; This is the main function that defines and organizes the tasks:

(define (work-through-files file-list)
  (dolist (fl file-list)
    (set 'table '())
    (scan-file fl)
    (write-report fl)))

; Two functions are called: scan-file, which scans an XML file and stores
; the required information in a table, which is going to be some sort of newLISP list,
; and write-report, which scans this table and outputs a report.
; The scan-file function receives a pathname, converts the file to SXML,
; finds all the charge items (using ref-all), and keeps a count of each value.
; We allow for the fact that some of the free items are marked variously
; as No Charge or no charge or nocharge:

(define (scan-file f)
  (xml-type-tags nil nil nil nil)
  (set 'sxml (xml-parse (read-file f) 15))
  (set 'r-list (ref-all 'charge sxml))
  (dolist (r r-list)
    (set 'charge-text (last (sxml (chop r))))
    (if (= (lower-case (replace " " charge-text "")) "nocharge")
        (set 'charge (lower-case charge-text))
        (set 'charge (float charge-text 0 10)))
    (if (set 'result (lookup charge table 1))
         ; if this price already exists in table, increment it
        (setf (assoc charge table) (list charge (inc result)))
        ; or create an entry for it
        (push (list charge 1) table -1))))

; The write-report function sorts and analyses the table, keeping running totals as it goes:

(define (write-report fl)
  (set 'total-items 0 'running-total 0 'total-priced-items 0)
  (println "sorting")
  (sort table (fn (x y) (< (float (x 0)) (float (y 0)))))
  (println "sorted ")
  (println "File: " fl)
  (println " Charge Quantity Subtotal")
  (dolist (c table)
    (set 'price (float (first c)))
    (set 'quantity (int (last c)))
    (inc total-items quantity)
    (cond
    ; do the No Charge items:
    ((= price nil) (println (format " No charge %12d" quantity)))
    ; do 0.00 items
    ((= price 0) (println (format " 0.00 %12d" quantity)))
    ; do priced items:
    (true
      (begin
        (set 'subtotal (mul price quantity))
        (inc running-total subtotal)
        (if (> price 0) (inc total-priced-items quantity))
        (println (format "%8.2f %8d %12.2f" price quantity subtotal))))))
; totals
(println (format "Total charged %8d %12.2f" total-priced-items running-total))
(println (format "Grand Total %8d %12.2f" total-items running-total)))

; The report requires a bit more fiddling about than the scan-file function, particularly
; as the user wanted - for some reason - the 0 and no charge items to be kept separate.

;-> Charge          Quantity     Subtotal
;-> No charge          138
;-> 0.00               145
;-> 0.11                 1          0.11
;-> 0.29                 1          0.29
;-> 1.89                72        136.08
;-> 1.99                17         33.83
;-> 2.99                18         53.82
;-> 12.99               55        714.45
;-> 17.99                1         17.99
;-> Total charge       165        956.57
;-> Grand Total        448        956.57


; THE DEBUGGER
; ============

; This section takes a brief look at the built-in debugger.

; The key function is "trace". To start and stop the debugger, use true or nil:

(trace true) ; start debugging

(trace nil) ; stop debugging

; Used without arguments, it returns true if the debugger is currently active.

; The trace-highlight command lets you control the display of the expression
; that's currently being evaluated, and some of the prompts.

; I'm using a VT100-compatible terminal,
; so I can use weird escape sequences to set the colors.
; Type this in at the newLISP prompt:

(trace-highlight "\027[0;37m" "\027[0;0m")

; But since I can never remember this, it's in my .init.lsp file,
; which loads when you start newLISP.
; If you can't use these sequences, you can use plain strings instead.

; The other debugging function is "debug".
; This is really just a short-cut for switching tracing on,
; running a function in the debugger, and then switching tracing off again.
; So, suppose we want to run a file called old-file-scanner.lsp,
; which contains the following code:

(define (walk-tree folder)
  (dolist (item (directory folder))
    (set 'item-name (string folder "/" item))
    (if (and (not (starts-with item ".")) (directory? item-name))
        ; folder
        (walk-tree item-name)
        ; file
        (and
          (not (starts-with item "."))
          (set 'f-name (real-path item-name))
          (set 'mtime (file-info f-name 6))
          (if (> (- (date-value) mtime) (* 5 365 24 60 60)) ; non-leap years :)
              (push (list mtime item-name) results))))))

(set 'results '())
(walk-tree {/usr/share})
(map (fn (i) (println (date (first i)) { } (last i))) (sort results))

; This scans a directory and subdirectories for files previously modified 5 or more years ago.
; (Notice that the file ends with expressions that
; will be evaluated immediately the file is loaded)
; First, switch tracing on:

(trace true)

; Then load and start debugging:

(load {old-file-scanner.lsp})

; Or, instead of those two lines, type this one:

(debug (load {old-file-scanner.lsp}))

; Either way, you'll see the first expression in the walk-tree function highlighted,
; awaiting evaluation.

; Now you can press the s, n, or c keys (Step, Next, and Continue)
; to proceed through your functions:
; Step evaluates every expression, and steps into other functions as they are called
; Next evaluates everything until it reaches the next expression at the same level
; and Continue runs through without stopping again.

; If you're clever, you can put a (trace true) expression
; just before the place where you want to start debugging.
; If possible, newLISP will stop just before that expression and show you
; the function it's just about to evaluate.
; In this case, you can start executing the script with a simple (load...) expression,
; don't use debug if you want to skip over the preliminary parts of the script.
; I think newLISP usually prefers to enter the debugger at the start of a function or
; function call - you probably won't be able to drop in to a function part way through.
; But you might be able to organize things so that you can do something similar.

; Here is how to drop into the debugger halfway through a loop.
; Here's a small portion of code:

(set 'i 0)

(define (f1)
  (inc i))

(define (f2)
  (dotimes (x 100)
    (f1)
    (if (= i 50) (trace true))))

(f2)

; Load it from file:

(load {simpleloop.lsp})

;-> -----
;-> (define (f1)
;->   (inc i))
;-> [-> 5 ] s|tep n|ext c|ont q|uit > i
;-> 50
;-> [-> 5 ] s|tep n|ext c|ont q|uit >

; Notice how the function f1 appeared - you don't get a chance to see anything in f2.
; At the debugger prompt, you can type in any newLISP expression, and evaluate any functions.
; Here I've typed i to see the current value of that symbol.
; newLISP is happy to let you change the values of some symbols, too.
; You should be able to change the loop variable, for example.
; But don't redefine any functions ... if you try to pull the rug from
; underneath newLISP's feet you'll probably succeed in making it fall over!
; The source code displayed by the debugger doesn't include comments,
; so if you want to leave yourself helpful remarks - or inspiration -
; when looking at your code, use text strings rather than comments:

(define (f1)
  [text]This will appear in the debugger.[/text]
  ; But this won't.
  (inc i))

; THE INTERNET
; ============

; HTTP AND NETWORKING
; ===================

; Most networking tasks are possible with newLISP's networking functions:

; - "base64-dec" decode a string from BASE64 format
; - "base64-enc" encode a string to BASE64 format
; - "delete-url" delete a URL
; - "get-url" read a file or page from the web
; - "net-accept" accept a new incoming connection
; - "net-close" close a socket connection
; - "net-connect" connect to a remote host
; - "net-error" return the last error
; - "net-eval" evaluate expressions on multiple remote newLISP servers
; - "net-interface" define the default network interface
; - "net-listen" listen for connections to a local socket
; - "net-local" local IP and port number for a connection
; - "net-lookup" the name for an IP number
; - "net-peek" number of characters ready to read
; - "net-peer" remote IP and port for a net-connect
; - "net-ping" send a ping packet (ICMP echo request) to one or more addresses
; - "net-receive" read data on a socket connection
; - "net-receive-from" read a UDP datagram on an open connection
; - "net-receive-udp" read a UDP datagram on and closes connection
; - "net-select" check a socket or list of sockets for status
; - "net-send" send data on a socket connection
; - "net-send-to" send a UDP datagram on an open connection
; - "net-send-udp" send a UDP datagram and closes connection
; - "net-service" translate a service name to a port number
; - "net-sessions" return a list of currently open connections
; - "post-url" post info to a URL address
; - "put-url" upload a page to a URL address.
; - "xml-error" return last XML parse error
; - "xml-parse" parse an XML document
; - "xml-type-tags" show or modify XML type tags

; With these networking functions you can build all kinds of network-capable applications.
; With functions like neteval you can start newLISP as a daemon on a remote computer and
; then use on a local computer to send newLISP code across the network for evaluation.

; ACCESSING WEB PAGES
; ===================
; Here's a very simple example using get-url.
; Given the URL of a web page, obtain the source and then use replace
; and its list-building ability to generate a list of all the JPEG images on that page:

(set 'the-source (get-url "http://www.apple.com"))

(replace {src="(http\S*?jpg)"} the-source (push $1 images-list -1) 0)

(println images-list)
;-> ("http://images.apple.com/home/2006/images/ipodhifititle20060228.jpg"
;-> "http://images.apple.com/home/2006/images/ipodhifitag20060228.jpg"
;-> "http://images.apple.com/home/2006/images/macminiwings20060228.jpg"
;-> "http://images.apple.com/home/2006/images/macminicallouts20060228.jpg"
;-> "http://images.apple.com/home/2006/images/ipodhifititle20060228.jpg"
;-> "http://images.apple.com/home/2006/images/ipodhifitag20060228.jpg")

; A SIMPLE HTML FORM
; ==================

; The simplest search form is probably something like this:

(load "cgi.lsp")
(println (string "Content-type: text/html\r\n\r\n"
      [text]<!doctype html>
      <html>
        <head>
        <title>Title</title>
        </head>
      <body>
      [/text]))

(set 'search-string (CGI:get "userinput"))

(println (format [text]
          <form name="form" class="dialog" method="GET">
              <fieldset>
                <input type="text" value="search" name="userinput" >
                <input type="submit" style="display:none"/>
              </fieldset>
          </form>[/text]))

(unless (nil? search-string)
  (println " I couldn't be bothered to search for \"" search-string "\""))

(println [text]
      </body>
    </html>
  [/text])

; A SIMPLE IRC CLIENT
; ===================

; The following code implements a simple IRC (Internet Relay Chat) client,
; and it shows how the basic network functions can be used.
; The script logs in to the server using the given username, and joins the # newlisp channel.
; Then the script divides into two threads:
; the first thread displays any channel activity in a continuous loop,
; while the second thread waits for input at the console.
; The only communication between the two threads is through the shared connected flag.

(set 'server (net-connect "irc.freenode.net" 6667))
(net-send server "USER newlispnewb 0 * :XXXXXXX\r\n")
(net-send server "NICK newlispnewb \r\n")
(net-send server "JOIN #newlisp\r\n")

(until (find "366" buffer)
  (net-receive server buffer 8192 "\n")
  (print buffer))

(set 'connected (share))
(share connected true)

(fork
    (while (share connected)
      (cond
        ((net-select server "read" 1000) ; read the latest
          (net-receive server buffer 8192 "\n")
          ; ANSI coloring: output in yellow then switch back
          (print "\n\027[0;33m" buffer "\027[0;0m"))
        ((regex {^PING :(.*)\r\n} buffer) ; play ping-pong
          (net-send server (append "PONG :" (string $1 ) "\r\n"))
          (sleep 5000))
        ((net-error) ; error
          (println "\n\027[0;34m" "UH-OH: " (net-error) "\027[0;0m")
          (share connected nil)))
    (sleep 1000)))

(while (share connected)
  (sleep 1000)
  (set 'message (read-line))
  (cond
    ((starts-with message "/") ; a command?
      (net-send server (append (rest message) "\r\n"))
      (if (net-select server "read" 1000)
        (begin
          (net-receive server buffer 8192 "\n")
          (print "\n\027[0;35m" buffer "\027[0;0m"))))
    ((starts-with message "quit") ; quit
      (share connected nil))
    (true ; send input as message
      (net-send server (append "PRIVMSG #newlisp :" message "\r\n")))))

(println "finished; closing server")
(close server)
(exit)

; MORE EXAMPLES
; =============

; This section contains some simple examples of newLISP in action.
; You can find plenty of good newLISP code on the web
; and in the standard newLISP distribution.

; ON YOUR OWN TERMS
; =================

; You might find that you don't like the names of some of the newLISP functions.
; You can use constant and global to assign another symbol to the function:

(constant (global 'set!) setf)

; You can now use "set!" instead of "setf". There's no speed penalty for doing this.

; It's also possible to define your own alternatives to built-in functions.
; For example, earlier we defined a context and a default function that did
; the same job as println, but kept a count of how many characters were output.
; For this code to be evaluated rather than the built-in code, do the following.

; First, define the function:

(define (Output:Output)
  (if Output:counter
    (inc Output:counter (length (string (args))))
    (set 'Output:counter 0))
  (map print (args))
  (print "\n"))

; Keep the original newLISP version of "println" available by defining an alias for it:

(constant (global 'newLISP-println) println)

; Assign the "println" symbol to your Output function:

(constant (global 'println) Output)

; Now you can use "println" as usual:

(for (i 1 5)
  (println (inc i)))
;-> 2
;-> 3
;-> 4
;-> 5
;-> 6

(map println '(1 2 3 4 5))
;-> 1
;-> 2
;-> 3
;-> 4
;-> 5

; And it appears to do the same job as the original function.
; But now you can also make use of the bonus features of
; the alternative println that you defined:

Output:counter
;-> 36

println:counter
;-> 36

; USING A SQLITE DATABASE
; =======================

; Sometimes it's easier to use existing software rather than write all the routines yourself,
; even though it can be fun designing something from the beginning.
; For example, you can save much time and effort by using an existing database engine
; such as SQLite instead of building custom data structures and database access functions.
; Here's how you might use the SQLite database engine with newLISP.
; Suppose you have a set of data that you want to analyse.
; For example, I've found a list of information about the elements in the periodic table,
; stored as a simple space-delimited table:

(set 'elements
  [text]1 1.0079 Hydrogen H -259 -253 0.09 0.14 1776 1 13.5984
  2 4.0026 Helium He -272 -269 0 0 1895 18 24.5874
  3 6.941 Lithium Li 180 1347 0.53 0 1817 1 5.3917
  ...
  108 277 Hassium Hs 0 0 0 0 1984 8 0
  109 268 Meitnerium Mt 0 0 0 0 1982 9 0[/text])

; (You can find the list in this file on GitHub:
; http://github.com/cormullion/newlisp-projects/blob/master/sqlite-periodic-table.lsp )

; The columns here are Atomic Weight, Melting Point, Boiling Point, Density,
; Percentage in the earth's crust, Year of discovery, Group, and Ionization energy.
; (I used 0 to mean Not Applicable, which was not a very good choice, as it turns out).

; To load newLISP's SQLite module, use the following line:

(load "/usr/share/newlisp/modules/sqlite3.lsp")

; This loads in the newLISP source file which contains the SQLite interface.
; It also creates a new context called sql3, containing
; the functions and symbols for working with SQLite databases.

; Next, we want to create a new database or open an existing one:

(if (sql3:open "periodic_table")
  (println "database opened/created")
  (println "problem: " (sql3:error)))

; This creates a new SQLite database file called periodic_table, and opens it.
; If the file already exists, it will be opened ready for use.
; You don't have to refer to this database again, because newLISP's SQLite library routines
; maintain a current database in the sql3 context.
; If the open function fails, the most recent error stored in sql3:error is printed instead.

; I've just created this database, so the next step is to create a table.
; First, though, I'll define a symbol containing a string of column names
; and the SQLite data types each one should use.
; I don't have to do this, but it probably has to be written down somewhere, so,
; instead of the back of an envelope, write it in a newLISP symbol:

(set 'column-def "number INTEGER, atomic_weight FLOAT,
  element TEXT, symbol TEXT, mp FLOAT, bp FLOAT, density
  FLOAT, earth_crust FLOAT, discovered INTEGER, egroup
  INTEGER, ionization FLOAT")

; Now I can make a function that creates the table:

(define (create-table)
  (if (sql3:sql (string "create table t1 (" column-def ")"))
    (println "created table ... OK")
    (println "problem " (sql3:error))))

; It's easy because I've just created the column-def symbol in exactly the right format!
; This function uses the sql3:sql function to create a table called t1.
; I want one more function: one that fills the SQLite table
; with the data stored in the list elements.
; It's not a pretty function, but it does the job, and it only has to be called once.

(define (init-table)
  (dolist (e (parse elements "\n" 0))
    (set 'line (parse e))
    (if (sql3:sql (format "insert into t1 values (%d,%f,'%s','%s',%f,%f,%f,%f,%d,%d,%f);"
        (int (line 0))
        (float (line 1))
        (line 2)
        (line 3)
        (float (line 4))
        (float (line 5))
        (float (line 6))
        (float (line 7))
        (int (line 8))
        (int (line 9))
        (float (line 10))))
      ; success
      (println "inserted element " e)
      ; failure
      (println (sql3:error) ":" "problem inserting " e))))

; This function calls parse twice. The first parse breaks the data into lines.
; The second parse breaks up each of these lines into a list of fields.
; Then I can use format to enclose the value of each field in single quotes, remembering
; to change the strings to integers or floating-point numbers (using int and float)
; according to the column definitions.

; It's now time to build the database:

(if (not (find "t1" (sql3:tables)))
  (and
    (create-table)
    (init-table)))

; if the t1 table doesn't exist in a list of tables, 
; the functions that create and fill it are called.

; QUERYING THE DATA
; =================

; The database is now ready for use.
; But first I'll write a simple utility function to make queries easier:

(define (query sql-text)
  (set 'sqlarray (sql3:sql sql-text)) ; results of query
  (if sqlarray
    (map println sqlarray)
    (println (sql3:error) " query problem ")))

; This function submits the supplied text, and either prints out the results
; (by mapping "println" over the results list) or displays the error message.

; Here are a few sample queries.

; Find all elements discovered before 1900 that make up more than 2% of the earth's crust,
; and display the results sorted by their discovery date:

(query
  "select element,earth_crust,discovered
  from t1
  where discovered < 1900 and earth_crust > 2
  order by discovered")

;-> ("Iron" 5.05 0)
;-> ("Magnesium" 2.08 1755)
;-> ("Oxygen" 46.71 1774)
;-> ("Potassium" 2.58 1807)
;-> ("Sodium" 2.75 1807)
;-> ("Calcium" 3.65 1808)
;-> ("Silicon" 27.69 1824)
;-> ("Aluminium" 8.07 1825)

; When were the noble gases discovered (they are in group 18)?

(query
  "select symbol, element, discovered
  from t1
  where egroup = 18")

;-> ("He" "Helium" 1895)
;-> ("Ne" "Neon" 1898)
;-> ("Ar" "Argon" 1894)
;-> ("Kr" "Krypton" 1898)
;-> ("Xe" "Xenon" 1898)
;-> ("Rn" "Radon" 1900)

; What are the atomic weights of all elements whose symbols start with A?

(query
  "select element,symbol,atomic_weight
  from t1
  where symbol like 'A%'
  order by element")

;-> ("Actinium" "Ac" 227)
;-> ("Aluminium" "Al" 26.9815)
;-> ("Americium" "Am" 243)
;-> ("Argon" "Ar" 39.948)
;-> ("Arsenic" "As" 74.9216)
;-> ("Astatine" "At" 210)
;-> ("Gold" "Au" 196.9665)
;-> ("Silver" "Ag" 107.8682)

; It's elementary, my dear Watson!

; You can find MySQL and Postgres modules for newLISP on the net as well.

; SIMPLE COUNTDOWN TIMER
; ======================

; Next is a simple countdown timer that runs as a command-line utility.
; This example shows some techniques for accessing the command-line arguments in a script.
; To start a countdown, you type the command (the name of the newLISP script)
; followed by a duration.
; The duration can be in:
; - seconds
; - minutes and seconds
; - hours, minutes, and seconds
; - days, hours, minutes, and seconds,
; separated by colons.
; It can also be any newLISP expression.

countdown 30
;-> Started countdown of 00d 00h 00m 30s at 2006-09-05 15:44:17
;-> Finish time: 2006-09-05 15:44:47
;-> Elapsed: 00d 00h 00m 11s Remaining: 00d 00h 00m 19s

; or:

countdown 1:30
;-> Started countdown of 00d 00h 01m 30s at 2006-09-05 15:44:47
;-> Finish time: 2006-09-05 15:46:17
;-> Elapsed: 00d 00h 00m 02s Remaining: 00d 00h 01m 28s

; or:

countdown 1:00:00
;-> Started countdown of 00d 01h 00m 00s at 2006-09-05 15:45:15
;-> Finish time: 2006-09-05 16:45:15
;-> Elapsed: 00d 00h 00m 02s Remaining: 00d 00h 59m 58s

; or:

countdown 5:04:00:00
;-> Started countdown of 05d 04h 00m 00s at 2006-09-05 15:45:47
;-> Finish time: 2006-09-10 19:45:47
;-> Elapsed: 00d 00h 00m 05s Remaining: 05d 03h 59m 55s

; Alternatively, you can supply a newLISP expression instead of a numerical duration.
; This might be a simple calculation, such as the number of seconds in π minutes:

countdown "(mul 60 (mul 2 (acos 0)))"
;-> Started countdown of 00d 00h 03m 08s at 2006-09-05 15:52:49
;-> Finish time: 2006-09-05 15:55:57
;-> Elapsed: 00d 00h 00m 08s Remaining: 00d 00h 03m 00s

; or, more usefully, a countdown to a specific moment in time,
; which you supply by subtracting the time now from the time of the target:

countdown "(- (date-value 2006 12 25) (date-value))"
;-> Started countdown of 110d 08h 50m 50s at 2006-09-05 16:09:10
;-> Finish time: 2006-12-25 00:00:00
;-> Elapsed: 00d 00h 00m 07s Remaining: 110d 08h 50m 43s

; In this example we've specified Christmas Day using date-value,
; which returns the number of seconds since 1970 for specified dates and times.

; The evaluation of expressions is done by eval-string,
; and here it's applied to the input text if it starts with "(",
; generally a clue that there's a newLISP expression around!
; Otherwise the input is assumed to be colon-delimited, and
; is split up by parse and converted into seconds.

; The information is taken from the command line arguments, and extracted using main-args,
; which is a list of the arguments that were used when the program was run:

(main-args 2)

; This fetches argument 2:
; argument 0 is the name of the newLISP program,
; argument 1 is the name of the script, so
; argument 2 is the first string following the countdown command.

; Save this file as 'countdown', and make it executable.

#!/usr/bin/newlisp
(if (not (main-args 2))
    (begin
      (println "usage: countdown duration [message]\n
        specify duration in seconds or d:h:m:s")
      (exit)))

(define (set-duration)
; convert input to seconds
  (if (starts-with duration-input "(")
      (set 'duration-input (string (eval-string duration-input))))
  (set 'duration
    (dolist (e (reverse (parse duration-input ":")))
      (if (!= e)
        (inc duration (mul (int e) ('(1 60 3600 86400) $idx)))))))

(define (seconds->dhms s)
; convert seconds to day hour min sec display
  (letn
    ((secs (mod s 60))
     (mins (mod (div s 60) 60))
     (hours (mod (div s 3600) 24))
     (days (mod (div s 86400) 86400)))
    (format "%02dd %02dh %02dm %02ds" days hours mins secs)))

(define (clear-screen-normans-way)
; clear screen using codes - thanks to norman on newlisp forum :-)

(println "\027[H\027[2J"))
  (define (notify announcement)
; MacOS X-only code. Change for other platforms.
  (and
    (= ostype "OSX")
  ; beep thrice
    (exec (string {osascript -e 'tell application "Finder" to beep 3'}))
  ; speak announcment:
  (if (!= announcement nil)
    (exec (string {osascript -e 'say "} announcement {"'})))
  ; notify using Growl:
  (exec (format "/usr/local/bin/growlnotify %s -m \"Finished count down \""
                (date (date-value) 0 "%Y-%m-%d %H:%M:%S")))))

(set 'duration-input (main-args 2) 'duration 0)

(set-duration)

(set 'start-time (date-value))

(set 'target-time (add (date-value) duration))

(set 'banner
  (string "Started countdown of "
    (seconds->dhms duration)
    " at "
    (date start-time 0 "%Y-%m-%d %H:%M:%S")
    "\nFinish time: "
    (date target-time 0 "%Y-%m-%d %H:%M:%S")))

(while (<= (date-value) target-time)
  (clear-screen-normans-way)
  (println
    banner
    "\n\n"
    "Elapsed: "
    (seconds->dhms (- (date-value) start-time ))
    " Remaining: "
    (seconds->dhms (abs (- (date-value) target-time))))
  (sleep 1000))

(println
  "Countdown completed at "
  (date (date-value) 0
  "%Y-%m-%d %H:%M:%S") "\n")

; do any notifications here
(notify (main-args 3))

(exit)

; EDITING TEXT FILES IN FOLDERS AND HIERARCHIES
; =============================================

; Here's a simple function that updates some text date stamps in every file in a folder,
; by looking for enclosing tags and changing the text between them.
; For example, you might have a pair of tags holding the date the file was last edited,
; such as <last-edited> and </last-edited>.

(define (replace-string-in-files start-str end-str repl-str folder)
  (set 'path (real-path folder))
  (set 'file-list (directory folder {^[^.]}))
  (dolist (f file-list)
    (println "processing file " f)
    (set 'the-file (string path "/" f))
    (set 'page (read-file the-file))
    (replace
      (append start-str "(.*?)" end-str) ; pattern
        page ; text
      (append start-str repl-str end-str) ; replacement
        0) ; regex option number
(write-file the-file page)
))

; which can be called like this:

(replace-string-in-files
  {<last-edited>} {</last-edited>}
  (date (date-value) 0 "%Y-%m-%d %H:%M:%S")
  "/Users/me/Desktop/temp/")

; The replace-string-in-files function accepts a folder name.
; The first task is to extract a list of suitable files,
; we're using directory with the regular expression {^[^.]}
; to exclude all files that start with a dot.
; Then, for each file, the contents are loaded into a symbol,
; the replace function replaces text enclosed in the specified strings,
; and finally the modified text is saved back to disk.
; To call the function, specify the start and end tags,
; followed by the text and the folder name.
; In this example we're just using a simple ISO date stamp provided by date and date-value.

; RECURSIVE VERSION
; =================

; Suppose we now wanted to make this work for folders within folders within folders,
; ie to traverse a hierarchy of files, changing every file on the way down.
; To do this, re-factor the replace-string function so that it works on a passed pathname.
; Then write a recursive function to look for folders within folders,
; and generate all the required pathnames, passing each one to the replace-string function.
; This re-factoring might be a good thing to do anyway:
; it makes the first function simpler, for one thing.

(define (replace-string-in-file start-str end-str repl-str pn)
  (println "processing file " pn)
  (set 'page (read-file pn))
  (replace
    (append start-str "(.*?)" end-str) ; pattern
      page ; text
    (append start-str repl-str end-str) ; replacement
      0) ; regex option number
(write-file pn page))

; Next for that recursive tree-walking function.
; This looks at each normal entry in a folder/directory,
; and tests to see if it's a directory (using directory?).
; If it is, the replace-in-tree function calls itself and starts again at the new location.
; If it isn't, the pathname of the file is passed to the replace-string-in-file function.
 
(define (replace-in-tree dir s e r)
  (dolist (nde (directory dir {^[^.]}))
    (if (directory? (append dir nde))
        (replace-in-tree (append dir nde "/") s e r)
        (replace-string-in-file (append dir nde) s e r))))

; To change a tree-full of files, call the function like this:

(replace-in-tree
  {/Users/me/Desktop/temp/}
  {<last-edited>}
  {</last-edited>}
  (date (date-value) 0 "%Y-%m-%d %H:%M:%S"))

; It's important to test these things in a scratch area first,
; a small mistake in your code could make a big impact on your data. Caveat newLISPer!


; GRAPHICAL INTERFACE
; ===================

; INTRODUCTION
; ============

; With newLISP you can easily build graphical interfaces for your applications. 
; This introductory document is long enough already, so I won't describe 
; the newLISP-GS feature set in any detail. 
; But there's room for a short example to give you a taste of how it works.

; The basic components of newLISP-GS are containers, widgets, events, and tags. 
; Your application consists of containers, which hold widgets and other containers. 
; By giving everything a tag (a symbol), you can control them easily. 
; And when the user of the application clicks, presses, and slides things, 
; events are sent back to newLISP-GS, and you write code to handle each event.

; A SIMPLE APPLICATION
; ====================

; To introduce the basic ideas, this chapter shows 
; how easy it is to build a simple application, a color mixer:

; You can move the sliders around to change the color of the central area of the window. 
; The color components (numbers between 0 and 1 for red, green, and blue), 
; are shown in a text string at the bottom of the window.
; In newLISP-GS the contents of a container are arranged depending on the type 
; of layout manager you choose - at present you can have flow, grid, or border layouts.
; The following diagram shows the structure of the application's interface. 
; The primary container, which in this case is a frame called 'Mixer', 
; is filled with other containers and widgets. 
; The top area of the window, containing the sliders, consists of a panel called 'SliderPanel', 
; which in turn is filled with three panels, one for each slider, 
; called 'RedPanel', 'GreenPanel', and 'BluePanel'. 
; Below, the middle area holds a canvas called 'Swatch' to show the color, 
; and at the bottom area there's a text label, called 'Value', displaying the RGB values as text. 
; Each area is laid out using a different layout manager.

; There's just a single handler required. 
; This is assigned to the sliders, and it's triggered whenever a slider is moved.

; The first step is to load the newLISP-GS module:

#!/usr/bin/env newlisp
(load (append (env "NEWLISPDIR") "/guiserver.lsp"))

; This provides all the objects and functions required, in a context called gs.

; The graphics system is initialized with a single function:

(gs:init)

; The various parts of the interface can be added one by one. 
; First I define the main window, and choose the border layout. 
; Border layouts let you place each component into one of five zones, labelled 
; "north", "west", "center", "east" and "south".

(gs:frame 'Mixer 200 200 400 300 "Mixer")

(gs:set-resizable 'Mixer nil)

(gs:set-border-layout 'Mixer)

; The top panel to hold the sliders can now be added. 
; I want the sliders to be stacked vertically, 
; so I'll use a grid layout of 3 rows and 1 column:

(gs:panel 'SliderPanel)
(gs:set-grid-layout 'SliderPanel 3 1)

; Each of the three color panels, with its companion labels and slider, is defined. 
; The sliders are assigned the sliderhandler function. 
; I can write that when I've finished defining the interface.

(gs:panel 'RedPanel)
(gs:panel 'GreenPanel)
(gs:panel 'BluePanel)

(gs:label 'Red "Red" "left" 50 10 )
(gs:label 'Green "Green" "left" 50 10 )
(gs:label 'Blue "Blue" "left" 50 10 )

(gs:slider 'RedSlider 'slider-handler "horizontal" 0 100 0)
(gs:slider 'GreenSlider 'slider-handler "horizontal" 0 100 0)
(gs:slider 'BlueSlider 'slider-handler "horizontal" 0 100 0)

(gs:label 'RedSliderStatus "0" "right" 50 10)
(gs:label 'GreenSliderStatus "0" "right" 50 10)
(gs:label 'BlueSliderStatus "0" "right" 50 10)

; The gs:add-to function adds components to a container, 
; using the layout that's been assigned to it. 
; If no layout has been assigned, the flow layout, a simple sequential layout, is used. 
; Specify the target container first, then give the components to be added. 
; So the objects tagged with 'Red, 'RedSlider, and 'RedSliderStatus 
; are added one by one to the 'RedPanel container. 
; When the three panels have been done, they can be added to the SliderPanel:

(gs:add-to 'RedPanel 'Red 'RedSlider 'RedSliderStatus)
(gs:add-to 'GreenPanel 'Green 'GreenSlider 'GreenSliderStatus)

(gs:add-to 'BluePanel 'Blue 'BlueSlider 'BlueSliderStatus)
(gs:add-to 'SliderPanel 'RedPanel 'GreenPanel 'BluePanel)

; You can draw all kinds of graphics on a canvas, although for this application 
; I'm just going to use a canvas as a swatch, a single area of color:

(gs:canvas 'Swatch)
(gs:label 'Value "")
(gs:set-font 'Value "Sans Serif" 16)

; Now the three main components: the slider panel, the color swatch, and the label for the value
; can be added to the main frame. 
; Because I assigned the border layout to the frame, I can place each component using directions:

(gs:add-to 'Mixer 'SliderPanel "north" 'Swatch "center" 'Value "south")

; We haven't used the east and west areas.

; By default, frames and windows start life as invisible, 
; so now is a good time to make our main frame visible:

(gs:set-visible 'Mixer true)

; That completes the application's structure. 
; Now some initialization is required, 
; so that something sensible appears when the application launches:

(set 'red 0 'green 0 'blue 0)
(gs:set-color 'Swatch (list red green blue))
(gs:set-text 'Value (string (list red green blue)))

; Finally, I mustn't forget to write the handler code for the sliders. 
; The handler is passed the id of the object which generated the event, and the slider's value. 
; The code converts the value, an integer less than 100, to a number between 0 and 1. 
; Then the set-color function can be used to set the color of the canvas to show the new mixture.

(define (slider-handler id value)
  (cond
    ((= id "MAIN:RedSlider")
      (set 'red (div value 100))
      (gs:set-text 'RedSliderStatus (string red)))
    ((= id "MAIN:GreenSlider")
      (set 'green (div value 100))
      (gs:set-text 'GreenSliderStatus (string green)))
    ((= id "MAIN:BlueSlider")
      (set 'blue (div value 100))
      (gs:set-text 'BlueSliderStatus (string blue)))
  )
  (gs:set-color 'Swatch (list red green blue))
  (gs:set-text 'Value (string (list red green blue))))

; Only one more line is necessary and we've finished. 
; The gs:listen function listens for events and dispatches them to the handlers. 
; It runs continuously, so you don't have to do anything else.

(gs:listen)

; Save the program as 'color-mixer.lsp, and load it from newLISP REPL:

(load "color-mixer.lsp")

; This tiny little application has barely scratched the surface of newLISP-GS, 
; so take a look at the documentation and have a go!

; CODE LISTING
; ============

#!/usr/bin/env newlisp
(load (append (env "NEWLISPDIR") "/guiserver.lsp"))

(gs:init)

(gs:frame 'Mixer 200 200 400 300 "Mixer")

(gs:set-resizable 'Mixer nil)

(gs:set-border-layout 'Mixer)

(gs:panel 'SliderPanel)

(gs:set-grid-layout 'SliderPanel 3 1)

(gs:panel 'RedPanel)
(gs:panel 'GreenPanel)
(gs:panel 'BluePanel)

(gs:label 'Red "Red" "left" 50 10 )
(gs:label 'Green "Green" "left" 50 10 )
(gs:label 'Blue "Blue" "left" 50 10 )

(gs:slider 'RedSlider 'slider-handler "horizontal" 0 100 0)
(gs:slider 'GreenSlider 'slider-handler "horizontal" 0 100 0)
(gs:slider 'BlueSlider 'slider-handler "horizontal" 0 100 0)

(gs:label 'RedSliderStatus "0" "right" 50 10)
(gs:label 'GreenSliderStatus "0" "right" 50 10)
(gs:label 'BlueSliderStatus "0" "right" 50 10)

(gs:add-to 'RedPanel 'Red 'RedSlider 'RedSliderStatus)
(gs:add-to 'GreenPanel 'Green 'GreenSlider 'GreenSliderStatus)
(gs:add-to 'BluePanel 'Blue 'BlueSlider 'BlueSliderStatus)

(gs:add-to 'SliderPanel 'RedPanel 'GreenPanel 'BluePanel)

(gs:canvas 'Swatch)

(gs:label 'Value "")

(gs:set-font 'Value "Sans Serif" 16)

(gs:add-to 'Mixer 'SliderPanel "north" 'Swatch "center" 'Value "south")

(gs:set-visible 'Mixer true)

(set 'red 0 'green 0 'blue 0)

(gs:set-color 'Swatch (list red green blue))

(gs:set-text 'Value (string (list red green blue)))

(define (slider-handler id value)
  (cond
    ((= id "MAIN:RedSlider")
      (set 'red (div value 100))
      (gs:set-text 'RedSliderStatus (string red)))
    ((= id "MAIN:GreenSlider")
      (set 'green (div value 100))
      (gs:set-text 'GreenSliderStatus (string green)))
    ((= id "MAIN:BlueSlider")
      (set 'blue (div value 100))
      (gs:set-text 'BlueSliderStatus (string blue)))
  )
  (gs:set-color 'Swatch (list red green blue))
  (gs:set-text 'Value (string (list red green blue))))

(gs:listen)

(exit)

;;eof