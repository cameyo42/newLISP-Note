
============================================================================
 Note su newLISP
 © copyright 2019-2020-2021 Massimo Corinaldesi aka cameyo
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
  Infinito e Not a Number (inf e NaN)
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
  XML e S-espressioni
  Analisi dei tempi di esecuzione delle funzioni
  Unificazione
  Stampare con print/println/format
  Complessità temporale delle operazioni aritmetiche fondamentali

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
  Il programma è in esecuzione? (progress display)
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
  Prodotto cartesiano (dot-product)
  Prodotto vettoriale (cross-product)
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
  Lista dei contesti attivi
  Conversione lista <--> stringa
  Funzione butlast
  Lista di tutte le partizioni di un numero
  Algoritmo di Euclide esteso
  Punti casuali in una circonferenza
  Esponenziazione (potenza) binaria
  Permutazioni circolari
  Crivello di Eratostene Lineare
  Area di un poligono semplice
  Rango di una matrice
  Operazioni tra coppie di elementi di una lista
  Polinomio interpolatore di Lagrange
  Moltiplicativo modulare inverso
  Radice n-esima di un numero
  Prodotto scalare (dot product)
  Prodotto vettoriale (cross-product)
  Angolo tra due direzioni (bearing)
  URL encoder/decoder
  Funzione gamma-ln
  select per i vettori
  Lunghezza di un numero intero
  Normalizzazione
  Papersize
  Verificare se due numeri hanno lo stesso segno
  Suddivisione di una lista
  Stampo di un numero
  Conversione vettore <--> lista
  one?
  Algoritmo Knuth-Morris-Pratt
  Heap binario (Binary Heap)
  Flood Fill
  Poligoni convessi
  Variazione percentuale
  Grafico di coppie di coordinate
  Sottosequenza crescente più lunga
  Conversione stringa <--> big-integer
  Dismutazioni (Derangements)

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
  Il problema di Giuseppe
  ROT-13
  Sudoku
  Chess960
  Percorso del cavallo
  Teorema cinese dei resti
  Numeri attraenti
  IBAN
  Estendere il linguaggio
  Composizione di funzioni
  Calcolo di una serie
  Numeri gapful
  Valutazione di una espressione RPN
  Il gioco del 24
  Sequenza fusc
  Algoritmo Damm
  Distanza tra due punti della terra
  Algoritmo Soundex
  Trasformata Discreta di Fourier (DFT)
  Numeri di Harshad
  Numeri Humble
  Persistenza di un numero
  Numeri Taxicab
  Codice Gray
  Game of Life
  Ackermann
  Sequenza Q di Hofstadter
  Sequenza Figura-Figura di Hofstadter
  Sequenza G di Hofstadter
  Sequenza Femmina (F) Maschio (M) di Hofstadter
  Convex Hull
  Sequenza Thue-Morse
  Numeri di Bell
  Numeri auto-descrittivi
  Jort sort
  Funzioni mutuamente ricorsive
  Numeri in base negativa
  Quaternioni
  Bioritmi
  Runge-Kutta
  ISBN13
  Insieme di Cantor
  Incremento-decremento di una stringa numerica
  Funzioni di prima classe
  Inversione frase
  Conteggio popolazione
  Selezione casuale da una lista
  Rappresentazione di Zeckendorf
  Vecchie unità di misura Russe

PROJECT EULERO
==============
  Problemi 1..102

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
  Nomi ordinati
  Distanza di numeri in una lista
  Ascensore difettoso ed equazioni diofantine
  Monete e griglie
  Teorema di Pick
  Problema dei fiammiferi di Banach
  Window sliding
  Il gioco di Wythoff
  Ordinamento per rime
  Lista circolare
  Circuito automobilistico
  Il problema delle studentesse di Kirkman
  Contadino, lupo, capra e cavoli
  Ancora la congettura di Goldbach
  Triangolo di Steinhaus
  L'ago di Buffon
  La scimmia e le noci di cocco

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
  Raggruppamento codici (Google)
  Caratteri differenti (Amazon)
  Triple con una data somma (Uber)
  Somma perfetta (Amazon)
  Mescolare una lista (LeetCode)
  Lista somma (geeks4geeks)
  Ordinare una lista di 0, 1 e 2 (geeks4geeks)
  Stipendio giusto (geeks4geeks)
  Volo completo (Programming Praxis)
  Benzina e stazioni (Uber)
  Aggiungere uno (Google)
  Numeri romani (LeetCode)
  Numero singolo (McAfee)
  Matrici a spirale (Google)
  Lunghezza della sottostringa più lunga senza caratteri ripetuti (Amazon)
  Rendere palindroma una stringa (Google)
  Cifre diverse (Visa)
  Rapporto minimo (Wolfram)
  Quadrato binario (McAfee)
  Fattoriale e zeri finali (Wolfram)
  Massima ripetizione di un carattere in una stringa (Google)
  Leggere libri (Uber)
  Numero mancante (Wolfram)
  Lista strettamente crescente (Visa)
  Pile di monete (LinkedIn)
  Numero più grande formato da una lista (Amazon)
  Rettagoli e quadrati in una scacchiera (Google)
  Rettangolo perfetto (Google)
  Addizione per intervalli (Range addition) (Google)
  Ordinamento Wiggle (Google)
  Generare parentesi (Amazon)
  Maggiori a destra (Visa)
  Numero che raddoppia (Wolfram)
  Calcolatore rotto (Broken calculator) (LeetCode)
  Contare le isole (islands) (Google)
  Lista con prodotto 1 (Amazon)
  Somma delle monete (Visa)
  Boomerang (Visa)
  Ricerca in una matrice 2D (Wolfram)
  Invertire le vocali (Google)
  Intervalli mancanti (LeetCode)
  Numeri strobogrammatici (LeetCode)
  Bomba sul nemico (Visa)
  Pitturare una staccionata (Amazon)
  Palindroma più lunga in una stringa (algoritmo Manacher) (Amazon)
  Permutazioni Palindrome (Uber)

LIBRERIE
========
  Operazioni con i numeri complessi
  Operazioni con le frazioni
  Operazioni con i tempi
  Operazioni con gli insiemi
  Funzioni winapi
  Operazioni con gli alberi binari
  funlisp.lsp (by Dmitry Chernyak)
  The Little newLISPER (newlisper.lsp)
  MessageBox (by Dexter Santucci)

NOTE LIBERE 1
=============
  Perchè newLISP?
  newLISP facile
  Apprendere newLISP
  Commentare righe di codice
  Stile del codice newLISP
  Considerazioni sulle parentesi del LISP
  Controllare l'output della REPL (prettyprint)
  Gestione di file e cartelle
  Funzioni come liste
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
  Rotazione di stringhe, liste e numeri
  Quadrato di una lista ordinata
  Somma da due numeri
  Mescolamento perfetto
  Mergesort
  Cifre crescenti e decrescenti
  Somma di numeri
  Operatori logici
  Quick select
  Macchina di Turing

NOTE LIBERE 2
=============
  Creare una lista di frequenza
  Approssimazione razionale di un numero
  Modificare le liste annidate
  Criptare un file sorgente o un contesto
  Leggere e stampare un file
  Lisp reader
  Liste e vettori annidati
  Conversione di un numero da una base ad un'altra
  Convertire una stringa in un numero univoco
  Reduce
  Quadrati nascosti
  Push, cons e list
  Append esteso
  newLISP keywords (Parole riservate)
  Estrazione di dati da un file di testo
  File di testo windows e unix
  CRC32
  Mescolare le parole
  Parsing di stringhe
  Formattazione di elementi di una lista
  Slice mapping
  Valore minimo/massimo di una lista di numeri
  Sommare una stringa
  Numeri palindromi
  Frazioni continue
  Liste formate da coppie di elementi
  Liste quotate
  Il limite sulle stringhe
  Aggiunta di liste
  Liberare una variabile
  Massimo prodotto di due numeri
  Test di funzioni
  Sostituzioni multiple in liste o stringhe
  Cambio monete
  Funzione Harakiri
  Ciclo for con numeri float
  Nascondere la finestra DOS
  Funzioni come parametri
  Valutazione input utente
  Passare dati per riferimento
  Pagamento giornaliero
  Differenze tra let e letn
  Tecnica RAID
  Crypto XOR
  Lancio di una moneta
  Area massima
  Sole o pioggia
  Roulette russa
  Common LISP Quicksort
  Ambito dinamico e parametri delle funzioni
  Torte e tagli
  Il ciclo for
  Perché uno specchio inverte destra e sinistra invece che su e giù?
  Treni e mosche
  Gestione degli errori
  Effetto percentuali
  Teorema di Euclide (infinità dei numeri primi)
  Il programma più corto
  Frequenza cifre pi greco
  Conversione a big-integer
  Congettura 8424432925592889329288197322308900672459420460792433L
  floor, ceil e fract
  Multipli di nove
  fizzbuzz esteso
  Conversione tra liste, stringhe, caratteri e simboli
  Divisori di un numero
  Sequenza di Collatz
  Generatore
  Multiplo con tutti 1 e 0
  Risolvere i sistemi lineari
  Sudoku test
  Integrali definiti
  Fattorizzazione
  "setq" o "set"
  Memfrob
  Generatore di sequenze
  Massimo gap
  Simulazione di un cannone
  Ottimizzare il taglio di un tubo
  Generazione automatica di una hash-map

NOTE LIBERE 3
=============
  Generazione di un simbolo univoco
  Compromessi tra tempo e spazio
  Scambio di somme
  Evitare begin nella condizione if
  Frazioni continue (funzioni)
  Redditi e tasse
  Numero di eulero o di nepero
  map e filter multiplo
  Direct Acyclic Graph (DAG)
  Corde e cerchio
  Toziente
  Numeri permutati
  Numeri bouncy
  docstring
  Numeri sfenici
  Bilancia a due piatti
  Somma di 6s
  Serie ricorsiva
  Sei contro cinque
  Torneo ad eliminazione diretta
  Roulette
  Daniel Dennet Quinian Crossword
  Lista delle fattorizzazioni di un numero
  Algoritmo di Bellman-Ford
  Catene di Markov
  Contornare una matrice
  Stringa decimale infinita 12345678910111213141516...
  Numeri early-bird
  Zero elevato a zero
  Fattoriale di zero
  Somma delle potenze dei primi n numeri
  Cercaparole
  Generare frazioni proprie
  Somma di quadrati
  Somma di cubi (Taxicab)
  Somma numeri dispari (pari)
  Cavo sospeso
  Numeri automorfici
  Numeri trimorfici
  Funzioni come Stringhe
  Assegnazione multipla
  Doppio fattoriale
  0.999999999...
  Quadrati magici curiosi
  Serie infinite
  Il gioco del Pig
  Mandelbrot
  find per vettori
  Variabili libere
  Debug spartano
  Espressioni ABCDEFGHIJ
  Sequenza Juggler
  Limiti dei big-integer
  Valutazione di espressioni infisse
  Vincere 2 volte su 3
  Investimenti in comune
  Dadi intransitivi
  Il prezzo di un libro
  La barca, l'uomo e il mattone
  Creare, modificare e restituire una funzione
  Input utente multi-linea
  Distanza dell'orizzonte
  Tic-Tac-Toe
  Labirinti (Maze)
  Progettare TinyURL
  Costante di Ramanujan
  Giustificazione del testo
  Data e tempo
  Algoritmo di Gale-Shapley
  Il problema dello zaino (Knapsack)
  Validazione UTF-8
  Sudoku mania
  Radici quadrate con il metodo di Newton
  Ippodromo
  Parser di espressioni infisse-prefisse-postfisse
  Derivate Simboliche
  Media geotmetica
  Verificare l'esistenza di un simbolo
  Primi troncati
  Contenimento del quadrato

NOTE LIBERE 4
=============
  Una relazione tra π ed e
  Ricerca del numero diverso
  Ricerca del numero singolo
  Punti in un semicerchio
  Coefficiente di Sorensen-Dice
  Parole di Lyndon
  Fattorizzazione di Lyndon
  Rimozione dei multipli
  Rock Paper Scissors
  TODO application
  Quine e Narciso
  Test di primalità
  Passeggiata casuale lungo una linea
  Serie di teste e croci (valore atteso)
  Ricerca con caratteri jolly (wildcard)
  Funzioni logiche booleane
  Tavole di verità
  Numeri Brasiliani
  Probabilità condizionata
  Teorema di Bayes 1
  Teorema di Bayes 2
  Probabilità bayesiane
  Dadi
  replace multiplo
  ASCII Mandelbrot
  Yahtzee
  Gioco del 15
  Numeri rari
  Patience Sort
  Lista degli indici
  Buche sulle strada
  Storia delle variabili
  Numeri di Chowla
  Secondi -> periodo
  Partizione di una lista in due parti con somme uguali
  Numeri di Zumkeller
  Numeri di Leonardo
  Frequenza caratteri
  Frequenza parole
  Magic 8-Ball
  I Ching
  Problema ABC
  Compressione/Decompressione intervallo di valori
  Plot di funzioni
  Spirale di Archimede
  Misure angolari
  Numero di settimane
  Il gioco del 21
  Fattoriale sinistro (Left factorial)
  Numeri primi lunghi
  Numeri Tau
  Sequenza Yellowstone
  Distanza di Jaro
  Pietre e gioielli (Stones and Jewels)
  Numeri super-d
  Algoritmo di Bresenham
  Associare gli elementi di una lista ogni k
  Somma delle potenze delle cifre
  Bruchi saltellanti
  Buste matrioska
  ASCII Julia
  Dado da 7 con dado da 5
  42 in newLISP e C
  Uguaglianza approssimata
  Primi sexy
  Tavola pitagorica
  Sottostringa più piccola che contiene tutti i caratteri di una stringa
  Algoritmo Floyd-Warshall
  Triangoli casuali
  Triangoli e bastoncini
  Generazione di una lista di numeri casuali che sommano a 1
  Numeri disarium
  Numeri promici
  Formula di Erone
  Tre funzioni per calcolare la potenza di un numero intero
  Numeri Armstrong
  Evoluzione dell'algoritmo per la moltiplicazione di due numeri interi
  Indice di equilibrio
  Numero soluzioni equazione lineare a k variabili  
  Internet-point

NOTE LIBERE 5
=============
  Spostamento di zeri
  Quadratura approssimata


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
  Codici ASCII

BIBLIOGRAFIA/WEB
==================

YO LIBRARY
==========
"yo.zip" Libreria per matematica ricreativa e problem solving (170 funzioni)

DOCUMENTAZIONE EXTRA
====================
  A) Introduction to newLISP (by Cormullion)
  B) Code Patterns (by Lutz Mueller)
  C) The Little newLISPER

==========================================================================

LICENSE

MIT License

Copyright (c) 2019-2020-2021 Massimo Corinaldesi aka cameyo

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
Klaatu barada nikto
==========================================================================

=============================================================================

