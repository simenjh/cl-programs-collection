;;;; pong.asd

(asdf:defsystem #:pong
  :description "Describe pong here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on ()
  :components ((:file "package")
	       (:file "pong")
	       (:file "game_objects")
	       (:file "fun_playing")
	       (:file "menu")))


