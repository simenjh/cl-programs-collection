(defun count-words-in-string (string)
  (let ((string-length (length string))
	(space-index (position #\Space string)))
    (cond ((= string-length 0) 0)
	  ((and (not space-index)
		(> string-length 0))
	   1)
	  ((and space-index
		(= space-index 0))
	   (error "Word not allowed to start with #\Space"))
	  ((= (1+ space-index) string-length)
	   (error "Word not allowed to end with #\Space"))
	  (t
	   (1+ (count-words-in-string (subseq string (1+ space-index))))))))

	  
	  
	  
	
	          
