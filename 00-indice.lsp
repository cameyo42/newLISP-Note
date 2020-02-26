
============================================================================
 Note su newLISP
 © copyright Massimo Corinaldesi aka cameyo
 MIT License
============================================================================

========

 INDICE

========

newLISP IN GENERALE
===================
  Introduzione
  Installazione
  Eseguire newLISP
  Le funzioni utente
  Argomenti di una funzione
  Trasformare una funzione distruttiva in non-distruttiva
  Trasformare una funzione da due a n argomenti
  Applicare una funzione ad ogni sottolista di una lista
  Assegnazione globale: set, setq e setf (e define)
  Assegnazione locale: let, letn e local
  Effetti collaterali (side effect) di setq e let e local
  Passaggio per valore e passaggio per riferimento
  Nil, true e lista vuota '()
  La funzione quote e il simbolo '
  Funzioni con memoria
  Generare funzioni da funzioni
  Tipi di numeri
  Punto decimale o virgola decimale
  Formattazione dell'output
  Operazioni aritmetiche elementari
  Incremento/decremento di variabili
  Uso dei numeri big integer
  Introspezione
  Conversioni di tipo: implicite ed esplicite
  Quanto sono precisi i numeri floating point?
  Quanto sono strani i numeri floating-point?
  Tipi di errore
  Propagazione degli errori
  Rappresentazione dei numeri floating point (32-bit)
  Machine epsilon
  Infinito e not a number
  Confronto tra numeri floating-point
  Verifica delle operazioni floating-point
  Una strana successione
  Operazioni sicure
  Quanto vale pi greco?
  Quanto vale il numero di eulero?
  Tempo di esecuzione
  Lista o vettore?
  Vettori
  Indicizzazione di stringhe, liste e vettori
  Attraversamento di liste e vettori
  Attraversamento di stringhe
  Uscita anticipata da funzioni, cicli e blocchi
  Lavorare con file di dati (file i/o)
  Salvare e caricare gli oggetti
  Struttura dati: il record
  Ambito (scope) dinamico e lessicale
  Contesti
  Uso dei moduli
    La variabile di ambiente NEWLISPDIR
    Il file di inizializzazione init.lsp
    Esempi sull'utilizzo dei moduli
  Hash-Map e dizionari
  CAR e CDR in newLISP
  Espressioni regolari
  Macro
  FOOP - Programmazione funzionale orientata agli oggetti

FUNZIONI VARIE
==============
  Tabella ASCII
  Pari o dispari
  Crono
  Cambiare di segno ad un numero
  Moltiplicazione solo con addizioni
  Divisione solo con sottrazioni
  Distanza tra due punti
  Conversione decimale <--> binario
  Conversione decimale <--> esadecimale
  Conversione decimale --> romano
  Conversione numero intero <--> lista
  Numeri casuali in un intervallo
  Calcolo proporzione
  Estrarre l'elemento n-esimo da una lista
  Verificare se una lista è palindroma
  Verificare se una stringa è palindroma
  Verificare se un numero è palindromo
  Zippare N liste
  Sostituire gli elementi di una lista con un determinato valore
  Raggruppare gli elementi di una lista
  Enumerare gli elementi di una lista
  Creare una stringa come ripetizione di un carattere/stringa
  Massimo annidamento di una lista ("s-espressione")
  Run Length Encode di una lista
  Run Length Decode di una lista
  Massimo Comun Divisore e Minimo Comune Multiplo
  Funzioni booleane
  Estrazione dei bit di un numero
  Conversione gradi decimali <--> gradi sessagesimali
  Conversione RGB <--> HSV
  Calcolo della media di n numeri
  Istogramma
  Stampare una matrice
  Retta passante per due punti
  Coordinate dei punti di una funzione
  Leggere e stampare un file di testo
  Criptazione e decriptazione di un file
  Funzioni per input utente
  Emettere un beep
  Disabilitare l'output delle espressioni
  Trasformare una lista di stringhe in lista di simboli
  Trasformare una lista di simboli in lista di stringhe
  Simboli creati dall'utente
  Il programma è in esecuzione ? (progress display)
  Ispezionare una cella newLISP
  Informazioni sul sistema (sys-info)
  Valutazione di elementi di una lista
  Download tutti i file da una pagina web
  Conversione numero da cifre a lettere
  Punto a destra o sinistra di una linea
  Creazione di un poligono da una lista di punti
  Percorso minimo di una lista di punti
  Utilizzo del protocollo ftp
  Normalizzazione di una lista di numeri
  Trasformazione omografica 2D
  Numeri primi successivi e precedenti
  Giorno Giuliano (Julian day)
  Punto interno al poligono
  Prodotto cartesiano
  Insieme delle parti (powerset)
  Terne pitagoriche
  Calcolo di e con il metodo spigot
  Calcolo IVA
  Numeri casuali distinti
  Numeri casuali con distribuzione discreta predefinita
  Generatore di stringhe casuali
  Inverso di un numero
  Crivello di Atkin
  Esponenziazione modulare veloce
  random sample
  Funzioni di Mobius e di Mertens
  Quadruple pitagoriche

newLISP 99 PROBLEMI (28)
========================
  N-99-01 Estrarre l'ultimo elemento di una lista
  N-99-02 Estrarre il penultimo elemento di una lista
  N-99-03 Estrarre il k-esimo elemento di una lista
  N-99-04 Determinare il numero di elementi di una lista
  N-99-05 Invertire una lista
  N-99-06 Determinare se una lista è palindroma
  N-99-07 Appiattire una lista annidata
  N-99-08 Elimina gli elementi duplicati consecutivi di una lista
  N-99-09 Unire gli elementi duplicati consecutivi di una lista in sottoliste.
  N-99-10 Run-length encode di una lista
  N-99-11 Run-length encode di una lista (modificato)
  N-99-12 Run-length decode di una lista
  N-99-13 Run-length encode di una lista (diretto)
  N-99-14 Duplicare gli elementi di una lista
  N-99-15 Replicare per n volte gli elementi di una lista
  N-99-16 Eliminare gli elementi da una lista per ogni k
  N-99-17 Dividere una lista in due parti (la lunghezza della prima lista è un parametro)
  N-99-18 Estrarre una parte di una lista
  N-99-19 Ruotare una lista di N posti a sinistra
  N-99-20 Eliminare l'elemento k-esimo di una lista
  N-99-21 Inserire un elemento in una data posizione di una lista
  N-99-22 Creare una lista che contiene tutti i numeri interi di un intervallo
  N-99-23 Estrarre un dato numero di elementi da una lista in maniera casuale (random)
  N-99-24 Lotto: estrarre N numeri differenti da un intervallo 1..M
  N-99-25 Generare le permutazioni degli elementi di una lista
  N-99-26 Generare le combinazioni di K oggetti distinti tra gli N elementi di una lista
  N-99-27 Raggruppare gli elementi di un insieme in sottoinsiemi disgiunti
  N-99-28 Ordinare una lista in base alla lunghezza delle sottoliste

ROSETTA CODE
============
  FizzBuzz
  Numeri Primi
  Numeri di Smith
  Numeri di Hamming
  Numeri di Catalan
  Numeri di Kaprekar
  Numeri Felici
  Numeri Primoriali
  Numeri Perfetti
  Numeri Amicabili
  Numeri Perniciosi
  Numeri di Munchausen
  Sequenza di Collatz
  Permutazioni
  Combinazioni
  Regola di Horner
  Problema dello zaino (Knapsack)
  Giorno della settimana
  Triangolo di Pascal
  Codice Morse
  Problema di Babbage
  Cifrario di Cesare
  Cifrario di Vigenere
  Anagrammi
  Numeri primi cuban
  Data di Pasqua
  Equazione di Pell
  Punteggio numerico (ranking)
  Legge di Bendford
  Calendario
  Carte da gioco
  Generatore di password
  Calcolo di Pi greco
  Numeri di Lucas
  Logaritmo intero di un numero intero
  Numeri di Carmichael
  Radice quadrata intera di un numero intero
  Coppie di primi gemelli
  Numeri semiprimi
  Numeri coprimi
  Fattorizzazione di un numero intero (big integer)
  Potenza di due numeri interi (big integer)
  Numeri di Tribonacci
  Numeri Eureka
  Abitazioni multiple
  Toziente di Eulero
  Numeri Vampiri
  Il gioco del Nim
  Fibonacci sequenze di n-numeri
  Il problema dei matrimoni stabili
  Test Primi Miller-Rabin

PROJECT EULERO
==============
  Problemi 1..60

PROBLEMI VARI
=============
  BubbleSort
  QuickSort
  Simulare una matrice con un vettore
  Implementare una pila (stack) con un vettore
  Implementare una coda (queue) con un vettore
  Coda circolare (Ring Buffer)
  Fattoriale
  Coefficiente binomiale
  Lancio di dadi
  Quadrati magici
  Quadrati magici 3x3
  Mastermind numerico
  Algoritmo babilonese sqrt(x)
  Radice quadrata intera di un numero intero (2^64 bit)
  Ricerca binaria (Binary search)
  Frazione generatrice
  Il numero aureo
  Equazione di secondo grado
  Equazione di terzo grado
  Sistemi lineari (Cramer)
  Sistemi lineari (Gauss)
  Numeri Brutti
  Numeri Poligonali
  Torre di Hanoi
  Indovina il numero
  Il problema Monty Hall
  Il problema del compleanno
  Algoritmo di Karatsuba
  Formati A0, A1, A2, A3, A4, ...
  Moltiplicazione del contadino russo
  Distanza di Manhattan
  Modello di crescita di una popolazione di conigli
  The Game of Pig
  Il gioco dei salti
  Ricerca stringa in un testo (algoritmo base)
  Ricerca stringa in un testo (algoritmo Z)
  Distanza di Levenshtein
  Social Network
  Skyline
  Knuth-shuffle
  Bussola e direzioni
  Puzzle (a b c + a b c + a b c = c c c)
  Numero mancante
  Somma massima di una sottolista (Algoritmo Kadane)
  Prodotto massimo di una sottolista
  Problema delle N-Regine
  Somma delle cifre di un numero
  Coppia di punti più vicina
  Moltiplicazione tra numeri interi (stringhe)
  Numeri pandigitali
  Somma dei divisori propri di un numero
  Labirinti (calcolo percorsi)
  Moltiplicazioni di fattori
  Problemi patologici dei numeri floating point
  Numerali di Church
  Creazione e valutazione di polinomi
  Quadrato perfetto di un numero
  Potenza perfetta di un numero
  Problema della segretaria
  Numeri con tre divisori
  Congettura di Goldbach
  Problema dei travasi ed equazioni diofantee
  Primi circolari
  Radici di un polinomio (Bairstow)

DOMANDE PROGRAMMATORI (CODING INTERVIEW QUESTIONS)
==================================================
  Notazione Big-O
  Contare i bit di un numero (McAfee)
  Scambiare il valore di due variabili (McAfee)
  Funzione "atoi" (McAfee)
  Somma di numeri in una lista (Google)
  Aggiornamento di una lista (Uber)
  Ricerca numero su una lista (Stripe)
  Decodifica di un messaggio (Facebook)
  Implementazione di un job-scheduler (Apple)
  Massimo raccoglitore d'acqua (LeetCode)
  Quantità d'acqua in un bacino (Facebook)
  Sposta gli zeri (Facebook)
  Intersezione di segmenti (byte-by-byte)
  Trovare l'elemento mancante (LeetCode)
  Verifica lista/sottolista (Visa)
  Controllo ordinamento lista (Visa)
  Caramelle (Visa)
  Unire due liste ordinate (Facebook)
  Salire le scale (Amazon)
  Numeri interi con segni opposti (MacAfee)
  Parità di un numero (McAfee)
  Minimo e massimo di due numeri (McAfee)
  Numero potenza di due (Google)
  Stanze e riunioni (Snapchat)
  Bilanciamento parentesi (Facebook)
  K punti più vicini - K Nearest points (LinkedIn)
  Ordinamento Colori (LeetCode) 
  Unione di intervalli (Google)
  Somma dei numeri unici (Google)
  Unione di due liste ordinate (Google)
  Prodotto massimo di due numeri in una lista (Facebook)
  Invertire le vocali (Google)
  Distanza di Hamming tra DNA (Google)
  Controllo sequenza RNA (Google)
  Somma di due box (Amazon)
  Punti vicini a zero (Amazon)
  Trova la Funzione (Uber)
  Prodotto scalare minimo e massimo (Google)
  25 numeri (Wolfram)
  Le cento porte (Wolfram)
  Insiemi con la stessa somma (Wolfram)
  Tripartizione di un intero (Wolfram)
  Cifre stampate (Uber)
  Travasi di liquidi (Facebook)
  Cambio monete 1 (LinkedIn)
  Cambio monete 2 (LinkedIn)
  Primi con cifre uguali (Wolfram)
  Intervalli di numeri (Facebook)
  Pattern Matching (Facebook)
  Percorsi su una griglia (Uber)
  Dadi e probabilità (Visa)
  Numeri casuali e fattori (Wolfram)
  Coprimi vicini (Wolfram)
  Unione di liste (LinkedIn)
  Tripla crescente (LeetCode)
  Stringhe isomorfe (Facebook)

LIBRERIE
========
  Operazioni con i numeri complessi
  Operazioni con le frazioni
  Operazioni con i tempi
  Operazioni con gli insiemi
  Funzioni winapi
  Operazioni con gli alberi binari
  funlisp.lsp (by Dmitry Chernyak)

NOTE LIBERE
===========
  Perchè newLISP?
  newLISP facile
  Apprendere newLISP
  Commentare righe di codice
  Stile del codice newLISP
  Considerazioni sulle parentesi del LISP
  Controllare l'output della REPL (prettyprint)
  File e cartelle
  Funzioni e liste
  4-4 Puzzle
  Il primo Primo
  Uso delle date
  Chiusura transitiva e raggiungibilità in un grafo
  Stalin sort
  Sequenza triangolare
  Vettore/lista di funzioni
  Numeri dispari differenza di quadrati
  Zero? test
  Operazioni su elementi consecutivi di una lista
  Il loop implicito del linguaggio Scheme (named let)
  Brainfuck string encode/decode
  Creare una utilità di sistema (.exe)
  Fattoriale, Fibonacci, Primi
  Quine
  I buchi delle cifre numeriche
  Ordinare tre numeri
  Conteggio strano
  Funzioni automodificanti
  I cicli (loops)
  L'alfabeto web "Leet"
  Autogrammi
  Ambito dinamico e ambito lessicale (statico)
  Uso delle espressioni condizionali
  select e unselect (antiselect)
  Generatori 1
  Generatori 2
  Shift logico e Shift aritmetico
  fold-left e fold-right
  La divisione di Feynman
  Il linguaggio di programmazione Fractran
  La funzione map semplificata
  Generazione della documentazione con newLISPdoc
  Ancora sui numeri primi
  Un algoritmo: matrice con somme positive
  Dadi e probabilità
  Test Vettori e Liste
  Un motore per espressioni regolari
  Insiemi (set) senza reinserimento
  Funzioni con parametri nominali
  La funzione COMMAND-EVENT
  Massimo Comun Divisore (MCD)
  Indicizzazione implicita
  nil come valore e nil come risultato
  Simulare un iteratore
  "Don't underrate an iterate..."
  Simboli che iniziano con "$"
  Uso di map nelle liste annidate
  Funzioni ordinali con le liste
  gensym e macro igieniche
  La variabile anaforica $idx
  Gestione dei simboli
  Funzioni e contesti
  Buon 2020 (e 2021)
  Nascita della teoria della probabilità
  Fibonacci(104911)
  Conta e leggi
  Assegnazione parallela
  Generatore di numeri casuali
  Liste di associazione
  Funzione Z e ipotesi di Riemann

APPENDICI
=========
  Lista delle funzioni newLISP
  Sul linguaggio newLISP - FAQ (Lutz Mueller)
  newLISP in 21 minuti (John W. Small)
  newLISP per programmatori (Dmitry Chernyak)
  notepad++ bundle
  Visual Studio Code e newLISP
  Debugger
  newLISPdoc - Il programma per la documentazione newLISP
  Compilare i sorgenti di newLISP
  Ricorsione e ottimizzazione della chiamata di coda (Tail Call Optimization)
  F-expression - FEXPR
  newLISP - Lisp per tutti (Krzysztof Kliś)
  Ricorsione avanzata in newLISP (Krzysztof Kliś)
  Differenze tra newLISP, Scheme e Common LISP (Lutz Mueller)
  Chiusure, contesti e funzioni con stato (Lutz Mueller)
  Creazione di funzioni con ambito lessicale in newLISP (Lutz Mueller)
  "The Y of Why" in newLISP (Lutz Mueller)
  Valutazione delle espressioni, Indicizzazione Implicita, Contesti e Funtori di Default (Lutz Mueller)
  Gestione Automatica della Memoria in newLISP (Lutz Mueller)
  Benchmarking newLISP
  Frasi Famose sulla Programmazione e sul Linguaggio Lisp

BIBLIOGRAFIA / WEB
==================

DOCUMENTAZIONE EXTRA
====================
  A) Introduction to newLISP (by Cormullion)
  B) The Little newLISPER (wip)
  C) Primality Testing (wip)

==========================================================================

LICENSE

MIT License

Copyright (c) 2019-2020 Massimo Corinaldesi aka cameyo

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

==========================================================================


