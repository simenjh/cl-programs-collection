;;;; pong.lisp

(in-package #:pong)

(defvar *canvas-width* 800)
(defvar *canvas-height* 600)
(defparameter *state-stack* nil)
(defparameter *current-state* nil)
(defparameter *game-ai* nil)
(defparameter *buttons* '(:space :apostrophe :comma :minus :period :slash
  :0 :1 :2 :3 :4 :5 :6 :7 :8 :9
  :semicolon :equal
  :a :b :c :d :e :f :g :h :i :j :k :l :m
  :n :o :p :q :r :s :t :u :v :w :x :y :z
  :left-bracket :backslash :right-bracket
  :grave-accent :world-1 :world-2
  :escape :enter :tab :backspace :insert :delete
  :right :left :down :up
  :page-up :page-down :home :end
  :caps-lock :scroll-lock :num-lock :print-screen :pause
  :f1 :f2 :f3 :f4 :f5 :f6 :f7 :f8 :f9 :f10 :f11 :f12
  :f13 :f14 :f15 :f16 :f17 :f18 :f19 :f20 :f21 :f22 :f23 :f24 :f25
  :keypad-0 :keypad-1 :keypad-2 :keypad-3 :keypad-4
  :keypad-5 :keypad-6 :keypad-7 :keypad-8 :keypad-9
  :keypad-decimal :keypad-divide :keypad-multiply
  :keypad-subtract :keypad-add :keypad-enter :keypad-equal
  :left-shift :left-control :left-alt :left-super
  :right-shift :right-control :right-alt :right-super
  :menu :mouse-left :mouse-right :mouse-middle))


(gamekit:defgame pong-gamekit () ()
  (:viewport-width *canvas-width*)     ; window's width
  (:viewport-height *canvas-height*)   ; window's height
  (:viewport-title "Pong, pong, pong!"))  ; window's title

(gamekit:register-resource-package
 :pong
 (asdf:system-relative-pathname "pong" "assets/"))


(defun start-the-game ()
  (gamekit:start 'pong-gamekit)
  (set-and-play-state #'main-menu-state))


(defun push-state ()
  (push *current-state* *state-stack*))


(defun resume-and-play-state ()
  (unbind-all-keys)
  (setf *current-state* (pop *state-stack*))
  (funcall *current-state*))


(defun set-and-play-state (state)
  (unbind-all-keys)
  (setf *current-state* state)
  (funcall *current-state*))


(defun unbind-all-keys ()
  (dolist (button *buttons*)
    (gamekit:bind-button button :pressed
			 (lambda ()))))
