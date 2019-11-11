;; menu.lisp
(in-package #:pong)

(defparameter *green* (gamekit:vec4 0 1 0 1))
(defparameter *black* (gamekit:vec4 0 0 0 1))
(defparameter *white* (gamekit:vec4 1 1 1 1))
(defvar *origin* (gamekit:vec2 0 0))
(defparameter *menu-origin* (gamekit:vec2 300 450))
(gamekit:define-font 'raleway "fonts/raleway.ttf")


(defun main-menu-state ()
  (reset-scores)
  (set-initial-balls-and-paddles)
  (draw-main-menu)
  (bind-main-menu-keys))


(defun pause-menu-state ()
  (draw-pause-menu)
  (bind-pause-menu-keys))


(defun game-over-menu-state ()
  (draw-game-over-menu)
  (bind-game-over-menu-keys))


(defun draw-main-menu ()  
  (defmethod gamekit:draw ((app pong-gamekit))
    (gamekit:draw-rect *origin* 800 600 :fill-paint *black*)
    (gamekit:draw-text "Single Player: 0"
		       *menu-origin*
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))
    (gamekit:draw-text "Multiplayer: 1"
		       (gamekit:vec2 300 400)
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))
    (gamekit:draw-text "Exit: q"
		       (gamekit:vec2 300 350)
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))))


(defun draw-pause-menu ()
  (defmethod gamekit:draw ((app pong-gamekit))
    (gamekit:draw-rect *origin* 800 600 :fill-paint *black*)
    (gamekit:draw-text "Resume Game: 0"
		       *menu-origin*
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))
    (gamekit:draw-text "Main Menu: q"
		       (gamekit:vec2 300 400)
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))))


(defun draw-game-over-menu ()
  (defmethod gamekit:draw ((app pong-gamekit))
    (gamekit:draw-rect *origin* 800 600 :fill-paint *black*)
    (draw-player-scores)
    (gamekit:draw-text "Game Over!"
		       (gamekit:vec2 300 500)
		       :fill-color *white*
		       :font (gamekit:make-font 'raleway 32))
    (gamekit:draw-text "Play Again?: y"
		       (gamekit:vec2 300 400)
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))
    (gamekit:draw-text "Main Menu: q"
		       (gamekit:vec2 300 350)
		       :fill-color *green*
		       :font (gamekit:make-font 'raleway 32))))
  


(defun bind-main-menu-keys ()
  (gamekit:bind-button :q :pressed
		       (lambda ()
			 (gamekit:stop)))
  (gamekit:bind-button :1 :pressed
		       (lambda ()
			 (set-and-play-state #'main-game-state)))
  (gamekit:bind-button :keypad-1 :pressed
		       (lambda ()
			 (set-and-play-state #'main-game-state))))


(defun bind-pause-menu-keys ()
  (gamekit:bind-button :q :pressed
		       (lambda ()
			 (set-and-play-state #'main-menu-state)))
  (gamekit:bind-button :0 :pressed
		       (lambda ()
			 (resume-and-play-state)))
  (gamekit:bind-button :keypad-0 :pressed
		       (lambda ()
			 (resume-and-play-state))))


(defun bind-game-over-menu-keys ()
  (gamekit:bind-button :q :pressed
		       (lambda ()
			 (set-and-play-state #'main-menu-state)))
  (gamekit:bind-button :y :pressed
		       (lambda ()
			 (reset-scores)
			 (set-and-play-state #'main-game-state))))


(defun set-initial-balls-and-paddles ()
  (setf *pong-balls* (list (make-instance 'pong-ball
			:position (gamekit:vec2 400 300)
			:color (gamekit:vec4 0 1 0 1)
			:velocity (+ 40 (random 21)))))
  (setf *paddles* (list (make-instance 'pong-paddle
		     :position (gamekit:vec2 10 300)
		     :color (gamekit:vec4 0 0 1 1))
		    (make-instance 'pong-paddle
		     :position (gamekit:vec2 780 300)
		     :color (gamekit:vec4 1 0 0 1)))))


(defun reset-scores ()
  (setf *player-left-score* 0
	*player-right-score* 0))
    
	      
	   
