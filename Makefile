generate: src/Items.elm src/Translations/English.elm src/Translations/Estonian.elm

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
	rm -rf src/Translations
	rm src/Items.elm

js = elm.js
min = main.js

.PHONY: build
build:
	make clean
	make generate
	set -e
	elm make --optimize --output=$(js) src/Main.elm
	npx terser $(js) --compress 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe' | npx terser --mangle --output=$(min)
	echo "Compiled size: $$(cat $(js) | wc -c) bytes"
	echo "Minified size: $$(cat $(min) | wc -c) bytes ($min)"
	echo "Gzipped size:  $$(cat $(min) | gzip -c | wc -c) bytes"
	rm $(js)

