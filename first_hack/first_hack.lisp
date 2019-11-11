;;;; first_hack.lisp

(in-package #:first_hack)

(defvar *canvas-width* 800)
(defvar *canvas-height* 600)

(defvar *pressed-left-mouse-button?* nil)
(defvar *pressed-right-mouse-button?* nil)

(gamekit:defgame new-gamekit () ()
  (:viewport-width *canvas-width*)     ; window's width
  (:viewport-height *canvas-height*)   ; window's height
  (:viewport-title "Hello Gamekit!"))  ; window's title

(gamekit:register-resource-package :keyword "/home/simen/programming/lisp/common_lisp/programming_for_noobz/first_hack/assets/")

(gamekit:define-image :snake-head "snake-head.png")
  
(defvar *black* (gamekit:vec4 0 0 0 1))


;; (defun real-time-seconds ()
;;   "Return seconds since certain point of time"
;;   (/ (get-internal-real-time) internal-time-units-per-second))


;; (defvar *curve* (make-array 4 :initial-contents (list (gamekit:vec2 300 300)
;;                                                       (gamekit:vec2 375 300)
;;                                                       (gamekit:vec2 425 300)
;;                                                       (gamekit:vec2 500 300))))



;; (defun update-position (position time)
;;   (let* ((subsecond (nth-value 1 (truncate time)))
;;          (angle (* 2 pi subsecond)))
;;     (setf (gamekit:y position) (+ 300 (* 100 (sin angle))))))


;; (defun update-snake-endpoint (position x y)
;;   (setf (gamekit:x position) x)
;;   (setf (gamekit:y position) y))
  
  


;; (defmethod gamekit:act ((app new-gamekit))
;;   (update-position (aref *curve* 1) (real-time-seconds))
;;   (update-position (aref *curve* 2) (+ 0.3 (real-time-seconds))))


;; (defmethod gamekit:draw ((app new-gamekit))
;;   (gamekit:print-text "A snake that is!" 300 400)
;;   (gamekit:draw-curve (aref *curve* 0)
;;                       (aref *curve* 3)
;;                       (aref *curve* 1)
;;                       (aref *curve* 2)
;;                       *black*
;;                       :thickness 5.0)
;;   ;; let's center image position properly first
;;   (let ((head-image-position (gamekit:subt (aref *curve* 3) (gamekit:vec2 32 32))))
;;     ;; then draw it where it belongs
;;     (gamekit:draw-image head-image-position :snake-head)))


;; ;; Start game engine
;; (gamekit:start 'new-gamekit)


;; (gamekit:bind-button :mouse-left :pressed
;; 		     (lambda () (setf *pressed-left-mouse-button?* t)))
;; (gamekit:bind-button :mouse-left :released
;; 		     (lambda () (setf *pressed-left-mouse-button?* nil)))

;; (gamekit:bind-button :mouse-right :pressed
;; 		     (lambda () (setf *pressed-right-mouse-button?* t)))
;; (gamekit:bind-button :mouse-right :released
;; 		     (lambda () (setf *pressed-right-mouse-button?* nil)))


;; (gamekit:bind-cursor (lambda (x y)
;; 		       (when *pressed-left-mouse-button?*
		       ;; 	 (update-snake-endpoint (aref *curve* 0) x y))
		       ;; (when *pressed-right-mouse-button?*
		       ;; 	 (update-snake-endpoint (aref *curve* 3) x y))))
