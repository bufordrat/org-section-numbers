(defun matt-number-headers (&optional beg end)
  "TODO."
  (save-match-data
    (save-excursion
      (let ((num nil)
	    (n 1)
	    (end (set-marker (make-marker) (or end (point-max)))))
	(setq beg (or beg (point-min)))
	(goto-char beg)
	;; TODO use org regexp
	(while (re-search-forward (rx bol (+ "*")) end t)
	  (if (< (length (match-string 0)) (length num))
	      (progn
		(pop num)
		(cl-incf (car num)))
	    (push n num))
	  (insert " " (string-join (reverse (mapcar #'number-to-string num)) ".")))
	num))))
