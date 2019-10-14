generate: src/Items.elm src/Translations/English.elm src/Translations/Estonian.elm optimizeimages


src/Items.elm: scripts/itemJsonFilesAsElmModule.js $(shell find static/items)
	node scripts/itemJsonFilesAsElmModule.js static/items > src/Items.elm


src/Translations/English.elm: scripts/translationsAsElmModule.js $(shell find static/english.json)
	mkdir -p src/Translations
	node scripts/translationsAsElmModule.js static/english.json > src/Translations/English.elm


src/Translations/Estonian.elm: scripts/translationsAsElmModule.js $(shell find static/estonian.json)
	mkdir -p src/Translations
	node scripts/translationsAsElmModule.js static/estonian.json > src/Translations/Estonian.elm


.PHONY: clean
clean:
	rm -rf build || true
	rm -rf src/Translations || true
	rm src/Items.elm || true
	rm -rf static/uploads_minimal || true
	rm -rf static/uploads_optimized || true


js = build/elm.js
min = build/main.js

.PHONY: build
build:
	# SETUP
	make clean
	make generate
	mkdir -p build
	# COMPILE ELM
	set -e
	elm make --optimize --output=$(js) src/Main.elm
	npx terser $(js) --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | npx terser --mangle --output=$(min)
	echo "Compiled size: $$(cat $(js) | wc -c) bytes"
	echo "Minified size: $$(cat $(min) | wc -c) bytes ($min)"
	echo "Gzipped size:  $$(cat $(min) | gzip -c | wc -c) bytes"
	rm $(js)
	# COPY FILES
	cp index.html build/index.html
	cp favicon.ico build/favicon.ico
	cp manifest.json build/manifest.json
	mkdir -p build/static/images
	cp -r static/images/ build/static/images/
	cp -r static/uploads/ build/static/uploads/


.PHONY: optimizeimages
optimizeimages:
	mkdir -p static/images
	cd static/uploads/;\
	pwd;\
	convert * -strip -interlace Plane -resize 800x800 -sampling-factor 4:2:0 -quality 85 -set filename:x %t "../images/%[filename:x].jpg"




