test-chibi-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/chibi bash -c "cd workdir && chibi-scheme -I ./snow/chibi r7rs-tests.scm"


test-chicken-r7rs-test:
	docker run -it -v ${PWD}:/workdir:z schemers/chicken bash -c "cd workdir &&  ls  && cp snow/chibi/term/ansi.sld snow.chibi.term.ansi.sld && csc -include-path ./snow/chibi -X r7rs -R r7rs -s -J snow.chibi.term.ansi.sld && cp snow/chibi/optional.sld snow.chibi.optional.sld && csc -include-path ./snow/chibi -X r7rs -R r7rs -s -J snow.chibi.optional.sld && cp snow/chibi/diff.sld snow.chibi.diff.sld && csc -include-path ./snow/chibi -X r7rs -R r7rs -s -J snow.chibi.diff.sld && cp snow/chibi/test.sld snow.chibi.test.sld && csc -include-path ./snow/chibi -X r7rs -R r7rs -s -J snow.chibi.test.sld"
	docker run -it -v ${PWD}:/workdir:z schemers/chicken bash -c "cd workdir && csc -include-path ./snow/chibi -X r7rs -R r7rs r7rs-tests.scm && ./r7rs-test && rm r7rs-test"


test-cyclone-r7rs-test:
	docker run -it -v ${PWD}:/workdir:z schemers/cyclone bash -c "cd workdir &&  ls  && cyclone -A . snow/chibi/term/ansi.sld && cyclone -A . snow/chibi/optional.sld && cyclone -A . snow/chibi/diff.sld && cyclone -A . snow/chibi/test.sld"
	docker run -it -v ${PWD}:/workdir:z schemers/cyclone bash -c "cd workdir && cyclone -A . r7rs-tests.scm && ./r7rs-test && rm r7rs-test"


test-gambit-r7rs-test:
	docker run -it -v ${PWD}:/workdir:z schemers/gambit bash -c "cd workdir &&  ls  && gsc . snow/chibi/term/ansi && gsc . snow/chibi/optional && gsc . snow/chibi/diff && gsc . snow/chibi/test"
	docker run -it -v ${PWD}:/workdir:z schemers/gambit bash -c "cd workdir && gsc -exe . -nopreload r7rs-tests.scm && ./r7rs-test && rm r7rs-test"


test-gauche-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/gauche bash -c "cd workdir && gosh -r7 -A ./snow r7rs-tests.scm"


test-guile-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/guile bash -c "cd workdir && guile --fresh-auto-compile --r7rs -L . -L ./snow r7rs-tests.scm"


test-kawa-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/kawa bash -c "cd workdir && kawa --r7rs -Dkawa.import.path=..:../snow:*.sld:./snow/chibi/*.sld:./snow/chibi/term/*.sld r7rs-tests.scm"


test-loko-r7rs-test:
	docker run -it -v ${PWD}:/workdir:z schemers/loko bash -c "cd workdir &&  ls  && ls snow/chibi/term/ansi.sld && ls snow/chibi/optional.sld && ls snow/chibi/diff.sld && ls snow/chibi/test.sld"
	docker run -it -v ${PWD}:/workdir:z schemers/loko bash -c "cd workdir && LOKO_LIBRARY_PATH=./snow loko -std=r7rs --compile r7rs-tests.scm && ./r7rs-test && rm r7rs-test"


test-mit-scheme-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/mit-scheme bash -c "cd workdir && mit-scheme --load r7rs-tests.scm"


test-sagittarius-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/sagittarius bash -c "cd workdir && sash -r7 -L ./snow r7rs-tests.scm > r7rs-test.log && cat r7rs-test.log"


test-stklos-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/stklos bash -c "cd workdir && stklos -I . r7rs-tests.scm"


test-skint-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/skint bash -c "cd workdir && skint --program r7rs-tests.scm"


test-tr7-r7rs-test:
	
	docker run -it -v ${PWD}:/workdir:z schemers/tr7 bash -c "cd workdir && tr7i r7rs-tests.scm"


clean:
	find . -name "*.so" -delete
	find . -name "*.c" -delete
	find . -name "*.o*" -delete
	find . -name "*.so" -delete
	find . -name "*.dep" -delete
	find . -name "*.zo" -delete
	find . -name "*.meta" -delete
	find . -name "compiled" -delete
	find . -name "srfi.*.sld" -delete
	find . -name "srfi.*.scm" -delete
	find . -name "srfi-*.sld" -delete
	find . -name "srfi.*.import.scm" -delete
	find . -name "srfi-*.import.scm" -delete
	find . -name "*.log" -delete
	find . -name "test-prefix.txt" -delete

