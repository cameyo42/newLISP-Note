
===================
 Problemi sui Dadi
===================

              A Collection of Dice Problems
           with solutions and useful appendices
             (a work continually in progress)
                   version July 3, 2022

                     Matthew M. Conroy
            doctormatt "at" madandmoonly dot com

https://www.madandmoonly.com/doctormatt/mathematics/dice1.pdf
http://www.matthewconroy.com/

Matthew Conroy solves the problems mathematically (very good).
Here, we solve the problems with simulations (if possible).

-----------------
General functions
-----------------

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

Number of iterations (minimum) = 1e6 (if possible)

The function "time" return the time elapsed in milliseconds.

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

(define (p4 iter)
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

(time (println (p4 1e6)))
(p4 1e6)
;-> 4.68883
;-> 1093.942

(define (p4-2 iter)
  (local (sum trial prev differ1 val)
    (setq sum 0)
    (for (i 1 iter)
      (setq trial 0)
      (setq prev -99)
      (setq differ1 0)
      (until (= differ1 2)
        (setq val (die6))
        (cond ((= (abs (- val prev)) 1)
                (++ differ1)
                ;(setq prev val)) ; continue search with val as prev
                (setq prev -99))  ; start new search
              (true (setq prev val))
        )
        (++ trial)
      )
      (++ sum trial)
    )
    (div sum iter)))

; continue search
(time (println (p4-2 1e6)))
;-> 8.279043
;-> 2056.942

; start new search
(time (println (p4-2 1e6)))
;-> 9.376621
;-> 2298.065

Note: the second simulation result is different from mathematical result


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

(setq lst (rand 10 20))
;-> (8 6 9 5 0 9 2 1 4 6 1 2 8 8 9 6 5 3 5 7)

(define (dice-lst n s) (map (curry + 1) (rand s n)))

(match '(* 1 2 *) '(1 3))

(length (match '(* 1 2 3 4 5 6 *) (dice6-lst 100000)))

(define (p6 n iter)
  (local (sum)
    (setq sum 0)
    (for (i 1 iter)
      (if (> (length (match '(* 1 2 3 4 5 6 *) (dice6-lst n))) 0)
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

For n>1000 the following expression is a quite good approximation:

                    1
  prob ≈ 1 - (1 - -----)^n
                   6^6


---------
Problem 7
---------
We roll a 6-sided die n times. What is the probability that all faces have appeared in some order in some six consecutive rolls?
What is the expected number of rolls until such a sequence appears?


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

This problem is an example of what is often referred to as a Coupon Collector’s problem.

