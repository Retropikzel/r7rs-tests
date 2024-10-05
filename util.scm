
(define slurp-loop
  (lambda (line result)
    (if (eof-object? line)
      result
      (slurp-loop (read-line) (string-append result line (string #\newline))))))

(define slurp
  (lambda (path)
    (with-input-from-file
      path
      (lambda ()
        (slurp-loop (read-line) "")))))

(define string-starts-with?
  (lambda (str prefix)
    (and (>= (string-length str) (string-length prefix))
         (string=? (string-copy str 0 (string-length prefix)) prefix))))

(define file-tail
  (lambda (path linecount)
    (with-input-from-file
      path
      (lambda ()
        (letrec
          ((looper
             (lambda (line count lines)
               (if (eof-object? line)
                 (list-tail lines (- (length lines) linecount))
                 (looper (read-line) (+ count 1) (append lines (list line)))))))
          (looper (read-line) 0 (list)))))))


(define number-of-line->number
  (lambda (str)
    (letrec
      ((looper
         (lambda (chars result)
           (if (and (not (null? chars))
                    (char-whitespace? (car chars)))
             (begin
               (string->number result))
             (looper (cdr chars) (string-append (string (car chars)) result ))))))
      (looper (reverse (string->list str)) ""))))
