
(define implementations
  '(((name . chibi) (command . "chibi-scheme -I ./snow"))
    ((name . chicken)
     (command . "csc -include-path ./snow/chibi -X r7rs -R r7rs")
     (library-command . "csc -include-path ./snow/chibi -X r7rs -R r7rs -s -J"))
    ((name . cyclone)
     (command . "cyclone -A .")
     (library-command . "cyclone -A ."))
    ((name . gambit)
     (command . "gsc -exe . -nopreload")
     (library-command . "gsc ."))
    ((name . gauche) (command . "gosh -r7 -A ./snow"))
    ((name . guile) (command . "guile --fresh-auto-compile --r7rs -L . -L ./snow"))
    ((name . kawa) (command . "kawa --r7rs -Dkawa.import.path=..:../snow:*.sld:./snow/chibi/*.sld:./snow/chibi/term/*.sld"))
    ((name . loko)
     (docker-image . "schemers/loko:head")
     (command . "LOKO_LIBRARY_PATH=./snow loko -std=r7rs --compile")
     ; Library command so the executable gets run
     (library-command . "ls"))
    ((name . mit-scheme) (command . "mit-scheme --load"))
    ((name . sagittarius) (command . "sash -r7 -L ./snow"))
    ((name . stklos) (command . "stklos -I ."))
    ((name . skint) (command . "skint --program"))
    ((name . tr7) (command . "tr7i"))))
