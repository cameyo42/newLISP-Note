================

 NOTE LIBERE 11

================

---------------------------
Il problema della celebrità
---------------------------

Ci sono N persone a una festa. A ogni persona è stato assegnato un ID univoco compreso tra 0 e N-1. Una celebrità è una persona che è nota a tutti, ma non conosce nessuno alla festa.
Il problema è quello di scoprire la celebrità alla festa:
  - se esiste la celebrità, allora restituire il suo ID.
  - se non esiste la celebrità, allora restituire nil.

Nota: Per risolvere il problema possiamo usare solo domande del tipo "A conosce B?".

Esempio: N = 4

Rappresentiamo la "conoscenza" tra due persone A e B con una matrice.
Il numero di riga rappresenta la persona A e il numero di colonna la persona B (A può conoscere più persone).
Se il valore è 1, allora A conosce B, altrimenti il valore è 0.
Il fatto che "A conosce A" viene codificato con il valore 0 (cioè la diagonale della matrice ha tutti i valori a 0).

Nel nostro esempio (0 conosce 2) (1 conosce 2) (2 conosce nessuno) (3 conosce 2):

                             0 1 2 3
                             -------
0 conosce 2    -->  (riga 0) 0 0 1 0
1 conosce 2    -->  (riga 1) 0 0 1 0
2 conosce nil  -->  (riga 2) 0 0 0 0
3 conosce 2    -->  (riga 3) 0 0 1 0

La matrice di input è la seguente:

(setq festa '((0 0 1 0)
              (0 0 1 0)
              (0 0 0 0)
              (0 0 1 0)))

Chiaramente la riga che ha tutti i valori a zero è l'ID della celebrità, ma dobbiamo risolvere il problema solo con domande "A conosce B?".

Funzione che effettua "A conosce B?":

(define (conosce? matrix a b) (matrix a b))

(conosce? festa 0 2)
;-> 1
(conosce? festa 0 0)
;-> 0

Algoritmo 1 (brute-force)
-------------------------
Trovare, se esiste, un ID che non conosce nessuno. 
Se esiste un tale ID (potenziale candidato per la celebrità), allora determinare se tutti lo conoscono o meno.

(define (celebrity matrix)
  (local (n cel conosce-qualcuno conosciuto-da-tutti stop1 stop2 stop3)
    (setq n (length matrix))
    (setq cel -1)
    (setq stop1 nil)
    ; Check one by one whether the person is a celebrity or not.
    (for (i 0 (- n 1) 1 stop1)
      (setq conosce-qualcuno nil)
      (setq conosciuto-da-tutti true)
      (setq stop2 nil)
      ; Check whether person with id 'i' knows any other person.
      (for (j 0 (- n 1) 1 stop2)
        (if (= (conosce? matrix i j) 1)
            (set 'conosce-qualcuno true 'stop2 true)
        )
      )
      (setq stop3 nil)
      (for (j 0 (- n 1) 1 stop3)
        (if (and (!= i j) (zero? (conosce? matrix j i)))
            (set 'conosciuto-da-tutti nil 'stop3 true)
        )
      )
      (if (and (not conosce-qualcuno) conosciuto-da-tutti)
        (set 'cel i 'stop1 true)
      )
    )
    cel))

(celebrity festa)
;-> 2

int findCelebrity(int n) {
    int celebrity = -1;
    // Check one by one whether the person is a celebrity or not.
    for(int i = 0; i < n; i++) {
        bool knowAny = false, knownToAll = true;
        // Check whether person with id 'i' knows any other person.
        for(int j = 0; j < n; j++) {
            if(knows(i, j)) {
                knowAny = true;
                break;
            }
        }
        // Check whether person with id 'i' is known to all the other person.
        for(int j = 0; j < n; j++) {
            if(i != j and !knows(j, i)) {
                knownToAll = false;
                break;
            }
        }
        if(!knowAny && knownToAll) {
            celebrity = i;
            break;
        }
    }
    return celebrity;
}

Algoritmo 2 (grafo)
-------------------
a) Creare due vettori in e out, per memorizzare l'indegree e l'outdegree
b) Eseguire un ciclo annidato, il ciclo esterno da 0 a n e il ciclo interno da 0 a n.
c) Per ogni coppia i, j controllare se i conosce j, quindi aumentare l'outdegree di i e l'indegree di j
d) Per ogni coppia i, j controllare se j conosce i, quindi aumentare l'outdegree di j e l'indegree di i
e) Eseguire un ciclo da 0 a n e trova l'id dove l'indice è n-1 e l'outdegree è 0

(define (celebrity matrix)
  (local (in out x len res stop)
    (setq len (length matrix))
    (setq in (array len '(0)))
    (setq out (array len '(0)))
    ; ciclo per ogni elemento della matrice
    (for (i 0 (- len 1))
      (for (j 0 (- len 1))
        (setq x (conosce? matrix i j))
        (++ (out i) x) ; i conosce --> aumenta il valore di out (out i)
        (++ (in j) x)  ; j è conosciuto --> aumenta il valore di (in j)
      )
    )
    (setq res -1)
    ; ricerca della celebrità
    (setq stop nil)
    (for (i 0 (- len 1) 1 stop)
      ; deve essere conosciuto da tutti: (in i) = n - 1
      ; non deve conoscere nessuno: (out i) = 0
      (if (and (= (in i) (- len 1)) (zero? (out i)))
          (set 'res i 'stop true)
      )
    )
    res))

(celebrity festa)
;-> 2

Complessità temporale: O(N^2)

Algoritmo 3 (ricorsione)
------------------------
a) Creare una funzione ricorsiva che accetta un intero n.
b) Controllare il caso base, se il valore di n è 0, restituire -1.
c) Chiamare la funzione ricorsiva e ottenere l'ID della potenziale celebrità dai primi n-1 elementi.
d) Se l'id è -1, assegnare n come potenziale celebrità e restituire il valore.
e) Se la potenziale celebrità dei primi n-1 elementi conosce n-1, restituire n-1,
f) Se la celebrità dei primi n-1 elementi non conosce n-1, restituire l'id della celebrità di n-1 elementi,
g) Altrimenti ritornare -1

(define (potential n)
(catch
  (local (id)
    ; caso base
    ; n = 0 significa che non ci sono celebrità
    (if (zero? n) (throw -1))
    ; trova la potenziale celebrità con (n - 1) persone
    (setq id (potential (- n 1)))
          ; se non ci sono celebrità
    (cond ((= id -1) (throw (- n 1)))
          ; se id conosce n-esima persona, allora
          ; id non è celebrità, ma n-esima può esserlo.
          ((= (conosce? matrix id (- n 1)) 1) (throw (- n 1)))
          ; se n-esima persona conosce id, allora
          ; n-esima persona non è celebrità, ma id può esserlo.
          ((= (conosce? matrix (- n 1) id) 1) (throw id))
    )
    ; nessuna celebrità
    -1)))

(define (celebrity matrix)
(catch
  (local (n id c1 c2)
    (setq c1 0)
    (setq c2 0)
    (setq n (length matrix))
    ; trova la potenziale celebrità
    (setq id (potential n))
    (if (= id -1)
        (throw id)
        ;else
        (begin
          ; trova la celebrità (se esiste)
          (for (i 0 (- n 1))
            (if (!= i id)
              (begin
                (setq c1 (+ c1 (conosce? matrix id i)))
                (setq c2 (+ c2 (conosce? matrix i id)))
              )
            )
          )
          ; se la persona è conosciuta da tutti e non conosce nessuno
          (if (and (zero? c1) (= c2 (- n 1)))
              (throw id)
          )
        )
    )
    ; nessuna celebrità
   -1)))

(celebrity festa)
;-> 2

Complessità temporale: O(N)

Algoritmo 4 (eliminazione)
--------------------------
Idea:
Se A conosce B, allora A non può essere una celebrità. Scarta A, mentre B potrebbe essere celebrità.
Se A non conosce B, allora B non può essere una celebrità. Scarta B, mentre A potrebbe essere una celebrità.
a) Creare una variabile per memorizzare la riga corrente e poi un ciclo da 0 a n-1 e se M[riga][i] è 1 allora contrassegniamo M[riga][riga]=1 e aggiorniamo riga = i e se M[riga][i]=0 quindi porre M[i][i]=1.
b) Dopo il ciclo iterae sulla diagonale della matrice cioè M[i][i] dove i->(0,n-1) ci sarà un solo elemento nella diagonale il cui valore sarà 0, quando trovato iterare su tutti le righe dall'alto verso il basso con la colonna impostata su i e se non c'è 0 in quella colonna, restituisci i altrimenti restituire -1.

(define (celebrity matrix)
(catch
  (local (r flag len stop)
    (setq len (length matrix))
    ; numero di riga
    (setq r 0)
    (for (i 1 (- len 1))
      ; controllare se la r-esima persona conosce la i-esima persona
      (cond ((= (matrix r i) 1)
              (setf (matrix r r) 1)
              (setq r i))
            (true
              (setf (matrix i i) 1))
      )
    )
    (for (i 0 (- len 1))
      ; controlla se l'i-esima persona può essere una celebrità
      (if (zero? (matrix i i))
        (begin
          (setq flag 0)
          (setq stop nil)
          ; itera nell'i-esima colonna da controllare
          ; se tutti conoscono la i-esima persona o no
          (for (j 0 (- len 1))
            (if (and (!= j i) (zero? (matrix j i)))
                (set 'flag 1 'stop true)
            )
          )
          (if (zero? flag) (throw i))
        )
      )
    )
    -1)))

(celebrity festa)
;-> 2

Complessità temporale: O(N)

Nota: Non può esistere più di una celebrità.
Dimostrazione per assurdo: se A e B fossero entrambe celebrità, allora A non conoscerebbe nessuno, neanche B, quindi B non sarebbe conosciuta da tutti e non potrebbe essere una celebrità (e, viceversa, anche A non sarebbe conosciuta da B).


----------------------------
Turtle Graphics (by newbert)
----------------------------

Esempio 1
---------
;=======================================
; Turtle graphics   (NewLISP + GUI-server)
; tree.lsp
;
; NewLISP v9.2.4                   B. Carette - nov. 2007
;=======================================
;; initialization GUI-server
(load (append (env "NEWLISPDIR") "/guiserver.lsp"))
(gs:init)

;; constants & variables
(constant 'PI2 (acos 0) 'DP2 (div PI2 90)) ; degre -> radian
(constant 'WIDTH 400 'HEIGHT 400) ; size of the window
(set 'coorX 0 'coorY 0) ; coordinates of the "turtle"
(set 'dir 0) ; orientation (heading to the north)
(set 'back-color '(1 1 1)) ; backcolor = white
(set 'pen-color '(0 0 0)) ; pen = black
(set 'pen true) ; pen is down

;; building the GUI
(gs:frame 'WIN 100 100 WIDTH (+ HEIGHT 34) "NewLISP Turtle")
(gs:canvas 'Canvas)
(gs:set-size 'Canvas WIDTH HEIGHT)
(gs:set-background 'Canvas back-color)
(gs:add-to 'WIN 'Canvas)
(gs:set-visible 'WIN true)

;; graphic procedures (commands for the turtle)
(define (home)
   ; center of the screen, heading to north
   (pen-up)
   (set 'coorX 0 'coorY 0)
   (set 'dir PI2)
   (pen-down))

(define (clear-screen)
   (gs:delete-tag 'L)
   (home))

(define (pen-down)
   (set 'pen true))

(define (pen-up)
   (set 'pen nil))

(define (pendown?)
   pen)

(define (set-pos x y)
   ;  set the new positionof the turtle
   (set 'coorX (add (div WIDTH 2) coorX) 'coorY (sub (div HEIGHT 2) coorY))
   (set 'newX (add (div WIDTH 2) x) 'newY (sub (div HEIGHT 2) y))
   (if (pendown?)
      ; draw if pen is down
      (gs:draw-line 'L (int coorX) (int coorY) (int newX) (int newY) pen-color ))
   (set 'coorX x 'coorY y))

(define (pos)
   ; return current position
   (cons coorX coorY))

(define (forward dist)
   (set-pos (add coorX (mul dist (cos dir)))
           (add coorY (mul dist (sin dir)))))

(define (backward dist)
   (forward (- dist)))

(define (set-heading angle)
   ; set the orientation
   (set 'dir (mod angle 360)))

(define (orientation)
   ; return current heading
   dir)

(define (right degre)
   ; set orientation to the right (in degre)
   (set-heading (sub dir (mul degre DP2))))

(define (left degre)
   ; set orientation to the left (in degre)
   (set-heading (add dir (mul degre DP2))))

;; main program (a Turtle Graphics program)
(define (tree size)
   (gs:set-stroke (div size 10))
   (set 'pen-color (amb gs:red gs:green gs:blue))
   (forward size)
   (if (> size 5)
      (begin
         (right 30)
         (tree (/ size 2))
         (right 30)
         (tree (/ size 2))
         (left 90)
         (tree (/ size 2))
         (left 30)
         (tree (/ size 2))
         (right 60)
         (gs:update)))
   (pen-up)
   (backward size)
   (pen-down)
   (gs:set-stroke 0.0))

(clear-screen)
(pen-up)
(backward 100)
(pen-down)
(tree 150)

;; boucle d'attente d'événements
(gs:listen)
;eof

Esempio 2
---------
;================
; Turtle Graphics  (NewLISP + GUI-server) - A recursive tree
;
; NewLISP v9.2.17                   Bertrand Carette - jan 2008
;================

;; initialisation GUI-server ---------------------------------------------
(load (append (env "NEWLISPDIR") "/guiserver.lsp"))
(gs:init)

;; constants & variables -------------------------------------------------
(constant 'PI2 (acos 0) 'DP2 (div PI2 90)); degree -> radian
(set 'WIDTH 400 'HEIGHT 400)              ; size of the screen
(set 'xcor 0 'ycor 0)                     ; coordinates of the turtle
(set 'heading 0)                          ; orientation (heading to north)
(set 'background '(1 1 1))                ; background color = white
(set 'pen-color '(0 0 0))                 ; pen color = black
(set 'pen true)                           ; pen is down

;; building graphic interface --------------------------------------------
(gs:frame 'WIN 100 100 WIDTH (+ HEIGHT 34) "NewLISP Turtle")
(gs:canvas 'Canvas)
(gs:set-size 'Canvas WIDTH HEIGHT)
(gs:set-background 'Canvas background)
(gs:window-resized 'WIN 'resize-action)
(gs:add-to 'WIN 'Canvas)
(gs:set-visible 'WIN true)

(define (resize-action id w h , x y)
   (set 'x (int (sub (div w 2) (div WIDTH 2))))
   (set 'y (int (sub (div h 2) (div HEIGHT 2))))
   (gs:move-tag 'L x y)
   (set 'WIDTH (int w) 'HEIGHT (int h)))

;; turtle graphics procedures --------------------------------------------
(define (home)
   ; center of the screen, heading to north
   (pen-up)
   (set 'xcor 0 'ycor 0)
   (set 'heading PI2)
   (pen-down))

(define (clear-screen)
   (gs:delete-tag 'L)
   (home))

(define (pen-down)
   (set 'pen true))

(define (pen-up)
   (set 'pen nil))

(define (pen?)
   ; status of the pen
   pen)

(define (set-pos x y)
   ;  set new position
   (set 'xcor (int (add (div WIDTH 2) xcor)))
   (set 'ycor (int (sub (div HEIGHT 2) ycor)))
   (set 'newx (int (add (div WIDTH 2) x)))
   (set 'newy (int (sub (div HEIGHT 2) y)))
   (if (pen?)
      ; draw if pen is down
      (gs:draw-line 'L xcor ycor newx newy pen-color ))
   (set 'xcor x 'ycor y))

(define (pos)
   ; output current position
   (cons xcor ycor))

(define (forward dist)
   ; move forward of 'dist' steps
   (set-pos    (add xcor (mul dist (cos heading)))
              (add ycor (mul dist (sin heading)))))

(define (backward dist)
   ; move backward
   (forward (sub dist)))

(define (set-heading angle)
   (set 'heading (mod angle 360)))

(define (orientation)
   ; output current heading
   heading)

(define (right degre)
   ; set heading to right (in degree)
   (set-heading (sub heading (mul degre DP2))))

(define (left degre)
   ; set heading to left (in degree)
   (set-heading (add heading (mul degre DP2))))

;; MAIN PROGRAM : a recursive tree ---------------------------------------

(define (tree size)
   (unless (< size 5)
      (begin
         (forward (div size 3))
         (left 30)
         (tree (div (mul size 2) 3))
         (right 30)
         (forward (div size 6))
         (right 25)
         (tree (div size 2))
         (left 25)
         (forward (div size 3))
         (right 25)
         (tree (div size 2))
         (left 25)
         (forward (div size 6))
         (backward size)))
   (forward size)
   (backward size))

(clear-screen)
(pen-up)
(backward 100)
(pen-down)
(tree 150)
(gs:update)

;; event loop ------------------------------------------------------------
(gs:listen)
;eof


------------------------------------
Dimensioni di un file JPG (by Cyril)
------------------------------------

Il codice seguente permette di determinare le dimensioni di un file JPG.
Legge un file byte per byte con 'read-char', quindi potrebbe essere lento, o potrebbe non funzionare se "read-char" non ritorna un byte unsigned (no byte signed e no unicode character)

;; This is an (almost) direct translation of C source found at:
;; http://dev.w3.org/cvsweb/Amaya/libjpeg/rdjpgcom.c?rev=1.2

;; The following code assumes that read-char function returns
;; one unsigned byte (not signed byte, not unicode character)

(context 'jpeg-dimensions)

(define (return x) x)

(define (read_1_byte , c)
  (setq c (read-char handle))
  (unless c (throw "read_1_byte: EOF"))
  (return c))

(define (read_2_bytes , c1 c2)
  (setq c1 (read-char handle))
  (unless c1 (throw "read_2_bytes: EOF"))
  (setq c2 (read-char handle))
  (unless c2 (throw "read_2_bytes: EOF"))
  (return (+ (<< c1 8) c2)))

(define (sof? byte)
  (and (= (& byte 0xF0) 0xC0) (not (member byte '(0xC4 0xC8 0xCC)))))

(define (first_marker)
  (unless (= (read_2_bytes) 0xFFD8) (throw "first_marker: not a JPEG")))

(define (next_marker , c)
  (setq c (read_1_byte))
  (unless (= c 0xFF) (throw "next_marker: garbage"))
  (while (= c 0xFF) (setq c (read_1_byte)))
  (return c))

(define (skip_variable , len)
  (setq len (read_2_bytes))
  (unless (>= len 2) (throw "skip_variable: bad length"))
  (dotimes (i (- len 2)) (read_1_byte)))

(define (process_sof marker , len precision height width components)
  (setq len (read_2_bytes))
  (setq precision (read_1_byte))
  (setq height (read_2_bytes))
  (setq width (read_2_bytes))
  (setq components (read_1_byte))
  (unless (= len (+ 8 (* components 3))) (throw "process_sof: bogus length"))
  (return (list width height)))

(define (scan_jpeg_header , marker)
  (catch
    (begin
      (first_marker)
      (while (setq marker (next_marker))
        (if (sof? marker)
          (throw (process_sof marker))
          (skip_variable)))
      (throw "scan_jpeg_header: no frames"))))

(define (jpeg-dimensions:jpeg-dimensions file , handle result)
  (setq handle (open file "read"))
  (setq result (scan_jpeg_header))
  (close handle)
  (return result))

(context MAIN)

; uncomment when used as script
;(println (jpeg-dimensions (main-args 2)))
;(exit)

(jpeg-dimensions "rmp.jpg")
;-> 709 434

(jpeg-dimensions "moonPhases.jpg")
;-> (8400 280)

Nota: non funziona con tutti i file jpg che ho provato (probabilmente alcuni jpg hanno dei caratteri unicode).


----------------------
Seven segments display
----------------------

Un display a sette segmenti può essere utilizzato per visualizzare i numeri. 
La rappresentazione grafica del display è la seguente:

  Segmenti tutti spenti    Segmenti tutti accesi
          ---                       ■■■ 
         |   |                     █   █
          ---                       ■■■ 
         |   |                     █   █
          ---                       ■■■ 

Le cifre da 0 a 9 vengono rappresentate nel modo seguente:

   0       1       2       3       4       5       6       7       8       9
  ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■     ■■■     ■■■     ■■■
 █   █   |   █   |   █   |   █   █   █   █   |   █   |   |   █   █   █   █   █
  ---     ---     ■■■     ■■■     ■■■     ■■■     ■■■     ---     ■■■     ■■■
 █   █   |   █   █   |   |   █   |   █   |   █   █   █   |   █   █   █   |   █
  ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■     ---     ■■■     ■■■
  (6)     (2)     (5)     (5)     (4)     (5)     (6)     (3)     (7)     (6)

Data una lista di numeri interi positivi, trovare il numero che utilizza il numero minimo di segmenti per essere visualizzato.
Se più numeri hanno lo stesso numero minimo di segmenti, allora restituire il numero più grande.

(define (min7 lst)
  (local (seg numseg numval sumseg)
    (setq numseg 999999999)
    (setq numval -1)
    ; array: seg(0) = 6, seg(1)=2, ecc.
    (setq seg (array 10 '(6 2 5 5 4 5 6 3 7 6)))
    ; per ogni numero della lista...
    (dolist (num lst)
      (setq sumseg 0)
      ; somma tutti i segmenti per ogni cifra
      (dolist (d (explode (string num)))
        (setq sumseg (+ sumseg (seg (int d))))
      )
      ;(print sumseg { })
      ; controllo valore minimo del numero di segmenti
      (cond ((= sumseg numseg) ; se abbiamo lo stesso numero di segmenti...
              ; allora memorizza il numero più grande
              (if (> num numval) (setq numval num)))
            ; se numero di segmenti maggiore, allora memorizza questa soluzione
            ((< sumseg numseg)
              (setq numval num)
              (setq numseg sumseg))
      )
    )
    (list numval numseg)))

Facciamo un paio di prove:

(min7 (sequence 0 9))
;-> (1 2)
(min7 '(123 345 23 44 57))
;-> (57 8)


-----------------------------------------------------
Regular paperfolding sequence e dragon curve sequence
-----------------------------------------------------

La sequenza di piegatura regolare della carta (regular paperfolding sequence), nota anche come sequenza della curva del drago (dragon curve sequence), è una sequenza infinita di 0 e 1. Si ottiene dalla sequenza parziale ripetuta:

1, ?, 0, ?, 1, ?, 0, ?, 1, ?, 0, ?, ...

compilando i punti interrogativi con un'altra copia dell'intera sequenza.

Sequenza OEIS: A014577

  1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, ...

Se una striscia di carta viene piegata ripetutamente a metà nella stessa direzione, i volte, otterrà (2^i - 1) pieghe, la cui direzione (sinistra o destra) è data dal motivo di 0 e 1 nella prima ( 2^i - 1) termini della normale sequenza di piegatura della carta. L'apertura di ogni piega per creare un angolo retto (o, equivalentemente, fare una sequenza di giri a sinistra ea destra attraverso una griglia regolare, seguendo lo schema della sequenza di piegatura della carta) produce una sequenza di catene poligonali che si avvicina al frattale della curva del drago.

Il valore di un dato termine t(n) della sequenza, che inizia con n=1, può essere trovato ricorsivamente come segue. Dividere n per due, quante più volte possibile, per ottenere una fattorizzazione della forma n = m*2^k dove m è un numero dispari. Quindi:

          | 1, se m ≡ 1 mod 4
  t(n) = |
          | 0, se m ≡ 3 mod 4

Scriviamo una funzione che stampa i primi n numeri della sequenza.

Algoritmo:
Passaggio 1: inizia con il primo termine 1. Quindi aggiungi 1 e 0 alternativamente dopo ogni elemento del termine precedente.
Passaggio 2: il nuovo termine ottenuto diventa il termine corrente.
Passaggio 3: ripetere il processo in un ciclo da 1 a n, per generare ogni termine e infine l'n-esimo termine.

Esempio:
- 1
(inizia con 1)

- "1" 1 "0"
1 e 0 sono inseriti alternativamente a sinistra ea destra del termine precedente.
Qui il numero tra virgolette rappresenta gli elementi appena aggiunti.
Così diventa il secondo termine
1 1 0

- "1" 1 "0" 1 "1" 0 "0"
Così diventa il terzo termine
1 1 0 1 1 0 0

- "1" 1 "0" 1 "1" 0 "0" 1 "1" 1 "0" 0 "1" 0 "0"
Il quarto termine diventa
1 1 0 1 1 0 0 1 1 1 0 0 1 0 0

(define (dragon n)
  (local (s tmp prev zero uno)
    ; primo termine della sequenza
    (setq s "1")
    (println 1 { } s)
    ; generazione di ogni elemento della sequenza
    (for (i 2 n)
      (setq tmp "1")
      (setq prev "1")
      (setq zero "0")
      (setq one "1")
      ; ciclo per generare l'i-esimo termine
      (for (j 0 (- (length s) 1))
        ; aggiunge il carattere dalla stringa originale
        (extend tmp (s j))
        ; aggiunge alternativamente 0 e 1 in mezzo
        (if (= prev "0")
          (begin
            ; se il precedente termine precedente era "0" aggiungere "1"
            (extend tmp one)
            ; termine corrente = termine precedente
            (setq prev one)
          )
          ;else
          (begin
            ; se il precedente termine precedente era "1" aggiungere "0"
            (extend tmp zero)
            ; termine corrente = termine precedente
            (setq prev zero)
          )
        )
      )
      ; s è l'i-esimo trermine della sequenza
      (setq s tmp)
      (println i { } s)
    )
    s))

(dragon 4)
;-> 1 1
;-> 2 110
;-> 3 1101100
;-> 4 110110011100100

(dragon 8)
;-> 1 1
;-> 2 110
;-> 3 1101100
;-> 4 110110011100100
;-> 5 1101100111001001110110001100100
;-> 6 110110011100100111011000110010011101100111001000110110001100100
;-> 7 1101100111001001110110001100100111011001110010001101100011001001
;->   110110011100100111011000110010001101100111001000110110001100100
;-> 8 1101100111001001110110001100100111011001110010001101100011001001
;->   1101100111001001110110001100100011011001110010001101100011001001
;->   1101100111001001110110001100100111011001110010001101100011001000
;->   110110011100100111011000110010001101100111001000110110001100100

=============================================================================

