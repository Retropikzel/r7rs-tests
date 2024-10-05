(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme char)
        (scheme process-context)
        (scheme file)
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
        (let ((test-name (cdr (assoc 'name test)))
              (name (symbol->string (cdr (assoc 'name implementation)))))
          (display (string-append "<tr>") out)
          (newline out)
          (display (string-append "<td>" test-name "</td>") out)
          (newline out)
          (for-each
            (lambda (implementation)
              (letrec* ((name (cdr (assoc 'name implementation)))
                        (command (cdr (assoc 'command implementation)))
                        (logfile (string-append "reports/"
                                                name
                                                "-"
                                                test-name
                                                ".log"))
                        (read-results (lambda (line results)
                                        (if (eof-object? line)
                                          results
                                          (read-results (read-line)
                                                        (if (string-starts-with? line "# of")
                                                          (begin
                                                            (append results
                                                                    (list (number-of-line->number line))))
                                                          results)))))
                        (results (if (not (file-exists? logfile))
                                   (list "" "" "" "")
                                   (with-input-from-file
                                     logfile
                                     (lambda ()
                                       (read-results (read-line) (list))))))
                        (expected-passes (if (> (length results) 0) (list-ref results 0) 0))
                        (expected-failures (if (> (length results) 1) (list-ref results 1) 0))
                        (unexpected-failures (if (> (length results) 2) (list-ref results 2) 0))
                        (skipped-tests (if (> (length results) 3) (list-ref results 3) 0))
                        (color (cond ((string? expected-passes) "white") ; No logfile
                                     ((> unexpected-failures 0) "red")
                                     ((> skipped-tests 0) "yellow")
                                     (else "green"))))
                (execute report-row
                         `((name . ,name)
                           (command . ,command)
                           (color . ,color)
                           (library-command . ,(if (assoc 'library-command implementation)
                                                 (cdr (assoc 'library-command implementation))
                                                 #f))
                           (name . ,name)
                           (expected-passes . ,expected-passes)
                           (expected-failures . ,expected-failures)
                           (unexpected-failures . ,unexpected-failures)
                           (skipped-tests . ,skipped-tests))
                         out)
                (newline out)))
            implementations)
          (display (string-append "</tr>") out)))
      tests)
    (execute report-bottom '() out)
    (newline out)))
