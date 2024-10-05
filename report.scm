(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme char)
        (scheme process-context)
        (scheme file)
        (srfi 13)
        (arvyy mustache))

(include "util.scm")
(include "implementations.scm")
(include "tests.scm")

(define report-top (compile (slurp "templates/Report-top")))
(define report-row (compile (slurp "templates/Report-row")))
(define report-bottom (compile (slurp "templates/Report-bottom")))

(define logfiles (list-tail (command-line) 1))



(call-with-output-file
  "reports/results.html"
  (lambda (out)
    (execute report-top `() out)
    (display "<tr>" out)
    (newline out)
    (display "<th>Test</th>" out)
    (for-each
      (lambda (implementation)
        (display (string-append "<th>" (symbol->string (cdr (assoc 'name implementation))) "</th>") out)
        (newline out))
      implementations)
    (display "</tr>" out)
    (newline out)
    (newline out)
    (for-each
      (lambda (test)
        (let ((test-name (cdr (assoc 'name test))))
          (display (string-append "<tr>") out)
          (newline out)
          (display (string-append "<td>" test-name "</td>") out)
          (newline out)
          (for-each
            (lambda (implementation)
              (letrec* ((name (cdr (assoc 'name implementation)))
                        (command (cdr (assoc 'command implementation)))
                        (logfile (string-append "reports/"
                                                (symbol->string (cdr (assoc 'name implementation)))
                                                "-"
                                                test-name
                                                ".log"))
                        (read-results (lambda (line results)
                                        (if (eof-object? line)
                                          results
                                          (read-results (read-line)
                                                        (if (string-contains line " out of ")
                                                          (begin
                                                            (append results
                                                                    (list line)))
                                                          results)))))
                        (results
                          (if (file-exists? logfile)
                            (file-tail logfile 3)
                            (list)))
                        (result (apply string-append
                                       (map
                                         (lambda (line)
                                           (string-append line "</br>"))
                                         results))))
                (execute report-row
                         `((name . ,name)
                           (command . ,command)
                           (library-command . ,(if (assoc 'library-command implementation)
                                                 (cdr (assoc 'library-command implementation))
                                                 #f))
                           (name . ,name)
                           (result . ,result))
                         out)
                (newline out)))
            implementations)
          (display (string-append "</tr>") out)))
      tests)
    (execute report-bottom '() out)
    (newline out)))
