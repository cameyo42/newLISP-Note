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

Lutz ha fornito un'altra versione di "defun" (con spiegazione):

In newLISP the difference between a function written with 'define' and 'define-macro' is that 'define' will evaluate all it's arguments, while 'define-macro' will not.

With 'define-macro' it is possible to make functions which behave and look like built-in fiunctions. I.e. the function (setq x y) does not evaluate the 'x' argument, but passes 'x' on directly as a symbol. The normal (set 'x y) doesn't work that way it evaluates both of it's arguments.

Another example is: (dolist (item mylist) .....). The expression (item mylist) is not evaluated but passed on into 'dolist' to deal with it. If not, we would have to quote doing (dolist '(item mylist) ...).

Macros are not used very often but when they are used they can be handy and important. The following example from init.lsp implements a 'defun' as found in Common LISP. Without 'define-macro' this would be impossible:

; usage example: (defun foo (x y z) ....)

(define-macro (defun _func-name _arguments)
      (set _func-name (append
        '(lambda )
         (list _arguments)
         (args))))

Without 'define-macro' you could only write a 'defun' where both the function name (i.e. foo) and the parameter list (i.e. (x y z)) would have to be quoted.


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

Vediamo cosa accade duante la somma:

(setq f 0.0)
(for (i 1 10)
  (setq f (add f 0.1))
  (print f { } )
)
;-> 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.79999999999 0.89999999999 0.99999999999

(add 0.7 0.1)
;-> 0.7999999999999999

Nota: la funzione "mul" fa le somme corrette :-)

(mul 10 0.1)
;-> 1

(add 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1)
;-> 0.9999999999999999

(= (mul 10 0.1) (add 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1))
;-> nil

(sub (mul 10 0.1) (add 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1 0.1))
;-> 1.110223024625157e-016


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


--------------------------------
Logaritmi: ln, log2, log10, logN
--------------------------------

****************
>>>funzione LOG
****************
sintassi: (log num)
sintassi: (log num num-base)

Nella prima sintassi, viene valutata l'espressione in num e dal risultato viene calcolata la funzione logaritmica naturale.

(log 1) → 0
(log (exp 1)) → 1

Nella seconda sintassi, una base arbitraria può essere specificata in num-base.

(log 1024 2) → 10
(log (exp 1) (exp 1)) → 1

Vedi anche "exp", che è la funzione inversa di "log" con base e (2.718281828).

Possiamo scrivere alcune funzioni per rendere le formule più leggibili:

Logaritmo naturale (base e):
(define (ln x) (log x))

Logaritmo in base 2:
(define (log2 x) (log x 2))

Logaritmo in base 10:
(define (log10 x) (log x 10))

Logaritmo in base N:
(define (logn x n) (log x n)

Nota: logN x = log x / log N

(div (log10 100) (log10 10))
;-> 2
(div (log2 100) (log2 10))
;-> 2
(div (log 100) (log 10))
;-> 2
(div (log 100 10) (log 10 10))
;-> 2

(for (i 0 100 10) (println i { } (ln i) { } (log2 i) { } (log10 i)))
;->   0 -1.#INF -1.#INF -1.#INF
;->  10 2.302585092994046 3.321928094887363 1
;->  20 2.995732273553991 4.321928094887363 1.301029995663981
;->  30 3.401197381662156 4.906890595608519 1.477121254719662
;->  40 3.688879454113936 5.321928094887363 1.602059991327962
;->  50 3.912023005428146 5.643856189774724 1.698970004336019
;->  60 4.094344562222100 5.906890595608519 1.778151250383643
;->  70 4.248495242049359 6.129283016944967 1.845098040014257
;->  80 4.382026634673881 6.321928094887362 1.903089986991943
;->  90 4.499809670330265 6.491853096329675 1.954242509439325
;-> 100 4.605170185988092 6.643856189774725 2


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


-------------------
Conteggio di Morris
-------------------

Vediamo un algoritmo dei primi tempi dell'informatica che è ancora rilevante oggi: contare un gran numero di eventi utilizzando solo una piccola quantità di memoria.
La tecnica è stata inventata da Robert Morris (ricercatore unix e crittografo della NSA, padre del primo "worm" per internet scritto nel 1988) e descritta nel suo articolo del 1978:

"Counting Large Numbers of Events in Small Registers"
http://www.inf.ed.ac.uk/teaching/courses/exc/reading/morris.pdf

L'idea di base è contare i logaritmi invece degli eventi discreti. Assumendo logaritmi in base 2, l'algoritmo è il seguente:

1) Inizializzare un contatore C su 0.

2) Per ogni evento, incrementare il contatore con probabilità 2^−C.

3) Quando viene richiesto il conteggio, restituire (2^C − 1).

Probabilmente sembra banale registrare un conteggio in un singolo byte invece di, diciamo, un intero di 4 byte. Ma i risparmi si moltiplicano rapidamente se dobbiamo contare un gran numero di eventi distinti.

(define (morris n)
  (let (c 0)
    (for (i 1 n)
      ;(if (zero? (rand (pow 2 c)))
      (if (< (random) (pow 2 (- c)))
          (++ c)))
    (- (pow 2 c) 1)))

Facciamo alcune prove:

(morris 0)
;-> 1
(morris 1)
;-> 1
(morris 3)
;-> 3
(morris 10)
;-> 7

Vediamo i primi 20 conteggi reali e quelli di Morris:

(map list (sequence 1 20) (map morris (sequence 1 20)))
;-> ((1 1) (2 3) (3 3) (4 3) (5 7) (6 3) (7 3) (8 7) (9 3) (10 31) (11 7)
;->  (12 7) (13 15) (14 7) (15 15) (16 7) (17 15) (18 15) (19 15) (20 31))

Vediamo i conteggi 1,101,201,...901 reali e quelli di Morris:

(map list (sequence 1 1000 100) (map morris (sequence 1 1000 100)))
;-> ((1 1) (101 31) (201 511) (301 255) (401 255) (501 255)
;->  (601 511) (701 1023) (801 255) (901 1023))

Come si vede non sempre abbiamo una stima valida e per vedere quanto ci discostiamo possiamo calcolare le percentuali degli errori.

Funzione che calcola la differenza percentuale tra due valori:

(define (delta xi xf) (mul (div (sub xf xi) xi) 100))

(delta 10 20)
;-> 100
(delta 20 10)
;-> -50

(map (fn(x) (list (x 0) (x 1) (delta (x 0) (x 1))))
      (map list (sequence 1 1000 100) (map morris (sequence 1 1000 100))))
;-> ((1 1 0)
;->  (101 31 -69.30693069306931)
;->  (201 63 -68.65671641791045)
;->  (301 255 -15.28239202657807)
;->  (401 255 -36.40897755610973)
;->  (501 255 -49.10179640718562)
;->  (601 1023 70.21630615640599)
;->  (701 1023 45.93437945791726)
;->  (801 1023 27.71535580524345)
;->  (901 1023 13.54051054384018))

Se calcoliamo la somma dei primi 5000 conteggi di morris, otteniamo un valore molto vicino a quello esatto:

(apply + (map morris (sequence 1 5000)))
;-> 12503906
(apply + (sequence 1 5000))
;-> 12502500

Quindi vediamo i valori medi dei conteggi, cioè calcoliamo il valore medio di tante misurazioni di morris.

(define (morris-all n conteggi)
  (setq totale 0)
  (for (i 1 conteggi)
    (setq totale (+ totale (morris n)))
  )
  (/ totale conteggi)
)

Facciamo 10 volte il conteggio di morris per 5000 eventi e calcoliamo la media:

(morris-all 5000 10)
;-> 4709

100 conteggi di 5000:

(morris-all 5000 100)
;-> 5057

1000 conteggi di 5000:

(morris-all 5000 1000)
;-> 4975

Vediamo una funzione simile alla precedente:

(define (morris-parallel n conteggi)
  (local (c)
    (setq c (array (+ conteggi 1) '(0)))
    (setq val 0)
    (for (k 1 conteggi)
      (setf (c k) (morris n))
    )
    ;(println c)
    (int (div (apply + c) (- (length c) 1)))))

(morris-parallel 5000 10)
;-> 5528

(morris-parallel 5000 100)
;-> 5170

(morris-parallel 5000 1000)
;-> 5008.408


---------------------------
Orientamento di un poligono
---------------------------

Un poligono può essere orientato (winding) in senso orario (CW - ClockWise) o in senso antiorario (CCW - Counter-ClockWise), riferendosi alla direzione in cui passiamo attraverso i vertici guardando il piano delle coordinate.
Per esempio:

     p1      p2              p1      p4
      +------+                +------+
      |      |                |      |
      |      |                |      |
      +------+                +------+
     p4      p3              p2      p3

  poligono orario        poligono antiorario


Funzione che verifica se un poligono è orientato in senso orario:

(define (clockwise? poly)
  (local (sum cur next)
    (setq sum 0)
    (for (i 0 (- (length poly) 2))
      (setq cur (poly i))
      (setq next (poly (+ i 1)))
      (setq sum (add sum (mul (sub (next 0) (cur 0)) (add (next 1) (cur 1)))))
    )
    (> sum 0)))

Facciamo alcune prove:

; poligoni convessi
; last point = first point
(setq p1 '((0 0) (1 1) (1 0) (0 0)))
(setq p2 '((0 0) (1 0) (1 1) (0 0)))

(clockwise? p1)
;-> true
(clockwise? p2)
;-> nil

; poligono concavo
(setq p3 '((0 0) (1 1) (0 2) (3 4) (6 2) (0 0)))
(clockwise? p3)
;-> true
(clockwise? (reverse (copy p3)))
;-> nil


==============================================================
Il problema della Bella Addormentata (Sleeping Beauty Problem)
==============================================================

The Sleeping Beauty Problem è un problema inventato da Arnold Zoboff e pubblicato per la prima volta su Usenet.
La Bella Addormentata, accetta il seguente esperimento:
La Bella Addormentata viene addormentata la domenica.
C'è poi un lancio di moneta:
1) Se esce testa, la Bella Addormentata si sveglia una volta (lunedì) e gli viene chiesto di stimare la probabilità che il lancio della moneta sia testa.
La sua stima viene registrata e poi viene riaddormentata per 2 giorni fino a mercoledì, momento in cui vengono conteggiati i risultati dell'esperimento.
2) Se invece il lancio della moneta è croce, la Bella Addormentata si sveglia lunedì e deve stimare la probabilità che il lancio della moneta fosse testa, ma poi le viene somministrato un farmaco che le fa dimenticare di essere stata svegliata lunedì prima di essere rimessa a dormire ancora.
Poi si sveglia solo 1 giorno dopo, martedì.
Le viene quindi chiesto (martedì) di indovinare di nuovo la probabilità che il lancio della moneta sia stato testa o croce.
Quindi viene riaddormentata e si sveglia come prima 1 giorno dopo, mercoledì.

Alcuni hanno sostenuto che, poiché il lancio della moneta è equo, la Bella Addormentata dovrebbe sempre stimare la probabilità di testa come 1/2, poiché non ha alcuna informazione aggiuntiva.
Altri sono in disaccordo, dicendo che se la Bella Addormentata conosce l'esperimento, sa anche che ha il doppio delle probabilità di svegliarsi e di dover stimare il lancio della moneta su croce che su testa, quindi la stima dovrebbe essere 1/3 per testa.

Scriviamo una funzione con il metodo di Monte Carlo per la simulazione dei risultati che calcola la percentuale di teste al risveglio.

(define (bella iter)
  (let ((up 0) (down 0) (coin 0))
    (for (i 1 iter)
      (++ down)
      (setq coin (rand 2))
      (if (= coin 1)
          (++ up)
          (++ down)
      )
    )
    (div up down)))

(bella 1e6)
;-> 0.3332417840641609

(bella 1e7)
;-> 0.3331674872979135

La simulazione dice che la percentuale di teste al risveglio è del 33%.


----------------
Per divertimento
----------------

Espressione:

(select "rnmteiv dop" '(10 4 0 7 8 5 6 4 0 3 5 2 4 1 3 9))
;-> "per divertimento"

Creazione dell'espressione:

(setq s "per divertimento")
(setq u (unique (randomize (explode s))))
;-> ("r" "n" "m" "t" "e" "i" "v" " " "d" "o" "p")
(setq ustr (join u))
;-> "rnmteiv dop"
(setq lst '())
(dolist (el (explode s)) (push (first (ref el u)) lst -1))
;-> (10 4 0 7 8 5 6 4 0 3 5 2 4 1 3 9)

(select "rnmteiv dop" '(10 4 0 7 8 5 6 4 0 3 5 2 4 1 3 9))
;-> "per divertimento"

Scriviamo una funzione che restituisce una funzione che esegue la nostra esepressione:
(setq sign "massimo")

(define (genera-firma sign)
  (local (uniq lst u)
    (setq uniq (randomize (unique (explode sign))))
    (setq lst '())
    (dolist (el (explode sign))
      (push (first (ref el uniq)) lst -1)
    )
    (setq u (join uniq))
    (letex ((indexes lst) (str u))
      (lambda () (select str 'indexes)))))

Adesso eseguendo la funzione otteniamo di ritorno un'altra funzione:

(setq firma (genera-firma "massimo"))
;-> (lambda () (select "amios" '(1 0 4 4 2 1 3)))

Eseguendo la funzione creata otteniamo il valore iniziale:

(firma)
;-> "massimo"

Riscriviamo la funzione in modo che restituisca una funzione che accetta un parametro che è la chiave per ottenere la risposta corretta dalla funzione stessa:

(define (genera-firma2 sign)
  (local (uniq lst)
    (setq uniq (randomize (unique (explode sign)))))
    (setq lst '())
    (dolist (el (explode sign))
      (push (first (ref el uniq)) lst -1)
    )
    ; stampa la chiave
    (println (join uniq))
    (letex (indexes lst)
      (lambda (x) (select x 'indexes))))

(setq firma2 (genera-firma2 "massimo"))
;-> iamso ; questa è la chiave
;-> (lambda (x) (select x '(0 2 1 1 3 0 4)))

Chiave corretta:

(firma2 "iamso")
;-> "massimo"

Chiave errata:

(firma2 "maios")
;-> "iaoomis"

Abbiamo una funzione F che si comporta correttamente se viene chiamata con una chiave che viene generata da un'altra funzione G che è la stessa che ha generato F.


----------------------------------------------------
Posizione di scacchi casuale - random chess position
----------------------------------------------------

Generare una posizione di scacchi casuale.
La posizione deve rispettare le seguenti regole:

1) Solo un Re per ogni colore (un Re nero e un Re bianco).
2) I Re non devono essere piazzati su caselle adiacenti.
3) Non possono esserci pedoni nella casella promozione (nessuna pedone in ottava o in prima traversa).
4) Il numero dei pezzi per ogni colore va da 2 a 16 (compresi i Re) (min 4 pezzi - max 32 pezzi).
5) Non è richiesto un equilibrio materiale tra le parti.
6) Il numero dei pezzi usati deve essere conforme a un normale set di scacchi (non cinque cavalli, dieci torri, ecc.)
7) I Re non possono arroccare (o hanno già arroccato).
8) Non c'è nessuna presa "en passant".

Condizione extra: È il turno del bianco.

Funzione che stampa la scacchiera:

(define (print-board board)
  (for (r 0 7)
    (for (c 0 7)
      (if (= (board r c) " ")
          (print " .")
          (print " " (board r c))
      )
    )
    (println)
  )
  'random-position)

Funzione che posiziona i due re nella scacchiera:

(define (place-kings)
(catch
  (local (r1 c1 r2 c2)
    (while true
      (map set '(r1 c1 r2 c2) (rand 8 4))
      ; i due Re non possono essere vicini (contigui)
      (if (and (> (abs (- r1 r2)) 1) (> (abs (- c1 c2)) 1))
        (begin
          (setf (board r1 c1) "K") ; white king
          (setf (board r2 c2) "k") ; black king
          (throw true)))))))

Funzione che seleziona un determinato numero di pezzi:

(define (select-pieces num-pieces)
  (local (out)
    (setq out '())
    (for (i 1 num-pieces)
      (push (black (+ 1 (rand 15))) out -1)
    )
    out))

Funzione che posiziona una lista di pezzi nella scacchiera:

(define (place-pieces lst)
  (local (r c ok)
    (dolist (el lst)
      (setq r (rand 8))
      (setq c (rand 8))
      (setq ok nil)
      (until ok
        (setq ok true)
        ;(print r { } c { } el { } (board r c)) (read-line)
        ; la casella deve essere vuota
        (if (!= (board r c) " ")
          (setq ok nil))
        ; se il pezzo è un pedone,
        ; allora non deve trovarsi nella prima o ultima traversa (riga)
        (if (and (= (upper-case el) "P")
                 (or (= r 7) (= r 0)))
            (setq ok nil))
        ; nuovo tentativo di posizionare il pezzo corrente
        (if (not ok)
          (begin
            (setq r (rand 8))
            (setq c (rand 8)))
        )
      )
      ; posizionamento del pezzo corrente
      (setf (board r c) el)
    )))

Funzione che genera una posizione casuale di scacchi:

(define (random-chess equal)
  (local (board black white pw pb w-pieces b-pieces)
    ; array per la scacchiera
    (setq board (array 8 8 '(" ")))
    ; lista dei pezzi bianchi
    ; caratteri ASCII
    (setq white '("K" "Q" "N" "N" "B" "B" "R" "R"
                  "P" "P" "P" "P" "P" "P" "P" "P"))
    ; caratteri UTF
    ;(setq white '("♚" "♛" "♞" "♞" "♝" "♝" "♜" "♜"
    ;              "♟" "♟" "♟" "♟" "♟" "♟" "♟" "♟")
    ; lista dei pezzi neri
    ; caratteri ASCII
    (setq black '("k" "q" "n" "n" "b" "b" "r" "r"
                  "p" "p" "p" "p" "p" "p" "p" "p"))
    ; caratteri UTF
    ;(setq black '("♔" "♕" "♘" "♘" "♗" "♗" "♖" "♖"
    ;              "♙" "♙" "♙" "♙" "♙" "♙" "♙" "♙"))
    ; numero casuale di pezzi bianchi da posizionare
    (setq pw (+ 2 (rand 14)))
    ; numero casuale di pezzi neri da posizionare
    (setq pb (+ 2 (rand 14)))
    ; se equal = true, allora stesso numero di pezzi bianchi e neri)
    (if equal (setq pb pw))
    ; scelta casuale dei pezzi bianchi
    ; (- pw 1) perchè il Re viene posizionato a parte
    (setq w-pieces (map upper-case (select-pieces (- pw 1))))
    ; scelta casuale dei pezzi neri
    ; (- pb 1) perchè il Re viene posizionato a parte
    (setq b-pieces (select-pieces (- pb 1)))
    ; assegnazione casuale della posizione dei due Re (King)
    (place-kings)
    ;(println "pezzi bianchi = " pw { - } w-pieces)
    ;(println "pezzi neri = " pb { - }  b-pieces)
    ; posizionamento dei pezzi bianchi
    (place-pieces w-pieces)
    ; posizionamento dei pezzi neri
    (place-pieces b-pieces)
    ; stampa della posizione finale
    (print-board board)
    board
  ))

Facciamo alcune prove:

; Numero di pezzi uguali

(random-chess true)
;->  . . . . . . . .
;->  . . . . . . p .
;->  . . . . . . . k
;->  . . . . . . . .
;->  . . . K . . . .
;->  . . . . . . . .
;->  . . . . . N . .
;->  . . . . . . . .
;-> random-position
(random-chess true)
;->  . . . . K . . r
;->  . p . . . . . .
;->  . . R . . . . .
;->  Q N . . . . r p
;->  . R B P . p . r
;->  q . . p n . . .
;->  N N . . . p k .
;->  . . . . . Q . N
;-> random-position
(random-chess true)
;->  . . K n . n . .
;->  p . . . . n N .
;->  . p p . . . . p
;->  P n Q . . . . .
;->  P P P . . N . N
;->  . r . . P . . .
;->  k . P P . b p .
;->  . . . . . . . .
;-> random-position

; Numero di pezzi diversi

(random-chess)
;->  . . . . . n . .
;->  r . . . P R . .
;->  . K . P . . . .
;->  . P . . P . . .
;->  . . p B P r . .
;->  . . . . N . P .
;->  . . . k P . . n
;->  . . . . . . . .
;-> random-position
(random-chess)
;->  . . . . N R . .
;->  p . B . p b p .
;->  . . p . . p . .
;->  . . q P . . P .
;->  . . P P p . . k
;->  N . P R R . b .
;->  . . . B K . b n
;->  . . . . N n . .
;-> random-position
(random-chess)
;->  b . b . . . . .
;->  . R . . . . Q .
;->  p . . . . . k p
;->  . . . n . . . .
;->  . . . p . . p p
;->  . . . p K . . .
;->  . . . . . . . .
;->  n b . . . . b .
;-> random-position

Nota: la condizione extra ci dice che la mossa spetta al Bianco.
Questo significa che il Re nero non può essere sotto scacco.
Quindi la posizione è corretta solo se nessun pezzo del Bianco attacca il Re nero.
La funzione che verifica se un Re è sotto scacco la scriverò in futuro...forse.

Vediamo come convertire una posizione di scacchi rappresentata con una matrice nella relativa rappresentazione algebrica scacchistica:

     Scacchiera con                          Matrice della posizione
     coordinate algebriche
                                              0   1   2   3   4   5   6   7
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  8 |   |   |   |   |   |   |   |   |     0 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  7 |   |   |   |   |   |   |   |   |     1 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  6 |   |   |   |   |   |   |   |   |     2 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  5 |   |   |   |   |   |   |   |   |     3 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  4 |   |   |   |   |   |   |   |   |     4 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  3 |   |   |   |   |   |   |   |   |     5 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  2 |   |   |   |   |   |   |   |   |     6 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
  1 |   |   |   |   |   |   |   |   |     7 |   |   |   |   |   |   |   |   |
    +---+---+---+---+---+---+---+---+       +---+---+---+---+---+---+---+---+
      a   b   c   d   e   f   g   h

Lista di associazione "char-col":

(setq char-col '(("a" 0) ("b" 1) ("c" 2) ("d" 3)
                 ("e" 4) ("f" 5) ("g" 6) ("h" 7)))

(setq col (lookup "e" char-col))
;-> 4

Lista di associazione "col-char":

(setq col-char (map (fn(x) (list (x 1) (x 0))) char-col))
;-> ((0 "a") (1 "b") (2 "c") (3 "d") (4 "e") (5 "f") (6 "g") (7 "h"))

(setq num-row '((8 0) (7 1) (6 2) (5 3) (4 4) (3 5) (2 6) (1 7)))

(setq row (lookup 6 num-row))
;-> 2

Lista di associazione "row-num":

;(setq row-num (map (fn(x) (list (x 1) (x 0))) num-row))
;-> ((0 8) (1 7) (2 6) (3 5) (4 4) (5 3) (6 2) (7 1))
(setq row-num '((0 8) (1 7) (2 6) (3 5) (4 4) (5 3) (6 2) (7 1)))

Funzione che trasforma una coppia di indici di una matrice nelle coordinate di una casella:

(define (matrix-chess row col)
  (list (lookup col col-char)
        (lookup row row-num)))

(matrix-chess 0 0)
;-> ("a 8")

(matrix-chess 7 0)
;-> ("a" 1)

(matrix-chess 1 1)
;-> ("b" 7)

(matrix-chess 1 2)
;-> ("c" 7)

(matrix-chess 7 7)
;-> ("h" 1)

Funzione che trasforma le coordinate di una casella in una coppia di indici di una matrice:

(define (chess-matrix chr num)
  (list (lookup num num-row)
        (lookup chr char-col)))

(chess-matrix "c" 7)
;-> (1 2)

(chess-matrix "a" 1)
;-> (7 0)

Creiamo le liste di associazione che collegano gli indici della matrice con le coordinate algebriche.

(setq out '())
(for (i 0 7)
  (for (j 0 7)
    (setq p (matrix-chess i j))
    (setq p (string (p 0) (p 1)))
    ;(push p out -1)
    (push (list (list i j) p) out -1)
  )
)
;-> (((0 0) "a8") ((0 1) "b8") ((0 2) "c8") ((0 3) "d8")
;->  ((0 4) "e8") ((0 5) "f8") ((0 6) "g8") ((0 7) "h8")
;->  ((1 0) "a7") ((1 1) "b7") ((1 2) "c7") ((1 3) "d7")
;->  ((1 4) "e7") ((1 5) "f7") ((1 6) "g7") ((1 7) "h7")
;->  ((2 0) "a6") ((2 1) "b6") ((2 2) "c6") ((2 3) "d6")
;->  ((2 4) "e6") ((2 5) "f6") ((2 6) "g6") ((2 7) "h6")
;->  ((3 0) "a5") ((3 1) "b5") ((3 2) "c5") ((3 3) "d5")
;->  ((3 4) "e5") ((3 5) "f5") ((3 6) "g5") ((3 7) "h5")
;->  ((4 0) "a4") ((4 1) "b4") ((4 2) "c4") ((4 3) "d4")
;->  ((4 4) "e4") ((4 5) "f4") ((4 6) "g4") ((4 7) "h4")
;->  ((5 0) "a3") ((5 1) "b3") ((5 2) "c3") ((5 3) "d3")
;->  ((5 4) "e3") ((5 5) "f3") ((5 6) "g3") ((5 7) "h3")
;->  ((6 0) "a2") ((6 1) "b2") ((6 2) "c2") ((6 3) "d2")
;->  ((6 4) "e2") ((6 5) "f2") ((6 6) "g2") ((6 7) "h2")
;->  ((7 0) "a1") ((7 1) "b1") ((7 2) "c1") ((7 3) "d1")
;->  ((7 4) "e1") ((7 5) "f1") ((7 6) "g1") ((7 7) "h1"))

(setq indexes-algebric
     '(((0 0) "a8") ((0 1) "b8") ((0 2) "c8") ((0 3) "d8")
       ((0 4) "e8") ((0 5) "f8") ((0 6) "g8") ((0 7) "h8")
       ((1 0) "a7") ((1 1) "b7") ((1 2) "c7") ((1 3) "d7")
       ((1 4) "e7") ((1 5) "f7") ((1 6) "g7") ((1 7) "h7")
       ((2 0) "a6") ((2 1) "b6") ((2 2) "c6") ((2 3) "d6")
       ((2 4) "e6") ((2 5) "f6") ((2 6) "g6") ((2 7) "h6")
       ((3 0) "a5") ((3 1) "b5") ((3 2) "c5") ((3 3) "d5")
       ((3 4) "e5") ((3 5) "f5") ((3 6) "g5") ((3 7) "h5")
       ((4 0) "a4") ((4 1) "b4") ((4 2) "c4") ((4 3) "d4")
       ((4 4) "e4") ((4 5) "f4") ((4 6) "g4") ((4 7) "h4")
       ((5 0) "a3") ((5 1) "b3") ((5 2) "c3") ((5 3) "d3")
       ((5 4) "e3") ((5 5) "f3") ((5 6) "g3") ((5 7) "h3")
       ((6 0) "a2") ((6 1) "b2") ((6 2) "c2") ((6 3) "d2")
       ((6 4) "e2") ((6 5) "f2") ((6 6) "g2") ((6 7) "h2")
       ((7 0) "a1") ((7 1) "b1") ((7 2) "c1") ((7 3) "d1")
       ((7 4) "e1") ((7 5) "f1") ((7 6) "g1") ((7 7) "h1")))

Funzione che converte da indici della matrice notazione algebrica:

(define (mat-alg ij)
  (lookup (list ij) indexes-algebric))

(mat-alg '(0 0))
;-> "a8"
(mat-alg '(7 7))
;-> "h1"
(mat-alg '(2 6))
;-> "g6"

; (setq algebric-indexes (map (fn(x) (list (x 1) (x 0))) indexes-algebric))
(setq algebric-indexes
   '(("a8" (0 0)) ("b8" (0 1)) ("c8" (0 2)) ("d8" (0 3))
     ("e8" (0 4)) ("f8" (0 5)) ("g8" (0 6)) ("h8" (0 7))
     ("a7" (1 0)) ("b7" (1 1)) ("c7" (1 2)) ("d7" (1 3))
     ("e7" (1 4)) ("f7" (1 5)) ("g7" (1 6)) ("h7" (1 7))
     ("a6" (2 0)) ("b6" (2 1)) ("c6" (2 2)) ("d6" (2 3))
     ("e6" (2 4)) ("f6" (2 5)) ("g6" (2 6)) ("h6" (2 7))
     ("a5" (3 0)) ("b5" (3 1)) ("c5" (3 2)) ("d5" (3 3))
     ("e5" (3 4)) ("f5" (3 5)) ("g5" (3 6)) ("h5" (3 7))
     ("a4" (4 0)) ("b4" (4 1)) ("c4" (4 2)) ("d4" (4 3))
     ("e4" (4 4)) ("f4" (4 5)) ("g4" (4 6)) ("h4" (4 7))
     ("a3" (5 0)) ("b3" (5 1)) ("c3" (5 2)) ("d3" (5 3))
     ("e3" (5 4)) ("f3" (5 5)) ("g3" (5 6)) ("h3" (5 7))
     ("a2" (6 0)) ("b2" (6 1)) ("c2" (6 2)) ("d2" (6 3))
     ("e2" (6 4)) ("f2" (6 5)) ("g2" (6 6)) ("h2" (6 7))
     ("a1" (7 0)) ("b1" (7 1)) ("c1" (7 2)) ("d1" (7 3))
     ("e1" (7 4)) ("f1" (7 5)) ("g1" (7 6)) ("h1" (7 7))))

Funzione che converte da notazione algebrica a indici della matrice:

(define (alg-mat c)
  (lookup (list c) algebric-indexes))

(alg-mat "a8")
;-> (0 0)
(alg-mat "h1")
;-> (7 7)
(alg-mat "g6")
;-> (2 6)

(define (upper-case? chr)
  (and (>= (char chr) 65) (<= (char chr) 90)))

(char 65)
;-> "A"
(char 90)
;-> "Z"

(define (matrice-algebrica m)
  (local (w b)
    ; lista dei pezzi bianchi
    (setq w '())
    ; lista dei pezzi neri
    (setq b '())
    (for (i 0 7)
      (for (j 0 7)
        (setq p (m i j))
        (cond ((= p " ") nil)
              (true
                (setq val (append p (mat-alg (list i j))))
                (if (upper-case? p)
                    ; lettera maiuscola: pezzo bianco
                    (push val w -1)
                    ;else
                    ; lettera minuscola: pezzo nero
                    (push val b -1)))
        )
      )
    )
    (list w b)))

Facciamo alcune prove:

(matrice-algebrica (random-chess true))
;->  B . . . . . . r
;->  . P . n . . N .
;->  p . . . . . k P
;->  . p . P . . . p
;->  . b p R . . P R
;->  . . . p Q . . n
;->  p K . . . . . .
;->  . . . . . . B .
;-> (("Ba8" "Pb7" "Ng7" "Ph6" "Pd5" "Rd4" "Pg4" "Rh4" "Qe3" "Kb2" "Bg1")
;->  ("rh8" "nd7" "pa6" "kg6" "pb5" "ph5" "bb4" "pc4" "pd3" "nh3" "pa2"))

(matrice-algebrica (random-chess true))
;->  . . . . . K B .
;->  b . p . . . . .
;->  . . . N . . p .
;->  r . . . p . . P
;->  . . . . . . . .
;->  . k . . P P . .
;->  . . . . . . . .
;->  . . . . . . . .
;-> (("Kf8" "Bg8" "Nd6" "Ph5" "Pe3" "Pf3")
;->  ("ba7" "pc7" "pg6" "ra5" "pe5" "kb3"))

(matrice-algebrica (random-chess))
;->  . . . K . q . .
;->  . . . . P . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . . . .
;->  . . . . . k . .
;->  . . P . . P . .
;->  . . . . . . . .
;-> (("Kd8" "Pe7" "Pc2" "Pf2") ("qf8" "kf3"))


-----------------------
Struttura dati generica
-----------------------

La seguente espressione permette di creare strutture dati generiche:

; Generic Data Structure by Cyril
(define (Struct:Struct) (apply context (cons (context) (args))))
;-> (lambda () (apply context (cons (context) (args))))

Ora per creare una nuova struttura occorre scrivere:

(new Struct 't)
;-> t

Per creare simbli ed assegnare valori basta scrivere:

(map t '(year month day hour mins sec micro doy dow tz dst) (now))
;-> (2022 10 10 15 55 14 969022 283 1 120 2)

Vediamo come sono associati i simboli/valori:

t:year
;-> 2022

t:day
;-> 10

Oppure:

(t 'month)
;-> 10

Vediamo come aggiornare i simboli/valori:

(setq t:year (+ t:year 1))
;-> 2023

Oppure:

(t 'year (+ (t 'year) 1))
;-> 2024

Questa (t) è una struttura di dati generica (contesto) i cui campi sono accessibili sia con la sintassi dei due punti ":" che con la notazioni funzionale. Quest'ultimo metodo è utile per le assegnazioni di gruppo.


-----------------------------------------
Differenza simmetrica negli insiemi (set)
-----------------------------------------

Dati due insiemi A e B, calcolare la differenza simmetrica, cioè (A \ B) ∪ (B \ A).
Cioè, enumerare gli elementi che si trovano in A o B, ma non in entrambi.
Questo insieme è chiamato differenza simmetrica di A e B.

Nota:
Differenza: A \ B fornisce l'insieme degli elementi in A che non sono in B;
Differenza: B \ A fornisce l'insieme degli elementi in B che non sono in A;
Unione: A ∪ B dà l'insieme degli elementi sia in A che in B, (la loro unione);
Intersezione: A ∩ B dà l'insieme degli elementi che si trovano sia in A che in B (la loro intersezione).

In altre parole: (A ∪ B) \ (B ∪ A) (l'insieme degli elementi che si trovano in almeno uno di A o B meno l'insieme degli elementi che si trovano sia in A che in B).

(setq s1 '("John" "Bob" "Mary" "Serena"))
(setq s2 '("Jim" "Mary" "John" "Bob"))

(difference s1 s2)
;-> "Serena"
(difference s2 s1)
;-> "Jim"

(define (symmetric-difference a b)
  (union (difference a b) (difference b a)))

(symmetric-difference s1 s2)
;-> ("Serena" "Jim")
(symmetric-difference s2 s1)
;-> ("Jim "Serena")

Insiemi con elementi uguali:

(setq s3 '("John" "Serena" "Bob" "Mary" "Serena"))
(setq s4 '("Jim" "Mary" "John" "Jim" "Bob"))

(symmetric-difference s3 s4)
;-> ("Serena" "Jim")

(symmetric-difference s4 s3)
;-> ("Jim" "Serena")


-------------------------------------------------
Problema dei nomi degli Stati (State name puzzle)
-------------------------------------------------

Prendere i nomi di due Stati degli Stati Uniti, mescolarli tutti insieme, quindi riordinare le lettere per formare i nomi di altri due Stati degli Stati Uniti (in modo che tutti e quattro i nomi di stato differiscano l'uno dall'altro).
Che stati sono questi?

(setq states
      '("Alabama" "Alaska" "Arizona" "Arkansas"
        "California" "Colorado" "Connecticut" "Delaware"
        "Florida" "Georgia" "Hawaii" "Idaho"
        "Illinois" "Indiana" "Iowa" "Kansas"
        "Kentucky" "Louisiana" "Maine" "Maryland"
        "Massachusetts" "Michigan" "Minnesota" "Mississippi"
        "Missouri" "Montana" "Nebraska" "Nevada"
        "New Hampshire" "New Jersey" "New Mexico" "New York"
        "North Carolina" "North Dakota" "Ohio" "Oklahoma"
        "Oregon" "Pennsylvania" "Rhode Island" "South Carolina"
        "South Dakota" "Tennessee" "Texas" "Utah"
        "Vermont" "Virginia" "Washington" "West Virginia"
        "Wisconsin" "Wyoming"))

(length states)
;-> 50

Funzione che calcola il prodotto cartesiano di due liste:

(define (cp lst1 lst2)
  (let (out '())
    (if (or (null? lst1) (null? lst2))
        nil
        (dolist (el1 lst1)
          (dolist (el2 lst2)
            (push (list el1 el2) out -1))))))

(length (cp states states))
;-> 2500

Funzione che trova i quattro stati (se esitono):

(define (mixed-states lst)
  (setq all (cp states states))
  (setq s '())
  ; creiamo una lista del tipo:
  ; ("  CCNNaaaahhiillnnoooorrrrtt" "North Carolina" "North Carolina")
  (dolist (el all)
    (push (list (join (sort (append (explode (el 0)) (explode (el 1)))))
                (el 0) (el 1)) s -1)
  )
  (sort s)
  ; Adesso quando nella lista s troviamo 4 stringhe uguali (consecutive),
  ; allora abbiamo trovato una soluzione.
  (for (i 0 (- (length s) 4))
    (if (= (first (s i)) (first (s (+ i 1)))
           (first (s (+ i 2))) (first (s (+ i 3))))
      (begin
        (println (s i))
        (println (s (+ i 1)))
        (println (s (+ i 2)))
        (println (s (+ i 3))))
    )
  )
)

(mixed-states states)
;-> ("  CDNSaaaahhiklnoooorrtttu" "North Carolina" "South Dakota")
;-> ("  CDNSaaaahhiklnoooorrtttu" "North Dakota" "South Carolina")
;-> ("  CDNSaaaahhiklnoooorrtttu" "South Carolina" "North Dakota")
;-> ("  CDNSaaaahhiklnoooorrtttu" "South Dakota" "North Carolina")


-------------------
Consigli del Buddha
-------------------

Il file "buddha.txt" si trova nella cartella "DATA".

(define (buddha)
  (local (file frasi num-frasi)
    (setq file (open "buddha.txt" "read"))
    (setq frasi '())
    (while (read-line file)
      (push (current-line) frasi -1)
    )
    (close file)
    (setq num-frasi (length frasi))
    (frasi (rand num-frasi))))

(buddha)
;-> "Un solo capello e' sufficiente ad agitare il mare."


-----------------------------------
Sequenza cifre-primi di Smarandache
-----------------------------------

La sequenza cifre-primi di Smarandache (SPDS - Smarandache prime-digital sequence) è la sequenza di numeri primi le cui cifre sono esse stesse prime.

Ad esempio 257 è un elemento di questa sequenza perché è primo e le sue cifre: 2, 5 e 7 sono anche primi.

Sequenza OEIS: A019546
  2, 3, 5, 7, 23, 37, 53, 73, 223, 227, 233, 257, 277, 337, 353,
  373, 523, 557, 577, 727, 733, 757, 773, 2237, 2273, 2333, 2357,
  2377, 2557, 2753, 2777, 3253, 3257, 3323, 3373, 3527, 3533, 3557,
  3727, 3733, 5227, 5233, 5237, 5273, 5323, 5333, 5527, 5557, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (int-list num)
"Convert an integer to a list of digits"
  (let (out '())
    (while (!= num 0)
      (push (% num 10) out)
      (setq num (/ num 10))) out))

Funzione che verifica se tutte le cifre di un numero sono prime:

(define (digit-prime? num)
  (local (lst stop)
    (setq lst (int-list num))
    (setq stop nil)
    (dolist (d lst stop)
      (if (or (= d 0) (= d 1) (= d 4) (= d 6) (= d 8) (= d 9))
          (setq stop true)
      )
    )
    (not stop)))

(digit-prime? 2371)
;-> nil
(digit-prime? 22275)
;-> true

Funzione che verifica se un numero è di Smarandache:

(define (smarandache? num)
  (and (digit-prime? num) (prime? num)))

(smarandache? 257)
;-> true

(filter smarandache? (sequence 1 5000))
;-> (2 3 5 7 23 37 53 73 223 227 233 257 277 337 353 373 523 557 577
;->  727 733 757 773 2237 2273 2333 2357 2377 2557 2753 2777 3253 3257
;->  3323 3373 3527 3533 3557 3727 3733)


------------------------------------------
Ricerca del numero più vicino in una lista
------------------------------------------

Dato un valore intero da cercare e una lista di associazione, trovare l'elemento della lista che fornisce la corrispondenza più vicina tra il valore intero e il primo valore degli elementi della lista.
Per esempio:

(setq target 200906281845)

(setq data '(
  (200906282050 "29003KT" "CAVOK")
  (200906281950 "05004KT" "CAVOK")
  (200906281750 "12010KT" "2222") ; <- dovrebbe restituire questo elemento
  (200906281700 "13010KT" "9999")
  (200906280000 "14010KT" "1111")
; ...
))

Nota: i numeri da cercare sono tutti positivi.

Calcoliamo tutte le differenza tra il numero e il primo valore di ogni elemento della lista (mantenendo l'indice di ogni elemento).
Ordiniamo la lista ottenuta con la differenza crescente.
Adesso il valore più vicino all'intero è quello che si trova al primo posto nella listail primo.

Per esempio:

Calcoliamo le differenze:

(setq d (map (fn(x) (list (abs (- target (first x))) $idx)) data))
;-> ((205 0) (105 1) (95 2) (145 3) (1845 4))

dove (205 0) significa che la differenza tra il numero intero e il valore della lista con indice 0 vale 250.

Adesso ordiniamo la lista delle differenze:

(sort d)
;-> ((95 2) (105 1) (145 3) (205 0) (1845 4))

L'elemento più vicino all'intero ha una differenza di 95 ed è quello all'indice 2 della lista di associazione:

(data 2)
;-> (200906281750 "12010KT" "2222")

Possiamo scrivere la funzione:

(define (find-match target lst)
  (let (diff (sort (map (fn(x) (list (abs (- target (first x))) $idx)) lst)))
    (lst (diff 0 1))))

(find-match target data)
;-> (200906281750 "12010KT" "2222")

(find-match 200906280000 data)
;-> (200906280000 "14010KT" "1111")

(setq data1 '(
    (101 a b c)
    (200 c d e)
    (230 x y z)
    (250 f g h)))

(find-match 150 data1)
;-> (101 a b c)
(find-match 160 data1)
;-> (200 c d e)

Vediamo una funzione più generale che permette di cercare anche in liste piatte (flat) e di cercare anche numeri negativi:

Il parametro "idx" è l'indice della colonna di ricerca della lista.
Se "idx" vale -1, allora "lst" è una lista piatta (flat).

(define (find-close target lst idx)
  (local (diffa)
    (if (= idx -1) ; flat list
        (setq diff (sort (map (fn(x) (list (abs (- target x)) $idx)) lst)))
        (setq diff (sort (map (fn(x) (list (abs (- target (x idx))) $idx)) lst)))
    )
    ;(println diff)
    (if (< (diff 0 0) 0)
        (lst (diff -1 1))
        (lst (diff 0 1)))))

(find-close 150 data1 0)
;-> (101 a b c)

(setq data2 '(
    (a 101 a b c)
    (a 200 c d e)
    (a 230 x y z)
    (a 250 f g h)))

(find-close 240 data2 1)
;-> (a 230 x y z)

(setq data3 '(101 200 230 250))
(find-close 240 data3 -1)
;-> 230

(setq data4 '((a 101) (b 200) (c 230) (d 250)))
(find-close 240 data4 1)
;-> (c 230)

(setq data5 '((a 101) (b 200) (b1 250) (c 230) (d 250)))
(find-close 240 data5 1)
;-> (b1 250)

(setq data6 '(11 -2 -3 -4 12))
(find-close -10 data6 -1)
;-> -4
(find-close 13 data6 -1)
;-> 12

(setq data7 '(101 200 -230 250))
(find-close -20 data7 -1)
;-> 101

Adesso scriviamo una funzione che ritorna anche l'indice del valore più vicino (in una lista piatta):

(define (find-close-flat target lst)
  (local (valore indice distanza)
    (setq distanza (abs (- target (lst 0))))
    (setq indice 0)
    (setq valore (lst 0))
    (dolist (el lst)
      (setq d (abs (- target el)))
      (if (< d distanza)
          (set 'distanza d 'indice $idx 'valore el)
      )
    )
    (list valore indice)))

(setq data8 '(-100 -10 42 101 200 -228 -230 250))
(find-close-flat -50 data8)
;-> (-10 1)
(find-close-flat 40 data8)
;-> (42 2)
(find-close-flat -229 data8)
;-> (-228 5)

Vediamo se le due funzioni restituiscono gli stessi valori con uno stress-test:

(define (rand-range min-val max-val)
"Generate a random integer in a closed range"
  (if (> min-val max-val) (swap min-val max-val))
  (+ min-val (rand (+ (- max-val min-val) 1))))

(define (stress iter)
  (for (i 1 iter)
    (setq lst (randomize (sequence -1000 1000 2)))
    (setq t (rand-range -999 999))
    (if (!= (find-close t lst -1) (first (find-close-flat t lst)))
      (println t { } (find-close t lst -1) { } (find-close-flat t lst))
    )))

(stress 1e5)
;-> nil ; sembra tutto corretto.

Infine una funzione generica per ricercare il valore più vicino in liste piatte o annidate e con numeri positivi e negativi:

(define (find-closest target lst idx)
  (local (value val-index diff)
    (cond ((= idx -1) ; flat list
            (setq value (lst 0))
            (setq val-index 0)
            (setq diff (abs (- target (lst 0))))
            (dolist (el lst)
              (setq d (abs (- target el)))
              (if (< d diff)
                  (set 'diff d 'val-index $idx 'value el)
              )
            )
            (list value val-index))
          (true ; nested list
            (setq value (lst 0 idx))
            (setq val-index 0)
            (setq diff (abs (- target (lst 0 idx))))
            (dolist (el lst)
              (setq d (abs (- target (el idx))))
              (if (< d diff)
                  (set 'diff d 'val-index $idx 'value (el idx))
              )
            )
            (list (lst val-index) val-index))
    )))

Facciamo alcune prove:

(find-closest 150 data1 0)
;-> ((101 a b c) 0)
(find-closest 240 data2 1)
;-> ((a 230 x y z) 2)
(find-closest 240 data3 -1)
;-> (230 2)
(find-closest 240 data4 1)
;-> ((c 230) 2)
(find-closest 240 data5 1)
;-> ((b1 250) 2)
(find-closest -10 data6 -1)
;-> (-4 3)
(find-closest 13 data6 -1)
;-> (12 4)
(find-closest -20 data7 -1)
;-> (101 0)


---------------------
Numeri primi Pierpont
---------------------

Un numero è Pierpont di primo tipo se è un numero primo della forma:
  (2^t*3^u + 1) con u,t > 0

Un numero è Pierpont di secondo tipo se è un numero primo della forma:
  (2^t*3^u - 1) con u,t > 0

Pierpont di primo tipo
----------------------

Sequenza OEIS: A005109
  2, 3, 5, 7, 13, 17, 19, 37, 73, 97, 109, 163, 193, 257, 433, 487,
  577, 769, 1153, 1297, 1459, 2593, 2917, 3457, 3889, 10369, 12289,
  17497, 18433, 39367, 52489, 65537, 139969, 147457, 209953, 331777,
  472393, 629857, 746497, 786433, 839809, 995329, 1179649, 1492993,
  1769473, 1990657, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (pierpont1 limit)
  (local (x2 x3 k2 k23 out))
    (setq out '())
    (set 'x2 0 'x3 0 'k2 1 'k23 1)
    (while (< k2 limit)
      (setq k23 k2)
      (while (< k23 limit)
        (if (prime? (+ k23 1)) (push (+ k23 1) out))
        (setq k23 (* k23 3))
      )
      (setq k2 (* k2 2))
    )
    (sort out)
  )

(pierpont1 1e6)
;-> (2 3 5 7 13 17 19 37 73 97 109 163 193 257 433 487 577 769
;->  1153 1297 1459 2593 2917 3457 3889 10369 12289 17497 18433
;->  39367 52489 65537 139969 147457 209953 331777 472393 629857
;->  746497 786433 839809 995329)

(time (println (length (pierpont1 1e7))))
;-> 50
;-> 3.991

(time (println (length (pierpont1 1e16))))
;-> 125
;-> 3820.517


Pierpont secondo tipo
---------------------

Sequenza OEIS: A005105
  2, 3, 5, 7, 11, 17, 23, 31, 47, 53, 71, 107, 127, 191, 383, 431,
  647, 863, 971, 1151, 2591, 4373, 6143, 6911, 8191, 8747, 13121,
  15551, 23327, 27647, 62207, 73727, 131071, 139967, 165887, 294911,
  314927, 442367, 472391, 497663, 524287, 786431, 995327, ...

(define (pierpont2 limit)
  (local (x2 x3 k2 k23 out))
    (setq out '())
    (set 'x2 0 'x3 0 'k2 1 'k23 1)
    (while (< k2 limit)
      (setq k23 k2)
      (while (< k23 limit)
        (if (prime? (- k23 1)) (push (- k23 1) out))
        (setq k23 (* k23 3))
      )
      (setq k2 (* k2 2))
    )
    (sort out)
  )

(pierpont2 1e6)
;-> (2 3 5 7 11 17 23 31 47 53 71 107 127 191 383 431 647 863 971
;->  1151 2591 4373 6143 6911 8191 8747 13121 15551 23327 27647
;->  62207 73727 131071 139967 165887 294911 314927 442367 472391
;->  497663 524287 786431 995327)

(time (println (length (pierpont2 1e7))))
;-> 45
;-> 0.998

(time (println (length (pierpont2 1e16))))
;-> 113
;-> 3072.157


---------------------------------
Punti, linee, polilinee, poligoni
---------------------------------

Punto P: (x y)
Linea L: ((x1 y1) (x2 y2))
Polilinea PL: (((x1 y1) (x2 y2)) ... ((xn-1 yn-1) (xn yn)))
Poligono PG: (((x1 y1) (x2 y2)) ... ((xn-1 yn-1) (xn yn))), dove x1 = xn e y1 = yn

Funzione che converte una lista di punti in linea, polilinea, poligono:

(define (pts2line lst)
  (map list (chop lst) (rest lst)))

(setq punti '((0 1) (2 2) (4 5) (2 3)))

(pts2line punti)
;-> (((0 1) (2 2)) ((2 2) (4 5)) ((4 5) (2 3)))

Se la lista ha due punti, allora otteniamo una linea.
Se la lista ha più di due punti, allora otteniamo una polilinea oppure un poligono se il primo e l'ultimo punto sono uguali.

Funzione che converte una linea, polilinea, poligono in una lista di punti:

(define (line2pts lst)
  (unique (flat lst 1)))

(line2pts (pts2line punti))
;-> ((0 1) (2 2) (4 5) (2 3))


-------------------
Sequenza di Van Eck
-------------------

La sequenza di Van Eck viene generata seguendo questo pseudo-codice:

R: Il primo termine è zero.
     Applicare ripetutamente:
         Se l'ultimo termine è *nuovo* nella sequenza finora, allora:
B: Il prossimo termine è zero.
         Altrimenti:
C: Il termine successivo è quanto indietro è avvenuto in precedenza quest'ultimo termine.

Esempio
Usare un:
0

Usando B:
0 0

Usando C:
0 0 1

Usando B:
0 0 1 0

Usando C: (l'ultimo zero si è verificato due passi indietro - prima dell'uno)
0 0 1 0 2

Usando B:
0 0 1 0 2 0

Usando C: (le ultime due si sono verificate due passi indietro - prima dello zero)
0 0 1 0 2 0 2 2

Usando C: (le ultime due si sono verificate un passo indietro)
0 0 1 0 2 0 2 2 1

Usando C: (l'ultimo è apparso sei passi indietro)
0 0 1 0 2 0 2 2 1 6

Sequenza OEIS: A181391
  0, 0, 1, 0, 2, 0, 2, 2, 1, 6, 0, 5, 0, 2, 6, 5, 4, 0, 5, 3, 0, 3, 2,
  9, 0, 4, 9, 3, 6, 14, 0, 6, 3, 5, 15, 0, 5, 3, 5, 2, 17, 0, 6, 11, 0,
  3, 8, 0, 3, 3, 1, 42, 0, 5, 15, 20, 0, 4, 32, 0, 3, 11, 18, 0, 4, 7,
  0, 3, 7, 3, 2, 31, 0, 6, 31, 3, 6, 3, 2, 8, 33, 0, 9, 56, 0, 3, 8, 7,
  19, 0, 5, 37, 0, 3, 8, 8, 1, ...

;; LISP version
;; Tested using CLISP
(defun VanEck (x) (reverse (VanEckh x 0 0 '(0))))

(defun VanEckh (final index curr lst)
  (if (eq index final)
    lst
    (VanEckh final (+ index 1) (howfar curr lst) (cons curr lst))))

(defun howfar (x lst) (howfarh x lst 0))

(defun howfarh (x lst runningtotal)
  (cond
    ((null lst) 0)
    ((eq x (car lst)) (+ runningtotal 1))
    (t (howfarh x (cdr lst) (+ runningtotal 1)))))

(format t "The first 10 elements are ~a~%" (VanEck 9))
(format t "The 990-1000th elements are ~a~%" (nthcdr 990 (VanEck 999)))

Output:
The first 10 elements are (0 0 1 0 2 0 2 2 1 6)
The 990-1000th elements are (4 7 30 25 67 225 488 0 10 136)

;; newLISP version
(define car first)
(define cdr rest)

(define (VanEck x) (reverse (VanEckh x 0 0 '(0))))

(define (VanEckh final idx curr lst)
  (if (= idx final)
      lst
      (VanEckh final (+ idx 1) (howfar curr lst) (cons curr lst))))

(define (howfar x lst) (howfarh x lst 0))

(define (howfarh x lst runningtotal)
  (cond
    ((null? lst) 0)
    ((= x (car lst)) (+ runningtotal 1))
    (true (howfarh x (cdr lst) (+ runningtotal 1)))))

(VanEck 9)
;-> (0 0 1 0 2 0 2 2 1 6)

Ma newLISP non ha (per default) uno stack sufficiente:

(VanEck 1000)
;-> ERR: call or result stack overflow in function cond : null?
;-> called from user function (howfarh x (cdr lst) (+ runningtotal 1))

Vediamo allora di utilizzare un algoritmo iterativo:

Van Eck's sequence:
For n >= 1,
if there exists an m < n such that a(m) = a(n),
   then take the largest such m and set a(n+1) = n-m,
   otherwise a(n+1) = 0. Start with a(1)=0.

(define (vaneck limit)
  (setq a (array limit '(0)))
  (for (n 0 (- limit 2))
    (setq stop nil)
    (for (m  (- n 1) 0 -1 stop)
      (if (= (a m) (a n))
          (begin
            (setf (a (+ n 1)) (- n m))
            (setq stop true))
      )
    )
  )
  (push 0 (array-list a)))

Facciamo alcune prove:

(vaneck 10)
;-> (0 0 1 0 2 0 2 2 1 6 0)

(slice (vaneck 1000) 990 10)
;-> (4 7 30 25 67 225 488 0 10 136)

Complessità temporale: O(n^2)

Vediamo i tempi di esecuzione:

(time (vaneck 1e3))
;-> 9.946

(time (vaneck 1e4))
;-> 738.647

(time (vaneck 1e5))
;-> 63503.147


--------------------------------------
Addizione tra numeri interi (stringhe)
--------------------------------------

Funzione che somma due numeri interi passati come stringhe:

(define (add+ str1 str2)
  (local (n1 n2 str val carry z)
    (setq z (char "0"))
    ; str2 deve essere la più lunga
    (if (> (length str1) (length str2)) (swap str1 str2))
    (setq str "")
    (setq n1 (length str1))
    (setq n2 (length str2))
    ; inversione delle stringhe
    (reverse str1)
    (reverse str2)
    (setq carry 0)
    ; Ciclo per tutta la stringa più corta
    ; sottrae le cifre di str2 a str1
    (for (i 0 (- n1 1))
      ; calcolo della somma delle cifre correnti e
      ; del riporto (carry)
      (setq val (+ (- (char (str1 i)) z)
                   (- (char (str2 i)) z)
                  carry))
      (extend str (char (+ (% val 10) z)))
      (setq carry (int (div val 10)))
    )
    (if (!= n1 n2) (begin
        ; aggiunge le cifre rimanenti di str2
        (for (i n1 (- n2 1))
          (setq val (+ (- (char (str2 i)) z) carry))
          (extend str (char (+ (% val 10) z)))
          (setq carry (int (div val 10)))
        ))
    )
    ; se esiste, aggiunge il riporto (carry)
    (if (> carry 0) (extend str (char (+ carry z))))
    ; inverte la stringa
    (reverse str)))

Facciamo alcune prove:

(add+ "198199" "12")
;-> "198211"
(+ 198199 12)
;-> 198211

(add+ "1989" "121")
;-> 2110
(+ 1989 121)
;-> 2110

(add+ "888" "333")
(+ 888 333)
;-> "1221"

(+ 873612837945612837945681273 3571234578912358971289511342578125)
;-> 3571235452525196916902349288259398L
(add+ "873612837945612837945681273" "3571234578912358971289511342578125")
;-> "3571235452525196916902349288259398"

Scriviamo una funzione per fare un determinato numero di test casuali:

(define (test iter)
  (local (a b as bs)
    (for (i 1 iter)
      (setq a (rand 1e12))
      (setq b (rand 1e12))
      (setq as (string a))
      (setq bs (string b))
      (if (!= (string (+ a b)) (add+ as bs))
          (println a { } b { } as { } bs { } (+ a b) { } (add+ as bs))))))

(time (test 1e6))
;-> 11124.437

Nessun errore su 1e6 addizioni.


----------------------------------------
Sottrazione tra numeri interi (stringhe)
----------------------------------------

Funzione che restituisce true se str1 < str2:

(define (smaller? str1 str2)
  (local (n1 n2 out)
    (setq n1 (length str1))
    (setq n2 (length str2))
    (cond ((> n1 n2) (setq out nil))
          ((< n1 n2) (setq out true))
          (true
            (setq out nil)
            (setq stop nil)
            (for (i 0 (- n1 1) 1 stop)
              (cond ((< (str1 i) (str2 i))
                     (set 'out true 'stop true))
                    ((> (str1 i) (str2 i))
                     (set 'out nil 'stop true))
              )
            )
          )
    )
    out))

(smaller? "12" "122")
;-> true
(smaller? "345" "233")
;-> nil
(smaller? "233" "345")
;-> true
(smaller? "111" "111")
;-> nil
(smaller? "0" "1")
;-> true

Scriviamo una funzione per verificare la correttezza della funzione "smaller?":

(define (test iter)
  (local (a b as bs)
    (for (i 1 iter)
      (setq a (rand 1e12))
      (setq b (rand 1e12))
      (setq as (string a))
      (setq bs (string b))
      (if (and (> a b) (= (smaller? as bs) true))
          (println a { } b { } as { } bs { } (+ a b) { } (smaller? as bs)))
      (if (and (< a b) (= (smaller? as bs) nil))
          (println a { } b { } as { } bs { } (+ a b) { } (smaller? as bs))))))

(test 1e6)
;-> nil

Nessun errore di valutazione in un milione di prove.

Funzione che sottrae due numeri interi passati come stringhe:

(define (sub- str1 str2)
  (local (n1 n2 str val carry z)
    (setq z (char "0"))
    ; str1 deve essere maggiore o uguale a str2
    (if (smaller? str1 str2) (swap str1 str2))
    (setq str "")
    (setq n1 (length str1))
    (setq n2 (length str2))
    ; inversione delle stringhe
    (reverse str1)
    (reverse str2)
    (setq carry 0)
    ; Ciclo per tutta la stringa più corta
    ; sottrae le cifre di str1 a str2
    (for (i 0 (- n2 1))
      (setq val (int (str1 i)))
      (setq val (- (- (char (str1 i)) z)
                   (- (char (str2 i)) z)
                   carry))
      ; Se la sottrazione è minore di zero
      ; allora aggiungiamo 10 a val e
      ; poniamo il riporto (carry) a 1
      (if (< val 0)
          (set 'val (+ val 10) 'carry 1)
          ; else
          (set 'carry 0)
      )
      (extend str (char (+ val z)))
    )
    ; sottrae le cifre rimanenti del numero maggiore
    (if (!= n1 n2) (begin
        ; sottrae le cifre che rimangono di str1
        (for (i n2 (- n1 1))
          (setq val (- (- (char (str1 i)) z) carry))
          ; se il valore val è negativo, allora lo rende positivo
          (if (< val 0)
            (set 'val (+ val 10) 'carry 1)
            ;else
            (set 'carry 0)
          )
          (extend str (char (+ val z)))
        ))
    )
    (reverse str)
    ; toglie gli (eventuali) zeri iniziali
    (while (= (str 0) "0") (pop str))
    (if (= str "") (setq str "0"))
    str))

(sub- "978" "977")
;-> "1"

(sub- "977" "978")
;-> "1"

(sub- "801" "102")
;-> "699"
(- 801 102)
;-> 699

(sub- "8102" "103")
;-> "7999"
(- 8102 103)
;-> 7999

(sub- "978" "12977")
;-> "11999"
(- 12977 978)
;-> 11999

(sub- "99999" "99998")
;-> "1"

(sub- "999" "999")
;-> "0"

Scriviamo una funzione per fare un determinato numero di test casuali:

(define (test iter)
  (local (a b as bs)
    (for (i 1 iter)
      (setq a (rand 1e12))
      (setq b (rand 1e12))
      (setq as (string a))
      (setq bs (string b))
      (if (!= (string (abs (- a b))) (sub- as bs))
          (println a { } b { } as { } bs { } (+ a b) { } (sub- as bs))))))

(time (test 1e6))
;-> 13714.882

Nessun errore su 1e6 sottrazioni.


---------------------
Numeri primi additivi
---------------------

I numeri primi additivi sono numeri primi per i quali anche la somma delle cifre decimali è primo.

Sequenza OEIS: A046704
  2, 3, 5, 7, 11, 23, 29, 41, 43, 47, 61, 67, 83, 89, 101, 113, 131,
  137, 139, 151, 157, 173, 179, 191, 193, 197, 199, 223, 227, 229, 241,
  263, 269, 281, 283, 311, 313, 317, 331, 337, 353, 359, 373, 379, 397,
  401, 409, 421, 443, 449, 461, 463, 467, 487, 557, 571, 577, 593, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (additive? num)
  (and (prime? num) (prime? (digit-sum num))))

(filter additive? (sequence 1 500))
;-> (2 3 5 7 11 23 29 41 43 47 61 67 83 89 101 113 131 137 139 151 157 173
;->  179 191 193 197 199 223 227 229 241 263 269 281 283 311 313 317 331 337
;->  353 359 373 379 397 401 409 421 443 449 461 463 467 487)


------------------
Numeri primi-primi
------------------

I numeri primi-primi sono numeri primi per i quali ogni cifra è primo e anche la somma delle cifre è primo.

Sequenza OEIS: A062088
  2, 3, 5, 7, 23, 223, 227, 337, 353, 373, 557, 577, 733, 757, 773,
  2333, 2357, 2377, 2557, 2753, 2777, 3253, 3257, 3323, 3527, 3727,
  5233, 5237, 5273, 5323, 5527, 7237, 7253, 7523, 7723, 7727, 22573,
  23327, 25237, 25253, 25523, 27253, 27527, 32233, 32237, 32257, ...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (digit-prime? num)
  (local (lst stop)
    (setq lst (int-list num))
    (setq stop nil)
    (dolist (d lst stop)
      (if (or (= d 0) (= d 1) (= d 4) (= d 6) (= d 8) (= d 9))
          (setq stop true)
      )
    )
    (not stop)))

Funzione che verifica se un numero è primo-primo:

(define (primi-primi num)
  (and (prime? num) (digit-prime? num) (prime? (digit-sum num))))

(filter primi-primi (sequence 1 1000))
;-> (2 3 5 7 23 223 227 337 353 373 557 577 733 757 773)

Vediamo la velocità di esecuzione modificando l'ordine delle clausole nell'espressione "and":

(time (filter primi-primi (sequence 1 1e6)))
;-> 1021.831
(time (filter primi-primi (sequence 1 1e7)))
;-> 19123.615

(define (primi-primi1 num)
  (and (digit-prime? num) (prime? num) (prime? (digit-sum num))))

(time (filter primi-primi1 (sequence 1 1e6)))
;-> 1560.831
(time (filter primi-primi1 (sequence 1 1e7)))
;-> 16863.613

(define (primi-primi2 num)
  (and (prime? (digit-sum num)) (digit-prime? num) (prime? num)))

(time (filter primi-primi2 (sequence 1 1e6)))
;-> 1597.485
(time (filter primi-primi2 (sequence 1 1e7)))
;-> 17514.915

(define (primi-primi3 num)
  (and (prime? (digit-sum num)) (prime? num) (digit-prime? num)))

(time (filter primi-primi3 (sequence 1 1e6)))
;-> 1501.376
(time (filter primi-primi3 (sequence 1 1e7)))
;-> 18769.388

(define (primi-primi4 num)
  (and (prime? num) (prime? (digit-sum num)) (digit-prime? num)))

(time (filter primi-primi4 (sequence 1 1e6)))
;-> 1040.193
(time (filter primi-primi4 (sequence 1 1e7)))
;-> 19257.749

(define (primi-primi5 num)
  (and (digit-prime? num) (prime? (digit-sum num)) (prime? num)))

(time (filter primi-primi5 (sequence 1 1e6)))
;-> 1565.135
(time (filter primi-primi5 (sequence 1 1e7)))
;-> 16855.33


-----------------------------------
Distanza di un punto da un segmento
-----------------------------------

Determinare la distanza tra un punto P(x,y) e un segmento S((x1,y1) (x2,y2)).
Possono verificarsi tre casi:

 Caso 1         | Caso 2         | Caso 3
---------------------------------|----------------
                |         p0     |
                |          *     |
    p1    p0    |     p1         |   p1
     \     *    |       \        |     \
   p3 *         |        \       |      \
       \        |         \      |       \
        \       |          \     |        \
         \      |           \    |         \
         p2     |           p2   |         p2   p0
                |                |               *

Nel caso 1, il punto del segmento più vicino a p0 è p3 (proiezione).
Nel caso 2, il punto del segmento più vicino a p0 è p1.
Nel caso 3, il punto del segmento più vicino a p0 è p2.

Chiamiamo il nostro punto p0 e i punti che definiscono la retta come p1 e p2.
Calcoliamo i vettori a = p0 - p1 e b = p2 - p1.
"param" è il valore scalare che moltiplicato per b dà il punto sulla linea più vicino a p0.
se "param" <= 0, il punto più vicino è p1.
se "param" >= 1, il punto più vicino è p2.
se "param" è compreso tra 0 e 1, il punto è compreso tra p1 e p2, quindi interpoliamo.
xx e yy è quindi il punto più vicino sul segmento di retta.
dx/dy è il vettore da p0 a quel punto e infine restituiamo la lunghezza di quel vettore.

Il prodotto scalare "dot" diviso per la lunghezza al quadrato "len-sq" fornisce la distanza di proiezione da (x1, y1).
Questa è la frazione della retta a cui il punto (x,y) è più vicino.
dx e dy è la proiezione del punto (x,y) sul segmento (x1,y1), (x2,y2).

(define (dist-point-line p s)
  (local (x y x1 y1 x2 y2 a b c d dot len-sq param xx yy dx dy)
    (set 'x (p 0) 'y (p 1))
    (set 'x1 (s 0 0) 'y1 (s 0 1) 'x2 (s 1 0) 'y2 (s 1 1))
    (setq a (sub x x1))
    (setq b (sub y y1))
    (setq c (sub x2 x1))
    (setq d (sub y2 y1))
    (setq dot (add (mul a c) (mul b d)))
    (setq len-sq (add (mul c c) (mul d d)))
    (setq param -1)
    (if (!= len-sq 0)
        (setq param (div dot len-sq))
    )
    (cond ((< param 0) ;caso 2
            (set 'xx x1 'yy y1))
          ((> param 1) ;caso 3
            (set 'xx x2 'yy y2))
          (true        ;caso 1
            (setq xx (add x1 (mul param c)))
            (setq yy (add y1 (mul param d))))
    )
    (setq dx (sub x xx)) ; p3 = (dx, dy)
    (setq dy (sub y yy)) ; p3 = (dx, dy)
    (println xx { } yy)
    (sqrt (add (mul dx dx) (mul dy dy)))))

Facciamo alcune prove:

p1=(1,4)
p2=(4,1)
p0=(3,4), p0=(2,6), p0=(5,-1)

(dist-point-line '(3 4) '((1 4) (4 1)))
;-> 2 3
;-> 1.414213562373095

(dist-point-line '(2 6) '((1 4) (4 1)))
;-> 1 4
;-> 2.23606797749979

(dist-point-line '(5 -1) '((1 4) (4 1)))
;-> 4 1
;-> 2.23606797749979

Verifichiamo i risultati:

(define (dist2d x1 y1 x2 y2)
"Calculates 2D Cartesian distance of two points P1 = (x1 y1) and P2 = (x2 y2)"
  (sqrt (add (mul (sub x1 x2) (sub x1 x2))
             (mul (sub y1 y2) (sub y1 y2)))))

Distanza p0=(3 4), p3:
(dist2d 3 4 2 3)
;-> 1.414213562373095

Distanza p0=(2 6), p1:
(dist2d 2 6 1 4)
;-> 2.23606797749979

Distanza p0=(5 -1), p2:
(dist2d 5 -1 4 1)
;-> 2.23606797749979


-------------------------------------------
Sostituire globalmente il testo in più file
-------------------------------------------

Funzione che modifica "str-old" in "str-new" in un file:

(define (replace-in-file filename str-old str-new)
   (setq data (read-file filename))
   (when (string? data)
     (replace str-old data str-new)
     (write-file filename data)
   )
)

Per ottenere la lista dei file di una cartella possiamo scrivere:

(clean directory? (directory (real-path)))

Oppure possiamo elencare i file in una lista:

(setq files '("a.txt" "b.txt" "c.txt" "d.txt"))

I file "a.txt", "b.txt" e "c.txt" si trovano nella cartella "data".

Adesso modifichiamo tutti file della lista:

(dolist (fname files)
   (replace-in-file fname "programming language" "linguaggio di programmazione")
   ;(replace-in-file fname "linguaggio di programmazione" "programming language")
)
;-> nil

Nota: il file "d.txt" non esiste, ma non genera un errore (data = nil).


-----------------------------
Copiare da "stdin" a "stdout"
-----------------------------

Creare una funzione che copia da "stdin" a "stdout".

Handle di default dei file
--------------------------
- standard input:  stdin = 0
- standard output: stdout = 1
- standard error:  stderr = 2

EOF
---
Per Windows, il carattere di EOF è Ctrl-Z.
Per Linux e OS X, il carattere di EOF è Ctrl-D.

Poiché l'input della console è spesso orientato alla riga, il sistema potrebbe anche non riconoscere il carattere EOF finché non viene seguito da un "Enter".
Inoltre è possibile che, se un carattere viene riconosciuto come EOF, allora il programma potrebbe non vedere il carattere effettivo.
Invece, un programma C si ottiene -1 da getchar().

#include <stdio.h>
int main(){
  char c;
  while ( (c=getchar()) != EOF ){
    putchar(c);
  }
  return 0;
}

In newLISP possiamo scrivere una funzione simile:

; premere CTRL-Z e poi Enter per terminare il programma
(define (read-string)
  (while (!= (setq c (read-char)) EOF)
    (write-char 1 c)))

(read-string)
;-> asdfsdaf
;-> asdfsdaf
;-> adsfsdfasdf
;-> adsfsdfasdf
;-> fggghhhdddds
;-> fggghhhdddds
;-> ^Z
;-> 1

Nota: Premendo CTRL-Z e poi Enter dal prompt di newLISP provoca la chiusura immediata della REPL.


------------------------------------------------------------
Eliminare/cambiare caratteri di una stringa (trim e replace)
------------------------------------------------------------

Problema: eliminare caratteri all'inizio e/o alla fine di una stringa
---------------------------------------------------------------------
Per questo possiamo usare la funzione primitiva "trim".

(setq str "   this is a string   ")

;; trim leading blanks
(trim str " " "")
;-> "this is a string   "

;; trim trailing blanks
(trim str "" " ")
;-> "   this is a string"

;; trim both leading and trailing blanks
(trim str)
;-> "this is a string"

Vediamo la definizione di "trim" dal manuale:

*****************
>>>funzione TRIM
*****************
sintassi: (trim str)
sintassi: (trim str str-char)
sintassi: (trim str str-left-char str-right-char)

Usando la prima sintassi, tutti i caratteri spazio " " vengono tagliati da entrambi i lati di str.

La seconda sintassi taglia la stringa str da entrambi i lati, eliminando i caratteri iniziali e finali contenuti in str-char.
Se str-char non contiene alcun carattere, viene assunto il carattere spazio.
trim restituisce la nuova stringa.

La terza sintassi può tagliare caratteri diversi da entrambi i lati o tagliare solo un lato se viene specificata una stringa vuota per l'altro.

(trim " hello \n ")
;-> "hello"
(trim " h e l l o ")
;-> "h e l l o")
(trim "----hello-----" "-")
;-> "hello"
(trim "00012340" "0" "")
;-> "12340"
(trim "1234000" "" "0")
;-> "1234"
(trim "----hello=====" "-" "=")
;-> "hello"

Per casi più complessi è possibile utilizzare la funzione "replace".
Quando possibile, è preferibile usare "trim" che è molto più veloce.

Problema: eliminare caratteri in tutta una stringa
--------------------------------------------------
Per questo possiamo usare la funzione primitiva "replace".

(setq str "She was a soul stripper. She took my heart!")

(replace "[aei]" str "" 0)
;-> "Sh ws  soul strppr. Sh took my hrt!"

Vediamo la definizione di "replace" dal manuale:

*******************
>>>funzione REPLACE
*******************
liste
sintassi: (replace exp-key list exp-replacement [func-compare])
sintassi: (replace exp-key list)

stringhe
sintassi: (replace str-key str-data exp-replacement)
sintassi: (replace str-pattern str-data exp-replacement regex-option)

Sostituzione nelle liste
------------------------
Se il secondo argomento è una lista, "replace" sostituisce tutti gli elementi nella lista list che sono uguali all'espressione in exp-key. L'elemento viene sostituito con exp-replacement. Se manca exp-replacement, tutte le istanze di exp-key verranno eliminate dalla lista.

Si noti che "replace" è distruttiva. Cambia la lista passato ad esso e restituisce la lista modificata. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count quando la funzione ritorna. Durante l'esecuzione delle sostituzioni delle espressioni, la variabile di sistema anaforica $it è impostata sull'espressione da sostituire.

Facoltativamente, func-compare può specificare un operatore di confronto o una funzione definita dall'utente. Per impostazione predefinita, func-compare è il = (segno di uguale).

;; list replacement

(set 'aList '(a b c d e a b c d))

(replace 'b aList 'B)
;-> (a B c d e a B c d)
aList
;-> (a B c d e a B c d)
$count
;-> 2  ; number of replacements

;; list replacement with special compare functor/function

; replace all numbers where 10 < number
(set 'L '(1 4 22 5 6 89 2 3 24))

(replace 10 L 10 <)
;-> (1 4 10 5 6 10 2 3 10)
$count
;-> 3

; same as:

(replace 10 L 10 (fn (x y) (< x y)))
;-> (1 4 10 5 6 10 2 3 10)

; change name-string to symbol, x is ignored as nil

(set 'AL '((john 5 6 4) ("mary" 3 4 7) (bob 4 2 7 9) ("jane" 3)))

(replace nil AL (cons (sym ($it 0)) (rest $it))
                (fn (x y) (string? (y 0)))) ; parameter x = nil not used
;-> ((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3))

; use $count in the replacement expression
(replace 'a '(a b a b a b) (list $count $it) =)
;-> ((1 a) b (2 a) b (3 a) b)

Utilizzando le funzioni "match" e "unify" è possibile formulare ricerche sulla lista che sono potenti come le ricerche con le espressioni regolari sulle stringhe:

; calculate the sum in all associations with 'mary

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(mary *)  AL (list 'mary (apply + (rest $it))) match)
;-> ((john 5 6 4) (mary 14) (bob 4 2 7 9) (jane 3))
$count
;-> 1

; make sum in all expressions

(set 'AL '((john 5 6 4) (mary 3 4 7) (bob 4 2 7 9) (jane 3)))

(replace '(*) AL (list ($it 0) (apply + (rest $it))) match)
;-> ((john 15) (mary 14) (bob 22) (jane 3))
$count
;-> 4

; using unify, replace only if elements are equal
(replace '(X X) '((3 10) (2 5) (4 4) (6 7) (8 8)) (list ($it 0) 'double ($it 1)) unify)
;-> ((3 10) (2 5) (4 double 4) (6 7) (8 double 8))

Eliminazione nelle liste
------------------------
L'ultima forma di "replace" per le liste ha solo due argomenti: l'espressione exp e la lista list. Questa forma rimuove tutte le espressioni exp trovate nella lista.

;; removing elements from a list

(set 'lst '(a b a a c d a f g))
(replace 'a lst)
;-> (b c d f g)
lst
;-> (b c d f g)

$count
;-> 4

Sostituzione nelle stringhe senza espressioni regolari
------------------------------------------------------
Se tutti gli argomenti sono stringhe, "replace" sostituisce tutte le occorrenzw di str-key in str-data con l'espressione valutata exp-replacement e ritorna la stringa modificata. L'espressione in exp-replacement viene valutata per ogni sostituzione. Il numero di sostituzioni effettuate è contenuto nella variabile di sistema $count. Questa forma di "replace" può processare anche gli 0 (zero) binari.

;; string replacement
(set 'str "this isa sentence")
(replace "isa" str "is a")
;-> "this is a sentence"
$count
;-> 1

Sostituzione con le espressioni regolari
----------------------------------------
La presenza di un quarto parametro indica che deve essere effettuata una ricerca con le espressioni regolari il cui modello/pattern viene specificato da str-pattern e da un numero, regex-option, che specifica l'opzione della regex (es. 1 (one) o "i" per ricerche case-insensitive o 0 (zero) per una ricerca standard PCRE (Perl Compatible Regular Expression) senza opzioni). Vedi anche "regex" per maggiori dettagli.

Per default, "replace" sostituisce tutte le occorrenze nella stringa anche se viene inclusa la specifica di beginning-of-line nel modello/pattern di ricerca. Dopo ogni sostituzione, parte una nuova ricerca dalla nuova posizione in str-data. Impostare il bit di opzione a 0x8000 in regex-option costringe "replace" ad sostituire solo la prima occorrenza. La stringa modificata viene restituita.

"replace" con le espressioni regolari imposta anche le variabili di sistema $0, $1 e $2 con il contenuto della espressione e delle sotto-espressioni trovate. La variabile anaforica di sistema $it ha lo stesso valore di $0. Queste variabili possono essere usate per sostituzioni che dipendono dal contenuto dell'espressione trovata durante la sostituzione. I simboli $0, $1, $2 e $it possono essere usati nelle espressioni come tutti gli altri simboli. L'espressione di sostituzione valuta su un valore diverso da una stringa, allora non viene effettuata alcuna sostituzione. In alternativa, si può accedere al contenuto di queste variabili utilizzando ($ 0), ($ 1), ($ 2), ecc. Questo metodo permette l'accesso indicizzato (es ($ i), dove i è un intero) .

Dopo che sono state effettuate tutte le sostituzioni, il numero di sostituzioni è contenuto nella variabile di sistema $count.

;; using the option parameter to employ regular expressions

(set 'str "ZZZZZxZZZZyy")
;-> "ZZZZZxZZZZyy"
(replace "x|y" str "PP" 0)
;-> "ZZZZZPPZZZZPPPP"
str
;-> "ZZZZZPPZZZZPPPP"

;; using system variables for dynamic replacement

(set 'str "---axb---ayb---")
(replace "(a)(.)(b)" str (append $3 $2 $1) 0)
;-> "---bxa---bya---"

str
;-> "---bxa---bya---"

;; using the 'replace once' option bit 0x8000

(replace "a" "aaa" "X" 0)
;-> "XXX"

(replace "a" "aaa" "X" 0x8000)
;-> "Xaa"

;; URL translation of hex codes with dynamic replacement

(set 'str "xxx%41xxx%42")
(replace "%([0-9A-F][0-9A-F])" str
               (char (int (append "0x" $1))) 1)
;-> xxxAxxxB
str
;-> "xxxAxxxB"

$count
;-> 2

La funzione "setf" insieme a "nth", "first" o "last" possono anche essere usate per modificare gli elementi in una lista.

Vedi anche "directory", "find", "find-all", "parse", "regex" e "search" per le altre funzioni che usano le espressioni regolari.

Come abbiamo visto la funzione "replace" sostituisce gli elementi utilizzando una stringa di ricerca. Quando dobbiamo effettuare sostituzioni con diverse stringhe di ricerca occorre applicare la funzione "replace" per ognuna di queste stringhe. Per esempio:

(setq text "albero mela cucina pesce")
(replace "albero" text "pera" 0)
;-> "pera mela cucina pesce"
(replace "cucina" text "formaggio" 0)
;-> "pera mela formaggio pesce"

Possiamo accoppiare e mettere tutte le stringhe di ricerca e modifica in una lista e poi utilizzare la seguente espressione:

(setq text "albero mela cucina pesce")
(setq repls '(("albero" "pera") ("cucina" "formaggio")))

(dolist (r repls)
    (replace (first r) text (last r)))
;-> "pera mela formaggio pesce"

Per utilizzare questo metodo, Lutz ha fornito la seguente macro:

(define-macro (replace-all)
    (dolist (r (eval (args 0)))
        (replace (first r) (eval (args 1)) (last r))))

(setq text "albero mela cucina pesce")
;-> "albero mela cucina pesce"
(replace-all repls text)
;-> "pera mela formaggio pesce"
text
"pera mela formaggio pesce"

Risulta comodo accoppiare le modifiche nel caso ce ne siano parecchie da effettuare.

Se vogliamo usare una funzione al posto della macro:

(define (replace-all-fn repls text)
    (dolist (r repls)
        (replace (first r) text (last r))
    )
    text)

(setq text "albero mela cucina pesce")
;-> "albero mela cucina pesce"
(replace-all-fn repls text)
;-> "pera mela formaggio pesce"
In questo caso "text" non viene modificato.
text
;-> "albero mela cucina pesce"


--------------------------------------------------
Problema delle Somme quadrate (Square-Sum problem)
--------------------------------------------------

Ordinare i numeri da 1 a 15 in modo che la somma di due numeri consecutivi è sempre un quadrato.

Algoritmo:
Disegniamo un grafo con il nodo 1 al centro.
Per ogni nodo, iteriamo sugli interi da 2 a 15, disegnando le connessioni e i nodi tra interi che si sommano in quadrati.
Dopo aver costruito il grafo, dobbiamo trovare un percorso che visita ogni nodo esattamente una volta.
Questo tipo di percorso è chiamato percorso hamiltoniano.
Individuare questi percorsi in un grafo è un problema noto e richiede il test di tutti i percorsi possibili (NP-complete).
Sebbene sia computazionalmente impegnativo, trovare un percorso hamiltoniano nel nostro grafo risolve esattamente il problema.

La costruzione del grafo è la seguente:

  +----+     +----+     +----+     +----+
  | 13 |-----| 12 |-----|  4 |-----|  5 |
  +----+     +----+     +----+     +----+
     |                                |
     |                                |
  +----+     +----+     +----+     +----+
  |  3 |-----|  6 |-----| 10 |     | 11 |
  +----+     +----+     +----+     +----+
     |                     |          |
     |                     |          |
  +----+                +----+     +----+
  |  1 |----------------| 15 |     | 14 |
  +----+                +----+     +----+
     |                                |
     |                                |
  +----+     +----+     +----+     +----+
  |  8 |     |  9 |-----|  7 |-----|  2 |
  +----+     +----+     +----+     +----+

La soluzione (percorso che visita tutti i nodi una sola volta) è la seguente:

(setq sol '(8 1 15 10 6 3 13 12 4 5 11 14 2 7 9))

Per quali numeri (n) è possibile disporre i numeri da 1 a n in forma "square-sum"?

La seguente tabella mostra che questi numeri sono 15, 16, 17, 23 e tutti i numeri dal 25 in poi.

0: non è possibile
1: è possibile

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 |
| --|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10| 11| 12| 13| 14| 15|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
| 1 | 1 | 0 | 0 | 0 | 0 | 0 | 1 | 0 | 1 | 1 | 1 | 1 | 1 | 1 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| 16| 17| 18| 19| 20| 21| 22| 23| 24| 25| 26| 27| 28| 29| 30|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+

+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+----+----+
| 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |  1 |  1 |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|----|----|
| 31| 32| 33| 34| 35| 36| 37| 38| 39| 40| 41| 42| 43| 44| 45| ...| inf|
+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+----+----+

Dimostrazione di R. Gerbicz disponibile al seguente indirizzo:
https://www.mersenneforum.org/showthread.php?t=22915
in cui si trova anche un programma in C che genera le sequenze in forma "square-sum" fino a n < 2^63.

Scriviamo una funzione per verificare se una lista di numeri è in forma "square-sum":

Funzione che verifica se un numero è un quadrato:

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

Funzione che somma tutte le coppie consecutive di una lista di numeri:

(define (pair-sums lst)
  (map + (chop lst) (rest lst)))

(setq a '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15))

(pair-sums a)
;-> (3 5 7 9 11 13 15 17 19 21 23 25 27 29)

Funzione che verifica se una lista di numeri è in forma "square-sum":

(map square? (pair-sums a))
;-> (nil nil nil true nil nil nil nil nil nil nil true nil nil)
(apply and (map square? (pair-sums a)))
;-> nil

(map square? '(4 9 16 81))
;-> (true true true true)
(apply and (map square? '(4 9 16 81)))
;-> true

(define (all-square? lst)
  (apply and (map square? (pair-sums lst))))

Verifichiamo la soluzione del problema:

(all-square? sol)
;-> true


---------
Brainfuck
---------

Codice from Rosetta Code website:
https://rosettacode.org/wiki/Execute_Brain****#NewLISP

; This module translates a string containing a
; Brainf*** program into a list of NewLISP expressions.
; Attempts to optimize consecutive +, -, > and < operations
; as well as bracket loops.

; Create a namespace and put the following definitions in it

(context 'BF)

; If BF:quiet is true, BF:run will return the output of the
; Brainf*** program

(define quiet)

; If BF:show-timing is true, the amount of milliseconds spent
; in 'compiling' (actually translating) and running the
; resulting program will be shown

(define show-timing true)

; The Brainf*** program as a string of characters

(define src "")

; Checks for correct pairs of brackets

(define (well-formed?)
  (let (p 0)
    (dostring (i src (> 0 p))
      (case i
  ("[" (++ p))
  ("]" (-- p))))
    (zero? p)))

; Translate the Brainf*** command into S-expressions

(define (_compile)
  (let ((prog '())
  ; Translate +
  (incr '(++ (tape i) n))
  ; Translate -
  (decr '(-- (tape i) n))
  ; Translate .
        (emit (if quiet
    '(push (char (tape i)) result -1)
                '(print (char (tape i)))))
  ; Translate ,
  (store '(setf (tape i) (read-key)))
  ; Check for loop condition
  (over? '(zero? (tape i)))
  ; Current character of the program
  (m)
  ; Find how many times the same character occurs
  (rep (fn ((n 1))
     (while (= m (src 0))
     (++ n)
     (pop src))
       n)))
    ; Traverse the program and translate recursively
    (until (or (empty? src) (= "]" (setq m (pop src))))
     (case m
       (">" (push (list '++ 'i (rep)) prog -1))
       ("<" (push (list '-- 'i (rep)) prog -1))
       ("+" (push (expand incr '((n (rep))) true) prog -1))
       ("-" (push (expand decr '((n (rep))) true) prog -1))
       ("." (push emit prog -1))
       ("," (push store prog -1))
       ("[" (push (append (list 'until over?)
        (_compile))
      prog -1))))
    prog))

(define (compile str , tim code)
  (setq src (join
  (filter (fn (x)
        (member x '("<" ">" "-" "+"
        "." "," {[} {]})))
    (explode str))))
  ; Throw an error if the program is ill-formed
  (unless (well-formed?)
    (throw-error "Unbalanced brackets in Brainf*** source string"))
  (setq tim (time (setq code (cons 'begin (_compile)))))
  (and show-timing (println "Compilation time: " tim))
  code)

; Translate and run
; Tape size is optional and defaults to 30000 cells

(define (run str (size 30000))
  (let ((tape (array size '(0)))
   (i 0)
   (result '())
   (tim 0)
   (prog (compile str)))
    (setq tim (time (eval prog)))
    (and show-timing (println "Execution time: " tim))
    (and quiet (join result))))

; test - run it with (BF:test)

(define (test)
  (run "++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>."))

(BF:test)
;-> Compilation time: 0
;-> Hello World!
;-> Execution time: 0.997
;-> nil

; to interpret a string of Brainf*** code, use (BF:run <string>)
; to interpret a Brainf*** code file, use (BF:run (read-file <path-to-file>))


----------------------
Problema del serbatoio
----------------------

Abbiamo un serbatoio con capacità C litri riempito completamente in partenza.
All'inizio di ogni giorno il serbatoio viene riempito con l litri d'acqua.
Nel caso di superamento della capacità, l'acqua in eccesso viene dispersa.
Ogni i-esimo giorno vengono prelevati i litri d'acqua.
Quanti giorni occorrono per svuotare il serbatoio?

(define (add-water litri)
  (setq c (min (+ c litri) max-c)))

(define (remove-water litri)
  (setq c (- c litri)))

(define (tank c l)
  (local (max-c day)
    ; capacità massima del serbatoio
    (setq max-c c)
    (setq day 0)
    ; fino a che il berbatoio non è vuoto...
    (while (> c 0)
      (++ day 1)
      ; inizio giornata
      (add-water l)
      ; fine giornata
      (remove-water day)
    )
    day))

Facciamo alcune prove:

(tank 5 2)
;-> 4

(tank 1111 10)
;-> 57

Il problema può essere risolto matematicamente:
Assumiamo C > L.
Sia d la quantità di giorni dopo in cui il serbatoio si svuota.
Durante questo periodo, ci saranno (d-1) ricariche e d prelievi.
Quindi dobbiamo risolvere questa equazione:

C + (d - 1)*L = Sum(i=1,d)[Ritiro(i)]

La somma di tutti i prelievi è una progressione aritmetica, quindi:

C + (d - 1)*L = 2*(L + 1 + L + d)/2

2C + 2dL - 2L = 2dL + d + d^2

d^2 + d - 2*(C - L) = 0

Discriminante = 1 + 8*(C - L) > 0, perché C > L.

Eliminando la radice negativa, otteniamo la seguente formula:

           sqrt(1 + 8*(C - L))
d = -1 + ---------------------
                   2

Pertanto, la risposta finale è:

                       sqrt(1 + 8*(C - L)) - 1
min-giorni = L + ceil(-------------------------)
                                  2

(define (tank-fn c l)
  (add l (ceil (div (sub (sqrt(add 1 (mul 8 (sub c l)))) 1) 2))))

Facciamo alcune prove:

(tank-fn 5 2)
;-> 4
(tank-fn 1111 10)
;-> 57

(tank 100 5)
;-> 19
(tank-fn 100 5)
;-> 19
(tank 6514683 4965)
;-> 8573
(tank-fn 6514683 4965)
;-> 8573


-----------------------------
Alcuni chiarimenti su newLISP
-----------------------------

Dal forum di newLISP:

Sunburned Surveyor
------------------
I had a couple of questions about the newLisp syntax I was hoping you guys could help with.

(1) I believe a symbol is like a variable in other languages. It is a named container that holds a value. Is this correct?

(2) What is the difference between a symbol and a constant?

(3) On page 13 pf the reference manual it discusses resetting the value of the integer math operators. It has the following LISP statement:

(constant '+ add)

I realize this statement is setting the value of the "+" operator to the add function, but what is the purpose of the single quote? Are we using that to refer to the name "+" rather than evauluating it as a math operator?

(4) Is init.lsp used to load a set of user defined functions for the newLisp compiler/IDE?

(5) I did some on-line research about Lambda ecpressions. I want to make sure I understand them correctly. Is the following true:

A Lambda expression defines a function temporarily. The first part of the expression must be the symbol name Lambda, the second is a parameter/argument list, and the thirs is the expression that operates on the arguments.

HPW
---
>(1) I believe a symbol is like a variable in other languages. It is a named container that holds a value. Is this correct?

Not only a value. It can also contain a function or list. There is no sharp frontier between code and data in lisp. It is one of the powerfull features and can be used for code generation at runtime.

>(2) What is the difference between a symbol and a constant?

The constant is protected against overwriting and the symbol not.

>I realize this statement is setting the value of the "+" operator to the add function, but what is the purpose of the single quote? Are we using that to refer to the name "+" rather than evauluating it as a math operator?

The quote prevent the symbol against evaluation to its content. You can also write (constant (quote +) add). It is the same.

>(4) Is init.lsp used to load a set of user defined functions for the newLisp compiler/IDE?

It is used to load your own function into the newlisp enviroment. It is not primaly used for the IDE.

Eddier
------
Coming from the imperative side of things, I also faced such challenges. The biggest one for me was (f x0 x1 ... xn) in Lisp == f(x0, x1, ..., xn) in Python, Perl, C, Java, etc,... Once I figured out that the first thing after the beginning "(" was an operation that operated on everything up to the ")" I started to get into it a bit. Then I realized to build programs in the functional world, just compose the functions. In the mathematical and imperative world (g comp f)(x) = g(f(x)), but in lisp it's just (g (f x)) => first apply f to x then apply g to whatever f left. This makes a pretty picture. Lisp is just evaluating a tree, the same infix, postfix, prefix trees you learned in that second semester programming course. As example,

(+ 2 3 (* 4 3))

  [+]
 / | \
2  3  [*]
      /  \
    4     3

Or, you can look at it as a bunch of linked lists. Each node has two pieces, in Lutz's model, the left part of the first node is the operation, the right part points to its argument list. The values are in the left part of each node. If the left part of a node is a pointer, then follow that pointer down. This will be a new list to evaluate. The down pointer will always be a function to evaluate unless it is a quote function.

root
 |
 V
[+ : -]-->[2 : -]-->[3 : -]-->[  : nil]
                               |
                               V
                               [* : -]-->[4 : -]-->[3 : -]-->[  : nil]

Lisp will try to evaluate every list even if it doesn't make sense. Sometimes (a bunch of times) you will want to treat a list as data. To do keep lisp from evaluating it, use the quote function or use the short hand of putting a ' in front of the list. Then you can pass a list from one function to the next.
Example

(join '("hello" "world") ":") => "hello:world"

Here join is the function and it's arguments are '("hello" "world") and ":". The reason '("hello" "world") is data and lisp is not trying to evaluate "here" as a function is because of the ' in front.

Lutz
----
You can draw it even simpler:

(+ 2 3 (* 4 3))

[ ]
  \
  [+] -> [2] -> [3] -> [ ]
                         \
                         [*] -> [4] -> [3]

because newLISP has no dotted pairs, a lisp cell has just a contents and the pointer to the next cell.

Eddier
------
I think there should be a "->[ ]" after the "[*]->[4]->[3]" correct?

Lutz
----
In the diagram the [ ] stands for some kind of 'list envelope' for it's members: *, 2, 3 and this envelope itself is a lisp cell the content of which is a pointer to the first list member, in this case the *.

Note: read the tutorial "newLISP in 21 minutes" by John W. Small.
(disponibile in italiano delle Appendici).


-------------------------------------------
La signora degusta il tè (Lady Tasting Tea)
-------------------------------------------

Questo problema si basa su un evento accaduto durante un tea party degli anni '20 a Cambridge.
La storia racconta che una signora (Muriel Bristol) sosteneva la capacità di distinguere tra:
1) una tazza di tè fatta versando il tè in una tazza di latte
2) una tazza di tè fatta versando il latte in una tazza di tè.
Non sorprende che molti fossero scettici e una persona decise di verificarlo.
Fece un esperimento con 8 tazze da tè, composte da 4 tazze di ogni preparato.
Straordinariamente, la signora fu in grado di identificare tutte e 8 le tazze, sollevando il problema se fosse stata solo fortunata.
Quali sono le probabilità di identificare per caso tutte e 8 le coppe?
Il problema è noto come Lady Tasting Tea e ha portato all'analisi moderna dei test di dati sperimentali casuali.

Il problema può essere risolto calcolando le combinazioni di k (4) elementi senza ripetizione da n (8) elementi:

(n k) = n!/(k!*(n - k)!)

(8 4) = 8!/(4!*(8! - 4!)) = 8!/(4!*4!)

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!) (combinations of k elements without repetition from n elements)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(binom 8 4)
;-> 70L

Probabilità di indovinare casualmente tutte le tazze:

(div 1 70)
;-> 0.01428571428571429

Quindi la probabilità di identificare per caso tutte le tazze vale 1/70 (circa 1.42 percento).
Possiamo concludere che la signora probabilmente aveva un gusto estremamente raffinato in grado di riconoscere la composizione delle tazze.


--------------------------------
Partizioni di sequenze di interi
--------------------------------

Gli interi consecutivi da 1 a n sono partizionati in m liste in modo tale che in ogni lista il numero più grande sia uguale alla somma dei numeri rimanenti.
Nota: ogni lista ha almeno 3 elementi: il numero più grande e almeno due numeri per effettuare la somma.

1) Quanti gruppi ci sono se n = 14?
2) Quanti gruppi ci sono se n = 12?

Chiamiamo "leader" il numero più grande di ogni lista.
Possiamo notare che:
a) la somma dei leader deve essere uguale alla metà della somma di tutti i numeri.
b) quindi, se la somma di tutti i numeri è dispari, allora non può esistere nessuna partizione con la proprietà richiesta.

Nel caso 1) Poiché 1 + 2 + ... + 13 + 14 = 105 è un numero dispari, allora non esiste nessuna partizione con la proprietà richiesta.

Nel caso 2) Poiché 1 + 2 + ... + 13 + 14 = 78, la somma dei leader deve essere 39.
Non ci possono essere solo tre gruppi perchè in questo caso la somma massima dei tre leader vale solo 10 + 11 + 12 = 33 < 39.
D'altra parte, se ci sono cinque o più gruppi, alcuni gruppi avranno meno di tre numeri, il che non è possibile.
Quindi il numero dei gruppi deve essere quattro.
Una possibile partizione è (12 9 3), (11 7 4), (10 8 2) e (6 5 1).

Usiamo alcune funzione per automatizzare la ricerca della soluzione.

Funzione che verifica se una lista soddisfa la proprietà, cioè se primo elemento è uguale alla somma di tutti i restanti elementi:

(define (check? lst)
  (sort lst >)
  (= (pop lst) (apply + lst)))

(check? '(10 8 3))
;-> nil
(check? '(11 8 3))
;-> true
(check? '(10 4 3 2 1))
;-> true

(define (comb k lst (r '()))
"Generates all combinations of k elements without repetition from a list of items"
  (if (= (length r) k)
    (list r)
    (let (rlst '())
      (dolist (x lst)
        (extend rlst (comb k ((+ 1 $idx) lst) (append r (list x)))))
      rlst)))

(define (list-break lst lst-len)
"Breaks a list into sub-lists of specified lengths"
  (let ((i 0) (q 0) (res '()))
    (dolist (el lst-len)
      (setq i (+ i q))
      (setq q el)
      (push (slice lst i q) res -1)
    )
    res))

(define (groups gs lst)
"Groups the elements of a list into disjoint sublists"
  (local (tmp out)
    ;------------------------
    (define (loop gs xss lst)
      (cond ((null? gs) xss)
            ((null? xss) '())
            (true
            (letn ((xs (first xss)) (leftover (filter (lambda (e) (not (member e xs))) lst)))
              ;(append (map (lambda (ys) (list xs ys)))
              (append (map (lambda (ys) (flat (list xs ys)))
                            (loop (rest gs) (comb (first gs) leftover) leftover))
                      (loop gs (rest xss) lst))))))
    ;------------------------
    (setq tmp (loop (rest gs) (comb (first gs) lst) lst))
    (setq out '())
    (dolist (g tmp)
    ;(dolist (g (loop (rest gs) (comb (first gs) lst) lst))
    (push (list-break g gs) out -1)
    )
    out))

(groups '(1 2 2) '(1 2 3 4 5))
;-> (((1) (2 3) (4 5)) ((1) (2 4) (3 5)) ((1) (2 5) (3 4)) ((1) (3 4) (2 5))
;->  ((1) (3 5) (2 4)) ((1) (4 5) (2 3)) ((2) (1 3) (4 5)) ((2) (1 4) (3 5))
;->  ((2) (1 5) (3 4)) ((2) (3 4) (1 5)) ((2) (3 5) (1 4)) ((2) (4 5) (1 3))
;->  ((3) (1 2) (4 5)) ((3) (1 4) (2 5)) ((3) (1 5) (2 4)) ((3) (2 4) (1 5))
;->  ((3) (2 5) (1 4)) ((3) (4 5) (1 2)) ((4) (1 2) (3 5)) ((4) (1 3) (2 5))
;->  ((4) (1 5) (2 3)) ((4) (2 3) (1 5)) ((4) (2 5) (1 3)) ((4) (3 5) (1 2))
;->  ((5) (1 2) (3 4)) ((5) (1 3) (2 4)) ((5) (1 4) (2 3)) ((5) (2 3) (1 4))
;->  ((5) (2 4) (1 3)) ((5) (3 4) (1 2)))

(groups '(2 3) '(1 2 3 4 5))
;-> (((1 2) (3 4 5)) ((1 3) (2 4 5)) ((1 4) (2 3 5)) ((1 5) (2 3 4))
;->  ((2 3) (1 4 5)) ((2 4) (1 3 5)) ((2 5) (1 3 4)) ((3 4) (1 2 5))
;->  ((3 5) (1 2 4)) ((4 5) (1 2 3)))

Nota: Se la lista delle parti contiene solo 1, allora la funzione "groups" genera gli stessi elementi della funzione che calcola le permutazioni "perm":

(length (groups '(1 1 1 1 1 1) '(1 2 3 4 5 6)))
;-> 720
(length (perm '(1 2 3 4 5 6)))
;-> 720

Scriviamo una funzione che verifica se una data sequenza e un determinato numero di gruppi possono soddisfare la proprietà:

(define (test num gruppi)
  (local (seq somma-seq semi-somma-seq leaders somma-leaders
          min-elements out)
    (setq out "")
    ; sequenza
    (setq seq (sequence 1 num))
    ; lunghezza sequenza
    (setq len-seq num)
    ; somma sequenza
    (setq somma-seq (apply + seq))
    ; semi-somma sequenza
    (setq semi-somma-seq (/ somma-seq 2))
    ; estrazione dei leaders (ultimi elementi della sequenza)
    (if (>= len-seq gruppi)
      (setq leaders (slice seq (- gruppi)))
      (setq leaders seq)
    )
    ; somma dei leaders
    (setq somma-leaders (apply + leaders))
    ; numeri minimo di elementi necessari
    ; (ogni gruppo deve avere almeno 3 elementi:
    ;  il leader e altri due elementi da sommare)
    (setq min-elements (* gruppi 3))
    ; deve risultare numero gruppi <= numero elementi della sequenza
    (cond ((> gruppi len-seq)
            (setq out "impossible"))
          ; la somma dei numeri della sequenza deve essere pari
          ((odd? somma-seq)
            (setq out "impossible"))
          ; la somma dei leaders deve essere maggiore o uguale
          ; alla somma degli elementi restanti.
          ((> semi-somma-seq somma-leaders)
            (setq out "impossible"))
          ; il numero minimo di elementi necessari deve essere
          ; minore o uguale al numero di elementi della sequenza
          ((> min-elements len-seq)
            (setq out "impossible"))
          (true
            (setq out "*** possible ***"))
    )
    out))

Facciamo alcune prove:

(test 12 5)
;-> "impossible"
(test 12 4)
;-> "*** possible ***"
(test 19 6)
;-> "*** possible ***"

Calcoliamo i valori "possibili" per sequenze di lunghezza da 12 a 20 e con numero di gruppi da 1 a 8:

(println "seq gruppi")
(for (i 12 20)
  (for (j 1 8)
    (println i {  } j { } (test i j))))

;-> seq gruppi
;-> 12  1 impossible
;-> 12  2 impossible
;-> ...
;-> 12  4 *** possible ***
;-> ...
;-> 15  5 *** possible ***
;-> ...
;-> 16  5 *** possible ***
;-> ...
;-> 19  6 *** possible ***
;-> ...
;-> 20  6 *** possible ***
;-> 20  7 impossible
;-> 20  8 impossible

Adesso scriviamo una funzione che cerca le liste che soddisfano la proprietà.
Generiamo tutte le possibili partizioni/raggruppamenti con la funzione "groups" per una determinata lista dei gruppi e una determinata sequenza, poi verifichiamo ogni partizione per vedere se verifica la proprietà (in ogni lista il numero più grande deve essere uguale alla somma dei numeri rimanenti).
Per esempio, data la sequenza (1 2 3 4 5 6 7 8 9 10 11 12) e la lista dei gruppi (3 3 3 3), una partizione è del tipo:
 ((12 11 1) (10 8 6) (9 5 3) (7 4 2))
quindi verifichiamo che se ogni sottolista della partizione verifica la proprietà. In tal caso la partizione è una soluzione.

(define (cerca gruppi seq)
  (local (out gr)
    (setq out '())
    ; calcolo delle partizioni/raggruppamenti
    (setq gr (groups gruppi seq))
    (println "ciclo...")
    ; ciclo sulle partizioni per il controllo della proprietà
    (dolist (g gr)
      ; tutti true il (check?) su ogni sottolista?
      (if (apply and (map check? g))
          ; ordiniamo gli elementi della partizione/soluzione corrente
          ; e la inseriamo nella lista delle soluzioni
          (push (sort (map (fn(x) (sort x >)) g) >) out -1)
      )
    )
    ; elimina le soluzioni multiple
    (unique out)
  )
)

Quanto tempo ci mette "groups" a calcolare la partizioni/raggruppamenti ?

(time (println (length (groups '(3 3 3 3) (sequence 1 12)))))
;-> 369600
;-> 23395.352 ; quasi 24 secondi

Verifichiamo la sequenza del problema:
sequenza: (1 2 3 4 5 6 7 8 9 10 11 12)
lista dei gruppi: (3 3 3 3)

(time (println (cerca '(3 3 3 3) (sequence 1 12))))
;-> ciclo...
;-> (((12 9 3) (11 7 4) (10 8 2) (6 5 1))
;->  ((12 8 4) (11 9 2) (10 7 3) (6 5 1))
;->  ((12 10 2) (11 8 3) (9 5 4) (7 6 1))
;->  ((12 10 2) (11 6 5) (9 8 1) (7 4 3))
;->  ((12 7 5) (11 8 3) (10 9 1) (6 4 2))
;->  ((12 8 4) (11 10 1) (9 6 3) (7 5 2))
;->  ((12 11 1) (10 7 3) (9 5 4) (8 6 2))
;->  ((12 11 1) (10 6 4) (9 7 2) (8 5 3)))
;-> 33191.995

Abbiamo trovato 8 soluzioni al problema.

Proviamo con la sequenza fino a 15 e con 5 gruppi:

(time (println (cerca '(3 3 3 3 3) (sequence 1 15))))
;-> ERR: call or result stack overflow in function extend : comb
;-> called from user function (comb k ((+ 1 $idx) lst) (append r (list x)))
;-> called from user function (comb k ((+ 1 $idx) lst) (append r (list x)))
;-> called from user function (comb (first gs) leftover)
;-> called from user function (loop (rest gs) (comb (first gs) leftover) leftover)
;-> called from user function (loop gs (rest xss) lst)

Bisognerebbe provare con uno stack più grande: newlisp -s <stacksize>
Maximum call stack constant: 2048 (default)


---------------------
Punteggi scacchistici
---------------------

Giocando N partite a scacchi, in quanti modi possiamo fare P punti?

Il punteggio di una partita a scacchi è il seguente:
  - 1 punto per la vittoria
  - 0.5 punti per una patt
  - 0 punti per una sconfitta

Giocando N partite con 3 risultati possiamo utlizzare le permutazioni per generare tutti i possibili risultati.

(define (perm-rep k lst)
"Generates all permutations of k elements with repetition from a list of items"
  (if (zero? k) '(())
      ;(flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
      (flat (map (lambda (p) (map (lambda (e) (cons e p)) lst))
                         (perm-rep (- k 1) lst)) 1)))

Se giochiamo 3 partite possiamo ottenere i seguenti risultati:

(perm-rep 3 '(1 0.5 0))
;-> ((1 1 1) (0.5 1 1) (0 1 1) (1 0.5 1) (0.5 0.5 1) (0 0.5 1)
;->  (1 0 1) (0.5 0 1) (0 0 1) (1 1 0.5) (0.5 1 0.5) (0 1 0.5)
;->  (1 0.5 0.5) (0.5 0.5 0.5) (0 0.5 0.5) (1 0 0.5) (0.5 0 0.5)
;->  (0 0 0.5) (1 1 0) (0.5 1 0) (0 1 0) (1 0.5 0) (0.5 0.5 0)
;->  (0 0.5 0) (1 0 0) (0.5 0 0) (0 0 0))

Adesso scriviamo una funzione che calcola tutti i possibili risultati e crea una lista con elementi che hanno la seguente struttura:

  (somma-risultati (lista-risultati)

(define (possible-results games)
    (sort (map (fn(x) (list (apply add x) x)) (perm-rep games '(1 0.5 0)))))

Giocando 3 partite otteniamo:

(possible-results 3)
;-> ((0 (0 0 0))
;->  (0.5 (0 0 0.5))
;->  (0.5 (0 0.5 0))
;->  (0.5 (0.5 0 0))
;->  (1 (0 0 1))
;->  (1 (0 0.5 0.5))
;->  (1 (0 1 0))
;->  (1 (0.5 0 0.5))
;->  (1 (0.5 0.5 0))
;->  (1 (1 0 0))
;->  (1.5 (0 0.5 1))
;->  (1.5 (0 1 0.5))
;->  (1.5 (0.5 0 1))
;->  (1.5 (0.5 0.5 0.5))
;->  (1.5 (0.5 1 0))
;->  (1.5 (1 0 0.5))
;->  (1.5 (1 0.5 0))
;->  (2 (0 1 1))
;->  (2 (0.5 0.5 1))
;->  (2 (0.5 1 0.5))
;->  (2 (1 0 1))
;->  (2 (1 0.5 0.5))
;->  (2 (1 1 0))
;->  (2.5 (0.5 1 1))
;->  (2.5 (1 0.5 1))
;->  (2.5 (1 1 0.5))
;->  (3 (1 1 1)))

Giocando 10 partite abbiamo il seguente numero di risultati:

(length (possible-results 10))
;-> 59049

Giocando 11 partite abbiamo il seguente numero di risultati:
(length (possible-results 11))
;-> 177147

Scriviamo una funzione per rispondere alla domanda del problema.

(define (modi points games)
  (first (count (list points)
                (sort (map (fn(x) (apply add x))
                          (perm-rep games '(1 0.5 0)))))))

Proviamo a vedere in quanti modi si possono fare 2 punti in 3 partite:

(modi 2 3)
;-> 6

Modi di fare 5 punti in 10 partite:

(modi 5 10)
;-> 8953

Calcoliamo i modi per tutti i punti che vanno da 0 al numero delle partite:

(setq g 10) ; numero delle partite
(for (i 0 g)
  (println i { } (modi i g))
)
;-> 0 1
;-> 1 55
;-> 2 615
;-> 3 2850
;-> 4 6765
;-> 5 8953
;-> 6 6765
;-> 7 2850
;-> 8 615
;-> 9 55
;-> 10 1

I risultati hanno una distribuzioone gaussiana.


----------------------------------------------------------
Addizioni e sottrazioni esatte di numeri in virgola mobile
----------------------------------------------------------

Le rappresentazioni binarie in virgola mobile IEEE 754 di numeri come 2.86 e .0765 non sono esatte.
Quindi le operazioni che applichiamo a questi numeri producono risultati non perfettamente esatti.
L'errore che viene generato può propagarsi nelle successive operazioni fino a portare a risultati completamente errati.

Per esempio la somma di 0.1 e 0.7 non produce il risultato esatto:
(add 0.1 0.7)
;-> 0.7999999999999999

Addizione esatta
----------------
Scriviamo una funzione che somma esattamente due numeri in virgola mobile (in formato stringa) di (quasi) qualunque magnitudine.
I numeri vengono memorizzati in vettori di cifre, quindi possiamo utilizzare numeri estremamente grandi e con molte cifre dopo la virgola.
Esempio:

  stringa1 = "12345.009"
  vettore1 = 0 1 2 3 4 5 . 0 0 9 0 0 0 0 0 0 0 0 0

  stringa2 = "6.038473666636"
  vettore2 = 0 0 0 0 0 6 . 0 3 8 4 7 3 6 6 6 6 3 6

(define (add-str str1 str2)
  (local (sep p1 p2 len1 len2 dopo prima len ante post ar1 ar2 sum carry val)
    (setq sep ".")
    ; posizione del punto decimale numero 1
    (setq p1 (find sep str1))
    ; se è un numero intero...
    (if (= p1 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str1 ".0")
        (setq p1 (find sep str1))))
    ; posizione del punto decimale numero 2
    (setq p2 (find sep str2))
    ; se è un numero intero...
    (if (= p2 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str2 ".0")
        (setq p2 (find sep str2))))
    ; lunghezza dei numeri
    (setq len1 (length str1))
    (setq len2 (length str2))
    ; max numero di cifre dopo la virgola
    (setq dopo (max (- len1 p1 1) (- len2 p2 1)))
    ; max numero di cifre prima della virgola
    (setq prima (max p1 p2))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len1 p1 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p1) 1)))
    (setq str1 (append ante str1 post))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len2 p2 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p2) 1)))
    (setq str2 (append ante str2 post))
    (setq len (length str1))
    ;(setq len (length str2))
    ; array di cifre dei due numeri
    (setq ar1 (array len (explode str1)))
    (setq ar2 (array len (explode str2)))
    ; array di cifre della somma
    (setq sum (array len '(0)))
    ; addiziona gli array di cifre
    (setq carry 0)
    ; ciclo di addizione come a scuola...
    (for (i (- len 1) 1 -1)
      (cond ((= (ar1 i) sep)
              (setf (sum i) sep))
            (true
              (setq val (+ (int (ar1 i)) (int (ar2 i)) carry))
              (setf (sum i) (string (% val 10)))
              (setq carry (/ val 10)))
      )
    )
    ; imposta la prima cifra del risultato
    (setf (sum 0) (string carry))
    (setq sum (join (array-list sum)))
    ; toglie gli (eventuali) zeri iniziali
    (while (= (sum 0) "0") (pop sum))
    (if (or (= sum "") (= sum ".0")) (setq sum "0.0"))
    sum))

Facciamo alcune prove:

(setq s1 "12345.009")
(setq s2 "6.038473666636")
(add-str s1 s2)
;-> "12351.047473666636"
(add 12345.009 6.038473666636)
;->  12351.04747366664

(setq s1 "12345009")
(setq s2 "6038473666636")
(add-str s1 s2)
;-> "6038486011645.0"
(+ 12345009 6038473666636)
;->  6038486011645

(setq s1 "12345.009")
(setq s2 "88763.9911")
(add-str s1 s2)
;-> "101109.0001"

(setq s1 "99999999999999999999999999.99999999999999999999999999")
(setq s2 "11111111111111111111111111.11111111111111111111111111")
(add-str s1 s2)
;-> "111111111111111111111111111.11111111111111111111111110"
(setq s1 "9999999999999999999999999999999999999999999999999999")
(setq s2 "1111111111111111111111111111111111111111111111111111")
(add-str s1 s2)
;-> "11111111111111111111111111111111111111111111111111110.0"
(+ 9999999999999999999999999999999999999999999999999999
   1111111111111111111111111111111111111111111111111111)
;->  11111111111111111111111111111111111111111111111111110L

(add-str "0.0" "0")
;-> "0.0"

Sommiamo 100 numeri casuali (da 0 a 1000) e vediamo la differenza tra il valore calcolato con "add-str" e il valore calcolato con la funzione "add" (che usa la rappresentazione IEEE 754):

(setq nums (random 0 1000 100))
(apply add nums)
;->  48865.62700277716
(apply add-str (map string nums) 2)
;-> "48865.627002777184671"

Scriviamo una macro per sommare più numeri (in formato stringa):

(define-macro (add-str-num)
  (apply add-str (args) 2))

(add-str-num "111.1" "222.2" "333.3" "444.4")
;-> "1111.0"

(apply add-str '("111.1" "222.2" "333.3" "444.4") 2)
;-> 1111.0

Nota: la funzione "add-str" è estremamente lenta rispetto alla funzione "add".


Sottrazione esatta
------------------
Scriviamo una funzione che sottrae esattamente due numeri in virgola mobile (in formato stringa) di (quasi) qualunque magnitudine.
I numeri vengono memorizzati in vettori di cifre, quindi possiamo utilizzare numeri estremamente grandi e con molte cifre dopo la virgola.
Il primo numero deve essere maggiore o uguale al secondo numero.

(define (sub-str str1 str2)
  ; condizione: str1 >= str2
  (local (sep p1 p2 len1 len2 dopo prima len ante post ar1 ar2 sot carry val)
    (setq sep ".")
    ; posizione del punto decimale numero 1
    (setq p1 (find sep str1))
    ; se è un numero intero...
    (if (= p1 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str1 ".0")
        (setq p1 (find sep str1))))
    ; posizione del punto decimale numero 2
    (setq p2 (find sep str2))
    ; se è un numero intero...
    (if (= p2 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str2 ".0")
        (setq p2 (find sep str2))))
    ; lunghezza dei numeri
    (setq len1 (length str1))
    (setq len2 (length str2))
    ; max numero di cifre dopo la virgola
    (setq dopo (max (- len1 p1 1) (- len2 p2 1)))
    ; max numero di cifre prima della virgola
    (setq prima (max p1 p2))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len1 p1 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p1) 1)))
    (setq str1 (append ante str1 post))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len2 p2 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p2) 1)))
    (setq str2 (append ante str2 post))
    (setq len (length str1))
    ;(setq len (length str2))
    ; array di cifre dei due numeri
    (setq ar1 (array len (explode str1)))
    (setq ar2 (array len (explode str2)))
    ; array di cifre della differenza
    (setq sot (array len '(0)))
    ; sottrae gli array di cifre
    (setq carry 0)
    ; ciclo di sottrazione come a scuola...
    (for (i (- len 1) 1 -1)
      (cond ((= (ar1 i) sep)
              (setf (sot i) sep))
            (true
              (setq val (- (int (str1 i)) (int (str2 i)) carry))
              ; Se la sottrazione è minore di zero
              ; allora aggiungiamo 10 a val e poniamo il riporto (carry) a 1
              (if (< val 0)
                  (set 'val (+ val 10) 'carry 1)
                  ; else
                  (set 'carry 0)
              )
              (setf (sot i) (string val)))
       )
    )
    ; imposta la prima cifra del risultato
    (setf (sot 0) (string carry))
    (setq sot (join (array-list sot)))
    ; toglie gli (eventuali) zeri iniziali
    (while (= (sot 0) "0") (pop sot))
    (if (or (= sot "") (= sot ".0")) (setq sot "0.0"))
    sot))

Facciamo alcune prove:

(sub-str "111" "100")
;-> "11.0"

(sub-str "111.25" "99.77")
;-> 11.48
(sub 111.25 99.77)
;-> 11.48

(sub-str "0" "0")
;-> "0.0"

(sub-str "12" "12.0")
;-> "0.0"

(sub-str "173871523034953472" "57828987577128989")
;-> "116042535457824483.0"
(- 173871523034953472 57828987577128989)
;->  116042535457824483

Le funzioni "add-str" e "sub-str" accettano solo numeri positivi e il primo numero deve essere maggiore del secondo.
Riscriviamo le funzioni per fare in modo che possano accettare anche numeri negativi in ordine qualsiasi.

Funzione che verifica se una stringa numerica è negativa:

(define (negative? str)
  (if (= (str 0) "-") true nil))

(negative? "-12.56")
;-> true
(negative? "11.421")
;-> nil

Funzione che controlla se una stringa numerica è maggiore (o uguale) ad un altra stringa numerica.
Le stringhe non hanno segno e hanno il seguente formato:

(setq s1 "0002345.45300000")
(setq s2 "0129755.73407001")

(define (maggiore? str1 str2)
(catch
  (let (len (length str1))
    (for (i 0 (- len 1))
    (if (< (str1 i) (str2 i)) (throw nil))
    (if (> (str1 i) (str2 i)) (throw true))
    )
    true)))

(maggiore? s1 s2)
;-> nil
(maggiore? s2 s1)
;-> true
(maggiore? "0111.0" "0111.1")
;-> nil

Esempio:

  stringa1 = "12345.009"
  vettore1 = 0 1 2 3 4 5 . 0 0 9 0 0 0 0 0 0 0 0 0

  stringa2 = "6.038473666636"
  vettore2 = 0 0 0 0 0 6 . 0 3 8 4 7 3 6 6 6 6 3 6

Funzioni ausiliarie:

(define (add-str-aux str1 str2)
  (local (ar1 ar2 sum carry val)
    ; simbolo decimale
    (setq sep ".")
    ; la lunghezza delle due stringhe è uguale
    (setq len (length str1))
    ;(setq len (length str2))
    ; array di cifre dei due numeri
    (setq ar1 (array len (explode str1)))
    (setq ar2 (array len (explode str2)))
    ; array di cifre della somma
    (setq sum (array len '("0")))
    ; addiziona gli array di cifre
    (setq carry 0)
    ; ciclo di addizione come a scuola...
    (for (i (- len 1) 1 -1)
      (cond ((= (ar1 i) sep)
              (setf (sum i) sep))
            (true
              (setq val (+ (int (ar1 i)) (int (ar2 i)) carry))
              (setf (sum i) (string (% val 10)))
              (setq carry (/ val 10)))
      )
    )
    ; imposta la prima cifra del risultato
    (setf (sum 0) (string carry))
    ; converte il vettore in stringa
    (setq sum (join (array-list sum)))
    ; toglie gli (eventuali) zeri iniziali
    (while (= (sum 0) "0") (pop sum))
    (if (or (= sum "") (= sum ".0")) (setq sum "0.0"))
    sum))

(define (sub-str-aux str1 str2)
  (local (ar1 ar2 sot carry val)
    ; simbolo decimale
    (setq sep ".")
    ; la lunghezza delle due stringhe è uguale
    (setq len (length str1))
    ;(setq len (length str2))
    ; array di cifre dei due numeri
    (setq ar1 (array len (explode str1)))
    (setq ar2 (array len (explode str2)))
    ; array di cifre della differenza
    (setq sot (array len '(0)))
    ; sottrae gli array di cifre
    (setq carry 0)
    ; ciclo di sottrazione come a scuola...
    (for (i (- len 1) 1 -1)
      (cond ((= (ar1 i) sep)
              (setf (sot i) sep))
            (true
              (setq val (- (int (str1 i)) (int (str2 i)) carry))
              ; Se la sottrazione è minore di zero
              ; allora aggiungiamo 10 a val e poniamo il riporto (carry) a 1
              (if (< val 0)
                  (set 'val (+ val 10) 'carry 1)
                  ; else
                  (set 'carry 0)
              )
              (setf (sot i) (string val)))
       )
    )
    ; imposta la prima cifra del risultato
    (setf (sot 0) (string carry))
    ; converte il vettore in stringa
    (setq sot (join (array-list sot)))
    ; toglie gli (eventuali) zeri iniziali
    (while (= (sot 0) "0") (pop sot))
    (if (or (= sot "") (= sot ".0")) (setq sot "0.0"))
    (if (= (sot 0) ".") (push "0" sot))
    sot))

Addizione esatta
----------------

(define (add-str str1 str2)
  (local (sep p1 p2 len1 len2 dopo prima len ante post
          neg1 neg2 mag1 mag2 temp)
    ; controllo numeri negativi
    (setq neg1 (negative? str1))
    (if neg1 (pop str1))
    (setq neg2 (negative? str2))
    (if neg2 (pop str2))
    (setq sep ".")
    ; posizione del punto decimale numero 1
    (setq p1 (find sep str1))
    ; se è un numero intero...
    (if (= p1 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str1 ".0")
        (setq p1 (find sep str1))))
    ; posizione del punto decimale numero 2
    (setq p2 (find sep str2))
    ; se è un numero intero...
    (if (= p2 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str2 ".0")
        (setq p2 (find sep str2))))
    ; lunghezza dei numeri
    (setq len1 (length str1))
    (setq len2 (length str2))
    ; max numero di cifre dopo la virgola
    (setq dopo (max (- len1 p1 1) (- len2 p2 1)))
    ; max numero di cifre prima della virgola
    (setq prima (max p1 p2))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len1 p1 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p1) 1)))
    (setq str1 (append ante str1 post))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len2 p2 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p2) 1)))
    (setq str2 (append ante str2 post))
    ; controllo numero maggiore (o uguale)
    (if (maggiore? str1 str2)
        (set 'mag1 true 'mag2 nil)
        ;else
        (set 'mag1 nil 'mag2 true)
    )
    ; definizione dell'operazione da effettuare
    (cond ((and neg1 neg2 mag1) ; -10 -6
           (setq temp (add-str-aux str1 str2))
           (push "-" temp))
          ((and neg1 neg2 mag2) ; -6 -10
           (setq temp (add-str-aux str1 str2))
           (push "-" temp))
          ((and neg1 (not neg2) mag1) ; -10 +5
           (setq temp (sub-str-aux str1 str2))
           (push "-" temp))
          ((and (not neg1) neg2 mag1) ; +10 -5
           (setq temp (sub-str-aux str1 str2)))
          ((and neg1 (not neg2) mag2) ; -10 +11
           (setq temp (sub-str-aux str2 str1)))
          ((and (not neg1) neg2 mag2) ; +10 -11
           (setq temp (sub-str-aux str2 str1))
           (push "-" temp))
          ((and (not neg1) (not neg2) mag1) ; +11 +10
           (setq temp (add-str-aux str1 str2)))
          ((and (not neg1) (not neg2) mag2) ; +10 +11
           (setq temp (add-str-aux str1 str2)))
    )
    temp))

Sottrazione esatta
------------------

(define (sub-str str1 str2)
  (local (sep p1 p2 len1 len2 dopo prima len ante post
          neg1 neg2 mag1 mag2 temp)
    ; controllo numeri negativi
    (setq neg1 (negative? str1))
    (if neg1 (pop str1))
    (setq neg2 (negative? str2))
    (if neg2 (pop str2))
    (setq sep ".")
    ; posizione del punto decimale numero 1
    (setq p1 (find sep str1))
    ; se è un numero intero...
    (if (= p1 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str1 ".0")
        (setq p1 (find sep str1))))
    ; posizione del punto decimale numero 2
    (setq p2 (find sep str2))
    ; se è un numero intero...
    (if (= p2 nil)
      ; allora aggiungiamo ".0"
      (begin
        (extend str2 ".0")
        (setq p2 (find sep str2))))
    ; lunghezza dei numeri
    (setq len1 (length str1))
    (setq len2 (length str2))
    ; max numero di cifre dopo la virgola
    (setq dopo (max (- len1 p1 1) (- len2 p2 1)))
    ; max numero di cifre prima della virgola
    (setq prima (max p1 p2))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len1 p1 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p1) 1)))
    (setq str1 (append ante str1 post))
    ; zeri da aggiungere posteriormente al numero
    (setq post (dup "0" (- dopo (- len2 p2 1))))
    ; zeri da aggiungere anteriormente al numero
    (setq ante (dup "0" (+ (- prima p2) 1)))
    (setq str2 (append ante str2 post))
    ; controllo numero maggiore (o uguale)
    (if (maggiore? str1 str2)
        (set 'mag1 true 'mag2 nil)
        ;else
        (set 'mag1 nil 'mag2 true)
    )
    ; definizione dell'operazione da effettuare
    (cond ((and neg1 neg2 mag1) ; -10 -6
           (setq temp (sub-str-aux str1 str2))
           (push "-" temp))
          ((and neg1 neg2 mag2) ; -6 -10
           (setq temp (sub-str-aux str2 str1)))
          ((and neg1 (not neg2) mag1) ; -10 +5
           (setq temp (add-str-aux str1 str2))
           (push "-" temp))
          ((and (not neg1) neg2 mag1) ; +10 -5
           (setq temp (add-str-aux str1 str2)))
          ((and neg1 (not neg2) mag2) ; -10 +11
           (setq temp (add-str-aux str1 str2))
           (push "-" temp))
          ((and (not neg1) neg2 mag2) ; +10 -11
           (setq temp (add-str-aux str2 str1)))
          ((and (not neg1) (not neg2) mag1) ; +11 +10
           (setq temp (sub-str-aux str1 str2)))
          ((and (not neg1) (not neg2) mag2) ; +10 +11
           (setq temp (sub-str-aux str2 str1))
           (push "-" temp))
    )
    temp))

Facciamo alcune prove:

(add-str "-5" "-6")
;-> "-11.0"
(add-str "-6" "-5")
;-> "-11.0"
(add-str "-6" "5")
;-> "-1.0"
(add-str "5" "-6")
;-> "-1.0"
(add-str "6" "-5")
;-> "1.0"
(add-str "-5" "6")
;-> "1.0"
(add-str "5" "6")
;-> "11.0"
(add-str "6" "5")
;-> "11.0"

(sub-str "-5" "-6")
;-> "1.0"
(sub-str "-6" "-5")
;-> "-1.0"
(sub-str "-6" "5")
;-> "-11.0"
(sub-str "5" "-6")
;-> "11.0"
(sub-str "6" "-5")
;-> "11.0"
(sub-str "-5" "6")
;-> "-11.0"
(sub-str "5" "6")
;-> "-1.0"
(sub-str "6" "5")
;-> "1.0"

Scriviamo due funzioni per sommare o sottrarre una serie di stringhe numeriche:

(define (add-str-num)
  (apply add-str (args) 2))

(add-str-num "111.1" "222.2" "333.3" "444.4")
;-> "1111.0"
(add 111.1 222.2 333.3 444.4)
;-> 1111

Se abbiamo una lista di stringhe numeriche possiamo usare "apply":

(apply add-str '("111.1" "222.2" "333.3" "444.4") 2)
;-> "1111.0"

(define (sub-str-num)
  (apply sub-str (args) 2))

(sub-str-num "111.1" "222.2" "333.3" "444.4")
;-> "-888.8"
(sub 111.1 222.2 333.3 444.4)
;-> -888.8

Se abbiamo una lista di stringhe numeriche possiamo usare "apply":

(apply sub-str '("111.1" "222.2" "333.3" "444.4") 2)
;-> "-888.8"

Facciamo alcune prove:

(add-str-num "-120.21" (sub-str-num "200.01" "0.009876534233001" "-200.01" "121"))
;-> "158.800123465766999"
(add -120.21 (sub 200.01 0.009876534233001 -200.01 121))
;->  158.800123465767

(add-str "32857853617893456123561" "3258915891765614561783456237465")
;-> "3258915924623468179676912361026.0"
(+ 32857853617893456123561 3258915891765614561783456237465)
;->  3258915924623468179676912361026L
(add 32857853617893456123561 3258915891765614561783456237465)
;-> 3.258915924623468e+030

(sub-str "0.032857853617893456123561" "0.03258915891765614561783456237465")
;-> "0.00026869470023731050572643762535"
(sub 0.032857853617893456123561 0.03258915891765614561783456237465)
;->  0.0002686947002373125


------------------------
Funzione slice di python
------------------------

The syntax of slice in python is:

a[start:stop]  # items start through stop-1
a[start:]      # items start through the rest of the array
a[:stop]       # items from the beginning through stop-1
a[:]           # a copy of the whole array

There is also the step value, which can be used with any of the above:

a[start:stop:step] # start through not past stop, by step

The key point to remember is that the :stop value represents the first value that is not in the selected slice. So, the difference between stop and start is the number of elements selected (if step is 1, the default).

The other feature is that start or stop may be a negative number, which means it counts from the end of the array instead of the beginning. So:

a[-1]    # last item in the array
a[-2:]   # last two items in the array
a[:-2]   # everything except the last two items

Similarly, step may be a negative number:

a[::-1]    # all items in the array, reversed
a[1::-1]   # the first two items, reversed
a[:-3:-1]  # the last two items, reversed
a[-3::-1]  # everything except the last two items, reversed

La seguente funzione simula lo slice di python ed è applicabile a liste e stringhe:

(define (extract obj start end)
"Extract a list/string from a list/string (from start to (end -1) indexes)"
  (if (nil? end)
      (slice obj start)
      (slice obj start (- end start))))

Con le stringhe:

(extract "zippo" 0 1)
;-> "z"
(extract "zippo" 1 3)
;-> "ip"
(extract "zippo" 2)
;-> "ppo"
(extract "zippo" 0)
;-> "zippo"
(extract "zippo" 0 0)
;-> ""
(extract "zippo" -2 2)
;-> "po"
(extract "zippo" -5)
;-> "zippo"
(extract "zippo" 5 4)
;-> ""
(extract "zippo" 10 20)
;-> ""

Con le liste:

(extract '("z" "i" "p" "p" "o") 0 1)
;-> ("z")
(extract '("z" "i" "p" "p" "o") 1 3)
;-> ("i" "p")
(extract '("z" "i" "p" "p" "o") 2)
;-> ("p" "p" "o")
(extract '("z" "i" "p" "p" "o") 0)
;-> ("z" "i" "p" "p" "o")
(extract '("z" "i" "p" "p" "o") 0 0)
;-> ()
(extract '("z" "i" "p" "p" "o") -2 2)
;-> ("p" "o")
(extract '("z" "i" "p" "p" "o") -5)
;-> ("z" "i" "p" "p" "o")
(extract '("z" "i" "p" "p" "o") 5 4)
;-> ()
(extract '("z" "i" "p" "p" "o") 10 20)
;-> ()

Vediamo la differenza con lo slice di newLISP:

(setq lst '(1 2 3 4 5))

(extract lst 0 1)
;-> (1)
(0 1 lst)
;-> (1)
(slice lst 0 1)
;-> (1)

(extract lst 0 0)
;-> ()
(0 0 lst)
;-> ()
(slice lst 0 0)
;-> ()

(extract lst 2 3)
;-> (3)
(2 3 lst)
;-> (3 4 5)
(slice lst 2 3)
;-> (3 4 5)


-------------------------
Coefficienti multinomiali
-------------------------

I coefficienti multinomiali sono generalizzazioni di coefficienti binomiali, con un'interpretazione combinatoria simile.
Sono i coefficienti dei termini nell'espansione di una potenza di un multinomio, nel teorema multinomiale.

I coefficienti multinomiali possono essere espressi in numerosi modi, anche come prodotto di coefficienti binomiali o di fattoriali:

  |      n       |           n!
  |              | = --------------------- =
  |k1,k2,k3,...km|    k1!*k2!*k3!*...*kn!

    | k1 |   | k1+k2 |   |k1+k2+k3|   |k1+k2+k3+...+kn|
  = |    | * |       | * |        | * |               |
    | k1 |   |  k2   |   |   k3   |   |      kn       |

Modi per mettere gli oggetti nelle scatole
------------------------------------------
I coefficienti multinomiali hanno un'interpretazione combinatoria diretta, come il numero di modi per depositare n oggetti distinti in m scatole distinte, con k1 oggetti nella prima scatola, k2 oggetti nella seconda scatola e così via.

Selezione di oggetti
--------------------
Il numero di modi per scegliere k1 oggetti intercambiabili da n oggetti, quindi scegliere k2 da ciò che resta, quindi scegliere k3 da ciò che resta, ..., quindi scegliere k(n-1) da ciò che resta.

Numero di permutazioni univoche di parole
-----------------------------------------
Il coefficiente multinomiale come prodotto di coefficienti binomiali, conta le permutazioni delle lettere di MISSISSIPPI.
Il coefficiente multinomiale è anche il numero di modi distinti per permutare un multiinsieme di n elementi, dove ki è la molteplicità dell'i-esimo elemento. Ad esempio, il numero di permutazioni distinte delle lettere della parola MISSISSIPPI, che ha 1 M, 4 I, 4 S e 2 P, vale:

  |   11    |        11!
  |         | = ------------- = 34650
  | 1 4 4 2 |    1!*4!*4!*2!

Quante sono le permutazioni distinte della parola ABRACADABRA?

  |    11     |         11!
  |           | = ---------------- = 83160
  | 5 2 1 1 2 |    5!*2!*1!*1!*2!

Implementazione con i fattoriali:

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (multinomial1 lst)
  (/ (fact-i (apply + lst)) (apply * (map fact-i lst))))

(multinomial1 '(1 4 4 2))
;-> 34650L

(multinomial1 '(5 2 1 1 2))
;-> 83160L

Implementazione con i coefficienti binomiali:

(define (binom num k)
"Calculates the binomial coefficient (n k) = n!/(k!*(n - k)!) (combinations of k elements without repetition from n elements)"
  (cond ((> k num) 0)
        ((zero? k) 1)
        (true
          (let (r 1L)
            (for (d 1 k)
              (setq r (/ (* r num) d))
              (-- num)
            )
          r))))

(define (multinomial2 lst)
  (let ((multi 1L) (sum 0L))
    (dolist (el lst)
      (setq sum (+ sum el))
      (setq multi (* multi (binom sum el)))
    )
    multi))

(multinomial2 '(1 4 4 2))
;-> 34650L

(multinomial2 '(5 2 1 1 2))
;-> 83160L

Implementazione efficiente:

https://stackoverflow.com/questions/46374185/does-python-have-a-function-which-computes-multinomial-coefficients

(define (multinomial3 lst)
  (local (res i i0)
    (setq res 1L)
    (setq i (apply + lst))
    (setq i0 (find (apply max lst) lst))
    (setq l1 (slice lst 0 i0))
    (setq l2 (slice lst (+ i0 1)))
    (setq l12 (append l1 l2))
    (dolist (a l12)
      (for (j 1 a)
        (setq res (* res i))
        (setq res (/ res j))
        (-- i)
      )
    )
    res))

Versione compatta:

(define (multinomial3 lst)
  (local (res i i0)
    (setq res 1L)
    (setq i (apply + lst))
    (setq i0 (find (apply max lst) lst))
    (dolist (a (append (slice lst 0 i0) (slice lst (+ i0 1))))
      (for (j 1 a)
        (setq res (* res i))
        (setq res (/ res j))
        (-- i)
      )
    )
    res))

(multinomial3 '(1 4 4 2))
;-> 34650L

(multinomial3 '(5 2 1 1 2))
;-> 83160L

Facciamo alcune prove di controllo:

(multinomial3 '(10 12 11 10))
;-> 239953960784788967676960L
(multinomial1 '(10 12 11 10))
;-> 239953960784788967676960L
(multinomial2 '(10 12 11 10))
;-> 239953960784788967676960L
(multinomial3 '(10 12 11 10))
;-> 239953960784788967676960L

(multinomial1 '(25 100 50 10))
;-> 258032725616706621605932604719180409163145266174701391871111490995550256691528504063680L
(multinomial2 '(25 100 50 10))
;-> 258032725616706621605932604719180409163145266174701391871111490995550256691528504063680L
(multinomial3 '(25 100 50 10))
;-> 258032725616706621605932604719180409163145266174701391871111490995550256691528504063680L

Vediamo i tempi di esecuzione delle tre funzioni:

(time (multinomial1 '(10 12 11 10)) 10000)
;-> 154.656
(time (multinomial2 '(10 12 11 10)) 10000)
;-> 284.668
(time (multinomial3 '(10 12 11 10)) 10000)
;-> 33.792

(time (multinomial1 '(25 100 50 10)) 10000)
;-> 772.511
(time (multinomial2 '(25 100 50 10)) 10000)
;-> 1021.397
(time (multinomial3 '(25 100 50 10)) 10000)
;-> 86.195


------------------------
Sicurezza delle password
------------------------

Eva e Roby hanno il proprio cellulare protetto con una password.
La password di Eva è lunga 4 e contiene 4 cifre diverse e le cifre possibili sono 1, 2, 3 e 4.
La password di Roby è lunga 3 e contiene 2 cifre diverse (quindi 1 cifra ripetuta) e le cifre possibili sono 1, 2 e 3.

Quale password è la più sicura?

Nel caso di Eva dobbiamo calcolare le permutazioni di 4 oggetti distinti, cioè P = 4! = 24.
Quindi abbiamo 24 possibili password distinte.

Nel caso di Roby dobbiamo calcolare i coefficienti multinomiali.

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (multinomial lst)
  (/ (fact-i (apply + lst)) (apply * (map fact-i lst))))

Se viene ripetuto il numero 1 abbiamo i seguenti 12 casi:

1123 1132 1213 1312 1231 1321 2113 2131 2311 3112 3121 3211
(multinomial '(2 1 1))
;-> 12L

Se viene ripetuto il numero 2 abbiamo i seguenti 12 casi:

2213 2231 2123 2321 2132 2312 1223 1232 1322 3221 3212 3122
(multinomial '(1 2 1))
;-> 12L
Se viene ripetuto il numero 2 abbiamo i seguenti 12 casi:

2213 2231 2123 2321 2132 2312 1223 1232 1322 3221 3212 3122
(multinomial '(1 1 2))
;-> 12L

In totale, per Roby, abbiamo 12 + 12 + 12 = 36 possibili password distinte.

Quindi la password più sicura è quella di Roby.


---------------------
Cattura di pagine web
---------------------

Per catturare una pagina web "http" possiamo usare la funzione "get-url".

********************
>>>funzione GET-URL
********************
sintassi: (get-url str-url [str-option] [int-timeout [str-header]])

Legge una pagina Web o un file specificato dall'URL in "str-url" utilizzando il protocollo HTTP GET. Vengono gestiti sia gli URL http:// che file://. "header" può essere specificato nell'argomento facoltativo "str-option" per recuperare solo l'intestazione. L'opzione "list" fa sì che le informazioni sull'intestazione e sulla pagina vengano restituite come stringhe separate in una lista e include anche il codice di stato del server come terzo membro della lista (dalla 10.6.4). L'opzione "raw" (dalla 10.6.4), che può essere utilizzata da sola o combinata con altre opzioni, sopprime il reindirizzamento della posizione dell'intestazione.

Un'opzione "debug" può essere specificata da sola o dopo l'opzione "header" o "list" separata da un carattere, ad esempio "header debug" o "list debug". Includendo "debug" tutte le informazioni in uscita vengono inviate alla finestra della console.

L'argomento facoltativo "int-timeout" può specificare un valore in millisecondi. Se non sono disponibili dati dall'host dopo il timeout specificato, "get-url" restituisce la stringa ERR: timeout. Quando si verificano altre condizioni di errore, "get-url" restituisce una stringa che inizia con ERR: e la descrizione dell'errore.

get-url gestisce il reindirizzamento se rileva una posizione: spec nell'intestazione ricevuta ed esegue automaticamente una seconda richiesta. get-url comprende anche il formato Transfer-Encoding: chunked e decomprimerà i dati in un formato unchunk.

le richieste get-url sono comprese anche dai nodi del server newLISP.

(get-url "http://www.nuevatec.com")
(get-url "http://www.nuevatec.com" 3000)
(get-url "http://www.nuevatec.com" "intestazione")
(get-url "http://www.nuevatec.com" "intestazione" 5000)
(get-url "http://www.nuevatec.com" "lista")

(get-url "file:///home/db/data.txt"); accedere al file system locale

(env "HTTP_PROXY" "http://ourproxy:8080")
(get-url "http://www.nuevatec.com/newlisp/")

La pagina dell'indice del sito specificato in "str-url" viene restituita come stringa. Nella terza riga, in una stringa viene restituita solo l'intestazione HTTP. Le righe 2 e 4 mostrano un valore di timeout utilizzato.

Il secondo esempio mostra l'utilizzo di un URL file:// per accedere a /home/db/data.txt sul file system locale.

Il terzo esempio illustra l'uso di un server proxy. L'URL del server proxy deve trovarsi nell'ambiente del sistema operativo. Come mostrato nell'esempio, questo può essere aggiunto usando la funzione "env".

L'int-timeout può essere seguito da un'intestazione personalizzata opzionale in "str-header":

Intestazione (header) personalizzata
------------------------------------
L'intestazione personalizzata (header) può contenere opzioni per i cookie del browser o altre direttive al server. Quando non viene specificato "str-header", newLISP invia determinate informazioni di intestazione per impostazione predefinita. Dopo la seguente richiesta:

(get-url "http://somehost.com" 5000)

newLISP configurerà e invierà la richiesta e l'intestazione di seguito:

GET / HTTP/1.1
Host: somehost.com
User-Agente: newLISP v10603
Collegamento: close

In alternativa, è possibile utilizzare l'opzione "str-header":

(get-url "http://somehost.com" 5000
"User-Agent: Mozilla/4.0\r\nCookie: nome=fred\r\n")

newLISP invierà ora la seguente richiesta e intestazione:

GET / HTTP/1.1
Host: somehost.com
User-Agente: Mozilla/4.o
Cookie: nome=fred
Collegamento: close

Si noti che quando si utilizza un'intestazione personalizzata, newLISP fornirà solo la riga di richiesta GET, nonché le voci di intestazione "Host" e "Connection". newLISP inserisce tutte le altre voci fornite nell'intestazione personalizzata tra le voci "Host" e "Connection". Ogni voce deve terminare con una coppia di ritorno a capo e avanzamento riga: \r\n.

Vedere un manuale di riferimento delle transazioni HTTP per voci di intestazione valide.

Le intestazioni personalizzate possono essere utilizzate anche nelle funzioni "put-url" e "post-url".
---------------------

Vediamo un semplice esempio:

(setq page (get-url "http://www.newlisp.org/"))
;-> [text]
;-> <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
;-> <html>
;-> <head>
;->   <title>newLISP  - Home</title>
;-> ...
;-> ...
;-> ...
;-> </script>
;-> <script type="text/javascript">
;-> _uacct = "UA-1098066-1";
;-> urchinTracker();
;-> </script> -->
;-> </body>
;-> </html>
;-> [/text]

Purtroppo la funzione "get-url" non supporta gli indirizzi web "HTTPS".

Nota: HTTPS è HTTP con crittografia e verifica. L'unica differenza tra i due protocolli è che HTTPS utilizza TLS (SSL) per crittografare le normali richieste e risposte HTTP e per firmare digitalmente tali richieste e risposte. Di conseguenza, HTTPS è molto più sicuro di HTTP.

Per ovviare a questo problema possiamo utilizzare il programma "curl" dall'interno di newLISP.

"Curl: command line tool and library for transferring data with URLs (since 1998)" è disponibile all'indirizzo:

https://curl.se/

Vediamo un paio di esempi:

Con il seguente comando salviamo la pagina web sul file "pagina.html" sulla cartella corrente:

(! "curl https://sourceforge.net > pagina.html")

Con il seguente comando salviamo la pagina html in una lista:

(setq page (exec "curl https://sourceforge.net"))

(page 0)
;-> "<!doctype html>"

(page -1)
;-> "</html>"


----------------------------------------
Generazione delle cartelle della tombola
----------------------------------------

Tombola: numeri da 1 a 90
Cartelle: gruppi di 6 cartelle con tutti i numeri da 1 a 90

Le cartelle sono formate da 3 file orizzontali (righe) ognuna contenente 9 caselle colonne.

Le cartelle devono seguire le seguenti regole nella disposizione dei numeri:

1) In ogni riga 5 caselle sono occupate dai numeri e 4 restano vuote.
2) Devono essere presenti 5 numeri per riga per un totale di 15 numeri.
3) I numeri devono essere tutti diversi e disposti a colonne per decine:
   nella prima colonna i numeri dall'1 al 9,
   nella seconda colonna i numeri dal 10 al 19,
   nella terza colonna i numeri dal 20 al 29,
   nella quarta colonna i numeri dal 30 al 39,
   nella quinta colonna i numeri dal 40 al 49,
   nella sesta colonna i numeri dal 50 al 59,
   nella settima colonna i numeri dal 60 al 69,
   nell'ottava colonna i numeri dal 70 al 79,
   nella nona colonna i numeri dall'80 al 90.
4) In ogni colonna ci possono essere 1 o 2 numeri, mai 3.
   (poichè ogni colonna deve avere almeno un numero,
    allora non ci può essere una colonna vuota).
5) I numeri nelle colonne devono essere in ordine crescente dall'alto in basso.
6) Il gruppo di 6 cartelle deve contenere tutti i numeri da 1 a 90.

Algoritmo:

1) Generiamo una sequenza casuale di numeri da 1 a 90.
2) Ciclo per riempire in sequenza le cartelle da 1 a 6 utilizzando i numeri della sequenza casuale.
   Provare a generare una cartella con 15 numeri seguendo le regole stabilite.
   Se abbiamo generato la cartella continua il ciclo,
   altrimenti ricomincia con una nuova sequenza casuale di numeri da 1 a 90.

L'algoritmo non è deterministico perchè le regole codificate non producono sempre 6 cartelle corrette (in genere, quando fallisce è la sesta cartella che non è corretta). Comunque dopo alcuni tentativi si trova velocemente una soluzione.

Funzione che stampa una cartella:

(define (print-table matrix)
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

(setq table (array-list (array 3 9 (rand 2 27))))
(setq table '((1 0 0 1 0 1 1 1 0)
              (0 0 0 0 0 0 0 1 1)
              (1 1 1 1 1 1 0 1 0)))

(print-table table)
;-> 1 0 0 1 0 1 1 1 0
;-> 0 0 0 0 0 0 0 1 1
;-> 1 1 1 1 1 1 0 1 0

Funzione che verifica se una riga è libera, cioè se contiene più di 4 caselle libere (0):

(define (check-free-row? row lst)
  (> (first (count '(0) (lst row))) 4))

(check-free-row? 0 table)
;-> nil
(check-free-row? 1 table)
;-> true
(check-free-row? 2 table)
;-> nil

Funzione che verifica se una colonna è libera, cioè se contiene più di 1 casella libera (0):

(define (check-free-col? col lst)
  (> (first (count '(0) ((transpose lst) col))) 1))

(check-free-col? 0 table)
;-> nil
(check-free-col? 1 table)
;-> true

La lista "colonne" contiene i possibili valori per ogni colonna:

(setq colonne '(
  (0 (1 2 3 4 5 6 7 8 9)) (1 (10 11 12 13 14 15 16 17 18 19))
  (2 (20 21 22 23 24 25 26 27 28 29)) (3 (30 31 32 33 34 35 36 37 38 39))
  (4 (40 41 42 43 44 45 46 47 48 49)) (5 (50 51 52 53 54 55 56 57 58 59))
  (6 (60 61 62 63 64 65 66 67 68 69)) (7 (70 71 72 73 74 75 76 77 78 79))
  (8 (80 81 82 83 84 85 86 87 88 89 90))))

Funzione che verifica se un dato numero può essere inserito in una data colonna:

(define (check-num-col? num col)
  (if (find num (lookup col colonne))
      true
      nil))

(check-num-col? 10 0)
;-> nil
(check-num-col? 16 1)
;-> true

Funzione che verifica se un dato numero può essere inserito in una data casella:

(define (possible? num row col lst)
  (local (res)
    (setq res true)
          ; la casella deve essera vuota
    (cond ((not (zero? (lst row col)))
           ;(println "casella piena")
            (setq res nil))
          ; ci sono almeno 5 caselle libere nella riga?
          ((not (check-free-row? row lst))
            ;(println "(check-free-row? row)")
            (setq res nil))
          ; ci sono almeno 2 caselle libere nella colonna?
          ((not (check-free-col? col lst))
           ;(println "(check-free-col? col)")
            (setq res nil))
          ; il numero può stare nella colonna?
          ((not (check-num-col? num col))
           ;(println "(check-num-col? col)")
            (setq res nil))
    )
    res))

Funzione che crea la lista delle posizioni possibili per un dato numero:

(define (list-possible num lst)
  (local (out)
    (setq out '())
    (for (r 0 2)
      (for (c 0 8)
        (if (possible? num r c lst)
            (push (list r c) out -1)
        )
      )
    )
    out))

(list-possible 11 table)
;-> ((1 1))

(list-possible 45 table)
;-> ((1 4))

(list-possible 54 table)
;-> ()

Funzione che verifica se una cartella è piena (cioè se ha 15 numeri):

(define (filled? lst)
  (<= (first (count '(0) (flat lst))) 12))

Funzione che ordina i valori delle colonne senza modificare i posti vuoti:
(questa operazione non modifica le altre proprietà della cartella).

(define (change-col-order lst)
  (for (c 0 8)
    ; possibile scambio solo se la colonna ha un solo 0 (posto vuoto)
    (if (= (first (count '(0) (list (lst 0 c) (lst 1 c) (lst 2 c)))) 1)
        (cond ((zero? (lst 0 c))
                  (if (and (> (lst 1 c) (lst 2 c))
                      (swap (lst 1 c) (lst 2 c)))))
              ((zero? (lst 1 c))
                  (if (> (lst 0 c) (lst 2 c))
                      (swap (lst 0 c) (lst 2 c))))
              ((zero? (lst 2 c))
                  (if (> (lst 0 c) (lst 1 c))
                      (swap (lst 0 c) (lst 1 c))))
        )
    )
  )
  lst)

(setq prima '((0 15  0  0 47 55 64  0 86)
              (0  0 29 38 42  0 62  0 87)
              (4  0 28 37  0 53  0 76  0)))

(print-table (change-col-order prima))
;->  0 15  0  0 42 53 62  0 86
;->  0  0 28 37 47  0 64  0 87
;->  4  0 29 38  0 55  0 76  0

Funzione che genera il gruppo di 6 cartelle con i numeri da 1 a 90:

(define (tombola stampa)
  (local (colonne finito cartelle numbers table
          possible cur-row cur-col filled)
    (setq colonne '(
       (0 (1 2 3 4 5 6 7 8 9)) (1 (10 11 12 13 14 15 16 17 18 19))
       (2 (20 21 22 23 24 25 26 27 28 29)) (3 (30 31 32 33 34 35 36 37 38 39))
       (4 (40 41 42 43 44 45 46 47 48 49)) (5 (50 51 52 53 54 55 56 57 58 59))
       (6 (60 61 62 63 64 65 66 67 68 69)) (7 (70 71 72 73 74 75 76 77 78 79))
       (8 (80 81 82 83 84 85 86 87 88 89 90))))
    (setq finito nil)
    ; proviamo a generare 6 cartelle corrette con
    ; una lista random di numeri da 1 a 90.
    ; se non è possibile, allora riproviamo con
    ; una nuova lista random di numeri da 1 a 90.
    (until finito
      ; lista delle 6 cartelle da generare
      (setq cartelle '())
      ; generazione lista random da 1 a 90
      (setq numbers (randomize (sequence 1 90)))
      ; ciclo per ogni cartella
      (setq error nil)
      (for (c 1 6 1 error)
        ; lista che rappresenta una cartella
        (setq table (array-list (array 3 9 '(0))))
        (setq stop nil)
        ; ciclo per tutti i 90 numeri (o quelli rimasti)...
        (dolist (n numbers stop)
          ; lista delle posizioni possibili del numero corrente
          ; nella cartella (r c)
          (setq possible (list-possible n table))
          ; se esiste almeno una posizione possibile,
          ; allora inserisce il numero nella prima posizione possibile
          (if (!= possible '())
            (begin
              (setq cur-row (possible 0 0))
              (setq cur-col (possible 0 1))
              (setf (table cur-row cur-col) n)
              ;(println "numero: " n)
              ;(print-table table)
              ;(println possible)
              ;(println cur-row { } cur-col)
              ;(read-line)
            )
          )
          ; se la cartella contiene 15 numeri (cioè se è piena)
          ; allora ferma il ciclo dei numeri
          (if (filled? table) (setq stop true))
        )
        ; se la cartella è piena (cioè se stop vale true),
        ; allora ordiniamo correttamente le colonne e
        ; la inseriamo nella lista delle cartelle
        (if stop
          (begin
            ; ordina gli elementi delle colonne della cartella (table)
            ; (gli 0 non vengono modificati)
            ; questo non modifica le altre proprietà della cartella
            (setq table (change-col-order table))
            ; inserisce la cartella corrente nella lista delle cartelle
            (push table cartelle -1)
            ; elimina i 15 numeri utilizzati per la cartella (table) corrente
            (setq numbers (difference numbers (flat table)))
            ;(println c)
            ;(print-table table)
            ;(println numbers)
            ;(read-line)
          )
          ;else
          ; altrimenti non è stato possibile completare la cartella corrente
          ; questo accade in genere per l'ultima tabella (la sesta)
          (begin
            ;(println "error: " c)
            (setq error true) ; per uscire dal ciclo for
          )
        )
      )
      ; se abbiamo creato 6 cartelle e
      ; se abbiamo utilizzato tutti i numeri da 1 a 90,
      ; allora abbiamo finito
      (if (and (= (length cartelle) 6)
               (= (sort (unique (flat cartelle))) (sequence 0 90)))
          (setq finito true)
      )
    )
    ; generazione delle cartelle terminata
    (if stampa
      ; stampa della cartelle
      (for (i 0 5) (print-table (cartelle i)) (println))
      ; else
      ; restituisce la lista delle cartelle
      cartelle
    )
  )
)

Facciamo un paio di prove:

(tombola true)
;->  0 11 24  0 46 50  0 72  0
;->  0 13  0  0 49  0 67 73 81
;->  7  0 26  0  0 57 69  0 87
;-> 
;->  2  0 25 32 42  0 60  0  0
;->  4  0 29 39  0  0 64 71  0
;->  0 10  0  0 47 53  0 79 80
;-> 
;->  1 12 20 31  0  0  0  0 89
;->  0 15 28 33  0  0 62  0 90
;->  5  0  0  0 41 54 66 78  0
;-> 
;->  0 16  0 30 44  0 61  0 82
;->  9 17  0 34  0 55 63  0  0
;->  0  0 23  0 45 58  0 75 83
;-> 
;->  0 18  0 36 48 51  0  0 84
;->  3  0  0 37  0 56 65 74  0
;->  8  0 22  0  0  0 68 76 88
;-> 
;->  0  0  0 35 40 52  0 70 85
;->  6 14 21 38 43  0  0  0  0
;->  0 19 27  0  0 59  0 77 86

(tombola true)
;->  0  0 22 34 40  0 60  0 82
;->  5 10 26  0  0  0 64  0 83
;->  0 18  0 38 49 55  0 78  0
;-> 
;->  0 13  0 30 41  0  0 73 80
;->  0  0  0 32 43 50  0 76 88
;->  6 19 28  0  0 51 61  0  0
;-> 
;->  4  0  0  0 45 56  0 71 86
;->  7 12 21  0 46  0  0  0 89
;->  0  0 23 37  0 58 69 74  0
;-> 
;->  0  0 27  0 42 53 65  0 85
;->  3  0  0  0 48  0 67 77 87
;->  0 15 29 33  0 59  0 79  0
;-> 
;->  0 14 20 31  0 54  0  0 81
;->  2 17 24 35  0  0 66  0  0
;->  8  0  0  0  0 57 68 75 84
;-> 
;->  1  0  0 36 44  0 62 70  0
;->  9 11  0 39  0  0 63  0 90
;->  0 16 25  0 47 52  0 72  0

Vediamo la velocità della funzione (considerando che il programma non è deterministico):

(time (tombola))
;-> 1875.275
(time (tombola))
;-> 124.934
(time (tombola) 10)
;-> 7297.853
(time (tombola) 10)
;-> 8344.443


-------------------------
Prefix e Suffix Sum Array
-------------------------

Prefix Sum Array
----------------
Dato un array arr[] di dimensione n, il suo array di prefix sum è un altro array prefixSum[] della stessa dimensione, in modo tale che il valore di prefixSum[i] sia:

  prefixSum[i] = arr[0] + arr[1] + arr[2] + ... + arr[i]

Esempio:
arr = (10 20 10 5 15)
prefixSum = (10 30 40 45 60)

Algoritmo:
Durante l'attraversamento dell'array, aggiornare l'elemento aggiungendolo al suo elemento precedente.
prefixSum[0] = 10,
prefixSum[1] = prefixSum[0] + arr[1] = 10 + 20 = 30,
prefixSum[2] = prefixSum[1] + arr[2] = 30 + 10 = 40 e cosi via.

(define (prefix-sum lst)
  (let (out (array (length lst) '(0)))
    ; imposta il primo elemento
    (setf (out 0) (lst 0))
    ; calcola i rimanenti elementi
    (for (i 1 (- (length lst) 1))
      ; aggiunge l'elemento corrente con l'elemento precedente
      (setf (out i) (add (out (- i 1)) (lst i)))
    )
    out))

(setq a '(10 20 10 5 15))

(prefix-sum a)
;-> (10 30 40 45 60)

Suffix Sum Array
----------------
Dato un array arr[] di dimensione n, il suo array di suffix sum è un altro array suffixSum[] della stessa dimensione, in modo tale che il valore di suffixSum[i] sia:

  suffixSum[i] = arr[i] + arr[i+1] + arr[i+2] + ... + arr[n-1]

arr = (15 10 25 5 10 20)
suffixSum = (85 70 60 35 30 20)

Algoritmo:
Durante l'attraversamento al contrario dell'array, aggiornare l'elemento corrente aggiungendolo all'elemento precedente (in senso contrario).
suffixSum[5] = 20,
suffixSum[4] = suffixSum[5] + arr[4] = 20 + 10 = 30,
suffixSum[3] = suffixSum[4] + arr[3] = 30 + 5 = 35 e cosi via.

(define (suffix-sum lst)
  (let (out (array (length lst) '(0)))
    ; imposta il primo elemento
    (setf (out -1) (lst -1))
    ; calcola i rimanenti elementi
    (for (i (- (length lst) 2) 0 -1)
      ; aggiunge l'elemento corrente con l'elemento precedente
      (setf (out i) (add (out (+ i 1)) (lst i)))
    )
    out))

(setq a '(15 10 25 5 10 20))

(suffix-sum a)
;-> (85 70 60 35 30 20)


---------------------------------------------
Minimize difference of Contiguous Sublist Sum
---------------------------------------------

Data una lista di numeri interi positivi, dividere la lista in due sottoliste (con elementi contigui) minimizzando la differenza delle somme degli elementi delle sottoliste.

Nota: In questo caso una "sottolista" (sublist) è una parte contigua della lista (cioè un sottoinsieme di elementi contigui).

Esempio:
lst = (lst = (1 2 4 3)
sublist1 = (7 9)
sublist2 = (5 10)
Differenza delle somme = (7 + 9) - (5 + `0) = 1)

Algoritmo:
Utilizziamo la tecnica dell'array Prefix and Suffix Sum.
Generariamo l'array della somma dei prefissi e l'array della somma dei suffissi.
Attraversiamo l'array e calcoliamo la differenza minima tra prefix_sum[i] e suffix_sum[i+1], per qualsiasi indice i (0 <= i <= N–1) dall'array ed eventualmente aggiorniamo la differenza minima assoluta.

Time Complexity: O(N)
Auxiliary Space: O(N)

(define (prefix-sum lst)
  (let (out (array (length lst) '(0)))
    (setf (out 0) (lst 0))
    (for (i 1 (- (length lst) 1))
      (setf (out i) (add (out (- i 1)) (lst i)))
    )
    out))

(define (suffix-sum lst)
  (let (out (array (length lst) '(0)))
    (setf (out -1) (lst -1))
    (for (i (- (length lst) 2) 0 -1)
      (setf (out i) (add (out (+ i 1)) (lst i)))
    )
    out))

(define (minimize lst)
  (local (len pre suf min-diff idx-pre idx-suf)
    ;(setq out (array len '(0)))
    (setq len (length lst))
    (setq pre (prefix-sum lst))
    (setq suf (suffix-sum lst))
    (setq min-diff 9999999999999)
    (for (i 0 (- len 2))
      (setq diff (abs (sub (pre i) (suf (+ i 1)))))
      (setq min-diff (min min-diff diff))
    )
    min-diff))

(setq a '(7 9 5 10))
(minimize a)
;-> 1

(setq b '(16 14 13 13 12 10 9 3))
(minimize b)
;-> 4

Per sottoliste non-contigue la soluzione sarebbe:
sublist1: (16 13 13 3)
sublist2: (14 12 10 9)
sum1 = 16 + 13 + 13 + 3 = 45
sum2 = 14 + 12 + 10 + 9 = 45
differenza = 0


----------------------------------
Minimize difference of Sublist Sum
----------------------------------

Data una lista di numeri interi positivi, dividere la lista in due sottoliste minimizzando la differenza delle somme degli elementi delle sottoliste e restituire questo valore minimo.

Nota: In questo caso una "sottolista" (sublist) è una parte qualunque della lista (cioè un sottoinsieme di elementi qualunque).

Soluzione ricorsiva:

(define (find-min lst i sum-calculated sum-total)
  ; Se abbiamo raggiunto l'ultimo elemento
  ; la somma di una sublist vale sum-calculated e
  ; la somma dell'altra sublist vale sum-total - sum-calculated.
  ; Restituisce la differenza assoluta delle due somme.
  (cond ((zero? i)
          (abs (- (- sum-total sum-calculated) sum-calculated)))
        ; Per ogni elemento arr[i] abbiamo due scelte:
        ; (1) Non lo includiamo nella prima sublist
        ; (2) Lo includiamo nella prima sublist
        ; Restituisce il minimo delle due scelte.
        (true
         (min (find-min lst (- i 1) (+ sum-calculated (lst (- i 1))) sum-total)
              (find-min lst (- i 1) sum-calculated sum-total)))
  ))

(define (find-min-diff-sublist lst)
  (find-min lst (length lst) 0 (apply + lst)))

Facciamo un paio di prove:

(find-min-diff-sublist '(3 1 4 2 2 1))
;-> 1
Una possibile soluzione:
sublist1: (3 2 2)
sublist2: (1 4 1)
sum1 = 3 + 2 + 2 = 7
sum2 = 1 + 4 + 1 = 6
differenza = 7 - 6 = 1

(find-min-diff-sublist '(16 14 13 13 12 10 9 3))
;-> 0
Una possibile soluzione:
sublist1: (16 13 13 3)
sublist2: (14 12 10 9)
sum1 = 16 + 13 + 13 + 3 = 45
sum2 = 14 + 12 + 10 + 9 = 45
differenza = 45 - 45 = 0

Soluzione programmazione dinamica:

(define (find-min-diff-sublist lst)
  (local (n sum dp diff stop)
    (setq n (length lst))
    ; Calcola la somma di tutti gli elementi della lista
    (setq sum (apply + lst))
    ; Crea una lista per i risultati dei sottoproblemi
    (setq dp (array (+ n 1) (+ sum 1) '(nil)))
    ; Imposta la prima colonna a true
    ; somma 0 è possibile con tutti gli elementi 0
    (for (i 0 n) (setf (dp i 0) true))
    ; Imposta la prima riga, eccetto dp[0][0], a nil
    ; con 0 elementi, solo la somma 0 è possibile
    (for (j 1 sum) (setf (dp 0 j) nil))
    ; Riempie la matrice dp in modo bottom up
    (for (i 1 n)
      (for (j 1 sum)
            # Se l'i-esimo elemento è escluso
            (setf (dp i j) (dp (- i 1) j))
            # Se l'i-esimo elemento è incluso
            (if (<= (lst (- i 1)) j)
                (setf (dp i j) (or (dp i j) (dp (- i 1) (- j (lst (- i 1))))))
            )
      )
    )
    ; Imposta la somma massima
    (setq diff 999999999)
    ; Trova il j più grande tale che dp[n][j] sia true 
    ; per j che va da sum/2 a 0
    (setq stop nil)
    (for (j (/ sum 2) 0 -1 stop)
      (if (dp n j)
          (set 'diff (- sum (* 2 j)) 'stop true)
      )
    )
    diff))

Facciamo un paio di prove:

(find-min-diff-sublist '(3 1 4 2 2 1))
;-> 1
(find-min-diff-sublist '(16 14 13 13 12 10 9 3))
;-> 0


-----------------------------------
Bambini e caramelle (Candy Lottery)
-----------------------------------

Ci sono n bambini e ognuno di loro riceve un numero intero casuale (indipendente) di caramelle compreso tra 1 e k. 
Qual è il numero massimo atteso/previsto di caramelle che un bambino riceve?

              Sum[0, k-1] (i^n)
max-value = ---------------------
                     k^n

(define (max-candy n k)
  (let ((sum 0) (den (pow k n)))
    (for (i 0 (- k 1))
      (setq sum (add sum (pow i n)))
    )
    (println (sub k (div sum den)))))

(max-candy 2 3)
;-> 2.444444444444445

(max-candy 10 20)
;-> 18.64027620304199

(max-candy 1 2)
;-> 1.5


---------
DNS Query
---------

DNS è un servizio Internet che mappa i nomi di dominio, come rosettacode.org, in indirizzi IP, come 66.220.0.231.
Utilizzare DNS per risolvere www.kame.net su indirizzi IPv4 e IPv6.

Scriviamo una funzione che utilizza le primitive di newLISP per risolvere questo problema:

(define (dnsLookup site , ipv)
    ;; captures current IPv mode
    (set 'ipv (net-ipv))
    ;; IPv mode agnostic lookup
    (println "IPv4: " (begin (net-ipv 4) (net-lookup site)))
    (println "IPv6: " (begin (net-ipv 6) (net-lookup site)))
    ;; returns newLISP to previous IPv mode
    (net-ipv ipv)
)

(dnsLookup "www.newlisp.org")
;-> IPv4: 208.94.116.177
;-> IPv6: nil
;-> 4

Uso del comando "nslookup" di windows:

(! "nslookup www.newlisp.org")
;-> Server:  dsldevice.lan
;-> Address:  fe80::3291:8fff:fece:4a20
;-> 
;-> DNS request timed out.
;->     timeout was 2 seconds.
;-> Non-authoritative answer:
;-> Name:    newlisp.nfshost.com
;-> Address:  208.94.116.177
;-> Aliases:  www.newlisp.org

(dnsLookup "www.google.com")
;-> IPv4: 142.251.209.4
;-> IPv6: 2a00:1450:4002:411::2004
;-> 4

Uso del comando "nslookup" di windows:

(! "nslookup www.google.net")
;-> Server:  dsldevice.lan
;-> Address:  fe80::3291:8fff:fece:4a20
;-> 
;-> DNS request timed out.
;->     timeout was 2 seconds.
;-> Name:    www.google.com
;-> Address:  2a00:1450:4002:410::2004
;-> Aliases:  www.google.net


--------
Libreria
--------

Una libreria vende N libri diversi. Si conosce il prezzo e il numero di pagine di ogni libro.
Si decide di voler spendere la cifra X. 
Qual è il numero massimo di pagine che si possono acquistare? 
È possibile acquistare ogni libro al massimo una volta.

num-books: numero di libri (N)
total-expense: spesa totale (X)
pages: lista con il numero di pagine di ogni libro
prices: lista con i prezzi di ogni libro

(define (max-pages num-books total-expense prices s)
  (setq dp (array 100100 '(0)))
  (for (i 0 (- num-books 1))
    (for (j total-expense 1 -1)
      (if (>= j (prices i))
          (setf (dp j) (max (dp j) (+ (dp (- j (prices i))) (s i))))
      )
    )
  )
  (dp total-expense))

(setq libri 4)
(setq spesa 10)
(setq prezzo '(4 8 5 3))
(setq pagine '(5 12 8 1))

(max-pages libri spesa prezzo pagine)
;-> 13

(setq libri 1000)
(setq spesa 100)
(setq prezzo (map (fn(x) (+ x 1)) (rand 100 1000)))
(setq pagine (map (fn(x) (+ x 10)) (rand 250 1000)))

(max-pages libri spesa prezzo pagine)
;-> 6041


-------------------------------------------------
Probabilità della somma dei dadi in un intervallo
-------------------------------------------------

Lanciando un dado (da 1 a 6) n volte, qual è la probabilità che la somma dei risultati sia compresa tra a e b?

Soluzione con simulazione:

(define (simula lanci a b iter)
  (local (somma interno)
    (for (i 1 iter)
      (setq somma (apply + (map (fn(x) (+ x 1)) (rand 6 lanci))))
      (if (and (>= somma a) (<= somma b))
          (++ interno)
      )
    )
    (div interno iter)))

(simula 2 9 10 1e5)
;-> 0.19605
(simula 2 9 10 1e6)
;-> 0.194535
(simula 2 9 10 1e7)
;-> 0.1942656
(simula 2 9 10 1e8)
;-> 0.19448131

(simula 10 25 35 1e7)
;-> 0.5111362

Soluzione matematica:

(define (prob lanci a b)
  (let (dp (array 1000 200 '(0)))
    (setf (dp 0 0) 1)
    (for (j 1 lanci)
      (for (i 1 600)
        (for (k 1 6)
          (if (>= (- i k) 0)
              (setf (dp i j) (add (dp i j) (mul (dp (- i k) (- j 1)) (div 6))))
          )
        )
      )
    )
    (setq out 0)
    (for (i a b)
      (setq out (add out (dp i lanci)))
    )
    out))

(prob 2 9 10)
;-> 0.1944444444444444

(prob 10 25 35)
;-> 0.5110984693326727

=============================================================================

