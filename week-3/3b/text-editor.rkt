;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname text-editor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #t)))
(require 2htdp/image)
(require 2htdp/universe)

;; A simple text editor that allows typing and deleting characters

;; =================
;; Constants:

(define WIDTH 400)
(define HEIGHT 25)

(define TEXT-SIZE 20)
(define TEXT-COLOR "black")

(define CURSOR-COLOR "red")

(define MTS (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 2 TEXT-SIZE "solid" CURSOR-COLOR))


;; =================
;; Data definitions:

;; Editor is String
;; interp. a text editor with text as the current content
(define ED1 "")
(define ED2 "hello world")
#;
(define (fn-for-editor ed)
  (... ed))

;; Template rules used:
;;  - atomic non-distinct: String


;; =================
;; Functions:

;; Editor -> Editor
;; start the world with (main "")
;; 
(define (main ed)
  (big-bang ed                       ; Editor
            (to-draw   render)       ; Editor -> Image
            (on-key    handle-key))) ; Editor KeyEvent -> Editor


;; Editor -> Image
;; render the editor with text and cursor
(check-expect (render "") (overlay/align "left" "middle"
                                         (beside (text "" TEXT-SIZE TEXT-COLOR)
                                                 CURSOR)
                                         MTS))
(check-expect (render "hello world") (overlay/align "left" "middle"
                                                    (beside (text "hello world" TEXT-SIZE TEXT-COLOR)
                                                            CURSOR)
                                                    MTS))

;(define (render Editor) MTS) ;stub

;<use template from Editor>

(define (render ed)
  (overlay/align "left" "middle"
                 (beside (text ed TEXT-SIZE TEXT-COLOR)
                         CURSOR)
                 MTS))


;; Editor KeyEvent -> Editor
;; handle key press events; add characters or delete with backspace
(check-expect (handle-key "" "a") "a")
(check-expect (handle-key "hel" "l") "hell")
(check-expect (handle-key "hello" "\b") "hell")
(check-expect (handle-key "" "\b") "")
(check-expect (handle-key "hi" "left") "hi")

;(define (handle-key ed ke) ed) ;stub

;<use template from KeyEvent>

(define (handle-key ed ke)
  (cond [(key=? ke "\r") ed]
        [(key=? ke "\b") (delete-char ed)]
        [(= (string-length ke) 1) (add-char ed ke)]
        [else ed]))


;; Editor -> Editor
;; delete the latest character from the editor text
(check-expect (delete-char "hello") "hell")
(check-expect (delete-char "a") "")
(check-expect (delete-char "") "")

;(define (delete-char ed) ed) ;stub

;<use template from Editor>

(define (delete-char ed)
  (cond [(= (string-length ed) 0) ""]
        [else (substring ed
                         0
                         (- (string-length ed) 1))]))


;; Editor String -> Editor
;; add a character to the end of the editor text
(check-expect (add-char "" "a") "a")
(check-expect (add-char "hel" "l") "hell")
(check-expect (add-char "hello" " ") "hello ")

;(define (add-char ed c) ed) ;stub

;<use template from Editor>

(define (add-char ed c)
  (string-append ed c))
