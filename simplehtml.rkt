#lang racket
(require 2htdp/batch-io)

; String, String -> String
; creates a string of a html file
(define (make-html heading)
  (local
    ((define page
       `(html ((lang "en"))
              (head
               (meta ((charset "utf-8")))
               (meta ((name "viewport")
                      (content ,(string-append
                                 "width=device-width, "
                                 "initial-scale=1"))))
               (link ((rel "stylesheet")
                      (href "yourcss.css")))
               
               (script ((src "yourjs.js"))))
              (body
               (h1 ,heading))))
     
     (define doctype "<!DOCTYPE html>\n"))
     
    (string-append doctype
                   (xexpr-as-string page))))

; String, Port -> String
; Allows user to enter a string  that represents a Shift field
; Returns a symbol representing said Shift field
(define (user-input prompt)
  (display prompt)
  (local ((define input (read (current-input-port))))
    (cond
     [(symbol? input) (symbol->string input)]
     [(number? input) input]
     [else "user-input: invalid input"])))

; Void -> HTML file
; prompts user for a path/file name and a heading
; to be inserted into a html file
(define (main)
  (local
    ((define path
       (user-input
        (string-append
         "\n#### Enter the file path for the new file ####\n"
         "## Ex: 'index' -> /home/username/index.html\n"
         "## output: [current directory]/[filename].html\n"
         "# Input> ")))
     (define heading
       (user-input
        (string-append
         "#### Enter a title for the h1 element ####\n"
         "# Input> ")))
     (define new-html (make-html heading)))
    
    (write-file (string-append path ".html")
                new-html)))

(main)