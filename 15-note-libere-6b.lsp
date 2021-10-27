================

 NOTE LIBERE 6b

================

In questo documento sono presentati alcuni post del blog di Kazimir Majorinc presenti nel sito:

http://kazimirmajorinc.blogspot.com/

Kazimir è un vero esperto sul linguaggio LISP e approfondisce in modo molto interessante alcune caratteristiche di newLISP (in particolar modo quelle proprie della famiglia dei linguaggi LISP).
Alcune parti del codice di esempio sono state aggiornate alla versione 10.7.5 di newLISP.
I sorgenti e i commenti ai post non sono stati tradotti.

Tutti i diritti sono di Kazimir Majorinc.

-----------------------------------------
One Hundred Propositional Tautologies (1)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-1.html

; I write program that derives one hundred propositional tautologies.
; Then I identify one which is not interesting, and try to improve
; program so next time it derives one hundred of more interesting
; propositional tautologies. We'll see where is this going.
;
;
; Preparing part:

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set '*list (lambda(l1 l2)
              (let ((result '()))
                   (dolist(i l1)
                     (dolist(j l2)
                       (push (list i j) result -1)))
                   result)))

(set 'appendall (lambda(a b)
                  (apply append (map a b))))

(set 'all-pf
  (lambda(len leafs unary binary)
     (if (= len 1)
        leafs
        (append (appendall (lambda(connective)
                              (map (lambda(x)(list connective x))
                                   (all-pf (- len 1) leafs unary binary)))
                           unary)
                (if (> len 2)
                    (appendall (lambda(connective)
                                  (appendall (lambda(r)
                                               (map (lambda(x)(cons connective x))
                                                    (*list (all-pf r leafs unary binary)
                                                           (all-pf (- len 1 r) leafs unary binary))))
                                             (sequence 1 (- len 2))))
                                binary)
                    '())))))

(set 'element find)

(set 'size-pf
     (lambda(f)
       (if (list? f)
           (apply + (map size-pf f))
           1)))

; For the first time, I has the right on a wild guess. So, I'll
; of the length 3 and 4, using true, nil and variables a b c d e,
; and classical connectives and filter tautologies.

(---)
(set 'tautologies (filter tautology? (append (all-pf 3 '(true nil a b c d e)
                                                       '(not)
                                                       '(and or -> <->))

                                             (all-pf 4 '(true nil a b c d e)
                                                       '(not)
                                                       '(and or -> <->)))))

(map (lambda(x)(println (+ $idx 1) ". " x))
     tautologies)

;===============================================================
;
; RESULTS:

1. (not (not true))
2. (and true true)
3. (or true true)
4. (or true nil)
5. (or true a)
6. (or true b)
7. (or true c)
8. (or true d)
9. (or true e)
10. (or nil true)
11. (or a true)
12. (or b true)
13. (or c true)
14. (or d true)
15. (or e true)
16. (-> true true)
17. (-> nil true)
18. (-> nil nil)
19. (-> nil a)
20. (-> nil b)
21. (-> nil c)
22. (-> nil d)
23. (-> nil e)
24. (-> a true)
25. (-> a a)
26. (-> b true)
27. (-> b b)
28. (-> c true)
29. (-> c c)
30. (-> d true)
31. (-> d d)
32. (-> e true)
33. (-> e e)
34. (<-> true true)
35. (<-> nil nil)
36. (<-> a a)
37. (<-> b b)
38. (<-> c c)
39. (<-> d d)
40. (<-> e e)
41. (not (not (not nil)))
42. (not (and true nil))
43. (not (and nil true))
44. (not (and nil nil))
45. (not (and nil a))
46. (not (and nil b))
47. (not (and nil c))
48. (not (and nil d))
49. (not (and nil e))
50. (not (and a nil))
51. (not (and b nil))
52. (not (and c nil))
53. (not (and d nil))
54. (not (and e nil))
55. (not (or nil nil))
56. (not (-> true nil))
57. (not (<-> true nil))
58. (not (<-> nil true))
59. (and true (not nil))
60. (and (not nil) true)
61. (or true (not true))
62. (or true (not nil))
63. (or true (not a))
64. (or true (not b))
65. (or true (not c))
66. (or true (not d))
67. (or true (not e))
68. (or nil (not nil))
69. (or a (not nil))
70. (or a (not a))
71. (or b (not nil))
72. (or b (not b))
73. (or c (not nil))
74. (or c (not c))
75. (or d (not nil))
76. (or d (not d))
77. (or e (not nil))
78. (or e (not e))
79. (or (not true) true)
80. (or (not nil) true)
81. (or (not nil) nil)
82. (or (not nil) a)
83. (or (not nil) b)
84. (or (not nil) c)
85. (or (not nil) d)
86. (or (not nil) e)
87. (or (not a) true)
88. (or (not a) a)
89. (or (not b) true)
90. (or (not b) b)
91. (or (not c) true)
92. (or (not c) c)
93. (or (not d) true)
94. (or (not d) d)
95. (or (not e) true)
96. (or (not e) e)
97. (-> true (not nil))
98. (-> nil (not true))
99. (-> nil (not nil))
100. (-> nil (not a))
101. (-> nil (not b))
102. (-> nil (not c))
103. (-> nil (not d))
104. (-> nil (not e))
105. (-> a (not nil))
106. (-> b (not nil))
107. (-> c (not nil))
108. (-> d (not nil))
109. (-> e (not nil))
110. (-> (not true) true)
111. (-> (not true) nil)
112. (-> (not true) a)
113. (-> (not true) b)
114. (-> (not true) c)
115. (-> (not true) d)
116. (-> (not true) e)
117. (-> (not nil) true)
118. (-> (not a) true)
119. (-> (not b) true)
120. (-> (not c) true)
121. (-> (not d) true)
122. (-> (not e) true)
123. (<-> true (not nil))
124. (<-> nil (not true))
125. (<-> (not true) nil)
126. (<-> (not nil) true)

Even for this, very first attempt, some interesting formulas
are derived. For example,

5.  (or true a)
11. (or a true)
19. (-> nil a)            lie implies anything
24. (-> a true)           anything implies truth
25. (-> a a)              reflexivity of implication
36. (<-> a a)             reflexivity of equivalence
45. (not (and nil a))
50. (not (and a nil))
70. (or a (not a))        (not a) is right inverse of a
88. (or (not a) a)        (not a) is left inverse of a

So, 10 interesting out of 126 tautologies. Not that bad. The first
tautology that is not interesting is 6. (or true b), because difference
in the name of the variable appears not to be significant enough.

Next thing to do is to filter tautologies and keep only those
that cannot be obtained from other tautologies by simple rename
of the variables.

Commenti:
---------
*** Anonymous 5 October 2009 at 19:22
I wonder if it's time for you to split up the 3000 line library into more than one file... ? I wanted to use debug-wrap, but kept on getting pages of tautologies.. :) And I couldn't work out how to suppress the printing...
cormullion

*** Kazimir Majorinc 5 October 2009 at 22:18
Cormullion,
maybe you're right but I prolong it, because my experience in the past was that it will only become more complicated if I'd have to take care about order of the load. Anycase, it appears to work for me (although version on the net lags behind things described on the blog).

(load "http://www.instprog.com/Instprog.default-library.lsp")
(debug-wrap fibo)
(fibo 4)

(set 'print.supressed true)
(print "supressed" " is " " it")
(set 'print.supressed false)
(print "isnt supressed" " this " " is")

(exit)

Note that print is now macro, hence it wouldn't work with (args) or $idx any more after my library is loaded.

If you find some relatively simple code where it doesn't work, please, post it to me.

Thank you for opinion.


-----------------------------------------
One Hundred Propositional Tautologies (2)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-2.html

;
; In previous, the first post of this serial, I simply defined few hundreds
; tautologies and checked whether they are tautologies. However,
; it was obvious that there are many of duplicates that differed
; only in using different variables. This time, we'll try to filter
; these tautologies, so these duplicated are rejected. First, we'll
; define the base of the formulas and tautologies.
;

(load "C:\\Newlisp\\Instprog.default-library.lsp")

(set 'formulas (append (all-pf 3 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))

                       (all-pf 4 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))

                       (all-pf 5 '(true nil a b c d e)
                                 '(not)
                                 '(and or -> <->))))

(println "We started with " (length formulas) ". formulas.")

(set 'tautologies (filter tautology? formulas))

(println "Filtered to " (length tautologies) ". tautologies.")

; I'll define the notion of the "prime tautology", in analogy to
; the prime numbers. Let us assume that tautologies are ordered
; in the list t1, t2, t3, ....

; the prime tautology is tautology that is not *an instance* of
; some other tautology that occured on the earlier place in the
; list.
;
; What does it mean that tautology (or more generally, the formula)
; f2 is "an instance" of other formula f1? Intuitively, that means
; that f2 is the special case of the more general formula f1. Just
; like in natural language, "London cathedral" is a special case of
; "Christian church."
;
; For example, (and (or x y) (not z)) is an instance of (and a b), because
; the substitution of a with (or x y), and b with (not z) will result in
; (and (or x y) z). Similarly, (or (and x y) (not z)) is not an instance
; of (and a b), because no substitution can transform that top level
; "and" into top-level "or."
;
; How can we check whether tautology t1 is instance of the tautology t2?
; First, because of technical reasons we should ensure that variables used
; in t1 are different than variables used in t2. Humans can understand
; that formula (or (not x) (not y)) is a special case of (or x y),
; because he'll understand that x and y are used in two different
; contexts, but with computers, this only complicates the issue.
;
; Because of that, we'll first change the form (or x y) into (or X Y),
; ie., we'll replace lowercase variables with uppercase.

(set 'upper-case-formula
     (lambda(f)
       (cond ((list? f)(map upper-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (upper-case (string f)))))))

; Now, we'll filter tautologies; we'll define another list, prime-tautologies,
; initially empty. Then, we'll take tautologies from the list, and
; check, one by one, whether these are instances of some of the
; formulas from prime-tautologies. If it is not, they will be
; added to prime tautologies.
;
; But, how can we check whether formula f is an instance of some
; other formula g? It would be the most complicated part. Fortunately,
; Newlisp has more general functions - unify. Unify doesn't test
; whether there is a substition s, such that f=s(g), but whether
; there is "unification" u, such that u(f)=u(g). During such test,
; unify will consider *only* symbols starting with upper case as variables.

(println (unify '(or (not x) (not y)) '(or X Y)))  ; ((X (not x)) (Y (not y)))
(println (unify '(or (not x) (not y)) '(and X Y))) ; nil

(set 'prime-tautologies '())
(dolist(f1 tautologies)
   (set 'composite nil)
   (dolist(f2 prime-tautologies composite)
      (if (unify f1 f2)
          (set 'composite true)))
   (when (not composite)
         (push (upper-case-formula f1) prime-tautologies -1)))

(println "Filtered to " (length tautologies) ". prime tautologies")

(map (lambda(x)(print $idx ". " x)) prime-tautologies)
(exit)

; RESULTS
;
; Now, this is pure beauty. All important formulas, if short enough
; are here. Among others, controversial (-> A (not (not A))) and
; (-> (not (not A)) A). I cannot, however, decide whether formulas
; containing only constants are interesting. Clearly, (not (not true))
; is interesting formula, but what with others? (not (not (not nil)))
; looks as less interesting, but why?

We started with 12957. formulas.
Filtered to 2465. tautologies.
Filtered to 348. prime tautologies
0. (not (not true))
1. (and true true)
2. (or true true)
3. (or true nil)
4. (or true A)
5. (or nil true)
6. (or A true)
7. (-> true true)
8. (-> nil true)
9. (-> nil nil)
10. (-> nil A)
11. (-> A true)
12. (-> A A)
13. (<-> true true)
14. (<-> nil nil)
15. (<-> A A)
16. (not (not (not nil)))
17. (not (and true nil))
18. (not (and nil true))
19. (not (and nil nil))
20. (not (and nil A))
21. (not (and A nil))
22. (not (or nil nil))
23. (not (-> true nil))
24. (not (<-> true nil))
25. (not (<-> nil true))
26. (and true (not nil))
27. (and (not nil) true)
28. (or nil (not nil))
29. (or A (not nil))
30. (or A (not A))
31. (or (not nil) nil)
32. (or (not nil) A)
33. (or (not A) A)
34. (-> true (not nil))
35. (-> A (not nil))
36. (-> (not true) nil)
37. (-> (not true) A)
38. (<-> true (not nil))
39. (<-> nil (not true))
40. (<-> (not true) nil)
41. (<-> (not nil) true)
42. (not (not (not (not true))))
43. (not (not (and true true)))
44. (not (not (or true true)))
45. (not (not (or true nil)))
46. (not (not (or true A)))
47. (not (not (or nil true)))
48. (not (not (or A true)))
49. (not (not (-> true true)))
50. (not (not (-> nil true)))
51. (not (not (-> nil nil)))
52. (not (not (-> nil A)))
53. (not (not (-> A true)))
54. (not (not (-> A A)))
55. (not (not (<-> true true)))
56. (not (not (<-> nil nil)))
57. (not (not (<-> A A)))
58. (not (and true (not true)))
59. (not (and A (not true)))
60. (not (and A (not A)))
61. (not (and (not true) true))
62. (not (and (not true) A))
63. (not (and (not A) A))
64. (not (or nil (not true)))
65. (not (or (not true) nil))
66. (not (-> true (not true)))
67. (not (-> (not nil) nil))
68. (not (<-> true (not true)))
69. (not (<-> nil (not nil)))
70. (not (<-> A (not A)))
71. (not (<-> (not true) true))
72. (not (<-> (not nil) nil))
73. (not (<-> (not A) A))
74. (and true (not (not true)))
75. (and true (and true true))
76. (and true (or true true))
77. (and true (or true nil))
78. (and true (or true A))
79. (and true (or nil true))
80. (and true (or A true))
81. (and true (-> true true))
82. (and true (-> nil true))
83. (and true (-> nil nil))
84. (and true (-> nil A))
85. (and true (-> A true))
86. (and true (-> A A))
87. (and true (<-> true true))
88. (and true (<-> nil nil))
89. (and true (<-> A A))
90. (and (not nil) (not nil))
91. (and (not (not true)) true)
92. (and (and true true) true)
93. (and (or true true) true)
94. (and (or true nil) true)
95. (and (or true A) true)
96. (and (or nil true) true)
97. (and (or A true) true)
98. (and (-> true true) true)
99. (and (-> nil true) true)
100. (and (-> nil nil) true)
101. (and (-> nil A) true)
102. (and (-> A true) true)
103. (and (-> A A) true)
104. (and (<-> true true) true)
105. (and (<-> nil nil) true)
106. (and (<-> A A) true)
107. (or nil (not (not true)))
108. (or nil (and true true))
109. (or nil (or true true))
110. (or nil (or true nil))
111. (or nil (or true A))
112. (or nil (or nil true))
113. (or nil (or A true))
114. (or nil (-> true true))
115. (or nil (-> nil true))
116. (or nil (-> nil nil))
117. (or nil (-> nil A))
118. (or nil (-> A true))
119. (or nil (-> A A))
120. (or nil (<-> true true))
121. (or nil (<-> nil nil))
122. (or nil (<-> A A))
123. (or A (not (not true)))
124. (or A (and true true))
125. (or A (or true true))
126. (or A (or true nil))
127. (or A (or true A))
128. (or A (or true B))
129. (or A (or nil true))
130. (or A (or A true))
131. (or A (or B true))
132. (or A (-> true true))
133. (or A (-> nil true))
134. (or A (-> nil nil))
135. (or A (-> nil A))
136. (or A (-> nil B))
137. (or A (-> A true))
138. (or A (-> A nil))
139. (or A (-> A A))
140. (or A (-> A B))
141. (or A (-> B true))
142. (or A (-> B B))
143. (or A (<-> true true))
144. (or A (<-> nil nil))
145. (or A (<-> nil A))
146. (or A (<-> A nil))
147. (or A (<-> A A))
148. (or A (<-> B B))
149. (or (not (not true)) nil)
150. (or (not (not true)) A)
151. (or (and true true) nil)
152. (or (and true true) A)
153. (or (or true true) nil)
154. (or (or true true) A)
155. (or (or true nil) nil)
156. (or (or true nil) A)
157. (or (or true A) nil)
158. (or (or true A) A)
159. (or (or true A) B)
160. (or (or nil true) nil)
161. (or (or nil true) A)
162. (or (or A true) nil)
163. (or (or A true) A)
164. (or (or A true) B)
165. (or (-> true true) nil)
166. (or (-> true true) A)
167. (or (-> nil true) nil)
168. (or (-> nil true) A)
169. (or (-> nil nil) nil)
170. (or (-> nil nil) A)
171. (or (-> nil A) nil)
172. (or (-> nil A) A)
173. (or (-> nil A) B)
174. (or (-> A true) nil)
175. (or (-> A true) A)
176. (or (-> A true) B)
177. (or (-> A nil) A)
178. (or (-> A A) nil)
179. (or (-> A A) A)
180. (or (-> A A) B)
181. (or (-> A B) A)
182. (or (<-> true true) nil)
183. (or (<-> true true) A)
184. (or (<-> nil nil) nil)
185. (or (<-> nil nil) A)
186. (or (<-> nil A) A)
187. (or (<-> A nil) A)
188. (or (<-> A A) nil)
189. (or (<-> A A) A)
190. (or (<-> A A) B)
191. (-> true (not (not true)))
192. (-> true (and true true))
193. (-> true (or true true))
194. (-> true (or true nil))
195. (-> true (or true A))
196. (-> true (or nil true))
197. (-> true (or A true))
198. (-> true (-> true true))
199. (-> true (-> nil true))
200. (-> true (-> nil nil))
201. (-> true (-> nil A))
202. (-> true (-> A true))
203. (-> true (-> A A))
204. (-> true (<-> true true))
205. (-> true (<-> nil nil))
206. (-> true (<-> A A))
207. (-> A (not (not true)))
208. (-> A (not (not A)))
209. (-> A (and true true))
210. (-> A (and true A))
211. (-> A (and A true))
212. (-> A (and A A))
213. (-> A (or true true))
214. (-> A (or true nil))
215. (-> A (or true A))
216. (-> A (or true B))
217. (-> A (or nil true))
218. (-> A (or nil A))
219. (-> A (or A true))
220. (-> A (or A nil))
221. (-> A (or A A))
222. (-> A (or A B))
223. (-> A (or B true))
224. (-> A (or B A))
225. (-> A (-> true true))
226. (-> A (-> true A))
227. (-> A (-> nil true))
228. (-> A (-> nil nil))
229. (-> A (-> nil A))
230. (-> A (-> nil B))
231. (-> A (-> A true))
232. (-> A (-> A A))
233. (-> A (-> B true))
234. (-> A (-> B A))
235. (-> A (-> B B))
236. (-> A (<-> true true))
237. (-> A (<-> true A))
238. (-> A (<-> nil nil))
239. (-> A (<-> A true))
240. (-> A (<-> A A))
241. (-> A (<-> B B))
242. (-> (not (not nil)) nil)
243. (-> (not (not nil)) A)
244. (-> (not (not A)) A)
245. (-> (and true nil) nil)
246. (-> (and true nil) A)
247. (-> (and true A) A)
248. (-> (and nil true) nil)
249. (-> (and nil true) A)
250. (-> (and nil nil) nil)
251. (-> (and nil nil) A)
252. (-> (and nil A) nil)
253. (-> (and nil A) A)
254. (-> (and nil A) B)
255. (-> (and A true) A)
256. (-> (and A nil) nil)
257. (-> (and A nil) A)
258. (-> (and A nil) B)
259. (-> (and A A) A)
260. (-> (and A B) A)
261. (-> (and A B) B)
262. (-> (or nil nil) nil)
263. (-> (or nil nil) A)
264. (-> (or nil A) A)
265. (-> (or A nil) A)
266. (-> (or A A) A)
267. (-> (-> true nil) nil)
268. (-> (-> true nil) A)
269. (-> (-> true A) A)
270. (-> (<-> true nil) nil)
271. (-> (<-> true nil) A)
272. (-> (<-> true A) A)
273. (-> (<-> nil true) nil)
274. (-> (<-> nil true) A)
275. (-> (<-> A true) A)
276. (<-> true (not (not true)))
277. (<-> true (and true true))
278. (<-> true (or true true))
279. (<-> true (or true nil))
280. (<-> true (or true A))
281. (<-> true (or nil true))
282. (<-> true (or A true))
283. (<-> true (-> true true))
284. (<-> true (-> nil true))
285. (<-> true (-> nil nil))
286. (<-> true (-> nil A))
287. (<-> true (-> A true))
288. (<-> true (-> A A))
289. (<-> true (<-> true true))
290. (<-> true (<-> nil nil))
291. (<-> true (<-> A A))
292. (<-> nil (not (not nil)))
293. (<-> nil (and true nil))
294. (<-> nil (and nil true))
295. (<-> nil (and nil nil))
296. (<-> nil (and nil A))
297. (<-> nil (and A nil))
298. (<-> nil (or nil nil))
299. (<-> nil (-> true nil))
300. (<-> nil (<-> true nil))
301. (<-> nil (<-> nil true))
302. (<-> A (not (not A)))
303. (<-> A (and true A))
304. (<-> A (and A true))
305. (<-> A (and A A))
306. (<-> A (or nil A))
307. (<-> A (or A nil))
308. (<-> A (or A A))
309. (<-> A (-> true A))
310. (<-> A (<-> true A))
311. (<-> A (<-> A true))
312. (<-> (not (not true)) true)
313. (<-> (not (not nil)) nil)
314. (<-> (not (not A)) A)
315. (<-> (and true true) true)
316. (<-> (and true nil) nil)
317. (<-> (and true A) A)
318. (<-> (and nil true) nil)
319. (<-> (and nil nil) nil)
320. (<-> (and nil A) nil)
321. (<-> (and A true) A)
322. (<-> (and A nil) nil)
323. (<-> (and A A) A)
324. (<-> (or true true) true)
325. (<-> (or true nil) true)
326. (<-> (or true A) true)
327. (<-> (or nil true) true)
328. (<-> (or nil nil) nil)
329. (<-> (or nil A) A)
330. (<-> (or A true) true)
331. (<-> (or A nil) A)
332. (<-> (or A A) A)
333. (<-> (-> true true) true)
334. (<-> (-> true nil) nil)
335. (<-> (-> true A) A)
336. (<-> (-> nil true) true)
337. (<-> (-> nil nil) true)
338. (<-> (-> nil A) true)
339. (<-> (-> A true) true)
340. (<-> (-> A A) true)
341. (<-> (<-> true true) true)
342. (<-> (<-> true nil) nil)
343. (<-> (<-> true A) A)
344. (<-> (<-> nil true) nil)
345. (<-> (<-> nil nil) true)
346. (<-> (<-> A true) A)
347. (<-> (<-> A A) true)

Commenti:
---------
*** dasuxullebt 13 October 2009 at 16:33
Why do you have <-> and ->. You wouldnt need both if you have -> and "and". In classical logic, you can also omit "and" by defining (and a b) by (-> (a -> (b -> nil))).

*** Kazimir Majorinc 13 October 2009 at 17:27
You are right. However, my intention is not to reduce number of existing logical operators and simplify expressions, but to try to derive expressions meaningful for people. Possibly to get some idea why some of these are meaningful.

Many logical systems have <->, and mathematicians use "if and only if" frequently, so probably there is something about that. Density of information, I guess, because

      (a <-> b)

is significantly shorter than

      (and (a -> b) (b -> a)).

Thanx on comment, come again.


-------------------------------------------------------------------
Opinions on Eval in Lisp, Python and Ruby - The Results of The Poll
-------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/opinions-on-eval-in-lisp-python-and.html

During September 2009, I made three polls with question "what do you think about eval?" for Lisp, Python and Ruby programmers separately. In total, there were 104 votes, between 30-40 for each language. Here are the results, graph and interpretations:

.                                                  Lisp          %     Python          %       Ruby          %
--------------------------------------------------------------------------------------------------------------
Eval is evil, harmful or at least unnecessary         2        4.9          7       21.9          0        0.0
Eval is useful but overused                          11       26.8          6       18.8          9       29.0
Eval has just the right place                        16       39.0         10       31.3         19       61.3
Eval is useful but neglected                          3        7.3          4       12.5          1        3.2
Eval is a single most important feature               5       12.2          0        0.0          0        0.0
I do not care for eval                                4        9.8          5       15.6          2        6.5
--------------------------------------------------------------------------------------------------------------
Total                                                41      100.0         32      100.0         31      100.0

Nota: Vedi il grafico "eval-graph.png" nella cartella "data".
(Those who voted they do not care about eval are ignored on graph.)

Great majority of Ruby programmers are satisfied with eval, and significant minority believe that eval is useful but overused. That means that Ruby designer should slightly discourage use of eval, or Ruby community should discuss the issue to reach understanding why and how not to use eval, or why use of eval is justified. Rubyists are not extremists - no one has extreme opinion, and it suggests that they have good capacity for cooperation - at least from the point of view of this, single aspect - which is not unimportant, since recently Ruby is frequently discussed in connection with metaprogramming.

The difference between Python programmers is more significant; majority of them think that eval has the right place in Python, and nearly equal number think that it is overused or neglected. However, large number of Python programmers believe that "eval is evil." Such a large group with extreme opinion suggests that Python community might separate in future on the group that wants Python to be more static, probably compiled - and others. Or, one group will prevail, and others will leave.

In Lisp community, it is exactly opposite: almost 15% Lisp programmers think that eval is essential, and about 5% think eval is evil. It is somehow strange that more Lispers than Rubyists are extremely against eval. Both extremes are significant, and it guarantees consistent disagreements and discussions on the topic. That means, community cannot be united - and it is not united, of course. Even in this single issue, fragmentation of Lisp community is justified.

Another possibility is that some Lisp programmers are not attracted by technical merits of the language, but by its allure - result of Lisp's long history, romantic AI past, and compliments given by programmers - celebrities like Yukihiro Matsumoto, Eric S. Raymond, Alan Kay, Paul Graham, Richard Stallman, Gregory Chaitin. However, I believe that those who do not like the language itself, especially its syntax, give up very early.

Comments are welcome.


------------------------------------------------
Why You Do Not Use Lisp? The Results of The Poll
------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/why-you-do-not-use-lisp-results-of-poll.html

0. Introduction

During early October 2009, I conducted the poll with question "Why you do not use Lisp?" on this blog. The poll was announced on related Usenet newsgroups comp.lang.lisp, comp.lang.programming, comp.lang.functional, and also on popular social sites Reddit and Digg.

Thirteen reasons were offered. It was specified that even people who use Lisp part of the time can answer why they do not use it in other part of the time. Lisp in this context means all Lisp dialects; and it was also specified. Multiple answers were allowed.

1. Results

I use Lisp, at least sometimes. 49 (44%)
It has not enough support for modern programming practice (libraries, threads and similar.) 42 (37%)
Its syntax repulses me. 26 (23%)
It is socially inadequate (small, not very alive community.)  23 (20%)
It doesn't have any technical advantage I might want. 20 (18%)
Its IDE is not good enough. 18 (16%)
I'd like to use Lisp, but my superiors or colleagues do not want that.  15 (13%)
It has not enough support for higher level programming (laziness, logic programming...) 15 (13%)
It is socially inadequate (arrogant, unhelping community.)  14 (12%)
It is too slow or bloated.  12 (10%)
It has attractive technical advantages, but these are hard to learn, use and not worth effort.  11 (9%)
It is OK, but only in some commercial version - and I want free or much cheaper one.  10 (9%)
It is so marginal that I never considered it. 9 (8%)

2. Comments

Presented on this way, it is not easy to recognize the message of the poll. All answers are expected, but what their relative importance means? However, I believe we can filter out important information, if we take into account two things: first, voters have much higher than average interest in Lisp and functional or metaprogramming than usually. Those who do not care for Lisp didn't care to vote on this poll as well. About 13% of voters would like to use Lisp, but they cannot because other their colleagues and bosses do not allow it. This is surprisingly low number of people - whatever your favourite language, the chance that your boss will prefer something else is large. If anything can be concluded it is that majority of Lispers somehow managed to group together or work on their own.

Lot of voters (37%) miss some libraries, or support for some modern feature. However, it doesn't say us much: lack of the libraries is universal phenomenon. I believe many people would say they do not use some mainstream language, say, Python because they've found that Ruby, Java or Perl have some specific library supported better. Second, this reason is somehow circular - less libraries means less users etc. Taking it into account, even if Lisp community wrote libraries as no one did, the result wouldn't be much better. It would be much better regarding libraries, but not much regarding programmers. Many of these who complain about lack of libraries probably already use Lisp part of the time.

The second reason is much stronger: 23% of voters do not like Lisp syntax. I incline to think that very few people who do not like Lisp syntax use Lisp on the first place. So, almost the half of the voters who do not use Lisp (56%) - on this poll - do that because of the syntax. If we assume that interest of the voters for Lisp is above average, we can safely say that Lisp syntax is the most important reason for majority of people who do not use Lisp.

One surprise, for me, is popularity of the answers "Lisp doesn't have any technical advantage I may want." (18%) "it has not enough support for higher level programming" (and it includes static typing) (13%) and "It has attractive technical advantages, but these are hard to learn, use and not worth effort" (9%) we have another revealing information - Lisp community didn't succeeded to develop or demonstrate technical advantages of Lisp. Functional languages programmers certainly understand these advantages, but they still think these are not that significant.

Good news is that Lisp got rid of its image as bloated and slow. Only 10% of voters complained about that. For, say, Modula-2, even that would be too much, but for Lisp family, which is certainly not designed to be among the leanest possible languages, the result is quite good.

Social inadequacy, i.e. small, not very alive community - rates surprisingly high (20%). I had no clue that people like to communicate that much. One might think that large community means lot of libraries. It does - but it still doesn't mean that voter will get the library he wants. So, it is, I believe, more of a human instinct for joining large, progressing, vibrant, active community, perhaps related to survival. Well, good information for all Lisp programmers and especially my Newlisp fellows; communication matters. On a related matter, significant number of voters (12%) believe that Lisp users are arrogant and unhelpful community.

Some 16% of voters missed good IDE. Well, two commercial Common Lisps have good IDE, and have free personal versions. PLT Scheme has nice IDE as well. Newlisp has very simple IDE. Personally I use Scite, which is text editor that can cooperate with command line tools easily, and it is good enough for me. About 9% of voters miss something in free versions, and it can be easily that it is again IDE.

Another poll that might interest you:

 Opinions on Eval in Lisp, Python and Ruby. The Results of The Poll.

Commenti:
---------
*** Anonymous 21 October 2009 at 16:14
did voters have to pick one answer or could they give various weights adding up to 100 pts?

*** Kazimir Majorinc 21 October 2009 at 17:01
The voters could pick as many answer as they want of listed 13. There was no weighting. Total number of answers is 264, that means voters chosen 2.4 answers on average.

*** Jacques Mattheij 21 October 2009 at 18:15
Hey Kazimir,
Thank you for an excellent post, some of the results were quite different than what I expected and that's why polls like this are interesting (after all, if the result is what you expected you learned, but not as much).
best regards,
Jacques

*** John F. Miller 23 October 2009 at 19:29
I would like to nuance your view of community and in paricular the "It has attractive technical advantages, but these are hard to learn..." answer. The Lisp community has tended to self-select towards formally eductated programmers who have, by the time they become lisp enthusiasts, already written their own lisp interpreter, etc. I spent my time in college studying physics and learning C. I now program in Ruby. I know that there are some amazing things one can do with lisp, but no one has ever presented me with a good tutorial on how to do them. There are lots of good resources on how lisp works, but this is like learning the rules of Chess, but never learning any stratagity. One ends up just pushing pieces randomly and loosing a lot. Once I learn the syntac, then what?

Rather then more of "How lisp works" I would like to see more "Using lisp to do really cool things"

*** Anonymous 9 March 2011 at 08:32
To my is simple, the mayor part of programmers are autodidacts who learned in books like Java for dummies.
Other important part with high education (BS. MS. ..) learn in courses based on structured programing inherited from numerical methods with fortran or pascal, but using newer languages like java.
Lisp is mainly learned by computer scientist, not always as a first language. One program in a language where one feels comfortable and productive.
Just very few learn to be productive with languages like lisp, scheme, haskell, ml, prolog, curry, etc.
That requires better education, more theoretical computer science oriented. A very small subset of programmers.

*** Agnius Vasiliauskas 28 November 2011 at 23:12
I think LISP suffers from the same illness as "pure" functional languages suffers - for the practical reasons they are MOST useful in scientific-related problem area - area which is mostly un-populated by the so called "mainstream" (industry) developers [C/C++,C#,JAVA,etc.]. There may be some data-centric uses with LISP/ Ocaml/etc. in the world of auto-trading software systems, but again in mission critical auto-trade tasks, C/C++ will be chosen because of speed issues (sometimes even linux kernel may be modified for lowering system latency). That is to say LISP/ML/other FP are cool languages, but in essence only for prototyping of some problems where BIG amount of fast prototyping is needed. And this is not the case of what 99,99% of industry developers day job consists. Maybe that is the reason why LISP didn't departure from the academics "airport"... Good luck.

*** Anonymous 2 February 2012 at 06:08
"Social inadequacy, i.e. small, not very alive community - rates surprisingly high (20%). I had no clue that people like to communicate that much."

Is that a joke? The sole reason of civilization is communicating.

Even survival is secondary. People with ample food but isolated, more likely to end up killing themselves.

But this is not exactly it in this case (see below):

"One might think that large community means lot of libraries. It does - but it still doesn't mean that voter will get the library he wants. So, it is, I believe, more of a human instinct for joining large, progressing, vibrant, active community, perhaps related to survival."

Isn't it obvious what it means?

Lot's of libraries.
MORE likely to get the library I want.
Lot's of JOBS.
Lot's of BOOKS and material on the language.
Lot's of FORUMS where I can find questions to my problems.
Lot's of TOOLING for the language.
Lot's of commercial support.
...

Anonymous2 February 2012 at 06:09
Plus:
More PROGRESS in the language and compiler development.

*** Preston L. Bannister 25 March 2012 at 17:12
I used Lisp quite a bit in school (UCI Lisp in the late 1970's) - a definite gain. At the time, Lisp was too fat for a lot of domains. Later, Lisp was either unfamiliar, or freaked out my coworkers. A programming language is not just for communicating with a computer, but also with coworkers. If I wrote code in Lisp, my coworkers would be entirely lost - not good.

Lisp is not good to use with (most) coworkers.

.... perhaps the above item should be on your survey. :-)

*** Kazimir Majorinc25 March 2012 at 21:09
You're right, Preston. It is especially true for people who do not program full time, for example, scientists and engineers.

*** Anonymous 13 January 2013 at 03:22
One thing I don't like about Lisp, especially Common Lisp, is that the language is not really evolving. Getting the Ansi process done wore out some of the best minds behind the language or something. And there is a lot of kruft laying about that is obsolete and a lot of simple things that are just not covered. But good luck getting anyone to seriously consider revving the spec. Part of that is for Lispers rolling your own way to bypass the ugly parts is pretty easy. But then you see how long a nice book like Practical Common Lisp fooled around just to handle file system directories without being bogged down in concerns that are part of Ansi Common Lisp that are no longer particularly relevant.


-----------------------------------------
One Hundred Propositional Tautologies (3)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-3.html

; By closer inspection of "prime tautologies" from my article
; `One hundred propositional tautologies (2)´, I noted that some of them are like

;                     (not (not (or true true)))

; It contains subformula (or true true), which is an instance of
; tautology

;                          (or true A).

; Hence, this formula doesn't say nothing new, but (not (not true)).
; and it should be removed from list of interesting tautologies.
; Generally, formula that has tautology as subformula (eccept
; trivial case - formula "true") is not interesting one. So, I
; decided to add one loop that will filter out such formulas from
; the list of 100 propositional tautologies, originally stored in
; prime-tautologies 1.

; The helper function, (lower-case-formula f) returns same formula as
; f, just  with all upper-case symbols changed to lower case. I need
; it because lower case is used as constant in unify.

; Helper function

(set 'lower-case-formula
     (lambda(f)
       (cond ((list? f)(map lower-case-formula f))
             ((> (length (string f)) 1) f)
             (true (sym (lower-case (string f)))))))

(set 'prime-tautologies1 (map lower-case-formula prime-tautologies1)) ; lower case - constants
(set 'prime-tautologies2 '())

(dolist(f1 prime-tautologies1)
  (set 'found-instance nil)
  (dolist(f2 prime-tautologies2 found-instance)
     (dolist(f3 (branches f1) found-instance)
        (unless(= f3 true)      ; othervise every subformula true
                                ; would be recognized as a special case.
         (when (unify f3 f2)
               (set 'found-instance true)
               (println "formula " f1 ", subformula " f3 " is instance of " f2 ")" )))))

  (unless found-instance
          (push (upper-case-formula f1) prime-tautologies2 -1)))

(println "Filtered to " (length prime-tautologies2) ". prime tautologies2")
(map (lambda(x)(println $idx ". " x)) prime-tautologies2)

; Output:

; We started with 12971 formulas.
; Filtered to 2467 tautologies.
; Filtered to 350. prime tautologies1
;
; formula (not (not (or true true))), subformula (or true true) is instance of (or true A))
; formula (not (not (or true nil))), subformula (or true nil) is instance of (or true A))
; ...
; Filtered to 178. prime tautologies2
;
; 0. true
; 1. (not nil)
; 2. (not (not true))
; 3. (and true true)
; 4. (or true true)
; 5. (or true nil)
; 6. (or true A)
; 7. (or nil true)
; 8. (or A true)
; 9. (-> true true)
; 10. (-> nil true)
; 11. (-> nil nil)
; 12. (-> nil A)
; 13. (-> A true)
; 14. (-> A A)
; 15. (<-> true true)
; 16. (<-> nil nil)
; 17. (<-> A A)
; 18. (not (not (not nil)))
; 19. (not (and true nil))
; 20. (not (and nil true))
; 21. (not (and nil nil))
; 22. (not (and nil A))
; 23. (not (and A nil))
; 24. (not (or nil nil))
; 25. (not (-> true nil))
; 26. (not (<-> true nil))
; 27. (not (<-> nil true))
; 28. (and true (not nil))
; 29. (and (not nil) true)
; 30. (or nil (not nil))
; 31. (or A (not nil))
; 32. (or A (not A))
; 33. (or (not nil) nil)
; 34. (or (not nil) A)
; 35. (or (not A) A)
; 36. (-> true (not nil))
; 37. (-> A (not nil))
; 38. (-> (not true) nil)
; 39. (-> (not true) A)
; 40. (<-> true (not nil))
; 41. (<-> nil (not true))
; 42. (<-> (not true) nil)
; 43. (<-> (not nil) true)
; 44. (not (not (not (not true))))
; 45. (not (not (and true true)))
; 46. (not (and true (not true)))
; 47. (not (and A (not true)))
; 48. (not (and A (not A)))
; 49. (not (and (not true) true))
; 50. (not (and (not true) A))
; 51. (not (and (not A) A))
; 52. (not (or nil (not true)))
; 53. (not (or (not true) nil))
; 54. (not (-> true (not true)))
; 55. (not (-> (not nil) nil))
; 56. (not (<-> true (not true)))
; 57. (not (<-> nil (not nil)))
; 58. (not (<-> A (not A)))
; 59. (not (<-> (not true) true))
; 60. (not (<-> (not nil) nil))
; 61. (not (<-> (not A) A))
; 62. (and true (not (not true)))
; 63. (and true (and true true))
; 64. (and (not nil) (not nil))
; 65. (and (not (not true)) true)
; 66. (and (and true true) true)
; 67. (or nil (not (not true)))
; 68. (or nil (and true true))
; 69. (or A (not (not true)))
; 70. (or A (and true true))
; 71. (or A (-> A nil))
; 72. (or A (-> A B))
; 73. (or A (<-> nil A))
; 74. (or A (<-> A nil))
; 75. (or (not (not true)) nil)
; 76. (or (not (not true)) A)
; 77. (or (and true true) nil)
; 78. (or (and true true) A)
; 79. (or (-> A nil) A)
; 80. (or (-> A B) A)
; 81. (or (<-> nil A) A)
; 82. (or (<-> A nil) A)
; 83. (-> true (not (not true)))
; 84. (-> true (and true true))
; 85. (-> A (not (not true)))
; 86. (-> A (not (not A)))
; 87. (-> A (and true true))
; 88. (-> A (and true A))
; 89. (-> A (and A true))
; 90. (-> A (and A A))
; 91. (-> A (or nil A))
; 92. (-> A (or A nil))
; 93. (-> A (or A A))
; 94. (-> A (or A B))
; 95. (-> A (or B A))
; 96. (-> A (-> true A))
; 97. (-> A (-> B A))
; 98. (-> A (<-> true A))
; 99. (-> A (<-> A true))
; 100. (-> (not (not nil)) nil)
; 101. (-> (not (not nil)) A)
; 102. (-> (not (not A)) A)
; 103. (-> (and true nil) nil)
; 104. (-> (and true nil) A)
; 105. (-> (and true A) A)
; 106. (-> (and nil true) nil)
; 107. (-> (and nil true) A)
; 108. (-> (and nil nil) nil)
; 109. (-> (and nil nil) A)
; 110. (-> (and nil A) nil)
; 111. (-> (and nil A) A)
; 112. (-> (and nil A) B)
; 113. (-> (and A true) A)
; 114. (-> (and A nil) nil)
; 115. (-> (and A nil) A)
; 116. (-> (and A nil) B)
; 117. (-> (and A A) A)
; 118. (-> (and A B) A)
; 119. (-> (and A B) B)
; 120. (-> (or nil nil) nil)
; 121. (-> (or nil nil) A)
; 122. (-> (or nil A) A)
; 123. (-> (or A nil) A)
; 124. (-> (or A A) A)
; 125. (-> (-> true nil) nil)
; 126. (-> (-> true nil) A)
; 127. (-> (-> true A) A)
; 128. (-> (<-> true nil) nil)
; 129. (-> (<-> true nil) A)
; 130. (-> (<-> true A) A)
; 131. (-> (<-> nil true) nil)
; 132. (-> (<-> nil true) A)
; 133. (-> (<-> A true) A)
; 134. (<-> true (not (not true)))
; 135. (<-> true (and true true))
; 136. (<-> nil (not (not nil)))
; 137. (<-> nil (and true nil))
; 138. (<-> nil (and nil true))
; 139. (<-> nil (and nil nil))
; 140. (<-> nil (and nil A))
; 141. (<-> nil (and A nil))
; 142. (<-> nil (or nil nil))
; 143. (<-> nil (-> true nil))
; 144. (<-> nil (<-> true nil))
; 145. (<-> nil (<-> nil true))
; 146. (<-> A (not (not A)))
; 147. (<-> A (and true A))
; 148. (<-> A (and A true))
; 149. (<-> A (and A A))
; 150. (<-> A (or nil A))
; 151. (<-> A (or A nil))
; 152. (<-> A (or A A))
; 153. (<-> A (-> true A))
; 154. (<-> A (<-> true A))
; 155. (<-> A (<-> A true))
; 156. (<-> (not (not true)) true)
; 157. (<-> (not (not nil)) nil)
; 158. (<-> (not (not A)) A)
; 159. (<-> (and true true) true)
; 160. (<-> (and true nil) nil)
; 161. (<-> (and true A) A)
; 162. (<-> (and nil true) nil)
; 163. (<-> (and nil nil) nil)
; 164. (<-> (and nil A) nil)
; 165. (<-> (and A true) A)
; 166. (<-> (and A nil) nil)
; 167. (<-> (and A A) A)
; 168. (<-> (or nil nil) nil)
; 169. (<-> (or nil A) A)
; 170. (<-> (or A nil) A)
; 171. (<-> (or A A) A)
; 172. (<-> (-> true nil) nil)
; 173. (<-> (-> true A) A)
; 174. (<-> (<-> true nil) nil)
; 175. (<-> (<-> true A) A)
; 176. (<-> (<-> nil true) nil)
; 177. (<-> (<-> A true) A)


-----------------------------------------
One Hundred Propositional Tautologies (4)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-4.html

; In list of the propositional tautologies from the last article
; in this series, I have found another redundancy. For example,
; both (or true nil) and (or true A) are still in the 100 formulas,
; although (or true nil) is special case of (or true A).

; How it happened? (or true A) is discovered after
; (or true nil). So, tests confirmed that (or true A) is not the instance
; of any tautology, but (or true nil) suddenly became the instance.
; of later developed theorem. And what now?

; (or true nil) becomes some kind of a formula for museum. In time it
; was discovered, it was interesting enough, but now - it cannot
; be effectively used any more in future development. So, what to
; do with that? I'll build special list, and call it museum. OK,
; I could use the word "archive", but this word is somehow overloaded,
; so I'll use museum.
;
; Then, I'll change the program on this way: first,
;
;    (1) it generates all propositional formulas of a given length,
;        making a list PF.
;
;    (2) it filters out tautologies - and makes the list T1
;
;    (3) one by one, it passes through tautologies in T1 and tests
;        whether some of them are instances of other, previously
;        developed tautologies in T1. More than that, it tests
;        whether some of the subformulas of tautologies is an
;        instance of the previously developed tautologies. Only
;        those tautologies, proved not to be an instances are
;        inserted in new list T2.
;
;    (4) Some of the formulas from T2 are "obsolete", because
;        some of the tautologies generated later are more general
;        - more general in a sense - older formula is and instance
;        - of new formula, or some subformula of the older formula
;        is an instance of a newer formula. These formulas are
;        moved to "museum", I'll name it M2.

(load "http://www.instprog.com/Instprog.default-library.lsp")

(set 'PF (apply append (map (lambda(x)(all-pf x '(true nil a b c d e)
                                                '(not)
                                                '(and or -> <->)))
                            (sequence 1 5))))

(println "Generated " (length PF) " formulas.")

(set 'T1 (filter tautology? PF))

(println "Filtered to " (length T1) " tautologies in T1.")

(set 'T2 (list))
(dolist(f1 T1)
   (set 'is-instance nil)
   (dolist(f2 T2 is-instance)
      (let((uf2 (upper-case-formula f2)))
          (dolist (sf1 (difference (branches f1) booleans) is-instance)
            (set 'u (unify sf1 uf2))
            (when (or u (= u '()))
                  (set 'is-instance true)))))
    (unless is-instance
            (push f1 T2 -1)))

(println "Filtered to " (length T2) " tautologies in T2.")

(set 'T2 (reverse T2))
(set 'T3 (list))
(set 'M3 (list))

(dolist(f1 T2)
   (set 'f1counter $idx)
   (set 'is-instance nil)
   (dolist(f2 T2)
     (when (> f1counter $idx)
        (let((uf2 (upper-case-formula f2)))
          (dolist (sf1 (difference (branches f1) booleans) is-instance)
            (set 'u (unify sf1 uf2))
            (when (or u (= u '()))
                  ;(println "--- " f1counter " ---")
                  ;(println=  "\nInstance discovered: \n" f1 "\n" sf1 "\n" uf2)
                  (set 'is-instance true))))))
   (if is-instance (push f1 M3)
                   (push f1 T3)))

(println "Filtered to " (length T3) " tautologies in T3 and "
                        (length M3) " tautologies in M3.")

(println "\n\n\n*** T3 ***\n")
(map (lambda(x)(println (+ $idx 1) ". " x)) T3)

(println "\n\n\n*** M3 ***\n")
(map (lambda(x)(println (+ $idx 1) ". " x)) M3)

(exit)

;---------------------------------------------------------------
; OUTPUT

Generated 12971 formulas.
Filtered to 2467 tautologies in T1.
Filtered to 137 tautologies in T2.
Filtered to 84 tautologies in T3 and 53 tautologies in M3.

*** T3 ***

1. true
2. (not nil)
3. (not (not true))
4. (and true true)
5. (or true a)
6. (or a true)
7. (-> nil a)
8. (-> a true)
9. (-> a a)
10. (<-> a a)
11. (not (and nil a))
12. (not (and a nil))
13. (not (or nil nil))
14. (not (-> true nil))
15. (not (<-> true nil))
16. (not (<-> nil true))
17. (or a (not a))
18. (or (not a) a)
19. (-> (not true) a)
20. (<-> nil (not true))
21. (<-> (not true) nil)
22. (not (and a (not true)))
23. (not (and a (not a)))
24. (not (and (not true) a))
25. (not (and (not a) a))
26. (not (or nil (not true)))
27. (not (or (not true) nil))
28. (not (-> true (not true)))
29. (not (<-> a (not a)))
30. (not (<-> (not a) a))
31. (or a (-> a b))
32. (or a (<-> nil a))
33. (or a (<-> a nil))
34. (or (-> a b) a)
35. (or (<-> nil a) a)
36. (or (<-> a nil) a)
37. (-> a (not (not a)))
38. (-> a (and true a))
39. (-> a (and a true))
40. (-> a (and a a))
41. (-> a (or a b))
42. (-> a (or b a))
43. (-> a (-> b a))
44. (-> a (<-> true a))
45. (-> a (<-> a true))
46. (-> (not (not a)) a)
47. (-> (and nil a) b)
48. (-> (and a nil) b)
49. (-> (and a b) a)
50. (-> (and a b) b)
51. (-> (or nil nil) a)
52. (-> (or nil a) a)
53. (-> (or a nil) a)
54. (-> (or a a) a)
55. (-> (-> true nil) a)
56. (-> (-> true a) a)
57. (-> (<-> true nil) a)
58. (-> (<-> true a) a)
59. (-> (<-> nil true) a)
60. (-> (<-> a true) a)
61. (<-> nil (and nil a))
62. (<-> nil (and a nil))
63. (<-> a (not (not a)))
64. (<-> a (and true a))
65. (<-> a (and a true))
66. (<-> a (and a a))
67. (<-> a (or nil a))
68. (<-> a (or a nil))
69. (<-> a (or a a))
70. (<-> a (-> true a))
71. (<-> a (<-> true a))
72. (<-> a (<-> a true))
73. (<-> (not (not a)) a)
74. (<-> (and true a) a)
75. (<-> (and nil a) nil)
76. (<-> (and a true) a)
77. (<-> (and a nil) nil)
78. (<-> (and a a) a)
79. (<-> (or nil a) a)
80. (<-> (or a nil) a)
81. (<-> (or a a) a)
82. (<-> (-> true a) a)
83. (<-> (<-> true a) a)
84. (<-> (<-> a true) a)

*** M3 ***

1. (or true true)
2. (or true nil)
3. (or nil true)
4. (-> true true)
5. (-> nil true)
6. (-> nil nil)
7. (<-> true true)
8. (<-> nil nil)
9. (not (and true nil))
10. (not (and nil true))
11. (not (and nil nil))
12. (-> (not true) nil)
13. (not (and true (not true)))
14. (not (and (not true) true))
15. (not (<-> true (not true)))
16. (not (<-> (not true) true))
17. (or a (-> a nil))
18. (or (-> a nil) a)
19. (-> a (or nil a))
20. (-> a (or a nil))
21. (-> a (or a a))
22. (-> a (-> true a))
23. (-> (and true nil) nil)
24. (-> (and true nil) a)
25. (-> (and true a) a)
26. (-> (and nil true) nil)
27. (-> (and nil true) a)
28. (-> (and nil nil) nil)
29. (-> (and nil nil) a)
30. (-> (and nil a) nil)
31. (-> (and nil a) a)
32. (-> (and a true) a)
33. (-> (and a nil) nil)
34. (-> (and a nil) a)
35. (-> (and a a) a)
36. (-> (or nil nil) nil)
37. (-> (-> true nil) nil)
38. (-> (<-> true nil) nil)
39. (-> (<-> nil true) nil)
40. (<-> nil (and true nil))
41. (<-> nil (and nil true))
42. (<-> nil (and nil nil))
43. (<-> nil (or nil nil))
44. (<-> nil (-> true nil))
45. (<-> nil (<-> true nil))
46. (<-> nil (<-> nil true))
47. (<-> (and true nil) nil)
48. (<-> (and nil true) nil)
49. (<-> (and nil nil) nil)
50. (<-> (or nil nil) nil)
51. (<-> (-> true nil) nil)
52. (<-> (<-> true nil) nil)
53. (<-> (<-> nil true) nil)


-----------------------------------------
One Hundred Propositional Tautologies (5)
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2009/10/one-hundred-propositional-tautologies-5.html

The same like last post, but this time 1500 tautologies, and
these are in the infix form. It is very easy to change prefix
into infix in Newlisp. And vice versa - same function can be
used for changing infix to prefix. But, tautologies are great.

(set 'infix<->prefix
  (lambda(L)
    (cond ((symbol? L) L)
          ((= (length L) 2) (map infix<->prefix L))
          ((= (length L) 3) (let((L1 (map infix<->prefix L)))
                                (list (nth 1 L1) (nth 0 L1) (nth 2 L1)))))))

Generated 1005725 formulas.
Filtered to 187105 tautologies in T1.
Filtered to 2730 tautologies in T2.
Filtered to 1581 tautologies in T3 and 1149 tautologies in M3.

Per l'output vedi il file "tautologie.txt" nella cartella "data".


---------
Tortelvis
---------
http://kazimirmajorinc.blogspot.com/2009/11/tortelvis.html

What the Heck is Tortelvis?

Tortelvis is agile 130 kg strong Elvis impersonator singer of Dread Zeppelin,
the band that plays Led Zeppelin covers in a reggae style. Definitely
fascinating. But, sometimes, you do not want the copy, you want the real thing.
Look here:
> (set 'L (list 1 2 3))
(1 2 3)
> (set 'push-right (lambda(a b)(push a b -1)))
(lambda (a b) (push a b -1))
> (push-right 4 L)
(1 2 3 4)
> L
(1 2 3)

Did you expected (1 2 3 4)? Well, Newlisp is sometimes too functional. This
time it passed copy of L to the push-right. OK, we'll fix it now.

> (set 'push-right (lambda-macro(a b)(eval (expand '(push a b -1) 'a 'b))))
(lambda-macro (a b) (eval (expand '(push a b -1) 'a 'b)))
> (push-right 5 L)
(1 2 3 5)
> L
(1 2 3 5)

Commenti:
---------
Anonymous10 November 2009 at 17:51
Is it not easier this way:

(set 'push-right (lambda-macro (a b) (push (eval a) (eval b) -1 )))

and safer:

(define (push-right a b) (push a b -1))
(set 'L:L '(1 2 3)
(push 4 L)
L:L -> '(1 2 3 4)

*** Anonymous 10 November 2009 at 17:52
correction:

(push-right 4 L)
L:L -> '(1 2 3 4)

*** Kazimir Majorinc 10 November 2009 at 18:42
Let me see, yes, you're right - the first is easier and the second is safer.


----------------------------------------------------------------------------------
Relatively Short Propositional Formulas and Symbols Instead of Pointers and Tables
----------------------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2009/11/relatively-short-propositional-formulas.html

; Boolean functions are functions from set {0, 1} to set {0, 1}.
; Our well known logical connectives and, or and not are such
; Boolean functions. In usual mathematical notation, it would be
; written:
;
;         or(0,0)=0; or(0,1)=1; or(1,0)=1; or(1,1)=1.
;
; Frequently, Booleans functions are defined in the form of the
; "truth-table".
;
;                   a  b (or a b)
;                  ---------------
;                   0  0    0
;                   0  1    1
;                   1  0    1
;                   1  1    1
;
; Boolean function is determined by third column, in this case,
; 0111. For each Boolean function, there are many possible formulas
; that define the function. In our example (or a b), but also
; (not (and a b)), (and (not a) (not b)), (-> (not a) b), and
; many others. Boolean functions and propositional formulas are very
; important, because computers are machines that calculate boolean
; functions, using physical realization of proposition formulas.
;
; The following program analyzes given list of all propositional
; formulas, and search for minimal between equivalent formulas.
;
; For all formulas f in list (f0 f1 ... fn),
;
;   (i) Boolean function B defined with f is found
;   (ii) it is tested whether f is a first formula that defines B,
;        or it is shorter than other formulas defining B.
;
; The program builds data structure, defining and using symbols.
; For example, if list ((or a b) (not (and a b)) (-> (not a) b)) is
; given, the program would first found that (or a b) defines Boolean
; function given with column 0111 in truth table. Then it would define
; two symbols and values:
;
;     [Boolean-function.0111] => ((or a b))
;     [propositional-formulas.(or a b)] => [Boolean-function.0111]
;
; After that, (not (and a b)) is found to define same Boolean function,
; but it is longer than (or a b), so nothing changes. If some shorter
; formula defining same Boolean function is found, then
; value [Boolean-function.0111] would be redefined.
;
; In this program, symbols are used instead of hash tables, in some
; other languages, where syntax would be something like
; Boolean-function[0111] instead. One might be surprised with such
; use of the symbols, and think it is abuse of the symbols. But,
; I think it is actually apropriate use, because, in general case,
; there is no reasons for distinction between hash table name,
; and key.
;
; In following program, such procedure is applied on all formulas
; with seven or less "nodes", and finally, all defined Boolean
; functions, and shortest formulas defining these Boolean functions
; are printed.

(set '[println.supressed] true '[print.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(set '[println.supressed] nil '[print.supressed] nil)

(set 'PF (apply append (map (lambda(x)(all-pf x '(true nil A B C)
                                                '(not)
                                                '(and or -> <->)))
                            (sequence 1 7))))

(box-standard "Generated " (length PF) " formulas.")

(set 'truth-column
     (lambda(f)(let ((result '()))
                    (letex((L (propositional-variables f)))
                          (dolist-multi(L '(nil true))
                             (push (eval f) result -1))
                    result))))

(set 'truth-column01
     (lambda(f)(apply string (map (lambda(x)(if x "1" "0"))
                                  (truth-column f)))))

(set 'symexpr (lambda()
                 (let ((result "["))
                      (dolist(i (args))
                        (set 'result (append result (string i) ".")))
                      (setf (last result) "]")
                      (sym result))))

(dolist(formula PF)
  (dolist(subformula (branches formula)) ; for formulas, branches are subformulas
    (set 'canonized-subformula (canon subformula)) ; canon: variables occur in alphabetical order
    (set 'canonized-subformula-symbol
         (symexpr "propositional-formula" canonized-subformula))
    (if (= (eval canonized-subformula-symbol) nil)
        ; new canonized subformula
       (begin (set 'Boolean-function-symbol
                   (symexpr "Boolean-function" (truth-column01 canonized-subformula)))
              (set canonized-subformula-symbol Boolean-function-symbol)
              (if (= (eval Boolean-function-symbol) nil)
                  ; new category
                  (set Boolean-function-symbol (list canonized-subformula))
                  ; old category
                  (if (< (size canonized-subformula)   ;new formula is leader of subcategory
                         (size (first (eval Boolean-function-symbol))))
                       ; canonized subformula is the best represent of category
                       (set Boolean-function-symbol (list canonized-subformula))
                       ; canonized subformula isn't the best represent of category
                       "do nothing")))
          ;old canonized subformula
          "do nothing")))

(set 'counter 1)
(dolist(formula PF)
  (when (= formula (canon formula))
     (set 'propositional-formula-symbol (symexpr "propositional-formula" formula))
     (set 'Boolean-function-symbol (symexpr "Boolean-function" (truth-column01 formula)))
     (when (= formula (first (eval Boolean-function-symbol)))
           (println counter ". " formula ", " Boolean-function-symbol)
           (inc counter))))
(exit)

                      +------------------+
                      | Generated 287535 |
                      |    formulas.     |
                      +------------------+

1. true, [Boolean-function.1]
2. nil, [Boolean-function.0]
3. A, [Boolean-function.01]
4. (not A), [Boolean-function.10]
5. (and nil A), [Boolean-function.00]
6. (and A B), [Boolean-function.0001]
7. (or true A), [Boolean-function.11]
8. (or A B), [Boolean-function.0111]
9. (-> A B), [Boolean-function.1101]
10. (<-> A B), [Boolean-function.1001]
11. (not (and A B)), [Boolean-function.1110]
12. (not (or A B)), [Boolean-function.1000]
13. (not (-> A B)), [Boolean-function.0010]
14. (not (<-> A B)), [Boolean-function.0110]
15. (and (not A) B), [Boolean-function.0100]
16. (or A (not B)), [Boolean-function.1011]
17. (and nil (and A B)), [Boolean-function.0000]
18. (and A (and B C)), [Boolean-function.00000001]
19. (and A (or true B)), [Boolean-function.0011]
20. (and A (or B C)), [Boolean-function.00000111]
21. (and A (-> B C)), [Boolean-function.00001101]
22. (and A (<-> B C)), [Boolean-function.00001001]
23. (and (or true A) B), [Boolean-function.0101]
24. (and (or A B) C), [Boolean-function.00010101]
25. (and (-> A B) C), [Boolean-function.01010001]
26. (and (<-> A B) C), [Boolean-function.01000001]
27. (or true (and A B)), [Boolean-function.1111]
28. (or A (and B C)), [Boolean-function.00011111]
29. (or A (or B C)), [Boolean-function.01111111]
30. (or A (-> B C)), [Boolean-function.11011111]
31. (or A (<-> B C)), [Boolean-function.10011111]
32. (or (and A B) C), [Boolean-function.01010111]
33. (or (-> A B) C), [Boolean-function.11110111]
34. (or (<-> A B) C), [Boolean-function.11010111]
35. (-> A (and nil B)), [Boolean-function.1100]
36. (-> A (and B C)), [Boolean-function.11110001]
37. (-> A (-> B C)), [Boolean-function.11111101]
38. (-> A (<-> B C)), [Boolean-function.11111001]
39. (-> (or A B) C), [Boolean-function.11010101]
40. (-> (-> A B) C), [Boolean-function.01011101]
41. (-> (<-> A B) C), [Boolean-function.01111101]
42. (<-> A (and B C)), [Boolean-function.11100001]
43. (<-> A (or B C)), [Boolean-function.10000111]
44. (<-> A (-> B C)), [Boolean-function.00101101]
45. (<-> A (<-> B C)), [Boolean-function.01101001]
46. (<-> (and nil A) B), [Boolean-function.1010]
47. (<-> (and A B) C), [Boolean-function.10101001]
48. (<-> (or A B) C), [Boolean-function.10010101]
49. (<-> (-> A B) C), [Boolean-function.01011001]
50. (not (and A (and B C))), [Boolean-function.11111110]
51. (not (and A (or B C))), [Boolean-function.11111000]
52. (not (and A (-> B C))), [Boolean-function.11110010]
53. (not (and A (<-> B C))), [Boolean-function.11110110]
54. (not (and (or A B) C)), [Boolean-function.11101010]
55. (not (and (-> A B) C)), [Boolean-function.10101110]
56. (not (and (<-> A B) C)), [Boolean-function.10111110]
57. (not (or A (and B C))), [Boolean-function.11100000]
58. (not (or A (or B C))), [Boolean-function.10000000]
59. (not (or A (-> B C))), [Boolean-function.00100000]
60. (not (or A (<-> B C))), [Boolean-function.01100000]
61. (not (or (and A B) C)), [Boolean-function.10101000]
62. (not (or (-> A B) C)), [Boolean-function.00001000]
63. (not (or (<-> A B) C)), [Boolean-function.00101000]
64. (not (-> A (and B C))), [Boolean-function.00001110]
65. (not (-> A (-> B C))), [Boolean-function.00000010]
66. (not (-> A (<-> B C))), [Boolean-function.00000110]
67. (not (-> (or A B) C)), [Boolean-function.00101010]
68. (not (-> (-> A B) C)), [Boolean-function.10100010]
69. (not (-> (<-> A B) C)), [Boolean-function.10000010]
70. (not (<-> A (and B C))), [Boolean-function.00011110]
71. (not (<-> A (or B C))), [Boolean-function.01111000]
72. (not (<-> A (-> B C))), [Boolean-function.11010010]
73. (not (<-> A (<-> B C))), [Boolean-function.10010110]
74. (not (<-> (and A B) C)), [Boolean-function.01010110]
75. (not (<-> (or A B) C)), [Boolean-function.01101010]
76. (not (<-> (-> A B) C)), [Boolean-function.10100110]
77. (and A (and (not B) C)), [Boolean-function.00000100]
78. (and A (or B (not C))), [Boolean-function.00001011]
79. (and (not A) (and B C)), [Boolean-function.00010000]
80. (and (not A) (or B C)), [Boolean-function.01110000]
81. (and (not A) (-> B C)), [Boolean-function.11010000]
82. (and (not A) (<-> B C)), [Boolean-function.10010000]
83. (and (not (and A B)) C), [Boolean-function.01010100]
84. (and (not (or A B)) C), [Boolean-function.01000000]
85. (and (not (<-> A B)) C), [Boolean-function.00010100]
86. (and (or A (not B)) C), [Boolean-function.01000101]
87. (or A (not (and B C))), [Boolean-function.11101111]
88. (or A (not (or B C))), [Boolean-function.10001111]
89. (or A (not (-> B C))), [Boolean-function.00101111]
90. (or A (not (<-> B C))), [Boolean-function.01101111]
91. (or A (and (not B) C)), [Boolean-function.01001111]
92. (or A (or B (not C))), [Boolean-function.10111111]
93. (or (and A B) (not C)), [Boolean-function.10101011]
94. (or (-> A B) (not C)), [Boolean-function.11111011]
95. (or (<-> A B) (not C)), [Boolean-function.11101011]
96. (or (and (not A) B) C), [Boolean-function.01110101]
97. (-> A (and (not B) C)), [Boolean-function.11110100]
98. (<-> A (and (not B) C)), [Boolean-function.10110100]
99. (<-> A (or B (not C))), [Boolean-function.01001011]
100. (<-> (and (not A) B) C), [Boolean-function.10011010]
101. (<-> (or A (not B)) C), [Boolean-function.01100101]
102. (not (and (or A (not B)) C)), [Boolean-function.10111010]
103. (not (or A (and (not B) C))), [Boolean-function.10110000]
104. (not (or (and (not A) B) C)), [Boolean-function.10001010]
105. (and nil (and A (and B C))), [Boolean-function.00000000]
106. (and A (and B (or true C))), [Boolean-function.00000011]
107. (and A (and (or true B) C)), [Boolean-function.00000101]
108. (and A (or true (and B C))), [Boolean-function.00001111]
109. (and A (-> B (and nil C))), [Boolean-function.00001100]
110. (and A (<-> (and nil B) C)), [Boolean-function.00001010]
111. (and (or true A) (and B C)), [Boolean-function.00010001]
112. (and (or true A) (or B C)), [Boolean-function.01110111]
113. (and (or true A) (-> B C)), [Boolean-function.11011101]
114. (and (or true A) (<-> B C)), [Boolean-function.10011001]
115. (and (or A B) (or true C)), [Boolean-function.00111111]
116. (and (or A B) (or B C)), [Boolean-function.00110111]
117. (and (or A B) (-> A C)), [Boolean-function.00110101]
118. (and (or A B) (-> B C)), [Boolean-function.00011101]
119. (and (or A B) (-> C B)), [Boolean-function.00111011]
120. (and (or A B) (<-> A C)), [Boolean-function.00100101]
121. (and (or A B) (<-> B C)), [Boolean-function.00011001]
122. (and (-> A B) (or true C)), [Boolean-function.11110011]
123. (and (-> A B) (or A C)), [Boolean-function.01010011]
124. (and (-> A B) (or B C)), [Boolean-function.01110011]
125. (and (-> A B) (-> B C)), [Boolean-function.11010001]
126. (and (-> A B) (-> C A)), [Boolean-function.10100011]
127. (and (-> A B) (-> C B)), [Boolean-function.10110011]
128. (and (-> A B) (<-> A C)), [Boolean-function.10100001]
129. (and (-> A B) (<-> B C)), [Boolean-function.10010001]
130. (and (<-> A B) (or true C)), [Boolean-function.11000011]
131. (and (<-> A B) (or A C)), [Boolean-function.01000011]
132. (and (<-> A B) (-> A C)), [Boolean-function.11000001]
133. (and (<-> A B) (-> C A)), [Boolean-function.10000011]
134. (and (<-> A B) (<-> A C)), [Boolean-function.10000001]
135. (and (or true (and A B)) C), [Boolean-function.01010101]
136. (and (or A (and B C)) B), [Boolean-function.00010011]
137. (and (or A (or B C)) B), [Boolean-function.00110011]
138. (and (-> A (and nil B)) C), [Boolean-function.01010000]
139. (and (-> A (and B C)) B), [Boolean-function.00110001]
140. (and (<-> A (and B C)) B), [Boolean-function.00100001]
141. (and (<-> (and nil A) B) C), [Boolean-function.01000100]
142. (or true (and A (and B C))), [Boolean-function.11111111]
143. (or A (and (or true B) C)), [Boolean-function.01011111]
144. (or A (-> B (and nil C))), [Boolean-function.11001111]
145. (or A (<-> (and nil B) C)), [Boolean-function.10101111]
146. (or (and A B) (-> C B)), [Boolean-function.10111011]
147. (or (and A B) (<-> A C)), [Boolean-function.10100111]
148. (or (and A B) (<-> B C)), [Boolean-function.10011011]
149. (or (<-> A B) (and A C)), [Boolean-function.11000111]
150. (or (<-> A B) (and B C)), [Boolean-function.11010011]
151. (or (<-> A B) (<-> A C)), [Boolean-function.11100111]
152. (or (<-> A B) (<-> B C)), [Boolean-function.11011011]
153. (or (-> A (and nil B)) C), [Boolean-function.11110101]
154. (or (<-> A (or B C)) B), [Boolean-function.10110111]
155. (or (<-> A (<-> B C)) B), [Boolean-function.01111011]
156. (-> A (and nil (and B C))), [Boolean-function.11110000]
157. (-> A (-> B (and nil C))), [Boolean-function.11111100]
158. (-> A (<-> (and nil B) C)), [Boolean-function.11111010]
159. (-> (or A B) (and nil C)), [Boolean-function.11000000]
160. (-> (or A B) (and A C)), [Boolean-function.11000101]
161. (-> (or A B) (<-> A C)), [Boolean-function.11100101]
162. (-> (or A B) (<-> B C)), [Boolean-function.11011001]
163. (-> (-> A B) (<-> A C)), [Boolean-function.10101101]
164. (-> (-> A B) (<-> B C)), [Boolean-function.10011101]
165. (-> (<-> A B) (and nil C)), [Boolean-function.00111100]
166. (-> (<-> A B) (and A C)), [Boolean-function.00111101]
167. (-> (<-> A B) (<-> A C)), [Boolean-function.10111101]
168. (<-> A (and B (or A C))), [Boolean-function.11100011]
169. (<-> A (and (or true B) C)), [Boolean-function.10100101]
170. (<-> A (and (-> B A) C)), [Boolean-function.10110101]
171. (<-> A (and (<-> A B) C)), [Boolean-function.10110001]
172. (<-> A (or B (<-> A C))), [Boolean-function.01000111]
173. (<-> A (or (<-> A B) C)), [Boolean-function.00100111]
174. (<-> A (-> (-> B A) C)), [Boolean-function.10000101]
175. (<-> A (-> (<-> A B) C)), [Boolean-function.10001101]
176. (<-> A (<-> B (and A C))), [Boolean-function.00111001]
177. (<-> A (<-> B (or A C))), [Boolean-function.01100011]
178. (<-> A (<-> B (-> A C))), [Boolean-function.11001001]
179. (<-> A (<-> B (-> C A))), [Boolean-function.10010011]
180. (<-> A (<-> (and nil B) C)), [Boolean-function.01011010]
181. (<-> (and nil A) (and B C)), [Boolean-function.11101110]
182. (<-> (and nil A) (or B C)), [Boolean-function.10001000]
183. (<-> (and nil A) (-> B C)), [Boolean-function.00100010]
184. (<-> (and nil A) (<-> B C)), [Boolean-function.01100110]
185. (<-> (and A B) (and B C)), [Boolean-function.11101101]
186. (<-> (and A B) (or B C)), [Boolean-function.10001011]
187. (<-> (and nil (and A B)) C), [Boolean-function.10101010]
188. (<-> (and A (and B C)) B), [Boolean-function.11001101]
189. (<-> (and A (or B C)) B), [Boolean-function.11001011]
190. (<-> (or (<-> A B) C) B), [Boolean-function.00011011]
191. (<-> (-> A (and B C)) C), [Boolean-function.01011011]


-------------------------------------
Symbols as Sexprs and Hygienic Fexprs
-------------------------------------
http://kazimirmajorinc.blogspot.com/2009/12/symbols-as-sexprs.html

; During last year of use of Newlisp I changed my opinion about
; one important thing: encoding information in symbols.

; Initially, I thought it is mistake, or attempt for escape from
; dry, but essential Lisp syntax, known in most of Lisp languages.
; See, for example, apostrophe - or even worse, "loop" in some
; dialects. I criticized my Newlisp coleague Cyril Slobin
; who did it once.

; However, soon I concluded that there is no good alternative for
; encoding of information in symbols. For example, in one of the
; first posts here, I tried to define operators similar to +=,
; -=, *= etc in C. If you didn't used these operators, x+=1 is
; same thing as x=x+1; x*=2 is same as x=x*2.
;
; What does it mean, encoding information in symbols? Take a look
; on C operators
;
;                          +=, -=, *=,
;
;
; again. The names of these operators are not *just names*, but also
; descriptions of the operators. The programmer who learns C probably
; mentally parse these names while programming for some time, until he
; automatizes use of the operators.
;
; If these operators are defined in Newlisp program, then the
; names must be defined by program as well. And what should be the
; names of the operators defined with
;
;          (operator1 x y) <=> (setq x (+ x y))
;          (operator2 x y) <=> (setq x (- x y))
;          ...?
;
; From my point of view, natural choice of the names could be
; setq+ and setq-.
;
; Another example of generated symbol names I used is in post
; in which I defined functions for prevention of accidental name
; clashes. If function f is, for example, defined with
;
;                  (set 'f (lambda(x)(x y)))
;
; then (protect1 'f '(x y)) replaced definition of f with
;
;                    (lambda(f.x)(f.x f.y))
;
; and later, I replaced it with
;
;                  (lambda([f.x])([f.x] [f.y]))
;
; How bracket get into combination? Because, I have find that
; I might need to distinguish names like
;
;                    f.[x.1] and [f.x].1
;
; At this point, my variable names started to look increasingly
; like s-expression, so I assumed that it might be useful to
; assume that our usual one-word symbols as just special cases
; of symbols in the form of s-expressions.
;
; Newlisp allow us to use "ilegal" symbol names, so theoretically,
; I can use symbols of the form (f x) - with blanks and parenthesis
; as characters - but such symbols cannot be printed out and readed
; again. So, symbols - sexprs must use different forms of parentheses
; and delimiters.

; Unfortunately, dot is not good choice for delimiter, because dot
; can be part of the number, so [f.1.3] is ambigious - is it (f 1.3),
; or (f 1 3)?
;
; Also, square and curly brackets have special meanings in Newlisp
; syntax, so more exotic choices are necessary.

; In following part of the code, I'll show how I defined symbols in
; the form of s-expression and how these are used to redefine functions
; protect1 (fast - and protecting from practically all kinds of accidental
; variable clashes) and protect2 (slow - protecting from accidental
; variable name clashes in some rare, in Newlisp practice unknown.
; but still possible cases.)
; Details are described in my previous posts in series
;
; "Don't fear dynamic scope."
;
; "Don't fear dynamic scope (2)."

;---------------------------------------------------------------
; First, we'll define equivalents in one, centralized place

(set 'left-parenthesis-equivalent ".<.")
(set 'right-parenthesis-equivalent ".>.")
(set 'blank-equivalent "___")
(set 'apostrophe-equivalent "`")
(set 'quotation-mark-equivalent "~")

;---------------------------------------------------------------
; Next, we'll define two pairs of functions for conversion from
; s-expression to string and vice versa.

(set 'symbol-to-sexpr
     (lambda(S)
       (setq S (string S))
       (setq S (replace left-parenthesis-equivalent S "("))
       (setq S (replace right-parenthesis-equivalent S ")"))
       (setq S (replace blank-equivalent S " "))
       (setq S (replace apostrophe-equivalent S "'"))
       (setq S (replace quotation-mark-equivalent "\""))
       (eval-string (append "'" S))))

(set 'sexpr-from-symbol symbol-to-sexpr)

(set 'sexpr-to-symbol
     (lambda(L)
       (setq L (string L))
       (setq L (replace "(" L left-parenthesis-equivalent))
       (setq L (replace ")" L right-parenthesis-equivalent))
       (setq L (replace " " L blank-equivalent))
       (setq L (replace "'" L apostrophe-equivalent ))
       (setq L (replace "\"" L quotation-mark-equivalent ))
       (sym L)))

(set 'symbol-from-sexpr sexpr-to-symbol)

; Let us see on example, how these functions work:

(println (symbol-from-sexpr '(* (+ x y) (- x y))))

;
;           .<.*___.<.+___x___y.>.___.<.-___x___y.>..>.
;
; Pretty much like normal s-expression, while < and > pretend to be
; parenthesis, and exotic dots pretend to be blank characters.
;
;---------------------------------------------------------------
; Now, I'll define "protected version" of function set:
;
;   * (set-protected1 function/macro-name original-code variables)

(set 'set-protected1
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (eval (list 'letex
                  (map (lambda(x)
                         (list x
                               (list 'quote
                                     (symbol-from-sexpr
                                        (list function/macro-name
                                              x)))))
                        variables)
                  definition-code)))))

;---------------------------------------------------------------
; Example:

(set-protected1 'f (lambda(x y z)(x y z)) '(x z))

(println f) ;=> (lambda (.<.f___x.>. y .<.f___z.>.)
            ;              (.<.f___x.>. y .<.f___z.>.))

;---------------------------------------------------------------
; Similarly, the version protect1 that protects the functions
; that already exist:

(set 'protect1 (lambda(function/macro-name variables)
                  (set-protected1 function/macro-name
                                (eval function/macro-name)
                                variables)))

;---------------------------------------------------------------
; In next step, I'll use set-protected1 and protect1 to define -
; protected versions of set-protected1 and protect1.

((copy set-protected1) 'set-protected1
                        set-protected1
                        '(function/macro-name definition-code
                                              variables
                                              x))

((copy protect1) 'protect1 '(function/macro-name variables))

;---------------------------------------------------------------
; In following step, I'll define set-protect2 and protect2. These
; two functions should be able to protect functions even from the
; most demanding funarg problems. Details are explained in "Don't
; fear dynamic scope." articles, links are above.

(set 'set-protected2
  (lambda(function/macro-name definition-code variables)
    (set function/macro-name
      (expand (lambda-macro()
                (let((name-and-counter
                        (symbol-from-sexpr (list 'function/macro-name
                                                 (inc counter)))))

                    (set-protected1 name-and-counter
                                    definition-code
                                    'variables)

                    (first (list (eval (cons name-and-counter
                                             $args))
                                 (dolist(i 'variables)
                                    (delete (symbol-from-sexpr
                                              (list name-and-counter
                                                    i))))
                                 (delete name-and-counter)))))

               'function/macro-name 'definition-code 'variables))))

; set-protected2 is the most important function in this post.
; In this version it is more than twice shorter and, I hope,
; simpler than in last version.

;---------------------------------------------------------------
; Example of set-protected2

(set-protected2 'f (lambda(x y z)(x y z)) '(x z))
(println f)

; (lambda-macro ()
;  (let ((name-and-counter (symbol-from-sexpr (list 'f (inc counter)))))
;   (set-protected1 name-and-counter (lambda (x y z) (x y z)) '(x z))
;   (first (list (apply name-and-counter $args)
;     (dolist (i '(x z))
;      (delete (symbol-from-sexpr (list name-and-counter i))))
;     (delete name-and-counter)))))

;---------------------------------------------------------------
; Similarly, the version protect2 that protects the functions
; and macros that already exist:

(set 'protect2
     (lambda(function/macro-name variables)
        (set-protected2 function/macro-name
                        (eval function/macro-name)
                        variables)))

;---------------------------------------------------------------
; In next step, I'll use protect1 to define -
; protected versions of set-protected2 and protect2.

(protect1 'set-protected2 '(function/macro-name definition-code
                            variables counter name-and-counter i))

(protect1 'protect2 '(function/macro-name variables))

;---------------------------------------------------------------
; Finally, hard example of funarg problem: recursive fexpr hard-example
; call itself, passing the function encapsulating one free variable
; from one instance of the hard-example to another. We'll see whether
; protect2 will protect it.
;
; If (hard-example (lambda(x)x)) returns 1 2 3 1 2 3 then free variable
; is overshadowed with same variable in other instance.
;
; If (hard-example (lambda(x)x)) returns 1 1 1 1 2 3 then it is not
; overshadowed.

(define-macro (hard-example f)
      (for(i 1 3)
         (unless done          ; avoiding infinite
             (set 'done true)  ; recursion
             (hard-example (lambda(x)i)))
                               ; One recursive call with function
                               ; (lambda(x)i)

         (println i " =>" (f i)))) ; which i will be printed?
                                   ; i=1 2 3 means inner is overriden

;---------------------------------------------------------------
; First, without protection:

(set 'done nil)
(hard-example (lambda(x)x))

; 1 =>1
; 2 =>2
; 3 =>3
; 1 =>1
; 2 =>2
; 3 =>3

; Overshadowing happened.

;---------------------------------------------------------------
; Then, after protection:

(set 'done nil)
(protect2 'hard-example '(f i x))
(hard-example (lambda(x)x))

; 1 =>1
; 2 =>1
; 3 =>1
; 1 =>1
; 2 =>2
; 3 =>3

; Overshadowing prevented.

;---------------------------------------------------------------
; Finally, we'll take a look whether all variables intended to
; be temporary, like .<.hard-example___1.>. etc. are deleted.

(dolist(i (symbols))
  (if (starts-with (string i) left-parenthesis-equivalent)
      (println i)))

; .<.*___.<.+___x___y.>.___.<.-___x___y.>..>.
; .<.f___x.>.
; .<.f___z.>.
; .<.protect1___function/macro-name.>.
; .<.protect1___variables.>.
; .<.protect2___function/macro-name.>.
; .<.protect2___variables.>.
; .<.set-protected1___definition-code.>.
; .<.set-protected1___function/macro-name.>.
; .<.set-protected1___variables.>.
; .<.set-protected1___x.>.
; .<.set-protected2___counter.>.
; .<.set-protected2___definition-code.>.
; .<.set-protected2___function/macro-name.>.
; .<.set-protected2___i.>.
; .<.set-protected2___name-and-counter.>.
; .<.set-protected2___variables.>.
;
; Yes, they are deleted.
;
; Another test, this one taken from recent John Shutt's disertation
; on Kernel programming language.

(define y 3)
(set 'f (lambda (x) (+ x y)))
(set 'g (lambda (y) (+ 1 (f y))))
(println (g 5))                     ;=> 11

; This code in lexically scoped Lisp evaluates to 9. In dynamically
; scoped Lisp it evaluates to 11. If you are surprised with 11,
; that means you didn't recognized that y from definition of g will
; overshadow top level y during evaluation of (f y). But - it will.
; If you want to use different objects, you have to use different
; names; and, if it is boring to invent new names for bounded variables,
; set-protected (both versions) will do that for you:

(define y 3)
(set-protected2 'f (lambda (x) (+ x y)) '(x))
(set-protected2 'g (lambda (y) (+ 1 (f y))) '(y))
(println (g 5))     ;=> 9

(exit)

; In further posts, I'll explore that idea of symbols as sexprs
; deeper.

Commenti:
---------
cormullion14 December 2009 at 23:45
I see what you were asking about brackets for now! amazing stuff...
cormullion

*** Kazimir Majorinc 15 December 2009 at 08:00
Thanx cormullion. On the way of development, I also accidentally ruined println.supressed - when I replaced it with [println.supressed].

But I experimented for some time until I discovered that these characters: ¨ and ˙ are relatively readable and relatively well supported by all kinds of consolas, web browsers, text editors, and they are unlikely to occur accidentally in programs.


---------------------------
Alan Kay on Lisp and Fexprs
---------------------------
http://kazimirmajorinc.blogspot.com/2010/02/alan-kay-on-fexprs.html

Alan Kay is designer of Smalltalk. This citation is known, but not as well as it should be, and I think it deserves attention separately of many posts I wrote on fexprs.

  "I could hardly believe how beautiful and wonderful the idea of LISP was. I say it this way because LISP had not only been around enough to get some honest barnacles, but worse, there were deep flaws in its logical foundations. By this, I mean that the pure language was supposed to be based on functions, but its most important components -- such as lambda expressions, quotes, and conds -- were not functions at all, and instead were called special forms. Landin and others had been able to get quotes and cons in terms of lambda by tricks that were variously clever and useful, but the flaw remained in the jewel. In the practical language things were better. There were not just EXPRs (which evaluated their arguments), but FEXPRs (which did not). My next questions was, why on Earth call it a functional language? Why not just base everything on FEXPRs and force evaluation on the receiving side when needed?

I could never get a good answer, but the question was very helpful when it came time to invent Smalltalk, because this started a line of thought that said 'take the hardest and most profound thing you need to do, make it great, an then build every easier thing out of it.'"

Alan Kay,
The Early History of Smalltalk.,
in: Bergin, Jr., T.J., and R.G. Gibson.
History of Programming Languages - II,
ACM Press, New York NY, and
Addison-Wesley Publ. Co., Reading MA 1996,
pp. 511-578


----------------------------------
Composition of Functions or Macros
----------------------------------
http://kazimirmajorinc.blogspot.com/2010/02/composition-of-functions-or-macros.html

; The composition of the functions is one of the basic mathematical
; operations. In this post, I'll try to define composition of
; functions and macros (Newlisp macros=fexprs) in Newlisp.
;
; Such composition should satisfy the following:
;
;     ((composition 'f1 ... 'fn) _ _ _) = (f1 (f2 ... (fn _ _ _)))
;
; for all functions and macros.
;
; It wasn't that easy as I thought. First, I limited myself on the
; case of the composition of two functions. After some experimentation
; I came to that:

(set 'compose2 (lambda(f g)
                 (expand (lambda-macro()(letex((L (cons 'g (args))))(f L)))
                          'f 'g)))

; I tested it on simple example:

(println (compose2 'sin 'cos))

; (lambda-macro ()
;  (letex ((L (cons 'cos (args)))) (sin L)))

(println ((compose2 'sin 'cos) 3) (sin (cos 3))) ; OK, it works.

; Then I tested it on two special, well, entities, i.e. identity
; function and identity macro:

(set 'I (lambda(x)x))
(set 'IM (lambda-macro(x)x))

(println ((compose2 'I 'sin) 3)) ; 0.1411200081, as it should be, i.e. (I (sin 3))
(println ((compose2 'sin 'I) 3)) ; 0.1411200081, as it should be, i.e. (sin (I 3))
(println ((compose2 'IM 'sin) 3)) ; (sin 3), as it should be, i.e. (IM (sin 3))
(println ((compose2 'sin 'IM) 3)) ; 0.1411200081, as it should be (sin (IM 3))

; OK; it appears it worked. Now I'll have to solve multi-version,
; I.e. composition of many functions or macros

(set 'compose (lambda()
                 (case (length (args))
                    (0 I)               ; because (I (S x)) <=> (S x),
                                        ; no matter if S is function or macro
                                        ; so I can be always added from the left.
                    (1 (first (args)))
                    (2 (apply compose2 (args)))
                    (true (compose2 (first (args)) (apply compose (rest (args))))))))

(println ((compose sqrt) 65536)) ; 256
(println ((compose sqrt sqrt) 65536)) ; 16
(println ((compose sqrt sqrt sqrt) 65536)) ; 4

; OK, it works as well. However, result of the composing is
; rather complicated because of recursive definition

(println (compose 'f1 'f2 'f3 'f4))

; (lambda-macro ()
;   (letex ((L (cons '(lambda-macro ()(letex ((L (cons '(lambda-macro ()(letex ((L (cons 'f4 (args))))
;                                                                              (f3 L)))
;                                                      (args))))
;                                             (f2 L)))
;                    (args))))
;         (f1 L)))
;
;
; If iteration is used for definition of compose, then composition
; can be both shorter and faster - but not more elegant.


---------------------------------------------------
Composing Fexprs Preserves Short-circuit Evaluation
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/02/composing-fexprs-preserves-short.html

; One of the well known advantages of special operators over
; functions is that special operators apply "short-cuirciting".
;
; For example, operator "and" that evaluates
;
;  (and (= 1 1) (= 2 2) (= 3 4) (= 5 (slow-function 6)))
;
; will never evaluate clause (= 5 (slow-function 6)). Instead,
; after (= 3 4) is recognized to be false, there is no theoretical
; possibility that whole expression evaluates to true, and
; nil is returned without evaluating other clauses.
;
; This is significant difference between operators and functions.
; If "and" was defined as function, all clauses would be evaluated
; first, and then passed to the operator "and."
;
; Only today I came to idea to test whether operator compose I
; defined few days ago, which can be applied on fexprs as well as
; on functions, preserves short-circuiting.
;
; I'll test it by defining two well known logical operators,
; nor and nand.

(set 'nor (compose not or))
(set 'nand (compose not and))

; Let us test whether 'nor' and 'nand' preserve short-circuit
; evaluation.

(nand (println "this should be done ")
      (println "and this should be done")
      (println (setf j nil))
      (println "but this shouldn't be done"))

; this should be done
; and this should be done
; nil
;

(println "---")

(nor (println (= 1 2))
     (println (= 1 3))
     (println "and something different")
     (println "this shouldn't be done"))

; ---
; nil
; nil
; and something different

; Everything works. Beautiful, isn't it?

(exit)

Commenti:
--------
*** Wolverrum 24 February 2010 at 01:54
>Beautiful compose() is a good enough approach to make code shorter, I like it :)

*** Kazimir Majorinc 24 February 2010 at 03:27
Actually, it is not that bad weather if one sits in the bar, drink tea and rum, and watch the world through windows. I have another similar function, it is "increase-order". On that way I can increase order of functions, so these can apply on other functions. For example, I can define +f

(setf +f (increase-order +))

and +f will add functions, not numbers.

((+f sin cos) x) ==> (+ (sin x) (cos x))

It was one of my first posts, so maybe it doesn't work any more - Newlisp changed, but version in my library works.

*** Wolverrum 27 February 2010 at 12:24
Blogger Wolverrum said...

As I understanding increasOrder properly it has type:
increaseOrder :: (b->c) -> ((a->b) -> (a->c))

At least above I was able to create using C#2 :)

FuncX<FuncX<A, B>, FuncX<A, C>> Up< B, C>(FuncX<B, C> fn)
{return delegate(FuncX<A, B> h) {
return Compose(h, fn); }; }

*** Kazimir Majorinc 28 February 2010 at 02:29
Hey, its pretty elegant solution.


------------------------------
How Many Syllogisms are There?
------------------------------
http://kazimirmajorinc.blogspot.com/2010/03/how-many-syllogisms-are-there.html

1. Introduction

Asyllogism or logical appeal is a kind of logical argument, developed by Aristotle, in which one proposition (the conclusion) is inferred from two others (the premises) of a certain form. The simplest and the most popular syllogisms are categorical syllogisms, like this one:

Some cats have no tails.  (premise)
All cats are mammals. (premise)
Some mammals have no tails.     (conclusion)
Both premises and conclusions of the syllogism are called propositions. There are four "types"of propositions:

All S are P (universal affirmative)
Some S are P  (particular affirmative)
Some S aren't P     (particular negative)
No S are P  (universal negative)
Some syllogisms are valid, like one with cats and mammals. That means, as long as form is preserved, no matter of terms used instead of cats, tails and mammals - if premises are true, then conclusion is also true. Not all syllogisms are valid. Discovering and describing all valid syllogisms is challenging logical problem and it seems it was the main activity of the logicians in period of more than two thousands years, until Göttlib Frege discovered predicate logic in late 19th century.

Surprisingly, it appears that there is no consensus about how many valid syllogisms exist. Some sources on Internet claim that there are 19 of them, others claim from 14 to 24. Newlisp program for construction and testing of syllogisms, i.e. discovering all valid syllogisms is described. The results of its work are given.

2. The Program

The program might look like

(dolist (p1 all-possible-1st-premises)
  (dolist (p2 all-possible-2nd-premises)
    (dolist (c all-possible-conclusions)
      (check-validity-of-syllogism p1 p2 c))))
where all these parts are, unfortunately, nontrivial. Let us assume that we know how loops can be organized. How can program know that syllogism is valid? For instance, this is how schematically written silogism about cats and tails and mamals might look alike:

Some cats have no tails.  (premise)       ==>  Some-arent M P
All cats are mammals.     (premise)       ==>  All-are M S
Some mammals have no tails. (conclusion)  ==>  Some-arent S P

where M = cats, P = creatures with tails and S = mammals.

Humans easily understand that syllogism is valid. The algorithm that allows program to recognize the validity is simple but not trivial: it analyzes all possible worlds. If in all possible worlds, each time both premises of syllogism are true then conclusion is also true - we'll say that syllogism is valid. The phrase "all possible worlds" sounds scary; However, if irelevant details are omitted, it turns that there are not that many essentially different worlds.

More precisely, theworlds are completey determined with relations between terms S, M and P. In some possible worlds all cats have tails; in other possible worlds only some cats have tails, and others have not. In some worlds, no cats have tails at all. In some worlds, only cats and noone else have tails. In some worlds, cats are not only beings with tails. In some worlds all beings have tails, except cats.

For our purpose, two possible worlds differ if there is some combination of S or (not S), M and (not M), P and (not P), such that in one world there are the beings that satisfy particular combination, and in other world there are no such beings.

Every world can be depicted with Venn's diagram like a following one.

Fig. 1. Venn's diagram of one Aristotle's world
Nota: vedi immagine "venn-aristotele.png" nella cartella "data".

This particular diagram represents the world in which there are beings that satisfy S and (not M) and (not P), and there are the beings that satisfy (not S) and (not M) and P but there are no beings that satisfy any other combination of S or (not S), M and (not M), P and (not P).

We can start defining the list of all possible worlds. Let us note that all areas in the Venn's diagram are denoted with sublists of letters from list (S M P). We can even say that large area out of S, M and P is denoted - with empty list, where empty list is also sublist of (S M P). Let us first define the function sublist, that accept list as argument, and returns list of all sublists of taht list.

(set 'sublists
   (lambda(L)
     (if (= (length L) 0) '(())
         (let ((s (sublists (chop L))))
              (append s
                      (map (lambda(x)(append x (list (last L))))
                           s))))))

For those who use some other Lisps, last and chop in Newlisp are in the same relation as first and rest. Let us define the list Areas that contains all sublists of (S M P), i.e. (() (S) (M) (S M) (P) (S P) (M P) (S M P)).

(set 'Areas (sublists '(S M P)))

Each possible world is determined by existance of being  in these areas. For our purpose, two worlds are equivalent if and only if they have elements in exactly same areas. Hence, we can say that single world is completely determined by sublist of the areas, containing only areas with some elements in.

For instance, the world depicted with Venns diagram above is completely described with ((S) (P)). There are beings that satisfy the property S (but nothing else) and there are also beings that satisfy P, but nothing else. Let us define the list of all possible worlds:

(set 'Worlds (sublists Areas))

Total, there are 256 worlds. In the next step, the number of the considered worlds is reduced. In Aristotle's logic - just like in everyday speech, empty terms are ignored. If someone says that all yetis are tall - one will say that there are no yetis, and he'll avoid any direct answer "it is true" or "it is false." That's why, for example, in Aristotle's logic,

All S are P implies Some S are P.

In some areas of reasoning, particularly mathematics, it is not assumed that terms are non-empty. For instance, the world ((S)) is not Aristotle's world, because neither one area in the world ((S)) contains P or M. On the other side, (() (S M) (P)) is Aristotle's world.

(set 'Aristotles-worlds
     (filter (lambda(x)(= (length (unique (flat x))) 3))
             Worlds))

There are 218 elements in Aristotles-worlds. In the next step, the function true-in-world will be defined. When we say something like "there is only one truth", we can say it because we think on only one world - our phisical world. If we consider more than one world, or even all possible worlds, we must speak about truth in particular world.

The function true-in-world accepts proposition (defined with pair of quantifier and copula (like all-are, some-are etc.) two terms) and one world, and returns true if proposition is true in that world, and nil otherwise.

For instance, we want that (true-in-world all-are 'S 'P '((S P) (P))) returns true, because for each "area" in ((S P) (P)) if S is in area, then P is in area as well.

(set 'true-in-world
   (lambda(qc term1 term2 w) ; qc = quantifier and copula
      (not
         (not
            (case qc
                  (all-are
                     (for-all (lambda (area)
                                      (if (find term1 area)
                                          (find term2 area)
                                          true))
                              w))
                  (some-are
                     (exists (lambda (area)
                                     (and (find term1 area)
                                          (find term2 area)))
                             w))
                  (some-arent
                     (exists (lambda (area)
                                     (and (find term1 area)
                                          (not (find term2
                                                     area))))
                             w))
                  (no-are
                     (for-all (lambda (area)
                                      (if (find term1 area)
                                          (not (find term2
                                                     area))
                                          true))
                              w)))))))

The function proposition-to-string is only to format the output to be more readable.

(define (proposition-to-string qc t1 t2)
  (letn((sqc (string qc))
        (fsqc (find "-" sqc)))
     (append (slice sqc 0 fsqc) " " (string t1) " "
             (slice sqc (+ fsqc 1) (- (length sqc) fsqc 1))
             " " (string t2))))

The loops should be organized for testing all possible syllogisms. Traditionally, syllogisms are systematized in Figures.

                  FIGURE 1    FIGURE 2    FIGURE 3    FIGURE 4
Premise major     - M - P     - P - M     - M - P     - P - M
Premise minor     - S - M     - S - M     - M - S     - M - S
                  ---------   --------    --------    ---------
                  - S - P     - S - P     - S - P     - S - P

Conclusion

Each figure determines subject and predicate in both premises. In all conclusions, subject is S and predicate is P. Theoretically, the figures like

FIGURE 1A

- M - P
- S - M
---------
- P - S

could be considered, but, if symbols S and P are replaced, the resulting figure

- M - S
- P - M
--------
- S - P

is the same as Figure 4, with one irrelevant change - replaced order of propositions.

(for (figure 1 4)
   (if (or (= figure 1) (= figure 3)) (set 'major1 'M 'major2 'P)
                                      (set 'major1 'P 'major2 'M))
   (if (or (= figure 1) (= figure 2)) (set 'minor1 'S 'minor2 'M)
                                      (set 'minor1 'M 'minor2 'S))

   (println "\n\nFigure " figure ": ")
   (println "=========")
   (println "Premise major: " major1 " - " major2)
   (println "Premise minor: " minor1 " - " minor2)
   (println "Conclusion:    S - P")

   (dolist (major-qc '(all-are some-are some-arent no-are))
      (dolist (minor-qc '(all-are some-are some-arent no-are))

        (set 'worlds-satisfying-both-premises
              (filter (lambda(m)(and (true-in-world major-qc
                                                    major1
                                                    major2
                                                    m)
                                     (true-in-world minor-qc
                                                    minor1
                                                    minor2
                                                    m)))
                       Aristotles-worlds))

        (dolist (conclusion-qc '(all-are some-are some-arent no-are))

           (when (for-all (lambda(m)
                             (true-in-world conclusion-qc 'S 'P m))
                          worlds-satisfying-both-premises)

              (println "\n----- " (inc syllogism) ". syllogism:\n")
              (println "  Premise major: "
                       (proposition-to-string major-qc major1 major2))
              (println "  Premise minor: "
                       (proposition-to-string minor-qc minor1 minor2))
              (println "  Conclusion:    "
                       (proposition-to-string conclusion-qc 'S 'P)
                       " ("
                       (length worlds-satisfying-both-premises)
                       " worlds.)"))))))

(exit)

3. The Results

The output of the program is the list of all valid syllogisms.

Figure 1:
=========
Premise major: M - P
Premise minor: S - M
Conclusion:    S - P

----- 1. syllogism:

  Premise major: all M are P
  Premise minor: all S are M
  Conclusion:    all S are P (8 worlds.)

----- 2. syllogism:

  Premise major: all M are P
  Premise minor: all S are M
  Conclusion:    some S are P (8 worlds.)

----- 3. syllogism:

  Premise major: all M are P
  Premise minor: some S are M
  Conclusion:    some S are P (32 worlds.)

----- 4. syllogism:

  Premise major: no M are P
  Premise minor: all S are M
  Conclusion:    some S arent P (4 worlds.)

----- 5. syllogism:

  Premise major: no M are P
  Premise minor: all S are M
  Conclusion:    no S are P (4 worlds.)

----- 6. syllogism:

  Premise major: no M are P
  Premise minor: some S are M
  Conclusion:    some S arent P (24 worlds.)

Figure 2:
=========
Premise major: P - M
Premise minor: S - M
Conclusion:    S - P

----- 7. syllogism:

  Premise major: all P are M
  Premise minor: some S arent M
  Conclusion:    some S arent P (24 worlds.)

----- 8. syllogism:

  Premise major: all P are M
  Premise minor: no S are M
  Conclusion:    some S arent P (4 worlds.)

----- 9. syllogism:

  Premise major: all P are M
  Premise minor: no S are M
  Conclusion:    no S are P (4 worlds.)

----- 10. syllogism:

  Premise major: no P are M
  Premise minor: all S are M
  Conclusion:    some S arent P (4 worlds.)

----- 11. syllogism:

  Premise major: no P are M
  Premise minor: all S are M
  Conclusion:    no S are P (4 worlds.)

----- 12. syllogism:

  Premise major: no P are M
  Premise minor: some S are M
  Conclusion:    some S arent P (24 worlds.)

Figure 3:
=========
Premise major: M - P
Premise minor: M - S
Conclusion:    S - P

----- 13. syllogism:

  Premise major: all M are P
  Premise minor: all M are S
  Conclusion:    some S are P (16 worlds.)

----- 14. syllogism:

  Premise major: all M are P
  Premise minor: some M are S
  Conclusion:    some S are P (32 worlds.)

----- 15. syllogism:

  Premise major: some M are P
  Premise minor: all M are S
  Conclusion:    some S are P (32 worlds.)

----- 16. syllogism:

  Premise major: some M arent P
  Premise minor: all M are S
  Conclusion:    some S arent P (28 worlds.)

----- 17. syllogism:

  Premise major: no M are P
  Premise minor: all M are S
  Conclusion:    some S arent P (12 worlds.)

----- 18. syllogism:

  Premise major: no M are P
  Premise minor: some M are S
  Conclusion:    some S arent P (24 worlds.)

Figure 4:
=========
Premise major: P - M
Premise minor: M - S
Conclusion:    S - P

----- 19. syllogism:

  Premise major: all P are M
  Premise minor: all M are S
  Conclusion:    some S are P (8 worlds.)

----- 20. syllogism:

  Premise major: all P are M
  Premise minor: no M are S
  Conclusion:    some S arent P (4 worlds.)

----- 21. syllogism:

  Premise major: all P are M
  Premise minor: no M are S
  Conclusion:    no S are P (4 worlds.)

----- 22. syllogism:

  Premise major: some P are M
  Premise minor: all M are S
  Conclusion:    some S are P (32 worlds.)

----- 23. syllogism:

  Premise major: no P are M
  Premise minor: all M are S
  Conclusion:    some S arent P (12 worlds.)

----- 24. syllogism:

  Premise major: no P are M
  Premise minor: some M are S
  Conclusion:    some S arent P (24 worlds.)


-----------------------------------------------------------
The program for derivation of syllogisms, condensed version
-----------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/03/how-many-syllogisms-are-there-condensed.html

; "Factoring out" is a sword with two blades. Typical result of the
; factoring out is that code is shorter, more concise, approaching
; the essence of the problem, but in the same time, much harder
; to understand. Here is my last program for derivation of syllogisms,
; in condensed version.

(load "http://www.instprog.com/Instprog.default-library.lsp")
(dolist (fig1 '((S M)(M S)))
  (dolist (fig2 '((M P)(P M)))
    (dolist-multi((majqc minqc conqc)(map first (setf qc '((all-are '(for-all if begin))
                                                           (some-are '(exists and begin))
                                                           (some-arent '(exists and not))
                                                           (no-are '(for-all if not))))))
      (when (for-all (fn(m (truew (fn(p)((eval ((setf d (eval (append '(case (p 0)) qc))) 0))
                                         (fn(a)(eval (list (d 1)
                                                           (find (p 1) a)
                                                           (list (d 2) (find (p 2) a))
                                                           true)))
                                         m))))(if (and (= (length (unique (flat m))) 3)
                                                       (truew (setf major (cons majqc fig2)))
                                                       (truew (setf minor (cons minqc fig1))))
                                                  (truew (setf concl (cons conqc '(S P))))
                                                  true))
                    (sublists (sublists '(S M P))))
        (println= "\n" (++ syllogism) "\n\n  " major "\n  " minor "\n  " concl)))))

; For better explained, longer code and results, see here: How many syllogisms are there?


------------------------------------------
McCarthy - Dijkstra short polemics in 1976
------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/04/mccarthy-dijkstra-short-polemics-in.html

To Professor John McCarthy

Dear Colleague,

thank you for your amazing letter of August 18, 1976. But you really don't need to be sorry for me because the output of your xerographic printer hurts my eye. (For after all, all of us need our daily dose of irritation: I satisfy my needs in this respect by exposure to audible wallpaper, xerographic computer output and similar would-be services to the consumer.)

I am puzzled by your ban on my use of the verb "to degrade": I thought I had used it correctly, in the sense of "to impair the quality of". But let me propose a deal: you allow me to dislike your poor xerographic printer output (and to say so), and I promise not to mind if you call me a snob.

As far as the mechanics of manuscript production are concerned, I can warmly recommend to all prospective authors to train themselves to get their texts nearly right the first time: it is a fast, efficient, and cheap way of working that almost always gives great esthetic and intellectual satisfaction.

And finally: if you have the text of your recent letter still in your computer files, you could do me three favours: inserting the missing "W." in the first line of the address, and correcting the spelling errors in the next two lines of the address.

As EWD581 - 1 your letter will get the same distribution as EWD574, my letter to Zohar.

Greetings and best wishes!
Yours ever,
Edsger W. Dijkstra
Dear Professor Dijkstra:

Zohar Manna showed me your letter of 26 July. I am sorry you "vehemently abhor" computer produced manuscripts in different type fonts. I wish our xerographic printer had higher resolution and didn't make smudges when it hasn't recently been adjusted; we do the best we can. You are entitled to your tastes, but when you claim that people with different tastes are using computers to "degrade our lives", you are contributing to an atmosphere of snobbery that has done much to degrade discussion of programming style. Consider this also a protest against the language used in your campaign against gotos. (Sorry our boldface isn't bolder).

As the inventor of one of the first languages (LISP) that allowed programming without gotos, I nevertheless consider that they have their uses. However, my main objection is to the character of the campaign you launched against them, which seemed to be based on an appeal to snobbery and seemed to encourage more snobbery.

As you see, justified right margins are optional in computer produced documents. Many people share your preference for unjustified lines, but it is wrong to make a moral issue of it. As a matter of taste, I find the backwards words fi and od unpleasing and would prefer parentheses or begins and ends for resolving ambiguities.

I am glad you like the content of Manna's and Waldinger's report. Manna would be an excellent expositor even if his reports had to be incised in clay tablets and baked, but the polished style and the prompt appearance may owe something to the opportunity for frequent revision afforded by computer produced documents. Certainly, this was one of our main reasons for pioneering them at this laboratory. Moreover, we cannot afford the secretarial time required to make several versions of a typescript.

If you felt like distributing this protest to your EWD list, I would be grateful.

Sincerely,
John McCarthy
transcribed by Carl Ludwigson
revised Sun, 9 Sep 2007

Edsger W. Dijkstra, A somewhat open letter to Professor John McCarthy, 1976, EWD551.

Commenti:
---------
*** Robert Giles 28 April 2010 at 05:20
It's very fascinating to me, as a fan of typography & programming, to see two geniuses sperging out over fonts. I think typography is underrated in importance by most people.

*** Unknown 1 March 2011 at 12:41
I tend to agree with McCarthy in just about everything he says in the letter.

I'd really like to know what Dijkstra seems to think is wrong with right justification, thought. Maybe he has a point, but I'm inclined not to think so.

On the post you mentioned at the beginning of this article, he clearly does not understand Lisp nor does he devote much effort in doing so, although he goes on to despise the language based on a single poor written language manual. Had he tried to see beyond the thin layer of Lisp's "atrocious syntax", as he calls it, I believe he would've been able to appreciate the giant leap forward that was Lisp in comparison to what was in use to that day (and actually much of what we still have today).


------------------------------------------
Interesting Case of Mismatched Parentheses
------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/05/interesting-case-of-mismatched.html

  * Programming language: Lisp. One of the most important programming
    languages, and probably the most important if we discuss parentheses.

  * Author: John McCarthy, the creator of Lisp.

  * Article: Recursive Functions of Symbolic Expressions, Communications
    of the ACM, April 1960, probably the most important article on Lisp.

  * Place: definition of arguably the most important function ever: eval.

The holiest place for programmers not afraid of parentheses!

Yet, parentheses do not match there.

This is not typical Lisp S-expression, it is so called "meta expression".

Here is original version of the article:

Fig.1 par-error01.png (nella cartella "data")

And here is the same mismatch in the version retyped using Latex.

Fig.2 par-error02.png (nella cartella "data")

I'll not say where is the error. I'll leave you to play
with that. Here is the text, so you can copy and paste it in
your editor. The simplest way to check my claim that there is
an error is that your editor counts left and right brackets.
Notepad++ says there are 68 left and 66 right brackets here.

eval[e; a] = [
atom [e] -> assoc [e; a];
atom [car [e]] -> [
eq [car [e]; QUOTE] -> cadr [e];
eq [car [e]; ATOM] -> atom [eval [cadr [e]; a]];
eq [car [e]; EQ] -> [eval [cadr [e]; a] = eval [caddr [e]; a]];
eq [car [e]; COND] -> evcon [cdr [e]; a];
eq [car [e]; CAR] -> car [eval [cadr [e]; a]];
eq [car [e]; CDR] -> cdr [eval [cadr [e]; a]];
eq [car [e]; CONS] -> cons [eval [cadr [e]; a]; eval [caddr [e];
             a]]; T -> eval [cons [assoc [car [e]; a];
                                          evlis [cdr [e]; a]]; a]];
eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]];
                        cons [list [cadar [e]; car [e]; a]];
eq [caar [e]; LAMBDA] -> eval [caddar [e];
                             append [pair [cadar [e]; evlis [cdr [e]; a]; a]]]

Some puritans might insist that it is brackets mismatch and not
parentheses mismatch. Wikipedia thinks that brackets are one type
of parentheses.

Of course, I cannot say that it is one of the most important
parentheses mismatches in history of programming. It had no effect
whatsoever, as far as I know.

Herbert Stoyan wrote about this error, and it is mentioned
in Latex version of the McCarthy's article, 1995.

Similar error in Lisp I. Programmer's Manual.

It is brought to my attention that intern unofficial publication,
"LISP I. Programmer's manual" from March 1960, has different definition:

Fig.3 par-error03.png (nella cartella "data")

However, it is also likely wrong. Look at the line with
LABEL, and two occurrences of cdr[e]. With some help of Shubert
who commented this post, I believe that the it should be:

eval[e; a] =
  [
   atom [e] -> assoc [e; a];
   atom [car [e]] ->
     [
      eq [car [e]; QUOTE] -> cadr [e];
      eq [car [e]; ATOM] -> atom [eval [cadr [e]; a]];
      eq [car [e]; EQ] -> [eval [cadr [e]; a] = eval [caddr [e]; a]];
      eq [car [e]; COND] -> evcon [cdr [e]; a];
      eq [car [e]; CAR] -> car [eval [cadr [e]; a]];
      eq [car [e]; CDR] -> cdr [eval [cadr [e]; a]];
      eq [car [e]; CONS] -> cons [eval [cadr [e]; a]; eval [caddr [e]; a]];
      T -> eval [cons [assoc [car [e]; a]; evlis [cdr [e]; a]]; a]
     ];
   eq [caar [e]; LABEL] -> eval [ cons [caddar [e]; cdr [e]];
                                  cons [list [cadar [e]; car [e]]; a]
                                ];
   eq [caar [e]; LAMBDA] -> eval [caddar [e];
                                  append [pair [cadar [e];
                                                evlis [cdr [e]; a]
                                               ];
                                          a
                                         ]
                                 ]
  ]

Similar error in Memo 8.

It is very interesting that error existed also in the third document,
memo of AI project on MIT, 1959, which contains different definition of eval:

Fig.4 par-error04.png (nella cartella "data")

For tried and tested EVAL see my post McCarthy's Lisp in Newlisp.

Commenti:
--------
*** G Shubert 10 May 2010 at 18:50
An editor which shows matching parentheses is a useful tool here. The missing close parenstheses appear to be in the last two eq clauses -- the ones with LABEL and LAMBDA. Change to:

eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]]; cons [list [cadar [e]; car [e]; a]]);

eq [caar [e]; LAMBDA] -> eval [caddar [e]; append [pair [cadar [e]; evlis [cdr [e]; a]; a]]])

I've used ')' to show where I inserted characters. I note that Paul Graham's implementation of eval in Common Lisp has parenthenses in these places.

*** Mark Stock 30 July 2010 at 04:07
If I am reading Paul Graham's implementation of eval in Common Lisp correctly, I think that the ')' goes in a different place for LABEL

eq [caar [e]; LABEL] -> eval [cons [caddar [e]; cdr [e]]; cons [list [cadar [e]; car [e]); a]];

I think that the second cons function takes two parameters:
list [cadar [e]; car [e]]
a


----------------------------------------------------
Short notes on McCarthy's "Recursive Functions ... "
----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/05/short-notes-on-mccarthys-recursive.html

Vedi "Majorinc-short-notes-on-McCarthys-recursive-functions.pdf" nella cartella "data".


---------------------------------------------------------
Using (sin cos 0.5) instead of (sin (cos 0.5)) in Newlisp
---------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/07/using-sin-cos-05-instead-of-sin-cos-05.html

; Recently, Jeremy Dunn on Newlisp forum expressed desire to use
; the single argument functions in Newlisp in following fashion:
;
;     (sin cos 0.5) = (sin (cos 0.5))
;
; The motivation is well know in Lisp world: avoidance of parentheses.
; I believe that regularity of the Lisp syntax should be preserved
; and that it is better to be consistent, although more verbose.
;
; However, the problem is interesting.
;
; At least two works are already done in Newlisp in that dyrection. Cyril
; Slobin described make-pass macro:
;
;         http://slobin.livejournal.com/148287.html
;
; (define-macro (make-pass)
;   (doargs (arg)
;     (letex ((Old arg)
;             (New (sym (append (string arg) "&"))))
;       (define-macro (New)
;         (Old (eval (args)))))))
;
; (make-pass catch not print)
;
; Here is how it works:
;
; (catch& while (read-line)
;   (setq line (current-line))
;   (if (not& empty? line)
;     (print& format "%s\n" line)
;     (throw 'empty)))
;
; My construct for composition of arbitrary functions
; or fexprs should be mentioned as well.
;
;   http://kazimirmajorinc.blogspot.com/2010/02/composition-of-functions-or-macros.html
;
; Its syntax should be:
;
; ((compose sin cos) 0.5)
;
; Needless to say, compose is "in the spirit" of the Lisp,
; but it is syntactically heavier than original (sin (cos 0.5)).
; And Jeremy didn't liked even Cyril's (sin& cos 5).
;
; So, I adapted Cyril's idea to work without that extra &, but
; then it had to work both like sin& and original sin.

(println (sin 3))
(println (sin (cos 4)))
(println (sin (cos (sin 5))))

; 0.1411200081
; -0.6080830096
; 0.5433319155

(define-macro (make-pass-adapted)
  (doargs (arg)
     (constant arg
        (letex((arg (eval arg)))
           (lambda-macro()
              (arg (eval (if (> (length (args)) 1)
                             (args)
                             (first (args))))))))))

(make-pass-adapted sin cos)

(println (sin (+ (cos 0) (cos 0) (cos 0))))
(println (sin cos 4))
(println (sin cos sin (+ 2 3)))

; 0.1411200081
; -0.6080830096
; 0.5433319155

; I'll test it whether it works with Cyril's example.

 (make-pass-adapted catch not print)

 (catch while (read-line)
   (setq line (current-line))

   (if (not empty? line)
     (print format "%s\n" line)
     (throw 'empty)))

; It's really easy, so I had doubt whether it is important enough
; to blog about that, lets say, sinful sin. However, I noticed
; that it is interesting example of the function that is replaced
; with FEXPR.


---------------------------------------------------------
McCarthy's 1960 "Recursive Functions ..." Lisp in Newlisp
---------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/08/mccarthys-1960-recursive-functions-lisp.html

;===============================================================
;
; McCarthy's Lisp, as described in  "Recursive functions", 1960,
; (40+ functions and operators)  is implemented in Newlisp. I'll
; use the term "McCarthy60 Lisp" for that dialect.
;
;     http://www-formal.stanford.edu/jmc/recursive.html
;
; As  syntax  of  Newlisp  and  McCarthy60  Lisp  are  the same,
; implementation  is  very  simple:  it  is   enough  to  define
; McCarthy60  Lisp functions  and operators as Newlisp functions
; or eventually, fexprs. It is convenient that Newlisp functions
; use lower case letters, while McCarthy60 Lisp uses upper case.
;
; There  are  some  important  differences  between  Newlisp and
; McCarthy60  Lisp.  Newlisp  doesn't  have  dottedpairs, it has
; lists only.  McCarthy60 Lisp uses T for 'true' and F (not NIL)
; for 'false'.  Newlisp uses true and nil.  In some Lisp dialect
; without   these   two   differences,   for   example,  Scheme,
; implementation could be even simpler. However, taking this into
; consideration, Newlisp and McCarthy60 Lisp can be mixed freely.
;
; The implementation could be of  interest for those who want to
; understand  and  who  are  not   sure   about   some  details,
; particularly because there are few errors in original article,
; as recently discussed in this blog.
;
; There  are lot of  comments and  examples "apostrophed out" in
; code.
;
; If you have some comment, or you think something could be done
; better, I'd like to hear it.
;
; Inspired by MARK STOCK'S recent project
;
;      http://hoop-la.ca/apple2/2010/retrochallenge.html
;
; Much more geeky than this one.
;
; Another very  useful discussion is Paul Graham's "The Roots of
; Lisp."
;
;         http://www.paulgraham.com/rootsoflisp.html
;
;---------------------------------------------------------------

   (set '[println.supressed] true)
   (load "http://www.instprog.com/Instprog.default-library.lsp")
   (set '[println.supressed] nil)

;---------------------------------------------------------------
; Newlisp has not dotted pairs, so they are emulated here.
;---------------------------------------------------------------

(define (dotform-atom? L)
  (atom? L))

(define (dotform-base? L)
  (and (list? L)
        (= (length L) 3)
        (= (nth 1 L) '.)))

(define (dotform-recursive? L)
   (or (dotform-atom? L)
        (and (dotform-base? L)
              (dotform-recursive? (first L))
              (dotform-recursive? (last L)))))

(define (listform-atom?)
   (and (atom? L)
         (not (= L 'NIL))))

(define (listform-base? L)
   (and (list? L)
         (not (dotform-base? L))))

(define (listform-recursive? L)
  (or (listorm-atom? L)
       (and (listform-base? L)
             (for-all? listform-recursive? L))))

(define (dotform L)
  (cond ((dotform-atom? L) L)
         ((dotform-base? L) (list  (dotform (first L))
                                    '.
                                    (dotform (last L))))
         ((= (length L) 0) 'NIL)
         ((> (length L) 0) (list (dotform (first L))
                                  '.
                                  (dotform (rest L))))))

(define (listform L)
  (cond ((listform-atom? L) L)
         ((= L '()) L)
         ((listform-base? L) (cons (listform (first L))
                                    (listform (rest L))))
         ((= L 'NIL) '())
         ((dotform-base? L) (let((L1 (listform (first L)))
                                 (L2 (listform (last L))))
                                (if (listform-base? L2)
                                    (cons L1 L2)
                                    (list L1 '. L2))))))

(define (listform-args L)
   (cond ((empty? L) L)
         ((= (first L) (quote .))(listform (rest L)))
         (true (listform L))))

  '(println= (listform-args '()))
  '(println= (listform-args '(. OOOPS)))
  '(println= (listform-args '(a b c d)))

(dolist (X '(NIL                    ()                       (())
            (NIL)                   ((NIL))                  (NIL . (NIL . NIL))
            ((NIL . NIL) . NIL)     ((A . NIL) . (B . NIL))  (A)
            (A . B)                 (() . ())                (B . (C))
            (A B C)))
        '(println= X (dotform X) (listform X)))

;===============================================================
; DEFINITION OF FEW BASIC OPERATORS.
; THESE OPERATORS ARE ELEMENTS OF META-LANGUAGE, DEFINED IN
; META-META-LANGUAGE (Newlisp)
;---------------------------------------------------------------

      (define-macro (COND)
         (letn((done nil)
               (result nil)
               (arglist (args))
               (largs (listform-args (args))))
             (dolist(clause largs done)
                 (when (= (eval (nth 0 clause)) 'T)
                       (setf result (eval (nth 1 clause)))
                       (setf done true)))
             (if (not done)
                 (throw-error "COND without any alternative satisfied.")
                 result)))

      (define-macro (AND)
         (letn((arglist (args))
               (largs (listform arglist)))
          (if (eval (cons 'and (map (lambda(x)(expand '(= x (quote T))
                                                      'x))
                                     largs)))
              (quote T)
              (quote F))))

          '(println= (AND 1 2) "should be F." )

     (define-macro (OR)
          (letn((arglist (args))
                (largs (listform arglist)))
              (if (eval (cons 'or (map (lambda(x)(expand '(= x (quote T))
                                                         'x))
                                        largs)))
                  (quote T)
                  (quote F))))

      (define-macro (NOT x)
         (let ((lx (listform x)))
          (if (= (eval lx) (quote T))
              (quote F)
              (if (= (eval lx) (quote F))
                  (quote T)
                  (throw-error
                    " NOT called with argument evaluating to T OR F.")))))

         '(println= (NOT (quote T)) (NOT (quote F))
                    "should be F AND T respectively.")

      ;---------------------------------------------------------------
      ; ABBREVIATION LIST
      ;
      ; STATUS OF THE ABBREVIATION LIST IS NOT CLEAR, i.e. IS IT DEFINED USING
      ; BOTH META-LANGUAGE OR IN META-META-LANGUAGE.
      ;
      ; AS IT CANNOT BE S-FUNCTION I THINK IT iS BEST TO CONSIDER IT AS
      ; ANOTHER SPECIAL OPERATOR OF META-LANGUAGE DEFINED IN META-META-LANGUAGE,
      ; SIMILAR TO COND.
      ;
      ; (LIST (quote e1) ... (quote en)) => (e1 . (... . (en . NIL)))
      ;---------------------------------------------------------------

      (define (LIST)
        (let((a (args)))
            (cond ((empty? a) (quote NIL))
                  ((quote T) (list (dotform (first a))
                                   '. (dotform (rest a)))))))

          '(println= (listform (LIST (quote e1) (quote e2)
                                     (quote ...) (quote en)))
                     "should be (e1 e2 ... en).")

      ;---------------------------------------------------------

      (define-macro (QUOTE x) x)
          '(println= (QUOTE (X X)) "should be (X X).")

      ;---------------------------------------------------------

      (define-macro (LAMBDA)
           (append (lambda) (args)))

        '(println ((LAMBDA(x)x) (QUOTE A)))

      ;---------------------------------------------------------

      (define-macro (LABEL)
        (let((l1 (first (args)))
             (l2 (last (args))))
            ;(println l1 l2)
            (set l1 (eval l2))))

;===============================================================
; FIVE ELEMENTARY S-FUNCTIONS.
;
; THESE S-FUNCTIONS ARE ELEMENTS OF THE META LANGUAGE, AND THEY ARE
; DEFINED IN META-META-LANGUAGE (NEWLISP).
;
; ALL S-FUNCTIONS ACCEPT ARGUMENTS IN FORM (A . B) AND (A B).

;---------------------------------------------------------------
; 1. ATOM
;---------------------------------------------------------------

(define (ATOM x)
        (if (atom? (dotform x)) (quote T) (quote F)))

'(println= (ATOM 'X) "should be T.")
'(println= (ATOM '(X . A)) "should be F.")

;---------------------------------------------------------------
; 2. EQ
;---------------------------------------------------------------

(define (EQ x y)
        (let((x (dotform x))
             (y (dotform y)))
          (if (and (atom? (dotform x)) (atom? (dotform y)))
              (if (= x y) (quote T) (quote F))
              (throw-error (string "** EQ undefined for " x " AND " y "**")))))

'(println= (EQ 'X 'X) "should be T.")
'(println= (EQ 'X 'A) "should be F.")
'(println= (EQ 'X '(X . A)) "should be undefined.")

;---------------------------------------------------------------
; 3. CAR
;---------------------------------------------------------------

(define (CAR x)
  (let ((x (dotform x)))
     (cond ((= x 'NIL) (throw-error "CAR undefined for NIL."))
            ((atom? x)
             (throw-error (string "CAR undefined for atomic symbol " x)))
            (true (first x)))))

'(println= (CAR '(X . A)) "should be X.")
'(println= (CAR '((X . A) . Y)) "should be (X . A).")

;---------------------------------------------------------------
; 4. CDR
;---------------------------------------------------------------

(define (CDR x)
  (let ((x (dotform x)))
     (cond ((= x 'NIL)
               (throw-error "CAR undefined for NIL."))
           ((atom? x)
               (throw-error (string "CDR undefined for atomic symbol " x)))
           (true (last x)))))

'(println= (CDR '(X . A)) "should be A.")
'(println= (CDR '((X . A) . Y)) "should be Y.")

;---------------------------------------------------------------
; 5. CONS
;---------------------------------------------------------------

(define (CONS x y)
     (let ((x (dotform x))
           (y (dotform y)))
           (list x '. y)))

'(println= (CONS 'X 'A) "should be (X . A).")
'(println= (CONS '(X . A) 'Y) "should be ((X . A). Y).")

;---------------------------------------------------------------
; DEFINITION OF IMPORTANT S-FUNCTIONS IN META-LANGUAGE
; STRICTLY FOLLOWED MCCARTHY'S ARTICLE. LOOK EXAMPLES AS BEST
; EXPLANATION

;---------------------------------------------------------------
; FF
;
; Returns first element of the LIST recursively
;---------------------------------------------------------------

(define (FF x)
        (COND ((ATOM x) x)
              ((QUOTE T) (FF (CAR x)))))

'(println= (FF (QUOTE A)) "should be A.")
'(println= (FF (QUOTE ((A . B) . C))) "should be A.")
'(println= (FF (QUOTE (((D) . B) . C))) "should be D.")

;---------------------------------------------------------------
; SUBST
;
; (SUBST x y z) returns result of substitution of x for y in z
;---------------------------------------------------------------

(define (SUBST x y z)
        (COND ((ATOM z) (COND ((EQ z y) x)
                              ((QUOTE T) z)))
              ((QUOTE T) (CONS (SUBST x y (CAR z))
                               (SUBST x y (CDR z))))))

'(println= (SUBST (QUOTE (X . A)) (QUOTE B) (QUOTE ((A . B) . C)))
          "should be ((A . (X . A)) . C)")

;---------------------------------------------------------------
; EQUAL
;
; Generalization of S-function EQ for all s-expressions.
;---------------------------------------------------------------

(define (EQUAL x y)
        (OR (AND (ATOM x) (ATOM y) (EQ x y))
            (AND (NOT (ATOM x))
                 (NOT (ATOM y))
                 (EQUAL (CAR x) (CAR y))
                 (EQUAL (CDR x) (CDR y)))))

'(println= (EQUAL (QUOTE (A . B)) (QUOTE (A . B))) "should be T")

;---------------------------------------------------------------
; NULL
;---------------------------------------------------------------

(define (NULL x)
        (AND (ATOM x) (EQ x (QUOTE NIL))))

'(println= (NULL (QUOTE NIL)) "should be T")

;---------------------------------------------------------------
; S-functions CAAR, CADR etc
;
; (CADDAR x) = (CAR (CDR (CDR (CAR x))))
;---------------------------------------------------------------

(define (CAAR   x)(CAR (CAR   x)))
(define (CADR   x)(CAR (CDR   x)))
(define (CDAR   x)(CDR (CAR   x)))
(define (CDDR   x)(CDR (CDR   x)))
(define (CAAAR  x)(CAR (CAAR  x)))
(define (CAADR  x)(CAR (CADR  x)))
(define (CADAR  x)(CAR (CDAR  x)))
(define (CADDR  x)(CAR (CDDR  x)))
(define (CDAAR  x)(CDR (CAAR  x)))
(define (CDADR  x)(CDR (CADR  x)))
(define (CDDAR  x)(CDR (CDAR  x)))
(define (CDDDR  x)(CDR (CDDR  x)))
(define (CADDAR x)(CAR (CDDAR x)))

            ;-------------------------------------------------
            ; THIS IS HOW IT CAN BE DONE IN META-META-LANGUAGE

            ; (let((L '(CAR CDR))
            ;      (n 10000))
            ;    (dotimes(i (/ n 2))
            ;      (let ((s (pop L)))
            ;        (dolist(j '(CAR CDR))
            ;          (set 's0 (sym (APPEND (chop (string j)) (rest (string s)))))
            ;          (set s0 (expand (lambda(x)(j (s x))) 's 'j))
            ;          (push s0 L -1)))))
            ;

'(dolist (i '(CAR CDR
             CAAR  CADR  CDAR  CDDR
             CAAAR CAADR CADAR CADDR
             CDAAR CDADR CDDAR CDDDR))
    (eval (expand '(println= (i (QUOTE (((1 . 2).(3 . 4)).((5 . 6).(7 . 8))))))
                  'i)))

;---------------------------------------------------------------
; S-FUNCTIONS USEFUL WHEN S-EXPRESSIONS ARE REGARDED AS LISTS
; DEFINED IN META-LANGUAGE IN MCCARTHY'S PAPER
;---------------------------------------------------------------

;---------------------------------------------------------------
; 1. APPEND
;---------------------------------------------------------------

(define (APPEND x y)
    (COND ((NULL x) y)
          ((QUOTE T) (CONS (CAR x) (APPEND (CDR x) y)))))

'(println= (listform (APPEND (QUOTE (A B)) (QUOTE (C D E))))
          "should be (A B C D E).")

;---------------------------------------------------------------
; 2. AMONG
;
; (AMONG (QUOTE <s>) (QUOTE <l>))
;
; returns T if <s> is element of the LIST <l>
;         F otherwise
;
;---------------------------------------------------------------

(define (AMONG x y)
        (AND (NOT (NULL y))
             (OR (EQUAL x (CAR y))
                 (AMONG x (CDR y)))))

'(println= (AMONG (QUOTE X) (QUOTE (A B X C))) "should be T.")
'(println= (AMONG (QUOTE X) (QUOTE (A B D C))) "should be F.")

;---------------------------------------------------------------
; PAIR
;
; (PAIR (QUOTE (<s1> ... <sn>)) (QUOTE (<t1> ... <tn>))) =>
;       ((<s1> <t1>) ... (<sn> <tn>))
;---------------------------------------------------------------

(define (PAIR x y)
        (COND ((AND (NULL x) (NULL y)) (QUOTE NIL))
              ((AND (NOT (ATOM x)) (NOT (ATOM y))) (CONS (LIST (CAR x) (CAR y))
                                                         (PAIR (CDR x) (CDR y))))))

'(println= (listform (PAIR (QUOTE (A B C)) (QUOTE (X (Y Z) U))))
          "should be ((A X)(B (Y Z)) (C U))")

;---------------------------------------------------------------
; ASSOC
;
; ASSOC returns the "value" of variable x in "association LIST" y.
; for example,
;
;  (ASSOC (QUOTE X) (QUOTE ((W (A B)) (X (C D)) (Y (E F)))))
;
; returns (C D).
;
; If variable is NOT "stored" in association LIST, then there
; will be error in attempt to find CAAR of empty list.

(define (ASSOC x y)
  (COND ;((AND (ATOM y)
        ;  (EQ y (QUOTE NIL))) (throw-error "ASSOC " x " in " y " is impossible."))
        ((EQ (CAAR y) x) (CADAR y))
        ((QUOTE T) (ASSOC x (CDR y)))))

'(println= (listform (ASSOC (QUOTE X) (QUOTE ((W (A B)) (X (C D)) (Y (E F))))))
          "should be (C D).")

;---------------------------------------------------------------
; SUBLIS (substitution defined by LIST).
;---------------------------------------------------------------

(define (SUB2 x z)
        (COND ((NULL x) z)
              ((EQ (CAAR x) z) (CADAR x))
              ((QUOTE T) (SUB2 (CDR x) z))))

(define (SUBLIS x y)
        (COND ((ATOM y) (SUB2 x y))
              ((QUOTE T) (CONS (SUBLIS x (CAR y))
                               (SUBLIS x (CDR y))))))

'(println= (listform (SUBLIS (QUOTE ((X (A B)) (Y (B C))))
                            (QUOTE (A . (X . Y)))))
          "should be (A (A B) B C).")

;---------------------------------------------------------------
; APPQ
;
; (APPQ (QUOTE (<expr1> ... <exprn>)))
;
;                        ===> ((QUOTE <expr1>)...(QUOTE <exprn>))
;---------------------------------------------------------------

(define (APPQ m)
        (COND ((NULL m) (QUOTE NIL))
              ((QUOTE T) (CONS (LIST (QUOTE QUOTE) (CAR m))
                               (APPQ (CDR m))))))

'(println= (listform (APPQ (QUOTE ((+ 1 1) 2 3))))
         "should be ((QUOTE (+ 1 1)) (QUOTE 2) (QUOTE 3)).")

;---------------------------------------------------------------
; EVAL
;
; in original code there is no branching on EVAL-QUOTE and similar
; functions, but this version is not significantly different, but
; it is much more practical for experiments.
;---------------------------------------------------------------

(define (EVAL e a)
   (COND ((ATOM e) (ASSOC e a))
         ((ATOM (CAR e))

             (COND ((EQ (CAR e) (QUOTE QUOTE)) (EVAL-QUOTE e a))
                   ((EQ (CAR e) (QUOTE ATOM))  (EVAL-ATOM e a))
                   ((EQ (CAR e) (QUOTE EQ))    (EVAL-EQ e a))
                   ((EQ (CAR e) (QUOTE COND))  (EVAL-COND e a))
                   ((EQ (CAR e) (QUOTE CAR))   (EVAL-CAR e a))
                   ((EQ (CAR e) (QUOTE CDR))   (EVAL-CDR e a))
                   ((EQ (CAR e) (QUOTE CONS))  (EVAL-CONS e a))
                   ((QUOTE T)                  (EVAL-REST e a))))

         ((EQ (CAAR e) (QUOTE LABEL))          (EVAL-LABEL e a))
         ((EQ (CAAR e) (QUOTE LAMBDA))         (EVAL-LAMBDA e a))
         ((QUOTE T)
             (throw-error
                (string "EVAL unexpected case, e=" e ", a=" a ".")))))

    ;-----------------------------------------------------------------+
    ; EVCON:                                                          |
    ;                                                                 |
    ; (EVCON (QUOTE ((<p1> <e1>)..(<pn> <en>))) <a>) =                |
    ;                                                                 |
    ; calculates (EVAL <p1> <a>), (EVAL <p2> <a>),... until it find   |
    ; first (EVAL <pi> <a>) that evaluates to T.                      |
    ;                                                                 |
    ; Then it returns (EVAL <ei> <a>).                                |
    ;-----------------------------------------------------------------+

        (define (EVCON c a)
                (COND ((EVAL (CAAR c) a) (EVAL (CADAR c) a))
                      ((QUOTE T)         (EVCON (CDR c) a))))

    ;---------------------------------------------------------------
    ; EVLIS:
    ;
    ; (EVLIS (QUOTE (<expr1> ... <exprn>)) a)    =>   (<r1> ... <rn>)
    ;
    ; where <ri> = result of the (EVAL (QUOTE <expri> a))
    ;---------------------------------------------------------------

        (define (EVLIS m a)
                (COND ((NULL m)  (QUOTE NIL))
                      ((QUOTE T) (CONS (EVAL (CAR m) a)
                                       (EVLIS (CDR m) a)))))

        ;-------
        ; (EVAL (QUOTE (QUOTE expr1)) a) evaluates to expr1

        (define (EVAL-QUOTE e a)
           (CADR e))

           '(println= (EVAL (QUOTE (QUOTE A)) (QUOTE ()))
                      "should be A")

        ;-------

        (define (EVAL-ATOM e a)
           (ATOM (EVAL (CADR e) a)))

           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((X A))))
                      "should be T.")
           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((Y OH)(X NIL))))
                      "should be T.")
           '(println= (EVAL (QUOTE (ATOM X)) (QUOTE ((X (A)))))
                      "should be F.")

        ;-------

        (define (EVAL-EQ e a)
           (EQ (EVAL (CADR e) a) (EVAL (CADDR e) a)))

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE B))) (QUOTE NIL))
                      "should be F.")
           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE A))) (QUOTE NIL))
                      "should be T.")
           '(println= (EVAL (QUOTE (EQ X (QUOTE A))) (QUOTE ((X A))))
                      "should be T.")

        ;-------

        (define (EVAL-COND e a)
           (EVCON (CDR e) a))

           '(println= (EVAL (QUOTE (COND ((ATOM X)(QUOTE FIRST-CHOICE))
                                        ((QUOTE T)(QUOTE SECOND-CHOICE))))
                           (QUOTE ((X Z))))
                     "should be FIRST-CHOICE.")

           '(println= (EVAL (QUOTE (COND ((ATOM X)(QUOTE FIRST-CHOICE))
                                        ((QUOTE T)(QUOTE SECOND-CHOICE))))
                           (QUOTE ((X (EXTRA Z)))))
                     "should be SECOND-CHOICE.")

        ;-------

        (define (EVAL-CAR e a)
           (CAR (EVAL (CADR e) a)))

           '(println= (EVAL (QUOTE (CAR (QUOTE (X Y))))
                            (QUOTE ((A B))))
                     "should be X.")

        ;-------

        (define (EVAL-CDR e a)
           (CDR (EVAL (CADR e) a)))

             '(println= (listform (EVAL (QUOTE (CDR (QUOTE (X Y))))
                                        (QUOTE ((A B)))))
                     "should be (Y).")

        ;-------

        (define (EVAL-CONS e a)
           (CONS (EVAL (CADR e) a)
                 (EVAL (CADDR e) a)))

                 '(println= (EVAL (QUOTE (CONS (QUOTE X) (QUOTE Y)))
                                  (QUOTE ((X Z))))
                         "should be (X . Y).")

                 '(println= (EVAL (QUOTE (CONS X (QUOTE Y)))
                                  (QUOTE ((X Z))))
                         "should be (Z . Y).")

    ;-------------------------------------------------------
    ; EVAL-REST is the strangest rule for evaluation, from modern point
    ; of view. It is used for evaluation of the lists of the form
    ;
    ;     (FUN <expr1> <expr2> ... <exprn>)
    ;
    ;
    ; where FUN is some user-defined symbol, so EVAL search its
    ; value in association list a given as argument. EVAL first
    ; calculate the LIST of the evaluated elements
    ;
    ;    (<efun> (EVAL <expr1> a) ... (EVAL <exprn> a))
    ;
    ; and result is then evaluated once again. Some people, for
    ; example, Paul Graham in his paper "Roots of Lisp" suggests
    ; that this is bug, AND I believe he is right. Instead of that,
    ; it will be evaluated as
    ;
    ;    ((ASSOC FUN a) <expr1> ... <exprn>)
    ;-------------------------------------------------------

        (define (EVAL-REST e a)
           (EVAL (listform (CONS (ASSOC (CAR e) a)
                                 (CDR e))) ; This (CDR e) is used
                                           ; instead of original version
                                           ; (EVLIS (CDR e) a),
                                           ; that is likely bug.
                 a))

                '(println= (EVAL (QUOTE (P (QUOTE (QUOTE A))))
                                (QUOTE ((P ATOM))))
                          "should be F.")

                '(println= (EVAL (QUOTE (P (QUOTE (QUOTE (QUOTE A)))))
                                (QUOTE ((P ATOM))))
                          "should be F.")

                '(println= (EVAL (QUOTE (P (QUOTE A)))
                                (QUOTE ((P R)(R S)(S ATOM))))
                          "should be T.")

                '(println= (listform (EVAL (QUOTE (P (QUOTE (X)) (QUOTE (Y))))
                                          (QUOTE ((P R)(R CONS)))))
                          "should be ((X) Y).")

        ;-------------------------------------------------------
        ; LAMBDA-expressions are evaluates by transforming
        ;
        ;  (EVAL (QUOTE ((LAMBDA(p1...pn) expr) expr1 ... exprn))
        ;        (QUOTE ((a1 e1)...(am em))))
        ;
        ; to
        ;
        ;  (EVAL (QUOTE expr)
        ;        (QUOTE ((p1 expr1)...(pn exprn)(a1 e1) ...(an em))))
        ;
        ; and transformed expression is evaluated and result is returned.
        ;-------------------------------------------------------

        (define (EVAL-LAMBDA e a)
           (EVAL (CADDAR e)
                 (listform (APPEND (PAIR (CADAR e) (EVLIS (CDR e) a)) a))))

           '(println= (listform (EVAL (QUOTE ((LAMBDA (X)
                                                  (CONS X (QUOTE NIL)))
                                              (QUOTE A)))
                                     (QUOTE (()))))

                     "should be (A).")

           '(println= (listform (EVAL (QUOTE ((LAMBDA (X)(CONS X (QUOTE NIL)))
                                              (CONS G (QUOTE NIL))))
                                      (QUOTE ((G (HOP-CUP-POSKOCIT-CU))))))

                     "should be (((HOP-CUP-POSKOCIT-CU))).")

        ;-------------------------------------------------------
        ; LABEL-expressions are evaluated by transforming
        ;         ;
        ; (EVAL (QUOTE ((LABEL f (LAMBDA...)) expr1 ... exprn))
        ;       (QUOTE ((a1 e1)...(am em))))
        ;
        ; to
        ;
        ; (EVAL (QUOTE ((LAMBDA ...) expr1 ... exprn))
        ;       (QUOTE ((f (LABEL f (LAMBDA...)))(a1 e1)...(am em))))
        ;
        ; and transformed expression is evaluated, and result is returned.
        ;
        ; Locally, it is enough to define label once, it will work:
        ;
        ;  (EVAL(QUOTE ((LABEL f (LAMBDA(X)(CONS X (CONS X (QUOTE NIL)))))
        ;               (f (f (f (f (f (f (f (f (f (QUOTE A))))))))))))
        ;               (QUOTE ()))
        ;-------------------------------------------------------

        (define (EVAL-LABEL e a)
           (EVAL (listform (CONS (CADDAR e) (CDR e)))
                 (listform (CONS (LIST (CADAR e) (CAR e)) a))))

           '(println= (EVAL-LABEL (QUOTE ((LABEL f (LAMBDA (X Y)(CONS X Y)))
                                (QUOTE (A))
                                (QUOTE (B))))
                        (QUOTE ((A1 E1)(A2 E2)))))

           '(println= (EVAL-LABEL
               (QUOTE ((LABEL f (LAMBDA(X)(CONS X (CONS X (QUOTE NIL)))))
                       (f (g (f (g (f (g (f (g (f (QUOTE A))))))))))))
               (QUOTE ((g (LAMBDA(Y)(CONS Y (CONS (QUOTE 1) (QUOTE NIL)))))))))

           '(println= (listform
               (EVAL (QUOTE ((LABEL SUBST
                              (LAMBDA (X Y Z)
                                  (COND ((ATOM Z)
                                         (COND ((EQ Y Z) X)
                                               ((QUOTE T) Z)))
                                        ((QUOTE T)
                                             (CONS (SUBST X Y (CAR Z))
                                                   (SUBST X Y (CDR Z)))))))
                             (QUOTE (A)) (QUOTE B) (QUOTE (Z B C))))

                    (QUOTE (()))))
                "should be (Z (A) C).")

           '(println= (listform
              (EVAL (QUOTE (SUBST (QUOTE (A)) (QUOTE B) (QUOTE (Z B C))))
                    (QUOTE ((SUBST
                            (LAMBDA (X Y Z)
                                (COND ((ATOM Z)
                                       (COND ((EQ Y Z) X)
                                             ((QUOTE T) Z)))
                                      ((QUOTE T)
                                           (CONS (SUBST X Y (CAR Z))
                                                 (SUBST X Y (CDR Z)))))))))))
               "should be (Z (A) C).")

           '(println= (listform (EVLIS (QUOTE (A . NIL))
                                      (QUOTE ((POKOS CAR)(A (X Y))))))
                     "should be ((X Y)).")

           '(println= (EVAL (QUOTE A) (QUOTE ((A VAL))))
                     "should be VAL.")

           '(println= (EVAL (QUOTE B)
                           (QUOTE ((A  VAL1) (B VAL2) (C VAL3))))
                     "should be VAL2.")

           '(println= (EVAL (QUOTE (QUOTE A)) (QUOTE ((A VAL))))
                     "should be A.")

           '(println= (EVAL (QUOTE (ATOM (QUOTE A)) (QUOTE ((T1 T2)))))
                     "should be T.")

           '(println= (EVAL (QUOTE (ATOM A)) (QUOTE ((A VAL))))
                     "should be T.")

           '(println= (EVAL (QUOTE (ATOM A)) (QUOTE ((A (VAL)))))
                     "should be F.")

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE A))) (QUOTE NIL))
                     "should be T.")

           '(println= (EVAL (QUOTE (EQ (QUOTE A) (QUOTE B))) (QUOTE NIL))
                     "should be F.")

           '(println= (EVAL (QUOTE (EQ A B)) (QUOTE ((A Z)(B Z))))
                     "should be T.")

           '(println= (EVAL (QUOTE (EQ A B)) (QUOTE ((A Y)(B Z))))
                     "should be F.")

           '(println= (EVAL (QUOTE (COND ((QUOTE T) (QUOTE A))))
                           (QUOTE ((A HI))))
                     "should be A.")

           '(println= (EVAL (QUOTE (COND ((QUOTE F) (QUOTE A))
                                        ((QUOTE T) B)))
                           (QUOTE ((B HI))))
                     "should be HI.")

           '(println= (EVAL (QUOTE (CAR (QUOTE ((A B) (C D)))))
                           (QUOTE ((A X))))
                     "should be (A . (B . NIL)).")

           '(println= (EVAL (QUOTE (CDR (QUOTE ((A B) (C D)))))
                           (QUOTE ((A X))))
                     "should be ((C . (D . NIL)) . NIL).")

           '(println= (EVAL (QUOTE (CONS A (QUOTE B)))
                           (QUOTE ((A X) (B Y))))
                     "should be (X . B).")

           '(println= (EVAL (QUOTE V2)
                           (QUOTE ((V1 X) (V2 Y) (V3 Z))))
                     "should be Y.")

;---------------------------------------------------------------
; APPLY
;---------------------------------------------------------------

(define (APPLY f a)
  (EVAL (CONS f (APPQ a)) (QUOTE NIL)))

'(println (APPLY (QUOTE CONS) (QUOTE (A (B)))))

(println "Definition of McCarthy60 Lisp for Newlisp.")
(println "Kazimir Majorinc, 2010.")
(println "\nAvailable functions and operators: \n")

(println "AMONG, AND, APPEND, APPLY APPQ, ASSOC, ATOM, CAR, CDR, C...R,\n"
         "COND, CONS, EVAL, EQ, EQUAL, EVCON, EVLIS, FF, LABEL, LAMBDA, \n"
         "LIST, NOT, OR, PAIR, QUOTE, SUB2, SUBLIS, SUBST.\n\n"
         "listform, dotform, debug-wrap, debug-unwrap\n"

         "Can be used and combined with other Newlisp functions.")

(println "\n")

(dolist(i '(((listform (QUOTE (A . (B)))))
            ((dotform (QUOTE (A . (B)))))
            ((CONS (QUOTE (X Y)) (QUOTE (Y Z))))
            ((listform (CONS (QUOTE (X Y)) (QUOTE (Y Z)))))
            ((time (cons (quote (X Y Z)) (quote (Y Z V))) 10000))
            ((time (CONS (QUOTE (X Y Z)) (QUOTE (Y Z V))) 1000))
            ((time (EVAL (QUOTE (CONS (QUOTE (X Y Z)) (QUOTE (Y Z V))))) 100))
            ((debug-wrap CONS)
             (CONS (CONS (QUOTE (X Y)) (QUOTE NIL)) (QUOTE (Y Z))))
            ((debug-unwrap CONS)(CONS (QUOTE (X Y)) (QUOTE (Y Z))))))
   (println "            Example "
            (+ $idx 1) ". \n")
   (println "Evaluation of:\n")
   (dolist(j i)(println "   " j))
   (println "\nproduces output:\n")
   (local(k)
   (dolist(j i)
     (setf k (eval j)))
   (println "\nand result:\n")
   (println "   " k "\n-----------------------------------")))


--------------------------------------------------------------------
McCarthy-60 Lisp Implemented as Association List in McCarthy-60 Lisp
--------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/08/mccarthy-60-lisp-implemented-as.html

; In my last post, McCarthy-60 Lisp in Newlisp

;  (1) McCarthy-60 Lisp, the version from his "Recursive functions..."
;      paper was defined in Newlisp. "Defined" because Newlisp is
;      Lisp, so McCarthy-60 Lisp functions (and special operators)
;      can be "just defined" as Newlisp functions and special
;      operator. Such a Newlisp + defined function behaves like
;      original McCarthy's Lisp. I guess that it could be done
;      even more easily in Lisp dialects more similar to McCarthy
;      60 Lisp, for example, Picolisp or Scheme.

;  (2) The legendary McCarthy's function EVAL was defined. Some
;      care was required, because the function as defined in McCarthy's
;      article, but also in other contemporary manuals and memos
;      had errors. Paul Graham's paper "The Roots of Lisp" can be
;      recommended.

; In this post another instance of McCarthy-60 Lisp running on top
; of that is implemented.

; For clarity, different keywords will be used in each "instance"
; of Lisp. For example, if we write:
;
;     (lambda(xx)(cons xx (cons xx (quote ()))))
;
; in Newlisp, then
;
;     (LAMBDA(XX)(CONS XX (CONS XX (QUOTE ()))))
;
; will be used in McCarthy-60 Lisp defined in Newlisp, and also
;
;     (LAMBDA.1(XX)(CONS.1 XX (CONS.1 XX (QUOTE.1 ()))))
;
; in McCarthy-60 Lisp interpreted in previous Lisp. And also
;
;     (LAMBDA.2(XX)(CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
;
; in McCarthy-60 Lisp interpreted in previous Lisp, described in
; this post.
;
;
;
;                       --------------
;
;
; McCarthy-60 EVAL has two arguments:
;
;                       (EVAL <e> <a>)
;
; where <e> is expression that is evaluated, and <a> is association
; list that contains values of the functions and variables used in
; <e>. For example, <a> might look like:
;
;         ((X 37)(f (LAMBDA.1(x)(CONS.1 x (QUOTE.1 NIL)))))
;
; if X or f occurs in <e>, the respective values will be used.
; McCarthy-60 EVAL is not very efficient, but is conceptually
; simple.
;
; Such definition of EVAL allows definition of whole interpreters
; as association list, and that's what is described in this post:
; interpreter of McCarthy-60 Lisp, in the form of association
; list that can be supplied to - McCarthy-60 Lisp.
;
; This is how this interpreter looks like:

(setf McCarthy-60-interpreter

 '(QUOTE

    (
      ;-------------------------
      (EVAL.1 (LABEL.1 EVAL.1
         (LAMBDA.1 (e a)
            (COND.1
               ((ATOM.1 e) (ASSOC.1 e a))
               ;-------------------------
               ((ATOM.1 (CAR.1 e))

                (COND.1

                    ((EQ.1 (CAR.1 e) (QUOTE.1 QUOTE.2))
                           (CAR.1 (CDR.1 e)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 ATOM.2))
                           (ATOM.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 EQ.2))
                           (EQ.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                         a)
                                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                         a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 COND.2))
                           (EVCON.1 (CDR.1 e) a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 AND.2))
                       (EVAL.1 (CONS.1 (QUOTE.1 COND.2)
                                  (CONS.1 (CDR.1 e)
                                     (QUOTE.1 (((QUOTE.2 T)
                                                (QUOTE.2 F))))))
                               a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CAR.2))
                           (CAR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CDR.2))
                           (CDR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CONS.2))
                           (CONS.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)
                                   (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                           a)))
                    ;-------------------------
                    ((QUOTE.1 T) (EVAL.1 (CONS.1 (ASSOC.1 (CAR.1 e)
                                                          a)
                                                 (CDR.1 e))
                                         a))))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LABEL.2))
                    (EVAL.1 (CONS.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                                    (CDR.1 e))
                            (CONS.1 (LIST.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                            (CAR.1 e))
                                    a)))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LAMBDA.2))
                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                         (APPEND.1 (PAIR.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                           (EVLIS.1 (CDR.1 e) a))
                                   a)))

       ))))
      ;-------------------------
      (APPEND.1 (LABEL.1 APPEND.1
         (LAMBDA.1(X Y)
            (COND.1 ((NULL.1 X) Y)
               ((QUOTE.1 T)
                   (CONS.1 (CAR.1 X) (APPEND.1 (CDR.1 X) Y)))))))
      ;-------------------------
      (ASSOC.1 (LABEL.1 ASSOC.1
         (LAMBDA.1 (X Y)
            (COND.1
               ((EQ.1 (CAR.1 (CAR.1 Y)) X) (CAR.1 (CDR.1 (CAR.1 Y))))
               ((QUOTE.1 T)                (ASSOC.1 X (CDR.1 Y)))))))
      ;-------------------------
      (PAIR.1 (LABEL.1 PAIR.1
         (LAMBDA.1 (X Y)
            (COND.1 ((AND.1 (NULL.1 X) (NULL.1 Y)) (QUOTE.1 NIL))
                    ((AND.1 (NOT.1 (ATOM.1 X)) (NOT.1 (ATOM.1 Y)))
                            (CONS.1 (LIST.1 (CAR.1 X) (CAR.1 Y))
                                    (PAIR.1 (CDR.1 X) (CDR.1 Y))))))))
      ;-------------------------
      (EVLIS.1 (LABEL.1 EVLIS.1
         (LAMBDA.1 (m a)
            (COND.1 ((NULL.1 m)  (QUOTE.1 NIL))
                    ((QUOTE.1 T) (CONS.1 (EVAL.1 (CAR.1 m) a)
                                         (EVLIS.1 (CDR.1 m) a)))))))
      ;-------------------------
      (EVCON.1 (LABEL.1 EVCON.1
         (LAMBDA.1 (c a)
            (COND.1 ((EVAL.1 (CAR.1 (CAR.1 c)) a)
                             (EVAL.1 (CAR.1 (CDR.1 (CAR.1 c))) a))
                    ((QUOTE.1 T)
                             (EVCON.1 (CDR.1 c) a))))))
      ;-------------------------
      (NULL.1 (LAMBDA.1 (X)
                 (AND.1 (ATOM.1 X) (EQ.1 X (QUOTE.1 NIL)))))
      ;-------------------------
      (NOT.1 (LAMBDA.1 (X)
                 (COND.1 (X          (QUOTE.1 F))
                         ((QUOTE.1 T)(QUOTE.1 T)))))
      ;-------------------------
      (LIST.1 (LAMBDA.1 (X Y) (CONS.1 X (CONS.1 Y (QUOTE.1 NIL)))))

    )
  )
)

; Is there any difference between EVAL.1 and EVAL defined in
; last post? Yes, EVAL used "building blocks" like operators AND
; or LIST. These can be easily defined in Newlisp, but require
; different approach in McCarthy-60 Lisp, where one cannot use
; variable number of arguments or define special operators.

; How code that could be evaluated by EVAL.1 look like? Well, it
; uses keywords like QUOTE.2, ATOM.2, CONS.2. And how it is called?
; Here is an example:
;
;
; (eval (expand '(EVAL (QUOTE (EVAL.1 (QUOTE.1
;                                       ((LAMBDA.2 (XX)
;                                           (CONS.2 XX
;                                                   (CONS.2 XX
;                                                           (QUOTE.2 ()))))
;                                        (QUOTE.2 somedata)))
;                                     (QUOTE.1 ())
;                             )
;                      )
;                      McCarthy-60-interpreter
;                )
;                'McCarthy-60-interpreter
;       )
; )
;
; The result should be (somedata somedata).
;
; In the rest of this post, McCarthy-60 Lisp is defined in Newlisp,
; more-less, like it was done in previous post, and then the code
; above (using somedata) will be evaluated, so those who are
; interested can, as usually, cut and paste whole post in their
; editor and evaluate in Newlisp. The result of the evaluation
; of the code above (with debug-wrap feature from my library) is
; correct; this is how part of the output on screen can look like.

   (load "http://www.instprog.com/Instprog.default-library.lsp")

;---------------------------------------------------------------
; Newlisp has not dotted pairs, so they are emulated here.
;---------------------------------------------------------------

(define (dotform-atom? L)
  (atom? L))

(define (dotform-base? L)
  (and (list? L)
       (= (length L) 3)
       (= (nth 1 L) '.)))

(define (dotform-recursive? L)
   (or (dotform-atom? L)
       (and (dotform-base? L)
             (dotform-recursive? (first L))
             (dotform-recursive? (last L)))))

(define (listform-atom?)
   (and (atom? L)
        (not (= L 'NIL))))

(define (listform-base? L)
   (and (list? L)
        (not (dotform-base? L))))

(define (listform-recursive? L)
  (or (listorm-atom? L)
      (and (listform-base? L)
           (for-all? listform-recursive? L))))

(define (dotform L)
  (cond ((dotform-atom? L) L)
         ((dotform-base? L) (list  (dotform (first L))
                                    '.
                                    (dotform (last L))))
         ((= (length L) 0) 'NIL)
         ((> (length L) 0) (list (dotform (first L))
                                  '.
                                  (dotform (rest L))))))

(define (listform L)
  (cond ((listform-atom? L) L)
         ((= L '()) L)
         ((listform-base? L) (cons (listform (first L))
                                    (listform (rest L))))
         ((= L 'NIL) '())
         ((dotform-base? L) (let((L1 (listform (first L)))
                                 (L2 (listform (last L))))
                                (if (listform-base? L2)
                                    (cons L1 L2)
                                    (list L1 '. L2))))))

(define (listform-args L)
   (cond ((empty? L) L)
         ((= (first L) (quote .))(listform (rest L)))
         (true (listform L))))

;===============================================================
; DEFINITION OF FEW BASIC OPERATORS.
; THESE OPERATORS ARE ELEMENTS OF META-LANGUAGE, DEFINED IN
; META-META-LANGUAGE (Newlisp)
;---------------------------------------------------------------

      (define-macro (COND)
         (letn((done nil)
               (result nil)
               (arglist (args))
               (largs (listform-args (args))))
             (dolist(clause largs done ind)
                 (setf ind (eval (symbol-from-sexpr '(debug-wrap indent))))
                 ;'(println (dup " " ind) "????? COND clause: " (nth 0 clause))
                 (let ((l (eval (nth 0 clause))))
                 (if  (= l 'T)
                      (begin '(println (dup " " ind) "+++++ COND clause "
                              (nth 0 clause) " evaluates to: " (listform l))
                             (setf result (listform (eval (nth 1 clause))))
                             (setf done true))
                      '(println (dup " " ind) "----- COND clause evaluates to: "
                                (listform l))
                      )))
             (if (not done)
                 (throw-error (append (dup " " ind)
                        "!!!!! COND without any alternative satisfied."))
                 (begin '(println (dup " " ind) "!!!!! COND expr evaluates to "
                                  (listform result))
                        result))))

      (define-macro (AND)
         (letn((arglist (args))
               (largs (listform arglist)))
          (if (eval (cons 'and (map (lambda(X)(expand '(= X (quote T))
                                                      'X))
                                     largs)))
              (quote T)
              (quote F))))

     (define-macro (OR)
          (letn((arglist (args))
                (largs (listform arglist)))
              (if (eval (cons 'or (map (lambda(X)(expand '(= X (quote T))
                                                         'X))
                                        largs)))
                  (quote T)
                  (quote F))))

      (define-macro (NOT X)
         (let ((lx (listform X)))
          (if (= (eval lx) (quote T))
              (quote F)
              (if (= (eval lx) (quote F))
                  (quote T)
                  (throw-error
                    " NOT called with argument evaluating to T OR F.")))))

      ;---------------------------------------------------------------

      (define (LIST)
        (listform (let((a (args)))
                    (cond ((empty? a) (quote NIL))
                          ((quote T) (list (dotform (first a))
                                           '. (dotform (rest a))))))))

      ;---------------------------------------------------------

      (define-macro (QUOTE X) (listform X))

      ;---------------------------------------------------------

      (define-macro (LAMBDA)
           (append (lambda) (args)))

      ;---------------------------------------------------------

      (define-macro (LABEL)
        (let((l1 (first (args)))
             (l2 (last (args))))
            ;(println l1 l2)
            (set l1 (eval l2))))

;===============================================================
; FIVE ELEMENTARY S-FUNCTIONS.

;---------------------------------------------------------------
; 1. ATOM
;---------------------------------------------------------------

(define (ATOM X)
   (if (atom? (dotform X)) (quote T) (quote F)))

;---------------------------------------------------------------
; 2. EQ
;---------------------------------------------------------------

(define (EQ X Y)
   (let((X (dotform X))
        (Y (dotform Y)))
     (if (and (atom? (dotform X)) (atom? (dotform Y)))
         (if (= X Y) (quote T) (quote F))
         (throw-error (string "** EQ undefined for " X " AND " Y "**")))))

;---------------------------------------------------------------
; 3. CAR
;---------------------------------------------------------------

(define (CAR X)
  (listform
      (let ((X (dotform X)))
         (cond ((= X 'NIL) (throw-error "CAR undefined for NIL."))
                ((atom? X)
                 (throw-error (string "CAR undefined for atomic symbol " X)))
                (true (first X))))))

;---------------------------------------------------------------
; 4. CDR
;---------------------------------------------------------------

(define (CDR X)
  (listform
    (let ((X (dotform X)))
       (cond ((= X 'NIL) (throw-error "CAR undefined for NIL."))
             ((atom? X) (throw-error
                          (string "CDR undefined for atomic symbol " X)))
             (true (last X))))))

;---------------------------------------------------------------
; 5. CONS
;---------------------------------------------------------------

(define (CONS X Y)
     (listform (let ((X (dotform X))
                     (Y (dotform Y)))
                    (list X '. Y))))

;---------------------------------------------------------------
; DEFINITION OF IMPORTANT S-FUNCTIONS IN META-LANGUAGE
; STRICTLY FOLLOWED MCCARTHY'S ARTICLE. LOOK EXAMPLES AS BEST
; EXPLANATION

;---------------------------------------------------------------
; NULL
;---------------------------------------------------------------

(define (NULL X)
   (listform  (AND (ATOM X) (EQ X (QUOTE NIL)))))

;---------------------------------------------------------------
; S-FUNCTIONS USEFUL WHEN S-EXPRESSIONS ARE REGARDED AS LISTS
; DEFINED IN META-LANGUAGE IN MCCARTHY'S PAPER
;---------------------------------------------------------------

;---------------------------------------------------------------
; 1. APPEND
;---------------------------------------------------------------

(define (APPEND X Y)
    (listform (COND ((NULL X) Y)
                    ((QUOTE T) (CONS (CAR X) (APPEND (CDR X) Y))))))

;---------------------------------------------------------------
; PAIR
;
; (PAIR (QUOTE (<s1> ... <sn>)) (QUOTE (<t1> ... <tn>))) =>
;       ((<s1> <t1>) ... (<sn> <tn>))
;
;---------------------------------------------------------------

(define (PAIR X Y)
  (listform
    (COND ((AND (NULL X) (NULL Y)) (QUOTE NIL))
          ((AND (NOT (ATOM X)) (NOT (ATOM Y)))
                               (CONS (LIST (CAR X) (CAR Y))
                                     (PAIR (CDR X) (CDR Y)))))))

;---------------------------------------------------------------
; ASSOC
;
; ASSOC returns the "value" of variable X in "association LIST" y.
; for example,
;
;  (ASSOC (QUOTE (X)) (QUOTE ((W (A B)) (X (C D)) (Y (E F)))))
;
; returns (C D).
;
; If variable is NOT "stored" in association LIST, then there
; will be error in attempt to find CAAR of empty list.

(define (ASSOC X Y)
  (let((X (dotform X))
       (Y (listform Y)))
     (when (or (= X 'F) (= X 'T))
           (throw-error "ASSOC CALLED WITH WRONG ARGUMENT."))
     (listform (COND ((AND (ATOM Y)
                           (EQ Y (QUOTE NIL)))
                           (throw-error (string "ASSOC " X " in "
                                                Y " is impossible.")))
                     ((EQ (CAR (CAR Y)) X) (CAR (CDR (CAR Y))))
                     ((QUOTE T) (ASSOC X (CDR Y)))))))

;---------------------------------------------------------------
; APPQ
;
; (APPQ (QUOTE (<expr1> ... <exprn>)))
;
;                        ===> ((QUOTE <expr1>)...(QUOTE <exprn>))
;---------------------------------------------------------------

(define (APPQ m)
     (listform (COND ((NULL m) (QUOTE NIL))
                     ((QUOTE T) (CONS (LIST (QUOTE QUOTE) (CAR m))
                                      (APPQ (CDR m)))))))

;---------------------------------------------------------------
; EVAL, EVCON, EVLIS
;---------------------------------------------------------------

 (define (EVLIS m a)
     (listform (COND ((NULL m)  (QUOTE NIL))
                     ((QUOTE T) (CONS (EVAL (CAR m) a)
                                      (EVLIS (CDR m) a))))))

(define (EVCON c a)
            (COND ((EVAL (CAR (CAR c)) a) (EVAL (CAR (CDR (CAR c)))
                                                 a))
                  ((QUOTE T)         (EVCON (CDR c) a))))

(define (EVAL e a)
  (listform
    (COND ((ATOM e) (listform (ASSOC e a)))
          ;----------------------------
          ((ATOM (CAR e))
              ;----------------------------
              (COND ((EQ (CAR e) (QUOTE QUOTE.1))
                         (CAR (CDR e)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE ATOM.1))
                         (ATOM (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE EQ.1))
                         (EQ (EVAL (CAR (CDR e)) a)
                             (EVAL (CAR (CDR (CDR e))) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE COND.1)) (EVCON (CDR e) a))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE AND.1))
                         (EVAL (CONS (QUOTE COND.1)
                                     (CONS (CDR e)
                                           (QUOTE (((QUOTE.1 T)
                                                    (QUOTE.1 F))))))
                               a))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CAR.1))
                                 (CAR (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CDR.1))
                         (CDR (EVAL (CAR (CDR e)) a)))
                    ;----------------------------
                    ((EQ (CAR e) (QUOTE CONS.1))
                         (CONS (EVAL (CAR (CDR e)) a)
                               (EVAL (CAR (CDR (CDR e))) a)))
                    ;----------------------------
                    ((QUOTE T) (EVAL (listform (CONS (ASSOC (CAR e) a)
                                                            (CDR e)))
                                     a))))
          ;----------------------------
          ((EQ (CAR (CAR e)) (QUOTE LABEL.1))
               (EVAL (listform (CONS (CAR (CDR (CDR (CAR e))))
                                     (CDR e)))
                     (listform (CONS (LIST (CAR (CDR (CAR e)))
                                     (CAR e))
                     a))))
          ;----------------------------
          ((EQ (CAR (CAR e)) (QUOTE LAMBDA.1))
            (EVAL (listform (CAR (CDR (CDR (CAR e)))))
                  (listform (APPEND (PAIR (CAR (CDR (CAR e)))
                                          (EVLIS (CDR e) a)) a)))))))

(debug-wrap EVAL)

(eval (expand '(EVAL (QUOTE (EVAL.1 (QUOTE.1 ((LAMBDA.2 (XX)
                             (CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
                                              (QUOTE.2 somedata)))
                                    (QUOTE.1 ())
                            )
                     )
                     McCarthy-60-interpreter
               )

               'McCarthy-60-interpreter
      )
)

(exit)


---------------------------------------------------------------
McCarthy-60 Lisp in McCarthy-60 Lisp in ... in McCarthy-60 Lisp
---------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2010/09/mccarthy-60-lisp-in-mccarthy-60-lisp-in.html

; In this article, I'll show how John McCarthy's Lisp can be interpreted
; in McCarthy's Lisp, which is interpreted in McCarthy's Lisp ...
; and so on, n times.
;
; One of the reasons for harder understanding of early Lisps is
; McCarthy's decision to use same identifiers for Lisp implemented
; in machine code, and for Lisp interpreted by EVAL function.
;
; For example, if McCarthy-60 Lisp expression
;
;
;    (EVAL (QUOTE ((LAMBDA (XX) (CONS XX (CONS XX (QUOTE ()))))
;                  (QUOTE somedata)))
;          (QUOTE ()))
;
;
; is evaluated, the first and the last oocurences of QUOTE are
; evaluated as special operators defined in base language (in my
; case Newlisp, in original implementation it was machine code),
; while second and third occurence of QUOTE are interpreted
; following the rules defined in John McCarthy-60 EVAL function.
;
; McCarthy's decision isn't incorrect, but using slightly
; different symbols is not wrong either and it certainly contributes
; to easier understanding. In second article I redefined EVAL so
; it evaluates expressions containing symbols like CONS.1, QUOTE.1
; ... for example:
;
;
;  (EVAL (QUOTE ((LAMBDA.1 (XX) (CONS.1 XX (CONS.1 XX (QUOTE.1 ()))))
;                (QUOTE.1 somedata)))
;        (QUOTE ()))
;
;
; If we can define LAMBDA.1, QUOTE.1, ... then, why not EVAL.1 as well?
;
; That definition was described in previous article on this topic. It is very
; dry and formal definition, because definition of EVAL.1, and
; all needed helper functions should be written in limited McCarthy-60
; Lisp EVAL interpreter, and given to EVAL in the form of quoted
; association list.
;
;
;  (EVAL <quoted expression to be evaluated>
;        <quoted association list>             ;<======= HERE
;  )
;
;
; If quoted association list is named McCarthy-60-interpreter.1,
; then example of such expressions is
;
;
; (EVAL (QUOTE (EVAL.1 (QUOTE.1 ((LAMBDA.2 (XX)
;                                  (CONS.2 XX (CONS.2 XX (QUOTE.2 ()))))
;                                (QUOTE.2 somedata)))
;                                     (QUOTE.1 ())
;                             )
;                      )
;        <McCarthy-60-interpreter.1>
;        )
;
;
; This is how McCarthy-60-interpreter.1 looks like:
; (McCarthy-60-Lisp in Newlisp library first.)

(load (append "http://www.instprog.com/McCarthy-60-LISP/"
              "McCarthy-60-LISP-in-Newlisp.lsp"))

(setf McCarthy-60-interpreter.1

 '(QUOTE

    (
      ;-------------------------
      (EVAL.1 (LABEL.1 EVAL.1
         (LAMBDA.1 (e a)
            (COND.1
               ((ATOM.1 e) (ASSOC.1 e a))
               ;-------------------------
               ((ATOM.1 (CAR.1 e))

                (COND.1

                    ((EQ.1 (CAR.1 e) (QUOTE.1 QUOTE.2))
                           (CAR.1 (CDR.1 e)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 ATOM.2))
                           (ATOM.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 EQ.2))
                           (EQ.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                         a)
                                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                         a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 COND.2))
                           (EVCON.1 (CDR.1 e) a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 AND.2))
                       (EVAL.1 (CONS.1 (QUOTE.1 COND.2)
                                  (CONS.1 (CDR.1 e)
                                     (QUOTE.1 (((QUOTE.2 T)
                                                (QUOTE.2 F))))))
                               a))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CAR.2))
                           (CAR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CDR.2))
                           (CDR.1 (EVAL.1 (CAR.1 (CDR.1 e)) a)))
                    ;-------------------------
                    ((EQ.1 (CAR.1 e) (QUOTE.1 CONS.2))
                           (CONS.1 (EVAL.1 (CAR.1 (CDR.1 e))
                                           a)
                                   (EVAL.1 (CAR.1 (CDR.1 (CDR.1 e)))
                                           a)))
                    ;-------------------------
                    ((QUOTE.1 T) (EVAL.1 (CONS.1 (ASSOC.1 (CAR.1 e)
                                                          a)
                                                 (CDR.1 e))
                                         a))))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LABEL.2))
                    (EVAL.1 (CONS.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                                    (CDR.1 e))
                            (CONS.1 (LIST.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                            (CAR.1 e))
                                    a)))
               ;-------------------------
               ((EQ.1 (CAR.1 (CAR.1 e)) (QUOTE.1 LAMBDA.2))
                 (EVAL.1 (CAR.1 (CDR.1 (CDR.1 (CAR.1 e))))
                         (APPEND.1 (PAIR.1 (CAR.1 (CDR.1 (CAR.1 e)))
                                           (EVLIS.1 (CDR.1 e) a))
                                   a)))

       ))))
      ;-------------------------
      (APPEND.1 (LABEL.1 APPEND.1
         (LAMBDA.1(X Y)
            (COND.1 ((NULL.1 X) Y)
               ((QUOTE.1 T)
                   (CONS.1 (CAR.1 X) (APPEND.1 (CDR.1 X) Y)))))))
      ;-------------------------
      (ASSOC.1 (LABEL.1 ASSOC.1
         (LAMBDA.1 (X Y)
            (COND.1
               ((EQ.1 (CAR.1 (CAR.1 Y)) X) (CAR.1 (CDR.1 (CAR.1 Y))))
               ((QUOTE.1 T)                (ASSOC.1 X (CDR.1 Y)))))))
      ;-------------------------
      (PAIR.1 (LABEL.1 PAIR.1
         (LAMBDA.1 (X Y)
            (COND.1 ((AND.1 (NULL.1 X) (NULL.1 Y)) (QUOTE.1 NIL))
                    ((AND.1 (NOT.1 (ATOM.1 X)) (NOT.1 (ATOM.1 Y)))
                            (CONS.1 (LIST.1 (CAR.1 X) (CAR.1 Y))
                                    (PAIR.1 (CDR.1 X) (CDR.1 Y))))))))
      ;-------------------------
      (EVLIS.1 (LABEL.1 EVLIS.1
         (LAMBDA.1 (m a)
            (COND.1 ((NULL.1 m)  (QUOTE.1 NIL))
                    ((QUOTE.1 T) (CONS.1 (EVAL.1 (CAR.1 m) a)
                                         (EVLIS.1 (CDR.1 m) a)))))))
      ;-------------------------
      (EVCON.1 (LABEL.1 EVCON.1
         (LAMBDA.1 (c a)
            (COND.1 ((EVAL.1 (CAR.1 (CAR.1 c)) a)
                             (EVAL.1 (CAR.1 (CDR.1 (CAR.1 c))) a))
                    ((QUOTE.1 T)
                             (EVCON.1 (CDR.1 c) a))))))
      ;-------------------------
      (NULL.1 (LAMBDA.1 (X)
                 (AND.1 (ATOM.1 X) (EQ.1 X (QUOTE.1 NIL)))))
      ;-------------------------
      (NOT.1 (LAMBDA.1 (X)
                 (COND.1 (X          (QUOTE.1 F))
                         ((QUOTE.1 T)(QUOTE.1 T)))))
      ;-------------------------
      (LIST.1 (LAMBDA.1 (X Y) (CONS.1 X (CONS.1 Y (QUOTE.1 NIL)))))

    )
  )
)

; variable McCarthy-60-interpreter.1 cannot be used directly. It
; has to be replaced with its value first.
;
; Once McCarthy-60-interpreter.1 is defined, it is easy to generalize
; it and define McCarthy-60-interpreter.2, McCarthy-60-interpreter.3,...
; Just respective indexes should be changed.
;
; Here is Newlisp function that calculate these interpreters, for
; given n:

(define (McCarthy-60-interpreter n)

  (if (= n 1)

      McCarthy-60-interpreter.1

      (letn((symbols-in-McCarthy-60-interpreter.1
                  (difference (unique (flat McCarthy-60-interpreter.1))
                              '(T F NIL)))

            (assoc-list1
               (map (lambda(x)
                      (list x
                           (if (find x '(QUOTE e a X Y m c))

                               (sym (append "°"
                                            (string x)
                                            "."
                                            (string (- n 1))))

                               (let ((parsed-x (parse (string x) ".")))

                                   (case (last parsed-x)
                                     ("1" (sym (append "°"
                                                 (first parsed-x)
                                                  "."
                                                 (string n))))
                                     ("2" (sym (append "°"
                                                 (first parsed-x)
                                                  "."
                                                 (string (+ n 1))))))))))

                     symbols-in-McCarthy-60-interpreter.1))

             (assoc-list2
                (map (lambda(x)
                        (list (last x) (sym (rest (string (last x))))))
                     assoc-list1)))

              (local(result)
                (setf result (expand McCarthy-60-interpreter.1
                                     assoc-list1))

                (setf result (expand result assoc-list2))

                result))))

; And this is an example how these interpreters could be used

(setf McCarthy-60-interpreter.2 (McCarthy-60-interpreter 2))

(debug-wrap EVAL)

                  (eval
                    (expand
                      '(EVAL
                         (QUOTE
                           (EVAL.1
                             (QUOTE.1
                               (EVAL.2
                                 (QUOTE.2
                                   (QUOTE.3 somedata))
                                 (QUOTE.2 ())
                               )
                             )
                             McCarthy-60-interpreter.2
                           )
                         )
                         McCarthy-60-interpreter.1
                       )

                      'McCarthy-60-interpreter.1
                      'McCarthy-60-interpreter.2
                    )
                  )

; McCarthy's EVAL is, however, very inefficient - its purpose was
; purely theoretical, so, if you want to really evaluate this simple
; expression prepare yourself on long waiting. (Less than one hour
; on modern PC, however.)


-----------------------------------
On Pitman's "Special forms in Lisp"
-----------------------------------
http://kazimirmajorinc.blogspot.com/2010/10/on-pitmans-special-forms-in-lisp.html

1. Introduction
---------------
It appears that during last few years controversial concept of fexprs is actualized in Lisp community. Newlisp and Picolisp, two small, dynamically scoped Lisps supporting fexprs are actively developed and respective communities slowly, but consistently, grow. Fexprs are frequently discussed on authoritative Lambda the Ultimate web site, passionately advocated by Schemers Thomas Lord and Ray Dillinger. Related links and discussions appear in other Internet forums and blogs. Recently, John Shutt published Ph.D. thesis on programming language Kernel, his attempt to extend Scheme with fexprs, while keeping lexical scope. Shutt's ideas attracted significant attention and few efforts for implementation are reported.

On the first sight, fexprs are elegant and powerful feature. The reason for their discontinuation in most important Lisp dialects is not obvious. According to Christian Quiennec, fexprs were „put to death“ by Kent Pitman who in his 1980 conference presentation „Special Forms in Lisp“

„suggested that, in the design of future Lisp dialects, serious consideration be given to the proposition that FEXPR's should be omitted from the language altogether.“
Pitman's opinion was representative:

„It is widely held among members of the MIT Lisp community that FEXPR, NLAMBDA, and related concepts could be omitted from the Lisp language with no loss of generality and little loss of expressive power, and that doing so would make a general improvement in the quality and reliability of program-manipulating programs.“
The presentation “Special forms in Lisp” covers many fexpr related issues. Unfortunately, some relevant properties of fexprs could be misunderstood or omitted.

2. Importance of Fexprs
-----------------------
It appears that Pitman's conclusion cited above is more result of the counting small and practical pros and cons of fexprs than making of “the big picture.” And that is exactly where fexprs shine. That argument is expressed on particularly strong and inspiring way by Smalltalk designer Alan Kay :

„I could hardly believe how beautiful and wonderful the idea of LISP was. I say it this way because LISP had not only been around enough to get some honest barnacles, but worse, there were deep flaws in its logical foundations. By this, I mean that the pure language was supposed to be based on functions, but its most important components -- such as lambda expressions, quotes, and conds -- were not functions at all, and instead were called special forms ... My next questions was, why on Earth call it a functional language? Why not just base everything on FEXPRs and force evaluation on the receiving side when needed? I could never get a good answer...“
Fexprs really do add to the generality of the language, on particularly interesting way – by exposing the most important elements of Lisp language to processing as a first class objects, during runtime, like functions and other data are processed.

Furthermore, fexprs can replace both functions and macros, making Lisp not only more general, but also conceptually simpler, with more regular semantics. The implementation of Lisp can be, at least theoretically, smaller. Even the number of basic, built-in fexprs can be reduced, since quote is equivalent to (lambda-fexpr(x)x), if lambda-fexpr is, conveniently, fexpr version of lambda.

3. Expandability of Fexprs
--------------------------
Second, comparison of macros and fexprs is done in “macros in general” vs “fexprs in general” fashion. In such comparison, all macros have some desirable properties that all fexprs cannot have. Pitman wrote:

Perhaps the most important reason why macro's are important is that they offer transparency of functionality. It is possible, without evaluating the macro form, to determine what the form will do in terms of primitive lisp operations. This is true because the macro definition need not be invoked only by the evaluator.
That means, macros are expandable during compile time. Particularly, expansion allows "code walking" and various optimizations during compile time. Unlike macros, in general case, fexprs cannot be expanded at all, let alone before runtime. However, comparison is not fair, because fexprs in general are more expressive than macros in general. The macros should be compared with fexprs that could be used as an alternative.

For a given macro M, defined with

(define-macro (M v1 ...  vn) _ _ _)

we can easily define associated macro-like fexpr with

(define-fexpr (F v1 ...  vn)(eval (begin _ _ _))).

Fexpr F is equivalent to macro M in following sense: every program P that uses M, and the program P[F/ M], obtained by replacement of M with F evaluate to same result. Furthermore, if F is macro-like fexpr equivalent to macro M, we can define expansion of fexpr call (F ... ) as expansion of macro call (M ... ). Macro-like fexpr calls can be expanded during compiling, and expansion can be used in “code walkers” as well. It could be said that macros are equivalent to one class of fexprs that can be inlined and optimized during compile time.

typical macro:

(define-macro (ifnt condition
                   else-branch
                   then-branch)
  `(if ,condition
       ,then-branch
       ,else-branch))

typical fexpr:

(define-fexpr (ifnt condition
                    else-branch
                    then-branch)
    (if (eval condition)
        (eval then-branch)
        (eval else-branch))

macro-like fexpr:

(define-fexpr (ifnt condition
                    else-branch
                    then-branch)
   (eval `(if ,condition)
              ,then-branch
              ,else-branch)))

Possible objection is that compiler cannot know that particular fexpr is not used as the first class object. But programmer can do that; he only needs to recognize that fexpr can be implemented as macro. It is sound approach: programmer, generally, knows more than it can be deduced from the code he wrote. Another possible objection is that, if fexprs are used as macros, the advantage of the fexprs is lost. It is true if programmer limits himself on macro-like fexprs. But, he can also use more general fexprs – if loss of "transparence of functionality" is acceptable.

Assuming that compiler can optimize fexprs on described – indeed, very simple way – then, for every program that uses macros, there is equivalent and equally fast program that uses fexprs instead of macros. Inverse is not true. Neither one macro can replace fexpr in programs that use fexpr as the first class value. Rare Lisp dialects support the first class macros (not fexprs!), but these are not discussed here.

4. The Price of Macro Expansion
-------------------------------
Third, although Pitman warned that macro expansion is space-demanding, the possibility that macro expansion can be time-demanding was not discussed. Usually, time required for macro-expansion is not important, because expansion is done only once, before compiling, and after that, the program is used in executable form only. However, Lisp, perhaps more than other languages, is designed to be used for generation of the code during runtime. Generated code can be evaluated using eval; in that case, macro calls are expanded during runtime. Slightly less obviously, if program generates lambda-expressions and compile (convert, coerce) these in form that can be “applied” or “funcalled” then expansion during runtime is unavoidable, even if eval isn't explicitly used.

The problem of macro expansion during runtime was known in Lisp community and some efforts were invested in solving it. See “Evolution of Lisp” for discussion. The problem can be avoided if non-expanding fexprs are used instead of macros. Surprisingly, that comparative advantage of fexprs is not well described in literature. Pitman doesn’t discuss it. Few years later, Z. Lichtman reported moderate slowdown (15%) if macros are used instead of fexprs. As shown in some earlier posts, the price can be higher.

It can be confusing that I wrote about expandable fexprs, and now, I claim that fexprs benefit from non-expanding. There is no single fexpr alternative to given macro; there are many of these. Some are expandable, and others are not.

For instance, take a look on fexpr at-least, generalized or, such that

(at-least e0 e1 ... en)

is true if and only if, well, at least e0 of expressions e1, ..., en evaluate to true. There are many ways this fexpr can be defined – some of these expand, and others do not. For instance, the first of the following two fexprs (slightly changed Newlisp) doesn’t expand, and second expands - and expansion can be done before runtime:

(define-fexpr (at-least n)
      (let ((en (eval n)))
           (doargs(i (zero? en))
                  (when (eval i)
                        (dec en)))
           (zero? en)))

(define-fexpr (at-least n)
  (eval (let ((central (cons 'or
                         (map (lambda(x)(list 'and
                                              x
                                              '(inc counter)
                                              '(= counter n)))
                              (args)))))
               (expand '(let((counter 0))
                            central
                            (= counter n))
                       'central 'n))))

As a side note (because that issue is not discussed in “Special forms”) careless use of fexprs, just like careless use of macros, might result in accidental overshadowing of variables. The solutions are similar (i.e. using gensyms or some kind of predefined “hygiene”). Shutt's approach is novel.

In “Special forms” the technique of wrapping macro around function for reduction of size of the expanded code is described:

(DEFUN f FEXPR (var) . body) =>

(DEFUN f MACRO (FORM)
       (LIST 'EXPR-f
             (LIST 'QUOTE (CDR FORM))))

(DEFUN EXPR-f (var) . body)

The same technique can improve speed of macro expansion of the code during runtime; it alleviates the problem, but doesn’t solve it completely.

5. Conclusions
--------------
Although Pitman's article contains number of valid arguments, including some in favour of fexprs - three important arguments seem to be omitted:

  1. Lisp with fexprs has simpler, more regular and more expressive semantics than Lisp with functions, with or without macros.
  2. The existance of expandable, macro-like fexprs is not recognized. For every macro, there is equivalent expandable, macro-like fexpr with same desirable properties. Particularly, if simple optimization of expandable fexprs is applied, for every program that uses macros there is at least equally fast equivalent program that uses fexprs.
  3. In some cases, the programs using fexprs are much faster than programs using macros.

These claims constitute strong case for fexprs, particularly because one of the main arguments against fexprs was their influence on the speed of the programs.

References
----------
Kay A., The early history of Smalltalk, in: Bergin, Jr., T.J., and Gibson, R. G., History of Programming Languages - II, ACM Press, New York, and Addison-Wesley Publ. Co., Reading 1996, pp. 511-78.
Burger A., The Picolisp reference, retrieved 25 October 2010.
Jaffer A., SCM, Scheme implementation, retrieved 25 October 2010.
Lichtman Z., Sometimes an FEXPR is better than a macro, ACM SIGART Bulletin archive, Issue 97, July 1986, pp. 20-2.
Majorinc K., Challenged By Common Lispers,  On macro expansion, EVAL and generated Code, Symbols as S-exprs and hygienic FEXPRs, posts on kazimirmajorinc.blogspot.com
Mueller L., Newlisp user manual and report, the post on newlisp.org, retrieved 25 October 2010.
Pitman K., Special forms in Lisp, Conference Record of the 1980 Lisp Conference, Stanford University, August 25-27, 1980.
Queineec, C., Lisp in small pieces, Cambridge University press, Cambridge, 1996.
Shutt J. N., Abstraction in programming -- working definition, Worcester Polytechnic Institute, Worcester, 1999.
Shutt J. N., S-expressiveness and the abstractive power of programming languages, W orcester Polytechnic Institute, Worcester, 1999.
Shutt J. N., Revised-1 report on the Kernel programming language, Worcester Polytechnic Institute, Worcester, 2009. retrieved 25 October 2010.
Shutt J. N., Fexprs as the basis of Lisp function application or $vau: the ultimate abstraction, Worcester Polytechnic Institute, Worcester, 2010.
Steele, G. L., Gabriel, R. P., The evolution of Lisp, extended version, retrieved 25 October 2010.


---------------------------
Lambda Calculus Interpreter
---------------------------
http://kazimirmajorinc.blogspot.com/2010/12/lambda-calculus-interpreter.html

Later edit: there is newer, improved version of this interpreter, check
this post (http://kazimirmajorinc.blogspot.com/2011/01/lambda-calculus-interpreter-2.html) and few posts before that.

; Lambda calculus implemented in Newlisp. It would be too ambitious
; to explain what is lambda calculus in this post, so I'll assume
; that reader familiarized himself with notion of lambda calculus
; somewhere else, and I'll provide only code for evaluation ("reduction")
; of lambda-expressions. Instead of lambda symbol, I'll use ^ -
; and it was original symbol used by Church.

; Only beta-reduction (but this is only important one) and normal
; order evaluation (better one, used for Haskell and fexprs) - from
; outside to inside implemented.

(set 'is-variable (lambda(x)(symbol? x)))

(set 'is-function (lambda(L)(and (list? L)
                                 (= (first L) '^)
                                 (= (nth 2 L) '.))))

(set 'function-variable (lambda(f)(nth 1 f)))
(set 'function-body (lambda(f)(last f)))

(set 'is-application (lambda(L)(and (list? L)
                                    (= (length L) 2))))

(set 'substitute-free-occurences ; of variable V in E with F
     (lambda(V E F)
       (cond ((is-variable E) (if (= E V) F E))

             ((is-function E)

                  (if (= (function-variable E) V)

                      E ; V is bounded in E - no substitution

                      (list '^
                            (function-variable E)
                            '.
                            (substitute-free-occurences V
                                   (function-body E)
                                   F))))
              ((is-application E)
               (list (substitute-free-occurences V (first E) F)
                     (substitute-free-occurences V (last E) F))))))

(set 'reduce-once
     (lambda(E)
        (cond ((is-variable E) E)
              ((is-function E) E)
              ((is-application E)
                (let ((E1 (first E))
                      (E2 (last E)))
                (if (is-function E1)
                    ;E=((^V._) E2) ==> E10[V:=E2]
                    (substitute-free-occurences (function-variable E1)
                                                (function-body E1)
                                                E2)

                     ;E=(E1 E2) ==>
                     (let ((new-E1 (reduce-once E1)))
                           (if (!= new-E1 E1)
                               (list new-E1 E2)
                               (list E1 (reduce-once E2))))))))))

(set 'reduce (lambda(new-expression)
                (local(expression)
                  (println "\n--------------\n\n" (string new-expression))
                  (do-while (!= new-expression expression)
                            (setf expression new-expression)
                            (setf new-expression (reduce-once expression))
                            (if (!= new-expression expression)
                                (println " ==> " (string new-expression))
                                (println "\n     Further reductions are impossible."))
                new-expression))))

; The list of reduced expressions

(dolist (i '( x
             (^ x . x)
             ((^ x . x) y)
             ((^ x . a) ((^ y . y) z))
             ((^ y . (^ z . z)) ((^ x . (x x)) (^ v . (v v))))
             ((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . x))) a) b)
             ((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . y))) a) b)
             ; (^ f . ((^ x . (f (x x))) (^ x . (f (x x))))) Y-combinator - test it!
             ((^ x . (x x)) (^ x . (x x)))
             ;((^ x . (x (x x))) (^ x . (x (x x))))
             ))

   ;(println "\n\n=== " (+ $idx 1) ": "  i "\n\n")

   (reduce i))

(exit)

                                      OUTPUT

--------------

x

     Further reductions are impossible.

--------------

(^ x . x)

     Further reductions are impossible.

--------------

((^ x . x) y)
 ==> y

     Further reductions are impossible.

--------------

((^ x . a) ((^ y . y) z))
 ==> a

     Further reductions are impossible.

--------------

((^ y . (^ z . z)) ((^ x . (x x)) (^ v . (v v))))
 ==> (^ z . z)

     Further reductions are impossible.

--------------

((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . x))) a) b)
 ==> (((^ t . (^ f . (((^ x . (^ y . x)) t) f))) a) b)
 ==> ((^ f . (((^ x . (^ y . x)) a) f)) b)
 ==> (((^ x . (^ y . x)) a) b)
 ==> ((^ y . a) b)
 ==> a

     Further reductions are impossible.

--------------

((((^ v . (^ t . (^ f . ((v t) f)))) (^ x . (^ y . y))) a) b)
 ==> (((^ t . (^ f . (((^ x . (^ y . y)) t) f))) a) b)
 ==> ((^ f . (((^ x . (^ y . y)) a) f)) b)
 ==> (((^ x . (^ y . y)) a) b)
 ==> ((^ y . y) b)
 ==> b

     Further reductions are impossible.

--------------

((^ x . (x x)) (^ x . (x x)))

     Further reductions are impossible.


---------------------------
Expansion of Free Variables
---------------------------
http://kazimirmajorinc.blogspot.com/2010/12/expansion-of-free-variables.html

; The function "expand" is a Newlisp version of mathematical operation
; of the substitution. It is very useful function. For example,
; in code
;
;               (setf 'x 'new-variable)
;               (expand '(lambda(x y)(print x)) 'x)
;
;   ===>        (lambda (new-variable y) (print new-variable))
;
; Newlisp "expands" all occurences of the symbol x with symbol
; new-variable.
;
; However, it is not always convenient to apply substitution on
; all occurences. For example, let us assume that you want to
; write interpreter for some other dialect of Lisp in Newlisp.
; That interpreter should be able to compute expressions like
;
;      ((lambda(x)(+ x (* 2 x) (let((x 5))(* x x)))) 3).
;
; It can be accompplished by substituting argument of the function (3)
; on place of parameter of the function (x) of the body of the
; function
;               (+ x (* 2 x) (let((x 5))(* x x))).
;
; However, the substitution is needed only for first two occurences
; of x, while not for third, fourth and fifth occurence - these
; occurences are not "free", they are "bounded."
;
; I defined expand-free-variable function so it recognizes few most
; important ways for binding of the variables: lambda, lambda-macro,
; local, let, letn and letex. As many of these operations are
; "polymorphic", only the most basic form is supported. It turned
; to be relatively hard to write, because almost every binding
; operator, every form of it, requires slightly different code.

(set 'function-parameters (lambda(f)(first f)))
(set 'function-body (lambda(f)(rest f)))

(set 'expand-free-variables
  (lambda(E)
    (let ((vars-to-expand (args)))

         (cond ((symbol? E) (eval (append '(expand)
                                           (map quote (list E))
                                           (map quote vars-to-expand))))

               ;------------------------------------------------

               ((or (lambda? E)
                    (macro? E))

                    (letn((new-vars-to-expand
                             (difference vars-to-expand
                                         (function-parameters E)))

                          (new-expand-function
                             (append (lambda(expr))
                                (list (append '(expand-free-variables expr)
                                               (map quote new-vars-to-expand))))))

                         (append (cond ((lambda? E) '(lambda))
                                       ((macro? E) '(lambda-macro)))

                                 (list (function-parameters E))

                                 (map new-expand-function
                                      (function-body E)))))

                ;-----------------------------------------------

                ((and (list? E)
                      (starts-with E 'local))

                    (letn((new-vars-to-expand (difference vars-to-expand
                                                          (nth 1 E)))

                         (new-expand-function
                           (append (lambda(expr))
                             (list (append '(expand-free-variables expr)
                                            (map quote new-vars-to-expand))))))

                         (append '(local)
                                  (list (nth 1 E))
                                  (map new-expand-function
                                       (rest (rest E))))))

                ;-----------------------------------------------

                ((and (list? E)
                      (or (starts-with E 'let)
                          (starts-with E 'letn)
                          (starts-with E 'letex)))

                     (letn((new-vars-to-expand
                              (difference vars-to-expand
                                          (map first (nth 1 E))))

                           (new-expand-function
                              (append (lambda(expr))
                                 (list (append '(expand-free-variables expr)
                                                (map quote new-vars-to-expand))))))

                         (append (cond ((starts-with E 'let) '(let))
                                       ((starts-with E 'letn) '(letn))
                                       ((starts-with E 'letex) '(letex)))

                                  (list (first (rest E)))
                                  (map new-expand-function
                                       (rest (rest E))))))

               ;------------------------------------------------

               ((list? E)(let((new-expand-function
                                (append (lambda(expr))
                                  (list (append '(expand-free-variables expr)
                                                 (map quote vars-to-expand))))))

                              (map new-expand-function E)))

               ;------------------------------------------------

               ((or (number? E)
                    (string? E))
                    E)

               ;------------------------------------------------

               ((quote? E)
                (list 'quote (eval (append '(expand-free-variables)
                                            (list (list 'quote (eval E)))
                                            (map quote vars-to-expand)))))

               ;------------------------------------------------

               (true (println "Expand for " E " is not defined.\n")
                     (throw-error "expand isn't defined."))))))



;                     FEW TESTS


(setf x 1 y 2 z 3 v 4 w 5)
(println (expand-free-variables '(local(x y z)x y z v w 7) 'x 'v))

; (local (x y z)
;  x y z 4 w 7)

(println (expand-free-variables '('('(x)) '('(z)) '''y (local(x)x y)) 'x 'y))

; ((quote ((quote (1)))) (quote ((quote (z)))) (quote (quote (quote 2)))
;  (local (x)
;   x 2))
;

(println (expand-free-variables '(lambda(x a y) x b z) 'x 'y 'z 'w))

; (lambda (x a y) x b 3)

(setf x 'new-variable)
(println (expand-free-variables (list 'x '(lambda(x y)(print x))) 'x))

; (new-variable
;  (let ((x 3))
;   (x even-newer-variable
;    (letex ((y 4)) y))))
;

(setf x 'new-variable y 'even-newer-variable)
(println (expand-free-variables '(x (let((x 3)) (x y (letex((y 4))y)))) 'x 'y))

; (lambda (x a y) x b 3)

(exit)

---------------------------------------------------
Do You Need Five Hundred Random Lambda-Expressions?
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/do-you-need-five-hundred-random-lambda.html

; Just in case ...
;
; Newlisp source:

(set 'random-var (lambda(nvars)(sym (char (+ 97 (rand nvars))))))

; (random-^-expr nvars nocc) returns random lambda-expression
; with at most nvars variables in total of exactly nocc occurences

(set 'random-^-expr
   (lambda(nvars nocc)
      (cond ((= nocc 1) (random-var nvars))
            ((> nocc 1)
             (amb (let ((r (+ (rand (- nocc 1)) 1)))
                       (list (random-^-expr nvars r)
                             (random-^-expr nvars (- nocc r))))
                  (list '^
                        (random-var nvars)
                        '.
                        (random-^-expr nvars (- nocc 1))))))))

(set 'pretty-form
   (lambda(t)
      (replace " . " (replace "^ " (replace ") (" (string t) ")(") "^") ".")))

(for(nvars 1 25 1)
  (for(nocc 1 20 1)
       (println (pretty-form (random-^-expr nvars nocc)))))

(exit)

Nota: per vedere l'output aprire il file "500lambda.txt" nella cartella "data".


------------------------------------------------
In Search for The Irreducible Lambda-Expressions
------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/in-search-for-irreducible-lambda.html

; In last post, I wrote the program that generates random lambda
; expressions, 500 of these. This is the program that generates
; roughly 3500000 random lambda expressions, then attempts to
; reduce these, and makes list of lambda-expressions such that
; reduction to normal form failed. There are two different kinds of
; lambda-expressions on that list:
;
;  (i)  the program proves that reductions fail to terminate, i.e.
;       lambda-expression is reduced to the form that is further
;       reduced to itself.
;
;  (ii) the program doesn't prove that reductions fail to terminate
;       generally, but it shows that after n (in our case 25)
;       reductions the lambda expression is still not in normal
;       form.
;
; The lambda expressions on the list are normalized, i.e. two lambda
; expressions are considered to be equivalent if there is
; alpha-conversion that transform one expression in the other.
; For example, there is alpha-conversion from (^ x . x) to (^ y . y).
;
; The results are at the bottom of the post. If you decide to try
; the program, be patient, it might need one hour of time. If
; you want it to run faster, change the constant in line
;
;              (dotimes(dummy 200000) ...

(setf [println.supressed] true [print.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(setf [println.supressed] nil [print.supressed] nil)

;---------------------------------------------------------------
; is-variable, is-function and is-application are predicated
; that return true or false

(set 'is-variable (lambda(x)(symbol? x)))

(set 'is-function (lambda(L)(and (list? L)
                                 (= (first L) '^)
                                 (= (nth 2 L) '.))))

(set 'is-application (lambda(L)(and (list? L)
                                    (= (length L) 2))))

;---------------------------------------------------------------
; function-variable and function-body return parts of the
; lambda-expression. For example
;
;       (function-variable '(^ x . (x x))) returns x
;       (function-body '(^ x . (x x))) returns (x x)

(set 'function-variable (lambda(f)(nth 1 f)))
(set 'function-body (lambda(f)(last f)))

;---------------------------------------------------------------
;
; (substitute-free-occurences V E F)
;
; Substitutes free occurences of variable V in expression E with F.
; Don't change bounded occurences of the variable.

(set 'substitute-free-occurences ; of variable V in E with F
     (lambda(V E F)
       (cond ((is-variable E) (if (= E V) F E))

             ((is-function E)
                  (if (= (function-variable E) V)

                      E ; V is bounded in E - no substitution

                      (list '^
                            (function-variable E)
                            '.
                            (substitute-free-occurences V
                                   (function-body E)
                                   F))))

              ((is-application E)
               (list (substitute-free-occurences V (first E) F)
                     (substitute-free-occurences V (last E) F))))))

;---------------------------------------------------------------
;
;                      (reduce-once E)
;
; performs beta-reduction on lambda-expression E. It returns pair
;
;                      (success result)
; where
;
;     success = true or nil, dependently if E is reduced
;     result  = reduced E if reduction is possible
;               original E if reduction is not possible

(set 'reduce-once

     (lambda(E)

        (cond ((is-variable E) (list 'nil E))

              ((is-function E)
               (let((rfb (reduce-once (function-body E))))
                 (if (first rfb) ; success
                     (list 'true (append (chop E)
                                         (list (last rfb))))

                     (list 'nil E))))

              ((is-application E)
                (let ((F (first E))
                      (G (last E)))

                  (if (is-function F)

                      ;E=((^V._) G) ==> E10[V:=E2]

                      (list 'true (substitute-free-occurences (function-variable F)
                                                              (function-body F)
                                                              G))

                       ;E=(F G) ==>

                       (let ((rF (reduce-once F)))

                             (cond ((= (first rF) true)
                                    (list 'true (list (last rF) G)))

                                   ((= (first rF) nil)

                                    (let ((rG (reduce-once G)))

                                         (cond ((= (first rG) true)
                                                (list 'true (list F (last rG))))
                                               ((= (first rG) nil)
                                                (list 'nil (list F G))))))))))))))

; (println= (reduce-once 'a))
; (println= (reduce-once '(a b)))
; (println= (reduce-once '(^ x . x)))
; (println= (reduce-once '((^ x . x) y)))
; (println= (reduce-once '((^ x . y) y)))
;

(set 'pretty-form
   (lambda(t)
      (replace " . " (replace "^ " (replace ") (" (string t) ")(") "^") ".")))

;---------------------------------------------------------------
;                     (bounded-var i)
;
; returns i-th of variables A0, B0, C0, ... A1, B1, C1 ...

(set 'bounded-var
     (lambda(i)(sym (append (char (+ 64 (% i 25)))
                            (string (/ i 25))))))


;---------------------------------------------------------------
; alpha-convert converts expressions, so beta-reduction can be
; performed on the way it is defined.

(set 'init-and-alpha-convert
     (lambda(E)
        (setf bounded-vars-counter 0)
        (alpha-convert E)))

(set 'alpha-convert
     (lambda(E)
        (cond ((is-variable E) E)
              ((is-function E)
               (begin (inc bounded-vars-counter)
                      (let (new-E-1 (bounded-var bounded-vars-counter))

                           (list '^
                                 new-E-1
                                 '.
                                 (expand (alpha-convert (E 3))
                                         (list (list (E 1) new-E-1)))))))

              ((is-application E)
               (list (alpha-convert (E 0))
                     (alpha-convert (E 1)))))))

;---------------------------------------------------------------
;
;      (reduce new-expression reduce-max to-print)
;
; reduces new-expression in at most reduce-max steps, producing
; output if to-print is set to true.
;
; It returs list
;
;            (terminating result result-counter)
;
; where
;
;       terminating = true if further reductions are impossible
;                   = nil  if cyclical reduction is discovered
;                   = undefined if reduction is quited because of
;                     lack of computing resources
;
;       result = last lambda-expression in process
;       result-counter = numbers of derived lambda-expression
;                        before further derivation is canceled
;                        independently of a reason

(set 'reduce
  (lambda(new-expr reduce-max to-print)
    (when to-print
          (println "\n--------------\n\n " (pretty-form new-expr)))

    (let ((reduce-counter 0)
          (terminating 'undefined)
          (result 'undefined)
          (reduce-end nil))

        (setf new-expr (init-and-alpha-convert new-expr))
        (when to-print (println " ==[alpha]==> "
                                (pretty-form new-expr)))

        (until reduce-end
          ;(println "unless loop")
          (letn ((old-expr new-expr)
                 (r (reduce-once old-expr))
                 (reduce-once-succeeded (first r)))

            (cond ((not reduce-once-succeeded)

                   (begin (setf reduce-end true)
                          (setf terminating true)
                          (setf result old-expr)

                          (when to-print
                                (println "\n There are no further reductions"))))

                  (reduce-once-succeeded

                   (begin (inc reduce-counter)
                          (setf new-expr (last r))
                          (when to-print
                                (println " ==[beta " reduce-counter
                                         ".]==> " (pretty-form new-expr)))

                          (setf new-expr (init-and-alpha-convert new-expr))
                          (when to-print
                               (println " ==[alpha]==> " (pretty-form new-expr)))

                          (cond ((= old-expr new-expr)
                                (begin (setf reduce-end true)
                                       (setf terminating nil)
                                       (setf result old-expr)

                                       (when to-print
                                         (println "\n Self-evaluating expression."))))

                               ((>= reduce-counter reduce-max)
                                   (begin (setf reduce-end true)
                                          (setf terminating 'undefined)
                                          (setf result new-expr)
                                          (when to-print
                                            (println "\n Maximal number of the reductions reached."))))))))))
          ;(println= "unless loop ended." old-expr new-expr reduce-end)
          (list terminating result reduce-counter))))

;---------------------------------------------------------------
;
;                  EXAMPLE OF REDUCTION

(reduce '((^ c . (c c)) (^ c . (c (c (^ c . c))))) 15 true)

; --------------
;
;  ((^A0.(A0 A0))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[alpha]==> ((^A0.(A0 A0))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[beta 1.]==> ((^B0.(B0 (B0 (^C0.C0))))(^B0.(B0 (B0 (^C0.C0)))))
;  ==[alpha]==> ((^A0.(A0 (A0 (^A0.A0))))(^C0.(C0 (C0 (^D0.D0)))))
;  ==[beta 2.]==> ((^C0.(C0 (C0 (^D0.D0))))((^C0.(C0 (C0 (^D0.D0))))(^A0.A0)))
;  ==[alpha]==> ((^A0.(A0 (A0 (^B0.B0))))((^C0.(C0 (C0 (^D0.D0))))(^E0.E0)))
;  ==[beta 3.]==> (((^C0.(C0 (C0 (^D0.D0))))(^E0.E0))(((^C0.(C0 (C0 (^D0.D0))))(^E0.E0))(^B0.B0)))
;  ==[alpha]==> (((^A0.(A0 (A0 (^B0.B0))))(^C0.C0))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[beta 4.]==> (((^C0.C0)((^C0.C0)(^B0.B0)))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[alpha]==> (((^A0.A0)((^B0.B0)(^C0.C0)))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[beta 5.]==> (((^B0.B0)(^C0.C0))(((^D0.(D0 (D0 (^E0.E0))))(^F0.F0))(^G0.G0)))
;  ==[alpha]==> (((^A0.A0)(^B0.B0))(((^C0.(C0 (C0 (^C0.C0))))(^E0.E0))(^F0.F0)))
;  ==[beta 6.]==> ((^B0.B0)(((^C0.(C0 (C0 (^C0.C0))))(^E0.E0))(^F0.F0)))
;  ==[alpha]==> ((^A0.A0)(((^B0.(B0 (B0 (^B0.B0))))(^D0.D0))(^E0.E0)))
;  ==[beta 7.]==> (((^B0.(B0 (B0 (^B0.B0))))(^D0.D0))(^E0.E0))
;  ==[alpha]==> (((^A0.(A0 (A0 (^A0.A0))))(^C0.C0))(^D0.D0))
;  ==[beta 8.]==> (((^C0.C0)((^C0.C0)(^A0.A0)))(^D0.D0))
;  ==[alpha]==> (((^A0.A0)((^B0.B0)(^C0.C0)))(^D0.D0))
;  ==[beta 9.]==> (((^B0.B0)(^C0.C0))(^D0.D0))
;  ==[alpha]==> (((^A0.A0)(^B0.B0))(^C0.C0))
;  ==[beta 10.]==> ((^B0.B0)(^C0.C0))
;  ==[alpha]==> ((^A0.A0)(^B0.B0))
;  ==[beta 11.]==> (^B0.B0)
;  ==[alpha]==> (^A0.A0)
;
;  There are no further reductions
;
;---------------------------------------------------------------
;
;                    (random-var nvars)
;
; return random of the first nvars variables of
; a0, b0, c0, ..., a1, b1, c1 ...
;


(set 'random-var
     (lambda(nvars)
       (let((r (rand nvars)))
           (sym (append (char (+ 97 (% r 25)))
                        (string (/ r 25)))))))


;---------------------------------------------------------------
;
;               (random-^-expr nvars number-of-occurences)
;
; returns random lambda-expression with at most nvars variables
; in total of exactly number-of-occurences occurences

(set 'random-^-expr
   (lambda(nvars number-of-occurences)
      (cond ((= number-of-occurences 1) (random-var nvars))
            ((> number-of-occurences 1)
             (amb (let ((r (+ (rand (- number-of-occurences 1)) 1)))
                       (list (random-^-expr nvars r)
                             (random-^-expr nvars (- number-of-occurences r))))
                  (list '^
                        (random-var nvars)
                        '.
                        (random-^-expr nvars (- number-of-occurences 1))))))))

;---------------------------------------------------------------
;
;                         (normalized E)
;
; returns normalized expression E, i.e. variables sorted by some
; natural and unique order. It is important only for order of
; free variables. The order of bounded variables is sorted on
; natural and unique way using function init-and-alpha-convert.

(set 'normalized
  (lambda(E)
    (let((varcounter 0)
         (F (flat E)))
      (dolist(i F)

        (when (and (!= i '^)
                   (!= i '.)
                   (= (string i)
                      (lower-case (string i))))

          (inc varcounter)
          (setf E
             (expand E ;((i _i))
                (list (list i
                        (sym (append "_"
                                (lower-case (string (bounded-var varcounter)))))))))))

     (eval-string (append "'" (replace "_" (string E) ""))))))


; (println= (normalized '(b0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0))))

;---------------------------------------------------------------
; The program will generate large number of lambda-expressions,
; and attempt to reduce these. The lambda-expressions not reduced in
; 20 steps or more are good candidates for unreducible lambda-expressions.

(for(number-of-occurences 6 8 1)

  (setf successes 0
        failures 0
        attempts 0
        total-number-of-steps 0
        max-number-of-steps-if-reduction-succeeded 0)

  (setf max-number-of-reductions 25)
  (setf unreduced '())

  (println= "\n\n----------------" number-of-occurences)
  (for(nvars 1 (- number-of-occurences 1) 1)
    (dotimes(dummy 200000)
      (letn((F (random-^-expr nvars number-of-occurences))
            (G (init-and-alpha-convert F)))
           (inc attempts)

           (letn((H (reduce G
                            max-number-of-reductions
                            nil)))

                 (cond ((= (H 0) true) ; reduction succeeded
                        (inc total-number-of-steps (H 2))
                        (inc successes)
                        (when (> (H 2) max-number-of-steps-if-reduction-succeeded)
                              (setf max-number-of-steps-if-reduction-succeeded (H 2))
                              (setf longest-reduction G)))

                      ((= (H 0) nil) ; reduction failed
                       (begin (inc failures)
                              ;(print "!")
                              (if (= (% failures 80) 0) (println))

                              (push (append (string (normalized G)) "  failed.")
                                    unreduced
                                    -1)))

                      ((= (H 0) 'undefined) ; reduction canceled
                       (begin (inc failures)
                              ;(print "?")
                              (if (= (% failures 80) 0) (println))

                              (push (append (string (normalized G))
                                            "  didn't succeeded in "
                                            (string max-number-of-reductions)
                                            " steps.")
                                    unreduced
                                    -1))))))))

   (println= "\n\n" attempts "\n" successes "\n" failures
             "\n" max-number-of-reductions "\n" total-number-of-steps
             "\n" max-number-of-steps-if-reduction-succeeded
             "\n" longest-reduction)

   (println "\nUnreduced (without duplicates):\n")
   (dolist(s (unique (sort unreduced)))
     (println (+ $idx 1) ".  " s)))

(exit)

Output: (!'s and ?'s are printed during execution of the program)

----------------number-of-occurences=6;

attempts=1000000;
successes=998677;
failures=1323;
max-number-of-reductions=25;
total-number-of-steps=596444;
max-number-of-steps-if-reduction-succeeded=3;
longest-reduction=(((^ A0 . (A0 A0)) (^ B0 . B0)) a0);

Unreduced (without duplicates):

1. ((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) failed.

----------------number-of-occurences=7;

attempts=1200000;
successes=1197916;
failures=2084;
max-number-of-reductions=25;
total-number-of-steps=908464;
max-number-of-steps-if-reduction-succeeded=5;
longest-reduction=((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 b0))));

Unreduced (without duplicates):

1. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) failed.
2. ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0))) failed.
3. ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0))) failed.
4. ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0))) failed.
5. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
6. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
7. ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
8. ((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
9. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0))) failed.
10. ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0))) failed.
11. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) failed.
12. (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.

----------------number-of-occurences=8;

attempts=1400000;
successes=1396693;
failures=3307;
max-number-of-reductions=25;
total-number-of-steps=1278600;
max-number-of-steps-if-reduction-succeeded=15;
longest-reduction=((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 (B0 c0)))));

Unreduced (without duplicates):

1. ((((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) a0) failed.
2. ((((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0) b0) failed.
3. (((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0))) a0) failed.
4. (((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0))) b0) failed.
5. (((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0))) a0) failed.
6. (((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0))) a0) didn't succeeded in 25 steps.
7. (((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) a0))) a0) didn't succeeded in 25 steps.
8. (((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0)))) a0) didn't succeeded in 25 steps.
9. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (^ C0 . C0)) failed.
10. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (^ C0 . a0)) failed.
11. (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) (a0 a0)) failed.
12. (((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 B0)))) b0) didn't succeeded in 25 steps.
13. (((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0))) a0) failed.
14. (((^ A0 . (^ B0 . (B0 B0))) a0) (^ C0 . (C0 C0))) failed.
15. (((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0))) a0) failed.
16. (((^ A0 . A0) (^ B0 . (B0 B0))) (^ C0 . (C0 C0))) failed.
17. ((^ A0 . (((A0 A0) A0) A0)) (^ B0 . (B0 B0))) failed.
18. ((^ A0 . (((A0 A0) A0) a0)) (^ B0 . (B0 B0))) failed.
19. ((^ A0 . (((A0 A0) a0) A0)) (^ B0 . (B0 B0))) failed.
20. ((^ A0 . (((^ B0 . A0) A0) A0)) (^ C0 . (C0 C0))) failed.
21. ((^ A0 . (((^ B0 . A0) a0) A0)) (^ C0 . (C0 C0))) failed.
22. ((^ A0 . (((^ B0 . B0) A0) A0)) (^ C0 . (C0 C0))) failed.
23. ((^ A0 . ((A0 (A0 A0)) A0)) (^ B0 . (B0 B0))) failed.
24. ((^ A0 . ((A0 (A0 A0)) a0)) (^ B0 . (B0 B0))) failed.
25. ((^ A0 . ((A0 A0) (A0 A0))) (^ B0 . (B0 B0))) failed.
26. ((^ A0 . ((A0 A0) (^ B0 . A0))) (^ C0 . (C0 C0))) failed.
27. ((^ A0 . ((A0 A0) (^ B0 . B0))) (^ C0 . (C0 C0))) failed.
28. ((^ A0 . ((A0 A0) (^ B0 . a0))) (^ C0 . (C0 C0))) failed.
29. ((^ A0 . ((A0 A0) (a0 A0))) (^ B0 . (B0 B0))) failed.
30. ((^ A0 . ((A0 A0) (a0 a0))) (^ B0 . (B0 B0))) failed.
31. ((^ A0 . ((A0 A0) A0)) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
32. ((^ A0 . ((A0 A0) A0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
33. ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
34. ((^ A0 . ((A0 A0) A0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
35. ((^ A0 . ((A0 A0) a0)) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
36. ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
37. ((^ A0 . ((A0 A0) a0)) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
38. ((^ A0 . ((A0 a0) (A0 A0))) (^ B0 . (B0 B0))) failed.
39. ((^ A0 . ((^ B0 . (A0 A0)) A0)) (^ C0 . (C0 C0))) failed.
40. ((^ A0 . ((^ B0 . (A0 A0)) a0)) (^ C0 . (C0 C0))) failed.
41. ((^ A0 . ((^ B0 . (A0 B0)) A0)) (^ C0 . (C0 C0))) failed.
42. ((^ A0 . ((^ B0 . (B0 A0)) A0)) (^ C0 . (C0 C0))) failed.
43. ((^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) a0) failed.
44. ((^ A0 . ((^ B0 . (B0 B0)) A0)) (^ C0 . (C0 C0))) failed.
45. ((^ A0 . ((^ B0 . B0) (A0 A0))) (^ C0 . (C0 C0))) failed.
46. ((^ A0 . ((a0 (A0 A0)) A0)) (^ B0 . (B0 B0))) failed.
47. ((^ A0 . ((a0 (A0 A0)) a0)) (^ B0 . (B0 B0))) failed.
48. ((^ A0 . ((a0 A0) (A0 A0))) (^ B0 . (B0 B0))) failed.
49. ((^ A0 . (A0 ((A0 A0) A0))) (^ B0 . (B0 B0))) failed.
50. ((^ A0 . (A0 ((A0 A0) a0))) (^ B0 . (B0 B0))) failed.
51. ((^ A0 . (A0 ((^ B0 . A0) a0))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
52. ((^ A0 . (A0 ((^ B0 . B0) A0))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
53. ((^ A0 . (A0 (A0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
54. ((^ A0 . (A0 (A0 (^ B0 . A0)))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
55. ((^ A0 . (A0 (A0 A0))) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
56. ((^ A0 . (A0 (A0 A0))) (^ B0 . ((B0 B0) a0))) didn't succeeded in 25 steps.
57. ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
58. ((^ A0 . (A0 (A0 A0))) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
59. ((^ A0 . (A0 (^ B0 . (A0 B0)))) (^ C0 . (C0 C0))) didn't succeeded in 25 steps.
60. ((^ A0 . (A0 (^ B0 . (B0 B0)))) (^ C0 . (C0 C0))) failed.
61. ((^ A0 . (A0 (^ B0 . A0))) (^ C0 . ((C0 a0) C0))) didn't succeeded in 25 steps.
62. ((^ A0 . (A0 (a0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
63. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (B0 B0))) a0)) didn't succeeded in 25 steps.
64. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (B0 C0))) a0)) didn't succeeded in 25 steps.
65. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (C0 B0))) a0)) didn't succeeded in 25 steps.
66. ((^ A0 . (A0 A0)) ((^ B0 . (^ C0 . (C0 C0))) a0)) didn't succeeded in 25 steps.
67. ((^ A0 . (A0 A0)) ((^ B0 . B0) (^ C0 . (C0 C0)))) didn't succeeded in 25 steps.
68. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) B0) B0))) didn't succeeded in 25 steps.
69. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) B0))) didn't succeeded in 25 steps.
70. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) a0))) didn't succeeded in 25 steps.
71. ((^ A0 . (A0 A0)) (^ B0 . (((B0 B0) a0) b0))) didn't succeeded in 25 steps.
72. ((^ A0 . (A0 A0)) (^ B0 . (((^ C0 . B0) B0) B0))) didn't succeeded in 25 steps.
73. ((^ A0 . (A0 A0)) (^ B0 . (((^ C0 . C0) B0) B0))) didn't succeeded in 25 steps.
74. ((^ A0 . (A0 A0)) (^ B0 . ((B0 (B0 B0)) B0))) didn't succeeded in 25 steps.
75. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (B0 B0)))) didn't succeeded in 25 steps.
76. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (B0 a0)))) didn't succeeded in 25 steps.
77. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . B0)))) didn't succeeded in 25 steps.
78. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . C0)))) didn't succeeded in 25 steps.
79. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (^ C0 . a0)))) didn't succeeded in 25 steps.
80. ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) (a0 B0)))) didn't succeeded in 25 steps.
81. ((^ A0 . (A0 A0)) (^ B0 . ((B0 a0) (B0 B0)))) didn't succeeded in 25 steps.
82. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (B0 C0)) B0))) didn't succeeded in 25 steps.
83. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (C0 B0)) B0))) didn't succeeded in 25 steps.
84. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . (C0 C0)) B0))) didn't succeeded in 25 steps.
85. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . B0) (B0 B0)))) didn't succeeded in 25 steps.
86. ((^ A0 . (A0 A0)) (^ B0 . ((^ C0 . C0) (B0 B0)))) didn't succeeded in 25 steps.
87. ((^ A0 . (A0 A0)) (^ B0 . ((a0 a0) (B0 B0)))) didn't succeeded in 25 steps.
88. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((B0 B0) B0)))) didn't succeeded in 25 steps.
89. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((^ C0 . B0) B0)))) didn't succeeded in 25 steps.
90. ((^ A0 . (A0 A0)) (^ B0 . (B0 ((^ C0 . C0) B0)))) didn't succeeded in 25 steps.
91. ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 (B0 B0))))) didn't succeeded in 25 steps.
92. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (B0 B0))))) failed.
93. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (B0 C0))))) didn't succeeded in 25 steps.
94. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (C0 B0))))) failed.
95. ((^ A0 . (A0 A0)) (^ B0 . (B0 (^ C0 . (C0 C0))))) failed.
96. ((^ A0 . (A0 A0)) (^ B0 . (B0 (a0 (B0 B0))))) didn't succeeded in 25 steps.
97. ((^ A0 . (A0 A0)) (^ B0 . (a0 (B0 (B0 B0))))) didn't succeeded in 25 steps.
98. ((^ A0 . (A0 A0)) (^ B0 . (a0 (a0 (B0 B0))))) didn't succeeded in 25 steps.
99. ((^ A0 . (^ B0 . ((A0 A0) A0))) (^ C0 . (C0 C0))) failed.
100. ((^ A0 . (^ B0 . ((A0 A0) B0))) (^ C0 . (C0 C0))) failed.
101. ((^ A0 . (^ B0 . ((A0 A0) a0))) (^ C0 . (C0 C0))) failed.
102. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . ((C0 C0) C0))) didn't succeeded in 25 steps.
103. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . ((C0 C0) a0))) didn't succeeded in 25 steps.
104. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 (C0 C0)))) didn't succeeded in 25 steps.
105. ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (a0 (C0 C0)))) didn't succeeded in 25 steps.
106. ((^ A0 . (^ B0 . (B0 (A0 A0)))) (^ C0 . (C0 C0))) failed.
107. ((^ A0 . (^ B0 . (^ C0 . (A0 A0)))) (^ D0 . (D0 D0))) failed.
108. ((^ A0 . (^ B0 . (a0 (A0 A0)))) (^ C0 . (C0 C0))) failed.
109. ((^ A0 . (a0 ((A0 A0) a0))) (^ B0 . (B0 B0))) failed.
110. ((^ A0 . (a0 (A0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
111. ((^ A0 . (a0 (A0 A0))) (^ B0 . ((B0 B0) B0))) didn't succeeded in 25 steps.
112. ((^ A0 . (a0 (A0 A0))) (^ B0 . ((B0 B0) b0))) didn't succeeded in 25 steps.
113. ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 (B0 B0)))) didn't succeeded in 25 steps.
114. ((^ A0 . (a0 (A0 A0))) (^ B0 . (a0 (B0 B0)))) didn't succeeded in 25 steps.
115. ((^ A0 . (a0 (A0 A0))) (^ B0 . (b0 (B0 B0)))) didn't succeeded in 25 steps.
116. ((^ A0 . (a0 (^ B0 . (A0 A0)))) (^ C0 . (C0 C0))) failed.
117. ((^ A0 . (a0 (b0 (A0 A0)))) (^ B0 . (B0 B0))) failed.
118. ((^ A0 . A0) ((^ B0 . (B0 B0)) (^ C0 . (C0 C0)))) failed.
119. ((a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) a0) failed.
120. ((a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) b0) failed.
121. ((a0 a0) ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.
122. ((a0 b0) ((^ A0 . (A0 A0)) (^ B0 . (B0 B0)))) failed.
123. (^ A0 . (((^ B0 . (B0 B0)) (^ C0 . (C0 C0))) A0)) failed.
124. (^ A0 . (((^ B0 . (B0 B0)) (^ C0 . (C0 C0))) a0)) failed.
125. (^ A0 . ((^ B0 . ((B0 B0) A0)) (^ C0 . (C0 C0)))) failed.
126. (^ A0 . ((^ B0 . ((B0 B0) B0)) (^ C0 . (C0 C0)))) failed.
127. (^ A0 . ((^ B0 . ((B0 B0) a0)) (^ C0 . (C0 C0)))) failed.
128. (^ A0 . ((^ B0 . (A0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
129. (^ A0 . ((^ B0 . (B0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
130. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) A0)))) didn't succeeded in 25 steps.
131. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) C0)))) didn't succeeded in 25 steps.
132. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . ((C0 C0) a0)))) didn't succeeded in 25 steps.
133. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (A0 (C0 C0))))) didn't succeeded in 25 steps.
134. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 (C0 C0))))) didn't succeeded in 25 steps.
135. (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (a0 (C0 C0))))) didn't succeeded in 25 steps.
136. (^ A0 . ((^ B0 . (^ C0 . (B0 B0))) (^ D0 . (D0 D0)))) failed.
137. (^ A0 . ((^ B0 . (a0 (B0 B0))) (^ C0 . (C0 C0)))) failed.
138. (^ A0 . (A0 ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
139. (^ A0 . (^ B0 . ((^ C0 . (C0 C0)) (^ D0 . (D0 D0))))) failed.
140. (^ A0 . (a0 ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
141. (a0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) a0)) failed.
142. (a0 (((^ A0 . (A0 A0)) (^ B0 . (B0 B0))) b0)) failed.
143. (a0 ((^ A0 . ((A0 A0) A0)) (^ B0 . (B0 B0)))) failed.
144. (a0 ((^ A0 . ((A0 A0) a0)) (^ B0 . (B0 B0)))) failed.
145. (a0 ((^ A0 . (A0 (A0 A0))) (^ B0 . (B0 B0)))) failed.
146. (a0 ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) B0)))) didn't succeeded in 25 steps.
147. (a0 ((^ A0 . (A0 A0)) (^ B0 . ((B0 B0) b0)))) didn't succeeded in 25 steps.
148. (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 (B0 B0))))) didn't succeeded in 25 steps.
149. (a0 ((^ A0 . (A0 A0)) (^ B0 . (b0 (B0 B0))))) didn't succeeded in 25 steps.
150. (a0 ((^ A0 . (^ B0 . (A0 A0))) (^ C0 . (C0 C0)))) failed.
151. (a0 ((^ A0 . (a0 (A0 A0))) (^ B0 . (B0 B0)))) failed.
152. (a0 (^ A0 . ((^ B0 . (B0 B0)) (^ C0 . (C0 C0))))) failed.
153. (a0 (a0 ((^ A0 . (A0 A0)) (^ B0 . (B0 B0))))) failed.


---------------------------
Two Thoughts on Lisp Syntax
---------------------------
http://kazimirmajorinc.blogspot.com/2011/01/two-thoughts-on-lisp-syntax.html

;                     1. Lisp has syntax
;
; It is frequently said that Lisp has no syntax. It is simplification:
; there is a syntax, just it is relatively simple and uniform,
; compared to other languages. For example, look at these two
; expressions:
                         (setq x 3 y 4)

                       (setq (x 3) (y 4))

; It is easy to imagine that these two expressions have same semantics,
; and that difference is purely syntactic. Even if we use some formal
; definition of syntax. For example, Wikipedia defines syntax as
;
;      "set of rules that defines the combinations of symbols
;       that are considered to be correctly structured programs
;       in that language."
;
;
;                    2. Which syntax is better?
;
; If code is written by programmer, then it is slightly easier
; to use (setq x 3 y 4) form. But if code is generated by program,
; then form (setq (x 3) (y 4)) is more suitable. For example, the
; function that extract variables from the setq expression in the
; form (setq x 3 y 4) might look like

   (define (setq-places s)
           (let((counter 0)
                (result '()))

               (dolist(i s)
                  (inc counter)
                  (when (even? counter)
                        (push i result -1))) ; push on the right side

                result))

; It is very simple, but verbose code. If I have luck and my Lisp
; supports some  suitable functions, it might be even simpler. However,
; it appears that it is always simpler to extract the variables
; from the form (setq (x 3) (y 4)):

        (define (setq-places s)
                (map first (rest s)))

; So, I'd say that overall, form (setq (x 3) (y 4)) is better.

Commenti:
---------
*** Unknown 8 February 2011 at 17:35
Though, this form (setq (x 3) (y 4)) kinda breaks a syntax-semantic correspondence consistency with the rest of lisp, because in general the first syntactical element in (a b c d ...) is a operator.

In the (setq (x 3) (y 4)) case, the x and y isn't operator. I can't think of a similar example in lisp right now.


-------------------------
Cantor's Enumerations (1)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-1.html

; George Cantor discovered that set of all pairs of the natural
; numbers is countable; i.e, there is bijective map
;
;                     N -> N × N
;
; where N is set of all natural numbers. This is the simplest
; bijection of that kind:
;
Nota: vedi immagine "Cantor_Pairing_Function.png" nella cartella "data".
;
; Each natural number, n is mapped to some pair of natural numbers,
; (r, c). That pair is on diagonale d. Inverse mapping is defined
; as well; for every pair of natural numbers, (r, c) there is a
; natural number n such that n is mapped to (r, c). However, if we
; want to write programs that use Cantor's enumeration, then we need
; explicit formulas.
;
; Let's say that n is given. First, we can calculate d, the diagonale
; on which n is placed. From picture
;
;           n <= 1 + 2 + ... + d = d * (d + 1) / 2
;
; i.e. we search for minimal natural number d such
;
;                d^2 + d - 2n >= 0
;
;                d = ceil ( - 1 + sqrt (1 + 8*n) / 2)
;
; When we know d, then it is easy to calculate
;
;                r = n - d * (d - 1) / 2
;
;                c = d - r + 1
;
; Inversly, if r and c are given, then d can be calculated as
;
;                d = c + r - 1
;
; and            n = d * (d - 1) /2 + r
;
; I'll define Newlisp functions, using longer names;
;
; First, lets define functions that calculate d, r and c on the
; base of n. I'll give longer names to these functions:
; cantors-diagonal1, cantors-row and cantors-column respectively.

(setf cantors-diagonal1
  (lambda(n)(ceil (div (add (- 1)
                            (sqrt (add 1 (mul 8 n))))
                        2))))

(setf cantors-row
   (lambda (n)
      (let ((cd (cantors-diagonal1 n)))
           (- n (/ (* cd
                      (- cd 1))
                   2)))))

(setf cantors-column (lambda (n) (+ (cantors-diagonal1 n)
                                    (- (cantors-row n))
                                    1)))

; Second, lets define functions that calcualte d and n on the base
; of r and c. I'll give longer names to these functions:
; cantors-diagonal2, and cantors-number.

(setf cantors-diagonal2 (lambda(r c)(+ c r (- 1))))

(setf cantors-number
      (lambda(r c)
         (let ((cd (cantors-diagonal2 r c)))
               (+ (/ (* cd (- cd 1)) 2) r))))

; Lets try two simple tests:

(for(n 1 10)
  (println (format "%2d" n) " -> " (list (cantors-row n) (cantors-column n))
             ", diagonal="  (cantors-diagonal1 n)))
(println)

(for(r 1 3)
  (for(c 1 3)
     (print "(" r "," c ") => "
            (format "n=%2d, " (cantors-number r c))
            (format "d=%1d;  " (cantors-diagonal2 r c))))
  (println))
(exit)

; Everything works.
;
;
;  1 -> (1 1), diagonal=1
;  2 -> (1 2), diagonal=2
;  3 -> (2 1), diagonal=2
;  4 -> (1 3), diagonal=3
;  5 -> (2 2), diagonal=3
;  6 -> (3 1), diagonal=3
;  7 -> (1 4), diagonal=4
;  8 -> (2 3), diagonal=4
;  9 -> (3 2), diagonal=4
; 10 -> (4 1), diagonal=4
;
; (1,1) => n= 1, d=1;  (1,2) => n= 2, d=2;  (1,3) => n= 4, d=3;
; (2,1) => n= 3, d=2;  (2,2) => n= 5, d=3;  (2,3) => n= 8, d=4;
; (3,1) => n= 6, d=3;  (3,2) => n= 9, d=4;  (3,3) => n=13, d=5;
;
; Cantor's row and Cantor's column remind on well known operators
; "div" and "mod", don't they?


-------------------------
Cantor's Enumerations (2)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-2.html

; It is possible to enumerate not only pairs of the natural numbers,
; but triplets as well. For a first step, I'll combine functions
; cantors-row and cantors column into one
;
;                  cantors-enumeration-2:N->N×N,
;
; and I'll also define inverse function
;
;               cantors-enumeration-2-inverse:N×N->N
;
; (If you want to "run" these examples, you might need to concatenate
; text of this post to text of previous post. Or, you can just read
; it as it is.)

(define cantors-enumeration-2
        (lambda(n)(list (cantors-row n) (cantors-column n))))

(define cantors-enumeration-2-inverse
        (lambda(r c)(cantors-number r c)))

; Now, cantor enumeration of triplets can be defined as
;
;                cantors-enumeration-3: N-> N x N x N

(define cantors-enumeration-3
        (lambda(n)(append (list (cantors-row n))
                          (cantors-enumeration-2 (cantors-column n)))))
;
; Is it bijection? Yes, it is - for completeness, here is the proof,
; but I advice you to skip through that, since it is very dry and
; "straight-forward."
;
; [1] Is it injection? It is, because, for every n1 and n2,
;     it is either
;
;    (1.1) (cantors-row n1) is different than (cantors-row n2), or
;    (1.2) (cantors-column n1) is different than (cantors-column n2)
;
;    if (1.1) then by definition (cantors-enumeration-3 n1) is different
;             than (cantors-enumeration-3 n2).
;    if (1.2) then (cantors-enumeration-2 (cantors-column n1)) is
;             different than (cantors-enumeration-2 (cantors-column n2))
;             because cantors-enumeration-2 is bijection, and then
;             (cantors-enumeration-3 n1) is different than
;             (cantors-enumeration-3 n2).
;
; [2] Is it surjection? First, there is m such that
;     (cantors-enumeration-2 m)=(y z). Also, there is n such that
;     (cantros-enumeration-2 n)=(x (cantors-column m)). So, yes,
;     it is surjection as well.
;
;  We can also define inverse enumeration:

(define cantors-enumeration-3-inverse
        (lambda(x y z)(let((m (cantors-enumeration-2-inverse y z)))
                          (cantors-enumeration-2-inverse x m))))
; lets test it:

(println "\ncantors-enumeration-3 and cantors-enumeration-3-inverse test:\n")

(for(i1 1 8)
   (letn((i2 (cantors-enumeration-3 i1))
         (i3 (apply cantors-enumeration-3-inverse i2)))
      (println (format "%2d" i1) " -> " i2 " => " (format "%2d" i3))))

;  1 -> (1 1 1) =>  1
;  2 -> (1 1 2) =>  2
;  3 -> (2 1 1) =>  3
;  4 -> (1 2 1) =>  4
;  5 -> (2 1 2) =>  5
;  6 -> (3 1 1) =>  6
;  7 -> (1 1 3) =>  7
;  8 -> (2 2 1) =>  8

(println)

(for(i 1 2)
  (for(j 1 2)
     (for(k 1 2)
        (letn((i1 (list i j k))
              (i2 (cantors-enumeration-3-inverse i j k))
              (i3 (cantors-enumeration-3 i2)))
        (println i1 " -> " (format "%2d" i2) " => " i3)))))

; (1 1 1) ->  1 => (1 1 1)
; (1 1 2) ->  2 => (1 1 2)
; (1 2 1) ->  4 => (1 2 1)
; (1 2 2) -> 11 => (1 2 2)
; (2 1 1) ->  3 => (2 1 1)
; (2 1 2) ->  5 => (2 1 2)
; (2 2 1) ->  8 => (2 2 1)
; (2 2 2) -> 17 => (2 2 2)

; By inductions, enumeration can be defined for p-tuples, where
; p is any natural number. Perhaps p=1 is unnecessary case, but I
; defined it, however, for sake of completeness.

(define (cantors-enumeration p n)
        (cond ((= p 1) (list n))
              ((> p 1) (cons (cantors-row n)
                             (cantors-enumeration (- p 1) (cantors-column n))))))


(define (cantors-enumeration-inverse)
        ; p is not needed since it can be calculated from the
        ; number of arguments
        (letn((arguments (args))
             (p (length arguments)))
            (cond ((= p 1) (first arguments))
                  ((> p 1) (apply cantors-number
                                  (cons (first arguments)
                                        (apply cantors-enumeration-inverse
                                               (rest arguments))))))))

; Test again

(println "\ncantors-enumeration and cantors-enumeration-inverse test:\n")

(for(i1 1 16)
    (letn((i2 (cantors-enumeration 4 i1))
          (i3 (apply cantors-enumeration-inverse i2)))
      (println (format "%2d" i1) " -> " i2 " => " (format "%2d" i3))))

;  1 -> (1 1 1) =>  1
;  2 -> (1 1 2) =>  2
;  3 -> (2 1 1) =>  3
;  4 -> (1 2 1) =>  4
;  5 -> (2 1 2) =>  5
;  6 -> (3 1 1) =>  6
;  7 -> (1 1 3) =>  7
;  8 -> (2 2 1) =>  8
;  9 -> (3 1 2) =>  9
; 10 -> (4 1 1) => 10
; 11 -> (1 2 2) => 11
; 12 -> (2 1 3) => 12
; 13 -> (3 2 1) => 13
; 14 -> (4 1 2) => 14
; 15 -> (5 1 1) => 15
; 16 -> (1 3 1) => 16

(println)

(for(i 1 2)
  (for(j 1 2)
    (for(k 1 2)
       (for(l 1 2)
          (letn((i1 (list i j k l))
                (i2 (cantors-enumeration-inverse i j k l))
                (i3 (cantors-enumeration 4 i2)))
            (println i1 " -> " (format "%3d" i2) " => " i3))))))

; (1 1 1 1) ->   1 => (1 1 1 1)
; (1 1 1 2) ->   2 => (1 1 1 2)
; (1 1 2 1) ->   7 => (1 1 2 1)
; (1 1 2 2) ->  56 => (1 1 2 2)
; (1 2 1 1) ->   4 => (1 2 1 1)
; (1 2 1 2) ->  11 => (1 2 1 2)
; (1 2 2 1) ->  29 => (1 2 2 1)
; (1 2 2 2) -> 137 => (1 2 2 2)
; (2 1 1 1) ->   3 => (2 1 1 1)
; (2 1 1 2) ->   5 => (2 1 1 2)
; (2 1 2 1) ->  12 => (2 1 2 1)
; (2 1 2 2) ->  68 => (2 1 2 2)
; (2 2 1 1) ->   8 => (2 2 1 1)
; (2 2 1 2) ->  17 => (2 2 1 2)
; (2 2 2 1) ->  38 => (2 2 2 1)
; (2 2 2 2) -> 155 => (2 2 2 2)

; Everything works.

(exit)


-------------------------
Cantor's Enumerations (3)
-------------------------
http://kazimirmajorinc.blogspot.com/2011/01/cantors-enumerations-3.html

; Grand finale of these few posts on Cantor's enumerations is
; enumeration of all finite sequences of natural numbers - including
; singles. Same Cantor's trick, but this time on more abstract
; level, can be used:
;
;    a11, a12, .... is enumerated list of all singles
;    a21, a22, .... is enumerated list of all pairs
;    a31, a32, .... is enumerated list of all triplets
;    ...
;
; It doesn't matter that aij's are the result of the Cantor's enumeration;
; Same Cantor's enumeration can be applied again:
;    a11, a12, a21, a31, a22, a32 ...
;
; After such enumeration, all finite sequences will be on our list, enumerated.
;
; What might be the next step - enumerating all infinite sequences?
; Unfortunately, it is impossible.
;
; If you want to run this post as program, you need to cut and paste
; previous two posts on the beginning. Alternatively, you can simply
; read the posts and believe me about results.

(println)

(define cantors-enumeration-finite
        (lambda(n)
          (cantors-enumeration (cantors-row n) (cantors-column n))))

(define cantors-enumeration-finite-inverse
        (lambda()
          (let((arguments (args)))
            (cantors-enumeration-inverse (length arguments)
                                         (apply cantors-enumeration-inverse arguments)))))

; Test

(for(i1 1 45)
  (letn((i2 (cantors-enumeration-finite i1))
        (i3 (apply cantors-enumeration-finite-inverse i2)))
        (println (format "%2d" i1) " -> " i2 " -> " (format "%2d" i3))))

; The result is pretty:

 1 -> (1) ->  1
 2 -> (2) ->  2
 3 -> (1 1) ->  3
 4 -> (3) ->  4
 5 -> (1 2) ->  5
 6 -> (1 1 1) ->  6
 7 -> (4) ->  7
 8 -> (2 1) ->  8
 9 -> (1 1 2) ->  9
10 -> (1 1 1 1) -> 10
11 -> (5) -> 11
12 -> (1 3) -> 12
13 -> (2 1 1) -> 13
14 -> (1 1 1 2) -> 14
15 -> (1 1 1 1 1) -> 15
16 -> (6) -> 16
17 -> (2 2) -> 17
18 -> (1 2 1) -> 18
19 -> (2 1 1 1) -> 19
20 -> (1 1 1 1 2) -> 20
21 -> (1 1 1 1 1 1) -> 21
22 -> (7) -> 22
23 -> (3 1) -> 23
24 -> (2 1 2) -> 24
25 -> (1 2 1 1) -> 25
26 -> (2 1 1 1 1) -> 26
27 -> (1 1 1 1 1 2) -> 27
28 -> (1 1 1 1 1 1 1) -> 28
29 -> (8) -> 29
30 -> (1 4) -> 30
31 -> (3 1 1) -> 31
32 -> (2 1 1 2) -> 32
33 -> (1 2 1 1 1) -> 33
34 -> (2 1 1 1 1 1) -> 34
35 -> (1 1 1 1 1 1 2) -> 35
36 -> (1 1 1 1 1 1 1 1) -> 36
37 -> (9) -> 37
38 -> (2 3) -> 38
39 -> (1 1 3) -> 39
40 -> (3 1 1 1) -> 40
41 -> (2 1 1 1 2) -> 41
42 -> (1 2 1 1 1 1) -> 42
43 -> (2 1 1 1 1 1 1) -> 43
44 -> (1 1 1 1 1 1 1 2) -> 44
45 -> (1 1 1 1 1 1 1 1 1) -> 45


---------------------------------
Enumeration of Lambda-Expressions
---------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/enumeration-of-lambda-expressions.html

(setf [println.supressed] true [print.supressed] true)
(load "http://instprog.com//Instprog.default-library.lsp")
(setf [println.supressed] nil [print.supressed] nil)

; The lambda-expressions are defined on following way:
;
; (a) a, b, c, ... are lambda-expressions. These lambda expressions
;     are named "variables".
;
; (b) if X is variable and E is lambda-expression, then
;
;                            (^ X . E)
;
;     is lambda-expression as well. These lambda-expressions are
;     named "functions".
;
; (c) if E and F are lambda-expressions, then (E F) is lambda-
;     expression as well. These lambda expressions are named
;     "applications."
;
; Using functions for Cantor's enumeration developed in last few
; posts, now in my library, I'll define functions for enumeration
; of all lambda-expressions, i.e. bijective function
;
;                    lam: N -> all lambda-exprsions
;
; Enumerations of variables, functions, and applications will be
; defined independently.
;
;       var1, var2, ..., varn, ...
;       fun1, fun2, ..., funn, ...
;       app1, app2, ..., appn, ...
;
; After that, all lambda expressions will be enumerated on following
; way:
;
;       var1, fun1, app1, var2, fun2, app2, ...
;
;---------------------------------------------------------------
;
; First - enumeration of variables; and inverse enumeration.
;
; If alphabet is, for example, "xyz", I'll enumerate variables
; on following way:
;
;       x, y, z, x1, y1, z1, x2, y2, z2 ...
;
; It slightly complicates enumeration, but it looks better than
;
;       x0, y0, z0, x1, y1, ...

(setf var (lambda(n alphabet)
             (letn((l (length alphabet))
                   (first-char (alphabet (% (- n 1) l)))
                   (rest-chars (let((n1 (/ (- n 1) l)))
                               (if (= n1 0) "" (string n1)))))
                  (sym (append first-char rest-chars)))))

(setf var-inverse (lambda(v alphabet)
                     (letn((l (length alphabet))
                           (first-char (first (string v)))
                           (rest-chars (rest (string v))))
                          (when (= rest-chars "")
                                (setf rest-chars "0"))
                          (+ (* (int rest-chars) l)
                             (find first-char alphabet) 1))))
;
;---------------------------------------------------------------
;
; Second, enumeration of functions - and inverse enumeration.
;
; Every function has form (^ <var> <lambda-expression>), where
; any variable and lambda-expression is allowed. All pairs of
; variables and lambda-expressions can be enumerated using
; Cantor's enumeration:

(setf fun (lambda(n alphabet)
             (list '^
                   (var (cantors-row n) alphabet)
                   '.
                   (lam (cantors-column n) alphabet))))

(setf fun-inverse
  (lambda(f alphabet)
     (cantors-enumeration-inverse (var-inverse (f 1) alphabet)
                                  (lam-inverse (f 3) alphabet))))
;
;---------------------------------------------------------------
;
; Third, enumeration of applications - and inverse enumeration.
;
; Every application has form (<lambda-expression1> <lambda-expression2>),
; For enumeration of pairs of lambda-expressions, we need Cantors
; enumeration again.

(setf app (lambda(n alphabet)
            (list (lam (cantors-row n) alphabet)
                  (lam (cantors-column n) alphabet))))

(setf app-inverse
  (lambda(a alphabet)
    (cantors-enumeration-inverse (lam-inverse (first a) alphabet)
                                 (lam-inverse (last a) alphabet))))

;
;---------------------------------------------------------------
;
; Finally, enumeration of lambda expressions - and inverse enumeration:

(setf lam (lambda(n alphabet)
            (letn((n1 (- n 1))
                  (row (+ (% n1 3) 1))
                  (column (+ (/ n1 3) 1)))

              (case row (1 (var column alphabet))
                        (2 (fun column alphabet))
                        (3 (app column alphabet))))))

; For lam-inverse, I need few helper predicates:

(setf var? (lambda(l)(symbol? l)))
(setf fun? (lambda(l)(and (list? l) (= (length l) 4))))
(setf app? (lambda(l)(and (list? l) (= (length l) 2))))

(setf lam-inverse
      (lambda(l alphabet)
         (local(row column)
           (cond ((var? l)(setf row 1)
                          (setf column (var-inverse l alphabet)))
                 ((fun? l)(setf row 2)
                          (setf column (fun-inverse l alphabet)))
                 ((app? l)(setf row 3)
                          (setf column (app-inverse l alphabet))))
            (+ (* 3 (- column 1)) row))))

;---------------------------------------------------------------
;
;                          TEST

(for(i1 1 10)
  (letn((i2 (lam i1 "xyz"))
       (i3 (lam-inverse i2 "xyz")))
       (println i1 " -> " i2 " => " i3)))

; Here is output - ten nice lambda expressions

; 1 -> x => 1
; 2 -> (^ x . x) => 2
; 3 -> (x x) => 3
; 4 -> y => 4
; 5 -> (^ x . (^ x . x)) => 5
; 6 -> (x (^ x . x)) => 6
; 7 -> z => 7
; 8 -> (^ y . x) => 8
; 9 -> ((^ x . x) x) => 9
; 10 -> x1 => 10
;
; In case you like these, here is one million lambda-expressions.
;
;
; (set 'out-file (open "C://lambda-expressions.txt" "write"))
; (for(i1 1 1000000)
;   (letn((i2 (lam i1 "xyz"))
;         (i3 (append (string i1) ".  " (string i2))))
;        (write-line out-file i3)))
; (close out-file)
;

(exit)

---------------------------------
199019 Reduced Lambda-Expressions
---------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/many-reduced-lambda-expressions.html

; The function that enumerates all lambda-expressions and the
; functions that perform few well known reductions of lambda-
; expressions are described in last posts. Recently, I wrote
; the program that generates and attempts to reduce all lambda-
; expressions to normal.
;
; Lambda expressions are enumerated and generated using Cantor's style
; enumeration of all lambda-expressions described in previous posts.
; However, some lambda expressions generated that way are obviously
; redundant. For example,
;
;                           ((^a.a) b)
;
; and
;                           ((^b.b) a)
;
; differ only in names of variables. To avoid such redundancies,
; program attempted to reduce only lambda expressions such that
; variables occur in alphabetical order, i.e. ((^a.a) b), but
; not ((^a.a) c) or ((^b.b) a). Program is left to work long
; enough so
;
;    23 969 511 lambda-expressions are generated
;
;       200 000 of these were non-redundant in just defined sense, and
;               attempts for reduction of these lambda-expressions
;               to normal form is done.
;
;       199 019 lambda-expressions are successefully reduced to
;               normal form,
;
;           934 lambda-expressions are proven irreducible, because
;               cycle is discovered and
;
;            47 lambda-expressions are not reduced: in 35 reductions
;               normal form wasn't reached, but cycle wasn't discovered
;               either. It appears that almost all of these
;               lambda-expressions grow infinitely.
;
; Standard lambda-reductions are used:
;
;    alpha reduction :  (^ x . x) <-> (^ y . y), i.e. bounded
;                       variables can be freely renamed.
;
;    eta reduction:     (^ x . (F x)) -> F i.e. elimination of
;                       redundant function definition
;
;    beta reduction:    ((^ x . F) G) -> F[x:=G], i.e. substitution
;                       of G for x in F. Beta reduction is not defined
;                       if G contains x as free variable.
;
; The reduction algorithm uses normal order of evaluation (i.e.
; like Lisp fexprs and Haskell functions), which is known to be
; superior to applicative order of evaluation (like functions in
; Lisp and in almost all other programming languages.)
;
; The program performs alpha-conversion after each reduction. Bounded
; variables are renamed to
;
;              x, y, z, x1, y1, z1, x2, ...
;
; The algorithm attempts to make eta-reduction before beta reduction.
; Although eta-reduction is prefered, it was done only 3047 times
; total, while beta-reduction is performed 304254 times, i.e. 100
; times more frequently.
;
; Here is one of them:
;
;   ------  8167/277305. ------
;
;   1. ==[ start ]==> ((^a.(a (a a)))((^a.(a a))(^a.a)))
;   2. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y y))(^z.z)))
;   3. ==[ beta  ]==> (((^y.(y y))(^z.z))(((^y.(y y))(^z.z))((^y.(y y))(^z.z))))
;   4. ==[ alpha ]==> (((^x.(x x))(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   5. ==[ beta  ]==> (((^y.y)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   6. ==[ alpha ]==> (((^x.x)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   7. ==[ beta  ]==> ((^y.y)(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   8. ==[ alpha ]==> ((^x.x)(((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1))))
;   9. ==[ beta  ]==> (((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1)))
;  10. ==[ alpha ]==> (((^x.(x x))(^y.y))((^z.(z z))(^x1.x1)))
;  11. ==[ beta  ]==> (((^y.y)(^y.y))((^z.(z z))(^x1.x1)))
;  12. ==[ alpha ]==> (((^x.x)(^y.y))((^z.(z z))(^x1.x1)))
;  13. ==[ beta  ]==> ((^y.y)((^z.(z z))(^x1.x1)))
;  14. ==[ alpha ]==> ((^x.x)((^y.(y y))(^z.z)))
;  15. ==[ beta  ]==> ((^y.(y y))(^z.z))
;  16. ==[ alpha ]==> ((^x.(x x))(^y.y))
;  17. ==[ beta  ]==> ((^y.y)(^y.y))
;  18. ==[ alpha ]==> ((^x.x)(^y.y))
;  19. ==[ beta  ]==> (^y.y)
;  20. ==[ alpha ]==> (^x.x)
;
;      REDUCED to normal form.
;
; For others, go to
;
;      Reduced lambda-expressions       1 -  25 000
;      Reduced lambda-expressions  25 001 -  50 000
;      Reduced lambda-expressions  50 001 -  75 000
;      Reduced lambda-expressions  75 001 - 100 000
;      Reduced lambda-expressions 100 001 - 125 000
;      Reduced lambda-expressions 125 001 - 150 000
;      Reduced lambda-expressions 150 001 - 175 000
;      Reduced lambda-expressions 175 001 - 200 000
;
; Alternatively, 200 000 of reduced lambda expressions in one large text file:
;
;      200 000 Reduced lambda-expressions
;
; Warning: that file is large: 60 MB.

Commenti:
---------
*** Kazimir Majorinc 13 November 2013 at 22:18
I'm glad you like it, Shaun. The files are just moved on http://kazimirmajorinc.com, currently under the "Programs".


-------------------------------
Lambda Calculus Interpreter (2)
-------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/lambda-calculus-interpreter-2.html

Use of "reduce^" from Newlisp REPL

c:\Newlisp>newlisp
newLISP v.10.2.18 on w1n32 IPv4/6. execute 'newl1sp -h' for more info.

> (setf [pr1ntln.supressed] true [print.supressed] true)
true
> (load "http://instprog.com/instprog.default-library.lsp")
true
(setf [println.supressed] nil [print.supressed] nil)
nil
> (reduce^ '(^ a . (a (a a)))((^ a . (a a))(^ a . a))) 25 true)
;   1. ==[ start ]==> ((^a.(a (a a)))((^a.(a a))(^a.a)))
;   2. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y y))(^z.z)))
;   3. ==[ beta  ]==> (((^y.(y y))(^z.z))(((^y.(y y))(^z.z))((^y.(y y))(^z.z))))
;   4. ==[ alpha ]==> (((^x.(x x))(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   5. ==[ beta  ]==> (((^y.y)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   6. ==[ alpha ]==> (((^x.x)(^y.y))(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   7. ==[ beta  ]==> ((^y.y)(((^z.(z z))(^x1.x1))((^y1.(y1 y1))(^z1.z1))))
;   8. ==[ alpha ]==> ((^x.x)(((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1))))
;   9. ==[ beta  ]==> (((^y.(y y))(^z.z))((^x1.(x1 x1))(^y1.y1)))
;  10. ==[ alpha ]==> (((^x.(x x))(^y.y))((^z.(z z))(^x1.x1)))
;  11. ==[ beta  ]==> (((^y.y)(^y.y))((^z.(z z))(^x1.x1)))
;  12. ==[ alpha ]==> (((^x.x)(^y.y))((^z.(z z))(^x1.x1)))
;  13. ==[ beta  ]==> ((^y.y)((^z.(z z))(^x1.x1)))
;  14. ==[ alpha ]==> ((^x.x)((^y.(y y))(^z.z)))
;  15. ==[ beta  ]==> ((^y.(y y))(^z.z))
;  16. ==[ alpha ]==> ((^x.(x x))(^y.y))
;  17. ==[ beta  ]==> ((^y.y)(^y.y))
;  18. ==[ alpha ]==> ((^x.x)(^y.y))
;  19. ==[ beta  ]==> (^y.y)
;  20. ==[ alpha ]==> (^x.x)

    REDUCED to normal form.
(reduced (^ x . x) 20)

(setf [println.supressed] true [print.supressed] true)
(load "http://instprog.com/Instprog.default-library.lsp" )
(setf [println.supressed] nil [print.supressed] nil)

;---------------------------------------------------------------
; Interpreter for lambda-calculus, described in recent posts is now
; integrated in my library for Newlisp, as function "reduce^".
;
; Here is example demonstrating how it works. If you want to see
; implementatition details, check the library. Check the previous
; posts also.

(println  (reduce^ '((^ x . (x (x x))) (^ y . (y (y y)))) ;lambda-expression

                        10   ;maximal number of reductions,
                             ;useful for non-terminating lambda-expressions

                        true ;true if you want reduction steps are printed on screen
                             ;nil if you want "silent" interpretation
                        ))

(println  (reduce^ '((^ x . x) (^ x . x))

                        10

                        true

                        ))

(println (reduce^ '((^ x . (x x)) (^ x . (x x)))

                        10

                        true
                        ))


(exit)

; OUTPUT:
;
;   1. ==[ start ]==> ((^x.(x (x x)))(^y.(y (y y))))
;   2. ==[ beta  ]==> ((^y.(y (y y)))((^y.(y (y y)))(^y.(y (y y)))))
;   3. ==[ alpha ]==> ((^x.(x (x x)))((^y.(y (y y)))(^z.(z (z z)))))
; ...
;
;      UNREDUCED: maximal number of reductions reached.
;
; (unreduced ((((^ y . (y (y y))) ((^ y . (y (y y))) (^ y . (y (y y))))) (((^ z . (
;        z
;        (z z)))
;      (^ x1 . (x1 (x1 x1))))
;     ((^ y1 . (y1 (y1 y1))) (^ z1 . (z1 (z1 z1))))))
;   (((^ x2 . (x2 (x2 x2))) (^ y2 . (y2 (y2 y2)))) ((^ z2 . (z2 (z2 z2))) (^ x3 . (
;       x3
;       (x3 x3)))))) 10)
;
;   1. ==[ start ]==> ((^x.x)(^x.x))
;   2. ==[ alpha ]==> ((^x.x)(^y.y))
;   3. ==[ beta  ]==> (^y.y)
;   4. ==[ alpha ]==> (^x.x)
;
;      REDUCED to normal form.
;
; (reduced (^ x . x) 4)
;
;   1. ==[ start ]==> ((^x.(x x))(^x.(x x)))
;   2. ==[ alpha ]==> ((^x.(x x))(^y.(y y)))
;   3. ==[ beta  ]==> ((^y.(y y))(^y.(y y)))
;   4. ==[ alpha ]==> ((^x.(x x))(^y.(y y)))
;
;      IRREDUCIBLE: cycle.
;
; (irreducible ((^ x . (x x)) (^ y . (y y))) 4)
;
;
;

If you like this post, you'll probably like: "Almost two hundred thousand reduced lambda-expressions".


-----------------------------------------------------
Some differences between lambda-calculus and Lisp (1)
-----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/some-differences-between-lambda.html

;                        0. Introduction
;
;
; At the first sight, Lisp dialects appear like extensions of the
; lambda-calculus. Syntax of the two is especially similar. For
; instance,
;
;                          ((^ x . x) y)
;
; in lambda-calculus is very similar to
;
;                         ((lambda(x)x) y)
;
; in Lisp. However, it turns that there are many important
; differences between lambda-calculus and Lisp, some of these
; are obvious, and others are quite subtle. In this post, I'll
; list and comment few of these I've find to be interesting and
; important. The post is not tutorial on lambda-calculus, but
; another view that might be interesting to those who already
; know lambda-calculus, but maybe also - to some extent - to those
; who do not know it yet.
;
;
;
;        1. The notion of lambda-expression
;
;
; There is significant difference even in basic terminology.
; For instance, this is definition of lambda-expression in Common
; Lisp Hyperspec:
;
;    "lambda expression n. a list which can be used in place of a
;     function name in certain contexts to denote a function by
;     directly describing its behavior rather than indirectly by
;     referring to the name of an established function; its name
;     derives from the fact that its first element is the symbol
;     lambda."
;
; In lambda-calculus, lambda-expression is the name used for
; all allowed expressions of lambda-calculus. According to definition,
; lambda expressions are:
;
;       1. variables: a, b, c, d ... a1, a2, ...
;       2. functions: (^ v . F), where v is any variable, F any lambda-expr.
;       3. applications: (E F), where E and F are lambda-expressions.
;
; This difference, although not essential is very confusing one.
;
;
;
;                 2. Evaluation vs. reduction
;
;
; In Lisp, expressions are "evaluated." For instance,
;
;            ((lambda(x)x) y) => value of y.
;
; In lambda-calculus, expressions are "reduced". Reduction
; doesn't require replacement of the variables with values, so
;
;                   ((^ x . x) y) => y
;
; and not
;
;                   ((^ x . x) y) => value of y.
;
; If we remember high school math, some of the exercises were of
; the form "simplify" or "expand", and didn't required knowledge
; about value of the variables to be solved.
;
;           (x+1)^2 -1 ==> (x^2+2x+1) -1 = x(x+2)
;
; Other group of exercises clearly required evaluation:
;
;       "Find the area of the rhomboid with sides
;        a=4, b=3, and angle of 30° between them."
;
;
;
;       3. Recursiveness of evaluation in Lisp
;                                 vs.
;           non-recursiveness of beta-reduction
;                     in lambda-calculus
;
;
; There are three reductions in lambda-calculus; only short
; resume here - formal definition find somewhere else.
;
;     1. Beta-reduction: the application of the function
;
;                ((^x.x) a) => a,
;                ((^x.(x x)) a) => (a a).
;
;     2. Alpha-reduction: renaming of the bounded variables
;
;                (^x.x) => (^y.y).
;
;     3. Eta-reduction: elimination of the redundant function
;
;                (^x.((^y.y)x)) => (^y.y).
;
;        (eta-reduction is not essential; it can be replaced
;         with other two.)
;
; Beta-reduction is very similar to function application
; in Lisp. However, there are significant differences.
;

;
; In Lisp, evaluation of the function application, for instance,
;
;                  ((lambda(x)(x x)) (a b))
;
; is performed on the following way:
;
;    - argument (here (a b)) is evaluated;
;    - result is assigned to the parameter (here x), and
;    - body of the function, (here (x x)) is evaluated.
;    - the result is returned as the result of  evaluation of
;      whole expression.
;
;
; In lambda-calculus, beta-reduction of the application,
; for instance,
;
;                    ((^x.(x x)) (a b))
;
; is performed on a following way:
;
;     - argument (here (a b)) is substituted for parameter (here x)
;       in the body of the function (here (x x)).
;     - the result of the substitution is result of beta-reduction.
;
; The result of the two is significantly different.
;
;     Note that beta reduction does significantly less than
;     evaluation. Beta-reduction doesn't apply itself recursively
;     on y and on (x x), while evaluation in Lisp does - it requires
;     evaluation of
;
;
;
;      3.1. Example: Church's lambda in Newlisp
;
;
; I'll use previous discussion to define
;
;                        lambda-Church
;
; in Newlisp, so expressions using it are evaluated just like
; lambda-expressions are beta reduced in lambda-calculus. For
; instance, I want
;
;                   ((lambda-Church (x) (x x)) (a b))
;
; to evalute to
;
;                      ((a b)(a b)).
;
; What should I do? In Newlisp, because it has fexprs, its easy.
; Expression
;
;                     (lambda-Church (x) (x x))
;
; should be evaluated to
;
;               (lambda-macro(x)(expand (quote (x x))
;                                       (quote x)))
;
; and that's all.

(define-macro (lambda-Church head body)
  (let ((var (first head)))
     (expand (lambda-macro(var)(expand (quote body)
                                       (quote var)))
             (quote body)
             (quote var))))

; Let's test it.

(println (lambda-Church (x)(x x)))

;    ==> (lambda-macro (x) (expand (quote (x x)) (quote x)))

(println ((lambda-Church (x)(x x)) (a b)))

;    ==> ((a b) (a b))
;
; It works. In future, lambda-Church expressions can
; be freely mixed with other Newlisp expressions.
;
;
;
; To be  continued  ...


-----------------------------------------------------
Some differences between lambda-calculus and Lisp (2)
-----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/01/some-differences-between-lambda_31.html


; This is the second part of  previous post .
;
;
;
;                4. Evaluation in Lisp vs.
;    reduction to normal form in lambda-calculus
;
;
; As noted in previous post, in Lisp, evaluation of the function
; application is defined recursively:
;
;      1.  evaluation of the function arguments is performed
;      2.  resulting values are assigned to the parameters of
;          the function
;      2.  evaluation of the function body is performed
;
; In lambda calculus, beta-reductions do not recurse on that way.
; There is no "automatic" beta-reductions of the argument of the
; application.
;
; Because of that, in general case, one applies reductions many
; times to achieve similar effect. How many times? Typically,
; until further reduction is impossible; in that case, it is
; said that expression is reduced to normal form.
;
; There are few differences between evaluation in Lisp and
; reduction to normal form in lambda-calculus:
;
;
;              4.1. Order of reductions in
;            lambda-calculus is not defined
;
;
; Lambda-calculus is not an algorithm. It is a "formal system". One
; who performs reductions - human or computer - can pick the order of
; reductions by any criteria.
;
;
;     4.2. Lisp evaluation strategy is not the best for
;                     lambda-calculus
;
;
; In Lisp, order of evaluations is "from inside"; if application
; is evaluated, for example,
;
;          ((lambda(x)(+ x x)) ((lambda(x)(* x x)) 3) 2)
;
; then inner left argument, in this case
;
;                     ((lambda(x)(* x x)) 3)
;
; is evaluated first. That order is called "applicative order".
; In lambda-calculus, some expressions cannot be reduced applying
; that order of reductions. For example,
;
;               ((^x.a) ((^x.(x x)) (^x.(x x))))
;
; would be reduced indefinitely, because reduction of
;
;                   ((^x.(x x)) (^x.(x x)))
;
; doesn't terminate. Some other evaluation strategies, for example,
; "normal order", "from outside", as defined in lambda-Church, terminate:
;
(println ((lambda-Church (x) a) ((lambda-Church(x)(x x))
                                 (lambda-Church(x)(x x)))))

;        => a
;
;
;
;        4.3. Reduction to normal form is more
;           extensive than single evaluation
;
;
; 1. In Lisp, function, like
;
;              (lambda(x)((lambda(y)y) x)),
;
;    if evaluated is either evaluated to some "compiled value",
;    i.e. it is not S-expression any more - or evaluates to
;    itself, as in Newlisp.
;
;    In lambda-calculus, reduction is performed inside the function
;    body. For example,
;
;               (^x.((^y.y) x)) => (^x.x).
;
; 2. In Lisp, result of the evaluation of the S-expression is frequently
;    in form that allows further evaluation.
;
;               ((lambda(x)(list '+ 1 2 x)) 3) => '(+ 1 2 3)
;
;But, it is not evaluated automatically.

;
;
; To be continued ...


--------------------------------------------------------------
Some Basic Concepts Implemented and Reduced in Lambda-calculus
--------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/02/some-basic-concepts-implemented-and.html

; After support for meta-variables in lambda-calculus is integrated
; in my Newlisp library, I can easily demonstrate few fundamental
; concepts: Boolean constants, integers, IF, predecessor, successor,
; multiplication and recursion are implemented in lambda calculus
; and how reduction of the expressions really looks like.
;
; At the end, factorial function is implemented - this time without
; full reduction, because even reduction of (FACTORIAL 0) is too
; large to be published in blog. However, you can try it for yourself.
;
; Watch out: it is frequently said this can be done, but it is
; rarely actually done.
;
;                    LOADING LIBRARY
;

(setf [print.supressed] true [println.supressed] true)
(load "http://instprog.com/Instprog.default-library.lsp")
(setf [print.supressed] nil [println.supressed] nil)

;---------------------------------------------------------------

(setf TRUE '(^ x .(^ y . x)))

    (expand-and-reduce^ '((TRUE a) b) ; <- lambda-expression
                         5000         ; <- max number of expansions
                                      ;    and reductions
                         true)        ; <- true if output is needed

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((TRUE a) b)
;
;     1. ==[ original ]==> ((TRUE a) b)
;     2. ==[ expanded ]==> (((^x.(^y.x)) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^x.(^y.x)) a) b)
;     2. ==[ beta     ]==> ((^y.a) b)
;     3. ==[ alpha    ]==> ((^x.a) b)
;     4. ==[ beta     ]==> a
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------


(setf FALSE '(^ x . (^ y . y)))

     (expand-and-reduce^ '((FALSE a) b)
                         5000
                         true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((FALSE a) b)
;
;     1. ==[ original ]==> ((FALSE a) b)
;     2. ==[ expanded ]==> (((^x.(^y.y)) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^x.(^y.y)) a) b)
;     2. ==[ beta     ]==> ((^y.y) b)
;     3. ==[ alpha    ]==> ((^x.x) b)
;     4. ==[ beta     ]==> b
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf IF '(^ v .(^ t . (^ f . ((v t) f)))))

     (expand-and-reduce^ '(((IF a) b) c)
                         5000
                         true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF a) b) c)
;
;     1. ==[ original ]==> (((IF a) b) c)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f)))) a) b) c)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f)))) a) b) c)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z)))) a) b) c)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y))) a) b) c)
;     4. ==[ eta      ]==> ((((^x.x) a) b) c)
;     5. ==[ beta     ]==> ((a b) c)
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

     (expand-and-reduce^ '(((IF TRUE) a) b)
                          5000
                          true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF TRUE) a) b)
;
;     1. ==[ original ]==> (((IF TRUE) a) b)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.x))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.x))) a) b)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z))))(^u.(^v.u))) a) b)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y)))(^u.(^v.u))) a) b)
;     4. ==[ alpha    ]==> ((((^x.(^y.(x y)))(^z.(^u.z))) a) b)
;     5. ==[ eta      ]==> ((((^x.x)(^z.(^u.z))) a) b)
;     6. ==[ alpha    ]==> ((((^x.x)(^y.(^z.y))) a) b)
;     7. ==[ beta     ]==> (((^y.(^z.y)) a) b)
;     8. ==[ alpha    ]==> (((^x.(^y.x)) a) b)
;     9. ==[ beta     ]==> ((^y.a) b)
;    10. ==[ alpha    ]==> ((^x.a) b)
;    11. ==[ beta     ]==> a
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

     (expand-and-reduce^ '(((IF FALSE) a) b)
                          5000
                          true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (((IF FALSE) a) b)
;
;     1. ==[ original ]==> (((IF FALSE) a) b)
;     2. ==[ expanded ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.y))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((((^v.(^t.(^f.((v t) f))))(^x.(^y.y))) a) b)
;     2. ==[ alpha    ]==> ((((^x.(^y.(^z.((x y) z))))(^u.(^v.v))) a) b)
;     3. ==[ eta      ]==> ((((^x.(^y.(x y)))(^u.(^v.v))) a) b)
;     4. ==[ alpha    ]==> ((((^x.(^y.(x y)))(^z.(^u.u))) a) b)
;     5. ==[ eta      ]==> ((((^x.x)(^z.(^u.u))) a) b)
;     6. ==[ alpha    ]==> ((((^x.x)(^y.(^z.z))) a) b)
;     7. ==[ beta     ]==> (((^y.(^z.z)) a) b)
;     8. ==[ alpha    ]==> (((^x.(^y.y)) a) b)
;     9. ==[ beta     ]==> ((^y.y) b)
;    10. ==[ alpha    ]==> ((^x.x) b)
;    11. ==[ beta     ]==> b
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf APPLY '(^ v .(^ f . (v f))))

     (expand-and-reduce^ '((APPLY a) b)
                          5000
                          true)

;----------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((APPLY a) b)
;
;     1. ==[ original ]==> ((APPLY a) b)
;     2. ==[ expanded ]==> (((^v.(^f.(v f))) a) b)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^v.(^f.(v f))) a) b)
;     2. ==[ alpha    ]==> (((^x.(^y.(x y))) a) b)
;     3. ==[ eta      ]==> (((^x.x) a) b)
;     4. ==[ beta     ]==> (a b)
;
;        REDUCED TO NORMAL FORM.
;
;----------------------------------------------------------------

; Y-combinator is tool that could be used for implementation of
; recursion

(setf Y '(^ f . ((^ x . (f (x x))) (^ x . (f (x x))))))

     (expand-and-reduce^ '(Y g)
                         12
                         true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (Y g)
;
;     1. ==[ original ]==> (Y g)
;     2. ==[ expanded ]==> ((^f.((^x.(f (x x)))(^x.(f (x x))))) g)
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^f.((^x.(f (x x)))(^x.(f (x x))))) g)
;     2. ==[ alpha    ]==> ((^x.((^y.(x (y y)))(^z.(x (z z))))) g)
;     3. ==[ beta     ]==> ((^y.(g (y y)))(^z.(g (z z))))
;     4. ==[ alpha    ]==> ((^x.(g (x x)))(^y.(g (y y))))
;     5. ==[ beta     ]==> (g ((^y.(g (y y)))(^y.(g (y y)))))
;     6. ==[ alpha    ]==> (g ((^x.(g (x x)))(^y.(g (y y)))))
;     7. ==[ beta     ]==> (g (g ((^y.(g (y y)))(^y.(g (y y))))))
;     8. ==[ alpha    ]==> (g (g ((^x.(g (x x)))(^y.(g (y y))))))
;     9. ==[ beta     ]==> (g (g (g ((^y.(g (y y)))(^y.(g (y y)))))))
;    10. ==[ alpha    ]==> (g (g (g ((^x.(g (x x)))(^y.(g (y y)))))))
;    11. ==[ beta     ]==> (g (g (g (g ((^y.(g (y y)))(^y.(g (y y))))))))
;    12. ==[ alpha    ]==> (g (g (g (g ((^x.(g (x x)))(^y.(g (y y))))))))
;
;        UNREDUCED: MAX NUMBER OF REDUCTIONS REACHED.
;
; Take a look on the way "reduced" lambda-expression looks like;
;
;  (Y g) is reduced to (g (Y g))! If we use some more complicated
;  formula instead of g, and normal order of reduction, then
;  g will be evaluated first.
;
;---------------------------------------------------------------
(setf ZERO '(^ f . (^ x . x)))

   (expand-and-reduce^ ZERO
                       5000
                       true)

;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (^f.(^x.x))
;
;     1. ==[ original ]==> (^f.(^x.x))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (^f.(^x.x))
;     2. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf SUCCESSOR '(^ n . (^ f . (^ x . (f ((n f) x))))))

   (expand-and-reduce^ '(SUCCESSOR ZERO)
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (SUCCESSOR ZERO)
;
;     1. ==[ original ]==> (SUCCESSOR ZERO)
;     2. ==[ expanded ]==> ((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))
;     2. ==[ alpha    ]==> ((^x.(^y.(^z.(y ((x y) z)))))(^u.(^v.v)))
;     3. ==[ beta     ]==> (^y.(^z.(y (((^u.(^v.v)) y) z))))
;     4. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.u)) x) y))))
;     5. ==[ beta     ]==> (^x.(^y.(x ((^u.u) y))))
;     6. ==[ alpha    ]==> (^x.(^y.(x ((^z.z) y))))
;     7. ==[ beta     ]==> (^x.(^y.(x y)))
;     8. ==[ eta      ]==> (^x.x)
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf ONE '(^ x . x))

   (expand-and-reduce^ '(SUCCESSOR (SUCCESSOR ZERO))
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (SUCCESSOR (SUCCESSOR ZERO))
;
;     1. ==[ original ]==> (SUCCESSOR (SUCCESSOR ZERO))
;     2. ==[ expanded ]==> ((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     2. ==[ alpha    ]==> ((^x.(^y.(^z.(y ((x y) z)))))((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))))
;     3. ==[ beta     ]==> (^y.(^z.(y ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) y) z))))
;     4. ==[ alpha    ]==> (^x.(^y.(x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x) y))))
;     5. ==[ beta     ]==> (^x.(^y.(x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x) y))))
;     6. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x) y))))
;     7. ==[ beta     ]==> (^x.(^y.(x ((^u.(x (((^v.(^w.w)) x) u))) y))))
;     8. ==[ alpha    ]==> (^x.(^y.(x ((^z.(x (((^u.(^v.v)) x) z))) y))))
;     9. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.v)) x) y)))))
;    10. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.u)) x) y)))))
;    11. ==[ beta     ]==> (^x.(^y.(x (x ((^u.u) y)))))
;    12. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.z) y)))))
;    13. ==[ beta     ]==> (^x.(^y.(x (x y))))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf ZERO? '(^ n . ((n (TRUE FALSE)) TRUE)))

   (expand-and-reduce^ '(ZERO? ZERO)
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (ZERO? ZERO)
;
;     1. ==[ original ]==> (ZERO? ZERO)
;     2. ==[ expanded ]==> ((^n.((n (TRUE FALSE)) TRUE))(^f.(^x.x)))
;     3. ==[ expanded ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))(^f.(^x.x)))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))(^f.(^x.x)))
;     2. ==[ alpha    ]==> ((^x.((x ((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w))))(^q.(^r.r)))
;     3. ==[ beta     ]==> (((^q.(^r.r))((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w)))
;     4. ==[ alpha    ]==> (((^x.(^y.y))((^z.(^u.z))(^v.(^w.w))))(^p.(^q.p)))
;     5. ==[ beta     ]==> ((^y.y)(^p.(^q.p)))
;     6. ==[ alpha    ]==> ((^x.x)(^y.(^z.y)))
;     7. ==[ beta     ]==> (^y.(^z.y))
;     8. ==[ alpha    ]==> (^x.(^y.x))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

   (expand-and-reduce^ '(ZERO? (SUCCESSOR ZERO))
                       5000
                       true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (ZERO? (SUCCESSOR ZERO))
;
;     1. ==[ original ]==> (ZERO? (SUCCESSOR ZERO))
;     2. ==[ expanded ]==> ((^n.((n (TRUE FALSE)) TRUE))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     3. ==[ expanded ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.((n ((^x.(^y.x))(^x.(^y.y))))(^x.(^y.x))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x))))
;     2. ==[ alpha    ]==> ((^x.((x ((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w))))((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1))))
;     3. ==[ beta     ]==> ((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))((^y.(^z.y))(^u.(^v.v))))(^w.(^p.w)))
;     4. ==[ alpha    ]==> ((((^x.(^y.(^z.(y ((x y) z)))))(^u.(^v.v)))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1)))
;     5. ==[ beta     ]==> (((^y.(^z.(y (((^u.(^v.v)) y) z))))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1)))
;     6. ==[ alpha    ]==> (((^x.(^y.(x (((^z.(^u.u)) x) y))))((^v.(^w.v))(^p.(^q.q))))(^r.(^x1.r)))
;     7. ==[ beta     ]==> ((^y.(((^v.(^w.v))(^p.(^q.q)))(((^z.(^u.u))((^v.(^w.v))(^p.(^q.q)))) y)))(^r.(^x1.r)))
;     8. ==[ alpha    ]==> ((^x.(((^y.(^z.y))(^u.(^v.v)))(((^w.(^p.p))((^q.(^r.q))(^x1.(^y1.y1)))) x)))(^z1.(^u1.z1)))
;     9. ==[ beta     ]==> (((^y.(^z.y))(^u.(^v.v)))(((^w.(^p.p))((^q.(^r.q))(^x1.(^y1.y1))))(^z1.(^u1.z1))))
;    10. ==[ alpha    ]==> (((^x.(^y.x))(^z.(^u.u)))(((^v.(^w.w))((^p.(^q.p))(^r.(^x1.x1))))(^y1.(^z1.y1))))
;    11. ==[ beta     ]==> ((^y.(^z.(^u.u)))(((^v.(^w.w))((^p.(^q.p))(^r.(^x1.x1))))(^y1.(^z1.y1))))
;    12. ==[ alpha    ]==> ((^x.(^y.(^z.z)))(((^u.(^v.v))((^w.(^p.w))(^q.(^r.r))))(^x1.(^y1.x1))))
;    13. ==[ beta     ]==> (^y.(^z.z))
;    14. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf MULTIPLY '(^ m . (^ n . (^ f . (m (n f))))))

   (expand-and-reduce^ '((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))
                                   (SUCCESSOR (SUCCESSOR ZERO)))
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF ((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))(SUCCESSOR (SUCCESSOR ZERO)))
;
;     1. ==[ original ]==> ((MULTIPLY (SUCCESSOR (SUCCESSOR ZERO)))(SUCCESSOR (SUCCESSOR ZERO)))
;     2. ==[ expanded ]==> (((^m.(^n.(^f.(m (n f)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> (((^m.(^n.(^f.(m (n f)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))((^n.(^f.(^x.(f ((n f) x)))))((^n.(^f.(^x.(f ((n f) x)))))(^f.(^x.x)))))
;     2. ==[ alpha    ]==> (((^x.(^y.(^z.(x (y z)))))((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))))
;     3. ==[ beta     ]==> ((^y.(^z.(((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1))))(y z))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))))
;     4. ==[ alpha    ]==> ((^x.(^y.(((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))))(x y))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))))
;     5. ==[ beta     ]==> (^y.(((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) y)))
;     6. ==[ alpha    ]==> (^x.(((^y.(^z.(^u.(z ((y z) u)))))((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)))
;     7. ==[ beta     ]==> (^x.((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u))))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)))
;     8. ==[ alpha    ]==> (^x.((^y.(^z.(y ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) y) z))))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)))
;     9. ==[ beta     ]==> (^x.(^z.((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) z))))
;    10. ==[ alpha    ]==> (^x.(^y.((((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))) x)((((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))(((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))((^x2.(^y2.(^z2.(y2 ((x2 y2) z2)))))(^u2.(^v2.v2)))) x)) y))))
;    11. ==[ beta     ]==> (^x.(^y.(((^u.(^v.(u ((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))) u) v)))) x)((((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))(((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))((^x2.(^y2.(^z2.(y2 ((x2 y2) z2)))))(^u2.(^v2.v2)))) x)) y))))
;    12. ==[ alpha    ]==> (^x.(^y.(((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u)))) x)((((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))(((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))((^r1.(^x2.(^y2.(x2 ((r1 x2) y2)))))(^z2.(^u2.u2)))) x)) y))))
;    13. ==[ beta     ]==> (^x.(^y.((^u.(x ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) x) u)))((((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))(((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))((^r1.(^x2.(^y2.(x2 ((r1 x2) y2)))))(^z2.(^u2.u2)))) x)) y))))
;    14. ==[ alpha    ]==> (^x.(^y.((^z.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x) z)))((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y))))
;    15. ==[ beta     ]==> (^x.(^y.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x)((((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y)))))
;    16. ==[ alpha    ]==> (^x.(^y.(x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x)((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y)))))
;    17. ==[ beta     ]==> (^x.(^y.(x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x)((((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y)))))
;    18. ==[ alpha    ]==> (^x.(^y.(x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x)((((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y)))))
;    19. ==[ beta     ]==> (^x.(^y.(x ((^u.(x (((^v.(^w.w)) x) u)))((((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y)))))
;    20. ==[ alpha    ]==> (^x.(^y.(x ((^z.(x (((^u.(^v.v)) x) z)))((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y)))))
;    21. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.v)) x)((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y))))))
;    22. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.u)) x)((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r)))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y))))))
;    23. ==[ beta     ]==> (^x.(^y.(x (x ((^u.u)((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r)))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y))))))
;    24. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.z)((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y))))))
;    25. ==[ beta     ]==> (^x.(^y.(x (x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q)))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))
;    26. ==[ alpha    ]==> (^x.(^y.(x (x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p)))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))
;    27. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.(u (((^w.(^p.p)) u) v))))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))
;    28. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.(z (((^v.(^w.w)) z) u))))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y)))))
;    29. ==[ beta     ]==> (^x.(^y.(x (x ((^u.((((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) u))) y)))))
;    30. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.((((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))) x)(((^z1.(^u1.u1))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) z))) y)))))
;    31. ==[ beta     ]==> (^x.(^y.(x (x ((((^u.(^v.(^w.(v ((u v) w)))))((^p.(^q.(^r.(q ((p q) r)))))(^x1.(^y1.y1)))) x)(((^z1.(^u1.u1))(((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))((^q1.(^r1.(^x2.(r1 ((q1 r1) x2)))))(^y2.(^z2.z2)))) x)) y))))))
;    32. ==[ alpha    ]==> (^x.(^y.(x (x ((((^z.(^u.(^v.(u ((z u) v)))))((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1)))) x)(((^y1.(^z1.z1))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y))))))
;    33. ==[ beta     ]==> (^x.(^y.(x (x (((^u.(^v.(u ((((^w.(^p.(^q.(p ((w p) q)))))(^r.(^x1.x1))) u) v)))) x)(((^y1.(^z1.z1))(((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))((^p1.(^q1.(^r1.(q1 ((p1 q1) r1)))))(^x2.(^y2.y2)))) x)) y))))))
;    34. ==[ alpha    ]==> (^x.(^y.(x (x (((^z.(^u.(z ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) z) u)))) x)(((^x1.(^y1.y1))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y))))))
;    35. ==[ beta     ]==> (^x.(^y.(x (x ((^u.(x ((((^v.(^w.(^p.(w ((v w) p)))))(^q.(^r.r))) x) u)))(((^x1.(^y1.y1))(((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))((^w1.(^p1.(^q1.(p1 ((w1 p1) q1)))))(^r1.(^x2.x2)))) x)) y))))))
;    36. ==[ alpha    ]==> (^x.(^y.(x (x ((^z.(x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x) z)))(((^r.(^x1.x1))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y))))))
;    37. ==[ beta     ]==> (^x.(^y.(x (x (x ((((^u.(^v.(^w.(v ((u v) w)))))(^p.(^q.q))) x)(((^r.(^x1.x1))(((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))((^v1.(^w1.(^p1.(w1 ((v1 w1) p1)))))(^q1.(^r1.r1)))) x)) y)))))))
;    38. ==[ alpha    ]==> (^x.(^y.(x (x (x ((((^z.(^u.(^v.(u ((z u) v)))))(^w.(^p.p))) x)(((^q.(^r.r))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y)))))))
;    39. ==[ beta     ]==> (^x.(^y.(x (x (x (((^u.(^v.(u (((^w.(^p.p)) u) v)))) x)(((^q.(^r.r))(((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))((^u1.(^v1.(^w1.(v1 ((u1 v1) w1)))))(^p1.(^q1.q1)))) x)) y)))))))
;    40. ==[ alpha    ]==> (^x.(^y.(x (x (x (((^z.(^u.(z (((^v.(^w.w)) z) u)))) x)(((^p.(^q.q))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))))
;    41. ==[ beta     ]==> (^x.(^y.(x (x (x ((^u.(x (((^v.(^w.w)) x) u)))(((^p.(^q.q))(((^r.(^x1.(^y1.(x1 ((r x1) y1)))))((^z1.(^u1.(^v1.(u1 ((z1 u1) v1)))))(^w1.(^p1.p1)))) x)) y)))))))
;    42. ==[ alpha    ]==> (^x.(^y.(x (x (x ((^z.(x (((^u.(^v.v)) x) z)))(((^w.(^p.p))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y)))))))
;    43. ==[ beta     ]==> (^x.(^y.(x (x (x (x (((^u.(^v.v)) x)(((^w.(^p.p))(((^q.(^r.(^x1.(r ((q r) x1)))))((^y1.(^z1.(^u1.(z1 ((y1 z1) u1)))))(^v1.(^w1.w1)))) x)) y))))))))
;    44. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (((^z.(^u.u)) x)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y))))))))
;    45. ==[ beta     ]==> (^x.(^y.(x (x (x (x ((^u.u)(((^v.(^w.w))(((^p.(^q.(^r.(q ((p q) r)))))((^x1.(^y1.(^z1.(y1 ((x1 y1) z1)))))(^u1.(^v1.v1)))) x)) y))))))))
;    46. ==[ alpha    ]==> (^x.(^y.(x (x (x (x ((^z.z)(((^u.(^v.v))(((^w.(^p.(^q.(p ((w p) q)))))((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))) x)) y))))))))
;    47. ==[ beta     ]==> (^x.(^y.(x (x (x (x (((^u.(^v.v))(((^w.(^p.(^q.(p ((w p) q)))))((^r.(^x1.(^y1.(x1 ((r x1) y1)))))(^z1.(^u1.u1)))) x)) y)))))))
;    48. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (((^z.(^u.u))(((^v.(^w.(^p.(w ((v w) p)))))((^q.(^r.(^x1.(r ((q r) x1)))))(^y1.(^z1.z1)))) x)) y)))))))
;    49. ==[ beta     ]==> (^x.(^y.(x (x (x (x ((^u.u) y)))))))
;    50. ==[ alpha    ]==> (^x.(^y.(x (x (x (x ((^z.z) y)))))))
;    51. ==[ beta     ]==> (^x.(^y.(x (x (x (x y))))))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
(setf PREDECESSOR '(^ n . (((n (^ p . (^ z . ((z (SUCCESSOR (p TRUE)))
                                              (p TRUE)))))
                             (^ z . ((z ZERO) ZERO)))
                           FALSE)))

    (expand-and-reduce^ '(PREDECESSOR ONE)
                        5000
                        true)
;---------------------------------------------------------------
;
;        EXPANSION AND REDUCTION OF (PREDECESSOR ONE)
;
;     1. ==[ original ]==> (PREDECESSOR ONE)
;     2. ==[ expanded ]==> ((^n.(((n (^p.(^z.((z (SUCCESSOR (p TRUE)))(p TRUE)))))(^z.((z ZERO) ZERO))) FALSE))(^x.x))
;     3. ==[ expanded ]==> ((^n.(((n (^p.(^z.((z ((^n.(^f.(^x.(f ((n f) x)))))(p (^x.(^y.x)))))(p (^x.(^y.x)))))))(^z.((z (^f.(^x.x)))(^f.(^x.x)))))(^x.(^y.y))))(^x.x))
;
;        META-VARIABLES EXPANDED.
;
;     1. ==[ start    ]==> ((^n.(((n (^p.(^z.((z ((^n.(^f.(^x.(f ((n f) x)))))(p (^x.(^y.x)))))(p (^x.(^y.x)))))))(^z.((z (^f.(^x.x)))(^f.(^x.x)))))(^x.(^y.y))))(^x.x))
;     2. ==[ alpha    ]==> ((^x.(((x (^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1))))(^r1.r1))
;     3. ==[ beta     ]==> ((((^r1.r1)(^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     4. ==[ alpha    ]==> ((((^x.x)(^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r)))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     5. ==[ beta     ]==> (((^y.(^z.((z ((^u.(^v.(^w.(v ((u v) w)))))(y (^p.(^q.p)))))(y (^r.(^x1.r))))))(^y1.((y1 (^z1.(^u1.u1)))(^v1.(^w1.w1)))))(^p1.(^q1.q1)))
;     6. ==[ alpha    ]==> (((^x.(^y.((y ((^z.(^u.(^v.(u ((z u) v)))))(x (^w.(^p.w)))))(x (^q.(^r.q))))))(^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1)))))(^w1.(^p1.p1)))
;     7. ==[ beta     ]==> ((^y.((y ((^z.(^u.(^v.(u ((z u) v)))))((^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1))))(^w.(^p.w)))))((^x1.((x1 (^y1.(^z1.z1)))(^u1.(^v1.v1))))(^q.(^r.q)))))(^w1.(^p1.p1)))
;     8. ==[ alpha    ]==> ((^x.((x ((^y.(^z.(^u.(z ((y z) u)))))((^v.((v (^w.(^p.p)))(^q.(^r.r))))(^x1.(^y1.x1)))))((^z1.((z1 (^u1.(^v1.v1)))(^w1.(^p1.p1))))(^q1.(^r1.q1)))))(^x2.(^y2.y2)))
;     9. ==[ beta     ]==> (((^x2.(^y2.y2))((^y.(^z.(^u.(z ((y z) u)))))((^v.((v (^w.(^p.p)))(^q.(^r.r))))(^x1.(^y1.x1)))))((^z1.((z1 (^u1.(^v1.v1)))(^w1.(^p1.p1))))(^q1.(^r1.q1))))
;    10. ==[ alpha    ]==> (((^x.(^y.y))((^z.(^u.(^v.(u ((z u) v)))))((^w.((w (^p.(^q.q)))(^r.(^x1.x1))))(^y1.(^z1.y1)))))((^u1.((u1 (^v1.(^w1.w1)))(^p1.(^q1.q1))))(^r1.(^x2.r1))))
;    11. ==[ beta     ]==> ((^y.y)((^u1.((u1 (^v1.(^w1.w1)))(^p1.(^q1.q1))))(^r1.(^x2.r1))))
;    12. ==[ alpha    ]==> ((^x.x)((^y.((y (^z.(^u.u)))(^v.(^w.w))))(^p.(^q.p))))
;    13. ==[ beta     ]==> ((^y.((y (^z.(^u.u)))(^v.(^w.w))))(^p.(^q.p)))
;    14. ==[ alpha    ]==> ((^x.((x (^y.(^z.z)))(^u.(^v.v))))(^w.(^p.w)))
;    15. ==[ beta     ]==> (((^w.(^p.w))(^y.(^z.z)))(^u.(^v.v)))
;    16. ==[ alpha    ]==> (((^x.(^y.x))(^z.(^u.u)))(^v.(^w.w)))
;    17. ==[ beta     ]==> ((^y.(^z.(^u.u)))(^v.(^w.w)))
;    18. ==[ alpha    ]==> ((^x.(^y.(^z.z)))(^u.(^v.v)))
;    19. ==[ beta     ]==> (^y.(^z.z))
;    20. ==[ alpha    ]==> (^x.(^y.y))
;
;        REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------

(setf FACTORIAL '(Y (^ f . (^ n .((((IF ZERO?) n) ONE)
                                   ((MULTIPLY n) (f (PREDECESSOR n))))))))

  (expand-and-reduce^ '(FACTORIAL (SUCCESSOR (SUCCESSOR ONE)))
                       5000
                       true)
;---------------------------------------------------------------
;
; Roughly ten minutes and 100000 of lines later, on my computer
;
; ...
;
; 2379. ==[ beta     ]==> (^x.(^y.(x (x (x (x (x (x ((^u.u) y)))))))))
; 2380. ==[ alpha    ]==> (^x.(^y.(x (x (x (x (x (x ((^z.z) y)))))))))
; 2381. ==[ beta     ]==> (^x.(^y.(x (x (x (x (x (x y))))))))
;
;       REDUCED TO NORMAL FORM.
;
;---------------------------------------------------------------
;                        EVERYTHING WORKS!

(exit)


--------------------------------------------------------------
Lambda Calculus Meta-variables Supported in my Newlisp Library
--------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/02/lambda-calculus-metavariables-supported.html

Lambda calculus is very small and still "Turing complete" language. However, because of its simplicity and small size, it is very hard to write real programs - even harder than in assembly language. Most of the materials demonstrating programming in lambda calculus> use meta-variables. For instance, TRUE is defined as

'(^ x .(^ y . x))),

and after that, TRUE is used instead of given expression. If such meta-variables are used, lambda-expressions are much shorter and more readable, however, there is no essential difference, since before reduction, all meta-variables are "expanded" into real lambda-expressions.

I already implemented support for reduction of lambda expressions in my Newlisp library. The code that deals with meta-variables is rather simple. It is  just recursive substitution of meta-variable's value for meta-variable itself.

You can see how it works in my previous post "Some Basic Concepts Implemented and Reduced in Lambda-calculus", now updated.


-----------------
Parallel "Expand"
-----------------
http://kazimirmajorinc.blogspot.com/2011/04/parallel-expand.html

Almost all Lisp dialects support both "parallel" and "serial" assignment operators like let and letn in Newlisp. For example

    (setf y 1)
    (let((y 2)(x y)) x)  ==> 1   (parallel)

but

   (setf y 1)
   (letn((y 2)(x y)) x)  ==> 2   (serial)

Expand-expression in Newlisp

   (expand '(x y) 'x 'y)

results in replacement of x and y in (x y) with values of x and y. Expand-expression in other form:

   (expand '(x y) ((x <value1>)(y <value2>)))

results in replacement of x and y in (x y) with <value1> and  <value2>.

In both cases, the replacement is performed in serial fashion. For  example,

   (expand '(x y) '((x y)(y 3))) ==> (3 3)

In this post I present the implementation of parallel expand,  expand// in Newlisp; two slashes in name remind on parallel lines such that, for instance

   (expand// '(x y) '((x y)(y 3))) ==> (y 3).

Parallel expand expression can be reduced to serial expand with introduction of new variables.

  (expand// <expr> '((<var1> <val1>)...(<varn> <valn>))) =

  (expand <expr> '((<var1>   expand//1) ... (<varn>   expand//<n>)
                   (expand//1 <val1>  ) ... (expand//n <valn>)))

Fexpr expand// can use always the same temporary variables expand//1, ..., expand//n, without need for generating fresh variables each time expand// is called. Other form of expand//,

  (expand// <expr> '<var0> ... '<varn>)

can be reduced on form

  (expand <expr>
         '((<var0>   expand//0) ...        (<varn> expand//<n>)
           (expand//0 <value of var0>) ... (expand//<n> <value of var<n>>))).

Using that idea, the implementation is not very technical

(define (expand// expr)
  (letn((a (args))
        (expand//sym (lambda(n)(sym (append "expand//" (string n)))))
        (expandlist

    (if (empty? a)
        (throw-error "expand//: arguments missing.")

        (cond ((symbol? (first a))
               (append (map (lambda(i)(list i (expand//sym $idx))) a)
                       (map (lambda(i)(list (expand//sym $idx) (eval i))) a)))

              ((list? (first a))
               (append (map (lambda(i)(list (i 0) (expand//sym $idx))) (first a))
                       (map (lambda(i)(list (expand//sym $idx) (i 1))) (first a))))))))


       (println "expandlist=" expandlist)
       (expand expr expandlist)))

(setf x 'y)
(setf y 3)
(println (expand '(x y) 'x 'y))           ; => (3 3)
(println (expand// '(x y) 'x 'y))         ; => (y 3)
(println (expand '(x y) '((x y)(y 3))))   ; => (3 3)
(println (expand// '(x y) '((x y)(y 3)))) ; => (y 3)

(exit)


------------------------------------------------------
Conflation of Subtraction and Additive Inverse in Lisp
------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/05/conflation-of-subtraction-and-additive.html

In mathematics, the symbol - is used as name of two different operations: subtraction and additive inverse. For instance, that symbol has different meaning in the expressions (-3)+7 and (6-3)+7. There is no ambiguity. The edge case of subtraction

c - b1 - b2 - ... - bn

for n = 0, i.e. subtraction with zero subtrahends, is c, which is clearly different than additive inverse of c: - c. However, in prefix notation use of the same symbol for two different operators will cause ambiguity so (- c) can be interpreted as both additive inverse of c and the edge case of subtraction with zero subtrahends. Designers of almost all Lisp dialects have chosen to keep the same symbol and implement both operations. The decision is based on the number of operands: if there is only one operand, operator - behaves as additive inverse; if there is two or more operands - behaves as subtraction.

This decision rarely causes any problems with "hand written" expressions because humans automatically, without much thinking, reduce edge case of subtraction to minuend, so, we'll not see the edge case of subtraction in any mathematical formulas. However, if expressions are processed by programs the reduction of the edge case doesn't happen automatically. For instance, the program that simplifies arithmetic expression could contain the function that deletes zeroes from subtrahends. That function should accept expression as

(- c b1 0 b2 0 0 0)

as argument and return expression

(- c b1 b2).

However, simple implementation like this one in Newlisp
(define (simplify E)
  (let ((operator (first E))
        (minuend (first (rest E)))
        (subtrahends (rest (rest E))))
       (setf new-subtrahends (clean zero? subtrahends))
       (append (list operator)
               (list minuend)
               new-subtrahends)))

will not work correctly, because, for instance, (- 3 0) will be reduced into (- 3) and these two expressions have not the same value. Explicit treatment of the edge case is required:

(define (simplify E)
  (let ((operator (first E))
        (minuend (first (rest E)))
        (subtrahends (rest (rest E))))
       (setf new-subtrahends (clean zero? subtrahends))
       (if (empty? new-subtrahends)
           minuend
           (append (list operator)
                   (list minuend)
                   new-subtrahends))))

The second definition is significantly (~ 15%) larger and less consistent: one can get rid of subtrahends equal to zero only if he removes whole subtraction. On the other hand, edge cases for some other operations like addition are well supported in all Lisp dialects: not only that (+ a 0) can be safely simplified to (+ a), but even (+ 0 0) can be simplified to (+).

Hence, merging of the two operators into one could be design mistake. It would be, arguably, better to
define new operator for additive inverse and
extend definition of subtraction on special case with zero subtrahends.
Of course, S-expressions would look even less similar to arithmetic expressions, however, clarity and consistency over convenience is, I think, the element of the philosophy of Lisp.

It is even more surprising that this merging is generalized: division operator, / which is not used as divisional inverse in mathematical expressions is used on the way analogous to - in almost all Lisp dialects.

It is hard to expect change in existing Lisp dialects because lot of existing code uses "conflated operator", although I think that such changes should be, gradually, done: the past is finite and future is infinite. However, I think that for future Lisp dialects it would be better to keep the difference between subtraction (division) and additive (multiplicative) inverse.


-------
Tangent
-------
http://kazimirmajorinc.blogspot.com/2011/05/tangent.html


The specificity of Lisp is, maybe, best visible on problems that require processing of data naturally represented as S-expressions. An example of such problem is "Probability that random propositional formula is tautology." In this post, the variation of classical example - symbolic differentiation - is presented: newLISP (and it is very similar in other Lisps) program that computes the tangent of the graph of the function f of single variable, defined as composition of elementary functions (+, -, sin, cos ...) in given point x0. The tangent of the function f in x0 is defined as linear function

y(x) = a·(x - x0) + b,

where a = f '(x0) and b = f(x0). The program consists of:

The function tangent that accepts two arguments: the function f in form of lambda list and the floating point number x0. The function tangent analyzes the code of the function f, calculates the values a and b according to mathematical definition of tangent (see above) and constructs the code of the function

(lambda(x)(+. (*. a (-. x x0)) b))

where symbols a, b and x0 are replaced with their respective values; that function is then returned as result of the function tangent. The implementation is very short, but it delegates main part of the work to the function d.
The function d accepts two arguments: formula and variable. It returns the expression obtained by symbolic differentiation of the formula for given variable. It is main function in this program, typical recursive "code walking" through formula. Simple "domain specific language" is used for descriptions of the rules  for symbolic differentiation that should be applied, for example

(+. (*. df g) (*. f dg))

for multiplication. The application of  rules for symbolic differentiation frequently give result that can be simplified. For instance, derivation of (*. 2 x) is

(+. (*. 0 x) (*. 2 1))

so function simplify is called when appropriate.
The function simplify accepts only one argument: symbolic expression formula. It analyzes and simplify formula, again, using typical recursive "code walking". For instance, S-expression (- x x) is simplified to 0. There are infinitely many possible rules for simplification; the function performs only few of these. The function uses eval at one place: if some expression contains only operators and constants, but not variables then the easisest way to simplify it is to eval it. (One might speculate that simplify is generalized eval.) Simplification is, actually, not necessary for computation of the tangent. However, its use in the context of symbolic differentiation is reasonable.
Few operators from my library are used; function expand// i.e. parallel expand, fexpr println= for convenient printing and floating point arithmetic operators +., -., *. and /., synonymous for built-in add, sub, mul and div. These functions are not essential.

The graph of the complicated function and tangent on the curve suggests that program, generally, works.

(setf f0 (lambda(x)
           (+. (sin (*. 12 x))
               (cos (*. 32 x))
               (tan (*. x 1.4))
               (asin x)
               (acos  x)
               (atan x)
               (*. x (cos (/. 7 x)))
               (sqrt (/. 9 x))
               (pow x x)
               (*. x (sinh x))
               (*. x (cosh x))
               (asinh x)
               (sin (acosh (+. x 1)))
               (atanh x))))
(setf x0 0.4)
(println= (tangent f0 x0))
; (tangent f0 x0)=(lambda (x) (+. (*. -21.491 (-. x 0.4)) 10.252))

Note: vedi immagine "tangent.png" nella cartella "data".

Finally, the code:
(setf [print.supressed] true [println.supressed] true)
(load "http://www.instprog.com/Instprog.default-library.lsp")
(setf [print.supressed] nil [println.supressed] nil)

(define (tangent f x0)
   (letn((variable           (first (first f)))
         (expression         (last f))
         (derived-expression (d expression variable))
         
         (a                  (eval (expand derived-expression
                                           (list (list variable x0)))))
         (b                  (f x0)))
        
       (expand// '(lambda(x)(+. (*. a (-. x x0)) b))
                  'a 'b 'x0)))

(define (d formula variable)
  (simplify 
    (cond 
      ((= formula variable) 1)
      ((atom? formula) 0)
      ((list? formula)
       (letn((operator (first formula))
             (operands (rest formula))
             (lexpand 
               (lambda(expr)
                 (letn((flatexpr (flat expr))
                       (f  (if (find 'f  flatexpr)(operands 0)))
                       (df (if (find 'df flatexpr)(d f variable)))
                       (g  (if (find 'g  flatexpr)(operands 1)))
                       (dg (if (find 'dg flatexpr)(d g variable))))
                   (expand// expr 'f 'df 'g 'dg)))))

         (case operator 

           (+. (cons '+. (map (lambda(op)(d op variable)) operands)))
           (-. (cons '-. (map (lambda(op)(d op variable)) operands)))

           (*. (case (length operands)
                 (1    (lexpand 'df))
                 (2    (lexpand '(+. (*. df g) (*. f dg))))
                 (true (d (list '*. (first operands)
                                    (cons '*. (rest operands)))
                           variable))))

           (/. (case (length operands)
                 (1    (d (list '/. 1 (first operands)) variable)) 
                 (2    (lexpand '(/. (-. (*. df g) (*. f dg)) (*. g g))))
                 (true (d (list '/.  (first operands)
                                     (cons '*. (rest operands)))
                       variable))))

           (pow (d (lexpand '(exp (*. g (log f)))) variable))
           (exp (lexpand '(*. f df)))
           (log (if (= (length operands) 1)
                    (lexpand '(/. df f))
                    (d (lexpand '(/. (log f) (log g))) variable)))

           (sqrt  (lexpand '(*. 0.5 df (/. 1 (sqrt f)))))
           (sin   (lexpand '(*. (cos f) df)))
           (cos   (lexpand '(*. (-. (sin f)) df)))
           (tan   (lexpand '(/. df (pow (cos f) 2))))
            (asin (lexpand '(/. df (sqrt (-. 1 (*. f f))))))
           (acos  (lexpand '(-. (/. df (sqrt (-. 1 (*. f f)))))))
           (atan  (lexpand '(/. df (+. 1 (*. f f)))))
           (sinh  (lexpand '(*. (cosh f) df)))
           (cosh  (lexpand '(*. (sinh f) df)))
           (tanh  (lexpand '(*. (-. 1 (pow (tanh f) 2)) df)))
           (asinh (lexpand '(/. df (sqrt (+.(*. f f) 1)))))
           (acosh (lexpand '(/. df (sqrt (-. (*. f f) 1)))))
           (atanh (lexpand '(/. df (-. 1 (*. f f)))))

           ))))))

(define (simplify formula)
  (cond 
    ((atom? formula) formula)
    ((list? formula)
     (letn((operator (first formula))
           (operands (map simplify (rest formula)))
           (formula (cons operator operands)))

       (cond 
       
         ; if all operands are constants, then 
         ; simplified formula is evaluated formula
   
         ((for-all number? operands)(eval formula))
   
         ; (*. x), (+. x) => x
         
         ((and (or (= operator '*.) (= operator '+.)) 
               (= (length operands) 1))
           (first operands))
           
         ; (*. ... 0 ...) => 0  
           
         ((and (= operator '*.) (find 0 operands)) 0)
         
         ; (*. ... 1 ...) => (*. ...)
         
         ((and (= operator '*.) (find 1 operands))
          (simplify (clean (curry = 1) formula)))
         
         ; (+. ... 0 ...) => 0
         
         ((and (= operator '+.) (find 0 operands))
          (simplify (clean zero? formula)))
          
         ; (-. (-. ...)) => ...
         
         ((match '(-. (-. ?)) formula)
           (last (last formula)))
           
         ; (-. minuend ...)
         
         ((and (= operator '-.) (> (length operands) 1))
               
          (letn((minuend (first operands))
                (subtrahends (rest operands))
                (subtrahend  (simplify (cons '+. subtrahends))))
                
            (cond ((zero? minuend)        (simplify (list '-. 
                                                          subtrahend)))
                  ((zero? subtrahend)     minuend)
                  ((= minuend subtrahend) 0)
                  (true                   (list '-. minuend 
                                                    subtrahend)))))
                     
         ; (/. (/. ...))
               
         ((match '(/. (/. ?)) formula) (last (last formula)))
         
         ; (/. dividend ...)
         
         ((and (= operator '/.) (> (length operands) 1))
          (letn((dividend (first operands))
                (divisors (rest operands))
                (divisor  (simplify (cons '*. divisors))))
            
            (cond ((zero? dividend)     0)
                  ((= divisor 1)        dividend)
                  ((= divisor -1)       (simplify (list '-. dividend)))
                  ((= dividend divisor) 1)
                  (true                 (list '/. dividend divisor)))))
          
         (true formula)))))) 


---------------------------------------------------
More Sophisticated Encoding of S-exprs into Symbols
---------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/more-sophisticated-encoding-of-s-exprs.html

Encoding of S-expressions into symbols is frequent topic of discussion in this blog. It is motivated by the idea that names should be equally flexible as S-expressions. (Actually, it might be the best if not only every symbol is S-expression, but also every S-expression is the symbol. OK, it is almost mystical statement.)

Trivial encoding was demonstrated in last post: S-expression is encoded in symbol which has exactly same characters as printed representation of S-expression. For instance, S-expression (+ a b) is encoded into symbol (+ a b). This trivial encoding has some limitations. For instance, if we look at symbol

((+ a b) c)

and try to decode it, we'll find that it cannot be determined whether (+ a b) is S-expression, or it is symbol. In some Lisp dialects (Common Lisp, Picolisp, ISLisp) there is no such problem. Symbol (+ a b) is written as |(+ a b)| so difference between S-expression and symbol is obvious. However, in these dialects, repeated encoding results in the symbols that grow exponentially.

In this post more sophisticated encoding, without that problem, is presented. Let us define encoding k, such that for every S-expression e, k(e) is defined as follows.
If e is symbol, then k(e) = e;
if e = (e1 ... en) then k(e) = [k(e1) k(e2) ... k(en)];
Semi-colon is part of the symbol. For instance

k(a) = a;
k((a b)) = [k(a) k(b)]; = [a;b;];

If only codes of the S-expressions contain characters [, ] and ;, then encoding k is injection, i.e. for two S-expressions e and f,

k( e ) = k( f ) => e = f.

Furthermore, there is no exponential explosion in case of multiple encoding. For instance,

k((a b)) = [a;b;];
k(k((a b))) = [a;b;];;
k(k(k((a b)))) = [a;b];;;

Here is implementation of encoding and decoding in R5RS Scheme.
(define (sexpr->string L)
  (string-append
     (if (symbol? L) (symbol->string L)
                     (string-append
                        "["
                        (apply string-append
                               (map sexpr->string L))
                        "]"))
     ";"))
     
(define (sexpr->symbol L)
  (string->symbol (sexpr->string L)))
  
(define (string->sexpr S)
  (let((S1 (substring S 0 (- (string-length S) 1))))
    (if (equal? (string-ref  S1 (- (string-length S1) 1)) #\])
      (let((substring-begin 1)
           (level 0)
           (result (list)))
        (do ((i 1 (+ i 1)))
            ((= i (string-length S1)) result)
          (if (and (= level 0)
                   (equal? (string-ref S1 i) #\;)
                   (not (equal? (string-ref S1 (+ i 1)) #\;)))
            (begin
              (set! result
                    (append result
                            (list (string->sexpr
                                    (substring S1
                                               substring-begin
                                               (+ i 1))))))
              (set! substring-begin (+ i 1))))
          (cond ((equal? (string-ref S1 i) #\[)
                 (set! level (+ level 1)))
                ((equal? (string-ref S1 i) #\])
                 (set! level (- level 1))))))
      (string->symbol (substring S 0 (- (string-length S) 1))))))
      
(define (symbol->sexpr s)
  (string->sexpr (symbol->string s)))

-------------------------

> (sexpr->symbol (quote (a b)))
|[a;b;];|
> (define s2 (sexpr->symbol (quote (|[a;b;];| c))))
> s2
|[[a;b;];;c;];|
> (symbol->sexpr s2)
(|[a;b;];| c)


--------------------------------------------
Another Encoding of S-expressions in Symbols
--------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/another-encoding-of-s-expressions-in.html

Unlike encoding from the last post, this one maintains form of S-expression. If e is S-expression, then its code is symbol (Q e).

Encoding is relatively simple, because built in functions for conversion of symbols and strings into symbols can be used; especially if symbols converted to strings are not encapsulated within vertical bars or quotation marks. Decoding is slightly more complicated. For instance, symbol

(Q (a (Q b)))

should be decoded into list (a (Q b)) where (Q b) isn't list, but symbol. Hence, built in conversion functions are not enough, but one must define his own "code walker." The code in Newlisp follows.

(define (sexpr->symbol r) (sym (string (list (quote Q) r))))

(define (qlist? r)
    (and (list? r)
         (not (empty? r))
         (= (first r) (quote Q))))
     
(define (symbol->sexpr r)
  (let((codewalker
         (lambda(r)
           (cond ((symbol? r) r)
                 ((qlist? r) (sym (string r)))
                 ((not (qlist? r)) (map codewalker r))))))
     (codewalker (last (read-expr (string r))))))
        
--------

> (setq s (sexpr->symbol (quote (a b))))
(Q (a b))
> (symbol? s)
true
> (setq q0 (sexpr->symbol (quote b)))
(Q b)
> (setq s (sexpr->symbol (list (quote a) q0)))
(Q (a (Q b)))
> (symbol? s)
true
> (setq s0 (symbol->sexpr s))
(a (Q b))
> (symbol? s0)
nil
> (symbol? (last s0))
true

Behaviour of Q strongly reminds on QUOTE.


----------------------------------------------------
More on Another Encoding of S-expressions in Symbols
----------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/more-on-another-encoding-of-s.html

In previous post, I have shown another interesting method for encoding of S-expressions into symbols. In this post, I'll show how it can be implemented in Lisp dialects that print symbols on different way from S-expressions, i.e. encapsulated in vertical bars or other symbols (Common Lisp, ISLisp, Picolisp, some implementations of Scheme). This is, normally, good feature. However, repeated encoding of the symbols results in exponential growth. So, we must get rid of those vertical bars inside our symbols.

The code, here in Common Lisp, is sort of trickier than it is in Newlisp or it would be in Clojure.
(defun decode-deep (r)
  (cond ((symbolp r) (let((result (read-from-string (string r))))
                        (if (symbolp result)
                            result
                            (decode-deep result))))
        ((listp r) (mapcar (quote decode-deep) r))))

(defun sexpr->symbol (r) 
  (make-symbol (write-to-string (list 'q (decode-deep r)))))

(defun encode-deep (r)
  (cond ((symbolp r) r)
        ((listp r)(if (eq (first r) (quote q))
                      (make-symbol (write-to-string r))
                      (mapcar (quote encode-deep) r)))))

(defun strip-q (r) (first (rest r)))

(defun symbol->sexpr (r) 
  (encode-deep (strip-q (read-from-string (string r)))))

-------------

[43]> (setq q0 (sexpr->symbol (list (quote b) (quote c))))
#:|(Q (B C))|
[44]> (setq s (sexpr->symbol (list (quote a) q0)))
#:|(Q (A (Q (B C))))|
[45]> (setq s0 (symbol->sexpr s))
(A #:|(Q (B C))|)


-----------------------------------------
Implementing Data Structures with Symbols
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2011/07/implementing-data-structures-with.html

Original Lisp had only symbols as atoms. Symbol names, if used on the same way variables are used in mathematics, are flexible enough to support wide variety (all?) data structures.

For instance, matrices 2 x 2 can be implemented with symbols as a11 instead of a[1,1] in some other language, or (a 1 1) in Lisp and names could be created as needed.

The code will be more complicated and less efficient than if matrices are directly supported by language, but neither one is essential problem - complexity of the code can be "abstracted away" with functions, and computational complexity is increased only for factor of constant * log n where n is the number of used symbols (if symbol reaching in Lisp is implemented efficiently.) Newlisp code follows.

(define (matrix-element m i j)
  (sym (append (string m) (string i) (string j))))

(define (set-matrix m m11 m12 m21 m22)
  (for(i 1 2)
    (for(j 1 2)
      (set (matrix-element m i j)
           (nth (+ (* 2 (- i 1)) (- j 1))
                (list m11 m12 m21 m22))))))
  
(define (println-matrix m)
  (for(i 1 2)
    (for(j 1 2)
       (println m "[" i "," j "]=" 
          (eval (matrix-element m i j))))))
          
(define (multiply-matrix a b c)
  (for(i 1 2)
    (for(j 1 2)
      (set (matrix-element c i j) 0)
      (for(k 1 2)
         (set (matrix-element c i j)
              (+ (eval (matrix-element c i j))
                 (* (eval (matrix-element a i k))
                    (eval (matrix-element b k j)))))))))

(set-matrix (quote X) 1 2 3 4)
(set-matrix (quote Y) 2 3 4 5)
(multiply-matrix (quote X) (quote Y) (quote Z))
(println-matrix (quote Z))

---------------------------
Program output

Z[1,1]=10
Z[1,2]=13
Z[2,1]=22
Z[2,2]=29

Commenti:
---------
*** Anonymous 20 November 2011 at 14:52
Erlang, which derives its basic syntax directly from Prolog, uses syms exactly like that, as meaningful entities, which in other langs would be implemented with vars, or strings.

E.g. messages between erlang processes are passed as symbols.

I do not see why meaningful syms cannot be used in other languages, too.

You are perfectly right.

*** Anonymous 21 November 2011 at 11:14
I could probably tell even more:
Erlang uses syms as meaningful semantic entities not only because it follows tradition from Prolog (in 'logical_programming' it's kind of natural to have syms stand for words, as it basically manipulates 'predicates'). Syms are naturally immutable, created once and never changed, and in Erlang it serves a purpose, eliminating potential conflicts in parallel distributed computing - no chance that the same var gets assigned to in different places dragging into the pot all kinds of race conditions and need for locks.

In Newlisp which allows sending serialized content to remote instances for remote evaluation, it may make full sense too - when Newlisp uses Erlang-like programming.
Now with 'messaging' btw parent and child added, this interesting way to architect programs becomes available to Newlisp too, and who knows, messaging with lists of syms (instead of lists of vars or lists of constant strings) might make sense.

Basically, syms with meaningful names are just one more kind of entities, and whether and how to use them depends probably on how convenient they are to manipulate - with the bulit-in means a given language provides.
(i.e. how easy it is to match them, compare on their names - or whether one would need to cast syms into strings to do recognition and manipulation etc. etc.)

But inherent immutability is one more reason to view syms as more than named placeholders for values, as vars do.

p.s. i am 'unixtechie' at newlisp forum. i post anonymously because i dislike the idea that my wanderings around the Net should be easily tracked by god knows whom, for god knows what purposes, and forever.
So i just did not enter my auth credentials when posted my first comment


-----------------------------------------
Three meanings of the term 'S-expression'
-----------------------------------------
http://kazimirmajorinc.blogspot.com/2011/08/three-meanings-of-term-s-expression.html

"Symbolic expressions" or "S-expressions" are the basic data type in Lisp. Particularly, Lisp programs are S-expressions as well. The notion has immense importance in Lisp community.

Surprisingly, designers of recent Lisp dialects avoid the term "symbolic expression" or "S-expression". It is used once in Picolisp documentation; only twice, almost accidentally, in CLtL2, and it isn't used in CL Hyperspec or recent Scheme standards. Clojure, according to its web site "extends the code-as-data system beyond parenthesized lists (s-expressions) to vectors and maps." Only Newlisp documentation appear to regularly uses the term.

However, the term S-expression is still extensively used in daily communication and literature. Unfortunately, there is no universal, unique meaning. Inconsistent use is sometimes noted; for instance, in P. Siebel's "Practical Common Lisp." More frequently, it is ignored.

For J. McCarthy, S-expression is finite sequence consisting of dots and parentheses and symbols. The symbols, truly atomic, cannot be analysed on characters. For instance, S-expression (left.right) is sequence of five elements: (, left, ., right and ).

More often1, S-expression is seen as sequence of characters. In that meaning, S-expression (left . right) is sequence consisting of 14 elements.

The most usually2, S-expression is data structure, perhaps tree consisting of cons cells and symbols. In that meaning S-expression (left . right) is cons cell, containing adresses of symbols left and right in memory.

1  For instance, in E. Shaphiro, "Common Lisp - an interactive approach"; F. Turbak and D. Gifford, "Design concept of programming languages."

2  For instance, in J. and G. Sussman and H. Abelson, "SICP"; D. Touretsky, "Common Lisp - A gentle introduction to symbolic computation"; R. Finkel, "Advanced programming languages design".


------------------------------------------------------------------------------
The Similarities Between Axioms of Natural Numbers and Axioms of S-expressions
------------------------------------------------------------------------------
http://kazimirmajorinc.blogspot.com/2011/08/similarities-between-axioms-of-natural.html

In last post, it was shown that in Lisp practice, the term "symbolic expression", shorter "s-expression", "sepxr", "sexp" is used on few different, although similar meanings.
It is not unusual. Other terms, even mathematical ones, like "lines" or "numbers" are not uniquely defined as well. Ambiguity usually motivates the search for the essence of the discussed entities; the result of the search is axiomatic theory. For example, the axioms of natural numbers are developed in late 1880's by R. Dedekind and G. Peano.
Axioms of Natural Numbers
-------------------------
There is a set N ("numbers"), distinctive element of the N denoted with 1 ("base", "initial number") and mapping
  successor: N → N
such that

1. all numbers, except 1, are successors of some numbers, i.e.
{ successor(n) | n ∈ N } = N \ {1};

2. the successor function is injection, or
successor(n) = successor(m) => n = m;

3. if S is a set of numbers such that
   i. S contains all initial numbers (i.e. 1);
  ii. if S contains n, then S contains successor(n);
then S contains all numbers.

Search for axioms of symbolic expressions might be equally justified. I designed following axioms (version in which lists are only shorter way of writing "dotted pairs") to emphasize the similarities to axioms of natural numbers.

Axioms of Symbolic Expressions
------------------------------
There is a set SEXPR ("symbolic expressions"), infinite set of distinct elements of the SEXPR denoted with A ("atoms") and mapping
cons: SEXPR × SEXPR → SEXPR
such that
1. all symbolic expressions, except atoms, are conses, i.e.
{ cons(x, y) | x, y ∈ SEXPR } = SEXPR \ A;

2. the function cons is injection, i.e.
cons(n, p) = cons(m, q) => n = m and p = q;

3. if S is a set of symbolic expressions such that
   i. S contains all atoms;
  ii. if S contains n and p then S contains cons(n, p);
then S contains all symbolic expressions.

Symbolic expressions in all three meanings satisfy the axioms; cons structures satisfy axiom (3) only if cyclic structures are not allowed, like in original, McCarthy's Lisp. I'm not aware of unintended, perverse models that satisfy given axioms; but I am not sure that such models do not exist.

There are only two differences between these axiom systems.

1. There is one "base element" for numbers and infinitely many for S-expressions.

2. The function "successor" is function of a single variable; the function "cons" is function of two variables.

It is not obvious that symbolic expressions require infinitely many atoms; it could be only convenience. Perhaps S-expressions like (A . (B . (C . D))) can be used instead of symbols like ABCD, eliminating need for infinitely many atoms.

It remains unclear why these two systems of axioms are so similar.
 
Commenti:
---------
*** karnataka state board of secondary education 20 June 2012 at 13:39
The natural numbers can be easily understand by the graphs.Like if we have to represent set of positive and negative numbers simultaneously.Then we can make four quadrants and represent them.


---------
Sexpron I
---------
http://kazimirmajorinc.com/Documents/All-symbolic-expressions/Sexpron-I.lsp

Sexpron I, Newlisp program for generation of symbolic expressions and one million generated symbolic expressions, (compressed file), Aaron Schwartz Memorial Hackathon, Hacklab Mama, Zagreb, November 8-10th, 2013.

(load "http://kazimirmajorinc.com/Default.lsp")

(setf ALPHABET "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(println "xxx")
(define (atomic-symbol n)
        (letn ((l (length))
               (last-char  (ALPHABET (% (- n 1) l))) 
               (other-chars (let ((n1 (/ (- n 1) l))) 
                                 (if (= n1 0) 
                                     ""
                                     (atomic-symbol n1)))))
              (sym (append (string other-chars) last-char))))

(define (pair n)
        (list (symbolic-expression (cantors-row n))
              (symbolic-expression (cantors-column n))))

(define (symbolic-expression n)
        (letn((n1 (- n 1))
              (row (+ (% n1 2) 1))
              (column (+ (/ n1 2) 1)))
          (println row " -> " (cantors-row n) ", " column " ->" (cantors-column n))    
          (case row (1 (atomic-symbol column))
                    (2 (pair          column)))))
                    
(define (symbolic-expression-external n)
        (replace " " (string (symbolic-expression n)) "."))

(for (i 1 1000)
  (println i ".---------")
  (println "-----------> " (symbolic-experssion-external i)))

; (setf out-file (open "C://symbolic-expressions.txt" "write"))
;             
; (for(i 1 1000000)      
;   (write-line out-file 
;               (append (string i)
;                       ". "
;                       (symbolic-expression-external i ALPHABET))))
;                       
; (close out-file)
;
(exit)

=============================================================================
