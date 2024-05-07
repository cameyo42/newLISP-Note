================

 NOTE LIBERE 24

================

Trigrammi

     =========          ===   ===           ===   ===           ===   ===
     =========          ===   ===           ===   ===           =========
     =========          ===   ===           =========           ===   ===
  乾 qián Cielo 天    坤 kūn  Terra 地    震 zhèn Tuono 雷    坎 kǎn  Acqua 水

     =========          =========           =========           ===   ===
     ===   ===          =========           ===   ===           =========
     ===   ===          ===   ===           =========           =========
  艮 gèn  Monte 山    巽 xùn  Vento 風    離 lí   Fuoco 火    兌 duì  Lago  泽


---------------------------------
Numeri sommati alle proprie cifre
---------------------------------

Dato un numero intero positivo N, definiamo "autosomma digitale" il numero:

  ASD(N) = N + somma(cifre di N)

Sequenza OEIS: A062028
a(n) = n + sum of the digits of n.
  0, 2, 4, 6, 8, 10, 12, 14, 16, 18, 11, 13, 15, 17, 19, 21, 23, 25, 27,
  29, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 33, 35, 37, 39, 41, 43, 45,
  47, 49, 51, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 55, 57, 59, 61, 63,
  65, 67, 69, 71, 73, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 77, ...

(define (digit-sum num)
"Calculates the sum of the digits of an integer"
  (let (out 0)
    (while (!= num 0)
      (setq out (+ out (% num 10)))
      (setq num (/ num 10))
    )
    out))

(define (asd num) (+ num (digit-sum num)))

Proviamo:

(map asd (sequence 0 30))
;-> (0 2 4 6 8 10 12 14 16 18 11 13 15 17 19 21 23 25 27
;->  29 22 24 26 28 30 32 34 36 38 40 33)

Possiamo anche applicare ripetutamente la formula partendo da un numero N:

(define (repeat-asd num times) (collect (setq num (asd num)) times))

Proviamo:

(repeat-asd 480 10)
;-> (492 507 519 534 546 561 573 588 609 624)

(repeat-asd 480 10)

(repeat-asd 123 50)
;-> (129 141 147 159 174 186 201 204 210 213 219 231 237 249 264 276 291
;->  303 309 321 327 339 354 366 381 393 408 420 426 438 453 465 480 492
;->  507 519 534 546 561 573 588 609 624 636 651 663 678 699 723 735)

(intersect (repeat-asd 1 100) (repeat-asd 2 100))
;-> (4 8 16 23 28 38 49 62 70 77 91 101 103 107 115 122 127 137 148 161
;->  169 185 199 218 229 242 250 257 271 281 292 305 313 320 325 335 346
;->  359 376 392 406 416 427 440 448 464 478 497 517 530 538 554 568 587
;->  607 620 628 644 658 677 697 719 736 752 766 785 805 818 835 851 865
;->  884 904 917 934 950 964 983 1003 1007 1015 1022 1027 1037 1048 1061
;->  1069 1085 1099 1118 1129 1142 1150 1157 1171 1181 1192 1205 1213)


--------------------------------
Stima della popolazione mondiale
--------------------------------

Alla pagina web https://xkcd.com/1047/ viene proposto un metodo per calcolare la popolazione mondiale in funzione dell'anno.

I passi del metodo sono i seguenti:

1) Prendere le ultime due cifre dell'anno corrente.
2) Sottrarre il numero di anni bisestili (incluso l'anno corrente) dall'uragano Katrina (2005).
3) Per questo calcolo ogni anno divisibile per 4 è considerato bisestile.
4) Aggiungere un punto decimale tra i due numeri (equivale a dividere per 10).
5) Aggiungere 6. Questo restituisce il risultato in miliardi di persone.

Per gli anni precedenti al 2005 il numero di anni bisestili è negativo.

(define (leap? year) (zero? (% year 4)))

(define (world-pop year)
  (setq p (int (slice (string year) -2) 0 10))
  (if (> year 2004)
    (setq p (- p (length (filter leap? (sequence 2005 year)))))
    ;else
    (setq p (+ p (length (filter leap? (sequence year 2005))))))
  (setq p (div p 10))
  (setq p (add p 6)))

Proviamo:

(world-pop 2024)
;-> 7.9

(map (fn(x) (list x (world-pop x))) (sequence 2000 2030))
;-> ((2000 6.2) (2001 6.2) (2002 6.3) (2003 6.4) (2004 6.5) (2005 6.5)
;->  (2006 6.6) (2007 6.7) (2008 6.7) (2009 6.8) (2010 6.9) (2011 7)
;->  (2012 7)   (2013 7.1) (2014 7.2) (2015 7.3) (2016 7.3) (2017 7.4)
;->  (2018 7.5) (2019 7.6) (2020 7.6) (2021 7.7) (2022 7.8) (2023 7.9)
;->  (2024 7.9) (2025 8) (2026 8.1) (2027 8.199999999999999)
;->  (2028 8.199999999999999) (2029 8.300000000000001) (2030 8.4))

(world-pop 2050)
;-> 9.9


--------------------------------------
Frequenza delle cifre nei numeri primi
--------------------------------------

Dato un numero intero positivo N, determinare la frequenza delle cifre dei numeri primi da 1 a N compreso.

(define (primes-to num)
"Generates all prime numbers less than or equal to a given number"
  (cond ((= num 1) '())
        ((= num 2) '(2))
        (true
         (let ((lst '(2)) (arr (array (+ num 1))))
          (for (x 3 num 2)
            (when (not (arr x))
              (push x lst -1)
              (for (y (* x x) num (* 2 x) (> y num))
                (setf (arr y) true)))) lst))))

(define (prime-digit N)
  (local (primi cifre)
    (setq primi (primes-to N))
    (setq cifre (flat (map (fn(x) (explode (string x))) primi)))
    (count '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9") cifre))

Proviamo:

(prime-digit 1e5)
;-> (2725 6353 3906 6229 3772 3816 3741 6172 3690 6130)

Vediamo le percentuali delle cifre:

(define (perc-list lst)
  (let (somma (apply add lst))
    (map (fn(x) (mul (div x somma) 100)) lst)))

N = 1e5
(map (fn(x) (list $idx x)) (perc-list (prime-digit 1e5)))
;-> ((0 5.855933296084583)
;->  (1 13.65238320367903)
;->  (2 8.393862552112434)
;->  (3 13.38591137662784)
;->  (4 8.105901061589375)
;->  (5 8.200455580865604)
;->  (6 8.039283104826577)
;->  (7 13.26342029483818)
;->  (8 7.929685821120041)
;->  (9 13.17316370825633))

N = 1e6
(map (fn(x) (list $idx x)) (perc-list (prime-digit 1e6)))
;-> ((0 6.598256408026611)
;->  (1 12.96475857121117)
;->  (2 8.60316977194165)
;->  (3 12.7769202339283)
;->  (4 8.480118268582734)
;->  (5 8.459464747700936)
;->  (6 8.416635867556579)
;->  (7 12.68060960497424)
;->  (8 8.379024719003414)
;->  (9 12.64104180707438))

N = 1e7
(time (println (map (fn(x) (list $idx x)) (perc-list (prime-digit 1e7)))))
;-> ((0 7.104227319142836)
;->  (1 12.49649043942)
;->  (2 8.780772627158969)
;->  (3 12.37579004838755)
;->  (4 8.711688255897981)
;->  (5 8.679732350663677)
;->  (6 8.671074886625577)
;->  (7 12.28496338769417)
;->  (8 8.644269624553182)
;->  (9 12.25099106045606))
;-> 5688.478

N = 1e8
(time (println (map (fn(x) (list $idx x)) (perc-list (prime-digit 1e8)))))
;-> ((0 7.470598595490779)
;->  (1 12.15470533307439)
;->  (2 8.928205089181605)
;->  (3 12.07050800831849)
;->  (4 8.872339691088259)
;->  (5 8.857409460525487)
;->  (6 8.839704487748509)
;->  (7 12.00566550306154)
;->  (8 8.819204921660404)
;->  (9 11.98165890985055))
;-> 61818.008

============================================================================

