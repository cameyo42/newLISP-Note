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

Se una striscia di carta viene piegata ripetutamente a metà nella stessa direzione, i volte, otteniamo (2^i - 1) pieghe, la cui direzione (sinistra o destra) è data dal motivo di 0 e 1 nei primi (2^i - 1) termini della normale sequenza di piegatura della carta. L'apertura di ogni piega per creare un angolo retto (o, equivalentemente, fare una sequenza di giri a sinistra e a destra attraverso una griglia regolare, seguendo lo schema della sequenza di piegatura della carta) produce una sequenza di catene poligonali che si avvicina al frattale della curva del drago.

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


------------------------------------
Sequenza di Hofstadter-Conway $10000
------------------------------------

La sequenza Hofstadter-Conway (o Newman-Conway), è definita dalla relazione di ricorsiva:

  P(n) = P(P(n - 1)) + P(n - P(n - 1))

con valori iniziali P(1) = 1 e P(2) = 1

Sequenza OEIS: A004001
  1, 1, 2, 2, 3, 4, 4, 4, 5, 6, 7, 7, 8, 8, 8, 8, 9, 10, 11, 12, 12,
  13, 14, 14, 15, 15, 15, 16, 16, 16, 16, 16, 17, 18, 19, 20, 21, 21,
  22, 23, 24, 24, 25, 26, 26, 27, 27, 27, 28, 29, 29, 30, 30, 30, 31,
  31, 31, 31, 32, 32, 32, 32, 32, 32, ...

Il 15 luglio 1988, durante un colloquio presso i Bell Labs, John Conway dichiarò di poter provare a(n)/n -> 1/2 per n tendente all'infinito, ma che la dimostrazione era estremamente difficile.
Ha quindi offerto $10000 a qualcuno che avesse trovato un n_0 tale che per tutti n >= n(0), abbiamo |a(n)/n - 1/2| < 0,05 e ha offerto $10.000 per il minimo n(0).
Il premio è stato rivendicato da Colin Mallows, che ha accettato di non incassare l'assegno.

Metodo 1 (ricorsione)
---------------------

(define (hc num)
  (if (or (= num 1) (= num 2))
      1
      ;else
      (+ (hc (hc (- num 1)))
         (hc (- num (hc (- num 1)))))))

(map hc (sequence 1 10))
;-> (1 1 2 2 3 4 4 4 5 6)

Metodo 2 (programmazione dinamica)
----------------------------------
Possiamo evitare di calcolare troppe volte gli stessi valori della sequenza memorizzandoli in un vettore.

(define (hc1 num)
  (let (s (array (+ num 1) '(0)))
    (setf (s 1) 1)
    (setf (s 2) 1)
    (for (i 3 num)
      (setf (s i) (+ (s (s (- i 1))) (s (- i (s (- i 1))))))
    )
    s))

(hc1 10)
;-> (0 1 1 2 2 3 4 4 4 5 6)

Tempi di esecuzione:

(time (println (hc 25)))
;-> 15
;-> 8380.959

(time (println (hc1 25)))
;-> (0 1 1 2 2 3 4 4 4 5 6 7 7 8 8 8 8 9 10 11 12 12 13 14 14 15)
;-> 0


----------------------------------------
Sommatoria e produttoria di una funzione
----------------------------------------

              n
Sommatoria:   ∑ [f(x)]
             i=1

              n
Produttoria:  ∏ [f(x)]
             i=1

Funzione che effettua la sommatoria:

(define (fn-sum func start end)
  (let (sum 0)
    (for (i start end)
      (inc sum (func i)))))

Funzione che effettua la produttoria:

(define (fn-mul func start end)
  (let (mult 1)
    (for (i start end)
      (setq mult (mul mult (func i))))))

Esempi:

  f(x) = 1 + 1/2 + 1/3 + ... + 1/n

(define (f x) (div x))

(fn-sum f 1 20)
;-> 3.597739657143682

(fn-mul f 1 10)
;-> 2.755731922398588e-007

(fn-sum (fn(x) (div (add 1 x))) 1 20)
;-> 2.64535870476273

Nota: alcune volte è necessario scrivere delle funzioni ad hoc per calcolare i valori di alcune serie. Per esempio, per la serie seguente:

  f(x) = 1/1! + 1/2! + 1/3! + ... + 1/n!

Possiamo precalcolare i valori dei fattoriali:

(define (fact limit)
  (local (f lst)
    (setq f 1)
    (setq lst '(1))
    (for (i 1 limit)
      (setq f (* f i))
      (push f lst -1)
    )
    lst))

(setq f (fact 10))
;-> (1 1 2 6 24 120 720 5040 40320 362880 3628800)

(fn-sum (fn(x) (div (f x))) 1 5)
;-> 1.71666667


---------------------------------------------------------------------------
Teorema di Nicomachus (somma del k-esimo gruppo di numeri positivi dispari)
---------------------------------------------------------------------------

Consideriamo i numeri dispari positivi in ​​ordine crescente come 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, ... e raggruppati come (1), (3 5), (7 9 11), (13 15 17 19), ... e così via.
Quindi, il primo gruppo è (1), il secondo gruppo è (3 5) e il terzo gruppo è (7 9 11), ecc. in generale, il k-esimo gruppo contiene i successivi k elementi della sequenza.
Dato k, trovare la lista dei numeri e la somma del k-esimo gruppo.

Esempi:
Input: k = 3
Uscita: 27
Il terzo gruppo è (7 9 11) e la somma è 27.
Input: k = 4
Uscita: 64
Il quarto gruppo è (13 15 17 19) e la somma è 64.

Metodo 1
--------
Possiamo il primo elemento del gruppo k-esimo considerando che:
 - il primo elemento del 1° gruppo è 1, che è il 1° numero dispari.
 - il primo elemento del 2° gruppo è 3, che è il 2° numero dispari.
 - il primo elemento del 3° gruppo è 7, che è il 4° numero dispari.
 - il primo elemento del 4° gruppo è 13, che è il 7° numero dispari.
e così via.

In generale, il primo elemento del k-esimo gruppo è l'ennesimo numero dispari,

 n = (1 + 2 + 3 + ... + (k – 1)) + 1.

In generale, l'ennesimo numero dispari vale 2n – 1.
Questo ci permette di calcolare il primo elemento del k-esimo gruppo:

  primo-elemento = (k * (k - 1)) + 1

Sapendo che ci sono k elementi nel gruppo, possiamo generarli e calcolare la loro somma.

Funzione che calcola la somma del k-esimo gruppo di interi dispari positivi:

(define (nico1 k all)
    (local (cur nic)
      ; trova il primo elemento del gruppo k
      (setq cur (+ (* k (- k 1)) 1))
      ; genera tutti gli elementi del gruppo k
      (setq nic (sequence cur (- (+ cur (* 2 k)) 1) 2))
      ; se all vale true ritorna la lista e la somma degli elementi
      (if all
        (list nic (apply + nic))
        ;else altrimenti ritorna solo la somma degli elementi
        (apply + nic))))

Facciamo alcune prove:

(nico1 3 true)
;-> ((7 9 11) 27)

(map nico1 (sequence 1 10))
;-> (1 8 27 64 125 216 343 512 729 1000)

(nico1 10 true)
;-> ((91 93 95 97 99 101 103 105 107 109) 1000)

Possiamo migliorare la funzione considerando il teorema di Nicomachus, il quale afferma che la somma del k-esimo gruppo vale k^3:

  1^3 = 1
  2^3 = 3+5
  3^3 = 7+9+11
  4^3 = 13+15+17+19
  ...

   k
   ∑[k*(k-1) - 1 + 2*i] = k^3
  i=1

Dimostrazione

   k                       k
   ∑[k*(k-1) - 1 + 2*i] =  ∑[k^k - k + 2i - 1] =
  i=1                     i=1

     k             k       k
  =  ∑[k^2 - k) +  ∑[2i] - ∑[1] =
    i=1           i=1     i=1

  = k(k^2 - k) + 2(1 + 2 + 3 + 4 + ... + k) - (1 + 1 + ... + 1) =

  = k(k^2 - k) + 2*(n/2)*(2 + n) - n =

  = k^3 - k^2 + k + k^2 - k = k^3

La funzione diventa la seguente:

(define (nico2 k all)
  (if (not all)
    ; calcola e restituisce la somma del k-esimo gruppo
    (* k k k)
    ;else
    (local (cur nic)
      ; trova il primo elemento del gruppo k
      (setq cur (+ (* k (- k 1)) 1))
      ; genera tutti gli elementi del gruppo k
      (setq nic (sequence cur (- (+ cur (* 2 k)) 1) 2))
      ;ritorna la lista e la somma degli elementi
      (list nic (apply + nic)))))

(nico2 4 true)
;-> ((13 15 17 19) 64)

(map nico2 (sequence 1 10))
;-> (1 8 27 64 125 216 343 512 729 1000)

(nico2 10 true)
;-> ((91 93 95 97 99 101 103 105 107 109) 1000)


-----------
Numeri Hoax
-----------

Un numero hoax (beffa, truffa, inganno) è definito come un numero composto, la cui somma delle cifre è uguale alla somma delle cifre dei suoi distinti fattori primi.
Notare che 1 non è considerato un numero primo, quindi non è incluso nella somma delle cifre di distinti fattori primi.

Esempi:
22 è un numero hoax, perchè i distinti fattori primi di 22 sono 2 e 11.
La somma delle loro cifre è 4, cioè 2 + 1 + 1.
Anche la somma delle cifre di 22 è 4, cioè 2 + 2.

84 è un numero hoax perchè i distinti fattori primi di 84 sono 2, 3 e 7.
La somma delle loro cifre è 12, cioè 2 + 3 + 4.
Anche la somma delle cifre di 84 è 12, cioè 8 + 4.

Sequenza OEIS: A019506
  22, 58, 84, 85, 94, 136, 160, 166, 202, 234, 250, 265, 274, 308, 319,
  336, 346, 355, 361, 364, 382, 391, 424, 438, 454, 456, 476, 483, 516,
  517, 526, 535, 562, 627, 634, 644, 645, 650, 654, 660, 663, 690, 702,
  706, 732, 735, 762, 778, 855, 860, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (hoax? num)
  (let (f (factor num))
    (if (= (length f) 1)
        nil ; numero primo
        ;else
        (= (apply + (map digit-sum (unique f)))
           (digit-sum num)))))

Facciamo alcune prove:

(hoax? 22)
;-> true
(hoax? 84)
;-> true

(filter hoax? (sequence 2 1000))
;-> (22 58 84 85 94 136 160 166 202 234 250 265 274 308 319 336 346 355 361
;->  364 382 391 424 438 454 456 476 483 516 517 526 535 562 627 634 644 645
;->  650 654 660 663 690 702 706 732 735 762 778 855 860 861 895 913 915 922
;->  948 958 985)


------------------------------------------------------
Numero di cifre dei fattoriali (formula di Kamenetsky)
------------------------------------------------------

La formula di Kamenetsky approssima il numero di cifre del fattoriale di un numero n:

  digits = log10( ((n/e)^n) * sqrt(2*pi*n) ) =
         = n*log10(n/e) + log10(2*pi*n)/2

(setq E 2.7182818284590451)
(setq PI 3.1415926535897931)
(define (fact-digit n)
  (cond ((< n 0) 0)
        ((<= n 1) 1)
        (true
          (add (floor
                      (add (mul n (log (div n E) 10))
                          (div (log (mul 2 PI n) 10) 2)))
              1))))

Facciamo alcune prove:

(fact-digit 120)
;-> 199
(fact-digit 1e6)
;-> 5565709
(fact-digit 1e9)
;-> 8565705523


--------------------------------
Massimo sottoinsieme con MCD = 1
--------------------------------

Dati n numeri interi, dobbiamo trovare il sottoinsieme più grande con MCD uguale a 1.

Il problema diventa semplice se facciamo le seguenti considerazioni:
Supponiamo di aver trovato un sottoinsieme con MCD 1, se gli aggiungiamo un nuovo elemento allora MCD rimane ancora 1.
Quindi se esiste un sottoinsieme con MCD 1, allora anche MCD dell'insieme completo è 1.
Per risolvere il problema troviamo prima MCD dell'insieme completo, se è 1, allora l'insieme completo è quel sottoinsieme altrimenti nessun sottoinsieme esiste con GCD 1.

(define (list-gcd1 lst)
  (if (= (apply gcd lst) 1)
      lst
      '()))

Facciamo alcune prove:

(list-gcd1 (rand 100 10))
;-> (93 4 89 29 22 76 41 20 62 60)

(list-gcd1 (sequence 2 100 2))
;-> ()


--------------
Coppie di cubi
--------------

Dato un numero n, trovare due coppie che possono rappresentare il numero come somma di due cubi. In altre parole, trovare due coppie (a, b) e (c, d) tali che un dato numero n possa essere espresso come:

   n = a^3 + b^3 = c^3 + d^3

dove a, b, c e d sono quattro numeri distinti.

Esempi:
n = 1729
Coppie di cubi: (1, 12) e (9, 10)
1729 = 1^3 + 12^3 = 9^3 + 10^3

n = 4104
Coppie di cubi: (2, 16) e (9, 15)
4104 = 2^3 + 16^3 = 9^3 + 15^3

n = 13832
Coppie di cubi: (2, 24) e (18, 20)
13832 = 2^3 + 24^3 = 18^3 + 20^3

Per soddisfare i vincoli qualsiasi numero n deve avere due coppie distinte (a, b) e (c, d) tali che a, b, c e d sono tutti minori di n^1/3.
Creiamo un vettore di dimensione n^1/3 in cui ogni indice "i" dell'array contiene un valore uguale al cubo di quell'indice, ovvero vettore(i) = i^3.
Ora il problema si riduce a trovare coppie di elementi in un vettore ordinato la cui somma sia uguale a un dato numero n (vedi anche "Somma di numeri in una lista (Google)"):

Algoritmo:
1) Creare una hash-map
2) Per ogni elemento val della lista lst
    Se (somma - val) esiste nella hash-map,
       allora aggiungere la coppia ((somma - val), val) nella lista soluzione
    Aggiungere val alla hash-map
3) Restituire la lista soluzione

(define (coppie lst somma)
  (local (temp out)
    (setq out '())
    (new Tree 'hash)
    (dolist (val lst)
      (setq temp (- somma val))
      (if (hash (string temp))
          (push (list temp val) out -1)
      )
      (hash (string val) val)
    )
    (delete 'hash)
    out))

(coppie '(10 15 3 7) 17)
;-> ((7 10))

(coppie '(-2 3 7 -9 2) 5)
;-> ((-2 7) (3 2))

(coppie '(3 -2 15 10 7 -4 -11) 21)
;-> ()

Adesso scriviamo la funzione finale che cerca le coppie di cubi di un numero:

(define (cube-pairs num)
  (local (out cube3 c3)
    (setq out '())
    (setq cube3 (array (int (add (pow num (div 3)) 1)) '(0)))
    ; generazione valori del vettore dei cubi
    (for (i 1 (- (length cube3) 1))
      (setf (cube3 i) (mul i i i))
    )
    ; ricerca delle coppie soluzione
    (setq c3 (coppie cube3 num))
    ; estrazione delle radici cubiche dei valori delle coppie soluzione
    (dolist (el c3)
      (push (list (el 0) (el 1)
                  (round (pow (el 0) (div 3)))
                  (round (pow (el 1) (div 3)))) out -1)
    )
    out))

Facciamo alcune prove:

(cube-pairs 1)
;-> ((0 1 0 1))
(cube-pairs 1729)
;-> ((729 1000 9 10) (1 1728 1 12))
(cube-pairs 1729)
;-> ((729 1000 9 10) (1 1728 1 12))
(cube-pairs 4104)
;-> ((729 3375 9 15) (8 4096 2 16))
(cube-pairs 13832)
;-> ((5832 8000 18 20) (8 13824 2 24))
(cube-pairs 20683)
;-> ((6859 13824 19 24) (1000 19683 10 27))

Funzione che elenco tutte le coppie di cubi di tutti i numeri fino dato limite:

(define (cube-pairs-all limit)
  (local (out)
    (setq out '())
    (for (i 1 limit)
      (setq pairs (cube-pairs i))
      (if (not (null? pairs))
          (push (list i pairs) out -1)
      )
    )
    out))

(cube-pairs-all 1000)
;-> ((1 ((0 1 0 1))) (8 ((0 8 0 2))) (9 ((1 8 1 2))) (27 ((0 27 0 3)))
;->  (28 ((1 27 1 3))) (35 ((8 27 2 3))) (64 ((0 64 0 4)))
;->  (65 ((1 64 1 4))) (72 ((8 64 2 4))) (91 ((27 64 3 4)))
;->  (126 ((1 125 1 5))) (133 ((8 125 2 5))) (152 ((27 125 3 5)))
;->  (189 ((64 125 4 5))) (217 ((1 216 1 6))) (224 ((8 216 2 6)))
;->  (243 ((27 216 3 6))) (280 ((64 216 4 6))) (341 ((125 216 5 6)))
;->  (344 ((1 343 1 7))) (351 ((8 343 2 7))) (370 ((27 343 3 7)))
;->  (407 ((64 343 4 7))) (468 ((125 343 5 7))) (512 ((0 512 0 8)))
;->  (513 ((1 512 1 8))) (520 ((8 512 2 8))) (539 ((27 512 3 8)))
;->  (559 ((216 343 6 7))) (576 ((64 512 4 8))) (637 ((125 512 5 8)))
;->  (728 ((216 512 6 8))) (730 ((1 729 1 9))) (737 ((8 729 2 9)))
;->  (756 ((27 729 3 9))) (793 ((64 729 4 9))) (854 ((125 729 5 9)))
;->  (855 ((343 512 7 8))) (945 ((216 729 6 9))))


----------------------------
MCD delle cifre di un numero
----------------------------

Scrivere una funzione per calcolare il MCD delle cifre di un numero intero positivo.

Sequenza OEIS: A052423
  1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 2,
  1, 2, 1, 2, 1, 2, 1, 3, 1, 1, 3, 1, 1, 3, 1, 1, 3, 4, 1, 2, 1, 4,
  1, 2, 1, 4, 1, 5, 1, 1, 1, 1, 5, 1, 1, 1, 1, 6, 1, 2, 3, 2, 1, 6,
  1, 2, 3, 7, 1, 1, 1, 1, 1, 1, 7, 1, 1, 8, 1, 2, 1, 4, 1, 2, 1, 8,
  1, 9, 1, 1, 3, 1, 1, 3, 1, 1, 9, 1, 1, 1, ...

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

(define (digit-gcd num)
  (apply gcd (int-list num)))

(digit-gcd 2468)
;-> 2
(digit-gcd 11)
;-> 1
(digit-gcd 66)
;-> 6

Calcoliamo la sequenza:

(map digit-gcd (sequence 1 200))
;-> (1 2 3 4 5 6 7 8 9 1 1 1 1 1 1 1 1 1 1 2 1 2 1 2 1 2 1 2 1 3 1 1 3 1 1
;->  3 1 1 3 4 1 2 1 4 1 2 1 4 1 5 1 1 1 1 5 1 1 1 1 6 1 2 3 2 1 6 1 2 3 7
;->  1 1 1 1 1 1 7 1 1 8 1 2 1 4 1 2 1 8 1 9 1 1 3 1 1 3 1 1 9 1 1 1 1 1 1
;->  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;->  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
;->  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2)


---------------------------------
La funzione DEFUN del Common LISP
---------------------------------

La funzione DEFUN del Common LISP è l'analoga della funzione "define" di newLISP.
La funzione DEFUN ha la seguente sintassi:

(defun <name> (list of arguments)
  "docstring"
  (function body))

Possiamo scrivere una macro per simulare la funzione DEFUN:

(define-macro (defun _name _args)
      (set _name (append '(lambda ) (list _args) (args))))

Esempio:

(defun test (v1 v2)
  (println v1 { } v2))
;-> (lambda (v1 v2) (println v1 " " v2))

(test 10 20)
;-> 10 20
(test 37 '(+ 10 2))
;-> 37 (+ 10 2)


---------------
Spirale di Ulam
---------------

La spirale di Ulam, o spirale dei numeri primi, è una rappresentazione grafica dei numeri primi che rivela un pattern non ancora pienamente compreso.
Fu scoperta dal matematico polacco Stanislaw Ulam nel 1963, mentre, sovrappensiero, scarabocchiava su di un foglietto di carta durante un meeting. Ulam, annoiato dal convegno, disegnò una griglia di numeri, mettendo l'1 al centro e tutti i seguenti disposti a spirale, poi segnò tutti i numeri primi (togliendo tutti gli altri numeri) ottenendo la seguente rappresentazione:

  101 --- --- ---  97 --- --- --- --- --- ---
  --- --- --- --- ---  61 ---  59 --- --- ---
  103 ---  37 --- --- --- --- ---  31 ---  89
  ---  67 ---  17 --- --- ---  13 --- --- ---
  --- --- --- ---   5 ---   3 ---  29 --- ---
  --- --- ---  19 --- ---   2  11 ---  53 ---
  107 ---  41 ---   7 --- --- --- --- --- ---
  ---  71 --- --- ---  23 --- --- --- --- ---
  109 ---  43 --- --- ---  47 --- --- ---  83
  ---  73 --- --- --- --- ---  79 --- --- ---
  --- --- 113 --- --- --- --- --- --- --- ---

Scrivere un programma per stampare la spirale di Ulam.

(define (print-matrix matrix)
"Print a matrix m x n"
  (local (row col lenmax digit fmtstr)
    ; converto matrice in lista?
    (if (array? matrix) (setq matrix  (array-list matrix)))
    ; righe della matrice
    (setq row (length matrix))
    ; colonne della matrice
    (setq col (length (first matrix)))
    ; valore massimo della lunghezza di un elemento (come stringa)
    (setq lenmax (apply max (map length (map string (flat matrix)))))
    ; calcolo spazio per gli elementi
    (setq digit (+ 1 lenmax))
    ; creo stringa di formattazione
    (setq fmtstr (append "%" (string digit) "s"))
    ; stampa la matrice
    (for (i 0 (- row 1))
      (for (j 0 (- col 1))
        (print (format fmtstr (string (matrix i j))))
      )
      (println))))

Prima scriviamo un programma che stampa una spirale di numeri (in senso orario o antiorario) partendo con il primo numero al centro della spirale:

(define (spiral size clockwise)
  (local (matrix x y dx dy dircount ringcount repeatcount value)
    (setq dx '(0 -1 0 1)) (setq dy '(1 0 -1 0)) (setq dircount 4)
    (setq ringcount (/ (- size 1) 2))
    (setq y ringcount)
    (setq x ringcount)
    (setq repeatcount 0)
    (setq value 1)
    (setq matrix (array size size '(0)))
    (setf (matrix y x) value)
    (++ value)
    (for (ring 0 (- ringcount 1))
      (-- y)
      (++ x)
      (++ repeatcount 2)
      (for (dir 0 (- dircount 1))
        (for (repeat 0 (- repeatcount 1))
        (setq y (+ y (dy dir)))
        (setq x (+ x (dx dir)))
        (setq (matrix y x) value)
        (++ value)
        )
      )
    )
    ; fill last column and last row of matrix with even size
    (if (even? size)
      (begin
        ; fill last column
        (for (r 0 (- size 1))
          (setf (matrix r (- size 1)) value)
          (++ value)
        )
        ; fill last row
        (for (c (- size 2) 0 -1)
          (setf (matrix (- size 1) c) value)
          (++ value)
        )
      )
    )
    ; clockwise or counter-clockwise spiral ?
    ; matrix is ccw
    ; (reverse matrix) is cw
    (if clockwise
        matrix
        (reverse matrix))))

Facciamo alcune prove:

(print-matrix (spiral 7))
;->  37 36 35 34 33 32 31
;->  38 17 16 15 14 13 30
;->  39 18  5  4  3 12 29
;->  40 19  6  1  2 11 28
;->  41 20  7  8  9 10 27
;->  42 21 22 23 24 25 26
;->  43 44 45 46 47 48 49
(print-matrix (spiral 7 true))
;->  43 44 45 46 47 48 49
;->  42 21 22 23 24 25 26
;->  41 20  7  8  9 10 27
;->  40 19  6  1  2 11 28
;->  39 18  5  4  3 12 29
;->  38 17 16 15 14 13 30
;->  37 36 35 34 33 32 31
(print-matrix (spiral 8))
;->  64 63 62 61 60 59 58 57
;->  37 36 35 34 33 32 31 56
;->  38 17 16 15 14 13 30 55
;->  39 18  5  4  3 12 29 54
;->  40 19  6  1  2 11 28 53
;->  41 20  7  8  9 10 27 52
;->  42 21 22 23 24 25 26 51
;->  43 44 45 46 47 48 49 50
(print-matrix (spiral 8 true))
;->  43 44 45 46 47 48 49 50
;->  42 21 22 23 24 25 26 51
;->  41 20  7  8  9 10 27 52
;->  40 19  6  1  2 11 28 53
;->  39 18  5  4  3 12 29 54
;->  38 17 16 15 14 13 30 55
;->  37 36 35 34 33 32 31 56
;->  64 63 62 61 60 59 58 57

Adesso scriviamo la funzione che stampa la spirale di Ulam:

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (ulam size clockwise)
  (local (matrix x y dx dy dircount ringcount repeatcount value max-val empty)
    (setq maxval (* size size))
    (setq empty (dup "-" (length 123)))
    (setq dx '(0 -1 0 1)) (setq dy '(1 0 -1 0)) (setq dircount 4)
    (setq ringcount (/ (- size 1) 2))
    (setq y ringcount)
    (setq x ringcount)
    (setq repeatcount 0)
    (setq value 1)
    (setq matrix (array size size '(0)))
    ; print only prime number
    (if (prime? value)
      (setf (matrix y x) value)
      (setf (matrix y x) empty)
    )
    (++ value)
    (for (ring 0 (- ringcount 1))
      (-- y)
      (++ x)
      (++ repeatcount 2)
      (for (dir 0 (- dircount 1))
        (for (repeat 0 (- repeatcount 1))
        (setq y (+ y (dy dir)))
        (setq x (+ x (dx dir)))
        ; print only prime number
        (if (prime? value)
          (setf (matrix y x) value)
          (setf (matrix y x) empty)
        )
        (++ value)
        )
      )
    )
    ; fill last column and last row of matrix with even size
    (if (even? size)
      (begin
        ; fill last column
        (for (r 0 (- size 1))
          (if (prime? value)
            (setf (matrix r (- size 1)) value)
            (setf (matrix r (- size 1)) empty)
          )
          (++ value)
        )
        ; fill last row
        (for (c (- size 2) 0 -1)
          (if (prime? value)
            (setf (matrix (- size 1) c) value)
            (setf (matrix (- size 1) c) empty)
          )
          (++ value)
        )
      )
    )
    ; clockwise or counter-clockwise spiral ?
    ; matrix is ccw
    ; (reverse matrix) is cw
    (if clockwise
        matrix
        (reverse matrix))))

Facciamo alcune prove:

(print-matrix (ulam 7))
;->   37 --- --- --- --- ---  31
;->  ---  17 --- --- ---  13 ---
;->  --- ---   5 ---   3 ---  29
;->  ---  19 --- ---   2  11 ---
;->   41 ---   7 --- --- --- ---
;->  --- --- ---  23 --- --- ---
;->   43 --- --- ---  47 --- ---

(print-matrix (ulam 16))
;->  --- --- --- --- --- 251 --- --- --- --- --- --- --- --- --- 241
;->  197 --- --- --- 193 --- 191 --- --- --- --- --- --- --- --- ---
;->  --- --- --- --- --- --- --- 139 --- 137 --- --- --- --- --- 239
;->  199 --- 101 --- --- ---  97 --- --- --- --- --- --- --- 181 ---
;->  --- --- --- --- --- --- ---  61 ---  59 --- --- --- 131 --- ---
;->  --- --- 103 ---  37 --- --- --- --- ---  31 ---  89 --- 179 ---
;->  --- 149 ---  67 ---  17 --- --- ---  13 --- --- --- --- --- ---
;->  --- --- --- --- --- ---   5 ---   3 ---  29 --- --- --- --- ---
;->  --- 151 --- --- ---  19 --- ---   2  11 ---  53 --- 127 --- 233
;->  --- --- 107 ---  41 ---   7 --- --- --- --- --- --- --- --- ---
;->  --- --- ---  71 --- --- ---  23 --- --- --- --- --- --- --- ---
;->  --- --- 109 ---  43 --- --- ---  47 --- --- ---  83 --- 173 ---
;->  --- --- ---  73 --- --- --- --- ---  79 --- --- --- --- --- 229
;->  --- --- --- --- 113 --- --- --- --- --- --- --- --- --- --- ---
;->  --- 157 --- --- --- --- --- 163 --- --- --- 167 --- --- --- 227
;->  211 --- --- --- --- --- --- --- --- --- --- --- 223 --- --- ---


----------------------------
Coefficiente di correlazione
----------------------------

Il coefficiente di correlazione, chiamato anche coefficiente di correlazione incrociata (cross-correlation coefficient), è un valore che rappresenta la forza della relazione tra due liste di valori.
Il coefficiente di correlazione è sempre compreso tra -1 (correlazione negativa) e +1 (correlazione positiva).

La formula per calcolare il coefficiente di correlazione è la seguente:

                      n*(∑x*y) - (∑x)*(∑y)
   r = --------------------------------------------------
         sqrt[(n*(∑x^2) - (∑x)^2) * (n*(∑y^2) - (∑y)^2)

Funzione per il calcolo del coefficiente di correlazione tra due liste:

(define (correlation a b)
(local (sumA sumB sumAB squareSumA squareSumB n)
  (set 'sumA 0 'sumB 0 'sumAB 0 'squareSumA 0 'squareSumB 0)
  (setq n (length a))
  (for (i 0 (- n 1))
    # sum of elements of array A.
    (setq sumA (add sumA (a i)))
    # sum of elements of array B.
    (setq sumB (add sumB (b i)))
    # sum of A[i] * B[i]
    (setq sumAB (add sumAB (mul (a i) (b i))))
    # sum of square of array elements.
    (setq squareSumA (add squareSumA (mul (a i) (a i))))
    (setq squareSumB (add squareSumB (mul (b i) (b i))))
  )
  ; calcola il coefficiente di correlazione
  (div (sub (mul n sumAB) (mul sumA sumB))
       (sqrt (mul (sub (mul n squareSumA) (mul sumA sumA))
                  (sub (mul n squareSumB) (mul sumB sumB)))))))

Facciamo alcune prove:

(setq x '(15 18 21 24 27))
(setq y '(25 25 27 31 32))
(correlation x y)
;-> 0.9534625892455922

(setq x1 '(43 21 25 42 57 59))
(setq y1 '(99 65 79 75 87 81))
(correlation x1 y1)
;-> 0.5298089018901744

(correlation (sequence 1 10) (sequence 1 10))
;-> 1
(correlation (sequence 1 10) (sequence 11 20))
;-> 1
(correlation (sequence 1 10) (sequence 100 1000 100))
;-> 1

Liste casuali:

(setq x2 (rand 100 100))
(setq y2 (rand 100 100))
(correlation x2 y2)
;-> 0.1470523813894944
(correlation (sort x2) (sort y2))
;-> 0.9926726835897934


--------------
Numeri frugali
--------------

Un numero frugale (o numero economico) è un numero il cui numero di cifre è strettamente maggiore del numero di cifre nella sua fattorizzazione (inclusi gli esponenti). Se l'esponente è 1 per un certo numero primo, coinvolto nella fattorizzazione dei primi, allora quell'esponente non contribuisce al numero di cifre nella fattorizzazione dei primi.
Alcuni esempi di numeri frugali sono:
1) 125 = 5^3, qui il numero di cifre nel numero è 3 (1, 2 e 5) che è strettamente maggiore del numero di cifre nella sua fattorizzazione primi che è 2 (5 e 3).
2) 512 = 2^9, qui il numero di cifre nel numero è 3 (5, 1 e 2) che è strettamente maggiore del numero di cifre nella sua fattorizzazione primi che è 2 (2 e 9).
3) 1029 = 3 * 7^3, qui il numero di cifre nel numero è 4 (1, 0, 2 e 9) che è strettamente maggiore del numero di cifre la sua fattorizzazione primo che è 3 (3, 7 e 3 ).

Sequenza OEIS: A046759
  125, 128, 243, 256, 343, 512, 625, 729, 1024, 1029, 1215, 1250, 1280,
  1331, 1369, 1458, 1536, 1681, 1701, 1715, 1792, 1849, 1875, 2048, 2187,
  2197, 2209, 2401, 2560, 2809, 3125, 3481, 3584, 3645, 3721, 4096, 4374,
  4375, 4489, 4802, 4913, ...

Nota: i numeri primi non sono numeri frugali. Infatti il numero di cifre nella fattorizzazione di un numero primo è uguale al numero di cifre nel numero primo (poiché gli esponenti di valore 1 non vengono considerati).

Generiamo la fattorizzazione del numero e poi ne calcoliamo il numero di cifre.
Infine confrontiamo questo valore con il nuumero di cifre del numero.

(define (factor-group num)
"Factorize an integer number"
  (if (< num 2) nil
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

(factor-group 1029)
;-> (3 1) (7 3))

Funzione che verifica se un numero è frugale:

(define (frugal? num)
  (let (sum 0)
    (dolist (el (flat (factor-group num)))
      (if (!= el 1) (++ sum (length el)))
    )
    (= (length num) (+ sum 1))))

Facciamo alcune prove:

(frugal? 1029)
;-> true
(frugal? 125)
;-> true
(frugal? 11);-> nil

Calcoliamo tutti i numeri frugali fino a 5000:

(filter frugal? (sequence 2 5000))
;-> (125 128 243 256 343 512 625 729 1024 1029 1215 1250 1280 1331 1369 1458
;->  1536 1681 1701 1715 1792 1849 1875 2048 2197 2209 2560 2809 3481 3584
;->  3645 3721 4096 4374 4375 4489 4802 4913)

Vediamo quanti numeri frugali ci sono fino ad 1 milione:

(time (println (length (filter frugal? (sequence 2 1e6)))))
;-> 2723
;-> 2654.927


-----------
Numeri Blum
-----------

Un numero Blum è un intero semiprimo (cioè un numero che è il prodotto esattamente di due numeri primi).
Supponiamo che p e q siano i due fattori (cioè n = p * q), essi (p e q) sono della forma 4t + 3, dove t è un numero intero.

Sequenza OEIS: A016105
   21, 33, 57, 69, 77, 93, 129, 133, 141, 161, 177, 201, 209, 213, 217,
   237, 249, 253, 301, 309, 321, 329, 341, 381, 393, 413, 417, 437, 453,
   469, 473, 489, 497, 501, 517, 537, 553, 573, 581, 589, 597, 633, 649,
   669, 681, 713, 717, 721, 737, 749, 753, 781, 789, ...

Nota: a causa della condizione che entrambi i fattori debbano essere semi-primi, i numeri pari non possono essere interi Blum né possono esserlo i numeri inferiori a 20.

Esempi:
N = 33
Blum? Si
Spiegazione: 33 = 3 * 11, 3 e 11 sono entrambi semiprimi
e nella forma 4t + 3 (per t = 0,2)

N: 25
Blum? No
Spiegazione: 25 = 5*5, 5 e 5 sono entrambi semiprimi,
ma non sono nella forma 4t + 3.

N: 77
Blum? Si
Spiegazione: 77 = 7 * 11, 7 e 11 sono entrambi semiprimi
e nella forma 4t + 3 (per t = 1,2)

Algoritmo:
Dato un numero N intero, dispari e maggiore di 20, calcoliamo i numeri primi da 1 a N.
Se troviamo un numero primo che divide N e il suo quoziente, allora entrambi sono primi e seguono la forma 4t + 3 per un intero, quindi il numero intero N è Blum.

(define (blum? num)
(catch
  (local (prime j q)
  ; crea un vettore di numeri primi (true/nil)
  (setq prime (array (+ num 1) '(true)))
  (setq (prime 0) nil)
  (setq (prime 1) nil)
  (setq i 2)
  (while (<= (* i i) num)
    (if (prime i)
        ; aggiorna tutti i multipli
        (for (j (* i 2) num i)
          (setf (prime j) nil)
        )
    )
    (++ i)
  )
  ; check blum (solo numeri dispari)
  (for (j 2 num)
    (if (prime j)
      ; controlla se i fattori sono nella forma 4t + 3
      (if (and (= (% num j) 0) (= (% (- j 3) 4) 0))
        (begin
          (setq q (/ num j))
          (throw (and (!= q j) (prime q) (= (% (- q 3) 4) 0))))
      )
    )
  )
  nil)))

Facciamo alcune prove:

(blum? 11)
;-> nil
(blum? 33)
;-> true
(blum? 501)
;-> true

Calcoliamo tutti i numeri blum fino a 1000:

(filter blum? (sequence 20 1000))
;-> (21 33 57 69 77 93 129 133 141 161 177 201 209 213 217 237 249 253 301
;->  309 321 329 341 381 393 413 417 437 453 469 473 489 497 501 517 537 553
;->  573 581 589 597 633 649 669 681 713 717 721 737 749 753 781 789 813 817
;->  849 869 889 893 913 917 921 933 973 989 993)


---------------------------------
Firma dei primi (Prime signature)
---------------------------------

La firma dei primi (prime signature - firma prima) di un numero è la sequenza di esponenti della sua fattorizzazione ordinati in ordine di dimensione:

  fattorizzazione(n) = p1^a1*p2^a2*...*pn^an
  dove p1 < p2 < ... < pn.

  firma(n) = (a1 a2 ... an)

Ad esempio, tutti i numeri primi hanno una firma (1), i quadrati dei numeri primi hanno una firma (2), i prodotti di due primi distinti hanno firma (1 1) e i prodotti di un quadrato di un numero primo e un numero primo diverso (ad es. 12,18,20,... ) hanno firma (2 1).

Nota: Il numero di divisori che di un numero è determinato dalla sua firma come segue:
Se aggiungiamo uno a ciascun esponente e li moltiplichiamo insieme otteniamo il numero di divisori incluso il numero stesso e 1. Ad esempio, 20 ha firma (2 1) e quindi il numero di divisori è 3*2=6 (1,2,4,5,10 e 20).

Dato un numero con la firma prima S, risulta:
- Un numero primo se S = (1)
- Un quadrato se gcd S è pari
- Un numero intero senza quadrati se max S = 1
- Un numero potente se min S ≥ 2
- Un numero di Achille se min S ≥ 2 e gcd S = 1
- "k"-quasi primo se somma S = "k"

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

La funzione per calcolare la firma prima di un numero:

(define (signature num)
  (map last (factor-group num)))

Facciamo alcune prove:

(signature 1)
;-> (1)
(signature 11)
;-> (1)
(signature 20)
;-> (2 1)

Calcoliamo la firma dei primi 20 numeri:

(map signature (sequence 1 20))
;-> ((1) (1) (1) (2) (1) (1 1) (1) (3) (2) (1 1) (1)
;->  (2 1) (1) (1 1) (1 1) (4) (1) (1 2) (1) (2 1))


-----------------
Numeri di Achille
-----------------

Un numero di Achille è un intero positivo potente (nel senso che ogni fattore primo si presenta con esponente maggiore di uno), ma imperfetto (nel senso che il numero non è una potenza perfetta).

Sequenza OEIS: A052486
  72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972, 1125,
  1152, 1323, 1352, 1372, 1568, 1800, 1944, 2000, 2312, 2592, 2700, 2888,
  3087, 3200, 3267, 3456, 3528, 3872, 3888, 4000, 4232, 4500, 4563, 4608,
  5000, 5292, 5324, 5400, 5408, 5488, 6075, ...

Ponendo "Signature" come la firma prima di un numero, allora il numero è di Achille se min(Signature) ≥ 2 e gcd(Signature) = 1.

(define (factor-group num)
"Factorize an integer number"
  (if (= num 1) '((1 1))
      (letn ((out '()) (lst (factor num)) (cur-val (first lst)) (cur-count 0))
        (dolist (el lst)
          (if (= el cur-val) (++ cur-count)
              (begin
                (push (list cur-val cur-count) out -1)
                (setq cur-count 1 cur-val el))))
        (push (list cur-val cur-count) out -1))))

Funzione per calcolare la firma prima di un numero:

(define (signature num)
  (map last (factor-group num)))

Funzione che verifica se un numero è di Achille:

(define (achille? num)
  (let (s (signature num))
    (and (>= (apply min s) 2) (= (apply gcd s) 1))))

Facciamo alcune prove:

(achille? 72)
;-> true

(achille? 100)
;-> nil

Calcoliamo tutti i numeri di Achille fino a 10000:

(filter achille? (sequence 1 10000))
;-> (72 108 200 288 392 432 500 648 675 800 864 968 972 1125 1152 1323 1352
;->  1372 1568 1800 1944 2000 2312 2592 2700 2888 3087 3200 3267 3456 3528
;->  3872 3888 4000 4232 4500 4563 4608 5000 5292 5324 5400 5408 5488 6075
;->  6125 6272 6728 6912 7200 7688 7803 8575 8712 8748 8788 9000 9248 9747
;->  9800)

Calcoliamo quanti sono i numeri di Achille fino ad 1 milione:

(time (println (length (filter achille? (sequence 1 1e6)))))
;-> 916
;-> 1932.563

Un numero intero positivo N è un numero di Achille forte se, sia N che toziente(N) sono numeri di Achille.

Sequenza OEIS: A194085
  500, 864, 1944, 2000, 2592, 3456, 5000, 10125, 10368, 12348, 12500,
  16875, 19652, 19773, 30375, 31104, 32000, 33275, 37044, 40500, 49392,
  50000, 52488, 55296, 61731, 64827, 67500, 69984, 78608, 80000, 81000,
  83349, 84375, 93312, 108000, ...

(define (totient num)
"Calculates the eulero totient of a given number"
  (if (= num 1) 1
    (let (res num)
      (dolist (f (unique (factor num)))
        (setq res (- res (/ res f))))
      res)))

La seguente funzione verifica se un numero è di Achille forte, ma non è ottimizzata (calcola due volte (factor num)):

(define (achille-strong? num)
  (and (achille? num) (achille? (totient num))))

Calcoliamo quanti sono i numeri di Achille forte fino ad 10000:

(time (println (length (filter achille-strong? (sequence 1 1e4)))))
;-> 7
;-> 14.699

Calcoliamo quanti sono i numeri di Achille forte fino ad 1 milione:

(time (println (length (filter achille-strong? (sequence 1 1e6)))))
;-> 99
;-> 1999.647

Vediamo quali sono sono i numeri di Achille forte fino ad 1 milione:

(time (println (filter achille-strong? (sequence 1 1e6))))
;-> (500 864 1944 2000 2592 3456 5000 10125 10368 12348 12500 16875 19652
;->  19773 30375 31104 32000 33275 37044 40500 49392 50000 52488 55296
;->  61731 64827 67500 69984 78608 80000 81000 83349 84375 93312 108000
;->  111132 124416 128000 135000 148176 151875 158184 162000 165888 172872
;->  177957 197568 200000 202612 209952 219488 221184 237276 243000 246924
;->  253125 266200 270000 273375 296352 320000 324000 333396 364500 397953
;->  405000 432000 444528 453789 455877 493848 497664 500000 518616 533871
;->  540000 555579 583443 605052 607500 629856 632736 648000 663552 665500
;->  666792 675000 691488 740772 750141 790272 800000 810448 820125 831875
;->  877952 949104 972000 987696)
;-> 1969.141

Calcoliamo quanti sono i numeri di Achille fino ad 100 milioni:

(time (println (length (filter achille-strong? (sequence 1 1e8)))))
;-> 656
;-> 550253.141


----------------
Numeri di Perrin
----------------

La sequenza P(n) dei numeri di Perrin (o sequenza Ondrej Such) è definita dalla seguente relazione ricorsiva:

 P(0) = 3
 P(1) = 0
 P(2) = 2
 P(n) = P(n-2) + P(n-3) per n > 2

Sequenza OEIS: A001608
  3, 0, 2, 3, 2, 5, 5, 7, 10, 12, 17, 22, 29, 39, 51, 68, 90, 119, 158,
  209, 277, 367, 486, 644, 853, 1130, 1497, 1983, 2627, 3480, 4610, 6107,
  8090, 10717, 14197, 18807, 24914, 33004, 43721, 57918, 76725, 101639,
  134643, 178364, 236282, 313007, ...

Metodo 1: ricorsione
--------------------

(define (perrin1 num)
  (cond ((= num 0) 3)
        ((= num 1) 0)
        ((= num 2) 2)
        (true
          (+ (perrin1 (- num 2)) (perrin1 (- num 3))))))

(perrin1 9)
;-> 12

(map perrin1 (sequence 1 20))
;-> (0 2 3 2 5 5 7 10 12 17 22 29 39 51 68 90 119 158 209 277)

Complessità temporale esponenziale: O(2^n)

Metodo 2: iterativo
-------------------

(define (perrin2 num)
  (let ((a 3) (b 0) (c 2) (out 0))
    (cond ((= num 0) a)
          ((= num 1) b)
          ((= num 2) c)
          (true
            (while (> num 2)
              (setq out (+ a b))
              (setq a b)
              (setq b c)
              (setq c out)
              (-- num)
            )
            out))))

(perrin2 9)
;-> 12

(map perrin2 (sequence 1 20))
;-> (0 2 3 2 5 5 7 10 12 17 22 29 39 51 68 90 119 158 209 277)

Complessità temporale lineare: O(n)


-------------
a*x + b*y = n
-------------

Dati a, b e n. Trovare i valori interi di x e y che soddisfano la seguente equazione:

  a*x + b*y = n

Per risolvere questo problema possiamo iterare x (o y) per tutti i possibili valori da 0 a n.
Poi calcoliamo: y = (n-a*x)/b (o x = (n-b*y)/a).
Se i valori correnti di x y soddisfano l'equazione, allora x e y sono una soluzione.

Per le equazioni diofantine lineari, esistono soluzioni intere se e solo se il MCD dei coefficienti delle due variabili divide perfettamente il termine costante.
In altre parole, una soluzione esiste se e solo se: MCD(a b) % n = 0.

(define (solve a b n)
  (local (x y out)
    (setq out '())
    ; controllo esistenza soluzione
    (if (zero? (% n (gcd a b)))
      (begin
        (setq x 0)
        (while (<= (* x a) n)
          (if (zero? (% (- n (* x a)) b))
            (push (list x (/ (- n (* x a)) b)) out -1)
          )
          (++ x)
        )
      )
    )
    out))

Facciamo alcune prove:

(solve 2 3 7)
;-> (2 1)

(solve 12 13 777)
;-> ((3 57) (16 45) (29 33) (42 21) (55 9))

(solve 12 4 33)
;-> ()


---------------------------
Sorry... i'm floating point
---------------------------

Poniamo f = 0
(setq f 0.0)

Poi aggiungiamo 10 volte 0.1 a f
(for (i 1 10)
  (setq f (add f 0.1))
)
Adesso f = 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1 + 0.1

Quindi f dovrebbe essere uguale a 1... e invece no!
(= f 1.0)
;-> nil

Infatti f vale:
f
;-> 0.9999999999999999


-------------------------------
Numeri sequenziali come stringa
-------------------------------

Scriviamo una funzione che genera numeri-stringa da "start" a "end" di lunghezza predefinita "pad".
Se un numero è più corto di "pad", allora vengono aggiunti all'inizio del numero gli zeri (0) necessari per avere lunghezza "pad".

Esempio:
start = 2
end = 12
pad = 3
Output: ("002" "003" "004" "005" "006" "007" "008" "009" "010" "011" "012")

(define (seq-str start end pad)
  (local (out fmt)
    (setq out '())
    (if (nil? pad) (setq pad (length (max start end))))
    (setq fmt (string "%0" pad "d"))
    (for (i start end)
      (push (format fmt i) out -1)
    )
    out))

Facciamo alcune prove:

(seq-str 7 21)
;-> ("07" "08" "09" "10" "11" "12" "13" "14" "15" "16" "17" "18" "19"
;->  "20" "21")

(seq-str 7 21 4)
;-> ("0007" "0008" "0009" "0010" "0011" "0012" "0013" "0014" "0015" "0016"
;->  "0017" "0018" "0019" "0020" "0021")

Con "start" maggiore di "end":

(seq-str 21 4 2)
;-> ("21" "20" "19" "18" "17" "16" "15" "14" "13" "12" "11" "10" "09"
;->  "08" "07" "06" "05" "04")

(seq-str 21 4 3)
;-> ("021" "020" "019" "018" "017" "016" "015" "014" "013" "012" "011"
;->  "010" "009" "008" "007" "006" "005" "004")


------------------------------
6174 - La costante di Kaprekar
------------------------------

Dato un qualsiasi numero a quattro cifre, tranne quelli con tutte le cifre uguali (0000, 1111, ...), applichiamo il seguente algoritmo (Kaprekar's routine):

1) Ordinare le quattro cifre in ordine crescente e memorizzare il risultato in un numero "asc".
2) Ordinare le quattro cifre in ordine decrescente e memorizzare il risultato in un numero "desc".
3) Sottrarre il numero più grande dal numero più piccolo, cioè abs(asc – desc).
4) Ripetere i tre passaggi sopra (1,2 e 3) fino a quando il risultato della sottrazione non diventa uguale al numero precedente.

La sequenza dei numeri generati termina sempre con 6174, che viene chiamato "costante di Kaprekar".
Inoltre raggiunge sempre il suo punto fisso, 6174, in un massimo di 7 iterazioni.
Una volta raggiunto 6174, il processo continuerà a produrre 7641 – 1467 = 6174.

Ad esempio, partiamo dal numero 1495:

  9541 – 1459 = 8082
  8820 – 0288 = 8532
  8532 – 2358 = 6174
  7641 – 1467 = 6174

Gli unici numeri a quattro cifre per i quali la routine di Kaprekar non raggiunge 6174 sono i numeri repdigit come 1111 (cioè numeri con cifre tutte uguali), che danno il risultato 0000 dopo una singola iterazione.
Tutti gli altri numeri a quattro cifre alla fine raggiungono 6174 se si utilizzano zeri iniziali per mantenere il numero di cifre a 4.
Per i numeri con tre numeri identici e un quarto numero che è un numero più alto o più basso (come 2111), è essenziale trattare i numeri a 3 cifre con uno zero iniziale.
Ad esempio:

  2111 – 1112 = 0999, 9990 – 999 = 8991, 9981 – 1899 = 8082,
  8820 – 288 = 8532, 8532 – 2358 = 6174.

(define (int-list num pad)
"Convert an integer to a list of digits (pad left with 0)"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))
    )
    ; pad left with 0
    (while (< (length out) pad) (push 0 out))
    out))

(int-list 24 4)
;-> (0 0 2 4)
(int-list 24 3)
;-> (0 2 4)

(define (list-int lst)
"Convert a list of digits to integer"
  (let (num 0)
    (dolist (el lst) (setq num (+ el (* num 10))))
    num))

(list-int '(0 0 2 4))
;-> 24
(list-int '(0 2 4))
;-> 24

Funzione che trasforma un numero con le operazioni 1, 2 e 3:

(define (trasform num len)
  (local (asc desc)
    (setq asc (list-int (sort (int-list num len))))
    (setq desc (list-int (sort (int-list num len) >)))
    (abs (- asc desc))))

(trasform 6174 4)
;-> 6174

Funzione che crea la sequenza di kaprekar per un dato numero:

(define (kaprekar len start)
  (local (k stop curr next)
    (setq stop nil)
    (setq curr start)
    (setq k (list curr))
    (until stop
      (setq next (trasform curr len))
      ; uncomment next line to see cycles
      ;(print curr { } next) (read-line)
      (if (or (= curr next) (zero? next))
          (setq stop true)
          ;else
          (push next k -1)
      )
      (setq curr next)
    )
    k))

Facciamo alcune prove:

(kaprekar 4 1234)
;-> (1234 3087 8352 6174)

(kaprekar 4 34)
;-> (34 4266 4176 6174)

(map (curry kaprekar 4) (sequence 1000 1010))
;-> ((1000 999 8991 8082 8532 6174)
;->  (1001 1089 9621 8352 6174)
;->  (1002 2088 8532 6174)
;->  (1003 3087 8352 6174)
;->  (1004 4086 8172 7443 3996 6264 4176 6174)
;->  (1005 5085 7992 7173 6354 3087 8352 6174)
;->  (1006 6084 8172 7443 3996 6264 4176 6174)
;->  (1007 7083 8352 6174)
;->  (1008 8082 8532 6174)
;->  (1009 9081 9621 8352 6174)
;->  (1010 1089 9621 8352 6174))

Vediamo quali numeri vengono generati dalla routine di kaprekar per tutti i numeri di 4 cifre (da 1000 a 9999):

(sort (setq all (unique (flat (map (curry kaprekar 4) (sequence 1000 9999))))))
;-> (999 1000 1001 1002 1003 1004 1005 1006 1007 1008 1009...
;->  ... 9992 9993 9994 9995 9996 9997 9998 9999)

(length (setq all (unique (flat (map (curry kaprekar 4) (sequence 1000 9999))))))
;-> 9001

Il parametro "len" ci permette di verificare se la routine di kaprekar vale anche per numeri con un numero di cifre diverso da 4. Per esempio con numeri da 3 cifre otteniamo un altra costante: 495.

(kaprekar 3 124)
;-> (124 297 693 594 495)

(kaprekar 3 477)
;-> (477 297 693 594 495)

(kaprekar 3 21)
;-> (21 198 792 693 594 495)

Con numeri da 5 cifre otteniamo dei cicli di numeri e non una costante:
(modificare la funzione "kaprekar": uncomment next line to see cycles)

(kaprekar 5 21345)
;-> 21345 41976
;-> 41976 82962
;-> 82962 75933
;-> 75933 63954
;-> 63954 61974
;-> 61974 82962
;-> 82962 75933
;-> 75933 63954
;-> 63954 61974
;-> ...

(kaprekar 5 44391)
;-> 44391 80982
;-> 80982 95931
;-> 95931 85932
;-> 85932 74943
;-> 74943 62964
;-> 62964 71973
;-> 71973 83952
;-> 83952 74943
;-> 74943 62964
;-> 62964 71973
;-> 71973 83952
;-> 83952 74943
;-> ...

Anche con numeri da25 cifre otteniamo dei cicli di numeri:

(kaprekar 2 26)
;-> 26 36
;-> 36 27
;-> 27 45
;-> 45 9
;-> 9 81
;-> 81 63
;-> 63 27
;-> 27 45
;-> 45 9
;-> 9 81
;-> ...

(kaprekar 2 71)
;-> 71 54
;-> 54 9
;-> 9 81
;-> 81 63
;-> 63 27
;-> 27 45
;-> 45 9
;-> 9 81
;-> ...


----------------------------------------------------------
Minimo Comune Multiplo (MCM) - Least Common Multiple (LCM)
----------------------------------------------------------

Il minimo comune multiplo di due numeri interi a e b, mcm(a,b), è il più piccolo numero intero positivo multiplo sia di a sia di b.
Nel caso particolare in cui uno tra a o b è uguale a zero, allora si definisce mcm(a,b) uguale a zero.
È possibile calcolare il minimo comune multiplo di più di due numeri, sostituendo man mano due dei numeri con il loro comune multiplo e proseguendo fino a che non rimane un solo numero che è il risultato.
Si può dimostrare che il risultato è lo stesso qualunque sia l'ordine in cui vengono fatte le sostituzioni.

Vediamo una implementazione proposta da Sammo:

;; Returns the least common multiple of one or more integers.
;; by Sammo

(define (lcm2 a b)
  (if (or (= a 0) (= b 0))
      0
      (/ (abs (* a b)) (gcd a b))))

(define (lcm )
  (cond ((empty? (args)) 1)
        ((empty? (rest (args))) (int (abs (args 0))))
        (true
         ;; reduce
         (apply lcm2 (args) 2))))

(define-macro (=? x => y)
  (if (!= (eval x) (eval y))
      (throw-error (format "failed: %s =/> %s" (string x) (string y))))
  true)

(=? (lcm 10) => 10)
;-> true
(=? (lcm 25 30) => 150)
;-> true
(=? (lcm -24 18 10) => 360)
;-> true
(=? (lcm 14 35) => 70)
;-> true
(=? (lcm 0 5) => 0)
;-> true
(=? (lcm 1 2 3 4 5 6) => 60)
;-> true

Il minimo comune multiplo di due numeri a e b diversi da zero può essere calcolato usando il massimo comun divisore (MCD) di a e b con la formula seguente:

                 a*b
  MCM(a,b) = ------------
               MCD(a,b)

Usiamo questa formula per scrivere una nuova funzione che calcola il minimo comune multiplo di due o più numeri.
La funzione integrata "gcd" calcola il massimo comun divisore (greatest common divisor) di due o più numeri.

Funzione che calcola il MCM di due numeri:

(define (lcm_ a b) (/ (* a b) (gcd a b)))

Funzione che calcola il MCM di N numeri:

(define-macro (lcm-macro)
"Calculates the lcm of two or more number"
  (apply lcm_ (args) 2))

Facciamo alcune prove:

(setq a '(2 3 4 5 6 7 8 9 10 11 12 13 78 34 56))

Vediamo quale funzione è più veloce:

(time (lcm 2 3 4 5 6 7 8 9 10 11 12 13 78 34 56) 100000)
;-> 655.583
(time (lcm-macro 2 3 4 5 6 7 8 9 10 11 12 13 78 34 56) 100000)
;-> 371.634

(time (apply lcm (sequence 10 500)) 10000)
;-> 2393.297
(time (apply lcm-macro (sequence 10 500)) 10000)
;-> 1473.182


-------------
Ruote dentate
-------------

Abbiamo N ruote dentate (ingranaggi) disposte in linea e collegate tra loro.
Le varie ruote dentate hanno un numero di denti pari a (d1 d2 ... dN).
Viene tracciata una linea retta che attravera tutti i centri delle ruote.
Quanti giri compiono tutte le ruote prima di essere di nuovo riallineate?

Vediamo pima il caso di due ruote dentate con a e b denti ciascuna:

quando gli ingranaggi iniziano a ruotare, il numero di rotazioni che la prima ruota deve completare per riallineare il segmento di linea può essere calcolato utilizzando il minimo comune multiplo.
La prima ruota deve compiere MCM(a,b)/a rotazioni per il riallineamento.
A quel punto, la seconda ruota avrà effettuato MCM(a,b)/b rotazioni.

Nel caso di N ruote possiamo applicare lo stesso ragionamento.

Funzione che calcola il MCM di N numeri:

(define (lcm2 a b) (/ (* a b) (gcd a b)))
(define-macro (lcm)
"Calculates the lcm of two or more number"
  (apply lcm2 (args) 2))

(define (allinea lst)
  (let (mcm (apply lcm lst))
    (map (curry / mcm) lst)))

Facciamo alcune prove:

(allinea '(10 2))
;-> (1 5)
Per riallinearsi la prima ruota (10 denti) fa un giro e la seconda ruota (2 denti) fa 5 giri.

(allinea '(3 3 4))
;-> (4 4 3)

(allinea (sequence 1 10))
;-> (2520 1260 840 630 504 420 360 315 280 252)


---------------
curry e hayashi
---------------

La seguente macro è stata scritta da johu (https://johu02.wordpress.com/):

(define-macro (hayashi)
;  (letex ((_func (flat (list (args 0) '_x (1 (args))))))
  (letex (_func (push '_x (args) 1))
    (fn (_x) _func )))

Vediamo cosa fa:

(hayashi + 10)
;-> (lambda (_x) (+ _x 10))

(hayashi func 1 2)
;-> (lambda (_x) (func _x 1 2))

La macro "hayashi" crea una funzione che ha le seguenti proprietà:
a) ha un solo parametro in ingresso: _x
b) il corpo applica la funzione passata ad "hayashi" con i parametri _x e gli altri argomenti passati ad "hayashi"

Ricordiamo che anche la funzione "curry" crea delle funzioni:

(curry + 10)
;-> (lambda ($x) (+ 10 $x))

hayashi produce --> (lambda (_x) (+ _x 10))
curry produce   --> (lambda ($x) (+ 10 $x))

Le funzioni sono simili, infatti i prametri sono scambiati (+ _x 10) e (+ 10 $x).

Vediamo la differenza in pratica:

(setq lst '(4 8 10))

"curry" divide il numero 2 per ogni elemento della lista:

(map (curry div 2) lst)
;-> (0.5 0.25 0.2)

"hayashi" divide ogni elemento della lista per 2:

(map (hayashi div 2) lst)
;-> (2 4 5)

Quindi "hayashi" può essere usato in modo simile a "curry" in base al modo con cui devono essere trattati i parametri.

Comunque "hayashi" permette di "passare" più parametri alla funzione da applicare.

Per esempio, supponiamo di avere la seguente funzione:

  f(k x y) = k*(x + y)

(define (f k x y) (mul k (add x y)))

(f 0 1 1)
;-> 0
(f 1 1 1)
;-> 2
(f 5 1 1)
;-> 10

Se vogliamo conoscere i valori assunti da f(k x y) per x = 1, y = 1 e k che varia da 0 a 10, possiamo scrivere:

(map (hayashi f 1 1) (sequence 0 10))
;-> (0 2 4 6 8 10 12 14 16 18 20)

Possiamo scrivere una funzione che si comporta esattamente come "curry", ma permette di "passare" più parametri alla funzione da applicare.
Basta modificare la posizione del simbolo _x e inserirlo in fondo alla lista dei parametri:

(define-macro (curry-ext)
   (letex (_func (push '_x (args) -1))
    (fn (_x) _func )))

Nel caso di un solo parametro (10) "curry" e "curry-ext" generano la stessa funzione:

(curry + 10)
;-> (lambda ($x) (+ 10 $x))
(curry-ext + 10)
;-> (lambda (_x) (+ 10 _x))

Se vogliamo passare più parametri dobbiamo usare "curry-ext":

(curry + 10 20)
;-> (lambda ($x) (+ 10 $x))
(curry-ext + 10 20)
;-> (lambda (_x) (+ 10 20 _x))

(map (curry-ext + 10 20) (sequence 1 10))
;-> (31 32 33 34 35 36 37 38 39 40)


-----------------------------------
Ricerca nelle liste di associazione
-----------------------------------

Una lista di associazione è una lista con la seguente struttura:

((chiave1 valore11 valore12 valore13 ... valore1N)
 (chiave2 valore21 valore22 valore23 ... valore2N)
 ...
 (chiaveM valoreM1 valoreM2 valoreM3 ... valoreMN))

Per esempio:

(setq cibo
'(
  ("frutta" "banana" "pera" "mela" "uva")
  ("verdura" "lattuga" "spinaci" "bietole")
  ("grassi" "salame" "salcicce" "cioccolata" "mela")
  ("pasta" "ravioli")
))

Uso di "assoc" con una chiave (restituisce chiave e tutti i valori):

(assoc "frutta" cibo)
;-> ("frutta" "banana" "pera" "mela" "uva")

Uso di "assoc" con un valore (restituisce nil):

(assoc "banana" food)
;-> nil

Uso di "lookup" con una chiave (restituisce l'ultimo valore associato alla chiave):

(lookup "frutta" cibo)
;-> "uva"

Uso di "lookup" con una chiave e un indice (restituisce il valore associato alla chioave con quell'indice):

(lookup "frutta" cibo 0)
;-> "frutta"
(lookup "frutta" cibo 1)
;-> "banana"
(lookup "frutta" cibo 3)
;-> "mela"

Quando l'indice non esiste, allora restituisce ultimo valore associato alla chiave:

(lookup "frutta" cibo 10)
;-> "uva"

Uso di "lookup" con un valore (restituisce nil):

(lookup "banana" cibo)
;-> nil

Scriviamo una funzione "look-all" che cerca anche i valori delle liste di associazione:

(define (look-all key aList)
  (let (vec (ref key aList))
    (and vec (aList (vec 0)))))

Uso di "look-all" con una chiave:

(look-all "frutta" cibo)
;-> ("frutta" "banana" "pera" "mela" "uva")

Uso di "look-all" con un valore:

(look-all "banana" cibo)
;-> ("frutta" "banana" "pera" "mela" "uva")

Se esiste un valore associato a più chiavi (es. "mela" è associato a "frutta" e a "grassi"), allora viene restituita solo la prima associazione:

(look-all "mela" cibo)
;-> ("frutta" "banana" "pera" "mela" "uva")

Se il valore (o la chiave) non esiste, allora restituisce nil:

(look-all "cocomero" cibo)
;-> nil


-------------------------
Orientamento di tre punti
-------------------------

Dati 3 punti 2D determinare l'orientamento (orario, antiorario o collineari).

                p3
               /
              /
             /
            p2
           .
        .
     .
    p1

La pendenza del segmento (p1,p2) vale: a = (y2−y1) / (x2−x1)

La pendenza del segmento (p2,p3) vale: b = (y3−y2) / (x3−x2)

Se risulta:

a > b --> orario - clockwise (right turn): a > b
a = b --> collineari - collinear (left turn): a = b
a < b --> antiorario - counterclockwise (left turn): a < b

Quindi l'orientamento dipende dall'espressione:

                                     > 0   -->   senso orario
  (y2−y1) (x3−x2) − (y3−y2) (x2−x1)  = 0   -->   punti collineari
                                     < 0   -->   senso antiorario

(define (orientamento p1 p2 p3)
  ;(println (mul (sub (p2 1) (p1 1)) (sub (p3 0) (p2 0))))
  ;(println (mul (sub (p3 1) (p2 1)) (sub (p2 0) (p1 0))))
  (sub (mul (sub (p2 1) (p1 1)) (sub (p3 0) (p2 0)))
       (mul (sub (p3 1) (p2 1)) (sub (p2 0) (p1 0)))))

(orientamento '(1 2) '(3 3) '(-3 4))
;-> -8 ; antiorario

(orientamento '(1 2) '(3 3) '(5 1))
;-> 6 ; orario

(orientamento '(1 1) '(3 3) '(2 2))
;-> 0 ; collineari


----------------------------------------------------
Algoritmo della prossima permutazione lessicografica
----------------------------------------------------

L'approccio migliore per generare tutte le permutazioni è iniziare dalla permutazione più bassa e calcolare ripetutamente la permutazione successiva in atto.
Vediamo un algoritmo semplice e veloce per calcolare la prossima permutazione lessicografica (next lexicographical permutation) partendo da una permutazione iniziale.
L'idea base di questo algoritmo è che quando vogliamo calcolare la permutazione successiva, dobbiamo "aumentare" la sequenza il meno possibile.
Proprio come quando contiamo usando i numeri, proviamo a modificare gli elementi più a destra e a lasciare invariato il lato sinistro.

Utilizzando la sequente lista iniziale (0 1 2 5 3 3 0), i passi dell'algoritmo sono i seguenti:

1) Sequenza iniziale
  0 1 2 5 3 3 0

2) Trovare il più lungo suffisso non crescente: 5 3 3 0
        _ _ _ _
  0 1 2 5 3 3 0

3) Identificare il pivot: 2
      p _ _ _ _
  0 1 2 5 3 3 0

4) Trovare il successore del pivot che si trova più a destra: 3
      p _ _ s _
  0 1 2 5 3 3 0

5) Scambiare pivot e successore: p <-> s
      s _ _ p _
  0 1 3 5 3 2 0

6) Invertire il suffisso: 5 3 2 0  -->  0 2 3 5
        _ _ _ _
  0 1 3 0 2 3 5

8) Finito, abbiamo trovato la prossima permutazione:
  0 1 3 0 2 3 5

Per maggiori spiegazioni vedere la seguente pagina web:

https://www.nayuki.io/page/next-lexicographical-permutation-algorithm

Scriviamo una funzione che implementa l'algoritmo:

(define (next-perm lst)
  (local (i j len)
    (setq len (length lst))
    ; Trova il più lungo suffisso non crescente
    (setq i (- len 1))
    (while (and (> i 0) (>= (lst (- i 1)) (lst i)))
      (-- i)
    )
    ; adesso i è l'indice iniziale del suffisso
    (cond ((<= i 0) nil) ; ultima permutazione raggiunta?
          (true
            ; il pivot è (lst (- i 1))
            ; Trova il successore del pivot che si trova più a destra
            (setq j (- len 1))
            (while (<= (lst j) (lst (- i 1)))
              (-- j)
            )
            ; Ora il valore array[j] diventerà il nuovo pivot
            ; (println j " >= " i)
            ; scambia il pivot con il successore
            (swap (lst (- i 1)) (lst j))
            ; Inverte il suffisso
            (setq j (- len 1))
            (while (< i j)
              (swap (lst i) (lst j))
              (++ i)
              (-- j)
            )
            lst))))

Facciamo alcune prove:

(next-perm '(0 1 2 3))
;-> (0 1 3 2)

(next-perm '(0 1 1 1 4))
;-> (0 1 1 4 1)

(next-perm '(0 1 2 5 3 3 0))
;-> (0 1 3 0 2 3 5)

(setq v '(0 1 2 3))
(while (setq v (next-perm v)) (println v))
;-> (0 1 3 2)
;-> (0 2 1 3)
;-> (0 2 3 1)
;-> (0 3 1 2)
;-> (0 3 2 1)
;-> (1 0 2 3)
;-> (1 0 3 2)
;-> (1 2 0 3)
;-> (1 2 3 0)
;-> (1 3 0 2)
;-> (1 3 2 0)
;-> (2 0 1 3)
;-> (2 0 3 1)
;-> (2 1 0 3)
;-> (2 1 3 0)
;-> (2 3 0 1)
;-> (2 3 1 0)
;-> (3 0 1 2)
;-> (3 0 2 1)
;-> (3 1 0 2)
;-> (3 1 2 0)
;-> (3 2 0 1)
;-> (3 2 1 0)
;-> (3 2 1 0)


------------------------------------
Formula per calcolare i numeri primi
------------------------------------

La seguente formula è derivata in Willans, "On Formulas for the nth Prime Number" (1964) (Mathematical Gazette vol. 48, n. 366, pp. 413-415):

                        |                                   |1/n
                2^n     |                n                  |
  prime(n) = 1 + ∑ floor|(---------------------------------)|
                i=1     |  i               (j-1)! + 1       |
                        |  ∑ floor ((cos(π*----------))^2)  |
                        | j=1                  j            |

Questa formula calcola l'n-esimo numero primo.

Implementiamola subito:

(setq PI 3.1415926535897931)

(define (fact num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

Funzione che calcola la seconda sommatoria della formula (quella interna):

(define (sum2 i j)
  (setq k 0)
  (for (jj 1 i)
    (setq k (add k
            (floor (pow (cos (mul PI (div (+ (fact (- jj 1)) 1) jj))) 2))))
  )
  k)

Funzione che implementa la formula di Willans:

(define (prime n)
  (setq p 1)
  (for (i 1 (pow 2 n))
    (setq p (add p
            (floor (pow (div n (sum2 i j)) (div n)))))
  )
  p)

Facciamo alcune prove:

(prime 1)
;-> 2

(prime 2)
;-> 3

Calcoliamo i primi 5 numeri primi:

(map prime (sequence 1 5))
;-> (2 3 5 7 11)

Comunque i numeri coinvolti nell'equazione rendono impossibile l'utilizzo pratico dell'equazione stessa.
Ad esempio la sommatoria di 2^n termini (che calcola al suo interno un'altra sommatoria) rende il tempo di calcolo lunghissimo anche per piccoli valori di n.
Inoltre i numeri floating point non sono abbastanza precisi per calcolare i risultati dell'equazione.

(prime 8)
;-> 1.#QNAN

Anche con Wolfram Mathematica non si va molto lontano...

Nota: la formula assomiglia ad un algoritmo di ricerca brute-force.


-----------------------------------------
Creazione automatica di simboli/variabili
-----------------------------------------

Supponiamo di avere una lista di coppie con il nome (stringa) e l'età (intero):

(setq lst '(("pietro" 55) ("ada" 50) ("frida" 45)))

Il problema è quello di creare i simboli dai nomi e assegnare il valore dell'età.
Cioè, pietro deve essere un simbolo che vale 55, ada deve essere un simbolo che vale 50 e frida deve essere un simbolo che vale 45.

Funzione che prende una stringa e un valore e crea il simbolo dalla stringa e assegnandogli il valore:

(define (sets str val)
  (set (sym str) (eval val)))

(sets "a" 10)
;-> 10
(println a)

Adesso per risolvere il nostro problema possiamo scrivere:

(map (fn(x) (sets (x 0) (x 1))) lst)
;-> (55 50 45)
(println pietro { } ada { } frida)
;-> 55 50 45

Questo metodo permette di creare simboli/variabili in modo automatico (ad. esempio tutti i simboli da A00 ad A99).

Inoltre possiamo usarlo per scrivere una funzione che crea un insieme di simboli:

(define (vars)
  (let (lst (explode (args) 2))
    (dolist (el lst)
      (set (sym (string (el 0))) (eval (el 1))))))

Che viene chiamata nel modo seguente:

(vars "vv" 3.14 "aa" 10 "cc" 11)
;-> 11
(println vv { } aa { } cc)
;-> 3.14 10 11


--------------------------------------------------------
Uso particolare degli operatori AND e OR (Short-circuit)
--------------------------------------------------------

Operatore AND
-------------
Scriviamo una funzione che trova il primo numero negativo e calcola il suo quadrato:

(define (quad-neg lst)
  (let (idx (find 0 lst >))
    (and idx (* (lst idx) (lst idx)))))

(setq lst '(3 -5 4 8 -2))
(quad-neg lst)
;-> 25

Ma se la lista non ha numeri negativi, allora "find" ritorna "nil".

In questa funzione l'operatore "AND":
- restituisce "idx" se "idx" vale nil (non esistono numeri negativi nella lista)
- restituisce il quadrato del numero negativo se "idx" è diverso da nil.

(setq lst '(3 5 4 8 2))
(quad-neg lst)
;-> nil

Operatore OR
------------
Scriviamo una funzione che ritorna la lista (o stringa) passta senza "num" elementi:

(define (ultimi list-or-string num)
  (chop list-or-string (or num 1)))

In questa funzione l'operatore OR:
- restituisce "num" se "num" è diverso da nil
- restituisce 1 se "num" è uguale a nil (quando non passiamo il parametro "num")

(setq lst '(3 5 4 8 2))

(ultimi lst 2)
;-> (3 5 4)

(ultimi lst)
(3 5 4 8)

Questi metodi funzionano perchè newLISP valuta le espressioni booleane con il metodo "short-circuit".
La valutazione "short-circuit" (o valutazione McCarthy) consiste nel valutare (eseguire) il secondo argomento dell'espressione solo se il primo argomento non è sufficiente a determinare il valore del espressione.
In particolare:
- quando il primo argomento della funzione AND restituisce nil, il valore complessivo deve essere nil.
- quando il primo argomento della funzione OR restituisce true, il valore complessivo deve essere true.

Esempi:

(and (setq a nil) (setq b 10))
;-> nil
(println a { } b)
;-> nil nil

(and (setq a 5) (setq b nil))
;-> nil
(println a { } b)
;-> 5 nil

(and (setq a 5) (setq b 10))
;-> 10
(println a { } b)
;-> 5 10

(set 'a nil 'b nil)
(or (setq a nil) (setq b 10))
;-> 10
(println a { } b)
;-> nil 10

(or (setq a 5) (setq b nil))
;-> 5
(println a { } b)
;-> 5 10

(or (setq a 5) (setq b 10))
;-> 5
(println a { } b)
;-> 5 10


-----------------------------------------------------
Condividere un numero segreto (Shamir Secret Sharing)
-----------------------------------------------------

Nel suo articolo del 1979 "How to Sahre a Secret", Adi Shamir (la S in RSA) ha proposto uno schema crittografico che consente a n persone di condividere un numero segreto S in modo tale che ci vogliono almeno k di loro che mettono in comune le proprie risorse (chiavi) per ricostruire S.
Questo schema di soglia (k n) utilizza i polinomi e l'aritmetica modulare per fornire a ciascuno degli n partecipanti 1/k delle informazioni necessarie.
Articolo originale di Adi Shamir: https://www.cs.tau.ac.il/~bchor/Shamir.html

Per spiegare il funzionamento di questo metodo facciamo un esempio.
Il numero segreto vale: S = 12345
Il numero di persone che condividono le informazioni (chiavi) vale: n = 10
Il numero di persone necessario e sufficiente per rivelare il segreto è: k = 4

1) Scegliere un polinomio di grado 3 (cioè k-1) il cui termine noto vale S.

  p(x) = a3*x^3 + a2*x^2 + a1*x + a0

Poichè i coefficienti delle potenze di x sono arbitrari poniamo:

  a0 = S = 12345
  a1 = 4
  a2 = 19
  a3 = 103

  p(x) = 103*x^3 + 19*x^2 + 4*x + 12345

Questi coefficienti devono essere mantenuti segreti alle persone.

(define (make-poly coeffs)
"Generates a function who evaluate a polynomial with those coefficients"
  (local (func body)
    (reverse coeffs)
    (setq func '(lambda (x) x)) ; funzione lambda base
    (setq body '())             ; corpo della funzione
    (push 'add body -1)
    (push (first coeffs) body -1)            ; termine noto
    (push (list 'mul 'x (coeffs 1)) body -1) ; termine lineare
    (if (> (length coeffs) 2)
      (for (i 2 (- (length coeffs) 1))       ; termini di ordine superiore
        (push (list 'mul (list 'pow 'x i) (coeffs i)) body -1)
      )
    )
    (setq (last func) body) ; modifica corpo della funzione
    func))

Generiamo il polinomio:

(setq poly (make-poly '(103 19 4 12345)))
;-> (lambda (x) (add 12345 (mul x 4) (mul (pow x 2) 19) (mul (pow x 3) 103)))

2) Generiamo n=10 valori del polinomio (es. per valori di x che vanno da 1 a 10):

Generazione di 10 valori (chiavi):

(for (i 1 10) (println (list i (poly i))))
;-> (1 12471)
;-> (2 13253)
;-> (3 15309)
;-> (4 19257)
;-> (5 25715)
;-> (6 35301)
;-> (7 48633)
;-> (8 66329)
;-> (9 89007)
;-> (10 117285)

Attenzione, se usiamo x=0, allora viene rivelato il numero segreto:

(poly 0)
;-> 12345

3) Utilizziamo il polinomio interpolatore di Lagrange per estrarre il segreto.
Il polinomio di interpolazione di Lagrange è il polinomio unico di grado più basso che interpola un dato insieme di dati.
Dato un insieme di dati di coppie di coordinate (x(i) y(i)) con 0 <= i <= n, il polinomio di Lagrange L(x) ha grado <= n e L(x(i)) = y(i) per ogni i.

Questa proprietà ci permette di estrarre il numero segreto solo se abbiamo 4 o più chiavi (cioè un numero di chiavi pari al grado del polinomio più uno).

Funzione che calcola il valore del polinomio interpolatore nel punto x:

(define (lagrange lst-pt x)
  (local (sum u l)
    (setq sum 0.0)
    (for (i 0 (- (length lst-pt) 1))
      (setq u 1.0 l 1.0)
      (for (j 0 (- (length lst-pt) 1))
        (if (!= j i)
          (setq u (mul u (sub x (lst-pt j 0)))
                l (mul l (sub (lst-pt i 0) (lst-pt j 0))))
        )
      )
      (setq sum (add sum (mul (div u l) (lst-pt i 1))))
    )
    sum))

Con 4 o più chiavi (il poligono è di grado 3) possiamo ricavare il numero segreto:

(setq pt '((1 12471) (4 19257) (5 25715) (6 35301)))

(lagrange pt 0)
;-> 12345

(setq pt '((1 12471) (7 48633) (8 66329) (9 89007) (10 117285)))
(lagrange pt 0)
;-> 12345

Con un numero di chiavi inferiore a 4 non possiamo ricavare il numero segreto:

(setq pt '((1 12471) (4 19257) (5 25715)))

(lagrange pt 0)
;-> 14405

In altre parole, 4 coefficienti (chiavi) sono necessari e sufficienti per definire esattamente lo stesso polinomio iniziale e quindi calcolare il suo valore per x=0 (che produce il numero segreto).

Possiamo anche determinare i coefficienti del polinomio interpolatore di Lagrange:

(define (lagrange-coeff pts)
  (local (coeff newcoeff idx)
    (setq coeff (array (length pts) '(0)))
    (for (m 0 (- (length pts) 1))
      (setq newcoeff (array (length pts) '(0)))
      (if (> m 0)
        (begin
        (setf (newcoeff 0) (sub (div (pts 0 0) (sub (pts m 0) (pts 0 0)))))
        (setf (newcoeff 1) (div 1 (sub (pts m 0) (pts 0 0)))))
        (begin
        (setf (newcoeff 0) (sub (div (pts 1 0) (sub (pts m 0) (pts 1 0)))))
        (setf (newcoeff 1) (div 1 (sub (pts m 0) (pts 1 0)))))
      )
      (setq idx 1)
      (if (= m 0) (setq idx 2))
      (for (n idx (- (length pts) 1))
        (if (!= m n)
          (begin
          (for (nc (- (length pts) 1) 1)
            (setf (newcoeff nc) (add (mul (newcoeff nc) (sub (div (pts n 0) (sub (pts m 0) (pts n 0)))))
                                     (div (newcoeff (- nc 1)) (sub (pts m 0) (pts n 0)))))
          )
          (setf (newcoeff 0) (mul (newcoeff 0) (sub (div (pts n 0) (sub (pts m 0) (pts n 0)))))))
        )
      )
      (for (nc 0 (- (length pts) 1))
        (setf (coeff nc) (add (coeff nc) (mul (pts m 1) (newcoeff nc))))
      )
    )
    coeff))

Facciamo una verifica:

(setq pt '((1 12471) (2 13253) (3 15309) (4 19257)))

(lagrange-coeff pt)
;-> (12345 4 19 103)

Abbiamo ritrovato il polinomio originale:

  p(x) = 103*x^3 + 19*x^2 + 4*x + 12345


--------------------------------------------------------------
Inversione dei valori di un matrice binaria (0 -> 1), (1 -> 0)
--------------------------------------------------------------

Problema: invertire i valori di una matrice binaria (nel modo più veloce).

Per invertire il valore di un bit (da 0 a 1 e da 1 a 0) usiamo l'espressione:

  x = 1 - x.

Funzione che inverte un bit (0 -> 1 e 1 -> 0):

(define (flip-bit x) (- 1 x))

(flip-bit 0)
;-> 1
(flip-bit 1)
;-> 0

Funzione che crea una matrice binaria (0 e 1) dati larghezza e altezza:

(define (random-bw width height)
  (explode (rand 2 (* width height)) height))

(setq m (random-bw 4 3))
;-> ((1 1 0) (0 0 0) (0 0 1) (0 0 0))

Funzioni che "flippano" una matrice binaria (lista):

Metodo 1: iterazione con lista
------------------------------

(define (flip-mat-1 matrix)
  (let ( (row (length matrix)) (col (length (matrix 0))) )
    (for (r 0 (- row 1))
      (for (c 0 (- col 1))
        (setf (matrix r c) (flip-bit (matrix r c)))
      )
    )
    matrix))

(flip-mat-1 m)
;-> ((0 0 1) (1 1 1) (1 1 0) (1 1 1))

Metodo 2: iterazione con vettore
--------------------------------

(define (flip-mat-2 matrix)
  (letn ( (row (length matrix)) (col (length (matrix 0)))
          (arr (array row col (flat matrix))) )
    (for (r 0 (- row 1))
      (for (c 0 (- col 1))
        (setf (arr r c) (flip-bit (arr r c)))
      )
    )
    arr))

(flip-mat-2 m)
;-> ((0 0 1) (1 1 1) (1 1 0) (1 1 1))

Metodo 3: primitive newLISP (map)
---------------------------------

(define (flip-mat-3 matrix)
  (let (c (length (matrix 0)))
    (explode (map flip-bit (flat matrix)) c)))

(flip-mat-3 m)
;-> ((0 0 1) (1 1 1) (1 1 0) (1 1 1))

Metodo 4: primitive newLISP (set-ref-all)
-----------------------------------------

(define (flip-mat-4 matrix)
  (set-ref-all '(*) matrix (map flip-bit $it) match))

(flip-mat-4 m)
;-> ((0 0 1) (1 1 1) (1 1 0) (1 1 1))

Vediamo la velocità di queste funzioni:

(silent (setq m1 (random-bw 10 10)))
(silent (setq m2 (random-bw 100 100)))
(silent (setq m3 (random-bw 1000 1000)))

Prima funzione:
(time (flip-mat-1 m1) 10000)
;-> 154.942
(time (flip-mat-1 m2) 100)
;-> 338.329
(time (flip-mat-1 m3) 1)
;-> 6675.432
Le liste con molti elementi sono lente.

Seconda funzione:
(time (flip-mat-2 m1) 10000)
;-> 200.336
(time (flip-mat-2 m2) 100)
;-> 151.512
(time (flip-mat-2 m3) 1)
;-> 175.057
I vettori (array) sono più veloci delle liste.

Terza funzione:
(time (flip-mat-3 m1) 10000)
;-> 84.981
(time (flip-mat-3 m2) 100)
;-> 84.499
(time (flip-mat-3 m3) 1)
;-> 89.979
La funzione "map" è molto veloce.

Quarta funzione:
(time (flip-mat-4 m1) 10000)
;-> 113.309
(time (flip-mat-4 m2) 100)
;-> 95.535
(time (flip-mat-4 m3) 1)
;-> 99.359
La funzione "set-ref-all" è veloce ed elegante.


---------------------
Dobble (Spot It) Game
---------------------

Nel gioco "Dobble" (o "Spot it"), utilizza un mazzo di 55 carte da gioco, ciascuna con 8 simboli diversi su di esse. Ciò che è notevole (matematicamente) è che due carte scelte a caso dal mazzo avranno uno e un solo simbolo in comune. 
Possiamo trovare la soluzione matematica al seguente indirizzo web:
https://math.stackexchange.com/questions/36798/what-is-the-math-behind-the-game-spot-it

In definitiva, se il numero di simboli su ogni carta è N, allora il numero massimo di simboli diversi nel mazzo è C, anche il numero massimo di carte in un mazzo è C, il numero di volte in cui un dato simbolo è ripetuto in tutto il pacchetto è N, e N e C sono correlati come segue:

  C = N^2 - N + 1

Ecco un algoritmo per generare un piano proiettivo per ogni N primo. Funziona per ogni N che è potenza di un primo primo se il calcolo del "(I*K + J) modulo N" viene effettuato nel "campo" corretto.

Pseudocode:

  // N*N first cards
  for I = 0 to N-1
    for J = 0 to N-1
        for K = 0 to N-1
          print ((I*K + J) modulus N)*N + K
        end for
        print N*N + I
        new line
    end for
  end for
  
  // N following cards
  for I = 0 to N-1
    for J = 0 to N-1
        print J*N + I
    end for
    print N*N + N
    new line
  end for
  
  // Last card
  for I = 0 to N-1
    print N*N + I
  end for
  new line

Scriviamo una funzione per generare un mazzo di carte per giocare a Dobble.
Funziona se n è un numero primo (2, 3, 5, 7, 11, 13, 17, ...).

Numero di simboli in una data carta = n + 1

Numero totale di carte = n^2 + n + 1

Numero totale di simboli = n^2 + n + 1

(define (spot-it n)
  (local (r res out)
    (setq out '())
    (setq r 1)
    (setq res '())
    (for (i 1 (+ n 1))
      (push i res -1)
    )
    (push res out -1)
    (setq res '())
    (for (j 1 n)
      (setq res '())
      (++ r)
      (push 1 res -1)
      (for (k 1 n)
        (push (+ n (* n (- j 1)) k 1) res -1)
      )
      (push res out -1)
    )
    (for (i 1 n)
      (for (j 1 n)
        (setq res '())
        (++ r)
        (push (+ i 1) res -1)
        (for (k 1 n)
          (push (+ n 2 (* n (- k 1)) (% (+ (* (- i 1) (- k 1)) j (- 1)) n )) res -1)
        )
        (push res out -1)
      )
    )
    out))

(setq carte (spot-it 3))
;-> ((1 2 3 4) 
;->  (1 5 6 7) 
;->  (1 8 9 10) 
;->  (1 11 12 13) 
;->  (2 5 8 11) 
;->  (2 6 9 12) 
;->  (2 7 10 13) 
;->  (3 5 9 13)
;->  (3 6 10 11)
;->  (3 7 8 12)
;->  (4 5 10 12)
;->  (4 6 8 13)
;->  (4 7 9 11))

Scriviamo una funzione che verifica che ogni coppia di carte ha un solo numero in comune:

(define (check-it lst)
  (local (len out)
    (setq out true)
    (setq len (length lst))
    (for (i 0 (- len 2))
      (for (j (+ i 1) (- len 1))
        ; verifica se due liste hanno solo un valore in comune
        (if (!= (length (intersect (lst i) (lst j))) 1)
          (begin
            (println "Error: " (lst i) { } (lst j) { } (intersect (lst i) (lst j)))
            (setq out nil))
        )
      )
    )
    out))

(check-it carte)
;-> true

Facciamo un'altro esempio:

(check-it (spot-it 7))
;-> true

Se togliamo alcune carte al mazzo, anche per le carte rimanenti ogni coppia di carte ha un solo numero in comune:

(setq cartine '(
  (1 5 6 7)
  (1 8 9 10)
  (1 11 12 13)
  (2 6 9 12)
  (2 7 10 13)
  (3 5 9 13)
  (3 7 8 12)
  (4 5 10 12)
  (4 7 9 11)))

(check-it cartine)
;-> true

Vediamo il caso in cui n non è un numero primo:

(setq c (spot-it 4))
;-> ((1 2 3 4 5) 
;->  (1 6 7 8 9) 
;->  (1 10 11 12 13) 
;->  (1 14 15 16 17) 
;->  (1 18 19 20 21) 
;->  (2 6 10 14 18)
;->  (2 7 11 15 19)
;->  (2 8 12 16 20)
;->  (2 9 13 17 21)
;->  (3 6 11 16 21)
;->  (3 7 12 17 18)
;->  (3 8 13 14 19)
;->  (3 9 10 15 20)
;->  (4 6 12 14 20)
;->  (4 7 13 15 21)
;->  (4 8 10 16 18)
;->  (4 9 11 17 19)
;->  (5 6 13 16 19)
;->  (5 7 10 17 20)
;->  (5 8 11 14 21)
;->  (5 9 12 15 18))

Verifichiamo se il mazzo è corretto:

(check-it c)
;-> Error: (2 6 10 14 18) (4 6 12 14 20) (6 14)
;-> Error: (2 6 10 14 18) (4 7 13 15 21) ()
;-> Error: (2 6 10 14 18) (4 8 10 16 18) (10 18)
;-> Error: (2 6 10 14 18) (4 9 11 17 19) ()
;-> Error: (2 7 11 15 19) (4 6 12 14 20) ()
;-> Error: (2 7 11 15 19) (4 7 13 15 21) (7 15)
;-> Error: (2 7 11 15 19) (4 8 10 16 18) ()
;-> Error: (2 7 11 15 19) (4 9 11 17 19) (11 19)
;-> Error: (2 8 12 16 20) (4 6 12 14 20) (12 20)
;-> Error: (2 8 12 16 20) (4 7 13 15 21) ()
;-> Error: (2 8 12 16 20) (4 8 10 16 18) (8 16)
;-> Error: (2 8 12 16 20) (4 9 11 17 19) ()
;-> Error: (2 9 13 17 21) (4 6 12 14 20) ()
;-> Error: (2 9 13 17 21) (4 7 13 15 21) (13 21)
;-> Error: (2 9 13 17 21) (4 8 10 16 18) ()
;-> Error: (2 9 13 17 21) (4 9 11 17 19) (9 17)
;-> Error: (3 6 11 16 21) (5 6 13 16 19) (6 16)
;-> Error: (3 6 11 16 21) (5 7 10 17 20) ()
;-> Error: (3 6 11 16 21) (5 8 11 14 21) (11 21)
;-> Error: (3 6 11 16 21) (5 9 12 15 18) ()
;-> Error: (3 7 12 17 18) (5 6 13 16 19) ()
;-> Error: (3 7 12 17 18) (5 7 10 17 20) (7 17)
;-> Error: (3 7 12 17 18) (5 8 11 14 21) ()
;-> Error: (3 7 12 17 18) (5 9 12 15 18) (12 18)
;-> Error: (3 8 13 14 19) (5 6 13 16 19) (13 19)
;-> Error: (3 8 13 14 19) (5 7 10 17 20) ()
;-> Error: (3 8 13 14 19) (5 8 11 14 21) (8 14)
;-> Error: (3 8 13 14 19) (5 9 12 15 18) ()
;-> Error: (3 9 10 15 20) (5 6 13 16 19) ()
;-> Error: (3 9 10 15 20) (5 7 10 17 20) (10 20)
;-> Error: (3 9 10 15 20) (5 8 11 14 21) ()
;-> Error: (3 9 10 15 20) (5 9 12 15 18) (9 15)
;-> nil

=============================================================================

