;; second_hack.lisp
(in-package #:second_hack)

(defvar *black* (gamekit:vec4 0 0 0 1))
(defvar *position* (gamekit:vec2 100 0))

(defvar *up-button-pressed?* nil)
(defvar *down-button-pressed?* nil)

(defmethod gamekit:draw ((app first_hack:new-gamekit))
  (gamekit:draw-rect *position* 20 100 :fill-paint *black*))

(defmethod gamekit:act ((app first_hack:new-gamekit))
  (when *up-button-pressed?*
    (let ((y (gamekit:y *position*)))
      (when (< y 500)
	(setf (gamekit:y *position*) (+ y 5)))))
  (when *down-button-pressed?*
    (let ((y (gamekit:y *position*)))
      (cond ((>= y 5)
	     (setf (gamekit:y *position*) (- y 5)))
	    ((< y 5) (setf (gamekit:y *position*) 0))))))
    
  


(gamekit:start 'first_hack:new-gamekit)


(gamekit:bind-button :up :pressed
		     (lambda () (setf *up-button-pressed?* t)))
(gamekit:bind-button :up :released
		     (lambda () (setf *up-button-pressed?* nil)))



(gamekit:bind-button :down :pressed
		     (lambda () (setf *down-button-pressed?* t)))
(gamekit:bind-button :down :released
		     (lambda () (setf *down-button-pressed?* nil)))
		      
