;; fun_playing.lisp

(in-package #:pong)

(defparameter *pong-balls* nil)
(defparameter *paddles* nil)

(defparameter *up-button-pressed?* nil)
(defparameter *down-button-pressed?* nil)
(defvar *w-button-pressed?* nil)
(defvar *s-button-pressed?* nil)

(defparameter *player-left-score* 0)
(defparameter *player-right-score* 0)

(defparameter *max-score* 5)


(defun main-game-state ()
  (draw-scene)
  (bind-main-game-keys)
  (update-internal-state))


(defun draw-scene()
  (defmethod gamekit:draw ((app pong-gamekit))
    (draw-background)
    (draw-paddles)
    (draw-balls)
    (draw-player-scores)))


(defun draw-paddles ()
  (dolist (paddle *paddles*)
    (gamekit:draw-rect
     (object-position paddle)
     (paddle-width paddle)
     (paddle-height paddle)
     :fill-paint (object-color paddle))))


(defun draw-balls ()
  (dolist (ball *pong-balls*)
    (gamekit:draw-circle
     (object-position ball)
     (ball-radius ball)
     :fill-paint (object-color ball))))


(defun draw-background ()
  (gamekit:draw-rect *origin*
		     800
		     600
		     :fill-paint *black*))


(defun draw-player-scores ()
  (gamekit:draw-text (format nil "~A" *player-left-score*)
		     (gamekit:vec2 300 550)
		     :fill-color *white*
		     :font (gamekit:make-font 'raleway 70))
  (gamekit:draw-text (format nil "~A" *player-right-score*)
		     (gamekit:vec2 450 550)
		     :fill-color *white*
		     :font (gamekit:make-font 'raleway 70)))


(defun update-internal-state ()
  (defmethod gamekit:act ((app pong-gamekit))
    (update-position-of-balls)
    (update-paddle-positions)
    (balls-hit-paddles)
    (update-scores)
    (update-angles)))


(defun update-position-of-balls ()  
  (dolist (ball *pong-balls*)
    (let* ((position (object-position ball))
	   (x (gamekit:x position))
	   (y (gamekit:y position))
	   (angle (ball-angle ball))
	   (velocity (ball-velocity ball)))
      (setf (object-position ball)
	    (gamekit:vec2 (+ x (* 0.1 velocity (cos angle)))
			  (+ y (* 0.1 velocity (sin angle))))))))


(defun update-angles ()
  (dolist (ball *pong-balls*)
    (let* ((position (object-position ball))
	   (y (gamekit:y position))
	   (angle (ball-angle ball))
	   (radius (ball-radius ball)))
      (when (or (<= y radius)
      		(>= y (- *canvas-height* radius)))
	(setf (ball-angle ball) (- angle))))))


(defun bind-main-game-keys ()
  (gamekit:bind-button :escape :pressed
		       (lambda ()
			 (defmethod gamekit:act ((app pong-gamekit)))
			 (push-state)
			 (set-and-play-state #'pause-menu-state)))
  (gamekit:bind-button :up :pressed
		       (lambda () (setf *up-button-pressed?* t)))
  (gamekit:bind-button :up :released
		       (lambda () (setf *up-button-pressed?* nil)))
  (gamekit:bind-button :down :pressed
		       (lambda () (setf *down-button-pressed?* t)))
  (gamekit:bind-button :down :released
		       (lambda () (setf *down-button-pressed?* nil)))
  (gamekit:bind-button :w :pressed
		       (lambda () (setf *w-button-pressed?* t)))
  (gamekit:bind-button :w :released
		       (lambda () (setf *w-button-pressed?* nil)))
  (gamekit:bind-button :s :pressed
		       (lambda () (setf *s-button-pressed?* t)))
  (gamekit:bind-button :s :released
		       (lambda () (setf *s-button-pressed?* nil))))


(defun update-paddle-positions ()
  (let ((left-paddle (first *paddles*))
	(right-paddle (second *paddles*)))
    (when *up-button-pressed?*
      (let ((y (gamekit:y (object-position right-paddle))))
	(when (< y (- *canvas-height* (paddle-height right-paddle)))
	  (setf (gamekit:y (object-position right-paddle)) (+ y (paddle-velocity right-paddle))))))
    (when *down-button-pressed?*
      (let ((y (gamekit:y (object-position right-paddle))))
	(cond ((>= y (paddle-velocity right-paddle))
	       (setf (gamekit:y (object-position right-paddle)) (- y (paddle-velocity right-paddle))))
	      ((< y (paddle-velocity right-paddle))
	       (gamekit:y (object-position right-paddle)) 0))))
    (when *w-button-pressed?*
      (let ((y (gamekit:y (object-position left-paddle))))
	(when (< y (- *canvas-height* (paddle-height left-paddle)))
	  (setf (gamekit:y (object-position left-paddle)) (+ y (paddle-velocity left-paddle))))))
    (when *s-button-pressed?*
      (let ((y (gamekit:y (object-position left-paddle))))
	(cond ((>= y (paddle-velocity left-paddle))
	       (setf (gamekit:y (object-position left-paddle)) (- y (paddle-velocity left-paddle))))
	      ((< y (paddle-velocity right-paddle))
	       (gamekit:y (object-position left-paddle)) 0))))))


(defun balls-hit-paddles ()
  (dolist (ball *pong-balls*)
    (let* ((position (object-position ball))
	   (x (gamekit:x position))
	   (y (gamekit:y position))
	   (angle (ball-angle ball))
	   (radius (ball-radius ball))
	   (left-paddle (first *paddles*))
	   (right-paddle (second *paddles*)))
      (cond ((ball-hits-left-paddle? ball x y angle radius left-paddle)
	     (change-angle-ball-hits-left-paddle ball angle)
	     (set-random-ball-velocity ball))
	    ((ball-hits-right-paddle? ball x y angle radius right-paddle)
	     (change-angle-ball-hits-right-paddle ball angle)
	     (set-random-ball-velocity ball))))))


(defun ball-hits-left-paddle? (ball x y angle radius left-paddle)
  (and (>= x (+ (gamekit:x (object-position left-paddle))
		(paddle-width left-paddle)))
       (<= x (+ (gamekit:x (object-position left-paddle))
		(paddle-width left-paddle)
		(* 2 radius)))
       (and (>= y (gamekit:y (object-position left-paddle)))
	    (<= y (+ (gamekit:y (object-position left-paddle))
		     (paddle-height left-paddle))))))


(defun ball-hits-right-paddle? (ball x y angle radius right-paddle)
  (and (>= x (- (gamekit:x (object-position right-paddle))
		radius))
       (<= x (- (gamekit:x (object-position right-paddle))
		(- radius)))
       (and (>= y (gamekit:y (object-position right-paddle)))
	    (<= y (+ (gamekit:y (object-position right-paddle))
		     (paddle-height right-paddle))))))


(defun change-angle-ball-hits-left-paddle (ball angle)
  (let ((random-angle (* (/ pi 180)
			 (+ 120 (random 61)))))
    (set-ball-angle ball angle random-angle)))
   

(defun change-angle-ball-hits-right-paddle (ball angle)
  (let ((random-angle (* (/ pi 180)
			 (random 61))))
    (set-ball-angle ball angle random-angle)))


(defun set-ball-angle (ball old-angle new-angle)
  (if (>= old-angle 0)
      (setf (ball-angle ball) (- pi new-angle))
      (setf (ball-angle ball) (- (- pi)
				 (- new-angle)))))


(defun update-scores ()
  (update-player-scores)
  (game-over))


(defun update-player-scores ()
  (dolist (ball *pong-balls*)
    (when (<= (gamekit:x (object-position ball)) 0)
      (incf *player-right-score*)
      (set-initial-balls-and-paddles))
    (when (>= (gamekit:x (object-position ball)) *canvas-width*)
      (incf *player-left-score*)
      (set-initial-balls-and-paddles))))


(defun game-over ()
  (when (or (= *player-left-score* *max-score*)
	    (= *player-right-score* *max-score*))
    (defmethod gamekit:act ((app pong-gamekit)))
    (set-and-play-state #'game-over-menu-state)))


