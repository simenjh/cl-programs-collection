;; game_objects.lisp

(in-package #:pong)



(defclass moving-object ()
  ((position :accessor object-position
	     :initarg :position)
   (color :accessor object-color
	  :initarg :color)))


(defmethod set-object-position ((obj moving-object) width height)
  (setf (object-position obj) (gamekit:vec2 width height)))


(defclass pong-ball (moving-object)
  ((radius :accessor ball-radius
	   :initarg :radius
	   :initform 5)
   (velocity :accessor ball-velocity
	     :initarg :velocity)
   (angle :accessor ball-angle
	  :initarg :angle
	  :initform (* (/ pi 180) (svref (vector -10 -30 -150 -170 0 10 30 150 170) (random 9))))))


(defclass pong-paddle (moving-object)
  ((width :accessor paddle-width
	  :initarg :width
	  :initform 10)
   (height :accessor paddle-height
	   :initarg :height
	   :initform 60)
   (velocity :accessor paddle-velocity
	     :initarg :velocity
	     :initform 5)))


(defmethod set-random-ball-velocity ((ball pong-ball))
  (setf (ball-velocity ball) (+ 40 (random 61))))


	     
