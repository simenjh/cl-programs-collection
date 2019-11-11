(defpackage "HANGMAN"
  (:use "COMMON-LISP")
  (:export "PLAY"))

(in-package hangman)
  

(defparameter *words* (vector "luring"))
(defparameter *word* nil)
(defparameter *word-progress* nil)
(defparameter *past-guesses* nil)
(defparameter *game-finished* nil)
(defparameter *hangman-state* nil)
(defparameter *current-states* nil)

(defparameter *hangman-states* (list
"    
     ----------
      |     
      |     
      |     
      |     
      |    
      |
      |
______________`"

"    
     ----------
      |     |
      |     
      |     
      |     
      |    
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |     
      |     
      |    
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |     | 
      |     |
      |    
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |     | 
      |     |
      |    / 
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |     |
      |     |
      |    / \\
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |    /|
      |     |
      |    / \\
      |
      |
______________`"

"    
     ----------
      |     |
      |     @
      |    /|\\  You lose
      |     |
      |    / \\
      |
      |
______________`
"))

				

(defun play ()
  (labels ((game-loop ()
	     (print-hangman-state)
	     (if *game-finished*
		 (when (prompt-try-again)
		   (reset-game)
		   (game-loop))
		 (progn
		   (update-game-state (prompt-guess))
		   (game-loop)))))
    (reset-game)
    (game-loop)))	     


(defun prompt-guess ()
  (format t "~%Guess this: ~A" *word-progress*)
  (format t "~%Past guesses: ~A" *past-guesses*)
  (format t "~%Enter guess: ")
  (let ((input (read-line)))
    (if (= (length input) 1)
	(let ((guess (character input)))
	  (cond ((position guess *past-guesses*)
		 (format t "~%Please choose a new guess.")
		 (prompt-guess))
		(t (push guess *past-guesses*)
		   guess)))
	(progn (format t "~%Invalid input. Please try again")
	       (prompt-guess)))))


(defun update-game-state (guess)
  (if (find guess *word*)
      (progn (dotimes (i (length *word*))
	       (when (eq (char *word* i) guess)
		 (setf (char *word-progress* i) guess)))
	     (when (string= *word* *word-progress*)
	       (format t "~%~%Congratulations! You have won!")
	       (format t "~%The word was ~A" *word*)
	       (setf *game-finished* t)))
      (update-hangman-state)))


(defun print-hangman-state ()
  (format t "~A~%" *hangman-state*))


(defun update-hangman-state ()
  (setf *hangman-state* (cadr (member *hangman-state* *hangman-states*)))
  (cond ((null (cdr (member *hangman-state* *hangman-states*)))
	 (format t "~%~%You lost!")
	 (format t "~%The word was: ~A" *word*)
	 (setf *game-finished* t))
	(t (setf *current-states* (cdr *current-states*)))))


(defun prompt-try-again ()
  (format t "~%Do you want to play again? (y/n): ")
  (let ((answer (read-line)))
    (when (= (length answer) 1)
      (cond ((eql (character answer) #\y) (return-from prompt-try-again t))
	    ((eql (character answer) #\n) (return-from prompt-try-again nil))))
    (format t "~%Please answer (y/n)")
    (prompt-try-again)))


(defun reset-game ()
  (format t "~%~%~%~%~%")
  (setf *word* (svref *words* (random (length *words*)))
	*current-states* (copy-list (cdr *hangman-states*))
	*word-progress* (make-array (length *word*)
				    :initial-element #\_
				    :element-type 'character)
	*past-guesses* nil
	*game-finished* nil
	*hangman-state* (car *hangman-states*)
	*current-states* nil))



	       
	   
      
      
  

  
