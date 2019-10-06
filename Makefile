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
	rm src/Files.elm
	rm src/Items.elm
