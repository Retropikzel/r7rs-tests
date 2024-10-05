(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme process-context)
        (scheme file)
        (arvyy mustache))

(include "util.scm")
(include "implementations.scm")
(include "tests.scm")

(define full-library-command
  (lambda (implementation test)
    (let* ((name (symbol->string (cdr (assoc 'name implementation))))
           (library-command (assoc 'library-command implementation)))
      (cond ((not library-command) #f)
            ; Note that Chicken needs to have the SRFI library as srfi-N.scm in same folder
            ((string=? name "chicken")
             (string-append
               " ls "
               " && cp snow/chibi/term/ansi.sld snow.chibi.term.ansi.sld"
               " && " (cdr library-command) " snow.chibi.term.ansi.sld"
               " && cp snow/chibi/optional.sld snow.chibi.optional.sld"
               " && " (cdr library-command) " snow.chibi.optional.sld"
               " && cp snow/chibi/diff.sld snow.chibi.diff.sld"
               " && " (cdr library-command) " snow.chibi.diff.sld"
               " && cp snow/chibi/test.sld snow.chibi.test.sld"
               " && " (cdr library-command) " snow.chibi.test.sld"
               ))
            (else (string-append
                    " ls "
                    " && " (cdr library-command) " snow/chibi/term/ansi" (if (string=? name "gambit") "" ".sld")
                    " && " (cdr library-command) " snow/chibi/optional" (if (string=? name "gambit") "" ".sld")
                    " && " (cdr library-command) " snow/chibi/diff" (if (string=? name "gambit") "" ".sld")
                    " && " (cdr library-command) " snow/chibi/test" (if (string=? name "gambit") "" ".sld")
                    ))))))

(define full-command
  (lambda (implementation test)
    (let* ((name (symbol->string (cdr (assoc 'name implementation))))
           (test-name (cdr (assoc 'name test)))
           (test-file (cdr (assoc 'file test)))
           (command
             (string-append
               (cdr (assoc 'command implementation)) " " test-file))
           (library-command (assoc 'library-command implementation)))
      (cond
        ((not library-command)
         (string-append command
                        ; Sagittarius does not make .log file for some reason
                        ; Temporary fix to get atleast something out
                        (if (string=? name "sagittarius")
                          (string-append " > " test-name ".log && cat " test-name ".log")
                          "")))
        (else (string-append command
                             " && ./" test-name
                             " && rm " test-name))))))

(define jenkinsfile-top (compile (slurp "templates/Jenkinsfile-top")))
(define jenkinsfile-job-top (compile (slurp "templates/Jenkinsfile-job-top")))
(define jenkinsfile-job (compile (slurp "templates/Jenkinsfile-job")))
(define jenkinsfile-job-bottom (compile (slurp "templates/Jenkinsfile-job-bottom")))
(define jenkinsfile-bottom (compile (slurp "templates/Jenkinsfile-bottom")))

(call-with-output-file
  "Jenkinsfile"
  (lambda (out)
    (execute jenkinsfile-top '() out)
    (newline out)
    (for-each
      (lambda (implementation)
        (let ((name (symbol->string (cdr (assoc 'name implementation)))))
          (execute jenkinsfile-job-top
                   `((name . ,name)
                     (dockerimage . ,(if (assoc 'docker-image implementation)
                                       (cdr (assoc 'docker-image implementation))
                                       (string-append "schemers/" name)))) out)
          (for-each
            (lambda (test)
              (execute jenkinsfile-job
                       `((command . ,(full-command implementation test))
                         (library-command . ,(full-library-command implementation test)))
                       out))
            tests)
          (execute jenkinsfile-job-bottom `((name . ,(cdr (assoc 'name implementation)))) out)
          (newline out)))
      implementations)
    (execute jenkinsfile-bottom '() out)
    (newline out)))

(define makefile-top (compile (slurp "templates/Makefile-top")))
(define makefile-job (compile (slurp "templates/Makefile-job")))
(define makefile-bottom (compile (slurp "templates/Makefile-bottom")))

(call-with-output-file
  "Makefile"
  (lambda (out)
    (execute makefile-top '() out)
    (for-each
      (lambda (test)
          (for-each
            (lambda (implementation)
              (let* ((name (symbol->string (cdr (assoc 'name implementation)))))
                (execute makefile-job
                         `((name . ,name)
                           (test-name . ,(cdr (assoc 'name test)))
                           (command . ,(full-command implementation test))
                           (library-command . ,(full-library-command implementation test)))
                         out))
              (newline out))
            implementations))
      tests)
    (execute makefile-bottom '() out)
    (newline out)))
