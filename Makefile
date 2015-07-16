all: copy-libs elm.js

SRCS=$(addprefix app/,App.elm Router.elm pages/About.elm pages/Home.elm Native/Router.js)

elm.js: $(SRCS)
	elm make app/App.elm

copy-libs: bower_components vendor vendor/router.min.js vendor/rsvp.min.js vendor/route-recognizer.js

vendor:
	mkdir vendor

bower_components:
	bower install

vendor/router.min.js:
	wget https://raw.githubusercontent.com/tildeio/router.js/master/dist/router.min.js -q -O vendor/router.min.js

vendor/rsvp.min.js: bower_components/rsvp/rsvp.min.js
	cp $< $@

vendor/route-recognizer.js: bower_components/route-recognizer/dist/route-recognizer.js
	cp $< $@


clean:
	rm -rf elm.js

dist-clean: clean
	rm -rf vendor

.PHONY: all copy-libs clean dist-clean
