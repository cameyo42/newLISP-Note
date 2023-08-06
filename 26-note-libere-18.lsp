================

 NOTE LIBERE 18

================

------------------------------------------
Tavola Periodica degli Elementi (ricerche)
------------------------------------------

Nella cartella "data" si trova il file "periodic-table.csv" che contiene dati sulla Tavola Periodica degli Elementi (in formato Comma Separated Value).

Per caricare il file in una lista:

(setq table '())
(setq file (open "periodic-table.csv" "read"))
(while (read-line file) (push (parse (current-line) ",") table -1))
(close file)

Adesso i dati si trovano nella lista "table" e il nomi dei campi si trovano nel primo elemento della lista:

(table 0)
;-> ("Atomic_Number" "Element" "Nome" "Symbol" "Atomic_Weight" "Period" 
;->  "Group" "Phase" "Type" "Ionic_Radius" "Atomic_Radius" "Electronegativity" 
;->  "First_Ionization_Potential" "Density" "Melting_Point(K)" 
;->  "Boiling_Point(K)" "Isotopes" "Year_Discovery" "Specific_Heat_Capacity"
;->  "Display_Row" "Display_Column")

Numero dei campi:

(length (table 0))
;-> 21

Vediamo come possiamo fare delle ricerche in questa lista.
Utilizziamo la seguente lista (parziale) per fare le ricerche:

(setq data '(
    ("Nome" "Symbol" "Atomic_Weight" "Period" "Group" "Phase" "Type")
    ("Idrogeno" "H" "1.00794" "1" "1" "gas" "Nonmetal")
    ("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
    ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")
    ("Berillio" "Be" "9.012182" "2" "2" "solid" "Alkaline Earth Metal")
    ("Boro" "B" "10.811" "2" "13" "solid" "Metalloid")
    ("Carbonio" "C" "12.0107" "2" "14" "solid" "Nonmetal")
    ("Azoto" "N" "14.0067" "2" "15" "gas" "Nonmetal")
    ("Ossigeno" "O" "15.9994" "2" "16" "gas" "Nonmetal")
    ("Fluoro" "F" "18.9984032" "2" "17" "gas" "Halogen")
    ("Neon" "Ne" "20.1797" "2" "18" "gas" "Noble Gas")
    ("Sodio" "Na" "22.98976928" "3" "1" "solid" "Alkali Metal")
    ("Magnesio" "Mg" "24.305" "3" "2" "solid" "Alkaline Earth Metal")
    ("Alluminio" "Al" "26.9815386" "3" "13" "solid" "Metal")
    ("Silicio" "Si" "28.0855" "3" "14" "solid" "Metalloid")
    ("Fosforo" "P" "30.973762" "3" "15" "solid" "Nonmetal")
    ("Zolfo" "S" "32.065" "3" "16" "solid" "Nonmetal")
    ("Cloro" "Cl" "35.453" "3" "17" "gas" "Halogen")
    ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas")
    ("Potassio" "K" "39.0983" "4" "1" "solid" "Alkali Metal")
    ("Calcio" "Ca" "40.078" "4" "2" "solid" "Alkaline Earth Metal")
    ("Scandio" "Sc" "44.955912" "4" "3" "solid" "Transition Metal")))

Esempi:

(find '("Litio" *) data match)
;-> 3
$0
;-> ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")

(find-all '(* "Calcio" *) data)
;-> (("Calcio" "Ca" "40.078" "4" "2" "solid" "Alkaline Earth Metal"))

(find-all '(* "F" *) data)
;-> (("Fluoro" "F" "18.9984032" "2" "17" "gas" "Halogen"))

(find-all '(* "Noble Gas" *) data)
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

(lookup "Litio" data)
;-> "Alkali Metal"

(assoc "Litio" data)
;-> ("Litio" "Li" "6.941" "2" "1" "solid" "Alkali Metal")

(setq column (find "Type" (data 0)))
(setq out '())
(for (i 1 (- (length data) 1))
  (if (= (data i column) "Nonmetal")
      (push (data i) out -1)))
out
;-> (("Idrogeno" "H" "1.00794" "1" "1" "gas" "Nonmetal")
;->  ("Carbonio" "C" "12.0107" "2" "14" "solid" "Nonmetal")
;->  ("Azoto" "N" "14.0067" "2" "15" "gas" "Nonmetal")
;->  ("Ossigeno" "O" "15.9994" "2" "16" "gas" "Nonmetal")
;->  ("Fosforo" "P" "30.973762" "3" "15" "solid" "Nonmetal")
;->  ("Zolfo" "S" "32.065" "3" "16" "solid" "Nonmetal"))

(ref-all "solid" data)
;-> ((3 5) (4 5) (5 5) (6 5) (11 5) (12 5) (13 5) (14 5) (15 5) (16 5) (19 5) (20 5)
;->  (21 5))

(ref-all "Noble Gas" data)
;-> ((2 6) (10 6) (18 6))

(select data '(2 10 18))
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

(select data (map first (ref-all "Noble Gas" data)))
;-> (("Elio" "He" "4.002602" "1" "18" "gas" "Noble Gas")
;->  ("Neon" "Ne" "20.1797" "2" "18"  "gas" "Noble Gas")
;->  ("Argon" "Ar" "39.948" "3" "18" "gas" "Noble Gas"))

Continua...

=============================================================================

