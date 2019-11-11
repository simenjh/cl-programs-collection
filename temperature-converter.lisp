(defun fahrenheit->celsius (fahr)
  (let ((celsius (* (- fahr 32) 5/9)))
    (format t "~A fahrenheit is ~A celsius~%" fahr celsius)))

(defun celsius->fahrenheit (celsius)
  (let ((fahr (+ (* celsius 9/5) 32)))
    (format t "~A celsius is ~A fahrenheit~%" celsius fahr)))
  
