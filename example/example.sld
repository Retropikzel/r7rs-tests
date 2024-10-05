(define-library (example)
  (import (scheme base))
  (cond-expand

   (chibi
    (import (except (chibi test) test-equal)))

   (gambit
    (import (rename (_test)
                    (test-equal test))))

   (gauche
    (import (rename (srfi 64)
                    (test-equal test)))))

  (include "example.scm"))
