(define-library (example)
  (import (scheme base))
  (cond-expand

   (chibi
    (import (rename (except (chibi test) test-equal)
                    (test test-equal))))

   (gambit
    (import (_test)))

   (gauche
    (import (srfi 64))))

  (include "example.scm"))
