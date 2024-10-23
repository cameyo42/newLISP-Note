===========

 APPENDICI

===========

============================================================================
 The fifteen ideas characterizing LISP
============================================================================

The fifteen ideas characterizing LISP:
1. Computing with symbolic expressions rather than numbers.
2. Representation of symbolic expressions and other information by list structure in computer memory.
3. Representation of information on paper, from keyboards and in other external media mostly by multi-level lists and sometimes by S-expressions. It has been important that any kind of data can be represented by a single general type.
4. A small set of selector and constructor operations expressed as func- tions, i.e. car, cdr and cons.
5. Composition of functions as a tool for forming more complex functions.
6. The use of conditional expressions for getting branching into function definitions.
7. The recursive use of conditional expressions as a sufficient tool for building computable functions.
8. The use of lambda-expressions for naming functions.
9. The storage of information on the property lists of atoms.
10. The representation of LISP programs as LISP data that can be manipulated by object programs. This has prevented the separation between system programmers and application programmers. Everyone can "improve" his LISP, and many of these "improvements" have developed into improvements to the language.
11. The conditional expression interpretation of Boolean connectives.
12. The LISP function eval that serves both as a formal definition of the language and as an interpreter.
13. Garbage collection as the means of erasure.
14. Minimal requirements for declarations so that LISP statements can be executed in an on-line environment without preliminaries.
15. LISP statements as a command language in an on-line environment.


============================================================================
 Lista delle funzioni newLISP
============================================================================

List processing, flow control, and integer arithmetic
=====================================================
+, -, *, /, %     integer arithmetic
++                increment integer numbers
--                decrement integer numbers
<, >, =           compares any data type: less, greater, equal
<=, >=, !=        compares any data type: less-equal, greater-equal, not-equal
:                 constructs a context symbol and applies it to an object
and               logical and
append            appends lists ,arrays or strings to form a new list, array or string
apply             applies a function or primitive to a list of arguments
args              retrieves the argument list of a function or macro expression
assoc             searches for keyword associations in a list
begin             begins a block of functions
bigint            convert a number to big integer format
bind              binds variable associations in a list
case              branches depending on contents of control variable
catch             evaluates an expression, possibly catching errors
chop              chops elements from the end of a list
clean             cleans elements from a list
collect           repeat evaluating an expression and collect results in a list
cond              branches conditionally to expressions
cons              prepends an element to a list, making a new list
constant          defines a constant symbol
count             counts elements of one list that occur in another list
curry             transforms a function f(x, y) into a function fx(y)
define            defines a new function or lambda expression
define-macro      defines a macro or lambda-macro expression
def-new           copies a symbol to a different context (namespace)
difference        returns the difference between two lists
doargs            iterates through the arguments of a function
dolist            evaluates once for each element in a list
dostring          evaluates once for each character in a string
dotimes           evaluates once for each number in a range
dotree            iterates through the symbols of a context
do-until          repeats evaluation of an expression until the condition is met
do-while          repeats evaluation of an expression while the condition is true
dup               duplicates a list or string a specified number of times
ends-with         checks the end of a string or list against a key of the same type
eval              evaluates an expression
exists            checks for the existence of a condition in a list
expand            replaces a symbol in a nested list
explode           explodes a list or string
extend            extends a list or string
first             gets the first element of a list or string
filter            filters a list
find              searches for an element in a list or string
flat              returns the flattened list
fn                defines a new function or lambda expression
for               evaluates once for each number in a range
for-all           checks if all elements in a list meet a condition
if                evaluates an expression conditionally
index             filters elements from a list and returns their indices
intersect         returns the intersection of two lists
lambda            defines a new function or lambda expression
last              returns the last element of a list or string
length            calculates the length of a list or string
let               declares and initializes local variables
letex             expands local variables into an expression, then evaluates
letn              initializes local variables incrementally, like nested lets
list              makes a list
local             declares local variables
lookup            looks up members in an association list
map               maps a function over members of a list, collecting the results
match             matches patterns against lists; for matching against strings, see find and regex
member            finds a member of a list or string
not               logical not
nth               gets the nth element of a list or string
or                logical or
pop               deletes and returns an element from a list or string
pop-assoc         removes an association from an association list
push              inserts a new element into a list or string
quote             quotes an expression
ref               returns the position of an element inside a nested list
ref-all           returns a list of index vectors of elements inside a nested list
rest              returns all but the first element of a list or string
replace           replaces elements inside a list or string
reverse           reverses a list or string
rotate            rotates a list or string
select            selects and permutes elements from a list or string
self              Accesses the target object inside a FOOP method
set               sets the binding or contents of a symbol
setf setq         sets contents of a symbol or list, array or string reference
set-ref           searches for an element in a nested list and replaces it
set-ref-all       searches for an element in a nested list and replaces all instances
silent            works like begin but suppresses console output of the return value
slice             extracts a sublist or substring
sort              sorts the members of a list
starts-with       checks the beginning of a string or list against a key of the same type
swap              swaps two elements inside a list or string
unify             unifies two expressions
unique            returns a list without duplicates
union             returns a unique list of elements found in two or more lists.
unless            evaluates an expression conditionally
until             repeats evaluation of an expression until the condition is met
when              evaluates a block of statements conditionally
while             repeats evaluation of an expression while the condition is true

String and conversion functions
===============================
address           gets the memory address of a number or string
bigint            convert a number to big integer format
bits              translates a number into binary representation
char              translates between characters and ASCII codes
chop              chops off characters from the end of a string
dostring          evaluates once for each character in a string
dup               duplicates a list or string a specified number of times
ends-with         checks the end of a string or list against a key of the same type
encrypt           does a one-time–pad encryption and decryption of a string
eval-string       compiles, then evaluates a string
explode           transforms a string into a list of characters
extend            extends a list or string
find              searches for an element in a list or string
find-all          returns a list of all pattern matches found in string
first             gets the first element in a list or string
float             translates a string or integer into a floating point number
format            formats numbers and strings as in the C language
get-char          gets a character from a memory address
get-float         gets a double float from a memory address
get-int           gets a 32-bit integer from a memory address
get-long          gets a long 64-bit integer from a memory address
get-string        gets a string from a memory address
int               translates a string or float into an integer
join              joins a list of strings
last              returns the last element of a list or string
lower-case        converts a string to lowercase characters
member            finds a list or string member
name              returns the name of a symbol or its context as a string
nth               gets the nth element in a list or string
pack              packs newLISP expressions into a binary structure
parse             breaks a string into tokens
pop               pops from a string
push              pushes onto a string
regex             performs a Perl-compatible regular expression search
regex-comp        pre-compiles a regular expression pattern
replace           replaces elements in a list or string
rest              gets all but the first element of a list or string
reverse           reverses a list or string
rotate            rotates a list or string
select            selects and permutes elements from a list or string
setf setq         sets contents of a string reference
slice             extracts a substring or sublist
source            returns the source required to bind a symbol as a string
starts-with       checks the start of the string or list against a key string or list
string            transforms anything into a string
sym               translates a string into a symbol
title-case        converts the first character of a string to uppercase
trim              trims a string on one or both sides
unicode           converts ASCII or UTF-8 to UCS-4 Unicode
utf8              converts UCS-4 Unicode to UTF-8
utf8len           returns length of an UTF-8 string in UTF-8 characters
unpack            unpacks a binary structure into newLISP expressions
upper-case        converts a string to uppercase characters

Floating point math and special functions
=========================================
abs               returns the absolute value of a number
acos              calculates the arc-cosine of a number
acosh             calculates the inverse hyperbolic cosine of a number
add               adds floating point or integer numbers and returns a floating point number
array             creates an array
array-list        returns a list conversion from an array
asin              calculates the arcsine of a number
asinh             calculates the inverse hyperbolic sine of a number
atan              calculates the arctangent of a number
atanh             calculates the inverse hyperbolic tangent of a number
atan2             computes the principal value of the arctangent of Y / X in radians
beta              calculates the beta function
betai             calculates the incomplete beta function
binomial          calculates the binomial function
ceil              rounds up to the next integer
cos               calculates the cosine of a number
cosh              calculates the hyperbolic cosine of a number
crc32             calculates a 32-bit CRC for a data buffer
dec               decrements a number in a variable, list or array
div               divides floating point or integer numbers
erf               calculates the error function of a number
exp               calculates the exponential e of a number
factor            factors a number into primes
fft               performs a fast Fourier transform (FFT)
floor             rounds down to the next integer
flt               converts a number to a 32-bit integer representing a float
gammai            calculates the incomplete Gamma function
gammaln           calculates the log Gamma function
gcd               calculates the greatest common divisor of a group of integers
ifft              performs an inverse fast Fourier transform (IFFT)
inc               increments a number in a variable, list or array
inf?              checks if a floating point value is infinite
log               calculates the natural or other logarithm of a number
min               finds the smallest value in a series of values
max               finds the largest value in a series of values
mod               calculates the modulo of two numbers
mul               multiplies floating point or integer numbers
NaN?              checks if a float is NaN (not a number)
round             rounds a number
pow               calculates x to the power of y
sequence          generates a list sequence of numbers
series            creates a geometric sequence of numbers
sgn               calculates the signum function of a number
sin               calculates the sine of a number
sinh              calculates the hyperbolic sine of a number
sqrt              calculates the square root of a number
ssq               calculates the sum of squares of a vector
sub               subtracts floating point or integer numbers
tan               calculates the tangent of a number
tanh              calculates the hyperbolic tangent of a number
uuid              returns a UUID (Universal Unique IDentifier)

Matrix functions
================
det               returns the determinant of a matrix
invert            returns the inversion of a matrix
mat               performs scalar operations on matrices
multiply          multiplies two matrices
transpose         returns the transposition of a matrix

Array functions
===============
append            appends arrays
array             creates and initializes an array with up to 16 dimensions
array-list        converts an array into a list
array?            checks if expression is an array
det               returns the determinant of a matrix
first             returns the first row of an array
invert            returns the inversion of a matrix
last              returns the last row of an array
mat               performs scalar operations on matrices
multiply          multiplies two matrices
nth               returns an element of an array
rest              returns all but the first row of an array
setf              sets contents of an array reference
slice             returns a slice of an array
transpose         transposes a matrix

Bit operators
=============
<<, >>            bit shift left, bit shift right
&                 bitwise and
|                 bitwise inclusive or
^                 bitwise exclusive or
~                 bitwise not

Predicates
==========
atom?             checks if an expression is an atom
array?            checks if an expression is an array
bigint?           checks if a number is a big integer
context?          checks if an expression is a context
directory?        checks if a disk node is a directory
empty?            checks if a list or string is empty
even?             checks the parity of an integer number
file?             checks if a file exists
float?            checks if an expression is a float
global?           checks if a symbol is global
inf?              checks if a floating point value is infinite
integer?          checks if an expression is an integer
lambda?           checks if an expression is a lambda expression
legal?            checks if a string contains a legal symbol
list?             checks if an expression is a list
macro?            checks if an expression is a lambda-macro expression
NaN?              checks if a float is NaN (not a number)
nil?              checks if an expression is nil
null?             checks if an expression is nil, "", (), 0 or 0.0
number?           checks if an expression is a float or an integer
odd?              checks the parity of an integer number
protected?        checks if a symbol is protected
primitive?        checks if an expression is a primitive
quote?            checks if an expression is quoted
string?           checks if an expression is a string
symbol?           checks if an expression is a symbol
true?             checks if an expression is not nil
zero?             checks if an expression is 0 or 0.0

Date and time functions
=======================
date              converts a date-time value to a string
date-list         returns a list of year, month, day, hours, minutes, seconds from a time value in seconds
date-parse        parses a date string and returns the number of seconds passed since January 1, 1970, (formerly parse-date)
date-value        calculates the time in seconds since January 1, 1970 for a date and time
now               returns a list of current date-time information
time              calculates the time it takes to evaluate an expression in milliseconds
time-of-day       calculates the number of milliseconds elapsed since the day started

Statistics, simulation and modeling functions
=============================================
amb               randomly selects an argument and evaluates it
bayes-query       calculates Bayesian probabilities for a data set
bayes-train       counts items in lists for Bayesian or frequency analysis
corr              calculates the product-moment correlation coefficient
crit-chi2         calculates the Chi² statistic for a given probability
crit-f            calculates the F statistic for a given probability
crit-t            calculates the Student's t statistic for a given probability
crit-z            calculates the normal distributed Z for a given probability
kmeans-query      calculates distances to cluster centroids or other data points
kmeans-train      partitions a data set into clusters
normal            makes a list of normal distributed floating point numbers
prob-chi2         calculates the tail probability of a Chi² distribution value
prob-f            calculates the tail probability of a F distribution value
prob-t            calculates the tail probability of a Student's t distribution value
prob-z            calculates the cumulated probability of a Z distribution value
rand              generates random numbers in a range
random            generates a list of evenly distributed floats
randomize         shuffles all of the elements in a list
seed              seeds the internal random number generator
stats             calculates some basic statistics for a data vector
t-test            compares means of data samples using the Student's t statistic

Pattern matching
================
ends-with         tests if a list or string ends with a pattern
find              searches for a pattern in a list or string
find-all          finds all occurrences of a pattern in a string
match             matches list patterns
parse             breaks a string along around patterns
ref               returns the position of an element inside a nested list
ref-all           returns a list of index vectors of elements inside a nested list
regex             finds patterns in a string
replace           replaces patterns in a string
search            searches for a pattern in a file
starts-with       tests if a list or string starts with a pattern
unify             performs a logical unification of patterns

Financial math functions
========================
fv                returns the future value of an investment
irr               calculates the internal rate of return
nper              calculates the number of periods for an investment
npv               calculates the net present value of an investment
pv                calculates the present value of an investment
pmt               calculates the payment for a loan

Input/output and file operations
================================
append-file       appends data to a file
close             closes a file
current-line      retrieves contents of last read-line buffer
device            sets or inquires about current print device
exec              launches another program, then reads from or writes to it
load              loads and evaluates a file of newLISP code
open              opens a file for reading or writing
peek              checks file descriptor for number of bytes ready for reading
print             prints to the console or a device
println           prints to the console or a device with a line-feed
read              reads binary data from a file
read-char         reads an 8-bit character from a file
read-file         reads a whole file in one operation
read-key          reads a keyboard key
read-line         reads a line from the console or file
read-utf8         reads UTF-8 character from a file
save              saves a workspace, context, or symbol to a file
search            searches a file for a string
seek              sets or reads a file position
write             writes binary data to a file
write-char        writes a character to a file
write-file        writes a file in one operation
write-line        writes a line to the console or a file

Processes and the Cilk API
==========================
!                 shells out to the operating system
abort             aborts a child process started with spawn
destroy           destroys a process created with fork or process
exec              runs a process, then reads from or writes to it
fork              launches a newLISP child process
pipe              creates a pipe for interprocess communication
process           launches a child process, remapping standard I/O and standard error
receive           receive a message from another process
semaphore         creates and controls semaphores
send              send a message to another process
share             shares memory with other processes
spawn             launches a child process for Cilk process management
sync              waits for child processes launched with spawn and collects results
wait-pid          waits for a child process to end

File and directory management
=============================
change-dir        changes to a different drive and directory
copy-file         copies a file
delete-file       deletes a file
directory         returns a list of directory entries
file-info         gets file size, date, time, and attributes
make-dir          makes a new directory
real-path         returns the full path of the relative file path
remove-dir        removes an empty directory
rename-file       renames a file or directory

HTTP networking API
===================
base64-enc        encodes a string into BASE64 format
base64-dec        decodes a string from BASE64 format
delete-url        deletes a file or page from the web
get-url           reads a file or page from the web
json-error        returns error information from a failed JSON translation.
json-parse        parses JSON formatted data
post-url          posts info to a URL address
put-url           uploads a page to a URL address
xfer-event        registers an event handler for HTTP byte transfers
xml-error         returns last XML parse error
xml-parse         parses an XML document
xml-type-tags     shows or modifies XML type tags

Socket TCP/IP, UDP and ICMP network API
=======================================
net-accept        accepts a new incoming connection
net-close         closes a socket connection
net-connect       connects to a remote host
net-error         returns the last error
net-eval          evaluates expressions on multiple remote newLISP servers
net-interface     Sets the default interface IP address on multihomed computers.
net-ipv           Switches between IPv4 and IPv6 internet protocol versions.
net-listen        listens for connections to a local socket
net-local         returns the local IP and port number for a connection
net-lookup        returns the name for an IP number
net-packet        send a custom configured IP packet over raw sockets
net-peek          returns the number of characters ready to be read from a network socket
net-peer          returns the remote IP and port for a net connect
net-ping          sends a ping packet (ICMP echo request) to one or more addresses
net-receive       reads data on a socket connection
net-receive-from  reads a UDP on an open connection
net-receive-udp   reads a UDP and closes the connection
net-select        checks a socket or list of sockets for status
net-send          sends data on a socket connection
net-send-to       sends a UDP on an open connection
net-send-udp      sends a UDP and closes the connection
net-service       translates a service name into a port number
net-sessions      returns a list of currently open connections

API for newLISP in a web browser
================================
display-html      display an HTML page in a web browser
eval-string-js    evaluate JavaScript in the current web browser page

Reflection and customization
============================
command-event     pre-processes the command-line and HTTP requests
error-event       defines an error handler
history           returns the call history of a function
last-error        report the last error number and text
macro             create a reader expansion macro
ostype            contains a string describing the OS platform
prefix            Returns the context prefix of a symbol
prompt-event      customizes the interactive newLISP shell prompt
read-expr         reads and translates s-expressions from source
reader-event      preprocess expressions before evaluation event-driven
set-locale        switches to a different locale
source            returns the source required to bind a symbol to a string
sys-error         reports OS system error numbers
sys-info          gives information about system resources
term              returns the term part of a symbol or its context as a string

System functions
================
$                 accesses system variables $0 -> $15
callback          registers a callback function for an imported library
catch             evaluates an expression, catching errors and early returns
context           creates or switches to a different namespace
copy              copies the result of an evaluation
debug             debugs a user-defined function
delete            deletes symbols from the symbol table
default           returns the contents of a default functor from a context
env               gets or sets the operating system's environment
exit              exits newLISP, setting the exit value
global            makes a symbol accessible outside MAIN
import            imports a function from a shared library
main-args         gets command-line arguments
new               creates a copy of a context
pretty-print      changes the pretty-printing characteristics
read-expr         translates a string to an s-expression without evaluating it
reset             goes to the top level
signal            sets a signal handler
sleep             suspends processing for specified milliseconds
sym               creates a symbol from a string
symbols           returns a list of all symbols in the system
throw             causes a previous catch to return
throw-error       throws a user-defined error
timer             starts a one-shot timer, firing an event
trace             sets or inquires about trace mode
trace-highlight   sets highlighting strings in trace mode

Importing libraries
===================
address           returns the memory address of a number or string
callback          registers a callback function for an imported library
flt               converts a number to a 32-bit integer representing a float
float             translates a string or integer into a floating point number
get-char          gets a character from a memory address
get-float         gets a double float from a memory address
get-int           gets a 32-bit integer from a memory address
get-long          gets a long 64-bit integer from a memory address
get-string        gets a string from a memory address
import            imports a function from a shared library
int               translates a string or float into an integer
pack              packs newLISP expressions into a binary structure
struct            Defines a data structure with C types
unpack            unpacks a binary structure into newLISP expressions

newLISP internals API
=====================
command-event     pre-processes the command-line and HTTP requests
cpymem            copies memory between addresses
dump              shows memory address and contents of newLISP cells
prompt-event      customizes the interactive newLISP shell prompt
read-expr         reads and translates s-expressions from source
reader-event      preprocess expressions before evaluation event-driven

Riguardare la lista rinfresca la memoria e aiuta a trovare funzioni... prima sconosciute.

============================================================================
 Sul linguaggio newLISP - FAQ di Lutz Mueller
============================================================================

Questa è la traduzione della pagina web relativa alle FAQ (Frequently Asked Questions) su newLISP:

http://www.newLISP.org/index.cgi?FAQ

1.  Cos'è newLISP e cosa posso fare con questo linguaggio?
2.  Perché newLISP, perché non uno degli altri LISP standard?
3.  Come posso studiare newLISP?
4.  Quanto è veloce newLISP?
5.  newLISP ha le matrici?
6.  newLISP ha le tabelle hash?
7.  newLISP ha una gestione automatica della memoria?
8.  newLISP può passare i dati per riferimento?
9.  Come funziona il variable scoping in newLISP?
10. newLISP gestisce il multiprocessing?
11. Posso usare newLISP per compiti di calcolo distribuiti?
12. Possiamo utilizzare la metodologia di programmazione orientata agli oggetti?
13. Cosa sono di pacchetti e moduli?
14. Quali sono alcune differenze tra newLISP e altri LISP?
15. newLISP funziona sul sistema operativo XYZ?
16. newLISP può gestire i caratteri speciali del mio paese e della mia lingua?
17. L'indicizzazione implicita non infrange le regole di sintassi del LISP?
18. newLISP può essere incorporato in altri programmi?
19. Posso mettere il copyright ai miei script anche se newLISP è concesso in licenza GPL?
20. Dove posso segnalare eventuali bug?

1. Cos'è newLISP e cosa posso fare con questo linguaggio?
---------------------------------------------------------
newLISP è un linguaggio di scripting simile al LISP per fare quelle cose che si fanno tipicamente con linguaggi di scripting: programmazione per internet, amministrazione di sistema, elaborazione testi, incollare diversi altri programmi insieme, ecc. newLISP è un LISP di scripting per persone che sono affascinate dalla bellezza e dal potere espressivo del LISP, ma che hanno bisogno di una versione ridotta per imparare facilmente l'essenziale.

2. Perché newLISP, perché non uno degli altri LISP standard?
------------------------------------------------------------
LISP è un vecchio linguaggio nato, cresciuto e standardizzato in tempi molto diversi da oggi, tempi in cui la programmazione era per persone altamente istruite che hanno progettato programmi. newLISP è un LISP rinato come linguaggio di scripting: pragmatico e casuale, semplice da imparare senza che tu debba conoscere concetti avanzati di informatica. Come ogni buon linguaggio di scripting, newLISP è relativamente semplice da imparare e potente per terminare il proprio lavoro senza problemi.

Vedi anche: "In Praise of Scripting: Real Programming Pragmatics" di Ronald P. Loui

http://web.cs.mun.ca/~harold/Courses/Old/CS2500.F09/Diary/04563874.pdf

newLISP ha un tempo di avvio molto veloce, ha bisogno di poche risorse come spazio su disco e memoria ed ha una pratica API con funzioni native per networking, statistica, machine learning, espressioni regolari, multiprocessing e calcolo distribuito, non aggiunte successivamente con moduli esterni.

3. Come posso studiare newLISP?
-------------------------------
Almeno all'inizio, studia principalmente newLISP utilizzandolo. Se capisci questo:

(+ 1 2 3); calcola la somma di 1,2,3 => 6

e questo:

(define (double x) (+ x x)); definisce una funzione

(doppio 123); calcola il doppio di 123 => 246

allora hai imparato abbastanza per iniziare a programmare in newLISP. Ci sono alcuni altri concetti come le funzioni anonime, l'applicazione di funzioni, spazi dei nomi (contesti) e l'indicizzazione implicita. Imparerai queste tecniche mentre usi newLISP.
I libri su LISP o Scheme, che sono due standard di LISP diversi e più vecchi, insegnano concetti che non hai la necessità di imparare per programmare in newLISP. Molte volte newLISP esprime le cose in modo diverso dai LISP tradizionali e in modi più applicabili ai compiti di programmazione odierni e ad un livello superiore più vicino al problema in questione.
Impara a risolvere i problemi con il modo newLISP! Per una comprensione più approfondita di newLISP, leggi la sezione del "Manuale utente" di newLISP, con meno teoria e più esempi. Dai uno sguardo al "Manuale di riferimento" per avere un'idea della profondità e dell'ampiezza delle funzioni API integrate.
Per lavorare seriamente con newLISP occorre leggere il manuale "Code Patterns" con altri suggerimenti e pezzi di codice. Un'ottima introduzione per principianti è il libro "Introduction to newLISP" oppure i video tutorial che sono disponibili nella pagina ufficiale della documentazione.
Molte funzioni in newLISP hanno una funzionalità facile da capire, ma sono molto più potenti quando si conoscono e si usano le opzioni speciali di quella funzione. La profondità della API di newLISP non è basata sulla quantità delle funzioni, ma piuttosto sulle opzioni e sulle sintassi multipla di ogni specifica funzione
Inizia a scrivere il tuo primo programma ora. Guarda le porzioni di codice (snippet) riportate in tutto il manuale e su questo sito web. Se hai domande, iscriviti al forum di discussione di newLISP e chiedi.

4. Quanto è veloce newLISP?
---------------------------
La velocità di calcolo di newLISP è confrontabile con quella dei popolari strumenti di scripting come Perl o Python, ma si comporta meglio quando si tratta di tempi di avvio e di memoria / spazio su disco.
Dai un'occhiata ad alcuni benchmark: http://www.newLISP.org/benchmarks/
Molte funzioni per cui altri linguaggi richiedono l'utilizzo di moduli esterni sono già incorporate in newLISP. Funzioni di networking e metodi matematici come FFT (Fast Fourier Analysis) o funzioni di apprendimento automatico bayesiano sono rapidissime in newLISP. Sono funzioni integrate e non richiedono alcun modulo esterno. Nonostante ciò, newLISP è più piccolo di altri linguaggi di scripting.

5. newLISP ha le matrici?
-------------------------
Sì. Per le applicazioni con accesso random a liste di grandi dimensioni, l'accesso può essere effettuato più velocemente utilizzando gli array di newLISP.

6. newLISP ha le tabelle hash?
------------------------------
newLISP utilizza alberi binari red-black per l'accesso alla memoria associativa quando si gestiscono spazi dei nomi (namespace), dizionari e per l'accesso ai valori-chiave simili alla tecnica hash.

7. newLISP ha una gestione automatica della memoria?
----------------------------------------------------
Sì. Ma non è il tipico processo di garbage collection che trovi in altri linguaggi interattivi. Proprio come la garbage collection dei tradizionali linguaggi, newLISP ricicla la memoria inutilizzata. Tuttavia, newLISP lo fa in un modo nuovo, molto più efficiente. La gestione della memoria di newLISP è sincrona senza pause improvvise nell'elaborazione che vengono osservate in linguaggi con garbage collection vecchio stile. L'esclusiva gestione automatica della memoria di newLISP è una delle ragioni della sua velocità, delle sue dimensioni ridotte e dell'uso efficiente della memoria.
Vedi anche: "Automatic Memory Management in newLISP" di Lutz Mueller

http://www.newLISP.org/MemoryManagement.html

8. newLISP può passare i dati per riferimento?
----------------------------------------------
Tutte le funzioni integrate passano liste e stringhe per riferimento sia in ingresso che in uscita. Per passare per riferimento a funzioni definite dall'utente, liste e stringhe possono essere raggruppati in spazi dei nomi particolari (context). Maggiori informazioni su questo argomento sul manuale utente. Dalla versione 10.2, FOOP passa per riferimento anche l'oggetto.

9. Come funziona il variable scoping in newLISP?
------------------------------------------------
newLISP ha uno scope dinamico applicato all'interno di contesti o spazi dei nomi separati lessicalmente. I namespace hanno un overhead molto piccolo e possono esisterne a milioni. I contesti in newLISP consentono la chiusura lessicale di più di una funzione lambda e di un oggetto. I contesti possono essere utilizzati per scrivere funzioni con scope lessicale con memoria, moduli software e oggetti. Ciò evita le insidie dello scope dinamico e aiuta a strutturare programmi più grandi.

10. newLISP gestisce il multiprocessing?
----------------------------------------
Le versioni Linux / UNIX di newLISP possono eseguire il fork e lo spawn dei processi. Le versioni di Windows possono avviare processi figlio indipendenti. I semafori vengono utilizzati per sincronizzare i processi e la memoria condivisa può essere utilizzata per le comunicazioni tra i processi.
Su macOS, Linux e altri Unix, l'API Cilk è integrata per facilitare il lancio e la sincronizzazione di più processi, in modo trasparente senza preoccuparsi di semafori, blocchi, ecc. È disponibile un'API di messaggistica asincrona per comunicare tra processi.

11. Posso usare newLISP per compiti di calcolo distribuiti?
-----------------------------------------------------------
Alcune delle applicazioni più grandi di oggi vengono distribuite su più computer, dividendo le loro complesse attività tra più nodi su una rete. newLISP può essere eseguito come server per valutare i comandi inviati da altri client newLISP ad esso connessi. La funzione "net-eval" incapsula tutta la gestione della rete necessaria per comunicare con altri computer sulla rete, distribuire il codice e le attività di calcolo e raccogliere i risultati in un modo bloccante o basato sugli eventi. newLISP può anche fungere da server Web che gestisce le richieste HTTP incluso CGI.

12. Possiamo utilizzare la metodologia di programmazione orientata agli oggetti?
--------------------------------------------------------------------------------
newLISP offre un nuovo modo di programmazione orientata agli oggetti funzionale chiamata FOOP. Usa gli spazi dei nomi per raccogliere tutti i metodi per una classe di oggetti e usa le normali espressioni S per rappresentare gli oggetti. Per ulteriori dettagli su questo nuovo modo di programmazione orientata agli oggetti in newLISP consultare la serie di video di addestramento "Towards FOOP" nella sezione documentazione e il capitolo "Functional object-oriented programming" nel manuale utente. Dalla versione 10.2 gli oggetti FOOP sono mutabili.

13. Cosa sono  pacchetti e moduli?
----------------------------------
newLISP utilizza gli spazi dei nomi per la creazione di pacchetti e moduli. Esistono moduli per l'accesso ai database come MySQL, PostgreSQL e SQLite, nonché ODBC. I moduli aggiuntivi supportano i protocolli Internet FTP, POP3, SMTP e REST. Poiché i nuovi spazi dei nomi di LISP vengono chiusi lessicamente, newLISP consente ai programmatori di trattare i moduli come black box. Questo metodologia è adatta per gruppi di programmatori che lavorano su applicazioni di grandi dimensioni.
newLISP può anche chiamare funzioni di librerie C condivise su Linux / UNIX e sistemi operativi Windows per espandere le sue funzionalità.
I moduli possono essere documentati utilizzando il sistema di documentazione automatica  newLISPdoc.

14. Quali sono alcune differenze tra newLISP e altri LISP?
----------------------------------------------------------
Le nuove differenze di LISP dagli altri LISP includono: il funzionamento delle espressioni lambda, l'esistenza di namespace (o contesti), il passaggio parametri e, naturalmente, la  API di newLISP (repertorio di funzioni). Nel complesso, il nuovo modo di programmazione del LISP di newLISP lo rendono più veloce, più piccolo e più facile da capire e da apprendere. Per una discussione più dettagliata, vedere "Comparison to Common Lisp and Scheme":

http://www.newLISP.org/index.cgi?page=Differences_to_Other_LISPs

15. newLISP funziona sul sistema operativo XYZ?
-----------------------------------------------
Probabilmente si. newLISP ha un minimo di dipendenze. Utilizza solo librerie C standard per la compilazione. Se il tuo sistema ha strumenti GNU come il compilatore GCC e l'utility make, allora newLISP dovrebbe compilare e linkare immediatamente usando uno dei makefile contenuti nella sua distribuzione sorgente.
newLISP viene creato utilizzando uno dei numerosi makefile, ciascuno scritto per una piattaforma specifica. Non ci sono script di make complessi. I makefile sono brevi e facili da modificare e adattare se  non sono già inclusi nella tua piattaforma o configurazione.

16. newLISP può gestire i caratteri speciali del mio paese e della mia lingua?
------------------------------------------------------------------------------
Nella maggior parte del mondo occidentale, è sufficiente impostare le impostazioni internazionali utilizzando la funzione newLISP "set-locale".
Più della metà dei paesi del mondo usano una virgola decimale invece di un punto decimale. newLISP leggerà e scriverà correttamente le virgole decimali quando passerà alla corretta locale.
La maggior parte degli alfabeti nell'emisfero occidentale si adattano a tabelle di codici carattere a 256 codici e ogni carattere richiede un solo byte di 8 bit da codificare. Se la lingua del tuo paese richiede caratteri multibyte per codificarla, allora hai bisogno della versione di newLISP con supporto UTF-8 abilitato. I Makefile per Windows e Linux sono inclusi per compilare le versioni UTF-8 di newLISP. Nella versione UTF-8, molte funzioni di gestione dei caratteri sono in grado di gestire caratteri multibyte. Vedere il capitolo sulla localizzazione e UTF-8 nel manuale per i dettagli.

17. L'indicizzazione implicita non infrange le regole di sintassi del LISP?
---------------------------------------------------------------------------
Al contrario, l'indicizzazione implicita è un'estensione logica della sintassi LISP. Quando si valutano le espressioni S, il primo elemento viene applicato come una funzione agli elementi restanti nell'espressione che servono come argomenti della funzione. L'indicizzazione implicita consiste semplicemente nel considerare i membri dei tipi di dati numerici, di stringa e di elenco come operatori speciali di indicizzazione quando si trovano nella prima posizione di un'espressione S.

18. newLISP può essere incorporato in altri programmi?
------------------------------------------------------
newLISP può essere compilato come libreria condivisa UNIX o DLL Windows (libreria a collegamento dinamico). Di conseguenza, le versioni di libreria condivisa di newLISP possono essere utilizzate all'interno di altri programmi che sono in grado di importare funzioni di libreria condivisa. Altri modi per integrare la tua applicazione con newLISP includono i pipe I/O e le porte di rete.
Sui sistemi Win32, newLISP è stato utilizzato all'interno di MS Excel, MS Visual Basic e del generatore di applicazioni GUI NeoBook. Su UNIX, newLISP è stato utilizzato all'interno del foglio di calcolo di GNumeric. Su macOS, newLISP è stato utilizzato come linguaggio di estensione per l'editor di BBEdit grazie alla nuova LISP che comunica con BBEdit tramite i pipe di I/O standard. Il Guiserver basato su Java e il vecchio frontend Tcl/Tk per newLISP sono esempi di integrazione di newLISP tramite porte di rete.

19. Copyright sui miei script anche se newLISP è concesso in licenza GPL?
-------------------------------------------------------------------------
Si, puoi. Le FAQ di gnu.org per la GPL lo spiegano. Finché i tuoi script non usano altro software GPL di terze parti sotto forma di librerie importate o moduli caricati, i tuoi script in newLISP non devono necessariamente avere una licenza GPL. La maggior parte dei moduli sul sito Web di newLISP non ha licenza e non importa altre librerie. Se lo fanno, consultare le licenze di quelle librerie di terze parti.
newLISP ti permette di distribuire un binario dell'interprete insieme al tuo sorgente. Quando si utilizza newLISP nel software, menzionare sempre il sito Web www.newLISP.org nella documentazione come luogo in cui è disponibile il codice sorgente per newLISP.

20. Dove posso segnalare eventuali bug?
---------------------------------------
La maggior parte delle segnalazioni di bug risulta dalla mancata lettura della documentazione o dal ritenere che newLISP funzioni come Common Lisp o Scheme. Le domande, i commenti e le segnalazioni di bug sono pubblicati sul forum ufficiale, dove vengono letti da molti altri, dando loro l'opportunità di commentare o dare consigli. Il forum consente anche di inviare messaggi privati.

21. Posso compilare i miei script in programmi eseguibili?
----------------------------------------------------------
Si. Il comando: newLISP -x "myscript.lsp" "myscript.exe" genera un file eseguibile sul proprio sistema operativo.


============================================================================
 newLISP in 21 minuti (John W. Small)
============================================================================

newLISP: un tutorial interattivo
--------------------------------
Questo documento è stato riformattato per HTML con alcune correzioni e aggiornamenti fatti da Rick Hanson nel maggio 2006, cryptorick@gmail.com. Ulteriori aggiornamenti da LM gennaio 2008, dicembre 2011, novembre 2014, maggio 2018.
Traduzione in italiano, aggiornamenti e adattamenti fatti da cameyo 2019.

Copyright 2004, John W. Small, Tutti i diritti riservati

Puoi scaricare e installare newLISP dal sito web www.newLISP.org.

Si prega di inviare eventuali commenti o domande riguardanti questo tutorial a jsmall@atlaol.net.

Indice
------
Ciao Mondo!
Codice sorgente e dati sono intercambiabili
Argomenti di funzione
Effetti collaterali e contesti
Sequenze di espressioni
Eseguibili e librerie dinamiche (dll)
Binding (associazione/legame)
Lista come struttura ricorsiva
Funzioni
Funzioni di ordine superiore
Liste lambda
Ambito dinamico (Dynamic scope)
Lista degli argomenti di una funzione
Lambda-macro
Contesti
Ambito lessicale (Lexical scope)

Ciao Mondo!
-----------
Con newLISP installato sul tuo sistema, al prompt della riga di comando della shell (cmd in windows) inserisci newLISP per avviare la REPL (Read, Eval, Print, Loop).
Su Linux, la console sarebbe simile a questa:

$ newLISP
> _

E su piattaforme Windows, sarebbe simile a questa.

c:\> newLISP
> _

Dopo l'avvio, newLISP risponde con il simbolo del prompt.

> _

Nota del traduttore:
per utilizzare questo documento con notepad++ e la REPL di newLISP ho eliminato il simbolo del prompt ">" quando viene seguito da un'espressione (in questo modo è possibile eseguire l'espressione direttamente). Inoltre l'output della REPL viene preceduto dalla stringa "->".

Inserisci l'espressione qui sotto per stampare "Ciao Mondo!" sulla console.

(println "Ciao Mondo!")

newLISP stampa il valore dell'espressione immessa nel prompt della REPL prima di eseguire il ciclo e richiedere un nuovo input.

(println "Ciao Mondo!")
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

Perché è stato stampato due volte?

La funzione println stampa la prima riga, es. Ciao Mondo! nella console a causa effetto collaterale (side effect) della chiamata di funzione.
Inoltre la funzione println restituisce la stringa di valore "Ciao Mondo!", cioè il suo ultimo argomento, alla REPL che a sua volta stampa la seconda riga, cioè

"Ciao Mondo!"

La REPL valuta qualsiasi espressione e non solo le chiamate di funzione:

"Ciao Mondo!"
;-> "Ciao Mondo!"
> _

Se inserisci l'espressione stringa "Ciao Mondo!", come mostrato sopra, questa restituisce semplicemente se stessa come qualsiasi espressione letterale e come i numeri letterali.

1
;-> 1
> _

A questo punto potresti essere intimorito dalle parentesi. Se iniziate newLISP conoscendo un normale linguaggio informatico, sembrerebbe più naturale scrivere una chiamata di funzione nel modo seguente:

println ("Ciao Mondo!")

Dovrai solo credermi sulla parola - nel tempo preferirai di gran lunga:

(println "Ciao Mondo!")

a

println ("Ciao Mondo!")

per ragioni che non possono essere adeguatamente spiegate fino a quando non avrai visto molti più esempi di elaborazione di liste simboliche.

Codice sorgente e dati sono intercambiabili
-------------------------------------------
Lisp è l'acronimo di List Processor. Poiché le liste sono utilizzate per rappresentare sia il codice che i dati in Lisp, questi ultimi sono essenzialmente intercambiabili.
La precedente espressione println è in realtà una lista con due elementi:

(println "Ciao mondo!")

Il primo elemento è:

println

e l'ultimo elemento è:

"Ciao Mondo!"

Lisp interpreta sempre una lista come una chiamata di funzione, a meno che non venga "quotata", indicando così che dovrebbe essere presa come un'espressione simbolica, cioè come un dato.
Per "quotare" occorre inserire il carattere " ' " davanti all'espressione.

'(println "Ciao Mondo!")
;-> (println "Ciao Mondo!")
> _

Un'espressione simbolica può tuttavia essere valutata come codice sorgente con la funzione "eval".

(eval '(println "Ciao Mondo!"))
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

Un programma Lisp può modificare se stesso durante l'esecuzione (runtime) costruendo liste di dati ed eseguendoli come codice sorgente!

(eval '(eval '(println "Ciao Mondo!")))
;-> Ciao Mondo!
;-> "Ciao Mondo!"
> _

In realtà il carattere " ' " rappresenta la funzione quote (syntactical sugar).

(quote (println "Ciao Mondo!"))
;-> (println "Ciao Mondo!")
> _

Pensa alla funzione quote come una funzione che utilizza i suoi argomenti letteralmente, cioè come simboli.

'x
;-> x
(quote x)
;-> x
'(1 2 tre "quattro")
;-> (1 2 tre "quattro")
> _

I simboli, come x e tre sopra, e le liste simboliche svolgono un ruolo di vitale importanza nell'intelligenza artificiale (AI). Questo tutorial non riguarderà argomenti di AI. Tuttavia, una volta che avrai imparato a programmare in Lisp, sarai in grado di seguire tranquillamente gli esempi Lisp che si trovano nella maggior parte dei libri di testo su AI.
Considera il seguente esempio.

'Ciao
;-> Ciao
"Ciao"
;-> "Ciao"
> _

Il simbolo 'Ciao non è lo stesso della stringa "Ciao". Ora puoi capire perché la REPL stampa le virgolette per indicare una stringa, distinguendola quindi da un simbolo con le stesse lettere.

Argomenti di funzione
---------------------
La funzione println può avere un numero variabile di argomenti.

(println "Ciao " "Mondo!")
;-> Ciao Mondo!
;-> "Mondo!"
> _

Gli argomenti sono semplicemente concatenati attraverso il flusso di output mentre l'ultimo argomento viene restituito come valore della chiamata di funzione.
In genere, gli argomenti passati a una funzione vengono valutati da sinistra a destra e i valori risultanti vengono quindi passati alla funzione. Si dice che gli argomenti correnti di una funzione sono valutati in modo rigoroso. Questo è noto come valutazione applicata in base all'ordine (applicative-order evaluation).
Ma notate che, per la funzione quote, questo non è il caso:

(quote (println "Ciao Mondo!"))
;-> (println "Ciao Mondo!")
> _

Se il suo argomento, vale a dire:

(println "Ciao Mondo!")

fosse stato rigorosamente valutato, avremmo visto:

Ciao Mondo!

visualizzato sulla console.
La funzione di quote è una funzione atipica a volte definita "forma speciale".
Puoi scrivere le tue funzioni speciali con newLISP. Queste sono chiamate macro e i loro argomenti sono detti "chiamati per nome", cioè letteralmente.
Questo è noto come ordine di valutazione normale e diciamo che la strategia di valutazione è pigra (lazy). In altre parole, gli argomenti di una macro non vengono valutati fino a quando, e solo se, si specifica direttamente l'esecuzione della valutazione (come vedremo in seguito).
Quindi, l'argomento della funzione quote viene preso alla lettera e restituito. In un certo senso, quote è una funzione di identità con una strategia di valutazione pigra (lazy evaluation). Non si preoccupa mai di valutare i sui argomenti, invece la restituisce letteralmente nella sua forma simbolica di codice sorgente.
Senza forme speciali, i costrutti di controllo del flusso trovati in altri linguaggi non potrebbero essere implementati in una linguaggio con solo liste di espressioni come sintassi con cui lavorare. Ad esempio,  considera il seguente if:

(if true (println "Ciao") (println "Arrivederci"))
;-> Ciao
;-> "Ciao"
> _

La forma speciale if prende tre argomenti:

sintassi: (if condizione conseguenza alternativa)

condizione  => vero
conseguenza => (println "Ciao")
alternativa => (println "Arrivederci")

L'argomento della condizione viene sempre valutato (strict evaluation), ma le conseguenze e le espressioni alternative sono valutate in modo pigro (lazy). Inoltre l'espressione alternativa è facoltativa.
Si noti che if è un'espressione. Restituisce il valore della espressione conseguenza o dell'espressione alternativa a seconda che la condizione sia rispettivamente vera (true) o falsa. Nell'esempio sopra, sappiamo che l'espressione alternativa non è stata valutata, perché il suo effetto collaterale della stampa "Arrivederci" sulla console non si è mai verificato.
Il valore di un'espressione if con una condizione falsa che non ha alternative e vale semplicemente nil (nullo). Il valore nil (nullo) indica vuoto o falso a seconda dell'interpretazione richiesta.
Nota: nella maggior parte dei linguaggi di programmazione tradizionali if è un'istruzione, e quindi non ha un valore di ritorno.
Se il Lisp non avesse avuto una strategia di valutazione pigra (lazy), non sarebbe possibile implementare forme speciali o macro. Senza una strategia di valutazione pigra, sarebbe stato necessario aggiungere parole chiave e/o sintassi al linguaggio. Quale tipi di sintassi hai visto fino ad ora, oltre alla parentesi e alle virgolette? Risposta: non molto!
Il rovescio della valutazione pigra (lazy) è che ora possibile aggiungere il proprio controllo di flusso al linguaggio estendendo così la "sintassi" di Lisp che consente di incorporare mini-linguaggi specifici dell'applicazione. La scrittura di funzioni e di macro sarà trattata in una sezione successiva di questo tutorial.

Effetti collaterali e contesti
------------------------------
Senza effetti collaterali, avere un REPL sarebbe inutile. Per capire il perché, consideriamo la seguente sequenza di espressioni:

(set 'ciao "Ciao")
;-> "Ciao"
(set 'mondo " Mondo")
;-> " Mondo"
(println ciao mondo)
;-> Ciao Mondo
;-> "Mondo"
> _

La funzione set sopra ha un effetto collaterale, come dimostrato di seguito:

ciao
;-> "Ciao"
mondo
;-> " Mondo"
> _

I simboli 'ciao e 'mondo sono legati nel contesto corrente a "Ciao" e "Mondo" rispettivamente.
Tutte le funzioni integrate (built-in) sono associate a simboli del contesto MAIN.

println
println@<409040>
set
set@<4080D0>
> _

Questo ci dice che println è associato a una funzione chiamata println con un punto di ingresso di 409040 (Versioni (build) diverse di newLISP avranno ovviamente punti di ingresso diversi per println).
Il contesto predefinito è MAIN. Un contesto è essenzialmente uno spazio dei nomi di stato. Impareremo in seguito i contesti definiti dall'utente.
Si noti che il simbolo letterale 'ciao valuta se stesso:

'ciao
;-> ciao
> _

La valutazione del simbolo 'ciao restituisce il valore a cui è associato nel contesto corrente:

(eval 'ciao)
;-> "Ciao"
> _

Se il simbolo non è associato quando viene valutato, restituisce semplicemente nil:

(eval 'z)
;-> nil
> _

In realtà non abbiamo bisogno di eval, dal momento che il simbolo senza la funzione quote viene automaticamente valutato nel contesto attuale:

ciao
;-> "Ciao"
z
;-> nil
> _

Quindi il valore di ciao e di mondo sono "Ciao" e "Mondo" rispettivamente:

(println ciao mondo)
;-> Ciao Mondo
;-> "Mondo"
> _

Cosa verrebbe visualizzato se inseriamo quanto segue?

(println 'ciao 'mondo)
?

Pensaci per un momento.

La funzione println visualizza i simboli uno immediatamente dopo l'altro sulla prima riga:

(println 'ciao 'mondo)
;-> ciaomondo
;-> mondo
> _

Sequenze di espressioni
-----------------------
Una sequenza di espressioni può essere combinata in un'espressione composta con la funzione begin:

(begin "Ciao" " Mondo!")
;-> " Mondo!"
> _

Cosa è successo a "Ciao"? Poiché un'espressione composta restituisce un singolo valore, restituisce il valore della sua ultima espressione. Ma le espressioni sono infatti valutate in sequenza. È solo che l'espressione "Ciao" non ha alcun effetto collaterale, quindi il suo valore di ritorno viene scartato e non si vede mai alcuna prova della sua valutazione:

(begin (print "Ciao") (println " Mondo!"))
;-> Ciao Mondo!
;-> " Mondo!"
> _

Questa volta, gli effetti collaterali di print e println sono evidenziati nella finestra della console e l'ultimo valore restituito viene visualizzato dal REPL.
La funzione begin è utile per combinare espressioni in una singola espressione. Ricordiamo la forma speciale if:

(if true
  (begin
    (print "Ciao" )
    (println " newLISP!"))
  (println "Java/Python/Ruby!"))

;-> Ciao newLISP!
;-> "newLISP!"
> _

Le istruzioni multilinea e le funzioni devono essere immesse premendo il tasto [invio] al prompt. Per uscire dalla modalità multilinea, premere di nuovo il tasto [invio] al prompt.
Ricorda che l'espressione if accetta solo tre argomenti:

sintassi: (if condizione conseguenza alternativa)

L'espressione (begin ...) viene utilizzata per combinare due espressioni in un'unica espressione, che viene quindi considerata come argomento conseguenza.
Terminiamo questa sezione vedendo come trasformare il nostro esempio in un programma eseguibile (exe).
Si noti che è possibile uscire dalla REPL in qualsiasi momento con la funzione (exit):

> (exit)
$ (linux) oppure c:\> (windows)

Puoi anche uscire con un argomento intero opzionale:

> (exit 3)

Questo può essere utile nell'elaborazione di shell o file batch creando punti di uscita con valori diversi in base agli errori avvenuti.
Ora possiamo mettere la nostra sequenza di espressioni in un file sorgente:

 ;Questo è un commento
 ;hw.lsp
 (println "Ciao mondo!")
 (exit)

E possiamo eseguirlo dalla riga di comando, in questo modo:

$ newLISP hw.lsp
Ciao mondo!

O in Windows:

c: \> newLISP hw.lsp
Ciao mondo!

Eseguibili e librerie dinamiche (dll)
-------------------------------------
Creare eseguibili nativi della piattaforma (exe in windows) e collegarsi alle librerie di collegamenti dinamici (dll in windows e so in linux) con newLISP è semplice.
Nelle vecchie versioni, dovresti trovare il file link.lsp nella sottodirectory degli esempi oppure dovresti scaricare gli esempi e i moduli separatamente da www.newLISP.org.
Con la versione 10.4.7 il processo di collegamento dei file sorgente LISP con un nuovo eseguibile LISP è cambiato e il file link.lsp non è più necessario.
Il processo è ora disponibile utilizzando l'opzione della riga di comando -x.
Consideriamo il seguente programma:

;; uppercase.lsp - Link example
(println (upper-case (main-args 1)))
(exit)

Il programma uppercase.lsp prende il primo argomento e lo converte in maiuscolo:
Le operazioni per creare un file eseguibilie sono le seguenti:

# in OSX, Linux e altri UNIX
newLISP -x "uppercase.lsp" "uppercase"

# impostiamo i permessi di esecuzione
chmod 755 uppercase

# in Windows il file eseguibile deve avere estensione .exe
newLISP -x "uppercase.lsp" "uppercase.exe"

In questo modo vengono messi insieme newLISP.exe e uppercase.lsp per creare il file eseguibile uppercase.exe. Per eseguire il programma occorre scrivere dal prompt dei comandi:

uppercase "testo da convertire"

L'output della console sarà:

TESTO DA CONVERTIRE

Nota: i file di inizializzazione (init.lsp o .init.lsp) non vengono caricati prima dell'esecuzione del programma.

Anche il collegamento a una libreria di collegamento dinamico è semplice. Sulle piattaforme Windows, le seguenti espressioni visualizzeranno una finestra di dialogo:

(import "user32.dll" "MessageBoxA")
(MessageBoxA 0 "Ciao mondo!" "newLISP Scripting Demo" 0)

Si noti che MessageBoxA è l'interfaccia di una funzione C nella libreria utente del sistema win32.
L'esempio seguente mostra come chiamare una funzione echo esterna scritta in C e compilata con Visual C ++:

// echo.c

#include <STDIO.H>
#define DLLEXPORT _declspec (dllexport)

DLLEXPORT void echo (const char * msg)
{
  printf (msg);
}

Dopo aver compilato il file echo.c in una DLL, può essere importata con il seguente codice:

(import "echo.dll" "echo")

(echo "Hello newLISP scripting World!")

La facilità con cui newLISP può collegarsi alle DLL è una caratteristica che lo rende un linguaggio di scripting ideale.
Assicurati di studiare gli altri esempi e i moduli che mostrano come programmare con i socket, connettersi ai database, ecc.

Binding (associazione/legame)
-----------------------------
Come mostrato in precedenza, la funzione set viene utilizzata per associare un valore a un simbolo:

(set 'y 'x)
;-> x
> _

In questo caso il valore 'x, un simbolo, è stato associato alla variabile denominata y .
Ora considera il seguente legame:

(set y 1)
;-> 1
> _

Dato che y non è quotato, esso viene valutato come 'x e di conseguenza 1 è legato alla variabile di nome x.

y
;-> x
x
;-> 1
> _

E ovviamente y rimane legato a 'x come mostrato sopra.

La funzione setq ti evita di dover scrivere quote ogni volta.

(setq y 1)
;-> 1
> _

Ora la variabile chiamata y è stata associata al valore 1.

y
;-> 1
> _

La funzione define funziona allo stesso modo:

(define y 2)
;-> 2
y
;-> 2
> _

Si noti che sia set che setq possono associare più variabili alla volta.

(set 'x 1 'y 2)
;-> 2
(setq x 3 y 4)
;-> 4
x
;-> 3
y
;-> 4
> _

(Dovresti verificare questi esempi mentre procediamo in modo che rimangano nella tua memoria.)
A differenza di setq, la funzione define può associare solo un'associazione alla volta. Tuttavia ci sono altri usi per define che saranno discussi a breve.
Ovviamente le funzioni set, setq e define hanno effetti collaterali oltre a restituire un valore. L'effetto collaterale è che l'associazione che lega la variabile ad un valore viene memorizzata nella tabella corrente dei simboli (implicita).
Possiamo visualizzare questa tabella di simboli implicita come una lista di associazioni:

'((x 1) (y 2))
;-> ((x 1) (y 2))
> _

L'elenco di associazioni sopra riportato è una lista di liste. Le liste annidate hanno due elementi ciascuna, vale a dire una coppia chiave-valore. Il primo elemento rappresenta il nome dell'associazione mentre l'ultimo elemento rappresenta il suo valore.

(first '(x 1))
;-> x
(last '(x 1))
;-> 1
> _

Il primo elemento di una lista di associazioni è naturalmente un'associazione:

(first '((x 1) (y 2)))
;-> (x 1)
> _

Le funzioni incorporate assoc e lookup sono fornite per facilitare il lavoro con gli elenchi di associazioni:

(assoc 'x' ((x 1) (y 2) (x 3)))
;-> (x 1)
(lookup 'x' ((x 1) (y 2) (x 3)))
;-> 1
> _

(La funzione lookup ha anche altri usi che puoi trovare nella documentazione di newLISP)
Nota che sia assoc e lookup restituiscono il legame e il valore rispettivamente della prima associazione che ha come chiave 'x. Questo punto sarà importante in seguito, man mano che si svilupperà la discussione sulle tabelle dei simboli e sui contesti di visibilità delle variabili (scope).

Lista come struttura ricorsiva
------------------------------
Qualsiasi lista che includa una lista di associazioni può essere vista come una struttura dati ricorsiva, probabilmente annidata. Una lista, per definizione, ha un primo elemento, una coda e un ultimo elemento:

(first '(1 2 3))
;-> 1
(rest '(1 2 3))
;-> (2 3)
(last '(1 2 3))
;-> 3

Ma considera quanto segue:

(rest '(1))
;-> ()
(rest '())
;-> ()
(first '())
;-> ERR: list is empty in function first : '()
(last '())
;-> ERR: list is empty in function last : '()

Il rest di una lista vuota o di un elenco con un solo elemento è di nuovo la lista vuota. Cercare di estrarre il primo o l'ultimo elemento da una lista vuota genera un errore. Si noti che (diversamente dal LISP) nil non rappresenta mai una lista vuota! Solo gli elementi inesistenti sono rappresentati con il valore nil!

(Si noti che la definizione di lista di newLISP è diversa da quella definita nel LISP e in Scheme)

Una lista può essere processata con un algoritmo ricorsivo.

Ad esempio, un algoritmo ricorsivo per calcolare la lunghezza di una lista generico potrebbe essere definito come segue:

(define (list-length a-list)
   (if a-list
   (+ 1 (list-length (rest a-list)))
   (0)))

Prima di tutto, si noti che define può essere utilizzata non solo per definire variabili, ma anche funzioni. Il nome della nostra funzione è list-length e richiede un argomento e precisamente una lista (a-list). Tutti gli altri argomenti di define costituiscono il corpo della funzione.
I nomi dei simboli (a differenza dei linguaggi principali) possono utilizzare tutti (quasi) i caratteri, permettendo uno stile di denominazione estrememente ampio. Assicurati di consultare la documentazione di newLISP per vedere le regole complete per la denominazione dei simboli!
La condizione if interpreta qualsiasi valore che non sia nil o la lista vuota (),  come true (vero). Così abbiamo potuto semplicemente fare il test sulla lista a-list ottenendo lo stesso risultato:

 (if a-list
     ...

Fintanto che una lista contiene il primo elemento (first) rimanente, il conteggio continua aggiungendo 1 al risultato della chiamata list-length sul resto (rest) della lista. Quando il primo elemento di una lista vuota è nil, viene restituito il valore alternativo zero che permette anche di uscire dalle chiamate ricorsive dell'algoritmo annidate nello stack (pila).
Diciamo che una lista è una struttura dati ricorsiva perché la sua definizione è ricorsiva e non semplicemente perché è suscettibile di algoritmi di elaborazione ricorsivi.
Una definizione ricorsiva di una lista potrebbe eseere qualcosa di simile:

 type list :: = empty-list |  first * list

Una lista è o la lista vuota o una lista con un primo elemento e una coda che è di per sé una lista.
Poiché il calcolo della lunghezza di una lista è abbastanza comune, esiste una funzione di libreria predefinita chiamata length che fa il lavoro per noi:

 (list-length '(1 2 5))
 ;-> 3
 (length '(1 2 5))
 ;-> 3
 > _

Torneremo alla nostra discussione sulle funzioni definite dall'utente più avanti.
Il concetto di una tabella di simboli implicita può essere visto come una successione di valutazioni delle espressioni:

 (set 'x 1)
 ;-> 1
 (+ x 1)
 ;-> 2
 > _

Quindi gli effetti collaterali tipicamente influenzano il flusso di output o questo contesto implicito. Una lista di associazioni è solo un modo per visualizzare concettualmente questa tabella di simboli implicita.

Supponiamo di voler ora cambiare momentaneamente il legame di una variabile senza sovrascriverlo in modo permanente.

 (set 'x 1' y 2)
 ;-> 2
 (let ((x 3) (y 4))
    (println x)
    (list x y))
 ;-> 3
 ;-> (3 4)
 x
 ;-> 1
 y
 ;-> 2
 > _

Si noti che x e y sono legati rispettivamente a 1 e 2 nella tabella dei simboli impliciti. L'espressione let associa momentaneamente (dinamicamente) x e y a 3 e 4 per la durata dell'espressione let. In altre parole, il primo argomento di let è un elenco di associazioni e gli argomenti rimanenti vengono eseguiti in sequenza.

La funzione list prende un numero variabile di argomenti che vengono valutati rigorosamente restituendo ogni valore risultante in una lista.

La forma let è simile alla forma iniziale mostrata in precedenza, tranne che estende dinamicamente la tabella dei simboli implicita per la durata del "blocco let" che include tutti gli argomenti dell'espressione let . Questo è possibile perché questi argomenti vengono pigramente valutati all'interno del contesto esteso del "blocco let". Se visualizzassimo la tabella dei simboli implicita all'interno del blocco let, avremmo la seguente lista di associazioni estesa:

 '((y 4) (x 3) (y 2) (x 1))

Poiché la ricerca inizia da sinistra, i valori di associazione di x e y vengono restituiti, in modo da nascondere i loro valori originali al di fuori dell'espressione let.
Quando l'espressione let termina, la tabella dei simboli si presenta come segue:

 '((y 2) (x 1))

E di conseguenza x e y assumono i valori originali (cioè quelli che avevano prima dell'esecuzione dell'espressione let).

Per capire meglio, confronta quanto segue:

 (begin (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> 4
 (list (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> (2 3 4)
 (quote (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> (+ 1 1)
 (quote (2 3 4))
 ;-> (2 3 4)
 (let () (+ 1 1) (+ 1 2) (+ 1 3))
 ;-> 4

Nota che la funzione quote prende solo un argomento (impareremo in seguito come tale funzione è in grado di ignorare ulteriori argomenti estranei). L'espressione let senza nessuna associazione dinamica (cioè senza la dichiarazione di nuove variabili) si comporta come se fosse la funzione begin.

Ora determina che cosa restituiscono le seguenti espressioni (le risposte sono di seguito).

 (setq x 3 y 4)
 (let ((x 1) (y 2)) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

 (setq x 3 y 4)
 (begin (set 'x 1 'y 2) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Risposte:

 (setq x 3 y 4)
 (let ((x 1) (y 2)) x y)
 ;-> 2
 x
 ;-> 3
 y
 ;-> 4

 (setq x 3 y 4)
 (begin (set 'x 1 'y 2) x y)
 ;-> 2
 x
 ;-> 1
 y
 ;-> 2

Adesso proviamo qualcosa di un pò più difficile.

 (setq x 3 y 4)
 (let ((y 2)) (setq x 5 y 6) x y)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Risposte:

 (setq x 3 y 4)
 (let ((y 2)) (setq x 5 y 6) x y)
 ;-> 6
 x
 ;-> 5
 y
 ;-> 4

Per capire perché la risposta sopra è corretta, considera quanto segue.

 '((y 2) (y 4) (x 3))

La lista di associazioni sopra riportata rappresenta la tabella dei simboli quando si entra nel corpo dell'espressione let subito dopo il l'associazione (dinamica) di y .

Dopo:

 (setq x 5 y 6)

la tabella dei simboli estesa diventa la sequente:

 '((y 6) (y 4) (x 5))

E al ritorno dall'espressione let viene modificata in questo modo:

 '((y 4) (x 5))

Quindi set, setq e define associano il simbolo se viene trovato nella tabella dei simboli oppure inseriscono la nuova associazione all'inizio (sulla parte anteriore) della lista di associazioni. Torneremo sulla visibilità delle variabili (scoping) dopo aver esplorato ulteriormente le funzioni.

Funzioni
--------
L'utente può definire nuove funzioni (come discusso in precedenza). La seguente funzione f restituisce la somma dei suoi due argomenti:

 (define (f x y) (+ x y))

Questa è in realtà una scorciatoia per qualsiasi delle seguenti definizioni:

 (define f (lambda (x y) (+ x y)))

 (setq f (lambda (x y) (+ x y)))

 (set 'f (lambda (x y) (+ x y)))

L'espressione "lambda" definisce una funzione anonima, cioè una funzione senza nome. Il primo argomento dell'espressione lambda è la sua lista di argomenti formali e le restanti espressioni costituiscono una sequenza (ritardata) di espressioni che costituiscono il corpo della funzione (questa sequenza di espressioni viene detta "ritardata" perchè viene valutata solamente quando chiamiamo la funzione).

 (f 1 2)
 ;-> 3
 ((lambda (x y) (+ x y)) 1 2)
 ;-> 3
 > _

Ricorda che una lista non quotata viene interpretata come una chiamata di funzione in cui tutti gli argomenti sono valutati rigorosamente. Il primo elemento della lista sopra è un'espressione lambda, quindi viene valutata restituendo una funzione anonima che viene poi applicata agli argomenti 1 e 2.

Si noti che le seguenti due espressioni sono essenzialmente le stesse:

 (let ((x 1) (y 2)) (+ x y))
 ;-> 3
 ((lambda (x y) (+ x y)) 1 2)
 ;-> 3
 > _

L'unica vera differenza è che la sequenza di espressioni nell'espressione lambda viene ritardata fino a quando non viene applicata agli argomenti. Applicare l'espressione lambda agli argomenti in effetti crea un'associazione tra gli argomenti formali e gli argomenti effettivi a cui viene applicata la funzione.

Quali sono i valori nelle seguenti espressioni?

 (setq x 3 y 4)
 ((lambda (y) (setq x 5 y 6) (+ x y)) 1 2)
 ;-> ?
 x
 ;-> ?
 y
 ;-> ?

Ricorda che le espressioni lambda e let sono essenzialmente le stesse.

 (setq x 3 y 4)
 ((lambda (y) (setq x 5 y 6) (+ x y)) 1 2)
 ;-> 11
 x
 ;-> 5
 y
 ;-> 4

Gli argomenti 1 e 2 sono superflui. L'argomento formale y nasconde la y definita al di fuori dell'espressione lambda in modo che l'impostazione di x al valore 5 sia l'unica che ha effetto dopo l'esecuzione (il ritorno) della funzione lambda.

Funzioni di primo ordine
------------------------
Le funzioni in Lisp sono valori di prima classe (ordine). Come i dati, possono essere create in fase di esecuzione e passate come qualsiasi altro valore di dati per effettuare una programmazione funzionale di ordine superiore. Si noti che i puntatori di funzione che troviamo nel linguaggio in C (e anche gli event-listener in Java/Csharp), ad esempio, non sono funzioni di prima classe. Sebbene possano essere trasmessi come dati, non possono mai essere creati in fase di esecuzione (come i dati).

Forse la funzione di ordine superiore più comunemente utilizzata è la funzione map (talvolta chiamata collect in linguaggi object oriented che hanno trasferito l'idea dal Lisp tramite Smalltalk).

 (map eval '((+ 1) (+ 1 2 3) 11))
 ;-> (1 6 11)
 > _

La funzione map applica la funzione eval a ciascun elemento della lista data. Si noti che la funzione + accetta un numero variabile di argomenti.

In questo caso avremmo potuto semplicemente scrivere quanto segue:

 (lista (+ 1) (+ 1 2 3) 11)
 ;-> (1 6 11)
 > _

Ma la funzione map può anche eseguire operazioni più interessanti.

 (map string? '(1 "Hello" 2 "World!")))
 ;-> (nil true true true)
 > _

La funzione map può processare più di una lista come argomento.

 (map + '(1 2 3 4)' (4 5 6 7) '(8 9 10 11))
 ;-> (13 16 19 22)
 > _

Alla prima iterazione + viene applicato il primo elemento di ciascuna lista.

 (+ 1 4 8)
 ;-> 13
 > _

Supponiamo di voler rilevare quali elementi di una lista sono pari:

 (map (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 (nil true true true)
 > _

"fn" è una scorciatoia per "lambda":

 (fn (x) (= 0 (% x 2)))) (lambda (x) (= 0 (% x 2))))
 > _

L'operatore rimanente % viene utilizzato per determinare se un numero è divisibile per 2 (senza resto).

La funzione filter è un'altra funzione di ordine superiore comunemente utilizzata (talvolta chiamata select nelle librerie dei linguaggi Object-Oriented):

 (filter (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 ;-> (2 4)
 > _

La funzione index può essere utilizzata invece per identificare gli indici degli elementi nell'elenco originale.

 (index (fn (x) (= 0 (% x 2))) '(1 2 3 4))
 ;-> (1 3)
 > _

La funzione apply è un'altra funzione di ordine superiore.

 (apply + '(1 2 3))
 ;-> 6
 > _

Perché non scrivere semplicemente (+ 1 2 3) ?

A volte potresti non sapere in anticipo quale funzione verrà applicata.

 (setq op +)
 ;-> + <40727D>
 (applica op '(1 2 3))
 ;-> 6
 > _

Questo approccio potrebbe essere utilizzato, per esempio, per implementare un dispatcher  dinamico.

Liste lambda
------------
Considera la seguente funzione:

 (define (f x y) (+ x y z))
 ;-> (lambda (x y) (+ x y z))
 f
 ;-> (lambda (x y) (+ x y z))
 > _

La funzione è un tipo speciale di lista noto come "lista lambda".

 (first f)
 ;-> (x y)
 (last f)
 ;-> (+ x y z)
 > _

Quindi una funzione "compilata" può essere esaminata (introspezione) in fase di esecuzione. In effetti può anche essere modificata in fase di esecuzione!

 (setf (n 1 f) '(+ x y z 1))
 (lambda (x y) (+ x y z 1))
 > _

(Assicurati di controllare la funzione nth-set nella documentazione di newLISP)

La funzione expand è utile in generale per modificare le liste, comprese le liste lambda.

 (let ((z 2)) (expand f 'z))
 ;-> (lambda (x y) (+ x y 2 1))
 > _

La funzione expand prende una lista di argomenti e sostituisce i simboli al suo interno con i valori simbolici di tutti gli argomenti rimanenti.

Ambito dinamico (Dynamic scope)
-------------------------------
Considera la seguente definizione di funzione:

 (define f
  (let ((x 1) (y 2))
    (lambda (z) (lista x y z))))

 ;-> (lambda (z) (lista x y z))
 > _

Da notare che il valore di f è solo lambda:

 f
 ;-> (lambda (z) (lista x y z))
 (setq x 3 y 4 z 5)
 ;-> 5
 (f 1)
 ;-> (3 4 1)
 (let ((x 5) (y 6) (z 7)) (f 1))
 ;-> (5 6 1)

Anche se l'espressione lambda è definita all'interno dell'ambito lessicale della espressione let che associa x a 1 e y a 2, al momento della sua chiamata è l'ambito dinamico che conta. Diciamo che l'associazione delle espressioni lambda in newLISP è dinamico (rispetto all'associazione lessicale del Common Lisp e di Scheme).

Qualsiasi variabile libera di un'espressione lambda viene associata dinamicamente nel momento in cui viene valutato il corpo delle espressioni. Le variabili non specificate (non associate) nella lista degli argomenti formali sono chiamate libere (free).

Possiamo usare la funzione di expand mostrata in precedenza per "chiudere" un'espressione lambda, cioè per associare tutte le variabili libere:

 (define f
  (let ((x 1) (y 2))
    (expand (lambda (z) (lista x y z)) 'x 'y)))

 ;-> (lambda (z) (lista 1 2 z))
 > _

Si noti che l'espressione lambda non ha variabili libere ora.

Tuttavia, "chiudere" l'espressione lambda con la funzione expand non è la stessa cosa della chiusura lessicale lambda che si trova in CL (Common Lisp) e Scheme. Le chiusure lessicali esistono in newLISP e saranno discusse in una sezione successiva basata sui contesti.

Lista degli argomenti di una funzione
-------------------------------------
Una funzione in newLISP può avere un numero qualsiasi di argomenti (entro limiti ragionevoli):

 (define (f z , x y)
  (setq x 1 y 2)
  (list x y z))

 ;-> (lambda (z , x y) (setq x 1 y 2) (list x y z))
 > _

I quattro argomenti formali di f sono:

 z , x y

Si noti che la virgola è il nome di un argomento (vedere le regole di denominazione dei simboli). Qui viene usato come espediente visivo.

L'unico argomento intenzionale è z .

Se il numero di argomenti formali supera il numero di argomenti effettivi a cui viene applicata la funzione, gli argomenti formali rimanenti vengono semplicemente inizializzati a nil.

 (f 3)
 ;-> (1 2 3)
 > _

In questo caso:
 , x y

sono tutti e tre inizializzati a nil. Poiché x e y appaiono come argomenti formali, agiscono come variabili locali, quindi:

 (setq x 1 y 2)

non sovrascrive il legame di x e y al di fuori dell'ambito dell'espressione lambda.

Avremmo potuto scrivere quanto segue per ottenere lo stesso effetto delle variabili locali:

 (define (f z)
  (let ((x 1) (y 2))
    (list x y z)))

;->  (lambda (z)
;->   (let ((x 1) (y 2))
;->     (list x y z)))
 > _

La virgola e gli argomenti formali inutilizzati sono un idioma utilizzato spesso in newLISP per fornire variabili locali.

Una funzione può anche essere chiamata con più argomenti di quelli che sono specificati nella sua lista di argomenti formali. In questo caso gli argomenti in eccesso vengono semplicemente ignorati.

Gli argomenti formali in eccedenza possono quindi essere trattati come argomenti opzionali:

 (define (f z x y)
  (if (not x) (setq x 1))
  (if (not y) (setq y 2))
  (lista x y z))

Ora se f viene chiamata con un solo argomento, x e y sono associati rispettivamente con i valori 1 e 2.

Lambda-macro
------------
Gli argomenti effettivi di una funzione lambda-macro non vengono valutati rigorosamente (come nel caso di una funzione lambda):

 (define-macro (my-setq _key _value)
  (set _key (eval _value)))

Poiché _key non viene valutato, si trova in forma simbolica (cioè, è come se fosse quotato). Anche _value è in forma simbolica, quindi deve essere ancora valutato:

 (my-setq key 1)
 ;-> 1
 key
 ;-> 1
 > _

Il carattere underscore "_" viene utilizzato per impedire la "cattura" delle variabili.
Considera quanto segue:

 (my-setq _key 1)
 ;-> 1
 _key
 ;-> nil
 > _

Che cosa è successo?

L'espressione:

 (set _key 1)

imposta semplicemente la variabile locale _key . Diciamo che la variabile _key è stata catturata dalla "espansione" della macro. Scheme ha macro "igieniche" (hygenic) che sono "pulite" (clean) nel senso che garantiscono la protezione delle variabili (cioè impediscono la cattura delle variabili). Normalmente, utilizzare il carattere underscore "_" nei nomi degli argomenti formali della macro è sufficiente per impedire la cattura delle variabili.
La funzione define-macro è una scorciatoia per associare un'espressione lambda-macro in un unico passaggio.

 (define my-setq
  (lambda-macro (_key _value)
  (set _key (eval _value))))

La definizione sopra è equivalente alla precedente definizione di my-setq.

Oltre alla valutazione lazy, le lambda-macro permettono anche di fornire un numero variabile di argomenti:

 (define-macro (my-setq)
  (eval (cons 'setq (args))))

La funzione cons unisce una lista con un nuovo primo elemento (inserisce un elemento al primo posto di una lista):

 (cons 1 '(2 3))
 ;-> (1 2 3)
 > _

La definizione di my-setq è ora un'implementazione più completa che consente di associare/utilizzare un numero variabile di argomenti:

 (my-setq x 10 y 11)
 ;-> 11
 x
 ;-> 10
 y
 ;-> 11
 > _

La chiamata alla funzione (args) restituisce l'elenco di tutti gli argomenti alla lambda-macro, cioè quelli non valutati.

Quindi la macro my-setq prima costruisce l'espressione simbolica mostrata sotto:

 '(setq x 10 y 11)

Poi questa espressione viene valutata.

Tuttavia, lo scopo principale delle macro è estendere la sintassi del linguaggio.

Supponiamo di voler introdurre il controllo del flusso repeat...until come estensione della sintassi del linguaggio.

 (repeat-until condition body ...)

La seguente macro permette proprio questo:

 (define-macro (repeat-until _condition)
  (let ((body (cons 'begin (rest (args)))))
  (eval (expand (cons 'begin
    (list body
      '(while (not _condition) body))) 'body '_condition))))

Usando il nostro repeat-until possiamo scrivere:

 (setq i 0)
 (repeat-until (> i 5)
  (println i)
  (inc i))
  ;  => 0 1 2 3 4 5

Le macro possono diventare complesse abbastanza rapidamente. Un trucco per convalidarle è sostituire eval con list o println per verificare l'aspetto dell'espansione appena prima di essere valutata:

 (define-macro (repeat-until _condition )
  (let ((body (cons 'begin (rest (args)))))
    (list (expand (cons 'begin
      (list body
        '(while _condition body))) 'body '_condition))))

Ora possiamo controllare l'aspetto dell'espansione.

 (repeat-until (> i 5)
 (println i) (inc i))

 ((begin
    (begin
      (println i)
      (inc i))
    (while (> i 5)
      (begin (println i) (inc i)))))
 > _

Contesti
--------
All'avvio il contesto predefinito è MAIN .

 (context)
 ;-> MAIN

Un contesto è uno spazio di nomi:

 (setq x 1)
 ;-> 1
 x
 ;-> 1
 MAIN:x
 ;-> 1
 > _

Una variabile di contesto può essere utilizzata per qualificare completamente un nome di variabile. MAIN:x si riferisce alla variabile x nel contesto MAIN.

Per creare un nuovo spazio di nomi usa la funzione "context":

 (context 'FOO)
 ;-> FOO
 FOO> _

L'istruzione sopra crea lo spazio di nomi (namespace) FOO, se non esiste già e passa ad esso. Il prompt indica lo spazio di nomi corrente soltanto se è diverso da MAIN.

Usa il predicato "context?" per determinare se una variabile è associata ad un contesto:

 FOO> (context? FOO)
 ;-> true
 FOO> (context? MAIN)
 ;-> true
 FOO> (context? Z)
 ;-> nil
 FOO> _

Le funzioni set, setq e define creano le associazioni nel contesto corrente (cioè nello spazio di nomi):

 FOO> (setq x 2)
 ;-> 2
 FOO> x
 ;-> 2
 FOO> FOO:x
 ;-> 2
 FOO> MAIN:x
 ;-> 1
 FOO> _

Per specificare una variabile, ad esempio FOO:x, non è richiesto un nome completo quando è associata al contesto corrente.

Per tornare al contesto MAIN (o a qualsiasi altro) utilizzare la variabile MAIN o il simbolo 'MAIN:

 FOO> (context MAIN)
 ;-> MAIN
 > _

 Oppure

 FOO> (context 'MAIN)
 ;-> MAIN
 > _

La funzione quote deve essere utilizzata solamente quando si creano nuovi contesti.

I contesti non possono essere nidificati: risiedono tutti allo stesso.

Si noti nell'esempio seguente che il nome y, che è definito in MAIN, non è noto nel contesto FOO:

 (setq y 3)
 ;-> 3
 (context FOO)
 ;-> FOO
 FOO> y
 ;-> nil
 FOO> MAIN:y
 ;-> 3
 FOO> _

Il prossimo esempio mostra che MAIN non è speciale in alcun modo: è soltanto il contesto predefinito. MAIN non conosce z, ad esempio:

 FOO> (setq z 4)
 ;-> 4
 FOO> (context MAIN)
 ;-> MAIN
 z
 ;-> nil
 FOO:z
 ;-> 4

Tutti i nomi delle funzione predefinite si trovano in una sezione globale speciale del contesto MAIN:

 println
 ;-> println <40AC99>
 (context FOO)
 FOO
 FOO> println
 ;-> println <40AC99>
 FOO>

La funzione built-in di println è nota in entrambi i contesti MAIN e FOO.
La funzione println è stata "esportata" nello stato globale.

La sequenza di espressioni qui sotto mostra che MAIN:t non è conosciuto inizialmente nei contesti FOO o BAR finché non è stato elevato allo stato globale:

 FOO> (context MAIN)
 ;-> MAIN
 (setq t 5)
 ;-> 5
 (context 'BAR)
 ;-> BAR
 BAR> t ;questa istruzione genera il simbolo t nel contesto BAR
 ;-> nil
 BAR> (context FOO)
 ;-> FOO
 FOO> t ;questa istruzione genera il simbolo t nel contesto BAR
 ;-> nil
 FOO> (context MAIN)
 ;-> MAIN

Eleviamo t allo stato globale (che si trova nel contesto MAIN):

 (global 't)
 ;-> t
 (context FOO)
 ;-> FOO
 FOO> t
 ;-> 5 ;purtroppo si ottiene nil perchè t è già stato creato in FOO
 FOO> (context BAR)
 ;-> BAR
 BAR> t
 ;-> 5 ;purtroppo si ottiene nil perchè t è già stato creato in BAR

Solo i nomi definiti nel contesto MAIN possono essere elevati allo stato globale.

Nota del traduttore
Le seguenti istruzioni funzionano correttamente con lo stato globale:
; partiamo dal contesto MAIN
(context MAIN)
; definiamo il contesto A1
(context 'A1)
;-> A1
; ritorniamo al contesto MAIN
(context MAIN)
;-> MAIN
; definiamo il contesto A1
(context 'A2)
;-> A2
; ritorniamo al contesto MAIN
(context MAIN)
;-> MAIN
; definiamo una variabile
(setq a 2)
;-> 2
; eleviamo la variabile allo stato globale
(global 'a)
;-> a
(context 'A1)
;-> A1
a
;-> 2
(context 'A2)
;-> A2
a
;-> 2
(context MAIN)
;-> MAIN

; Continuiamo l'esempio per vedere cosa accade:
(context 'A3)
;-> A3
(symbols)
;-> () ; la lista dei simboli del contesto A3 è vuota
; Quando si esegue una istruzione, i simboli dell'istruzione vengono associati a quelli esistenti (nel contesto corrente e nello stato globale) oppure, se non esistono, vengono creati nel contesto corrente.
a ; questa istruzione crea il simbolo a nel contesto corrente
;-> nil
(symbols)
;-> (a) ; come volevasi dimostrare.

Ambito lessicale
----------------
Le funzioni set, setq e define associano i nomi nel contesto corrente:

 (context 'F)
 ;-> F
 F> (setq x 1 y 2)
 ;-> 2
 ; elenco dei simboli definiti nel contesto corrente
 F> (symbols)
 ;-> (x y)
 F> _

Si noti che la funzione symbols restituisce i nomi dei simboli associati al contesto corrente.

 F> (define (id z) z)
 ;-> (lambda (z) z)
 F> (symbols)
 ;-> (id x y z)
 F> _

L'ambito lessicale del contesto corrente continua fino al prossimo cambio di contesto. Poiché è possibile in seguito tornare a un particolare contesto, è possibile aumentare il suo ambito lessicale e potrebbe apparire frammentato nel file sorgente.

 F> (context 'B)
 ;-> B
 B> (setq a 1 b 2)
 ;-> 2
 B> _

Per ambito lessicale, intendiamo l'ambito definito dal codice sorgente. I nomi x ed y sono definiti nell'ambito lessicale del contesto F mentre i nomi a e b sono definiti nell'ambito lessicale del contesto B.

Tutte le espressioni lambda sono associate all'ambito lessicale del contesto in cui sono definite. Di conseguenza le espressioni lambda sono in definitiva "chiuse" dal contesto.

L'espressione lambda sottostante si trova nell'ambito lessicale di MAIN e anche nell'ambito lessicale dell'espressione (let ((x 3)) ...).

 (context MAIN)
 (setq x 1 y 2)
 ;-> 2

 (define foo
    (let ((x 3))
      (lambda () (list x y))))

 ;-> (lambda () (list x y))

 (foo)
 ;-> (1 2)
 > _

Ricordiamo che le invocazioni lambda in generale hanno un ambito dinamico. Anche se questo è vero occorre notare che la chiamata alla funzione lambda è in definitiva "chiusa" dall'ambito lessicale del contesto MAIN e non dall'espressione let .

Continuando con l'ultimo esempio possiamo vedere questo ibrido ambito lessicale/dinamico al lavoro:

 (let ((x 4)) (foo))
 ;-> (4 2)
 > _

Questa volta il contesto con ambito lessicale viene ampliato dinamicamente durante l'esecuzione dell'espressione let in modo che (foo) venga richiamato nell'ambito dinamico dell'espressione let.

Cosa succederà se invochiamo (foo) in un contesto alieno?

 (context 'FOO)
 ;-> FOO
 FOO> (let ((x 5)) (MAIN:foo))
 ?

Pensaci per un momento. L'espressione let in alto estende dinamicamente l'ambito lessicale di FOO anziché MAIN.

 FOO> (let ((x 5)) (MAIN:foo))
 ;-> (1 2)
 FOO> _

Che cosa è successo? L'ambito dinamico di MAIN:foo include solo l'ambito del contesto MAIN eventualmente esteso dinamicamente. Poiché l'espressione let estende l'ambito dinamico di FOO, l'invocazione di MAIN:foo non vede l'associazione FOO:x => 5.

La seguente espressione è rivelatrice:

 FOO> MAIN:foo
 ;-> (lambda () (list MAIN:x MAIN:y))
 FOO> _

Quando abbiamo introspettato foo nel contesto MAIN, non abbiamo visto il qualificatore predefinito MAIN.

 (context MAIN)
 foo
 (lambda () (lista x y))
 > _

Quindi, anche se il contesto FOO è stato ampliato in modo dinamico con l'associazione FOO:x => 5, possiamo vedere che quando MAIN:foo viene eseguito esecuzione, limita la sua ricerca solo al contesto MAIN (possibilmente esteso dinamicamente).

Quale sarebbe il valore della seguente espressione?

 (context FOO)
 FOO> (let ((MAIN:x 5)) (MAIN:foo))
 ?

Se hai risposto quanto segue, hai indovinato:

 (context FOO)
 FOO> (let ((MAIN: x 5)) (MAIN:foo))
 ;-> (5 2)
 FOO> _

Diciamo che il contesto, o spazio dei nomi, è la chiusura lessicale di tutte le funzioni definite all'interno di quel contesto.

Comprendere come newLISP traduce e valuta il codice sorgente è fondamentale per capire correttamente il funzionamento dei contesti.

Ogni espressione di livello superiore viene prima tradotta e quindi valutata in ordine da newLISP prima di passare alla successiva espressione di livello superiore. Durante la fase di traduzione tutti i simboli (non qualificati) sono considerati da associare nel contesto corrente. Quindi l'espressione di contesto è semplicemente una direttiva per passare (o creare e passare) al contesto indicato. Questo ha importanti implicazioni come vedremo tra poco:

; prima espressione
(context 'FOO)

;seconda espressione
(setq r 1 s 2)

Ciascuna delle espressioni di cui sopra sono espressioni di livello superiore, nonostante l'indentazione suggerisca diversamente. La prima espressione viene tradotta nel contesto corrente. In questo modo, FOO diventa un simbolo associato al contesto corrente (ad es. MAIN, se non lo è già) prima che l'espressione venga effettivamente valutata. Una volta che l'espressione tradotta viene valutata, avviene il cambio di contesto, che può essere visto chiaramente quando si opera in modalità interprete:

(context MAIN)
(context 'FOO)
;-> FOO
FOO>

Quindi, quando newLISP si appresta a interpretare:

FOO> (setq r 1 s 2)

il contesto attuale è ora FOO.

Considerare ora il seguente frammento di codice:

(context MAIN)
(begin (context 'FOO) (setq z 5))
;-> 5
FOO> z
;-> nil
FOO> MAIN:z
;-> 5
FOO> _

Che cosa è successo?

Prima la singola espressione di primo livello:

(begin (context 'FOO) (setq z 5))

è stato tradotta nel contesto MAIN. Quindi z è diventata:

(setq MAIN:z 5)

Appena l'espressione composta begin inizia ad essere valutata viene cambiato il contesto, ma la variabile MAIN:z è già impostata a 5 (perchè prima della valutazione vengono associati i simboli). Al ritorno della valutazione dell'espressione composta, il contesto rimane commutato su FOO.

Per capire correttamente questo funzionamento dobbiamo considerare il comportamento del codice sorgente nelle sue due fasi, cioè la traduzione e l'esecuzione, specialmente quando utilizziamo i contesti.

I contesti possono essere utilizzati per organizzare dati e/o funzioni come record o strutture, classi e moduli:

(context MAIN)
(context 'POINT)
;-> POINT
POINT> (setq x 0 y 0)
(context MAIN)

Il contesto POINT mostrato sopra può essere pensato per una struttura che ha due campi (o slot):

POINT:x
;-> 0
> _

Ma poichè i contesti possono anche essere clonati, possono servire da semplice classe o prototipo. La funzione new mostrata di seguito crea un nuovo contesto chiamato p se non esiste già e quindi unisce una copia delle associazioni trovate nel contesto POINT:

(new POINT 'p)
;-> p
p:x
;-> 0
(setq p:x 1)
;-> 1
p:x
;-> 1
POINT:x
;-> 0

La sequenza di espressioni sopra mostra che il contesto p è una copia distinta e separata di POINT.

L'esempio seguente mostra come i contesti potrebbero essere utilizzati per fornire un semplice meccanismo di ereditarietà della struttura dati:

(context 'POINT)
;-> POINT
(setq x 0 y 0)
;-> 0
(context MAIN)
;-> MAIN

(context 'CIRCLE)
;-> CIRCLE
(new POINT CIRCLE)
;-> CIRCLE
(setq radius 1)
;-> 1
(context MAIN)
;-> MAIN

(context 'RECTANGLE)
;-> RECTANGLE
(new POINT RECTANGLE)
;-> RECTANGLE
(setq width 1 height 1)
;-> 1
(context MAIN)

Si noti come la funzione new unisce i campi x e y di POINT in CIRCLE che aggiunge un campo aggiuntivo chiamato radius. RECTANGLE "eredita" da POINT in modo simile.

La macro def-make qui sotto ci consente di definire istanze nominali di un contesto e facoltativamente specificare gli inizializzatori:

(define-macro (def-make _name _ctx)
  (let ((ctx (new (eval _ctx) _name))
        (kw-args (rest (rest (args)))))
  (while kw-args
    (let ((slot (pop kw-args))
          (val (eval (pop kw-args))))
         (set (sym (name slot) ctx) val)))
ctx))

Ad esempio, è possibile creare un'istanza RECTANGLE di nome r e sovrascrivere i valori predefiniti per x e height con la seguente espressione:

(def-make r RECTANGLE x 2 height 2)

La seguente funzione convertirà una "istanza" di contesto in una stringa:

(define (context->string _ctx)
  (let ((str (list (format "#S(%s" (string _ctx)))))
  (dotree (slot _ctx)
    (push (format "%s:%s" (name slot)
           (string (eval (sym (name slot) _ctx))))
            str -1))
    (push ")" str -1)
(join a str)))

Ora possiamo verificare il contenuto di r:

(context->string r)
"#S(r height:2 width:1 x:2 y:0)"
> _

Si noti come vari caratteri come " -> " possono essere usati nei nomi degli identificatori.

Adesso dovresti conoscere abbastanza su newLISP ora per decifrare le funzioni def-make e context->string che abbiamo definito. Assicurati di cercare nella documentazione di newLISP eventuali operazioni primitive come dotree, push, join, ecc. che non ti sono familiari.

Sia Common Lisp che Scheme hanno funzioni lessical scope, questo significa che una chiusura è esclusiva per una particolare funzione. Le funzioni in newLISP possono condividere una chiusura lessicale, cioè il contesto, che è simile a un oggetto i cui metodi condividono uno stato comune. Gli esempi di contesto mostrati finora potrebbero aver incluso anche funzioni. La documentazione di newLISP fornisce diversi esempi di utilizzo dei contesti come semplice oggetti.


============================================================================
 newLISP per programmatori (Dmitry Chernyak)
============================================================================
v. 1.1

(C) 2006, Dmitry Chernyak losthost@narod.ru.
http://en.feautec.pp.ru
https://web.archive.org/web/20091010040813/http://en.feautec.pp.ru/store/fun-of-newlisp.html

Traduzione: Massimo Corinaldesi aka cameyo 2019

Questo articolo è stato scritto per i programmatori di linguaggi "tradizionali" procedurali e object-oriented. Il suo scopo è quello di mostrare alcune convenienti tecniche di programmazione comuni per il linguaggio funzionale LISP, ma raramente utilizzati in altre linguaggi.

LISP è un'intera famiglia di dialetti, il più famoso e riconosciuto tra questi è Common LISP. Tuttavia, la base di questo articolo è il dialetto semplificato newLISP, il cui interprete funziona in qualsiasi sistema operativo e che può essere utilizzato per "le attività quotidiane" a livello del linguaggio Perl. Le differenze tra newLISP e Common LISP nel quadro del materiale presentato non sono assolutamente significative.

Dove trovare la distribuzione newLISP è scritto nell'ultimo capitolo.

Dunque proviamo!

A COSA SERVE IL LISP?
---------------------

La maggior parte dei linguaggi di programmazione (Con l'eccezione del BASIC :-)) sono stati sviluppati per semplificare la soluzione di certi problemi. Il nome del linguaggio LISP sta per "LISt Processor", "gestore di liste" - questa è la principale area delle sua applicazioni.

Durante la scrittura di codice LISP, le liste sono delimitate da parentesi tonde, ed i suoi elementi sono separati dal carattere spazio. Che cosa può contenere una lista? - in LISP - quasi tutto! Gli elementi di una lista possono essere costanti, nomi di variabili e funzioni (nella terminologia LISP, simboli) e, naturalmente, altre liste:

(1 2 "abc" var (34 "w"))

Non è esagerato dire che in LISP la lista è la principale struttura di dati e di aggregazione. Records e strutture in Common Lisp sono implementati per mezzo del linguaggio stesso (primitive), ma in newLISP non ce ne sono affatto. Le implementazioni moderne (tra cui newLISP) sono dotate di supporto per gli array e gli hash, ma in realtà sono utilizzati solo nei casi in cui l'algoritmo ha davvero bisogno array o hash, vale a dire, sorprendentemente, alquanto raramente. Va notato che in LISP vengono solitamente utilizzate le "liste associative" al posto degli hash.

Una lista associativa è una "lista di liste", in cui il primo elemento è utilizzato come chiave per la ricerca:

((key1 value1_1 value1_2) (key2 value2_1 value2_2) ...)

Per la ricerca nelle liste associative, si utilizzano le funzioni "assoc" e "lookup". Da un lato, questo approccio (teoricamente) porta ad una riduzione delle prestazioni di ricerca (in pratica, questo è un punto controverso...), ma d'altra parte, si può avere più elementi con la stessa chiave e si ha sempre una sequenza fissa di record.

(Come?
 (leggi il programma Lisp))

È molto semplice - tutto ciò che è all'interno delle parentesi è una chiamata di funzione, la prima parola dopo la parentesi aperta è il nome della funzione, e il resto sono i suoi parametri.
Un matematico scriverebbe:

f1 (x, y)

su LISP sarà simile a:

(f1 x y)

Una espressione più complicata:

f1(x, f2(y, z))

si trasformerà in:

(f1 x (f2 y z))

Esempio, addizione

"in modo matematico":

1 + 2 -> 3

"in modo LISP":

(+ 1 2) -> 3

(di seguito, il segno "->" precederà il risultato della valutazione dell'espressione)

Pensi che sia "scomodo!"? – Allora guarda questo:

(+ 1 2 3 4 5) -> 15

Inoltre saranno mostrate le conseguenze più interessanti di questo tipo di approccio.

COME VIENE CALCOLATA UN'ESPRESSIONE LISP?
-----------------------------------------

Così come in matematica: quando calcoliamo una funzione, prima vengono calcolati i suoi argomenti, e poi le azioni definite da questa funzione sono eseguite su di essi.

(+ 10 (sqrt 25)) -> 15

la funzione sqrt (radice quadrata) è calcolata, il risultato (5) viene passato alla funzione +, che, a sua volta, viene calcolata e restituisce il risultato: 10 + 5 = 15.

Alcuni esempi utili:

(setq a "test") -> "test"

"setq" è una funzione di assegnazione, restituisce il valore dell'ultimo argomento, ma assegna anche al carattere "a" il valore "test".

a -> "test"

Il calcolo di un carattere restituisce il suo valore.

(setq b (sqrt 25)) -> 5

Non ci sono commenti.

(setq b '(sqrt 25)) -> (sqrt 25)

un apostrofo "quote" è un carattere speciale che impedisce la valutazione dell'espressione: il risultato è una mormale lista. In realtà, un apostrofo è un'abbreviazione della funzione quote. Questa è l'unica estensione che è stata introdotta nella sintassi del LISP (uso puro di parentesi), grazie all'uso frequente:

(setq b (quote (sqrt 25))) -> (sqrt 25)

"quote", a sua volta, è l'esempio più semplice di una "funzione macro" - una funzione speciale i cui argomenti non vengono calcolati/valutati automaticamente. Torneremo in seguito sui diversi modi di applicare le funzioni macro.

(setq b '(("first" 1) ("second" 2) ("third" 3)))
 -> (("first" 1) ("second" 2) ("third" 3))

(b 1) -> ("second" 2)

per ottenere un elemento tramite un indice, il primo elemento ha indice 0. Tale sintassi di newLISP si chiama "indicizzazione implicita".

(nota: non esiste una sintassi simile in Common LISP, l'indicizzazione viene eseguita dalla funzione nth).

(1 b) -> (("second" 2) ("third" 3))

Taglio (slice) dal secondo elemento alla fine della lista.

(0 2 b) -> (("first" 1) ("second" 2))

taglio dal primo elemento della lista con una lunghezza di 2 elementi. C'è un modo più tradizionale per LISP - la funzione "nth" (elemento per indice) e "slice" - taglio.

(assoc "second" b) -> ("second" 2)
(lookup "second" b) -> 2
(lookup "second" b 0) -> "second"
(lookup "second" b 1) -> 2

Ricerca nella lista associativa: "assoc" restituisce l'intero sottolista, e "lookup" restituisce l'ultimo elemento della sottolista, o un elemento con l'indice specificato nel terzo parametro.

(Perchè?
 (tutte
 (queste parentesi)))

Il codice di un programma LISP è visivamente simile al titolo di questo capitolo. Naturalmente, la cosa più importante che cattura immediatamente l'occhio è l'abbondanza di parentesi :-). E la prima domanda che di solito si pone quando si acquisisce familiarità con LISP è perché usare così tante parentesi quando potrebbero essere sostituite con lo stesso numero di virgole, punti e virgola, parentesi graffe e altre sintassi convenienti?

La risposta si trova in superficie: probabilmente hai già notato la somiglianza tra le liste del LISP e le espressioni del LISP. In effetti, l'espressione LISP è sintatticamente una lista LISP. Inoltre un'espressione può essere trattata come una normale lista – memorizzata in variabili, sottoposta a trasformazioni, passata come parametro di una funzione nella forma di una lista e, ovviamente, verranno eseguite!

Questa è una delle proprietà fondamentali del LISP - l'uso del codice come dati.

Un semplice programma di esempio: movimento in modo casuale nelle quattro direzioni

(setq x 0 y 0); posizione iniziale

(define (up moves) (dec 'y moves))
; definizione di una funzione con il nome "up",
; il parametro "sposta", che riduce
; il valore del carattere "y" per il valore di "moves"

(define (down moves)  (inc 'y moves)); similare
(define (left moves)  (dec 'x moves))
(define (right moves) (inc 'x moves))

(setq doings (list up down left right))
; solo un elenco di caratteri con
; le funzioni appena definite ;-)
; funzione list - crea una lista

(seed (date-value))
; inizializza il generatore di numeri random

; spostamento diretto
dotimes (i 100)
  ((doings (rand 4)) (rand 5))
  (println x ":" y))

Analizziamo l'espressione spostamento più in dettaglio:

(dotimes (i 100) espressione1 espressione2 ...) - calcola le "espressioni" 100 volte, mentre il simbolo "i" assume valori da 0 a 99.

(rand 4) - genera un numero intero casuale nell'intervallo da 0 a 3.

(doings (rand 4)) - questa forma è stata descritta nel capitolo precedente come "ottenere un elemento da una lista in base all'indice". Di conseguenza: "doings" è una lista, e "(rand 4)" serve come indice.

Vale la pena di guardare la lista delle azioni/moves più da vicino:

doings ->
 ((lambda (moves) (dec 'y moves))
  (lambda (moves) (inc 'y moves))
  (lambda (moves) (dec 'x moves))
  (lambda (moves) (inc 'x moves)))

Come promesso all'inizio del capitolo, una normale lista può contenere codice di programma! La parola "lambda", che si trova all'inizio di ogni funzione - l'elemento dell'azione, non è un elemento della lista, ma indica che questa lista è una funzione che può essere chiamata. Tali funzioni sono chiamate "funzioni lambda" o "funzioni senza nome." Allo stesso tempo, la funzione lambda è una lista normale, e il primo elemento (zero) della nostra lista lambda è l'elemento "(moves)".

Forse avete una domanda: che dire dei nomi - "up", "down", "left" e "destra"? In realtà, questi nomi sono solo i caratteri delle variabili a cui vengono assegnate le liste lambda come valori:

up -> (lambda (sposta) (dec 'y mosse))

(up 1) -> -1; funzione viene chiamata con il parametro 1

(nth 0 up) -> (moves)
; poiché indicizzazione implicita non funziona in questo
; caso, utilizzare la funzione ennesima per ottenere
; l'elemento 0

(setq up-new up)

up-new -> (lambda (moves) (dec 'y moves))

(up-new 1) -> -2; era -1, diminuiamo ancora di uno...

Infatti, le due espressioni seguenti sono identiche:

define (up moves) (dec 'y moves))

setq up '(lambda (moves) (dec' y moves)))

Tuttavia, andiamo avanti con il nostro esempio ...

((doings (rand4)) (rand 5)) - dal momento gli elementi della lista "doings" sono funzioni, si può usare come una normale chiamata a funzione - cioè, sostituire il nome della funzione nell'espressione LISP. Di conseguenza, un numero casuale (rand 5) sarà l'argomento della funzione.

(println expression1 expression2 ...) - stampa i risultati della valutazione delle espressioni-argomenti, completandoli con un avanzamento di riga. Inoltre, la funzione println restituisce il risultato della valutazione dell'ultima espressione dell'argomento.

In conclusione dell'analisi di questo esempio, occorre notare che, con non meno di successo, potremmo fare una lista di "azioni" non dal codice della funzione, ma dai caratteri a cui sono assegnati:

...
(setq doings' (up down left right))
...
(dotimes (i 100)
  (apply (doings (rand 4)) (list (rand 5)))
  (println x ":" y))

L'unica nuova funzione qui è "apply" - il suo primo argomento è il nome della funzione che si deve chiamare, e il secondo è un elenco di argomenti a cui questa funzione deve essere applicata.

Opportunità simili a quelli descritte e parzialmente rudimentali sono presenti nei linguaggi procedurali, tuttavia, essi sono utilizzati principalmente da programmatori molto esperti nei in momenti di disperazione. Per renderli più amichevoli, la OOP è stata aggiunta ai linguaggi procedurali, che, a sua volta, richiede la decomposizioni in oggetti e rende più complessa la programmazione.

Tuttavia, in LISP, l'uso del codice come dati è una pratica "quotidiana", applicata quando necessario (e anche quando non servirebbe :-).

Alla fine del capitolo, qualche parola sulla OOP in Lisp: In Common Lisp, il sistema di programmazione orientata agli oggetti (CLOS) è implementato come una normale libreria scritta in Common LISP - senza alcuna modifica al linguaggio in se stesso.
Nel linguaggio newLISP, per la programmazione con gli oggetti, viene proposto un sistema integrato di "contesti" ( "context") – spazi di nomi (namespace) isolati che implementano i principi fondamentali della programmazione orientata agli oggetti in forma più adatta per la scrittura rapida di "script".

LE ECCEZIONI CHE CONFERMANO LE REGOLE.
--------------------------------------

Nei capitoli precedenti, abbiamo già incontrato un'eccezione insolita alla sintassi armoniosa delle parentesi LISP - il simbolo della apostrofo, una notazione abbreviata per la funzione macro "quote". Infatti, questa funzione è l'unico modo in LISP per impostare una funzione costante (non valutata) come argomento. Cosa che la rende così speciale?

(define (test1 arg) (println arg))
; definiamo una funzione ordinaria
(test1 (+ 1 2)) -> 3
; e prova ...

(define-macro (test2 arg) (println arg))
; ora definiamo una "inusuale" funzione macro
(test2 (+ 1 2)) -> (+ 1 2)
; e prova ...

A differenza delle funzioni ordinarie, in cui gli argomenti vengono valutati automaticamente prima della chiamata, quando si utilizzano le "funzioni macro" viene utilizzato il modello di valutazione "lazy" (pigro), in cui gli argomenti non vengono assolutamente valutati.

Al fine di evitare confusione inutile, è opportuno notare che il termine "macro" in LISP non significa che la funzione viene calcolata/espansa dal preprocessore prima di interpretare (compilare) il codice principale, come avviene nel linguaggio C. – Le funzioni "Macro", così come quelle ordinari, vengono calcolate/valutate direttamente durante l'esecuzione del programma.

La funzione di "quote" è la funzione macro più semplice. Se non fosse definita nel linguaggio, potrebbe essere scritta come segue:

(define-macro (quote a) a)
; funzione prende un argomento
; e lo restituisce inalterato (senza valutarlo)

Se si passa un'espressione LISP come argomento a una funzione macro, allora questa espressione in sé (non valutata) sarà disponibile come variabile nel calcolo della funzione macro chiamata. Se si desidera valutarla, è necessario utilizzare la funzione "eval":

(define-macro (test3 arg) (println (eval arg)))
(test3 (+ 1 2) -> 3

Tale comportamento permette una interessante opportunità:

(define-macro (my-if condition result-true result-false)
  (let  (_c (eval condition))
    (and _c (eval result-true))
    (or  _c (eval result-false))))

(my-if (= 1 1) (println "true") (println "false")) -> "true"
(my-if (= 1 2) (println "true") (println "false")) -> "false"

La funzione "let" ha la seguente sintassi:

(let (character1 expression-value1 character2 expression-value2 ...)
  action expression
  action expression
  ....)

crea e inizializza i caratteri/variabili che agiranno al momento del calcolo delle espressioni-azioni, e cessano di esistere (memoria libera) al momento del ritorno dalla funzione "let". Il risultato della funzione let è il risultato della valutazione dell'ultima espressione.

Le funzioni "and" e "or" sono operatori logici ed operano secondo uno schema evidente: per "or" - se la prima espressione è falsa, la seconda è calcolata, ecc, viene ritornato il risultato della prima espressione vera (true).
Per "and", rispettivamente.

Così, abbiamo discretamente definito e provato un nuovo costrutto di sintassi - l'operatore più comune di branching condizionale! E la cosa più sorprendente di questo operatore è che esteriormente è indistinguibile da tutti i costrutti della sintassi LISP, compresi quelli incorporati! (built-in)
Grazie a questa caratteristica, LISP è giustamente chiamato un "meta-linguaggio", o "il linguaggio per la creazione di linguaggi": uno dei metodi di programmazione raccomandati in LISP è quello di creare il proprio linguaggio con la sintassi conveniente per risolvere un problema specifico, e quindi utilizzare questo linguaggio per ottenere il risultato desiderato.

Tra l'altro, durante la creazione di compilatori Common Lisp, la maggior parte della sintassi del linguaggio standard è implementato non nel linguaggio di creazione del compilatore, ma in Common Lisp se stesso, come librerie.

Naturalmente, ci sono modi più complessi e produttivi per costruire le funzioni-macro, basati sula modifica del codice passato loro e la compilazione di nuove espressioni sulla base di questo codice. Durante la scrittura di macro in newLISP non dimenticate di fare la conoscenza con la funzione "letex".

UN PÒ DI COMPUTAZIONE CONDIZIONALE.
-----------------------------------

Dal momento che abbiamo citato l'operatore condizionale, diamo uno sguardo più da vicino ai calcoli logici in newLISP (il LISP tradizionale ha alcune differenze, in particolare, una diversa interpretazione del concetto di "nil" e regole molto insoliti di uguaglianza).
La base dei calcoli logici, la logica binaria, è costruita sui valori di "vero" (true) e "falso" (false). In newLISP, il valore "false" utilizza il simbolo "nil". Il secondo scopo di questo carattere è il valore "null" che hanno i caratteri non inizializzati.

Tutti gli altri valori in newLISP sono trattati come true (incluso 0, una stringa vuota e una lista vuota). Per facilità di scrittura, newLISP ha anche un simbolo speciale "true" - alcune funzioni logiche possono restituirlo.

(if condition expression
    condition expression
    ...
    otherwise, expression)

Così appare la vera funzione della ramificazione condizionale. Se la "condition" è vera, allora la corrispondente "espressione" viene eseguita e il calcolo della funzione viene interrotto. Se tutte le "condition" sono false, allora viene eseguita l'espressione "otherwise, expression". Se una qualsiasi "espression" viene valutata, allora il risultato viene restituito come risultato della funzione, altrimenti viene restituito nil.
Si noti che un "expression" può essere una sola espressione:

(if right (+ x 1))

Se è necessario eseguire una sequenza di espressioni diverse, allora è necessario "racchiuderle" con la funzione "begin":

(if right (begin
            (+ x 1)
            (+ y 1)))

"begin" è una semplice funzione per collegare una sequenza di espressioni. Naturalmente, se necessario, invece di questa, è possibile utilizzare la funzione già vista "let" o un altro operatore condizionale o qualcos'altro adatto per il caso.

Notare che l'esempio potrebbe utilizzare dei caratteri UTF-8 per i nomi dei simboli, poichè in newLISP questo è valido.

Un'alternativa al costrutto "if" è la funzione "cond":

(cond (expression condition)
      (expression condition)
       ...)

A causa delle parentesi aggiuntive, "expression" può essere una sequenza di diverse espressioni, senza ulteriori contenitori.

E, infine, la regina delle funzioni condizionali è la funzione "case":

(case symbol
   (test constant expression)
   (test constant expression)
   ...
   (true expressions))

Esempio:

(define (translate n)
  (case n
    (1 "one")
    (2 "two")
    (3 "three")
    (4 "four")
    (true "Can't translate this")))

 (translate 3) -> "three"
 (translate 10) -> "Can't translate this"

In questo esempio, il valore del simbolo "n" sarà sequenzialmente confrontato con i "test costanti" 1, 2, 3, ecc. e, se abbinato, l'espressione corrispondente verrà calcolato. Si noti che in questo esempio costanti di tipo stringa sono utilizzate come expressions. La costante finale "true" viene usata per indicare l'azione predefinita.

Ora, utilizzando la funzione "translate", un valore numerico può essere convertito in una stringa numerica.

Va notato che la funzione "caso" ha una particolarità: le "costanti di prova" sono solo costanti, non possono essere delle espressioni da calcolare. Cioè, il seguente programma è sintatticamente valido, ma non porterà al risultato desiderato:

(case n
   (a "n is equal to a")
   ((+ a 1) "n is one more than the value of a"))

Il vantaggio di questo comportamento è l'aumento di velocità della funzione "case".

Ma cosa succede se la convenienza è più importante? È molto semplice scrivere una macro:

(define-macro (ecase _v)
   (eval (append
           (list 'case _v)
           (map (fn (_i) (set-nth 0 _i (eval (_i 0))))
                (args))))))
Proviamo:

(setq a 1 n 2)
; assegna a = 1, n = 2

(ecase n
  (a "n is equal to a")
  ((+ a 1) "n is one more than the value of a"))

-> "n is one greater than the value of a"

La funzione macro ecase funziona nel seguente modo: nella lista dei suoi argomenti, che è lo stessa di quella della funzione "case", sostituisce tutte le espressioni che sono al posto delle "costanti di prova" con il risultato del loro calcolo - cioè, con altre costanti.
Poi il simbolo case e il nome della variabile testata vengono aggiunti in cima alla lista convertita.
Poi l'espressione risultante viene valutata utilizzando la funzione eval.

Il testo di questa macro è ancora un po 'complicato - sarà chiaro dopo i capitoli "Conversione di liste" e "Funzioni anonime".

ASSEGNAZIONE FUNZIONALE TALMENTE "SCOMODA".
-------------------------------------------

Espressione semplice:

a = 1 + 2;

con newLISP può essere scritta come:

(setq a (+ 1 2)) -> 3

Sembra insolito? Non è ovvia la convenienza di questo metodo?
Dai un'occhiata a questo:

(setq a (+ 1 2 3 4 5)) -> 15

Molte delle funzioni LISP standard possono gestire un numero arbitrario di argomenti Qui, naturalmente, si può dire che il vantaggio non è grande - la capacità di indicare in modo statico un elenco arbitrario di argomenti. Tuttavia, non abbiate fretta...
È facile notare che gli argomenti della funzione "+" sono una lista. Scriviamo sotto:

(setq L '(1 2 3 4 5)) -> (1 2 3 4 5)

L -> (1 2 3 4 5)

Ora abbiamo una lista. Se potessimo costruire un'espressione dal nome della funzione desiderata e la nostra lista, e potessimo calcolarla, allora l'elaborazione di funzioni di un numero arbitrario di argomenti avrebbe più senso...

(define-macro (my-apply fun lst)
  (eval (cons fun (eval lst))))

(my-apply + L) -> 15

La funzione "cons", nuova per noi, crea una lista con l'aggiunta di un nuovo elemento (primo argomento) all'inizio di quella esistente (secondo argomento). In realtà, abbiamo già visto la funzione built-in "apply", che fa la stessa come la nostra macro.

(setq a (a + L)) -> 15

La funzione "applica" valuta la funzione indicata dal primo argomento, passando come argomenti la lista del secondo argomento.
Naturalemente, al posto della funzione "+" ci può essere una qualsiasi altra funzione, compresa una definita dall'utente:

(define (average) (div (apply add (args)) (length (args))))
-> (lambda () (div (apply add (args)) (length (args))))

(apply average L) -> 3

"add" e "div" sono analoghi delle funzioni e "+" "/", ma funzionano con i numeri in virgola mobile. "args" è una funzione che restituisce tutti gli argomenti non collegati passati alla funzione.
Così:

(define (f x y) (println "x =" x "y =" y "args =" (args)))
-> (lambda (x y) (println "x =" x "y =" y "args =" (args)))

(f 1 2 3 4) -> x = 1 y = 2 args = (3 4)

CARATTERISTICHE ANONIME.
------------------------

In LISP ci sono un sacco di funzioni che, come "apply", prendono altre funzioni come argomenti. Puoi anche scriverne una.

Uno dei più notevoli esempi built-in è la funzione "map".

(map pow '(1 2 3 4)) -> (1 4 9 16)
; pow – elevamento a potenza

(map first '((1 2 3) (4 5 6) (7 8 9))) ->' (1 4 7)
; first - restituisce il primo elemento della lista

La funzione "map" viene utilizzata per convertire gli elementi delle lista. La funzione specificata come primo argomento di "map" viene applicata in sequenza (uno per uno) a tutti gli elementi della lista specificata nel secondo argomento. I risultati del calcolo vengono inseriti in una nuova lista, che viene restituita dalla funzione.
Comunque "map", non sembra molto conveniente nel caso seguente:

(define (third lst) (lst 2))
 ; there is no third function

(map third '((1 2 3) (4 5 6) (7 8 9))) ->' (3 6 9)
Abbiamo solo voluto prendere il terzo elemento di ogni sottolista, e per questo abbiamo dovuto pre-definire la funzione. Anche se a volte questo non è affatto dannoso, in generale, mi piacerebbe essere in grado di farne a meno. La funzione "fn" viene in soccorso - il costruttore di liste lambda anonimi:

(map (fn (lst) (lst 2))
     '((1 2 3) (4 5 6) (7 8 9))) ->' (3 6 9)

La funzione "fn" funziona in modo simile alla funzione di "define", ma e "fn" non assegna la lista lambda creata ad una nome/variabile:

(define (third lst) (lst 2)) -> (lambda (lst) (lst 2))
; in addition, the symbol "third" received a value
; the same of lambda list

(fn (lst) (lst 2)) -> (lambda (lst) (lst 2))
; only lambda list as a result
; no additional effect

Oltre alla funzione di "fn", c'è un "fn-macro" progettato per creare macro anonime.

Abbiamo già visto una tecnica simile al capitolo "(Perché? (Tutte (queste parentesi)))", ma negli esempi non veniva utilizzata la funzione "fn", ma direttamente la lista lambda, protetta dal simbolo apostrofo:

(fn (lst) (lst 2)) -> (lambda (lst) (lst 2))
'(lambda (lst) (lst 2)) -> (lambda (lst) (lst 2))

Di conseguenza, queste espressioni sono equivalenti. L'unica differenza è la brevità.

CONVERTIRE LISTE.
-----------------

Nell'esempio con il "ecase" macro, che abbiamo già incontrato la funzione "lista", che permette di creare liste di singoli elementi:

(setq a 25)
(list 1 2 3 a) -> (1 2 3 25)

Abbiamo visto anche la funzione di "append", che unisce le liste:

(append '(1 2 3)' (4 5 6)) -> (1 2 3 4 5 6)

E l'esempio con il "my-append" - la funzione "cons", che aggiunge un elemento in cima alla lista:

(cons 1 '(2 3 4)) -> (1 2 3 4)
(cons '(1 2)' (3 4)) -> ((1 2) 3 4)

In un LISP tradizionale, dove le liste sono rappresentate come una testa e una coda, "cons" svolge un ruolo molto più significativo combinando questi due componenti. In newLISP, le liste sono costruiti su una base "lineare".

Di maggiore interesse sono funzioni progettate per convertire una lista in un'altra. La più semplice e più attesa è la funzione "filter", che filtra la lista, lasciando in essa solo i valori che soddisfano la condizione data:

; (filter test_function list)

(filter (fn (x) (not (empty? x))) '("abc" "" "def" "jhi" ""))
  -> ("abc" "def" "jhi")

"empty?" - Una funzione che restituisce "true" se argomento non è una stringa vuota o una lista non vuota. "filter" restituisce una lista in cui rimangono solo gli elementi per cui la funzione di test restituirà true.
La funzione inversa è "clean":

(clean empty? '("abc" "" "def" "jhi" "")) -> ("abc" "def" "jhi")

Un'altra semplice, ma utile funzione, "join", combina una lista di stringhe in una singola stringa.

(join '("abc" "" "def" "jhi") ":") -> "abc :: def: jhi"
(join '("abc" 123 "def" "jhi") ":") -> Error! - 123 is not a string
(join (map string '("abc" 123 "def" "jhi")) ":") -> "abc: 123: def: jhi"

Il primo parametro "join" è un elenco di stringhe, il secondo (opzionale) è un delimitatore di stringa. La funzione utilizzata converte qualsiasi tipo di dati in una rappresentazione di testo.

E, naturalmente, "la più meravigliosa" è la funzione "map" discussa nel capitolo precedente. Inoltre, essa può gestire più liste.

(map (fn (x y) (+ x y)) '(1 2 3 4)' (5 6 7 8)) -> (6 8 10 12)

E, data la ben nota funzione "+", è possibile scriverla in modo ancora più semplice:

(map + '(1 2 3 4)' (5 6 7 8)) -> (6 8 10 12)

Ora sapete abbastanza per tornare alla macro "ecase" e vedere come funziona.

METODI DI PROGRAMMAZIONE.
-------------------------

Se siete armati con competenze di programmazione procedurale, e si tenta di scrivere in LISP (e, in particolare, in newLISP), allora si avrà successo molto presto. Tuttavia, è improbabile che il risultato finale sia superiore agli analoghi in linguaggi ordinari. LISP è un linguaggio funzionale, in cui troviamo le sue leggi di efficienza e i propri metodi di programmazione confortevole.

Caratteristiche di autocontenimento.
------------------------------------

La accademicamente corretta programmazione funzionale "pura" richiede che le funzioni utilizzate non abbiano "effetti collaterali (side effect)". Cioè, la funzione può elaborare solo i dati che riceve come parametri e l'unico risultato del suo funzionamento deve essere il valore restituito. La funzione non deve utilizzare o modificare le variabili "globali".

Nonostante il fatto che, nella pratica reale, un tale stile non è sempre possibile ed efficace, cercare di avvicinarsi ad essa permette di scrivere il programma in modo più trasparente e rendere gli errori logici più visibili.

Registrazione funzionale.
-------------------------

Ridurre l'uso di effetti collaterali consente, a sua volta, di aumentare le capacità di registrazione funzionale - quello che normalmente è scritto sotto forma di diverse espressioni in un linguaggio procedurale spesso può essere messo in una sola espressione in LISP. Inoltre, la struttura annidata dell'espressione LISP rivela le connessioni logiche dei suoi componenti. L'aspetto di una notazione funzionale è più simile a un linguaggio naturale, mentre una notazione procedurale non è altro che un elenco di azioni sequenziali (come l'assembler).

Sviluppo dal basso verso l'alto (bottom-up).
--------------------------------------------

Naturalmente, non si deve aspettare "trasparenza" da un'espressione funzionale di due pagine. Tutti sanno che il codice che è troppo grande può essere diviso in funzioni. L'approccio usuale per linguaggi procedurali è quello di definire un compito, isolare i sottocompiti, e dividerli fino a quando diventa possibile scrivere funzioni separate per la loro soluzione. Se alla fine dello sviluppo le funzioni risultano ancora grandi e complesse, si capisce che era necessario risolvere il problema in modo leggermente diverso ... Questo metodo è chiamato sviluppo top-down.
In LISP, grazie alle sue proprietà di meta-linguaggio, tutto è fatto al contrario. Per risolvere il problema, l'argomento da risolvere viene indagato e, in base alle capacità di LISP, viene creato un nuovo linguaggio. Quindi, la soluzione del problema viene scritta in questo linguaggio. Se "improvvisamente" si scopre che il piano originale ha subito cambiamenti significativi, questo non è un problema - in un linguaggio ad-hoc non è difficile scrivere qualcosa di nuovo. Questo metodo viene chiamato sviluppo bottom-up.

Un conseguenza particolarmente piacevole dello sviluppo bottom-up è la capacità di usare il linguaggio più appropriato a ciascun livello di risoluzione del problema, che, ancora una volta, può essere facilmente tradotto nella logica del linguaggio naturale.

Auto documentante.
------------------

A tutto quanto sopra, occorre aggiungere due osservazioni: - non lesinare sui nomi "auto-documentanti" delle funzioni e delle variabili. I nomi "t", "tmp", "ex", ecc sono buoni in sezioni locali di codice. Tuttavia, per i nomi a livello globale, qualcosa come "exit-state" è molto meglio (e non dire che tu digiti lentamente!). A volte per designare un'azione da svolgere solo una volta è meglio scrivere una funzione separata.

Non privatevi della possibilità di scrivere in questo modo:

(do-select ((CustomerName CustomerEmail)
            : from Customers
            : where (> CustomerAge 100))
  (send-email CustomerEmail
              : subject "Congratulations!"
              : body (format nil
                            "Dear ~ A, you won a prize! Call ~ A."
                            CustomerName company-phone)))

I commenti sono superflui, non è vero?

Questo esempio è scritto in sintassi Common Lisp. Preso da un forum su http://linux.org.ru.

Elaborazione liste.
-------------------

E, infine, occorre ricordare che LISP è progettato per elaborare liste. Maggiori sono le opportunità di applicare le liste nel problema, maggiori sono le possibilità che l'elaborazione dei dati sia più facile (for free).

FORMATTAZIONE DEL CODICE.
-------------------------

Ci sono opinioni diverse su come formattare meglio il codice LISP e newLISP. Un metodo abbastanza comodo e "canonico" è descritto qui:

Indentazione.
-------------

Il rientro standard per l'annidamento delle espressioni è impostato su due spazi.

Il rientro per liste di dati annidate è uno spazio (dal momento che le parentesi di apertura sulla linea precedente possono seguire una dopo l'altra).

Se una funzione ha molti argomenti e il primo si trova sulla stessa riga del nome della funzione, il resto degli argomenti sono convenientemente scritti sotto il primo "in una colonna" (come nell'esempio precedente).

Per funzioni speciali, come "let" o "se", in cui il primo parametro ha un significato speciale, il primo parametro di solito inizia sulla stessa riga del nome della funzione, e il resto su altre linee con una indentazione standard di due spazi:

(if (= ab)
  (println "equality")
  (println "inequality"))

Chiusura parentesi.
-------------------

Le parentesi di chiusura di solito non compaiono su righe separate, come avviene nel linguaggio "C" e simili. Questo è inutile per mettere in evidenza la struttura del programma, dal momento che l'indentazione (i rientri) porta già tutte le informazioni necessarie.

Per controllare l'equilibrio (bilanciamento) delle parentesi, è meglio utilizzare un editor di testo che offre la possibilità di visualizzare automaticamente le coppie di parentesi - tutti i moderni editor per "programmatori" sono in  grado di farlo.

In assenza di un editor "corretto", è conveniente per chiudere le parentesi "alla cieca" - usare gli occhi per contare il rientro del codice dal più interno al livello che deve essere completato, per ogni volta che premete ciecamente la parentesi di chiusura sulla tastiera.

SCRIPTING PRATICO.
------------------

Il compito più comune di scripting è, naturalmente, elaborare file di testo. Il leader assoluto in termini di convenienza qui è AWK - non esiste un linguaggio che potrebbe essere scritto in modo più conciso. Purtroppo, questo è un linguaggio piuttosto debole, che perde rapidamente terreno quando c'è la necessità di elaborare dati complessi. In questa area, Perl ha tradizionalmente dominato.

Per gli stessi compiti, newLISP è una buona scelta. Questo linguaggio supporta anche le espressioni regolari Perl-compatibili (PCRE) e permette l'analisi (parsing) di documenti di testo. La peculiarità dell'uso di newLISP è il suo orientamento per l'elaborazione di liste (mentre lo stile Perl tende all'elaborazione del flusso – stream processing). Ciò significa che quando usiamo newLISP, di solito è più vantaggioso non processare il testo linea per linea, ma di leggere tutto il file, dividerlo in una lista che contiene le sue parti (linee, parole, righe) e quindi elaborarle utilizzando tutta la potenza del LISP.

Ad esempio, si consideri un compito semplice: Supponiamo che il file "report.txt" contenga un rapporto nella forma seguente:

+ ---------------------------- +
 | Sample Text Report |
+ ---------------------------- +
 |uid | balance | volume |
+ ---------------------------- +
 |user1 | 100,000 | 1000 |
 |user2 | 200,000 | 1234 |
 ...

e si desidera conoscere l'importo per totale della colonna balance:

(apply +
  (map (fn (x) (int (x 3) 10))
       (filter (fn (x) (and (> (length x) 3) (regex "^ [0-9] + $" (x 3))))
               (map (fn (x) (parse x "* \\ | *" 0))
                    (parse (read-file "report.txt") "\ n")))))

Nuove funzionalità:

"Read-file" - legge in un file come una unica stringa.

"parse" - divide la linea in una lista di linee in base ai delimitatori specificati. Quando si specificano le opzioni aggiuntive, è possibile utilizzare le espressioni regolari (PCRE).

"\n" è il carattere di fine linea.

"regex" - Ricerca per una corrispondenza della espressione regolare.... Se non la trova, restituisce nil

"int" - converte una stringa in un intero con la base specificata dal secondo parametro.

Per capire come funziona, scriviamo la stessa cosa, ma più accuratamente:

(define (split-report-line str)
  (map (fn (x) (parse x "* \\ | *" 0))
       str))

(define (line-has-data? lst)
  (and (> (length lst) 3) (regex "^ [0-9] + $" (lst 3))))

(apply +
  (map (fn (x) (int (x 3) 10))
       (filter line-has-data?
               (map split-report-line
                    (parse (read-file "report.txt") "\ n")))))

Ora il codice principale praticamente non ha bisogno di commenti. In breve:
1) il file di report viene letto (nella sua interezza),
suddiviso in una lista di righe,
2) le linee sono divise in elementi,
3) le linee contenenti dati per l'analisi vengono filtrate,
4) il quarto elemento viene preso da ogni riga (indice -3) e convertito in un numero,
5) la lista risultante viene sommmata.

Due funzioni ausiliarie sono evidenti: la prima separa la stringa con una espressione regolare (e rimuove tutti gli spazi aggiuntivi in uno), la seconda cerca nella lista divisa in stringhe il valore numerico nel quarto elemento (quello che interessa a noi).

Forse in Perl è possibile scrivere un programma più compatto. Tuttavia, non bisogna dimenticare che il risultato principale di questo script è quello di ottenere una lista di tutti gli elementi del report che possono poi essere raggruppati, filtrati, correlati e manipolati con tutta la ricchezza delle funzioni per l'elaborazione delle liste.

-------------------
Qui mi permetto di interrompere il racconto, visto che è stato scritto abbastanza, e si può cedere al desiderio di vedere cosa si può fare con questo linguaggio ...
-------------------

IN CONCLUSIONE, QUALCHE PAROLA SULLE CARATTERISTICHE DEL LINGUAGGIO newLISP.
----------------------------------------------------------------------------

newLISP è stato creato ed è attivamente sviluppato grazie agli sforzi di Lutz Mueller. Si tratta di un interprete scritto in puro C, utilizzando solo la libreria standard libc. Questa implementazione ha reso newLISP un linguaggio multipiattaforma che funziona allo stesso modo in molti sistemi Unix, tutte le versioni di M$ di Windows, e sotto MacOS X.
Nonostante le sue dimensioni in miniatura - un file binario di circa 300k, newLISP ha molte caratteristiche, tra cui:

• TCP/IP, uso di network deamon e supporto HTTP
• Spawn dei processi, semafori, segnali, timer
• Utilizzo di funzioni da librerie dinamiche (.so, .dll, etc.)
• PCRE espressioni regolari
• parser XML
• Interfaccia per TCL/Tk (distribuzione di Windows include Tk Graphics Library)
• sistema di unificazione che permette di implementare la logica in stile Prolog
• classificatori bayesiani (utilizzando librerie aggiuntive dal kit di distribuzione)
• Supporto Unicode
• Molte funzioni matematiche

newLISP è pubblicato con licenza GNU GPL con sorgenti e binari disponibili presso http://newlisp.org. Sullo stesso sito avrete accesso a una eccellente documentazione (in inglese), link utili, suggerimenti e un forum accogliente (in inglese).
Tra la documentazione, vale la pena evidenziare i documenti "ufficiali" estremamente utili:
"newLISP Manual and Reference" - un riferimento alla lingua e alla
"Code Patterns in newLISP" - una descrizione delle tecniche di programmazione per tutte le principali aree di applicazione del linguaggio.

Il sito dell'autore di questo articolo si trova a http://en.feautec.pp.ru. Si possono trovare diverse librerie utili e un repository non ufficiale Debian.


RINGRAZIAMENTI
--------------

Ai visitatori di linux.org.ru alcuni dei loro commenti sono stati molto interessanti.

Alex dal forum di newLISP per i commenti sullo stile.


LICENZA
-------

This text may be freely distributed in whole or in part on electronic networks, provided that information about the author and the original site is stored - http://en.feautec.pp.ru.

Any modification of the text is allowed under the following conditions:
- reflection of the fact of modification in the line with the version number at the beginning of the document,
- notification of the author by e-mail specified in the Copyright document,
- unconditional consent to include any fragments of the changes in the original version of the document (with reflection authorship in the Acknowledgments section).

Any reproduction of this document in the form of hard copies (on paper or electronic media), with the exception of newLISP distributions and distributions of free operating systems, is allowed only with the written consent of the author.

(C) 2006, Dmitry Chernyak losthost@narod.ru.


============================================================================
 Notepad++ bundle
============================================================================

How to use notepad++ with newLISP.

Download: https://github.com/cameyo42/notepadpp-newLISP

Add newLISP syntax highlighting
-------------------------------
Copy all the text of the file: newLISP-udl.xml
and paste it inside the section:<NotepadPlus> ... </NotepadPlus>
of the file: userDefineLang.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)

Example
<NotepadPlus>
    <UserLang name="newLISP" ext="lsp" udlVersion="2.1">
    ...
    </UserLang>
</NotepadPlus>

The newLISP keywords are from primes.h (newLISP source).
The actual highlight colors are for "obsidiane" theme of notepad++.
You can change (easily) the colors as you like.

Open newLISP help from notepad++
--------------------------------

Add the line:

<Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newLISP/newLISP_manual.html#$(CURRENT_WORD)</Command>

inside the section: <UserDefinedCommands> ... </UserDefinedCommands>
of the file: shortcut.xml (located at: c:\Users\<username>\AppData\Roaming\Notepad++\)

Example:
<UserDefinedCommands>
    <Command name="newLISP Help" Ctrl="yes" Alt="yes" Shift="no" Key="112">chrome file:///C:/Program%20Files%20(x86)/newLISP/newLISP_manual.html#$(CURRENT_WORD)</Command>

</UserDefinedCommands>

Note: change the path to point to your newLISP help file

Now you can select a word and press Ctrl+Alt+F1 to open newLISP help file.

The shortcut is Ctrl + Alt + F1, but you can change it.

Execute newLISP code from notepad++
-----------------------------------

Download and install autohotkey (http://www.autohotkey.com).

Run the script "npp-newLISP.ahk" (double click it).

Run notepad++

Press Win+F12 to start newLISP REPL (la cartella di default di newLISP è quella dove si trova  lo script "npp-newLISP.ahk")

Now, from notepad++, you can:

1) Execute the expression of current line pressing: Left-Shift + Enter

2) Execute a selected block of expression pressing: Right-Shift + Enter

After the execution of the expressions, notepad++ is the active application.

3) Shortcut (Ctrl + F8) to evaluate expression inside notepad ++ (get the result in notepad++ console)

4) Shortcut (Ctrl + Alt + =) to insert:
[cmd]

[/cmd]

Note:
When selecting a block of expression be sure to begin and end the selection
with a blank line (or use [cmd] [/cmd]).

Note:
The script npp-newLISP.ahk exchange the brackets () and [] in the keyboard.
You can edit the file to disable this (you must comment two lines).
The script also enable other shortcuts... see the source.


============================================================================
 Visual Studio Code e newLISP
============================================================================

You can use VSCode or (better) VSCodium (https://vscodium.com/) with newLISP .

Add these lines to the file "keybindings.json":

1. Shift+Enter to run selected text or current line

{ "key": "shift+enter",
  "command": "workbench.action.terminal.runSelectedText", "when": "editorTextFocus"},

2. switch editor <--> terminal

{ "key": "ctrl+`", "command": "workbench.action.focusActiveEditorGroup", "when": "terminalFocus" },
{ "key": "ctrl+`", "command": "workbench.action.terminal.focus", "when": "!terminalFocus" },

In definitiva:

[
    { "key": "shift+enter",
      "command": "workbench.action.terminal.runSelectedText",
      "when": "editorTextFocus" },

    { "key": "ctrl+`",
      "command": "workbench.action.focusActiveEditorGroup",
       "when": "terminalFocus" },

    { "key": "ctrl+`",
      "command": "workbench.action.terminal.focus",
      "when": "!terminalFocus" }
]

Now, open Terminal and run newlisp.exe (type newlisp.exe)

Now type (+ 1 2 3) and press Shift+Enter:
;-> 6

(define (sum a b) (add a b))
;-> (lambda (a b) (add a b))

(sum 2 3)
;-> 5

To move the Terminal window to the right, right click on Terminal menu bar (any place) and select "Move Panel to Right".

You can use the autohotkey script "vscode.ahk":

Ctrl-Alt-q insert:
;->

Ctrl-Alt-w insert:
[cmd]

[/cmd]


============================================================================
 Debugger
============================================================================

Il debugger in newLISP è molto spartano, ma è comunque un aiuto indispensabile nello sviluppo dei programmi.

La funzione principale è "trace".
Per fa partire o terminare  il debugger, usare il paraemtro true o nil:

Per iniziare la sessione di debugging: (trace true)

Per terminare la sessione di debugging: (trace nil)

Per verificare lo stato del debugger (nessun argomento):
(trace) ; Senza argomento, ritorna true se la sessione è attiva.
;-> true

Il comando trace-highlight permette di controllare alcune modalità di visualizzazione dell'espressione che è attualmente in fase di valutazione. Se utilizziamo un terminale che supporta i codici ANSI possiamo modificare anche il colore e altri parametri (grassetto, sottolineato, ecc.)
Questo rende l'espressione da valutare di colore rosso:

(trace-highlight "\027[0;31m" "\027[0;0m") ;red text color

Questo usa il colore verde:

(trace-highlight "\027[0;32m" "\027[0;0m")

Questo rende l'espressione di colore negativo:

(trace-highlight "\027[0;7m" "\027[0;0m")  ;negative

Nota: \027 = ESC

Nota: per attivare i codici ANSI in windows 10 occorre creare nella chiave di registro [HKEY_CURRENT_USER\Console] la variabile "VirtualTerminalLevel" di tipo DWORD e porre il suo valore a 1 (uno).
Dal prompt della console (cmd.exe):
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1
Per disattivare i codici ANSI impostare il valore della variabile "VirtualTerminalLevel" a 0 (zero).

Se il terminale non supporta i codici ANSI, allora potete modificare solo il prompt con dei caratteri:

(trace-highlight ">>>" "<<<")

Potete inserire questo comando nel file init.lsp che viene eseguito quando eseguiamo newLISP.

Per fare un esempio definiamo una funzione ricorsiva che calcola la potenza di un numero x^n:

(define (expn x n)
  (if (= n 0) 1 (mul x (expn x (- n 1))))
)

(expn 3 3)
;-> 27

Per fare il debug di una funzione attiviamo la funzione "trace":

(trace true)

(trace (expn 2 3))

(define (expn x n)
  #(if (= n 0) 1 (mul x (expn x (- n 1))))#
)

[-> 2 ] s|tep n|ext c|ont q|uit >

Vediamo come interpretare l'output:

L'espressione attualmente tracciata (cioè quella in attesa di valutazione) e' quella compresa tra i caratteri "#" e "#":

 #(if (= n 0) 1 (mul x (expn x (- n 1))))#

[-> 2]: indica la direzione (avanti o indietro) e il numero della chiamata

s|tep: valuta ogni subespressione dell'espressione e si ferma

n|ext: valuta tutta l'espressione e si ferma

c|ont: valuta tutte le espressioni della funzione fino al termine

q|uit: esce dal comando "trace"

Nota: Durante il tracciamento, l'espressione tracciata cambia a seconda delle scelte dell'utente.

Per disabilitare la funzione "trace" occorre chiamarla con un valore nil:

(trace nil)

La funzione "debug" è una semplificazione dell'uso di "trace". Passiamo la funzione da tracciare a "debug" che si occupa di attivare e terminare la sessione di debug:

(debug (expn 2 3))

-----

(define (expn x n)
  #(if (= n 0)
   1
   (mul x (expn x (- n 1))))#)


[-> 3 ] s|tep n|ext c|ont q|uit >

L'output nella console mostra cosa ha appena fatto all'ultimo clic.
Ad esempio se inizia con:

[<- ... ]

significa che è appena uscito dalla espressione evidenziata con l'ultimo clic.

Se appare:

[-> ..]

significa che è appena entrato nella espressione evidenziata.

Vediamo una sessione completa di debug con delle funzioni annidate. Definiamo le funzioni "pari" e "dispari" (in stile LISP):

(define (pari n)
  (if (= n 0) true (dispari (- n 1)))
)

(define (dispari n)
  (if (= n 0) nil (pari (- n 1)))
)

(pari 8)
;-> true

(dispari 11)
;-> true

(pari 11)
;-> nil

(dispari 8)
;-> nil

Per fare il debug (tracciamento) della funzione pari dobbiamo attivare la funzione "trace" e poi chiamare la funzione da tracciare (oppure (debug (pari 3))):

(trace true)
;-> true

(pari 3)

-----

(define (pari n)
  #(if (= n 0)
   true
   (dispari (- n 1)))#)

[-> 2 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if #(= n 0)#
   true
   (dispari (- n 1))))

[-> 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if #(= n 0)#
   true
   (dispari (- n 1))))

RESULT: nil ; risultato dell'espressione: (= n 0)

[<- 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  (if (= n 0)
   true
   #(dispari (- n 1))#))

[-> 3 ] s|tep n|ext c|ont q|uit >

n

(define (pari n)
  (if (= n 0)
   true
   #(dispari (- n 1))#))

RESULT: nil ; risultato dell'espressione: (dispari (- n 1))

[<- 3 ] s|tep n|ext c|ont q|uit >

s

(define (pari n)
  #(if (= n 0)
   true
   (dispari (- n 1)))#)

RESULT: nil

[<- 2 ] s|tep n|ext c|ont q|uit >

c

;-> nil

Questo è il risultato finale della funzione (il numero 3 non è pari) e la sessione di debug è terminata.

Durante il debug possiamo usare la REPL per verificare il valore delle variabili, scrivere funzioni o altro codice necessario (si consiglia di non ridefinire la funzione attualmente in fase di debug).

Vediamo un altro esempio:

(define (conta n)
  (dotimes (i n)
    (setq somma (+ somma i))
    (println n))
)

(debug (conta 5))

-----

(define (conta n)
  #(dotimes (i n)
   (setq somma (+ somma i))
   (println n))#)

[-> 3 ] s|tep n|ext c|ont q|uit >

s ; valuta (dotimes (i n) --> dotimes (0 5)) e avanza alla prossima subespressione

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

[-> 4 ] s|tep n|ext c|ont q|uit >

s; valuta (somma) e avanza alla prossima subespressione

(define (conta n)
  (dotimes (i n)
   (setq somma #(+ somma i)#)
   (println n)))

[-> 5 ] s|tep n|ext c|ont q|uit >

s ; valuta il risultato della subespressione

(define (conta n)
  (dotimes (i n)
   (setq somma #(+ somma i)#)
   (println n)))

RESULT: 0 ; risultato di (+ somma i)

[<- 5 ] s|tep n|ext c|ont q|uit >

i ; vediamo il valore di i
;-> 0

[<- 5 ] s|tep n|ext c|ont q|uit >

s ; la subespressione è stata valutata quindi valuta l'intera espressione

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

RESULT: 0 ; risultato di (setq somma (+ somma i))

[<- 4 ] s|tep n|ext c|ont q|uit >

s ;

(define (conta n)
  (dotimes (i n)
   (setq somma (+ somma i))
   #(println n)#))

RESULT: 0

[<- 4 ] s|tep n|ext c|ont q|uit >

s ; avanza alla prossima espressione da tracciare

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

[-> 4 ] s|tep n|ext c|ont q|uit >

n ; valuta tutta l'espressione attiva (valutando tutte le subespressioni)

(define (conta n)
  (dotimes (i n)
   #(setq somma (+ somma i))#
   (println n)))

RESULT: 1 ; risultato di (setq somma (+ somma i))

[<- 4 ] s|tep n|ext c|ont q|uit >

i ; vediamo il valore di i
;-> 1

[<- 4 ] s|tep n|ext c|ont q|uit >

n ; valuta tutta l'espressione che segue
;-> 5

(define (conta n)
  (dotimes (i n)
   (setq somma (+ somma i))
   #(println n)#))

RESULT: 5 ; risultato di (println n)

[<- 4 ] s|tep n|ext c|ont q|uit >

c ; valuta tutta la funzione fino al termine
;-> 5
;-> 5
;-> 5
;-> 5
;-> 5

Occorre fare molta pratica per utilizzare proficuamente il debugger.

Nota: Poichè il debugger usa i caratteri "s", "n", "c" e "q" come tasti scorciatoia per le azioni di "s|tep n|ext c|ont q|uit" è consigliabile non usare questi caratteri come nomi delle variabili nelle funzioni (altrimenti sulla REPL dovreste usare "print" per conoscere il loro valore).

Per fare il debug di un file (es. test.lsp) possiamo scrivere:

(debug (load "test.lsp"))

In questo caso il file deve terminare con delle espressioni che devono essere valutate immediatamente appena il file viene caricato. In altre parole, il file deve terminare con una chiamata di funzione.

Al fine di evitare la valutazione completa di una funzione, possiamo inserire il comando trace all'interno della funzione stessa. In questo modo il debug può essere attivato nel punto desiderato.
Vediamo un modo per far partire il debug a metà di un ciclo. Prima salvate le seguenti linee di codice in un file (es. test-debug.lsp)

(setq i 0)

(define (f1) (inc i))

(define (f2)
  (dotimes (x 100)
    (f1)
    (if (= i 50) (trace true))))

(f2)

Poi eseguite dalla console:

(load "test-debug.lsp")

-----

(define (f1)
  (inc i))

[-> 5 ] s|tep n|ext c|ont q|uit >

i
;-> 50

[-> 5 ] s|tep n|ext c|ont q|uit >

(setq i 60) ; possiamo anche modificare il valore di i
;-> 60

[-> 5 ] s|tep n|ext c|ont q|uit > n

(define (f1 ) (inc i))

RESULT: 61

[<- 5 ] s|tep n|ext c|ont q|uit >

Come potete notare il tracciamento appare quando i vale 50 (che abbiamo verificato visualizzando il valore di i).

Il debugger non visualizza i commenti che si trovano nelle funzioni. Per fare apparire un testo durante la sessione di debug possiamo utilizzare il marcatore [text] [/text]:

(define (f1)
  [text]Questo testo appare nel debugger.[/text]
  ; Questo testo non appare nel debugger.
  (inc i))

Nota: modificare la funzione di cui si sta effettuandoo il debug genera sempre un crash della REPL.

Durante il debug di un contesto, per evitare la visualizzazione dei nomi di contesto prima dei simboli, passare prima al contesto nella console.

Supponiamo di avere il seguente programma

(context 'MYCONTEXT)

(definire (test a b c)
   ...
   ...
)
(context 'PRINCIPALE)

Nella console passare a MYCONTEXT con:

(context 'MYCONTEXT)

Ora apri la finestra del debugger e nella console digita:

MYCONTEXT> (debug (test 1 2 3))

Il debugger viene sempre eseguito dal contesto della console.

Per finire riportiamo la traduzione del manuale di riferimento delle funzioni "trace", "trace-highlight" e "debug".

Funzione DEBUG
--------------
sintassi: (debug func)

Chiama la funzione "trace" e inizia la valutazione della funzione definita dall'utente "func".
"debug" è una scorciatoia per eseguire (trace true) ed entrare nella funzione da tracciare ("func").

; Invece di digitare...
(trace true)
(my-func a b c)
(trace nil)

; Possiamo utilizzare "debug"...
(debug (my-func a b c))

Durante il tracciamento con "trace" o "debug" i messaggi di errore vengono stampati. La funzione che ha causato l'eccezione ritorna zero o nil e l'esecuzione continua. In questo modo le variabili e lo stato del programma può essere ispezionato durante il debugging.

Funzione TRACE
--------------
sintassi: (trace int-device)
sintassi: (trace true)
sintassi: (trace nil)
sintassi: (trace)

Nella prima sintassi il parametro è un intero associato ad un dispositivo (es. un file aperto). L'output viene scritto continuamente su quel dispositivo. Se "int-device" vale 1, allora l'output è scritto su stdout.

; write all entries and exits from expressions to trace.txt
(trace (open "trace.txt"))

; write all entries and exits from expressions to trace.txt
(foo x y)
(bar x)

; close the trace.txt file
(trace nil)

Nella seconda sintassi il debugger diviene attivo quando il parametro vale true.
In modalità di debug newLISP si arresta all'ingresso e all'uscita di ogni espressione e attende eventuali input dell'utente.
L'espressione attiva viene visualizzata tra due caratteri "#" (number sign). I caratteri possono essere modificati con la funzione "trace-highlight".
Ad ogni prompt del debugger:

[-> 2] s|tep n|ext c|ont q|uit >

possiamo inserire "s", "n", "c" o "q" per proseguire la valutazione in modi diversi (es. valutare ogni subespressione o valutare tutta l'espressione). Al prompt possiamo anche inserire una espressione qualsiasi da valutare. Ad esempio se inseriamo il nome di una variabile, allora verrà restituito il suo valore. In questo modo possiamo verificare il contenuto delle variabili e possiamo anche modificarlo.

; Imposta newLISP in modalità di debug
(trace true)
;-> true

; il debugger mostra ogni passo
(my-func a b c)

; Imposta newLISP in modalità normale (esce dalla modalità di debug)
(trace nil)
;-> nil

Per inserire dei break point dove newLISP dovrebbe interrompere l'esecuzione normale del programma ed entrare in modalità di debug, possiamo inserire l'espression (trace true) prima delle espressioni che devono essere tracciate.
To set break points where newLISP should interrupt normal execution and go into debugging mode, put
(trace true) statements into the newLISP code where execution should switch on the debugger.
Puoi usare la funzione "debug" come scorciatoia per l'esempio sopra:

(debug (my-func a b c))

La terza sintassi chiude la modalità di debug o il file usato per il tracciamento.

La quarta e ultima sintassi riporta il valore corrente della modalità di debug (true o nil).

Funzione TRACE-HIGHLIGHT
------------------------
sintassi: (trace-highlight str-pre str-post [str-header str-footer])

Imposta i caratteri o la stringa di caratteri che racchiude l'espressione attiva durante il tracciamento. Il valore di default che racchide l'espressione è "#" (number sign). Questo può essere cambiato con una stringa lunga fino a sette caratteri. Se il tterminale accetta caratteri di controllo (ANSI sequenze di Esc), possiamo utilizzarli per cambiare il colore dell'espressione, visualizzarla in grassetto o reverse, ecc.
Due ulteriori stringhe opzionali "str-header" e "str-footer" che controllano il separatore e il prompt del debugger. Un massimo di 15 caratteri è consentito per "str-header" e 31 caratteri per "str-footer".

;; l'espressione attiva è racchiusa con ">>" e "<<"
(trace-highlight ">>" "<<")

;; colore brillante ('bright') su terminali VT-100 o compatibili
(trace-highlight ">>\027[1m" "\027[0m")

Nota: looks like old "print" function never dies.

Nota: newLISP compiles source code to an internal lisp-cell-expression based binary format. There is no easy way to supply line numbers without inflating memory usage considerably (similar to 'debug' builds in 'C').

Un ottimo libro sul processo di debugging è "Why Programs Fail" di Andreas Zeller:

Indice
 1) How Failures Come To Be
 Your program fails. How can this be?
 The answer is that the programmer created a defect in the code.
 When the code is executed, the defect causes an infection in the program state, which later becomes visible as a failure.
 To find the defect, one must reason backward, starting with the failure.
 2) Tracking Problems
 3) Making Programs Fail
 4) Reproducing Problems
 5) Simplifying Problems
 6) Scientific Debugging
 7) Deducing Errors
 8) Observing Facts
 9) Tracking Origins
10) Asserting Expectations
11) Detecting Anomalies
12) Causes and Effects
13) Isolating Failure Causes
14) Isolating Cause–Effect Chains
15) Fixing the Defect
16) Learning from Mistakes


============================================================================
 newLISPdoc - Il programma per la documentazione newLISP
============================================================================

I commenti nei file sorgenti di newLISP possono essere convertiti in documentazione HTML utilizzando solo pochi tag nei commenti. Il sistema newLISPdoc è progettato per utilizzare un minimo di tag e lasciare ancora leggibili i commenti con tag.

newLISPdoc genera anche una pagina indice per tutti i file sorgente newLISP generati.

Potete leggere il sorgente del file "newLISPdoc" nella cartella "util" dell'installazione di newLISP ((es. c:\newlisp\util). Il programma e questa documentazione fanno anche parte della distribuzione di newLISP dalla versione 9.0. Poiché l'evidenziazione della sintassi di newLISP versione 9.1 è integrata in newlispdoc, che è installato nella stessa cartella del programma eseguibile newLISP. Lo script syntax.cgi è ancora disponibile per le installazioni di siti Web, ma non è più necessario per newLISPdoc.

Utilizzo
Dall'interno della cartella in cui si trovano i tuoi moduli, eseguire "newlispdoc" dalla linea di comando passando tutti i nomi dei file dei moduli. Ad esempio, per elaborare i file mysql.lsp, odbc.lsp e sqlite3.lsp eseguire:

Linux, OSX:
newlispdoc mysql.lsp odbc.lsp sqlite.lsp

Windows:
newlisp newlispdoc mysql.lsp odbc.lsp sqlite.lsp

Questo genera i file index.html, mysql.lsp.html, odbc.lsp.html e sqlite.lsp.html tutti nella stessa cartella da dove è stato eseguito il comando. La pagina index.html contiene i collegamenti a tutte le altre pagine.

Se la cartella di lavoro contiene il file newlispdoc.css, l'output HTML verrà formattato di conseguenza. Per un esempio, consultare il file "util/newlispdoc.css" nella cartella di installazione.

Possiamo usare il flag -s della riga di comando per generare anche file HTML separati con evidenzazione dei sorgenti e inserire un collegamento alla versione evidenziata del file nella pagina della documentazione:

newlispdoc -s mysql.lsp odbc.lsp sqlite.lsp
newlispdoc -s *.lsp

Il flag -d fornisce un collegamento per il download dei sorgenti originali:

Linux, OSX:
newlispdoc -d *.lsp
newlispdoc -s -d *.lsp

È possibile fornire una o entrambe le opzioni.

Windows:
newlisp newlispdoc -s mysql.lsp odbc.lsp sqlite.lsp

Possiamo specificare anche la posizione del file sorgente con un indirizzo URL. Ciò consente l'indicizzazione e la documentazione di sorgenti newLISP distribuiti su diversi siti:

Linux, OSX:
newlispdoc -url file-with-urls.txt
newlispdoc -s -url file-with-urls.txt

Windows:
newlisp newlispdoc -url file-with-urls.txt
newlisp newlispdoc -s -url file-with-urls.txt

L'indirizzo URL può utilizzare http:// e file://
Come per i singoli file, l'opzione -s può essere specificata per generare anche file sorgente con sintassi evidenziata. Un file URL contiene un URL per riga. Non sono consentite altre informazioni nel file. Di seguito è riportato un file URL di esempio:

http://asite.com/code/afile.lsp
http://othersite.org/somefile.lsp
file:///usr/home/joe/program.lsp

L'ultima riga mostra un URL di file locale.

Tutti i file generati verranno scritti nella cartella corrente.

Lista "tag"
-----------

I tag hanno la seguente sintassi:

;; @<tag-name>

Con le seguenti funzionalità:

;; @module una parola per il nome del modulo
;; @index Titolo e URL per la pagina indice
;; @description una riga per la descrizione del modulo
;; @location la posizione dell'URL originale del file sorgente
;; @version una riga per le informazioni sulla versione
;; @author una riga per le informazioni sull'autore
;; @syntax una riga per il modello di sintassi (syntax pattern)
;; @param una riga per il nome e la descrizione del parametro
;; @return una riga per descrizione del risultato (output)
;; @example esempio di codice multilinea a partire dalla riga successiva

L'unico tag richiesto è il tag @module o in alternativa il tag @index. Se nessuno di questi tag è presente nel file, allora non verrà elaborato. Tutti gli altri tag sono opzionali. Solo le righe che iniziano con ";;" (2 punti e virgola) vengono elaborate. Il testo del commento del programma che non dovrebbe apparire nella documentazione dovrebbe iniziare con un solo punto e virgola.

La descrizione di una riga del tag @description verrà inserita sotto il nome del modulo nella pagina dell'indice e del documento del modulo.

Una funzione può avere più tag @syntax ciascuno su righe consecutive.

Quello che segue è l'unico tag, che può essere incorporato ovunque nel testo. Tra la specifica e la descrizione del collegamento tag c'è esattamente uno spazio:

@link link descrizione

Tag personalizzati possono essere creati semplicemente anteponendo il nome personalizzato con una @. Il testo dopo il tag personalizzato verrà tradotto come al solito, ad es. può contenere un tag @link. Come nella maggior parte degli altri tag, il testo da inserire è limitato alla stessa riga.

Tutte le parole tra <...> (parentesi angolari) sono visualizzate in corsivo. Internamente newLISPdoc utilizza i tag <em>, </em> per la formattazione. Dovrebbero essere utilizzati per le specifiche dei parametri dopo il tag @param e nel testo che si riferisce a tali parametri.

Tutte le parole tra virgolette singole '...' sono stampate in monospace. Internamente newLISPdoc utilizza i tag <tt>, </tt> per la formattazione.

Tutte le altre righe che iniziano con 2 punti e virgola contengono testo descrittivo. Una riga vuota con solo 2 punti e virgola all'inizio è un'interruzione tra paragrafi di testo.

Le righe che non iniziano con 2 punti e virgola vengono ignorate da newLISPdoc. Ciò consente di scrivere commenti sul codice con un solo punto e virgola.

Se è richiesta una formattazione maggiore di quella offerta da newLISPdoc, è possibile utilizzare anche i seguenti semplici tag HTML e i relativi moduli di chiusura: <h1>, <h2>, <h3>, <h4>, <i>, <em>, <b>, <tt>, <p>, <br>, <pre>, <center>, <blockquote> e <hr>.

Collegamento ad altre raccolte di moduli
----------------------------------------
newLISPdoc genera e indicizza la pagina per tutti i moduli documentati. È possibile utilizzare un tag speciale @index per mostrare un collegamento nella pagina dell'indice a un indice di altre raccolte di moduli. In questo modo è possibile creare indici multilivello dei moduli. Per visualizzare un collegamento a un'altra raccolta di moduli nella pagina dell'indice, creare un file contenente il tag @index e il tag @description nel modo seguente:

; - other-collection.txt -
;; @index OtherCollection http://example.com/modules
;; @description Modules from OtherCollection

Utilizzare uno o più di questi file nella riga di comando newLISPdoc come qualsiasi altro file di origine:

newlispdoc -s other-collection.txt *.lsp

Questo mostrerà la voce di indice per OtherCollection sull'indice del modulo prima di elencare tutti i moduli in *.lsp.

Esempi

Quella che segue è il sorgente commentato del programma newLISP di esempio:

;; @syntax (example:foo <num-repeat> <str-message>)
;; @param <num-repeat> The number of times to repeat.
;; @param <str-message> The message string to be printed.
;; @return Returns the message in <str-message>
;;
;; The function 'foo' repeatedly prints a string to
;; standard out terminated by a line feed.
;;
;; @example
;; (example:foo 5 "hello world")
;; =>
;; "hello world"
;; "hello world"
;; "hello world"
;; "hello world"
;; "hello world"

(context 'example)

(define (foo n msg)
  (dotimes (i n)
    (println msg))
)

;; See the @link http://example.com/example.lsp source .

Di seguito vengono riportate le pagine "example.lsp.html" e "index.html" generate:

"example.lsp.html"
-------------------------------------------------
Module index(link)

Module: example.lsp
Author: John Doe, johndoe@example.com
Version: 1.0

This module is an example module for the newlispdoc program, which generates automatic newLISP module documentation.

                        - § -

Syntax: (example:foo num-repeat str-message)

parameter: num-repeat - The number of times to repeat.
parameter: str-message - The message string to be printed.

return: Returns the message in str-message

The function foo repeatedly prints a string to standard out terminated by a line feed.

example:
 (example:foo 5 "hello world")
 =>
 "hello world"
 "hello world"
 "hello world"
 "hello world"
 "hello world"

See the source(link).
-------------------------------------------------

"index.html"
-------------------------------------------------
        Index
Module: example.lsp(link)
foo(link)
-------------------------------------------------

Quando viene specificato più di un modulo sulla riga di comando, la pagina dell'indice mostrerà una riga di collegamento per ciascun modulo.


============================================================================
 Compilare i sorgenti di newLISP
============================================================================

In questa appendice vediamo i passi necessari per compilare newLISP con windows 10 partendo dai sorgenti. In particolare compileremo la versione di newLISP a 64 bit con estensioni UTF8 e FFI.

Scaricare i sorgenti di newLISP (newLISP-10.7.5.tgz) da:

http://www.newLISP.org/downloads/development/inprogress/

Attualmente la versione è la 10.7.5

Scompattare il file nella cartella: c:\newLISP-10.7.5

Scaricare il compilatore gcc 5.1 "TDM64 Bundle" da: http://tdm-gcc.tdragon.net/

Installare il programma nella cartella: c:\TDM-GCC-64

Scaricare la libreria "libffi" versione 3.2.1 (precompilata per windows) da:

https://proj.goldencode.com/downloads/libffi/libffi_3.2.1_prebuilt_mingw_4.9.0_64bit.zip

Scompattare il file nella cartella: c:\newLISP-10.7.5\libffi-3.2.1-prebuilt_mingw490_64bit

Copiare i file "libffi.a" e "libffi.dll.a" "libffi-6.dll" nella cartella:

c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\

(c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\libffi.a)
(c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\libffi.dll.a)
(c:\TDM-GCC-64\lib\gcc\x86_64-w64-mingw32\5.1.0\libffi-6.dll)

Adesso dobbiamo modificare un makefile che si trova nella cartella dei sorgenti.

Spostarsi nella cartella c:\newLISP-10.7.5 e aprire il file "makefile_mingw64dll_utf8_ffi" con un editor di testo.

Sostituire la riga:   $(CC) -m64 -shared *.o -Wl,--kill-at -lffi -lws2_32 -o newLISP.dll
Con la riga:          $(CC) -m64 -shared $(OBJS) -Wl,--kill-at -lffi -lws2_32 -o newLISP.dll

Salvare e chiudere il makefile.

Aprire una finestra DOS (command prompt - cmd.exe) e dalla cartella dei sorgenti digitare:

make -f makefile_mingw64_utf8_ffi

Oppure, mingw32-make -f makefile_mingw64_utf8_ffi

Se tutto va bene, dopo alcuni secondi avrete il vostro file "newLISP.exe" insieme a diversi altri file che hanno estensione ".o".
Adesso occorre copiare il file "libffi-6.dll"

Prima di creare la dll di newLISP dobbiamo eliminare tutti i file ".o" che sono stati creati.

Una volta eliminati i file ".o" digitare:

make -f "makefile_mingw64dll_utf8_ffi"

Questa volta avrete il vostro file "newLISP.dll" insieme a diversi altri file che hanno estensione ".o".

Cancellate i file ".o" e copiate "newLISP.exe" e "newLISP.dll" nella cartella che preferite (la cartella deve trovarsi nella variabile di ambiente PATH).

Complimenti, avete creato la vostra versione di newLISP !!!

Nota: nelle versioni ffi di newLISP occorre copiare la libreria "libffi-6.dll" nella cartella dove si trova newLISP.exe e newLISP.dll

Nota: l'installazione completa di newLISP comprende anche altri file. Comunque questi file devono semplicemente essere copiati dalla cartella dei sorgenti (moduli, manuali, util, ecc.).
Puoi vedere la cartella dove è installato newLISP per capire quali file sono necessari.

Nota: In questo modo abbiamo solamente installato la REPL di newLISP, tralasciando la versione GUI.


============================================================================
 Ricorsione e ottimizzazione della chiamata di coda (Tail Call Optimization)
============================================================================

Questo è un concetto molto importante quando utilizziamo funzioni ricorsive.
Parliamo di "ottimizzazione della chiamata di coda" (TCO - Tail Call Optimization) quando è possibile evitare di allocare un nuovo stack frame per una funzione poichè la funzione chiamante restituirà semplicemente il valore che ottiene dalla funzione chiamata.
L'uso più comune è la "ricorsione in coda" (tail recursion), quando una funzione ricorsiva è in grado di utilizzare una dimensione costante dello stack.

Scheme (o Javascript ES6) è uno dei pochi linguaggi che garantisce nelle specifiche di essere in grado di effettuare questa ottimizzazione.
Vediamo due esempi in Scheme (con sintassi newLISP)

(define (fact x)
  (if (= x 0) 1
      (mul x (fact (- x 1)))))

(fact 10)
;-> 3628800

(fact 2500)
;-> ERR: call or result stack overflow

(define (fact x)
  (define (fact-tail x accum)
    (if (= x 0) accum
      (fact-tail (- x 1) (mul x accum))))
  (fact-tail x 1))

La prima funzione non ha la ricorsione di coda perchè quando viene effettuata la chiamata ricorsiva la funzione deve tenere traccia della moltiplicazione necessaria per ottenere il risultato dopo che è ritornata la chiamata.
Quindi lo stack è simile al seguente:

(fact 3)
(* 3 (fact 2))
(* 3 (* 2 (fact 1)))
(* 3 (* 2 (* 1 (fact 0))))
(* 3 (* 2 (* 1 1)))
(* 3 (* 2 1))
(* 3 2)
6

In contrasto lo stack per la seconda funzione si comporta nel modo seguente:

(fact 3)
(fact-tail 3 1)
(fact-tail 2 3)
(fact-tail 1 6)
(fact-tail 0 6)
6

Come puoi vedere, abbiamo soltanto bisogno di memorizzare la stessa quantità di dati per ogni chiamata perchè dobbiamo semplicemente restituire il valore che otteniamo dalla chiamata superiore. Questo significa che anche la chiamata (fact 1000000) ha bisogno della stessa quantità di spazio della chiamata (fact 3).
Questo non accade nelle funzioni senza ottimizzazione della chiamata di coda (non-tail recursive), infatti valori elevati dell'argomento possono causare l'errore di esaurimento dello stack (stack overflow).

A rigor di termini, l'ottimizzazione della chiamata di coda non sostituisce necessariamente lo stack frame del chiamante con i chimati, ma, piuttosto, garantisce che un numero illimitato di chiamate nella posizione di coda richieda solo una quantità limitata di spazio.

In altre parole la TCO (Tail Call Optimization) è il processo mediante il quale un compilatore intelligente può effettuare una chiamata a una funzione e non occupare ulteriore spazio di stack. L'unica situazione in cui ciò accade è se l'ultima istruzione eseguita in una funzione f è una chiamata a una funzione g (Nota: g può essere f). Il punto è che f non ha più bisogno di spazio nello stack - semplicemente chiama g e restituisce qualsiasi cosa restituisca g. In questo caso si può fare l'ottimizzazione: la funzione g viene eseguita e ritorna il suo valore a quello che ha chiamato f.

Questa ottimizzazione può far sì che le chiamate ricorsive occupino uno spazio di stack costante, anziché facciano esplodere lo stack.

Esempio: questa funzione fattoriale non è TCOttimizzabile:

def fact(n):
    if n == 0:
        return 1
    return n * fact(n-1)

Questa funzione fa anche altre cose oltre a chiamare un'altra funzione nella sua ultima istruzione (dichiarazione di ritorno).

Esempio: questa funzione fattoriale non è TCOttimizzabile:

def fact_h(n, acc):
    if n == 0:
        return acc
    return fact_h(n-1, acc*n)

def fact(n):
    return fact_h(n, 1)

Questo perché l'ultima istruzione in una di queste funzioni è la chiamata un'altra funzione.
Il TCO riguarda l'ottimizzazione dello spazio utilizzato nello stack di chiamate (da O(n) a costante).

Purtroppo newLISP non supporta Tail Call Optimization (TCO), ma è possibile superare il problema dell'esplosione dello stack delle funzioni ricorsive tramite la tecnica di "memoization".
Questa tecnica viene spiegata nell'articolo "Advanced Recursion in newLISP":
https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newLISP.html di Krzysztof Kliś che trovate tradotto più avanti.

Lutz:
-----
Regarding "tail call optimization":

Tail call optimization is good if you prefer expressing algorithms via recursion versus iteration. But speed performance wise iteration can be implement more efficiently compared to tail recursion optimization, which usually is implemented using continuations.

The paradox about tail recursion optimization is, that you can only optimize the tail part of the recursion, which at the same time is the part easy to express or transform into iteration (because it is the last call in the function).

In the end tail-recursion-optimization versus iteration comes down to a programmer preference of rather using one versus the other method when expressing algorithms.


============================================================================
 F-expression - FEXPR
============================================================================

Nei linguaggi di programmazione Lisp, una FEXPR è una funzione i cui operandi/parametri vengono passati ad essa senza essere valutati. Quando viene chiamato una FEXPR, viene valutato solo il corpo di FEXPR: non si effettuano altre valutazioni se non quando esplicitamente avviato/richiesto dalla FEXPR.

Al contrario, quando viene chiamata una normale funzione Lisp, gli operandi vengono valutati automaticamente e solo i risultati di queste valutazioni vengono passati alla funzione.

Quando viene chiamata una macro Lisp (tradizionale), gli operandi vengono passati in modo non valutato, ma qualunque sia il risultato ritornato dalla macro, questo viene valutato automaticamente.

Nel rigoroso utilizzo originale, una FEXPR è quindi una funzione definita dall'utente i cui operandi vengono passati senza essere valutati. Tuttavia, nell'uso successivo, il termine FEXPR descrive qualsiasi funzione di prima classe/ordine i cui operandi vengono passati non valutati, indipendentemente dal fatto che la funzione sia primitiva o definita dall'utente.

Il supporto delle Fexpr è continuato in Lisp 1.5, l'ultimo dialetto sostanzialmente standard di Lisp prima che si frammentasse in più linguaggi. Negli anni '70, i due linguaggi dominanti, MacLisp e Interlisp, supportarono entrambi le fexprs.

Alla conferenza del 1980 sul Lisp e la programmazione funzionale, Kent Pitman presentò un documento "Special Forms in Lisp" in cui discuteva dei vantaggi e degli svantaggi delle macro e delle fexprs e, infine, condannò le fexprs. La sua obiezione centrale era che, in un dialetto di Lisp che consente fexprs, l'analisi statica non può determinare in generale se un operatore rappresenti una funzione ordinaria o un fexpr - pertanto l'analisi statica non può determinare se gli operandi saranno valutati o meno. In particolare, il compilatore non può dire se una sottoespressione può essere ottimizzata in modo sicuro, poiché la sottoespressione potrebbe essere trattata come dati non valutati in fase di esecuzione.

"Le MACRO offrono un meccanismo adeguato per specificare definizioni di moduli speciali e ... le FEXPR no. ... Si suggerisce che, nella progettazione dei futuri dialetti del Lisp, si dovrebbe prendere in seria considerazione la proposizione che le FEXPR dovrebbero essere del tutto escluse dal linguaggio"
Kent M. Pitman, "Special Forms in Lisp", Proceedings of the 1980 ACM Conference on Lisp and Functional Programming, 1980, pag. 179–187.

Le macro di newLISP sono FEXPR. Perchè?

Il problema evidenziato da Pitman è valido solo per i linguaggi compilati, infatti nei linguaggi interpretati (come newLISP) le fexpr non hanno effetti indesiderati, anzi rendono la meta-programmazione più semplice ed elegante.

Con le fexpr viene aggiunta "generalità" al linguaggio, in quanto permette di trattare i più importanti elementi del Lisp come oggetti di prima classe durante il runtime.

Per un'analisi approfondita potete consultare l'articolo "On Pitman's 'Special Forms in Lisp'" di Kazimir Majorinc all'indirizzo:

http://kazimirmajorinc.com/Documents/On-Pitmans-Special-forms-in-Lisp/index.html

Riportiamo le conclusioni dell'articolo citato sopra:

"Sebbene l'articolo di Pitman contenga un numero di argomenti validi, inclusi alcuni a favore delle fexprs, tre argomenti importanti sembrano essere stati omessi:

1. Lisp con fexprs ha una semantica più semplice, più regolare ed espressiva di Lisp con funzioni, con o senza macro.

2. L'esistenza di fexprs espandibili simili a macro non è riconosciuta. Per ogni macro esiste un equivalente fexpr espandibile simile a una macro con le stesse proprietà desiderabili. In particolare, se viene applicata una semplice ottimizzazione di fexprs espandibili, per ogni programma che utilizza macro esiste un programma equivalente altrettanto veloce che utilizza fexprs.

3. In alcuni casi, i programmi che usano fexprs sono molto più veloci dei programmi che usano macro.

Queste affermazioni costituiscono un valido motivo per i fexprs, in particolare perché uno dei principali argomenti contro i fexprs era la loro influenza sulla velocità dei programmi."


============================================================================
 newLISP - Lisp per tutti (Krzysztof Kliś)
============================================================================

Traduzione dell'articolo "newLISP - Lisp for the masses" di Krzysztof Kliś

https://weblambdazero.blogspot.com/2010/06/newLISP-lisp-for-masses.html

Esiste un detto popolare tra gli hacker Lisp: pianta un albero, scrivi un libro e crea un dialetto personale del Lisp. Sebbene non ci siano in giro molti Lisp popolari (persino il Common Lisp non è mai stato usato in maniera massiccia) sembra proprio che nel caso di varie distribuzioni Linux, spesso "di più" significa semplicemente "migliore". Un buon esempio di questa storia di successo è Clojure, e adesso arriva un altro candidato a prendere il comando.
newLISP è un dialetto moderno del Lisp, progettato da Lutz Mueller per essere (come dice lui stesso) "veloce da imparare e per finire il lavoro". Devo dire che questa frase non potrebbe essere più vera - risolvere il problema 10 di ProjectEuler (trovare la somma di tutti i numeri primi sotto 2 milioni) dopo soli due giorni di manipolazione con newLISP mi ci sono voluti meno di 3 minuti, tra cui progettazione, scrittura, test per eseguire il seguente codice:

(println (apply + (filter (fn (n) (= 1 (length (factor n)))) (sequence 2 2000000))))

Nonostante sia un linguaggio interpretato, i programmi creati con newLISP girano in modo incredibilmente veloce. Il codice sopra è una soluzione che utilizza la forza bruta, ma viene eseguito in meno di 10 secondi su Core 2 Duo a 1,66 GHz (2931 ms su Core i5 3.4 GHz).
Tuttavia, la semplicità ha un prezzo. Se cerchi di utilizzare un approccio più sofisticato, come il classico setaccio di Eratostene, potresti rimanere un pò sorpreso:

(define (sieve seq out)
  (let ((n (first seq)))
    (setf seq (filter (fn (x) (!= 0 (mod x n))) seq))
    (push n out)
    (if (not seq) out (sieve seq out))))

(print (apply + (sieve (sequence 2 2000000))))

Con questa funzione, sebbene sia correttamente ricorsiva in coda, newLISP consuma rapidamente tutto lo stack oppure, se si fornisce abbastanza spazio per lo stack, consuma tutta la memoria disponibile. Questo avviene perché newLISP non ottimizza la ricorsione in coda. Se per qualche motivo non puoi convivere con questa limitazione, puoi comunque utilizzare il Common Lisp per implementare tali ricorsioni:

(defun range (min max) (loop for i from min to max collect i))

(defun sieve (seq &optional out)
  (let ((n (car seq)))
    (setf seq (delete-if #'(lambda (x) (= 0 (mod x n))) seq))
    (push n out)
    (if (not seq) out (sieve seq out))))

(print (apply #'+ (sieve (range 2 2000000))))

Come puoi vedere, il codice delle due funzioni 'sieve' è molto simile, quindi è abbastanza facile passare a newLISP se conosci il Common Lisp. Le differenze con altri dialetti Lisp sono ben documentate, così come il linguaggio stesso. La documentazione è un altro punto di forza di newLISP: puoi imparare come risolvere diversi problemi reali usando i "code patterns" di newLISP oppure curiosare tra i molti frammenti di codice interessanti.
Quello che personalmente apprezzo di newLISP rispetto ad altri Lisp è il suo piccolo ingombro (davvero minuscolo). È possibile creare un eseguibile standalone contenente il motore newLISP (circa 300kB) e il vostro programma con un semplice comando dal terminale:

newLISP -x "mycode.lsp" "mycode.exe"

Nonostante sia così piccolo, il nuovo LISP offre una sorprendente quantità di funzionalità "out of the box": espressioni regolari, networking TCP/IP (inclusi i protocolli FTP e HTTP), accesso a database (tramite librerie esterne), OpenGL, XML e gestione XML-RPC, matrici, statistica (comprese formule bayesiane), supporto per Unicode e un insieme di moduli C/C++ che ne estendono ancora di più le capacità.
newLISP supporta anche l'elaborazione parallela tramite le API Cilk-like e l'elaborazione distribuita tramite la funzione integrata "net-eval".
newLISP non è sicuramente un Nuovo Common Lisp, e in alcuni punti (come ad esempio la ricorsione di coda) è ancora inferiore. Ma newLISP è un esempio perfetto che nel settore IT: a volte peggio è meglio  (sometimes worse is better).

Commento di Kazimir Majorinc:
newLISP insiste sull'idea di "codice = dati" di più della maggior parte dei dialetti Lisp non attivamente sperimentati e attivamente mantenuti.

(1) A causa di alcuni motivi, newLISP sfrutta molto di più la funzione "eval" della maggior parte degli altri dialetti Lisp. Una delle ragioni è che "eval" è veloce, solo Eligis OpenLisp e Picolisp hanno delle funzioni "eval" ancora più veloci.

(2) newLISP ha uno ambito (scope) dinamico e non lessicale. L'ambito dinamico funziona meglio con la funzione "eval".
Per esempio,

(let ((x 1)) (eval 'x))

è legale nell'ambito dinamico e restituisce l'errore "x not defined" in ambito lessicale. Emacs Lisp, Picolisp e newLISP supportano l'ambito dinamico, CL supporta entrambi, altri dialetti supportano solo l'ambito lessicale.

(3) Le macro in newLISP sono in realtà di FEXPR: vale a dire qualcosa come macro del primo ordine (first-class) definite a runtime (durante l'esecuzione). A differenza delle macro, è possibile assegnare FEXPR come valori, applicate, mappate e utilizzate come dati durante il runtime. Le FEXPRS esistevano nelle prime implementazioni del Lisp, ma sono state abbandonate perché si supponeva che renderessero impossibili alcune ottimizzazioni del compilatore. Questa affermazione è, a mio avviso, fuorviante, ma è irrilevante per i linguaggi interpretati. Attualmente nessun altro dialetto Lisp supporta le fexprs. (newLISP supporta anche reader-macro e alcune macro tradizionali - ma attraverso librerie.)

(4) A differenza delle macro, FEXPRS collabora bene con "eval", quindi se il programma combina (fexprs o macros) ed "eval", è probabile che sarà molto più veloce in newLISP rispetto ad altri dialoghi Lisp.

(5) Funzioni e macro (es. FEXPRS) in newLISP sono *espressioni*, non i risultati della valutazione delle espressioni. Quindi, queste possono essere (comprese quelle anonime) analizzate e modificate durante il runtime.


============================================================================
 Ricorsione avanzata in newLISP (Krzysztof Kliś)
============================================================================

Traduzione dell'articolo "Advanced Recursion in newLISP" di Krzysztof Kliś

https://weblambdazero.blogspot.com/2010/07/advanced-recursion-in-newLISP.html

Nel precedente post su newLISP ho menzionato che non supporta l'ottimizzazione delle chiamate di coda. In realtà, molti Lisp non lo fanno. Come indicato da Bill Six, anche lo standard ANSI del Common Lisp non impone (a differenza dello Scheme) un'eliminazione delle chiamate di coda fornita dall'implementazione del linguaggio, anche se sembra che tutti i maggiori compilatori ANSI Common Lisp lo facciano comunque.

Mi chiedevo se esiste un modo per aggirare questo problema e la prima soluzione che ho trovato è stata l'utilizzo della macro "memoize" descritta nell'eccellente documentazione online di newLISP, "Code Pattern in newLISP":

(define-macro (memoize mem-func func)
  (set (sym mem-func mem-func)
    (letex (f func c mem-func)
      (lambda ()
        (or (context c (string (args)))
        (context c (string (args)) (apply f (args))))))))

È possibile applicare questa macro a qualsiasi funzione con qualsiasi numero di argomenti. Il trucco qui è che ogni volta che viene chiamata una funzione, il suo risultato viene scritto in memoria per un'altra chiamata. Questo può velocizzare enormemente la tua applicazione, e può essere osservato confrontando il tempo di esecuzione di queste funzioni di Fibonacci:

(define (fibo n)
  (if (< n 2) 1
    (+ (fibo (- n 1)) (fibo (- n 2)))))

(memoize fibo-m
  (lambda (n)
    (if (< n 2) 1
      (+ (fibo-m (- n 1)) (fibo-m (- n 2))))))

(time (fibo 35))
;-> 4479 msec
(time (fibo-m 35))
;-> 0.016

Sul mio portatile (fibo 35) impiega 12.98 secondi, mentre (fibo-m 35) viene eseguita in 0.016 millisecondi.

Sfortunatamente la macro memoize non può gestire la ricorsione reciproca. Un classico esempio di tale ricorsione appare come segue:

(define (f1 n)
  (println n)
    (if (= n 0)
      (println "Blastoff!")
      (f2 n)))

(define (f2 n)
  (f1 (- n 1)))

newLISP esaurisce rapidamente lo spazio dello stack se eseguiamo (f1 1000), per non parlare di numeri più grandi. Cosa succede se definiamo una versione "memoized" di f1 e f2 ? Vediamo:

(memoize f1
  (lambda (n)
    (println n)
    (if (= n 0)
      (println "Blastoff!")
      (f2 n))))

(memoize f2
  (lambda (n)
    (f1 (- n 1))))

Ancora una volta, l'esecuzione di (f1 1000) esaurisce immediatamente lo stack di newLISP.

Una soluzione a questo problema si ottiene utilizzando una tecnica chiamata "trampolining" (trampolino). Bill Clementson sul suo blog non solo ha spiegato in modo eccellente il concetto di usare i trampolini, ma ha anche fornito un'implementazione in Common Lisp, che è diventata la mia ispirazione per scrivere una versione in newLISP:

(define (trampoline fun arg)
  (catch
    (while true
      (let ((run (apply fun arg)))
        (setf fun (first run) arg (rest run)))) 'result)
  result)

Un trampolino esegue iterativamente i "thunk" [1] di codice restituiti da una funzione e in questo modo evita di far esplodere lo stack di applicazioni. Tuttavia, per utilizzare il trampolino, la funzione deve restituire la continuazione (un puntatore al passaggio successivo) anziché il valore. Di seguito è riportata una versione delle funzioni di cui sopra modificate per utilizzare il trampolino:

(define (f1 n)
  (println n)
  (if (= n 0)
    (throw "Blastoff!")
    (list f2 n)))

(define (f2 n)
  (list f1 (- n 1)))

Ora puoi testarlo con:

(trampoline f1 '(1000))
(trampoline f1 '(10000))
(trampoline f1 '(100000))
...

Buon divertimento!

[1]
Un "thunk" è una subroutine usata per iniettare un calcolo addizionale in un'altra subroutine. I thunk vengono principalmente utilizzati per ritardare un calcolo finché non è necessario il risultato o per inserire operazioni all'inizio o alla fine di un'altra subroutine. Può semplicemente essere pensato come una funzione che non accetta argomenti, in attesa di essere chiamata a fare il suo lavoro.


===================================
A Look at newLISP (Alexandru Lazar)
===================================

by Alexandru Lazar
2009-01-05

Working with newLISP is a fairly pleasant experience, although it does depend a lot on what you want to do with it. Although the developer tools are not very complex, nor very powerful, they are sufficient for typical scripting needs.

As mentioned earlier, newLISP comes with a very useful documentation. Unlike Hyperspec, which is extremely complete but rather unpleasant to work with, newLISP's documentation is a lot leaner and cleaner, although not as detailed. This is a double-edged sword. On one hand, if you are looking for the gory details of the implementation, you have to look at the source. On the other hand, the documentation works very well not only when working with newLISP, but also as a reference.

newLISP sports a reasonable IDE, which offers most of the things you would expect from it — a friendly syntax-highlighting editor and a REPL prompt (an interactive prompt which allows you to evaluate LISP expressions on the fly and to debug your program). Although it's quite far from being particularily complete, we should point out the fact that most other LISP dialects offer only one other alternative in the shape of Emacs and SLIME, ILM, ILISP and so on. Again, this is double-edged, although Emacs is a wonderful tool (and before burning me to the stake in the comments, my editor of choice), it is quite a turnoff for most beginners. There is a newLISP Emacs mode floating on the Internet, but it does not offer the same range of features as SLIME, meaning that seasoned Emacs and SLIME users will be left without their favorite LISP development environment. While it can be argued that the typical newLISP program does not require all the features SLIME offers, newLISP's IDE does lack a number of features. There are no documentation-related features, there is no code completion and no support for managing projects.

Adjusting to newLISP is not very difficult if you have used some LISP dialect before. In fact, compared to Common LISP, newLISP will feel like quite a breeze, being a lot simpler, although arguably less complete and/or fast. Furthermore, most differences are there to simplify things, not complicate them any further, so learning newLISP will essentially feel like learning a more intuitive subset of Common LISP.

Although (being a fairly experienced Common LISP user) I cannot objectively judge this, learning newLISP does not seem to be particularly difficult for a newcomer to LISP. Furthermore, a very detailed tutorial is also available, written in the same no-frills manner as the rest of the documentation, making it easy for LISP beginners to make their first steps.

The matter is further simplified by the fact that newLISP is an already mature and robust platform, already at its tenth incarnation. The basic API is here to stay, and the system is tightly integrated and robustly documented.

SUMMING UP
Although newLISP is not as complete, nor possibly as fast and efficient as its cousins Common LISP and Scheme, the overall impression that it has left me was positive to say the least. It is very clean, unobtrusive, and it does allow you to get things done with relative ease. It is well suited for scripting and some web development, and the enthusiasm displayed by its authors is entirely deserved. It also has a small, but helpful and enjoyable community, not to mention the CAPTCHA on their forums being absolutely unbeatable.

newLISP does have a handful of downsides. The GUI server is somewhat arcane to deal with (although it's an otherwise sufficient solution given its ease of use and portability), and an IDE with a few additional functions, like some extra set of debugging features and some basic project management functions would make a good start for a wislist. The modules are fairly broad but some of them are rather superficial, so anything extremely serious is likely to imply some extra work on your side. However, one could always point out that newLISP wasn't meant for anything “extremely serious” — but it can incidentally do a lot of “extremely serious work”, some of it being displayed on newLISP's homepage under the Apps section.

Whether this is a better option than another LISP dialect (or another programming language, for that matter) will obviously depend on a lot of issues. Despite some optimistic claims, I am rather reluctant recommending newLISP for scientific or statistical applications, and I haven't tried using it as an environment for full-blown application development. Nevertheless, I would wholeheartedly recommend that you try having a look at it before writing your next Python script. You never know how much you may like it.

newLISP is distributed under a GPL license and you can find it at http://www.newlisp.org/. Happy coding!

About me: I'm a freelancer studying Electrical Engineering betweem deadlines, and a quiet but active LISP user for the last couple of years.


============================================================================
 Differenze tra newLISP, Scheme e Common LISP (Lutz Mueller)
============================================================================

Cerchiamo di capire quali sono le differenze tra newLISP, Scheme e Common LISP.
Lo scopo di questo confronto non è quello di dimostrare che un linguaggio è migliore di un altro.
Diversi stili di programmazione si adattano a personalità diverse. Ogni approccio ha differenti punti di forza e di debolezza. L'idea che si possa progettare un unico linguaggio per tutti gli usi è una illusione. L'autore di newLISP utilizza 'C' e Java contemporaneamente a newLISP. Altri usano un diverso set di strumenti adatto al loro stile di programmazione e ai progetti che devono realizzare.
L'estetica di newLISP, che ha uno stile disinvolto e flessibile, ha attirato non solo il tradizionale programmatore, ma anche molte persone di altre professioni. Molti contributi alla progettazione di newLISP provengono da persone che non sono programmatori di professione. Per molti, newLISP non è solo un linguaggio di programmazione, ma anche uno strumento per modellare e organizzare il pensiero creativo.

Linguaggi di scripting contro linguaggi compilati
-------------------------------------------------
newLISP è un linguaggio di scripting progettato per non essere compilato ma per essere completamente dinamico e introspettivo. Molte delle differenze con altri LISP derivano da questa distinzione.
Entrambi gli approcci hanno il loro posto nell'informatica moderna. Per una discussione su questo argomento vedi:

"In Praise of Scripting: Real Programming Pragmatics" di Ronald P. Loui

http://web.cs.mun.ca/~harold/Courses/Old/CS2500.F09/Diary/04563874.pdf

Per ulteriori informazioni su storia, critica e altri aspetti del Lisp, consultare la pagina web:

http://www.newLISP.org/index.cgi?page=Links

Apertura e trasparenza
----------------------
newLISP è completamente aperto. Non ci sono stati nascosti. Tutti gli oggetti del linguaggio e i dati sono di primo ordine (classe). Sebbene newLISP inizialmente compili il sorgente del programma in un albero di s-espressioni, ogni oggetto può essere riportato in ogni momento in una forma comprensibile. Questo vale sia per gli spazi dei nomi (namespaces/context) sia per le espressioni lambda. Questa apertura facilita il funzionamento e il debug interattivo e facilita la comprensione del linguaggio. I programmi newLISP sono completamente auto-riflessivi e possono essere ispezionati e modificati in ogni momento (anche a quando sono in esecuzione).
newLISP è in grado di gestire le risorse di rete per quanto riguarda i file in modo trasparente. Nella maggior parte dei casi dove vengono usati dei file, si possono usare anche gli indirizzi URL.
I file possono essere letti, scritti e aggiornati, i programmi possono essere caricati o salvato utilizzando lo stesso codice per sia per l'accesso locale che quello di rete. Questo facilita la scrittura di applicazioni distribuite.

Applicazione delle funzioni come in Scheme
------------------------------------------
A differenza di Common Lisp, newLISP e Scheme valutano prima l'operatore di un'espressione e poi lo applicano ai suoi argomenti.

Espressioni Lambda
------------------
In newLISP, le espressioni lambda sono costanti che valutano su se stesse. Sono un sottotipo del tipo di dati lista, quindi un oggetto dati di primo ordine che può essere manipolato come qualsiasi altra lista. In Common Lisp e Scheme, le espressioni lambda, una volta valutate, restituiscono come tipo di dati, una funzione speciale che formano un chiusura lessicale dopo aver vincolato (associato) le sue variabili libere all'ambiente corrente.
In newLISP, il binding delle variabili libere nelle espressioni lambda avviene durante l'applicazione dell'espressione lambda senza creare una chiusura.
Le espressioni Lambda in newLISP possono essere trattate come dati in ogni momento, anche dopo essere state associate ad una  definizione di funzione:

(define (foo x) (+ x x))
;-> (lambda (x) (+ x x))

(last foo)
;-> (+ x x)

Altri LISP usano le chiusure lambda per creare funzioni con stato (memoria). Mantenere lo stato è una condizione necessaria per un linguaggio di programmazione per permettere la programmazione orientata agli oggetti. In newLISP, i contesti (spazi dei nomi)chiusi lessicalmente possono essere usati per scrivere funzioni con stato. Come le espressioni lambda, i contesti in newLISP sono oggetti di primo ordine. I contesti possono essere creati e distrutti durante il runtime, passati come parametri, e referenziati con dei simboli.
Vedi l'appendice "Chiusure, contesti e funzioni con stato" per un confronto tra le chiusure di Scheme e i contesti di newLISP.
Vedi anche l'appendice "Creazione di funzioni con ambito lessicale in newLISP".

Un solo spazio dei simboli
--------------------------
In newLISP e Scheme, le variabili, le primitive e le funzioni definite dall'utente condividono lo stesso spazio dei simboli. In Common Lisp, i simboli di funzione e i simboli delle variabili utilizzano ciascuno uno spazio di nomi dedicato.
Questo è il motivo per cui a volte i simboli di funzione Common Lisp devono essere preceduti dal carattere #'.
I simboli in newLISP distinguono tra maiuscole e minuscole.

Ambito dinamico all'interno di spazi di nomi isolati
-----------------------------------------------------
newLISP a volte viene criticato per l'utilizzo di ambiti (scope) dinamici e di fexprs. Queste critiche ignorano che
i contesti (namespace) di newLISP proteggono i simboli delle funzioni dagli svantaggi tradizionali dell'ambito dinamico e delle fexprs.
In newLISP, tutte le variabili hanno un ambito dinamico come impostazione predefinita. Tuttavia, definendo una funzione nel proprio contesto, può essere utilizzato l'ambito statico/lessicale. I nomi dei parametri usati nelle fexprs sono inseriti con il loro valore su una pila all'entrata della funzione e vengono ripristinati al ritorno della funzione. In newLISP, diverse funzioni e dati possono condividere uno spazio dei nomi. Includendo le funzioni nel proprio spazio dei nomi, si ottiene un meccanismo di chiusura lessicale. Common Lisp e Scheme hanno un ambito lessicamente predefinito e utilizzano le espressioni lambda come meccanismo di chiusura. Common Lisp offre anche speciali variabili per l'ambito dinamico.
I problemi delle variabili libere in ambito dinamico possono essere evitati. Nei rari casi in cui devono essere utilizzate variabili libere, è possibile suddividere il codice in moduli di spazi di nomi per un controllo più semplice delle variabili libere. È quindi possibile sfruttare i vantaggi dell'ambito dinamico. Con un ambito dinamico all'interno di spazi di nomi chiusi lessicamente, newLISP combina il meglio di entrambi i mondi degli ambiti (scoping).
newLISP non ha problemi di funarg perché segue una semplice regola: le variabili mostrano sempre l'associazione (binding) del loro ambiente attuale. Quando vengono inserite espressioni con variabili locali, newLISP salva lo stato delle variabili in una pila e lo ripristina al termine dell'espressione. In newLISP sono espressioni locali, oltre ai parametri delle funzioni e alle variabili definite con let, anche le variabili di loop di tutti i cicli.

La cella LISP e cons
--------------------
In Common Lisp e Scheme, la parte cdr (rest) della cella Lisp può essere utilizzata per contenere un altro oggetto LISP, nel qual caso abbiamo una coppia puntata. In newLISP, non ci sono coppie puntate. Invece, ciascuna cella di newLISP contiene un oggetto e un puntatore ad un altro oggetto se la cella fa parte di una lista. Come risultato in newLISP la funzione "cons" si comporta diversamente dagli altri LISP.

Common Lisp e Scheme
(cons 'a' b) => (a . b)  ;una coppia puntata
[a | b]

newLISP
(cons 'a' b) => (a b)   ;una lista
[ ]
 \
 [a] -> [b]

La cella LISP in in newLISP
(+ 2 3 (* 4 3))
[ ]
 \
 [+] -> [2] -> [3] -> [ ]
                       \
                       [*] -> [4] -> [3]

Gli argomenti di una funzione sono opzionali
--------------------------------------------
In newLISP, tutti gli argomenti relativi a una funzione definita dall'utente sono facoltativi. Le variabili degli argomenti non assegnati assumeranno il valore nil all'interno della funzione.

Creazione di simboli impliciti
------------------------------
Logicamente, non ci sono simboli non associati o non esistenti in newLISP. Qualsiasi simbolo non associato o non esistente viene creato ed associato a nil nello spazio di nomi corrente quando viene visualizzato per la prima volta da newLISP.

nil e true sono costanti booleane
---------------------------------
nil e true sono costanti booleane in newLISP.
In Common Lisp, nil ha un ruolo aggiuntivo come terminatore di lista:

newLISP
(cons 'x nil) => (x nil)

Scheme
(cons 'x #f) => (x . #f)

Common Lisp
(cons 'x nil) => (x)

Scheme ha due costanti booleane #t e #f per vero e falso.
In newLISP la funzione first e in Scheme la funzione car generano un errore quando vengono usate su una lista vuota.
Il Common Lisp, la funzione car restituisce nil:

newLISP
(first '()) => error

Scheme
(car '()) => error

Common Lisp
(car '()) => nil

Gestione della memoria con un unico riferimento (ORO)
-----------------------------------------------------
In newLISP, ogni oggetto viene referenziato una sola volta (ORO), ad eccezione dei simboli e dei contesti. La regola ORO di newLISP consente la gestione automatica della memoria, basata su stack, senza i problemi degli algoritmi di garbage collection tradizionali usati in altri linguaggi di scripting.
La gestione della memoria ORO di newLISP è più veloce e utilizza meno risorse.
newLISP passa i parametri per valore-copia (pass by value) e memorizza i risultati intermedi su uno stack di risultati. La memoria creata per i risultati intermedi viene riciclata dopo il ritorno della funzione. Come la tradizionale garbage collection, la gestione della memoria ORO libera il programmatore dal gestire l'allocazione e la riallocazione della memoria.
Per evitare di copiare gli oggetti di dati quando si passa per valore-copia, possiamo passare questi dati per riferimento (by reference) racchiudendoli in contesti (context).
Il seguente frammento di codice mostra il passaggio per riferimento utilizzando il funtore di predefinito di uno spazio di nomi:

(define (modify data value)
  (push value data))

(set 'reflist:reflist '(b c d e f g))

(modify reflist 'a) ; passato per riferimento

reflist:reflist => (a b c d e f g)

La gestione automatica della memoria di newLISP è completamente trasparente per il programmatore, ma è più veloce e richiede meno risorse rispetto ai classici algoritmi di garbage collection.
Poiché la gestione della memoria ORO è sincrona, il codice newLISP ha un tempo di esecuzione è costante e ripetibile. I linguaggi di programmazione che utilizzano la garbage collection tradizionale mostrano ritardi e pause improvvis.
La combinazione tra il passaggio per valore-copia e la gestione unica della memoria rendono newLISP il linguaggio di scripting interattivo (non compilato) più veloce in generale tra quelli disponibili. Come mostrato sopra, è comunque possibile anche il passaggio per riferimento. Per le funzioni integrate il passaggio per riferimento è quello predefinito.
Come sottoprodotto della gestione della memoria ORO di newLISP, è necessario solo il segno di uguale "=" per verificare l'uguaglianza tra due oggetti. Common Lisp richiede eq, eql, equal, equalp, =, string=, string-equal, char= e char-eq per i test di uguaglianza di espressioni, tipi di dati, oggetti identici e oggetti referenziati.

Macro Fexpr e macro di riscrittura
----------------------------------
In newLISP, le forme speciali (special form) vengono create usando fexprs definite con la funzione define-macro. Il Common Lisp utilizza dei template di espansione e compilazione per creare le forme speciali. Le forme speciali non valutano i loro argomenti o li valutano solo in condizioni speciali. In newLISP, le fexprs sono chiamate macro perché servono allo stesso scopo delle macro utilizzate in altri dialetti LISP: esse consentono la definizione di forme speciali.
Le fexpr create con define-macro controllano completamente quando gli argomenti vengono valutati. Come risultato, le macro di newLISP possono funzionare come forme speciali integrate:

(define-macro (my-setq x y) (set x (eval y)))

; come macro igienica evitando la cattura delle variabili
(define-macro (my-setq) (set (args 0) (eval (args 1)))))

newLISP può avviare l'espansione delle variabili esplicitamente usando le funzioni expand e letex:

(define (raise-to power)

(expand (fn (base) (pow base power)) 'power))

(define square (raise-to 2))

(define cube (raise-to 3))

(quadrato 5) => 25

(cubo 5) => 125

L'espansione delle variabili può essere utilizzata per catturare lo stato di variabili libere. Vedi un'applicazione di questo concetto nell'appendice: "The Y of Why in newLISP". newLISP combina frequentemente define-macro e i template di espansione usando expand o letex.
In newLISP la cattura delle variabili nelle fexpr può essere evitata racchiudendole in uno spazio di nomi, oppure usando la funzione args per recuperare i parametri passati, cioè (args 0) per il primo (args 1) per il secondo e così via. In entrambi i casi, le fexpr risultanti sono completamente igieniche senza pericolo di cattura delle variabili.
Nella versione 10.1.6, newLISP ha introdotto macro di riscrittura-espansione in un modulo caricabile. Dalla versione 10.6.0, la stessa funzionalità è disponibile con una funzione macro nativa integrata che funziona in modo identico:

; registra un template macro
(macro (cubo X) (pow X 3))

; durante il caricamento del codice, le macro vengono espanse.
(cubo 3) => 27

La funzione di espansione delle macro si aggancia tra il processo di lettura/traduzione del sorgente e il processo di valutazione. Nell'esempio, ogni occorrenza di (cubo n) verrebbe tradotta in (pow n 3). In questo modo si evita il sovraccarico di lavoro delle fexpr.

Indicizzazione implicita (Implicit Indexing)
-------------------------------------------
newLISP ha la capacità di indicizzazione implicita. Questa è un'estensione logica delle regole di valutazione LISP che permette di indicizzare implicitamente le liste e le stringhe in aggiunta alle normali funzionalità di indicizzazione integrate disponibili (nth, rest, slice):

(set 'myList '(a b c (d e) f g))

; utilizzando la funzione  nth
(nth 2 myList) => c

; con un vettore di indici
(nth '(3 1) myList) => e
(nth '(3 0) myList) => d

; utilizzando l'indicizzazione implicita
(myList 2) => c
(myList 3 1) => e
(myList -3 0) => d

; con un vettore di indici
(set 'v '(3 1))
(myList v) => e

; rest implicito, slice
(1 myList) => (b c (d e) f g)
(-3 myList) => ((d e) f g)
(1 2 myList) => (b c)

L'utilizzo dell'indicizzazione implicita è opzionale. In parecchi casi permette di aumentare la velocità e la leggibilità dei programmi.


============================================================================
 Chiusure, contesti e funzioni con stato (Lutz Mueller)
============================================================================

Scheme utilizza le chiusure per scrivere funzioni generatrici, funzioni con stato e oggetti software. newLISP usa l'espansione delle variabili e spazi di nomi chiamati contesti (context) per fare lo stesso.
Gli spazi di nomi di newLISP sono sempre aperti all'ispezione. Sono oggetti di primo ordine che possono essere copiati e passati come parametri alle primitive di newLISP o alle funzioni lambda definite dall'utente.
Un contesto newLISP può contenere più funzioni contemporaneamente. Questo è il metodo usato da newLISP per costruire moduli software.
Come una chiusura Scheme, un contesto newLISP è uno spazio lessicamente chiuso. In newLISP all'interno di tale spazio di nomi l'ambito è dinamico. newLISP consente di combinare l'ambito (scope) lessicale e quello dinamico in modo flessibile.

Funzioni generatrici (Function factories)
-----------------------------------------
Il primo è un semplice esempio di una funzione generatrice. La funzione crea una funzione somma (adder) specifica per ogni numero da aggiungere. Mentre Scheme utilizza una chiusura di funzione per acquisire il numero in una variabile statica, newLISP utilizza la funzione expand per creare una funzione lambda specifica che contiene il numero come costante:

; Chiusura in Scheme

(define make-adder
    (lambda (n)
        (lambda (x) (+ x n))))

(define add3 (make-adder 3)) => # <procedure add3>

(add3 10) => 13

newLISP usa exp o letex per rendere il numero n una parte dell'espressione lambda come costante, oppure usa la funzione curry:

; newLISP usando expand

(define (make-adder n)
    (expand (lambda (x) (+ x n)) 'n))

(define add3 (make-adder 3))

(add3 10) => 13

; newLISP usando letex

(define (make-adder n)
    (letex (c n) (lambda (x) (+ x c))))

; oppure letex sullo stesso simbolo

(define (make-adder n)
    (letex (n n) (lambda (x) (+ x n)))))

(define add3 (make-adder 3))

(add3 10) => 13

; newLISP usando curry

(define add3 (curry + 3))

(add3 10) => 13

In entrambi i casi creiamo un'espressione lambda con il numero 3 contenuto come costante.

Funzioni con memoria
--------------------
Il prossimo esempio usa una chiusura per scrivere una funzione generatore. Produce un risultato diverso ogni volta che viene chiamata e ricorda uno stato interno:

; generatore in Scheme

(define gen
    (let ((acc 0))
         (lambda () (set! acc (+ acc 1)))))

(gen) => 1
(gen) => 2

In newLISP creiamo una variabile di stato locale usando un contesto come spazio di nomi:

; generatore newLISP

(define (gen:gen)
   (setq gen:sum
       (if gen:sum (inc gen:sum) 1)))

; Possiamo scriverlo più concisamente perchè "inc" tratta nil come zero

(define (gen:gen)
    (inc gen:sum))

(gen) => 1
(gen) => 2

Quando scriviamo gen:gen, viene creato un contesto chiamato gen. gen è uno psazio di nomi lessicale contenente i propri simboli usati come variabili e funzioni. In questo caso il lo spazio di nomi gen ha le variabili gen e sum.
Il primo simbolo gen ha lo stesso nome del gen del contesto genitore. Questo tipo di simbolo è chiamato un funtore predefinito in newLISP.
Quando si utilizza un nome di contesto al posto di un nome di funzione, newLISP assume il functor predefinito. Possiamo chiamare la nostra funzione generatore usando (gen). Non è necessario chiamare la funzione usando (gen:gen), (gen) viene riferito a (gen:gen) per default.
Vedi anche l'appendice successiva che crea la funzione "def-static" per automatizzare il processo di creazione di funzioni con ambito lessicale.

Introspezione
-------------
In newLISP è sempre possibile interrogare lo stato interno di una funzione. In Scheme lo stato di una chiusura è nascosto e non aperto all'introspezione senza codice aggiuntivo:

; in Scheme gli stati sono nascosti

add3 #<procedure add3>

gen => #<procedure gen>

; in newLISP gli stati sono visibili

add3 => (lambda (x) (+ x 3))

gen:sum => 2

gen:gen => (lambda () (inc gen:sum))

In Scheme la chiusura lambda è nascosta dall'ispezione, una volta che è stata valutata e assegnata.

Le funzioni in newLISP sono liste di primo ordine
-------------------------------------------------

(define (double x) (+ x x)))
(setf (nth 1 double) '(mul 2 x))

double => (lambda (x) (mul 2 x))

La natura di prima classe delle espressioni lambda in newLISP consente di scrivere codice auto-modificante.

Funzioni con memoria (stateful) che utilizzano la modifica in-place
-------------------------------------------------------------------

;; sum accumulator
(define (sum (x 0)) (inc 0 x))

(sum 1) ;=> 1
(sum 2) ;=> 3

sum ;=> (lambda ((x 0)) (inc 3 x))

;; self incrementer
(define (incre) (inc 0))

(incre) ;=> 1
(incre) ;=> 2
(incre) ;=> 3

incre ;=> (lambda () (inc 3)

;; make stream function with expansion closure

(define (make-stream lst)
    (letex (stream lst)
        (lambda () (pop 'stream))))

(set 'lst '(a b c d e f g h))
(define mystream (make-stream lst))

(mystream) ;=> a
(mystream) ;=> b
(mystream) ;=> c

(set 'str "abcddefgh")
(define mystream (make-stream str))

(mystream) ;=> "a"
(mystream) ;=> "c"

Un altro interessante pattern automodificante è mostrato da Kazimir Majorinc all'indirizzo:
http://kazimirmajorinc.com/Documents/Crawler-tractor/index.html

(define (f)
  (begin
    (println (inc cnt))
    (push (last f) f -1)
    (if (> (length f) 3) (pop f 1))))

Il pattern chiamato "Crawler tractor" (trattore cingolato) verrà eseguito per sempre senza utilizzare iterazione o ricorsione. Il nuovo codice da eseguire viene copiato dal vecchio codice e aggiunto alla fine della funzione. Il vecchio codice eseguito viene estratto dall'inizio della funzione.
newLISP ha la possibilità unica di scrivere funzioni auto-modificanti.


============================================================================
 Creazione di funzioni con ambito lessicale in newLISP (Lutz Mueller)
============================================================================

Una funzione predefinita appare e si comporta in modo analogo alle funzioni con ambito statico trovate in altri linguaggi di programmazione. Diverse funzioni possono condividere uno spazio di nomi.

Utilizzando la primitiva integrata "def-new", è possibile definire una funzione o una macro per creare altre funzioni racchiuse nel proprio spazio di nomi:

(define (def-static s body)
    (def-new 'body (sym s s)))

(setq sum 0)

(def-static 'acc (lambda (x)
        (inc sum x)))

(acc 5)  → 5
(acc 5)  → 10
(acc 2)  → 12

acc:sum  → 12
acc:x    → nil

acc:acc  → (lambda (acc:x) (inc acc:sum acc:x))

sum      → 0

La funzione lavora creando un contesto e un functor predefinito dal nome della funzione. Il valore di acc:sum viene inizializzato a 0 copiando il valore di MAIN:sum.

Utilizzando acc come prototipo, è possibile creare nuove funzioni con ambito statico:

  (new 'acc 'myacc)

  (myacc 3) → 15

La nuova funzione inizierà con myacc:sum come presente in acc:sum quando viene copiato con new.

Utilizzando un metodo più complesso, una def-static può essere definita come una macro che può essere utilizzata come la normale funzione di definizione:

;; define static functions (use only in context MAIN)
;;
;; Example:
;;
;; (def-static (foo x) (+ x x))
;;
;; foo:foo   → (lambda (foo:x) (+ foo:x foo:x))
;;
;; (foo 10)  → 20
;;
(define-macro (def-static)
   (let (temp (append (lambda) (list (1 (args 0)) (args 1))))
       (def-new 'temp (sym (args 0 0) (args 0 0)))))

(def-static (acc x)
       (inc sum x))

(acc 5)  → 5
(acc 5)  → 10
(acc 2)  → 12

acc:sum  → 12
acc:x    → nil

La macro def-static crea innanzitutto un'espressione lambda della funzione da definire nello spazio di nomi attuale e la assegna alla variabile temp. In una seconda fase, la funzione lambda in temp viene copiata nel proprio spazio di nomi. Ciò accade assegnandolo al functor predefinito acc:acc costruito partendo dal nome della funzione.


============================================================================
 The Y of Why in newLISP (Lutz Mueller)
============================================================================

Il compito è trovare una funzione Y, che può trasformare una funzione ricorsiva in una funzione veramente funzionale senza effetti collaterali, senza variabili libere e con la proprietà del punto fisso (fixed point). Quanto segue è una versione di "The Why of Y" [1] di Richard P. Gabriel modificata per newLISP.

Trovare Y
---------
Questa è la definizione ricorsiva originale del fattoriale:

  (define fact (lambda (n) (if (< n 2) 1 (* n (fact (- n 1))))))

L'originale fattoriale ridefinito come funzione anonima e prendendo il vero fattoriale in h:

  (lambda (h) (lambda (n) (if (< n 2) 1 (* n (h (- n 1))))))

Se questa funzione è chiamata F e il fattoriale vero è f allora ((F f) n) = (F n), f è un punto fisso di F.

Stiamo cercando una funzione Y con la proprietà: ((F (Y F)) x) = ((Y F) x)

Questa funzione è chiamata "Applicative-order Y fixed point operator" per i funzionali. Per ottenere ciò, trasformiamo la forma base della funzione fattoriale:

Il fattoriale base con il vero fattoriale:

  (lambda (n) (if (< n 2) 1 (* n (h (- n 1)))))

Passiamo la funzione fattoriale come parametro:

  (lambda (h n) (if (< n 2) 1 (* n (h h (- n 1)))))

Impacchettiamo come espressione anonima e proviamo:

  (let ((g (lambda (h n)
           (if (< n 2) 1 (* n (h h (- n 1)))))))
    (g g 10)); => 3628800

Fino a questo punto le espressioni sono identiche a quelle trovate in "The Why of Y" di Richard P. Gabriel. Il resto delle trasformazioni segue Gabriel, ma inserisce la funzione newLISP "expand" dove richiesto per ottenere un effetto di chiusura per la funzione passata come parametro nell'espressione (lambda (h) ...).

Curry (g g 10) a ((g g) 10):

  (let ((g (lambda (h)
          (espandi (lambda (n) (if (< n 2) 1 (* n ((h h) (- n 1))))) 'h))))
      ((g g) 10))

Estraiamo (h h) come f:

  (let ((g (lambda (h)
            (espandi (lambda (n)
              (let ((f (lambda (f n)
                      (if (< n 2) 1 (* n (f (- n 1)))))))
              (f (h h) n))) 'h))))
           ((g g) 10))

Curry la definizione di f per f interna a (lambda (f n) ...):

  (let ((g (lambda (h)
           (espandi (lambda (n)
            (let ((f (lambda (q)
                   (espandi (lambda (n)
                     (se (< n 2) 1 (* n (q (- n 1))))) 'q)))); in Schema
             ((f (h h)) n))) 'h))))
    ((g g) 10))

Riscriviamo per portare f in cima:

  (let ((f (lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q))))
    (let ((g (lambda (h) (expand (lambda (n) ((f (h h)) n)) 'h))))
       ((g g) 10)))

La funzione Y
-------------
Ora definiamo Y come la corretta espansione e sostituzione di h e f:

  (define Y (lambda (f) (expand
      (let ((g (lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))))
            (g g)) 'f)))

Evitando il let e portando fuori l'espressione (g g) si ottiene:

  (define  Y (lambda (f) (expand
      ((lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))
       (lambda (h) (expand (lambda (x) ((f (h h)) x)) 'h))) 'f)) )

newLISP deve applicare expand per ottenere l'effetto di chiusura per la procedura passata q:

  (define f
    (lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)))

  ((Y f) 10) ;=> 3628800

Mostriamo la proprietà del punto fisso:

  (= ((Y f) 10) ((f (Y f)) 10) ) ;=> true

  ((f (Y f)) 10) ;=> 3628800

  ((f (f (Y f))) 10) ;=> 3628800

Il valore di ritorno di (Y f) mostra che (Y f) è puramente funzionale, senza effetti collaterali e senza variabili libere:

  (lambda (x)
  (((lambda (q) (expand (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q))
    ((lambda (h) (expand (lambda (x) (((lambda (q) (expand
       (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)) (h h)) x)) 'h))
     (lambda (h) (expand (lambda (x) (((lambda (q) (expand
       (lambda (n) (if (< n 2) 1 (* n (q (- n 1))))) 'q)) (h h)) x)) 'h)))) x))

Controlla un'altra funzione ricorsiva fibo:

  (define f (lambda (q) (expand
           (lambda(n) (if(< n 2) 1 (+  (q (- n 1)) (q (- n 2))))) 'q)) )

  (define fibo (Y f))

  (fibo 10) ;=> 89

[1] "The Why of Y" di Richard P. Gabriel - 2001
http://www.dreamsongs.com/NewFiles/WhyOfY.pdf


Note
----
Il Lambda calcolo in newLISP è basato sulla ridefinizione di Lambda - expand espande le variabili maiuscole:

    (define-macro (LAMBDA)
      (append (lambda ) (expand (args))))

Per una differente versione di Y, ma con identiche funzionalità, vedi: "The Y Combinator (Slight Return)" di Mike Vanier
https://mvanier.livejournal.com/2897.html


============================================================================
 Valutazione delle espressioni, Indicizzazione Implicita, Contesti e Funtori di Default (Lutz Mueller)
============================================================================

L'indicizzazione esplicita e i funtori di default sono una estensione delle normali regole di valutazione delle espressioni in LISP. I contesti forniscono spazi di nomi lessicamente chiusi (con stato) in un linguaggio di programmazione con ambito (scope) dinamico.

Valutazione delle S-espressioni e indicizzazione implicita
----------------------------------------------------------
In un altro articolo viene spiegato come la valutazione delle S-espressioni si interfaccia con il metodo di gestione automatica della memoria ORO (One Reference Only) [1]. Il seguente pseudo-code della funzione di valutazione di newLISP mostra come l'indicizzazione implicita sia un'estensione delle regole di valutazione delle S-espressioni in LISP:

function evaluateExpression(expr)
    {
    if typeOf(expr) is constant (BOOLEAN, NUMBER, STRING, CONTEXT)
        return(expr)

    if typeOf(expr) is SYMBOL
        return(symbolContents(expr))

    if typeOf(expr) is QUOTED
        return(unQuotedContents(expr))

    if typeOf(expr) is LIST
        {
        func = evaluateExpression(firstOf(expr))
        args = rest(expr)
        if typeOf(func) is BUILTIN_FUNCTION
            result = evaluateFunc(func, args)
        else if typeOf(func) = LAMBDA_FUNCTION
            result = evaluateLambda(func, args)
    /* extensions for default functor */
        if typeOf(func) is CONTEXT
            func = defaultFunctor(func)
                if typeOf(func) = LAMBDA_FUNCTION
                    result = evaluateLambda(defaultFunctor(func), args)
        /* extensions for implicit indexing */
        else if typeOf(func) = LIST
            result = implicitIndexList(func, args)
        else if typeOf(func) = STRING
            result = implicitIndexString(func, args)
        else if typeOf(func) = ARRAY
            result = implicitIndexArray(func, args)
        else if typeOf(func) = NUMBER
            result = implicitNrestSlice(func, args)
        }
    }

    return(result)
    }

Il funzionamento generale della funzione riflette la struttura generale della funzione eval descritta da John McCarthy nel 1960, [2].

La funzione first elabora le espressione atomiche. Le costanti valutano su se stesse e vengono restituite. I simboli valutano al loro contenuto.

Se l'espressione è una lista, il primo elemento (first) viene applicato al resto della lista (rest). Come in Scheme, newLISP valuta il primo elemento prima di applicarlo ai suoi argomenti.

Lisp o Scheme tradizionali consentono solo una funzioni built-in, un operatore o una funzione lambda definita dall'utente come prima posizione (funtore) nella lista S-espression da valutare. In newLISP un simbolo del contesto, una lista, un vettore e un numero possono agire come funzioni se si trovano nella posizione del funtore (prima posizione).

Le funzioni built-in vengono valutate chiamando evaluateFunc(func, args), i funtori, che sono espressioni lambda, chiamano la funzione evaluateLambda(func, args). Entrambe le funzioni a loro volta chiameranno evaluateExpression(expr) di nuovo per la valutazione degli argomenti della funzione.

Il funzionamento di un simbolo di contesto nella posizione del functor di una 'S-espressione sarà spiegato più in basso nel capitolo sugli spazi di nomi (namespace) e i funtori predefiniti.

Il tipo lista fa sì che newLISP valuti l'intera S-espressione come l'elemento indicizzato dal numero/i che segue l'elenco e interpretato come indice o indici (in newLISP gli elementi nidificati possono essere indicizzati usando indici multipli).

(set 'lst '(a b (c d e) f g))
(lst 2)  → (c d e)
(lst 2 1)  → d

(set 'str "abcdefg")
(str 2)  → "c"

Un numero nella posizione del funtore assumerà funzionalità di slicing e applicherà la funzione slice alla lista seguente utilizzando come offset quel numero. Quando abbiamo due numeri, allora il secondo specifica la lunghezza dello slice della lista:

(1 lst)  → (b (c d e) f g)
(1 2 lst)  → (b (c d e))

(1 2 str)  → "bc"

A prima vista sembra logico estendere questo fuznionamento anche ai dati di tipo booleano. Un espressione condizionale ternaria potrebbe essere realizzata sernza utilizzare l'operatore if, ma in pratica questo porta a difficoltà nella lettura del codicee causa troppe ambiguità nei messaggi di errore. Nella maggior parte dei casi, l'indicizzazione implicita genera un codice più leggibile, poichè l'oggetto dati viene raggruppato insieme ai suoi indici. L'indicizzazione implicita è molto veloce, ma è opzionale. Le parole chiave "nth", "first", "last", "rest" e "slice" possono essere usate in quei pochi casi in cui la leggibilità è migliore con l'utilizzo di forme esplicite di indicizzazione.

Lo stack dell'ambiente e l'ambito dinamico (dynamic scoping)
------------------------------------------------------------
Nella funzione eval del Lisp originale, un variabile  d'ambiente viene implementata come una lista di associazioni di simboli e i loro valori. In newLISP un simbolo viene implementato come una struttura dati con uno slot per il valore e la variabile d'ambiente non è una lista di asssocizioni, ma un albero binario per i simboli e uno stack fi ambiente che memorizza i valori precedenti dei simboli nei livelli di valutazione più alti.

Quando incontriamo una funzione lambda, i parametri dei simboli e i loro valori correnti sono inseriti sullo stack d'ambiente. Qando lasciamo la funzione, i parametri dei simboli sono ripristinati ai valori precedenti, cioè ai valori che avevano immediatamente prima di entrare nello stack. Qualuqnque chiamata ad un'altra funzione vedrà il valore del simbolo così come definito nell'ambito della funzione chiamante. Le variabili d'ambiente cambiano dinamicamente durante le chiamate e il ritorno delle funzioni. L'ambito dei una variabile viene esteso dinamicamente nei livelli inferiori di chiamate.

Il seguente esempio imposta due mvariabili e definisce due funzioni lambda. Dopo la loro definizione, le funzioni vengono utilizzate in modo nidificato. La parte delle variabili d'ambiente che si modifica viene evidenziata con una freccia (==>):

; x  → nil, y  → nil;
; foo  → nil
; double  → nil
; environment stack: [ ]

(define (foo x y)
  (+ (double (+ x 1)) y))

; x → nil, y  → nil,
==> ; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → nil
; environment stack: [ ]

(define (double x)
  (* 2 x))

; x  → nil, y  → nil
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
==> ; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

(set 'x 10) (set 'y 20)

==> ; x  → 10, y  → 20
; foo  → (lambda (x y) (+ (double (+ x 1)) y))
; double  → (lambda (x) (* 2 x)))
; environment stack: [ ]

In maniera simile a Scheme, newLISP utilizza lo stesso spazio di nomi (namespace) per memorizzare i simboli delle variabili e i simboli delle funzioni lambda definite dall'utente. La funzione "define" è solo un trucco per scrivere:

(set 'foo (lambda (x y) (+ (double (+ x 1)) y)))

Durante tutte queste operazioni lo stack d'ambiente rimane vuoto [ ]. I simboli che rappresentano espressioni lambda fanno parte dello stesso spazio di nomi dei simboli che contengono dati e vengono trattati allo stesso modo. Adesso la prima funzione "foo" viene chiamata:

(foo 2 4)

; after entering the function foo
==> ; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20]

Dopo essere entrati nella funzione, i vecchi valori di x e y vengono inseriti nello stack d'ambiente. Questa operazione di push è iniziata dalla funzione evaluateLambda(func, args), che verrà discussa in seguito in questo articolo. Internamente a "foo" viene chiamata la funzone "double":

(double 3)
; after entering the function double
==> ; x -> 3, y -> 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20, x -> 2]

; after return from double
==> ; x → 2, y → 4
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [x -> 10, y -> 20]

; after return from foo
==> ; x → 10, y → 20
; foo → (lambda (x y) (+ (double (+ x 1)) y))
; double → (lambda (x) (* 2 x)))
==> ; environment stack: [ ]

Si noti che in newLISP l'ambito (scope) dinamico dei simboli dei parametri nelle espressioni lambda non crea chiusure di stato lessicale attorno a quei simboli come nel linguaggio Scheme (dialetto del Lisp). Al ritorno dalla funzione lambda il contenuto del simbolo viene distrutto e la memoria viene recuperata. I simboli dei parametri recuperano i loro vecchi valori all'uscita dalla funzione lambda prendendoli dallo stack d'ambiente.

In newLISP le chiusure lessicali con stato (lexical state-full closures) non vengono con le chiusure lambda, ma utilizzando spazi di nomi lessicali. Le funzioni lambda in newLISP non creano chiusure ma possono creare un nuovo ambito e un nuovo contenuto temporaneo per i simboli esistenti durante l'esecuzione della funzione lambda.

Valutazione delle funzioni lambda
---------------------------------
Tutti i processi appena descritti avvengono nella funzione evaluateLambda(func, args). Il seguente pseudo-codice mostra alcuni dettagli:

function evaluateLambda(lambda-func, args)
    {
    for each parameter symbol in lambda-func
        pushEnvironmentStack(symbol, value)

    for each arg in args and the symbol belonging to arg
        ; evaluation of arg happens in old symbol environment
        assignSymbolValue(symbol, evaluateExpression(arg))

    for each body expression expr in lambda-func
        result = evaluateExpression(expr)

    for each parameter symbol in lambda-func
        popEnvironmentStack()

    return(result)
    }

Le funzioni evaluateExpression(args) e evaluateLambda(func, args) si chiamano in modo reciproco in un ciclo  ricorsivo.

Si noti che gli argomenti delle funzioni lambda vengono valutati nell'ambiente delle variabili come definito precedentemente alla chiamata della funzione lambda. Le assegnazioni ai simboli dei parametri avvengono dopo tutte le valutazioni degli argomenti. Vengono valutati solo gli argomenti che hanno un simbolo di parametro corrispondente. Se sono presenti più simboli di parametro rispetto agli argomenti passati, i simboli dei parametri vengono assegnati a nil o a un valore predefinito.

Spazi di nomi (namespace) e il ciclo di traduzione e valutazione
----------------------------------------------------------------
Tutti gli oggetti dati di memoria in newLISP sono collegati direttamente o indirettamente a un simbolo. Gli oggetti di memoria sono referenziati direttamente da un simbolo o fanno parte di una S-espressione che li racchiude a cui fa riferimento un simbolo. Gli oggetti non legati (unbound) esistono solo come oggetti transitori come valori restituiti dalle valutazioni e sono referenziati sullo stack dei risultati per una eliminazione successiva [1].

Tranne che per i simboli, tutti i dati e gli oggetti del programma sono referenziati una sola volta. I simboli sono creati e organizzati in una struttura ad albero binario. Gli spazi di nomi (namespace), chiamati "context" in newLISP, sono sotto-rami in questo albero binario. Un contesto è associato a un simbolo nel contesto principale MAIN, che a sua volta è un simbolo nel contesto radice.

Con poche eccezioni, tutti i simboli vengono creati durante il caricamento del codice e la fase di traduzione dell'interprete newLISP. Solo le funzioni load, sym, eval-string e una speciale sintassi dei context creano simboli durante l'esecuzione del runtime.

I due simboli MAIN: x e CTX: x sono due simboli diversi in ogni momento. Un simbolo in nessun caso può cambiare il contesto dopo che è stato creato. Un contesto, ad esempio CTX, è di per sé un simbolo in MAIN contenente il puntatore di root a un sotto-ramo nell'albero dei simboli.

Il funzionamento del cambio di contesto è spiegato usando i seguenti due pezzi di codice:

(set 'var 123)
(define (foo x y)
    (context 'CTX)
    (println var " " x " " y))

L'istruzione (context 'CTX) è stata inclusa solo qui per mostrare, non ha alcun effetto in questa posizione. Un passaggio a un contesto di namespace diverso avrà influenza solo sulle successive creazione di simboli usando sym o eval-string. Nel momento in cui (context 'CTX) è eseguito, la funzione foo è già stata definita e tutti i simboli utilizzati in esso sono stati cercati e tradotti. Solo quando si utilizza (context ...) sul livello superiore influenzerà la creazione del simbolo con il codice che la segue:

(context 'CTX)
(set 'var 123)
(define (foo x y)
    (println var " " x " " y))
(context MAIN)

Adesso il contesto viene creato e passato al livello più alto. Quando newLISP traduce la successiva istruzione set e la definizione di funzione, tutti i simboli faranno parte di CTX come CTX:var, CTX:foo, CTX:x e CTX:y.

Durante il caricamento del codice newLISP legge un'espressione di livello superiore che traduce e poi valuta. Questo ciclo viene ripetuto fino a quando tutte le espressioni di livello superiore vengono lette e valutate.

(set 'var 123)
(define (foo x y)
    (println var " " x " " y))

Nello snippet di codice precedente due espressioni di livello superiore sono tradotte e valutate con conseguente creazione dei tre simboli: MAIN:var, MAIN:foo, MAIN:x, MAIN:y e MAIN:CTX.

Il simbolo MAIN:var conterrà il numero 123 e il simbolo MAIN:foo conterrà l'espressione lambda (lambda (x y) (println var " " x " " y)). I simboli MAIN:x e MAIN:y entrambi conterranno nil. La var all'interno della definizione di foo è la stessa della var precedentemente impostata a 123 e verrà stampata come 123 durante l'esecuzione di foo.

In dettaglio vengono eseguiti i seguenti passi:

1. il contesto attuale è MAIN

2. legge la parentesi di apertura di primo livello e crea una cella Lisp di tipo EXPRESSION.

3. legge e cerca set in MAIN e trova che è una primitiva built-in di MAIN, quindi lo traduce nell'indirizzo di memoria di questa funzione primitiva. Crea una cella Lisp di tipo PRIMITIVE che contiene internamente l'indirizzo della funzione.

4. legge il simbolo quote ' e crea una cella Lisp di tipo QUOTE.

5. Legge e cerca la variabile var in MAIN, non si trova in MAIN, lo crea in MAIN e lo traduce nell'indirizzo dell'albero binario dei simboli. Crea una cella Lisp di tipo SYMBOL contenente internamente l'indirizzo del simbolo. La cella di QUOTE precedentemente creata funge da inviluppo per la cella dei simboli.

6. Legge 123 e crea una cella Lisp di tipo INTEGER con 123 nello slot del contenuto.

7. legge la parentesi chiusa che chiude il primo livello e termina la seguente struttura di lista in memoria:

[ ]                          ; cell of type: EXPRESSION
  \
 [MAIN:set]  → [']  → [123]  ; three cells of type: PRIMITIVE, QUOTE, INTEGER
                 \
               [MAIN:var]    ; cell of type: SYMBOL

Il diagramma sopra mostra le cinque celle Lisp, che sono state create. Le celle List e quote sono celle di inviluppo che contengono una lista o un'espressione quotata.

L'istruzione (set 'var 123) non è ancora stata eseguita, ma la traduzione e la creazione dei simboli sono finite e l'istruzione esiste come una struttura di lista in memoria. L'intera struttura della lista può essere referenziata con un indirizzo di memoria, l'indirizzo della prima cella creata di tipo EXPRESSION.

8. Valutazione delle istruzioni
In modo simile newLISP leggerà e tradurrà la successiva espressione di primo livello, che è la definizione di funzione di foo. La valutazione di questa espressione di livello superiore comporterà un assegnamento di una espressione lambda al simbolo foo.

Nel codice sopra riportato, entrambe le istanze di var si riferiscono a MAIN:var. L'istruzione (context 'CTX) cambia solo il contesto, lo spazio di nomi per i nuovi simboli creati. Il simbolo var è stato creato durante il caricamento e la traduzione della funzione foo. Nel momento in cui foo viene chiamata ed eseguitola variabile var esiste già all'interno della funzione foo come MAIN:var. L'istruzione (context 'CTX) non ha alcun effetto sulla succesiva esecuzione di (println var).

Le istruzioni context come (context 'CTX) sopra, cambiano il contesto corrente per la creazione del simbolo durante la fase di caricamento e traduzione. Il contesto corrente definisce sotto quale ramo nell'albero dei simboli vengono creati nuovi simboli. Questo riguarda solo le funzioni sym, eval-string e una speciale sintassi di context per creare simboli. Una volta che un simbolo appartiene a un contesto, rimane lì.

Cambiamento di spazi di nomi (namespaces context)
-------------------------------------------------
I capitoli precedenti hanno mostrato come utilizzare il cambio di contesto al livello principale [top-level] di un  file sorgente newLISP per influenzare la creazione e la traduzione dei simboli durante il processo di caricamento della sorgente. Una volta che esistono spazi dei nomi diversi, chiamando una funzione che appartiene a un contesto diverso, si verificherà un cambio di contesto nello spazio dei nomi dove si trova la funzione lambda chiamata. Se la funzione chiamata non esegue alcuna istruzione sym o eval-string, allora questo cambio di contesto non hanno alcun effetto. Anche il comando load avvia sempre il caricamento del file relativamente al contesto MAIN, a meno che non venga specificato un contesto diverso come parametro speciale nellas funzione load. All'interno del file caricato i cambiamenti di contesto produrranno la creazioni di simboli durante il processo di load come spiegato precedentemente.

Ciò che causa i cambio di contesto è il simbolo che contiene la funzione lambda. Negli esempi di codice seguenti, la freccia ==> viene utilizzata per l'output generato dalle istruzioni println:

(context 'Foo)
(set 'var 123)
(define (func)
    (println "current context: " (context))
    (println "var: " var))
(context 'MAIN)

(Foo:func)
==> current context: Foo
==> var: 123

(set 'aFunc Foo:func)
(set 'var 999)

(aFunc)
==> current context: MAIN
==> var: 123

Si noti che la chiamata a aFunc fa sì che il contesto corrente venga visualizzato come MAIN, perché il simbolo aFunc appartiene al contesto MAIN. In entrambi i casi la variabile var viene stampata come 123. Il simbolo var è stato inserito nello spazio dei nomi di Foo durante la traduzione di func e resterà sempre lì, anche se una copia della funzione lambda viene creata e assegnata ad un simbolo in un contesto diverso.

Questo comportamento di cambio del contesto segue le stesse regole quando si applicano o si mappano le funzioni:

(apply 'Foo:func)
==> current context: Foo
==> var: 123

(apply Foo:func)
==> current context: MAIN
==> var: 123

La prima volta Foo:func viene applicata come simbolo-quotato, la seconda volta la funzione lambda contenuta in Foo:func viene applicata direttamente, perchè apply valuta prima il suo primo argomento.

Spazi di nomi e il funtore di default
-------------------------------------
In newLISP, un simbolo è un funtore predefinito (default functor) se ha lo stesso nome del contesto a cui appartiene, es. Foo:Foo è il simbolo del funtore predefinito nel contesto Foo. In newLISP quando si utilizza un simbolo di contesto nella posizione del funtore, viene preso come il funtore predefinito:

(define (double:double x) (* 2 x))
(double 3)  → 6

(set 'my-list:my-list '(a b c d e f))
(my-list 3)  → d

Il secondo esempio combina l'indicizzazione implicita con l'uso di un funtore predefinito.

I funtori predefiniti possono essere applicati e mappati usando apply e map come qualsiasi altra funzione o simbolo di funtore:

(map my-list '(3 2 1 2))  → (d c b c)

(apply double '(10))  → 20

I funtori predefiniti sono un modo conveniente in newLISP per passare liste o altri oggetti big data per riferimento:

(set 'my-list:my-list '(a b c d e f))

(define (set-last ctx val)
  (setf (ctx -1) val))

(set-last my-list 99)  → f

my-list:my-list  → (a b c d e 99)

I funtori predefiniti sono anche un modo conveniente per definire funzioni full-state in uno spazio di nomi (functions with a closed state-full name space):

(context 'accumulator)
(define (accumulator:accumulator x)
  (if (not value)
    (set 'value x)
    (inc 'value x)))
(context MAIN)

(accumulator 10)  → 10
(accumulator 2)  → 12
(accumulator 3)  → 15

Nota che i simboli x e value appartengono entrambi allo spazio dei nomi accumulator. Poichè (context 'accumulator) è al livello più alto, la traduzione della seguente definizione di funzione accumulator:accumulator avviene all'interno dello spazio dei nomi corrente accumulator.

I namespace in newLISP possono essere passati per riferimento e possono essere utilizzati per creare chiusure lessicali full-state.

Il funtore di default usato come funzione pseudo-hash
-----------------------------------------------------
Un funtore predefinito che contiene nil e si trova nella posizione di operatore funzionerà in modo simile a una funzione di hash per la costruzione di dizionari con chiave associativa → accesso al valore:

(define aHash:aHash) ; create namespace and default functor containing nil

(aHash "var" 123) ; create and set a key "var" to 123

(aHash "var")  → 123 ; retrieve value from key

Riferimenti
-----------

[1] Lutz Mueller, 2004-2013
Automatic Memory Management in newLISP.

[2] John McCarthy, 1960
Recursive Functions of Symbolic Expressions and their Computation by Machine.


============================================================================
 Gestione Automatica della Memoria in newLISP (Lutz Mueller)
============================================================================

ORO (One Reference Only) La gestione automatica della memoria sviluppata per newLISP è un'alternativa rapida e in grado di risparmiare risorse rispetto ai classici algoritmi di garbage collection dei linguaggi di programmazione dinamici e interattivi. Questo articolo spiega come funziona la gestione della memoria di tipo ORO.

newLISP e qualsiasi altro sistema di linguaggio interattivo genererano costantemente nuovi oggetti in memoria durante la valutazione delle espressioni. I nuovi oggetti in memoria sono il risultato delle valutazioni intermedie, della riassegnazione di oggetti in memoria o della modifica di oggetti in memoria il cui contenuto è stato modificato. Se newLISP non eliminasse alcuni degli oggetti creati, alla fine esaurirebbe la memoria disponibile.

Per comprendere la gestione automatica della memoria in newLISP, è necessario prima rivedere i metodi tradizionali utilizzati da altri linguaggi.

Metodi tradizionali di gestione automatica della memoria (Garbage Collection)
-----------------------------------------------------------------------------
Nella maggior parte dei linguaggi di programmazione, un processo registra la memoria allocata e un altro processo trova e ricicla le parti inutilizzate del pool di memoria allocato. Il processo di riciclaggio può essere attivato da un limite di allocazione della memoria o può essere programmato tra una fase di valutazione e l'altra. Questa forma di gestione automatica della memoria si chiama Garbage Collection.

Gli schemi di garbage collection tradizionali sviluppati per LISP utilizzavano uno dei due seguenti algoritmi:¹

(1) L'algoritmo mark-and-sweep registra ogni oggetto di memoria allocato. Una fase mark contrassegna periodicamente ciascun oggetto nel pool di memoria allocato. Un oggetto con nome (un simbolo di variabile) fa riferimento direttamente o indirettamente a ciascun oggetto di memoria nel sistema. La fase di sweep libera la memoria degli oggetti contrassegnati quando non sono più in uso.

(2) Uno schema di conteggio di riferimento registra ogni oggetto di memoria allocato insieme con un conteggio di riferimenti all'oggetto. Questo conteggio dei riferimenti viene incrementato o decrementato durante la valutazione dell'espressione. Ogni volta che il conteggio dei riferimenti di un oggetto raggiunge lo zero, la memoria allocata dell'oggetto viene liberata.

Nel corso del tempo, sono stati elaborati molti schemi di garbage collection basati su queste tecniche. I primi algoritmi di garbage collection sono apparsi in LISP. Gli inventori del linguaggio Smalltalk utilizzavano schemi garbage collection più elaborati. La storia di Smalltalk-80 è un resoconto entusiasmante delle sfide poste dall'implementazione di metodi di gestione della memoria in linguaggi di programmazione interattivi, vedi [Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice]. Una panoramica più recente dei metodi di garbage collection è disponibile in [Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management].

One reference only, (ORO) memory management
-------------------------------------------
La gestione della memoria in newLISP non si basa su un algoritmo di garbage collection. La memoria non è marcata o referenziata per conteggio. Invece, una decisione se eliminare un oggetto di memoria appena creato viene effettuata subito dopo la creazione dell'oggetto.

Studi empirici su LISP hanno dimostrato che la maggior parte delle celle LISP non sono condivise e quindi possono essere recuperate durante il processo di valutazione. A parte alcune ottimizzazioni per parte delle funzioni integrate, newLISP cancella la memoria di nuovi oggetti contenenti risultati di valutazione intermedi una volta raggiunto un livello di valutazione più alto. newLISP fa ciò spingendo un riferimento ad ogni oggetto di memoria creato su uno stack di risultati. Quando newLISP raggiunge un livello di valutazione superiore, rimuove il riferimento del risultato dell'ultima valutazione dallo stack dei risultati ed elimina l'oggetto di memoria del risultato della valutazione. Questo non dovrebbe essere confuso con il conteggio dei riferimenti a un bit. La gestione della memoria ORO non imposta bit come adesivi per contrassegnare gli oggetti.

newLISP segue la regola di un solo riferimento (ORO). Ogni oggetto di memoria non referenziato da un simbolo è obsoleto quando newLISP raggiunge un livello di valutazione più alto durante la valutazione dell'espressione. Gli oggetti in newLISP (esclusi simboli e contesti) vengono passati per copia del valore ad altre funzioni definite dall'utente. Di conseguenza, ogni nuovo oggetto LISP richiede solo un riferimento.

La regola ORO di newLISP ha dei vantaggi. Semplifica non solo la gestione della memoria, ma anche altri aspetti del nuovo linguaggio LISP. Ad esempio, mentre gli utenti di LISP tradizionali devono distinguere tra l'uguaglianza degli oggetti di memoria copiati e l'uguaglianza dei riferimenti agli oggetti di memoria, gli utenti newLISP non ne hanno bisogno.

La regola ORO di newLISP forza newLISP ad allocare e liberare celle LISP costantemente. newLISP ottimizza questo processo allocando grandi blocchi di memoria per le celle dal sistema operativo. newLISP richiederà celle LISP da un elenco di celle libere e quindi le riciclerà nuovamente in quell'elenco. Di conseguenza, sono necessarie solo alcune istruzioni della CPU (assegnazioni di puntatori) per scollegare una cella libera o per reinserire una cella eliminata.

L'effetto complessivo della gestione della memoria ORO è un tempo di valutazione più rapido e una memoria e un ingombro del disco più contenuti rispetto a quelli offerti dal tradizionale LISP interpretato. Il tempo impiegato per collegare e scollegare gli oggetti di memoria è più che compensato dalla mancanza di tempo di elaborazione causata dai metodi tradizionali di garbage collection. La gestione della memoria ORO evita anche le pause occasionali di elaborazione nei linguaggii che utilizzano la tradizionale garbage collection e l'ottimizzazione dei parametri di garbage collection richiesti durante l'esecuzione di programmi che fanno uso intensivo di memoria.

La gestione della memoria ORO avviene in modo sincrono rispetto ad altre elaborazioni nell'interprete, il che si traduce in tempi di elaborazione deterministici.

Nelle versioni precedenti alla 10.1.3, newLISP utilizzava un classico algoritmo di mark e sweep per liberare celle non referenziate in condizioni di errore. A partire dalla versione 10.1.3, questo è stato eliminato e sostituito da una corretta pulizia dello stack dei risultati in condizioni di errore.

Considerazioni sulle prestazioni con i parametri di copia
---------------------------------------------------------
In teoria, il passaggio dei parametri alle funzioni definite dall'utente in base al valore (by-value, copia della memoria) anziché al riferimento pone un potenziale svantaggio quando si gestiscono liste, matrici o stringhe di grandi dimensioni. Ma in pratica newLISP è più veloce o veloce come altri linguaggi di scripting e offre speciali sintassi per passare oggetti di memoria molto grandi per riferimento.

Poiché le funzioni newLISP versione 9.4.5 possono passare parametri di tipo list, array e string come riferimenti utilizzando gli identificativi dei funtori predefiniti degli spazi dei nomi. I namespace (chiamati contesti in newLISP) hanno un overhead molto piccolo e possono essere utilizzati per avvolgere funzioni e dati. Ciò consente il passaggio di riferimento di un grande oggetto di memoria nelle funzioni definite dall'utente.

Dalla versione 10.2, FOOP (Functional Object Oriented Programming) in newLISP passa per riferimento anche l'oggetto target di una chiamata di metodo.

Ma anche nei casi in cui il passaggio di riferimento e altre ottimizzazioni non sono presenti, la velocità della gestione della memoria ORO compensa ampiamente il sovraccarico necessario per copiare ed eliminare oggetti.

Ottimizzazioni per la gestione della memoria ORO ²
------------------------------------------------
Dalla versione 10.1 di newLISP, tutte le liste, i vettori (array) e le stringhe vengono passati in e out dalle funzioni predefinite per riferimento. Tutte le funzioni integrate funzionano direttamente sugli oggetti di memoria restituiti per riferimento da altre funzioni incorporate. Ciò ha sostanzialmente ridotto la necessità di copiare ed eliminare oggetti di memoria e aumentato la velocità di alcune funzioni incorporate. Ora solo i parametri in funzioni definite dall'utente e i valori di ritorno passati da funzioni definite dall'utente sono gestiti da ORO.

Dalla versione 10.3.2, newLISP controlla lo stack dei risultati prima di copiare le celle LISP. Ciò ha ridotto la quantità di celle copiate di circa l'83% e ha aumentato significativamente la velocità di molte operazioni su liste più grandi.

Memoria e tipi di dati in newLISP
-------------------------------
Gli oggetti di memoria delle stringhe newLISP vengono allocati e liberati sul sistema operativo host, ogni volta che newLISP ricicla le celle dai suoi blocchi di allocazione delle celle di memoria. Ciò significa che newLISP gestisce la memoria delle celle in modo più efficiente rispetto alla memoria delle stringhe. Di conseguenza, è spesso preferibile utilizzare simboli anziché stringhe per un'elaborazione efficiente. Ad esempio, quando si gestisce il linguaggio naturale è più efficiente gestire le parole del linguaggio naturale come singoli simboli in uno spazio dei nomi separato, quindi come singole stringhe. La funzione bayes-train in newLISP utilizza questo metodo. newLISP può gestire milioni di simboli senza compromettere le prestazioni.

I programmatori provenienti da altri linguaggi di programmazione spesso trascurano che i simboli in LISP possono comportarsi come qualcosa di più di semplici variabili o riferimenti a oggetti. Il simbolo è un tipo di dati utile in sé, che in molti casi può sostituire il tipo di dati stringa.

I numeri interi e i numeri a virgola mobile (double) sono memorizzati direttamente nelle celle LISP di newLISP e non richiedono un ciclo di allocazione della memoria separato.

Per l'efficienza durante operazioni con matrici come la moltiplicazione o l'inversione della matrice, newLISP assegna oggetti di memoria non-cella per matrici, converte i risultati in celle LISP e quindi libera gli oggetti di memoria matrice.

newLISP alloca un array come un gruppo di celle LISP. Le celle LISP sono allocate in modo lineare. Di conseguenza, gli indici di array hanno un accesso casuale più rapido alle celle LISP. Solo un sottoinsieme delle funzioni di newLISP disponibilki per le liste può essere utilizzato sugli array. La gestione automatica della memoria in newLISP gestisce gli array in modo simile a come gestisce le liste.

Implementazione della gestione della memoria ORO
------------------------------------------------
Il seguente pseudo codice illustra l'algoritmo implementato in newLISP nel contesto della valutazione dell'espressione LISP. Sono necessarie solo due funzioni e una struttura dati per implementare la gestione della memoria ORO:

function pushResultStack(evalationResult)

function popResultStack() ; implies deleting

array resultStack[] ; preallocated stack area

Le prime due funzioni pushResultStack e popResultStack spingono (push) o estraggono (pop) un handle di un oggetto LISP avanti e indietro da una pila. pushResultStack aumenta il valore resultStackIndex mentre popResultStack lo diminuisce. In newLISP ogni oggetto è contenuto in una struttura di celle LISP. L'handle di oggetto di quella struttura è semplicemente il puntatore di memoria alla struttura della cella. La cella stessa può contenere indirizzi puntatore ad altri oggetti di memoria come buffer di stringa o altre celle LISP collegate all'oggetto originale. Oggetti piccoli come numeri vengono memorizzati direttamente. In questa funzione popResultStack() implica anche che l'oggetto estratto venga eliminato.

Le due funzioni di gestione resultStack descritte sono chiamate dalla funzione evaluateExpression di newLISP:³

;; function evaluateExpression(expr)
;;     {
;;     resultStackIndexSave = resultStackIndex
;;
;;     if typeOf(expr) is BOOLEAN or NUMBER or STRING
;;     return(expr)
;;
;;     if typeOf(expr) is SYMBOL
;;         return(symbolContents(expr))
;;
;;     if typeOf(expr) is QUOTE
;;         return(quoteContents(expr))
;;
;;     if typeOf(expr) is LIST
;;         {
;;         func = evaluateExpression(firstOf(expr))
;;         args = rest(expr)
;;         if typeOf(func) is BUILTIN_FUNCTION
;;                 result = evaluateFunc(func, args)
;;         else if typeOf(func) = LAMBDA_FUNCTION
;;                 result = evaluateLambda(func, args)
;;         }
;;     }
;;
;;     while (resultStackIndex > resultStackIndexSave)
;;         deleteList(popResultStack())
;;
;;     pushResultStack(result)
;;
;;     return(result)
;;     }

La funzione evaluateExpression introduce le due variabili resultStackIndexSave e resultStackIndex e alcune altre funzioni:

resultStackIndex è un indice che punta all'elemento superiore di resultStack. Maggiore è il livello di valutazione, maggiore è il valore di resultStackIndex.

resultStackIndexSave funge da memoria temporanea per il valore di resultStackIndex all'entrata della funzione evaluateExpression(func, args). Prima di uscire, il resultStack viene visualizzato al livello salvato di resultStackIndex. Estrarre il resultStack implica l'eliminazione degli oggetti di memoria indicati dalle voci nel resultStack.

resultStack[] è un'area di stack preallocata per il salvataggio di puntatori a celle LISP che sono indicizzate da resultStackIndex.

symbolContents(expr) e quoteContents(expr) estraggono il contenuto da simboli o da celle di memoria quotate (inviluppate con quote).

typeOf(expr) estrae il tipo di un'espressione, che è una costante BOOLEAN come nil o true o un NUMBER o STRING, oppure una variabile SYMBOL contenente alcuni contenuti, o un QUOTE che serve come una busta di inviluppo per un'altra espressione LIST expr.

evaluateFunc(func, args) è l'applicazione di una funzione built-in ai suoi argomenti. La funzione built-in è il primo membro valutato di una lista in expr e gli argomenti sono il resto della lista in expr. La funzione func viene estratta chiamando evaluateExpression(first (expr)) in modo ricorsivo. Ad esempio se l'espressione expr vale (foo x y) allora foo è una funzione built-in e x e y sono gli argomenti o parametri della funzione.

evaluateLambda(func, args) funziona in modo simile a evaluateFunc(func, args), applicando una funzione definita dall'utente first(expr) ai suoi argomenti definiti in rest(expr). Nel caso di una funzione definita dall'utente abbiamo due tipi di argomenti in rest(expr), un elenco di parametri locali seguiti da una o più espressioni del corpo valutate in sequenza.
Sia, evaluateFunc(func, args) e evaluateLambda(func, args) restituiranno un oggetto cella LISP appena creato o copiato, che può essere qualsiasi tipo di espressione sopra menzionata. Dalla versione 10.0, molte funzioni built-in elaborate con evaluateFunc(func, args) sono ottimizzate e restituiscono riferimenti invece di oggetti appena creati o copiati. Fatta eccezione per queste ottimizzazioni, i valori dei risultati saranno sempre gli oggetti di cella LISP appena creati destinati a essere distrutti al successivo livello di valutazione più alto, dopo che la funzione evaluateExpression (expr) corrente è stata eseguita.

Entrambe le funzioni chiamano ricorsivamente evaluateExpression(expr) per valutare i loro argomenti. Con l'aumentare della ricorsione, aumenta il livello di ricorsione della funzione.

Prima del ritorno di evaluateExpression(func, args), questa popolerà il resultStack eliminando i valori del risultato dal livello più profondo di valutazione e restituito da una delle due funzioni, evaluateFunc o evaluateLambda.

Qualsiasi espressione di risultato appena creata è destinata a essere distrutta in seguito, ma la sua cancellazione viene ritardata fino a raggiungere un livello di valutazione più alto, meno profondo. Ciò consente di utilizzare e/o copiare i risultati richiamando le funzioni.

L'esempio seguente mostra la valutazione di una piccola funzione LISP sum-of-squares definita dall'utente e la creazione e l'eliminazione di oggetti di memoria associati:

(define (sum-of-squares x y)
  (+ (* x x) (* y y)))

(sum-of-squares 3 4) => 25

sum-of-squares è una funzione lambda definita dall'utente che chiama le funzioni built-in + e *.

Il seguente trace mostra i passaggi rilevanti quando si definisce la funzione somma dei quadrati e quando si esegue con gli argomenti 3 e 4.

> (define (sum-of-squares x y) (+ (* x x) (* y y)))

level 0: evaluateExpression( (define (sum-of-squares x y)
 (+ (* x x) (* y y))) )
level 1: evaluateFunc( define <6598> )
level 1: return( (lambda (x y) (+ (* x x) (* y y))) )

→ (lambda (x y) (+ (* x x) (* y y)))

> (sum-of-squares 3 4)

level 0: evaluateExpression( (sum-of-squares 3 4) )
level 1:   evaluateLambda( (lambda (x y) (+ (* x x) (* y y))), (3 4) )
level 1:   evaluateExpression( (+ (* x x) (* y y)) )
level 2:     evaluateFunc( +, ((* x x) (* y y)) )
level 2:     evaluateExpression( (* x x) )
level 3:       evaluateFunc( *, (x x) )
level 3:       pushResultStack( 9 )
level 3:       return( 9 )
level 2:     evaluateExpression( (* y y) )
level 3:       evaluateFunc( *, (y y) )
level 3:       pushResultStack( 16 )
level 3:       return( 16 )
level 2:     popResultStack() → 16
level 2:     popResultStack() → 9
level 2:     pushResultStack( 25 )
level 2:     return( 25 )
level 1:   return( 25 )

→ 25

L'attuale implementazione del linguaggio C è ottimizzata in alcuni punti per evitare di inserire (pop) il resultStack ed evitare di chiamare evaluateExpression (expr). Vengono mostrati solo i passi più rilevanti. La funzione evaluateLambda (func, args) non ha bisogno di valutare i suoi argomenti 3 e 4 perché sono costanti, ma evaluateLambda(func, args) chiamerà evaluateExpression(expr) due volte per valutare le due espressioni del corpo (+ (* xx) e (+ (* xx). Linee precedute dal prompt > mostrano l'input della riga di comando.

evaluateLambda(func, args) salva anche l'ambiente per i simboli variabili x e y, copia i parametri in variabili locali e ripristina il vecchio ambiente all'uscita. Anche queste azioni comportano la creazione e la cancellazione di oggetti di memoria. I dettagli sono omessi perché sono simili ai metodi in altri linguaggi dinamici.

Riferimenti
– Glenn Krasner, 1983: Smalltalk-80, Bits of History, Words of Advice
Addison Wesley Publishing Company

– Richard Jones, Rafael Lins, 1996: Garbage Collection, Algorithms for Automatic Dynamic Memory Management
John Wiley & Sons

¹ Gli algoritmi Reference counting and mark-and-sweep sono stati  sviluppati appositamente per il LISP. Altri schemi come la copia o gli algoritmi generazionali sono stati sviluppati per altri linguaggi come Smalltalk e successivamente anche in LISP.

² Questo capitolo è stato aggiunto nell'ottobre 2008 ed è stato esteso ad agosto 2011.

³ Questa è una versione abbreviata della valutazione delle espressioni che non include la gestione dei funtori predefiniti e l'indicizzazione implicita. Per ulteriori informazioni sulla valutazione delle espressioni, consultare: "Valutazione dell'espressione, Indicizzazione implicita, Contesti e Funtori di default"


============================================================================
 Benchmarking newLISP
============================================================================

Questo documento contiene tutte le funzioni utilizzate da Lutz Mueller per il Benckmark di newLISP. Le funzioni sono state leggermente modificate per il sistema operativo Windows.

Lista delle funzioni:

 1) Ackerman
 2) Array Access
 3) Concatenate
 4) Count Words
 5) Deque Lists
 6) Echo Client/Server
 7) Exceptions
 8) Fannkuch
 9) Fibonacci Numbers
10) Hash Access
11) Hash Update
12) Heap Sort
13) Matrix Multiplication
14) Method Calls
15) Nested Loops
16) Nsieve
17) Object Instantiation
18) Prime
19) Random Numbers
20) Regular Expressions
21) Reverse a File
22) Spell Checker
23) Startup
24) Statistical Moments
25) Sum a File of Numbers
26) Synchronize
27) Takfp
28) Word Frequency

---------------------------------------------------------------------
;;
;; Ackermann's Function
;; by Brent Fulgham
;;

(define (ack m n)
    (cond ((= m 0) (+ n 1))
          ((= n 0) (ack (- m 1) 1))
    (true    (ack (- m 1) (ack m (- n 1))))))

(define (main)
    (set 'N (integer (last (main-args))))
    (println
        (format "Ack(3,%d): %d" N (ack 3 N))))

---------------------------------------------------------------------
;;
;; Array Access
;; (requires newLISP 9.0)
;;

(define (main)
  (set 'n (integer (main-args 2)))
  (set 'x (array n (sequence 1 n)))
  (set 'y (array n '(0)))
  (dotimes (k 1000)
    (for (i (- n 1) 0)
      (nth-set (y i) (+ (y i) (x i)) )))
  (println (y 0) " " (y (- n 1) )))

---------------------------------------------------------------------
;;
;; Concatenate Strings
;; (requires newLISP 8.3.0)
;;

(set 'n (integer (main-args 2)))
(set 'str "")
(dotimes (i n) (write-buffer str "hello\n"))
(println (length str))

---------------------------------------------------------------------
;;
;; Count Words
;;

(set 'lc 0 'wc 0 'cc 0)
(while (set 'line (read-line))
  (inc 'lc)
  (inc 'wc (length (parse (trim line) "\\s+" 0)))
  (inc 'cc (+ (length line) 1))) ;; add back the line feed
(println lc " " wc " " cc)

---------------------------------------------------------------------
;;
;; Deque Lists
;; (requires newLISP 8.3.0)
;; (mimics Python's way)
;;

(set 'SIZE 10000)
(define (test-lists)
  (set 'Li1  (sequence 1 SIZE))
  (set 'Li2 Li1)
  (set 'Li3 '())
  ; remove each item from left of Li2 and append to Li3
  (reverse Li2)
  (while Li2 (push (pop Li2) Li3 -1))
  (while Li3 (push (pop Li3) Li2 -1))
  (reverse Li1)
  (if   (!= (first Li1) SIZE) 0
    (= Li1 Li2) (length Li1)
    0))
(set 'n (integer (main-args 2)))
(dotimes (i n)
  (set 'result (test-lists)))
(println result)

---------------------------------------------------------------------
;;
;; Echo Client/Server
;; (requires newLISP 9.0.0)
;; do not work on Windows
;;

(set 'DATA "Hello there sailor\n");
(set 'bufferSize (length DATA))
(define (server port)
  (set 'listen (net-listen port))
  (set 'connection (net-accept listen))
  (set 'N 0)
  (while (net-receive connection 'buff bufferSize)
    (inc 'N (length buff))
    (net-send connection buff))
  (net-close connection)
  (net-close listen)
  (println "server processed " N " bytes"))

(define (client port n)
  (set 'connection (net-connect "127.0.0.1" port))
  (dotimes (x n)
    (net-send connection DATA)
    (net-receive connection 'buff bufferSize)
    (if (!= buff DATA) (println "Received different message: " buff)))
  (net-close connection))

(set 'n (integer (main-args 2)))

(fork (server 100001))
(sleep 100)
(client 100001 n)

---------------------------------------------------------------------
;;
;; Exceptions
;; (requires newLISP 7.5.1)
;;

(context 'MAIN)

(set 'HI 0 'LO 0)

(define (some_function num)
  (catch (hi_function num) 'result)
  (if (not (integer? result))
    (println "we never get here")))

(define (hi_function num)
  (catch (lo_function num) 'result)
  (if (= result 'HI_exception)
    (inc 'HI)
    (throw result)))

(define (lo_function num)
  (catch (blowup num) 'result)
  (if (= result 'LO_exception)
    (inc 'LO)
    (throw result)))

(define (blowup num)
  (if (= (& num 1) 1)
    (throw 'HI_exception)
    (throw 'LO_exception)))

(define (main)
  (dotimes (i n)
    (some_function i))
  (println "Exceptions: HI=" HI " / LO=" LO))

(set 'n (integer (nth 2 (main-args))))

(main)

---------------------------------------------------------------------
;;
;; Fannkuch 9.0
;; by Lutz Mueller 2004-12-11
;;

(define MaxCount 0)

(define (permute left right)
    (let (j (length right))
        (if (< j 2)
            (permCount (append left right))
            (dotimes (i j)
                (permute (append left (slice right i 1))
                         (append (slice right 0 i) (slice right (+ i 1))))))))

(define (permCount perm , myCount perm0)
        (set 'myCount 0)
        (while (!= (set 'perm0 (first perm)) 1)
            (inc 'myCount)
            (set 'perm (append (reverse (slice perm 0 perm0)) (slice perm perm0))))
        (if (> myCount MaxCount) (set 'MaxCount myCount)))

(define (fannkuch n)
    (permute '() (sequence 1 n))
    MaxCount)

(define (main)
    (set 'n (integer (main-args 2)))
    (println (format "Pfannkuchen(%d) = %d" n (fannkuch n))))

(main)

---------------------------------------------------------------------
;;
;; Fibonacci Numbers
;;

(define (fibo n)
  (if(< n 2) 1
  (+  (fibo (- n 1))
      (fibo (- n 2)))))

(println (fibo (integer (main-args 2))))

---------------------------------------------------------------------
;;
;; Hash Access
;; create i = 1..n symbols with value i
;; count all exsiting symbols in reverse
;;
;; newLISP does not have hashtables but can
;; simulate hashes with symbols
;;

(context 'HASH) ; create hash container
(context 'MAIN) ; go back to MAIN context

(set 'n (integer (main-args 2)))

(for (i 1 n)
  (set (sym (format "_%x" i) HASH) i) )

(set 'cnt 0)
(for (i n 1)
  (if (sym (format "_%d"  i) HASH nil) (inc 'cnt)))

(println cnt)

---------------------------------------------------------------------
;;
;; Hash update
;;
;; newLISP does not have hashtables but can
;; simulate hashes efficient with symbols
;;

(context 'Hash1) ; create hash container
(context 'MAIN) ; go back to MAIN context
(context 'Hash2) ; create hash container
(context 'MAIN) ; go back to MAIN context

(set 'n (integer (main-args 2)))

(dotimes (i 10000)
  (set (sym (format "foo_%d" i) Hash1) i) )

(dotimes (i n)
  (dotree (k Hash1)
    (set 'key (sym (name k) Hash2 nil))
    (if key
      (inc key (eval k))
      (set (sym (name k) Hash2) (eval k)))))

(println Hash1:foo_1 " " Hash1:foo_9999 " " Hash2:foo_1 " " Hash2:foo_9999)

---------------------------------------------------------------------
;;
;; Heap Sort
;;
;; newLISP has fast built-in sort and random algorithms
;; not used in this benchmark
;;

(set 'IM 139968)
(set 'IA 3877)
(set 'IC 29573)

(set 'LAST 42)

(define (gen_random maximum)
  (set 'LAST (mod (add (mul LAST IA) IC) IM))
  (div (mul maximum LAST) IM))

(define (heapsort n ra)
  (set 'rra 0 'i 0 'j 0)
  (set 'l (+ (>> n 1) 1))
  (set 'ir n)

  (while (not done)
    (if (> l 1)
      (begin
        (dec 'l)
        (set 'rra (ra l)))
      (begin
        (set 'rra (ra ir))
        (nth-set ir ra (ra 1))
        (dec 'ir)
        (if (= ir 1)
          (begin
            (nth-set (ra 1) rra)
            (set 'done true)
            ; return
            ra))))
    (set 'i l)
    (set 'j (<< l 1))
    (if (not done) (begin
      (while (<= j ir)
        (if (and (< j ir) (< (ra j) (ra (+ j 1))))
          (inc ' j))
        (if (< rra (ra j))
          (begin
            (nth-set (ra i) (ra j))
            (set 'i j)
            (inc 'j i))
          (set 'j (+ ir 1))))
      (nth-set (ra i) rra))
    ) ra))

(define (main)
  (set 'N (integer (last (main-args))))

  (set 'ary (array (+ N 1)))

  (for (i 1 N) (nth-set (ary i) (gen_random 1.0)))

  (set 'ary (heapsort N ary))

  (println (format "%.10f" (ary N)))
)

(main)

---------------------------------------------------------------------
;;
;; Matrix Multiplication
;; since version 9.0 matrix finctions can also be used
;; on array types, additionally to lists.
;;

(set 'size 30)

(define (mkmatrix rows cols)
  (map (fn (i) (sequence (+ (* i cols) 1)  (+ (* i cols) cols))) (sequence 0 (- rows 1))))

(define (main n)
  (set 'm1 (mkmatrix size size))
  (set 'm2 m1)
  (dotimes (i n)
    (set 'm3 (multiply m1 m2)))
  (println (m3 0 0) " " (m3 2 3) " " (m3 3 2) " " (m3 4 4)))

(set 'n (integer (main-args 2)))

(main n)

---------------------------------------------------------------------
;;
;; Method Calls
;;
;; this is almost identical Object Instantiation
;; but here method call is measured instead of
;; object creation/instantiation
;;

; define class Toggle

(context 'Toggle)

(define (init start_state)
  (set 'bool start_state))

(define (value)
  bool)

(define (activate)
  (set 'bool (not bool)))

(context 'MAIN)

; subclass Toggle to NthToggle and overwrite methods

(new Toggle 'NthToggle)

(context NthToggle)

(define (init start_state max_counter)
  (set 'bool start_state)
  (set 'count_max max_counter)
  (set 'counter 0))

(define (activate)
  (inc 'counter)
  (if (>= counter count_max)
    (begin
      (set 'bool (not bool))
      (set 'counter 0))
                counter ))

(context 'MAIN)

; Method calls
; get n from command line

(set 'n (integer (main-args 2)))

(define (main)
  (new Toggle 'toggle)
  (toggle:init true)

  (dotimes (x n)
    (toggle:activate)
    (set 'val toggle:value))

  (if (toggle:value) (println "true") (println "false"))

  (new NthToggle 'ntoggle)
  (ntoggle:init true 3)

  (dotimes (x n)
    (ntoggle:activate)
    (set 'val ntoggle:value))

  (if (ntoggle:value) (println "true") (println "false"))
  )

(main)

---------------------------------------------------------------------
;;
;; Nested Loops
;;
;; newLISP also has a 'for' which takes an initializer
;; for the looping variable and is a bit slower
;;

(set 'n (integer (main-args 2)))
(set 'x 0)
(dotimes (a n)
  (dotimes (b n)
    (dotimes (c n)
      (dotimes (d n)
        (dotimes (e n)
          (dotimes (f n)
            (inc 'x)))))))
(println x)

(set 'n (integer (main-args 2)))
(set 'x 0)
(for (a 1 n)
  (for (b 1 n)
    (for (c 1 n)
      (for (d 1 n)
        (for (e 1 n)
          (for (f 1 n)
            (inc 'x)))))))
(println x)

---------------------------------------------------------------------
;;
;; Nsieve
;;
;; by Lutz Mueller 2004-12-11
;;
;; A solution with a newLISP array for flags is about the same
;; speed but uses much more memory. Here a character vector is
;; manipulated directly.
;;

(define (nsieve m f, cnt)
  (set 'cnt 0)
        (for (i 2 m)
            (if (= (char f:isPrime i) 1)
                (begin
                    (set 'k (+ i i))
                    (while (<= k m)
                        (cpymem "\000" (+ k (address f:isPrime)) 1)
                        (inc k i))
          (inc cnt))))
         cnt)

(define (main)
    (set 'n (integer (main-args 2)))
    (set 'm (* (pow 2 n) 10000))
    (set 'flags:isPrime (dup "\001" (+ m 1) ))
    (println (format "Primes up to %8d%8d" m (nsieve m flags)))
    (set 'm (* (pow 2 (- n 1)) 10000))
    (println (format "Primes up to %8d%8d" m (nsieve m flags)))
    (set 'm (* (pow 2 (- n 2)) 10000))
    (println (format "Primes up to %8d%8d" m (nsieve m flags)))
    )

(main)

---------------------------------------------------------------------
;;
;; Object Instantiation
;;

; define class Toggle

(context 'Toggle)

(define (init start_state)
  (set 'bool start_state))

(define (value)
  bool)

(define (activate)
  (set 'bool (not bool)))

(context 'MAIN)

; subclass Toggle to NthToggle and overwrite methods

(new Toggle 'NthToggle)

(context NthToggle)

(define (init start_state max_counter)
  (set 'bool start_state)
  (set 'count_max max_counter)
  (set 'counter 0))

(define (activate)
  (inc 'counter)
  (if (>= counter count_max)
    (begin
      (set 'bool (not bool))
      (set 'counter 0))
                counter ))

(context 'MAIN)

; get n from command line

(set 'n (integer (main-args 2)))

(define (main)
  (new Toggle 'toggle)
  (toggle:init true)

  (dotimes (x 5)
    (toggle:activate)
    (if (toggle:value) (println "true") (println "false")))

  (dotimes (x n)
    (new Toggle 'toggle)
    (toggle:init true))

  (println)

  (new NthToggle 'ntoggle)
  (ntoggle:init true 3)

  (dotimes (x 8)
    (ntoggle:activate)
    (if (ntoggle:value) (println "true") (println "false")))

  (dotimes (x n)
    (new NthToggle 'ntoggle)
    (ntoggle:init true 3))
  )

(main)

---------------------------------------------------------------------
;;
;; Prime
;; (requires newLISP 7.5.2)
;;

(define (main)
  (set 'NUM (integer (main-args 2)))

  (dotimes (p NUM)
    (set 'flags (array 8193 '(1)))
    (set 'cnt 0)

    (for (i 2 8192)
      (if (= (nth i flags) 1)
        (begin
          (set 'k (+ i i))
          (while (<= k 8192)
            (nth-set k flags 0)
            (inc 'k i))
          (inc 'cnt)))))

  (println "Count: " cnt))

(main)

---------------------------------------------------------------------
;;
;; Random Numbers
;;
;; note, that newLISP has various fast built-in random
;; functions which are not used here
;;

(set 'IM 139968)
(set 'IA 3877)
(set 'IC 29573)

(set 'LAST 42)

(define (gen_random maximum)
  (set 'LAST (mod (add (mul LAST IA) IC) IM))
  (div (mul maximum LAST) IM))

(define (main)
  (set 'N (integer (main-args 2)))
  (dotimes (i (- N 1)) (gen_random 100.0))
  (println (format "%.9f" (gen_random 100.0))) )

(main)

---------------------------------------------------------------------
;;
;; Regular Expressions
;; get phone data from stdin
;;

(while (read-line) (push (append (current-line) "\n") phones))
(reverse phones)

;; patterns
(set 'pattern (append
    {(?:^|[^\d\(])}   ; must be preceeded by non-digit
    {(\()?}       ; match 1: possible initial left paren
    {(\d\d\d)}      ; match 2: area code is 3 digits
    {(?(1)\))}      ; if match1 then match right paren
    {[ ]}       ; area code followed by one space
    {(\d\d\d)}      ; match 3: prefix of 3 digits
    {[ -]}            ; separator is either space or dash
    {(\d\d\d\d)}      ; match 4: last 4 digits
    {\D}        ; must be followed by a non-digit
))

;; get N
(set 'N (integer (last (main-args))))
(set 'cnt 0)

(dotimes (i N)
  (dolist (phone phones)
    (if (regex pattern phone)
        (if (= i 0)
          (begin
            (inc 'cnt)
            (println (string cnt ": (" $2 ") " $3 "-" $4)))))))

---------------------------------------------------------------------
;;
;; Reverse a File
;;

(while (read-line) (push (current-line) file))
(println (join file "\n"))

---------------------------------------------------------------------
;;
;; Spell Checker
;; (requires newLISP 8.3.0)

(context 'MAIN)

(define (main)
  (set 'infile (open "Usr.Dict.Words" "read"))
  (while (set 'word (read-line infile))
    (sym word 'Dictionary))
  (close infile)

  (while (set 'word (read-line))
    (if (not (sym word 'Dictionary nil))
      (println word))))

(main)

---------------------------------------------------------------------
;;
;; Startup
;;

(println "Hello World")

---------------------------------------------------------------------
;;
;; Statistical Moments
;; read file filter empty lines
;;

(define (main)
  (while (read-line) (push (float (current-line)) nums))
  (set 'nums (reverse (filter float? nums)))
  (set 'n (length nums))
  (set 'sum (apply add nums))
  (set 'mean (div sum n))
  (set 'avg-dev 0 'std-dev 0 'var 0 'skew 0 'kurtosis 0)
  (set 'dev (map sub nums (dup mean n)))
  (set 'avg-dev (div (apply add (map abs dev)) n))
  (set 'var (div (apply add (map mul dev dev)) (- n 1)))
  (set 'skew (apply add (map mul dev dev dev)))
  (set 'kurtosis (apply add (map  mul dev dev dev dev)))
  (set 'std-dev (sqrt var))
  (if (> var 0.0)
    (begin
  (set 'skew (div skew (mul n var std-dev)))
  (set 'kurtosis (sub (div kurtosis (mul n var var)) 3.0))))
  (sort nums)
  (set 'mid (/ n 2))
  (if (= 0 (% n 2))
  (set 'median (div (add (nums mid) (nums (- mid 1))) 2))
  (set 'median (nums mid)))
  (println (format "n:                  %d" n))
  (println (format "median:             %f" median))
  (println (format "mean:               %f" mean))
  (println (format "average_deviation:  %f" avg-dev))
  (println (format "standard_deviation: %f" std-dev))
  (println (format "variance:           %f" var))
  (println (format "skew:               %f" skew))
  (println (format "kurtosis:           %f" kurtosis))
)

(main)

---------------------------------------------------------------------
;;
;; Sum a File of Numbers
;;

(set 'sum 0)
(while (read-line) (inc 'sum (integer (current-line))))
(println sum)

---------------------------------------------------------------------
;;
;; Synchronize
;; producer/consumer
;; (requires newLISP 8.3.0)
;; Note that newLISP does not use Pthreads,
;; but classic UNIX/fork() processes
;; therefore no mutexes amd condition variables,
;; but semaphores and shared memory
;;

(constant 'wait -1 'sig 1)

(define (consumer n)
  (set 'i 0)
  (while (< i n)
    (semaphore cons-sem wait)
    (set 'i (share data))
    (share consumed (+ (share consumed) 1))
    (semaphore prod-sem sig))
  (exit))

(define (producer n)
  (for (i 1 n)
    (semaphore prod-sem wait)
    (share data i)
    (share produced (+ (share produced) 1))
    (semaphore cons-sem sig))
  (exit))

(define (main n)
  (set 'produced (share)) ; get shared mem addresses
  (set 'consumed (share))
  (set 'data (share))

  (share produced 0) ; init shared memory
  (share consumed 0)
  (share data 0)

  (set 'prod-sem (semaphore)) ; get semaphores
  (set 'cons-sem (semaphore))

  (set 'prod-pid (fork (producer n))) ; start processes
  (set 'cons-pid (fork (consumer n)))
  (semaphore prod-sem sig) ; get producer started

  (wait-pid prod-pid) ; wait for processe to finish
  (wait-pid cons-pid)
  (semaphore cons-sem 0) ; release semaphore
  (semaphore prod-sem 0) ; release semaphore

  (println (share produced) " " (share consumed)))

(main (integer (last (main-args))))

(exit)

---------------------------------------------------------------------
;;
;; -*- mode: lisp -*-
;; $Id: takfp-newlisp.code,v 1.1 2004/12/05 21:22:46 bfulgham Exp $
;; http://shootout.alioth.debian.org/
;; Contributed by Brent Fulgham
;; changes L.M. 2004/12/13
;;

;;; switch int-ops to float-ops
(constant '- sub '* mul)

(define (tak x y z)
  (if (>= y x)
      z
      (tak (tak (- x 1) y z) (tak (- y 1) z x) (tak (- z 1) x y))))

(define (main)
  (set 'n (integer (last (main-args))))
  (println
    (format "%.1f" (tak (* n 3.0) (* n 2.0) (* n 1.0) ))))

(main)

---------------------------------------------------------------------
;;
;; Word Frequency
;; create a context/namespace to hold words
;; since version 8.8 newLISP has a built in function
;; bayes-query, which will do the counting in just
;; one statement and much faster
;;

(context 'wc)
(context MAIN)

(define (main)
;;  (HASH:make 'wc)
  (while (read-line)
    (set 'data (parse (lower-case (current-line)) "[^a-z]+" 0))
    (dolist (w data)
      (if (set 'result (eval (symbol (append "_" w) wc) ))
        (set (symbol (append "_" w) wc) (+ result 1))
        (set (symbol (append "_" w) wc) 1))))
  (dolist (w (symbols wc))
    (set 'wrd (name w))
    (if (and (starts-with wrd "_") (!= "_" wrd))
      (push (list (eval w) (slice wrd 1) ) words) ))
  (dolist (w (reverse (sort words)))
    (println (format "%7d %s" (first w) (last w))))
  )

(main)
---------------------------------------------------------------------


============================================================================
 Frasi sulla Programmazione e sul Linguaggio Lisp
============================================================================

"I know nothing except this statement."
- anonymous

"Programs must be written for people to read, and only incidentally for machines to execute."
- Abelson & Sussman, SICP, preface to the first edition

"Lisp is a programmable programming language."
- John Foderaro, CACM, September 1991

"Lisp is worth learning for the profound enlightenment experience you will have when you finally get it; that experience will make you a better programmer for the rest of your days, even if you never actually use Lisp itself a lot."
- Eric Raymond, "How to Become a Hacker"

"Lisp has jokingly been called: 'the most intelligent way to misuse a computer'. I think that description is a great compliment because it transmits the full flavor of liberation: it has assisted a number of our most gifted fellow humans in thinking previously impossible thoughts."
- Edsger Dijkstra, CACM, 15:10

"The competent programmer is fully aware of the strictly limited size of his own skull; therefore he approaches the programming task in full humility, and among other things he avoids clever tricks like the plague."
- Edsger Dijkstra

"Testing can show the presence of errors, but not their absence."
- Edsger Dijkstra

"Lisp isn't a language, it's a building material."
- Alan Kay

"Lisp was far more powerful and flexible than any other language of its day; in fact, it is still a better design than most languages of today, twenty-five years later. Lisp freed ITS's hackers to think in unusual and creative ways. It was a major factor in their successes, and remains one of hackerdom's favorite languages."
- Eric Raymond, in "Open Sources: Voices from the Open Source Revolution", 1999

"I suppose I should learn Lisp, but it seems so foreign."
- Paul Graham, Nov 1983

"The only way to learn a new programming language is by writing programs in it."
- Kernighan and Ritchie

"Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it."
- Kernighan

"Most languages in computer science describe how their author learned what someone else already developed."
- anonymous

"In order to understand recursion, one must first understand recursion."
- anonymous

"It is better to first strive for clarity and correctness and to make programs efficient only if really needed."
- "Getting Started with Erlang" by Ericsson

"Good programming: before writing code, one should "design" a program and the best way to do that is with a flow chart."
- Klein, Godunov

"Rules of optimization: Rule #1: Don't do it. Rule #2 (for experts only): Don't do it yet."
- Michael A. Jackson

"Cavemen in bearskins invaded the ivory towers of Artificial Intelligence. Nine months later, they left with a baby named newLISP. The women of the ivory towers wept and wailed. 'Abomination!' they cried."
- TedWalther

"On every new project/problem, newLISP behave like a chameleon. It changed to a new language (of the Lisp-family) for solving that problem."
- Hans-Peter

"All profound and true things are simple. Complexity is vanity."
- Lutz Mueller  (creator of newLISP)

"Incorrect documentation is often worse than no documentation."
- Bertrand Meyer

"Correctness is clearly the prime quality. If a system does not do what it is supposed to do, then everything else about it matters little."
- Bertrand Meyer

"It pays to know the dark corners of your language."
- anonymous

"Learning from your mistakes is one of the best ways to learn."
- anonymous

"The secret to creativity is knowing how to hide your sources."
- Albert Einstein

" The true logic of this world is the calculus of probabilities."
- James Clerk Maxwell

"The value of a prototype is in the education it gives you, not in the code itself."
- Alan Cooper

"The most disastrous thing that you can ever learn is your first programming language."
- Alan Kay

"A programmer does not primarily write code. Rather, he primarily writes to another programmer about his problem solution. The understanding of this fact is the final step in his maturation as technician."
- anonymous

"Sometimes the problem is to discover what the problem is."
- Gordon Glegg

"A person without data is just another person with an opinion."
- anonymous

"Features, quality, time: pick two."
- anonymous

"User: this is not what we want. Programmer: maybe, but this is what you asked."
- anonymous

"Perchè i governi non hanno mai tempo per fare le cose per bene, ma hanno sempre tempo per rifarle da capo?"
- anonymous

"Any non-trivial program contains at least one bug."
- anonymous

"99.9% of times the error was by programmer, non computer."
- anonymous

"It's not a bug — it's an undocumented feature."
- anonymous

"All users are beta-tester."
- anonymous

"A computer is a stupid machine with the ability to do incredibly smart things, while computer programmers are smart people with the ability to do incredibly stupid things. They are, in short, a perfect match."
- anonymous

"Another effective technique is to explain your code to someone else. This will often cause you to explain the bug to yourself. Sometimes it takes no more than a few sentences, followed by an embarrassed “Never mind, I see what's wrong. Sorry to bother you.” This works remarkably well: you can even use non-programmers as listeners. One university computer center kept a teddy bear near the help desk. Students with mysterious bugs were required to explain them to the bear before they could speak to a human counselor."
- Brian Kernighan

"Don't comment bad code ‐ rewrite it."
- Brian Kernighan

"Theory is when you know something, but it doesn't work. Practice is when something works, but you don't know why. Programmers combine theory and practice: Nothing works and they don't know why."
- anonymous

"Never trust a programmer in a suit."
- anonymous

"It works on my machine."
- anonymous

"There is only one ways to write error-free programs: do not write it."
- anonymous

"The amount of energy necessary to refute stupidity/bullshit is an order of magnitude bigger than to produce it."
- anonymous

"Programmers have to fight against the two most destructive forces in the universe: entropy and stupidity."
- Damian Conway

"There's no time like the present."
- anonymous

"DRY ‐ Don't Repeat Yourself."
- anonymous

"Computer Science is no more about computers than astronomy is about telescopes."
- Edsger Dijkstra

"If debugging is the process of removing software bugs, then programming must be the process of putting them in."
- Edsger Dijkstra

"Walking on water and developing software from a specification are easy if both are frozen."
- Edward Berard

"First learn computer science and all the theory. Next develop a programming style. Then forget all that and just hack."
- George Carrette

"Deleted code don't need debugging"
- anonymous

"Sometimes, the elegant implementation is just a function. Not a method. Not a class. Not a framework. Just a function."
- John Carmack

"It's a lot easier to talk about code than it is to write code."
- John O'Nolan

"First, solve the problem. Then, write the code."
- John Johnson

"Hope is not a plan."
- Jonathan Rosenberg

"The number one skill required for learning any complex system is patience."
Kelsey Hightower

"When in doubt, use brute force."
- Ken Thompson

"Deleting lines of code can be more productive than writing."
- Anonymous

"There's nothing more permanent than a temporary hack."
- Kile Simpson

"To iterate is human, to recurse divine."
- Peter Deutsch

"When you feel the need to write a comment, first try to refactor the code so that any comment becomes superfluous."
- Martin Fowler

"Rarely is anyone thanked for the work they did to prevent the disaster that didn't happen."
- Mikko Hypponen

"Hardware eventually fails. Software eventually works."
- Michael Hartung

"Anything that can possibly go wrong, will go wrong."
- Murphy's Law

"Security is a state of mind."
- NSA Security Manual

"We crave for new sensations but soon become indifferent to them. Wonders of yesterday are today common occurrences."
- Nikola tesla

"One of the best programming skills you can have is knowing when to walk away for awhile."
- Oscar godson

"Playfully doing something difficult, whether useful or not, that is hacking."
- Richard Stallman

"Data dominates. If you've chosen the right data structures and organized things well, the algorithms will almost always be self-evident. Data structures, not algorithms, are central to programming."
- Rob Pike

"Another effective technique is to explain your code to someone else. This will often cause you to explain the bug to yourself. Sometimes it takes no more than a few sentences, followed by an embarrassed "Never mind, I see what's wrong. Sorry to bother you." This works remarkably well. You can even use non-programmers as listeners. One university computer center kept a teddy bear near the help desk. Students with mysterious bugs were required to explain them to the bear before they could speak to a human counselor."
- Rob Pike

"Code never lies, comments sometimes do."
- Ron Jeffries

"When debugging, novices insert corrective code; experts remove defective code."
- Richard Pattis

"Programming start from "Spaghetti Code" and ends with "Lasagna Code" (too many layers)."
- anonymous

"Functions should do one thing. They should do it well. They should do it only."
- Robert C. Martin

"The first rule of functions is that they should be small. The second rule of functions is that they should be smaller than that."
- Robert C. Martin

"The ideal numbers of arguments for a function is zero (niladic). Next comes one (monadic), followed closely by two (dyadic). Three arguments (triadic) should be avoided where possible. More than three (polyadic) requires very special justification ‐ and then shouldn't be used anyway."
- Robert C. Martin

"The longer it takes for a bug to surface, the harder it is to find."
- Roedy Green

"Necessity is the Mother of Invention, Play is its Father."
- unknown

"You are not a Bayesian homunculus whose reasoning is “corrupted” by cognitive biases. You just are cognitive biases."
- Luke Muehlhauser

"Simple is:
1. Clear abstraction: smart, well-drawn layers of "knowledge focus" that allow hiding of details.
2. Clean expression: meaningful, concise but not cryptic, representation and communication of concepts."
- Carl Sassenrath

"There are only two hard things in Computer Science: cache invalidation and naming things."
- Phil Karlton

"È più facile scrivere un codice nuovo che capirne uno vecchio."
John Von Neumann

"Se è così semplice creare organismi viventi, perchè non ne create uno voi?"
Nils Aaal Barricelli

"L'assenza di segnale non dovrebbe mai essere usata come segnale"
Julian Bigelow

"La parte che è stabile la prevederemo. E la parte che è instabile la controlleremo."
John Von Neumann

"Il fattore 4 è un dono di Dio (o dell'altra fazione)."
John Von Neumann

"Non vedo il problema dal punto di vista del matematico, come fece per esempio Von Neumann, lo vedo dal punto di vista dell'ingegnere.
Forse è un bene che manchi quasi totalmente un supporto per idee del genere.
Magari c'è pure il diavolo dietro."
Konrad Zuse


============================================================================
 Prefissi del Sistema Internazionale di unità di misura
============================================================================

Prefisso   Simbolo   Fattore    Scala lunga      Scala corta
------------------------------------------------------------
yotta      Y         10^24      Quadrilione      Septillion
zetta      Z         10^21      Triliardo        Sextillion
exa        E         10^18      Trilione         Quintillion
peta       P         10^15      Biliardo         Quadrillion
tera       T         10^12      Bilione          Trillion
giga       G         10^9       Miliardo         Billion
mega       M         10^6       Milione          Million
kilo       k         10^3       Mille            Thousand
hecto      h         10^2       Cento            Hundred
deca       da        10^1       Dieci            Ten
                     10^0       Uno              One
deci       d         10^-1      Decimo           Tenth
centi      c         10^-2      Centesimo        Hundredth
milli      m         10^-3      Millesimo        Thousandth
micro      µ         10^-6      Milionesimo      Millionth
nano       n         10^-9      Miliardesimo     Billionth
pico       p         10^-12     Bilionesimo      Trillionth
femto      f         10^-15     Biliardesimo     Quadrillionth
atto       a         10^-18     Trilionesimo     Quintillionth
zepto      z         10^-21     Triliardesimo    Sextilionth
yocto      y         10^-24     Quadrilionesimo  Septillionth


============================================================================
 Alfabeto greco
============================================================================

  +---------+---------+
  | Nome    | Simbolo |
  +---------+---------+
  | alpha   |  α      |
  | beta    |  β      |
  | gamma   |  γ      |
  | delta   |  δ      |
  | epsilon |  ε      |
  | zeta    |  ζ      |
  | eta     |  η      |
  | theta   |  θ, ϑ   |
  | iota    |  ι      |
  | kappa   |  κ      |
  | lambda  |  λ      |
  | xi      |  ξ      |
  | pi      |  π      |
  | rho     |  ρ      |
  | mu      |  μ      |
  | nu      |  ν      |
  | sigma   |  σ      |
  | tau     |  τ      |
  | upsilon |  υ      |
  | phi     |  φ, ϕ   |
  | chi     |  χ      |
  | psi     |  ψ      |
  | omega   |  ω      |
  | omicron |  o      |
  +---------+---------+


=============
 Colori HTML
=============

Lista dei colori HTML (140)
(ordinati per codice esadecimale)

(setq color '(
  ($000000 Black)
  ($000080 Navy)
  ($00008B DarkBlue)
  ($0000CD MediumBlue)
  ($0000FF Blue)
  ($006400 DarkGreen)
  ($008000 Green)
  ($008080 Teal)
  ($008B8B DarkCyan)
  ($00BFFF DeepSkyBlue)
  ($00CED1 DarkTurquoise)
  ($00FA9A MediumSpringGreen)
  ($00FF00 Lime)
  ($00FF7F SpringGreen)
  ($00FFFF Aqua)
  ($00FFFF Cyan)
  ($191970 MidnightBlue)
  ($1E90FF DodgerBlue)
  ($20B2AA LightSeaGreen)
  ($228B22 ForestGreen)
  ($2E8B57 SeaGreen)
  ($2F4F4F DarkSlateGray)
  ($2F4F4F DarkSlateGrey)
  ($32CD32 LimeGreen)
  ($3CB371 MediumSeaGreen)
  ($40E0D0 Turquoise)
  ($4169E1 RoyalBlue)
  ($4682B4 SteelBlue)
  ($483D8B DarkSlateBlue)
  ($48D1CC MediumTurquoise)
  ($4B0082 Indigo)
  ($556B2F DarkOliveGreen)
  ($5F9EA0 CadetBlue)
  ($6495ED CornflowerBlue)
  ($663399 RebeccaPurple)
  ($66CDAA MediumAquaMarine)
  ($696969 DimGray)
  ($696969 DimGrey)
  ($6A5ACD SlateBlue)
  ($6B8E23 OliveDrab)
  ($708090 SlateGray)
  ($708090 SlateGrey)
  ($778899 LightSlateGray)
  ($778899 LightSlateGrey)
  ($7B68EE MediumSlateBlue)
  ($7CFC00 LawnGreen)
  ($7FFF00 Chartreuse)
  ($7FFFD4 Aquamarine)
  ($800000 Maroon)
  ($800080 Purple)
  ($808000 Olive)
  ($808080 Gray)
  ($808080 Grey)
  ($87CEEB SkyBlue)
  ($87CEFA LightSkyBlue)
  ($8A2BE2 BlueViolet)
  ($8B0000 DarkRed)
  ($8B008B DarkMagenta)
  ($8B4513 SaddleBrown)
  ($8FBC8F DarkSeaGreen)
  ($90EE90 LightGreen)
  ($9370DB MediumPurple)
  ($9400D3 DarkViolet)
  ($98FB98 PaleGreen)
  ($9932CC DarkOrchid)
  ($9ACD32 YellowGreen)
  ($A0522D Sienna)
  ($A52A2A Brown)
  ($A9A9A9 DarkGray)
  ($A9A9A9 DarkGrey)
  ($ADD8E6 LightBlue)
  ($ADFF2F GreenYellow)
  ($AFEEEE PaleTurquoise)
  ($B0C4DE LightSteelBlue)
  ($B0E0E6 PowderBlue)
  ($B22222 FireBrick)
  ($B8860B DarkGoldenRod)
  ($BA55D3 MediumOrchid)
  ($BC8F8F RosyBrown)
  ($BDB76B DarkKhaki)
  ($C0C0C0 Silver)
  ($C71585 MediumVioletRed)
  ($CD5C5C IndianRed)
  ($CD853F Peru)
  ($D2691E Chocolate)
  ($D2B48C Tan)
  ($D3D3D3 LightGray)
  ($D3D3D3 LightGrey)
  ($D8BFD8 Thistle)
  ($DA70D6 Orchid)
  ($DAA520 GoldenRod)
  ($DB7093 PaleVioletRed)
  ($DC143C Crimson)
  ($DCDCDC Gainsboro)
  ($DDA0DD Plum)
  ($DEB887 BurlyWood)
  ($E0FFFF LightCyan)
  ($E6E6FA Lavender)
  ($E9967A DarkSalmon)
  ($EE82EE Violet)
  ($EEE8AA PaleGoldenRod)
  ($F08080 LightCoral)
  ($F0E68C Khaki)
  ($F0F8FF AliceBlue)
  ($F0FFF0 HoneyDew)
  ($F0FFFF Azure)
  ($F4A460 SandyBrown)
  ($F5DEB3 Wheat)
  ($F5F5DC Beige)
  ($F5F5F5 WhiteSmoke)
  ($F5FFFA MintCream)
  ($F8F8FF GhostWhite)
  ($FA8072 Salmon)
  ($FAEBD7 AntiqueWhite)
  ($FAF0E6 Linen)
  ($FAFAD2 LightGoldenRodYellow)
  ($FDF5E6 OldLace)
  ($FF0000 Red)
  ($FF00FF Fuchsia)
  ($FF00FF Magenta)
  ($FF1493 DeepPink)
  ($FF4500 OrangeRed)
  ($FF6347 Tomato)
  ($FF69B4 HotPink)
  ($FF7F50 Coral)
  ($FF8C00 DarkOrange)
  ($FFA07A LightSalmon)
  ($FFA500 Orange)
  ($FFB6C1 LightPink)
  ($FFC0CB Pink)
  ($FFD700 Gold)
  ($FFDAB9 PeachPuff)
  ($FFDEAD NavajoWhite)
  ($FFE4B5 Moccasin)
  ($FFE4C4 Bisque)
  ($FFE4E1 MistyRose)
  ($FFEBCD BlanchedAlmond)
  ($FFEFD5 PapayaWhip)
  ($FFF0F5 LavenderBlush)
  ($FFF5EE SeaShell)
  ($FFF8DC Cornsilk)
  ($FFFACD LemonChiffon)
  ($FFFAF0 FloralWhite)
  ($FFFAFA Snow)
  ($FFFF00 Yellow)
  ($FFFFE0 LightYellow)
  ($FFFFF0 Ivory)
  ($FFFFFF White)))

Sort by name
(sort color (fn (x y) (<= (last x) (last y))))


============================================================================
 Codici nazionali (ISO 3166)
============================================================================
;;
;; Country codes alpha-2 & alpha-3
;;
;; This is a complete list of all (249) country ISO codes
;; as described in the ISO 3166 international standard.
;; These codes are used throughout the IT industry
;; to ease the identification of country names.
;;
;; Format: (country alpha-2 alpha-3 numeric)
;;
;; Note: Only ASCII character
;;
(setq country-code '(
 ("Afghanistan" "AF" "AFG" "004")
 ("Albania" "AL" "ALB" "008")
 ("Algeria" "DZ" "DZA" "012")
 ("American Samoa" "AS" "ASM" "016")
 ("Andorra" "AD" "AND" "020")
 ("Angola" "AO" "AGO" "024")
 ("Anguilla" "AI" "AIA" "660")
 ("Antarctica" "AQ" "ATA" "010")
 ("Antigua and Barbuda" "AG" "ATG" "028")
 ("Argentina" "AR" "ARG" "032")
 ("Armenia" "AM" "ARM" "051")
 ("Aruba" "AW" "ABW" "533")
 ("Australia" "AU" "AUS" "036")
 ("Austria" "AT" "AUT" "040")
 ("Azerbaijan" "AZ" "AZE" "031")
 ("Bahamas (the)" "BS" "BHS" "044")
 ("Bahrain" "BH" "BHR" "048")
 ("Bangladesh" "BD" "BGD" "050")
 ("Barbados" "BB" "BRB" "052")
 ("Belarus" "BY" "BLR" "112")
 ("Belgium" "BE" "BEL" "056")
 ("Belize" "BZ" "BLZ" "084")
 ("Benin" "BJ" "BEN" "204")
 ("Bermuda" "BM" "BMU" "060")
 ("Bhutan" "BT" "BTN" "064")
 ("Bolivia (Plurinational State of)" "BO" "BOL" "068")
 ("Bonaire, Sint Eustatius and Saba" "BQ" "BES" "535")
 ("Bosnia and Herzegovina" "BA" "BIH" "070")
 ("Botswana" "BW" "BWA" "072")
 ("Bouvet Island" "BV" "BVT" "074")
 ("Brazil" "BR" "BRA" "076")
 ("British Indian Ocean Territory (the)" "IO" "IOT" "086")
 ("Brunei Darussalam" "BN" "BRN" "096")
 ("Bulgaria" "BG" "BGR" "100")
 ("Burkina Faso" "BF" "BFA" "854")
 ("Burundi" "BI" "BDI" "108")
 ("Cabo Verde" "CV" "CPV" "132")
 ("Cambodia" "KH" "KHM" "116")
 ("Cameroon" "CM" "CMR" "120")
 ("Canada" "CA" "CAN" "124")
 ("Cayman Islands (the)" "KY" "CYM" "136")
 ("Central African Republic (the)" "CF" "CAF" "140")
 ("Chad" "TD" "TCD" "148")
 ("Chile" "CL" "CHL" "152")
 ("China" "CN" "CHN" "156")
 ("Christmas Island" "CX" "CXR" "162")
 ("Cocos (Keeling) Islands (the)" "CC" "CCK" "166")
 ("Colombia" "CO" "COL" "170")
 ("Comoros (the)" "KM" "COM" "174")
 ("Congo (the Democratic Republic of the)" "CD" "COD" "180")
 ("Congo (the)" "CG" "COG" "178")
 ("Cook Islands (the)" "CK" "COK" "184")
 ("Costa Rica" "CR" "CRI" "188")
 ("Croatia" "HR" "HRV" "191")
 ("Cuba" "CU" "CUB" "192")
 ("Curacao" "CW" "CUW" "531")
 ("Cyprus" "CY" "CYP" "196")
 ("Czechia" "CZ" "CZE" "203")
 ("Cote d'Ivoire" "CI" "CIV" "384")
 ("Denmark" "DK" "DNK" "208")
 ("Djibouti" "DJ" "DJI" "262")
 ("Dominica" "DM" "DMA" "212")
 ("Dominican Republic (the)" "DO" "DOM" "214")
 ("Ecuador" "EC" "ECU" "218")
 ("Egypt" "EG" "EGY" "818")
 ("El Salvador" "SV" "SLV" "222")
 ("Equatorial Guinea" "GQ" "GNQ" "226")
 ("Eritrea" "ER" "ERI" "232")
 ("Estonia" "EE" "EST" "233")
 ("Eswatini" "SZ" "SWZ" "748")
 ("Ethiopia" "ET" "ETH" "231")
 ("Falkland Islands (the) [Malvinas]" "FK" "FLK" "238")
 ("Faroe Islands (the)" "FO" "FRO" "234")
 ("Fiji" "FJ" "FJI" "242")
 ("Finland" "FI" "FIN" "246")
 ("France" "FR" "FRA" "250")
 ("French Guiana" "GF" "GUF" "254")
 ("French Polynesia" "PF" "PYF" "258")
 ("French Southern Territories (the)" "TF" "ATF" "260")
 ("Gabon" "GA" "GAB" "266")
 ("Gambia (the)" "GM" "GMB" "270")
 ("Georgia" "GE" "GEO" "268")
 ("Germany" "DE" "DEU" "276")
 ("Ghana" "GH" "GHA" "288")
 ("Gibraltar" "GI" "GIB" "292")
 ("Greece" "GR" "GRC" "300")
 ("Greenland" "GL" "GRL" "304")
 ("Grenada" "GD" "GRD" "308")
 ("Guadeloupe" "GP" "GLP" "312")
 ("Guam" "GU" "GUM" "316")
 ("Guatemala" "GT" "GTM" "320")
 ("Guernsey" "GG" "GGY" "831")
 ("Guinea" "GN" "GIN" "324")
 ("Guinea-Bissau" "GW" "GNB" "624")
 ("Guyana" "GY" "GUY" "328")
 ("Haiti" "HT" "HTI" "332")
 ("Heard Island and McDonald Islands" "HM" "HMD" "334")
 ("Holy See (the)" "VA" "VAT" "336")
 ("Honduras" "HN" "HND" "340")
 ("Hong Kong" "HK" "HKG" "344")
 ("Hungary" "HU" "HUN" "348")
 ("Iceland" "IS" "ISL" "352")
 ("India" "IN" "IND" "356")
 ("Indonesia" "ID" "IDN" "360")
 ("Iran (Islamic Republic of)" "IR" "IRN" "364")
 ("Iraq" "IQ" "IRQ" "368")
 ("Ireland" "IE" "IRL" "372")
 ("Isle of Man" "IM" "IMN" "833")
 ("Israel" "IL" "ISR" "376")
 ("Italy" "IT" "ITA" "380")
 ("Jamaica" "JM" "JAM" "388")
 ("Japan" "JP" "JPN" "392")
 ("Jersey" "JE" "JEY" "832")
 ("Jordan" "JO" "JOR" "400")
 ("Kazakhstan" "KZ" "KAZ" "398")
 ("Kenya" "KE" "KEN" "404")
 ("Kiribati" "KI" "KIR" "296")
 ("Korea (the Democratic People's Republic of)" "KP" "PRK" "408")
 ("Korea (the Republic of)" "KR" "KOR" "410")
 ("Kuwait" "KW" "KWT" "414")
 ("Kyrgyzstan" "KG" "KGZ" "417")
 ("Lao People's Democratic Republic (the)" "LA" "LAO" "418")
 ("Latvia" "LV" "LVA" "428")
 ("Lebanon" "LB" "LBN" "422")
 ("Lesotho" "LS" "LSO" "426")
 ("Liberia" "LR" "LBR" "430")
 ("Libya" "LY" "LBY" "434")
 ("Liechtenstein" "LI" "LIE" "438")
 ("Lithuania" "LT" "LTU" "440")
 ("Luxembourg" "LU" "LUX" "442")
 ("Macao" "MO" "MAC" "446")
 ("Madagascar" "MG" "MDG" "450")
 ("Malawi" "MW" "MWI" "454")
 ("Malaysia" "MY" "MYS" "458")
 ("Maldives" "MV" "MDV" "462")
 ("Mali" "ML" "MLI" "466")
 ("Malta" "MT" "MLT" "470")
 ("Marshall Islands (the)" "MH" "MHL" "584")
 ("Martinique" "MQ" "MTQ" "474")
 ("Mauritania" "MR" "MRT" "478")
 ("Mauritius" "MU" "MUS" "480")
 ("Mayotte" "YT" "MYT" "175")
 ("Mexico" "MX" "MEX" "484")
 ("Micronesia (Federated States of)" "FM" "FSM" "583")
 ("Moldova (the Republic of)" "MD" "MDA" "498")
 ("Monaco" "MC" "MCO" "492")
 ("Mongolia" "MN" "MNG" "496")
 ("Montenegro" "ME" "MNE" "499")
 ("Montserrat" "MS" "MSR" "500")
 ("Morocco" "MA" "MAR" "504")
 ("Mozambique" "MZ" "MOZ" "508")
 ("Myanmar" "MM" "MMR" "104")
 ("Namibia" "NA" "NAM" "516")
 ("Nauru" "NR" "NRU" "520")
 ("Nepal" "NP" "NPL" "524")
 ("Netherlands (the)" "NL" "NLD" "528")
 ("New Caledonia" "NC" "NCL" "540")
 ("New Zealand" "NZ" "NZL" "554")
 ("Nicaragua" "NI" "NIC" "558")
 ("Niger (the)" "NE" "NER" "562")
 ("Nigeria" "NG" "NGA" "566")
 ("Niue" "NU" "NIU" "570")
 ("Norfolk Island" "NF" "NFK" "574")
 ("Northern Mariana Islands (the)" "MP" "MNP" "580")
 ("Norway" "NO" "NOR" "578")
 ("Oman" "OM" "OMN" "512")
 ("Pakistan" "PK" "PAK" "586")
 ("Palau" "PW" "PLW" "585")
 ("Palestine, State of" "PS" "PSE" "275")
 ("Panama" "PA" "PAN" "591")
 ("Papua New Guinea" "PG" "PNG" "598")
 ("Paraguay" "PY" "PRY" "600")
 ("Peru" "PE" "PER" "604")
 ("Philippines (the)" "PH" "PHL" "608")
 ("Pitcairn" "PN" "PCN" "612")
 ("Poland" "PL" "POL" "616")
 ("Portugal" "PT" "PRT" "620")
 ("Puerto Rico" "PR" "PRI" "630")
 ("Qatar" "QA" "QAT" "634")
 ("Republic of North Macedonia" "MK" "MKD" "807")
 ("Romania" "RO" "ROU" "642")
 ("Russian Federation (the)" "RU" "RUS" "643")
 ("Rwanda" "RW" "RWA" "646")
 ("Reunion" "RE" "REU" "638")
 ("Saint Barthelemy" "BL" "BLM" "652")
 ("Saint Helena, Ascension and Tristan da Cunha" "SH" "SHN" "654")
 ("Saint Kitts and Nevis" "KN" "KNA" "659")
 ("Saint Lucia" "LC" "LCA" "662")
 ("Saint Martin (French part)" "MF" "MAF" "663")
 ("Saint Pierre and Miquelon" "PM" "SPM" "666")
 ("Saint Vincent and the Grenadines" "VC" "VCT" "670")
 ("Samoa" "WS" "WSM" "882")
 ("San Marino" "SM" "SMR" "674")
 ("Sao Tome and Principe" "ST" "STP" "678")
 ("Saudi Arabia" "SA" "SAU" "682")
 ("Senegal" "SN" "SEN" "686")
 ("Serbia" "RS" "SRB" "688")
 ("Seychelles" "SC" "SYC" "690")
 ("Sierra Leone" "SL" "SLE" "694")
 ("Singapore" "SG" "SGP" "702")
 ("Sint Maarten (Dutch part)" "SX" "SXM" "534")
 ("Slovakia" "SK" "SVK" "703")
 ("Slovenia" "SI" "SVN" "705")
 ("Solomon Islands" "SB" "SLB" "090")
 ("Somalia" "SO" "SOM" "706")
 ("South Africa" "ZA" "ZAF" "710")
 ("South Georgia and the South Sandwich Islands" "GS" "SGS" "239")
 ("South Sudan" "SS" "SSD" "728")
 ("Spain" "ES" "ESP" "724")
 ("Sri Lanka" "LK" "LKA" "144")
 ("Sudan (the)" "SD" "SDN" "729")
 ("Suriname" "SR" "SUR" "740")
 ("Svalbard and Jan Mayen" "SJ" "SJM" "744")
 ("Sweden" "SE" "SWE" "752")
 ("Switzerland" "CH" "CHE" "756")
 ("Syrian Arab Republic" "SY" "SYR" "760")
 ("Taiwan (Province of China)" "TW" "TWN" "158")
 ("Tajikistan" "TJ" "TJK" "762")
 ("Tanzania, United Republic of" "TZ" "TZA" "834")
 ("Thailand" "TH" "THA" "764")
 ("Timor-Leste" "TL" "TLS" "626")
 ("Togo" "TG" "TGO" "768")
 ("Tokelau" "TK" "TKL" "772")
 ("Tonga" "TO" "TON" "776")
 ("Trinidad and Tobago" "TT" "TTO" "780")
 ("Tunisia" "TN" "TUN" "788")
 ("Turkey" "TR" "TUR" "792")
 ("Turkmenistan" "TM" "TKM" "795")
 ("Turks and Caicos Islands (the)" "TC" "TCA" "796")
 ("Tuvalu" "TV" "TUV" "798")
 ("Uganda" "UG" "UGA" "800")
 ("Ukraine" "UA" "UKR" "804")
 ("United Arab Emirates (the)" "AE" "ARE" "784")
 ("United Kingdom of Great Britain and Northern Ireland (the)" "GB" "GBR" "826")
 ("United States Minor Outlying Islands (the)" "UM" "UMI" "581")
 ("United States of America (the)" "US" "USA" "840")
 ("Uruguay" "UY" "URY" "858")
 ("Uzbekistan" "UZ" "UZB" "860")
 ("Vanuatu" "VU" "VUT" "548")
 ("Venezuela (Bolivarian Republic of)" "VE" "VEN" "862")
 ("Viet Nam" "VN" "VNM" "704")
 ("Virgin Islands (British)" "VG" "VGB" "092")
 ("Virgin Islands (U.S.)" "VI" "VIR" "850")
 ("Wallis and Futuna" "WF" "WLF" "876")
 ("Western Sahara" "EH" "ESH" "732")
 ("Yemen" "YE" "YEM" "887")
 ("Zambia" "ZM" "ZMB" "894")
 ("Zimbabwe" "ZW" "ZWE" "716")
 ("Aland Islands" "AX" "ALA" "248")))


============================================================================
 Codice ASCII
============================================================================

L'American Standard Code for Information Interchange, o codice ASCII, è stato creato nel 1963 dal Comitato "American Standards Association" o "ASA", l'agenzia ha cambiato il suo nome nel 1969 in "American National Standards Institute" o "ANSI" così com'è conosciuto da allora.
Questo codice nasce dal riordino e dall'espansione del set di simboli e caratteri già utilizzati in telegrafia a quel tempo dalla società Bell.
All'inizio includeva solo lettere maiuscole e numeri, ma nel 1967 furono aggiunte le lettere minuscole e alcuni caratteri di controllo, formando ciò che è noto come US-ASCII, cioè i caratteri da 0 a 127.
Quindi con questo set di soli 128 caratteri è stato pubblicato nel 1967 come standard, contenente tutto il necessario per scrivere in lingua inglese.
Nel 1981 IBM sviluppò un'estensione del codice ASCII a 8 bit, chiamata "code page 437", in questa versione furono sostituiti alcuni caratteri di controllo obsoleti con i caratteri grafici. Inoltre sono stati aggiunti 128 caratteri, con nuovi simboli, segni, grafici e lettere latine, tutti i segni di punteggiatura e i caratteri necessari per scrivere testi in altre lingue, come lo spagnolo. In questo modo sono stati aggiunti i caratteri ASCII compresi tra 128 e 255.
IBM include il supporto per questa tabella codici nell'hardware del suo modello 5150, noto come "IBM-PC", considerato il primo personal computer. Anche il sistema operativo di questo modello, "MS-DOS", utilizzava questo codice ASCII esteso.
Quasi tutti i sistemi informatici di oggi utilizzano il codice ASCII per rappresentare caratteri e testi.

ASCII control characters
-------------------------------------------
00   |   NULL   |  (Null character)       |
01   |   SOH    |  (Start of Header)      |
02   |   STX    |  (Start of Text)        |
03   |   ETX    |  (End of Text)          |
04   |   EOT    |  (End of Trans.)        |
05   |   ENQ    |  (Enquiry)              |
06   |   ACK    |  (Acknowledgement)      |
07   |   BEL    |  (Bell)                 |
08   |   BS     |  (Backspace)            |
09   |   HT     |  (Horizontal Tab)       |
10   |   LF     |  (Line feed)            |
11   |   VT     |  (Vertical Tab)         |
12   |   FF     |  (Form feed)            |
13   |   CR     |  (Carriage return)      |
14   |   SO     |  (Shift Out)            |
15   |   SI     |  (Shift In)             |
16   |   DLE    |  (Data link escape)     |
17   |   DC1    |  (Device control 1)     |
18   |   DC2    |  (Device control 2)     |
19   |   DC3    |  (Device control 3)     |
20   |   DC4    |  (Device control 4)     |
21   |   NAK    |  (Negative acknowl.)    |
22   |   SYN    |  (Synchronous idle)     |
23   |   ETB    |  (End of trans. block)  |
24   |   CAN    |  (Cancel)               |
25   |   EM     |  (End of medium)        |
26   |   SUB    |  (Substitute)           |
27   |   ESC    |  (Escape)               |
28   |   FS     |  (File separator)       |
29   |   GS     |  (Group separator)      |
30   |   RS     |  (Record separator)     |
31   |   US     |  (Unit separator)       |
127  |   DEL    |  (Delete)               |

ASCII printable characters (standard)
------------------------------------------
|  32  | space |  64  |  @  |  96  |  `  |
|  33  |   !   |  65  |  A  |  97  |  a  |
|  34  |   "   |  66  |  B  |  98  |  b  |
|  35  |   #   |  67  |  C  |  99  |  c  |
|  36  |   $   |  68  |  D  |  100 |  d  |
|  37  |   %   |  69  |  E  |  101 |  e  |
|  38  |   &   |  70  |  F  |  102 |  f  |
|  39  |   '   |  71  |  G  |  103 |  g  |
|  40  |   (   |  72  |  H  |  104 |  h  |
|  41  |   )   |  73  |  I  |  105 |  i  |
|  42  |   *   |  74  |  J  |  106 |  j  |
|  43  |   +   |  75  |  K  |  107 |  k  |
|  44  |   ,   |  76  |  L  |  108 |  l  |
|  45  |   -   |  77  |  M  |  109 |  m  |
|  46  |   .   |  78  |  N  |  110 |  n  |
|  47  |   /   |  79  |  O  |  111 |  o  |
|  48  |   0   |  80  |  P  |  112 |  p  |
|  49  |   1   |  81  |  Q  |  113 |  q  |
|  50  |   2   |  82  |  R  |  114 |  r  |
|  51  |   3   |  83  |  S  |  115 |  s  |
|  52  |   4   |  84  |  T  |  116 |  t  |
|  53  |   5   |  85  |  U  |  117 |  u  |
|  54  |   6   |  86  |  V  |  118 |  v  |
|  55  |   7   |  87  |  W  |  119 |  w  |
|  56  |   8   |  88  |  X  |  120 |  x  |
|  57  |   9   |  89  |  Y  |  121 |  y  |
|  58  |   :   |  90  |  Z  |  122 |  z  |
|  59  |   ;   |  91  |  [  |  123 |  {  |
|  60  |   <   |  92  |  \  |  124 |  |  |
|  61  |   =   |  93  |  ]  |  125 |  }  |
|  62  |   >   |  94  |  ^  |  126 |  ~  |
|  63  |   ?   |  95  |  _  |

Extended ASCII characters (not standard)
--------------------------------------------
|  128  |  Ç  |  171  |  ½  |  214  |   Í  |
|  129  |  ü  |  172  |  ¼  |  215  |   Î  |
|  130  |  é  |  173  |  ¡  |  216  |   Ï  |
|  131  |  â  |  174  |  «  |  217  |   ┘  |
|  132  |  ä  |  175  |  »  |  218  |   ┌  |
|  133  |  à  |  176  |  ░  |  219  |   █  |
|  134  |  å  |  177  |  ▒  |  220  |   ▄  |
|  135  |  ç  |  178  |  ▓  |  221  |   ¦  |
|  136  |  ê  |  179  |  │  |  222  |   Ì  |
|  137  |  ë  |  180  |  ┤  |  223  |   ▀  |
|  138  |  è  |  181  |  Á  |  224  |   Ó  |
|  139  |  ï  |  182  |  Â  |  225  |   ß  |
|  140  |  î  |  183  |  À  |  226  |   Ô  |
|  141  |  ì  |  184  |  ©  |  227  |   Ò  |
|  142  |  Ä  |  185  |  ╣  |  228  |   õ  |
|  143  |  Å  |  186  |  ║  |  229  |   Õ  |
|  144  |  É  |  187  |  ╗  |  230  |   µ  |
|  145  |  æ  |  188  |  ╝  |  231  |   þ  |
|  146  |  Æ  |  189  |  ¢  |  232  |   Þ  |
|  147  |  ô  |  190  |  ¥  |  233  |   Ú  |
|  148  |  ö  |  191  |  ┐  |  234  |   Û  |
|  149  |  ò  |  192  |  └  |  235  |   Ù  |
|  150  |  û  |  193  |  ┴  |  236  |   ý  |
|  151  |  ù  |  194  |  ┬  |  237  |   Ý  |
|  152  |  ÿ  |  195  |  ├  |  238  |   ¯  |
|  153  |  Ö  |  196  |  ─  |  239  |   ´  |
|  154  |  Ü  |  197  |  ┼  |  240  |   ≡  |
|  155  |  ø  |  198  |  ã  |  241  |   ±  |
|  156  |  £  |  199  |  Ã  |  242  |   ‗  |
|  157  |  Ø  |  200  |  ╚  |  243  |   ¾  |
|  158  |  ×  |  201  |  ╔  |  244  |   ¶  |
|  159  |  ƒ  |  202  |  ╩  |  245  |   §  |
|  160  |  á  |  203  |  ╦  |  246  |   ÷  |
|  161  |  í  |  204  |  ╠  |  247  |   ¸  |
|  162  |  ó  |  205  |  ═  |  248  |   °  |
|  163  |  ú  |  206  |  ╬  |  249  |   ¨  |
|  164  |  ñ  |  207  |  ¤  |  250  |   ·  |
|  165  |  Ñ  |  208  |  ð  |  251  |   ¹  |
|  166  |  ª  |  209  |  Ð  |  252  |   ³  |
|  167  |  º  |  210  |  Ê  |  253  |   ²  |
|  168  |  ¿  |  211  |  Ë  |  254  |   ■  |
|  169  |  ®  |  212  |  È  |  255  | nbsp |
|  170  |  ¬  |  213  |  ı  |

Print characters in Windows
---------------------------

Vowels grave accent      Vowels acute accent      Vowels with diaresis
---------------------    ---------------------    ---------------------
|  à  |  alt + 133  |    |  á  |  alt + 160  |    |  ä  |  alt + 132  |
|  è  |  alt + 138  |    |  é  |  alt + 130  |    |  ë  |  alt + 137  |
|  ì  |  alt + 141  |    |  í  |  alt + 161  |    |  ï  |  alt + 139  |
|  ò  |  alt + 149  |    |  ó  |  alt + 162  |    |  ö  |  alt + 148  |
|  ù  |  alt + 151  |    |  ú  |  alt + 163  |    |  ü  |  alt + 129  |
|  À  |  alt + 0192 |    |  Á  |  alt + 181  |    |  Ä  |  alt + 142  |
|  È  |  alt + 0200 |    |  É  |  alt + 144  |    |  Ë  |  alt + 211  |
|  Ì  |  alt + 0204 |    |  Í  |  alt + 214  |    |  Ï  |  alt + 216  |
|  Ò  |  alt + 0210 |    |  Ó  |  alt + 224  |    |  Ö  |  alt + 153  |
|  Ù  |  alt + 0217 |    |  Ú  |  alt + 233  |    |  Ü  |  alt + 154  |

Mathematical symbols     Commercial symbols       Quotes and parenthesis
---------------------    ---------------------    ----------------------
|  ½  |  alt + 171  |    |  @  |  alt + 64   |    |  "  |  alt + 34   |
|  ¼  |  alt + 172  |    |  $  |  alt + 36   |    |  '  |  alt + 39   |
|  ¾  |  alt + 243  |    |  £  |  alt + 156  |    |  (  |  alt + 40   |
|  ¹  |  alt + 251  |    |  ¥  |  alt + 190  |    |  )  |  alt + 41   |
|  ³  |  alt + 252  |    |  ¢  |  alt + 189  |    |  [  |  alt + 91   |
|  ²  |  alt + 253  |    |  ¤  |  alt + 207  |    |  ]  |  alt + 93   |
|  ƒ  |  alt + 159  |    |  ®  |  alt + 169  |    |  {  |  alt + 123  |
|  ±  |  alt + 241  |    |  ©  |  alt + 184  |    |  }  |  alt + 125  |
|  ×  |  alt + 158  |    |  ª  |  alt + 166  |    |  «  |  alt + 174  |
|  ÷  |  alt + 246  |    |  º  |  alt + 167  |    |  »  |  alt + 175  |
|  ≡  |  alt + 240  |    |  °  |  alt + 248  |


=========================
 ASCII Punctuation marks
=========================

;;  "`" - backtick
;;  "!" - Exclamation mark
;;  """ - Quotation mark
;;  "#" - Number sign (also known as hash or pound sign)
;;  "$" - Dollar sign
;;  "%" - Percent sign
;;  "&" - Ampersand
;;  "'" - Apostrophe
;;  "(" - Left parenthesis
;;  ")" - Right parenthesis
;;  "*" - Asterisk
;;  "+" - Plus sign
;;  "," - Comma
;;  "-" - Hyphen or Minus sign
;;  "." - Period or Dot
;;  "/" - Slash
;;  ":" - Colon
;;  ";" - Semicolon
;;  "<" - Less than sign
;;  "=" - Equal sign
;;  ">" - Greater than sign
;;  "?" - Question mark
;;  "@" - At sign
;;  "[" - Left square bracket
;;  "\" - Backslash
;;  "]" - Right square bracket
;;  "^" - Caret
;;  "_" - Underscore
;;  "{" - Left curly bracket
;;  "|" - Vertical bar or Pipe
;;  "}" - Right curly bracket
;;  "~" - Tilde
;;  " " - Space

========================
 Solarized Color Scheme
========================
 
https://ethanschoonover.com/solarized/

  +-----------+----------+--------------+-------------+-------------+
  | SOLARIZED | HEX      | RGB          | HSB         | L*A*B       |  
  +-----------+----------+--------------+-------------+-------------+
  | base03    | #002b36  | 0,43,54      | 193,100,21  | 15,-12,-12  | 
  | base02    | #073642  | 7,54,66      | 192,90,26   | 20,-12,-12  | 
  | base01    | #586e75  | 88,110,117   | 194,25,46   | 45,-07,-07  | 
  | base00    | #657b83  | 101,123,131  | 195,23,51   | 50,-07,-07  | 
  | base0     | #839496  | 131,148,150  | 186,13,59   | 60,-06,-03  | 
  | base1     | #93a1a1  | 147,161,161  | 180,9,63    | 65,-05,-02  | 
  | base2     | #eee8d5  | 238,232,213  | 44,11,93    | 92,-00,10   | 
  | base3     | #fdf6e3  | 253,246,227  | 44,10,99    | 97,00,10    | 
  | yellow    | #b58900  | 181,137,0    | 45,100,71   | 60,10,65    | 
  | orange    | #cb4b16  | 203,75,22    | 18,89,80    | 50,50,55    | 
  | red       | #d30102  | 211,1,2      | 0,99,83     | 45,70,60    | 
  | magenta   | #d33682  | 211,54,130   | 331,74,83   | 50,65,-05   | 
  | violet    | #6c71c4  | 108,113,196  | 237,45,77   | 50,15,-45   | 
  | blue      | #268bd2  | 38,139,210   | 205,82,82   | 55,-10,-45  | 
  | cyan      | #2aa198  | 42,161,152   | 175,74,63   | 60,-35,-05  | 
  | green     | #859900  | 133,153,0    | 68,100,60   | 60,-20,65   | 
  +-----------+----------+--------------+-------------+-------------+
  +-----------+-----------+---------------+
  | SOLARIZED | TERMCOL   | XTERM - HEX   |  
  +-----------+-----------+---------------+
  | base03    | brblack   | 234 - #1c1c1c | 
  | base02    | black     | 235 - #262626 | 
  | base01    | brgreen   | 240 - #585858 | 
  | base00    | bryellow  | 241 - #626262 | 
  | base0     | brblue    | 244 - #808080 | 
  | base1     | brcyan    | 245 - #8a8a8a | 
  | base2     | white     | 254 - #e4e4e4 | 
  | base3     | brwhite   | 230 - #ffffd7 | 
  | yellow    | yellow    | 136 - #af8700 | 
  | orange    | brred     | 166 - #d75f00 | 
  | red       | red       | 124 - #af0000 | 
  | magenta   | magenta   | 125 - #af005f | 
  | violet    | brmagenta | 61  - #5f5faf | 
  | blue      | blue      | 33  - #0087ff | 
  | cyan      | cyan      | 37  - #00afaf | 
  | green     | green     | 64  - #5f8700 | 
  +-----------+-----------+---------------+

Vedi anche "solarized.png" nella cartella "data".


====================
 Regole di Internet
====================

"Rules of the Internet" è una raccolta di regole e aforismi generati da 4chan. A seconda di chi lo chieda, non sono da prendere sul serio o sono molto serie. La maggior parte di esse non si applica se non all'interno della comunità da cui sono nate, e l'elenco è in continua evoluzione, ma grazie alla Mutazione Memetica, alcune sono diventate famose.
Comment
Inoltre, quasi nessuno dei numeri è standardizzato, quindi non è raro trovare molte regole riordinate o semplicemente sostituite del tutto. Gli unici numeri standardizzati sono la Regola 34, la Regola 50 e la Regola 63, e forse anche le Regole 1 e 2 (e questo probabilmente solo a causa del Fight Club).

Alcune delle regole più importanti includono:
Regola 0: Non si scherza con i gatti.
Regola 1: Non parlare di /b/.
Regola 2: NON parlare di /b/.
Regola 3: Noi siamo Anonymous.
Regola 4: Anonymous é una legione.
Regola 5: Anonymous non perdona.
Regola 6: Anonymous può essere orribile, insensato ed un mostro incurante.
Regola 7: Anonymous è ancora in grado di consegnare.
Regola 8: Non ci sono vere regole per postare.
Regola 9: Non ci sono regole reali nemmeno per la moderazione - goditi il tuo ban.
Regola 10: Se ti piace qualche sito concorrente, NON FARLO.
Regola 11: Per quanto vi piaccia discutere, ricordate che su internet nessuno discute. Al contrario, si prendono gioco della vostra intelligenza e dei vostri genitori.
Regola 12: Qualsiasi cosa diciate può essere usata contro di voi.
Regola 13: Tutto ciò che dite può essere e sarà trasformato in qualcos'altro.
Regola 14: Non discutere con i troll: significa che vincono loro.
Regola 15: Più ti impegni, più fallirai.
Regola 16: Se il fallimento è di proporzioni epiche, potrebbe diventare un fallimento vincente.
Regola 17: Ogni vittoria prima o poi fallisce.
Regola 18: Tutto ciò che può essere etichettato può essere odiato.
Regola 19: Più lo si odia, più diventa forte.
Regola 20: Niente va preso sul serio.
Regole 21: Un contenuto originale è originale solo per pochi secondi prima di non esserlo più.
Regole 22: Il copypasta è fatto per rovinare fino all'ultimo bit di originalità.
Regole 23: Il copypasta è fatto per rovinare fino all'ultimo bit di originalità.
Regole 24: Ogni post è sempre un repost di un repost.
Regole 25: La relazione all'argomento originale si perde ad ogni singolo post.
Regole 26: Ogni argomento si puó trasformare in qualcosa di totalmente non correlato.
Regole 27: Metti sempre in discussione l'orientamento sessuale di una persona senza una reale ragione per farlo.
Regole 28: Metti sempre in discussione il genere di una persona - solo nel caso sia realmente un uomo.
Regola 29: Su Internet gli uomini sono uomini, le donne sono anch'esse uomini e i bambini sono agenti dell'FBI sotto copertura.
Regola 30: Le ragazze non esistono su Internet.
Regola 31: Tette o GTFO (levati dal cazzo) - la scelta è vostra.
Regola 32: Devi avere delle foto per dimostrare le tue affermazioni/Tutto può essere spiegato con una foto.
Regola 33: Lurkate di più: non è mai abbastanza.
Regola 34: se una cosa esiste, allora ne esiste anche la versione porno.
Regola 35: Se non c'è nessun porno al momento, esso sarà creato.
Regola 36: Non importa quanto sia malato, c'è sempre di peggio di quello che hai appena visto.
Regola 37: Non si può dividere per zero (solo perché lo dice la calcolatrice).
Regola 38: In questo caso non esistono limiti reali di alcun tipo, nemmeno il cielo.
Regola 39: Il BLOCCO MAIUSCOLE È IL CONTROLLO PER LA CALMA.
Regola 40: ANCHE CON IL CONTROLLO DELLA CALMA SI DEVE SEMPRE STERZARE.
Regola 41: Desu non è divertente. Sul serio, ragazze. È peggio delle battute di Chuck Norris.
Regola 42: Niente è sacro.
Regola 43: Più una cosa è bella e pura - più è soddisfacente corromperla.
Regola 44: Anche un solo commento positivo riguardo a cose giapponesi puó renderi un weaboo.
Regola 45: Quando si vede un leone, bisogna salire in macchina.
Regola 46: Ci sará sempre porno furry a riguardo.
Regola 47: La piscina è sempre chiusa.
Regola 48: L'unico hentai buono è quello "Yaoi", è così che funziona internet. L'unica eccezione può essere "Shotacon".
Regola 49: Non importa cosa sia, è il feticcio di qualcuno.
Regola 50: Un crossover, per quanto improbabile, alla fine si realizzerà nella Fan Art, nella Fan Fiction o nel materiale ufficiale, spesso attraverso una fanfiction.
Regola 51: Se esiste, esiste una versione AI di esso. Se non c'è, ci sarà.
Regola 61: Chuck Norris è l'eccezione, nessuna eccezione.
Regola 62: È stato craccato e piratato. Si può trovare qualsiasi cosa se si cerca abbastanza a lungo.
Regola 63: Per ogni personaggio maschile esiste una versione femminile di quel personaggio (e viceversa). E c'è sempre un porno di quel personaggio.
Regola 64: Se esiste, c'è un universo alternativo di quel personaggio.
Regola 65: Se non c'è, ci sarà.
Regola 66: Tutto ha un fandom, tutto.
Regola 67: Il 90% delle fanfiction è roba da incubo.
Regola 68: Se esiste, mettetela in un abito da cameriera.
Regola 69: Se esiste, mettetela in un vestito da coniglietta (quello sexy)
Regola 70: Non parlare del fallimento del "100M GET".
Regola 71: Internet è un affare fottutamente serio.
Regola 72: Se una canzone esiste, esiste una versione Megalovania.
Regola 75: La regola 75 è una bugia. OH CAZZ-
Regola 77: Internet ti rende stupido.
NESSUNA ECCEZIONE!

  
============================================================================
 Considerazioni lungo il tragitto
============================================================================

Dal 2019 al 2024 sono 5 anni.
Scrivo questi articoli per tenere allenata la mente (over 60).
Non sono un programmatore. Solo un amatore.
Niente di trascendentale, ma di tutto un pò (e ci saranno anche argomenti ripetuti...dovuti alla mia labile memoria).
Quando incontro un problema o un argomento che mi interessa (leggendo un libro o sul web o sul lavoro), cerco di risolverlo/capirlo anche con l'aiuto di newLISP.
Gli articoli non hanno tutti la stessa profondità o spiegazioni complete, ma i sorgenti sono commentati (quasi sempre).
Alcuni articoli trattano le tecniche generali di "Risoluzione dei problemi".
Ogni articolo è autosufficiente, nel senso che in ognuno sono riportate tutte le funzioni necessarie per eseguire le istruzioni riportate.
Alcuni problemi sono ottimi esercizi di programmazione per principianti.
Ci sono tantissime sequenze OEIS (On-line Encyclopedia of Integer Sequences).
In genere i programmi/algoritmi/funzioni sono scritti per essere leggibili/comprensibili e possono essere sicuramente migliorati/ottimizzati.
Mi sono divertito anche a programmare diversi giochi (carte, dadi, griglie, ecc.).
Ci sono degli errori? Sicuramente si (anche se mi sono impegnato abbastanza).
Fatemi sapere cosa ne pensate.

============================================================================
Non sei roba tua
Non sei il tuo lavoro
Non sei il tuo patrimonio
Non sei i tuoi successi
Non sei la tua età
Non sei la tua salute
Non sei il tuo corpo
Non sei le tue opinioni
Non sei la tua conoscenza
Non sei i tuoi ricordi
Non sei i tuoi pensieri
Non sei le tue emozioni
Non sei la tua personalità
Non sei la tua coscienza
Non sei il tuo cervello
Non sei il tuo cuore
Non sei quello che pensi di essere...
Allora, chi sei?
============================================================================

