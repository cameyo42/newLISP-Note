================

 NOTE LIBERE 26

================

  "In cuesta fraze ci sono cincue erori"

------------------
Punteggio Scrabble
------------------

Lo Scrabble è un gioco basato sulla formazione di parole di senso compiuto.
Per calcolare il valore di una parola ad ogni lettera viene assegnato un punteggio che è inversamente proporzionale alla frequenza di utilizzo nella lingua italiana.
La seguente tabella mostra i valori e la frequenza per ogni lettera dell'alfabeto italiano:

  Lettera   Valore   Frequenza
  A          1       14       
  B          5        3       
  C          2        6       
  D          5        3       
  E          1       11       
  F          5        3       
  G          8        2       
  H          8        2       
  I          1       12       
  L          3        5       
  M          3        5       
  N          3        5       
  O          1       15       
  P          5        3       
  Q         10        1       
  R          2        6       
  S          2        6       
  T          2        6       
  U          3        5       
  V          5        3       
  Z          8        2       

Scriviamo una funzione che calcola il valore di una data parola.

(define (scrabble str)
  (let ( (val 0)
         (valori '(("A" 1) ("B" 5) ("C" 2) ("D" 5) ("E" 1) ("F" 5) ("G" 8)
                   ("H" 8) ("I" 1) ("L" 3) ("M" 3) ("N" 3) ("O" 1) ("P" 5)
                   ("Q" 10) ("R" 2) ("S" 2) ("T" 2) ("U" 3) ("V" 5) ("Z" 8))) )
    (setq str (upper-case str))
    (for (i 0 (- (length str) 1))
      (++ val (lookup (str i) valori)))))

Proviamo:

(scrabble "mamma")
;-> 11
(scrabble "soqquadro")
;-> 35

(scrabble "dieci")
;-> 10
(scrabble "quarantaquattro")
;-> 44

Vediamo quali numeri in forma letterale (da 0 a 100) hanno un valore scrabble pari al numero stesso:
(per la creazione dei numeri in lettere vedi "Conversione numero da cifre a lettere" su "Funzioni varie")

(setq numeri
  '("Zero" "Uno" "Due" "Tre" "Quattro" "Cinque" "Sei" "Sette" "Otto" "Nove"
    "Dieci" "Undici" "Dodici" "Tredici" "Quattordici" "Quindici" "Sedici"
    "Diciassette" "Diciotto" "Diciannove" "Venti" "VentUno" "VentiDue"
    "VentiTre" "VentiQuattro" "VentiCinque" "VentiSei" "VentiSette"
    "VentOtto" "VentiNove" "Trenta" "TrentUno" "TrentaDue" "TrentaTre"
    "TrentaQuattro" "TrentaCinque" "TrentaSei" "TrentaSette" "TrentOtto"
    "TrentaNove" "Quaranta" "QuarantUno" "QuarantaDue" "QuarantaTre"
    "QuarantaQuattro" "QuarantaCinque" "QuarantaSei" "QuarantaSette"
    "QuarantOtto" "QuarantaNove" "Cinquanta" "CinquantUno" "CinquantaDue"
    "CinquantaTre" "CinquantaQuattro" "CinquantaCinque" "CinquantaSei"
    "CinquantaSette" "CinquantOtto" "CinquantaNove" "Sessanta"
    "SessantUno" "SessantaDue" "SessantaTre" "SessantaQuattro" 
    "SessantaCinque" "SessantaSei" "SessantaSette" "SessantOtto"
    "SessantaNove" "Settanta" "SettantUno" "SettantaDue" "SettantaTre"
    "SettantaQuattro" "SettantaCinque" "SettantaSei" "SettantaSette"
    "SettantOtto" "SettantaNove" "Ottanta" "OttantUno" "OttantaDue"
    "OttantaTre" "OttantaQuattro" "OttantaCinque" "OttantaSei" "OttantaSette"
    "OttantOtto" "OttantaNove" "Novanta" "NovantUno" "NovantaDue"
    "NovantaTre" "NovantaQuattro" "NovantaCinque" "NovantaSei"
    "NovantaSette" "NovantOtto" "NovantaNove" "Cento"))

(for (i 0 100)
  (if (= (scrabble (numeri i)) i)
      (println (numeri i) " --> " i)))
;-> Dieci --> 10
;-> QuarantaQuattro --> 44

============================================================================

