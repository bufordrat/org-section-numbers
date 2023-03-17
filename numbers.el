(defun matt-number-headers (&optional beg end)
  "TODO."
  (interactive)
  (save-match-data
    (save-excursion
      (let ((num nil)
	    (n 1)
	    (end
             (set-marker (make-marker)
                         (if (use-region-p)
                             (region-end)
                           (or end (point-max))))))
	(setq beg (if (use-region-p)
                      (region-beginning)
                    (or beg (point-min))))
	(goto-char beg)
	;; TODO use org regexp
	(while (re-search-forward (rx bol (+ "*")) end t)
	  (let ((level (length (match-string 0))))
            (if (< level (length num))
	        (progn
		  (dotimes (_ (- (length num) level))
                    (pop num))
		  (cl-incf (car num)))
	      (if (= level (length num))
                  (cl-incf (car num))
                (push n num))))
	  (insert " " (string-join (reverse (mapcar #'number-to-string num)) ".")))
	num))))
