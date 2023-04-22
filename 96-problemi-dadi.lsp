
; Functions
(define (die s) (+ (rand s) 1))
(define (die6) (+ (rand 6) 1))
(define (dice n s) (+ n (apply + (rand s n))))
(define (dice6 n) (+ n (apply + (rand 6 n))))
(define (dice-lst n s) (map (curry + 1) (rand s n)))
(define (dice6-lst n) (map (curry + 1) (rand 6 n)))
(define (dice-lst-freq n s) (count (sequence 1 s) (dice-lst n s)))
(define (dice6-lst-freq n) (count '(1 2 3 4 5 6) (dice6-lst n)))
(define (one-in prob) (int (add 0.5 (div prob))))
(define (rand-pick lst)
  (local (rnd stop out)
    (while (= (setq rnd (random)) 1))
    (setq stop nil)
    (dolist (p lst stop)
      (setq rnd (sub rnd p))
      (if (< rnd 0) (set 'out $idx 'stop true))
    )
    out))


                   ===================
                    PROBLEMI SUI DADI
                   ===================

              A Collection of Dice Problems
           with solutions and useful appendices
             (a work continually in progress)
            version July 3, 2022 (76 problems)

                     Matthew M. Conroy
            doctormatt "at" madandmoonly dot com

https://www.madandmoonly.com/doctormatt/mathematics/dice1.pdf
http://www.matthewconroy.com/

Conroy solves the problems mathematically (very informative and interesting).
Here, I try solve the problems with simulations (if I am able...).


========================
 Problem Solving Status
========================

+ = solved
- = unsolved

1. Standard Dice (1..26)
1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26
+  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +

2. Dice Sums (27..45)
27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45
+  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +  +

3. Non-standard Dice (46..55)
46 47 48 49 50 51 52 53 54 55
+  +  -  -  -  -  -  -  -  -

4. Game with Dice (56..76)
56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76
-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -


===================
 General Functions
===================

; roll a die with S sides
(define (die s) (+ (rand s) 1))

; roll a die with 6 sides
(define (die6) (+ (rand 6) 1))

; roll N die with S sides and return the sum of numbers
(define (dice n s) (+ n (apply + (rand s n))))
(dice 10 4)
;-> 19

; roll N die with 6 sides and return the sum of numbers
(define (dice6 n) (+ n (apply + (rand 6 n))))
(dice6 10)
;-> 38

; roll N die with S sides and return the list of numbers
(define (dice-lst n s) (map (curry + 1) (rand s n)))
(dice-lst 4 8)
;-> (7 7 5 3)

; roll N die with 6 sides and return the list of numbers
(define (dice6-lst n) (map (curry + 1) (rand 6 n)))
(dice6-lst 5)
;-> (1 3 2 6 2)

; roll N die with s sides and return a list with the frequency of all faces
(define (dice-lst-freq n s) (count (sequence 1 s) (dice-lst n s)))
(dice-lst-freq 20 8)
;-> (3 3 3 4 0 5 1 1)

; roll N die with 6 sides and return a list with the frequency of all faces
(define (dice6-lst-freq n) (count '(1 2 3 4 5 6) (dice6-lst n)))
(dice6-lst-freq 12)
;-> (1 3 0 4 3 1)

; convert probability (0..1) to "1 in x events"
(define (one-in prob) (int (add 0.5 (div prob))))
(one-in 0.5)
;-> 2

; simulate a non-fair dice
; get a list of N probabilities (one prob for each faces)
; and return a random number (0..N-1) with the distribution
; of the probabilities predefined
(define (rand-pick lst)
  (local (rnd stop out)
    ; generiamo un numero random diverso da 1
    ; (per evitare errori di arrotondamento)
    (while (= (setq rnd (random)) 1))
    (setq stop nil)
    (dolist (p lst stop)
      ; sottraiamo la probabilità corrente al numero random...
      (setq rnd (sub rnd p))
      ; se il risultato è minore di zero,
      ; allora restituiamo l'indice della probabilità corrente
      (if (< rnd 0)
          (set 'out $idx 'stop true)
      )
    )
    out))

(setq dice4-prob '(0.05 0.15 0.35 0.45))

Nota: la somma delle probabilità deve valere 1.
(apply add dice4-prob)
;-> 1

(rand-pick dice4-prob)
;-> 2

Facciamo alcune prove per verificare la correttezza della funzione:

(setq dice4-prob '(0.05 0.15 0.35 0.45))
(apply add dice4-prob)
;-> 1
(setq vet (array 4 '(0)))
;-> (0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick dice4-prob))))
vet
;-> (50087 150175 349614 450124)
(apply + vet)
;-> 1000000

(setq dice6-prob '(0.01 0.01 0.01 0.77 0.1 0.1))
(apply add dice6-prob)
;-> 1
(setq vet (array 6 '(0)))
;-> (0 0 0 0 0 0)
(for (i 0 999999) (++ (vet (rand-pick dice6-prob))))
vet
;-> (9821 10070 9923 770122 100288 99776)

Note: Number of iterations (minimum) = 1e6 (if possible)

Note: The function "time" return the time elapsed in milliseconds.


==========================
 1. Standard Dice (1..26)
==========================

---------
Problem 1
---------
On average, how many times must a 6-sided die be rolled until a 6 turns up?

Solution = 6

(define (p1 iter)
  (local (sum trial)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 1)
      (until (= (die6) 6)
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p1 1e6)))
;-> 6.008071
;-> 761.984


---------
Problem 2
---------
On average, how many times must a 6-sided die be rolled until a 6 turns up twice in a row?

Solution = 42

(define (p2 iter)
  (local (sum trial prev pair val)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq prev nil)
      (setq pair nil)
      (until pair
        (setq val (die6))
        (cond ((and (= val 6) prev) (setq pair true))
              ((= val 6) (setq prev true))
              (true (setq prev nil))
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p2 1e6)))
;-> 41.991021
;-> 8495.761


---------
Problem 3
---------
On average, how many times must a 6-sided die be rolled until the sequence 65 appears (i.e., a 6 followed by a 5)?

Solution = 36

(define (p3 iter)
  (local (sum trial prev pair val)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq prev nil)
      (setq pair nil)
      (until pair
        (setq val (die6))
        (cond ((and (= val 5) prev) (setq pair true))
              ((= val 6) (setq prev true))
              (true (setq prev nil))
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p3 1e6)))
;-> 36.000682
;-> 7318.514


---------
Problem 4
---------
On average, how many times must a 6-sided die be rolled until there are two rolls in a row that differ by 1 (such as a 2 followed by a 1 or 3, or a 6 followed by a 5)?
What if we roll until there are two rolls in a row that differ by no more than 1 (so we stop at a repeated roll, too)?

Solution 1 = 4.68627450980
Solution 2 = 3.278260869565

(define (p4-1 iter)
  (local (sum trial prev differ1 val)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq prev -99)
      (setq differ1 nil)
      (until differ1
        (setq val (die6))
        (cond ((= (abs (- val prev)) 1) (setq differ1 true))
              (true (setq prev val))
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p4-1 1e6)))
;-> 4.68883
;-> 1093.942

(define (p4-2 iter)
  (local (sum trial prev differ1 val)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq prev -99)
      (setq differ1 nil)
      (until differ1
        (setq val (die6))
        (cond ((<= (abs (- val prev)) 1) (setq differ1 true))
              (true (setq prev val))
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p4-2 1e6)))
;-> 3.27747
;-> 803.129


---------
Problem 5
---------
We roll a 6-sided die n times. What is the probability that all faces have appeared?

Solution =
   n  Exact values                 Approximate values
   1  0                            0
   2  0                            0
   3  0                            0
   4  0                            0
   5  0                            0
   6  5/324                        0.01543210
   7  35/648                       0.05401235
   8  665/5832                     0.11402606
   9  245/1296                     0.18904321
  10  38045/139968                 0.27181213
  11  99715/279936                 0.35620642
  12  1654565/3779136              0.43781568
  13  485485/944784                0.51385819
  14  317181865/544195584          0.58284535
  15  233718485/362797056          0.64421274
  16  2279105465/3265173504        0.69800440
  17  4862708305/6530347008        0.74463245
  18  553436255195/705277476864    0.78470712
  19  1155136002965/1410554953728  0.81892308
  20  2691299309615/3173748645888  0.84798754
  36                               0.99154188

(define (p5 n iter)
  (local (sum faces)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 7))
      (setf (faces 0) -1)
      (for (j 1 n)
        (++ (faces (die6)))
      )
      (if (not (ref 0 faces)) (++ sum))
    )
    (div sum iter)))

(time (println (p5 20 1e6)))
;-> 0.847704
;-> 3000.267

(define (test-p5 n)
  (for (i 1 n) (println i { } (p5 i 1e6))))

(time (test-p5 36))
;->  1 0
;->  2 0
;->  3 0
;->  4 0
;->  5 0
;->  6 0.015385
;->  7 0.053868
;->  8 0.113604
;->  9 0.189396
;-> 10 0.271885
;-> 11 0.356252
;-> 12 0.438
;-> 13 0.513837
;-> 14 0.582553
;-> 15 0.644249
;-> 16 0.698467
;-> 17 0.744921
;-> 18 0.7846
;-> 19 0.819185
;-> 20 0.848105
;-> 21 0.872557
;-> 22 0.892951
;-> 23 0.910738
;-> 24 0.924831
;-> 25 0.937707
;-> 26 0.947833
;-> 27 0.956693
;-> 28 0.963554
;-> 29 0.969738
;-> 30 0.974813
;-> 31 0.979082
;-> 32 0.982314
;-> 33 0.985501
;-> 34 0.987878
;-> 35 0.989893
;-> 36 0.991443
;-> 100587.521 ; 100 seconds


---------
Problem 6
---------
We roll a 6-sided die n times. What is the probability that all faces have appeared in order, in some six consecutive rolls (i.e., what is the probability that the subsequence 123456 appears among the n rolls)?

Solution =
      n   prob
      6   0.00002143347051
     10   0.0001071673525
     20   0.0003214813850
     50   0.0009641479102
    100   0.002034340799
    200   0.004171288550
    500   0.01055471585
   1000   0.02110296021
   2000   0.04186329068
   5000   0.1015397384
  10000   0.1928556782

(define (p6 n iter)
  (local (sum)
    (setq sum 0)
    (for (i 1 iter)
      (if (match '(* 1 2 3 4 5 6 *) (dice6-lst n))
        (++ sum)
      )
    )
    (div sum iter)))

(time (println (p6 6 1e6)))
;-> 0.00002700
;-> 858.821
(time (println (p6 10 1e6)))
;-> 0.000107
;-> 1244.377
(time (println (p6 20 1e6)))
;-> 0.000342
;-> 2199.397
(time (println (p6 50 1e6)))
;-> 0.000984
;-> 5087.946
(time (println (p6 100 1e6)))
;-> 0.002134
;-> 9805.423000000001
(time (println (p6 200 1e6)))
;-> 0.004151
;-> 19308.951
(time (println (p6 500 1e6)))
;-> 0.010528
;-> 47747.793
(time (println (p6 1000 1e6)))
;-> 0.020992
;-> 96440.39
(time (println (p6 2000 1e6)))
;-> 0.041803
;-> 194294.68
(time (println (p6 5000 1e5)))
;-> 0.10071
;-> 49892.692
(time (println (p6 10000 1e5)))
;-> 0.19275
;-> 104299.682

For (n > 1000) the following expression is a quite good approximation:

                    1
  prob ≈ 1 - (1 - -----)^n
                   6^6


---------
Problem 7
---------
We roll a 6-sided die n times.
What is the probability that all faces have appeared in some order in some six consecutive rolls?
What is the expected number of rolls until such a sequence appears?

Solution =

The probability that we have had a run of six distinct faces in six consecutive rolls after rolling n times:

    n  prob(n)
    6  0.015432098765432
    7  0.028292181069958
    8  0.040723593964334
    9  0.052940672153635
   10  0.065002953055936
   11  0.076924328735457
   12  0.088693222472014
   13  0.100311784227929
   14  0.111782118026154
   15  0.123106206915980
   16  0.134285932624874
   17  0.145323126219390
   18  0.156219603871238
   19  0.166977159634352
   20  0.177597564757422
  ...
  544  0.999011257908158

The expect number of rolls until six distinct faces appear in six consecutive rolls:

  E = 83.2

(define (p7-1 n iter)
  (local (success roll found)
    (setq success 0)
    (for (i 1 iter)
      (setq roll (dice6-lst n))
      (setq found nil)
      (for (k 0 (- n 6) 1 found)
        (if (= (sort (slice roll k 6)) '(1 2 3 4 5 6)) (setq found true))
      )
      (if found (++ success))
    )
    (div success iter)))

(time (for (n 6 20) (println n { } (p7-1 n 1e6))))

;->  6 0.015528
;->  7 0.028403
;->  8 0.040712
;->  9 0.05272
;-> 10 0.064964
;-> 11 0.077047
;-> 12 0.088167
;-> 13 0.100323
;-> 14 0.11155
;-> 15 0.123212
;-> 16 0.134386
;-> 17 0.145571
;-> 18 0.155803
;-> 19 0.167233
;-> 20 0.17747
;-> 70120.217

(time (println "544" { } (p7-1 544 1e6)))
;-> 544 0.999043
;-> 74985.561

(define (p7-2 iter)
  (local (sum found trial roll nums)
    (setq sum 0)
    (for (i 1 iter)
      (setq found nil)
      ; at least 6 dice are needed to find the sequence
      (setq trial 5)
      ; first roll
      (setq roll (dice6-lst 6))
      (until found
        ; check unique digits on current sequence
        (if (= (sort (copy roll)) '(1 2 3 4 5 6)) (setq found true))
        (++ trial)
        ; new roll
        (pop roll) (push (die6) roll -1)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p7-2 1e6)))
;-> 83.30385
;-> 37709.552


---------
Problem 8
---------
Person A rolls n dice and person B rolls m dice.
What is the probability that they have a common face showing (e.g., person A rolled a 2 and person B also rolled a 2, among all their dice)?

Solution =
   n   m   prob.
   1   1   0.1666666
   1   2   0.3055555
   2   2   0.5138888
   1   3   0.4212962
   2   3   0.6566358
   3   3   0.7910236
   1   4   0.5177469
   2   4   0.7550154
   3   4   0.8695773
   4   4   0.9276084
   5   5   0.9780956
   6   6   0.9938971

(define (p8 n m iter)
  (local (sum a b)
    (setq sum 0)
    (for (i 1 iter)
      (setq a (dice6-lst n))
      (setq b (dice6-lst m))
      (if (intersect a b) (++ sum))
    )
    (div sum iter)))

(p8 1 1 1e6)
;-> 0.166295
(p8 1 2 1e6)
;-> 0.305687
(p8 2 2 1e6)
;-> 0.513849
(p8 1 3 1e6)
;-> 0.421542
(p8 2 3 1e6)
;-> 0.656901
(p8 3 3 1e6)
;-> 0.791544
(p8 1 4 1e6)
;-> 0.518101
(p8 2 4 1e6)
;-> 0.754937
(p8 3 4 1e6)
;-> 0.869145
(p8 4 4 1e6)
;-> 0.92736
(p8 5 5 1e6)
;-> 0.97803
(p8 6 6 1e6)
;-> 0.993827


---------
Problem 9
---------
On average, how many times must a 6-sided die be rolled until all sides appear at least once?
What about for an n-sided die?

Solution = 14.7

(define (p9 n iter)
  (local (sum faces found trial)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup nil (+ n 1)))
      (setf (faces 0) true)
      (setq found nil)
      (setq trial 0)
      (until found
        (setf (faces (die n)) true)
        (setq found (= (length (ref-all 'true faces)) (+ n 1)))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p9 6 1e6)))
;-> 14.705402
;-> 5548.258

For a die with n faces:

  prob = n*Sum[i=1..n](1/i)

(define (p9-exact n)
  (let (sum 0)
    (for (i 1 n)
      (setq sum (add sum (div i)))
    )
    (mul n sum)))

(p9-exact 100)
;-> 518.737751763962

(time (println (p9 100 1e5)))
;-> 518.29085
;-> 104390.523


----------
Problem 10
----------
On average, how many times must a 6-sided die be rolled until all sides appear at least twice?

Solution = 24.1338692...

(define (p10 n iter)
  (local (sum faces found trial)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 (+ n 1)))
      (setf (faces 0) 2)
      (setq found nil)
      (setq trial 0)
      (until found
        (++ (faces (die n)))
        ; all numbers of faces are greater or equal 2?
        (if (= (length (find-all 2 faces $it <=)) (+ n 1))
            (setq found true)
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p10 6 1e6)))
;-> 24.135915
;-> 18805.147

Calculate the probability that after j rolls all sides have appeared at least twice.

Solution =
   j   prob
  11   0
  12   0.003438285
  13   0.014899238
  14   0.037661964
  15   0.072748752
  16   0.119155589
  17   0.174576398
  18   0.236147670
  19   0.301007601
  20   0.366633348
  21   0.430995652
  22   0.492589321
  23   0.550391734
  30   0.828548154
  34   0.906280939
  39   0.957121359
  49   0.991461443
  62   0.999009173

This problem is an example of what is often referred to as a Coupon Collector's problem.

(define (p10-2 n nroll iter)
  (local (sum faces)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 (+ n 1)))
      (setf (faces 0) 2)
      (for (j 1 nroll) (++ (faces (die n))))
      ; all numbers of faces are greater or equal 2?
      (if (= (length (find-all 2 faces $it <=)) (+ n 1)) (++ sum))
    )
    (div sum iter)))

(time (for (j 11 49) (println j { } (p10-2 6 j 1e6))))
;-> 11 0
;-> 12 0.003449
;-> 13 0.014824
;-> 14 0.037528
;-> 15 0.072657
;-> 16 0.119407
;-> 17 0.175054
;-> 18 0.235637
;-> 19 0.300605
;-> 20 0.36671
;-> 21 0.430828
;-> 22 0.493054
;-> 23 0.551049
;-> 24 0.604159
;-> 25 0.652677
;-> 26 0.695583
;-> 27 0.735347
;-> 28 0.770919
;-> 29 0.802058
;-> 30 0.828042
;-> 31 0.852119
;-> 32 0.872932
;-> 33 0.890399
;-> 34 0.906171
;-> 35 0.919331
;-> 36 0.93114
;-> 37 0.941177
;-> 38 0.94958
;-> 39 0.957342
;-> 40 0.96317
;-> 41 0.968737
;-> 42 0.973105
;-> 43 0.977453
;-> 44 0.980842
;-> 45 0.983586
;-> 46 0.985973
;-> 47 0.988242
;-> 48 0.98998
;-> 49 0.991628
;-> 202823.933
(time (println 62 { } (p10-2 6 62 1e6)))
;-> 62 0.999015
;-> 9847.644


-----------
Problema 11
-----------
On average, how many times must a pair of 6-sided dice be rolled until all sides appear at least once?

Solution = 7.59945887445...

(define (p11 n iter)
  (local (sum faces found trial)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 (+ n 1)))
      (setf (faces 0) 1)
      (setq found nil)
      (setq trial 0)
      (until found
        ; rolls two dice
        (++ (faces (die n)))
        (++ (faces (die n)))
        ; all numbers of faces are greater or equal 2?
        (if (= (length (find-all 1 faces $it <=)) (+ n 1))
            (setq found true)
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p11 6 1e6)))
;-> 7.599961
;-> 7398.658


----------
Problem 12
----------
Suppose we roll n dice.
What is the expected number of distinct faces that appear?

Solution =
    n   E
    1   1
    2   1.833333
    3   2.527777
    4   3.106481481
    5   3.588734...
    6   3.990612...
    7   4.325510...
    8   4.604591...
    9   4.837159...
   10   5.030966...
   14   5.532680...
   23   5.909430...
   27   5.956322...
   36   5.991535...
   48   5.999050...

(define (p12 n iter)
  (local (sum)
    (setq sum 0)
    (for (i 1 iter)
      (++ sum (length (unique (dice6-lst n))))
    )
    (div sum iter)))

(time (for (n 1 48) (println n { } (p12 n 1e6))))
;-> 1 1
;-> 2 1.833859
;-> 3 2.528731
;-> 4 3.106721
;-> 5 3.588687
;-> 6 3.991302
;-> 7 4.325726
;-> 8 4.603786
;-> 9 4.837814
;-> 10 5.030227
;-> 11 5.19259
;-> 12 5.327828
;-> 13 5.438742
;-> 14 5.53269
;-> 15 5.61021
;-> 16 5.675945
;-> 17 5.730029
;-> 18 5.774289
;-> 19 5.81153
;-> 20 5.842915
;-> 21 5.869354
;-> 22 5.891612
;-> 23 5.909854
;-> 24 5.924193
;-> 25 5.936624
;-> 26 5.947644
;-> 27 5.956269
;-> 28 5.963438
;-> 29 5.969837
;-> 30 5.974563
;-> 31 5.978807
;-> 32 5.982656
;-> 33 5.985494
;-> 34 5.987834
;-> 35 5.989852
;-> 36 5.991497
;-> 37 5.992909
;-> 38 5.994039
;-> 39 5.994992
;-> 40 5.995903
;-> 41 5.996482
;-> 42 5.997188
;-> 43 5.997674
;-> 44 5.998017
;-> 45 5.99837
;-> 46 5.998611
;-> 47 5.99887
;-> 48 5.99909
;-> 223381.002

----------
Problem 13
----------
Suppose we roll n dice and keep the highest one.
What is the distribution of values?

Solution = the probability that, if n dice are rolled, the highest number to turn up will be k is

                k^n - (k - 1)^n
  prob(n,k) = -------------------
                      6^n

(define (p13-exact n k)
  (div (sub (pow k n) (pow (sub k 1) n))
       (pow 6 n)))

(p13-exact 7 3)
;-> 0.007355252629172382

(for (n 1 10)
  (println "dice: " n)
  (for (k 1 6)
    ;(println n { } k { } ((p13-exact n k))))
    ;(println n { } k { } ((p13-exact n k))))
    ;(println (format "%4d %4d %8.4f" n k (p13-exact n k)))))
    (print (format " %2d %6.4f" k (p13-exact n k)))
  )
  (println))
;-> dice: 1
;->   1 0.1667  2 0.1667  3 0.1667  4 0.1667  5 0.1667  6 0.1667
;-> dice: 2
;->   1 0.0278  2 0.0833  3 0.1389  4 0.1944  5 0.2500  6 0.3056
;-> dice: 3
;->   1 0.0046  2 0.0324  3 0.0880  4 0.1713  5 0.2824  6 0.4213
;-> dice: 4
;->   1 0.0008  2 0.0116  3 0.0502  4 0.1350  5 0.2847  6 0.5177
;-> dice: 5
;->   1 0.0001  2 0.0040  3 0.0271  4 0.1004  5 0.2702  6 0.5981
;-> dice: 6
;->   1 0.0000  2 0.0014  3 0.0143  4 0.0722  5 0.2471  6 0.6651
;-> dice: 7
;->   1 0.0000  2 0.0005  3 0.0074  4 0.0507  5 0.2206  6 0.7209
;-> dice: 8
;->   1 0.0000  2 0.0002  3 0.0038  4 0.0351  5 0.1935  6 0.7674
;-> dice: 9
;->   1 0.0000  2 0.0001  3 0.0019  4 0.0241  5 0.1678  6 0.8062
;-> dice: 10
;->   1 0.0000  2 0.0000  3 0.0010  4 0.0164  5 0.1442  6 0.8385

(define (p13 n iter)
  (local (lst freq prob)
    (setq lst '())
    (for (i 1 iter)
      (push (apply max (dice6-lst n)) lst -1)
    )
    (setq freq (count '(1 2 3 4 5 6) lst))
    (setq prob (map (fn(x) (div x iter)) freq))
    ;(println freq { } prob)
    prob))

(p13 7 1e6)
;-> (6e-006 0.000442 0.007363 0.050972 0.219704 0.721513)

(time (for (n 1 10) (println n { } (p13 n 1e6))))
;-> 1  (0.166603 0.167335 0.166213 0.166191 0.166555 0.167103)
;-> 2  (0.027601 0.083129 0.138378 0.194765 0.250341 0.305786)
;-> 3  (0.004629 0.032263 0.088042 0.171574 0.282297 0.421195)
;-> 4  (0.000821 0.011472 0.049987 0.13401 0.285015 0.518695)
;-> 5  (0.000129 0.003939 0.027033 0.100233 0.26997 0.598696)
;-> 6  (1.6e-005 0.001361 0.01433 0.072286 0.247107 0.6649)
;-> 7  (2e-006 0.000483 0.00747 0.050509 0.220155 0.721381)
;-> 8  (0 0.000171 0.003793 0.035 0.193767 0.767269)
;-> 9  (0 5.1e-005 0.001917 0.023898 0.168053 0.806081)
;-> 10 (0 1e-005 0.000945 0.016373 0.14395 0.838722)
;-> 11282.673


----------
Problem 14
----------
Suppose we can roll a 6-sided die up to n times.
At any point we can stop, and that roll becomes our "score".
Our goal is to get the highest possible score, on average.
How should we decide when to stop?

Solution =

          floor(f(n-1))
  f(n) = ---------------*f(n-1) + Sum[j=floor(f(n-1))+1..s] (j/s)
               s

Valore atteso 1 dado
(div (apply + (sequence 1 6)) 6)
;-> 3.5
(div (dice6 1e6) 1e6)
;-> 3.499703

(setq *limits* '(0 3.5))

(define (p14 n iter)
  (local (sum curr stop val)
    (setq sum 0)
    (for (i 1 iter)
      (setq curr 0)
      (setq stop nil)
      (for (j 1 n 1 stop)
        (setq val (die6))
        (if (> val (*limits* (- n 1)))
          ; stick on this
          (setq curr val stop true)
          ; else
          ; stick on last roll
          (if (= j n) (setq curr val))
        )
      )
      (++ sum curr)
    )
    (push (div sum iter) *limits* -1)
    (div sum iter)))

(time (for (i 2 10) (println i { } (p14 i 1e6))))
;-> 2  4.250644
;-> 3  4.608175
;-> 4  4.907549
;-> 5  5.103784
;-> 6  4.997978
;-> 7  5.324007
;-> 8  5.303848
;-> 9  5.41803
;-> 10 5.515014
;-> 7292.307

*limits*
;-> (0 3.5 4.250644 4.608175 4.907549 5.103784
;->  4.997978 5.324007 5.303848 5.41803 5.515014)


-----------
Problema 15
-----------
How many dice must be rolled to have at least a 95% chance of rolling a six?
99%? 99.9%?

Solution =
  95% for (n >= 17)
  99% for (n >= 26)
  99.9% for (n >= 38)

(define (p15 dice iter)
  (local (sum six)
    (setq sum 0)
    (for (i 1 iter)
      (setq six nil)
      (for (d 1 dice 1 six) (if (= (die6) 6) (setq six true)))
      (if six (++ sum))
    )
    (div sum iter)))

(time (for (d 1 40) (println d { } (p15 d 1e6))))
;-> 1 0.166271
;-> 2 0.305417
;-> 3 0.421026
;-> 4 0.517103
;-> 5 0.597869
;-> 6 0.665168
;-> 7 0.720985
;-> 8 0.767632
;-> 9 0.806316
;-> 10 0.838425
;-> 11 0.865469
;-> 12 0.888022
;-> 13 0.906149
;-> 14 0.922279
;-> 15 0.935188
;-> 16 0.946048
;-> 17 0.954735 ; 95%
;-> 18 0.96227
;-> 19 0.969071
;-> 20 0.973798
;-> 21 0.978006
;-> 22 0.981885
;-> 23 0.984865
;-> 24 0.987278
;-> 25 0.989575
;-> 26 0.991304 ; 99%
;-> 27 0.992539
;-> 28 0.993919
;-> 29 0.995024
;-> 30 0.995713
;-> 31 0.99657
;-> 32 0.997112
;-> 33 0.997546
;-> 34 0.997959
;-> 35 0.998352
;-> 36 0.998578
;-> 37 0.998755
;-> 38 0.999021 ; 99.9%
;-> 39 0.999249
;-> 40 0.999294
;-> 33032.014


----------
Problem 16
----------
How many dice must be rolled to have at least a 95% chance of rolling a one and a two?
What about a one, a two, and a three?
What about a one, a two, a three, a four, a five and a six?

Solution =
  (1,2) (n >= 21)
  (1,2,3) (n >= 23)
  (1,2,3,4,5,6) (n >= 27)

(define (p16-1 dice iter)
  (local (sum one two)
    (setq sum 0)
    (for (i 1 iter)
      (setq one nil two nil)
      (for (d 1 dice 1 (and one two))
        (setq val (die6))
        (cond ((= val 1) (setq one true))
              ((= val 2) (setq two true))
        )
      )
      (if (and one two) (++ sum))
    )
    (div sum iter)))

(time (for (d 1 25) (println d { } (p16-1 d 1e6))))
;-> 1 0
;-> 2 0.05559
;-> 3 0.13883
;-> 4 0.233121
;-> 5 0.327592
;-> 6 0.418627
;-> 7 0.501204
;-> 8 0.574853
;-> 9 0.63789
;-> 10 0.694277
;-> 11 0.742869
;-> 12 0.78304
;-> 13 0.818369
;-> 14 0.846931
;-> 15 0.872646
;-> 16 0.893039
;-> 17 0.91136
;-> 18 0.925608
;-> 19 0.938207
;-> 20 0.948131
;-> 21 0.956454 ; 95%
;-> 22 0.964159
;-> 23 0.969966
;-> 24 0.974815
;-> 25 0.9790410000000001
;-> 32986.911

(define (p16-2 dice iter)
  (local (sum one two three)
    (setq sum 0)
    (for (i 1 iter)
      (setq one nil two nil three nil)
      (for (d 1 dice 1 (and one two three))
        (setq val (die6))
        (cond ((= val 1) (setq one true))
              ((= val 2) (setq two true))
              ((= val 3) (setq three true))
        )
      )
      (if (and one two three) (++ sum))
    )
    (div sum iter)))

(time (for (d 20 30) (println d { } (p16-2 d 1e6))))
;-> 20 0.922536
;-> 21 0.935449
;-> 22 0.946124
;-> 23 0.954843 ; 95%
;-> 24 0.962767
;-> 25 0.968441
;-> 26 0.973769
;-> 27 0.978481
;-> 28 0.981875
;-> 29 0.984878
;-> 30 0.987334
;-> 24579.861

(define (p16-3 dice iter)
  (local (sum one two three four five six)
    (setq sum 0)
    (for (i 1 iter)
      (setq one nil two nil three nil four nil five nil six nil)
      (for (d 1 dice 1 (and one two three four five six))
        (setq val (die6))
        (cond ((= val 1) (setq one true))
              ((= val 2) (setq two true))
              ((= val 3) (setq three true))
              ((= val 4) (setq four true))
              ((= val 5) (setq five true))
              ((= val 6) (setq six true))
        )
      )
      (if (and one two three four five six) (++ sum))
    )
    (div sum iter)))

(time (for (d 25 35) (println d { } (p16-3 d 1e6))))
;-> 25 0.937842
;-> 26 0.948049
;-> 27 0.956697 ; 95%
;-> 28 0.963901
;-> 29 0.96983
;-> 30 0.974597
;-> 31 0.97866
;-> 32 0.982467
;-> 33 0.985335
;-> 34 0.987913
;-> 35 0.98992
;-> 40014.731


----------
Problem 17
----------
How many dice should be rolled to maximize the probability of rolling exactly one six?
two sixes? n sixes?

Solution =
The probability that exactly one is a six rolling n dice is:
  n   prob
  1 = 0.1666...
  2 = 0.2777...
  3 = 0.3472...
  4 = 0.3858...
  5 = 0.4018...
  6 = 0.4018...

  (6) (max prob for n=5 or n=6)
  (6 6) (max prob for n=11 or n=12)
  (6 ... 6) (max prob for n=6*n-1 or n=6*n)

(define (p17 n six iter)
  (local (sum roll)
    (setq sum 0)
    (for (i 1 iter)
      (setq roll (dice6-lst n))
      (if (= (first (count '(6) roll)) six) (++ sum))
    )
    (div sum iter)))

(time (for (d 1 10) (println d { } (p17 d 1 1e6))))
;-> 1 0.167077
;-> 2 0.278159
;-> 3 0.347116
;-> 4 0.386928
;-> 5 0.401902 ; max prob
;-> 6 0.401668 ; max prob
;-> 7 0.391217
;-> 8 0.371749
;-> 9 0.34952
;-> 10 0.322343
;-> 13195.512

(time (for (d 1 15) (println d { } (p17 d 2 1e6))))
;-> 1 0
;-> 2 0.027667
;-> 3 0.069857
;-> 4 0.116078
;-> 5 0.160673
;-> 6 0.20077
;-> 7 0.234401
;-> 8 0.260995
;-> 9 0.278521
;-> 10 0.290484
;-> 11 0.295599 ; max prob
;-> 12 0.295339 ; max prob
;-> 13 0.291402
;-> 14 0.283797
;-> 15 0.271698
;-> 25814.935

(time (for (d 10 20) (println d { } (p17 d 3 1e6))))


---------
Problem 18
----------
Suppose we roll a fair die 100 times.
What is the probability of a run of at least 10 sixes?

Solution = 0.00000125690042984...

(define (p18 iter)
  (setq sum 0)
  (for (i 1 iter)
    (setq roll (join (map string (dice6-lst 100))))
    (if (find "6666666666" roll) (++ sum))
  )
  (div sum iter))

(time (println (format "%4.12f" (p18 1e6))))
;-> 0.000001000000
;-> 37713.921

(time (println (format "%4.12f" (p18 1e7))))
;-> 0.000001100000
;-> 377145.146


----------
Problem 19
----------
Suppose we roll a fair die until some face has appeared twice. For instance, we might have a run of rolls 12545 or 636.
How many rolls on average would we make?
What if we roll until a face has appeared three times?

Solution =
  (2 faces) (3.7746913580246...)
  (3 faces) (7.2955443387059899...)

(define (p19 faces iter)
  (local (sum stop rolled trial)
    (for (i 1 iter)
      (setq stop nil)
      (setq rolled '())
      (setq trial 0)
      (until stop
        (push (die6) rolled -1)
        (if (ref faces (count '(1 2 3 4 5 6) rolled))
            (setq stop true)
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(p19 2 1e6)
;-> 3.773871

(p19 3 1e6)
;-> 7.291689


----------
Problem 20
----------
Suppose we roll a fair die 10 times.
What is the probability that the sequence of rolls is non-decreasing (i.e., the next roll is never less than the current roll)?

Solution = 0.0000496641295788...
 n   prob
 1 = 1
 2 = 0.5833333333
 3 = 0.259259259
 4 = 0.0972
 5 = 0.032407
 6 = 0.00990226...
 7 = 0.00282921...
 8 = 0.000766246...
 9 = 0.000198656...
10 = 0.0000496641...

(define (p20 dice iter)
  (local (sum)
    (for (i 1 iter)
      (if (apply <= (dice6-lst dice)) (++ sum))
    )
    (div sum iter)))

(time (for (d 2 10) (println d { } (format "%4.8f" (p20 d 1e6)))))
;->  2 0.58238200
;->  3 0.25966200
;->  4 0.09732000
;->  5 0.03231500
;->  6 0.00982500
;->  7 0.00282900
;->  8 0.00080900
;->  9 0.00020600
;-> 10 0.00004700
;-> 6929.942


----------
Problem 21
----------
Suppose a pair of dice are thrown, and then thrown again. What is the probability that the faces
appearing on the second throw are the same as the first?
What if three dice are used? Or six?

Solution =

  (2) 0.0509259...
  (3) 0.02134773662551...
  (6) 0.004064823502...

(define (p21 dice iter)
  (local (sum)
    (for (i 1 iter)
      (if (= (sort (dice6-lst dice)) (sort (dice6-lst dice))) (++ sum))
    )
    (div sum iter)))

(time (for (d 2 6) (println d { } (p21 d 1e6))))
;-> 2 0.050996
;-> 3 0.021266
;-> 4 0.010841
;-> 5 0.00642
;-> 6 0.004006
;-> 6953.273


----------
Problem 22
----------
What is the most probable: rolling at least one six with six dice, at least two sixes with twelve dice,
or at least three sixes with eighteen dice? (This is an old problem, frequently connected with Isaac
Newton.)

Solution =

  (1 6)  0.66510202331961591221...
  (2 12) 0.61866737373230871348...
  (3 18) 0.59734568594772319497...

(define (p22 iter)
  (local (s1 s2 s3)
    (setq s1 0 s2 0 s3 0)
    (for (i 1 iter)
      (if (ref 6 (dice6-lst 6)) (++ s1))
      (if (>= (length (ref-all 6 (dice6-lst 12))) 2) (++ s2))
      (if (>= (length (ref-all 6 (dice6-lst 18))) 3) (++ s3))
    )
    (list (div s1 iter) (div s2 iter) (div s3 iter))))

(time (println (p22 1e6)))
;-> (0.665893 0.618825 0.597801)
;-> 4049.654


----------
Problem 23
----------
Suppose we roll n dice, remove all the dice that come up 1, and roll the rest again.
If we repeat this process, eventually all the dice will be eliminated.
How many rolls, on average, will we make?
Show, for instance, that on average fewer than O(log n) throws occur.

Solution =

   n   Expect rolls
   1   6
   2   8.72727272727273
   3   10.5554445554446
   4   11.9266962545651
   5   13.0236615075553
   6   13.9377966973204
   7   14.7213415962620
   8   15.4069434778816
   9   16.0163673664838
  10   16.5648488612594
  15   18.6998719821123
  20   20.2329362496041
  30   22.4117651317294
  40   23.9670168145374
  50   25.1773086926527

(define (p23 n iter)
  (local (sum len trial dice)
    (setq sum 0)
    (for (i 1 iter)
      (setq len n)
      (setq trial 0)
      (while (> len 0)
        (setq dice (dice6-lst len))
        (setq dice (clean (fn(x) (= x 1)) dice))
        (setq len (length dice))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (for (d 1 10) (println d { } (p23 d 1e6))))
;->  1 6.002214
;->  2 8.727068
;->  3 10.564767
;->  4 11.916275
;->  5 13.019453
;->  6 13.933349
;->  7 14.710539
;->  8 15.394792
;->  9 16.018595
;-> 10 16.548994
;-> 114707.608

(time (println 50 { } (p23 50 1e6)))
;-> 50 25.17865
;-> 72227.549


----------
Problem 24
----------
Suppose we roll a die 6k times.
What is the probability that each possible face comes up an equal number of times (i.e., k times)?
Find an asymptotic expression for this probability in terms of k.

Solution =

                  (6*k)!
  prob(k) = ------------------
              (k!)^6*6^(6*k)

(define (fact-i num)
"Calculates the factorial of an integer number"
  (if (zero? num)
      1
      (let (out 1L)
        (for (x 1L num)
          (setq out (* out x))))))

(define (p24-exact k)
  (div (fact-i(* 6 k))
       (mul (pow (fact-i k) 6) (pow 6 (* 6 k)))))

(for (k 1 8) (println k { } (p24-exact k)))
;-> 1 0.0154320987654321
;-> 2 0.00343828589391861
;-> 3 0.001351173164124394
;-> 4 0.0006851855739960354
;-> 5 0.0004018232732834528
;-> 6 0.0002588780071408263
;-> 7 0.0001781322200362953
;-> 8 0.0001286843191407073

(define (p24 k iter)
  (local (sum dice roll)
    (setq sum 0)
    (setq dice (* 6 k))
    (for (i 1 iter)
      (setq roll (dice6-lst dice))
      (if (= (count '(1 2 3 4 5 6) roll) (list k k k k k k)) (++ sum))
    )
    (div sum iter)))

(time (for (k 1 8) (println k { } (p24 k 1e6))))
;-> 1 0.015311
;-> 2 0.003418
;-> 3 0.001376
;-> 4 0.000669
;-> 5 0.000369
;-> 6 0.000275
;-> 7 0.000184
;-> 8 0.00014
;-> 42578.911


----------
Problem 25
----------
Call a "consecutive difference" the absolute value of the difference between two consecutive rolls of a die.
For example, the sequence of rolls 14351 has the corresponding sequence of consecutive differences 3, 1, 2, 4.
What is the expected number of times we need to roll a die until all 6 consecutive differences have appeared?

Solution = 25.84844128587580155492288439...

(define (p25 iter)
  (local (sum trial diff stop prev cur)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 1)
      (setq diff (dup '-1 6))
      (setq stop nil)
      (setq prev (die6))
      (until stop
        (setq cur (die6))
        (setf (diff (abs (- prev cur))) 1)
        (if (and (= (diff 0) 1) (= (diff 1) 1) (= (diff 2) 1)
                 (= (diff 3) 1) (= (diff 4) 1) (= (diff 5) 1))
            (setq stop true)
        )
        (setq prev cur)
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p25 1e6)))
;-> 25.849529
;-> 9719.595


----------
Problem 26
----------
Suppose we roll six dice repeatedly as long as there are repetitions among the rolled faces, rerolling all non-distinct face dice.
For example, our first roll might give 112245, in which case we would keep the 45 and roll the other four.
Suppose those four turn up 1346 so the set of faces is 134456, and so we re-roll the two 4 dice, and continue.
What is the expected number of rolls until all faces are distinct?

Solution = 31.008483737975263

(define (p26 iter)
  (local (sum trial dice stop seq roll tmp)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq dice 6)
      (setq stop nil)
      (setq seq '())
      (until stop
        (setq roll (dice6-lst dice))
        (extend roll seq)
        ; remove duplicates
        (setq seq '())
        (dolist (el (count '(1 2 3 4 5 6) roll))
          (if (= el 1) (push (+ $idx 1) seq))
        )
        ;(if (= (sort seq '(1 2 3 4 5 6)) (setq stop true))
        (if (= (length seq) 6) (setq stop true))
        (setq dice (- 6 (length seq)))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p26 1e6)))
;-> 31.005582
;-> 57661.46


=======================
 2. Dice Sums (27..45)
=======================

----------
Problem 27
----------
Show that the probability of rolling 14 is the same whether we throw 3 dice or 5 dice.

Solution = 5/72 = 0.06944444444444445

(define (p27 iter)
  (local (s1 s2)
    (setq s1 0 s2 0)
    (for (i 1 iter)
      (if (= (dice6 3) 14) (++ s1))
      (if (= (dice6 5) 14) (++ s2))
    )
    (list (div s1 iter) (div s2 iter))))

(time (println (p27 1e6)))
;-> (0.069704 0.069616)
;-> 658.65
(time (println (p27 1e7)))
;-> (0.0693125 0.0694063)
;-> 6469.459


----------
Problem 28
----------
Show that the probability of rolling a sum of 9 with a pair of 5-sided dice is the same as rolling a sum
of 9 with a pair of 10-sided dice.
Are there other examples of this phenomenon?
Can we prove there are infinitely many such?

Solution =

  sides 1   sides 2   sum (m)
     5        10        9
     5        15       10
    10        20       17
    10        30       19
    13        65       26
    17        68       33

If (m - 1) is divisible by 8 or the square of an odd prime and s1 < s2, then

            2*s1*(s2^2)
  m - 1 = ---------------
            s1^2 + s2^2

the probability of rolling a sum of m with a pair of s1-sided dice is the same as with a pair of
s2-sided dice.

(define (div-square-odd-prime x)
  (local (primes out pp)
    (setq primes '(2 3 5 7 11 13 17 19 23 29 31 37 41
                43 47 53 59 61 67 71 73 79 83 89 97))
    (setq out nil)
    (dolist (p primes out)
      (setq pp (* p p))
      (if (and (>= x pp) (zero? (% x pp))) (setq out true))
    )
  out))

(define (find-sides start end)
  (local (out)
    (setq out '())
    (for (s1 start (- end 1))
      (for (s2 (+ s1 1) end)
        (setq m-1 (div (* 2 s1 s2 s2) (+ (* s1 s1) (* s2 s2))))
        ;(println m-1)
        (if (and (= (int m-1) m-1)
                 (or (zero? (% m-1 8))
                     (div-square-odd-prime m-1)))
          (push (list s1 s2 (+ m-1 1)) out -1)
        )
      )
    )
    out))

(find-sides 5 100)
;-> ((5 10 9) (5 15 10) (10 20 17) (10 30 19) (13 65 26) (15 30 25)
;->  (15 45 28) (17 68 33) (20 40 33) (20 60 37) (25 50 41) (25 75 46)
;->  (26 39 37) (30 60 49) (30 90 55) (35 70 57) (40 80 65) (45 90 73)
;->  (50 100 81) (51 85 76) (52 78 73) (75 100 97))

(define (p28 sides1 sides2 val iter)
  (local (s1 s2)
    (setq s1 0 s2 0)
    (for (i 1 iter)
      (if (= (dice 2 sides1) val) (++ s1))
      (if (= (dice 2 sides2) val) (++ s2))
    )
    (list (div s1 iter) (div s2 iter))))

(time (println (p28 5 10 9 1e7)))
;-> (0.0799434 0.0800273)
;-> 5356.291

(time (println (p28 5 15 10 1e7)))
;-> (0.0400338 0.040021)
;-> 5316.93

(time (println (p28 75 100 97 1e7)))
;-> (0.009624000000000001 0.009652300000000001)
;-> 5332.902


----------
Problem 29
----------
Suppose we roll n dice and sum the highest 3.
What is the probability that the sum is 18?

Solution =
  n  prob
  1  0
  2  0
  3  0.004629629629629629
  4  0.0162037037037037
  5  0.03549382716049383

(define (p29 n iter)
  (let (sum 0)
    (for (i 1 iter)
      (if (= 18 (apply + (slice (sort (dice6-lst n) >) 0 3))) (++ sum))
    )
    (div sum iter)))

(time (for (n 3 5) (println (p29 n 1e7))))
;-> 0.0046275
;-> 0.0161614
;-> 0.0356094
;-> 38816.193


----------
Problem 30
----------
Four fair, 6-sided dice are rolled. The highest three are summed.
What is the distribution of the sum?

Solution = the most likely roll is 13

(define (p30 iter)
  (let ((sum 0) (freq (array 19 '(0))))
    (for (i 1 iter)
      (++ (freq (apply + (slice (sort (dice6-lst 4) >) 0 3))))
    )
    (dolist (f freq) (println $idx { } f))))

(time (p30 1e6))
;-> 0 0
;-> 1 0
;-> 2 0
;-> 3 769
;-> 4 3105
;-> 5 7598
;-> 6 16135
;-> 7 29185
;-> 8 47692
;-> 9 70277
;-> 10 94176
;-> 11 114618
;-> 12 128647
;-> 13 133020 ; max value
;-> 14 123391
;-> 15 100870
;-> 16 72523
;-> 17 41694
;-> 18 16300
;-> 1300.675


----------
Problem 31
----------
Three fair, n-sided dice are rolled.
What is the probability that the sum of two of the faces rolled equals the value of the other rolled face?

Solution =

          3*(n - 1)
  prob = -----------
            2*n^2

(define (p31-exact n) (div (* 3 (- n 1)) (* 2 n n)))

(for (n 4 10) (println n { } (p31-exact n)))
;-> 4 0.28125
;-> 5 0.24
;-> 6 0.2083333333333333
;-> 7 0.1836734693877551
;-> 8 0.1640625
;-> 9 0.1481481481481481
;-> 10 0.135

(define (check-equal lst)
  (or (= (+ (lst 0) (lst 1)) (lst 2))
      (= (+ (lst 0) (lst 2)) (lst 1))
      (= (+ (lst 1) (lst 2)) (lst 0))))

(define (p31 sides iter)
  (let (sum 0)
    (for (i 1 iter)
      (if (check-equal (dice-lst 3 sides)) (++ sum))
    )
    (div sum iter)))

(time (for (n 4 10) (println n { } (p31 n 1e7))))
;->  4 0.2810453
;->  5 0.2398544
;->  6 0.208315
;->  7 0.1836798
;->  8 0.1640555
;->  9 0.1482441
;-> 10 0.1350701
;-> 49364.249


----------
Problem 32
----------
A fair, n-sided die is rolled until a roll of k or greater appears.
All rolls are summed. What is the expected value of the sum?

Solution =

The expected value of the sum is:

                 n^2 + n
 ESum(n,k) = ---------------
              2*n - 2*k + 2

(define (p32-exact n k) (div (+ n (* n n)) (+ (* 2 n) (* -2 k) 2)))

(for (n 4 10)
  (for (k 1 n)
    (println n { } k { } (p32-exact n k))))
;->  4  1  2.5
;->  4  2  3.333333333333334
;->  4  3  5
;->  4  4 10
;->  5  1  3
;->  5  2  3.75
;->  5  3  5
;->  5  4  7.5
;->  5  5 15
;->  6  1  3.5
;->  6  2  4.2
;->  6  3  5.25
;->  6  4  7
;->  6  5 10.5
;->  6  6 21
;->  7  1  4
;->  7  2  4.666666666666667
;->  7  3  5.6
;->  7  4  7
;->  7  5  9.333333333333334
;->  7  6 14
;->  7  7 28
;->  8  1  4.5
;->  8  2  5.142857142857143
;->  8  3  6
;->  8  4  7.2
;->  8  5  9
;->  8  6 12
;->  8  7 18
;->  8  8 36
;->  9  1  5
;->  9  2  5.625
;->  9  3  6.428571428571429
;->  9  4  7.5
;->  9  5  9
;->  9  6 11.25
;->  9  7 15
;->  9  8 22.5
;->  9  9 45
;-> 10  1  5.5
;-> 10  2  6.111111111111111
;-> 10  3  6.875
;-> 10  4  7.857142857142857
;-> 10  5  9.166666666666666
;-> 10  6 11
;-> 10  7 13.75
;-> 10  8 18.33333333333333
;-> 10  9 27.5
;-> 10 10 55

(define (p32 sides k iter)
  (local (sum cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (setq val (die sides))
        (++ cur-sum val)
        (if (>= val k) (setq stop true))
      )
      (++ sum cur-sum)
    )
    (div sum iter)))

(for (n 4 10)
  (for (k 1 n)
    (println n { } k { } (p32 n k 1e6))))
;->  4  1  2.499844
;->  4  2  3.334495
;->  4  3  4.997689
;->  4  4  9.998665
;->  5  1  3.003005
;->  5  2  3.751079
;->  5  3  5.002493
;->  5  4  7.503473
;->  5  5 14.987994
;->  6  1  3.502979
;->  6  2  4.201347
;->  6  3  5.249296
;->  6  4  7.003202
;->  6  5 10.491035
;->  6  6 21.006365
;->  7  1  3.997013
;->  7  2  4.667817
;->  7  3  5.599894
;->  7  4  7.001535
;->  7  5  9.336456
;->  7  6 13.988482
;->  7  7 27.999418
;->  8  1  4.497405
;->  8  2  5.143777
;->  8  3  6.000895
;->  8  4  7.202
;->  8  5  9.002279
;->  8  6 12.010102
;->  8  7 18.002953
;->  8  8 36.009548
;->  9  1  4.999364
;->  9  2  5.625633
;->  9  3  6.429222
;->  9  4  7.501889
;->  9  5  9.005683
;->  9  6 11.259142
;->  9  7 14.997734
;->  9  8 22.503234
;->  9  9 45.00624
;-> 10  1  5.499014
;-> 10  2  6.111696
;-> 10  3  6.872022
;-> 10  4  7.857096
;-> 10  5  9.168457
;-> 10  6 10.995887
;-> 10  7 13.747192
;-> 10  8 18.304277
;-> 10  9 27.45352
;-> 10 10 55.045263


----------
Problem 33
----------
A pair of dice is rolled repeatedly.
What is the expected number of rolls until all eleven possible sums have appeared?
What if three dice are rolled until all sixteen possible sums have appeared?

Solution =

  E(11) = 61.217384763957...
  E(16) = 338.45308554395589...

(define (p33-1 iter)
  (local (sum faces trial stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 13))
      (setf (faces 0) -1)
      (setf (faces 1) -1)
      (setq trial 0)
      (setq stop nil)
      (until stop
        (++ (faces (dice6 2)))
        (if (not (ref 0 faces)) (setq stop true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p33-1 1e6)))
;-> 61.181503
;-> 24784.804

(define (p33-2 iter)
  (local (sum faces trial stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq faces (dup 0 19))
      (setf (faces 0) -1)
      (setf (faces 1) -1)
      (setf (faces 2) -1)
      (setq trial 0)
      (setq stop nil)
      (until stop
        (++ (faces (dice6 3)))
        (if (not (ref 0 faces)) (setq stop true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (println (p33-2 1e6)))
;-> 338.273674
;-> 151208.602

----------
Problem 34
----------
A die is rolled repeatedly and summed.
What can you say about the expected number of rolls until the sum is greater than or equal to n?

Solution =

E(n) is very closely approximated by g(n) = (2/7)*n + 10/21 as n get large.

  n    E(n)          g(n)          En - g(n)
  1    1.00000000    0.76190476    0.2380952381
  2    1.16666666    1.04761904    0.1190476190
  3    1.36111111    1.33333333    0.02777777778
  4    1.58796296    1.61904761   -0.03108465608
  5    1.85262345    1.90476190   -0.05213844797
  6    2.16139403    2.19047619   -0.02908215755
  7    2.52162637    2.47619047    0.04543589555
  8    2.77523076    2.76190476    0.01332600513
  9    3.04332478    3.04761904   -0.004294263859
 10    3.32369372    3.33333333   -0.009639604132
 15    4.76000837    4.76190476   -0.001896385320
 20    6.19019519    6.19047619   -0.0002809914888
 25    7.61908161    7.61904761    0.00003399272215
 30    9.04763459    9.04761904    0.00001554676498
 35   10.47619480   10.47619048    0.000004327490791
 40   11.90476290   11.90476190    0.0000009934675945
 45   13.33333351   13.33333333    0.0000001795084385
 50   14.76190478   14.76190476    0.00000001842084560
 60   17.61904762   17.61904762   -0.000000000990023724
 70   20.47619048   20.47619048   -8.20317511*e10-11
 80   23.33333333   23.33333333   -1.896370261*10-12
 90   26.19047619   26.19047619    6.32378328*10-14
100   29.04761905   29.04761905    6.478729760*10-15

(define (p34 n iter)
  (local (sum trial cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (++ cur-sum (die6))
        (if (>= cur-sum n) (setq stop true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(setq test '(1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 60 70 80 90 100))
(time (dolist (t test) (println t { } (p34 t 1e6))))
;->   1 1
;->   2 1.166995
;->   3 1.360913
;->   4 1.587156
;->   5 1.853321
;->   6 2.161714
;->   7 2.521069
;->   8 2.776531
;->   9 3.043351
;->  10 3.323642
;->  15 4.759487
;->  20 6.1916
;->  25 7.618022
;->  30 9.0474320
;->  35 10.477505
;->  40 11.906859
;->  45 13.334945
;->  50 14.762519
;->  60 17.621313
;->  70 20.47775
;->  80 23.339379
;->  90 26.190114
;-> 100 29.047459
;-> 38889.62


----------
Problem 35
----------

A die is rolled repeatedly and summed.
Show that the expected number of rolls until the sum is a multiple of n is n.

Solution = n

(define (p35 n iter)
  (local (sum trial cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (++ cur-sum (die6))
        (if (zero? (% cur-sum n)) (setq stop true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (for (n 5 50 5) (println n { } (p35 n 1e6))))
;->  5 5.004791
;-> 10 10.017
;-> 15 14.995774
;-> 20 19.974979
;-> 25 24.94479
;-> 30 29.999757
;-> 35 34.983506
;-> 40 39.992965
;-> 45 45.004574
;-> 50 50.042733
;-> 51834.964


----------
Problem 36
----------

A fair, n-sided die is rolled and summed until the sum is at least n.
What is the expected number of rolls?

Solution =

  E(n) = (1 + 1/n)^(n-1)

     n   E(n)
     1   1.0000
     2   1.5000
     3   1.7778
     4   1.9531
     5   2.0736
     6   2.1614
     7   2.2282
     8   2.2807
     9   2.3231
    10   2.3579
    20   2.5270
   100   2.6780
   500   2.7101
  1000   2.7142

For n -> infinito, E(n) -> e = 2.7182818284590451

(define (p36 n iter)
  (local (sum trial cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (++ cur-sum (die n))
        (if (>= cur-sum n) (setq stop true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (for (n 1 10) (println n { } (p36 n 1e6))))
;->  1 1
;->  2 1.500262
;->  3 1.777915
;->  4 1.95344
;->  5 2.075321
;->  6 2.16121
;->  7 2.229231
;->  8 2.281749
;->  9 2.322825
;-> 10 2.358849
;-> 5050.859

(time (println (p36 1000 1e6)))
;-> 2.713591
;-> 636.463

(time (println (p36 1e7 1e7)))
;-> 2.717951
;-> 6521.895


----------
Problem 37
----------
A die is rolled and summed repeatedly.
What is the probability that the sum will ever be a given value x?
What is the limit of this probability as x -> infinite?

Solution =

   x   p(x)
   1   0.1666666666666666666666666666
   2   0.1944444444444444444444444444
   3   0.2268518518518518518518518518
   4   0.2646604938271604938271604938
   5   0.3087705761316872427983539094
   6   0.3602323388203017832647462277
   7   0.2536043952903520804755372656
   8   0.2680940167276329827770156988
   9   0.2803689454414977391657775745
  10   0.2892884610397720537180985283
  11   0.2933931222418739803665882007
  12   0.2908302132602384366279605826
  13   0.2792631923335612121884963084
  14   0.2835396585074294008073228155
  15   0.2861139321373954704790406683
  16   0.2870714299200450923645845173
  17   0.2867019247334239321389988488
  18   0.2855867251486822574344006235
  19   0.2847128104634228942354739637
  20   0.2856210801517331745766369062

For x -> infinite, p(x) -> 2/7 = 0.2857142857142857...

(define (p37 x iter)
  (local (sum success cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq success 0)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (++ cur-sum (die6))
        (cond ((= cur-sum x) (++ success) (setq stop true))
              ((> cur-sum x) (setq stop true))
        )
      )
      (++ sum success)
    )
    (div sum iter)))

(time (for (x 1 20) (println x { } (p37 x 1e6))))
;->  1 0.16666
;->  2 0.194341
;->  3 0.226992
;->  4 0.26446
;->  5 0.308869
;->  6 0.360218
;->  7 0.252632
;->  8 0.26827
;->  9 0.280195
;-> 10 0.289617
;-> 11 0.292264
;-> 12 0.291235
;-> 13 0.278908
;-> 14 0.28384
;-> 15 0.285922
;-> 16 0.286776
;-> 17 0.286604
;-> 18 0.285712
;-> 19 0.284588
;-> 20 0.285544
;-> 14729.982

(time (for (x 1 20) (println x { } (p37 x 1e7))))
;->  1 0.166676
;->  2 0.1943121
;->  3 0.2268943
;->  4 0.2646964
;->  5 0.3088836
;->  6 0.3605864
;->  7 0.2536836
;->  8 0.2681763
;->  9 0.2801742
;-> 10 0.2893609
;-> 11 0.2934537
;-> 12 0.2908989
;-> 13 0.2794088
;-> 14 0.2838539
;-> 15 0.2863527
;-> 16 0.2871503
;-> 17 0.2866966
;-> 18 0.2855154
;-> 19 0.2847173
;-> 20 0.2854919
;-> 146949.576

(time (println 1000 { } (p37 1000 1e6)))
;-> 1000 0.285877
;-> 46318.398


----------
Problem 38
----------

A die is rolled and summed repeatedly.
Let x be a positive integer.
What is the probability that the sum will ever be x or x + 1?
What is the probability that the sum will ever be x, x + 1, or x + 2?
Etc.?

Solution =

For x -> infinite, p(x,x+1) = 11/21 = 0.5238095...
For x -> infinite, p(x,x+1,x+2) = 5/7 = 0.7142857...
For x -> infinite, p(x,x+1,x+2,x+3) = 6/7 = 0.8571428...
For x -> infinite, p(x,x+1,x+2,x+3,x+4) = 20/21 = 0.9523809...
For x > 0, p(x,x+1,x+2,x+3,x+4,x+5) = 1

(define (p38 x gap iter)
  (local (sum success cur-sum stop)
    (setq sum 0)
    (for (i 1 iter)
      (setq success 0)
      (setq cur-sum 0)
      (setq stop nil)
      (until stop
        (++ cur-sum (die6))
        (cond ((and (>= cur-sum x) (<= cur-sum (+ x gap)))
                (++ success) (setq stop true))
              ((> cur-sum (+ x gap)) (setq stop true))
        )
      )
      (++ sum success)
    )
    (div sum iter)))

(x, x+1)
(time (for (x 1 20) (println x { } (p38 x 1 1e6))))
;->  1 0.332811
;->  2 0.38873
;->  3 0.453138
;->  4 0.529115
;->  5 0.617748
;->  6 0.553619
;->  7 0.480343
;->  8 0.503892
;->  9 0.52286
;-> 10 0.534459
;-> 11 0.535031
;-> 12 0.521181
;-> 13 0.516621
;-> 14 0.522181
;-> 15 0.525219
;-> 16 0.526601
;-> 17 0.524298
;-> 18 0.52303
;-> 19 0.522811
;-> 20 0.525442
;-> 18010.568

(time (println 1000 { } (p38 1000 1 1e6)))
;-> 1000 0.523654
;-> 56682.654

(x, x+1, x+2)
(time (for (x 1 20) (println x { } (p38 x 2 1e6))))
;->  1 0.500194
;->  2 0.582479
;->  3 0.680495
;->  4 0.794172
;->  5 0.760068
;->  6 0.719681
;->  7 0.673643
;->  8 0.701867
;->  9 0.721625
;-> 10 0.727834
;-> 11 0.717177
;-> 12 0.710538
;-> 13 0.708568
;-> 14 0.714733
;-> 15 0.716407
;-> 16 0.716446
;-> 17 0.714625
;-> 18 0.712756
;-> 19 0.713592
;-> 20 0.714175
;-> 17893.32
(time (println 1000 { } (p38 1000 2 1e6)))
;-> 1000 0.713795
;-> 56830.675

(x, x+1, x+2, x+3)
(time (for (x 1 20) (println x { } (p38 x 3 1e6))))
;->  1 0.666952
;->  2 0.778021
;->  3 0.907369
;->  4 0.892113
;->  5 0.874436
;->  6 0.852554
;->  7 0.828534
;->  8 0.855572
;->  9 0.868953
;-> 10 0.861796
;-> 11 0.856212
;-> 12 0.854335
;-> 13 0.854111
;-> 14 0.858126
;-> 15 0.858512
;-> 16 0.857444
;-> 17 0.856356
;-> 18 0.856031
;-> 19 0.856979
;-> 20 0.857325
;-> 17783.638
(time (println 1000 { } (p38 1000 3 1e6)))
;-> 1000 0.856998
;-> 56763.018

(x, x+1, x+2, x+3, x+4)
(time (for (x 1 20) (println x { } (p38 x 4 1e6))))
;->  1 0.833231
;->  2 0.972125
;->  3 0.967781
;->  4 0.962235
;->  5 0.956051
;->  6 0.947976
;->  7 0.940075
;->  8 0.957886
;->  9 0.955643
;-> 10 0.953408
;-> 11 0.951796
;-> 12 0.950942
;-> 13 0.951461
;-> 14 0.953581
;-> 15 0.952759
;-> 16 0.952405
;-> 17 0.952115
;-> 18 0.952351
;-> 19 0.952328
;-> 20 0.952618
;-> 17658.901
(time (println 1000 { } (p38 1000 4 1e6)))
;-> 1000 0.952544
;-> 56576.821

(x, x+1, x+2, x+3, x+4, x+5)
(time (for (x 1 20) (println x { } (p38 x 5 1e6))))
(time (println 1000 { } (p38 1000 5 1e6)))
;->  1 1
;->  2 1
;->  3 1
;->  4 1
;->  5 1
;->  6 1
;->  7 1
;->  8 1
;->  9 1
;-> 10 1
;-> 11 1
;-> 12 1
;-> 13 1
;-> 14 1
;-> 15 1
;-> 16 1
;-> 17 1
;-> 18 1
;-> 19 1
;-> 20 1
;-> 17597.076


----------
Problem 39
----------
A die is rolled once: call the result N.
Then N dice are rolled once and summed.
What is the distribution of the sum?
What is the expected value of the sum?
What is the most likely value?
What the heck, take it one more step.
Roll a die: call the result N.
Roll N dice once and sum them: call the result M.
Roll M dice once and sum.
What's the distribution of the sum, expected value, most likely value?

Solution =

  (N)   E = 12.25, Most likely value = 6
  (N,M) E = 42.875, Most likely value = 20

(define (p39-1 iter)
  (local (sum freq N cur-sum fmax fmax-val)
    (setq sum 0)
    (setq freq (dup '0 37))
    (for (i 1 iter)
      (setq N (die6))
      (setq cur-sum (dice6 N))
      (++ (freq cur-sum))
      (++ sum cur-sum)
    )
    (setq fmax 0 fmax-val 0)
    (dolist (f freq)
      (println $idx { } f)
      (if (> f fmax) (setq fmax f fmax-val $idx))
    )
    (println (div sum iter)
    (println fmax-val))))

(time (p39-1 1e7))
;->  0 0
;->  1 277432
;->  2 323936
;->  3 377471
;->  4 441298
;->  5 514295
;->  6 600149 ; max
;->  7 422978
;->  8 446170
;->  9 465949
;-> 10 482192
;-> 11 487162 ; local max
;-> 12 481005
;-> 13 459266
;-> 14 462088 ; local max
;-> 15 456789
;-> 16 444223
;-> 17 426916
;-> 18 400760
;-> 19 369243
;-> 20 335386
;-> 21 296571
;-> 22 252910
;-> 23 210126
;-> 24 167395
;-> 25 129195
;-> 26 95883
;-> 27 67310
;-> 28 45065
;-> 29 27920
;-> 30 16540
;-> 31 8941
;-> 32 4454
;-> 33 2018
;-> 34 732
;-> 35 200
;-> 36 32
;-> 12.25350946 ; expected value
;-> 6           ; most likely value
;-> 4539.027

(define (p39-2 iter)
  (local (sum freq N M cur-sum fmax fmax-val)
    (setq sum 0)
    (setq freq (dup '0 217))
    (for (i 1 iter)
      (setq N (die6))
      (setq M (dice6 N))
      (setq cur-sum (dice6 M))
      (++ (freq cur-sum))
      (++ sum cur-sum)
    )
    (setq fmax 0 fmax-val 0)
    (dolist (f freq)
      (println $idx { } f)
      (if (> f fmax) (setq fmax f fmax-val $idx))
    )
    (println (div sum iter)
    (println fmax-val))))

(time (p39-2 1e7))
;->   0 0
;->   1 46219
;->   2 54959
;->   3 66104
;->   4 78648
;->   5 93992
;->   6 112223
;->   7 88072
;->   8 96253
;->   9 104770
;->  10 111935
;->  11 117849
;->  12 122149
;->  13 123319
;->  14 129465
;->  15 135139
;->  16 139165
;->  17 142710
;->  18 144276
;->  19 145548
;->  20 146197
;->  21 145638
;->  22 143760
;->  23 142137
;->  24 139213
;->  25 137685
;->  26 135662
;->  27 134431
;->  28 133199
;->  29 132668
;->  30 132217
;->  31 133467
;->  32 133282
;->  33 134198
;->  34 134766
;->  35 135407
;->  36 135358
;->  37 135258
;->  38 135685
;->  39 135987
;->  40 135501
;->  41 135493
;->  42 134336
;->  43 134473
;->  44 133845
;->  45 133250
;->  46 132443
;->  47 131845
;->  48 130435
;->  49 130780
;->  50 129651
;->  51 128239
;->  52 126315
;->  53 126027
;->  54 124912
;->  55 123805
;->  56 121941
;->  57 121131
;->  58 119215
;->  59 117155
;->  60 115155
;->  61 113549
;->  62 112286
;->  63 109526
;->  64 106819
;->  65 104716
;->  66 101802
;->  67 99559
;->  68 97079
;->  69 93946
;->  70 91381
;->  71 88075
;->  72 85329
;->  73 82043
;->  74 79117
;->  75 75183
;->  76 72590
;->  77 69566
;->  78 66301
;->  79 63811
;->  80 60174
;->  81 57081
;->  82 53586
;->  83 51134
;->  84 47725
;->  85 45264
;->  86 42692
;->  87 39881
;->  88 36875
;->  89 34548
;->  90 31956
;->  91 29687
;->  92 27507
;->  93 25384
;->  94 23192
;->  95 21239
;->  96 19829
;->  97 17905
;->  98 16186
;->  99 14894
;-> 100 13219
;-> 101 12073
;-> 102 10911
;-> 103 9723
;-> 104 8782
;-> 105 7848
;-> 106 6947
;-> 107 6083
;-> 108 5381
;-> 109 4884
;-> 110 4228
;-> 111 3639
;-> 112 3265
;-> 113 2729
;-> 114 2382
;-> 115 2096
;-> 116 1883
;-> 117 1533
;-> 118 1369
;-> 119 1176
;-> 120 945
;-> 121 808
;-> 122 638
;-> 123 535
;-> 124 461
;-> 125 371
;-> 126 317
;-> 127 276
;-> 128 209
;-> 129 181
;-> 130 154
;-> 131 123
;-> 132 104
;-> 133 83
;-> 134 65
;-> 135 47
;-> 136 37
;-> 137 25
;-> 138 22
;-> 139 20
;-> 140 13
;-> 141 12
;-> 142 5
;-> 143 10
;-> 144 3
;-> 145 4
;-> 146 1
;-> 147 1
;-> 148 1
;-> 149 1
;-> 150 0
;-> 151 1
;-> 152 1
;-> 153 0
;-> 154 0
;-> 155 1
;-> 156 0
;-> ...
;-> 42.87629420 ; expected value
;-> 20          ; most likely value
;-> 10049.618


----------
Problem 40
----------
A die is rolled once. Call the result N.
Then, the die is rolled N times, and those rolls which are equal to or greater than N are summed (other rolls are not summed).
What is the distribution of the resulting sum?
What is the expected value of the sum?

Solution =

  E = 133/18 = 7.388888888888889
  Most likely value = 6

(define (p40 iter)
  (local (sum freq N roll cur-sum fmax fmax-val)
    (setq sum 0)
    (setq freq (dup '0 37))
    (for (i 1 iter)
      (setq N (die6))
      (setq roll (dice6-lst N))
      (setq cur-sum (apply + (filter (fn(x) (>= x N)) roll)))
      (++ (freq cur-sum))
      (++ sum cur-sum)
    )
    (setq fmax 0 fmax-val 0)
    (dolist (f freq)
      (println $idx { } f)
      (if (> f fmax) (setq fmax f fmax-val $idx))
    )
    (println (div sum iter)
    (println fmax-val))))

(time (p40 1e7))
;->  0 989821
;->  1 277782
;->  2 370955
;->  3 461758
;->  4 648390
;->  5 967940
;->  6 1731882
;->  7 277839
;->  8 439540
;->  9 517415
;-> 10 645901
;-> 11 646320
;-> 12 727520
;-> 13 138394
;-> 14 184885
;-> 15 219149
;-> 16 242663
;-> 17 177763
;-> 18 159267
;-> 19 20678
;-> 20 28556
;-> 21 37584
;-> 22 38629
;-> 23 22231
;-> 24 19158
;-> 25 222
;-> 26 1051
;-> 27 2120
;-> 28 2179
;-> 29 1079
;-> 30 1302
;-> 31 0
;-> 32 0
;-> 33 0
;-> 34 0
;-> 35 0
;-> 36 27
;-> 7.38890086 ; expected value
;-> 6          ; most likely value
;-> 12324.912


----------
Problem 41
----------
Suppose n six-sided dice are rolled and summed.
For each six that appears, we sum the six, and reroll that die and sum, and continue to reroll and sum until we roll something other than a six with that die.
What is the expected value of the sum?
What is the distribution of the sum?

Solution =

  E(n) = 4.2*n

(define (re-roll)
  (local (stop sum val)
    (setq stop nil)
    (setq sum 0)
    (until stop
      (setq val (die6))
      (if (!= val 6) (setq stop true))
      (++ sum val)
    )
    sum))

(define (p41 n iter)
  (local (sum freq cur-sum roll sixes fmax fmax-val)
    (setq sum 0)
    (setq sixes 0)
    (setq freq (dup '0 500))
    (for (i 1 iter)
      (setq cur-sum 0)
      (setq roll (dice6-lst n))
      ;(println "roll = " roll)
      (setq cur-sum (apply + roll))
      ;(println "cur-sum = " cur-sum)
      (setq sixes (filter (fn(x) (= x 6)) roll))
      ;(println "sixes = " sixes)
      ; rerolling sixes
      (dolist (six sixes)
        (++ cur-sum (re-roll))
        ;(println "six " $idx)
      )
      ;(println "cur-sum (after sixes) = " cur-sum)
      (++ (freq cur-sum))
      ;(println "sum (prima) = " sum)
      (++ sum cur-sum)
      ;(println "sum (dopo) = " sum)
      ;(read-line)
    )
    (setq fmax 0 fmax-val 0)
    (dolist (f freq)
      ;(println $idx { } f)
      (if (> f fmax) (setq fmax f fmax-val $idx))
    )
    (println (format "%4d %4.8f %4.8f %4d" n (div sum iter) (mul n 4.2) fmax-val))))

(time (for (n 1 10) (p41 n 1e6)))
       n  E(n)        4.2*n        Max probability value
;->    1  4.19778900  4.20000000    1
;->    2  8.39903500  8.40000000    6
;->    3 12.59932900 12.60000000    9
;->    4 16.78503600 16.80000000   13
;->    5 20.99763400 21.00000000   17
;->    6 25.19698300 25.20000000   22
;->    7 29.39231900 29.40000000   26
;->    8 33.58248900 33.60000000   30
;->    9 37.79898100 37.80000000   34
;->   10 41.99001500 42.00000000   39
;-> 21665.655


----------
Problem 42
----------
A die is rolled until all sums from 1 to x are attainable from some subset of rolled faces.
For example, if x = 3, then we might roll until a 1 and 2 are rolled, or until three 1s appear, or until two 1s and a 3.
What is the expected number of rolls?

Solution =

   x   E(x)
   2   7.5
   3   7.72222...
   4   7.93316...
   5   7.96387...
   6   7.99487...
   7   8.03103...
   8   8.07630...
   9   8.10442...
  10   8.15177...
  11   8.20726...

(define (subset-sum lst sum)
  (local (dp j)
    (setq dp (array (+ sum 1) '(nil)))
    ; l'inizializzazione con 1 perchè somma 0 è sempre possibile
    (setf (dp 0) true)
    ; ciclo per ogni elemento della lista
    (dolist (el lst)
      ; per modificare il valore di tutti i possibili valori di somma in True
      (setq j sum)
      (while (> j (- el 1))
        (if (dp (- j el)) (setf (dp j) true))
        (-- j)
      )
    )
    (dp sum)))

(define (p42 x iter)
  (local (sum roll found trial wrong)
    (setq sum 0)
    (for (i 1 iter)
      (setq roll '())
      (setq filled (array (+ x 1) '(0)))
      (setf (filled 0) 1)
      (setq trial 0)
      (setq found nil)
      (until found
        (push (die6) roll)
        (for (i 1 x)
          (if (and (!= (filled i) 1)
                   (subset-sum roll i))
              (setf (filled i) 1))
        )
        (if (= (apply + filled) (+ x 1)) (setq found true))
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

(time (for (x 2 11) (println x { } (p42 x 1e6))))
;->  2 7.505095
;->  3 7.716187
;->  4 7.931494
;->  5 7.971391
;->  6 8.0105
;->  7 8.029393
;->  8 8.071361
;->  9 8.104572
;-> 10 8.148847
;-> 11 8.209016
;-> 517855.895


----------
Problem 43
----------
How long, on average, do we need to roll a die and sum the rolls until the sum is a perfect square (1, 4, 9, 16, ...)?

Solution =

  E = 7.079764237551105103895

(define (square? n)
  (let (v (+ (sqrt n 0.5)))
    (= n (* v v))))

(define (p43 iter)
  (local (total success trial sum)
    (setq total 0)
    (setq success 0)
    (for (i 1 iter)
      (setq sum (die6))
      (setq trial 1)
      (until (square? sum)
        (++ sum (die6))
        (++ trial)
      )
      (++ total trial)
    )
    (div total iter)))

(time (println (p43 1e7)))
;-> 7.082254
;-> 19181.145


----------
Problem 44
----------
How long, on average, do we need to roll a die and sum the rolls until the sum is prime?
What if we roll until the sum is composite?

Solution =

  E(prime) = 2.428497913693504230366081906...
  E(composite) = 2.12848699151757507022715820...

(define (prime? num)
"Check if a number is prime"
   (if (< num 2) nil
       (= 1 (length (factor num)))))

(define (p44-1 iter)
  (local (total success trial sum)
    (setq total 0)
    (setq success 0)
    (for (i 1 iter)
      (setq sum (die6))
      (setq trial 1)
      (until (prime? sum)
        (++ sum (die6))
        (++ trial)
      )
      (++ total trial)
    )
    (div total iter)))

(time (println (p44-1 1e7)))
;-> 2.4286145
;-> 7089.412

(define (p44-2 iter)
  (local (total success trial sum)
    (setq total 0)
    (setq success 0)
    (for (i 1 iter)
      (setq sum (die6))
      (setq trial 1)
      ; number 1 is not composite
      (until (and (!= sum 1) (not (prime? sum)))
        (++ sum (die6))
        (++ trial)
      )
      (++ total trial)
    )
    (div total iter)))

(time (println (p44-2 1e7)))
;-> 2.1282056
;-> 7237.64


----------
Problem 45
----------
What is the probability that, if we roll two dice, the product of the faces will start with the digit '1'?
What if we roll three dice, or, ten dice?
What is going on?

Solution =

   n   prob(n)
   1   0.1666666666...
   2   0.3333333333...
   3   0.300925925...
   4   0.2924382716...
   5   0.2979681069...
   6   0.2978395061...
   7   0.2999042638...
   8   0.3013867455...
   9   0.3020477101...
  10   0.3021776836...

(define (p45 n iter)
  (local (success digit)
    (setq success 0)
    (for (i 1 iter)
      (setq val (string (apply * (dice6-lst n))))
      (if (= (val 0) "1") (++ success))
    )
    (div success iter)))

(time (for (n 1 10) (println n { } (p45 n 1e6))))
;->  1 0.166148
;->  2 0.334088
;->  3 0.301635
;->  4 0.292251
;->  5 0.298389
;->  6 0.298034
;->  7 0.299466
;->  8 0.301169
;->  9 0.301953
;-> 10 0.302202
;-> 11839.709


===============================
 3. Non-standard Dice (46..55)
===============================

----------
Problem 46
----------
Show that the probability of rolling doubles with a non-fair (“fixed”) die is greater than with a fair die.

(define (p46 prob iter)
  (local (die-fair1 die-fair2 die-not1 sum-not2 sum-fair sum-not)
    (setq sum-fair 0 sum-not 0)
    (for (i 1 iter)
      (if (= (die6) (die6)) (++ sum-fair))
      (if (= (rand-pick prob) (rand-pick prob)) (++ sum-not))
    )
    (list sum-fair sum-not)))

(setq prob8 '(0.1 0.1 0.15 0.2 0.2 0.25)))
(apply add prob8)
(time (println (p46 prob8 1e6)))
;-> (166260 185267)
;-> 1721.195

(setq prob6 '(0.1 0.12 0.15 0.18 0.2 0.25))
(apply add prob6)
;-> 1
(time (println (p46 prob6 1e6)))
;-> (166444 182700)
;-> 1730.433

With a fair dice:
(setq prob6 (list (div 6) (div 6) (div 6) (div 6) (div 6) (div 6)))
(apply add prob6)
;-> 0.9999999999999999
(time (println (p46 prob6 1e6)))
;-> (166441 166271)
;-> 1634.85


----------
Problem 47
----------
Is it possible to have a non-fair six-sided die such that the probability of rolling 2, 3, 4, 5 and 6 is the same whether we roll it once or twice (and sum)?
What about for other numbers of sides?

Solution =

  pf1 = 0.3833276422504671918282678397
  pf2 = 0.1469400813133021601465169741
  pf3 = 0.1126523898438400996320617058
  pf4 = 0.1079569374817992533848329781
  pf5 = 0.1158720592665417507230810930
  pf6 = 0.1332508898440495442852394095

(apply add
  (setq p6 '(0.3833276422504672 0.1469400813133022 0.1126523898438401
            0.1079569374817993 0.1158720592665418 0.1332508898440495))
)
;-> 1

(define (p47 prob face iter)
  (local (sum1 sum2)
    (setq sum1 0 sum2 0)
    (for (i 1 iter)
      (if (= (+ (rand-pick prob) 1) face) (++ sum1))
      (if (= (+ (+ (rand-pick prob) 1) (+ (rand-pick prob) 1)) face) (++ sum2))
    )
    (list (div sum1 iter) (div sum2 iter))))

(for (f 2 6) (println f { } (p47 p6 f 1e6)))
;-> 2 (0.147239 0.146712)
;-> 3 (0.111974 0.112795)
;-> 4 (0.108161 0.10761)
;-> 5 (0.116093 0.116102)
;-> 6 (0.133684 0.133972)


----------
Problem 48
----------
Find a pair of 6-sided dice, labelled with positive integers differently from the standard dice, so that the sum probabilities are the same as for a pair of standard dice.


----------
Problem 49
----------
Is it possible to have two non-fair n-sided dice, with sides numbered 1 through n, with the property that their sum probabilities are the same as for two fair n-sided dice?


----------
Problem 50
----------
Is it possible to have two non-fair 6-sided dice, with sides numbered 1 through 6, with a uniform sum probability? 
What about n-sided dice?
