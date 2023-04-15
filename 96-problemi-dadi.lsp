
(define (die s) (+ (rand s) 1))
(define (die6) (+ (rand 6) 1))
(define (dice n s) (+ n (apply + (rand s n))))
(define (dice6 n) (+ n (apply + (rand 6 n))))
(define (dice6-lst n) (map (curry + 1) (rand 6 n)))

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

Conroy solves the problems mathematically (very informative and interesting).
Here, I solve the problems with simulations (if I am able...).


----------------------
Problem solving status
----------------------

+ = solved
- = unsolved

  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 
  +  +  +  +  +  +  -  +  +  +  +  +  +  +  +  +  -  -  -  -  -  -  -  -  -
 
 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 
  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
 
 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75
  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -
 76
  -


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
(6 rolls) prob = 0.0154320987654321...
E = 83.2


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

----------
Problem 18
----------
Suppose we roll a fair die 100 times. 
What is the probability of a run of at least 10 sixes?
Solution =

