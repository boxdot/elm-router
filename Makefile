all: copy-libs elm.js

elm.js: app/App.elm app/Router.elm
	elm make app/App.elm

.PHONY: all copy-libs clean
copy-libs: bower_components vendor vendor/router.js vendor/rsvp.min.js vendor/route-recognizer.js

vendor:
	mkdir vendor

bower_components:
	bower install

vendor/router.js: bower_components/router.js/dist/router.min.js
	cp $< $@

vendor/rsvp.min.js: bower_components/rsvp/rsvp.min.js
	cp $< $@

vendor/route-recognizer.js: bower_components/route-recognizer/dist/route-recognizer.js
	cp $< $@


clean:
	rm -r vendor elm.js