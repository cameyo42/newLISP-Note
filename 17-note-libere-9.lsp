===============

 NOTE LIBERE 9

===============

-------------------
La lunghezza di nil
-------------------

In Common LISP:

(length nil)   --> 0
(length 'nil)  --> 0

In newLISP:

(length nil)
;-> 0
(length 'nil)
;-> 3

In newLISP, la funzione "length" applicata a un simbolo restituisce la lunghezza del nome del simbolo.


-----------------------------------------
Vocali, consonanti e cifre in una stringa
-----------------------------------------

Scrivere una funzione per calcolare quante vocali, consonanti e cifre ci sono in una data stringa.

Primo metodo:

(define (quanti str)
  (local (lst letters conta out)
    ; lista dei caratteri della stringa
    (setq lst (explode testo))
    ; lista dei caratteri da contare
    (setq letters '())
    ; aggiunge i numeri
    (for (i 48 57) (push (char i) letters -1))
    ; aggiunge le lettere minuscole
    (for (i 97 122) (push (char i) letters -1))
    ; conteggio
    (setq conta (count letters lst))
    ; creazione lista di associazione (char freq)
    (map list letters conta)))

(setq testo "super1cali2fragilissi3chespiralidoso")
(quanti testo)
;-> (("0" 0) ("1" 1) ("2" 1) ("3" 1) ("4" 0) ("5" 0) ("6" 0) ("7" 0) ("8" 0)
;->  ("9" 0) ("a" 3) ("b" 0) ("c" 2) ("d" 1) ("e" 2) ("f" 1) ("g" 1) ("h" 1)
;->  ("i" 6) ("j" 0) ("k" 0) ("l" 3) ("m" 0) ("n" 0) ("o" 2) ("p" 2) ("q" 0)
;->  ("r" 3) ("s" 5) ("t" 0) ("u" 1) ("v" 0) ("w" 0) ("x" 0) ("y" 0) ("z" 0))

Secondo metodo:

(define (howmany str)
  (local (lst vowel conso digit out)
    (setq lst (explode testo))
    (setq vowel '("a" "e" "i" "o" "u"))
    (setq conso '("b" "c" "d" "f" "g" "h" "j" "k" "l" "m" "n" 
                  "p" "q" "r" "s" "t" "v" "w" "x" "y" "z"))
    (setq digit '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9"))
    (setq out '())
    ; conta vocali
    (setq tmp (map list vowel (count vowel lst)))
    (push tmp out -1)
    ; conta consonanti
    (setq tmp (map list conso (count conso lst)))
    (push tmp out -1)
    ; conta cifre
    (setq tmp (map list digit (count digit lst)))
    (push tmp out -1)
    out))

(howmany testo)
;-> ((("a" 3) ("e" 2) ("i" 6) ("o" 2) ("u" 1))
;->  (("b" 0) ("c" 2) ("d" 1) ("f" 1) ("g" 1) ("h" 1) ("j" 0) ("k" 0) ("l" 3)
;->   ("m" 0) ("n" 0) ("p" 2) ("q" 0) ("r" 3) ("s" 5) ("t" 0) ("v" 0) ("w" 0) 
;->   ("x" 0) ("y" 0) ("z" 0)) 
;->  (("0" 0) ("1" 1) ("2" 1) ("3" 1) ("4" 0) 
;->    ("5" 0) ("6" 0) ("7" 0) ("8" 0) ("9" 0)))


--------------------------
Pseudo-closures con gensym
--------------------------

Da un post di William James:

(define (gensym:gensym)
  (sym (string "gensym-" (inc gensym:counter))))
;-> (lambda () (sym (string "gensym-" (inc gensym:counter))))

(define-macro (closure varval-pairs body)
  (let (alist (map (fn(x) (list (x 0) (gensym) (eval (x 1))))
                   (explode varval-pairs 2)))
    (bind (map (fn (x) (rest x)) alist))
    (dolist (x alist)
      (set-ref-all (x 0) body (x 1)))
    body))

(set 'up-down
  (closure (a 0 b 99)
    (lambda () (list (++ a) (-- b)))))

(up-down)
;-> (1 98)
(up-down)
;-> (2 97)
(up-down)
;-> (3 96)

(println up-down)
;-> (lambda () (list (++ gensym:gensym-1) (-- gensym:gensym-2)))

Versione leggermente migliorata e con un esempio in cui due lambda condividono una variabile.

(define-macro (closure varval-pairs)
  (let (body (cons 'begin (args))
        alist (map (fn(x) (list (x 0) (gensym) (eval (x 1))))
                   (explode varval-pairs 2)))
    (bind (map (fn (x) (rest x)) alist))
    (dolist (x alist)
      (set-ref-all (x 0) body (x 1)))
    (eval body)))

(closure (count 0)
  (setq up (fn()(++ count))) (setq down (fn()(-- count))))

;-> (up)
;-> ;-> 1
;-> (up)
;-> ;-> 2
;-> (up)
;-> 3
;-> (down)
;-> 2
;-> (down)
;-> 1

Per un modo diverso di farlo vedere:

http://www.newlisp.org/index.cgi?def-static

La differenza di "def-static" rispetto a questa soluzione è che inserisce ogni funzione nel proprio spazio dei nomi (contesto) tramite un functor predefinito.

Al posto di "gensym" è possibile utilizzare (sym (uuid)).

Nota: la funzione "gensym" è leggermente più veloce e mantiene tutti i simboli generati nello stesso contesto (namespace) gensym. Ma se ne usiamo solo alcuni, allora (sym (uuid)) è più pratico. 
Una buona pratica è spostare le define-macro (fexprs) nel proprio spazio dei nomi, che risolve anche l'acquisizione di variabili e crea una sorta di chiusura lessicale.


-------------------------------------------------------------
Passaggio di elementi di una lista come argomenti di funzione
-------------------------------------------------------------

Supponiamo di avere una funzione che accetta come argomenti due stringhe e tre numeri interi:

(myfunc "str1" "str2" 3 4 5)

Tuttavia abbiamo una lista che contiene questi valori interi:

(setq myvalues '(3 4 5))

Come passare gli elementi di questa lista come argomenti della funzione?

Un metodo immediato (ma non applicabile se non conosciamo il numero di elementi della lista):

(myfunc "str1" "str2" (myvalues 0) (myvalues 1) (myvalues 2))

Dobbiamo utilizare le funzioni "apply", "append" e "list":

(define (my-func s1 s2 a b c)
  (dup (string s1 s2 a b) c))

(my-func "o" "-" 1984 9 3)
;-> "o-19849o-19849o-19849"

(apply my-func (cons "o" (cons "-" '(1984 9 3))))
;-> "o-19849o-19849o-19849"

(apply my-func (append '("o" "-") '(1984 9 3)))
;-> "o-19849o-19849o-19849"

=============================================================================

