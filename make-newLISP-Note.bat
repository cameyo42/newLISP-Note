REM Batch file to make "newLISP-Note.lsp" and "newLISP-Extra.lsp"
REM make newLISP-Note.lsp
del "newLISP-Note.lsp" > nul
del "newLISP-Extra.lsp" > nul
type *.lsp > newLISP-Note
rename "newLISP-Note" "newLISP-Note.lsp"
REM make newLISP-Extra.lsp
type *.lisp > newLISP-Extra
rename "newLISP-Extra" "newLISP-Extra.lsp"